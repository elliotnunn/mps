package main

import (
	"fmt"
)

const maxBlock = 64 * 1024 * 1024

var bump uint32 = kHeap
var memFree uint32 = uint32(len(mem)) - kHeap
var usedBlocks = make(map[uint32]*block)   // map[addr]*block
var freeBlocks = make(map[uint32][]uint32) // map[size][]addr

const (
	masterPtrBlock = 1
	pointerBlock   = 2
	handleBlock    = 3
)

type block struct {
	masterPtr uint32
	total     uint32
	size      uint32
	original  uint32
	max       uint32
	kind      int8
}

func logbCeil(n uint32) int {
	for i := 0; i < 32; i++ {
		if uint32(1)<<i >= n {
			return i
		}
	}
	panic("too damn big")
}

func newBlock(size uint32, expandable bool) uint32 {
	log := logbCeil(size)

	block := block{
		total:    1 << (log + 1),
		max:      1 << log,
		size:     size,
		original: size,
	}

	if expandable && block.max < maxBlock {
		block.total <<= 1
		block.max <<= 1
	}

	var addr uint32
	freeCnt := len(freeBlocks[block.total])
	if freeCnt > 0 {
		addr = freeBlocks[block.total][freeCnt-1]
		freeBlocks[block.total] = freeBlocks[block.total][:freeCnt-1]
	} else {
		addr = bump
		bump += block.total
		if bump > uint32(len(mem)) {
			panic("out of memory")
		}
	}

	// Zero-init
	for i := uint32(0); i < block.total; i++ {
		writeb(addr+i, 0)
	}

	usedBlocks[addr] = &block
	memFree -= block.total

	return addr
}

func freeBlock(addr uint32) {
	block, ok := usedBlocks[addr]
	if !ok {
		panic(fmt.Sprintf("double free %08x", addr))
	}
	delete(usedBlocks, addr)
	memFree += block.total

	freeBlocks[block.total] = append(freeBlocks[block.total], addr)
}

func verifyHandle(hand uint32) (ptr uint32) {
	mpBlock, ok := usedBlocks[hand]
	if !ok || mpBlock.kind != masterPtrBlock {
		panic(fmt.Sprintf("bad handle %08x", hand))
	}

	ptr = readl(hand)
	if ptr != 0 {
		ptrBlock, ok := usedBlocks[ptr]
		if !ok || ptrBlock.kind != handleBlock || ptrBlock.masterPtr != hand {
			panic(fmt.Sprintf("bad master pointer %08x", hand))
		}
	}

	return ptr
}

func verifyPtr(ptr uint32) {
	ptrBlock, ok := usedBlocks[ptr]
	if !ok || ptrBlock.kind != pointerBlock {
		panic("bad pointer")
	}
}

func memErrWrap(actualTrap func() int) func() {
	return func() {
		err := actualTrap()
		writew(0x220, uint16(err)) // MemErr
	}
}

func memErrD0Wrap(actualTrap func() int) func() {
	return func() {
		err := actualTrap()
		writew(0x220, uint16(err)) // MemErr
		writel(d0ptr, uint32(err))
	}
}

// Memory Manager OS traps

var tGetZone = memErrD0Wrap(func() int {
	TheZone := readl(0x118)
	writel(a0ptr, TheZone)
	return 0
})

var tSetZone = memErrD0Wrap(func() int {
	to := readl(a0ptr)
	if to != readl(0x2aa) {
		panic("SetZone to something other than our fake zone")
	}
	writel(0x118, to) // TheZone
	return 0
})

var tFreeMem = memErrWrap(func() int {
	writel(d0ptr, memFree)
	return 0
})

var tMaxMem = memErrWrap(func() int {
	writel(d0ptr, maxBlock)
	writel(a0ptr, 0)
	return 0
})

var tCompactMem = memErrWrap(func() int {
	writel(d0ptr, maxBlock)
	return 0
})

var tPurgeOrResrvMem = memErrD0Wrap(func() int {
	cbNeeded := readl(d0ptr)
	if cbNeeded <= maxBlock {
		return 0
	} else {
		return -108 // memFullErr
	}
})

var tStackSpace = memErrWrap(func() int {
	writel(d0ptr, (readl(spptr)-kStackLimit-200)&0xfffffffc)
	return 0
})

var tNewPtr = memErrD0Wrap(func() int {
	size := readl(d0ptr)
	if size > maxBlock {
		writel(a0ptr, 0)
		return -108 // memFullErr
	}

	ptr := newBlock(size, false)
	usedBlocks[ptr].kind = pointerBlock

	writel(a0ptr, ptr)
	return 0
})

var tDisposPtr = memErrD0Wrap(func() int {
	ptr := readl(a0ptr)

	verifyPtr(ptr)

	freeBlock(ptr)
	return 0
})

var tSetPtrSize = memErrD0Wrap(func() int {
	ptr := readl(a0ptr)
	newSize := readl(d0ptr)

	verifyPtr(ptr)
	block := usedBlocks[ptr]

	// Expand anywhere up to its original size
	if newSize <= block.original {
		for i := block.size; i < newSize; i++ {
			writeb(ptr+i, 0)
		}
		block.size = newSize
		return 0
	}

	return -108 // memFullErr
})

var tGetPtrSize = memErrWrap(func() int {
	ptr := readl(a0ptr)
	verifyPtr(ptr)
	writel(d0ptr, usedBlocks[ptr].size)
	return 0
})

var tNewHandle = memErrD0Wrap(func() int {
	size := readl(d0ptr)
	if size > maxBlock {
		writel(a0ptr, 0)
		return -108 // memFullErr
	}

	hand := newBlock(5, false)
	usedBlocks[hand].kind = masterPtrBlock

	ptr := newBlock(size, true)
	usedBlocks[ptr].kind = handleBlock

	// Join the MP and storage blocks together
	usedBlocks[ptr].masterPtr = hand
	writel(hand, ptr)

	writel(a0ptr, hand)
	return 0
})

var tNewEmptyHandle = memErrD0Wrap(func() int {
	hand := newBlock(5, false)
	usedBlocks[hand].kind = masterPtrBlock

	writel(a0ptr, hand)
	return 0
})

var tDisposHandle = memErrD0Wrap(func() int {
	hand := readl(a0ptr)
	if hand == 0 {
		return -109 // nilHandleErr
	}

	ptr := verifyHandle(hand)

	freeBlock(hand)
	if ptr != 0 {
		freeBlock(ptr)
	}

	return 0
})

var tSetHandleSize = memErrD0Wrap(func() int {
	hand := readl(a0ptr)
	if hand == 0 {
		return -109 // nilHandleErr
	}

	ptr := verifyHandle(hand)
	if ptr == 0 {
		return -109 // nilHandleErr
	}

	block := usedBlocks[ptr]

	newSize := readl(d0ptr)

	// Fit within existing block
	if newSize <= block.max {
		for i := block.size; i < newSize; i++ {
			writeb(ptr+i, 0)
		}
		block.size = newSize

		return 0
	}

	// Allocate new block, unless locked bit is set
	if newSize <= maxBlock && readb(hand+4)&0x80 == 0 {
		newPtr := newBlock(newSize, true)
		usedBlocks[newPtr].kind = handleBlock
		usedBlocks[newPtr].masterPtr = hand
		writel(hand, newPtr)

		copy(mem[newPtr:], mem[ptr:][:block.size])
		freeBlock(ptr)

		return 0
	}

	return -108 // memFullErr
})

var tReallocHandle = memErrD0Wrap(func() int {
	hand := readl(a0ptr)
	if hand == 0 {
		return -109 // nilHandleErr
	}

	ptr := verifyHandle(hand)

	newSize := readl(d0ptr)
	if newSize > maxBlock {
		return -108 // memFullErr
	}

	// "Normally h is an empty handle, but it need not be."
	if ptr != 0 {
		freeBlock(ptr)
	}

	ptr = newBlock(newSize, true)
	usedBlocks[ptr].kind = handleBlock
	usedBlocks[ptr].masterPtr = hand
	writel(hand, ptr)

	return 0
})

var tGetHandleSize = memErrWrap(func() int {
	hand := readl(a0ptr)
	ptr := verifyHandle(hand)
	if ptr == 0 {
		writel(d0ptr, 0)
		return -109 // nilHandleErr
	}

	writel(d0ptr, usedBlocks[ptr].size)
	return 0
})

var tRecoverHandle = memErrWrap(func() int {
	ptr := readl(a0ptr)

	block, ok := usedBlocks[ptr]
	if !ok || block.kind != handleBlock {
		panic("bad argument to RecoverHandle")
	}

	writel(a0ptr, block.masterPtr)
	return 0
})

var tEmptyHandle = memErrD0Wrap(func() int {
	hand := readl(a0ptr)
	if hand == 0 {
		return -109 // nilHandleErr
	}

	ptr := verifyHandle(hand)

	if readb(hand+4)&0x80 != 0 {
		return -112 // memPurErr: Attempt to purge a locked block
	}

	if ptr != 0 {
		freeBlock(ptr)
		writel(hand, 0)
	}

	return 0
})

func tBlockMove() {
	src := readl(a0ptr)
	dest := readl(a1ptr)
	size := readl(d0ptr)
	copy(mem[dest:dest+size], mem[src:src+size])
}

var tHGetState = memErrWrap(func() int {
	handle := readl(a0ptr)
	if handle == 0 || verifyHandle(handle) == 0 {
		writel(d0ptr, 0)
		return -109 // nilHandleErr
	}

	flags := readb(handle + 4)
	writel(d0ptr, uint32(flags))
	return 0
})

var tHSetState = memErrD0Wrap(func() int {
	handle := readl(a0ptr)
	if handle == 0 || verifyHandle(handle) == 0 {
		writel(d0ptr, 0)
		return -109 // nilHandleErr
	}

	flags := readb(d0ptr + 3)
	writeb(handle+4, flags)
	return 0
})

var tHLock = memErrD0Wrap(func() int {
	handle := readl(a0ptr)
	if handle == 0 || verifyHandle(handle) == 0 {
		return -109 // nilHandleErr
	}

	mem[handle+4] |= 0x80
	return 0
})

var tHUnlock = memErrD0Wrap(func() int {
	handle := readl(a0ptr)
	if handle == 0 || verifyHandle(handle) == 0 {
		return -109 // nilHandleErr
	}

	mem[handle+4] &= ^byte(0x80)
	return 0
})

var tHPurge = memErrD0Wrap(func() int {
	handle := readl(a0ptr)
	if handle == 0 || verifyHandle(handle) == 0 {
		return -109 // nilHandleErr
	}

	mem[handle+4] |= 0x40
	return 0
})

var tHNoPurge = memErrD0Wrap(func() int {
	handle := readl(a0ptr)
	if handle == 0 || verifyHandle(handle) == 0 {
		return -109 // nilHandleErr
	}

	mem[handle+4] &= ^byte(0x40)
	return 0
})

func tMemMgrNop() {
	writew(0x220, 0) // MemErr
	writel(d0ptr, 0)
	writel(a0ptr, 0)
}

func mfMemRoutine(selector uint16) {
	switch selector {
	case 0x15: // FUNCTION TempMaxMem (VAR grow: Size): Size;
		writel(popl(), 0) // the weird grow parameter
		writel(readl(spptr), 0x7ffffffe)

	case 0x16: // FUNCTION TempTopMem: Ptr;
		writel(readl(spptr), 0x7ffffffe)

	case 0x18: // FUNCTION TempFreeMem: LONGINT;
		writel(readl(spptr), 0x7ffffffe)

	case 0x1d: // FUNCTION TempNewHandle(logicalSize: Size;VAR resultCode: OSErr): Handle;
		writew(popl(), 0) // resultCode = noErr
		size := popl()

		writel(d0ptr, size)
		tNewHandle()
		handle := readl(a0ptr)

		writel(readl(spptr), handle)

	case 0x1e, 0x1f: // PROCEDURE TempH[Un]Lock(h: Handle;VAR resultCode: OSErr);
		writew(popl(), 0) // resultCode = noErr
		popl()            // discard handle arg

	case 0x20: // PROCEDURE TempDisposeHandle(h: Handle;VAR resultCode: OSErr);
		writew(popl(), 0) // resultCode = noErr
		handle := popl()

		writel(a0ptr, handle)
		tDisposHandle()

	default:
		panic("mfMemRoutine: unknown MF temp mem selector")
	}
}

// Utility routines for other code

func newHandleFrom(data []byte) uint32 {
	writel(d0ptr, uint32(len(data)))
	call_m68k(executable_atrap(0xa122))
	handle := readl(a0ptr)
	copy(mem[readl(handle):], data)
	return handle
}

func getBlock(ptr uint32) []byte {
	block, ok := usedBlocks[ptr]
	if !ok {
		panic("bad argument to getBlock")
	}

	slice := make([]byte, block.size)
	copy(slice, mem[ptr:])
	return slice
}

func setHandleBlock(handle uint32, contents []byte) {
	writel(a0ptr, handle)
	writel(d0ptr, uint32(len(contents)))
	tSetHandleSize()

	copy(mem[readl(handle):], contents)
}

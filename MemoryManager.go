package main

var bump uint32 = kHeap

// Memory Manager OS traps

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

var block_sizes = make(map[uint32]uint32)
var master_ptrs = make(map[uint32]uint32)

var tGetZone = memErrD0Wrap(func() int {
	ApplZone := readl(0x2aa)
	writel(a0ptr, ApplZone) // ApplZone
	return 0
})

var tFreeMem = memErrWrap(func() int { // _FreeMem _MaxMem _CompactMem _PurgeSpace
	writel(d0ptr, 0x7ffffffe) // free
	writel(a0ptr, 0x7ffffffe) // growable (MaxMem only)
	return 0
})

var tStackSpace = memErrWrap(func() int {
	writel(d0ptr, (readl(spptr)-kStackLimit-200)&0xfffffffc)
	return 0
})

// Final common pathway for making heap blocks
// TODO: improve on this bump allocator
var tNewPtr = memErrD0Wrap(func() int {
	size := readl(d0ptr)

	bump += 16
	bump = (bump + 0xfff) & 0xfffff000
	block := bump
	bump += size

	if bump > uint32(len(mem)) {
		panic("OOM")
	}

	block_sizes[block] = size
	writel(a0ptr, block)
	return 0
})

var tDisposPtr = memErrD0Wrap(func() int {
	return 0
})

var tSetPtrSize = memErrD0Wrap(func() int {
	ptr := readl(a0ptr)
	size := readl(d0ptr)

	if block_sizes[ptr] >= size {
		block_sizes[ptr] = size
		return 0
	} else {
		return -108 // memFullErr
	}
})

var tGetPtrSize = memErrWrap(func() int {
	writel(d0ptr, block_sizes[readl(a0ptr)])
	return 0
})

var tNewHandle = memErrD0Wrap(func() int {
	tNewPtr()

	ptr := readl(a0ptr)
	handle := ptr - 16
	master_ptrs[ptr] = handle
	writel(ptr-16, ptr) // stash the master pointer in the header
	writel(a0ptr, handle)
	return 0
})

var tNewEmptyHandle = memErrD0Wrap(func() int {
	writel(d0ptr, 0)
	tNewHandle()
	writel(readl(a0ptr), 0) // points nowhere!
	return 0
})

var tDisposHandle = memErrD0Wrap(func() int {
	ptr := readl(readl(a0ptr))
	delete(master_ptrs, ptr)
	writel(a0ptr, ptr)
	tDisposPtr()
	return 0
})

var tSetHandleSize = memErrD0Wrap(func() int {
	handle := readl(a0ptr)
	size := readl(d0ptr)

	ptr := readl(handle)
	oldsize := block_sizes[ptr]
	if oldsize >= size {
		// can shrink the handle
		block_sizes[ptr] = size
	} else {
		writel(d0ptr, size)
		tNewPtr()
		ptr2 := readl(a0ptr)
		delete(master_ptrs, ptr)
		master_ptrs[ptr2] = handle
		copy(mem[ptr2:ptr2+size], mem[ptr:ptr+size])
		writel(handle, ptr2)
	}
	return 0
})

var tGetHandleSize = memErrWrap(func() int {
	writel(d0ptr, block_sizes[readl(readl(a0ptr))]) // might die??
	return 0
})

var tReallocHandle = memErrD0Wrap(func() int {
	handle := readl(a0ptr)
	size := readl(d0ptr)
	tEmptyHandle()
	writel(d0ptr, size)
	tNewPtr()
	writel(handle, readl(a0ptr))
	writel(a0ptr, handle)
	return 0
})

var tRecoverHandle = memErrWrap(func() int {
	writel(a0ptr, master_ptrs[readl(a0ptr)])
	return 0
})

var tEmptyHandle = memErrD0Wrap(func() int {
	handle := readl(a0ptr)
	writel(a0ptr, readl(handle))
	tDisposPtr()
	writel(handle, 0)
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
	flags := readb(handle + 4)
	writel(d0ptr, uint32(flags))
	return 0
})

var tHSetState = memErrD0Wrap(func() int {
	handle := readl(a0ptr)
	flags := readb(d0ptr + 3)
	writeb(handle+4, flags)
	return 0
})

func getPtrBlock(ptr uint32) []byte {
	size, ok := block_sizes[ptr]
	if !ok {
		panic("getPtrBlock on bad pointer")
	}

	return append(make([]byte, 0, size), mem[ptr:][:size]...)
}

func setHandleBlock(handle uint32, contents []byte) {
	writel(a0ptr, handle)
	writel(d0ptr, uint32(len(contents)))
	tSetHandleSize()

	copy(mem[readl(handle):], contents)
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

func newPtrFrom(data []byte) uint32 {
	writel(d0ptr, uint32(len(data)))
	call_m68k(executable_atrap(0xa11e))
	ptr := readl(a0ptr)
	copy(mem[ptr:], data)
	return ptr
}

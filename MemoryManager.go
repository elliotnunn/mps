package main

// Memory Manager OS traps

func return_memerr_and_d0(result int) {
	writew(0x220, uint16(result))
	writel(d0ptr, uint32(result))
}

func return_memerr(result int) {
	writew(0x220, uint16(result))
}

var block_sizes = make(map[uint32]uint32)
var master_ptrs = make(map[uint32]uint32)

func tGetZone() {
	return_memerr_and_d0(0)
	ApplZone := readl(0x2aa)
	writel(a0ptr, ApplZone) // ApplZone
}

func tFreeMem() { // _FreeMem _MaxMem _CompactMem _PurgeSpace
	return_memerr(0)
	writel(d0ptr, 0x7ffffffe) // free
	writel(a0ptr, 0x7ffffffe) // growable (MaxMem only)
}

func tStackSpace() {
	return_memerr(0)
	writel(d0ptr, (readl(spptr)-kStackLimit-200)&0xfffffffc)
}

// Final common pathway for making heap blocks
// TODO: improve on this bump allocator
func tNewPtr() {
	size := readl(d0ptr)
	return_memerr_and_d0(0)

	for i := 0; i < 16; i++ {
		mem = append(mem, 0)
	}
	for len(mem)%0x1000 != 0 {
		mem = append(mem, 0)
	}
	block := uint32(len(mem))
	for uint32(len(mem)) < block+size || uint32(len(mem)) < block+256 {
		mem = append(mem, 0)
	}
	block_sizes[block] = size

	writel(a0ptr, block)
}

func tDisposPtr() {
	return_memerr_and_d0(0)
}

func tSetPtrSize() {
	ptr := readl(a0ptr)
	size := readl(d0ptr)

	if block_sizes[ptr] >= size {
		block_sizes[ptr] = size
		return_memerr_and_d0(0)
	} else {
		return_memerr_and_d0(-108) // memFullErr
	}
}

func tGetPtrSize() {
	return_memerr(0)
	writel(d0ptr, block_sizes[readl(a0ptr)])
}

func tNewHandle() {
	tNewPtr()

	ptr := readl(a0ptr)
	handle := ptr - 16
	master_ptrs[ptr] = handle
	writel(ptr-16, ptr) // stash the master pointer in the header
	writel(a0ptr, handle)
}

func tNewEmptyHandle() {
	writel(d0ptr, 0)
	tNewHandle()
	writel(readl(a0ptr), 0) // points nowhere!
}

func tDisposHandle() {
	ptr := readl(readl(a0ptr))
	delete(master_ptrs, ptr)
	writel(a0ptr, ptr)
	tDisposPtr()
}

func tSetHandleSize() {
	handle := readl(a0ptr)
	size := readl(d0ptr)
	return_memerr_and_d0(0)

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
}

func tGetHandleSize() {
	return_memerr(0)
	writel(d0ptr, block_sizes[readl(readl(a0ptr))]) // might die??
}

func tReallocHandle() {
	handle := readl(a0ptr)
	size := readl(d0ptr)
	tEmptyHandle()
	writel(d0ptr, size)
	tNewPtr()
	writel(handle, readl(a0ptr))
	writel(a0ptr, handle)
	return_memerr_and_d0(0)
}

func tRecoverHandle() {
	return_memerr(0) // preserves d0, oddly
	writel(a0ptr, master_ptrs[readl(a0ptr)])
}

func tEmptyHandle() {
	handle := readl(a0ptr)
	writel(a0ptr, readl(handle))
	tDisposPtr()
	writel(handle, 0)
	return_memerr_and_d0(0)
}

func tBlockMove() {
	src := readl(a0ptr)
	dest := readl(a1ptr)
	size := readl(d0ptr)
	copy(mem[dest:dest+size], mem[src:src+size])
	return_memerr_and_d0(0)
}

func tHGetState() {
	handle := readl(a0ptr)
	flags := readb(handle + 4)
	writel(d0ptr, uint32(flags))
	return_memerr(0)
}

func tHSetState() {
	handle := readl(a0ptr)
	flags := readb(d0ptr + 3)
	writeb(handle+4, flags)
	return_memerr(0)
}

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

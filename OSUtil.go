package main

func tCmpString() {
	aptr := readl(a0ptr)
	bptr := readl(a1ptr)
	alen := readw(d0ptr)
	blen := readw(d0ptr + 2)
	diacSens := readw(d1ptr)&0x200 == 0 // ,MARKS
	caseSens := readw(d1ptr)&0x400 != 0 // ,CASE

	if relString(macstring(mem[aptr:][:alen]), macstring(mem[bptr:][:blen]), caseSens, diacSens) == 0 {
		writel(d0ptr, 0)
	} else {
		writel(d0ptr, 1)
	}
}

func tUprString() {
	sptr := readl(a0ptr)
	slen := readl(d0ptr)

	marks := readw(d1ptr)&0x200 != 0

	for i := sptr; i < sptr+slen; i++ {
		c := readb(i)
		if marks {
			c = macStripTab[c]
		}
		c = macUpperTab[c]
		writeb(i, c)
	}
}

func tSecs2Date() {
	secs := readl(d0ptr)
	rec := readl(a0ptr)

	y, m, d := secs2ymd(secs)
	writew(rec, y)
	writew(rec+2, m)
	writew(rec+4, d)

	h, m, s := secs2hms(secs)
	writew(rec+6, h)
	writew(rec+8, m)
	writew(rec+10, s)

	dow := secs2dow(secs)
	writew(rec+12, dow)
}

func secs2hms(secs uint32) (h, m, s uint16) {
	h = uint16((secs / (60 * 60)) % 24)
	m = uint16((secs / 60) % 60)
	s = uint16(secs % 60)
	return
}

func secs2dow(secs uint32) uint16 {
	d := uint16(secs / (24 * 60 * 60))
	return (d+5)%7 + 1
}

func secs2ymd(secs uint32) (y, m, d uint16) {
	d = uint16(secs / (24 * 60 * 60))

	// a quad is a leap-common-common-common cycle
	const daysPerQuad = 366 + 365 + 365 + 365
	y = d / daysPerQuad * 4
	d %= daysPerQuad

	for m_, mlen := range quadMonths {
		m = uint16(m_)
		if d < mlen {
			y = 1904 + y + m/12
			m = m%12 + 1
			d += 1
			break
		}

		d -= uint16(mlen)
	}

	return
}

var quadMonths = []uint16{
	31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, // leap year
	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, // common years...
	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31,
	31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31,
}

// _NewHandle will set d0/MemErr
func tHandToHand() { // duplicate handle
	srcPtr := readl(readl(a0ptr))
	size := block_sizes[srcPtr]
	writel(d0ptr, size)
	call_m68k(executable_atrap(0xa122)) // _NewHandle takes d0 and return a0
	dstptr := readl(readl(a0ptr))
	if dstptr != 0 {
		copy(mem[dstptr:][:size], mem[srcPtr:][:size])
	}
}

// _NewHandle will set d0/MemErr
func tPtrToHand() { // copy to new handle
	srcPtr := readl(a0ptr)
	size := readl(d0ptr)
	call_m68k(executable_atrap(0xa122)) // _NewHandle takes d0 and return a0
	dstptr := readl(readl(a0ptr))
	if dstptr != 0 {
		copy(mem[dstptr:][:size], mem[srcPtr:][:size])
	}
}

// _SetHandleSize will set d0/MemErr
func tPtrToXHand() { // copy to existing handle
	srcPtr := readl(a0ptr)
	dstHndl := readl(a1ptr)
	size := readl(d0ptr)
	writel(a0ptr, dstHndl)
	tSetHandleSize() // no need to go thru trap dispatcher
	dstPtr := readl(dstHndl)
	if readw(d0ptr+2) == 0 && dstPtr != 0 {
		copy(mem[dstPtr:][:size], mem[srcPtr:][:size])
		writel(a0ptr, dstHndl)
	}
}

// _SetHandleSize will set d0/MemErr
func tHandAndHand() { // copy to existing handle
	aHndl := readl(a0ptr)
	bHndl := readl(a1ptr)

	aSize := block_sizes[readl(aHndl)]
	bSize := block_sizes[readl(bHndl)]

	writel(a0ptr, bHndl)
	writel(d0ptr, aSize+bSize)
	tSetHandleSize() // of the bHndl

	aPtr := readl(aHndl)
	bPtr := readl(bHndl)

	if aPtr != 0 && bPtr != 0 {
		copy(mem[bPtr+bSize:][:aSize], mem[aPtr:][:aSize])
	}

	writel(a0ptr, bHndl)
}

// _SetHandleSize will set d0/MemErr
func tPtrAndHand() {
	ptr := readl(a0ptr)
	hndl := readl(a1ptr)
	addSize := readl(d0ptr)

	writel(a0ptr, hndl)
	tGetHandleSize()
	oldSize := readl(d0ptr)
	writel(d0ptr, oldSize+addSize)
	writel(a0ptr, hndl)
	tSetHandleSize()

	if readl(hndl) != 0 {
		copy(mem[readl(hndl)+oldSize:][:addSize], mem[ptr:][:addSize])
	}
	writel(a0ptr, hndl)
}

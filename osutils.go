// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

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
	hand := readl(a0ptr)
	ptr := verifyHandle(hand)

	size := uint32(0)
	if ptr != 0 {
		size = usedBlocks[ptr].size
	}

	writel(d0ptr, size)
	lineA(0xa122) // _NewHandle takes d0 and return a0
	ptr2 := readl(readl(a0ptr))

	copy(mem[ptr2:][:size], mem[ptr:][:size])
}

// _NewHandle will set d0/MemErr
func tPtrToHand() { // copy to new handle
	ptr := readl(a0ptr)
	size := readl(d0ptr)

	lineA(0xa122) // _NewHandle takes d0 and return a0
	ptr2 := readl(readl(a0ptr))

	copy(mem[ptr2:][:size], mem[ptr:][:size])
}

// _SetHandleSize will set d0/MemErr
func tPtrToXHand() { // copy to existing handle
	ptr := readl(a0ptr)
	size := readl(d0ptr)

	hand := readl(a1ptr)

	writel(a0ptr, hand)
	lineA(0xa024) // _SetHandleSize takes a0/d0, return err in d0

	if readw(d0ptr+2) == 0 { // proceed if no error
		ptr2 := readl(hand)
		copy(mem[ptr2:][:size], mem[ptr:][:size])
	}
}

// _SetHandleSize will set d0/MemErr
func tHandAndHand() { // copy to existing handle
	aHndl := readl(a0ptr)
	bHndl := readl(a1ptr)

	aPtr := verifyHandle(aHndl)
	bPtr := verifyHandle(bHndl)

	aSize := usedBlocks[aPtr].size
	bSize := usedBlocks[bPtr].size

	writel(a0ptr, bHndl)
	writel(d0ptr, aSize+bSize)
	lineA(0xa024) // _SetHandleSize takes a0/d0, return err in d0

	if readw(d0ptr+2) == 0 { // proceed if no error
		bPtr = readl(bHndl) // handle might have moved
		copy(mem[bPtr+bSize:][:aSize], mem[aPtr:][:aSize])
	}

	writel(a0ptr, bHndl)
}

// _SetHandleSize will set d0/MemErr
func tPtrAndHand() {
	aPtr := readl(a0ptr)
	aSize := readl(d0ptr)
	bHndl := readl(a1ptr)

	bPtr := verifyHandle(bHndl)

	bSize := usedBlocks[bPtr].size

	writel(a0ptr, bHndl)
	writel(d0ptr, aSize+bSize)
	lineA(0xa024) // _SetHandleSize takes a0/d0, return err in d0

	if readw(d0ptr+2) == 0 { // proceed if no error
		bPtr = readl(bHndl) // handle might have moved
		copy(mem[bPtr+bSize:][:aSize], mem[aPtr:][:aSize])
	}

	writel(a0ptr, bHndl)
}

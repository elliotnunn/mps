package main

func tBitAnd() {
	result := popl() & popl()
	writel(readl(spptr), result)
}
func tBitXor() {
	result := popl() ^ popl()
	writel(readl(spptr), result)
}

func tBitNot() {
	result := ^popl()
	writel(readl(spptr), result)
}

func tBitOr() {
	result := popl() | popl()
	writel(readl(spptr), result)
}

func tBitShift() {
	by := int16(popw())
	result := popl()
	if by > 0 {
		result <<= by % 32
	} else {
		result >>= (-by) % 32
	}
	writel(readl(spptr), result)
}

func tBitTst() {
	bitNum := popl()
	bytePtr := popl()
	bytePtr += bitNum / 8
	bitNum %= 8
	result := readb(bytePtr)&(0x80>>bitNum) != 0

	if result {
		writew(readl(spptr), 0x0100) // bool true
	} else {
		writew(readl(spptr), 0)
	}
}

func tBitSet() {
	bitNum := popl()
	bytePtr := popl()
	bytePtr += bitNum / 8
	bitNum %= 8
	writeb(bytePtr, readb(bytePtr)|(0x80>>bitNum))
}

func tBitClr() {
	bitNum := popl()
	bytePtr := popl()
	bytePtr += bitNum / 8
	bitNum %= 8
	writeb(bytePtr, readb(bytePtr) & ^(0x80>>bitNum))
}

// func tRandom() {
//     writew(readl(spptr), random.randint(0x10000))
// }

func tHiWord() {
	val := popw()
	popw()
	writew(readl(spptr), val)
}

func tLoWord() {
	popw()
	val := popw()
	writew(readl(spptr), val)
}

func tInitGraf() {
	a5 := readl(a5ptr)
	qd := popl()
	writel(a5, qd)
	writel(qd, kQDPort)
}

func tSetPort() {
	a5 := readl(a5ptr)
	qd := readl(a5)
	port := popl()
	writel(qd, port)
}

func tGetPort() {
	a5 := readl(a5ptr)
	qd := readl(a5)
	port := readl(qd)
	retaddr := popl()
	writel(retaddr, port)
}

func tSetRect() {
	botRight := popl()
	topLeft := popl()
	rectPtr := popl()
	writel(rectPtr, topLeft)
	writel(rectPtr+4, botRight)
}

func tOffsetRect() {
	dv := popw()
	dh := popw()
	rectPtr := popl()

	writew(rectPtr+0, readw(rectPtr+0)+dv) // top
	writew(rectPtr+2, readw(rectPtr+2)+dh) // left
	writew(rectPtr+4, readw(rectPtr+4)+dv) // bottom
	writew(rectPtr+6, readw(rectPtr+6)+dh) // right
}

func tInsetRect() {
	dv := popw()
	dh := popw()
	rectPtr := popl()

	writew(rectPtr+0, readw(rectPtr+0)+dv) // top
	writew(rectPtr+2, readw(rectPtr+2)+dh) // left
	writew(rectPtr+4, readw(rectPtr+4)-dv) // bottom
	writew(rectPtr+6, readw(rectPtr+6)-dh) // right
}

func tCharWidth() {
	popw()
	writew(readl(spptr), 10) // ?????
}

func tGetFNum() {
	numPtr := popl()
	popl() // discard name ptr
	writew(numPtr, 0)
}

func tGetFName() {
	namePtr := popl()
	popw() // discard num
	writePstring(namePtr, macstring("Monaco"))
}

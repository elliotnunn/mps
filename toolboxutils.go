// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

package main

func tNewString() {
	ptr := popl()
	size := uint32(readb(ptr)) + 1

	writel(d0ptr, size)
	lineA(0xa122) // _NewHandle takes d0 and returns a0
	result := readl(a0ptr)

	copy(mem[readl(result):], mem[ptr:][:size])

	writel(readl(spptr), result)
}

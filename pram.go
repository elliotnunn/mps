// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

package main

// Pretend PRAM is full of zeros
// Could expand this in future
func tReadXPram() {
	// base := uint32(readw(d0ptr+2))
	cnt := uint32(readw(d0ptr))
	addr := readl(a0ptr)

	for i := addr; i < addr+cnt; i++ {
		writeb(i, 0)
	}

	writel(d0ptr, 0)
}

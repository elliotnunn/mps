// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

// Stdin, stdout and stderr
// Tool calls to the "Dev" streams are ignored by ToolServer, so we must patch.
// ResourceManager.go calls ioCodePatch to patch.

package main

import (
	"bytes"
	"os"
)

// Overwrite our two functions
func ioCodePatch(code []byte) {
	if idx := bytes.Index(code, []byte("\x4e\x75\x87DevRead")); idx != -1 {
		if idx2 := bytes.LastIndex(code[:idx], []byte("NV")); idx2 != -1 {
			code[idx2] = 0xaf
			code[idx2+1] = 0xfe
		}
	}

	if idx := bytes.Index(code, []byte("\x4e\x75\x88DevWrite")); idx != -1 {
		if idx2 := bytes.LastIndex(code[:idx], []byte("NV")); idx2 != -1 {
			code[idx2] = 0xaf
			code[idx2+1] = 0xfd
		}
	}
}

// These Toolbox traps are called with autoPop, so they act as RTS

// Replaces DevRead
func tSpecialStdin() {
	writel(d0ptr, 0) // always

	fstruct := readl(readl(spptr))

	cnt := readl(fstruct + 12)
	ptr := readl(fstruct + 16)
	slice := mem[ptr:][:cnt]

	n := stdinReadMac(slice)

	writel(fstruct+12, cnt-uint32(n))
	writew(fstruct+2, 0) // never seems to return eofErr
}

// Replaces DevWrite
func tSpecialStdoutStderr() {
	writel(d0ptr, 0) // always

	fstruct := readl(readl(spptr))

	cookie := readl(fstruct + 8)
	cnt := readl(fstruct + 12)
	ptr := readl(fstruct + 16)
	slice := mem[ptr:][:cnt]

	var stream *os.File
	switch readl(readl(cookie)) {
	case 0:
		writew(fstruct+2, 0x10000-61) // wrPermErr
		return
	case 1:
		stream = os.Stdout
	case 2:
		stream = os.Stderr
	case 3:
		writew(fstruct+2, 0x10000-43) // fnfErr
		return
	}

	slice = []byte(macToUnicode(macstring(slice)))
	stream.Write(slice)

	writel(fstruct+12, 0) // no bytes left over
	writew(fstruct+2, 0)
}

// Mixed Go-68k stack traces (most useful when panicking)
package main

import (
	"encoding/binary"
	"fmt"
	"runtime/debug"
	"strings"
)

type traceEntry struct {
	sp, pc uint32
}

// Functions for the 68k emulator to call
var trace []traceEntry
var traceEmu []traceEntry

// Call after pushing a return address
// (but not the fake return address that call_m68k uses)
func pushedReturnAddr() {
	// Pop entry records up to and including this one
	for len(trace) > 0 && trace[len(trace)-1].sp <= readl(spptr) {
		trace = trace[:len(trace)-1]
	}

	trace = append(trace, traceEntry{sp: readl(spptr), pc: pc})
}

// Call after popping a return address,
// or to clean up when the stack might have shrunk
func poppedReturnAddr() {
	for len(trace) > 0 && trace[len(trace)-1].sp < readl(spptr) {
		trace = trace[:len(trace)-1]
	}
}

// Keep a stack of call_m68k invocations and their respective 68k stack pointers
func entered68k() {
	traceEmu = append(traceEmu, traceEntry{sp: readl(spptr), pc: pc})
}

func exited68k() {
	traceEmu = traceEmu[:len(traceEmu)-1]
	poppedReturnAddr() // all subroutines of this call_m68k have returned
}

// Re-panics will show up in the stack trace, but the last is clipped.
func stacktrace() string {
	s := string(debug.Stack())
	lines := strings.SplitAfter(s, "\n")
	lines = lines[5:] // Delete first line, debug.Stack(), stacktrace()

	var bild strings.Builder

	poppedReturnAddr() // pop returned routines from stack

	indexEmu := len(traceEmu) - 1
	index := len(trace) - 1
	emuLastAddr := pc
	for _, line := range lines {
		if strings.HasPrefix(line, "main.call_m68k(") {
			what, where := describePC(emuLastAddr)
			bild.WriteString(what)
			bild.WriteString("\n\t")
			bild.WriteString(where)
			bild.WriteByte('\n')

			for ; index >= 0; index-- {
				if trace[index].sp >= traceEmu[indexEmu].sp {
					break
				}

				// This area of stack has been overwritten
				if trace[index].pc != readl(trace[index].sp) {
					continue
				}

				what, where := describePC(trace[index].pc)
				bild.WriteString(what)
				bild.WriteString("\n\t")
				bild.WriteString(where)
				bild.WriteByte('\n')
			}
			emuLastAddr = traceEmu[indexEmu].pc
			indexEmu--
		}

		bild.WriteString(line)
	}

	return bild.String()
}

func describePC(pc uint32) (what, where string) {
	defer func() {
		what = "68k:" + what
		where = fmt.Sprintf("%#08x %s", pc, where)
	}()

	switch {
	case kA5World-0x8000 <= pc && pc < kA5World:
		what = "<code in A5 world>"
		where = fmt.Sprintf("A5-%#x", kA5World-pc)
		return
	case kATrapTable <= pc && pc < kATrapTable+0x10000:
		what = "<internal A-trap>"
		where = fmt.Sprintf("A-trap table %#x", pc>>4)
		return
	case kFTrapTable <= pc && pc < kFTrapTable+0x10000:
		what = "<internal F-trap>"
		where = fmt.Sprintf("F-trap table %#x", pc>>4)
		return
	case pc >= kHeapLimit:
		what = "<code on stack>"
		where = "stack"
		return
	case pc < kHeap:
		what = "<???>"
		where = "low memory"
		return
	}

	// Somewhere in the heap... walk all heap blocks
	for _, resMapAddr := range allResMaps() {
		resMap := dumpMap(mem[resMapAddr:])
		for _, entry := range resMap.list {
			if entry.rHndl == 0 {
				continue
			}

			curSegStart = readl(entry.rHndl)
			if curSegStart == 0 { // empty handle
				continue
			}

			curSegEnd = curSegStart + usedBlocks[curSegStart].size
			if !(curSegStart <= pc && pc < curSegEnd) {
				continue
			}

			fcb := fcbFromRefnum(resMap.mRefNum)
			fname := macToUnicode(readPstring(fcb + 62))

			var fourcc [4]byte
			binary.BigEndian.PutUint32(fourcc[:], entry.tType)

			what = macsbugName(mem[pc:curSegEnd])
			if what == "" {
				what = "<no MacsBug name>"
			} else {
				what += "()"
			}

			where = fmt.Sprintf("%s/'%s' (%d,\"%s\") +%#x",
				fname,
				string(fourcc[:]),
				entry.rID,
				macToUnicode(entry.name),
				pc-curSegStart,
			)
			return
		}
	}

	return "???", "in heap but not resource"
}

/*
From DisAsmLookUp.h:...

A valid MacsBug symbol consists of the characters '_', '%', spaces, digits, and
upper/lower case letters in a format determined by the first two bytes of the
symbol as follows:

1st byte  | 2nd byte  |  Byte  |
  Range   |  Range    | Length | Comments
==============================================================================
$20 - $7F | $20 - $7F |    8   | "Old style" MacsBug symbol format
$A0 - $FF | $20 - $7F |    8   | "Old style" MacsBug symbol format
------------------------------------------------------------------------------
$20 - $7F | $80 - $FF |   16   | "Old style" MacApp symbol ab==>b.a
$A0 - $FF | $80 - $FF |   16   | "Old style" MacApp symbol ab==>b.a
------------------------------------------------------------------------------
$80       | $01 - $FF |    n   | n = 2nd byte       (Apple Compiler symbol)
$81 - $9F | $00 - $FF |    m   | m = 1st byte & $7F (Apple Compiler symbol)
==============================================================================
*/
func macsbugName(slice []byte) (ret string) {
	defer func() {
		recover() // panics will return empty string

		for _, c := range []byte(ret) {
			if !macsbugChar(c) {
				ret = ""
			}
		}
	}()

	for try := 0; try < len(slice); try += 2 {
		// Find the end of the function
		if slice[try] == 0x4e && slice[try+1] == 0x74 && slice[try+2] == 0 {
			// RTD #<word>
			slice = slice[try+4:]
			goto foundFuncEnd
		} else if slice[try] == 0x4e && (slice[try+1] == 0x75 || slice[try+1] == 0xd0) {
			// RTS or JMP(A0)
			slice = slice[try+2:]
			goto foundFuncEnd
		}
	}
	return "" // did not find func end

foundFuncEnd:

	// "Old style" MacsBug symbol format
	// Haven't done the MacApp format -- unlikely to find in an MPW tool?
	if 0x20 <= slice[0]&0x7f && slice[0]&0x7f <= 0x7f && // 0x20-0x7f,0xa0-0xff
		0x20 <= slice[1] && slice[1] <= 0x7f { // 0x20-0x7f
		var fixedLen [8]byte // copy to edit
		copy(fixedLen[:], slice[:8])
		fixedLen[0] &= 0x7f

		return strings.TrimRight(string(fixedLen[:]), " ")
	}

	// Apple Compiler symbol
	if slice[0] == 0x80 && slice[1] != 0 {
		lenByte := slice[1]
		return string(slice[2:][:lenByte])
	}

	// Apple Compiler symbol
	if 0x81 <= slice[0] && slice[0] <= 0x9f {
		lenByte := slice[0] & 0x7f
		return string(slice[1:][:lenByte])
	}

	return ""
}

func macsbugChar(c byte) bool {
	if 'a' <= c && c <= 'z' {
		return true
	}
	if 'A' <= c && c <= 'Z' {
		return true
	}
	if '0' <= c && c <= '9' {
		return true
	}
	if c == ' ' || c == '%' || c == '_' {
		return true
	}
	return false
}

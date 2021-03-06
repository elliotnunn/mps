// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

// Mixed Go-68k stack traces (most useful when panicking)
package main

import (
	"encoding/binary"
	"encoding/hex"
	"fmt"
	"runtime/debug"
	"strings"
)

type traceEntry struct {
	stackReturn    uint32   // stack address where caller return address was pushed
	stackArgs      [20]byte // args, not including the return address
	pc             uint32   // pc of the caller
	isEmulatorCall bool     // created on entry to run68?
}

// "Out of band" view of the 68k call stack
// The 68k emulator must cooperate by telling us about JSR/RTS-like instructions
var trace []traceEntry

// Call after pushing a return address
func pushedReturnAddr(enteringEmulator bool) {
	// Clean up stray routines on the stack
	steal := popl()
	poppedReturnAddr()
	pushl(steal)

	entry := traceEntry{
		stackReturn:    readl(spptr),
		pc:             pc,
		isEmulatorCall: enteringEmulator,
	}
	copy(entry.stackArgs[:], mem[readl(spptr)+4:])

	trace = append(trace, entry)
}

// Call after popping a return address
// Harmless if called more often
// But don't call while panicking, because deferred code popping the stack
// will cause us to pop/drop our record of what went wrong!
func poppedReturnAddr() {
	// Trim returned stack entries
	for i := len(trace) - 1; i >= 0; i-- {
		if readl(spptr) <= trace[i].stackReturn {
			break // no need to delete
		}

		trace = trace[:i] // delete the entry
	}
}

func stacktrace() string {
	stackGo := strings.TrimSpace(string(debug.Stack()))

	// Cut away debug.Stack() and stacktrace()
	stackGo = strings.SplitN(stackGo, "stacktrace(", 2)[1]
	stackGo = strings.SplitN(stackGo, "\n", 3)[2]

	// Delimit chunks with a blank line, same as stack68()
	stackGo = strings.ReplaceAll(stackGo, "\nmain.run68(", "\n\nmain.run68(")

	// Split Go and 68k stacks into chunks so we can interleave them
	stackGoSplit := strings.Split(stackGo, "\n\n")
	stack68Split := strings.Split(stack68(), "\n\n")

	var bild strings.Builder

	// Interleave the chunks like so: (Go )*(68k Go )*
	for iGo := range stackGoSplit {
		i68 := iGo - len(stackGoSplit) + len(stack68Split)

		if i68 >= 0 {
			bild.WriteString(stack68Split[i68])
			bild.WriteByte('\n')
		}

		bild.WriteString(stackGoSplit[iGo])
		bild.WriteByte('\n')
	}

	return strings.TrimSpace(bild.String())
}

func shortStacktrace() (funcNames []string) {
	lines := strings.Split(stacktrace(), "\n")

	for _, line := range lines {
		if line == "" || line[0] == '\t' {
			continue
		}

		line, _, _ = strings.Cut(line, "(")
		if _, after, hasSpace := strings.Cut(line, " "); hasSpace {
			line = after
		}

		funcNames = append(funcNames, line)
	}

	return funcNames
}

// 68k call stack, formatted quite like runtime.Stack(),
// with a blank line separating invocations of run68()
func stack68() string {
	var bild strings.Builder

	calleePC := pc

	// Iterate entry records from the most recent
	for i := len(trace) - 1; i >= 0; i-- {
		// trace[i].stackArgs/isEmulatorCall refers to callee (printing now)
		// trace[i].pc refers to the caller (will print next iteration)

		what, where := describePC(calleePC)

		// Function name
		bild.WriteString(what)
		bild.WriteByte('\n')

		// Function arguments scraped the from stack
		bild.WriteByte('\t')
		bild.WriteString("stack(")
		for j := 0; j < len(trace[i].stackArgs); j += 2 {
			if j != 0 {
				bild.WriteByte(' ')
			}
			bild.WriteString(hex.EncodeToString(trace[i].stackArgs[j : j+2]))
		}
		bild.WriteByte(')')
		bild.WriteByte('\n')

		// Function location
		bild.WriteByte('\t')
		bild.WriteString(where)
		bild.WriteByte('\n')

		// Print a blank line to separate run68() invocations
		if trace[i].isEmulatorCall {
			bild.WriteByte('\n')
		}

		// The next iteration will be the caller of this function
		calleePC = trace[i].pc
	}

	return strings.TrimSpace(bild.String())
}

func describePC(pc uint32) (what, where string) {
	defer func() {
		what = "68k " + what
	}()

	switch {
	case kA5World-0x8000 <= pc && pc < kA5World:
		return "<???>", fmt.Sprintf("<A5-%#x>", kA5World-pc)
	case kFTrapTable <= pc && pc < kFTrapTable+0x10000:
		return "<???>", fmt.Sprintf("<F-trap table %#x>", pc>>4)
	case pc >= kHeapLimit && pc < kReturnAddr:
		return "<???>", fmt.Sprintf("<stack %#08x>", pc)
	case pc == kReturnAddr:
		return "<???>", fmt.Sprintf("<run68 return address %#08x>", pc)
	case pc >= kLowestIllegal:
		return "<???>", fmt.Sprintf("<illegal address %#08x>", pc)
	case pc < kHeap:
		return "<???>", fmt.Sprintf("<lowmem %#08x>", pc)
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

			var fourcc [4]byte
			binary.BigEndian.PutUint32(fourcc[:], entry.tType)

			what = macsbugName(mem[pc:curSegEnd])
			if what == "" {
				what = "<no MacsBug name>"
			} else if unmangled, ok := unmangle(what); ok {
				what = unmangled
			} else {
				what += "()"
			}

			where = fmt.Sprintf("%s//%s/%d/%q +%#x",
				openPaths[resMap.mRefNum].hostpath,
				string(fourcc[:]),
				entry.rID,
				macToUnicode(entry.name),
				pc-curSegStart,
			)
			return
		}
	}

	return "<???>", fmt.Sprintf("<heap but not resource %#08x>", pc)
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
		} else if slice[try] == 0x4e && slice[try+1] == 0x75 {
			// RTS
			slice = slice[try+2:]
			goto foundFuncEnd
		} else if slice[try] == 0x4e && 0xd0 <= slice[try+1] && slice[try+1] <= 0xd1 {
			// JMP (A0||A1)
			// More permissive because JMP (A1) is common in glue libraries
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

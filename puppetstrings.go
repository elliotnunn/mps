// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

// Force ToolServer to run scripts determined by the mps command line

package main

import (
	_ "embed"
	"os"
	"strings"
)

const REPL = `
Set Exit 0
Loop
	Echo -n '• '
	"{SystemFolder}ReadLine" >"{TempFolder}REPL"
	"{TempFolder}REPL"
End
`

//go:embed ReadLine.r
var embedReadLineTool []byte

// 1. Args parsed, and 1-2 script files are written out

func initPuppetStrings(args []string) {
	bad := false

	cwd, _ := os.Getwd()

	// Check that inputs are sane ahead of time
	if _, ok := unicodeToMac(cwd); !ok {
		bad = true
		os.Stdout.Write([]byte("#### Working directory path not convertible to Mac Roman\n"))
	}

	for _, a := range args {
		if _, ok := unicodeToMac(a); !ok {
			bad = true
			os.Stdout.Write([]byte("#### Arg not convertible to Mac Roman: " + a + "\n"))
		}
	}

	if bad {
		os.Exit(1)
	}

	args = convertArgPaths(args)
	script := macstring("Directory ") + quote(unicodeToMacOrPanic(platPathToMac(cwd))) + macstring("\r")

	switch {
	case len(args) == 0: // REPL
		script += unicodeToMacOrPanic(REPL)

		// This Tool is necessary for a REPL (sadly)
		os.Create(platPathJoin(systemFolder, "ReadLine"))
		os.WriteFile(platPathJoin(systemFolder, "ReadLine.rdump"), embedReadLineTool, 0o644)
		os.WriteFile(platPathJoin(systemFolder, "ReadLine.idump"), []byte("MPSTMPS "), 0o644)

	case strings.HasPrefix(args[0], "-"): // -c inline_script [args...]
		if args[0] != "-c" || len(args) < 2 {
			printUsageAndQuit()
		}

		if len(args) > 2 {
			putScript("InnerScript", unicodeToMacOrPanic(args[1]))

			script += macstring(`"{SystemFolder}InnerScript"`)
			for _, a := range args[2:] {
				script += " " + quote(unicodeToMacOrPanic(a))
			}
		} else {
			script += unicodeToMacOrPanic(args[1])
		}

	default: // scriptPath [args...]
		for _, a := range args {
			script += quote(unicodeToMacOrPanic(a)) + " "
		}
	}

	putScript("Script", script)
}

func convertArgPaths(args []string) []string {
	newArgs := make([]string, 0, len(args))

	for i := 0; i < len(args); i++ {
		if args[i] == "%%%" {
			for _, arg := range args[i+1:] {
				newArgs = append(newArgs, platPathToMac(arg))
			}
			break
		} else if args[i] == "%%" && i < len(args)-1 {
			newArgs = append(newArgs, platPathToMac(args[i+1]))
			i++
		} else {
			newArgs = append(newArgs, args[i])
		}
	}

	return newArgs
}

func putScript(name string, content macstring) {
	os.WriteFile(platPathJoin(systemFolder, name), []byte(content), 0o644)
	os.WriteFile(platPathJoin(systemFolder, name+".idump"), []byte("TEXTMPS "), 0o644)
	clearDirCache(systemFolder)
}

// 2. Every WaitNextEvent returns a command keypress, forcing TS to call MenuKey.

func tGetNextEvent() {
	eventrecord := popl()
	mask := popw()

	for i := uint32(0); i < 16; i++ {
		writeb(eventrecord+i, 0)
	}

	// Tell the top-level event loop about a command-keystroke
	if mask&0x400 != 0 { // check for high-level events
		writew(eventrecord, 3)        // keyDown
		writel(eventrecord+2, 0)      // no particular key
		writew(eventrecord+14, 0x100) // command
		writew(readl(spptr), 0xffff)  // return true
		return

	}
	writew(readl(spptr), 0) // return false
}

func tWaitNextEvent() {
	pop(8) // ignore sleep and mouseRgn args
	tGetNextEvent()
}

// 3. First File > Execute, then File > Quit

var sentExecute = false
var puppetFlag = false // whether next SFGetFile is for puppet

func tMenuKey() {
	puppetFlag = true
	popw() // ignore the key code

	if sentExecute {
		// writel(readl(spptr), 0x00810005) // File > Quit

		// Respect deferred calls
		panic(exitToShell{})
	} else {
		writel(readl(spptr), 0x00810002) // File > Execute}
		sentExecute = true
	}
}

// 4. The following SFGetFile is directed to {SystemFolder}Script

func tPack3() {
	selector := popw()

	sp := readl(spptr)
	replyPtr := uint32(0)
	isNewStyle := false // hierarchical version of the call

	switch selector {
	case 2: // SFGetFile
		isNewStyle = false
		replyPtr = readl(sp)
		sp += 26
	case 4: // SFPGetFile
		isNewStyle = false
		replyPtr = readl(sp + 6)
		sp += 32
	case 6: // StandardGetFile
		isNewStyle = true
		replyPtr = readl(sp)
		sp += 10
	case 8: // CustomGetFile
		isNewStyle = true
		replyPtr = readl(sp + 26)
		sp += 34
	default:
		panic("SFPutFile unimp")
	}

	writel(spptr, sp) // pop args from stack

	var number uint16
	var name macstring
	if puppetFlag {
		puppetFlag = false
		number = dirID(systemFolder)
		name = macstring("Script")
	} else {
		panic("GetFile unimplemented")
	}

	ftype := "TEXT" // finderInfo(path)[:4] // TODO: real type

	if isNewStyle {
		writeb(replyPtr, 0xff)             // good
		writeb(replyPtr+1, 0xff)           // replacing
		copy(mem[replyPtr+2:], ftype)      // type
		writew(replyPtr+6, rootID)         // FSSpec vRefNum
		writel(replyPtr+8, uint32(number)) // FSSpec dirID
		writePstring(replyPtr+12, name)    // FSSpec name
		writew(replyPtr+76, 0)             // script
		writew(replyPtr+78, 0)             // flags
		writeb(replyPtr+80, 0)             // isFolder
		writeb(replyPtr+81, 0)             // isVolume
	} else {
		writeb(replyPtr, 0xff)          // good
		writeb(replyPtr+1, 0xff)        // replacing
		copy(mem[replyPtr+2:], ftype)   // type
		writew(replyPtr+6, number)      // vRefNum
		writew(replyPtr+8, 0)           // version
		writePstring(replyPtr+10, name) // name
	}
}

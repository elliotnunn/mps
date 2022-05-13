// Copyright (c) 2021 Elliot Nunn
// Licensed under the MIT license

// The puppet strings manipulate ToolServer according to the command line.
// When ToolServer is run, the FileMgr will communicate with us via
// the puppetFilename and puppetContent channels.

package main

import (
	"os"
	"strings"
)

const puppetPrefix = ".MPS"

var puppetMaster func() (mainScript string, scripts map[string][]byte)
var puppetFlag = false // whether next SFGetFile is for puppet
var puppetFilename = make(chan string)
var puppetContent = make(chan macstring)

// 1. Args parsed, and a goroutine is chosen to pull the puppet strings

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
	cwdCmd := macstring("Directory ") + quote(unicodeToMacOrPanic(convertPath(cwd))) + macstring("\r")

	// Pick a goroutine to run the overall flow of the program
	switch {
	case len(args) == 0: // REPL
		go func() {
			<-puppetFilename
			puppetContent <- cwdCmd + macstring("Set Exit 0; Loop; Execute "+puppetPrefix+".REPL; End")

			for {
				<-puppetFilename
				for {
					os.Stdout.Write([]byte("• "))
					cmd, _ := bufin.ReadString('\n')
					if cmd, ok := unicodeToMac(cmd); ok {
						// Interactive shell should tolerate filesystem changes between commands
						clearDirCache("")

						puppetContent <- cmd
						break
					}
					os.Stdout.Write([]byte("#### Line not convertible to Mac Roman\n"))
				}
			}
		}()

	case strings.HasPrefix(args[0], "-"): // -c inline_script [args...]
		if args[0] != "-c" || len(args) < 2 {
			printUsageAndQuit()
		}

		go func() {
			if len(args) > 2 {
				<-puppetFilename
				callScript := macstring(puppetPrefix + ".Script")
				for _, a := range args[2:] {
					callScript += " " + quote(unicodeToMacOrPanic(a))
				}
				puppetContent <- cwdCmd + callScript

				<-puppetFilename
				puppetContent <- unicodeToMacOrPanic(args[1])
			} else {
				<-puppetFilename
				puppetContent <- cwdCmd + unicodeToMacOrPanic(args[1])

			}

			<-puppetFilename
			puppetContent <- "Quit"
		}()

	default: // scriptPath [args...]
		go func() {
			<-puppetFilename
			oneLine := macstring("")
			for _, a := range args {
				oneLine += quote(unicodeToMacOrPanic(a)) + " "
			}
			puppetContent <- cwdCmd + oneLine

			<-puppetFilename
			puppetContent <- "Quit"
		}()
	}
}

func convertArgPaths(args []string) []string {
	newArgs := make([]string, 0, len(args))

	for i := 0; i < len(args); i++ {
		if args[i] == "%%%" {
			for _, arg := range args[i+1:] {
				newArgs = append(newArgs, convertPath(arg))
			}
			break
		} else if args[i] == "%%" && i < len(args)-1 {
			newArgs = append(newArgs, convertPath(args[i+1]))
			i++
		} else {
			newArgs = append(newArgs, args[i])
		}
	}

	return newArgs
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

// 3. Every command keypress chooses File > Execute

func tMenuKey() {
	puppetFlag = true
	popw()                           // ignore the key code
	writel(readl(spptr), 0x00810002) // File > Execute
}

// 4. The following SFGetFile is directed to the file named puppetPrefix

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
		number = 2 // root
		name = macstring(puppetPrefix)
	} else {
		panic("GetFile unimplemented")
	}

	ftype := "TEXT" // finderInfo(path)[:4] // TODO: real type

	if isNewStyle {
		writeb(replyPtr, 0xff)             // good
		writeb(replyPtr+1, 0xff)           // replacing
		copy(mem[replyPtr+2:], ftype)      // type
		writew(replyPtr+6, 2)              // FSSpec vRefNum
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

// 5. FileMgr calls these functions to consume files from the goroutine above

func isPuppetFile(name string) bool {
	return strings.HasPrefix(name, puppetPrefix)
}

func puppetFile(name string) []byte {
	puppetFilename <- name
	return []byte(<-puppetContent)
}

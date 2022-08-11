// Copyright (c) 2022 Elliot Nunn
// Licensed under the MIT license

package main

import (
	"fmt"
	"strings"
	"time"
)

// FUNCTION New[C]Dialog(dStorage: Ptr; boundsRect: Rect; title: Str255;
//     visible: BOOLEAN; procID: INTEGER; behind: WindowPtr;
//     goAwayFlag: BOOLEAN; refCon: LONGINT; items: Handle): DialogPtr;
func tNewDialog() {
	itemsHand := popl()
	refCon := popl()
	popw() // ignore goAwayFlag
	popl() // ignore behind
	popw() // ignore procID (WDEF ID)
	visible := popb() != 0
	popl() // ignore title (does not apply to modal dialogs)
	boundsPtr := popl()
	dStorage := popl()

	if dStorage == 0 {
		writel(d0ptr, 170)
		lineA(0xa31e) // NewPtrClear
		if readw(0x220) != 0 {
			panic(fmt.Sprintf("NewDialog...NewPtr...MemErr %d", int16(readw(0x220))))
		}
		dStorage = readl(a0ptr)
	}

	// Initialize the item list
	itemsPtr := readl(itemsHand)
	item := itemsPtr + 2
	for i := 0; i <= int(readw(itemsPtr)); i++ {
		typ := readb(item + 12)
		switch typ & 0x7f {
		case 8, 16: // statText, editText
			pushl(0)
			pushl(item + 13) // pascal string pointer
			lineA(0xa906)    // _NewString
			handle := popl()
			writel(item, handle)
		default:
			writel(item, 0) // GetDItem will return zero
		}

		item = ditlNext(item)
	}

	// A GrafPort within a Window within a Dialog
	writed(dStorage+16, readd(boundsPtr))
	writew(dStorage+108, 2) // windowKind = dialogKind
	writel(dStorage+152, refCon)
	writel(dStorage+156, itemsHand)

	if visible {
		pushl(dStorage)
		tShowWindow()
	}

	writel(readl(spptr), dStorage)
}

// FUNCTION GetNewDialog(dialogID: INTEGER; dStorage: Ptr; behind: WindowPtr): DialogPtr;
func tGetNewDialog() {
	behind := popl()
	dStorage := popl()
	dialogID := popw()
	writel(readl(spptr), 0) // zero result in case we return early

	pushl(0)
	pushl(0x444c4f47) // DLOG
	pushw(dialogID)
	lineA(0xa9a0) // _GetResource
	dlogHand := popl()
	if dlogHand == 0 || readl(dlogHand) == 0 {
		return
	}
	dlogPtr := readl(dlogHand)

	pushl(0)
	pushl(0x4449544c)          // DITL
	pushw(readw(dlogPtr + 18)) // itemsID
	lineA(0xa9a0)              // _GetResource
	ditlHand := popl()
	if ditlHand == 0 || readl(ditlHand) == 0 {
		return
	}

	// Duplicate the item list handle
	ditlHand = newHandleFrom(getBlock(readl(ditlHand)))

	// Result field for NewDialog is already on the stack
	pushl(dStorage)
	pushl(dlogPtr)             // pointer to boundsRect
	pushl(dlogPtr + 20)        // pointer to title
	pushb(readb(dlogPtr + 10)) // visible
	pushw(readw(dlogPtr + 8))  // procID (WDEF ID)
	pushl(behind)
	pushb(readb(dlogPtr + 12)) // goAwayFlag
	pushl(readl(dlogPtr + 14)) // refCon
	pushl(ditlHand)

	tNewDialog()
}

// PROCEDURE GetDItem(theDialog: DialogPtr; itemNo: INTEGER;
//     VAR itemType: INTEGER; VAR item: Handle; VAR box: Rect);
func tGetDItem() {
	boxPtr := popl()
	itemHandPtr := popl()
	itemTypePtr := popl()
	itemNo := popw()
	theDialog := popl()

	if itemHandPtr != 0 {
		writel(itemHandPtr, 0) // zero result in case we return early
	}

	if readw(theDialog+108) != 2 {
		panic("GetDItem called, but not on a dialog")
	}

	ditlHand := readl(theDialog + 156)
	if itemNo-1 > readw(readl(ditlHand)) {
		return
	}

	item := readl(ditlHand) + 2
	for i := 0; i < int(itemNo)-1; i++ {
		item = ditlNext(item)
	}

	if itemTypePtr != 0 {
		writew(itemTypePtr, uint16(readb(item+12)))
	}

	if itemHandPtr != 0 {
		writel(itemHandPtr, readl(item))

		if readl(item) == 0 {
			writel(itemHandPtr, 0x1deabad1)
		}
	}

	if boxPtr != 0 {
		writed(boxPtr, readd(item+4))
	}
}

// PROCEDURE SetDItem(theDialog: DialogPtr; itemNo: INTEGER; itemType: INTEGER;
//     item: Handle; box: Rect);
func tSetDItem() {
	boxPtr := popl()
	itemHand := popl()
	itemType := popw()
	itemNo := popw()
	theDialog := popl()

	if readw(theDialog+108) != 2 {
		panic("SetDItem called, but not on a dialog")
	}

	ditlHand := readl(theDialog + 156)
	if itemNo-1 > readw(readl(ditlHand)) {
		return
	}

	item := readl(ditlHand) + 2
	for i := 0; i < int(itemNo)-1; i++ {
		item = ditlNext(item)
	}

	writeb(item+12, uint8(itemType))
	writel(item, itemHand)
	writed(item+4, readd(boxPtr))
}

// PROCEDURE GetIText(item: Handle; VAR text: Str255);
func tGetIText() {
	ptr := popl()
	handle := popl()
	writePstring(ptr, macstring(getBlock(readl(handle))))
}

// PROCEDURE SetIText(item: Handle; text: Str255);
func tSetIText() {
	text := readPstring(popl())
	handle := popl()
	setHandleBlock(handle, []byte(text))
}

func ditlNext(itemPtr uint32) uint32 {
	return (itemPtr + 14 + uint32(readb(itemPtr+13)) + 1) & ^uint32(1)
}

var currentDialog uint32
var modalDialogAwaiter *time.Timer

// PROCEDURE ShowWindow(theWindow: WindowPtr);
func tShowWindow() {
	theWindow := popl()
	// Check for magic dialog value in bkPat
	if readw(theWindow+108) != 2 {
		panic("ShowWindow called, but not on a dialog")
	}

	currentDialog = theWindow

	// We can only interact with the dialog if ModalDialog is called
	if modalDialogAwaiter != nil {
		modalDialogAwaiter.Stop()
	}
	modalDialogAwaiter = time.AfterFunc(1000000000, func() {
		logln("The MPW Tool tried to display a dialog but did not call ModalWindow.\n" +
			"It is probably waiting for input that mps cannot provide.")
	})
}

// PROCEDURE ModalDialog(filterProc: ProcPtr; VAR itemHit: INTEGER);
func tModalDialog() {
	if modalDialogAwaiter != nil {
		modalDialogAwaiter.Stop()
		modalDialogAwaiter = nil
	}

	itemHitPtr := popl()
	popl() // discard filter procedure

	ditlHand := readl(currentDialog + 156)

	itemPtrs := make([]uint32, int(readw(readl(ditlHand)))+1)
	item := readl(ditlHand) + 2
	for i := range itemPtrs {
		itemPtrs[i] = item
		item = ditlNext(item)
	}

	// Print StatText items
	for _, item := range itemPtrs {
		if readb(item+12)&0x7f != 8 || readl(item) == 0 {
			continue
		}

		text := macToUnicode(macstring(getBlock(readl(readl(item)))))
		text = strings.Trim(text, " \t\r\n\x00")
		fmt.Printf("%s ", text)
	}

	// Prompt for EditTexts
	didPrintNewline := false
	for _, item := range itemPtrs {
		if readb(item+12)&0x7f != 16 {
			continue
		}

		dflt := ""
		if readl(item) != 0 {
			dflt = macToUnicode(macstring(getBlock(readl(readl(item)))))
		}

		for {
			if dflt != "" {
				fmt.Printf("[%s] ", dflt)
			}

			line, _ := stdin.ReadString('\n')
			if strings.HasSuffix(line, "\n") {
				didPrintNewline = true
			}

			line = strings.Trim(line, " \t\r\n\x00")
			if line == "" {
				line = dflt
			}

			roman, ok := unicodeToMac(line)
			if ok {
				setHandleBlock(readl(item), []byte(roman))
				break
			} else {
				logln("Not convertible to Mac Roman. Try again.")
			}
		}
	}

	if !didPrintNewline {
		fmt.Println()
	}

	// Prompt for buttons
	type button struct {
		name  string
		index int
	}

	var buttons []button
	for i, item := range itemPtrs {
		if readb(item+12)&0x7f != 4 {
			continue
		}

		buttons = append(buttons, button{
			name:  macToUnicode(readPstring(item + 13)),
			index: i,
		})
	}

	if len(buttons) == 0 {
		panic("No buttons")
	}

	prompt := "\033[1m" + buttons[0].name + "\033[0m" // bold
	for _, btn := range buttons[1:] {
		prompt += ", " + btn.name
	}

	index := -1
	for index == -1 {
		fmt.Printf("%s? ", prompt)

		line, _ := stdin.ReadString('\n')
		line = strings.TrimRight(line, "\n")

		if line == "" {
			index = 0
			break
		}

		for _, btn := range buttons {
			if strings.HasPrefix(strings.ToLower(btn.name), strings.ToLower(line)) {
				if index == -1 {
					index = btn.index
				} else {
					index = -1 // ambiguous match
					break
				}
			}
		}
	}

	writew(itemHitPtr, uint16(index)+1) // one-based index
	return
}

// PROCEDURE ParamText(param0,param1,param2,param3: Str255);
func tParamText() {
	for i := 0; i < 4; i++ {
		lm := 0xaa0 + 4*uint32(i) // DAHandle: four string handles
		arg := readl(readl(spptr) + 4*uint32(3-i))

		// Delete the existing ones via trap table, so ToolServer knows
		if readl(lm) != 0 {
			pushl(readl(lm))
			lineA(0xa023) // _DisposHandle
		}

		// Likewise create new ones via trap table
		pushl(0)
		pushl(arg)
		lineA(0xa906) // _NewString
		handle := popl()

		writel(lm, handle)
	}

	writel(spptr, readl(spptr)+16) // pop args
}

// PROCEDURE CloseDialog(theDialog: DialogPtr);
func tCloseDialog() {
	theDialog := popl()

	itemsHand := readl(theDialog + 156)
	if itemsHand != 0 {
		writel(a0ptr, itemsHand)
		lineA(0xa023) // _DisposHandle
	}

	writel(a0ptr, theDialog)
	lineA(0xa01f) // _DisposPtr
}

// PROCEDURE DisposDialog(theDialog: DialogPtr);
func tDisposDialog() {
	theDialog := popl()

	itemsHand := readl(theDialog + 156)
	if itemsHand != 0 {
		itemsPtr := readl(itemsHand)
		item := itemsPtr + 2
		for i := 0; i <= int(readw(itemsPtr)); i++ {
			typ := readb(item+12) & 0x7f

			// Delete static and editable text handles
			if (typ == 8 || typ == 16) && readl(item) != 0 {
				writel(a0ptr, readl(item))
				lineA(0xa023) // _DisposHandle
			}

			item = ditlNext(item)
		}

		writel(a0ptr, itemsHand)
		lineA(0xa023) // _DisposHandle
	}

	writel(a0ptr, theDialog)
	lineA(0xa01f) // _DisposPtr
}

// Debugging aid
func dumpDITL(handle uint32) {
	constants := map[uint8]string{
		64: "picItem",
		32: "iconItem",
		16: "editText",
		8:  "statText",
		7:  "ctrlItem+resCtrl",
		6:  "ctrlItem+radCtrl",
		5:  "ctrlItem+chkCtrl",
		4:  "ctrlItem+btnCtrl",
		0:  "userItem",
	}

	ptr := readl(handle)
	countMinus1 := readw(ptr)

	fmt.Printf("DITL ptr=%#x count-1=%#04x\n", ptr, countMinus1)

	ptr += 2
	for i := 1; i <= int(countMinus1+1); i++ {
		fmt.Printf("  item %d offset = %#x\n", i, ptr-readl(handle))

		fmt.Printf("         handle = %#08x", readl(ptr))
		if readl(ptr) != 0 {
			if readb(ptr+12)&0x7f < 4 {
				fmt.Printf(" = procedureptr")
			} else {
				fmt.Printf(" = %q", macToUnicode(macstring(getBlock(readl(readl(ptr))))))
			}
		}
		fmt.Println()

		fmt.Printf("           rect = (%d,%d,%d,%d)\n", int16(readw(ptr+4)), int16(readw(ptr+6)), int16(readw(ptr+8)), int16(readw(ptr+10)))

		kind := readb(ptr + 12)
		name := constants[kind&0x7f]
		if name != "" && kind&0x80 != 0 {
			name += "+itemDisable"
		}
		if name == "" {
			name = "?"
		}
		fmt.Printf("           type = %#02x=%s\n", kind, name)

		fmt.Printf("           data = len=%d", readb(ptr+13))

		switch kind & 0x7f {
		case 4, 5, 6, 8, 16:
			fmt.Printf(",string=%q\n", macToUnicode(readPstring(ptr+13)))
		case 7, 32, 64:
			fmt.Printf(",resID=%d\n", int16(readw(ptr+15)))
		default:
			fmt.Println()
		}

		ptr = ditlNext(ptr)
	}
}

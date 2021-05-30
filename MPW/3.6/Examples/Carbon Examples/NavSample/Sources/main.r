/*
	File:		main.r

	Contains:	Derezed version of NavSample's resources

	Version:	1.4

	Disclaimer:	IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
				("Apple") in consideration of your agreement to the following terms, and your
				use, installation, modification or redistribution of this Apple software
				constitutes acceptance of these terms.  If you do not agree with these terms,
				please do not use, install, modify or redistribute this Apple software.

				In consideration of your agreement to abide by the following terms, and subject
				to these terms, Apple grants you a personal, non-exclusive license, under Apple’s
				copyrights in this original Apple software (the "Apple Software"), to use,
				reproduce, modify and redistribute the Apple Software, with or without
				modifications, in source and/or binary forms; provided that if you redistribute
				the Apple Software in its entirety and without modifications, you must retain
				this notice and the following text and disclaimers in all such redistributions of
				the Apple Software.  Neither the name, trademarks, service marks or logos of
				Apple Computer, Inc. may be used to endorse or promote products derived from the
				Apple Software without specific prior written permission from Apple.  Except as
				expressly stated in this notice, no other rights or licenses, express or implied,
				are granted by Apple herein, including but not limited to any patent rights that
				may be infringed by your derivative works or by other works in which the Apple
				Software may be incorporated.

				The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
				WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
				WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
				PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
				COMBINATION WITH YOUR PRODUCTS.

				IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
				CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
				GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
				ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION
				OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT
				(INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN
				ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

	Copyright © 1996-2001 Apple Computer, Inc., All Rights Reserved
*/

#define SystemSevenOrLater 1

#ifdef USE_FRAMEWORK_HEADERS
#include <Carbon/Carbon.r>
#else
#include "Types.r"
#include "FileTypesAndCreators.r"	// for 'kind' resource def
#endif

resource 'open' (300, "Native document types for NavGetFile") {
	'CPAP',
	{	/* array typeArray: 2 elements */
		/* [1] */
		'PICT',
		/* [2] */
		'TEXT'
	}
};

resource 'open' (301, "Native document type for NavChooseFile") {
	'CPAP',
	{	/* array typeArray: 1 elements */
		/* [1] */
		'CPDC'
	}
};

resource 'kind' (1000)
{
	'CPAP',
	verUS,
	{
		'apnm', "NavSample",
		'TEXT', "NavSample Text Document",
		'PICT', "NavSample Picture Document"
	}
};

resource 'MENU' (128) {
	128,
	textMenuProc,
	0x7FFFFFFD,
	enabled,
	apple,
	{	/* array: 2 elements */
		/* [1] */
		"About NavSample…", noIcon, noKey, noMark, plain,
		/* [2] */
		"-", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (129) {
	129,
	textMenuProc,
	0x7FFFF87B,
	enabled,
	"File",
	{	/* array: 14 elements */
		/* [1] */
		"New", noIcon, "N", noMark, plain,
		/* [2] */
		"Open…", noIcon, "O", noMark, plain,
		/* [3] */
		"-", noIcon, noKey, noMark, plain,
		/* [4] */
		"Close", noIcon, "W", noMark, plain,
		/* [5] */
		"Save", noIcon, "S", noMark, plain,
		/* [6] */
		"Save A Copy…", noIcon, noKey, noMark, plain,
		/* [7] */
		"Revert to Saved", noIcon, noKey, noMark, plain,
		/* [8] */
		"-", noIcon, noKey, noMark, plain,
		/* [9] */
		"Select Dictionary File…", noIcon, noKey, noMark, plain,
		/* [10] */
		"-", noIcon, noKey, noMark, plain,
		/* [11] */
		"Page Setup…", noIcon, noKey, noMark, plain,
		/* [12] */
		"Print…", noIcon, "P", noMark, plain,
		/* [13] */
		"-", noIcon, noKey, noMark, plain,
		/* [14] */
		"Quit", noIcon, "Q", noMark, plain
	}
};

resource 'MENU' (130) {
	130,
	textMenuProc,
	0x7FFFFFFD,
	enabled,
	"Edit",
	{	/* array: 7 elements */
		/* [1] */
		"Undo", noIcon, "Z", noMark, plain,
		/* [2] */
		"-", noIcon, noKey, noMark, plain,
		/* [3] */
		"Cut", noIcon, "X", noMark, plain,
		/* [4] */
		"Copy", noIcon, "C", noMark, plain,
		/* [5] */
		"Paste", noIcon, "V", noMark, plain,
		/* [6] */
		"Clear", noIcon, noKey, noMark, plain,
		/* [7] */
		"Select All", noIcon, "A", noMark, plain
	}
};

resource 'MENU' (131) {
	131,
	textMenuProc,
	0x7FFFB6FF,
	enabled,
	"Classic",
	{	/* array: 16 elements */
		/* [1] */
		"Choose a Directory…", noIcon, noKey, noMark, plain,
		/* [2] */
		"Choose a Volume…", noIcon, noKey, noMark, plain,
		/* [3] */
		"Choose an Object…", noIcon, noKey, noMark, plain,
		/* [4] */
		"Choose an Application…", noIcon, noKey, noMark, plain,
		/* [5] */
		"Create a Directory…", noIcon, noKey, noMark, plain,
		/* [6] */
		"-", noIcon, noKey, noMark, plain,
		/* [7] */
		"Custom Open…", noIcon, noKey, noMark, plain,
		/* [8] */
		"Add Files…", noIcon, noKey, noMark, plain,
		/* [9] */
		"-", noIcon, noKey, noMark, plain,
		/* [10] */
		"Customize Show Popup…", noIcon, noKey, noMark, plain,
		/* [11] */
		"Fully Customize Show Popup…", noIcon, noKey, noMark, plain,
		/* [12] */
		"-", noIcon, noKey, noMark, plain,
		/* [13] */
		"Customize Format Popup…", noIcon, noKey, noMark, plain,
		/* [14] */
		"Fully Customize Format Popup…", noIcon, noKey, noMark, plain,
		/* [15] */
		"-", noIcon, noKey, noMark, plain,
		/* [16] */
		"New File…", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (132) {
	132,
	textMenuProc,
	allEnabled,
	enabled,
	"Modern",
	{	/* array: 5 elements */
		/* [1] */
		"Save Changes", noIcon, noKey, noMark, plain,
		/* [2] */
		"-", noIcon, noKey, noMark, plain,
		/* [3] */
		"Open a File", noIcon, noKey, noMark, plain,
		/* [4] */
		"Save a Copy", noIcon, noKey, noMark, plain,
		/* [5] */
		"Choose an Object…", noIcon, noKey, noMark, plain,
		/* [6] */
		"Create a Directory…", noIcon, noKey, noMark, plain,
		/* [7] */
		"-", noIcon, noKey, noMark, plain,
		/* [8] */
		"Customize Show Popup", noIcon, noKey, noMark, plain,
		/* [9] */
		"Customize using Carbon Events", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (135) {
	135,
	textMenuProc,
	allEnabled,
	enabled,
	"Commands",
	{	/* array: 22 elements */
		/* [1] */
		"Show Desktop", noIcon, noKey, noMark, plain,
		/* [2] */
		"Sort By", noIcon, noKey, noMark, plain,
		/* [3] */
		"Sort Order", noIcon, noKey, noMark, plain,
		/* [4] */
		"Scroll Home", noIcon, noKey, noMark, plain,
		/* [5] */
		"Scroll End", noIcon, noKey, noMark, plain,
		/* [6] */
		"Page Up", noIcon, noKey, noMark, plain,
		/* [7] */
		"Page Down", noIcon, noKey, noMark, plain,
		/* [8] */
		"Get Location", noIcon, noKey, noMark, plain,
		/* [9] */
		"Set Location", noIcon, noKey, noMark, plain,
		/* [10] */
		"Get Selection", noIcon, noKey, noMark, plain,
		/* [11] */
		"Set Selection", noIcon, noKey, noMark, plain,
		/* [12] */
		"Show Selection", noIcon, noKey, noMark, plain,
		/* [13] */
		"Open Selection", noIcon, noKey, noMark, plain,
		/* [14] */
		"Eject Volume", noIcon, noKey, noMark, plain,
		/* [15] */
		"New Folder", noIcon, noKey, noMark, plain,
		/* [16] */
		"Cancel", noIcon, noKey, noMark, plain,
		/* [17] */
		"Accept", noIcon, noKey, noMark, plain,
		/* [18] */
		"Is Preview Showing", noIcon, noKey, noMark, plain,
		/* [19] */
		"Add Control", noIcon, noKey, noMark, plain,
		/* [20] */
		"Add Control List", noIcon, noKey, noMark, plain,
		/* [21] */
		"Get FirstControl ID", noIcon, noKey, noMark, plain,
		/* [22] */
		"SelectCustomType", noIcon, noKey, noMark, plain,
		/* [23] */
		"SelectAllType", noIcon, noKey, noMark, plain,
		/* [24] */
		"Get Edit FileName", noIcon, noKey, noMark, plain,
		/* [25] */
		"Set Edit FileName", noIcon, noKey, noMark, plain,
		/* [26] */
		"Select Edit FileName", noIcon, noKey, noMark, plain,
		/* [27] */
		"Browser Select All", noIcon, noKey, noMark, plain,
		/* [28] */
		"Goto Parent", noIcon, noKey, noMark, plain,
		/* [29] */
		"Set Action State", noIcon, noKey, noMark, plain,
		/* [30] */
		"Browser Redraw", noIcon, noKey, noMark, plain,
		/* [31] */
		"Terminate", noIcon, noKey, noMark, plain
	}
};

resource 'MBAR' (128) {
	{	/* array MenuArray: 5 elements */
		/* [1] */
		128,
		/* [2] */
		129,
		/* [3] */
		130,
		/* [4] */
		131,
		/* [5] */
		132
	}
};

resource 'ALRT' (128, "Save changes?") {
	{94, 80, 211, 434},
	128,
	{	/* array: 4 elements */
		/* [1] */
		OK, visible, silent,
		/* [2] */
		OK, visible, silent,
		/* [3] */
		OK, visible, silent,
		/* [4] */
		OK, visible, silent
	},
	alertPositionMainScreen
};

resource 'ALRT' (129, "Revert to saved?") {
	{94, 80, 211, 434},
	129,
	{	/* array: 4 elements */
		/* [1] */
		Cancel, visible, silent,
		/* [2] */
		Cancel, visible, silent,
		/* [3] */
		Cancel, visible, silent,
		/* [4] */
		Cancel, visible, silent
	},
	alertPositionMainScreen
};

resource 'ALRT' (130, "Generic alert") {
	{94, 80, 211, 434},
	130,
	{	/* array: 4 elements */
		/* [1] */
		OK, visible, silent,
		/* [2] */
		OK, visible, silent,
		/* [3] */
		OK, visible, silent,
		/* [4] */
		OK, visible, silent
	},
	alertPositionMainScreen
};

resource 'DITL' (128, "Save changes?") {
	{	/* array DITLarray: 5 elements */
		/* [1] */
		{87, 284, 107, 344},
		Button {
			enabled,
			"Save"
		},
		/* [2] */
		{87, 211, 107, 271},
		Button {
			enabled,
			"Cancel"
		},
		/* [3] */
		{87, 70, 107, 155},
		Button {
			enabled,
			"Don’t Save"
		},
		/* [4] */
		{10, 20, 42, 52},
		Icon {
			disabled,
			2
		},
		/* [5] */
		{10, 72, 76, 344},
		StaticText {
			disabled,
			"Save changes to the document “^0” before"
			" ^1?"
		}
	}
};

resource 'DITL' (129, "Revert to saved?") {
	{	/* array DITLarray: 4 elements */
		/* [1] */
		{87, 284, 107, 344},
		Button {
			enabled,
			"Revert"
		},
		/* [2] */
		{87, 211, 107, 271},
		Button {
			enabled,
			"Cancel"
		},
		/* [3] */
		{10, 20, 42, 52},
		Icon {
			disabled,
			2
		},
		/* [4] */
		{10, 72, 76, 344},
		StaticText {
			disabled,
			"Revert to the last saved version of “^0”"
			"?"
		}
	}
};

resource 'DITL' (130, "Generic Alert items") {
	{	/* array DITLarray: 2 elements */
		/* [1] */
		{87, 284, 107, 344},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{10, 72, 76, 344},
		StaticText {
			disabled,
			"^0"
		}
	}
};

resource 'DITL' (131, "About window items", purgeable) {
	{	/* array DITLarray: 3 elements */
		/* [1] */
		{147, 382, 167, 448},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{20, 68, 137, 441},
		StaticText {
			disabled,
			"NavSample\n\nA Navigation Services client "
			"application with sample code for develop"
			"ers.\n\nCopyright © 1996-2001, Apple Compu"
			"ter, Inc."
		},
		/* [3] */
		{20, 21, 52, 53},
		UserItem {
			disabled
		}
	}
};

resource 'DITL' (132, "Custom open controls (inset)") {
	{	/* array DITLarray: 8 elements */
		/* [1] */
		{10, 6, 29, 252},
		Control {
			enabled,
			132
		},
		/* [2] */
		{92, 131, 107, 258},
		CheckBox {
			enabled,
			"Default Button"
		},
		/* [3] */
		{10, 276, 99, 410},
		Picture {
			disabled,
			128
		},
		/* [4] */
		{38, 12, 54, 85},
		StaticText {
			disabled,
			"Edit Field:"
		},
		/* [5] */
		{38, 96, 54, 262},
		EditText {
			enabled,
			"Some text..."
		},
		/* [6] */
		{67, 10, 85, 124},
		RadioButton {
			enabled,
			"Radio Choice 1"
		},
		/* [7] */
		{87, 10, 105, 127},
		RadioButton {
			enabled,
			"Radio Choice 2"
		},
		/* [8] */
		{64, 133, 84, 265},
		Button {
			enabled,
			"Alert"
		}
	}
};

resource 'DITL' (133, "Add/Remove Items") {
	{	/* array DITLarray: 6 elements */
		/* [1] */
		{9, 12, 25, 210},
		StaticText {
			disabled,
			"Current List of Files:"
		},
		/* [2] */
		{29, 12, 115, 286},
		Control {
			enabled,
			133
		},
		/* [3] */
		{38, 300, 58, 392},
		Button {
			enabled,
			"Remove"
		},
		/* [4] */
		{66, 300, 86, 392},
		Button {
			enabled,
			"Remove All"
		},
		/* [5] */
		{95, 300, 115, 392},
		Button {
			enabled,
			"Done"
		},
		/* [6] */
		{10, 300, 30, 392},
		Button {
			enabled,
			"Add All"
		}
	}
};

resource 'DITL' (134, "Custom open controls") {
	{	/* array DITLarray: 8 elements */
		/* [1] */
		{1, -4, 20, 242},
		Control {
			enabled,
			132
		},
		/* [2] */
		{83, 121, 98, 248},
		CheckBox {
			enabled,
			"Default Button"
		},
		/* [3] */
		{1, 266, 90, 400},
		Picture {
			disabled,
			128
		},
		/* [4] */
		{29, 2, 45, 75},
		StaticText {
			disabled,
			"Edit Field:"
		},
		/* [5] */
		{29, 86, 45, 252},
		EditText {
			enabled,
			"Some text..."
		},
		/* [6] */
		{58, 0, 76, 114},
		RadioButton {
			enabled,
			"Radio Choice 1"
		},
		/* [7] */
		{78, 0, 96, 117},
		RadioButton {
			enabled,
			"Radio Choice 2"
		},
		/* [8] */
		{55, 123, 75, 255},
		Button {
			enabled,
			"Alert"
		}
	}
};

resource 'DITL' (135, "New File Items") {
	{	/* array DITLarray: 1 elements */
		/* [1] */
		{0, 0, 20, 101},
		Button {
			enabled,
			"New File…"
		}
	}
};

resource 'DITL' (136, "New File Items (inset)") {
	{	/* array DITLarray: 1 elements */
		/* [1] */
		{11, 9, 31, 110},
		Button {
			enabled,
			"New File…"
		}
	}
};

resource 'STR#' (129, "Undo strings") {
	{	/* array StringArray: 3 elements */
		/* [1] */
		"Can't Undo",
		/* [2] */
		"Undo",
		/* [3] */
		"Redo"
	}
};

resource 'STR#' (128, "App strings") {
	{	/* array StringArray: 35 elements */
		/* [1] */
		"NavSample",
		/* [2] */
		"An error occurred while translating a document on a locked disk.",
		/* [3] */
		"An error occurred while translating a document.",
		/* [4] */
		"An error ocurred while opening the file.",
		/* [5] */
		"An error ocurred while reading the file.",
		/* [6] */
		"The file cannot be changed because it is in use.",
		/* [7] */
		"The file cannot be opened because it is in use by another application.",
		/* [8] */
		"Please find the dictionary file.",
		/* [9] */
		"Please choose a folder.",
		/* [10] */
		"Please choose a volume.",
		/* [11] */
		"Please create a folder.",
		/* [12] */
		"Please choose a file object.",
		/* [13] */
		"Choose an Application",
		/* [14] */
		"Save a copy of this document:",
		/* [15] */
		"Save this document as:",
		/* [16] */
		"closing",
		/* [17] */
		"quitting",
		/* [18] */
		"Add Selected Files…",
		/* [19] */
		"NavSample is getting low on memory, please close some documents or increase its memory requirements.",
		/* [20] */
		"Unable to save this file, disk if full.",
		/* [21] */
		"Unable to save this file, an error has occurred.",
		/* [22] */
		"untitled ",
		/* [23] */
		" copy",
		/* [24] */
		"Add",
		/* [25] */
		"You cannot use the default button until you have checked the \"Default Button\" checkbox.",
		/* [26] */
		"The selected item(s) are already in the list.",
		/* [27] */
		"You are not allowed to open the System Folder.",
		/* [28] */
		"This example shows how to customize the Show popup menu.",
		/* [29] */
		"This example shows how to customize the Format popup menu.",
		/* [30] */
		"Text (as HTML)",
		/* [31] */
		"Text (as Tab Delimmited)",
		/* [32] */
		"Text (styled text)",
		/* [33] */
		"Cancel",
		/* [34] */
		"Don't Save",
		/* [35] */
		"This is a sample alert.",
		/* [36] */
		"This file is locked so you will not be able to save any changes.",
		/* [37] */
		"This example shows how to customize using Carbon Events."
	}
};

resource 'DLOG' (131, "About dialog") {
	{71, 49, 254, 519},
	dBoxProc,
	visible,
	noGoAway,
	0x0,
	131,
	"",
	centerMainScreen
};

resource 'DLOG' (132, "Custom open controls (inset)") {
	{0, 0, 114, 419},
	documentProc,
	visible,
	noGoAway,
	0x0,
	134,
	"",
	centerMainScreen
};

resource 'DLOG' (133, "Add/Remove Custom Area") {
	{35, 52, 160, 408},
	documentProc,
	visible,
	noGoAway,
	0x0,
	133,
	"",
	centerMainScreen
};

resource 'DLOG' (134, "Custom open controls") {
	{0, 0, 99, 402},
	documentProc,
	visible,
	noGoAway,
	0x0,
	132,
	"",
	centerMainScreen
};

resource 'BNDL' (128) {
	'CPAP',
	0,
	{	/* array TypeArray: 2 elements */
		/* [1] */
		'FREF',
		{	/* array IDArray: 3 elements */
			/* [1] */
			0, 128,
			/* [2] */
			1, 129,
			/* [3] */
			2, 130
		},
		/* [2] */
		'ICN#',
		{	/* array IDArray: 3 elements */
			/* [1] */
			0, 128,
			/* [2] */
			1, 129,
			/* [3] */
			2, 130
		}
	}
};


resource 'FREF' (128) {
	'APPL',
	0,
	""
};

resource 'FREF' (129) {
	'TEXT',
	1,
	""
};

resource 'FREF' (130) {
	'PICT',
	2,
	""
};

resource 'ics4' (128) {
	$"0000 000F F000 0000 0000 00FC CF00 0000"
	$"0000 0FCD DCF0 0000 0000 FCDD DDCF 0000"
	$"000F CDDD DDDC F000 00FC DDDD DDDD CF00"
	$"0FCD DDDD DDDD DCF0 FCDD DDDD FFFF FDCF"
	$"FEDD DDDF 1000 FFEF 0FED DFFF FFF0 0FFF"
	$"00FE DDDF 1000 10FF 000F EDDD F010 00FF"
	$"0000 FEDD DFFF FFFF 0000 0FED DEF0 00FF"
	$"0000 00FE EF00 0000 0000 000F F0"
};

resource 'ics4' (129) {
	$"0FFF FFFF FFF0 0000 0F00 0000 00FF 0000"
	$"0F0C CCCC CCF0 F000 0F0C CCCC CCFF FF00"
	$"0F0C FFCC CCCC DF00 0F0C CCCC CCCC DF00"
	$"0F0C FFFF FFFC DF00 0F0C CCCC CCCC DF00"
	$"0F0C FFFF FFFC DF00 0F0C CCCC CCCC DF00"
	$"0F0C FFFF FFFC DF00 0F0C CCCC CCCC DF00"
	$"0F0C CCCC FFFC DF00 0F0C CCCC CCCC DF00"
	$"0FDD DDDD DDDD DF00 0FFF FFFF FFFF FF"
};

resource 'ics4' (130) {
	$"0FFF FFFF FFF0 0000 0F00 0000 00FF 0000"
	$"0F0C CCCC CCF0 F000 0F0C CCCC CCFF FF00"
	$"0F0C CCCC CCCC DF00 0F0B BBBB BBBC DF00"
	$"0F0B 7777 77AC DF00 0F0B 77FF F7AC DF00"
	$"0F0B 7FFF F7AC DF00 0F0B 7FFF F7AC DF00"
	$"0F0B 9999 99AC DF00 0F0B AAAA AAAC DF00"
	$"0F0C CCCC CCCC DF00 0F0C CCCC CCCC DF00"
	$"0FDD DDDD DDDD DF00 0FFF FFFF FFFF FF"
};

resource 'ics#' (128) {
	{	/* array: 2 elements */
		/* [1] */
		$"0100 0280 0440 0820 1010 2008 4004 80F2"
		$"4109 27F7 1103 0883 047F 0223 0140 0080",
		/* [2] */
		$"0100 0380 07C0 0FE0 1FF0 3FF8 7FFC FFFE"
		$"7FFF 3FFF 1FFF 0FFF 07FF 03E3 01C0 0080"
	}
};

resource 'ics#' (129) {
	{	/* array: 2 elements */
		/* [1] */
		$"7FE0 4030 4028 403C 4C04 4004 4FE4 4004"
		$"4FE4 4004 4FE4 4004 40E4 4004 4004 7FFC",
		/* [2] */
		$"7FF0 7FF8 7FFC 7FFC 7FFC 7FFC 7FFC 7FFC"
		$"7FFC 7FFC 7FFC 7FFC 7FFC 7FFC 7FFC 7FFC"
	}
};

resource 'ics#' (130) {
	{	/* array: 2 elements */
		/* [1] */
		$"7FE0 4030 4028 403C 4004 4004 4FE4 4824"
		$"4B24 4AA4 4824 4FE4 4004 4004 4004 7FFC",
		/* [2] */
		$"7FF0 7FF8 7FFC 7FFC 7FFC 7FFC 7FFC 7FFC"
		$"7FFC 7FFC 7FFC 7FFC 7FFC 7FFC 7FFC 7FFC"
	}
};

resource 'ICN#' (128, purgeable) {
	{	/* array: 2 elements */
		/* [1] */
		$"0001 0000 0002 8000 0004 4000 0008 2000"
		$"0010 1000 0020 0800 0040 0400 0080 0200"
		$"0100 0100 0200 0080 0400 0040 0800 0020"
		$"1000 0010 2000 0008 4000 3F04 8000 4082"
		$"4000 8041 2001 3022 1001 C814 081E 7F8F"
		$"0402 3007 0201 0007 0100 8007 0080 6007"
		$"0040 1FE7 0020 021F 0010 040F 0008 0800"
		$"0004 1000 0002 2000 0001 4000 0000 80",
		/* [2] */
		$"0001 0000 0003 8000 0007 C000 000F E000"
		$"001F F000 003F F800 007F FC00 00FF FE00"
		$"01FF FF00 03FF FF80 07FF FFC0 0FFF FFE0"
		$"1FFF FFF0 3FFF FFF8 7FFF FFFC FFFF FFFE"
		$"7FFF FFFF 3FFF FFFE 1FFF FFFC 0FFF FFFF"
		$"07FF FFFF 03FF FFFF 01FF FFFF 00FF FFFF"
		$"007F FFFF 003F FE1F 001F FC0F 000F F800"
		$"0007 F000 0003 E000 0001 C000 0000 80"
	}
};

resource 'ICN#' (129, purgeable) {
	{	/* array: 2 elements */
		/* [1] */
		$"1FFF FC00 1000 0600 1000 0500 1000 0480"
		$"1000 0440 1000 0420 1000 07F0 10F8 0010"
		$"1000 0010 10F8 0010 1000 0010 1000 0010"
		$"1000 0010 10FF FE10 1000 0010 10FF FE10"
		$"1000 0010 10FF FE10 1000 0010 1000 0010"
		$"10FF FE10 1000 0010 10FF FE10 1000 0010"
		$"1000 0010 1000 0010 1000 7E10 1000 0010"
		$"1000 0010 1000 0010 1000 0010 1FFF FFF0",
		/* [2] */
		$"1FFF FC00 1FFF FE00 1FFF FF00 1FFF FF80"
		$"1FFF FFC0 1FFF FFE0 1FFF FFF0 1FFF FFF0"
		$"1FFF FFF0 1FFF FFF0 1FFF FFF0 1FFF FFF0"
		$"1FFF FFF0 1FFF FFF0 1FFF FFF0 1FFF FFF0"
		$"1FFF FFF0 1FFF FFF0 1FFF FFF0 1FFF FFF0"
		$"1FFF FFF0 1FFF FFF0 1FFF FFF0 1FFF FFF0"
		$"1FFF FFF0 1FFF FFF0 1FFF FFF0 1FFF FFF0"
		$"1FFF FFF0 1FFF FFF0 1FFF FFF0 1FFF FFF0"
	}
};

resource 'ICN#' (130, purgeable) {
	{	/* array: 2 elements */
		/* [1] */
		$"1FFF FC00 1000 0600 1000 0500 1000 0480"
		$"1000 0440 1000 0420 1000 07F0 1000 0010"
		$"1000 0010 1000 0010 1000 0010 11FF FF10"
		$"11AA AB10 117F FD10 11C0 0710 1144 0510"
		$"11CA 0710 1155 0510 11D5 7710 1151 5510"
		$"11D1 5710 117F FD10 11C0 0710 117F FD10"
		$"11D5 5710 11FF FF10 1000 0010 1000 0010"
		$"1000 0010 1000 0010 1000 0010 1FFF FFF0",
		/* [2] */
		$"1FFF FC00 1FFF FE00 1FFF FF00 1FFF FF80"
		$"1FFF FFC0 1FFF FFE0 1FFF FFF0 1FFF FFF0"
		$"1FFF FFF0 1FFF FFF0 1FFF FFF0 1FFF FFF0"
		$"1FFF FFF0 1FFF FFF0 1FFF FFF0 1FFF FFF0"
		$"1FFF FFF0 1FFF FFF0 1FFF FFF0 1FFF FFF0"
		$"1FFF FFF0 1FFF FFF0 1FFF FFF0 1FFF FFF0"
		$"1FFF FFF0 1FFF FFF0 1FFF FFF0 1FFF FFF0"
		$"1FFF FFF0 1FFF FFF0 1FFF FFF0 1FFF FFF0"
	}
};

resource 'icl8' (128) {
	$"0000 0000 0000 0000 0000 0000 0000 00FF"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 FF2B"
	$"FF00 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 00FF 2B2B"
	$"2BFF 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 FF2B 2BF9"
	$"2B2B FF00 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 00FF 2B2B F9F9"
	$"F92B 2BFF 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 FF2B 2BF9 F9F9"
	$"F9F9 2B2B FF00 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 00FF 2B2B F9F9 F9F9"
	$"F9F9 F92B 2BFF 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 FF2B 2BF9 F9F9 F9F9"
	$"F9F9 F9F9 2B2B FF00 0000 0000 0000 0000"
	$"0000 0000 0000 00FF 2B2B F9F9 F9F9 F9F9"
	$"F9F9 F9F9 F92B 2BFF 0000 0000 0000 0000"
	$"0000 0000 0000 FF2B 2BF9 F9F9 F9F9 F9F9"
	$"F9F9 F9F9 F9F9 2B2B FF00 0000 0000 0000"
	$"0000 0000 00FF 2B2B F9F9 F9F9 F9F9 F9F9"
	$"F9F9 F9F9 F9F9 F92B 2BFF 0000 0000 0000"
	$"0000 0000 FF2B 2BF9 F9F9 F9F9 F9F9 F9F9"
	$"F9F9 F9F9 F9F9 F9F9 2B2B FF00 0000 0000"
	$"0000 00FF 2B2B F9F9 F9F9 F9F9 F9F9 F9F9"
	$"F9F9 F9F9 F9F9 F9F9 F92B 2BFF 0000 0000"
	$"0000 FF2B 2BF9 F9F9 F9F9 F9F9 F9F9 F9F9"
	$"F9F9 F9F9 F9F9 F9F9 F9F9 2B2B FF00 0000"
	$"00FF 2B2B F9F9 F9F9 F9F9 F9F9 F9F9 F9F9"
	$"F9F9 FFFF FFFF FFFF F9F9 F92B 2BFF 0000"
	$"FF2B 2BF9 F9F9 F9F9 F9F9 F9F9 F9F9 F9F9"
	$"F9FF 0008 0008 0008 FFF9 F9F9 2B2B FF00"
	$"00FF FCFC F9F9 F9F9 F9F9 F9F9 F9F9 F9F9"
	$"FF00 0800 0800 0800 08FF F9F9 F92B 2BFF"
	$"0000 FFFC FCF9 F9F9 F9F9 F9F9 F9F9 F9FF"
	$"0008 FFFF 0008 0008 0008 FFF9 FCFC FF00"
	$"0000 00FF FCFC F9F9 F9F9 F9F9 F9F9 F9FF"
	$"FFFF 0800 FF00 0800 0800 08FF FCFF 0000"
	$"0000 0000 FFFC FCF9 F9F9 F9FF FFFF FF08"
	$"00FF FFFF FFFF FFFF FF08 0008 FFFF FFFF"
	$"0000 0000 00FF FCFC F9F9 F9F9 F9F9 FF00"
	$"0800 FFFF 0800 0800 0800 0800 08FF FFFF"
	$"0000 0000 0000 FFFC FCF9 F9F9 F9F9 F9FF"
	$"0008 0008 0008 0008 0008 0008 00FF FFFF"
	$"0000 0000 0000 00FF FCFC F9F9 F9F9 F9F9"
	$"FF00 0800 0800 0800 0800 0800 08FF FFFF"
	$"0000 0000 0000 0000 FFFC FCF9 F9F9 F9F9"
	$"F9FF FF08 0008 0008 0008 0008 00FF FFFF"
	$"0000 0000 0000 0000 00FF FCFC F9F9 F9F9"
	$"F9F9 F9FF FFFF FFFF FFFF FF00 08FF FFFF"
	$"0000 0000 0000 0000 0000 FFFC FCF9 F9F9"
	$"F9F9 F9F9 FCFC FF00 0000 00FF FFFF FFFF"
	$"0000 0000 0000 0000 0000 00FF FCFC F9F9"
	$"F9F9 F9FC FCFF 0000 0000 0000 FFFF FFFF"
	$"0000 0000 0000 0000 0000 0000 FFFC FCF9"
	$"F9F9 FCFC FF00 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 00FF FCFC"
	$"F9FC FCFF 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 FFFC"
	$"FCFC FF00 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 00FF"
	$"FCFF 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"FF"
};

resource 'icl8' (129) {
	$"0000 00FF FFFF FFFF FFFF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF 0000 0000 0000 0000 0000"
	$"0000 00FF F5F5 F5F5 F5F5 F5F5 F5F5 F5F5"
	$"F5F5 F5F5 F5FF FF00 0000 0000 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2BFF 00FF 0000 0000 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2BFF 0000 FF00 0000 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2BFF 0000 00FF 0000 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2BFF 0000 0000 FF00 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2BFF FFFF FFFF FFFF 0000 0000"
	$"0000 00FF F52B 2B2B FFFF FFFF FF2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B FFFF FFFF FF2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B FFFF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF FF2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B FFFF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF FF2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B FFFF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF FF2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B FFFF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF FF2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B FFFF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF FF2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2BFF FFFF FFFF FF2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F9F9 F9F9 F9F9 F9F9 F9F9 F9F9"
	$"F9F9 F9F9 F9F9 F9F9 F9F9 F9FF 0000 0000"
	$"0000 00FF FFFF FFFF FFFF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF FFFF FFFF FFFF"
};

resource 'icl8' (130) {
	$"0000 00FF FFFF FFFF FFFF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF 0000 0000 0000 0000 0000"
	$"0000 00FF F5F5 F5F5 F5F5 F5F5 F5F5 F5F5"
	$"F5F5 F5F5 F5FF FF00 0000 0000 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2BFF 00FF 0000 0000 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2BFF 0000 FF00 0000 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2BFF 0000 00FF 0000 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2BFF 0000 0000 FF00 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2BFF FFFF FFFF FFFF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2BFF FFFF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF FFFF 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2BFF FF33 3333 3333 3333"
	$"3333 3333 3333 FFFF 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2BFF 33FF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF 33FF 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2BFF 33FF C0C0 C0C0 C0C0"
	$"C0C0 C0C0 C0FF 33FF 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2BFF 33FF C0C0 C0FF C0C0"
	$"C0C0 C0C0 C0FF 33FF 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2BFF 33FF C0C0 FF00 FFC0"
	$"C0C0 C0C0 C0FF 33FF 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2BFF 33FF C0FF 00FF 00FF"
	$"C0C0 C0C0 C0FF 33FF 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2BFF 33FF C0FF 00FF 00FF"
	$"C0FF FFFF C0FF 33FF 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2BFF 33FF C0FF 0000 00FF"
	$"C0FF 00FF C0FF 33FF 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2BFF 33FF C0FF 0000 00FF"
	$"C0FF 00FF C0FF 33FF 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2BFF 33FF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF 33FF 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2BFF 33FF E3E3 E3E3 E3E3"
	$"E3E3 E3E3 E3FF 33FF 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2BFF 33FF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF 33FF 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2BFF FF33 3333 3333 3333"
	$"3333 3333 3333 FFFF 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2BFF FFFF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF FFFF 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F52B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2B2B 2B2B F9FF 0000 0000"
	$"0000 00FF F9F9 F9F9 F9F9 F9F9 F9F9 F9F9"
	$"F9F9 F9F9 F9F9 F9F9 F9F9 F9FF 0000 0000"
	$"0000 00FF FFFF FFFF FFFF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF FFFF FFFF FFFF"
};

resource 'icl4' (128) {
	$"0000 0000 0000 000F 0000 0000 0000 0000"
	$"0000 0000 0000 00FC F000 0000 0000 0000"
	$"0000 0000 0000 0FCC CF00 0000 0000 0000"
	$"0000 0000 0000 FCCD CCF0 0000 0000 0000"
	$"0000 0000 000F CCDD DCCF 0000 0000 0000"
	$"0000 0000 00FC CDDD DDCC F000 0000 0000"
	$"0000 0000 0FCC DDDD DDDC CF00 0000 0000"
	$"0000 0000 FCCD DDDD DDDD CCF0 0000 0000"
	$"0000 000F CCDD DDDD DDDD DCCF 0000 0000"
	$"0000 00FC CDDD DDDD DDDD DDCC F000 0000"
	$"0000 0FCC DDDD DDDD DDDD DDDC CF00 0000"
	$"0000 FCCD DDDD DDDD DDDD DDDD CCF0 0000"
	$"000F CCDD DDDD DDDD DDDD DDDD DCCF 0000"
	$"00FC CDDD DDDD DDDD DDDD DDDD DDCC F000"
	$"0FCC DDDD DDDD DDDD DDFF FFFF DDDC CF00"
	$"FCCD DDDD DDDD DDDD DF10 0010 FDDD CCF0"
	$"0FEE DDDD DDDD DDDD F000 1000 1FDD DCCF"
	$"00FE EDDD DDDD DDDF 00FF 0010 00FD EEF0"
	$"000F EEDD DDDD DDDF FF00 F000 100F EF00"
	$"0000 FEED DDDF FFF0 0FFF FFFF F010 FFFF"
	$"0000 0FEE DDDD DDF0 10FF 1000 1000 1FFF"
	$"0000 00FE EDDD DDDF 0010 0010 0010 0FFF"
	$"0000 000F EEDD DDDD F000 1000 1000 1FFF"
	$"0000 0000 FEED DDDD DFF0 0010 0010 0FFF"
	$"0000 0000 0FEE DDDD DDDF FFFF FFF0 1FFF"
	$"0000 0000 00FE EDDD DDDD EEF0 000F FFFF"
	$"0000 0000 000F EEDD DDDE EF00 0000 FFFF"
	$"0000 0000 0000 FEED DDEE F000 0000 0000"
	$"0000 0000 0000 0FEE DEEF 0000 0000 0000"
	$"0000 0000 0000 00FE EEF0 0000 0000 0000"
	$"0000 0000 0000 000F EF00 0000 0000 0000"
	$"0000 0000 0000 0000 F0"
};

resource 'icl4' (129) {
	$"000F FFFF FFFF FFFF FFFF FF00 0000 0000"
	$"000F 0000 0000 0000 0000 0FF0 0000 0000"
	$"000F 0CCC CCCC CCCC CCCC CF0F 0000 0000"
	$"000F 0CCC CCCC CCCC CCCC CF00 F000 0000"
	$"000F 0CCC CCCC CCCC CCCC CF00 0F00 0000"
	$"000F 0CCC CCCC CCCC CCCC CF00 00F0 0000"
	$"000F 0CCC CCCC CCCC CCCC CFFF FFFF 0000"
	$"000F 0CCC FFFF FCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC FFFF FCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC FFFF FFFF FFFF FFFC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC FFFF FFFF FFFF FFFC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC FFFF FFFF FFFF FFFC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC FFFF FFFF FFFF FFFC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC FFFF FFFF FFFF FFFC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CFFF FFFC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F DDDD DDDD DDDD DDDD DDDD DDDF 0000"
	$"000F FFFF FFFF FFFF FFFF FFFF FFFF"
};

resource 'icl4' (130) {
	$"000F FFFF FFFF FFFF FFFF FF00 0000 0000"
	$"000F 0000 0000 0000 0000 0FF0 0000 0000"
	$"000F 0CCC CCCC CCCC CCCC CF0F 0000 0000"
	$"000F 0CCC CCCC CCCC CCCC CF00 F000 0000"
	$"000F 0CCC CCCC CCCC CCCC CF00 0F00 0000"
	$"000F 0CCC CCCC CCCC CCCC CF00 00F0 0000"
	$"000F 0CCC CCCC CCCC CCCC CFFF FFFF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCF FFFF FFFF FFFF FFFF CCDF 0000"
	$"000F 0CCF FBBB BBBB BBBB BBFF CCDF 0000"
	$"000F 0CCF BFFF FFFF FFFF FFBF CCDF 0000"
	$"000F 0CCF BF77 7777 7777 7FBF CCDF 0000"
	$"000F 0CCF BF77 7F77 7777 7FBF CCDF 0000"
	$"000F 0CCF BF77 F0F7 7777 7FBF CCDF 0000"
	$"000F 0CCF BF7F 0F0F 7777 7FBF CCDF 0000"
	$"000F 0CCF BF7F 0F0F 7FFF 7FBF CCDF 0000"
	$"000F 0CCF BF7F 000F 7F0F 7FBF CCDF 0000"
	$"000F 0CCF BF7F 000F 7F0F 7FBF CCDF 0000"
	$"000F 0CCF BFFF FFFF FFFF FFBF CCDF 0000"
	$"000F 0CCF BF88 8888 8888 8FBF CCDF 0000"
	$"000F 0CCF BFFF FFFF FFFF FFBF CCDF 0000"
	$"000F 0CCF FBBB BBBB BBBB BBFF CCDF 0000"
	$"000F 0CCF FFFF FFFF FFFF FFFF CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F 0CCC CCCC CCCC CCCC CCCC CCDF 0000"
	$"000F DDDD DDDD DDDD DDDD DDDD DDDF 0000"
	$"000F FFFF FFFF FFFF FFFF FFFF FFFF"
};

resource 'ics8' (128) {
	$"0000 0000 0000 00FF FF00 0000 0000 0000"
	$"0000 0000 0000 FF2B 2BFF 0000 0000 0000"
	$"0000 0000 00FF 2BF9 F92B FF00 0000 0000"
	$"0000 0000 FF2B F9F9 F9F9 2BFF 0000 0000"
	$"0000 00FF 2BF9 F9F9 F9F9 F92B FF00 0000"
	$"0000 FF2B F9F9 F9F9 F9F9 F9F9 2BFF 0000"
	$"00FF 2BF9 F9F9 F9F9 F9F9 F9F9 F92B FF00"
	$"FF2B F9F9 F9F9 F9F9 FFFF FFFF FFF9 2BFF"
	$"FFFC F9F9 F9F9 F9FF 0800 0800 FFFF FCFF"
	$"00FF FCF9 F9FF FFFF FFFF FF08 00FF FFFF"
	$"0000 FFFC F9F9 F9FF 0800 0800 0800 FFFF"
	$"0000 00FF FCF9 F9F9 FF08 0008 0008 FFFF"
	$"0000 0000 FFFC F9F9 F9FF FFFF FFFF FFFF"
	$"0000 0000 00FF FCF9 F9FC FF00 0000 FFFF"
	$"0000 0000 0000 FFFC FCFF 0000 0000 0000"
	$"0000 0000 0000 00FF FF"
};

resource 'ics8' (129) {
	$"00FF FFFF FFFF FFFF FFFF FF00 0000 0000"
	$"00FF F5F5 F5F5 F5F5 F5F5 FFFF 0000 0000"
	$"00FF F52B 2B2B 2B2B 2B2B FF00 FF00 0000"
	$"00FF F52B 2B2B 2B2B 2B2B FFFF FFFF 0000"
	$"00FF F52B FFFF 2B2B 2B2B 2B2B F9FF 0000"
	$"00FF F52B 2B2B 2B2B 2B2B 2B2B F9FF 0000"
	$"00FF F52B FFFF FFFF FFFF FF2B F9FF 0000"
	$"00FF F52B 2B2B 2B2B 2B2B 2B2B F9FF 0000"
	$"00FF F52B FFFF FFFF FFFF FF2B F9FF 0000"
	$"00FF F52B 2B2B 2B2B 2B2B 2B2B F9FF 0000"
	$"00FF F52B FFFF FFFF FFFF FF2B F9FF 0000"
	$"00FF F52B 2B2B 2B2B 2B2B 2B2B F9FF 0000"
	$"00FF F52B 2B2B 2B2B FFFF FF2B F9FF 0000"
	$"00FF F52B 2B2B 2B2B 2B2B 2B2B F9FF 0000"
	$"00FF F9F9 F9F9 F9F9 F9F9 F9F9 F9FF 0000"
	$"00FF FFFF FFFF FFFF FFFF FFFF FFFF"
};

resource 'ics8' (130) {
	$"00FF FFFF FFFF FFFF FFFF FF00 0000 0000"
	$"00FF F5F5 F5F5 F5F5 F5F5 FFFF 0000 0000"
	$"00FF F52B 2B2B 2B2B 2B2B FF00 FF00 0000"
	$"00FF F52B 2B2B 2B2B 2B2B FFFF FFFF 0000"
	$"00FF F52B 2B2B 2B2B 2B2B 2B2B F9FF 0000"
	$"00FF F55E 5E5E 5E5E 5E5E 5E2B F9FF 0000"
	$"00FF F55E C0C0 C0C0 C0C0 892B F9FF 0000"
	$"00FF F55E C0C0 FFFF FFC0 892B F9FF 0000"
	$"00FF F55E C0FF FFFF FFC0 892B F9FF 0000"
	$"00FF F55E C0FF FFFF FFC0 892B F9FF 0000"
	$"00FF F55E CBCB CBCB CBCB 892B F9FF 0000"
	$"00FF F55E 8989 8989 8989 892B F9FF 0000"
	$"00FF F52B 2B2B 2B2B 2B2B 2B2B F9FF 0000"
	$"00FF F52B 2B2B 2B2B 2B2B 2B2B F9FF 0000"
	$"00FF F9F9 F9F9 F9F9 F9F9 F9F9 F9FF 0000"
	$"00FF FFFF FFFF FFFF FFFF FFFF FFFF"
};

resource 'vers' (2) {
	0x1,
	0x40,
	release,
	0x0,
	0,
	"1.4",
	"Navigation Services Sample"
};

resource 'vers' (1) {
	0x1,
	0x40,
	release,
	0x0,
	0,
	"1.4",
	"1.4, © 1996-2001, Apple Computer, Inc."
};

resource 'CNTL' (132, "customization popup") {
	{185, 111, 204, 357},
	0,
	visible,
	87,
	135,
	1008,
	0,
	"Commands:"
};

resource 'CNTL' (133, "list box control") {
	{29, 12, 115, 286},
	133,
	visible,
	0,
	0,
	kControlListBoxProc,
	0,
	""
};

resource 'dlgx' (131, "About dialog") {
	versionZero {
		9
	}
};

resource 'mctb' (131) {
	{	/* array MCTBArray: 1 elements */
		/* [1] */
		mctbLast, 0,
		{	/* array: 4 elements */
			/* [1] */
			0, 0, 0,
			/* [2] */
			0, 0, 0,
			/* [3] */
			0, 0, 0,
			/* [4] */
			0, 0, 0
		}
	}
};

resource 'PICT' (128) {
	15728,
	{0, 0, 89, 134},
	$"0011 02FF 0C00 FFFE 9554 0048 0000 0048"
	$"0000 0000 0000 0059 0086 3FA9 8BBC 001E"
	$"0001 000A 0000 0000 0059 0086 009B 0000"
	$"00FF 8218 0000 0000 0059 0086 0000 0004"
	$"0000 0000 0048 0000 0048 0000 0010 0020"
	$"0003 0008 0000 0000 065D 9FAC 0000 0000"
	$"0000 0000 0059 0086 0000 0000 0059 0086"
	$"0040 000A 0000 0000 0059 0086 001D C93A"
	$"05CC CCD3 E9F8 DA81 3A05 A5BE CCDA F8CC"
	$"813A 05B0 A5CC E9F8 BEB9 3A00 1DC8 3A00"
	$"C5FD 3A01 E2E2 823A 00B0 FD3A 01DA DA82"
	$"3A00 9EFD 3A01 DADA BB3A 0015 C33A 027B"
	$"BEB0 813A FD3A 019E 9781 3AFD 3A00 BEBB"
	$"3A00 0AC3 3A00 7B81 3A81 3AAE 3A00 20C9"
	$"3A01 F8F0 FE3A 0197 9E82 3A01 F8F0 FE3A"
	$"0189 8982 3A01 F8E9 FE3A 0174 89BA 3A00"
	$"1DC8 3A05 BE7B A5A5 B0B0 813A 05B0 3A89"
	$"8997 9081 3A05 B73A 7B7B 9082 BA3A 001C"
	$"C73A 009E FE97 00B0 813A 053A 747B 8282"
	$"9781 3A05 3A5E 7482 8290 BA3A 0018 C63A"
	$"02A5 9790 813A FE3A 0289 826C 813A FE3A"
	$"027B 826C B93A 0008 813A 813A 813A EF3A"
	$"0008 813A 813A 813A EF3A 0012 C23A 00FF"
	$"813A FC3A 00FF 813A FC3A 00E9 BB3A 0015"
	$"C23A 01BE F881 3AFD 3A01 97E9 813A FD3A"
	$"0197 F0BC 3A00 21C4 3A03 6C3A 3AF0 F43A"
	$"02FF FF6C 8C3A 00F0 F43A 01FF FF8B 3A00"
	$"E9F4 3A01 FFFF CB3A 0034 C73A 07BE 3AB0"
	$"BE89 3A3A 9EF6 3AFC F800 BE94 3A03 9E3A"
	$"89A5 FE3A 0074 F63A FCF8 009E 913A 0097"
	$"FE3A 006C F63A 04F8 FFF8 F8FF CD3A 0049"
	$"C73A 066C B0E9 895E 3A9E FD3A 0C7B A5FF"
	$"FFF8 FFFF F8FF F8F8 F0B0 923A 0189 E2FE"
	$"3A00 82FB 3A0A FFFF F8FF FFF8 FFF8 FFF0"
	$"9792 3A01 6CD3 FE3A 006C FB3A 09F0 FFF8"
	$"FFE9 FFFF F8FF E9CC 3A00 3FC4 3A01 6C9E"
	$"FB3A 0597 F8F8 FFFF F8FD FF05 F8FF E93A"
	$"3AB0 923A 0082 FA3A 04F8 F8FF FFF8 FDFF"
	$"05F8 FFE9 3A3A 8992 3A00 56FA 3A04 F8E2"
	$"FFFF F8FC FF01 F8F0 CD3A 003B BD3A 0897"
	$"F089 3A97 C5F0 E23A FCF8 03F0 C5DA C58C"
	$"3A00 F0FE 3A03 B0F0 DA3A FCF8 03F0 B7CC"
	$"BE8C 3A00 E9FE 3A0C 9EE9 CC3A F8F8 FFF8"
	$"F8E9 B0BE BED1 3A00 4BC8 3A00 5EFA 3A08"
	$"9EBE B0DA 9E89 DAE9 B0FC 3A07 E9F8 F8FF"
	$"F8DA E2F0 913A 0882 9E97 CC74 3ACC E290"
	$"FC3A 07E9 F8F8 FFF8 D3DA F091 3A08 6C89"
	$"90B0 5E3A BED3 5EFC 3A07 F0F8 F8F0 F8D3"
	$"CCE9 D23A 0051 C93A 037B 9789 5EFD 3A08"
	$"A5B0 BEBE CCB0 896C 7BFB 3A08 89F8 FFF8"
	$"F8FF F0F8 9E9A 3A00 7BFB 3A05 899E A5A5"
	$"C589 F73A 07F8 FFF8 F8FF F0F8 9799 3A00"
	$"65FC 3A05 7B82 9797 C56C F73A 07F8 F0F8"
	$"F8FF E9F8 89D3 3A00 66CA 3A0A 89BE 3A5E"
	$"5E82 3A3A 9EB0 B0FE BE0B F03A 8989 C55E"
	$"C5B0 89B0 6C3A FBF8 00CC 9B3A 009E FE3A"
	$"096C 3A3A 7497 9E9E A5A5 F0FE 3A07 B03A"
	$"BE97 3A97 3A3A FBF8 00C5 9B3A 007B FE3A"
	$"095E 3A3A 6C74 8289 9797 E9FE 3A08 9E3A"
	$"BE3A 3A90 3A3A F8FE FF02 F8F8 C5D3 3A00"
	$"61CB 3A06 6CFF DA90 5ED3 5EFD 3A08 B0BE"
	$"BEC5 9E7B 3AB0 F8FD 3A04 5E7B 903A 89FD"
	$"F800 E99C 3A04 FFBE 6C3A C5FC 3A08 9EA5"
	$"A5B0 7448 3A89 F8FB 3A02 5E3A 3AFD F800"
	$"DA9C 3A04 F8B0 5E3A 9EFC 3A04 8297 9790"
	$"6CFE 3A00 E2FB 3A02 6C3A 3AFE FF01 F8E9"
	$"D33A 0051 CB3A 03CC E290 9EFC 3A09 B048"
	$"487B BEB0 976C 896C FA3A 076C 5E5E 3AE2"
	$"F8F0 F89D 3A03 B7DA 6C82 FC3A 0689 3A3A"
	$"5E97 977B F33A 03CC F8F0 F89D 3A03 82CC"
	$"6C56 FC3A 066C 3A3A 4197 9074 F33A 03E2"
	$"FFE9 F8D3 3A00 5BCC 3A05 89E2 DABE B0B0"
	$"FE3A 069E 9EB0 B048 4890 FB3A 00B0 FB3A"
	$"056C 9E3A 3AF8 F89D 3A04 DABE 9E89 90FE"
	$"3A06 8282 9797 3A3A 6CFB 3A00 5EFA 3A04"
	$"743A 3AF8 F89E 3A05 65B7 B089 6C5E FE3A"
	$"066C 5674 743A 3A7B F33A 047B 3A3A F8F8"
	$"D33A 0056 CC3A FDBE 093A 6C3A 7B9E 899E"
	$"9EB0 6CFD 3A00 6CFE 3A01 CC6C FA3A 0389"
	$"3A3A C59E 3A03 9E9E 909E FD3A 0474 7482"
	$"8297 F83A 01A5 48FA 3A03 743A 3AB7 9E3A"
	$"037B 3A6C 89FD 3A04 6C56 6C6C 74F8 3A00"
	$"89F9 3A03 823A 3AB0 D33A 0042 CD3A 0EF8"
	$"F8BE 895E B0B0 BE97 8989 9082 8990 F93A"
	$"005E F93A 005E 9C3A 07E9 E99E 3A41 8989"
	$"9EFE 3A03 6C5E 566C F93A 0048 933A 05F0"
	$"F03A 6582 90FC 3A03 6C5E 3A6C BE3A 0043"
	$"D23A 1497 FFF8 FFFF DAFF BEBE D3DA 89BE"
	$"F8FF 9797 B089 8997 903A 1448 FFF8 FFFF"
	$"CCFF 9E9E A5B7 569E F8FF 6C3A 973A 3A7B"
	$"8F3A 0DFF F8F8 FFBE FF3A 3A7B 973A 3AF8"
	$"F0B9 3A00 55D4 3AFD FF01 D3E9 FEFF 0EE2"
	$"E2FF CCE2 E2F8 FFFF 896C F0F8 3A97 F23A"
	$"0048 FE3A 0048 A73A FDFF 01C5 E9FE FF0E"
	$"CCCC FFB7 CCDA F8FF FF3A 3AE9 E93A 7B93"
	$"3A15 FFFF F8FF B7E2 FFF8 FF9E 9EE9 829E"
	$"DAF8 F0FF 3A3A CCF0 BE3A 0063 D53A 0CF0"
	$"3AF8 F8FF F0E2 E2DA FFE2 FFF0 FEE2 09F8"
	$"F8FF FF7B FFF8 3A97 A5F0 3A01 487B A83A"
	$"19F0 3AF8 F8FF E9DA CCCC FFDA FFF0 DACC"
	$"DAF8 E9FF FF3A FFE9 3A56 7BEF 3A00 5EA8"
	$"3A0C E93A F8F8 FFCC DACC BEFF CCFF E9FE"
	$"CC06 F8F0 F8FF 3AF0 F0EC 3A00 4FD4 3A00"
	$"6DD4 3A18 5E3A BEFF 979E E2B0 F8D3 DAF0"
	$"D3F0 E2E2 F8E9 E9D3 89F8 CCB0 BEFC 3A00"
	$"48FC 3A01 829E FD3A 006C A43A 169E FF3A"
	$"74DA 90E9 C5CC F0CC F0CC DAF8 E2E2 CC3A"
	$"E9B7 9790 F63A 015E 82FD 3A00 56A4 3A16"
	$"B0FF 3A7B CC82 F0B7 BEDA CCE9 9EDA F8D3"
	$"D3CC 3AF0 8274 6CF6 3A01 5E56 CE3A 0071"
	$"D73A 1B48 3A97 D35E 7BE2 BE9E B0B0 CCE9"
	$"F0E9 DAD3 DAE2 CCC5 DAFF 7BF0 B097 9EFA"
	$"3A03 4889 6C65 FD3A 0048 A53A 1956 C53A"
	$"3ADA A574 9789 B7E2 F0E2 D3C5 CCDA BEB0"
	$"CCFF 3AF0 977B 74F9 3A02 743A 4F9F 3A18"
	$"B73A 3ADA 9741 906C 97D3 E9D3 D3B7 BECC"
	$"A590 B0F0 3AFF 903A 5EF9 3A02 653A 41CC"
	$"3A00 6AD8 3A1B 7BB0 899E F86C A5C5 9E90"
	$"B0BE BECC D3E9 E9E2 D3E9 E2CC DAFF 896C"
	$"F87B F93A 0248 5E5E FD3A 025E 4848 A83A"
	$"1997 4174 F83A 7BB0 7B5E 979E A5BE C5E2"
	$"E2DA C5E2 DAB7 CCFF 3A3A F8F6 3A00 48A0"
	$"3A18 4841 F83A 3A9E 896C 907B 97A5 B7D3"
	$"D3CC B7D3 CC97 BEF0 3A3A E2BF 3A00 5CD7"
	$"3A0F A589 9E5E 89BE 899E 9EC5 89C5 B0BE"
	$"B0CC FEDA 07D3 C5E9 E9FF 97B0 89F2 3A02"
	$"5E3A 48A8 3A0F 7B3A 743A 3A9E 3A89 74B7"
	$"3AB7 9EA5 90C5 FECC 06C5 B7E9 E2FF 3A89"
	$"933A 0D41 3A3A 7B3A 895E B03A B09E 9782"
	$"C5FE BE04 B7B0 E2D3 FFBD 3A00 80D9 3A1D"
	$"FFFF D3E9 F097 7B9E 9E7B 6C3A 3ABE B0B0"
	$"97CC B0CC E2CC D3FF BEB0 8997 5E5E F93A"
	$"006C FD3A 0248 4F6C FB3A 02B0 F8F8 B23A"
	$"1BFF FFC5 E9F0 564F 8274 3A41 3A3A 9E89"
	$"893A A597 BEDA C5CC FF9E 9748 6CF1 3A01"
	$"4848 FB3A 029E F8F8 B23A 19FF FFB7 F0DA"
	$"3A5E 6C6C 3A5E 3A3A 896C 903A B090 A5DA"
	$"C5CC F089 90E7 3A02 9EF8 F8DA 3A00 68DA"
	$"3A0A F8FF C5F8 E9B0 9E89 9E5E 48FE 3A10"
	$"6C7B 7BB0 C5CC C56C E2E2 BEDA 3A5E 6C3A"
	$"89F4 3A03 4856 5E48 AB3A 08F8 FFB7 F8E9"
	$"8982 4874 F93A 0890 B7BE B03A CCDA 9ECC"
	$"FD3A 0065 F33A 0141 48AA 3A08 FFFF B0E2"
	$"E23A 6C3A 6CF9 3A08 82B0 A590 3ACC CC7B"
	$"BEEE 3A00 41D0 3A00 7EDA 3A07 F8E2 E2DA"
	$"B0A5 B097 FE7B 173A 483A 895E 7B3A 7B90"
	$"8997 97B0 DACC 3A5E 8989 9789 745E 5EF9"
	$"3A03 4848 6C48 FC3A 00E2 B03A 0AF8 DADA"
	$"D39E 7B90 563A 3A48 FE3A 005E FD3A 0D6C"
	$"3A56 6C97 CCB7 3A3A 483A 6C3A 56F5 3A00"
	$"48FB 3A00 CCB0 3A06 F8DA B7D3 823A 5EFA"
	$"3A00 48FD 3A00 6CFE 3A02 74B0 97FB 3A00"
	$"48EE 3A00 E2D7 3A00 81DA 3A23 E2F0 897B"
	$"9097 A589 7B7B 483A 483A 827B 9E89 9E7B"
	$"97B0 89CC B07B BEA5 6C89 893A 5E48 3A48"
	$"F83A 005E FB3A 03B0 7B3A 74B3 3A09 CCF0"
	$"3A3A 5E6C 893A 3A48 FD3A 104F 5E82 6582"
	$"3A48 5E3A B75E 3A9E 893A 5648 F33A 0056"
	$"FB3A 039E 3A3A 6CB3 3A06 E2E9 3A3A 6C3A"
	$"7BFA 3A04 414F 6C3A 56FD 3A00 97FE 3A00"
	$"7BE9 3A03 B03A 3A6C DA3A 0074 DB3A 05F8"
	$"FFF8 A5B0 97FE 8900 6CFD 3A0C 5E5E 89BE"
	$"B097 897B 9789 F8A5 E2FE DA0E 3A3A 5E5E"
	$"7B5E 483A 3A48 5E4F 486C 5EFA 3A01 6C89"
	$"B13A 08F8 FFF8 8989 6C56 6574 F93A 0290"
	$"906C FD3A 05F8 3ADA D3B7 CCFD 3A00 48FB"
	$"3A03 483A 4848 A83A FEF8 007B FD3A 0056"
	$"F93A 016C 82FC 3A05 E23A DAD3 97BE BF3A"
	$"008C DC3A 09E9 F89E 97DA D37B 3A48 90FB"
	$"3A1E F8FF F8FF FFB0 3A7B 7BB0 5E5E B0CC"
	$"DAC5 3A3A 7B3A 7B3A 483A 3A5E 4F5E 657B"
	$"5EFC 3A03 E97B B77B B33A 05E2 F874 48D3"
	$"C5FE 3A00 6CFB 3A00 F8FD FF00 90FE 3A06"
	$"893A 3A5E A5B7 B0F7 3A03 483A 4F5E FB3A"
	$"03E9 3AA5 48B3 3A05 D3F8 5E3A D3B7 FE3A"
	$"005E FB3A 05F8 FFFF F8FF 5EFA 3A02 B097"
	$"90F5 3A01 414F FB3A 02F0 3AA5 D73A 008F"
	$"DC3A 0FDA B0A5 B09E 6C6C 5E48 973A 3A97"
	$"3A3A CCFD FF1A DABE B06C 97BE A53A 3A89"
	$"C5A5 FF48 3A3A 6C6C 7448 485E 5E48 6C5E"
	$"6CFB 3A01 DA97 B23A 0FCC 907B 9774 3A48"
	$"3A3A 6C3A 3A56 3A3A BEFD FF05 CC9E 973A"
	$"7B82 FD3A 02B0 89FF FC3A 0856 3A3A 483A"
	$"3A56 4856 FB3A 01CC 48B2 3A04 BE82 3A90"
	$"41F7 3A00 A5FE FF02 F8BE 89FE 3A00 48FD"
	$"3A02 9E7B F0FC 3A00 48F3 3A00 BED6 3A00"
	$"91DD 3A09 97C5 E9E9 9E7B E965 489E FE3A"
	$"216C 3A3A 5EFF F8FF F8DA 5E97 6C97 976C"
	$"975E 82A5 C5BE E9E9 5E5E 485E 654F 5E5E"
	$"3A5E 6CF9 3A01 5EE9 B43A 096C BEE2 E274"
	$"3ADA 4F3A 82FA 3AFE FF01 F8CC FD3A 006C"
	$"FE3A 054F 7BB0 B0E9 E9FD 3A06 4148 5648"
	$"3A3A 4FF8 3A00 E2B4 3A09 89BE D3D3 7B3A"
	$"E941 3A6C FA3A FEFF 01F8 BEF9 3A05 413A"
	$"90B7 E2E2 FD3A 0041 FC3A 005E F83A 00D3"
	$"D83A 009C DD3A 2E89 9EDA DA97 89B0 3A82"
	$"483A 3A90 5E3A 3A6C 3AFF FFF8 7B3A 9789"
	$"7B97 9789 893A 3ADA E9CC D3D3 9789 6C7B"
	$"5E3A 7B6C 5E56 FD3A 04E2 8989 4897 B23A"
	$"077B CCD3 3A3A 9E3A 4FFE 3A00 5EFC 3A02"
	$"FFFF F8FA 3A00 5EFE 3A0E D3E9 C5C5 CC48"
	$"653A 5E3A 3A48 563A 41FD 3A00 DAFE 3A00"
	$"56B2 3A07 89BE D33A 3A9E 3A41 FE3A 005E"
	$"FC3A 02FF FFF8 FA3A 0048 FE3A 04D3 E2C5"
	$"B7CC FE3A 0041 FC3A 0041 FD3A 00DA D33A"
	$"0093 DC3A 0E90 B089 897B 903A 3A6C 6C97"
	$"6C6C 3A7B FE3A 1BD3 9E3A DABE 896C A597"
	$"6C5E 977B D3E2 E9C5 6CA5 5E74 6C6C 6556"
	$"6C6C 48FE 3A06 7BE9 976C 9797 7BB3 3A05"
	$"5E90 5E3A 3A6C FD3A 0248 3A48 FC3A 04A5"
	$"743A D3B0 FC3A 0F48 3A5E CCDA E2B7 3A89"
	$"3A48 483A 4F41 48FB 3A03 E256 3A56 B13A"
	$"056C 8248 3A3A 5EF5 3A04 7B7B 3AD3 B7FA"
	$"3A0C 4FCC DAD3 B03A 7B3A 483A 3A41 41FA"
	$"3A00 D3D3 3A00 8DDD 3A2B FFD3 89B0 3A3A"
	$"973A 90DA 9797 485E 6C89 9E6C 97BE CCBE"
	$"973A 3AA5 97A5 9790 6CB0 97E9 977B 7B5E"
	$"5E6C 485E 4856 FB3A 025E E9A5 B03A 0AFF"
	$"CC3A 893A 3A7B 3A6C CC6C FD3A 0756 743A"
	$"3A82 909E 82FB 3A07 6C3A 896C E282 3A48"
	$"FB3A 0041 FA3A 01E9 89B0 3A09 FFCC 6590"
	$"3A3A 653A 5EBE FB3A 0641 3A3A 485E 3A82"
	$"FB3A 005E FE3A 01D3 82F9 3A00 41FA 3A01"
	$"E27B D43A 0085 DD3A 1448 895E F85E 977B"
	$"3AE9 97A5 9E7B 977B 6C6C 3A6C 6CB0 FC3A"
	$"10BE 8989 9090 C590 893A 3A5E 906C 5EE2"
	$"4848 FC3A 046C 3A3A 657B AD3A 0DF8 3A6C"
	$"3A3A E256 8982 3A3A 5E48 4FFE 3A00 5EFC"
	$"3A06 9E65 745E 5EBE 6CFD 3A03 6C3A 3ADA"
	$"F73A 0041 AC3A 00E2 FD3A 08D3 3A7B 6C3A"
	$"3A41 3A5E F83A 067B 3A56 5E6C BE5E FD3A"
	$"034F 3A3A CCF7 3A00 41D3 3A00 80DE 3A02"
	$"6C5E 97FE FF0F 6C97 DA97 3A97 977B 3A3A"
	$"6C5E 3A3A 895E FB3A 117B 5E89 CCD3 DA7B"
	$"3A6C 6C9E 905E 7B7B 9EE9 E2FE 3A02 484F"
	$"74AC 3AFE FF05 3A56 CC6C 3A6C FD3A 0048"
	$"FE3A 0065 FA3A 0548 3A41 C5CC D3FD 3A01"
	$"746C FE3A 0274 DADA FD3A 0148 5EAC 3AFE"
	$"F802 3A3A B0EC 3A03 48C5 CCD3 FD3A 016C"
	$"5EFE 3A02 5EE9 CCFC 3A00 6CD2 3A00 89DF"
	$"3A03 7B89 7BDA FEFF 0EA5 9E6C B76C 6C7B"
	$"6C7B 3A3A 893A 4890 FE3A 006C FE3A 1689"
	$"3A3A B0DA 6C97 3A97 3A89 A589 B75E 6CE9"
	$"D33A 5E3A 3A7B AF3A 034F 3A3A DAFE FF03"
	$"3A74 3AA5 FA3A 0365 3A3A 6CF7 3A0E 89D3"
	$"3A7B 3A6C 3A3A 8965 973A 3ADA CCFD 3A00"
	$"5EAF 3A03 5E3A 3AE9 FEFF 033A 413A A5F7"
	$"3A00 5EF7 3A01 90D3 FB3A 067B 3AA5 3A3A"
	$"E9CC FD3A 004F D13A 0088 DF3A 0D9E 3A9E"
	$"F0E9 F8FF 97B0 97C5 487B 6CFE 3A08 823A"
	$"3A89 9782 3A4F 97FC 3A13 6C89 B097 7BC5"
	$"903A 3A9E 90BE FFE9 F0DA 5E7B 3A48 AE3A"
	$"0A90 3A82 E9E2 F8FF 3A5E 3AB0 FB3A 005E"
	$"FE3A 036C 6C3A 48FA 3A0E 5690 7B3A B06C"
	$"3A3A 825E A5FF E9F0 CCAA 3A06 973A 56CC"
	$"D3F8 FFFE 3A00 9EFB 3A00 5EFD 3A00 48F7"
	$"3A0D 9E3A 3A9E 6C3A 3A56 6C97 F8E2 DABE"
	$"CC3A 0079 DD3A 1989 8990 E990 7BB0 B07B"
	$"485E 3A3A 5E6C 3A89 5E97 A590 7B89 973A"
	$"5EFD 3A00 9EFD 3A09 6C82 5E90 9EC5 E9CC"
	$"B0BE FE3A 005E AC3A 0765 3A7B E26C 485E"
	$"89FB 3A00 48FE 3A05 567B 6C48 566C FB3A"
	$"0074 FD3A 0941 5E3A 6C74 B7E9 A59E A5A7"
	$"3A03 6589 D34F F23A 006C F83A 005E FD3A"
	$"094F 6C3A 4F5E B0E2 899E 97CC 3A00 82DE"
	$"3A1C 6C90 9082 8248 8989 3A7B 896C 3A3A"
	$"6C5E 7B6C 895E 9EB0 9E9E 6C48 3A3A 6CFE"
	$"3A01 897B FE3A 0B65 4856 90B7 B0BE 97BE"
	$"B06C 65AC 3A04 4889 895E 6CFD 3A00 48FA"
	$"3A06 483A 3A82 9E89 74F9 3A01 655E FE3A"
	$"0B41 3A41 6CA5 899E 569E 973A 41AB 3A03"
	$"8989 6C7B F23A 0356 8289 41F9 3A01 5641"
	$"FE3A 0B41 3A41 4FA5 6C89 3A7B 903A 41CF"
	$"3A00 86E0 3A1E F897 3A90 9797 483A 3A6C"
	$"893A 5E74 7B3A 7B6C FF6C 483A 7B89 9E97"
	$"483A 3A5E B7FE 3A01 9097 FE3A 0497 743A"
	$"5E97 FD89 AB3A 05F8 563A 8989 82FD 3A04"
	$"5E3A 3A56 48FE 3A00 FFFD 3A02 5674 89FD"
	$"3A00 4FFE 3A01 6C7B FE3A 017B 5EFD 3A00"
	$"48A9 3A05 F83A 3A89 7482 FD3A 0348 3A3A"
	$"48FD 3A00 FFFC 3A01 6C74 FD3A 0041 FE3A"
	$"006C FD3A 0165 5EC5 3A00 97E0 3A17 FFE2"
	$"896C 823A 4F3A 487B 896C 6C5E 6C3A 6CFF"
	$"BE5E 7B89 B09E FEB0 033A 3A89 BEFE 6C05"
	$"899E CC3A 7B89 FE3A 0789 9790 899E 9ED3"
	$"6CAE 3A0A FFDA 3A4F 6C3A 483A 3A5E 5EFB"
	$"3A01 FF9E FE3A 1090 8297 8989 3A3A 4882"
	$"3A3A 563A 82C5 3A48 FD3A 0748 3A6C 5E74"
	$"82CC 41AE 3A04 FFB7 655E 7BFD 3A01 4148"
	$"FB3A 01FF 7BFE 3A04 8256 746C 6CFE 3A00"
	$"48FE 3A02 656C C5F9 3A05 4F48 4156 CC5E"
	$"CF3A 0072 E13A FDFF FC3A 0748 8289 3A7B"
	$"7B89 48FE 3A0C 897B 6C5E 8997 6C9E 9E48"
	$"3AA5 7BFE 3A05 8982 8974 9E5E FE3A 0689"
	$"8997 E9E9 F89E AF3A FDFF FB3A 016C 65F4"
	$"3A06 483A 8274 3A3A 7BFD 3A04 656C 6556"
	$"82FB 3A04 48E2 E9F8 7BAF 3AFD FFFB 3A00"
	$"48F1 3A01 6C7B F93A 035E 3A48 6CFA 3A03"
	$"D3E2 E289 CF3A 0087 E23A FCFF FB3A FE5E"
	$"0889 9089 899E 9797 F8FF FD6C 0DCC 979E"
	$"6C3A 3A97 3A3A 6C7B 9E7B 74FB 3A06 D3DA"
	$"FFFF E9D3 7BB1 3AFC FFFB 3A0B 563A 3A5E"
	$"6C65 4174 5656 F8FF FD3A 02B7 6C82 FE3A"
	$"007B FE3A 0348 8248 6CFB 3A05 CCBE FFFF"
	$"E9CC B03A FDFF 00F0 F83A 0848 5E3A 486C"
	$"3A3A F8F8 FD3A 0282 3A6C FE3A 0074 FD3A"
	$"0256 3A5E FB3A 05CC B0FF FFE2 CCCF 3A00"
	$"8FE3 3A01 5EF8 FEFF FB3A 1265 5E9E 8289"
	$"9089 82B0 CCD3 DAF8 5E6C 7B5E E2BE FE89"
	$"065E 3AA5 3A3A 7B74 FA3A 07F0 F0FF F8F8"
	$"E9D3 5EB1 3A00 E9FE FFFB 3A0C 4F48 746C"
	$"746C 5E5E 90B7 C5D3 F8FD 3A03 DA9E 3A56"
	$"FE3A 0489 3A3A 745E FA3A 06F0 F0FF F8F8"
	$"E9CC B03A 00F0 FEFF FB3A 0C41 3A5E 5E65"
	$"6C48 5E5E C59E D3F8 FD3A 00DA FB3A 047B"
	$"3A3A 745E FA3A 06DA E9FF F8F8 F0E2 CF3A"
	$"0092 E23A 02E9 E9FF FD3A 1FB7 4865 656C"
	$"7B89 8282 979E 97CC CC3A E2E9 7B48 6C9E"
	$"B790 897B 8948 3A48 3A3A 5EFC 3A08 563A"
	$"F8F8 FFF8 F0F0 E2B0 3A02 E2E2 FFFD 3A10"
	$"973A 4141 4F5E 746C 5E7B 747B B7B7 3ADA"
	$"DAFE 3A04 7497 5E65 48F5 3A08 413A F8F8"
	$"FFF8 F0F0 DAB0 3A02 D3D3 FFFD 3A10 A53A"
	$"4141 5E41 565E 5E74 6C74 9782 3ACC E9FE"
	$"3A03 7BA5 6C65 F43A 0841 3AF8 F8FF F8E9"
	$"E9DA CF3A 00B6 E43A 04E9 97B0 3AD3 FD3A"
	$"03FF 3A74 65FE 7B15 9782 829E 9790 977B"
	$"3AB0 9789 8990 7B89 A56C 3ABE 5E6C FA3A"
	$"0974 7B3A 89FF F8F0 E9DA 6CD9 3A09 4841"
	$"4F5E 4F4F 5E4F 5E4F E43A 04E9 5689 3AC5"
	$"FD3A 0CFF 3A48 4F5E 5E65 7B6C 6C82 7B5E"
	$"FE3A 0A9E 7B5E 655E 3A3A 893A 3AB0 F83A"
	$"0848 5E3A 3AFF F8F0 E9D3 D13A FE48 E43A"
	$"00E2 FE3A 00B7 FD3A 02FF 3A48 FE41 0165"
	$"65FE 6C01 746C FE3A 0AB0 7448 3A6C 3A3A"
	$"7B3A 3AB7 F83A 0848 413A 65FF F8E9 F0D3"
	$"D73A 0848 5E5E 4848 5E5E 6C5E 00E5 E43A"
	$"03B0 E23A BEFD 3A08 FF48 3A74 7482 8982"
	$"89FE 9706 B097 E27B 6C89 90FE 9E08 B789"
	$"8997 3A3A 89A5 89FC 3A0A 7B65 5E3A F0E2"
	$"E9E9 C53A 82EC 3A06 414F 4F41 5E48 4FFD"
	$"56F9 5E00 6CF8 5EE4 3A03 9EDA 3A9E FD3A"
	$"0EFF 3A3A 5656 6C74 6C74 7B82 8297 7BDA"
	$"FE3A 0B6C 8990 90A5 5E48 7B3A 3A41 89FB"
	$"3A0A 5E4F 3A3A F0DA E2E9 B03A 6CE8 3A02"
	$"4841 3AFD 41FD 4F06 414F 414F 4F5E 41FA"
	$"5EE4 3A03 9EDA 3A7B FD3A 02FF 3A3A FE48"
	$"0856 5E65 7482 8290 74DA FE3A 0B6C 8997"
	$"97A5 483A 743A 3A48 7BFB 3A0A 4F41 3A3A"
	$"E9DA D3F0 903A 7BEC 3A06 4848 5E48 6C74"
	$"5EFD 74FD 7B0A 8289 827B 7B89 8289 8997"
	$"89FE 9701 00E4 3A01 B09E FB3A 0597 3A4F"
	$"6C74 6CFE 7B1D 89B0 B09E 97B0 9E97 97A5"
	$"909E B0C5 B097 893A 7B9E 48B0 823A 3A97"
	$"7B82 9089 FEFF 04E2 CC5E 3A7B FA3A 0648"
	$"3A41 4F5E 4F56 F95E 076C 6565 5E5E 6C6C"
	$"5EFD 6C04 746C 746C 74FE 6CF9 74E4 3A01"
	$"9E90 F83A 234F 564F 5E3A 3A74 9797 897B"
	$"9E74 7B56 897B 979E B09E 4856 3A3A 903A"
	$"976C 3A3A 895E 6C5E 3AFE FF04 CCA5 3A3A"
	$"65F7 3A03 484F 3A41 FE4F FB5E 0365 655E"
	$"5EFD 6CFE 7404 7B74 7B74 7BFE 74F9 7BE4"
	$"3A01 9E97 F93A 1248 4F48 5E41 3A3A 7490"
	$"9089 749E 7B3A 3A7B 8989 FE9E FD3A 1297"
	$"3A90 483A 3A74 415E 5E3A F8FF FFCC B03A"
	$"3A74 F83A 0456 487B 5E41 FD7B 0189 7BFE"
	$"8901 9090 FD97 019E 97FE A504 B0A5 B0A5"
	$"B0FE A5F9 B001 04E3 3A00 BEFC 3A26 9789"
	$"6C48 746C 827B 899E 9EB0 BEA5 89BE 90B0"
	$"8997 97B0 9E9E B7C5 3A3A B09E 4848 3A3A"
	$"9765 7B9E 7BFD FF08 F8B0 3A97 6565 4F48"
	$"65FE 5E06 6C65 655E 6C5E 5EFD 6CFB 74FC"
	$"8200 7BF9 8204 8982 8989 97FE 89FE 9000"
	$"82E3 3A00 B0F8 3A00 48FE 5E15 3A74 9797"
	$"A589 659E 5E90 3A7B 8297 9790 A5B7 3A3A"
	$"8989 FD3A 0482 565E 743A FDFF 08F8 973A"
	$"8241 413A 4156 FD5E 0465 655E 6C5E FE6C"
	$"0174 74FB 7BFC 8200 89F9 8204 8982 8989"
	$"90FE 89FE 9700 82E3 3A00 B7F8 3A19 484F"
	$"5E41 3A41 8990 977B 3AB0 6C9E 3A74 8290"
	$"8997 A5B0 3A3A 6C89 FD3A 1782 564F 5E3A"
	$"F0FF FFF0 F83A 3A82 4141 5E74 567B 7B89"
	$"8990 90FE 9704 9E97 97A5 A5F6 B000 B7F9"
	$"B004 B7B0 B7B7 B0FB B700 B001 05DD 3A01"
	$"CCA5 FE3A 136C 7B7B 89B0 9EBE B7B0 909E"
	$"E2B0 B77B 6C90 8297 B0FE 3A0C 909E 975E"
	$"5E89 A53A 3A7B 7B89 FFFE F805 5E3A 825E"
	$"6C65 FC6C FD74 0782 827B 827B 8989 82FB"
	$"89FD 9005 8990 8990 9097 FE90 0097 FE90"
	$"FE97 049E 9797 9E9E DD3A 00B7 FD3A 134F"
	$"5E5E 659E 89A5 A589 6C74 DA9E A53A 3A6C"
	$"6C82 9EFE 3A06 8982 8248 5674 89FC 3A00"
	$"FFFE F806 3A3A 6C5E 5E65 6CFD 74FD 7B03"
	$"8282 8982 FE89 0082 FB89 FD97 0589 9789"
	$"9797 90FE 9700 9EFE 97FE 9E04 979E 9E97"
	$"97DD 3A00 82FD 3A13 4F41 4F56 9E89 97A5"
	$"905E 6CCC 9EA5 3A3A 5E5E 829E FE3A 0689"
	$"6C82 3A3A 657B FD3A 0165 FFFE F806 3A3A"
	$"6C89 8990 97FD A5FB B001 B7B0 FEB7 00B0"
	$"F2B7 00BE FEB7 00BE FEB7 FEBE 04B7 BEBE"
	$"B7B7 010B DE3A 04F8 FFFF CC48 FE3A 3282"
	$"895E B0BE C5A5 3A97 7B90 DADA A57B 653A"
	$"8990 893A 9797 8282 9090 743A E9B0 A589"
	$"9E89 FF5E 487B B074 7B89 827B 8990 8290"
	$"9082 FE97 0089 FD97 039E 909E 97FE 9E02"
	$"979E 90F5 9700 9EFD 9704 909E B0B0 97DE"
	$"3A03 F8FF FFB7 FD3A 325E 743A 9797 B089"
	$"3A56 3A5E CCCC 895E 4F3A 416C 653A 8282"
	$"7B7B 8989 483A E974 3A3A 743A FF3A 3A65"
	$"977B 8989 8289 8997 9097 9790 FE9E 0089"
	$"FD9E FE97 069E B097 979E B097 F59E 0097"
	$"FD9E 0497 97A5 A59E DE3A 03F8 FFFF 82FD"
	$"3A06 6C74 3A90 979E 7BFE 3A21 6CBE BE7B"
	$"4141 3A48 4F3A 3A82 827B 7B89 8956 3AE2"
	$"4F3A 3A7B 3AFF 3A3A 6590 B0B7 B7B0 FEB7"
	$"02BE B7B7 FDBE 00C5 FDBE FEC5 06BE C5C5"
	$"B7CC C5C5 F5BE 00B7 FDBE 01B7 B7FE BE00"
	$"E1DE 3AFD FF01 3A48 FE3A 0189 9EFE B006"
	$"3A3A 7B97 DABE BEFE 6C1B 89E9 5E9E 3A82"
	$"9782 8297 6C3A 3ABE CCFF C5B0 6C7B 977B"
	$"A590 9097 979E FE97 0E9E 9EA5 A5B0 B0A5"
	$"A59E B09E 9E97 9E97 FE9E 0097 FA9E EF97"
	$"DE3A FDFF FC3A 0B74 9797 9E89 3A3A 5E48"
	$"CCA5 9EFD 3A08 E23A 743A 7B89 7B7B 82FE"
	$"3A04 A5BE FFB0 89FE 3A00 5EFE 9702 9E9E"
	$"97FE 9E0E B0B0 A5A5 B7B7 A5A5 B0B7 B0B0"
	$"9E97 9EFE B000 9EFA B0EF 9EDE 3AFD FFFC"
	$"3A0B 7489 909E 903A 3A4F 3ABE 977B FD3A"
	$"08D3 3A41 3A7B 747B 7B82 FE3A 0397 A5F8"
	$"9EFD 3A0B 41A5 C5B7 BECC C5CC BECC C5D3"
	$"FBCC 06C5 CCC5 C5CC C5CC FEC5 00CC FAC5"
	$"EFBE 0114 DE3A 09FF FFE9 F8DA 7B82 483A"
	$"3AFE B003 895E 8990 FEFF 2C9E 8990 979E"
	$"D3D3 B03A 5E82 9797 6C5E BEE9 E9FF E9F0"
	$"E97B 5E90 979E BE9E B0B7 9EB0 9EB0 B7B0"
	$"B0A5 A5B0 A59E 9EB0 FD9E 06A5 9E97 979E"
	$"9797 FE9E FC97 0390 9790 97FB 9004 9E90"
	$"9097 97DE 3A06 FFFF E9F8 CC3A 6CFE 3A06"
	$"979E 9E74 4865 6CFE FF2C 743A 6C7B 74C5"
	$"CC90 3A48 6C82 893A 3A9E E2E9 FFE2 F0E2"
	$"3A3A 8982 B0B7 B0B7 BEB0 B7B0 B7BE B7B7"
	$"A5A5 B7A5 B0B0 B7FD B006 A5B0 9E9E B09E"
	$"9EFE B0FC 9E03 979E 979E F897 019E 9EDE"
	$"3A06 FFFF F0F8 BE3A 48FE 3A06 909E 9E56"
	$"3A56 5EFE FF23 5E3A 5E74 7BB7 CC82 3A3A"
	$"6C82 743A 3AB0 D3E2 F0D3 E9D3 3A3A 8982"
	$"D3CC D3CC D3D3 CCD3 CCD3 FBCC 02C5 C5CC"
	$"FDC5 06CC C5CC BEC5 BEBE FEC5 FCBE 03B7"
	$"BEB7 BEF8 B701 BEBE 010B DF3A 30FF F8FF"
	$"DAE9 F05E 6574 3A5E 5EB0 9797 897B 8989"
	$"5E89 907B 8997 D3D3 CCB0 5E5E 3A3A 975E"
	$"3AE2 DAF0 F0E9 CCE9 B090 90A5 B09E FDB0"
	$"039E 9EB0 9EFE B000 A5FE B003 A59E 9797"
	$"FE9E 0097 FD9E 0597 9E9E 9797 9EFD 97FC"
	$"9001 9790 FA97 DF3A 08FF F8FF DAE9 F03A"
	$"4F5E FE3A 0390 7B82 65FC 3A03 6C48 3A56"
	$"FEC5 14B0 3A48 3A3A 893A 3ACC CCF0 F0E2"
	$"B7E2 975E 8982 B7B0 FDB7 03B0 B0B7 B0FE"
	$"B700 A5FE B703 A5B0 9E9E FEB0 009E FE97"
	$"06B0 9EB0 B09E 9E97 FD9E FC97 019E 97FA"
	$"9EDF 3A08 FFF8 FFE9 E2E9 3A41 6CFE 3A02"
	$"8274 82FB 3A00 4FFE 3A03 B7B7 C5B0 FD3A"
	$"1774 3A3A CCBE E9E9 D397 D390 5E89 97CC"
	$"D3CC CCDA CCD3 D3CC D3F9 CC02 C5BE CCFE"
	$"C500 BEFD C505 BEC5 C5BE BEC5 FDBE FCB7"
	$"01BE B7FA BE01 08E3 3A26 483A 3AF8 FFF8"
	$"F0FF F8E9 B089 823A 5E5E 48A5 976C 896C"
	$"975E 5E7B 9EE9 E9F8 BEC5 B05E 8282 5E7B"
	$"7BFE E206 7BF8 F0BE 9E90 9EFC B002 B7B7"
	$"B0FD B7FB B004 A59E 979E B0FD 9EFE A507"
	$"B0A5 B0B7 B0B0 B7B0 FCA5 07B7 B090 9E97"
	$"9E97 9EFD 97E0 3A09 F8FF E9F0 FFF8 DA97"
	$"746C FD3A 0189 6CFA 3A17 74E9 E2F8 B0B7"
	$"9E3A 5E7B 3A48 3AF0 DADA 3AE9 F0B0 826C"
	$"909E FDB7 06BE BEB7 BEB0 BEBE FBB7 04A5"
	$"B09E B0B7 FDB0 FEA5 07B7 A5B7 BEB7 B7BE"
	$"B7FC A507 B0A5 97B0 9E97 9E97 FD9E E03A"
	$"09F8 FFF0 E9FF E2E9 9065 6CFD 3A00 7BF9"
	$"3A09 41E2 D3E2 B7B0 B03A 6C7B FE3A 0AF8"
	$"DACC 3AF0 E9B7 6C5E 97B0 FDCC 02D3 D3CC"
	$"FDD3 FACC 03C5 CCC5 CCFD C5FB CC03 D3CC"
	$"CCD3 FBCC 07C5 BEC5 C5BE C5BE B7FD BE01"
	$"33E8 3A02 4F48 5EFE 6C09 563A FFF8 FFE2"
	$"97F0 F0A5 FEB0 2582 3A5E 9E48 6C6C 5E3A"
	$"6C7B BECC D3E2 C5B7 9E90 5E89 973A 3ADA"
	$"F089 3A3A FFDA BE97 89B0 B0C5 B7FE 9E1E"
	$"B0BE B0B7 B0BE B0B7 B7B0 9E9E A59E 9EB7"
	$"B7B0 B0A5 B09E A5A5 9797 9E97 9097 97FB"
	$"9000 89FD 9006 9790 9790 9797 90E8 3A16"
	$"483A 4141 5E5E 413A FFF8 FFCC 6CF0 F089"
	$"979E 895E 3A3A 97FA 3A0E 9EB7 CCDA B0A5"
	$"976C 3A65 893A 3ACC F0FE 3A08 FFCC A582"
	$"65B7 B7BE BEFE B01E B7C5 B7BE B7C5 B7BE"
	$"BEB7 B0B0 A5B0 B0BE BEB7 B7A5 B7B0 A5A5"
	$"9E9E B09E 979E 9EFB 9700 89FD 9706 9E97"
	$"9E97 9E9E 97E8 3A16 5E3A 4F5E 8989 743A"
	$"FFF8 F89E 89E9 DA7B 909E 905E 3A3A C5F9"
	$"3A0D C5E2 CC9E A589 4F3A 7474 3A3A BEE9"
	$"FE3A 06FF BE97 8274 CCCC FCD3 FEDA 00D3"
	$"FEDA 09D3 D3CC C5D3 CCD3 C5D3 D3FD CC09"
	$"C5CC CCBE BEC5 BEC5 BEBE F6B7 06BE B7BE"
	$"B7BE BEB7 0148 EF3A 1748 5E48 4F5E 5E6C"
	$"656C 6C74 6C74 5EF8 FFFF B0C5 6C3A C5C5"
	$"9EFE B004 7BB7 3A3A 48FE 5E29 3ABE FFE9"
	$"CCF8 E2B0 BE6C 7B89 9048 D3DA E9B0 A5BE"
	$"9E5E 8989 97BE 9EB7 B7B0 9EB0 9EA5 9E97"
	$"A59E 9797 9E97 FE9E 0397 979E 97FD 9E02"
	$"9797 9EFE 9700 82FD 9000 97FE 9001 8989"
	$"FD90 FE97 0390 8297 90EE 3A02 413A 48FE"
	$"5E15 656C 747B 747B 5EF8 FFFF 90BE 3A3A"
	$"B7B0 979E 9790 48BE FA3A 2F97 FFDA BEF8"
	$"DAB0 B03A 6565 6C3A CCCC E99E 3AB0 893A"
	$"3A74 97C5 B0BE BEB7 B0B7 B0A5 B09E A5B0"
	$"9E9E B09E B097 B09E 9EB0 9EFD B006 9E9E"
	$"979E 909E 90FD 9700 90FE 9701 8989 FD97"
	$"FE9E 0397 9090 97EE 3A0C 4F3A 487B 7B89"
	$"9097 A5B0 A5B0 97FE FF0B 9EBE 3A3A B09E"
	$"899E 9082 3AD3 FA3A 1897 F8E9 A5E2 B7B0"
	$"B73A 6574 6C3A CCBE E282 3AB7 893A 6574"
	$"9EDA FED3 0CCC D3CC D3CC C5CC CCC5 BEBE"
	$"C5CC FEC5 03BE BEC5 BEFD C502 BECC B7FD"
	$"BEFD B700 B0F8 B7FE BE03 B7BE BEB7 0146"
	$"F43A 0656 4F48 746C 5E5E FE6C FE74 1F89"
	$"8990 9097 7BFF E9F8 E9A5 BE9E 909E 9EB0"
	$"979E B0B0 3A48 3A3A 4848 A5E2 F8F8 C5FE"
	$"B010 746C 7482 6C6C 97E9 FFF8 BE5E 3A3A"
	$"829E 97FE 9E08 B09E B79E B0B0 9E97 97FE"
	$"9E01 979E FE97 FC9E 0097 FE9E FB97 FA90"
	$"0197 90FE 9704 909E 9EA5 CCFE A500 9EF4"
	$"3A09 413A 415E 4F4F 5E5E 6C74 FE7B 1489"
	$"8997 979E 89FF E9F8 DA89 A574 7B89 909E"
	$"7B97 B7B7 FA3A 11DA F8F8 B089 A59E 483A"
	$"5E6C 3A3A 7BE9 FFF8 9EFE 3A02 6C90 9EFE"
	$"B008 B7B0 BEB0 B7B7 B09E 9EFE B001 9EB0"
	$"FE9E FCB0 009E FEB0 FB9E FA97 0190 97FE"
	$"9E04 97B0 B0A5 C5FE A500 B0F4 3A03 4148"
	$"746C FE7B 0289 97A5 FEB0 FDB7 10BE B7FF"
	$"F0F8 E9A5 9741 8989 9782 6589 CCCC FA3A"
	$"0ADA E2F8 9090 BEB0 563A 5E6C FE3A 02F0"
	$"F0F8 FD3A 026C 97CC FEC5 00CC FED3 04CC"
	$"CCD3 CCCC FEC5 01BE C5FE BEFC C500 BEFE"
	$"C500 CCFC BEFA B701 BEB7 FEBE 04C5 C5D3"
	$"CCC5 FECC 00C5 016B FA3A 015E 48FD 5E00"
	$"65FE 6C06 7474 8282 8989 90FE 9724 9EA5"
	$"B097 F8FF CC97 F8BE C5B7 5E97 9EB0 A59E"
	$"B0B7 3A6C 5E3A 3A97 A597 CCDA E99E B7BE"
	$"5E7B 74FE 5E00 B0FE F806 E23A 7B6C 97B0"
	$"97FE 9E12 A5B0 979E 9EB0 B0A5 B0A5 9E97"
	$"A59E 9797 B0B0 97FC B706 9EB0 B797 9E97"
	$"9EFE 900D 9790 9797 9E97 9097 B79E 9EA5"
	$"B0A5 FE9E 01B7 B0FA 3A10 413A 4848 5E5E"
	$"656C 7474 7B7B 8282 8989 97FE 9E16 97A5"
	$"B7A5 F8FF B76C F89E BEA5 3A7B 9097 89B0"
	$"B7B0 3A48 48FC 3A08 A5DA E990 A59E 3A65"
	$"6CFE 3A00 97FE F806 DA3A 653A 7BB0 9EFE"
	$"B012 A5B7 9EB0 B0B7 B7A5 B7A5 B09E A5B0"
	$"9E9E B7B7 9EFC BE05 B0B7 B09E B09E FD97"
	$"079E 979E 9E97 9E97 9EFE B002 A5B7 A5FD"
	$"B000 B7FA 3A09 4F3A 6C6C 7B89 9097 A5A5"
	$"FDB0 FEB7 FEBE 13C5 CCCC DAF8 FF97 89E2"
	$"BEBE A53A 7497 907B D3DA C5F9 3A08 B0E9"
	$"E297 A5B0 3A65 5EFE 3A00 90FE F806 DA3A"
	$"653A 74B0 BEFE C5FE CC01 C5C5 FCCC 05C5"
	$"CCCC C5BE BEFE CCFC D305 C5CC C5CC C5BE"
	$"FDB7 07BE B7BE BEB7 BEB7 BEFE C5FE CCFD"
	$"C500 CC01 7503 3A4F 484F FD5E 0765 5E6C"
	$"7482 8289 90FE 9702 9097 97FE 9E00 B0FE"
	$"B707 B089 FFF8 F889 9782 FE9E 1697 899E"
	$"B0B0 B790 5E74 5E74 5E89 8997 A5A5 90B0"
	$"B05E 8289 FE3A 1D5E F8F0 FFF8 9797 8990"
	$"979E B0B7 B09E B7BE BEB7 BEBE B0B0 9E9E"
	$"A5A5 B0A5 9EFE 9705 9090 9E9E 979E FE97"
	$"0190 97FB 9000 97FD 9004 9797 B0B7 B7FC"
	$"9E18 A5A5 B03A 4841 4848 4F5E 5E65 6C74"
	$"7B82 8289 9790 9E9E 979E 9EFE B000 B7FE"
	$"BE15 B79E FFF8 F83A 825E 9090 9782 6590"
	$"B7B7 BE7B 3A56 4848 FB3A 055E 979E 3A6C"
	$"74FD 3A1C F8F0 FFF8 897B 746C 89B0 B7BE"
	$"B7B0 BEC5 C5B0 C5C5 B7B7 B0B0 A5A5 B7A5"
	$"B0FE 9E05 9797 B097 9EB0 FE9E 0197 9EFB"
	$"9700 9EFD 9706 9E9E A5B0 B097 97FE B00D"
	$"A5A5 B73A 4874 5E6C 7B89 8990 9EA5 FEB0"
	$"01B7 C5FE BE06 C5CC CCC5 D3D3 CCFE D315"
	$"CCCC FFF8 F83A 906C 9797 8982 7497 CCCC"
	$"D397 3A48 3A48 FB3A 056C 909E 3A5E 56FD"
	$"3A11 E2E9 F0F8 9E3A 746C 9ED3 CCD3 CCD3"
	$"D3DA DAD3 FEDA 02CC C5D3 FDCC 00C5 FEBE"
	$"FDC5 06CC C5CC BEBE C5BE FBB7 00BE FDB7"
	$"FEBE 00D3 FCC5 00D3 FECC 0154 FE5E 056C"
	$"6C74 8289 82FD 9703 9E97 B0A5 FAB0 009E"
	$"FDB0 0DBE FFCC 9EE9 DA3A 5E3A 9E9E B0BE"
	$"9EFE B018 6C74 4F6C 6C3A 893A 3A89 A597"
	$"A5B0 7B89 6C3A 9089 9E9E F0DA FFFE B009"
	$"97A5 9E9E 979E 9E97 909E F997 0090 FB97"
	$"069E 9EA5 9EB7 B797 FE9E 0790 9097 A5B0"
	$"979E 9EFE 970D 9EB7 9E97 A5D3 A5B7 A5B0"
	$"BEC5 C5BE FE5E 0574 747B 8289 90FD 9E03"
	$"B09E B7A5 FAB7 00B0 FCB7 04FF B797 E9CC"
	$"FE3A 0C89 8990 B7B0 B7B7 A53A 4848 5648"
	$"FA3A 1997 973A 744F 3A7B 3A82 97F0 DAFF"
	$"9EB7 B79E A5B0 B09E B0B0 9E97 97F9 9E00"
	$"97FB 9E06 B0B0 A5B0 BEBE 9EFC 9705 9EA5"
	$"A59E 9797 FE9E 1597 B0B0 9EA5 CCA5 B0A5"
	$"B7B7 BEBE C57B 8997 A5A5 B0B0 B7FC BE01"
	$"C5BE F8CC 00D3 FDCC 05DA F0C5 89F0 BEFE"
	$"3A09 8989 82CC D3CC CCBE 3A48 F73A 0DA5"
	$"903A 565E 3A97 656C 89DA E9F0 82FD CC08"
	$"C5C5 CCC5 C5CC C5C5 CCFA BE00 C5FB BE02"
	$"C5D3 CCFE D300 CCFE C507 B7B7 BECC BECC"
	$"C5C5 FEBE FEC5 FDCC 00C5 FECC 02D3 D3DA"
	$"0157 136C 7490 8997 979E 9797 B0B0 A59E"
	$"B0B7 B0B7 B7B0 9EFD B000 A5FE B009 B7C5"
	$"FFB0 5E9E 7B9E 9E90 FEB0 1E9E A59E A55E"
	$"8948 3A3A 5E97 E9CC 5E7B 6C97 7B3A 747B"
	$"7B3A 8990 B09E 9EB0 9097 FD9E F497 029E"
	$"9797 FE9E 0197 97FE 9E00 A5FE 9700 9EFE"
	$"97FD 9007 97B0 9797 9E9E 97B0 FEB7 1EA5"
	$"A5B7 9EB7 CCB0 A59E D3C5 747B 9789 9E9E"
	$"B09E 9EB7 B7A5 B0B7 BEB7 BEBE B7B0 FDB7"
	$"00A5 FEB7 12BE BEFF 893A 743A 897B 5E97"
	$"9E9E B0A5 B0A5 3A74 FC3A 01DA C5FB 3A0B"
	$"4865 5E3A 657B 9E90 909E 6C9E FEB0 0097"
	$"F49E 02B0 9E9E FEB0 059E 9E97 B0B0 A5FE"
	$"9E00 B0FE 9EFD 9707 9EB0 9E9E B097 9EA5"
	$"FEB0 01A5 A5FE B00C C5B7 A5B0 CCBE A5B0"
	$"B7B7 BEBE C5FC CC07 D3CC D3CC D3D3 CCD3"
	$"F9CC 12D3 D3F0 6C3A 6C3A 8989 6C74 9E9E"
	$"C5CC C5CC 3A65 FC3A 01E9 C5FB 3A0B 5665"
	$"413A 6589 9E97 979E 5EBE FDC5 F4BE 02C5"
	$"BEBE FEC5 01CC CCFE C504 CCBE CCBE C5FE"
	$"BEFD B707 BEB0 BEBE C5C5 BEBE FEC5 01CC"
	$"CCFD C504 CCCC D3CC D301 6B03 909E 9797"
	$"FE9E 00B0 F9B7 06B0 B7B0 B0A5 B09E FEB0"
	$"299E B097 F0F0 5E3A 6C97 749E B0A5 9EA5"
	$"A59E A5A5 BE3A B03A 89E2 E9B7 9EB0 9E9E"
	$"7B3A 8282 7B6C 4F97 9097 A5FD 9704 9E9E"
	$"9097 90FE 9700 9EFC 9704 9E9E A59E A5FD"
	$"B003 BEB7 B090 FE97 0190 97FD 9002 9790"
	$"97FD 9009 9790 9797 9089 90B0 97B0 FEB7"
	$"01B0 BEFD CC03 9797 9E9E FEB0 00B7 F9BE"
	$"06B7 BEB7 B7A5 B7B0 FEB7 04B0 B79E F0F0"
	$"FE3A 037B 6C89 9EFE 9723 A5B0 A597 973A"
	$"893A 3ADA E2A5 7B9E 9782 3A3A 6C6C 5E5E"
	$"4882 5E82 9782 829E 9EB0 9797 9E97 FE9E"
	$"0097 FC9E 0497 B0A5 97A5 FDB7 03C5 BEB7"
	$"97FE 9E01 979E FD97 029E 979E FD97 0990"
	$"9790 9E97 8997 9E9E A5FE B001 B7B7 FBC5"
	$"01BE CCFE D300 CCF9 D301 DAD3 FDCC 00D3"
	$"FECC 04D3 CCBE E9E9 FD3A 0A6C 899E A589"
	$"A5CC C5CC A597 FD3A 15CC D3A5 899E 8956"
	$"3A3A 4848 414F 3A90 6C90 A590 82BE BEFE"
	$"C501 BEB7 FEBE 00C5 FCBE 03C5 C5CC C5FD"
	$"CC04 DADA D3CC C5FE BE01 B7BE FDB7 02BE"
	$"B7BE FDB7 03B0 B7B0 BEFE B702 B0BE BEFE"
	$"C501 CCCC FDC5 0163 0FB0 9EB7 B7B0 B7B7"
	$"B0BE B7B7 B0B7 B0B0 9EFE B0FE 9E0D B0B0"
	$"9EB0 9EA5 C5F8 E96C 5E82 9097 FE9E 07A5"
	$"B0A5 B07B 3AF0 E9FE 3A08 6CBE E297 A59E"
	$"9E6C 5EFD 7404 5EB0 B097 97FE 9E00 97FE"
	$"9E03 9797 9E90 FD97 019E 97FE 9E0E A5A5"
	$"B79E 97C5 BEB7 B09E A59E 9E90 97F8 9001"
	$"9797 FC90 009E FA97 039E 9E97 97FE B00F"
	$"B7B0 BEBE B7BE BEB7 C5BE BEB7 BEB7 B7B0"
	$"FEB7 FEB0 18B7 B7B0 B7B0 A5BE F8E2 3A3A"
	$"5E6C 8297 9090 89B7 A5B7 3A3A F0E9 FE3A"
	$"085E 9EDA 6C82 8974 3A48 FE5E 096C 3AB7"
	$"897B 8997 B0B0 9EFE B003 9E9E 9797 FD9E"
	$"01B0 9EFE B00E A5A5 B0B0 9EBE C5BE B7B0"
	$"A5B0 B097 9EF8 9701 909E FB97 FB90 049E"
	$"9797 9E9E FEA5 00CC FED3 0BCC D3D3 DADA"
	$"D3D3 DAD3 DADA D3FE CCFE D311 CCCC D3CC"
	$"D3CC D3F8 D33A 3A6C 6C82 8997 977B FECC"
	$"033A 3AE9 F0FE 3A08 9789 CC89 9789 7B3A"
	$"3AFD 5E08 3ACC 9074 9E89 C5C5 BEFE C503"
	$"BEBE C5C5 FEBE 02CC C5BE FEC5 0ACC CCD3"
	$"C5CC D3DA D3CC C5CC FEC5 00BE F8B7 01B0"
	$"BEFB B7FB B002 BEB7 B7FC BE01 8405 B7B0"
	$"B7B7 BEBE FEB7 01BE BEFE B002 9EB0 9EFE"
	$"B02A B7B0 9EB0 B7B7 B0C5 F8CC DA7B 5EB0"
	$"6CA5 8997 9E97 A5B0 7B5E F8FF D33A 48DA"
	$"A59E 89A5 A5B0 5E3A 5682 827B 6CFE 9E06"
	$"9790 B09E B09E 9EFE B018 BEA5 9E97 A597"
	$"9097 979E 97B7 979E B0B7 B0B7 B7C5 9EB7"
	$"9EB0 9EFE 9703 9097 9090 F997 FE89 1497"
	$"9790 8997 909E 9790 979E 9E97 9E9E BEB7"
	$"BEBE C5C5 FEBE 01C5 C5FE B702 B0B7 B0FE"
	$"B734 BEB7 B0B7 BEBE B7BE E9C5 CC3A 3A90"
	$"3A89 7482 749E A5B7 3A3A F8FF C53A 3ACC"
	$"7B89 3A82 829E 3A3A 416C 6C5E 4897 B0B0"
	$"977B B7B0 B7B0 B0FD B717 A5B0 9EA5 9E97"
	$"9E9E B09E B09E B0B7 BEB7 BEBE CCB0 BEB0"
	$"B7B0 FE9E 0497 9E97 9790 FB9E 0090 FE89"
	$"1490 9097 8990 9797 9097 9097 979E 9797"
	$"D3DA D3E2 DADA FED3 FEDA 1ACC CCD3 CCD3"
	$"CCDA CCD3 DAD3 DAD3 D3CC D3F0 C5BE 3A3A"
	$"5E3A 7B74 825E FECC 1E3A 3AF8 FF9E 3A3A"
	$"BE3A 893A 9797 9E3A 3A41 5E5E 4F3A B7C5"
	$"C59E 89CC C5CC C5D3 FCCC 00C5 FECC 0DC5"
	$"CCCC C5CC C5BE C5CC D3CC D3D3 E2FE D301"
	$"CCC5 FEBE 03B7 BEB7 B7FE BE00 CCFD BEFE"
	$"B70E B0B0 B7B7 B0B7 B7B0 B7B0 B7B7 BEB7"
	$"B701 5101 BEB0 FDBE 06B0 B7B0 B7B0 B0B7"
	$"FDB0 04B7 B7B0 BEBE FEB7 259E B7B0 F0DA"
	$"9EA5 5E9E 7B97 9E97 B09E 8990 8948 F0FF"
	$"6C3A D3E9 C589 979E 9789 3A6C 3A74 827B"
	$"5EFC 9E05 B0B0 899E 9EB0 FC9E 01B0 9EF9"
	$"970A A5D3 B09E A5A5 B0A5 9E9E 90FC 97FE"
	$"900F 9797 9097 9097 8997 8989 9797 8989"
	$"8289 F797 01C5 B7FD C506 B7BE B7BE B7B7"
	$"BEFD B704 BEBE B7C5 C5FE BE1E B0BE B7F0"
	$"D390 973A 893A 7B90 829E B065 6C74 3AF0"
	$"FF3A 3AC5 E9B0 3A82 9797 56FE 3A05 5E6C"
	$"4F3A 9797 FEB0 05B7 B79E B0B0 B7FD B002"
	$"97A5 97F9 9E0A A5CC B7B0 A5A5 B7A5 B0B0"
	$"97FD 9E00 90FE 970F 9090 9790 9790 8990"
	$"8989 9090 8989 8289 F790 FADA 05D3 DAD3"
	$"CCCC D3FE CC02 DAD3 D3FE DAFC D31B CCE9"
	$"D397 A53A 893A 7497 829E C53A 5E56 3AE9"
	$"FF3A 3AB7 E29E 3A82 899E FD3A 035E 485E"
	$"3AFC C5FE CC02 D3D3 CCFC C501 BEC5 FBBE"
	$"01CC BEFE CC00 D3FD CC02 C5C5 B7FC BEFE"
	$"B70F BEBE B7B0 B7B0 B7B0 B7B7 B0B0 B7B7"
	$"B0B7 F7B0 0159 02B7 B0B7 FCBE 04B0 B0B7"
	$"B09E FEB0 02B7 B0CC FEBE 22B7 B0B0 B7B7"
	$"BEF0 F0D3 B0B0 8990 B09E A5B7 7B89 827B"
	$"5EF8 A53A 3AB7 8990 B07B 9E82 486C FD3A"
	$"036C 979E 97FD 9E01 979E FC97 0690 9797"
	$"9097 9790 FB97 FC9E 04A5 9797 9E9E FC97"
	$"0090 FE97 0289 9097 FC89 0782 9797 8297"
	$"8282 89FE 8202 8982 74FE 9703 82BE B7BE"
	$"FCC5 04B7 B7BE B7B0 FEB7 02BE B7D3 FEC5"
	$"20BE B7B7 BEBE B7F0 F0CC A597 747B 9E89"
	$"97BE 3A3A 6C5E 3AF8 7B3A 3A97 567B 9E3A"
	$"906C FB3A 0348 89B0 9EFD B001 9EB0 FC9E"
	$"0697 9E9E 979E 9E97 FB9E 0197 97FE B00A"
	$"A59E 9EB0 979E 9E90 9E9E 97FE 9002 8997"
	$"90FC 8907 8290 9082 9082 8289 FE82 0989"
	$"827B 8990 9082 D3DA D3FA DA02 D3DA D3FE"
	$"DA00 D3FC DA16 D3DA CCD3 D3CC DAE9 E2BE"
	$"9074 899E 89A5 D33A 3A5E 4F3A F8FE 3A06"
	$"A53A 899E 3A97 6CFA 3A02 9EC5 BEFD C501"
	$"BEC5 FCBE 06B7 BEBE B7BE BEC5 FBBE FCC5"
	$"04CC CCBE C5C5 FCBE 06B7 BEB0 B0B7 B7B0"
	$"FCB7 FAB0 00B7 FEB0 03B7 B0B0 9EFE B001"
	$"2AFC BEFE B7FE B001 B7B7 FBBE 0AB7 BEB7"
	$"B0B0 B7B7 B0DA 90C5 FEB0 1E9E B0B0 97B0"
	$"7B6C 6C89 487B F0DA 5E5E BEA5 6C90 9797"
	$"3A5E 893A 8989 3A7B B7D3 FEB0 FD9E 0297"
	$"9790 FC97 0090 F497 039E 9EB7 9EFD 9703"
	$"A5B7 9E9E FC97 0690 9097 8997 8997 FD82"
	$"0089 F582 FCC5 FEBE FEB7 01BE BEFB C52C"
	$"BEC5 BEB7 B7BE BEA5 CC5E BE9E 8997 909E"
	$"9789 B748 3A56 743A 3AF0 CC3A 3A9E 7B4F"
	$"7B82 893A 4174 3A74 743A 3ABE CCFE B7FD"
	$"B002 9E9E 97FC 9E00 97F8 9E00 90FE 9E17"
	$"B097 B097 9E90 9E9E A5B0 B097 9E9E 9090"
	$"9E97 9790 8990 8990 FD82 0089 F582 FCDA"
	$"FED3 FEDA 01E2 D3FB DA12 D3DA D3CC CCD3"
	$"D3BE BE6C BE9E 9090 979E 749E CCFE 3A15"
	$"653A 3AE9 BE3A 3ABE 3A7B 8990 9E3A 4F82"
	$"3A82 743A 3AD3 FDCC FDC5 02BE BEB7 FCBE"
	$"00B7 F4BE FDC5 FDBE 00CC FEC5 FCBE 05B7"
	$"B7B0 B7B0 B7FC B000 B7F5 B001 5108 B7B7"
	$"CCBE B7BE BECC C5FD CCFE B70F B0B0 B7B7"
	$"B09E B0B7 B7CC B7E2 6C89 9E9E FEB7 2397"
	$"B79E 8982 7B89 48E9 E9BE 6C82 909E 9EB0"
	$"9EBE 9EB0 A597 9090 97B7 A5A5 9E9E A59E"
	$"9EA5 97FE 90FE 9704 9090 9790 9EFA 9704"
	$"9090 9790 97F9 9000 89FE 90FE 8901 9097"
	$"FE89 0997 8982 9782 8989 8282 74F9 820A"
	$"7482 CCCC C5C5 CCC5 C5D3 CCFD D3FE BE0F"
	$"B7B7 BEBE B7B0 B7BE BEC5 BEDA 3A3A 9789"
	$"FEA5 1682 BE82 566C 5E74 3AE2 E29E 3A5E"
	$"5E89 8990 909E B09E 9789 FE6C 09B0 A5A5"
	$"B0B0 A5B0 B0A5 9EFE 97FE 9E04 9797 9E97"
	$"97FA 9E04 9797 9E97 90F9 9700 89FE 97FE"
	$"8901 9790 FE89 0990 8982 9082 8989 8282"
	$"7BF9 8206 7B82 E2E2 DADA E2FE DA00 E2FD"
	$"DAFE D30F CCCC D3D3 CCD3 CCD3 D3C5 E2CC"
	$"3A3A 8989 FEA5 2682 D356 3A6C 4F56 3AD3"
	$"D37B 3A6C 6C89 899E 97BE C59E A59E 5E7B"
	$"3AC5 CCCC C5C5 CCC5 C5CC BEB7 C5C5 FEBE"
	$"04B7 B7BE B7B7 FABE 04B7 B7BE B7BE F1B7"
	$"00B0 FEB7 01B0 B7FE B001 B7B7 F4B0 0127"
	$"07C5 B7CC C5B7 CCBE CCFE BE01 B7B7 FBB0"
	$"0D9E A5B0 9EB7 9EBE FFCC 8948 7B9E B7FD"
	$"B01C 7B89 7482 895E 89B0 9E3A 3A89 B097"
	$"97B0 979E 979E C5B0 829E 9097 9E97 97FE"
	$"9005 9790 9797 9097 FE90 FE97 0290 9097"
	$"EE90 0089 FD90 0297 9097 FC89 0497 9789"
	$"9789 F482 07CC CCD3 CCCC D3C5 D3FE C501"
	$"BEBE FBB7 2EB0 A5B7 B0BE B0B7 FFA5 3A3A"
	$"4889 A597 8990 B73A 656C 6C74 3A3A 8989"
	$"3A3A 7490 8282 909E 979E B0BE 976C B097"
	$"9E97 9E90 FE97 059E 979E 9E97 9EFE 97FE"
	$"9E02 9797 9EEE 9700 89FD 9702 9097 90FC"
	$"8904 9090 8990 89F4 8204 E2E2 DAE2 E2FB"
	$"DA01 D3D3 FBCC 08C5 CCCC C5D3 D3CC FF89"
	$"FE3A 2289 A590 9082 CC3A 566C 5E65 3A65"
	$"6C89 3A3A 829E 8282 9EBE C5BE C5BE 906C"
	$"C5C5 BEC5 BEBE FEB7 05BE B7BE BEB7 BEFE"
	$"B7FE BE02 B7B7 BEE9 B702 B0B7 B0FC B704"
	$"B0B0 B7B0 B7F4 B001 4C07 CCCC BEB0 9EB0"
	$"B7A5 FEB0 0D9E B0B0 A59E 979E 9EA5 9E97"
	$"A5B7 9EFE FF18 897B 9089 9EB0 B0B7 5E82"
	$"7489 896C 897B A59E 8989 9790 9E97 90FE"
	$"9716 9E97 979E 97B0 9790 9797 9090 9789"
	$"9797 9090 9790 9790 97FD 9004 9790 9790"
	$"97FD 9000 97F8 9000 97FD 9007 9E90 9097"
	$"9789 9790 FE97 0182 97F6 82FE 7407 D3D3"
	$"C5B7 B0B7 BEA5 FEB7 0DB0 B7B7 A5B0 9EB0"
	$"B0A5 B09E A5B0 B0FE FF18 3A3A 6C74 8290"
	$"B7BE 3A6C 5E65 655E 3A3A 7B89 7456 7B89"
	$"909E 97FE 9E16 B09E 9E97 9EA5 9E97 9E9E"
	$"9797 9089 9E9E 9797 9E97 9E97 9EFD 9704"
	$"9E97 9097 9EFD 9700 90F8 9700 90FA 9704"
	$"9090 8990 97FE 9001 8290 F682 FE7B FDDA"
	$"02D3 DAD3 FDCC 00D3 FECC 09C5 CCC5 C5CC"
	$"C5CC CCC5 D3FE FF18 3A3A 4F65 5682 CCD3"
	$"3A5E 6C56 564F 653A 3A89 823A 7489 97BE"
	$"C5FE BE03 C5BE BEC5 FEBE 0FB7 BEBE B7B7"
	$"BEC5 BEBE B7B7 BEB7 BEB7 BEFD B704 BEB7"
	$"BEB7 BEFD B700 B0F8 B700 B0FA B704 B0B0"
	$"B7B0 B7EE B001 2406 B0B7 B09E B0B0 B7FE"
	$"B00D A5A5 B0A5 A597 9EA5 9E97 A5A5 9EB0"
	$"FDFF 07F0 5E7B B0B0 A5B0 5EFE 7B0A 5E82"
	$"8989 8289 9EB0 A5B0 A5FB 9700 9EFA 97FD"
	$"9000 97FE 9004 9790 9797 90F4 97FD 9000"
	$"97FD 90FC 8901 9090 FD89 0097 FD89 0597"
	$"8982 9789 97F8 820A 7482 8290 B7BE B7B0"
	$"B7B7 BEFE B70D A5A5 B7A5 A59E B0A5 B09E"
	$"A5A5 97A5 FDFF 15F0 3A3A 8997 A5B7 3A3A"
	$"4F5E 565E 7474 6C74 9090 9790 97FB 9E00"
	$"B0FA 9EFD 9700 9EFE 9704 9E97 9E9E 97F7"
	$"9E02 909E 90FD 9700 90FD 97FC 8901 9797"
	$"FD89 0082 FD89 0590 8982 9089 90F8 820B"
	$"7B82 827B CCD3 DAD3 CCCC D3DA F9CC 07C5"
	$"CCC5 BECC CCB7 BEFE FF16 F8E9 3A3A 9090"
	$"CCCC 3A3A 5E4F 3A6C 7474 6C74 979E A59E"
	$"A5FB BE02 C5BE CCFC BEFD B708 BEC5 B7B7"
	$"BEB7 BEBE B7F4 BEFD B700 B0F2 B700 90FD"
	$"B704 B0B7 B0B0 B7F4 B000 9701 4304 B7B0"
	$"B09E B0FE 9E00 A5FE B005 A5B0 A5A5 979E"
	$"FDA5 009E FDFF 14F8 F897 90B7 C5B7 B76C"
	$"747B 7474 8997 9EB0 979E 9EB0 FD97 029E"
	$"9790 FC97 F990 0197 97FC 9002 9797 9EFE"
	$"9700 9EFE 9704 9097 9E90 97FC 9000 89FD"
	$"9000 97FE 9006 8990 9790 9089 90FE 8904"
	$"8289 8282 7BFB 8203 8982 8274 FE82 0674"
	$"74BE B7B7 B0B7 FEB0 00A5 FEB7 05A5 B7A5"
	$"A59E B0FD A500 B0FD FF04 F8F8 486C A5FE"
	$"BE00 3AFE 5E07 5674 8289 9782 8990 FC9E"
	$"0297 9E97 FC9E F997 019E 9EFC 9702 9E9E"
	$"B0FE 9E00 B0FE 9E04 979E 9797 9EFC 9700"
	$"89FD 9700 9EFE 9706 8997 9097 9789 97FE"
	$"8904 8289 8282 89FB 8203 8982 827B FE82"
	$"067B 7BD3 CCDA D3CC FED3 F8CC 00C5 FDCC"
	$"00D3 FDFF 04F8 E23A 6CA5 FED3 0C3A 5E41"
	$"5E48 7482 8990 9089 979E FEBE 03CC C5BE"
	$"C5FC BEF9 B701 BEBE FCB7 06BE BEC5 BEBE"
	$"CCC5 FEBE 04B7 BEB7 B7BE F7B7 00BE FCB7"
	$"00B0 FAB7 04B0 B7B0 B0B7 FBB0 00B7 F9B0"
	$"012E 079E B0B7 A59E B09E 9EFE A50A 9EB0"
	$"A59E 97A5 A59E 9EA5 89FE FF15 F8FF F8BE"
	$"97B7 9EA5 976C 6C7B 7B97 749E 90A5 B09E"
	$"B0B0 FD97 019E 9EFE A503 9E9E 9797 F990"
	$"0297 9090 F597 0190 97FD 9002 9E90 97FA"
	$"9003 9790 9089 FE90 0189 90FC 8906 9797"
	$"8989 8289 89FE 8200 97F7 8207 B0B7 BEA5"
	$"B0B7 B0B0 FEA5 0AB0 B7A5 B09E A5A5 B0B0"
	$"A589 FEFF 13F8 FFF8 B07B A597 A59E 3A3A"
	$"5E5E 7B48 897B 8297 90FB 9E01 97B0 FEA5"
	$"03B0 979E 9EF9 9702 9E97 97F5 9E01 9790"
	$"FB97 0090 FA97 039E 9797 89FE 9701 8997"
	$"FC89 0690 9089 8982 8989 FE82 0089 F782"
	$"07D3 CCD3 CCD3 CCD3 C5FE CC03 D3CC CCC5"
	$"FECC 1CC5 C5CC C5FF F8FF F8F8 E2B7 3AA5"
	$"C5CC CC3A 3A4F 4F65 5689 8997 9097 9EB0"
	$"FDBE 01C5 C5FE CC03 C5B7 BEBE FAB7 03C5"
	$"BEC5 B7F5 BE01 B7BE FBB7 00B0 FAB7 00BE"
	$"F4B7 06B0 B0B7 B7B0 B7B7 FEB0 009E F7B0"
	$"012F FEB7 06A5 9E9E 9797 9E9E FCB0 0697"
	$"9E9E 9797 A597 FDFF 14F0 BEBE C5A5 A5B0"
	$"9E6C 897B 7B82 7B90 B097 A5B7 9790 FE97"
	$"0090 FA97 0290 9089 FB90 0097 FE90 FD97"
	$"0090 FB97 FC90 0197 97FC 9000 89FD 9000"
	$"97FE 9004 8990 8989 97FD 8900 97FD 8906"
	$"9789 8982 8274 74FE 8200 74FB 82FE BE06"
	$"A5B0 B09E 9EB0 B0FC B706 9EB0 B09E 9EA5"
	$"9EFD FF03 F0B0 A5BE FEA5 07B0 3A74 5E5E"
	$"6C5E 89FE 9702 A59E 97FE 9E02 9790 90FC"
	$"9E02 9797 89FB 9700 9EFE 97FD 9E00 97FB"
	$"9EFC 9701 9090 FC97 0089 FD97 0090 FE97"
	$"0489 9789 8990 FD89 0090 FD89 0690 8989"
	$"8282 7B7B FE82 007B FB82 FED3 06CC C5C5"
	$"CCCC C5D3 FBCC 05C5 C5CC BECC CCFD FF14"
	$"E9B7 97BE CCCC BEC5 3A56 4F4F 4841 8990"
	$"9EA5 A5BE B7FE BE00 B7FA BEF8 B703 BEB7"
	$"B7C5 FDBE 00C5 FBBE FCB7 01B0 BEF7 B700"
	$"B0FA B700 B0FD B700 B0FD B702 B0B7 B7F3"
	$"B001 3506 B0B0 A597 979E 9EFD B007 A59E"
	$"9797 9E9E 9797 FE9E 07FF F8FF E9D3 B0BE"
	$"97FE 9E0A 7B48 3A74 7482 9797 90A5 9EFC"
	$"9701 9097 FE90 0697 9790 9097 9789 FB90"
	$"0297 9790 FD97 049E 9797 B09E FD97 009E"
	$"FE90 FD97 FD90 0397 9090 97FC 90FE 8901"
	$"9090 FB89 0782 9782 8989 8289 89F6 8206"
	$"B7B7 A59E 9EB0 B0FD B715 A597 9E9E B0B0"
	$"9E9E B0B0 97FF F8FF E9CC 9EB0 9EB0 97B0"
	$"FE3A 0756 5E5E 7B7B 6C97 B0FC 9E01 9790"
	$"FE97 069E 9E97 979E 9E89 FB97 029E 9E97"
	$"FD9E 04B0 9E9E B7B0 FD9E FD97 FD9E FD97"
	$"0390 9797 9EFC 97FE 8901 9797 FB89 0782"
	$"9082 8989 8289 89F6 82FC CC02 D3D3 DAFD"
	$"CC06 C5CC CCC5 C5BE BEFE C507 F8F8 F0E2"
	$"CC9E B7CC FEC5 FE3A 0748 5E5E 6574 6CA5"
	$"C5FC BE01 B7BE FEB7 05BE BEB7 B7BE BEFA"
	$"B70C BEBE C5BE BECC CCC5 BECC CCC5 CCFE"
	$"BEFD B7FD BEFD B703 BEB7 B7BE F1B7 FEB0"
	$"04B7 B7B0 B7B7 F6B0 014F 0BB0 B7B0 B09E"
	$"B0B0 A59E 9E97 90FE 971A 909E 9797 9EA5"
	$"B0FF E9DA B0B0 C5BE B0B0 A548 3AE9 F83A"
	$"3A6C 909E B0FD 9702 9097 90FD 971A 9097"
	$"9790 9097 9090 9797 9097 9097 9090 979E"
	$"9EB7 BECC C5B7 D3BE B0FB 97F7 9002 979E"
	$"97FC 9001 8990 FE89 0A97 8989 9789 8982"
	$"8289 8289 FD82 0389 8282 97FB 820B B7CC"
	$"B7B7 B0B7 B7A5 97B0 9E97 FE9E 1497 979E"
	$"9EB0 A5B7 FFE9 D39E 90B7 A5B7 B7A5 3A3A"
	$"E9E9 FE3A 016C 90FC 9E02 979E 97FD 9E1A"
	$"979E 9E97 979E 9797 909E 979E 979E 9797"
	$"9EB0 B0BE C5D3 CCBE CCB7 A5FB 9EF7 9702"
	$"9E97 9EFC 9701 8997 FE89 0A90 8989 9089"
	$"8982 8289 8289 FD82 0389 8282 90FB 820B"
	$"DAE2 DADA C5CC DACC C5C5 CCB7 FEBE 0DC5"
	$"C5CC CCC5 CCCC F8E2 D39E 82B0 97FE CC03"
	$"3A3A E2F0 FE3A 026C 97B0 FDBE 02B7 BEB7"
	$"FDBE 19B7 BEBE B7B7 BEB7 B7BE BEB7 BEB7"
	$"BEC5 C5CC C5D3 D3DA DAE2 D3CC CCFA BEF7"
	$"B702 BEC5 BEF7 B70A B0B7 B7B0 B7B7 B0B0"
	$"B7B0 B7FD B000 B7F8 B001 3FFC 9E03 9090"
	$"979E FE97 009E FC97 0E9E B0A5 A5CC D39E"
	$"9EB0 B097 B09E 9782 FDFF 05F0 7B89 9E97"
	$"97FE 9004 9797 9097 90FD 9700 9EFC 9711"
	$"9090 9E9E 9790 979E B09E 9EB7 C5CC CCBE"
	$"B79E FE97 0090 FC97 0B9E 979E 9E90 9797"
	$"9097 9790 97FC 9001 8997 F889 0382 9782"
	$"89F5 8201 9774 FCB0 0397 979E B0FE 9E00"
	$"B0FC 9E01 B0B7 FEA5 02CC 8974 FE9E 03B7"
	$"B09E 82FD FF05 F03A 6589 9E9E FE97 049E"
	$"9E97 9E97 FD9E 00B0 FC9E 1197 97B0 B09E"
	$"979E B0B7 B0B0 BECC D3D3 C5BE B0FE 9E00"
	$"97FC 9E01 979E FE97 069E 9E97 9E90 979E"
	$"FC97 0189 90F8 8903 8290 8289 F582 0189"
	$"7BFE D3FD C501 CCC5 FEBE 00C5 FDBE 01CC"
	$"C5FE CC14 B0CC 896C 9E9E CCCC C5CC B0FF"
	$"F0FF FFDA 3A74 89BE BEFE B704 BEBE B7BE"
	$"B7FD BE00 C5FC BEFD C50D BEB7 BEC5 CCD3"
	$"C5D3 E2E9 E9DA D3C5 FEBE 00B7 FCBE 0BC5"
	$"BEC5 C5B7 BEBE B7BE BEB7 BEFB B700 B0F8"
	$"B7FE B000 B7F5 B001 9EB0 0157 0897 9E97"
	$"9097 979E 979E FB97 FD9E 0FA5 A59E C55E"
	$"909E BEB0 A59E 9E90 F8FF FFFE F801 B090"
	$"FC97 0390 9797 90FC 9700 9EFE 9703 9097"
	$"9790 FD97 0590 979E B09E A5FE DA05 C5BE"
	$"9E97 979E FC97 0A90 9782 9797 9097 9E90"
	$"9097 FD90 0789 9097 8990 8989 97FC 8908"
	$"9797 8297 8982 8289 97FE 8201 9789 FB82"
	$"089E B09E 979E 9EB0 9EB0 FB9E FDB0 0FA5"
	$"A5B0 BE3A 6C97 A5B7 A597 B097 E9FF FFFE"
	$"F801 9E89 FC9E 0397 9E9E 97FC 9E00 B0FE"
	$"9E03 979E 9E97 FD9E 0597 9EB0 B7B0 BEFE"
	$"DA05 CCC5 B09E 9EB0 FD9E 0790 979E 829E"
	$"9E97 9EFE 9700 9EFD 9707 8997 9089 9789"
	$"8990 FC89 0890 9082 9089 8282 8990 FE82"
	$"0190 89FB 8208 BEC5 CCC5 CCBE C5BE C5FB"
	$"BEFD C509 CCCC D3BE 3A6C 8997 CCCC FEC5"
	$"07F0 FFFF F8E2 E29E 89FC BE03 B7BE BEB7"
	$"FCBE 00C5 FEBE 03B7 BEBE B7FD BE05 B7BE"
	$"C5CC D3E2 FEE9 05E2 DAC5 BEBE C5FD BE07"
	$"B0B7 BEB0 BEBE C5BE FEB7 00BE FBB7 00B0"
	$"FDB7 00B0 FCB7 FDB0 03B7 B0B0 B7FC B000"
	$"B7FB B000 00FF"
};

resource kControlListDescResType (133, "Add/Remove list definition", purgeable) {
	versionZero {
        0,             		/* Rows */
        1,               	/* Columns */
        0,              	/* Cell Height */
        0,              	/* Cell Width */
        hasVertScroll,   	/* Vert Scroll */
        noHorizScroll, 		/* Horiz Scroll */
        0,            		/* LDEF Res ID */
       	noGrowSpace			/* growable? */
	}
};

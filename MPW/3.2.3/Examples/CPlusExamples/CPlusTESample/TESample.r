/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple TextEdit Sample Application
#
#	CPlusTESample
#
#	TESample.r	-	Rez source
#
#	Copyright © 1989 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	
#			1.10 					07/89
#			1.00 					04/89
#
#	Components:
#			CPlusTESample.make		July 9, 1989
#			TApplicationCommon.h	July 9, 1989
#			TApplication.h			July 9, 1989
#			TDocument.h				July 9, 1989
#			TECommon.h				July 9, 1989
#			TESample.h				July 9, 1989
#			TEDocument.h			July 9, 1989
#			TESample.cp				July 9, 1989
#			TESample.r				July 9, 1989
#
#	CPlusTESample is an example application that demonstrates
#	how to initialize the commonly used toolbox managers,
#	operate successfully under MultiFinder, handle desk
#	accessories and create, grow, and zoom windows. The
#	fundamental TextEdit toolbox calls and TextEdit autoscroll
#	are demonstrated. It also shows how to create and maintain
#	scrollbar controls. 
#
#	This version of TESample has been substantially reworked in
#	C++ to show how a "typical" object oriented program could
#	be written. To this end, what was once a single source code
#	file has been restructured into a set of classes which
#	demonstrate the advantages of object-oriented programming.
#
------------------------------------------------------------------------------*/

#include "SysTypes.r"
#include "Types.r"

#include "TECommon.h"

resource 'vers' (1) {
	0x01, 0x00, release, 0x00,
	verUS,
	"1.10",
	"1.10, Copyright © 1989 Apple Computer, Inc."
};

/* we use an MBAR resource to conveniently load all the menus */

resource 'MBAR' (rMenuBar, preload) {
	{ mApple, mFile, mEdit };		/* three menus */
};


resource 'MENU' (mApple, preload) {
	mApple, textMenuProc,
	0b1111111111111111111111111111101,	/* disable dashed line, enable About and DAs */
	enabled, apple,
	{
		"About CPlusTESample…",
			noicon, nokey, nomark, plain;
		"-",
			noicon, nokey, nomark, plain
	}
};

resource 'MENU' (mFile, preload) {
	mFile, textMenuProc,
	0b0000000000000000000100000000000,	/* enable Quit only, program enables others */
	enabled, "File",
	{
		"New",
			noicon, "N", nomark, plain;
		"Open",
			noicon, "O", nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Close",
			noicon, "W", nomark, plain;
		"Save",
			noicon, "S", nomark, plain;
		"Save As…",
			noicon, nokey, nomark, plain;
		"Revert",
			noicon, nokey, nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Page Setup…",
			noicon, nokey, nomark, plain;
		"Print…",
			noicon, nokey, nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Quit",
			noicon, "Q", nomark, plain
	}
};

resource 'MENU' (mEdit, preload) {
	mEdit, textMenuProc,
	0b0000000000000000000000000000000,	/* disable everything, program does the enabling */
	enabled, "Edit",
	 {
		"Undo",
			noicon, "Z", nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Cut",
			noicon, "X", nomark, plain;
		"Copy",
			noicon, "C", nomark, plain;
		"Paste",
			noicon, "V", nomark, plain;
		"Clear",
			noicon, nokey, nomark, plain
	}
};


/* this ALRT and DITL are used as an About screen */

resource 'ALRT' (rAboutAlert, purgeable) {
	{40, 20, 160, 330 }, rAboutAlert, {
		OK, visible, silent;
		OK, visible, silent;
		OK, visible, silent;
		OK, visible, silent
	};
};

resource 'ALRT' (rUserAlert, purgeable) {
	{40, 20, 150, 260},
	129,
	{	/* array: 4 elements */
		/* [1] */
		OK, visible, silent,
		/* [2] */
		OK, visible, silent,
		/* [3] */
		OK, visible, silent,
		/* [4] */
		OK, visible, silent
	}
};


resource 'DITL' (rAboutAlert, purgeable) {
	{ /* array DITLarray: 5 elements */
		/* [1] */
		{88, 224, 108, 304},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{8, 8, 24, 304 },
		StaticText {
			disabled,
			"MultiFinder-Aware C++ TextEdit Application"
		},
		/* [3] */
		{32, 8, 48, 237},
		StaticText {
			disabled,
			"Copyright © 1989 Apple Computer"
		},
		/* [4] */
		{56, 8, 72, 136},
		StaticText {
			disabled,
			"Brought to you by:"
		},
		/* [5] */
		{80, 24, 112, 167},
		StaticText {
			disabled,
			"Macintosh Developer  Technical Support"
		}
	}
};


resource 'WIND' (rDocWindow, preload, purgeable) {
	{64, 60, 314, 460},
	zoomDocProc, invisible, goAway, 0x0, "untitled"
};


resource 'CNTL' (rVScroll, preload, purgeable) {
	{-1, 385, 236, 401},
	0, visible, 0, 0, scrollBarProc, 0, ""
};


resource 'CNTL' (rHScroll, preload, purgeable) {
	{235, -1, 251, 386},
	0, visible, 0, 0, scrollBarProc, 0, ""
};

resource 'STR#' (kTEDocErrStrings, purgeable) {
	{
	"Not enough memory to run TESample";
	"Not enough memory to do Cut";
	"Cannot do Cut";
	"Cannot do Copy";
	"Cannot exceed 32,000 characters with Paste";
	"Not enough memory to do Paste";
	"Cannot create window";
	"Cannot exceed 32,000 characters";
	"Cannot do Paste"
	}
};

/* here is the quintessential MultiFinder friendliness device, the SIZE resource */

resource 'SIZE' (-1) {
	dontSaveScreen,
	acceptSuspendResumeEvents,
	enableOptionSwitch,
	canBackground,		/* we can background; we don't currently, but our sleep value */
						/* guarantees we don't hog the Mac while we are in the background */
	multiFinderAware,	/* this says we do our own activate/deactivate; don't fake us out */
	backgroundAndForeground, /* this is definitely note a background-only application! */
	dontGetFrontClicks,	/* change this is if you want "do first click" behavior like the Finder */
	ignoreChildDiedEvents,
	is32BitCompatible,
	reserved, reserved, reserved, reserved,
	reserved, reserved, reserved,
	kPrefSize * 1024,
	kMinSize * 1024
};


type 'MOOT' as 'STR ';


resource 'MOOT' (0) {
	"MultiFinder-Aware TextEdit Sample Application"
};


resource 'BNDL' (128) {
	'MOOT',
	0,
	{
		'ICN#',
		{
			0, 128
		},
		'FREF',
		{
			0, 128
		}
	}
};


resource 'FREF' (128) {
	'APPL',
	0,
	""
};


resource 'ICN#' (128) {
	{ /* array: 2 elements */
		/* [1] */
		$"04 30 40 00 0A 50 A0 00 0B 91 10 02 08 22 08 03"
		$"12 24 04 05 20 28 02 09 40 10 01 11 80 0C 00 A1"
		$"80 03 FF C2 7E 00 FF 04 01 00 7F 04 03 00 1E 08"
		$"04 E0 00 0C 08 E0 00 0A 10 E0 00 09 08 C0 00 06"
		$"04 87 FE 04 02 88 01 04 01 88 00 84 00 88 00 44"
		$"00 88 00 44 00 88 00 C4 01 10 01 88 02 28 03 10"
		$"01 C4 04 E0 00 02 08 00 73 BF FB EE 4C A2 8A 2A"
		$"40 AA AA EA 52 AA AA 24 5E A2 8A EA 73 BE FB 8E",
		/* [2] */
		$"04 30 40 00 0E 70 E0 00 0F F1 F0 02 0F E3 F8 03"
		$"1F E7 FC 07 3F EF FE 0F 7F FF FF 1F FF FF FF BF"
		$"FF FF FF FE 7F FF FF FC 01 FF FF FC 03 FF FF F8"
		$"07 FF FF FC 0F FF FF FE 1F FF FF FF 0F FF FF FE"
		$"07 FF FF FC 03 FF FF FC 01 FF FF FC 00 FF FF FC"
		$"00 FF FF FC 00 FF FF FC 01 FF FF F8 03 EF FF F0"
		$"01 C7 FC E0 00 03 F8 00 73 BF FB EE 7F BE FB EE"
		$"7F BE FB EE 7F BE FB E4 7F BE FB EE 73 BE FB 8E"
	}
};

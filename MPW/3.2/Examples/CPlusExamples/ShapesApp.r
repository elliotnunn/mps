/*------------------------------------------------------------------------------
#
#	MultiFinder-Aware Simple Shapes Sample Application
#
#	CPlusShapesApp
#
#	This file: ShapesApp.cp - Resource definitions for CPlusShapesApp
#
#	Copyright © 1988 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	1.0 				3/89
#
#	Components:
#			CPlusShapesApp.make		March 1, 1989
#			TApplicationCommon.h	March 1, 1989
#			TApplication.h			March 1, 1989
#			TDocument.h				March 1, 1989
#			ShapesAppCommon.h		March 1, 1989
#			ShapesApp.h				March 1, 1989
#			ShapesDocument.h		March 1, 1989
#			TApplication.cp			March 1, 1989
#			TDocument.cp			March 1, 1989
#			ShapesApp.cp			March 1, 1989
#			ShapesDocument.cp		March 1, 1989
#			TApplication.r			March 1, 1989
#			ShapesApp.r				March 1, 1989
#
#   There are four main classes in this program. Each of
#   these classes has a definition (.h) file and an
#   implementation (.cp) file.  
#   
#   The TApplication class does all of the basic event
#   handling and initialization necessary for Mac Toolbox
#   applications. It maintains a list of TDocument objects,
#   and passes events to the correct TDocument class when
#   apropriate. 
#   
#   The TDocument class does all of the basic document
#   handling work. TDocuments are objects that are
#   associated with a window. Methods are provided to deal
#   with update, activate, mouse-click, key down, and other
#   events. Some additional classes which implement a
#   linked list of TDocument objects are provided. 
#   
#   The TApplication and TDocument classes together define
#   a basic framework for Mac applications, without having
#   any specific knowledge about the type of data being
#   displayed by the application's documents. They are a
#   (very) crude implementation of the MacApp application
#   model, without the sophisticated view heirarchies or
#   any real error handling. 
#   
#   The TShapesApp class is a subclass of TApplication. It
#   overrides several TApplication methods, including those
#   for handling menu commands and cursor adjustment, and
#   it does some necessary initialization.
#   
#   The TShapesDocument class is a subclass of TDocument. This
#   class contains most of the special purpose code for
#   shape drawing. In addition to overriding several of the
#   TDocument methods, it defines a few additional
#   methods which are used by the TShapesApp class to get
#   information on the document state.  
#
#------------------------------------------------------------------------------*/

#include "SysTypes.r"
#include "Types.r"

#include "ShapesAppCommon.h"

resource 'vers' (1) {
	0x01, 0x00, release, 0x00,
	verUS,
	"1.00",
	"1.00, Copyright © 1989 Apple Computer, Inc."
};

/* we use an MBAR resource to conveniently load all the menus */

resource 'MBAR' (rMenuBar, preload) {
	{ mApple, mFile, mEdit, mShapes };		/* four menus */
};


resource 'MENU' (mApple, preload) {
	mApple, textMenuProc,
	0b1111111111111111111111111111101,	/* disable dashed line, enable About and DAs */
	enabled, apple,
	{
		"About CPlusShapesApp…",
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

resource 'MENU' (mShapes, preload) {
	mShapes, textMenuProc,
	0b0000000000000000000000000000000,	/* disable everything, program does the enabling */
	enabled, "Shapes",
	{	/* array: 5 elements */
		/* [1] */
		"Round Rect", noIcon, "R", noMark, plain,
		/* [2] */
		"Oval", noIcon, "O", noMark, plain,
		/* [3] */
		"Arc", noIcon, "A", noMark, plain,
		/* [4] */
		"-", noIcon, noKey, noMark, plain,
		/* [5] */
		"Move", noIcon, "M", noMark, plain
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
			"MultiFinder-Aware C++ Shapes Application"
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
	noGrowDocProc, invisible, goAway, 0x0, "Shape Land"
};


resource 'STR#' (kShapesAppErrStrings, purgeable) {
	{
	"Not enough memory to run ShapesApp";
	"Cannot create window";
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
	"MultiFinder-Aware C++ Shape Drawing Application"
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


/*
	File:		InlineInputSample.r

	Contains:	Resource definitions for InlineInputSample

	Copyright:	© 1989-1994 Apple Computer, Inc. All rights reserved.

*/


#if qInline
#define qAppleEvents 1
#endif


#define SystemSevenOrLater 1

#include "SysTypes.r"
#include "Types.r"
#include "CodeFragmentTypes.r"

#include "InlineInputSample.h"


// application signature and name

#define kSignature 'issa'
#if qAppleEvents
#if qInline
#define kApplicationName "InlineInputSample"
#define kApplicationBlurb "Styled TextEdit Application with Inline Input"
#else // qInline
#define kApplicationName "AppleEventsSample"
#define kApplicationBlurb "Styled TextEdit Application with Apple Events"
#endif // qInline
#else // qAppleEvents
#define kApplicationName "SimpleSample"
#define kApplicationBlurb "Styled TextEdit Application"
#endif // qAppleEvents

// constant for disabling all items in a menu

#define allDisabled 0


resource 'vers' (1) {
	0x01, 0x01, release, 0x00, verUS,
	"1.0.1",
	"1.0.1, (c) 1989-1994 Apple Computer, Inc."
};


// we use an MBAR resource to conveniently load all the menus

resource 'MBAR' (rMenuBar, preload) {
	{ mApple, mFile, mEdit, mFont, mFontSize, mStyle };
};


resource 'MENU' (mApple, preload) {
	mApple, textMenuProc,
	allEnabled,
	enabled, apple,
	{
		"About " kApplicationName "...",
			noicon, nokey, nomark, plain;
		"-",
			noicon, nokey, nomark, plain
	}
};

resource 'MENU' (mFile, preload) {
	mFile, textMenuProc,
	allDisabled,
	enabled, "File",
	{
		"New",
			noicon, "N", nomark, plain;
		"Open...",
			noicon, "O", nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Close",
			noicon, "W", nomark, plain;
		"Save",
			noicon, "S", nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Page Setup...",
			noicon, nokey, nomark, plain;
		"Print...",
			noicon, nokey, nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Quit",
			noicon, "Q", nomark, plain
	}
};

resource 'MENU' (mEdit, preload) {
	mEdit, textMenuProc,
	allDisabled,
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
			noicon, nokey, nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Select All",
			noicon, "A", nomark, plain
	}
};

resource 'MENU' (mFont, preload) {
	mFont, textMenuProc,
	allEnabled,
	enabled, "Font",
	 {
	 }
};

resource 'MENU' (mFontSize, preload) {
	mFontSize, textMenuProc,
	allEnabled,
	enabled, "Size",
	 {
	 	"9 Point", noIcon, noKey, noMark, plain,
		"10 Point", noIcon, noKey, noMark, plain,
		"12 Point", noIcon, noKey, noMark, plain,
		"14 Point", noIcon, noKey, noMark, plain,
		"18 Point", noIcon, noKey, noMark, plain,
		"24 Point", noIcon, noKey, noMark, plain
	 }
};

resource 'MENU' (mStyle, preload) {
	mStyle, textMenuProc,
	allEnabled,
	enabled, "Style",
	 {
		"Plain",
			noicon, "P", nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Bold",
			noicon, "B", nomark, bold;
		"Italic",
			noicon, "I", nomark, italic;
		"Underline",
			noicon, "U", nomark, underline;
		"Outline",
			noicon, nokey, nomark, outline;
		"Shadow",
			noicon, nokey, nomark, shadow
	}
};


/* this ALRT and DITL are used as an About screen */

resource 'ALRT' (rAboutAlert, purgeable) {
	{40, 20, 210, 340},
	rAboutAlert,
	{	OK, visible, silent,
		OK, visible, silent,
		OK, visible, silent,
		OK, visible, silent
	},
	alertPositionMainScreen
};

resource 'DITL' (rAboutAlert, purgeable) {
	{	/* array DITLarray: 5 elements */
		/* [1] */
		{140, 230, 160, 310},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{10, 10, 26, 329},
		StaticText {
			disabled,
			kApplicationBlurb
		},
		/* [3] */
		{30, 10, 62, 336},
		StaticText {
			disabled,
			"(c) 1989-1994 Apple Computer, Inc. \n"
			"All rights reserved."
		},
		/* [4] */
		{70, 10, 86, 139},
		StaticText {
			disabled,
			"Brought to you by:"
		},
		/* [5] */
		{90, 30, 122, 299},
		StaticText {
			disabled,
			"Developer Support Center &\n"
			"International Software Support"
		}
	}
};


/* this ALRT and DITL are used as an error screen */

resource 'ALRT' (rUserAlert, purgeable) {
	{40, 20, 150, 260},
	rUserAlert,
	{ /* array: 4 elements */
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


resource 'DITL' (rUserAlert, purgeable) {
	{ /* array DITLarray: 3 elements */
		/* [1] */
		{80, 150, 100, 230},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{10, 60, 60, 230},
		StaticText {
			disabled,
			"Error. ^0"
		},
		/* [3] */
		{8, 8, 40, 40},
		Icon {
			disabled,
			2
		}
	}
};


resource 'WIND' (rDocWindow, preload, purgeable) {
	{64, 60, 314, 460},
	zoomDocProc, invisible, goAway, 0x0, "Untitled",
	staggerParentWindowScreen
};


resource 'CNTL' (rVScroll, preload, purgeable) {
	{-1, 385, 236, 401},
	0, visible, 0, 0, scrollBarProc, 0, ""
};


resource 'CNTL' (rHScroll, preload, purgeable) {
	{235, -1, 251, 386},
	0, visible, 0, 0, scrollBarProc, 0, ""
};

resource 'STR#' (rErrorStrings, purgeable) {
	{
	kApplicationName " needs at least a Macintosh 512Ke to run.";
	kApplicationName " needs at least system software 6.0 to run.";
	"Application memory size is too small.";
	"Not enough memory to run " kApplicationName ".";
	"Not enough memory to do Cut.";
	"Cannot do Cut.";
	"Cannot do Copy.";
	"Cannot exceed 32,000 characters with Paste.";
	"Not enough memory to do Paste.";
	"Cannot create window.";
	"Cannot exceed 32,000 characters.";
	"Cannot do Paste."
	}
};


resource 'SIZE' (-1) {
	dontSaveScreen,
	acceptSuspendResumeEvents,
	enableOptionSwitch,
	canBackground,				/* we can background; we don't currently, but our sleep value */
								/* guarantees we don't hog the Mac while we are in the background */
	doesActivateOnFGSwitch,		/* this says we do our own activate/deactivate; don't fake us out */
	backgroundAndForeground,	/* this is definitely not a background-only application! */
	dontGetFrontClicks,			/* change this is if you want "do first click" behavior like the Finder */
	ignoreAppDiedEvents,		/* essentially, I'm not a debugger (sub-launching) */
	is32BitCompatible,
#if qAppleEvents
	isHighLevelEventAware,
	localAndRemoteHLEvents,
#else // qAppleEvents
	notHighLevelEventAware,
	reserved,
#endif // qAppleEvents
	notStationeryAware,
	dontUseTextEditServices,
	reserved,
	reserved,
	reserved,
	128 * 1024,					// with styled TextEdit and printing, it's rather difficult to
	64 * 1024					// define reasonable memory requirements. These are just guesses.
};


#if qPowerPC
resource 'cfrg' (0) {
   {
      kPowerPC,
      kFullLib,
	  kNoVersionNum, kNoVersionNum,
	  kDefaultStackSize, kNoAppSubFolder,
	  kIsApp, kOnDiskFlat, kZeroOffset, kWholeFork,
	  kApplicationName
   }
};
#endif


type kSignature as 'STR ';


resource kSignature (0) {
	kApplicationName ": "
	kApplicationBlurb ". "
	"© 1989-1994 Apple Computer, Inc. All rights reserved."
};


resource 'BNDL' (128) {
	kSignature,
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


resource 'ICN#' (128, purgeable) {
	{	/* array: 2 elements */
		/* [1] */
		$"0001 0000 0002 8000 0004 4000 0008 2000"
		$"0010 101C 0021 0822 0042 0441 0084 42A1"
		$"0108 8151 0211 12AA 0422 2554 0800 4AA8"
		$"1088 1550 2111 2AA8 4202 5544 8444 AA82"
		$"4088 9501 2110 CA02 1020 E404 0840 F808"
		$"0400 0010 0200 0020 0100 0040 0080 0080"
		$"0040 0100 0020 0200 0010 0400 0008 0800"
		$"0004 1000 0002 2000 0001 4000 0000 80",
		/* [2] */
		$"0001 0000 0003 8000 0007 C000 000F E000"
		$"001F F01C 003F F83E 007F FC7F 00FF FEFF"
		$"01FF FFFF 03FF FFFE 07FF FFFC 0FFF FFF8"
		$"1FFF FFF0 3FFF FFF8 7FFF FFFC FFFF FFFE"
		$"7FFF FFFF 3FFF FFFE 1FFF FFFC 0FFF FFF8"
		$"07FF FFF0 03FF FFE0 01FF FFC0 00FF FF80"
		$"007F FF00 003F FE00 001F FC00 000F F800"
		$"0007 F000 0003 E000 0001 C000 0000 80"
	}
};

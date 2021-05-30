/*
	File:		ModApp.r

	Contains:	Resource definitions for the small modular application

	Written by:	Richard Clark

	Copyright:	© 1993,1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				  2/9/94	RC		Changed version to "1.0 final"
				 1/26/94	RC		Increased memory partition to handle larger windows,
				 					and turned on the "accepts suspend/resume events" bit
									in the SIZE resource
				 1/13/94	RC		Added String for "No Mixed Mode"
				  7/2/93	RC		d1 release

	To Do:
*/

#define SystemSevenOrLater 1

#include "Types.r"
#include "SysTypes.r"

resource 'STR ' (1001, "Tool Folder Name", purgeable, preload) {
	"Modules"
};

resource 'STR#' (1001, "Tool menu strings", purgeable, preload) {
	{	/* array StringArray: 1 elements */
		/* [1] */
		"No tools found"
	}
};

resource 'STR#' (1002, "Error messages", purgeable, preload) {
	{
		"This application requires System 7 or later",
		"The Code Fragment Manager is not available on this machine",
		"Mixed Mode is not available on this machine",
		"Could not find tool code"
	}
};

resource 'WIND' (1001, "Display Window", purgeable, preload) {
	{44, 16, 344, 316},
	zoomDocProc,
	visible,
	goAway,
	0x0,
	Untitled,
	staggerMainScreen
};

resource 'vers' (1) {
	0x1,
	0x0,
	final,
	0x0,
	verUS,
	"1.0",
	"1.0 by Richard Clark"
};

resource 'MENU' (1005, "Debug", preload) {
	1005,
	textMenuProc,
	allEnabled,
	enabled,
	"Debug",
	{	/* array: 1 elements */
		/* [1] */
		"Debug", noIcon, "D", noMark, plain
	}
};

resource 'MENU' (1003, "Edit", preload) {
	1003,
	textMenuProc,
	0x7FFFFFBD,
	disabled,
	"Edit",
	{	/* array: 6 elements */
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
		"Clear", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (1002, "File", preload) {
	1002,
	textMenuProc,
	allEnabled,
	enabled,
	"File",
	{	/* array: 4 elements */
		/* [1] */
		"New", noIcon, "N", noMark, plain,
		/* [2] */
		"Close", noIcon, "W", noMark, plain,
		/* [3] */
		"-", noIcon, noKey, noMark, plain,
		/* [4] */
		"Quit", noIcon, "Q", noMark, plain
	}
};

resource 'MENU' (1001, "Apple", preload) {
	1001,
	textMenuProc,
	0x7FFFFFFD,
	enabled,
	apple,
	{	/* array: 2 elements */
		/* [1] */
		"About ModApp…", noIcon, noKey, noMark, plain,
		/* [2] */
		"-", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (1004, "Modules", preload) {
	1004,
	textMenuProc,
	0x7FFFFFFE,
	enabled,
	"Modules",
	{	/* array: 1 elements */
		/* [1] */
		"None loaded", noIcon, noKey, noMark, plain
	}
};

resource 'MBAR' (1001, purgeable, preload) {
	{	/* array MenuArray: 5 elements */
		/* [1] */
		1001,
		/* [2] */
		1002,
		/* [3] */
		1003,
		/* [4] */
		1004,
		/* [5] */
		1005
	}
};

resource 'BNDL' (1000) {
	'moda',
	0,
	{	/* array TypeArray: 2 elements */
		/* [1] */
		'ICN#',
		{	/* array IDArray: 2 elements */
			/* [1] */
			0, 1000,
			/* [2] */
			1, 1001
		},
		/* [2] */
		'FREF',
		{	/* array IDArray: 2 elements */
			/* [1] */
			0, 1000,
			/* [2] */
			1, 1001
		}
	}
};

resource 'ICN#' (1000) {
	{	/* array: 2 elements */
		/* [1] */
		$"0001 0000 0002 8000 000C 4000 0080 2000"
		$"0144 1000 02E0 0800 0531 0400 0A18 0200"
		$"140C 4100 2806 0080 1003 1040 0806 0020"
		$"040C 0410 4218 0208 5134 8004 80E3 8802"
		$"4443 8001 2007 A002 1100 0004 0800 8008"
		$"0440 0010 0202 0020 0110 0040 0088 0080"
		$"0040 0100 0020 0200 0010 0400 0008 0800"
		$"0004 1000 0002 2000 0001 4000 0000 80",
		/* [2] */
		$"0001 0000 0003 8000 000F C000 008F E000"
		$"01DF F000 03FF F800 07FF FC00 0FFF FE00"
		$"1FFF FF00 3FFF FF80 1FFF FFC0 0FFF FFE0"
		$"1FFF FFF0 7FFF FFF8 7FFF FFFC FFFF FFFE"
		$"7FFF FFFF 3FFF FFFE 1FFF FFFC 0FFF FFF8"
		$"07FF FFF0 03FF FFE0 01FF FFC0 00FF FF80"
		$"007F FF00 003F FE00 001F FC00 000F F800"
		$"0007 F000 0003 E000 0001 C000 0000 80"
	}
};

resource 'ICN#' (1001) {
	{	/* array: 2 elements */
		/* [1] */
		$"1FFF FC00 1000 0600 1000 0500 1000 0480"
		$"1000 0440 1000 0420 1000 07F0 1000 0010"
		$"13FF FF10 12EA AB10 13B5 5510 12EA AB10"
		$"13FF FF10 1200 0510 1200 0510 1200 0510"
		$"1200 0510 1200 0510 1200 0510 1200 0510"
		$"1200 0510 13FF FF10 1200 0710 13FF FF10"
		$"1000 0010 1001 0010 1001 0010 1007 C010"
		$"1003 8010 1001 0010 1000 0010 1FFF FFF0",
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

resource 'FREF' (1000) {
	'APPL',
	0,
	""
};

resource 'FREF' (1001) {
	'modt',
	1,
	""
};

resource 'SIZE' (-1) {
	reserved,
	acceptSuspendResumeEvents,
	reserved,
	canBackground,
	multiFinderAware,
	backgroundAndForeground,
	dontGetFrontClicks,
	ignoreChildDiedEvents,
	is32BitCompatible,
	isHighLevelEventAware,
	onlyLocalHLEvents,
	notStationeryAware,
	dontUseTextEditServices,
	reserved,
	reserved,
	reserved,
	1500 * 1024,
	750 * 1024
};

resource 'ALRT' (1001, "About", purgeable) {
	{57, 37, 246, 386},
	1001,
	{	/* array: 4 elements */
		/* [1] */
		OK, visible, sound1,
		/* [2] */
		OK, visible, sound1,
		/* [3] */
		OK, visible, sound1,
		/* [4] */
		OK, visible, sound1
	},
	alertPositionMainScreen
};

resource 'DITL' (1001, "About", purgeable) {
	{	/* array DITLarray: 2 elements */
		/* [1] */
		{150, 170, 170, 230},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{8, 80, 109, 332},
		StaticText {
			disabled,
			"“Modular” demonstration application by Richard Clark.\n\n"
			"This application uses plug-in modules to generate all window contents."
		}
	}
};

resource 'ALRT' (1002, "Error", purgeable) {
	{383, 390, 487, 762},
	1002,
	{	/* array: 4 elements */
		/* [1] */
		OK, visible, sound1,
		/* [2] */
		OK, visible, sound1,
		/* [3] */
		OK, visible, sound1,
		/* [4] */
		OK, visible, sound1
	},
	alertPositionMainScreen
};

resource 'DITL' (1002, purgeable) {
	{	/* array DITLarray: 2 elements */
		/* [1] */
		{76, 292, 96, 360},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{12, 64, 60, 356},
		StaticText {
			disabled,
			"^0^1"
		}
	}
};


resource 'SICN' (128) {
	{	/* array: 1 elements */
		/* [1] */
		$"0100 0280 0440 0E20 1B10 3588 5AC4 8D82"
		$"4701 2202 1004 0808 0410 0220 0140 0080"
	}
};

type 'moda' as 'STR ';

resource 'moda' (0, "Owner resource") {
	"version 1.0d1 by Richard Clark"
};

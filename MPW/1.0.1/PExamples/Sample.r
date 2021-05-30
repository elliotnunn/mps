/*------------------------------------------------------------------------------

	  Sample.r	-  Resources for the Sample Application

	  Copyright Apple Computer, Inc. 1985, 1986
	  All rights reserved.

------------------------------------------------------------------------------*/

#include "Types.r"

/* These define's are used in the MENU resources to disable specific
   menu items. */
#define AllItems	0b1111111111111111111111111111111	/* 31 flags */
#define MenuItem1	0b00001
#define MenuItem2	0b00010
#define MenuItem3	0b00100
#define MenuItem4	0b01000
#define MenuItem5	0b10000

resource 'WIND' (128, "Sample Window") {
	{64, 60, 314, 460},
	documentProc, visible, noGoAway, 0x0, "Sample Window"
};

resource 'DLOG' (128, "About Sample…") {
	{66, 102, 224, 400},
	dBoxProc, visible, noGoAway, 0x0, 128, ""
};

resource 'DITL' (128) {
	 {
/* 1 */ {130, 205, 150, 284},
		button {
			enabled,
			"Continue"
		};
/* 2 */ {104, 144, 120, 296},				/* SourceLanguage Item */
		staticText {
			disabled,
			""
		};
/* 3 */ {88, 144, 105, 218},				/* Author Item */
		staticText {
			disabled,
			""
		};
/* 4 */ {8, 32, 26, 273},
		staticText {
			disabled,
			"Macintosh Programmer's Workshop"
		};
/* 5 */ {32, 80, 50, 212},
		staticText {
			disabled,
			"Sample Application"
		};
/* 6 */ {56, 16, 74, 281},
		staticText {
			enabled, "Copyright © 1985,1986 Apple Computer"
		};
/* 7 */ {88, 16, 104, 144},
		staticText {
			enabled, "Source Language:"
		};
/* 8 */ {104, 16, 120, 144},
		staticText {
			enabled, "Brought to you by:"
		}
	}
};

resource 'MENU' (128, "Apple", preload) {
	128, textMenuProc,
	AllItems & ~MenuItem2,	/* Disable item #2 */
	enabled, apple,
	{
		"About Sample…",
			noicon, nokey, nomark, plain;
		"-",
			noicon, nokey, nomark, plain
	}
};

resource 'MENU' (129, "File", preload) {
	129, textMenuProc,
	allEnabled,
	enabled, "File",
	{
		"Quit",
			noicon, "Q", nomark, plain
	}
};

resource 'MENU' (130, "Edit", preload) {
	130, textMenuProc,
	AllItems & ~(MenuItem1 | MenuItem2),	/* Disable items #1 & #2 */
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


type 'SAMP' as 'STR ';

resource 'SAMP' (0) {
	"Sample Application - Version 1.0"
};


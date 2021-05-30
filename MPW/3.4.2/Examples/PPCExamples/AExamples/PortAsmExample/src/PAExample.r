/*------------------------------------------------------------------------------
;
;	PortAsm Simple Example	By Steven Ellis
;
;	Copyright MicroAPL Ltd 1993/4
;
;	PAExample.r - Rez Source
;
------------------------------------------------------------------------------*/


#include "SysTypes.r"
#include "Types.r"

/* Various values required to set up the resources */

#define	rMenuBar	128				/* application's menu bar */
#define	rUserAlert	129				/* error user alert */
#define	rWindow		128				/* application's window */

/* The following constants are used to identify menus and their items. The menu IDs
   have an "m" prefix and the item numbers within each menu have an "i" prefix. */

#define	mApple					128		/* Apple menu */
#define	iAbout					1

#define	mFile					129		/* File menu */
#define	iNew					1
#define	iClose					4
#define	iQuit					12

#define	mEdit					130		/* Edit menu */
#define	iUndo					1
#define	iCut					3
#define	iCopy					4
#define	iPaste					5
#define	iClear					6

#define	mColor					131		/* Color menu */
#define	iRed					1
#define	iYellow					2
#define	iMagenta				3
#define	iGreen					4
#define iCyan					5
#define	iBlue					6
#define	iBlack					7

#define	mRandom					132		/* Random menu */
#define iColor					1
#define	iPolygon				2
#define	iDirection				3

#define	mSound					133		/* Sound menu */
#define iSoundOff				1
#define	iSoundOn				2


/* these #defines are used to set enable/disable flags of a menu */

#define AllItems	0b1111111111111111111111111111111	/* 31 flags */
#define NoItems		0b0000000000000000000000000000000
#define MenuItem1	0b0000000000000000000000000000001
#define MenuItem2	0b0000000000000000000000000000010
#define MenuItem3	0b0000000000000000000000000000100
#define MenuItem4	0b0000000000000000000000000001000
#define MenuItem5	0b0000000000000000000000000010000
#define MenuItem6	0b0000000000000000000000000100000
#define MenuItem7	0b0000000000000000000000001000000
#define MenuItem8	0b0000000000000000000000010000000
#define MenuItem9	0b0000000000000000000000100000000
#define MenuItem10	0b0000000000000000000001000000000
#define MenuItem11	0b0000000000000000000010000000000
#define MenuItem12	0b0000000000000000000100000000000

resource 'vers' (1) {
	0x02, 0x00, release, 0x00,
	verUS,
	"0.01",
	"0.01, Copyright \251 MicroAPL Ltd 1993"
};


/* this is a definition for a resource which contains only a rectangle */

type 'RECT' {
	rect;
};


/* we use an MBAR resource to conveniently load all the menus */

resource 'MBAR' (rMenuBar, preload) {
	{ mApple, mFile, mEdit, mColor, mRandom, mSound};	/* four menus */
};


resource 'MENU' (mApple, preload) {
	mApple, textMenuProc,
	AllItems & ~MenuItem2,	/* Disable dashed line, enable About and DAs */
	enabled, apple,
	{
		"About Example…",
			noicon, nokey, nomark, plain;
		"-",
			noicon, nokey, nomark, plain
	}
};

resource 'MENU' (mFile, preload) {
	mFile, textMenuProc,
	MenuItem1 | MenuItem12,				/* enable Quit and New only, program enables others */
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
	NoItems,				/* disable everything, program does the enabling */
	disabled, "Edit",
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

resource 'MENU' (mColor, preload) {
	mColor, textMenuProc,
	AllItems,				/* disable everything, program does the enabling */
	enabled, "Colors",
	 {
		"Red",
			noicon, nokey, nomark, plain;
		"Yellow",
			noicon, nokey, nomark, plain;
		"Magenta",
			noicon, nokey, nomark, plain;
		"Green",
			noicon, nokey, nomark, plain;
		"Cyan",
			noicon, nokey, nomark, plain;
		"Blue",
			noicon, nokey, nomark, plain;
		"Black",
			noicon, nokey, nomark, plain
	}
};

resource 'MENU' (mRandom, preload) {
	mRandom, textMenuProc,
	AllItems,				/* enable everything */
	enabled, "Random",
	 {
		"Color",
			noicon, nokey, nomark, plain;
		"Polygons",
			noicon, nokey, nomark, plain;
		"Direction",
			noicon, nokey, nomark, plain;
	}
};

resource 'MENU' (mSound, preload) {
	mSound, textMenuProc,
	AllItems,				/* enable everything */
	enabled, "Sound",
	 {
		"Off  ",
			noicon, nokey, nomark, plain;
		"On   ",
			noicon, nokey, nomark, plain;
	}
};

/* this ALRT and DITL are used as an error screen */

resource 'ALRT' (rUserAlert, purgeable) {
	{40, 20, 120, 260},
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
	}
};


resource 'DITL' (rUserAlert, purgeable) {
	{ /* array DITLarray: 3 elements */
		/* [1] */
		{50, 150, 70, 230},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{10, 60, 30, 230},
		StaticText {
			disabled,
			"Example - Error occurred!"
		},
		/* [3] */
		{8, 8, 40, 40},
		Icon {
			disabled,
			2
		}
	}
};


resource 'WIND' (rWindow, preload, purgeable) {
	{60, 40, 460, 540},
	0, visible, GoAway, 0x0, "PortAsm Example"
};


data 'SIZE' (-1) {
	$"5800 0005 7800 0001 6800"                           /* X...x...h. */
};


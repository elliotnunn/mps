/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple Input/Output Window
#
#	SIOW
#
#	Copyright:	© 1989-1999 by Apple Computer, Inc., all rights reserved.
#
------------------------------------------------------------------------------*/


#include "Types.r"
#include "BalloonTypes.r"

#include "SIOW.h"

#ifndef CREATOR
	#define CREATOR 'siow'
#endif

#ifndef WINDOW_HEIGHT
	#ifdef WINDOW_HEIGTH	/* old, misspelled name */
		#define WINDOW_HEIGHT WINDOW_HEIGTH
	#else
		#define WINDOW_HEIGHT 286
	#endif
#endif

#ifndef WINDOW_WIDTH
	#define WINDOW_WIDTH 480
#endif

#define VERSION	"3.5"

resource 'vers' (1) {
	0x3,
	0x50,
	release,
	0,
	verUS,
	VERSION,
	"Built with SIOW "VERSION", © 1989-1999 Apple Computer, Inc."
};

type 'FtSz'
{
	integer; /* font size or other preference value */
};

type 'siow' as 'STR ';

resource 'siow' (0, purgeable) 
{
	"An SIOW application"
};

/* we use an MBAR resource to conveniently load all the menus */

resource 'MBAR' (__rMenuBar, preload) 
{
	{ __mApple, __mFile, __mEdit, __mFont, __mSize, __mControl };		/* five menus */
};


resource 'MENU' (__mApple, preload) 
{
	__mApple, textMenuProc,
	0b1111111111111111111111111111101,	/* disable dashed line, enable About and DAs */
	enabled, apple,
	{
		"About S I O W...",		/* use ... instead of … for compatibility with non-roman systems */
			noicon, nokey, nomark, plain;
		"-",
			noicon, nokey, nomark, plain
	}
};

resource 'MENU' (__mFile, preload) 
{
	__mFile, textMenuProc,
	0b000000000000000000000000000000,	/* enable Quit only, program enables others */
	enabled, "File",
	{
		"New",				/* not used by SIOW */
			noicon, "N", nomark, plain;
		"Open",				/* not used by SIOW */
			noicon, "O", nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Close",
			noicon, "W", nomark, plain;
		"Save",
			noicon, "S", nomark, plain;
		"Save As...",		/* use ... instead of … for compatibility with non-roman systems */
			noicon, nokey, nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Page Setup...",	/* use ... instead of … for compatibility with non-roman systems */
			noicon, nokey, nomark, plain;
		"Print...",			/* use ... instead of … for compatibility with non-roman systems */
			noicon, "P", nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Quit",
			noicon, "Q", nomark, plain
	}
};

resource 'MENU' (__mEdit, preload) {
	__mEdit, textMenuProc,
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
			noicon, nokey, nomark, plain;
		"-",
			noicon, nokey, nomark, plain;
		"Select All",
			noicon, "A", nomark, plain
	}
};

resource 'MENU' (__mControl, preload) {
	__mControl, textMenuProc,
	0b1111111111111111111111111111111,	/* disable everything, program does the enabling */
	enabled, "Control",
	 {
		"Force End Of Input File",					/* cmd-d == ctrl-d */
			noicon, "D", nomark, plain;
		"Pause",
			noicon, "T", nomark, plain;		
		"Stop",
			noicon, ".", nomark, plain		/* cmd-period == ctrl-c */
	}
};

resource 'MENU' (__mFont, preload) {
	__mFont, textMenuProc,
	0b1111111111111111111111111111111,	/* enable everything */
	enabled, "Font",
	 {
	 }
};

resource 'MENU' (20004, "Size") {
	__mSize, textMenuProc,
	allEnabled,
	enabled, "Size",
	{
		"9", 
			noIcon, noKey, noMark, plain,

		"10", 
			noIcon, noKey, noMark, plain,

		"12", 
			noIcon, noKey, noMark, plain,

		"14", 
			noIcon, noKey, noMark, plain,

		"18", 
			noIcon, noKey, noMark, plain,

		"24", 
			noIcon, noKey, noMark, plain,

		"36", 
			noIcon, noKey, noMark, plain
	}
};

/* this ALRT and DITL are used as an About screen */

resource 'ALRT' (__rAboutAlert, purgeable) {
// 12/13/93 - GAB: support for native PowerPC version

	{36, 58, 314, 396},

	 __rAboutAlert, {
		OK, visible, silent;
		OK, visible, silent;
		OK, visible, silent;
		OK, visible, silent
	}
#if ALRT_RezTemplateVersion == 1
	/*	The following are window positioning options ,usable in 7.0	*/
	, centerParentWindowScreen;
#endif
};

resource 'DITL' (__rAboutAlert, purgeable) {
	{	/* array DITLarray: 10 elements */
		/* [1] */
		{233, 144, 253, 224},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{8, 14, 24, 327},
		StaticText {
			disabled,
			"Simple Input/Output Window (SIOW) v" VERSION
		},
		/* [3] */
		{56, 14, 72, 327},
		StaticText {
			disabled,
			$$Format("Copyright © Apple Computer, Inc. 1989-%d ", $$Year)
		},
		/* [4] */
		{80, 108, 96, 244},
		StaticText {
			disabled,
			"Updated by"
		},
		/* [5] */
		{109, 132, 125, 229},
		StaticText {
			disabled,
			"Herb Ruth"
		},
		/* [6] */
		{152, 24, 170, 212},
		StaticText {
			disabled,
			"Special Thanks to..."
		},
		/* [7] */
		{176, 56, 194, 289},
		StaticText {
			disabled,
			"Roger, Russ, Landon, Ira, ",
		},
		/* [8] */
		{204, 56, 222, 289},
		StaticText {
			disabled,
			"Munch, Greg, and Scott."
		},
	}
};

/* this ALRT and DITL are used as an error screen */

resource 'ALRT' (__rUserAlert, purgeable) {
	{40, 20, 211, 356},
	__rUserAlert,
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
#if ALRT_RezTemplateVersion == 1
	, alertPositionParentWindowScreen
#endif
};


resource 'DITL' (__rUserAlert, purgeable) {
	{ /* array DITLarray: 3 elements */
		/* [1] */
		{138, 240, 158, 320},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{10, 60, 129, 319},
		StaticText {
			disabled,
			"^0^1^2^3"
		},
	}
};


resource 'WIND' (__rDocWindow, preload, purgeable) {
	{0, 0, WINDOW_HEIGHT, WINDOW_WIDTH},
	zoomDocProc, invisible, noGoAway, 0x0, DEFAULT_WINDOW_NAME
	/*	The following are window positioning options ,usable in 7.0	*/
#if WIND_RezTemplateVersion == 1
	, centerMainScreen
#endif
};

resource 'CNTL' (__rVScroll, preload, purgeable) {
	{-1, WINDOW_WIDTH-15, WINDOW_HEIGHT-14, WINDOW_WIDTH+1},
	0, invisible, 0, 0, scrollBarProc, 0, ""
};

resource 'CNTL' (__rHScroll, preload, purgeable) {
	{WINDOW_HEIGHT-15, -1, WINDOW_HEIGHT+1, WINDOW_WIDTH-14},
	0, invisible, 0, 0, scrollBarProc, 0, ""
};

resource 'STR ' (__rFontPrefStr, preload, purgeable )
{
	DEFAULT_FONT_NAME
};

resource 'STR ' (__rPauseMenuText, preload, purgeable )
{
	"Pause"
};

resource 'STR ' (__rResumeMenuText, preload, purgeable )
{
	"Resume"
};

resource 'STR ' (__rOutfilePrefStr, preload, purgeable )
{
	DEFAULT_OUTFILE_NAME
};

resource 'FtSz' (__rFontPrefStr, preload, purgeable )
{
	DEFAULT_FONT_SIZE
};

resource 'FtSz' (__rSavePref, preload, purgeable )
{
	DEFAULT_SAVE_PREF
};

resource 'FtSz' (__rStopPref, preload, purgeable )
{
	DEFAULT_STOP_PREF
};

resource 'FtSz' (__rWindowWidthPref, preload, purgeable )
{
	DEFAULT_WINDOW_SIZE
};

resource 'STR#' (__kErrStrings, purgeable) {
	{
	/* __eWrongMachine */ 			"You must run on 512Ke or later";
	/* __eSmallSize */				"Application Memory Size is too small";
	/* __eNoMemory */ 				"Not enough memory to run SIOW";
	/* __eNoSpaceCut */				"Not enough memory to do Cut";
	/* __eNoCut */					"Cannot do Cut";
	/* __eNoCopy */					"Cannot do Copy";
	/* __eExceedPaste */			"Cannot exceed 32,000 characters with Paste";
	/* __eNoSpacePaste */			"Not enough memory to do Paste";
	/* __eNoWindow */ 				"Cannot create window";
	/* __eExceedChar */				"Cannot exceed 32,000 characters";
	/* __eNoPaste */				"Cannot do Paste";
	/* __eNofont */					"Font not found";
	/* __eNoInputMoreThanReq */		"Your input was longer than this program was requesting; it will be truncated.";
	/* __eDontNeedToSaveAgain */	"You do not need to save again. All input and output since your last save has been written to the file you specified."
	}
};

/* here is the quintessential MultiFinder friendliness device, the SIZE resource */

resource 'SIZE' (-1) {
	dontSaveScreen,
	acceptSuspendResumeEvents,
	enableOptionSwitch,
	canBackground,				/* we can background. Our sleep value */
								/* guarantees we don't hog the Mac. */
	multiFinderAware,			/* this says we do our own activate/deactivate; don't fake us out. */
	backgroundAndForeground,	/* this is definitely not a background-only application! */
	dontGetFrontClicks,			/* change this is if you want "do first click" behavior like the Finder. */
	ignoreChildDiedEvents,		/* essentially, I'm not a debugger (sub-launching). */
	is32BitCompatible,			/* this app should be run in 32-bit address space. */
	isHighLevelEventAware,		/* accepts the core apple-events. */
	localAndRemoteHLEvents,		/* change to 'reserved' if you don't like remote-control. */
	notStationeryAware,			/* not stationery-aware. */
	dontUseTextEditServices,	/* can't handle inline input of chinese, etc. */
	reserved,
	reserved,
	reserved,
	__kPrefSize * 1024,
	__kMinSize * 1024	
};

/* If you want to restrict your SIOW application to only opening 			*/
/* TEXT files, replace the FREFs for '****' (any file), 'disk' (disk icon) 	*/
/* and 'fold' (any folder) into a single FREF for 'TEXT'. Alter the BNDL 	*/
/* resource and the 'open' resource to match.								*/

resource 'BNDL' (128) {
	CREATOR,	0,
	{
		'FREF',
		{
			0, 128,		/* APPL */
			1, 129,		/* **** */
			2, 130,		/* disk */
			3, 131		/* fold */
		},
		'ICN#',
		{
			0, 128,		/* APPL */
			1, 129,		/* **** */
			2, 130,		/* disk */
			3, 131		/* fold */
		},
	}
};

resource 'FREF' (128) {
	'APPL',	0,	""
};

resource 'FREF' (129) {
	'****',	0,	""
};

resource 'FREF' (130) {
	'disk',	0,	""
};

resource 'FREF' (131) {
	'fold',	0,	""
};

resource 'open' (128) {   /* for the Translation Manager aka Easy Open */
	CREATOR,
	{	
		'****', 
		'disk', 	
		'fold'	
	}
};

resource 'ALRT' (__rSaveAlert, preload) {
	{72, 64, 168, 407},
	__rSaveAlert,
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
	/*	The following are window positioning options ,usable in 7.0	*/
#if ALRT_RezTemplateVersion == 1
	, alertPositionParentWindowScreen
#endif
	;
};

resource 'DITL' (__rSaveAlert, preload) {
	{	/* array DITLarray: 3 elements */
		/* [1] */
		{60, 253, 80, 327},
		Button {
			enabled,
			"Save"
		},
		/* [2] */
		{60, 157, 80, 231},
		Button {
			enabled,
			"Quit"
		},
		/* [3] */
		{10, 112, 42, 325},
		StaticText {
			disabled,
			"Save changes before quitting?"
		},
	}
};


// PPCLINK creates appropriate 'cfrg' resource. Don't do it yourself.
//#ifdef APPNAME	// only include 'cfrg' in native PowerPC apps
//#include "CodeFragmentTypes.r"
//resource 'cfrg' (0) {
//	{
//		kPowerPC,
//		kFullLib,
//		kNoVersionNum,kNoVersionNum,
//		0,0,
//		kIsApp,kOnDiskFlat,kZeroOffset,kWholeFork,
//		APPNAME	// must be defined on Rez command line with -d option
//	}
//};
//#endif

resource 'ALRT' (__rQuitAlert, preload) {
	{74, 68, 176, 399},
	__rQuitAlert,
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
	/*	The following are window positioning options ,usable in 7.0	*/
#if ALRT_RezTemplateVersion == 1
	, alertPositionParentWindowScreen
#endif
	;
};

resource 'DITL' (__rQuitAlert, preload) {
	{	/* array DITLarray: 3 elements */
		/* [1] */
		{70, 240, 90, 316},
		Button {
			enabled,
			"Stop"
		},
		/* [2] */
		{70, 151, 90, 225},
		Button {
			enabled,
			"Continue"
		},
		/* [3] */
		{10, 111, 58, 313},
		StaticText {
			disabled,
			"Stop running this application?"
		},
	}
};

data 'ICN#' (128) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 1FFF FF00"
	$"1000 0100 1FFF FF00 1000 0100 1000 0100"
	$"13FF 8100 1000 0100 11FF 8100 1000 3F80"
	$"107F C0C0 1000 8040 11FF 3020 1001 C810"
	$"10FE 7F8F 1002 3007 1001 0007 1000 8007"
	$"1FFF E007 0000 1FE7 0000 001F 0000 0007"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 1FFF FF00"
	$"1FFF FF00 1FFF FF00 1FFF FF00 1FFF FF00"
	$"1FFF FF00 1FFF FF00 1FFF FF00 1FFF FF80"
	$"1FFF FFC0 1FFF FFC0 1FFF FFE0 1FFF FFF0"
	$"1FFF FFFF 1FFF FFFF 1FFF FFFF 1FFF FFFF"
	$"1FFF FFFF 0000 1FFF 0000 001F 0000 0007"
};
data 'ICN#' (129) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 1FFF FF00"
	$"1000 0100 1FFF FF00 1000 0100 1000 0100"
	$"13FF 8100 1000 0100 11FF 8100 1000 3F80"
	$"107F C0C0 1000 8040 11FF 3020 1001 C810"
	$"10FE 7F8F 1002 3007 1001 0007 1000 8007"
	$"1FFF E007 0000 1FE7 0000 001F 0000 0007"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 1FFF FF00"
	$"1FFF FF00 1FFF FF00 1FFF FF00 1FFF FF00"
	$"1FFF FF00 1FFF FF00 1FFF FF00 1FFF FF80"
	$"1FFF FFC0 1FFF FFC0 1FFF FFE0 1FFF FFF0"
	$"1FFF FFFF 1FFF FFFF 1FFF FFFF 1FFF FFFF"
	$"1FFF FFFF 0000 1FFF 0000 001F 0000 0007"
};
data 'ICN#' (130) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 1FFF FF00"
	$"1000 0100 1FFF FF00 1000 0100 1000 0100"
	$"13FF 8100 1000 0100 11FF 8100 1000 3F80"
	$"107F C0C0 1000 8040 11FF 3020 1001 C810"
	$"10FE 7F8F 1002 3007 1001 0007 1000 8007"
	$"1FFF E007 0000 1FE7 0000 001F 0000 0007"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 1FFF FF00"
	$"1FFF FF00 1FFF FF00 1FFF FF00 1FFF FF00"
	$"1FFF FF00 1FFF FF00 1FFF FF00 1FFF FF80"
	$"1FFF FFC0 1FFF FFC0 1FFF FFE0 1FFF FFF0"
	$"1FFF FFFF 1FFF FFFF 1FFF FFFF 1FFF FFFF"
	$"1FFF FFFF 0000 1FFF 0000 001F 0000 0007"
};
data 'ICN#' (131) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 1FFF FF00"
	$"1000 0100 1FFF FF00 1000 0100 1000 0100"
	$"13FF 8100 1000 0100 11FF 8100 1000 3F80"
	$"107F C0C0 1000 8040 11FF 3020 1001 C810"
	$"10FE 7F8F 1002 3007 1001 0007 1000 8007"
	$"1FFF E007 0000 1FE7 0000 001F 0000 0007"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 1FFF FF00"
	$"1FFF FF00 1FFF FF00 1FFF FF00 1FFF FF00"
	$"1FFF FF00 1FFF FF00 1FFF FF00 1FFF FF80"
	$"1FFF FFC0 1FFF FFC0 1FFF FFE0 1FFF FFF0"
	$"1FFF FFFF 1FFF FFFF 1FFF FFFF 1FFF FFFF"
	$"1FFF FFFF 0000 1FFF 0000 001F 0000 0007"
};
data 'icl8' (128) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 00FF FFFF FFFF FFFF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF FFFF 0000 0000 0000 0000"
	$"0000 00FF 2B2B 2B2B 2B2B 2B2B 2B2B 2B2B"
	$"2B2B 2B2B 2B2B 2BFF 0000 0000 0000 0000"
	$"0000 00FF FFFF FFFF FFFF FFFF FFFF FFFF"
	$"FFFF FFFF FFFF FFFF 0000 0000 0000 0000"
	$"0000 00FF F5F5 F5F5 F5F5 F5F5 F5F5 F5F5"
	$"F5F5 F5F5 F5F5 F5FF 0000 0000 0000 0000"
	$"0000 00FF F5F5 F5F5 F5F5 F5F5 F5F5 F5F5"
	$"F5F5 F5F5 F5F5 F5FF 0000 0000 0000 0000"
	$"0000 00FF F5F5 FFFF FFFF FFFF FFFF FFFF"
	$"FFF5 F5F5 F5F5 F5FF 0000 0000 0000 0000"
	$"0000 00FF F5F5 F5F5 F5F5 F5F5 F5F5 F5F5"
	$"F5F5 F5F5 F5F5 F5FF 0000 0000 0000 0000"
	$"0000 00FF F5F5 F5FF FFFF FFFF FFFF FFFF"
	$"FFF5 F5F5 F5F5 F5FF 0000 0000 0000 0000"
	$"0000 00FF F5F5 F5F5 F5F5 F5F5 F5F5 F5F5"
	$"F5F5 FFFF FFFF FFFF F500 0000 0000 0000"
	$"0000 00FF F5F5 F5F5 F5FF FFFF FFFF FFFF"
	$"FFFF 0808 0808 0808 FF00 0000 0000 0000"
	$"0000 00FF F5F5 F5F5 F5F5 F5F5 F5F5 F5F5"
	$"FF08 0808 0808 0808 08FF 0000 0000 0000"
	$"0000 00FF F5F5 F5FF FFFF FFFF FFFF FFFF"
	$"0808 FFFF 0808 0808 0808 FF00 0000 0000"
	$"0000 00FF F5F5 F5F5 F5F5 F5F5 F5F5 F5FF"
	$"FFFF 0000 FF08 0808 0808 08FF 0000 0000"
	$"0000 00FF F5F5 F5F5 FFFF FFFF FFFF FF08"
	$"08FF FFFF FFFF FFFF FF08 0808 FFFF FFFF"
	$"0000 00FF F5F5 F5F5 F5F5 F5F5 F5F5 FF08"
	$"0808 FFFF 0808 0808 0808 0808 08FF FFFF"
	$"0000 00FF F5F5 F5F5 F5F5 F5F5 F5F5 F5FF"
	$"0808 0808 0808 0808 0808 0808 08FF FFFF"
	$"0000 00FF F5F5 F5F5 F5F5 F5F5 F5F5 F5F5"
	$"FF08 0808 0808 0808 0808 0808 08FF FFFF"
	$"0000 00FF FFFF FFFF FFFF FFFF FFFF FFFF"
	$"FFFF FF08 0808 0808 0808 0808 08FF FFFF"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 00FF FFFF FFFF FFFF FF08 08FF FFFF"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 00FF FFFF FFFF"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 00FF FFFF"
};

data 'icl4' (128) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"000F FFFF FFFF FFFF FFFF FFFF 0000 0000"
	$"000F CCCC CCCC CCCC CCCC CCCF 0000 0000"
	$"000F FFFF FFFF FFFF FFFF FFFF 0000 0000"
	$"000F C0C0 C0C0 C0C0 C0C0 C0CF 0000 0000"
	$"000F 0C0C 0C0C 0C0C 0C0C 0C0F 0000 0000"
	$"000F C0FF FFFF FFFF F0C0 C0CF 0000 0000"
	$"000F 0C0C 0C0C 0C0C 0C0C 0C0F 0000 0000"
	$"000F C0CF FFFF FFFF F0C0 C0CF 0000 0000"
	$"000F 0C0C 0C0C 0C0C 0CFF FFFF 0000 0000"
	$"000F C0CC CFFF FFFF FFF0 2020 F000 0000"
	$"000F 0C0C 0C0C 0C0C FF02 0202 0F00 0000"
	$"000F C0CF FFFF FFFF F0FF F020 20F0 0000"
	$"000F 0C0C 0C0C 0C0F FF00 FF02 020F 0000"
	$"000F C0C0 FFFF FFF0 2FFF FFFF F020 FFFF"
	$"000F 0C0C 0C0C 0CFF 02FF 0202 0202 0FFF"
	$"000F C0C0 C0C0 C0CF F020 2020 2020 2FFF"
	$"000F 0C0C 0C0C 0C0C FF02 0202 0202 0FFF"
	$"000F FFFF FFFF FFFF FFF0 2020 2020 2FFF"
	$"0000 0000 0000 0000 000F FFFF FFFF 0FFF"
	$"0000 0000 0000 0000 0000 0000 000F FFFF"
	$"0000 0000 0000 0000 0000 0000 0000 0FFF"
};

data 'ics#' (128) {
	$"0000 0000 0000 0000 0000 3FFC 2004 3FFC"
	$"2004 2E74 208C 2BE4 20B3 2043 3FFF 0007"
	$"0000 0000 0000 0000 0000 3FFC 3FFC 3FFC"
	$"3FFC 3FFC 3FFC 3FFC 3FFF 3FFF 3FFF 0007"
};

data 'ics8' (128) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 FFFF FFFF FFFF FFFF FFFF FFFF 0000"
	$"0000 FF00 0000 0000 0000 0000 00FF 0000"
	$"0000 FFFF FFFF FFFF FFFF FFFF FFFF 0000"
	$"0000 FF00 0000 0000 0000 0000 00FF 0000"
	$"0000 FF00 FFFF FF00 00FF FFFF 00FF 0000"
	$"0000 FF00 0000 0000 FF00 0000 FFFF 0000"
	$"0000 FF00 FF00 FFFF FFFF FF00 00FF 0000"
	$"0000 FF00 0000 0000 FF00 FFFF 0000 FFFF"
	$"0000 FF00 0000 0000 00FF 0000 0000 FFFF"
	$"0000 FFFF FFFF FFFF FFFF FFFF FFFF FFFF"
	$"0000 0000 0000 0000 0000 0000 00FF FFFF"
};

data 'ics4' (128) {
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 0000 0000 0000 0000"
	$"0000 0000 0000 0000 00FF FFFF FFFF FF00"
	$"00F0 0000 0000 0F00 00FF FFFF FFFF FF00"
	$"00F0 0000 0000 0F00 00F0 FFF0 0FFF 0F00"
	$"00F0 0000 F000 FF00 00F0 F0FF FFF0 0F00"
	$"00F0 0000 F0FF 00FF 00F0 0000 0F00 00FF"
	$"00FF FFFF FFFF FFFF 0000 0000 0000 0FFF"
};

resource 'STR#' ( __kBalloonStringsResID, purgeable )
{
	{
		/* [1] File Menu, Normal */
			"File menu\n"
			"\n"
			"Use this menu to save or print the SIOW window contents, and to quit this application.",
		
		/* [2] File/New, Grayed */
			"Creates a new document.\n"
			"\n"
			"Not available now because SIOW does not allow creating new documents.",

		/* [3] File/Open, Grayed */
			"Opens a document.\n"
			"\n"
			"Not available now because SIOW does not allow opening documents.",

		/* [4] File/Close, normal */
			"Closes the SIOW window.",

		/* [5] File/Save, normal */
			"Saves the contents of the SIOW window.",

		/* [6] File/Save, Grayed */
			"Saves the contents of the SIOW window.\n"
			"\n"
			"Not available now because no changes have been "
			"made to the SIOW window contents.",

		/* [7] File/Save As, normal */
			"Displays a dialog box in which you can assign a "
			"file name and specify a location to save the "
			"contents of the SIOW window.",

		/* [8] File/Page Setup, normal */
			"Displays a dialog box in which you can select "
			"paper size, orientation, and other printing options.",

		/* [9] File/Print, normal */
			"Displays a dialog box in which you can select "
			"the number of copies to print and other printing options.",

		/* [10] File/Quit, normal */
			"Quits this application. If you have not saved the "
			"contents of the SIOW window, you will be asked whether "
			"you want to save the contents",

		/* [11] Edit Menu, Normal */
			"Edit menu\n"
			"\n"
			"Use this menu to undo your last action, or to manipulate text.",

		/* [12] Edit/Undo, normal */
			"Undoes your last action if it involves cut/copy/paste.",

		/* [13] Edit/Undo, Grayed */
			"Undoes your last action if it involves cut/copy/paste.\n"
			"\n"
			"Not available now because your last action cannot be undone.",

		/* [14] Edit/Cut, normal */
			"Removes the selected text and places it in the temporary "
			"storage area called the Clipboard.",

		/* [15] Edit/Cut, Grayed */
			"Removes the selected text and places it in the temporary "
			"storage area called the Clipboard.\n"
			"\n"
			"Not available now because no text is selected.",

		/* [16] Edit/Copy, normal */
			"Copies the selected text and places it in the temporary "
			"storage area called the Clipboard. The original text stays "
			"where it is.",

		/* [17] Edit/Copy, Grayed */
			"Copies the selected text and places it in the temporary "
			"storage area called the Clipboard. The original text stays "
			"where it is.\n"
			"\n"
			"Not available now because no text is selected.",

		/* [18] Edit/Paste, normal */
			"Copies the contents of the Clipboard into the current "
			"text-insertion point.",

		/* [19] Edit/Paste, Grayed */
			"Copies the contents of the Clipboard into the current "
			"text-insertion point.\n"
			"\n"
			"Not available now because no text is in the Clipboard.",

		/* [20] Edit/Clear, normal */
			"Removes the selected text; it does not go into the Clipboard.",

		/* [21] Edit/Clear, Grayed */
			"Removes the selected text; it does not go into the Clipboard.\n"
			"\n"
			"Not available now because no text is selected.",

		/* [22] Font Menu, Normal */
			"Font menu\n"
			"\n"
			"Use this menu to change the font used for text in the SIOW window.",

		/* [23] Size Menu, Normal */
			"Size menu\n"
			"\n"
			"Use this menu to change the font size used for text in the SIOW window.",

		/* [24] Control Menu, Normal */
			"Control menu\n"
			"\n"
			"Use this menu to pause or stop this application, or to "
			"send it an end-of-input indication.",

		/* [25] Control/Input EndOfFile, Normal */
			"Use this to indicate end-of-input, also known as end-of-file, or EOF. "
			"This is equivalent to control-d in some Unix-like environments, or "
			"control-z in some other command-line environments.",

		/* [26] Control/Pause, Normal */
			"Select this to suspend output from this application. Select this "
			"a second time to continue execution of this application.",

		/* [27] Control/Resume, Normal */
			"This has been used to suspend output from this application. "
			"Select this to continue execution of this application.",

		/* [28] Control/Pause, Grayed */
			"Use this to suspend output from this application.\n"
			"\n"
			"Not available now because the application has finished or "
			"is waiting for your input.",

		/* [29] Control/Stop, Normal */
			"Use this to halt this application. You can not continue after "
			"you have stopped execution.",

		/* [30] Control/Stop, Grayed */
			"Use this to halt this application.\n"
			"\n"
			"Not available now because the application has finished normally or "
			"you have stopped it.",
	}
};

resource 'hmnu' (__mFile, purgeable) 
{
	HelpMgrVersion,
	hmDefaultOptions,
	0,
	0,

	HMSTRResItem { 0,0,0,0 },	/* item -1:Default balloon */
	{

		HMStringResItem {		/* item 0:File Menu Title */
			__kBalloonStringsResID,1, 	/* normal */
			0,0,						/* disabled */
			0,0,
			0,0
		},
		HMStringResItem {		/* item 1:File/New */
			0,0,						/* normal */
			__kBalloonStringsResID,2,	/* disabled */
			0,0,						/* checked */
			0,0
		},
		HMStringResItem {		/* item 2:File/Open */
			0,0,						/* normal */
			__kBalloonStringsResID,3,	/* disabled */
			0,0,						/* checked */
			0,0
		},
		HMSkipItem { },			/* item 3:File/----- */
		HMStringResItem {		/* item 4:File/Close */
			__kBalloonStringsResID,4,	/* normal */
			0,0,						/* disabled */
			0,0,						/* checked */
			0,0
		},
		HMStringResItem {		/* item 5:File/Save */
			__kBalloonStringsResID,5,	/* normal */
			__kBalloonStringsResID,6,	/* disabled */
			0,0,						/* checked */
			0,0
		},
		HMStringResItem {		/* item 6:File/Save As */
			__kBalloonStringsResID,7,	/* normal */
			0,0,						/* disabled */
			0,0,						/* checked */
			0,0
		},
		HMSkipItem { },			/* item 7:File/----- */
		HMStringResItem {		/* item 8:File/Page Setup */
			__kBalloonStringsResID,8,	/* normal */
			0,0,						/* disabled */
			0,0,						/* checked */
			0,0
		},
		HMStringResItem {		/* item 9:File/Print */
			__kBalloonStringsResID,9,	/* normal */
			0,0,						/* disabled */
			0,0,						/* checked */
			0,0
		},
		HMSkipItem { },			/* item 7:File/----- */
		HMStringResItem {		/* item 9:File/Quit */
			__kBalloonStringsResID,10,	/* normal */
			0,0,						/* disabled */
			0,0,						/* checked */
			0,0
		}
	}
};

resource 'hmnu' (__mEdit, purgeable) 
{
	HelpMgrVersion,
	hmDefaultOptions,
	0,
	0,

	HMSTRResItem { 0,0,0,0 },	/* item -1:Default balloon */
	{

		HMStringResItem {		/* item 0:Edit Menu Title */
			__kBalloonStringsResID,11, 	/* normal */
			0,0,						/* disabled */
			0,0,
			0,0
		},
		HMStringResItem {		/* item 1:Edit/Undo */
			__kBalloonStringsResID,12,	/* normal */
			__kBalloonStringsResID,13,	/* disabled */
			0,0,						/* checked */
			0,0
		},
		HMSkipItem { },			/* item 2:Edit/----- */
		HMStringResItem {		/* item 3:Edit/Cut */
			__kBalloonStringsResID,14,	/* normal */
			__kBalloonStringsResID,15,	/* disabled */
			0,0,						/* checked */
			0,0
		},
		HMStringResItem {		/* item 4:Edit/Copy */
			__kBalloonStringsResID,16,	/* normal */
			__kBalloonStringsResID,17,	/* disabled */
			0,0,						/* checked */
			0,0
		},
		HMStringResItem {		/* item 5:Edit/Paste */
			__kBalloonStringsResID,18,	/* normal */
			__kBalloonStringsResID,19,	/* disabled */
			0,0,						/* checked */
			0,0
		},
		HMStringResItem {		/* item 6:Edit/Clear */
			__kBalloonStringsResID,20,	/* normal */
			__kBalloonStringsResID,21,	/* disabled */
			0,0,						/* checked */
			0,0
		}
	}
};

resource 'hmnu' (__mControl, purgeable) 
{
	HelpMgrVersion,
	hmDefaultOptions,
	0,
	0,

	HMSTRResItem { 0,0,0,0 },	/* item -1:Default balloon */
	{

		HMStringResItem {		/* item 0:Control Menu Title */
			__kBalloonStringsResID,24, 	/* normal */
			0,0,						/* disabled */
			0,0,
			0,0
		},
		HMStringResItem {		/* item 1:Control/EOF */
			__kBalloonStringsResID,25,	/* normal */
			__kBalloonStringsResID,26,	/* disabled */
			0,0,						/* checked */
			0,0
		},
		HMCompareItem {			/* item 2:Control/Pause or Resume */
			"Pause",
			HMStringResItem {
				__kBalloonStringsResID,26,	/* normal - pause */
				__kBalloonStringsResID,28,	/* disabled */
				0,0,						/* checked */
				0,0
			},
		},
		HMCompareItem {			/* item 2:Control/Pause or Resume */
			"Resume",
			HMStringResItem {
				__kBalloonStringsResID,27,	/* normal - resume */
				0,0,						/* disabled */
				0,0,						/* checked */
				0,0
			},
		},
		HMStringResItem {		/* item 3:Control/Stop */
			__kBalloonStringsResID,29,	/* normal */
			__kBalloonStringsResID,30,	/* disabled */
			0,0,						/* checked */
			0,0
		},
	}
};

resource 'hmnu' (__mFont, purgeable) 
{
	HelpMgrVersion,
	hmDefaultOptions,
	0,
	0,

	HMSTRResItem { 0,0,0,0 },	/* item -1:Default balloon */
	{

		HMStringResItem {		/* item 0:Font Menu Title */
			__kBalloonStringsResID,22, 	/* normal */
			0,0,						/* disabled */
			0,0,
			0,0
		}
	}
};

resource 'hmnu' (__mSize, purgeable) 
{
	HelpMgrVersion,
	hmDefaultOptions,
	0,
	0,

	HMSTRResItem { 0,0,0,0 },	/* item -1:Default balloon */
	{

		HMStringResItem {		/* item 0:Size Menu Title */
			__kBalloonStringsResID,23, 	/* normal */
			0,0,						/* disabled */
			0,0,
			0,0
		}
	}
};

resource 'hfdr' ( -5696, purgeable )
{
	HelpMgrVersion,
	hmDefaultOptions,
	0,					// Default balloon definition function
	0,					// Default variation code
	{
		HMSTRResItem
		{
			__rFinderHelpString	// Resource ID of help string ('STR ') to display
		}
	}
};

// This string resource contains the help text that will be displayed in the Finder if you
// move the mouse over the application icon when help is enabled.

resource 'STR ' (__rFinderHelpString, purgeable)
{
	"This application was created with the SIOW library from Apple Computer, Inc. "
	"You may be able to drop file, folder, or disk icons onto this application to execute it with those "
	"items as input."
};
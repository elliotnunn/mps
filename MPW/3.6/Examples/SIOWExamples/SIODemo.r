/* SIODemo.r by C. Keith Ray, Copyright Apple Computer, 1996 */

#include "Types.r"
#include "SysTypes.r"

#include "SIODemo.h"

resource 'SIZE' (-1) 
{
	reserved,
	acceptSuspendResumeEvents,
	reserved,
	canBackground,
	multiFinderAware,
	backgroundAndForeground,
	getFrontClicks,
	ignoreChildDiedEvents,
	is32BitCompatible,
	notHighLevelEventAware,
	onlyLocalHLEvents,
	notStationeryAware,
	useTextEditServices,
	reserved,
	reserved,
	reserved,
	250000,
	400000
};

resource 'DLOG' (kInputWindowDLOG) 
{
	{332, 12, 442, 497},
	movableDBoxProc,
	visible,
	goAway,
	0x0,
	kInputWindowDLOG,
	"Input Window"
#if DLOG_RezTemplateVersion == 1
	, centerMainScreen
#endif
};

resource 'DITL' (kInputWindowDLOG) 
{
	{	/* array DITLarray: 4 elements */
		/* [1] */
		{78, 407, 98, 477},
		Button {
			enabled,
			"Accept"
		},
		/* [2] */
		{8, 7, 65, 476},
		EditText {
			enabled,
			""
		},
		/* [3] */
		{78, 297, 98, 395},
		Button {
			enabled,
			"EndOfFile"
		},
		/* [4] */
		{78, 227, 98, 285},
		Button {
			enabled,
			"Stop"
		}
	}
};

resource 'WIND' (kStdOutWindow) 
{
	{42, 4, 306, 484},
	noGrowDocProc,
	invisible,
	goAway,
	0x0,
	"stdout"
#if WIND_RezTemplateVersion == 1
	, noAutoCenter
#endif
};

resource 'WIND' (kStdErrWindow) 
{
	{178, 2, 240, 506},
	noGrowDocProc,
	invisible,
	goAway,
	0x0,
	"stderr"
#if WIND_RezTemplateVersion == 1
	, noAutoCenter
#endif
};

resource 'ALRT' (kAboutAlert) 
{
	{36, 18, 158, 318},
	kAboutAlert,
	{	/* array: 4 elements */
		/* [1] */
		OK, visible, sound1,
		/* [2] */
		OK, visible, sound1,
		/* [3] */
		OK, visible, sound1,
		/* [4] */
		OK, visible, sound1
	}
#if ALRT_RezTemplateVersion == 1
	/*	The following are window positioning options ,usable in 7.0	*/
	, centerParentWindowScreen;
#endif
};

resource 'MENU' (kAppleMenu) {
	kAppleMenu,
	textMenuProc,
	allEnabled,
	enabled,
	apple,
	{	/* array: 1 elements */
		/* [1] */
		"About SIODemo...", noIcon, noKey, noMark, plain
	}
};

resource 'MENU' (kFileMenu) {
	kFileMenu,
	textMenuProc,
	allEnabled,
	enabled,
	"File",
	{	/* array: 1 elements */
		/* [1] */
		"Quit", noIcon, "Q", noMark, plain
	}
};

resource 'MENU' (kEditMenu) 
{
	kEditMenu,
	textMenuProc,
	0x7FFFFFFD,
	enabled,
	"Edit",
	{	/* array: 5 elements */
		/* [1] */
		"Undo", noIcon, "Z", noMark, plain,
		/* [2] */
		"-", noIcon, noKey, noMark, plain,
		/* [3] */
		"Cut", noIcon, "X", noMark, plain,
		/* [4] */
		"Copy", noIcon, "C", noMark, plain,
		/* [5] */
		"Paste", noIcon, "V", noMark, plain
	}
};

resource 'MBAR' (kDemoMBAR) 
{
	{	/* array MenuArray: 3 elements */
		/* [1] */
		kAppleMenu,
		/* [2] */
		kFileMenu,
		/* [3] */
		kEditMenu
	}
};

resource 'DITL' (kAboutAlert) 
{
	{	/* array DITLarray: 4 elements */
		/* [1] */
		{85, 58, 105, 133},
		Button {
			enabled,
			"I'm OK"
		},
		/* [2] */
		{85, 172, 105, 254},
		Button {
			enabled,
			"You're OK"
		},
		/* [3] */
		{17, 66, 38, 237},
		StaticText {
			disabled,
			"SIOdemo by C. Keith Ray"
		},
		/* [4] */
		{41, 16, 60, 287},
		StaticText {
			disabled,
			"Copyright © 1996 Apple Computer, Inc."
		}
	}
};

resource 'DITL' (kQuitAlert) 
{
	{	/* array DITLarray: 3 elements */
		/* [1] */
		{68, 215, 88, 273},
		Button {
			enabled,
			"Cancel"
		},
		/* [2] */
		{68, 144, 88, 202},
		Button {
			enabled,
			"Quit"
		},
		/* [3] */
		{8, 85, 62, 271},
		StaticText {
			disabled,
			"Do you really want to stop execution and"
			" quit?"
		}
	}
};

resource 'ALRT' (kQuitAlert) 
{
	{40, 40, 138, 326},
	kQuitAlert,
	{	/* array: 4 elements */
		/* [1] */
		OK, visible, sound1,
		/* [2] */
		OK, visible, sound1,
		/* [3] */
		OK, visible, sound1,
		/* [4] */
		OK, visible, sound1
	}
#if ALRT_RezTemplateVersion == 1
	/*	The following are window positioning options ,usable in 7.0	*/
	, centerParentWindowScreen;
#endif
};


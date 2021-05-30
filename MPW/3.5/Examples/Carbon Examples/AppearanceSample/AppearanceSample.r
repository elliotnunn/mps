/*
	File:		AppearanceSample.r

	Contains:	Resources for our sample app using new Appearance types.

	Version:    CarbonLib 1.0.2 SDK

	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "Apple Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.

	© 1997-2000 by Apple Computer, Inc. All rights reserved.
*/

#include "Menus.r"
#include "Dialogs.r"
#include "Controls.r"
#include "ControlDefinitions.r"

#define teFlushRight -1 					/*flush right for all scripts */


resource 'CNTL' (247, "Mega Dialog - Password field") {
	{0, 0, 16, 112},
	0,
	visible,
	0,
	0,
	274,   // kControlEditTextPasswordProc
	0,
	"Secret"
};

resource 'ldes' (128, purgeable)
{
	versionZero
	{
		30,		// rows
		30,		// columns
		16, 	// width
		50, 	// height
		hasVertScroll,
		hasHorizScroll, 
		0,
		hasGrowSpace
	};
};

		


resource 'xmnu' (128, purgeable)
{
	versionZero
	{
		{
			dataItem { 'abou', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph }
		}
	};
};

resource 'xmnu' (129, purgeable)
{
	versionZero
	{
		{
			dataItem { 'clos', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			skipItem {},
			dataItem { 'quit', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph }
		}
	};
};

resource 'xmnu' (130, purgeable)
{
	versionZero
	{
		{
			dataItem { 'opfw', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'opdw', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'opbd', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'newf', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'stal', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'bvli', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'cdef', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'live', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'mega', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'util', kMenuShiftModifier, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'side', kMenuShiftModifier, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'asiz', kMenuShiftModifier, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'vert', kMenuShiftModifier, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'horz', kMenuShiftModifier, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'prox', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph }
		}
	};
};

resource 'xmnu' (148, purgeable)
{
	versionZero
	{
		{
			dataItem { 'mdra', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'dhie', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'hmen', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'dtim', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, 149, sysFont, naturalGlyph }
		}
	};
};

resource 'xmnu' (145, purgeable)
{
	versionZero
	{
		{
			skipItem {},
			skipItem {},
			skipItem {},
			skipItem {},
			skipItem {},
			skipItem {},
			dataItem { '    ', kMenuNoModifiers, sysScript, 0, 0, noHierID, sysFont, 2 },
			dataItem { '    ', kMenuNoModifiers, sysScript, 0, 0, noHierID, sysFont, 3 },
			dataItem { '    ', kMenuNoModifiers, sysScript, 0, 0, noHierID, sysFont, 4 },
			dataItem { '    ', kMenuNoModifiers, sysScript, 0, 0, noHierID, sysFont, 5 },
			dataItem { '    ', kMenuNoModifiers, sysScript, 0, 0, noHierID, sysFont, 6 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 7 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 8 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 9 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x0a },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x0b },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x0c },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x0d },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x0f },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x10 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x11 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x12 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x13 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x14 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x17 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x18 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x19 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x1a },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x1b },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x1c },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x61 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x62 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x63 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x64 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x65 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x66 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x67 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x68 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x69 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x6a },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x6b },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x6c },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x6d },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x6e },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x6f },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x70 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x71 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x72 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x73 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x74 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x75 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x76 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x77 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x78 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x79 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x7a },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x87 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x88 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x89 },
			dataItem { '    ', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, 0x8a }
		}
	};
};


resource 'xmnu' (149, purgeable)
{
	versionZero
	{
		{
			dataItem { 'arrc', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'carc', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'aarc', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'cmac', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'ibec', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'croc', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'pluc', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'watc', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'clhc', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'ophc', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'cuhc', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'cdhc', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'cbhc', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'spnc', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'rslc', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'rsrc', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph },
			dataItem { 'rsbc', kMenuNoModifiers, currScript, 0, 0, noHierID, sysFont, naturalGlyph }
		}
	};
};


//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	About Box resources (extended info)
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã

resource 'dlgx' (5000, purgeable)
{
	versionZero
	{
		kDialogFlagsUseThemeBackground + kDialogFlagsUseThemeControls + kDialogFlagsUseControlHierarchy
	}
};

resource 'dftb' (5000, purgeable)
{
	versionZero
	{
		{
			skipItem {},
			dataItem { kDialogFontUseFontMask, kControlFontSmallSystemFont, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "" },
			dataItem { kDialogFontUseJustMask, 0, 0, 0, 0, teFlushRight, 0, 0, 0, 0, 0, 0, "" }
		}
	};
};

resource 'dftb' (6003, purgeable)
{
	versionZero
	{
		{
			skipItem {},
			skipItem {},
			skipItem {},
			skipItem {},
			dataItem { kDialogFontUseFontMask, kControlFontBigSystemFont, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "" }
		}
	};
};

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Live feedback dialog stuff
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã

resource 'dlgx' (1004, purgeable)
{
	versionZero
	{
		kDialogFlagsUseThemeBackground + kDialogFlagsUseControlHierarchy
	}
};

resource 'dlgx' (2019, purgeable)
{
	versionZero
	{
		kDialogFlagsUseThemeBackground + kDialogFlagsUseControlHierarchy
	}
};

resource 'dftb' (1004, purgeable)
{
	versionZero
	{
		{
			skipItem {},
			skipItem {},
			dataItem { kDialogFontUseFontMask, kControlFontSmallSystemFont, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "" }
		}
	};
};

data 'carb' (0) {
	$"00"                                                 /* . */
};

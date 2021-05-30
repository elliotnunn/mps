/*
	File:		MegaDialog.r

	Contains:	Resources for our MegaDialog.

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


#include "Dialogs.r"
#include "Controls.r"

#define	teCenter 1 						/*center justify (word alignment) */

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	MegaDialog stuff
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã

resource 'dftb' (6000, purgeable)
{
	versionZero
	{
		{
			dataItem { kDialogFontUseFontMask, kControlFontSmallBoldSystemFont, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "" }
		}
	};
};

resource 'dftb' (6002, purgeable)
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
			skipItem {},
			dataItem { kDialogFontUseFontMask + kDialogFontUseJustMask, kControlFontSmallBoldSystemFont, 0, 0, 0, teCenter, 0, 0, 0, 0, 0, 0, "" }
		}
	}
};

resource 'dftb' (6005, purgeable)
{
	versionZero
	{
		{
			skipItem {},
			skipItem {},
			skipItem {},
			dataItem { kDialogFontUseFontMask, kControlFontSmallBoldSystemFont, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "" }
		}
	}
};

resource 'dftb' (6006, purgeable)
{
	versionZero
	{
		{
			skipItem {},
			skipItem {},
			dataItem { kDialogFontUseFontMask, kControlFontSmallSystemFont, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "" },
			dataItem { kDialogFontUseFontMask, kControlFontSmallSystemFont, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "" }
		}
	}
};

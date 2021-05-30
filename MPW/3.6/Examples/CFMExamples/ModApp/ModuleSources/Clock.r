/*
	File:		Clock.r

	Contains:	Clock tool resources.

	Written by:	Richard Clark

	Copyright:	© 1993-1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

			8/15/94		BLS		updated to CFM-68K runtime

*/


#include "Types.r"

resource 'MENU' (2001, "Clock") {
	2001,
	textMenuProc,
	0x7FFFFFFF,
	enabled,
	"Clock",
	{
		"Show second hand", noIcon, noKey, noMark, plain
	}
};



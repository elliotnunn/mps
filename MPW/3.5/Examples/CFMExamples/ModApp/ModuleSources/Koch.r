/*
	File:		Koch.r

	Contains:	Tool menu resources.

	Written by:	Richard Clark

	Copyright:	© 1993-1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

			8/15/94		BLS		updated to CFM-68K runtime

*/


#include "Types.r"

resource 'MENU' (2001, "Koch", preload) {
	2001,
	textMenuProc,
	0x7FFFFFFF,
	enabled,
	"Koch",
	{	
		"1 snowflake", noIcon, "1", noMark, plain,
		"2 snowflakes", noIcon, "2", noMark, plain,
		"3 snowflakes", noIcon, "3", check, plain,
		"4 snowflakes", noIcon, "4", check, plain,
		"-", noIcon, noKey, noMark, plain,
		"Low detail", noIcon, "L", noMark, plain,
		"Medium detail", noIcon, "M", noMark, plain,
		"High detail", noIcon, "H", check, plain,
		"-", noIcon, noKey, noMark, plain,
		"Rotate colors", noIcon, "R", check, plain
	}
};


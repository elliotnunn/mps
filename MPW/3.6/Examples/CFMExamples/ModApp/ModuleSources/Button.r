/*
	File:		Button.r

	Contains:	Button resources
	
	Written by:	Richard Clark

	Copyright:	© 1993-1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

			8/15/94		BLS		updated to CFM-68K runtime

*/


#include "Types.r"

resource 'CNTL' (1001, "Click Me") {
	{30, 26, 55, 139},
	0,
	visible,
	0,
	0,
	pushButProc,
	0,
	"Click Me"
};


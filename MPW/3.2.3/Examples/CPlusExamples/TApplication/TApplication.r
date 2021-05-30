/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple Application Framework
#
#	CPlusAppLib
#
#	TApplication.r	-	Rez source
#
#	Copyright © 1989 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	
#			1.10 					07/89
#			1.00 					04/89
#
#	Components:
#			TApplicationCommon.h	July 9, 1989
#			TApplication.h			July 9, 1989
#			TDocument.h				July 9, 1989
#			TApplication.cp			July 9, 1989
#			TDocument.cp			July 9, 1989
#			TApplication.r			July 9, 1989
#
#	CPlusAppLib is a rudimentary application framework
#	for C++. The applications CPlusShapesApp and CPlusTESample
#	are built using CPlusAppLib.
#
------------------------------------------------------------------------------*/

#include "SysTypes.r"
#include "Types.r"

#include "TApplicationCommon.h"

/* this ALRT and DITL are used as an error screen */
resource 'ALRT' (rUserAlert, purgeable) {
	{40, 20, 150, 260},
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
		{80, 150, 100, 230},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{10, 60, 60, 230},
		StaticText {
			disabled,
			"Error. ^0."
		},
		/* [3] */
		{8, 8, 40, 40},
		Icon {
			disabled,
			2
		}
	}
};


resource 'STR#' (kErrStrings, purgeable) {
	{
	"You must run on 512Ke or later";
	"Application Memory Size is too small"
	}
};


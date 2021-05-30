/*
	File:		cfrg.r

	Contains:	Resource which identifies an application as "native" PowerPC code.

	Written by:	Richard Clark

	Copyright:	© 1993 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				 1/12/94	RC		Incorporated named constants for stack size & default folder
				  7/2/93	RC		d1 release
				  9/21/93	RC		Changed to 'cfrg' for A5

	To Do:
*/

#include "CodeFragmentTypes.r"


resource 'cfrg' (0) {
   {
      kPowerPC,
      kFullLib,
	  kNoVersionNum,kNoVersionNum,
	  kDefaultStackSize, kNoAppSubFolder,
	  kIsApp,kOnDiskFlat,kZeroOffset,kWholeFork,
	  "ModApp"
   }
};

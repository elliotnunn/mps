/*
	File:		GWorldTools.r

	Contains:	'cfrg' resource which marks GWorldTools as a shared library

	Written by:	Richard Clark, Alan Lillich

	Copyright:	© 1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				 1/12/94	RC		Created

	To Do:
*/

#include "CodeFragmentTypes.r"

resource 'cfrg' (0) {
   {
      kPowerPC,
      kFullLib,
	  kNoVersionNum,kNoVersionNum,
	  kDefaultStackSize, kNoAppSubFolder,
	  kIsLib,kOnDiskFlat,kZeroOffset,kWholeFork,
	  "GWorldTools"
   }
};


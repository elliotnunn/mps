/*
	File:		ModuleCFRG.r

	Contains:	template for a plug-in cfrg

	Written by:	Brian Strull

	Copyright:	© 1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				  8/15/94	BLS		First release

	To Do:
*/

#include "CodeFragmentTypes.r"


// The following builds up a cfrg resource for a plug-in.
// It assumes that ARCH and TOOLNAME were defined on the
// command line.

resource 'cfrg' (0) 
{
	{
		ARCH,
		kFullLib,
		kNoVersionNum, kNoVersionNum,
		kDefaultStackSize, kNoAppSubFolder,
	 	kIsDropIn,kOnDiskFlat,kZeroOffset,kWholeFork,
	    TOOLNAME
	}	
};

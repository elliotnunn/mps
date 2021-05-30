/*
 *	File:		PPCApp.r
 *
 *	Contains:	Resource declaration for cfrg resource required for Power Macintosh
 *              applications.
 *
 *				Copyright © 1994 by Apple Computer, Inc.  All rights reserved. 
 *
 */

#include "CodeFragmentTypes.r"

resource 'cfrg' (0) {
   {
      kPowerPC,				/* Target machine's Architecture. */
      kFullLib,				/* This is not an update. */
	  kNoVersionNum,		/* Current version. */
	  kNoVersionNum,		/* Definition version. */
	  kDefaultStackSize,	/* Stack size of application. */
	  kNoAppSubFolder,		/* Not used here.  Can be the resource-id of an 'alis'
	                           resource.  Used to provide additional location
							   to search for libraries. */
	  kIsApp,				/* This is an application (not a lib or drop-in). */
	  kOnDiskFlat,          /* This code fragment is on disk, in the data fork. */
	  kZeroOffset,		    /* Offset of code into data fork. */
	  kWholeFork,           /* Code takes up all of data fork (can give a size). */
	  "CPlusTESample"       /* Name of application. */
   }
};
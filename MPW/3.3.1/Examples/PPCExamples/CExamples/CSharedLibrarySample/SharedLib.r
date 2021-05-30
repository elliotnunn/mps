/*
 *   SharedLib.r
 *
 *	 resource file for sample C++ shared library
 *
 *	 Copyright © 1993, 1994, Apple Computer, Inc.  All rights reserved.
 */

#include "Types.r"
#include "SysTypes.r"
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
	  kIsLib,				/* This is library. */
	  kOnDiskFlat,          /* This code fragment is on disk, in the data fork. */
	  kZeroOffset,		    /* Offset of code into data fork. */
	  kWholeFork,           /* Code takes up all of data fork (can give a size). */
	  "SharedLib"           /* Name of library. */
   }
};

resource 'vers' (1) {
	0x1,
	0x0,
	beta,
	0xd,
	verUS,
	"1.0b1",
	"Version 1.0b1.  Copyright © 1994, Apple Computer, Inc."
};
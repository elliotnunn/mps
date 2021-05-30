/* 
	AsmSample.r
	-	contains resources for AsmSample application.
	
	v1		10/9/93		PMR
	v2		 1/7/94 	fpf
	
*/ 

#include "Types.r"
#include "SysTypes.r"
#include "CodeFragmentTypes.r"

resource 'ALRT' (128) {
	{43, 39, 141, 287},
	128,
	{	
		OK, visible, sound1,
		OK, visible, sound1,
		OK, visible, sound1,
		OK, visible, sound1
	}
};

resource 'DITL' (128) {
	{	{53, 144, 73, 210},
		Button {
			enabled,
			"Hello"
		},
		{53, 36, 73, 102},
		Button {
			enabled,
			"Goodbye"
		},
		{20, 50, 38, 189},
		StaticText {
			disabled,
			"Choose A Message…"
		}
	}
};

resource 'ALRT' (129) {
	{40, 40, 139, 288},
	129,
	{	OK, visible, sound1,
		OK, visible, sound1,
		OK, visible, sound1,
		OK, visible, sound1
	}
};

resource 'DITL' (129) {
	{	{59, 92, 79, 150},
		Button {
			enabled,
			"OK"
		},
		{12, 14, 42, 238},
		StaticText {
			disabled,
			"^0"
		}
	}
};


resource 'SIZE' (-1) {
	reserved,
	ignoreSuspendResumeEvents,
	reserved,
	cannotBackground,
	notMultiFinderAware,
	backgroundAndForeground,
	dontGetFrontClicks,
	ignoreChildDiedEvents,
	is32BitCompatible,
	notHighLevelEventAware,
	onlyLocalHLEvents,
	notStationeryAware,
	dontUseTextEditServices,
	reserved,
	reserved,
	reserved,
	393216,
	393216
};


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
	  "AsmSample"           /* Name of application. */
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
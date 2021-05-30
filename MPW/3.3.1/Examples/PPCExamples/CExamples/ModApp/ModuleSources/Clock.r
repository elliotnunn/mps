// File: ClockTool.r

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


#ifdef AddCFRG

	#include "CodeFragmentTypes.r"

	// We're using the 'cfrg' to indicate that this module contains
	// native code. However, ModApp is the only thing that actually
	// looks for this resource in the module -- the system only looks
	// if the file is an application or a shared library
	resource 'cfrg' (0) {
   {
      kPowerPC,
      kFullLib,
	  kNoVersionNum,kNoVersionNum,
	  kDefaultStackSize, kNoAppSubFolder,
	  kIsDropIn,kOnDiskFlat,kZeroOffset,kWholeFork,
	  "Clock"
   }
};

#endif

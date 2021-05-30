// File: KochTool.r

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
	  "Koch"
   }
};

#endif

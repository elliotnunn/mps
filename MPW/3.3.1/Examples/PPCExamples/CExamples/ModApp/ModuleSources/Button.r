// File: Button.r

#include "Types.r"

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
	  "Button"
   }
};

#endif

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


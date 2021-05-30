// File: PowerResource.r

#include "Types.r"
#include "CodeFragmentTypes.r"

resource 'STR#' (128, "Message", purgeable) {
	{
		"This is running from a PowerPC resource",
		"This is running from a 68K resource"
	}
};

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
  kIsDropIn, kInMem,
  /* We use "kInMemory" to mean a resource. This usage is strictly a ModApp convention. */
  kZeroOffset,kWholeFork,
  "PowerResource"
  }
};

// Get the PEF container and load it into a resource
read 'TOOL' (1, "Tool in a PowerPC resource") "::PowerPC:PowerResource.ppc";

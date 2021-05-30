/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
------------------------------------------------------------------------------*/

/*
 *	This is a klugy way of ensuring our 'cfrg' resource for PowerPC is correct.
 *	If this is a 68K only build, then we must remove the 'cfrg' resource.
 *	So a 68K link ALWAYS removes it.  If we are doing a PowerPC build,
 *	then this file gets called a second time to put it back in.
 */
#ifdef powerc
/* here is the quintessential PowerPC friendliness device, the cfrg resource */

#include "CodeFragmentTypes.r"

resource 'cfrg' (0) {
   {
      kPowerPC,
      kFullLib,
	  kNoVersionNum,kNoVersionNum,
	  0,0,
	  kIsApp,kOnDiskFlat,kZeroOffset,kWholeFork,
	  "Kibitz"
   }
};

#else
delete 'cfrg';
#endif

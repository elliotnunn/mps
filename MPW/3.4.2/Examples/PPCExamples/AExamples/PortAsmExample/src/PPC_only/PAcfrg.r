/*------------------------------------------------------------------------------
;
;	PortAsm Simple Example	By Steven Ellis
;
;	Copyright MicroAPL Ltd 1993/4
;
;	PAcfrg.r - cfrg resource required for PPC based Mac
;
------------------------------------------------------------------------------*/

#include "CodeFragmentTypes.r"

resource 'cfrg' (0) {
   {
	kPowerPC,
	kFullLib,
	kNoVersionNum,kNoVersionNum,
	0, 0,
	kIsApp,kOnDiskFlat,kZeroOffset,kWholeFork,
	"PAExamplePPC"
   }
};
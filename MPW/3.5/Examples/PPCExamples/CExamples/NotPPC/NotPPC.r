#include "Types.r"
#include "NotPPC.h"		/* local defintions only */


resource 'ALRT' (RESOURCE_ID, purgeable) {
	{90, 110, 240, 450},
	RESOURCE_ID,
	{	/* array: 4 elements */
		/* [1] */
		OK, visible, silent,
		/* [2] */
		OK, visible, silent,
		/* [3] */
		OK, visible, silent,
		/* [4] */
		OK, visible, silent
	}
	/****** Extra bytes follow... ******/
#if SystemSevenOrLater
	,alertPositionMainScreen
#endif
};

resource 'DITL' (RESOURCE_ID) {
	{	/* array DITLarray: 3 elements */
		/* [1] */
		{120, 255, 140, 315},
		Button {
			enabled,
			"OK"
		},
		/* [2] */
		{10, 70, 110, 340},
		StaticText {
			disabled,
			"^0"
		},
		/* [3] */
		{10, 20, 40, 50},
		Icon {
			disabled,
			0
		}
	}
};

resource 'STR#' (RESOURCE_ID) {
  {
    "This application program is designed for Power Macintosh computers."
       " It is not compatible with this Macintosh.";
	
	"This application program is running under emulation on a Power "
	   "Macintosh computer.  Power Macintosh code requires a 'cfrg' "
	   "resource in order to execute."
  }
};


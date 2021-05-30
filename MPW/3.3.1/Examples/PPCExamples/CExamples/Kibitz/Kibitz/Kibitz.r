/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
------------------------------------------------------------------------------*/

#include "Types.r"
#include "SysTypes.r"
#include "BalloonTypes.r"
#include "UtilitiesCommon.h"

include "Kibitz.π.rsrc";

resource 'SIZE' (-1) {
	dontSaveScreen,
	acceptSuspendResumeEvents,
	enableOptionSwitch,
	canBackground,				/* Can properly use background null events	*/
	doesActivateOnFGSwitch,		/* We do our own activate/deactivate; don't fake us out */
	backgroundAndForeground,	/* This is definitely not a background-only application! */
	dontGetFrontClicks,			/* Change this is if you want "do first click" behavior like the Finder */
	ignoreAppDiedEvents,		/* Essentially, I'm not a debugger (sub-launching) */
	is32BitCompatible,			/* This app can be run in 32-bit address space */
	isHighLevelEventAware,		/* does Post/AcceptHighLevelEvent */
	localAndRemoteHLEvents,
	notStationeryAware,
	dontUseTextEditServices,
	reserved,
	reserved,
	reserved,
	400 * 1024,
	400 * 1024
};


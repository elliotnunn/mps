/*
	file HTMLSample.r
	
	Description:
	This file contains the MPW Rez declarations used in the HTMLSample
	application.
	
	HTMLSample is an application illustrating how to use the new
	HTMLRenderingLib services found in Mac OS 9. HTMLRenderingLib
	is Apple's light-weight HTML rendering engine capable of
	displaying HTML files.

	by John Montbriand, 1999.

	Copyright: © 1999 by Apple Computer, Inc.
	all rights reserved.
	
	Disclaimer:
	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "DSC Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.
	
	Change History (most recent first):
	10/16/99 created by John Montbriand
*/

#include "Processes.r"
#include "CodeFragments.r"

include "HTMLSample.rsrc";

resource 'SIZE' (-1, purgeable)  {
	reserved,
	acceptSuspendResumeEvents,
	reserved,
	canBackground,
	doesActivateOnFGSwitch,
	backgroundAndForeground,
	dontGetFrontClicks,
	ignoreAppDiedEvents,
	is32BitCompatible,
	isHighLevelEventAware,
	localAndRemoteHLEvents,
	isStationeryAware,
	dontUseTextEditServices,
	reserved,
	reserved,
	reserved,
	1024 * 4000,
	1024 * 4000
};

resource 'cfrg' (0) {
	{	kPowerPC,
		kFullLib,
		kNoVersionNum,
		kNoVersionNum,
		kDefaultStackSize,
		kNoAppSubFolder,
		kIsApp,
		kOnDiskFlat,
		kZeroOffset,
		kWholeFork,
		"HTMLSample"
	}
};
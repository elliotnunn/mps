/*
** Apple Macintosh Developer Technical Support
**
** Program:	    DTS.Lib
** File:	    PPC.c
** Written by:  Eric Soldan
**
** Copyright © 1992 Apple Computer, Inc.
** All rights reserved.
**
** This is the only PPC code we have so far for this file.  Who knows if we'll do more...
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */



/*****************************************************************************/



#include "PPC.h"
#include "Utilities.h"



/*****************************************************************************/



OSErr	DoIPCListPorts(short *sindx, short *reqCount, short *actCount,
					   LocationNamePtr  loc,
					   PortInfoArrayPtr retInfo,
					   PPCFilterProcPtr filter)
{
	OSErr				err;
	IPCListPortsPBRec	lpPBRec;
	PPCPortRec			portRec;
	PortInfoRec			info;
	Boolean				keeper;
	char				*cptr;
	short				i;

	*actCount = 0;

	cptr = (char *)&lpPBRec;
	for (i = 0; i < sizeof(IPCListPortsPBRec); ++i) cptr[i] = 0;

	portRec.nameScript = 0;
	pcpy(portRec.name, "\p=");					/* Match all names. */

	portRec.portKindSelector = ppcByString;
	pcpy(portRec.u.portTypeStr, "\p=");			/* Match all names. */

	lpPBRec.requestCount = 1;
	lpPBRec.portName     = &portRec;
	lpPBRec.locationName = loc;
	lpPBRec.bufferPtr    = &info;

	for (; *actCount < *reqCount;) {

		lpPBRec.startIndex = *sindx;
		if (err = IPCListPortsSync(&lpPBRec)) return(err);	/* Call IPCListPorts synchronously. */

		++*sindx;	/* We read it once.  Make sure we don't read it again. */

		if (!lpPBRec.actualCount) {		/* If this happens, we hit end of list. */
			*reqCount = 0;				/* This is a flag stating that all are read. */
			return(noErr);
		}

		keeper = true;
		if (filter)
			keeper = (*filter)(loc, &info);
		if (keeper) {
			retInfo[*actCount] = info;
			++*actCount;
		}
	}

	return(noErr);
}




/*
** Apple Macintosh Developer Technical Support
**
** File:             start.c
** Originally from:  Traffic Light 2.0 (2.0 version by Keith Rollin)
** Modified by:      Eric Soldan
**
** Copyright © 1989-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif

#ifndef __TEXTEDITCONTROL__
#include <TextEditControl.h>
#endif

#ifndef	__TSMTE__
#include <TSMTE.h>
#endif



/*****************************************************************************/



extern void _DataInit();



/*****************************************************************************/
/*****************************************************************************/



#pragma segment Main
void	main(void)
{
	NamesTableEntry	appNTE;
	EntityName		appEntityName;
	OSErr			atErr;

#ifndef THINK_C
	UnloadSeg((Ptr)_DataInit);		/* Note that _DataInit can't be in Main! */
#endif
	
	SetApplLimit(GetApplLimit() - 16384);
		/* This decreases the application heap by 16k, which in turn
		** increases the stack by 16k. */

	MaxApplZone();		/* Expand the heap so code segments load at the top. */
	Initialize();							/* Initialize the program. */

	DoSetCursor(*GetCursor(watchCursor));	/* Rest of startup may take a while. */

	StartDocuments();				/* Open (or print) designated documents. */

// This can be removed when we have a universal TSMTE.h
#ifndef powerc
	if(CTEUseTSMTE())
		InitTSMAwareApplication();
#endif

	UnloadSeg((Ptr)Initialize);		/* Initialize can't be in Main! */

	atErr = AddPPCNBPAlias(&appNTE, "\pKibitz", &appEntityName);

	EventLoop();				/* Call the main event loop. */

	if (!atErr) RemoveNBPAlias(&appEntityName);

// This can be removed when we have a universal TSMTE.h
#ifndef powerc
	if(CTEUseTSMTE())
		CloseTSMAwareApplication();
#endif

	ExitToShell();					/* Quit the application. */
}




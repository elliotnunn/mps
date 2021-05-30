/*
** Apple Macintosh Developer Technical Support
**
** File:        window.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __GWLAYERS__
#include <GWLayers.h>
#endif

#ifndef __LOWMEM__
#include <LowMem.h>
#endif

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/



extern short	gPrintPage;		/* Non-zero means we are printing. */
extern LayerObj	gBoardLayer;



/*****************************************************************************/
/*****************************************************************************/



/* This function creates a new application window.  An application window
** contains a document which is referenced by a handle in the refCon field. */

#pragma segment Window
OSErr	AppNewWindow(FileRecHndl frHndl, WindowPtr *retWindow, WindowPtr behind)
{
	WindowPtr	oldPort, window;
	OSErr		err;
	Rect		rct;

	/* We will allocate our own window storage instead of letting the Window
	** Manager do it because GetNewWindow may load in temp. resources before
	** making the NewPtr call, and this can lead to heap fragmentation. */

	GetPort(&oldPort);

	err = memFullErr;		/* Assume that we will fail.  Good attitude. */

	SetRect(&rct, 0, 0, 0, 0);
	window = GetStaggeredWindow(rWindow, nil, false, FrontWindow(), behind, true, rct, (long)frHndl);
	if (window) {
		(*frHndl)->fileState.window = window;
		AppNewWindowTitle(window);
		if (!(err = AppNewWindowControls(frHndl, window, behind))) {
			if (gPrintPage) MoveWindow(window, 16384, 16384, true);
				/* So the window can be hidden while printing, yet
				** PrintMonitor can get the document name. */
			if ((*frHndl)->doc.justBoardWindow)
				ZoomToWindowDevice(window, rJustBoardWindowWidth, rWindowHeight, inZoomOut, true);
			ShowWindow(window);
			if (gPrintPage)
				MoveWindow(window, 16384, 16384, true);
					/* Moving invisible windows to the front doesn't always
					** get them to the front.  Now that it is visible, moving
					** it will definitely get it to the front. */
		}
	}

	SetPort(oldPort);
	if (retWindow) *retWindow = window;

	return(err);
}



/*****************************************************************************/



/* This function updates the window title to reflect the new document name.
** The new document name is stored in the fileState portion of the document.
** This is automatically set to 'Untitled # N' for new documents, and is
** updated when a user does a save-as. */

#pragma segment Window
void	AppNewWindowTitle(WindowPtr window)
{
	FileRecHndl	frHndl;
	Str255		wTitle;

	if (frHndl = (FileRecHndl)GetWRefCon(window)) {
		pcpy(wTitle, (*frHndl)->fileState.fss.name);
		SetWTitle(window, wTitle);
	}
}



/*****************************************************************************/



/* This function returns the state of the window's document.  If the document
** is dirty, then true is returned.  If the document is clean, or the window
** has no document, then false is returned. */

#pragma segment Window
Boolean	AppWindowDirty(WindowPtr window)
{
	FileRecHndl	frHndl;

	if (frHndl = (FileRecHndl)GetWRefCon(window))
		return(AppDocumentDirty(frHndl));

	return(false);
}



/*****************************************************************************/



/* Close all the windows.  This is called prior to quitting the application.
** This function returns true if all windows were closed.  The user may decide
** to abort a save, thus stopping the closing of the windows.  If the user
** does this, false will be returned, indicating that all windows were not
** closed after all. */

#pragma segment Window
Boolean	CloseAllWindows(void)
{
	WindowPtr	window;

	while (window = (WindowPtr)LMGetWindowList()) {
		/* While we have a front window, try closing it. */

		if (!CloseOneWindow(window, iQuit)) return(false);
			/* When CloseOneWindow returns false, this means that the window
			** didn't close.  The only cause of this is if the window had a
			** document that needed saving, and the user cancelled the save.
			** If the window succeeded in getting closed, then we are
			** returned true.  Either way, we return the result. */
	}

	return(true);
}



/*****************************************************************************/



/* Closes one window.  This window may be an application window, or it may be
** a system window.  If it is an application window, it may have a document
** that needs saving. */

#pragma segment Window
Boolean	CloseOneWindow(WindowPtr window, short saveMode)
{
	FileRecHndl	frHndl;
	OSErr		err;

	if (IsAppWindow(window)) {
		/* First, if the window is an application window, try saving
		** the document.  Remember that the user may cancel the save. */

		if (frHndl = (FileRecHndl)GetWRefCon(window)) {
			err = AppSaveDocument(frHndl, window, saveMode);
			if (err) {
				if (err != userCanceledErr)
					Alert(rErrorAlert, gAlertFilterUPP);
				return(false);
			}		/* Stop closing windows on error or user cancel. */

			SetOpponentType(frHndl, kOnePlayer);
			AppDisposeDocument(frHndl);
				/* The document is saved, or the user doesn't care about
				** that document, so dispose of the document. */
		}
	}
	DisposeAnyWindow(window);

	return(true);
}



/*****************************************************************************/



#pragma segment Window
WindowPtr	SetFilePort(FileRecHndl frHndl)
{
	WindowPtr	oldPort;

	GetPort(&oldPort);
	SetPort((*frHndl)->fileState.window);
	return(oldPort);
}




/*
** Apple Macintosh Developer Technical Support
**
** File:		System6Help.c
** Written by:	Eric Soldan
**
** Copyright © 1990-1993 Apple Computer, Inc.
** All rights reserved.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */



/*****************************************************************************/



#include "DTS.Lib2.h"
#include "DTS.Lib.protos.h"

#ifndef __BALLOONS__
#include <Balloons.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

extern HMMessageRecord	gHelpMessage;
extern Rect				gHelpMessageRct;
extern ControlHandle	gHelpMessageCtl;
extern WindowPtr		gHelpWithWindow;

static PicHandle		gHelp6Pic;



/*****************************************************************************/



static OSErr	HelpImageDocument(FileRecHndl frHndl);
static OSErr	HelpInitContent(FileRecHndl frHndl, WindowPtr window);
static OSErr	HelpFreeDocument(FileRecHndl frHndl);



/*****************************************************************************/
/*****************************************************************************/



#pragma segment Help
OSErr	HelpInitDocument(FileRecHndl frHndl)
{
	FileRecPtr	frPtr;

	frPtr = *frHndl;
	frPtr->fileState.calcFrameRgnProc        = nil;
	frPtr->fileState.contentClickProc        = nil;
	frPtr->fileState.contentKeyProc          = nil;
	frPtr->fileState.drawFrameProc           = nil;
	frPtr->fileState.freeDocumentProc        = HelpFreeDocument;
	frPtr->fileState.freeWindowProc          = nil;
	frPtr->fileState.imageProc               = HelpImageDocument;
	frPtr->fileState.initContentProc         = HelpInitContent;
	frPtr->fileState.readDocumentProc        = nil;
	frPtr->fileState.readDocumentHeaderProc  = nil;
	frPtr->fileState.resizeContentProc       = nil;
	frPtr->fileState.scrollFrameProc         = nil;
	frPtr->fileState.undoFixupProc           = nil;
	frPtr->fileState.windowCursorProc        = nil;
	frPtr->fileState.writeDocumentProc       = nil;
	frPtr->fileState.writeDocumentHeaderProc = nil;

	return(noErr);
}



/*****************************************************************************/
/*****************************************************************************/



#pragma segment Help
static OSErr	HelpImageDocument(FileRecHndl frHndl)
{
#pragma unused (frHndl)

	DoDrawControls((*frHndl)->fileState.window, false);
	return(noErr);
}



/*****************************************************************************/



#pragma segment TheDoc
static OSErr	HelpInitContent(FileRecHndl frHndl, WindowPtr window)
{
#pragma unused (frHndl)

	WindowPtr		oldPort, ww;
	OSErr			err;
	Rect			scnRct, strRct, cntRct, ctlRct, rct, **rh;
	short			xx, yy, ht, ofst, cc;
	Handle			txt;
	StringHandle	sh;
	StScrpHandle	stl;
	ControlHandle	ctl;
	TEHandle		te;
	Str255			pstr;

	if (err = AddControlSet(window, '6hlp', kwStandardVis, 0, 0, nil)) return(err);

	scnRct = GetWindowDeviceRectNMB(gHelpWithWindow);		/* Rect of screen that window-with-help is most on. */

	if (!(ctl = CTENext(window, &te, nil, 1, false))) return(memFullErr);

	GetPort(&oldPort);
	SetPort(gHelpWithWindow);
	ctlRct = (*gHelpMessageCtl)->contrlRect;
	LocalToGlobalRect(&ctlRct);								/* Rect of control that is getting help. */
	SetPort(oldPort);

	if (gHelp6Pic) KillPicture(gHelp6Pic);
	gHelp6Pic = nil;

	pstr[0] = 0;
	xx = yy = 0;

	switch (gHelpMessage.hmmHelpType) {
		case khmmString:
			pcpy(pstr, (StringPtr)gHelpMessage.u.hmmString);
			break;
		case khmmPict:
			if (!(gHelp6Pic = (PicHandle)Get1Resource('PICT', gHelpMessage.u.hmmTERes))) return(ResError());
			ReleaseResource((Handle)gHelp6Pic);
			xx = (*gHelp6Pic)->picFrame.right  - (*gHelp6Pic)->picFrame.left;
			yy = (*gHelp6Pic)->picFrame.bottom - (*gHelp6Pic)->picFrame.top;
			break;
		case khmmStringRes:
			GetIndString(pstr, gHelpMessage.u.hmmStringRes.hmmResID, gHelpMessage.u.hmmStringRes.hmmIndex);
			break;
		case khmmTERes:
			if (!(txt = Get1Resource('TEXT', gHelpMessage.u.hmmTERes))) return(memFullErr);
			DetachResource(txt);
			if (stl = (StScrpHandle)Get1Resource('styl', gHelpMessage.u.hmmTERes)) DetachResource((Handle)stl);
			UseControlStyle(ctl);
			DisposeHandle(CTESwapText(te, txt, stl, false));
			if (stl) DisposeHandle((Handle)stl);
			if (rh = (Rect **)Get1Resource('RECT', gHelpMessage.u.hmmTERes)) xx = (*rh)->right  - (*rh)->left;
			UseControlStyle(nil);
			break;
		case khmmSTRRes:
			if (sh = (StringHandle)GetResource('STR ', gHelpMessage.u.hmmSTRRes))
			pcpy(pstr, *sh);
			break;
	}

	if (pstr[0]) {
		UseControlStyle(ctl);
		CTEPutPStr(ctl, pstr);
		UseControlStyle(nil);
	}

	SetPort(window);
	if (!yy) {		/* If handling text... */
		if (!xx) {
			for (;;) {
				yy = CTEDocHeight(te);
				xx = (*ctl)->contrlRect.right - (*ctl)->contrlRect.left;

				if (xx > scnRct.right - scnRct.left - 64) {
					xx = scnRct.right - scnRct.left - 64;
					break;
				}

				if (xx > 4 * yy) break;

				CTESize(te, (xx + xx / 2), yy, true);
			}
		}
		yy = CTEDocHeight(te);
		CTESize(te, xx, yy, true);
		yy = CTEDocHeight(te);
	}
	SetPort(oldPort);

	MoveWindow(window, 16384, 16384, false);
	ShowHide(window, true);
	CleanSendBehind(window, (WindowPtr)-1);

	rct = (*ctl)->contrlRect;
	SizeWindow(window, xx + rct.left, yy + 2 * rct.top, false);

	strRct = GetWindowStructureRect(window);		/* Structure rect of window-with-help. */
	cntRct = GetWindowContentRect(window);			/* Content rect of window-with-help. */

	cc = (ctlRct.right + ctlRct.left) / 2;
	xx = cc - xx / 2;
	if (xx < (scnRct.left + 10)) xx = (scnRct.left + 10);
	if (xx > scnRct.right - (cntRct.right - cntRct.left) - 10)
		xx = scnRct.right - (cntRct.right - cntRct.left) - 10;

	yy = ctlRct.top - (strRct.bottom - strRct.top) - 10;
	if (yy < scnRct.top + 2) {
		yy = ctlRct.bottom + 10;
		if (yy > scnRct.bottom - (strRct.bottom - strRct.top) - 2)
			yy = scnRct.bottom - (strRct.bottom - strRct.top) - 2;
	}
	yy += (cntRct.top - strRct.top);

	MoveWindow(window, xx, yy, false);

	return(noErr);
}



/*****************************************************************************/



#pragma segment TheDoc
static OSErr	HelpFreeDocument(FileRecHndl frHndl)
{
	if (gHelp6Pic) KillPicture(gHelp6Pic);
	gHelp6Pic = nil;

	return(DefaultFreeDocument(frHndl));
}




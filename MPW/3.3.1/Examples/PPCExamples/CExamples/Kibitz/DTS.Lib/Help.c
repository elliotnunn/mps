/*
** Apple Macintosh Developer Technical Support
**
** File:		Help.c
** Written by:	Eric Soldan
**
** Copyright © 1993 Apple Computer, Inc.
** All rights reserved.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */

/* This file contains some sample code for handling dynamic balloon help.  The
** assumption here is that you used the AppsToGo program editor to add controls
** to the content of a window that have balloon help assigned to them. */



/*****************************************************************************/



#include "DTS.Lib2.h"
#include "DTS.Lib.protos.h"

#ifndef __BALLOONS__
#include <Balloons.h>
#endif

#ifndef __PROCESSES__
#include <Processes.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __UTILITIES__
#include "Utilities.h"
#endif

typedef struct {
	short	helpVers;
	long	options;
	short	procID;
	short	variantForTip;
	short	numMessages;
	short	itemSize;
	short	itemType[0];
} hrctRec;
typedef hrctRec *hrctRecPtr, **hrctRecHndl;

extern short	gQuickBalloons;

Boolean			gHaveQuickBalloon;
PicHandle		gPicBalloon;

HMMessageRecord	gHelpMessage;
Rect			gHelpMessageRct;
ControlHandle	gHelpMessageCtl;
WindowPtr		gHelpWithWindow;

extern short	gTECtl;

ControlHandle	ControlBalloonMessage(WindowPtr window, Point mouseLoc, HMMessageRecord *msg, Rect *msgRct,
									  short *pos, short *hrctID, short *itemID);



/*****************************************************************************/
/*****************************************************************************/



#pragma segment Main
Boolean	ControlBalloonHelp(WindowPtr window, short modifiers, Point mouseLoc)
{
	WindowPtr				ww;
	ProcessSerialNumber		cpsn, fpsn;
	ControlHandle			ctl;
	short					hrctID, itemID, pos;
	Boolean					procsSame;
	HMMessageRecord			message, msg;
	Rect					messageRct;

	if (gSystemVersion < 0x0700)
		if (!gQuickBalloons)
			return(false);

	if (gSystemVersion >= 0x0700) {
		if (!window) {
			if (gHelpMessage.hmmHelpType) HMRemoveBalloon();
			gHelpMessage.hmmHelpType = 0;
		}
		if (gQuickBalloons) {
			if ((modifiers & gQuickBalloons) == gQuickBalloons) {
				if (!HMGetBalloons())
					HMSetBalloons(gHaveQuickBalloon = true);
			}
			else {
				if (gHaveQuickBalloon) {
					if (HMGetBalloons()) {
						HMRemoveBalloon();
						HMSetBalloons(false);
					}
					gHaveQuickBalloon = false;
					gHelpMessage.hmmHelpType = 0;
				}
			}
		}
		if (!window) return(false);
	}
	else {
		if (!window) {
			gHelpMessage.hmmHelpType = 0;
			return(false);
		}
		gHaveQuickBalloon = ((modifiers & gQuickBalloons) == gQuickBalloons) ? true : false;
		if (!gHaveQuickBalloon) {
			gHelpMessage.hmmHelpType = 0;
			return(false);
		}
	}

	if (gSystemVersion >= 0x0700) {
		if (!HMGetBalloons()) {
			gHelpMessage.hmmHelpType = 0;
			return(false);
		}		/* Balloons have been turned off. */

		HMGetBalloonWindow(&ww);
		if (!ww)
			gHelpMessage.hmmHelpType = 0;
				/* There is no balloon currently, so there is no last message. */
	}
	else {
		if (!GetNextWindow(nil, '6hlp'))
			gHelpMessage.hmmHelpType = 0;
	}

	if (gSystemVersion >= 0x0700) {
		GetCurrentProcess(&cpsn);
		GetFrontProcess(&fpsn);
		SameProcess(&cpsn, &fpsn, &procsSame);
		if (!procsSame) {
			gHelpMessage.hmmHelpType = 0;
			return(false);
		}		/* We aren't the front process, so leave. */
	}
	else {
		if (gInBackground) {
			gHelpMessage.hmmHelpType = 0;
			return(false);
		}
	}

	if (!GetWRefCon(window)) {
		gHelpMessage.hmmHelpType = 0;
		return(false);
	}

	ctl = ControlBalloonMessage(window, mouseLoc, &message, &messageRct, &pos, &hrctID, &itemID);

	if (message.hmmHelpType) {
		if (!EqualRect(&gHelpMessageRct, &messageRct))
			gHelpMessage.hmmHelpType = -1;
		if (!EqualData(&gHelpMessage, &message, sizeof(message))) {		/* If new balloon... */
			gHelpMessage    = message;
			gHelpMessageRct = messageRct;
			gHelpMessageCtl = ctl;
			gHelpWithWindow = window;
			if (gSystemVersion >= 0x0700) {
				msg = message;
				if (message.hmmHelpType == khmmTERes) {
					if (gPicBalloon) KillPicture(gPicBalloon);
					if (gPicBalloon = BalloonText2PICT(window, &message)) {
						msg.hmmHelpType = khmmPictHandle;
						msg.u.hmmPictHandle = gPicBalloon;
					}
				}
				HMShowBalloon(&msg, mouseLoc, &messageRct, nil, 0, pos, kHMRegularWindow);
			}
			else {
				if (gHaveQuickBalloon) {
					if (ww = GetNextWindow(nil, '6hlp')) {
						gHelpMessage.hmmHelpType = 0;
						return(false);
					}
					if (NewDocumentWindow(nil, '6hlp', false)) {
						gHelpMessage.hmmHelpType = 0;
						return(false);
					}
				}
			}
		}
		return(true);
	}
	else {
		if (gSystemVersion >= 0x0700) {
			if (gHelpMessage.hmmHelpType)
				HMRemoveBalloon();
		}
		gHelpMessage.hmmHelpType = 0;
		if (gPicBalloon) {
			KillPicture(gPicBalloon);
			gPicBalloon = nil;
		}
	}

	return(false);
}



/*****************************************************************************/



#pragma segment Main
ControlHandle	ControlBalloonMessage(WindowPtr window, Point mouseLoc, HMMessageRecord *msg, Rect *msgRct,
									  short *pos, short *hrctID, short *itemID)
{
	Point				pt;
	WindowPtr			oldPort;
	ControlStyleInfo	cinfo;
	Rect				rct;
	short				charsUsed, i, j, cv, strNumID, strNumIndx;
	long				ofst;
	ControlHandle		ctl;
	char				*cptr;
	hrctRecHndl			hrct;
	Ptr					ptr;
	static short		position[4] = {5, 6, 2, 1};

	msg->hmmHelpType  = 0;
	*hrctID = *itemID = 0;

	GetPort(&oldPort);
	SetPort(window);
	pt = mouseLoc;
	GlobalToLocal(&pt);
	SetPort(oldPort);

	if (!WhichControl(pt, 0, window, &ctl)) return(nil);
	if (!GetControlStyle(ctl, &cinfo))      return(nil);

	*msgRct = (*ctl)->contrlRect;
	rct = (*(window->visRgn))->rgnBBox;
	SectRect(&rct, msgRct, msgRct);
	if (!PtInRect(pt, msgRct)) return(nil);

	cptr = (char *)cinfo.balloonHelp;
	p2c((StringPtr)cptr);
	if (!(*hrctID = c2dec(cptr, &charsUsed))) return(nil);
	cptr += (charsUsed + 1);

	*itemID = c2dec(cptr, &charsUsed);
	cptr += charsUsed;

	if (!(hrct = (hrctRecHndl)GetResource('hrct', *hrctID))) return(nil);

	if (*cptr == ',') {									/* If entry for inactive control... */
		i = c2dec(++cptr, &charsUsed);
		cptr += charsUsed;
		if ((*ctl)->contrlHilite == 255) *itemID = i;	/* If control inactive... */
	}

	while (*cptr == ':') {
		cv = c2dec(++cptr, &charsUsed);
		cptr += charsUsed;
		i = j = c2dec(++cptr, &charsUsed);
		cptr += charsUsed;
		if (*cptr == ',') {									/* If entry for inactive control... */
			j = c2dec(++cptr, &charsUsed);
			cptr += charsUsed;
		}
		if (cv == (*ctl)->contrlValue) {
			if (!(*ctl)->contrlHilite)       *itemID = i;	/* If control active... */
			if ((*ctl)->contrlHilite == 255) *itemID = j;	/* If control inactive... */
			break;
		}
	}

	if (!(hrct = (hrctRecHndl)GetResource('hrct', *hrctID))) return(nil);
	if (*itemID > (*hrct)->numMessages)                      return(nil);
	if (!*itemID)                                            return(nil);

	ofst = offsetof(hrctRec,itemSize);
	for (i = 1; i < *itemID; ++i) {
		ptr = (Ptr)*hrct;
		ofst += *(short *)(ptr + ofst);
	}
	ofst += sizeof(short);							/* Point to item type. */

	SetMem(msg, 0, sizeof(HMMessageRecord));		/* Clean out structure for compare purposes. */
	ptr = (Ptr)*hrct;
	msg->hmmHelpType = *(short *)(ptr + ofst);
	ofst += sizeof(short);
	ofst += (sizeof(Point) + sizeof(Rect));			/* Skip 'hrct' tip and rect. */
	switch (msg->hmmHelpType) {
		case kHMStringItem:
			pcpy((StringPtr)msg->u.hmmString, (StringPtr)(ptr + ofst));
			break;
		case kHMPictItem:
			msg->u.hmmPict = *(short *)(ptr + ofst);
			break;
		case kHMStringResItem:
			strNumID = *(short *)(ptr + ofst);
			ofst += sizeof(short);
			strNumIndx = *(short *)(ptr + ofst);
			msg->u.hmmStringRes.hmmResID = strNumID;
			msg->u.hmmStringRes.hmmIndex = strNumIndx;
			break;
		case kHMTEResItem:
			msg->u.hmmTERes = *(short *)(ptr + ofst);
			break;
		case kHMSTRResItem:
			msg->u.hmmSTRRes = *(short *)(ptr + ofst);
			break;
	}

	LocalToGlobalRect(msgRct);
	*pos = (mouseLoc.v > (msgRct->top + msgRct->bottom) / 2) ? 2 : 0;
	if (mouseLoc.h > (msgRct->left + msgRct->right) / 2)
		++*pos;

	*pos = position[*pos];
	return(ctl);
}



/*****************************************************************************/



#pragma segment Main
PicHandle	BalloonText2PICT(WindowPtr window, HMMessageRecord *msg)
{
	Rect			rct, **rh;
	Handle			txt;
	StScrpHandle	stl;
	TEHandle		te;
	PicHandle		pic;
	short			ofst;
	OSErr			err;

	if (msg->hmmHelpType != kHMTEResItem) return(nil);
	if (!(rh  =      (Rect **)Get1Resource('RECT', msg->u.hmmTERes))) return(nil);
	if (!(txt =               Get1Resource('TEXT', msg->u.hmmTERes))) return(nil);
	if (!(stl = (StScrpHandle)Get1Resource('styl', msg->u.hmmTERes))) return(nil);

	rct = **rh;

	err = CTENew(gTECtl, false, window, &te, &rct, &rct, &rct, &rct, 32000, (cteNoBorder, cteStyledTE));
	if (err) return(nil);

	DetachResource(txt);
	DetachResource((Handle)stl);
	DisposeHandle(CTESwapText(te, txt, stl, false));
	DisposeHandle((Handle)stl);

	if (pic = OpenPicture(&rct)) {
		ofst = 0;
		CTEPrint(te, &ofst, &rct);		/* The bottom of rct is now calculated, returned in rct.bottom. */
		ClosePicture();
		(*pic)->picFrame.bottom = rct.bottom;
	}

	DisposeControl(CTEViewFromTE(te));
	return(pic);
}




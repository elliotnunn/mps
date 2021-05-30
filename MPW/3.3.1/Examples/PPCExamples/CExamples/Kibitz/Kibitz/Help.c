/*
** Apple Macintosh Developer Technical Support
**
** File:        help.c
** Written by:  Eric Soldan
**
** Copyright © 1991-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __BALLOONS__
#include <balloons.h>
#endif

#ifndef __PROCESSES__
#include <Processes.h>
#endif

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/
/*****************************************************************************/



#pragma segment Main
void	DynamicBalloonHelp(void)
{
	WindowPtr			window, oldPort;
	ProcessSerialNumber	cpsn, fpsn;
	FileRecHndl			frHndl;
	Point				mouseLoc, tip;
	ControlHandle		ctl;
	Rect				rct;
	short				part, message, pos, i;
	long				ref;
	HMMessageRecord		helpMessage;
	Boolean				procsSame;
	static short		lastMessage;
	static short		position[4] = {5, 6, 2, 1};

	if (gSystemVersion < 0x0700) return;
		/* The system can't support balloons. */

	if ((!HMGetBalloons()) || (!IsAppWindow(FrontWindow()))) {
		lastMessage = 0;
		return;
	}		/* Balloons have been turned off, or it isn't our window anymore. */

	HMGetBalloonWindow(&window);
	if (!window) lastMessage = 0;
		/* There is no balloon currently, so there is no last message. */

	tip = mouseLoc = GetGlobalMouse();
	part = FindWindow(mouseLoc, &window);
	if ((window != FrontWindow()) || (part != inContent)) {
		lastMessage = 0;
		return;
	}		/* We aren't over the content of the front window, so leave. */

	GetCurrentProcess(&cpsn);
	GetFrontProcess(&fpsn);
	SameProcess(&cpsn, &fpsn, &procsSame);
	if (!procsSame) {
		lastMessage = 0;
		return;
	}		/* We aren't the front process, so leave. */

	GetPort(&oldPort);
	frHndl = (FileRecHndl)GetWRefCon(window);
	SetPort(window);
	SetOrigin((*frHndl)->doc.arrangeBoard * 4096, 0);
	GlobalToLocal(&mouseLoc);

	ctl = ((WindowPeek)window)->controlList;
	while (ctl) {
		rct = (*ctl)->contrlRect;
		if (PtInRect(mouseLoc, &rct)) break;
		ctl = (*ctl)->nextControl;
	}		/* Find the control that we are over. */

	message = 0;
	if (ctl) {
		message = ref = GetCRefCon(ctl);
		message *= 2;
		if (ref > 9) {
			if (ctl == (*frHndl)->doc.gameSlider) {
				message = 24;
				if (!(*frHndl)->doc.numGameMoves) --message;
			}
			else {
				for (i = 0; i < 2; ++i) if ((TEHandle)ref == (*frHndl)->doc.message[i]) break;
				if (i < 2) message = 19 + i + i;
				else message = 0;
			}
		}
		else
			if (FindControl(mouseLoc, window, &ctl)) --message;
				/* Use regular message for active controls. */
	}
	else {
		rct = PaletteRect();
		if (PtInRect(mouseLoc, &rct)) message = 25;
	}

	if (message) {
		if (lastMessage != message) {	/* If this balloon isn't current balloon... */
			lastMessage = message;
			helpMessage.hmmHelpType             = khmmStringRes;
			helpMessage.u.hmmStringRes.hmmResID = rDynHelpStrings;
			helpMessage.u.hmmStringRes.hmmIndex = message;
			LocalToGlobalRect(&rct);
			pos = (tip.v > (rct.top + rct.bottom) / 2) ? 2 : 0;
			if (tip.h > (rct.left + rct.right) / 2) ++pos;
			pos = position[pos];
			SetOrigin(0, 0);
			HMShowBalloon(&helpMessage, tip, &rct, nil, 0, pos, kHMRegularWindow);
		}
	}
	else {
		if (lastMessage) HMRemoveBalloon();
		lastMessage = 0;
	}

	SetOrigin(0, 0);
	SetPort(oldPort);
}




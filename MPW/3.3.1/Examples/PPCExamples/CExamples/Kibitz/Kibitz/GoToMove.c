/*
** Apple Macintosh Developer Technical Support
**
** File:        gotomove.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __PACKAGES__
#include <Packages.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/



#define kGoToOK		1
#define kGoToEquivs	2
#define kGoToCancel	3
#define kStatText1	4
#define kWhichMove	5
#define kWhiteMove	6
#define kBlackMove	7

#define kLeftArrow	28
#define kRightArrow	29
#define kUpArrow	30
#define kDownArrow	31

static short	gOption;

static pascal Boolean	GoToFilter(DialogPtr dlg, EventRecord *event, short *item);



/*****************************************************************************/
/*****************************************************************************/



#pragma segment GoTo
void	DoGoToMove(FileRecHndl frHndl)
{
	WindowPtr		oldPort, window;
	DialogPtr		dialog;
	short			item, userItemType, startColor, halfMoveNum, moveNum;
	short			gameIndex, whosMove, i;
	Handle			itemHndl;
	Rect			userItemRect;
	TEHandle		te;
	Str255			str;
	TheDocPtr		docPtr;
	static ModalFilterUPP goToFilterUPP = nil;

	oldPort = SetFilePort(frHndl);

	window = (*frHndl)->fileState.window;
	if (dialog = GetCenteredDialog(rGoToMove, nil, window, (WindowPtr)-1L)) {

		startColor  = (*frHndl)->doc.startColor;
		halfMoveNum = (*frHndl)->doc.gameIndex + startColor;
		moveNum     = (halfMoveNum >> 1);

		item = kWhiteMove + (halfMoveNum - 2 * moveNum);
		GetDItem(dialog, item, &userItemType, &itemHndl, &userItemRect);
		SetCtlValue((ControlHandle)itemHndl, true);

		te = ((DialogPeek)dialog)->textH;
		pcpydec(str, moveNum + 1);
		TESetText(str + 1, *str, te);
		TESetSelect(0, *str, te);

		for (;;) {

			SetPort(dialog);
			if (!goToFilterUPP)
				goToFilterUPP = NewModalFilterProc (GoToFilter);
			ModalDialog(goToFilterUPP, &item);

			if (item == kGoToOK) {
				GetDItem(dialog, kBlackMove, &userItemType, &itemHndl, &userItemRect);
				whosMove = GetCtlValue((ControlHandle)itemHndl);
				BlockMove(*((*te)->hText), str + 1, *str = (*te)->teLength);
				break;
			}

			if (item == kGoToCancel) break;

			if (item >= kWhiteMove) {
				GetDItem(dialog, item, &userItemType, &itemHndl, &userItemRect);
				SetCtlValue((ControlHandle)itemHndl, true);
				item = (kWhiteMove + kBlackMove) - item;
				GetDItem(dialog, item, &userItemType, &itemHndl, &userItemRect);
				SetCtlValue((ControlHandle)itemHndl, false);
			}
		}

		DisposeDialog(dialog);

		if (item == kGoToOK) {
			moveNum   = p2num(str, 10, nil) - 1;
			gameIndex = ( 2 * moveNum) + whosMove - startColor;
			if (gOption) {
				moveNum = gameIndex = 0;
				docPtr  = &((*frHndl)->doc);
				if (docPtr->timeLeft[0] != -1)
					for (i = 0; i < 2; ++i)
						docPtr->displayTime[i] = docPtr->timeLeft[i] = docPtr->defaultTime[i];
			}
			if ((moveNum >= 0) && (gameIndex >= 0)) {
				SetFilePort(frHndl);
				RepositionBoard(frHndl, gameIndex, true);
				ImageDocument(frHndl, true);
				AdjustGameSlider(frHndl);
				if ((*frHndl)->doc.twoPlayer) SendGame(frHndl, kResync, nil);
				SendMssg(frHndl, kTimeMssg);
				(*frHndl)->doc.timerRefTick = TickCount();
				DrawTime(frHndl);
			}
		}
	}

	SetPort(oldPort);
}



/*****************************************************************************/



#pragma segment Config
pascal Boolean	GoToFilter(DialogPtr dlg, EventRecord *event, short *item)
{
	TEHandle				te;
	char					key;
	Boolean					arrowKey;
	static unsigned long	lastIdle;

	gOption = (event->modifiers) & optionKey;

	if (KeyEquivFilter(dlg, event, item)) return(true);

	*item = 0;

	switch (event->what) {
		case keyDown:
		case autoKey:
			te       = ((DialogPeek)dlg)->textH;
			key      = event->message & charCodeMask;
			arrowKey = ((key >= kLeftArrow) && (key <= kDownArrow));
			if ((arrowKey) || (key == 8)) return(false);	/* These are always okay. */
			if ((key < '0') || (key > '9')) return(true);	/* Don't accept non-digits. */
			if ((*te)->teLength >= 3) return(true);			/* Don't accept more than 3 chars. */
			break;
	}

	if (lastIdle + 30 < TickCount()) {
		lastIdle = TickCount();
		DoIdleTasks(false);
		SetPort(dlg);
	}

	return(false);
}




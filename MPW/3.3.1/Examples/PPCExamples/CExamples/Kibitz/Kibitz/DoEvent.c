/*
** Apple Macintosh Developer Technical Support
**
** File:        doevent.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __AEUTILS__
#include <AEUtils.h>
#endif

#ifndef __DESK__
#include <Desk.h>
#endif

#ifndef __DISKINIT__
#include <DiskInit.h>
#endif

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __MENUS__
#include <Menus.h>
#endif

#ifndef __OSEVENTS__
#include <OSEvents.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __TEXTEDITCONTROL__
#include <TextEditControl.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/



extern Cursor	*gCurrentCursor;

unsigned long	gStatusTime;
Boolean			gAlertTimeout, gComputerResigns;



/*****************************************************************************/
/*****************************************************************************/



/* Do the right thing for an event.  Determine what kind of event it is, and
** call the appropriate routines. */

#pragma segment Main
void	DoEvent(EventRecord *event)
{
	short			part, err;
	WindowPtr		window;
	char			key;
	Point			aPoint;
	FileRecHndl		frHndl;
	ControlHandle	ctl;
	long			tick;
	Rect			boardRct;
	short			retval, width, dir;

	switch(event->what) {

		case nullEvent:
			DoIdleTasks(true);
			break;

		case mouseDown:
			gCurrentCursor = nil;
				/* No shortcuts when we recalculate the cursor region. */

			part = FindWindow(event->where, &window);
			if (part != inContent) DoSetCursor(&qd.arrow);

			switch(part) {

				case inContent:
					if (window != FrontWindow()) {
						SelectWindow(window);
						if (IsAppWindow(window)) {
							DoUpdate(window);
							boardRct = GlobalBoardRect(window);
							if (PtInRect(event->where, &boardRct))
								DoEvent(event);
						}
									/* Do first click if over board. */
					} else
						DoContentClick(window, event);
					break;

				case inDrag:			
					DragWindow(window, event->where, &qd.screenBits.bounds);
					break;		/* Pass screenBits.bounds to
								** get all gDevices. */

				case inGoAway:
					if (TrackGoAway(window, event->where)) {
						CloseOneWindow(window, iClose);
					}
					break;

				case inGrow:
					break;

				case inMenuBar:		/* Process mouse menu command (if any). */
					AdjustMenus();
					DoMenuCommand(MenuSelect(event->where), event);
					break;

				case inSysWindow:	/* Let the system handle the mouseDown. */
					SystemClick(event, window);
					break;

				case inZoomIn:
				case inZoomOut:
					if (TrackBox(window, event->where, part)) {
						width = window->portRect.right - window->portRect.left;
						if (width == rWindowWidth) width = rJustBoardWindowWidth;
						else					   width = rWindowWidth;
						ZoomToWindowDevice(window, width, rWindowHeight, inZoomOut, true);
					}
					break;

			}
			break;

		case activateEvt:
			gCurrentCursor = nil;		/* No shortcuts when we recalculate the cursor region. */
			DoActivate((WindowPtr)event->message, (event->modifiers & activeFlag));
			break;

		case autoKey:
		case keyDown:					/* Check for menukey equivalents. */
			key = event->message & charCodeMask;
			if (event->modifiers & cmdKey) {		/* Command key down. */
				if (event->what == keyDown) {
					AdjustMenus();
						/* Enable/disable/check menu items properly. */
					DoMenuCommand(MenuKey(key), event);
				}
			}
			else {
				if (!IsAppWindow(window = FrontWindow())) break;
				frHndl = (FileRecHndl)GetWRefCon(window);
				if (key == 0x03) {
					ctl = (*frHndl)->doc.sendMessage;
					if (!(*ctl)->contrlHilite) {
						HiliteControl(ctl, 1);
						tick = TickCount();
						while (TickCount() < tick + 10);
						HiliteControl(ctl, 0);
						SendMssg(frHndl, kTextMssg);
					}
				}
				else {
					if (event->modifiers & optionKey) {
						dir = 0;
						if ((key == chLeft)  || (key == chUp))   dir = -1;
						if ((key == chRight) || (key == chDown)) dir = 1;
						if (dir) {
							SetFilePort(frHndl);
							RepositionBoard(frHndl, (*frHndl)->doc.gameIndex + dir, true);
							ImageDocument(frHndl, true);
							AdjustGameSlider(frHndl);
							if ((*frHndl)->doc.twoPlayer) SendGame(frHndl, kResync, nil);
							return;
						}
					}
					if (retval = CTEKey(window, event)) {
						if (retval == 2) (*frHndl)->fileState.docDirty = true;
							/* Out-box was edited, so dirty document. */
						AdjustMenus();		/* Avoid unnecessary DoCursor() and speed */
						return;				/* up TextEdit entry. */
					}
				}
			}
			break;

		case diskEvt:
			gCurrentCursor = nil;
				/* No shortcuts when we recalculate the cursor region. */

			if (HiWord(event->message) != noErr) {
				SetPt(&aPoint, kDILeft, kDITop);
				err = DIBadMount(aPoint, event->message);
			}
			break;		/* It is not a bad idea to at least call DIBadMount
						** in response to a diskEvt, so that the user can
						** format a floppy.
						*/
		case kHighLevelEvent:
			gCurrentCursor = nil;
				/* No shortcuts when we recalculate the cursor region. */

			DoHighLevelEvent(event);
			break;

		case kOSEvent:
			gCurrentCursor = nil;
				/* No shortcuts when we recalculate the cursor region. */

			switch ((event->message >> 24) & 0x0FF) {
					/* Must logical and with 0x0FF to get only low byte. */
					/* High byte of message. */

				case kMouseMovedMessage:
					DoIdleTasks(true);
					break;

				case kSuspendResumeMessage:
						/* Suspend/resume is also an activate/deactivate. */
					gInBackground = !((event->message) & kResumeMask);
					CTEConvertClipboard((event->message) & convertClipboardFlag, !gInBackground);
					DoActivate(FrontWindow(), !gInBackground);
					break;
			}
			break;

		case updateEvt:
			DoUpdate((WindowPtr)event->message);
			break;

	}

	DoCursor();
	AdjustMenus();
}



/*****************************************************************************/



/* This is called when a window is activated or deactivated. */

#pragma segment Main
void	DoActivate(WindowPtr window, Boolean becomingActive)
{
	FileRecHndl		frHndl;
	short			hilite;
	ControlHandle	ctl;

	NotifyCancel();

	if (IsAppWindow(window)) {

		frHndl = (FileRecHndl)GetWRefCon(window);

		SetPort(window);
		SetOrigin((*frHndl)->doc.arrangeBoard * 4096, 0);

		hilite = 0;
		if (!becomingActive) hilite = 255;

		HiliteControl((*frHndl)->doc.gameSlider, hilite);
		HiliteControl((*frHndl)->doc.resign, hilite);
		HiliteControl((*frHndl)->doc.draw, hilite);

		if (!(*frHndl)->doc.twoPlayer) hilite = 255;

		HiliteControl(ctl = (*frHndl)->doc.sendMessage, hilite);
		OutlineControl(ctl);
		HiliteControl((*frHndl)->doc.beepOnMove, hilite);
		HiliteControl((*frHndl)->doc.beepOnMssg, hilite);

		if (!SoundInputAvaliable()) hilite = 255;
		HiliteControl((*frHndl)->doc.record, hilite);
		if (!(*frHndl)->doc.sound) hilite = 255;
		HiliteControl((*frHndl)->doc.sendSnd, hilite);

		if (!(*frHndl)->doc.arrangeBoard) CTEWindActivate(window, true);

		DoDrawControls(window, true);
		SetOrigin(0, 0);
	}
}



/*****************************************************************************/



/* This is called when an update event is received for a window.  It calls
** ImageDocument to draw the contents of an application window.  As an
** effeciency measure that does not have to be followed, it calls the drawing
** routine only if the visRgn is non-empty.  This will handle situations where
** calculations for drawing or drawing itself is very time-consuming. */

#pragma segment Main
void	DoUpdate(WindowPtr window)
{
	if (IsAppWindow(window)) {
		BeginUpdate(window);				/* This sets up the visRgn. */
		if (!EmptyRgn(window->visRgn)) {	/* Draw if updating needs doing. */
			SetPort(window);
			ImageDocument((FileRecHndl)GetWRefCon(window), false);
		}
		EndUpdate(window);
	}
}



/*****************************************************************************/



/* This is called when a mouse-down event occurs in the content of a window.
** Other applications might want to call FindControl, TEClick, etc., to
** further process the click. */

#pragma segment Main
void	DoContentClick(WindowPtr window, EventRecord *event)
{
	Boolean			invertBoard, legalMove;
	short			fromRow, fromCol, toRow, toCol, i, myColor;
	short			fromSq, toSq, promotion, piece, item;
	short			numLegalMoves, part, twoPlayer, whosMove;
	OSErr			err;
	long			ref;
	Point			clickLoc, releaseLoc;
	Rect			boardRect, fromRect;
	FileRecHndl		frHndl;
	MoveListHndl	legalMoves;
	DialogPtr		promoteDialog;
	short			itemType, ctlNum, val, action;
	Handle			itemHndl;
	Rect			itemRect;
	ControlHandle	ctlHit;
	EventRecord		option;

	if (!IsAppWindow(window)) return;

	frHndl = (FileRecHndl)GetWRefCon(window);
	SetPort(window);
	SetOrigin((*frHndl)->doc.arrangeBoard * 4096, 0);

	twoPlayer = (*frHndl)->doc.twoPlayer;

	clickLoc = event->where;
	GlobalToLocal(&clickLoc);

	if (CTEClick(window, event, &action)) {
		SetOrigin(0, 0);
		return;
	}
		/* If TextEdit control handled the click, we are done. */

	if (part = FindControl(clickLoc, window, &ctlHit)) {
		ctlNum = ref = GetCRefCon(ctlHit);
		if ((ref) && (ref < 10)) {
			if (TrackControl(ctlHit, clickLoc, nil)) {
				switch (ctlNum) {
					case 1:
						SendMssg(frHndl, kTextMssg);
						break;
					case 2:
					case 3:
						SetCtlValue(ctlHit, val = (GetCtlValue(ctlHit) ^ 1));
						if (val)
							if ((event->modifiers) & optionKey) SendMssg(frHndl, kBeepMssg);
						break;
					case 4:
					case 5:
						SetCtlValue(ctlHit, 1);
						SetCtlValue((*frHndl)->doc.wbStart[5 - ctlNum], 0);
						(*frHndl)->doc.startColor = ctlNum - 4;
						break;
					case 6:
						EndTheGame(frHndl, kWhiteResigns + (*frHndl)->doc.myColor);
						SayTheMove(frHndl);
						UpdateGameStatus(frHndl);
						if (twoPlayer) {
							SendGame(frHndl, kIsMove, nil);
								/* Show the dialog at the other end. */
							SendGame(frHndl, kResync, nil);
								/* Make sure that simultaneous hits on the
								** resign button are taken care of. */
						}
						break;
					case 7:
						i = ((*frHndl)->doc.drawBtnState ^ 0x02);
						if (!twoPlayer) i = 0x06;
						if (i >= 0x06) {
							EndTheGame(frHndl, kDrawGame);
							SayTheMove(frHndl);
						}
						DrawButtonTitle(frHndl, i);
						if (twoPlayer) {
							SendGame(frHndl, kIsMove, nil);
								/* Show the dialog at the other end. */
							SendGame(frHndl, kResync, nil);
								/* Make sure that simultaneous hits on the
								** draw button are taken care of. */
						}
						break;
					case 8:
						err = RecordSound(frHndl);
						if ((err) && (err != userCanceledErr))
							Alert(rErrorAlert, gAlertFilterUPP);
						break;
					case 9:
						SendMssg(frHndl, kSoundMssg);
						break;
				}
			}
		}
		SetOrigin(0, 0);

		if (ctlHit == (*frHndl)->doc.gameSlider)
			TrackControl(ctlHit, clickLoc, nil);

		return;
	}

	if ((*frHndl)->fileState.readOnly) {
		SetOrigin(0, 0);
		return;
	}					/* Don't allow changes if read-only. */

	if ((*frHndl)->doc.arrangeBoard) {
		DoArrangeBoard(frHndl, event, clickLoc);
		return;
	}

	SetOrigin(0, 0);

	invertBoard = (*frHndl)->doc.invertBoard;

	boardRect = BoardRect();
	if (!PtInRect(clickLoc, &boardRect)) return;

	fromRow = (clickLoc.v - kBoardVOffset) / kBoardSqSize;
	fromCol = (clickLoc.h - kBoardHOffset) / kBoardSqSize;
	fromRect.top    = 1 + fromRow * kBoardSqSize;
	fromRect.left   = 1 + fromCol * kBoardSqSize;
	fromRect.bottom = fromRect.top  + 32;
	fromRect.right  = fromRect.left + 32;

	if (invertBoard) {
		fromRow = 7 - fromRow;
		fromCol = 7 - fromCol;
	}
	fromSq  = START_IBNDS + 10 * fromRow + fromCol;

	if (GameStatus(frHndl) != kGameContinues) return;
		/* Game over, so no moves. */

	if ((*frHndl)->doc.resync != kIsMove) return;
		/* Don't allow moves until we are resynced. */

	numLegalMoves = (*frHndl)->doc.numLegalMoves;
	legalMoves    = (*frHndl)->doc.legalMoves;

	for (i = 0; i < numLegalMoves; ++i)
		if ((**legalMoves)[i].moveFrom == fromSq) break;

	if (i == numLegalMoves) return;
		/* Clicked on a empty square or on a piece that can't move. */

	whosMove = WhosMove(frHndl);
	myColor  = (*frHndl)->doc.myColor;
	OSEventAvail(nullEvent, &option);
	if (option.modifiers & optionKey)
		if (myColor != kMessageDoc) myColor = whosMove;

	if ((twoPlayer) && (whosMove != myColor)) return;
		/* It's the other player's turn. */

	if ((whosMove == WHITE) && ((*frHndl)->doc.compMovesWhite)) return;
	if ((whosMove == BLACK) && ((*frHndl)->doc.compMovesBlack)) return;
		/* Computer is moving this color, so ignore click. */

	SetCursor(*GetCursor(closedHandCursor));
	gCurrentCursor = nil;

	releaseLoc.h = releaseLoc.v = 0x4000;
	MoveThePiece(frHndl, fromSq, fromRect, clickLoc, &releaseLoc);

	toRow = (releaseLoc.v - kBoardVOffset) / kBoardSqSize;
	toCol = (releaseLoc.h - kBoardHOffset) / kBoardSqSize;
	if (invertBoard) {
		toRow = 7 - toRow;
		toCol = 7 - toCol;
	}
	toSq = START_IBNDS + 10 * toRow + toCol;

	for (i = 0; i < numLegalMoves; ++i)
		if (
			((**legalMoves)[i].moveFrom == fromSq) &&
			((**legalMoves)[i].moveTo   == toSq)
		) break;

	promotion = QUEEN;		/* If there is a promotion, assume queen. */

	if (legalMove = (i < numLegalMoves)) {

		if ((toRow == 0) || (toRow == 7)) {		/* Possible pawn promotion... */

			piece = (*frHndl)->doc.theBoard[fromSq];
			if (piece < 0) piece = -piece;

			if (piece == PAWN) {				/* It is a pawn promotion... */

				if (option.modifiers & shiftKey) promotion = QUEEN;
				else {

					MakeMove(frHndl, fromSq, toSq, PAWN);
					ImageDocument(frHndl, true);
					MakeMove(frHndl, -1, 0, 0);

					promoteDialog = GetCenteredDialog(rPawnPromotion, nil,
													  FrontWindow(), (WindowPtr)-1L);
					if (promoteDialog) {
						SetPort(promoteDialog);
						OutlineDialogItem(promoteDialog, 1);
						DoSetCursor(&qd.arrow);

						for (item = QUEEN;;) {
							if (promotion != item) {
								GetDItem(promoteDialog, promotion + 1, &itemType, &itemHndl, &itemRect);
								SetCtlValue((ControlHandle)itemHndl, false);
							}

							GetDItem(promoteDialog, item + 1, &itemType, &itemHndl, &itemRect);
							SetCtlValue((ControlHandle)itemHndl, true);
							promotion = item;

							ModalDialog(gKeyEquivFilterUPP, &item);
							if (item == 1) break;
							--item;
						}
						DisposDialog(promoteDialog);
						SetPort(window);
					}
				}
			}
		}
	}

	if (GameStatus(frHndl)) ImageDocument(frHndl, true);
	else {
		if (legalMove) MakeMove(frHndl, fromSq, toSq, promotion);
		ImageDocument(frHndl, true);
		DrawTime(frHndl);
		if (legalMove) AdjustGameSlider(frHndl);
		DrawButtonTitle(frHndl, twoPlayer);
		UpdateGameStatus(frHndl);
		if ((legalMove) && (twoPlayer)) SendGame(frHndl, kIsMove, nil);
		if (legalMove) {
			SayTheMove(frHndl);
			AlertIfGameOver(frHndl);
		}
		(frHndl);
	}
}



/*****************************************************************************/



extern TheDoc	newDocData;

#pragma segment Main
short	AlertIfGameOver(FileRecHndl frHndl)
{
	WindowPtr		oldPort;
	DialogPtr		dialogPtr;
	short			status, i, theAlert, item;
	Str255			gameStatMssg;
	Handle			rsrc, txt;
	long			l;
	static Str255	whichMessage;
	static ModalFilterUPP	statusFilterUPP;

	theAlert = rGameStat;

	if ((status = GameStatus(frHndl)) != kGameContinues) {

		if (gComputerResigns) {
			if (!whichMessage[0]) {
				rsrc = GetResource('STR#', rComputerResigns);
				whichMessage[0] = **(short **)rsrc;
				for (i = 1; i <= whichMessage[0]; ++i) whichMessage[i] = i;
			}
			theAlert = rComputerResigns;
			gComputerResigns = false;
			l  = Random();
			l &= 0x0000FFFFL;
			l *= whichMessage[0];
			l /= 0x10000L;
			status = whichMessage[++l];
			whichMessage[l] = whichMessage[whichMessage[0]--];
		}

		UpdateGameStatus(frHndl);
		GetIndString(gameStatMssg, theAlert, status);

		ParamText(gameStatMssg, nil, nil, nil);
		DoSetCursor(&qd.arrow);

		gStatusTime = TickCount();
		if (((*frHndl)->doc.compMovesWhite) && ((*frHndl)->doc.compMovesBlack))
			status = kGameContinues;

		gAlertTimeout = false;

		GetPort(&oldPort);
		dialogPtr = GetCenteredDialog(theAlert, nil, nil, (WindowPtr)-1);
		if (dialogPtr) {
			SetPort(dialogPtr);
			DrawDialog(dialogPtr);
			OutlineDialogItem(dialogPtr, 1);
			SetEmptyRgn(((WindowPeek)dialogPtr)->updateRgn);	/* Did it by hand -- prevent redraw. */

			if ((*frHndl)->doc.doSpeech) {
				if (txt = NewHandle(gameStatMssg[0])) {
					for (i = 1; i <= gameStatMssg[0]; ++i)
						if (gameStatMssg[i] == (unsigned char)'’')
							gameStatMssg[i] = '\'';
					BlockMove(gameStatMssg + 1, *txt, gameStatMssg[0]);
					SayText(nil, txt, (*frHndl)->doc.theVoice);
					DisposeHandle(txt);
				}
			}

			if (!statusFilterUPP)
				statusFilterUPP = NewModalFilterProc(statusFilter);
			for (;;) {
				ModalDialog(statusFilterUPP, &item);
				if (item == 1) break;
			}
			DisposeDialog(dialogPtr);
		}
		else gAlertTimeout = true;
		SetPort(oldPort);

		if (!gAlertTimeout) status = GameStatus(frHndl);

		if (status == kGameContinues) {
			oldPort = SetFilePort(frHndl);
			RepositionBoard(frHndl, 0, true);
			UpdateGameStatus(frHndl);
			if ((*frHndl)->doc.twoPlayer) SendGame(frHndl, kResync, nil);
			AdjustGameSlider(frHndl);
			for (i = 0; i < 2; ++i)
				if ((*frHndl)->doc.timeLeft[i] != -1)
					(*frHndl)->doc.timeLeft[i] = (*frHndl)->doc.displayTime[i] =
						(*frHndl)->doc.defaultTime[i];
			(*frHndl)->doc.timerRefTick = TickCount();
			UpdateTime(frHndl, false);
			DrawTime(frHndl);
			SetPort(oldPort);
		}			
	}

	return(status);
}



/*****************************************************************************/



#pragma segment Config
pascal Boolean	statusFilter(DialogPtr dlg, EventRecord *event, short *item)
{
	if (KeyEquivFilter(dlg, event, item)) return(true);
	if ((gStatusTime) && (gStatusTime + 600 < TickCount())) {
		*item = 1;
		gAlertTimeout = true;
		return(true);
	}

	return(false);
}




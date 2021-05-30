/*
** Apple Macintosh Developer Technical Support
**
** File:        kibitzwindow.c
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

#ifndef __FONTS__
#include <Fonts.h>
#endif

#ifndef __GWLAYERS__
#include <GWLayers.h>
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



extern short	gPrintPage;					/* Non-zero means we are printing. */
extern LayerObj	gBoardLayer;
extern short	gClearSquare;

CIconHandle		gPieceCIcon[26];

static short		gLastPiece[120];
static RgnHandle	gLastColorRgn;



/*****************************************************************************/
/*****************************************************************************/



/* This function adds the application's controls to a window. */

#pragma segment Window
OSErr	AppNewWindowControls(FileRecHndl frHndl, WindowPtr window, WindowPtr behind)
{
	WindowPtr		oldPort;
	OSErr			err;
	TEHandle		mssgIn, mssgOut;
	CTEDataHndl		teData;
	ControlHandle	sendMssg, beepOnMove, beepOnMssg, viewCtl;
	Rect			ctlRect, brdrRect, viewRect, destRect;
	ControlHandle	gameSlider, whiteStarts, blackStarts, resign, draw;
	ControlHandle	record, sendSnd;
	Handle			textHndl;
	Boolean			messageDoc;
	short			mode;
	TextStyle		styl;

	GetPort(&oldPort);
	SetPort(window);

	SetRect(&ctlRect,
			kBoardWidth + 20,
			35,
			rWindowWidth - 20,
			kBoardHalfHeight + kBoardVOffset - 1
	);

	brdrRect = viewRect = ctlRect;
	InsetRect(&viewRect, 4, 4);
	destRect = viewRect;
	destRect.right -= 2;
		/* This fixes a TextEdit problem where the view has to be a little
		** outside the dest on the right, or else characters are clipped.
		*/

	styl.tsFont = applFont;
	styl.tsSize = 9;

	TextFont(styl.tsFont);
	TextSize(styl.tsSize);

	CTENew(rTECtl,				/* viewCtl of resID for TextEdit control. */
		   true,					/* Visible.								  */
		   window,					/* Window to hold TERecord.				  */
		   &mssgIn,					/* Return handle for TERecord. 			  */
		   &ctlRect,				/* Rect for view control.				  */
		   &destRect,				/* destRect for TERecord				  */
		   &viewRect,				/* viewRect for TERecord				  */
		   &brdrRect,				/* Used to frame a border.				  */
		   32000,					/* Maximum TextEdit document length.	  */
		   cteReadOnly+cteVScroll	/* TERecord is regular read-only.		  */
	);
	if (mssgIn)
		TESetStyle((doFont | doSize), &styl, false, mssgIn);

	OffsetRect(&ctlRect, 0, kBoardHalfHeight - 38);

	messageDoc = false;
	if ((*frHndl)->doc.myColor == kMessageDoc) messageDoc = true;
	if (messageDoc)
		SetRect(&ctlRect, -1, -1, rWindowWidth - 14, rWindowHeight + 1);
			/* When the window is a message document, the whole window is the outbox.
			** This keep the actual differences between window kinds to a minimum,
			** while altering the appearance greatly. */

	brdrRect = viewRect = ctlRect;
	InsetRect(&viewRect, 4, 4);
	destRect = viewRect;
	destRect.right -= 2;

	mode = cteVScroll;
	if (behind == (WindowPtr)-1)
		if (!(*frHndl)->doc.arrangeBoard)
			mode |= cteActive;
	CTENew(rTECtl, true, window, &mssgOut, &ctlRect, &destRect, &viewRect, &brdrRect, 32000, mode);

	if (mssgOut) {
		TESetStyle((doFont | doSize), &styl, false, mssgOut);

		viewCtl = CTEViewFromTE(mssgOut);
		teData  = (CTEDataHndl)(*viewCtl)->contrlData;
		(*teData)->mode |= cteActive;
			/* Make sure that when a window is activated, the caret blinks.  We need
			** to do this because the window isn't necessarily opened as the front window.
			** If we create the TextEdit Control as the active control for a window that
			** isn't opened as the front window, then we will turn off the caret for
			** whatever window is the front window.  Al we are doing here is determining
			** that the message-out TextEdit Control will be the active control when the
			** window is first brought to the front. */
	
		textHndl = (Handle)(*frHndl)->doc.legalMoves;
		(*frHndl)->doc.legalMoves = (MoveListHndl)CTESwapText(mssgOut, textHndl, nil, false);
			/* AppOpenDocument may have placed some text for the out-box TextEdit
			** control temporarily in the legalMoves handle.  Move this text into
			** the out-box TextEdit control. */
	}

	if (sendMssg   = GetNewControl(rSendMessage, window)) HiliteControl(sendMssg, 255);
	if (beepOnMove = GetNewControl(rMoveNotify, window))  HiliteControl(beepOnMove, 255);
	if (beepOnMssg = GetNewControl(rMssgNotify, window))  HiliteControl(beepOnMssg, 255);

	if (whiteStarts = GetNewControl(rWhiteStarts, window)) {
		OffsetControl(whiteStarts, -4096, 0);
		SetCtlValue(whiteStarts, (*frHndl)->doc.startColor ^ 1);
		ShowControl(whiteStarts);
	}
	if (blackStarts = GetNewControl(rBlackStarts, window)) {
		OffsetControl(blackStarts, -4096, 0);
		SetCtlValue(blackStarts, (*frHndl)->doc.startColor);
		ShowControl(blackStarts);
	}

	resign      = GetNewControl(rResign, window);
	draw        = GetNewControl(rDraw, window);
	if (record  = GetNewControl(rRecordSound, window)) HiliteControl(record, 255);
	if (sendSnd = GetNewControl(rSendSound, window))   HiliteControl(sendSnd, 255);

	gameSlider = BoardSliderNew(window);

	(*frHndl)->doc.message[kMessageIn]  = mssgIn;
	(*frHndl)->doc.message[kMessageOut] = mssgOut;
	(*frHndl)->doc.sendMessage = sendMssg;
	(*frHndl)->doc.beepOnMove  = beepOnMove;
	(*frHndl)->doc.beepOnMssg  = beepOnMssg;
	(*frHndl)->doc.gameSlider  = gameSlider;
	(*frHndl)->doc.wbStart[0]  = whiteStarts;
	(*frHndl)->doc.wbStart[1]  = blackStarts;
	(*frHndl)->doc.resign      = resign;
	(*frHndl)->doc.draw        = draw;
	(*frHndl)->doc.record      = record;
	(*frHndl)->doc.sendSnd     = sendSnd;

	if (
		(mssgIn) &&
		(mssgOut) &&
		(sendMssg) &&
		(beepOnMove) &&
		(beepOnMssg) &&
		(gameSlider) &&
		(whiteStarts) &&
		(blackStarts) &&
		(resign) &&
		(draw) &&
		(record) &&
		(sendSnd)
	) {
		if (messageDoc) {
			CTEHide(mssgIn);
			HideControl(sendMssg);
			MoveControl(sendMssg, 0, -4096);	/* So no border is drawn. */
			HideControl(beepOnMove);
			HideControl(beepOnMssg);
			HideControl(gameSlider);
			HideControl(whiteStarts);
			HideControl(blackStarts);
			HideControl(resign);
			HideControl(draw);
			HideControl(record);
			HideControl(sendSnd);
		}
		AdjustGameSlider(frHndl);
		err = noErr;
	}
	else
		err = memFullErr;

	SetPort(oldPort);
	return(err);
}



/*****************************************************************************/



#pragma segment Window
void	DrawTime(FileRecHndl frHndl)
{
	WindowPtr		oldPort;
	Rect			clockRect;
	short			clock, i, time[3];
	unsigned long	timeLeft, displayTime;
	Str32			pstr, timestr;

	if ((*frHndl)->doc.arrangeBoard) return;

	oldPort = SetFilePort(frHndl);

	TextMode(srcCopy);
	TextFont(systemFont);
	TextSize(0);
	TextFace(normal);

	for (clock = 0; clock < 2; ++clock) {

		clockRect = BoardRect();

		if (clock == (*frHndl)->doc.invertBoard)
			clockRect.top += 14;

		clockRect.left   = clockRect.right + 26;
		clockRect.right  = clockRect.left + 70;
		clockRect.bottom = clockRect.top + 14;

		timeLeft = (*frHndl)->doc.timeLeft[clock];
		if (timeLeft == -1) {
			EraseRect(&clockRect);
			continue;
		}

		if ((displayTime = (*frHndl)->doc.displayTime[clock]) > timeLeft)
			 displayTime = (*frHndl)->doc.displayTime[clock]  = timeLeft;

		MoveTo(clockRect.left + 6, clockRect.top + 14);

		for (i = 3; i;) {
			displayTime /= 60;
			time[--i] = displayTime % 60;
		}
		timestr[0] = 0;
		for (i = 0; i < 3; ++i) {
			pcpydec(pstr, time[i]);
			if (pstr[0] == 1) pcat(timestr, "\p0");
			pcat(timestr, pstr);
			pcat(timestr, (StringPtr)"\1:\1:\1 " + (i << 1));	/* Append colon or space. */
		}
		DrawString(timestr);
	}

	TextMode(srcOr);
	SetPort(oldPort);
}



/*****************************************************************************/



#pragma segment Window
void	ImageBoardLines(short increment, short hOffset, short vOffset)
{
	short	i;

	PenNormal();
	PenSize(1, 1);

	for (i = 0; i <= 8; i += increment) {
		MoveTo(hOffset, vOffset + kBoardSqSize * i);
		Line(kBoardSqSize * 8, 0);
		MoveTo(hOffset + kBoardSqSize * i, vOffset);
		Line(0, kBoardSqSize * 8);
	}

	PenNormal();
}



/*****************************************************************************/



/* Image the document into the current port. */

#pragma segment Window
void	ImageDocument(FileRecHndl frHndl, Boolean justBoard)
{
	short			r, c, rr, cc, piece, pieceIconID, fnum, i;
	short			gameIndex, lastFrom, lastTo, square, ss, hOffset, vOffset;
	Boolean			toWindow, invertBoard, messageDoc;
	LayerObj		windowLayer;
	Rect			sqRect, theInk, boardRect;
	GameListHndl	gameMoves;
	WindowPtr		curPort;
	TEHandle		te;
	Point			pt;
	RgnHandle		colorRgn, testRgn;
	static short	teOffset;

	GetPort(&curPort);

	toWindow = (curPort == (*frHndl)->fileState.window);
	if (!toWindow) gClearSquare = 0;

	messageDoc = false;
	if ((*frHndl)->doc.myColor == kMessageDoc) messageDoc = true;

	colorRgn = testRgn = nil;

	hOffset = kBoardHOffset;
	vOffset = kBoardVOffset;
	if (gPrintPage > 0) {
		theInk = curPort->portRect;
		GetFNum("\pTimes", &fnum);
		TextFont(fnum);
		TextSize(12);
		TextFace(normal);
		hOffset = theInk.right - 10 - kBoardWidth;
		vOffset = 10;
		if (messageDoc) {
			if (gPrintPage == 1) teOffset = 0;
			te = (*frHndl)->doc.message[kMessageOut];
			InsetRect(&theInk, 4, 4);
			CTEPrint(te, &teOffset, &theInk);
			if (teOffset == -1) gPrintPage = 0;
			return;
		}
		if (curPort->portBits.rowBytes & 0x8000)
			RectRgn(colorRgn = NewRgn(), &theInk);
				/* Print the board in grayscale or color if user has so chosen. */
	}
	else {
		SetRectRgn(curPort->clipRgn, -30000, -30000, 30000, 30000);

		if (!messageDoc) {
			if (!gPrintPage) ImageBoardLines(8, hOffset, vOffset);

			colorRgn = ScreenDepthRegion(8);		/* Screen of 8-bit or greater get color icon. */
			pt.h = pt.v = 0;
			GlobalToLocal(&pt);
			OffsetRgn(colorRgn, pt.h, pt.v);		/* Localize the area that gets color icons. */

			if (!gPrintPage) SetLayerWorld(gBoardLayer);
		}
	}

	if (!colorRgn) colorRgn = NewRgn();
	if (!testRgn)  testRgn  = NewRgn();

	if (!gLastColorRgn) gLastColorRgn = NewRgn();
	if ((gPrintPage) || (!EqualRgn(colorRgn, gLastColorRgn)))
		for (i = 0; i < 120; ++i) gLastPiece[i] = 0;
			/* If printing, exporting a board, or if color region has changed, redraw all squares. */
	CopyRgn(colorRgn, gLastColorRgn);

	invertBoard = (*frHndl)->doc.invertBoard;
	lastFrom = lastTo = 0;
	gameIndex = (*frHndl)->doc.gameIndex;
	gameMoves = (*frHndl)->doc.gameMoves;
	if (gameIndex) {
		lastFrom = (**gameMoves)[gameIndex - 1].moveFrom;
		lastTo   = (**gameMoves)[gameIndex - 1].moveTo;
		if (!lastFrom) {
			if (gameIndex > 1) {
				lastFrom = (**gameMoves)[gameIndex - 2].moveFrom;
				lastTo   = (**gameMoves)[gameIndex - 2].moveTo;
			}
		}
	}

	if (gPrintPage < 2) {		/* If not printing, or printing first page... */
		if (!messageDoc) {
			for (r = 0; r < 8; ++r) {
				if (gClearSquare) r = (gClearSquare - START_IBNDS) / 10;

				for (c = 0; c < 8; ++c) {
					if (gClearSquare) c = gClearSquare - START_IBNDS - 10 * r;
				
					piece = (*frHndl)->doc.theBoard[square = START_IBNDS + 10 * r + c];
					if (gClearSquare) piece = EMPTY;
					pieceIconID = piece + KING;
	
					rr = r;
					cc = c;
					if (invertBoard) {
						rr = 7 - r;
						cc = 7 - c;
					}
					ss = START_IBNDS + 10 * rr + cc;

					if ((rr + cc) & 0x01) pieceIconID += 13;

					if (!gPieceCIcon[pieceIconID])
						gPieceCIcon[pieceIconID] = ReadCIcon(pieceIconID + 257);

					sqRect.top    = vOffset + kBoardSqSize * rr + 1;
					sqRect.left   = hOffset + kBoardSqSize * cc + 1;
					sqRect.bottom = sqRect.top  + 32;
					sqRect.right  = sqRect.left + 32;

					if (gLastPiece[ss] != pieceIconID + 257) {
						gLastPiece[ss] = pieceIconID + 257;
						if (!RectInRgn(&sqRect, colorRgn))		/* If 1-bit, draw b/w icon. */
							DrawCIconByDepth(gPieceCIcon[pieceIconID], sqRect, 1, false);
						else {		/* Draw some combo of color and b/w icon. */
							RectRgn(testRgn, &sqRect);
							SectRgn(testRgn, colorRgn, testRgn);
							for (;;) {
								if ((*testRgn)->rgnSize == 10) {
									if (EqualRect(&((*testRgn)->rgnBBox), &sqRect)) {
										DrawCIconByDepth(gPieceCIcon[pieceIconID], sqRect, 8, false);
										break;			/* Icon completely on color monitor. */
									}
								}
								DrawCIconByDepth(gPieceCIcon[pieceIconID], sqRect, 1, false);
									/* Icon is across two monitors, so first draw it b/w. */
								SetClip(testRgn);
								DrawCIconByDepth(gPieceCIcon[pieceIconID], sqRect, 8, false);
									/* Then redraw the color portion. */
								SetRectRgn(testRgn, -30000, -30000, 30000, 30000);
								SetClip(testRgn);
								break;
							}
						}
					}

					if (!gPrintPage) {
						if ((square == lastFrom) || (square == lastTo)) {
							FrameRect(&sqRect);
							gLastPiece[ss] = 0;
						}
					}

					if (gClearSquare) break;
				}
				if (gClearSquare) break;
			}
		}
	}

	DisposeRgn(colorRgn);
	DisposeRgn(testRgn);

	if (!gPrintPage) {
		if (!messageDoc)
			if (!gPrintPage)
				ResetLayerWorld(gBoardLayer);
		if (toWindow) {
			if (!gClearSquare) {
				if (!messageDoc) {
					if (!NewLayer(&windowLayer, nil, nil, curPort, 8, 0)) {
						InsertLayer(gBoardLayer, windowLayer, 1);
						boardRect = BoardRect();
						(*windowLayer)->dstRect = boardRect;
						InvalLayer(windowLayer, boardRect, false);
						UpdateLayer(windowLayer);
						DisposeLayer(windowLayer);
					}
				}
			}
		}
	}			

	if (gPrintPage) {				/* If printing... */
		if (gPrintPage == 1)		/* If printing page 1... */
			ImageBoardLines(1, hOffset, vOffset);
		ImageMoveList(frHndl, theInk, hOffset);
		return;
	}

	if (!justBoard) {
		SetOrigin((*frHndl)->doc.arrangeBoard * 4096, 0);
		if (!messageDoc) UpdateGameStatus(frHndl);
		DoDrawControls(curPort, false);
		if (!messageDoc) {
			OutlineControl((*frHndl)->doc.sendMessage);
			DrawTime(frHndl);
			DrawPalette(frHndl);
		}
		SetOrigin(0, 0);
	}
}



/*****************************************************************************/



#pragma segment Window
void	ImageMoveList(FileRecHndl frHndl, Rect theInk, short hOffset)
{
	short	gameIndex, numGameMoves, printMoveNum, colsPerPage, colHeight;
	short	pageNum, colNum, colVOffset, numMovePairs, colEndMove, hloc, vloc;
	Str255	pstr;

	gameIndex    = (*frHndl)->doc.gameIndex;
	numGameMoves = (*frHndl)->doc.numGameMoves;
	printMoveNum = (*frHndl)->doc.startColor;
	colsPerPage  = (theInk.right  - theInk.left) / 180;
	colHeight    = (theInk.bottom - theInk.top) - 2 * kBoardHOffset;

	for (pageNum = 1; pageNum <= gPrintPage; ++pageNum) {

		for (colNum = 1; colNum <= colsPerPage; ++colNum) {

			hloc = colNum * 180 - 120;

			colVOffset = 0;
			if (pageNum == 1) {
				if (colNum == 1) colVOffset = (3 * 20);
				if (hloc + 130 >= hOffset)
					for (; colVOffset < (kBoardHeight + 20 + kBoardVOffset); colVOffset += 20);
						/* Start this column below the board on 20-pixel boundary. */
			}

			numMovePairs = (colHeight - colVOffset) / 20;
			colEndMove   = printMoveNum + 2 * numMovePairs;

			if (pageNum == gPrintPage) {

				if ((pageNum == 1) && (colNum == 1)) {
					MoveTo(hloc, theInk.top + 20);
					pcpy(pstr, (*frHndl)->fileState.fss.name);
					TextFace(bold + underline);
					DrawString(pstr);
					TextFace(normal);
				}

				for (; printMoveNum < colEndMove; ++printMoveNum) {

					RepositionBoard(frHndl, printMoveNum, false);

					if (printMoveNum >= numGameMoves) {
						gPrintPage = 0;
						RepositionBoard(frHndl, gameIndex, false);
						return;
					}

					vloc = theInk.top + colVOffset + 20;

					if (!(printMoveNum & 0x01)) {
						pcpydec(pstr, printMoveNum / 2 + 1);
						MoveTo(hloc - 16 - StringWidth(pstr), vloc);
						DrawString(pstr);
						DrawString("\p)");
						MoveTo(hloc, vloc);
					}
					else {
						MoveTo(hloc + 40, vloc);
						MoveTo(hloc + 40 + 12, vloc);
						colVOffset += 20;
					}

					if (Algebraic(frHndl, printMoveNum, gameIndex, pstr))
						TextFace(underline);

					DrawString(pstr);
					TextFace(normal);
				}
			}

			if ((printMoveNum = colEndMove) >= numGameMoves) {
				gPrintPage = 0;
				RepositionBoard(frHndl, gameIndex, false);
				return;
			}
		}
	}

	RepositionBoard(frHndl, gameIndex, false);
}




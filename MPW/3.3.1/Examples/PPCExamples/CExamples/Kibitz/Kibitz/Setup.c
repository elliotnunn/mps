/*
** Apple Macintosh Developer Technical Support
**
** File:        setup.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __GWLAYERS__
#include <GWLayers.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif


extern Cursor	*gCurrentCursor;




/*****************************************************************************/
/*****************************************************************************/



#pragma segment Config
void	DoArrangeBoard(FileRecHndl frHndl, EventRecord *event, Point clickLoc)
{
	short			piece, fromSq, fromRow, fromCol, toRow, toCol, toSq;
	short			palettePiece, color, delta, middle, i;
	Boolean			squareWasEmpty, changedPalettePiece;
	Rect			paletteRect, boardRect, fromRect;
	Point			releaseLoc;
	ControlHandle	ctl;

	paletteRect = PaletteRect();
	if (PtInRect(clickLoc, &paletteRect)) {
		palettePiece = 1 + (clickLoc.h - paletteRect.left) / kBoardSqSize;
		if (clickLoc.v < paletteRect.top + kBoardSqSize)
			palettePiece = -palettePiece;
		(*frHndl)->doc.palettePiece = palettePiece;
		DrawPalette(frHndl);
		SetOrigin(0, 0);
		return;
	}

	SetOrigin(0, 0);
	clickLoc.h += 4096;

	squareWasEmpty = false;

	boardRect = BoardRect();
	if (PtInRect(clickLoc, &boardRect)) {

		fromRow = (clickLoc.v - kBoardVOffset) / kBoardSqSize;
		fromCol = (clickLoc.h - kBoardHOffset) / kBoardSqSize;
		fromRect.top    = 1 + fromRow * kBoardSqSize;
		fromRect.left   = 1 + fromCol * kBoardSqSize;
		fromRect.bottom = fromRect.top  + 32;
		fromRect.right  = fromRect.left + 32;

		if ((*frHndl)->doc.invertBoard) {
			fromRow = 7 - fromRow;
			fromCol = 7 - fromCol;
		}
		fromSq = START_IBNDS + 10 * fromRow + fromCol;

		piece = (*frHndl)->doc.palettePiece;
		changedPalettePiece = false;
		if (event->modifiers & optionKey) {
			changedPalettePiece = true;
			i = (*frHndl)->doc.theBoard[fromSq];
			if ((i != WK) && (i != BK) && (i != EMPTY)) {
				piece = (*frHndl)->doc.palettePiece = i;
				SetOrigin((kArrangeBoard * 4096), 0);
				DrawPalette(frHndl);
				SetOrigin(0, 0);
			}
		}

		if ((*frHndl)->doc.theBoard[fromSq] == EMPTY) {
			squareWasEmpty = true;
			if (piece == WP) {
				if (fromRow == 7) return;
				if (fromRow == 0) piece = WQ;
			}
			if (piece == BP) {
				if (fromRow == 0) return;
				if (fromRow == 7) piece = BQ;
			}
			(*frHndl)->doc.theBoard[fromSq]  = piece;
			(*frHndl)->doc.gameIndex      = 0;
			(*frHndl)->doc.numGameMoves   = 0;
			(*frHndl)->fileState.docDirty = true;
			ctl = (*frHndl)->doc.gameSlider;
			(*ctl)->contrlMax   = 0;
			(*ctl)->contrlValue = 0;

			if (fromSq == 21) (*frHndl)->doc.king[BLACK].rookMoves[QSIDE] = 0;
			if (fromSq == 28) (*frHndl)->doc.king[BLACK].rookMoves[KSIDE] = 0;
			if (fromSq == 91) (*frHndl)->doc.king[WHITE].rookMoves[QSIDE] = 0;
			if (fromSq == 98) (*frHndl)->doc.king[WHITE].rookMoves[KSIDE] = 0;
				/* Adjust castling privileges. */

			(*frHndl)->doc.enPasMove    = (*frHndl)->doc.arngEnPasMove    = 0;
			(*frHndl)->doc.enPasPawnLoc = (*frHndl)->doc.arngEnPasPawnLoc = 0;
				/* Double-pawn-push must be last change to enable en-passant. */
		}

		SetCursor(*GetCursor(closedHandCursor));
		gCurrentCursor = nil;

		piece = (*frHndl)->doc.theBoard[fromSq];
		releaseLoc.h = releaseLoc.v = 0x4000;
		if (piece) MoveThePiece(frHndl, fromSq, fromRect, clickLoc, &releaseLoc);

		if ((toRow = releaseLoc.v - kBoardVOffset) < 0) toRow = -1;
		else											toRow /= kBoardSqSize;
		if ((toCol = releaseLoc.h - kBoardHOffset) < 0) toCol = -1;
		else											toCol /= kBoardSqSize;
		if ((*frHndl)->doc.invertBoard) {
			toRow = 7 - toRow;
			toCol = 7 - toCol;
		}
		if ((toRow > -1) && (toRow < 8) && (toCol > -1) && (toCol < 8)) {
			toSq = START_IBNDS + 10 * toRow + toCol;
			if (toSq == fromSq) {
				if (!squareWasEmpty) {
					if (!changedPalettePiece) {
						if ((piece != WK) && (piece != BK)) {
							(*frHndl)->doc.theBoard[fromSq] = EMPTY;
							SetOrigin((kArrangeBoard * 4096), 0);
							DrawPalette(frHndl);
							SetOrigin(0, 0);
						}
					}
				}
				ImageDocument(frHndl, true);
				return;
			}
		}
		else toSq = fromSq;

		if (((*frHndl)->doc.theBoard[toSq] == BK) || ((*frHndl)->doc.theBoard[toSq] == WK)) {
			ImageDocument(frHndl, true);
			return;
		}

		piece = (*frHndl)->doc.theBoard[fromSq];
		if ((piece == WP) && (toSq >= 91)) {
			ImageDocument(frHndl, true);
			return;
		}
		if ((piece == WP) && (toSq <= 28)) piece = WQ;
		if ((piece == BP) && (toSq <= 28)) {
			ImageDocument(frHndl, true);
			return;
		}
		if ((piece == BP) && (toSq >= 91)) piece = BQ;

		(*frHndl)->doc.theBoard[toSq]    = piece;
		(*frHndl)->doc.theBoard[fromSq]  = EMPTY;
		(*frHndl)->doc.gameIndex      = 0;
		(*frHndl)->doc.numGameMoves   = 0;
		(*frHndl)->fileState.docDirty = true;
		ctl = (*frHndl)->doc.gameSlider;
		(*ctl)->contrlMax   = 0;
		(*ctl)->contrlValue = 0;

		if ((piece == WK) || (piece == BK)) {
			color = (piece < 0) ? WHITE : BLACK;
			(*frHndl)->doc.king[color].kingLoc   = toSq;
			(*frHndl)->doc.king[color].kingMoves = true;
		}

		if ((fromSq==21) || (toSq==21)) ++(*frHndl)->doc.king[BLACK].rookMoves[QSIDE];
		if ((fromSq==28) || (toSq==28)) ++(*frHndl)->doc.king[BLACK].rookMoves[KSIDE];
		if ((fromSq==91) || (toSq==91)) ++(*frHndl)->doc.king[WHITE].rookMoves[QSIDE];
		if ((fromSq==98) || (toSq==98)) ++(*frHndl)->doc.king[WHITE].rookMoves[KSIDE];
			/* Adjust castling privileges. */

		(*frHndl)->doc.enPasMove    = (*frHndl)->doc.arngEnPasMove    = 0;
		(*frHndl)->doc.enPasPawnLoc = (*frHndl)->doc.arngEnPasPawnLoc = 0;
			/* Double-pawn-push must be last change to enable en-passant. */

		delta = 0;
		if (piece == WP)
			if ((fromSq >= 81) && (fromSq <= 88))
				delta = fromSq - toSq;
		if (piece == BP)
			if ((fromSq >= 31) && (fromSq <= 38))
				delta = toSq - fromSq;
		if (delta == 20) {
			middle = (fromSq + toSq) / 2;
			if (!(*frHndl)->doc.theBoard[middle]) {
				(*frHndl)->doc.enPasMove        = middle;
				(*frHndl)->doc.arngEnPasMove    = middle;
				(*frHndl)->doc.enPasPawnLoc     = toSq;
				(*frHndl)->doc.arngEnPasPawnLoc = toSq;
			}
		}

		ImageDocument(frHndl, true);
	}
}



/*****************************************************************************/



#pragma segment Config
void	DrawPalette(FileRecHndl frHndl)
{
	GrafPtr		curPort;
	short		rr, cc, piece;
	Rect		paletteRect;
	CIconHandle	pieceIcon;

	GetPort(&curPort);
	if (curPort->portRect.left != -4096) return;

	PenSize(1, 1);
	for (rr = 1; rr < 6; ++rr) {
		for (cc = -1; cc < 3; cc += 2) {
			paletteRect = PaletteRect();
			paletteRect.left += (rr - 1) * kBoardSqSize;
			if (cc == 1) paletteRect.top += kBoardSqSize;
			paletteRect.right  = paletteRect.left + 32;
			paletteRect.bottom = paletteRect.top + 32;
			piece = rr * cc;
			if (piece == (*frHndl)->doc.palettePiece) piece += 13;
			pieceIcon = ReadCIcon(263 + piece);
			DrawCIconNoMask(pieceIcon, paletteRect);
			InsetRect(&paletteRect, -1, -1);
			FrameRect(&paletteRect);
			KillCIcon(pieceIcon);
		}
	}
	PenNormal();
}



/*****************************************************************************/



#pragma segment Config
Rect	PaletteRect(void)
{
	Rect	paletteRect;

	paletteRect.top    = 74;
	paletteRect.left   = kBoardWidth + 21;
	paletteRect.right  = paletteRect.left + 5 * kBoardSqSize;
	paletteRect.bottom = paletteRect.top + 2 * kBoardSqSize;
	OffsetRect(&paletteRect, -4096, 0);

	return(paletteRect);
}




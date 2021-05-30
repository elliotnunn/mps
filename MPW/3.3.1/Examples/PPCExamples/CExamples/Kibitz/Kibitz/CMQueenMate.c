/*
** Apple Macintosh Developer Technical Support
**
** File:	    cmqueenmate.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/



/*****************************************************************************/



extern short	gPieceLoc;



/*****************************************************************************/



#pragma segment Chess
short	QueenMate(FileRecHndl game)
{
	short			color, myKingLoc, opKingLoc, pieceLoc;
	short			mkr, mkc, okr, okc, pr, pc, row, col;
	short			dr, dc, absdr, absdc;
	short			from, to, val, minVal, minMove;
	short			rspin;
	Boolean			pieceBetween, hflip;
	MoveListHndl	moves;
	short			num, move;

	GenerateLegalMoves(game);
	num   = (*game)->doc.numLegalMoves;
	moves = (*game)->doc.legalMoves;

	color = WhosMove(game);
	myKingLoc = (*game)->doc.king[color].kingLoc;
	opKingLoc = (*game)->doc.king[1 - color].kingLoc;
	pieceLoc  = gPieceLoc;

	for (rspin = 0; rspin < 4; ++rspin) {		/* Rotate until okr < pr < mkr. */
		GetDeltas(pieceLoc, opKingLoc, &dr, &dc, &absdr, &absdc);
		if (dr > 0) {
			GetDeltas(myKingLoc, pieceLoc, &dr, &dc, &absdr, &absdc);
			if (dr > 0) break;
		}
		RSpinPosition(&myKingLoc);
		RSpinPosition(&opKingLoc);
		RSpinPosition(&pieceLoc);
		for (move = 0; move < num; ++move) {
			RSpinPosition(&(**moves)[move].moveFrom);
			RSpinPosition(&(**moves)[move].moveTo);
		}
	}

	pieceBetween = (rspin < 4);
	if (!pieceBetween) {
		for (rspin = 0; rspin < 4; ++rspin) {	/* Rotate until myKing 2+ rows below opKing. */
			GetDeltas(myKingLoc, opKingLoc, &dr, &dc, &absdr, &absdc);
			if (dr > 1) break;
			RSpinPosition(&myKingLoc);
			RSpinPosition(&opKingLoc);
			RSpinPosition(&pieceLoc);
			for (move = 0; move < num; ++move) {
				RSpinPosition(&(**moves)[move].moveFrom);
				RSpinPosition(&(**moves)[move].moveTo);
			}
		}
	}

	GetRowCol(opKingLoc, &okr, &okc);
	hflip = false;
	if (okc > 3) hflip = true;		/* Position opponent king on left side of board. */
	if (hflip) {
		HFlipPosition(&myKingLoc);
		HFlipPosition(&opKingLoc);
		HFlipPosition(&pieceLoc);
		for (move = 0; move < num; ++move) {
			HFlipPosition(&(**moves)[move].moveFrom);
			HFlipPosition(&(**moves)[move].moveTo);
		}
	}

	GetRowCol(myKingLoc, &mkr, &mkc);
	GetRowCol(opKingLoc, &okr, &okc);
	GetRowCol(pieceLoc,  &pr,  &pc);

	if (!pieceBetween) {
		if ((pr >= mkr) || (pr < okr)) {
			for (minVal = 16, move = 0; move < num; ++move) {
				from = (**moves)[move].moveFrom;
				to   = (**moves)[move].moveTo;
				if (from == pieceLoc) {			/* If piece move... */
					GetRowCol(to, &row, &col);
					val = row - okr;
					if (val < 1) val = 7;
					GetDeltas(to, opKingLoc, &dr, &dc, &absdr, &absdc);
					if (absdc < 3) {
						if (val == 1) val = 7;
						if (val == 2) val += (3 - absdc);
					}
					if (minVal > val) {
						minVal = val;
						minMove = move;
					}
				}
			}
			GenerateLegalMoves(game);
			return(minMove);
		}
	}

	GetDeltas(pieceLoc, opKingLoc, &dr, &dc, &absdr, &absdc);
	from = pieceLoc;
	to = 0;
	for (;;) {
		if (dc < 0) {
			to = from + (okc - pc) + 1;
			if (absdr == 1) ++to;
			break;
		}
		if (dr > 1) {
			to = from - 10 * (dr - 1);
			if (dc == 1) to += (dr - 1);
			if ((opKingLoc == START_IBNDS) && (to == (START_IBNDS + 12))) to += 10;
			break;
		}
		if (!okr) {
			to = opKingLoc + 12;
			if (!okc) ++to;
			if (from != to) break;
		}
		else if ((to = opKingLoc + 12) != from) break;

		from = to = myKingLoc;
		if (!mkc) ++to;
		if (mkc > 1) --to;
		if ((mkr - pr) > 1) to -= 10;
		if (to == from) --to;

		break;
	}

	for (move = 0; move < num; ++move) {
		if ((from == (**moves)[move].moveFrom) && (to == (**moves)[move].moveTo)) {
			GenerateLegalMoves(game);
			return(move);
		}
	}

	GenerateLegalMoves(game);		/* This should never happen. */
	return(0);
}




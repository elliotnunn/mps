/*
** Apple Macintosh Developer Technical Support
**
** File:	    cmrookmate.c
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
short	RookMate(FileRecHndl game)
{
	short			color, myKingLoc, opKingLoc, pieceLoc;
	short			mkr, mkc, okr, okc, pr, pc;
	short			dr, dc, absdr, absdc;
	short			from, to, minVal, minMove;
	short			rspin;
	Boolean			hflip, onEdge;
	MoveListHndl	moves;
	short			num, move;

	GenerateLegalMoves(game);
	num   = (*game)->doc.numLegalMoves;
	moves = (*game)->doc.legalMoves;

	color = WhosMove(game);
	myKingLoc = (*game)->doc.king[color].kingLoc;
	opKingLoc = (*game)->doc.king[1 - color].kingLoc;
	pieceLoc  = gPieceLoc;

	GetDeltas(myKingLoc, pieceLoc, &dr, &dc, &absdr, &absdc);
	if ((absdr > 1) || (absdc > 1)) {			/* If piece not next to king... */
		GetRowCol(opKingLoc, &okr, &okc);
		onEdge = false;
		if ((!okr) || (okr == 7)) onEdge = true;
		if ((!okc) || (okc == 7)) onEdge = true;
		for (minVal = 16, move = 0; move < num; ++move) {
			from = (**moves)[move].moveFrom;
			to   = (**moves)[move].moveTo;
			if (from == pieceLoc) {			/* If piece move... */
				GetDeltas(to, opKingLoc, &dr, &dc, &absdr, &absdc);
				if ((onEdge) && (absdr < 3) && (absdc < 3)) continue;
					/* We don't want to stalemate the guy while trying to get
					** our piece close to our king. */
				if ((absdr < 2) && (absdc < 2)) continue;
					/* We don't want to get our piece captured either. */
				GetDeltas(to, myKingLoc, &dr, &dc, &absdr, &absdc);
				if (minVal > (absdr + absdc)) {
					minVal = absdr + absdc;
					minMove = move;
				}
			}
		}
		return(minMove);
	}

	for (rspin = 0;; ++rspin) {		/* Rotate until opponent king is above us. */
		GetDeltas(myKingLoc, opKingLoc, &dr, &dc, &absdr, &absdc);
		if (dr > 1) break;
		RSpinPosition(&myKingLoc);
		RSpinPosition(&opKingLoc);
		RSpinPosition(&pieceLoc);
	}
		
	GetDeltas(myKingLoc, opKingLoc, &dr, &dc, &absdr, &absdc);
	hflip = false;
	if (dc < 0) hflip = true;		/* Position opponent king left of ours. */
	if (!dc) {
		GetDeltas(pieceLoc, opKingLoc, &dr, &dc, &absdr, &absdc);
		if (dc < 0) hflip = true;
	}
	if (hflip) {
		HFlipPosition(&myKingLoc);
		HFlipPosition(&opKingLoc);
		HFlipPosition(&pieceLoc);
	}

	GetRowCol(myKingLoc, &mkr, &mkc);
	GetRowCol(opKingLoc, &okr, &okc);
	GetRowCol(pieceLoc,  &pr,  &pc);

	from = pieceLoc;		/* Default that we will move the piece. */
	switch (myKingLoc - pieceLoc) {
		case -11:
			if (mkc < 2) {		/* myKing too close to left edge. */
				to = (from = myKingLoc) + 1;
				break;
			}
			to = from - 20;		/* opKing at least 2 rows above, so cut it off. */
			break;
		case -10:
			if (mkc < 2) {		/* myKing too close to left edge. */
				to = (from = myKingLoc) + 1;
				break;
			}
			if (mkc == 7) {		/* myKing on right edge, so move piece left. */
				to = from - 1;
				break;
			}
			if (mkc - okc < 2) {	/* opKing above or just 1 left, so move piece right */
				to = from + 1;		/* to prevent opKing from getting away. */
				break;
			}
			to = from - 1;		/* opKing left of us enough to cut it off on the */
			break;				/* left side of myKing. */
		case -9:
			if (mkc == okc) {	/* opKing is above myKing. */
				to = from + 2;	/* Cut the king off from moving right. */
				break;
			}
			to = from - 10;		/* opKing is 2 rows above myKing, so just slide the piece up. */
			break;
		case -1:
			if (mkr == 7) {		/* myKing on bottom edge, so move piece up. */
				to = from - 10;
				break;
			}
			to = from - 10;		/* opKing at least 2 rows above myKing, so move piece up. */
			break;
		case 1:
			if (mkc == okc) {		/* If opKing is above us, we punt. */
				if (mkr == 7) {
					to = from - 10;		/* If at bottom, move piece up 1. */
					break;
				}
				to = from + 10;			/* Move piece down 1. */
				break;
			}
			if ((mkr == 2) && (mkc == 2)) {		/* Leads to mate in 1 or 2 for rook. */
				to = (from = myKingLoc) - 10;
				break;
			}
			if ((mkr > 2) || (mkc == 2)) {
				if ((mkr + okr) & 0x01) {
					to = (from = myKingLoc) - 10;
					break;
				}
			}
			to = from - 10;
			break;
		case 9:
			if ((mkc == 1) && (!okc)) {
				to = from - 1;
				break;
			}
			if (!mkc) {			/* myKing on left edge. */
				to = (from = myKingLoc) + 1;
				break;
			}
			if (mkc == okc) {
				if ((mkr - okr) == 2) {
					to = (from = myKingLoc) + 1;
					break;
				}
				if ((mkr - okr) > 2) {
					to = (from = myKingLoc) - 10;
					break;
				}
			}
			to = from - 1;
			if (mkc - okc > 1) --to;
			break;
		case 10:
			if ((mkr == 2) && (mkc == 2)) {
				if (mkr == 2) {			/* Leads to mate in 1 or 2 for rook. */
					to = (from = myKingLoc) - 1;
					break;
				}
			}
			if ((mkr == 3) && (mkc == 2)) {
				if ((okr == 1) && (okc == 1)) {
					to = (from = myKingLoc) - 9;
					break;
				}
				if (!okr) {
					to = (from = myKingLoc) - 11;
					break;
				}
				to = from - 1;
				break;
			}
			if (mkc < 2) {		/* myKing too close to left edge. */
				to = (from = myKingLoc) + 1;
				if (mkr > 2) to -= 10;
				break;
			}
			if ((mkc - okc) == 1) {
				to = (from = myKingLoc) - 1;
				if ((mkr - okr) > 2) to -= 10;
				break;
			}
			to = from - 1;
			break;
		case 11:
			if ((mkr == 2) && (mkc == 2)) {
				to = from + 10;
				break;
			}
			if (mkc == okc) {
				to = from + 1;
				if (mkc < 7) ++to;
				break;
			}
			if (mkc > 2) {
				to = (from = myKingLoc) - 1;
				break;
			}
			to = (from = myKingLoc) - 10;
			break;
	}

	if (hflip) {
		HFlipPosition(&from);
		HFlipPosition(&to);
	}

	for (; rspin < 4; ++rspin) {		/* Rotate some more to make 4. */
		RSpinPosition(&from);
		RSpinPosition(&to);
	}
		
	for (move = 0; move < num; ++move)
		if ((from == (**moves)[move].moveFrom) && (to == (**moves)[move].moveTo)) return(move);

	return(-1);
		
}



/*****************************************************************************/



#pragma segment Chess
void	GetRowCol(short pos, short *row, short *col)
{
	*row = (pos - START_IBNDS) / 10;
	*col = pos - START_IBNDS - *row * 10;
}



/*****************************************************************************/



#pragma segment Chess
void	GetDeltas(short pos1, short pos2, short *dr, short *dc, short *absdr, short *absdc)
{
	short	r1, c1, r2, c2;

	GetRowCol(pos1, &r1, &c1);
	GetRowCol(pos2, &r2, &c2);
	*dr = r1 - r2;
	*dc = c1 - c2;

	if ((*absdr = *dr) < 0) *absdr = -*absdr;
	if ((*absdc = *dc) < 0) *absdc = -*absdc;
}



/*****************************************************************************/



#pragma segment Chess
void	RSpinPosition(short *pos)
{
	short	oldr, oldc, newr, newc;

	GetRowCol(*pos, &oldr, &oldc);
	newr = oldc;
	newc = 7 - oldr;
	*pos = START_IBNDS + 10 * newr + newc;
}



/*****************************************************************************/



#pragma segment Chess
void	HFlipPosition(short *pos)
{
	short	r, c;

	GetRowCol(*pos, &r, &c);
	*pos = START_IBNDS + 10 * r + (7 - c);
}




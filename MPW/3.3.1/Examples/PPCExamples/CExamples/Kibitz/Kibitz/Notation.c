/*
** Apple Macintosh Developer Technical Support
**
** File:        notation.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __MEMORY__
#include <Memory.h>
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



#pragma segment Window
Boolean	Algebraic(FileRecHndl frHndl, short doMoveNum, short gameIndex, StringPtr pstr)
{
	short			from, to, piece, extend, rowMatch, colMatch;
	short			i, r, c, rr, cc, rrr, ccc, fff, ttt, ppp;
	short			color, kingLoc;
	GameListHndl	gameMoves;
	MoveListHndl	legalMoves;

	gameMoves = (*frHndl)->doc.gameMoves;
	from = (**gameMoves)[doMoveNum].moveFrom;
	to   = (**gameMoves)[doMoveNum].moveTo;

	if (!from) {
		GetIndString(pstr, rGameStat, to);
		while (pstr[1] == ' ') BlockMove(pstr + 2, pstr + 1, --pstr[0]);
		return(false);
	}

	r  = from / 10;
	c  = from - 10 * r - 1;
	r -= 2;

	rr  = to / 10;
	cc  = to - 10 * rr - 1;
	rr -= 2;

	piece = (*frHndl)->doc.theBoard[from];
	if (piece < 0) piece = -piece;

	pstr[0] = 0;
	if (piece == PAWN) {
		if (c != cc) {
			pstr[++pstr[0]] = "abcdefgh"[c];
			pstr[++pstr[0]] = 'x';
		}
	}
	if (piece == KING) {
		i = c - cc;
		if (i == 2) {
			pcpy(pstr, "\pO-O-O");
			piece = EMPTY;
		}
		if (i == -2) {
			pcpy(pstr, "\pO-O");
			piece = EMPTY;
		}
	}

	if (piece > PAWN) {
		rowMatch = colMatch = extend = false;
		GenerateLegalMoves(frHndl);
		legalMoves = (*frHndl)->doc.legalMoves;
		for (i = 0; i < (*frHndl)->doc.numLegalMoves; ++i) {
			fff = (**legalMoves)[i].moveFrom;
			ttt = (**legalMoves)[i].moveTo;
			if ((ttt == to) && (fff != from)) {
				ppp = (*frHndl)->doc.theBoard[fff];
				if (ppp < 0) ppp = -ppp;
				if (ppp != piece) continue;
				rrr  = fff / 10;
				ccc  = fff - 10 * rrr - 1;
				rrr -= 2;
				extend = true;
				if (r == rrr) rowMatch = true;
				if (c == ccc) colMatch = true;
			}
		}
		if ((extend) && (!colMatch)) rowMatch |= extend;
		pstr[++pstr[0]] = "  NBRQK"[piece];
		if (rowMatch)
			pstr[++pstr[0]] = "abcdefgh"[c];
		if (colMatch)
			pstr[++pstr[0]] = "87654321"[r];
		i = (*frHndl)->doc.theBoard[to];
		if ((i) && (i != OBNDS)) pstr[++pstr[0]] = 'x';

	}
	if (piece) {
		pstr[++pstr[0]] = "abcdefgh"[cc];
		pstr[++pstr[0]] = "87654321"[rr];
	}
	if (piece == PAWN) {
		if (to = (**gameMoves)[doMoveNum].promoteTo) {
			if (to < 0) to = -to;
			pstr[++pstr[0]] = '=';
			pstr[++pstr[0]] = "  NBRQ"[to];
		}
	}

	if (doMoveNum < (*frHndl)->doc.numGameMoves) {
		RepositionBoard(frHndl, doMoveNum + 1, false);
		kingLoc = (*frHndl)->doc.king[color = WhosMove(frHndl)].kingLoc;
		if (SquareAttacked(frHndl, kingLoc, color)) pstr[++pstr[0]] = '+';
		RepositionBoard(frHndl, doMoveNum, false);
	}

	return(doMoveNum == gameIndex - 1);
}



/*****************************************************************************/



#pragma segment Window
void	MovesToOutBox(FileRecHndl frHndl, EventRecord *event)
{
	short		txtIndx, numGameMoves, gameIndex, startColor;
	short		move, moveColor, moveNum, i, selStart, selEnd, condensed;
	Boolean		needCR;
	Str255		txt;
	Handle		txtHndl;
	TEHandle	teHndl;
	WindowPtr	oldPort;

	txtHndl = NewHandle(32000);
	if (!txtHndl) return;
	txtIndx = 0;

	condensed = (event->modifiers & optionKey);

	numGameMoves = (*frHndl)->doc.numGameMoves;
	gameIndex    = (*frHndl)->doc.gameIndex;
	teHndl       = (*frHndl)->doc.message[kMessageOut];
	startColor   = (*frHndl)->doc.startColor;

	txt[0] = 0;
	needCR = false;
	for (move = gameIndex; move < numGameMoves; ++move) {
		moveColor = ((move + startColor) & 0x01);
		moveNum   = ((move + startColor) / 2 + 1);
		if ((needCR) && (!moveColor)) {
			i = (condensed) ? 32 : 13;
			(*txtHndl)[txtIndx++] = i;
			needCR = false;
		}
		if ((!moveColor) || (move == gameIndex)) {
			pcpydec(txt, i = (move / 2 + 1));
			pcat(txt, "\p)  ");
			if ((condensed) || (i > 9)) txt[0]--;
			BlockMove(txt + 1, *txtHndl + txtIndx, txt[0]);
			txtIndx += txt[0];
			needCR = true;
		}
		if ((moveColor) && (move == gameIndex)) {
			if (condensed) {
				BlockMove("...,", *txtHndl + txtIndx, 4);
				txtIndx += 4;
			}
			else {
				BlockMove("...      ", *txtHndl + txtIndx, 8);
				txtIndx += 8;
			}
			needCR = true;
		}
		RepositionBoard(frHndl, move, false);
		Algebraic(frHndl, move, 0, txt);
		if (move < numGameMoves - 1) {
			if (condensed) {
				if (!moveColor) txt[++(txt[0])] = ',';
			}
			else {
				if (!moveColor) pcat(txt, "\p        ");
				if (txt[0] > 8) txt[0] = 8;
			}
		}
		BlockMove(txt + 1, *txtHndl + txtIndx, txt[0]);
		txtIndx += txt[0];
		needCR = true;
	}

	LockHandleHigh(txtHndl);
	oldPort = SetFilePort(frHndl);

	CTENewUndo(CTEViewFromTE(teHndl), true);
	TEDelete(teHndl);
	selStart = (*teHndl)->selStart;
	TEInsert(*txtHndl, txtIndx, teHndl);
	selEnd = (*teHndl)->selStart;
	TESetSelect(selStart, selEnd, teHndl);
	TESelView(teHndl);
	CTEAdjustTEBottom(teHndl);
	CTEAdjustScrollValues(teHndl);
	(*frHndl)->fileState.docDirty = true;

	SetPort(oldPort);
	DisposHandle(txtHndl);

	RepositionBoard(frHndl, gameIndex, false);
}



/*****************************************************************************/



#pragma segment Window
void	MovesFromText(FileRecHndl frHndl, Handle txtHndl, short txtLen,
					  short beg, short end, Boolean slideMoves)
{
	WindowPtr		oldPort;
	short			gameIndex, txtIndx, commentCount;
	short			numUsed, numLglMoves, lastChar, c0, c1, i;
	short			from, to, fromRow, fromCol, promoteTo, piece, f, t, r, c;
	long			tick;
	char			*cptr;
	MoveListHndl	lglMoves;
	static char		goodFirstFromChar[] = "Oo01abcdefghPNBRQK";

	oldPort  = SetFilePort(frHndl);
	if (end == beg) end = txtLen;

	GenerateLegalMoves(frHndl);
	gameIndex = (*frHndl)->doc.gameIndex;
	txtIndx = beg;
	commentCount = 0;

	tick = TickCount();

	for (;; txtIndx += numUsed) {

		if (!commentCount) {
			numLglMoves = (*frHndl)->doc.numLegalMoves;
			lglMoves    = (*frHndl)->doc.legalMoves;
			if (!numLglMoves) break;
				/* Can't accept any moves, as there are no legal moves. */
		}

		lastChar = end - txtIndx - 1;
		if (lastChar < 1) break;
			/* An algebraic move is at least 2 characters. */

		cptr = *txtHndl + txtIndx;
		c0 = cptr[0];
		numUsed = 1;		/* Always use at least 1 character per pass. */

		if (c0 == '[') {
			++commentCount;
			continue;
		}

		if (c0 == ']') {
			if (commentCount) --commentCount;
			continue;
		}

		if (commentCount) continue;

		for (i = 0; goodFirstFromChar[i]; ++i)
			if (c0 == goodFirstFromChar[i]) break;
		if (!goodFirstFromChar[i]) continue;
			/* Not good first character, so check next char. */

		fromRow = fromCol = -1;
		from = to = 0;
			/* From may be square or piece. */
			/* To will be square. */
			/* If to stays 0, then to = from, and from = PAWN.  More on this later. */

		for (;;) {		/* Used to break from for jump purposes. */

			if (i < 3) {		/* First character is castling character... */
				if (lastChar < 2) break;
					/* Not enough characters for kside castling. */
				if (cptr[numUsed] != '-') break;		/* Isn't a castle. */
				if (cptr[numUsed + 1] != '1') {			/* Isn't a black-wins notation. */
					if (cptr[++numUsed] != c0) break;	/* Isn't a castle. */
					from = (WhosMove(frHndl)) ? 25 : 95;
					to   = from + 2;
					if (lastChar < 4) {
						++numUsed;
						break;
					}		/* Not enough characters for qside castling, so try kside. */
					if (cptr[++numUsed] != '-') break;		/* Isn't a castle. */
					if (cptr[++numUsed] != c0) break;		/* Isn't a castle. */
					to -= 4;
					++numUsed;
					break;		/* Try qside castle. */
				}
			}

			i -= 2;
			if (i < 2) {	/* May be end-of-game notation. (1-0, 1/2, 0-1) */
				if (lastChar < 2) break;
					/* Not enough characters for end-of-game notation. */
				c1 = cptr[numUsed];
				if (c1 == '-') {
					if (cptr[numUsed + 1] == ('1' - i)) to = kWhiteResigns + i;
				}
				else if (c1 == '/') {
					if (cptr[numUsed + 1] == '2') to = kDrawGame;
				}
				if (to) EndTheGame(frHndl, to);
				to = 0;
				break;		/* Done processing this character, either way. */
			}

			i -= 2;
			if (i < 8) {		/* It is probably a pawn move.  The form is one of */
								/* the following: e4, dxe4, d3xe4, d3e4, d3-e4.    */
								/* Due to this, it can't be decided yet as to      */
								/* whether we are looking at the from or the to    */
								/* location.                                       */

				from = PAWN;
				fromCol = i;	/* Might end up the toCol, so keep this in mind. */
				c1 = cptr[numUsed];
				if ((c1 >= '1') && (c1 <= '8')) {
					fromRow = 7 - (c1 - '1');	/* Might end up the toRow. */
					if (++numUsed > lastChar) break;
					c1 = cptr[numUsed];
				}
				if ((c1 == 'x') || (c1 == 'X') || (c1 == '-')) {
					if (++numUsed > lastChar) break;
					c0 = cptr[numUsed];
					if ((c0 < 'a') || (c0 > 'h')) break;
					if (++numUsed > lastChar) break;
					c1 = cptr[numUsed];
					if ((c1 >= '1') && (c1 <= '8')) {
						to = 10 * (7 - (c1 - '1')) + (c0 - 'a') + START_IBNDS;
						from = PAWN;		/* Assume it is a pawn move. */
						if ((fromRow != -1) && (fromCol != -1))
							from = 10 * fromRow + fromCol + START_IBNDS;
								/* Move is of form d3-e4, so it doesn't have to be a pawn. */
						++numUsed;
						break;
					}
				}
				else {		
					if (fromRow != -1) {			/* Of the form e4. */
						if ((c1 < 'a') || (c1 > 'h')) {
							from = PAWN;
							to = 10 * fromRow + fromCol + START_IBNDS;
							fromRow = fromCol = -1;		/* No hint of where from. */
						}
						else {
							if (++numUsed > lastChar) break;
							c0 = c1;
							c1 = cptr[numUsed];
							if ((c1 >= '1') && (c1 <= '8')) {
								to = 10 * (7 - (c1 - '1')) + (c0 - 'a') + START_IBNDS;
								from = PAWN;		/* Assume it is a pawn move. */
								if ((fromRow != -1) && (fromCol != -1))
									from = 10 * fromRow + fromCol + START_IBNDS;
										/* Move is of form d3e4, so it doesn't have to be a pawn. */
								++numUsed;
								break;
							}
						}
					}
					break;
				}
			}

			else from = i - 7;		/* Remember which kind of piece. */

			c0 = cptr[numUsed];

			if (c0 == '(') {	/* Parens are optional -- just skip them. */
				if (++numUsed > lastChar) break;
				c0 = cptr[numUsed];
			}

			if ((c0 >= 'a') && (c0 <= 'h')) {
				fromCol = c0 - 'a';
				if (++numUsed > lastChar) break;
				c0 = cptr[numUsed];
			}
			if ((c0 >= 'a') && (c0 <= 'h')) {
				if (++numUsed > lastChar) break;
				c1 = cptr[numUsed];
				if ((c1 >= '1') && (c1 <= '8')) {
					to = 10 * (7 - (c1 - '1')) + (c0 - 'a') + START_IBNDS;
					++numUsed;
				}
				break;
			}
			if ((c0 >= '1') && (c0 <= '8')) {
				fromRow = 7 - (c0 - '1');
				if (++numUsed > lastChar) break;
				c0 = cptr[numUsed];
			}

			if (c0 == ')') {	/* Parens are optional -- just skip them. */
				if (++numUsed > lastChar) break;
				c0 = cptr[numUsed];
			}

			if ((c0 == 'x') || (c0 == 'X') || (c0 == '-')) {
				if (++numUsed > lastChar) break;
				c0 = cptr[numUsed];
			}

			if ((c0 >= 'a') && (c0 <= 'h')) {
				if (++numUsed > lastChar) break;
				c1 = cptr[numUsed];
				if ((c1 >= '1') && (c1 <= '8')) {
					to = 10 * (7 - (c1 - '1')) + (c0 - 'a') + START_IBNDS;
					++numUsed;
				}
				break;
			}
			else {
				if ((fromRow != -1) && (fromCol != -1)) {
					to = 10 * fromRow + fromCol + START_IBNDS;
					fromRow = fromCol = -1;		/* No hint of where from. */
				}
				break;
			}

			break;
		}

		if (!to) {
			if ((fromRow != -1) && (fromCol != -1)) {
				to = 10 * fromRow + fromCol + START_IBNDS;
				fromRow = fromCol = -1;
			}
		}

		promoteTo = QUEEN;
		if (to) {
			if (numUsed < lastChar) {
				if (cptr[numUsed++] == '=') {
					if (numUsed < lastChar) {
						c1 = cptr[numUsed++];
						if (c1 == 'N') promoteTo = KNIGHT;
						if (c1 == 'B') promoteTo = BISHOP;
						if (c1 == 'R') promoteTo = ROOK;
					}
				}
			}
		}

		i = numLglMoves;
		for (i = 0; i < numLglMoves; ++i) {
			f = (**lglMoves)[i].moveFrom;
			t = (**lglMoves)[i].moveTo;
			if (to != t) continue;
			if (from >= START_IBNDS) {
				if (from == f) break;
				continue;
			}
			piece = (*frHndl)->doc.theBoard[f];
			if (piece < 0) piece = -piece;
			if (piece == from) {
				r = (f - START_IBNDS) / 10;
				c = f - START_IBNDS - 10 * r;
				if (fromRow == -1) r = -1;
				if (fromCol == -1) c = -1;
				if ((fromRow == r) && (fromCol == c)) {
					from = f;
					break;
				}
			}
		}
		if (i < numLglMoves) {
			if (slideMoves) SlideThePiece(frHndl, from, to);
			MakeMove(frHndl, from, to, promoteTo);
			GenerateLegalMoves(frHndl);
			ImageDocument(frHndl, true);
			AdjustGameSlider(frHndl);
			UpdateGameStatus(frHndl);
			if (tick + 30 < TickCount()) {		/* Send max 1 AppleEvent per 1/2 sec. */
				tick = TickCount();
				if ((*frHndl)->doc.twoPlayer) SendGame(frHndl, kScrolling, nil);
			}
		}
		else {
			if ((!from) && (!to)) {
				if (numUsed > 1) --numUsed;
				for (;;) {
					c0 = cptr[numUsed++];
					if (numUsed >= lastChar) break;
					if ((c0 >= 'A') && (c0 <= 'Z')) continue;
					if ((c0 >= 'a') && (c0 <= 'z')) continue;
					if ((c0 >= '0') && (c0 <= '9')) continue;
					break;
				}
			}
		}
	}

	if ((*frHndl)->doc.twoPlayer) SendGame(frHndl, kResync, nil);

}




/*****************************************************************************/



#pragma segment Window
void	MakeVerbose(StringPtr pstr)
{
	Str63				result;
	Str32				piece, from, verb, to, epi;
	short				i;
	static StringPtr	cols[] = {"\pA,", "\pbee,", "\psea,", "\pdee,",
							  "\pe,", "\pef,", "\pgee,", "\pH,"};

	if (!pstr[0]) return;

	result[0] = from[0] = to[0] = epi[0] = 0;

	pcpy(piece, "\ppawn ");
	pcpy(verb,  "\ptoo, ");

	if (pstr[i = 1] < 'Z') {
		if (pstr[i] == 'O') {
			++i;
			if (pstr[0] < 3) return;
			pcpy(result, "\pcastle ");
			if (pstr[0] < 4) {
				pcat(result, "\p king side");
				pcpy(pstr, result);
				return;
			}
			if (pstr[4] == '+') {
				pcat(result, "\p king side, check");
				pcpy(pstr, result);
				return;
			}
			pcat(result, "\p kweenn side");
			if (pstr[0] >= 6) {
				if (pstr[6] == '+') pcat(result, "\p, check");
				pcpy(pstr, result);
			}
			pcpy(pstr, result);
			return;
		}

		if (pstr[i] == 'N') pcpy(piece, "\pknight ");
		if (pstr[i] == 'B') pcpy(piece, "\pbishop ");
		if (pstr[i] == 'R') pcpy(piece, "\prook ");
		if (pstr[i] == 'Q') pcpy(piece, "\pkweenn ");
		if (pstr[i] == 'K') pcpy(piece, "\pking ");
		++i;
	}

	if (i > pstr[0]) return;

	if ((pstr[i] >= '1') && (pstr[i] <= '8')) {
		if (pstr[0] > (i + 1)) {
			pcpy(from, "\pat, ");
			pcatchr(from, pstr[i++], 1);
			pcat(from, "\p, ");
		}
	}

	if ((pstr[i] >= 'a') && (pstr[i] <= 'h')) {
		if (pstr[0] > (i + 1)) {
			if ((pstr[i + 1] < '1') || (pstr[i + 1] > '8')) {
				pcpy(from, "\pat, ");
				pcat(from, cols[pstr[i++] - 'a']);
				pcatchr(from, ' ', 1);
			}
		}
	}

	if (i > pstr[0]) return;

	if (pstr[i] == 'x') {
		pcpy(verb, "\ptakes, ");
		++i;
	}

	if (i > pstr[0]) return;

	if ((pstr[i] >= 'a') && (pstr[i] <= 'h')) {
		pcat(to, cols[pstr[i++] - 'a']);
		pcatchr(to, ' ', 1);
	}

	if (i > pstr[0]) return;

	if ((pstr[i] >= '1') && (pstr[i] <= '8')) {
		pcatchr(to, pstr[i++], 1);
		pcatchr(to, ' ', 1);
	}

	if (i <= pstr[0]) {
		if (pstr[i] == '=') {
			pcat(epi, "\p, promote too ");
			if (++i > pstr[0]) return;
			if (pstr[i] == 'N') pcat(epi, "\pknight ");
			if (pstr[i] == 'B') pcat(epi, "\pbishop ");
			if (pstr[i] == 'R') pcat(epi, "\prook ");
			if (pstr[i] == 'Q') pcat(epi, "\pkweenn ");
			++i;
		}
	}

	if (i <= pstr[0]) {
		if (pstr[i] == '+')
			pcat(epi, "\p, check");
	}

	pcpy(pstr, piece);
	pcat(pstr, from);
	pcat(pstr, verb);
	pcat(pstr, to);
	pcat(pstr, epi);
}



/*****************************************************************************/



#pragma segment Window
void	SayTheMove(FileRecHndl frHndl)
{
	Handle	txt;
	Str255	pstr;
	short	i;
	Boolean	move;

	if (!(*frHndl)->doc.doSpeech) return;

	MakeMove(frHndl, -1, 0, 0);
	i = (*frHndl)->doc.gameIndex;
	move = Algebraic(frHndl, i, i + 1, pstr);
	MakeMove(frHndl, 1, 0, 0);
	if (move) MakeVerbose(pstr);

	switch (i = GameStatus(frHndl)) {
		case kYouWin:
		case kYouLose:
			pcat(pstr, "\p mate");
			break;
	}

	txt = NewHandle(pstr[0]);
	BlockMove(pstr + 1, *txt, pstr[0]);
	SayText(nil, txt, (*frHndl)->doc.theVoice);
	DisposeHandle(txt);
}




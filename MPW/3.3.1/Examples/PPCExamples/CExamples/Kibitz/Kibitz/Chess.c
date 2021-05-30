/*
** Apple Macintosh Developer Technical Support
**
** File:	    chess.c
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

#ifndef __TEXTEDITCONTROL__
#include <TextEditControl.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif

#ifndef __STDIO__
#include <StdIO.h>
#endif

#ifndef __STRING__
#include <String.h>
#endif

#ifndef THINK_C
#ifndef __STRINGS__
#include <Strings.h>
#endif
#endif

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/



extern Boolean	gComputerResigns;

short	gPieceLoc;

#define kLastNode         6
#define kComputerResigns -9999

static GameListHndl		gGenMovesHndl;
static unsigned long	idleTick;
static MoveListHndl		gNodeHndl[kLastNode + 1];

static short	gNumPieces, gPosReps;
static long	gTreeValue, gWhiteTotal, gBlackTotal;
static long	gTreePieceValues[13] = {
	-0x40000000L, -0x00090000L, -0x00050000L, -0x00030000L, -0x00030000L, -0x00010000L,
	 0x00000000L,
	 0x00010000L,  0x00030000L,  0x00030000L,  0x00050000L,  0x00090000L,  0x40000000L,
};

static short	distance[10] = {0, 1, 1, 7, 7, 7, 1};
	/* How far a piece can move.						*/
	/* The double-pawn-push is handled as an exception. */
	/* Castling is handled as an exception.				*/

static short	direction[10][9] = {
	  0,   0,   0,   0,   0,   0,   0,   0,   0,
	 10,   9,  11,   0,   0,   0,   0,   0,   0,	/* Pawn moves.	 */
	-21, -19, -12,  -8,   8,  12,  19,  21,   0,	/* Knight moves. */
	-11,  -9,   9,  11,   0,   0,   0,   0,   0,	/* Bishop moves. */
	-10,  -1,   1,  10,   0,   0,   0,   0,   0,	/* Rook moves.	 */
	-11,  -9,   9,  11, -10,  -1,   1,  10,   0,	/* Queen moves.	 */
	-11,  -9,   9,  11, -10,  -1,   1,  10,   0,	/* King moves.	 */
};

static short	gPieceColor[13] = {WHITE, WHITE, WHITE, WHITE, WHITE, WHITE,
								   EMPTY,
								   BLACK, BLACK, BLACK, BLACK, BLACK, BLACK};

static short	gPieceKind[13]  = {KING, QUEEN, ROOK, BISHOP, KNIGHT, PAWN,
								   EMPTY,
								   PAWN, KNIGHT, BISHOP, ROOK, QUEEN, KING};



/*****************************************************************************/



TheDoc	newDocData
 = {
	kVersion,		/* File format version.							 */

	false,			/* Flag indicating print record is current.		 */
	{				/* Space for print record.						 */
		0,
		{0, 0, 0,{0, 0, 0, 0},},
		{0, 0, 0, 0},
		{0, 0, 0, 0, 0},
		{0, 0, 0,{0, 0, 0, 0},},
		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
		{0, 0, 0, 0, 0, nil, nil, 0, 0, 0},
		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
	},

	OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS,
	OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS,
	OBNDS,  BR,    BN,    BB,    BQ,    BK,    BB,    BN,    BR,   OBNDS,
	OBNDS,  BP,    BP,    BP,    BP,    BP,    BP,    BP,    BP,   OBNDS,
	OBNDS,   0,     0,     0,     0,     0,     0,     0,     0,   OBNDS,
	OBNDS,   0,     0,     0,     0,     0,     0,     0,     0,   OBNDS,
	OBNDS,   0,     0,     0,     0,     0,     0,     0,     0,   OBNDS,
	OBNDS,   0,     0,     0,     0,     0,     0,     0,     0,   OBNDS,
	OBNDS,  WP,    WP,    WP,    WP,    WP,    WP,    WP,    WP,   OBNDS,
	OBNDS,  WR,    WN,    WB,    WQ,    WK,    WB,    WN,    WR,   OBNDS,
	OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS,
	OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS, OBNDS,
	{
		WKPOS, 0,	/* White king position, king-moved count.		 */
		0,			/* White queen-rook-moved count.				 */
		0,			/* White king-rook-moved count.					 */
		BKPOS, 0,	/* Black king position, king-moved count.		 */
		0,			/* Black queen-rook-moved count.				 */
		0			/* Black king-rook-moved count.					 */
	},
	0,				/* En-passant opportunity location.				 */
	0,				/* En-passant opportunity pawn-to-take location. */
	0,				/* Arranged en-passant opportunity loc.			 */
	0,				/* Arranged en-passant opp. pawn-to-take loc.	 */
	0,				/* Number of legal moves in move list.			 */
	0,				/* Index into record of game.					 */
	0,				/* Number of moves in game.						 */
	0,				/* My color (0 = white).						 */
	0,				/* True if black started game.					 */
	0,				/* True if in arrange-board mode.				 */
	WP,				/* Piece hilited in arrange-board palette.		 */
	18000L,			/* 5 minute default time for white.				 */
	18000L,			/* 5 minute default time for black.				 */
	-1L,			/* Ticks remaining for white. (-1, no clock)	 */
	-1L,			/* Ticks remaining for black. (-1, no clock)	 */
	false,			/* Display board normal (not inverted.)			 */
	0,				/* Above info is saved to disk.					 */

	"\0",			/* Space for opponent zone.						 */
	"\0",			/* Space for opponent machine.					 */
	"\0",			/* Space for opponent kibitz full path.			 */
	"\0",			/* Space for opponent kibitz filename.			 */
	false,			/* Boolean for just board window.				 */
	false,			/* Boolean for document is template.			 */
	false,			/* Document saved while computer moves white.	 */
	false,			/* Document saved while computer moves black.	 */
	0,				/* Above is new version info saved to disk.		 */

	false,			/* Flag indicating existence of opponent.		 */
	0L,				/* ID assigned by me for this game.				 */
	0L,				/* ID assigned by opponent for this game.		 */
	0,				/* Reason for sending the game.					 */
	0,				/* State of the draw button. 					 */
	{
		0L,			/* AEAddressDesc of opponent.					 */
		nil
	},
	0,				/* Above is send game info.						 */

	0,				/* State for receiving AppleEvents.				 */
	false,			/* Flag indicating if we originated game.		 */
	-1L,			/* Ticks remaining displayed for white.			 */
	-1L,			/* Ticks remaining displayed for black.			 */
	-1L,			/* Ticks for freeze clock for white.			 */
	-1L,			/* Ticks for freeze clock for black.			 */
	0L,				/* Reference tick for timer.					 */
	0L,				/* Tick when computer moved last.				 */
	0L,				/* Tick when received last info from opponent.	 */
	false,			/* Flag indicating computer moves white pieces.	 */
	false,			/* Flag indicating computer moves black pieces.	 */
	"\0",			/* Space for opponent name.						 */
	"\0",			/* Space for opponent zone.						 */
	"\0",			/* Space for opponent machine.					 */
	0,				/* Time that last move/message received.		 */
	0,				/* Above info is for one machine only.			 */

	false,			/* Flag indicating color change has been posted. */
	0,				/* New color from config.						 */
	false,			/* Flag indicating time change has been posted.	 */
	-1L,			/* New white time from config.					 */
	-1L,			/* New black time from config.					 */
	0,				/* Above info is config setting which will		 */
					/* not be applied until a NULL event.			 */

	nil,			/* Handle to legal move list.					 */
	nil,			/* Handle to game record.						 */
	nil,			/* Handle to incoming message.					 */
	nil,			/* Handle to outgoing message.					 */
	nil,			/* Handle to recorded sound, if any.			 */
	false,			/* Boolean stating if we say stuff.				 */
	{
		0L,			/* Default voice.								 */
		0L
	},
	nil,			/* Handle to send button control.				 */
	nil,			/* Handle to move notify control.				 */
	nil,			/* Handle to message notify control.			 */
	nil,			/* Handle to game-slider control.				 */
	nil,			/* Handle to white-starts radio button.			 */
	nil,			/* Handle to black-starts radio button.			 */
	nil,			/* Handle to resign button.						 */
	nil,			/* Handle to draw button.						 */
	nil,			/* Handle to record sound button.				 */
	nil,			/* Handle to send sound button.					 */
	0,				/* Above info is reference to controls.			 */
}
;

/*****************************************************************************/



#pragma segment Chess
OSErr	InitLogic(void)
{
	short	i;

	if (!(gGenMovesHndl = (GameListHndl)NewHandle(0))) return(memFullErr);

	for (i = 0; i <= kLastNode; ++i)
		if (!(gNodeHndl[i] = (MoveListHndl)NewHandle(0))) return(memFullErr);

	return(noErr);
}



/*****************************************************************************/



#pragma segment Chess
void	NewGame(FileRecHndl game)
{
	TheDocPtr	docPtr;

	docPtr = &(*game)->doc;

	newDocData.legalMoves = docPtr->legalMoves;
	newDocData.gameMoves  = docPtr->gameMoves;

	*docPtr = newDocData;

	newDocData.legalMoves = nil;
	newDocData.gameMoves  = nil;
}



/*****************************************************************************/



#pragma segment Chess
void	GenerateLegalMoves(FileRecHndl game)
{
	short			gameIndex, numGameMoves, square, piece;
	short			color, pieceColor;
	short			row, dirNum, dir, dist;
	short			s, d, dest, destColor, epLoc;
	long			size;
	Boolean			docDirty, check;
	GameListHndl	gameMoves;

	gameIndex    = (*game)->doc.gameIndex;
	gameMoves    = (*game)->doc.gameMoves;
	numGameMoves = (*game)->doc.numGameMoves;
	docDirty     = (*game)->fileState.docDirty;

	(*game)->doc.numLegalMoves = 0;			/* Start the list over. */

	if ((gameIndex) && (gameIndex == numGameMoves))
		if (!(**gameMoves)[gameIndex - 1].moveFrom) return;
			/* Resignation or agreed-upon draw recorded.
			** Game over, so no legal moves. */

	SetHandleSize((Handle)gGenMovesHndl, size = GetHandleSize((Handle)gameMoves));
	BlockMove(*(Handle)gameMoves, *(Handle)gGenMovesHndl, size);
	(*game)->doc.gameMoves = gGenMovesHndl;			/* Protect the game moves list. */

	color = WhosMove(game);						/* Who's move it is. */

	for (square = START_IBNDS; square < END_IBNDS; ++square) {
		/* Scan for pieces of correct color. */

		if ((piece = (*game)->doc.theBoard[square]) == EMPTY) continue;
			/* Empty square, so next square, please. */

		if (piece == OBNDS) continue;
			/* Out of bounds. */

		pieceColor = BLACK;
		if (piece < 0) {
			pieceColor = WHITE;
			piece = -piece;
		}

		if (pieceColor != color) continue;
			/* Not our piece. */

		row = square / 10;

		for (dirNum = 0; dir = direction[piece][dirNum]; ++dirNum) {
			/* The direction we will move a piece.  This is correct in all
			** cases except for white pawns.  Without an adjustment, they
			** would move in the direction of black pawns, i.e., backwards.
			*/

			dist = distance[piece];
				/* The distance a piece can move, in all cases except a
				** double-pawn-push and castling.
				*/

			if (piece == PAWN) {
				if (color == WHITE) dir = -dir;
					/* White pawns will now move forwards. */

				if ((!dirNum) && ((row == 3) || (row == 8))) dist = 2;
					/* In the case of a pawn, the first direction we check
					** is forwards, so if dirNum is 0, we are pushing pawns.
					**
					** Allow double-pawn-push if pawn is on correct row.  We don't
					** have to worry about which color the pawn is if the pawn
					** has advanced to the other double-push row.  It will
					** double-push itself out of bounds.
					*/
			}

			for (s = square, d = 1; d <= dist; ++d) {

				s += dir;
				dest = (*game)->doc.theBoard[s];
				if (dest == OBNDS) break;	/* Can't go this direction anymore. */

				destColor = BLACK;
				if (dest < 0) {
					destColor = WHITE;
					dest = -dest;
				}

				if ((dest) && (destColor == color)) break;
					/* Ran into our own piece, so can't go this direction anymore. */

				if (dest == KING) break;
					/* Never allow the king to be taken. */

				if (piece == PAWN) {
					if (!dirNum) {				/* If pawn push... */
						if (dest) break;		/* Can't take on a pawn-push. */
					}
					else {
						if (dest == EMPTY) {	/* If possible en-passant... */
							if ((*game)->doc.enPasMove != s) break;
								/* Not en-passant pawn capture. */
							epLoc = (*game)->doc.enPasPawnLoc;
							dest  = (*game)->doc.theBoard[epLoc];
							destColor = BLACK;
							if (dest < 0) {
								destColor = WHITE;
								dest = -dest;
							}
							if (destColor == color) break;
								/* We can't en-passant our own piece. */
							if (dest != PAWN) break;
								/* We can only en-passant pawns. */
						}
					}
				}

				MakeMove(game, square, s, QUEEN);
				check = SquareAttacked(game,
					(*game)->doc.king[color].kingLoc, color);
				UnmakeMove(game);
				if (!check) AddLegalMove(game, square, s);
					/* Move didn't put (or leave) king in check, so it is a
					** valid move.  Since it is valid, record it. */

				if (dest) break;	/* Once we hit a piece, we are
									** done in this direction. */
			}
		}
	}

	square = (*game)->doc.king[color].kingLoc;
	if (CastleOkay(game, QSIDE)) AddLegalMove(game, square, square - 2);
	if (CastleOkay(game, KSIDE)) AddLegalMove(game, square, square + 2);
		/* If castling possible, add it to move list. */

	(*game)->doc.gameMoves      = gameMoves;
	(*game)->doc.numGameMoves   = numGameMoves;
	(*game)->fileState.docDirty = docDirty;
		/* Restore things the way we were.  We are done with MakeMove services. */
}



/*****************************************************************************/



#pragma segment Chess
void	AddLegalMove(FileRecHndl game, short from, short to)
{
	MoveListHndl	lglMoves;
	short			numLglMoves;
	long			newHndlSize, oldHndlSize;

	numLglMoves = (*game)->doc.numLegalMoves;
	lglMoves    = (*game)->doc.legalMoves;

	oldHndlSize = GetHandleSize((Handle)lglMoves);
	newHndlSize = ((numLglMoves | 0x3F) + 1) * sizeof(MoveElement);
	if (newHndlSize != oldHndlSize)
		SetHandleSize((Handle)lglMoves, newHndlSize);

	(**lglMoves)[numLglMoves].moveFrom = from;
	(**lglMoves)[numLglMoves].moveTo   = to;
	(**lglMoves)[numLglMoves].value    = 0;

	++(*game)->doc.numLegalMoves;
}



/*****************************************************************************/



#pragma segment Chess
Boolean	CastleOkay(FileRecHndl game, short castleSide)
{
	short	color;
	short	castleDir, kingLoc, rookLoc;
	short	i, j, piece, pieceColor;

	color = WhosMove(game);			/* Who's move it is. */

	if ((*game)->doc.king[color].kingMoves) return(false);
		/* Can't castle.  King has already moved. */

	rookLoc = (kingLoc = (*game)->doc.king[color].kingLoc) + 3;
	if ((castleDir = castleSide) == QSIDE) {
		rookLoc -= 7;
		--castleDir;
	}

	for (i = kingLoc, j = 3; j; i += castleDir, --j)
		if (SquareAttacked(game, i, color)) return(false);
			/* Can't castle out of, through, or into check. */

	if ((*game)->doc.king[color].rookMoves[castleSide]) return(false);
		/* Rook trying to castle with has already moved,
		** or has been taken.
		*/

	piece = (*game)->doc.theBoard[rookLoc];
	pieceColor = BLACK;
	if (piece < 0) {
		pieceColor = WHITE;
		piece = -piece;
	}
	if (color != pieceColor) return(false);
	if (piece != ROOK)		 return(false);
		/* These deviant conditions can occur if user arranged the board. */

	/* So far, everything is cool.  The only remaining possible problem is
	** that there is a piece (or more) between the king and the rook. */

	while (kingLoc += castleDir, kingLoc != rookLoc)
		if ((*game)->doc.theBoard[kingLoc]) return(false);
			/* There is a piece in the way, so we can't castle. */

	return(true);		/* The castling move is okay. */
}



/*****************************************************************************/



#pragma segment Chess
void	MakeMove(FileRecHndl game, short moveFrom, short moveTo, short promoteTo)
{
	GameListHndl	gameMoves;
	long			newHndlSize, oldHndlSize;
	short			gameIndex, numGameMoves, color, rank, i;
	short			pieceMoved, pieceCaptured, pieceCapturedFrom;
	short			absPieceMoved, delta, middle, oldRookLoc;
	Boolean			modifyGame;

	if (moveFrom == -1) {
		UnmakeMove(game);
		return;
	}

	gameIndex    = (*game)->doc.gameIndex;
	numGameMoves = (*game)->doc.numGameMoves;
	gameMoves    = (*game)->doc.gameMoves;
	color        = WhosMove(game);

	i = (gameIndex > numGameMoves) ? gameIndex : numGameMoves;
	newHndlSize = ((i | 0x3F) + 1) * sizeof(GameElement);
	oldHndlSize = GetHandleSize((Handle)gameMoves);
	if (newHndlSize != oldHndlSize)
		SetHandleSize((Handle)gameMoves, newHndlSize);

	modifyGame = true;

	if (moveFrom == 1) {
		if (gameIndex >= numGameMoves) return;
			/* Already positioned at the end of the game. */
		moveFrom   = (**gameMoves)[gameIndex].moveFrom;
		moveTo     = (**gameMoves)[gameIndex].moveTo;
		promoteTo  = (**gameMoves)[gameIndex].promoteTo;
		modifyGame = false;
	}

	if (!moveFrom) {		/* Draw agreed upon, or player resigned. */
		if (gameIndex)
			if (!(**gameMoves)[gameIndex - 1].moveFrom) --gameIndex;
				/* In case there is a race condition, only allow one game-ending
				** "move" to occur. */
		(**gameMoves)[gameIndex].moveFrom          = 0;
		(**gameMoves)[gameIndex].moveTo            = moveTo;
		(**gameMoves)[gameIndex].pieceCaptured     = 0;
		(**gameMoves)[gameIndex].pieceCapturedFrom = 0;
		(**gameMoves)[gameIndex].promoteTo         = 0;
		(*game)->doc.gameIndex = ++gameIndex;
		(*game)->doc.numGameMoves   = gameIndex;
		(*game)->fileState.docDirty = true;
		(*game)->doc.resync = kResync;
		return;
	}

	pieceMoved        = (*game)->doc.theBoard[moveFrom];
	pieceCaptured     = (*game)->doc.theBoard[moveTo];
	pieceCapturedFrom = moveTo;

	absPieceMoved = (pieceMoved < 0) ? -pieceMoved : pieceMoved;

	if (absPieceMoved == PAWN) {

		rank = moveTo / 10;
		if ((rank == 2) || (rank == 9)) {
			if (promoteTo < 0) promoteTo = -promoteTo;
			pieceMoved *= promoteTo;
			promoteTo = pieceMoved;
		}
		else promoteTo = 0;

		if (moveTo == (*game)->doc.enPasMove) {
			pieceCaptured     = -pieceMoved;
			pieceCapturedFrom = (*game)->doc.enPasPawnLoc;
		}		/* If pawn move is onto en-passant move square, then the
				** capture is from a square other than moveTo.
				*/
	}
	else promoteTo = 0;

	(**gameMoves)[gameIndex].moveFrom          = moveFrom;
	(**gameMoves)[gameIndex].moveTo            = moveTo;
	(**gameMoves)[gameIndex].pieceCaptured     = pieceCaptured;
	(**gameMoves)[gameIndex].pieceCapturedFrom = pieceCapturedFrom;
	(**gameMoves)[gameIndex].promoteTo         = promoteTo;
	(*game)->doc.gameIndex = ++gameIndex;

	if (modifyGame) {
		(*game)->doc.numGameMoves   = gameIndex;
		(*game)->fileState.docDirty = true;
	}

	/* The move has now been recorded in the move list.  Now make the move. */

	(*game)->doc.theBoard[pieceCapturedFrom] = 0;
	(*game)->doc.theBoard[moveTo]            = pieceMoved;
	(*game)->doc.theBoard[moveFrom]          = 0;
		/* The move is now made, except for the rook if castling. */

	delta  = moveTo - moveFrom;
	middle = (moveTo + moveFrom) / 2;

	if (absPieceMoved == KING) {
		oldRookLoc = 0;
		if (delta == -2) oldRookLoc = moveFrom - 4;
		if (delta == 2)  oldRookLoc = moveFrom + 3;
		if (oldRookLoc) {
			(*game)->doc.theBoard[middle] = (*game)->doc.theBoard[oldRookLoc];
			(*game)->doc.theBoard[oldRookLoc] = 0;
		}
	}		/* Castling (and therefore move) now complete. */


	/* All that remains is some information updating for castling, king
	** position, and en-passant. */

	if (absPieceMoved == KING) {
		(*game)->doc.king[color].kingLoc = moveTo;
		++(*game)->doc.king[color].kingMoves;
	}

	if ((moveFrom==21) || (moveTo==21)) ++(*game)->doc.king[BLACK].rookMoves[QSIDE];
	if ((moveFrom==28) || (moveTo==28)) ++(*game)->doc.king[BLACK].rookMoves[KSIDE];
	if ((moveFrom==91) || (moveTo==91)) ++(*game)->doc.king[WHITE].rookMoves[QSIDE];
	if ((moveFrom==98) || (moveTo==98)) ++(*game)->doc.king[WHITE].rookMoves[KSIDE];
		/* This accounts for all rook moves/captures, other than castling.
		** This is necessary to keep track of rook moves/captures to determine
		** if castling is allowed.  Rook moves when castling don't have to be
		** accounted for, since the king move in the castle will prevent
		** any more castling.
		*/

	/* If the move was a double-pawn-push, then we have some en-passant
	** information to record.  Otherwise, we need to zero-out these values. */

	if (absPieceMoved == PAWN) {

		if ((delta != -20) && (delta != 20))
			middle = moveTo = 0;
				/* If not a double-pawn-push, then record 0's for the
				** en-passant information.  This will prevent en-passant
				** moves from being generated. */

	}
	else middle = moveTo = 0;

	(*game)->doc.enPasMove    = middle;
	(*game)->doc.enPasPawnLoc = moveTo;
		/* Record the en-passant information.  These values are
		** non-zero if a pawn was double-pushed. */

}



/*****************************************************************************/



#pragma segment Chess
void	UnmakeMove(FileRecHndl game)
{
	GameListHndl	gameMoves;
	short			gameIndex, numGameMoves;
	short			moveFrom, moveTo, pieceCaptured, pieceCapturedFrom;
	short			promoteTo, pieceMoved, color, delta, oldRookLoc, middle;

	gameIndex    = (*game)->doc.gameIndex;
	numGameMoves = (*game)->doc.numGameMoves;
	gameMoves    = (*game)->doc.gameMoves;

	if (!gameIndex) return;
	--gameIndex;

	moveFrom          = (**gameMoves)[gameIndex].moveFrom;
	moveTo            = (**gameMoves)[gameIndex].moveTo;
	pieceCaptured     = (**gameMoves)[gameIndex].pieceCaptured;
	pieceCapturedFrom = (**gameMoves)[gameIndex].pieceCapturedFrom;
	promoteTo         = (**gameMoves)[gameIndex].promoteTo;

	if (moveFrom) {		/* The "move" could be a resign or draw.  Make sure it isn't. */
		pieceMoved = (*game)->doc.theBoard[moveTo];
		if (promoteTo) pieceMoved = (pieceMoved < 0) ? -1 : 1;

		(*game)->doc.theBoard[moveFrom]          = pieceMoved;
		(*game)->doc.theBoard[moveTo]            = 0;
		(*game)->doc.theBoard[pieceCapturedFrom] = pieceCaptured;
			/* Any move now undone, except for castling.  The rook still has
			** to be put back.
			*/

		if ((pieceMoved == KING) || (pieceMoved == -KING)) {

			color = ((gameIndex + (*game)->doc.startColor) & 0x01);		/* Who's move it is. */
			(*game)->doc.king[color].kingLoc = moveFrom;
			--(*game)->doc.king[color].kingMoves;

			delta  = moveTo - moveFrom;
			oldRookLoc = 0;
			if (delta == -2) oldRookLoc = moveFrom - 4;
			if (delta == 2)  oldRookLoc = moveFrom + 3;
			if (oldRookLoc) {
				middle = (moveTo + moveFrom) / 2;
				(*game)->doc.theBoard[oldRookLoc] = (*game)->doc.theBoard[middle];
				(*game)->doc.theBoard[middle] = 0;
			}
		}		/* Castling now completely undone. */

		if ((moveFrom == 21) || (moveTo == 21)) --(*game)->doc.king[BLACK].rookMoves[QSIDE];
		if ((moveFrom == 28) || (moveTo == 28)) --(*game)->doc.king[BLACK].rookMoves[KSIDE];
		if ((moveFrom == 91) || (moveTo == 91)) --(*game)->doc.king[WHITE].rookMoves[QSIDE];
		if ((moveFrom == 98) || (moveTo == 98)) --(*game)->doc.king[WHITE].rookMoves[KSIDE];
			/* Undo any rook move/capture accounting.  This info is used when
			** determining of castling is allowed.
			*/

		(*game)->doc.enPasMove = (*game)->doc.enPasPawnLoc = 0;
			/* Assume move previous to the one we just undid was not a
			** double-pawn-push.  If it was not a double-pawn-push, then
			** en-passant moves are not possible at the move number we
			** just undid.
			*/
	}

	if (gameIndex) {		/* Restore en-passant possibilities. */

		moveFrom   = (**gameMoves)[--gameIndex].moveFrom;
		moveTo     = (**gameMoves)[gameIndex++].moveTo;
		pieceMoved = (*game)->doc.theBoard[moveTo];

		if ((pieceMoved == PAWN) || (pieceMoved == -PAWN)) {
			delta = moveTo - moveFrom;
			if ((delta == -20) || (delta == 20)) {
				(*game)->doc.enPasMove    = (moveTo + moveFrom) / 2;
				(*game)->doc.enPasPawnLoc = moveTo;
			}
		}
	}
	else {
		(*game)->doc.enPasMove    = (*game)->doc.arngEnPasMove;
		(*game)->doc.enPasPawnLoc = (*game)->doc.arngEnPasPawnLoc;
	}

	(*game)->doc.gameIndex = gameIndex;
}




/*****************************************************************************/



#pragma segment Chess
short	SquareAttacked(FileRecHndl game, short square, short color)
{
	short	destColor;
	short	kind;
	short	dirNum, dir;
	short	s, dist, maxDist, dest, taker, takerLoc;

	taker    = KING + 1;		/* This is a no-take flag. */
	takerLoc = 0;

	for (kind = KNIGHT; kind <= QUEEN; kind += (QUEEN - KNIGHT)) {
		/* Check in the knight and queen directions. */

		for (dirNum = 0; dir = direction[kind][dirNum]; ++dirNum) {
			/* The direction we will scan for an attack, for the most part. */

			maxDist = (kind == KNIGHT) ? 1 : 7;
			for (s = square, dist = 1; dist <= maxDist; ++dist) {

				s += dir;
				if ((dest = (*game)->doc.theBoard[s]) == EMPTY) continue;
					/* Empty square, so keep looking. */

				if (dest == OBNDS) break;
					/* Can't be attacked from this direction anymore. */

				destColor = BLACK;
				if (dest < 0) {
					destColor = WHITE;
					dest = -dest;
				}

				if (destColor == color) break;
					/* Ran into our own piece, so no attack
					** from this direction.
					*/

				if (dest >= taker) continue;

				if (kind == KNIGHT)	{		/* If we are looking for knights... */
					if (dest == KNIGHT) {
						taker    = KNIGHT;
						takerLoc = s;
						dirNum   = 7;		/* Since there is 'an' attack by a knight,
											** we don't care if there is another.
											** We have already established a knight
											** take, so we can skip the rest of the
											** knight directions. */
					}
					continue;		/* Only knights can take in this direction. */
				}

				if (dest == KING) {
					if (dist == 1) {
						taker    = KING;
						takerLoc = s;
					}
					break;
				}			/* We are looking in the non-knight move directions
							** for attackers.  If a king is found as the possible
							** attacker, make sure it is in range (one square away)
							** before counting it as an attack.  If it isn't one
							** square away, then it serves to prevent any other
							** attack from this direction.
							*/

				if (dest == QUEEN) {
					taker    = QUEEN;
					takerLoc = s;
					break;
				}			/* If the potential attacker is a queen, then it is
							** a valid attacker.
							*/

				if (dest == ROOK) {
					if (dirNum > 3) {
						taker    = ROOK;
						takerLoc = s;
					}
					break;
				}			/* If the potential attacker is a rook, and we are
							** examining a rank or file, then count it as an attacker.
							** Otherwise, the rook serves to prevent any other
							** attack from this direction.
							*/

				if (dest == BISHOP) {
					if (dirNum < 4) {
						taker    = BISHOP;
						takerLoc = s;
					}
					break;
				}			/* If the potential attacker is a bishop, and we are
							** examining a diagonal, then count it as an attacker.
							** Otherwise, the bishop serves to prevent any other
							** attack from this direction.
							*/

				if (dest == PAWN) {
					if (destColor == BLACK) {
						if ((dirNum < 2) && (dist == 1)) {
							taker    = PAWN;
							takerLoc = s;
						}
					}
					else
						if (
							(dirNum > 1) && 
							(dirNum < 4) && 
							(dist == 1)
						) {
							taker    = PAWN;
							takerLoc = s;
						}
					break;
				}

				break;
					/* Final case is a knight in a non-knight direction. */
			}
		}
	}

	return(takerLoc);
}



/*****************************************************************************/



#pragma segment Chess
void	EndTheGame(FileRecHndl game, short endReason)
{
	WindowPtr	oldPort;

	MakeMove(game, 0, endReason, 0);
		/* Record who resigned or draw agreement. */

	oldPort = SetFilePort(game);
	ImageDocument(game, true);
	AdjustGameSlider(game);
	UpdateGameStatus(game);
	SetPort(oldPort);
}



/*****************************************************************************/



#pragma segment Chess
short	WhosMove(FileRecHndl game)
{
	short	color;

	color  = ((*game)->doc.gameIndex ^ (*game)->doc.startColor);
	return(color & 0x01);
}



/*****************************************************************************/



#pragma segment Chess
short	GameStatus(FileRecHndl game)
{
	short			i, color, kingLoc;
	short			board[120], *boardPtr;
	short			origGameIndex, gameIndex;
	short			rep, back, pieceMoved, gameStat;
	GameListHndl	gameMoves;

	gPosReps = 0;

	if ((*game)->doc.arrangeBoard) return(kGameContinues);

	for (i = 0; i < 2; ++i)
		if (!(*game)->doc.timeLeft[i])
			return(kYouLoseOnTime - (i ^ (*game)->doc.myColor));

	GenerateLegalMoves(game);

	gameMoves     = (*game)->doc.gameMoves;
	origGameIndex = (*game)->doc.gameIndex;

	if (!(*game)->doc.numLegalMoves) {

		color = WhosMove(game);			/* Who's move it is. */

		if ((origGameIndex) && (origGameIndex == (*game)->doc.numGameMoves))
			if (!(**gameMoves)[origGameIndex - 1].moveFrom)
				return((**gameMoves)[origGameIndex - 1].moveTo);

		kingLoc = (*game)->doc.king[color].kingLoc;

		if (SquareAttacked(game, kingLoc, color)) {		/* Checkmated. */
			if (color == (*game)->doc.myColor) return(kYouLose);
			else return(kYouWin);
		}

		return(kStalemate);
	}

	BlockMove((Ptr)&(*game)->doc.theBoard[0], (Ptr)&board[0], 120 * sizeof(short));

	rep = 2;			/* 2 matching current position makes 3 that match. */
	back = 100;

	while ((rep) && (back) && (gameIndex = (*game)->doc.gameIndex)) {

		if ((**gameMoves)[--gameIndex].pieceCaptured) break;

		pieceMoved = (*game)->doc.theBoard[(**gameMoves)[gameIndex].moveTo];
		if (pieceMoved < 0) pieceMoved = -pieceMoved;
		if (pieceMoved == PAWN) break;

		UnmakeMove(game);
		--back;

		boardPtr = &(*game)->doc.theBoard[0];
		for (i = START_IBNDS; i < END_IBNDS; ++i) if (boardPtr[i] != board[i]) break;

		if (i == END_IBNDS) {
			++gPosReps;
			if (!(--rep)) break;
		}
	}

	while ((*game)->doc.gameIndex != origGameIndex) MakeMove(game, 1, 0, 0);

	gameStat = kGameContinues;
	if (!rep)  gameStat = kDrawByRep;
	if (!back) gameStat = kDrawBy50;

	if (gameStat) (*game)->doc.numLegalMoves = 0;

	return(gameStat);
}



/*****************************************************************************/



#pragma segment Chess
short	UpdateTime(FileRecHndl game, Boolean canLose)
{
	FileRecPtr	frPtr;
	short		moveColor, myColor;
	long		timeLeft, opponentTimeLeft, oldTimeLeft, diff;

	frPtr = *game;
	moveColor        = WhosMove(game);
	myColor          = frPtr->doc.myColor;
	timeLeft         = frPtr->doc.timeLeft[moveColor];
	opponentTimeLeft = frPtr->doc.timeLeft[moveColor ^ 1];

	if (!frPtr->doc.twoPlayer) myColor = moveColor;
		/* Since we are not playing over the net, both sides can lose 
		** due to time on this machine. */

	if ((timeLeft > 0) && (opponentTimeLeft > 0)) {
		oldTimeLeft = timeLeft;
		diff = TickCount() - frPtr->doc.timerRefTick;
		if (diff < 0) {
			frPtr->doc.timerRefTick = TickCount();
			diff = 0;
		}
		diff /= 60;
		diff *= 60;
		if (diff >= 60) {
			if (!GameStatus(game)) {
				timeLeft -= diff;
				if (timeLeft < 60) timeLeft = 0;
				if (!timeLeft)
					if ((myColor != moveColor) || (!canLose)) timeLeft = 60;
				frPtr->doc.timeLeft[moveColor] = timeLeft;
				frPtr->doc.timerRefTick += diff;
				if (!timeLeft) return(2);
				if (timeLeft != oldTimeLeft) return(1);
			}
			else (*game)->doc.timerRefTick = TickCount();
				/* Someone has already lost, so no time change. */
		}
	}
	else (*game)->doc.timerRefTick = TickCount();

	return(0);
}



/*****************************************************************************/



#pragma segment Chess
void	UpdateGameStatus(FileRecHndl game)
{
	WindowPtr		oldPort;
	ControlHandle	draw, resign;
	short			status, myColor;
	Rect			drawRect, resignRect, workRect;
	Point			endOfText;
	Boolean			hideEm, hidden;
	Str255			reasonText;

	if ((*game)->doc.arrangeBoard) return;

	draw   = (*game)->doc.draw;
	resign = (*game)->doc.resign;

	if (!draw) return;

	oldPort = SetFilePort(game);

	drawRect   = (*draw)->contrlRect;
	resignRect = (*resign)->contrlRect;

	hideEm = false;
	if (status = GameStatus(game)) hideEm = true;

	hidden = false;
	if (drawRect.top & 0x4000) hidden = true;

	workRect = drawRect;
	if (hidden) OffsetRect(&workRect, 0, -0x4000);
	workRect.right = resignRect.right;

	if (hideEm != hidden) {
		EraseRect(&workRect);
		MoveControl(draw,   drawRect.left,   drawRect.top ^ 0x4000);
		MoveControl(resign, resignRect.left, resignRect.top ^ 0x4000);
	}

	if (hideEm) {
		myColor = (*game)->doc.myColor;
		switch (status) {
			case kYouWin:
			case kYouWinOnTime:
				status = kWhiteWins + myColor;
				break;
			case kYouLose:
			case kYouLoseOnTime:
				status = kBlackWins - myColor;
				break;
		}

		TextMode(srcCopy);
		TextFont(systemFont);
		TextSize(0);
		GetIndString(reasonText, rGameStat, status);
		MoveTo(workRect.left, workRect.top + 14);
		DrawString(reasonText);
		TextMode(srcOr);
		GetPen(&endOfText);
		workRect.left = endOfText.h;
		EraseRect(&workRect);
	}

	SetPort(oldPort);
}



/*****************************************************************************/



#pragma segment Chess
void	DrawButtonTitle(FileRecHndl game, short newVal)
{
	WindowPtr		oldPort;
	ControlHandle	draw;
	Rect			drawRect;
	Str255			drawButtonText;

	if (newVal != (*game)->doc.drawBtnState) {

		oldPort = SetFilePort(game);

		GetIndString(drawButtonText, rGameStat, kDrawButtonText + newVal);

		draw = (*game)->doc.draw;
		SetCTitle(draw, drawButtonText);
		(*game)->doc.drawBtnState = newVal;

		drawRect = (*draw)->contrlRect;
		ValidRect(&drawRect);

		SetPort(oldPort);
	}
}



/*****************************************************************************/
/*****************************************************************************/



#pragma segment Chess
Boolean	ComputerMove(FileRecHndl game)
{
	OSErr			err;
	FileRecHndl		workGame;
	short			numLegalMoves, moveNum, fromSq, toSq, i;
	short			wtotal, btotal, color, update;
	WindowPtr		window;
	Boolean			compMoved;
	MoveListHndl	legalMoves;

	compMoved = false;

	IncNewFileNum(false);
	err = AppDuplicateDocument(game, &workGame);
	IncNewFileNum(true);
	if (err) return(false);

	for (i = 0; i < 2; ++i) (*workGame)->doc.timeLeft[i] = (*game)->doc.timeLeft[i];

	GetPort(&window);
	(*workGame)->fileState.window = window;

	GenerateLegalMoves(game);
	GenerateLegalMoves(workGame);

	numLegalMoves = (*workGame)->doc.numLegalMoves;
	legalMoves    = (*workGame)->doc.legalMoves;

	if (numLegalMoves) {		/* If there is a move, pick one, any one. */
		if (numLegalMoves == 1) moveNum = 0;
		else {
			moveNum = CheckForMate(workGame, 0, 2);
			if (moveNum == -1) {
				CalcPositionValues(workGame);
				wtotal = gWhiteTotal >> 16;
				btotal = gBlackTotal >> 16;
				color  = WhosMove(workGame);
				for (;;) {
					if (gNumPieces == 1) {
						if (
							((color == WHITE) && (wtotal == 9)) ||
							((color == BLACK) && (btotal == 9))
						) {
							moveNum = QueenMate(workGame);
							break;
						}
						if (
							((color == WHITE) && (wtotal == 5)) ||
							((color == BLACK) && (btotal == 5))
						) {
							moveNum = RookMate(workGame);
							break;
						}
					}
					moveNum = BestMove(workGame);
					break;
				}
			}
		}

		if (moveNum > -1) {
			if (update = UpdateTime(game, true)) DrawTime(game);
			if (update == 2) {
				if ((*game)->doc.twoPlayer) SendGame(game, kIsMove, nil);
				AlertIfGameOver(game);
			}
			else {
				fromSq = (**legalMoves)[moveNum].moveFrom;
				toSq   = (**legalMoves)[moveNum].moveTo;
				SlideThePiece(game, fromSq, toSq);
				MakeMove(game, fromSq, toSq, QUEEN);
				compMoved = true;
			}
		}
		if (moveNum == kComputerResigns) {
			EndTheGame(game, kWhiteResigns + WhosMove(game));
			if ((*game)->doc.twoPlayer) SendGame(game, kIsMove, nil);
			gComputerResigns = true;
			AlertIfGameOver(game);
		}
	}

	AppDisposeDocument(workGame);
	return(compMoved);
}



/*****************************************************************************/



#pragma segment Chess
short	CheckForMate(FileRecHndl game, short nodeDepth, short maxDepth)
{
	short			num, ourMove, move;
	short			color, kingLoc, result;
	MoveListHndl	node;
	EventRecord		event;

	ourMove = -1;
	GenerateLegalMoves(game);

	num  = (*game)->doc.numLegalMoves;
	node = (*game)->doc.legalMoves;

	(*game)->doc.legalMoves = gNodeHndl[nodeDepth];
		/* Protect the list of legal moves for this level.  Put a handle
		** into the game where moves for the next level can be placed. */

	color = WhosMove(game) ^ 1;
	if (!(nodeDepth & 0x01)) {
		for (move = 0; (move < num) && (ourMove == -1); ++move) {
			MakeMove(game, (**node)[move].moveFrom, (**node)[move].moveTo, QUEEN);
			kingLoc = (*game)->doc.king[color].kingLoc;
			if (SquareAttacked(game, kingLoc, color)) {		/* The move caused check. */
				GenerateLegalMoves(game);
				if (!(*game)->doc.numLegalMoves) {			/* If no way out of check... */
					ourMove = move;							/* ...it is checkmate. */
				}
			}
			UnmakeMove(game);
		}
		if (idleTick + 10 < TickCount()) {
			idleTick = TickCount();
			if (EventAvail(everyEvent - highLevelEventMask, &event)) ourMove = -2;
			else {
				CTEIdle();
				DoIdleTasks(false);
			}
		}
	}

	if (nodeDepth < maxDepth) {
		if (ourMove == -1) {
			for (move = 0; (move < num) && (ourMove == -1); ++move) {
				MakeMove(game, (**node)[move].moveFrom, (**node)[move].moveTo, QUEEN);
				result = CheckForMate(game, nodeDepth + 1, maxDepth);
				if (result == -1) {
					ourMove = move;
				}
					/* If opponent can't find saving move, then this is the move we want. */
				if (result == -2) ourMove = -2;
					/* User interrupted search. */
				UnmakeMove(game);
			}
		}
	}

	if (!nodeDepth) {
		if (ourMove > -1) {
			MakeMove(game, (**node)[ourMove].moveFrom, (**node)[ourMove].moveTo, QUEEN);
			kingLoc = (*game)->doc.king[color].kingLoc;
			if (!SquareAttacked(game, kingLoc, color)) {	/* It is not a mate in 1. */
				GenerateLegalMoves(game);
				if (!(*game)->doc.numLegalMoves) ourMove = -1;
					/* It is a stalemate.  Throw it back. */
			}
			UnmakeMove(game);
		}
	}

	(*game)->doc.numLegalMoves = num;
	(*game)->doc.legalMoves    = node;

	return(ourMove);
}



/*****************************************************************************/



#pragma segment Chess
short	BestMove(FileRecHndl game)
{
	short			bestMove, keepBestMove, num;
	short			i, color, move, from, to;
	Boolean			playOn;
	long			value, max;
	MoveListHndl	node;
	EventRecord		event;

	bestMove = -1;

	num  = (*game)->doc.numLegalMoves;
	node = (*game)->doc.legalMoves;

	(*game)->doc.legalMoves = gNodeHndl[kLastNode];
		/* Protect the list of legal moves for this node.  Put a different handle
		** into the game where moves for the next level can be placed. */

	color  = WhosMove(game);
	playOn = false;
	if ((i = (*game)->doc.timeLeft[1 - color]) >= 0)
		if (i < 7200)
			playOn = true;

	for (max = 0x80000000L, move = 0; move < num; ++move) {
		from = (**node)[move].moveFrom;
		to   = (**node)[move].moveTo;
		(**node)[move].value = value = OneDeepEval(game, from, to, color);
		if (max < value) {
			max = value;
			bestMove = move;		/* Best move so far. */
		}
		if (idleTick + 10 < TickCount()) {
			idleTick = TickCount();
			if (EventAvail(everyEvent - highLevelEventMask, &event)) {
				bestMove = -2;
				break;
			}
			CTEIdle();
			DoIdleTasks(false);
		}
	}

	if (bestMove > -1) {		/* Make sure we aren't getting mated in two. */
		for (keepBestMove = bestMove;;) {
			from = (**node)[bestMove].moveFrom;
			to   = (**node)[bestMove].moveTo;
			MakeMove(game, from, to, QUEEN);
			i = CheckForMate(game, 0, 2);	/* Check for mate in 2. */
			UnmakeMove(game);
			if (i == -2) {
				bestMove = -2;
				break;		/* User wants to do something, so interrupt. */
			}
			if (i == -1) {
				max = (**node)[bestMove].value;
				if (!playOn)
					if (max < -0x00070000)
						if (!(Random() & 0x03))
							bestMove = kComputerResigns;	/* Resign sometimes. */
				break;		/* Opponent has no mate in 2 against bestMove. */
			}
			(**node)[bestMove].value = max = 0x80000000L;	/* Getting mated is bad-bad. */
			for (i = 0; i < num; ++i) {		/* Try the next best move. */
				if (max < (**node)[i].value) {
					max = (**node)[i].value;
					bestMove = i;
				}
			}
			if (max == 0x80000000L) {
				bestMove = keepBestMove;	/* We are going to get mated.  (Bummer.) */
				if (!playOn)
					if (!(Random() & 0x01))
						bestMove = kComputerResigns;	/* Resign sometimes. */
				break;
			}
		}
	}

	(*game)->doc.numLegalMoves = num;
	(*game)->doc.legalMoves    = node;

	return(bestMove);
}



/*****************************************************************************/



#pragma segment Chess
long	OneDeepEval(FileRecHndl game, short from, short to, short color)
{
	short			material, matBalance, xcngVal, posVal;
	short			take, takerLoc, retakerLoc;
	short			val, saveBoard;
	short			*boardPtr, keepBoard[120], square, j, k, xcolor;
	short			movedPiece, piece, pieceColor, r, c, cc, delta, xcng[64], xnum, loop;
	short			dirNum, dir, s, dist, numChecks;
	long			value;

	MakeMove(game, from, to, QUEEN);

	boardPtr   = &(*game)->doc.theBoard[0];
	matBalance = xcngVal = posVal = 0;

	for (material = 0, square = START_IBNDS; square < END_IBNDS; ++square) {
		if (piece = boardPtr[square]) {
			if (piece != OBNDS) {
				if (piece < 0) piece = -piece;
				if (piece == KING)   piece = 0;
				if (piece == QUEEN)  piece = 9;
				if (piece == ROOK)   piece = 5;
				if (piece == KNIGHT) piece = 3;
				material += piece;
			}
		}
	}

	movedPiece = boardPtr[to];
	if (movedPiece < 0) movedPiece = -movedPiece;

	for (square = START_IBNDS; square < END_IBNDS; ++square) {

		if (piece = boardPtr[square]) {		/* Evaluate value of this piece being here. */

			if ((piece) && (piece != OBNDS)) {

				pieceColor = BLACK;	/* Figure who's piece it is. */
				if (piece < 0) {
					pieceColor = WHITE;
					piece = -piece;
				}

				j = piece;
				if (j == QUEEN)  j = 9;
				if (j == ROOK)   j = 5;
				if (j == KNIGHT) j = 3;
				if (color == pieceColor) matBalance += j;
				else					 matBalance -= j;

				r = square / 10;	/* Get row and column of piece. */
				c = square - 10 * r - 1;
				r -= 2;

				if (pieceColor == WHITE) r = 7 - r;		/* Flip rank for white. */

				if (piece == PAWN) {			/* Weight the pawn position. */
					if (r > 4) {
						if (r == 6) r = 63;		/* Highly advanced pawns are nice. */
						if (r == 5) r = 30;
					}
					else {
						if (material > 40) {
							cc = c;
							if (cc > 3) cc = 7 - cc;
							if (r < 2) cc = 0;
							switch (cc) {
								case 0:
									r = 0;
									break;
								case 1:
									if (r > 2) r = -8;
									else       r = 0;
									break;
								case 2:
									if (r == 2) r = -2;
									if (r == 3) {
										r = 6;
										if (c < 5) r = 11;
									}
									break;
								case 3:
									if (r == 2) r = 6;
									if (r == 3) {
										r = 6;
										if (c < 5) r = 11;
									}
									break;
							}
						}
						if (material < 26) r *= 4;
					}
					for (j = 9; j <= 11; j += 2) {	/* Give weight to pawn chains. */
						k = boardPtr[square + j];
						if (pieceColor == WHITE) k = -k;
						if (k == PAWN) {
							k = boardPtr[square - j];
							if (pieceColor == WHITE) k = -k;
							if (k == PAWN) ++r;
						}
					}
					for (j = square;;) {	/* Give negative weight for doubled pawns. */
						j += 10;
						if (pieceColor == WHITE) j -= 20;
						k = boardPtr[j];
						if (k == OBNDS) break;
						if (pieceColor == WHITE) k = -k;
						if (k == PAWN) r -= 4;
					}
					if ((c == 3) || (c == 4)) {	/* Give negative weight for backward center pawns. */
						for (j = square - 1;;) {
							j += 10;
							if (pieceColor == WHITE) j -= 20;
							k = boardPtr[j];
							if (k == OBNDS) break;
							if (pieceColor == WHITE) k = -k;
							if (k == PAWN) {
								r -= 2;
								break;
							}
						}
						for (j = square + 1;;) {
							j += 10;
							if (pieceColor == WHITE) j -= 20;
							k = boardPtr[j];
							if (k == OBNDS) break;
							if (pieceColor == WHITE) k = -k;
							if (k == PAWN) {
								r -= 2;
								break;
							}
						}
					}
					for (j = square;;) {	/* Give negative weight for doubled pawns. */
						j += 10;
						if (pieceColor == WHITE) j -= 20;
						k = boardPtr[j];
						if (k == OBNDS) break;
						if (pieceColor == WHITE) k = -k;
						if (k == PAWN) r -= 4;
					}

					if ((*game)->doc.gameIndex == 2)
						if (square == 54)
							if ((boardPtr[63] == WP) || (boardPtr[65] == WP))
								r = -200;
									/* Special-case out center-counter. */

					if ((*game)->doc.gameIndex == 4)
						if (square == 45)
							if (boardPtr[45] == BP)
								if (boardPtr[54] == BP)
									if (boardPtr[63] == WP)
										if (boardPtr[64] == WP)
											r += (0x00010000 >> 3);
												/* Give weight to declining queen's gambit. */

					if ((*game)->doc.gameIndex == 4)
						if (square == 53)
							if (boardPtr[53] == BP)
								if (boardPtr[43] == BN)
									if (boardPtr[65] == WP)
										if (boardPtr[76] == WN)
											r += (0x00010000 >> 3);
												/* Play a better e4,c5,Nf3. */

					if ((*game)->doc.gameIndex == 5)
						if (square == 54)
							if (boardPtr[54] == WP)
								if (boardPtr[53] == BP)
									if (boardPtr[63] == WP)
										if (boardPtr[46] == BN)
											r += (0x00010000 >> 2);
												/* Play a better d4,Nf6,c4,c5. */

					if ((*game)->doc.gameIndex == 6)
						if (square == 64)
							if (boardPtr[64] == BP)
								if (boardPtr[43] == BN)
									if (boardPtr[65] == WP)
										if (boardPtr[76] == WN)
											r += (0x00010000 >> 2);
												/* Play a better e4,c5,Nf3,Nc6,d4. */

					if (color != pieceColor) r = -r;
					posVal += r;

				}

				if (piece == KNIGHT) {		/* Give weight to centralized knights. */
					if ((!r) || (r == 7)) {
						r = -4;
						if ((*game)->doc.gameIndex < 3) {
							r = 200;
							/* Special-case out knights early, 'cause it's really gross. */
						}
					}
					else {
						if (r == 4) r = 5;
						if (r > 3) r = 7 - r;
						if ((c < 2) || (c > 5))  r /= 2;
						if ((c < 1) || (c > 6))  r /= 2;
					}
					if (color != pieceColor) r = -r;
					posVal += r;
				}

				if (piece == BISHOP) {
					j = r;
					if (r > 5) r = 7 - r;
						if (!r) r = -2;		/* Get those bishops developed. */
					if ((c < 1) || (c > 6))  r /= 4;
					if (j > 1) {		/* Give weight to knights before bishops past 2nd rank. */
						c = (c < 4) ? 2 : 7;
						k = boardPtr[90 + c - 70 * pieceColor];
						if (pieceColor == WHITE) k = -k;
						if (k == KNIGHT) r = -1;
					}
					if (color != pieceColor) r = -r;
					posVal += r;
				}

				if (piece == ROOK) {	/* Give weight to rooks on open files. */
					if (material > 25) {
						delta = (color == BLACK) ? 10 : -10;
						if ((c) && (c < 7)) {
							for (j = square + delta; !boardPtr[j]; j += delta, ++r);
							if (color != pieceColor) r = -r;
							posVal += r;
						}
					}
				}

				if (piece == QUEEN) {
					if (color == pieceColor) {
						if (movedPiece == QUEEN) {
							if (material > 50) {
								r = -2;
								if (color != pieceColor) r = -r;
								posVal += r;
							}		/* Keep the queen from moving too much in the beginning. */
						}
					}
				}
				if (piece == KING) {	/* Give weight to no king moves other than castling. */
					j = 0;
					if ((*game)->doc.king[color].kingMoves < 2) {
						j = -10;
						if (!r) {
							if (c == 6) j = 6;
							if (c == 2) j = 4;
						}
					}
					if (color != pieceColor) j = -j;
					posVal += j;
				}

				if (color == pieceColor) {

					for (dirNum = 0; dir = direction[piece][dirNum]; ++dirNum) {
						for (s = square, dist = 1; dist <= distance[piece]; ++dist) {
							if (piece == PAWN) {
								if (dirNum > 1) break;
								dir = direction[BISHOP][dirNum];
								if (color == BLACK) dir = -dir;
							}
							s += dir;
							if ((take = (*game)->doc.theBoard[s]) == EMPTY) continue;
							if (take == OBNDS) break;
							xcolor = BLACK;
							if (take < 0) {
								xcolor = WHITE;
								take = -take;
							}
							if (xcolor == color) break;
							switch (j = take) {
								case KNIGHT:
									j = 3;
									break;
								case ROOK:
									j = 5;
									break;
								case QUEEN:
									j = 9;
									break;
								case KING:
									j = material;
									if (j > 39) j = 60 - j;
									j /= 2;
									break;
							}
							switch (k = piece) {
								case KNIGHT:
									k = 3;
									break;
								case ROOK:
									k = 5;
									break;
								case QUEEN:
									k = 9;
									break;
								case KING:
									k = material;
									if (k > 39) k = 60 - k;
									k /= 2;
									break;
							}
							if (j > k) posVal += (j - k) * 5;
							else if (!SquareAttacked(game, s, color)) posVal += (j + 4);
							break;
						}
					}		/* The above code calculates the aggression factor of the board.
							** If the attacking piece is smaller than the piece attacked, then
							** we add the delta value as a plus.  This factor finds forks,
							** chases kings, queens, etc. */

							/* The below code estimates the exchange value of takes.  This
							** is only an estimate, as it is not an actual move analysis
							** of all the possible exchanges.  We are only trying to get
							** an estimate of the board position in this function. */

					if (takerLoc = SquareAttacked(game, square, color)) {
						saveBoard = false;
						xnum = val = 0;
						for (xcolor = color ^ 1; takerLoc; xcolor ^= 1) {
							take = boardPtr[square];
							if (take < 0) take = -take;
							if (take == KING)   take = 512;
							if (take == QUEEN)  take = 9;
							if (take == ROOK)   take = 5;
							if (take == KNIGHT) take = 3;
							retakerLoc = SquareAttacked(game, square, xcolor);
							if (xcolor == color) val += take;
							else				 val -= take;
							xcng[xnum++] = val;
							if (retakerLoc) {
								if (!saveBoard) {
									saveBoard = true;
									for (j = START_IBNDS; j < END_IBNDS; ++j)
										keepBoard[j] = boardPtr[j];
								}
								boardPtr[square] = boardPtr[takerLoc];
								boardPtr[takerLoc] = 0;
							}
							takerLoc = retakerLoc;
						}
						if (saveBoard)
							for (j = START_IBNDS; j < END_IBNDS; ++j)
								boardPtr[j] = keepBoard[j];
						xcng[xnum] = xcng[xnum - 1];
						xcolor = 1;		/* Check on opponent first. */
						for (loop = true; loop; xcolor ^= 1) {
							val  = xcng[xcolor];
							k    = xnum;
							loop = false;
							for (j = xcolor + 2; j <= k; j += 2) {
								if (xcolor) {
									if (val > xcng[j]) {
										val = xcng[j];
										xnum = j - 1;
										loop = true;
									}
								}
								else {
									if (val < xcng[j]) {
										val = xcng[j];
										xnum = j - 1;
										loop = true;
									}
								}
							}
						}
						if (xcngVal > val) xcngVal = val;
					}
				}
			}
		}
	}

	val = GameStatus(game);
	j = (100 - (*game)->doc.numLegalMoves) / 3;
	if (material > 60) j = 0;

	xcolor = color ^ 1;
	for (numChecks = 0;; ++numChecks) {
		if (!(SquareAttacked(game, (*game)->doc.king[xcolor].kingLoc, xcolor))) break;
		if ((*game)->doc.gameIndex < 2) break;
		UnmakeMove(game);
		UnmakeMove(game);
	}
	if (numChecks > 3) {
		j = 0;
	}
	for (; numChecks; --numChecks) {
		MakeMove(game, 1, 0, 0);
		MakeMove(game, 1, 0, 0);
	}

	posVal += j;

	if ((val >= kStalemate) && (val <= kDrawByRep)) matBalance = xcngVal = posVal = 0;
		/* Drawing may be our best move, so don't just eliminate this move. */

	if (gPosReps) matBalance = xcngVal = posVal = 0;
		/* Drawing may be our best move, so don't just eliminate this move. */

	UnmakeMove(game);
	GenerateLegalMoves(game);

	value = (((long)(matBalance + xcngVal)) << 16) + (((long)posVal) << 3);
	if (material > 29) value += (Random() & 0x7F);

	return(value);		
}



/*****************************************************************************/



#pragma segment Chess
void	SlideThePiece(FileRecHndl game, short fromSq, short toSq)
{
	short	fromRow, fromCol, toRow, toCol;
	Point	fromLoc, toLoc;
	Rect	fromRect;

	fromRow = (fromSq - START_IBNDS) / 10;
	fromCol = fromSq - START_IBNDS - 10 * fromRow;
	if ((*game)->doc.invertBoard) {
		fromRow = 7 - fromRow;
		fromCol = 7 - fromCol;
	}
	fromRect.top    = 1 + fromRow * kBoardSqSize;
	fromRect.left   = 1 + fromCol * kBoardSqSize;
	fromRect.bottom = fromRect.top  + 32;
	fromRect.right  = fromRect.left + 32;

	toRow = (toSq - START_IBNDS) / 10;
	toCol = toSq - START_IBNDS - 10 * toRow;
	if ((*game)->doc.invertBoard) {
		toRow = 7 - toRow;
		toCol = 7 - toCol;
	}

	fromLoc.v = fromRow * kBoardSqSize + kBoardVOffset + (kBoardSqSize / 2);
	fromLoc.h = fromCol * kBoardSqSize + kBoardHOffset + (kBoardSqSize / 2);
	toLoc.v   = toRow * kBoardSqSize + kBoardVOffset + (kBoardSqSize / 2);
	toLoc.h   = toCol * kBoardSqSize + kBoardHOffset + (kBoardSqSize / 2);

	MoveThePiece(game, fromSq, fromRect, fromLoc, &toLoc);
}



/*****************************************************************************/



#pragma segment Chess
void	CalcPositionValues(FileRecHndl game)
{
	short	*boardPtr, square, piece;
	long	val;

	boardPtr = &(*game)->doc.theBoard[0];
	gTreeValue = gWhiteTotal = gBlackTotal = gNumPieces = 0;
	for (square = START_IBNDS; square < END_IBNDS; ++square) {
		if (piece = boardPtr[square]) {
			if (piece != OBNDS) {
				val = gTreePieceValues[piece + KING];
				gTreeValue += val;
				if (piece < 0) piece = -piece;
				if (piece != KING) {
					gPieceLoc = square;
					++gNumPieces;
					if (val < 0) gWhiteTotal -= val;
					else		 gBlackTotal += val;
				}
			}
		}
	}
}




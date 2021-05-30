#ifndef __CHESS__
#define __CHESS__

#ifndef __TYPES__
#include <types.h>
#endif

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif

#ifndef __PRINTING__
#include <Printing.h>
#endif

#ifndef __SPEECH__
#include "Speech.h"
#endif


#define WHITE 0
#define BLACK 1

#define QSIDE 0
#define KSIDE 1

#define EMPTY	0
#define PAWN	1
#define KNIGHT	2
#define BISHOP	3
#define ROOK	4
#define QUEEN	5
#define KING	6

#define BP PAWN			/* Black pawn	*/
#define BN KNIGHT		/* Black knight	*/
#define BB BISHOP		/* Black bishop	*/
#define BR ROOK			/* Black rook	*/
#define BQ QUEEN		/* Black queen	*/
#define BK KING			/* Black king	*/

#define WP -PAWN		/* White pawn	*/
#define WN -KNIGHT		/* White knight	*/
#define WB -BISHOP		/* White bishop	*/
#define WR -ROOK		/* White rook	*/
#define WQ -QUEEN		/* White queen	*/
#define WK -KING		/* White king	*/

#define OBNDS 32767		/* Out of bounds. */

#define START_IBNDS	21		/* Start of in-bounds for the board. */
#define END_IBNDS	99		/* End of in-bounds for the board. */

#define BKPOS	25
#define WKPOS	95

#define kGameContinues	0
#define kYouWin			1
#define kYouLose		2
#define kStalemate		3
#define kDrawBy50		4
#define kDrawByRep		5
#define kYouWinOnTime	6
#define kYouLoseOnTime	7
#define kWhiteResigns	8
#define kBlackResigns	9
#define kDrawGame		10
#define kWhiteWins		11
#define kBlackWins		12
#define kDrawButtonText	13

#define kMessageDoc		-1

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
typedef struct {
	short	kingLoc;
	short	kingMoves;
	short	rookMoves[2];
} KingInfo;
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct {
	short	moveFrom;
	short	moveTo;
	long	value;
} MoveElement;
typedef MoveElement MoveListAry[];
typedef MoveListAry *MoveListPtr, **MoveListHndl;

typedef struct {
	short	moveFrom;
	short	moveTo;
	short	pieceCaptured;
	short	pieceCapturedFrom;		/* For undoing en-passant. */
	short	promoteTo;				/* For undoing promotions and recording games. */
} GameElement;
typedef GameElement GameListAry[];
typedef GameListAry *GameListPtr, **GameListHndl;

typedef struct {
	GameElement	move;
	short		enPasMove;
	short		enPasPawnLoc;
} MoveRec;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
typedef struct {

	short			version;			/* The file format version.				   */

	Boolean			printRecValid;		/* True if print record has been created.  */
	TPrint			print;				/* Print record for file.				   */

	short			theBoard[120];		/* The current board position.			   */
	KingInfo		king[2];			/* King locations and castling info.	   */
	short			enPasMove;			/* Where an en-passant could occur.		   */
	short			enPasPawnLoc;		/* Location of en-passant-capture.		   */
	short			arngEnPasMove;		/* Initial arranged en-pas move.		   */
	short			arngEnPasPawnLoc;	/* Initial arranged en-pas capture.		   */
	short			numLegalMoves;		/* # of moves in legal move list.		   */
	short			gameIndex;			/* Index into game record.				   */
	short			numGameMoves;		/* Size of game record.					   */
	short			myColor;			/* True if I am playing black.			   */
	short			startColor;			/* True if black started game.			   */
	short			arrangeBoard;		/* True if in arrange-board mode.		   */
	short			palettePiece;		/* Piece hilited in arrange-board palette. */
	unsigned long	defaultTime[2];		/* Default ticks for white/black.		   */
	unsigned long	timeLeft[2];		/* Ticks remaining for white/black.		   */
	Boolean			invertBoard;		/* True, display board inverted.		   */
	short			endFileInfo1;		/* Above info is saved to disk.			   */

	Str32			reconnectZone;		/* Zone of opponent.					   */
	Str32			reconnectMachine;	/* Machine of opponent.					   */
	Str255			reconnectPath;		/* Full path of opponent's copy of Kibitz. */
	Str32			reconnectApp;		/* Name of opponent's copy of Kibitz.	   */
	Boolean			justBoardWindow;	/* Just the board shows if true.		   */
	Boolean			docIsTemplate;		/* Doc opens as Untitled, file closed.	   */
	Boolean			keepCMWhite;		/* True if computer moves white pieces.    */
	Boolean			keepCMBlack;		/* True if computer moves black pieces.    */
	short			endFileInfo2;		/* Above info is saved to disk.			   */
										/* Above info saved in later version.	   */

	Boolean			twoPlayer;			/* True if playing over the net.		   */
	long			gameID_0;			/* Used to match up incoming moves.		   */
	long			gameID_1;			/* Used to match up incoming moves.		   */
	short			sendReason;			/* Reason for sending the game.			   */
	short			drawBtnState;		/* State of the draw button. 			   */
	AEAddressDesc	locOfOpponent;		/* AppleEvents address of opponent.		   */
	short			endSendInfo;		/* Above is send game info.				   */

	short			resync;				/* Non-zero if resync needed.			   */
	Boolean			creator;			/* True if this guy originated game.	   */
	unsigned long	displayTime[2];		/* Time shown (is <= timeLeft).			   */
	unsigned long	freezeTime[2];		/* Time left when clock stopped.		   */
	unsigned long	timerRefTick;		/* Reference tick for timer.			   */
	unsigned long	compMoveTick;		/* Tick when computer moved last.		   */
	unsigned long	gotUpdateTick;		/* Tick when we received new game info.	   */
	Boolean			compMovesWhite;		/* True if computer moves white pieces.    */
	Boolean			compMovesBlack;		/* True if computer moves black pieces.    */
	Str32			opponentName;		/* User name of opponent.				   */
	Str32			opponentZone;		/* Zone of opponent.					   */
	Str32			opponentMachine;	/* Machine of opponent.					   */
	unsigned long	timeLastReceive;	/* Time that last move/message received.   */
	short			endLocalInfo;		/* Above info is for one machine only.	   */

	Boolean			configColorChange;	/* True if color change has been posted.   */
	short			configColor;		/* Color change value to be applied.	   */
	Boolean			configTimeChange;	/* True if time change has been posted.	   */
	unsigned long	configTime[2];		/* Time change value to be applied.		   */
	short			endConfigInfo;		/* Above info is config setting which will */
										/* not be applied until a NULL event.	   */

	MoveListHndl	legalMoves;			/* Handle of legal moves.				   */
	GameListHndl	gameMoves;			/* Handle of game record (saved to disk).  */
	TEHandle		message[2];			/* Handles to in/out messages.			   */
	Handle			sound;				/* Handle to recorded sound.			   */
	Boolean			doSpeech;
	VoiceSpec		theVoice;
	ControlHandle	sendMessage;		/* Handle to send button.				   */
	ControlHandle	beepOnMove;			/* Handle to move-beep checkbox.		   */
	ControlHandle	beepOnMssg;			/* Handle to mssg-beep checkbox.		   */
	ControlHandle	gameSlider;			/* Handle to slider custom control.		   */
	ControlHandle	wbStart[2];			/* Handles to arrange board controls.	   */
	ControlHandle	resign;				/* Handle to resign button.				   */
	ControlHandle	draw;				/* Handle to draw button.				   */
	ControlHandle	record;				/* Handle to record sound button.		   */
	ControlHandle	sendSnd;			/* Handle to send sound button.			   */
	short			endControls;		/* Above info is reference to controls.	   */

} TheDoc, *TheDocPtr, **TheDocHndl;
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

#endif

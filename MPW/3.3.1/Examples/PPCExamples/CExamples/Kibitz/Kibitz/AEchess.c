/*
** Apple Macintosh Developer Technical Support
**
** File:	    aechess.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved.
**
** This is the custom AppleEvents code.  The required AppleEvents code is in
** the file AppleEvents.c, which is Keith Rollin's work. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __AEUTILS__
#include <AEUtils.h>
#endif

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __FONTS__
#include <Fonts.h>
#endif

#ifndef __LOWMEM__
#include <LowMem.h>
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifndef __NOTIFICATION__
#include <Notification.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#ifndef __PPC__
#include "PPC.h"
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __SOUND__
#include <Sound.h>
#endif

#ifndef __STRING__
#include <String.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif

#ifndef __TEXTEDITCONTROL__
#include <TextEditControl.h>
#endif

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/



#define PRIORITY        kAENormalPriority
#define kTimeOutInTicks (60 * 30)	/* 30 second timeout. */



/*****************************************************************************/



static pascal void	CancelNotify(NMRecPtr nmReqPtr);
static void			GetFullPathAndAppName(StringPtr path, StringPtr app);

static void			GetAppFullPath(StringPtr path);



/*****************************************************************************/



struct triplets{
	AEEventClass		theEventClass;
	AEEventID			theEventID;
	ProcPtr				theHandler;
	AEEventHandlerUPP	theUPP;
};
typedef struct triplets triplets;
static triplets keywordsToInstall[] = {
	{ kCoreEventClass,		kAEAnswer,				DoAEAnswer },
	{ kCustomEventClass,	kibitzAESendGame,		ReceiveGame },
	{ kCustomEventClass,	kibitzAESendMssg,		ReceiveMssg }
};		/* These are the custom AppleEvents. */



/*****************************************************************************/



extern Boolean		gHasAppleEvents;
extern Boolean		gHasPPCToolbox;

extern RgnHandle	gCurrentCursorRgn;
extern Cursor		*gCurrentCursor;

extern short		gMenuMods;



/*****************************************************************************/
/*****************************************************************************/



/* InitCustomAppleEvents
**
** Install our custom AppleEvents.  This is done in addition to installing
** the required AppleEvents.  InitAppleEvents, which installs the required
** AppleEvents, must be called first, since it sets up some global values. */

#pragma segment AppleEvents
void	InitCustomAppleEvents(void)
{
	OSErr	err;
	short	i;

	if (gHasAppleEvents) {
		for (i = 0; i < (sizeof(keywordsToInstall) / sizeof(triplets)); ++i) {

			if (!keywordsToInstall[i].theUPP)
				keywordsToInstall[i].theUPP = NewAEEventHandlerProc(keywordsToInstall[i].theHandler);

			err = AEInstallEventHandler(
				keywordsToInstall[i].theEventClass,	/* What class to install.  */
				keywordsToInstall[i].theEventID,	/* Keywords to install.    */
				keywordsToInstall[i].theUPP,		/* The AppleEvent handler. */
				0L,									/* Unused refcon.		   */
				false								/* Only for our app.	   */
			);

			if (err) {
				Alert(rErrorAlert, gAlertFilterUPP);
				return;
			}
		}
	}
}



/*****************************************************************************/



#pragma segment AppleEvents
pascal OSErr	DoAEAnswer(AppleEvent *message, AppleEvent *reply, long refcon)
{
#pragma unused (refcon)

	OSErr	err;

	gCurrentCursor = nil;
		/* Force re-calc of cursor region and cursor to use. */

	err = ReceiveGameReply(message, reply);

	AEPutParamPtr(				/* RETURN REPLY ERROR, EVEN IF NONE... */
		reply,					/* The AppleEvent. 			 */
		keyReplyErr,			/* AEKeyword				 */
		typeShortInteger,		/* Desired type.			 */
		(Ptr)&err,				/* Pointer to area for data. */ 
		sizeof(short)			/* Size of data area.		 */
	);

	return(noErr);
}



/*****************************************************************************/



/* SendGame
**
** This routine acquires an opponent and sends the opponent the current game.
** Various changes are made to the game record to indicate that this game
** has an opponent, which color we are, where we are located (so the
** opponent can send moves back), the ID of our game, etc.  Once this
** information is in the game record, the game is transmitted to the
** opponent.  Upon receiving the game, the opponent sends back confirmation,
** which also includes the ID of the game on the opponent's end.  The return
** information is sent back as via AEAnswer, so we will extablish a two-player
** game until we receive this event.  Once we do establish a two-player game,
** we will store the opponent's game ID in the game record as well.  With our
** ID and the opponents ID, we will be able to determine which game the data
** is for at both ends.  This allows two opponents to play multiple games with
** the same machines. */

void	TogglePPCPatches(Boolean on);

#pragma segment AppleEvents
OSErr	SendGame(FileRecHndl frHndl, short sendReason, StringPtr nbpType)
{
	AEAddressDesc	locOfOpponent;
	Boolean			twoPlayer;
	OSErr			err;
	AEDescList		sendGameList;
	long			gameID[2], size, timeout;
	char			hstate;
	Ptr				ptr1, ptr2;
	GameListHndl	gameMoves;
	AppleEvent		theAevt, reply;
	short			replyType;
	Str255			macText, appText, opponentName, reconnectPath;
	Str32			reconnectApp;
	Handle			userNameHndl;
	static PPCFilterUPP	kibitzPortFilterUPP;

	sendGameList.dataHandle = theAevt.dataHandle = reply.dataHandle = nil;
		/* Make sure disposing of the descriptors is okay in all cases.
		** This will not be necessary after 7.0b3, since the calls that
		** attempt to create the descriptors will nil automatically
		** upon failure. */

	err = noErr;
		/* We may not make the first operation that can cause an error,
		** so we have to initialize err. */

	locOfOpponent.dataHandle = nil;
		/* Make it safe to dispose of in all cases. */

	if ((*frHndl)->doc.resync < ((*frHndl)->doc.sendReason = sendReason))
		(*frHndl)->doc.resync = sendReason;
			/* Bump up resync, if needed. */

	UpdateTime(frHndl, false);
		/* Make sure timers are current before we give them to opponent. */

	twoPlayer = (*frHndl)->doc.twoPlayer;
	if (!twoPlayer) {			/* If we don't have a live opponent yet... */
		GetIndString(macText, rPPCText, sTitleText);
		GetIndString(appText, rPPCText, sAppText);

		if ((*frHndl)->doc.reconnectZone[0]) {
			for (timeout = TickCount() + 600; timeout > TickCount();) {
				err = GetRemoteProcessTarget(frHndl, &locOfOpponent, KibitzFilter);
				if (err) break;
				if (locOfOpponent.dataHandle) break;
			}
		}
		else {
#ifndef powerc
			if (gMenuMods & shiftKey) TogglePPCPatches(true);
#endif
			if (!kibitzPortFilterUPP)
				kibitzPortFilterUPP = NewPPCFilterProc (KibitzPortFilter);
			err = MakeTarget(&locOfOpponent, false, kAEWaitReply,
				macText, appText, kibitzPortFilterUPP, (char *)nbpType);
					/* Generate the target for our opponent. */
#ifndef powerc
			if (gMenuMods & shiftKey) TogglePPCPatches(false);
#endif
		}

		(*frHndl)->doc.gameID_0      = gameID[0] = (TickCount() & 0xFFFFFFFE);
		(*frHndl)->doc.gameID_1      = gameID[0];
		(*frHndl)->doc.locOfOpponent = locOfOpponent;
	}
	else locOfOpponent = (*frHndl)->doc.locOfOpponent;

	if (!err) {		/* If we have an opponent... */
		err = AECreateList(		/* CREATE THE LIST TO HOLD THE GAME. */
			nil,				/* No factoring.			 */
			0,					/* No factoring.			 */
			false,				/* Not an AppleEvent record. */
			&sendGameList		/* List descriptor.			 */
		);
	}

	if (!err) {		/* If we have an empty list to add to... */
		hstate = LockHandleHigh((Handle)frHndl);
		ptr1   = (Ptr)&((*frHndl)->doc);
		ptr2   = (Ptr)&((*frHndl)->doc.endSendInfo);
		size   = (long)ptr2 - (long)ptr1;
		err = AEPutPtr(		/* ADD BOARD INFO TO THE APPLEEVENT. */
			&sendGameList,	/* List to add to.					 */
			1L,				/* Make this element #1.			 */
			typeTheBoard,	/* It is a descriptor for the board. */
			ptr1,			/* Pointer to the board data.		 */
			size			/* Size of the board data.			 */
		);
		HSetState((Handle)frHndl, hstate);
	}

	/* For a new opponent, the field twoPlayer in sendGameList (to be sent
	** to the opponent) indicates that there is no live opponent.  When the
	** receiver gets a board with twoPlayer false, this indicates a new game
	** is being set up.  If twoPlayer is true, then it is an existing game. */

	if (!err) {		/* If we could add the board info to the list... */
		gameMoves = (*frHndl)->doc.gameMoves;
		size      = (*frHndl)->doc.numGameMoves * sizeof(GameElement);
		hstate    = LockHandleHigh((Handle)gameMoves);
		err = AEPutPtr(			/* ADD GAME MOVES TO THE LIST.			 */
			&sendGameList,		/* List to add to.						 */
			2L,					/* Make this element #2.				 */
			typeGameMoves,		/* Descriptor for the moves of the game. */
			(Ptr)(*gameMoves),	/* Pointer to the move data.			 */
			size				/* Size of the move data.				 */
		);
		HSetState((Handle)gameMoves, hstate);
	}

	if ((!err) && (!twoPlayer)) {
		hstate = LockHandleHigh((Handle)frHndl);
		ptr1   = (Ptr)&((*frHndl)->fileState.fss);
		err = AEPutPtr(			/* ADD FSSpec TO LIST TO PASS THE GAME NAME. */
			&sendGameList,		/* List to add to.		 */
			3L,					/* Make this element #3. */
			typeFSS,			/* FSSpec descriptor.	 */
			ptr1,				/* Pointer to the data.	 */
			sizeof(FSSpec)		/* Size of the data.	 */
		);
		HSetState((Handle)frHndl, hstate);
		if (!err) {
			opponentName[0] = 0;
			if (userNameHndl = GetResource('STR ', -16096))
				pcpy(opponentName, (StringPtr)(*userNameHndl));
			err = AEPutPtr(			/* ADD USER NAME TO LIST. */
				&sendGameList,		/* List to add to.			 */
				4L,					/* Make this element #4.	 */
				typePascal,			/* Pascal string descriptor. */
				(Ptr)opponentName,	/* Pointer to the data.		 */
				opponentName[0] + 1	/* Size of the data.		 */
			);
			if (!err) {
				GetFullPathAndAppName(reconnectPath, reconnectApp);
				err = AEPutPtr(				/* ADD USER NAME TO LIST. */
					&sendGameList,			/* List to add to.			 */
					5L,						/* Make this element #5.	 */
					typePascal2,			/* Pascal string descriptor. */
					(Ptr)reconnectPath,		/* Pointer to the data.		 */
					reconnectPath[0] + 1	/* Size of the data.		 */
				);
				if (!err) {
					err = AEPutPtr(				/* ADD USER NAME TO LIST. */
						&sendGameList,			/* List to add to.			 */
						6L,						/* Make this element #5.	 */
						typePascal3,			/* Pascal string descriptor. */
						(Ptr)reconnectApp,		/* Pointer to the data.		 */
						reconnectApp[0] + 1		/* Size of the data.		 */
					);
				}
			}
		}
	}

	if (!err) {		/* If we could add the game moves to the list... */
		err = AECreateAppleEvent(			/* CREATE EMPTY APPLEEVENT.	 */
			kCustomEventClass,				/* Event class.				 */
			kibitzAESendGame,				/* Event ID.				 */
			&locOfOpponent,					/* Address of receiving app. */
			kAutoGenerateReturnID,			/* This value causes the	 */
											/* AppleEvent manager to	 */
											/* assign a return ID that	 */
											/* is unique to the session. */
			kAnyTransactionID,				/* Ignore transaction ID.	 */
			&theAevt						/* Location of event.		 */
		);
	}

	if (!err) {		/* If we have an empty AppleEvent... */
		err = AEPutParamDesc(	/* PUT THE LIST INTO THE APPLEEVENT.  */
			&theAevt,			/* AppleEvent to add list to.		  */
			keyDirectObject,	/* This is our direct (only) object.  */
			&sendGameList		/* The list to add to the AppleEvent. */
		);
	}

	replyType = (!twoPlayer) ? kAEQueueReply : kAENoReply;
		/* Queue a reply only for a new game. */

	if (!err) {		/* If we have an AppleEvent ready to send... */
		err = AESend(		/* SEND APPLEEVENT.				*/
			&theAevt,		/* Our Apple Event to send.		*/
			&reply,			/* We may have a reply.			*/
			replyType,		/* Type of reply.				*/
			PRIORITY,		/* App. send priority.			*/
			0,				/* We aren't waiting.			*/
			nil,			/* We aren't waiting.			*/
			nil				/* EventFilterProcPtr.			*/
		);
	}
	if (replyType == kAEQueueReply)
		if (locOfOpponent.descriptorType == typeProcessSerialNumber)
			err = ReceiveGameReply(&reply, &reply);
				/* If we want a queue reply, and if we are sending to ourselves,
				** then we already have the reply.  Since we are sending to
				** ourselves, we don't have to wait for an event.  Stuff happens
				** right away.  We're (probably) happy. */

	AEDisposeDesc(&sendGameList);
	AEDisposeDesc(&theAevt);
	AEDisposeDesc(&reply);
		/* Dispose of the descriptors, created or not.
		** If not created, no harm done by calling. */

	if (err) {
		AEDisposeDesc(&locOfOpponent);
			/* If we didn't connect, get rid of the target descriptor. */

		(*frHndl)->doc.gameID_0 = 0;
		(*frHndl)->doc.gameID_1 = 0;
			/* Mark this window so that it will never be found if we somehow
			** do get an answer from the receiver, even after failure. */
	}

	return(err);
}



/*****************************************************************************/



/* This code is executed only after an game is initially sent and we receive
** an AEAnswer event.  The "answer" is acknowledgment that the opponent
** received the game and that the opponent is set up for a two-player game.
** In the reply, we receive the opponent's game ID, which is used to match
** up which game receives the AppleEvents. */

#pragma segment AppleEvents
pascal OSErr	ReceiveGameReply(AppleEvent *message, AppleEvent *reply)
{
#pragma unused (reply)

	OSErr			err, replyErr;
	DescType		actualType;
	long			gameID[2], actualSize, mssgSize;
	char			hstate;
	WindowPtr		window;
	FileRecHndl		frHndl;
	Handle			mssgData;
	Str32			opponentName, zone, machine, application;
	Str255			reconnectPath;
	Str32			reconnectApp;
	AEAddressDesc	locOfOpponent;
	short			txFont, txSize;
	Style			txFace;
	WindowPtr		oldPort, curPort;

	err = AEGetParamPtr(		/* CHECK FOR A RECEIVER ERROR... */
		message,				/* The AppleEvent. 			 */
		keyReplyErr,			/* AEKeyword				 */
		typeShortInteger,		/* Desired type.			 */
		&actualType,			/* Type code.				 */
		(Ptr)&replyErr,			/* Pointer to area for data. */ 
		sizeof(short),			/* Size of data area.		 */
		&actualSize				/* Returned size of data.	 */
	);
	if (!err) err = replyErr;

	if (!err) {
		err = AEGetParamPtr(	/* GET RECEIVER GAME ID. */
			message,			/* The AppleEvent. 			 */
			keyGameID,			/* AEKeyword				 */
			typeDoubleLong,		/* Desired type.			 */
			&actualType,		/* Type code.				 */
			(Ptr)&gameID[0],	/* Pointer to area for data. */ 
			2 * sizeof(long),	/* Size of data area.		 */
			&actualSize			/* Returned size of data.	 */
		);
	}

	if (!err) {		/* If we got the receiver game ID... */

		window = GetGameWindow(gameID[1], gameID[1]);
			/* The ID's are still both ours, since this is where we
			** get the receiver's ID returned.  gameID[0] holds the
			** receiver's ID, and gameID[1] holds ours. */

		if (window) {
			frHndl = (FileRecHndl)GetWRefCon(window);
			if (!(*frHndl)->doc.twoPlayer) {
				err = AEGetParamPtr(
					message,			/* The AppleEvent. 			 */
					keyPascalReply,		/* AEKeyword				 */
					typePascal,			/* Desired type.			 */
					&actualType,		/* Type code.				 */
					(Ptr)opponentName,	/* Pointer to area for data. */ 
					sizeof(Str32),		/* Size of data area.		 */
					&actualSize			/* Returned size of data.	 */
				);

				(*frHndl)->doc.opponentName[0] = 0;
				if (!err) {
					(*frHndl)->doc.gameID_1 = gameID[0];
					pcpy(&(*frHndl)->doc.opponentName[0], opponentName);
					SetOpponentType(frHndl, kTwoPlayer);
					locOfOpponent = (*frHndl)->doc.locOfOpponent;
					zone[0] = machine[0] = 0;
					GetTargetInfo(locOfOpponent, zone, machine, application);
					pcpy(&(*frHndl)->doc.opponentZone[0], zone);
					pcpy(&(*frHndl)->doc.opponentMachine[0], machine);

					err = AEGetParamPtr(
						message,			/* The AppleEvent. 			 */
						keyPascal2Reply,	/* AEKeyword				 */
						typePascal2,		/* Desired type.			 */
						&actualType,		/* Type code.				 */
						(Ptr)reconnectPath,	/* Pointer to area for data. */ 
						sizeof(Str255),		/* Size of data area.		 */
						&actualSize			/* Returned size of data.	 */
					);
					(*frHndl)->doc.reconnectPath[0] = 0;
					if (!err) pcpy(&(*frHndl)->doc.reconnectPath[0], reconnectPath);

					err = AEGetParamPtr(
						message,			/* The AppleEvent. 			 */
						keyPascal3Reply,	/* AEKeyword				 */
						typePascal3,		/* Desired type.			 */
						&actualType,		/* Type code.				 */
						(Ptr)reconnectApp,	/* Pointer to area for data. */ 
						sizeof(Str32),		/* Size of data area.		 */
						&actualSize			/* Returned size of data.	 */
					);
					(*frHndl)->doc.reconnectApp[0] = 0;
					if (!err) pcpy(&(*frHndl)->doc.reconnectApp[0], reconnectApp);

					if (!err) {
						err = AEGetParamPtr(
							message,				/* The AppleEvent. 			 */
							keyTextMessage,			/* AEKeyword				 */
							typeMssg,				/* Desired type.			 */
							&actualType,			/* Type code.				 */
							nil,					/* Pointer to area for data. */ 
							0,						/* Size of data area.		 */
							&mssgSize				/* Returned size of data.	 */
						);
					}
					mssgData = nil;
					if (!err) {		/* Get the data... */
						mssgData = NewHandle(mssgSize);
						if (mssgData) {
							hstate = LockHandleHigh(mssgData);
							err = AEGetParamPtr(
								message,				/* The AppleEvent. 			 */
								keyTextMessage,			/* AEKeyword				 */
								typeMssg,				/* Desired type.			 */
								&actualType,			/* Type code.				 */
								*mssgData,				/* Pointer to area for data. */ 
								mssgSize,				/* Size of data area.		 */
								&actualSize				/* Returned size of data.	 */
							);
						}
						else err = memFullErr;
					}
					if (!err) {
						oldPort = SetFilePort(frHndl);
						GetPort(&curPort);
						txFont = curPort->txFont;
						txSize = curPort->txSize;
						txFace = curPort->txFace;
						TextFont(applFont);
						TextSize(9);
						TextFace(normal);
						mssgData = CTESwapText((*frHndl)->doc.message[kMessageIn],
												mssgData, nil, true);
						TextFont(txFont);
						TextSize(txSize);
						TextFace(txFace);
						SetPort(oldPort);
					}
					if (mssgData) DisposHandle(mssgData);

					if (err == errAEDescNotFound) err = noErr;
				}
				if (err) (*frHndl)->doc.gameID_0 = (*frHndl)->doc.gameID_1 = 0;
				else GetDateTime(&((*frHndl)->doc.timeLastReceive));
			}
		}
	}

	return(err);
}



/*****************************************************************************/



/* ReceiveGame
**
** This routine receives a board from an opponent.  It receives it for various
** purposes.  These are:
**   1) Establishing a new game.
**   2) Receiving a move.
**   3) Receiving a new board position, due to scrolling.
**
** Establishing a new game is determined by the fact that the value twoPlayer
** is false.  If it is a previously established game, then this field is true.
**
** If it is a previously established game, then whether or not it is a new move
** is determined by field "sendReason".  If sendReason != kIsMove, then it is some
** other change, such as scrolling or resyncing by of the sender.
** These other cases should not cause a win/loss/tie dialog to appear.
**
** If it is a regular move, (sendReason == kIsMove), then the win/loss/draw dialogs
** should be displayed, if the game is indeed over after the move. */

#pragma segment AppleEvents
pascal OSErr	ReceiveGame(AppleEvent *message, AppleEvent *reply, long refcon)
{
#pragma unused (refcon)

	OSErr			err;
	FileRecHndl		frHndl, newFrHndl, oldFrHndl, mssgFrHndl;
	FileRecPtr		frPtr;
	AEDescList		receiveGameList;
	char			hstate;
	Ptr				ptr1, ptr2;
	long			size, gameID[2];
	Boolean			twoPlayer;
	AEAddressDesc	senderTarget;
	AEKeyword		ignoredKeyWord;
	DescType		ignoredType;
	Size			ignoredSize;
	GameListHndl	gameMoves;
	WindowPtr		oldPort, window, fwindow, behindWindow;
	WindowPeek		wpeek;
	FSSpec			myFSS;
	Str32			opponentName, zone, machine, application;
	Str255			reconnectPath;
	Str32			reconnectApp;
	Handle			userNameHndl, hText;
	short			i, drawBtnState, sendReason, myColor, invertBoard, fromSq, toSq;
	GameListHndl	oldGame, newGame;
	GameElement		*optr, *nptr;
	short			oldGameIndex, newGameIndex, oldNumMoves, newNumMoves, identical;
	TEHandle		te;

	err = noErr;
	AEPutParamPtr(				/* RETURN REPLY ERROR, EVEN IF NONE... */
		reply,					/* The AppleEvent. 			 */
		keyReplyErr,			/* AEKeyword				 */
		typeShortInteger,		/* Desired type.			 */
		(Ptr)&err,				/* Pointer to area for data. */ 
		sizeof(short)			/* Size of data area.		 */
	);

	receiveGameList.dataHandle = nil;
		/* Make sure disposing of the descriptors is okay in all cases.
		** This will not be necessary after 7.0b3, since the calls that
		** attempt to create the descriptors will nil automatically
		** upon failure. */

	IncNewFileNum(false);
	err = AppNewDocument(&newFrHndl, ksOrigName);
	IncNewFileNum(true);

	if (err) return(err);

	/* We have a new document... */
	err = AEGetParamDesc(	/* GET THE APPLEEVENT LIST.  */
		message,			/* AppleEvent to holding list.		  */
		keyDirectObject,	/* This is our direct (only) object.  */
		typeWildCard,		/* Desired type is game list.		  */
		&receiveGameList	/* The list to add to the AppleEvent. */
	);

	if (!err) {		/* If we got the list descriptor... */
		hstate = LockHandleHigh((Handle)newFrHndl);
		ptr1   = (Ptr)&((*newFrHndl)->doc);
		ptr2   = (Ptr)&((*newFrHndl)->doc.endSendInfo);
		size   = (long)ptr2 - (long)ptr1;
		err = AEGetNthPtr(		/* GET BOARD INFO FROM THE LIST.	 */
			&receiveGameList,	/* List to get from.				 */
			1L,					/* Get first item in list.			 */
			typeTheBoard,		/* First item is the board.			 */
			&ignoredKeyWord,	/* Returned keyword -- we know.		 */
			&ignoredType,		/* Returned type -- we know.		 */
			ptr1,				/* Where to put the board info.		 */
			size,				/* Size of the board.				 */
			&ignoredSize		/* Actual size -- we know.			 */
		);
		HSetState((Handle)newFrHndl, hstate);
	}

	if (!err) {		/* If we got the board... */
		gameMoves = (*newFrHndl)->doc.gameMoves;
		size      = (*newFrHndl)->doc.numGameMoves * sizeof(GameElement);
		SetHandleSize((Handle)gameMoves, size);
		err = MemError();
		if (!err) {
			hstate = LockHandleHigh((Handle)gameMoves);
			err = AEGetNthPtr(		/* GET GAME MOVES FROM THE LIST.	 */
				&receiveGameList,	/* List to get from.				 */
				2L,					/* Get second item in list.			 */
				typeGameMoves,		/* Second item is the game moves.	 */
				&ignoredKeyWord,	/* Returned keyword -- we know.		 */
				&ignoredType,		/* Returned type -- we know.		 */
				(Ptr)(*gameMoves),	/* Where to put the moves.			 */
				size,				/* Size of the board.				 */
				&ignoredSize		/* Actual size -- we know.			 */
			);
			HSetState((Handle)gameMoves, hstate);
		}
	}



	if (!err) {

		/* We now have the board and game moves, in newFrHndl.  This is either a
		** new opponent, or an update from an old opponent.  Let's see... */

		twoPlayer = (*newFrHndl)->doc.twoPlayer;
		(*newFrHndl)->doc.twoPlayer = false;
			/* See if this is an already existing opponent, or a new one. */
	
		if (!twoPlayer) {		/* If new game... */
			err = AEGetAttributeDesc(	/* GET ADDRESS OF NEW OPPONENT.	 */
				message,				/* Get address of sender from message.		 */
				keyAddressAttr,			/* We want an address.						 */
				typeWildCard,			/* We want the address of the sender.		 */
				&senderTarget			/* Address of sender.						 */
			);
			if (!err) {
				(*newFrHndl)->doc.twoPlayer     = true;
				(*newFrHndl)->doc.arrangeBoard  = false;
				(*newFrHndl)->doc.locOfOpponent = senderTarget;
				err = AEGetNthPtr(		/* GET FSSpec (FOR GAME NAME) FROM LIST. */
					&receiveGameList,	/* List to get from.			*/
					3L,					/* Get second item in list.		*/
					typeFSS,			/* Third item is the FSSpec.	*/
					&ignoredKeyWord,	/* Returned keyword -- we know. */
					&ignoredType,		/* Returned type -- we know.	*/
					(Ptr)&myFSS,		/* Where to put the FSSpec.		*/
					sizeof(FSSpec),		/* Size of the data.			*/
					&ignoredSize		/* Actual size -- we know.		*/
				);
				if (!err)
					pcpy((*newFrHndl)->fileState.fss.name, myFSS.name);
			}
			if (!err) {
				err = AEGetNthPtr(		/* GET FSSpec (FOR GAME NAME) FROM LIST. */
					&receiveGameList,	/* List to get from.				*/
					4L,					/* Get second item in list.			*/
					typePascal,			/* Third item is the opponent name.	*/
					&ignoredKeyWord,	/* Returned keyword -- we know. 	*/
					&ignoredType,		/* Returned type -- we know.		*/
					(Ptr)opponentName,	/* Where to put the opponent name.	*/
					sizeof(Str32),		/* Size of the data.				*/
					&ignoredSize		/* Actual size.						*/
				);
				(*newFrHndl)->doc.opponentName[0] = 0;
				if (!err) {
					pcpy((*newFrHndl)->doc.opponentName, opponentName);
					zone[0] = machine[0] = 0;
					GetTargetInfo(senderTarget, zone, machine, application);
					pcpy((*newFrHndl)->doc.opponentZone, zone);
					pcpy((*newFrHndl)->doc.opponentMachine, machine);
					GetDateTime(&((*newFrHndl)->doc.timeLastReceive));
				}
				if (!err) {
					err = AEGetNthPtr(		/* GET FSSpec (FOR GAME NAME) FROM LIST. */
						&receiveGameList,	/* List to get from.				*/
						5L,					/* Get second item in list.			*/
						typePascal2,		/* Third item is the opponent name.	*/
						&ignoredKeyWord,	/* Returned keyword -- we know. 	*/
						&ignoredType,		/* Returned type -- we know.		*/
						(Ptr)reconnectPath,	/* Where to put the opponent name.	*/
						sizeof(Str255),		/* Size of the data.				*/
						&ignoredSize		/* Actual size.						*/
					);
					(*newFrHndl)->doc.reconnectPath[0] = 0;
					if (!err) pcpy((*newFrHndl)->doc.reconnectPath, reconnectPath);
				}
				if (!err) {
					err = AEGetNthPtr(		/* GET FSSpec (FOR GAME NAME) FROM LIST. */
						&receiveGameList,	/* List to get from.				*/
						6L,					/* Get second item in list.			*/
						typePascal3,		/* Third item is the opponent name.	*/
						&ignoredKeyWord,	/* Returned keyword -- we know. 	*/
						&ignoredType,		/* Returned type -- we know.		*/
						(Ptr)reconnectApp,	/* Where to put the opponent name.	*/
						sizeof(Str32),		/* Size of the data.				*/
						&ignoredSize		/* Actual size.						*/
					);
					(*newFrHndl)->doc.reconnectApp[0] = 0;
					if (!err) pcpy((*newFrHndl)->doc.reconnectApp, reconnectApp);
				}
			}
		}
	}

	if (!err) {		/* If we got the opponent address... */

		if (!twoPlayer) {		/* It is a new game... */

			(*newFrHndl)->doc.timerRefTick = TickCount();
				/* Set the timer reference early as possible.
				** This syncs the two clocks as much as possible. */

				/* For a new opponent, then we need to ID the receiver side
				** of the sender/receiver ID pair.  We also need to send
				** back the receiver portion of the ID pair for the sender. */

			(*newFrHndl)->doc.gameID_0 = gameID[0] = (TickCount() | 0x01);
			(*newFrHndl)->doc.myColor     ^= 1;
			(*newFrHndl)->doc.invertBoard ^= 1;
				/* We are the opposite color/side as the opponent. */

			if ((*newFrHndl)->doc.version != kVersion) err = errAEWrongDataType;
				/* Incompatible file format. */

			if (!err) {
				gameID[1] = (*newFrHndl)->doc.gameID_1;
				err = AEPutParamPtr(	/* RETURN RECEIVER GAME ID.	 */
					reply,				/* The AppleEvent. 			 */
					keyGameID,			/* AEKeyword				 */
					typeDoubleLong,		/* Type code.				 */
					(Ptr)&gameID[0],	/* Pointer to area for data. */ 
					2 * sizeof(long)	/* Size of data area.		 */
				);
			}

			if (!err) {
				opponentName[0] = 0;
				if (userNameHndl = GetResource('STR ', -16096))
					pcpy(opponentName, (StringPtr)(*userNameHndl));
				err = AEPutParamPtr(	/* RETURN RECEIVER GAME ID.	 */
					reply,				/* The AppleEvent. 			 */
					keyPascalReply,		/* AEKeyword				 */
					typePascal,			/* Type code.				 */
					(Ptr)opponentName,	/* Pointer to area for data. */ 
					opponentName[0] + 1	/* Size of data area.		 */
				);
			}

			if (!err) {
				GetFullPathAndAppName(reconnectPath, reconnectApp);
				err = AEPutParamPtr(		/* RETURN RECEIVER GAME ID.	 */
					reply,					/* The AppleEvent. 			 */
					keyPascal2Reply,		/* AEKeyword				 */
					typePascal2,			/* Type code.				 */
					(Ptr)reconnectPath,		/* Pointer to area for data. */ 
					reconnectPath[0] + 1	/* Size of data area.		 */
				);
				if (!err) {
					err = AEPutParamPtr(		/* RETURN RECEIVER GAME ID.	 */
						reply,					/* The AppleEvent. 			 */
						keyPascal3Reply,		/* AEKeyword				 */
						typePascal3,			/* Type code.				 */
						(Ptr)reconnectApp,		/* Pointer to area for data. */ 
						reconnectApp[0] + 1	/* Size of data area.		 */
					);
				}
			}

			if (!err) {
				if (IsAppWindow(fwindow = FrontWindow())) {
					frPtr = *(frHndl = (FileRecHndl)GetWRefCon(fwindow));
					if (
						(frPtr->doc.myColor != kMessageDoc) &&
						(!(frPtr->doc.arrangeBoard)) &&
						(!(frPtr->doc.twoPlayer)) &&
						(!(frPtr->doc.numGameMoves)) &&
						(!(frPtr->doc.gameID_0)) &&
						(!(frPtr->doc.timeLastReceive))
					) {
						AppDisposeDocument(frHndl);
						DisposeAnyWindow(fwindow);
					}
				}
				behindWindow = (WindowPtr)-1;
				for (wpeek = LMGetWindowList(); wpeek; wpeek = wpeek->nextWindow) {
					if (IsAppWindow((WindowPtr)wpeek)) {
						frPtr = *(FileRecHndl)GetWRefCon((WindowPtr)wpeek);
						if (
							(frPtr->doc.myColor != kMessageDoc) &&
							(!(frPtr->doc.arrangeBoard)) &&
							(!(frPtr->doc.twoPlayer)) &&
							(!(frPtr->doc.numGameMoves))
						) break;
						behindWindow = (WindowPtr)wpeek;
					}
				}
				err = AppNewWindow(newFrHndl, nil, behindWindow);
			}

				/* If everything worked for new opponent, give the new document a window. */

			if (!err) {
				AdjustGameSlider(newFrHndl);

				DrawButtonTitle(newFrHndl, kTwoPlayer);
					/* Convert the draw button to two player. */

				(*newFrHndl)->doc.gotUpdateTick = TickCount();
					/* Record when we got the event. */

				fwindow = FrontWindow();
				mssgFrHndl = (FileRecHndl)GetWRefCon((WindowPtr)fwindow);
				if ((*mssgFrHndl)->doc.myColor == kMessageDoc) {
					te     = (*mssgFrHndl)->doc.message[kMessageOut];
					hText  = (*te)->hText;
					hstate = LockHandleHigh(hText);
					size   = (*te)->teLength;
					err = AEPutParamPtr(
						reply,
						keyTextMessage,
						typeMssg,
						*hText,
						size
					);
					HSetState(hText, hstate);
				}
			}
		}
		else {		/* It is an update to an existing game. */

			window = GetGameWindow(
				(*newFrHndl)->doc.gameID_1, (*newFrHndl)->doc.gameID_0);
					/* Get the window for the existing game. */

			if (window) {		/* This game still exists... */

				oldFrHndl = (FileRecHndl)GetWRefCon(window);
				UpdateTime(oldFrHndl, false);

				if ((*oldFrHndl)->doc.resync < (sendReason = (*newFrHndl)->doc.sendReason))
					(*oldFrHndl)->doc.resync = sendReason;
						/* Bump up resync, if needed. */

				if (sendReason == kScrolling) {
					if (
						((*oldFrHndl)->doc.resync == kResync) || 
						((*oldFrHndl)->doc.gotUpdateTick + 30 > TickCount())
					) {
						window = nil;
						AppDisposeDocument(newFrHndl);
								/* Temporary document now gone. */
					}	/* If it has been less than 1/2 second since the last
						** scroll update received, or if the user has finished
						** scrolling, then we can ignore this scroll event.
						** This keeps us from getting behind in the processing
						** of scroll events. */
				}
			}
			else
				err = memFullErr;
					/* Can't find the old window, so cause some kind of error. */

			if (window) {		/* This game still exists... */

				if (sendReason != kIsMove) {
					for (i = 0; i < 2; ++i)
						(*newFrHndl)->doc.timeLeft[i] = (*oldFrHndl)->doc.timeLeft[i];
							/* Keep our clock values if opponent is scrolling or resyncing. */
				}

				frPtr        = *oldFrHndl;
				oldGameIndex = frPtr->doc.gameIndex;
				oldNumMoves  = frPtr->doc.numGameMoves;
				oldGame      = frPtr->doc.gameMoves;
				frPtr        = *newFrHndl;
				newGameIndex = frPtr->doc.gameIndex;
				newNumMoves  = frPtr->doc.numGameMoves;
				newGame      = frPtr->doc.gameMoves;
				if ((oldGameIndex == newGameIndex) && (oldNumMoves == newNumMoves)) {
					optr = &(**oldGame)[0];
					nptr = &(**newGame)[0];
					identical = true;
					for (i = 0; i < oldNumMoves; ++i, ++optr, ++nptr) {
						if (
							(optr->moveFrom          != nptr->moveFrom) ||
							(optr->moveTo            != nptr->moveTo) ||
							(optr->pieceCaptured     != nptr->pieceCaptured) ||
							(optr->pieceCapturedFrom != nptr->pieceCapturedFrom) ||
							(optr->promoteTo         != nptr->promoteTo)
						) {
							identical = false;
							break;
						}
					}
				}
				else identical = false;

				myColor     = (*oldFrHndl)->doc.myColor;
				invertBoard = (*oldFrHndl)->doc.invertBoard;
					/* These need to be saved, so they are in that section,
					** but they are private info, so cache them. */

				ptr1 = (Ptr)&((*newFrHndl)->doc);
				ptr2 = (Ptr)&((*newFrHndl)->doc.endFileInfo1);
				size = (long)ptr2 - (long)ptr1;
				ptr2 = (Ptr)&((*oldFrHndl)->doc);
				BlockMove(ptr1, ptr2, size);

				(*oldFrHndl)->doc.myColor     = myColor;
				(*oldFrHndl)->doc.invertBoard = invertBoard;
					/* Restore our private cached values. */

				(*newFrHndl)->doc.gameMoves = (*oldFrHndl)->doc.gameMoves;
				(*oldFrHndl)->doc.gameMoves = gameMoves;
					/* Swap the game move handles.  The existing document
					** is now updated completely.  We can dispose of the
					** temporary new one.  (gameMoves is set above for
					** the handle for the new document.) */

				i = (*newFrHndl)->doc.drawBtnState;
				drawBtnState = kTwoPlayer;
				if (i & 0x02) drawBtnState |= 0x04;
				if (i & 0x04) drawBtnState |= 0x02;

				AppDisposeDocument(newFrHndl);
					/* Temporary document now gone. */

				GetPort(&oldPort);
				SetPort(window);

				if (!identical) {		/* There was a change, so show it. */
					if (sendReason == kIsMove) {
					if (GetCtlValue((*oldFrHndl)->doc.beepOnMove)) SysBeep(1);
						if (GameStatus(oldFrHndl) <= kDrawByRep) {
							MakeMove(oldFrHndl, -1, 0, 0);
							oldGame      = (*oldFrHndl)->doc.gameMoves;
							oldGameIndex = (*oldFrHndl)->doc.gameIndex;
							fromSq = (**oldGame)[oldGameIndex].moveFrom;
							toSq   = (**oldGame)[oldGameIndex].moveTo;
							SlideThePiece(oldFrHndl, fromSq, toSq);
							MakeMove(oldFrHndl, 1, 0, 0);
							SayTheMove(oldFrHndl);
						}
					}
					ImageDocument(oldFrHndl, true);
					AdjustGameSlider(oldFrHndl);
				}

				DrawButtonTitle(oldFrHndl, drawBtnState);
				UpdateGameStatus(oldFrHndl);
					/* Update the text of the draw button. */

				DrawTime(oldFrHndl);

				(*oldFrHndl)->doc.gotUpdateTick = TickCount();
					/* Record when we got the event. */

				if (sendReason == kIsMove) {
					(*oldFrHndl)->fileState.docDirty = true;
					AlertIfGameOver(oldFrHndl);
						/* For non-moves, we don't want to beep or
						** show a game-over dialog. */
				}
				SetPort(oldPort);
			}
		}
	}

	if (err) AppDisposeDocument(newFrHndl);
		/* This won't get done twice, even though there is an
		** AppDisposeDocument(newFrHndl) earlier.  The earlier
		** one only happens if no error occured, and this one
		** only happens on an error condition. */

	AEDisposeDesc(&receiveGameList);
		/* Dispose of the descriptors, created or not.
		** If not created, no harm done by calling. */

	if (!err) NotifyUser();
	return(err);
}



/*****************************************************************************/



/* Send one of various messages to the opponent.  There is a common set of
** data that needs to be sent so that the opponent can determine which game
** the message should be applied.  Then there is message-specific data that
** is handled case by case.  Once the message is completed, it is sent off
** to the opponent.  The additional task of updating the state of our game
** is also handled here.  For example:  When text is sent, the text on our
** machine is selected to make it easier to replace the old text with new
** text.  Any typing by the user will replace the selected text (all the text)
** with the newly typed text.  */

#pragma segment AppleEvents
Boolean	SendMssg(FileRecHndl frHndl, short messageType)
{
	AEAddressDesc	locOfOpponent;
	OSErr			err;
	TEHandle		teIn, teOut;
	char			hstate;
	AppleEvent		theAevt, reply;
	Handle			hText, snd, intxt, outtxt;
	RgnHandle		oldClip, newClip;
	TextStyle		styl;
	long			size, gameID[2], time[2];
	short			i, inlen, outlen, overflow;
	Boolean			twoPlayer;
	WindowPtr		oldPort, curPort;
	Point			pt;
	short			txFont, txSize;
	Style			txFace;

	oldPort = SetFilePort(frHndl);
	GetPort(&curPort);

	theAevt.dataHandle = reply.dataHandle = nil;
		/* Make sure disposing of the descriptors is okay in all cases.
		** This will not be necessary after 7.0b3, since the calls that
		** attempt to create the descriptors will nil automatically
		** upon failure. */

	err = noErr;

	if (twoPlayer = (*frHndl)->doc.twoPlayer) {

		locOfOpponent = (*frHndl)->doc.locOfOpponent;

		err = AECreateAppleEvent(		/* CREATE EMPTY APPLEEVENT.	 */
			kCustomEventClass,			/* Event class.				 */
			kibitzAESendMssg,			/* Event ID.				 */
			&locOfOpponent,				/* Address of receiving app. */
			kAutoGenerateReturnID,		/* This value causes the	 */
										/* AppleEvent manager to	 */
										/* assign a return ID that	 */
										/* is unique to the session. */
			kAnyTransactionID,			/* Ignore transaction ID.	 */
			&theAevt					/* Location of event.		 */
		);

		if (!err) {			/* Say what the message is. */
			AEPutParamPtr(
				&theAevt,
				keyDirectObject,
				typeShortInteger,
				(Ptr)&messageType,
				sizeof(short)
			);
		}

		if (!err) {			/* Say what window message is for. */
			gameID[0] = (*frHndl)->doc.gameID_0;
			gameID[1] = (*frHndl)->doc.gameID_1;
			AEPutParamPtr(
				&theAevt,
				keyGameID,
				typeDoubleLong,
				(Ptr)&gameID[0],
				2 * sizeof(long)
			);
		}
	}

	/* The stuff that applies to all messages is now done.  Now specifically
	** handle all the different message types. */

	if (!err) {
		switch (messageType) {

			case kAmWhiteMssg:
			case kAmBlackMssg:
				(*frHndl)->doc.configColor       = messageType;
				(*frHndl)->doc.configColorChange = true;
				(*frHndl)->doc.resync            = kHandResync;
					/* The AppleEvent already has all the data the opponent
					** needs.  Post that a color change is happening.  The
					** reason that it is posted, instead of immediately applied,
					** is that we want to make sure that the opponent isn't
					** doing a color change operation at the same time.  The
					** color change will only occur when we get a NULL event.
					** The NULL event indicates that the opponent isn't sending
					** any AppleEvents at that time.  Waiting for quiescence
					** helps prevent the state of the game from getting
					** confused.  Also, the creator of the game echos the
					** color change, just to make sure that both machines are
					** in the same state.  (The echo doesn't occur until
					** there are no other AppleEvents happening.  This helps
					** keep the number of AppleEvents down, as well.) */
				break;

			case kDisconnectMssg:
					/* All the information we need is already in the AppleEvent. */
				break;

			case kTimeMssg:
				for (i = 0; i < 2; ++i)
					time[i] = (*frHndl)->doc.configTime[i] = (*frHndl)->doc.timeLeft[i];
				if (twoPlayer) {
					err = AEPutParamPtr(
						&theAevt,
						keyTime,
						typeDoubleLong,
						(Ptr)&time[0],
						2 * sizeof(long)
					);
					if ((*frHndl)->doc.resync)
						(*frHndl)->doc.configTimeChange = true;
					else {
						for (i = 0; i < 2; ++i)
							(*frHndl)->doc.timeLeft[i] =
								(*frHndl)->doc.displayTime[i] =
									(*frHndl)->doc.configTime[i];
						UpdateTime(frHndl, false);
						DrawTime(frHndl);
					}
				}
				break;

			case kTextMssg:
				if (twoPlayer) {
					teOut  = (*frHndl)->doc.message[kMessageOut];
					hText  = (*teOut)->hText;
					hstate = LockHandleHigh(hText);
					size   = (*teOut)->teLength;
					err = AEPutParamPtr(
						&theAevt,
						keyTextMessage,
						typeMssg,
						*hText,
						size
					);
					HSetState(hText, hstate);
				}
				break;

			case kSoundMssg:
				if (twoPlayer) {
					if (snd = (*frHndl)->doc.sound) {
						hstate = LockHandleHigh(snd);
						size   = GetHandleSize(snd);
						err = AEPutParamPtr(
							&theAevt,
							keySoundMessage,
							typeMssg,
							*snd,
							size
						);
						HSetState(snd, hstate);
					}
				}
				break;
		}
	}

	if (twoPlayer) {
		if (!err) {		/* If everything looks good... */
			err = AESend(				/* SEND APPLEEVENT.				 */
				&theAevt,				/* Our Apple Event to send.		 */
				&reply,					/* We may have a reply.			 */
				kAENoReply,				/* Don't wait for reply.		 */
				PRIORITY,				/* App. send priority.			 */
				0,						/* We aren't waiting.			 */
				nil,					/* We don't wait, so no idleProc */
				nil						/* EventFilterProcPtr.			 */
			);
		}
		if (!err) {
			switch (messageType) {
				case kTextMssg:
					styl.tsFont = applFont;

					teIn   = (*frHndl)->doc.message[kMessageIn];
					intxt  = (*teIn)->hText;

					txFont = curPort->txFont;
					txSize = curPort->txSize;
					txFace = curPort->txFace;
					TextFont(styl.tsFont);
					TextSize(9);
					TextFace(normal);
					outtxt = CTESwapText(teOut, NewHandle(0), nil, true);
					TextFont(txFont);
					TextSize(txSize);
					TextFace(txFace);

					inlen  = (*teIn)->teLength;
					outlen = GetHandleSize(outtxt);

					GetClip(oldClip = NewRgn());
					SetClip(newClip = NewRgn());

					overflow = inlen + outlen - 31998;
					if (overflow > 0) {
						if (overflow > inlen) overflow = inlen;
						TESetSelect(0, overflow, teIn);
						TEDelete(teIn);
						inlen -= overflow;
					}

					inlen = (*teIn)->teLength;
					TESetSelect(inlen, inlen, teIn);
					if ((inlen) && (outlen < 31998)) {
						i = ((*intxt)[inlen - 1] == 13) ? 1 : 2;
						for (;i--;) {
							TEKey(13, teIn);
							++inlen;
						}
						styl.tsSize = 4;
						TESetSelect(inlen - 1, inlen, teIn);
						TESetStyle((doFont | doSize), &styl, false, teIn);
						TESetSelect(inlen, inlen, teIn);
					}

					HLock(outtxt);
					TEInsert(*outtxt, outlen, teIn);
					DisposeHandle(outtxt);

					TESetSelect(inlen, (*teIn)->teLength, teIn);

					styl.tsFace = italic;
					styl.tsSize = 9;
					TESetStyle((doFont | doFace | doSize), &styl, false, teIn);

					TECalText(teIn);
					pt = TEGetPoint(inlen, teIn);
					pt.v -= 12;
					TEScroll(0, (*teIn)->viewRect.top - pt.v, teIn);

					SetClip(oldClip);
					DisposeRgn(oldClip);
					DisposeRgn(newClip);

					CTEUpdate(teIn, CTEViewFromTE(teIn), false);
					CTEAdjustTEBottom(teIn);
					CTEAdjustScrollValues(teIn);

					break;

				case kSoundMssg:
					SndPlay(nil, (*frHndl)->doc.sound, false);
					break;
			}
		}

		AEDisposeDesc(&theAevt);
		AEDisposeDesc(&reply);
			/* Dispose of the descriptors, created or not.
			** If not created, no harm done by calling. */
	}

	SetPort(oldPort);
	return(err);
}



/*****************************************************************************/



#pragma segment AppleEvents
pascal OSErr	ReceiveMssg(AppleEvent *message, AppleEvent *reply, long refcon)
{
#pragma unused (refcon)

	OSErr			err;
	long			gameID[2], time[2];
	short			messageType, i, inlen, outlen, overflow;
	WindowPtr		oldPort, window;
	FileRecHndl		frHndl;
	DescType		actualType;
	long			actualSize, mssgSize;
	unsigned long	key;
	char			hstate;
	Handle			mssgData, intxt, outtxt;
	AEAddressDesc	locOfOpponent;
	RgnHandle		oldClip, newClip;
	TEHandle		teIn;
	TextStyle		styl;
	Point			pt;

	err = noErr;
	AEPutParamPtr(				/* RETURN REPLY ERROR, EVEN IF NONE... */
		reply,					/* The AppleEvent. 			 */
		keyReplyErr,			/* AEKeyword				 */
		typeShortInteger,		/* Desired type.			 */
		(Ptr)&err,				/* Pointer to area for data. */ 
		sizeof(short)			/* Size of data area.		 */
	);

	err = AEGetParamPtr(		/* GET THE MESSAGE TYPE.	 */
		message,				/* The AppleEvent. 			 */
		keyDirectObject,		/* AEKeyword				 */
		typeShortInteger,		/* Desired type.			 */
		&actualType,			/* Type code.				 */
		(Ptr)&messageType,		/* Pointer to area for data. */ 
		2 * sizeof(long),		/* Size of data area.		 */
		&actualSize				/* Returned size of data.	 */
	);

	if (!err) {
		err = AEGetParamPtr(		/* GET WINDOW MESSAGE IS FOR. */
			message,				/* The AppleEvent. 			  */
			keyGameID,				/* AEKeyword				  */
			typeDoubleLong,			/* Desired type.			  */
			&actualType,			/* Type code.				  */
			(Ptr)&gameID[0],		/* Pointer to area for data.  */ 
			2 * sizeof(long),		/* Size of data area.		  */
			&actualSize				/* Returned size of data.	  */
		);
	}

	if (!err) {			/* See if the requested window exists... */
		if (window = GetGameWindow(gameID[1], gameID[0])) {
			frHndl = (FileRecHndl)GetWRefCon(window);
				/* The game still exists... */
		}
		else
			err = userCanceledErr;
				/* User (or computer) canceled game by disconnecting improperly. */
	}

	if (!err) {		/* If everything is cool, then do the specific task... */

		switch(messageType) {

			case kAmWhiteMssg:
			case kAmBlackMssg:
				messageType ^= 1;
				(*frHndl)->doc.configColor       = messageType;
				(*frHndl)->doc.configColorChange = true;
				(*frHndl)->doc.resync            = kHandResync;
				if ((*frHndl)->doc.creator)
					SendMssg(frHndl, messageType);
						/* If we are the creator, echo the message to make sure
						** that both players aren't the same color. */
				break;

			case kDisconnectMssg:
				locOfOpponent = (*frHndl)->doc.locOfOpponent;
				AEDisposeDesc(&locOfOpponent);
				(*frHndl)->doc.twoPlayer = kLimbo;
					/* We set the state of the game to NOT two-player, and NOT
					** what we are now.  This allows us to call SetOpponentType
					** to do all the work we need done.  If we didn't fudge the
					** state of the game (from two-player) then SetOpponentType
					** would send a disconnect message (and we would end up
					** back here.)  This would be an ugly situation, which is
					** completely prevented by fudging the state of the game. */
				SetOpponentType(frHndl, kOnePlayer);
				break;

			case kTimeMssg:
				AEGetParamPtr(
					message,				/* The AppleEvent. 			 */
					keyTime,				/* AEKeyword				 */
					typeDoubleLong,			/* Desired type.			 */
					&actualType,			/* Type code.				 */
					(Ptr)&time[0],			/* Pointer to area for data. */ 
					2 * sizeof(long),		/* Size of data area.		 */
					&mssgSize				/* Returned size of data.	 */
				);
				for (i = 0; i < 2; ++i)
					(*frHndl)->doc.configTime[i] = time[i];
				if ((*frHndl)->doc.resync)
					(*frHndl)->doc.configTimeChange = true;
				else {
					for (i = 0; i < 2; ++i)
						(*frHndl)->doc.timeLeft[i] =
							(*frHndl)->doc.displayTime[i] = time[i];
					UpdateTime(frHndl, false);
					DrawTime(frHndl);
				}
				if ((*frHndl)->doc.creator)
					SendMssg(frHndl, kTimeMssg);
						/* If we are the creator, echo the message to make sure
						** the clocks are in sync. */
				break;

			case kTextMssg:
			case kSoundMssg:
				/* Both the text and sound message simply send a block of
				** data less than 32k.  Get the data from the AppleEvent
				** for both cases, and then decide what kind of data it is. */

				key = (messageType == kTextMssg) ? keyTextMessage : keySoundMessage;
				if (!err) {		/* Determine the size of the data... */
					err = AEGetParamPtr(
						message,				/* The AppleEvent. 			 */
						key,					/* AEKeyword				 */
						typeMssg,				/* Desired type.			 */
						&actualType,			/* Type code.				 */
						nil,					/* Pointer to area for data. */ 
						0,						/* Size of data area.		 */
						&mssgSize				/* Returned size of data.	 */
					);
				}
				mssgData = nil;
				if (!err) {		/* Get the data... */
					mssgData = NewHandle(mssgSize);
					if (mssgData) {
						hstate = LockHandleHigh(mssgData);
						err = AEGetParamPtr(
							message,				/* The AppleEvent. 			 */
							key,					/* AEKeyword				 */
							typeMssg,				/* Desired type.			 */
							&actualType,			/* Type code.				 */
							*mssgData,				/* Pointer to area for data. */ 
							mssgSize,				/* Size of data area.		 */
							&actualSize				/* Returned size of data.	 */
						);
					}
					else err = memFullErr;
				}
				if (!err) {
					if (messageType == kTextMssg) {

						styl.tsFont = applFont;

						teIn   = (*frHndl)->doc.message[kMessageIn];
						intxt  = (*teIn)->hText;
						outtxt = mssgData;
						inlen  = (*teIn)->teLength;
						outlen = GetHandleSize(outtxt);

						oldPort = SetFilePort(frHndl);
						GetClip(oldClip = NewRgn());
						SetClip(newClip = NewRgn());

						overflow = inlen + outlen - 31998;
						if (overflow > 0) {
							if (overflow > inlen) overflow = inlen;
							TESetSelect(0, overflow, teIn);
							TEDelete(teIn);
							inlen -= overflow;
						}

						inlen = (*teIn)->teLength;
						TESetSelect(inlen, inlen, teIn);
						if ((inlen) && (outlen < 31998)) {
							i = ((*intxt)[inlen - 1] == 13) ? 1 : 2;
							for (;i--;) {
								TEKey(13, teIn);
								++inlen;
							}
							styl.tsSize = 4;
							TESetSelect(inlen - 1, inlen, teIn);
							TESetStyle((doFont | doSize), &styl, false, teIn);
							TESetSelect(inlen, inlen, teIn);
						}

						HLock(outtxt);
						TEInsert(*outtxt, outlen, teIn);

						TESetSelect(inlen, (*teIn)->teLength, teIn);

						styl.tsFace = normal;
						styl.tsSize = 9;
						TESetStyle((doFont | doFace | doSize), &styl, false, teIn);

						TECalText(teIn);
						pt = TEGetPoint(inlen, teIn);
						pt.v -= 12;
						TEScroll(0, (*teIn)->viewRect.top - pt.v, teIn);

						SetClip(oldClip);
						DisposeRgn(oldClip);
						DisposeRgn(newClip);
						SetPort(oldPort);

						CTEUpdate(teIn, CTEViewFromTE(teIn), false);
						CTEAdjustTEBottom(teIn);
						CTEAdjustScrollValues(teIn);

						if ((*frHndl)->doc.doSpeech)
							SayText(teIn, nil, (*frHndl)->doc.theVoice);

						if (GetCtlValue((*frHndl)->doc.beepOnMssg))
							if (mssgSize) SysBeep(1);
					}
					else SndPlay(nil, mssgData, false);
				}
				if (mssgData) DisposHandle(mssgData);
				if (!err) NotifyUser();
				break;

			case kBeepMssg:
				SysBeep(1);
				break;

		}
	}

	return(err);
}



/*****************************************************************************/
/*****************************************************************************/



/* GetGameWindow
**
** Find the window with the specified game ID's. */

#pragma segment AppleEvents
WindowPtr	GetGameWindow(long gameID_0, long gameID_1)
{
	WindowPeek	window;
	FileRecHndl	frHndl;

	for (window = LMGetWindowList(); window; window = window->nextWindow) {
		if (IsAppWindow((WindowPtr)window)) {
			frHndl = (FileRecHndl)GetWRefCon((WindowPtr)window);
			if (
				((*frHndl)->doc.gameID_0 == gameID_0) &&
				((*frHndl)->doc.gameID_1 == gameID_1)
			) return((WindowPtr)window);
		}
	}

	return(nil);
}



/*****************************************************************************/



/* KibitzPortFilter
**
** Don't allow PPCBrowser to show any applications other than Kibitz. */

#pragma segment AppleEvents
pascal Boolean	KibitzPortFilter(LocationNamePtr locationName, PortInfoPtr thePortInfo)
{
#pragma unused (locationName)

	long	type;

	if (thePortInfo->name.portKindSelector == ppcByString) {
		BlockMove(thePortInfo->name.u.portTypeStr + 1, (Ptr)&type, 4);
			/* The BlockMove is so that we don't get an address error
			** on a 68000-based machine due to referencing a long at
			** an odd-address. */
		if (type == gameCreator) return(true);
	}

	return(false);
}



/*****************************************************************************/



/* SetOpponentType
**
** Change the opponent type from whatever it currently is to the specified
** type.  In so doing, change the state of any controls, etc., that need
** to be changed due to the new opponent type. */

#pragma segment AppleEvents
void	SetOpponentType(FileRecHndl frHndl, short newOpponentType)
{
	WindowPtr		oldPort, window;
	short			oldOpponentType, hilite, i, toggle;
	AEAddressDesc	locOfOpponent;
	Rect			boardRect;
	ControlHandle	ctl;
	RgnHandle		oldClip, newClip;

	if (!(*frHndl)->fileState.window) return;

	if (!(oldOpponentType = (*frHndl)->doc.arrangeBoard))
		oldOpponentType = (*frHndl)->doc.twoPlayer;

	if (oldOpponentType == newOpponentType) return;

	(*frHndl)->doc.arrangeBoard = false;

	oldPort = SetFilePort(frHndl);
	GetPort(&window);

	oldClip = NewRgn();
	newClip = NewRgn();
	GetClip(oldClip);

	toggle = false;
	if ((newOpponentType == kArrangeBoard) || (oldOpponentType == kArrangeBoard)) {
		toggle = true;
		SetClip(newClip);		/* Prevent stuff from drawing. */
	}

	if (oldOpponentType == kTwoPlayer) {
		SendMssg(frHndl, kDisconnectMssg);
		locOfOpponent = (*frHndl)->doc.locOfOpponent;
		AEDisposeDesc(&locOfOpponent);
	}

	if (newOpponentType == kTwoPlayer) {
		hilite = 0;
		(*frHndl)->doc.timerRefTick = TickCount();
		(*frHndl)->doc.creator = true;
		if ((*frHndl)->doc.myColor == WHITE) (*frHndl)->doc.compMovesBlack = false;
		else								 (*frHndl)->doc.compMovesWhite = false;
	}
	else {
		hilite = 255;
		(*frHndl)->doc.creator = false;
		(*frHndl)->doc.resync  = kIsMove;
		(*frHndl)->doc.gameID_0 = (*frHndl)->doc.gameID_1 = 0;
	}

	SetPort(window);

	if (newOpponentType == kArrangeBoard) {
		CTEActivate(false, CTEFindActive(window));
		(*frHndl)->doc.king[BLACK].rookMoves[QSIDE] = 0;
		(*frHndl)->doc.king[BLACK].rookMoves[KSIDE] = 0;
		(*frHndl)->doc.king[WHITE].rookMoves[QSIDE] = 0;
		(*frHndl)->doc.king[WHITE].rookMoves[KSIDE] = 0;
		(*frHndl)->doc.enPasMove        = 0;
		(*frHndl)->doc.enPasPawnLoc     = 0;
		(*frHndl)->doc.arngEnPasMove    = 0;
		(*frHndl)->doc.arngEnPasPawnLoc = 0;
		(*frHndl)->doc.numLegalMoves    = 0;
		(*frHndl)->doc.gameIndex        = 0;
		(*frHndl)->doc.numGameMoves     = 0;
		(*frHndl)->doc.compMovesWhite   = false;
		(*frHndl)->doc.compMovesBlack   = false;
		AdjustGameSlider(frHndl);
	}
	if (oldOpponentType == kArrangeBoard) CTEWindActivate(window, true);

	if (newOpponentType == kArrangeBoard) {
		(*frHndl)->doc.arrangeBoard = kArrangeBoard;
		newOpponentType = kOnePlayer;
	}
	(*frHndl)->doc.twoPlayer = newOpponentType;

	HiliteControl(ctl = (*frHndl)->doc.sendMessage, hilite);
	OutlineControl(ctl);
	HiliteControl((*frHndl)->doc.beepOnMove, hilite);
	HiliteControl((*frHndl)->doc.beepOnMssg, hilite);

	if (!SoundInputAvaliable()) hilite = 255;
	HiliteControl((*frHndl)->doc.record, hilite);
	if (!(*frHndl)->doc.sound) hilite = 255;
	HiliteControl((*frHndl)->doc.sendSnd, hilite);
	DrawButtonTitle(frHndl, newOpponentType);

	if (toggle) {
		SetClip(oldClip);
		for (i = 0; i < 2; ++i) (*frHndl)->doc.timeLeft[i] = -1;
		boardRect = BoardRect();
		boardRect.left = boardRect.right + 1;
		boardRect.right = 1000;
		EraseRect(&boardRect);
		ImageDocument(frHndl, false);
	}

	DisposeRgn(oldClip);
	DisposeRgn(newClip);
	SetPort(oldPort);
}



/*****************************************************************************/



#pragma segment AppleEvents
void	GetFullPathAndAppName(StringPtr path, StringPtr app)
{
	ProcessSerialNumber	psn;
	ProcessInfoRec		pinfo;
	FSSpec				fss;

	pinfo.processInfoLength = sizeof(ProcessInfoRec);
	pinfo.processName       = app;
	pinfo.processAppSpec    = &fss;

	psn.lowLongOfPSN  = kCurrentProcess;
	psn.highLongOfPSN = kNoProcess;
	GetProcessInformation(&psn, &pinfo);

	PathNameFromDirID(pinfo.processAppSpec->parID, pinfo.processAppSpec->vRefNum, path);
}



/*****************************************************************************/



/* Don't allow DoIPCListPorts to find anything but the finder. */

#pragma segment AppleEvents
pascal Boolean	FinderFilter(LocationNamePtr locationName, PortInfoPtr thePortInfo)
{
#pragma unused (locationName)

	OSType	type;

	if (thePortInfo->name.portKindSelector == ppcByString) {
		BlockMove(thePortInfo->name.u.portTypeStr + 1, (Ptr)&type, 4);
			/* The BlockMove is so that we don't get an address error
			** on a 68000-based machine due to referencing a long at
			** an odd-address. */
		if (type == 'MACS') return(true);
	}

	return(false);
}

/***/

/* Don't allow DoIPCListPorts to find anything but Kibitz. */

#pragma segment AppleEvents
static pascal Boolean	KibitzFilter(LocationNamePtr locationName, PortInfoPtr thePortInfo)
{
#pragma unused (locationName)

	OSType	type;

	if (thePortInfo->name.portKindSelector == ppcByString) {
		BlockMove(thePortInfo->name.u.portTypeStr + 1, (Ptr)&type, 4);
			/* The BlockMove is so that we don't get an address error
			** on a 68000-based machine due to referencing a long at
			** an odd-address. */
		if (type == 'KBTZ') return(true);
	}

	return(false);
}

/***/

OSErr	GetRemoteProcessTarget(FileRecHndl frHndl, AEDesc *retDesc, GRPTProcPtr proc)
{
	OSErr			err;
	char			hstate;
	PortInfoRec		info;		/* Just one, please. */
	LocationNameRec	loc;
	short			indx, reqCount, actCount;
	TargetID		theID;

	retDesc->dataHandle = nil;		/* So caller can dispose always. */

	hstate = LockHandleHigh((Handle)frHndl);
	loc.locationKindSelector = ppcNBPLocation;		/* Using an NBP construct. */
	pcpy(loc.u.nbpEntity.objStr,  (*frHndl)->doc.reconnectMachine);
	pcpy(loc.u.nbpEntity.zoneStr, (*frHndl)->doc.reconnectZone);
	pcpy(loc.u.nbpEntity.typeStr, "\pPPCToolBox");
	HSetState((Handle)frHndl, hstate);

	indx     = 0;
	reqCount = 1;
	actCount = 0;
	if (err = DoIPCListPorts(&indx, &reqCount, &actCount, &loc, &info, proc)) return(err);

	if (actCount) {
		theID.name = info.name;
		theID.location = loc;
		err = AECreateDesc(typeTargetID, (Ptr)&theID, sizeof(theID), retDesc);
	}

	return(err);
}




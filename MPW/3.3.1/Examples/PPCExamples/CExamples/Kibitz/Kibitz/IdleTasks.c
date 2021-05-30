/*
** Apple Macintosh Developer Technical Support
**
** File:        idletasks.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/



#pragma segment Main
void	DoIdleTasks(Boolean allowComputerMoves)
{
	WindowPtr		window, compMoveWindow;
	unsigned long	compMoveTick;
	FileRecHndl		game, compMoveGame;
	FileRecPtr		frPtr;
	short			twoPlayer, moveColor, myColor, update, syncClocks, i;
	Boolean			compMovesWhite, compMovesBlack, sendSyncGame;
OSErr	err;

	static unsigned long	clockSyncTick;
	static Boolean			startingUp = true;
	static long				waitSome;

	if (startingUp) {
		if (FrontWindow()) {
			startingUp = false;
			return;
		}
		if (!waitSome) waitSome = TickCount() + 30;
		else {
			if (waitSome < TickCount()) {
				startingUp = false;
				err = AppNewDocument(&game, ksOrigName);
				if (!err) {
					(*game)->doc.compMovesBlack = true;
					if (err = AppNewWindow(game, nil, (WindowPtr)-1)) {
						AppDisposeDocument(game);
					}
				}
			}
		}
		return;
	}

	DynamicBalloonHelp();

	compMoveTick = -1;

	if (syncClocks = (clockSyncTick + 1800 < TickCount()))
		clockSyncTick = TickCount();
			/* Syncronize clocks every 30 seconds. */


	for (window = FrontWindow();
		 window;
		 window = (WindowPtr)(((WindowPeek)window)->nextWindow)
	) {
		if (IsAppWindow(window)) {

			DoSetCursor(nil);

			game = (FileRecHndl)GetWRefCon(window);
			twoPlayer = (*game)->doc.twoPlayer;

			if (update = UpdateTime(game, true)) DrawTime(game);

			if (update == 2) {
				if (twoPlayer) SendGame(game, kIsMove, nil);
					/* Send it as a move, since we want the alert to
					** show up for the opponent. */
				AlertIfGameOver(game);
				return;
			}

			if ((*game)->doc.resync >= kResync) {
				sendSyncGame = true;
					/* We may need to sync up.  Assume we will. */

				if ((*game)->doc.configColorChange) {
					if ((*game)->doc.myColor != (*game)->doc.configColor) {
						(*game)->doc.myColor = (*game)->doc.configColor;
						(*game)->doc.invertBoard ^= 1;
						SetPort(window);
						ImageDocument(game, true);
					}
					(*game)->doc.configColorChange = false;
					AdjustGameSlider(game);
					sendSyncGame = false;
				}

				if ((*game)->doc.configTimeChange) {
					for (i = 0; i < 2; ++i)
						(*game)->doc.timeLeft[i] =
							(*game)->doc.displayTime[i] =
								(*game)->doc.configTime[i];
					(*game)->doc.configTimeChange = false;
					UpdateTime(game, false);
					DrawTime(game);
					sendSyncGame = false;
				}

				if (sendSyncGame) {
					if ((*game)->doc.gotUpdateTick + 120 < TickCount()) {
						/* Wait for 2 secs since last game update before syncing.
						** This is so that we don't send a sync while the opponent
						** is still clicking on the arrow.  Without this delay, the
						** scrollbar of the opponent will jump around after he is
						** done scrolling.  It would eventually end up correct,
						** but it looks bad.  2 secs is enough time (generally) for
						** the opponent to receive the sync from the last click, so
						** the scroll won't jump around.  Also, 2 secs is probably
						** more time than the user would take between clicks on
						** the arrow. */

						if ((*game)->doc.creator)		/* Only the creator can sync. */
							if (twoPlayer) SendGame(game, kHandResync, nil);
								/* Make sure the boards are in sync. */

						(*game)->doc.resync = kIsMove;
							/* Back to life as usual. */

						DoSetCursor(nil);
							/* Re-calc the cursor. */
					}
				}
			}

			frPtr          = *game;
			compMovesWhite = frPtr->doc.compMovesWhite;
			compMovesBlack = frPtr->doc.compMovesBlack;
			myColor        = frPtr->doc.myColor;
			moveColor      = WhosMove(game);

			if (frPtr->doc.arrangeBoard)
				compMovesWhite = compMovesBlack = 0;

			if (twoPlayer) {
				if (myColor == moveColor) {
					if (syncClocks)
						SendMssg(game, kTimeMssg);
							/* Sync up the clocks every 30 seconds.  Only do
							** this if it is our move, since the player who
							** owns the move also owns the clock. */
				}
				else
					compMovesWhite = compMovesBlack = false;
			}
			if (
				((compMovesWhite) && (moveColor == WHITE)) ||
				((compMovesBlack) && (moveColor == BLACK))
			) {
				if (compMoveTick > frPtr->doc.compMoveTick) {
					if (GameStatus(game) == kGameContinues) {
						compMoveTick   = frPtr->doc.compMoveTick;
						compMoveWindow = window;
						compMoveGame   = game;
					}
				}
			}
		}
	}

	if (allowComputerMoves) {
		if (compMoveTick != -1) {
			if ((*compMoveGame)->doc.resync == kIsMove) {
				(*compMoveGame)->doc.compMoveTick = TickCount();
				if (ComputerMove(compMoveGame)) {
					SetPort(compMoveWindow);
					ImageDocument(compMoveGame, true);
					AdjustGameSlider(compMoveGame);
					twoPlayer = (*compMoveGame)->doc.twoPlayer;
					DrawButtonTitle(compMoveGame, twoPlayer);
					UpdateGameStatus(compMoveGame);
					if (twoPlayer) SendGame(compMoveGame, kIsMove, nil);
					SayTheMove(game);
					AlertIfGameOver(compMoveGame);
					DoSetCursor(nil);
				}
			}
		}
	}
}




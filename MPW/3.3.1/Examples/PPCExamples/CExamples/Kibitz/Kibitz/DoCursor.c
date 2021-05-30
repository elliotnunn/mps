/*
** Apple Macintosh Developer Technical Support
**
** File:	    docursor.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __OSEVENTS__
#include <OSEvents.h>
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



RgnHandle	gCurrentCursorRgn;
	/* The current cursor region.  The initial cursor region is an empty
	** region, which will cause WaitNextEvent to generate a mouse-moved
	** event, which will cause us to set the cursor for the first time. */

Cursor	*gCurrentCursor, **gCurrentCursorHndl;
	/* The current cursor that applies to gCurrentCursorRgn.  These values
	** are here to shorten the re-processing time for determining the
	** correct cursor after an event.  This is specifically so that characters
	** can be typed into the TextEdit control faster.  If we spend a great
	** deal of time per-event recalculating the cursor region, text entry for
	** the TextEdit control slows down considerably.  If you want to override
	** the time savings because you are changing the cursor directly, either
	** set gCurrentCursor to nil, or call DoSetCursor to set the cursor.
	** DoSetCursor simply sets gCurrentCursor to nil, as well as setting
	** the cursor. */



/*****************************************************************************/
/*****************************************************************************/



/* Handle the cursor changes, based on if an AppleEvent is involved, or
** depending on the location of the cursor.  This also calculates the region
** where the current cursor resides (for WaitNextEvent).  If the mouse is
** ever outside of that region, an event would be generated, causing this
** function to be called, allowing us to change the region to the region
** the mouse is currently in.  The only other cursor management in this sample
** is for operations such as pulling down a menu.  Just prior to pulling down
** the menu, the arrow cursor is set.  This prevents any latencies in cursor
** update to cause a non-arrow cursor to be used in the menus.  This technique
** should be carried throughout the application. */

#pragma segment Main
void	DoCursor(void)
{
	WindowPtr	window, oldPort;
	WindowPeek	wpeek;
	RgnHandle	rgn1, rgn2, rgn3;
	Rect		boardRct, structRct, teViewRct;
	Point		mouseLoc;
	FileRecHndl	frHndl;
	FileRecPtr	frPtr;
	TEHandle	teHndl;
	Boolean		readOnly, twoPlayer, canMove;
	short		resync, myColor, moveColor;
	EventRecord	option;

	mouseLoc = GetGlobalMouse();

	if ((!gInBackground) && (!IsDAWindow(window = FrontWindow()))) {

		if (IsAppWindow(window)) {

			if (gCurrentCursor) {
				if (PtInRgn(mouseLoc, gCurrentCursorRgn)) {
					SetCursor(*gCurrentCursorHndl);
					return;
				}
			}

			SetEmptyRgn(gCurrentCursorRgn);
			GetPort(&oldPort);

			if (CTETargetInfo(&teHndl, &teViewRct) == window) {
				SetPort(window);
				SectRect(&teViewRct, &(window->portRect), &teViewRct);
				LocalToGlobalRect(&teViewRct);
				SetPort(oldPort);
				RectRgn(gCurrentCursorRgn, &teViewRct);
				if (PtInRect(mouseLoc, &teViewRct)) {
					SetCursor(gCurrentCursor = *(gCurrentCursorHndl = GetCursor(ibeamCursor)));
					return;
				}
			}

			rgn1 = NewRgn();
			rgn2 = NewRgn();
			rgn3 = NewRgn();

			wpeek = (WindowPeek)window;
			for (; wpeek; wpeek = wpeek->nextWindow) {

				if (IsAppWindow((WindowPtr)wpeek)) {

					frHndl = (FileRecHndl)GetWRefCon((WindowPtr)wpeek);
					frPtr  = *frHndl;
					readOnly  = frPtr->fileState.readOnly;
					twoPlayer = frPtr->doc.twoPlayer;
					resync    = frPtr->doc.resync;
					myColor   = frPtr->doc.myColor;
					moveColor = WhosMove(frHndl);

					OSEventAvail(nullEvent, &option);
					if (option.modifiers & optionKey)
						if (myColor != kMessageDoc) myColor = moveColor;

					canMove = true;

					if (readOnly)
						canMove = false;
					if ((twoPlayer) && (myColor != moveColor))
						canMove = false;
					if (myColor == kMessageDoc)
						canMove = false;
					if (GameStatus(frHndl) != kGameContinues)
						canMove = false;
					if ((moveColor == WHITE) && ((*frHndl)->doc.compMovesWhite))
						canMove = false;
					if ((moveColor == BLACK) && ((*frHndl)->doc.compMovesBlack))
						canMove = false;
					if ((resync == kScrolling) || (resync == kResync))
						canMove = false;

					if (canMove) {
						boardRct = GlobalBoardRect((WindowPtr)wpeek);
						RectRgn(rgn1, &boardRct);
						DiffRgn(rgn1, rgn2, rgn1);
						UnionRgn(rgn3, rgn1, rgn3);
					}
				}

				structRct = GetWindowStructureRect((WindowPtr)wpeek);
				RectRgn(rgn1, &structRct);
				UnionRgn(rgn1, rgn2, rgn2);
			}		/* Assume cursor is over an app content. */

			if (!PtInRgn(mouseLoc, rgn3)) {
					/* The cursor wasn't over a chessboard after all. */
				SetRectRgn(rgn1, kExtremeNeg, kExtremeNeg,
								 kExtremePos, kExtremePos);
				DiffRgn(rgn1, rgn3, rgn3);
				gCurrentCursor     = &qd.arrow;
				gCurrentCursorHndl = &gCurrentCursor;
				SetCursor(gCurrentCursor);
			}
			else SetCursor(*(gCurrentCursorHndl = GetCursor(handCursor)));

			DiffRgn(rgn3, gCurrentCursorRgn, gCurrentCursorRgn);

			DisposeRgn(rgn1);
			DisposeRgn(rgn2);
			DisposeRgn(rgn3);
			return;
		}

		else DoSetCursor(&qd.arrow);
	}

	else {
		SetRectRgn(gCurrentCursorRgn, kExtremeNeg, kExtremeNeg,
									  kExtremePos, kExtremePos);
		gCurrentCursor = nil;
	}
}



/*****************************************************************************/



#pragma segment Main
void	DoSetCursor(Cursor *cursor)
{
	if (cursor) SetCursor(cursor);
	gCurrentCursor = nil;
	if (!cursor) DoCursor();
}



/*****************************************************************************/



#pragma segment Main
Rect	BoardRect(void)
{
	Rect	boardRct;

	SetRect(&boardRct, kBoardHOffset + 1, kBoardVOffset + 1,
			 kBoardHOffset + 8 * kBoardSqSize + 1,
			 kBoardVOffset + 8 * kBoardSqSize + 1);
	return(boardRct);
}



/*****************************************************************************/



#pragma segment Main
Rect	GlobalBoardRect(WindowPtr window)
{
	Rect	boardRct, windRct;

	boardRct = BoardRect();
	windRct  = GetWindowContentRect(window);

	OffsetRect(&boardRct, windRct.left, windRct.top);
	return(boardRct);
}




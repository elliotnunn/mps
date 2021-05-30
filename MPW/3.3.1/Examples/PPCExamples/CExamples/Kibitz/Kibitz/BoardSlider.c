/*
** Apple Macintosh Developer Technical Support
**
** File:        boardslider.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved. */

/* This is a custom slider for Kibitz.  It sends AppleEvents to the opponent,
** if there is one, so that the remote board is also scrolled.  It sends a
** maximum of 1 a second, so that they will be able to be processed without
** stacking up at the other end.
**
** There is a custom cdef for this code.  All it does is jump to this code.
** There is a really good reason for this, which is most obscure.  It is
** possible that, when you choose an opponent machine, you choose your own
** machine.  This is fully supported in Kibitz.  As a matter of fact, only
** theMakeTarget code "knows" that it is the same machine.  The rest of the
** application is completely ignorant of this fact.  When the user clicks
** on the slider, the control manager locks down the cdef, and then calls it.
** When the custom cdef returns to the control manager, the cdef is unlocked.
** This all seems very reasonable.  However, in the case that you are sending
** a game to the same machine, I send an AppleEvent, which causes an update
** on the slider.  This update is handled by the control manager calling the
** cdef.  Of course, it locks it down, and then when the control manager is
** returned to, it unlocks it.  BUT WAIT!!  We are still tracking the slider
** that caused the AppleEvent to be sent, which in turn caused the slider of
** another window to update.  This is true.  It is also true that the cdef
** is now UNLOCKED!  And with AppleEvents using memory in a healthy way, it
** is very probable that the cdef will  move.  It isn't a good idea to rts
** to code that has moved.  This is why the cdef jumps to the code in the
** application.  We never return to the (potentially unlocked) cdef.  We
** return straight to the control manager.  Ugly problem, huh? */



/*****************************************************************************/



#define kCapHeight		11
#define kThumbHeight	7
#define kThumbOffset	12
#define kSliderWidth	13

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

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/



#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
typedef struct cdefRsrcJMP {
	long	jsrInst;
	long	moveInst;
	short	jmpInst;
	long	jmpAddress;
} cdefRsrcJMP;
typedef cdefRsrcJMP *cdefRsrcJMPPtr, **cdefRsrcJMPHndl;
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

static void			BoardDrawCIcon(CIconHandle iconHndl, short hloc, short vloc);
static pascal long	BoardSliderCtl(short varCode, ControlHandle ctl, short msg, long parm);
static void			BoardSliderUpdate(ControlHandle ctl, short hiliteCap);
static Rect			CalcSliderRect(ControlHandle ctl);
static void			TrackSlider(ControlHandle ctl, Point origMouseLoc);



/*****************************************************************************/



/* Given a file reference, adjust the slider to reflect the position
** of the chessboard. */

#pragma segment Controls
void	AdjustGameSlider(FileRecHndl frHndl)
{
	ControlHandle	ctl;
	short			val, max;
	WindowPtr		oldPort;

	ctl = (*frHndl)->doc.gameSlider;
	val = (*frHndl)->doc.gameIndex;
	max = (*frHndl)->doc.numGameMoves;
		/* Get the info we need. */

	(*ctl)->contrlMax   = max;
	(*ctl)->contrlValue = val;
	oldPort = SetFilePort(frHndl);
	BoardSliderUpdate(ctl, -1);
		/* Change the slider value and show the result. */

	SetPort(oldPort);
}



/*****************************************************************************/



#pragma segment Controls
ControlHandle	BoardSliderNew(WindowPtr window)
{
	WindowPtr		oldPort;
	FileRecHndl		frHndl;
	Rect			boardRect;
	ControlHandle	sliderCtl;
	cdefRsrcJMPHndl	cdefRsrc;
	static	ControlDefUPP	boardSliderCtlUPP = nil;

	GetPort(&oldPort);
	SetPort(window);

	frHndl = (FileRecHndl)GetWRefCon(window);

	boardRect = BoardRect();
	boardRect.left    = boardRect.right + 4;
	boardRect.right   = boardRect.left + 13;
	boardRect.top    += 4;
	boardRect.bottom -= 4;

	cdefRsrc = (cdefRsrcJMPHndl)GetResource('CDEF', (rSliderCtl / 16));
	if (!boardSliderCtlUPP)
		boardSliderCtlUPP = NewControlDefProc(BoardSliderCtl);
	(*cdefRsrc)->jmpAddress = (long)boardSliderCtlUPP;
	FlushInstructionCache();
		/* Make sure that instruction caches don't kill us. */

	sliderCtl = NewControl(window, &boardRect, "\p", true, 0, 0, 0,
						   rSliderCtl, (long)frHndl);

	return(sliderCtl);
}



/*****************************************************************************/



#pragma segment Controls
pascal long	BoardSliderCtl(short varCode, ControlHandle ctl, short msg, long parm)
{
#pragma unused (varCode)

	Rect			viewRect;
	static Point	lastClick;

	viewRect = (*ctl)->contrlRect;

	switch (msg) {
		case drawCntl:
			BoardSliderUpdate(ctl, -1);
			break;

		case testCntl:
			if ((*ctl)->contrlHilite == 255) return(0);
			if (!(*ctl)->contrlMax) return(0);
			if (PtInRect(*(Point *)&parm, &viewRect)) {
				lastClick = *((Point *)&parm);
				return(inThumb);
			}		/* Everything is the thumb.  The "thumb" routine will figure
					** out what part it is.  Since this is a very specific control,
					** we can get away with this simplification. */
			return(0);

		case calcCRgns:
		case calcCntlRgn:
			if (msg == calcCRgns) parm &= 0x00FFFFFF;
			RectRgn((RgnHandle)parm, &viewRect);
			break;

		case initCntl:
			break;

		case dispCntl:
			break;

		case posCntl:
			break;

		case thumbCntl:
			TrackSlider(ctl, lastClick);
			break;

		case dragCntl:
			return(true);

		case autoTrack:
			break;
	}

	return(0);
}



/*****************************************************************************/



#pragma segment Controls
void	BoardSliderUpdate(ControlHandle ctl, short hiliteCap)
{
	Rect		ctlRect, workRect, sliderRect;
	FileRecHndl	frHndl;
	Boolean		active;
	short		i, j, thumbColor;
	RgnHandle	origClipRgn, clipRgn, workRgn;
	CIconHandle	icons[7];

	/* We use color icons here for the various slider parts.  This is so that we
	** can take advantage of the depth of monitors.  I use icons here so that I
	** can do a single plot of an icon if the delta of the thumb is -12 to 12.
	** (The thumb is in the center of an icon, and 12 pixels above and below the
	** icon, I have slider bar.  Use RedEdit to check it out.)  This technique
	** gives a very smooth appearance when the thumb slides.  There is no flash.
	** For deltas greater than +-12, I redraw the slider without the thumb, and
	** then draw the thumb in the new position.  Since the thumb is moving a lot
	** anyway, this doesn't show up as a flicker.  There is no overlap in the
	** old and new positions for a big delta. */

	ctlRect = (*ctl)->contrlRect;
	frHndl  = (FileRecHndl)GetCRefCon(ctl);

	for (i = 0; i < 7; i++) icons[i] = ReadCIcon(i + rSliderBase);

	origClipRgn = NewRgn();
	GetClip(origClipRgn);

	clipRgn = NewRgn();

	for (i = 0; i < 2; i++) {		/* Draw the arrow parts first. */
		j = i;
		if (hiliteCap == i) j += 5;
		workRect = ctlRect;
		if (!i)
			workRect.bottom = workRect.top + kCapHeight;
		else
			workRect.top = workRect.bottom - kCapHeight;
		RectRgn(clipRgn, &workRect);
		SetClip(clipRgn);
			/* Clip out the area outside the arrow part. */
		BoardDrawCIcon(icons[j], workRect.left, workRect.top);
			/* Draw the arrow part. */
	}

	ctlRect.top    += kCapHeight;
	ctlRect.bottom -= kCapHeight;
	RectRgn(clipRgn, &ctlRect);
	SetClip(clipRgn);
		/* Clip out everything except the slider bar area. */

	active  = ((*ctl)->contrlOwner == FrontWindow());
	if ((*ctl)->contrlHilite == 255) active = false;
	if (!(*ctl)->contrlMax) active = false;

	if (active) {		/* If control active, draw the thumb. */
		sliderRect = CalcSliderRect(ctl);
		thumbColor = (((*ctl)->contrlValue & 0x01) ^ (*frHndl)->doc.startColor);
		BoardDrawCIcon(icons[3 + thumbColor],
					   sliderRect.left, sliderRect.top - kThumbOffset);
		workRgn = NewRgn();
		RectRgn(workRgn, &sliderRect);
		DiffRgn(clipRgn, workRgn, clipRgn);
		SetClip(clipRgn);
		DisposeRgn(workRgn);
			/* Now that the thumb is drawn, protect it by clipping it out. */
	}

	for (i = ctlRect.top; i < ctlRect.bottom; i += 32)
		BoardDrawCIcon(icons[2], ctlRect.left, i);
			/* Draw the slider bar portion. */

	/* It is now completely drawn.  Clean up and get out. */

	SetClip(origClipRgn);
	DisposeRgn(clipRgn);
	DisposeRgn(origClipRgn);

	for (i = 0; i < 7; i++) KillCIcon(icons[i]);
}



/*****************************************************************************/



#pragma segment Controls
void	BoardDrawCIcon(CIconHandle iconHndl, short hloc, short vloc)
{
	Rect	iconRect;

	iconRect.right  = (iconRect.left = hloc) + 32;
	iconRect.bottom = (iconRect.top  = vloc) + 32;

	DrawCIcon(iconHndl, iconRect);
}



/*****************************************************************************/



#pragma segment Controls
Rect	CalcSliderRect(ControlHandle ctl)
{
	Rect	ctlRect, sliderRect;
	short	max, val;
	long	calc;

	ctlRect = (*ctl)->contrlRect;
	ctlRect.top    += kCapHeight;
	ctlRect.bottom -= kCapHeight;
	max = (*ctl)->contrlMax;
	val = (*ctl)->contrlValue;

	calc = ctlRect.bottom - ctlRect.top - kThumbHeight;
	calc *= val;
	if (max) calc /= max;
	sliderRect.top    = ctlRect.top + calc,
	sliderRect.left   = ctlRect.left;
	sliderRect.bottom = sliderRect.top + kThumbHeight;
	sliderRect.right  = ctlRect.right;

	return(sliderRect);
}



/*****************************************************************************/



#pragma segment Controls
void	TrackSlider(ControlHandle ctl, Point origMouseLoc)
{
	CIconHandle	icons[7];
	WindowPtr	oldPort;
	Rect		ctlRect, sliderRange, slopRect, sliderRect, capRect, pgRect;
	FileRecHndl	frHndl;
	RgnHandle	origClipRgn, clipRgn, workRgn;
	short		i, max, val, origGameIndex, ovloc, voffset, vloc, delta, hiliteCap;
	Boolean		twoPlayer, hiliteOn, doPgScroll;
	long		origTick, tick, calc;
	Point		lastMouseLoc, mouseLoc;

	/* Get everything we need set up. */

	origTick = tick = TickCount();

	for (i = 2; i < 5; i++) icons[i] = ReadCIcon(i + rSliderBase);

	frHndl  = (FileRecHndl)GetCRefCon(ctl);
	oldPort = SetFilePort(frHndl);
	ctlRect = (*ctl)->contrlRect;

	origClipRgn = NewRgn();
	GetClip(origClipRgn);

	clipRgn = NewRgn();
	workRgn = NewRgn();

	origGameIndex = (*frHndl)->doc.gameIndex;
	max = (*ctl)->contrlMax;

	twoPlayer  = (*frHndl)->doc.twoPlayer;
	sliderRect = CalcSliderRect(ctl);

	/* That ought to be enough setup. */

	if (PtInRect(origMouseLoc, &sliderRect)) {	/* If they are on the thumb... */

		ctlRect.top    += kCapHeight;			/* Protect the arrow parts. */
		ctlRect.bottom -= kCapHeight;
		RectRgn(clipRgn, &ctlRect);
		SetClip(clipRgn);

		sliderRange = ctlRect;					/* Calc area thumb can move. */
		sliderRange.bottom -= kThumbHeight;		/* Count height of thumb against range. */

		slopRect = sliderRange;					/* Give the user some slop. */
		InsetRect(&slopRect, -20, -20);

		lastMouseLoc = origMouseLoc;
		voffset = lastMouseLoc.v - sliderRect.top;
		ovloc   = lastMouseLoc.v - voffset;

		while (StillDown()) {

			if (tick + 30 < TickCount()) {		/* Send max 1 AppleEvent per 1/2 sec. */
				tick = TickCount();
				if (twoPlayer) SendGame(frHndl, kScrolling, nil);
			}

			GetMouse(&mouseLoc);
			if (!EqualPt(mouseLoc, lastMouseLoc)) {		/* The mouse has moved. */

				if (!PtInRect(mouseLoc, &slopRect)) mouseLoc = origMouseLoc;
					/* Outside slopRect, so snap back to the original position. */

				vloc = mouseLoc.v - voffset;
				if (vloc < sliderRange.top)    vloc = sliderRange.top;
				if (vloc > sliderRange.bottom) vloc = sliderRange.bottom;
				delta = vloc - ovloc;
					/* The delta tells us how much the thumb moved. */

				if (
					(delta < -((32 - kThumbHeight) / 2)) ||
					(delta >  ((32 - kThumbHeight) / 2))
				) {
					for (i = ctlRect.top; i < ctlRect.bottom; i += 32)
						BoardDrawCIcon(icons[2], ctlRect.left, i);
							/* The thumb moved too far for a single plot to cover
							** up the old position, so clear the old thumb. */
				}

				calc  = max + 1;		/* Force below math to be with longs. */
				calc *= (vloc - sliderRange.top);
					/* We use max + 1 because there is one more game
					** move position than moves in the game.  This is
					** because we can position in front of the first move,
					** as well as after the last move. */
				calc /= (sliderRange.bottom - sliderRange.top);

				val = calc;
				if (val > max) val = max;
				if (val < 0)   val = 0;
				if (delta)
					BoardDrawCIcon(icons[3 + ((val + (*frHndl)->doc.startColor) & 0x01)],
								   ctlRect.left, vloc - kThumbOffset);
										/* The thumb is now updated. */

				SetClip(origClipRgn);
				RepositionBoard(frHndl, val, true);
					/* We set the clipRgn back to the original so the board
					** can update.  (Pretty boring if it doesn't. */

				SetClip(clipRgn);
					/* Back to our normally scheduled program... */

				lastMouseLoc = mouseLoc;
				(*ctl)->contrlValue = val;
				ovloc = vloc;
			}
		}
	}

	else {		/* We missed the thumb.  See if we hit an arrow part... */
		delta = hiliteOn = 0;
		capRect = ctlRect;
		capRect.bottom = ctlRect.top + kCapHeight;
		if (PtInRect(origMouseLoc, &capRect)) {
			delta = -1;
			hiliteCap = 0;
		}
		else {
			capRect = ctlRect;
			capRect.top = ctlRect.bottom - kCapHeight;
			if (PtInRect(origMouseLoc, &capRect)) {
				delta = 1;
				hiliteCap = 1;
			}
		}

		if (delta) {	/* We hit an arrow, and there is a change to do... */
			do {
				if (tick + 30 < TickCount()) {
					tick = TickCount();
					if (twoPlayer) SendGame(frHndl, kScrolling, nil);
				}
				GetMouse(&mouseLoc);
				if (PtInRect(mouseLoc, &capRect)) {		/* Still in arrow... */
					val = (*ctl)->contrlValue + delta;
					if ((val >= 0) && (val <= max)) {	/* Still scrolling... */
						hiliteOn = true;
						(*ctl)->contrlValue = val;
						BoardSliderUpdate(ctl, hiliteCap);
						SetClip(origClipRgn);
						if (RepositionBoard(frHndl, val, true)) SetClip(clipRgn);
					}
					else {		/* Scrolled as far as we can go, so unhilite arrow. */
						if (hiliteOn) {
							BoardSliderUpdate(ctl, -1);
							hiliteOn = false;
						}
					}
				}
				else {		/* Outside arrow, so unhilite it. */
					if (hiliteOn) {
						BoardSliderUpdate(ctl, -1);
						hiliteOn = false;
					}
				}

				while ((StillDown()) && (origTick + 20 > TickCount()));
					/* Don't go too fast. */

			} while (StillDown());
		}

		else {

			pgRect = ctlRect;
			pgRect.top    += kCapHeight;
			pgRect.bottom -= kCapHeight;
			if (PtInRect(origMouseLoc, &pgRect)) {		/* If in the page area... */
				delta = (origMouseLoc.v < sliderRect.top) ? -2 : 2;
				InsetRect(&pgRect, -10, -10);
				do {
					if (tick + 30 < TickCount()) {
						tick = TickCount();
						if (twoPlayer) SendGame(frHndl, kScrolling, nil);
					}
					GetMouse(&mouseLoc);
					if (PtInRect(mouseLoc, &pgRect)) {		/* Still in page area... */
						doPgScroll = false;
						sliderRect = CalcSliderRect(ctl);
						if ((delta == -2) && (mouseLoc.v < sliderRect.top))    doPgScroll = true;
						if ((delta == 2)  && (mouseLoc.v > sliderRect.bottom)) doPgScroll = true;
						if (doPgScroll) {
							val = (*ctl)->contrlValue + delta;
							if (val == -1)       val = 0;
							if (val == (max + 1)) val = max;
							if ((val >= 0) && (val <= max)) {	/* Still scrolling... */
								(*ctl)->contrlValue = val;
								BoardSliderUpdate(ctl, -1);
								SetClip(origClipRgn);
								if (RepositionBoard(frHndl, val, true)) SetClip(clipRgn);
							}
						}
					}

					while ((StillDown()) && (origTick + 20 > TickCount()));
						/* Don't go too fast. */

				} while (StillDown());
			}
		}
	}

	SetClip(origClipRgn);
	DisposeRgn(workRgn);
	DisposeRgn(clipRgn);
	DisposeRgn(origClipRgn);

	if (twoPlayer) SendGame(frHndl, kResync, nil);
		/* Make sure that the result from the scroll isn't ignored.  The
		** opponent may ignore the events while we are scrolling, but not
		** when we are done. */

	BoardSliderUpdate(ctl, -1);
		/* Snap the slider to a move position.  The user may have let go of the
		** slider at a position that doesn't map exactly to the game position. */

	for (i = 2; i < 5; i++) KillCIcon(icons[i]);

	SetPort(oldPort);
}



/*****************************************************************************/



#pragma segment Controls
Boolean	RepositionBoard(FileRecHndl frHndl, short newPos, Boolean update)
{
	short		oldPos, delta;

	oldPos = (*frHndl)->doc.gameIndex;
	if (newPos == oldPos) return(false);

	delta  = (newPos > oldPos) ? 1 : -1;
		/* We need to walk the board forward or backward delta number of moves. */

	for (; oldPos != newPos; oldPos += delta)
		MakeMove(frHndl, delta, 0, 0);
			/* Walk the board position one half-move forward or backward. */

	if (update) {
		ImageDocument(frHndl, true);
		DrawButtonTitle(frHndl, (*frHndl)->doc.twoPlayer);
		UpdateGameStatus(frHndl);
			/* Show the new board position. */
	}

	return(true);
}




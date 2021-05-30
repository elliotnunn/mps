/*
** Apple Macintosh Developer Technical Support
**
** File:        offscreen.c
** Written by:  Eric Soldan
**
** Copyright © 1991-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __ERRORS__
#include "Errors.h"
#endif

#ifndef __GWLAYERS__
#include <GWLayers.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



static short		gDepth, gPiece;
static CTabHandle	gCtab;
static Rect			gPieceRect;
static RgnHandle	gColorRgn, gTestRgn;



/*****************************************************************************/



LayerObj			gBoardLayer;
short				gClearSquare;
extern CIconHandle	gPieceCIcon[26];

static OSErr	PieceLayerProc(LayerObj theLayer, short message);
static OSErr	BoardLayerProc(LayerObj theLayer, short message);
static void		PlotWithShadow(short x, short y);



/*****************************************************************************/



#pragma segment Config
OSErr	InitOffscreen(void)
{
	RgnHandle	colorRgn;
	short		depth;
	OSErr		err;

	gClearSquare = 0;		/* Regular board imaging as default. */

	colorRgn = ScreenDepthRegion(8);
	depth = (EmptyRgn(colorRgn)) ? 1 : 8;
	DisposeRgn(colorRgn);

	err = NewLayer(&gBoardLayer, nil, BoardLayerProc, nil, depth, 0);
		/* We create boardLayer at initialization time.  This layer will be
		** used to image the board off-screen.  Note that the layer has its own
		** layerProc.  The kLayerInit action doesn't call the default layerInit.
		** This custom layerProc uses just the size of the above GWorld to
		** determine the size of the bitmap it creates, so this layer isn't
		** necessarily the same depth as the above layer.  If there is no above
		** layer, then this custom layerProc needs to return paramErr for the
		** kLayerInit message, just as the default LayerProc does. */

	return(err);
}



/*****************************************************************************/



#pragma segment Config
void	MoveThePiece(FileRecHndl frHndl, short fromSq, Rect fromRect, Point fromLoc, Point *toLoc)
{
	WindowPtr		window, keepPort;
	LayerObj		windowLayer, pieceLayer;
	short			dx, dy, adx, ady, ticksForMove, tickDiff, update;
	unsigned long	startTick;
	Point			lastLoc, mouseLoc, pt;

	lastLoc.h = lastLoc.v = 0x4000;
		/* Make sure that the first position gets updated.  We want a last mouse
		** location that is different than whatever the user would have clicked. */

	keepPort = SetFilePort(frHndl);
	GetPort(&window);

	ImageDocument(frHndl, true);

	NewLayer(&windowLayer, nil, nil, window, 8, 0);
		/* Create the layer object related to the window.  If NewLayer fails,
		** windowLayer is set to nil. */
	(*windowLayer)->dstRect = BoardRect();
		/* pieceLayer isn't the same size as the window's portRect.  By setting
		** windowLayer's dstRect, we change the area that the two layers map
		** to.  dstRect is set nil by NewLayer, and if it is left nil, then
		** the portRect is used for mapping.  Since we only want to map into
		** the window for the board, we set dstRect to just that portion of
		** the window. */
	gClearSquare = fromSq;
	gPiece       = (*frHndl)->doc.theBoard[fromSq];
	ImageDocument(frHndl, true);
	gClearSquare = 0;

	gTestRgn  = NewRgn();
	gColorRgn = ScreenDepthRegion(8);		/* Screen of 8-bit or greater get color icon. */
	pt.h = pt.v = 0;
	GlobalToLocal(&pt);
	OffsetRgn(gColorRgn, pt.h, pt.v);		/* Localize the area that gets color icons. */

	NewLayer(&pieceLayer, windowLayer, PieceLayerProc, nil, 8, 0);
		/* pieceLayer is created, and it maps to the board area of windowLayer.
		** Note that windowLayer is a parameter for pieceLayer.  If windowLayer
		** failed to get created, then this call will return a paramErr.  This
		** is because if you don't state a port, pixmap, or bitmap, the default
		** layerProc (which PieceLayerProc calls) uses the above layer to
		** determine the size and depth of an off-screen GWorld it automatically
		** creates.  If there is also no above layer, then there is nothing that
		** can be used as a basis for the GWorld, and that results in a paramErr. */

	InsertLayer(gBoardLayer, windowLayer, 2);
		/* Connect board layer in as the background layer. */
	InvalLayer(windowLayer, fromRect, false);
		/* On first update, redraw square where piece was picked up. */

	if (toLoc->h != 0x4000) {		/* If we have a start and end point, slide the piece. */
		startTick = TickCount();
		dx = adx = toLoc->h - fromLoc.h;
		if (adx < 0) adx = -adx;
		dy = ady = toLoc->v - fromLoc.v;
		if (ady < 0) ady = -ady;
		ticksForMove = (adx + ady) / 3;
		if (ticksForMove > 30) ticksForMove = 30;
			/* The piece slide will take at most half a second. */
	}

	for (;;) {
		if (toLoc->h == 0x4000) {		/* If user grabbed the piece, get where the mouse is now. */
			GetMouse(&mouseLoc);
			if (update = UpdateTime(frHndl, true)) DrawTime(frHndl);
			if (update == 2) {
				if ((*frHndl)->doc.twoPlayer) SendGame(frHndl, kIsMove, nil);
				AlertIfGameOver(frHndl);
				lastLoc.h = lastLoc.v = 0x4000;
				break;
			}
		}
		else {
			tickDiff = TickCount() - startTick;
			if (tickDiff > ticksForMove) tickDiff = ticksForMove;
			mouseLoc.h = fromLoc.h + dx * tickDiff / ticksForMove;
			mouseLoc.v = fromLoc.v + dy * tickDiff / ticksForMove;
				/* If sliding piece, calculate the new position, based on time. */
		}
		if ((lastLoc.h != mouseLoc.h) || (lastLoc.v != mouseLoc.v)) {
				/* If new piece position is different than last... */
			lastLoc = mouseLoc;
			gPieceRect = fromRect;
			gPieceRect.right  += 5;			/* Make space for the piece's shadow. */
			gPieceRect.bottom += 5;
			OffsetRect(&gPieceRect, mouseLoc.h - fromLoc.h - 2, mouseLoc.v - fromLoc.v - 2);
				/* Position the update rect at the new mouse location but offset 2
				** up and 2 left.  This offset is so the piece looks like it is
				** lifted from the board for the first update. */
			InvalLayer(windowLayer, gPieceRect, true);	/* Mark the area to be updated. */
			UpdateLayer(windowLayer);					/* DO IT. */
		}
		if (toLoc->h == 0x4000) {		/* If under user control... */
			if (!StillDown()) break;	/* Break if mouse is released. */
		}
		else if (tickDiff == ticksForMove) break;
			/* If piece being slid, break when it gets there. */
	}

	DetachLayer(gBoardLayer);
		/* Keep this permanent layer from being disposed of. */
	DisposeThisAndBelowLayers(windowLayer);
		/* Dispose of the layers and associated data. */
	DisposeRgn(gColorRgn);
	DisposeRgn(gTestRgn);

	SetPort(keepPort);
	*toLoc = lastLoc;		/* Return where the piece was dropped. */
}



/*****************************************************************************/



#pragma segment Config
static OSErr	PieceLayerProc(LayerObj theLayer, short message)
{
	OSErr	err;
	GrafPtr	thisPort;

	switch (message) {
		case kLayerInit:
			gCtab = nil;
				/* We will need a color table if the depth is greater than 1, and
				** we succeed in creating the pixMap for the layer.  Assume that
				** these conditions won't be met, and initialize the color table
				** reference to nil. */
			err = DefaultLayerProc(theLayer, kLayerInit);
			if (!err) {
				thisPort = (*theLayer)->layerPort;
				gDepth = 1;
				if (thisPort->portBits.rowBytes & 0x8000)
					gDepth = (*(((CGrafPtr)thisPort)->portPixMap))->pixelSize;
				if (gDepth != 1) gCtab = GetCTable(64 + 8);
					/* We need a color table for the shadow if depth is greater than 1. */
			}
			break;
		case kLayerDispose:
			err = DefaultLayerProc(theLayer, kLayerDispose);
				/* Do the standard dispose behavior. */
			if (gCtab) DisposeCTable(gCtab);
				/* Dispose of the color table for the piece shadow, if we have one. */
			break;
		case kLayerUpdate:
			err = DefaultLayerProc(theLayer, kLayerUpdate);
			SetLayerWorld(theLayer);
			PlotWithShadow(gPieceRect.left, gPieceRect.top);
				/* Draw the piece and shadow into the piece layer in the new position. */
			ResetLayerWorld(theLayer);
			break;
		default:
			err = DefaultLayerProc(theLayer, message);
				/* For future messages, use the default behavior. */
			break;
	}

	return(err);
}



/*****************************************************************************/



#pragma segment Config
static OSErr	BoardLayerProc(LayerObj theLayer, short message)
{
	OSErr		err;
	Rect		boardRect;
	GWorldPtr	layerWorld;
	CGrafPtr	keepPort;
	GDHandle	keepGDevice;

	switch (message) {
		case kLayerInit:
			boardRect = BoardRect();
			err = NewGWorld(&layerWorld, (*theLayer)->layerDepth, &boardRect, nil, nil, 0);
			if (!err) {		/* If we succeeded at creating the GWorld... */
				(*theLayer)->layerOwnsPort = true;
				GetGWorld(&keepPort, &keepGDevice);		/* To get the GDevice. */
				(*theLayer)->layerPort    = (GrafPtr)layerWorld;
				(*theLayer)->layerGDevice = keepGDevice;
				SetLayerWorld(theLayer);
				SetOrigin(boardRect.left, boardRect.top);
				EraseRect(&boardRect);
					/* Pre-clear the bitmap before imaging into it. */
				ImageBoardLines(1, kBoardHOffset, kBoardVOffset);
					/* Pre-image the lines dividing the squares. */
				ResetLayerWorld(theLayer);
			}
			break;
		default:
			err = DefaultLayerProc(theLayer, message);
				/* Default behavior for everything else. */
			break;
	}

	return(err);
}



/*****************************************************************************/



#pragma segment Config
void	PlotWithShadow(short x, short y)
{
	GrafPtr		curPort;
	Handle		shadowHndl;
	short		pieceShadow;
	ResType		iconType;
	Rect		iconRect, destRect;
	char		hstate;
	PixMap		shadowPixMap;

	iconType = (gDepth == 1) ? 'ICON' : 'icl8';
	if ((pieceShadow = gPiece) < 0) pieceShadow = -pieceShadow;
	shadowHndl = GetResource(iconType, 400 + pieceShadow);
	hstate = LockHandleHigh(shadowHndl);

	SetRect(&iconRect, 0, 0, 32, 32);
	shadowPixMap.baseAddr   = *shadowHndl;
	shadowPixMap.rowBytes   = (iconType == 'ICON') ? 4 : 0x8020;
	shadowPixMap.bounds     = iconRect;
	shadowPixMap.pmVersion  = 0;
	shadowPixMap.packType   = 0;
	shadowPixMap.packSize   = 0;
	shadowPixMap.hRes       = 0x00480000;
	shadowPixMap.vRes       = 0x00480000;
	shadowPixMap.pixelType  = 0;
	shadowPixMap.pixelSize  = 8;
	shadowPixMap.cmpCount   = 1;
	shadowPixMap.cmpSize    = 8;
	shadowPixMap.planeBytes = 0;
	shadowPixMap.pmTable    = gCtab;
	shadowPixMap.pmReserved = 0;

	destRect.bottom = (destRect.top  = y + 5) + 32;
	destRect.right  = (destRect.left = x + 5) + 32;
		/* Add 5 to offset the shadow. */

	GetPort(&curPort);
	CopyBits((BitMapPtr)&shadowPixMap, &(curPort->portBits), &iconRect, &destRect, srcOr, nil);
	HSetState(shadowHndl, hstate);

	if (!gPieceCIcon[gPiece + KING])
		gPieceCIcon[gPiece + KING] = ReadCIcon(gPiece + KING + 257);
	if (!gPieceCIcon[gPiece + KING + 13])
		gPieceCIcon[gPiece + KING + 13] = ReadCIcon(gPiece + KING + 13 + 257);

	OffsetRect(&destRect, -5, -5);
		/* 5 was added for the shadow.  This undoes that. */

	if (!RectInRgn(&destRect, gColorRgn))		/* If 1-bit, draw b/w icon. */
		DrawCIconByDepth(gPieceCIcon[gPiece + KING], destRect, 1, true);

	else {									/* Draw some combo of color and b/w icon. */
		RectRgn(gTestRgn, &destRect);
		SectRgn(gColorRgn, gTestRgn, gTestRgn);
		if ((*gTestRgn)->rgnSize == 10) {
			if (EqualRect(&((*gTestRgn)->rgnBBox), &destRect)) {		/* All color. */
				DrawCIconByDepth(gPieceCIcon[gPiece + KING + 13], destRect, 8, true);
				return;
			}
		}
		SetClip(gTestRgn);
		DrawCIconByDepth(gPieceCIcon[gPiece + KING + 13], destRect, 8, true);	/* Color part. */
		RectRgn(gTestRgn, &destRect);
		XorRgn(gColorRgn, gTestRgn, gTestRgn);
		SetClip(gTestRgn);
		DrawCIconByDepth(gPieceCIcon[gPiece + KING], destRect, 1, true);		/* b/w part. */
		SetRectRgn(gTestRgn, -32000, -32000, 32000, 32000);
		SetClip(gTestRgn);
	}
}




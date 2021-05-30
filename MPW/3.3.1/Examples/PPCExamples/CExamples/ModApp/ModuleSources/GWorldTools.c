/*
	File:		GWorldTools.c

	Contains:	A group of handy utilities for managing off-screen graphics worlds

	Written by:	Richard Clark

	Copyright:	© 1994 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

				 2/16/94	RC		Changed NewGWorld to allocate purgeable buffers
				 1/27/94	RC		Added pervasive error checking (i.e. is the buffer not NIL?)
				 					before performing any operation.
				 1/14/94	RC		Created

	To Do:
*/


#ifndef __QUICKDRAW__
	#include <Types.h>
#endif

#ifndef __QUICKDRAW__
	#include <Quickdraw.h>
#endif

#ifndef __QUICKDRAW__
	#include <Windows.h>
#endif

#ifndef __QDOFFSCREEN__
	#include <QDOffscreen.h>
#endif

#ifndef __ERRORS__
	#include <Errors.h>
#endif

#ifndef __LOWMEM__
	#include <LowMem.h> 	// For MemError()
#endif

#include "GWorldTools.h"

Rect GetGlobalBounds (WindowPtr wp)
{
	/* return the bounds of this window, in global coordinates 		*/
	Rect  bounds;

	if (((WindowPeek)wp)->visible)
		bounds = (*((WindowPeek)wp)->contRgn)->rgnBBox;
	else
		/* get the size in local coordinates since we can't depend on anything else */
		bounds = wp->portRect;

	return bounds;
}

OSErr LockBuffer (GWorldPtr buffer, GWorldFlags *oldPixState)
{
	PixMapHandle	bufferPixMap;
	OSErr			err = noErr;
	
	if (buffer) {
		/* Lock down our off-screen image */
		bufferPixMap = GetGWorldPixMap(buffer);
		*oldPixState = GetPixelsState(bufferPixMap);
		if (!LockPixels(bufferPixMap))
			err = kPixelsPurged;
	}
	return err;
}


OSErr UnlockBuffer (GWorldPtr buffer, GWorldFlags oldPixState)
{
	PixMapHandle	bufferPixMap;

	/* Undo the effects of "LockBuffer" */
	if (buffer) {
		bufferPixMap = GetGWorldPixMap(buffer);
		SetPixelsState(bufferPixMap, oldPixState);
	}
	return noErr;
}

OSErr CopyBufferToWindow (WindowPtr wp, GWorldPtr buffer)
{
	/* Copy the image from the offscreen buffer to the window */
	OSErr			err;
	RgnHandle		imageRgn, growIconRgn;
	Rect			portRect, growIconRect;
	GWorldFlags		oldPixState;
	PixMapHandle	bufferPixMap;

	portRect = wp->portRect;
	if (buffer) {
		bufferPixMap = GetGWorldPixMap(buffer);
		err = LockBuffer(buffer, &oldPixState);
		if (err) goto done;
	}
	
	/* Construct a mask region which omits the grow icon */
	growIconRect = portRect;
	growIconRect.top = growIconRect.bottom - 15;
	growIconRect.left = growIconRect.right - 15;
	imageRgn = NewRgn();
	RectRgn(imageRgn, &portRect);
	growIconRgn = NewRgn();
	RectRgn(growIconRgn, &growIconRect);
	DiffRgn(imageRgn, growIconRgn, imageRgn);
	
	/* Draw, podnah */
	SetPort(wp);
	ForeColor(blackColor);
	BackColor(whiteColor);
	CopyBits((BitMap*)*bufferPixMap,
			&wp->portBits,
			&buffer->portRect,
			&portRect,
			srcCopy, imageRgn);
	
	DisposeRgn(imageRgn);
	DisposeRgn(growIconRgn);
	
	UnlockBuffer(buffer, oldPixState);

done:
	return err;
}


OSErr UpdateBuffer (WindowPtr wp, GWorldPtr* buffer)
{
	Rect			globalBounds;
	GWorldFlags		newGWorldState;
	OSErr			err = noErr;
	
	if (*buffer) {
		globalBounds = GetGlobalBounds(wp);
		newGWorldState = UpdateGWorld(buffer, 0, &globalBounds, NULL, NULL, 0);
		// We may have encountered an error, so see if the returned result is
		// one of the known error codes.
		if ((newGWorldState == paramErr) || (newGWorldState == cDepthErr))
			err = (OSErr)newGWorldState;
	}
	return err;
}


OSErr DisposeBuffer (GWorldPtr* buffer)
{
	if (*buffer)
		DisposeGWorld(*buffer);
	*buffer = NULL;
	return MemError();
}

OSErr AllocateBuffer (WindowPtr wp, Rect bounds, GWorldPtr* buffer, Boolean disposeOld)
{
#pragma unused (wp)
	OSErr			err = noErr;
	CGrafPtr		oldPort;
	GDHandle		oldDevice;
	
	GetGWorld(&oldPort,&oldDevice);

	if (disposeOld && (buffer != NULL) && (*buffer != NULL))
		DisposeGWorld(*buffer);
	
	err = NewGWorld(buffer, 0, &bounds, NULL, NULL, pixPurge);
	
	if (err) {
		*buffer = NULL;
		goto done;
	}
	
	/* Erase the new buffer */
	if ((buffer) && (*buffer)) {
		OSErr		err2;
		GWorldFlags oldPixState;
		
		err2 = LockBuffer (*buffer, &oldPixState);
		if (err2 == noErr) {
			SetGWorld(*buffer, NULL);
			EraseRect(&(*buffer)->portRect);
			UnlockBuffer(*buffer, oldPixState);
		}
	} else
		err = memFullErr;
	
done:
	SetGWorld(oldPort, oldDevice);
	return err;
}


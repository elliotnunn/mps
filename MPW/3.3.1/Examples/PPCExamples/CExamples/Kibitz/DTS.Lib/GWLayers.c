/*
** Apple Macintosh Developer Technical Support
**
** Program:	    DTS.Lib
** File:        GWLayers.c
** Written by:  Eric Soldan and Forrest Tanaka
**
** Copyright © 1989-1993 Apple Computer, Inc.
** All rights reserved.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */

/* This is an implementation of off-screen GWorld handling.  This particular
** implementation uses GWorlds in a hierarchical manner, with each layer in
** the hierarchy having its own tasks to handle at its specific level.
** The advantage to this is that it can conform to many applications.  Each
** application may need a different number of layers, and each layer may
** need to perform a different kind of operation.  By having an unlimited
** number of layers, and by having each layer handle its own application
** specific tasks, off-screen GWorld handling can be standardized.
**
** A common use for off-screen stuff is to move an object around in a 
** window over a background.  To accomplish this, we need 3 layers.
** These are:
**
** 1) The window layer.  This layer transfers a rectangle of pixels from
**    the middle layer into the window layer, once the middle layer is ready.
**    The rectangle transferred would be large enough to cover the old
**    location and the new location, thus moving the piece without having
**    to turn it off in the old location as a separate step.  This gives a
**    very smooth appearance when moving an object.
** 2) A middle layer that is used to apply the object being moved to the
**    background plus removing the object from the old location.  Once these
**    two tasks are done, the off-screen work area is ready to be transferred
**    to the window layer.
** 3) A background image against which the object moves.  This is used to
**    restore the middle layer at the location where the object being moved
**    was last at.
**
** The top layer object relates to the window, and therefore we don't need an
** off-screen GWorld for it.  A call to create this layer might look like the below:
**
** err = NewLayer(&windowLayer,   Layer object handle is returned here.
**                nil,            Top layer, so there is no above layer.
**                nil,            Uses default layer procedure.
**                window,         Window used by the layer object.
**                0,              Desired depth (0 for screen depth).
**                0);             Custom layer init data, if any.
**
** If NewLayer succeeds, the layer object handle is returned in windowLayer.
** If it fails, nil is returned in windowLayer, plus an error is returned.
** If windowLayer is successfully created, then we can proceed to create the
** next two layers.  In the case below, we are creating an off-screen layer
** that has a pixmap the same size and depth as windowLayer.  If this is
** what we want for the middle layer, then we can again use the default
** LayerProc for the kLayerInit message.  All we need to do is to call the
** default layerProc with a kLayerInit message.  We want the standard
** action for initialization, but we want our own update action.  That's
** why we have a custom layerProc for the middle layer.  The call would look
** something like the below:
**
** err = NewLayer(&middleLayer,     Layer object handle is returned here.
**                windowLayer,      Layer above this layer.
**                MiddleLayerProc,  Custom layerProc.
**                nil,              Create a pixmap for layer.
**                0,                Pixmap created as same size/depth as above layer.
**                0);
**
** The background layer would be created similarly.  When you are finished with
** the layers, you can dispose of them one at a time with DisposeLayer, or you
** can dispose of all of them in the layer chain with DisposeThisAndBelowLayers.
**
** Inserting a layer is done by position, and not by which layer it goes above
** or below.  The reason for this is that the layer positions are most likely
** absolute, and therefore it is better to indicate their position with an
** absolute number instead of always relating it to some other layer.  If it
** is necessary to insert a layer specifically above or below some other layer,
** it would be done as follows:
**     	InsertLayer(newLayer, aboveLayer, GetLayerPosition(aboveLayer) + 1);
**     	InsertLayer(newLayer, belowLayer, GetLayerPosition(belowLayer));
**
** The sample applications DTS.Draw and Kibitz uses the off-screen layer code.
** For a sample usage, see the file Window2.c in DTS.Draw, or Offscreen.c in Kibitz.
*/



/*****************************************************************************/



#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __GESTALTEQU__
#include <GestaltEqu.h>
#endif

#ifndef __GWLAYERS__
#include "GWLayers.h"
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __WINDOWS__
#include <Windows.h>
#endif

#define kQDOriginal 0

static OSErr	DefaultLayerInit(LayerObj theLayer);
static OSErr	DefaultLayerUpdate(LayerObj theLayer);
static OSErr	DefaultLayerDispose(LayerObj theLayer);

static OSErr	MakeLayerWorld(GWorldPtr *layerWorld, LayerObj theLayer, Rect bnds);
static void		KillLayerWorld(LayerObj theLayer);
static void		SmartGetGWorld(CGrafPtr *port, GDHandle *gdh);
static void		SmartSetGWorld(CGrafPtr port, GDHandle gdh);
static short	GetQDVersion(void);



/*****************************************************************************/
/*****************************************************************************/



#pragma segment GWLayers
OSErr	NewLayer(LayerObj *newLayer, LayerObj aboveLayer, LayerProc theProc,
				 GrafPtr basePort, short depth, unsigned long theData)
{
	OSErr		err;
	LayerRecPtr	lptr;
	CGrafPtr	scratchPort;
	GDHandle	baseGDevice;

	*newLayer = (LayerObj)NewHandleClear(sizeof(LayerRec));
	if (err = MemError()) return(err);
		/* If not enough memory for layer object, return nil and error. */

	SmartGetGWorld(&scratchPort, &baseGDevice);
	if (!theProc)
		theProc = DefaultLayerProc;
			/* If layer proc is nil, then they want the default behavior. */

	lptr = **newLayer;
	lptr->layerPort     = basePort;
	lptr->layerGDevice  = baseGDevice;
	lptr->layerDepth    = depth;
	lptr->xferMode      = srcCopy;
	lptr->layerProc     = theProc;
	lptr->layerData     = theData;
		/* Layer object is now initialized, except for layers that need a GWorld
		** created.  This will occur when the layer proc is called with an
		** initialization message.  (All fields not explicitly set are 0.) */

	InsertLayer(*newLayer, aboveLayer, GetLayerPosition(aboveLayer) + 1);
		/* Connect the layer to the layer chain.  The default initialization
		** behavior may need this, as it may create a GWorld of the same size
		** as the above layer.  If it isn't connected to the layer chain, then
		** there is no above layer. */

	if (err = (*theProc)(*newLayer, kLayerInit)) {
		DisposeLayer(*newLayer);
		*newLayer = nil;
			/* There wasn't enough memory to create the off-screen GWorld, so
			** dispose of the layer object.  Since we failed, we need to return
			** nil and the error. */
	}

	return(err);
}



/*****************************************************************************/



#pragma segment GWLayers
void	DetachLayer(LayerObj theLayer)
{
	LayerObj	aboveLayer, belowLayer;

	if (theLayer) {
		aboveLayer = (*theLayer)->aboveLayer;
		belowLayer = (*theLayer)->belowLayer;
		if (aboveLayer)
			(*aboveLayer)->belowLayer = belowLayer;
		if (belowLayer)
			(*belowLayer)->aboveLayer = aboveLayer;
		(*theLayer)->aboveLayer = (*theLayer)->belowLayer = nil;
	}
}



/*****************************************************************************/



#pragma segment GWLayers
OSErr	DisposeLayer(LayerObj theLayer)
{
	OSErr	err;

	err = noErr;
	if (theLayer) {
		err = (*((*theLayer)->layerProc))(theLayer, kLayerDispose);
		DetachLayer(theLayer);
		DisposeHandle((Handle)theLayer);
	}

	return(err);
}



/*****************************************************************************/



#pragma segment GWLayers
OSErr	DisposeThisAndBelowLayers(LayerObj theLayer)
{
	OSErr	err, err2;

	err = noErr;
	if (theLayer) {
		err2 = DisposeThisAndBelowLayers((*theLayer)->belowLayer);
		err  = DisposeLayer(theLayer);
		if (!err)
			err = err2;
	}
	return(err);
}



/*****************************************************************************/



#pragma segment GWLayers
short	GetLayerPosition(LayerObj theLayer)
{
	short	pos;

	if (!theLayer) return(0);

	for (pos = 0; theLayer = (*theLayer)->aboveLayer; ++pos);
	return(pos);
}



/*****************************************************************************/



#pragma segment GWLayers
LayerObj	GetTopLayer(LayerObj theLayer)
{
	for (; (*theLayer)->aboveLayer; theLayer = (*theLayer)->aboveLayer);
	return(theLayer);
}



/*****************************************************************************/



#pragma segment GWLayers
LayerObj	GetBottomLayer(LayerObj theLayer)
{
	for (; (*theLayer)->belowLayer; theLayer = (*theLayer)->belowLayer);
	return(theLayer);
}



/*****************************************************************************/



#pragma segment GWLayers
void	InsertLayer(LayerObj theLayer, LayerObj referenceLayer, short pos)
{
	LayerObj	aboveLayer, belowLayer;
	short		i;

	if (theLayer) {
		if (theLayer == referenceLayer) {
			/* If theLayer layer is the same as referenceLayer... */

			if (belowLayer = (*theLayer)->belowLayer)
				referenceLayer = belowLayer;
			if (aboveLayer = (*theLayer)->aboveLayer)
				referenceLayer = aboveLayer;
					/* Try to make the reference layer not the same as theLayer.
					** If it is the same as theLayer, then when theLayer is
					** removed from the old hierarchy, we lose the ability to re-add
					** it to the hierarchy in a new location. */
		}

		DetachLayer(theLayer);
			/* Remove layer from its old hierarchy, if any. */

		if (!referenceLayer) return;
			/* If there isn't a valid alternative reference, then theLayer
			** IS the hierarchy and no action is taken. */

		aboveLayer = nil;
		belowLayer = GetTopLayer(referenceLayer);
			/* aboveLayer now nil.  belowLayer now is top layer.  These
			** are the correct values if the layer being added is to be
			** the new top layer.  This will be the case if pos is 0.
			** We now walk the linked list pos number of times to get the
			** correct position.  We also terminate if we reach the end
			** of the linked list, no matter what pos is.  This will allow
			** values of pos that are too big to insert the layer at the
			** end of the linked list. */

		for (i = 0; ((belowLayer) && (i != pos)); ++i) {
			aboveLayer = belowLayer;
			belowLayer = (*belowLayer)->belowLayer;
		}
			/* We now have correct values for aboveLayer and belowLayer.  Note that
			** these values may be nil, which would be correct. */
		if ((*theLayer)->aboveLayer = aboveLayer)
			(*aboveLayer)->belowLayer = theLayer;
		if ((*theLayer)->belowLayer = belowLayer)
			(*belowLayer)->aboveLayer = theLayer;
	}
}



/*****************************************************************************/



#pragma segment GWLayers
OSErr	UpdateLayer(LayerObj theLayer)
{
	OSErr	err;

	err = noErr;
	if (theLayer) {
		err = UpdateLayer((*theLayer)->belowLayer);
			/* Handle the updates from the bottom up. */
		if (!err)
			err = (*((*theLayer)->layerProc))(theLayer, kLayerUpdate);
				/* Chain possible errors through each level of recursion. */
	}
	return(err);
}



/*****************************************************************************/



#pragma segment GWLayers
Rect	GetEffectiveSrcRect(LayerObj theLayer)
{
	Rect	srcRect;

	if (!theLayer)
		SetRect(&srcRect, 0, 0, 0, 0);
	else {
		srcRect = (*theLayer)->srcRect;
		if (EmptyRect(&srcRect))
			srcRect = ((*theLayer)->layerPort)->portRect;
	}
	return(srcRect);
}



/*****************************************************************************/



#pragma segment GWLayers
Rect	GetEffectiveDstRect(LayerObj theLayer)
{
	Rect	dstRect;

	if (!theLayer)
		SetRect(&dstRect, 0, 0, 0, 0);
	else {
		dstRect = (*theLayer)->dstRect;
		if (EmptyRect(&dstRect))
			dstRect = ((*theLayer)->layerPort)->portRect;
	}
	return(dstRect);
}



/*****************************************************************************/



#pragma segment GWLayers
OSErr	DefaultLayerProc(LayerObj theLayer, short message)
{
	OSErr	err;

	err = noErr;
	if (theLayer) {
		switch (message) {		/* Dispatch to the correct default behavior. */
			case kLayerInit:
				err = DefaultLayerInit(theLayer);
				break;
			case kLayerDispose:
				err = DefaultLayerDispose(theLayer);
				break;
			case kLayerUpdate:
				err = DefaultLayerUpdate(theLayer);
				break;
			default:
				break;
		}
	}
	return(err);
}



/*****************************************************************************/



#pragma segment GWLayers
Rect	UpdateUpdateRects(LayerObj theLayer)
{
	Rect	lastUpdate, thisUpdate, dstRect;

	if (theLayer) {
		lastUpdate = (*theLayer)->lastUpdate;
		(*theLayer)->lastUpdate = thisUpdate = (*theLayer)->thisUpdate;
		SetRect(&((*theLayer)->thisUpdate), 0, 0, 0, 0);

		if ((*theLayer)->includeLastUpdate) {
			(*theLayer)->includeLastUpdate = false;
			if (EmptyRect(&lastUpdate))
				lastUpdate = thisUpdate;
			if (EmptyRect(&thisUpdate))
				thisUpdate = lastUpdate;
			UnionRect(&thisUpdate, &lastUpdate, &thisUpdate);
				/* We are going to update the last and current update rects.
				** This will allow the appearance of movement for a foreground
				** object.  The old location is cleared, plus the new location
				** is updated. */
			dstRect = GetEffectiveDstRect(theLayer);
			SectRect(&thisUpdate, &dstRect, &thisUpdate);
		}
	}
	else SetRect(&thisUpdate, 0, 0, 0, 0);

	return(thisUpdate);
}



/*****************************************************************************/



#pragma segment GWLayers
void	InvalLayer(LayerObj theLayer, Rect invalRect, Boolean includeLastUpdate)
{
	Rect		thisUpdate, srcRect, dstRect;
	LayerObj	belowLayer;
	short		ow, oh;
	long		dw, dh, sw, sh;

	if (theLayer) {
		belowLayer = (*theLayer)->belowLayer;
		dstRect    = GetEffectiveDstRect(theLayer);

		SectRect(&dstRect, &invalRect, &invalRect);
		if (!EmptyRect(&invalRect)) {				/* If there is something to invalidate... */
			thisUpdate = (*theLayer)->thisUpdate;	/* There may be a prior unhandled update... */
			if (EmptyRect(&thisUpdate))
				thisUpdate = invalRect;				/* UnionRect doesn't */
			UnionRect(&thisUpdate, &invalRect, &(*theLayer)->thisUpdate);	/* like empty rects. */

			if (belowLayer) {
				/* If we have a below layer, then pass the update down.  The effectiveSrcRct
				** rect for the below layer may be a different size than the effectiveDstRct.
				** If this is the case, we want to scale invalRect to invalidate a proportional
				** area in the below layer. */

				srcRect = GetEffectiveSrcRect(belowLayer);

				dw = dstRect.right  - dstRect.left;		/* Calculate widths and heights for */
				dh = dstRect.bottom - dstRect.top;		/* srcRect and dstRect. */
				sw = srcRect.right  - srcRect.left;
				sh = srcRect.bottom - srcRect.top;

				OffsetRect(&invalRect, -dstRect.left, -dstRect.top);
					/* We want to align the upper-left corner of the srcRect and dstRect
					** so that the scaling also aligns the invalRect into the correct
					** place in the below layer's effectiveSrcRect.  invalRect is now
					** positioned relative to a dstRect with a upper-left corner of 0,0. */

				if (dw != sw) {		/* Width dstRect different than srcRect. */
					ow = invalRect.right  - invalRect.left;
					invalRect.left  = (short)((invalRect.left  * sw) / dw);
					invalRect.right = (short)((invalRect.right * sw) / dw);
					if ((((invalRect.right  - invalRect.left) * dw) / sw) != ow)
						++invalRect.right;
							/* We can possibly lose a fraction of a pixel on the right edge when
							** scaling the invalRect.  It won't hurt if we inval just a bit too
							** much, whereas invalidating too little is a bad thing. */
				}

				if (dh != sh) {		/* Height dstRect different than srcRect. */
					oh = invalRect.bottom - invalRect.top;
					invalRect.top    = (short)((invalRect.top    * sh) / dh);
					invalRect.bottom = (short)((invalRect.bottom * sh) / dh);
					if ((((invalRect.bottom - invalRect.top ) * dh) / sh) != oh)
						++invalRect.bottom;
				}

				OffsetRect(&invalRect, srcRect.left, srcRect.top);
					/* Displace the new invalRect correctly relative to the srcRect. */
			}
		}

		if (includeLastUpdate)
			(*theLayer)->includeLastUpdate = true;
				/* If requested to update last position as well, flag it. */

		InvalLayer(belowLayer, invalRect, includeLastUpdate);
			/* Invalidate the below layer with the new (possibly scaled) invalRect. */
	}
}


/*****************************************************************************/



#pragma segment GWLayers
void	SetLayerWorld(LayerObj theLayer)
{
	CGrafPtr	keepPort;
	GDHandle	keepGDevice;

	/* This is a convenient call for setting a GWorld, while remembering what
	** the previous GWorld was.  This should be balanced with a call to
	** ResetLayerWorld.  A count of how many times this is called is kept
	** so that the old GWorld is cached only if SetLayerWorld is currently
	** in balance with ResetLayerWorld.  This keeps the oldest kept GWorld
	** from being overwritten by subsequent calls. */

	if (theLayer) {
		if (!(*theLayer)->cachedCount++) {
			SmartGetGWorld(&keepPort, &keepGDevice);
			(*theLayer)->cachedPort    = keepPort;
			(*theLayer)->cachedGDevice = keepGDevice;
		}
		SmartSetGWorld((CGrafPtr)(*theLayer)->layerPort, (*theLayer)->layerGDevice);
		LockLayerWorld(theLayer);
	}
}



/*****************************************************************************/



#pragma segment GWLayers
void	ResetLayerWorld(LayerObj theLayer)
{
	/* This is used to undo a call to SetLayerWorld.  Calls to ResetLayerWorld
	** should be balanced with previous calls to SetLayerWorld. */

	if (theLayer) {
		UnlockLayerWorld(theLayer);
		if (!--(*theLayer)->cachedCount)
			SmartSetGWorld((*theLayer)->cachedPort, (*theLayer)->cachedGDevice);
	}
}



/*****************************************************************************/



#pragma segment GWLayers
void	LockLayerWorld(LayerObj theLayer)
{
	Handle	bitmap;

	/* This is a convenient way to lock down the pixels for a layer's GWorld.
	** A locked count is kept to make sure that the GWorld is locked only the
	** first time this is called.  Calls to LockLayerWorld will most likely
	** be balanced by calls to UnlockLayerWorld, but not necessarily.  It may
	** be desirable to keep a GWorld call locked.  In this case, right after
	** creating the layer (and indirectly its GWorld), call LockLayerWorld.
	** This will initially lock it.  Subsequent calls would be balanced, and
	** therefore there will always be one more LockLayerWorld call than
	** UnlockLayerWorld calls.  This will keep it locked. */

	if (theLayer) {
		if ((*theLayer)->layerOwnsPort) {
			if (!(*theLayer)->lockedCount++) {
				if (bitmap = (*theLayer)->layerBitmap) {
					HLock(bitmap);
					(*theLayer)->layerPort->portBits.baseAddr = *bitmap;
				}
				else
					LockPixels(GetGWorldPixMap((GWorldPtr)(*theLayer)->layerPort));
			}
		}
	}
}



/*****************************************************************************/



#pragma segment GWLayers
void	UnlockLayerWorld(LayerObj theLayer)
{
	Handle	bitmap;

	/* This undoes what LockLayerWorld does.  Calls to UnlockLayerWorld will
	** generally be balanced with calls to LockLayerWorld. */

	if (theLayer) {
		if ((*theLayer)->layerOwnsPort) {
			if (!--(*theLayer)->lockedCount) {
				if (bitmap = (*theLayer)->layerBitmap)
					HUnlock(bitmap);
				else
					UnlockPixels(GetGWorldPixMap((GWorldPtr)(*theLayer)->layerPort));
			}
		}
	}
}



/*****************************************************************************/



#pragma segment GWLayers
RgnHandle	ScreenDepthRegion(short depth)
{
	RgnHandle		retRgn, tmpRgn;
	GDHandle		device;
	PixMapHandle	pmap;
	Rect			rct;
	GrafPtr			mainPort;

	retRgn = NewRgn();

	if (GetQDVersion() == kQDOriginal) {
		if (depth == 1) {
			GetWMgrPort(&mainPort);
			rct = mainPort->portRect;
			RectRgn(retRgn, &rct);
		}
	}
	else {
		tmpRgn = NewRgn();
		for (device = GetDeviceList(); device; device = GetNextDevice(device)) {
			if (
				(TestDeviceAttribute(device, screenDevice)) &&
				(TestDeviceAttribute(device, screenActive))
			) {
				pmap = (*device)->gdPMap;
				if ((*pmap)->pixelSize >= depth) {
					rct = (*device)->gdRect;
					RectRgn(tmpRgn, &rct);
					UnionRgn(retRgn, tmpRgn, retRgn);
				}
			}
		}
		DisposeRgn(tmpRgn);
	}

	return(retRgn);
}



/*****************************************************************************/



#pragma segment GWLayers
CIconHandle	ReadCIcon(short iconID)
{
	Handle	hndl;

	if (GetQDVersion() == kQDOriginal) {
		hndl = GetResource('cicn', iconID);
		DetachResource(hndl);
		return((CIconHandle)hndl);
	}

	return(GetCIcon(iconID));
}



/*****************************************************************************/



#pragma segment GWLayers
void	KillCIcon(CIconHandle icon)
{
	if (!icon) return;

	if (GetQDVersion() == kQDOriginal)
		DisposeHandle((Handle)icon);
	else
		DisposeCIcon(icon);
}



/*****************************************************************************/



#pragma segment GWLayers
void	DrawCIcon(CIconHandle icon, Rect destRect)
{
	if (!icon) return;

	if (GetQDVersion() == kQDOriginal)
		DrawCIconByDepth(icon, destRect, 1, true);
	else
		PlotCIcon(&destRect, icon);
}



/*****************************************************************************/



#pragma segment GWLayers
void	DrawCIconNoMask(CIconHandle icon, Rect destRect)
{
	Rect	iconRect;
	char	oldMask[128], *mptr;
	short	maskSize, i;

	if (!icon) return;

	mptr = (Ptr)(*icon)->iconMaskData;
	iconRect = (*icon)->iconPMap.bounds;
	maskSize = (iconRect.bottom - iconRect.top) * (*icon)->iconMask.rowBytes;
	for (i = 0; i < maskSize; ++i) {
		oldMask[i] = mptr[i];
		mptr[i] = 0xFF;
	}
	DrawCIcon(icon, destRect);
	mptr = (Ptr)(*icon)->iconMaskData;
	for (i = 0; i < maskSize; ++i) mptr[i] = oldMask[i];
}



/*****************************************************************************/



#pragma segment GWLayers
void	DrawCIconByDepth(CIconHandle icon, Rect destRect, short depth, Boolean useMask)
{
	GrafPtr		curPort;
	char		savedIconState;
	char		savedDataState;
	short		offset;
	BitMapPtr	bmap;
	Rect		iconRect;

	if (!icon) return;

	GetPort(&curPort);

	if (!depth) {
		if (!(curPort->portBits.rowBytes & 0x8000))
			depth = 1;
		else
			depth = (*(((CGrafPtr)curPort)->portPixMap))->pixelSize;
	}

	savedIconState = HGetState((Handle)icon);		/* Lock down things. */
	HLock((Handle)icon);
	if (depth > 1) {
		savedDataState = HGetState((*icon)->iconData);
		HLock((*icon)->iconData);
		(*icon)->iconPMap.baseAddr = *((*icon)->iconData);
			/* Point the icon's pixMap at the color icon data. */
	}

	iconRect = (*icon)->iconPMap.bounds;
		/* Find out the dimensions of the icon. */

	(*icon)->iconMask.baseAddr = (Ptr)(*icon)->iconMaskData;
		/* Point the mask's bitMap at the mask data. */

	offset  = iconRect.bottom - iconRect.top;
	offset *= (*icon)->iconMask.rowBytes;
	(*icon)->iconBMap.baseAddr = (*icon)->iconMask.baseAddr + offset;
		/* Point the icon's bitMap at the b/w icon data. */

	bmap = (depth == 1) ? (BitMapPtr)&((*icon)->iconBMap) : (BitMapPtr)&((*icon)->iconPMap);
	if (useMask)
		CopyMask(bmap, &((*icon)->iconMask), &curPort->portBits, &iconRect, &iconRect, &destRect);
	else
		CopyBits(bmap, &curPort->portBits, &iconRect, &destRect, srcCopy, nil);

	HSetState((Handle)icon, savedIconState);		/* Unlock things. */
	if (depth > 1)
		HSetState((*icon)->iconData, savedDataState);
}



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



#pragma segment GWLayers
static OSErr	DefaultLayerInit(LayerObj theLayer)
{
	LayerObj	aboveLayer;
	GWorldPtr	layerWorld;		/* GWorld for this layer. */
	Rect		parentRect;		/* Rectangle of parent in global coordinates. */
	GrafPtr		parentPort;		/* Parent layer's GrafPort. */
	GDHandle	parentGDevice;	/* Parent layer's GDevice. */
	CGrafPtr	keepPort;		/* Saved GrafPort. */
	GDHandle	keepGDevice;	/* Saved GDevice. */
	Point		org;
	OSErr		err;
	short		depth;

	err = noErr;
	if (theLayer) {
		if (!(*theLayer)->layerPort) {

			if (aboveLayer = (*theLayer)->aboveLayer) {
				/* The default behavior is to create a GWorld the same size
				** as the above layer, if there is one.  If there isn't an above
				** layer and we were expected to create a GWorld, we have problems.
				** This situation can't be resolved and is handled as a paramErr. */

				if (!((*theLayer)->layerDepth))
					(*theLayer)->layerDepth = (*aboveLayer)->layerDepth;

				SmartGetGWorld(&keepPort, &keepGDevice);		/* Keep the GWorld. */

				parentPort    = (*aboveLayer)->layerPort;
				parentGDevice = (*aboveLayer)->layerGDevice;
					/* Grab the parent layer's GrafPort and GDevice. */
	
				SmartSetGWorld((CGrafPtr)parentPort, parentGDevice);
				parentRect = GetEffectiveDstRect(aboveLayer);
					/* The default behavior is to use the portRect of the above
					** port.  This behavior can be overridden if desired by setting
					** dstRect.  dstRect is initialized to be empty, but if
					** it is specifically set, then this layer should map into
					** just the dstRect and not the portRect.  This is useful if
					** the off-screen image is to be displayed in only a portion
					** of a window. */

				org.h = parentRect.left;
				org.v = parentRect.top;

				LocalToGlobal(((Point *)&parentRect) + 0);
				LocalToGlobal(((Point *)&parentRect) + 1);
					/* Put the parent layer's destination rect in global coordinates. */
	
				if (GetQDVersion())
					err = NewGWorld(&layerWorld, (*theLayer)->layerDepth, &parentRect, nil, nil, 0);
						/* Create the GWorld for this layer.  It will be created with the
						** requested depth.  If the requested depth is 0, then it will be
						** created with a depth great enough for the deepest monitor the
						** parentRect intersects. */
				else
					err = MakeLayerWorld(&layerWorld, theLayer, parentRect);
						/* Create a bitmap for those systems without GWorlds. */

				if (err == noErr) {
					(*theLayer)->layerOwnsPort = true;
					SetPort((*theLayer)->layerPort = (GrafPtr)layerWorld);
						/* Save the new GWorld in the layer object. */
					SetOrigin(org.h, org.v);
						/* Set the origin so that this GWorld maps directly into the
						** area to be copied into (dstRect or portRect) for the
						** above layer. */

					if (!((*theLayer)->layerDepth)) {
						if (((GrafPtr)layerWorld)->portBits.rowBytes & 0x8000)
							depth = (*(((CGrafPtr)layerWorld)->portPixMap))->pixelSize;
						else
							depth = 1;
						(*theLayer)->layerDepth = depth;
					}
				}

				SmartSetGWorld(keepPort, keepGDevice);		/* Restore the kept GWorld. */
			}
			else {
				err = paramErr;
					/* We were expected to create an off-screen GWorld of the
					** same size as the above layer, but we didn't have an above
					** layer.  This is an error.  The parameters passed to NewLayer
					** were inappropriate for the situation, so return a paramErr. */
			}
		}
	}

	return(err);
}



/*****************************************************************************/



#pragma segment GWLayers
static OSErr	DefaultLayerUpdate(LayerObj theLayer)
{
	LayerObj	belowLayer;
	GrafPtr		belowPort, thisPort;
	GDHandle	thisGDevice;
	CGrafPtr	keepPort;
	GDHandle	keepGDevice;
	Rect		thisUpdate, belowRect, thisRect;
	short		xfer;
	RgnHandle	rgn;

	/* The default update behavior is to copy the area to be updated from the
	** below layer into the indicated layer.  We only need to update layer if
	** there is a below layer.  The bottom-most layer update doesn't do anything.
	** As a default, the bottom-most layer is considered background and does not
	** get updated. */

	if (theLayer) {
		if (belowLayer = (*theLayer)->belowLayer) {
			/* Get this layer's GWorld and below layer's port. */
			thisPort    = (*theLayer)->layerPort;
			thisGDevice = (*theLayer)->layerGDevice;
			belowPort   = (*belowLayer)->layerPort;

			/* Save current GWorld and set the parent's GWorld. */
			SmartGetGWorld(&keepPort, &keepGDevice);
			SmartSetGWorld((CGrafPtr)thisPort, thisGDevice);

			thisUpdate = UpdateUpdateRects(theLayer);

			rgn = NewRgn();
			RectRgn(rgn, &thisUpdate);

			belowRect = GetEffectiveSrcRect(belowLayer);
			thisRect  = GetEffectiveDstRect(theLayer);

				/* As a default behavior, we CopyBits the below layer into this layer. */
			LockLayerWorld(belowLayer);
			LockLayerWorld(theLayer);
			xfer = (*theLayer)->xferMode;
			CopyBits(&belowPort->portBits, &thisPort->portBits, &belowRect, &thisRect, xfer, rgn);
			UnlockLayerWorld(theLayer);
			UnlockLayerWorld(belowLayer);
			DisposeRgn(rgn);

			SmartSetGWorld(keepPort, keepGDevice);		/* Restore to the kept GWorld. */
		}
	}
	return(noErr);
}



/*****************************************************************************/



#pragma segment GWLayers
static OSErr	DefaultLayerDispose(LayerObj theLayer)
{
	GWorldPtr	theWorld;

	if (theLayer) {
		if ((*theLayer)->layerOwnsPort) {
			if (theWorld = (GWorldPtr)(*theLayer)->layerPort) {
				if ((*theLayer)->layerBitmap)
					KillLayerWorld(theLayer);
				else
					DisposeGWorld(theWorld);
			}
		}
	}

	return(noErr);
}



/*****************************************************************************/



#pragma segment GWLayers
static OSErr	MakeLayerWorld(GWorldPtr *layerWorld, LayerObj theLayer, Rect bnds)
{
	GrafPtr	oldPort;
	GrafPtr	newPort;
	Handle	bitmap;
	OSErr	err;

	OffsetRect(&bnds, -bnds.left, -bnds.top);	/* Make sure upper-left is 0,0. */

	GetPort(&oldPort);		/* Need this to restore the port after OpenPort. */

	newPort = (GrafPtr)NewPtr(sizeof(GrafPort));		/* Allocate the grafPort. */
	if (err = MemError())
		return(err);		/* Failed to allocate the off-screen port. */

	/* The call to OpenPort does the following:
	** 1) allocates space for visRgn (set to screenBits.bounds) and clipRgn (set wide open)
	** 2) sets portBits to screenBits
	** 3) sets portRect to screenBits.bounds, etc. (see IM I-163,164)
	** 4) side effect: does a SetPort(&offScreen) */

	OpenPort(newPort);
	SetPort(oldPort);

		/* Now make bitmap the size of the bounds that caller supplied. */

	newPort->portRect = bnds;
	newPort->portBits.bounds = bnds;
	RectRgn(newPort->visRgn, &bnds);

	SetRectRgn(newPort->clipRgn, -32000, -32000, 32000, 32000);
		/* Avoid wide-open clipRgn, to be safe.	*/

	/* rowBytes is size of row, it must be rounded up to an even number of bytes. */
	newPort->portBits.rowBytes = ((bnds.right - bnds.left + 15) >> 4) << 1;

	bitmap = NewHandle(newPort->portBits.rowBytes * (long)(bnds.bottom - bnds.top));
	if (err = MemError()) {
		ClosePort(newPort);			/* Dump the visRgn and clipRgn. */
		DisposPtr((Ptr)newPort);	/* Dump the GrafPort. */
		return(err);
	}

	(*theLayer)->layerBitmap = bitmap;
	*layerWorld              = (GWorldPtr)newPort;

	return(noErr);
}



/*****************************************************************************/



#pragma segment GWLayers
static void	KillLayerWorld(LayerObj theLayer)
{
	DisposeHandle((*theLayer)->layerBitmap);
	(*theLayer)->layerBitmap = nil;

	ClosePort((*theLayer)->layerPort);
	DisposePtr((Ptr)(*theLayer)->layerPort);
	(*theLayer)->layerPort = nil;
}




/*****************************************************************************/



#pragma segment GWLayers
static void	SmartGetGWorld(CGrafPtr *port, GDHandle *gdh)
{
	if (GetQDVersion())
		GetGWorld(port, gdh);
	else {
		*gdh = nil;
		GetPort((GrafPtr *)port);
	}
}



/*****************************************************************************/



#pragma segment GWLayers
static void	SmartSetGWorld(CGrafPtr port, GDHandle gdh)
{
	if (GetQDVersion())
		SetGWorld(port, gdh);
	else
		SetPort((GrafPtr)port);
}



/*****************************************************************************/



#pragma segment GWLayers
static short	GetQDVersion()
{
	long	gestaltResult;

	if (Gestalt(gestaltQuickdrawVersion, &gestaltResult))
		gestaltResult = 0;

	return((gestaltResult >> 8) & 0xFF);
}




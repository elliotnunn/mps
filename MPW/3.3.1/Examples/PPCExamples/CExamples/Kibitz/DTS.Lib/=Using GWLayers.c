***** GWLayers.c usage documentation *****/

Purpose:  To simplify and standardize offscreen drawing in a flexible way.

NOTE:  This package was originally written for use with GWorlds, but system 6
       support has been added.  You no longer need system 7 or color quickdraw
       to use this package.

Using offscreen GWorlds allows applications to achieve very clean graphics
effects that are not possible if drawing directly to a window (or grafPort).
In most cases, when an image is generated in an offscreen GWorld, that image
will end up being displayed in a window.

This relationship between offscreen GWorlds and windows needs to be managed.
In addition to one GWorld relating to a window, you may actually need multiple
GWorlds to relate to a window.  Many effects demand more than one offscreen
GWorld.  Smoothly dragging an image over a background is one such effect.

GWLayers.c is a block of code that manages the more mundane aspects of handling one
or more GWorlds.  GWLayers.c gives you a consistent way of relating GWorlds/windows
together.

A common use for offscreen GWorlds is to move an object around in a window smoothly
over a background.  To accomplish this, we need 3 layers.
These are:

1) The window layer.  This is the top-most layer in the layer hierarchy.  The
   top-most layer is typically what the user will see, and therefore commonly
   is a window layer.  Layers below the top-most are typically offscreen
   GWorlds.
2) A middle layer that is used to apply the object being moved to the
   background plus removing the object from the old location.  Once these
   two tasks are done, the offscreen work area is ready to be transferred
   to the window layer.
3) A background image against which the object moves.  This is used to
   restore the middle layer at the location where the object being moved
   was last at.

The background layer is generated only once.  The relevant (changing) portions of
the background image are copied into the middle layer.  Once the background portion
is copied into the middle layer, the object that is moving across the background is
drawn into the middle layer on top of the background portion.

Once the middle layer has the background portion with the moving object drawn onto it,
the portion is transferred to the top-most layer, which is the window layer.  The user
sees only this final transfer, so the intermediate steps are completely hidden.  The
user just sees the object being dragged drawn into its new location.

To make the dragged object seem to move, it is also important to erase it from its
old location.  If this were done in two steps (restore old location, draw in new location),
the movement would flicker.  The user would be able to perceive (very easily) that
the object is first removed from the old location and the redrawn in the new location.
To prevent this flickering, the old location and the new location have to be updated
in a single step.  Working offscreen allows this.  The middle layer is first updated so
that the old location of the object is restored to background.  The middle layer then has
the object drawn into the new location.  And then when the transfer finally occurs into
the window layer, an area large enough to cover both the old location and the new location
are transferred at once with a single CopyBits.


GWLayers.c conventions:

Updating of each layer is handled by the layer itself.  A particular layer checks to
see if there is a layer below, and if there is, does a CopyBits of the relevant area
from the below layer into itself.  If after the CopyBits there is any additional
drawing needed (such as the middle layer in the above example), then it is typically
done after the CopyBits.

Since the layers actually need to update from the bottom-most layer to the top-most
layer (top-most being the window, showing the final result), the layer updating code
checks to see if there is a layer below.  If there is, then the update procedure is
called for the layer below.  This recursion continues until the bottom-most layer is
reached.  The bottom-most layer then does its thing.  (For the case where the bottom-most
layer is background this "thing" will be to do nothing.)  Once the update for the layer
is completed, the update procedure simply returns.  It will return to the caller, which
is the layer above it (if any).  The next layer up does its thing, and then returns, and
so on.  This recursive chain of layers allows the updating to happen automatically in
the order designated by the layer hierarchy.

Since window records and GWorld records don't have any fields for all of the stuff we
need to keep (such as above-layer, below-layer, update procedures, etc.), this
implementation uses a handle to hold the layer record.  Each layer record has a reference
to the window or GWorld is is to draw into, plus a reference to what layers records
are above and below, if any.  The structure for a layer record is as follows:

typedef struct LayerRec {
	LayerObj		aboveLayer;			/* Nil if no above layer. */
	LayerObj		belowLayer;			/* Nil if no below layer. */
	Boolean     	layerOwnsPort;		/* True if layer created the GWorld. */
	GrafPtr			layerPort;			/* Window or GWorld this layer draws into. */
	GDHandle    	layerGDevice;		/* The GDevice for this layer. */
	Handle			layerBitmap;		/* If GWorlds aren't available, this holds the bitmap. */
	short			layerDepth;			/* Requested NewLayer depth of pixmap. */
	LayerProc		layerProc;			/* Layer procedure.  If nil, then default behaviors used. */
	unsigned long	layerData;			/* Application refCon-type field. */
	short			xferMode;			/* Transfer mode for CopyBits. */
	Rect			srcRect;			/* Initially nil, which makes entire GWorld source. */
	Rect			dstRect;			/* Initially nil, which makes entire window/GWorld dest. */
	Rect			thisUpdate;			/* Area to be updated for this update. */
	Rect			lastUpdate;			/* Area updated last time UpdateLayer() was called. */
	Boolean			includeLastUpdate;	/* True is last updated area is o updated as well. */
	Boolean			lockedCount;		/* Used internally by GWorld locking/unlocking calls. */
	Boolean			cachedCount;		/* Used internally by GWorld locking/unlocking calls. */
	CGrafPtr		cachedPort;			/* Used internally by GWorld usage calls. */
	GDHandle		cachedGDevice;		/* Used internally by GWorld usage calls. */
} LayerRec;

layerOwnsPort:
	If the layer created the GWorld, then it is the layer's responsibility to get rid
	of its GWorld when the layer is disposed of.  If this flag is true, the GWorld
	will be disposed of when the layer is disposed of.

layerProc:
	This is nil if the default behaviors are acceptable for a particular layer.
	If this is non-nil, then you are responsible for implementing each layer
	message behavior.  (More on this later.)

xferMode:
	This is the transfer mode for CopyBits.  The default behavior for updating simply
	transfers some or all of the below layer (if there is one) into the current layer.
	It does this with CopyBits, using the designated transfer mode.

srcRect:
	This is initially an empty rect.  If this srcRect is empty, then the portRect of the
	GWorld is used as the srcRect.  This means the default srcRect is the entire GWorld.
	If this field is set to a non-empty rect, the default update behavior is to do a CopyBits
	of just the srcRect area, and not the entire GWorld.  (Remember, the CopyBits is done by
	the above layer, so only if the above layer uses the default update behavior does this
	occur automatically.)
	Having a srcRect smaller than the entire GWorld allows for additional effects, such as
	fat-bits.  If the srcRect for this layer is smaller than the dstRect of the above layer,
	CopyBits will transfer a small rect into a big rect.  The image will be scaled to
	accommodate the larger destination rect, and presto -- fat-bits!!

dstRect:
	This field is initially an empty rect, just like srcRect.  If dstRect is set to a
	non-empty rect, then the default update behavior will CopyBits only into this area.
	This allows targeting of a specific portion of a window for offscreen updating, while
	the rest of the window can be used from scrollbars, or some such other thing.

thisRect:
	This field is also initially an empty rect.  This field becomes non-empty by
	calling InvalLayer().  InvalLayer() unions the rect passed to it into thisRect and
	stores the result in thisRect.  It then calls itself if there is a below layer, thus
	recursively changing thisRect for all layers below it in the layer hierarchy.

lastRect:
	This field is also initially an empty rect.  This field becomes non-empty after
	thisRect is non-empty and then UpdateLayer() is called.  Once the update is done,
	thisRect is copied into lastRect, and then thisRect is set empty once again.
	The lastRect field is use to optionally combine updating the last update with the
	current update.  This is particularly useful for dragging objects, as described above.
	In a single CopyBits, the old location and the new location need to be drawn in the
	window.  By setting includeLastUpdate true, this is done automatically by the default
	update behavior.

includeLastUpdate:
	As just described for the lastRect field, if this field is true, then the default
	update behavior CopyBits includes both the last update and this update, thus generating
	smooth animation effects.


A call to create a layer for a window (the top-most layer, most likely) might look like this:

	NewLayer(&windowLayer,    /* Layer object handle is returned here.    */
              nil,            /* Top layer, so there is no above layer.   */
              nil,            /* Uses default layer procedure.            */
              window,         /* Window used by the layer object.         */
              0,              /* Depth for offscreen 0 for screen depth). */
              0);             /* Custom layer init data, if any.          */

If NewLayer succeeds, the layer object handle is returned in windowLayer.  If it fails,
nil is returned in windowLayer, plus an error is returned.  This call can hardly fail, as
there is no offscreen GWorld created.  If only a minimally-sized handle can be created, it
will succeed.

To create a work layer below this window layer, we might make a call such as:

	err = NewLayer(&workLayer, windowLayer, WorkLayerProc, nil, 0, (long)&myInfo);
			/* myInfo is a struct that holds information that WorkLayerProc
			** needs to reference for drawing the object in the new location. */

This call has a greater chance of failure, as an offscreen GWorld was created for it.
We passed it a nil grafPort, so the default initialization behavior knows that it will
have to create a GWorld.  The default initialization behavior uses dstRect of the above
layer as the size of the offscreen GWorld it is to create.  If dstRect is an empty rect,
then it uses the portRect of the above layer instead.  So if you wanted to map the offscreen
layer to just a portion of the window, you would set the dstRect for the top-most layer
prior to creating the middle layer.

IMPORTANT:  The default behavior automatically creates the offscreen GWorld to the described
			size.  We have passed NewLayer() a layer procedure, so we don't automatically get
			the default behaviors for the middle layer.  This must be kept in mind when
			writing the layer procedure for the middle layer.  To get the default behavior,
			we simply call DefaultLayerInit() when the layer procedure gets an initialization
			message.  Since the default initialization behavior is exactly what we want, we
			just call it directly.

The reason that we have a layer procedure for this layer is that we want to do something
different when we receive an update message.  For the update message we want to first
transfer the portion of background into the middle layer, and then we want to draw the object
we are dragging into the middle layer.  For the update message, we can first call
DefaultLayerUpdate() to do the CopyBits from the below layer into the middle layer, and then
right after that we can draw the object being dragged into its new location.  The neat thing
about this is that the default behavior can still commonly be used, even if there is extra
stuff that we need to do.

Assuming no errors, we now have a top-most layer relating to the target window, plus a middle
layer for doing the offscreen drawing of the object being dragged.  We now need a background
layer that has an image of the background drawn into it.  This code might look like:

	if (!err) err = NewLayer(&backLayer, workLayer, BackLayerProc, nil, 0, (long)&myInfo);

This layer also has its own layer procedure.  The reasoning behind this is that the
initialization would do the drawing into the background.  Once the layers are all set up,
we want the background layer to be fully imaged.  This way there is no time spent for the
background layer, which is the way a background should be.

To recap, the code to create the 3 layers is as follows:

					NewLayer(&windowLayer, nil, nil, window, 0, 0);
			  err = NewLayer(&workLayer, windowLayer, WorkLayerProc, nil, 0, (long)&myInfo);
	if (!err) err = NewLayer(&backLayer, workLayer, BackLayerProc, nil, 0, (long)&myInfo);

For dragging, we would then have some sort of loop, such as:

	/* Assume the location where the user clicked is already in mouseLoc, local coordinates. */

	if (err) return;		/* No ram for the offscreen stuff. */

	lastLoc.h = lastLoc.v = -32767;		/* Unclickable initial point. */
	while (StillDown()) {
		if ((lastLoc.h != mouseLoc.h) || (lastLoc.v != mouseLoc.v)) {	/* Always true first time. */
			rct.top  = rct.bottom = mouseLoc.v;
			rct.left = rct.right  = mouseLoc.h;
			rct.bottom += myInfo.objectHeight;
			rct.right  += myInfo.objectWidth;
			InvalLayer(windowLayer, rct, true);		/* Update last location, as well as this one. */
			UpdateLayer(windowLayer);
			lastLoc = mouseLoc;
		}
	}

	DisposeThisAndBelowLayers(windowLayer);

As can be seen above, smoothly dragging an object can be very little code.  There are a few
things not handled by the above code, such as if there isn't enough memory for the offscreen
GWorlds.  It isn't really polite to do nothing, as the above code does.  For exception handling,
please see the actual sample code that uses the GWLayers.c package.


For explanations of the remaining functions of GWLayers.c, see the header file GWLayers.h, which
is in the DTS.Lib.headers folder.


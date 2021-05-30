#ifndef __GWLAYERS__
#define __GWLAYERS__

#ifndef __TYPES__
#include "Types.h"
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifndef __QDOFFSCREEN__
#include <QDOffscreen.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

struct LayerRec;
typedef struct LayerRec *LayerRecPtr, **LayerObj;

typedef OSErr (*LayerProc)(LayerObj theLayer, short message);

typedef struct LayerRec {
	LayerObj		aboveLayer;
	LayerObj		belowLayer;
	Boolean     	layerOwnsPort;
	GrafPtr			layerPort;
	GDHandle    	layerGDevice;
	Handle			layerBitmap;
	short			layerDepth;
	LayerProc		layerProc;
	unsigned long	layerData;
	short			xferMode;
	Rect			srcRect;
	Rect			dstRect;
	Rect			thisUpdate;
	Rect			lastUpdate;
	Boolean			includeLastUpdate;
	Boolean			lockedCount;
	Boolean			cachedCount;
	CGrafPtr		cachedPort;
	GDHandle		cachedGDevice;
} LayerRec;

#define kLayerInit    0
#define kLayerDispose 1
#define kLayerUpdate  2

OSErr	NewLayer(LayerObj *newLayer, LayerObj aboveLayer, LayerProc theProc,
				 GrafPtr basePort, short depth, unsigned long theData);
/* Use this call to create a layer object.
** newLayer:     Layer object handle returned here.
** aboveLayer:   Layer object above this layer (if any) in the layer hierarchy.
**				 If none, pass in nil.
** theProc:      Layer definition procedure.  Use nil for default behaviors.
** basePort:     If the port or GWorld for the layer already exists, such as a window,
**               pass it here.  If you want a GWorld created for you, pass in nil.
** depth:		 Pass in a non-0 value if you want a specific depth.  If you pass in 0,
**				 the the depth of the above layer will be used.
** theData:      Optional data reference.
*/

void	DetachLayer(LayerObj theLayer);
/* Use this call to remove a layer from a layer hierarchy.  This call does
** not dispose of the layer. */

OSErr	DisposeLayer(LayerObj theLayer);
/* Dispose of the layer.  If the layer belongs to a hierarchy, it is first
** removed from that hierarchy. */

OSErr	DisposeThisAndBelowLayers(LayerObj theLayer);
/* Dispose of the layer and all layers below it in the hierarchy. */

short	GetLayerPosition(LayerObj theLayer);
/* Return the layer position in the hierarchy.  0 is the top layer. */

LayerObj	GetTopLayer(LayerObj theLayer);
/* Return the top layer in the hierarchy. */

LayerObj	GetBottomLayer(LayerObj theLayer);
/* Return the bottom layer in the hierarchy. */

void	InsertLayer(LayerObj theLayer, LayerObj referenceLayer, short pos);
/* Insert a layer into a hierarchy.  Passing a 0 for position makes the layer
** the top layer. */

OSErr	UpdateLayer(LayerObj theLayer);
/* Given that a layer update has been posted, do the update.  LayerUpdate does
** a recursive update from theLayer down.  If there is a layer below, it calls
** LayerUpdate for that layer.  Once the bottom of the hierarchy is reached,
** the layerProc is called to do the update.  This causes the layer updates to
** occur from bottom up. */

Rect	GetEffectiveSrcRect(LayerObj theLayer);
/* The effectiveSrcRect is srcRect or portRect of the layer.  If there is no srcRect,
** (srcRect is empty), then effectiveSrcRect is the layer's portRect. */

Rect	GetEffectiveDstRect(LayerObj theLayer);
/* The effectiveDstRect is dstRect or portRect of the layer.  If there is no dstRect,
** (dstRect is empty), then effectiveDstRect is the layer's portRect. */

OSErr	DefaultLayerProc(LayerObj theLayer, short message);
/* The three currently defined message definitions are:
**
** kLayerInit:     Called by NewLayer.  If layerPort is nil (which was
**                 initialized by NewLayer), then the size/depth of the GWorld
**                 that is created is dependent on aboveLayer.  If there is no
**                 aboveLayer, this is an error, and paramErr is returned.
**                 If the GWorld is successfully created, then layerOwnsPort is
**                 set true.
** kLayerDispose:  Called when a layer is disposed of by either DisposeLayer or
**                 DisposeThisAndBelowLayers.  It disposes of the GWorld if the
**                 GWorld is owned by the layer.
** kLayerUpdate:   If there is a below layer, kLayerUpdate does a CopyBits from the
**                 below layer into the current layer.  The copy is done from the
**                 below layer's effectiveSrcRect into the current layer's
**                 effectiveDstRect.  The transfer mode used is in xferMode, which
**                 by default is srcCopy. */

Rect	UpdateUpdateRects(LayerObj theLayer);
/* Return the rect that is to be updated, plus manage lastUpdate/thisUpdate
** so that they apply to the next update. */

void	InvalLayer(LayerObj theLayer, Rect invalRect, Boolean includeLastUpdate);
/* Post a layer update rect.  The rect is unioned into the thisUpdate for the
** layer and all layers below this layer.  If includeLastUpdate is true, then
** the field includeLastUpdate is set true for each layer, as well.  This boolean
** is used by the default update behavior to determine if the area last updated
** should be updated again.  This makes animation effects easier in the the old
** and new position for a player being moved are updated at the same time.  This
** could be handled by hand by calculating the rect to be updated to include the
** last position, but by passing includeLastUpdate as true, it is
** handled automatically. */

void	SetLayerWorld(LayerObj theLayer);
/* This is a convenient call for setting a GWorld, while remembering what
** the previous GWorld was.  This should be balanced with a call to
** ResetLayerWorld.  A count of how many times this is called is kept
** so that the old GWorld is cached only if SetLayerWorld is currently
** in balance with ResetLayerWorld.  This keeps the oldest kept GWorld
** from being overwritten by subsequent calls. */

void	ResetLayerWorld(LayerObj theLayer);
/* This is used to undo a call to SetLayerWorld.  Calls to ResetLayerWorld
** should be balanced with previous calls to SetLayerWorld. */

void	LockLayerWorld(LayerObj theLayer);
/* This is a convenient way to lock down the pixels for a layer's GWorld.
** A locked count is kept to make sure that the GWorld is locked only the
** first time this is called.  Calls to LockLayerWorld will most likely
** be balanced by calls to UnlockLayerWorld, but not necessarily.  It may
** be desirable to keep a GWorld layer locked.  In this case, right after
** creating the layer (and indirectly its GWorld), call LockLayerWorld.
** This will initially lock it.  Subsequent calls would be balanced, and
** therefore there will always be one more LockLayerWorld call than
** UnlockLayerWorld calls.  This will keep it locked. */

void	UnlockLayerWorld(LayerObj theLayer);
/* This undoes what LockLayerWorld does.  Calls to UnlockLayerWorld will
** generally be balanced with calls to LockLayerWorld. */

RgnHandle	ScreenDepthRegion(short depth);
/* This returns a region describing the area of the various screens that is at least as deep
** as the value passed in.  So, if you want to find out what area of the screens has at least
** an 8-pixel depth, pass in an 8, and the region returned will describe that area.  If you
** want the screen area that is exactly 8 pixels deep, call this function with an 8, and then
** call it again with a 9.  Diff out the region returned when 9 was passed in.  The remaining
** area is the area that is exactly 8 pixels deep.  (Dispose of both regions when you are done
** with them.) */

CIconHandle	ReadCIcon(short iconID);
/* This function is for system 6/7 compatibility.  System 6 doesn't normally have color icon
** support, and if you call the 'cicn' functions in system 6, you will get an unimplemented
** trap error.  ReadCIcon calls the color QuickDraw trap GetCIcon if it is available, or it
** simply calls GetResource/ReleaseResource if the trap isn't available. */

void		KillCIcon(CIconHandle icon);
/* This call disposes of a 'cicn' handle gotten by calling ReadCicon. */

void		DrawCIcon(CIconHandle icon, Rect destRect);
/* This function calls PlotCIcon if it is available, or it dereferences the 1-bit deep bitmap
** of the 'cicn' and does a CopyBits if it isn't. */

void		DrawCIconNoMask(CIconHandle icon, Rect destRect);
/* This function calls PlotCIcon with a temporary mask of nothing masked if it is available,
** or it dereferences the 1-bit deep bitmap of the 'cicn' and does a CopyMask if it isn't. */

void		DrawCIconByDepth(CIconHandle icon, Rect destRect, short depth, Boolean useMask);
/* This call does either a CopyBits or CopyMask of the correct part of the 'cicn' resource.
** The correct part is determined by the depth.  If a specific depth of 1 is requested, then
** the bitmap portion of the 'cicn' is plotted.  If a specific depth of greater than 1 is
** requested, and the depth of the target is greater than 1, then the pixmap portion of the 
** 'cicn' is plotted. */

#endif

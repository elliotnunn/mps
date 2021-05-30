/******************************************************************************
 **																			 **
 ** 	Module:		QD3DView.h												 **
 **																			 **
 **																			 **
 ** 	Purpose: 	View types and routines									 **
 **																			 **
 **																			 **
 **																			 **
 ** 	Copyright (C) 1992-1995 Apple Computer, Inc.  All rights reserved.	 **
 **																			 **
 **																			 **
 *****************************************************************************/
#ifndef QD3DView_h
#define QD3DView_h

#ifndef QD3D_h
#include <QD3D.h>
#endif  /*  QD3D_h  */

#if PRAGMA_ONCE
	#pragma once
#endif

#if defined(__MWERKS__)
	#pragma enumsalwaysint on
	#pragma align_array_members off
	#pragma options align=native
#endif

#include <QD3DStyle.h>
#include <QD3DSet.h>

#ifdef __cplusplus
extern "C" {
#endif	/* __cplusplus */


/******************************************************************************
 **																			 **
 **						View Type Definitions								 **
 **																			 **
 *****************************************************************************/

typedef enum TQ3ViewStatus {
	kQ3ViewStatusDone,
	kQ3ViewStatusRetraverse,
	kQ3ViewStatusError,
	kQ3ViewStatusCancelled
} TQ3ViewStatus;


/******************************************************************************
 **																			 **
 **						Default Attribute Set								 **
 **																			 **
 *****************************************************************************/

#define kQ3ViewDefaultAmbientCoefficient	1.0
#define kQ3ViewDefaultDiffuseColor			0.5, 0.5, 0.5
#define kQ3ViewDefaultSpecularColor			0.5, 0.5, 0.5
#define kQ3ViewDefaultSpecularControl		4.0
#define kQ3ViewDefaultTransparency			1.0, 1.0, 1.0
#define kQ3ViewDefaultHighlightColor		1.0, 0.0, 0.0

#define kQ3ViewDefaultSubdivisionMethod		kQ3SubdivisionMethodConstant
#define kQ3ViewDefaultSubdivisionC1			10.0
#define kQ3ViewDefaultSubdivisionC2			10.0


/******************************************************************************
 **																			 **
 **							View Routines									 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3ViewObject Q3View_New(
	void);

QD3D_EXPORT TQ3Status Q3View_Cancel(
	TQ3ViewObject		view);

/******************************************************************************
 **																			 **
 **						View Rendering routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status Q3View_SetRendererByType(
	TQ3ViewObject 		view,
	TQ3ObjectType 		type);
	
QD3D_EXPORT TQ3Status Q3View_SetRenderer(
	TQ3ViewObject 		view,
	TQ3RendererObject	renderer);

QD3D_EXPORT TQ3Status Q3View_GetRenderer(
	TQ3ViewObject		view,
	TQ3RendererObject	*renderer);
	
QD3D_EXPORT TQ3Status Q3View_StartRendering(
	TQ3ViewObject 		view);
	
QD3D_EXPORT TQ3ViewStatus Q3View_EndRendering(
	TQ3ViewObject 		view);
	
QD3D_EXPORT TQ3Status Q3View_Flush(
	TQ3ViewObject		view);
	
QD3D_EXPORT TQ3Status Q3View_Sync(
	TQ3ViewObject		view);


/******************************************************************************
 **																			 **
 **						View/Bounds/Pick routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status Q3View_StartBoundingBox(
	TQ3ViewObject		view,
	TQ3ComputeBounds	computeBounds);

QD3D_EXPORT TQ3ViewStatus Q3View_EndBoundingBox(
	TQ3ViewObject		view,
	TQ3BoundingBox		*result);

QD3D_EXPORT TQ3Status Q3View_StartBoundingSphere(
	TQ3ViewObject		view,
	TQ3ComputeBounds	computeBounds);

QD3D_EXPORT TQ3ViewStatus Q3View_EndBoundingSphere(
	TQ3ViewObject		view,
	TQ3BoundingSphere	*result);

QD3D_EXPORT TQ3Status Q3View_StartPicking(
	TQ3ViewObject		view,
	TQ3PickObject		pick);

QD3D_EXPORT TQ3ViewStatus Q3View_EndPicking(
	TQ3ViewObject		view);


/******************************************************************************
 **																			 **
 **							View/Camera routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status Q3View_GetCamera(
	TQ3ViewObject		view,
	TQ3CameraObject		*camera);

QD3D_EXPORT TQ3Status Q3View_SetCamera(
	TQ3ViewObject		view,
	TQ3CameraObject		camera);


/******************************************************************************
 **																			 **
 **							View/Lights routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status Q3View_SetLightGroup(
	TQ3ViewObject		view,
	TQ3GroupObject		lightGroup);

QD3D_EXPORT TQ3Status Q3View_GetLightGroup(
	TQ3ViewObject		view,
	TQ3GroupObject		*lightGroup);


/******************************************************************************
 **																			 **
 **		Idle Method															 **
 **																			 **
 **		These allow the application to register callback routines which will **
 **		be called by the view during especially long operations.			 **
 **																			 **
 **		These are used to interrupt long renderings or traversals.  Inside	 **
 **		the idler callback the application can check for command-period or	 **
 **		whatever else they may be using to let the user interrupt rendering. **
 **																			 **
 **		It is NOT LEGAL to call QD3D routines inside an idler callback.		 **
 **		Return kQ3Failure to cancel rendering.								 **
 **																			 **
 **		Q3View_SetIdleMethod registers a callback that can be called		 **
 **		by the system during rendering.  Unfortunately there is no way yet	 **
 **		to set timer intervals when you want to be called.  Basically, it is **
 **		up to the application's idler callback to check clocks to see if you **
 **		were called back only a millisecond ago or an hour ago!				 **
 **																			 **
 *****************************************************************************/

typedef TQ3Status (*TQ3ViewIdleMethod)(
	TQ3ViewObject		view,
	const void			*idlerData);

QD3D_EXPORT TQ3Status Q3View_SetIdleMethod(
	TQ3ViewObject		view,
	TQ3ViewIdleMethod	idleMethod,
	const void 			*idleData);


/******************************************************************************
 **																			 **
 **							Push/Pop routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status Q3Push_Submit(
	TQ3ViewObject 	view);

QD3D_EXPORT TQ3Status Q3Pop_Submit(
	TQ3ViewObject 	view);


/******************************************************************************
 **																			 **
 **		Check if bounding box is visible in the viewing frustum.  Transforms **
 **		the bbox by the current local_to_world transformation matrix and	 **
 **		does a clip test to see if it lies in the viewing frustum.			 **
 **		This can be used by applications to cull out large chunks of scenes	 **
 **		that are not going to be visible.									 **
 **																			 **
 **		The default implementation is to always return kQ3True.  Renderers	 **
 **		may override this routine however to do the checking.				 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Boolean Q3View_IsBoundingBoxVisible(
	TQ3ViewObject			view,
	const TQ3BoundingBox	*bbox);


/******************************************************************************
 **																			 **
 **							DrawContext routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status Q3View_SetDrawContext(
	TQ3ViewObject 			view,
	TQ3DrawContextObject	drawContext);

QD3D_EXPORT TQ3Status Q3View_GetDrawContext(
	TQ3ViewObject 			view,
	TQ3DrawContextObject	*drawContext);


/******************************************************************************
 **																			 **
 **							Graphics State routines							 **
 **																			 **
 ** The graphics state routines can only be called while rendering (ie. in	 **
 ** between calls to start and end rendering calls).  If they are called	 **
 ** outside of a rendering loop, they will return with error.				 **
 **																			 **
 *****************************************************************************/
  
/******************************************************************************
 **																			 **
 **							Transform routines								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status Q3View_GetLocalToWorldMatrixState(
	TQ3ViewObject		view,
	TQ3Matrix4x4		*matrix);
		
QD3D_EXPORT TQ3Status Q3View_GetWorldToFrustumMatrixState(
	TQ3ViewObject		view,
	TQ3Matrix4x4		*matrix);
		
QD3D_EXPORT TQ3Status Q3View_GetFrustumToWindowMatrixState(
	TQ3ViewObject		view,
	TQ3Matrix4x4		*matrix);
	

/******************************************************************************
 **																			 **
 **							Style state routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status Q3View_GetBackfacingStyleState(
	TQ3ViewObject			view,
	TQ3BackfacingStyle		*backfacingStyle);

QD3D_EXPORT TQ3Status Q3View_GetInterpolationStyleState(
	TQ3ViewObject			view,
	TQ3InterpolationStyle	*interpolationType);

QD3D_EXPORT TQ3Status Q3View_GetFillStyleState(
	TQ3ViewObject			view,
	TQ3FillStyle			*fillStyle);

QD3D_EXPORT TQ3Status Q3View_GetHighlightStyleState(
	TQ3ViewObject			view,
	TQ3AttributeSet			*highlightStyle);

QD3D_EXPORT TQ3Status Q3View_GetSubdivisionStyleState(
	TQ3ViewObject			view,
	TQ3SubdivisionStyleData	*subdivisionStyle);

QD3D_EXPORT TQ3Status Q3View_GetOrientationStyleState(
	TQ3ViewObject			view,
	TQ3OrientationStyle		*fontFacingDirectionStyle);

QD3D_EXPORT TQ3Status Q3View_GetReceiveShadowsStyleState(
	TQ3ViewObject			view,
	TQ3Boolean				*receives);

QD3D_EXPORT TQ3Status Q3View_GetPickIDStyleState(
	TQ3ViewObject			view,
	unsigned long			*pickIDStyle);
	
QD3D_EXPORT TQ3Status Q3View_GetPickPartsStyleState(
	TQ3ViewObject			view,
	TQ3PickParts			*pickPartsStyle);


/******************************************************************************
 **																			 **
 **						Attribute state routines							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Status Q3View_GetDefaultAttributeSet(
	TQ3ViewObject		view,
	TQ3AttributeSet		*attributeSet);

QD3D_EXPORT TQ3Status Q3View_SetDefaultAttributeSet(
	TQ3ViewObject		view,
	TQ3AttributeSet		attributeSet);


QD3D_EXPORT TQ3Status Q3View_GetAttributeSetState(
	TQ3ViewObject 		view,
	TQ3AttributeSet		*attributeSet);

QD3D_EXPORT TQ3Status Q3View_GetAttributeState(
	TQ3ViewObject 		view,
	TQ3AttributeType	attributeType,
	void				*data);
	
#ifdef __cplusplus
}
#endif	/* __cplusplus */

#if defined(__MWERKS__)
#pragma options align=reset
#pragma enumsalwaysint reset
#endif

#endif  /*  QD3DView_h  */

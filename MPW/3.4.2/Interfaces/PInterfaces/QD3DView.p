{
 	File:		QD3DView.p
 
 	Contains:	View types and routines											
 
 	Version:	Technology:	Quickdraw 3D 1.0.6
 				Release:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QD3DView;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DVIEW__}
{$SETC __QD3DVIEW__ := 1}

{$I+}
{$SETC QD3DViewIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}
{$IFC UNDEFINED __QD3DSTYLE__}
{$I QD3DStyle.p}
{$ENDC}
{$IFC UNDEFINED __QD3DSET__}
{$I QD3DSet.p}
{$ENDC}

{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{
*****************************************************************************
 **																			 **
 **						View Type Definitions								 **
 **																			 **
 ****************************************************************************
}

TYPE
	TQ3ViewStatus 				= LONGINT;
CONST
	kQ3ViewStatusDone			= {TQ3ViewStatus}0;
	kQ3ViewStatusRetraverse		= {TQ3ViewStatus}1;
	kQ3ViewStatusError			= {TQ3ViewStatus}2;
	kQ3ViewStatusCancelled		= {TQ3ViewStatus}3;

{
*****************************************************************************
 **																			 **
 **						Default Attribute Set								 **
 **																			 **
 ****************************************************************************
}
{
*****************************************************************************
 **																			 **
 **							View Routines									 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3View_New: TQ3ViewObject; C;
FUNCTION Q3View_Cancel(view: TQ3ViewObject): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						View Rendering routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3View_SetRendererByType(view: TQ3ViewObject; theType: TQ3ObjectType): TQ3Status; C;
FUNCTION Q3View_SetRenderer(view: TQ3ViewObject; renderer: TQ3RendererObject): TQ3Status; C;
FUNCTION Q3View_GetRenderer(view: TQ3ViewObject; VAR renderer: TQ3RendererObject): TQ3Status; C;
FUNCTION Q3View_StartRendering(view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3View_EndRendering(view: TQ3ViewObject): TQ3ViewStatus; C;
FUNCTION Q3View_Flush(view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3View_Sync(view: TQ3ViewObject): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						View/Bounds/Pick routines							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3View_StartBoundingBox(view: TQ3ViewObject; computeBounds: TQ3ComputeBounds): TQ3Status; C;
FUNCTION Q3View_EndBoundingBox(view: TQ3ViewObject; VAR result: TQ3BoundingBox): TQ3ViewStatus; C;
FUNCTION Q3View_StartBoundingSphere(view: TQ3ViewObject; computeBounds: TQ3ComputeBounds): TQ3Status; C;
FUNCTION Q3View_EndBoundingSphere(view: TQ3ViewObject; VAR result: TQ3BoundingSphere): TQ3ViewStatus; C;
FUNCTION Q3View_StartPicking(view: TQ3ViewObject; pick: TQ3PickObject): TQ3Status; C;
FUNCTION Q3View_EndPicking(view: TQ3ViewObject): TQ3ViewStatus; C;
{
*****************************************************************************
 **																			 **
 **							View/Camera routines							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3View_GetCamera(view: TQ3ViewObject; VAR camera: TQ3CameraObject): TQ3Status; C;
FUNCTION Q3View_SetCamera(view: TQ3ViewObject; camera: TQ3CameraObject): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							View/Lights routines							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3View_SetLightGroup(view: TQ3ViewObject; lightGroup: TQ3GroupObject): TQ3Status; C;
FUNCTION Q3View_GetLightGroup(view: TQ3ViewObject; VAR lightGroup: TQ3GroupObject): TQ3Status; C;
{
*****************************************************************************
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
 ****************************************************************************
}

TYPE
	TQ3ViewIdleMethod = ProcPtr;  { FUNCTION TQ3ViewIdleMethod(view: TQ3ViewObject; idlerData: UNIV Ptr): TQ3Status; C; }

FUNCTION Q3View_SetIdleMethod(view: TQ3ViewObject; idleMethod: TQ3ViewIdleMethod; idleData: UNIV Ptr): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							Push/Pop routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3Push_Submit(view: TQ3ViewObject): TQ3Status; C;
FUNCTION Q3Pop_Submit(view: TQ3ViewObject): TQ3Status; C;
{
*****************************************************************************
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
 ****************************************************************************
}
FUNCTION Q3View_IsBoundingBoxVisible(view: TQ3ViewObject; {CONST}VAR bbox: TQ3BoundingBox): TQ3Boolean; C;
{
*****************************************************************************
 **																			 **
 **							DrawContext routines							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3View_SetDrawContext(view: TQ3ViewObject; drawContext: TQ3DrawContextObject): TQ3Status; C;
FUNCTION Q3View_GetDrawContext(view: TQ3ViewObject; VAR drawContext: TQ3DrawContextObject): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							Graphics State routines							 **
 **																			 **
 ** The graphics state routines can only be called while rendering (ie. in	 **
 ** between calls to start and end rendering calls).  If they are called	 **
 ** outside of a rendering loop, they will return with error.				 **
 **																			 **
 ****************************************************************************
}
{
*****************************************************************************
 **																			 **
 **							Transform routines								 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3View_GetLocalToWorldMatrixState(view: TQ3ViewObject; VAR matrix: TQ3Matrix4x4): TQ3Status; C;
FUNCTION Q3View_GetWorldToFrustumMatrixState(view: TQ3ViewObject; VAR matrix: TQ3Matrix4x4): TQ3Status; C;
FUNCTION Q3View_GetFrustumToWindowMatrixState(view: TQ3ViewObject; VAR matrix: TQ3Matrix4x4): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **							Style state routines							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3View_GetBackfacingStyleState(view: TQ3ViewObject; VAR backfacingStyle: TQ3BackfacingStyle): TQ3Status; C;
FUNCTION Q3View_GetInterpolationStyleState(view: TQ3ViewObject; VAR interpolationType: TQ3InterpolationStyle): TQ3Status; C;
FUNCTION Q3View_GetFillStyleState(view: TQ3ViewObject; VAR fillStyle: TQ3FillStyle): TQ3Status; C;
FUNCTION Q3View_GetHighlightStyleState(view: TQ3ViewObject; VAR highlightStyle: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3View_GetSubdivisionStyleState(view: TQ3ViewObject; VAR subdivisionStyle: TQ3SubdivisionStyleData): TQ3Status; C;
FUNCTION Q3View_GetOrientationStyleState(view: TQ3ViewObject; VAR fontFacingDirectionStyle: TQ3OrientationStyle): TQ3Status; C;
FUNCTION Q3View_GetReceiveShadowsStyleState(view: TQ3ViewObject; VAR receives: TQ3Boolean): TQ3Status; C;
FUNCTION Q3View_GetPickIDStyleState(view: TQ3ViewObject; VAR pickIDStyle: LONGINT): TQ3Status; C;
FUNCTION Q3View_GetPickPartsStyleState(view: TQ3ViewObject; VAR pickPartsStyle: TQ3PickParts): TQ3Status; C;
{
*****************************************************************************
 **																			 **
 **						Attribute state routines							 **
 **																			 **
 ****************************************************************************
}
FUNCTION Q3View_GetDefaultAttributeSet(view: TQ3ViewObject; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3View_SetDefaultAttributeSet(view: TQ3ViewObject; attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3View_GetAttributeSetState(view: TQ3ViewObject; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;
FUNCTION Q3View_GetAttributeState(view: TQ3ViewObject; attributeType: TQ3AttributeType; data: UNIV Ptr): TQ3Status; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DViewIncludes}

{$ENDC} {__QD3DVIEW__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

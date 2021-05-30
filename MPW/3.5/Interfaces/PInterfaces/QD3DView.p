{
     File:       QD3DView.p
 
     Contains:   View types and routines
 
     Version:    Technology: Quickdraw 3D 1.6
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1995-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{*****************************************************************************
 **                                                                          **
 **                     View Type Definitions                                **
 **                                                                          **
 ****************************************************************************}

TYPE
	TQ3ViewStatus 				= SInt32;
CONST
	kQ3ViewStatusDone			= 0;
	kQ3ViewStatusRetraverse		= 1;
	kQ3ViewStatusError			= 2;
	kQ3ViewStatusCancelled		= 3;


	{	*****************************************************************************
	 **                                                                          **
	 **                     Default Attribute Set                                **
	 **                                                                          **
	 ****************************************************************************	}

	{	*****************************************************************************
	 **                                                                          **
	 **                         View Routines                                    **
	 **                                                                          **
	 ****************************************************************************	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3View_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3View_New: TQ3ViewObject; C;

{
 *  Q3View_Cancel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_Cancel(view: TQ3ViewObject): TQ3Status; C;

{*****************************************************************************
 **                                                                          **
 **                     View Rendering routines                              **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3View_SetRendererByType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_SetRendererByType(view: TQ3ViewObject; theType: TQ3ObjectType): TQ3Status; C;

{
 *  Q3View_SetRenderer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_SetRenderer(view: TQ3ViewObject; renderer: TQ3RendererObject): TQ3Status; C;

{
 *  Q3View_GetRenderer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetRenderer(view: TQ3ViewObject; VAR renderer: TQ3RendererObject): TQ3Status; C;

{
 *  Q3View_StartRendering()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_StartRendering(view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3View_EndRendering()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_EndRendering(view: TQ3ViewObject): TQ3ViewStatus; C;

{
 *  Q3View_Flush()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_Flush(view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3View_Sync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_Sync(view: TQ3ViewObject): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                     View/Bounds/Pick routines                            **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3View_StartBoundingBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_StartBoundingBox(view: TQ3ViewObject; computeBounds: TQ3ComputeBounds): TQ3Status; C;

{
 *  Q3View_EndBoundingBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_EndBoundingBox(view: TQ3ViewObject; VAR result: TQ3BoundingBox): TQ3ViewStatus; C;

{
 *  Q3View_StartBoundingSphere()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_StartBoundingSphere(view: TQ3ViewObject; computeBounds: TQ3ComputeBounds): TQ3Status; C;

{
 *  Q3View_EndBoundingSphere()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_EndBoundingSphere(view: TQ3ViewObject; VAR result: TQ3BoundingSphere): TQ3ViewStatus; C;

{
 *  Q3View_StartPicking()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_StartPicking(view: TQ3ViewObject; pick: TQ3PickObject): TQ3Status; C;

{
 *  Q3View_EndPicking()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_EndPicking(view: TQ3ViewObject): TQ3ViewStatus; C;


{*****************************************************************************
 **                                                                          **
 **                         View/Camera routines                             **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3View_GetCamera()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetCamera(view: TQ3ViewObject; VAR camera: TQ3CameraObject): TQ3Status; C;

{
 *  Q3View_SetCamera()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_SetCamera(view: TQ3ViewObject; camera: TQ3CameraObject): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         View/Lights routines                             **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3View_SetLightGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_SetLightGroup(view: TQ3ViewObject; lightGroup: TQ3GroupObject): TQ3Status; C;

{
 *  Q3View_GetLightGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetLightGroup(view: TQ3ViewObject; VAR lightGroup: TQ3GroupObject): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                             Idle Method                                  **
 **                                                                          **
 ****************************************************************************}
{
 *  The idle methods allow the application to register callback routines 
 *  which will be called by the view during especially long operations.
 *
 *  The idle methods may also be used to interrupt long renderings or
 *  traversals.  Inside the idler callback the application can check for
 *  Command-Period, Control-C or clicking a "Cancel" button or whatever else
 *  may be used to let the user interrupt rendering.    
 *
 *  It is NOT LEGAL to call QD3D routines inside an idler callback.
 *
 *  Return kQ3Failure to cancel rendering, kQ3Success to continue. Don't
 *  bother posting an error.
 *
 *  Q3View_SetIdleMethod registers a callback that can be called
 *  by the system during rendering.  Unfortunately there is no way yet
 *  to set timer intervals when you want to be called.  Basically, it is
 *  up to the application's idler callback to check clocks to see if you
 *  were called back only a millisecond ago or an hour ago!
 *
 *  Q3View_SetIdleProgressMethod registers a callback that also gives
 *  progress information. This information is supplied by the renderer, and
 *  may or may not be based on real time.
 *
 *  If a renderer doesn't support the progress method, your method will be
 *  called with current == 0 and completed == 0.
 *  
 *  Otherwise, you are GUARANTEED to get called at least 2 or more times:
 *  
 *  ONCE            idleMethod(view, 0, n)      -> Initialize, Show Dialog
 *  zero or more    idleMethod(view, 1..n-1, n) -> Update progress
 *  ONCE            idleMethod(view, n, n)      -> Exit, Hide Dialog
 *  
 *  "current" is guaranteed to be less than or equal to "completed"
 *  "completed" may change values, but current/complete always indicates
 *  the degree of completion.
 *
 *  The calling conventions aid in managing any data associated with a 
 *  progress user interface indicator.
 }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3ViewIdleMethod = FUNCTION(view: TQ3ViewObject; idlerData: UNIV Ptr): TQ3Status; C;
{$ELSEC}
	TQ3ViewIdleMethod = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TQ3ViewIdleProgressMethod = FUNCTION(view: TQ3ViewObject; idlerData: UNIV Ptr; current: UInt32; completed: UInt32): TQ3Status; C;
{$ELSEC}
	TQ3ViewIdleProgressMethod = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3View_SetIdleMethod()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3View_SetIdleMethod(view: TQ3ViewObject; idleMethod: TQ3ViewIdleMethod; idleData: UNIV Ptr): TQ3Status; C;

{
 *  Q3View_SetIdleProgressMethod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_SetIdleProgressMethod(view: TQ3ViewObject; idleMethod: TQ3ViewIdleProgressMethod; idleData: UNIV Ptr): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                             EndFrame Method                              **
 **                                                                          **
 ****************************************************************************}
{
 *  The end frame method is an alternate way of determining when an
 *  asynchronous renderer has completed rendering a frame. It differs from
 *  Q3View_Sync in that notification of the frame completion is the opposite
 *  direction. 
 *  
 *  With Q3View_Sync the application asks a renderer to finish rendering
 *  a frame, and blocks until the frame is complete.
 *  
 *  With the EndFrame method, the renderer tells the application that is has
 *  completed a frame.
 *
 *  If "Q3View_Sync" is called BEFORE this method has been called, this
 *  method will NOT be called ever.
 *  
 *  If "Q3View_Sync" is called AFTER this method has been called, the
 *  call will return immediately (as the frame has already been completed).
 }
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TQ3ViewEndFrameMethod = PROCEDURE(view: TQ3ViewObject; endFrameData: UNIV Ptr); C;
{$ELSEC}
	TQ3ViewEndFrameMethod = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3View_SetEndFrameMethod()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3View_SetEndFrameMethod(view: TQ3ViewObject; endFrame: TQ3ViewEndFrameMethod; endFrameData: UNIV Ptr): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         Push/Pop routines                                **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Push_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Push_Submit(view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3Pop_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Pop_Submit(view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3Push_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Push_New: TQ3StateOperatorObject; C;

{
 *  Q3Pop_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Pop_New: TQ3StateOperatorObject; C;

{
 *  Q3StateOperator_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3StateOperator_Submit(stateOperator: TQ3StateOperatorObject; view: TQ3ViewObject): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **     Check if bounding box is visible in the viewing frustum.  Transforms **
 **     the bbox by the current local_to_world transformation matrix and     **
 **     does a clip test to see if it lies in the viewing frustum.           **
 **     This can be used by applications to cull out large chunks of scenes  **
 **     that are not going to be visible.                                    **
 **                                                                          **
 **     The default implementation is to always return kQ3True.  Renderers   **
 **     may override this routine however to do the checking.                **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3View_IsBoundingBoxVisible()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_IsBoundingBoxVisible(view: TQ3ViewObject; {CONST}VAR bbox: TQ3BoundingBox): TQ3Boolean; C;


{*****************************************************************************
 **                                                                          **
 **     Allows display groups to be culled if they are assigned bounding     **
 **     boxes.                                                               **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3View_AllowAllGroupCulling()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_AllowAllGroupCulling(view: TQ3ViewObject; allowCulling: TQ3Boolean): TQ3Status; C;



{*****************************************************************************
 **                                                                          **
 **                         DrawContext routines                             **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3View_SetDrawContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_SetDrawContext(view: TQ3ViewObject; drawContext: TQ3DrawContextObject): TQ3Status; C;

{
 *  Q3View_GetDrawContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetDrawContext(view: TQ3ViewObject; VAR drawContext: TQ3DrawContextObject): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         Graphics State routines                          **
 **                                                                          **
 ** The graphics state routines can only be called while rendering (ie. in   **
 ** between calls to start and end rendering calls).  If they are called     **
 ** outside of a rendering loop, they will return with error.                **
 **                                                                          **
 ****************************************************************************}
{*****************************************************************************
 **                                                                          **
 **                         Transform routines                               **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3View_GetLocalToWorldMatrixState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetLocalToWorldMatrixState(view: TQ3ViewObject; VAR matrix: TQ3Matrix4x4): TQ3Status; C;

{
 *  Q3View_GetWorldToFrustumMatrixState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetWorldToFrustumMatrixState(view: TQ3ViewObject; VAR matrix: TQ3Matrix4x4): TQ3Status; C;

{
 *  Q3View_GetFrustumToWindowMatrixState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetFrustumToWindowMatrixState(view: TQ3ViewObject; VAR matrix: TQ3Matrix4x4): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         Style state routines                             **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3View_GetBackfacingStyleState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetBackfacingStyleState(view: TQ3ViewObject; VAR backfacingStyle: TQ3BackfacingStyle): TQ3Status; C;

{
 *  Q3View_GetInterpolationStyleState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetInterpolationStyleState(view: TQ3ViewObject; VAR interpolationType: TQ3InterpolationStyle): TQ3Status; C;

{
 *  Q3View_GetFillStyleState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetFillStyleState(view: TQ3ViewObject; VAR fillStyle: TQ3FillStyle): TQ3Status; C;

{
 *  Q3View_GetHighlightStyleState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetHighlightStyleState(view: TQ3ViewObject; VAR highlightStyle: TQ3AttributeSet): TQ3Status; C;

{
 *  Q3View_GetSubdivisionStyleState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetSubdivisionStyleState(view: TQ3ViewObject; VAR subdivisionStyle: TQ3SubdivisionStyleData): TQ3Status; C;

{
 *  Q3View_GetOrientationStyleState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetOrientationStyleState(view: TQ3ViewObject; VAR fontFacingDirectionStyle: TQ3OrientationStyle): TQ3Status; C;

{
 *  Q3View_GetReceiveShadowsStyleState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetReceiveShadowsStyleState(view: TQ3ViewObject; VAR receives: TQ3Boolean): TQ3Status; C;

{
 *  Q3View_GetPickIDStyleState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetPickIDStyleState(view: TQ3ViewObject; VAR pickIDStyle: UInt32): TQ3Status; C;

{
 *  Q3View_GetPickPartsStyleState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetPickPartsStyleState(view: TQ3ViewObject; VAR pickPartsStyle: TQ3PickParts): TQ3Status; C;

{
 *  Q3View_GetAntiAliasStyleState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetAntiAliasStyleState(view: TQ3ViewObject; VAR antiAliasData: TQ3AntiAliasStyleData): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                     Attribute state routines                             **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3View_GetDefaultAttributeSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetDefaultAttributeSet(view: TQ3ViewObject; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;

{
 *  Q3View_SetDefaultAttributeSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_SetDefaultAttributeSet(view: TQ3ViewObject; attributeSet: TQ3AttributeSet): TQ3Status; C;


{
 *  Q3View_GetAttributeSetState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetAttributeSetState(view: TQ3ViewObject; VAR attributeSet: TQ3AttributeSet): TQ3Status; C;

{
 *  Q3View_GetAttributeState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3View_GetAttributeState(view: TQ3ViewObject; attributeType: TQ3AttributeType; data: UNIV Ptr): TQ3Status; C;



{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DViewIncludes}

{$ENDC} {__QD3DVIEW__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

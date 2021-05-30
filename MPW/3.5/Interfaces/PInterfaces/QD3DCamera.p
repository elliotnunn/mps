{
     File:       QD3DCamera.p
 
     Contains:   Generic camera routines
 
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
 UNIT QD3DCamera;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DCAMERA__}
{$SETC __QD3DCAMERA__ := 1}

{$I+}
{$SETC QD3DCameraIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **                                                                          **
 **                         Data Structure Definitions                       **
 **                                                                          **
 ****************************************************************************}
{
 *  The placement of the camera.
 }

TYPE
	TQ3CameraPlacementPtr = ^TQ3CameraPlacement;
	TQ3CameraPlacement = RECORD
		cameraLocation:			TQ3Point3D;								{   Location point of the camera   }
		pointOfInterest:		TQ3Point3D;								{   Point of interest            }
		upVector:				TQ3Vector3D;							{   "up" vector              }
	END;

	{	
	 *  The range of the camera.
	 	}
	TQ3CameraRangePtr = ^TQ3CameraRange;
	TQ3CameraRange = RECORD
		hither:					Single;									{   Hither plane, measured from "from" towards "to"    }
		yon:					Single;									{   Yon  plane, measured from "from" towards "to"      }
	END;

	{	
	 *  Viewport specification.  Origin is (-1, 1), and corresponds to the 
	 *  upper left-hand corner; width and height maximum is (2.0, 2.0),
	 *  corresponding to the lower left-hand corner of the window.  The
	 *  TQ3Viewport specifies a part of the viewPlane that gets displayed 
	 *  on the window that is to be drawn.
	 *  Normally, it is set with an origin of (-1.0, 1.0), and a width and
	 *  height of both 2.0, specifying that the entire window is to be
	 *  drawn.  If, for example, an exposure event of the window exposed
	 *  the right half of the window, you would set the origin to (0, 1),
	 *  and the width and height to (1.0) and (2.0), respectively.
	 *
	 	}
	TQ3CameraViewPortPtr = ^TQ3CameraViewPort;
	TQ3CameraViewPort = RECORD
		origin:					TQ3Point2D;
		width:					Single;
		height:					Single;
	END;

	TQ3CameraDataPtr = ^TQ3CameraData;
	TQ3CameraData = RECORD
		placement:				TQ3CameraPlacement;
		range:					TQ3CameraRange;
		viewPort:				TQ3CameraViewPort;
	END;

	{	
	 *  An orthographic camera.
	 *
	 *  The lens characteristics are set with the dimensions of a
	 *  rectangular viewPort in the frame of the camera.
	 	}
	TQ3OrthographicCameraDataPtr = ^TQ3OrthographicCameraData;
	TQ3OrthographicCameraData = RECORD
		cameraData:				TQ3CameraData;
		left:					Single;
		top:					Single;
		right:					Single;
		bottom:					Single;
	END;

	{	
	 *  A perspective camera specified in terms of an arbitrary view plane.
	 *
	 *  This is most useful when setting the camera to look at a particular
	 *  object.  The viewPlane is set to distance from the camera to the object.
	 *  The halfWidth is set to half the width of the cross section of the object,
	 *  and the halfHeight equal to the halfWidth divided by the aspect ratio
	 *  of the viewPort.
	 * 
	 *  This is the only perspective camera with specifications for off-axis
	 *  viewing, which is desirable for scrolling.
	 	}
	TQ3ViewPlaneCameraDataPtr = ^TQ3ViewPlaneCameraData;
	TQ3ViewPlaneCameraData = RECORD
		cameraData:				TQ3CameraData;
		viewPlane:				Single;
		halfWidthAtViewPlane:	Single;
		halfHeightAtViewPlane:	Single;
		centerXOnViewPlane:		Single;
		centerYOnViewPlane:		Single;
	END;

	{	
	 *  A view angle aspect camera is a perspective camera specified in 
	 *  terms of the minimum view angle and the aspect ratio of X to Y.
	 *
	 	}
	TQ3ViewAngleAspectCameraDataPtr = ^TQ3ViewAngleAspectCameraData;
	TQ3ViewAngleAspectCameraData = RECORD
		cameraData:				TQ3CameraData;
		fov:					Single;
		aspectRatioXToY:		Single;
	END;

	{	*****************************************************************************
	 **                                                                          **
	 **                         Generic Camera routines                          **
	 **                                                                          **
	 ****************************************************************************	}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3Camera_GetType()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3Camera_GetType(camera: TQ3CameraObject): TQ3ObjectType; C;

{
 *  Q3Camera_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Camera_SetData(camera: TQ3CameraObject; {CONST}VAR cameraData: TQ3CameraData): TQ3Status; C;

{
 *  Q3Camera_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Camera_GetData(camera: TQ3CameraObject; VAR cameraData: TQ3CameraData): TQ3Status; C;

{
 *  Q3Camera_SetPlacement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Camera_SetPlacement(camera: TQ3CameraObject; {CONST}VAR placement: TQ3CameraPlacement): TQ3Status; C;

{
 *  Q3Camera_GetPlacement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Camera_GetPlacement(camera: TQ3CameraObject; VAR placement: TQ3CameraPlacement): TQ3Status; C;

{
 *  Q3Camera_SetRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Camera_SetRange(camera: TQ3CameraObject; {CONST}VAR range: TQ3CameraRange): TQ3Status; C;

{
 *  Q3Camera_GetRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Camera_GetRange(camera: TQ3CameraObject; VAR range: TQ3CameraRange): TQ3Status; C;

{
 *  Q3Camera_SetViewPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Camera_SetViewPort(camera: TQ3CameraObject; {CONST}VAR viewPort: TQ3CameraViewPort): TQ3Status; C;

{
 *  Q3Camera_GetViewPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Camera_GetViewPort(camera: TQ3CameraObject; VAR viewPort: TQ3CameraViewPort): TQ3Status; C;

{
 *  Q3Camera_GetWorldToView()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Camera_GetWorldToView(camera: TQ3CameraObject; VAR worldToView: TQ3Matrix4x4): TQ3Status; C;

{
 *  Q3Camera_GetWorldToFrustum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Camera_GetWorldToFrustum(camera: TQ3CameraObject; VAR worldToFrustum: TQ3Matrix4x4): TQ3Status; C;

{
 *  Q3Camera_GetViewToFrustum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Camera_GetViewToFrustum(camera: TQ3CameraObject; VAR viewToFrustum: TQ3Matrix4x4): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         Specific Camera Routines                         **
 **                                                                          **
 ****************************************************************************}
{*****************************************************************************
 **                                                                          **
 **                         Orthographic Camera                              **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3OrthographicCamera_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3OrthographicCamera_New({CONST}VAR orthographicData: TQ3OrthographicCameraData): TQ3CameraObject; C;

{
 *  Q3OrthographicCamera_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3OrthographicCamera_GetData(camera: TQ3CameraObject; VAR cameraData: TQ3OrthographicCameraData): TQ3Status; C;

{
 *  Q3OrthographicCamera_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3OrthographicCamera_SetData(camera: TQ3CameraObject; {CONST}VAR cameraData: TQ3OrthographicCameraData): TQ3Status; C;

{
 *  Q3OrthographicCamera_SetLeft()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3OrthographicCamera_SetLeft(camera: TQ3CameraObject; left: Single): TQ3Status; C;

{
 *  Q3OrthographicCamera_GetLeft()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3OrthographicCamera_GetLeft(camera: TQ3CameraObject; VAR left: Single): TQ3Status; C;

{
 *  Q3OrthographicCamera_SetTop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3OrthographicCamera_SetTop(camera: TQ3CameraObject; top: Single): TQ3Status; C;

{
 *  Q3OrthographicCamera_GetTop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3OrthographicCamera_GetTop(camera: TQ3CameraObject; VAR top: Single): TQ3Status; C;

{
 *  Q3OrthographicCamera_SetRight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3OrthographicCamera_SetRight(camera: TQ3CameraObject; right: Single): TQ3Status; C;

{
 *  Q3OrthographicCamera_GetRight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3OrthographicCamera_GetRight(camera: TQ3CameraObject; VAR right: Single): TQ3Status; C;

{
 *  Q3OrthographicCamera_SetBottom()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3OrthographicCamera_SetBottom(camera: TQ3CameraObject; bottom: Single): TQ3Status; C;

{
 *  Q3OrthographicCamera_GetBottom()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3OrthographicCamera_GetBottom(camera: TQ3CameraObject; VAR bottom: Single): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         ViewPlane Camera                                 **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewPlaneCamera_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewPlaneCamera_New({CONST}VAR cameraData: TQ3ViewPlaneCameraData): TQ3CameraObject; C;

{
 *  Q3ViewPlaneCamera_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewPlaneCamera_GetData(camera: TQ3CameraObject; VAR cameraData: TQ3ViewPlaneCameraData): TQ3Status; C;

{
 *  Q3ViewPlaneCamera_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewPlaneCamera_SetData(camera: TQ3CameraObject; {CONST}VAR cameraData: TQ3ViewPlaneCameraData): TQ3Status; C;

{
 *  Q3ViewPlaneCamera_SetViewPlane()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewPlaneCamera_SetViewPlane(camera: TQ3CameraObject; viewPlane: Single): TQ3Status; C;

{
 *  Q3ViewPlaneCamera_GetViewPlane()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewPlaneCamera_GetViewPlane(camera: TQ3CameraObject; VAR viewPlane: Single): TQ3Status; C;

{
 *  Q3ViewPlaneCamera_SetHalfWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewPlaneCamera_SetHalfWidth(camera: TQ3CameraObject; halfWidthAtViewPlane: Single): TQ3Status; C;

{
 *  Q3ViewPlaneCamera_GetHalfWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewPlaneCamera_GetHalfWidth(camera: TQ3CameraObject; VAR halfWidthAtViewPlane: Single): TQ3Status; C;

{
 *  Q3ViewPlaneCamera_SetHalfHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewPlaneCamera_SetHalfHeight(camera: TQ3CameraObject; halfHeightAtViewPlane: Single): TQ3Status; C;

{
 *  Q3ViewPlaneCamera_GetHalfHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewPlaneCamera_GetHalfHeight(camera: TQ3CameraObject; VAR halfHeightAtViewPlane: Single): TQ3Status; C;

{
 *  Q3ViewPlaneCamera_SetCenterX()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewPlaneCamera_SetCenterX(camera: TQ3CameraObject; centerXOnViewPlane: Single): TQ3Status; C;

{
 *  Q3ViewPlaneCamera_GetCenterX()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewPlaneCamera_GetCenterX(camera: TQ3CameraObject; VAR centerXOnViewPlane: Single): TQ3Status; C;

{
 *  Q3ViewPlaneCamera_SetCenterY()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewPlaneCamera_SetCenterY(camera: TQ3CameraObject; centerYOnViewPlane: Single): TQ3Status; C;

{
 *  Q3ViewPlaneCamera_GetCenterY()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewPlaneCamera_GetCenterY(camera: TQ3CameraObject; VAR centerYOnViewPlane: Single): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         View Angle Aspect Camera                         **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ViewAngleAspectCamera_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewAngleAspectCamera_New({CONST}VAR cameraData: TQ3ViewAngleAspectCameraData): TQ3CameraObject; C;

{
 *  Q3ViewAngleAspectCamera_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewAngleAspectCamera_SetData(camera: TQ3CameraObject; {CONST}VAR cameraData: TQ3ViewAngleAspectCameraData): TQ3Status; C;

{
 *  Q3ViewAngleAspectCamera_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewAngleAspectCamera_GetData(camera: TQ3CameraObject; VAR cameraData: TQ3ViewAngleAspectCameraData): TQ3Status; C;

{
 *  Q3ViewAngleAspectCamera_SetFOV()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewAngleAspectCamera_SetFOV(camera: TQ3CameraObject; fov: Single): TQ3Status; C;

{
 *  Q3ViewAngleAspectCamera_GetFOV()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewAngleAspectCamera_GetFOV(camera: TQ3CameraObject; VAR fov: Single): TQ3Status; C;

{
 *  Q3ViewAngleAspectCamera_SetAspectRatio()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewAngleAspectCamera_SetAspectRatio(camera: TQ3CameraObject; aspectRatioXToY: Single): TQ3Status; C;

{
 *  Q3ViewAngleAspectCamera_GetAspectRatio()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ViewAngleAspectCamera_GetAspectRatio(camera: TQ3CameraObject; VAR aspectRatioXToY: Single): TQ3Status; C;




{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DCameraIncludes}

{$ENDC} {__QD3DCAMERA__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

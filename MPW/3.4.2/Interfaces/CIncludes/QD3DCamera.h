/******************************************************************************
 **																			 **
 ** 	Module:		QD3DCamera.h											 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose: 	Generic camera routines								 	 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1991-1995 Apple Computer, Inc. All rights reserved.	 **	
 ** 																		 **
 *****************************************************************************/
#ifndef QD3DCamera_h
#define QD3DCamera_h

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

#ifdef __cplusplus
extern "C" {
#endif	/* __cplusplus */


/******************************************************************************
 **																			 **
 **							Data Structure Definitions						 **
 **																			 **
 *****************************************************************************/
/*
 *  The placement of the camera.
 */
typedef struct TQ3CameraPlacement{
	TQ3Point3D		cameraLocation;		/*  Location point of the camera 	*/
	TQ3Point3D		pointOfInterest;	/*  Point of interest 				*/
	TQ3Vector3D		upVector;			/*  "up" vector 					*/
} TQ3CameraPlacement;


/*
 *  The range of the camera.
 */
typedef struct TQ3CameraRange {
	float	hither;		/*  Hither plane, measured from "from" towards "to"	*/
	float	yon;		/*  Yon  plane, measured from "from" towards "to" 	*/
} TQ3CameraRange;


/*
 *  Viewport specification.  Origin is (-1, 1), and corresponds to the 
 *  upper left-hand corner; width and height maximum is (2.0, 2.0),
 *  corresponding to the lower left-hand corner of the window.  The
 *  TQ3Viewport specifies a part of the viewPlane that gets displayed 
 *	on the window that is to be drawn.
 *  Normally, it is set with an origin of (-1.0, 1.0), and a width and
 *  height of both 2.0, specifying that the entire window is to be
 *  drawn.  If, for example, an exposure event of the window exposed
 *  the right half of the window, you would set the origin to (0, 1),
 *  and the width and height to (1.0) and (2.0), respectively.
 *
 */
typedef struct TQ3CameraViewPort {
	TQ3Point2D		origin;
	float			width;
	float			height;
} TQ3CameraViewPort;

 
typedef struct TQ3CameraData {
	TQ3CameraPlacement	placement;
	TQ3CameraRange		range;
	TQ3CameraViewPort	viewPort;
} TQ3CameraData;


/*
 *  An orthographic camera.
 *
 *  The lens characteristics are set with the dimensions of a
 *  rectangular viewPort in the frame of the camera.
 */
typedef struct TQ3OrthographicCameraData {
	TQ3CameraData		cameraData;
	float				left;
	float				top;
	float				right;
	float				bottom;
} TQ3OrthographicCameraData;

/*
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
 */
typedef struct TQ3ViewPlaneCameraData {
	TQ3CameraData		cameraData;
	float				viewPlane;
	float				halfWidthAtViewPlane;
	float				halfHeightAtViewPlane;
	float				centerXOnViewPlane;
	float				centerYOnViewPlane;
} TQ3ViewPlaneCameraData;

/*
 *	A view angle aspect camera is a perspective camera specified in 
 *	terms of the minimum view angle and the aspect ratio of X to Y.
 *
 */
typedef struct TQ3ViewAngleAspectCameraData {
	TQ3CameraData		cameraData;
	float				fov;
	float				aspectRatioXToY;
} TQ3ViewAngleAspectCameraData;


/******************************************************************************
 **																			 **
 **							Generic Camera routines						     **
 **																			 **
 *****************************************************************************/
 

QD3D_EXPORT TQ3ObjectType Q3Camera_GetType(
	TQ3CameraObject				camera);

QD3D_EXPORT TQ3Status Q3Camera_SetData(
	TQ3CameraObject				camera,
	const TQ3CameraData			*cameraData);

QD3D_EXPORT TQ3Status Q3Camera_GetData(
	TQ3CameraObject				camera,
	TQ3CameraData				*cameraData);
	
QD3D_EXPORT TQ3Status Q3Camera_SetPlacement(
	TQ3CameraObject				camera,
	const TQ3CameraPlacement	*placement);
	
QD3D_EXPORT TQ3Status Q3Camera_GetPlacement(
	TQ3CameraObject				camera,
	TQ3CameraPlacement			*placement);
	
QD3D_EXPORT TQ3Status Q3Camera_SetRange(
	TQ3CameraObject				camera,
	const TQ3CameraRange		*range);

QD3D_EXPORT TQ3Status Q3Camera_GetRange(
	TQ3CameraObject				camera,
	TQ3CameraRange				*range);

QD3D_EXPORT TQ3Status Q3Camera_SetViewPort(
	TQ3CameraObject				camera,
	const TQ3CameraViewPort		*viewPort);

QD3D_EXPORT TQ3Status Q3Camera_GetViewPort(
	TQ3CameraObject				camera,
	TQ3CameraViewPort			*viewPort);

QD3D_EXPORT TQ3Status Q3Camera_GetWorldToView( 
	TQ3CameraObject				camera,
	TQ3Matrix4x4				*worldToView);

QD3D_EXPORT TQ3Status Q3Camera_GetWorldToFrustum( 
	TQ3CameraObject				camera,
	TQ3Matrix4x4				*worldToFrustum);

QD3D_EXPORT TQ3Status Q3Camera_GetViewToFrustum(
	TQ3CameraObject				camera,
	TQ3Matrix4x4				*viewToFrustum);


/******************************************************************************
 **																			 **
 **							Specific Camera Routines					 	 **
 **																			 **
 *****************************************************************************/

/******************************************************************************
 **																			 **
 **							Orthographic Camera							 	 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3CameraObject Q3OrthographicCamera_New(
	const TQ3OrthographicCameraData	*orthographicData);

QD3D_EXPORT TQ3Status Q3OrthographicCamera_GetData(
	TQ3CameraObject					camera,
	TQ3OrthographicCameraData		*cameraData);

QD3D_EXPORT TQ3Status Q3OrthographicCamera_SetData(
	TQ3CameraObject					camera,
	const TQ3OrthographicCameraData	*cameraData);

QD3D_EXPORT TQ3Status Q3OrthographicCamera_SetLeft(
	TQ3CameraObject					camera,
	float							left);
	
QD3D_EXPORT TQ3Status Q3OrthographicCamera_GetLeft(
	TQ3CameraObject					camera,
	float							*left);

QD3D_EXPORT TQ3Status Q3OrthographicCamera_SetTop(
	TQ3CameraObject					camera,
	float							top);
	
QD3D_EXPORT TQ3Status Q3OrthographicCamera_GetTop(
	TQ3CameraObject					camera,
	float							*top);

QD3D_EXPORT TQ3Status Q3OrthographicCamera_SetRight(
	TQ3CameraObject					camera,
	float							right);
	
QD3D_EXPORT TQ3Status Q3OrthographicCamera_GetRight(
	TQ3CameraObject					camera,
	float							*right);

QD3D_EXPORT TQ3Status Q3OrthographicCamera_SetBottom(
	TQ3CameraObject					camera,
	float							bottom);
	
QD3D_EXPORT TQ3Status Q3OrthographicCamera_GetBottom(
	TQ3CameraObject					camera,
	float							*bottom);


/******************************************************************************
 **																			 **
 **							ViewPlane Camera							 	 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3CameraObject Q3ViewPlaneCamera_New(
	const TQ3ViewPlaneCameraData	*cameraData);
	
QD3D_EXPORT TQ3Status Q3ViewPlaneCamera_GetData(
	TQ3CameraObject					camera,
	TQ3ViewPlaneCameraData			*cameraData);

QD3D_EXPORT TQ3Status Q3ViewPlaneCamera_SetData(
	TQ3CameraObject					camera,
	const TQ3ViewPlaneCameraData	*cameraData);

QD3D_EXPORT TQ3Status Q3ViewPlaneCamera_SetViewPlane(
	TQ3CameraObject					camera,
	float							viewPlane);
	
QD3D_EXPORT TQ3Status Q3ViewPlaneCamera_GetViewPlane(
	TQ3CameraObject					camera,
	float							*viewPlane);

QD3D_EXPORT TQ3Status Q3ViewPlaneCamera_SetHalfWidth(
	TQ3CameraObject					camera,
	float							halfWidthAtViewPlane);

QD3D_EXPORT TQ3Status Q3ViewPlaneCamera_GetHalfWidth(
	TQ3CameraObject					camera,
	float							*halfWidthAtViewPlane);

QD3D_EXPORT TQ3Status Q3ViewPlaneCamera_SetHalfHeight(
	TQ3CameraObject					camera,
	float							halfHeightAtViewPlane);

QD3D_EXPORT TQ3Status Q3ViewPlaneCamera_GetHalfHeight(
	TQ3CameraObject					camera,
	float							*halfHeightAtViewPlane);
	
QD3D_EXPORT TQ3Status Q3ViewPlaneCamera_SetCenterX(
	TQ3CameraObject					camera,
	float							centerXOnViewPlane);
	
QD3D_EXPORT TQ3Status Q3ViewPlaneCamera_GetCenterX(
	TQ3CameraObject					camera,
	float							*centerXOnViewPlane);
	
QD3D_EXPORT TQ3Status Q3ViewPlaneCamera_SetCenterY(
	TQ3CameraObject					camera,
	float							centerYOnViewPlane);
	
QD3D_EXPORT TQ3Status Q3ViewPlaneCamera_GetCenterY(
	TQ3CameraObject					camera,
	float							*centerYOnViewPlane);


/******************************************************************************
 **																			 **
 **							View Angle Aspect Camera					 	 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3CameraObject Q3ViewAngleAspectCamera_New(
	const TQ3ViewAngleAspectCameraData	*cameraData);

QD3D_EXPORT TQ3Status Q3ViewAngleAspectCamera_SetData(
	TQ3CameraObject						camera,
	const TQ3ViewAngleAspectCameraData	*cameraData);
	
QD3D_EXPORT TQ3Status Q3ViewAngleAspectCamera_GetData(
	TQ3CameraObject						camera,
	TQ3ViewAngleAspectCameraData		*cameraData);

QD3D_EXPORT TQ3Status Q3ViewAngleAspectCamera_SetFOV(
	TQ3CameraObject						camera,
	float								fov);

QD3D_EXPORT TQ3Status Q3ViewAngleAspectCamera_GetFOV(
	TQ3CameraObject						camera,
	float								*fov);

QD3D_EXPORT TQ3Status Q3ViewAngleAspectCamera_SetAspectRatio(
	TQ3CameraObject						camera,
	float								aspectRatioXToY);
	
QD3D_EXPORT TQ3Status Q3ViewAngleAspectCamera_GetAspectRatio(
	TQ3CameraObject						camera,
	float								*aspectRatioXToY);


#ifdef __cplusplus
}
#endif	/* __cplusplus */

#if defined(__MWERKS__)
#pragma options align=reset
#pragma enumsalwaysint reset
#endif

#endif  /*  QD3DCamera_h  */

{
     File:       QD3DTransform.p
 
     Contains:   Q3Transform routines
 
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
 UNIT QD3DTransform;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DTRANSFORM__}
{$SETC __QD3DTRANSFORM__ := 1}

{$I+}
{$SETC QD3DTransformIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **                                                                          **
 **                         Transform Routines                               **
 **                                                                          **
 ****************************************************************************}
{$IFC CALL_NOT_IN_CARBON }
{
 *  Q3Transform_GetType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Transform_GetType(transform: TQ3TransformObject): TQ3ObjectType; C;

{
 *  Q3Transform_GetMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Transform_GetMatrix(transform: TQ3TransformObject; VAR matrix: TQ3Matrix4x4): TQ3Matrix4x4Ptr; C;

{
 *  Q3Transform_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Transform_Submit(transform: TQ3TransformObject; view: TQ3ViewObject): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         MatrixTransform Routines                         **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3MatrixTransform_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3MatrixTransform_New({CONST}VAR matrix: TQ3Matrix4x4): TQ3TransformObject; C;

{
 *  Q3MatrixTransform_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3MatrixTransform_Submit({CONST}VAR matrix: TQ3Matrix4x4; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3MatrixTransform_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3MatrixTransform_Set(transform: TQ3TransformObject; {CONST}VAR matrix: TQ3Matrix4x4): TQ3Status; C;

{
 *  Q3MatrixTransform_Get()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3MatrixTransform_Get(transform: TQ3TransformObject; VAR matrix: TQ3Matrix4x4): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         RotateTransform Data                             **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3RotateTransformDataPtr = ^TQ3RotateTransformData;
	TQ3RotateTransformData = RECORD
		axis:					TQ3Axis;
		radians:				Single;
	END;

	{	*****************************************************************************
	 **                                                                          **
	 **                         RotateTransform Routines                         **
	 **                                                                          **
	 ****************************************************************************	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3RotateTransform_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3RotateTransform_New({CONST}VAR data: TQ3RotateTransformData): TQ3TransformObject; C;


{
 *  Q3RotateTransform_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateTransform_Submit({CONST}VAR data: TQ3RotateTransformData; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3RotateTransform_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateTransform_SetData(transform: TQ3TransformObject; {CONST}VAR data: TQ3RotateTransformData): TQ3Status; C;

{
 *  Q3RotateTransform_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateTransform_GetData(transform: TQ3TransformObject; VAR data: TQ3RotateTransformData): TQ3Status; C;

{
 *  Q3RotateTransform_SetAxis()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateTransform_SetAxis(transform: TQ3TransformObject; axis: TQ3Axis): TQ3Status; C;

{
 *  Q3RotateTransform_SetAngle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateTransform_SetAngle(transform: TQ3TransformObject; radians: Single): TQ3Status; C;

{
 *  Q3RotateTransform_GetAxis()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateTransform_GetAxis(renderable: TQ3TransformObject; VAR axis: TQ3Axis): TQ3Status; C;

{
 *  Q3RotateTransform_GetAngle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateTransform_GetAngle(transform: TQ3TransformObject; VAR radians: Single): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                 RotateAboutPointTransform Data                           **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3RotateAboutPointTransformDataPtr = ^TQ3RotateAboutPointTransformData;
	TQ3RotateAboutPointTransformData = RECORD
		axis:					TQ3Axis;
		radians:				Single;
		about:					TQ3Point3D;
	END;

	{	*****************************************************************************
	 **                                                                          **
	 **                 RotateAboutPointTransform Routines                       **
	 **                                                                          **
	 ****************************************************************************	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3RotateAboutPointTransform_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3RotateAboutPointTransform_New({CONST}VAR data: TQ3RotateAboutPointTransformData): TQ3TransformObject; C;

{
 *  Q3RotateAboutPointTransform_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutPointTransform_Submit({CONST}VAR data: TQ3RotateAboutPointTransformData; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3RotateAboutPointTransform_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutPointTransform_SetData(transform: TQ3TransformObject; {CONST}VAR data: TQ3RotateAboutPointTransformData): TQ3Status; C;

{
 *  Q3RotateAboutPointTransform_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutPointTransform_GetData(transform: TQ3TransformObject; VAR data: TQ3RotateAboutPointTransformData): TQ3Status; C;

{
 *  Q3RotateAboutPointTransform_SetAxis()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutPointTransform_SetAxis(transform: TQ3TransformObject; axis: TQ3Axis): TQ3Status; C;

{
 *  Q3RotateAboutPointTransform_GetAxis()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutPointTransform_GetAxis(transform: TQ3TransformObject; VAR axis: TQ3Axis): TQ3Status; C;


{
 *  Q3RotateAboutPointTransform_SetAngle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutPointTransform_SetAngle(transform: TQ3TransformObject; radians: Single): TQ3Status; C;

{
 *  Q3RotateAboutPointTransform_GetAngle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutPointTransform_GetAngle(transform: TQ3TransformObject; VAR radians: Single): TQ3Status; C;


{
 *  Q3RotateAboutPointTransform_SetAboutPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutPointTransform_SetAboutPoint(transform: TQ3TransformObject; {CONST}VAR about: TQ3Point3D): TQ3Status; C;

{
 *  Q3RotateAboutPointTransform_GetAboutPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutPointTransform_GetAboutPoint(transform: TQ3TransformObject; VAR about: TQ3Point3D): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                 RotateAboutAxisTransform Data                            **
 **                                                                          **
 ****************************************************************************}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	TQ3RotateAboutAxisTransformDataPtr = ^TQ3RotateAboutAxisTransformData;
	TQ3RotateAboutAxisTransformData = RECORD
		origin:					TQ3Point3D;
		orientation:			TQ3Vector3D;
		radians:				Single;
	END;

	{	*****************************************************************************
	 **                                                                          **
	 **                 RotateAboutAxisTransform Routines                        **
	 **                                                                          **
	 ****************************************************************************	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Q3RotateAboutAxisTransform_New()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Q3RotateAboutAxisTransform_New({CONST}VAR data: TQ3RotateAboutAxisTransformData): TQ3TransformObject; C;

{
 *  Q3RotateAboutAxisTransform_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutAxisTransform_Submit({CONST}VAR data: TQ3RotateAboutAxisTransformData; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3RotateAboutAxisTransform_SetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutAxisTransform_SetData(transform: TQ3TransformObject; {CONST}VAR data: TQ3RotateAboutAxisTransformData): TQ3Status; C;

{
 *  Q3RotateAboutAxisTransform_GetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutAxisTransform_GetData(transform: TQ3TransformObject; VAR data: TQ3RotateAboutAxisTransformData): TQ3Status; C;


{
 *  Q3RotateAboutAxisTransform_SetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutAxisTransform_SetOrientation(transform: TQ3TransformObject; {CONST}VAR axis: TQ3Vector3D): TQ3Status; C;

{
 *  Q3RotateAboutAxisTransform_GetOrientation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutAxisTransform_GetOrientation(transform: TQ3TransformObject; VAR axis: TQ3Vector3D): TQ3Status; C;


{
 *  Q3RotateAboutAxisTransform_SetAngle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutAxisTransform_SetAngle(transform: TQ3TransformObject; radians: Single): TQ3Status; C;

{
 *  Q3RotateAboutAxisTransform_GetAngle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutAxisTransform_GetAngle(transform: TQ3TransformObject; VAR radians: Single): TQ3Status; C;


{
 *  Q3RotateAboutAxisTransform_SetOrigin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutAxisTransform_SetOrigin(transform: TQ3TransformObject; {CONST}VAR origin: TQ3Point3D): TQ3Status; C;

{
 *  Q3RotateAboutAxisTransform_GetOrigin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RotateAboutAxisTransform_GetOrigin(transform: TQ3TransformObject; VAR origin: TQ3Point3D): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         ScaleTransform Routines                          **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ScaleTransform_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ScaleTransform_New({CONST}VAR scale: TQ3Vector3D): TQ3TransformObject; C;

{
 *  Q3ScaleTransform_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ScaleTransform_Submit({CONST}VAR scale: TQ3Vector3D; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3ScaleTransform_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ScaleTransform_Set(transform: TQ3TransformObject; {CONST}VAR scale: TQ3Vector3D): TQ3Status; C;

{
 *  Q3ScaleTransform_Get()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ScaleTransform_Get(transform: TQ3TransformObject; VAR scale: TQ3Vector3D): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         TranslateTransform Routines                      **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3TranslateTransform_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3TranslateTransform_New({CONST}VAR translate: TQ3Vector3D): TQ3TransformObject; C;

{
 *  Q3TranslateTransform_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3TranslateTransform_Submit({CONST}VAR translate: TQ3Vector3D; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3TranslateTransform_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3TranslateTransform_Set(transform: TQ3TransformObject; {CONST}VAR translate: TQ3Vector3D): TQ3Status; C;

{
 *  Q3TranslateTransform_Get()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3TranslateTransform_Get(transform: TQ3TransformObject; VAR translate: TQ3Vector3D): TQ3Status; C;

{*****************************************************************************
 **                                                                          **
 **                         QuaternionTransform Routines                     **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3QuaternionTransform_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3QuaternionTransform_New({CONST}VAR quaternion: TQ3Quaternion): TQ3TransformObject; C;

{
 *  Q3QuaternionTransform_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3QuaternionTransform_Submit({CONST}VAR quaternion: TQ3Quaternion; view: TQ3ViewObject): TQ3Status; C;

{
 *  Q3QuaternionTransform_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3QuaternionTransform_Set(transform: TQ3TransformObject; {CONST}VAR quaternion: TQ3Quaternion): TQ3Status; C;

{
 *  Q3QuaternionTransform_Get()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3QuaternionTransform_Get(transform: TQ3TransformObject; VAR quaternion: TQ3Quaternion): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                         ResetTransform Routines                          **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3ResetTransform_New()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ResetTransform_New: TQ3TransformObject; C;

{
 *  Q3ResetTransform_Submit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3ResetTransform_Submit(view: TQ3ViewObject): TQ3Status; C;




{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DTransformIncludes}

{$ENDC} {__QD3DTRANSFORM__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

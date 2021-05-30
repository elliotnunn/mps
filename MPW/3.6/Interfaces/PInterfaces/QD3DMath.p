{
     File:       QD3DMath.p
 
     Contains:   Math & matrix routines and definitions.
 
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
 UNIT QD3DMath;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QD3DMATH__}
{$SETC __QD3DMATH__ := 1}

{$I+}
{$SETC QD3DMathIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QD3D__}
{$I QD3D.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{*****************************************************************************
 **                                                                          **
 **                         Constant Definitions                             **
 **                                                                          **
 ****************************************************************************}
{
 *  Real zero definition
 }
CONST
    kQ3RealZero         = 1.19209290e-07;
    kQ3MaxFloat         = 3.40282347e+38;
{
 *  Values of PI
 }
    kQ3Pi               = 3.1415926535898;
    kQ32Pi              = 2.0 * 3.1415926535898;
    kQ3PiOver2          = 3.1415926535898 / 2.0;
    kQ33PiOver2         = 3.0 * 3.1415926535898 / 2.0;


{*****************************************************************************
 **                                                                          **
 **                         Miscellaneous Functions                          **
 **                                                                          **
 ****************************************************************************}

{*****************************************************************************
 **                                                                          **
 **                         Point and Vector Creation                        **
 **                                                                          **
 ****************************************************************************}
{$IFC CALL_NOT_IN_CARBON }
{
 *  Q3Point2D_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point2D_Set(VAR point2D: TQ3Point2D; x: Single; y: Single): TQ3Point2DPtr; C;

{
 *  Q3Param2D_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Param2D_Set(VAR param2D: TQ3Param2D; u: Single; v: Single): TQ3Param2DPtr; C;

{
 *  Q3Point3D_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point3D_Set(VAR point3D: TQ3Point3D; x: Single; y: Single; z: Single): TQ3Point3DPtr; C;

{
 *  Q3RationalPoint3D_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RationalPoint3D_Set(VAR point3D: TQ3RationalPoint3D; x: Single; y: Single; w: Single): TQ3RationalPoint3DPtr; C;

{
 *  Q3RationalPoint4D_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RationalPoint4D_Set(VAR point4D: TQ3RationalPoint4D; x: Single; y: Single; z: Single; w: Single): TQ3RationalPoint4DPtr; C;

{
 *  Q3Vector2D_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector2D_Set(VAR vector2D: TQ3Vector2D; x: Single; y: Single): TQ3Vector2DPtr; C;

{
 *  Q3Vector3D_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector3D_Set(VAR vector3D: TQ3Vector3D; x: Single; y: Single; z: Single): TQ3Vector3DPtr; C;

{
 *  Q3PolarPoint_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3PolarPoint_Set(VAR polarPoint: TQ3PolarPoint; r: Single; theta: Single): TQ3PolarPointPtr; C;

{
 *  Q3SphericalPoint_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3SphericalPoint_Set(VAR sphericalPoint: TQ3SphericalPoint; rho: Single; theta: Single; phi: Single): TQ3SphericalPointPtr; C;


{*****************************************************************************
 **                                                                          **
 **                 Point and Vector Dimension Conversion                    **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Point2D_To3D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point2D_To3D({CONST}VAR point2D: TQ3Point2D; VAR result: TQ3Point3D): TQ3Point3DPtr; C;

{
 *  Q3RationalPoint3D_To2D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RationalPoint3D_To2D({CONST}VAR point3D: TQ3RationalPoint3D; VAR result: TQ3Point2D): TQ3Point2DPtr; C;

{
 *  Q3Point3D_To4D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point3D_To4D({CONST}VAR point3D: TQ3Point3D; VAR result: TQ3RationalPoint4D): TQ3RationalPoint4DPtr; C;

{
 *  Q3RationalPoint4D_To3D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RationalPoint4D_To3D({CONST}VAR point4D: TQ3RationalPoint4D; VAR result: TQ3Point3D): TQ3Point3DPtr; C;

{
 *  Q3Vector2D_To3D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector2D_To3D({CONST}VAR vector2D: TQ3Vector2D; VAR result: TQ3Vector3D): TQ3Vector3DPtr; C;

{
 *  Q3Vector3D_To2D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector3D_To2D({CONST}VAR vector3D: TQ3Vector3D; VAR result: TQ3Vector2D): TQ3Vector2DPtr; C;


{*****************************************************************************
 **                                                                          **
 **                         Point Subtraction                                **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Point2D_Subtract()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point2D_Subtract({CONST}VAR p1: TQ3Point2D; {CONST}VAR p2: TQ3Point2D; VAR result: TQ3Vector2D): TQ3Vector2DPtr; C;

{
 *  Q3Param2D_Subtract()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Param2D_Subtract({CONST}VAR p1: TQ3Param2D; {CONST}VAR p2: TQ3Param2D; VAR result: TQ3Vector2D): TQ3Vector2DPtr; C;

{
 *  Q3Point3D_Subtract()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point3D_Subtract({CONST}VAR p1: TQ3Point3D; {CONST}VAR p2: TQ3Point3D; VAR result: TQ3Vector3D): TQ3Vector3DPtr; C;


{*****************************************************************************
 **                                                                          **
 **                         Point Distance                                   **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Point2D_Distance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point2D_Distance({CONST}VAR p1: TQ3Point2D; {CONST}VAR p2: TQ3Point2D): Single; C;

{
 *  Q3Point2D_DistanceSquared()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point2D_DistanceSquared({CONST}VAR p1: TQ3Point2D; {CONST}VAR p2: TQ3Point2D): Single; C;


{
 *  Q3Param2D_Distance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Param2D_Distance({CONST}VAR p1: TQ3Param2D; {CONST}VAR p2: TQ3Param2D): Single; C;

{
 *  Q3Param2D_DistanceSquared()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Param2D_DistanceSquared({CONST}VAR p1: TQ3Param2D; {CONST}VAR p2: TQ3Param2D): Single; C;


{
 *  Q3RationalPoint3D_Distance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RationalPoint3D_Distance({CONST}VAR p1: TQ3RationalPoint3D; {CONST}VAR p2: TQ3RationalPoint3D): Single; C;

{
 *  Q3RationalPoint3D_DistanceSquared()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RationalPoint3D_DistanceSquared({CONST}VAR p1: TQ3RationalPoint3D; {CONST}VAR p2: TQ3RationalPoint3D): Single; C;


{
 *  Q3Point3D_Distance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point3D_Distance({CONST}VAR p1: TQ3Point3D; {CONST}VAR p2: TQ3Point3D): Single; C;

{
 *  Q3Point3D_DistanceSquared()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point3D_DistanceSquared({CONST}VAR p1: TQ3Point3D; {CONST}VAR p2: TQ3Point3D): Single; C;


{
 *  Q3RationalPoint4D_Distance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RationalPoint4D_Distance({CONST}VAR p1: TQ3RationalPoint4D; {CONST}VAR p2: TQ3RationalPoint4D): Single; C;

{
 *  Q3RationalPoint4D_DistanceSquared()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RationalPoint4D_DistanceSquared({CONST}VAR p1: TQ3RationalPoint4D; {CONST}VAR p2: TQ3RationalPoint4D): Single; C;


{*****************************************************************************
 **                                                                          **
 **                         Point Relative Ratio                             **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Point2D_RRatio()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point2D_RRatio({CONST}VAR p1: TQ3Point2D; {CONST}VAR p2: TQ3Point2D; r1: Single; r2: Single; VAR result: TQ3Point2D): TQ3Point2DPtr; C;

{
 *  Q3Param2D_RRatio()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Param2D_RRatio({CONST}VAR p1: TQ3Param2D; {CONST}VAR p2: TQ3Param2D; r1: Single; r2: Single; VAR result: TQ3Param2D): TQ3Param2DPtr; C;

{
 *  Q3Point3D_RRatio()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point3D_RRatio({CONST}VAR p1: TQ3Point3D; {CONST}VAR p2: TQ3Point3D; r1: Single; r2: Single; VAR result: TQ3Point3D): TQ3Point3DPtr; C;

{
 *  Q3RationalPoint4D_RRatio()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RationalPoint4D_RRatio({CONST}VAR p1: TQ3RationalPoint4D; {CONST}VAR p2: TQ3RationalPoint4D; r1: Single; r2: Single; VAR result: TQ3RationalPoint4D): TQ3RationalPoint4DPtr; C;


{*****************************************************************************
 **                                                                          **
 **                 Point / Vector Addition & Subtraction                    **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Point2D_Vector2D_Add()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point2D_Vector2D_Add({CONST}VAR point2D: TQ3Point2D; {CONST}VAR vector2D: TQ3Vector2D; VAR result: TQ3Point2D): TQ3Point2DPtr; C;

{
 *  Q3Param2D_Vector2D_Add()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Param2D_Vector2D_Add({CONST}VAR param2D: TQ3Param2D; {CONST}VAR vector2D: TQ3Vector2D; VAR result: TQ3Param2D): TQ3Param2DPtr; C;

{
 *  Q3Point3D_Vector3D_Add()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point3D_Vector3D_Add({CONST}VAR point3D: TQ3Point3D; {CONST}VAR vector3D: TQ3Vector3D; VAR result: TQ3Point3D): TQ3Point3DPtr; C;

{
 *  Q3Point2D_Vector2D_Subtract()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point2D_Vector2D_Subtract({CONST}VAR point2D: TQ3Point2D; {CONST}VAR vector2D: TQ3Vector2D; VAR result: TQ3Point2D): TQ3Point2DPtr; C;

{
 *  Q3Param2D_Vector2D_Subtract()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Param2D_Vector2D_Subtract({CONST}VAR param2D: TQ3Param2D; {CONST}VAR vector2D: TQ3Vector2D; VAR result: TQ3Param2D): TQ3Param2DPtr; C;

{
 *  Q3Point3D_Vector3D_Subtract()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point3D_Vector3D_Subtract({CONST}VAR point3D: TQ3Point3D; {CONST}VAR vector3D: TQ3Vector3D; VAR result: TQ3Point3D): TQ3Point3DPtr; C;


{*****************************************************************************
 **                                                                          **
 **                             Vector Scale                                 **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Vector2D_Scale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector2D_Scale({CONST}VAR vector2D: TQ3Vector2D; scalar: Single; VAR result: TQ3Vector2D): TQ3Vector2DPtr; C;

{
 *  Q3Vector3D_Scale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector3D_Scale({CONST}VAR vector3D: TQ3Vector3D; scalar: Single; VAR result: TQ3Vector3D): TQ3Vector3DPtr; C;


{*****************************************************************************
 **                                                                          **
 **                             Vector Length                                **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Vector2D_Length()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector2D_Length({CONST}VAR vector2D: TQ3Vector2D): Single; C;

{
 *  Q3Vector3D_Length()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector3D_Length({CONST}VAR vector3D: TQ3Vector3D): Single; C;


{*****************************************************************************
 **                                                                          **
 **                             Vector Normalize                             **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Vector2D_Normalize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector2D_Normalize({CONST}VAR vector2D: TQ3Vector2D; VAR result: TQ3Vector2D): TQ3Vector2DPtr; C;

{
 *  Q3Vector3D_Normalize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector3D_Normalize({CONST}VAR vector3D: TQ3Vector3D; VAR result: TQ3Vector3D): TQ3Vector3DPtr; C;


{*****************************************************************************
 **                                                                          **
 **                 Vector/Vector Addition and Subtraction                   **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Vector2D_Add()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector2D_Add({CONST}VAR v1: TQ3Vector2D; {CONST}VAR v2: TQ3Vector2D; VAR result: TQ3Vector2D): TQ3Vector2DPtr; C;

{
 *  Q3Vector3D_Add()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector3D_Add({CONST}VAR v1: TQ3Vector3D; {CONST}VAR v2: TQ3Vector3D; VAR result: TQ3Vector3D): TQ3Vector3DPtr; C;


{
 *  Q3Vector2D_Subtract()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector2D_Subtract({CONST}VAR v1: TQ3Vector2D; {CONST}VAR v2: TQ3Vector2D; VAR result: TQ3Vector2D): TQ3Vector2DPtr; C;

{
 *  Q3Vector3D_Subtract()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector3D_Subtract({CONST}VAR v1: TQ3Vector3D; {CONST}VAR v2: TQ3Vector3D; VAR result: TQ3Vector3D): TQ3Vector3DPtr; C;


{*****************************************************************************
 **                                                                          **
 **                             Cross Product                                **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Vector2D_Cross()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector2D_Cross({CONST}VAR v1: TQ3Vector2D; {CONST}VAR v2: TQ3Vector2D): Single; C;

{
 *  Q3Vector3D_Cross()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector3D_Cross({CONST}VAR v1: TQ3Vector3D; {CONST}VAR v2: TQ3Vector3D; VAR result: TQ3Vector3D): TQ3Vector3DPtr; C;

{
 *  Q3Point3D_CrossProductTri()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point3D_CrossProductTri({CONST}VAR point1: TQ3Point3D; {CONST}VAR point2: TQ3Point3D; {CONST}VAR point3: TQ3Point3D; VAR crossVector: TQ3Vector3D): TQ3Vector3DPtr; C;


{*****************************************************************************
 **                                                                          **
 **                             Dot Product                                  **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Vector2D_Dot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector2D_Dot({CONST}VAR v1: TQ3Vector2D; {CONST}VAR v2: TQ3Vector2D): Single; C;

{
 *  Q3Vector3D_Dot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector3D_Dot({CONST}VAR v1: TQ3Vector3D; {CONST}VAR v2: TQ3Vector3D): Single; C;


{*****************************************************************************
 **                                                                          **
 **                     Point and Vector Transformation                      **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Vector2D_Transform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector2D_Transform({CONST}VAR vector2D: TQ3Vector2D; {CONST}VAR matrix3x3: TQ3Matrix3x3; VAR result: TQ3Vector2D): TQ3Vector2DPtr; C;

{
 *  Q3Vector3D_Transform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector3D_Transform({CONST}VAR vector3D: TQ3Vector3D; {CONST}VAR matrix4x4: TQ3Matrix4x4; VAR result: TQ3Vector3D): TQ3Vector3DPtr; C;

{
 *  Q3Point2D_Transform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point2D_Transform({CONST}VAR point2D: TQ3Point2D; {CONST}VAR matrix3x3: TQ3Matrix3x3; VAR result: TQ3Point2D): TQ3Point2DPtr; C;

{
 *  Q3Param2D_Transform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Param2D_Transform({CONST}VAR param2D: TQ3Param2D; {CONST}VAR matrix3x3: TQ3Matrix3x3; VAR result: TQ3Param2D): TQ3Param2DPtr; C;

{
 *  Q3Point3D_Transform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point3D_Transform({CONST}VAR point3D: TQ3Point3D; {CONST}VAR matrix4x4: TQ3Matrix4x4; VAR result: TQ3Point3D): TQ3Point3DPtr; C;

{
 *  Q3RationalPoint4D_Transform()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RationalPoint4D_Transform({CONST}VAR point4D: TQ3RationalPoint4D; {CONST}VAR matrix4x4: TQ3Matrix4x4; VAR result: TQ3RationalPoint4D): TQ3RationalPoint4DPtr; C;

{
 *  Q3Point3D_To3DTransformArray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point3D_To3DTransformArray({CONST}VAR inPoint3D: TQ3Point3D; {CONST}VAR matrix: TQ3Matrix4x4; VAR outPoint3D: TQ3Point3D; numPoints: LONGINT; inStructSize: UInt32; outStructSize: UInt32): TQ3Status; C;

{
 *  Q3Point3D_To4DTransformArray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point3D_To4DTransformArray({CONST}VAR inPoint3D: TQ3Point3D; {CONST}VAR matrix: TQ3Matrix4x4; VAR outPoint4D: TQ3RationalPoint4D; numPoints: LONGINT; inStructSize: UInt32; outStructSize: UInt32): TQ3Status; C;

{
 *  Q3RationalPoint4D_To4DTransformArray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RationalPoint4D_To4DTransformArray({CONST}VAR inPoint4D: TQ3RationalPoint4D; {CONST}VAR matrix: TQ3Matrix4x4; VAR outPoint4D: TQ3RationalPoint4D; numPoints: LONGINT; inStructSize: UInt32; outStructSize: UInt32): TQ3Status; C;


{*****************************************************************************
 **                                                                          **
 **                             Vector Negation                              **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Vector2D_Negate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector2D_Negate({CONST}VAR vector2D: TQ3Vector2D; VAR result: TQ3Vector2D): TQ3Vector2DPtr; C;

{
 *  Q3Vector3D_Negate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector3D_Negate({CONST}VAR vector3D: TQ3Vector3D; VAR result: TQ3Vector3D): TQ3Vector3DPtr; C;


{*****************************************************************************
 **                                                                          **
 **                 Point conversion from cartesian to polar                 **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Point2D_ToPolar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point2D_ToPolar({CONST}VAR point2D: TQ3Point2D; VAR result: TQ3PolarPoint): TQ3PolarPointPtr; C;

{
 *  Q3PolarPoint_ToPoint2D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3PolarPoint_ToPoint2D({CONST}VAR polarPoint: TQ3PolarPoint; VAR result: TQ3Point2D): TQ3Point2DPtr; C;

{
 *  Q3Point3D_ToSpherical()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point3D_ToSpherical({CONST}VAR point3D: TQ3Point3D; VAR result: TQ3SphericalPoint): TQ3SphericalPointPtr; C;

{
 *  Q3SphericalPoint_ToPoint3D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3SphericalPoint_ToPoint3D({CONST}VAR sphericalPoint: TQ3SphericalPoint; VAR result: TQ3Point3D): TQ3Point3DPtr; C;


{*****************************************************************************
 **                                                                          **
 **                         Point Affine Combinations                        **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Point2D_AffineComb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point2D_AffineComb({CONST}VAR points2D: TQ3Point2D; {CONST}VAR weights: Single; nPoints: UInt32; VAR result: TQ3Point2D): TQ3Point2DPtr; C;

{
 *  Q3Param2D_AffineComb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Param2D_AffineComb({CONST}VAR params2D: TQ3Param2D; {CONST}VAR weights: Single; nPoints: UInt32; VAR result: TQ3Param2D): TQ3Param2DPtr; C;

{
 *  Q3RationalPoint3D_AffineComb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RationalPoint3D_AffineComb({CONST}VAR points3D: TQ3RationalPoint3D; {CONST}VAR weights: Single; numPoints: UInt32; VAR result: TQ3RationalPoint3D): TQ3RationalPoint3DPtr; C;

{
 *  Q3Point3D_AffineComb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point3D_AffineComb({CONST}VAR points3D: TQ3Point3D; {CONST}VAR weights: Single; numPoints: UInt32; VAR result: TQ3Point3D): TQ3Point3DPtr; C;

{
 *  Q3RationalPoint4D_AffineComb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3RationalPoint4D_AffineComb({CONST}VAR points4D: TQ3RationalPoint4D; {CONST}VAR weights: Single; numPoints: UInt32; VAR result: TQ3RationalPoint4D): TQ3RationalPoint4DPtr; C;


{*****************************************************************************
 **                                                                          **
 **                             Matrix Functions                             **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Matrix3x3_Copy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix3x3_Copy({CONST}VAR matrix3x3: TQ3Matrix3x3; VAR result: TQ3Matrix3x3): TQ3Matrix3x3Ptr; C;

{
 *  Q3Matrix4x4_Copy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_Copy({CONST}VAR matrix4x4: TQ3Matrix4x4; VAR result: TQ3Matrix4x4): TQ3Matrix4x4Ptr; C;


{
 *  Q3Matrix3x3_SetIdentity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix3x3_SetIdentity(VAR matrix3x3: TQ3Matrix3x3): TQ3Matrix3x3Ptr; C;

{
 *  Q3Matrix4x4_SetIdentity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_SetIdentity(VAR matrix4x4: TQ3Matrix4x4): TQ3Matrix4x4Ptr; C;


{
 *  Q3Matrix3x3_Transpose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix3x3_Transpose({CONST}VAR matrix3x3: TQ3Matrix3x3; VAR result: TQ3Matrix3x3): TQ3Matrix3x3Ptr; C;

{
 *  Q3Matrix4x4_Transpose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_Transpose({CONST}VAR matrix4x4: TQ3Matrix4x4; VAR result: TQ3Matrix4x4): TQ3Matrix4x4Ptr; C;


{
 *  Q3Matrix3x3_Invert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix3x3_Invert({CONST}VAR matrix3x3: TQ3Matrix3x3; VAR result: TQ3Matrix3x3): TQ3Matrix3x3Ptr; C;

{
 *  Q3Matrix4x4_Invert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_Invert({CONST}VAR matrix4x4: TQ3Matrix4x4; VAR result: TQ3Matrix4x4): TQ3Matrix4x4Ptr; C;


{
 *  Q3Matrix3x3_Adjoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix3x3_Adjoint({CONST}VAR matrix3x3: TQ3Matrix3x3; VAR result: TQ3Matrix3x3): TQ3Matrix3x3Ptr; C;


{
 *  Q3Matrix3x3_Multiply()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix3x3_Multiply({CONST}VAR matrixA: TQ3Matrix3x3; {CONST}VAR matrixB: TQ3Matrix3x3; VAR result: TQ3Matrix3x3): TQ3Matrix3x3Ptr; C;

{
 *  Q3Matrix4x4_Multiply()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_Multiply({CONST}VAR matrixA: TQ3Matrix4x4; {CONST}VAR matrixB: TQ3Matrix4x4; VAR result: TQ3Matrix4x4): TQ3Matrix4x4Ptr; C;


{
 *  Q3Matrix3x3_SetTranslate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix3x3_SetTranslate(VAR matrix3x3: TQ3Matrix3x3; xTrans: Single; yTrans: Single): TQ3Matrix3x3Ptr; C;

{
 *  Q3Matrix3x3_SetScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix3x3_SetScale(VAR matrix3x3: TQ3Matrix3x3; xScale: Single; yScale: Single): TQ3Matrix3x3Ptr; C;


{
 *  Q3Matrix3x3_SetRotateAboutPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix3x3_SetRotateAboutPoint(VAR matrix3x3: TQ3Matrix3x3; {CONST}VAR origin: TQ3Point2D; angle: Single): TQ3Matrix3x3Ptr; C;

{
 *  Q3Matrix4x4_SetTranslate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_SetTranslate(VAR matrix4x4: TQ3Matrix4x4; xTrans: Single; yTrans: Single; zTrans: Single): TQ3Matrix4x4Ptr; C;

{
 *  Q3Matrix4x4_SetScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_SetScale(VAR matrix4x4: TQ3Matrix4x4; xScale: Single; yScale: Single; zScale: Single): TQ3Matrix4x4Ptr; C;


{
 *  Q3Matrix4x4_SetRotateAboutPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_SetRotateAboutPoint(VAR matrix4x4: TQ3Matrix4x4; {CONST}VAR origin: TQ3Point3D; xAngle: Single; yAngle: Single; zAngle: Single): TQ3Matrix4x4Ptr; C;

{
 *  Q3Matrix4x4_SetRotateAboutAxis()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_SetRotateAboutAxis(VAR matrix4x4: TQ3Matrix4x4; {CONST}VAR origin: TQ3Point3D; {CONST}VAR orientation: TQ3Vector3D; angle: Single): TQ3Matrix4x4Ptr; C;

{
 *  Q3Matrix4x4_SetRotate_X()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_SetRotate_X(VAR matrix4x4: TQ3Matrix4x4; angle: Single): TQ3Matrix4x4Ptr; C;

{
 *  Q3Matrix4x4_SetRotate_Y()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_SetRotate_Y(VAR matrix4x4: TQ3Matrix4x4; angle: Single): TQ3Matrix4x4Ptr; C;

{
 *  Q3Matrix4x4_SetRotate_Z()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_SetRotate_Z(VAR matrix4x4: TQ3Matrix4x4; angle: Single): TQ3Matrix4x4Ptr; C;

{
 *  Q3Matrix4x4_SetRotate_XYZ()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_SetRotate_XYZ(VAR matrix4x4: TQ3Matrix4x4; xAngle: Single; yAngle: Single; zAngle: Single): TQ3Matrix4x4Ptr; C;

{
 *  Q3Matrix4x4_SetRotateVectorToVector()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_SetRotateVectorToVector(VAR matrix4x4: TQ3Matrix4x4; {CONST}VAR v1: TQ3Vector3D; {CONST}VAR v2: TQ3Vector3D): TQ3Matrix4x4Ptr; C;

{
 *  Q3Matrix4x4_SetQuaternion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_SetQuaternion(VAR matrix: TQ3Matrix4x4; {CONST}VAR quaternion: TQ3Quaternion): TQ3Matrix4x4Ptr; C;

{
 *  Q3Matrix3x3_Determinant()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix3x3_Determinant({CONST}VAR matrix3x3: TQ3Matrix3x3): Single; C;

{
 *  Q3Matrix4x4_Determinant()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Matrix4x4_Determinant({CONST}VAR matrix4x4: TQ3Matrix4x4): Single; C;


{*****************************************************************************
 **                                                                          **
 **                             Quaternion Routines                          **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3Quaternion_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_Set(VAR quaternion: TQ3Quaternion; w: Single; x: Single; y: Single; z: Single): TQ3QuaternionPtr; C;

{
 *  Q3Quaternion_SetIdentity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_SetIdentity(VAR quaternion: TQ3Quaternion): TQ3QuaternionPtr; C;

{
 *  Q3Quaternion_Copy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_Copy({CONST}VAR quaternion: TQ3Quaternion; VAR result: TQ3Quaternion): TQ3QuaternionPtr; C;

{
 *  Q3Quaternion_IsIdentity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_IsIdentity({CONST}VAR quaternion: TQ3Quaternion): TQ3Boolean; C;

{
 *  Q3Quaternion_Invert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_Invert({CONST}VAR quaternion: TQ3Quaternion; VAR result: TQ3Quaternion): TQ3QuaternionPtr; C;

{
 *  Q3Quaternion_Normalize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_Normalize({CONST}VAR quaternion: TQ3Quaternion; VAR result: TQ3Quaternion): TQ3QuaternionPtr; C;

{
 *  Q3Quaternion_Dot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_Dot({CONST}VAR q1: TQ3Quaternion; {CONST}VAR q2: TQ3Quaternion): Single; C;

{
 *  Q3Quaternion_Multiply()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_Multiply({CONST}VAR q1: TQ3Quaternion; {CONST}VAR q2: TQ3Quaternion; VAR result: TQ3Quaternion): TQ3QuaternionPtr; C;

{
 *  Q3Quaternion_SetRotateAboutAxis()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_SetRotateAboutAxis(VAR quaternion: TQ3Quaternion; {CONST}VAR axis: TQ3Vector3D; angle: Single): TQ3QuaternionPtr; C;

{
 *  Q3Quaternion_SetRotate_XYZ()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_SetRotate_XYZ(VAR quaternion: TQ3Quaternion; xAngle: Single; yAngle: Single; zAngle: Single): TQ3QuaternionPtr; C;

{
 *  Q3Quaternion_SetRotate_X()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_SetRotate_X(VAR quaternion: TQ3Quaternion; angle: Single): TQ3QuaternionPtr; C;

{
 *  Q3Quaternion_SetRotate_Y()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_SetRotate_Y(VAR quaternion: TQ3Quaternion; angle: Single): TQ3QuaternionPtr; C;

{
 *  Q3Quaternion_SetRotate_Z()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_SetRotate_Z(VAR quaternion: TQ3Quaternion; angle: Single): TQ3QuaternionPtr; C;


{
 *  Q3Quaternion_SetMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_SetMatrix(VAR quaternion: TQ3Quaternion; {CONST}VAR matrix: TQ3Matrix4x4): TQ3QuaternionPtr; C;

{
 *  Q3Quaternion_SetRotateVectorToVector()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_SetRotateVectorToVector(VAR quaternion: TQ3Quaternion; {CONST}VAR v1: TQ3Vector3D; {CONST}VAR v2: TQ3Vector3D): TQ3QuaternionPtr; C;

{
 *  Q3Quaternion_MatchReflection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_MatchReflection({CONST}VAR q1: TQ3Quaternion; {CONST}VAR q2: TQ3Quaternion; VAR result: TQ3Quaternion): TQ3QuaternionPtr; C;

{
 *  Q3Quaternion_InterpolateFast()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_InterpolateFast({CONST}VAR q1: TQ3Quaternion; {CONST}VAR q2: TQ3Quaternion; t: Single; VAR result: TQ3Quaternion): TQ3QuaternionPtr; C;

{
 *  Q3Quaternion_InterpolateLinear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Quaternion_InterpolateLinear({CONST}VAR q1: TQ3Quaternion; {CONST}VAR q2: TQ3Quaternion; t: Single; VAR result: TQ3Quaternion): TQ3QuaternionPtr; C;

{
 *  Q3Vector3D_TransformQuaternion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Vector3D_TransformQuaternion({CONST}VAR vector3D: TQ3Vector3D; {CONST}VAR quaternion: TQ3Quaternion; VAR result: TQ3Vector3D): TQ3Vector3DPtr; C;

{
 *  Q3Point3D_TransformQuaternion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3Point3D_TransformQuaternion({CONST}VAR point3D: TQ3Point3D; {CONST}VAR quaternion: TQ3Quaternion; VAR result: TQ3Point3D): TQ3Point3DPtr; C;


{*****************************************************************************
 **                                                                          **
 **                             Volume Routines                              **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3BoundingBox_Copy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BoundingBox_Copy({CONST}VAR src: TQ3BoundingBox; VAR dest: TQ3BoundingBox): TQ3BoundingBoxPtr; C;

{
 *  Q3BoundingBox_Union()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BoundingBox_Union({CONST}VAR v1: TQ3BoundingBox; {CONST}VAR v2: TQ3BoundingBox; VAR result: TQ3BoundingBox): TQ3BoundingBoxPtr; C;

{
 *  Q3BoundingBox_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BoundingBox_Set(VAR bBox: TQ3BoundingBox; {CONST}VAR min: TQ3Point3D; {CONST}VAR max: TQ3Point3D; isEmpty: TQ3Boolean): TQ3BoundingBoxPtr; C;

{
 *  Q3BoundingBox_UnionPoint3D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BoundingBox_UnionPoint3D({CONST}VAR bBox: TQ3BoundingBox; {CONST}VAR point3D: TQ3Point3D; VAR result: TQ3BoundingBox): TQ3BoundingBoxPtr; C;

{
 *  Q3BoundingBox_UnionRationalPoint4D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BoundingBox_UnionRationalPoint4D({CONST}VAR bBox: TQ3BoundingBox; {CONST}VAR point4D: TQ3RationalPoint4D; VAR result: TQ3BoundingBox): TQ3BoundingBoxPtr; C;

{
 *  Q3BoundingBox_SetFromPoints3D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BoundingBox_SetFromPoints3D(VAR bBox: TQ3BoundingBox; {CONST}VAR points3D: TQ3Point3D; numPoints: UInt32; structSize: UInt32): TQ3BoundingBoxPtr; C;

{
 *  Q3BoundingBox_SetFromRationalPoints4D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BoundingBox_SetFromRationalPoints4D(VAR bBox: TQ3BoundingBox; {CONST}VAR points4D: TQ3RationalPoint4D; numPoints: UInt32; structSize: UInt32): TQ3BoundingBoxPtr; C;


{*****************************************************************************
 **                                                                          **
 **                             Sphere Routines                              **
 **                                                                          **
 ****************************************************************************}
{
 *  Q3BoundingSphere_Copy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BoundingSphere_Copy({CONST}VAR src: TQ3BoundingSphere; VAR dest: TQ3BoundingSphere): TQ3BoundingSpherePtr; C;

{
 *  Q3BoundingSphere_Union()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BoundingSphere_Union({CONST}VAR s1: TQ3BoundingSphere; {CONST}VAR s2: TQ3BoundingSphere; VAR result: TQ3BoundingSphere): TQ3BoundingSpherePtr; C;

{
 *  Q3BoundingSphere_Set()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BoundingSphere_Set(VAR bSphere: TQ3BoundingSphere; {CONST}VAR origin: TQ3Point3D; radius: Single; isEmpty: TQ3Boolean): TQ3BoundingSpherePtr; C;

{
 *  Q3BoundingSphere_UnionPoint3D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BoundingSphere_UnionPoint3D({CONST}VAR bSphere: TQ3BoundingSphere; {CONST}VAR point3D: TQ3Point3D; VAR result: TQ3BoundingSphere): TQ3BoundingSpherePtr; C;

{
 *  Q3BoundingSphere_UnionRationalPoint4D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BoundingSphere_UnionRationalPoint4D({CONST}VAR bSphere: TQ3BoundingSphere; {CONST}VAR point4D: TQ3RationalPoint4D; VAR result: TQ3BoundingSphere): TQ3BoundingSpherePtr; C;


{
 *  Q3BoundingSphere_SetFromPoints3D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BoundingSphere_SetFromPoints3D(VAR bSphere: TQ3BoundingSphere; {CONST}VAR points3D: TQ3Point3D; numPoints: UInt32; structSize: UInt32): TQ3BoundingSpherePtr; C;

{
 *  Q3BoundingSphere_SetFromRationalPoints4D()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Q3BoundingSphere_SetFromRationalPoints4D(VAR bSphere: TQ3BoundingSphere; {CONST}VAR points4D: TQ3RationalPoint4D; numPoints: UInt32; structSize: UInt32): TQ3BoundingSpherePtr; C;




{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QD3DMathIncludes}

{$ENDC} {__QD3DMATH__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

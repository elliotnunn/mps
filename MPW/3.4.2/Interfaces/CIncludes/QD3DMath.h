/******************************************************************************
 **																			 **
 ** 	Module:		QD3DMath.h												 **
 ** 																		 **
 ** 																		 **
 ** 																		 **
 ** 	Purpose: 	Math & matrix routines and definitions.					 **
 ** 																		 **
 ** 																		 **
 ** 	Copyright (C) 1992-1995 Apple Computer, Inc.  All rights reserved.	 **
 ** 																		 **
 ** 																		 ** 
 *****************************************************************************/
#ifndef QD3DMath_h
#define QD3DMath_h

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

#include <math.h>
#include <float.h>

#ifdef __cplusplus
extern "C" {
#endif	/* __cplusplus */

/******************************************************************************
 **																			 **
 **							Constant Definitions							 **
 **																			 **
 *****************************************************************************/
/*
 *  Real zero definition
 */
#ifdef FLT_EPSILON
#	define kQ3RealZero			(FLT_EPSILON)
#else
#	define kQ3RealZero			((float)1.19209290e-07)			
#endif  /*  FLT_EPSILON  */

#ifdef FLT_MAX
#	define	kQ3MaxFloat			(FLT_MAX)
#else
#	define	kQ3MaxFloat			((float)3.40282347e+38)
#endif  /*  FLT_MAX  */

/*
 *  Values of PI
 */
#define kQ3Pi 					((float)3.1415926535898)
#define kQ32Pi 					((float)(2.0 * 3.1415926535898))
#define kQ3PiOver2				((float)(3.1415926535898 / 2.0))
#define kQ33PiOver2				((float)(3.0 * 3.1415926535898 / 2.0))


/******************************************************************************
 **																			 **
 **							Miscellaneous Functions							 **
 **																			 **
 *****************************************************************************/
 
#define Q3Math_DegreesToRadians(x)	((float)((x) *  kQ3Pi / 180.0))
#define Q3Math_RadiansToDegrees(x)	((float)((x) * 180.0 / kQ3Pi))

#define Q3Math_Min(x,y)				((x) <= (y) ? (x) : (y))
#define Q3Math_Max(x,y)				((x) >= (y) ? (x) : (y))

		
/******************************************************************************
 **																			 **
 **							Point and Vector Creation						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Point2D *Q3Point2D_Set(
	TQ3Point2D					*point2D,
	float						x, 
	float						y);

QD3D_EXPORT TQ3Param2D *Q3Param2D_Set(
	TQ3Param2D					*param2D,
	float						u, 
	float						v);

QD3D_EXPORT TQ3Point3D *Q3Point3D_Set(
	TQ3Point3D					*point3D,
	float						x, 
	float						y, 
	float						z);

QD3D_EXPORT TQ3RationalPoint3D *Q3RationalPoint3D_Set(
	TQ3RationalPoint3D			*point3D,
	float						x, 
	float						y, 
	float						w);
	
QD3D_EXPORT TQ3RationalPoint4D *Q3RationalPoint4D_Set(
	TQ3RationalPoint4D			*point4D,
	float						x,
	float						y,
	float						z, 
	float						w);
	
QD3D_EXPORT TQ3Vector2D *Q3Vector2D_Set(
	TQ3Vector2D					*vector2D,
	float						x, 
	float						y);

QD3D_EXPORT TQ3Vector3D *Q3Vector3D_Set(
	TQ3Vector3D					*vector3D,
	float						x, 
	float						y, 
	float						z);

QD3D_EXPORT TQ3PolarPoint *Q3PolarPoint_Set(
	TQ3PolarPoint				*polarPoint,
	float						r,
	float						theta);

QD3D_EXPORT TQ3SphericalPoint *Q3SphericalPoint_Set(
	TQ3SphericalPoint			*sphericalPoint,
	float						rho,
	float						theta,
	float						phi);
	
	
/******************************************************************************
 **																			 **
 **					Point and Vector Dimension Conversion					 **
 **																			 **
 *****************************************************************************/
 
QD3D_EXPORT TQ3Point3D *Q3Point2D_To3D(
	const TQ3Point2D			*point2D,
	TQ3Point3D					*result);

QD3D_EXPORT TQ3Point2D *Q3RationalPoint3D_To2D(
	const TQ3RationalPoint3D	*point3D,
	TQ3Point2D					*result);
	
QD3D_EXPORT TQ3RationalPoint4D *Q3Point3D_To4D(
	const TQ3Point3D			*point3D,
	TQ3RationalPoint4D			*result);

QD3D_EXPORT TQ3Point3D *Q3RationalPoint4D_To3D(
	const TQ3RationalPoint4D	*point4D,
	TQ3Point3D					*result);

QD3D_EXPORT TQ3Vector3D *Q3Vector2D_To3D(
	const TQ3Vector2D			*vector2D,
	TQ3Vector3D					*result);
	
QD3D_EXPORT TQ3Vector2D *Q3Vector3D_To2D(
	const TQ3Vector3D			*vector3D,
	TQ3Vector2D					*result);

	
/******************************************************************************
 **																			 **
 **							Point Subtraction								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Vector2D *Q3Point2D_Subtract(
	const TQ3Point2D			*p1, 
	const TQ3Point2D			*p2,
	TQ3Vector2D					*result);

QD3D_EXPORT TQ3Vector2D *Q3Param2D_Subtract(
	const TQ3Param2D			*p1, 
	const TQ3Param2D			*p2,
	TQ3Vector2D					*result);

QD3D_EXPORT TQ3Vector3D *Q3Point3D_Subtract(
	const TQ3Point3D			*p1, 
	const TQ3Point3D			*p2,
	TQ3Vector3D					*result);
	
	
/******************************************************************************
 **																			 **
 **							Point Distance									 **
 **																			 **
 *****************************************************************************/
	
QD3D_EXPORT float Q3Point2D_Distance(
	const TQ3Point2D			*p1, 
	const TQ3Point2D			*p2);

QD3D_EXPORT float Q3Point2D_DistanceSquared(
	const TQ3Point2D			*p1, 
	const TQ3Point2D			*p2);


QD3D_EXPORT float Q3Param2D_Distance(
	const TQ3Param2D			*p1, 
	const TQ3Param2D			*p2);

QD3D_EXPORT float Q3Param2D_DistanceSquared(
	const TQ3Param2D			*p1, 
	const TQ3Param2D			*p2);
	
	
QD3D_EXPORT float Q3RationalPoint3D_Distance(
	const TQ3RationalPoint3D	*p1, 
	const TQ3RationalPoint3D	*p2);
	
QD3D_EXPORT float Q3RationalPoint3D_DistanceSquared(
	const TQ3RationalPoint3D	*p1, 
	const TQ3RationalPoint3D	*p2);


QD3D_EXPORT float Q3Point3D_Distance(
	const TQ3Point3D			*p1, 
	const TQ3Point3D			*p2);

QD3D_EXPORT float Q3Point3D_DistanceSquared(
	const TQ3Point3D			*p1, 
	const TQ3Point3D			*p2);


QD3D_EXPORT float Q3RationalPoint4D_Distance(
	const TQ3RationalPoint4D	*p1, 
	const TQ3RationalPoint4D	*p2);

QD3D_EXPORT float Q3RationalPoint4D_DistanceSquared(
	const TQ3RationalPoint4D	*p1, 
	const TQ3RationalPoint4D	*p2);


/******************************************************************************
 **																			 **
 **							Point Relative Ratio							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Point2D *Q3Point2D_RRatio(
	const TQ3Point2D			*p1,
	const TQ3Point2D			*p2,
	float						r1,
	float						r2,
	TQ3Point2D					*result);

QD3D_EXPORT TQ3Param2D *Q3Param2D_RRatio(
	const TQ3Param2D			*p1,
	const TQ3Param2D			*p2,
	float						r1,
	float						r2,
	TQ3Param2D					*result);

QD3D_EXPORT TQ3Point3D *Q3Point3D_RRatio(
	const TQ3Point3D			*p1,
	const TQ3Point3D			*p2,
	float						r1,
	float						r2,
	TQ3Point3D					*result);

QD3D_EXPORT TQ3RationalPoint4D *Q3RationalPoint4D_RRatio(
	const TQ3RationalPoint4D	*p1,
	const TQ3RationalPoint4D	*p2,
	float						r1,
	float						r2,
	TQ3RationalPoint4D			*result);
						
						
/******************************************************************************
 **																			 **
 **					Point / Vector Addition	& Subtraction					 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Point2D *Q3Point2D_Vector2D_Add(
	const TQ3Point2D			*point2D, 
	const TQ3Vector2D			*vector2D,
	TQ3Point2D					*result);

QD3D_EXPORT TQ3Param2D *Q3Param2D_Vector2D_Add(
	const TQ3Param2D			*param2D, 
	const TQ3Vector2D			*vector2D,
	TQ3Param2D					*result);

QD3D_EXPORT TQ3Point3D *Q3Point3D_Vector3D_Add(
	const TQ3Point3D			*point3D, 
	const TQ3Vector3D			*vector3D,
	TQ3Point3D					*result);

QD3D_EXPORT TQ3Point2D *Q3Point2D_Vector2D_Subtract(
	const TQ3Point2D			*point2D, 
	const TQ3Vector2D			*vector2D,
	TQ3Point2D					*result);

QD3D_EXPORT TQ3Param2D *Q3Param2D_Vector2D_Subtract(
	const TQ3Param2D			*param2D, 
	const TQ3Vector2D			*vector2D,
	TQ3Param2D					*result);

QD3D_EXPORT TQ3Point3D *Q3Point3D_Vector3D_Subtract(
	const TQ3Point3D			*point3D, 
	const TQ3Vector3D			*vector3D,
	TQ3Point3D					*result);


/******************************************************************************
 **																			 **
 **								Vector Scale								 **
 **																			 **
 *****************************************************************************/
						
QD3D_EXPORT TQ3Vector2D *Q3Vector2D_Scale(
	const TQ3Vector2D			*vector2D, 
	float						scalar,
	TQ3Vector2D					*result);

QD3D_EXPORT TQ3Vector3D *Q3Vector3D_Scale(
	const TQ3Vector3D			*vector3D, 
	float						scalar,
	TQ3Vector3D					*result);

	
/******************************************************************************
 **																			 **
 **								Vector Length								 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT float Q3Vector2D_Length(
	const TQ3Vector2D 			*vector2D);

QD3D_EXPORT float Q3Vector3D_Length(
	const TQ3Vector3D			*vector3D);

	
/******************************************************************************
 **																			 **
 **								Vector Normalize							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Vector2D *Q3Vector2D_Normalize(
	const TQ3Vector2D			*vector2D,
	TQ3Vector2D					*result);

QD3D_EXPORT TQ3Vector3D *Q3Vector3D_Normalize(
	const TQ3Vector3D			*vector3D,
	TQ3Vector3D					*result);


/******************************************************************************
 **																			 **
 **					Vector/Vector Addition and Subtraction					 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Vector2D *Q3Vector2D_Add(
	const TQ3Vector2D			*v1, 
	const TQ3Vector2D			*v2,
	TQ3Vector2D					*result);

QD3D_EXPORT TQ3Vector3D *Q3Vector3D_Add(
	const TQ3Vector3D			*v1, 
	const TQ3Vector3D			*v2, 
	TQ3Vector3D					*result);


QD3D_EXPORT TQ3Vector2D *Q3Vector2D_Subtract(
	const TQ3Vector2D			*v1, 
	const TQ3Vector2D			*v2, 
	TQ3Vector2D					*result);

QD3D_EXPORT TQ3Vector3D *Q3Vector3D_Subtract(
	const TQ3Vector3D			*v1, 
	const TQ3Vector3D			*v2,
	TQ3Vector3D					*result);


/******************************************************************************
 **																			 **
 **								Cross Product								 **
 **																			 **
 *****************************************************************************/
 
QD3D_EXPORT float Q3Vector2D_Cross(
	const TQ3Vector2D			*v1, 
	const TQ3Vector2D			*v2);

QD3D_EXPORT TQ3Vector3D *Q3Vector3D_Cross(
	const TQ3Vector3D			*v1, 
	const TQ3Vector3D			*v2,
	TQ3Vector3D					*result);
	
QD3D_EXPORT TQ3Vector3D *Q3Point3D_CrossProductTri(
	const TQ3Point3D 			*point1, 
	const TQ3Point3D 			*point2, 
	const TQ3Point3D 			*point3, 
	TQ3Vector3D 				*crossVector);


/******************************************************************************
 **																			 **
 **								Dot Product									 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT float Q3Vector2D_Dot(
	const TQ3Vector2D			*v1, 
	const TQ3Vector2D			*v2);

QD3D_EXPORT float Q3Vector3D_Dot(
	const TQ3Vector3D			*v1, 
	const TQ3Vector3D			*v2);


/******************************************************************************
 **																			 **
 **						Point and Vector Transformation						 **
 **																			 **
 *****************************************************************************/
 
QD3D_EXPORT TQ3Vector2D *Q3Vector2D_Transform(
	const TQ3Vector2D			*vector2D,
	const TQ3Matrix3x3		 	*matrix3x3,
	TQ3Vector2D					*result);
	
QD3D_EXPORT TQ3Vector3D *Q3Vector3D_Transform(
	const TQ3Vector3D			*vector3D,
	const TQ3Matrix4x4			*matrix4x4,
	TQ3Vector3D					*result);

QD3D_EXPORT TQ3Point2D *Q3Point2D_Transform(
	const TQ3Point2D 			*point2D,
	const TQ3Matrix3x3			*matrix3x3,
	TQ3Point2D					*result);

QD3D_EXPORT TQ3Param2D *Q3Param2D_Transform(
	const TQ3Param2D 			*param2D,
	const TQ3Matrix3x3			*matrix3x3,
	TQ3Param2D					*result);

QD3D_EXPORT TQ3Point3D *Q3Point3D_Transform(
	const TQ3Point3D			*point3D,
	const TQ3Matrix4x4			*matrix4x4,
	TQ3Point3D					*result);

QD3D_EXPORT TQ3RationalPoint4D *Q3RationalPoint4D_Transform(
	const TQ3RationalPoint4D	*point4D, 
	const TQ3Matrix4x4			*matrix4x4,
	TQ3RationalPoint4D			*result);
	
QD3D_EXPORT TQ3Status Q3Point3D_To3DTransformArray(
	const TQ3Point3D 			*inVertex, 
	const TQ3Matrix4x4 			*matrix,
	TQ3Point3D 					*outVertex,  
	long 						numVertices, 
	unsigned long 				inStructSize, 
	unsigned long 				outStructSize);
	
QD3D_EXPORT TQ3Status Q3Point3D_To4DTransformArray(
	const TQ3Point3D 			*inVertex, 
	const TQ3Matrix4x4	 		*matrix,
	TQ3RationalPoint4D 			*outVertex,  
	long 						numVertices,
	unsigned long 				inStructSize, 
	unsigned long 				outStructSize);
	
QD3D_EXPORT TQ3Status Q3RationalPoint4D_To4DTransformArray(
	const TQ3RationalPoint4D 	*inVertex, 
	const TQ3Matrix4x4 			*matrix,
	TQ3RationalPoint4D 			*outVertex,  
	long 						numVertices, 
	unsigned long 				inStructSize, 
	unsigned long 				outStructSize);


/******************************************************************************
 **																			 **
 **								Vector Negation								 **
 **																			 **
 *****************************************************************************/
 
QD3D_EXPORT TQ3Vector2D *Q3Vector2D_Negate(
	const TQ3Vector2D			*vector2D,
	TQ3Vector2D					*result);

QD3D_EXPORT TQ3Vector3D *Q3Vector3D_Negate(
	const TQ3Vector3D			*vector3D,
	TQ3Vector3D					*result);


/******************************************************************************
 **																			 **
 **					Point conversion from cartesian to polar				 **
 **																			 **
 *****************************************************************************/
 
QD3D_EXPORT TQ3PolarPoint *Q3Point2D_ToPolar(
	const TQ3Point2D			*point2D,
	TQ3PolarPoint				*result);
	
QD3D_EXPORT TQ3Point2D *Q3PolarPoint_ToPoint2D(
	const TQ3PolarPoint			*polarPoint,
	TQ3Point2D					*result);
	
QD3D_EXPORT TQ3SphericalPoint *Q3Point3D_ToSpherical(
	const TQ3Point3D			*point3D,
	TQ3SphericalPoint			*result);
	
QD3D_EXPORT TQ3Point3D *Q3SphericalPoint_ToPoint3D(
	const TQ3SphericalPoint		*sphericalPoint,
	TQ3Point3D					*result);


/******************************************************************************
 **																			 **
 **							Point Affine Combinations						 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Point2D *Q3Point2D_AffineComb(
	const TQ3Point2D			*points2D,
	const float					*weights,
	unsigned long				nPoints, 
	TQ3Point2D					*result);

QD3D_EXPORT TQ3Param2D *Q3Param2D_AffineComb(
	const TQ3Param2D			*param2Ds,
	const float					*weights,
	unsigned long				nPoints, 
	TQ3Param2D					*result);

QD3D_EXPORT TQ3RationalPoint3D *Q3RationalPoint3D_AffineComb(
	const TQ3RationalPoint3D	*points3D,
	const float					*weights,
	unsigned long				nPoints, 
	TQ3RationalPoint3D			*result);
	
QD3D_EXPORT TQ3Point3D *Q3Point3D_AffineComb(
	const TQ3Point3D			*points3D,
	const float					*weights,
	unsigned long				nPoints, 
	TQ3Point3D					*result);

QD3D_EXPORT TQ3RationalPoint4D *Q3RationalPoint4D_AffineComb(
	const TQ3RationalPoint4D	*points4D,
	const float					*weights,
	unsigned long				nPoints, 
	TQ3RationalPoint4D			*result);
	
	
/******************************************************************************
 **																			 **
 **								Matrix Functions							 **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Matrix3x3 *Q3Matrix3x3_Copy(
	const TQ3Matrix3x3			*matrix3x3,
	TQ3Matrix3x3				*result);
	
QD3D_EXPORT TQ3Matrix4x4 *Q3Matrix4x4_Copy(
	const TQ3Matrix4x4			*matrix4x4,
	TQ3Matrix4x4				*result);


QD3D_EXPORT TQ3Matrix3x3 *Q3Matrix3x3_SetIdentity(
	TQ3Matrix3x3				*matrix3x3);

QD3D_EXPORT TQ3Matrix4x4 *Q3Matrix4x4_SetIdentity(
	TQ3Matrix4x4				*matrix4x4);


QD3D_EXPORT TQ3Matrix3x3 *Q3Matrix3x3_Transpose(
	const TQ3Matrix3x3			*matrix3x3,
	TQ3Matrix3x3				*result);

QD3D_EXPORT TQ3Matrix4x4 *Q3Matrix4x4_Transpose(
	const TQ3Matrix4x4			*matrix4x4,
	TQ3Matrix4x4				*result);


QD3D_EXPORT TQ3Matrix3x3 *Q3Matrix3x3_Invert(
	const TQ3Matrix3x3			*matrix3x3,
	TQ3Matrix3x3				*result);

QD3D_EXPORT TQ3Matrix4x4 *Q3Matrix4x4_Invert(
	const TQ3Matrix4x4			*matrix4x4,
	TQ3Matrix4x4				*result);
	
	
QD3D_EXPORT TQ3Matrix3x3 *Q3Matrix3x3_Adjoint(
	const TQ3Matrix3x3			*matrix3x3,
	TQ3Matrix3x3				*result);


QD3D_EXPORT TQ3Matrix3x3 *Q3Matrix3x3_Multiply(
	const TQ3Matrix3x3			*matrixA,
	const TQ3Matrix3x3			*matrixB,
	TQ3Matrix3x3				*result);

QD3D_EXPORT TQ3Matrix4x4 *Q3Matrix4x4_Multiply(
	const TQ3Matrix4x4			*matrixA,
	const TQ3Matrix4x4			*matrixB,
	TQ3Matrix4x4				*result);


QD3D_EXPORT TQ3Matrix3x3 *Q3Matrix3x3_SetTranslate(
	TQ3Matrix3x3				*matrix3x3,	
	float						xTrans,
	float						yTrans);

QD3D_EXPORT TQ3Matrix3x3 *Q3Matrix3x3_SetScale(
	TQ3Matrix3x3				*matrix3x3,
	float						xScale,
	float						yScale);


QD3D_EXPORT TQ3Matrix3x3 *Q3Matrix3x3_SetRotateAboutPoint(
	TQ3Matrix3x3				*matrix3x3,
	const TQ3Point2D			*origin,
	float						angle);

QD3D_EXPORT TQ3Matrix4x4 *Q3Matrix4x4_SetTranslate(
	TQ3Matrix4x4				*matrix4x4,
	float						xTrans,
	float						yTrans,
	float						zTrans);

QD3D_EXPORT TQ3Matrix4x4 *Q3Matrix4x4_SetScale(
	TQ3Matrix4x4				*matrix4x4,
	float						xScale,
	float						yScale,
	float						zScale);


QD3D_EXPORT TQ3Matrix4x4 *Q3Matrix4x4_SetRotateAboutPoint(
	TQ3Matrix4x4				*matrix4x4,
	const TQ3Point3D			*origin,
	float						xAngle,
	float						yAngle,
	float						zAngle);
	
QD3D_EXPORT TQ3Matrix4x4 *Q3Matrix4x4_SetRotateAboutAxis(
	TQ3Matrix4x4				*matrix4x4,
	const TQ3Point3D			*origin,
	const TQ3Vector3D			*orientation,   
	float						angle);	
	
QD3D_EXPORT TQ3Matrix4x4 *Q3Matrix4x4_SetRotate_X(
	TQ3Matrix4x4				*matrix4x4,
	float						angle);
	
QD3D_EXPORT TQ3Matrix4x4 *Q3Matrix4x4_SetRotate_Y(
	TQ3Matrix4x4				*matrix4x4,
	float						angle);

QD3D_EXPORT TQ3Matrix4x4 *Q3Matrix4x4_SetRotate_Z(
	TQ3Matrix4x4				*matrix4x4,
	float						angle);
		
QD3D_EXPORT TQ3Matrix4x4 *Q3Matrix4x4_SetRotate_XYZ(
	TQ3Matrix4x4				*matrix4x4,
	float						xAngle,
	float						yAngle,
	float						zAngle);							
							
QD3D_EXPORT TQ3Matrix4x4 *Q3Matrix4x4_SetRotateVectorToVector(
	TQ3Matrix4x4				*matrix4x4,
	const TQ3Vector3D			*v1,
	const TQ3Vector3D			*v2);

QD3D_EXPORT TQ3Matrix4x4 *Q3Matrix4x4_SetQuaternion(
	TQ3Matrix4x4 				*matrix, 
	const TQ3Quaternion 		*quaternion);

QD3D_EXPORT float Q3Matrix3x3_Determinant(
	const TQ3Matrix3x3			*matrix3x3);

QD3D_EXPORT float Q3Matrix4x4_Determinant(
	const TQ3Matrix4x4			*matrix4x4);
	
	
/******************************************************************************
 **																			 **
 **								Quaternion Routines						     **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3Quaternion *Q3Quaternion_Set(
	TQ3Quaternion				*quaternion,
	float						w,
	float						x,
	float						y,
	float						z);
	
QD3D_EXPORT TQ3Quaternion *Q3Quaternion_SetIdentity(
	TQ3Quaternion				*quaternion);
	
QD3D_EXPORT TQ3Quaternion *Q3Quaternion_Copy(
	const TQ3Quaternion			*quaternion, 
	TQ3Quaternion 				*result);

QD3D_EXPORT TQ3Boolean Q3Quaternion_IsIdentity(
	const TQ3Quaternion			*quaternion);

QD3D_EXPORT TQ3Quaternion *Q3Quaternion_Invert(
	const TQ3Quaternion 		*quaternion,
	TQ3Quaternion				*result);

QD3D_EXPORT TQ3Quaternion *Q3Quaternion_Normalize(
	const TQ3Quaternion			*quaternion,
	TQ3Quaternion				*result);

QD3D_EXPORT float Q3Quaternion_Dot(
	const TQ3Quaternion 		*q1, 
	const TQ3Quaternion 		*q2);

QD3D_EXPORT TQ3Quaternion *Q3Quaternion_Multiply(
	const TQ3Quaternion			*q1, 
	const TQ3Quaternion			*q2,
	TQ3Quaternion				*result);

QD3D_EXPORT TQ3Quaternion *Q3Quaternion_SetRotateAboutAxis(
	TQ3Quaternion 				*quaternion, 
	const TQ3Vector3D 			*axis, 
	float 						angle);
	
QD3D_EXPORT TQ3Quaternion *Q3Quaternion_SetRotateXYZ(
	TQ3Quaternion 				*quaternion, 
	float 						xAngle, 
	float 						yAngle, 
	float 						zAngle);
	
QD3D_EXPORT TQ3Quaternion *Q3Quaternion_SetRotateX(
	TQ3Quaternion 				*quaternion, 
	float 						angle);

QD3D_EXPORT TQ3Quaternion *Q3Quaternion_SetRotateY(
	TQ3Quaternion 				*quaternion, 
	float 						angle);

QD3D_EXPORT TQ3Quaternion *Q3Quaternion_SetRotateZ(
	TQ3Quaternion 				*quaternion, 
	float 						angle);

QD3D_EXPORT TQ3Quaternion *Q3Quaternion_SetMatrix(
	TQ3Quaternion 				*quaternion, 
	const TQ3Matrix4x4 			*matrix);

QD3D_EXPORT TQ3Quaternion *Q3Quaternion_SetRotateVectorToVector(
	TQ3Quaternion 				*quaternion, 
	const TQ3Vector3D 			*v1, 
	const TQ3Vector3D 			*v2);

QD3D_EXPORT TQ3Quaternion *Q3Quaternion_MatchReflection(
	const TQ3Quaternion			*q1, 
	const TQ3Quaternion 		*q2,
	TQ3Quaternion				*result);

QD3D_EXPORT TQ3Quaternion *Q3Quaternion_InterpolateFast(
	const TQ3Quaternion 		*q1, 
	const TQ3Quaternion 		*q2, 
	float 						t,
	TQ3Quaternion				*result);

QD3D_EXPORT TQ3Quaternion *Q3Quaternion_InterpolateLinear(
	const TQ3Quaternion 		*q1, 
	const TQ3Quaternion 		*q2, 
	float 						t,
	TQ3Quaternion 				*result);

QD3D_EXPORT TQ3Vector3D *Q3Vector3D_TransformQuaternion(
	const TQ3Vector3D 			*vector, 
	const TQ3Quaternion 		*quaternion,
	TQ3Vector3D					*result);

QD3D_EXPORT TQ3Point3D *Q3Point3D_TransformQuaternion(
	const TQ3Point3D 			*vector, 
	const TQ3Quaternion 		*quaternion,
	TQ3Point3D					*result);


/******************************************************************************
 **																			 **
 **								Volume Routines							     **
 **																			 **
 *****************************************************************************/

QD3D_EXPORT TQ3BoundingBox *Q3BoundingBox_Copy(
	const TQ3BoundingBox 		*src, 
	TQ3BoundingBox 				*dest);
	
QD3D_EXPORT TQ3BoundingBox *Q3BoundingBox_Union(
	const TQ3BoundingBox 		*v1, 
	const TQ3BoundingBox 		*v2,
	TQ3BoundingBox				*result);
	
QD3D_EXPORT TQ3BoundingBox *Q3BoundingBox_Set(
	TQ3BoundingBox 				*bBox,
	const TQ3Point3D 			*min, 
	const TQ3Point3D 			*max,
	TQ3Boolean					isEmpty);
	
QD3D_EXPORT TQ3BoundingBox *Q3BoundingBox_UnionPoint3D(
	const TQ3BoundingBox 		*bBox,
	const TQ3Point3D 			*pt3D,
	TQ3BoundingBox				*result);
	
QD3D_EXPORT TQ3BoundingBox *Q3BoundingBox_UnionRationalPoint4D(
	const TQ3BoundingBox 		*bBox,
	const TQ3RationalPoint4D 	*pt4D, 
	TQ3BoundingBox 				*result);

QD3D_EXPORT TQ3BoundingBox *Q3BoundingBox_SetFromPoints3D(
	TQ3BoundingBox 				*bBox, 
	const TQ3Point3D 			*pts, 
	unsigned long 				nPts,
	unsigned long				structSize);
	
QD3D_EXPORT TQ3BoundingBox *Q3BoundingBox_SetFromRationalPoints4D(
	TQ3BoundingBox 				*bBox, 
	const TQ3RationalPoint4D 	*pts, 
	unsigned long 				nPts,
	unsigned long				structSize);


/******************************************************************************
 **																			 **
 **								Sphere Routines							     **
 **																			 **
 *****************************************************************************/
 
QD3D_EXPORT TQ3BoundingSphere *Q3BoundingSphere_Copy(
	const TQ3BoundingSphere 	*src, 
	TQ3BoundingSphere 			*dest);
	
QD3D_EXPORT TQ3BoundingSphere *Q3BoundingSphere_Union(
	const TQ3BoundingSphere 	*s1, 
	const TQ3BoundingSphere 	*s2,
	TQ3BoundingSphere			*result);

QD3D_EXPORT TQ3BoundingSphere *Q3BoundingSphere_Set(
	TQ3BoundingSphere 			*bSphere,
	const TQ3Point3D 			*origin, 
	float						radius,
	TQ3Boolean					isEmpty);
	
QD3D_EXPORT TQ3BoundingSphere *Q3BoundingSphere_UnionPoint3D(
	const TQ3BoundingSphere 	*bSphere,
	const TQ3Point3D 			*pt3D,
	TQ3BoundingSphere			*result);
	
QD3D_EXPORT TQ3BoundingSphere *Q3BoundingSphere_UnionRationalPoint4D(
	const TQ3BoundingSphere 	*bSphere,
	const TQ3RationalPoint4D 	*pt4D, 
	TQ3BoundingSphere 			*result);

	
QD3D_EXPORT TQ3BoundingSphere *Q3BoundingSphere_SetFromPoints3D(
	TQ3BoundingSphere 			*bSphere, 
	const TQ3Point3D 			*pts, 
	unsigned long 				nPts,
	unsigned long				structSize);
	
QD3D_EXPORT TQ3BoundingSphere *Q3BoundingSphere_SetFromRationalPoints4D(
	TQ3BoundingSphere 			*bSphere, 
	const TQ3RationalPoint4D 	*pts, 
	unsigned long 				nPts,
	unsigned long				structSize);	


#ifdef __cplusplus
}
#endif	/* __cplusplus */

#if defined(__MWERKS__)
#pragma options align=reset
#pragma enumsalwaysint reset
#endif

#endif  /*  QD3DMath_h  */

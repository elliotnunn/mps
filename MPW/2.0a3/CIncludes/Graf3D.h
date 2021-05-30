/*
	Graf3D.h -- Graf3D

	version	2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/


#ifndef __GRAF3D__
#define __GRAF3D__
#ifndef __TYPES__
#include <QuickDraw.h>
#endif

#define radConst 3754936

typedef struct Point3D {
	Fixed x,y,z;
} Point3D;
typedef struct Point2D {
	Fixed x,y;
} Point2D;
typedef Fixed XfMatrix[4][4];
typedef struct Port3D {
	GrafPtr grPort;
	Rect viewRect;
	Fixed xLeft,yTop,xRight,yBottom;
	Point3D pen,penPrime,eye;
	Fixed hSize,vSize;
	Fixed hCenter,vCenter;
	Fixed xCotan,yCotan;
	char filler;
	char ident;
	XfMatrix xForm;
} Port3D,*Port3DPtr;

pascal void InitGrf3D(port)
	Port3DPtr *port;
	extern;
pascal void Open3DPort(port)
	Port3DPtr port;
	extern;
pascal void SetPort3D(port)
	Port3DPtr port;
	extern;
pascal void GetPort3D(port)
	Port3DPtr port;
	extern;
pascal void MoveTo2D(x,y)
	Fixed x,y;
	extern;
pascal void MoveTo3D(x,y,z)
	Fixed x,y,z;
	extern;
pascal void LineTo2D(x,y)
	Fixed x,y;
	extern;
pascal void LineTo3D(x,y,z)
	Fixed x,y,z;
	extern;
pascal void Move2D(x,y)
	Fixed x,y;
	extern;
pascal void Move3D(x,y,z)
	Fixed x,y,z;
	extern;
pascal void Line2D(x,y)
	Fixed x,y;
	extern;
pascal void Line3D(x,y,z)
	Fixed x,y,z;
	extern;
pascal void ViewPort(r)
	Rect *r;
	extern;
pascal void LookAt(left,top,right,bottom)
	Fixed left,top,right,bottom;
	extern;
pascal void ViewAngle(angle)
	Fixed angle;
	extern;
pascal void Identity()
	extern;
pascal void Scale(xFactor,yFactor,zFactor)
	Fixed xFactor,yFactor,zFactor;
	extern;
pascal void Translate(dx,dy,dz)
	Fixed dx,dy,dz;
	extern;
pascal void Pitch(xAngle)
	Fixed xAngle;
	extern;
pascal void Yaw(yAngle)
	Fixed yAngle;
	extern;
pascal void Roll(zAngle)
	Fixed zAngle;
	extern;
pascal void Skew(zAngle)
	Fixed zAngle;
	extern;
pascal void Transform(src,dst)
	Point3D *src,*dst;
	extern;
pascal short Clip3D(src1,src2,dst1,dst2)
	Point3D *src1,*src2;
	Point *dst1,*dst2;
	extern;
pascal void SetPt3D(pt3D,x,y,z)
	Point3D *pt3D;
	Fixed x,y,z;
	extern;
pascal void SetPt2D(pt2D,x,y)
	Point2D *pt2D;
	Fixed x,y;
	extern;
#endif

/************************************************************

Created: Tuesday, October 4, 1988 at 6:36 PM
    Graf3D.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988 
    All rights reserved

************************************************************/


#ifndef __GRAF3D__
#define __GRAF3D__

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#define radConst 3754936

typedef Fixed XfMatrix[4][4];


struct Point3D {
    Fixed x;
    Fixed y;
    Fixed z;
};

#ifndef __cplusplus
typedef struct Point3D Point3D;
#endif

struct Point2D {
    Fixed x;
    Fixed y;
};

#ifndef __cplusplus
typedef struct Point2D Point2D;
#endif

struct Port3D {
    GrafPtr grPort;
    Rect viewRect;
    Fixed xLeft;
    Fixed yTop;
    Fixed xRight;
    Fixed yBottom;
    Point3D pen;
    Point3D penPrime;
    Point3D eye;
    Fixed hSize;
    Fixed vSize;
    Fixed hCenter;
    Fixed vCenter;
    Fixed xCotan;
    Fixed yCotan;
    char filler;
    char ident;
    XfMatrix xForm;
};

#ifndef __cplusplus
typedef struct Port3D Port3D;
#endif

typedef Port3D *Port3DPtr;

#ifdef __safe_link
extern "C" {
#endif
pascal void InitGrf3d(Port3DPtr port); 
pascal void Open3DPort(Port3DPtr port); 
pascal void SetPort3D(Port3DPtr port); 
pascal void GetPort3D(Port3DPtr *port); 
pascal void MoveTo2D(Fixed x,Fixed y); 
pascal void MoveTo3D(Fixed x,Fixed y,Fixed z); 
pascal void LineTo2D(Fixed x,Fixed y); 
pascal void Move2D(Fixed dx,Fixed dy); 
pascal void Move3D(Fixed dx,Fixed dy,Fixed dz); 
pascal void Line2D(Fixed dx,Fixed dy); 
pascal void Line3D(Fixed dx,Fixed dy,Fixed dz); 
pascal void ViewPort(const Rect *r); 
pascal void LookAt(Fixed left,Fixed top,Fixed right,Fixed bottom); 
pascal void ViewAngle(Fixed angle); 
pascal void Identity(void); 
pascal void Scale(Fixed xFactor,Fixed yFactor,Fixed zFactor); 
pascal void Translate(Fixed dx,Fixed dy,Fixed dz); 
pascal void Pitch(Fixed xAngle); 
pascal void Yaw(Fixed yAngle); 
pascal void Roll(Fixed zAngle); 
pascal void Skew(Fixed zAngle); 
pascal void Transform(const Point3D *src,Point3D *dst); 
pascal short Clip3D(const Point3D *src1,const Point3D *src2,Point *dst1,
    Point *dst2); 
pascal void SetPt3D(Point3D *pt3D,Fixed x,Fixed y,Fixed z); 
pascal void SetPt2D(Point2D *pt2D,Fixed x,Fixed y); 
pascal void LineTo3D(Fixed x,Fixed y,Fixed z); 
#ifdef __safe_link
}
#endif

#endif

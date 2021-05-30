/*
	Types.h -- Common Defines and Types

	version	2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __TYPES__
#define __TYPES__

#define nil 0
#define NULL 0
#define noErr 0
typedef enum {false,true} Boolean;
typedef char *Ptr;
typedef Ptr *Handle;
typedef long (*ProcPtr)();
typedef ProcPtr *ProcHandle;
typedef long Fixed;
typedef long Fract;
typedef unsigned long ResType;
typedef long OSType;
typedef short OSErr;
typedef unsigned char Style;
typedef struct Point {
	short v;
	short h;
} Point;
typedef struct Rect {
	short top;
	short left;
	short bottom;
	short right;
} Rect;
#define String(size) struct {\
	unsigned char length; unsigned char text[size];}
typedef String(255) Str255,*StringPtr,**StringHandle;
#endif

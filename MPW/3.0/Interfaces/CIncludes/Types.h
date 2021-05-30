/************************************************************

Created: Tuesday, October 4, 1988 at 10:06 PM
    Types.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved

************************************************************/


#ifndef __TYPES__
#define __TYPES__

#ifndef NULL
#define NULL 0
#endif
#define nil 0
#define noErr 0     /*All is well*/
#define Length(string) (*(unsigned char *)(string))

enum {false,true};
typedef unsigned char Boolean;

typedef long (*ProcPtr)();
typedef long Fixed;
typedef long Fract;

typedef short OSErr;

typedef unsigned long OSType;

typedef ProcPtr *ProcHandle;
typedef char *Ptr;
typedef Ptr *Handle;
typedef unsigned long ResType;
typedef unsigned char Str255[256],Str63[64],Str31[32],Str27[28],Str15[16],*StringPtr,**StringHandle;

typedef unsigned char Style;


struct Point {
    short v;
    short h;
};

#ifndef __cplusplus
typedef struct Point Point;
#endif

struct Rect {
    short top;
    short left;
    short bottom;
    short right;
};

#ifndef __cplusplus
typedef struct Rect Rect;
#endif

#ifdef __safe_link
extern "C" {
#endif
pascal void Debugger(void)
    = 0xA9FF; 
pascal void DebugStr(const Str255 aStr)
    = 0xABFF; 
void debugstr(char *aStr); 
#ifdef __safe_link
}
#endif

#endif

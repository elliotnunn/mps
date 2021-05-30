/************************************************************

Created: Thursday, September 7, 1989 at 8:18 PM
	Types.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1985-1989
	All rights reserved

************************************************************/


#ifndef __TYPES__
#define __TYPES__

#ifndef NULL
#define NULL 0
#endif
#define nil 0
#define noErr 0 	/*All is well*/

enum {false,true};
typedef unsigned char Boolean;

enum {v,h};
typedef unsigned char VHSelect;

typedef long (*ProcPtr)();
typedef unsigned char Byte;
typedef char SignedByte;
typedef long Fixed;
typedef long Fract;

typedef short OSErr;

typedef unsigned long OSType;

typedef ProcPtr *ProcHandle;
typedef char *Ptr;
typedef Ptr *Handle;
typedef unsigned long ResType;
typedef unsigned char Str255[256],Str63[64],Str31[32],Str27[28],Str15[16],*StringPtr,**StringHandle;

#ifdef __cplusplus
inline int Length(const StringPtr string) { return (*string); };
#else
#define Length(string) (*(unsigned char *)(string))
#endif


typedef unsigned char Style;


struct Point {
	short v;
	short h;
};

typedef struct Point Point;
struct Rect {
	short top;
	short left;
	short bottom;
	short right;
};

typedef struct Rect Rect;
#ifdef __cplusplus
extern "C" {
#endif
pascal void Debugger(void)
	= 0xA9FF;
pascal void DebugStr(StringPtr aStr)
	= 0xABFF;
void debugstr(char *aStr);
pascal void SysBreak(void)
	= {0x303C,0xFE16,0xA9C9};
pascal void SysBreakStr(StringPtr debugStr)
	= {0x303C,0xFE15,0xA9C9};
pascal void SysBreakFunc(StringPtr debugFunc)
	= {0x303C,0xFE14,0xA9C9};
#ifdef __cplusplus
}
#endif

#endif

/*
 	File:		GXMath.h
 
 	Contains:	QuickDraw GX math routine interfaces.
 
 	Version:	Technology:	Quickdraw GX 1.1
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __GXMATH__
#define __GXMATH__


#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __FIXMATH__
#include <FixMath.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#if defined(__MWERKS__) && GENERATING68K
	#pragma push
	#pragma pointers_in_D0
#endif
 
#define mathTypesIncludes
/* old header = math types */
 
struct gxPoint {
	Fixed							x;
	Fixed							y;
};
typedef struct gxPoint gxPoint;

typedef unsigned short gxColorValue;

struct gxPolar {
	Fixed							radius;
	Fixed							angle;
};
struct gxMapping {
	Fixed							map[3][3];
};
typedef struct gxPolar gxPolar;

typedef struct gxMapping gxMapping;

#define gxColorValue1 ((gxColorValue) 0x0000FFFF)
#define gxPositiveInfinity ((long) 0x7FFFFFFFL)
#define gxNegativeInfinity ((long) 0x80000000L)
#define mathRoutinesIncludes
/* old header = math routines */
 
extern gxMapping *CopyToMapping(gxMapping *target, const gxMapping *source)
 THREEWORDINLINE(0x303C, 0x31, 0xA832);
extern gxMapping *InvertMapping(gxMapping *target, const gxMapping *source)
 THREEWORDINLINE(0x303C, 0x32, 0xA832);
extern gxMapping *MapMapping(gxMapping *target, const gxMapping *source)
 THREEWORDINLINE(0x303C, 0x33, 0xA832);
extern gxMapping *MoveMapping(gxMapping *target, Fixed hOffset, Fixed vOffset)
 THREEWORDINLINE(0x303C, 0x34, 0xA832);
extern gxMapping *MoveMappingTo(gxMapping *target, Fixed hPosition, Fixed vPosition)
 THREEWORDINLINE(0x303C, 0x35, 0xA832);
extern gxMapping *NormalizeMapping(gxMapping *target)
 THREEWORDINLINE(0x303C, 0x36, 0xA832);
extern gxMapping *RotateMapping(gxMapping *target, Fixed angle, Fixed xCenter, Fixed yCenter)
 THREEWORDINLINE(0x303C, 0x37, 0xA832);
extern gxMapping *ScaleMapping(gxMapping *target, Fixed hFactor, Fixed vFactor, Fixed xCenter, Fixed yCenter)
 THREEWORDINLINE(0x303C, 0x38, 0xA832);
extern gxMapping *ResetMapping(gxMapping *target)
 THREEWORDINLINE(0x303C, 0x39, 0xA832);
extern gxMapping *SkewMapping(gxMapping *target, Fixed skewX, Fixed skewY, Fixed xCenter, Fixed yCenter)
 THREEWORDINLINE(0x303C, 0x3a, 0xA832);
extern void MapPoints(const gxMapping *source, long count, gxPoint vector[])
 THREEWORDINLINE(0x303C, 0x3b, 0xA832);
extern short FirstBit(unsigned long x)
 THREEWORDINLINE(0x303C, 0x3c, 0xA832);
extern short WideScale(const wide *source)
 THREEWORDINLINE(0x303C, 0x3d, 0xA832);
extern short LinearRoot(Fixed first, Fixed last, Fract t[])
 THREEWORDINLINE(0x303C, 0x3e, 0xA832);
extern short QuadraticRoot(Fixed first, Fixed control, Fixed last, Fract t[])
 THREEWORDINLINE(0x303C, 0x3f, 0xA832);
extern gxPoint *PolarToPoint(const gxPolar *ra, gxPoint *xy)
 THREEWORDINLINE(0x303C, 0x40, 0xA832);
extern gxPolar *PointToPolar(const gxPoint *xy, gxPolar *ra)
 THREEWORDINLINE(0x303C, 0x41, 0xA832);
extern Fract FractCubeRoot(Fract source)
 THREEWORDINLINE(0x303C, 0x42, 0xA832);
extern Fract FractDivide(Fract dividend, Fract divisor)
 THREEWORDINLINE(0x303C, 0x43, 0xA832);
extern Fract FractMultiply(Fract multiplicand, Fract multiplier)
 THREEWORDINLINE(0x303C, 0x44, 0xA832);
extern Fract FractSineCosine(Fixed degrees, Fract *cosine)
 THREEWORDINLINE(0x303C, 0x45, 0xA832);
extern Fract FractSquareRoot(Fract source)
 THREEWORDINLINE(0x303C, 0x46, 0xA832);
extern Fixed FixedDivide(Fixed dividend, Fixed divisor)
 THREEWORDINLINE(0x303C, 0x47, 0xA832);
extern Fixed FixedMultiply(Fixed multiplicand, Fixed multiplier)
 THREEWORDINLINE(0x303C, 0x48, 0xA832);
/* This next call is (source * multiplier / divisor) -- it avoids underflow, overflow by using wides */
extern long MultiplyDivide(long source, long multiplier, long divisor)
 THREEWORDINLINE(0x303C, 0x49, 0xA832);
extern unsigned long Magnitude(long deltaX, long deltaY)
 THREEWORDINLINE(0x303C, 0x4a, 0xA832);
extern long VectorMultiplyDivide(long count, const long *vector1, long step1, const long *vector2, long step2, long divisor)
 THREEWORDINLINE(0x303C, 0x4b, 0xA832);
 
 
/* wide operations are defined within FixMath.h only for PowerPC */
#if	!GENERATINGPOWERPC
extern wide *WideAdd(wide *target, const wide *source)
 THREEWORDINLINE(0x303C, 0x4c, 0xA832);
extern short WideCompare(const wide *target, const wide *source)
 THREEWORDINLINE(0x303C, 0x4d, 0xA832);
extern wide *WideNegate(wide *target)
 THREEWORDINLINE(0x303C, 0x4e, 0xA832);
extern wide *WideShift(wide *target, long shift)
 THREEWORDINLINE(0x303C, 0x4f, 0xA832);
extern unsigned long WideSquareRoot(const wide *source)
 THREEWORDINLINE(0x303C, 0x50, 0xA832);
extern wide *WideSubtract(wide *target, const wide *source)
 THREEWORDINLINE(0x303C, 0x51, 0xA832);
extern wide *WideMultiply(long multiplicand, long multiplier, wide *target)
 THREEWORDINLINE(0x303C, 0x52, 0xA832);
/* returns the quotient */
extern long WideDivide(const wide *dividend, long divisor, long *remainder)
 THREEWORDINLINE(0x303C, 0x53, 0xA832);
/* quotient replaces dividend */
extern wide *WideWideDivide(wide *dividend, long divisor, long *remainder)
 THREEWORDINLINE(0x303C, 0x55, 0xA832);
#endif
 
 
extern wide *VectorMultiply(long count, const long *vector1, long step1, const long *vector2, long step2, wide *dot)
 THREEWORDINLINE(0x303C, 0x54, 0xA832);
extern unsigned long RandomBits(long count, long focus)
 THREEWORDINLINE(0x303C, 0x56, 0xA832);
extern void SetRandomSeed(const wide *seed)
 THREEWORDINLINE(0x303C, 0x57, 0xA832);
extern wide *GetRandomSeed(wide *seed)
 THREEWORDINLINE(0x303C, 0x58, 0xA832);
#define FixedRound(a) ((short)((Fixed)(a) + fixed1/2 >> 16))
#define FixedSquareRoot(a) ((Fixed)FractSquareRoot(a) + 64 >> 7)
#define FixedTruncate(a) ((short)((Fixed)(a) >> 16))
#define FixedToFract(a) ((Fract)(a) << 14)
#define FractToFixed(a) ((Fixed)(a) + 8192L >> 14)
#define FixedToInt(a) ((short)((Fixed)(a) + fixed1/2 >> 16))
#define IntToFixed(a) ((Fixed)(a) << 16)
#define FixedToFloat(a) ((float)(a) / fixed1)
#define FloatToFixed(a) ((Fixed)((float)(a) * fixed1))
#define FractToFloat(a) ((float)(a) / fract1)
#define FloatToFract(a) ((Fract)((float)(a) * fract1))
#define ColorToFract(a) (((Fract) (a) << 14) + ((Fract)(a) + 2 >> 2))
#define FractToColor(a) ((gxColorValue) ((a) - ((a) >> 16) + 8191 >> 14))
#define ff(a) IntToFixed(a)
#define fl(a) FloatToFixed(a)
 
#if defined(__MWERKS__) && GENERATING68K
	#pragma pop
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __GXMATH__ */

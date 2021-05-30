/*
	FixMath.h -- Fixed Point Math

	version	2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __FIXMATH__
#define __FIXMATH__
#ifndef __TYPES__
#include <Types.h>
#endif

pascal Fixed FixDiv(x,y)
	Fixed x,y;
	extern /* 0xA84D */;
pascal Fract FracDiv(x,y)
	Fract x,y;
	extern /* 0xA84B */;
pascal Fract FracMul(x,y)
	Fract x,y;
	extern /* 0xA84A */;
pascal Fract FracSqrt(x)
	Fract x;
	extern /* 0xA849 */;
pascal Fract FracSin(x)
	Fixed x;
	extern /* 0xA848 */;
pascal Fract FracCos(x)
	Fixed x;
	extern /* 0xA847 */;
pascal Fixed FixATan2(x,y)
	long x,y;
	extern 0xA818;
pascal Fixed Long2Fix(x)
	long x;
	extern 0xA83F;
pascal long Fix2Long(x)
	Fixed x;
	extern 0xA840;
pascal Fract Fix2Frac(x)
	Fixed x;
	extern 0xA841;
pascal Fixed Frac2Fix(x)
	Fract x;
	extern 0xA842;
pascal extended Fix2X(x)
	Fixed x;
	extern 0xA843;
extern Fixed X2Fix();
pascal extended Frac2X(x)
	Fract x;
	extern 0xA845;
extern Fract X2Frac();
#endif

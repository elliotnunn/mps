/************************************************************

Created: Thursday, September 7, 1989 at 8:55 PM
	FixMath.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1985-1989
	All rights reserved

************************************************************/


#ifndef __FIXMATH__
#define __FIXMATH__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif
pascal Fract Fix2Frac(Fixed x)
	= 0xA841;
pascal long Fix2Long(Fixed x)
	= 0xA840;
pascal Fixed FixATan2(long x,long y)
	= 0xA818;
pascal Fixed Long2Fix(long x)
	= 0xA83F;
pascal Fixed Frac2Fix(Fract x)
	= 0xA842;
pascal extended Frac2X(Fract x);
pascal extended Fix2X(Fixed x); 
pascal Fixed X2Fix(extended x); 
pascal Fract X2Frac(extended x);
pascal Fract FracMul(Fract x,Fract y);
pascal Fixed FixDiv(Fixed x,Fixed y);
pascal Fract FracDiv(Fract x,Fract y);
pascal Fract FracSqrt(Fract x); 
pascal Fract FracSin(Fixed x);
pascal Fract FracCos(Fixed x);
#ifdef __cplusplus
}
#endif

#endif

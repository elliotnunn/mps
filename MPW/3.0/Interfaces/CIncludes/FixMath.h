/************************************************************

Created: Tuesday, October 4, 1988 at 10:43 PM
    FixMath.h
    C Interface to Fixed Point Math


    Copyright Apple Computer, Inc.  1985-1988 
    All rights reserved

************************************************************/


#ifndef __FIXMATH__
#define __FIXMATH__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifdef __safe_link
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
#ifdef __safe_link
}
#endif

#endif

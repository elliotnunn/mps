/************************************************************

Created: Tuesday, October 4, 1988 at 10:45 PM
    Math.h
    Math Supplement to SANE


    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved

************************************************************/


#ifndef __MATH__
#define __MATH__

#ifndef __SANE__
#include <SANE.h>
#endif

#define pow(x,y) power(x,y)

#ifdef __safe_link
extern "C" {
#endif
extended log10(extended x);
extended frexp(extended x,int *exp); 
extended ldexp(extended x,int n); 
extended floor(extended x); 
extended ceil(extended x); 
extended fmod(extended x,extended y); 
extended modf(extended x,extended *ip); 
extended fabs(extended x); 
extended sinh(extended x); 
extended cosh(extended x); 
extended tanh(extended x); 
extended asin(extended x); 
extended acos(extended x); 
extended atan2(extended y,extended x); 
extended hypot(extended x,extended y); 
char *ecvt(extended value,int ndigit,int *decpt,int *sign); 
char *fcvt(extended value,int ndigit,int *decpt,int *sign); 
#ifdef __safe_link
}
#endif

#endif

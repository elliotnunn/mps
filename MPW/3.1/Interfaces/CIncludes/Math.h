/************************************************************

Created: Friday, September 15, 1989 at 6:14 PM
	Math.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1985-1989
	All rights reserved

************************************************************/


#ifndef __MATH__
#define __MATH__

#ifndef __SANE__
#include <SANE.h>
#endif

#define HUGE_VAL inf()
#define pow(x,y) power(x,y)

#ifdef __cplusplus
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
#ifdef __cplusplus
}
#endif

#endif

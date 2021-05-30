/************************************************************

Created: Friday, September 15, 1989 at 6:14 PM
	Math.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1985-1991
	All rights reserved

************************************************************/


#ifndef __MATH__
#define __MATH__

#define HUGE_VAL __inf()

#ifdef __cplusplus
extern "C" {
#endif
extended sin(extended x);
extended cos(extended x);
extended tan(extended x);
extended asin(extended x);
extended acos(extended x);
extended atan(extended x);
extended atan2(extended y,extended x);
extended sinh(extended x);
extended cosh(extended x);
extended tanh(extended x);
extended exp(extended x);
extended log(extended x);
extended log10(extended x); 
extended frexp(extended x,int *exp);
extended ldexp(extended x,int n);
extended modf(extended x,extended *ip);
extended pow(extended x,extended y);
extended sqrt(extended x);
extended floor(extended x); 
extended ceil(extended x);
extended fmod(extended x,extended y);
extended fabs(extended x);
char *ecvt(extended value,int ndigit,int *decpt,int *sign); 
char *fcvt(extended value,int ndigit,int *decpt,int *sign);

extended __inf(void);
extended hypot(extended x,extended y);

#ifdef __cplusplus
}
#endif

#endif

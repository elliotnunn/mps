/*
	Math.h - Math Supplement to SANE

	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __MATH__
#define __MATH__

#ifndef __SANE__
#include <SANE.h>
#endif

extended atof(),frexp(),ldexp(),modf();
#define log10(x) (log(x)/2.3025850929940456840)
#define pow(x,y) power(x,y)
extended floor(),ceil(),fmod();
extended hypot();
extended sinh(),cosh(),tanh();
extended asin(),acos(),atan2();
#endif

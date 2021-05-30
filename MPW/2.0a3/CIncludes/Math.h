/*
	Math.h - Math Supplement to SANE

	version	2.0a3

	Copyright Apple Computer,Inc. 1985 - 1987
	All rights reserved.
*/

#ifndef __MATH__
#define __MATH__

#ifndef __SANE__
#include <SANE.h>
#endif

extended atof(),frexp(),ldexp(),modf();
#define log10(x) (log(x)/log(10.0))
#define pow(x,y) power(x,y)
extended floor(),ceil(),fmod();
extended hypot();
extended sinh(),cosh(),tanh();
extended asin(),acos(),atan2();
#endif

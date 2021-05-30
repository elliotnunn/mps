/*
	SANE.h - Standard Apple Numeric Environment

	version	2.0a3

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985 - 1987
	All rights reserved.
*/

#ifndef __SANE__
#define __SANE__

#define SIGDIGLEN 20
#define DECSTROUTLEN 80 
#define FLOATDECIMAL 0
#define FIXEDDECIMAL 1
#define INVALID 1
#define UNDERFLOW 2
#define OVERFLOW 4
#define DIVBYZERO 8
#define INEXACT 16
#define GREATERTHAN 0
#define LESSTHAN 1
#define EQUALTO 2
#define UNORDERED 3
#define SNAN 0
#define QNAN 1
#define INFINITE 2
#define ZERONUM 3
#define NORMALNUM 4
#define DENORMALNUM 5
#define TONEAREST 0
#define UPWARD 1
#define DOWNWARD 2
#define TOWARDZERO 3
#define EXTPRECISION 0
#define DBLPRECISION 1
#define FLOATPRECISION 2
#define IEEEDEFAULTENV 0

typedef short exception;
typedef short relop;
typedef short numclass; 
typedef short rounddir; 
typedef short roundpre; 
typedef short environment;
typedef struct decimal {
	char sgn,unused;
	short exp;
	struct {unsigned char length,text[SIGDIGLEN],unused} sig;
} decimal;
typedef struct decform {
	char style,unused;
	short digits;
} decform;
typedef void (*haltvector)();

extended dec2num();
extended fabs();
extended remainder();
extended sqrt();
extended rint();
extended scalb();
extended logb();
extended copysign();
extended nextfloat();
extended nextdouble();
extended nextextended();
extended log2();
extended log();
extended log1();
extended exp2();
extended exp();
extended exp1();
extended power();
extended ipower();
extended compound();
extended annuity();
extended tan();
extended sin();
extended cos();
extended atan();
extended randomx();
haltvector gethaltvector();
extended nan();
extended inf();
extended pi();
#endif

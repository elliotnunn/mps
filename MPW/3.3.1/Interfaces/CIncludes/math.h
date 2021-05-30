/************************************************************

Created: Friday, September 15, 1989 at 6:14 PM
	Math.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1985-1992
	All rights reserved
	
	25 Feb 93 - Rewritten by Preston Gardner to be ANSI conforming.
	
Change log (relative to MPW 3.1 Math.h)

	26 Oct 89 - Jon Okada
		Removed #include of SANE.h.
		Added declaration of __inf() and changed #define of HUGE_VAL.
		Changed #define of pow to declaration.
		Added declarations of sqrt, log, exp, tan, cos, sin,
		  and atan (formerly in SANE.h).

************************************************************/


#ifndef __MATH_H__
#define __MATH_H__

/*  Strictly conforming implementations must have the parameters to these routines
    be double, not long double.  They still get evaluated to long double precision on the 68K.
	We expect that a lot of this confusion will eventually get settled by NCEG and then
	we will do it the NCEG way.
*/
#if (__STDC__ == 1) || defined(powerc)
#define _float_eval double
#else /*__STDC__*/
#define _float_eval long double
#endif /*__STDC__*/

#define HUGE_VAL __inf()

#ifdef __cplusplus
extern "C" {
#endif
_float_eval sin(_float_eval _x);  /* We put underscores on the formal parameter names to reduce name space pollution.
									 Plum-Hall tests require that we do this:  they have macros called exp, size etc. */
_float_eval cos(_float_eval _x);
_float_eval tan(_float_eval _x);
_float_eval asin(_float_eval _x);
_float_eval acos(_float_eval _x);
_float_eval atan(_float_eval _x);
_float_eval atan2(_float_eval _y,_float_eval _x);
_float_eval sinh(_float_eval _x);
_float_eval cosh(_float_eval _x);
_float_eval tanh(_float_eval _x);
_float_eval exp(_float_eval _x);
_float_eval log(_float_eval _x);
_float_eval log10(_float_eval _x); 
_float_eval frexp(_float_eval _x,int *_exp);
_float_eval ldexp(_float_eval _x,int _n);

_float_eval modf(_float_eval _x, _float_eval *_ip);

#ifdef powerc
/*
 *	If you use modf() you must decide which version you mean: modf(),
 *	modff() or modfl().  The usual promotions to long double don't
 *	help here because we're using a pointer.
 *
 *	NOTE:	both modff() and modfl() are not ANSI defined functions;
 *			if you use it, your code may not be portable.
 */
float modff(float _x,float *_ip);
long double modfl(long double _x, long double *_ip);
#endif

_float_eval pow(_float_eval _x,_float_eval _y);
_float_eval sqrt(_float_eval _x);
_float_eval floor(_float_eval _x); 
_float_eval ceil(_float_eval _x);
_float_eval fmod(_float_eval _x,_float_eval _y);
_float_eval fabs(_float_eval _x);

_float_eval __inf(void);
/*
 * NOTE:	hypot() is not an ANSI defined function;
 *			if you use it, your code may not be portable.
 */
_float_eval hypot(_float_eval _x,_float_eval _y);

#ifdef __cplusplus
}
#endif

#endif

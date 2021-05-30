/************************************************************

	Math.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1985-1995
	All rights reserved
	
************************************************************/


#ifndef __MATH_H__
#define __MATH_H__

/*
	Strictly conforming implementations must have the parameters to these routines
    be double, not long double.  They still get evaluated to long double precision
	on the 68K.  We expect that a lot of this confusion will eventually get settled
	by NCEG and then we will do it the NCEG way.
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

/*
 *	We put underscores on the formal parameter names to reduce name space pollution.
 *	Plum-Hall tests require that we do this:  they have macros called exp, size etc.
 */

/*
 *	ANSI routines
 */

_float_eval sin(_float_eval _x);
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

_float_eval pow(_float_eval _x,_float_eval _y);
_float_eval sqrt(_float_eval _x);
_float_eval floor(_float_eval _x); 
_float_eval ceil(_float_eval _x);
_float_eval fmod(_float_eval _x,_float_eval _y);
_float_eval fabs(_float_eval _x);

_float_eval __inf(void);

/*
 *  Apple extentions
 */
 
/* CFront can't handle the pretty version of this conditional 
#if defined (__useAppleExts__) || \
	((defined (applec) && ! defined (__STDC__)) || \
	 (defined (__PPCC__) && __STDC__ == 0))
*/
#if defined (__useAppleExts__) || ((defined (applec) && ! defined (__STDC__)) || (defined (__PPCC__) && __STDC__ == 0))

#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
	#pragma import on
#endif

char *ecvt(extended value,int ndigit,int *decpt,int *sign); 	/* Imported from StdCLib. */
char *fcvt(extended value,int ndigit,int *decpt,int *sign); 	/* Imported from StdCLib. */

#if defined (__powerc) || defined (powerc) || defined (__CFM68K__)
	#pragma import off
#endif

_float_eval hypot(_float_eval _x,_float_eval _y);


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

#else
/*
 * For the 68K, these are defined as macros which evaluate to modf(),
 * since for the 68K world there is no difference between modf(), modff(),
 * and modfl().  (Functional implementations are also provided if you are
 * linking with MathLib.o.  If you link with CSANELib.o and Math.o,
 * attempting to use the function instead of the macro will cause link
 * errors as these are not available as functions in the older SANE engine.)
 */

float modff(float _x,float *_ip);
#define modff(_x,_ip) modf(_x,_ip)
long double modfl(long double _x, long double *_ip);
#define modfl(_x,_ip) modf(_x,_ip)

#endif  /* powerc */

#endif  /* __useAppleExts__ */

#ifdef __cplusplus
}
#endif

#endif  /* __MATH_H__ */

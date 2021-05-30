/*
	File:		Complex.h

	Contains:	xxx put contents here xxx

	Written by:	Jeff Cobb

	Copyright:	© 1993 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

		 <2>	  3/4/93	jrc		Total rewrite from Ali (so people will stop bothering him about
									our old headers)

*/

/************************************************************

Created: Monday, June 27, 1988 12:42:53 PM
    Complex.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc. 1985-1992
    All rights reserved.
	
IMPORTANT NOTE

PowerPC will for the time being support only one complex type
composed of an ordered pair of double_t (double) values. NCEG has not
yet specified complex extensions to C.  Without such a specification,
support for a second wider (long double) complex type will introduce
complications in mixed precision calculations, overloading in C++,
etc., as well as poorer performance.  Since double_t is defined to
be long double (extended) on the Motorola 680X0 Macintosh, the complex
arithmetic implementation remains the same in that world.

CHANGE LOG:

	30 Oct 92  JPO	Changed all instances of "extended" to "double_t"
					to accommodate PowerPC.
					
    August 25 1993   ali   changed clog to cLog to avoid clashing with
	                       the stream i/o clog.

************************************************************/

#ifndef __COMPLEX__
#define __COMPLEX__

#ifndef __FP__
#include "fp.h"
#endif

#ifndef   powerc              /*   preserve compatibility with 68k macintoshes    */
#define   cLog    clog
#endif

struct complex;

/*
	NOTE to users of the complex class stream i/o functionality:
	
	In order to use the complex stream functionality prototyped by the two following 
	function declarations one must include either <IOStream.h> or <Stream.h> before
	including <Complex.h>.

*/
#ifdef __IOSTREAM__
ostream& operator<<(ostream&, complex);
	istream& operator>>(istream&, complex&);
#endif
	
struct complex {
	double_t	re;
	double_t	im;
	
#ifdef __cplusplus

		complex() { re =0.0; im =0.0; }
		complex(double_t r, double_t i =0.0) { re =r; im =i; }

	friend double_t real(const complex);
	friend double_t imag(const complex);
	friend double_t abs(complex);
	friend double_t norm(complex);
	friend double_t arg(complex);

	friend complex	acos(complex);
	friend complex	acosh(complex);
	friend complex	asin(complex);
	friend complex	asinh(complex);
	friend complex	atan(complex);
	friend complex	atanh(complex);
	friend complex	conj(complex);
	friend complex	cos(complex);
	friend complex	cosh(complex);
	friend complex	exp(complex);
	friend complex	log(complex);
	friend complex	pow(complex, complex);
	friend complex	pow(complex, long);
	friend complex	pow(complex, double_t);
	friend complex	pow(double_t, complex);
	friend complex	polar(double_t, double_t);
	friend complex	sin(complex);
	friend complex	sinh(complex);
	friend complex	sqrt(complex);
	friend complex	sqr(complex);
	friend complex	tan(complex);
	friend complex	tanh(complex);
	friend complex	operator +(complex, complex);
	friend complex	operator -(complex, complex);
	friend complex	operator -(complex);
	friend complex	operator *(complex, complex);	
	friend complex	operator *(complex, double_t);
	friend complex	operator *(double_t, complex);
	friend complex	operator /(complex, complex);
	friend complex	operator /(complex, double_t);
	friend complex	operator /(double_t, complex);
	friend int		operator ==(complex, complex);
	friend int		operator !=(complex, complex);
	complex	 operator +=(complex);
	complex	 operator -=(complex);
	complex	 operator *=(complex);
	complex	 operator *=(double_t);
	complex	 operator /=(complex);
	complex	 operator /=(double_t);

#endif
};



#ifndef __cplusplus
typedef struct complex complex;
#else
extern "C" {
#endif
	
complex cadd( complex x, complex y );
complex csub( complex x, complex y );
complex cmul( complex x, complex y );
complex cdiv( complex x, complex y );
complex xdivc( double_t x, complex y );
complex csqrt( complex z );
complex csin( complex z );
complex ccos( complex z );
complex csquare( complex z );
complex cexp( complex z );
complex cLog( complex z );
complex cepwry( double_t x, complex y );
complex cxpwri( complex x, long y );
complex cxpwre( complex x, double_t y );
complex cxpwry( complex x, complex y );
complex csinh( complex z );
complex ccosh( complex z );
complex ctanh( complex z );
complex ctan( complex z );
complex casin( complex z );
complex casinh( complex z );
complex cacos( complex z );
complex cacosh( complex z );
complex catan( complex z );
complex catanh( complex z );
complex cconj( complex z );

double_t cabs( complex z );
double_t carg( complex z );

#ifdef __cplusplus
}	// close the extern "C" declaration

inline double_t	real(const complex a)	{ return a.re; }
inline double_t imag(const complex a)	{ return a.im; }
inline double_t abs(complex a)	{ return cabs(a); }
inline double_t norm(complex a)	{ return a.re*a.re+a.im*a.im; }
inline double_t arg(complex a)	{ return carg(a); }
inline complex	acos(complex a)	{ return cacos(a); }
inline complex	acosh(complex a)	{ return cacosh(a); }
inline complex	asin(complex a)	{ return casin(a); }
inline complex	asinh(complex a)	{ return casinh(a); }
inline complex	atan(complex a)	{ return catan(a); }
inline complex	atanh(complex a)	{ return catanh(a); }
inline complex	conj(complex a)	{ return complex(a.re, -a.im); }
inline complex	cos(complex a)	{ return ccos(a); }
inline complex	cosh(complex a)	{ return ccosh(a); }
inline complex	exp(complex a)	{ return cexp(a); }
inline complex	log(complex a)	{ return cLog(a); }
inline complex	pow(complex a, complex b)	{ return cxpwry(a, b); }
inline complex	pow(complex a, long b)	{ return cxpwri(a, b); }
inline complex	pow(complex a, double_t b)	{ return cxpwre(a, b); }
inline complex	pow(double_t a, complex b) { return cepwry(a, b); }
inline complex	polar(double_t r, double_t theta)	{ return complex(r*cos(theta), r*sin(theta) ); }
inline complex	sin(complex a)	{ return csin(a); }
inline complex	sinh(complex a)	{ return csinh(a); }
inline complex	sqrt(complex a)	{ return csqrt(a); }
inline complex	sqr(complex a)	{ return csquare(a); }
inline complex	tan(complex a)	{ return ctan(a); }
inline complex	tanh(complex a)	{ return ctanh(a); }
inline complex	operator +(complex a, complex b)	{ return complex(a.re+b.re, a.im+b.im); }
inline complex	operator -(complex a,complex b)	{ return complex(a.re-b.re, a.im-b.im); }
inline complex	operator -(complex a)	{ return complex(-a.re, -a.im); }
inline complex	operator *(complex a, complex b)	{ return cmul(a, b); }	
inline complex	operator *(complex a, double_t b)	{ return complex(a.re*b, a.im*b); }
inline complex	operator *(double_t a, complex b)	{ return complex(a*b.re, a*b.im); }
inline complex	operator /(complex a, complex b)	{ return cdiv(a, b); }
inline complex	operator /(complex a, double_t b) { return complex(a.re/b, a.im/b); }
inline complex	operator /(double_t a, complex b)	{ return xdivc(a, b); }
inline int		operator ==(complex a, complex b)	{ return (a.re==b.re && a.im==b.im); }
inline int		operator !=(complex a, complex b)	{ return (a.re!=b.re || a.im!=b.im); }

inline complex complex::operator +=(complex a)
{
	re += a.re;
	im += a.im;
	return complex(re, im);
}

inline complex complex::operator -=(complex a)
{
	re -= a.re;
	im -= a.im;
	return complex(re, im);
}

inline complex complex::operator *=(complex a)
{
	return *this = cmul(*this, a);
}

inline complex complex::operator *=(double_t a)
{
	re *= a;
	im *= a;
	return complex(re, im);
}

inline complex complex::operator /=(complex a)
{
	return *this = cdiv(*this, a);
}

inline complex complex::operator /=(double_t a)
{
	re /= a;
	im /= a;
	return complex(re, im);
}

#endif

#endif
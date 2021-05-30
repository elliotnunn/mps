#ifndef __COMPLEX__
#define __COMPLEX__

/************************************************************

Created: Monday, June 27, 1988 12:42:53 PM
    Complex.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc. 1985-1988
    All rights reserved.

************************************************************/

#ifndef __SANE__ 
#include <SANE.h>
#endif

struct complex {
	extended	re;
	extended	im;
	
#ifdef __cplusplus

		complex() { re =0.0; im =0.0; }
		complex(extended r, extended i =0.0) { re =r; im =i; }

	friend extended real(const complex&);
	friend extended imag(const complex&);
	friend extended abs(complex);
	friend extended norm(complex);
	friend extended arg(complex);

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
	friend complex	pow(complex, extended);
	friend complex	pow(extended, complex);
	friend complex	polar(extended, extended);
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
	friend complex	operator *(complex, extended);
	friend complex	operator *(extended, complex);
	friend complex	operator /(complex, complex);
	friend complex	operator /(complex, extended);
	friend complex	operator /(extended, complex);
	friend int		operator ==(complex, complex);
	friend int		operator !=(complex, complex);
	void	operator +=(complex);
	void	operator -=(complex);
	void	operator *=(complex);
	void	operator *=(extended);
	void	operator /=(complex);
	void	operator /=(extended);

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
complex xdivc( extended x, complex y );
complex csqrt( complex z );
complex csin( complex z );
complex ccos( complex z );
complex csquare( complex z );
complex cexp( complex z );
complex clog( complex z );
complex cepwry( extended x, complex y );
complex cxpwri( complex x, long y );
complex cxpwre( complex x, extended y );
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

extended cabs( complex z );
extended carg( complex z );
extended arcsinh( extended x );

#ifdef __cplusplus
}	// close the extern "C" declaration

/*
	NOTE: To users of the complex class stream i/o functionality
	
	In order to use the complex stream functionality prototyped by the two following function
	declarations one must also include <iostreams.h>.  It was not done here so as not to penalize
	those complex users who choose not to use the stream support.  Use of the Stream library
	requires linking against a library with "sticky" modules that cannot be stripped by the
	linker even if you don't use them.
*/

class ostream;
class istream;

ostream& operator<<(ostream&, complex);
istream& operator>>(istream&, complex&);

inline extended	real(const complex& a)	{ return a.re; }
inline extended imag(const complex& a)	{ return a.im; }
inline extended abs(complex a)	{ return cabs(a); }
inline extended norm(complex a)	{ return a.re*a.re+a.im*a.im; }
inline extended arg(complex a)	{ return carg(a); }
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
inline complex	log(complex a)	{ return clog(a); }
inline complex	pow(complex a, complex b)	{ return cxpwry(a, b); }
inline complex	pow(complex a, long b)	{ return cxpwri(a, b); }
inline complex	pow(complex a, extended b)	{ return cxpwre(a, b); }
inline complex	pow(extended a, complex b) { return cepwry(a, b); }
inline complex	polar(extended r, extended theta)	{ return complex(r*cos(theta), r*sin(theta) ); }
inline complex	sin(complex a)	{ return csin(a); }
inline complex	sinh(complex a)	{ return csinh(a); }
inline complex	sqrt(complex a)	{ return csqrt(a); }
inline complex	sqr(complex a)	{ return csquare(a); }
inline complex	tan(complex a)	{ return ctan(a); }
inline complex	tanh(complex a)	{ return ctanh(a); }
inline complex	operator +(complex a, complex b)	{ return complex(a.re+b.re, a.im+b.im); }
inline complex	operator -(complex a,complex b)	{ return complex(a.re-b.re, a.im-b.im); }
inline complex	operator -(complex a)	{ return complex(-a.re, -a.im); }
inline complex	operator *(complex a, complex b)	
	{ return complex(a.re*b.re-a.im*b.im, a.re*b.im+a.im*b.re); }
inline complex	operator *(complex a, extended b)	{ return complex(a.re*b, a.im*b); }
inline complex	operator *(extended a, complex b)	{ return complex(a*b.re, a*b.im); }
inline complex	operator /(complex a, complex b)	{ return cdiv(a, b); }
inline complex	operator /(complex a, extended b) { return complex(a.re/b, a.im/b); }
inline complex	operator /(extended a, complex b)	{ return xdivc(a, b); }
inline int		operator ==(complex a, complex b)	{ return (a.re==b.re && a.im==b.im); }
inline int		operator !=(complex a, complex b)	{ return (a.re!=b.re || a.im!=b.im); }

inline void	complex::operator +=(complex a)
{
	re += a.re;
	im += a.im;
}

inline void complex::operator -=(complex a)
{
	re -= a.re;
	im -= a.im;
}

inline void	complex::operator *=(complex a)
{
	extended r = re*a.re - im*a.im;
	extended i = re*a.im + im*a.re;
	re = r;
	im = i;
}

inline void complex::operator *=(extended a)
{
	re *= a;
	im *= a;
}

inline void complex::operator /=(complex a)
{
	complex quot, temp1, temp2;
	if ( (temp2.re = a.re) < 0 ) temp2.re = -temp2.re;
	if ( (temp2.im = a.im) < 0 ) temp2.im = -temp2.im;
	if ( temp2.re <= temp2.im ) {
		temp2.im = a.re/a.im;
		temp2.re = a.im * (1 + temp2.im*temp2.im);
		temp1 = *this;
	} else {
		temp2.im = -a.im/a.re;
		temp2.re = a.re * (1 +  temp2.im*temp2.im);
		temp1.re = -im;
		temp1.im = re;
	}
	re = (temp1.re * temp2.im + temp1.im) / temp2.re;
	im = (temp1.im * temp2.im - temp1.re) / temp2.re;
}

inline void complex::operator /=(extended a)
{
	re /= a;
	im /= a;
}

#endif

#endif
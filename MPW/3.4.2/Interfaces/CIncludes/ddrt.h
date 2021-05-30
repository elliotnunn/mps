/************************************************************

    ddrt.h

    Types and functions used for emulating PowerPC "double double"
	arithmetic. The "double double" type is the implementation
	of the "long double" 'C' data type as supported on Apple's
	PowerPC computers by Apple's PowerPC compilers.
	
	Certain function names were previously defined by IBM™
	for their AIX runtime environment.  They are provided here
	for backward compability.

    Copyright Apple Computer,Inc.  1996
    All rights reserved

************************************************************/

#ifndef __DDRT_H__
#define __DDRT_H__

#include <ConditionalMacros.h>
#include <fp.h>
#include <fenv.h>

#ifdef __cplusplus
extern "C" {
#endif

#if		GENERATINGPOWERPC

typedef long double DD;							/*	Use native "long double".		*/
typedef decimal decimalDD;

#define __fpsetdblprec() ((void)0)
#define __fpsetextprec() ((void)0)

#else	/* not GENERATINGPOWERPC */

#define __fpsetdblprec() fesetprec(FE_DBLPREC)
#define __fpsetextprec() fesetprec(FE_LDBLPREC)

#define			SIGDIGLENDD		36				/*	significant decimal digits		*/
#define			MAXDIGITS		SIGDIGLENDD

struct decimalDD 
{
	char sgn;									/*	sign 0 for +, 1 for -			*/
	char unused;
	short exp;									/*	decimal exponent				*/
	struct
	{
		unsigned char length;
		unsigned char text[SIGDIGLENDD];		/*	significant digits				*/
		unsigned char unused;
	} sig;
};

typedef struct decimalDD decimalDD;

typedef struct									/*	"long double" on the PowerPC	*/
{												/*	is just a pair of doubles.		*/
	double hi;
	double lo;
} DD;

/*	These routines are similar to the corresponding routines in <fp.h>
 *	except that these routines run on the 68000 family.
 */


extern void num2decl ( const decform *f, DD x, decimalDD *d );

extern void num2decDD ( const decform *f, double x, decimalDD *d );

extern DD dec2numDD ( const decimalDD *d );

extern void str2decDD ( const char *s, short *ix, decimalDD *d, short *vp ); 

extern DD str2numDD (const char *s);

#endif	/* GENERATINGPOWERPC */

/*	Basic operations	*/
extern DD _xlqadd( DD x, DD y );
extern DD _xlqsub( DD x, DD y );
extern DD _xlqmul( DD x, DD y );
extern DD _xlqdiv( DD x, DD y );
extern DD __negdd( DD x );


/*	Type conversions	*/
extern DD __int2dd( int n );
extern DD __uns2dd( unsigned ui );
extern DD __flt2dd( float f );
extern DD __dbl2dd( double d );
extern int __dd2int( DD x );
extern unsigned int __dd2uns( DD x );
extern float __dd2flt( DD x );
extern double __dd2dbl( DD x );

extern DD _qint(DD x);  /*	truncates x to DD integer.	*/

#define _HEAD(x) ((double *)&x)[0]
#define _TAIL(x) ((double *)&x)[1]

/* Macro forms of the relational operator routines. */

#define _EQ(x,y) (_HEAD(x) == _HEAD(y) && _TAIL(x) == _TAIL(y))
#define _NE(x,y) (_HEAD(x) != _HEAD(y) || _TAIL(x) != _TAIL(y))
#define _GT(x,y) (_HEAD(x) > _HEAD(y) || (_HEAD(x) == _HEAD(y) && _TAIL(x) > _TAIL(y)))
#define _LT(x,y) (_HEAD(x) < _HEAD(y) || (_HEAD(x) == _HEAD(y) && _TAIL(x) < _TAIL(y)))
#define _LE(x,y) (_LT(x,y) || _EQ(x,y))
#define _GE(x,y) (_GT(x,y) || _EQ(x,y))
#define _UNORDERED(x,y) \
( \
	_HEAD(x) != _HEAD(x) || _HEAD(y) != _HEAD(y) || \
	_TAIL(x) != _TAIL(x) || _TAIL(y) != _TAIL(y)    \
)

/* Relational operators */
extern int __ddeq(DD x, DD y);        /* x == y */
extern int __ddne(DD x, DD y);        /* x != y */
extern int __ddgt(DD x, DD y);        /* x >  y */
extern int __ddge(DD x, DD y);        /* x >= y */
extern int __ddlt(DD x, DD y);        /* x <  y */
extern int __ddle(DD x, DD y);        /* x <= y */
extern int __ddunordered(DD x, DD y); /* x unordered y */


/* Emulation routine for the PowerPC's Multiply-Add-Fused instruction:
 *    (x*y + z)
 */
extern double MAF( double x, double y, double z );

/* The possible values returned by "_qatof".	*/
typedef enum
{
	NoConversionError = 0,
	PositiveOverFlow = 1,
	NegativeOverFlow = 2,
	Underflow = 3,
	DenormalizedNumber = 4
} ConversionErrorFlagType;

/*
 * Similar to "atof"
 * "_qatof" converts the charater string "s" into a "DD"
 * "ld" points to the result.
 * The return value gives a possible conversion error.
 */

extern int _qatof(DD *ld, const char *s);

/*
 * Similar to "ecvt" and "fcvt".
 * Converts "value" to a decimal string.
 * "ndigit" is the number of digits to use in the string.
 * "decpt" will be the character position of the decimal point.
 * "sign" will be 0 for positive, 1 for negative.
 * "_qecvt" uses the "e" format, producing a floating point number with exponent.
 * "_qecvt" uses the "f" format, producing a fixed point number.
 * "__g_fmt" uses the "g" format, using either fixed or floating point depending on the value.
 *   The buffer "output" should be at least 64-bytes long.
 *
 * Note:
 *  Due to the nature of the "DD" type, it is not always possible to print
 * a decimal string that can acurately represent the binary value.  Under
 * these conditions, the binary->decimal->binary round trip conversion
 * cannot be guaranteed with less than 600 decimal digits.
 */

extern char *_qecvt (DD value, int ndigit, int *decpt, int *sign);
extern char *_qfcvt (DD value, int ndigit, int *decpt, int *sign);
extern void __g_fmt (char *output, DD value);


#ifdef __cplusplus
}			/* extern "C" */
#endif

#endif	/* __DDRT_H__ */


/*******************************************************************************
*                                                                              *
*      File fp.h   -   PowerPC and 68K Macintosh                               *
*                                                                              *
*      A collection of numerical functions designed to facilitate a wide       *
*      range of numerical programming. It is modeled after the Floating-Point  *
*      C Extensions (FPCE) proposed technical draft of the Numerical C         *
*      Extensions Group's requirements (NCEG / X3J11.1).                       *
*      The <fp.h> declares many functions in support of numerical programming. *
*      It provides a superset of <math.h> and <sane.h> functions.  Some        *
*      functionality previously found in <sane.h> and not in the FPCE <fp.h>   *
*      can be found in this <fp.h> under the heading "__NOEXTENSIONS__".       *
*                                                                              *
*      All of these functions are IEEE 754 aware and treat exceptions, NaNs,   *
*      positive and negative zero and infinity consistent with the floating-   *
*      point standard.                                                         *
*                                                                              *
*      Copyright © 1992-1995 Apple Computer, Inc.  All rights reserved.        *
*                                                                              *
*      Written by Ali Sazegari, started on July 1992,                          *
*      based on the file Numerics.h by Jim Thomas.                             *
*                                                                              *
*      October    27  1992: made changes for PowerPC, transfered some power    *
*                           functions to <faux.h>.                             *
*      October    30  1992: added long double data type for PowerPC and        *
*                           merged it with the Macintosh <fp.h>.               *
*      December   10  1992: changed logb, scalb, frexp and ldexp to            *
*                           LOGB, SCALB, FREXP and LDEXP to avoid collision    *
*                           with the ibm libc.                                 *
*      December   16  1992: changed the flag "powerpc" to "powerc"             *
*      February   17  1993: removed the typedefs and defrerred them to         *
*                           <Types.h>.                                         *
*      May        18  1993: added binary to decimal conversions for the        *
*                           PowerPC.                                           *
*      June       14  1993: added the long double decimal conversions, changed *
*                           the decimal conversion prototypes to double_t.     *
*      July       11  1993: changed the names of the long double bin2dec.      *
*      August     23  1993: included C++ extern "C" wrappers to make them C++  *
*                           friendly.                                          *
*      November   29  1993: corrected a spelling mistake in the comments.      *
*      February   22  1994: modf changed to double_t for 68K compatability PAF *
*      February   22  1994: Comment changes PAF                                *
*      April      26  1994: #define SIGDIGLEN 20 for 68K PAF                   *
*      April      28  1994: collected all powerpc specific calls, changed      *
*                           DECIMAL_DIG to 17.                                 *             
*      May         2  1994: Added dec2d prototype and function to fp68K.c      *
*      May         4  1994: Added #ifndef powerc prototype for trunc           *
*      June       23  1994: Changed __inf() prototype to double_t.             *
*	 January    17  1995: Remove C++ comments.  Use ConditionalMacros.h      *
*      March      29  1995: Added definitions for 68k based transfer functions *
*                           and MathLib v2 double to 68k long double transfer  *
*                           functions.  Corrected some comments.               *
*      October    11  1995: changed an #ifdef to #if in a macro definition.    *
*                                                                              *
*******************************************************************************/

#ifndef __FP__
#define __FP__

/*      efficient types are included in Types.h.                              */

#ifndef __TYPES__
#include <Types.h>
#endif

/*******************************************************************************
*                              Define some constants.                          *
*******************************************************************************/

#if	      GENERATINGPOWERPC
#define      LONG_DOUBLE_SIZE         16
#elif       GENERATING68881
#define      LONG_DOUBLE_SIZE         12
#else
#define      LONG_DOUBLE_SIZE         10
#endif  

#define      DOUBLE_SIZE               8      

#define      HUGE_VAL                  __inf()
#define      INFINITY                  __inf()
#define      NAN                        nan("255")

/*    the macro DECIMAL_DIG is obtained by satisfying the constraint that the
      conversion from double to decimal and back is the identity function.   */

#if          GENERATINGPOWERPC
#define      DECIMAL_DIG              17 /* does not exist for double-double */
#else
#define      DECIMAL_DIG              21
#endif      

#ifdef __cplusplus
extern "C" {
#endif
/*******************************************************************************
*                            Trigonometric functions                           *
*******************************************************************************/

double_t cos ( double_t x );
double_t sin ( double_t x );
double_t tan ( double_t x );

double_t acos ( double_t x );                /*  result is in [0,pi]          */
double_t asin ( double_t x );                /*  result is in [-pi/2,pi/2]    */
double_t atan ( double_t x );                /*  result is in [-pi/2,pi/2]    */

/*    atan2 computes the arc tangent of y/x in [-pi,pi] using the sign of
      both arguments to determine the quadrant of the computed value.         */

double_t atan2 ( double_t y, double_t x );

/*******************************************************************************
*                              Hyperbolic functions                            *
*******************************************************************************/

double_t cosh ( double_t x );
double_t sinh ( double_t x );
double_t tanh ( double_t x );

double_t acosh ( double_t x );
double_t asinh ( double_t x );
double_t atanh ( double_t x );

/*******************************************************************************
*                              Exponential functions                           *
*******************************************************************************/

double_t exp ( double_t x );

/*    expm1 computes the base e exponential of the argument minus 1,
      i. e., exp(x) - 1.  For small enough arguments, expm1 is expected
      to be more accurate than the straight forward computation of exp(x) - 1.*/

double_t expm1  ( double_t x );
double_t exp2  ( double_t x );

double_t frexp ( double_t x, int *exponent );
double_t ldexp ( double_t x, int n );

double_t log ( double_t x );
double_t log2 ( double_t x );

/*    log1p computes the base e logorithm of 1 plus the argument,
      i. e., log (1+x).  For small enough arguments, log1p is expected
      to be more accurate than the straightforward computation of log (1+x).  */

double_t log1p ( double_t x );
double_t log10 ( double_t x ); 

/*    logb extracts the exponent of its argument, as a signed integral
      value. A subnormal argument is treated as though it were first
      normalized. Thus

      1 <= x * 2^( - Logb ( x ) ) < 2                                         */

double_t logb ( double_t x );

long double modfl ( long double x, long double *iptrl );
double_t    modf  ( double_t x, double_t *iptr );  /* <- note NCEG difference */
float       modff ( float x, float *iptrf );

/*    scalb computes x * 2^n efficently.  This is not normally done by
      computing 2^n explicitly.                                               */

double_t scalb ( double_t x, long int n ); 

/*******************************************************************************
*                     Power and absolute value functions                       *
*******************************************************************************/

double_t fabs ( double_t x );

/*    hypot computes the square root of the sum of the squares of its
      arguments, without undue overflow or underflow.                         */

double_t hypot ( double_t x, double_t y );
double_t pow   ( double_t x, double_t y );
double_t sqrt  ( double_t x );

/*******************************************************************************
*                        Gamma and Error functions                             *
*******************************************************************************/

double_t erf  ( double_t x );            /*   the error function              */
double_t erfc ( double_t x );            /*   complementary error function    */

double_t gamma ( double_t x );

/*    lgamma computes the base-e logarithm of the absolute value of
      gamma of its argument x, for x > 0.                                     */

double_t lgamma ( double_t x );

/*******************************************************************************
*                        Nearest integer functions                             *
*******************************************************************************/

double_t ceil  ( double_t x );
double_t floor ( double_t x ); 

/*    the rint function rounds its argument to an integral value in floating
      point format, honoring the current rounding direction.                  */

double_t rint ( double_t x );

/*    nearbyint differs from rint only in that it does not raise the
      inexact exception. It is the nearbyint function recommended by the
      IEEE floating-point standard 854.                                       */

double_t nearbyint ( double_t x );

/*    the function rinttol rounds its argument to the nearest long int using
      the current rounding direction.
      >>Note that if the rounded value is outside the range of long int, then
      the result is undefined.                                                */

long int rinttol ( double_t x );

/*    the round function rounds the argument to the nearest integral value
      in double format similar to the Fortran "anint" function.  That is:
      add half to the magnitude and chop.                                     */

double_t round ( double_t x );

/*    roundtol is similar to the Fortran function nint or to the Pascal round
      >>Note that if the rounded value is outside the range of long int, then
      the result is undefined.                                                */

long int roundtol ( double_t round );

/*    trunc computes the integral value, in floating format, nearest to
      but no larger in magnitude than its argument.                           */

#if  GENERATING68K
/* necessary because trunc is implicitly declared this way when -elems881 is set */
int      trunc ( double_t x );      /*  Round to integer in direction of zero */
#else
double_t trunc ( double_t x );
#endif

/*******************************************************************************
*                            Remainder functions                               *
*******************************************************************************/

double_t fmod ( double_t x, double_t y );

/*    the following two functions compute the remainder.  remainder is required
      by the IEEE 754 floating point standard. The second form correponds to the
      SANE remainder; it stores into 'quotient' the 7 low-order bits of the
      integer quotient x/y, such that -127 <= quotient <= 127.                */

double_t remainder ( double_t x, double_t y );
double_t remquo    ( double_t x, double_t y, int *quo );

/*******************************************************************************
*                             Auxiliary functions                              *
*******************************************************************************/

/*    copysign produces a value with the magnitude of its first argument
      and sign of its second argument. NOTE: the order of the arguments
      matches the recommendation of the IEEE 754 floating point standard,
      which is opposite from the SANE copysign function.                      */

double_t copysign ( double_t x, double_t y );

/*    the call 'nan ( "n-char-sequence" )' returns a quiet NaN with content
      indicated through tagp in the selected data type format.                */

long double nanl ( const char *tagp );
double      nan  ( const char *tagp );
float       nanf ( const char *tagp );

/*    these compute the next representable value, in the type indicated,
      after 'x' in the direction of 'y'.  if x == y then y is returned.       */

long double nextafterl ( long double x, long double y );
double      nextafterd ( double x, double y );
float       nextafterf ( float x, float y );

/*******************************************************************************
*                              Inquiry macros                                  *
*******************************************************************************/

enum NumberKind
            {
            FP_SNAN = 0,        /*      signaling NaN                         */
            FP_QNAN,            /*      quiet NaN                             */
            FP_INFINITE,        /*      + or - infinity                       */
            FP_ZERO,            /*      + or - zero                           */
            FP_NORMAL,          /*      all normal numbers                    */
            FP_SUBNORMAL        /*      denormal numbers                      */
            };

#define      fpclassify(x)    ( ( sizeof ( x ) == LONG_DOUBLE_SIZE ) ?         \
                              __fpclassify  ( x ) :                            \
                                ( sizeof ( x ) == DOUBLE_SIZE ) ?              \
                              __fpclassifyd ( x ) :                            \
                              __fpclassifyf ( x ) )

/*    isnormal is non-zero if and only if the argument x is normalized.       */

#define      isnormal(x)      ( ( sizeof ( x ) == LONG_DOUBLE_SIZE ) ?         \
                              __isnormal ( x ) :                               \
                                ( sizeof ( x ) == DOUBLE_SIZE ) ?              \
                              __isnormald ( x ) :                              \
                              __isnormalf ( x ) )

/*    isfinite is non-zero if and only if the argument x is finite.           */

#define      isfinite(x)      ( ( sizeof ( x ) == LONG_DOUBLE_SIZE ) ?         \
                              __isfinite ( x ) :                               \
                                ( sizeof ( x ) == DOUBLE_SIZE ) ?              \
                              __isfinited ( x ) :                              \
                              __isfinitef ( x ) )

/*    isnan is non-zero if and only if the argument x is a NaN.               */

#define      isnan(x)         ( ( sizeof ( x ) == LONG_DOUBLE_SIZE ) ?         \
                              __isnan ( x ) :                                  \
                              ( sizeof ( x ) == DOUBLE_SIZE ) ?                \
                              __isnand ( x ) :                                 \
                              __isnanf ( x ) )

/*    signbit is non-zero if and only if the sign of the argument x is
      negative. this includes, NaNs, infinities and zeros.                    */

#define      signbit(x)       ( ( sizeof ( x ) == LONG_DOUBLE_SIZE ) ?         \
                              __signbit ( x ) :                                \
                              ( sizeof ( x ) == DOUBLE_SIZE ) ?                \
                              __signbitd ( x ) :                               \
                              __signbitf ( x ) )

/*******************************************************************************
*                      Max, Min and Positive Difference                        *
*******************************************************************************/

/*    These extension functions correspond to the standard functions, dim
      max and min.

      The fdim function determines the 'positive difference' between its
      arguments: { x - y, if x > y }, { +0, if x <= y }.  If one argument is
      NaN, then fdim returns that NaN.  if both arguments are NaNs, then fdim
      returns the first argument.                                             */

double_t fdim ( double_t x, double_t y );

/*    max and min return the maximum and minimum of their two arguments,
      respectively.  They correspond to the max and min functions in FORTRAN.
      NaN arguments are treated as missing data.  If one argument is NaN and
      the other is a number, then the number is returned.  If both are NaNs
      then the first argument is returned.                                    */

double_t fmax ( double_t x, double_t y );
double_t fmin ( double_t x, double_t y );

/*******************************************************************************
*                                Constants                                     *
*******************************************************************************/

extern const double_t pi;

/*******************************************************************************
*                              Internal prototypes                             *
*******************************************************************************/

long int __fpclassify  ( long double x ); 
long int __fpclassifyd ( double x );
long int __fpclassifyf ( float x );

long int __isnormal  ( long double x );
long int __isnormald ( double x );
long int __isnormalf ( float x );

long int __isfinite  ( long double x );
long int __isfinited ( double x );
long int __isfinitef ( float x );

long int __isnan  ( long double x );
long int __isnand ( double x );
long int __isnanf ( float x );

long int __signbit  ( long double x );
long int __signbitd ( double x );
long int __signbitf ( float x );

double_t __inf ( void );

/*******************************************************************************
*                              Non NCEG extensions                             *
*******************************************************************************/

#ifndef __NOEXTENSIONS__

/*******************************************************************************
*                              Financial functions                             *
*******************************************************************************/

/*    compound computes the compound interest factor "(1 + rate) ^ periods"
      more accurately than the straightforward computation with the Power
      function.  This is SANE's compound function.                            */

double_t compound ( double_t rate, double_t periods );

/*    The function annuity computes the present value factor for an annuity 
      "( 1 - ( 1 + rate ) ^ ( - periods ) ) / rate" more accurately than the
      straightforward computation with the Power function. This is SANE's 
      annuity function.                                                       */

double_t annuity ( double_t rate, double_t periods );

/*******************************************************************************
*                              Random function                                 *
*******************************************************************************/

double_t randomx ( double_t *x );

/*******************************************************************************
*                              Relational operator                             *
*******************************************************************************/

typedef short relop;                         /*      relational operator      */

enum 
      {
      GREATERTHAN = ( ( relop ) ( 0 ) ),
      LESSTHAN,
      EQUALTO,
      UNORDERED
      };

relop relation ( double_t x, double_t y );

/*******************************************************************************
*                         Binary to decimal conversions                        *
*******************************************************************************/

#if    GENERATINGPOWERPC
#define      SIGDIGLEN      36               /*    significant decimal digits */
#else
#define      SIGDIGLEN      20               /*    significant decimal digits */
#endif

#define      DECSTROUTLEN   80               /* max length for dec2str output */
#define      FLOATDECIMAL   ((char)(0))
#define      FIXEDDECIMAL   ((char)(1))

/*    The decimal record type provides an intermediate unpacked form for
      programmers who wish to do their own parsing of numeric input or
      formatting of numeric output.                                           */
	
struct decimal 
     {
      char sgn;                              /*         sign 0 for +, 1 for - */
      char unused;
      short exp;                             /*              decimal exponent */
      struct
            {
            unsigned char length;
            unsigned char text[SIGDIGLEN];   /*            significant digits */
            unsigned char unused;
            }sig;
      };

typedef struct decimal decimal;

/*    Each conversion to a decimal string is controlled by a decform
      structure.  The style is either FLOATDECIMAL or FIXEDDECIMAL defined
      above.  The value of digits is the number of significant digits for
      FLOATDECIMAL.  The value of digits for FIXEDDECIMAL is the number of
      digits to the right of the decimal point.                               */

struct decform 
      {
      char style;                            /*  FLOATDECIMAL or FIXEDDECIMAL */
      char unused;
      short digits;
      };

typedef struct decform decform;

/*    Each conversion to a decimal record d via the function call num2dec is 
      controlled by a decform record f (defined earlier), to a double_t x.    */

void num2dec ( const decform *f, double_t x, decimal *d );

/*    dec2num converts a decimal record d to a double_t value.                */

double_t dec2num ( const decimal *d );

/*    The MathLib formatter dec2str is controlled by a decform f.  Input d is
      a decimal record.                                                       */

void dec2str ( const decform *f, const decimal *d, char *s );

/*    The function str2dec is the MathLib scanner.                            */

void str2dec ( const char *s, short *ix, decimal *d, short *vp ); 

/*    dec2d is similar to dec2num except a double is returned on 68k platforms*/

#if  GENERATING68K
double dec2d ( const decimal *d );
#endif

/*    dec2f is similar to dec2num except a float is returned.                 */

float dec2f ( const decimal *d );

/*    dec2s is similar to dec2num except a short is returned.                 */

short int dec2s ( const decimal *d );

/*    dec2l is similar to dec2num except a long is returned.                  */

long int dec2l  ( const decimal *d );

/*******************************************************************************
*                    68k-only Transfer Function Prototypes                     *
*******************************************************************************/

#if GENERATING68K
#if GENERATING68881

void x96tox80 ( const long double *x, extended80 *x80 );
void x80tox96 ( const extended80 *x80, long double *x );

#else

void x96tox80 ( const extended96 *x96, long double *x );
void x80tox96 ( const long double *x, extended96 *x96 );

#endif      /* GENERATING68881   */
#endif      /* GENERATING68K */

#endif      /* __NOEXTENSIONS__ */

/*******************************************************************************
*                         PowerPC-only Function Prototypes                     *
*******************************************************************************/

#if  GENERATINGPOWERPC

long double cosl ( long double x );
long double sinl ( long double x );
long double tanl ( long double x );

long double acosl ( long double x );          /*  result is in [0,pi]         */
long double asinl ( long double x );          /*  result is in [-pi/2,pi/2]   */
long double atanl ( long double x );          /*  result is in [-pi/2,pi/2]   */
long double atan2l ( long double y, long double x );

long double coshl ( long double x );
long double sinhl ( long double x );
long double tanhl ( long double x );

long double acoshl ( long double x );
long double asinhl ( long double x );
long double atanhl ( long double x );

long double expl ( long double x );
long double expm1l ( long double x );
long double exp2l  ( long double x );

long double frexpl ( long double x, int *exponent );
long double ldexpl ( long double x, int n );

long double logl ( long double x );
long double log1pl ( long double x );
long double log10l ( long double x ); 
long double log2l ( long double x );

long double logbl ( long double x );
long double scalbl ( long double x, long int n ); 

long double fabsl ( long double x );
long double hypotl ( long double x, long double y );
long double powl   ( long double x, long double y );
long double sqrtl  ( long double x );

long double erfl  ( long double x );     /*   the error function              */
long double erfcl ( long double x );     /*   complementary error function    */
long double gammal ( long double x );
long double lgammal ( long double x );

long double ceill  ( long double x );
long double floorl ( long double x );
long double rintl ( long double x );
long double nearbyintl ( long double x );
long int rinttoll ( long double x );
long double roundl ( long double x );
long int roundtoll ( long double round );
long double truncl ( long double x );
long double remainderl ( long double x, long double y );
long double remquol    ( long double x, long double y, int *quo );
long double copysignl ( long double x, long double y );
long double fdiml ( long double x, long double y );
long double fmaxl ( long double x, long double y );
long double fminl ( long double x, long double y );

#ifndef __NOEXTENSIONS__

relop relationl ( long double x, long double y );
void x80told ( const extended80 *x80, long double *x );
void ldtox80 ( const long double *x, extended80 *x80 );

/*    MathLib v2 has two new transfer functions: x80tod and dtox80.  They can 
      be used to directly transform 68k 80-bit extended data types to double
      and back for PowerPC based machines without using the functions
      x80told or ldtox80.  Double rounding may occur.                         */

double x80tod ( const extended80 *x80 );
void dtox80   ( const double *x, extended80 *x80 );

void num2decl ( const decform *f, long double x, decimal *d );
long double dec2numl ( const decimal *d );

#endif      /* __NOEXTENSIONS__ */

#endif      /* GENERATINGPOWERPC  */

#ifdef __cplusplus
}
#endif

#endif      /* __FP__          */

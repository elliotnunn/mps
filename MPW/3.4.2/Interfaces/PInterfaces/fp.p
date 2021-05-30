{
 	File:		fp.p
 
 	Copyright:	© 1994-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Version:	Universal Pascal, March 29, 1995 
	
	Note:		The following file was hand converted from fp.h
				See fp.h for more information and comments.
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT fp;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FP__}
{$SETC __FP__ := 1}

{$I+}
{$SETC fpIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}

CONST
	DOUBLE_SIZE					= 8;

{$IFC GENERATINGPOWERPC }
	LONG_DOUBLE_SIZE			= 16;
	DECIMAL_DIG					= 17;  { does not exist for double-double }
{$ELSEC}
	DECIMAL_DIG					= 21;
{$IFC GENERATING68881}
	LONG_DOUBLE_SIZE			= 12;
{$ELSEC}
	LONG_DOUBLE_SIZE			= 10;
{$ENDC}
{$ENDC}

(*******************************************************************************
*                            Trigonometric functions                           *
*******************************************************************************)


FUNCTION cos(x: double_t): double_t; C;
FUNCTION sin(x: double_t): double_t; C;
FUNCTION tan(x: double_t): double_t; C;

FUNCTION acos(x: double_t): double_t; C;	{  result is in [0,pi]          }
FUNCTION asin(x: double_t): double_t; C;	{  result is in [-pi/2,pi/2]    }
FUNCTION atan(x: double_t): double_t; C;	{  result is in [-pi/2,pi/2]    }

{    atan2 computes the arc tangent of y/x in [-pi,pi] using the sign of
      both arguments to determine the quadrant of the computed value.         }
FUNCTION atan2(y: double_t; x: double_t): double_t; C;


(*******************************************************************************
*                              Hyperbolic functions                            *
*******************************************************************************)

FUNCTION cosh(x: double_t): double_t; C;
FUNCTION sinh(x: double_t): double_t; C;
FUNCTION tanh(x: double_t): double_t; C;
FUNCTION acosh(x: double_t): double_t; C;
FUNCTION asinh(x: double_t): double_t; C;
FUNCTION atanh(x: double_t): double_t; C;

(*******************************************************************************
*                              Exponential functions                           *
*******************************************************************************)

FUNCTION exp(x: double_t): double_t; C;

{    expm1 computes the base e exponential of the argument minus 1,
      i. e., exp(x) - 1.  For small enough arguments, expm1 is expected
      to be more accurate than the straight forward computation of exp(x) - 1.}
FUNCTION expm1(x: double_t): double_t; C;

{      exp2 computes the base 2 exponential.                                 }
FUNCTION exp2(x: double_t): double_t; C;
FUNCTION frexp(x: double_t; VAR exponent: LONGINT): double_t; C;
FUNCTION ldexp(x: double_t; n: LONGINT): double_t; C;
FUNCTION log(x: double_t): double_t; C;

{      log2 computes the base 2 logarithm.                                   }
FUNCTION log2(x: double_t): double_t; C;

{    log1p computes the base e logorithm of 1 plus the argument,
      i. e., log (1 x).  For small enough arguments, log1p is expected
      to be more accurate than the straightforward computation of log (1+x).  }
FUNCTION log1p(x: double_t): double_t; C;
FUNCTION log10(x: double_t): double_t; C;

{    logb extracts the exponent of its argument, as a signed integral
      value. A subnormal argument is treated as though it were first
      normalized. Thus

      1 <= x  2^( - Logb ( x ) ) < 2                                         }
FUNCTION logb(x: double_t): double_t; C;
FUNCTION modf(x: Double; VAR iptr: Double): Double; C;
FUNCTION modff(x: Single; VAR iptrf: Single): Single; C;

{    scalb computes x  2^n efficently.  This is not normally done by
      computing 2^n explicitly.                                               }
FUNCTION scalb(x: double_t; n: LONGINT): double_t; C;

(*******************************************************************************
*                     Power and absolute value functions                       *
*******************************************************************************)

FUNCTION fabs(x: double_t): double_t; C;

{    hypot computes the square root of the sum of the squares of its
      arguments, without undue overflow or underflow.                         }
FUNCTION hypot(x: double_t; y: double_t): double_t; C;
FUNCTION pow(x: double_t; y: double_t): double_t; C;
FUNCTION sqrt(x: double_t): double_t; C;

(*******************************************************************************
*                        Gamma and Error functions                             *
*******************************************************************************)

FUNCTION erf(x: double_t): double_t; C;
FUNCTION erfc(x: double_t): double_t; C;	{   complementary error function   }

FUNCTION gamma(x: double_t): double_t; C;

{    lgamma computes the base-e logarithm of the absolute value of
      gamma of its argument x, for x > 0.                                     }
FUNCTION lgamma(x: double_t): double_t; C;

(*******************************************************************************
*                        Nearest integer functions                             *
*******************************************************************************)

FUNCTION ceil(x: double_t): double_t; C;
FUNCTION floor(x: double_t): double_t; C;

{    the rint function rounds its argument to an integral value in floating
      point format, honoring the current rounding direction.                  }
FUNCTION rint(x: double_t): double_t; C;

{    nearbyint differs from rint only in that it does not raise the
      inexact exception. It is the nearbyint function recommended by the
      IEEE floating-point standard 854.                                       }
FUNCTION nearbyint(x: double_t): double_t; C;

{    the function rinttol rounds its argument to the nearest long using
      the current rounding direction.
      >>Note that if the rounded value is outside the range of long, then
      the result is undefined.                                                }
FUNCTION rinttol(x: double_t): LONGINT; C;

{    the round function rounds the argument to the nearest integral value
      in double format similar to the Fortran "anint" function.  That is:
      add half to the magnitude and chop.                                     }
FUNCTION round(x: double_t): double_t; C;

{    roundtol is similar to the Fortran function nint or to the Pascal round
      >>Note that if the rounded value is outside the range of long, then
      the result is undefined.                                                }
FUNCTION roundtol(round: double_t): LONGINT; C;

{    trunc computes the integral value, in floating format, nearest to
      but no larger in magnitude than its argument.                           }
FUNCTION trunc(x: double_t): double_t; C;

(*******************************************************************************
*                            Remainder functions                               *
*******************************************************************************)

FUNCTION fmod(x: double_t; y: double_t): double_t; C;

{    the following two functions compute the remainder.  remainder is required
      by the IEEE 754 floating point standard. The second form correponds to the
      SANE remainder; it stores into 'quotient' the 7 low-order bits of the
      integer quotient x/y, such that -127 <= quotient <= 127.                }
FUNCTION remainder(x: double_t; y: double_t): double_t; C;
FUNCTION remquo(x: double_t; y: double_t; VAR quo: LONGINT): double_t; C;


(*******************************************************************************
*                             Auxiliary functions                              *
*******************************************************************************)

FUNCTION copysign(x: double_t; y: double_t): double_t; C;
FUNCTION nan(tagp: ConstCStringPtr): Double; C;
FUNCTION nanf(tagp: ConstCStringPtr): Single; C;

FUNCTION nextafterd(x: Double; y: Double): Double; C;
FUNCTION nextafterf(x: Single; y: Single): Single; C;

(*******************************************************************************
*                      Max, Min and Positive Difference                        *
*******************************************************************************)

{     These extension functions correspond to the standard functions, dim
      max and min.

      The fdim function determines the 'positive difference' between its
      arguments: ( x - y, if x > y ), ( +0, if x <= y ).  If one argument is
      NaN, then fdim returns that NaN.  if both arguments are NaNs, then fdim
      returns the first argument.                                             }
FUNCTION fdim(x: double_t; y: double_t): double_t; C;

{    max and min return the maximum and minimum of their two arguments,
      respectively.  They correspond to the max and min functions in FORTRAN.
      NaN arguments are treated as missing data.  If one argument is NaN and
      the other is a number, then the number is returned.  If both are NaNs
      then the first argument is returned.                                    }
FUNCTION fmax(x: double_t; y: double_t): double_t; C;
FUNCTION fmin(x: double_t; y: double_t): double_t; C;

(*******************************************************************************
*                              Inquiry functions                               *
*******************************************************************************)

CONST
	FP_SNAN 	= 0;        {      signaling NaN                         }
	FP_QNAN 	= 1;        {      quiet NaN                             }
	FP_INFINITE = 2;        {      + or - infinity                       }
	FP_ZERO		= 3;        {      + or - zero                           }
	FP_NORMAL	= 4;        {      all normal numbers                    }
	FP_SUBNORMA = 5;        {      denormal numbers                      }


FUNCTION __fpclassifyd(x: Double): LONGINT; C;
FUNCTION __fpclassifyf(x: Single): LONGINT; C;

FUNCTION __isnormald(x: Double) : LONGINT; C;
FUNCTION __isnormalf(x: Single): LONGINT; C;

FUNCTION __isfinited(x: Double): LONGINT; C;
FUNCTION __isfinitef(x: Single): LONGINT; C;

FUNCTION __isnand(x: Double): LONGINT; C;
FUNCTION __isnanf(x: Single): LONGINT; C;

FUNCTION __signbitd(x: Double): LONGINT; C;
FUNCTION __signbitf(x: Single): LONGINT; C;

FUNCTION __inf: Double;


(*******************************************************************************
*                              Non NCEG extensions                             *
*******************************************************************************)


{$IFC UNDEFINED __NOEXTENSIONS__ }

(*******************************************************************************
*                              Financial functions                             *
*******************************************************************************)

{     compound computes the compound interest factor "(1 + rate) ^ periods"
      more accurately than the straightforward computation with the Power
      function.  This is SANE's compound function.                            }
FUNCTION compound(rate: double_t; periods: double_t): double_t; C;

{    The function annuity computes the present value factor for an annuity 
      "( 1 - ( 1 + rate ) ^ ( - periods ) ) / rate" more accurately than the
      straightforward computation with the Power function. This is SANE's 
      annuity function.                                                       }
FUNCTION annuity(rate: double_t; periods: double_t): double_t; C;

(*******************************************************************************
*                              Random function                                 *
*******************************************************************************)

FUNCTION randomx(VAR x: double_t): double_t; C;


(*******************************************************************************
*                              Relational operator                             *
*******************************************************************************)

TYPE
	relop = INTEGER;		{      relational operator      }

CONST
	GREATERTHAN					= 0;
	LESSTHAN					= 1;
	EQUALTO						= 2;
	UNORDERED					= 3;


FUNCTION relation(x: double_t; y: double_t): relop; C;



(*******************************************************************************
*                         Binary to decimal conversions                        *
*******************************************************************************)

CONST
{$IFC GENERATINGPOWERPC }
	SIGDIGLEN					= 36;					{ significant decimal digits }
{$ELSEC}
	SIGDIGLEN					= 20;					{ significant decimal digits }
{$ENDC}
	DECSTROUTLEN				= 80;					{ max length for dec2str output }

TYPE
	DecimalKind = (FloatDecimal,FixedDecimal);

{     The decimal record type provides an intermediate unpacked form for
      programmers who wish to do their own parsing of numeric input or
      formatting of numeric output.                                         }
	
	{$ALIGN MAC68K}
	Decimal = RECORD
		sgn: 	0..1;			{ sign 0 for +, 1 for -  }
		exp: 	INTEGER;
		sig: 	STRING[SIGDIGLEN];
	END;
	{$ALIGN RESET}

{    Each conversion to a decimal string is controlled by a decform
      structure.  The style is either FLOATDECIMAL or FIXEDDECIMAL defined
      above.  The value of digits is the number of significant digits for
      FLOATDECIMAL.  The value of digits for FIXEDDECIMAL is the number of
      digits to the right of the decimal point.                               }
	  
	{$ALIGN MAC68K}
	Decform = RECORD
		style: 	DecimalKind;
		digits: INTEGER;
	END;
	{$ALIGN RESET}
	
{    Each conversion to a decimal record d via the function call num2dec is 
      controlled by a decform record f (defined earlier), to a double_t x.    }
PROCEDURE num2dec({CONST}VAR f: Decform; x: double_t; VAR d: decimal); C;


{ dec2num converts a decimal record d to a double_t value.          }
FUNCTION dec2num({CONST}VAR d: Decimal): double_t; C;

{    The MathLib formatter dec2str is controlled by a decform f.  Input d is
      a decimal record.                                                       }
PROCEDURE dec2str({CONST}VAR f: Decform; {CONST}VAR d: Decimal; s: CStringPtr); C;

{    The function str2dec is the MathLib scanner.                            }
PROCEDURE str2dec(s: ConstCStringPtr; VAR ix: INTEGER; VAR d: Decimal; VAR vp: INTEGER); C;

{$IFC GENERATING68K }
{    dec2d is similar to dec2num except a double is returned on 68k platforms }
FUNCTION dec2d({CONST}VAR d: Decimal): Double; C;
{$ENDC}

{    dec2f is similar to dec2num except a float is returned.                 }
FUNCTION dec2f({CONST}VAR d: Decimal): Single; C;

{    dec2s is similar to dec2num except a short is returned.                 }
FUNCTION dec2s({CONST}VAR d: Decimal): INTEGER; C;

{    dec2l is similar to dec2num except a long is returned.                  }
FUNCTION dec2l({CONST}VAR d: Decimal): LONGINT; C;

(*******************************************************************************
*                    68k-only Transfer Function Prototypes                     *
*******************************************************************************)

{$IFC GENERATING68K }

PROCEDURE x96tox80({CONST}VAR x96: extended96; VAR x80: extended80); C;
PROCEDURE x80tox96({CONST}VAR x80: extended80; VAR x96: extended96); C;

{$ENDC}     { GENERATING68K }


{$ENDC} {__NOEXTENSIONS__}

(*******************************************************************************
*                         PowerPC-only Function Prototypes                     *
*******************************************************************************)

{$IFC GENERATINGPOWERPC }
FUNCTION cosl(x: LongDouble): LongDouble; C;
FUNCTION sinl(x: LongDouble): LongDouble; C;
FUNCTION tanl(x: LongDouble): LongDouble; C;

FUNCTION acosl(x: LongDouble): LongDouble; C;
FUNCTION asinl(x: LongDouble): LongDouble; C;
FUNCTION atanl(x: LongDouble): LongDouble; C;
FUNCTION atan2l(y: LongDouble; x: LongDouble): LongDouble; C;

FUNCTION coshl(x: LongDouble): LongDouble; C;
FUNCTION sinhl(x: LongDouble): LongDouble; C;
FUNCTION tanhl(x: LongDouble): LongDouble; C;

FUNCTION acoshl(x: LongDouble): LongDouble; C;
FUNCTION asinhl(x: LongDouble): LongDouble; C;
FUNCTION atanhl(x: LongDouble): LongDouble; C;

FUNCTION expl(x: LongDouble): LongDouble; C;
FUNCTION expm1l(x: LongDouble): LongDouble; C;
FUNCTION exp2l(x: LongDouble): LongDouble; C;

FUNCTION frexpl(x: LongDouble; VAR exponent: LONGINT): LongDouble; C;
FUNCTION ldexpl(x: LongDouble; n: LONGINT): LongDouble; C;

FUNCTION logl(x: LongDouble): LongDouble; C;
FUNCTION log1pl(x: LongDouble): LongDouble; C;
FUNCTION log10l(x: LongDouble): LongDouble; C;
FUNCTION log2l(x: LongDouble): LongDouble; C;

FUNCTION logbl(x: LongDouble): LongDouble; C;
FUNCTION scalbl(x: LongDouble; n: LONGINT): LongDouble; C;

FUNCTION fabsl(x: LongDouble): LongDouble; C;
FUNCTION hypotl(x: LongDouble; y: LongDouble): LongDouble; C;
FUNCTION powl(x: LongDouble; y: LongDouble): LongDouble; C;
FUNCTION sqrtl(x: LongDouble): LongDouble; C;

FUNCTION erfl(x: LongDouble): LongDouble; C;
FUNCTION erfcl(x: LongDouble): LongDouble; C;
FUNCTION gammal(x: LongDouble): LongDouble; C;
FUNCTION lgammal(x: LongDouble): LongDouble; C;

FUNCTION ceill(x: LongDouble): LongDouble; C;
FUNCTION floorl(x: LongDouble): LongDouble; C;
FUNCTION rintl(x: LongDouble): LongDouble; C;
FUNCTION nearbyintl(x: LongDouble): LongDouble; C;
FUNCTION rinttoll(x: LongDouble): LONGINT; C;
FUNCTION roundl(x: LongDouble): LongDouble; C;
FUNCTION roundtoll(round: LongDouble): LONGINT; C;
FUNCTION truncl(x: LongDouble): LongDouble; C;
FUNCTION remainderl(x: LongDouble; y: LongDouble): LongDouble; C;
FUNCTION remquol(x: LongDouble; y: LongDouble; VAR quo: LONGINT): LongDouble; C;
FUNCTION copysignl(x: LongDouble; y: LongDouble): LongDouble; C;
FUNCTION fdiml(x: LongDouble; y: LongDouble): LongDouble; C;
FUNCTION fmaxl(x: LongDouble; y: LongDouble): LongDouble; C;
FUNCTION fminl(x: LongDouble; y: LongDouble): LongDouble; C;

FUNCTION modfl(x: LongDouble; VAR iptrl: LongDouble): LongDouble; C;
FUNCTION nanl(tagp: ConstCStringPtr): LongDouble; C;
FUNCTION nextafterl(x: LongDouble; y: LongDouble): LongDouble; C;
FUNCTION __fpclassify(x: LongDouble): LONGINT; C;
FUNCTION __isnormal(x: LongDouble): LONGINT; C;
FUNCTION __isfinite(x: LongDouble): LONGINT; C;
FUNCTION __isnan(x: LongDouble): LONGINT; C;
FUNCTION __signbit(x: LongDouble): LONGINT; C;

{$IFC UNDEFINED __NOEXTENSIONS__ }
FUNCTION relationl(x: LongDouble; y: LongDouble): relop; C;
PROCEDURE x80told(x80: extended80; VAR x: LongDouble); C;
PROCEDURE ldtox80(x: LongDouble; VAR x80: extended80); C;

{    MathLib v2 has two new transfer functions: x80tod and dtox80.  They can 
      be used to directly transform 68k 80-bit extended data types to double
      and back for PowerPC based machines without using the functions
      x80told or ldtox80.  Double rounding may occur.                         
}
FUNCTION x80tod({CONST}VAR x80: extended80): Double; C;
PROCEDURE dtox80({CONST}VAR x: Double; VAR x80: extended80); C;

PROCEDURE num2decl({CONST}VAR f: Decform; x: LongDouble; VAR d: Decimal); C;
FUNCTION dec2numl({CONST}VAR d: Decimal): LongDouble; C;
{$ENDC} { __NOEXTENSIONS__ }

{$ENDC} { GENERATINGPOWERPC }



{$SETC UsingIncludes := fpIncludes}

{$ENDC} {__FP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

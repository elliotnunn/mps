{
     File:       fp.p
 
     Contains:   FPCE Floating-Point Definitions and Declarations.
 
     Version:    Technology: MathLib v2
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1987-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}

{*******************************************************************************
*                                                                               *
*    A collection of numerical functions designed to facilitate a wide          *
*    range of numerical programming as required by C9X.                         *
*                                                                               *
*    The <fp.h> declares many functions in support of numerical programming.    *
*    It provides a superset of <math.h> and <SANE.h> functions.  Some           *
*    functionality previously found in <SANE.h> and not in the FPCE <fp.h>      *
*    can be found in this <fp.h> under the heading "__NOEXTENSIONS__".          *
*                                                                               *
*    All of these functions are IEEE 754 aware and treat exceptions, NaNs,      *
*    positive and negative zero and infinity consistent with the floating-      *
*    point standard.                                                            *
*                                                                               *
*******************************************************************************}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{*******************************************************************************
*                                                                               *
*                            Efficient types                                    *
*                                                                               *
*    float_t         Most efficient type at least as wide as float              *
*    double_t        Most efficient type at least as wide as double             *
*                                                                               *
*      CPU            float_t(bits)                double_t(bits)               *
*    --------        -----------------            -----------------             *
*    PowerPC          float(32)                    double(64)                   *
*    68K              long double(80/96)           long double(80/96)           *
*    x86              double(64)                   double(64)                   *
*                                                                               *
*******************************************************************************}
{$IFC TARGET_CPU_PPC }

TYPE
	float_t								= Single;
	double_t							= Double;
{$ELSEC}
  {$IFC TARGET_CPU_68K }
TYPE
    float_t                             = extended;
    double_t                            = extended;
  {$ELSEC}
    {$IFC TARGET_CPU_X86 }

TYPE
	float_t								= Double;
	double_t							= Double;
    {$ELSEC}
      {$IFC TARGET_CPU_MIPS }

TYPE
	float_t								= Double;
	double_t							= Double;
      {$ELSEC}
        {$IFC TARGET_CPU_ALPHA }

TYPE
	float_t								= Double;
	double_t							= Double;
        {$ELSEC}
          {$IFC TARGET_CPU_SPARC }

TYPE
	float_t								= Double;
	double_t							= Double;
          {$ELSEC}
{ Unsupported CPU }
          {$ENDC}
        {$ENDC}
      {$ENDC}
    {$ENDC}
  {$ENDC}
{$ENDC}

{*******************************************************************************
*                                                                               *
*                              Define some constants.                           *
*                                                                               *
*    HUGE_VAL            IEEE 754 value of infinity.                            *
*    INFINITY            IEEE 754 value of infinity.                            *
*    NAN                 A generic NaN (Not A Number).                          *
*    DECIMAL_DIG         Satisfies the constraint that the conversion from      *
*                        double to decimal and back is the identity function.   *
*                                                                               *
*******************************************************************************}
CONST
{$IFC TARGET_CPU_PPC }
    DECIMAL_DIG                         = 17; 
{$ELSEC}
    DECIMAL_DIG                         = 21;
{$ENDC}
{$IFC TARGET_OS_MAC }
{*******************************************************************************
*                                                                               *
*                            Trigonometric functions                            *
*                                                                               *
*   acos        result is in [0,pi].                                            *
*   asin        result is in [-pi/2,pi/2].                                      *
*   atan        result is in [-pi/2,pi/2].                                      *
*   atan2       Computes the arc tangent of y/x in [-pi,pi] using the sign of   *
*               both arguments to determine the quadrant of the computed value. *
*                                                                               *
*******************************************************************************}
{
 *  cos()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION cos(x: double_t): double_t; C;

{
 *  sin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION sin(x: double_t): double_t; C;

{
 *  tan()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION tan(x: double_t): double_t; C;

{
 *  acos()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION acos(x: double_t): double_t; C;

{
 *  asin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION asin(x: double_t): double_t; C;

{
 *  atan()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION atan(x: double_t): double_t; C;

{
 *  atan2()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION atan2(y: double_t; x: double_t): double_t; C;



{*******************************************************************************
*                                                                               *
*                              Hyperbolic functions                             *
*                                                                               *
*******************************************************************************}
{
 *  cosh()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION cosh(x: double_t): double_t; C;

{
 *  sinh()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION sinh(x: double_t): double_t; C;

{
 *  tanh()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION tanh(x: double_t): double_t; C;

{
 *  acosh()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION acosh(x: double_t): double_t; C;

{
 *  asinh()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION asinh(x: double_t): double_t; C;

{
 *  atanh()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION atanh(x: double_t): double_t; C;



{*******************************************************************************
*                                                                               *
*                              Exponential functions                            *
*                                                                               *
*   expm1       expm1(x) = exp(x) - 1.  But, for small enough arguments,        *
*               expm1(x) is expected to be more accurate than exp(x) - 1.       *
*   frexp       Breaks a floating-point number into a normalized fraction       *
*               and an integral power of 2.  It stores the integer in the       *
*               object pointed by *exponent.                                    *
*   ldexp       Multiplies a floating-point number by an integer power of 2.    *
*   log1p       log1p = log(1 + x). But, for small enough arguments,            *
*               log1p is expected to be more accurate than log(1 + x).          *
*   logb        Extracts the exponent of its argument, as a signed integral     *
*               value. A subnormal argument is treated as though it were first  *
*               normalized. Thus:                                               *
*                                  1   <=   x * 2^(-logb(x))   <   2            *
*   modf        Returns fractional part of x as function result and returns     *
*               integral part of x via iptr. Note C9X uses double not double_t. *
*   scalb       Computes x * 2^n efficently.  This is not normally done by      *
*               computing 2^n explicitly.                                       *
*                                                                               *
*******************************************************************************}
{
 *  exp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION exp(x: double_t): double_t; C;

{
 *  expm1()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION expm1(x: double_t): double_t; C;

{
 *  exp2()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION exp2(x: double_t): double_t; C;

{
 *  frexp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION frexp(x: double_t; VAR exponent: LONGINT): double_t; C;

{
 *  ldexp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ldexp(x: double_t; n: LONGINT): double_t; C;

{
 *  log()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION log(x: double_t): double_t; C;

{
 *  log2()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION log2(x: double_t): double_t; C;

{
 *  log1p()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION log1p(x: double_t): double_t; C;

{
 *  log10()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION log10(x: double_t): double_t; C;

{
 *  logb()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION logb(x: double_t): double_t; C;

{
 *  modf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION modf(x: double_t; VAR iptr: double_t): double_t; C;

{
 *  modff()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION modff(x: Single; VAR iptrf: Single): Single; C;


{
    Note: For compatiblity scalb(x,n) has n of type
            int  on Mac OS X 
            long on Mac OS
}

TYPE
	_scalb_n_type						= LONGINT;
	{
	 *  scalb()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in MathLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION scalb(x: double_t; n: _scalb_n_type): double_t; C;



{*******************************************************************************
*                                                                               *
*                     Power and absolute value functions                        *
*                                                                               *
*   hypot       Computes the square root of the sum of the squares of its       *
*               arguments, without undue overflow or underflow.                 *
*   pow         Returns x raised to the power of y.  Result is more accurate    *
*               than using exp(log(x)*y).                                       *
*                                                                               *
*******************************************************************************}
{
 *  fabs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION fabs(x: double_t): double_t; C;

{
 *  hypot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION hypot(x: double_t; y: double_t): double_t; C;

{
 *  pow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION pow(x: double_t; y: double_t): double_t; C;

{
 *  sqrt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION sqrt(x: double_t): double_t; C;



{*******************************************************************************
*                                                                               *
*                        Gamma and Error functions                              *
*                                                                               *
*   erf         The error function.                                             *
*   erfc        Complementary error function.                                   *
*   gamma       The gamma function.                                             *
*   lgamma      Computes the base-e logarithm of the absolute value of          *
*               gamma of its argument x, for x > 0.                             *
*                                                                               *
*******************************************************************************}
{
 *  erf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION erf(x: double_t): double_t; C;

{
 *  erfc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION erfc(x: double_t): double_t; C;

{
 *  gamma()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION gamma(x: double_t): double_t; C;

{
 *  lgamma()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION lgamma(x: double_t): double_t; C;



{*******************************************************************************
*                                                                               *
*                        Nearest integer functions                              *
*                                                                               *
*   rint        Rounds its argument to an integral value in floating point      *
*               format, honoring the current rounding direction.                *
*                                                                               *
*   nearbyint   Differs from rint only in that it does not raise the inexact    *
*               exception. It is the nearbyint function recommended by the      *
*               IEEE floating-point standard 854.                               *
*                                                                               *
*   rinttol     Rounds its argument to the nearest long int using the current   *
*               rounding direction.  NOTE: if the rounded value is outside      *
*               the range of long int, then the result is undefined.            *
*                                                                               *
*   round       Rounds the argument to the nearest integral value in floating   *
*               point format similar to the Fortran "anint" function. That is:  *
*               add half to the magnitude and chop.                             *
*                                                                               *
*   roundtol    Similar to the Fortran function nint or to the Pascal round.    *
*               NOTE: if the rounded value is outside the range of long int,    *
*               then the result is undefined.                                   *
*                                                                               *
*   trunc       Computes the integral value, in floating format, nearest to     *
*               but no larger in magnitude than its argument.   NOTE: on 68K    *
*               compilers when using -elems881, trunc must return an int        *
*                                                                               *
*******************************************************************************}
{
 *  ceil()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ceil(x: double_t): double_t; C;

{
 *  floor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION floor(x: double_t): double_t; C;

{
 *  rint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION rint(x: double_t): double_t; C;

{
 *  nearbyint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION nearbyint(x: double_t): double_t; C;

{
 *  rinttol()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION rinttol(x: double_t): LONGINT; C;

{
 *  round()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION round(x: double_t): double_t; C;

{
 *  roundtol()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION roundtol(round: double_t): LONGINT; C;

{
    Note: For compatiblity trunc(x) has a return type of
            int       for classic 68K with FPU enabled
            double_t  everywhere else
}
{$IFC TARGET_RT_MAC_68881 }

TYPE
	_trunc_return_type					= LONGINT;
{$ELSEC}

TYPE
	_trunc_return_type					= double_t;
{$ENDC}  {TARGET_RT_MAC_68881}
	{
	 *  trunc()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in MathLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION trunc(x: double_t): _trunc_return_type; C;




{*******************************************************************************
*                                                                               *
*                            Remainder functions                                *
*                                                                               *
*   remainder       IEEE 754 floating point standard for remainder.             *
*   remquo          SANE remainder.  It stores into 'quotient' the 7 low-order  *
*                   bits of the integer quotient x/y, such that:                *
*                       -127 <= quotient <= 127.                                *
*                                                                               *
*******************************************************************************}
{
 *  fmod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION fmod(x: double_t; y: double_t): double_t; C;

{
 *  remainder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION remainder(x: double_t; y: double_t): double_t; C;

{
 *  remquo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION remquo(x: double_t; y: double_t; VAR quo: LONGINT): double_t; C;



{*******************************************************************************
*                                                                               *
*                             Auxiliary functions                               *
*                                                                               *
*   copysign        Produces a value with the magnitude of its first argument   *
*                   and sign of its second argument.  NOTE: the order of the    *
*                   arguments matches the recommendation of the IEEE 754        *
*                   floating point standard,  which is opposite from the SANE   *
*                   copysign function.                                          *
*                                                                               *
*   nan             The call 'nan("n-char-sequence")' returns a quiet NaN       *
*                   with content indicated through tagp in the selected         *
*                   data type format.                                           *
*                                                                               *
*   nextafter       Computes the next representable value after 'x' in the      *
*                   direction of 'y'.  if x == y, then y is returned.           *
*                                                                               *
*******************************************************************************}
{
 *  copysign()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION copysign(x: double_t; y: double_t): double_t; C;

{
 *  nan()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION nan(tagp: ConstCStringPtr): Double; C;

{
 *  nanf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION nanf(tagp: ConstCStringPtr): Single; C;

{
 *  nextafterd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION nextafterd(x: Double; y: Double): Double; C;

{
 *  nextafterf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION nextafterf(x: Single; y: Single): Single; C;


{
 *  __fpclassifyd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION __fpclassifyd(x: Double): LONGINT; C;

{
 *  __fpclassifyf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION __fpclassifyf(x: Single): LONGINT; C;

{
 *  __isnormald()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION __isnormald(x: Double): LONGINT; C;

{
 *  __isnormalf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION __isnormalf(x: Single): LONGINT; C;

{
 *  __isfinited()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION __isfinited(x: Double): LONGINT; C;

{
 *  __isfinitef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION __isfinitef(x: Single): LONGINT; C;

{
 *  __isnand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION __isnand(x: Double): LONGINT; C;

{
 *  __isnanf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION __isnanf(x: Single): LONGINT; C;

{
 *  __signbitd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION __signbitd(x: Double): LONGINT; C;

{
 *  __signbitf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION __signbitf(x: Single): LONGINT; C;

{
 *  __inf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION __inf: double_t; C;



{*******************************************************************************
*                                                                               *
*                              Inquiry macros                                   *
*                                                                               *
*   fpclassify      Returns one of the FP_≈ values.                             *
*   isnormal        Non-zero if and only if the argument x is normalized.       *
*   isfinite        Non-zero if and only if the argument x is finite.           *
*   isnan           Non-zero if and only if the argument x is a NaN.            *
*   signbit         Non-zero if and only if the sign of the argument x is       *
*                   negative.  This includes, NaNs, infinities and zeros.       *
*                                                                               *
*******************************************************************************}

CONST
	FP_SNAN						= 0;							{       signaling NaN                          }
	FP_QNAN						= 1;							{       quiet NaN                              }
	FP_INFINITE					= 2;							{       + or - infinity                        }
	FP_ZERO						= 3;							{       + or - zero                            }
	FP_NORMAL					= 4;							{       all normal numbers                     }
	FP_SUBNORMAL				= 5;							{       denormal numbers                       }





	{	*******************************************************************************
	*                                                                               *
	*                      Max, Min and Positive Difference                         *
	*                                                                               *
	*   fdim        Determines the 'positive difference' between its arguments:     *
	*               ( x - y, if x > y ), ( +0, if x <= y ).  If one argument is     *
	*               NaN, then fdim returns that NaN.  if both arguments are NaNs,   *
	*               then fdim returns the first argument.                           *
	*                                                                               *
	*   fmax        Returns the maximum of the two arguments.  Corresponds to the   *
	*               max function in FORTRAN.  NaN arguments are treated as missing  *
	*               data.  If one argument is NaN and the other is a number, then   *
	*               the number is returned.  If both are NaNs then the first        *
	*               argument is returned.                                           *
	*                                                                               *
	*   fmin        Returns the minimum of the two arguments.  Corresponds to the   *
	*               min function in FORTRAN.  NaN arguments are treated as missing  *
	*               data.  If one argument is NaN and the other is a number, then   *
	*               the number is returned.  If both are NaNs then the first        *
	*               argument is returned.                                           *
	*                                                                               *
	*******************************************************************************	}
	{
	 *  fdim()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in MathLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION fdim(x: double_t; y: double_t): double_t; C;

{
 *  fmax()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION fmax(x: double_t; y: double_t): double_t; C;

{
 *  fmin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION fmin(x: double_t; y: double_t): double_t; C;


{******************************************************************************
*                                Constants                                     *
******************************************************************************}
{$IFC NOT UNDEFINED MWERKS}
    {$IFC MWERKS > $1500}
        CONST pi : double_t = 3.1415926535;
    {$ENDC}
{$ENDC}
{*******************************************************************************
*                                                                               *
*                              Non NCEG extensions                              *
*                                                                               *
*******************************************************************************}
{$IFC UNDEFINED __NOEXTENSIONS__ }
{*******************************************************************************
*                                                                               *
*                              Financial functions                              *
*                                                                               *
*   compound        Computes the compound interest factor "(1 + rate)^periods"  *
*                   more accurately than the straightforward computation with   *
*                   the Power function.  This is SANE's compound function.      *
*                                                                               *
*   annuity         Computes the present value factor for an annuity            *
*                   "(1 - (1 + rate)^(-periods)) /rate" more accurately than    *
*                   the straightforward computation with the Power function.    *
*                   This is SANE's annuity function.                            *
*                                                                               *
*******************************************************************************}
{
 *  compound()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION compound(rate: double_t; periods: double_t): double_t; C;

{
 *  annuity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION annuity(rate: double_t; periods: double_t): double_t; C;



{*******************************************************************************
*                                                                               *
*                              Random function                                  *
*                                                                               *
*   randomx         A pseudorandom number generator.  It uses the iteration:    *
*                               (7^5*x)mod(2^31-1)                              *
*                                                                               *
*******************************************************************************}
{
 *  randomx()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION randomx(VAR x: double_t): double_t; C;



{******************************************************************************
*                              Relational operator                             *
******************************************************************************}
{      relational operator      }

TYPE
	relop								= INTEGER;

CONST
	GREATERTHAN					= 0;
	LESSTHAN					= 1;
	EQUALTO						= 2;
	UNORDERED					= 3;

	{
	 *  relation()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in MathLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION relation(x: double_t; y: double_t): relop; C;



{*******************************************************************************
*                                                                               *
*                         Binary to decimal conversions                         *
*                                                                               *
*   SIGDIGLEN   Significant decimal digits.                                     *
*                                                                               *
*   decimal     A record which provides an intermediate unpacked form for       *
*               programmers who wish to do their own parsing of numeric input   *
*               or formatting of numeric output.                                *
*                                                                               *
*   decform     Controls each conversion to a decimal string.  The style field  *
*               is either FLOATDECIMAL or FIXEDDECIMAL. If FLOATDECIMAL, the    *
*               value of the field digits is the number of significant digits.  *
*               If FIXEDDECIMAL value of the field digits is the number of      *
*               digits to the right of the decimal point.                       *
*                                                                               *
*   num2dec     Converts a double_t to a decimal record using a decform.        *
*   dec2num     Converts a decimal record d to a double_t value.                *
*   dec2str     Converts a decform and decimal to a string using a decform.     *
*   str2dec     Converts a string to a decimal struct.                          *
*   dec2d       Similar to dec2num except a double is returned (68k only).      *
*   dec2f       Similar to dec2num except a float is returned.                  *
*   dec2s       Similar to dec2num except a short is returned.                  *
*   dec2l       Similar to dec2num except a long is returned.                   *
*                                                                               *
*******************************************************************************}
CONST
{$IFC TARGET_CPU_PPC }
    SIGDIGLEN                   = 36;
{$ELSEC}
    {$IFC TARGET_CPU_68K }
        SIGDIGLEN               = 20;
    {$ELSEC}
        {$IFC TARGET_CPU_X86 }
            SIGDIGLEN           = 20;
        {$ENDC}
    {$ENDC}
{$ENDC}
    DECSTROUTLEN                = 80;
TYPE
    DecimalKind = (FLOATDECIMAL, FIXEDDECIMAL);


    decimal = RECORD
        sgn:    0..1;           { sign 0 for +, 1 for -  }
        exp:    INTEGER;
        sig:    STRING[SIGDIGLEN];
    END;

    decform = RECORD
        style:  DecimalKind;
        digits: INTEGER;
    END;

{
 *  num2dec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE num2dec({CONST}VAR f: decform; x: double_t; VAR d: decimal); C;

{
 *  dec2num()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION dec2num({CONST}VAR d: decimal): double_t; C;

{
 *  dec2str()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE dec2str({CONST}VAR f: decform; {CONST}VAR d: decimal; s: CStringPtr); C;

{
 *  str2dec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE str2dec(s: ConstCStringPtr; VAR ix: INTEGER; VAR d: decimal; VAR vp: INTEGER); C;

{$IFC TARGET_CPU_68K }
{$IFC CALL_NOT_IN_CARBON }
{
 *  dec2d()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION dec2d({CONST}VAR d: decimal): Double; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_CPU_68K}
{
 *  dec2f()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION dec2f({CONST}VAR d: decimal): Single; C;

{
 *  dec2s()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION dec2s({CONST}VAR d: decimal): INTEGER; C;

{
 *  dec2l()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION dec2l({CONST}VAR d: decimal): LONGINT; C;




{*******************************************************************************
*                                                                               *
*                         68k-only Transfer Function Prototypes                 *
*                                                                               *
*******************************************************************************}
{$IFC TARGET_CPU_68K }
{$IFC CALL_NOT_IN_CARBON }
{
 *  x96tox80()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE x96tox80({CONST}VAR x: extended96; VAR x80: extended80); C;

{
 *  x80tox96()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE x80tox96({CONST}VAR x80: extended80; VAR x: extended96); C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_CPU_68K}
{$ENDC}
{*******************************************************************************
*                                                                               *
*                         PowerPC-only Function Prototypes                      *
*                                                                               *
*******************************************************************************}

{$IFC TARGET_CPU_PPC }

{
 *  cosl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION cosl(x: LongDouble): LongDouble; C;


{
 *  sinl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION sinl(x: LongDouble): LongDouble; C;


{
 *  tanl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION tanl(x: LongDouble): LongDouble; C;


{
 *  acosl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION acosl(x: LongDouble): LongDouble; C;


{
 *  asinl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION asinl(x: LongDouble): LongDouble; C;


{
 *  atanl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION atanl(x: LongDouble): LongDouble; C;


{
 *  atan2l()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION atan2l(y: LongDouble; x: LongDouble): LongDouble; C;


{
 *  coshl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION coshl(x: LongDouble): LongDouble; C;


{
 *  sinhl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION sinhl(x: LongDouble): LongDouble; C;


{
 *  tanhl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION tanhl(x: LongDouble): LongDouble; C;


{
 *  acoshl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION acoshl(x: LongDouble): LongDouble; C;


{
 *  asinhl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION asinhl(x: LongDouble): LongDouble; C;


{
 *  atanhl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION atanhl(x: LongDouble): LongDouble; C;


{
 *  expl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION expl(x: LongDouble): LongDouble; C;


{
 *  expm1l()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION expm1l(x: LongDouble): LongDouble; C;


{
 *  exp2l()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION exp2l(x: LongDouble): LongDouble; C;


{
 *  frexpl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION frexpl(x: LongDouble; VAR exponent: LONGINT): LongDouble; C;


{
 *  ldexpl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION ldexpl(x: LongDouble; n: LONGINT): LongDouble; C;


{
 *  logl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION logl(x: LongDouble): LongDouble; C;


{
 *  log1pl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION log1pl(x: LongDouble): LongDouble; C;


{
 *  log10l()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION log10l(x: LongDouble): LongDouble; C;


{
 *  log2l()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION log2l(x: LongDouble): LongDouble; C;


{
 *  logbl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION logbl(x: LongDouble): LongDouble; C;


{
 *  scalbl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION scalbl(x: LongDouble; n: LONGINT): LongDouble; C;


{
 *  fabsl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION fabsl(x: LongDouble): LongDouble; C;


{
 *  hypotl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION hypotl(x: LongDouble; y: LongDouble): LongDouble; C;


{
 *  powl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION powl(x: LongDouble; y: LongDouble): LongDouble; C;


{
 *  sqrtl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION sqrtl(x: LongDouble): LongDouble; C;


{
 *  erfl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION erfl(x: LongDouble): LongDouble; C;


{
 *  erfcl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION erfcl(x: LongDouble): LongDouble; C;


{
 *  gammal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION gammal(x: LongDouble): LongDouble; C;


{
 *  lgammal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION lgammal(x: LongDouble): LongDouble; C;


{
 *  ceill()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 2.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION ceill(x: LongDouble): LongDouble; C;


{
 *  floorl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION floorl(x: LongDouble): LongDouble; C;


{
 *  rintl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION rintl(x: LongDouble): LongDouble; C;


{
 *  nearbyintl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION nearbyintl(x: LongDouble): LongDouble; C;


{
 *  rinttoll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION rinttoll(x: LongDouble): LONGINT; C;


{
 *  roundl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION roundl(x: LongDouble): LongDouble; C;


{
 *  roundtoll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION roundtoll(x: LongDouble): LONGINT; C;


{
 *  truncl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION truncl(x: LongDouble): LongDouble; C;


{
 *  remainderl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION remainderl(x: LongDouble; y: LongDouble): LongDouble; C;


{
 *  remquol()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION remquol(x: LongDouble; y: LongDouble; VAR quo: LONGINT): LongDouble; C;


{
 *  copysignl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION copysignl(x: LongDouble; y: LongDouble): LongDouble; C;


{
 *  fdiml()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION fdiml(x: LongDouble; y: LongDouble): LongDouble; C;


{
 *  fmaxl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION fmaxl(x: LongDouble; y: LongDouble): LongDouble; C;


{
 *  fminl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION fminl(x: LongDouble; y: LongDouble): LongDouble; C;

{$IFC UNDEFINED __NOEXTENSIONS__ }
{
 *  relationl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION relationl(x: LongDouble; y: LongDouble): relop; C;


{
 *  num2decl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
PROCEDURE num2decl({CONST}VAR f: decform; x: LongDouble; VAR d: decimal); C;


{
 *  dec2numl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION dec2numl({CONST}VAR d: decimal): LongDouble; C;

{$ENDC}
{$ENDC}  {TARGET_CPU_PPC}
{$ENDC}  {TARGET_OS_MAC}

{$IFC UNDEFINED __NOEXTENSIONS__ }
{    
        MathLib v2 has two new transfer functions: x80tod and dtox80.  They can 
        be used to directly transform 68k 80-bit extended data types to double
        and back for PowerPC based machines without using the functions
        x80told or ldtox80.  Double rounding may occur. 
    }
{
 *  x80tod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION x80tod({CONST}VAR x80: extended80): Double; C;

{
 *  dtox80()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE dtox80({CONST}VAR x: Double; VAR x80: extended80); C;

{$IFC TARGET_CPU_PPC }
{
 *  x80told()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
PROCEDURE x80told({CONST}VAR x80: extended80; VAR x: LongDouble); C;


{
 *  ldtox80()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MathLib 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
PROCEDURE ldtox80({CONST}VAR x: LongDouble; VAR x80: extended80); C;

{$ENDC} {TARGET_CPU_PPC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := fpIncludes}

{$ENDC} {__FP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

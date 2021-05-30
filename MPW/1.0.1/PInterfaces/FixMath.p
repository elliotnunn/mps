{
  File: FixMath.p

 Version: 1.0

 Copyright Apple Computer, Inc. 1984, 1985, 1986
 All Rights Reserved

}

{
-------------------------------------------------------------------------
		Equates for FixTraps
		Fixed Point Routines
 -------------------------------------------------------------------------

  These calls support three types of fixed point numbers, each 32 bits long.
  The bits are interpreted as shown.  The '-' represents the sign bit.

  Type	 <---------Integer Portion--------> <-------Fractional Portion------>
 LongInt -xxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx.
 Fixed				-xxxxxxx xxxxxxxx.xxxxxxxx xxxxxxxx
 Fract						 -x.xxxxxxxx xxxxxxxx xxxxxxxx xxxxxx

  Type LongInt can represent integers between +/-2147483647.  Type Fixed can
  represent fractional quantities between +/-32768, with about 5 digits of
  accuracy.  Type Fract can represent fractional quantities between +/-2 with
  about 9 digits of accuracy.  These numeric representations are useful for
  applications that do not require the accuracy of the floating point routines,
  and which need to run as fast as possible.  The Graf3D three dimensional
  graphics package resides on top of these routines.  Although FixMul is in the
  file ToolTraps, it is shown below to show how it handles different types.
  Additional fixed point routines are described in the Inside Macintosh chapter,
  “Toolbox Utilities.” }

UNIT FixMath;

  INTERFACE

	USES {$U MemTypes.p } MemTypes;

	TYPE
	  Fract = LONGINT;

	  {These routines are only available on a system with a 128K ROM:}

	FUNCTION Long2Fix(x: LONGINT): fixed;
	  INLINE $A83F;

	FUNCTION Fix2Long(x: fixed): LONGINT;
	  INLINE $A840;

	FUNCTION Fix2Frac(x: fixed): Fract;
	  INLINE $A841;

	FUNCTION Frac2Fix(x: Fract): fixed;
	  INLINE $A842;
	{ Functions to convert between fixed-point types.}

	FUNCTION Fix2X(x: fixed): extended;
	  INLINE $A843;

	FUNCTION X2Fix(x: extended): fixed;
	  INLINE $A844;

	FUNCTION Frac2X(x: Fract): extended;
	  INLINE $A845;

	FUNCTION X2Frac(x: extended): Fract;
	  INLINE $A846;
{ Functions to convert between Fixed and Fract and the Extended
  floating-point type.}

	FUNCTION FixAtan2(x, y: LONGINT): fixed;
	  INLINE $A818;
{ FixATan2 returns the arctangent of y / x.  Note that FixATan2 effects
  "arctan(type / type) --> Fixed":
	arctan(LONGINT / LONGINT) --> Fixed
	arctan(Fixed   / Fixed	) --> Fixed
	arctan(Fract   / Fract	) --> Fixed}

	{The following routines are supplied as glue code:}

	FUNCTION FracMul(x, y: Fract): Fract;
 { FracMul returns x * y.  Note that FracMul effects "type * Fract --> type":
		Fract	* Fract 		--> Fract
		LONGINT * Fract 		--> LONGINT
		Fract	* LONGINT		--> LONGINT
		Fixed	* Fract 		--> Fixed
		Fract	* Fixed 		--> Fixed}

	FUNCTION FixDiv(x, y: fixed): fixed;
 { FixDiv returns x / y.  Note that FixDiv effects "type / type --> Fixed":
		Fixed / Fixed		  --> Fixed
		LONGINT / LONGINT		--> Fixed
		Fract / Fract		  --> Fixed
		LONGINT / Fixed 		--> LONGINT
		Fract / Fixed		  --> Fract}

	FUNCTION FracDiv(x, y: Fract): Fract;
 { FracDiv returns x / y.  Note that FracDiv effects "type / type --> Fract":
		Fract / Fract		  --> Fract
		LONGINT / LONGINT		--> Fract
		Fixed / Fixed		  --> Fract
		LONGINT / Fract 		--> LONGINT
		Fixed / Fract		  --> Fixed}

	FUNCTION FracSqrt(x: Fract): Fract;
 { FracSqrt returns the square root of x.  Both argument and result are regarded
   as unsigned.}

	FUNCTION FracCos(x: fixed): Fract;

	FUNCTION FracSin(x: fixed): Fract;
 { FracCos and FracSin return the cosine and sine, respectively, given the
   argument x in radians.}

{These routines are accessed as traps via the glue code if
   it is running on a 128K ROM machine:

 FUNCTION FixDiv(x,y:fixed):fixed; INLINE $A84D;
 FUNCTION FracCos(x:fixed):fract; INLINE $A847;
 FUNCTION FracSin(x:fixed):fract; INLINE $A848;
 FUNCTION FracSqrt(x:fract):fract; INLINE $A849;
 FUNCTION FracMul(x,y:fract):fract; INLINE $A84A;
 FUNCTION FracDiv(x,y:fract):fixed; INLINE $A84B;
}

END.

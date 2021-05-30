{
 	File:		FixMath.p
 
 	Contains:	Fixed Math Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT FixMath;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __FIXMATH__}
{$SETC __FIXMATH__ := 1}

{$I+}
{$SETC FixMathIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	fixed1						= $00010000;
	fract1						= $40000000;
	positiveInfinity			= $7FFFFFFF;
	negativeInfinity			= $80000000;


FUNCTION Fix2Frac(x: Fixed): Fract;
	{$IFC NOT GENERATINGCFM}
	INLINE $A841;
	{$ENDC}
FUNCTION Fix2Long(x: Fixed): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A840;
	{$ENDC}
FUNCTION Long2Fix(x: LONGINT): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $A83F;
	{$ENDC}
FUNCTION Frac2Fix(x: Fract): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $A842;
	{$ENDC}
FUNCTION FracMul(x: Fract; y: Fract): Fract;
	{$IFC NOT GENERATINGCFM}
	INLINE $A84A;
	{$ENDC}
FUNCTION FixDiv(x: Fixed; y: Fixed): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $A84D;
	{$ENDC}
FUNCTION FracDiv(x: Fract; y: Fract): Fract;
	{$IFC NOT GENERATINGCFM}
	INLINE $A84B;
	{$ENDC}
FUNCTION FracSqrt(x: Fract): Fract;
	{$IFC NOT GENERATINGCFM}
	INLINE $A849;
	{$ENDC}
FUNCTION FracSin(x: Fixed): Fract;
	{$IFC NOT GENERATINGCFM}
	INLINE $A848;
	{$ENDC}
FUNCTION FracCos(x: Fixed): Fract;
	{$IFC NOT GENERATINGCFM}
	INLINE $A847;
	{$ENDC}
FUNCTION FixATan2(x: LONGINT; y: LONGINT): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $A818;
	{$ENDC}
{$IFC GENERATINGPOWERPC }
FUNCTION WideCompare({CONST}VAR target: wide; {CONST}VAR source: wide): INTEGER; C;
FUNCTION WideAdd(VAR target: wide; {CONST}VAR source: wide): WidePtr; C;
FUNCTION WideSubtract(VAR target: wide; {CONST}VAR source: wide): WidePtr; C;
FUNCTION WideNegate(VAR target: wide): WidePtr; C;
FUNCTION WideShift(VAR target: wide; shift: LONGINT): WidePtr; C;
FUNCTION WideSquareRoot({CONST}VAR source: wide): LONGINT; C;
FUNCTION WideMultiply(multiplicand: LONGINT; multiplier: LONGINT; VAR target: wide): WidePtr; C;
{ returns the quotient }
FUNCTION WideDivide({CONST}VAR dividend: wide; divisor: LONGINT; VAR remainder: LONGINT): LONGINT; C;
{ quotient replaces dividend }
FUNCTION WideWideDivide(VAR dividend: wide; divisor: LONGINT; VAR remainder: LONGINT): WidePtr; C;
FUNCTION WideBitShift(VAR src: wide; shift: LONGINT): WidePtr; C;
{$ENDC}
{$IFC GENERATING68K  & NOT GENERATING68881 }
FUNCTION Frac2X(x: Fract): double_t;
	{$IFC NOT GENERATINGCFM}
	INLINE $A845;
	{$ENDC}
FUNCTION Fix2X(x: Fixed): double_t;
	{$IFC NOT GENERATINGCFM}
	INLINE $A843;
	{$ENDC}
FUNCTION X2Fix(x: double_t): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $A844;
	{$ENDC}
FUNCTION X2Frac(x: double_t): Fract;
	{$IFC NOT GENERATINGCFM}
	INLINE $A846;
	{$ENDC}
{$ELSEC}
FUNCTION Frac2X(x: Fract): double_t;
FUNCTION Fix2X(x: Fixed): double_t;
FUNCTION X2Fix(x: double_t): Fixed;
FUNCTION X2Frac(x: double_t): Fract;
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := FixMathIncludes}

{$ENDC} {__FIXMATH__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

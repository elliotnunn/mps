{
 	File:		GXMath.p
 
 	Contains:	QuickDraw GX math routine interfaces.
 
 	Version:	Technology:	Quickdraw GX 1.1
 				Release:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT GXMath;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GXMATH__}
{$SETC __GXMATH__ := 1}

{$I+}
{$SETC GXMathIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __FIXMATH__}
{$I FixMath.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	gxPointPtr = ^gxPoint;
	gxPoint = RECORD
		x:						Fixed;
		y:						Fixed;
	END;

	gxColorValue						= INTEGER;
	gxPolarPtr = ^gxPolar;
	gxPolar = RECORD
		radius:					Fixed;
		angle:					Fixed;
	END;

	gxMappingPtr = ^gxMapping;
	gxMapping = RECORD
		map:					ARRAY [0..2,0..2] OF Fixed;
	END;


CONST
	gxColorValue1				= $0000FFFF;					{  gxColorValue 1.0  }

	gxPositiveInfinity			= $7FFFFFFF;					{  for Fixed and Fract  }
	gxNegativeInfinity			= $80000000;					{  for Fixed and Fract  }


FUNCTION CopyToMapping(VAR target: gxMapping; {CONST}VAR source: gxMapping): gxMappingPtr; C;
FUNCTION InvertMapping(VAR target: gxMapping; {CONST}VAR source: gxMapping): gxMappingPtr; C;
FUNCTION MapMapping(VAR target: gxMapping; {CONST}VAR source: gxMapping): gxMappingPtr; C;
FUNCTION MoveMapping(VAR target: gxMapping; hOffset: Fixed; vOffset: Fixed): gxMappingPtr; C;
FUNCTION MoveMappingTo(VAR target: gxMapping; hPosition: Fixed; vPosition: Fixed): gxMappingPtr; C;
FUNCTION NormalizeMapping(VAR target: gxMapping): gxMappingPtr; C;
FUNCTION RotateMapping(VAR target: gxMapping; angle: Fixed; xCenter: Fixed; yCenter: Fixed): gxMappingPtr; C;
FUNCTION ScaleMapping(VAR target: gxMapping; hFactor: Fixed; vFactor: Fixed; xCenter: Fixed; yCenter: Fixed): gxMappingPtr; C;
FUNCTION ResetMapping(VAR target: gxMapping): gxMappingPtr; C;
FUNCTION SkewMapping(VAR target: gxMapping; skewX: Fixed; skewY: Fixed; xCenter: Fixed; yCenter: Fixed): gxMappingPtr; C;
PROCEDURE MapPoints({CONST}VAR source: gxMapping; count: LONGINT; VAR vector: gxPoint); C;
FUNCTION FirstBit(x: LONGINT): INTEGER; C;
FUNCTION WideScale({CONST}VAR source: wide): INTEGER; C;
FUNCTION LinearRoot(first: Fixed; last: Fixed; VAR t: Fract): INTEGER; C;
FUNCTION QuadraticRoot(first: Fixed; control: Fixed; last: Fixed; VAR t: Fract): INTEGER; C;
FUNCTION PolarToPoint({CONST}VAR ra: gxPolar; VAR xy: gxPoint): gxPointPtr; C;
FUNCTION PointToPolar({CONST}VAR xy: gxPoint; VAR ra: gxPolar): gxPolarPtr; C;
FUNCTION FractCubeRoot(source: Fract): Fract; C;
FUNCTION FractDivide(dividend: Fract; divisor: Fract): Fract; C;
FUNCTION FractMultiply(multiplicand: Fract; multiplier: Fract): Fract; C;
FUNCTION FractSineCosine(degrees: Fixed; VAR cosine: Fract): Fract; C;
FUNCTION FractSquareRoot(source: Fract): Fract; C;
FUNCTION FixedDivide(dividend: Fixed; divisor: Fixed): Fixed; C;
FUNCTION FixedMultiply(multiplicand: Fixed; multiplier: Fixed): Fixed; C;
{  This next call is (source * multiplier / divisor) -- it avoids underflow, overflow by using wides  }
FUNCTION MultiplyDivide(source: LONGINT; multiplier: LONGINT; divisor: LONGINT): LONGINT; C;
FUNCTION Magnitude(deltaX: LONGINT; deltaY: LONGINT): LONGINT; C;
FUNCTION VectorMultiplyDivide(count: LONGINT; {CONST}VAR vector1: LONGINT; step1: LONGINT; {CONST}VAR vector2: LONGINT; step2: LONGINT; divisor: LONGINT): LONGINT; C;
{  wide operations are defined within FixMath.h only for PowerPC  }
{$IFC NOT GENERATINGPOWERPC }
FUNCTION WideAdd(VAR target: wide; {CONST}VAR source: wide): widePtr; C;
FUNCTION WideCompare({CONST}VAR target: wide; {CONST}VAR source: wide): INTEGER; C;
FUNCTION WideNegate(VAR target: wide): widePtr; C;
FUNCTION WideShift(VAR target: wide; shift: LONGINT): widePtr; C;
FUNCTION WideSquareRoot({CONST}VAR source: wide): LONGINT; C;
FUNCTION WideSubtract(VAR target: wide; {CONST}VAR source: wide): widePtr; C;
FUNCTION WideMultiply(multiplicand: LONGINT; multiplier: LONGINT; VAR target: wide): widePtr; C;
{  returns the quotient  }
FUNCTION WideDivide({CONST}VAR dividend: wide; divisor: LONGINT; VAR remainder: LONGINT): LONGINT; C;
{  quotient replaces dividend  }
FUNCTION WideWideDivide(VAR dividend: wide; divisor: LONGINT; VAR remainder: LONGINT): widePtr; C;
{$ENDC}
FUNCTION VectorMultiply(count: LONGINT; {CONST}VAR vector1: LONGINT; step1: LONGINT; {CONST}VAR vector2: LONGINT; step2: LONGINT; VAR dot: wide): widePtr; C;
FUNCTION RandomBits(count: LONGINT; focus: LONGINT): LONGINT; C;
PROCEDURE SetRandomSeed({CONST}VAR seed: wide); C;
FUNCTION GetRandomSeed(VAR seed: wide): widePtr; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXMathIncludes}

{$ENDC} {__GXMATH__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

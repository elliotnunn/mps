{
     File:       GXMath.p
 
     Contains:   QuickDraw GX math routine interfaces.
 
     Version:    Technology: Quickdraw GX 1.1
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
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

	gxColorValue						= UInt16;
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


{$IFC CALL_NOT_IN_CARBON }
	{
	 *  CopyToMapping()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION CopyToMapping(VAR target: gxMapping; {CONST}VAR source: gxMapping): gxMappingPtr; C;
{
 *  InvertMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvertMapping(VAR target: gxMapping; {CONST}VAR source: gxMapping): gxMappingPtr; C;
{
 *  MapMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MapMapping(VAR target: gxMapping; {CONST}VAR source: gxMapping): gxMappingPtr; C;
{
 *  MoveMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MoveMapping(VAR target: gxMapping; hOffset: Fixed; vOffset: Fixed): gxMappingPtr; C;
{
 *  MoveMappingTo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MoveMappingTo(VAR target: gxMapping; hPosition: Fixed; vPosition: Fixed): gxMappingPtr; C;
{
 *  NormalizeMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NormalizeMapping(VAR target: gxMapping): gxMappingPtr; C;
{
 *  RotateMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RotateMapping(VAR target: gxMapping; angle: Fixed; xCenter: Fixed; yCenter: Fixed): gxMappingPtr; C;
{
 *  ScaleMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ScaleMapping(VAR target: gxMapping; hFactor: Fixed; vFactor: Fixed; xCenter: Fixed; yCenter: Fixed): gxMappingPtr; C;
{
 *  ResetMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ResetMapping(VAR target: gxMapping): gxMappingPtr; C;
{
 *  SkewMapping()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SkewMapping(VAR target: gxMapping; skewX: Fixed; skewY: Fixed; xCenter: Fixed; yCenter: Fixed): gxMappingPtr; C;
{
 *  MapPoints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MapPoints({CONST}VAR source: gxMapping; count: LONGINT; VAR theVector: gxPoint); C;
{
 *  FirstBit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FirstBit(x: UInt32): INTEGER; C;
{
 *  WideScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION WideScale({CONST}VAR source: wide): INTEGER; C;
{
 *  LinearRoot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION LinearRoot(first: Fixed; last: Fixed; VAR t: Fract): INTEGER; C;
{
 *  QuadraticRoot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION QuadraticRoot(first: Fixed; control: Fixed; last: Fixed; VAR t: Fract): INTEGER; C;
{
 *  PolarToPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PolarToPoint({CONST}VAR ra: gxPolar; VAR xy: gxPoint): gxPointPtr; C;
{
 *  PointToPolar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PointToPolar({CONST}VAR xy: gxPoint; VAR ra: gxPolar): gxPolarPtr; C;
{
 *  FractCubeRoot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FractCubeRoot(source: Fract): Fract; C;
{
 *  FractDivide()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FractDivide(dividend: Fract; divisor: Fract): Fract; C;
{
 *  FractMultiply()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FractMultiply(multiplicand: Fract; multiplier: Fract): Fract; C;
{
 *  FractSineCosine()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FractSineCosine(degrees: Fixed; VAR cosine: Fract): Fract; C;
{
 *  FractSquareRoot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FractSquareRoot(source: Fract): Fract; C;
{
 *  FixedDivide()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FixedDivide(dividend: Fixed; divisor: Fixed): Fixed; C;
{
 *  FixedMultiply()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FixedMultiply(multiplicand: Fixed; multiplier: Fixed): Fixed; C;
{ This next call is (source * multiplier / divisor) -- it avoids underflow, overflow by using wides }
{
 *  MultiplyDivide()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MultiplyDivide(source: LONGINT; multiplier: LONGINT; divisor: LONGINT): LONGINT; C;
{
 *  Magnitude()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Magnitude(deltaX: LONGINT; deltaY: LONGINT): UInt32; C;
{
 *  VectorMultiplyDivide()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION VectorMultiplyDivide(count: LONGINT; {CONST}VAR vector1: LONGINT; step1: LONGINT; {CONST}VAR vector2: LONGINT; step2: LONGINT; divisor: LONGINT): LONGINT; C;



{ wide operations are defined within FixMath.h for PowerPC }
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC TARGET_OS_MAC AND TARGET_CPU_68K }
{$IFC CALL_NOT_IN_CARBON }
{
 *  WideAdd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION WideAdd(VAR target: wide; {CONST}VAR source: wide): widePtr; C;
{
 *  WideCompare()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION WideCompare({CONST}VAR target: wide; {CONST}VAR source: wide): INTEGER; C;
{
 *  WideNegate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION WideNegate(VAR target: wide): widePtr; C;
{
 *  WideShift()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION WideShift(VAR target: wide; shift: LONGINT): widePtr; C;
{
 *  WideSquareRoot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION WideSquareRoot({CONST}VAR source: wide): UInt32; C;
{
 *  WideSubtract()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION WideSubtract(VAR target: wide; {CONST}VAR source: wide): widePtr; C;
{
 *  WideMultiply()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION WideMultiply(multiplicand: LONGINT; multiplier: LONGINT; VAR target: wide): widePtr; C;
{ returns the quotient }
{
 *  WideDivide()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION WideDivide({CONST}VAR dividend: wide; divisor: LONGINT; VAR remainder: LONGINT): LONGINT; C;
{ quotient replaces dividend }
{
 *  WideWideDivide()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION WideWideDivide(VAR dividend: wide; divisor: LONGINT; VAR remainder: LONGINT): widePtr; C;
{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}



{$IFC CALL_NOT_IN_CARBON }
{
 *  VectorMultiply()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION VectorMultiply(count: LONGINT; {CONST}VAR vector1: LONGINT; step1: LONGINT; {CONST}VAR vector2: LONGINT; step2: LONGINT; VAR dot: wide): widePtr; C;
{
 *  RandomBits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RandomBits(count: LONGINT; focus: LONGINT): UInt32; C;
{
 *  SetRandomSeed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetRandomSeed({CONST}VAR seed: wide); C;
{
 *  GetRandomSeed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetRandomSeed(VAR seed: wide): widePtr; C;

{$ENDC}  {CALL_NOT_IN_CARBON}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXMathIncludes}

{$ENDC} {__GXMATH__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

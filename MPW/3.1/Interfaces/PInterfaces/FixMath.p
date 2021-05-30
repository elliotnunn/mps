{
Created: Saturday, October 15, 1988 at 8:43 AM
	FixMath.p
	Pascal Interface to Fixed Point Math

	Copyright Apple Computer, Inc.	1985-1988
	All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT FixMath;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingFixMath}
{$SETC UsingFixMath := 1}

{$I+}
{$SETC FixMathIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$SETC UsingIncludes := FixMathIncludes}


FUNCTION Fix2Frac(x: Fixed): Fract;
	INLINE $A841;
FUNCTION Fix2Long(x: Fixed): LONGINT;
	INLINE $A840;
FUNCTION FixATan2(x: LONGINT;y: LONGINT): Fixed;
	INLINE $A818;
FUNCTION Long2Fix(x: LONGINT): Fixed;
	INLINE $A83F;
FUNCTION Frac2Fix(x: Fract): Fixed;
	INLINE $A842;
FUNCTION Frac2X(x: Fract): Extended;
FUNCTION Fix2X(x: Fixed): Extended;
FUNCTION X2Fix(x: Extended): Fixed;
FUNCTION X2Frac(x: Extended): Fract;
FUNCTION FracMul(x: Fract;y: Fract): Fract;
FUNCTION FixDiv(x: Fixed;y: Fixed): Fixed;
FUNCTION FracDiv(x: Fract;y: Fract): Fract;
FUNCTION FracSqrt(x: Fract): Fract;
FUNCTION FracSin(x: Fixed): Fract;
FUNCTION FracCos(x: Fixed): Fract;

{$ENDC}    { UsingFixMath }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}


{
	File:		ToolUtils.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT ToolUtils;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingToolUtils}
{$SETC UsingToolUtils := 1}

{$I+}
{$SETC ToolUtilsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingQuickdraw}
{$I $$Shell(PInterfaces)Quickdraw.p}
{$ENDC}
{$SETC UsingIncludes := ToolUtilsIncludes}

CONST
sysPatListID = 0;
iBeamCursor = 1;
crossCursor = 2;
plusCursor = 3;
watchCursor = 4;

TYPE
Int64Bit = RECORD
    hiLong: LONGINT;
    loLong: LONGINT;
    END;


FUNCTION FixRatio(numer: INTEGER;denom: INTEGER): Fixed;
    INLINE $A869;
FUNCTION FixMul(a: Fixed;b: Fixed): Fixed;
    INLINE $A868;
FUNCTION FixRound(x: Fixed): INTEGER;
    INLINE $A86C;
PROCEDURE PackBits(VAR srcPtr: Ptr;VAR dstPtr: Ptr;srcBytes: INTEGER);
    INLINE $A8CF;
PROCEDURE UnpackBits(VAR srcPtr: Ptr;VAR dstPtr: Ptr;dstBytes: INTEGER);
    INLINE $A8D0;
FUNCTION BitTst(bytePtr: Ptr;bitNum: LONGINT): BOOLEAN;
    INLINE $A85D;
PROCEDURE BitSet(bytePtr: Ptr;bitNum: LONGINT);
    INLINE $A85E;
PROCEDURE BitClr(bytePtr: Ptr;bitNum: LONGINT);
    INLINE $A85F;
FUNCTION BitAnd(value1: LONGINT;value2: LONGINT): LONGINT;
    INLINE $A858;
FUNCTION BitOr(value1: LONGINT;value2: LONGINT): LONGINT;
    INLINE $A85B;
FUNCTION BitXor(value1: LONGINT;value2: LONGINT): LONGINT;
    INLINE $A859;
FUNCTION BitNot(value: LONGINT): LONGINT;
    INLINE $A85A;
FUNCTION BitShift(value: LONGINT;count: INTEGER): LONGINT;
    INLINE $A85C;
FUNCTION HiWord(x: LONGINT): INTEGER;
    INLINE $A86A;
FUNCTION LoWord(x: LONGINT): INTEGER;
    INLINE $A86B;
PROCEDURE LongMul(a: LONGINT;b: LONGINT;VAR result: Int64Bit);
    INLINE $A867;
FUNCTION GetIcon(iconID: INTEGER): Handle;
    INLINE $A9BB;
PROCEDURE PlotIcon(theRect: Rect;theIcon: Handle);
    INLINE $A94B;
FUNCTION GetPattern(patternID: INTEGER): PatHandle;
    INLINE $A9B8;
FUNCTION GetCursor(cursorID: INTEGER): CursHandle;
    INLINE $A9B9;
FUNCTION GetPicture(pictureID: INTEGER): PicHandle;
    INLINE $A9BC;
FUNCTION SlopeFromAngle(angle: INTEGER): Fixed;
    INLINE $A8BC;
FUNCTION AngleFromSlope(slope: Fixed): INTEGER;
    INLINE $A8C4;
FUNCTION DeltaPoint(ptA: Point;ptB: Point): LONGINT;
    INLINE $A94F;
PROCEDURE ShieldCursor(shieldRect: Rect;offsetPt: Point);
    INLINE $A855;
PROCEDURE ScreenRes(VAR scrnHRes: INTEGER;VAR scrnVRes: INTEGER);
    INLINE $225F,$32B8,$0102,$225F,$32B8,$0104;
PROCEDURE GetIndPattern(VAR thePat: Pattern;patternListID: INTEGER;index: INTEGER);


{$ENDC}    { UsingToolUtils }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}


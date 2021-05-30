{
 	File:		ToolUtils.p
 
 	Contains:	Toolbox Utilities Interfaces.
 
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
 UNIT ToolUtils;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TOOLUTILS__}
{$SETC __TOOLUTILS__ := 1}

{$I+}
{$SETC ToolUtilsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{	MixedMode.p													}
{	Memory.p													}

{$IFC UNDEFINED __TEXTUTILS__}
{$I TextUtils.p}
{$ENDC}
{	Script.p													}
{		Quickdraw.p												}
{			QuickdrawText.p										}
{		IntlResources.p											}
{		Events.p												}

{$IFC UNDEFINED __FIXMATH__}
{$I FixMath.p}
{$ENDC}
{$IFC OLDROUTINELOCATIONS }

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}

{$IFC UNDEFINED __ICONS__}
{$I Icons.p}
{$ENDC}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
{
	Note: 
	
	The following have moved to Icons.h: 	 PlotIcon and GetIcon
	
	The following have moved to Quickdraw.h: GetPattern, GetIndPattern, GetCursor, ShieldCursor, 
											 GetPicture, DeltaPoint and ScreenResGetCursor
}

TYPE
	Int64Bit = RECORD
		hiLong:					SInt32;
		loLong:					UInt32;
	END;


FUNCTION FixRatio(numer: INTEGER; denom: INTEGER): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $A869;
	{$ENDC}
FUNCTION FixMul(a: Fixed; b: Fixed): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $A868;
	{$ENDC}
FUNCTION FixRound(x: Fixed): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A86C;
	{$ENDC}
PROCEDURE PackBits(VAR srcPtr: Ptr; VAR dstPtr: Ptr; srcBytes: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8CF;
	{$ENDC}
PROCEDURE UnpackBits(VAR srcPtr: Ptr; VAR dstPtr: Ptr; dstBytes: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8D0;
	{$ENDC}
FUNCTION BitTst(bytePtr: UNIV Ptr; bitNum: LONGINT): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A85D;
	{$ENDC}
PROCEDURE BitSet(bytePtr: UNIV Ptr; bitNum: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $A85E;
	{$ENDC}
PROCEDURE BitClr(bytePtr: UNIV Ptr; bitNum: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $A85F;
	{$ENDC}
FUNCTION BitAnd(value1: LONGINT; value2: LONGINT): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A858;
	{$ENDC}
FUNCTION BitOr(value1: LONGINT; value2: LONGINT): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A85B;
	{$ENDC}
FUNCTION BitXor(value1: LONGINT; value2: LONGINT): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A859;
	{$ENDC}
FUNCTION BitNot(value: LONGINT): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A85A;
	{$ENDC}
FUNCTION BitShift(value: LONGINT; count: INTEGER): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A85C;
	{$ENDC}
FUNCTION SlopeFromAngle(angle: INTEGER): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8BC;
	{$ENDC}
FUNCTION AngleFromSlope(slope: Fixed): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8C4;
	{$ENDC}
{$IFC GENERATING68K }
PROCEDURE LongMul(a: LONGINT; b: LONGINT; VAR result: Int64Bit);
	{$IFC NOT GENERATINGCFM}
	INLINE $A867;
	{$ENDC}
{$ENDC}
FUNCTION HiWord(x: LONGINT): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A86A;
	{$ENDC}
FUNCTION LoWord(x: LONGINT): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A86B;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ToolUtilsIncludes}

{$ENDC} {__TOOLUTILS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

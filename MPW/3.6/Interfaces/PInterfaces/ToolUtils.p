{
     File:       ToolUtils.p
 
     Contains:   Toolbox Utilities Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1990-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FIXMATH__}
{$I FixMath.p}
{$ENDC}
{$IFC UNDEFINED __TEXTUTILS__}
{$I TextUtils.p}
{$ENDC}
{$IFC UNDEFINED __ICONS__}
{$I Icons.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
————————————————————————————————————————————————————————————————————————————————————
    Note: 
    
    The following routines that used to be in this header file, have moved to
    more appropriate headers.  
    
        FixMath.h:      FixMul
                        FixRatio
                        FixRound
        
        Icons.h:        GetIcon
                        PlotIcon
                        
        Quickdraw.h:    AngleFromSlope
                        DeltaPoint
                        GetCursor
                        GetIndPattern
                        GetPattern
                        GetPicture
                        PackBits
                        ScreenRes
                        ShieldCursor
                        SlopeFromAngle
                        UnpackBits
                        
        TextUtils.h:    Munger
                        GetIndString
                        GetString
                        NewString
                        SetString
————————————————————————————————————————————————————————————————————————————————————
}

{
 *  BitTst()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitTst(bytePtr: UNIV Ptr; bitNum: LONGINT): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A85D;
	{$ENDC}

{
 *  BitSet()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE BitSet(bytePtr: UNIV Ptr; bitNum: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A85E;
	{$ENDC}

{
 *  BitClr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE BitClr(bytePtr: UNIV Ptr; bitNum: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A85F;
	{$ENDC}

{
 *  BitAnd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitAnd(value1: LONGINT; value2: LONGINT): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A858;
	{$ENDC}

{
 *  BitOr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitOr(value1: LONGINT; value2: LONGINT): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A85B;
	{$ENDC}

{
 *  BitXor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitXor(value1: LONGINT; value2: LONGINT): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A859;
	{$ENDC}

{
 *  BitNot()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitNot(value: LONGINT): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A85A;
	{$ENDC}

{
 *  BitShift()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitShift(value: LONGINT; count: INTEGER): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A85C;
	{$ENDC}

{$IFC TARGET_CPU_68K }

TYPE
	Int64BitPtr = ^Int64Bit;
	Int64Bit = RECORD
		hiLong:					SInt32;
		loLong:					UInt32;
	END;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  LongMul()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE LongMul(a: LONGINT; b: LONGINT; VAR result: Int64Bit);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A867;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_CPU_68K}

{
   HiWord and LoWord are not in Carbon, but Metrowerks 
   supplies an implementation on PPC
}
{
 *  HiWord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib H.a.c.k and later
 *    Mac OS X:         not available
 }
FUNCTION HiWord(x: LONGINT): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A86A;
	{$ENDC}

{
 *  LoWord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib H.a.c.k and later
 *    Mac OS X:         not available
 }
FUNCTION LoWord(x: LONGINT): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A86B;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ToolUtilsIncludes}

{$ENDC} {__TOOLUTILS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

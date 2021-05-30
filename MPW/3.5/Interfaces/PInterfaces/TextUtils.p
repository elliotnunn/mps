{
     File:       TextUtils.p
 
     Contains:   Text Utilities Interfaces.
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT TextUtils;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TEXTUTILS__}
{$SETC __TEXTUTILS__ := 1}

{$I+}
{$SETC TextUtilsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __NUMBERFORMATTING__}
{$I NumberFormatting.p}
{$ENDC}
{$IFC UNDEFINED __STRINGCOMPARE__}
{$I StringCompare.p}
{$ENDC}
{$IFC UNDEFINED __DATETIMEUTILS__}
{$I DateTimeUtils.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{

    Here are the current System 7 routine names and the translations to the older forms.
    Please use the newer forms in all new code and migrate the older names out of existing
    code as maintainance permits.
    
    NEW NAME                    OLD NAMEs                   OBSOLETE FORM (no script code)

    FindScriptRun
    FindWordBreaks                                          NFindWord, FindWord
    GetIndString            
    GetString
    Munger
    NewString               
    SetString               
    StyledLineBreak
    TruncString
    TruncText

    UpperString ($A054)         UprString, UprText
    UppercaseText               SCUpperText (a only)        UpperText ($A456)
    LowercaseText                                           LwrString, LowerText, LwrText ($A056)
    StripDiacritics                                         StripText ($A256)
    UppercaseStripDiacritics                                StripUpperText ($A656)


}

{ TruncCode, StyledLineBreakCode, and truncation constants moved to QuickDrawText.i }

TYPE
	ScriptRunStatusPtr = ^ScriptRunStatus;
	ScriptRunStatus = RECORD
		script:					SInt8;
		runVariant:				SInt8;
	END;

	BreakTablePtr = ^BreakTable;
	BreakTable = RECORD
		charTypes:				PACKED ARRAY [0..255] OF CHAR;
		tripleLength:			INTEGER;
		triples:				ARRAY [0..0] OF INTEGER;
	END;

	NBreakTablePtr = ^NBreakTable;
	NBreakTable = RECORD
		flags1:					SInt8;
		flags2:					SInt8;
		version:				INTEGER;
		classTableOff:			INTEGER;
		auxCTableOff:			INTEGER;
		backwdTableOff:			INTEGER;
		forwdTableOff:			INTEGER;
		doBackup:				INTEGER;
		length:					INTEGER;								{  length of NBreakTable  }
		charTypes:				PACKED ARRAY [0..255] OF CHAR;
		tables:					ARRAY [0..0] OF INTEGER;
	END;

	{  The following functions are new names that work on 68k and PowerPC }
	{
	 *  Munger()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION Munger(h: Handle; offset: LONGINT; ptr1: UNIV Ptr; len1: LONGINT; ptr2: UNIV Ptr; len2: LONGINT): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9E0;
	{$ENDC}

{
 *  NewString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewString(theString: Str255): StringHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A906;
	{$ENDC}

{
 *  SetString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetString(theString: StringHandle; strNew: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A907;
	{$ENDC}

{
 *  GetString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetString(stringID: INTEGER): StringHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9BA;
	{$ENDC}

{
 *  GetIndString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetIndString(VAR theString: Str255; strListID: INTEGER; index: INTEGER);

{
 *  FindWordBreaks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FindWordBreaks(textPtr: Ptr; textLength: INTEGER; offset: INTEGER; leadingEdge: BOOLEAN; breaks: BreakTablePtr; VAR offsets: OffsetTable; script: ScriptCode);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $C012, $001A, $A8B5;
	{$ENDC}

{
 *  LowercaseText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LowercaseText(textPtr: Ptr; len: INTEGER; script: ScriptCode);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0000, $2F3C, $800A, $FFB6, $A8B5;
	{$ENDC}

{
 *  UppercaseText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE UppercaseText(textPtr: Ptr; len: INTEGER; script: ScriptCode);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0400, $2F3C, $800A, $FFB6, $A8B5;
	{$ENDC}

{
 *  StripDiacritics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE StripDiacritics(textPtr: Ptr; len: INTEGER; script: ScriptCode);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0200, $2F3C, $800A, $FFB6, $A8B5;
	{$ENDC}

{
 *  UppercaseStripDiacritics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE UppercaseStripDiacritics(textPtr: Ptr; len: INTEGER; script: ScriptCode);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0600, $2F3C, $800A, $FFB6, $A8B5;
	{$ENDC}

{
 *  FindScriptRun()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FindScriptRun(textPtr: Ptr; textLen: LONGINT; VAR lenUsed: LONGINT): ScriptRunStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $820C, $0026, $A8B5;
	{$ENDC}

{
    The following functions are old names, but are required for PowerPC builds
    because InterfaceLib exports these names, instead of the new ones.
}

{$IFC CALL_NOT_IN_CARBON }
{
 *  FindWord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FindWord(textPtr: Ptr; textLength: INTEGER; offset: INTEGER; leadingEdge: BOOLEAN; breaks: BreakTablePtr; VAR offsets: OffsetTable);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8012, $001A, $A8B5;
	{$ENDC}

{
 *  NFindWord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE NFindWord(textPtr: Ptr; textLength: INTEGER; offset: INTEGER; leadingEdge: BOOLEAN; nbreaks: NBreakTablePtr; VAR offsets: OffsetTable);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8012, $FFE2, $A8B5;
	{$ENDC}

{
   On 68K machines, LwrText, LowerText, StripText, UpperText and StripUpperText
   return an error code in register D0, but System 7 PowerMacs do not emulate
   this properly, so checking D0 is unreliable.
}

{
 *  LwrText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE LwrText(textPtr: Ptr; len: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A056;
	{$ENDC}

{
 *  LowerText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE LowerText(textPtr: Ptr; len: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A056;
	{$ENDC}

{
 *  StripText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE StripText(textPtr: Ptr; len: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A256;
	{$ENDC}

{
 *  UpperText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE UpperText(textPtr: Ptr; len: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A456;
	{$ENDC}

{
 *  StripUpperText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE StripUpperText(textPtr: Ptr; len: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A656;
	{$ENDC}


{  The following are new names which are exported by InterfaceLib }

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  UpperString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE UpperString(VAR theString: Str255; diacSensitive: BOOLEAN);

{  Old routine name but no new names are mapped to it: }
{$IFC CALL_NOT_IN_CARBON }
{
 *  UprText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE UprText(textPtr: Ptr; len: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $205F, $A054;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
    Functions for converting between C and Pascal Strings
    (Previously in Strings.h)
    
    Note: CopyPascalStringToC, CopyCStringToPascal, c2pstrcpy, and p2cstrcpy
          are written to allow inplace conversion.  That is, the src and dst
          parameters can point to the memory location.  These functions
          are available in CarbonLib and CarbonAccessors.o.
          
    Note: c2pstr, C2PStr, p2cstr, and P2CStr are all deprecated.  These functions
          only do inplace conversion and often require casts to call them.  This can
          cause bugs because you can easily cast away a const and change the 
          contents of a read-only buffer.  These functions are available
          in InterfaceLib, or when building for Carbon if you #define OLDP2C,
          then they are available as a macro.
    
}
{
 *  c2pstrcpy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE c2pstrcpy(VAR dst: Str255; src: ConstCStringPtr); C;

{
 *  p2cstrcpy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE p2cstrcpy(dst: CStringPtr; src: Str255); C;

{
 *  CopyPascalStringToC()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CopyPascalStringToC(src: Str255; dst: CStringPtr); C;

{
 *  CopyCStringToPascal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CopyCStringToPascal(src: ConstCStringPtr; VAR dst: Str255); C;

{$IFC CALL_NOT_IN_CARBON }
{
 *  C2PStrProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE C2PStrProc(aStr: UNIV Ptr);

{
 *  P2CStrProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE P2CStrProc(aStr: StringPtr);

{
 *  C2PStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION C2PStr(cString: UNIV Ptr): StringPtr;

{
 *  P2CStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION P2CStr(pString: StringPtr): Ptr;

{$ENDC}  {CALL_NOT_IN_CARBON}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TextUtilsIncludes}

{$ENDC} {__TEXTUTILS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

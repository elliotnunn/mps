{
     File:       StringCompare.p
 
     Contains:   Public interfaces for String Comparison and related operations
 
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
 UNIT StringCompare;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __STRINGCOMPARE__}
{$SETC __STRINGCOMPARE__ := 1}

{$I+}
{$SETC StringCompareIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __SCRIPT__}
{$I Script.p}
{$ENDC}
{$IFC UNDEFINED __TYPESELECT__}
{$I TypeSelect.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{

    Here are the current System 7 routine names and the translations to the older forms.
    Please use the newer forms in all new code and migrate the older names out of existing
    code as maintenance permits.
    
    NEW NAME                    OLD NAME                    OBSOLETE FORM (no handle)
    
    CompareString (Str255)      IUCompPString (hp only)     IUCompString (hp only)
    CompareText (ptr/len)       IUMagPString                IUMagString
    IdenticalString (Str255)    IUEqualPString (hp only)    IUEqualString  (hp only)
    IdenticalText (ptr/len)     IUMagIDPString              IUMagIDString
    LanguageOrder               IULangOrder
    ScriptOrder                 IUScriptOrder
    StringOrder (Str255)        IUStringOrder (hp only)
    TextOrder (ptr/len)         IUTextOrder

    RelString
    CmpString (a only)                  
    EqualString (hp only)
    
    ReplaceText

    Carbon only supports the new names.  The old names are undefined for Carbon targets.

    InterfaceLib always has exported the old names.  For C macros have been defined to allow
    the use of the new names.  For Pascal and Assembly using the new names will result
    in link errors. 
    
}


CONST
																{  Special language code values for Language Order }
	systemCurLang				= -2;							{  current (itlbLang) lang for system script }
	systemDefLang				= -3;							{  default (table) lang for system script }
	currentCurLang				= -4;							{  current (itlbLang) lang for current script }
	currentDefLang				= -5;							{  default lang for current script }
	scriptCurLang				= -6;							{  current (itlbLang) lang for specified script }
	scriptDefLang				= -7;							{  default language for a specified script }

	{  obsolete names }
	iuSystemCurLang				= -2;
	iuSystemDefLang				= -3;
	iuCurrentCurLang			= -4;
	iuCurrentDefLang			= -5;
	iuScriptCurLang				= -6;
	iuScriptDefLang				= -7;


	{	
	 *  These routines are available in Carbon with the new names.
	 	}
	{
	 *  [Mac]ReplaceText()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION ReplaceText(baseText: Handle; substitutionText: Handle; VAR key: Str15): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $820C, $FFDC, $A8B5;
	{$ENDC}

{
 *  ScriptOrder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ScriptOrder(script1: ScriptCode; script2: ScriptCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001E, $A9ED;
	{$ENDC}

{
 *  [Mac]CompareString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CompareString(aStr: Str255; bStr: Str255; itl2Handle: Handle): INTEGER;

{
 *  IdenticalString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IdenticalString(aStr: Str255; bStr: Str255; itl2Handle: Handle): INTEGER;

{
 *  StringOrder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION StringOrder(aStr: Str255; bStr: Str255; aScript: ScriptCode; bScript: ScriptCode; aLang: LangCode; bLang: LangCode): INTEGER;

{
 *  CompareText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CompareText(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; itl2Handle: Handle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001A, $A9ED;
	{$ENDC}

{
 *  IdenticalText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IdenticalText(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; itl2Handle: Handle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001C, $A9ED;
	{$ENDC}

{
 *  TextOrder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TextOrder(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; aScript: ScriptCode; bScript: ScriptCode; aLang: LangCode; bLang: LangCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0022, $A9ED;
	{$ENDC}

{
 *  LanguageOrder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LanguageOrder(language1: LangCode; language2: LangCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0020, $A9ED;
	{$ENDC}


{
 *  These routines are available in InterfaceLib with old names.
 *  Macros are provided for C to allow source code use to the new names.
 }
{$IFC CALL_NOT_IN_CARBON }
{
 *  IUMagPString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IUMagPString(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; itl2Handle: Handle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001A, $A9ED;
	{$ENDC}

{
 *  IUMagIDPString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IUMagIDPString(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; itl2Handle: Handle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001C, $A9ED;
	{$ENDC}

{
 *  IUTextOrder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IUTextOrder(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; aScript: ScriptCode; bScript: ScriptCode; aLang: LangCode; bLang: LangCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0022, $A9ED;
	{$ENDC}

{
 *  IULangOrder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IULangOrder(language1: LangCode; language2: LangCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0020, $A9ED;
	{$ENDC}

{
 *  IUScriptOrder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IUScriptOrder(script1: ScriptCode; script2: ScriptCode): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001E, $A9ED;
	{$ENDC}

{
 *  IUMagString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IUMagString(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000A, $A9ED;
	{$ENDC}

{
 *  IUMagIDString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IUMagIDString(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000C, $A9ED;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  IUCompPString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IUCompPString(aStr: Str255; bStr: Str255; itl2Handle: Handle): INTEGER;

{
 *  IUEqualPString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IUEqualPString(aStr: Str255; bStr: Str255; itl2Handle: Handle): INTEGER;

{
 *  IUStringOrder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IUStringOrder(aStr: Str255; bStr: Str255; aScript: ScriptCode; bScript: ScriptCode; aLang: LangCode; bLang: LangCode): INTEGER;

{
 *  IUCompString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IUCompString(aStr: Str255; bStr: Str255): INTEGER;

{
 *  IUEqualString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IUEqualString(aStr: Str255; bStr: Str255): INTEGER;

{$ENDC}  {CALL_NOT_IN_CARBON}


{
 *  RelString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RelString(str1: Str255; str2: Str255; caseSensitive: BOOLEAN; diacSensitive: BOOLEAN): INTEGER;

{
 *  EqualString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION EqualString(str1: Str255; str2: Str255; caseSensitive: BOOLEAN; diacSensitive: BOOLEAN): BOOLEAN;



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := StringCompareIncludes}

{$ENDC} {__STRINGCOMPARE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

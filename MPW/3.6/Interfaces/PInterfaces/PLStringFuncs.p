{
     File:       PLStringFuncs.p
 
     Contains:   Pascal string manipulation routines that parallel ANSI C string.h
 
     Version:    Technology: Mac OS
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT PLStringFuncs;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PLSTRINGFUNCS__}
{$SETC __PLSTRINGFUNCS__ := 1}

{$I+}
{$SETC PLStringFuncsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
 *  PLstrcmp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PLstrcmp(str1: Str255; str2: Str255): INTEGER;

{
 *  PLstrncmp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PLstrncmp(str1: Str255; str2: Str255; num: INTEGER): INTEGER;

{
 *  PLstrcpy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PLstrcpy(str1: StringPtr; str2: Str255): StringPtr;

{
 *  PLstrncpy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PLstrncpy(str1: StringPtr; str2: Str255; num: INTEGER): StringPtr;

{
 *  PLstrcat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PLstrcat(str1: StringPtr; str2: Str255): StringPtr;

{
 *  PLstrncat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PLstrncat(str1: StringPtr; str2: Str255; num: INTEGER): StringPtr;

{
 *  PLstrchr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PLstrchr(str1: Str255; ch1: INTEGER): Ptr;

{
 *  PLstrrchr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PLstrrchr(str1: Str255; ch1: INTEGER): Ptr;

{
 *  PLstrpbrk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PLstrpbrk(str1: Str255; str2: Str255): Ptr;

{
 *  PLstrspn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PLstrspn(str1: Str255; str2: Str255): INTEGER;

{
 *  PLstrstr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PLstrstr(str1: Str255; str2: Str255): Ptr;

{
 *  PLstrlen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PLstrlen(str: Str255): INTEGER;

{
 *  PLpos()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PLpos(str1: Str255; str2: Str255): INTEGER;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PLStringFuncsIncludes}

{$ENDC} {__PLSTRINGFUNCS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

{
     File:       CFTimeZone.p
 
     Contains:   CoreFoundation time zone
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CFTimeZone;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFTIMEZONE__}
{$SETC __CFTIMEZONE__ := 1}

{$I+}
{$SETC CFTimeZoneIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
{$ENDC}
{$IFC UNDEFINED __CFDATA__}
{$I CFData.p}
{$ENDC}
{$IFC UNDEFINED __CFDATE__}
{$I CFDate.p}
{$ENDC}
{$IFC UNDEFINED __CFDICTIONARY__}
{$I CFDictionary.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ 
        ### Warning ###
        
    The CFTimeZone functions are not usable on when running on CarbonLib under
    Mac OS 8/9.  CFTimeZoneCreate will return NULL and most functions are no-ops.
    
    The CFTimeZone functions do work properly when running on Mac OS X.

}
{
 *  CFTimeZoneGetTypeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTimeZoneGetTypeID: CFTypeID; C;

{
 *  CFTimeZoneCopySystem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTimeZoneCopySystem: CFTimeZoneRef; C;

{
 *  CFTimeZoneResetSystem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFTimeZoneResetSystem; C;

{
 *  CFTimeZoneCopyDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTimeZoneCopyDefault: CFTimeZoneRef; C;

{
 *  CFTimeZoneSetDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFTimeZoneSetDefault(tz: CFTimeZoneRef); C;

{
 *  CFTimeZoneCopyKnownNames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTimeZoneCopyKnownNames: CFArrayRef; C;

{
 *  CFTimeZoneCopyAbbreviationDictionary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTimeZoneCopyAbbreviationDictionary: CFDictionaryRef; C;

{
 *  CFTimeZoneSetAbbreviationDictionary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFTimeZoneSetAbbreviationDictionary(dict: CFDictionaryRef); C;

{
 *  CFTimeZoneCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTimeZoneCreate(allocator: CFAllocatorRef; name: CFStringRef; data: CFDataRef): CFTimeZoneRef; C;

{
 *  CFTimeZoneCreateWithTimeIntervalFromGMT()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTimeZoneCreateWithTimeIntervalFromGMT(allocator: CFAllocatorRef; ti: CFTimeInterval): CFTimeZoneRef; C;

{
 *  CFTimeZoneCreateWithName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTimeZoneCreateWithName(allocator: CFAllocatorRef; name: CFStringRef; tryAbbrev: BOOLEAN): CFTimeZoneRef; C;

{
 *  CFTimeZoneGetName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTimeZoneGetName(tz: CFTimeZoneRef): CFStringRef; C;

{
 *  CFTimeZoneGetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTimeZoneGetData(tz: CFTimeZoneRef): CFDataRef; C;

{
 *  CFTimeZoneGetSecondsFromGMT()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTimeZoneGetSecondsFromGMT(tz: CFTimeZoneRef; at: CFAbsoluteTime): CFTimeInterval; C;

{
 *  CFTimeZoneCopyAbbreviation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTimeZoneCopyAbbreviation(tz: CFTimeZoneRef; at: CFAbsoluteTime): CFStringRef; C;

{
 *  CFTimeZoneIsDaylightSavingTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFTimeZoneIsDaylightSavingTime(tz: CFTimeZoneRef; at: CFAbsoluteTime): BOOLEAN; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFTimeZoneIncludes}

{$ENDC} {__CFTIMEZONE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

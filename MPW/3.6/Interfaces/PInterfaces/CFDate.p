{
     File:       CFDate.p
 
     Contains:   CoreFoundation date
 
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
 UNIT CFDate;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFDATE__}
{$SETC __CFDATE__ := 1}

{$I+}
{$SETC CFDateIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	CFTimeInterval						= Double;
	CFAbsoluteTime						= CFTimeInterval;
	{	 absolute time is the time interval since the reference date 	}
	{	 the reference date (epoch) is 00:00:00 1 January 2001. 	}
	{
	 *  CFAbsoluteTimeGetCurrent()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFAbsoluteTimeGetCurrent: CFAbsoluteTime; C;

{
 *  kCFAbsoluteTimeIntervalSince1970
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCFAbsoluteTimeIntervalSince1904
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }

TYPE
	CFDateRef    = ^LONGINT; { an opaque 32-bit type }
	CFDateRefPtr = ^CFDateRef;  { when a VAR xx:CFDateRef parameter can be nil, it is changed to xx: CFDateRefPtr }
	{
	 *  CFDateGetTypeID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFDateGetTypeID: CFTypeID; C;

{
 *  CFDateCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDateCreate(allocator: CFAllocatorRef; at: CFAbsoluteTime): CFDateRef; C;

{
 *  CFDateGetAbsoluteTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDateGetAbsoluteTime(theDate: CFDateRef): CFAbsoluteTime; C;

{
 *  CFDateGetTimeIntervalSinceDate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDateGetTimeIntervalSinceDate(theDate: CFDateRef; otherDate: CFDateRef): CFTimeInterval; C;

{
 *  CFDateCompare()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFDateCompare(theDate: CFDateRef; otherDate: CFDateRef; context: UNIV Ptr): CFComparisonResult; C;


TYPE
	CFTimeZoneRef    = ^LONGINT; { an opaque 32-bit type }
	CFTimeZoneRefPtr = ^CFTimeZoneRef;  { when a VAR xx:CFTimeZoneRef parameter can be nil, it is changed to xx: CFTimeZoneRefPtr }
	CFGregorianDatePtr = ^CFGregorianDate;
	CFGregorianDate = RECORD
		year:					SInt32;
		month:					SInt8;
		day:					SInt8;
		hour:					SInt8;
		minute:					SInt8;
		second:					Double;
	END;

	CFGregorianUnitsPtr = ^CFGregorianUnits;
	CFGregorianUnits = RECORD
		years:					SInt32;
		months:					SInt32;
		days:					SInt32;
		hours:					SInt32;
		minutes:				SInt32;
		seconds:				Double;
	END;

	CFGregorianUnitFlags 		= SInt32;
CONST
	kCFGregorianUnitsYears		= $01;
	kCFGregorianUnitsMonths		= $02;
	kCFGregorianUnitsDays		= $04;
	kCFGregorianUnitsHours		= $08;
	kCFGregorianUnitsMinutes	= $10;
	kCFGregorianUnitsSeconds	= $20;
	kCFGregorianAllUnits		= $00FFFFFF;

	{
	 *  CFGregorianDateIsValid()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFGregorianDateIsValid(gdate: CFGregorianDate; unitFlags: CFOptionFlags): BOOLEAN; C;

{
 *  CFGregorianDateGetAbsoluteTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFGregorianDateGetAbsoluteTime(gdate: CFGregorianDate; tz: CFTimeZoneRef): CFAbsoluteTime; C;

{
 *  CFAbsoluteTimeGetGregorianDate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFAbsoluteTimeGetGregorianDate(at: CFAbsoluteTime; tz: CFTimeZoneRef): CFGregorianDate; C;

{
 *  CFAbsoluteTimeAddGregorianUnits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFAbsoluteTimeAddGregorianUnits(at: CFAbsoluteTime; tz: CFTimeZoneRef; units: CFGregorianUnits): CFAbsoluteTime; C;

{
 *  CFAbsoluteTimeGetDifferenceAsGregorianUnits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFAbsoluteTimeGetDifferenceAsGregorianUnits(at1: CFAbsoluteTime; at2: CFAbsoluteTime; tz: CFTimeZoneRef; unitFlags: CFOptionFlags): CFGregorianUnits; C;

{
 *  CFAbsoluteTimeGetDayOfWeek()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFAbsoluteTimeGetDayOfWeek(at: CFAbsoluteTime; tz: CFTimeZoneRef): SInt32; C;

{
 *  CFAbsoluteTimeGetDayOfYear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFAbsoluteTimeGetDayOfYear(at: CFAbsoluteTime; tz: CFTimeZoneRef): SInt32; C;

{
 *  CFAbsoluteTimeGetWeekOfYear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFAbsoluteTimeGetWeekOfYear(at: CFAbsoluteTime; tz: CFTimeZoneRef): SInt32; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFDateIncludes}

{$ENDC} {__CFDATE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

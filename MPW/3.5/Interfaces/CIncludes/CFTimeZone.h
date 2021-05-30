/*
     File:       CFTimeZone.h
 
     Contains:   CoreFoundation time zone
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CFTIMEZONE__
#define __CFTIMEZONE__

#ifndef __CFBASE__
#include <CFBase.h>
#endif

#ifndef __CFARRAY__
#include <CFArray.h>
#endif

#ifndef __CFDATA__
#include <CFData.h>
#endif

#ifndef __CFDATE__
#include <CFDate.h>
#endif

#ifndef __CFDICTIONARY__
#include <CFDictionary.h>
#endif

#ifndef __CFSTRING__
#include <CFString.h>
#endif




#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
    #pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
    #pragma pack(2)
#endif

/* 
        ### Warning ###
        
    The CFTimeZone functions are not usable on when running on CarbonLib under
    Mac OS 8/9.  CFTimeZoneCreate will return NULL and most functions are no-ops.
    
    The CFTimeZone functions do work properly when running on Mac OS X.

*/
/*
 *  CFTimeZoneGetTypeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTypeID )
CFTimeZoneGetTypeID(void);


/*
 *  CFTimeZoneCopySystem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTimeZoneRef )
CFTimeZoneCopySystem(void);


/*
 *  CFTimeZoneResetSystem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFTimeZoneResetSystem(void);


/*
 *  CFTimeZoneCopyDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTimeZoneRef )
CFTimeZoneCopyDefault(void);


/*
 *  CFTimeZoneSetDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFTimeZoneSetDefault(CFTimeZoneRef tz);


/*
 *  CFTimeZoneCopyKnownNames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFArrayRef )
CFTimeZoneCopyKnownNames(void);


/*
 *  CFTimeZoneCopyAbbreviationDictionary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFDictionaryRef )
CFTimeZoneCopyAbbreviationDictionary(void);


/*
 *  CFTimeZoneSetAbbreviationDictionary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFTimeZoneSetAbbreviationDictionary(CFDictionaryRef dict);


/*
 *  CFTimeZoneCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTimeZoneRef )
CFTimeZoneCreate(
  CFAllocatorRef   allocator,
  CFStringRef      name,
  CFDataRef        data);


/*
 *  CFTimeZoneCreateWithTimeIntervalFromGMT()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTimeZoneRef )
CFTimeZoneCreateWithTimeIntervalFromGMT(
  CFAllocatorRef   allocator,
  CFTimeInterval   ti);


/*
 *  CFTimeZoneCreateWithName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTimeZoneRef )
CFTimeZoneCreateWithName(
  CFAllocatorRef   allocator,
  CFStringRef      name,
  Boolean          tryAbbrev);


/*
 *  CFTimeZoneGetName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFTimeZoneGetName(CFTimeZoneRef tz);


/*
 *  CFTimeZoneGetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFDataRef )
CFTimeZoneGetData(CFTimeZoneRef tz);


/*
 *  CFTimeZoneGetSecondsFromGMT()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTimeInterval )
CFTimeZoneGetSecondsFromGMT(
  CFTimeZoneRef    tz,
  CFAbsoluteTime   at);


/*
 *  CFTimeZoneCopyAbbreviation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFTimeZoneCopyAbbreviation(
  CFTimeZoneRef    tz,
  CFAbsoluteTime   at);


/*
 *  CFTimeZoneIsDaylightSavingTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFTimeZoneIsDaylightSavingTime(
  CFTimeZoneRef    tz,
  CFAbsoluteTime   at);



#if PRAGMA_STRUCT_ALIGN
    #pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
    #pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __CFTIMEZONE__ */


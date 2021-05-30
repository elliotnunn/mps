/*
     File:       CFPreferences.h
 
     Contains:   CoreFoundation preferences
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CFPREFERENCES__
#define __CFPREFERENCES__

#ifndef __CFBASE__
#include <CFBase.h>
#endif

#ifndef __CFARRAY__
#include <CFArray.h>
#endif

#ifndef __CFPROPERTYLIST__
#include <CFPropertyList.h>
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
 *  kCFPreferencesAnyApplication
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFPreferencesAnyApplication;
/*
 *  kCFPreferencesCurrentApplication
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFPreferencesCurrentApplication;
/*
 *  kCFPreferencesAnyHost
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFPreferencesAnyHost;
/*
 *  kCFPreferencesCurrentHost
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFPreferencesCurrentHost;
/*
 *  kCFPreferencesAnyUser
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFPreferencesAnyUser;
/*
 *  kCFPreferencesCurrentUser
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFPreferencesCurrentUser;
/*    The "App" functions search the various sources of defaults that
    apply to the given application, and should never be called with
    kCFPreferencesAnyApplication - only kCFPreferencesCurrentApplication
    or an application's ID (its bundle identifier).
*/
/* Searches the various sources of application defaults to find the
value for the given key. key must not be NULL.  If a value is found,
it returns it; otherwise returns NULL.  Caller must release the
returned value */
/*
 *  CFPreferencesCopyAppValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFPropertyListRef )
CFPreferencesCopyAppValue(
  CFStringRef   key,
  CFStringRef   applicationID);


/* Convenience to interpret a preferences value as a boolean directly.
Returns FALSE if the key doesn't exist, or has an improper format; under
those conditions, keyExistsAndHasValidFormat (if non-NULL) is set to FALSE */
/*
 *  CFPreferencesGetAppBooleanValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFPreferencesGetAppBooleanValue(
  CFStringRef   key,
  CFStringRef   applicationID,
  Boolean *     keyExistsAndHasValidFormat);


/* Convenience to interpret a preferences value as an integer directly.
Returns 0 if the key doesn't exist, or has an improper format; under
those conditions, keyExistsAndHasValidFormat (if non-NULL) is set to FALSE */
/*
 *  CFPreferencesGetAppIntegerValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFIndex )
CFPreferencesGetAppIntegerValue(
  CFStringRef   key,
  CFStringRef   applicationID,
  Boolean *     keyExistsAndHasValidFormat);


/* Sets the given value for the given key in the "normal" place for
application preferences.  key must not be NULL.  If value is NULL,
key is removed instead. */
/*
 *  CFPreferencesSetAppValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFPreferencesSetAppValue(
  CFStringRef         key,
  CFPropertyListRef   value,
  CFStringRef         applicationID);


/* Adds the preferences for the given suite to the app preferences for
the specified application.  To write to the suite domain, use
CFPreferencesSetValue(), below, using the suiteName in place
of the appName */
/*
 *  CFPreferencesAddSuitePreferencesToApp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFPreferencesAddSuitePreferencesToApp(
  CFStringRef   applicationID,
  CFStringRef   suiteID);


/*
 *  CFPreferencesRemoveSuitePreferencesFromApp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFPreferencesRemoveSuitePreferencesFromApp(
  CFStringRef   applicationID,
  CFStringRef   suiteID);


/* Writes all changes in all sources of application defaults.
Returns success or failure. */
/*
 *  CFPreferencesAppSynchronize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFPreferencesAppSynchronize(CFStringRef applicationID);


/* The primitive get mechanism; all arguments must be non-NULL
(use the constants above for common values).  Only the exact
location specified by app-user-host is searched.  The returned
CFType must be released by the caller when it is finished with it. */
/*
 *  CFPreferencesCopyValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFPropertyListRef )
CFPreferencesCopyValue(
  CFStringRef   key,
  CFStringRef   applicationID,
  CFStringRef   userName,
  CFStringRef   hostName);


/* Convenience to fetch multiple keys at once.  Keys in
keysToFetch that are not present in the returned dictionary
are not present in the domain.  If keysToFetch is NULL, all
keys are fetched. */
/*
 *  CFPreferencesCopyMultiple()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFDictionaryRef )
CFPreferencesCopyMultiple(
  CFArrayRef    keysToFetch,
  CFStringRef   applicationID,
  CFStringRef   userName,
  CFStringRef   hostName);


/* The primitive set function; all arguments except value must be
non-NULL.  If value is NULL, the given key is removed */
/*
 *  CFPreferencesSetValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFPreferencesSetValue(
  CFStringRef         key,
  CFPropertyListRef   value,
  CFStringRef         applicationID,
  CFStringRef         userName,
  CFStringRef         hostName);


/* Convenience to set multiple values at once.  Behavior is undefined
if a key is in both keysToSet and keysToRemove */
/*
 *  CFPreferencesSetMultiple()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFPreferencesSetMultiple(
  CFDictionaryRef   keysToSet,
  CFArrayRef        keysToRemove,
  CFStringRef       applicationID,
  CFStringRef       userName,
  CFStringRef       hostName);


/*
 *  CFPreferencesSynchronize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFPreferencesSynchronize(
  CFStringRef   applicationID,
  CFStringRef   userName,
  CFStringRef   hostName);


/* Constructs and returns the list of the name of all applications
which have preferences in the scope of the given user and host.
The returned value must be released by the caller; neither argument
may be NULL. */
/*
 *  CFPreferencesCopyApplicationList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFArrayRef )
CFPreferencesCopyApplicationList(
  CFStringRef   userName,
  CFStringRef   hostName);


/* Constructs and returns the list of all keys set in the given
location.  The returned value must be released by the caller;
all arguments must be non-NULL */
/*
 *  CFPreferencesCopyKeyList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFArrayRef )
CFPreferencesCopyKeyList(
  CFStringRef   applicationID,
  CFStringRef   userName,
  CFStringRef   hostName);



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

#endif /* __CFPREFERENCES__ */


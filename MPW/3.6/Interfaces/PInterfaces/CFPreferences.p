{
     File:       CFPreferences.p
 
     Contains:   CoreFoundation preferences
 
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
 UNIT CFPreferences;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFPREFERENCES__}
{$SETC __CFPREFERENCES__ := 1}

{$I+}
{$SETC CFPreferencesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
{$ENDC}
{$IFC UNDEFINED __CFPROPERTYLIST__}
{$I CFPropertyList.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
 *  kCFPreferencesAnyApplication
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCFPreferencesCurrentApplication
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCFPreferencesAnyHost
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCFPreferencesCurrentHost
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCFPreferencesAnyUser
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
{
 *  kCFPreferencesCurrentUser
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
{    The "App" functions search the various sources of defaults that
    apply to the given application, and should never be called with
    kCFPreferencesAnyApplication - only kCFPreferencesCurrentApplication
    or an application's ID (its bundle identifier).
}
{ Searches the various sources of application defaults to find the
value for the given key. key must not be NULL.  If a value is found,
it returns it; otherwise returns NULL.  Caller must release the
returned value }
{
 *  CFPreferencesCopyAppValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPreferencesCopyAppValue(key: CFStringRef; applicationID: CFStringRef): CFPropertyListRef; C;

{ Convenience to interpret a preferences value as a boolean directly.
Returns FALSE if the key doesn't exist, or has an improper format; under
those conditions, keyExistsAndHasValidFormat (if non-NULL) is set to FALSE }
{
 *  CFPreferencesGetAppBooleanValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPreferencesGetAppBooleanValue(key: CFStringRef; applicationID: CFStringRef; VAR keyExistsAndHasValidFormat: BOOLEAN): BOOLEAN; C;

{ Convenience to interpret a preferences value as an integer directly.
Returns 0 if the key doesn't exist, or has an improper format; under
those conditions, keyExistsAndHasValidFormat (if non-NULL) is set to FALSE }
{
 *  CFPreferencesGetAppIntegerValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPreferencesGetAppIntegerValue(key: CFStringRef; applicationID: CFStringRef; VAR keyExistsAndHasValidFormat: BOOLEAN): CFIndex; C;

{ Sets the given value for the given key in the "normal" place for
application preferences.  key must not be NULL.  If value is NULL,
key is removed instead. }
{
 *  CFPreferencesSetAppValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFPreferencesSetAppValue(key: CFStringRef; value: CFPropertyListRef; applicationID: CFStringRef); C;

{ Adds the preferences for the given suite to the app preferences for
the specified application.  To write to the suite domain, use
CFPreferencesSetValue(), below, using the suiteName in place
of the appName }
{
 *  CFPreferencesAddSuitePreferencesToApp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFPreferencesAddSuitePreferencesToApp(applicationID: CFStringRef; suiteID: CFStringRef); C;

{
 *  CFPreferencesRemoveSuitePreferencesFromApp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFPreferencesRemoveSuitePreferencesFromApp(applicationID: CFStringRef; suiteID: CFStringRef); C;

{ Writes all changes in all sources of application defaults.
Returns success or failure. }
{
 *  CFPreferencesAppSynchronize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPreferencesAppSynchronize(applicationID: CFStringRef): BOOLEAN; C;

{ The primitive get mechanism; all arguments must be non-NULL
(use the constants above for common values).  Only the exact
location specified by app-user-host is searched.  The returned
CFType must be released by the caller when it is finished with it. }
{
 *  CFPreferencesCopyValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPreferencesCopyValue(key: CFStringRef; applicationID: CFStringRef; userName: CFStringRef; hostName: CFStringRef): CFPropertyListRef; C;

{ Convenience to fetch multiple keys at once.  Keys in
keysToFetch that are not present in the returned dictionary
are not present in the domain.  If keysToFetch is NULL, all
keys are fetched. }
{
 *  CFPreferencesCopyMultiple()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPreferencesCopyMultiple(keysToFetch: CFArrayRef; applicationID: CFStringRef; userName: CFStringRef; hostName: CFStringRef): CFDictionaryRef; C;

{ The primitive set function; all arguments except value must be
non-NULL.  If value is NULL, the given key is removed }
{
 *  CFPreferencesSetValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFPreferencesSetValue(key: CFStringRef; value: CFPropertyListRef; applicationID: CFStringRef; userName: CFStringRef; hostName: CFStringRef); C;

{ Convenience to set multiple values at once.  Behavior is undefined
if a key is in both keysToSet and keysToRemove }
{
 *  CFPreferencesSetMultiple()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFPreferencesSetMultiple(keysToSet: CFDictionaryRef; keysToRemove: CFArrayRef; applicationID: CFStringRef; userName: CFStringRef; hostName: CFStringRef); C;

{
 *  CFPreferencesSynchronize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPreferencesSynchronize(applicationID: CFStringRef; userName: CFStringRef; hostName: CFStringRef): BOOLEAN; C;

{ Constructs and returns the list of the name of all applications
which have preferences in the scope of the given user and host.
The returned value must be released by the caller; neither argument
may be NULL. }
{
 *  CFPreferencesCopyApplicationList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPreferencesCopyApplicationList(userName: CFStringRef; hostName: CFStringRef): CFArrayRef; C;

{ Constructs and returns the list of all keys set in the given
location.  The returned value must be released by the caller;
all arguments must be non-NULL }
{
 *  CFPreferencesCopyKeyList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFPreferencesCopyKeyList(applicationID: CFStringRef; userName: CFStringRef; hostName: CFStringRef): CFArrayRef; C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFPreferencesIncludes}

{$ENDC} {__CFPREFERENCES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

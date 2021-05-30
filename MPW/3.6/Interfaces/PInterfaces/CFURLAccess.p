{
     File:       CFURLAccess.p
 
     Contains:   CoreFoundation url access
 
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
 UNIT CFURLAccess;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFURLACCESS__}
{$SETC __CFURLACCESS__ := 1}

{$I+}
{$SETC CFURLAccessIncludes := UsingIncludes}
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
{$IFC UNDEFINED __CFDICTIONARY__}
{$I CFDictionary.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __CFURL__}
{$I CFURL.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Attempts to read the data and properties for the given URL.  If
only interested in one of the resourceData and properties, pass NULL
for the other.  If properties is non-NULL and desiredProperties is
NULL, then all properties are fetched.  Returns success or failure;
note that as much work as possible is done even if FALSE is returned.
So for instance if one property is not available, the others are
fetched anyway. errorCode is set to 0 on success, and some other
value on failure.  If non-NULL, it is the caller 's responsibility
to release resourceData and properties.

    Apple reserves for its use all negative error code values; these
values represent errors common to any scheme.  Scheme-specific error
codes should be positive, non-zero, and should be used only if one of
the predefined Apple error codes does not apply.  Error codes should
be publicized and documented with the scheme-specific properties.
}
{
 *  CFURLCreateDataAndPropertiesFromResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreateDataAndPropertiesFromResource(alloc: CFAllocatorRef; url: CFURLRef; VAR resourceData: CFDataRef; VAR properties: CFDictionaryRef; desiredProperties: CFArrayRef; VAR errorCode: SInt32): BOOLEAN; C;

{ Attempts to write the given data and properties to the given URL.
If dataToWrite is NULL, only properties are written out (use
CFURLDestroyResource() to delete a resource).  Properties not present
in propertiesToWrite are left unchanged, hence if propertiesToWrite
is NULL or empty, the URL's properties are not changed at all.
Returns success or failure; errorCode is set as for
CFURLCreateDataAndPropertiesFromResource(), above.
}
{
 *  CFURLWriteDataAndPropertiesToResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLWriteDataAndPropertiesToResource(url: CFURLRef; dataToWrite: CFDataRef; propertiesToWrite: CFDictionaryRef; VAR errorCode: SInt32): BOOLEAN; C;

{ Destroys the resource indicated by url. }
{ Returns success or failure; errorCode set as above. }
{
 *  CFURLDestroyResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLDestroyResource(url: CFURLRef; VAR errorCode: SInt32): BOOLEAN; C;

{ Convenience method which calls through to CFURLCreateDataAndPropertiesFromResource(). }
{ Returns NULL on error and sets errorCode accordingly. }
{
 *  CFURLCreatePropertyFromResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFURLCreatePropertyFromResource(alloc: CFAllocatorRef; url: CFURLRef; property: CFStringRef; VAR errorCode: SInt32): CFTypeRef; C;

{ Common error codes; this list is expected to grow }

TYPE
	CFURLError 					= SInt32;
CONST
	kCFURLUnknownError			= -10;
	kCFURLUnknownSchemeError	= -11;
	kCFURLResourceNotFoundError	= -12;
	kCFURLResourceAccessViolationError = -13;
	kCFURLRemoteHostUnavailableError = -14;
	kCFURLImproperArgumentsError = -15;
	kCFURLUnknownPropertyKeyError = -16;
	kCFURLPropertyKeyUnavailableError = -17;
	kCFURLTimeoutError			= -18;

	{	 Property keys 	}
	{
	 *  kCFURLFileExists
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{
	 *  kCFURLFileDirectoryContents
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{
	 *  kCFURLFileLength
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{
	 *  kCFURLFileLastModificationTime
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{
	 *  kCFURLFilePOSIXMode
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{
	 *  kCFURLFileOwnerID
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{
	 *  kCFURLHTTPStatusCode
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{
	 *  kCFURLHTTPStatusLine
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{	 The value of kCFURLFileExists is a CFBoolean 	}
	{	 The value of kCFURLFileDirectoryContents is a CFArray containing CFURLs.  An empty array means the directory exists, but is empty 	}
	{	 The value of kCFURLFileLength is a CFNumber giving the file's length in bytes 	}
	{	 The value of kCFURLFileLastModificationTime is a CFDate 	}
	{	 The value of kCFURLFilePOSIXMode is a CFNumber as given in stat.h 	}
	{	 The value of kCFURLFileOwnerID is a CFNumber representing the owner's uid 	}
	{	 Properties for the http: scheme.  Except for the common error codes, above, errorCode will be set to the HTTP response status code upon failure.  Any HTTP header name can also be used as a property 	}
	{	 The value of kCFURLHTTPStatusCode is a CFNumber 	}
	{	 The value of kCFURLHTTPStatusLine is a CFString 	}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFURLAccessIncludes}

{$ENDC} {__CFURLACCESS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

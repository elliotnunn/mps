{
     File:       CFBundle.p
 
     Contains:   CoreFoundation bundle
 
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
 UNIT CFBundle;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CFBUNDLE__}
{$SETC __CFBUNDLE__ := 1}

{$I+}
{$SETC CFBundleIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CFBASE__}
{$I CFBase.p}
{$ENDC}
{$IFC UNDEFINED __CFARRAY__}
{$I CFArray.p}
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


TYPE
	CFBundleRef    = ^LONGINT; { an opaque 32-bit type }
	CFBundleRefPtr = ^CFBundleRef;  { when a VAR xx:CFBundleRef parameter can be nil, it is changed to xx: CFBundleRefPtr }
	CFPlugInRef    = CFBundleRef;
	CFPlugInRefPtr = ^CFPlugInRef;  { when a VAR xx:CFPlugInRef parameter can be nil, it is changed to xx: CFPlugInRefPtr }
	{	 ===================== Standard Info.plist keys ===================== 	}
	{
	 *  kCFBundleInfoDictionaryVersionKey
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{	 The version of the Info.plist format 	}
	{
	 *  kCFBundleExecutableKey
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{	 The name of the executable in this bundle (if any) 	}
	{
	 *  kCFBundleIdentifierKey
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{	 The bundle identifier (for CFBundleGetBundleWithIdentifier()) 	}
	{
	 *  kCFBundleVersionKey
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{	 The version number of the bundle.  Clients should use CFBundleGetVersionNumber() instead of accessing this key directly
	    since that function will properly convert a version number in string format into its interger representation. 	}
	{
	 *  kCFBundleDevelopmentRegionKey
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{	 The name of the development language of the bundle. 	}
	{
	 *  kCFBundleNameKey
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
	{	 The human-readable name of the bundle.  This key is often found in the InfoPlist.strings since it is usually localized. 	}
	{	 ===================== Finding Bundles ===================== 	}
	{
	 *  CFBundleGetMainBundle()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CFBundleGetMainBundle: CFBundleRef; C;

{
 *  CFBundleGetBundleWithIdentifier()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleGetBundleWithIdentifier(bundleID: CFStringRef): CFBundleRef; C;

{ A bundle can name itself by providing a key in the info dictionary. }
{ This facility is meant to allow bundle-writers to get hold of their }
{ bundle from their code without having to know where it was on the disk. }
{ This is meant to be a replacement mechanism for +bundleForClass: users. }
{
 *  CFBundleGetAllBundles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleGetAllBundles: CFArrayRef; C;

{ This is potentially expensive.  Use with care. }
{ ===================== Creating Bundles ===================== }
{
 *  CFBundleGetTypeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleGetTypeID: UInt32; C;

{
 *  CFBundleCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCreate(allocator: CFAllocatorRef; bundleURL: CFURLRef): CFBundleRef; C;

{ Might return an existing instance with the ref-count bumped. }
{
 *  CFBundleCreateBundlesFromDirectory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCreateBundlesFromDirectory(allocator: CFAllocatorRef; directoryURL: CFURLRef; bundleType: CFStringRef): CFArrayRef; C;

{ Create instances for all bundles in the given directory matching the given }
{ type (or all of them if bundleType is NULL) }
{ ==================== Basic Bundle Info ==================== }
{
 *  CFBundleCopyBundleURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyBundleURL(bundle: CFBundleRef): CFURLRef; C;

{
 *  CFBundleGetValueForInfoDictionaryKey()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleGetValueForInfoDictionaryKey(bundle: CFBundleRef; key: CFStringRef): CFTypeRef; C;

{ Returns a localized value if available, otherwise the global value. }
{
 *  CFBundleGetInfoDictionary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleGetInfoDictionary(bundle: CFBundleRef): CFDictionaryRef; C;

{ This is the global info dictionary.  Note that CFBundle may add }
{ extra keys to the dictionary for its own use. }
{
 *  CFBundleGetLocalInfoDictionary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleGetLocalInfoDictionary(bundle: CFBundleRef): CFDictionaryRef; C;

{ This is the localized info dictionary. }
{
 *  CFBundleGetPackageInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFBundleGetPackageInfo(bundle: CFBundleRef; VAR packageType: UInt32; VAR packageCreator: UInt32); C;

{
 *  CFBundleGetIdentifier()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleGetIdentifier(bundle: CFBundleRef): CFStringRef; C;

{
 *  CFBundleGetVersionNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleGetVersionNumber(bundle: CFBundleRef): UInt32; C;

{
 *  CFBundleGetDevelopmentRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleGetDevelopmentRegion(bundle: CFBundleRef): CFStringRef; C;

{
 *  CFBundleCopySupportFilesDirectoryURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopySupportFilesDirectoryURL(bundle: CFBundleRef): CFURLRef; C;

{
 *  CFBundleCopyResourcesDirectoryURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyResourcesDirectoryURL(bundle: CFBundleRef): CFURLRef; C;

{
 *  CFBundleCopyPrivateFrameworksURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyPrivateFrameworksURL(bundle: CFBundleRef): CFURLRef; C;

{
 *  CFBundleCopySharedFrameworksURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopySharedFrameworksURL(bundle: CFBundleRef): CFURLRef; C;

{
 *  CFBundleCopySharedSupportURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopySharedSupportURL(bundle: CFBundleRef): CFURLRef; C;

{
 *  CFBundleCopyBuiltInPlugInsURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyBuiltInPlugInsURL(bundle: CFBundleRef): CFURLRef; C;

{ ------------- Basic Bundle Info without a CFBundle instance ------------- }
{ This API is provided to enable developers to retrieve basic information }
{ about a bundle without having to create an instance of CFBundle. }
{
 *  CFBundleCopyInfoDictionaryInDirectory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyInfoDictionaryInDirectory(bundleURL: CFURLRef): CFDictionaryRef; C;

{
 *  CFBundleGetPackageInfoInDirectory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleGetPackageInfoInDirectory(url: CFURLRef; VAR packageType: UInt32; VAR packageCreator: UInt32): BOOLEAN; C;

{ ==================== Resource Handling API ==================== }
{
 *  CFBundleCopyResourceURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyResourceURL(bundle: CFBundleRef; resourceName: CFStringRef; resourceType: CFStringRef; subDirName: CFStringRef): CFURLRef; C;

{
 *  CFBundleCopyResourceURLsOfType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyResourceURLsOfType(bundle: CFBundleRef; resourceType: CFStringRef; subDirName: CFStringRef): CFArrayRef; C;

{
 *  CFBundleCopyLocalizedString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyLocalizedString(bundle: CFBundleRef; key: CFStringRef; value: CFStringRef; tableName: CFStringRef): CFStringRef; C;

{ ------------- Resource Handling without a CFBundle instance ------------- }
{ This API is provided to enable developers to use the CFBundle resource }
{ searching policy without having to create an instance of CFBundle. }
{ Because of caching behavior when a CFBundle instance exists, it will be faster }
{ to actually create a CFBundle if you need to access several resources. }
{
 *  CFBundleCopyResourceURLInDirectory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyResourceURLInDirectory(bundleURL: CFURLRef; resourceName: CFStringRef; resourceType: CFStringRef; subDirName: CFStringRef): CFURLRef; C;

{
 *  CFBundleCopyResourceURLsOfTypeInDirectory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyResourceURLsOfTypeInDirectory(bundleURL: CFURLRef; resourceType: CFStringRef; subDirName: CFStringRef): CFArrayRef; C;

{ =========== Localization-specific Resource Handling API =========== }
{ This API allows finer-grained control over specific localizations,  }
{ as distinguished from the above API, which always uses the user's   }
{ preferred localizations.  }
{
 *  CFBundleCopyBundleLocalizations()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyBundleLocalizations(bundle: CFBundleRef): CFArrayRef; C;

{ Lists the localizations that a bundle contains.  }
{
 *  CFBundleCopyPreferredLocalizationsFromArray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyPreferredLocalizationsFromArray(locArray: CFArrayRef): CFArrayRef; C;

{ Given an array of possible localizations, returns the one or more }
{ that CFBundle would use in the current context. To find out which }
{ localizations are in use for a particular bundle, apply this to   }
{ the result of CFBundleCopyBundleLocalizations.  }
{
 *  CFBundleCopyResourceURLForLocalization()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyResourceURLForLocalization(bundle: CFBundleRef; resourceName: CFStringRef; resourceType: CFStringRef; subDirName: CFStringRef; localizationName: CFStringRef): CFURLRef; C;

{
 *  CFBundleCopyResourceURLsOfTypeForLocalization()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyResourceURLsOfTypeForLocalization(bundle: CFBundleRef; resourceType: CFStringRef; subDirName: CFStringRef; localizationName: CFStringRef): CFArrayRef; C;

{ ==================== Primitive Code Loading API ==================== }
{ This API abstracts the various different executable formats supported on }
{ various platforms.  It can load DYLD, CFM, or DLL shared libraries (on their }
{ appropriate platforms) and gives a uniform API for looking up functions. }
{ Note that Cocoa-based bundles containing Objective-C or Java code must }
{ be loaded with NSBundle, not CFBundle.  Once they are loaded, however, }
{ either CFBundle or NSBundle can be used. }
{
 *  CFBundleCopyExecutableURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyExecutableURL(bundle: CFBundleRef): CFURLRef; C;

{
 *  CFBundleIsExecutableLoaded()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleIsExecutableLoaded(bundle: CFBundleRef): BOOLEAN; C;

{
 *  CFBundleLoadExecutable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleLoadExecutable(bundle: CFBundleRef): BOOLEAN; C;

{
 *  CFBundleUnloadExecutable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFBundleUnloadExecutable(bundle: CFBundleRef); C;

{
 *  CFBundleGetFunctionPointerForName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleGetFunctionPointerForName(bundle: CFBundleRef; functionName: CFStringRef): Ptr; C;

{
 *  CFBundleGetFunctionPointersForNames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFBundleGetFunctionPointersForNames(bundle: CFBundleRef; functionNames: CFArrayRef; VAR ftbl: UNIV Ptr); C;

{
 *  CFBundleGetDataPointerForName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleGetDataPointerForName(bundle: CFBundleRef; symbolName: CFStringRef): Ptr; C;

{
 *  CFBundleGetDataPointersForNames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFBundleGetDataPointersForNames(bundle: CFBundleRef; symbolNames: CFArrayRef; VAR stbl: UNIV Ptr); C;

{
 *  CFBundleCopyAuxiliaryExecutableURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleCopyAuxiliaryExecutableURL(bundle: CFBundleRef; executableName: CFStringRef): CFURLRef; C;

{ This function can be used to find executables other than your main }
{ executable.  This is useful, for instance, for applications that have }
{ some command line tool that is packaged with and used by the application. }
{ The tool can be packaged in the various platform executable directories }
{ in the bundle and can be located with this function.  This allows an }
{ app to ship versions of the tool for each platform as it does for the }
{ main app executable. }
{ ==================== Getting a bundle's plugIn ==================== }
{
 *  CFBundleGetPlugIn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleGetPlugIn(bundle: CFBundleRef): CFPlugInRef; C;

{ ==================== Resource Manager-Related API ==================== }
{
 *  CFBundleOpenBundleResourceMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleOpenBundleResourceMap(bundle: CFBundleRef): INTEGER; C;

{ This function opens the non-localized and the localized resource files }
{ (if any) for the bundle, creates and makes current a single read-only }
{ resource map combining both, and returns a reference number for it. }
{ If it is called multiple times, it opens the files multiple times, }
{ and returns distinct reference numbers.  }
{
 *  CFBundleOpenBundleResourceFiles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CFBundleOpenBundleResourceFiles(bundle: CFBundleRef; VAR refNum: INTEGER; VAR localizedRefNum: INTEGER): SInt32; C;

{ Similar to CFBundleOpenBundleResourceMap, except that it creates two }
{ separate resource maps and returns reference numbers for both. }
{
 *  CFBundleCloseBundleResourceMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CFBundleCloseBundleResourceMap(bundle: CFBundleRef; refNum: INTEGER); C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CFBundleIncludes}

{$ENDC} {__CFBUNDLE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

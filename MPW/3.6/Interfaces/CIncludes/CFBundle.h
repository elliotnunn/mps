/*
     File:       CFBundle.h
 
     Contains:   CoreFoundation bundle
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CFBUNDLE__
#define __CFBUNDLE__

#ifndef __CFBASE__
#include <CFBase.h>
#endif

#ifndef __CFARRAY__
#include <CFArray.h>
#endif

#ifndef __CFDICTIONARY__
#include <CFDictionary.h>
#endif

#ifndef __CFSTRING__
#include <CFString.h>
#endif

#ifndef __CFURL__
#include <CFURL.h>
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

typedef struct __CFBundle*              CFBundleRef;
typedef struct __CFBundle*              CFPlugInRef;
/* ===================== Standard Info.plist keys ===================== */
/*
 *  kCFBundleInfoDictionaryVersionKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFBundleInfoDictionaryVersionKey;
/* The version of the Info.plist format */
/*
 *  kCFBundleExecutableKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFBundleExecutableKey;
/* The name of the executable in this bundle (if any) */
/*
 *  kCFBundleIdentifierKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFBundleIdentifierKey;
/* The bundle identifier (for CFBundleGetBundleWithIdentifier()) */
/*
 *  kCFBundleVersionKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFBundleVersionKey;
/* The version number of the bundle.  Clients should use CFBundleGetVersionNumber() instead of accessing this key directly
    since that function will properly convert a version number in string format into its interger representation. */
/*
 *  kCFBundleDevelopmentRegionKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFBundleDevelopmentRegionKey;
/* The name of the development language of the bundle. */
/*
 *  kCFBundleNameKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFBundleNameKey;
/* The human-readable name of the bundle.  This key is often found in the InfoPlist.strings since it is usually localized. */
/* ===================== Finding Bundles ===================== */
/*
 *  CFBundleGetMainBundle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFBundleRef )
CFBundleGetMainBundle(void);


/*
 *  CFBundleGetBundleWithIdentifier()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFBundleRef )
CFBundleGetBundleWithIdentifier(CFStringRef bundleID);


/* A bundle can name itself by providing a key in the info dictionary. */
/* This facility is meant to allow bundle-writers to get hold of their */
/* bundle from their code without having to know where it was on the disk. */
/* This is meant to be a replacement mechanism for +bundleForClass: users. */
/*
 *  CFBundleGetAllBundles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFArrayRef )
CFBundleGetAllBundles(void);


/* This is potentially expensive.  Use with care. */
/* ===================== Creating Bundles ===================== */
/*
 *  CFBundleGetTypeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( UInt32 )
CFBundleGetTypeID(void);


/*
 *  CFBundleCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFBundleRef )
CFBundleCreate(
  CFAllocatorRef   allocator,
  CFURLRef         bundleURL);


/* Might return an existing instance with the ref-count bumped. */
/*
 *  CFBundleCreateBundlesFromDirectory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFArrayRef )
CFBundleCreateBundlesFromDirectory(
  CFAllocatorRef   allocator,
  CFURLRef         directoryURL,
  CFStringRef      bundleType);


/* Create instances for all bundles in the given directory matching the given */
/* type (or all of them if bundleType is NULL) */
/* ==================== Basic Bundle Info ==================== */
/*
 *  CFBundleCopyBundleURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFBundleCopyBundleURL(CFBundleRef bundle);


/*
 *  CFBundleGetValueForInfoDictionaryKey()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTypeRef )
CFBundleGetValueForInfoDictionaryKey(
  CFBundleRef   bundle,
  CFStringRef   key);


/* Returns a localized value if available, otherwise the global value. */
/*
 *  CFBundleGetInfoDictionary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFDictionaryRef )
CFBundleGetInfoDictionary(CFBundleRef bundle);


/* This is the global info dictionary.  Note that CFBundle may add */
/* extra keys to the dictionary for its own use. */
/*
 *  CFBundleGetLocalInfoDictionary()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFDictionaryRef )
CFBundleGetLocalInfoDictionary(CFBundleRef bundle);


/* This is the localized info dictionary. */
/*
 *  CFBundleGetPackageInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFBundleGetPackageInfo(
  CFBundleRef   bundle,
  UInt32 *      packageType,
  UInt32 *      packageCreator);


/*
 *  CFBundleGetIdentifier()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFBundleGetIdentifier(CFBundleRef bundle);


/*
 *  CFBundleGetVersionNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( UInt32 )
CFBundleGetVersionNumber(CFBundleRef bundle);


/*
 *  CFBundleGetDevelopmentRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFBundleGetDevelopmentRegion(CFBundleRef bundle);


/*
 *  CFBundleCopySupportFilesDirectoryURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFBundleCopySupportFilesDirectoryURL(CFBundleRef bundle);


/*
 *  CFBundleCopyResourcesDirectoryURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFBundleCopyResourcesDirectoryURL(CFBundleRef bundle);


/*
 *  CFBundleCopyPrivateFrameworksURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFBundleCopyPrivateFrameworksURL(CFBundleRef bundle);


/*
 *  CFBundleCopySharedFrameworksURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFBundleCopySharedFrameworksURL(CFBundleRef bundle);


/*
 *  CFBundleCopySharedSupportURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFBundleCopySharedSupportURL(CFBundleRef bundle);


/*
 *  CFBundleCopyBuiltInPlugInsURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFBundleCopyBuiltInPlugInsURL(CFBundleRef bundle);


/* ------------- Basic Bundle Info without a CFBundle instance ------------- */
/* This API is provided to enable developers to retrieve basic information */
/* about a bundle without having to create an instance of CFBundle. */
/*
 *  CFBundleCopyInfoDictionaryInDirectory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFDictionaryRef )
CFBundleCopyInfoDictionaryInDirectory(CFURLRef bundleURL);


/*
 *  CFBundleGetPackageInfoInDirectory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFBundleGetPackageInfoInDirectory(
  CFURLRef   url,
  UInt32 *   packageType,
  UInt32 *   packageCreator);


/* ==================== Resource Handling API ==================== */
/*
 *  CFBundleCopyResourceURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFBundleCopyResourceURL(
  CFBundleRef   bundle,
  CFStringRef   resourceName,
  CFStringRef   resourceType,
  CFStringRef   subDirName);


/*
 *  CFBundleCopyResourceURLsOfType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFArrayRef )
CFBundleCopyResourceURLsOfType(
  CFBundleRef   bundle,
  CFStringRef   resourceType,
  CFStringRef   subDirName);


/*
 *  CFBundleCopyLocalizedString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFBundleCopyLocalizedString(
  CFBundleRef   bundle,
  CFStringRef   key,
  CFStringRef   value,
  CFStringRef   tableName);


#define CFCopyLocalizedString(key, comment) CFBundleCopyLocalizedString(CFBundleGetMainBundle(), (key), (key), NULL)
#define CFCopyLocalizedStringFromTable(key, tbl, comment) CFBundleCopyLocalizedString(CFBundleGetMainBundle(), (key), (key), (tbl))
#define CFCopyLocalizedStringFromTableInBundle(key, tbl, bundle, comment) CFBundleCopyLocalizedString((bundle), (key), (key), (tbl))
/* ------------- Resource Handling without a CFBundle instance ------------- */
/* This API is provided to enable developers to use the CFBundle resource */
/* searching policy without having to create an instance of CFBundle. */
/* Because of caching behavior when a CFBundle instance exists, it will be faster */
/* to actually create a CFBundle if you need to access several resources. */
/*
 *  CFBundleCopyResourceURLInDirectory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFBundleCopyResourceURLInDirectory(
  CFURLRef      bundleURL,
  CFStringRef   resourceName,
  CFStringRef   resourceType,
  CFStringRef   subDirName);


/*
 *  CFBundleCopyResourceURLsOfTypeInDirectory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFArrayRef )
CFBundleCopyResourceURLsOfTypeInDirectory(
  CFURLRef      bundleURL,
  CFStringRef   resourceType,
  CFStringRef   subDirName);


/* =========== Localization-specific Resource Handling API =========== */
/* This API allows finer-grained control over specific localizations,  */
/* as distinguished from the above API, which always uses the user's   */
/* preferred localizations.  */
/*
 *  CFBundleCopyBundleLocalizations()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFArrayRef )
CFBundleCopyBundleLocalizations(CFBundleRef bundle);


/* Lists the localizations that a bundle contains.  */
/*
 *  CFBundleCopyPreferredLocalizationsFromArray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFArrayRef )
CFBundleCopyPreferredLocalizationsFromArray(CFArrayRef locArray);


/* Given an array of possible localizations, returns the one or more */
/* that CFBundle would use in the current context. To find out which */
/* localizations are in use for a particular bundle, apply this to   */
/* the result of CFBundleCopyBundleLocalizations.  */
/*
 *  CFBundleCopyResourceURLForLocalization()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFBundleCopyResourceURLForLocalization(
  CFBundleRef   bundle,
  CFStringRef   resourceName,
  CFStringRef   resourceType,
  CFStringRef   subDirName,
  CFStringRef   localizationName);


/*
 *  CFBundleCopyResourceURLsOfTypeForLocalization()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFArrayRef )
CFBundleCopyResourceURLsOfTypeForLocalization(
  CFBundleRef   bundle,
  CFStringRef   resourceType,
  CFStringRef   subDirName,
  CFStringRef   localizationName);


/* ==================== Primitive Code Loading API ==================== */
/* This API abstracts the various different executable formats supported on */
/* various platforms.  It can load DYLD, CFM, or DLL shared libraries (on their */
/* appropriate platforms) and gives a uniform API for looking up functions. */
/* Note that Cocoa-based bundles containing Objective-C or Java code must */
/* be loaded with NSBundle, not CFBundle.  Once they are loaded, however, */
/* either CFBundle or NSBundle can be used. */
/*
 *  CFBundleCopyExecutableURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFBundleCopyExecutableURL(CFBundleRef bundle);


/*
 *  CFBundleIsExecutableLoaded()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFBundleIsExecutableLoaded(CFBundleRef bundle);


/*
 *  CFBundleLoadExecutable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFBundleLoadExecutable(CFBundleRef bundle);


/*
 *  CFBundleUnloadExecutable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFBundleUnloadExecutable(CFBundleRef bundle);


/*
 *  CFBundleGetFunctionPointerForName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void * )
CFBundleGetFunctionPointerForName(
  CFBundleRef   bundle,
  CFStringRef   functionName);


/*
 *  CFBundleGetFunctionPointersForNames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFBundleGetFunctionPointersForNames(
  CFBundleRef   bundle,
  CFArrayRef    functionNames,
  void *        ftbl[]);


/*
 *  CFBundleGetDataPointerForName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void * )
CFBundleGetDataPointerForName(
  CFBundleRef   bundle,
  CFStringRef   symbolName);


/*
 *  CFBundleGetDataPointersForNames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFBundleGetDataPointersForNames(
  CFBundleRef   bundle,
  CFArrayRef    symbolNames,
  void *        stbl[]);


/*
 *  CFBundleCopyAuxiliaryExecutableURL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFURLRef )
CFBundleCopyAuxiliaryExecutableURL(
  CFBundleRef   bundle,
  CFStringRef   executableName);


/* This function can be used to find executables other than your main */
/* executable.  This is useful, for instance, for applications that have */
/* some command line tool that is packaged with and used by the application. */
/* The tool can be packaged in the various platform executable directories */
/* in the bundle and can be located with this function.  This allows an */
/* app to ship versions of the tool for each platform as it does for the */
/* main app executable. */
/* ==================== Getting a bundle's plugIn ==================== */
/*
 *  CFBundleGetPlugIn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFPlugInRef )
CFBundleGetPlugIn(CFBundleRef bundle);


/* ==================== Resource Manager-Related API ==================== */
/*
 *  CFBundleOpenBundleResourceMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( short )
CFBundleOpenBundleResourceMap(CFBundleRef bundle);


/* This function opens the non-localized and the localized resource files */
/* (if any) for the bundle, creates and makes current a single read-only */
/* resource map combining both, and returns a reference number for it. */
/* If it is called multiple times, it opens the files multiple times, */
/* and returns distinct reference numbers.  */
/*
 *  CFBundleOpenBundleResourceFiles()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( SInt32 )
CFBundleOpenBundleResourceFiles(
  CFBundleRef   bundle,
  short *       refNum,
  short *       localizedRefNum);


/* Similar to CFBundleOpenBundleResourceMap, except that it creates two */
/* separate resource maps and returns reference numbers for both. */
/*
 *  CFBundleCloseBundleResourceMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFBundleCloseBundleResourceMap(
  CFBundleRef   bundle,
  short         refNum);



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

#endif /* __CFBUNDLE__ */


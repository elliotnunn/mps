/*
     File:       CFPropertyList.h
 
     Contains:   CoreFoundation PropertyList
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CFPROPERTYLIST__
#define __CFPROPERTYLIST__

#ifndef __CFBASE__
#include <CFBase.h>
#endif

#ifndef __CFDATA__
#include <CFData.h>
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

#if PRAGMA_ENUM_ALWAYSINT
    #if defined(__fourbyteints__) && !__fourbyteints__ 
        #define __CFPROPERTYLIST__RESTORE_TWOBYTEINTS
        #pragma fourbyteints on
    #endif
    #pragma enumsalwaysint on
#elif PRAGMA_ENUM_OPTIONS
    #pragma option enum=int
#elif PRAGMA_ENUM_PACK
    #if __option(pack_enums)
        #define __CFPROPERTYLIST__RESTORE_PACKED_ENUMS
        #pragma options(!pack_enums)
    #endif
#endif

/*
    Type to mean any instance of a property list type;
    currently, CFString, CFData, CFNumber, CFBoolean, CFDate,
    CFArray, and CFDictionary.
*/
typedef CFTypeRef                       CFPropertyListRef;

enum CFPropertyListMutabilityOptions {
  kCFPropertyListImmutable      = 0,
  kCFPropertyListMutableContainers = 1,
  kCFPropertyListMutableContainersAndLeaves = 2
};
typedef enum CFPropertyListMutabilityOptions CFPropertyListMutabilityOptions;

/*
    Creates a property list object from its XML description; xmlData should
    be the raw bytes of that description, possibly the contents of an XML
    file. Returns NULL if the data cannot be parsed; if the parse fails
    and errorString is non-NULL, a human-readable description of the failure
    is returned in errorString. It is the caller's responsibility to release
    either the returned object or the error string, whichever is applicable.
*/
/*
 *  CFPropertyListCreateFromXMLData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFPropertyListRef )
CFPropertyListCreateFromXMLData(
  CFAllocatorRef   allocator,
  CFDataRef        xmlData,
  CFOptionFlags    mutabilityOption,
  CFStringRef *    errorString);


/*
    Returns the XML description of the given object; propertyList must
    be one of the supported property list types, and (for composite types
    like CFArray and CFDictionary) must not contain any elements that
    are not themselves of a property list type. If a non-property list
    type is encountered, NULL is returned. The returned data is
    appropriate for writing out to an XML file. Note that a data, not a
    string, is returned because the bytes contain in them a description
    of the string encoding used.
*/
/*
 *  CFPropertyListCreateXMLData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFDataRef )
CFPropertyListCreateXMLData(
  CFAllocatorRef      allocator,
  CFPropertyListRef   propertyList);


/*
    Recursively creates a copy of the given property list (so nested arrays
    and dictionaries are copied as well as the top-most container). The
    resulting property list has the mutability characteristics determined
    by mutabilityOption.
*/
/*
 *  CFPropertyListCreateDeepCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFPropertyListRef )
CFPropertyListCreateDeepCopy(
  CFAllocatorRef      allocator,
  CFPropertyListRef   propertyList,
  CFOptionFlags       mutabilityOption);



#if PRAGMA_ENUM_ALWAYSINT
    #pragma enumsalwaysint reset
    #ifdef __CFPROPERTYLIST__RESTORE_TWOBYTEINTS
        #pragma fourbyteints off
    #endif
#elif PRAGMA_ENUM_OPTIONS
    #pragma option enum=reset
#elif defined(__CFPROPERTYLIST__RESTORE_PACKED_ENUMS)
    #pragma options(pack_enums)
#endif

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

#endif /* __CFPROPERTYLIST__ */


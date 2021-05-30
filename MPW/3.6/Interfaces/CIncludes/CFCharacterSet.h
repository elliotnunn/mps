/*
     File:       CFCharacterSet.h
 
     Contains:   CoreFoundation character sets
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CFCHARACTERSET__
#define __CFCHARACTERSET__

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
        #define __CFCHARACTERSET__RESTORE_TWOBYTEINTS
        #pragma fourbyteints on
    #endif
    #pragma enumsalwaysint on
#elif PRAGMA_ENUM_OPTIONS
    #pragma option enum=int
#elif PRAGMA_ENUM_PACK
    #if __option(pack_enums)
        #define __CFCHARACTERSET__RESTORE_PACKED_ENUMS
        #pragma options(!pack_enums)
    #endif
#endif

typedef const struct __CFCharacterSet*  CFCharacterSetRef;
typedef struct __CFCharacterSet*        CFMutableCharacterSetRef;

enum CFCharacterSetPredefinedSet {
  kCFCharacterSetControl        = 1,
  kCFCharacterSetWhitespace     = 2,
  kCFCharacterSetWhitespaceAndNewline = 3,
  kCFCharacterSetDecimalDigit   = 4,
  kCFCharacterSetLetter         = 5,
  kCFCharacterSetLowercaseLetter = 6,
  kCFCharacterSetUppercaseLetter = 7,
  kCFCharacterSetNonBase        = 8,
  kCFCharacterSetDecomposable   = 9,
  kCFCharacterSetAlphaNumeric   = 10,
  kCFCharacterSetPunctuation    = 11,
  kCFCharacterSetIllegal        = 12
};
typedef enum CFCharacterSetPredefinedSet CFCharacterSetPredefinedSet;

/*
 *  CFCharacterSetGetTypeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTypeID )
CFCharacterSetGetTypeID(void);


/*
 *  CFCharacterSetGetPredefined()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFCharacterSetRef )
CFCharacterSetGetPredefined(CFCharacterSetPredefinedSet theSetIdentifier);


/*
 *  CFCharacterSetCreateWithCharactersInRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFCharacterSetRef )
CFCharacterSetCreateWithCharactersInRange(
  CFAllocatorRef   alloc,
  CFRange          theRange);


/*
 *  CFCharacterSetCreateWithCharactersInString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFCharacterSetRef )
CFCharacterSetCreateWithCharactersInString(
  CFAllocatorRef   alloc,
  CFStringRef      theString);


/*
 *  CFCharacterSetCreateWithBitmapRepresentation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFCharacterSetRef )
CFCharacterSetCreateWithBitmapRepresentation(
  CFAllocatorRef   alloc,
  CFDataRef        theData);


/*
 *  CFCharacterSetCreateMutable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFMutableCharacterSetRef )
CFCharacterSetCreateMutable(CFAllocatorRef alloc);


/*
 *  CFCharacterSetCreateMutableCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFMutableCharacterSetRef )
CFCharacterSetCreateMutableCopy(
  CFAllocatorRef      alloc,
  CFCharacterSetRef   theSet);


/*
 *  CFCharacterSetIsCharacterMember()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFCharacterSetIsCharacterMember(
  CFCharacterSetRef   theSet,
  UniChar             theChar);


/*
 *  CFCharacterSetCreateBitmapRepresentation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFDataRef )
CFCharacterSetCreateBitmapRepresentation(
  CFAllocatorRef      alloc,
  CFCharacterSetRef   theSet);


/*
 *  CFCharacterSetAddCharactersInRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFCharacterSetAddCharactersInRange(
  CFMutableCharacterSetRef   theSet,
  CFRange                    theRange);


/*
 *  CFCharacterSetRemoveCharactersInRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFCharacterSetRemoveCharactersInRange(
  CFMutableCharacterSetRef   theSet,
  CFRange                    theRange);


/*
 *  CFCharacterSetAddCharactersInString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFCharacterSetAddCharactersInString(
  CFMutableCharacterSetRef   theSet,
  CFStringRef                theString);


/*
 *  CFCharacterSetRemoveCharactersInString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFCharacterSetRemoveCharactersInString(
  CFMutableCharacterSetRef   theSet,
  CFStringRef                theString);


/*
 *  CFCharacterSetUnion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFCharacterSetUnion(
  CFMutableCharacterSetRef   theSet,
  CFCharacterSetRef          theOtherSet);


/*
 *  CFCharacterSetIntersect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFCharacterSetIntersect(
  CFMutableCharacterSetRef   theSet,
  CFCharacterSetRef          theOtherSet);


/*
 *  CFCharacterSetInvert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFCharacterSetInvert(CFMutableCharacterSetRef theSet);



#if PRAGMA_ENUM_ALWAYSINT
    #pragma enumsalwaysint reset
    #ifdef __CFCHARACTERSET__RESTORE_TWOBYTEINTS
        #pragma fourbyteints off
    #endif
#elif PRAGMA_ENUM_OPTIONS
    #pragma option enum=reset
#elif defined(__CFCHARACTERSET__RESTORE_PACKED_ENUMS)
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

#endif /* __CFCHARACTERSET__ */


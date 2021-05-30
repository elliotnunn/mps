/*
     File:       CFData.h
 
     Contains:   CoreFoundation block of bytes
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CFDATA__
#define __CFDATA__

#ifndef __CFBASE__
#include <CFBase.h>
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

typedef const struct __CFData*          CFDataRef;
typedef struct __CFData*                CFMutableDataRef;
/*
 *  CFDataGetTypeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTypeID )
CFDataGetTypeID(void);


/*
 *  CFDataCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFDataRef )
CFDataCreate(
  CFAllocatorRef   allocator,
  const UInt8 *    bytes,
  CFIndex          length);


/*
 *  CFDataCreateWithBytesNoCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFDataRef )
CFDataCreateWithBytesNoCopy(
  CFAllocatorRef   allocator,
  const UInt8 *    bytes,
  CFIndex          length,
  CFAllocatorRef   bytesDeallocator);


/* Pass kCFAllocatorNull as bytesDeallocator to assure the bytes aren't freed */
/*
 *  CFDataCreateCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFDataRef )
CFDataCreateCopy(
  CFAllocatorRef   allocator,
  CFDataRef        theData);


/*
 *  CFDataCreateMutable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFMutableDataRef )
CFDataCreateMutable(
  CFAllocatorRef   allocator,
  CFIndex          capacity);


/*
 *  CFDataCreateMutableCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFMutableDataRef )
CFDataCreateMutableCopy(
  CFAllocatorRef   allocator,
  CFIndex          capacity,
  CFDataRef        theData);


/*
 *  CFDataGetLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFIndex )
CFDataGetLength(CFDataRef theData);


/*
 *  CFDataGetBytePtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( const UInt8 * )
CFDataGetBytePtr(CFDataRef theData);


/*
 *  CFDataGetMutableBytePtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( UInt8 * )
CFDataGetMutableBytePtr(CFMutableDataRef theData);


/*
 *  CFDataGetBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFDataGetBytes(
  CFDataRef   theData,
  CFRange     range,
  UInt8 *     buffer);


/*
 *  CFDataSetLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFDataSetLength(
  CFMutableDataRef   theData,
  CFIndex            length);


/*
 *  CFDataIncreaseLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFDataIncreaseLength(
  CFMutableDataRef   theData,
  CFIndex            extraLength);


/*
 *  CFDataAppendBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFDataAppendBytes(
  CFMutableDataRef   theData,
  const UInt8 *      bytes,
  CFIndex            length);


/*
 *  CFDataReplaceBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFDataReplaceBytes(
  CFMutableDataRef   theData,
  CFRange            range,
  const UInt8 *      newBytes,
  CFIndex            newLength);


/*
 *  CFDataDeleteBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFDataDeleteBytes(
  CFMutableDataRef   theData,
  CFRange            range);



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

#endif /* __CFDATA__ */


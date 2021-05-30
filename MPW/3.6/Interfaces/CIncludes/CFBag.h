/*
     File:       CFBag.h
 
     Contains:   CoreFoundation bag collection
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CFBAG__
#define __CFBAG__

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

typedef CALLBACK_API_C( const void *, CFBagRetainCallBack )(CFAllocatorRef allocator, const void *value);
typedef CALLBACK_API_C( void , CFBagReleaseCallBack )(CFAllocatorRef allocator, const void *value);
typedef CALLBACK_API_C( CFStringRef , CFBagCopyDescriptionCallBack )(const void * value);
typedef CALLBACK_API_C( Boolean , CFBagEqualCallBack )(const void *value1, const void *value2);
typedef CALLBACK_API_C( CFHashCode , CFBagHashCallBack )(const void * value);
struct CFBagCallBacks {
  CFIndex             version;
  CFBagRetainCallBack  retain;
  CFBagReleaseCallBack  release;
  CFBagCopyDescriptionCallBack  copyDescription;
  CFBagEqualCallBack  equal;
  CFBagHashCallBack   hash;
};
typedef struct CFBagCallBacks           CFBagCallBacks;
/*
 *  kCFTypeBagCallBacks
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFBagCallBacks kCFTypeBagCallBacks;
/*
 *  kCFCopyStringBagCallBacks
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFBagCallBacks kCFCopyStringBagCallBacks;
typedef CALLBACK_API_C( void , CFBagApplierFunction )(const void *value, void *context);
typedef const struct __CFBag*           CFBagRef;
typedef struct __CFBag*                 CFMutableBagRef;
/*
 *  CFBagGetTypeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFTypeID )
CFBagGetTypeID(void);


/*
 *  CFBagCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFBagRef )
CFBagCreate(
  CFAllocatorRef          allocator,
  const void **           values,
  CFIndex                 numValues,
  const CFBagCallBacks *  callBacks);


/*
 *  CFBagCreateCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFBagRef )
CFBagCreateCopy(
  CFAllocatorRef   allocator,
  CFBagRef         theBag);


/*
 *  CFBagCreateMutable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFMutableBagRef )
CFBagCreateMutable(
  CFAllocatorRef          allocator,
  CFIndex                 capacity,
  const CFBagCallBacks *  callBacks);


/*
 *  CFBagCreateMutableCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFMutableBagRef )
CFBagCreateMutableCopy(
  CFAllocatorRef   allocator,
  CFIndex          capacity,
  CFBagRef         theBag);


/*
 *  CFBagGetCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFIndex )
CFBagGetCount(CFBagRef theBag);


/*
 *  CFBagGetCountOfValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFIndex )
CFBagGetCountOfValue(
  CFBagRef      theBag,
  const void *  value);


/*
 *  CFBagContainsValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFBagContainsValue(
  CFBagRef      theBag,
  const void *  value);


/*
 *  CFBagGetValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( const void * )
CFBagGetValue(
  CFBagRef      theBag,
  const void *  value);


/*
 *  CFBagGetValueIfPresent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFBagGetValueIfPresent(
  CFBagRef       theBag,
  const void *   candidate,
  const void **  value);


/*
 *  CFBagGetValues()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFBagGetValues(
  CFBagRef       theBag,
  const void **  values);


/*
 *  CFBagApplyFunction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFBagApplyFunction(
  CFBagRef               theBag,
  CFBagApplierFunction   applier,
  void *                 context);


/*
 *  CFBagAddValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFBagAddValue(
  CFMutableBagRef   theBag,
  const void *      value);


/*
 *  CFBagReplaceValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFBagReplaceValue(
  CFMutableBagRef   theBag,
  const void *      value);


/*
 *  CFBagSetValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFBagSetValue(
  CFMutableBagRef   theBag,
  const void *      value);


/*
 *  CFBagRemoveValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFBagRemoveValue(
  CFMutableBagRef   theBag,
  const void *      value);


/*
 *  CFBagRemoveAllValues()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFBagRemoveAllValues(CFMutableBagRef theBag);



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

#endif /* __CFBAG__ */


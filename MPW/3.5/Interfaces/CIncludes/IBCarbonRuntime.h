/*
     File:       IBCarbonRuntime.h
 
     Contains:   Nib support for Carbon
 
     Version:    Technology: CarbonLib 1.1/Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __IBCARBONRUNTIME__
#define __IBCARBONRUNTIME__

#ifndef __CFSTRING__
#include <CFString.h>
#endif

#ifndef __CFBUNDLE__
#include <CFBundle.h>
#endif

#ifndef __MACWINDOWS__
#include <MacWindows.h>
#endif

#ifndef __CONTROLDEFINITIONS__
#include <ControlDefinitions.h>
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

enum {
  kIBCarbonRuntimeCantFindNibFile = -10960,
  kIBCarbonRuntimeObjectNotOfRequestedType = -10961,
  kIBCarbonRuntimeCantFindObject = -10962
};

/* ----- typedef ------ */
typedef struct OpaqueIBNibRef*          IBNibRef;
/* ----- Create & Dispose NIB References ------ */
/*
 *  CreateNibReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
CreateNibReference(
  CFStringRef   inNibName,
  IBNibRef *    outNibRef);


/*
 *  CreateNibReferenceWithCFBundle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
CreateNibReferenceWithCFBundle(
  CFBundleRef   inBundle,
  CFStringRef   inNibName,
  IBNibRef *    outNibRef);


/*
 *  DisposeNibReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeNibReference(IBNibRef inNibRef);


/* ----- Window ------ */
/*
 *  CreateWindowFromNib()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
CreateWindowFromNib(
  IBNibRef      inNibRef,
  CFStringRef   inName,
  WindowRef *   outWindow);


/* ----- Menu -----*/

/*
 *  CreateMenuFromNib()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
CreateMenuFromNib(
  IBNibRef      inNibRef,
  CFStringRef   inName,
  MenuRef *     outMenuRef);


/* ----- MenuBar ------*/

/*
 *  CreateMenuBarFromNib()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
CreateMenuBarFromNib(
  IBNibRef      inNibRef,
  CFStringRef   inName,
  Handle *      outMenuBar);


/*
 *  SetMenuBarFromNib()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
SetMenuBarFromNib(
  IBNibRef      inNibRef,
  CFStringRef   inName);



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

#endif /* __IBCARBONRUNTIME__ */


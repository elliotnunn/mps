/*
     File:       CFPlugIn.h
 
     Contains:   CoreFoundation plugins
 
     Version:    Technology: Mac OS X
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
                                                            
#if !defined(COREFOUNDATION_CFPLUGINCOM_SEPARATE)
#define COREFOUNDATION_CFPLUGINCOM_SEPARATE 1
#endif

#ifndef __CFPLUGIN__
#define __CFPLUGIN__

#ifndef __CFBASE__
#include <CFBase.h>
#endif

#ifndef __CFARRAY__
#include <CFArray.h>
#endif

#ifndef __CFBUNDLE__
#include <CFBundle.h>
#endif

#ifndef __CFSTRING__
#include <CFString.h>
#endif

#ifndef __CFURL__
#include <CFURL.h>
#endif

#ifndef __CFUUID__
#include <CFUUID.h>
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

/* ================ Standard Info.plist keys for plugIns ================ */
/*
 *  kCFPlugInDynamicRegistrationKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFPlugInDynamicRegistrationKey;
/*
 *  kCFPlugInDynamicRegisterFunctionKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFPlugInDynamicRegisterFunctionKey;
/*
 *  kCFPlugInUnloadFunctionKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFPlugInUnloadFunctionKey;
/*
 *  kCFPlugInFactoriesKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFPlugInFactoriesKey;
/*
 *  kCFPlugInTypesKey
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
extern const CFStringRef kCFPlugInTypesKey;
/* ================= Function prototypes for various callbacks ================= */
/* Function types that plugIn authors can implement for various purposes. */
typedef CALLBACK_API_C( void , CFPlugInDynamicRegisterFunction )(CFPlugInRef plugIn);
typedef CALLBACK_API_C( void , CFPlugInUnloadFunction )(CFPlugInRef plugIn);
typedef CALLBACK_API_C( void *, CFPlugInFactoryFunction )(CFAllocatorRef allocator, CFUUIDRef typeUUID);
/* ================= Creating PlugIns ================= */
/*
 *  CFPlugInGetTypeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( UInt32 )
CFPlugInGetTypeID(void);


/*
 *  CFPlugInCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFPlugInRef )
CFPlugInCreate(
  CFAllocatorRef   allocator,
  CFURLRef         plugInURL);


/* Might return an existing instance with the ref-count bumped. */
/*
 *  CFPlugInGetBundle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFBundleRef )
CFPlugInGetBundle(CFPlugInRef plugIn);


/* ================= Controlling load on demand ================= */
/* For plugIns. */
/* PlugIns that do static registration are load on demand by default. */
/* PlugIns that do dynamic registration are not load on demand by default. */
/* A dynamic registration function can call CFPlugInSetLoadOnDemand(). */
/*
 *  CFPlugInSetLoadOnDemand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFPlugInSetLoadOnDemand(
  CFPlugInRef   plugIn,
  Boolean       flag);


/*
 *  CFPlugInIsLoadOnDemand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFPlugInIsLoadOnDemand(CFPlugInRef plugIn);


/* ================= Finding factories and creating instances ================= */
/* For plugIn hosts. */
/* Functions for finding factories to create specific types and actually creating instances of a type. */
/*
 *  CFPlugInFindFactoriesForPlugInType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFArrayRef )
CFPlugInFindFactoriesForPlugInType(CFUUIDRef typeUUID);


/* This function finds all the factories from any plugin for the given type.  */
/*
 *  CFPlugInFindFactoriesForPlugInTypeInPlugIn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFArrayRef )
CFPlugInFindFactoriesForPlugInTypeInPlugIn(
  CFUUIDRef     typeUUID,
  CFPlugInRef   plugIn);


/* This function restricts the result to factories from the given plug-in that can create the given type */
/*
 *  CFPlugInInstanceCreate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void * )
CFPlugInInstanceCreate(
  CFAllocatorRef   allocator,
  CFUUIDRef        factoryUUID,
  CFUUIDRef        typeUUID);


/* This function returns the IUnknown interface for the new instance. */
/* ================= Registering factories and types ================= */
/* For plugIn writers who must dynamically register things. */
/* Functions to register factory functions and to associate factories with types. */
/*
 *  CFPlugInRegisterFactoryFunction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFPlugInRegisterFactoryFunction(
  CFUUIDRef                 factoryUUID,
  CFPlugInFactoryFunction   func);


/*
 *  CFPlugInRegisterFactoryFunctionByName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFPlugInRegisterFactoryFunctionByName(
  CFUUIDRef     factoryUUID,
  CFPlugInRef   plugIn,
  CFStringRef   functionName);


/*
 *  CFPlugInUnregisterFactory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFPlugInUnregisterFactory(CFUUIDRef factoryUUID);


/*
 *  CFPlugInRegisterPlugInType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFPlugInRegisterPlugInType(
  CFUUIDRef   factoryUUID,
  CFUUIDRef   typeUUID);


/*
 *  CFPlugInUnregisterPlugInType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFPlugInUnregisterPlugInType(
  CFUUIDRef   factoryUUID,
  CFUUIDRef   typeUUID);


/* ================= Registering instances ================= */
/* When a new instance of a type is created, the instance is responsible for registering itself with the factory that created it and unregistering when it deallocates. */
/* This means that an instance must keep track of the CFUUIDRef of the factory that created it so it can unregister when it goes away. */
/*
 *  CFPlugInAddInstanceForFactory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFPlugInAddInstanceForFactory(CFUUIDRef factoryID);


/*
 *  CFPlugInRemoveInstanceForFactory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
CFPlugInRemoveInstanceForFactory(CFUUIDRef factoryID);



/* Obsolete API */
typedef struct __CFPlugInInstance*      CFPlugInInstanceRef;
typedef CALLBACK_API_C( Boolean , CFPlugInInstanceGetInterfaceFunction )(CFPlugInInstanceRef instance, CFStringRef interfaceName, void **ftbl);
typedef CALLBACK_API_C( void , CFPlugInInstanceDeallocateInstanceDataFunction )(void * instanceData);
/*
 *  CFPlugInInstanceGetInterfaceFunctionTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
CFPlugInInstanceGetInterfaceFunctionTable(
  CFPlugInInstanceRef   instance,
  CFStringRef           interfaceName,
  void **               ftbl);


/*
 *  CFPlugInInstanceGetFactoryName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFStringRef )
CFPlugInInstanceGetFactoryName(CFPlugInInstanceRef instance);


/*
 *  CFPlugInInstanceGetInstanceData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void * )
CFPlugInInstanceGetInstanceData(CFPlugInInstanceRef instance);


/*
 *  CFPlugInInstanceGetTypeID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( UInt32 )
CFPlugInInstanceGetTypeID(void);


/*
 *  CFPlugInInstanceCreateWithInstanceDataSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( CFPlugInInstanceRef )
CFPlugInInstanceCreateWithInstanceDataSize(
  CFAllocatorRef                                   allocator,
  CFIndex                                          instanceDataSize,
  CFPlugInInstanceDeallocateInstanceDataFunction   deallocateInstanceFunction,
  CFStringRef                                      factoryName,
  CFPlugInInstanceGetInterfaceFunction             getInterfaceFunction);


                                                            
#if !COREFOUNDATION_CFPLUGINCOM_SEPARATE
#include <CoreFoundation/CFPlugInCOM.h>
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

#endif /* __CFPLUGIN__ */


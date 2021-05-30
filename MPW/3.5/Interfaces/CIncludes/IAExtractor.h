/*
     File:       IAExtractor.h
 
     Contains:   Interfaces to Find by Content Plugins that scan files
 
     Version:    Technology: Mac OS 8.6
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __IAEXTRACTOR__
#define __IAEXTRACTOR__

#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif

#ifndef __MACERRORS__
#include <MacErrors.h>
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

/* modes for IASetDocAccessorReadPositionProc */
enum {
  kIAFromStartMode              = 0,
  kIAFromCurrMode               = 1,
  kIAFromEndMode                = 2
};

/* versions for plug-ins */
enum {
  kIAExtractorVersion1          = 0x00010001,
  kIAExtractorCurrentVersion    = kIAExtractorVersion1
};

/* types */
typedef OSStatus                        IAResult;
typedef struct OpaqueIAPluginRef*       IAPluginRef;
typedef struct OpaqueIADocAccessorRef*  IADocAccessorRef;
typedef struct OpaqueIADocRef*          IADocRef;
/* IAPluginInitBlock functions */
typedef CALLBACK_API_C( void *, IAAllocProcPtr )(UInt32 inSize);
typedef CALLBACK_API_C( void , IAFreeProcPtr )(void * inObject);
typedef CALLBACK_API_C( UInt8 , IAIdleProcPtr )(void);
typedef STACK_UPP_TYPE(IAAllocProcPtr)                          IAAllocUPP;
typedef STACK_UPP_TYPE(IAFreeProcPtr)                           IAFreeUPP;
typedef STACK_UPP_TYPE(IAIdleProcPtr)                           IAIdleUPP;
#if CALL_NOT_IN_CARBON
/*
 *  NewIAAllocUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( IAAllocUPP )
NewIAAllocUPP(IAAllocProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppIAAllocProcInfo = 0x000000F1 };  /* 4_bytes Func(4_bytes) */
  #ifdef __cplusplus
    inline IAAllocUPP NewIAAllocUPP(IAAllocProcPtr userRoutine) { return (IAAllocUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIAAllocProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewIAAllocUPP(userRoutine) (IAAllocUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIAAllocProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewIAFreeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( IAFreeUPP )
NewIAFreeUPP(IAFreeProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppIAFreeProcInfo = 0x000000C1 };  /* no_return_value Func(4_bytes) */
  #ifdef __cplusplus
    inline IAFreeUPP NewIAFreeUPP(IAFreeProcPtr userRoutine) { return (IAFreeUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIAFreeProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewIAFreeUPP(userRoutine) (IAFreeUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIAFreeProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewIAIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( IAIdleUPP )
NewIAIdleUPP(IAIdleProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppIAIdleProcInfo = 0x00000011 };  /* 1_byte Func() */
  #ifdef __cplusplus
    inline IAIdleUPP NewIAIdleUPP(IAIdleProcPtr userRoutine) { return (IAIdleUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIAIdleProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewIAIdleUPP(userRoutine) (IAIdleUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIAIdleProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposeIAAllocUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeIAAllocUPP(IAAllocUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeIAAllocUPP(IAAllocUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeIAAllocUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeIAFreeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeIAFreeUPP(IAFreeUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeIAFreeUPP(IAFreeUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeIAFreeUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeIAIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeIAIdleUPP(IAIdleUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeIAIdleUPP(IAIdleUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeIAIdleUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokeIAAllocUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void * )
InvokeIAAllocUPP(
  UInt32      inSize,
  IAAllocUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void * InvokeIAAllocUPP(UInt32 inSize, IAAllocUPP userUPP) { return (void *)CALL_ONE_PARAMETER_UPP(userUPP, uppIAAllocProcInfo, inSize); }
  #else
    #define InvokeIAAllocUPP(inSize, userUPP) (void *)CALL_ONE_PARAMETER_UPP((userUPP), uppIAAllocProcInfo, (inSize))
  #endif
#endif

/*
 *  InvokeIAFreeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
InvokeIAFreeUPP(
  void *     inObject,
  IAFreeUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeIAFreeUPP(void * inObject, IAFreeUPP userUPP) { CALL_ONE_PARAMETER_UPP(userUPP, uppIAFreeProcInfo, inObject); }
  #else
    #define InvokeIAFreeUPP(inObject, userUPP) CALL_ONE_PARAMETER_UPP((userUPP), uppIAFreeProcInfo, (inObject))
  #endif
#endif

/*
 *  InvokeIAIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( UInt8 )
InvokeIAIdleUPP(IAIdleUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline UInt8 InvokeIAIdleUPP(IAIdleUPP userUPP) { return (UInt8)CALL_ZERO_PARAMETER_UPP(userUPP, uppIAIdleProcInfo); }
  #else
    #define InvokeIAIdleUPP(userUPP) (UInt8)CALL_ZERO_PARAMETER_UPP((userUPP), uppIAIdleProcInfo)
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewIAAllocProc(userRoutine)                         NewIAAllocUPP(userRoutine)
    #define NewIAFreeProc(userRoutine)                          NewIAFreeUPP(userRoutine)
    #define NewIAIdleProc(userRoutine)                          NewIAIdleUPP(userRoutine)
    #define CallIAAllocProc(userRoutine, inSize)                InvokeIAAllocUPP(inSize, userRoutine)
    #define CallIAFreeProc(userRoutine, inObject)               InvokeIAFreeUPP(inObject, userRoutine)
    #define CallIAIdleProc(userRoutine)                         InvokeIAIdleUPP(userRoutine)
#endif /* CALL_NOT_IN_CARBON */

struct IAPluginInitBlock {
  IAAllocUPP          Alloc;
  IAFreeUPP           Free;
  IAIdleUPP           Idle;
};
typedef struct IAPluginInitBlock        IAPluginInitBlock;
typedef IAPluginInitBlock *             IAPluginInitBlockPtr;
/* IADocAccessorRecord  functions */
typedef CALLBACK_API_C( OSStatus , IADocAccessorOpenProcPtr )(IADocAccessorRef inAccessor);
typedef CALLBACK_API_C( OSStatus , IADocAccessorCloseProcPtr )(IADocAccessorRef inAccessor);
typedef CALLBACK_API_C( OSStatus , IADocAccessorReadProcPtr )(IADocAccessorRef inAccessor, void *buffer, UInt32 *ioSize);
typedef CALLBACK_API_C( OSStatus , IASetDocAccessorReadPositionProcPtr )(IADocAccessorRef inAccessor, SInt32 inMode, SInt32 inOffset);
typedef CALLBACK_API_C( OSStatus , IAGetDocAccessorReadPositionProcPtr )(IADocAccessorRef inAccessor, SInt32 *outPostion);
typedef CALLBACK_API_C( OSStatus , IAGetDocAccessorEOFProcPtr )(IADocAccessorRef inAccessor, SInt32 *outEOF);
typedef STACK_UPP_TYPE(IADocAccessorOpenProcPtr)                IADocAccessorOpenUPP;
typedef STACK_UPP_TYPE(IADocAccessorCloseProcPtr)               IADocAccessorCloseUPP;
typedef STACK_UPP_TYPE(IADocAccessorReadProcPtr)                IADocAccessorReadUPP;
typedef STACK_UPP_TYPE(IASetDocAccessorReadPositionProcPtr)     IASetDocAccessorReadPositionUPP;
typedef STACK_UPP_TYPE(IAGetDocAccessorReadPositionProcPtr)     IAGetDocAccessorReadPositionUPP;
typedef STACK_UPP_TYPE(IAGetDocAccessorEOFProcPtr)              IAGetDocAccessorEOFUPP;
#if CALL_NOT_IN_CARBON
/*
 *  NewIADocAccessorOpenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( IADocAccessorOpenUPP )
NewIADocAccessorOpenUPP(IADocAccessorOpenProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppIADocAccessorOpenProcInfo = 0x000000F1 };  /* 4_bytes Func(4_bytes) */
  #ifdef __cplusplus
    inline IADocAccessorOpenUPP NewIADocAccessorOpenUPP(IADocAccessorOpenProcPtr userRoutine) { return (IADocAccessorOpenUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIADocAccessorOpenProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewIADocAccessorOpenUPP(userRoutine) (IADocAccessorOpenUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIADocAccessorOpenProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewIADocAccessorCloseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( IADocAccessorCloseUPP )
NewIADocAccessorCloseUPP(IADocAccessorCloseProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppIADocAccessorCloseProcInfo = 0x000000F1 };  /* 4_bytes Func(4_bytes) */
  #ifdef __cplusplus
    inline IADocAccessorCloseUPP NewIADocAccessorCloseUPP(IADocAccessorCloseProcPtr userRoutine) { return (IADocAccessorCloseUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIADocAccessorCloseProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewIADocAccessorCloseUPP(userRoutine) (IADocAccessorCloseUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIADocAccessorCloseProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewIADocAccessorReadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( IADocAccessorReadUPP )
NewIADocAccessorReadUPP(IADocAccessorReadProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppIADocAccessorReadProcInfo = 0x00000FF1 };  /* 4_bytes Func(4_bytes, 4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline IADocAccessorReadUPP NewIADocAccessorReadUPP(IADocAccessorReadProcPtr userRoutine) { return (IADocAccessorReadUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIADocAccessorReadProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewIADocAccessorReadUPP(userRoutine) (IADocAccessorReadUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIADocAccessorReadProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewIASetDocAccessorReadPositionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( IASetDocAccessorReadPositionUPP )
NewIASetDocAccessorReadPositionUPP(IASetDocAccessorReadPositionProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppIASetDocAccessorReadPositionProcInfo = 0x00000FF1 };  /* 4_bytes Func(4_bytes, 4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline IASetDocAccessorReadPositionUPP NewIASetDocAccessorReadPositionUPP(IASetDocAccessorReadPositionProcPtr userRoutine) { return (IASetDocAccessorReadPositionUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIASetDocAccessorReadPositionProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewIASetDocAccessorReadPositionUPP(userRoutine) (IASetDocAccessorReadPositionUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIASetDocAccessorReadPositionProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewIAGetDocAccessorReadPositionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( IAGetDocAccessorReadPositionUPP )
NewIAGetDocAccessorReadPositionUPP(IAGetDocAccessorReadPositionProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppIAGetDocAccessorReadPositionProcInfo = 0x000003F1 };  /* 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline IAGetDocAccessorReadPositionUPP NewIAGetDocAccessorReadPositionUPP(IAGetDocAccessorReadPositionProcPtr userRoutine) { return (IAGetDocAccessorReadPositionUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIAGetDocAccessorReadPositionProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewIAGetDocAccessorReadPositionUPP(userRoutine) (IAGetDocAccessorReadPositionUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIAGetDocAccessorReadPositionProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewIAGetDocAccessorEOFUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( IAGetDocAccessorEOFUPP )
NewIAGetDocAccessorEOFUPP(IAGetDocAccessorEOFProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppIAGetDocAccessorEOFProcInfo = 0x000003F1 };  /* 4_bytes Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline IAGetDocAccessorEOFUPP NewIAGetDocAccessorEOFUPP(IAGetDocAccessorEOFProcPtr userRoutine) { return (IAGetDocAccessorEOFUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIAGetDocAccessorEOFProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewIAGetDocAccessorEOFUPP(userRoutine) (IAGetDocAccessorEOFUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppIAGetDocAccessorEOFProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposeIADocAccessorOpenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeIADocAccessorOpenUPP(IADocAccessorOpenUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeIADocAccessorOpenUPP(IADocAccessorOpenUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeIADocAccessorOpenUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeIADocAccessorCloseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeIADocAccessorCloseUPP(IADocAccessorCloseUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeIADocAccessorCloseUPP(IADocAccessorCloseUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeIADocAccessorCloseUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeIADocAccessorReadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeIADocAccessorReadUPP(IADocAccessorReadUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeIADocAccessorReadUPP(IADocAccessorReadUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeIADocAccessorReadUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeIASetDocAccessorReadPositionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeIASetDocAccessorReadPositionUPP(IASetDocAccessorReadPositionUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeIASetDocAccessorReadPositionUPP(IASetDocAccessorReadPositionUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeIASetDocAccessorReadPositionUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeIAGetDocAccessorReadPositionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeIAGetDocAccessorReadPositionUPP(IAGetDocAccessorReadPositionUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeIAGetDocAccessorReadPositionUPP(IAGetDocAccessorReadPositionUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeIAGetDocAccessorReadPositionUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeIAGetDocAccessorEOFUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeIAGetDocAccessorEOFUPP(IAGetDocAccessorEOFUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeIAGetDocAccessorEOFUPP(IAGetDocAccessorEOFUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeIAGetDocAccessorEOFUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokeIADocAccessorOpenUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
InvokeIADocAccessorOpenUPP(
  IADocAccessorRef      inAccessor,
  IADocAccessorOpenUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline OSStatus InvokeIADocAccessorOpenUPP(IADocAccessorRef inAccessor, IADocAccessorOpenUPP userUPP) { return (OSStatus)CALL_ONE_PARAMETER_UPP(userUPP, uppIADocAccessorOpenProcInfo, inAccessor); }
  #else
    #define InvokeIADocAccessorOpenUPP(inAccessor, userUPP) (OSStatus)CALL_ONE_PARAMETER_UPP((userUPP), uppIADocAccessorOpenProcInfo, (inAccessor))
  #endif
#endif

/*
 *  InvokeIADocAccessorCloseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
InvokeIADocAccessorCloseUPP(
  IADocAccessorRef       inAccessor,
  IADocAccessorCloseUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline OSStatus InvokeIADocAccessorCloseUPP(IADocAccessorRef inAccessor, IADocAccessorCloseUPP userUPP) { return (OSStatus)CALL_ONE_PARAMETER_UPP(userUPP, uppIADocAccessorCloseProcInfo, inAccessor); }
  #else
    #define InvokeIADocAccessorCloseUPP(inAccessor, userUPP) (OSStatus)CALL_ONE_PARAMETER_UPP((userUPP), uppIADocAccessorCloseProcInfo, (inAccessor))
  #endif
#endif

/*
 *  InvokeIADocAccessorReadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
InvokeIADocAccessorReadUPP(
  IADocAccessorRef      inAccessor,
  void *                buffer,
  UInt32 *              ioSize,
  IADocAccessorReadUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline OSStatus InvokeIADocAccessorReadUPP(IADocAccessorRef inAccessor, void * buffer, UInt32 * ioSize, IADocAccessorReadUPP userUPP) { return (OSStatus)CALL_THREE_PARAMETER_UPP(userUPP, uppIADocAccessorReadProcInfo, inAccessor, buffer, ioSize); }
  #else
    #define InvokeIADocAccessorReadUPP(inAccessor, buffer, ioSize, userUPP) (OSStatus)CALL_THREE_PARAMETER_UPP((userUPP), uppIADocAccessorReadProcInfo, (inAccessor), (buffer), (ioSize))
  #endif
#endif

/*
 *  InvokeIASetDocAccessorReadPositionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
InvokeIASetDocAccessorReadPositionUPP(
  IADocAccessorRef                 inAccessor,
  SInt32                           inMode,
  SInt32                           inOffset,
  IASetDocAccessorReadPositionUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline OSStatus InvokeIASetDocAccessorReadPositionUPP(IADocAccessorRef inAccessor, SInt32 inMode, SInt32 inOffset, IASetDocAccessorReadPositionUPP userUPP) { return (OSStatus)CALL_THREE_PARAMETER_UPP(userUPP, uppIASetDocAccessorReadPositionProcInfo, inAccessor, inMode, inOffset); }
  #else
    #define InvokeIASetDocAccessorReadPositionUPP(inAccessor, inMode, inOffset, userUPP) (OSStatus)CALL_THREE_PARAMETER_UPP((userUPP), uppIASetDocAccessorReadPositionProcInfo, (inAccessor), (inMode), (inOffset))
  #endif
#endif

/*
 *  InvokeIAGetDocAccessorReadPositionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
InvokeIAGetDocAccessorReadPositionUPP(
  IADocAccessorRef                 inAccessor,
  SInt32 *                         outPostion,
  IAGetDocAccessorReadPositionUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline OSStatus InvokeIAGetDocAccessorReadPositionUPP(IADocAccessorRef inAccessor, SInt32 * outPostion, IAGetDocAccessorReadPositionUPP userUPP) { return (OSStatus)CALL_TWO_PARAMETER_UPP(userUPP, uppIAGetDocAccessorReadPositionProcInfo, inAccessor, outPostion); }
  #else
    #define InvokeIAGetDocAccessorReadPositionUPP(inAccessor, outPostion, userUPP) (OSStatus)CALL_TWO_PARAMETER_UPP((userUPP), uppIAGetDocAccessorReadPositionProcInfo, (inAccessor), (outPostion))
  #endif
#endif

/*
 *  InvokeIAGetDocAccessorEOFUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
InvokeIAGetDocAccessorEOFUPP(
  IADocAccessorRef        inAccessor,
  SInt32 *                outEOF,
  IAGetDocAccessorEOFUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline OSStatus InvokeIAGetDocAccessorEOFUPP(IADocAccessorRef inAccessor, SInt32 * outEOF, IAGetDocAccessorEOFUPP userUPP) { return (OSStatus)CALL_TWO_PARAMETER_UPP(userUPP, uppIAGetDocAccessorEOFProcInfo, inAccessor, outEOF); }
  #else
    #define InvokeIAGetDocAccessorEOFUPP(inAccessor, outEOF, userUPP) (OSStatus)CALL_TWO_PARAMETER_UPP((userUPP), uppIAGetDocAccessorEOFProcInfo, (inAccessor), (outEOF))
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewIADocAccessorOpenProc(userRoutine)               NewIADocAccessorOpenUPP(userRoutine)
    #define NewIADocAccessorCloseProc(userRoutine)              NewIADocAccessorCloseUPP(userRoutine)
    #define NewIADocAccessorReadProc(userRoutine)               NewIADocAccessorReadUPP(userRoutine)
    #define NewIASetDocAccessorReadPositionProc(userRoutine)    NewIASetDocAccessorReadPositionUPP(userRoutine)
    #define NewIAGetDocAccessorReadPositionProc(userRoutine)    NewIAGetDocAccessorReadPositionUPP(userRoutine)
    #define NewIAGetDocAccessorEOFProc(userRoutine)             NewIAGetDocAccessorEOFUPP(userRoutine)
    #define CallIADocAccessorOpenProc(userRoutine, inAccessor)  InvokeIADocAccessorOpenUPP(inAccessor, userRoutine)
    #define CallIADocAccessorCloseProc(userRoutine, inAccessor) InvokeIADocAccessorCloseUPP(inAccessor, userRoutine)
    #define CallIADocAccessorReadProc(userRoutine, inAccessor, buffer, ioSize) InvokeIADocAccessorReadUPP(inAccessor, buffer, ioSize, userRoutine)
    #define CallIASetDocAccessorReadPositionProc(userRoutine, inAccessor, inMode, inOffset) InvokeIASetDocAccessorReadPositionUPP(inAccessor, inMode, inOffset, userRoutine)
    #define CallIAGetDocAccessorReadPositionProc(userRoutine, inAccessor, outPostion) InvokeIAGetDocAccessorReadPositionUPP(inAccessor, outPostion, userRoutine)
    #define CallIAGetDocAccessorEOFProc(userRoutine, inAccessor, outEOF) InvokeIAGetDocAccessorEOFUPP(inAccessor, outEOF, userRoutine)
#endif /* CALL_NOT_IN_CARBON */

/* IADocAccessorRecord */
struct IADocAccessorRecord {
  IADocAccessorRef    docAccessor;
  IADocAccessorOpenUPP  OpenDoc;
  IADocAccessorCloseUPP  CloseDoc;
  IADocAccessorReadUPP  ReadDoc;
  IASetDocAccessorReadPositionUPP  SetReadPosition;
  IAGetDocAccessorReadPositionUPP  GetReadPosition;
  IAGetDocAccessorEOFUPP  GetEOF;
};
typedef struct IADocAccessorRecord      IADocAccessorRecord;
typedef IADocAccessorRecord *           IADocAccessorPtr;
/*
   If building a text extractor, define BUILDING_IAEXTRACTOR to 1 to export
   the following functions.  If building a client of text extractor plug-ins,
   define BUILDING_IAEXTRACTOR to false so the following methods are not
   exported.
*/
#ifndef BUILDING_IAEXTRACTOR
#define BUILDING_IAEXTRACTOR 1
#endif
#if BUILDING_IAEXTRACTOR
#if PRAGMA_IMPORT
#pragma export on
#endif
#endif
/*
    A Sherlock Plugin is a CFM shared library that implements the following functions:
*/

/*
   IAPluginInit - plug-in's method that is called when opened by a client.  The
   plug-in retuns an IAPluginRef which is an opaque type defined by the plug-in
   and used for the current session.
*/
#if CALL_NOT_IN_CARBON
/*
 *  IAPluginInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
IAPluginInit(
  IAPluginInitBlockPtr   initBlock,
  IAPluginRef *          outPluginRef);


/*
   IAPluginTerm - plug-in's method that is called when closed by a client.  The
   client passes back the IAPluginRef that was returned from IAPluginInit.  At
   this time the plug-in can perform any needed cleanup.
*/
/*
 *  IAPluginTerm()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
IAPluginTerm(IAPluginRef inPluginRef);


/*
   IAGetExtractorVersion - returns the version of the Text Extractor interface that the
   plug-in was built with.
*/
/*
 *  IAGetExtractorVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
IAGetExtractorVersion(
  IAPluginRef   inPluginRef,
  UInt32 *      outPluginVersion);


/*
   IACountSupportedDocTypes - returns number of document types the plug-in supports
*/
/*
 *  IACountSupportedDocTypes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
IACountSupportedDocTypes(
  IAPluginRef   inPluginRef,
  UInt32 *      outCount);


/*
   IAGetIndSupportedDocType - returns the nth document type the plug-in supports.
   First item is one not zero.  Returns the MIME type of supported document
*/
/*
 *  IAGetIndSupportedDocType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
IAGetIndSupportedDocType(
  IAPluginRef   inPluginRef,
  UInt32        inIndex,
  char **       outMIMEType);


/*
   IAOpenDocument - returns a reference to the text of a document.  Client passes in an
   IADocAccessorRecord* that the plug-in can use to to access a document.  Plug-in
   returns IADocRef which an opaque type defined by plug-in to reference the text of
   a document.
*/
/*
 *  IAOpenDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
IAOpenDocument(
  IAPluginRef            inPluginRef,
  IADocAccessorRecord *  inDoc,
  IADocRef *             outDoc);


/*
   IACloseDocument - perform any cleanup for IADocRef that was returned from IAOpenDocument.
*/
/*
 *  IACloseDocument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
IACloseDocument(IADocRef inDoc);


/*
   IAGetNextTextRun - get next run of text.  On input, ioSize is the length of buffer argument.
   On output, ioSize contains the number of bytes written to buffer argument
*/
/*
 *  IAGetNextTextRun()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
IAGetNextTextRun(
  IADocRef   inDoc,
  void *     buffer,
  UInt32 *   ioSize);


/*
   IAGetTextRunInfo - get information about the text returned from the last call to IAGetNextTextRun.
   Arguments outEncoding ane outLanguage are options an NULL can be passed in.  If arguments are
   non-null, plug-in will return pointer to internet encoding and language of last run of text.
   If encoding or language are unknown, plug-in will set *outEncoding and/or *outLanguage to NULL. 
*/
/*
 *  IAGetTextRunInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
IAGetTextRunInfo(
  IADocRef   inDoc,
  char **    outEncoding,
  char **    outLanguage);




#if BUILDING_IAEXTRACTOR
#if PRAGMA_IMPORT
#pragma export off
#endif
#endif




#endif  /* CALL_NOT_IN_CARBON */


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

#endif /* __IAEXTRACTOR__ */


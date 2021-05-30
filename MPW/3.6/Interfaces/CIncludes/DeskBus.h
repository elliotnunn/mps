/*
     File:       DeskBus.h
 
     Contains:   Apple Desktop Bus (ADB) Interfaces.
 
     Version:    Technology: System 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1987-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __DESKBUS__
#define __DESKBUS__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __MIXEDMODE__
#include <MixedMode.h>
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

#if TARGET_OS_MAC
typedef SInt8                           ADBAddress;
#if CALL_NOT_IN_CARBON
typedef CALLBACK_API_REGISTER68K( void , ADBCompletionProcPtr, (Ptr buffer, Ptr refCon, long command) );
typedef CALLBACK_API_REGISTER68K( void , ADBDeviceDriverProcPtr, (SInt8 devAddress, SInt8 devType) );
/*
    TempADBServiceRoutineUPP is needed because of circular definition of
    ADBServiceRoutineProcPtr and ADBServiceRoutineUPP depending on each other.
*/
typedef REGISTER_UPP_TYPE(ADBServiceRoutineProcPtr)             TempADBServiceRoutineUPP;
typedef CALLBACK_API_REGISTER68K( void , ADBServiceRoutineProcPtr, (Ptr buffer, TempADBServiceRoutineUPP completionProc, Ptr refCon, long command) );
typedef CALLBACK_API_REGISTER68K( void , ADBInitProcPtr, (SInt8 callOrder) );
typedef REGISTER_UPP_TYPE(ADBCompletionProcPtr)                 ADBCompletionUPP;
typedef REGISTER_UPP_TYPE(ADBDeviceDriverProcPtr)               ADBDeviceDriverUPP;
typedef REGISTER_UPP_TYPE(ADBServiceRoutineProcPtr)             ADBServiceRoutineUPP;
typedef REGISTER_UPP_TYPE(ADBInitProcPtr)                       ADBInitUPP;
struct ADBDataBlock {
  SInt8               devType;                /* original handler ID */
  SInt8               origADBAddr;            /* original ADB Address */
  ADBServiceRoutineUPP  dbServiceRtPtr;       /* service routine pointer */
  Ptr                 dbDataAreaAddr;         /* this field is passed as the refCon parameter to the service routine */
};
typedef struct ADBDataBlock             ADBDataBlock;
typedef ADBDataBlock *                  ADBDBlkPtr;
struct ADBSetInfoBlock {
  ADBServiceRoutineUPP  siService;            /* service routine pointer */
  Ptr                 siDataAreaAddr;         /* this field is passed as the refCon parameter to the service routine */
};
typedef struct ADBSetInfoBlock          ADBSetInfoBlock;
typedef ADBSetInfoBlock *               ADBSInfoPtr;
/* ADBOpBlock is only used when calling ADBOp from 68k assembly code */
struct ADBOpBlock {
  Ptr                 dataBuffPtr;            /* buffer: pointer to variable length data buffer */
  ADBServiceRoutineUPP  opServiceRtPtr;       /* completionProc: completion routine pointer */
  Ptr                 opDataAreaPtr;          /* refCon: this field is passed as the refCon parameter to the completion routine */
};
typedef struct ADBOpBlock               ADBOpBlock;
typedef ADBOpBlock *                    ADBOpBPtr;
#endif  /* CALL_NOT_IN_CARBON */
#if CALL_NOT_IN_CARBON
/*
 *  ADBReInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
ADBReInit(void)                                               ONEWORDINLINE(0xA07B);


/*
    ADBOp has a different interface for 68k assembly than for everything else
    for 68k assembly the interface is 
    #pragma parameter __D0 ADBOp(__A0,__D0)
    OSErr ADBOp( ADBOpBlock * pb, short commandNum );
*/
/*
    IMPORTANT NOTE:
    "Inside Macintosh: Devices" documents the completion routine for ADBOp will be called with
    four parameters using 68k register based calling conventions, specifically the completion routine
    passed in should be of type ADBServiceRoutineProcPtr. However, when upp types were first added
    to this interface file, the type ADBCompletionUPP was mistakenly used for the second parameter
    to ADBOp. Since applications have shipped using completion routines of type ADBCompletionUPP,
    the mistake cannot be corrected.
    The only difference between ADBServiceRoutineUPP and ADBCompletionUPP is the former takes an extra
    argument which is a pointer to itself, fortunately not needed for PowerPC code.
    For compatibility with existing 68k code, when an ADBOp completion routine is called,
    68k register A1 will point to the completion routine, as documented in Inside Mac.
*/
#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  ADBOp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
ADBOp(
  Ptr                refCon,
  ADBCompletionUPP   compRout,
  Ptr                buffer,
  short              commandNum);


#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  CountADBs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 CountADBs
#endif
EXTERN_API( short )
CountADBs(void)                                               ONEWORDINLINE(0xA077);


/*
 *  GetIndADB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 GetIndADB(__A0, __D0)
#endif
EXTERN_API( ADBAddress )
GetIndADB(
  ADBDataBlock *  info,
  short           devTableIndex)                              ONEWORDINLINE(0xA078);


/*
 *  GetADBInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 GetADBInfo(__A0, __D0)
#endif
EXTERN_API( OSErr )
GetADBInfo(
  ADBDataBlock *  info,
  ADBAddress      adbAddr)                                    ONEWORDINLINE(0xA079);


/*
 *  SetADBInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 SetADBInfo(__A0, __D0)
#endif
EXTERN_API( OSErr )
SetADBInfo(
  const ADBSetInfoBlock *  info,
  ADBAddress               adbAddr)                           ONEWORDINLINE(0xA07A);


#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  NewADBCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ADBCompletionUPP )
NewADBCompletionUPP(ADBCompletionProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppADBCompletionProcInfo = 0x007B9802 };  /* register no_return_value Func(4_bytes:A0, 4_bytes:A2, 4_bytes:D0) */
  #ifdef __cplusplus
    inline ADBCompletionUPP NewADBCompletionUPP(ADBCompletionProcPtr userRoutine) { return (ADBCompletionUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppADBCompletionProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewADBCompletionUPP(userRoutine) (ADBCompletionUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppADBCompletionProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewADBDeviceDriverUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ADBDeviceDriverUPP )
NewADBDeviceDriverUPP(ADBDeviceDriverProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppADBDeviceDriverProcInfo = 0x00050802 };  /* register no_return_value Func(1_byte:D0, 1_byte:D1) */
  #ifdef __cplusplus
    inline ADBDeviceDriverUPP NewADBDeviceDriverUPP(ADBDeviceDriverProcPtr userRoutine) { return (ADBDeviceDriverUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppADBDeviceDriverProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewADBDeviceDriverUPP(userRoutine) (ADBDeviceDriverUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppADBDeviceDriverProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewADBServiceRoutineUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ADBServiceRoutineUPP )
NewADBServiceRoutineUPP(ADBServiceRoutineProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppADBServiceRoutineProcInfo = 0x0F779802 };  /* register no_return_value Func(4_bytes:A0, 4_bytes:A1, 4_bytes:A2, 4_bytes:D0) */
  #ifdef __cplusplus
    inline ADBServiceRoutineUPP NewADBServiceRoutineUPP(ADBServiceRoutineProcPtr userRoutine) { return (ADBServiceRoutineUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppADBServiceRoutineProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewADBServiceRoutineUPP(userRoutine) (ADBServiceRoutineUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppADBServiceRoutineProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewADBInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ADBInitUPP )
NewADBInitUPP(ADBInitProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppADBInitProcInfo = 0x00000802 };  /* register no_return_value Func(1_byte:D0) */
  #ifdef __cplusplus
    inline ADBInitUPP NewADBInitUPP(ADBInitProcPtr userRoutine) { return (ADBInitUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppADBInitProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewADBInitUPP(userRoutine) (ADBInitUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppADBInitProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposeADBCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeADBCompletionUPP(ADBCompletionUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeADBCompletionUPP(ADBCompletionUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeADBCompletionUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeADBDeviceDriverUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeADBDeviceDriverUPP(ADBDeviceDriverUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeADBDeviceDriverUPP(ADBDeviceDriverUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeADBDeviceDriverUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeADBServiceRoutineUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeADBServiceRoutineUPP(ADBServiceRoutineUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeADBServiceRoutineUPP(ADBServiceRoutineUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeADBServiceRoutineUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeADBInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeADBInitUPP(ADBInitUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeADBInitUPP(ADBInitUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeADBInitUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokeADBCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
InvokeADBCompletionUPP(
  Ptr               buffer,
  Ptr               refCon,
  long              command,
  ADBCompletionUPP  userUPP);
#if !OPAQUE_UPP_TYPES && (!TARGET_OS_MAC || !TARGET_CPU_68K || TARGET_RT_MAC_CFM)
  #ifdef __cplusplus
    inline void InvokeADBCompletionUPP(Ptr buffer, Ptr refCon, long command, ADBCompletionUPP userUPP) { CALL_THREE_PARAMETER_UPP(userUPP, uppADBCompletionProcInfo, buffer, refCon, command); }
  #else
    #define InvokeADBCompletionUPP(buffer, refCon, command, userUPP) CALL_THREE_PARAMETER_UPP((userUPP), uppADBCompletionProcInfo, (buffer), (refCon), (command))
  #endif
#endif

/*
 *  InvokeADBDeviceDriverUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter InvokeADBDeviceDriverUPP(__D0, __D1, __A0)
#endif
EXTERN_API_C( void )
InvokeADBDeviceDriverUPP(
  SInt8               devAddress,
  SInt8               devType,
  ADBDeviceDriverUPP  userUPP)                                ONEWORDINLINE(0x4E90);
#if !OPAQUE_UPP_TYPES && (!TARGET_OS_MAC || !TARGET_CPU_68K || TARGET_RT_MAC_CFM)
  #ifdef __cplusplus
    inline void InvokeADBDeviceDriverUPP(SInt8 devAddress, SInt8 devType, ADBDeviceDriverUPP userUPP) { CALL_TWO_PARAMETER_UPP(userUPP, uppADBDeviceDriverProcInfo, devAddress, devType); }
  #else
    #define InvokeADBDeviceDriverUPP(devAddress, devType, userUPP) CALL_TWO_PARAMETER_UPP((userUPP), uppADBDeviceDriverProcInfo, (devAddress), (devType))
  #endif
#endif

/*
 *  InvokeADBServiceRoutineUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
InvokeADBServiceRoutineUPP(
  Ptr                       buffer,
  TempADBServiceRoutineUPP  completionProc,
  Ptr                       refCon,
  long                      command,
  ADBServiceRoutineUPP      userUPP);
#if !OPAQUE_UPP_TYPES && (!TARGET_OS_MAC || !TARGET_CPU_68K || TARGET_RT_MAC_CFM)
  #ifdef __cplusplus
    inline void InvokeADBServiceRoutineUPP(Ptr buffer, TempADBServiceRoutineUPP completionProc, Ptr refCon, long command, ADBServiceRoutineUPP userUPP) { CALL_FOUR_PARAMETER_UPP(userUPP, uppADBServiceRoutineProcInfo, buffer, completionProc, refCon, command); }
  #else
    #define InvokeADBServiceRoutineUPP(buffer, completionProc, refCon, command, userUPP) CALL_FOUR_PARAMETER_UPP((userUPP), uppADBServiceRoutineProcInfo, (buffer), (completionProc), (refCon), (command))
  #endif
#endif

/*
 *  InvokeADBInitUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter InvokeADBInitUPP(__D0, __A0)
#endif
EXTERN_API_C( void )
InvokeADBInitUPP(
  SInt8       callOrder,
  ADBInitUPP  userUPP)                                        ONEWORDINLINE(0x4E90);
#if !OPAQUE_UPP_TYPES && (!TARGET_OS_MAC || !TARGET_CPU_68K || TARGET_RT_MAC_CFM)
  #ifdef __cplusplus
    inline void InvokeADBInitUPP(SInt8 callOrder, ADBInitUPP userUPP) { CALL_ONE_PARAMETER_UPP(userUPP, uppADBInitProcInfo, callOrder); }
  #else
    #define InvokeADBInitUPP(callOrder, userUPP) CALL_ONE_PARAMETER_UPP((userUPP), uppADBInitProcInfo, (callOrder))
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewADBCompletionProc(userRoutine)                   NewADBCompletionUPP(userRoutine)
    #define NewADBDeviceDriverProc(userRoutine)                 NewADBDeviceDriverUPP(userRoutine)
    #define NewADBServiceRoutineProc(userRoutine)               NewADBServiceRoutineUPP(userRoutine)
    #define NewADBInitProc(userRoutine)                         NewADBInitUPP(userRoutine)
    #define CallADBCompletionProc(userRoutine, buffer, refCon, command) InvokeADBCompletionUPP(buffer, refCon, command, userRoutine)
    #define CallADBDeviceDriverProc(userRoutine, devAddress, devType) InvokeADBDeviceDriverUPP(devAddress, devType, userRoutine)
    #define CallADBServiceRoutineProc(userRoutine, buffer, completionProc, refCon, command) InvokeADBServiceRoutineUPP(buffer, completionProc, refCon, command, userRoutine)
    #define CallADBInitProc(userRoutine, callOrder)             InvokeADBInitUPP(callOrder, userRoutine)
#endif /* CALL_NOT_IN_CARBON */

#endif  /* TARGET_OS_MAC */


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

#endif /* __DESKBUS__ */


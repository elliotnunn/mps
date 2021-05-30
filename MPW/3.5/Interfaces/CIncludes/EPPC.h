/*
     File:       EPPC.h
 
     Contains:   High Level Event Manager Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1988-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __EPPC__
#define __EPPC__

#ifndef __MACERRORS__
#include <MacErrors.h>
#endif

#ifndef __APPLETALK__
#include <AppleTalk.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __PPCTOOLBOX__
#include <PPCToolbox.h>
#endif

#ifndef __PROCESSES__
#include <Processes.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
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
                                        /* postOptions currently supported */
  receiverIDMask                = 0x0000F000,
  receiverIDisPSN               = 0x00008000,
  receiverIDisSignature         = 0x00007000,
  receiverIDisSessionID         = 0x00006000,
  receiverIDisTargetID          = 0x00005000,
  systemOptionsMask             = 0x00000F00,
  nReturnReceipt                = 0x00000200,
  priorityMask                  = 0x000000FF,
  nAttnMsg                      = 0x00000001
};

enum {
                                        /* constant for return receipts */
  HighLevelEventMsgClass        = FOUR_CHAR_CODE('jaym'),
  rtrnReceiptMsgID              = FOUR_CHAR_CODE('rtrn')
};

enum {
  msgWasPartiallyAccepted       = 2,
  msgWasFullyAccepted           = 1,
  msgWasNotAccepted             = 0
};

struct TargetID {
  long                sessionID;
  PPCPortRec          name;
  LocationNameRec     location;
  PPCPortRec          recvrName;
};
typedef struct TargetID                 TargetID;
typedef TargetID *                      TargetIDPtr;
typedef TargetIDPtr *                   TargetIDHandle;
typedef TargetIDHandle                  TargetIDHdl;
typedef TargetID                        SenderID;
typedef SenderID *                      SenderIDPtr;
struct HighLevelEventMsg {
  unsigned short      HighLevelEventMsgHeaderLength;
  unsigned short      version;
  unsigned long       reserved1;
  EventRecord         theMsgEvent;
  unsigned long       userRefcon;
  unsigned long       postingOptions;
  unsigned long       msgLength;
};
typedef struct HighLevelEventMsg        HighLevelEventMsg;
typedef HighLevelEventMsg *             HighLevelEventMsgPtr;
typedef HighLevelEventMsgPtr *          HighLevelEventMsgHandle;
typedef HighLevelEventMsgHandle         HighLevelEventMsgHdl;
typedef CALLBACK_API( Boolean , GetSpecificFilterProcPtr )(void *contextPtr, HighLevelEventMsgPtr msgBuff, const TargetID *sender);
typedef STACK_UPP_TYPE(GetSpecificFilterProcPtr)                GetSpecificFilterUPP;
#if CALL_NOT_IN_CARBON
/*
 *  NewGetSpecificFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( GetSpecificFilterUPP )
NewGetSpecificFilterUPP(GetSpecificFilterProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppGetSpecificFilterProcInfo = 0x00000FD0 };  /* pascal 1_byte Func(4_bytes, 4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline GetSpecificFilterUPP NewGetSpecificFilterUPP(GetSpecificFilterProcPtr userRoutine) { return (GetSpecificFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppGetSpecificFilterProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewGetSpecificFilterUPP(userRoutine) (GetSpecificFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppGetSpecificFilterProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposeGetSpecificFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeGetSpecificFilterUPP(GetSpecificFilterUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeGetSpecificFilterUPP(GetSpecificFilterUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeGetSpecificFilterUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokeGetSpecificFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( Boolean )
InvokeGetSpecificFilterUPP(
  void *                contextPtr,
  HighLevelEventMsgPtr  msgBuff,
  const TargetID *      sender,
  GetSpecificFilterUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline Boolean InvokeGetSpecificFilterUPP(void * contextPtr, HighLevelEventMsgPtr msgBuff, const TargetID * sender, GetSpecificFilterUPP userUPP) { return (Boolean)CALL_THREE_PARAMETER_UPP(userUPP, uppGetSpecificFilterProcInfo, contextPtr, msgBuff, sender); }
  #else
    #define InvokeGetSpecificFilterUPP(contextPtr, msgBuff, sender, userUPP) (Boolean)CALL_THREE_PARAMETER_UPP((userUPP), uppGetSpecificFilterProcInfo, (contextPtr), (msgBuff), (sender))
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewGetSpecificFilterProc(userRoutine)               NewGetSpecificFilterUPP(userRoutine)
    #define CallGetSpecificFilterProc(userRoutine, contextPtr, msgBuff, sender) InvokeGetSpecificFilterUPP(contextPtr, msgBuff, sender, userRoutine)
#endif /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
#if CALL_NOT_IN_CARBON
/*
 *  PostHighLevelEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
PostHighLevelEvent(
  const EventRecord *  theEvent,
  void *               receiverID,
  unsigned long        msgRefcon,
  void *               msgBuff,
  unsigned long        msgLen,
  unsigned long        postingOptions)                        THREEWORDINLINE(0x3F3C, 0x0034, 0xA88F);


#endif  /* CALL_NOT_IN_CARBON */

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
#if CALL_NOT_IN_CARBON
/*
 *  AcceptHighLevelEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
AcceptHighLevelEvent(
  TargetID *       sender,
  unsigned long *  msgRefcon,
  void *           msgBuff,
  unsigned long *  msgLen)                                    THREEWORDINLINE(0x3F3C, 0x0033, 0xA88F);


#endif  /* CALL_NOT_IN_CARBON */

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
#if CALL_NOT_IN_CARBON
/*
 *  GetProcessSerialNumberFromPortName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
GetProcessSerialNumberFromPortName(
  const PPCPortRec *     portName,
  ProcessSerialNumber *  pPSN)                                THREEWORDINLINE(0x3F3C, 0x0035, 0xA88F);


#endif  /* CALL_NOT_IN_CARBON */

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
#if CALL_NOT_IN_CARBON
/*
 *  GetPortNameFromProcessSerialNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
GetPortNameFromProcessSerialNumber(
  PPCPortRec *                 portName,
  const ProcessSerialNumber *  pPSN)                          THREEWORDINLINE(0x3F3C, 0x0046, 0xA88F);


#endif  /* CALL_NOT_IN_CARBON */

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
#if CALL_NOT_IN_CARBON
/*
 *  GetSpecificHighLevelEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
GetSpecificHighLevelEvent(
  GetSpecificFilterUPP   aFilter,
  void *                 contextPtr,
  OSErr *                err)                                 THREEWORDINLINE(0x3F3C, 0x0045, 0xA88F);


#endif  /* CALL_NOT_IN_CARBON */

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

#endif /* __EPPC__ */


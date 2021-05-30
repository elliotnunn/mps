/*
     File:       CTBUtilities.h
 
     Contains:   Communications Toolbox Utilities interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1988-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __CTBUTILITIES__
#define __CTBUTILITIES__

#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif

#ifndef __APPLETALK__
#include <AppleTalk.h>
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

#if CALL_NOT_IN_CARBON
enum {
  curCTBUVersion                = 2     /* version of Comm Toolbox Utilities*/
};

enum {
                                        /*    Error codes/types    */
  ctbuGenericError              = -1,
  ctbuNoErr                     = 0
};

typedef OSErr                           CTBUErr;
typedef SInt16 ChooseReturnCode;
enum {
  chooseDisaster                = -2,
  chooseFailed                  = -1,
  chooseAborted                 = 0,
  chooseOKMinor                 = 1,
  chooseOKMajor                 = 2,
  chooseCancel                  = 3
};

typedef UInt16 NuLookupReturnCode;
enum {
  nlOk                          = 0,
  nlCancel                      = 1,
  nlEject                       = 2
};

typedef UInt16 NameFilterReturnCode;
enum {
  nameInclude                   = 1,
  nameDisable                   = 2,
  nameReject                    = 3
};

typedef UInt16 ZoneFilterReturnCode;
enum {
  zoneInclude                   = 1,
  zoneDisable                   = 2,
  zoneReject                    = 3
};


enum {
                                        /*    Values for hookProc items   */
  hookOK                        = 1,
  hookCancel                    = 2,
  hookOutline                   = 3,
  hookTitle                     = 4,
  hookItemList                  = 5,
  hookZoneTitle                 = 6,
  hookZoneList                  = 7,
  hookLine                      = 8,
  hookVersion                   = 9,
  hookReserved1                 = 10,
  hookReserved2                 = 11,
  hookReserved3                 = 12,
  hookReserved4                 = 13,   /*    "virtual" hookProc items   */
  hookNull                      = 100,
  hookItemRefresh               = 101,
  hookZoneRefresh               = 102,
  hookEject                     = 103,
  hookPreflight                 = 104,
  hookPostflight                = 105,
  hookKeyBase                   = 1000
};


/*  NuLookup structures/constants   */
struct NLTypeEntry {
  Handle              hIcon;
  Str32               typeStr;
};
typedef struct NLTypeEntry              NLTypeEntry;
typedef NLTypeEntry                     NLType[4];
struct NBPReply {
  EntityName          theEntity;
  AddrBlock           theAddr;
};
typedef struct NBPReply                 NBPReply;
typedef CALLBACK_API( short , DialogHookProcPtr )(short item, DialogRef theDialog);
typedef CALLBACK_API( short , NameFilterProcPtr )(const EntityName * theEntity);
typedef CALLBACK_API( short , ZoneFilterProcPtr )(ConstStr32Param theZone);
typedef STACK_UPP_TYPE(DialogHookProcPtr)                       DialogHookUPP;
typedef STACK_UPP_TYPE(NameFilterProcPtr)                       NameFilterUPP;
typedef STACK_UPP_TYPE(ZoneFilterProcPtr)                       ZoneFilterUPP;
#if CALL_NOT_IN_CARBON
/*
 *  NewDialogHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( DialogHookUPP )
NewDialogHookUPP(DialogHookProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppDialogHookProcInfo = 0x000003A0 };  /* pascal 2_bytes Func(2_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline DialogHookUPP NewDialogHookUPP(DialogHookProcPtr userRoutine) { return (DialogHookUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDialogHookProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewDialogHookUPP(userRoutine) (DialogHookUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDialogHookProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewNameFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( NameFilterUPP )
NewNameFilterUPP(NameFilterProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppNameFilterProcInfo = 0x000000E0 };  /* pascal 2_bytes Func(4_bytes) */
  #ifdef __cplusplus
    inline NameFilterUPP NewNameFilterUPP(NameFilterProcPtr userRoutine) { return (NameFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNameFilterProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewNameFilterUPP(userRoutine) (NameFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppNameFilterProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewZoneFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ZoneFilterUPP )
NewZoneFilterUPP(ZoneFilterProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppZoneFilterProcInfo = 0x000000E0 };  /* pascal 2_bytes Func(4_bytes) */
  #ifdef __cplusplus
    inline ZoneFilterUPP NewZoneFilterUPP(ZoneFilterProcPtr userRoutine) { return (ZoneFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppZoneFilterProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewZoneFilterUPP(userRoutine) (ZoneFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppZoneFilterProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposeDialogHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeDialogHookUPP(DialogHookUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeDialogHookUPP(DialogHookUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeDialogHookUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeNameFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeNameFilterUPP(NameFilterUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeNameFilterUPP(NameFilterUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeNameFilterUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeZoneFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeZoneFilterUPP(ZoneFilterUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeZoneFilterUPP(ZoneFilterUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeZoneFilterUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokeDialogHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( short )
InvokeDialogHookUPP(
  short          item,
  DialogRef      theDialog,
  DialogHookUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline short InvokeDialogHookUPP(short item, DialogRef theDialog, DialogHookUPP userUPP) { return (short)CALL_TWO_PARAMETER_UPP(userUPP, uppDialogHookProcInfo, item, theDialog); }
  #else
    #define InvokeDialogHookUPP(item, theDialog, userUPP) (short)CALL_TWO_PARAMETER_UPP((userUPP), uppDialogHookProcInfo, (item), (theDialog))
  #endif
#endif

/*
 *  InvokeNameFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( short )
InvokeNameFilterUPP(
  const EntityName *  theEntity,
  NameFilterUPP       userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline short InvokeNameFilterUPP(const EntityName * theEntity, NameFilterUPP userUPP) { return (short)CALL_ONE_PARAMETER_UPP(userUPP, uppNameFilterProcInfo, theEntity); }
  #else
    #define InvokeNameFilterUPP(theEntity, userUPP) (short)CALL_ONE_PARAMETER_UPP((userUPP), uppNameFilterProcInfo, (theEntity))
  #endif
#endif

/*
 *  InvokeZoneFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( short )
InvokeZoneFilterUPP(
  ConstStr32Param  theZone,
  ZoneFilterUPP    userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline short InvokeZoneFilterUPP(ConstStr32Param theZone, ZoneFilterUPP userUPP) { return (short)CALL_ONE_PARAMETER_UPP(userUPP, uppZoneFilterProcInfo, theZone); }
  #else
    #define InvokeZoneFilterUPP(theZone, userUPP) (short)CALL_ONE_PARAMETER_UPP((userUPP), uppZoneFilterProcInfo, (theZone))
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewDialogHookProc(userRoutine)                      NewDialogHookUPP(userRoutine)
    #define NewNameFilterProc(userRoutine)                      NewNameFilterUPP(userRoutine)
    #define NewZoneFilterProc(userRoutine)                      NewZoneFilterUPP(userRoutine)
    #define CallDialogHookProc(userRoutine, item, theDialog)    InvokeDialogHookUPP(item, theDialog, userRoutine)
    #define CallNameFilterProc(userRoutine, theEntity)          InvokeNameFilterUPP(theEntity, userRoutine)
    #define CallZoneFilterProc(userRoutine, theZone)            InvokeZoneFilterUPP(theZone, userRoutine)
#endif /* CALL_NOT_IN_CARBON */

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  InitCTBUtilities()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( CTBUErr )
InitCTBUtilities(void);


/*
 *  CTBGetCTBVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( short )
CTBGetCTBVersion(void);


/*
 *  StandardNBP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( short )
StandardNBP(
  Point              where,
  ConstStr255Param   prompt,
  short              numTypes,
  NLType             typeList,
  NameFilterUPP      nameFilter,
  ZoneFilterUPP      zoneFilter,
  DialogHookUPP      hook,
  NBPReply *         theReply);


/*
 *  CustomNBP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( short )
CustomNBP(
  Point              where,
  ConstStr255Param   prompt,
  short              numTypes,
  NLType             typeList,
  NameFilterUPP      nameFilter,
  ZoneFilterUPP      zoneFilter,
  DialogHookUPP      hook,
  long               userData,
  short              dialogID,
  ModalFilterUPP     filter,
  NBPReply *         theReply);


#endif  /* CALL_NOT_IN_CARBON */

#if OLDROUTINENAMES
#define NuLookup(where, prompt, numTypes, typeList, nameFilter, zoneFilter, \
hook, theReply)                                                             \
StandardNBP(where, prompt, numTypes, typeList, nameFilter, zoneFilter,      \
hook, theReply)
#define NuPLookup(where, prompt, numTypes, typeList, nameFilter,                \
zoneFilter, hook, userData, dialogID, filter, theReply)                     \
CustomNBP(where, prompt, numTypes, typeList, nameFilter,                        \
zoneFilter, hook, userData, dialogID, filter, theReply)
#endif  /* OLDROUTINENAMES */




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

#endif /* __CTBUTILITIES__ */


/*
     File:       Start.h
 
     Contains:   Start Manager Interfaces.
 
     Version:    Technology: Mac OS 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1987-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __START__
#define __START__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __FILES__
#include <Files.h>
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

/*
    Important: When the major version number of kExtensionTableVersion and the value
    returned by gestaltExtensionTableVersion change, it indicates that the Extension
    Table startup mechanism has radically changed and code that doesn't know about
    the new major version must not attempt to use the Extension Table startup
    mechanism.
    
    Changes to the minor version number of kExtensionTableVersion indicate that the
    definition of the ExtensionElement structure has been extended, but the fields
    defined for previous minor versions of kExtensionTableVersion have not changed.
*/
enum {
  kExtensionTableVersion        = 0x00000100 /* current ExtensionTable version (1.0.0) */
};

/* ExtensionNotification message codes */
enum {
  extNotificationBeforeFirst    = 0,    /* Before any extensions have loaded */
  extNotificationAfterLast      = 1,    /* After all extensions have loaded */
  extNotificationBeforeCurrent  = 2,    /* Before extension at extElementIndex is loaded */
  extNotificationAfterCurrent   = 3     /* After extension at extElementIndex is loaded */
};

struct ExtensionElement {
  Str31               fileName;               /* The file name */
  long                parentDirID;            /* the file's parent directory ID */
                                              /* and everything after ioNamePtr in the HParamBlockRec.fileParam variant */
  short               ioVRefNum;              /* always the real volume reference number (not a drive, default, or working dirID) */
  short               ioFRefNum;
  SInt8               ioFVersNum;
  SInt8               filler1;
  short               ioFDirIndex;            /* always 0 in table */
  SInt8               ioFlAttrib;
  SInt8               ioFlVersNum;
  FInfo               ioFlFndrInfo;
  long                ioDirID;
  unsigned short      ioFlStBlk;
  long                ioFlLgLen;
  long                ioFlPyLen;
  unsigned short      ioFlRStBlk;
  long                ioFlRLgLen;
  long                ioFlRPyLen;
  unsigned long       ioFlCrDat;
  unsigned long       ioFlMdDat;
};
typedef struct ExtensionElement         ExtensionElement;
typedef ExtensionElement *              ExtensionElementPtr;
struct ExtensionTableHeader {
  UInt32              extTableHeaderSize;     /* size of ExtensionTable header ( equal to offsetof(ExtensionTable, extElements[0]) ) */
  UInt32              extTableVersion;        /* current ExtensionTable version (same as returned by gestaltExtTableVersion Gestalt selector) */
  UInt32              extElementIndex;        /* current index into ExtensionElement records (zero-based) */
  UInt32              extElementSize;         /* size of ExtensionElement */
  UInt32              extElementCount;        /* number of ExtensionElement records in table (1-based) */
};
typedef struct ExtensionTableHeader     ExtensionTableHeader;
struct ExtensionTable {
  ExtensionTableHeader  extTableHeader;       /* the ExtensionTableHeader */
  ExtensionElement    extElements[1];         /* one element for each extension to load */
};
typedef struct ExtensionTable           ExtensionTable;
typedef ExtensionTable *                ExtensionTablePtr;
typedef ExtensionTablePtr *             ExtensionTableHandle;
typedef CALLBACK_API( void , ExtensionNotificationProcPtr )(UInt32 message, void *param, ExtensionElementPtr extElement);
typedef CALLBACK_API( void , ExtensionTableHandlerProcPtr )(UInt32 message, void *param, ExtensionTableHandle extTableHandle);
typedef STACK_UPP_TYPE(ExtensionNotificationProcPtr)            ExtensionNotificationUPP;
typedef STACK_UPP_TYPE(ExtensionTableHandlerProcPtr)            ExtensionTableHandlerUPP;
#if CALL_NOT_IN_CARBON
/*
 *  NewExtensionNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ExtensionNotificationUPP )
NewExtensionNotificationUPP(ExtensionNotificationProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppExtensionNotificationProcInfo = 0x00000FC0 };  /* pascal no_return_value Func(4_bytes, 4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline ExtensionNotificationUPP NewExtensionNotificationUPP(ExtensionNotificationProcPtr userRoutine) { return (ExtensionNotificationUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppExtensionNotificationProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewExtensionNotificationUPP(userRoutine) (ExtensionNotificationUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppExtensionNotificationProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewExtensionTableHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( ExtensionTableHandlerUPP )
NewExtensionTableHandlerUPP(ExtensionTableHandlerProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppExtensionTableHandlerProcInfo = 0x00000FC0 };  /* pascal no_return_value Func(4_bytes, 4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline ExtensionTableHandlerUPP NewExtensionTableHandlerUPP(ExtensionTableHandlerProcPtr userRoutine) { return (ExtensionTableHandlerUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppExtensionTableHandlerProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewExtensionTableHandlerUPP(userRoutine) (ExtensionTableHandlerUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppExtensionTableHandlerProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposeExtensionNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeExtensionNotificationUPP(ExtensionNotificationUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeExtensionNotificationUPP(ExtensionNotificationUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeExtensionNotificationUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeExtensionTableHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeExtensionTableHandlerUPP(ExtensionTableHandlerUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeExtensionTableHandlerUPP(ExtensionTableHandlerUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeExtensionTableHandlerUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokeExtensionNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
InvokeExtensionNotificationUPP(
  UInt32                    message,
  void *                    param,
  ExtensionElementPtr       extElement,
  ExtensionNotificationUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeExtensionNotificationUPP(UInt32 message, void * param, ExtensionElementPtr extElement, ExtensionNotificationUPP userUPP) { CALL_THREE_PARAMETER_UPP(userUPP, uppExtensionNotificationProcInfo, message, param, extElement); }
  #else
    #define InvokeExtensionNotificationUPP(message, param, extElement, userUPP) CALL_THREE_PARAMETER_UPP((userUPP), uppExtensionNotificationProcInfo, (message), (param), (extElement))
  #endif
#endif

/*
 *  InvokeExtensionTableHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
InvokeExtensionTableHandlerUPP(
  UInt32                    message,
  void *                    param,
  ExtensionTableHandle      extTableHandle,
  ExtensionTableHandlerUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeExtensionTableHandlerUPP(UInt32 message, void * param, ExtensionTableHandle extTableHandle, ExtensionTableHandlerUPP userUPP) { CALL_THREE_PARAMETER_UPP(userUPP, uppExtensionTableHandlerProcInfo, message, param, extTableHandle); }
  #else
    #define InvokeExtensionTableHandlerUPP(message, param, extTableHandle, userUPP) CALL_THREE_PARAMETER_UPP((userUPP), uppExtensionTableHandlerProcInfo, (message), (param), (extTableHandle))
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewExtensionNotificationProc(userRoutine)           NewExtensionNotificationUPP(userRoutine)
    #define NewExtensionTableHandlerProc(userRoutine)           NewExtensionTableHandlerUPP(userRoutine)
    #define CallExtensionNotificationProc(userRoutine, message, param, extElement) InvokeExtensionNotificationUPP(message, param, extElement, userRoutine)
    #define CallExtensionTableHandlerProc(userRoutine, message, param, extTableHandle) InvokeExtensionTableHandlerUPP(message, param, extTableHandle, userRoutine)
#endif /* CALL_NOT_IN_CARBON */

union DefStartRec {
  struct {
    SignedByte          sdExtDevID;
    SignedByte          sdPartition;
    SignedByte          sdSlotNum;
    SignedByte          sdSRsrcID;
  }                       slotDev;
  struct {
    SignedByte          sdReserved1;
    SignedByte          sdReserved2;
    short               sdRefNum;
  }                       scsiDev;
};
typedef union DefStartRec               DefStartRec;
typedef DefStartRec *                   DefStartPtr;
struct DefVideoRec {
  SignedByte          sdSlot;
  SignedByte          sdsResource;
};
typedef struct DefVideoRec              DefVideoRec;
typedef DefVideoRec *                   DefVideoPtr;
struct DefOSRec {
  SignedByte          sdReserved;
  SignedByte          sdOSType;
};
typedef struct DefOSRec                 DefOSRec;
typedef DefOSRec *                      DefOSPtr;
#if CALL_NOT_IN_CARBON
/*
 *  GetDefaultStartup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter GetDefaultStartup(__A0)
#endif
EXTERN_API( void )
GetDefaultStartup(DefStartPtr paramBlock)                     ONEWORDINLINE(0xA07D);


/*
 *  SetDefaultStartup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter SetDefaultStartup(__A0)
#endif
EXTERN_API( void )
SetDefaultStartup(DefStartPtr paramBlock)                     ONEWORDINLINE(0xA07E);


/*
 *  GetVideoDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter GetVideoDefault(__A0)
#endif
EXTERN_API( void )
GetVideoDefault(DefVideoPtr paramBlock)                       ONEWORDINLINE(0xA080);


/*
 *  SetVideoDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter SetVideoDefault(__A0)
#endif
EXTERN_API( void )
SetVideoDefault(DefVideoPtr paramBlock)                       ONEWORDINLINE(0xA081);


/*
 *  GetOSDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter GetOSDefault(__A0)
#endif
EXTERN_API( void )
GetOSDefault(DefOSPtr paramBlock)                             ONEWORDINLINE(0xA084);


/*
 *  SetOSDefault()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter SetOSDefault(__A0)
#endif
EXTERN_API( void )
SetOSDefault(DefOSPtr paramBlock)                             ONEWORDINLINE(0xA083);


#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  SetTimeout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SetTimeout(short count);


/*
 *  GetTimeout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
GetTimeout(short * count);


#endif  /* CALL_NOT_IN_CARBON */

/*
    InstallExtensionNotificationProc

    Installs an ExtensionNotificationUPP.

    Parameters:
        extNotificationProc The ExtensionNotificationUPP to install.

    Results:
        noErr       0       The ExtensionNotificationUPP was installed.
        paramErr    -50     This ExtensionNotificationUPP has already been installed.
        memFullErr  -108    Not enough memory to install the ExtensionNotificationUPP.
*/
#if CALL_NOT_IN_CARBON
/*
 *  InstallExtensionNotificationProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
InstallExtensionNotificationProc(ExtensionNotificationUPP extNotificationProc) TWOWORDINLINE(0x7000, 0xAA7D);



/*
    RemoveExtensionNotificationProc

    Removes an ExtensionNotificationUPP.
    
    Note:   ExtensionNotificationUPPs can't call RemoveExtensionNotificationProc.

    Parameters:
        extNotificationProc The ExtensionNotificationUPP to remove.

    Results:
        noErr       0       The ExtensionNotificationUPP was removed.
        paramErr    -50     The ExtensionNotificationUPP was not found, or
                            RemoveExtensionNotificationProc was called from within
                            a ExtensionNotificationUPP (ExtensionNotificationUPPs can't
                            call RemoveExtensionNotificationProc).
*/
/*
 *  RemoveExtensionNotificationProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
RemoveExtensionNotificationProc(ExtensionNotificationUPP extNotificationProc) TWOWORDINLINE(0x7001, 0xAA7D);



/*
    InstallExtensionTableHandlerProc

    Installs an ExtensionTableHandlerUPP. Control is taken away from the system's default
    handler and the ExtensionTableHandlerUPP is responsible for all changes to the
    ExtensionTable (except for incrementing extElementIndex between extensions). This is
    always the first handler called with extNotificationBeforeFirst and
    extNotificationBeforeCurrent messages and the last handler called with
    extNotificationAfterLast and extNotificationAfterCurrent messages. extElementIndex
    is always incremented immediately after the ExtensionTableHandlerUPP is called with
    the extNotificationAfterCurrent message.
    
    There can only be one ExtensionTableHandler installed.
    
    Warning:    The only safe time to change what ExtensionElement is at
                ExtensionTable.extElements[extElementIndex] is when your
                ExtensionTableHandlerUPP is called with the extNotificationAfterCurrent
                message. You may change the ExtensionTable or the extElementIndex at other
                times, but you must ensure that the ExtensionElement at
                ExtensionTable.extElements[extElementIndex] stays the same.
                
    Note:       If the ExtensionTable or the contents of the folders included in the
                ExtensionTable are changed after installing an ExtensionTableHandler,
                RemoveExtensionTableHandlerProc cannot be called.

    Parameters:
        extMgrProc          The ExtensionTableHandlerUPP to install.
        extTable            A pointer to an ExtensionTableHandle where
                            InstallExtensionTableHandlerProc will return the current
                            ExtensionTableHandle. You don't own the handle itself and
                            must not dispose of it, but you can change the extElementIndex.
                            the extElementCount, and the ExtensionElements in the table.

    Results:
        noErr       0       The ExtensionTableHandlerUPP was installed.
        paramErr    -50     Another ExtensionTableHandlerUPP has already been installed.
        memFullErr  -108    Not enough memory to install the ExtensionTableHandlerUPP.
*/
/*
 *  InstallExtensionTableHandlerProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
InstallExtensionTableHandlerProc(
  ExtensionTableHandlerUPP   extMgrProc,
  ExtensionTableHandle *     extTable)                        TWOWORDINLINE(0x7002, 0xAA7D);



/*
    RemoveExtensionTableHandlerProc

    Remove an ExtensionTableUPP. Control is passed back to the default handler.

    Parameters:
        extMgrProc          The ExtensionTableUPP to remove.

    Results:
        noErr       0       The ExtensionTableUPP was removed.
        paramErr    -50     This ExtensionTableUPP was not installed,
                            or the ExtensionTable no longer matches the
                            original boot ExtensionTable.
*/
/*
 *  RemoveExtensionTableHandlerProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
RemoveExtensionTableHandlerProc(ExtensionTableHandlerUPP extMgrProc) TWOWORDINLINE(0x7003, 0xAA7D);


#endif  /* CALL_NOT_IN_CARBON */

/*
 * Native StartLib calls - these are implemented ONLY on NewWorld machines (iMac, etc.)
 *
 * These functions should be weak linked.  If unavailable, use older method (Get/SetDefaultStartup)
 */
/*
 * The enums below define pseudo startup devices, such as a network disk.  They can be used in place
 * of driveNums in various StartLib calls
 *
 * NOTE - the values are chosen to avoid conflict with vRefNums (low negative numbers), wdRefNums
 *      (large negative numbers) and drive numbers (low positive numbers)
 */
enum {
  kNetworkStartupDevice         = 32767,
  kLocalStartupDevice           = 32766
};

/*
 * The enums below determine the maximum string size of parameters for network startup device calls.
 */
enum {
  kSMProtocolStringSize         = 16,
  kSMAddressStringSize          = 16,
  kSMBootFilenameSize           = 128
};

/*
 * GetSelectedStartupDevice - return the driveNum of the currently selected startup device.  This refers
 * to the device selected by the user via Startup Disk control panel, which may or may not be the
 * device currently booted.
 */
#if CALL_NOT_IN_CARBON
/*
 *  GetSelectedStartupDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in StartLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSErr )
GetSelectedStartupDevice(UInt16 * driveNum);


/*
 * GetSelectedStartupDeviceType - return the type of the currently selected startup device.  This refers
 * to the device selected by the user via Startup Disk control panel, which may or may not be the
 * device currently booted.  Returned types are based on kdgInterface  DriverGestalt response 
 * ('scsi', 'ata ', 'fire', etc.)
 */
/*
 *  GetSelectedStartupDeviceType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in StartLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSErr )
GetSelectedStartupDeviceType(OSType * interfaceType);


/*
 * GetSelectedFirewireStartupDeviceInfo - for a startup device of type Firewire, get pertinent info, including
 * GUID, mao and lun.  This refers to the device selected by the user via Startup Disk control panel, which 
 * may or may not be the device currently booted.
 *
 * GetSelectedFirewireStartupDeviceInfo should only be called if GetSelectedStartupDeviceType returns
 * the type kdgFireWireIntf.  If the selected startup device is not kdgFireWireIntf,
 * GetSelectedFirewireStartupDeviceInfo returns an error (nsDrvErr) and the return parameters are
 * undefined.
 */
/*
 *  GetSelectedFirewireStartupDeviceInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in StartLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSErr )
GetSelectedFirewireStartupDeviceInfo(
  UnsignedWide *  GUID,
  UInt32 *        mao,
  UInt32 *        lun);


/*
 * GetSelectedNetworkStartupDeviceInfo - for a network startup device, return relevant information (this refers
 * to the device selected by the user via Startup Disk control panel, which may or may not be the
 * device currently booted):
 *
 * See the Open Firmware netbooting recommended practices:
 *      http://playground.sun.com/1275/practice/obp-tftp/tftp1_0.pdf
 *
 * The possible parameters for this call are:
 *
 *      [bootp,]siaddr,filename,ciaddr,giaddr,bootp-retries,tftp-retries
 *
 *          bootp...specifies the use of BOOTP as the “discovery” protocol to be used.
 *          siaddr is the IP address of the intended server.
 *          filename is the filename of the file that is to be loaded by TFTP from the server.
 *          ciaddr is the IP address of the client (i.e., the system being booted).
 *          giaddr is the IP address of the BOOTP ‘gateway’.
 *          bootp-retries is the maximum number of retries that are attempted before the BOOTP process is determined to have failed.
 *          tftp-retries is the maximum number of retries that are attempted before the TFTP process is stopped.
 *
 *      Address parameters are specified as strings, not binary (e.g., "128.1.1.1") and are limited to kSMAddressStringSize
 *      (16 bytes) in length.  filename parameter is limited to kSMBootFilenameSize (128 bytes) in length.  protocol 
 *      parameter is limited to kSMProtocolStringSize in length
 */
/*
 *  GetSelectedNetworkStartupDeviceInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in StartLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSErr )
GetSelectedNetworkStartupDeviceInfo(
  char *    protocol,
  char *    siaddr,
  char *    filename,
  char *    ciaddr,
  char *    giaddr,
  UInt32 *  bootpRetries,
  UInt32 *  tftpRetries,
  UInt32    reserved);


/*
 * IsDriveSelectable - determines if the drive specified by driveNum is a candidate for booting.  This
 * checks criteria, such as necessary driver support and Open Firmware support, which are minimal for
 * the device to be considered as a startup device.  This call does not check other criteria, such as
 * whether or not a valid System Folder is present on the volume.
 */
/*
 *  IsDriveSelectable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in StartLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( Boolean )
IsDriveSelectable(UInt16 driveNum);


/*
 * SetSelectedStartupDevice - set the device referred to by driveNum to be the startup device.  Passing
 * the pseudo-device kNetworkStartupDevice sets default enet:bootp behavior.  For more complex 
 * scenarios, use SetSelectedNetworkStartupDevice (q.v.).
 */
/*
 *  SetSelectedStartupDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in StartLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSErr )
SetSelectedStartupDevice(UInt16 driveNum);


/*
 * SetSelectedNetworkStartupDevice - set a network device as the startup device.  This is for more
 * complex setup than handled by SetSelectedStartupDevice.
 *
 * See the Open Firmware netbooting recommended practices:
 *      http://playground.sun.com/1275/practice/obp-tftp/tftp1_0.pdf
 *
 * The possible parameters for this call are:
 *
 *      [bootp,]siaddr,filename,ciaddr,giaddr,bootp-retries,tftp-retries
 *
 *          bootp...specifies the use of BOOTP as the “discovery” protocol to be used.
 *              if not specified (parameter is nil), bootp is used by default
 *          siaddr is the IP address of the intended server.
 *          filename is the filename of the file that is to be loaded by TFTP from the server.
 *          ciaddr is the IP address of the client (i.e., the system being booted).
 *          giaddr is the IP address of the BOOTP ‘gateway’.
 *          bootp-retries is the maximum number of retries that are attempted before the BOOTP process is determined to have failed.
 *          tftp-retries is the maximum number of retries that are attempted before the TFTP process is stopped.
 *
 *      Address parameters are specified as strings, not binary (e.g., "128.1.1.1") and are limited to kSMAddressStringSize
 *      (16 bytes) in length.  filename parameter is limited to kSMBootFilenameSize (128 bytes) in length.  protocol 
 *      parameter is limited to kSMProtocolStringSize in length
 *
 *  NOTE - unspecified parameters should be specified as nil, except for retry parameters which should be zero.
 */
/*
 *  SetSelectedNetworkStartupDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in StartLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSErr )
SetSelectedNetworkStartupDevice(
  char *   protocol,
  char *   siaddr,
  char *   filename,
  char *   ciaddr,
  char *   giaddr,
  UInt32   bootpRetries,
  UInt32   tftpRetries,
  UInt32   reserved);


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

#endif /* __START__ */


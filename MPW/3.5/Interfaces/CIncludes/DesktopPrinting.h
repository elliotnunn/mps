/*
     File:       DesktopPrinting.h
 
     Contains:   Print driver declarations for classic PrintMonitor and Desktop PrintMonitor
 
     Version:    Technology: Mac OS 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __DESKTOPPRINTING__
#define __DESKTOPPRINTING__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __PRINTING__
#include <Printing.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __MACERRORS__
#include <MacErrors.h>
#endif


/* PrGeneral opcodes for desktop printng*/
/* DTP printer types (address types)*/


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
  kDTPUnknownPrinterType        = -1,   /* unknown address type*/
  kDTPSerialPrinterType         = 0,    /* serial printer*/
  kDTPAppleTalkPrinterType      = 1,    /* AppleTalk printer*/
  kDTPTCPIPPrinterType          = 2,    /* TCP/IP printer*/
  kDTPSCSIPrinterType           = 3,    /* SCSI printer*/
  kDTPUSBPrinterType            = 4     /* USB printer*/
};

/* serial ports*/
enum {
  kDTPUnknownPort               = -1,   /* for drivers that support serial connection by the */
                                        /* Comm Toolbox other than modem and printer port*/
  kDTPPrinterPort               = 0,    /* printer port*/
  kDTPModemPort                 = 1     /* modem port*/
};

/* PrGeneral opcodes*/
enum {
  kDTPGetPrinterInfo            = 23,
  kDTPIsSamePrinterInfo         = 24,
  kDTPSetDefaultPrinterInfo     = 25
};

/* serial printer address*/
struct DTPSerialAddress {
  short               port;                   /* kDTPPrinterPort, kDTPModemPort or kDTPUnknownPort*/
  Str31               portName;               /* name of the port specified in the port field*/
};
typedef struct DTPSerialAddress         DTPSerialAddress;
/* AppleTalk printer address*/
struct DTPAppleTalkAddress {
  Str32               nbpName;
  Str32               nbpZone;
  Str32               nbpType;
};
typedef struct DTPAppleTalkAddress      DTPAppleTalkAddress;
/* TCP/IP printer address*/
struct DTPTCPIPAddress {
  Str255              TCPIPAddress;
  Str255              queueName;
};
typedef struct DTPTCPIPAddress          DTPTCPIPAddress;
/* SCSI printer address*/
struct DTPSCSIAddress {
  short               id;                     /* SCSI id*/
};
typedef struct DTPSCSIAddress           DTPSCSIAddress;
/* USB printer address*/
struct DTPUSBAddress {
  Str255              name;                   /* printer name*/
};
typedef struct DTPUSBAddress            DTPUSBAddress;
/* data passed into the PrGeneral calls*/
struct DTPPrinterInfo {
  Str31               dtpDefaultName;         /* default name for the desktop printer.*/
  short               printerType;            /* kDTPSerialPrinterType, kDTPAppleTalkPrinterType, kDTPTCPIPPrinterType,*/
                                              /* kDTPSCSIPrinterType, kDTPUSBPrinterType or kDTPUnknownPrinterType*/

                                              /* Info specific to each type of printers*/
  union {
    DTPSerialAddress    serial;
    DTPAppleTalkAddress  appleTalk;
    DTPTCPIPAddress     tcpip;
    DTPSCSIAddress      scsi;
    DTPUSBAddress       usb;
  }                       u;

                                              /* optional driver-specific information can be appended here*/

};
typedef struct DTPPrinterInfo           DTPPrinterInfo;
typedef DTPPrinterInfo *                DTPPrinterInfoPtr;
typedef DTPPrinterInfoPtr *             DTPPrinterInfoHandle;
struct TDTPPrGeneralData {
  short               iOpCode;                /* kDTPGetPrinterInfo, kDTPIsSamePrinterInfo or kDTPSetDefaultPrinterInfo*/
  short               iError;
  long                iCommand;
  DTPPrinterInfoHandle  printerInfo;
};
typedef struct TDTPPrGeneralData        TDTPPrGeneralData;
/* desktop printer info resource*/
enum {
  kDTPInfoResType               = FOUR_CHAR_CODE('dtpi'),
  kDTPInfoResID                 = -8192
};

/* connection types supported*/
enum {
  kDTPUnknownConnection         = 0x00000000, /* unknown connection type*/
  kDTPSerialConnection          = 0x00000001, /* serial connection*/
  kDTPSCSIConnection            = 0x00000002, /* SCSI connection*/
  kDTPAppleTalkConnection       = 0x00000004, /* AppleTalk connection*/
  kDTPTCPIPConnection           = 0x00000008, /* TCP/IP connection*/
  kDTPUSBConnection             = 0x00000010 /* USB connection*/
};

/* dtp extra features supported*/
enum {
  kDTPBasicFeatures             = 0x00000000 /* only basic dtp funtionalities are supported*/
};

struct DTPInfoResource {
  long                features;               /* kDTPBasicFeatures (only basic features are supported for MacOS 8.5)*/
  long                connectionType;         /* can be kDTPUnknownConnection or any combination of kDTPSerialConnection, */
                                              /* kDTPSCSIConnection, kDTPAppleTalkConnection, kDTPTCPIPConnection and kDTPUSBConnection*/
};
typedef struct DTPInfoResource          DTPInfoResource;
enum {
                                        /* GestaltDTPInfoRec.version*/
  kDTPGestaltStructVersion2     = 0x02008000, /* version 2.0f0 (for Mac OS 8.0, 8.1 and 7.x)*/
  kDTPGestaltStructVersion3     = 0x03000000 /* version 3.0 (for Mac OS 8.5)*/
};

/* DTPInfo*/
struct DTPInfo {
  short               vRefNum;                /* vRefNum of the DTP folder*/
  long                dirID;                  /* directory ID of the DTP folder*/
  Str31               dtpName;                /* name of the DTP folder*/
  OSType              driverType;             /* creator type of the print driver for this DTP*/
  Boolean             current;                /* is this DTP currently the default printer?*/
  Str32               printerName;            /* name of the acutal printer on the net (only for LaserWriter 8 dtps)*/
  Str32               zoneName;               /* zone where this printer resides (only for LaserWriter 8 dtps)*/
};
typedef struct DTPInfo                  DTPInfo;
/* data associated with the desktop printer info gestalt*/
struct GestaltDTPInfoRec {
  long                version;                /* kDTPGestaltStructVersion3 or kDTPGestaltStructVersion2*/
  short               numDTPs;                /* number of the active dtps*/
  Handle              theDTPList;             /* handle to a list of DTPInfo for the active dtps*/
  Handle              theDTPDriverList;       /* handle to a list of print driver file specs for each of the active dtp in theDTPList*/
  long                reserved;
};
typedef struct GestaltDTPInfoRec        GestaltDTPInfoRec;
typedef GestaltDTPInfoRec *             GestaltDTPInfoPtr;
typedef GestaltDTPInfoPtr *             GestaltDTPInfoHdle;
/* AppleEvents */
enum {
  kDTPSignature                 = FOUR_CHAR_CODE('dtpx')
};

enum {
  aeDTPSetDefaultEventType      = FOUR_CHAR_CODE('pfsd'), /* for setting a desktop printer to be the default*/
  aeDTPSyncEventType            = FOUR_CHAR_CODE('pfsc') /* for notifying Desktop PrintMonitor of a new spool file created in a desktop printer folder*/
};

/* event data*/
struct DTPAppleEventData {
  OSType              dtpSignature;           /* kDTPSignature*/
  OSType              dtpEventType;           /* aeDTPSetDefaultEventType or aeDTPSyncEventType*/
  FSSpec              dtpSpec;                /* the file spec of the target dtp*/
};
typedef struct DTPAppleEventData        DTPAppleEventData;
/* Notification during de-spooling*/
/* DTPAsyncErrorNotificationUPP*/
typedef CALLBACK_API( void , DTPAsyncErrorNotificationProcPtr )(StringHandle errStr);
/* DTPEndNotificationUPP*/
typedef CALLBACK_API( void , DTPEndNotificationProcPtr )(void);
/* DTPInForegroundUPP*/
typedef CALLBACK_API( Boolean , DTPInForegroundProcPtr )(void);
/* DTPStatusMessageUPP*/
typedef CALLBACK_API( void , DTPStatusMessageProcPtr )(StringHandle statusStr);
typedef STACK_UPP_TYPE(DTPAsyncErrorNotificationProcPtr)        DTPAsyncErrorNotificationUPP;
typedef STACK_UPP_TYPE(DTPEndNotificationProcPtr)               DTPEndNotificationUPP;
typedef STACK_UPP_TYPE(DTPInForegroundProcPtr)                  DTPInForegroundUPP;
typedef STACK_UPP_TYPE(DTPStatusMessageProcPtr)                 DTPStatusMessageUPP;
#if CALL_NOT_IN_CARBON
/*
 *  NewDTPAsyncErrorNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( DTPAsyncErrorNotificationUPP )
NewDTPAsyncErrorNotificationUPP(DTPAsyncErrorNotificationProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppDTPAsyncErrorNotificationProcInfo = 0x000000C0 };  /* pascal no_return_value Func(4_bytes) */
  #ifdef __cplusplus
    inline DTPAsyncErrorNotificationUPP NewDTPAsyncErrorNotificationUPP(DTPAsyncErrorNotificationProcPtr userRoutine) { return (DTPAsyncErrorNotificationUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDTPAsyncErrorNotificationProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewDTPAsyncErrorNotificationUPP(userRoutine) (DTPAsyncErrorNotificationUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDTPAsyncErrorNotificationProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewDTPEndNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( DTPEndNotificationUPP )
NewDTPEndNotificationUPP(DTPEndNotificationProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppDTPEndNotificationProcInfo = 0x00000000 };  /* pascal no_return_value Func() */
  #ifdef __cplusplus
    inline DTPEndNotificationUPP NewDTPEndNotificationUPP(DTPEndNotificationProcPtr userRoutine) { return (DTPEndNotificationUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDTPEndNotificationProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewDTPEndNotificationUPP(userRoutine) (DTPEndNotificationUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDTPEndNotificationProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewDTPInForegroundUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( DTPInForegroundUPP )
NewDTPInForegroundUPP(DTPInForegroundProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppDTPInForegroundProcInfo = 0x00000010 };  /* pascal 1_byte Func() */
  #ifdef __cplusplus
    inline DTPInForegroundUPP NewDTPInForegroundUPP(DTPInForegroundProcPtr userRoutine) { return (DTPInForegroundUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDTPInForegroundProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewDTPInForegroundUPP(userRoutine) (DTPInForegroundUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDTPInForegroundProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewDTPStatusMessageUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( DTPStatusMessageUPP )
NewDTPStatusMessageUPP(DTPStatusMessageProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppDTPStatusMessageProcInfo = 0x000000C0 };  /* pascal no_return_value Func(4_bytes) */
  #ifdef __cplusplus
    inline DTPStatusMessageUPP NewDTPStatusMessageUPP(DTPStatusMessageProcPtr userRoutine) { return (DTPStatusMessageUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDTPStatusMessageProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewDTPStatusMessageUPP(userRoutine) (DTPStatusMessageUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDTPStatusMessageProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposeDTPAsyncErrorNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeDTPAsyncErrorNotificationUPP(DTPAsyncErrorNotificationUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeDTPAsyncErrorNotificationUPP(DTPAsyncErrorNotificationUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeDTPAsyncErrorNotificationUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeDTPEndNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeDTPEndNotificationUPP(DTPEndNotificationUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeDTPEndNotificationUPP(DTPEndNotificationUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeDTPEndNotificationUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeDTPInForegroundUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeDTPInForegroundUPP(DTPInForegroundUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeDTPInForegroundUPP(DTPInForegroundUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeDTPInForegroundUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeDTPStatusMessageUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeDTPStatusMessageUPP(DTPStatusMessageUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeDTPStatusMessageUPP(DTPStatusMessageUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeDTPStatusMessageUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokeDTPAsyncErrorNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
InvokeDTPAsyncErrorNotificationUPP(
  StringHandle                  errStr,
  DTPAsyncErrorNotificationUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeDTPAsyncErrorNotificationUPP(StringHandle errStr, DTPAsyncErrorNotificationUPP userUPP) { CALL_ONE_PARAMETER_UPP(userUPP, uppDTPAsyncErrorNotificationProcInfo, errStr); }
  #else
    #define InvokeDTPAsyncErrorNotificationUPP(errStr, userUPP) CALL_ONE_PARAMETER_UPP((userUPP), uppDTPAsyncErrorNotificationProcInfo, (errStr))
  #endif
#endif

/*
 *  InvokeDTPEndNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
InvokeDTPEndNotificationUPP(DTPEndNotificationUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeDTPEndNotificationUPP(DTPEndNotificationUPP userUPP) { CALL_ZERO_PARAMETER_UPP(userUPP, uppDTPEndNotificationProcInfo); }
  #else
    #define InvokeDTPEndNotificationUPP(userUPP) CALL_ZERO_PARAMETER_UPP((userUPP), uppDTPEndNotificationProcInfo)
  #endif
#endif

/*
 *  InvokeDTPInForegroundUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( Boolean )
InvokeDTPInForegroundUPP(DTPInForegroundUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline Boolean InvokeDTPInForegroundUPP(DTPInForegroundUPP userUPP) { return (Boolean)CALL_ZERO_PARAMETER_UPP(userUPP, uppDTPInForegroundProcInfo); }
  #else
    #define InvokeDTPInForegroundUPP(userUPP) (Boolean)CALL_ZERO_PARAMETER_UPP((userUPP), uppDTPInForegroundProcInfo)
  #endif
#endif

/*
 *  InvokeDTPStatusMessageUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
InvokeDTPStatusMessageUPP(
  StringHandle         statusStr,
  DTPStatusMessageUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeDTPStatusMessageUPP(StringHandle statusStr, DTPStatusMessageUPP userUPP) { CALL_ONE_PARAMETER_UPP(userUPP, uppDTPStatusMessageProcInfo, statusStr); }
  #else
    #define InvokeDTPStatusMessageUPP(statusStr, userUPP) CALL_ONE_PARAMETER_UPP((userUPP), uppDTPStatusMessageProcInfo, (statusStr))
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewDTPAsyncErrorNotificationProc(userRoutine)       NewDTPAsyncErrorNotificationUPP(userRoutine)
    #define NewDTPEndNotificationProc(userRoutine)              NewDTPEndNotificationUPP(userRoutine)
    #define NewDTPInForegroundProc(userRoutine)                 NewDTPInForegroundUPP(userRoutine)
    #define NewDTPStatusMessageProc(userRoutine)                NewDTPStatusMessageUPP(userRoutine)
    #define CallDTPAsyncErrorNotificationProc(userRoutine, errStr) InvokeDTPAsyncErrorNotificationUPP(errStr, userRoutine)
    #define CallDTPEndNotificationProc(userRoutine)             InvokeDTPEndNotificationUPP(userRoutine)
    #define CallDTPInForegroundProc(userRoutine)                InvokeDTPInForegroundUPP(userRoutine)
    #define CallDTPStatusMessageProc(userRoutine, statusStr)    InvokeDTPStatusMessageUPP(statusStr, userRoutine)
#endif /* CALL_NOT_IN_CARBON */

/* PrGeneral call that PrintMonitor/Desktop PrintMonitor use to set up the notification procs*/
enum {
  kPrintMonitorPrGeneral        = -3
};

/*
   TPrintMonitorPrintingData:
   for classic background printing and desktop printing that does not support third-party drivers 
*/
struct TPrintMonitorPrintingData {
  short               iOpCode;                /* kPrintMonitorPrGeneral*/
  short               iError;
  long                iReserved;              /* 0 - classic PrintMonitor is running*/
  THPrint             hPrint;
  short               noProcs;                /* number of notification procs*/
  long                iReserved2;
  DTPAsyncErrorNotificationUPP  pAsyncNotificationProc; /* UPP to put up a notification*/
  DTPEndNotificationUPP  pAsyncEndnotifyProc; /* UPP to take down the notification*/
  DTPInForegroundUPP  pDTPInForegroundProc;   /* UPP to check if PrintMonitor is in foreground*/
};
typedef struct TPrintMonitorPrintingData TPrintMonitorPrintingData;
/*
   TDesktopPrintMonitorPrintingData:
   for desktop printing that supports third-party print drivers
*/
struct TDesktopPrintMonitorPrintingData {
  short               iOpCode;                /* kPrintMonitorPrGeneral*/
  short               iError;
  long                iReserved;              /* 1 - Desktop PrintMonitor is running*/
  THPrint             hPrint;
  short               noProcs;                /* number of notification procs*/
  long                iReserved2;
  DTPAsyncErrorNotificationUPP  pAsyncNotificationProc; /* UPP to put up a notification*/
  DTPEndNotificationUPP  pAsyncEndnotifyProc; /* UPP to take down the notification*/
  DTPInForegroundUPP  pInForegroundProc;      /* UPP to check if desktop printing is in foreground*/
  DTPStatusMessageUPP  pStatusMessageProc;    /* UPP to update the printing status message in the desktop printer window*/
};
typedef struct TDesktopPrintMonitorPrintingData TDesktopPrintMonitorPrintingData;
/* Spool file data*/

/* spool file data fork*/
struct SpoolFileHeader {
  short               version;                /* should always be 1*/
  long                fileLen;                /* length of the spool file including the spool file header*/
  long                fileFlags;              /* should always be 0*/
  short               numPages;               /* total number of pages in the spool file*/
  TPrint              printRecord;            /* used only if PREC 3 can't be read*/
};
typedef struct SpoolFileHeader          SpoolFileHeader;
typedef SpoolFileHeader *               SpoolFileHeaderPtr;
typedef SpoolFileHeaderPtr *            SpoolFileHeaderHandle;
struct SpoolPage {
  long                pictFlags;              /* should always be 0*/
  Picture             thePict;                /* variable length*/
  long                pageOffset;             /* offset to the beginning of this page's PICT*/
};
typedef struct SpoolPage                SpoolPage;
/*
   spool file resource fork
   PREC 126
*/
struct SpoolPREC126Record {
  short               version;                /* always 1*/
  short               flags;                  /* always 0*/
  short               numPages;               /* total number of pages in the spool file*/
  short               numCopies;              /* total number of copies for the spool file*/
  OSType              creator;                /* the creator type of the print driver that creates the spool file*/
  Str31               appName;                /* the name of the application used to create the spool file*/
};
typedef struct SpoolPREC126Record       SpoolPREC126Record;
typedef SpoolPREC126Record *            SpoolPREC126Ptr;
typedef SpoolPREC126Ptr *               SpoolPREC126Handle;
/* PINX -8200 (page index resource)*/
struct SpoolPageIndex {
  short               count;                  /* number of elements in the pageOffset array*/
  long                pageOffset[1];          /* the offset from the beginning of the file to the page record*/
                                              /* e.g. it would be sizeof(SpoolFileHeader) for the first page.*/
};
typedef struct SpoolPageIndex           SpoolPageIndex;
typedef SpoolPageIndex *                SpoolPageIndexPtr;
typedef SpoolPageIndexPtr *             SpoolPageIndexHandle;
/*
   jobi 1 (DTP print job information resource)
   print priorities
*/
enum {
  kDTPPrintJobUrgent            = 0x00000001,
  kDTPPrintJobAtTime            = 0x00000002,
  kDTPPrintJobNormal            = 0x00000003,
  kDTPPrintJobHolding           = 0x00001003
};

struct DTPPrintJobInfo {
  short               firstPageToPrint;       /* first page in the spool file to print*/
  short               priority;               /* print priority (eg kDTPPrintJobNormal)*/
  short               numCopies;              /* total number of copies*/
  short               numPages;               /* total number of pages in the spool file*/
  unsigned long       timeToPrint;            /* time to print (in seconds) when priority is kDTPPrintJobAtTime*/
  Str31               documentName;           /* name of the document*/
  Str31               applicationName;        /* name of the application that's used to create this spool file*/
  Str32               printerName;            /* name of the target printer (should be the same as what's in PREC 124)*/
};
typedef struct DTPPrintJobInfo          DTPPrintJobInfo;
typedef DTPPrintJobInfo *               DTPPrintJobInfoPtr;
typedef DTPPrintJobInfoPtr *            DTPPrintJobInfoHandle;

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

#endif /* __DESKTOPPRINTING__ */


/*
     File:       PPCToolbox.h
 
     Contains:   Program-Program Communications Toolbox Interfaces.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1989-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __PPCTOOLBOX__
#define __PPCTOOLBOX__

#ifndef __MACTYPES__
#include <MacTypes.h>
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

typedef UInt8 PPCServiceType;
enum {
  ppcServiceRealTime            = 1
};

typedef SInt16 PPCLocationKind;
enum {
  ppcNoLocation                 = 0,    /* There is no PPCLocName */
  ppcNBPLocation                = 1,    /* Use AppleTalk NBP      */
  ppcNBPTypeLocation            = 2,    /* Used for specifying a location name type during PPCOpen only */
  ppcXTIAddrLocation            = 3     /* Use TCP/IP or DNS host name address */
};

typedef SInt16 PPCPortKinds;
enum {
  ppcByCreatorAndType           = 1,    /* Port type is specified as colloquial Mac creator and type */
  ppcByString                   = 2     /* Port type is in pascal string format */
};

/* Values returned for request field in PPCInform call */
typedef UInt8 PPCSessionOrigin;
enum {
  ppcLocalOrigin                = 1,    /* session originated from this machine */
  ppcRemoteOrigin               = 2     /* session originated from remote machine */
};


typedef short                           PPCPortRefNum;
typedef long                            PPCSessRefNum;


/*  The maximum allowed size of a fAddress in PPCXTIAddress */
enum {
  kMaxPPCXTIAddress             = 95
};


/*    
    The possible types of information found in the fAddressType field of a PPCXTIAddress record
    Note:   These constants are the same as the AF_INET & AF_DNS constants, defined in OpenTptInternet.x
*/
typedef SInt16 PPCXTIAddressType;
enum {
  kINETAddrType                 = 2,    /*    An IP address in binary form (type InetHost).*/
  kDNSAddrType                  = 42    /*    A DNS or dotted-decimal name string (no leading length byte, no NULL termination byte)*/
};


/*    
    This structure specifies a transport independent network address in a 
    form that can be used by Open Transport, or as a XTI/TLI/socket network 
    address in UNIX terminology.
*/
struct PPCXTIAddress {
  PPCXTIAddressType   fAddressType;           /* A constant specifying what kind of network address this is */
  UInt8               fAddress[96];           /* The contents of the network address (variable length, NULL terminated). */
};
typedef struct PPCXTIAddress            PPCXTIAddress;
typedef PPCXTIAddress *                 PPCXTIAddressPtr;


/*
    This structure is the variant type used in a LocationNameRec when an IP connection
    is being established for a PPC Toolbox session.
    
    NOTE: The value of the xtiAddrLen must be the length of the entire PPCXTIAddress structure 
    in the xtiAddr field, and not just the length of the fAddress field of the PPCXTIAddress structure.
*/
struct PPCAddrRec {
  UInt8               Reserved[3];            /* reserved - must be initialize to 0          */
  UInt8               xtiAddrLen;             /* size of the xtiAddr field             */
  PPCXTIAddress       xtiAddr;                /* the transport-independent network address   */
};
typedef struct PPCAddrRec               PPCAddrRec;
typedef PPCAddrRec *                    PPCAddrRecPtr;

struct LocationNameRec {
  PPCLocationKind     locationKindSelector;   /* which variant */
  union {
    EntityName          nbpEntity;            /* NBP name entity                   */
    Str32               nbpType;              /* just the NBP type string, for PPCOpen  */
    PPCAddrRec          xtiType;              /* an XTI-type network address record     */
  }                       u;
};
typedef struct LocationNameRec          LocationNameRec;
typedef LocationNameRec *               LocationNamePtr;

struct PPCPortRec {
  ScriptCode          nameScript;             /* script of name */
  Str32Field          name;                   /* name of port as seen in browser */
  PPCPortKinds        portKindSelector;       /* which variant */
  union {
    Str32               portTypeStr;          /* pascal type string */
    struct {
      OSType              portCreator;
      OSType              portType;
    }                       port;
  }                       u;
};
typedef struct PPCPortRec               PPCPortRec;
typedef PPCPortRec *                    PPCPortPtr;
struct PortInfoRec {
  SInt8               filler1;
  Boolean             authRequired;
  PPCPortRec          name;
};
typedef struct PortInfoRec              PortInfoRec;
typedef PortInfoRec *                   PortInfoPtr;
typedef PortInfoRec *                   PortInfoArrayPtr;
typedef union PPCParamBlockRec          PPCParamBlockRec;
typedef PPCParamBlockRec *              PPCParamBlockPtr;
typedef CALLBACK_API( void , PPCCompProcPtr )(PPCParamBlockPtr pb);
typedef STACK_UPP_TYPE(PPCCompProcPtr)                          PPCCompUPP;
#define PPCHeader \
     Ptr            qLink;                  /* PPC's Internal Use */\
     unsigned short csCode;                 /* Requested PPC command */\
     unsigned short intUse;                 /* Internal Use */\
     Ptr            intUsePtr;              /* Internal Use */\
     PPCCompUPP     ioCompletion;           /* 12 --> Completion Routine */\
     volatile OSErr ioResult;               /* 16 <-- Command Result Code */\
     unsigned long  Reserved[5];            /* Reserved for PPC, Don't use */

struct PPCOpenPBRec {
  Ptr                 qLink;                  /* PPC's Internal Use */
  unsigned short      csCode;                 /* Requested PPC command */
  unsigned short      intUse;                 /* Internal Use */
  Ptr                 intUsePtr;              /* Internal Use */
  PPCCompUPP          ioCompletion;           /* 12 --> Completion Routine */
  volatile OSErr      ioResult;               /* 16 <--     Command Result Code */
  unsigned long       Reserved[5];            /* Reserved for PPC, Don't use */
  PPCPortRefNum       portRefNum;             /* 38 <--   Port Reference */
  long                filler1;
  PPCServiceType      serviceType;            /* 44 -->    Bit field describing the requested port service */
  UInt8               resFlag;                /* Must be set to 0 */
  PPCPortPtr          portName;               /* 46 -->   PortName for PPC */
  LocationNamePtr     locationName;           /* 50 -->   If NBP Registration is required */
  Boolean             networkVisible;         /* 54 -->   make this network visible on network */
  Boolean             nbpRegistered;          /* 55 <--   The given location name was registered on the network */
};
typedef struct PPCOpenPBRec             PPCOpenPBRec;
typedef PPCOpenPBRec *                  PPCOpenPBPtr;
struct PPCInformPBRec {
  Ptr                 qLink;                  /* PPC's Internal Use */
  unsigned short      csCode;                 /* Requested PPC command */
  unsigned short      intUse;                 /* Internal Use */
  Ptr                 intUsePtr;              /* Internal Use */
  PPCCompUPP          ioCompletion;           /* 12 --> Completion Routine */
  volatile OSErr      ioResult;               /* 16 <--     Command Result Code */
  unsigned long       Reserved[5];            /* Reserved for PPC, Don't use */
  PPCPortRefNum       portRefNum;             /* 38 -->   Port Identifier */
  PPCSessRefNum       sessRefNum;             /* 40 <--   Session Reference */
  PPCServiceType      serviceType;            /* 44 <--   Status Flags for type of session, local, remote */
  Boolean             autoAccept;             /* 45 -->   if true session will be accepted automatically */
  PPCPortPtr          portName;               /* 46 -->   Buffer for Source PPCPortRec */
  LocationNamePtr     locationName;           /* 50 -->   Buffer for Source LocationNameRec */
  StringPtr           userName;               /* 54 -->   Buffer for Soure user's name trying to link. */
  unsigned long       userData;               /* 58 <--   value included in PPCStart's userData */
  PPCSessionOrigin    requestType;            /* 62 <--   Local or Network */
  SInt8               filler;
};
typedef struct PPCInformPBRec           PPCInformPBRec;
typedef PPCInformPBRec *                PPCInformPBPtr;
struct PPCStartPBRec {
  Ptr                 qLink;                  /* PPC's Internal Use */
  unsigned short      csCode;                 /* Requested PPC command */
  unsigned short      intUse;                 /* Internal Use */
  Ptr                 intUsePtr;              /* Internal Use */
  PPCCompUPP          ioCompletion;           /* 12 --> Completion Routine */
  volatile OSErr      ioResult;               /* 16 <--     Command Result Code */
  unsigned long       Reserved[5];            /* Reserved for PPC, Don't use */
  PPCPortRefNum       portRefNum;             /* 38 -->   Port Identifier */
  PPCSessRefNum       sessRefNum;             /* 40 <--   Session Reference */
  PPCServiceType      serviceType;            /* 44 <--   Actual service method (realTime) */
  UInt8               resFlag;                /* 45 -->   Must be set to 0  */
  PPCPortPtr          portName;               /* 46 -->   Destination portName */
  LocationNamePtr     locationName;           /* 50 -->   NBP or NAS style service location name */
  unsigned long       rejectInfo;             /* 54 <--   reason for rejecting the session request */
  unsigned long       userData;               /* 58 -->   Copied to destination PPCInform parameter block */
  unsigned long       userRefNum;             /* 62 -->   userRefNum (obtained during login process)  */
};
typedef struct PPCStartPBRec            PPCStartPBRec;
typedef PPCStartPBRec *                 PPCStartPBPtr;
struct PPCAcceptPBRec {
  Ptr                 qLink;                  /* PPC's Internal Use */
  unsigned short      csCode;                 /* Requested PPC command */
  unsigned short      intUse;                 /* Internal Use */
  Ptr                 intUsePtr;              /* Internal Use */
  PPCCompUPP          ioCompletion;           /* 12 --> Completion Routine */
  volatile OSErr      ioResult;               /* 16 <--     Command Result Code */
  unsigned long       Reserved[5];            /* Reserved for PPC, Don't use */
  short               filler1;
  PPCSessRefNum       sessRefNum;             /* 40 -->   Session Reference */
};
typedef struct PPCAcceptPBRec           PPCAcceptPBRec;
typedef PPCAcceptPBRec *                PPCAcceptPBPtr;
struct PPCRejectPBRec {
  Ptr                 qLink;                  /* PPC's Internal Use */
  unsigned short      csCode;                 /* Requested PPC command */
  unsigned short      intUse;                 /* Internal Use */
  Ptr                 intUsePtr;              /* Internal Use */
  PPCCompUPP          ioCompletion;           /* 12 --> Completion Routine */
  volatile OSErr      ioResult;               /* 16 <--     Command Result Code */
  unsigned long       Reserved[5];            /* Reserved for PPC, Don't use */
  short               filler1;
  PPCSessRefNum       sessRefNum;             /* 40 -->   Session Reference */
  short               filler2;
  long                filler3;
  long                filler4;
  unsigned long       rejectInfo;             /* 54 -->   reason for rejecting the session request  */
};
typedef struct PPCRejectPBRec           PPCRejectPBRec;
typedef PPCRejectPBRec *                PPCRejectPBPtr;
struct PPCWritePBRec {
  Ptr                 qLink;                  /* PPC's Internal Use */
  unsigned short      csCode;                 /* Requested PPC command */
  unsigned short      intUse;                 /* Internal Use */
  Ptr                 intUsePtr;              /* Internal Use */
  PPCCompUPP          ioCompletion;           /* 12 --> Completion Routine */
  volatile OSErr      ioResult;               /* 16 <--     Command Result Code */
  unsigned long       Reserved[5];            /* Reserved for PPC, Don't use */
  short               filler1;
  PPCSessRefNum       sessRefNum;             /* 40 -->   Session Reference */
  Size                bufferLength;           /* 44 -->   Length of the message buffer */
  Size                actualLength;           /* 48 <--   Actual Length Written */
  Ptr                 bufferPtr;              /* 52 -->   Pointer to message buffer */
  Boolean             more;                   /* 56 -->   if more data in this block will be written */
  SInt8               filler2;
  unsigned long       userData;               /* 58 -->   Message block userData Uninterpreted by PPC */
  OSType              blockCreator;           /* 62 -->   Message block creator Uninterpreted by PPC */
  OSType              blockType;              /* 66 -->   Message block type Uninterpreted by PPC */
};
typedef struct PPCWritePBRec            PPCWritePBRec;
typedef PPCWritePBRec *                 PPCWritePBPtr;
struct PPCReadPBRec {
  Ptr                 qLink;                  /* PPC's Internal Use */
  unsigned short      csCode;                 /* Requested PPC command */
  unsigned short      intUse;                 /* Internal Use */
  Ptr                 intUsePtr;              /* Internal Use */
  PPCCompUPP          ioCompletion;           /* 12 --> Completion Routine */
  volatile OSErr      ioResult;               /* 16 <--     Command Result Code */
  unsigned long       Reserved[5];            /* Reserved for PPC, Don't use */
  short               filler1;
  PPCSessRefNum       sessRefNum;             /* 40 -->   Session Reference */
  Size                bufferLength;           /* 44 -->   Length of the message buffer */
  Size                actualLength;           /* 48 <--   Actual length read */
  Ptr                 bufferPtr;              /* 52 -->   Pointer to message buffer */
  Boolean             more;                   /* 56 <--   if true more data in this block to be read */
  SInt8               filler2;
  unsigned long       userData;               /* 58 <--   Message block userData Uninterpreted by PPC */
  OSType              blockCreator;           /* 62 <--   Message block creator Uninterpreted by PPC */
  OSType              blockType;              /* 66 <--   Message block type Uninterpreted by PPC */
};
typedef struct PPCReadPBRec             PPCReadPBRec;
typedef PPCReadPBRec *                  PPCReadPBPtr;
struct PPCEndPBRec {
  Ptr                 qLink;                  /* PPC's Internal Use */
  unsigned short      csCode;                 /* Requested PPC command */
  unsigned short      intUse;                 /* Internal Use */
  Ptr                 intUsePtr;              /* Internal Use */
  PPCCompUPP          ioCompletion;           /* 12 --> Completion Routine */
  volatile OSErr      ioResult;               /* 16 <--     Command Result Code */
  unsigned long       Reserved[5];            /* Reserved for PPC, Don't use */
  short               filler1;
  PPCSessRefNum       sessRefNum;             /* 40 -->   Session Reference */
};
typedef struct PPCEndPBRec              PPCEndPBRec;
typedef PPCEndPBRec *                   PPCEndPBPtr;
struct PPCClosePBRec {
  Ptr                 qLink;                  /* PPC's Internal Use */
  unsigned short      csCode;                 /* Requested PPC command */
  unsigned short      intUse;                 /* Internal Use */
  Ptr                 intUsePtr;              /* Internal Use */
  PPCCompUPP          ioCompletion;           /* 12 --> Completion Routine */
  volatile OSErr      ioResult;               /* 16 <--     Command Result Code */
  unsigned long       Reserved[5];            /* Reserved for PPC, Don't use */
  PPCPortRefNum       portRefNum;             /* 38 -->   Port Identifier */
};
typedef struct PPCClosePBRec            PPCClosePBRec;
typedef PPCClosePBRec *                 PPCClosePBPtr;
struct IPCListPortsPBRec {
  Ptr                 qLink;                  /* PPC's Internal Use */
  unsigned short      csCode;                 /* Requested PPC command */
  unsigned short      intUse;                 /* Internal Use */
  Ptr                 intUsePtr;              /* Internal Use */
  PPCCompUPP          ioCompletion;           /* 12 --> Completion Routine */
  volatile OSErr      ioResult;               /* 16 <--     Command Result Code */
  unsigned long       Reserved[5];            /* Reserved for PPC, Don't use */
  short               filler1;
  unsigned short      startIndex;             /* 40 -->   Start Index */
  unsigned short      requestCount;           /* 42 -->   Number of entries to be returned */
  unsigned short      actualCount;            /* 44 <--   Actual Number of entries to be returned */
  PPCPortPtr          portName;               /* 46 -->   PortName Match */
  LocationNamePtr     locationName;           /* 50 -->   NBP or NAS type name to locate the Port Location */
  PortInfoArrayPtr    bufferPtr;              /* 54 -->   Pointer to a buffer requestCount*sizeof(PortInfo) bytes big */
};
typedef struct IPCListPortsPBRec        IPCListPortsPBRec;
typedef IPCListPortsPBRec *             IPCListPortsPBPtr;
union PPCParamBlockRec {
  PPCOpenPBRec        openParam;
  PPCInformPBRec      informParam;
  PPCStartPBRec       startParam;
  PPCAcceptPBRec      acceptParam;
  PPCRejectPBRec      rejectParam;
  PPCWritePBRec       writeParam;
  PPCReadPBRec        readParam;
  PPCEndPBRec         endParam;
  PPCClosePBRec       closeParam;
  IPCListPortsPBRec   listPortsParam;
};

/*  PPC Calling Conventions  */
#if CALL_NOT_IN_CARBON
/*
 *  PPCInit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCInit
#endif
EXTERN_API( OSErr )
PPCInit(void)                                                 TWOWORDINLINE(0x7000, 0xA0DD);



/*
 *  PPCOpenSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCOpenSync(__A0)
#endif
EXTERN_API( OSErr )
PPCOpenSync(PPCOpenPBPtr pb)                                  TWOWORDINLINE(0x7001, 0xA0DD);


/*
 *  PPCOpenAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCOpenAsync(__A0)
#endif
EXTERN_API( OSErr )
PPCOpenAsync(PPCOpenPBPtr pb)                                 TWOWORDINLINE(0x7001, 0xA4DD);


/*
 *  PPCInformSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCInformSync(__A0)
#endif
EXTERN_API( OSErr )
PPCInformSync(PPCInformPBPtr pb)                              TWOWORDINLINE(0x7003, 0xA0DD);


/*
 *  PPCInformAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCInformAsync(__A0)
#endif
EXTERN_API( OSErr )
PPCInformAsync(PPCInformPBPtr pb)                             TWOWORDINLINE(0x7003, 0xA4DD);


/*
 *  PPCStartSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCStartSync(__A0)
#endif
EXTERN_API( OSErr )
PPCStartSync(PPCStartPBPtr pb)                                TWOWORDINLINE(0x7002, 0xA0DD);


/*
 *  PPCStartAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCStartAsync(__A0)
#endif
EXTERN_API( OSErr )
PPCStartAsync(PPCStartPBPtr pb)                               TWOWORDINLINE(0x7002, 0xA4DD);


/*
 *  PPCAcceptSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCAcceptSync(__A0)
#endif
EXTERN_API( OSErr )
PPCAcceptSync(PPCAcceptPBPtr pb)                              TWOWORDINLINE(0x7004, 0xA0DD);


/*
 *  PPCAcceptAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCAcceptAsync(__A0)
#endif
EXTERN_API( OSErr )
PPCAcceptAsync(PPCAcceptPBPtr pb)                             TWOWORDINLINE(0x7004, 0xA4DD);


/*
 *  PPCRejectSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCRejectSync(__A0)
#endif
EXTERN_API( OSErr )
PPCRejectSync(PPCRejectPBPtr pb)                              TWOWORDINLINE(0x7005, 0xA0DD);


/*
 *  PPCRejectAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCRejectAsync(__A0)
#endif
EXTERN_API( OSErr )
PPCRejectAsync(PPCRejectPBPtr pb)                             TWOWORDINLINE(0x7005, 0xA4DD);


/*
 *  PPCWriteSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCWriteSync(__A0)
#endif
EXTERN_API( OSErr )
PPCWriteSync(PPCWritePBPtr pb)                                TWOWORDINLINE(0x7006, 0xA0DD);


/*
 *  PPCWriteAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCWriteAsync(__A0)
#endif
EXTERN_API( OSErr )
PPCWriteAsync(PPCWritePBPtr pb)                               TWOWORDINLINE(0x7006, 0xA4DD);


/*
 *  PPCReadSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCReadSync(__A0)
#endif
EXTERN_API( OSErr )
PPCReadSync(PPCReadPBPtr pb)                                  TWOWORDINLINE(0x7007, 0xA0DD);


/*
 *  PPCReadAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCReadAsync(__A0)
#endif
EXTERN_API( OSErr )
PPCReadAsync(PPCReadPBPtr pb)                                 TWOWORDINLINE(0x7007, 0xA4DD);


/*
 *  PPCEndSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCEndSync(__A0)
#endif
EXTERN_API( OSErr )
PPCEndSync(PPCEndPBPtr pb)                                    TWOWORDINLINE(0x7008, 0xA0DD);


/*
 *  PPCEndAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCEndAsync(__A0)
#endif
EXTERN_API( OSErr )
PPCEndAsync(PPCEndPBPtr pb)                                   TWOWORDINLINE(0x7008, 0xA4DD);


/*
 *  PPCCloseSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCCloseSync(__A0)
#endif
EXTERN_API( OSErr )
PPCCloseSync(PPCClosePBPtr pb)                                TWOWORDINLINE(0x7009, 0xA0DD);


/*
 *  PPCCloseAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 PPCCloseAsync(__A0)
#endif
EXTERN_API( OSErr )
PPCCloseAsync(PPCClosePBPtr pb)                               TWOWORDINLINE(0x7009, 0xA4DD);


/*
 *  IPCListPortsSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 IPCListPortsSync(__A0)
#endif
EXTERN_API( OSErr )
IPCListPortsSync(IPCListPortsPBPtr pb)                        TWOWORDINLINE(0x700A, 0xA0DD);


/*
 *  IPCListPortsAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 IPCListPortsAsync(__A0)
#endif
EXTERN_API( OSErr )
IPCListPortsAsync(IPCListPortsPBPtr pb)                       TWOWORDINLINE(0x700A, 0xA4DD);


/*
 *  IPCKillListPorts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter __D0 IPCKillListPorts(__A0)
#endif
EXTERN_API( OSErr )
IPCKillListPorts(IPCListPortsPBPtr pb)                        TWOWORDINLINE(0x700B, 0xA0DD);


/*
 *  DeleteUserIdentity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
DeleteUserIdentity(unsigned long userRef);


/*
 *  GetDefaultUser()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
GetDefaultUser(
  unsigned long *  userRef,
  Str32            userName);


/*
 *  StartSecureSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
StartSecureSession(
  PPCStartPBPtr      pb,
  Str32              userName,
  Boolean            useDefault,
  Boolean            allowGuest,
  Boolean *          guestSelected,
  ConstStr255Param   prompt);


#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API( Boolean , PPCFilterProcPtr )(LocationNamePtr name, PortInfoPtr port);
typedef STACK_UPP_TYPE(PPCFilterProcPtr)                        PPCFilterUPP;
#if CALL_NOT_IN_CARBON
/*
 *  NewPPCCompUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PPCCompUPP )
NewPPCCompUPP(PPCCompProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPPCCompProcInfo = 0x000000C0 };  /* pascal no_return_value Func(4_bytes) */
  #ifdef __cplusplus
    inline PPCCompUPP NewPPCCompUPP(PPCCompProcPtr userRoutine) { return (PPCCompUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPPCCompProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPPCCompUPP(userRoutine) (PPCCompUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPPCCompProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewPPCFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( PPCFilterUPP )
NewPPCFilterUPP(PPCFilterProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppPPCFilterProcInfo = 0x000003D0 };  /* pascal 1_byte Func(4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline PPCFilterUPP NewPPCFilterUPP(PPCFilterProcPtr userRoutine) { return (PPCFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPPCFilterProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewPPCFilterUPP(userRoutine) (PPCFilterUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppPPCFilterProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposePPCCompUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePPCCompUPP(PPCCompUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePPCCompUPP(PPCCompUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePPCCompUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposePPCFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposePPCFilterUPP(PPCFilterUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposePPCFilterUPP(PPCFilterUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposePPCFilterUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokePPCCompUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
InvokePPCCompUPP(
  PPCParamBlockPtr  pb,
  PPCCompUPP        userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokePPCCompUPP(PPCParamBlockPtr pb, PPCCompUPP userUPP) { CALL_ONE_PARAMETER_UPP(userUPP, uppPPCCompProcInfo, pb); }
  #else
    #define InvokePPCCompUPP(pb, userUPP) CALL_ONE_PARAMETER_UPP((userUPP), uppPPCCompProcInfo, (pb))
  #endif
#endif

/*
 *  InvokePPCFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( Boolean )
InvokePPCFilterUPP(
  LocationNamePtr  name,
  PortInfoPtr      port,
  PPCFilterUPP     userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline Boolean InvokePPCFilterUPP(LocationNamePtr name, PortInfoPtr port, PPCFilterUPP userUPP) { return (Boolean)CALL_TWO_PARAMETER_UPP(userUPP, uppPPCFilterProcInfo, name, port); }
  #else
    #define InvokePPCFilterUPP(name, port, userUPP) (Boolean)CALL_TWO_PARAMETER_UPP((userUPP), uppPPCFilterProcInfo, (name), (port))
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewPPCCompProc(userRoutine)                         NewPPCCompUPP(userRoutine)
    #define NewPPCFilterProc(userRoutine)                       NewPPCFilterUPP(userRoutine)
    #define CallPPCCompProc(userRoutine, pb)                    InvokePPCCompUPP(pb, userRoutine)
    #define CallPPCFilterProc(userRoutine, name, port)          InvokePPCFilterUPP(name, port, userRoutine)
#endif /* CALL_NOT_IN_CARBON */

#if CALL_NOT_IN_CARBON
/*
 *  PPCBrowser()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSErr )
PPCBrowser(
  ConstStr255Param   prompt,
  ConstStr255Param   applListLabel,
  Boolean            defaultSpecified,
  LocationNameRec *  theLocation,
  PortInfoRec *      thePortInfo,
  PPCFilterUPP       portFilter,
  ConstStr32Param    theLocNBPType)                           THREEWORDINLINE(0x303C, 0x0D00, 0xA82B);



/*
  The ParamBlock calls without the "Sync" or "Async" suffix are being phased out.
*/
#endif  /* CALL_NOT_IN_CARBON */

#define PPCOpen(pb, async)      ((async) ? PPCOpenAsync(pb)      : PPCOpenSync(pb))
#define PPCInform(pb, async)    ((async) ? PPCInformAsync(pb)    : PPCInformSync(pb))
#define PPCStart(pb, async)     ((async) ? PPCStartAsync(pb)     : PPCStartSync(pb))
#define PPCAccept(pb, async)    ((async) ? PPCAcceptAsync(pb)    : PPCAcceptSync(pb))
#define PPCReject(pb, async)    ((async) ? PPCRejectAsync(pb)    : PPCRejectSync(pb))
#define PPCWrite(pb, async)     ((async) ? PPCWriteAsync(pb)     : PPCWriteSync(pb))
#define PPCRead(pb, async)      ((async) ? PPCReadAsync(pb)      : PPCReadSync(pb))
#define PPCEnd(pb, async)       ((async) ? PPCEndAsync(pb)       : PPCEndSync(pb))
#define PPCClose(pb, async)     ((async) ? PPCCloseAsync(pb)     : PPCCloseSync(pb))
#define IPCListPorts(pb, async) ((async) ? IPCListPortsAsync(pb) : IPCListPortsSync(pb))


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

#endif /* __PPCTOOLBOX__ */


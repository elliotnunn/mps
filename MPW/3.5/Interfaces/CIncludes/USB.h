/*
     File:       USB.h
 
     Contains:   Public API for USB Services Library (and associated components)
 
     Version:    Technology: USB 1.4
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __USB__
#define __USB__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __NAMEREGISTRY__
#include <NameRegistry.h>
#endif

#ifndef __CODEFRAGMENTS__
#include <CodeFragments.h>
#endif

#ifndef __DEVICES__
#include <Devices.h>
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

/* ************* Constants ************* */

enum {
                                        /* Flags */
  kUSBTaskTimeFlag              = 1,
  kUSBHubPower                  = 2,
  kUSBPowerReset                = 4,
  kUSBHubReaddress              = 8,
  kUSBAddressRequest            = 16,
  kUSBReturnOnException         = 32,
  kUSBNo5SecTimeout             = 64,
  kUSBTimeout                   = 128,
  kUSBNoDataTimeout             = 256,
  kUSBDebugAwareFlag            = 512,
  kUSBResetDescriptorCache      = 1024
};

enum {
                                        /* Hub messages */
  kUSBHubPortResetRequest       = 1,
  kUSBHubPortSuspendRequest     = 2,
  kUSBHubPortStatusRequest      = 3
};

enum {
  kVendorID_AppleComputer       = 0x05AC
};

/* ************* types ************* */

typedef SInt32                          USBReference;
typedef USBReference                    USBDeviceRef;
typedef USBDeviceRef *                  USBDeviceRefPtr;
typedef USBReference                    USBInterfaceRef;
typedef USBReference                    USBPipeRef;
typedef USBReference                    USBBusRef;
typedef UInt32                          USBPipeState;
typedef UInt32                          USBCount;
typedef UInt32                          USBFlags;
typedef UInt8                           USBRequest;
typedef UInt8                           USBDirection;
typedef UInt8                           USBRqRecipient;
typedef UInt8                           USBRqType;
typedef UInt16                          USBRqIndex;
typedef UInt16                          USBRqValue;


struct usbControlBits {
  UInt8               BMRequestType;
  UInt8               BRequest;
  USBRqValue          WValue;
  USBRqIndex          WIndex;
  UInt16              reserved4;
};
typedef struct usbControlBits           usbControlBits;
struct USBIsocFrame {
  OSStatus            frStatus;
  UInt16              frReqCount;
  UInt16              frActCount;
};
typedef struct USBIsocFrame             USBIsocFrame;
enum {
  kUSBMaxIsocFrameReqCount      = 1023  /* maximum size (bytes) of any one Isoc frame*/
};

struct usbIsocBits {
  USBIsocFrame *      FrameList;
  UInt32              NumFrames;
};
typedef struct usbIsocBits              usbIsocBits;
struct usbHubBits {
  UInt32              Request;
  UInt32              Spare;
};
typedef struct usbHubBits               usbHubBits;
typedef struct USBPB                    USBPB;
typedef CALLBACK_API_C( void , USBCompletion )(USBPB * pb);
union USBVariantBits {
  usbControlBits      cntl;
  usbIsocBits         isoc;
  usbHubBits          hub;
};
typedef union USBVariantBits            USBVariantBits;
struct USBPB {

  void *              qlink;
  UInt16              qType;
  UInt16              pbLength;
  UInt16              pbVersion;
  UInt16              reserved1;
  UInt32              reserved2;

  OSStatus            usbStatus;
  USBCompletion       usbCompletion;
  UInt32              usbRefcon;

  USBReference        usbReference;

  void *              usbBuffer;
  USBCount            usbReqCount;
  USBCount            usbActCount;

  USBFlags            usbFlags;

  USBVariantBits      usb;

  UInt32              usbFrame;

  UInt8               usbClassType;
  UInt8               usbSubclass;
  UInt8               usbProtocol;
  UInt8               usbOther;

  UInt32              reserved6;
  UInt16              reserved7;
  UInt16              reserved8;

};


typedef USBPB *                         USBPBPtr;
#if !defined(OLDUSBNAMES)
#define OLDUSBNAMES 0
#endif

#if OLDUSBNAMES
#define usbBMRequestType  usb.cntl.BMRequestType
#define usbBRequest       usb.cntl.BRequest
#define usbWValue         usb.cntl.WValue
#define usbWIndex         usb.cntl.WIndex
#endif
struct uslReq {
  USBDirection        usbDirection;
  USBRqType           usbType;
  USBRqRecipient      usbRecipient;
  USBRequest          usbRequest;
};
typedef struct uslReq                   uslReq;

enum {
                                        /* BT 19Aug98, bump up to v1.10 for Isoc*/
  kUSBCurrentPBVersion          = 0x0100, /* v1.00*/
  kUSBIsocPBVersion             = 0x0109, /* v1.10*/
  kUSBCurrentHubPB              = kUSBIsocPBVersion
};




#define kUSBNoCallBack ((USBCompletion)-1L)


typedef UInt8                           bcdUSB;
enum {
  kUSBControl                   = 0,
  kUSBIsoc                      = 1,
  kUSBBulk                      = 2,
  kUSBInterrupt                 = 3,
  kUSBAnyType                   = 0xFF
};

/* endpoint type */
enum {
  kUSBOut                       = 0,
  kUSBIn                        = 1,
  kUSBNone                      = 2,
  kUSBAnyDirn                   = 3
};

/*USBDirection*/
enum {
  kUSBStandard                  = 0,
  kUSBClass                     = 1,
  kUSBVendor                    = 2
};

/*USBRqType*/
enum {
  kUSBDevice                    = 0,
  kUSBInterface                 = 1,
  kUSBEndpoint                  = 2,
  kUSBOther                     = 3
};

/*USBRqRecipient*/
enum {
  kUSBRqGetStatus               = 0,
  kUSBRqClearFeature            = 1,
  kUSBRqReserved1               = 2,
  kUSBRqSetFeature              = 3,
  kUSBRqReserved2               = 4,
  kUSBRqSetAddress              = 5,
  kUSBRqGetDescriptor           = 6,
  kUSBRqSetDescriptor           = 7,
  kUSBRqGetConfig               = 8,
  kUSBRqSetConfig               = 9,
  kUSBRqGetInterface            = 10,
  kUSBRqSetInterface            = 11,
  kUSBRqSyncFrame               = 12
};

/*USBRequest*/

enum {
  kUSBDeviceDesc                = 1,
  kUSBConfDesc                  = 2,
  kUSBStringDesc                = 3,
  kUSBInterfaceDesc             = 4,
  kUSBEndpointDesc              = 5,
  kUSBHIDDesc                   = 0x21,
  kUSBReportDesc                = 0x22,
  kUSBPhysicalDesc              = 0x23,
  kUSBHUBDesc                   = 0x29
};

/* descriptorType */

enum {
  kUSBFeatureDeviceRemoteWakeup = 1,
  kUSBFeatureEndpointStall      = 0
};

/* Feature selectors */
enum {
  kUSBActive                    = 0,    /* Pipe can accept new transactions*/
  kUSBIdle                      = 1,    /* Pipe will not accept new transactions*/
  kUSBStalled                   = 2,    /* An error occured on the pipe*/
  kUSBSuspended                 = 4,    /* Device is suspended*/
  kUSBNoBandwidth               = 8     /* (Isoc or Int) Pipe could not be initialised due to bandwidth constraint*/
};

enum {
  kUSB100mAAvailable            = 50,
  kUSB500mAAvailable            = 250,
  kUSB100mA                     = 50,
  kUSBAtrBusPowered             = 0x80,
  kUSBAtrSelfPowered            = 0x40,
  kUSBAtrRemoteWakeup           = 0x20
};

enum {
  kUSBRel10                     = 0x0100
};

#define USB_CONSTANT16(x)   ((((x) >> 8) & 0x0ff) | ((x & 0xff) << 8))
enum {
  kUSBDeviceDescriptorLength    = 0x12,
  kUSBInterfaceDescriptorLength = 0x09,
  kUSBConfigDescriptorLength    = 0x09
};

struct USBDeviceDescriptor {
  UInt8               length;
  UInt8               descType;
  UInt16              usbRel;
  UInt8               deviceClass;
  UInt8               deviceSubClass;
  UInt8               protocol;
  UInt8               maxPacketSize;
  UInt16              vendor;
  UInt16              product;
  UInt16              devRel;
  UInt8               manuIdx;
  UInt8               prodIdx;
  UInt8               serialIdx;
  UInt8               numConf;
};
typedef struct USBDeviceDescriptor      USBDeviceDescriptor;
typedef USBDeviceDescriptor *           USBDeviceDescriptorPtr;
struct USBDescriptorHeader {
  UInt8               length;
  UInt8               descriptorType;
};
typedef struct USBDescriptorHeader      USBDescriptorHeader;
typedef USBDescriptorHeader *           USBDescriptorHeaderPtr;
struct USBConfigurationDescriptor {
  UInt8               length;
  UInt8               descriptorType;
  UInt16              totalLength;
  UInt8               numInterfaces;
  UInt8               configValue;
  UInt8               configStrIndex;
  UInt8               attributes;
  UInt8               maxPower;
};
typedef struct USBConfigurationDescriptor USBConfigurationDescriptor;
typedef USBConfigurationDescriptor *    USBConfigurationDescriptorPtr;
struct USBInterfaceDescriptor {
  UInt8               length;
  UInt8               descriptorType;
  UInt8               interfaceNumber;
  UInt8               alternateSetting;
  UInt8               numEndpoints;
  UInt8               interfaceClass;
  UInt8               interfaceSubClass;
  UInt8               interfaceProtocol;
  UInt8               interfaceStrIndex;
};
typedef struct USBInterfaceDescriptor   USBInterfaceDescriptor;
typedef USBInterfaceDescriptor *        USBInterfaceDescriptorPtr;
struct USBEndPointDescriptor {
  UInt8               length;
  UInt8               descriptorType;
  UInt8               endpointAddress;
  UInt8               attributes;
  UInt16              maxPacketSize;
  UInt8               interval;
};
typedef struct USBEndPointDescriptor    USBEndPointDescriptor;
typedef USBEndPointDescriptor *         USBEndPointDescriptorPtr;
struct USBHIDDescriptor {
  UInt8               descLen;
  UInt8               descType;
  UInt16              descVersNum;
  UInt8               hidCountryCode;
  UInt8               hidNumDescriptors;
  UInt8               hidDescriptorType;
  UInt8               hidDescriptorLengthLo;  /* can't make this a single 16bit value or the compiler will add a filler byte*/
  UInt8               hidDescriptorLengthHi;
};
typedef struct USBHIDDescriptor         USBHIDDescriptor;
typedef USBHIDDescriptor *              USBHIDDescriptorPtr;
struct USBHIDReportDesc {
  UInt8               hidDescriptorType;
  UInt8               hidDescriptorLengthLo;  /* can't make this a single 16bit value or the compiler will add a filler byte*/
  UInt8               hidDescriptorLengthHi;
};
typedef struct USBHIDReportDesc         USBHIDReportDesc;
typedef USBHIDReportDesc *              USBHIDReportDescPtr;
struct USBHubPortStatus {
  UInt16              portFlags;              /* Port status flags */
  UInt16              portChangeFlags;        /* Port changed flags */
};
typedef struct USBHubPortStatus         USBHubPortStatus;
typedef USBHubPortStatus *              USBHubPortStatusPtr;
/* ********* ProtoTypes *************** */
/* For dealing with endianisms */
#if CALL_NOT_IN_CARBON
/*
 *  HostToUSBWord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( UInt16 )
HostToUSBWord(UInt16 value);


/*
 *  USBToHostWord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( UInt16 )
USBToHostWord(UInt16 value);


/*
 *  HostToUSBLong()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( UInt32 )
HostToUSBLong(UInt32 value);


/*
 *  USBToHostLong()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( UInt32 )
USBToHostLong(UInt32 value);


/* Main prototypes */
/* Transfer commands */
/*
 *  USBDeviceRequest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBDeviceRequest(USBPB * pb);


/*
 *  USBBulkWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBBulkWrite(USBPB * pb);


/*
 *  USBBulkRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBBulkRead(USBPB * pb);


/*
 *  USBIntRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBIntRead(USBPB * pb);


/*
 *  USBIntWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBIntWrite(USBPB * pb);


/*
 *  USBIsocRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBIsocRead(USBPB * pb);


/*
 *  USBIsocWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBIsocWrite(USBPB * pb);


/* Pipe state control */
/*
 *  USBClearPipeStallByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBClearPipeStallByReference(USBPipeRef ref);


/*
 *  USBAbortPipeByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBAbortPipeByReference(USBReference ref);


/*
 *  USBResetPipeByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBResetPipeByReference(USBReference ref);


/*
 *  USBSetPipeIdleByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBSetPipeIdleByReference(USBPipeRef ref);


/*
 *  USBSetPipeActiveByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBSetPipeActiveByReference(USBPipeRef ref);


/*
 *  USBClosePipeByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBClosePipeByReference(USBPipeRef ref);


/*
 *  USBGetPipeStatusByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBGetPipeStatusByReference(
  USBReference    ref,
  USBPipeState *  state);



/* Configuration services */
/*
 *  USBFindNextInterface()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBFindNextInterface(USBPB * pb);


/*
 *  USBOpenDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBOpenDevice(USBPB * pb);


/*
 *  USBSetConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBSetConfiguration(USBPB * pb);


/*
 *  USBNewInterfaceRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBNewInterfaceRef(USBPB * pb);


/*
 *  USBDisposeInterfaceRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBDisposeInterfaceRef(USBPB * pb);


/*
 *  USBConfigureInterface()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBConfigureInterface(USBPB * pb);


/*
 *  USBFindNextPipe()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBFindNextPipe(USBPB * pb);


/*
 *  USBSetPipePolicy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBSetPipePolicy(USBPB * pb);


/* Dealing with descriptors. */
/* Note most of this is temprorary */
/*
 *  USBGetConfigurationDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBGetConfigurationDescriptor(USBPB * pb);


/*
 *  USBGetFullConfigurationDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBGetFullConfigurationDescriptor(USBPB * pb);


/*
 *  USBGetStringDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBGetStringDescriptor(USBPB * pb);


/*
 *  USBFindNextEndpointDescriptorImmediate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBFindNextEndpointDescriptorImmediate(USBPB * pb);


/*
 *  USBFindNextInterfaceDescriptorImmediate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBFindNextInterfaceDescriptorImmediate(USBPB * pb);


/*
 *  USBFindNextAssociatedDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBFindNextAssociatedDescriptor(USBPB * pb);




/* Utility functions */
/*
 *  USBResetDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBResetDevice(USBPB * pb);


/*
 *  USBPortStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBPortStatus(USBPB * pb);


/*
 *  USBSuspendDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBSuspendDevice(USBPB * pb);


/*
 *  USBResumeDeviceByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBResumeDeviceByReference(USBReference refIn);


/*
 *  USBGetBandwidthAvailableByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBGetBandwidthAvailableByReference(
  USBReference   ref,
  UInt32 *       avail);


/*
 *  USBGetFrameNumberImmediate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBGetFrameNumberImmediate(USBPB * pb);


/*
 *  USBDelay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBDelay(USBPB * pb);


/*
 *  USBSAbortQueuesByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBSAbortQueuesByReference(USBReference ref);


/*
 *  USBAllocMem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBAllocMem(USBPB * pb);


/*
 *  USBDeallocMem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBDeallocMem(USBPB * pb);


/* Expert interface functions */
/*
 *  USBExpertInstallInterfaceDriver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBExpertInstallInterfaceDriver(
  USBDeviceRef                ref,
  USBDeviceDescriptorPtr      desc,
  USBInterfaceDescriptorPtr   interfacePtr,
  USBReference                hubRef,
  UInt32                      busPowerAvailable);


/*
 *  USBExpertRemoveInterfaceDriver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBExpertRemoveInterfaceDriver(USBDeviceRef ref);


/*
 *  USBExpertInstallDeviceDriver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBExpertInstallDeviceDriver(
  USBDeviceRef             ref,
  USBDeviceDescriptorPtr   desc,
  USBReference             hubRef,
  UInt32                   port,
  UInt32                   busPowerAvailable);


/*
 *  USBExpertRemoveDeviceDriver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBExpertRemoveDeviceDriver(USBDeviceRef ref);


/*
 *  USBExpertStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBExpertStatus(
  USBDeviceRef   ref,
  void *         pointer,
  UInt32         value);


/*
 *  USBExpertFatalError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBExpertFatalError(
  USBDeviceRef   ref,
  OSStatus       status,
  void *         pointer,
  UInt32         value);


/*
 *  USBExpertNotify()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBFamilyExpertLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBExpertNotify(void * note);


/*
 *  USBExpertStatusLevel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBExpertStatusLevel(
  UInt32         level,
  USBDeviceRef   ref,
  StringPtr      status,
  UInt32         value);


/*
 *  USBExpertGetStatusLevel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( UInt32 )
USBExpertGetStatusLevel(void);


/*
 *  USBExpertSetStatusLevel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
USBExpertSetStatusLevel(UInt32 level);




/*
 *  USBExpertSetDevicePowerStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBExpertSetDevicePowerStatus(
  USBDeviceRef   ref,
  UInt32         reserved1,
  UInt32         reserved2,
  UInt32         powerStatus,
  UInt32         busPowerAvailable,
  UInt32         busPowerNeeded);


#endif  /* CALL_NOT_IN_CARBON */

enum {
  kUSBDevicePower_PowerOK       = 0,
  kUSBDevicePower_BusPowerInsufficient = 1,
  kUSBDevicePower_BusPowerNotAllFeatures = 2,
  kUSBDevicePower_SelfPowerInsufficient = 3,
  kUSBDevicePower_SelfPowerNotAllFeatures = 4,
  kUSBDevicePower_HubPortOk     = 5,
  kUSBDevicePower_HubPortOverCurrent = 6,
  kUSBDevicePower_BusPoweredHubOnLowPowerPort = 7,
  kUSBDevicePower_BusPoweredHubToBusPoweredHub = 8,
  kUSBDevicePower_Reserved3     = 9,
  kUSBDevicePower_Reserved4     = 10
};


/* For hubs only */
#if CALL_NOT_IN_CARBON
/*
 *  USBHubAddDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBHubAddDevice(USBPB * pb);


/*
 *  USBHubConfigurePipeZero()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBHubConfigurePipeZero(USBPB * pb);


/*
 *  USBHubSetAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBHubSetAddress(USBPB * pb);


/*
 *  USBHubDeviceRemoved()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBHubDeviceRemoved(USBPB * pb);


/*
 *  USBMakeBMRequestType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( UInt8 )
USBMakeBMRequestType(
  UInt8   direction,
  UInt8   reqtype,
  UInt8   recipient);


/*
 *  USBControlRequest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBControlRequest(USBPB * pb);


#endif  /* CALL_NOT_IN_CARBON */

typedef UInt32                          USBLocationID;
enum {
  kUSBLocationNibbleFormat      = 0     /* Other values are reserved for future types (like when we have more than 16 ports per hub)*/
};


enum {
  kNoDeviceRef                  = -1
};

/* Status Level constants*/
/*
Level 1: Fatal errors
Level 2: General errors that may or may not effect operation
Level 3: General driver messages.  The "AddStatus" call that drivers use comes through as a level 3.  This is also the default level at boot time.
Level 4: Important status messages from the Expert and USL.
Level 5: General status messages from the Expert and USL.
*/
enum {
  kUSBStatusLevelFatal          = 1,
  kUSBStatusLevelError          = 2,
  kUSBStatusLevelClient         = 3,
  kUSBStatusLevelGeneral        = 4,
  kUSBStatusLevelVerbose        = 5
};

/* Expert Notification Types*/
typedef UInt8 USBNotificationType;
enum {
  kNotifyAddDevice              = 0x00,
  kNotifyRemoveDevice           = 0x01,
  kNotifyAddInterface           = 0x02,
  kNotifyRemoveInterface        = 0x03,
  kNotifyGetDeviceDescriptor    = 0x04,
  kNotifyGetInterfaceDescriptor = 0x05,
  kNotifyGetNextDeviceByClass   = 0x06,
  kNotifyGetDriverConnectionID  = 0x07,
  kNotifyInstallDeviceNotification = 0x08,
  kNotifyRemoveDeviceNotification = 0x09,
  kNotifyDeviceRefToBusRef      = 0x0A,
  kNotifyDriverNotify           = 0x0C,
  kNotifyParentNotify           = 0x0D,
  kNotifyAnyEvent               = 0xFF,
  kNotifyPowerState             = 0x17,
  kNotifyStatus                 = 0x18,
  kNotifyFatalError             = 0x19,
  kNotifyStatusLevel            = 0x20
};

typedef USBNotificationType             USBDriverMessage;
/*
   USB Manager wildcard constants for USBGetNextDeviceByClass
   and USBInstallDeviceNotification.
*/
typedef UInt16 USBManagerWildcard;
enum {
  kUSBAnyClass                  = 0xFFFF,
  kUSBAnySubClass               = 0xFFFF,
  kUSBAnyProtocol               = 0xFFFF,
  kUSBAnyVendor                 = 0xFFFF,
  kUSBAnyProduct                = 0xFFFF
};



struct ExpertNotificationData {
  USBNotificationType  notification;
  UInt8               filler[1];              /* unused due to 2-byte 68k alignment*/
  USBDeviceRef *      deviceRef;
  UInt32              busPowerAvailable;
  void *              data;
  UInt32              info1;
  UInt32              info2;
};
typedef struct ExpertNotificationData   ExpertNotificationData;
typedef ExpertNotificationData *        ExpertNotificationDataPtr;
/* Definition of function pointer passed in ExpertEntryProc*/
typedef CALLBACK_API_C( OSStatus , ExpertNotificationProcPtr )(ExpertNotificationDataPtr pNotificationData);
/* Definition of expert's callback installation function*/
typedef CALLBACK_API_C( OSStatus , ExpertEntryProcPtr )(ExpertNotificationProcPtr pExpertNotify);
/* Device Notification Callback Routine*/
typedef CALLBACK_API_C( void , USBDeviceNotificationCallbackProcPtr )(void * pb);
/* Device Notification Parameter Block*/
struct USBDeviceNotificationParameterBlock {
  UInt16              pbLength;
  UInt16              pbVersion;
  USBNotificationType  usbDeviceNotification;
  UInt8               reserved1[1];           /* needed because of 2-byte 68k alignment*/
  USBDeviceRef        usbDeviceRef;
  UInt16              usbClass;
  UInt16              usbSubClass;
  UInt16              usbProtocol;
  UInt16              usbVendor;
  UInt16              usbProduct;
  OSStatus            result;
  UInt32              token;
  USBDeviceNotificationCallbackProcPtr  callback;
  UInt32              refcon;
};
typedef struct USBDeviceNotificationParameterBlock USBDeviceNotificationParameterBlock;
typedef USBDeviceNotificationParameterBlock * USBDeviceNotificationParameterBlockPtr;
/* Definition of USBDriverNotificationCallback Routine*/
typedef CALLBACK_API_C( void , USBDriverNotificationCallbackPtr )(OSStatus status, UInt32 refcon);
/* Public Functions*/
#if CALL_NOT_IN_CARBON
/*
 *  USBGetVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( UInt32 )
USBGetVersion(void);


/*
 *  USBGetNextDeviceByClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBGetNextDeviceByClass(
  USBDeviceRef *       deviceRef,
  CFragConnectionID *  connID,
  UInt16               theClass,
  UInt16               theSubClass,
  UInt16               theProtocol);


/*
 *  USBGetDeviceDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBGetDeviceDescriptor(
  USBDeviceRef *         deviceRef,
  USBDeviceDescriptor *  deviceDescriptor,
  UInt32                 size);


/*
 *  USBGetInterfaceDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBGetInterfaceDescriptor(
  USBInterfaceRef *         interfaceRef,
  USBInterfaceDescriptor *  interfaceDescriptor,
  UInt32                    size);


/*
 *  USBGetDriverConnectionID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBGetDriverConnectionID(
  USBDeviceRef *       deviceRef,
  CFragConnectionID *  connID);


/*
 *  USBInstallDeviceNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
USBInstallDeviceNotification(USBDeviceNotificationParameterBlock * pb);


/*
 *  USBRemoveDeviceNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBRemoveDeviceNotification(UInt32 token);


/*
 *  USBDeviceRefToBusRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBDeviceRefToBusRef(
  USBDeviceRef *  deviceRef,
  USBBusRef *     busRef);


/*
 *  USBDriverNotify()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBDriverNotify(
  USBReference                       reference,
  USBDriverMessage                   mesg,
  UInt32                             refcon,
  USBDriverNotificationCallbackPtr   callback);


/*
 *  USBExpertNotifyParent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBExpertNotifyParent(
  USBReference   reference,
  void *         pointer);


/*
 *  USBAddDriverForFSSpec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBAddDriverForFSSpec(
  USBReference   reference,
  FSSpec *       fileSpec);


/*
 *  USBAddShimFromDisk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBAddShimFromDisk(FSSpec * shimFilePtr);


/*
 *  USBReferenceToRegEntry()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBReferenceToRegEntry(
  RegEntryID *   parentEntry,
  USBDeviceRef   parentDeviceRef);


/*
 *  USBConfigureADBShim()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBConfigureADBShim(
  UInt32   inCommandID,
  void *   arg1,
  void *   arg2);



#endif  /* CALL_NOT_IN_CARBON */

typedef CALLBACK_API_C( void , HIDInterruptProcPtr )(UInt32 refcon, void *theData);
typedef CALLBACK_API_C( void , HIDNotificationProcPtr )(UInt32 refcon, UInt32 reportSize, void *theReport, USBReference theInterfaceRef);
/* HID Install Interrupt prototype*/
typedef CALLBACK_API_C( OSStatus , USBHIDInstallInterruptProcPtr )(HIDInterruptProcPtr pInterruptProc, UInt32 refcon);
/* HID Poll Device prototype*/
typedef CALLBACK_API_C( OSStatus , USBHIDPollDeviceProcPtr )(void);
/* HID Control Device prototype*/
typedef CALLBACK_API_C( OSStatus , USBHIDControlDeviceProcPtr )(UInt32 theControlSelector, void *theControlData);
/* HID Get Device Info prototype*/
typedef CALLBACK_API_C( OSStatus , USBHIDGetDeviceInfoProcPtr )(UInt32 theInfoSelector, void *theInfo);
/* HID Enter Polled Mode prototype*/
typedef CALLBACK_API_C( OSStatus , USBHIDEnterPolledModeProcPtr )(void);
/* HID Exit Polled Mode prototype*/
typedef CALLBACK_API_C( OSStatus , USBHIDExitPolledModeProcPtr )(void);
/* HID Install Notification prototype*/
typedef CALLBACK_API_C( OSStatus , USBHIDInstallNotificationProcPtr )(HIDNotificationProcPtr pNotificationProc, UInt32 refcon);
enum {
  kHIDStandardDispatchVersion   = 0,
  kHIDReservedDispatchVersion   = 1,
  kHIDNotificationDispatchVersion = 2,
  kHIDCurrentDispatchVersion    = 2
};


struct USBHIDRev2DispatchTable {
  UInt32              hidDispatchVersion;
  USBHIDInstallInterruptProcPtr  pUSBHIDInstallInterrupt;
  USBHIDPollDeviceProcPtr  pUSBHIDPollDevice;
  USBHIDControlDeviceProcPtr  pUSBHIDControlDevice;
  USBHIDGetDeviceInfoProcPtr  pUSBHIDGetDeviceInfo;
  USBHIDEnterPolledModeProcPtr  pUSBHIDEnterPolledMode;
  USBHIDExitPolledModeProcPtr  pUSBHIDExitPolledMode;
  USBHIDInstallNotificationProcPtr  pUSBHIDInstallNotification;
};
typedef struct USBHIDRev2DispatchTable  USBHIDRev2DispatchTable;
typedef USBHIDRev2DispatchTable *       USBHIDRev2DispatchTablePtr;
struct USBHIDModuleDispatchTable {
  UInt32              hidDispatchVersion;
  USBHIDInstallInterruptProcPtr  pUSBHIDInstallInterrupt;
  USBHIDPollDeviceProcPtr  pUSBHIDPollDevice;
  USBHIDControlDeviceProcPtr  pUSBHIDControlDevice;
  USBHIDGetDeviceInfoProcPtr  pUSBHIDGetDeviceInfo;
  USBHIDEnterPolledModeProcPtr  pUSBHIDEnterPolledMode;
  USBHIDExitPolledModeProcPtr  pUSBHIDExitPolledMode;
};
typedef struct USBHIDModuleDispatchTable USBHIDModuleDispatchTable;
typedef USBHIDModuleDispatchTable *     USBHIDModuleDispatchTablePtr;
/*  Prototypes Tue, Mar 17, 1998 4:54:30 PM */
#if CALL_NOT_IN_CARBON
/*
 *  USBHIDInstallInterrupt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBHIDInstallInterrupt(
  HIDInterruptProcPtr   HIDInterruptFunction,
  UInt32                refcon);


/*
 *  USBHIDPollDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBHIDPollDevice(void);


/*
 *  USBHIDControlDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBHIDControlDevice(
  UInt32   theControlSelector,
  void *   theControlData);


/*
 *  USBHIDGetDeviceInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBHIDGetDeviceInfo(
  UInt32   theInfoSelector,
  void *   theInfo);


/*
 *  USBHIDEnterPolledMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBHIDEnterPolledMode(void);


/*
 *  USBHIDExitPolledMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBHIDExitPolledMode(void);


/*
 *  USBHIDInstallNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( OSStatus )
USBHIDInstallNotification(
  HIDNotificationProcPtr   HIDNotificationFunction,
  UInt32                   refcon);


/*
 *  HIDNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
HIDNotification(
  UInt32   devicetype,
  UInt8    NewHIDData[],
  UInt8    OldHIDData[]);


#endif  /* CALL_NOT_IN_CARBON */

enum {
  kHIDRqGetReport               = 1,
  kHIDRqGetIdle                 = 2,
  kHIDRqGetProtocol             = 3,
  kHIDRqSetReport               = 9,
  kHIDRqSetIdle                 = 10,
  kHIDRqSetProtocol             = 11
};

enum {
  kHIDRtInputReport             = 1,
  kHIDRtOutputReport            = 2,
  kHIDRtFeatureReport           = 3
};

enum {
  kHIDBootProtocolValue         = 0,
  kHIDReportProtocolValue       = 1
};

enum {
  kHIDKeyboardInterfaceProtocol = 1,
  kHIDMouseInterfaceProtocol    = 2
};

enum {
  kHIDSetLEDStateByBits         = 1,
  kHIDSetLEDStateByBitMask      = 1,
  kHIDSetLEDStateByIDNumber     = 2,
  kHIDRemoveInterruptHandler    = 3,
  kHIDEnableDemoMode            = 4,
  kHIDDisableDemoMode           = 5,
  kHIDRemoveNotification        = 0x1000
};

enum {
  kHIDGetLEDStateByBits         = 1,    /* not supported in 1.0 of keyboard module*/
  kHIDGetLEDStateByBitMask      = 1,    /* not supported in 1.0 of keyboard module*/
  kHIDGetLEDStateByIDNumber     = 2,
  kHIDGetDeviceCountryCode      = 3,    /* not supported in 1.0 HID modules*/
  kHIDGetDeviceUnitsPerInch     = 4,    /* only supported in mouse HID module*/
  kHIDGetInterruptHandler       = 5,
  kHIDGetCurrentKeys            = 6,    /* only supported in keyboard HID module*/
  kHIDGetInterruptRefcon        = 7,
  kHIDGetVendorID               = 8,
  kHIDGetProductID              = 9
};


enum {
  kNumLockLED                   = 0,
  kCapsLockLED                  = 1,
  kScrollLockLED                = 2,
  kComposeLED                   = 3,
  kKanaLED                      = 4
};

enum {
  kNumLockLEDMask               = 1 << kNumLockLED,
  kCapsLockLEDMask              = 1 << kCapsLockLED,
  kScrollLockLEDMask            = 1 << kScrollLockLED,
  kComposeLEDMask               = 1 << kComposeLED,
  kKanaLEDMask                  = 1 << kKanaLED
};

enum {
  kUSBCapsLockKey               = 0x39,
  kUSBNumLockKey                = 0x53,
  kUSBScrollLockKey             = 0x47
};

struct USBMouseData {
  UInt16              buttons;
  SInt16              XDelta;
  SInt16              YDelta;
};
typedef struct USBMouseData             USBMouseData;
typedef USBMouseData *                  USBMouseDataPtr;
struct USBKeyboardData {
  UInt16              keycount;
  UInt16              usbkeycode[32];
};
typedef struct USBKeyboardData          USBKeyboardData;
typedef USBKeyboardData *               USBKeyboardDataPtr;
union USBHIDData {
  USBKeyboardData     kbd;
  USBMouseData        mouse;
};
typedef union USBHIDData                USBHIDData;
typedef USBHIDData *                    USBHIDDataPtr;
#if CALL_NOT_IN_CARBON
/*
 *  StartCompoundClassDriver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
StartCompoundClassDriver(
  USBDeviceRef   device,
  UInt16         classID,
  UInt16         subClass);


#endif  /* CALL_NOT_IN_CARBON */

enum {
  kUSBCompositeClass            = 0,
  kUSBAudioClass                = 1,
  kUSBCommClass                 = 2,
  kUSBHIDClass                  = 3,
  kUSBDisplayClass              = 4,
  kUSBPrintingClass             = 7,
  kUSBMassStorageClass          = 8,
  kUSBHubClass                  = 9,
  kUSBDataClass                 = 10,
  kUSBVendorSpecificClass       = 0xFF
};

enum {
  kUSBCompositeSubClass         = 0,
  kUSBHubSubClass               = 1,
  kUSBPrinterSubclass           = 1,
  kUSBVendorSpecificSubClass    = 0xFF
};

enum {
  kUSBHIDInterfaceClass         = 0x03
};

enum {
  kUSBNoInterfaceSubClass       = 0x00,
  kUSBBootInterfaceSubClass     = 0x01
};

enum {
  kUSBNoInterfaceProtocol       = 0x00,
  kUSBKeyboardInterfaceProtocol = 0x01,
  kUSBMouseInterfaceProtocol    = 0x02,
  kUSBVendorSpecificProtocol    = 0xFF
};

enum {
  kUSBPrinterUnidirectionalProtocol = 0x01,
  kUSBPrinterBidirectionalProtocol = 0x02
};


enum {
  kServiceCategoryUSB           = FOUR_CHAR_CODE('usb ') /* USB*/
};

enum {
  kUSBDriverFileType            = FOUR_CHAR_CODE('ndrv'),
  kUSBDriverRsrcType            = FOUR_CHAR_CODE('usbd'),
  kUSBShimRsrcType              = FOUR_CHAR_CODE('usbs')
};

enum {
  kTheUSBDriverDescriptionSignature = FOUR_CHAR_CODE('usbd')
};

enum {
  kInitialUSBDriverDescriptor   = 0
};


typedef UInt32                          USBDriverDescVersion;
/*  Driver Loading Options*/
typedef UInt32 USBDriverLoadingOptions;
enum {
  kUSBDoNotMatchGenericDevice   = 0x00000001, /* Driver's VendorID must match Device's VendorID*/
  kUSBDoNotMatchInterface       = 0x00000002, /* Do not load this driver as an interface driver.*/
  kUSBProtocolMustMatch         = 0x00000004, /* Do not load this driver if protocol field doesn't match.*/
  kUSBInterfaceMatchOnly        = 0x00000008 /* Only load this driver as an interface driver.*/
};

enum {
  kClassDriverPluginVersion     = 0x00001100
};



struct USBDeviceInfo {
  UInt16              usbVendorID;            /* USB Vendor ID*/
  UInt16              usbProductID;           /* USB Product ID.*/
  UInt16              usbDeviceReleaseNumber; /* Release Number of Device*/
  UInt16              usbDeviceProtocol;      /* Protocol Info.*/
};
typedef struct USBDeviceInfo            USBDeviceInfo;
typedef USBDeviceInfo *                 USBDeviceInfoPtr;
struct USBInterfaceInfo {
  UInt8               usbConfigValue;         /* Configuration Value*/
  UInt8               usbInterfaceNum;        /* Interface Number*/
  UInt8               usbInterfaceClass;      /* Interface Class*/
  UInt8               usbInterfaceSubClass;   /* Interface SubClass*/
  UInt8               usbInterfaceProtocol;   /* Interface Protocol*/
};
typedef struct USBInterfaceInfo         USBInterfaceInfo;
typedef USBInterfaceInfo *              USBInterfaceInfoPtr;
struct USBDriverType {
  Str31               nameInfoStr;            /* Driver's name when loading into the Name Registry.*/
  UInt8               usbDriverClass;         /* USB Class this driver belongs to.*/
  UInt8               usbDriverSubClass;      /* Module type*/
  NumVersion          usbDriverVersion;       /* Class driver version number.*/
};
typedef struct USBDriverType            USBDriverType;
typedef USBDriverType *                 USBDriverTypePtr;
struct USBDriverDescription {
  OSType              usbDriverDescSignature; /* Signature field of this structure.*/
  USBDriverDescVersion  usbDriverDescVersion; /* Version of this data structure.*/
  USBDeviceInfo       usbDeviceInfo;          /* Product & Vendor Info*/
  USBInterfaceInfo    usbInterfaceInfo;       /* Interface info*/
  USBDriverType       usbDriverType;          /* Driver Info.*/
  USBDriverLoadingOptions  usbDriverLoadingOptions; /* Options for class driver loading.*/
};
typedef struct USBDriverDescription     USBDriverDescription;
typedef USBDriverDescription *          USBDriverDescriptionPtr;
/*
   Dispatch Table
   Definition of class driver's HW Validation proc.
*/
typedef CALLBACK_API_C( OSStatus , USBDValidateHWProcPtr )(USBDeviceRef device, USBDeviceDescriptorPtr pDesc);
/*
   Definition of class driver's device initialization proc.
   Called if the driver is being loaded for a device
*/
typedef CALLBACK_API_C( OSStatus , USBDInitializeDeviceProcPtr )(USBDeviceRef device, USBDeviceDescriptorPtr pDesc, UInt32 busPowerAvailable);
/* Definition of class driver's interface initialization proc.*/
typedef CALLBACK_API_C( OSStatus , USBDInitializeInterfaceProcPtr )(UInt32 interfaceNum, USBInterfaceDescriptorPtr pInterface, USBDeviceDescriptorPtr pDevice, USBInterfaceRef interfaceRef);
/* Definition of class driver's finalization proc.*/
typedef CALLBACK_API_C( OSStatus , USBDFinalizeProcPtr )(USBDeviceRef device, USBDeviceDescriptorPtr pDesc);
typedef UInt32 USBDriverNotification;
enum {
  kNotifySystemSleepRequest     = 0x00000001,
  kNotifySystemSleepDemand      = 0x00000002,
  kNotifySystemSleepWakeUp      = 0x00000003,
  kNotifySystemSleepRevoke      = 0x00000004,
  kNotifyHubEnumQuery           = 0x00000006,
  kNotifyChildMessage           = 0x00000007,
  kNotifyExpertTerminating      = 0x00000008,
  kNotifyDriverBeingRemoved     = 0x0000000B,
  kNotifyAllowROMDriverRemoval  = 0x0000000E
};

/*
   Definition of driver's notification proc.      
   Added refcon for 1.1 version of dispatch table
*/
typedef CALLBACK_API_C( OSStatus , USBDDriverNotifyProcPtr )(USBDriverNotification notification, void *pointer, UInt32 refcon);
struct USBClassDriverPluginDispatchTable {
  UInt32              pluginVersion;
  USBDValidateHWProcPtr  validateHWProc;      /* Proc for driver to verify proper HW*/
  USBDInitializeDeviceProcPtr  initializeDeviceProc; /* Proc that initializes the class driver.*/
  USBDInitializeInterfaceProcPtr  initializeInterfaceProc; /* Proc that initializes a particular interface in the class driver.*/
  USBDFinalizeProcPtr  finalizeProc;          /* Proc that finalizes the class driver.*/
  USBDDriverNotifyProcPtr  notificationProc;  /* Proc to pass notifications to the driver.*/
};
typedef struct USBClassDriverPluginDispatchTable USBClassDriverPluginDispatchTable;
typedef USBClassDriverPluginDispatchTable * USBClassDriverPluginDispatchTablePtr;
/* Shim Defines*/
enum {
  kTheUSBShimDescriptionSignature = FOUR_CHAR_CODE('usbs')
};

typedef UInt32 USBShimDescVersion;
enum {
  kCurrentUSBShimDescVers       = 0x0100
};

/*  Shim Loading Options*/
typedef UInt32 USBShimLoadingOptions;
enum {
  kUSBRegisterShimAsSharedLibrary = 0x00000001 /* Driver's VendorID must match Device's VendorID*/
};

struct USBShimDescription {
  OSType              usbShimDescSignature;   /* Signature field of this structure.*/
  USBShimDescVersion  usbShimDescVersion;     /* Version of this data structure.*/
  USBShimLoadingOptions  usbDriverLoadingOptions; /* Options for shim loading.*/
  Str63               libraryName;            /* For optional shared library registration*/
};
typedef struct USBShimDescription       USBShimDescription;
typedef USBShimDescription *            USBShimDescriptionPtr;
/* Hub defines*/

enum {
  kUSBHubDescriptorType         = 0x29
};

enum {
                                        /* Hub features */
  kUSBHubLocalPowerChangeFeature = 0,
  kUSBHubOverCurrentChangeFeature = 1,  /* port features */
  kUSBHubPortConnectionFeature  = 0,
  kUSBHubPortEnableFeature      = 1,
  kUSBHubPortSuspendFeature     = 2,
  kUSBHubPortOverCurrentFeature = 3,
  kUSBHubPortResetFeature       = 4,
  kUSBHubPortPowerFeature       = 8,
  kUSBHubPortLowSpeedFeature    = 9,
  kUSBHubPortConnectionChangeFeature = 16,
  kUSBHubPortEnableChangeFeature = 17,
  kUSBHubPortSuspendChangeFeature = 18,
  kUSBHubPortOverCurrentChangeFeature = 19,
  kUSBHubPortResetChangeFeature = 20
};


enum {
  kHubPortConnection            = 1,
  kHubPortEnabled               = 2,
  kHubPortSuspend               = 4,
  kHubPortOverCurrent           = 8,
  kHubPortBeingReset            = 16,
  kHubPortPower                 = 0x0100,
  kHubPortSpeed                 = 0x0200
};

enum {
  kHubLocalPowerStatus          = 1,
  kHubOverCurrentIndicator      = 2,
  kHubLocalPowerStatusChange    = 1,
  kHubOverCurrentIndicatorChange = 2
};

enum {
  off                           = false,
  on                            = true
};


struct hubDescriptor {
                                              /* See usbDoc pg 250?? */
  UInt8               dummy;                  /* to align charcteristics */

  UInt8               length;
  UInt8               hubType;
  UInt8               numPorts;

  UInt16              characteristics;
  UInt8               powerOnToGood;          /* Port settling time, in 2ms */
  UInt8               hubCurrent;

                                              /* These are received packed, will have to be unpacked */
  UInt8               removablePortFlags[8];
  UInt8               pwrCtlPortFlags[8];
};
typedef struct hubDescriptor            hubDescriptor;



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

#endif /* __USB__ */


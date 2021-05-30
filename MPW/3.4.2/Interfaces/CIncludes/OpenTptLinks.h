/*
	File:		OpenTptLinks.h

	Contains:	Definitions for link modules

	Copyright:	© 1994-1996 by Apple Computer, Inc., all rights reserved.


*/

#ifndef __OPENTPTLINKS__
#define __OPENTPTLINKS__

#ifndef __OPENTRANSPORT__
#include <OpenTransport.h>
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

/*******************************************************************************
** Device Types for OTPortRefs
********************************************************************************/

enum
{
	kOTADEVDevice			= 1,		/* An Atalk ADEV		*/
	kOTMDEVDevice			= 2,		/* A TCP/IP MDEV		*/
	kOTLocalTalkDevice		= 3,		/* LocalTalk			*/
	kOTIRTalkDevice			= 4,		/* IRTalk				*/
	kOTTokenRingDevice		= 5,		/* Token Ring			*/
	kOTISDNDevice			= 6,		/* ISDN					*/
	kOTATMDevice			= 7,		/* ATM					*/
	kOTSMDSDevice			= 8,		/* SMDS					*/
	kOTSerialDevice			= 9,		/* Serial 				*/
	kOTEthernetDevice		= 10,		/* Ethernet				*/
	kOTSLIPDevice			= 11,		/* SLIP Pseudo-device	*/
	kOTPPPDevice			= 12,		/* PPP Pseudo-device	*/
	kOTModemDevice			= 13,		/* Modem Pseudo-Device	*/
	kOTFastEthernetDevice	= 14,		/* 100 MB Ethernet		*/
	kOTFDDIDevice			= 15,		/* FDDI					*/
	kOTIrDADevice			= 16,		/* IrDA Infrared		*/
	kOTATMSNAPDevice		= 17,		/* ATM SNAP emulation	*/
	kOTFibreChannelDevice	= 18,		/* Fibre Channel		*/
	kOTFireWireDevice		= 19		/* FireWire link Device	*/
};

/*******************************************************************************
** Interface option flags
********************************************************************************/

enum
{
	//
	// Ethernet framing options
	//
	kOTFramingEthernet		= 0x01,
	kOTFramingEthernetIPX	= 0x02,
	kOTFraming8023			= 0x04,
	kOTFraming8022			= 0x08
};
/*
 * These are obsolete and will be going away in OT1.5
 */
enum
{
	//
	// RawMode options
	//
	kOTRawRcvOn					= 0,
	kOTRawRcvOff				= 1,
	kOTRawRcvOnWithTimeStamp	= 2
};

enum
{
	//
	// OPT_SETPROMISCUOUS value
	//
	DL_PROMISC_OFF			= 0
};

/*******************************************************************************
** Module definitions
********************************************************************************/
//
// XTI Levels
//
enum
{
	LNK_ENET	= 'ENET',
	LNK_TOKN	= 'TOKN',
	LNK_FDDI	= 'FDDI',
	LNK_TPI		= 'LTPI'
};
//
// Module IDs
//
enum
{
	kT8022ModuleID		= 7100,
	kEnetModuleID		= 7101,
	kTokenRingModuleID	= 7102,
	kFDDIModuleID		= 7103
};
//
// Module Names
//
#define kEnet8022Name		"enet8022x"
#define kEnetName			"enet"
#define kFastEnetName		"fenet"
#define kTokenRingName		"tokn"
#define kFDDIName			"fddi"
#define kIRTalkName			"irtlk"
#define kSMDSName			"smds"
#define kATMName			"atm"
#define kT8022Name			"tpi8022x"
#define kATMSNAPName		"atmsnap"
#define kFireWireName		"firewire"
#define kFibreChannelName	"fibre"
//
// Address Family
//
enum
{
	AF_8022		= 8200	// Our 802.2 generic address family
};

/*******************************************************************************
** Options
********************************************************************************/

enum
{
	OPT_ADDMCAST 		= 0x1000,
	OPT_DELMCAST 		= 0x1001,
	OPT_RCVPACKETTYPE	= 0x1002,
	OPT_RCVDESTADDR		= 0x1003,
	OPT_SETRAWMODE		= 0x1004,
	OPT_SETPROMISCUOUS	= 0x1005
};

enum OTPacketType
{
	kETypeStandard=0,
	kETypeMulticast,
	kETypeBroadcast,
	kETRawPacketBit = 0x80000000,
	kETTimeStampBit = 0x40000000
};

/*******************************************************************************
** Link related constants
********************************************************************************/

enum
{
	//
	// length of an ENET hardware addressaddress
	//
	kMulticastLength			= 6,
	k48BitAddrLength			= 6,
	//
	// The protocol type is our DLSAP
	//
	k8022DLSAPLength			= 2,
	//
	k8022SNAPLength 			= 5,
	//
	// length of an address field used by the ENET enpoint
	//    = k48BitAddrLength + sizeof(protocol type)
	//
	kEnetAddressLength			= k48BitAddrLength + k8022DLSAPLength,
	//
	// Special DLSAPS for ENET
	//
	kSNAPSAP					= 0x00AA,
	kIPXSAP						= 0x00FF,
	kMax8022SAP					= 0x00FE,
	k8022GlobalSAP				= 0x00FF,
	kMinDIXSAP					= 1501,
	kMaxDIXSAP					= 0xFFFFU
};



/*******************************************************************************
** Generic Address Structure
********************************************************************************/

struct T8022Address
{
		OTAddressType	fAddrFamily;
		UInt8			fHWAddr[k48BitAddrLength];
		UInt16			fSAP;
		UInt8			fSNAP[k8022SNAPLength];
};

enum
{
		k8022BasicAddressLength = sizeof(OTAddressType) + k48BitAddrLength +
												sizeof(UInt16),
		k8022SNAPAddressLength = sizeof(OTAddressType) + k48BitAddrLength +
									sizeof(UInt16) + k8022SNAPLength
};

/*******************************************************************************
** Some helpful stuff for dealing with 48 bit addresses
********************************************************************************/

#define OTCompare48BitAddresses(p1, p2)														\
	(*(const UInt32*)((const UInt8*)(p1)) == *(const UInt32*)((const UInt8*)(p2)) &&		\
	 *(const UInt16*)(((const UInt8*)(p1))+4) == *(const UInt16*)(((const UInt8*)(p2))+4) )

#define OTCopy48BitAddress(p1, p2)												\
	(*(UInt32*)((UInt8*)(p2)) = *(const UInt32*)((const UInt8*)(p1)),			\
	 *(UInt16*)(((UInt8*)(p2))+4) = *(const UInt16*)(((const UInt8*)(p1))+4) )

#define OTClear48BitAddress(p1)													\
	(*(UInt32*)((UInt8*)(p1)) = 0,												\
	 *(UInt16*)(((UInt8*)(p1))+4) = 0 )

#define OTCompare8022SNAP(p1, p2)														\
	(*(const UInt32*)((const UInt8*)(p1)) == *(const UInt32*)((const UInt8*)(p2)) &&	\
	 *(((const UInt8*)(p1))+4) == *(((const UInt8*)(p2))+4) )

#define OTCopy8022SNAP(p1, p2)												\
	(*(UInt32*)((UInt8*)(p2)) = *(const UInt32*)((const UInt8*)(p1)),		\
	 *(((UInt8*)(p2))+4) = *(((const UInt8*)(p1))+4) )

#define OTIs48BitBroadcastAddress(p1)					\
	(*(UInt32*)((UInt8*)(p1)) == 0xffffffff &&			\
	 *(UInt16*)(((UInt8*)(p1))+4) == 0xffff )

#define OTSet48BitBroadcastAddress(p1)					\
	(*(UInt32*)((UInt8*)(p1)) = 0xffffffff,				\
	 *(UInt16*)(((UInt8*)(p1))+4) = 0xffff )

#define OTIs48BitZeroAddress(p1)				\
	(*(UInt32*)((UInt8*)(p1)) == 0 && 			\
	 *(UInt16*)(((UInt8*)(p1))+4) == 0 )

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#endif

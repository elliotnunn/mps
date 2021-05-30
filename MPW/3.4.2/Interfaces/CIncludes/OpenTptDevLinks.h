/*
	File:		OpenTptDevLinks.h

	Contains:	Link related constants and structures

	Copyright:	© 1993-1995 by Apple Computer, Inc., all rights reserved.


*/

#ifndef __OPENTPTDEVLINKS__
#define __OPENTPTDEVLINKS__

#ifndef __OPENTPTLINKS__
#include <OpenTptLinks.h>
#endif

#ifndef __OPENTPTCOMMON__
#include <OpenTptCommon.h>
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

/*******************************************************************************
** Link related constants
********************************************************************************/

enum
{
	kEnetPacketHeaderLength		= (2*k48BitAddrLength)+k8022DLSAPLength,
	//
	// The TSDU for ethernet.
	//
	kEnetTSDU					= 1514,
	//
	// The TSDU for TokenRing.
	//
	kTokenRingTSDU				= 4458,
	//
	// The TSDU for FDDI.
	//
	kFDDITSDU					= 4458, //%%% Until someone tells me different
	
	
	k8022SAPLength				= 1,
	
	//
	// define the length of the header portion of an 802.2 packet.
	//
	k8022BasicHeaderLength		= 3, // = SSAP+DSAP+ControlByte
	k8022SNAPHeaderLength		= k8022SNAPLength + k8022BasicHeaderLength
};

/*******************************************************************************
** Address Types recognized by the Enet DLPI
********************************************************************************/

enum EAddrType
{
	keaStandardAddress=0, keaMulticast, keaBroadcast, keaBadAddress,
	keaRawPacketBit = 0x80000000, keaTimeStampBit = 0x40000000
};

/*******************************************************************************
** Packet Header Structures
********************************************************************************/

struct EnetPacketHeader
{
	UInt8	fDestAddr[k48BitAddrLength];
	UInt8	fSourceAddr[k48BitAddrLength];
	UInt16	fProto;
};

typedef struct EnetPacketHeader	EnetPacketHeader;

struct T8022Header
{
	UInt8	fDSAP;
	UInt8	fSSAP;
	UInt8	fCtrl;
};

typedef struct T8022Header	T8022Header;

struct T8022SNAPHeader
{
	UInt8	fDSAP;
	UInt8	fSSAP;
	UInt8	fCtrl;
	UInt8	fSNAP[k8022SNAPLength];
};

typedef struct T8022SNAPHeader	T8022SNAPHeader;

struct T8022FullPacketHeader
{
	EnetPacketHeader	fEnetPart;
	T8022SNAPHeader		f8022Part;
};

typedef struct T8022FullPacketHeader	T8022FullPacketHeader;

/*	-------------------------------------------------------------------------
	Define the lengths of the structures above
	------------------------------------------------------------------------- */
enum
{
	kT8022HeaderLength				= 3,
	kT8022SNAPHeaderLength			= 3 + k8022SNAPLength,
	kT8022FullPacketHeaderLength	= kEnetPacketHeaderLength + kT8022SNAPHeaderLength
};

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#endif

/*
	File:		OpenTptAppleTalk.h

	Contains:	Public AppleTalk definitions

	Copyright:	© 1993-1996 by Apple Computer, Inc., all rights reserved.


*/

#ifndef __OPENTPTAPPLETALK__
#define __OPENTPTAPPLETALK__

#ifndef __OPENTRANSPORT__
#include <OpenTransport.h>
#endif
#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

/*******************************************************************************
** Some prefixes for shared libraries
********************************************************************************/

#define kATalkVersion	"1.1"
#define kATalkPrefix	"ot:atlk$"
#define kATBinderID		"ot:atbd$"

/*******************************************************************************
** Module definitions
********************************************************************************/
//
// XTI Levels
//
#define ATK_DDP			'DDP '
#define ATK_AARP		'AARP'
#define ATK_ATP			'ATP '
#define ATK_ADSP		'ADSP'
#define ATK_ASP			'ASP '
#define ATK_PAP			'PAP '
#define ATK_NBP			'NBP '
#define ATK_ZIP			'ZIP '
//
// Module Names
//
#define kDDPName		"ddp"
#define	kATPName		"atp"
#define kADSPName		"adsp"
#define	kASPName		"asp"
#define kPAPName		"pap"
#define kNBPName		"nbp"
#define kZIPName		"zip"
#define kLTalkName		"ltlk"
#define kLTalkAName		"ltlkA"
#define kLTalkBName		"ltlkB"

/*******************************************************************************
** Protocol-specific Options
**
** NOTE:
** All Protocols support OPT_CHECKSUM (Value is (unsigned long)T_YES/T_NO)
** ATP supports OPT_RETRYCNT (# Retries, 0 = try once) and
**				OPT_INTERVAL (# Milliseconds to wait)
********************************************************************************/

#define DDP_OPT_CHECKSUM	OPT_CHECKSUM,
#define DDP_OPT_SRCADDR		0x2101	/* DDP UnitDataReq Only - set src address	*/
									/* Value is DDPAddress						*/
									
#define ATP_OPT_REPLYCNT	0x2110	/* AppleTalk - ATP Resp Pkt Ct Type			*/
									/* Value is (unsigned long)  pkt count		*/
#define ATP_OPT_DATALEN		0x2111	/* AppleTalk - ATP Pkt Data Len Type		*/
									/* Value is (unsigned long) length			*/
#define ATP_OPT_RELTIMER	0x2112	/* AppleTalk - ATP Release Timer Type		*/
									/* Value is (unsigned long) timer			*/
									/* (See Inside AppleTalk, second edition	*/
#define ATP_OPT_TRANID		0x2113	/* Value is (unsigned long) Boolean			*/
									/* Used to request Transaction ID			*/
									/* Returned with Transaction ID on requests */

#define PAP_OPT_OPENRETRY	0x2120	/* AppleTalk - PAP OpenConn Retry count		*/
									/* Value is (unsigned long) T_YES/T_NO		*/

/*******************************************************************************
** Protocol-specific events
********************************************************************************/

enum
{
	kAppleTalkEvent					= kPROTOCOLEVENT | 0x10000,

	T_GETMYZONECOMPLETE				= kAppleTalkEvent+1,
	T_GETLOCALZONESCOMPLETE			= kAppleTalkEvent+2,
	T_GETZONELISTCOMPLETE			= kAppleTalkEvent+3,
	T_GETATALKINFOCOMPLETE			= kAppleTalkEvent+4,
	
	//
	// If you send the IOCTL: OTIoctl(I_OTGetMiscellaneousEvents, 1),
	// you will receive these events on your endpoint.
	// NOTE: The endpoint does not need to be bound.
	//
	// No routers have been seen for a while.  If the cookie is NULL,
	// all routers are gone.  Otherwise, there is still an ARA router
	// hanging around being used, and only the local cable has been 
	// timed out.
	//
	T_ATALKROUTERDOWNEVENT			= kAppleTalkEvent + 51,
		//
		// This indicates that all routers are offline
		//
		kAllATalkRoutersDown			= 0,
		//
		// This indicates that all local routers went offline, but
		// an ARA router is still active
		//
		kLocalATalkRoutersDown			= -1L,
		//
		// This indicates that ARA was disconnected, do it's router went offline,
		// and we have no local routers to fall back onto.
		//
		kARARouterDisconnected			= -2L,
	//
	// We didn't have a router, but now one has come up.
	// Cookie is NULL for a normal router coming up, non-NULL
	// for an ARA router coming on-line
	//
	T_ATALKROUTERUPEVENT			= kAppleTalkEvent + 52,
		//
		// We had no local routers, but an ARA router is now online.
		//
		kARARouterOnline				= -1L,
		//
		// We had no routers, but a local router is now online
		//
		kATalkRouterOnline				= 0,
		//
		// We have an ARA router, but now we've seen a local router as well
		//
		kLocalATalkRouterOnline			 = -2L,
	//
	// A Zone name change was issued from the router, so our
	// AppleTalk Zone has changed.
	//
	T_ATALKZONENAMECHANGEDEVENT		= kAppleTalkEvent + 53,
	//
	// An ARA connection was established (cookie != NULL),
	// or was disconnected (cookie == NULL)
	//
	T_ATALKCONNECTIVITYCHANGEDEVENT	= kAppleTalkEvent + 54,
	//
	// A router has appeared, and our address is in the startup
	// range.  Cookie is hi/lo of new cable range.
	//
	T_ATALKINTERNETAVAILABLEEVENT	= kAppleTalkEvent + 55,
	//
	// A router has appeared, and it's incompatible withour
	// current address.  Cookie is hi/lo of new cable range.
	//
	T_ATALKCABLERANGECHANGEDEVENT	= kAppleTalkEvent + 56
	//
	// A bad router has appeared/disappeared on our network.
	//
};

#define IsAppleTalkEvent(x)			((x) & 0xffff0000) == kAppleTalkEvent)

/*******************************************************************************
** Protocol-specific IOCTLs
********************************************************************************/
//
// Turn on/off full self-send (it's automatic for non-backward-compatible links)
//
#define ATALK_IOC_FULLSELFSEND			MIOC_CMD(MIOC_ATALK,48)
//
// ADSP Forward Reset
//
#define	ADSP_IOC_FORWARDRESET			MIOC_CMD(MIOC_ATALK,60)

/*******************************************************************************
** Protocol-specific constants
********************************************************************************/

enum
{
	/*	-------------------------------------------------------------------------
		ECHO
		------------------------------------------------------------------------- */

	kECHO_TSDU				= 585,		// Max. # of data bytes.

	/*	-------------------------------------------------------------------------
		NBP
		------------------------------------------------------------------------- */

	kNBPMaxNameLength		= 32,
	kNBPMaxTypeLength		= 32,
	kNBPMaxZoneLength		= 32,
	kNBPSlushLength			= 9,	// Extra space for @, : and a few escape chars
	kNBPMaxEntityLength		= (kNBPMaxNameLength + kNBPMaxTypeLength + kNBPMaxZoneLength + 3),
	kNBPEntityBufferSize	= (kNBPMaxNameLength + kNBPMaxTypeLength + kNBPMaxZoneLength + kNBPSlushLength),
	kNBPWildCard			= 0x3D,		// NBP name and type match anything '='
	kNBPImbeddedWildCard	= 0xC5,		// NBP name and type match some '≈'
	kNBPDefaultZone			= 0x2A,		// NBP default zone '*'

	/*	-------------------------------------------------------------------------
		ZIP
		------------------------------------------------------------------------- */
	
	kZIPMaxZoneLength		= kNBPMaxZoneLength,
	
	/*	-------------------------------------------------------------------------
		Address-related values
		------------------------------------------------------------------------- */
		
	kDDPAddressLength		= 8,		// value to use in netbuf.len field
										// Maximum length of AppleTalk address
	kNBPAddressLength		= kNBPEntityBufferSize,
	kAppleTalkAddressLength	= kDDPAddressLength + kNBPEntityBufferSize
};

#define OTCopyDDPAddress(addr, dest)				\
	{												\
		((UInt32*)(dest))[0] = ((UInt32*)(addr))[0];	\
		((UInt32*)(dest))[1] = ((UInt32*)(addr))[1];	\
	}

/*******************************************************************************
** CLASS TAppleTalkServices
********************************************************************************/

#if !OTKERNEL

#ifndef __cplusplus
	typedef void*	ATSvcRef;
#else
	class TAppleTalkServices;
	typedef TAppleTalkServices*	ATSvcRef;
#endif

#define kDefaultAppleTalkServicesPath	((OTConfiguration*)-3)

#ifdef __cplusplus
extern "C" {
#endif

extern pascal OSStatus	OTAsyncOpenAppleTalkServices(OTConfiguration* cfig, OTOpenFlags flags,
													 OTNotifyProcPtr, void* contextPtr);			
extern pascal ATSvcRef	OTOpenAppleTalkServices(OTConfiguration* cfig, OTOpenFlags flags,
												OSStatus* err);
	//
	// Get the zone associated with the ATSvcRef
	//
extern pascal OSStatus	OTATalkGetMyZone(ATSvcRef ref, TNetbuf* zone);
	//
	// Get the list of available zones associated with the local cable
	// of the ATSvcRef
	//
extern pascal OSStatus	OTATalkGetLocalZones(ATSvcRef ref, TNetbuf* zones);
	//
	// Get the list of all zones on the internet specified by the ATSvcRef
	//
extern pascal OSStatus	OTATalkGetZoneList(ATSvcRef ref, TNetbuf* zones);
	//
	// Stores an AppleTalkInfo structure into the TNetbuf (see later in this file)
	//
extern pascal OSStatus	OTATalkGetInfo(ATSvcRef ref, TNetbuf* info);

#ifdef __cplusplus
}

class TAppleTalkServices : public TProvider
{
	public:
			OSStatus	GetMyZone(TNetbuf* zone) 		{ return OTATalkGetMyZone(this, zone); }
			OSStatus	GetLocalZones(TNetbuf* zones)	{ return OTATalkGetLocalZones(this, zones); }
			OSStatus	GetZoneList(TNetbuf* zones)		{ return OTATalkGetZoneList(this, zones); }
			OSStatus	GetInfo(TNetbuf* info)			{ return OTATalkGetInfo(this, info); }
};

#endif	/* _cplus */
#endif	/* !OTKERNEL */

/*	-------------------------------------------------------------------------
	AppleTalk Addressing
	
	The NBPEntity structure is used to manipulate NBP names without regard
	to issues of what kind of "special" characters are in the name.
	
	When stored as an address in an NBPAddress or DDPNBPAddress, they are 
	stored as a character string, which is currently just ASCII, but in the
	future may be UniChar, or some other internationalizable scripting set.
	The string following an NBPAddress or DDPNBPAddress is intended to be
	suitable for showing to users, whereas NBPEntity is not.
	WARNING: NBPAddress and DDPNBPAddress structures do not "know" the length
	of the address.  That must have been obtained as part of a Lookup or
	ResolveAddress call.
	------------------------------------------------------------------------- */

	typedef struct DDPAddress		DDPAddress;
	typedef struct NBPAddress		NBPAddress;
	typedef struct DDPNBPAddress	DDPNBPAddress;
	
	struct NBPEntity
	{
		UInt8	fEntity[kNBPMaxEntityLength];
	};
	
	typedef struct NBPEntity	NBPEntity;

	/*	---------------------------------------------------------------------
		These are some utility routines for dealing with NBP and DDP addresses. 
		--------------------------------------------------------------------- */
	
	#ifdef __cplusplus
	extern "C" {
	#endif
	//
	// Functions to initialize the various AppleTalk Address types
	//
	extern pascal void		OTInitDDPAddress(DDPAddress* addr, UInt16 net, UInt8 node,
											 UInt8 socket, UInt8 ddpType);
	extern pascal size_t	OTInitNBPAddress(NBPAddress* addr, const char* name);
	extern pascal size_t	OTInitDDPNBPAddress(DDPNBPAddress* addr, const char* name,
												UInt16 net, UInt8 node, UInt8 socket,
												UInt8 ddpType);
		//
		// Compare 2 DDP addresses for equality
		//
	extern pascal Boolean	OTCompareDDPAddresses(const DDPAddress* addr1, const DDPAddress* addr2);
		//
		// Init an NBPEntity to a NULL name
		//
	extern pascal void		OTInitNBPEntity(NBPEntity* entity);
		//
		// Get the length an NBPEntity would have when stored as an address
		// 
	extern pascal size_t	OTGetNBPEntityLengthAsAddress(const NBPEntity* entity);
		//
		// Store an NBPEntity into an address buffer
		//
	extern pascal size_t	OTSetAddressFromNBPEntity(UInt8* nameBuf, const NBPEntity* entity);
		//
		// Create an address buffer from a string (use -1 for len to use strlen)
		//
	extern pascal size_t	OTSetAddressFromNBPString(UInt8* addrBuf, const char* name, SInt32 len);
		//
		// Create an NBPEntity from an address buffer. False is returned if
		//   the address was truncated.
		//
	extern pascal Boolean	OTSetNBPEntityFromAddress(NBPEntity* entity, const UInt8* addrBuf,
													  size_t len);
		//
		// Routines to set a piece of an NBP entity from a character string
		//
	extern pascal Boolean	OTSetNBPName(NBPEntity* entity, const char* name);
	extern pascal Boolean	OTSetNBPType(NBPEntity* entity, const char* typeVal);
	extern pascal Boolean	OTSetNBPZone(NBPEntity* entity, const char* zone);
		//
		// Routines to extract pieces of an NBP entity
		//
	extern pascal void		OTExtractNBPName(const NBPEntity* entity, char* name);
	extern pascal void		OTExtractNBPType(const NBPEntity* entity, char* typeVal);
	extern pascal void		OTExtractNBPZone(const NBPEntity* entity, char* zone);
												
	#ifdef __cplusplus
	}
	#endif

	enum
	{
		AF_ATALK_FAMILY	= 0x0100,
		AF_ATALK_DDP	= AF_ATALK_FAMILY,
		AF_ATALK_DDPNBP	= AF_ATALK_FAMILY + 1,
		AF_ATALK_NBP	= AF_ATALK_FAMILY + 2,
		AF_ATALK_MNODE	= AF_ATALK_FAMILY + 3
	};

struct DDPAddress
{
	OTAddressType	fAddressType;		// One of the enums above
	UInt16			fNetwork;
	UInt8			fNodeID;
	UInt8			fSocket;
	UInt8			fDDPType;
	UInt8			fPad;
#ifndef __cplusplus

};

#else

	public:
				void			Init(const DDPAddress&);
				void			Init(UInt16 net, UInt8 node, UInt8 socket);
				void			Init(UInt16 net, UInt8 node, UInt8 socket, UInt8 type);

				void			SetSocket(UInt8);
				void			SetType(UInt8);
				void			SetNode(UInt8);
				void			SetNetwork(UInt16);
			
				size_t			GetAddressLength() const;
				OTAddressType	GetAddressType() const;
				UInt8			GetSocket() const;
				UInt8			GetType() const;
				UInt8			GetNode() const;
				UInt16			GetNetwork() const;
			
				Boolean			operator==(const DDPAddress&) const;
				Boolean			operator!=(const DDPAddress&) const;
				void			operator=(const DDPAddress&);
};

/*
 *	Inline methods for DDPAddress
 */

	inline void DDPAddress::operator=(const DDPAddress& addr)
	{
		*(UInt32*)&fAddressType = *(UInt32*)&addr.fAddressType;
		*(UInt32*)&fNodeID = *(UInt32*)&addr.fNodeID;
	}
	
	inline Boolean DDPAddress::operator==(const DDPAddress& addr) const
	{
		return OTCompareDDPAddresses(&addr, this);
	}
	
	inline Boolean DDPAddress::operator!=(const DDPAddress& addr) const
	{
		return !OTCompareDDPAddresses(&addr, this);
	}
	
	inline void DDPAddress::SetSocket(UInt8 socket)
	{
		fSocket = socket;
	}
	
	inline void DDPAddress::SetNode(UInt8 node)
	{
		fNodeID = node;
	}
	
	inline void DDPAddress::SetType(UInt8 type)
	{
		fDDPType = type;
	}
	
	inline void DDPAddress::SetNetwork(UInt16 net)
	{
		fNetwork = net;
	}
	
	inline size_t DDPAddress::GetAddressLength() const
	{
		return kDDPAddressLength;
	}
	
	inline OTAddressType DDPAddress::GetAddressType() const
	{
		return fAddressType;
	}
	
	inline UInt8 DDPAddress::GetSocket() const
	{
		return fSocket;
	}
	
	inline UInt8 DDPAddress::GetNode() const
	{
		return fNodeID;
	}
	
	inline UInt8 DDPAddress::GetType() const
	{
		return fDDPType;
	}
	
	inline UInt16 DDPAddress::GetNetwork() const
	{
		return fNetwork;
	}
	
	inline void  DDPAddress::Init(UInt16 net, UInt8 node,
								  UInt8 socket)
	{
		fAddressType = AF_ATALK_DDP;
		SetNetwork(net);
		SetNode(node);
		SetSocket(socket);
		SetType(0);
	}
	
	inline void  DDPAddress::Init(UInt16 net, UInt8 node,
								  UInt8 socket, UInt8 type)
	{
		fAddressType = AF_ATALK_DDP;
		SetNetwork(net);
		SetNode(node);
		SetSocket(socket);
		SetType(type);
	}
	
	inline void DDPAddress::Init(const DDPAddress& addr)
	{
		*(UInt32*)&fAddressType = *(UInt32*)&addr.fAddressType;
		*(UInt32*)&fNodeID = *(UInt32*)&addr.fNodeID;
	}
	
#endif	/* __cplusplus */


struct NBPAddress
{
	OTAddressType	fAddressType;		// One of the enums above
	UInt8			fNBPNameBuffer[kNBPEntityBufferSize];
#ifndef __cplusplus

};

#else

	public:
				size_t			Init();
				size_t			Init(const NBPEntity&);
				size_t			Init(const char*);
				size_t			Init(const char*, size_t len);
				Boolean			ExtractEntity(NBPEntity&, size_t len);
			
				OTAddressType	GetAddressType() const;
};

/*
 *	Inline methods for NBPAddress
 */

	inline size_t NBPAddress::Init()
	{
		fAddressType = AF_ATALK_NBP;
		return sizeof(OTAddressType);
	}
	
	inline size_t NBPAddress::Init(const NBPEntity& addr)
	{
		fAddressType = AF_ATALK_NBP;
		return sizeof(OTAddressType) + OTSetAddressFromNBPEntity(fNBPNameBuffer, &addr);
	}
	
	inline size_t NBPAddress::Init(const char* name)
	{
		fAddressType = AF_ATALK_NBP;
		return sizeof(OTAddressType) + OTSetAddressFromNBPString(fNBPNameBuffer, name, -1);
	}
	
	inline size_t NBPAddress::Init(const char* name, size_t len)
	{
		fAddressType = AF_ATALK_NBP;
		return sizeof(OTAddressType) + OTSetAddressFromNBPString(fNBPNameBuffer, name, (SInt32)len);
	}
	
	inline Boolean NBPAddress::ExtractEntity(NBPEntity& entity, size_t len)
	{
		return OTSetNBPEntityFromAddress(&entity, fNBPNameBuffer, len);
	}
		
	inline OTAddressType NBPAddress::GetAddressType() const
	{
		return fAddressType;
	}
	
#endif	/* __cplusplus */

struct DDPNBPAddress
{
	OTAddressType	fAddressType;		// One of the enums above
	UInt16			fNetwork;
	UInt8			fNodeID;
	UInt8			fSocket;
	UInt8			fDDPType;
	UInt8			fPad;
	UInt8			fNBPNameBuffer[kNBPEntityBufferSize];

#ifndef __cplusplus

};

#else

	public:
				void			Init(const DDPAddress&);
				void			Init(UInt16 net, UInt8 node, UInt8 socket);
				void			Init(UInt16 net, UInt8 node, UInt8 socket, UInt8 type);

				void			SetSocket(UInt8);
				void			SetType(UInt8);
				void			SetNode(UInt8);
				void			SetNetwork(UInt16);
				
				OTAddressType	GetAddressType() const;
				UInt8			GetSocket() const;
				UInt8			GetType() const;
				UInt8			GetNode() const;
				UInt16			GetNetwork() const;
				
				Boolean			ExtractEntity(NBPEntity&, size_t len);
				size_t			SetNBPEntity(const NBPEntity&);
				size_t			SetNBPEntity(const char*);
				size_t			SetNBPEntity(const char*, size_t len);
				
				Boolean			operator==(const DDPAddress&) const;
};

/*
 *	Inline methods for DDPNBPAddress
 */
	inline Boolean DDPNBPAddress::operator==(const DDPAddress& addr) const
	{
		return OTCompareDDPAddresses((const DDPAddress*)this, &addr);
	}
	
	inline void DDPNBPAddress::SetSocket(UInt8 socket)
	{
		fSocket = socket;
	}
	
	inline void DDPNBPAddress::SetNode(UInt8 node)
	{
		fNodeID = node;
	}
	
	inline void DDPNBPAddress::SetType(UInt8 type)
	{
		fDDPType = type;
	}
	
	inline void DDPNBPAddress::SetNetwork(UInt16 net)
	{
		fNetwork = net;
	}
	
	inline OTAddressType DDPNBPAddress::GetAddressType() const
	{
		return fAddressType;
	}
	
	inline UInt8 DDPNBPAddress::GetSocket() const
	{
		return fSocket;
	}
	
	inline UInt8 DDPNBPAddress::GetNode() const
	{
		return fNodeID;
	}
	
	inline UInt8 DDPNBPAddress::GetType() const
	{
		return fDDPType;
	}
	
	inline UInt16 DDPNBPAddress::GetNetwork() const
	{
		return fNetwork;
	}
	
	inline void DDPNBPAddress::Init(UInt16 net, UInt8 node,
									UInt8 socket)
	{
		fAddressType = AF_ATALK_DDPNBP;
		SetNetwork(net);
		SetNode(node);
		SetSocket(socket);
		SetType(0);
	}
	
	inline void DDPNBPAddress::Init(UInt16 net, UInt8 node,
									UInt8 socket, UInt8 type)
	{
		fAddressType = AF_ATALK_DDPNBP;
		SetNetwork(net);
		SetNode(node);
		SetSocket(socket);
		SetType(type);
	}
	
	inline void DDPNBPAddress::Init(const DDPAddress& addr)
	{
		fAddressType = AF_ATALK_DDPNBP;
		SetNetwork(addr.GetNetwork());
		SetNode(addr.GetNode());
		SetSocket(addr.GetSocket());
		SetType(addr.GetType());
		fNBPNameBuffer[0] = 0;
	}
	
	inline size_t DDPNBPAddress::SetNBPEntity(const NBPEntity& entity)
	{
		return OTSetAddressFromNBPEntity(fNBPNameBuffer, &entity) + kDDPAddressLength;
	}
	
	inline size_t DDPNBPAddress::SetNBPEntity(const char* name)
	{
		return OTSetAddressFromNBPString(fNBPNameBuffer, name, -1) + kDDPAddressLength;
	}
	
	inline size_t DDPNBPAddress::SetNBPEntity(const char* name, size_t len)
	{
		return OTSetAddressFromNBPString(fNBPNameBuffer, name, (SInt32)len) + kDDPAddressLength;
	}
	
	inline Boolean DDPNBPAddress::ExtractEntity(NBPEntity& entity, size_t len)
	{
		return OTSetNBPEntityFromAddress(&entity, fNBPNameBuffer, len);
	}

#endif	/* __cplusplus */

/*	-------------------------------------------------------------------------
		AppleTalkInfo - filled out by the OTGetATalkInfo function
	------------------------------------------------------------------------- */

struct AppleTalkInfo
{
	DDPAddress	fOurAddress;		// Our DDP address (network # & node)
	DDPAddress	fRouterAddress;		// The address of a router on our cable
	UInt16		fCableRange[2];		// The current cable range
	UInt16		fFlags;				// See below
};

//
// For the fFlags field in AppleTalkInfo
//
enum
{
	kATalkInfoIsExtended	= 0x0001,	// This is an extended (phase 2) network
	kATalkInfoHasRouter		= 0x0002,	// This cable has a router
	kATalkInfoOneZone		= 0x0004	// This cable has only one zone
};

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#endif	/*  __OPENTPTAPPLETALK__ */

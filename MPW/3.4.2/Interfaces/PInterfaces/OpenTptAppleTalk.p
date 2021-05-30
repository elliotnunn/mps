{
 	File:		OpenTptAppleTalk.p
 
 	Contains:	Public AppleTalk definitions
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
 				All rights reserved.
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OpenTptAppleTalk;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTPTAPPLETALK__}
{$SETC __OPENTPTAPPLETALK__ := 1}

{$I+}
{$SETC OpenTptAppleTalkIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORT__}
{$I OpenTransport.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
******************************************************************************
** Module definitions
*******************************************************************************
}
{  XTI Levels }

CONST
	ATK_DDP						= 'DDP ';
	ATK_AARP					= 'AARP';
	ATK_ATP						= 'ATP ';
	ATK_ADSP					= 'ADSP';
	ATK_ASP						= 'ASP ';
	ATK_PAP						= 'PAP ';
	ATK_NBP						= 'NBP ';
	ATK_ZIP						= 'ZIP ';

{  Module Names }

	kDDPName		= 'ddp';
	kATPName		= 'atp';
	kADSPName		= 'adsp';
	kASPName		= 'asp';
	kPAPName		= 'pap';
	kNBPName		= 'nbp';
	kZIPName		= 'zip';
	kLTalkName		= 'ltlk';
	kLTalkAName		= 'ltlkA';
	kLTalkBName		= 'ltlkB';

{
******************************************************************************
** Protocol-specific Options
**
** NOTE:
** All Protocols support OPT_CHECKSUM (Value is (unsigned long)T_YES/T_NO)
** ATP supports OPT_RETRYCNT (# Retries, 0 = try once) and
**				OPT_INTERVAL (# Milliseconds to wait)
*******************************************************************************
}
	DDP_OPT_CHECKSUM			= $0600;						{  DDP UnitDataReq Only - set src address	 }
	DDP_OPT_SRCADDR				= $2101;						{  Value is DDPAddress						 }
																{  AppleTalk - ATP Resp Pkt Ct Type			 }
	ATP_OPT_REPLYCNT			= $2110;						{  Value is (unsigned long)  pkt count		 }
																{  AppleTalk - ATP Pkt Data Len Type		 }
	ATP_OPT_DATALEN				= $2111;						{  Value is (unsigned long) length			 }
																{  AppleTalk - ATP Release Timer Type		 }
																{  Value is (unsigned long) timer			 }
	ATP_OPT_RELTIMER			= $2112;						{  (See Inside AppleTalk, second edition	 }
	ATP_OPT_TRANID				= $2113;						{  Value is (unsigned long) Boolean			 }
																{  AppleTalk - PAP OpenConn Retry count		 }
	PAP_OPT_OPENRETRY			= $2120;						{  Value is (unsigned long) T_YES/T_NO		 }

{
******************************************************************************
** Protocol-specific events
*******************************************************************************
}
	kAppleTalkEvent				= $23010000;

{
 * If you send the IOCTL: OTIoctl(I_OTGetMiscellaneousEvents, 1),
 * you will receive these events on your endpoint.
 * NOTE: The endpoint does not need to be bound.
 *
 * No routers have been seen for a while.  If the cookie is NULL,
 * all routers are gone.  Otherwise, there is still an ARA router
 * hanging around being used, and only the local cable has been 
 * timed out.
}
	T_ATALKROUTERDOWNEVENT		= $23010033;
	kAllATalkRoutersDown		= 0;
	kLocalATalkRoutersDown		= -1;
	kARARouterDisconnected		= -2;
	T_ATALKROUTERUPEVENT		= $23010034;
	kARARouterOnline			= -1;
	kATalkRouterOnline			= 0;
	kLocalATalkRouterOnline		= -2;
	T_ATALKZONENAMECHANGEDEVENT	= $23010035;
	T_ATALKCONNECTIVITYCHANGEDEVENT = $23010036;
	T_ATALKINTERNETAVAILABLEEVENT = $23010037;
	T_ATALKCABLERANGECHANGEDEVENT = $23010038;

{
******************************************************************************
** Protocol-specific IOCTLs
*******************************************************************************
}

	ATALK_IOC_FULLSELFSEND		= $5430;
	ADSP_IOC_FORWARDRESET		= $543C;
{
******************************************************************************
** Protocol-specific constants
*******************************************************************************
}
{
	-------------------------------------------------------------------------
		ECHO
		------------------------------------------------------------------------- 
}
	kECHO_TSDU					= 585;							{  Max. # of data bytes. }

{
	-------------------------------------------------------------------------
		NBP
		------------------------------------------------------------------------- 
}
	kNBPMaxNameLength			= 32;
	kNBPMaxTypeLength			= 32;
	kNBPMaxZoneLength			= 32;
	kNBPSlushLength				= 9;							{  Extra space for @, : and a few escape chars }
	kNBPMaxEntityLength			= 99;
	kNBPEntityBufferSize		= 105;
	kNBPWildCard				= $3D;							{  NBP name and type match anything '=' }
	kNBPImbeddedWildCard		= $C5;							{  NBP name and type match some '≈' }
	kNBPDefaultZone				= $2A;							{  NBP default zone '*' }

{
	-------------------------------------------------------------------------
		ZIP
		------------------------------------------------------------------------- 
}
	kZIPMaxZoneLength			= 32;

{
	-------------------------------------------------------------------------
		Address-related values
		------------------------------------------------------------------------- 
}
	kDDPAddressLength			= 8;							{  value to use in netbuf.len field }
																{  Maximum length of AppleTalk address }
	kNBPAddressLength			= 105;
	kAppleTalkAddressLength		= 113;

{
******************************************************************************
** CLASS TAppleTalkServices
*******************************************************************************
}
{$IFC NOT OTKERNEL }
{$IFC UNDEFINED __cplusplus }

TYPE
	ATSvcRef							= Ptr;
{$ELSEC}

TYPE
	TAppleTalkServicesPtr = ^TAppleTalkServices;
	TAppleTalkServices = RECORD
	END;

	ATSvcRef							= ^TAppleTalkServices;
{$ENDC}

CONST
	kDefaultAppleTalkServicesPath = -3;

FUNCTION OTAsyncOpenAppleTalkServices(VAR cfig: OTConfiguration; flags: OTOpenFlags; notifyProc: OTNotifyProcPtr; contextPtr: UNIV Ptr): OSStatus;
FUNCTION OTOpenAppleTalkServices(VAR cfig: OTConfiguration; flags: OTOpenFlags; VAR err: OSStatus): ATSvcRef;
{  Get the zone associated with the ATSvcRef }
FUNCTION OTATalkGetMyZone(ref: ATSvcRef; VAR zone: TNetbuf): OSStatus;
{
 Get the list of available zones associated with the local cable
 of the ATSvcRef
}
FUNCTION OTATalkGetLocalZones(ref: ATSvcRef; VAR zones: TNetbuf): OSStatus;
{  Get the list of all zones on the internet specified by the ATSvcRef }
FUNCTION OTATalkGetZoneList(ref: ATSvcRef; VAR zones: TNetbuf): OSStatus;
{  Stores an AppleTalkInfo structure into the TNetbuf (see later in this file) }
FUNCTION OTATalkGetInfo(ref: ATSvcRef; VAR info: TNetbuf): OSStatus;
{$ENDC}
{
	-------------------------------------------------------------------------
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
	------------------------------------------------------------------------- 
}

TYPE
	DDPAddressPtr = ^DDPAddress;
	DDPAddress = RECORD
		fAddressType:			OTAddressType;
		fNetwork:				UInt16;
		fNodeID:				SInt8;
		fSocket:				SInt8;
		fDDPType:				SInt8;
		fPad:					SInt8;
	END;

	NBPAddressPtr = ^NBPAddress;
	NBPAddress = RECORD
		fAddressType:			OTAddressType;
		fNBPNameBuffer:			PACKED ARRAY [0..104] OF UInt8;
	END;

	DDPNBPAddressPtr = ^DDPNBPAddress;
	DDPNBPAddress = RECORD
		fAddressType:			OTAddressType;
		fNetwork:				UInt16;
		fNodeID:				SInt8;
		fSocket:				SInt8;
		fDDPType:				SInt8;
		fPad:					SInt8;
		fNBPNameBuffer:			PACKED ARRAY [0..104] OF UInt8;
	END;

	NBPEntityPtr = ^NBPEntity;
	NBPEntity = RECORD
		fEntity:				PACKED ARRAY [0..98] OF UInt8;
	END;

{
	---------------------------------------------------------------------
		These are some utility routines for dealing with NBP and DDP addresses. 
		--------------------------------------------------------------------- 
}
{  Functions to initialize the various AppleTalk Address types }
PROCEDURE OTInitDDPAddress(VAR addr: DDPAddress; net: UInt16; node: ByteParameter; socket: ByteParameter; ddpType: ByteParameter);
FUNCTION OTInitNBPAddress(VAR addr: NBPAddress; name: ConstCStringPtr): size_t;
FUNCTION OTInitDDPNBPAddress(VAR addr: DDPNBPAddress; name: ConstCStringPtr; net: UInt16; node: ByteParameter; socket: ByteParameter; ddpType: ByteParameter): size_t;
{  Compare 2 DDP addresses for equality }
FUNCTION OTCompareDDPAddresses({CONST}VAR addr1: DDPAddress; {CONST}VAR addr2: DDPAddress): BOOLEAN;
{  Init an NBPEntity to a NULL name }
PROCEDURE OTInitNBPEntity(VAR entity: NBPEntity);
{
 Get the length an NBPEntity would have when stored as an address
 
}
FUNCTION OTGetNBPEntityLengthAsAddress({CONST}VAR entity: NBPEntity): size_t;
{  Store an NBPEntity into an address buffer }
FUNCTION OTSetAddressFromNBPEntity(VAR nameBuf: UInt8; {CONST}VAR entity: NBPEntity): size_t;
{  Create an address buffer from a string (use -1 for len to use strlen) }
FUNCTION OTSetAddressFromNBPString(VAR addrBuf: UInt8; name: ConstCStringPtr; len: SInt32): size_t;
{
 Create an NBPEntity from an address buffer. False is returned if
   the address was truncated.
}
FUNCTION OTSetNBPEntityFromAddress(VAR entity: NBPEntity; {CONST}VAR addrBuf: UInt8; len: size_t): BOOLEAN;
{  Routines to set a piece of an NBP entity from a character string }
FUNCTION OTSetNBPName(VAR entity: NBPEntity; name: ConstCStringPtr): BOOLEAN;
FUNCTION OTSetNBPType(VAR entity: NBPEntity; typeVal: ConstCStringPtr): BOOLEAN;
FUNCTION OTSetNBPZone(VAR entity: NBPEntity; zone: ConstCStringPtr): BOOLEAN;
{  Routines to extract pieces of an NBP entity }
PROCEDURE OTExtractNBPName({CONST}VAR entity: NBPEntity; name: CStringPtr);
PROCEDURE OTExtractNBPType({CONST}VAR entity: NBPEntity; typeVal: CStringPtr);
PROCEDURE OTExtractNBPZone({CONST}VAR entity: NBPEntity; zone: CStringPtr);

CONST
	AF_ATALK_FAMILY				= $0100;
	AF_ATALK_DDP				= $0100;
	AF_ATALK_DDPNBP				= $0101;
	AF_ATALK_NBP				= $0102;
	AF_ATALK_MNODE				= $0103;

{
	-------------------------------------------------------------------------
		AppleTalkInfo - filled out by the OTGetATalkInfo function
	------------------------------------------------------------------------- 
}

TYPE
	AppleTalkInfoPtr = ^AppleTalkInfo;
	AppleTalkInfo = RECORD
		fOurAddress:			DDPAddress;								{  Our DDP address (network # & node) }
		fRouterAddress:			DDPAddress;								{  The address of a router on our cable }
		fCableRange:			ARRAY [0..1] OF UInt16;					{  The current cable range }
		fFlags:					UInt16;									{  See below }
	END;

{  For the fFlags field in AppleTalkInfo }

CONST
	kATalkInfoIsExtended		= $0001;						{  This is an extended (phase 2) network }
	kATalkInfoHasRouter			= $0002;						{  This cable has a router }
	kATalkInfoOneZone			= $0004;						{  This cable has only one zone }

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OpenTptAppleTalkIncludes}

{$ENDC} {__OPENTPTAPPLETALK__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

{
     File:       OpenTransportProviders.p
 
     Contains:   This file contains provider-specific definitions for various built-in providers.
 
     Version:    Technology: 2.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1993-2001 by Apple Computer, Inc. and Mentat Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OpenTransportProviders;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTRANSPORTPROVIDERS__}
{$SETC __OPENTRANSPORTPROVIDERS__ := 1}

{$I+}
{$SETC OpenTransportProvidersIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __OPENTRANSPORT__}
{$I OpenTransport.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$ifc not undefined __MWERKS and TARGET_CPU_68K}
    {$pragmac d0_pointers on}
{$endc}


{  ***** TCP/IP ***** }

{  Basic types }


TYPE
	InetPort							= UInt16;
	InetHost							= UInt32;
	{   Enums used as address type designations. }

CONST
	AF_INET						= 2;							{  Traditonal }

	AF_DNS						= 42;


	{
	    Enum which can be used to bind to all IP interfaces
	    rather than a specific one.
	}

	kOTAnyInetAddress			= 0;							{  Wildcard }

	{
	   Define the InetSvcRef type.  This type needs special
	   processing because in C++ it's a subclass of TProvider.
	   See the definition of TEndpointRef in "OpenTransport.h"
	   for the logic behind this definition.
	}


TYPE
	InetSvcRef    = ^LONGINT; { an opaque 32-bit type }
	InetSvcRefPtr = ^InetSvcRef;  { when a VAR xx:InetSvcRef parameter can be nil, it is changed to xx: InetSvcRefPtr }

CONST
	kDefaultInternetServicesPath = -3;

	{  Shared library prefixes }

	{  Module Names }

	{  XTI Options }

	{  Protocol levels }

	INET_IP						= $00;
	INET_TCP					= $06;
	INET_UDP					= $11;

	{  TCP Level Options }

	TCP_NODELAY					= $01;
	TCP_MAXSEG					= $02;
	TCP_NOTIFY_THRESHOLD		= $10;							{ * not a real XTI option  }
	TCP_ABORT_THRESHOLD			= $11;							{ * not a real XTI option  }
	TCP_CONN_NOTIFY_THRESHOLD	= $12;							{ * not a real XTI option  }
	TCP_CONN_ABORT_THRESHOLD	= $13;							{ * not a real XTI option  }
	TCP_OOBINLINE				= $14;							{ * not a real XTI option  }
	TCP_URGENT_PTR_TYPE			= $15;							{ * not a real XTI option  }
	TCP_KEEPALIVE				= $0008;						{  keepalive defined in OpenTransport.h  }

	T_GARBAGE					= 2;

	{  UDP Level Options }

	UDP_CHECKSUM				= $0600;
	UDP_RX_ICMP					= $02;

	{  IP Level Options }
	kIP_OPTIONS					= $01;
	kIP_TOS						= $02;
	kIP_TTL						= $03;
	kIP_REUSEADDR				= $04;
	kIP_DONTROUTE				= $10;
	kIP_BROADCAST				= $20;
	kIP_REUSEPORT				= $0200;
	kIP_HDRINCL					= $1002;
	kIP_RCVOPTS					= $1005;
	kIP_RCVDSTADDR				= $1007;
	kIP_MULTICAST_IF			= $1010;						{  set/get IP multicast interface  }
	kIP_MULTICAST_TTL			= $1011;						{  set/get IP multicast timetolive     }
	kIP_MULTICAST_LOOP			= $1012;						{  set/get IP multicast loopback   }
	kIP_ADD_MEMBERSHIP			= $1013;						{  add an IP group membership      }
	kIP_DROP_MEMBERSHIP			= $1014;						{  drop an IP group membership        }
	kIP_BROADCAST_IFNAME		= $1015;						{  Set interface for broadcasts    }
	kIP_RCVIFADDR				= $1016;						{  Set interface for broadcasts    }

	IP_OPTIONS					= $01;
	IP_TOS						= $02;
	IP_TTL						= $03;
	IP_REUSEADDR				= $04;
	IP_DONTROUTE				= $10;
	IP_BROADCAST				= $20;
	IP_REUSEPORT				= $0200;
	IP_HDRINCL					= $1002;
	IP_RCVOPTS					= $1005;
	IP_RCVDSTADDR				= $1007;
	IP_MULTICAST_IF				= $1010;						{  set/get IP multicast interface  }
	IP_MULTICAST_TTL			= $1011;						{  set/get IP multicast timetolive     }
	IP_MULTICAST_LOOP			= $1012;						{  set/get IP multicast loopback   }
	IP_ADD_MEMBERSHIP			= $1013;						{  add an IP group membership      }
	IP_DROP_MEMBERSHIP			= $1014;						{  drop an IP group membership        }
	IP_BROADCAST_IFNAME			= $1015;						{  Set interface for broadcasts    }
	IP_RCVIFADDR				= $1016;						{  Set interface for broadcasts    }

	DVMRP_INIT					= 100;							{  DVMRP-specific setsockopt commands, from ip_mroute.h }
	DVMRP_DONE					= 101;
	DVMRP_ADD_VIF				= 102;
	DVMRP_DEL_VIF				= 103;
	DVMRP_ADD_LGRP				= 104;
	DVMRP_DEL_LGRP				= 105;
	DVMRP_ADD_MRT				= 106;
	DVMRP_DEL_MRT				= 107;


	{  IP_TOS precdence levels }

	T_ROUTINE					= 0;
	T_PRIORITY					= 1;
	T_IMMEDIATE					= 2;
	T_FLASH						= 3;
	T_OVERRIDEFLASH				= 4;
	T_CRITIC_ECP				= 5;
	T_INETCONTROL				= 6;
	T_NETCONTROL				= 7;

	{   IP_TOS type of service }

	T_NOTOS						= $00;
	T_LDELAY					= $10;
	T_HITHRPT					= $08;
	T_HIREL						= $04;

	{  IP Multicast option structures }


TYPE
	TIPAddMulticastPtr = ^TIPAddMulticast;
	TIPAddMulticast = RECORD
		multicastGroupAddress:	InetHost;
		interfaceAddress:		InetHost;
	END;

	{  Protocol-specific events }

CONST
	T_DNRSTRINGTOADDRCOMPLETE	= $10000001;
	T_DNRADDRTONAMECOMPLETE		= $10000002;
	T_DNRSYSINFOCOMPLETE		= $10000003;
	T_DNRMAILEXCHANGECOMPLETE	= $10000004;
	T_DNRQUERYCOMPLETE			= $10000005;

	{  InetAddress }


TYPE
	InetAddressPtr = ^InetAddress;
	InetAddress = RECORD
		fAddressType:			OTAddressType;							{  always AF_INET }
		fPort:					InetPort;								{  Port number  }
		fHost:					InetHost;								{  Host address in net byte order }
		fUnused:				PACKED ARRAY [0..7] OF UInt8;			{  Traditional unused bytes }
	END;

	{  Domain Name Resolver (DNR)  }

CONST
	kMaxHostAddrs				= 10;
	kMaxSysStringLen			= 32;
	kMaxHostNameLen				= 255;


TYPE
	InetDomainName						= PACKED ARRAY [0..255] OF CHAR;
	InetHostInfoPtr = ^InetHostInfo;
	InetHostInfo = RECORD
		name:					InetDomainName;
		addrs:					ARRAY [0..9] OF InetHost;
	END;

	InetSysInfoPtr = ^InetSysInfo;
	InetSysInfo = RECORD
		cpuType:				PACKED ARRAY [0..31] OF CHAR;
		osType:					PACKED ARRAY [0..31] OF CHAR;
	END;

	InetMailExchangePtr = ^InetMailExchange;
	InetMailExchange = RECORD
		preference:				UInt16;
		exchange:				InetDomainName;
	END;

	DNSQueryInfoPtr = ^DNSQueryInfo;
	DNSQueryInfo = RECORD
		qType:					UInt16;
		qClass:					UInt16;
		ttl:					UInt32;
		name:					InetDomainName;
		responseType:			UInt16;									{  answer, authority, or additional }
		resourceLen:			UInt16;									{  actual length of array which follows }
		resourceData:			PACKED ARRAY [0..3] OF CHAR;			{  size varies }
	END;

	{  DNSAddress }
	{
	   The DNSAddress format is optional and may be used in connects,
	   datagram sends, and resolve address calls.   The name takes the 
	   format "somewhere.com" or "somewhere.com:portnumber" where
	   the ":portnumber" is optional.   The length of this structure
	   is arbitrarily limited to the overall max length of a domain
	   name (255 chars), although a longer one can be use successfully
	   if you use this as a template for doing so.   However, the domain name 
	   is still limited to 255 characters.
	}

	DNSAddressPtr = ^DNSAddress;
	DNSAddress = RECORD
		fAddressType:			OTAddressType;							{  always AF_DNS }
		fName:					InetDomainName;
	END;

	{  InetInterfaceInfo }

CONST
	kDefaultInetInterface		= -1;

	kInetInterfaceInfoVersion	= 3;


TYPE
	InetInterfaceInfoPtr = ^InetInterfaceInfo;
	InetInterfaceInfo = RECORD
		fAddress:				InetHost;
		fNetmask:				InetHost;
		fBroadcastAddr:			InetHost;
		fDefaultGatewayAddr:	InetHost;
		fDNSAddr:				InetHost;
		fVersion:				UInt16;
		fHWAddrLen:				UInt16;
		fHWAddr:				Ptr;
		fIfMTU:					UInt32;
		fReservedPtrs:			ARRAY [0..1] OF Ptr;
		fDomainName:			InetDomainName;
		fIPSecondaryCount:		UInt32;
		fReserved:				PACKED ARRAY [0..251] OF UInt8;
	END;

	{  InetDHCPOption }

CONST
	kAllDHCPOptions				= -1;
	kDHCPLongOption				= 126;
	kDHCPLongOptionReq			= 127;


TYPE
	InetDHCPOptionPtr = ^InetDHCPOption;
	InetDHCPOption = RECORD
		fOptionTag:				SInt8;
		fOptionLen:				SInt8;
		fOptionValue:			SInt8;
	END;

	{  TCP/IP Utility Routines }

	{
	 *  OTInitInetAddress()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE OTInitInetAddress(VAR addr: InetAddress; port: InetPort; host: InetHost);

{
 *  OTInitDNSAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTInitDNSAddress(VAR addr: DNSAddress; str: CStringPtr): OTByteCount;

{
 *  OTInetStringToHost()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTInetStringToHost(str: ConstCStringPtr; VAR host: InetHost): OSStatus;

{
 *  OTInetHostToString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE OTInetHostToString(host: InetHost; str: CStringPtr);

{
 *  OTInetGetInterfaceInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTInetGetInterfaceInfo(VAR info: InetInterfaceInfo; val: SInt32): OSStatus;

{
 *  OTInetGetSecondaryAddresses()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTInetGetSecondaryAddresses(VAR addr: InetHost; VAR count: UInt32; val: SInt32): OSStatus;

{$IFC CALL_NOT_IN_CARBON }
{
 *  OTInetGetDHCPConfigInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTInetGetDHCPConfigInfo(VAR buf: InetDHCPOption; bufSize: UInt32; index: SInt32; opt: SInt32): OSStatus;

{  InetServices & DNR Calls }

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC NOT OTKERNEL }
{
   Under Carbon, OTOpenInternetServices routines take a client context pointer.  Applications may pass NULL
   after calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
   valid client context.
}
{
 *  OTOpenInternetServicesInContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTOpenInternetServicesInContext(cfig: OTConfigurationRef; oflag: OTOpenFlags; VAR err: OSStatus; clientContext: OTClientContextPtr): InetSvcRef;

{
 *  OTAsyncOpenInternetServicesInContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTAsyncOpenInternetServicesInContext(cfig: OTConfigurationRef; oflag: OTOpenFlags; upp: OTNotifyUPP; contextPtr: UNIV Ptr; clientContext: OTClientContextPtr): OSStatus;

{$IFC CALL_NOT_IN_CARBON }
{
 *  OTOpenInternetServices()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTOpenInternetServices(cfig: OTConfigurationRef; oflag: OTOpenFlags; VAR err: OSStatus): InetSvcRef;

{
 *  OTAsyncOpenInternetServices()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTAsyncOpenInternetServices(cfig: OTConfigurationRef; oflag: OTOpenFlags; proc: OTNotifyUPP; contextPtr: UNIV Ptr): OSStatus;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC OTCARBONAPPLICATION }
{  The following macro may be used by applications only. }
{$ENDC}  {OTCARBONAPPLICATION}
{
 *  OTInetStringToAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTInetStringToAddress(ref: InetSvcRef; name: CStringPtr; VAR hinfo: InetHostInfo): OSStatus;

{
 *  OTInetAddressToName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTInetAddressToName(ref: InetSvcRef; addr: InetHost; VAR name: InetDomainName): OSStatus;

{
 *  OTInetSysInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTInetSysInfo(ref: InetSvcRef; name: CStringPtr; VAR sysinfo: InetSysInfo): OSStatus;

{
 *  OTInetMailExchange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTInetMailExchange(ref: InetSvcRef; name: CStringPtr; VAR num: UInt16; VAR mx: InetMailExchange): OSStatus;

{
 *  OTInetQuery()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTInetQuery(ref: InetSvcRef; name: CStringPtr; qClass: UInt16; qType: UInt16; buf: CStringPtr; buflen: OTByteCount; VAR argv: UNIV Ptr; argvlen: OTByteCount; flags: OTFlags): OSStatus;

{$ENDC}

{  ***** AppleTalk ***** }
{  Shared library prefixes }

{******************************************************************************
** Module definitions
*******************************************************************************}
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

	{
	   Protocol-specific Options
	   NOTE:
	   All Protocols support OPT_CHECKSUM (Value is (unsigned long)T_YES/T_NO)
	   ATP supports OPT_RETRYCNT (# Retries, 0 = try once) and
	                OPT_INTERVAL (# Milliseconds to wait)
	}

	DDP_OPT_CHECKSUM			= $0600;
	DDP_OPT_SRCADDR				= $2101;						{  DDP UnitDataReq Only - set src address, Value is DDPAddress  }
	ATP_OPT_REPLYCNT			= $2110;						{  AppleTalk - ATP Resp Pkt Ct Type, Value is (unsigned long)  pkt count  }
	ATP_OPT_DATALEN				= $2111;						{  AppleTalk - ATP Pkt Data Len Type, Value is (unsigned long) length  }
	ATP_OPT_RELTIMER			= $2112;						{  AppleTalk - ATP Release Timer Type, Value is (unsigned long) timer, (See Inside AppleTalk, second edition  }
	ATP_OPT_TRANID				= $2113;						{  Value is (unsigned long) Boolean, Used to request Transaction ID, Returned with Transaction ID on requests  }
	PAP_OPT_OPENRETRY			= $2120;						{  AppleTalk - PAP OpenConn Retry count, Value is (unsigned long) T_YES/T_NO  }

	{  Protocol-Specific Events }

	{
	   If you send the IOCTL: OTIoctl(I_OTGetMiscellaneousEvents, 1),
	   you will receive the T_ATALKxxx events on your endpoint.
	   NOTE: The endpoint does not need to be bound.
	}

	kAppleTalkEvent				= $23010000;
	T_GETMYZONECOMPLETE			= $23010001;
	T_GETLOCALZONESCOMPLETE		= $23010002;
	T_GETZONELISTCOMPLETE		= $23010003;
	T_GETATALKINFOCOMPLETE		= $23010004;
	T_ATALKROUTERDOWNEVENT		= $23010033;					{  No routers have been seen for a while.  If the cookie is NULL, all routers are gone.  Otherwise, there is still an ARA router hanging around being used, and only the local cable has been  timed out. }
	T_ATALKROUTERUPEVENT		= $23010034;					{  We didn't have a router, but now one has come up. Cookie is NULL for a normal router coming up, non-NULL for an ARA router coming on-line }
	T_ATALKZONENAMECHANGEDEVENT	= $23010035;					{  A Zone name change was issued from the router, so our AppleTalk Zone has changed. }
	T_ATALKCONNECTIVITYCHANGEDEVENT = $23010036;				{  An ARA connection was established (cookie != NULL), or was disconnected (cookie == NULL) }
	T_ATALKINTERNETAVAILABLEEVENT = $23010037;					{  A router has appeared, and our address is in the startup range.  Cookie is hi/lo of new cable range. }
	T_ATALKCABLERANGECHANGEDEVENT = $23010038;					{  A router has appeared, and it's incompatible with our current address.  Cookie is hi/lo of new cable range. }

	kAllATalkRoutersDown		= 0;							{  This indicates that all routers are offline }
	kLocalATalkRoutersDown		= -1;							{  This indicates that all local routers went offline, but an ARA router is still active }
	kARARouterDisconnected		= -2;							{  This indicates that ARA was disconnected, do it's router went offline, and we have no local routers to fall back onto. }

	kARARouterOnline			= -1;							{  We had no local routers, but an ARA router is now online. }
	kATalkRouterOnline			= 0;							{  We had no routers, but a local router is now online }
	kLocalATalkRouterOnline		= -2;							{  We have an ARA router, but now we've seen a local router as well }

	{  Protocol-specific IOCTLs }

	ATALK_IOC_FULLSELFSEND		= $542F;						{  Turn on/off full self-send (it's automatic for non-backward-compatible links) }
	ADSP_IOC_FORWARDRESET		= $543C;						{  ADSP Forward Reset }

	{  Protocol-specific constants }

	{  ECHO }

	kECHO_TSDU					= 585;							{  Max. # of data bytes. }

	{  NBP }

	kNBPMaxNameLength			= 32;
	kNBPMaxTypeLength			= 32;
	kNBPMaxZoneLength			= 32;
	kNBPSlushLength				= 9;							{  Extra space for @, : and a few escape chars }
	kNBPMaxEntityLength			= 99;
	kNBPEntityBufferSize		= 105;
	kNBPWildCard				= $3D;							{  NBP name and type match anything '=' }
	kNBPImbeddedWildCard		= $C5;							{  NBP name and type match some '≈' }
	kNBPDefaultZone				= $2A;							{  NBP default zone '*' }

	{  ZIP }

	kZIPMaxZoneLength			= 32;

	kDDPAddressLength			= 8;							{  value to use in netbuf.len field, Maximum length of AppleTalk address }
	kNBPAddressLength			= 105;
	kAppleTalkAddressLength		= 113;

	{	******************************************************************************
	** CLASS TAppleTalkServices
	*******************************************************************************	}
{$IFC NOT OTKERNEL }
	{
	   Define the ATSvcRef type.  This type needs special
	   processing because in C++ it's a subclass of TProvider.
	   See the definition of TEndpointRef in "OpenTransport.h"
	   for the logic behind this definition.
	}

TYPE
	ATSvcRef    = ^LONGINT; { an opaque 32-bit type }
	ATSvcRefPtr = ^ATSvcRef;  { when a VAR xx:ATSvcRef parameter can be nil, it is changed to xx: ATSvcRefPtr }

CONST
	kDefaultAppleTalkServicesPath = -3;

	{
	   Under Carbon, OpenAppleTalkServices routines take a client context pointer.  Applications may pass NULL
	   after calling InitOpenTransport(kInitOTForApplicationMask, ...).  Non-applications must always pass a
	   valid client context.
	}
	{
	 *  OTAsyncOpenAppleTalkServicesInContext()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION OTAsyncOpenAppleTalkServicesInContext(cfig: OTConfigurationRef; flags: OTOpenFlags; proc: OTNotifyUPP; contextPtr: UNIV Ptr; clientContext: OTClientContextPtr): OSStatus;

{
 *  OTOpenAppleTalkServicesInContext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTOpenAppleTalkServicesInContext(cfig: OTConfigurationRef; flags: OTOpenFlags; VAR err: OSStatus; clientContext: OTClientContextPtr): ATSvcRef;

{$IFC CALL_NOT_IN_CARBON }
{
 *  OTAsyncOpenAppleTalkServices()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTAsyncOpenAppleTalkServices(cfig: OTConfigurationRef; flags: OTOpenFlags; proc: OTNotifyUPP; contextPtr: UNIV Ptr): OSStatus;

{
 *  OTOpenAppleTalkServices()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OTOpenAppleTalkServices(cfig: OTConfigurationRef; flags: OTOpenFlags; VAR err: OSStatus): ATSvcRef;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$IFC OTCARBONAPPLICATION }
{  The following macro may be used by applications only. }
{$ENDC}  {OTCARBONAPPLICATION}
{  Get the zone associated with the ATSvcRef }
{
 *  OTATalkGetMyZone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTATalkGetMyZone(ref: ATSvcRef; VAR zone: TNetbuf): OSStatus;

{
   Get the list of available zones associated with the local cable
   of the ATSvcRef
}
{
 *  OTATalkGetLocalZones()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTATalkGetLocalZones(ref: ATSvcRef; VAR zones: TNetbuf): OSStatus;

{  Get the list of all zones on the internet specified by the ATSvcRef }
{
 *  OTATalkGetZoneList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTATalkGetZoneList(ref: ATSvcRef; VAR zones: TNetbuf): OSStatus;

{  Stores an AppleTalkInfo structure into the TNetbuf (see later in this file) }
{
 *  OTATalkGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTATalkGetInfo(ref: ATSvcRef; VAR info: TNetbuf): OSStatus;

{$ENDC}

{  AppleTalk Addressing }
{
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
}


CONST
	AF_ATALK_FAMILY				= $0100;
	AF_ATALK_DDP				= $0100;
	AF_ATALK_DDPNBP				= $0101;
	AF_ATALK_NBP				= $0102;
	AF_ATALK_MNODE				= $0103;


TYPE
	NBPEntityPtr = ^NBPEntity;
	NBPEntity = RECORD
		fEntity:				PACKED ARRAY [0..98] OF UInt8;
	END;

	DDPAddressPtr = ^DDPAddress;
	DDPAddress = RECORD
		fAddressType:			OTAddressType;							{  One of the enums above }
		fNetwork:				UInt16;
		fNodeID:				SInt8;
		fSocket:				SInt8;
		fDDPType:				SInt8;
		fPad:					SInt8;
	END;

	NBPAddressPtr = ^NBPAddress;
	NBPAddress = RECORD
		fAddressType:			OTAddressType;							{  One of the enums above }
		fNBPNameBuffer:			PACKED ARRAY [0..104] OF UInt8;
	END;

	DDPNBPAddressPtr = ^DDPNBPAddress;
	DDPNBPAddress = RECORD
		fAddressType:			OTAddressType;							{  One of the enums above }
		fNetwork:				UInt16;
		fNodeID:				SInt8;
		fSocket:				SInt8;
		fDDPType:				SInt8;
		fPad:					SInt8;
		fNBPNameBuffer:			PACKED ARRAY [0..104] OF UInt8;
	END;

	{  These are some utility routines for dealing with NBP and DDP addresses.  }

	{  Functions to initialize the various AppleTalk Address types }
	{
	 *  OTInitDDPAddress()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE OTInitDDPAddress(VAR addr: DDPAddress; net: UInt16; node: ByteParameter; socket: ByteParameter; ddpType: ByteParameter);

{
 *  OTInitNBPAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTInitNBPAddress(VAR addr: NBPAddress; name: ConstCStringPtr): OTByteCount;

{
 *  OTInitDDPNBPAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTInitDDPNBPAddress(VAR addr: DDPNBPAddress; name: ConstCStringPtr; net: UInt16; node: ByteParameter; socket: ByteParameter; ddpType: ByteParameter): OTByteCount;

{  Compare 2 DDP addresses for equality }
{
 *  OTCompareDDPAddresses()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTCompareDDPAddresses({CONST}VAR addr1: DDPAddress; {CONST}VAR addr2: DDPAddress): BOOLEAN;

{  Init an NBPEntity to a NULL name }
{
 *  OTInitNBPEntity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE OTInitNBPEntity(VAR entity: NBPEntity);

{  Get the length an NBPEntity would have when stored as an address }
{
 *  OTGetNBPEntityLengthAsAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTGetNBPEntityLengthAsAddress({CONST}VAR entity: NBPEntity): OTByteCount;

{  Store an NBPEntity into an address buffer }
{
 *  OTSetAddressFromNBPEntity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTSetAddressFromNBPEntity(VAR nameBuf: UInt8; {CONST}VAR entity: NBPEntity): OTByteCount;

{  Create an address buffer from a string (use -1 for len to use strlen) }
{
 *  OTSetAddressFromNBPString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTSetAddressFromNBPString(VAR addrBuf: UInt8; name: ConstCStringPtr; len: SInt32): OTByteCount;

{
   Create an NBPEntity from an address buffer. False is returned if
     the address was truncated.
}
{
 *  OTSetNBPEntityFromAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTSetNBPEntityFromAddress(VAR entity: NBPEntity; {CONST}VAR addrBuf: UInt8; len: OTByteCount): BOOLEAN;

{  Routines to set a piece of an NBP entity from a character string }
{
 *  OTSetNBPName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTSetNBPName(VAR entity: NBPEntity; name: ConstCStringPtr): BOOLEAN;

{
 *  OTSetNBPType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTSetNBPType(VAR entity: NBPEntity; typeVal: ConstCStringPtr): BOOLEAN;

{
 *  OTSetNBPZone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OTSetNBPZone(VAR entity: NBPEntity; zone: ConstCStringPtr): BOOLEAN;

{  Routines to extract pieces of an NBP entity }
{
 *  OTExtractNBPName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE OTExtractNBPName({CONST}VAR entity: NBPEntity; name: CStringPtr);

{
 *  OTExtractNBPType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE OTExtractNBPType({CONST}VAR entity: NBPEntity; typeVal: CStringPtr);

{
 *  OTExtractNBPZone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE OTExtractNBPZone({CONST}VAR entity: NBPEntity; zone: CStringPtr);

{  AppleTalkInfo as used by the OTGetATalkInfo function }


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

	{  ***** Ethernet ***** }

	{  Interface option flags }

	{  Ethernet framing options }

	kOTFramingEthernet			= $01;
	kOTFramingEthernetIPX		= $02;
	kOTFraming8023				= $04;
	kOTFraming8022				= $08;

	{
	   These are obsolete and will be going away in OT 1.5.
	   Hmmm, OT 1.5 got cancelled.  The status of these options
	   is uncertain.
	}

	{  RawMode options }

	kOTRawRcvOn					= 0;
	kOTRawRcvOff				= 1;
	kOTRawRcvOnWithTimeStamp	= 2;

	DL_PROMISC_OFF				= 0;							{  OPT_SETPROMISCUOUS value }

	{  Module definitions }

	{  Module IDs }

	kT8022ModuleID				= 7100;
	kEnetModuleID				= 7101;
	kTokenRingModuleID			= 7102;
	kFDDIModuleID				= 7103;

	{  Module Names }

	{  Address Family }

	AF_8022						= 8200;							{  Our 802.2 generic address family }

	{  XTI Levels }

	LNK_ENET					= 'ENET';
	LNK_TOKN					= 'TOKN';
	LNK_FDDI					= 'FDDI';
	LNK_TPI						= 'LTPI';

	{  Options }

	OPT_ADDMCAST				= $1000;
	OPT_DELMCAST				= $1001;
	OPT_RCVPACKETTYPE			= $1002;
	OPT_RCVDESTADDR				= $1003;
	OPT_SETRAWMODE				= $1004;
	OPT_SETPROMISCUOUS			= $1005;


TYPE
	OTPacketType 				= UInt32;
CONST
	kETypeStandard				= 0;
	kETypeMulticast				= 1;
	kETypeBroadcast				= 2;
	kETRawPacketBit				= $80000000;
	kETTimeStampBit				= $40000000;

	{  Link related constants }

	kMulticastLength			= 6;							{  length of an ENET hardware addressaddress }
	k48BitAddrLength			= 6;
	k8022DLSAPLength			= 2;							{  The protocol type is our DLSAP }
	k8022SNAPLength				= 5;
	kEnetAddressLength			= 8;							{  length of an address field used by the ENET enpoint }
																{     = k48BitAddrLength + sizeof(protocol type) }
	kSNAPSAP					= $00AA;						{  Special DLSAPS for ENET }
	kIPXSAP						= $00FF;
	kMax8022SAP					= $00FE;
	k8022GlobalSAP				= $00FF;
	kMinDIXSAP					= 1501;
	kMaxDIXSAP					= $FFFF;

	{  Generic Address Structure }


TYPE
	T8022AddressPtr = ^T8022Address;
	T8022Address = RECORD
		fAddrFamily:			OTAddressType;
		fHWAddr:				PACKED ARRAY [0..5] OF UInt8;
		fSAP:					UInt16;
		fSNAP:					PACKED ARRAY [0..4] OF UInt8;
	END;


CONST
	k8022BasicAddressLength		= 10;
	k8022SNAPAddressLength		= 15;

	{  Some helpful stuff for dealing with 48 bit addresses }

	{  Link related constants }

	kEnetPacketHeaderLength		= 14;
	kEnetTSDU					= 1514;							{  The TSDU for ethernet. }
	kTokenRingTSDU				= 4458;							{  The TSDU for TokenRing. }
	kFDDITSDU					= 4458;							{  The TSDU for FDDI.  }
	k8022SAPLength				= 1;
	k8022BasicHeaderLength		= 3;							{  define the length of the header portion of an 802.2 packet. }
																{  = SSAP+DSAP+ControlByte }
	k8022SNAPHeaderLength		= 8;

	{	******************************************************************************
	** Address Types recognized by the Enet DLPI
	*******************************************************************************	}

TYPE
	EAddrType 					= UInt32;
CONST
	keaStandardAddress			= 0;
	keaMulticast				= 1;
	keaBroadcast				= 2;
	keaBadAddress				= 3;
	keaRawPacketBit				= $80000000;
	keaTimeStampBit				= $40000000;

	{  Packet Header Structures }


TYPE
	EnetPacketHeaderPtr = ^EnetPacketHeader;
	EnetPacketHeader = RECORD
		fDestAddr:				PACKED ARRAY [0..5] OF UInt8;
		fSourceAddr:			PACKED ARRAY [0..5] OF UInt8;
		fProto:					UInt16;
	END;

	T8022HeaderPtr = ^T8022Header;
	T8022Header = RECORD
		fDSAP:					SInt8;
		fSSAP:					SInt8;
		fCtrl:					SInt8;
	END;

	T8022SNAPHeaderPtr = ^T8022SNAPHeader;
	T8022SNAPHeader = RECORD
		fDSAP:					SInt8;
		fSSAP:					SInt8;
		fCtrl:					SInt8;
		fSNAP:					PACKED ARRAY [0..4] OF UInt8;
	END;

	T8022FullPacketHeaderPtr = ^T8022FullPacketHeader;
	T8022FullPacketHeader = RECORD
		fEnetPart:				EnetPacketHeader;
		f8022Part:				T8022SNAPHeader;
	END;

	{  Define the lengths of the structures above }

CONST
	kT8022HeaderLength			= 3;
	kT8022SNAPHeaderLength		= 8;
	kT8022FullPacketHeaderLength = 22;

	{  ***** Serial ***** }

	{  Module Definitions }

	{  XTI Level }

	COM_SERIAL					= 'SERL';

	{  Version Number }

	{  Module Names }

	kSerialABModuleID			= 7200;

	kOTSerialFramingAsync		= $01;							{  Support Async serial mode          }
	kOTSerialFramingHDLC		= $02;							{  Support HDLC synchronous serial mode    }
	kOTSerialFramingSDLC		= $04;							{  Support SDLC synchronous serial mode    }
	kOTSerialFramingAsyncPackets = $08;							{  Support Async "packet" serial mode  }
	kOTSerialFramingPPP			= $10;							{  Port does its own PPP framing - wants unframed packets from PPP  }

	{  IOCTL Calls for Serial Drivers }

	I_SetSerialDTR				= $5500;						{  Set DTR (0 = off, 1 = on) }
	kOTSerialSetDTROff			= 0;
	kOTSerialSetDTROn			= 1;
	I_SetSerialBreak			= $5501;						{  Send a break on the line - kOTSerialSetBreakOff = off, kOTSerialSetBreakOn = on, }
																{  Any other number is the number of milliseconds to leave break on, then }
																{  auto shutoff }
	kOTSerialSetBreakOn			= $FFFFFFFF;
	kOTSerialSetBreakOff		= 0;
	I_SetSerialXOffState		= $5502;						{  Force XOFF state - 0 = Unconditionally clear XOFF state, 1 = unconditionally set it }
	kOTSerialForceXOffTrue		= 1;
	kOTSerialForceXOffFalse		= 0;
	I_SetSerialXOn				= $5503;						{  Send an XON character, 0 = send only if in XOFF state, 1 = send always }
	kOTSerialSendXOnAlways		= 1;
	kOTSerialSendXOnIfXOffTrue	= 0;
	I_SetSerialXOff				= $5504;						{  Send an XOFF character, 0 = send only if in XON state, 1 = send always }
	kOTSerialSendXOffAlways		= 1;
	kOTSerialSendXOffIfXOnTrue	= 0;

	{  Option Management for Serial Drivers }

	{
	   These options are all 4-byte values.
	   BaudRate is the baud rate.
	   DataBits is the number of data bits.
	   StopBits is the number of stop bits times 10.
	   Parity is an enum
	}

	SERIAL_OPT_BAUDRATE			= $0100;						{  UInt32  }
	SERIAL_OPT_DATABITS			= $0101;						{  UInt32  }
	SERIAL_OPT_STOPBITS			= $0102;						{  UInt32 10, 15 or 20 for 1, 1.5 or 2     }
	SERIAL_OPT_PARITY			= $0103;						{  UInt32  }
	SERIAL_OPT_STATUS			= $0104;						{  UInt32  }
																{  The "Status" option is a 4-byte value option that is ReadOnly }
																{  It returns a bitmap of the current serial status }
	SERIAL_OPT_HANDSHAKE		= $0105;						{  UInt32  }
																{  The "Handshake" option defines what kind of handshaking the serial port }
																{  will do for line flow control.  The value is a 32-bit value defined by }
																{  the function or macro SerialHandshakeData below. }
																{  For no handshake, or CTS handshake, the onChar and offChar parameters }
																{  are ignored. }
	SERIAL_OPT_RCVTIMEOUT		= $0106;						{  The "RcvTimeout" option defines how long the receiver should wait before delivering }
																{  less than the RcvLoWat number of characters.  If RcvLoWat is 0, then the RcvTimeout }
																{  is how long a gap to wait for before delivering characters.  This parameter is advisory, }
																{  and serial drivers are free to deliver data whenever they deem it convenient.  For instance, }
																{  many serial drivers will deliver data whenever 64 bytes have been received, since 64 bytes }
																{  is the smallest STREAMS buffer size. Keep in mind that timeouts are quantized, so be sure to }
																{  look at the return value of the option to determine what it was negotiated to. }
	SERIAL_OPT_ERRORCHARACTER	= $0107;						{  This option defines how characters with parity errors are handled. }
																{  A 0 value will disable all replacement.  A single character value in the low }
																{  byte designates the replacement character.  When characters are received with a  }
																{  parity error, they are replaced by this specified character.  If a valid incoming }
																{  character matches the replacement character, then the received character's msb is }
																{  cleared. For this situation, the alternate character is used, if specified in bits }
																{  8 through 15 of the option long, with 0xff being place in bits 16 through 23. }
																{  Whenever a valid character is received that matches the first replacement character, }
																{  it is replaced with this alternate character. }
	SERIAL_OPT_EXTCLOCK			= $0108;						{  The "ExtClock" requests an external clock.  A 0-value turns off external clocking. }
																{  Any other value is a requested divisor for the external clock.  Be aware that }
																{  not all serial implementations support an external clock, and that not all }
																{  requested divisors will be supported if it does support an external clock. }
	SERIAL_OPT_BURSTMODE		= $0109;						{  The "BurstMode" option informs the serial driver that it should continue looping, }
																{  reading incoming characters, rather than waiting for an interrupt for each character. }
																{  This option may not be supported by all Serial driver }
	SERIAL_OPT_DUMMY			= $010A;						{  placeholder }


TYPE
	ParityOptionValues 			= UInt32;
CONST
	kOTSerialNoParity			= 0;
	kOTSerialOddParity			= 1;
	kOTSerialEvenParity			= 2;

	kOTSerialSwOverRunErr		= $01;
	kOTSerialBreakOn			= $08;
	kOTSerialParityErr			= $10;
	kOTSerialOverrunErr			= $20;
	kOTSerialFramingErr			= $40;
	kOTSerialXOffSent			= $00010000;
	kOTSerialDTRNegated			= $00020000;
	kOTSerialCTLHold			= $00040000;
	kOTSerialXOffHold			= $00080000;
	kOTSerialOutputBreakOn		= $01000000;

	kOTSerialXOnOffInputHandshake = 1;							{  Want XOn/XOff handshake for incoming characters     }
	kOTSerialXOnOffOutputHandshake = 2;							{  Want XOn/XOff handshake for outgoing characters     }
	kOTSerialCTSInputHandshake	= 4;							{  Want CTS handshake for incoming characters      }
	kOTSerialDTROutputHandshake	= 8;							{  Want DTR handshake for outoing characters    }

	{  Default attributes for the serial ports }

	kOTSerialDefaultBaudRate	= 19200;
	kOTSerialDefaultDataBits	= 8;
	kOTSerialDefaultStopBits	= 10;
	kOTSerialDefaultParity		= 0;
	kOTSerialDefaultHandshake	= 0;
	kOTSerialDefaultOnChar		= 17;
	kOTSerialDefaultOffChar		= 19;
	kOTSerialDefaultSndBufSize	= 1024;
	kOTSerialDefaultRcvBufSize	= 1024;
	kOTSerialDefaultSndLoWat	= 96;
	kOTSerialDefaultRcvLoWat	= 1;
	kOTSerialDefaultRcvTimeout	= 10;

	{  ***** ISDN ***** }

	{  Module Definitions }

	{  XTI Level }

	COM_ISDN					= 'ISDN';

	{  Module Names }

	kISDNModuleID				= 7300;


	{  ISDN framing methods, set using the I_OTSetFramingType IOCTL }

	kOTISDNFramingTransparentSupported = $0010;					{  Support Transparent mode     }
	kOTISDNFramingHDLCSupported	= $0020;						{  Support HDLC Synchronous mode   }
	kOTISDNFramingV110Supported	= $0040;						{  Support V.110 Asynchronous mode     }
	kOTISDNFramingV14ESupported	= $0080;						{  Support V.14 Asynchronous mode      }

	{  Miscellaneous equates }

	{  Disconnect reason codes (from Q.931) }

	kOTISDNUnallocatedNumber	= 1;
	kOTISDNNoRouteToSpecifiedTransitNetwork = 2;
	kOTISDNNoRouteToDestination	= 3;
	kOTISDNChannelUnacceptable	= 6;
	kOTISDNNormal				= 16;
	kOTISDNUserBusy				= 17;
	kOTISDNNoUserResponding		= 18;
	kOTISDNNoAnswerFromUser		= 19;
	kOTISDNCallRejected			= 21;
	kOTISDNNumberChanged		= 22;
	kOTISDNNonSelectedUserClearing = 26;
	kOTISDNDestinationOutOfOrder = 27;
	kOTISDNInvalidNumberFormat	= 28;
	kOTISDNFacilityRejected		= 29;
	kOTISDNNormalUnspecified	= 31;
	kOTISDNNoCircuitChannelAvailable = 34;
	kOTISDNNetworkOutOfOrder	= 41;
	kOTISDNSwitchingEquipmentCongestion = 42;
	kOTISDNAccessInformationDiscarded = 43;
	kOTISDNRequestedCircuitChannelNotAvailable = 44;
	kOTISDNResourceUnavailableUnspecified = 45;
	kOTISDNQualityOfServiceUnvailable = 49;
	kOTISDNRequestedFacilityNotSubscribed = 50;
	kOTISDNBearerCapabilityNotAuthorized = 57;
	kOTISDNBearerCapabilityNotPresentlyAvailable = 58;
	kOTISDNCallRestricted		= 59;
	kOTISDNServiceOrOptionNotAvilableUnspecified = 63;
	kOTISDNBearerCapabilityNotImplemented = 65;
	kOTISDNRequestedFacilityNotImplemented = 69;
	kOTISDNOnlyRestrictedDigitalBearer = 70;
	kOTISDNServiceOrOptionNotImplementedUnspecified = 79;
	kOTISDNCallIdentityNotUsed	= 83;
	kOTISDNCallIdentityInUse	= 84;
	kOTISDNNoCallSuspended		= 85;
	kOTISDNCallIdentityCleared	= 86;
	kOTISDNIncompatibleDestination = 88;
	kOTISDNInvalidTransitNetworkSelection = 91;
	kOTISDNInvalidMessageUnspecified = 95;
	kOTISDNMandatoryInformationElementIsMissing = 96;
	kOTISDNMessageTypeNonExistentOrNotImplemented = 97;
	kOTISDNInterworkingUnspecified = 127;

	{  OTISDNAddress }

	{
	   The OTISDNAddress has the following format:
	   "xxxxxx*yy"
	   where 'x' is the phone number and 'y' is the sub address (if available
	   in the network. The characters are coded in ASCII (IA5), and valid
	   characters are: '0'-'9','#','*'.
	   The max length of the each phone number is 21 characters (?) and the max
	   subaddress length is network dependent.
	   When using bonded channels the phone numbers are separated by '&'.
	   The X.25 user data is preceded by '@'.
	}

	kAF_ISDN					= $2000;

	AF_ISDN						= $2000;

	kOTISDNMaxPhoneSize			= 32;
	kOTISDNMaxSubSize			= 4;


TYPE
	OTISDNAddressPtr = ^OTISDNAddress;
	OTISDNAddress = RECORD
		fAddressType:			OTAddressType;
		fPhoneLength:			UInt16;
		fPhoneNumber:			PACKED ARRAY [0..36] OF CHAR;
	END;

	{  IOCTL Calls for ISDN }
	{  ISDN shares the same ioctl space as serial. }


CONST
	MIOC_ISDN					= 85;							{  ISDN ioctl() cmds  }

	I_OTISDNAlerting			= $5564;						{  Send or receive an ALERTING message }
	I_OTISDNSuspend				= $5565;						{  Send a SUSPEND message }
																{  The parameter is the Call Identity (Maximum 8 octets) }
	I_OTISDNSuspendAcknowledge	= $5566;						{  Receive a SUSPEND ACKNOWLEDGE message }
	I_OTISDNSuspendReject		= $5567;						{  Receive a SUSPEND REJECT message }
	I_OTISDNResume				= $5568;						{  Send a RESUME message }
																{  The parameter is the Call Identity (Maximum 8 octets) }
	I_OTISDNResumeAcknowledge	= $5569;						{  Receive a RESUME ACKNOWLEDGE message }
	I_OTISDNResumeReject		= $556A;						{  Receive a RESUME REJECT message }
	I_OTISDNFaciltity			= $556B;						{  Send or receive a FACILITY message }

	{  Connect user data size }

	kOTISDNMaxUserDataSize		= 32;

	{  Option management calls for ISDN }

	ISDN_OPT_COMMTYPE			= $0200;
	ISDN_OPT_FRAMINGTYPE		= $0201;
	ISDN_OPT_56KADAPTATION		= $0202;

	{  For ISDN_OPT_COMMTYPE... }

	kOTISDNTelephoneALaw		= 1;							{  G.711 A-law                 }
	kOTISDNTelephoneMuLaw		= 26;							{  G.711 µ-law                 }
	kOTISDNDigital64k			= 13;							{  unrestricted digital (default)      }
	kOTISDNDigital56k			= 37;							{  user rate 56Kb/s            }
	kOTISDNVideo64k				= 41;							{  video terminal at 64Kb/s     }
	kOTISDNVideo56k				= 42;							{  video terminal at 56Kb/s     }

	{  For ISDN_OPT_FRAMINGTYPE... }

	kOTISDNFramingTransparent	= $0010;						{  Transparent mode            }
	kOTISDNFramingHDLC			= $0020;						{  HDLC synchronous mode (default)     }
	kOTISDNFramingV110			= $0040;						{  V.110 asynchronous mode        }
	kOTISDNFramingV14E			= $0080;						{  V.14E asynchronous mode          }

	{  For ISDN_OPT_56KADAPTATION... }

	kOTISDNNot56KAdaptation		= false;						{  not 56K Adaptation (default)      }
	kOTISDN56KAdaptation		= true;							{  56K Adaptation            }

	{  Default options, you do not need to set these }

	kOTISDNDefaultCommType		= 13;
	kOTISDNDefaultFramingType	= $0020;
	kOTISDNDefault56KAdaptation	= 0;


	{	******************************************************************************
	*   Constants for Open Transport-based Remote Access/PPP API
	*******************************************************************************	}

	{  OTCreateConfiguration name for PPP control endpoint }


	{  XTI Level }

	COM_PPP						= 'PPPC';

	{  Options limits }

	kPPPMaxIDLength				= 255;
	kPPPMaxPasswordLength		= 255;
	kPPPMaxDTEAddressLength		= 127;
	kPPPMaxCallInfoLength		= 255;


	{  Various XTI option value constants }

	kPPPStateInitial			= 1;
	kPPPStateClosed				= 2;
	kPPPStateClosing			= 3;
	kPPPStateOpening			= 4;
	kPPPStateOpened				= 5;

	kPPPConnectionStatusIdle	= 1;
	kPPPConnectionStatusConnecting = 2;
	kPPPConnectionStatusConnected = 3;
	kPPPConnectionStatusDisconnecting = 4;

	kPPPMinMRU					= 0;
	kPPPMaxMRU					= 4500;

	kIPCPTCPHdrCompressionDisabled = 0;
	kIPCPTCPHdrCompressionEnabled = 1;

	kPPPCompressionDisabled		= $00000000;
	kPPPProtoCompression		= $00000001;
	kPPPAddrCompression			= $00000002;

	kPPPNoOutAuthentication		= 0;
	kPPPCHAPOrPAPOutAuthentication = 1;

	kCCReminderTimerDisabled	= 0;
	kCCIPIdleTimerDisabled		= 0;

	kPPPScriptTypeModem			= 1;
	kPPPScriptTypeConnect		= 2;
	kPPPMaxScriptSize			= 32000;

	kE164Address				= 1;
	kPhoneAddress				= 1;
	kCompoundPhoneAddress		= 2;
	kX121Address				= 3;

	kPPPConnectionStatusDialogsFlag = $00000001;
	kPPPConnectionRemindersFlag	= $00000002;
	kPPPConnectionFlashingIconFlag = $00000004;
	kPPPOutPasswordDialogsFlag	= $00000008;
	kPPPAllAlertsDisabledFlag	= $00000000;
	kPPPAllAlertsEnabledFlag	= $0000000F;

	kPPPAsyncMapCharsNone		= $00000000;
	kPPPAsyncMapCharsXOnXOff	= $000A0000;
	kPPPAsyncMapCharsAll		= $FFFFFFFF;


	{  Option names }

	IPCP_OPT_GETREMOTEPROTOADDR	= $00007000;
	IPCP_OPT_GETLOCALPROTOADDR	= $00007001;
	IPCP_OPT_TCPHDRCOMPRESSION	= $00007002;
	LCP_OPT_PPPCOMPRESSION		= $00007003;
	LCP_OPT_MRU					= $00007004;
	LCP_OPT_RCACCMAP			= $00007005;
	LCP_OPT_TXACCMAP			= $00007006;
	SEC_OPT_OUTAUTHENTICATION	= $00007007;
	SEC_OPT_ID					= $00007008;
	SEC_OPT_PASSWORD			= $00007009;
	CC_OPT_REMINDERTIMER		= $00007010;
	CC_OPT_IPIDLETIMER			= $00007011;
	CC_OPT_DTEADDRESSTYPE		= $00007012;
	CC_OPT_DTEADDRESS			= $00007013;
	CC_OPT_CALLINFO				= $00007014;
	CC_OPT_GETMISCINFO			= $00007015;
	PPP_OPT_GETCURRENTSTATE		= $00007016;
	LCP_OPT_ECHO				= $00007017;					{  Available on Mac OS X only  }
	CC_OPT_SERIALPORTNAME		= $00007200;

	{  Endpoint events }

	kPPPEvent					= $230F0000;
	kPPPConnectCompleteEvent	= $230F0001;
	kPPPSetScriptCompleteEvent	= $230F0002;
	kPPPDisconnectCompleteEvent	= $230F0003;
	kPPPDisconnectEvent			= $230F0004;
	kPPPIPCPUpEvent				= $230F0005;
	kPPPIPCPDownEvent			= $230F0006;
	kPPPLCPUpEvent				= $230F0007;
	kPPPLCPDownEvent			= $230F0008;
	kPPPLowerLayerUpEvent		= $230F0009;
	kPPPLowerLayerDownEvent		= $230F000A;
	kPPPAuthenticationStartedEvent = $230F000B;
	kPPPAuthenticationFinishedEvent = $230F000C;
	kPPPDCEInitStartedEvent		= $230F000D;
	kPPPDCEInitFinishedEvent	= $230F000E;
	kPPPDCECallStartedEvent		= $230F000F;
	kPPPDCECallFinishedEvent	= $230F0010;


	{	******************************************************************************
	*   IOCTL constants for I_OTConnect, I_OTDisconnect and I_OTScript
	*   are defined in OpenTransport.h
	*******************************************************************************	}

	{	******************************************************************************
	*   PPPMRULimits
	*******************************************************************************	}

TYPE
	PPPMRULimitsPtr = ^PPPMRULimits;
	PPPMRULimits = RECORD
		mruSize:				UInt32;									{  proposed or actual }
		upperMRULimit:			UInt32;
		lowerMRULimit:			UInt32;
	END;


	{	******************************************************************************
	*   CCMiscInfo
	*******************************************************************************	}
	CCMiscInfoPtr = ^CCMiscInfo;
	CCMiscInfo = RECORD
		connectionStatus:		UInt32;
		connectionTimeElapsed:	UInt32;
		connectionTimeRemaining: UInt32;
		bytesTransmitted:		UInt32;
		bytesReceived:			UInt32;
		reserved:				UInt32;
	END;


	{	******************************************************************************
	*   LCPEcho
	*******************************************************************************	}
	{  Set both fields to zero to disable sending of LCP echo requests }

	LCPEchoPtr = ^LCPEcho;
	LCPEcho = RECORD
		retryCount:				UInt32;
		retryPeriod:			UInt32;									{  in milliseconds }
	END;


	{	******************************************************************************
	*   Bits used to tell kind of product
	*******************************************************************************	}

CONST
	kRAProductClientOnly		= 2;
	kRAProductOnePortServer		= 3;
	kRAProductManyPortServer	= 4;


{$ifc not undefined __MWERKS and TARGET_CPU_68K}
    {$pragmac d0_pointers reset}
{$endc}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OpenTransportProvidersIncludes}

{$ENDC} {__OPENTRANSPORTPROVIDERS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

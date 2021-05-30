/*
	File:		OpenTptInternet.h

	Contains:	Client TCP/IP definitions

	Copyright:	© 1993-1996 by Apple Computer, Inc., all rights reserved.


*/


#ifndef __OPENTPTINTERNET__
#define __OPENTPTINTERNET__

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
** Misc 
********************************************************************************/

typedef UInt16	InetPort;
typedef UInt32	InetHost;

//
//	Enums used as address type designations.
//
enum
{
	AF_INET				= 2,	// Traditonal
	AF_DNS				= 42	// Obviously, the answer to...
};

//
//	Enum which can be used to bind to all IP interfaces
//	rather than a specific one.
//
enum
{
	kOTAnyInetAddress	= 0		// Wildcard
};

#ifdef __cplusplus
	class	TInternetServices;
	typedef TInternetServices*	InetSvcRef;
#else
	typedef void*	InetSvcRef;
#endif

/*******************************************************************************
** Some prefixes for shared libraries
********************************************************************************/

#define kInetVersion	"3.1.1"
#define kInetPrefix		"ot:inet$"

/*******************************************************************************
** Module Names
********************************************************************************/
#define kDNRName		"dnr"
#define kTCPName		"tcp"
#define kUDPName		"udp"
#define kRawIPName		"rawip"

/*******************************************************************************
** XTI Options
********************************************************************************/

// Protocol levels

#define	INET_IP		 0x0
#define	INET_TCP	 0x06
#define	INET_UDP	 0x11


// TCP Level Options

#define	TCP_NODELAY		 			0x01
#define	TCP_MAXSEG		 			0x02
#define TCP_NOTIFY_THRESHOLD		0x10	/** not a real XTI option */
#define TCP_ABORT_THRESHOLD			0x11	/** not a real XTI option */
#define TCP_CONN_NOTIFY_THRESHOLD	0x12	/** not a real XTI option */
#define TCP_CONN_ABORT_THRESHOLD	0x13	/** not a real XTI option */
#define TCP_OOBINLINE				0x14	/** not a real XTI option */
#define TCP_URGENT_PTR_TYPE			0x15	/** not a real XTI option */
#define	TCP_KEEPALIVE	 			OPT_KEEPALIVE	/* keepalive defined in OpenTransport.h */

#define	T_GARBAGE		 			2			


// UDP Level Options

#define	UDP_CHECKSUM		OPT_CHECKSUM
#define UDP_RX_ICMP			0x2

// IP Level Options

#define	IP_OPTIONS			 0x01
#define	IP_TOS				 0x02
#define	IP_TTL				 0x03
#define	IP_REUSEADDR		 0x04
#define	IP_DONTROUTE		 0x10
#define	IP_BROADCAST		 0x20
#define	IP_HDRINCL			 0x1002	
#define IP_RCVOPTS			 0x1005
#define IP_RCVDSTADDR		 0x1007
#define	IP_MULTICAST_IF		 0x1010		/* set/get IP multicast interface	*/
#define	IP_MULTICAST_TTL	 0x1011		/* set/get IP multicast timetolive	*/
#define	IP_MULTICAST_LOOP	 0x1012		/* set/get IP multicast loopback	*/
#define	IP_ADD_MEMBERSHIP	 0x1013		/* add an IP group membership		*/
#define	IP_DROP_MEMBERSHIP	 0x1014		/* drop an IP group membership		*/
#define	IP_BROADCAST_IF		 0x1015		/* Set interface for broadcasts 	*/
#define	IP_RCVIFADDR		 0x1016		/* Set interface for broadcasts 	*/

//	DVMRP-specific setsockopt commands, from ip_mroute.h
//
#define	DVMRP_INIT		100
#define	DVMRP_DONE		101
#define	DVMRP_ADD_VIF	102
#define	DVMRP_DEL_VIF	103
#define	DVMRP_ADD_LGRP	104
#define	DVMRP_DEL_LGRP	105
#define	DVMRP_ADD_MRT	106
#define	DVMRP_DEL_MRT	107

// IP_TOS precdence levels
enum
{
	T_ROUTINE		= 0,
	T_PRIORITY		= 1,
	T_IMMEDIATE		= 2,
	T_FLASH			= 3,
	T_OVERRIDEFLASH	= 4,
	T_CRITIC_ECP	= 5,
	T_INETCONTROL	= 6,
	T_NETCONTROL	= 7
};

//	IP_TOS type of service
enum
{
	T_NOTOS		= 0x0,		
	T_LDELAY	= (1<<4),
	T_HITHRPT	= (1<<3),
	T_HIREL 	= (1<<2)
};

#define	SET_TOS(prec,tos)	(((0x7 & (prec)) << 5) | (0x1c & (tos)))

// IP Multicast option structures
struct TIPAddMulticast
{
	InetHost multicastGroupAddress;
	InetHost interfaceAddress;
};
typedef struct TIPAddMulticast TIPAddMulticast;


/*******************************************************************************
** Protocol-specific events
********************************************************************************/

enum
{
	T_DNRSTRINGTOADDRCOMPLETE	= kPRIVATEEVENT+1,
	T_DNRADDRTONAMECOMPLETE		= kPRIVATEEVENT+2,
	T_DNRSYSINFOCOMPLETE		= kPRIVATEEVENT+3,
	T_DNRMAILEXCHANGECOMPLETE	= kPRIVATEEVENT+4,
	T_DNRQUERYCOMPLETE			= kPRIVATEEVENT+5
};

/*******************************************************************************
** InetAddress
********************************************************************************/

struct InetAddress
{
		OTAddressType	fAddressType;	// always AF_INET
		InetPort		fPort;			// Port number 
		InetHost		fHost;			// Host address in net byte order
		UInt8			fUnused[8];		// Traditional unused bytes
};
typedef struct InetAddress InetAddress;

/*******************************************************************************
** Domain Name Resolver (DNR) 
********************************************************************************/

enum 
{ 
		kMaxHostAddrs 		=  10,
		kMaxSysStringLen 	=  32,
		kMaxHostNameLen		= 255
};

typedef char InetDomainName[kMaxHostNameLen + 1];

struct InetHostInfo
{
	InetDomainName	name;
	InetHost		addrs[kMaxHostAddrs];
};
typedef struct InetHostInfo	InetHostInfo;

struct InetSysInfo
{
	char		cpuType[kMaxSysStringLen];
	char		osType[kMaxSysStringLen];
};
typedef struct InetSysInfo InetSysInfo;

struct InetMailExchange
{
	UInt16			preference;
	InetDomainName	exchange;
};
typedef struct InetMailExchange InetMailExchange;

struct DNSQueryInfo
{
	UInt16			qType;
	UInt16			qClass;
	UInt32			ttl;
	InetDomainName	name;
	UInt16			responseType;		// answer, authority, or additional
	UInt16			resourceLen;		// actual length of array which follows
	char			resourceData[4];	// size varies
};
typedef struct DNSQueryInfo DNSQueryInfo;


/*******************************************************************************
** DNSAddress
**
**		The DNSAddress format is optional and may be used in connects,
**		datagram sends, and resolve address calls.   The name takes the 
**		format "somewhere.com" or "somewhere.com:portnumber" where
**		the ":portnumber" is optional.   The length of this structure
**		is arbitrarily limited to the overall max length of a domain
**		name (255 chars), although a longer one can be use successfully
**		if you use this as a template for doing so.   However, the domain name 
**		is still limited to 255 characters.
********************************************************************************/

struct DNSAddress
{
	OTAddressType	fAddressType;	// always AF_DNS
	InetDomainName	fName;			
};
typedef struct DNSAddress DNSAddress;

/*******************************************************************************
** InetInterfaceInfo
********************************************************************************/

struct InetInterfaceInfo
{
	InetHost		fAddress;
	InetHost		fNetmask;
	InetHost		fBroadcastAddr;
	InetHost		fDefaultGatewayAddr;
	InetHost		fDNSAddr;
	UInt16			fVersion;
	UInt16			fHWAddrLen;
	UInt8*			fHWAddr;
	UInt32			fIfMTU;
	UInt8*			fReservedPtrs[2];
	InetDomainName	fDomainName;
	UInt8			fReserved[256];			
};
typedef struct InetInterfaceInfo InetInterfaceInfo;



/*******************************************************************************
** Static helper functions
********************************************************************************/

#ifdef __cplusplus
extern "C" {
#endif

extern pascal void	 		OTInitInetAddress(InetAddress* addr, InetPort port, InetHost host);
extern pascal size_t		OTInitDNSAddress(DNSAddress* addr, char* str);
extern pascal OSStatus 		OTInetStringToHost(char* str, InetHost* host);
extern pascal void  		OTInetHostToString(InetHost host, char* str);
extern pascal OSStatus 		OTInetGetInterfaceInfo(InetInterfaceInfo* info, SInt32 val);

#ifdef __cplusplus
}
#endif


/*******************************************************************************
** InetServices & DNR calls
********************************************************************************/

#define kDefaultInternetServicesPath	((OTConfiguration*)-3)

#if !OTKERNEL

#ifdef __cplusplus
extern "C" {
#endif

extern pascal InetSvcRef 	OTOpenInternetServices(OTConfiguration* cfig, OTOpenFlags oflag, OSStatus* err);
extern pascal OSStatus		OTAsyncOpenInternetServices(OTConfiguration* cfig, OTOpenFlags oflag, 
														OTNotifyProcPtr proc, void* contextPtr);
extern pascal OSStatus 		OTInetStringToAddress(InetSvcRef ref, char* name,
												  InetHostInfo* hinfo);
extern pascal OSStatus 		OTInetAddressToName(InetSvcRef ref, InetHost addr, 
												InetDomainName name);
extern pascal OSStatus 		OTInetSysInfo(InetSvcRef ref, char* name,
										  InetSysInfo* sysinfo);
extern pascal OSStatus 		OTInetMailExchange(InetSvcRef ref, char* name, UInt16* num,
											   InetMailExchange* mx);
											   
extern pascal OSStatus		OTInetQuery(InetSvcRef ref, char* name, UInt16 qClass, UInt16 qType,
							  		    char* buf, size_t buflen, 
										void** argv, size_t argvlen,
										OTFlags flags);
					

#ifdef __cplusplus
}
#endif

enum
{
	kDefaultInetInterface	= -1,
	kInetInterfaceInfoVersion	= 2
};

#ifdef __cplusplus

class TInternetServices : public TProvider
{
	public:
			OSStatus 	StringToAddress(char* name, InetHostInfo* hinfo)
						{ return OTInetStringToAddress(this, name, hinfo); }
					
			OSStatus 	AddressToName(InetHost addr, InetDomainName name)
						{ return OTInetAddressToName(this, addr, name); }
					
			OSStatus 	SysInfo(char* name, InetSysInfo* sysinfo )
						{ return OTInetSysInfo(this, name, sysinfo); }
					
			OSStatus 	MailExchange(char* name, UInt16* num, InetMailExchange* mx)
						{ return OTInetMailExchange(this, name, num, mx); }
						
			OSStatus	Query(char* name, UInt16 qClass, UInt16 qType, 
							  char* buf, size_t buflen, 
							  void** argv, size_t argvlen,
							  OTFlags flags)
						{ return OTInetQuery(this, name, qClass, qType, buf, buflen, argv, argvlen, flags); }
};

#endif
#endif		/* !OTKERNEL */

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#endif	/* __OTINTERNET__ */

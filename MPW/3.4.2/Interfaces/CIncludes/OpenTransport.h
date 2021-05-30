/*
	File:		OpenTransport.h

	Contains:	Open Transport client interface file.  This contains all the client APIs
				that are available to 68K clients on PowerPC machines running System 7.

	Copyright:	© 1993-1996 by Apple Computer, Inc. and Mentat Inc., all rights reserved.


*/

#ifndef __OPENTRANSPORT__
#define __OPENTRANSPORT__

#ifndef SystemSevenOrLater
#define SystemSevenOrLater	1
#endif

#ifndef __TYPES__
#include <Types.h>
#endif
#ifndef __STDDEF__
#include <stddef.h>
#endif

#if GENERATING68K && defined(__MWERKS__)
#pragma pointers_in_D0
#endif

/*	-------------------------------------------------------------------------
	Define what functions look like
	------------------------------------------------------------------------- */
	
#define _CDECL
#define _MDECL

#if defined(__SC__) || defined(THINK_CPLUS) || defined(__MRC__)
	#ifdef __cplusplus
		#undef _CDECL
		#undef _MDECL
		#define _CDECL			_cdecl
		#define _MDECL			_cdecl
	#endif
#endif

#if GENERATING68K
	typedef unsigned long	uchar_p;
	typedef unsigned long	ushort_p;
	typedef long			short_p;
	typedef long			char_p;
	typedef long			boolean_p;
	typedef long			int_t;
	typedef unsigned long	uint_t;
#else
	typedef unsigned char	uchar_p;
	typedef unsigned short	ushort_p;
	typedef short			short_p;
	typedef char			char_p;
	typedef Boolean			boolean_p;
	typedef long			int_t;
	typedef unsigned long	uint_t;
#endif

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif

#ifndef OTKERNEL
#define OTKERNEL	0
#endif
#ifndef OTUNIXERRORS
#define OTUNIXERRORS	0
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#ifdef __cplusplus
extern "C" {
#endif

/*******************************************************************************
** Some prefixes for shared libraries
********************************************************************************/

#define kOTLibraryVersion		"1.1"

#define kOTLibraryPrefix 		"OTLib$"
#define kOTModulePrefix			"OTModl$"
#define kOTClientPrefix			"OTClnt$"
#define kOTKernelPrefix			"OTKrnl$"

/*******************************************************************************
** Gestalt values for Open Transport
********************************************************************************/

enum
{
	gestaltOpenTptVersions			= 'otvr',
	gestaltOpenTpt					= 'otan',
	
	gestaltOpenTptPresentMask			= 0x00000001,
	gestaltOpenTptLoadedMask			= 0x00000002,
	gestaltOpenTptAppleTalkPresentMask	= 0x00000004,
	gestaltOpenTptAppleTalkLoadedMask	= 0x00000008,
	gestaltOpenTptTCPPresentMask		= 0x00000010,
	gestaltOpenTptTCPLoadedMask			= 0x00000020,
	gestaltOpenTptIPXSPXPresentMask		= 0x00000040,
	gestaltOpenTptIPXSPXLoadedMask		= 0x00000080,
	
	gestaltOpenTptPresentBit			= 0,
	gestaltOpenTptLoadedBit				= 1,
	gestaltOpenTptAppleTalkPresentBit	= 2,
	gestaltOpenTptAppleTalkLoadedBit	= 3,
	gestaltOpenTptTCPPresentBit			= 4,
	gestaltOpenTptTCPLoadedBit			= 5,
	gestaltOpenTptIPXSPXPresentBit		= 6,
	gestaltOpenTptIPXSPXLoadedBit		= 7
};

/*******************************************************************************
** Some typedefs used by the OpenTransport system
********************************************************************************/

/*	-------------------------------------------------------------------------
	Miscellaneous typedefs
	------------------------------------------------------------------------- */

typedef UInt32				OTTimeout;		/* A millisecond timeout value					*/
typedef long				OTSequence;		/* An ID number in connections/transactions		*/
typedef long				OTNameID;		/* An ID number for registered names			*/
typedef SInt32				OTReason;		/* A protocol-specific reason code for failure	*/
											/* Usually a Unix-style positive error code		*/
typedef UInt32				OTQLen;			/* # outstanding connection requests at 1 time	*/
typedef void*				OTClient;		/* value describing a client					*/
typedef UInt8*				OTClientName;	/* Will become internationalizeable shortly		*/
typedef long				OTCommand;		/* The command code in STREAMS messages			*/

/*	-------------------------------------------------------------------------
	OTOpenFlags - flags used for opening providers
	------------------------------------------------------------------------- */

typedef UInt32				OTOpenFlags;

enum
{
	O_ASYNC		= 0x01,
	O_NDELAY	= 0x04,
	O_NONBLOCK	= 0x04
};

/*	-------------------------------------------------------------------------
	StdCLib-style Error codes
	------------------------------------------------------------------------- */

typedef UInt16					OTUnixErr;

#if OTKERNEL || OTUNIXERRORS

	/*
	 * There may be some error code confusions with other compiler vendor header
	 * files - However, these match both MPW and AIX definitions.
	 * We undefine the #defined ones we know about so that we can put them
	 * in an enum.
	 */
	 
	#undef EPERM
	#undef ENOENT
	#undef ENORSRC
	#undef EINTR
	#undef EIO
	#undef ENXIO
	#undef E2BIG
	#undef EBADF
	#undef EAGAIN
	#undef ENOMEM
	#undef EACCES
	#undef EFAULT
	#undef EBUSY
	#undef EEXIST
	#undef ENODEV
	#undef EINVAL
	#undef ENOTTY
	#undef ERANGE
	#undef ESRCH
	#undef EPIPE

	enum
	{
		EPERM			= 1,		/* Permission denied					*/
		ENOENT			= 2,		/* No such file or directory			*/
		ENORSRC 	 	= 3,		/* No such resource						*/
		EINTR			= 4,		/* Interrupted system service			*/
		EIO 			= 5,		/* I/O error							*/
		ENXIO			= 6,		/* No such device or address			*/
		EBADF		 	= 9,		/* Bad file number						*/
		EAGAIN			= 11,		/* Try operation again later			*/
		ENOMEM			= 12,		/* Not enough space						*/
		EACCES			= 13,		/* Permission denied					*/
		EFAULT			= 14,		/* Bad address							*/
		EBUSY			= 16,		/* Device or resource busy				*/
		EEXIST			= 17,		/* File exists							*/
		ENODEV			= 19,		/* No such device						*/
		EINVAL			= 22,		/* Invalid argument						*/
		ENOTTY			= 25,		/* Not a character device				*/
		EPIPE			= 32,		/* Broken pipe							*/
		ERANGE			= 34,		/* Math result not representable		*/
		EDEADLK			= 35,		/* Call would block so was aborted		*/ 
		EWOULDBLOCK		= EDEADLK,	/* Or a deadlock would occur			*/
		EALREADY		= 37,
		ENOTSOCK		= 38,		/* Socket operation on non-socket		*/
		EDESTADDRREQ	= 39,		/* Destination address required			*/
		EMSGSIZE		= 40,		/* Message too long						*/
		EPROTOTYPE		= 41,		/* Protocol wrong type for socket		*/
		ENOPROTOOPT		= 42,		/* Protocol not available				*/
		EPROTONOSUPPORT	= 43,		/* Protocol not supported				*/
		ESOCKTNOSUPPORT	= 44,		/* Socket type not supported			*/
		EOPNOTSUPP		= 45,		/* Operation not supported on socket	*/
		EADDRINUSE		= 48,		/* Address already in use				*/
		EADDRNOTAVAIL	= 49,		/* Can't assign requested address		*/
	
		ENETDOWN		= 50,		/* Network is down						*/
		ENETUNREACH		= 51,		/* Network is unreachable				*/
		ENETRESET		= 52,		/* Network dropped connection on reset	*/
		ECONNABORTED	= 53,		/* Software caused connection abort		*/
		ECONNRESET		= 54,		/* Connection reset by peer				*/
		ENOBUFS			= 55,		/* No buffer space available			*/
		EISCONN			= 56,		/* Socket is already connected			*/
		ENOTCONN		= 57,		/* Socket is not connected				*/
		ESHUTDOWN		= 58,		/* Can't send after socket shutdown		*/
		ETOOMANYREFS	= 59,		/* Too many references: can't splice	*/
		ETIMEDOUT		= 60,		/* Connection timed out					*/
		ECONNREFUSED	= 61,		/* Connection refused					*/
	
		EHOSTDOWN		= 64,		/* Host is down							*/
		EHOSTUNREACH	= 65,		/* No route to host						*/
	
		EPROTO			= 70,
		ETIME			= 71,
		ENOSR			= 72,
		EBADMSG			= 73,
		ECANCEL			= 74,
		ENOSTR			= 75,
		ENODATA			= 76,
		EINPROGRESS		= 77,
	
		ESRCH		 	= 78,
		ENOMSG			= 79,
	
		ELASTERRNO		= 79
	};

#endif

/*	-------------------------------------------------------------------------
	Open Transport/XTI Error codes
	------------------------------------------------------------------------- */

typedef UInt16					OTXTIErr;

	enum
	{
		TSUCCESS		= 0,	/* No Error occurred						*/
		TBADADDR		= 1,	/* A Bad address was specified				*/
		TBADOPT 		= 2,	/* A Bad option was specified				*/
		TACCES			= 3,	/* Missing access permission				*/
		TBADF			= 4,	/* Bad provider reference					*/
		TNOADDR 		= 5,	/* No address was specified					*/
		TOUTSTATE		= 6,	/* Call issued in wrong state				*/
		TBADSEQ 		= 7,	/* Sequence specified does not exist		*/
		TSYSERR 		= 8,	/* A system error occurred					*/
		TLOOK			= 9,	/* An event occurred - call Look()			*/
		TBADDATA		= 10,	/* An illegal amount of data was specified	*/
		TBUFOVFLW		= 11,	/* Passed buffer not big enough				*/
		TFLOW			= 12,	/* Provider is flow-controlled				*/
		TNODATA 		= 13,	/* No data available for reading			*/
		TNODIS			= 14,	/* No disconnect indication available		*/
		TNOUDERR		= 15,	/* No Unit Data Error indication available	*/
		TBADFLAG		= 16,	/* A Bad flag value was supplied			*/
		TNOREL			= 17,	/* No orderly release indication available	*/
		TNOTSUPPORT 	= 18,	/* Command is not supported					*/
		TSTATECHNG		= 19,	/* State is changing - try again later		*/
		TNOSTRUCTYPE	= 20,	/* Bad structure type requested for OTAlloc	*/
		TBADNAME		= 21,	/* A bad endpoint name was supplied			*/
		TBADQLEN		= 22,	/* A Bind to an in-use address with qlen > 0*/
		TADDRBUSY		= 23,	/* Address requested is already in use		*/
		TINDOUT 		= 24,	/* Accept failed because of pending listen	*/
		TPROVMISMATCH	= 25,	/* Tried to accept on incompatible endpoint	*/
		TRESQLEN		= 26,
		TRESADDR		= 27,
		TQFULL			= 28,
		TPROTO			= 29,	/* An unspecified provider error occurred	*/
		TBADSYNC		= 30,	/* A synchronous call at interrupt time		*/
		TCANCELED		= 31,	/* The command was cancelled				*/
		
		TLASTXTIERROR	= 31
	};

/*	-------------------------------------------------------------------------
	Standard negative error codes conforming to both the Open Transport/XTI
	errors and the Exxxxx StdCLib errors.
	These are returned as OSStatus' from functions, and to the OTResult parameter
	of a notification function or method.  However, OTResult may sometimes
	contain other values depending on the notification.
	------------------------------------------------------------------------- */

typedef SInt32				OTResult;
	/*
	 * These map the Open Transport/XTI errors (the Txxxx error codes), and the
	 * StdCLib Exxxx error codes into unique spaces in the Apple OSStatus space.
	 */
	#define XTI2OSStatus(x)			(-3149 - (x))
	#define E2OSStatus(x)			(-3199 - (x))

	#define OSStatus2XTI(x)			((OTXTIErr)(-3149 - (x)))
	#define OSStatus2E(x)			((OTUnixErr)(-3199 - (x)))
	
	#define IsXTIError(x)			((x) < -3149 && (x) >= (-3149 - TLASTXTIERROR))
	#define IsEError(x)				((x) < -3199 && (x) >= (-3199 - ELASTERRNO))

	enum
	{
		kOTNoError				= (OSStatus)0,		/* No Error occurred							*/
		kOTOutOfMemoryErr		= -3211,
		kOTNotFoundErr			= -3201,
		kOTDuplicateFoundErr	= -3216,
		/*
		 * Remapped XTI error codes
		 */
		kOTBadAddressErr		= XTI2OSStatus(TBADADDR),		/* -3150 A Bad address was specified				*/
		kOTBadOptionErr			= XTI2OSStatus(TBADOPT),		/* -3151 A Bad option was specified					*/
		kOTAccessErr			= XTI2OSStatus(TACCES),			/* -3152 Missing access permission					*/
		kOTBadReferenceErr		= XTI2OSStatus(TBADF),			/* -3153 Bad provider reference						*/
		kOTNoAddressErr			= XTI2OSStatus(TNOADDR),		/* -3154 No address was specified					*/
		kOTOutStateErr			= XTI2OSStatus(TOUTSTATE),		/* -3155 Call issued in wrong state					*/
		kOTBadSequenceErr		= XTI2OSStatus(TBADSEQ),		/* -3156 Sequence specified does not exist			*/
		kOTSysErrorErr			= XTI2OSStatus(TSYSERR),		/* -3157 A system error occurred					*/
		kOTLookErr				= XTI2OSStatus(TLOOK),			/* -3158 An event occurred - call Look()			*/
		kOTBadDataErr			= XTI2OSStatus(TBADDATA),		/* -3159 An illegal amount of data was specified	*/
		kOTBufferOverflowErr	= XTI2OSStatus(TBUFOVFLW),		/* -3160 Passed buffer not big enough				*/
		kOTFlowErr				= XTI2OSStatus(TFLOW),			/* -3161 Provider is flow-controlled				*/
		kOTNoDataErr			= XTI2OSStatus(TNODATA),		/* -3162 No data available for reading				*/
		kOTNoDisconnectErr		= XTI2OSStatus(TNODIS),			/* -3163 No disconnect indication available			*/
		kOTNoUDErrErr			= XTI2OSStatus(TNOUDERR),		/* -3164 No Unit Data Error indication available	*/
		kOTBadFlagErr			= XTI2OSStatus(TBADFLAG),		/* -3165 A Bad flag value was supplied				*/
		kOTNoReleaseErr			= XTI2OSStatus(TNOREL),			/* -3166 No orderly release indication available	*/
		kOTNotSupportedErr		= XTI2OSStatus(TNOTSUPPORT),	/* -3167 Command is not supported					*/
		kOTStateChangeErr		= XTI2OSStatus(TSTATECHNG),		/* -3168 State is changing - try again later		*/
		kOTNoStructureTypeErr	= XTI2OSStatus(TNOSTRUCTYPE),	/* -3169 Bad structure type requested for OTAlloc	*/
		kOTBadNameErr			= XTI2OSStatus(TBADNAME),		/* -3170 A bad endpoint name was supplied			*/
		kOTBadQLenErr			= XTI2OSStatus(TBADQLEN),		/* -3171 A Bind to an in-use addr with qlen > 0		*/
		kOTAddressBusyErr		= XTI2OSStatus(TADDRBUSY),		/* -3172 Address requested is already in use		*/
		kOTIndOutErr			= XTI2OSStatus(TINDOUT),		/* -3173 Accept failed because of pending listen	*/
		kOTProviderMismatchErr	= XTI2OSStatus(TPROVMISMATCH),	/* -3174 Tried to accept on incompatible endpoint	*/
		kOTResQLenErr			= XTI2OSStatus(TRESQLEN),		/* -3175											*/
		kOTResAddressErr		= XTI2OSStatus(TRESADDR),		/* -3176											*/
		kOTQFullErr				= XTI2OSStatus(TQFULL),			/* -3177											*/
		kOTProtocolErr			= XTI2OSStatus(TPROTO),			/* -3178 An unspecified provider error occurred		*/
		kOTBadSyncErr			= XTI2OSStatus(TBADSYNC),		/* -3179 A synchronous call at interrupt time		*/
		kOTCanceledErr			= XTI2OSStatus(TCANCELED),		/* -3180 The command was cancelled					*/
		/*
		 * Remapped StdCLib error codes.
		 */
		kEPERMErr					= -3200,		/*  Permission denied					*/
		kENOENTErr					= -3201,		/*  No such file or directory			*/
		kENORSRCErr					= -3202,		/*  No such resource					*/
		kEINTRErr					= -3203,		/*  Interrupted system service			*/
		kEIOErr						= -3204,		/*  I/O error							*/
		kENXIOErr					= -3205,		/*  No such device or address			*/
		kEBADFErr					= -3208,		/*  Bad file number						*/
		kEAGAINErr					= -3210,		/*  Try operation again later			*/
		kENOMEMErr					= -3211,		/*  Not enough space					*/
		kEACCESErr					= -3212,		/*  Permission denied					*/
		kEFAULTErr					= -3213,		/*  Bad address							*/
		kEBUSYErr					= -3215,		/*  Device or resource busy				*/
		kEEXISTErr					= -3216,		/*  File exists							*/
		kENODEVErr					= -3218,		/*  No such device						*/
		kEINVALErr					= -3221,		/*  Invalid argument					*/
		kENOTTYErr					= -3224,		/*  Not a character device				*/
		kEPIPEErr					= -3231,		/*  Broken pipe							*/
		kERANGEErr					= -3233,		/*  Message size too large for STREAM	*/
		kEWOULDBLOCKErr				= -3234,		/*  Call would block, so was aborted	*/
		kEDEADLKErr					= -3234,		/*  or a deadlock would occur			*/
		kEALREADYErr				= -3236,		/* 										*/
		kENOTSOCKErr				= -3237,		/*  Socket operation on non-socket		*/
		kEDESTADDRREQErr			= -3238,		/*  Destination address required		*/
		kEMSGSIZEErr				= -3239,		/*  Message too long					*/
		kEPROTOTYPEErr				= -3240,		/*  Protocol wrong type for socket		*/
		kENOPROTOOPTErr				= -3241,		/*  Protocol not available				*/
		kEPROTONOSUPPORTErr 		= -3242,		/*  Protocol not supported				*/
		kESOCKTNOSUPPORTErr 		= -3243,		/*  Socket type not supported			*/
		kEOPNOTSUPPErr				= -3244,		/*  Operation not supported on socket	*/
		kEADDRINUSEErr				= -3247,		/*  Address already in use				*/
		kEADDRNOTAVAILErr			= -3248,		/*  Can't assign requested address		*/
		kENETDOWNErr				= -3249,		/*  Network is down						*/
		kENETUNREACHErr				= -3250,		/*  Network is unreachable				*/
		kENETRESETErr				= -3251,		/*  Network dropped connection on reset	*/
		kECONNABORTEDErr			= -3252,		/*  Software caused connection abort	*/
		kECONNRESETErr				= -3253,		/*  Connection reset by peer			*/
		kENOBUFSErr					= -3254,		/*  No buffer space available			*/
		kEISCONNErr					= -3255,		/*  Socket is already connected			*/
		kENOTCONNErr				= -3256,		/*  Socket is not connected				*/
		kESHUTDOWNErr				= -3257,		/*  Can't send after socket shutdown	*/
		kETOOMANYREFSErr			= -3258,		/*  Too many references: can't splice	*/
		kETIMEDOUTErr				= -3259,		/*  Connection timed out				*/
		kECONNREFUSEDErr			= -3260,		/*  Connection refused					*/
		kEHOSTDOWNErr				= -3263,		/*  Host is down						*/
		kEHOSTUNREACHErr			= -3264,		/*  No route to host					*/
		kEPROTOErr					= -3269,		/* 										*/
		kETIMEErr					= -3270,		/* 										*/
		kENOSRErr					= -3271,		/* 										*/
		kEBADMSGErr					= -3272,		/* 										*/
		kECANCELErr					= -3273,		/* 										*/
		kENOSTRErr					= -3274,		/* 										*/
		kENODATAErr					= -3275,		/* 										*/
		kEINPROGRESSErr				= -3276,		/* 										*/
		kESRCHErr					= -3277,		/* 										*/
		kENOMSGErr					= -3278,		/* 										*/
		
		kOTClientNotInittedErr		= -3279,
		kOTPortHasDiedErr			= -3280,
		kOTPortWasEjectedErr		= -3281,
		kOTBadConfigurationErr		= -3282,
		kOTConfigurationChangedErr	= -3283,
		kOTUserRequestedErr			= -3284,
		kOTPortLostConnection		= -3285	
	};
	
/*	-------------------------------------------------------------------------
	OTAddressType - defines the address type for the OTAddress
	------------------------------------------------------------------------- */

typedef UInt16		OTAddressType;

enum
{
	kOTGenericName	= 0
};

/*	-------------------------------------------------------------------------
	OTAddress - Generic OpenTransport protocol address
	------------------------------------------------------------------------- */

struct OTAddress
{
	OTAddressType	fAddressType;
	UInt8			fAddress[1];
};

typedef struct OTAddress	OTAddress;

/*	-------------------------------------------------------------------------
	OTStructType - defines the structure type for the OTAlloc call
	------------------------------------------------------------------------- */

typedef UInt32				OTStructType;

	enum
	{
		T_BIND			= (OTStructType)1,
		T_OPTMGMT		= (OTStructType)2,
		T_CALL			= (OTStructType)3,
		T_DIS			= (OTStructType)4,
		T_UNITDATA		= (OTStructType)5,
		T_UDERROR		= (OTStructType)6,
		T_INFO			= (OTStructType)7,
		T_REPLYDATA		= (OTStructType)8,
		T_REQUESTDATA	= (OTStructType)9,
		T_UNITREQUEST	= (OTStructType)10,
		T_UNITREPLY		= (OTStructType)11
	};

/*	-------------------------------------------------------------------------
	OTFlags - flags for sending and receiving data
	------------------------------------------------------------------------- */

typedef UInt32				OTFlags;

	enum
	{
		T_MORE			= 0x001,	/* More data to come in message		*/
		T_EXPEDITED 	= 0x002,	/* Data is expedited, if possible	*/
		T_ACKNOWLEDGED	= 0x004,	/* Acknowledge transaction			*/
		T_PARTIALDATA	= 0x008,	/* Partial data - more coming		*/
		T_NORECEIPT		= 0x010,	/* No event on transaction done		*/
		T_TIMEDOUT		= 0x020		/* Reply timed out					*/
	};

/*	-------------------------------------------------------------------------
	OTBand - a band value when reading priority messages
	------------------------------------------------------------------------- */

typedef UInt32		OTBand;			/* A priority band value					*/

/*	-------------------------------------------------------------------------
	Reference values
	------------------------------------------------------------------------- */

#ifdef __cplusplus
typedef struct TProvider*	ProviderRef;
typedef struct TEndpoint*	EndpointRef;
typedef struct TMapper*		MapperRef;
#else
typedef void*				ProviderRef;
typedef void*				EndpointRef;
typedef void*				MapperRef;
#endif

enum 
{
	kOTInvalidRef			= 0
};

#define kOTInvalidProviderRef	((ProviderRef)0)
#define kOTInvalidEndpointRef	((EndpointRef)0)
#define kOTInvalidMapperRef		((MapperRef)0)

/*	-------------------------------------------------------------------------
	OTEventCode values for Open Transport - These are the event codes that
	are sent to notification routine during asynchronous processing.
	------------------------------------------------------------------------- */

typedef UInt32	OTEventCode;
/*
 * Function definition to handle notification from providers
 *
 * This is never a UniversalProcPtr.
 */
typedef pascal void (*OTNotifyProcPtr)(void* contextPtr, OTEventCode code, 
									   OTResult result, void* cookie);

enum
{
	/*
	 * These will be returned by the T_LOOK function, or will be returned
	 * if asynchronous notification is used.
	 */
	T_LISTEN					= (OTEventCode)0x0001,		/* An connection request is available 	*/
	T_CONNECT					= (OTEventCode)0x0002,		/* Confirmation of a connect request	*/ 
	T_DATA						= (OTEventCode)0x0004,		/* Standard data is available			*/
	T_EXDATA					= (OTEventCode)0x0008,		/* Expedited data is available			*/
	T_DISCONNECT				= (OTEventCode)0x0010,		/* A disconnect is available			*/
	T_ERROR 					= (OTEventCode)0x0020,		/* obsolete/unused in library			*/
	T_UDERR 					= (OTEventCode)0x0040,		/* A Unit Data Error has occurred		*/
	T_ORDREL					= (OTEventCode)0x0080,		/* An orderly release is available		*/
	T_GODATA					= (OTEventCode)0x0100,		/* Flow control lifted on standard data	*/
	T_GOEXDATA					= (OTEventCode)0x0200,		/* Flow control lifted on expedited data*/
	T_REQUEST					= (OTEventCode)0x0400,		/* An Incoming request is available		*/
	T_REPLY						= (OTEventCode)0x0800,		/* An Incoming reply is available		*/
	T_PASSCON 					= (OTEventCode)0x1000,		/* State is now T_DATAXFER				*/
	T_RESET 					= (OTEventCode)0x2000,		/* Protocol has been reset				*/

	/*
	 * kPRIVATEEVENT + 1 through kPRIVATEEVENT + 0xffff
	 *		may be used for any private event codes desired.
	 *		All other event codes are reserved for Apple Computer, Inc.
	 *		use only.
	 */
	kPRIVATEEVENT				= (OTEventCode)0x10000000,
	/*
	 * These are only returned if asynchronous notification is being used
	 */
	kCOMPLETEEVENT				= (OTEventCode)0x20000000,
	
	T_BINDCOMPLETE				= (OTEventCode)0x20000001,	/* Bind call is complete				*/	
	T_UNBINDCOMPLETE			= (OTEventCode)0x20000002,	/* Unbind call is complete				*/
	T_ACCEPTCOMPLETE			= (OTEventCode)0x20000003,	/* Accept call is complete				*/
	T_REPLYCOMPLETE				= (OTEventCode)0x20000004,	/* SendReply call is complete			*/
	T_DISCONNECTCOMPLETE		= (OTEventCode)0x20000005,	/* Disconnect call is complete			*/
	T_OPTMGMTCOMPLETE			= (OTEventCode)0x20000006,	/* OptMgmt call is complete				*/
	T_OPENCOMPLETE				= (OTEventCode)0x20000007,	/* An Open call is complete				*/
	T_GETPROTADDRCOMPLETE		= (OTEventCode)0x20000008,	/* GetProtAddress call is complete		*/
	T_RESOLVEADDRCOMPLETE		= (OTEventCode)0x20000009,	/* A ResolveAddress call is complet		*/
	T_GETINFOCOMPLETE			= (OTEventCode)0x2000000A,	/* A GetInfo call is complete			*/
	T_SYNCCOMPLETE				= (OTEventCode)0x2000000B,	/* A Sync call is complete				*/
	T_MEMORYRELEASED			= (OTEventCode)0x2000000C,	/* No-copy memory was released			*/
	T_REGNAMECOMPLETE			= (OTEventCode)0x2000000D,	/* A RegisterName call is complete		*/
	T_DELNAMECOMPLETE			= (OTEventCode)0x2000000E,	/* A DeleteName call is complete		*/
	T_LKUPNAMECOMPLETE			= (OTEventCode)0x2000000F,	/* A LookupName call is complete		*/
	T_LKUPNAMERESULT			= (OTEventCode)0x20000010,	/* A LookupName is returning a name		*/
	kOTSyncIdleEvent			= (OTEventCode)0x20000011,	/* Synchronous call Idle event			*/
	/*
	 * These are events you get using the STREAMS functions like
	 * IOCtl, PutMessage, and GetMessage
	 */
	kSTREAMEVENT				= (OTEventCode)0x21000000,

	kGetmsgEvent				= (OTEventCode)0x21000002,	/* A GetMessage call is complete		*/
	kStreamReadEvent			= (OTEventCode)0x21000003,	/* A Read call is complete				*/
	kStreamWriteEvent			= (OTEventCode)0x21000004,	/* A Write call is complete				*/
	kStreamIoctlEvent			= (OTEventCode)0x21000005,	/* An Ioctl call is complete			*/
	kStreamOpenEvent			= (OTEventCode)0x21000007,	/* An OpenStream call is complete		*/
	kPollEvent					= (OTEventCode)0x21000008,	/* A Poll call is complete				*/

	kSIGNALEVENT				= (OTEventCode)0x22000000,	/* A signal has arrived from the STREAM	*/
	
	kPROTOCOLEVENT				= (OTEventCode)0x23000000,	/* Some event from the protocols		*/
	/*
	 * These are miscellaneous events that could be sent to a provider
	 */
	kOTProviderIsDisconnected	= (OTEventCode)0x23000001,	/* Provider is temporarily off-line		*/
	kOTProviderIsReconnected	= (OTEventCode)0x23000002,	/* Provider is now back on-line			*/
	/*
	 * These are system events sent to each provider.
	 */
	kOTProviderWillClose		= (OTEventCode)0x24000001,	/* Provider will close immediately		*/
	kOTProviderIsClosed			= (OTEventCode)0x24000002,	/* Provider was closed					*/
	/*
	 * These are system events sent to registered clients
	 */
		//
		// result code is 0, cookie is the OTPortRef
		//
	kOTPortDisabled				= (OTEventCode)0x25000001,	/* Port is now disabled					*/
	kOTPortEnabled				= (OTEventCode)0x25000002,	/* Port is now enabled					*/
	kOTPortOffline				= (OTEventCode)0x25000003,	/* Port is now offline					*/
	kOTPortOnline				= (OTEventCode)0x25000004,	/* Port is now online					*/
		//
		// result is a reason for the close request, cookie is a pointer to the 
		// OTPortCloseStruct structure.
		//
	kOTClosePortRequest			= (OTEventCode)0x25000005,	/* Request to close/yield				*/
	kOTYieldPortRequest			= (OTEventCode)0x25000005,	/* Request to close/yield				*/
		//
		// A new port has been registered, cookie is the OTPortRef
		//
	kOTNewPortRegistered		= (OTEventCode)0x25000006,	/* New port has been registered			*/
	/*
	 * These are events sent to the configuration management infrastructure 
	 */
	kOTConfigurationChanged		= (OTEventCode)0x26000001,	/* Protocol configuration changed		*/
	kOTSystemSleep				= (OTEventCode)0x26000002,
	kOTSystemShutdown			= (OTEventCode)0x26000003,
	kOTSystemAwaken				= (OTEventCode)0x26000004,
	kOTSystemIdle				= (OTEventCode)0x26000005,
	kOTSystemSleepPrep			= (OTEventCode)0x26000006,
	kOTSystemShutdownPrep		= (OTEventCode)0x26000007,
	kOTSystemAwakenPrep			= (OTEventCode)0x26000008
};

#define IsOTPrivateEvent(x)			(((x) & 0x70000000L) == kPRIVATEEVENT)
#define IsOTCompleteEvent(x)		(((x) & 0x7f000000L) == kCOMPLETEEVENT)
#define IsOTProtocolEvent(x)		(((x) & 0x7f000000L) == kPROTOCOLEVENT)
#define IsOTStreamEvent(x)			(((x) & 0x7f000000L) == kSTREAMEVENT)
#define IsOTSignalEvent(x)			(((x) & 0x7f000000L) == kSIGNALEVENT)
#define GetOTEventCode(x)			(x)

/*	-------------------------------------------------------------------------
	Signals that are generated by a stream.  Add these values to
	kSIGNALEVENT to determine what event you are receiving.
	------------------------------------------------------------------------- */

enum
{
	SIGHUP		= 1,
	SIGURG		= 16,
	SIGPOLL		= 30
};

/*	-------------------------------------------------------------------------
	Option Management equates
	------------------------------------------------------------------------- */
/*
** The XTI Level number of a protocol
*/
typedef UInt32				OTXTILevel;

	enum
	{
		XTI_GENERIC 	= (OTXTILevel)0xffff	/* level to match any protocol	*/
	};
/*
** The XTI name of a protocol option
*/
typedef UInt32				OTXTIName;
	/*
	 * XTI names for options used with XTI_GENERIC above
	 */
	enum
	{
		XTI_DEBUG		= (OTXTIName)0x0001,
		XTI_LINGER		= (OTXTIName)0x0080,
		XTI_RCVBUF		= (OTXTIName)0x1002,
		XTI_RCVLOWAT	= (OTXTIName)0x1004,
		XTI_SNDBUF		= (OTXTIName)0x1001,
		XTI_SNDLOWAT	= (OTXTIName)0x1003,
		XTI_PROTOTYPE	= (OTXTIName)0x1005
	};
	/*
	 * Generic options that can be used with any protocol
	 * that understands them
	 */
	enum 
	{
		OPT_CHECKSUM	= (OTXTIName)0x0600,	// Set checksumming = UInt32 - 0 or 1)
		OPT_RETRYCNT	= (OTXTIName)0x0601,	// Set a retry counter = UInt32 (0 = infinite)
		OPT_INTERVAL	= (OTXTIName)0x0602,	// Set a retry interval = UInt32 milliseconds
		OPT_ENABLEEOM	= (OTXTIName)0x0603,	// Enable the EOM indication = UInt8 (0 or 1)
		OPT_SELFSEND	= (OTXTIName)0x0604,	// Enable Self-sending on broadcasts = UInt32 (0 or 1)
		OPT_SERVERSTATUS= (OTXTIName)0x0605,	// Set Server Status (format is proto dependent)
		OPT_ALERTENABLE	= (OTXTIName)0x0606,	// Enable/Disable protocol alerts
		OPT_KEEPALIVE	= (OTXTIName)0x0008		// See t_keepalive structure
	};

/*******************************************************************************
** Definitions not associated with a Typedef
********************************************************************************/

/*	-------------------------------------------------------------------------
	IOCTL values for the OpenTransport system
	------------------------------------------------------------------------- */

#define	MIOC_CMD(t,v)	((((t)&0xFF) << 8) | ((v)&0xFF))

enum
{
	MIOC_STREAMIO	= 'A',		/* Basic Stream ioctl() cmds - I_PUSH, I_LOOK, etc. */
	MIOC_STRLOG		= 'b',		/* ioctl's for Mentat's log device */
	MIOC_SAD		= 'g',		/* ioctl's for Mentat's sad module */
	MIOC_TCP		= 'k',		/* tcp.h ioctl's */
	MIOC_DLPI		= 'l',		/* dlpi.h additions */
	MIOC_OT			= 'O',		/* ioctls for Open Transport	*/
	MIOC_ATALK		= 'T',		/* ioctl's for AppleTalk	*/
	MIOC_SRL		= 'U',		/* ioctl's for Serial		*/
	MIOC_CFIG		= 'z'		/* ioctl's for private configuration */
};

enum
{
	I_OTGetMiscellaneousEvents	= ((MIOC_OT << 8) | 1),			/* sign up for Misc Events					*/
	I_OTSetFramingType			= ((MIOC_OT << 8) | 2),			/* Set framing option for link				*/
		kOTGetFramingValue			= 0xffffffff,				/* Use this value to read framing			*/
	I_OTSetRawMode				= ((MIOC_OT << 8) | 3),			/* Set raw mode for link					*/
		kOTSetRecvMode				= 0x1,
		kOTSendErrorPacket			= 0x2,

	I_OTConnect					= ((MIOC_OT << 8) | 4),			/* Generic connect request for links		*/
	I_OTDisconnect				= ((MIOC_OT << 8) | 5),			/* Generic disconnect request for links		*/
	I_OTScript					= ((MIOC_OT << 8) | 6)			/* Send a script to a module				*/
};
/*
 * Structure for the I_OTScript Ioctl.
 */
struct OTScriptInfo
{
	UInt32	fScriptType;
	void*	fTheScript;
	UInt32	fScriptLength;
};
typedef struct OTScriptInfo	OTScriptInfo;
	
/*	-------------------------------------------------------------------------
	Maximum size of a provider name, and maximum size of a STREAM module name.
	This module name is smaller than the maximum size of a TProvider to allow
	for 4 characters of extra "minor number" information that might be 
	potentially in a TProvider name
	------------------------------------------------------------------------- */

enum
{
	kMaxModuleNameLength	= 31,
	kMaxModuleNameSize		= kMaxModuleNameLength + 1,

	kMaxProviderNameLength	= kMaxModuleNameLength + 4,
	kMaxProviderNameSize	= kMaxProviderNameLength + 1,
	
	kMaxSlotIDLength		= 7,
	kMaxSlotIDSize			= 8,
	
	kMaxResourceInfoLength	= 31,
	kMaxResourceInfoSize	= 32
};

/*	-------------------------------------------------------------------------
	These values are used in the "fields" parameter of the OTAlloc call
	to define which fields of the structure should be allocated.
	------------------------------------------------------------------------- */

enum 
{
	T_ADDR			= 0x01,
	T_OPT			= 0x02,
	T_UDATA 		= 0x04,
	T_ALL			= 0xffff
};

/*	-------------------------------------------------------------------------
	These are the potential values returned by OTGetEndpointState and OTSync
	which represent the state of an endpoint
	------------------------------------------------------------------------- */

enum
{
	T_UNINIT		= 0,	/* addition to standard xti.h	*/
	T_UNBND 		= 1,	/* unbound						*/
	T_IDLE			= 2,	/* idle							*/
	T_OUTCON		= 3,	/* outgoing connection pending	*/
	T_INCON 		= 4,	/* incoming connection pending	*/
	T_DATAXFER		= 5,	/* data transfer				*/
	T_OUTREL		= 6,	/* outgoing orderly release		*/
	T_INREL 		= 7		/* incoming orderly release		*/
};

/*	-------------------------------------------------------------------------
	Flags used by option management calls to request services
	------------------------------------------------------------------------- */

enum
{
	T_NEGOTIATE 	= 0x004,
	T_CHECK 		= 0x008,
	T_DEFAULT		= 0x010,
	T_CURRENT		= 0x080
};

/*	-------------------------------------------------------------------------
	Flags used by option management calls to return results
	------------------------------------------------------------------------- */
	
enum
{
	T_SUCCESS		= 0x020,
	T_FAILURE		= 0x040,
	T_PARTSUCCESS	= 0x100,
	T_READONLY		= 0x200,
	T_NOTSUPPORT	= 0x400
};

/*	-------------------------------------------------------------------------
	General definitions
	------------------------------------------------------------------------- */

enum
{
	T_YES			= 1,
	T_NO			= 0,
	T_UNUSED		= -1,
	T_NULL			= 0,
	T_ABSREQ		= 0x8000
};

/*	-------------------------------------------------------------------------
	Option Management definitions
	------------------------------------------------------------------------- */

enum
{
	T_UNSPEC		= (~0 - 2),
	T_ALLOPT		= 0
};
//
// This macro will align return the value of "len", rounded up to the next
// 4-byte boundary.
//
#define T_ALIGN(len)		(((UInt32)(len)+(sizeof(SInt32)-1)) & ~(sizeof(SInt32)-1))
//
// This macro will return the next option in the buffer, given the previous option
// in the buffer, returning NULL if there are no more.
// You start off by setting prevOption = (TOption*)theBuffer
// (Use OTNextOption for a more thorough check - it ensures the end
//  of the option is in the buffer as well.)
//
#define OPT_NEXTHDR(theBuffer, theBufLen, prevOption) \
	(((char*)(prevOption) + T_ALIGN((prevOption)->len) < (char*)(theBuffer) + (theBufLen)) ?	\
			(TOption*)((char*)(prevOption)+T_ALIGN((prevOption)->len))	\
			: (TOption*)NULL)
	
/*******************************************************************************
** Structures and forward declarations
**
** From here on down, all structures are aligned the same on 68K and powerpc
********************************************************************************/

/*	-------------------------------------------------------------------------
	OTConfiguration structure - this is a "black box" structure used to
	define the configuration of a provider or endpoint.
	------------------------------------------------------------------------- */

struct OTConfiguration;
typedef struct OTConfiguration	OTConfiguration;

#define kOTInvalidConfigurationPtr		((OTConfiguration*)-1L)
#define kOTNoMemoryConfigurationPtr		((OTConfiguration*)0)

/*	-------------------------------------------------------------------------
	Option Management structures
	------------------------------------------------------------------------- */
/*
 * Structure used with OPT_KEEPALIVE option.
 */
struct t_kpalive
{
	long	kp_onoff;		/* option on/off		*/
	long	kp_timeout;		/* timeout in minutes	*/
};
typedef struct t_kpalive t_kpalive;

/*
 * Structure used with XTI_LINGER option
 */
struct t_linger 
{
	long	l_onoff;		/* option on/off */
	long	l_linger;		/* linger time */
};
typedef struct t_linger t_linger;

/*	-------------------------------------------------------------------------
	TEndpointInfo - this structure is returned from the GetEndpointInfo call
	and contains information about an endpoint
	------------------------------------------------------------------------- */

struct t_info
{
	SInt32	addr;		/* Maximum size of an address			*/
	SInt32	options;	/* Maximum size of options				*/
	SInt32	tsdu;		/* Standard data transmit unit size		*/
	SInt32	etsdu;		/* Expedited data transmit unit size	*/
	SInt32	connect;	/* Maximum data size on connect			*/
	SInt32	discon;		/* Maximum data size on disconnect		*/
	UInt32	servtype;	/* service type (see below for values)	*/
	UInt32	flags;		/* Flags (see below for values)			*/
};

typedef struct t_info		TEndpointInfo;

/*
 * Values returned in servtype field of TEndpointInfo
 */
enum
{
	T_COTS			= 1,	/* Connection-mode service								*/
	T_COTS_ORD		= 2,	/* Connection service with orderly release				*/
	T_CLTS			= 3,	/* Connectionless-mode service							*/
	T_TRANS			= 5,	/* Connection-mode transaction service					*/
	T_TRANS_ORD		= 6,	/* Connection transaction service with orderly release	*/
	T_TRANS_CLTS	= 7		/* Connectionless transaction service					*/
};
/*
 * Values returned in flags field of TEndpointInfo
 */
enum
{
	T_SENDZERO			= 0x001,			/* supports 0-length TSDU's				*/
	T_XPG4_1			= 0x002,			/* supports the GetProtAddress call		*/
	T_CAN_SUPPORT_MDATA	= 0x10000000,		/* support M_DATAs on packet protocols	*/
	T_CAN_RESOLVE_ADDR	= 0x40000000,		/* Supports ResolveAddress call			*/
	T_CAN_SUPPLY_MIB	= 0x20000000		/* Supports SNMP MIB data				*/
};
/*
 * Values returned in tsdu, etsdu, connect, and discon fields of TEndpointInfo
 */
enum
{
	T_INFINITE		= -1,	/* supports infinit amounts of data		*/
	T_INVALID		= -2	/* Does not support data transmission	*/
};

/*	-------------------------------------------------------------------------
	OTPortRecord
	------------------------------------------------------------------------- */
/*
 * Unique identifier for a port
 */
typedef UInt32 OTPortRef;

/*
 * A couple of special values for the "port type" in an OTPortRef.
 * See OpenTptLinks.h for other values.
 * The device kOTPseudoDevice is used where no other defined
 * device type will work.
 */
enum
{
	kOTNoDeviceType		= 0,
	kOTPseudoDevice		= 1023,
	kOTLastDeviceIndex	= 1022,
	
	kOTLastSlotNumber	= 255,
	kOTLastOtherNumber	= 255
};

/*
 * kMaxPortNameLength is the maximum size allowed to define
 * a port
 */
enum
{
	kMaxPortNameLength		= kMaxModuleNameLength + 4,
	kMaxPortNameSize		= kMaxPortNameLength + 1
};

enum
{
	kOTInvalidPortRef	= ((OTPortRef)0)
};

/*
 * Equates for the legal Bus-type values
 */
enum
{
	kOTUnknownBusPort	= 0,
	kOTMotherboardBus	= 1,
	kOTNuBus			= 2,
	kOTPCIBus			= 3,
	kOTGeoPort			= 4,
	kOTPCCardBus		= 5,
	kOTFireWireBus		= 6,
	kOTLastBusIndex		= 15
};

struct OTPortCloseStruct
{
	OTPortRef			fPortRef;			// The port requested to be closed.
	ProviderRef			fTheProvider;		// The provider using the port.
	OSStatus			fDenyReason;		// Set to a negative number to deny the request
};

typedef struct OTPortCloseStruct	OTPortCloseStruct;

extern pascal OTPortRef	OTCreatePortRef(UInt8 busType, UInt16 devType,
										UInt16 slot, UInt16 other);
extern pascal UInt16	OTGetDeviceTypeFromPortRef(OTPortRef ref);
extern pascal UInt16	OTGetBusTypeFromPortRef(OTPortRef ref);
extern pascal UInt16	OTGetSlotFromPortRef(OTPortRef ref, UInt16* other);
extern pascal OTPortRef	OTSetDeviceTypeInPortRef(OTPortRef ref, UInt16 devType);
extern pascal OTPortRef	OTSetBusTypeInPortRef(OTPortRef ref, UInt8 busType);

#define OTCreateNuBusPortRef(devType, slot, other)	\
	OTCreatePortRef(kOTNuBus, devType, slot, other)
	
#define OTCreatePCIPortRef(devType, slot, other)	\
	OTCreatePortRef(kOTPCIBus, devType, slot, other)
	
#define OTCreatePCMCIAPortRef(devType, slot, other)	\
	OTCreatePortRef(kOTPCMCIABus, devType, slot, other)

/*	
 * One OTPortRecord is created for each instance of a port.
 * For Instance 'enet' identifies an ethernet port.
 * A TPortRecord for each ethernet card it finds, with an
 * OTPortRef that will uniquely allow the driver to determine which
 * port it is supposed to open on.
 */

struct OTPortRecord
{
	OTPortRef		fRef;
	UInt32			fPortFlags;
	UInt32			fInfoFlags;
	UInt32			fCapabilities;
	size_t			fNumChildPorts;
	OTPortRef*		fChildPorts;
	char			fPortName[kMaxProviderNameSize];
	char			fModuleName[kMaxModuleNameSize];
	char			fSlotID[kMaxSlotIDSize];
	char			fResourceInfo[kMaxResourceInfoSize];
	char			fReserved[164];
};

typedef struct OTPortRecord	OTPortRecord;

/*
 * Values for the fInfoFlags field of OTPortRecord
 * kOTPortCanYield and kOTPortCanArbitrate
 * will not be set until the port is used for the first time.
 */
enum
{
	kOTPortIsDLPI				= 0x00000001,
	kOTPortIsTPI				= 0x00000002,
	kOTPortCanYield				= 0x00000004,
	kOTPortCanArbitrate			= 0x00000008,
	kOTPortIsTransitory			= 0x00000010,
	kOTPortAutoConnects			= 0x00000020,
	kOTPortIsSystemRegistered	= 0x00004000,
	kOTPortIsPrivate			= 0x00008000,
	kOTPortIsAlias				= 0x80000000
};
/*
 * Values for the fPortFlags field of TPortRecord
 * If no bits are set, the port is currently inactive.
 */
enum
{
	kOTPortIsActive				= 0x00000001,
	kOTPortIsDisabled 			= 0x00000002,
	kOTPortIsUnavailable		= 0x00000004,
	kOTPortIsOffline			= 0x00000008
};

/*	-------------------------------------------------------------------------
	TOptionHeader and TOption
	
	This structure describes the contents of a single option in a buffer
	------------------------------------------------------------------------- */

struct TOptionHeader
{
		UInt32		len;		/* total length of option				*/
								/* = sizeof(TOptionHeader) + length		*/
								/*	 of option value in bytes			*/
		OTXTILevel	level;		/* protocol affected					*/
		OTXTIName	name;		/* option name							*/
		UInt32		status; 	/* status value							*/
};

typedef struct TOptionHeader	TOptionHeader;

struct TOption
{
		UInt32		len;		/* total length of option				*/
								/* = sizeof(TOption) + length	*/
								/*	 of option value in bytes			*/
		OTXTILevel	level;		/* protocol affected					*/
		OTXTIName	name;		/* option name							*/
		UInt32		status; 	/* status value							*/
		UInt32		value[1];	/* data goes here						*/
};

typedef struct TOption	TOption;

enum
{
	kOTOptionHeaderSize			= sizeof(TOptionHeader),
	kOTBooleanOptionDataSize	= sizeof(UInt32),
	kOTBooleanOptionSize		= kOTOptionHeaderSize + kOTBooleanOptionDataSize,
	kOTOneByteOptionSize		= kOTOptionHeaderSize + 1,
	kOTTwoByteOptionSize		= kOTOptionHeaderSize + 2,
	kOTFourByteOptionSize		= kOTOptionHeaderSize + sizeof(UInt32)
};

/*	-------------------------------------------------------------------------
	OTClientList structure
	
	This is used with the OTYieldPortRequest function.
	------------------------------------------------------------------------- */

struct OTClientList
{
	size_t		fNumClients;
	UInt8		fBuffer[4];
};

typedef struct OTClientList	OTClientList;

/*	-------------------------------------------------------------------------
	OTData
	
	This is a structure that may be used in a TNetbuf or netbuf to send
	non-contiguous data.  Set the 'len' field of the netbuf to the
	constant kNetbufDataIsOTData to signal that the 'buf' field of the
	netbuf actually points to one of these structures instead of a
	memory buffer.
	------------------------------------------------------------------------- */

struct OTData
{
		void*		fNext;
		void*		fData;
		size_t		fLen;
};

typedef struct OTData	OTData;

enum
{
	kNetbufDataIsOTData	= (size_t)0xfffffffeU
};

/*	-------------------------------------------------------------------------
	OTBuffer

	This is the structure that is used for no-copy receives.
	When you are done with it, you must call the OTReleaseBuffer function.
	For best performance, you need to call OTReleaseBuffer quickly.  Only
	data netbufs may use this - no netbufs for addresses or options, or the like.
	------------------------------------------------------------------------- */

typedef struct OTBuffer	OTBuffer;

struct OTBuffer
{
		void*		fLink;		// b_next & b_prev
		void*		fLink2;
		OTBuffer*	fNext;		// b_cont
		UInt8*		fData;		// b_rptr
		size_t		fLen;		// b_wptr
		void*		fSave;		// b_datap
		UInt8		fBand;		// b_band
		UInt8		fType;		// b_pad1
		UInt8		fPad1;
		UInt8		fFlags;		// b_flag
};

/*	-------------------------------------------------------------------------
	OTBufferInfo
	
	This structure is used with OTReadBuffer to keep track of where you
	are in the buffer, since the OTBuffer is "read-only".
	------------------------------------------------------------------------- */

struct OTBufferInfo
{
	OTBuffer*	fBuffer;
	size_t		fOffset;
	UInt8		fPad;
};

typedef struct OTBufferInfo	OTBufferInfo;

#define OTInitBufferInfo(infoPtr, theBuffer)	\
	(infoPtr)->fBuffer = theBuffer;				\
	(infoPtr)->fPad	= (theBuffer)->fPad1;		\
	(infoPtr)->fOffset	= 0

enum
{
	kOTNetbufDataIsOTBufferStar	= (size_t)0xfffffffdU
};

/*	-------------------------------------------------------------------------
	TNetbuf
	
	This structure is the basic structure used to pass data back and forth
	between the Open Transport protocols and their clients
	------------------------------------------------------------------------- */

struct TNetbuf
{
	size_t	maxlen;
	size_t	len;
	UInt8*	buf;
};

typedef struct TNetbuf	TNetbuf;

/*	-------------------------------------------------------------------------
	TBind
	
	Structure passed to GetProtAddress, ResolveAddress and Bind
	------------------------------------------------------------------------- */

struct TBind
{
	TNetbuf	addr;
	OTQLen	qlen;
};

typedef struct TBind	TBind;

/*	-------------------------------------------------------------------------
	TDiscon
	
	Structure passed to RcvDisconnect to find out additional information
	about the disconnect
	------------------------------------------------------------------------- */

struct TDiscon
{
	TNetbuf		udata;
	OTReason	reason;
	OTSequence 	sequence;
};

typedef struct TDiscon	TDiscon;


/*	-------------------------------------------------------------------------
	TCall
	
	Structure passed to Connect, RcvConnect, Listen, Accept, and
	SndDisconnect to describe the connection.
	------------------------------------------------------------------------- */

struct TCall
{
	TNetbuf		addr;
	TNetbuf		opt;
	TNetbuf		udata;
	OTSequence 	sequence;
};

typedef struct TCall	TCall;
	
/*	-------------------------------------------------------------------------
	TUnitData
	
	Structure passed to SndUData and RcvUData to describe the datagram
	------------------------------------------------------------------------- */

struct TUnitData
{
	TNetbuf			addr;
	TNetbuf			opt;
	TNetbuf			udata;
};

typedef struct TUnitData	TUnitData;
	
/*	-------------------------------------------------------------------------
	TUDErr
	
	Structure passed to RcvUDErr to find out about a datagram error
	------------------------------------------------------------------------- */

struct TUDErr
{
	TNetbuf			addr;
	TNetbuf			opt;
	SInt32			error;
};

typedef struct TUDErr	TUDErr;

/*	-------------------------------------------------------------------------
	TOptMgmt
	
	Structure passed to the OptionManagement call to read or set protocol
	options.
	------------------------------------------------------------------------- */

struct TOptMgmt
{
	TNetbuf			opt;
	OTFlags			flags;
};

typedef struct TOptMgmt	TOptMgmt;

/*	-------------------------------------------------------------------------
	TRequest
	
	Structure passed to SndRequest and RcvRequest that contains the information
	about the request
	------------------------------------------------------------------------- */

struct TRequest
{
	TNetbuf			data;
	TNetbuf			opt;
	OTSequence		sequence;
};

typedef struct TRequest	TRequest;

/*	-------------------------------------------------------------------------
	TReply
	
	Structure passed to SndReply to send a reply to an incoming request
	------------------------------------------------------------------------- */

struct TReply
{
	TNetbuf			data;
	TNetbuf			opt;
	OTSequence		sequence;
};

typedef struct TReply	TReply;

/*	-------------------------------------------------------------------------
	TUnitRequest
	
	Structure passed to SndURequest and RcvURequest that contains the information
	about the request
	------------------------------------------------------------------------- */

struct TUnitRequest
{
	TNetbuf			addr;
	TNetbuf			opt;
	TNetbuf			udata;
	OTSequence		sequence;
};

typedef struct TUnitRequest	TUnitRequest;

/*	-------------------------------------------------------------------------
	TUnitReply
	
	Structure passed to SndUReply to send a reply to an incoming request
	------------------------------------------------------------------------- */

struct TUnitReply
{
	TNetbuf			opt;
	TNetbuf			udata;
	OTSequence		sequence;
};

typedef struct TUnitReply	TUnitReply;

/*	-------------------------------------------------------------------------
	TRegisterRequest
	------------------------------------------------------------------------- */

struct TRegisterRequest
{
	TNetbuf		name;
	TNetbuf		addr;
	OTFlags		flags;
};

typedef struct TRegisterRequest	TRegisterRequest;
	
/*	-------------------------------------------------------------------------
	TRegisterReply
	------------------------------------------------------------------------- */

struct TRegisterReply
{
	TNetbuf		addr;
	OTNameID	nameid;
};

typedef struct TRegisterReply	TRegisterReply;
	
/*	-------------------------------------------------------------------------
	TLookupRequest
	------------------------------------------------------------------------- */

struct TLookupRequest
{
	TNetbuf		name;
	TNetbuf		addr;
	UInt32		maxcnt;
	OTTimeout	timeout;
	OTFlags		flags;
};

typedef struct TLookupRequest	TLookupRequest;

/*	-------------------------------------------------------------------------
	TLookupReply 
	
	Structure used by Mapper protocols to return the results of name Lookups
	------------------------------------------------------------------------- */
 
struct TLookupBuffer
{
	UInt16		fAddressLength;
	UInt16		fNameLength;
	UInt8		fAddressBuffer[1];
};

typedef struct TLookupBuffer	TLookupBuffer;

#define OTNextLookupBuffer(buf)			\
	((TLookupBuffer*)					\
		((char*)buf + ((offsetof(TLookupBuffer, fAddressBuffer) + buf->fAddressLength + buf->fNameLength + 3) & ~3)))

struct TLookupReply
{
	TNetbuf			names;
	UInt32			rspcount;
};

typedef struct TLookupReply	TLookupReply;

/*******************************************************************************
** C Interfaces to Open Transport
********************************************************************************/

/*	-------------------------------------------------------------------------
	Initializing and shutting down Open Transport
	------------------------------------------------------------------------- */
	
#if !OTKERNEL

extern pascal OSStatus	InitOpenTransport(void);
extern pascal OSStatus	InitOpenTransportUtilities(void);
extern pascal void		CloseOpenTransport(void);
//
// This registers yourself as a client for any miscellaneous Open Transport
// notifications that come along. CloseOpenTransport will automatically do
// an OTUnregisterAsClient, if you have not already done so.
//
extern pascal OSStatus	OTRegisterAsClient(OTClientName name, OTNotifyProcPtr proc);
extern pascal OSStatus	OTUnregisterAsClient(void);

#endif	/* !OTKERNEL	*/

/*	-------------------------------------------------------------------------
	 Tasking model routines
	------------------------------------------------------------------------- */
//
// These are normally used by the kernel to tell Open Transport we're
// at interrupt time.
//
extern pascal void		OTEnterInterrupt(void);
extern pascal void		OTLeaveInterrupt(void);

	/*
	 * Function definition to handle process routine callbacks
	 *
	 * This is never a UniversalProcPtr.
	 */
	typedef pascal void (*OTProcessProcPtr)(void* arg);

extern pascal long		OTCreateDeferredTask(OTProcessProcPtr proc, void* arg);
extern pascal Boolean	OTScheduleDeferredTask(long dtCookie);
extern pascal Boolean	OTScheduleInterruptTask(long dtCookie);
extern pascal OSStatus	OTDestroyDeferredTask(long dtCookie);

#if !OTKERNEL

extern pascal long		OTCreateSystemTask(OTProcessProcPtr proc, void* arg);
extern pascal OSStatus	OTDestroySystemTask(long stCookie);
extern pascal Boolean	OTScheduleSystemTask(long stCookie);
extern pascal Boolean	OTCancelSystemTask(long stCookie);
extern pascal Boolean	OTCanMakeSyncCall(void);

#endif	/* !OTKERNEL	*/

extern Boolean			OTIsAtInterruptLevel(void);
extern Boolean			OTCanLoadLibraries(void);
	
/*	-------------------------------------------------------------------------
	Functions for dealing with port
	------------------------------------------------------------------------- */

#if !OTKERNEL
	//
	// Index through the ports in the system
	//
extern pascal Boolean	OTGetIndexedPort(OTPortRecord* record, size_t index);
	//
	// Find an OTPortRecord for a port using it's name
	//
extern pascal Boolean	OTFindPort(OTPortRecord* record, const char* portName);
	//
	// Find an OTPortRecord for a port using it's OTPortRef
	//
extern pascal Boolean	OTFindPortByRef(OTPortRecord* record, OTPortRef ref);
	//
	// Register a port. The name the port was registered under is returned in
	// the fPortName field.
	//
extern OSStatus	OTRegisterPort(OTPortRecord* portInfo, void* ref);
	//
	// Unregister the port with the given name (If you re-register the
	// port, it may get a different name - use OTChangePortState if
	// that is not desireable).  Since a single OTPortRef can be registered
	// with several names, the API needs to use the portName rather than
	// the OTPortRef to disambiguate.
	//
extern OSStatus	OTUnregisterPort(const char* portName, void**);
	//
	// Change the state of the port.
	//
extern OSStatus	OTChangePortState(OTPortRef, OTEventCode theChange, OTResult why);

#endif	/* !OTKERNEL	*/

/*	-------------------------------------------------------------------------
	Interface to providers
	------------------------------------------------------------------------- */

#if !OTKERNEL

extern pascal OSStatus		OTAsyncOpenProvider(OTConfiguration*, OTOpenFlags,
												OTNotifyProcPtr, void*);
extern pascal ProviderRef	OTOpenProvider(OTConfiguration*, OTOpenFlags, OSStatus*);
extern pascal OSStatus		OTCloseProvider(ProviderRef ref);
extern pascal ProviderRef	OTTransferProviderOwnership(ProviderRef ref, 
														OTClient prevOwner,
														OSStatus* errPtr);
extern pascal OTClient	OTWhoAmI(void);
extern pascal OTPortRef	OTGetProviderPortRef(ProviderRef ref);
extern pascal SInt32	OTIoctl(ProviderRef ref, UInt32 cmd, void* data);
extern pascal OTResult	OTGetMessage(ProviderRef ref, struct strbuf* ctlbuf,
									 struct strbuf* databuf, OTFlags*);
extern pascal OTResult	OTGetPriorityMessage(ProviderRef ref, struct strbuf* ctlbuf,
											 struct strbuf* databuf, OTBand*, OTFlags*);
extern pascal OSStatus	OTPutMessage(ProviderRef ref, const struct strbuf* ctlbuf,
									 const struct strbuf* databuf, OTFlags flags);
extern pascal OSStatus	OTPutPriorityMessage(ProviderRef ref, const struct strbuf* ctlbuf,
											 const struct strbuf* databuf, OTBand, OTFlags);
extern pascal OSStatus	OTSetAsynchronous(ProviderRef ref);
extern pascal OSStatus	OTSetSynchronous(ProviderRef ref);
extern pascal Boolean	OTIsSynchronous(ProviderRef ref);
extern pascal OSStatus	OTSetBlocking(ProviderRef ref);
extern pascal OSStatus	OTSetNonBlocking(ProviderRef ref);
extern pascal Boolean	OTIsBlocking(ProviderRef ref);
extern pascal OSStatus	OTInstallNotifier(ProviderRef ref,
										  OTNotifyProcPtr proc, void* contextPtr);
extern pascal OSStatus	OTUseSyncIdleEvents(ProviderRef ref, Boolean useEvents);
extern pascal void		OTRemoveNotifier(ProviderRef ref);
extern pascal void		OTLeaveNotifier(ProviderRef ref);
extern pascal Boolean	OTEnterNotifier(ProviderRef ref);
extern pascal OSStatus	OTAckSends(ProviderRef ref);
extern pascal OSStatus	OTDontAckSends(ProviderRef ref);
extern pascal Boolean	OTIsAckingSends(ProviderRef ref);
extern pascal OSStatus	OTCancelSynchronousCalls(ProviderRef ref, OSStatus err);

#define OTIsNonBlocking(ref)	(!OTIsBlocking(ref))
#define OTIsAsynchronous(ref)	(!OTIsSynchronous(ref))
	
#endif	/* !OTKERNEL	*/

/*	-------------------------------------------------------------------------
	Interface to endpoints
	------------------------------------------------------------------------- */

#if !OTKERNEL
//
// Open/Close
//
extern pascal EndpointRef	
						OTOpenEndpoint(OTConfiguration* config, OTOpenFlags oflag,
									   TEndpointInfo* info, OSStatus* err);
extern pascal OSStatus	OTAsyncOpenEndpoint(OTConfiguration* config,
											OTOpenFlags oflag, TEndpointInfo* info,
											OTNotifyProcPtr proc, void* contextPtr);
//
// Misc Information
//
extern pascal OSStatus	OTGetEndpointInfo(EndpointRef ref, TEndpointInfo* info);
extern pascal OTResult	OTGetEndpointState(EndpointRef ref);
extern pascal OTResult	OTLook(EndpointRef ref);
extern pascal OTResult	OTSync(EndpointRef ref);
extern pascal OTResult	OTCountDataBytes(EndpointRef ref, size_t* countPtr);
extern pascal OSStatus	OTGetProtAddress(EndpointRef ref, TBind* boundAddr,
										 TBind* peerAddr);
extern pascal OSStatus	OTResolveAddress(EndpointRef ref, TBind* reqAddr,
										 TBind* retAddr, OTTimeout timeOut);
//
// Allocating structures
//
extern pascal void*		OTAlloc(EndpointRef ref, OTStructType structType,
								UInt32 fields, OSStatus* err);
extern pascal OTResult	OTFree(void* ptr, OTStructType structType);
//
// Option management
//
extern pascal OSStatus	OTOptionManagement(EndpointRef ref, TOptMgmt* req, TOptMgmt* ret);
//
// Bind/Unbind
//
extern pascal OSStatus	OTBind(EndpointRef ref, TBind* reqAddr, TBind* retAddr);
extern pascal OSStatus	OTUnbind(EndpointRef ref);
//
// Connection creation/tear-down
//
extern pascal OSStatus	OTConnect(EndpointRef ref, TCall* sndCall, TCall* rcvCall);
extern pascal OSStatus	OTRcvConnect(EndpointRef ref, TCall* call);
extern pascal OSStatus	OTListen(EndpointRef ref, TCall* call);
extern pascal OSStatus	OTAccept(EndpointRef ref, EndpointRef resRef, TCall* call);
extern pascal OSStatus	OTSndDisconnect(EndpointRef ref, TCall* call);
extern pascal OSStatus	OTSndOrderlyDisconnect(EndpointRef ref);
extern pascal OSStatus	OTRcvDisconnect(EndpointRef ref, TDiscon* discon);
extern pascal OSStatus	OTRcvOrderlyDisconnect(EndpointRef ref);
//
// Connection-oriented send/receive
//
extern pascal OTResult	OTRcv(EndpointRef ref, void* buf, size_t nbytes, OTFlags* flags);
extern pascal OTResult	OTSnd(EndpointRef ref, void* buf, size_t nbytes, OTFlags flags);
//
// non-connection oriented send/receive
//
extern pascal OSStatus	OTSndUData(EndpointRef ref, TUnitData* udata);
extern pascal OSStatus	OTRcvUData(EndpointRef ref, TUnitData* udata, OTFlags* flags);
extern pascal OSStatus	OTRcvUDErr(EndpointRef ref, TUDErr* uderr);
//
// Connection-oriented transactions
//
extern pascal OSStatus	OTSndRequest(EndpointRef ref, TRequest* req, OTFlags reqFlags);
extern pascal OSStatus	OTRcvReply(EndpointRef ref, TReply* reply, OTFlags* replyFlags);
extern pascal OSStatus	OTSndReply(EndpointRef ref, TReply* reply, OTFlags replyFlags);
extern pascal OSStatus	OTRcvRequest(EndpointRef ref, TRequest* req, OTFlags* reqFlags);
extern pascal OSStatus	OTCancelRequest(EndpointRef ref, OTSequence sequence);
extern pascal OSStatus	OTCancelReply(EndpointRef ref, OTSequence sequence);
//
// Connectionless transactions
//
extern pascal OSStatus	OTSndURequest(EndpointRef ref, TUnitRequest* req, OTFlags reqFlags);
extern pascal OSStatus	OTRcvUReply(EndpointRef ref, TUnitReply* reply, OTFlags* replyFlags);
extern pascal OSStatus	OTSndUReply(EndpointRef ref, TUnitReply* reply, OTFlags replyFlags);
extern pascal OSStatus	OTRcvURequest(EndpointRef ref, TUnitRequest* req, OTFlags* reqFlags);
extern pascal OSStatus	OTCancelURequest(EndpointRef ref, OTSequence seq);
extern pascal OSStatus	OTCancelUReply(EndpointRef ref, OTSequence seq);

/*	-------------------------------------------------------------------------
	Interface to mappers
	------------------------------------------------------------------------- */

extern pascal OSStatus 	OTAsyncOpenMapper(OTConfiguration* config, OTOpenFlags oflag,
										  OTNotifyProcPtr proc, void* contextPtr);			
extern pascal MapperRef	OTOpenMapper(OTConfiguration* config, OTOpenFlags oflag,
									 OSStatus* err);	
extern pascal OSStatus	OTRegisterName(MapperRef ref, TRegisterRequest* req,
									   TRegisterReply* reply);
extern pascal OSStatus	OTDeleteName(MapperRef ref, TNetbuf* name);
extern pascal OSStatus	OTDeleteNameByID(MapperRef ref, OTNameID nameID);
extern pascal OSStatus	OTLookupName(MapperRef ref, TLookupRequest* req,
									 TLookupReply* reply);

/*	-------------------------------------------------------------------------
	Miscellaneous and generic functions
	------------------------------------------------------------------------- */

extern void*			OTAllocMem(size_t);
extern void				OTFreeMem(void*);
extern pascal void		OTDelay(UInt32 seconds);
extern pascal void		OTIdle(void);

extern pascal OTConfiguration*	
						OTCreateConfiguration(const char* path);
extern pascal OTConfiguration*
						OTCloneConfiguration(OTConfiguration* cfig);
extern pascal void		OTDestroyConfiguration(OTConfiguration* cfig);
extern pascal OSStatus	OTCreateOptions(const char* endPtName, char** strPtr,
										TNetbuf* buf);
extern pascal OSStatus	OTCreateOptionString(const char* endPtName, TOption** opt,
											 void* bufEnd, char* string,
											 size_t stringSize);

extern pascal OSStatus	OTNextOption(UInt8* buffer, UInt32 buflen,
									 TOption** prevOptPtr);
extern pascal TOption*	OTFindOption(UInt8* buffer, UInt32 buflen,
									 OTXTILevel level, OTXTIName name); 
		
#endif	/* !OTKERNEL	*/

/*******************************************************************************
** Open Transport Utility routines
**
** These routines are available to both client and kernel
********************************************************************************/

/*	-------------------------------------------------------------------------
	** Memory functions
	------------------------------------------------------------------------- */

extern void		OTMemcpy(void* dest, const void* src, size_t nBytes);
extern Boolean	OTMemcmp(const void* mem1, const void* mem2, size_t nBytes);
extern void		OTMemmove(void* dest, const void* src, size_t nBytes);
extern void		OTMemzero(void* dest, size_t nBytes);
extern void		OTMemset(void* dest, uchar_p toSet, size_t nBytes);
extern size_t	OTStrLength(const char*);
extern void		OTStrCopy(char*, const char*);
extern void		OTStrCat(char*, const char*);
extern Boolean	OTStrEqual(const char*, const char*);

/*	-------------------------------------------------------------------------
	** Time functions
	**	
	**	OTGetTimeStamp returns time in "tick" numbers, stored in 64 bits.
	**	This timestamp can be used as a base number for calculating elapsed 
	**	time.
	**	OTSubtractTimeStamps returns a pointer to the "result" parameter.
	**		
	**	OTGetClockTimeInSecs returns time since Open Transport was initialized
	**		in seconds.
	------------------------------------------------------------------------- */
	
typedef UnsignedWide	OTTimeStamp;

extern void			OTGetTimeStamp(OTTimeStamp*);
extern OTTimeStamp*	OTSubtractTimeStamps(OTTimeStamp* result, OTTimeStamp* start,
										 OTTimeStamp* end);
extern UInt32		OTTimeStampInMilliseconds(OTTimeStamp* delta);
extern UInt32		OTTimeStampInMicroseconds(OTTimeStamp* delta);
extern UInt32		OTElapsedMilliseconds(OTTimeStamp* startTime);
extern UInt32		OTElapsedMicroseconds(OTTimeStamp* startTime);

extern UInt32		OTGetClockTimeInSecs(void);

/*	-------------------------------------------------------------------------
	** OTLIFO
	**
	** These are functions to implement a LIFO list that is interrupt-safe.
	** The only function which is not is OTReverseList.  Normally, you create
	** a LIFO list, populate it at interrupt time, and then use OTLIFOStealList
	** to atomically remove the list, and OTReverseList to flip the list so that
	** it is a FIFO list, which tends to be more useful.
	------------------------------------------------------------------------- */

typedef struct OTLink	OTLink;
typedef struct OTLIFO	OTLIFO;

struct OTLink
{
	OTLink*	fNext;
	
#ifdef __cplusplus
			void	Init()
						{ fNext = NULL; }
#endif
};

	//
	// This function puts "object" on the listHead, and places the
	// previous value at listHead into the pointer at "object" plus
	// linkOffset.
	//
extern void		OTEnqueue(void** listHead, void* object, size_t linkOffset);
	//
	// This function returns the head object of the list, and places
	// the pointer at "object" + linkOffset into the listHead
	//
extern void*	OTDequeue(void** listHead, size_t linkOffset);
	//
	// This function atomically enqueues the link onto the list
	//
extern void 	OTLIFOEnqueue(OTLIFO* list, OTLink* link);
	//
	// This function atomically dequeues the first element
	// on the list
	//
extern OTLink* OTLIFODequeue(OTLIFO* list);
	//
	// This function atomically empties the list and returns a
	// pointer to the first element on the list
	//
extern OTLink*	OTLIFOStealList(OTLIFO* list);
	//
	// This function reverses a list that was stolen by
	// OTLIFOStealList.  It is NOT atomic.  It returns the
	// new starting list.
	//
extern OTLink*	OTReverseList(OTLink*);

struct OTLIFO
{
	OTLink*	fHead;
	
#ifdef __cplusplus
				void	Init()	
							{ fHead = NULL; }
				
				void	Enqueue(OTLink* link)
							{ OTLIFOEnqueue(this, link); }
							
				OTLink*	Dequeue()
							{ return OTLIFODequeue(this); }
							
				OTLink*	StealList()
							{ return OTLIFOStealList(this); }
							
				Boolean	IsEmpty()
							{ return fHead == NULL; }
#endif
};

/*	-------------------------------------------------------------------------
	** OTList
	**
	** An OTList is a non-interrupt-safe list, but has more features than the
	** OTLIFO list. It is a standard singly-linked list.
	------------------------------------------------------------------------- */

typedef struct OTList	OTList;

	/*
	 * Function definition to handle notification from providers
	 *
	 * For PowerPC, this should never be a UniversalProcPtr.
	 * For standard 68K runtime, this should never be a UniversalProcPtr.
	 * For CFM68K, it MUST be a UniversalProcPtr.
	 */
	typedef Boolean (*OTListSearchProcPtr)(const void* ref, OTLink* linkToCheck);
	//
	// Add the link to the list at the front
	//
extern void 		OTAddFirst(OTList* list, OTLink* link);
	//
	// Add the link to the list at the end
	//
extern void 		OTAddLast(OTList* list, OTLink* link);
	//
	// Remove the first link from the list
	//
extern OTLink*		OTRemoveFirst(OTList* list);
	//
	// Remove the last link from the list
	//
extern OTLink*		OTRemoveLast(OTList* list);
	//
	// Return the first link from the list
	//
extern OTLink*		OTGetFirst(OTList* list);
	//
	// Return the last link from the list
	//
extern OTLink*		OTGetLast(OTList* list);
	//
	// Return true if the link is present in the list
	//
extern Boolean		OTIsInList(OTList* list, OTLink* link);
	//
	// Find a link in the list which matches the search criteria
	// established by the search proc and the refPtr.  This is done
	// by calling the search proc, passing it the refPtr and each
	// link in the list, until the search proc returns true.
	// NULL is returned if the search proc never returned true.
	//
extern OTLink*		OTFindLink(OTList* list, OTListSearchProcPtr proc, const void* refPtr);
	//
	// Remove the specified link from the list, returning true if it was found
	//
extern Boolean		OTRemoveLink(OTList*, OTLink*);
	//
	// Similar to OTFindLink, but it also removes it from the list.
	//
extern OTLink*		OTFindAndRemoveLink(OTList* list, OTListSearchProcPtr proc, const void* refPtr);
	//
	// Return the "index"th link in the list
	//
extern OTLink*		OTGetIndexedLink(OTList* list, size_t index);

struct OTList
{
	OTLink*		fHead;
	
#ifdef __cplusplus
			void		Init()	
							{ fHead = NULL; }
			
			Boolean		IsEmpty()
							{ return fHead == NULL; }
							
			void		AddFirst(OTLink* link)
							{ OTAddFirst(this, link); }
			
			void		AddLast(OTLink* link)
							{ OTAddLast(this, link); }
			
			OTLink*		GetFirst()
							{ return OTGetFirst(this); }
			
			OTLink*		GetLast()
							{ return OTGetLast(this); }
			
			OTLink*		RemoveFirst()
							{ return OTRemoveFirst(this); }
			
			OTLink*		RemoveLast()
							{ return OTRemoveLast(this); }
							
			Boolean		IsInList(OTLink* link)
							{ return OTIsInList(this, link); }
							
			OTLink*		FindLink(OTListSearchProcPtr proc, const void* ref)
							{ return OTFindLink(this, proc, ref); }
							
			Boolean		RemoveLink(OTLink* link)
							{ return OTRemoveLink(this, link); }
							
			OTLink*		RemoveLink(OTListSearchProcPtr proc, const void* ref)
							{ return OTFindAndRemoveLink(this, proc, ref); }
							
			OTLink*		GetIndexedLink(size_t index)
							{ return OTGetIndexedLink(this, index); }
#endif
};

#define OTGetLinkObject(link, struc, field)	\
	((struc*)((char*)(link) - offsetof(struc, field)))

/*	-------------------------------------------------------------------------
	** Atomic Operations
	**
	** The Bit operations return the previous value of the bit (0 or non-zero).
	** The memory pointed to must be a single byte and only bits 0 through 7 are
	** valid.  Bit 0 corresponds to a mask of 0x01, and Bit 7 to a mask of 0x80.
	------------------------------------------------------------------------- */

typedef UInt8	OTLock;

#if GENERATING68K

#pragma parameter __D0 OTAtomicSetBit(__A0, __D0)
Boolean OTAtomicSetBit(UInt8*, size_t) =
{
	0x01d0, 0x56c0,	/* bset.b d0,(a0); sne d0 */
	0x7201, 0xc081	/* moveq #1,d1; and.l d1,d0 */
};
	
#pragma parameter __D0 OTAtomicClearBit(__A0, __D0)
Boolean OTAtomicClearBit(UInt8*, size_t) =
{
	0x0190, 0x56c0,	/* bclr.b d0,(a0); sne d0 */
	0x7201, 0xc081	/* moveq #1,d1; and.l d1,d0 */
};
	
#pragma parameter __D0 OTAtomicTestBit(__A0, __D0)
Boolean OTAtomicTestBit(UInt8*, size_t) =
{
	0x0110, 0x56c0,	/* btst.b d0,(a0); sne d0 */
	0x7201, 0xc081	/* moveq #1,d1; and.l d1,d0 */
};

#pragma parameter __D0 OTCompareAndSwapPtr(__D0, __D1, __A0)
Boolean OTCompareAndSwapPtr(void*, void*, void**) =
{
	0x0ed0, 0x0040,		/*	cas.l	d0,d1,(a0)	*/
	0x57c0,				/*	seq		d0			*/
	0x7201, 0xc081		/* moveq #1,d1; and.l d1,d0 */
};

#pragma parameter __D0 OTCompareAndSwap32(__D0, __D1, __A0)
Boolean OTCompareAndSwap32(UInt32, UInt32, UInt32*) =
{
	0x0ed0, 0x0040,		/*	cas.l	d0,d1,(a0)	*/
	0x57c0,				/*	seq		d0			*/
	0x7201, 0xc081		/* moveq #1,d1; and.l d1,d0 */
};

#pragma parameter __D0 OTCompareAndSwap16(__D0, __D1, __A0)
Boolean OTCompareAndSwap16(UInt32, UInt32, UInt16*) =
{
	0x0cd0, 0x0040,		/*	cas.w	d0,d1,(a0)	*/
	0x57c0,				/*	seq		d0			*/
	0x7201, 0xc081		/* moveq #1,d1; and.l d1,d0 */
};

#pragma parameter __D0 OTCompareAndSwap8(__D0, __D1, __A0)
Boolean OTCompareAndSwap8(UInt32, UInt32, UInt8*) =
{
	0x0ad0, 0x0040,		/*	cas.b	d0,d1,(a0)	*/
	0x57c0,				/*	seq		d0			*/
	0x7201, 0xc081		/* moveq #1,d1; and.l d1,d0 */
};

#pragma parameter __D0 OTAtomicAdd32(__D0, __A0)
SInt32 OTAtomicAdd32(SInt32, SInt32*) =
{
	0x2240,				/* 		move.l	d0,a1		*/
	0x2210,				/*@1	move.l	(a0),d1		*/
	0x2001,				/*		move.l	d1,d0		*/
	0xd089,				/*		add.l	a1,d0		*/
	0x0ed0, 0x0001,		/*		cas.l	d1,d0,(a0)	*/
	0x66f4				/*		bne.s	@1			*/
};
		
#elif GENERATINGPOWERPC

extern Boolean OTAtomicSetBit(UInt8*, size_t);
extern Boolean OTAtomicClearBit(UInt8*, size_t);
extern Boolean OTAtomicTestBit(UInt8*, size_t);
//
// WARNING! void* and UInt32 locations MUST be on 4-byte boundaries.
//			UInt16 locations must not cross a 4-byte boundary.
//
extern Boolean	OTCompareAndSwapPtr(void* oldValue, void* newValue, void** location);
extern Boolean	OTCompareAndSwap32(UInt32 oldValue, UInt32 newValue, UInt32* location);
extern Boolean	OTCompareAndSwap16(UInt32 oldValue, UInt32 newValue, UInt16* location);
extern Boolean	OTCompareAndSwap8(UInt32 oldValue, UInt32 newValue, UInt8* location);
//
// WARNING! UInt32 locations MUST be on 4-byte boundaries.
//			UInt16 locations must not cross a 4-byte boundary.
//
extern SInt32	OTAtomicAdd32(SInt32, SInt32*);

#endif

extern SInt16	OTAtomicAdd16(SInt32, SInt16*);
extern SInt8	OTAtomicAdd8(SInt32, SInt8*);

#define OTClearLock(lockPtr)	*(lockPtr) = 0
#define OTAcquireLock(lockPtr)	(OTAtomicSetBit(lockPtr, 0) == 0)

#ifdef __cplusplus
}
#endif

/*******************************************************************************
**
** FROM HERE ON DOWN ARE THE C++ Interfaces to Open Transport
**
********************************************************************************/

#ifdef __cplusplus

/*	-------------------------------------------------------------------------
	CLASS TProvider
	
	This class provides the client interface to a Stream.  Typically, clients
	talk to an object (or glue code in front of the object) that is a subclass
	of TProvider.
	------------------------------------------------------------------------- */

#if !OTKERNEL

class TProvider
{
	private:
		void*		operator new(size_t)	{ return NULL; }
		void		operator delete(void*)	{}
		
	//
	// This is the public interface to a TProvider.  All other public
	// methods normally come from the subclass.
	//
	public:	
		OSStatus	Close()				{ return OTCloseProvider(this); }

		OSStatus	SetNonBlocking()	{ return OTSetNonBlocking(this); }
		OSStatus	SetBlocking()		{ return OTSetBlocking(this); }
		Boolean		IsBlocking()		{ return OTIsBlocking(this); }
		Boolean		IsNonBlocking()		{ return !OTIsBlocking(this); }
		OSStatus	SetSynchronous()	{ return OTSetSynchronous(this); }
		OSStatus	SetAsynchronous()	{ return OTSetAsynchronous(this); }
		Boolean		IsSynchronous()		{ return OTIsSynchronous(this); }
		Boolean		IsAsynchronous()	{ return !OTIsSynchronous(this); }
		
		OSStatus	AckSends()			{ return OTAckSends(this); }
		OSStatus	DontAckSends()		{ return OTDontAckSends(this); }
		Boolean		IsAckingSends()		{ return OTIsAckingSends(this); }

		void		CancelSynchronousCalls(OSStatus err)
					{ (void)OTCancelSynchronousCalls(this, err); }

		OSStatus	InstallNotifier(OTNotifyProcPtr proc, void* ptr)
					{ return OTInstallNotifier(this, proc, ptr); }

		OSStatus	UseSyncIdleEvents()
					{ return OTUseSyncIdleEvents(this, true); }

		OSStatus	DontUseSyncIdleEvents()
					{ return OTUseSyncIdleEvents(this, false); }
					
		void		RemoveNotifier()
					{ OTRemoveNotifier(this); }
		
		Boolean		EnterNotifier()
					{ return OTEnterNotifier(this); }
					
		void		LeaveNotifier()
					{ OTLeaveNotifier(this); }
					
		OTPortRef	GetOTPortRef()
					{ return OTGetProviderPortRef(this); }
					
		ProviderRef	TransferOwnership(OTClient prevOwner, OSStatus* errPtr)
					{ return OTTransferProviderOwnership(this, prevOwner, errPtr); }
					
		SInt32		Ioctl(UInt32 cmd, void* data)
					{ return OTIoctl(this, cmd, data); }
		SInt32		Ioctl(UInt32 cmd, long data)
					{ return OTIoctl(this, cmd, (void*)data); }
					
		OTResult	GetMessage(struct strbuf* ctlbuf, struct strbuf* databuf, OTFlags* flagPtr)
					{ return OTGetMessage(this, ctlbuf, databuf, flagPtr); }
		OTResult	GetPriorityMessage(struct strbuf* ctlbuf, struct strbuf* databuf,
									   OTBand* bandPtr, OTFlags* flagPtr)
					{ return OTGetPriorityMessage(this, ctlbuf, databuf, bandPtr, flagPtr); }
		OSStatus	PutMessage(const struct strbuf* ctlbuf, const struct strbuf* databuf,
							   OTFlags flags)
					{ return OTPutMessage(this, ctlbuf, databuf, flags); }
		OSStatus	PutPriorityMessage(const struct strbuf* ctlbuf, const struct strbuf* databuf,
									   OTBand band, OTFlags flags)
					{ return OTPutPriorityMessage(this, ctlbuf, databuf, band, flags); }
					
};
		
/*	-------------------------------------------------------------------------
	Class TEndpoint
	
	This class is the interface to all TPI modules, which constitute the
	vast majority of protocols, with the exception of link-layer protocols.
	------------------------------------------------------------------------- */

class TEndpoint : public TProvider
{
	public:
	//
	// Miscellaneous informative functions
	//
		OSStatus	GetEndpointInfo(TEndpointInfo* info)
					{ return OTGetEndpointInfo(this, info); }
					
		OSStatus	GetProtAddress(TBind* boundAddr, TBind* peerAddr)
					{ return OTGetProtAddress(this, boundAddr, peerAddr); }
					
		OSStatus	ResolveAddress(TBind* reqAddr, TBind* retAddr, OTTimeout timeout)
					{ return OTResolveAddress(this, reqAddr, retAddr, timeout); }
					
		OTResult	GetEndpointState()		
					{ return OTGetEndpointState(this); }
					
		OTResult	Look()
					{ return OTLook(this); }
					
		OTResult	Sync()
					{ return OTSync(this); }
	//
	// Allocating structures
	//
		void*		Alloc(OTStructType structType, UInt32 fields, OSStatus* err = NULL)
					{ return OTAlloc(this, structType, fields, err); }
					
		OTResult	Free(void* ptr, OTStructType structType)
					{ return OTFree(ptr, structType); }
	//
	// Option Management
	//
		OSStatus	OptionManagement(TOptMgmt* req, TOptMgmt* ret)
					{ return OTOptionManagement(this, req, ret); }
	//
	// Bind/Unbind
	//
		OSStatus	Bind(TBind* reqAddr, TBind* retAddr)
					{ return OTBind(this, reqAddr, retAddr); }
					
		OSStatus	Unbind()
					{ return OTUnbind(this); }
	//
	// Connection creation and tear-down
	//
		OSStatus	Connect(TCall* sndCall, TCall* rcvCall)
					{ return OTConnect(this, sndCall, rcvCall); }
					
		OSStatus	RcvConnect(TCall* call)
					{ return OTRcvConnect(this, call); }
					
		OSStatus	Listen(TCall* call)
					{ return OTListen(this, call); }
					
		OSStatus	Accept(EndpointRef resRef, TCall* call)
					{ return OTAccept(this, resRef, call); }
					
		OSStatus	SndDisconnect(TCall* call)
					{ return OTSndDisconnect(this, call); }
					
		OSStatus	SndOrderlyDisconnect()
					{ return OTSndOrderlyDisconnect(this); }
					
		OSStatus	RcvDisconnect(TDiscon* discon)
					{ return OTRcvDisconnect(this, discon); }
					
		OSStatus	RcvOrderlyDisconnect()
					{ return OTRcvOrderlyDisconnect(this); }
	//
	// Connection-oriented data transfer
	//
		OTResult	Snd(void* buf, size_t nbytes, OTFlags flags)
					{ return OTSnd(this, buf, nbytes, flags); }
					
		OTResult	Rcv(void* buf, size_t nbytes, OTFlags* flagP)
					{ return OTRcv(this, buf, nbytes, flagP); }
	//
	// Non-connection-oriented data transfer
	//
		OSStatus	SndUData(TUnitData* udata)
					{ return OTSndUData(this, udata); }
					
		OSStatus	RcvUData(TUnitData* udata, OTFlags* flagP)
					{ return OTRcvUData(this, udata, flagP); }
					
		OSStatus	RcvUDErr(TUDErr* uderr)
					{ return OTRcvUDErr(this, uderr); }
	//
	// Connection-oriented transactions
	//
		OSStatus	SndRequest(TRequest* req, OTFlags reqFlags)
					{ return OTSndRequest(this, req, reqFlags); }

		OSStatus	RcvReply(TReply* reply, OTFlags* replyFlags)
					{ return OTRcvReply(this, reply, replyFlags); }
					
		OSStatus	SndReply(TReply* reply, OTFlags flags)
					{ return OTSndReply(this, reply, flags); }
					
		OSStatus	RcvRequest(TRequest* req, OTFlags* flags)
					{ return OTRcvRequest(this, req, flags); }
					
		OSStatus	CancelRequest(OTSequence seq)
					{ return OTCancelRequest(this, seq); }
					
		OSStatus	CancelReply(OTSequence seq)
					{ return OTCancelReply(this, seq); }
	//
	// Non-connection-oriented transactions
	//
		OSStatus	SndURequest(TUnitRequest* req, OTFlags reqFlags)
					{ return OTSndURequest(this, req, reqFlags); }

		OSStatus	RcvUReply(TUnitReply* reply, OTFlags* replyFlags)
					{ return OTRcvUReply(this, reply, replyFlags); }
					
		OSStatus	SndUReply(TUnitReply* reply, OTFlags flags)
					{ return OTSndUReply(this, reply, flags); }
					
		OSStatus	RcvURequest(TUnitRequest* req, OTFlags* flags)
					{ return OTRcvURequest(this, req, flags); }
					
		OSStatus	CancelURequest(OTSequence seq)
					{ return OTCancelURequest(this, seq); }
					
		OSStatus	CancelUReply(OTSequence seq)
					{ return OTCancelUReply(this, seq); }
	//
	// Miscellaneous functions
	//
		OTResult	CountDataBytes(size_t* countPtr)
					{ return OTCountDataBytes(this, countPtr); }
};

/*	-------------------------------------------------------------------------
	CLASS TMapper
	
	This class is the interface to naming protocols.
	------------------------------------------------------------------------- */

class TMapper : public TProvider
{
	public:
		OSStatus	RegisterName(TRegisterRequest* req, TRegisterReply* reply)
					{ return OTRegisterName(this, req, reply); }
				
		OSStatus	DeleteName(TNetbuf* name)
					{ return OTDeleteName(this, name); }
				
		OSStatus	DeleteName(OTNameID id)	
					{ return OTDeleteNameByID(this, id); }
				
		OSStatus	LookupName(TLookupRequest* req, TLookupReply* reply)
					{ return OTLookupName(this, req, reply); }
};
	
#endif	/* OTKERNEL	*/
#endif	/* __cplusplus */

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif
#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if GENERATING68K && defined(__MWERKS__)
#pragma pointers_in_A0
#endif

#endif	/* __OPENTRANSPORT__ */


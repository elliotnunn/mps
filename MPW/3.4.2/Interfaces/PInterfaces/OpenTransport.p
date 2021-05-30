{
 	File:		OpenTransport.p
 
 	Contains:	OpenTransport interfaces
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
 				All rights reserved.
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT OpenTransport;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OPENTRANSPORT__}
{$SETC __OPENTRANSPORT__ := 1}

{$I+}
{$SETC OpenTransportIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$SETC SystemSevenOrLater := 1 }
{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{
	-------------------------------------------------------------------------
	Some Typedefs for Pascal
	------------------------------------------------------------------------- 
}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	size_t								= LONGINT;
{$SETC NULL := 0 }
	uchar_p								= LONGINT;
	ushort_p							= LONGINT;
	short_p								= LONGINT;
	char_p								= LONGINT;
	boolean_p							= LONGINT;
	int_t								= LONGINT;
	uint_t								= LONGINT;
{$IFC UNDEFINED OTKERNEL }
{$SETC OTKERNEL := 0 }
{$ENDC}
{$IFC UNDEFINED OTUNIXERRORS }
{$SETC OTUNIXERRORS := 0 }
{$ENDC}
{
******************************************************************************
** Gestalt values for Open Transport
*******************************************************************************
}

CONST
	gestaltOpenTptVersions		= 'otvr';
	gestaltOpenTpt				= 'otan';
	gestaltOpenTptPresentMask	= $00000001;
	gestaltOpenTptLoadedMask	= $00000002;
	gestaltOpenTptAppleTalkPresentMask = $00000004;
	gestaltOpenTptAppleTalkLoadedMask = $00000008;
	gestaltOpenTptTCPPresentMask = $00000010;
	gestaltOpenTptTCPLoadedMask	= $00000020;
	gestaltOpenTptIPXSPXPresentMask = $00000040;
	gestaltOpenTptIPXSPXLoadedMask = $00000080;
	gestaltOpenTptPresentBit	= 0;
	gestaltOpenTptLoadedBit		= 1;
	gestaltOpenTptAppleTalkPresentBit = 2;
	gestaltOpenTptAppleTalkLoadedBit = 3;
	gestaltOpenTptTCPPresentBit	= 4;
	gestaltOpenTptTCPLoadedBit	= 5;
	gestaltOpenTptIPXSPXPresentBit = 6;
	gestaltOpenTptIPXSPXLoadedBit = 7;

{
******************************************************************************
** Some prefixes for shared libraries
*******************************************************************************
}
	kOTLibraryVersion	=	'1.1';
	kOTLibraryPrefix	=	'OTLib$';
	kOTModulePrefix		=	'OTModl$';
	kOTKernelPrefix		=	'OTKrnl$';
	kOTClientPrefix		=	'OTClnt$';
{
******************************************************************************
** Some typedefs used by the OpenTransport system
*******************************************************************************
}
{
	-------------------------------------------------------------------------
	Miscellaneous typedefs
	------------------------------------------------------------------------- 
}

TYPE
	OTTimeout							= UInt32;
	OTSequence							= LONGINT;
	OTNameID							= LONGINT;
	OTReason							= SInt32;
	OTQLen								= UInt32;
	OTClient							= Ptr;
	OTClientName						= ^UInt8;
	OTCommand							= LONGINT;
	CStringPtrPtr						= ^CStringPtr;
{
	-------------------------------------------------------------------------
	OTOpenFlags - flags used for opening providers
	------------------------------------------------------------------------- 
}
	OTOpenFlags							= UInt32;

CONST
	O_ASYNC						= $01;
	O_NDELAY					= $04;
	O_NONBLOCK					= $04;

{
	-------------------------------------------------------------------------
	StdCLib-style Error codes
	------------------------------------------------------------------------- 
}

TYPE
	OTUnixErr							= UInt16;
{$IFC OTKERNEL OR OTUNIXERRORS }
{
		 * There may be some error code confusions with other compiler vendor header
		 * files - However, these match both MPW and AIX definitions.
		 * We undefine the #defined ones we know about so that we can put them
		 * in an enum.
}

CONST
	EPERM						= 1;							{  Permission denied					 }
	ENOENT						= 2;							{  No such file or directory			 }
	ENORSRC						= 3;							{  No such resource						 }
	EINTR						= 4;							{  Interrupted system service			 }
	EIO							= 5;							{  I/O error							 }
	ENXIO						= 6;							{  No such device or address			 }
	EBADF						= 9;							{  Bad file number						 }
	EAGAIN						= 11;							{  Try operation again later			 }
	ENOMEM						= 12;							{  Not enough space						 }
	EACCES						= 13;							{  Permission denied					 }
	EFAULT						= 14;							{  Bad address							 }
	EBUSY						= 16;							{  Device or resource busy				 }
	EEXIST						= 17;							{  File exists							 }
	ENODEV						= 19;							{  No such device						 }
	EINVAL						= 22;							{  Invalid argument						 }
	ENOTTY						= 25;							{  Not a character device				 }
	EPIPE						= 32;							{  Broken pipe							 }
	ERANGE						= 34;							{  Math result not representable		 }
	EDEADLK						= 35;							{  Call would block so was aborted		 }
	EWOULDBLOCK					= 35;							{  Or a deadlock would occur			 }
	EALREADY					= 37;
	ENOTSOCK					= 38;							{  Socket operation on non-socket		 }
	EDESTADDRREQ				= 39;							{  Destination address required			 }
	EMSGSIZE					= 40;							{  Message too long						 }
	EPROTOTYPE					= 41;							{  Protocol wrong type for socket		 }
	ENOPROTOOPT					= 42;							{  Protocol not available				 }
	EPROTONOSUPPORT				= 43;							{  Protocol not supported				 }
	ESOCKTNOSUPPORT				= 44;							{  Socket type not supported			 }
	EOPNOTSUPP					= 45;							{  Operation not supported on socket	 }
	EADDRINUSE					= 48;							{  Address already in use				 }
	EADDRNOTAVAIL				= 49;							{  Can't assign requested address		 }
	ENETDOWN					= 50;							{  Network is down						 }
	ENETUNREACH					= 51;							{  Network is unreachable				 }
	ENETRESET					= 52;							{  Network dropped connection on reset	 }
	ECONNABORTED				= 53;							{  Software caused connection abort		 }
	ECONNRESET					= 54;							{  Connection reset by peer				 }
	ENOBUFS						= 55;							{  No buffer space available			 }
	EISCONN						= 56;							{  Socket is already connected			 }
	ENOTCONN					= 57;							{  Socket is not connected				 }
	ESHUTDOWN					= 58;							{  Can't send after socket shutdown		 }
	ETOOMANYREFS				= 59;							{  Too many references: can't splice	 }
	ETIMEDOUT					= 60;							{  Connection timed out					 }
	ECONNREFUSED				= 61;							{  Connection refused					 }
	EHOSTDOWN					= 64;							{  Host is down							 }
	EHOSTUNREACH				= 65;							{  No route to host						 }
	EPROTO						= 70;
	ETIME						= 71;
	ENOSR						= 72;
	EBADMSG						= 73;
	ECANCEL						= 74;
	ENOSTR						= 75;
	ENODATA						= 76;
	EINPROGRESS					= 77;
	ESRCH						= 78;
	ENOMSG						= 79;
	ELASTERRNO					= 79;

{$ENDC}
{
	-------------------------------------------------------------------------
	Open Transport/XTI Error codes
	------------------------------------------------------------------------- 
}

TYPE
	OTXTIErr							= UInt16;

CONST
	TSUCCESS					= 0;							{  No Error occurred						 }
	TBADADDR					= 1;							{  A Bad address was specified				 }
	TBADOPT						= 2;							{  A Bad option was specified				 }
	TACCES						= 3;							{  Missing access permission				 }
	TBADF						= 4;							{  Bad provider reference					 }
	TNOADDR						= 5;							{  No address was specified					 }
	TOUTSTATE					= 6;							{  Call issued in wrong state				 }
	TBADSEQ						= 7;							{  Sequence specified does not exist		 }
	TSYSERR						= 8;							{  A system error occurred					 }
	TLOOK						= 9;							{  An event occurred - call Look()			 }
	TBADDATA					= 10;							{  An illegal amount of data was specified	 }
	TBUFOVFLW					= 11;							{  Passed buffer not big enough				 }
	TFLOW						= 12;							{  Provider is flow-controlled				 }
	TNODATA						= 13;							{  No data available for reading			 }
	TNODIS						= 14;							{  No disconnect indication available		 }
	TNOUDERR					= 15;							{  No Unit Data Error indication available	 }
	TBADFLAG					= 16;							{  A Bad flag value was supplied			 }
	TNOREL						= 17;							{  No orderly release indication available	 }
	TNOTSUPPORT					= 18;							{  Command is not supported					 }
	TSTATECHNG					= 19;							{  State is changing - try again later		 }
	TNOSTRUCTYPE				= 20;							{  Bad structure type requested for OTAlloc	 }
	TBADNAME					= 21;							{  A bad endpoint name was supplied			 }
	TBADQLEN					= 22;							{  A Bind to an in-use address with qlen > 0 }
	TADDRBUSY					= 23;							{  Address requested is already in use		 }
	TINDOUT						= 24;							{  Accept failed because of pending listen	 }
	TPROVMISMATCH				= 25;							{  Tried to accept on incompatible endpoint	 }
	TRESQLEN					= 26;
	TRESADDR					= 27;
	TQFULL						= 28;
	TPROTO						= 29;							{  An unspecified provider error occurred	 }
	TBADSYNC					= 30;							{  A synchronous call at interrupt time		 }
	TCANCELED					= 31;							{  The command was cancelled				 }
	TLASTXTIERROR				= 31;

{
	-------------------------------------------------------------------------
	Standard negative error codes conforming to both the Open Transport/XTI
	errors and the Exxxxx StdCLib errors.
	These are returned as OSStatus' from functions, and to the OTResult parameter
	of a notification function or method.  However, OTResult may sometimes
	contain other values depending on the notification.
	------------------------------------------------------------------------- 
}

TYPE
	OTResult							= SInt32;
{
		 * These map the Open Transport/XTI errors (the Txxxx error codes), and the
		 * StdCLib Exxxx error codes into unique spaces in the Apple OSStatus space.
}

CONST
	kOTNoError					= 0;							{  No Error occurred						 }
	kOTOutOfMemoryErr			= -3211;
	kOTNotFoundErr				= -3201;
	kOTDuplicateFoundErr		= -3216;
	kOTBadAddressErr			= -3150;						{  -3150 A Bad address was specified				 }
	kOTBadOptionErr				= -3151;						{  -3151 A Bad option was specified					 }
	kOTAccessErr				= -3152;						{  -3152 Missing access permission					 }
	kOTBadReferenceErr			= -3153;						{  -3153 Bad provider reference						 }
	kOTNoAddressErr				= -3154;						{  -3154 No address was specified					 }
	kOTOutStateErr				= -3155;						{  -3155 Call issued in wrong state					 }
	kOTBadSequenceErr			= -3156;						{  -3156 Sequence specified does not exist			 }
	kOTSysErrorErr				= -3157;						{  -3157 A system error occurred					 }
	kOTLookErr					= -3158;						{  -3158 An event occurred - call Look()			 }
	kOTBadDataErr				= -3159;						{  -3159 An illegal amount of data was specified	 }
	kOTBufferOverflowErr		= -3160;						{  -3160 Passed buffer not big enough				 }
	kOTFlowErr					= -3161;						{  -3161 Provider is flow-controlled				 }
	kOTNoDataErr				= -3162;						{  -3162 No data available for reading				 }
	kOTNoDisconnectErr			= -3163;						{  -3163 No disconnect indication available			 }
	kOTNoUDErrErr				= -3164;						{  -3164 No Unit Data Error indication available	 }
	kOTBadFlagErr				= -3165;						{  -3165 A Bad flag value was supplied				 }
	kOTNoReleaseErr				= -3166;						{  -3166 No orderly release indication available	 }
	kOTNotSupportedErr			= -3167;						{  -3167 Command is not supported					 }
	kOTStateChangeErr			= -3168;						{  -3168 State is changing - try again later		 }
	kOTNoStructureTypeErr		= -3169;						{  -3169 Bad structure type requested for OTAlloc	 }
	kOTBadNameErr				= -3170;						{  -3170 A bad endpoint name was supplied			 }
	kOTBadQLenErr				= -3171;						{  -3171 A Bind to an in-use addr with qlen > 0		 }
	kOTAddressBusyErr			= -3172;						{  -3172 Address requested is already in use		 }
	kOTIndOutErr				= -3173;						{  -3173 Accept failed because of pending listen	 }
	kOTProviderMismatchErr		= -3174;						{  -3174 Tried to accept on incompatible endpoint	 }
	kOTResQLenErr				= -3175;						{  -3175											 }
	kOTResAddressErr			= -3176;						{  -3176											 }
	kOTQFullErr					= -3177;						{  -3177											 }
	kOTProtocolErr				= -3178;						{  -3178 An unspecified provider error occurred		 }
	kOTBadSyncErr				= -3179;						{  -3179 A synchronous call at interrupt time		 }
	kOTCanceledErr				= -3180;						{  -3180 The command was cancelled					 }
	kEPERMErr					= -3200;						{   Permission denied					 }
	kENOENTErr					= -3201;						{   No such file or directory			 }
	kENORSRCErr					= -3202;						{   No such resource					 }
	kEINTRErr					= -3203;						{   Interrupted system service			 }
	kEIOErr						= -3204;						{   I/O error							 }
	kENXIOErr					= -3205;						{   No such device or address			 }
	kEBADFErr					= -3208;						{   Bad file number						 }
	kEAGAINErr					= -3210;						{   Try operation again later			 }
	kENOMEMErr					= -3211;						{   Not enough space					 }
	kEACCESErr					= -3212;						{   Permission denied					 }
	kEFAULTErr					= -3213;						{   Bad address							 }
	kEBUSYErr					= -3215;						{   Device or resource busy				 }
	kEEXISTErr					= -3216;						{   File exists							 }
	kENODEVErr					= -3218;						{   No such device						 }
	kEINVALErr					= -3221;						{   Invalid argument					 }
	kENOTTYErr					= -3224;						{   Not a character device				 }
	kEPIPEErr					= -3231;						{   Broken pipe							 }
	kERANGEErr					= -3233;						{   Message size too large for STREAM	 }
	kEWOULDBLOCKErr				= -3234;						{   Call would block, so was aborted	 }
	kEDEADLKErr					= -3234;						{   or a deadlock would occur			 }
	kEALREADYErr				= -3236;						{  										 }
	kENOTSOCKErr				= -3237;						{   Socket operation on non-socket		 }
	kEDESTADDRREQErr			= -3238;						{   Destination address required		 }
	kEMSGSIZEErr				= -3239;						{   Message too long					 }
	kEPROTOTYPEErr				= -3240;						{   Protocol wrong type for socket		 }
	kENOPROTOOPTErr				= -3241;						{   Protocol not available				 }
	kEPROTONOSUPPORTErr			= -3242;						{   Protocol not supported				 }
	kESOCKTNOSUPPORTErr			= -3243;						{   Socket type not supported			 }
	kEOPNOTSUPPErr				= -3244;						{   Operation not supported on socket	 }
	kEADDRINUSEErr				= -3247;						{   Address already in use				 }
	kEADDRNOTAVAILErr			= -3248;						{   Can't assign requested address		 }
	kENETDOWNErr				= -3249;						{   Network is down						 }
	kENETUNREACHErr				= -3250;						{   Network is unreachable				 }
	kENETRESETErr				= -3251;						{   Network dropped connection on reset	 }
	kECONNABORTEDErr			= -3252;						{   Software caused connection abort	 }
	kECONNRESETErr				= -3253;						{   Connection reset by peer			 }
	kENOBUFSErr					= -3254;						{   No buffer space available			 }
	kEISCONNErr					= -3255;						{   Socket is already connected			 }
	kENOTCONNErr				= -3256;						{   Socket is not connected				 }
	kESHUTDOWNErr				= -3257;						{   Can't send after socket shutdown	 }
	kETOOMANYREFSErr			= -3258;						{   Too many references: can't splice	 }
	kETIMEDOUTErr				= -3259;						{   Connection timed out				 }
	kECONNREFUSEDErr			= -3260;						{   Connection refused					 }
	kEHOSTDOWNErr				= -3263;						{   Host is down						 }
	kEHOSTUNREACHErr			= -3264;						{   No route to host					 }
	kEPROTOErr					= -3269;						{  										 }
	kETIMEErr					= -3270;						{  										 }
	kENOSRErr					= -3271;						{  										 }
	kEBADMSGErr					= -3272;						{  										 }
	kECANCELErr					= -3273;						{  										 }
	kENOSTRErr					= -3274;						{  										 }
	kENODATAErr					= -3275;						{  										 }
	kEINPROGRESSErr				= -3276;						{  										 }
	kESRCHErr					= -3277;						{  										 }
	kENOMSGErr					= -3278;						{  										 }
	kOTClientNotInittedErr		= -3279;
	kOTPortHasDiedErr			= -3280;
	kOTPortWasEjectedErr		= -3281;
	kOTBadConfigurationErr		= -3282;
	kOTConfigurationChangedErr	= -3283;
	kOTUserRequestedErr			= -3284;
	kOTPortLostConnection		= -3285;

{
	-------------------------------------------------------------------------
	OTAddressType - defines the address type for the OTAddress
	------------------------------------------------------------------------- 
}

TYPE
	OTAddressType						= UInt16;

CONST
	kOTGenericName				= 0;

{
	-------------------------------------------------------------------------
	OTAddress - Generic OpenTransport protocol address
	------------------------------------------------------------------------- 
}

TYPE
	OTAddressPtr = ^OTAddress;
	OTAddress = RECORD
		fAddressType:			OTAddressType;
		fAddress:				SInt8;
	END;

{
	-------------------------------------------------------------------------
	OTStructType - defines the structure type for the OTAlloc call
	------------------------------------------------------------------------- 
}
	OTStructType						= UInt32;

CONST
	T_BIND						= 1;
	T_OPTMGMT					= 2;
	T_CALL						= 3;
	T_DIS						= 4;
	T_UNITDATA					= 5;
	T_UDERROR					= 6;
	T_INFO						= 7;
	T_REPLYDATA					= 8;
	T_REQUESTDATA				= 9;
	T_UNITREQUEST				= 10;
	T_UNITREPLY					= 11;

{
	-------------------------------------------------------------------------
	OTFlags - flags for sending and receiving data
	------------------------------------------------------------------------- 
}

TYPE
	OTFlags								= UInt32;

CONST
	T_MORE						= $0001;						{  More data to come in message		 }
	T_EXPEDITED					= $0002;						{  Data is expedited, if possible	 }
	T_ACKNOWLEDGED				= $0004;						{  Acknowledge transaction			 }
	T_PARTIALDATA				= $0008;						{  Partial data - more coming		 }
	T_NORECEIPT					= $0010;						{  No event on transaction done		 }
	T_TIMEDOUT					= $0020;						{  Reply timed out					 }

{
	-------------------------------------------------------------------------
	OTBand - a band value when reading priority messages
	------------------------------------------------------------------------- 
}

TYPE
	OTBand								= UInt32;
{
	-------------------------------------------------------------------------
	Reference values
	------------------------------------------------------------------------- 
}
	StreamRef							= Ptr;
	ProviderRef							= Ptr;
	EndpointRef							= Ptr;
	MapperRef							= Ptr;

CONST
	kOTInvalidRef				= 0;
	kOTInvalidStreamRef			= 0;
	kOTInvalidProviderRef		= 0;
	kOTInvalidEndpointRef		= 0;
	kOTInvalidMapperRef			= 0;

{
	-------------------------------------------------------------------------
	OTEventCode values for Open Transport - These are the event codes that
	are sent to notification routine during asynchronous processing.
	------------------------------------------------------------------------- 
}

TYPE
	OTEventCode							= UInt32;
{
	 * Function definition to handle notification from providers
	 *
	 * This is never a UniversalProcPtr.
}
	OTNotifyProcPtr = ProcPtr;  { PROCEDURE OTNotify(contextPtr: UNIV Ptr; code: OTEventCode; result: OTResult; cookie: UNIV Ptr); }

{
	 * These will be returned by the T_LOOK function, or will be returned
	 * if asynchronous notification is used.
}

CONST
	T_LISTEN					= $0001;						{  An connection request is available 	 }
	T_CONNECT					= $0002;						{  Confirmation of a connect request	 }
	T_DATA						= $0004;						{  Standard data is available			 }
	T_EXDATA					= $0008;						{  Expedited data is available			 }
	T_DISCONNECT				= $0010;						{  A disconnect is available			 }
	T_ERROR						= $0020;						{  obsolete/unused in library			 }
	T_UDERR						= $0040;						{  A Unit Data Error has occurred		 }
	T_ORDREL					= $0080;						{  An orderly release is available		 }
	T_GODATA					= $0100;						{  Flow control lifted on standard data	 }
	T_GOEXDATA					= $0200;						{  Flow control lifted on expedited data }
	T_REQUEST					= $0400;						{  An Incoming request is available		 }
	T_REPLY						= $0800;						{  An Incoming reply is available		 }
	T_PASSCON					= $1000;						{  State is now T_DATAXFER				 }
	T_RESET						= $2000;						{  Protocol has been reset				 }

{
	 * kPRIVATEEVENT + 1 through kPRIVATEEVENT + 0xffff
	 *		may be used for any private event codes desired.
	 *		All other event codes are reserved for Apple Computer, Inc.
	 *		use only.
}
	kPRIVATEEVENT				= $10000000;

{
	 * These are only returned if asynchronous notification is being used
}
	kCOMPLETEEVENT				= $20000000;
	T_BINDCOMPLETE				= $20000001;					{  Bind call is complete				 }
	T_UNBINDCOMPLETE			= $20000002;					{  Unbind call is complete				 }
	T_ACCEPTCOMPLETE			= $20000003;					{  Accept call is complete				 }
	T_REPLYCOMPLETE				= $20000004;					{  SendReply call is complete			 }
	T_DISCONNECTCOMPLETE		= $20000005;					{  Disconnect call is complete			 }
	T_OPTMGMTCOMPLETE			= $20000006;					{  OptMgmt call is complete				 }
	T_OPENCOMPLETE				= $20000007;					{  An Open call is complete				 }
	T_GETPROTADDRCOMPLETE		= $20000008;					{  GetProtAddress call is complete		 }
	T_RESOLVEADDRCOMPLETE		= $20000009;					{  A ResolveAddress call is complet		 }
	T_GETINFOCOMPLETE			= $2000000A;					{  A GetInfo call is complete			 }
	T_SYNCCOMPLETE				= $2000000B;					{  A Sync call is complete				 }
	T_MEMORYRELEASED			= $2000000C;					{  No-copy memory was released			 }
	T_REGNAMECOMPLETE			= $2000000D;					{  A RegisterName call is complete		 }
	T_DELNAMECOMPLETE			= $2000000E;					{  A DeleteName call is complete		 }
	T_LKUPNAMECOMPLETE			= $2000000F;					{  A LookupName call is complete		 }
	T_LKUPNAMERESULT			= $20000010;					{  A LookupName is returning a name		 }
	kOTSyncIdleEvent			= $20000011;					{  Synchronous call Idle event			 }

{
	 * Events for streams - not normally seen by clients.
}
	kSTREAMEVENT				= $21000000;
	kGetmsgEvent				= $21000002;					{  A GetMessage call is complete		 }
	kStreamReadEvent			= $21000003;					{  A Read call is complete				 }
	kStreamWriteEvent			= $21000004;					{  A Write call is complete				 }
	kStreamIoctlEvent			= $21000005;					{  An Ioctl call is complete			 }
	kStreamOpenEvent			= $21000007;					{  An OpenStream call is complete		 }
	kPollEvent					= $21000008;					{  A Poll call is complete				 }
	kSIGNALEVENT				= $22000000;					{  A signal has arrived from the STREAM	 }
	kPROTOCOLEVENT				= $23000000;					{  Some event from the protocols		 }

{
	 * These are miscellaneous events that could be sent to a provider
}
	kOTProviderIsDisconnected	= $23000001;					{  Provider is temporarily off-line		 }
	kOTProviderIsReconnected	= $23000002;					{  Provider is now back on-line			 }

{
	 * These are system events sent to each provider.
}
	kOTProviderWillClose		= $24000001;					{  Provider will close immediately		 }
	kOTProviderIsClosed			= $24000002;					{  Provider was closed					 }

{
	 * These are system events sent to registered clients
	 *
	 * result code is 0, cookie is the OTPortRef
}
	kOTPortDisabled				= $25000001;					{  Port is now disabled					 }
	kOTPortEnabled				= $25000002;					{  Port is now enabled					 }
	kOTPortOffline				= $25000003;					{  Port is now offline					 }
	kOTPortOnline				= $25000004;					{  Port is now online					 }

{
	 * result is a reason for the close request, cookie is a pointer to the 
	 * OTPortCloseStruct structure.
}
	kOTClosePortRequest			= $25000005;					{  Request to close/yield				 }
	kOTYieldPortRequest			= $25000005;					{  Request to close/yield				 }

{
	 * A new port has been registered, cookie is the OTPortRef
}
	kOTNewPortRegistered		= $25000006;					{  New port has been registered			 }

{
	 * These are events sent to the configuration management infrastructure 
}
	kOTConfigurationChanged		= $26000001;					{  Protocol configuration changed		 }
	kOTSystemSleep				= $26000002;
	kOTSystemShutdown			= $26000003;
	kOTSystemAwaken				= $26000004;
	kOTSystemIdle				= $26000005;
	kOTSystemSleepPrep			= $26000006;
	kOTSystemShutdownPrep		= $26000007;
	kOTSystemAwakenPrep			= $26000008;

{
	-------------------------------------------------------------------------
	Signals that are generated by a stream.  Add these values to
	kSIGNALEVENT to determine what event you are receiving.
	------------------------------------------------------------------------- 
}
	SIGHUP						= 1;
	SIGURG						= 16;
	SIGPOLL						= 30;

{
	-------------------------------------------------------------------------
	Option Management equates
	------------------------------------------------------------------------- 
}
{
	** The XTI Level number of a protocol
}

TYPE
	OTXTILevel							= UInt32;

CONST
	XTI_GENERIC					= $FFFF;						{  level to match any protocol	 }

{
	** The XTI name of a protocol option
}

TYPE
	OTXTIName							= UInt32;
{
		 * XTI names for options used with XTI_GENERIC above
}

CONST
	XTI_DEBUG					= $0001;
	XTI_LINGER					= $0080;
	XTI_RCVBUF					= $1002;
	XTI_RCVLOWAT				= $1004;
	XTI_SNDBUF					= $1001;
	XTI_SNDLOWAT				= $1003;
	XTI_PROTOTYPE				= $1005;

{
		 * Generic options that can be used with any protocol
		 * that understands them
}
	OPT_CHECKSUM				= $0600;						{  Set checksumming = UInt32 - 0 or 1) }
	OPT_RETRYCNT				= $0601;						{  Set a retry counter = UInt32 (0 = infinite) }
	OPT_INTERVAL				= $0602;						{  Set a retry interval = UInt32 milliseconds }
	OPT_ENABLEEOM				= $0603;						{  Enable the EOM indication = UInt8 (0 or 1) }
	OPT_SELFSEND				= $0604;						{  Enable Self-sending on broadcasts = UInt32 (0 or 1) }
	OPT_SERVERSTATUS			= $0605;						{  Set Server Status (format is proto dependent) }
	OPT_ALERTENABLE				= $0606;						{  Enable/Disable protocol alerts }
	OPT_KEEPALIVE				= $0008;						{  See t_keepalive structure }

{
******************************************************************************
** Definitions not associated with a Typedef
*******************************************************************************
}
{
	-------------------------------------------------------------------------
	IOCTL values for the OpenTransport system
	------------------------------------------------------------------------- 
}
	MIOC_STREAMIO				= 65;							{  Basic Stream ioctl() cmds - I_PUSH, I_LOOK, etc.  }
	MIOC_STRLOG					= 98;							{  ioctl's for Mentat's log device  }
	MIOC_SAD					= 103;							{  ioctl's for Mentat's sad module  }
	MIOC_ARP					= 104;							{  ioctl's for Mentat's arp module  }
	MIOC_TCP					= 107;							{  tcp.h ioctl's  }
	MIOC_DLPI					= 108;							{  dlpi.h additions  }
	MIOC_OT						= 79;							{  ioctls for Open Transport	 }
	MIOC_ATALK					= 84;							{  ioctl's for AppleTalk	 }
	MIOC_SRL					= 85;							{  ioctl's for Serial		 }
	MIOC_SRL_HIGH				= $5500;						{  ioctls for Serial			'U' << 8  }
	MIOC_OT_HIGH				= $4F00;						{  ioctls for Open Transport	'O' << 8  }
	MIOC_SIO_HIGH				= $4100;						{  ioctls for StreamIO			'A' << 8  }
	MIOC_CFIG					= 122;							{  ioctl's for private configuration  }

	I_STR						= $4108;
	I_FIND						= $410B;
	I_LIST						= $4116;
	I_OTGetMiscellaneousEvents	= $4F01;						{  sign up for Misc Events					 }
	I_OTSetFramingType			= $4F02;						{  Set framing option for link				 }
	kOTGetFramingValue			= $FFFFFFFF;					{  Use this value to read framing			 }
	I_OTSetRawMode				= $4F03;						{  Set raw mode for link					 }
	I_OTConnect					= $4F04;						{  Generic connect request for links		 }
	I_OTDisconnect				= $4F05;						{  Generic disconnect request for links		 }
	I_OTScript					= $4F06;						{  Send a script to a module				 }

{
	 * Structure for the I_OTScript Ioctl.
}

TYPE
	OTScriptInfoPtr = ^OTScriptInfo;
	OTScriptInfo = RECORD
		fScriptType:			UInt32;
		fTheScript:				Ptr;
		fScriptLength:			UInt32;
	END;

{
	 * structure of ioctl data for I_STR IOCtls
}
	strioctlPtr = ^strioctl;
	strioctl = RECORD
		ic_cmd:					int_t;									{  downstream command	 }
		ic_timout:				int_t;									{  ACK/NAK timeout		 }
		ic_len:					int_t;									{  length of data arg	 }
		ic_dp:					CStringPtr;								{  ptr to data arg		 }
	END;

{
	-------------------------------------------------------------------------
	Maximum size of a provider name, and maximum size of a STREAM module name.
	This module name is smaller than the maximum size of a TProvider to allow
	for 4 characters of extra "minor number" information that might be 
	potentially in a TProvider name
	------------------------------------------------------------------------- 
}

CONST
	kMaxModuleNameLength		= 31;
	kMaxModuleNameSize			= 32;
	kMaxProviderNameLength		= 35;
	kMaxProviderNameSize		= 36;
	kMaxSlotIDLength			= 7;
	kMaxSlotIDSize				= 8;
	kMaxResourceInfoLength		= 31;
	kMaxResourceInfoSize		= 32;

{
	-------------------------------------------------------------------------
	These values are used in the "fields" parameter of the OTAlloc call
	to define which fields of the structure should be allocated.
	------------------------------------------------------------------------- 
}
	T_ADDR						= $01;
	T_OPT						= $02;
	T_UDATA						= $04;
	T_ALL						= $FFFF;

{
	-------------------------------------------------------------------------
	These are the potential values returned by OTGetEndpointState and OTSync
	which represent the state of an endpoint
	------------------------------------------------------------------------- 
}
	T_UNINIT					= 0;							{  addition to standard xti.h	 }
	T_UNBND						= 1;							{  unbound						 }
	T_IDLE						= 2;							{  idle							 }
	T_OUTCON					= 3;							{  outgoing connection pending	 }
	T_INCON						= 4;							{  incoming connection pending	 }
	T_DATAXFER					= 5;							{  data transfer				 }
	T_OUTREL					= 6;							{  outgoing orderly release		 }
	T_INREL						= 7;							{  incoming orderly release		 }

{
	-------------------------------------------------------------------------
	Flags used by option management calls to request services
	------------------------------------------------------------------------- 
}
	T_NEGOTIATE					= $0004;
	T_CHECK						= $0008;
	T_DEFAULT					= $0010;
	T_CURRENT					= $0080;

{
	-------------------------------------------------------------------------
	Flags used by option management calls to return results
	------------------------------------------------------------------------- 
}
	T_SUCCESS					= $0020;
	T_FAILURE					= $0040;
	T_PARTSUCCESS				= $0100;
	T_READONLY					= $0200;
	T_NOTSUPPORT				= $0400;

{
	-------------------------------------------------------------------------
	General definitions
	------------------------------------------------------------------------- 
}
	T_YES						= 1;
	T_NO						= 0;
	T_UNUSED					= -1;
	T_NULL						= 0;
	T_ABSREQ					= $8000;

{
	-------------------------------------------------------------------------
	Option Management definitions
	------------------------------------------------------------------------- 
}
	T_UNSPEC					= $FFFFFFFD;
	T_ALLOPT					= 0;

{
 This macro will align return the value of "len", rounded up to the next
 4-byte boundary.
}
{
 This macro will return the next option in the buffer, given the previous option
 in the buffer, returning NULL if there are no more.
 You start off by setting prevOption = (TOption*)theBuffer
 (Use OTNextOption for a more thorough check - it ensures the end
  of the option is in the buffer as well.)
}
{
******************************************************************************
** Structures and forward declarations
**
** From here on down, all structures are aligned the same on 68K and powerpc
*******************************************************************************
}
{
	-------------------------------------------------------------------------
	OTConfiguration structure - this is a "black box" structure used to
	define the configuration of a provider or endpoint.
	------------------------------------------------------------------------- 
}

TYPE
	OTConfigurationPtr = ^OTConfiguration;
	OTConfiguration = RECORD
	END;

{
	-------------------------------------------------------------------------
	Option Management structures
	------------------------------------------------------------------------- 
}
{
	 * Structure used with OPT_KEEPALIVE option.
}
	t_kpalivePtr = ^t_kpalive;
	t_kpalive = RECORD
		kp_onoff:				LONGINT;								{  option on/off		 }
		kp_timeout:				LONGINT;								{  timeout in minutes	 }
	END;

{
	 * Structure used with XTI_LINGER option
}
	t_lingerPtr = ^t_linger;
	t_linger = RECORD
		l_onoff:				LONGINT;								{  option on/off  }
		l_linger:				LONGINT;								{  linger time  }
	END;

{
	-------------------------------------------------------------------------
	TEndpointInfo - this structure is returned from the GetEndpointInfo call
	and contains information about an endpoint
	------------------------------------------------------------------------- 
}
	TEndpointInfoPtr = ^TEndpointInfo;
	TEndpointInfo = RECORD
		addr:					SInt32;									{  Maximum size of an address			 }
		options:				SInt32;									{  Maximum size of options				 }
		tsdu:					SInt32;									{  Standard data transmit unit size		 }
		etsdu:					SInt32;									{  Expedited data transmit unit size	 }
		connect:				SInt32;									{  Maximum data size on connect			 }
		discon:					SInt32;									{  Maximum data size on disconnect		 }
		servtype:				UInt32;									{  service type (see below for values)	 }
		flags:					UInt32;									{  Flags (see below for values)			 }
	END;

{
	 * Values returned in servtype field of TEndpointInfo
}

CONST
	T_COTS						= 1;							{  Connection-mode service								 }
	T_COTS_ORD					= 2;							{  Connection service with orderly release				 }
	T_CLTS						= 3;							{  Connectionless-mode service							 }
	T_TRANS						= 5;							{  Connection-mode transaction service					 }
	T_TRANS_ORD					= 6;							{  Connection transaction service with orderly release	 }
	T_TRANS_CLTS				= 7;							{  Connectionless transaction service					 }

{
	 * Values returned in flags field of TEndpointInfo
}
	T_SENDZERO					= $0001;						{  supports 0-length TSDU's			 }
	T_XPG4_1					= $0002;						{  supports the GetProtAddress call	 }
	T_CAN_SUPPORT_MDATA			= $10000000;					{  support M_DATAs on packet protocols	 }
	T_CAN_RESOLVE_ADDR			= $40000000;					{  Supports ResolveAddress call			 }
	T_CAN_SUPPLY_MIB			= $20000000;					{  Supports SNMP MIB data				 }

{
	 * Values returned in tsdu, etsdu, connect, and discon fields of TEndpointInfo
}
	T_INFINITE					= -1;							{  supports infinit amounts of data		 }
	T_INVALID					= -2;							{  Does not support data transmission	 }

{
	-------------------------------------------------------------------------
	OTPortRecord
	------------------------------------------------------------------------- 
}
{
	 * Unique identifier for a port
}

TYPE
	OTPortRef							= UInt32;
	OTPortRefPtr						= ^OTPortRef;
{
	 * A couple of special values for the "port type" in an OTPortRef.
	 * See OpenTptLinks.h for other values.
	 * The device kOTPseudoDevice is used where no other defined
	 * device type will work.
}

CONST
	kOTNoDeviceType				= 0;
	kOTPseudoDevice				= 1023;
	kOTLastDeviceIndex			= 1022;
	kOTLastSlotNumber			= 255;
	kOTLastOtherNumber			= 255;

{
	 * kMaxPortNameLength is the maximum size allowed to define
	 * a port
}
	kMaxPortNameLength			= 35;
	kMaxPortNameSize			= 36;

	kOTInvalidPortRef			= 0;

{
	 * Equates for the legal Bus-type values
}
	kOTUnknownBusPort			= 0;
	kOTMotherboardBus			= 1;
	kOTNuBus					= 2;
	kOTPCIBus					= 3;
	kOTGeoPort					= 4;
	kOTPCCardBus				= 5;
	kOTFireWireBus				= 6;
	kOTLastBusIndex				= 15;


TYPE
	OTPortCloseStructPtr = ^OTPortCloseStruct;
	OTPortCloseStruct = RECORD
		fPortRef:				OTPortRef;								{  The port requested to be closed. }
		fTheProvider:			ProviderRef;							{  The provider using the port. }
		fDenyReason:			OSStatus;								{  Set to a negative number to deny the request }
	END;

FUNCTION OTCreatePortRef(busType: ByteParameter; devType: UInt16; slot: UInt16; other: UInt16): OTPortRef;
FUNCTION OTGetDeviceTypeFromPortRef(ref: OTPortRef): UInt16;
FUNCTION OTGetBusTypeFromPortRef(ref: OTPortRef): UInt16;
FUNCTION OTGetSlotFromPortRef(ref: OTPortRef; VAR other: UInt16): UInt16;
FUNCTION OTSetDeviceTypeInPortRef(ref: OTPortRef; devType: UInt16): OTPortRef;
FUNCTION OTSetBusTypeInPortRef(ref: OTPortRef; busType: ByteParameter): OTPortRef;
{
	 * One OTPortRecord is created for each instance of a port.
	 * For Instance 'enet' identifies an ethernet port.
	 * A TPortRecord for each ethernet card it finds, with an
	 * OTPortRef that will uniquely allow the driver to determine which
	 * port it is supposed to open on.
}

TYPE
	OTPortRecordPtr = ^OTPortRecord;
	OTPortRecord = RECORD
		fRef:					OTPortRef;
		fPortFlags:				UInt32;
		fInfoFlags:				UInt32;
		fCapabilities:			UInt32;
		fNumChildPorts:			size_t;
		fChildPorts:			OTPortRefPtr;
		fPortName:				PACKED ARRAY [0..35] OF CHAR;
		fModuleName:			PACKED ARRAY [0..31] OF CHAR;
		fSlotID:				PACKED ARRAY [0..7] OF CHAR;
		fResourceInfo:			PACKED ARRAY [0..31] OF CHAR;
		fReserved:				PACKED ARRAY [0..163] OF CHAR;
	END;

{
	 * Values for the fInfoFlags field of OTPortRecord
	 * kOTPortCanYield and kOTPortCanArbitrate
	 * will not be set until the port is used for the first time.
}

CONST
	kOTPortIsDLPI				= $00000001;
	kOTPortIsTPI				= $00000002;
	kOTPortCanYield				= $00000004;
	kOTPortCanArbitrate			= $00000008;
	kOTPortIsTransitory			= $00000010;
	kOTPortAutoConnects			= $00000020;
	kOTPortIsSystemRegistered	= $00004000;
	kOTPortIsPrivate			= $00008000;
	kOTPortIsAlias				= $80000000;

{
	 * Values for the fPortFlags field of TPortRecord
	 * If no bits are set, the port is currently inactive.
}
	kOTPortIsActive				= $00000001;
	kOTPortIsDisabled			= $00000002;
	kOTPortIsUnavailable		= $00000004;
	kOTPortIsOffline			= $00000008;

{
	-------------------------------------------------------------------------
	TOptionHeader and TOption
	
	This structure describes the contents of a single option in a buffer
	------------------------------------------------------------------------- 
}

TYPE
	TOptionHeaderPtr = ^TOptionHeader;
	TOptionHeader = RECORD
		len:					UInt32;									{  total length of option				 }
																		{  = sizeof(TOptionHeader) + length		 }
																		{ 	 of option value in bytes			 }
		level:					OTXTILevel;								{  protocol affected					 }
		optName:				OTXTIName;								{  option name							 }
		status:					UInt32;									{  status value							 }
	END;

	TOptionPtr = ^TOption;
	TOption = RECORD
		len:					UInt32;									{  total length of option				 }
																		{  = sizeof(TOption) + length	 }
																		{ 	 of option value in bytes			 }
		level:					OTXTILevel;								{  protocol affected					 }
		optName:				OTXTIName;								{  option name							 }
		status:					UInt32;									{  status value							 }
		value:					ARRAY [0..0] OF UInt32;					{  data goes here						 }
	END;


CONST
	kOTOptionHeaderSize			= 16;
	kOTBooleanOptionDataSize	= 4;
	kOTBooleanOptionSize		= 20;
	kOTOneByteOptionSize		= 17;
	kOTTwoByteOptionSize		= 18;
	kOTFourByteOptionSize		= 20;

{
	-------------------------------------------------------------------------
	PollRef structure
	
	This is used with the OTStreamPoll function
	------------------------------------------------------------------------- 
}

TYPE
	PollRefPtr = ^PollRef;
	PollRef = RECORD
		filler:					LONGINT;
		events:					INTEGER;
		revents:				INTEGER;
		ref:					StreamRef;
	END;

{
	-------------------------------------------------------------------------
	OTClientList structure
	
	This is used with the OTYieldPortRequest function.
	------------------------------------------------------------------------- 
}
	OTClientListPtr = ^OTClientList;
	OTClientList = RECORD
		fNumClients:			size_t;
		fBuffer:				PACKED ARRAY [0..3] OF UInt8;
	END;

{
	-------------------------------------------------------------------------
	OTData
	
	This is a structure that may be used in a TNetbuf or netbuf to send
	non-contiguous data.  Set the 'len' field of the netbuf to the
	constant kNetbufDataIsOTData to signal that the 'buf' field of the
	netbuf actually points to one of these structures instead of a
	memory buffer.
	------------------------------------------------------------------------- 
}
	OTDataPtr = ^OTData;
	OTData = RECORD
		fNext:					Ptr;
		fData:					Ptr;
		fLen:					size_t;
	END;


CONST
	kNetbufDataIsOTData			= $FFFFFFFE;

{
	-------------------------------------------------------------------------
	OTBuffer

	This is the structure that is used for no-copy receives.
	When you are done with it, you must call the OTReleaseBuffer function.
	For best performance, you need to call OTReleaseBuffer quickly.  Only
	data netbufs may use this - no netbufs for addresses or options, or the like.
	------------------------------------------------------------------------- 
}

TYPE
	OTBufferPtr = ^OTBuffer;
	OTBuffer = RECORD
		fLink:					Ptr;									{  b_next & b_prev }
		fLink2:					Ptr;
		fNext:					OTBufferPtr;							{  b_cont }
		fData:					Ptr;									{  b_rptr }
		fLen:					size_t;									{  b_wptr }
		fSave:					Ptr;									{  b_datap }
		fBand:					SInt8;									{  b_band }
		fType:					SInt8;									{  b_pad1 }
		fPad1:					SInt8;
		fFlags:					SInt8;									{  b_flag }
	END;

{
	-------------------------------------------------------------------------
	OTBufferInfo
	
	This structure is used with OTReadBuffer to keep track of where you
	are in the buffer, since the OTBuffer is "read-only".
	------------------------------------------------------------------------- 
}
	OTBufferInfoPtr = ^OTBufferInfo;
	OTBufferInfo = RECORD
		fBuffer:				OTBufferPtr;
		fOffset:				size_t;
		fPad:					SInt8;
		fFiller:				SInt8;
	END;


CONST
	kOTNetbufDataIsOTBufferStar	= $FFFFFFFD;

{
	-------------------------------------------------------------------------
	TNetbuf
	
	This structure is the basic structure used to pass data back and forth
	between the Open Transport protocols and their clients
	------------------------------------------------------------------------- 
}

TYPE
	TNetbufPtr = ^TNetbuf;
	TNetbuf = RECORD
		maxlen:					size_t;
		len:					size_t;
		buf:					Ptr;
	END;

{
	-------------------------------------------------------------------------
	TBind
	
	Structure passed to GetProtAddress, ResolveAddress and Bind
	------------------------------------------------------------------------- 
}
	TBindPtr = ^TBind;
	TBind = RECORD
		addr:					TNetbuf;
		qlen:					OTQLen;
	END;

{
	-------------------------------------------------------------------------
	TDiscon
	
	Structure passed to RcvDisconnect to find out additional information
	about the disconnect
	------------------------------------------------------------------------- 
}
	TDisconPtr = ^TDiscon;
	TDiscon = RECORD
		udata:					TNetbuf;
		reason:					OTReason;
		sequence:				OTSequence;
	END;

{
	-------------------------------------------------------------------------
	TCall
	
	Structure passed to Connect, RcvConnect, Listen, Accept, and
	SndDisconnect to describe the connection.
	------------------------------------------------------------------------- 
}
	TCallPtr = ^TCall;
	TCall = RECORD
		addr:					TNetbuf;
		opt:					TNetbuf;
		udata:					TNetbuf;
		sequence:				OTSequence;
	END;

{
	-------------------------------------------------------------------------
	TUnitData
	
	Structure passed to SndUData and RcvUData to describe the datagram
	------------------------------------------------------------------------- 
}
	TUnitDataPtr = ^TUnitData;
	TUnitData = RECORD
		addr:					TNetbuf;
		opt:					TNetbuf;
		udata:					TNetbuf;
	END;

{
	-------------------------------------------------------------------------
	TUDErr
	
	Structure passed to RcvUDErr to find out about a datagram error
	------------------------------------------------------------------------- 
}
	TUDErrPtr = ^TUDErr;
	TUDErr = RECORD
		addr:					TNetbuf;
		opt:					TNetbuf;
		error:					SInt32;
	END;

{
	-------------------------------------------------------------------------
	TOptMgmt
	
	Structure passed to the OptionManagement call to read or set protocol
	options.
	------------------------------------------------------------------------- 
}
	TOptMgmtPtr = ^TOptMgmt;
	TOptMgmt = RECORD
		opt:					TNetbuf;
		flags:					OTFlags;
	END;

{
	-------------------------------------------------------------------------
	TRequest
	
	Structure passed to SndRequest and RcvRequest that contains the information
	about the request
	------------------------------------------------------------------------- 
}
	TRequestPtr = ^TRequest;
	TRequest = RECORD
		data:					TNetbuf;
		opt:					TNetbuf;
		sequence:				OTSequence;
	END;

{
	-------------------------------------------------------------------------
	TReply
	
	Structure passed to SndReply to send a reply to an incoming request
	------------------------------------------------------------------------- 
}
	TReplyPtr = ^TReply;
	TReply = RECORD
		data:					TNetbuf;
		opt:					TNetbuf;
		sequence:				OTSequence;
	END;

{
	-------------------------------------------------------------------------
	TUnitRequest
	
	Structure passed to SndURequest and RcvURequest that contains the information
	about the request
	------------------------------------------------------------------------- 
}
	TUnitRequestPtr = ^TUnitRequest;
	TUnitRequest = RECORD
		addr:					TNetbuf;
		opt:					TNetbuf;
		udata:					TNetbuf;
		sequence:				OTSequence;
	END;

{
	-------------------------------------------------------------------------
	TUnitReply
	
	Structure passed to SndUReply to send a reply to an incoming request
	------------------------------------------------------------------------- 
}
	TUnitReplyPtr = ^TUnitReply;
	TUnitReply = RECORD
		opt:					TNetbuf;
		udata:					TNetbuf;
		sequence:				OTSequence;
	END;

{
	-------------------------------------------------------------------------
	TRegisterRequest
	------------------------------------------------------------------------- 
}
	TRegisterRequestPtr = ^TRegisterRequest;
	TRegisterRequest = RECORD
		name:					TNetbuf;
		addr:					TNetbuf;
		flags:					OTFlags;
	END;

{
	-------------------------------------------------------------------------
	TRegisterReply
	------------------------------------------------------------------------- 
}
	TRegisterReplyPtr = ^TRegisterReply;
	TRegisterReply = RECORD
		addr:					TNetbuf;
		nameid:					OTNameID;
	END;

{
	-------------------------------------------------------------------------
	TLookupRequest
	------------------------------------------------------------------------- 
}
	TLookupRequestPtr = ^TLookupRequest;
	TLookupRequest = RECORD
		name:					TNetbuf;
		addr:					TNetbuf;
		maxcnt:					UInt32;
		timeout:				OTTimeout;
		flags:					OTFlags;
	END;

{
	-------------------------------------------------------------------------
	TLookupReply 
	
	Structure used by Mapper protocols to return the results of name Lookups
	------------------------------------------------------------------------- 
}
{
	 * This is the structure returned by the mapper for names that are
	 * looked up.  
}
	TLookupBufferPtr = ^TLookupBuffer;
	TLookupBuffer = RECORD
		fAddressLength:			UInt16;
		fNameLength:			UInt16;
		fAddressBuffer:			SInt8;
	END;

	TLookupReplyPtr = ^TLookupReply;
	TLookupReply = RECORD
		names:					TNetbuf;
		rspcount:				UInt32;
	END;

{
******************************************************************************
** C Interfaces to Open Transport
*******************************************************************************
}
{
	-------------------------------------------------------------------------
	Initializing and shutting down Open Transport
	------------------------------------------------------------------------- 
}
{$IFC NOT OTKERNEL }
FUNCTION InitOpenTransport: OSStatus;
FUNCTION InitOpenTransportUtilities: OSStatus;
PROCEDURE CloseOpenTransport;
{
 This registers yourself as a client for any miscellaneous Open Transport
 notifications that come along. CloseOpenTransport will automatically do
 an OTUnregisterAsClient, if you have not already done so.
}
FUNCTION OTRegisterAsClient(name: OTClientName; proc: OTNotifyProcPtr): OSStatus;
FUNCTION OTUnregisterAsClient: OSStatus;
{$ENDC}
{
	-------------------------------------------------------------------------
	Interrupt processing
	
	These routine must be used by interrupt, deferred task, vbl, and time
	manager routines to bracket any calls to OpenTransport.
	------------------------------------------------------------------------- 
}
PROCEDURE OTEnterInterrupt;
PROCEDURE OTLeaveInterrupt;

TYPE
	OTProcessProcPtr = ProcPtr;  { PROCEDURE OTProcess(arg: UNIV Ptr); }

FUNCTION OTCreateDeferredTask(proc: OTProcessProcPtr; arg: UNIV Ptr): LONGINT;
FUNCTION OTScheduleDeferredTask(dtCookie: LONGINT): BOOLEAN;
FUNCTION OTScheduleInterruptTask(dtCookie: LONGINT): BOOLEAN;
FUNCTION OTDestroyDeferredTask(dtCookie: LONGINT): OSStatus;
{$IFC NOT OTKERNEL }
FUNCTION OTCreateSystemTask(proc: OTProcessProcPtr; arg: UNIV Ptr): LONGINT;
FUNCTION OTDestroySystemTask(stCookie: LONGINT): OSStatus;
FUNCTION OTScheduleSystemTask(stCookie: LONGINT): BOOLEAN;
FUNCTION OTCancelSystemTask(stCookie: LONGINT): BOOLEAN;
FUNCTION OTCanMakeSyncCall: BOOLEAN;
{$ENDC}
FUNCTION OTIsAtInterruptLevel: BOOLEAN; C;
FUNCTION OTCanLoadLibraries: BOOLEAN; C;
{
	-------------------------------------------------------------------------
	Functions for dealing with port
	------------------------------------------------------------------------- 
}
{$IFC NOT OTKERNEL }
FUNCTION OTGetIndexedPort(VAR record1: OTPortRecord; index: size_t): BOOLEAN;
FUNCTION OTFindPort(VAR record1: OTPortRecord; portName: ConstCStringPtr): BOOLEAN;
FUNCTION OTFindPortByRef(VAR record1: OTPortRecord; ref: OTPortRef): BOOLEAN;
FUNCTION OTRegisterPort(VAR portInfo: OTPortRecord; ref: UNIV Ptr): OSStatus; C;
FUNCTION OTUnregisterPort(portName: ConstCStringPtr; VAR cookiePtrPTr: UNIV Ptr): OSStatus; C;
FUNCTION OTChangePortState(ref: OTPortRef; theChange: OTEventCode; why: OTResult): OSStatus; C;
{$ENDC}
{
	-------------------------------------------------------------------------
	Interface to providers
	------------------------------------------------------------------------- 
}

TYPE
	strbufPtr = ^strbuf;
	strbuf = RECORD
		maxlen:					LONGINT;								{  max buffer length  }
		len:					LONGINT;								{  length of data  }
		buf:					CStringPtr;								{  pointer to buffer  }
	END;

{$IFC NOT OTKERNEL }
FUNCTION OTAsyncOpenProvider(config: OTConfigurationPtr; flags: OTOpenFlags; proc: OTNotifyProcPtr; contextPtr: UNIV Ptr): OSStatus;
FUNCTION OTOpenProvider(config: OTConfigurationPtr; flags: OTOpenFlags; VAR errPtr: OSStatus): ProviderRef;
FUNCTION OTCloseProvider(ref: ProviderRef): OSStatus;
FUNCTION OTTransferProviderOwnership(ref: ProviderRef; prevOwner: OTClient; VAR errPtr: OSStatus): ProviderRef;
FUNCTION OTWhoAmI: OTClient;
FUNCTION OTGetProviderPortRef(ref: ProviderRef): OTPortRef;
FUNCTION OTIoctl(ref: ProviderRef; cmd: UInt32; data: UNIV Ptr): SInt32;
FUNCTION OTGetMessage(ref: ProviderRef; VAR ctlbuf: strbuf; VAR databuf: strbuf; VAR flagPtr: OTFlags): OTResult;
FUNCTION OTGetPriorityMessage(ref: ProviderRef; VAR ctlbuf: strbuf; VAR databuf: strbuf; VAR bandPtr: OTBand; VAR flagPtr: OTFlags): OTResult;
FUNCTION OTPutMessage(ref: ProviderRef; {CONST}VAR ctlbuf: strbuf; {CONST}VAR databuf: strbuf; flags: OTFlags): OSStatus;
FUNCTION OTPutPriorityMessage(ref: ProviderRef; {CONST}VAR ctlbuf: strbuf; {CONST}VAR databuf: strbuf; band: OTBand; flags: OTFlags): OSStatus;
FUNCTION OTSetAsynchronous(ref: ProviderRef): OSStatus;
FUNCTION OTSetSynchronous(ref: ProviderRef): OSStatus;
FUNCTION OTIsSynchronous(ref: ProviderRef): BOOLEAN;
FUNCTION OTSetBlocking(ref: ProviderRef): OSStatus;
FUNCTION OTSetNonBlocking(ref: ProviderRef): OSStatus;
FUNCTION OTIsBlocking(ref: ProviderRef): BOOLEAN;
FUNCTION OTInstallNotifier(ref: ProviderRef; proc: OTNotifyProcPtr; contextPtr: UNIV Ptr): OSStatus;
FUNCTION OTUseSyncIdleEvents(ref: ProviderRef; useEvents: BOOLEAN): OSStatus;
PROCEDURE OTRemoveNotifier(ref: ProviderRef);
PROCEDURE OTLeaveNotifier(ref: ProviderRef);
FUNCTION OTEnterNotifier(ref: ProviderRef): BOOLEAN;
FUNCTION OTAckSends(ref: ProviderRef): OSStatus;
FUNCTION OTDontAckSends(ref: ProviderRef): OSStatus;
FUNCTION OTIsAckingSends(ref: ProviderRef): BOOLEAN;
FUNCTION OTCancelSynchronousCalls(ref: ProviderRef; err: OSStatus): OSStatus;
{$ENDC}
{
	-------------------------------------------------------------------------
	Interface to endpoints
	------------------------------------------------------------------------- 
}
{$IFC NOT OTKERNEL }
{  Open/Close }
FUNCTION OTOpenEndpoint(config: OTConfigurationPtr; oflag: OTOpenFlags; info: TEndpointInfoPtr; VAR err: OSStatus): EndpointRef;
FUNCTION OTAsyncOpenEndpoint(config: OTConfigurationPtr; oflag: OTOpenFlags; info: TEndpointInfoPtr; proc: OTNotifyProcPtr; contextPtr: UNIV Ptr): OSStatus;
{  Misc Information }
FUNCTION OTGetEndpointInfo(ref: EndpointRef; info: TEndpointInfoPtr): OSStatus;
FUNCTION OTGetEndpointState(ref: EndpointRef): OTResult;
FUNCTION OTLook(ref: EndpointRef): OTResult;
FUNCTION OTSync(ref: EndpointRef): OTResult;
FUNCTION OTCountDataBytes(ref: EndpointRef; VAR countPtr: size_t): OTResult;
FUNCTION OTGetProtAddress(ref: EndpointRef; boundAddr: TBindPtr; peerAddr: TBindPtr): OSStatus;
FUNCTION OTResolveAddress(ref: EndpointRef; reqAddr: TBindPtr; retAddr: TBindPtr; timeOut: OTTimeout): OSStatus;
{  Allocating structures }
FUNCTION OTAlloc(ref: EndpointRef; structType: OTStructType; fields: UInt32; VAR err: OSStatus): Ptr;
FUNCTION OTFree(ptr: UNIV Ptr; structType: OTStructType): OTResult;
{  Option management }
FUNCTION OTOptionManagement(ref: EndpointRef; req: TOptMgmtPtr; ret: TOptMgmtPtr): OSStatus;
{  Bind/Unbind }
FUNCTION OTBind(ref: EndpointRef; reqAddr: TBindPtr; retAddr: TBindPtr): OSStatus;
FUNCTION OTUnbind(ref: EndpointRef): OSStatus;
{  Connection creation/tear-down }
FUNCTION OTConnect(ref: EndpointRef; sndCall: TCallPtr; rcvCall: TCallPtr): OSStatus;
FUNCTION OTRcvConnect(ref: EndpointRef; call: TCallPtr): OSStatus;
FUNCTION OTListen(ref: EndpointRef; call: TCallPtr): OSStatus;
FUNCTION OTAccept(ref: EndpointRef; resRef: EndpointRef; call: TCallPtr): OSStatus;
FUNCTION OTSndDisconnect(ref: EndpointRef; call: TCallPtr): OSStatus;
FUNCTION OTSndOrderlyDisconnect(ref: EndpointRef): OSStatus;
FUNCTION OTRcvDisconnect(ref: EndpointRef; discon: TDisconPtr): OSStatus;
FUNCTION OTRcvOrderlyDisconnect(ref: EndpointRef): OSStatus;
{  Connection-oriented send/receive }
FUNCTION OTRcv(ref: EndpointRef; buf: UNIV Ptr; nbytes: size_t; VAR flags: OTFlags): OTResult;
FUNCTION OTSnd(ref: EndpointRef; buf: UNIV Ptr; nbytes: size_t; flags: OTFlags): OTResult;
{  non-connection oriented send/receive }
FUNCTION OTSndUData(ref: EndpointRef; udata: TUnitDataPtr): OSStatus;
FUNCTION OTRcvUData(ref: EndpointRef; udata: TUnitDataPtr; VAR flags: OTFlags): OSStatus;
FUNCTION OTRcvUDErr(ref: EndpointRef; uderr: TUDErrPtr): OSStatus;
{  Connection-oriented transactions }
FUNCTION OTSndRequest(ref: EndpointRef; req: TRequestPtr; reqFlags: OTFlags): OSStatus;
FUNCTION OTRcvReply(ref: EndpointRef; reply: TReplyPtr; VAR replyFlags: OTFlags): OSStatus;
FUNCTION OTSndReply(ref: EndpointRef; reply: TReplyPtr; replyFlags: OTFlags): OSStatus;
FUNCTION OTRcvRequest(ref: EndpointRef; req: TRequestPtr; VAR reqFlags: OTFlags): OSStatus;
FUNCTION OTCancelRequest(ref: EndpointRef; sequence: OTSequence): OSStatus;
FUNCTION OTCancelReply(ref: EndpointRef; sequence: OTSequence): OSStatus;
{  Connectionless transactions }
FUNCTION OTSndURequest(ref: EndpointRef; req: TUnitRequestPtr; reqFlags: OTFlags): OSStatus;
FUNCTION OTRcvUReply(ref: EndpointRef; reply: TUnitReplyPtr; VAR replyFlags: OTFlags): OSStatus;
FUNCTION OTSndUReply(ref: EndpointRef; reply: TUnitReplyPtr; replyFlags: OTFlags): OSStatus;
FUNCTION OTRcvURequest(ref: EndpointRef; req: TUnitRequestPtr; VAR reqFlags: OTFlags): OSStatus;
FUNCTION OTCancelURequest(ref: EndpointRef; seq: OTSequence): OSStatus;
FUNCTION OTCancelUReply(ref: EndpointRef; seq: OTSequence): OSStatus;
{
	-------------------------------------------------------------------------
	Interface to mappers
	------------------------------------------------------------------------- 
}
FUNCTION OTAsyncOpenMapper(config: OTConfigurationPtr; oflag: OTOpenFlags; proc: OTNotifyProcPtr; contextPtr: UNIV Ptr): OSStatus;
FUNCTION OTOpenMapper(config: OTConfigurationPtr; oflag: OTOpenFlags; VAR err: OSStatus): MapperRef;
FUNCTION OTRegisterName(ref: MapperRef; req: TRegisterRequestPtr; VAR reply: TRegisterReply): OSStatus;
FUNCTION OTDeleteName(ref: MapperRef; name: TNetbufPtr): OSStatus;
FUNCTION OTDeleteNameByID(ref: MapperRef; nameID: OTNameID): OSStatus;
FUNCTION OTLookupName(ref: MapperRef; req: TLookupRequestPtr; reply: TLookupReplyPtr): OSStatus;
{
	-------------------------------------------------------------------------
	Miscellaneous and generic functions
	------------------------------------------------------------------------- 
}
FUNCTION OTAllocMem(size: size_t): Ptr; C;
PROCEDURE OTFreeMem(memptr: UNIV Ptr); C;
PROCEDURE OTDelay(seconds: UInt32);
PROCEDURE OTIdle;
FUNCTION OTCreateConfiguration(path: ConstCStringPtr): OTConfigurationPtr;
FUNCTION OTCloneConfiguration(cfig: OTConfigurationPtr): OTConfigurationPtr;
PROCEDURE OTDestroyConfiguration(cfig: OTConfigurationPtr);
FUNCTION OTCreateOptions(endPtName: ConstCStringPtr; strPtr: CStringPtrPtr; VAR buf: TNetbuf): OSStatus;
FUNCTION OTCreateOptionString(endPtName: ConstCStringPtr; VAR opt: TOptionPtr; bufEnd: UNIV Ptr; strPTr: CStringPtr; stringSize: size_t): OSStatus;
FUNCTION OTNextOption(VAR buffer: UInt8; buflen: UInt32; VAR prevOptPtr: TOptionPtr): OSStatus;
FUNCTION OTFindOption(VAR buffer: UInt8; buflen: UInt32; level: OTXTILevel; name: OTXTIName): TOptionPtr;
{$ENDC}
{
******************************************************************************
** Open Transport Utility routines
**
** These routines are available to both client and kernel
*******************************************************************************
}
{
	-------------------------------------------------------------------------
	** Memory functions
	------------------------------------------------------------------------- 
}
PROCEDURE OTMemcpy(dest: UNIV Ptr; src: UNIV Ptr; nBytes: size_t); C;
FUNCTION OTMemcmp(mem1: UNIV Ptr; mem2: UNIV Ptr; nBytes: size_t): BOOLEAN; C;
PROCEDURE OTMemmove(dest: UNIV Ptr; src: UNIV Ptr; nBytes: size_t); C;
PROCEDURE OTMemzero(dest: UNIV Ptr; nBytes: size_t); C;
PROCEDURE OTMemset(dest: UNIV Ptr; toSet: uchar_p; nBytes: size_t); C;
FUNCTION OTStrLength(strPtr: ConstCStringPtr): size_t; C;
PROCEDURE OTStrCopy(strTo: CStringPtr; strFrom: ConstCStringPtr); C;
PROCEDURE OTStrCat(strTo: CStringPtr; strFrom: ConstCStringPtr); C;
FUNCTION OTStrEqual(strPtr1: ConstCStringPtr; strPtr2: ConstCStringPtr): BOOLEAN; C;
{
	-------------------------------------------------------------------------
	** Time functions
	**	
	**	OTGetTimeStamp returns time in "tick" numbers, stored in 64 bits.
	**	This timestamp can be used as a base number for calculating elapsed 
	**	time.
	**	OTSubtractTimeStamps returns a pointer to the "result" parameter.
	**		
	**	OTGetClockTimeInSecs returns time since Open Transport was initialized
	**		in seconds.
	------------------------------------------------------------------------- 
}

TYPE
	OTTimeStamp							= UnsignedWide;
	OTTimeStampPtr 						= ^OTTimeStamp;
PROCEDURE OTGetTimeStamp(VAR stamp: OTTimeStamp); C;
FUNCTION OTSubtractTimeStamps(VAR result: OTTimeStamp; VAR startTime: OTTimeStamp; VAR endTime: OTTimeStamp): OTTimeStampPtr; C;
FUNCTION OTTimeStampInMilliseconds(VAR delta: OTTimeStamp): UInt32; C;
FUNCTION OTTimeStampInMicroseconds(VAR delta: OTTimeStamp): UInt32; C;
FUNCTION OTElapsedMilliseconds(VAR startTime: OTTimeStamp): UInt32; C;
FUNCTION OTElapsedMicroseconds(VAR startTime: OTTimeStamp): UInt32; C;
FUNCTION OTGetClockTimeInSecs: UInt32; C;
{
	-------------------------------------------------------------------------
	** OTLIFO
	**
	** These are functions to implement a LIFO list that is interrupt-safe.
	** The only function which is not is OTReverseList.  Normally, you create
	** a LIFO list, populate it at interrupt time, and then use OTLIFOStealList
	** to atomically remove the list, and OTReverseList to flip the list so that
	** it is a FIFO list, which tends to be more useful.
	------------------------------------------------------------------------- 
}

TYPE
	OTLinkPtr = ^OTLink;
	OTLIFOPtr = ^OTLIFO;
	OTLIFO = RECORD
		fHead:					OTLinkPtr;
	END;

	OTLink = RECORD
		fNext:					OTLinkPtr;
	END;

{
 This function puts "object" on the listHead, and places the
 previous value at listHead into the pointer at "object" plus
 linkOffset.
}
PROCEDURE OTEnqueue(VAR listHead: UNIV Ptr; object: UNIV Ptr; linkOffset: size_t); C;
{
 This function returns the head object of the list, and places
 the pointer at "object" + linkOffset into the listHead
}
FUNCTION OTDequeue(VAR listHead: UNIV Ptr; linkOffset: size_t): Ptr; C;
{  This function atomically enqueues the link onto the list }
PROCEDURE OTLIFOEnqueue(VAR list: OTLIFO; VAR link: OTLink); C;
{
 This function atomically dequeues the first element
 on the list
}
FUNCTION OTLIFODequeue(VAR list: OTLIFO): OTLinkPtr; C;
{
 This function atomically empties the list and returns a
 pointer to the first element on the list
}
FUNCTION OTLIFOStealList(VAR list: OTLIFO): OTLinkPtr; C;
{
 This function reverses a list that was stolen by
 OTLIFOStealList.  It is NOT atomic.  It returns the
 new starting list.
}
FUNCTION OTReverseList(VAR list: OTLink): OTLinkPtr; C;
{
	-------------------------------------------------------------------------
	** OTList
	**
	** An OTList is a non-interrupt-safe list, but has more features than the
	** OTLIFO list. It is a standard singly-linked list.
	------------------------------------------------------------------------- 
}

TYPE
	OTListPtr = ^OTList;
	OTList = RECORD
		fHead:					OTLinkPtr;
	END;

	OTListSearchProcPtr = ProcPtr;  { FUNCTION OTListSearch(ref: UNIV Ptr; VAR linkToCheck: OTLink): BOOLEAN; C; }

{  Add the link to the list at the front }
PROCEDURE OTAddFirst(VAR list: OTList; VAR link: OTLink); C;
{  Add the link to the list at the end }
PROCEDURE OTAddLast(VAR list: OTList; VAR link: OTLink); C;
{  Remove the first link from the list }
FUNCTION OTRemoveFirst(VAR list: OTList): OTLinkPtr; C;
{  Remove the last link from the list }
FUNCTION OTRemoveLast(VAR list: OTList): OTLinkPtr; C;
{  Return the first link from the list }
FUNCTION OTGetFirst(VAR list: OTList): OTLinkPtr; C;
{  Return the last link from the list }
FUNCTION OTGetLast(VAR list: OTList): OTLinkPtr; C;
{  Return true if the link is present in the list }
FUNCTION OTIsInList(VAR list: OTList; VAR link: OTLink): BOOLEAN; C;
{
 Find a link in the list which matches the search criteria
 established by the search proc and the refPtr.  This is done
 by calling the search proc, passing it the refPtr and each
 link in the list, until the search proc returns true.
 NULL is returned if the search proc never returned true.
}
FUNCTION OTFindLink(VAR listPtr: OTList; procPtr: OTListSearchProcPtr; refPtr: UNIV Ptr): OTLinkPtr; C;
{  Remove the specified link from the list, returning true if it was found }
FUNCTION OTRemoveLink(VAR listPtr: OTList; VAR linkPtr: OTLink): BOOLEAN; C;
{  Similar to OTFindLink, but it also removes it from the list. }
FUNCTION OTFindAndRemoveLink(VAR list: OTList; proc: OTListSearchProcPtr; refPtr: UNIV Ptr): OTLinkPtr; C;
{  Return the "index"th link in the list }
FUNCTION OTGetIndexedLink(VAR list: OTList; index: size_t): OTLinkPtr; C;
{
	-------------------------------------------------------------------------
	** Atomic Operations
	**
	** The Bit operations return the previous value of the bit (0 or non-zero).
	** The memory pointed to must be a single byte and only bits 0 through 7 are
	** valid.  Bit 0 corresponds to a mask of 0x01, and Bit 7 to a mask of 0x80.
	------------------------------------------------------------------------- 
}

TYPE
	OTLock								= UInt8;
FUNCTION OTAtomicSetBit(VAR ptr: UInt8; len: size_t): BOOLEAN; C;
FUNCTION OTAtomicClearBit(VAR ptr: UInt8; len: size_t): BOOLEAN; C;
FUNCTION OTAtomicTestBit(VAR ptr: UInt8; len: size_t): BOOLEAN; C;
{
 WARNING! void* and UInt32 locations MUST be on 4-byte boundaries.
			UInt16 locations must not cross a 4-byte boundary.
}
FUNCTION OTCompareAndSwapPtr(oldValue: UNIV Ptr; newValue: UNIV Ptr; VAR location: UNIV Ptr): BOOLEAN; C;
FUNCTION OTCompareAndSwap32(oldValue: UInt32; newValue: UInt32; VAR location: UInt32): BOOLEAN; C;
FUNCTION OTCompareAndSwap16(oldValue: UInt32; newValue: UInt32; VAR location: UInt16): BOOLEAN; C;
FUNCTION OTCompareAndSwap8(oldValue: UInt32; newValue: UInt32; VAR location: UInt8): BOOLEAN; C;
{
 WARNING! UInt32 locations MUST be on 4-byte boundaries.
			UInt16 locations must not cross a 4-byte boundary.
}
FUNCTION OTAtomicAdd32(val: SInt32; VAR ptr: SInt32): SInt32; C;
FUNCTION OTAtomicAdd16(val: SInt16; VAR ptr: SInt16): SInt16; C;
FUNCTION OTAtomicAdd8(val: SInt8; VAR ptr: SInt8): SInt8; C;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OpenTransportIncludes}

{$ENDC} {__OPENTRANSPORT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

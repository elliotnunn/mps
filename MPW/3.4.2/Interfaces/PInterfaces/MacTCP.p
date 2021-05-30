{
 	File:		MacTCP.p
 
 	Contains:	TCP Manager Interfaces.
 
 	Version:	Technology:	MacTCP 2.0.6
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MacTCP;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MACTCP__}
{$SETC __MACTCP__ := 1}

{$I+}
{$SETC MacTCPIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __APPLETALK__}
{$I AppleTalk.p}
{$ENDC}
{	OSUtils.p													}
{		MixedMode.p												}
{		Memory.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
{
Developer Notes:
		0. This MacTCP header replaces what used to be defined in the following header files
			MacTCPCommonTypes.h
			GetMyIPAddr.h
			MiscIPPB.h
			TCPPB.h
			UDPPB.h 
			
			When the various control calls are made to the ip driver, you must set up a 
			NewRoutineDescriptor for every non-nil completion routine and/or notifyProc parameter.  
			Otherwise, the 68K driver code, will not correctly call your routine.
		1. For ipctlGetAddr Control calls, use NewGetIPIOCompletionProc
			to set up a GetIPIOCompletionUPP universal procptr to pass as
			the ioCompletion parameter.
		2. For the ipctlEchoICMP and ipctlLAPStats Control calls, use 
			NewIPIOCompletion to set up a IPIOCompletionUPP universal procptr
			to pass in the ioCompletion field of the parameter block.
		3. For TCPCreatePB Control calls, use NewTCPNotifyProc to set up a
			TCPNotifyUPP universal procptr to pass in the notifyProc field
			of the parameter block
		4. For all of the TCP Control calls using the TCPiopb parameter block,
			use NewTCPIOCompletionProc to set up a TCPIOCompletionUPP
			universal procptr to pass in the ioCompletion field of the paramter
			block.
		5. For UDBCreatePB Control calls, use NewUDPNotifyProc to set up a
			UDPNotifyUPP universal procptr to pass in the notifyProc field
			of the parameter block
		6. For all of the UDP Control calls using the UDPiopb parameter block,
			use NewUDPIOCompletionProc to set up a UDPIOCompletionUPP
			universal procptr to pass in the ioCompletion field of the paramter
			block.
		7. For all calls implementing a notifyProc or ioCompletion routine
			which was set up using a NewTCPRoutineProc call, do not call
			DisposeRoutineSDescriptor on the universal procptr until
			after the completion or notify proc has completed.
}
{ MacTCP return Codes in the range -23000 through -23049 }

CONST
	inProgress					= 1;							{ I/O in progress }
	ipBadLapErr					= -23000;						{ bad network configuration }
	ipBadCnfgErr				= -23001;						{ bad IP configuration error }
	ipNoCnfgErr					= -23002;						{ missing IP or LAP configuration error }
	ipLoadErr					= -23003;						{ error in MacTCP load }
	ipBadAddr					= -23004;						{ error in getting address }
	connectionClosing			= -23005;						{ connection is closing }
	invalidLength				= -23006;
	connectionExists			= -23007;						{ request conflicts with existing connection }
	connectionDoesntExist		= -23008;						{ connection does not exist }
	insufficientResources		= -23009;						{ insufficient resources to perform request }
	invalidStreamPtr			= -23010;
	streamAlreadyOpen			= -23011;
	connectionTerminated		= -23012;
	invalidBufPtr				= -23013;
	invalidRDS					= -23014;
	invalidWDS					= -23014;
	openFailed					= -23015;
	commandTimeout				= -23016;
	duplicateSocket				= -23017;

{ Error codes from internal IP functions }
	ipDontFragErr				= -23032;						{ Packet too large to send w/o fragmenting }
	ipDestDeadErr				= -23033;						{ destination not responding }
	icmpEchoTimeoutErr			= -23035;						{ ICMP echo timed-out }
	ipNoFragMemErr				= -23036;						{ no memory to send fragmented pkt }
	ipRouteErr					= -23037;						{ can't route packet off-net }
	nameSyntaxErr				= -23041;
	cacheFault					= -23042;
	noResultProc				= -23043;
	noNameServer				= -23044;
	authNameErr					= -23045;
	noAnsErr					= -23046;
	dnrErr						= -23047;
	outOfMemory					= -23048;

	BYTES_16WORD				= 2;							{ bytes per = 16, bit ip word }
	BYTES_32WORD				= 4;							{ bytes per = 32, bit ip word }
	BYTES_64WORD				= 8;							{ bytes per = 64, bit ip word }

{ 8-bit quantity }
	
TYPE
	b_8 = UInt8;

{ 16-bit quantity }
	b_16 = UInt16;

{ 32-bit quantity }
	b_32 = UInt32;

{ IP address is 32-bits }
	ip_addr = b_32;

	ip_addrbytes = RECORD
		CASE INTEGER OF
		0: (
			addr:						b_32;
		   );
		1: (
			byte:						PACKED ARRAY [0..3] OF SInt8; (* UInt8 *)
		   );

	END;

	wdsEntry = RECORD
		length:					INTEGER;								{ length of buffer }
		ptr:					Ptr;									{ pointer to buffer }
	END;

	rdsEntry = RECORD
		length:					INTEGER;								{ length of buffer }
		ptr:					Ptr;									{ pointer to buffer }
	END;

	BufferPtr = LONGINT;

	StreamPtr = LONGINT;


CONST
	netUnreach					= 0;
	hostUnreach					= 1;
	protocolUnreach				= 2;
	portUnreach					= 3;
	fragReqd					= 4;
	sourceRouteFailed			= 5;
	timeExceeded				= 6;
	parmProblem					= 7;
	missingOption				= 8;
	lastICMPMsgType				= 32767;

	
TYPE
	ICMPMsgType = INTEGER;

	ip_port = b_16;

	ICMPReport = RECORD
		streamPtr:				StreamPtr;
		localHost:				ip_addr;
		localPort:				ip_port;
		remoteHost:				ip_addr;
		remotePort:				ip_port;
		reportType:				INTEGER;
		optionalAddlInfo:		INTEGER;
		optionalAddlInfoPtr:	LONGINT;
	END;

{ csCode to get our IP address }

CONST
	ipctlGetAddr				= 15;

TYPE
	GetIPIOCompletionProcPtr = ProcPtr;  { PROCEDURE GetIPIOCompletion(VAR iopb: GetAddrParamBlock); }
	GetIPIOCompletionUPP = UniversalProcPtr;

	GetAddrParamBlock = RECORD
		qLink:					^QElem;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			GetIPIOCompletionUPP;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		ioCRefNum:				INTEGER;
		csCode:					INTEGER;								{ standard I/O header }
		ourAddress:				ip_addr;								{ our IP address }
		ourNetMask:				LONGINT;								{ our IP net mask }
	END;

{ control codes }

CONST
	ipctlEchoICMP				= 17;							{ send icmp echo }
	ipctlLAPStats				= 19;							{ get lap stats }

TYPE
	IPIOCompletionProcPtr = ProcPtr;  { PROCEDURE IPIOCompletion(VAR iopb: ICMPParamBlock); }
	IPIOCompletionUPP = UniversalProcPtr;

	ICMPParamBlock = RECORD
		qLink:					^QElem;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			IPIOCompletionUPP;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		ioCRefNum:				INTEGER;
		csCode:					INTEGER;								{ standard I/O header }
		params:					ARRAY [0..10] OF INTEGER;
		icmpEchoInfo:			RECORD
				echoRequestOut:					LONGINT;						{ time in ticks of when the echo request went out }
				echoReplyIn:					LONGINT;						{ time in ticks of when the reply was received }
				echoedData:						rdsEntry;						{ data received in responce }
				options:						Ptr;
				userDataPtr:					LONGINT;
			END;


	END;

	ICMPEchoNotifyProcPtr = ProcPtr;  { PROCEDURE ICMPEchoNotify(VAR iopb: ICMPParamBlock); }
	ICMPEchoNotifyUPP = UniversalProcPtr;

	IPParamBlock = RECORD
		qLink:					^QElem;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			IPIOCompletionUPP;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		ioCRefNum:				INTEGER;
		csCode:					INTEGER;								{ standard I/O header }
		CASE INTEGER OF
		0: (
			dest:						ip_addr;							{ echo to IP address }
			data:						wdsEntry;
			timeout:					INTEGER;
			options:					Ptr;
			optLength:					INTEGER;
			icmpCompletion:				ICMPEchoNotifyUPP;
			userDataPtr:				LONGINT;
		   );
		1: (
			lapStatsPtr:				^LAPStats;
		   );

	END;

	LAPStatsAddrXlation = RECORD
		CASE INTEGER OF
		0: (
			arp_table:					^arp_entry;
		   );
		1: (
			nbp_table:					^nbp_entry;
		   );
	END;

	LAPStats = RECORD
		ifType:					INTEGER;
		ifString:				^CHAR;
		ifMaxMTU:				INTEGER;
		ifSpeed:				LONGINT;
		ifPhyAddrLength:		INTEGER;
		ifPhysicalAddress:		^CHAR;
		AddrXlation:			LAPStatsAddrXlation;
		slotNumber:				INTEGER;
	END;

	nbp_entry = RECORD
		ip_address:				ip_addr;								{ IP address }
		at_address:				AddrBlock;								{ matching AppleTalk address }
		gateway:				BOOLEAN;								{ TRUE if entry for a gateway }
		valid:					BOOLEAN;								{ TRUE if LAP address is valid }
		probing:				BOOLEAN;								{ TRUE if NBP lookup pending }
		afiller:				SInt8;									{ Filler for proper byte alignment	 }
		age:					LONGINT;								{ ticks since cache entry verified }
		access:					LONGINT;								{ ticks since last access }
		filler:					ARRAY [0..115] OF SInt8;				{ for internal use only !!! }
	END;

	Enet_addr = RECORD
		en_hi:					b_16;
		en_lo:					b_32;
	END;

	arp_entry = RECORD
		age:					INTEGER;								{ cache aging field }
		protocol:				b_16;									{ Protocol type }
		ip_address:				ip_addr;								{ IP address }
		en_address:				Enet_addr;								{ matching Ethernet address }
	END;

{ number of ARP table entries }

CONST
	ARP_TABLE_SIZE				= 20;

	NBP_TABLE_SIZE				= 20;							{ number of NBP table entries }
	NBP_MAX_NAME_SIZE			= 16 + 10 + 2;

{ Command codes }
	TCPCreate					= 30;
	TCPPassiveOpen				= 31;
	TCPActiveOpen				= 32;
	TCPSend						= 34;
	TCPNoCopyRcv				= 35;
	TCPRcvBfrReturn				= 36;
	TCPRcv						= 37;
	TCPClose					= 38;
	TCPAbort					= 39;
	TCPStatus					= 40;
	TCPExtendedStat				= 41;
	TCPRelease					= 42;
	TCPGlobalInfo				= 43;
	TCPCtlMax					= 49;

	TCPClosing					= 1;
	TCPULPTimeout				= 2;
	TCPTerminate				= 3;
	TCPDataArrival				= 4;
	TCPUrgent					= 5;
	TCPICMPReceived				= 6;
	lastEvent					= 32767;

	
TYPE
	TCPEventCode = INTEGER;


CONST
	TCPRemoteAbort				= 2;
	TCPNetworkFailure			= 3;
	TCPSecPrecMismatch			= 4;
	TCPULPTimeoutTerminate		= 5;
	TCPULPAbort					= 6;
	TCPULPClose					= 7;
	TCPServiceError				= 8;
	lastReason					= 32767;

	
TYPE
	TCPTerminationReason = INTEGER;

	TCPNotifyProcPtr = ProcPtr;  { PROCEDURE TCPNotify(tcpStream: StreamPtr; eventCode: INTEGER; userDataPtr: Ptr; terminReason: INTEGER; VAR icmpMsg: ICMPReport); }
	TCPNotifyUPP = UniversalProcPtr;

	tcp_port = INTEGER;

{ ValidityFlags }

CONST
	timeoutValue				= $80;
	timeoutAction				= $40;
	typeOfService				= $20;
	precedence					= $10;

{ TOSFlags }
	lowDelay					= $01;
	throughPut					= $02;
	reliability					= $04;


TYPE
	TCPCreatePB = RECORD
		rcvBuff:				Ptr;
		rcvBuffLen:				LONGINT;
		notifyProc:				TCPNotifyUPP;
		userDataPtr:			Ptr;
	END;

	TCPOpenPB = RECORD
		ulpTimeoutValue:		SInt8;
		ulpTimeoutAction:		SInt8;
		validityFlags:			SInt8;
		commandTimeoutValue:	SInt8;
		remoteHost:				ip_addr;
		remotePort:				tcp_port;
		localHost:				ip_addr;
		localPort:				tcp_port;
		tosFlags:				SInt8;
		precedence:				SInt8;
		dontFrag:				BOOLEAN;
		timeToLive:				SInt8;
		security:				SInt8;
		optionCnt:				SInt8;
		options:				ARRAY [0..39] OF SInt8;
		userDataPtr:			Ptr;
	END;

	TCPSendPB = RECORD
		ulpTimeoutValue:		SInt8;
		ulpTimeoutAction:		SInt8;
		validityFlags:			SInt8;
		pushFlag:				BOOLEAN;
		urgentFlag:				BOOLEAN;
		filler:					SInt8;									{ Filler for proper byte alignment	 }
		wdsPtr:					Ptr;
		sendFree:				LONGINT;
		sendLength:				INTEGER;
		userDataPtr:			Ptr;
	END;

{ for receive and return rcv buff calls }
{   Note: the filler in the following structure is in a different location than }
{         that specified in the Programmer's Guide.  }
	TCPReceivePB = RECORD
		commandTimeoutValue:	SInt8;
		markFlag:				BOOLEAN;
		urgentFlag:				BOOLEAN;
		filler:					SInt8;									{ Filler for proper byte alignment  }
		rcvBuff:				Ptr;
		rcvBuffLen:				INTEGER;
		rdsPtr:					Ptr;
		rdsLength:				INTEGER;
		secondTimeStamp:		INTEGER;
		userDataPtr:			Ptr;
	END;

	TCPClosePB = RECORD
		ulpTimeoutValue:		SInt8;
		ulpTimeoutAction:		SInt8;
		validityFlags:			SInt8;
		filler:					SInt8;									{ Filler for proper byte alignment	 }
		userDataPtr:			Ptr;
	END;

	HistoBucket = RECORD
		value:					INTEGER;
		counter:				LONGINT;
	END;


CONST
	NumOfHistoBuckets			= 7;


TYPE
	TCPConnectionStats = RECORD
		dataPktsRcvd:			LONGINT;
		dataPktsSent:			LONGINT;
		dataPktsResent:			LONGINT;
		bytesRcvd:				LONGINT;
		bytesRcvdDup:			LONGINT;
		bytesRcvdPastWindow:	LONGINT;
		bytesSent:				LONGINT;
		bytesResent:			LONGINT;
		numHistoBuckets:		INTEGER;
		sentSizeHisto:			ARRAY [0..NumOfHistoBuckets-1] OF HistoBucket;
		lastRTT:				INTEGER;
		tmrSRTT:				INTEGER;
		rttVariance:			INTEGER;
		tmrRTO:					INTEGER;
		sendTries:				SInt8;
		sourchQuenchRcvd:		SInt8;
	END;

	TCPStatusPB = RECORD
		ulpTimeoutValue:		SInt8;
		ulpTimeoutAction:		SInt8;
		unused:					LONGINT;
		remoteHost:				ip_addr;
		remotePort:				tcp_port;
		localHost:				ip_addr;
		localPort:				tcp_port;
		tosFlags:				SInt8;
		precedence:				SInt8;
		connectionState:		SInt8;
		filler:					SInt8;									{ Filler for proper byte alignment	 }
		sendWindow:				INTEGER;
		rcvWindow:				INTEGER;
		amtUnackedData:			INTEGER;
		amtUnreadData:			INTEGER;
		securityLevelPtr:		Ptr;
		sendUnacked:			LONGINT;
		sendNext:				LONGINT;
		congestionWindow:		LONGINT;
		rcvNext:				LONGINT;
		srtt:					LONGINT;
		lastRTT:				LONGINT;
		sendMaxSegSize:			LONGINT;
		connStatPtr:			^TCPConnectionStats;
		userDataPtr:			Ptr;
	END;

	TCPAbortPB = RECORD
		userDataPtr:			Ptr;
	END;

	TCPParam = RECORD
		tcpRtoA:				LONGINT;
		tcpRtoMin:				LONGINT;
		tcpRtoMax:				LONGINT;
		tcpMaxSegSize:			LONGINT;
		tcpMaxConn:				LONGINT;
		tcpMaxWindow:			LONGINT;
	END;

	TCPStats = RECORD
		tcpConnAttempts:		LONGINT;
		tcpConnOpened:			LONGINT;
		tcpConnAccepted:		LONGINT;
		tcpConnClosed:			LONGINT;
		tcpConnAborted:			LONGINT;
		tcpOctetsIn:			LONGINT;
		tcpOctetsOut:			LONGINT;
		tcpOctetsInDup:			LONGINT;
		tcpOctetsRetrans:		LONGINT;
		tcpInputPkts:			LONGINT;
		tcpOutputPkts:			LONGINT;
		tcpDupPkts:				LONGINT;
		tcpRetransPkts:			LONGINT;
	END;

	StreamPPtr = ^StreamPtr;

	TCPGlobalInfoPB = RECORD
		tcpParamPtr:			^TCPParam;
		tcpStatsPtr:			^TCPStats;
		tcpCDBTable:			ARRAY [0..0] OF StreamPPtr;
		userDataPtr:			Ptr;
		maxTCPConnections:		INTEGER;
	END;

	TCPIOCompletionProcPtr = ProcPtr;  { PROCEDURE TCPIOCompletion(VAR iopb: TCPiopb); }
	TCPIOCompletionUPP = UniversalProcPtr;

	TCPiopb = RECORD
		fill12:					ARRAY [0..11] OF SInt8;
		ioCompletion:			TCPIOCompletionUPP;
		ioResult:				INTEGER;
		ioNamePtr:				Ptr;
		ioVRefNum:				INTEGER;
		ioCRefNum:				INTEGER;
		csCode:					INTEGER;
		tcpStream:				StreamPtr;
		CASE INTEGER OF
		0: (
			create:						TCPCreatePB;
		   );
		1: (
			open:						TCPOpenPB;
		   );
		2: (
			send:						TCPSendPB;
		   );
		3: (
			receive:					TCPReceivePB;
		   );
		4: (
			close:						TCPClosePB;
		   );
		5: (
			abort:						TCPAbortPB;
		   );
		6: (
			status:						TCPStatusPB;
		   );
		7: (
			globalInfo:					TCPGlobalInfoPB;
		   );

	END;


CONST
	UDPCreate					= 20;
	UDPRead						= 21;
	UDPBfrReturn				= 22;
	UDPWrite					= 23;
	UDPRelease					= 24;
	UDPMaxMTUSize				= 25;
	UDPStatus					= 26;
	UDPMultiCreate				= 27;
	UDPMultiSend				= 28;
	UDPMultiRead				= 29;
	UDPCtlMax					= 29;

	UDPDataArrival				= 1;
	UDPICMPReceived				= 2;
	lastUDPEvent				= 32767;

	
TYPE
	UDPEventCode = INTEGER;

	UDPNotifyProcPtr = ProcPtr;  { PROCEDURE UDPNotify(udpStream: StreamPtr; eventCode: INTEGER; userDataPtr: Ptr; VAR icmpMsg: ICMPReport); }
	UDPNotifyUPP = UniversalProcPtr;

	udp_port = INTEGER;

{ for create and release calls }
	UDPCreatePB = RECORD
		rcvBuff:				Ptr;
		rcvBuffLen:				LONGINT;
		notifyProc:				UDPNotifyUPP;
		localPort:				INTEGER;
		userDataPtr:			Ptr;
		endingPort:				udp_port;
	END;

	UDPSendPB = RECORD
		reserved:				INTEGER;
		remoteHost:				ip_addr;
		remotePort:				udp_port;
		wdsPtr:					Ptr;
		checkSum:				BOOLEAN;
		filler:					SInt8;									{ Filler for proper byte alignment	 }
		sendLength:				INTEGER;
		userDataPtr:			Ptr;
		localPort:				udp_port;
	END;

{ for receive and buffer return calls }
	UDPReceivePB = RECORD
		timeOut:				INTEGER;
		remoteHost:				ip_addr;
		remotePort:				udp_port;
		rcvBuff:				Ptr;
		rcvBuffLen:				INTEGER;
		secondTimeStamp:		INTEGER;
		userDataPtr:			Ptr;
		destHost:				ip_addr;								{ only for use with multi rcv }
		destPort:				udp_port;								{ only for use with multi rcv }
	END;

	UDPMTUPB = RECORD
		mtuSize:				INTEGER;
		remoteHost:				ip_addr;
		userDataPtr:			Ptr;
	END;

	UDPIOCompletionProcPtr = ProcPtr;  { PROCEDURE UDPIOCompletion(VAR iopb: UDPiopb); }
	UDPIOCompletionUPP = UniversalProcPtr;

	UDPiopb = RECORD
		fill12:					ARRAY [0..11] OF SInt8;
		ioCompletion:			UDPIOCompletionUPP;
		ioResult:				INTEGER;
		ioNamePtr:				Ptr;
		ioVRefNum:				INTEGER;
		ioCRefNum:				INTEGER;
		csCode:					INTEGER;
		udpStream:				StreamPtr;
		CASE INTEGER OF
		0: (
			create:						UDPCreatePB;
		   );
		1: (
			send:						UDPSendPB;
		   );
		2: (
			receive:					UDPReceivePB;
		   );
		3: (
			mtu:						UDPMTUPB;
		   );

	END;


CONST
	uppGetIPIOCompletionProcInfo = $000000C1; { PROCEDURE (4 byte param); }
	uppIPIOCompletionProcInfo = $000000C1; { PROCEDURE (4 byte param); }
	uppICMPEchoNotifyProcInfo = $000000C1; { PROCEDURE (4 byte param); }
	uppTCPNotifyProcInfo = $0000EEC0; { PROCEDURE (4 byte param, 2 byte param, 4 byte param, 2 byte param, 4 byte param); }
	uppTCPIOCompletionProcInfo = $000000C1; { PROCEDURE (4 byte param); }
	uppUDPNotifyProcInfo = $00003EC0; { PROCEDURE (4 byte param, 2 byte param, 4 byte param, 4 byte param); }
	uppUDPIOCompletionProcInfo = $000000C1; { PROCEDURE (4 byte param); }

FUNCTION NewGetIPIOCompletionProc(userRoutine: GetIPIOCompletionProcPtr): GetIPIOCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewIPIOCompletionProc(userRoutine: IPIOCompletionProcPtr): IPIOCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewICMPEchoNotifyProc(userRoutine: ICMPEchoNotifyProcPtr): ICMPEchoNotifyUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTCPNotifyProc(userRoutine: TCPNotifyProcPtr): TCPNotifyUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTCPIOCompletionProc(userRoutine: TCPIOCompletionProcPtr): TCPIOCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewUDPNotifyProc(userRoutine: UDPNotifyProcPtr): UDPNotifyUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewUDPIOCompletionProc(userRoutine: UDPIOCompletionProcPtr): UDPIOCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallGetIPIOCompletionProc(VAR iopb: GetAddrParamBlock; userRoutine: GetIPIOCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallIPIOCompletionProc(VAR iopb: ICMPParamBlock; userRoutine: IPIOCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallICMPEchoNotifyProc(VAR iopb: ICMPParamBlock; userRoutine: ICMPEchoNotifyUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallTCPNotifyProc(tcpStream: StreamPtr; eventCode: INTEGER; userDataPtr: Ptr; terminReason: INTEGER; VAR icmpMsg: ICMPReport; userRoutine: TCPNotifyUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallTCPIOCompletionProc(VAR iopb: TCPiopb; userRoutine: TCPIOCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallUDPNotifyProc(udpStream: StreamPtr; eventCode: INTEGER; userDataPtr: Ptr; VAR icmpMsg: ICMPReport; userRoutine: UDPNotifyUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallUDPIOCompletionProc(VAR iopb: UDPiopb; userRoutine: UDPIOCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MacTCPIncludes}

{$ENDC} {__MACTCP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

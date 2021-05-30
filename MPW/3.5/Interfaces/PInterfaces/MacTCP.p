{
     File:       MacTCP.p
 
     Contains:   TCP Manager Interfaces.
 
     Version:    Technology: MacTCP 2.0.6
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1989-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __APPLETALK__}
{$I AppleTalk.p}
{$ENDC}


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
	inProgress					= 1;							{  I/O in progress  }
	ipBadLapErr					= -23000;						{  bad network configuration  }
	ipBadCnfgErr				= -23001;						{  bad IP configuration error  }
	ipNoCnfgErr					= -23002;						{  missing IP or LAP configuration error  }
	ipLoadErr					= -23003;						{  error in MacTCP load  }
	ipBadAddr					= -23004;						{  error in getting address  }
	connectionClosing			= -23005;						{  connection is closing  }
	invalidLength				= -23006;
	connectionExists			= -23007;						{  request conflicts with existing connection  }
	connectionDoesntExist		= -23008;						{  connection does not exist  }
	insufficientResources		= -23009;						{  insufficient resources to perform request  }
	invalidStreamPtr			= -23010;
	streamAlreadyOpen			= -23011;
	connectionTerminated		= -23012;
	invalidBufPtr				= -23013;
	invalidRDS					= -23014;
	invalidWDS					= -23014;
	openFailed					= -23015;
	commandTimeout				= -23016;
	duplicateSocket				= -23017;

	{	 Error codes from internal IP functions 	}
	ipDontFragErr				= -23032;						{  Packet too large to send w/o fragmenting  }
	ipDestDeadErr				= -23033;						{  destination not responding  }
	icmpEchoTimeoutErr			= -23035;						{  ICMP echo timed-out  }
	ipNoFragMemErr				= -23036;						{  no memory to send fragmented pkt  }
	ipRouteErr					= -23037;						{  can't route packet off-net  }
	nameSyntaxErr				= -23041;
	cacheFault					= -23042;
	noResultProc				= -23043;
	noNameServer				= -23044;
	authNameErr					= -23045;
	noAnsErr					= -23046;
	dnrErr						= -23047;
	outOfMemory					= -23048;


	BYTES_16WORD				= 2;							{  bytes per = 16, bit ip word  }
	BYTES_32WORD				= 4;							{  bytes per = 32, bit ip word  }
	BYTES_64WORD				= 8;							{  bytes per = 64, bit ip word  }

	{	 8-bit quantity 	}

TYPE
	b_8									= UInt8;
	{	 16-bit quantity 	}
	b_16								= UInt16;
	{	 32-bit quantity 	}
	b_32								= UInt32;
	{	 IP address is 32-bits 	}
	ip_addr								= b_32;
	ip_addrbytesPtr = ^ip_addrbytes;
	ip_addrbytes = RECORD
		CASE INTEGER OF
		0: (
			addr:				b_32;
			);
		1: (
			byte:				PACKED ARRAY [0..3] OF UInt8;
			);
	END;

	wdsEntryPtr = ^wdsEntry;
	wdsEntry = RECORD
		length:					UInt16;									{  length of buffer  }
		ptr:					Ptr;									{  pointer to buffer  }
	END;

	rdsEntryPtr = ^rdsEntry;
	rdsEntry = RECORD
		length:					UInt16;									{  length of buffer  }
		ptr:					Ptr;									{  pointer to buffer  }
	END;

	BufferPtr							= UInt32;
	StreamPtr							= UInt32;

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
	ICMPMsgType							= UInt16;
	ip_port								= b_16;
	ICMPReportPtr = ^ICMPReport;
	ICMPReport = RECORD
		streamPtr:				StreamPtr;
		localHost:				ip_addr;
		localPort:				ip_port;
		remoteHost:				ip_addr;
		remotePort:				ip_port;
		reportType:				INTEGER;
		optionalAddlInfo:		UInt16;
		optionalAddlInfoPtr:	UInt32;
	END;

	{	 csCode to get our IP address 	}

CONST
	ipctlGetAddr				= 15;


TYPE
	GetAddrParamBlockPtr = ^GetAddrParamBlock;
{$IFC TYPED_FUNCTION_POINTERS}
	GetIPIOCompletionProcPtr = PROCEDURE(iopb: GetAddrParamBlockPtr); C;
{$ELSEC}
	GetIPIOCompletionProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	GetIPIOCompletionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	GetIPIOCompletionUPP = UniversalProcPtr;
{$ENDC}	
	GetAddrParamBlock = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			GetIPIOCompletionUPP;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		ioCRefNum:				INTEGER;
		csCode:					INTEGER;
		ourAddress:				ip_addr;								{  our IP address  }
		ourNetMask:				LONGINT;								{  our IP net mask  }
	END;

	{	 control codes 	}

CONST
	ipctlEchoICMP				= 17;							{  send icmp echo  }
	ipctlLAPStats				= 19;							{  get lap stats  }



TYPE
	ICMPParamBlockPtr = ^ICMPParamBlock;
{$IFC TYPED_FUNCTION_POINTERS}
	IPIOCompletionProcPtr = PROCEDURE(iopb: ICMPParamBlockPtr); C;
{$ELSEC}
	IPIOCompletionProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	IPIOCompletionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	IPIOCompletionUPP = UniversalProcPtr;
{$ENDC}	
	ICMPParamBlock = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			IPIOCompletionUPP;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		ioCRefNum:				INTEGER;
		csCode:					INTEGER;
		params:					ARRAY [0..10] OF INTEGER;
		echoRequestOut:			UInt32;									{  time in ticks of when the echo request went out  }
		echoReplyIn:			UInt32;									{  time in ticks of when the reply was received  }
		echoedData:				rdsEntry;								{  data received in responce  }
		options:				Ptr;
		userDataPtr:			UInt32;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	ICMPEchoNotifyProcPtr = PROCEDURE(VAR iopb: ICMPParamBlock); C;
{$ELSEC}
	ICMPEchoNotifyProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ICMPEchoNotifyUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ICMPEchoNotifyUPP = UniversalProcPtr;
{$ENDC}	
	LAPStatsPtr = ^LAPStats;
	IPParamBlockPtr = ^IPParamBlock;
	IPParamBlock = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			IPIOCompletionUPP;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		ioCRefNum:				INTEGER;
		csCode:					INTEGER;
		CASE INTEGER OF
		0: (
			dest:				ip_addr;								{  echo to IP address  }
			data:				wdsEntry;
			timeout:			INTEGER;
			options:			Ptr;
			optLength:			UInt16;
			icmpCompletion:		ICMPEchoNotifyUPP;
			userDataPtr:		UInt32;
		   );
		1: (
			lapStatsPtr:		LAPStatsPtr;
		   );
	END;


	nbp_entryPtr = ^nbp_entry;
	nbp_entry = RECORD
		ip_address:				ip_addr;								{  IP address  }
		at_address:				AddrBlock;								{  matching AppleTalk address  }
		gateway:				BOOLEAN;								{  TRUE if entry for a gateway  }
		valid:					BOOLEAN;								{  TRUE if LAP address is valid  }
		probing:				BOOLEAN;								{  TRUE if NBP lookup pending  }
		afiller:				SInt8;									{  Filler for proper byte alignment     }
		age:					LONGINT;								{  ticks since cache entry verified  }
		access:					LONGINT;								{  ticks since last access  }
		filler:					ARRAY [0..115] OF SInt8;				{  for internal use only !!!  }
	END;

	Enet_addrPtr = ^Enet_addr;
	Enet_addr = RECORD
		en_hi:					b_16;
		en_lo:					b_32;
	END;

	arp_entryPtr = ^arp_entry;
	arp_entry = RECORD
		age:					INTEGER;								{  cache aging field  }
		protocol:				b_16;									{  Protocol type  }
		ip_address:				ip_addr;								{  IP address  }
		en_address:				Enet_addr;								{  matching Ethernet address  }
	END;

	LAPStatsAddrXlationPtr = ^LAPStatsAddrXlation;
	LAPStatsAddrXlation = RECORD
		CASE INTEGER OF
		0: (
			arp_table:			arp_entryPtr;
			);
		1: (
			nbp_table:			nbp_entryPtr;
			);
	END;

	LAPStats = RECORD
		ifType:					INTEGER;
		ifString:				CStringPtr;
		ifMaxMTU:				INTEGER;
		ifSpeed:				LONGINT;
		ifPhyAddrLength:		INTEGER;
		ifPhysicalAddress:		CStringPtr;
		AddrXlation:			LAPStatsAddrXlation;
		slotNumber:				INTEGER;
	END;

	{	 number of ARP table entries 	}

CONST
	ARP_TABLE_SIZE				= 20;

	NBP_TABLE_SIZE				= 20;							{  number of NBP table entries  }
	NBP_MAX_NAME_SIZE			= 28;



	{	 Command codes 	}
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
	TCPEventCode						= UInt16;

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
	TCPTerminationReason				= UInt16;
{$IFC TYPED_FUNCTION_POINTERS}
	TCPNotifyProcPtr = PROCEDURE(tcpStream: StreamPtr; eventCode: UInt16; userDataPtr: Ptr; terminReason: UInt16; VAR icmpMsg: ICMPReport);
{$ELSEC}
	TCPNotifyProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	TCPNotifyUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TCPNotifyUPP = UniversalProcPtr;
{$ENDC}	
	tcp_port							= UInt16;
	{	 ValidityFlags 	}

CONST
	timeoutValue				= $80;
	timeoutAction				= $40;
	typeOfService				= $20;
	precedence					= $10;

	{	 TOSFlags 	}
	lowDelay					= $01;
	throughPut					= $02;
	reliability					= $04;


TYPE
	TCPCreatePBPtr = ^TCPCreatePB;
	TCPCreatePB = RECORD
		rcvBuff:				Ptr;
		rcvBuffLen:				UInt32;
		notifyProc:				TCPNotifyUPP;
		userDataPtr:			Ptr;
	END;

	TCPOpenPBPtr = ^TCPOpenPB;
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


	TCPSendPBPtr = ^TCPSendPB;
	TCPSendPB = RECORD
		ulpTimeoutValue:		SInt8;
		ulpTimeoutAction:		SInt8;
		validityFlags:			SInt8;
		pushFlag:				BOOLEAN;
		urgentFlag:				BOOLEAN;
		filler:					SInt8;									{  Filler for proper byte alignment     }
		wdsPtr:					Ptr;
		sendFree:				UInt32;
		sendLength:				UInt16;
		userDataPtr:			Ptr;
	END;


	{	 for receive and return rcv buff calls 	}
	{	   Note: the filler in the following structure is in a different location than 	}
	{	         that specified in the Programmer's Guide.  	}
	TCPReceivePBPtr = ^TCPReceivePB;
	TCPReceivePB = RECORD
		commandTimeoutValue:	SInt8;
		markFlag:				BOOLEAN;
		urgentFlag:				BOOLEAN;
		filler:					SInt8;									{  Filler for proper byte alignment   }
		rcvBuff:				Ptr;
		rcvBuffLen:				UInt16;
		rdsPtr:					Ptr;
		rdsLength:				UInt16;
		secondTimeStamp:		UInt16;
		userDataPtr:			Ptr;
	END;


	TCPClosePBPtr = ^TCPClosePB;
	TCPClosePB = RECORD
		ulpTimeoutValue:		SInt8;
		ulpTimeoutAction:		SInt8;
		validityFlags:			SInt8;
		filler:					SInt8;									{  Filler for proper byte alignment     }
		userDataPtr:			Ptr;
	END;

	HistoBucketPtr = ^HistoBucket;
	HistoBucket = RECORD
		value:					UInt16;
		counter:				UInt32;
	END;


CONST
	NumOfHistoBuckets			= 7;


TYPE
	TCPConnectionStatsPtr = ^TCPConnectionStats;
	TCPConnectionStats = RECORD
		dataPktsRcvd:			UInt32;
		dataPktsSent:			UInt32;
		dataPktsResent:			UInt32;
		bytesRcvd:				UInt32;
		bytesRcvdDup:			UInt32;
		bytesRcvdPastWindow:	UInt32;
		bytesSent:				UInt32;
		bytesResent:			UInt32;
		numHistoBuckets:		UInt16;
		sentSizeHisto:			ARRAY [0..6] OF HistoBucket;
		lastRTT:				UInt16;
		tmrSRTT:				UInt16;
		rttVariance:			UInt16;
		tmrRTO:					UInt16;
		sendTries:				SInt8;
		sourchQuenchRcvd:		SInt8;
	END;

	TCPStatusPBPtr = ^TCPStatusPB;
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
		filler:					SInt8;									{  Filler for proper byte alignment     }
		sendWindow:				UInt16;
		rcvWindow:				UInt16;
		amtUnackedData:			UInt16;
		amtUnreadData:			UInt16;
		securityLevelPtr:		Ptr;
		sendUnacked:			UInt32;
		sendNext:				UInt32;
		congestionWindow:		UInt32;
		rcvNext:				UInt32;
		srtt:					UInt32;
		lastRTT:				UInt32;
		sendMaxSegSize:			UInt32;
		connStatPtr:			TCPConnectionStatsPtr;
		userDataPtr:			Ptr;
	END;

	TCPAbortPBPtr = ^TCPAbortPB;
	TCPAbortPB = RECORD
		userDataPtr:			Ptr;
	END;

	TCPParamPtr = ^TCPParam;
	TCPParam = RECORD
		tcpRtoA:				UInt32;
		tcpRtoMin:				UInt32;
		tcpRtoMax:				UInt32;
		tcpMaxSegSize:			UInt32;
		tcpMaxConn:				UInt32;
		tcpMaxWindow:			UInt32;
	END;

	TCPStatsPtr = ^TCPStats;
	TCPStats = RECORD
		tcpConnAttempts:		UInt32;
		tcpConnOpened:			UInt32;
		tcpConnAccepted:		UInt32;
		tcpConnClosed:			UInt32;
		tcpConnAborted:			UInt32;
		tcpOctetsIn:			UInt32;
		tcpOctetsOut:			UInt32;
		tcpOctetsInDup:			UInt32;
		tcpOctetsRetrans:		UInt32;
		tcpInputPkts:			UInt32;
		tcpOutputPkts:			UInt32;
		tcpDupPkts:				UInt32;
		tcpRetransPkts:			UInt32;
	END;

	StreamPPtr							= ^StreamPtr;
	TCPGlobalInfoPBPtr = ^TCPGlobalInfoPB;
	TCPGlobalInfoPB = RECORD
		tcpParamPtr:			TCPParamPtr;
		tcpStatsPtr:			TCPStatsPtr;
		tcpCDBTable:			ARRAY [0..0] OF StreamPPtr;
		userDataPtr:			Ptr;
		maxTCPConnections:		UInt16;
	END;

	TCPiopbPtr = ^TCPiopb;
{$IFC TYPED_FUNCTION_POINTERS}
	TCPIOCompletionProcPtr = PROCEDURE(iopb: TCPiopbPtr); C;
{$ELSEC}
	TCPIOCompletionProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	TCPIOCompletionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TCPIOCompletionUPP = UniversalProcPtr;
{$ENDC}	
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
			create:				TCPCreatePB;
			);
		1: (
			open:				TCPOpenPB;
			);
		2: (
			send:				TCPSendPB;
			);
		3: (
			receive:			TCPReceivePB;
			);
		4: (
			close:				TCPClosePB;
			);
		5: (
			abort:				TCPAbortPB;
			);
		6: (
			status:				TCPStatusPB;
			);
		7: (
			globalInfo:			TCPGlobalInfoPB;
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
	UDPEventCode						= UInt16;
{$IFC TYPED_FUNCTION_POINTERS}
	UDPNotifyProcPtr = PROCEDURE(udpStream: StreamPtr; eventCode: UInt16; userDataPtr: Ptr; VAR icmpMsg: ICMPReport);
{$ELSEC}
	UDPNotifyProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	UDPNotifyUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	UDPNotifyUPP = UniversalProcPtr;
{$ENDC}	
	udp_port							= UInt16;
	{	 for create and release calls 	}
	UDPCreatePBPtr = ^UDPCreatePB;
	UDPCreatePB = RECORD
		rcvBuff:				Ptr;
		rcvBuffLen:				UInt32;
		notifyProc:				UDPNotifyUPP;
		localPort:				UInt16;
		userDataPtr:			Ptr;
		endingPort:				udp_port;
	END;

	UDPSendPBPtr = ^UDPSendPB;
	UDPSendPB = RECORD
		reserved:				UInt16;
		remoteHost:				ip_addr;
		remotePort:				udp_port;
		wdsPtr:					Ptr;
		checkSum:				BOOLEAN;
		filler:					SInt8;									{  Filler for proper byte alignment     }
		sendLength:				UInt16;
		userDataPtr:			Ptr;
		localPort:				udp_port;
	END;

	{	 for receive and buffer return calls 	}
	UDPReceivePBPtr = ^UDPReceivePB;
	UDPReceivePB = RECORD
		timeOut:				UInt16;
		remoteHost:				ip_addr;
		remotePort:				udp_port;
		rcvBuff:				Ptr;
		rcvBuffLen:				UInt16;
		secondTimeStamp:		UInt16;
		userDataPtr:			Ptr;
		destHost:				ip_addr;								{  only for use with multi rcv  }
		destPort:				udp_port;								{  only for use with multi rcv  }
	END;

	UDPMTUPBPtr = ^UDPMTUPB;
	UDPMTUPB = RECORD
		mtuSize:				UInt16;
		remoteHost:				ip_addr;
		userDataPtr:			Ptr;
	END;

	UDPiopbPtr = ^UDPiopb;
{$IFC TYPED_FUNCTION_POINTERS}
	UDPIOCompletionProcPtr = PROCEDURE(iopb: UDPiopbPtr); C;
{$ELSEC}
	UDPIOCompletionProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	UDPIOCompletionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	UDPIOCompletionUPP = UniversalProcPtr;
{$ENDC}	
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
			create:				UDPCreatePB;
			);
		1: (
			send:				UDPSendPB;
			);
		2: (
			receive:			UDPReceivePB;
			);
		3: (
			mtu:				UDPMTUPB;
			);
	END;


CONST
	uppGetIPIOCompletionProcInfo = $000000C1;
	uppIPIOCompletionProcInfo = $000000C1;
	uppICMPEchoNotifyProcInfo = $000000C1;
	uppTCPNotifyProcInfo = $0000EEC0;
	uppTCPIOCompletionProcInfo = $000000C1;
	uppUDPNotifyProcInfo = $00003EC0;
	uppUDPIOCompletionProcInfo = $000000C1;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewGetIPIOCompletionUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewGetIPIOCompletionUPP(userRoutine: GetIPIOCompletionProcPtr): GetIPIOCompletionUPP; { old name was NewGetIPIOCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewIPIOCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewIPIOCompletionUPP(userRoutine: IPIOCompletionProcPtr): IPIOCompletionUPP; { old name was NewIPIOCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewICMPEchoNotifyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewICMPEchoNotifyUPP(userRoutine: ICMPEchoNotifyProcPtr): ICMPEchoNotifyUPP; { old name was NewICMPEchoNotifyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTCPNotifyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewTCPNotifyUPP(userRoutine: TCPNotifyProcPtr): TCPNotifyUPP; { old name was NewTCPNotifyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTCPIOCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewTCPIOCompletionUPP(userRoutine: TCPIOCompletionProcPtr): TCPIOCompletionUPP; { old name was NewTCPIOCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewUDPNotifyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewUDPNotifyUPP(userRoutine: UDPNotifyProcPtr): UDPNotifyUPP; { old name was NewUDPNotifyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewUDPIOCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewUDPIOCompletionUPP(userRoutine: UDPIOCompletionProcPtr): UDPIOCompletionUPP; { old name was NewUDPIOCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeGetIPIOCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeGetIPIOCompletionUPP(userUPP: GetIPIOCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeIPIOCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeIPIOCompletionUPP(userUPP: IPIOCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeICMPEchoNotifyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeICMPEchoNotifyUPP(userUPP: ICMPEchoNotifyUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTCPNotifyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeTCPNotifyUPP(userUPP: TCPNotifyUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTCPIOCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeTCPIOCompletionUPP(userUPP: TCPIOCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeUDPNotifyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeUDPNotifyUPP(userUPP: UDPNotifyUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeUDPIOCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeUDPIOCompletionUPP(userUPP: UDPIOCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeGetIPIOCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeGetIPIOCompletionUPP(iopb: GetAddrParamBlockPtr; userRoutine: GetIPIOCompletionUPP); { old name was CallGetIPIOCompletionProc }
{
 *  InvokeIPIOCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeIPIOCompletionUPP(iopb: ICMPParamBlockPtr; userRoutine: IPIOCompletionUPP); { old name was CallIPIOCompletionProc }
{
 *  InvokeICMPEchoNotifyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeICMPEchoNotifyUPP(VAR iopb: ICMPParamBlock; userRoutine: ICMPEchoNotifyUPP); { old name was CallICMPEchoNotifyProc }
{
 *  InvokeTCPNotifyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeTCPNotifyUPP(tcpStream: StreamPtr; eventCode: UInt16; userDataPtr: Ptr; terminReason: UInt16; VAR icmpMsg: ICMPReport; userRoutine: TCPNotifyUPP); { old name was CallTCPNotifyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTCPIOCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeTCPIOCompletionUPP(iopb: TCPiopbPtr; userRoutine: TCPIOCompletionUPP); { old name was CallTCPIOCompletionProc }
{
 *  InvokeUDPNotifyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeUDPNotifyUPP(udpStream: StreamPtr; eventCode: UInt16; userDataPtr: Ptr; VAR icmpMsg: ICMPReport; userRoutine: UDPNotifyUPP); { old name was CallUDPNotifyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeUDPIOCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeUDPIOCompletionUPP(iopb: UDPiopbPtr; userRoutine: UDPIOCompletionUPP); { old name was CallUDPIOCompletionProc }
{$ENDC}  {CALL_NOT_IN_CARBON}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MacTCPIncludes}

{$ENDC} {__MACTCP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

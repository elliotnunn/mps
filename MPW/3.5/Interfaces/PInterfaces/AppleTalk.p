{
     File:       AppleTalk.p
 
     Contains:   AppleTalk Interfaces.
 
     Version:    Technology: System 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AppleTalk;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __APPLETALK__}
{$SETC __APPLETALK__ := 1}

{$I+}
{$SETC AppleTalkIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  Driver unit numbers (ADSP is dynamic)  }
	mppUnitNum					= 9;							{  MPP unit number  }
	atpUnitNum					= 10;							{  ATP unit number  }
	xppUnitNum					= 40;							{  XPP unit number  }

																{  Driver refNums (ADSP is dynamic)  }
	mppRefNum					= -10;							{  MPP reference number  }
	atpRefNum					= -11;							{  ATP reference number  }
	xppRefNum					= -41;							{  XPP reference number  }

																{  .MPP csCodes  }
	lookupReply					= 242;							{  This command queued to ourself  }
	writeLAP					= 243;							{  Write out LAP packet  }
	detachPH					= 244;							{  Detach LAP protocol handler  }
	attachPH					= 245;							{  Attach LAP protocol handler  }
	writeDDP					= 246;							{  Write out DDP packet  }
	closeSkt					= 247;							{  Close DDP socket  }
	openSkt						= 248;							{  Open DDP socket  }
	loadNBP						= 249;							{  Load NBP command-executing code  }
	lastResident				= 249;							{  Last resident command  }
	confirmName					= 250;							{  Confirm name  }
	lookupName					= 251;							{  Look up name on internet  }
	removeName					= 252;							{  Remove name from Names Table  }
	registerName				= 253;							{  Register name in Names Table  }
	killNBP						= 254;							{  Kill outstanding NBP request  }
	unloadNBP					= 255;							{  Unload NBP command code  }
	setSelfSend					= 256;							{  MPP: Set to allow writes to self  }
	SetMyZone					= 257;							{  Set my zone name  }
	GetATalkInfo				= 258;							{  get AppleTalk information  }
	ATalkClosePrep				= 259;							{  AppleTalk close query  }

																{  .ATP csCodes  }
	nSendRequest				= 248;							{  NSendRequest code  }
	relRspCB					= 249;							{  Release RspCB  }
	closeATPSkt					= 250;							{  Close ATP socket  }
	addResponse					= 251;							{  Add response code | Require open skt  }
	sendResponse				= 252;							{  Send response code  }
	getRequest					= 253;							{  Get request code  }
	openATPSkt					= 254;							{  Open ATP socket  }
	sendRequest					= 255;							{  Send request code  }
	relTCB						= 256;							{  Release TCB  }
	killGetReq					= 257;							{  Kill GetRequest  }
	killSendReq					= 258;							{  Kill SendRequest  }
	killAllGetReq				= 259;							{  Kill all getRequests for a skt  }

																{  .XPP csCodes  }
	openSess					= 255;							{  Open session  }
	closeSess					= 254;							{  Close session  }
	userCommand					= 253;							{  User command  }
	userWrite					= 252;							{  User write  }
	getStatus					= 251;							{  Get status  }
	afpCall						= 250;							{  AFP command (buffer has command code)  }
	getParms					= 249;							{  Get parameters  }
	abortOS						= 248;							{  Abort open session request  }
	closeAll					= 247;							{  Close all open sessions  }
	xCall						= 246;							{  .XPP extended calls  }

																{  Transition Queue transition types  }
	ATTransOpen					= 0;							{ AppleTalk has opened }
	ATTransClose				= 2;							{ AppleTalk is about to close }
	ATTransClosePrep			= 3;							{ Is it OK to close AppleTalk ? }
	ATTransCancelClose			= 4;							{ Cancel the ClosePrep transition }

	afpByteRangeLock			= 1;							{ AFPCall command codes }
	afpVolClose					= 2;							{ AFPCall command codes }
	afpDirClose					= 3;							{ AFPCall command codes }
	afpForkClose				= 4;							{ AFPCall command codes }
	afpCopyFile					= 5;							{ AFPCall command codes }
	afpDirCreate				= 6;							{ AFPCall command codes }
	afpFileCreate				= 7;							{ AFPCall command codes }
	afpDelete					= 8;							{ AFPCall command codes }
	afpEnumerate				= 9;							{ AFPCall command codes }
	afpFlush					= 10;							{ AFPCall command codes }
	afpForkFlush				= 11;							{ AFPCall command codes }
	afpGetDirParms				= 12;							{ AFPCall command codes }
	afpGetFileParms				= 13;							{ AFPCall command codes }
	afpGetForkParms				= 14;							{ AFPCall command codes }
	afpGetSInfo					= 15;							{ AFPCall command codes }
	afpGetSParms				= 16;							{ AFPCall command codes }
	afpGetVolParms				= 17;							{ AFPCall command codes }
	afpLogin					= 18;							{ AFPCall command codes }
	afpContLogin				= 19;							{ AFPCall command codes }
	afpLogout					= 20;							{ AFPCall command codes }
	afpMapID					= 21;							{ AFPCall command codes }
	afpMapName					= 22;							{ AFPCall command codes }
	afpMove						= 23;							{ AFPCall command codes }
	afpOpenVol					= 24;							{ AFPCall command codes }
	afpOpenDir					= 25;							{ AFPCall command codes }
	afpOpenFork					= 26;							{ AFPCall command codes }
	afpRead						= 27;							{ AFPCall command codes }
	afpRename					= 28;							{ AFPCall command codes }
	afpSetDirParms				= 29;							{ AFPCall command codes }
	afpSetFileParms				= 30;							{ AFPCall command codes }
	afpSetForkParms				= 31;							{ AFPCall command codes }
	afpSetVolParms				= 32;							{ AFPCall command codes }
	afpWrite					= 33;							{ AFPCall command codes }
	afpGetFlDrParms				= 34;							{ AFPCall command codes }
	afpSetFlDrParms				= 35;							{ AFPCall command codes }
	afpDTOpen					= 48;							{ AFPCall command codes }
	afpDTClose					= 49;							{ AFPCall command codes }
	afpGetIcon					= 51;							{ AFPCall command codes }
	afpGtIcnInfo				= 52;							{ AFPCall command codes }
	afpAddAPPL					= 53;							{ AFPCall command codes }
	afpRmvAPPL					= 54;							{ AFPCall command codes }
	afpGetAPPL					= 55;							{ AFPCall command codes }
	afpAddCmt					= 56;							{ AFPCall command codes }
	afpRmvCmt					= 57;							{ AFPCall command codes }
	afpGetCmt					= 58;							{ AFPCall command codes }
	afpAddIcon					= 192;							{ Special code for ASP Write commands }

	xppLoadedBit				= 5;							{  XPP bit in PortBUse  }
	scbMemSize					= 192;							{  Size of memory for SCB  }
	xppFlagClr					= 0;							{  Cs for AFPCommandBlock  }

	xppFlagSet					= 128;							{  StartEndFlag & NewLineFlag fields.  }

	lapSize						= 20;
	ddpSize						= 26;
	nbpSize						= 26;
	atpSize						= 56;

	atpXOvalue					= 32;							{ ATP exactly-once bit  }
	atpEOMvalue					= 16;							{ ATP End-Of-Message bit  }
	atpSTSvalue					= 8;							{ ATP Send-Transmission-Status bit  }
	atpTIDValidvalue			= 2;							{ ATP trans. ID valid bit  }
	atpSendChkvalue				= 1;							{ ATP send checksum bit  }

	zipGetLocalZones			= 5;
	zipGetZoneList				= 6;
	zipGetMyZone				= 7;

	LAPMgrPtr					= $0B18;						{ Entry point for LAP Manager }

	LAPMgrCall					= 2;							{ Offset to LAP routines }
	LAddAEQ						= 23;							{ LAPAddATQ routine selector }
	LRmvAEQ						= 24;							{ LAPRmvATQ routine selector }

	tLAPRead					= 0;
	tLAPWrite					= 1;
	tDDPRead					= 2;
	tDDPWrite					= 3;
	tNBPLookup					= 4;
	tNBPConfirm					= 5;
	tNBPRegister				= 6;
	tATPSndRequest				= 7;
	tATPGetRequest				= 8;
	tATPSdRsp					= 9;
	tATPAddRsp					= 10;
	tATPRequest					= 11;
	tATPResponse				= 12;


TYPE
	ABCallType							= SInt8;

CONST
	lapProto					= 0;
	ddpProto					= 1;
	nbpProto					= 2;
	atpProto					= 3;


TYPE
	ABProtoType							= UInt8;
	ABByte								= Byte;
	LAPAdrBlockPtr = ^LAPAdrBlock;
	LAPAdrBlock = PACKED RECORD
		dstNodeID:				UInt8;
		srcNodeID:				UInt8;
		lapProtType:			ABByte;
		filler:					UInt8;									{     Filler for proper byte alignment }
	END;

	ATQEntryPtr = ^ATQEntry;
{$IFC TYPED_FUNCTION_POINTERS}
	ATalkTransitionEventProcPtr = FUNCTION(eventCode: LONGINT; qElem: ATQEntryPtr; eventParameter: UNIV Ptr): LONGINT; C;
{$ELSEC}
	ATalkTransitionEventProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ATalkTransitionEventUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ATalkTransitionEventUPP = UniversalProcPtr;
{$ENDC}	
	ATalkTransitionEvent				= ATalkTransitionEventUPP;
	ATQEntry = RECORD
		qLink:					ATQEntryPtr;							{ next queue entry }
		qType:					INTEGER;								{ queue type }
		CallAddr:				ATalkTransitionEventUPP;				{ your routine descriptor }
	END;

	{	 
	    Real definition of EntityName is 3 PACKED strings of any length (32 is just an example). No
	    offests for Asm since each String address must be calculated by adding length byte to last string ptr.
	    In Pascal, String(32) will be 34 bytes long since fields never start on an odd byte unless they are 
	    only a byte long. So this will generate correct looking interfaces for Pascal and C, but they will not
	    be the same, which is OK since they are not used. 
		}
	EntityNamePtr = ^EntityName;
	EntityName = RECORD
		objStr:					Str32Field;
		typeStr:				Str32Field;
		zoneStr:				Str32Field;
	END;

	EntityPtr							= ^EntityName;
	AddrBlockPtr = ^AddrBlock;
	AddrBlock = PACKED RECORD
		aNet:					UInt16;
		aNode:					UInt8;
		aSocket:				UInt8;
	END;

	RetransTypePtr = ^RetransType;
	RetransType = PACKED RECORD
		retransInterval:		UInt8;
		retransCount:			UInt8;
	END;

	BDSElementPtr = ^BDSElement;
	BDSElement = RECORD
		buffSize:				INTEGER;
		buffPtr:				Ptr;
		dataSize:				INTEGER;
		userBytes:				LONGINT;
	END;

	BDSType								= ARRAY [0..7] OF BDSElement;
	BDSPtr								= ^BDSElement;
    BitMapType = PACKED ARRAY [0..7] OF BOOLEAN;
	ATLAPRecPtr = ^ATLAPRec;
	ATLAPRec = RECORD
		abOpcode:				ABCallType;
		filler:					SInt8;									{     Filler for proper byte alignment }
		abResult:				INTEGER;
		abUserReference:		LONGINT;
		lapAddress:				LAPAdrBlock;
		lapReqCount:			INTEGER;
		lapActCount:			INTEGER;
		lapDataPtr:				Ptr;
	END;

	ATLAPRecHandle						= ^ATLAPRecPtr;
	ATDDPRecPtr = ^ATDDPRec;
	ATDDPRec = RECORD
		abOpcode:				ABCallType;
		filler:					SInt8;									{     Filler for proper byte alignment }
		abResult:				INTEGER;
		abUserReference:		LONGINT;
		ddpType:				INTEGER;
		ddpSocket:				INTEGER;
		ddpAddress:				AddrBlock;
		ddpReqCount:			INTEGER;
		ddpActCount:			INTEGER;
		ddpDataPtr:				Ptr;
		ddpNodeID:				INTEGER;
	END;

	ATDDPRecHandle						= ^ATDDPRecPtr;
	ATNBPRecPtr = ^ATNBPRec;
	ATNBPRec = RECORD
		abOpcode:				ABCallType;
		filler:					SInt8;									{     Filler for proper byte alignment }
		abResult:				INTEGER;
		abUserReference:		LONGINT;
		nbpEntityPtr:			EntityPtr;
		nbpBufPtr:				Ptr;
		nbpBufSize:				INTEGER;
		nbpDataField:			INTEGER;
		nbpAddress:				AddrBlock;
		nbpRetransmitInfo:		RetransType;
	END;

	ATNBPRecHandle						= ^ATNBPRecPtr;
	ATATPRecPtr = ^ATATPRec;
	ATATPRec = RECORD
		abOpcode:				ABCallType;
		filler1:				SInt8;									{     Filler for proper byte alignment }
		abResult:				INTEGER;
		abUserReference:		LONGINT;
		atpSocket:				INTEGER;
		atpAddress:				AddrBlock;
		atpReqCount:			INTEGER;
		atpDataPtr:				Ptr;
		atpRspBDSPtr:			BDSPtr;
		atpBitMap:				SInt8;
		filler2:				SInt8;									{     Filler for proper byte alignment }
		atpTransID:				INTEGER;
		atpActCount:			INTEGER;
		atpUserData:			LONGINT;
		atpXO:					BOOLEAN;
		atpEOM:					BOOLEAN;
		atpTimeOut:				INTEGER;
		atpRetries:				INTEGER;
		atpNumBufs:				INTEGER;
		atpNumRsp:				INTEGER;
		atpBDSSize:				INTEGER;
		atpRspUData:			LONGINT;
		atpRspBuf:				Ptr;
		atpRspSize:				INTEGER;
	END;

	ATATPRecHandle						= ^ATATPRecPtr;
	AFPCommandBlockPtr = ^AFPCommandBlock;
	AFPCommandBlock = PACKED RECORD
		cmdByte:				UInt8;
		startEndFlag:			UInt8;
		forkRefNum:				INTEGER;
		rwOffset:				LONGINT;
		reqCount:				LONGINT;
		newLineFlag:			UInt8;
		newLineChar:			CHAR;
	END;

	MPPParamBlockPtr = ^MPPParamBlock;
	ATPParamBlockPtr = ^ATPParamBlock;
	XPPParamBlockPtr = ^XPPParamBlock;
	MPPPBPtr							= ^MPPParamBlock;
	ATPPBPtr							= ^ATPParamBlock;
	XPPParmBlkPtr						= ^XPPParamBlock;
{$IFC TYPED_FUNCTION_POINTERS}
	MPPCompletionProcPtr = PROCEDURE(thePBptr: MPPPBPtr);
{$ELSEC}
	MPPCompletionProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ATPCompletionProcPtr = PROCEDURE(thePBptr: ATPPBPtr);
{$ELSEC}
	ATPCompletionProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	XPPCompletionProcPtr = PROCEDURE(thePBptr: XPPParmBlkPtr);
{$ELSEC}
	XPPCompletionProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	AttnRoutineProcPtr = PROCEDURE(sessRefnum: INTEGER; attnBytes: INTEGER);
{$ELSEC}
	AttnRoutineProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	MPPCompletionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MPPCompletionUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ATPCompletionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ATPCompletionUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	XPPCompletionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	XPPCompletionUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	AttnRoutineUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	AttnRoutineUPP = UniversalProcPtr;
{$ENDC}	

	WDSElementPtr = ^WDSElement;
	WDSElement = RECORD
		entryLength:			INTEGER;
		entryPtr:				Ptr;
	END;

	NTElementPtr = ^NTElement;
	NTElement = RECORD
		nteAddress:				AddrBlock;								{ network address of entity }
		filler:					SInt8;
		entityData:				ARRAY [0..98] OF SInt8;					{ Object, Type & Zone }
	END;

	NamesTableEntryPtr = ^NamesTableEntry;
	NamesTableEntry = RECORD
		qNext:					Ptr;									{ ptr to next NTE }
		nt:						NTElement;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	MPPProtocolHandlerProcPtr = FUNCTION(SCCAddr1: Ptr; SCCAddr2: Ptr; MPPLocalVars: Ptr; nextFreeByteInRHA: Ptr; ReadPacketAndReadRestPtr: Ptr; numBytesLeftToReadInPacket: INTEGER): BOOLEAN;
{$ELSEC}
	MPPProtocolHandlerProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DDPSocketListenerProcPtr = FUNCTION(SCCAddr1: Ptr; SCCAddr2: Ptr; MPPLocalVars: Ptr; nextFreeByteInRHA: Ptr; ReadPacketAndReadRestPtr: Ptr; packetDestinationNumber: ByteParameter; numBytesLeftToReadInPacket: INTEGER): BOOLEAN;
{$ELSEC}
	DDPSocketListenerProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	MPPProtocolHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MPPProtocolHandlerUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DDPSocketListenerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DDPSocketListenerUPP = UniversalProcPtr;
{$ENDC}	
	{	
	    MPPProtocolHandlerProcs and  DDPSocketListenerProcs cannot be written 
	    in or called from a high-level language without the help of mixed mode 
	    or assembly glue because they use the following parameter-passing conventions:
	
	    typedef Boolean (*MPPProtocolHandlerProcPtr)(Ptr SCCAddr1, Ptr SCCAddr2, 
	            Ptr MPPLocalVars, Ptr nextFreeByteInRHA, Ptr ReadPacketAndReadRestPtr, 
	            short numBytesLeftToReadInPacket);
	
	        In:
	            =>  SCCAddr1                    A0.L
	            =>  SCCAddr2                    A1.L
	            =>  MPPLocalVars                A2.L
	            =>  nextFreeByteInRHA           A3.L
	            =>  ReadPacketAndReadRestPtr    A4.L
	            =>  numBytesLeftToReadInPacket  D1.W
	        Out:
	            <=  Boolean                     Z bit of CCR
	
	    typedef Boolean (*DDPSocketListenerProcPtr)(Ptr SCCAddr1, Ptr SCCAddr2, 
	            Ptr MPPLocalVars, Ptr nextFreeByteInRHA, Ptr ReadPacketAndReadRestPtr, 
	            UInt8 packetDestinationNumber, short numBytesLeftToReadInPacket);
	
	        In:
	            =>  SCCAddr1                    A0.L
	            =>  SCCAddr2                    A1.L
	            =>  MPPLocalVars                A2.L
	            =>  nextFreeByteInRHA           A3.L
	            =>  ReadPacketAndReadRestPtr    A4.L
	            =>  packetDestinationNumber     D0.B
	            =>  numBytesLeftToReadInPacket  D1.W
	        Out:
	            <=  Boolean                     Z bit of CCR
	
		}
	MPPParamBlock = PACKED RECORD
		qLink:					QElemPtr;								{ next queue entry }
		qType:					INTEGER;								{ queue type }
		ioTrap:					INTEGER;								{ routine trap }
		ioCmdAddr:				Ptr;									{ routine address }
		ioCompletion:			ATPCompletionUPP;						{ ATPCompletionUPP or MPPCompletionUPP }
		ioResult:				OSErr;									{ result code }
		userData:				LONGINT;								{ Command result (ATP user bytes) }
		reqTID:					INTEGER;								{ request transaction ID }
		ioRefNum:				INTEGER;								{ driver reference number }
		csCode:					INTEGER;								{ Call command code }
		CASE INTEGER OF
		0: (
			filler0:			INTEGER;
			wdsPointer:			Ptr;
		   );
		1: (
			protType:			UInt8;
			filler:				SInt8;
			handler:			MPPProtocolHandlerUPP;
		   );
		2: (
			socket:				UInt8;
			checksumFlag:		UInt8;
			listener:			DDPSocketListenerUPP;
		   );
		3: (
			interval:			UInt8;									{ retry interval  }
			count:				UInt8;									{ retry count  }
			nbpPtrs:			Ptr;
			CASE INTEGER OF
			0: (
				verifyFlag:		UInt8;
				filler3:		UInt8;
			   );
			1: (
				retBuffPtr:		Ptr;
				retBuffSize:	INTEGER;
				maxToGet:		INTEGER;
				numGotten:		INTEGER;
			   );
			2: (
				confirmAddr:	AddrBlock;
				newSocket:		UInt8;
				filler4:		UInt8;
			   );
			   );
			4: (
				newSelfFlag:	UInt8;									{ self-send toggle flag  }
				oldSelfFlag:	UInt8;									{ previous self-send state  }
			   );
			5: (
				nKillQEl:		Ptr;									{ ptr to i/o queue element to cancel  }
			   );
			6: (
				version:		INTEGER;								{ requested info version }
				varsPtr:		Ptr;									{ pointer to well known MPP vars }
				DCEPtr:			Ptr;									{ pointer to MPP DCE }
				portID:			INTEGER;								{ port number [0..7] }
				configuration:	LONGINT;								{ 32-bit configuration word }
				selfSend:		INTEGER;								{ non zero if SelfSend enabled }
				netLo:			INTEGER;								{ low value of network range }
				netHi:			INTEGER;								{ high value of network range }
				ourAdd:			LONGINT;								{ our 24-bit AppleTalk address }
				routerAddr:		LONGINT;								{ 24-bit address of (last) router }
				numOfPHs:		INTEGER;								{ max. number of protocol handlers }
				numOfSkts:		INTEGER;								{ max. number of static sockets }
				numNBPEs:		INTEGER;								{ max. concurrent NBP requests }
				nTQueue:		Ptr;									{ pointer to registered name queue }
				LAlength:		INTEGER;								{ length in bytes of data link addr }
				linkAddr:		Ptr;									{ data link address returned }
				zoneName:		Ptr;									{ zone name returned }
			   );
			7: (
				appName:		Ptr;									{ pointer to application name in buffer }
			   );
	END;

	XPPParamBlock = PACKED RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			XPPCompletionUPP;
		ioResult:				OSErr;
		cmdResult:				LONGINT;
		ioVRefNum:				INTEGER;
		ioRefNum:				INTEGER;
		csCode:					INTEGER;
		CASE INTEGER OF
		0: (
			abortSCBPtr:		Ptr;									{  SCB pointer for AbortOS }
		   );
		1: (
			aspMaxCmdSize:		INTEGER;								{ For SPGetParms }
			aspQuantumSize:		INTEGER;
			numSesss:			INTEGER;
		   );
		2: (
			sessRefnum:			INTEGER;								{ Offset to session refnum  }
			aspTimeout:			UInt8;									{ Timeout for ATP  }
			aspRetry:			UInt8;									{ Retry count for ATP  }
			CASE INTEGER OF
			0: (
				serverAddr:		AddrBlock;								{ Server address block  }
				scbPointer:		Ptr;									{ SCB pointer  }
				attnRoutine:	AttnRoutineUPP;							{ Attention routine pointer }
			   );
			1: (
				cbSize:			INTEGER;								{ Command block size  }
				cbPtr:			Ptr;									{ Command block pointer  }
				rbSize:			INTEGER;								{ Reply buffer size  }
				rbPtr:			Ptr;									{ Reply buffer pointer  }
				CASE INTEGER OF
				0: (
					afpAddrBlock: AddrBlock;							{ block in AFP login  }
					afpSCBPtr:	Ptr;									{ SCB pointer in AFP login  }
					afpAttnRoutine: AttnRoutineUPP;						{ routine pointer in AFP login  }
				   );
				1: (
					wdSize:		INTEGER;								{ Write Data size }
					wdPtr:		Ptr;									{ Write Data pointer }
					ccbStart:	PACKED ARRAY [0..295] OF UInt8;			{ CCB memory allocated for driver afpWrite max size(CCB)=296 all other calls=150 }
				   );
				   );
				   );
				3: (
					xppSubCode:	INTEGER;
					xppTimeout:	UInt8;									{ retry interval (seconds) }
					xppRetry:	UInt8;									{ retry count }
					filler1:	INTEGER;
					zipBuffPtr:	Ptr;									{ pointer to buffer (must be 578 bytes) }
					zipNumZones: INTEGER;								{ no. of zone names in this response }
					zipLastFlag: UInt8;									{ non-zero if no more zones }
					filler2:	UInt8;									{ filler }
					zipInfoField: PACKED ARRAY [1..70] OF UInt8;		{ on initial call, set first word to zero }
				   );
	END;


	ATPParamBlock = PACKED RECORD
		qLink:					QElemPtr;								{ next queue entry }
		qType:					INTEGER;								{ queue type }
		ioTrap:					INTEGER;								{ routine trap }
		ioCmdAddr:				Ptr;									{ routine address }
		ioCompletion:			ATPCompletionUPP;						{ ATPCompletionUPP or MPPCompletionUPP }
		ioResult:				OSErr;									{ result code }
		userData:				LONGINT;								{ Command result (ATP user bytes) }
		reqTID:					INTEGER;								{ request transaction ID }
		ioRefNum:				INTEGER;								{ driver reference number }
		csCode:					INTEGER;								{ Call command code }
		atpSocket:				UInt8;									{ currbitmap for requests or ATP socket number }
		atpFlags:				UInt8;									{ control information }
		addrBlock:				AddrBlock;								{ source/dest. socket address }
		reqLength:				INTEGER;								{ request/response length }
		reqPointer:				Ptr;									{ ->request/response Data }
		bdsPointer:				Ptr;									{ ->response BDS  }
		CASE INTEGER OF
		0: (
			numOfBuffs:			UInt8;									{ numOfBuffs  }
			timeOutVal:			UInt8;									{ timeout interval  }
			numOfResps:			UInt8;									{ number of responses actually received  }
			retryCount:			UInt8;									{ number of retries  }
			intBuff:			INTEGER;								{ used internally for NSendRequest  }
			TRelTime:			UInt8;									{ TRelease time for extended send request  }
			filler0:			SInt8;
		   );
		1: (
			filler:				UInt8;
			bdsSize:			UInt8;									{ number of BDS elements  }
			transID:			INTEGER;								{ transaction ID recd.  }
		   );
		2: (
			bitMap:				UInt8;
			filler2:			UInt8;
		   );
		3: (
			rspNum:				UInt8;
			filler3:			UInt8;
		   );
		4: (
			aKillQEl:			Ptr;									{ ptr to i/o queue element to cancel }
		   );
	END;


CONST
	uppATalkTransitionEventProcInfo = $00000FF1;
	uppMPPCompletionProcInfo = $00009802;
	uppATPCompletionProcInfo = $00009802;
	uppXPPCompletionProcInfo = $00009802;
	uppAttnRoutineProcInfo = $00061002;
	uppMPPProtocolHandlerProcInfo = $0000007F;
	uppDDPSocketListenerProcInfo = $0000008F;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewATalkTransitionEventUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewATalkTransitionEventUPP(userRoutine: ATalkTransitionEventProcPtr): ATalkTransitionEventUPP; { old name was NewATalkTransitionEventProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMPPCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewMPPCompletionUPP(userRoutine: MPPCompletionProcPtr): MPPCompletionUPP; { old name was NewMPPCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewATPCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewATPCompletionUPP(userRoutine: ATPCompletionProcPtr): ATPCompletionUPP; { old name was NewATPCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewXPPCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewXPPCompletionUPP(userRoutine: XPPCompletionProcPtr): XPPCompletionUPP; { old name was NewXPPCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewAttnRoutineUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewAttnRoutineUPP(userRoutine: AttnRoutineProcPtr): AttnRoutineUPP; { old name was NewAttnRoutineProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMPPProtocolHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewMPPProtocolHandlerUPP(userRoutine: MPPProtocolHandlerProcPtr): MPPProtocolHandlerUPP; { old name was NewMPPProtocolHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDDPSocketListenerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewDDPSocketListenerUPP(userRoutine: DDPSocketListenerProcPtr): DDPSocketListenerUPP; { old name was NewDDPSocketListenerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeATalkTransitionEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeATalkTransitionEventUPP(userUPP: ATalkTransitionEventUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMPPCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeMPPCompletionUPP(userUPP: MPPCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeATPCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeATPCompletionUPP(userUPP: ATPCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeXPPCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeXPPCompletionUPP(userUPP: XPPCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeAttnRoutineUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeAttnRoutineUPP(userUPP: AttnRoutineUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMPPProtocolHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeMPPProtocolHandlerUPP(userUPP: MPPProtocolHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDDPSocketListenerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeDDPSocketListenerUPP(userUPP: DDPSocketListenerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeATalkTransitionEventUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeATalkTransitionEventUPP(eventCode: LONGINT; qElem: ATQEntryPtr; eventParameter: UNIV Ptr; userRoutine: ATalkTransitionEventUPP): LONGINT; { old name was CallATalkTransitionEventProc }
{
 *  InvokeMPPCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeMPPCompletionUPP(thePBptr: MPPPBPtr; userRoutine: MPPCompletionUPP); { old name was CallMPPCompletionProc }
{
 *  InvokeATPCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeATPCompletionUPP(thePBptr: ATPPBPtr; userRoutine: ATPCompletionUPP); { old name was CallATPCompletionProc }
{
 *  InvokeXPPCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeXPPCompletionUPP(thePBptr: XPPParmBlkPtr; userRoutine: XPPCompletionUPP); { old name was CallXPPCompletionProc }
{
 *  InvokeAttnRoutineUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeAttnRoutineUPP(sessRefnum: INTEGER; attnBytes: INTEGER; userRoutine: AttnRoutineUPP); { old name was CallAttnRoutineProc }
{
 *  InvokeMPPProtocolHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeMPPProtocolHandlerUPP(SCCAddr1: Ptr; SCCAddr2: Ptr; MPPLocalVars: Ptr; nextFreeByteInRHA: Ptr; ReadPacketAndReadRestPtr: Ptr; numBytesLeftToReadInPacket: INTEGER; userRoutine: MPPProtocolHandlerUPP): BOOLEAN; { old name was CallMPPProtocolHandlerProc }
{
 *  InvokeDDPSocketListenerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeDDPSocketListenerUPP(SCCAddr1: Ptr; SCCAddr2: Ptr; MPPLocalVars: Ptr; nextFreeByteInRHA: Ptr; ReadPacketAndReadRestPtr: Ptr; packetDestinationNumber: ByteParameter; numBytesLeftToReadInPacket: INTEGER; userRoutine: DDPSocketListenerUPP): BOOLEAN; { old name was CallDDPSocketListenerProc }
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  OpenXPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION OpenXPP(VAR xppRefnum: INTEGER): OSErr;

{
 *  ASPOpenSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ASPOpenSession(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;

{
 *  ASPCloseSession()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ASPCloseSession(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;

{
 *  ASPAbortOS()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ASPAbortOS(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;

{
 *  ASPGetParms()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ASPGetParms(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;

{
 *  ASPCloseAll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ASPCloseAll(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;

{
 *  ASPUserWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ASPUserWrite(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;

{
 *  ASPUserCommand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ASPUserCommand(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;

{
 *  ASPGetStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ASPGetStatus(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;

{
 *  AFPCommand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AFPCommand(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;

{
 *  GetLocalZones()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetLocalZones(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;

{
 *  GetZoneList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetZoneList(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;

{
 *  GetMyZone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetMyZone(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;

{
 *  PAttachPH()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PAttachPH(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;

{
 *  PDetachPH()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PDetachPH(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;

{
 *  PWriteLAP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PWriteLAP(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;

{
 *  POpenSkt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION POpenSkt(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;

{
 *  PCloseSkt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCloseSkt(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;

{
 *  PWriteDDP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PWriteDDP(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;

{
 *  PRegisterName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PRegisterName(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;

{
 *  PLookupName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PLookupName(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;

{
 *  PConfirmName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PConfirmName(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;

{
 *  PRemoveName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PRemoveName(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;

{
 *  PSetSelfSend()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PSetSelfSend(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;

{
 *  PKillNBP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PKillNBP(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;

{
 *  PGetAppleTalkInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PGetAppleTalkInfo(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;

{
 *  PATalkClosePrep()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PATalkClosePrep(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;

{
 *  POpenATPSkt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION POpenATPSkt(thePBptr: ATPPBPtr; async: BOOLEAN): OSErr;

{
 *  PCloseATPSkt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCloseATPSkt(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;

{
 *  PSendRequest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PSendRequest(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;

{
 *  PGetRequest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PGetRequest(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;

{
 *  PSendResponse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PSendResponse(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;

{
 *  PAddResponse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PAddResponse(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;

{
 *  PRelTCB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PRelTCB(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;

{
 *  PRelRspCB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PRelRspCB(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;

{
 *  PNSendRequest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PNSendRequest(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;

{
 *  PKillSendReq()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PKillSendReq(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;

{
 *  PKillGetReq()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PKillGetReq(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;

{
 *  ATPKillAllGetReq()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATPKillAllGetReq(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;

{
 *  BuildLAPwds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE BuildLAPwds(wdsPtr: Ptr; dataPtr: Ptr; destHost: INTEGER; prototype: INTEGER; frameLen: INTEGER);

{
 *  BuildDDPwds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE BuildDDPwds(wdsPtr: Ptr; headerPtr: Ptr; dataPtr: Ptr; netAddr: AddrBlock; ddpType: INTEGER; dataLen: INTEGER);

{
 *  NBPSetEntity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE NBPSetEntity(buffer: Ptr; nbpObject: Str32; nbpType: Str32; nbpZone: Str32);

{
 *  NBPSetNTE()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE NBPSetNTE(ntePtr: Ptr; nbpObject: Str32; nbpType: Str32; nbpZone: Str32; socket: INTEGER);

{
 *  GetBridgeAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetBridgeAddress: INTEGER;

{
 *  BuildBDS()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION BuildBDS(buffPtr: Ptr; bdsPtr: Ptr; buffSize: INTEGER): INTEGER;

{
 *  MPPOpen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPPOpen: OSErr;

{
 *  LAPAddATQ()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION LAPAddATQ(theATQEntry: ATQEntryPtr): OSErr;

{
 *  LAPRmvATQ()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION LAPRmvATQ(theATQEntry: ATQEntryPtr): OSErr;

{
 *  ATPLoad()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATPLoad: OSErr;

{
 *  ATPUnload()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATPUnload: OSErr;

{
 *  NBPExtract()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NBPExtract(theBuffer: Ptr; numInBuf: INTEGER; whichOne: INTEGER; VAR abEntity: EntityName; VAR address: AddrBlock): OSErr;

{
 *  GetNodeAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetNodeAddress(VAR myNode: INTEGER; VAR myNet: INTEGER): OSErr;

{
 *  IsMPPOpen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IsMPPOpen: BOOLEAN;

{
 *  IsATPOpen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IsATPOpen: BOOLEAN;

{
 *  ATEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ATEvent(event: LONGINT; infoPtr: Ptr);

{
 *  ATPreFlightEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATPreFlightEvent(event: LONGINT; cancel: LONGINT; infoPtr: Ptr): OSErr;

{
    The following routines are obsolete and will not be supported on
    PowerPC. Equivalent functionality is provided by the routines
    above.
}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC TARGET_CPU_68K }
{$IFC CALL_NOT_IN_CARBON }
{
 *  MPPClose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPPClose: OSErr;

{
 *  LAPOpenProtocol()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION LAPOpenProtocol(theLAPType: ByteParameter; protoPtr: Ptr): OSErr;

{
 *  LAPCloseProtocol()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION LAPCloseProtocol(theLAPType: ByteParameter): OSErr;

{
 *  LAPWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION LAPWrite(abRecord: ATLAPRecHandle; async: BOOLEAN): OSErr;

{
 *  LAPRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION LAPRead(abRecord: ATLAPRecHandle; async: BOOLEAN): OSErr;

{
 *  LAPRdCancel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION LAPRdCancel(abRecord: ATLAPRecHandle): OSErr;

{
 *  DDPOpenSocket()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DDPOpenSocket(VAR theSocket: INTEGER; sktListener: Ptr): OSErr;

{
 *  DDPCloseSocket()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DDPCloseSocket(theSocket: INTEGER): OSErr;

{
 *  DDPRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DDPRead(abRecord: ATDDPRecHandle; retCksumErrs: BOOLEAN; async: BOOLEAN): OSErr;

{
 *  DDPWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DDPWrite(abRecord: ATDDPRecHandle; doChecksum: BOOLEAN; async: BOOLEAN): OSErr;

{
 *  DDPRdCancel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DDPRdCancel(abRecord: ATDDPRecHandle): OSErr;

{
 *  ATPOpenSocket()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATPOpenSocket(addrRcvd: AddrBlock; VAR atpSocket: INTEGER): OSErr;

{
 *  ATPCloseSocket()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATPCloseSocket(atpSocket: INTEGER): OSErr;

{
 *  ATPSndRequest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATPSndRequest(abRecord: ATATPRecHandle; async: BOOLEAN): OSErr;

{
 *  ATPRequest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATPRequest(abRecord: ATATPRecHandle; async: BOOLEAN): OSErr;

{
 *  ATPReqCancel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATPReqCancel(abRecord: ATATPRecHandle; async: BOOLEAN): OSErr;

{
 *  ATPGetRequest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATPGetRequest(abRecord: ATATPRecHandle; async: BOOLEAN): OSErr;

{
 *  ATPSndRsp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATPSndRsp(abRecord: ATATPRecHandle; async: BOOLEAN): OSErr;

{
 *  ATPAddRsp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATPAddRsp(abRecord: ATATPRecHandle): OSErr;

{
 *  ATPResponse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATPResponse(abRecord: ATATPRecHandle; async: BOOLEAN): OSErr;

{
 *  ATPRspCancel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ATPRspCancel(abRecord: ATATPRecHandle; async: BOOLEAN): OSErr;

{
 *  NBPRegister()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NBPRegister(abRecord: ATNBPRecHandle; async: BOOLEAN): OSErr;

{
 *  NBPLookup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NBPLookup(abRecord: ATNBPRecHandle; async: BOOLEAN): OSErr;

{
 *  NBPConfirm()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NBPConfirm(abRecord: ATNBPRecHandle; async: BOOLEAN): OSErr;

{
 *  NBPRemove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NBPRemove(abEntity: EntityPtr): OSErr;

{
 *  NBPLoad()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NBPLoad: OSErr;

{
 *  NBPUnload()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NBPUnload: OSErr;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_CPU_68K}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AppleTalkIncludes}

{$ENDC} {__APPLETALK__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

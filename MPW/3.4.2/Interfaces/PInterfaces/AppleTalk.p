{
 	File:		AppleTalk.p
 
 	Contains:	AppleTalk Interfaces.
 
 	Version:	Technology:	System 7.5
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
 UNIT AppleTalk;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __APPLETALK__}
{$SETC __APPLETALK__ := 1}

{$I+}
{$SETC AppleTalkIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{	MixedMode.p													}
{	Memory.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{ Driver unit and reference numbers (ADSP is dynamic) }
	mppUnitNum					= 9;							{ MPP unit number }
	atpUnitNum					= 10;							{ ATP unit number }
	xppUnitNum					= 40;							{ XPP unit number }
	mppRefNum					= -10;							{ MPP reference number }
	atpRefNum					= -11;							{ ATP reference number }
	xppRefNum					= -41;							{ XPP reference number }
{ .MPP csCodes }
	lookupReply					= 242;							{ This command queued to ourself }
	writeLAP					= 243;							{ Write out LAP packet }
	detachPH					= 244;							{ Detach LAP protocol handler }
	attachPH					= 245;							{ Attach LAP protocol handler }
	writeDDP					= 246;							{ Write out DDP packet }
	closeSkt					= 247;							{ Close DDP socket }
	openSkt						= 248;							{ Open DDP socket }
	loadNBP						= 249;							{ Load NBP command-executing code }
	lastResident				= 249;							{ Last resident command }
	confirmName					= 250;							{ Confirm name }
	lookupName					= 251;							{ Look up name on internet }
	removeName					= 252;							{ Remove name from Names Table }
	registerName				= 253;							{ Register name in Names Table }
	killNBP						= 254;							{ Kill outstanding NBP request }

	unloadNBP					= 255;							{ Unload NBP command code }
	setSelfSend					= 256;							{ MPP: Set to allow writes to self }
	SetMyZone					= 257;							{ Set my zone name }
	GetATalkInfo				= 258;							{ get AppleTalk information }
	ATalkClosePrep				= 259;							{ AppleTalk close query }
{ .ATP csCodes }
	nSendRequest				= 248;							{ NSendRequest code }
	relRspCB					= 249;							{ Release RspCB }
	closeATPSkt					= 250;							{ Close ATP socket }
	addResponse					= 251;							{ Add response code | Require open skt }
	sendResponse				= 252;							{ Send response code }
	getRequest					= 253;							{ Get request code }
	openATPSkt					= 254;							{ Open ATP socket }
	sendRequest					= 255;							{ Send request code }
	relTCB						= 256;							{ Release TCB }
	killGetReq					= 257;							{ Kill GetRequest }
	killSendReq					= 258;							{ Kill SendRequest }
	killAllGetReq				= 259;							{ Kill all getRequests for a skt }
{ .XPP csCodes }
	openSess					= 255;							{ Open session }
	closeSess					= 254;							{ Close session }
	userCommand					= 253;							{ User command }

	userWrite					= 252;							{ User write }
	getStatus					= 251;							{ Get status }
	afpCall						= 250;							{ AFP command (buffer has command code) }
	getParms					= 249;							{ Get parameters }
	abortOS						= 248;							{ Abort open session request }
	closeAll					= 247;							{ Close all open sessions }
	xCall						= 246;							{ .XPP extended calls }
{ Transition Queue transition types }
	ATTransOpen					= 0;							{AppleTalk has opened}
	ATTransClose				= 2;							{AppleTalk is about to close}
	ATTransClosePrep			= 3;							{Is it OK to close AppleTalk ?}
	ATTransCancelClose			= 4;							{Cancel the ClosePrep transition}
	afpByteRangeLock			= 1;							{AFPCall command codes}
	afpVolClose					= 2;							{AFPCall command codes}
	afpDirClose					= 3;							{AFPCall command codes}
	afpForkClose				= 4;							{AFPCall command codes}
	afpCopyFile					= 5;							{AFPCall command codes}
	afpDirCreate				= 6;							{AFPCall command codes}
	afpFileCreate				= 7;							{AFPCall command codes}
	afpDelete					= 8;							{AFPCall command codes}
	afpEnumerate				= 9;							{AFPCall command codes}

	afpFlush					= 10;							{AFPCall command codes}
	afpForkFlush				= 11;							{AFPCall command codes}
	afpGetDirParms				= 12;							{AFPCall command codes}
	afpGetFileParms				= 13;							{AFPCall command codes}
	afpGetForkParms				= 14;							{AFPCall command codes}
	afpGetSInfo					= 15;							{AFPCall command codes}
	afpGetSParms				= 16;							{AFPCall command codes}
	afpGetVolParms				= 17;							{AFPCall command codes}
	afpLogin					= 18;							{AFPCall command codes}
	afpContLogin				= 19;							{AFPCall command codes}
	afpLogout					= 20;							{AFPCall command codes}
	afpMapID					= 21;							{AFPCall command codes}
	afpMapName					= 22;							{AFPCall command codes}
	afpMove						= 23;							{AFPCall command codes}
	afpOpenVol					= 24;							{AFPCall command codes}
	afpOpenDir					= 25;							{AFPCall command codes}
	afpOpenFork					= 26;							{AFPCall command codes}
	afpRead						= 27;							{AFPCall command codes}
	afpRename					= 28;							{AFPCall command codes}
	afpSetDirParms				= 29;							{AFPCall command codes}

	afpSetFileParms				= 30;							{AFPCall command codes}
	afpSetForkParms				= 31;							{AFPCall command codes}
	afpSetVolParms				= 32;							{AFPCall command codes}
	afpWrite					= 33;							{AFPCall command codes}
	afpGetFlDrParms				= 34;							{AFPCall command codes}
	afpSetFlDrParms				= 35;							{AFPCall command codes}
	afpDTOpen					= 48;							{AFPCall command codes}
	afpDTClose					= 49;							{AFPCall command codes}
	afpGetIcon					= 51;							{AFPCall command codes}
	afpGtIcnInfo				= 52;							{AFPCall command codes}
	afpAddAPPL					= 53;							{AFPCall command codes}
	afpRmvAPPL					= 54;							{AFPCall command codes}
	afpGetAPPL					= 55;							{AFPCall command codes}
	afpAddCmt					= 56;							{AFPCall command codes}
	afpRmvCmt					= 57;							{AFPCall command codes}
	afpGetCmt					= 58;							{AFPCall command codes}
	afpAddIcon					= 192;							{Special code for ASP Write commands}
	xppLoadedBit				= 5;							{ XPP bit in PortBUse }
	scbMemSize					= 192;							{ Size of memory for SCB }
	xppFlagClr					= 0;							{ Cs for AFPCommandBlock }

	xppFlagSet					= 128;							{ StartEndFlag & NewLineFlag fields. }
	lapSize						= 20;
	ddpSize						= 26;
	nbpSize						= 26;
	atpSize						= 56;
	atpXOvalue					= 32;							{ATP exactly-once bit }
	atpEOMvalue					= 16;							{ATP End-Of-Message bit }
	atpSTSvalue					= 8;							{ATP Send-Transmission-Status bit }
	atpTIDValidvalue			= 2;							{ATP trans. ID valid bit }
	atpSendChkvalue				= 1;							{ATP send checksum bit }
	zipGetLocalZones			= 5;
	zipGetZoneList				= 6;
	zipGetMyZone				= 7;
	LAPMgrPtr					= $B18;							{Entry point for LAP Manager}
	LAPMgrCall					= 2;							{Offset to LAP routines}
	LAddAEQ						= 23;							{LAPAddATQ routine selector}
	LRmvAEQ						= 24;							{LAPRmvATQ routine selector}

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
	ABCallType = SInt8;


CONST
	lapProto					= 0;
	ddpProto					= 1;
	nbpProto					= 2;
	atpProto					= 3;

	
TYPE
	ABProtoType = UInt8;

	ABByte = Byte;

	LAPAdrBlock = PACKED RECORD
		dstNodeID:				UInt8;
		srcNodeID:				UInt8;
		lapProtType:			ABByte;
		filler:					UInt8;									{	Filler for proper byte alignment}
	END;

	ATQEntryPtr = ^ATQEntry;

	ATalkTransitionEventProcPtr = ProcPtr;  { FUNCTION ATalkTransitionEvent(eventCode: LONGINT; qElem: ATQEntryPtr; eventParameter: UNIV Ptr): LONGINT; }
	ATalkTransitionEventUPP = UniversalProcPtr;

	ATalkTransitionEvent = ATalkTransitionEventUPP;

	ATQEntry = RECORD
		qLink:					^ATQEntry;								{next queue entry}
		qType:					INTEGER;								{queue type}
		CallAddr:				ATalkTransitionEventUPP;				{your routine descriptor}
	END;

	AddrBlock = PACKED RECORD
		aNet:					UInt16;
		aNode:					UInt8;
		aSocket:				UInt8;
	END;

{ 
	Real definition of EntityName is 3 PACKED strings of any length (32 is just an example). No
	offests for Asm since each String address must be calculated by adding length byte to last string ptr.
	In Pascal, String(32) will be 34 bytes long since fields never start on an odd byte unless they are 
	only a byte long. So this will generate correct looking interfaces for Pascal and C, but they will not
	be the same, which is OK since they are not used. 
}
	EntityName = RECORD
		objStr:					Str32;
		typeStr:				Str32;
		zoneStr:				Str32;
	END;

	EntityPtr = ^EntityName;

	RetransType = PACKED RECORD
		retransInterval:		UInt8;
		retransCount:			UInt8;
	END;

	BDSElement = RECORD
		buffSize:				INTEGER;
		buffPtr:				Ptr;
		dataSize:				INTEGER;
		userBytes:				LONGINT;
	END;

	BDSType = ARRAY [0..7] OF BDSElement;

	BDSPtr = ^BDSElement;

	BitMapType = PACKED ARRAY [0..7] OF BOOLEAN;

	ATLAPRec = RECORD
		abOpcode:				ABCallType;
		filler:					SInt8;									{	Filler for proper byte alignment}
		abResult:				INTEGER;
		abUserReference:		LONGINT;
		lapAddress:				LAPAdrBlock;
		lapReqCount:			INTEGER;
		lapActCount:			INTEGER;
		lapDataPtr:				Ptr;
	END;

	ATLAPRecPtr = ^ATLAPRec;
	ATLAPRecHandle = ^ATLAPRecPtr;

	ATDDPRec = RECORD
		abOpcode:				ABCallType;
		filler:					SInt8;									{	Filler for proper byte alignment}
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

	ATDDPRecPtr = ^ATDDPRec;
	ATDDPRecHandle = ^ATDDPRecPtr;

	ATNBPRec = RECORD
		abOpcode:				ABCallType;
		filler:					SInt8;									{	Filler for proper byte alignment}
		abResult:				INTEGER;
		abUserReference:		LONGINT;
		nbpEntityPtr:			EntityPtr;
		nbpBufPtr:				Ptr;
		nbpBufSize:				INTEGER;
		nbpDataField:			INTEGER;
		nbpAddress:				AddrBlock;
		nbpRetransmitInfo:		RetransType;
	END;

	ATNBPRecPtr = ^ATNBPRec;
	ATNBPRecHandle = ^ATNBPRecPtr;

	ATATPRec = RECORD
		abOpcode:				ABCallType;
		filler1:				SInt8;									{	Filler for proper byte alignment}
		abResult:				INTEGER;
		abUserReference:		LONGINT;
		atpSocket:				INTEGER;
		atpAddress:				AddrBlock;
		atpReqCount:			INTEGER;
		atpDataPtr:				Ptr;
		atpRspBDSPtr:			BDSPtr;
		atpBitMap:				BitMapType;
		filler2:				SInt8; (* UInt8 *)						{	Filler for proper byte alignment}
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

	ATATPRecPtr = ^ATATPRec;
	ATATPRecHandle = ^ATATPRecPtr;

	AFPCommandBlock = PACKED RECORD
		cmdByte:				UInt8;
		startEndFlag:			UInt8;
		forkRefNum:				INTEGER;
		rwOffset:				LONGINT;
		reqCount:				LONGINT;
		newLineFlag:			UInt8;
		newLineChar:			CHAR;
	END;

	MPPPBPtr = ^MPPParamBlock;

	ATPPBPtr = ^ATPParamBlock;

	XPPParmBlkPtr = ^XPPParamBlock;

	{
		MPPCompletionProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => thePBptr    	A0.L
	}
	MPPCompletionProcPtr = Register68kProcPtr;  { register PROCEDURE MPPCompletion(thePBptr: MPPPBPtr); }
	{
		ATPCompletionProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => thePBptr    	A0.L
	}
	ATPCompletionProcPtr = Register68kProcPtr;  { register PROCEDURE ATPCompletion(thePBptr: ATPPBPtr); }
	{
		XPPCompletionProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => thePBptr    	A0.L
	}
	XPPCompletionProcPtr = Register68kProcPtr;  { register PROCEDURE XPPCompletion(thePBptr: XPPParmBlkPtr); }
	{
		AttnRoutineProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => sessRefnum  	D0.W
		 => attnBytes   	D1.W
	}
	AttnRoutineProcPtr = Register68kProcPtr;  { register PROCEDURE AttnRoutine(sessRefnum: INTEGER; attnBytes: INTEGER); }
	MPPCompletionUPP = UniversalProcPtr;
	ATPCompletionUPP = UniversalProcPtr;
	XPPCompletionUPP = UniversalProcPtr;
	AttnRoutineUPP = UniversalProcPtr;

	WDSElement = RECORD
		entryLength:			INTEGER;
		entryPtr:				Ptr;
	END;

	NTElement = RECORD
		nteAddress:				AddrBlock;								{network address of entity}
		filler:					SInt8;
		entityData:				PACKED ARRAY [0..98] OF SInt8;			{Object, Type & Zone}
	END;

	NamesTableEntry = RECORD
		qNext:					Ptr;									{ptr to next NTE}
		nt:						NTElement;
	END;

	MPPProtocolHandlerProcPtr = ProcPtr;  { FUNCTION MPPProtocolHandler(SCCAddr1: Ptr; SCCAddr2: Ptr; MPPLocalVars: Ptr; nextFreeByteInRHA: Ptr; ReadPacketAndReadRestPtr: Ptr; numBytesLeftToReadInPacket: INTEGER): BOOLEAN; }
	DDPSocketListenerProcPtr = ProcPtr;  { FUNCTION DDPSocketListener(SCCAddr1: Ptr; SCCAddr2: Ptr; MPPLocalVars: Ptr; nextFreeByteInRHA: Ptr; ReadPacketAndReadRestPtr: Ptr; packetDestinationNumber: ByteParameter; numBytesLeftToReadInPacket: INTEGER): BOOLEAN; }
	MPPProtocolHandlerUPP = UniversalProcPtr;
	DDPSocketListenerUPP = UniversalProcPtr;

	MPPParamBlock = PACKED RECORD
		qLink:					^QElem;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			ATPCompletionUPP;
		ioResult:				OSErr;
		userData:				LONGINT;
		reqTID:					INTEGER;
		ioRefNum:				INTEGER;
		csCode:					INTEGER;
		CASE INTEGER OF
		0: (
			filler0:					INTEGER;
			wdsPointer:					Ptr;
		   );
		1: (
			protType:					UInt8;
			filler:						UInt8;
			handler:					MPPProtocolHandlerUPP;
		   );
		2: (
			socket:						UInt8;
			checksumFlag:				UInt8;
			listener:					DDPSocketListenerUPP;
		   );
		3: (
			interval:					SInt8; (* UInt8 *)					{retry interval }
			count:						SInt8; (* UInt8 *)					{retry count }
			nbpPtrs:					Ptr;
			CASE INTEGER OF
			0: (
				verifyFlag:						SInt8; (* UInt8 *)
				filler3:						SInt8; (* UInt8 *)
			   );
			1: (
				retBuffPtr:						Ptr;
				retBuffSize:					INTEGER;
				maxToGet:						INTEGER;
				numGotten:						INTEGER;
			   );
			2: (
				confirmAddr:					AddrBlock;
				newSocket:						SInt8; (* UInt8 *)
				filler4:						SInt8; (* UInt8 *)
			   );
		   );
		4: (
			newSelfFlag:				UInt8;								{self-send toggle flag }
			oldSelfFlag:				UInt8;								{previous self-send state }
		   );
		5: (
			nKillQEl:					Ptr;								{ptr to i/o queue element to cancel }
		   );
		6: (
			version:					INTEGER;
			varsPtr:					Ptr;
			DCEPtr:						Ptr;
			portID:						INTEGER;
			configuration:				LONGINT;
			selfSend:					INTEGER;
			netLo:						INTEGER;
			netHi:						INTEGER;
			ourAdd:						LONGINT;
			routerAddr:					LONGINT;
			numOfPHs:					INTEGER;
			numOfSkts:					INTEGER;
			numNBPEs:					INTEGER;
			nTQueue:					Ptr;
			LAlength:					INTEGER;
			linkAddr:					Ptr;
			zoneName:					Ptr;
		   );
		7: (
			appName:					Ptr;								{pointer to application name in buffer}
		   );
	END;

	XPPParamBlock = PACKED RECORD
		qLink:					^QElem;
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
			abortSCBPtr:				Ptr;								{ SCB pointer for AbortOS}
		   );
		1: (
			aspMaxCmdSize:				INTEGER;
			aspQuantumSize:				INTEGER;
			numSesss:					INTEGER;
		   );
		2: (
			sessRefnum:					INTEGER;
			aspTimeout:					SInt8; (* UInt8 *)
			aspRetry:					SInt8; (* UInt8 *)
			CASE INTEGER OF
			0: (
				serverAddr:						AddrBlock;
				scbPointer:						Ptr;
				attnRoutine:					AttnRoutineUPP;
			   );
			1: (
				cbSize:							INTEGER;
				cbPtr:							Ptr;
				rbSize:							INTEGER;
				rbPtr:							Ptr;
				CASE INTEGER OF
				0: (
					afpAddrBlock:						AddrBlock;
					afpSCBPtr:							Ptr;
					afpAttnRoutine:						Ptr;
				   );
				1: (
					wdSize:								INTEGER;
					wdPtr:								Ptr;
					ccbStart:							ARRAY [0..295] OF SInt8; (* UInt8 *)
				   );
			   );
		   );
		3: (
			xppSubCode:					INTEGER;
			xppTimeout:					UInt8;
			xppRetry:					UInt8;
			filler1:					INTEGER;
			zipBuffPtr:					Ptr;
			zipNumZones:				INTEGER;
			zipLastFlag:				UInt8;
			filler2:					UInt8;
			zipInfoField:				PACKED ARRAY [1..70] OF UInt8;
		   );
	END;

	ATPParamBlock = PACKED RECORD
		qLink:					^QElem;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			ATPCompletionUPP;
		ioResult:				OSErr;
		userData:				LONGINT;
		reqTID:					INTEGER;
		ioRefNum:				INTEGER;
		csCode:					INTEGER;
		atpSocket:				UInt8;
		atpFlags:				UInt8;
		addrBlock:				AddrBlock;
		reqLength:				INTEGER;
		reqPointer:				Ptr;
		bdsPointer:				Ptr;
		CASE INTEGER OF
		0: (
			numOfBuffs:					UInt8;
			timeOutVal:					UInt8;
			numOfResps:					UInt8;
			retryCount:					UInt8;
			intBuff:					INTEGER;
			TRelTime:					UInt8;
		   );
		1: (
			filler:						UInt8;
			bdsSize:					UInt8;
			transID:					INTEGER;
		   );
		2: (
			bitMap:						UInt8;
			filler2:					UInt8;
		   );
		3: (
			rspNum:						UInt8;
			filler3:					UInt8;
		   );
		4: (
			aKillQEl:					Ptr;
		   );
	END;


CONST
	uppATalkTransitionEventProcInfo = $00000FF1; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 4 byte result; }
	uppMPPCompletionProcInfo = $00009802; { Register PROCEDURE (4 bytes in A0); }
	uppATPCompletionProcInfo = $00009802; { Register PROCEDURE (4 bytes in A0); }
	uppXPPCompletionProcInfo = $00009802; { Register PROCEDURE (4 bytes in A0); }
	uppAttnRoutineProcInfo = $00061002; { Register PROCEDURE (2 bytes in D0, 2 bytes in D1); }
	uppMPPProtocolHandlerProcInfo = $0000007F; { SPECIAL_CASE_PROCINFO( kSpecialCaseProtocolHandler ) }
	uppDDPSocketListenerProcInfo = $0000008F; { SPECIAL_CASE_PROCINFO( kSpecialCaseSocketListener ) }

FUNCTION NewATalkTransitionEventProc(userRoutine: ATalkTransitionEventProcPtr): ATalkTransitionEventUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMPPCompletionProc(userRoutine: MPPCompletionProcPtr): MPPCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewATPCompletionProc(userRoutine: ATPCompletionProcPtr): ATPCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewXPPCompletionProc(userRoutine: XPPCompletionProcPtr): XPPCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewAttnRoutineProc(userRoutine: AttnRoutineProcPtr): AttnRoutineUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMPPProtocolHandlerProc(userRoutine: MPPProtocolHandlerProcPtr): MPPProtocolHandlerUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewDDPSocketListenerProc(userRoutine: DDPSocketListenerProcPtr): DDPSocketListenerUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallATalkTransitionEventProc(eventCode: LONGINT; qElem: ATQEntryPtr; eventParameter: UNIV Ptr; userRoutine: ATalkTransitionEventUPP): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallMPPCompletionProc(thePBptr: MPPPBPtr; userRoutine: MPPCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallATPCompletionProc(thePBptr: ATPPBPtr; userRoutine: ATPCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallXPPCompletionProc(thePBptr: XPPParmBlkPtr; userRoutine: XPPCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallAttnRoutineProc(sessRefnum: INTEGER; attnBytes: INTEGER; userRoutine: AttnRoutineUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

FUNCTION CallMPPProtocolHandlerProc(SCCAddr1: Ptr; SCCAddr2: Ptr; MPPLocalVars: Ptr; nextFreeByteInRHA: Ptr; ReadPacketAndReadRestPtr: Ptr; numBytesLeftToReadInPacket: INTEGER; userRoutine: MPPProtocolHandlerUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters according to special case conventions.}
	{$ENDC}

FUNCTION CallDDPSocketListenerProc(SCCAddr1: Ptr; SCCAddr2: Ptr; MPPLocalVars: Ptr; nextFreeByteInRHA: Ptr; ReadPacketAndReadRestPtr: Ptr; packetDestinationNumber: ByteParameter; numBytesLeftToReadInPacket: INTEGER; userRoutine: DDPSocketListenerUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters according to special case conventions.}
	{$ENDC}

FUNCTION OpenXPP(VAR xppRefnum: INTEGER): OSErr;
FUNCTION ASPOpenSession(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION ASPCloseSession(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION ASPAbortOS(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION ASPGetParms(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION ASPCloseAll(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION ASPUserWrite(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION ASPUserCommand(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION ASPGetStatus(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION AFPCommand(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION GetLocalZones(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION GetZoneList(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION GetMyZone(thePBptr: XPPParmBlkPtr; async: BOOLEAN): OSErr;
FUNCTION PAttachPH(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PDetachPH(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PWriteLAP(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;
FUNCTION POpenSkt(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PCloseSkt(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PWriteDDP(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PRegisterName(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PLookupName(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PConfirmName(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PRemoveName(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PSetSelfSend(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PKillNBP(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PGetAppleTalkInfo(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PATalkClosePrep(thePBptr: MPPPBPtr; async: BOOLEAN): OSErr;
FUNCTION POpenATPSkt(thePBptr: ATPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PCloseATPSkt(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PSendRequest(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PGetRequest(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PSendResponse(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PAddResponse(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PRelTCB(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PRelRspCB(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PNSendRequest(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PKillSendReq(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;
FUNCTION PKillGetReq(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;
FUNCTION ATPKillAllGetReq(thePBPtr: ATPPBPtr; async: BOOLEAN): OSErr;
PROCEDURE BuildLAPwds(wdsPtr: Ptr; dataPtr: Ptr; destHost: INTEGER; prototype: INTEGER; frameLen: INTEGER);
PROCEDURE BuildDDPwds(wdsPtr: Ptr; headerPtr: Ptr; dataPtr: Ptr; netAddr: AddrBlock; ddpType: INTEGER; dataLen: INTEGER);
PROCEDURE NBPSetEntity(buffer: Ptr; nbpObject: ConstStr32Param; nbpType: ConstStr32Param; nbpZone: ConstStr32Param);
PROCEDURE NBPSetNTE(ntePtr: Ptr; nbpObject: ConstStr32Param; nbpType: ConstStr32Param; nbpZone: ConstStr32Param; socket: INTEGER);
FUNCTION GetBridgeAddress: INTEGER;
FUNCTION BuildBDS(buffPtr: Ptr; bdsPtr: Ptr; buffSize: INTEGER): INTEGER;
FUNCTION MPPOpen: OSErr;
FUNCTION LAPAddATQ(theATQEntry: ATQEntryPtr): OSErr;
FUNCTION LAPRmvATQ(theATQEntry: ATQEntryPtr): OSErr;
FUNCTION ATPLoad: OSErr;
FUNCTION ATPUnload: OSErr;
FUNCTION NBPExtract(theBuffer: Ptr; numInBuf: INTEGER; whichOne: INTEGER; VAR abEntity: EntityName; VAR address: AddrBlock): OSErr;
FUNCTION GetNodeAddress(VAR myNode: INTEGER; VAR myNet: INTEGER): OSErr;
FUNCTION IsMPPOpen: BOOLEAN;
FUNCTION IsATPOpen: BOOLEAN;
PROCEDURE ATEvent(event: LONGINT; infoPtr: Ptr);
FUNCTION ATPreFlightEvent(event: LONGINT; cancel: LONGINT; infoPtr: Ptr): OSErr;
{
	The following routines are obsolete and will not be supported on
	PowerPC. Equivalent functionality is provided by the routines
	above.
}
{$IFC OLDROUTINENAMES  & NOT GENERATINGCFM }
FUNCTION MPPClose: OSErr;
FUNCTION LAPOpenProtocol(theLAPType: ByteParameter; protoPtr: Ptr): OSErr;
FUNCTION LAPCloseProtocol(theLAPType: ByteParameter): OSErr;
FUNCTION LAPWrite(abRecord: ATLAPRecHandle; async: BOOLEAN): OSErr;
FUNCTION LAPRead(abRecord: ATLAPRecHandle; async: BOOLEAN): OSErr;
FUNCTION LAPRdCancel(abRecord: ATLAPRecHandle): OSErr;
FUNCTION DDPOpenSocket(VAR theSocket: INTEGER; sktListener: Ptr): OSErr;
FUNCTION DDPCloseSocket(theSocket: INTEGER): OSErr;
FUNCTION DDPRead(abRecord: ATDDPRecHandle; retCksumErrs: BOOLEAN; async: BOOLEAN): OSErr;
FUNCTION DDPWrite(abRecord: ATDDPRecHandle; doChecksum: BOOLEAN; async: BOOLEAN): OSErr;
FUNCTION DDPRdCancel(abRecord: ATDDPRecHandle): OSErr;
FUNCTION ATPOpenSocket(addrRcvd: AddrBlock; VAR atpSocket: INTEGER): OSErr;
FUNCTION ATPCloseSocket(atpSocket: INTEGER): OSErr;
FUNCTION ATPSndRequest(abRecord: ATATPRecHandle; async: BOOLEAN): OSErr;
FUNCTION ATPRequest(abRecord: ATATPRecHandle; async: BOOLEAN): OSErr;
FUNCTION ATPReqCancel(abRecord: ATATPRecHandle; async: BOOLEAN): OSErr;
FUNCTION ATPGetRequest(abRecord: ATATPRecHandle; async: BOOLEAN): OSErr;
FUNCTION ATPSndRsp(abRecord: ATATPRecHandle; async: BOOLEAN): OSErr;
FUNCTION ATPAddRsp(abRecord: ATATPRecHandle): OSErr;
FUNCTION ATPResponse(abRecord: ATATPRecHandle; async: BOOLEAN): OSErr;
FUNCTION ATPRspCancel(abRecord: ATATPRecHandle; async: BOOLEAN): OSErr;
FUNCTION NBPRegister(abRecord: ATNBPRecHandle; async: BOOLEAN): OSErr;
FUNCTION NBPLookup(abRecord: ATNBPRecHandle; async: BOOLEAN): OSErr;
FUNCTION NBPConfirm(abRecord: ATNBPRecHandle; async: BOOLEAN): OSErr;
FUNCTION NBPRemove(abEntity: EntityPtr): OSErr;
FUNCTION NBPLoad: OSErr;
FUNCTION NBPUnload: OSErr;
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AppleTalkIncludes}

{$ENDC} {__APPLETALK__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

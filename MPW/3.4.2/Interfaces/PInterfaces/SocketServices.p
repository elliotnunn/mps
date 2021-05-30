{
 	File:		SocketServices.p
 
 	Contains:	This file contains constants and data structures that
				describe the Socket Service interface to Card Services.
 
 	Version:	Technology: PCMCIA Software 2.0
				Package:	Universal Interfaces 2.1.1 in “MPW Latest” on ETO #19
 
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
 UNIT SocketServices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SOCKETSERVICES__}
{$SETC __SOCKETSERVICES__ := 1}

{$I+}
{$SETC SocketServicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
	
TYPE
	SS_BYTE = Byte;

	SS_FLAGS8 = Byte;

	SS_IRQ = Byte;

	SS_PWRLEVEL = Byte;

	SS_ADAPTER = UInt16;

	SS_BCD = UInt16;

	SS_COUNT = UInt16;

	SS_EDC = UInt16;

	SS_FLAGS16 = UInt16;

	SS_PAGE = UInt16;

	SS_PWRINDEX = UInt16;

	SS_SIGNATURE = UInt16;

	SS_SKTBITS = UInt16;

	SS_SOCKET = UInt16;

	SS_SPEED = UInt16;

	SS_WINDOW = UInt16;

	SS_WORD = UInt16;

	SS_BASE = UInt32;

	SS_FLAGS32 = UInt32;

	SS_OFFSET = UInt32;

	SS_SIZE = UInt32;

	SS_PTR = Ptr;

	SS_RETCODE = OSErr;

	SS_SCHARTBL = RECORD
		sktCaps:				UInt16;									{	SS_FLAGS16}
		activeHigh:				UInt32;									{	SS_FLAGS32}
		activeLow:				UInt32;									{	SS_FLAGS32}
	END;

	SS_SISTRUCT = RECORD
		bufferLength:			UInt16;									{	SS_WORD}
		dataLength:				UInt16;									{	SS_WORD}
		charTable:				SS_SCHARTBL;							{	SS_FLAGS16}
	END;

{$SETC STR_SIZE := 24}
	SS_VISTRUCT = RECORD
		bufferLength:			UInt16;									{	SS_WORD}
		dataLength:				UInt16;									{	SS_WORD}
		szImplementor:			ARRAY [0..0] OF CHAR;					{	SS_WORD}
		padding:				ARRAY [0..0] OF SInt8; (* Byte *)		{	}
	END;

	SS_ACHARTBL = RECORD
		adpCaps:				UInt16;									{	SS_FLAGS16}
		activeHigh:				UInt32;									{	SS_FLAGS32}
		activeLow:				UInt32;									{	SS_FLAGS32}
	END;

	SS_PWRENTRY = RECORD
		powerLevel:				SInt8; (* Byte *)						{	SS_PWRLEVEL}
		validSignals:			SInt8; (* Byte *)						{	SS_FLAGS8}
	END;

	SS_AISTRUCT = RECORD
		bufferLength:			UInt16;									{	SS_WORD}
		dataLength:				UInt16;									{	SS_WORD}
		charTable:				SS_ACHARTBL;
		numPwrEntries:			UInt16;									{	SS_WORD}
		pwrEntryPtr:			^SS_PWRENTRY;
	END;

	SS_MEMWINTBL = RECORD
		memWndCaps:				UInt16;									{	SS_FLAGS16}
		firstByte:				UInt32;									{	SS_BASE}
		lastByte:				UInt32;									{	SS_BASE}
		minSize:				UInt32;									{	SS_SIZE}
		maxSize:				UInt32;									{	SS_SIZE}
		reqGran:				UInt32;									{	SS_SIZE}
		reqBase:				UInt32;									{	SS_SIZE}
		reqOffset:				UInt32;									{	SS_SIZE}
		slowest:				UInt16;									{	SS_SPEED}
		fastest:				UInt16;									{	SS_SPEED}
	END;

	SS_IOWINTBL = RECORD
		ioWndCaps:				UInt16;									{	SS_FLAGS16}
		firstByte:				UInt32;									{	SS_BASE}
		lastByte:				UInt32;									{	SS_BASE}
		minSize:				UInt32;									{	SS_SIZE}
		maxSize:				UInt32;									{	SS_SIZE}
		reqGran:				UInt32;									{	SS_SIZE}
		addrLines:				UInt16;									{	SS_COUNT}
		eisaSlot:				SInt8; (* Byte *)						{	SS_FLAGS8}
		padding:				ARRAY [0..0] OF SInt8; (* Byte *)		{	}
	END;

	SS_WISTRUCT = RECORD
		bufferLength:			UInt16;									{	SS_WORD}
		dataLength:				UInt16;									{	SS_WORD}
		numTblEntries:			UInt16;									{	SS_WORD}
		memWinTbl:				SS_MEMWINTBL;
		ioWinTbl:				SS_IOWINTBL;
	END;

{————————————————————————————————————————————————————————————————————————
	function selectors passed to Socket Service entry point
————————————————————————————————————————————————————————————————————————}

CONST
	fnSSGetAdapterCount			= $80;
	fnSSUnsupported81			= $81;
	fnSSUnsupported82			= $82;
	fnSSGetSSInfo				= $83;
	fnSSInquireAdapter			= $84;
	fnSSGetAdapter				= $85;
	fnSSSetAdapter				= $86;
	fnSSInquireWindow			= $87;
	fnSSGetWindow				= $88;
	fnSSSetWindow				= $89;
	fnSSGetPage					= $8A;
	fnSSSetPage					= $8B;
	fnSSInquireSocket			= $8C;
	fnSSGetSocket				= $8D;
	fnSSSetSocket				= $8E;
	fnSSGetStatus				= $8F;
	fnSSResetSocket				= $90;
	fnSSUnsupported91			= $91;
	fnSSUnsupported92			= $92;
	fnSSUnsupported93			= $93;
	fnSSUnsupported94			= $94;
	fnSSInquireEDC				= $95;
	fnSSGetEDC					= $96;
	fnSSSetEDC					= $97;
	fnSSStartEDC				= $98;
	fnSSPauseEDC				= $99;
	fnSSResumeEDC				= $9A;
	fnSSStopEDC					= $9B;
	fnSSReadEDC					= $9C;
	fnSSGetVendorInfo			= $9D;
	fnSSAcknowledgeInterrupt	= $9E;
	fnSSGetSetPriorHandler		= $9F;
	fnSSGetSetSSAddr			= $A0;
	fnSSGetAccessOffsets		= $A1;
	fnSSUnsupportedA2			= $A2;
	fnSSUnsupportedA3			= $A3;
	fnSSUnsupportedA4			= $A4;
	fnSSUnsupportedA5			= $A5;
	fnSSUnsupportedA6			= $A6;
	fnSSUnsupportedA7			= $A7;
	fnSSUnsupportedA8			= $A8;
	fnSSUnsupportedA9			= $A9;
	fnSSUnsupportedAA			= $AA;
	fnSSUnsupportedAB			= $AB;
	fnSSUnsupportedAC			= $AC;
	fnSSUnsupportedAD			= $AD;
	fnSSVendorSpecific			= $AE;

{	SSVendorSpecificPB.function values}
	fnVSReserved				= $00;
	fnVSGetSocketLocationIcon	= $01;
	fnVSGetSocketLocationText	= $02;
	fnVSDoSocketLocalization	= $03;
	fnVSAppleSocketCapabilities	= $04;
	fnVSSleepWakeNotification	= $05;

{————————————————————————————————————————————————————————————————————————
	defines for the Socket Services function codes
————————————————————————————————————————————————————————————————————————}
	AC_IND						= 1;							{ adapter characteristics}
	AC_PWR						= 2;
	AC_DBW						= 4;

	AS_POWERDOWN				= 1;
	AS_MAINTAIN					= 2;

	EC_UNI						= 1;
	EC_BI						= 2;
	EC_REGISTER					= 4;
	EC_MEMORY					= 8;
	EC_PAUSABLE					= 16;
	EC_WRITE					= 16;

	ET_CHECK8					= 1;
	ET_SDLC16					= 2;

	IF_MEMORY					= 1;
	IF_IO						= 2;

	IRQ_HIGH					= 64;
	IRQ_ENABLE					= 128;

	IRQ_MEMORY					= 4;
	IRQ_IO						= 4;

	PS_ATTRIBUTE				= $01;
	PS_ENABLED					= $02;
	PS_WP						= $04;

	PWR_VCC						= 128;							{ Power pins in PwrEntry elements}
	PWR_VPP1					= 64;
	PWR_VPP2					= 32;

	SBM_WP						= 1;
	SBM_LOCKED					= 2;
	SBM_EJECT					= 4;
	SBM_INSERT					= 8;
	SBM_BVD1					= 16;
	SBM_BVD2					= 32;
	SBM_RDYBSY					= 64;
	SBM_CD						= 128;

	SBM_LOCK					= 16;
	SBM_BATT					= 32;
	SBM_BUSY					= 64;
	SBM_XIP						= 128;

{ Vendor Specific Apple Socket Capabilities }
	SBM_SLEEP_PWR				= 1;

	WC_COMMON					= 1;
	WC_IO						= 2;
	WC_ATTRIBUTE				= 4;
	WC_TYPE_MASK				= 7;
	WC_WAIT						= 128;

	WC_BASE						= 1;
	WC_SIZE						= 2;
	WC_WENABLE					= 4;
	WC_8BIT						= 8;
	WC_16BIT					= 16;
	WC_BALIGN					= 32;
	WC_POW2						= 64;
	WC_CALIGN					= 128;
	WC_PAVAIL					= 256;
	WC_PSHARED					= 512;
	WC_PENABLE					= 1024;
	WC_WP						= 2048;

	WC_INPACK					= 128;
	WC_EISA						= 256;
	WC_CENABLE					= 512;

	WS_IO						= 1;
	WS_ENABLED					= 2;
	WS_16BIT					= 4;

	WS_PAGED					= 8;
	WS_EISA						= 16;
	WS_CENABLE					= 32;
	WS_SWAP_LITTLE_TO_BIG_ENDIAN = 64;

	SS_SIG_VALUE				= $5353;						{ 'SS'}

	SS_CMPL_1_00				= $0100;						{ compliant with rev 1.0 of SS standard}
	SS_CMPL_1_01				= $0101;						{ compliant with rev 1.01 of SS standard}
	SS_CMPL_2_00				= $0200;						{ compliant with rev 2.0 of SS standard}
	SS_CMPL_2_10				= $0210;						{ compliant with rev 2.1 of SS standard}

{————————————————————————————————————————————————————————————————————————
	Universal ProcPtr for Socket Service entry point
————————————————————————————————————————————————————————————————————————}
TYPE
	PCCardSSEntryProcPtr = ProcPtr;  { FUNCTION PCCardSSEntry(fnCode: UInt16; callPB: Ptr; dataPtr: Ptr): INTEGER; }
	PCCardSSEntryUPP = UniversalProcPtr;

CONST
	uppPCCardSSEntryProcInfo = $00000FA0; { FUNCTION (2 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewPCCardSSEntryProc(userRoutine: PCCardSSEntryProcPtr): PCCardSSEntryUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallPCCardSSEntryProc(fnCode: UInt16; callPB: Ptr; dataPtr: Ptr; userRoutine: PCCardSSEntryUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
{————————————————————————————————————————————————————————————————————————
	Card Services calls used by a Socket Service
————————————————————————————————————————————————————————————————————————}

TYPE
	CSEventEntryPB = RECORD
		ssHandlerID:			UInt32;
		adapter:				UInt16;
		socket:					UInt16;
		message:				UInt16;
		intrpBits:				SInt8; (* Byte *)
		padding:				SInt8; (* Byte *)
	END;

	PCCardCSEntryProcPtr = ProcPtr;  { PROCEDURE PCCardCSEntry(VAR pb: CSEventEntryPB); }
	PCCardCSEntryUPP = UniversalProcPtr;

CONST
	uppPCCardCSEntryProcInfo = $000000C0; { PROCEDURE (4 byte param); }

FUNCTION NewPCCardCSEntryProc(userRoutine: PCCardCSEntryProcPtr): PCCardCSEntryUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallPCCardCSEntryProc(VAR pb: CSEventEntryPB; userRoutine: PCCardCSEntryUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
{------------		AddSocketServices		------------							}

TYPE
	AddSocketServicesPB = RECORD
		ssEntry:				PCCardSSEntryUPP;						{ -> given to CS for its use}
		csEntry:				PCCardCSEntryUPP;						{ <- taken from CS so we know where to enter}
		dataPtr:				UInt32;
		attributes:				UInt32;
		numAdapters:			UInt16;
		numSockets:				UInt16;
	END;

{------------ 		ReplaceSocketServices	------------							}
	ReplaceSocketServicesPB = RECORD
		ssEntry:				PCCardSSEntryUPP;
		oldSSEntry:				PCCardSSEntryUPP;
		dataPtr:				UInt32;
		socket:					UInt16;
		numSockets:				UInt16;
		attributes:				UInt16;
	END;


FUNCTION CSAddSocketServices(VAR pb: AddSocketServicesPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7050, $AAF0;
	{$ENDC}
FUNCTION CSReplaceSocketServices(VAR pb: ReplaceSocketServicesPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7051, $AAF0;
	{$ENDC}
{————————————————————————————————————————————————————————————————————————
	parameter blocks for each Socket Service function
————————————————————————————————————————————————————————————————————————}

TYPE
	SSAcknowledgeInterruptPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		sockets:				UInt16;									{	SS_SKTBITS}
	END;

	SSGetAccessOffsetsPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		mode:					SInt8; (* Byte *)						{	SS_BYTE}
		reserved:				SInt8; (* Byte *)						{	padding}
		count:					UInt16;									{	SS_COUNT}
		buffer:					Ptr;									{	SS_PTR}
		numAvail:				UInt16;									{	SS_COUNT}
	END;

	SSGetAdapterCountPB = RECORD
		totalAdapters:			UInt16;									{	SS_COUNT}
		sig:					UInt16;									{	SS_SIGNATURE}
	END;

	SSGetSetAdapterPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		state:					SInt8; (* Byte *)						{	SS_FLAGS8}
		irqStatus:				SInt8; (* Byte *)						{	SS_IRQ}
	END;

	SSGetSetEDCPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		edc:					UInt16;									{	SS_EDC}
		socket:					UInt16;									{	SS_SOCKET}
		state:					SInt8; (* Byte *)						{	SS_FLAGS8}
		edcType:				SInt8; (* Byte *)						{	SS_FLAGS8}
	END;

	SSGetSetPagePB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		window:					UInt16;									{	SS_WINDOW}
		page:					UInt16;									{	SS_PAGE}
		state:					SInt8; (* Byte *)						{	SS_FLAGS8}
		reserved:				SInt8; (* Byte *)						{	padding}
		offset:					UInt32;									{	SS_OFFSET}
	END;

	SSGetSetPriorHandlerPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		mode:					SInt8; (* Byte *)						{	SS_FLAGS8}
		reserved:				SInt8; (* Byte *)						{	padding}
		handler:				Ptr;									{	SS_PTR}
	END;

	SSGetSetSocketPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		socket:					UInt16;									{	SS_SOCKET}
		vccIndex:				UInt16;									{	SS_PWRINDEX}
		vpp1Index:				UInt16;									{	SS_PWRINDEX}
		vpp2Index:				UInt16;									{	SS_PWRINDEX}
		scIntMask:				SInt8; (* Byte *)						{	SS_FLAGS8}
		state:					SInt8; (* Byte *)						{	SS_FLAGS8}
		ctlInd:					SInt8; (* Byte *)						{	SS_FLAGS8}
		ireqRouting:			SInt8; (* Byte *)						{	SS_IRQ}
		ifType:					SInt8; (* Byte *)						{	SS_FLAGS8}
		padding:				ARRAY [0..0] OF SInt8; (* Byte *)		{	}
	END;

	SSGetSetSSAddrPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		mode:					SInt8; (* Byte *)						{	SS_BYTE}
		subfunc:				SInt8; (* Byte *)						{	SS_BYTE}
		numAddData:				UInt16;									{	SS_COUNT}
		buffer:					Ptr;									{	SS_PTR}
	END;

	SSGetSetWindowPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		window:					UInt16;									{	SS_WINDOW}
		socket:					UInt16;									{	SS_SOCKET}
		size:					UInt32;									{	SS_SIZE}
		state:					SInt8; (* Byte *)						{	SS_FLAGS8}
		reserved:				SInt8; (* Byte *)						{	padding}
		speed:					UInt16;									{	SS_SPEED}
		base:					UInt32;									{	SS_BASE}
	END;

	SSGetSSInfoPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		compliance:				UInt16;									{	SS_BCD}
		numAdapters:			UInt16;									{	SS_COUNT}
		firstAdapter:			UInt16;									{	SS_ADAPTER}
	END;

	SSGetStatusPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		socket:					UInt16;									{	SS_SOCKET}
		cardState:				SInt8; (* Byte *)						{	SS_FLAGS8}
		socketState:			SInt8; (* Byte *)						{	SS_FLAGS8}
		ctlInd:					SInt8; (* Byte *)						{	SS_FLAGS8}
		ireqRouting:			SInt8; (* Byte *)						{	SS_IRQ}
		ifType:					SInt8; (* Byte *)						{	SS_FLAGS8}
		padding:				ARRAY [0..0] OF SInt8; (* Byte *)		{	}
	END;

	SSGetVendorInfoPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		vendorInfoType:			SInt8; (* Byte *)						{	SS_BYTE}
		reserved:				SInt8; (* Byte *)						{	padding}
		buffer:					Ptr;									{	SS_PTR}
		release:				UInt16;									{	SS_BCD}
	END;

	SSInquireAdapterPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		buffer:					Ptr;									{	SS_PTR}
		numSockets:				UInt16;									{	SS_COUNT}
		numWindows:				UInt16;									{	SS_COUNT}
		numEDCs:				UInt16;									{	SS_COUNT}
	END;

	SSInquireEDCPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		edc:					UInt16;									{	SS_EDC}
		sockets:				UInt16;									{	SS_SKTBITS}
		caps:					SInt8; (* Byte *)						{	SS_FLAGS8}
		types:					SInt8; (* Byte *)						{	SS_FLAGS8}
	END;

	SSInquireSocketPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		socket:					UInt16;									{	SS_SOCKET}
		buffer:					Ptr;									{	SS_PTR}
		scIntCaps:				SInt8; (* Byte *)						{	SS_FLAGS8}
		scRptCaps:				SInt8; (* Byte *)						{	SS_FLAGS8}
		ctlIndCaps:				SInt8; (* Byte *)						{	SS_FLAGS8}
		padding:				ARRAY [0..0] OF SInt8; (* Byte *)		{	}
	END;

	SSInquireWindowPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		window:					UInt16;									{	SS_WINDOW}
		buffer:					Ptr;									{	SS_PTR}
		wndCaps:				SInt8; (* Byte *)						{	SS_FLAGS8}
		reserved:				SInt8; (* Byte *)						{	padding}
		sockets:				UInt16;									{	SS_SKTBITS}
	END;

	SSPauseEDCPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		edc:					UInt16;									{	SS_EDC}
	END;

	SSReadEDCPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		edc:					UInt16;									{	SS_EDC}
		value:					UInt16;									{	SS_WORD}
	END;

	SSResetSocketPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		socket:					UInt16;									{	SS_SOCKET}
	END;

	SSResumeEDCPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		edc:					UInt16;									{	SS_EDC}
	END;

	SSStartEDCPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		edc:					UInt16;									{	SS_EDC}
	END;

	SSStopEDCPB = RECORD
		adapter:				UInt16;									{	SS_ADAPTER}
		edc:					UInt16;									{	SS_EDC}
	END;

	SSVendorSpecificPB = RECORD
		vsFunction:				UInt16;									{	SS_WORD}
		adapter:				UInt16;									{	SS_ADAPTER}
		socket:					UInt16;									{	SS_SOCKET}
		bufferSize:				UInt16;									{	SS_WORD}
		buffer:					Ptr;									{	SS_PTR}
		attributes:				UInt32;									{	SS_LONG}
	END;

{	‘attributes’ constants }

CONST
	kSSGoingToSleep				= $00000001;
	kSSWakingFromSleep			= $00000002;

{————————————————————————————————————————————————————————————————————————
	Non-specific Socket Services Functions
————————————————————————————————————————————————————————————————————————}

FUNCTION SSGetAdapterCount(VAR pb: SSGetAdapterCountPB; dataPtr: Ptr): SS_RETCODE;
{————————————————————————————————————————————————————————————————————————
	Adapter Functions
————————————————————————————————————————————————————————————————————————}
FUNCTION SSAcknowledgeInterrupt(VAR pb: SSAcknowledgeInterruptPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSGetSetPriorHandler(VAR pb: SSGetSetPriorHandlerPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSGetSetSSAddr(VAR pb: SSGetSetSSAddrPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSGetAccessOffsets(VAR pb: SSGetAccessOffsetsPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSGetAdapter(VAR pb: SSGetSetAdapterPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSGetSSInfo(VAR pb: SSGetSSInfoPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSGetVendorInfo(VAR pb: SSGetVendorInfoPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSInquireAdapter(VAR pb: SSInquireAdapterPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSSetAdapter(VAR pb: SSGetSetAdapterPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSVendorSpecific(VAR pb: SSVendorSpecificPB; dataPtr: Ptr): SS_RETCODE;
{————————————————————————————————————————————————————————————————————————
	Socket Functions
————————————————————————————————————————————————————————————————————————}
FUNCTION SSGetSocket(VAR pb: SSGetSetSocketPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSGetStatus(VAR pb: SSGetStatusPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSInquireSocket(VAR pb: SSInquireSocketPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSResetSocket(VAR pb: SSResetSocketPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSSetSocket(VAR pb: SSGetSetSocketPB; dataPtr: Ptr): SS_RETCODE;
{————————————————————————————————————————————————————————————————————————
	Window Functions
————————————————————————————————————————————————————————————————————————}
FUNCTION SSGetPage(VAR pb: SSGetSetPagePB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSGetWindow(VAR pb: SSGetSetWindowPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSInquireWindow(VAR pb: SSInquireWindowPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSSetPage(VAR pb: SSGetSetPagePB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSSetWindow(VAR pb: SSGetSetWindowPB; dataPtr: Ptr): SS_RETCODE;
{————————————————————————————————————————————————————————————————————————
	Error Detection Functions
————————————————————————————————————————————————————————————————————————}
FUNCTION SSGetEDC(VAR pb: SSGetSetEDCPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSInquireEDC(VAR pb: SSInquireEDCPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSPauseEDC(VAR pb: SSPauseEDCPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSReadEDC(VAR pb: SSReadEDCPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSResumeEDC(VAR pb: SSResumeEDCPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSSetEDC(VAR pb: SSGetSetEDCPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSStartEDC(VAR pb: SSStartEDCPB; dataPtr: Ptr): SS_RETCODE;
FUNCTION SSStopEDC(VAR pb: SSStopEDCPB; dataPtr: Ptr): SS_RETCODE;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SocketServicesIncludes}

{$ENDC} {__SOCKETSERVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

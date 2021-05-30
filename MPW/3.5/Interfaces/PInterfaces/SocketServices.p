{
     File:       SocketServices.p
 
     Contains:   This file contains constants and data structures that
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc. All rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
  ///////////////////////////////////////////////////////////////////////////////////////
    TypeDefs for the Socket Services function codes
}


TYPE
	SS_BYTE								= Byte;
	SS_FLAGS8							= Byte;
	SS_IRQ								= Byte;
	SS_PWRLEVEL							= Byte;
	SS_ADAPTER							= UInt16;
	SS_BCD								= UInt16;
	SS_COUNT							= UInt16;
	SS_EDC								= UInt16;
	SS_FLAGS16							= UInt16;
	SS_PAGE								= UInt16;
	SS_PWRINDEX							= UInt16;
	SS_SIGNATURE						= UInt16;
	SS_SKTBITS							= UInt16;
	SS_SOCKET							= UInt16;
	SS_SPEED							= UInt16;
	SS_WINDOW							= UInt16;
	SS_WORD								= UInt16;
	SS_BASE								= UInt32;
	SS_FLAGS32							= UInt32;
	SS_OFFSET							= UInt32;
	SS_SIZE								= UInt32;
	SS_PTR								= Ptr;
	SS_RETCODE							= OSErr;
	SS_SCHARTBLPtr = ^SS_SCHARTBL;
	SS_SCHARTBL = RECORD
		sktCaps:				UInt16;									{     SS_FLAGS16 }
		activeHigh:				UInt32;									{     SS_FLAGS32 }
		activeLow:				UInt32;									{     SS_FLAGS32 }
	END;

	SS_SISTRUCTPtr = ^SS_SISTRUCT;
	SS_SISTRUCT = RECORD
		bufferLength:			UInt16;									{     SS_WORD }
		dataLength:				UInt16;									{     SS_WORD }
		charTable:				SS_SCHARTBL;							{     SS_FLAGS16 }
	END;


CONST
	STR_SIZE					= 24;

	{  minimum string length }

TYPE
	SS_VISTRUCTPtr = ^SS_VISTRUCT;
	SS_VISTRUCT = RECORD
		bufferLength:			UInt16;									{     SS_WORD }
		dataLength:				UInt16;									{     SS_WORD }
		szImplementor:			SInt8;									{     SS_WORD }
		padding:				SInt8;									{      }
	END;

	SS_ACHARTBLPtr = ^SS_ACHARTBL;
	SS_ACHARTBL = RECORD
		adpCaps:				UInt16;									{     SS_FLAGS16 }
		activeHigh:				UInt32;									{     SS_FLAGS32 }
		activeLow:				UInt32;									{     SS_FLAGS32 }
	END;

	SS_PWRENTRYPtr = ^SS_PWRENTRY;
	SS_PWRENTRY = RECORD
		powerLevel:				SInt8;									{     SS_PWRLEVEL }
		validSignals:			SInt8;									{     SS_FLAGS8 }
	END;

	SS_AISTRUCTPtr = ^SS_AISTRUCT;
	SS_AISTRUCT = RECORD
		bufferLength:			UInt16;									{     SS_WORD }
		dataLength:				UInt16;									{     SS_WORD }
		charTable:				SS_ACHARTBL;
		numPwrEntries:			UInt16;									{     SS_WORD }
		pwrEntryPtr:			SS_PWRENTRYPtr;
	END;

	SS_MEMWINTBLPtr = ^SS_MEMWINTBL;
	SS_MEMWINTBL = RECORD
		memWndCaps:				UInt16;									{     SS_FLAGS16 }
		firstByte:				UInt32;									{     SS_BASE }
		lastByte:				UInt32;									{     SS_BASE }
		minSize:				UInt32;									{     SS_SIZE }
		maxSize:				UInt32;									{     SS_SIZE }
		reqGran:				UInt32;									{     SS_SIZE }
		reqBase:				UInt32;									{     SS_SIZE }
		reqOffset:				UInt32;									{     SS_SIZE }
		slowest:				UInt16;									{     SS_SPEED }
		fastest:				UInt16;									{     SS_SPEED }
	END;

	SS_IOWINTBLPtr = ^SS_IOWINTBL;
	SS_IOWINTBL = RECORD
		ioWndCaps:				UInt16;									{     SS_FLAGS16 }
		firstByte:				UInt32;									{     SS_BASE }
		lastByte:				UInt32;									{     SS_BASE }
		minSize:				UInt32;									{     SS_SIZE }
		maxSize:				UInt32;									{     SS_SIZE }
		reqGran:				UInt32;									{     SS_SIZE }
		addrLines:				UInt16;									{     SS_COUNT }
		eisaSlot:				SInt8;									{     SS_FLAGS8 }
		padding:				SInt8;									{      }
	END;

	SS_WISTRUCTPtr = ^SS_WISTRUCT;
	SS_WISTRUCT = RECORD
		bufferLength:			UInt16;									{     SS_WORD }
		dataLength:				UInt16;									{     SS_WORD }
		numTblEntries:			UInt16;									{     SS_WORD }
		memWinTbl:				SS_MEMWINTBL;
		ioWinTbl:				SS_IOWINTBL;
	END;


	{	————————————————————————————————————————————————————————————————————————
	    function selectors passed to Socket Service entry point
	————————————————————————————————————————————————————————————————————————	}

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

	{   SSVendorSpecificPB.function values }

	fnVSReserved				= $00;
	fnVSGetSocketLocationIcon	= $01;
	fnVSGetSocketLocationText	= $02;
	fnVSDoSocketLocalization	= $03;
	fnVSAppleSocketCapabilities	= $04;
	fnVSSleepWakeNotification	= $05;


	{	————————————————————————————————————————————————————————————————————————
	    defines for the Socket Services function codes
	————————————————————————————————————————————————————————————————————————	}
	AC_IND						= 1;							{  adapter characteristics }
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

	PWR_VCC						= 128;							{  Power pins in PwrEntry elements }
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

	{	 Vendor Specific Apple Socket Capabilities 	}
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

	SS_SIG_VALUE				= $5353;						{  'SS' }

	SS_CMPL_1_00				= $0100;						{  compliant with rev 1.0 of SS standard }
	SS_CMPL_1_01				= $0101;						{  compliant with rev 1.01 of SS standard }
	SS_CMPL_2_00				= $0200;						{  compliant with rev 2.0 of SS standard }
	SS_CMPL_2_10				= $0210;						{  compliant with rev 2.1 of SS standard }

	{	————————————————————————————————————————————————————————————————————————
	    Universal ProcPtr for Socket Service entry point
	————————————————————————————————————————————————————————————————————————	}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PCCardSSEntryProcPtr = FUNCTION(fnCode: UInt16; callPB: Ptr; dataPtr: Ptr): INTEGER;
{$ELSEC}
	PCCardSSEntryProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	PCCardSSEntryUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PCCardSSEntryUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppPCCardSSEntryProcInfo = $00000FA0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewPCCardSSEntryUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewPCCardSSEntryUPP(userRoutine: PCCardSSEntryProcPtr): PCCardSSEntryUPP; { old name was NewPCCardSSEntryProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposePCCardSSEntryUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePCCardSSEntryUPP(userUPP: PCCardSSEntryUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokePCCardSSEntryUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePCCardSSEntryUPP(fnCode: UInt16; callPB: Ptr; dataPtr: Ptr; userRoutine: PCCardSSEntryUPP): INTEGER; { old name was CallPCCardSSEntryProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{————————————————————————————————————————————————————————————————————————
    Card Services calls used by a Socket Service
————————————————————————————————————————————————————————————————————————}

TYPE
	CSEventEntryPBPtr = ^CSEventEntryPB;
	CSEventEntryPB = RECORD
		ssHandlerID:			UInt32;
		adapter:				UInt16;
		socket:					UInt16;
		message:				UInt16;
		intrpBits:				SInt8;
		padding:				SInt8;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	PCCardCSEntryProcPtr = PROCEDURE(VAR pb: CSEventEntryPB);
{$ELSEC}
	PCCardCSEntryProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	PCCardCSEntryUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PCCardCSEntryUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppPCCardCSEntryProcInfo = $000000C0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewPCCardCSEntryUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewPCCardCSEntryUPP(userRoutine: PCCardCSEntryProcPtr): PCCardCSEntryUPP; { old name was NewPCCardCSEntryProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposePCCardCSEntryUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePCCardCSEntryUPP(userUPP: PCCardCSEntryUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokePCCardCSEntryUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokePCCardCSEntryUPP(VAR pb: CSEventEntryPB; userRoutine: PCCardCSEntryUPP); { old name was CallPCCardCSEntryProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{ ------------      AddSocketServices       ------------                             }


TYPE
	AddSocketServicesPBPtr = ^AddSocketServicesPB;
	AddSocketServicesPB = RECORD
		ssEntry:				PCCardSSEntryUPP;						{  -> given to CS for its use }
		csEntry:				PCCardCSEntryUPP;						{  <- taken from CS so we know where to enter }
		dataPtr:				UInt32;
		attributes:				UInt32;
		numAdapters:			UInt16;
		numSockets:				UInt16;
	END;

	{ ------------      ReplaceSocketServices   ------------                             }

	ReplaceSocketServicesPBPtr = ^ReplaceSocketServicesPB;
	ReplaceSocketServicesPB = RECORD
		ssEntry:				PCCardSSEntryUPP;
		oldSSEntry:				PCCardSSEntryUPP;
		dataPtr:				UInt32;
		socket:					UInt16;
		numSockets:				UInt16;
		attributes:				UInt16;
	END;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  CSAddSocketServices()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION CSAddSocketServices(VAR pb: AddSocketServicesPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7050, $AAF0;
	{$ENDC}

{
 *  CSReplaceSocketServices()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSReplaceSocketServices(VAR pb: ReplaceSocketServicesPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7051, $AAF0;
	{$ENDC}



{————————————————————————————————————————————————————————————————————————
    parameter blocks for each Socket Service function
————————————————————————————————————————————————————————————————————————}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	SSAcknowledgeInterruptPBPtr = ^SSAcknowledgeInterruptPB;
	SSAcknowledgeInterruptPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		sockets:				UInt16;									{     SS_SKTBITS }
	END;

	SSGetAccessOffsetsPBPtr = ^SSGetAccessOffsetsPB;
	SSGetAccessOffsetsPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		mode:					SInt8;									{     SS_BYTE }
		reserved:				SInt8;									{     padding }
		count:					UInt16;									{     SS_COUNT }
		buffer:					Ptr;									{     SS_PTR }
		numAvail:				UInt16;									{     SS_COUNT }
	END;

	SSGetAdapterCountPBPtr = ^SSGetAdapterCountPB;
	SSGetAdapterCountPB = RECORD
		totalAdapters:			UInt16;									{     SS_COUNT }
		sig:					UInt16;									{     SS_SIGNATURE }
	END;

	SSGetSetAdapterPBPtr = ^SSGetSetAdapterPB;
	SSGetSetAdapterPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		state:					SInt8;									{     SS_FLAGS8 }
		irqStatus:				SInt8;									{     SS_IRQ }
	END;

	SSGetSetEDCPBPtr = ^SSGetSetEDCPB;
	SSGetSetEDCPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		edc:					UInt16;									{     SS_EDC }
		socket:					UInt16;									{     SS_SOCKET }
		state:					SInt8;									{     SS_FLAGS8 }
		edcType:				SInt8;									{     SS_FLAGS8 }
	END;

	SSGetSetPagePBPtr = ^SSGetSetPagePB;
	SSGetSetPagePB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		window:					UInt16;									{     SS_WINDOW }
		page:					UInt16;									{     SS_PAGE }
		state:					SInt8;									{     SS_FLAGS8 }
		reserved:				SInt8;									{     padding }
		offset:					UInt32;									{     SS_OFFSET }
	END;

	SSGetSetPriorHandlerPBPtr = ^SSGetSetPriorHandlerPB;
	SSGetSetPriorHandlerPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		mode:					SInt8;									{     SS_FLAGS8 }
		reserved:				SInt8;									{     padding }
		handler:				Ptr;									{     SS_PTR }
	END;

	SSGetSetSocketPBPtr = ^SSGetSetSocketPB;
	SSGetSetSocketPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		socket:					UInt16;									{     SS_SOCKET }
		vccIndex:				UInt16;									{     SS_PWRINDEX }
		vpp1Index:				UInt16;									{     SS_PWRINDEX }
		vpp2Index:				UInt16;									{     SS_PWRINDEX }
		scIntMask:				SInt8;									{     SS_FLAGS8 }
		state:					SInt8;									{     SS_FLAGS8 }
		ctlInd:					SInt8;									{     SS_FLAGS8 }
		ireqRouting:			SInt8;									{     SS_IRQ }
		ifType:					SInt8;									{     SS_FLAGS8 }
		padding:				SInt8;									{      }
	END;

	SSGetSetSSAddrPBPtr = ^SSGetSetSSAddrPB;
	SSGetSetSSAddrPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		mode:					SInt8;									{     SS_BYTE }
		subfunc:				SInt8;									{     SS_BYTE }
		numAddData:				UInt16;									{     SS_COUNT }
		buffer:					Ptr;									{     SS_PTR }
	END;

	SSGetSetWindowPBPtr = ^SSGetSetWindowPB;
	SSGetSetWindowPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		window:					UInt16;									{     SS_WINDOW }
		socket:					UInt16;									{     SS_SOCKET }
		size:					UInt32;									{     SS_SIZE }
		state:					SInt8;									{     SS_FLAGS8 }
		reserved:				SInt8;									{     padding }
		speed:					UInt16;									{     SS_SPEED }
		base:					UInt32;									{     SS_BASE }
	END;

	SSGetSSInfoPBPtr = ^SSGetSSInfoPB;
	SSGetSSInfoPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		compliance:				UInt16;									{     SS_BCD }
		numAdapters:			UInt16;									{     SS_COUNT }
		firstAdapter:			UInt16;									{     SS_ADAPTER }
	END;

	SSGetStatusPBPtr = ^SSGetStatusPB;
	SSGetStatusPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		socket:					UInt16;									{     SS_SOCKET }
		cardState:				SInt8;									{     SS_FLAGS8 }
		socketState:			SInt8;									{     SS_FLAGS8 }
		ctlInd:					SInt8;									{     SS_FLAGS8 }
		ireqRouting:			SInt8;									{     SS_IRQ }
		ifType:					SInt8;									{     SS_FLAGS8 }
		padding:				SInt8;									{      }
	END;

	SSGetVendorInfoPBPtr = ^SSGetVendorInfoPB;
	SSGetVendorInfoPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		vendorInfoType:			SInt8;									{     SS_BYTE }
		reserved:				SInt8;									{     padding }
		buffer:					Ptr;									{     SS_PTR }
		release:				UInt16;									{     SS_BCD }
	END;

	SSInquireAdapterPBPtr = ^SSInquireAdapterPB;
	SSInquireAdapterPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		buffer:					Ptr;									{     SS_PTR }
		numSockets:				UInt16;									{     SS_COUNT }
		numWindows:				UInt16;									{     SS_COUNT }
		numEDCs:				UInt16;									{     SS_COUNT }
	END;

	SSInquireEDCPBPtr = ^SSInquireEDCPB;
	SSInquireEDCPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		edc:					UInt16;									{     SS_EDC }
		sockets:				UInt16;									{     SS_SKTBITS }
		caps:					SInt8;									{     SS_FLAGS8 }
		types:					SInt8;									{     SS_FLAGS8 }
	END;

	SSInquireSocketPBPtr = ^SSInquireSocketPB;
	SSInquireSocketPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		socket:					UInt16;									{     SS_SOCKET }
		buffer:					Ptr;									{     SS_PTR }
		scIntCaps:				SInt8;									{     SS_FLAGS8 }
		scRptCaps:				SInt8;									{     SS_FLAGS8 }
		ctlIndCaps:				SInt8;									{     SS_FLAGS8 }
		padding:				SInt8;									{      }
	END;

	SSInquireWindowPBPtr = ^SSInquireWindowPB;
	SSInquireWindowPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		window:					UInt16;									{     SS_WINDOW }
		buffer:					Ptr;									{     SS_PTR }
		wndCaps:				SInt8;									{     SS_FLAGS8 }
		reserved:				SInt8;									{     padding }
		sockets:				UInt16;									{     SS_SKTBITS }
	END;

	SSPauseEDCPBPtr = ^SSPauseEDCPB;
	SSPauseEDCPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		edc:					UInt16;									{     SS_EDC }
	END;

	SSReadEDCPBPtr = ^SSReadEDCPB;
	SSReadEDCPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		edc:					UInt16;									{     SS_EDC }
		value:					UInt16;									{     SS_WORD }
	END;

	SSResetSocketPBPtr = ^SSResetSocketPB;
	SSResetSocketPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		socket:					UInt16;									{     SS_SOCKET }
	END;

	SSResumeEDCPBPtr = ^SSResumeEDCPB;
	SSResumeEDCPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		edc:					UInt16;									{     SS_EDC }
	END;

	SSStartEDCPBPtr = ^SSStartEDCPB;
	SSStartEDCPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		edc:					UInt16;									{     SS_EDC }
	END;

	SSStopEDCPBPtr = ^SSStopEDCPB;
	SSStopEDCPB = RECORD
		adapter:				UInt16;									{     SS_ADAPTER }
		edc:					UInt16;									{     SS_EDC }
	END;

	SSVendorSpecificPBPtr = ^SSVendorSpecificPB;
	SSVendorSpecificPB = RECORD
		vsFunction:				UInt16;									{     SS_WORD }
		adapter:				UInt16;									{     SS_ADAPTER }
		socket:					UInt16;									{     SS_SOCKET }
		bufferSize:				UInt16;									{     SS_WORD }
		buffer:					Ptr;									{     SS_PTR }
		attributes:				UInt32;									{     SS_LONG }
	END;

	{	  ‘attributes’ constants 	}

CONST
	kSSGoingToSleep				= $00000001;
	kSSWakingFromSleep			= $00000002;

	{	————————————————————————————————————————————————————————————————————————
	    Non-specific Socket Services Functions
	————————————————————————————————————————————————————————————————————————	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  SSGetAdapterCount()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION SSGetAdapterCount(VAR pb: SSGetAdapterCountPB; dataPtr: Ptr): SS_RETCODE;

{————————————————————————————————————————————————————————————————————————
    Adapter Functions
————————————————————————————————————————————————————————————————————————}
{
 *  SSAcknowledgeInterrupt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSAcknowledgeInterrupt(VAR pb: SSAcknowledgeInterruptPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSGetSetPriorHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSGetSetPriorHandler(VAR pb: SSGetSetPriorHandlerPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSGetSetSSAddr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSGetSetSSAddr(VAR pb: SSGetSetSSAddrPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSGetAccessOffsets()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSGetAccessOffsets(VAR pb: SSGetAccessOffsetsPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSGetAdapter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSGetAdapter(VAR pb: SSGetSetAdapterPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSGetSSInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSGetSSInfo(VAR pb: SSGetSSInfoPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSGetVendorInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSGetVendorInfo(VAR pb: SSGetVendorInfoPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSInquireAdapter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSInquireAdapter(VAR pb: SSInquireAdapterPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSSetAdapter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSSetAdapter(VAR pb: SSGetSetAdapterPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSVendorSpecific()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSVendorSpecific(VAR pb: SSVendorSpecificPB; dataPtr: Ptr): SS_RETCODE;

{————————————————————————————————————————————————————————————————————————
    Socket Functions
————————————————————————————————————————————————————————————————————————}
{
 *  SSGetSocket()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSGetSocket(VAR pb: SSGetSetSocketPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSGetStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSGetStatus(VAR pb: SSGetStatusPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSInquireSocket()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSInquireSocket(VAR pb: SSInquireSocketPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSResetSocket()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSResetSocket(VAR pb: SSResetSocketPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSSetSocket()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSSetSocket(VAR pb: SSGetSetSocketPB; dataPtr: Ptr): SS_RETCODE;

{————————————————————————————————————————————————————————————————————————
    Window Functions
————————————————————————————————————————————————————————————————————————}
{
 *  SSGetPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSGetPage(VAR pb: SSGetSetPagePB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSGetWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSGetWindow(VAR pb: SSGetSetWindowPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSInquireWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSInquireWindow(VAR pb: SSInquireWindowPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSSetPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSSetPage(VAR pb: SSGetSetPagePB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSSetWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSSetWindow(VAR pb: SSGetSetWindowPB; dataPtr: Ptr): SS_RETCODE;

{————————————————————————————————————————————————————————————————————————
    Error Detection Functions
————————————————————————————————————————————————————————————————————————}
{
 *  SSGetEDC()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSGetEDC(VAR pb: SSGetSetEDCPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSInquireEDC()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSInquireEDC(VAR pb: SSInquireEDCPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSPauseEDC()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSPauseEDC(VAR pb: SSPauseEDCPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSReadEDC()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSReadEDC(VAR pb: SSReadEDCPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSResumeEDC()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSResumeEDC(VAR pb: SSResumeEDCPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSSetEDC()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSSetEDC(VAR pb: SSGetSetEDCPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSStartEDC()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSStartEDC(VAR pb: SSStartEDCPB; dataPtr: Ptr): SS_RETCODE;

{
 *  SSStopEDC()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SSStopEDC(VAR pb: SSStopEDCPB; dataPtr: Ptr): SS_RETCODE;


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SocketServicesIncludes}

{$ENDC} {__SOCKETSERVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

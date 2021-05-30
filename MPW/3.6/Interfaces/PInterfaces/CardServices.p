{
     File:       CardServices.p
 
     Contains:   The client interface to Card and Socket Services.
 
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
 UNIT CardServices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CARDSERVICES__}
{$SETC __CARDSERVICES__ := 1}

{$I+}
{$SETC CardServicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __PCCARDTUPLES__}
{$I PCCardTuples.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{   miscellaneous }


CONST
	CS_MAX_SOCKETS				= 32;							{  a long is used as a socket bitmap }


	{  Will move to <Traps.h> }
	_PCCardDispatch				= $AAF0;						{  Card Services entry trap }

	{  Will move to <Errors.h> }

	{   result codes }

	kCSBadAdapterErr			= -9050;						{  invalid adapter number }
	kCSBadAttributeErr			= -9051;						{  specified attributes field value is invalid }
	kCSBadBaseErr				= -9052;						{  specified base system memory address is invalid }
	kCSBadEDCErr				= -9053;						{  specified EDC generator specified is invalid }
	kCSBadIRQErr				= -9054;						{  specified IRQ level is invalid }
	kCSBadOffsetErr				= -9055;						{  specified PC card memory array offset is invalid }
	kCSBadPageErr				= -9056;						{  specified page is invalid }
	kCSBadSizeErr				= -9057;						{  specified size is invalid }
	kCSBadSocketErr				= -9058;						{  specified logical or physical socket number is invalid }
	kCSBadTypeErr				= -9059;						{  specified window or interface type is invalid }
	kCSBadVccErr				= -9060;						{  specified Vcc power level index is invalid }
	kCSBadVppErr				= -9061;						{  specified Vpp1 or Vpp2 power level index is invalid }
	kCSBadWindowErr				= -9062;						{  specified window is invalid }
	kCSBadArgLengthErr			= -9063;						{  ArgLength argument is invalid }
	kCSBadArgsErr				= -9064;						{  values in argument packet are invalid }
	kCSBadHandleErr				= -9065;						{  clientHandle is invalid }
	kCSBadCISErr				= -9066;						{  CIS on card is invalid }
	kCSBadSpeedErr				= -9067;						{  specified speed is unavailable }
	kCSReadFailureErr			= -9068;						{  unable to complete read request }
	kCSWriteFailureErr			= -9069;						{  unable to complete write request }
	kCSGeneralFailureErr		= -9070;						{  an undefined error has occurred }
	kCSNoCardErr				= -9071;						{  no PC card in the socket }
	kCSUnsupportedFunctionErr	= -9072;						{  function is not supported by this implementation }
	kCSUnsupportedModeErr		= -9073;						{  mode is not supported }
	kCSBusyErr					= -9074;						{  unable to process request at this time - try later }
	kCSWriteProtectedErr		= -9075;						{  media is write-protected }
	kCSConfigurationLockedErr	= -9076;						{  a configuration has already been locked }
	kCSInUseErr					= -9077;						{  requested resource is being used by a client }
	kCSNoMoreItemsErr			= -9078;						{  there are no more of the requested item }
	kCSOutOfResourceErr			= -9079;						{  Card Services has exhausted the resource }



	{   messages sent to client's event handler }

	kCSNullMessage				= $00;							{  no messages pending (not sent to clients) }
	kCSCardInsertionMessage		= $01;							{  card has been inserted into the socket }
	kCSCardRemovalMessage		= $02;							{  card has been removed from the socket }
	kCSCardLockMessage			= $03;							{  card is locked into the socket with a mechanical latch }
	kCSCardUnlockMessage		= $04;							{  card is no longer locked into the socket }
	kCSCardReadyMessage			= $05;							{  card is ready to be accessed }
	kCSCardResetMessage			= $06;							{  physical reset has completed }
	kCSInsertionRequestMessage	= $07;							{  request to insert a card using insertion motor }
	kCSInsertionCompleteMessage	= $08;							{  insertion motor has finished inserting a card }
	kCSEjectionRequestMessage	= $09;							{  user or other client is requesting a card ejection }
	kCSEjectionFailedMessage	= $0A;							{  eject failure due to electrical/mechanical problems }
	kCSPMResumeMessage			= $0B;							{  power management resume (TBD) }
	kCSPMSuspendMessage			= $0C;							{  power management suspend (TBD) }
	kCSResetPhysicalMessage		= $0D;							{  physical reset is about to occur on this card }
	kCSResetRequestMessage		= $0E;							{  physical reset has been requested by a client }
	kCSResetCompleteMessage		= $0F;							{  ResetCard() background reset has completed }
	kCSBatteryDeadMessage		= $10;							{  battery is no longer useable, data will be lost }
	kCSBatteryLowMessage		= $11;							{  battery is weak and should be replaced }
	kCSWriteProtectMessage		= $12;							{  card is now write protected }
	kCSWriteEnabledMessage		= $13;							{  card is now write enabled }
	kCSClientInfoMessage		= $14;							{  client is to return client information }
	kCSSSUpdatedMessage			= $15;							{  AddSocketServices/ReplaceSocket services has changed SS support }
	kCSFunctionInterruptMessage	= $16;							{  card function interrupt }
	kCSAccessErrorMessage		= $17;							{  client bus errored on access to socket }
	kCSCardUnconfiguredMessage	= $18;							{  a CARD_READY was delivered to all clients and no client  }
																{     requested a configuration for the socket }
	kCSStatusChangedMessage		= $19;							{  status change for cards in I/O mode }

	{	
	    The following is a mapping of the PCMCIA name space to the Macintosh name space.
	    These two enum lists will be removed and given to developers as a separate file.
		}
	SUCCESS						= 0;
	BAD_ADAPTER					= -9050;
	BAD_ATTRIBUTE				= -9051;
	BAD_BASE					= -9052;
	BAD_EDC						= -9053;
	BAD_IRQ						= -9054;
	BAD_OFFSET					= -9055;
	BAD_PAGE					= -9056;
	BAD_SIZE					= -9057;
	BAD_SOCKET					= -9058;
	BAD_TYPE					= -9059;
	BAD_VCC						= -9060;
	BAD_VPP						= -9061;
	BAD_WINDOW					= -9062;
	BAD_ARG_LENGTH				= -9063;
	BAD_ARGS					= -9064;
	BAD_HANDLE					= -9065;
	BAD_CIS						= -9066;
	BAD_SPEED					= -9067;
	READ_FAILURE				= -9068;
	WRITE_FAILURE				= -9069;
	GENERAL_FAILURE				= -9070;
	NO_CARD						= -9071;
	UNSUPPORTED_FUNCTION		= -9072;
	UNSUPPORTED_MODE			= -9073;
	BUSY						= -9074;
	WRITE_PROTECTED				= -9075;
	CONFIGURATION_LOCKED		= -9076;
	IN_USE						= -9077;
	NO_MORE_ITEMS				= -9078;
	OUT_OF_RESOURCE				= -9079;


	{   messages sent to client's event handler }

	NULL_MESSAGE				= $00;
	CARD_INSERTION				= $01;
	CARD_REMOVAL				= $02;
	CARD_LOCK					= $03;
	CARD_UNLOCK					= $04;
	CARD_READY					= $05;
	CARD_RESET					= $06;
	INSERTION_REQUEST			= $07;
	INSERTION_COMPLETE			= $08;
	EJECTION_REQUEST			= $09;
	EJECTION_FAILED				= $0A;
	PM_RESUME					= $0B;
	PM_SUSPEND					= $0C;
	RESET_PHYSICAL				= $0D;
	RESET_REQUEST				= $0E;
	RESET_COMPLETE				= $0F;
	BATTERY_DEAD				= $10;
	BATTERY_LOW					= $11;
	WRITE_PROTECT				= $12;
	WRITE_ENABLED				= $13;
	CLIENT_INFO					= $14;
	SS_UPDATED					= $15;
	FUNCTION_INTERRUPT			= $16;
	ACCESS_ERROR				= $17;
	CARD_UNCONFIGURED			= $18;
	STATUS_CHANGED				= $19;


	{ ----------------      CSAccessConfigurationRegister   ---------------- }


TYPE
	AccessConfigurationRegisterPBPtr = ^AccessConfigurationRegisterPB;
	AccessConfigurationRegisterPB = RECORD
		socket:					UInt16;									{   -> global socket number }
		action:					SInt8;									{   -> read/write }
		offset:					SInt8;									{   -> offset from config register base }
		value:					SInt8;									{  <-> value to read/write }
		padding:				SInt8;									{   }
	END;

	{   ‘action’ field values }


CONST
	kCSReadConfigRegister		= $00;
	kCSWriteConfigRegister		= $01;


	{ ----------------      CSGetCardServicesInfo           ---------------- }


TYPE
	GetCardServicesInfoPBPtr = ^GetCardServicesInfoPB;
	GetCardServicesInfoPB = RECORD
		signature:				PACKED ARRAY [0..1] OF UInt8;			{  <-  two ascii chars 'CS' }
		count:					UInt16;									{  <-  total number of sockets installed }
		revision:				UInt16;									{  <-  BCD }
		csLevel:				UInt16;									{  <-  BCD }
		reserved:				UInt16;									{   -> zero }
		vStrLen:				UInt16;									{  <-> in: client's buffer size, out: vendor string length }
		vendorString:			Ptr;									{  <-> in: pointer to buffer to hold CS vendor string (zero-terminated) }
																		{     out: CS vendor string copied to buffer }
	END;

	{ ----------------      CSGetClientInfo                 ---------------- }


	{  upper byte of attributes is kCSClientInfoSubfunction }
	ClientInfoParamPtr = ^ClientInfoParam;
	ClientInfoParam = RECORD
		clientHandle:			UInt32;									{   -> clientHandle returned by RegisterClient }
		attributes:				UInt16;									{  <-> subfunction + bitmapped client attributes }
		revision:				UInt16;									{  <-  BCD value of client's revision }
		csLevel:				UInt16;									{  <-  BCD value of CS release }
		revDate:				UInt16;									{  <-  revision date: y[15-9], m[8-5], d[4-0] }
		nameLen:				SInt16;									{  <-> in: max length of client name string, out: actual length }
		vStringLen:				SInt16;									{  <-> in: max length of vendor string, out: actual length }
		nameString:				Ptr;									{  <-  pointer to client name string (zero-terminated) }
		vendorString:			Ptr;									{  <-  pointer to vendor string (zero-terminated) }
	END;

	{
	   upper byte of attributes is kCSCardNameSubfunction,
	                               kCSCardTypeSubfunction,
	                               kCSHelpStringSubfunction
	}
	AlternateTextStringParamPtr = ^AlternateTextStringParam;
	AlternateTextStringParam = RECORD
		clientHandle:			UInt32;									{   -> clientHandle returned by RegisterClient }
		attributes:				UInt16;									{  <-> subfunction + bitmapped client attributes }
		socket:					UInt16;									{   -> logical socket number }
		reserved:				UInt16;									{   -> zero }
		length:					SInt16;									{  <-> in: max length of string, out: actual length }
		text:					Ptr;									{  <-  pointer to string (zero-terminated) }
	END;

	{  upper byte of attributes is kCSCardIconSubfunction }
	AlternateCardIconParamPtr = ^AlternateCardIconParam;
	AlternateCardIconParam = RECORD
		clientHandle:			UInt32;									{   -> clientHandle returned by RegisterClient }
		attributes:				UInt16;									{  <-> subfunction + bitmapped client attributes }
		socket:					UInt16;									{   -> logical socket number }
		iconSuite:				Handle;									{  <-  handle to icon suite containing all icons }
	END;

	{  upper byte of attributes is kCSActionProcSubfunction }
	CustomActionProcParamPtr = ^CustomActionProcParam;
	CustomActionProcParam = RECORD
		clientHandle:			UInt32;									{   -> clientHandle returned by RegisterClient }
		attributes:				UInt16;									{  <-> subfunction + bitmapped client attributes }
		socket:					UInt16;									{   -> logical socket number }
	END;

	GetClientInfoPBPtr = ^GetClientInfoPB;
	GetClientInfoPB = RECORD
		CASE INTEGER OF
		0: (
			clientInfo:			ClientInfoParam;
			);
		1: (
			alternateTextString: AlternateTextStringParam;
			);
		2: (
			alternateIcon:		AlternateCardIconParam;
			);
		3: (
			customActionProc:	CustomActionProcParam;
			);
	END;

	{   ‘attributes’ field values }

CONST
	kCSMemoryClient				= $0001;
	kCSIOClient					= $0004;
	kCSClientTypeMask			= $0007;
	kCSShareableCardInsertEvents = $0008;
	kCSExclusiveCardInsertEvents = $0010;
	kCSInfoSubfunctionMask		= $FF00;
	kCSClientInfoSubfunction	= $0000;
	kCSCardNameSubfunction		= $8000;
	kCSCardTypeSubfunction		= $8100;
	kCSHelpStringSubfunction	= $8200;
	kCSCardIconSubfunction		= $8300;
	kCSActionProcSubfunction	= $8400;


	{
	  ----------------      CSGetConfigurationInfo          ----------------
	  ----------------      CSModifyConfiguration           ----------------
	  ----------------      CSRequestConfiguration          ----------------
	}


TYPE
	GetModRequestConfigInfoPBPtr = ^GetModRequestConfigInfoPB;
	GetModRequestConfigInfoPB = RECORD
		clientHandle:			UInt32;									{   -> clientHandle returned by RegisterClient }
		socket:					UInt16;									{   -> logical socket number }
		attributes:				UInt16;									{  <-> bitmap of configuration attributes }
		vcc:					SInt8;									{  <-> Vcc setting }
		vpp1:					SInt8;									{  <-> Vpp1 setting }
		vpp2:					SInt8;									{  <-> Vpp2 setting }
		intType:				SInt8;									{  <-> interface type (memory or memory+I/O) }
		configBase:				UInt32;									{  <-> card base address of configuration registers }
		status:					SInt8;									{  <-> card status register setting, if present }
		pin:					SInt8;									{  <-> card pin register setting, if present }
		copy:					SInt8;									{  <-> card socket/copy register setting, if present }
		configIndex:			SInt8;									{  <-> card option register setting, if present }
		present:				SInt8;									{  <-> bitmap of which configuration registers are present }
		firstDevType:			SInt8;									{  <-  from DeviceID tuple }
		funcCode:				SInt8;									{  <-  from FuncID tuple }
		sysInitMask:			SInt8;									{  <-  from FuncID tuple }
		manufCode:				UInt16;									{  <-  from ManufacturerID tuple }
		manufInfo:				UInt16;									{  <-  from ManufacturerID tuple }
		cardValues:				SInt8;									{  <-  valid card register values }
		padding:				SInt8;									{   }
	END;

	{   ‘attributes’ field values }

CONST
	kCSExclusivelyUsed			= $0001;
	kCSEnableIREQs				= $0002;
	kCSVccChangeValid			= $0004;
	kCSVpp1ChangeValid			= $0008;
	kCSVpp2ChangeValid			= $0010;
	kCSValidClient				= $0020;
	kCSSleepPower				= $0040;						{  request that power be applied to socket during Sleep }
	kCSLockSocket				= $0080;
	kCSTurnOnInUse				= $0100;

	{   ‘intType’ field values }

	kCSMemoryInterface			= $01;
	kCSMemory_And_IO_Interface	= $02;

	{   ‘present’ field values }

	kCSOptionRegisterPresent	= $01;
	kCSStatusRegisterPresent	= $02;
	kCSPinReplacementRegisterPresent = $04;
	kCSCopyRegisterPresent		= $08;

	{   ‘cardValues’ field values }

	kCSOptionValueValid			= $01;
	kCSStatusValueValid			= $02;
	kCSPinReplacementValueValid	= $04;
	kCSCopyValueValid			= $08;


	{
	  ----------------      CSGetClientEventMask            ----------------
	  ----------------      CSSetClientEventMask            ----------------
	}


TYPE
	GetSetClientEventMaskPBPtr = ^GetSetClientEventMaskPB;
	GetSetClientEventMaskPB = RECORD
		clientHandle:			UInt32;									{   -> clientHandle returned by RegisterClient }
		attributes:				UInt16;									{  <-> bitmap of attributes }
		eventMask:				UInt16;									{  <-> bitmap of events to be passed to client for this socket }
		socket:					UInt16;									{   -> logical socket number }
	END;

	{   ‘attributes’ field values }

CONST
	kCSEventMaskThisSocketOnly	= $0001;

	{   ‘eventMask’ field values }

	kCSWriteProtectEvent		= $0001;
	kCSCardLockChangeEvent		= $0002;
	kCSEjectRequestEvent		= $0004;
	kCSInsertRequestEvent		= $0008;
	kCSBatteryDeadEvent			= $0010;
	kCSBatteryLowEvent			= $0020;
	kCSReadyChangeEvent			= $0040;
	kCSCardDetectChangeEvent	= $0080;
	kCSPMChangeEvent			= $0100;
	kCSResetEvent				= $0200;
	kCSSSUpdateEvent			= $0400;
	kCSFunctionInterrupt		= $0800;
	kCSAllEvents				= $FFFF;


	{
	  ----------------      CSGetFirstClient                ----------------
	  ----------------      CSGetNextClient                 ----------------
	}


TYPE
	GetClientPBPtr = ^GetClientPB;
	GetClientPB = RECORD
		clientHandle:			UInt32;									{  <-  clientHandle for this client }
		socket:					UInt16;									{   -> logical socket number }
		attributes:				UInt16;									{   -> bitmap of attributes }
	END;

	{   ‘attributes’ field values }

CONST
	kCSClientsForAllSockets		= $0000;
	kCSClientsThisSocketOnly	= $0001;


	{
	  ----------------      CSGetFirstTuple                 ----------------
	  ----------------      CSGetNextTuple                  ----------------
	  ----------------      CSGetTupleData                  ----------------
	}


TYPE
	GetTuplePBPtr = ^GetTuplePB;
	GetTuplePB = RECORD
		socket:					UInt16;									{   -> logical socket number }
		attributes:				UInt16;									{   -> bitmap of attributes }
		desiredTuple:			SInt8;									{   -> desired tuple code value, or $FF for all }
		tupleOffset:			SInt8;									{   -> offset into tuple from link byte }
		flags:					UInt16;									{  <-> internal use }
		linkOffset:				UInt32;									{  <-> internal use }
		cisOffset:				UInt32;									{  <-> internal use }
		CASE INTEGER OF
		0: (
			tupleCode:			SInt8;									{  <-  tuple code found }
			tupleLink:			SInt8;									{  <-  link value for tuple found }
		   );
		1: (
			tupleDataMax:		UInt16;									{   -> maximum size of tuple data area }
			tupleDataLen:		UInt16;									{  <-  number of bytes in tuple body }
			tupleData:			TupleBody;								{  <-  tuple data }
		   );
	END;

	{   ‘attributes’ field values }

CONST
	kCSReturnLinkTuples			= $0001;


	{
	  ----------------      CSRequestSocketMask             ----------------
	  ----------------      CSReleaseSocketMask             ----------------
	}


TYPE
	ReqRelSocketMaskPBPtr = ^ReqRelSocketMaskPB;
	ReqRelSocketMaskPB = RECORD
		clientHandle:			UInt32;									{   -> clientHandle returned by RegisterClient }
		socket:					UInt16;									{   -> logical socket }
		eventMask:				UInt16;									{   -> bitmap of events to be passed to client for this socket }
	END;

	{   ‘eventMask’ field values (see above for Get/SetClientEventMask }

	{ ----------------      CSGetStatus                     ---------------- }

	GetStatusPBPtr = ^GetStatusPB;
	GetStatusPB = RECORD
		socket:					UInt16;									{   -> logical socket number }
		cardState:				UInt16;									{  <-  current state of installed card }
		socketState:			UInt16;									{  <-  current state of the socket }
	END;

	{   ‘cardState’ field values }

CONST
	kCSWriteProtected			= $0001;
	kCSCardLocked				= $0002;
	kCSEjectRequest				= $0004;
	kCSInsertRequest			= $0008;
	kCSBatteryDead				= $0010;
	kCSBatteryLow				= $0020;
	kCSReady					= $0040;
	kCSCardDetected				= $0080;

	{   ‘socketState’ field values }

	kCSWriteProtectChanged		= $0001;
	kCSCardLockChanged			= $0002;
	kCSEjectRequestPending		= $0004;
	kCSInsertRequestPending		= $0008;
	kCSBatteryDeadChanged		= $0010;
	kCSBatteryLowChanged		= $0020;
	kCSReadyChanged				= $0040;
	kCSCardDetectChanged		= $0080;


	{
	  ----------------      CSModifyWindow                  ----------------
	  ----------------      CSReleaseWindow                 ----------------
	  ----------------      CSRequestWindow                 ----------------
	}


TYPE
	ReqModRelWindowPBPtr = ^ReqModRelWindowPB;
	ReqModRelWindowPB = RECORD
		clientHandle:			UInt32;									{   -> clientHandle returned by RegisterClient }
		windowHandle:			UInt32;									{  <-> window descriptor }
		socket:					UInt16;									{   -> logical socket number }
		attributes:				UInt16;									{   -> window attributes (bitmap) }
		base:					UInt32;									{  <-> system base address }
		size:					UInt32;									{  <-> memory window size }
		accessSpeed:			SInt8;									{   -> window access speed (bitmap) }
																		{        (not applicable for I/O mode) }
		padding:				SInt8;									{   }
	END;

	{   ‘attributes’ field values }

CONST
	kCSMemoryWindow				= $0001;
	kCSIOWindow					= $0002;
	kCSAttributeWindow			= $0004;						{  not normally used by Card Services clients }
	kCSWindowTypeMask			= $0007;
	kCSEnableWindow				= $0008;
	kCSAccessSpeedValid			= $0010;
	kCSLittleEndian				= $0020;						{  configure socket for little endianess }
	kCS16BitDataPath			= $0040;
	kCSWindowPaged				= $0080;						{   }
	kCSWindowShared				= $0100;
	kCSWindowFirstShared		= $0200;						{   }
	kCSWindowProgrammable		= $0400;						{   }

	{   ‘accessSpeed’ field values }

	kCSDeviceSpeedCodeMask		= $07;
	kCSSpeedExponentMask		= $07;
	kCSSpeedMantissaMask		= $78;
	kCSUseWait					= $80;
	kCSAccessSpeed250nsec		= $01;
	kCSAccessSpeed200nsec		= $02;
	kCSAccessSpeed150nsec		= $03;
	kCSAccessSpeed100nsec		= $04;
	kCSExtAccSpeedMant1pt0		= $01;
	kCSExtAccSpeedMant1pt2		= $02;
	kCSExtAccSpeedMant1pt3		= $03;
	kCSExtAccSpeedMant1pt5		= $04;
	kCSExtAccSpeedMant2pt0		= $05;
	kCSExtAccSpeedMant2pt5		= $06;
	kCSExtAccSpeedMant3pt0		= $07;
	kCSExtAccSpeedMant3pt5		= $08;
	kCSExtAccSpeedMant4pt0		= $09;
	kCSExtAccSpeedMant4pt5		= $0A;
	kCSExtAccSpeedMant5pt0		= $0B;
	kCSExtAccSpeedMant5pt5		= $0C;
	kCSExtAccSpeedMant6pt0		= $0D;
	kCSExtAccSpeedMant7pt0		= $0E;
	kCSExtAccSpeedMant8pt0		= $0F;
	kCSExtAccSpeedExp1ns		= $00;
	kCSExtAccSpeedExp10ns		= $01;
	kCSExtAccSpeedExp100ns		= $02;
	kCSExtAccSpeedExp1us		= $03;
	kCSExtAccSpeedExp10us		= $04;
	kCSExtAccSpeedExp100us		= $05;
	kCSExtAccSpeedExp1ms		= $06;
	kCSExtAccSpeedExp10ms		= $07;


	{
	  ----------------      CSRegisterClient                ----------------
	  ----------------      CSDeregisterClient              ----------------
	}


TYPE
	ClientCallbackPBPtr = ^ClientCallbackPB;
	ClientCallbackPB = RECORD
		message:				UInt16;									{   -> which event this is }
		socket:					UInt16;									{   -> logical socket number }
		info:					UInt16;									{   -> function-specific }
		misc:					UInt16;									{   -> function-specific }
		reserved:				Ptr;									{   -> pointer to MTD request block }
		buffer:					Ptr;									{   -> function-specific }
		clientData:				Ptr;									{   -> pointer to client's data (from RegisterClient) }
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	PCCardCSClientProcPtr = FUNCTION(ccPBPtr: ClientCallbackPBPtr): UInt16;
{$ELSEC}
	PCCardCSClientProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	PCCardCSClientUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PCCardCSClientUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppPCCardCSClientProcInfo = $000000E0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewPCCardCSClientUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewPCCardCSClientUPP(userRoutine: PCCardCSClientProcPtr): PCCardCSClientUPP; { old name was NewPCCardCSClientProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposePCCardCSClientUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePCCardCSClientUPP(userUPP: PCCardCSClientUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokePCCardCSClientUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePCCardCSClientUPP(ccPBPtr: ClientCallbackPBPtr; userRoutine: PCCardCSClientUPP): UInt16; { old name was CallPCCardCSClientProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	RegisterClientPBPtr = ^RegisterClientPB;
	RegisterClientPB = RECORD
		clientHandle:			UInt32;									{  <-  client descriptor }
		clientEntry:			PCCardCSClientUPP;						{   -> universal procPtr to client's event handler }
		attributes:				UInt16;									{   -> bitmap of client attributes }
		eventMask:				UInt16;									{   -> bitmap of events to notify client }
		clientData:				Ptr;									{   -> pointer to client's data }
		version:				UInt16;									{   -> Card Services version this client expects }
	END;

	{   ‘attributes’ field values (see GetClientInfo) }
	{
	    kCSMemoryClient                 = 0x0001,
	    kCSIOClient                     = 0x0004,
	    kCSShareableCardInsertEvents    = 0x0008,
	    kCSExclusiveCardInsertEvents    = 0x0010
	}


	{ ----------------      CSReleaseConfiguration          ---------------- }

	ReleaseConfigurationPBPtr = ^ReleaseConfigurationPB;
	ReleaseConfigurationPB = RECORD
		clientHandle:			UInt32;									{   -> clientHandle returned by RegisterClient }
		socket:					UInt16;									{   ->  }
	END;

	{ ----------------      CSResetCard                     ---------------- }

	ResetCardPBPtr = ^ResetCardPB;
	ResetCardPB = RECORD
		clientHandle:			UInt32;									{   -> clientHandle returned by RegisterClient }
		socket:					UInt16;									{   ->  }
		attributes:				UInt16;									{   -> xxx }
	END;

	{ ----------------      CSValidateCIS                   ---------------- }

	ValidateCISPBPtr = ^ValidateCISPB;
	ValidateCISPB = RECORD
		socket:					UInt16;									{   ->  }
		chains:					UInt16;									{   -> whether link/null tuples should be included }
	END;

	{
	  ----------------      CSRequestIO                     ----------------
	  ----------------      CSReleaseIO                     ----------------
	}

	ReqRelIOPBPtr = ^ReqRelIOPB;
	ReqRelIOPB = RECORD
		clientHandle:			UInt32;									{   -> clientHandle returned by RegisterClient }
		socket:					UInt16;									{   -> socket number }
		reserved:				UInt16;
		basePort1:				UInt16;									{     -> base I/O port for range }
		numPorts1:				SInt8;									{     -> number of ports (e.g., bytes). }
		attributes1:			SInt8;									{     -> attributes }
		basePort2:				UInt16;									{     -> base I/O port for range }
		numPorts2:				SInt8;									{     -> number of ports }
		attributes2:			SInt8;									{     -> attributes }
		ioAddrLines:			SInt8;									{     -> number of I/O lines decoded by card }
		reserved1:				SInt8;
	END;

	{ ----------------      CSVendorSpecific                ---------------- }
	VendorSpecificPBPtr = ^VendorSpecificPB;
	VendorSpecificPB = RECORD
		clientHandle:			UInt32;									{   -> clientHandle returned by RegisterClient }
		vsCode:					UInt16;
		socket:					UInt16;
		dataLen:				UInt32;									{   -> length of buffer pointed to by vsDataPtr }
		vsDataPtr:				Ptr;									{   -> Card Services version this client expects }
	END;

	{   ‘vsCode’ field values }


CONST
	vsAppleReserved				= $0000;
	vsEjectCard					= $0001;
	vsGetCardInfo				= $0002;
	vsEnableSocketEvents		= $0003;
	vsGetCardLocationIcon		= $0004;
	vsGetCardLocationText		= $0005;
	vsGetAdapterInfo			= $0006;

	{
	  ///////////////////////////////////////////////////////////////////////////////////////
	    GetAdapterInfo parameter block (vendor-specific call #6)
	}


TYPE
	GetAdapterInfoPBPtr = ^GetAdapterInfoPB;
	GetAdapterInfoPB = RECORD
		attributes:				UInt32;									{  <-  capabilties of socket's adapter }
		revision:				UInt16;									{  <-  id of adapter }
		reserved:				UInt16;									{   }
		numVoltEntries:			UInt16;									{  <-  number of valid voltage values }
		voltages:				Ptr;									{  <-> array of BCD voltage values }
	END;

	{   ‘attributes’ field values }

CONST
	kCSLevelModeInterrupts		= $00000001;
	kCSPulseModeInterrupts		= $00000002;
	kCSProgrammableWindowAddr	= $00000004;
	kCSProgrammableWindowSize	= $00000008;
	kCSSocketSleepPower			= $00000010;
	kCSSoftwareEject			= $00000020;
	kCSLockableSocket			= $00000040;
	kCSInUseIndicator			= $00000080;

	{
	  ///////////////////////////////////////////////////////////////////////////////////////
	    GetCardInfo parameter block (vendor-specific call #2)
	}


TYPE
	GetCardInfoPBPtr = ^GetCardInfoPB;
	GetCardInfoPB = RECORD
		cardType:				SInt8;									{  <-  type of card in this socket (defined at top of file) }
		subType:				SInt8;									{  <-  more detailed card type (defined at top of file) }
		reserved:				UInt16;									{  <-> reserved (should be set to zero) }
		cardNameLen:			UInt16;									{   -> maximum length of card name to be returned }
		vendorNameLen:			UInt16;									{   -> maximum length of vendor name to be returned }
		cardName:				Ptr;									{   -> pointer to card name string (read from CIS), or nil }
		vendorName:				Ptr;									{   -> pointer to vendor name string (read from CIS), or nil }
	END;

	{   GetCardInfo card types }

CONST
	kCSUnknownCardType			= 0;
	kCSMultiFunctionCardType	= 1;
	kCSMemoryCardType			= 2;
	kCSSerialPortCardType		= 3;
	kCSSerialOnlyType			= 0;
	kCSDataModemType			= 1;
	kCSFaxModemType				= 2;
	kCSFaxAndDataModemMask		= 3;
	kCSVoiceEncodingType		= 4;
	kCSParallelPortCardType		= 4;
	kCSFixedDiskCardType		= 5;
	kCSUnknownFixedDiskType		= 0;
	kCSATAInterface				= 1;
	kCSRotatingDevice			= $00;
	kCSSiliconDevice			= $80;
	kCSVideoAdaptorCardType		= 6;
	kCSNetworkAdaptorCardType	= 7;
	kCSAIMSCardType				= 8;
	kCSNumCardTypes				= 9;


{$IFC UNDEFINED __PCCARDENABLERPLUGIN__ }
	{	
	    NOTE: These prototypes conflict with PCCardEnablerPlugin.≈
	          You cannot use both PCCardEnablerPlugin.h and CardServices.h
	          
		}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  CSVendorSpecific()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION CSVendorSpecific(VAR pb: VendorSpecificPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $AAF0;
	{$ENDC}

{
 *  CSRegisterClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSRegisterClient(VAR pb: RegisterClientPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AAF0;
	{$ENDC}

{
 *  CSDeregisterClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSDeregisterClient(VAR pb: RegisterClientPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AAF0;
	{$ENDC}

{
 *  CSGetFirstTuple()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetFirstTuple(VAR pb: GetTuplePB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AAF0;
	{$ENDC}

{
 *  CSGetNextTuple()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetNextTuple(VAR pb: GetTuplePB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $AAF0;
	{$ENDC}

{
 *  CSGetTupleData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetTupleData(VAR pb: GetTuplePB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $AAF0;
	{$ENDC}

{
 *  CSGetConfigurationInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetConfigurationInfo(VAR pb: GetModRequestConfigInfoPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $AAF0;
	{$ENDC}

{
 *  CSGetCardServicesInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetCardServicesInfo(VAR pb: GetCardServicesInfoPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $AAF0;
	{$ENDC}

{
 *  CSGetStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetStatus(VAR pb: GetStatusPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $AAF0;
	{$ENDC}

{
 *  CSValidateCIS()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSValidateCIS(VAR pb: ValidateCISPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $AAF0;
	{$ENDC}

{
 *  CSGetFirstClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetFirstClient(VAR pb: GetClientPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $AAF0;
	{$ENDC}

{
 *  CSGetNextClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetNextClient(VAR pb: GetClientPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $AAF0;
	{$ENDC}

{
 *  CSGetClientInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetClientInfo(VAR pb: GetClientInfoPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $AAF0;
	{$ENDC}

{
 *  CSResetCard()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSResetCard(VAR pb: ResetCardPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $AAF0;
	{$ENDC}

{
 *  CSRequestWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSRequestWindow(VAR pb: ReqModRelWindowPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7013, $AAF0;
	{$ENDC}

{
 *  CSModifyWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSModifyWindow(VAR pb: ReqModRelWindowPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $AAF0;
	{$ENDC}

{
 *  CSReleaseWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSReleaseWindow(VAR pb: ReqModRelWindowPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $AAF0;
	{$ENDC}

{
 *  CSRequestConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSRequestConfiguration(VAR pb: GetModRequestConfigInfoPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701B, $AAF0;
	{$ENDC}

{
 *  CSModifyConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSModifyConfiguration(VAR pb: GetModRequestConfigInfoPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701C, $AAF0;
	{$ENDC}

{
 *  CSAccessConfigurationRegister()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSAccessConfigurationRegister(VAR pb: AccessConfigurationRegisterPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701D, $AAF0;
	{$ENDC}

{
 *  CSReleaseConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSReleaseConfiguration(VAR pb: ReleaseConfigurationPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701E, $AAF0;
	{$ENDC}

{
 *  CSGetClientEventMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetClientEventMask(VAR pb: GetSetClientEventMaskPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701F, $AAF0;
	{$ENDC}

{
 *  CSSetClientEventMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSSetClientEventMask(VAR pb: GetSetClientEventMaskPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7020, $AAF0;
	{$ENDC}

{
 *  CSRequestSocketMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSRequestSocketMask(VAR pb: ReqRelSocketMaskPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7021, $AAF0;
	{$ENDC}

{
 *  CSReleaseSocketMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSReleaseSocketMask(VAR pb: ReqRelSocketMaskPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7022, $AAF0;
	{$ENDC}


{
    Additional calls which are required for all I/O clients when running on
    systems which do not reserve dedicated I/O-spaces for each PC Card.
}

{
 *  CSRequestIO()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSRequestIO(VAR pb: ReqRelIOPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7025, $AAF0;
	{$ENDC}

{
 *  CSReleaseIO()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCardLib 1.0 thru 2.0
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSReleaseIO(VAR pb: ReqRelIOPB): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7026, $AAF0;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CardServicesIncludes}

{$ENDC} {__CARDSERVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

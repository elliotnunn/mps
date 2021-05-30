{
 	File:		CardServices.p
 
	Contains:	This file contains constants and data structures that describe
				the client interface to Card and Socket Services.

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
 UNIT CardServices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CARDSERVICES__}
{$SETC __CARDSERVICES__ := 1}

{$I+}
{$SETC CardServicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __PCCARDTUPLES__}
{$I PCCardTuples.p}
{$ENDC}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	CS_MAX_SOCKETS				= 32;							{ a long is used as a socket bitmap}

{ ••• Should eventually move to <Gestalt.h>}
	gestaltCardServicesAttr		= 'pccd';						{ Card Services attributes}
	gestaltCardServicesPresent	= 0;							{ if set, Card Services is present}

{ ••• Should eventually move to <Traps.h>}
	_PCCardDispatch				= $AAF0;						{ Card Services entry trap}

{ 
	The PC Card Manager will migrate towards a complete Mac name space very soon.
	Part of that process will be to reassign result codes to a range reserved for
	the PC Card Manager...the range will be...-9050 to -9305 (decimal inclusive).
}
{	result codes}
	kCSBadAdapterErr			= -9050;						{ invalid adapter number}
	kCSBadAttributeErr			= -9051;						{ specified attributes field value is invalid}
	kCSBadBaseErr				= -9052;						{ specified base system memory address is invalid}
	kCSBadEDCErr				= -9053;						{ specified EDC generator specified is invalid}
	kCSBadIRQErr				= -9054;						{ specified IRQ level is invalid}
	kCSBadOffsetErr				= -9055;						{ specified PC card memory array offset is invalid}
	kCSBadPageErr				= -9056;						{ specified page is invalid}
	kCSBadSizeErr				= -9057;						{ specified size is invalid}
	kCSBadSocketErr				= -9058;						{ specified logical or physical socket number is invalid}
	kCSBadTypeErr				= -9059;						{ specified window or interface type is invalid}
	kCSBadVccErr				= -9060;						{ specified Vcc power level index is invalid}
	kCSBadVppErr				= -9061;						{ specified Vpp1 or Vpp2 power level index is invalid}
	kCSBadWindowErr				= -9062;						{ specified window is invalid}
	kCSBadArgLengthErr			= -9063;						{ ArgLength argument is invalid}
	kCSBadArgsErr				= -9064;						{ values in argument packet are invalid}
	kCSBadHandleErr				= -9065;						{ clientHandle is invalid}
	kCSBadCISErr				= -9066;						{ CIS on card is invalid}
	kCSBadSpeedErr				= -9067;						{ specified speed is unavailable}
	kCSReadFailureErr			= -9068;						{ unable to complete read request}
	kCSWriteFailureErr			= -9069;						{ unable to complete write request}
	kCSGeneralFailureErr		= -9070;						{ an undefined error has occurred}
	kCSNoCardErr				= -9071;						{ no PC card in the socket}
	kCSUnsupportedFunctionErr	= -9072;						{ function is not supported by this implementation}
	kCSUnsupportedModeErr		= -9073;						{ mode is not supported}
	kCSBusyErr					= -9074;						{ unable to process request at this time - try later}
	kCSWriteProtectedErr		= -9075;						{ media is write-protected}
	kCSConfigurationLockedErr	= -9076;						{ a configuration has already been locked}
	kCSInUseErr					= -9077;						{ requested resource is being used by a client}
	kCSNoMoreItemsErr			= -9078;						{ there are no more of the requested item}
	kCSOutOfResourceErr			= -9079;						{ Card Services has exhausted the resource}

{	messages sent to client's event handler}
	kCSNullMessage				= $00;							{ no messages pending (not sent to clients)}
	kCSCardInsertionMessage		= $01;							{ card has been inserted into the socket}
	kCSCardRemovalMessage		= $02;							{ card has been removed from the socket}
	kCSCardLockMessage			= $03;							{ card is locked into the socket with a mechanical latch}
	kCSCardUnlockMessage		= $04;							{ card is no longer locked into the socket}
	kCSCardReadyMessage			= $05;							{ card is ready to be accessed}
	kCSCardResetMessage			= $06;							{ physical reset has completed}
	kCSInsertionRequestMessage	= $07;							{ request to insert a card using insertion motor}
	kCSInsertionCompleteMessage	= $08;							{ insertion motor has finished inserting a card}
	kCSEjectionRequestMessage	= $09;							{ user or other client is requesting a card ejection}
	kCSEjectionFailedMessage	= $0A;							{ eject failure due to electrical/mechanical problems}
	kCSPMResumeMessage			= $0B;							{ power management resume (TBD)}
	kCSPMSuspendMessage			= $0C;							{ power management suspend (TBD)}
	kCSResetPhysicalMessage		= $0D;							{ physical reset is about to occur on this card}
	kCSResetRequestMessage		= $0E;							{ physical reset has been requested by a client}
	kCSResetCompleteMessage		= $0F;							{ ResetCard() background reset has completed}
	kCSBatteryDeadMessage		= $10;							{ battery is no longer useable, data will be lost}
	kCSBatteryLowMessage		= $11;							{ battery is weak and should be replaced}
	kCSWriteProtectMessage		= $12;							{ card is now write protected}
	kCSWriteEnabledMessage		= $13;							{ card is now write enabled}
	kCSClientInfoMessage		= $14;							{ client is to return client information}
	kCSSSUpdatedMessage			= $15;							{ AddSocketServices/ReplaceSocket services has changed SS support}
	kCSFunctionInterruptMessage	= $16;							{ card function interrupt}
	kCSAccessErrorMessage		= $17;							{ client bus errored on access to socket}
	kCSCardUnconfiguredMessage	= $18;							{ a CARD_READY was delivered to all clients and no client }
{	requested a configuration for the socket}
	kCSStatusChangedMessage		= $19;							{ status change for cards in I/O mode}

{
	The following is a mapping of the PCMCIA name space to the Macintosh name space.
	These two enum lists will be removed and given to developers as a separate file.
}
	SUCCESS						= noErr;
	BAD_ADAPTER					= kCSBadAdapterErr;
	BAD_ATTRIBUTE				= kCSBadAttributeErr;
	BAD_BASE					= kCSBadBaseErr;
	BAD_EDC						= kCSBadEDCErr;
	BAD_IRQ						= kCSBadIRQErr;
	BAD_OFFSET					= kCSBadOffsetErr;
	BAD_PAGE					= kCSBadPageErr;
	BAD_SIZE					= kCSBadSizeErr;
	BAD_SOCKET					= kCSBadSocketErr;
	BAD_TYPE					= kCSBadTypeErr;
	BAD_VCC						= kCSBadVccErr;
	BAD_VPP						= kCSBadVppErr;
	BAD_WINDOW					= kCSBadWindowErr;
	BAD_ARG_LENGTH				= kCSBadArgLengthErr;
	BAD_ARGS					= kCSBadArgsErr;
	BAD_HANDLE					= kCSBadHandleErr;
	BAD_CIS						= kCSBadCISErr;
	BAD_SPEED					= kCSBadSpeedErr;
	READ_FAILURE				= kCSReadFailureErr;
	WRITE_FAILURE				= kCSWriteFailureErr;
	GENERAL_FAILURE				= kCSGeneralFailureErr;
	NO_CARD						= kCSNoCardErr;
	UNSUPPORTED_FUNCTION		= kCSUnsupportedFunctionErr;
	UNSUPPORTED_MODE			= kCSUnsupportedModeErr;
	BUSY						= kCSBusyErr;
	WRITE_PROTECTED				= kCSWriteProtectedErr;
	CONFIGURATION_LOCKED		= kCSConfigurationLockedErr;
	IN_USE						= kCSInUseErr;
	NO_MORE_ITEMS				= kCSNoMoreItemsErr;
	OUT_OF_RESOURCE				= kCSOutOfResourceErr;

{	messages sent to client's event handler}
	NULL_MESSAGE				= kCSNullMessage;
	CARD_INSERTION				= kCSCardInsertionMessage;
	CARD_REMOVAL				= kCSCardRemovalMessage;
	CARD_LOCK					= kCSCardLockMessage;
	CARD_UNLOCK					= kCSCardUnlockMessage;
	CARD_READY					= kCSCardReadyMessage;
	CARD_RESET					= kCSCardResetMessage;
	INSERTION_REQUEST			= kCSInsertionRequestMessage;
	INSERTION_COMPLETE			= kCSInsertionCompleteMessage;
	EJECTION_REQUEST			= kCSEjectionRequestMessage;
	EJECTION_FAILED				= kCSEjectionFailedMessage;
	PM_RESUME					= kCSPMResumeMessage;
	PM_SUSPEND					= kCSPMSuspendMessage;
	RESET_PHYSICAL				= kCSResetPhysicalMessage;
	RESET_REQUEST				= kCSResetRequestMessage;
	RESET_COMPLETE				= kCSResetCompleteMessage;
	BATTERY_DEAD				= kCSBatteryDeadMessage;
	BATTERY_LOW					= kCSBatteryLowMessage;
	WRITE_PROTECT				= kCSWriteProtectMessage;
	WRITE_ENABLED				= kCSWriteEnabledMessage;
	CLIENT_INFO					= kCSClientInfoMessage;
	SS_UPDATED					= kCSSSUpdatedMessage;
	FUNCTION_INTERRUPT			= kCSFunctionInterruptMessage;
	ACCESS_ERROR				= kCSAccessErrorMessage;
	CARD_UNCONFIGURED			= kCSCardUnconfiguredMessage;
	STATUS_CHANGED				= kCSStatusChangedMessage;

{----------------		CSAccessConfigurationRegister	----------------}

TYPE
	AccessConfigurationRegisterPB = RECORD
		socket:					UInt16;									{  -> global socket number}
		action:					SInt8; (* UInt8 *)						{  -> read/write}
		offset:					SInt8; (* UInt8 *)						{  -> offset from config register base}
		value:					SInt8; (* UInt8 *)						{ <-> value to read/write}
		padding:				ARRAY [0..0] OF SInt8; (* UInt8 *)		{ }
	END;

{	‘action’ field values}

CONST
	kCSReadConfigRegister		= $00;
	kCSWriteConfigRegister		= $01;

{----------------		CSGetCardServicesInfo			----------------}

TYPE
	GetCardServicesInfoPB = RECORD
		signature:				ARRAY [0..1] OF SInt8; (* UInt8 *)		{ <-  two ascii chars 'CS'}
		count:					UInt16;									{ <-  total number of sockets installed}
		revision:				UInt16;									{ <-  BCD}
		csLevel:				UInt16;									{ <-  BCD}
		reserved:				UInt16;									{  -> zero}
		vStrLen:				UInt16;									{ <-> in: client's buffer size, out: vendor string length}
		vendorString:			^UInt8;									{ <-> in: pointer to buffer to hold CS vendor string (zero-terminated)}
		{  	out: CS vendor string copied to buffer}
	END;

{----------------		CSGetClientInfo					----------------}
	ClientInfoParam = RECORD
		clientHandle:			UInt32;									{  -> clientHandle returned by RegisterClient}
		attributes:				UInt16;									{ <-> subfunction + bitmapped client attributes}
		revision:				UInt16;									{ <-  BCD value of client's revision}
		csLevel:				UInt16;									{ <-  BCD value of CS release}
		revDate:				UInt16;									{ <-  revision date: y[15-9], m[8-5], d[4-0]}
		nameLen:				SInt16;									{ <-> in: max length of client name string, out: actual length}
		vStringLen:				SInt16;									{ <-> in: max length of vendor string, out: actual length}
		nameString:				^UInt8;									{ <-  pointer to client name string (zero-terminated)}
		vendorString:			^UInt8;									{ <-  pointer to vendor string (zero-terminated)}
	END;

{ upper byte of attributes is kCSCardNameSubfunction,}
{							   kCSCardTypeSubfunction,}
{							   kCSHelpStringSubfunction}
	AlternateTextStringParam = RECORD
		clientHandle:			UInt32;									{  -> clientHandle returned by RegisterClient}
		attributes:				UInt16;									{ <-> subfunction + bitmapped client attributes}
		socket:					UInt16;									{  -> logical socket number}
		reserved:				UInt16;									{  -> zero}
		length:					SInt16;									{ <-> in: max length of string, out: actual length}
		text:					^UInt8;									{ <-  pointer to string (zero-terminated)}
	END;

{ upper byte of attributes is kCSCardIconSubfunction}
	AlternateCardIconParam = RECORD
		clientHandle:			UInt32;									{  -> clientHandle returned by RegisterClient}
		attributes:				UInt16;									{ <-> subfunction + bitmapped client attributes}
		socket:					UInt16;									{  -> logical socket number}
		iconSuite:				Handle;									{ <-  handle to icon suite containing all icons}
	END;

{ upper byte of attributes is kCSActionProcSubfunction}
	CustomActionProcParam = RECORD
		clientHandle:			UInt32;									{  -> clientHandle returned by RegisterClient}
		attributes:				UInt16;									{ <-> subfunction + bitmapped client attributes}
		socket:					UInt16;									{  -> logical socket number}
	END;

	GetClientInfoPB = RECORD
		CASE INTEGER OF
		0: (
			clientInfo:					ClientInfoParam;
		   );
		1: (
			alternateTextString:		AlternateTextStringParam;
		   );
		2: (
			alternateIcon:				AlternateCardIconParam;
		   );
		3: (
			customActionProc:			CustomActionProcParam;
		   );

	END;

{	‘attributes’ field values}

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

{----------------		CSGetConfigurationInfo			----------------}
{----------------		CSModifyConfiguration			----------------}
{----------------		CSRequestConfiguration			----------------}

TYPE
	GetModRequestConfigInfoPB = RECORD
		clientHandle:			UInt32;									{  -> clientHandle returned by RegisterClient}
		socket:					UInt16;									{  -> logical socket number}
		attributes:				UInt16;									{ <-> bitmap of configuration attributes}
		vcc:					SInt8; (* UInt8 *)						{ <-> Vcc setting}
		vpp1:					SInt8; (* UInt8 *)						{ <-> Vpp1 setting}
		vpp2:					SInt8; (* UInt8 *)						{ <-> Vpp2 setting}
		intType:				SInt8; (* UInt8 *)						{ <-> interface type (memory or memory+I/O)}
		configBase:				UInt32;									{ <-> card base address of configuration registers}
		status:					SInt8; (* UInt8 *)						{ <-> card status register setting, if present}
		pin:					SInt8; (* UInt8 *)						{ <-> card pin register setting, if present}
		copy:					SInt8; (* UInt8 *)						{ <-> card socket/copy register setting, if present}
		configIndex:			SInt8; (* UInt8 *)						{ <-> card option register setting, if present}
		present:				SInt8; (* UInt8 *)						{ <-> bitmap of which configuration registers are present}
		firstDevType:			SInt8; (* UInt8 *)						{ <-  from DeviceID tuple}
		funcCode:				SInt8; (* UInt8 *)						{ <-  from FuncID tuple}
		sysInitMask:			SInt8; (* UInt8 *)						{ <-  from FuncID tuple}
		manufCode:				UInt16;									{ <-  from ManufacturerID tuple}
		manufInfo:				UInt16;									{ <-  from ManufacturerID tuple}
		cardValues:				SInt8; (* UInt8 *)						{ <-  valid card register values}
		padding:				ARRAY [0..0] OF SInt8; (* UInt8 *)		{ }
	END;

{	‘attributes’ field values}

CONST
	kCSExclusivelyUsed			= $0001;
	kCSEnableIREQs				= $0002;
	kCSVccChangeValid			= $0004;
	kCSVpp1ChangeValid			= $0008;
	kCSVpp2ChangeValid			= $0010;
	kCSValidClient				= $0020;
	kCSSleepPower				= $0040;						{ request that power be applied to socket during Sleep}
	kCSLockSocket				= $0080;
	kCSTurnOnInUse				= $0100;

{	‘intType’ field values}
	kCSMemoryInterface			= $01;
	kCSMemory_And_IO_Interface	= $02;

{	‘present’ field values}
	kCSOptionRegisterPresent	= $01;
	kCSStatusRegisterPresent	= $02;
	kCSPinReplacementRegisterPresent = $04;
	kCSCopyRegisterPresent		= $08;

{	‘cardValues’ field values}
	kCSOptionValueValid			= $01;
	kCSStatusValueValid			= $02;
	kCSPinReplacementValueValid	= $04;
	kCSCopyValueValid			= $08;

{----------------		CSGetClientEventMask			----------------}
{----------------		CSSetClientEventMask			----------------}

TYPE
	GetSetClientEventMaskPB = RECORD
		clientHandle:			UInt32;									{  -> clientHandle returned by RegisterClient}
		attributes:				UInt16;									{ <-> bitmap of attributes}
		eventMask:				UInt16;									{ <-> bitmap of events to be passed to client for this socket}
		socket:					UInt16;									{  -> logical socket number}
	END;

{	‘attributes’ field values}

CONST
	kCSEventMaskThisSocketOnly	= $0001;

{	‘eventMask’ field values}
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

{----------------		CSGetFirstClient				----------------}
{----------------		CSGetNextClient					----------------}

TYPE
	GetClientPB = RECORD
		clientHandle:			UInt32;									{ <-  clientHandle for this client}
		socket:					UInt16;									{  -> logical socket number}
		attributes:				UInt16;									{  -> bitmap of attributes}
	END;

{	‘attributes’ field values}

CONST
	kCSClientsForAllSockets		= $0000;
	kCSClientsThisSocketOnly	= $0001;

{----------------		CSGetFirstTuple					----------------}
{----------------		CSGetNextTuple					----------------}
{----------------		CSGetTupleData					----------------}

TYPE
	GetTuplePB = RECORD
		socket:					UInt16;									{  -> logical socket number}
		attributes:				UInt16;									{  -> bitmap of attributes}
		desiredTuple:			SInt8; (* UInt8 *)						{  -> desired tuple code value, or $FF for all}
		tupleOffset:			SInt8; (* UInt8 *)						{  -> offset into tuple from link byte}
		flags:					UInt16;									{ <-> internal use}
		linkOffset:				UInt32;									{ <-> internal use}
		cisOffset:				UInt32;									{ <-> internal use}
		CASE INTEGER OF
		0: (
			tupleCode:					SInt8; (* UInt8 *)					{ <-  tuple code found}
			tupleLink:					SInt8; (* UInt8 *)					{ <-  link value for tuple found}
		   );
		1: (
			tupleDataMax:				UInt16;								{  -> maximum size of tuple data area}
			tupleDataLen:				UInt16;								{ <-  number of bytes in tuple body}
			tupleData:					TupleBody;							{ <-  tuple data}
		   );

	END;

{	‘attributes’ field values}

CONST
	kCSReturnLinkTuples			= $0001;

{----------------		CSRequestSocketMask				----------------}
{----------------		CSReleaseSocketMask				----------------}

TYPE
	ReqRelSocketMaskPB = RECORD
		clientHandle:			UInt32;									{  -> clientHandle returned by RegisterClient}
		socket:					UInt16;									{  -> logical socket}
		eventMask:				UInt16;									{  -> bitmap of events to be passed to client for this socket}
	END;

{	‘eventMask’ field values (see above for Get/SetClientEventMask}
{----------------		CSGetStatus						----------------}
	GetStatusPB = RECORD
		socket:					UInt16;									{  -> logical socket number}
		cardState:				UInt16;									{ <-  current state of installed card}
		socketState:			UInt16;									{ <-  current state of the socket}
	END;

{	‘cardState’ field values}

CONST
	kCSWriteProtected			= $0001;
	kCSCardLocked				= $0002;
	kCSEjectRequest				= $0004;
	kCSInsertRequest			= $0008;
	kCSBatteryDead				= $0010;
	kCSBatteryLow				= $0020;
	kCSReady					= $0040;
	kCSCardDetected				= $0080;

{	‘socketState’ field values}
	kCSWriteProtectChanged		= $0001;
	kCSCardLockChanged			= $0002;
	kCSEjectRequestPending		= $0004;
	kCSInsertRequestPending		= $0008;
	kCSBatteryDeadChanged		= $0010;
	kCSBatteryLowChanged		= $0020;
	kCSReadyChanged				= $0040;
	kCSCardDetectChanged		= $0080;

{----------------		CSModifyWindow					----------------}
{----------------		CSReleaseWindow					----------------}
{----------------		CSRequestWindow					----------------}

TYPE
	ReqModRelWindowPB = RECORD
		clientHandle:			UInt32;									{  -> clientHandle returned by RegisterClient}
		windowHandle:			UInt32;									{ <-> window descriptor}
		socket:					UInt16;									{  -> logical socket number}
		attributes:				UInt16;									{  -> window attributes (bitmap)}
		base:					UInt32;									{ <-> system base address}
		size:					UInt32;									{ <-> memory window size}
		accessSpeed:			SInt8; (* UInt8 *)						{  -> window access speed (bitmap)}
		{		(not applicable for I/O mode)}
		padding:				ARRAY [0..0] OF SInt8; (* UInt8 *)		{ }
	END;

{	‘attributes’ field values}

CONST
	kCSMemoryWindow				= $0001;
	kCSIOWindow					= $0002;
	kCSAttributeWindow			= $0004;						{ not normally used by Card Services clients}
	kCSWindowTypeMask			= $0007;
	kCSEnableWindow				= $0008;
	kCSAccessSpeedValid			= $0010;
	kCSLittleEndian				= $0020;						{ configure socket for little endianess}
	kCS16BitDataPath			= $0040;						{}
	kCSWindowPaged				= $0080;						{ }
	kCSWindowShared				= $0100;						{}
	kCSWindowFirstShared		= $0200;						{ }
	kCSWindowProgrammable		= $0400;						{ }

{	‘accessSpeed’ field values}
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

{----------------		CSRegisterClient				----------------}
{----------------		CSDeregisterClient				----------------}

TYPE
	ClientCallbackPB = RECORD
		message:				UInt16;									{  -> which event this is}
		socket:					UInt16;									{  -> logical socket number}
		info:					UInt16;									{  -> function-specific}
		misc:					UInt16;									{  -> function-specific}
		reserved:				Ptr;									{  -> pointer to MTD request block}
		buffer:					Ptr;									{  -> function-specific}
		clientData:				Ptr;									{  -> pointer to client's data (from RegisterClient)}
	END;

	ClientCallbackPBPtr = ^ClientCallbackPB;

	PCCardCSClientProcPtr = ProcPtr;  { FUNCTION PCCardCSClient(ccPBPtr: ClientCallbackPBPtr): UInt16; }
	PCCardCSClientUPP = UniversalProcPtr;

CONST
	uppPCCardCSClientProcInfo = $000000E0; { FUNCTION (4 byte param): 2 byte result; }

FUNCTION NewPCCardCSClientProc(userRoutine: PCCardCSClientProcPtr): PCCardCSClientUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallPCCardCSClientProc(ccPBPtr: ClientCallbackPBPtr; userRoutine: PCCardCSClientUPP): UInt16;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	RegisterClientPB = RECORD
		clientHandle:			UInt32;									{ <-  client descriptor}
		clientEntry:			PCCardCSClientUPP;						{  -> universal procPtr to client's event handler}
		attributes:				UInt16;									{  -> bitmap of client attributes}
		eventMask:				UInt16;									{  -> bitmap of events to notify client}
		clientData:				Ptr;									{  -> pointer to client's data}
		version:				UInt16;									{  -> Card Services version this client expects}
	END;

{	‘attributes’ field values (see GetClientInfo)}
{	kCSMemoryClient					= 0x0001,}
{	kCSIOClient						= 0x0004,}
{	kCSShareableCardInsertEvents	= 0x0008,}
{	kCSExclusiveCardInsertEvents	= 0x0010}
{----------------		CSReleaseConfiguration			----------------}
	ReleaseConfigurationPB = RECORD
		clientHandle:			UInt32;									{  -> clientHandle returned by RegisterClient}
		socket:					UInt16;									{  -> }
	END;

{----------------		CSResetCard						----------------}
	ResetCardPB = RECORD
		clientHandle:			UInt32;									{  -> clientHandle returned by RegisterClient}
		socket:					UInt16;									{  -> }
		attributes:				UInt16;									{  -> xxx}
	END;

{----------------		CSValidateCIS					----------------}
	ValidateCISPB = RECORD
		socket:					UInt16;									{  -> }
		chains:					UInt16;									{  -> whether link/null tuples should be included}
	END;

{----------------		CSVendorSpecific				----------------}
	VendorSpecificPB = RECORD
		clientHandle:			UInt32;									{  -> clientHandle returned by RegisterClient}
		vsCode:					UInt16;
		socket:					UInt16;
		dataLen:				UInt32;									{  -> length of buffer pointed to by vsDataPtr}
		vsDataPtr:				^UInt8;									{  -> Card Services version this client expects}
	END;

{	‘vsCode’ field values}

CONST
	vsAppleReserved				= $0000;
	vsEjectCard					= $0001;
	vsGetCardInfo				= $0002;
	vsEnableSocketEvents		= $0003;
	vsGetCardLocationIcon		= $0004;
	vsGetCardLocationText		= $0005;
	vsGetAdapterInfo			= $0006;

{///////////////////////////////////////////////////////////////////////////////////////}
{}
{	GetAdapterInfo parameter block (vendor-specific call #6)}

TYPE
	GetAdapterInfoPB = RECORD
		attributes:				UInt32;									{ <-  capabilties of socket's adapter}
		revision:				UInt16;									{ <-  id of adapter}
		reserved:				UInt16;									{ }
		numVoltEntries:			UInt16;									{ <-  number of valid voltage values}
		voltages:				^UInt8;									{ <-> array of BCD voltage values}
	END;

{	‘attributes’ field values}

CONST
	kCSLevelModeInterrupts		= $00000001;
	kCSPulseModeInterrupts		= $00000002;
	kCSProgrammableWindowAddr	= $00000004;
	kCSProgrammableWindowSize	= $00000008;
	kCSSocketSleepPower			= $00000010;
	kCSSoftwareEject			= $00000020;
	kCSLockableSocket			= $00000040;
	kCSInUseIndicator			= $00000080;

{///////////////////////////////////////////////////////////////////////////////////////}
{}
{	GetCardInfo parameter block (vendor-specific call #2)}

TYPE
	GetCardInfoPB = RECORD
		cardType:				SInt8; (* UInt8 *)						{ <-  type of card in this socket (defined at top of file)}
		subType:				SInt8; (* UInt8 *)						{ <-  more detailed card type (defined at top of file)}
		reserved:				UInt16;									{ <-> reserved (should be set to zero)}
		cardNameLen:			UInt16;									{  -> maximum length of card name to be returned}
		vendorNameLen:			UInt16;									{  -> maximum length of vendor name to be returned}
		cardName:				^UInt8;									{  -> pointer to card name string (read from CIS), or nil}
		vendorName:				^UInt8;									{  -> pointer to vendor name string (read from CIS), or nil}
	END;

{	GetCardInfo card types}

CONST
	kCSUnknownCardType			= 0;
	kCSMultiFunctionCardType	= 1;
	kCSMemoryCardType			= 2;
	kCSSerialPortCardType		= 3;
	kCSSerialOnlyType			= 0;
	kCSDataModemType			= 1;
	kCSFaxModemType				= 2;
	kCSFaxAndDataModemMask		= 0+(kCSDataModemType + kCSFaxModemType);
	kCSVoiceEncodingType		= 4;
	kCSParallelPortCardType		= 4;
	kCSFixedDiskCardType		= 5;
	kCSUnknownFixedDiskType		= 0;
	kCSATAInterface				= 1;
	kCSRotatingDevice			= 0+(0 * (2**(7)));
	kCSSiliconDevice			= 0+(1 * (2**(7)));
	kCSVideoAdaptorCardType		= 6;
	kCSNetworkAdaptorCardType	= 7;
	kCSAIMSCardType				= 8;
	kCSNumCardTypes				= 9;


FUNCTION CSVendorSpecific(VAR pb: VendorSpecificPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $AAF0;
	{$ENDC}
FUNCTION CSRegisterClient(VAR pb: RegisterClientPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $AAF0;
	{$ENDC}
FUNCTION CSDeregisterClient(VAR pb: RegisterClientPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $AAF0;
	{$ENDC}
FUNCTION CSGetFirstTuple(VAR pb: GetTuplePB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7003, $AAF0;
	{$ENDC}
FUNCTION CSGetNextTuple(VAR pb: GetTuplePB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7004, $AAF0;
	{$ENDC}
FUNCTION CSGetTupleData(VAR pb: GetTuplePB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7005, $AAF0;
	{$ENDC}
FUNCTION CSGetConfigurationInfo(VAR pb: GetModRequestConfigInfoPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7006, $AAF0;
	{$ENDC}
FUNCTION CSGetCardServicesInfo(VAR pb: GetCardServicesInfoPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7007, $AAF0;
	{$ENDC}
FUNCTION CSGetStatus(VAR pb: GetStatusPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7008, $AAF0;
	{$ENDC}
FUNCTION CSValidateCIS(VAR pb: ValidateCISPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7009, $AAF0;
	{$ENDC}
FUNCTION CSGetFirstClient(VAR pb: GetClientPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700F, $AAF0;
	{$ENDC}
FUNCTION CSGetNextClient(VAR pb: GetClientPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7010, $AAF0;
	{$ENDC}
FUNCTION CSGetClientInfo(VAR pb: GetClientInfoPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7011, $AAF0;
	{$ENDC}
FUNCTION CSResetCard(VAR pb: ResetCardPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7012, $AAF0;
	{$ENDC}
FUNCTION CSRequestWindow(VAR pb: ReqModRelWindowPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7013, $AAF0;
	{$ENDC}
FUNCTION CSModifyWindow(VAR pb: ReqModRelWindowPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7014, $AAF0;
	{$ENDC}
FUNCTION CSReleaseWindow(VAR pb: ReqModRelWindowPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7015, $AAF0;
	{$ENDC}
FUNCTION CSRequestConfiguration(VAR pb: GetModRequestConfigInfoPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701B, $AAF0;
	{$ENDC}
FUNCTION CSModifyConfiguration(VAR pb: GetModRequestConfigInfoPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701C, $AAF0;
	{$ENDC}
FUNCTION CSAccessConfigurationRegister(VAR pb: AccessConfigurationRegisterPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701D, $AAF0;
	{$ENDC}
FUNCTION CSReleaseConfiguration(VAR pb: ReleaseConfigurationPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701E, $AAF0;
	{$ENDC}
FUNCTION CSGetClientEventMask(VAR pb: GetSetClientEventMaskPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701F, $AAF0;
	{$ENDC}
FUNCTION CSSetClientEventMask(VAR pb: GetSetClientEventMaskPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7020, $AAF0;
	{$ENDC}
FUNCTION CSRequestSocketMask(VAR pb: ReqRelSocketMaskPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7021, $AAF0;
	{$ENDC}
FUNCTION CSReleaseSocketMask(VAR pb: ReqRelSocketMaskPB): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7022, $AAF0;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CardServicesIncludes}

{$ENDC} {__CARDSERVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

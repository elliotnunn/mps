{
     File:       PCCard.p
 
     Contains:   PC Card Family Programming interface
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1996-2001 by Apple Computer, Inc.  All rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT PCCard;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PCCARD__}
{$SETC __PCCARD__ := 1}

{$I+}
{$SETC PCCardIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}


CONST
	kServiceCategoryPCCard		= 'pccd';



TYPE
	PCCardEvent							= UInt32;
	PCCardEventMask						= UInt32;
	PCCardClientID						= UInt32;
	PCCardTimerID						= UInt32;
	PCCardSocket						= UInt32;
	PCCardWindowID						= UInt32;
	PCCardWindowType					= UInt32;
	PCCardWindowSize					= UInt32;
	PCCardWindowOffset					= UInt32;
	PCCardWindowAlign					= UInt32;
	PCCardWindowState					= OptionBits;
	PCCardAccessSpeed					= UInt32;
	PCCardWindowParam					= UInt32;
	PCCardPage							= UInt32;
	PCCardVoltage						= UInt32;
	{	
	    Several of the client notification bit flags have been REMOVED since the first
	    release of this header.  These were unused codes that were either
	    copied directly from PC Card 2.x, or from the PCMCIA standard.  In all cases,
	    they were completely unimplemented and would never be sent under PCCard 3.0.
	    
	    The removed flags are:
	        kPCCardClientInfoMessage, kPCCardSSUpdatedMessage,
	        and kPCCardFunctionInterruptMessage.
	    
	    If your software used any of these flags, you should delete any references
	    to them.  These event codes are being recycled for new features.
		}
	{	 Client notification bit flags 	}

CONST
	kPCCardNullMessage			= $00000000;					{  no messages pending (not sent to clients) }
	kPCCardInsertionMessage		= $00000001;					{  card has been inserted into the socket }
	kPCCardRemovalMessage		= $00000002;					{  card has been removed from the socket- do not touch hardware! }
																{  Lock and Unlock may be used for a hardware locking card-cage.  }
	kPCCardLockMessage			= $00000004;					{  card is locked into the socket with a mechanical latch  }
	kPCCardUnlockMessage		= $00000008;					{  card is no longer locked into the socket  }
																{  Ready and Reset are holdovers from PC Card 2.x, but someone might be using them (!?)  }
	kPCCardReadyMessage			= $00000010;					{  card is ready to be accessed -- do not use! this event is never sent! (use kPCCardInsertion instead)  }
	kPCCardResetMessage			= $00000020;					{  physical reset has completed -- do not use! this event is never sent! (use kPCCardResetComplete instead)  }
																{  InsertionRequest and InsertionComplete may be used with certain cages (??)  }
	kPCCardInsertionRequestMessage = $00000040;					{  request to insert a card using insertion motor  }
	kPCCardInsertionCompleteMessage = $00000080;				{  insertion motor has finished inserting a card  }
	kPCCardEjectionRequestMessage = $00000100;					{  user or other client is requesting a card ejection }
	kPCCardEjectionCompleteMessage = $00000200;					{  card ejection succeeded- do not touch hardware!  }
	kPCCardEjectionFailedMessage = $00000400;					{  eject failure due to electrical/mechanical problems }
	kPCCardPMResumeMessage		= $00000800;					{  power management resume  }
	kPCCardPMSuspendMessage		= $00001000;					{  power management suspend  }
	kPCCardPMSuspendRequest		= $00002000;					{  power management sleep request  }
	kPCCardPMSuspendRevoke		= $00004000;					{  power management sleep revoke  }
	kPCCardResetPhysicalMessage	= $00008000;					{  physical reset is about to occur on this card -- this event is never sent!  }
	kPCCardResetRequestMessage	= $00010000;					{  physical reset has been requested by a client }
	kPCCardResetCompleteMessage	= $00020000;					{  ResetCard() background reset has completed }
	kPCCardBatteryDeadMessage	= $00040000;					{  battery is no longer useable, data will be lost }
	kPCCardBatteryLowMessage	= $00080000;					{  battery is weak and should be replaced }
	kPCCardWriteProtectMessage	= $00100000;					{  card is now write protected }
	kPCCardWriteEnabledMessage	= $00200000;					{  card is now write enabled }
	kPCCardDisplayEjectDSATMessage = $00400000;					{  about to display a DSAT for the user to re-insert a manually ejected card  }
	kPCCardUnexpectedRemovalMessage = $02000000;				{  card has unexpectedly been manually ejected  }
																{  Unconfigured is a (currently unused) holdover from PC Card 2.x  }
	kPCCardUnconfiguredMessage	= $04000000;					{  a CARD_READY was delivered to all clients and no client  }
																{     requested a configuration for the socket -- this event is never sent under PCCard 3.0!  }
	kPCCardStatusChangedMessage	= $08000000;					{  status change for cards in I/O mode }
	kPCCardTimerExpiredMessage	= $10000000;					{  message sent when requested time has expired  }
	kPCCardRequestAttentionMessage = $20000000;
	kPCCardEraseCompleteMessage	= $40000000;
	kPCCardRegistrationCompleteMessage = $80000000;				{  notifications available only in PCCard 3.1 and later  }
	kPCCardPMEnabledMessage		= $00800000;					{  power management has been enabled by the user; if appropriate, clients should call PCCardSetPowerLevel(off)  }


TYPE
	PCCardWindowAttributes				= OptionBits;
	{	  window state (values of PCCardWindowAttributes) 	}

CONST
	kWSCommon					= $0001;						{  common memory window  }
	kWSAttribute				= $0002;						{  attribute memory window }
	kWSIO						= $0004;						{  I/O window }
	kWSCardBus					= $0800;						{  CardBus bridge window  }
	kWSTypeMask					= $0807;						{  window type mask }
	kWSEnabled					= $0008;						{  window enabled }
	kWS8bit						= $0010;						{  8-bit data width window }
	kWS16bit					= $0020;						{  16-bit data width window }
	kWS32bit					= $0040;						{  32-bit data width window }
	kWSAutoSize					= $0080;						{  auto-size data width window }
	kWSWidthMask				= $00F0;						{  window data width mask }
	kWSProtected				= $0100;						{  window write protected }
	kWSPrefetchable				= $0200;						{  bridge window prefetchable }
	kWSPageShared				= $0400;						{  page register is shared }
	kWSWindowSizeOffset			= $4000;
	kWSChangeAccessSpeed		= $8000;						{  Used by CSModifyWindow only  }

	{	 window speed (sample values of PCCardAccessSpeed) for use in PCCardRequestWindow  	}
	kAccessSpeed600ns			= $006A;
	kAccessSpeed500ns			= $005A;
	kAccessSpeed400ns			= $004A;
	kAccessSpeed300ns			= $003A;
	kAccessSpeed250ns			= $0001;
	kAccessSpeed200ns			= $0002;
	kAccessSpeed150ns			= $0003;
	kAccessSpeed100ns			= $0004;


TYPE
	PCCardInterfaceType					= UInt32;
	{	 InterfaceType bit-mask (values of PCCardInterfaceType) 	}

CONST
	kIFTypeMask					= $03;							{  IO & memory type mask }
	kIFCardBus					= $00;							{  if bits 0 & 1 are zero then cardbus interface }
	kIFMemory					= $01;							{  if bit 0 set memory IF }
	kIFIO						= $02;							{  if bit 1 set IO IF }
	kIFReserved					= $03;							{  bits 0 and 1 set is reserved  }
	kIFDMA						= $08;							{  if bit 3 set DMA supported }
	kIFVSKey					= $10;							{  if bit 4 set supports low Voltage key }
	kIF33VCC					= $20;							{  if bit 5 set socket suports 3.3v }
	kIFXXVCC					= $40;							{  if bit 6 set socket supports X.X voltage }
	kIFYYVCC					= $80;							{  if bit 7 set socket supports Y.Y voltage }


TYPE
	PCCardCustomInterfaceID				= UInt32;
	{	 Custom Interface Identifiers (values of PCCardCustomInterfaceID) 	}

CONST
	kIFCustom_None				= $00;							{  no custom interface ID  }
	kIFCustom_ZOOM				= $41;							{  ZOOM Video Mode custom interface identifier  }


TYPE
	PCCardConfigOptions					= OptionBits;
	{	 Bit mask values for PCCardConfigOptions in the configuration calls 	}

CONST
	kEnableIRQSteering			= $0002;
	kIRQChangeValid				= $0004;
	kVppChangeValid				= $0010;
	kEnableDMAChannel			= $0040;
	kDMAChangeValid				= $0080;
	kVSOverride					= $0200;						{  Bits 10..31 reserved  }

	{
	   Configuration Registers Presence Mask for the FCR
	   Used by PCCardConfigPresentMask
	}
	kConfigOptionPresent		= $00000001;
	kConfigStatusPresent		= $00000002;
	kPinReplacePresent			= $00000004;
	kSocketCopyPresent			= $00000008;
	kExtendedStatusPresent		= $00000010;
	kIOBase0Present				= $00000020;
	kIOBase1Present				= $00000040;
	kIOBase2Present				= $00000080;
	kIOBase3Present				= $00000100;
	kIOLimitPresent				= $00000200;


TYPE
	PCCardConfigPresentMask				= UInt32;
	PCCardConfigRegisterIndex			= UInt32;
	PCCardConfigRegisterOffset			= UInt32;
	PCCardFunctionConfigRegPtr = ^PCCardFunctionConfigReg;
	PCCardFunctionConfigReg = RECORD
		configOptionReg:		SInt8;
		configStatusReg:		SInt8;
		pinReplaceReg:			SInt8;
		socketCopyReg:			SInt8;
		extendedStatusReg:		SInt8;
		ioBase0:				SInt8;
		ioBase1:				SInt8;
		ioBase2:				SInt8;
		ioBase3:				SInt8;
		ioLimit:				SInt8;
	END;

	PCCardSocketStatus					= OptionBits;
	{	  general socket status bits (values of PCCardSocketStatus) 	}

CONST
	kSTBatteryDead				= $0001;						{  battery dead }
	kSTBatteryLow				= $0002;						{  battery low }
	kSTBatteryGood				= $0004;						{  battery good }
	kSTPower					= $0008;						{  power is applied }
	kST16bit					= $0010;						{  16-bit PC Card present }
	kSTCardBus					= $0020;						{  CardBus PC Card present }
	kSTMemoryCard				= $0040;						{  memory card present }
	kSTIOCard					= $0080;						{  I/O card present }
	kSTNotACard					= $0100;						{  unrecognizable PC Card detected }
	kSTReady					= $0200;						{  ready }
	kSTWriteProtect				= $0400;						{  card is write-protected }
	kSTDataLost					= $0800;						{  data may have been lost due to card removal }
	kSTRingIndicate				= $1000;						{  ring indicator is active }
	kSTReserved					= $E000;

	{	 Bit mask for PCCardPowerOptions in the power management calls 	}

TYPE
	PCCardPowerOptions					= OptionBits;

CONST
	kPCCardPowerOn				= $00000001;
	kPCCardPowerOff				= $00000002;
	kPCCardLowPower				= $00000004;


TYPE
	PCCardAdapterCapabilities			= OptionBits;
	PCCardAdapterPowerState				= UInt32;
	PCCardSCEvents						= OptionBits;
	PCCardWindow						= UInt32;
	PCCardIRQ							= UInt32;
	PCCardDMA							= UInt32;
	{	 Selectors for PCCardGetGlobalOptions 	}
	{	  The type of the "value" parameter is provided for each selector. 	}
	PCCardOptionSelector				= UInt32;

CONST
	kPCCardPowerManagementAttrib = 1;							{  value = (Boolean*) enabled   }



	{  Types and structures for accessing the PCCard Assigned-Address property. }

	kPCCardNonRelocatableSpace	= $80;
	kPCCardPrefetchableSpace	= $40;
	kPCCard16BitSpace			= $20;
	kPCCardAddressTypeCodeMask	= $07;
	kPCCardConfigSpace			= 0;
	kPCCardIOSpace				= 1;
	kPCCardMemorySpace			= 2;
	kPCCardAttributeMemorySpace	= 4;


TYPE
	PCCardAddressSpaceFlags				= UInt8;

CONST
	kPCCardSocketNumberMask		= $F8;
	kPCCardFunctionNumberMask	= $07;


TYPE
	PCCardSocketFunction				= UInt8;
	PCCardBusNumber						= UInt8;
	PCCardRegisterNumber				= UInt8;
	{
	   note: this structure is similar, but not the same as the PCIAssignedAddress structure
	         16-bit cards use this structure, CardBus cards use PCIAssignedAddress
	}
	PCCardAssignedAddressPtr = ^PCCardAssignedAddress;
	PCCardAssignedAddress = PACKED RECORD
		addressSpaceFlags:		PCCardAddressSpaceFlags;
		reserved:				UInt8;
		socketFunctionNumber:	PCCardSocketFunction;
		registerNumber:			PCCardRegisterNumber;
		address:				UInt32;
		size:					UInt32;
	END;

	{	----------------------------------------------------------------------
	    Client Support
	----------------------------------------------------------------------	}
	{	 Prototype for client callback 	}
{$IFC TYPED_FUNCTION_POINTERS}
	PCCardEventHandler = FUNCTION(theEvent: PCCardEvent; vSocket: PCCardSocket; device: UInt32; info: UInt32; MTDRequest: UInt32; VAR Buffer: UInt32; misc: UInt32; status: UInt32; clientParam: UNIV Ptr): OSStatus; C;
{$ELSEC}
	PCCardEventHandler = ProcPtr;
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PCCardRegisterClient()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in PCCard 3.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PCCardRegisterClient({CONST}VAR deviceRef: RegEntryID; eventMask: PCCardEventMask; clientCallBack: PCCardEventHandler; clientParam: UNIV Ptr; VAR newClientID: PCCardClientID): OSStatus; C;

{
 *  PCCardDeRegisterClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardDeRegisterClient(theClientID: PCCardClientID): OSStatus; C;

{
 *  PCCardRegisterTimer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardRegisterTimer(registeredClientID: PCCardClientID; VAR lpNewTimerID: PCCardTimerID; delay: LONGINT): OSStatus; C;

{
 *  PCCardDeRegisterTimer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE PCCardDeRegisterTimer(timerID: PCCardTimerID); C;

{
 *  PCCardSetEventMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardSetEventMask(theClientID: PCCardClientID; newEventMask: PCCardEventMask): OSStatus; C;

{
 *  PCCardGetEventMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardGetEventMask(theClientID: PCCardClientID; VAR newEventMask: PCCardEventMask): OSStatus; C;

{
 *  PCCardGetCardServicesInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardGetCardServicesInfo(VAR socketCount: ItemCount; VAR complianceLevel: UInt32; VAR version: UInt32): OSStatus; C;

{
 *  PCCardGetSocketRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardGetSocketRef(vSocket: PCCardSocket; VAR socketRef: RegEntryID): OSStatus; C;

{
 *  PCCardGetCardRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardGetCardRef(vSocket: PCCardSocket; VAR cardRef: RegEntryID): OSStatus; C;

{
 *  PCCardGetDeviceRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardGetDeviceRef(vSocket: PCCardSocket; device: UInt32; VAR deviceRef: RegEntryID): OSStatus; C;

{
 *  PCCardGetSocketAndDeviceFromDeviceRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardGetSocketAndDeviceFromDeviceRef({CONST}VAR deviceRef: RegEntryID; VAR vSocket: PCCardSocket; VAR device: UInt32): OSStatus; C;

{
 *  PCCardGetCardRefFromDeviceRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardGetCardRefFromDeviceRef({CONST}VAR deviceRef: RegEntryID; VAR cardRef: RegEntryID): OSStatus; C;


{----------------------------------------------------------------------
    Resource Management
----------------------------------------------------------------------}
{
 *  PCCardRequestWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardRequestWindow({CONST}VAR deviceRef: RegEntryID; windowAttributes: PCCardWindowAttributes; VAR windowBase: LogicalAddress; VAR windowSize: ByteCount; VAR windowSpeed: PCCardAccessSpeed; VAR windowOffset: PCCardWindowOffset; VAR windowID: PCCardWindowID): OSStatus; C;

{
 *  PCCardModifyWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardModifyWindow(windowID: PCCardWindowID; windowAttributes: PCCardWindowAttributes; windowSpeed: PCCardAccessSpeed; windowOffset: PCCardWindowOffset): OSStatus; C;

{
 *  PCCardReleaseWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardReleaseWindow(windowID: PCCardWindowID): OSStatus; C;

{
 *  PCCardInquireWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardInquireWindow({CONST}VAR deviceRef: RegEntryID; windowID: PCCardWindowID; VAR windowAttributes: PCCardWindowAttributes; VAR windowBase: LogicalAddress; VAR windowSize: ByteCount; VAR windowSpeed: PCCardAccessSpeed; VAR windowOffset: PCCardWindowOffset): OSStatus; C;

{
 *  PCCardGetStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardGetStatus({CONST}VAR deviceRef: RegEntryID; VAR currentState: UInt32; VAR changedState: UInt32; VAR Vcc: PCCardVoltage; VAR Vpp: PCCardVoltage): OSStatus; C;

{
 *  PCCardRequestConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardRequestConfiguration({CONST}VAR deviceRef: RegEntryID; configOptions: PCCardConfigOptions; ifType: PCCardInterfaceType; ifCustomType: PCCardCustomInterfaceID; vcc: PCCardVoltage; vpp: PCCardVoltage; configRegistersBase: LogicalAddress; configRegistersPresent: PCCardConfigPresentMask; VAR configRegisterValues: PCCardFunctionConfigReg): OSStatus; C;

{
 *  PCCardReleaseConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardReleaseConfiguration({CONST}VAR deviceRef: RegEntryID): OSStatus; C;

{
 *  PCCardModifyConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardModifyConfiguration({CONST}VAR deviceRef: RegEntryID; configOptions: PCCardConfigOptions; vpp: PCCardVoltage): OSStatus; C;

{
 *  PCCardReadConfigurationRegister()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardReadConfigurationRegister({CONST}VAR deviceRef: RegEntryID; whichRegister: PCCardConfigRegisterIndex; offset: PCCardConfigRegisterOffset; VAR value: UInt8): OSStatus; C;

{
 *  PCCardWriteConfigurationRegister()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardWriteConfigurationRegister({CONST}VAR deviceRef: RegEntryID; whichRegister: PCCardConfigRegisterIndex; offset: PCCardConfigRegisterOffset; value: ByteParameter): OSStatus; C;

{
 *  PCCardResetFunction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardResetFunction({CONST}VAR deviceRef: RegEntryID): OSStatus; C;

{----------------------------------------------------------------------
    Client Utilities
----------------------------------------------------------------------}
{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	PCCardTupleKind						= UInt8;
	PCCardTupleIterator    = ^LONGINT; { an opaque 32-bit type }
	PCCardTupleIteratorPtr = ^PCCardTupleIterator;  { when a VAR xx:PCCardTupleIterator parameter can be nil, it is changed to xx: PCCardTupleIteratorPtr }
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PCCardNewTupleIterator()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in PCCard 3.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PCCardNewTupleIterator: PCCardTupleIterator; C;

{
 *  PCCardDisposeTupleIterator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardDisposeTupleIterator(tupleIterator: PCCardTupleIterator): OSStatus; C;

{
 *  PCCardGetFirstTuple()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardGetFirstTuple({CONST}VAR deviceID: RegEntryID; desiredTuple: ByteParameter; tupleIterator: PCCardTupleIterator; dataBuffer: UNIV Ptr; VAR dataBufferSize: UInt32; VAR foundTuple: PCCardTupleKind; VAR foundTupleDataSize: UInt32): OSStatus; C;

{
 *  PCCardGetNextTuple()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardGetNextTuple({CONST}VAR deviceRef: RegEntryID; desiredTuple: ByteParameter; tupleIterator: PCCardTupleIterator; dataBuffer: UNIV Ptr; VAR dataBufferSize: UInt32; VAR foundTuple: PCCardTupleKind; VAR foundTupleDataSize: UInt32): OSStatus; C;

{----------------------------------------------------------------------
    Miscellaneous
----------------------------------------------------------------------}
{
 *  PCCardEject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardEject({CONST}VAR cardRef: RegEntryID): OSStatus; C;

{
 *  PCCardEnableModemSound()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardEnableModemSound({CONST}VAR cardRef: RegEntryID; enableSound: BOOLEAN): OSStatus; C;

{
 *  PCCardEnableZoomedVideo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardEnableZoomedVideo({CONST}VAR cardRef: RegEntryID; enableZoomedVideo: BOOLEAN): OSStatus; C;

{
 *  PCCardEnableZoomedVideoSound()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardEnableZoomedVideoSound({CONST}VAR cardRef: RegEntryID; enableSound: BOOLEAN): OSStatus; C;

{
 *  PCCardSetPowerLevel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardSetPowerLevel({CONST}VAR deviceRef: RegEntryID; powerLevel: PCCardPowerOptions): OSStatus; C;

{
 *  PCCardSetRingIndicate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardSetRingIndicate({CONST}VAR deviceRef: RegEntryID; setRingIndicate: BOOLEAN): OSStatus; C;

{
 *  PCCardGetGlobalOptions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PCCardGetGlobalOptions(selector: PCCardOptionSelector; value: UNIV Ptr): OSStatus; C;

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	PCCardDevType						= UInt32;
	PCCardSubType						= UInt32;
	{  values for PCCardType and PCCardSubType }

CONST
	kPCCardUnknownType			= 0;
	kPCCardMultiFunctionType	= 1;
	kPCCardMemoryType			= 2;
	kPCCardNullSubType			= 0;							{  Memory sub types  }
	kPCCardRomSubType			= 1;
	kPCCardOTPromSubType		= 2;
	kPCCardEpromSubType			= 3;
	kPCCardEEpromSubType		= 4;
	kPCCardFlashSubType			= 5;
	kPCCardSramSubType			= 6;
	kPCCardDramSubType			= 7;
	kPCCardSerialPortType		= 3;
	kPCCardSerialOnlySubType	= 0;
	kPCCardDataModemSubType		= 1;
	kPCCardFaxModemSubType		= 2;
	kPCCardFaxAndDataModemMask	= 3;
	kPCCardVoiceEncodingSubType	= 4;
	kPCCardParallelPortType		= 4;
	kPCCardFixedDiskType		= 5;
	kPCCardUnknownFixedDiskType	= 0;
	kPCCardATAInterfaceDiskSubType = 1;
	kPCCardRotatingDeviceSubType = $00;
	kPCCardSiliconDevice		= $80;
	kPCCardVideoAdaptorType		= 6;
	kPCCardNetworkAdaptorType	= 7;
	kPCCardArcNetSubType		= 1;							{  network sub types  }
	kPCCardEthernetSubType		= 2;
	kPCCardTokenRingSubType		= 3;
	kPCCardLocalTalkSubType		= 4;
	kPCCardFDDI_CDDISubType		= 5;
	kPCCardATMSubType			= 6;
	kPCCardWirelessSubType		= 7;
	kPCCardAIMSType				= 8;
	kPCCardSCSIType				= 9;
	kPCCardSerialBusType		= 10;
	kPCCardUSBBusSubType		= 1;
	kPCCardFirewireBusSubType	= 2;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PCCardGetCardInfo()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in PCCard 3.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PCCardGetCardInfo({CONST}VAR cardRef: RegEntryID; VAR cardType: PCCardDevType; VAR cardSubType: PCCardSubType; cardName: StringPtr; vendorName: StringPtr): OSStatus; C;

{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kPCCard16HardwareType		= 'pc16';
	kCardBusHardwareType		= 'cdbs';


TYPE
	PCCardHardwareType					= UInt32;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  PCCardGetCardType()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in PCCard 3.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION PCCardGetCardType({CONST}VAR socketRef: RegEntryID; VAR cardType: PCCardHardwareType): OSStatus; C;


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PCCardIncludes}

{$ENDC} {__PCCARD__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

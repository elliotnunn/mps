{
     File:       PCCardEnablerPlugin.p
 
     Contains:   Interfacer for PCCard Manager 3.0
 
     Version:    Technology: Mac OS 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1997-2001 by Apple Computer, Inc. and SystemSoft Corporation.  All rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT PCCardEnablerPlugin;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __PCCARDENABLERPLUGIN__}
{$SETC __PCCARDENABLERPLUGIN__ := 1}

{$I+}
{$SETC PCCardEnablerPluginIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}
{$IFC UNDEFINED __INTERRUPTS__}
{$I Interrupts.p}
{$ENDC}
{$IFC UNDEFINED __PCCARD__}
{$I PCCard.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{$IFC UNDEFINED __CARDSERVICES__ }
{
    NOTE: These prototypes conflict with CardServices.≈
          You cannot use both PCCardEnablerPlugin.h and CardServices.h
          
}

{  Copyright:  © 1996 SystemSoft Corporation, all rights reserved. }
{------------------------------------------------------------------------------------
    Card Services calls exported by the Family
------------------------------------------------------------------------------------}
{   Card Services for Card Enablers }

{$IFC CALL_NOT_IN_CARBON }
{
 *  CSGetCardServicesInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetCardServicesInfo(VAR socketCount: UInt32; VAR complianceLevel: UInt32; VAR version: UInt32): OSStatus; C;


{  Function prototypes for tuples calls  }

{
 *  CSGetFirstTuple()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetFirstTuple(socket: PCCardSocket; device: UInt32; tupleIterator: PCCardTupleIterator; desiredTuple: ByteParameter; tupleData: UNIV Ptr; VAR tupleBufferSize: ByteCount; VAR foundTuple: Byte): OSStatus; C;

{
 *  CSGetNextTuple()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetNextTuple(tupleIterator: PCCardTupleIterator; desiredTuple: ByteParameter; tupleData: UNIV Ptr; VAR tupleBufferSize: ByteCount; VAR foundTuple: Byte): OSStatus; C;


{  Function prototypes for window calls }

{
 *  CSRequestWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSRequestWindow(vSocket: PCCardSocket; device: UInt32; windowAttributes: PCCardWindowAttributes; windowSpeed: PCCardAccessSpeed; VAR windowBase: LogicalAddress; VAR windowSize: PCCardWindowSize; VAR windowOffset: PCCardWindowOffset; VAR requestedWindow: PCCardWindowID): OSStatus; C;

{
 *  CSReleaseWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSReleaseWindow(windowToRelease: PCCardWindowID): OSStatus; C;

{
 *  CSModifyWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSModifyWindow(windowToModify: PCCardWindowID; windowAttributes: PCCardWindowType; memorySpeed: PCCardAccessSpeed; VAR windowOffset: PCCardWindowOffset): OSStatus; C;

{
 *  CSGetWindowBaseAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetWindowBaseAddress(window: PCCardWindowID; VAR baseAddress: LogicalAddress): OSStatus; C;

{
 *  CSInquireWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSInquireWindow(vSocket: PCCardSocket; device: UInt32; windowID: PCCardWindowID; VAR windowAttributes: PCCardWindowAttributes; VAR windowParam: PCCardAccessSpeed; VAR windowBase: UInt32; VAR windowSize: PCCardWindowSize; VAR windowOffset: PCCardWindowOffset): OSStatus; C;

{  Function prototypes for CIS calls }

{
 *  CSValidateCIS()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSValidateCIS(vSocket: PCCardSocket; device: UInt32; VAR cisChainCount: UInt32): OSStatus; C;

{
 *  CSGetDeviceCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetDeviceCount(vSocket: PCCardSocket; VAR deviceCount: UInt32): OSStatus; C;


{  Function prototypes for Status calls }

{
 *  CSGetStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetStatus(vSocket: PCCardSocket; VAR currentState: UInt32; VAR changedState: UInt32; VAR Vcc: PCCardVoltage; VAR Vpp: PCCardVoltage): OSStatus; C;


{  Function prototypes for configuration calls }

{
 *  CSRequestConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSRequestConfiguration(vSocket: PCCardSocket; device: UInt32; configOptions: PCCardConfigOptions; socketInterface: PCCardInterfaceType; customInterface: PCCardCustomInterfaceID; vcc: PCCardVoltage; vpp: PCCardVoltage; IRQ: PCCardIRQ; DMA: PCCardDMA; configRegBaseAddress: UInt32; configRegPresentMask: PCCardConfigPresentMask; VAR configReg: PCCardFunctionConfigReg): OSStatus; C;

{
 *  CSModifyConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSModifyConfiguration(vSocket: PCCardSocket; device: UInt32; modifyAttributes: PCCardConfigOptions; IRQ: PCCardIRQ; DMA: PCCardDMA; Vpp: PCCardVoltage): OSStatus; C;

{
 *  CSReleaseConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSReleaseConfiguration(vSocket: PCCardSocket; device: UInt32): OSStatus; C;

{
 *  CSSetRingIndicate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSSetRingIndicate(vSocket: PCCardSocket; setRingIndicate: BOOLEAN): OSStatus; C;

{
 *  CSResetFunction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSResetFunction(vSocket: PCCardSocket; device: UInt32): OSStatus; C;

{
 *  CSReadConfigurationRegister()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSReadConfigurationRegister(vSocket: PCCardSocket; device: UInt32; whichRegister: PCCardConfigPresentMask; configRegBaseAddress: UInt32; VAR registerValue: UInt8): OSStatus; C;

{
 *  CSWriteConfigurationRegister()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSWriteConfigurationRegister(vSocket: PCCardSocket; device: UInt32; whichRegister: PCCardConfigPresentMask; configRegBaseAddress: UInt32; registerValue: ByteParameter): OSStatus; C;

{ Function prototypes for Client Support calls}
{
 *  CSRegisterClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSRegisterClient(vSocket: PCCardSocket; eventMask: PCCardEventMask; clientCallBack: PCCardEventHandler; clientParam: UNIV Ptr; VAR newClientID: PCCardClientID): OSStatus; C;

{
 *  CSDeRegisterClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSDeRegisterClient(theClientID: PCCardClientID): OSStatus; C;

{
 *  CSSetEventMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSSetEventMask(theClientID: PCCardClientID; newEventMask: PCCardEventMask): OSStatus; C;

{
 *  CSGetEventMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSGetEventMask(theClientID: PCCardClientID; VAR newEventMask: PCCardEventMask): OSStatus; C;

{
 *  CSRegisterTimer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSRegisterTimer(registeredClientID: PCCardClientID; VAR lpNewTimerID: PCCardTimerID; delay: LONGINT): OSStatus; C;

{
 *  CSDeRegisterTimer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSDeRegisterTimer(timerID: PCCardTimerID): OSStatus; C;

{ Function prototypes for CardBus Config Space access}
{
 *  CSReadCardBusConfigSpace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSReadCardBusConfigSpace(vSocket: PCCardSocket; device: UInt32; configOffset: UInt32; VAR data: Byte; dataSize: UInt32): OSStatus; C;

{
 *  CSWriteCardBusConfigSpace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CSWriteCardBusConfigSpace(vSocket: PCCardSocket; device: UInt32; configOffset: UInt32; VAR data: Byte; dataSize: UInt32): OSStatus; C;

{------------------------------------------------------------------------------------
    Card Enabler Types
------------------------------------------------------------------------------------}
{$ENDC}  {CALL_NOT_IN_CARBON}

CONST
	kUnknownDeviceType			= 'unkn';						{  class-code = 0x00  }
	kSCSIDeviceType				= 'scsi';						{  class-code = 0x01, sub-class = 0x00  }
	kBlockDeviceType			= 'blok';						{  class-code = 0x01, sub-class = 0xXX  }
	kNetworkDeviceType			= 'netw';						{  class-code = 0x02  }
	kDisplayDeviceType			= 'dspl';						{  class-code = 0x03  }
	kMultimediaDeviceType		= 'mmdv';						{  class-code = 0x04  }
	kMemoryDeviceType			= 'mem ';						{  class-code = 0x05  }
	kBridgeDeviceType			= 'brdg';						{  class-code = 0x06  }
	kCommDeviceType				= 'comm';						{  class-code = 0x07  }
	kPeripheralDeviceType		= 'sysp';						{  class-code = 0x08  }
	kInputDeviceType			= 'inpt';						{  class-code = 0x09  }
	kDockingDeviceType			= 'dock';						{  class-code = 0x0A  }
	kProcessorDeviceType		= 'proc';						{  class-code = 0x0B  }
	kFirewireBusDeviceType		= 'firw';						{  class-code = 0x0C, sub-class = 0x00  }
	kACCESSBusDeviceType		= 'accs';						{  class-code = 0x0C, sub-class = 0x01  }
	kSSABusDeviceType			= 'ssa ';						{  class-code = 0x0C, sub-class = 0x02  }
	kUSBBusDeviceType			= 'usb ';						{  class-code = 0x0C, sub-class = 0x03  }
	kFibreBusDeviceType			= 'fibr';						{  class-code = 0x0C, sub-class = 0x04  }
	kByteDeviceType				= 'byte';						{  class-code = 0x??  }
	kSerialDeviceType			= 'ser ';						{  class-code = 0x??  }
	kParallelDeviceType			= 'parl';						{  class-code = 0x??  }
	kAIMSDeviceType				= 'aims';						{  class-code = 0x??  }


TYPE
	PCDeviceType						= OSType;

CONST
	kAttributeType				= 0;
	kMemoryType					= 1;
	kIOType						= 2;


TYPE
	PCCardMemoryType					= UInt32;

CONST
	kUnknown					= 'unkn';
	kPCCard16					= 'pc16';
	kCardBus					= 'cdbs';


TYPE
	PCCardArchitectureType				= OSType;

	{	------------------------------------------------------------------------------------
	  Plugin Dispatch Table
	------------------------------------------------------------------------------------	}

CONST
	kServiceTypePCCardEnabler	= 'card';
	kPCCardEnablerPluginVersion	= $00000001;
	kPCCardEnablerPluginCurrentVersion = $00000001;

	{	  Card Enabler Entrypoints	}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	CEValidateHardwareProc = FUNCTION({CONST}VAR cardRef: RegEntryID): OSStatus; C;
{$ELSEC}
	CEValidateHardwareProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEInitializeProc = FUNCTION({CONST}VAR cardRef: RegEntryID; replacingOld: BOOLEAN): OSStatus; C;
{$ELSEC}
	CEInitializeProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CECleanupProc = FUNCTION({CONST}VAR cardRef: RegEntryID; beingReplaced: BOOLEAN): OSStatus; C;
{$ELSEC}
	CECleanupProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEPowerManagementProc = FUNCTION({CONST}VAR lpCardEntry: RegEntryID; powerLevel: PCCardPowerOptions): OSStatus; C;
{$ELSEC}
	CEPowerManagementProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEHandleEventProc = FUNCTION({CONST}VAR cardRef: RegEntryID; theEvent: PCCardEvent): OSStatus; C;
{$ELSEC}
	CEHandleEventProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEGetCardInfoProc = FUNCTION({CONST}VAR cardRef: RegEntryID; VAR cardType: PCCardDevType; VAR cardSubType: PCCardSubType; cardName: StringPtr; vendorName: StringPtr): OSStatus; C;
{$ELSEC}
	CEGetCardInfoProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEAddCardPropertiesProc = FUNCTION({CONST}VAR cardRef: RegEntryID): OSStatus; C;
{$ELSEC}
	CEAddCardPropertiesProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEGetDeviceCountProc = FUNCTION({CONST}VAR cardRef: RegEntryID; VAR numberOfDevices: ItemCount): OSStatus; C;
{$ELSEC}
	CEGetDeviceCountProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEGetDeviceNameProc = FUNCTION(socketNumber: UInt32; deviceNumber: UInt32; deviceName: CStringPtr): OSStatus; C;
{$ELSEC}
	CEGetDeviceNameProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEGetDeviceCompatibleProc = FUNCTION({CONST}VAR deviceRef: RegEntryID; socketNumber: UInt32; deviceNumber: UInt32; name: CStringPtr): OSStatus; C;
{$ELSEC}
	CEGetDeviceCompatibleProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEGetDeviceTypeProc = FUNCTION({CONST}VAR deviceRef: RegEntryID; socketNumber: UInt32; deviceNumber: UInt32; VAR lpDeviceType: PCDeviceType): OSStatus; C;
{$ELSEC}
	CEGetDeviceTypeProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEGetDeviceTypeNameProc = FUNCTION({CONST}VAR deviceRef: RegEntryID; socketNumber: UInt32; deviceNumber: UInt32; name: CStringPtr): OSStatus; C;
{$ELSEC}
	CEGetDeviceTypeNameProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEAddDevicePropertiesProc = FUNCTION({CONST}VAR deviceRef: RegEntryID; device: UInt32): OSStatus; C;
{$ELSEC}
	CEAddDevicePropertiesProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEConfigureDeviceProc = FUNCTION({CONST}VAR deviceRef: RegEntryID; deviceNumber: UInt32): OSStatus; C;
{$ELSEC}
	CEConfigureDeviceProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEFinalizeDeviceProc = FUNCTION(socket: UInt32; device: UInt32; {CONST}VAR deviceRef: RegEntryID): OSStatus; C;
{$ELSEC}
	CEFinalizeDeviceProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEValidateCISProc = FUNCTION(socket: UInt32; device: UInt32; VAR lpCISChainCount: UInt32): OSStatus; C;
{$ELSEC}
	CEValidateCISProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEGetFirstTupleProc = FUNCTION(socket: UInt32; device: UInt32; lpTupleIterator: PCCardTupleIterator; desiredTuple: ByteParameter; lptupleData: UNIV Ptr; VAR lpTupleBufferSize: UInt32; VAR lpFoundTuple: Byte): OSStatus; C;
{$ELSEC}
	CEGetFirstTupleProc = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CEGetNextTupleProc = FUNCTION(lpTupleIterator: PCCardTupleIterator; desiredTuple: ByteParameter; lptupleData: UNIV Ptr; VAR lpTupleBufferSize: UInt32; VAR lpFoundTuple: Byte): OSStatus; C;
{$ELSEC}
	CEGetNextTupleProc = ProcPtr;
{$ENDC}

	PCCardEnablerPluginHeaderPtr = ^PCCardEnablerPluginHeader;
	PCCardEnablerPluginHeader = RECORD
		pluginDispatchTableVersion: UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
		reserved3:				UInt32;
	END;

	PCCardEnablerPluginDispatchTablePtr = ^PCCardEnablerPluginDispatchTable;
	PCCardEnablerPluginDispatchTable = RECORD
		header:					PCCardEnablerPluginHeader;
																		{  General functions }
		validateHardwareProc:	CEValidateHardwareProc;
		initializeProc:			CEInitializeProc;
		cleanUpProc:			CECleanupProc;
		setPCCardPowerLevel:	CEPowerManagementProc;
																		{  Card functions }
		handleEventProc:		CEHandleEventProc;
		getCardInfoProc:		CEGetCardInfoProc;
		addCardProperties:		CEAddCardPropertiesProc;
		getDeviceCount:			CEGetDeviceCountProc;
																		{  Device functions }
		getDeviceName:			CEGetDeviceNameProc;
		getDeviceCompatibleNames: CEGetDeviceCompatibleProc;
		getDeviceType:			CEGetDeviceTypeProc;
		getDeviceTypeName:		CEGetDeviceTypeNameProc;
		addDeviceProperties:	CEAddDevicePropertiesProc;
		configureDevice:		CEConfigureDeviceProc;
		finalizeDevice:			CEFinalizeDeviceProc;
																		{  Card Services Overrides... }
		validateCIS:			CEValidateCISProc;
		getFirstTuple:			CEGetFirstTupleProc;
		getNextTuple:			CEGetNextTupleProc;
																		{  InterruptHandlers... }
		cardInterruptHandlerFunction: InterruptHandler;
		cardInterruptEnableFunction: InterruptEnabler;
		cardInterruptDisableFunction: InterruptDisabler;
	END;

	{	------------------------------------------------------------------------------------
	    PC Card Enabler Utility calls exported by the Family
	------------------------------------------------------------------------------------	}
	{	  Generic Enabler Entrypoints	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  CEInitializeCard()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in PCCard 3.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION CEInitializeCard({CONST}VAR cardRef: RegEntryID; replacingOld: BOOLEAN): OSStatus; C;

{
 *  CEFinalizeCard()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEFinalizeCard({CONST}VAR cardRef: RegEntryID; beingReplaced: BOOLEAN): OSStatus; C;

{
 *  CEPowerManagement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEPowerManagement({CONST}VAR lpParentID: RegEntryID; powerLevel: PCCardPowerOptions): OSStatus; C;

{
 *  CEHandleCardEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEHandleCardEvent({CONST}VAR cardRef: RegEntryID; lTheCardEvent: PCCardEvent): OSStatus; C;

{
 *  CEGetCardInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEGetCardInfo({CONST}VAR cardRef: RegEntryID; VAR cardType: PCCardDevType; VAR cardSubType: PCCardSubType; cardName: StringPtr; vendorName: StringPtr): OSStatus; C;

{
 *  CEAddCardProperties()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEAddCardProperties({CONST}VAR cardRef: RegEntryID): OSStatus; C;

{
 *  CEGetDeviceCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEGetDeviceCount({CONST}VAR cardRef: RegEntryID; VAR numberOfDevices: ItemCount): OSStatus; C;

{  device functions }
{
 *  CEGetDeviceName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEGetDeviceName(socketNumber: UInt32; deviceNumber: UInt32; deviceName: CStringPtr): OSStatus; C;

{
 *  CEGetDeviceCompatibleNames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEGetDeviceCompatibleNames({CONST}VAR deviceRef: RegEntryID; socketNumber: UInt32; deviceNumber: UInt32; name: CStringPtr): OSStatus; C;

{
 *  CEGetDeviceType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEGetDeviceType({CONST}VAR deviceRef: RegEntryID; socketNumber: UInt32; deviceNumber: UInt32; VAR lpDeviceType: PCDeviceType): OSStatus; C;

{
 *  CEGetDeviceTypeName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEGetDeviceTypeName({CONST}VAR deviceRef: RegEntryID; socketNumber: UInt32; deviceNumber: UInt32; name: CStringPtr): OSStatus; C;

{
 *  CEAddDeviceProperties()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEAddDeviceProperties({CONST}VAR deviceRef: RegEntryID; deviceNumber: UInt32): OSStatus; C;

{
 *  CEConfigureDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEConfigureDevice({CONST}VAR deviceRef: RegEntryID; deviceNumber: UInt32): OSStatus; C;

{
 *  CEFinalizeDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEFinalizeDevice(socket: UInt32; device: UInt32; {CONST}VAR deviceRef: RegEntryID): OSStatus; C;


{  RegEntryID <-> socket number mapping functions}
{
 *  CEGetSocketAndDeviceFromRegEntry()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEGetSocketAndDeviceFromRegEntry({CONST}VAR lpNode: RegEntryID; VAR lpSocket: UInt32; VAR lpDevice: UInt32): OSStatus; C;

{
 *  CEGetPhysicalSocketNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEGetPhysicalSocketNumber({CONST}VAR socketRef: RegEntryID; {CONST}VAR lpDeviceEntry: RegEntryID; VAR lpPhysicalSocketNumber: UInt32): OSStatus; C;

{  Hardware Validation Utilities}
{
 *  CECompareCISTPL_VERS_1()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CECompareCISTPL_VERS_1({CONST}VAR cardRef: RegEntryID; majorVersion: ByteParameter; minorVersion: ByteParameter; manufacturer: ConstCStringPtr; productName: ConstCStringPtr; info1: ConstCStringPtr; info2: ConstCStringPtr; VAR identical: BOOLEAN): OSStatus; C;

{
 *  CECompareCISTPL_MANFID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CECompareCISTPL_MANFID({CONST}VAR cardRef: RegEntryID; manufacturerCode: UInt16; manufacturerInfo: UInt16; VAR identical: BOOLEAN): OSStatus; C;

{
 *  CECompareMemory()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CECompareMemory({CONST}VAR cardRef: RegEntryID; memType: PCCardMemoryType; offset: ByteCount; length: ByteCount; VAR dataToCompare: Byte; VAR identical: BOOLEAN): OSStatus; C;

{
 *  CEValidateCIS()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEValidateCIS(socket: UInt32; device: UInt32; VAR lpCISChainCount: UInt32): OSStatus; C;

{
 *  CEDefaultInterruptHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PCCard 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CEDefaultInterruptHandler(ISTmember: InterruptSetMember; refCon: UNIV Ptr; theIntCount: UInt32): InterruptMemberNumber; C;


{------------------------------------------------------------------------------------
    PC Card Customization Resources
------------------------------------------------------------------------------------}
{$ENDC}  {CALL_NOT_IN_CARBON}

CONST
	kPCCardCustomInfoResType	= 'pccd';
	kPCCardCustomInfoVersion	= 0;


TYPE
	PCCardCustomResourcePtr = ^PCCardCustomResource;
	PCCardCustomResource = RECORD
		version:				LONGINT;
		customIconID:			INTEGER;								{     ICN#, etc. resource ID }
		customStringsID:		INTEGER;								{     STR# resource ID }
		customTypeStringIndex:	INTEGER;
		customHelpStringIndex:	INTEGER;
		customAction:			OSType;
		customActionParam1:		LONGINT;
		customActionParam2:		LONGINT;
	END;

{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PCCardEnablerPluginIncludes}

{$ENDC} {__PCCARDENABLERPLUGIN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

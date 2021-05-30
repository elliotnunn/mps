{
     File:       USB.p
 
     Contains:   Public API for USB Services Library (and associated components)
 
     Version:    Technology: USB 1.4
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT USB;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __USB__}
{$SETC __USB__ := 1}

{$I+}
{$SETC USBIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}
{$IFC UNDEFINED __DEVICES__}
{$I Devices.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ ************* Constants ************* }


CONST
																{  Flags  }
	kUSBTaskTimeFlag			= 1;
	kUSBHubPower				= 2;
	kUSBPowerReset				= 4;
	kUSBHubReaddress			= 8;
	kUSBAddressRequest			= 16;
	kUSBReturnOnException		= 32;
	kUSBNo5SecTimeout			= 64;
	kUSBTimeout					= 128;
	kUSBNoDataTimeout			= 256;
	kUSBDebugAwareFlag			= 512;
	kUSBResetDescriptorCache	= 1024;

																{  Hub messages  }
	kUSBHubPortResetRequest		= 1;
	kUSBHubPortSuspendRequest	= 2;
	kUSBHubPortStatusRequest	= 3;

	kVendorID_AppleComputer		= $05AC;

	{	 ************* types ************* 	}


TYPE
	USBReference						= SInt32;
	USBDeviceRef						= USBReference;
	USBDeviceRefPtr						= ^USBDeviceRef;
	USBInterfaceRef						= USBReference;
	USBPipeRef							= USBReference;
	USBBusRef							= USBReference;
	USBPipeState						= UInt32;
	USBCount							= UInt32;
	USBFlags							= UInt32;
	USBRequest							= UInt8;
	USBDirection						= UInt8;
	USBRqRecipient						= UInt8;
	USBRqType							= UInt8;
	USBRqIndex							= UInt16;
	USBRqValue							= UInt16;


	usbControlBitsPtr = ^usbControlBits;
	usbControlBits = RECORD
		BMRequestType:			SInt8;
		BRequest:				SInt8;
		WValue:					USBRqValue;
		WIndex:					USBRqIndex;
		reserved4:				UInt16;
	END;

	USBIsocFramePtr = ^USBIsocFrame;
	USBIsocFrame = RECORD
		frStatus:				OSStatus;
		frReqCount:				UInt16;
		frActCount:				UInt16;
	END;


CONST
	kUSBMaxIsocFrameReqCount	= 1023;							{  maximum size (bytes) of any one Isoc frame }


TYPE
	usbIsocBitsPtr = ^usbIsocBits;
	usbIsocBits = RECORD
		FrameList:				USBIsocFramePtr;
		NumFrames:				UInt32;
	END;

	usbHubBitsPtr = ^usbHubBits;
	usbHubBits = RECORD
		Request:				UInt32;
		Spare:					UInt32;
	END;

	USBPBPtr = ^USBPB;
{$IFC TYPED_FUNCTION_POINTERS}
	USBCompletion = PROCEDURE(pb: USBPBPtr); C;
{$ELSEC}
	USBCompletion = ProcPtr;
{$ENDC}

	USBVariantBitsPtr = ^USBVariantBits;
	USBVariantBits = RECORD
		CASE INTEGER OF
		0: (
			cntl:				usbControlBits;
			);
		1: (
			isoc:				usbIsocBits;
			);
		2: (
			hub:				usbHubBits;
			);
	END;

	USBPB = PACKED RECORD
		qlink:					Ptr;
		qType:					UInt16;
		pbLength:				UInt16;
		pbVersion:				UInt16;
		reserved1:				UInt16;
		reserved2:				UInt32;
		usbStatus:				OSStatus;
		usbCompletion:			USBCompletion;
		usbRefcon:				UInt32;
		usbReference:			USBReference;
		usbBuffer:				Ptr;
		usbReqCount:			USBCount;
		usbActCount:			USBCount;
		usbFlags:				USBFlags;
		usb:					USBVariantBits;
		usbFrame:				UInt32;
		usbClassType:			UInt8;
		usbSubclass:			UInt8;
		usbProtocol:			UInt8;
		usbOther:				UInt8;
		reserved6:				UInt32;
		reserved7:				UInt16;
		reserved8:				UInt16;
	END;

	uslReqPtr = ^uslReq;
	uslReq = RECORD
		usbDirection:			SInt8;
		usbType:				SInt8;
		usbRecipient:			SInt8;
		usbRequest:				SInt8;
	END;



CONST
																{  BT 19Aug98, bump up to v1.10 for Isoc }
	kUSBCurrentPBVersion		= $0100;						{  v1.00 }
	kUSBIsocPBVersion			= $0109;						{  v1.10 }
	kUSBCurrentHubPB			= $0109;




	kUSBNoCallBack				= -1;



TYPE
	bcdUSB								= UInt8;

CONST
	kUSBControl					= 0;
	kUSBIsoc					= 1;
	kUSBBulk					= 2;
	kUSBInterrupt				= 3;
	kUSBAnyType					= $FF;

	{	 endpoint type 	}
	kUSBOut						= 0;
	kUSBIn						= 1;
	kUSBNone					= 2;
	kUSBAnyDirn					= 3;

	{	USBDirection	}
	kUSBStandard				= 0;
	kUSBClass					= 1;
	kUSBVendor					= 2;

	{	USBRqType	}
	kUSBDevice					= 0;
	kUSBInterface				= 1;
	kUSBEndpoint				= 2;
	kUSBOther					= 3;

	{	USBRqRecipient	}
	kUSBRqGetStatus				= 0;
	kUSBRqClearFeature			= 1;
	kUSBRqReserved1				= 2;
	kUSBRqSetFeature			= 3;
	kUSBRqReserved2				= 4;
	kUSBRqSetAddress			= 5;
	kUSBRqGetDescriptor			= 6;
	kUSBRqSetDescriptor			= 7;
	kUSBRqGetConfig				= 8;
	kUSBRqSetConfig				= 9;
	kUSBRqGetInterface			= 10;
	kUSBRqSetInterface			= 11;
	kUSBRqSyncFrame				= 12;

	{	USBRequest	}

	kUSBDeviceDesc				= 1;
	kUSBConfDesc				= 2;
	kUSBStringDesc				= 3;
	kUSBInterfaceDesc			= 4;
	kUSBEndpointDesc			= 5;
	kUSBHIDDesc					= $21;
	kUSBReportDesc				= $22;
	kUSBPhysicalDesc			= $23;
	kUSBHUBDesc					= $29;

	{	 descriptorType 	}

	kUSBFeatureDeviceRemoteWakeup = 1;
	kUSBFeatureEndpointStall	= 0;

	{	 Feature selectors 	}
	kUSBActive					= 0;							{  Pipe can accept new transactions }
	kUSBIdle					= 1;							{  Pipe will not accept new transactions }
	kUSBStalled					= 2;							{  An error occured on the pipe }
	kUSBSuspended				= 4;							{  Device is suspended }
	kUSBNoBandwidth				= 8;							{  (Isoc or Int) Pipe could not be initialised due to bandwidth constraint }

	kUSB100mAAvailable			= 50;
	kUSB500mAAvailable			= 250;
	kUSB100mA					= 50;
	kUSBAtrBusPowered			= $80;
	kUSBAtrSelfPowered			= $40;
	kUSBAtrRemoteWakeup			= $20;

	kUSBRel10					= $0100;

	kUSBDeviceDescriptorLength	= $12;
	kUSBInterfaceDescriptorLength = $09;
	kUSBConfigDescriptorLength	= $09;


TYPE
	USBDeviceDescriptorPtr = ^USBDeviceDescriptor;
	USBDeviceDescriptor = RECORD
		length:					SInt8;
		descType:				SInt8;
		usbRel:					UInt16;
		deviceClass:			SInt8;
		deviceSubClass:			SInt8;
		protocol:				SInt8;
		maxPacketSize:			SInt8;
		vendor:					UInt16;
		product:				UInt16;
		devRel:					UInt16;
		manuIdx:				SInt8;
		prodIdx:				SInt8;
		serialIdx:				SInt8;
		numConf:				SInt8;
	END;

	USBDescriptorHeaderPtr = ^USBDescriptorHeader;
	USBDescriptorHeader = RECORD
		length:					SInt8;
		descriptorType:			SInt8;
	END;

	USBConfigurationDescriptorPtr = ^USBConfigurationDescriptor;
	USBConfigurationDescriptor = PACKED RECORD
		length:					UInt8;
		descriptorType:			UInt8;
		totalLength:			UInt16;
		numInterfaces:			UInt8;
		configValue:			UInt8;
		configStrIndex:			UInt8;
		attributes:				UInt8;
		maxPower:				UInt8;
	END;

	USBInterfaceDescriptorPtr = ^USBInterfaceDescriptor;
	USBInterfaceDescriptor = PACKED RECORD
		length:					UInt8;
		descriptorType:			UInt8;
		interfaceNumber:		UInt8;
		alternateSetting:		UInt8;
		numEndpoints:			UInt8;
		interfaceClass:			UInt8;
		interfaceSubClass:		UInt8;
		interfaceProtocol:		UInt8;
		interfaceStrIndex:		UInt8;
	END;

	USBEndPointDescriptorPtr = ^USBEndPointDescriptor;
	USBEndPointDescriptor = PACKED RECORD
		length:					UInt8;
		descriptorType:			UInt8;
		endpointAddress:		UInt8;
		attributes:				UInt8;
		maxPacketSize:			UInt16;
		interval:				UInt8;
	END;

	USBHIDDescriptorPtr = ^USBHIDDescriptor;
	USBHIDDescriptor = PACKED RECORD
		descLen:				UInt8;
		descType:				UInt8;
		descVersNum:			UInt16;
		hidCountryCode:			UInt8;
		hidNumDescriptors:		UInt8;
		hidDescriptorType:		UInt8;
		hidDescriptorLengthLo:	UInt8;									{  can't make this a single 16bit value or the compiler will add a filler byte }
		hidDescriptorLengthHi:	UInt8;
	END;

	USBHIDReportDescPtr = ^USBHIDReportDesc;
	USBHIDReportDesc = PACKED RECORD
		hidDescriptorType:		UInt8;
		hidDescriptorLengthLo:	UInt8;									{  can't make this a single 16bit value or the compiler will add a filler byte }
		hidDescriptorLengthHi:	UInt8;
	END;

	USBHubPortStatusPtr = ^USBHubPortStatus;
	USBHubPortStatus = RECORD
		portFlags:				UInt16;									{  Port status flags  }
		portChangeFlags:		UInt16;									{  Port changed flags  }
	END;

	{	 ********* ProtoTypes *************** 	}
	{	 For dealing with endianisms 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  HostToUSBWord()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION HostToUSBWord(value: UInt16): UInt16; C;

{
 *  USBToHostWord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBToHostWord(value: UInt16): UInt16; C;

{
 *  HostToUSBLong()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HostToUSBLong(value: UInt32): UInt32; C;

{
 *  USBToHostLong()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBToHostLong(value: UInt32): UInt32; C;

{ Main prototypes }
{ Transfer commands }
{
 *  USBDeviceRequest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBDeviceRequest(VAR pb: USBPB): OSStatus; C;

{
 *  USBBulkWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBBulkWrite(VAR pb: USBPB): OSStatus; C;

{
 *  USBBulkRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBBulkRead(VAR pb: USBPB): OSStatus; C;

{
 *  USBIntRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBIntRead(VAR pb: USBPB): OSStatus; C;

{
 *  USBIntWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBIntWrite(VAR pb: USBPB): OSStatus; C;

{
 *  USBIsocRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBIsocRead(VAR pb: USBPB): OSStatus; C;

{
 *  USBIsocWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBIsocWrite(VAR pb: USBPB): OSStatus; C;

{ Pipe state control }
{
 *  USBClearPipeStallByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBClearPipeStallByReference(ref: USBPipeRef): OSStatus; C;

{
 *  USBAbortPipeByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBAbortPipeByReference(ref: USBReference): OSStatus; C;

{
 *  USBResetPipeByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBResetPipeByReference(ref: USBReference): OSStatus; C;

{
 *  USBSetPipeIdleByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBSetPipeIdleByReference(ref: USBPipeRef): OSStatus; C;

{
 *  USBSetPipeActiveByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBSetPipeActiveByReference(ref: USBPipeRef): OSStatus; C;

{
 *  USBClosePipeByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBClosePipeByReference(ref: USBPipeRef): OSStatus; C;

{
 *  USBGetPipeStatusByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBGetPipeStatusByReference(ref: USBReference; VAR state: USBPipeState): OSStatus; C;


{ Configuration services }
{
 *  USBFindNextInterface()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBFindNextInterface(VAR pb: USBPB): OSStatus; C;

{
 *  USBOpenDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBOpenDevice(VAR pb: USBPB): OSStatus; C;

{
 *  USBSetConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBSetConfiguration(VAR pb: USBPB): OSStatus; C;

{
 *  USBNewInterfaceRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBNewInterfaceRef(VAR pb: USBPB): OSStatus; C;

{
 *  USBDisposeInterfaceRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBDisposeInterfaceRef(VAR pb: USBPB): OSStatus; C;

{
 *  USBConfigureInterface()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBConfigureInterface(VAR pb: USBPB): OSStatus; C;

{
 *  USBFindNextPipe()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBFindNextPipe(VAR pb: USBPB): OSStatus; C;

{
 *  USBSetPipePolicy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBSetPipePolicy(VAR pb: USBPB): OSStatus; C;

{ Dealing with descriptors. }
{ Note most of this is temprorary }
{
 *  USBGetConfigurationDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBGetConfigurationDescriptor(VAR pb: USBPB): OSStatus; C;

{
 *  USBGetFullConfigurationDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBGetFullConfigurationDescriptor(VAR pb: USBPB): OSStatus; C;

{
 *  USBGetStringDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBGetStringDescriptor(VAR pb: USBPB): OSStatus; C;

{
 *  USBFindNextEndpointDescriptorImmediate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBFindNextEndpointDescriptorImmediate(VAR pb: USBPB): OSStatus; C;

{
 *  USBFindNextInterfaceDescriptorImmediate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBFindNextInterfaceDescriptorImmediate(VAR pb: USBPB): OSStatus; C;

{
 *  USBFindNextAssociatedDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBFindNextAssociatedDescriptor(VAR pb: USBPB): OSStatus; C;



{ Utility functions }
{
 *  USBResetDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBResetDevice(VAR pb: USBPB): OSStatus; C;

{
 *  USBPortStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBPortStatus(VAR pb: USBPB): OSStatus; C;

{
 *  USBSuspendDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBSuspendDevice(VAR pb: USBPB): OSStatus; C;

{
 *  USBResumeDeviceByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBResumeDeviceByReference(refIn: USBReference): OSStatus; C;

{
 *  USBGetBandwidthAvailableByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBGetBandwidthAvailableByReference(ref: USBReference; VAR avail: UInt32): OSStatus; C;

{
 *  USBGetFrameNumberImmediate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBGetFrameNumberImmediate(VAR pb: USBPB): OSStatus; C;

{
 *  USBDelay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBDelay(VAR pb: USBPB): OSStatus; C;

{
 *  USBSAbortQueuesByReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBSAbortQueuesByReference(ref: USBReference): OSStatus; C;

{
 *  USBAllocMem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBAllocMem(VAR pb: USBPB): OSStatus; C;

{
 *  USBDeallocMem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBDeallocMem(VAR pb: USBPB): OSStatus; C;

{ Expert interface functions }
{
 *  USBExpertInstallInterfaceDriver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBExpertInstallInterfaceDriver(ref: USBDeviceRef; desc: USBDeviceDescriptorPtr; interfacePtr: USBInterfaceDescriptorPtr; hubRef: USBReference; busPowerAvailable: UInt32): OSStatus; C;

{
 *  USBExpertRemoveInterfaceDriver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBExpertRemoveInterfaceDriver(ref: USBDeviceRef): OSStatus; C;

{
 *  USBExpertInstallDeviceDriver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBExpertInstallDeviceDriver(ref: USBDeviceRef; desc: USBDeviceDescriptorPtr; hubRef: USBReference; port: UInt32; busPowerAvailable: UInt32): OSStatus; C;

{
 *  USBExpertRemoveDeviceDriver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBExpertRemoveDeviceDriver(ref: USBDeviceRef): OSStatus; C;

{
 *  USBExpertStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBExpertStatus(ref: USBDeviceRef; pointer: UNIV Ptr; value: UInt32): OSStatus; C;

{
 *  USBExpertFatalError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBExpertFatalError(ref: USBDeviceRef; status: OSStatus; pointer: UNIV Ptr; value: UInt32): OSStatus; C;

{
 *  USBExpertNotify()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBFamilyExpertLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBExpertNotify(note: UNIV Ptr): OSStatus; C;

{
 *  USBExpertStatusLevel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBExpertStatusLevel(level: UInt32; ref: USBDeviceRef; status: StringPtr; value: UInt32): OSStatus; C;

{
 *  USBExpertGetStatusLevel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBExpertGetStatusLevel: UInt32; C;

{
 *  USBExpertSetStatusLevel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE USBExpertSetStatusLevel(level: UInt32); C;



{
 *  USBExpertSetDevicePowerStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBExpertSetDevicePowerStatus(ref: USBDeviceRef; reserved1: UInt32; reserved2: UInt32; powerStatus: UInt32; busPowerAvailable: UInt32; busPowerNeeded: UInt32): OSStatus; C;

{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kUSBDevicePower_PowerOK		= 0;
	kUSBDevicePower_BusPowerInsufficient = 1;
	kUSBDevicePower_BusPowerNotAllFeatures = 2;
	kUSBDevicePower_SelfPowerInsufficient = 3;
	kUSBDevicePower_SelfPowerNotAllFeatures = 4;
	kUSBDevicePower_HubPortOk	= 5;
	kUSBDevicePower_HubPortOverCurrent = 6;
	kUSBDevicePower_BusPoweredHubOnLowPowerPort = 7;
	kUSBDevicePower_BusPoweredHubToBusPoweredHub = 8;
	kUSBDevicePower_Reserved3	= 9;
	kUSBDevicePower_Reserved4	= 10;


	{	 For hubs only 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  USBHubAddDevice()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION USBHubAddDevice(VAR pb: USBPB): OSStatus; C;

{
 *  USBHubConfigurePipeZero()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBHubConfigurePipeZero(VAR pb: USBPB): OSStatus; C;

{
 *  USBHubSetAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBHubSetAddress(VAR pb: USBPB): OSStatus; C;

{
 *  USBHubDeviceRemoved()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBHubDeviceRemoved(VAR pb: USBPB): OSStatus; C;

{
 *  USBMakeBMRequestType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBMakeBMRequestType(direction: ByteParameter; reqtype: ByteParameter; recipient: ByteParameter): ByteParameter; C;

{
 *  USBControlRequest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBServicesLib 1.2 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBControlRequest(VAR pb: USBPB): OSStatus; C;

{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
	USBLocationID						= UInt32;

CONST
	kUSBLocationNibbleFormat	= 0;							{  Other values are reserved for future types (like when we have more than 16 ports per hub) }


	kNoDeviceRef				= -1;

	{  Status Level constants }
	{	
	Level 1: Fatal errors
	Level 2: General errors that may or may not effect operation
	Level 3: General driver messages.  The "AddStatus" call that drivers use comes through as a level 3.  This is also the default level at boot time.
	Level 4: Important status messages from the Expert and USL.
	Level 5: General status messages from the Expert and USL.
		}
	kUSBStatusLevelFatal		= 1;
	kUSBStatusLevelError		= 2;
	kUSBStatusLevelClient		= 3;
	kUSBStatusLevelGeneral		= 4;
	kUSBStatusLevelVerbose		= 5;

	{  Expert Notification Types }

TYPE
	USBNotificationType 		= UInt8;
CONST
	kNotifyAddDevice			= $00;
	kNotifyRemoveDevice			= $01;
	kNotifyAddInterface			= $02;
	kNotifyRemoveInterface		= $03;
	kNotifyGetDeviceDescriptor	= $04;
	kNotifyGetInterfaceDescriptor = $05;
	kNotifyGetNextDeviceByClass	= $06;
	kNotifyGetDriverConnectionID = $07;
	kNotifyInstallDeviceNotification = $08;
	kNotifyRemoveDeviceNotification = $09;
	kNotifyDeviceRefToBusRef	= $0A;
	kNotifyDriverNotify			= $0C;
	kNotifyParentNotify			= $0D;
	kNotifyAnyEvent				= $FF;
	kNotifyPowerState			= $17;
	kNotifyStatus				= $18;
	kNotifyFatalError			= $19;
	kNotifyStatusLevel			= $20;


TYPE
	USBDriverMessage					= USBNotificationType;
	{
	   USB Manager wildcard constants for USBGetNextDeviceByClass
	   and USBInstallDeviceNotification.
	}
	USBManagerWildcard 			= UInt16;
CONST
	kUSBAnyClass				= $FFFF;
	kUSBAnySubClass				= $FFFF;
	kUSBAnyProtocol				= $FFFF;
	kUSBAnyVendor				= $FFFF;
	kUSBAnyProduct				= $FFFF;




TYPE
	ExpertNotificationDataPtr = ^ExpertNotificationData;
	ExpertNotificationData = RECORD
		notification:			SInt8;
		filler:					SInt8;									{  unused due to 2-byte 68k alignment }
		deviceRef:				USBDeviceRefPtr;
		busPowerAvailable:		UInt32;
		data:					Ptr;
		info1:					UInt32;
		info2:					UInt32;
	END;

	{  Definition of function pointer passed in ExpertEntryProc }
{$IFC TYPED_FUNCTION_POINTERS}
	ExpertNotificationProcPtr = FUNCTION(pNotificationData: ExpertNotificationDataPtr): OSStatus; C;
{$ELSEC}
	ExpertNotificationProcPtr = ProcPtr;
{$ENDC}

	{  Definition of expert's callback installation function }
{$IFC TYPED_FUNCTION_POINTERS}
	ExpertEntryProcPtr = FUNCTION(pExpertNotify: ExpertNotificationProcPtr): OSStatus; C;
{$ELSEC}
	ExpertEntryProcPtr = ProcPtr;
{$ENDC}

	{  Device Notification Callback Routine }
{$IFC TYPED_FUNCTION_POINTERS}
	USBDeviceNotificationCallbackProcPtr = PROCEDURE(pb: UNIV Ptr); C;
{$ELSEC}
	USBDeviceNotificationCallbackProcPtr = ProcPtr;
{$ENDC}

	{  Device Notification Parameter Block }
	USBDeviceNotificationParameterBlockPtr = ^USBDeviceNotificationParameterBlock;
	USBDeviceNotificationParameterBlock = RECORD
		pbLength:				UInt16;
		pbVersion:				UInt16;
		usbDeviceNotification:	SInt8;
		reserved1:				SInt8;									{  needed because of 2-byte 68k alignment }
		usbDeviceRef:			USBDeviceRef;
		usbClass:				UInt16;
		usbSubClass:			UInt16;
		usbProtocol:			UInt16;
		usbVendor:				UInt16;
		usbProduct:				UInt16;
		result:					OSStatus;
		token:					UInt32;
		callback:				USBDeviceNotificationCallbackProcPtr;
		refcon:					UInt32;
	END;

	{  Definition of USBDriverNotificationCallback Routine }
{$IFC TYPED_FUNCTION_POINTERS}
	USBDriverNotificationCallbackPtr = PROCEDURE(status: OSStatus; refcon: UInt32); C;
{$ELSEC}
	USBDriverNotificationCallbackPtr = ProcPtr;
{$ENDC}

	{  Public Functions }
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  USBGetVersion()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in USBServicesLib 1.3 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION USBGetVersion: UInt32; C;

{
 *  USBGetNextDeviceByClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBGetNextDeviceByClass(VAR deviceRef: USBDeviceRef; VAR connID: CFragConnectionID; theClass: UInt16; theSubClass: UInt16; theProtocol: UInt16): OSStatus; C;

{
 *  USBGetDeviceDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBGetDeviceDescriptor(VAR deviceRef: USBDeviceRef; VAR deviceDescriptor: USBDeviceDescriptor; size: UInt32): OSStatus; C;

{
 *  USBGetInterfaceDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBGetInterfaceDescriptor(VAR interfaceRef: USBInterfaceRef; VAR interfaceDescriptor: USBInterfaceDescriptor; size: UInt32): OSStatus; C;

{
 *  USBGetDriverConnectionID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBGetDriverConnectionID(VAR deviceRef: USBDeviceRef; VAR connID: CFragConnectionID): OSStatus; C;

{
 *  USBInstallDeviceNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE USBInstallDeviceNotification(VAR pb: USBDeviceNotificationParameterBlock); C;

{
 *  USBRemoveDeviceNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBRemoveDeviceNotification(token: UInt32): OSStatus; C;

{
 *  USBDeviceRefToBusRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBDeviceRefToBusRef(VAR deviceRef: USBDeviceRef; VAR busRef: USBBusRef): OSStatus; C;

{
 *  USBDriverNotify()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBDriverNotify(reference: USBReference; mesg: ByteParameter; refcon: UInt32; callback: USBDriverNotificationCallbackPtr): OSStatus; C;

{
 *  USBExpertNotifyParent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBExpertNotifyParent(reference: USBReference; pointer: UNIV Ptr): OSStatus; C;

{
 *  USBAddDriverForFSSpec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBAddDriverForFSSpec(reference: USBReference; VAR fileSpec: FSSpec): OSStatus; C;

{
 *  USBAddShimFromDisk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBAddShimFromDisk(VAR shimFilePtr: FSSpec): OSStatus; C;

{
 *  USBReferenceToRegEntry()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBReferenceToRegEntry(VAR parentEntry: RegEntryID; parentDeviceRef: USBDeviceRef): OSStatus; C;

{
 *  USBConfigureADBShim()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in USBManagerLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBConfigureADBShim(inCommandID: UInt32; arg1: UNIV Ptr; arg2: UNIV Ptr): OSStatus; C;


{$ENDC}  {CALL_NOT_IN_CARBON}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	HIDInterruptProcPtr = PROCEDURE(refcon: UInt32; theData: UNIV Ptr); C;
{$ELSEC}
	HIDInterruptProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	HIDNotificationProcPtr = PROCEDURE(refcon: UInt32; reportSize: UInt32; theReport: UNIV Ptr; theInterfaceRef: USBReference); C;
{$ELSEC}
	HIDNotificationProcPtr = ProcPtr;
{$ENDC}

	{  HID Install Interrupt prototype }
{$IFC TYPED_FUNCTION_POINTERS}
	USBHIDInstallInterruptProcPtr = FUNCTION(pInterruptProc: HIDInterruptProcPtr; refcon: UInt32): OSStatus; C;
{$ELSEC}
	USBHIDInstallInterruptProcPtr = ProcPtr;
{$ENDC}

	{  HID Poll Device prototype }
{$IFC TYPED_FUNCTION_POINTERS}
	USBHIDPollDeviceProcPtr = FUNCTION: OSStatus; C;
{$ELSEC}
	USBHIDPollDeviceProcPtr = ProcPtr;
{$ENDC}

	{  HID Control Device prototype }
{$IFC TYPED_FUNCTION_POINTERS}
	USBHIDControlDeviceProcPtr = FUNCTION(theControlSelector: UInt32; theControlData: UNIV Ptr): OSStatus; C;
{$ELSEC}
	USBHIDControlDeviceProcPtr = ProcPtr;
{$ENDC}

	{  HID Get Device Info prototype }
{$IFC TYPED_FUNCTION_POINTERS}
	USBHIDGetDeviceInfoProcPtr = FUNCTION(theInfoSelector: UInt32; theInfo: UNIV Ptr): OSStatus; C;
{$ELSEC}
	USBHIDGetDeviceInfoProcPtr = ProcPtr;
{$ENDC}

	{  HID Enter Polled Mode prototype }
{$IFC TYPED_FUNCTION_POINTERS}
	USBHIDEnterPolledModeProcPtr = FUNCTION: OSStatus; C;
{$ELSEC}
	USBHIDEnterPolledModeProcPtr = ProcPtr;
{$ENDC}

	{  HID Exit Polled Mode prototype }
{$IFC TYPED_FUNCTION_POINTERS}
	USBHIDExitPolledModeProcPtr = FUNCTION: OSStatus; C;
{$ELSEC}
	USBHIDExitPolledModeProcPtr = ProcPtr;
{$ENDC}

	{  HID Install Notification prototype }
{$IFC TYPED_FUNCTION_POINTERS}
	USBHIDInstallNotificationProcPtr = FUNCTION(pNotificationProc: HIDNotificationProcPtr; refcon: UInt32): OSStatus; C;
{$ELSEC}
	USBHIDInstallNotificationProcPtr = ProcPtr;
{$ENDC}


CONST
	kHIDStandardDispatchVersion	= 0;
	kHIDReservedDispatchVersion	= 1;
	kHIDNotificationDispatchVersion = 2;
	kHIDCurrentDispatchVersion	= 2;



TYPE
	USBHIDRev2DispatchTablePtr = ^USBHIDRev2DispatchTable;
	USBHIDRev2DispatchTable = RECORD
		hidDispatchVersion:		UInt32;
		pUSBHIDInstallInterrupt: USBHIDInstallInterruptProcPtr;
		pUSBHIDPollDevice:		USBHIDPollDeviceProcPtr;
		pUSBHIDControlDevice:	USBHIDControlDeviceProcPtr;
		pUSBHIDGetDeviceInfo:	USBHIDGetDeviceInfoProcPtr;
		pUSBHIDEnterPolledMode:	USBHIDEnterPolledModeProcPtr;
		pUSBHIDExitPolledMode:	USBHIDExitPolledModeProcPtr;
		pUSBHIDInstallNotification: USBHIDInstallNotificationProcPtr;
	END;

	USBHIDModuleDispatchTablePtr = ^USBHIDModuleDispatchTable;
	USBHIDModuleDispatchTable = RECORD
		hidDispatchVersion:		UInt32;
		pUSBHIDInstallInterrupt: USBHIDInstallInterruptProcPtr;
		pUSBHIDPollDevice:		USBHIDPollDeviceProcPtr;
		pUSBHIDControlDevice:	USBHIDControlDeviceProcPtr;
		pUSBHIDGetDeviceInfo:	USBHIDGetDeviceInfoProcPtr;
		pUSBHIDEnterPolledMode:	USBHIDEnterPolledModeProcPtr;
		pUSBHIDExitPolledMode:	USBHIDExitPolledModeProcPtr;
	END;

	{	  Prototypes Tue, Mar 17, 1998 4:54:30 PM 	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  USBHIDInstallInterrupt()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION USBHIDInstallInterrupt(HIDInterruptFunction: HIDInterruptProcPtr; refcon: UInt32): OSStatus; C;

{
 *  USBHIDPollDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBHIDPollDevice: OSStatus; C;

{
 *  USBHIDControlDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBHIDControlDevice(theControlSelector: UInt32; theControlData: UNIV Ptr): OSStatus; C;

{
 *  USBHIDGetDeviceInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBHIDGetDeviceInfo(theInfoSelector: UInt32; theInfo: UNIV Ptr): OSStatus; C;

{
 *  USBHIDEnterPolledMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBHIDEnterPolledMode: OSStatus; C;

{
 *  USBHIDExitPolledMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBHIDExitPolledMode: OSStatus; C;

{
 *  USBHIDInstallNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION USBHIDInstallNotification(HIDNotificationFunction: HIDNotificationProcPtr; refcon: UInt32): OSStatus; C;

{
 *  HIDNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE HIDNotification(devicetype: UInt32; VAR NewHIDData: UInt8; VAR OldHIDData: UInt8); C;

{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kHIDRqGetReport				= 1;
	kHIDRqGetIdle				= 2;
	kHIDRqGetProtocol			= 3;
	kHIDRqSetReport				= 9;
	kHIDRqSetIdle				= 10;
	kHIDRqSetProtocol			= 11;

	kHIDRtInputReport			= 1;
	kHIDRtOutputReport			= 2;
	kHIDRtFeatureReport			= 3;

	kHIDBootProtocolValue		= 0;
	kHIDReportProtocolValue		= 1;

	kHIDKeyboardInterfaceProtocol = 1;
	kHIDMouseInterfaceProtocol	= 2;

	kHIDSetLEDStateByBits		= 1;
	kHIDSetLEDStateByBitMask	= 1;
	kHIDSetLEDStateByIDNumber	= 2;
	kHIDRemoveInterruptHandler	= 3;
	kHIDEnableDemoMode			= 4;
	kHIDDisableDemoMode			= 5;
	kHIDRemoveNotification		= $1000;

	kHIDGetLEDStateByBits		= 1;							{  not supported in 1.0 of keyboard module }
	kHIDGetLEDStateByBitMask	= 1;							{  not supported in 1.0 of keyboard module }
	kHIDGetLEDStateByIDNumber	= 2;
	kHIDGetDeviceCountryCode	= 3;							{  not supported in 1.0 HID modules }
	kHIDGetDeviceUnitsPerInch	= 4;							{  only supported in mouse HID module }
	kHIDGetInterruptHandler		= 5;
	kHIDGetCurrentKeys			= 6;							{  only supported in keyboard HID module }
	kHIDGetInterruptRefcon		= 7;
	kHIDGetVendorID				= 8;
	kHIDGetProductID			= 9;


	kNumLockLED					= 0;
	kCapsLockLED				= 1;
	kScrollLockLED				= 2;
	kComposeLED					= 3;
	kKanaLED					= 4;

	kNumLockLEDMask				= $01;
	kCapsLockLEDMask			= $02;
	kScrollLockLEDMask			= $04;
	kComposeLEDMask				= $08;
	kKanaLEDMask				= $10;

	kUSBCapsLockKey				= $39;
	kUSBNumLockKey				= $53;
	kUSBScrollLockKey			= $47;


TYPE
	USBMouseDataPtr = ^USBMouseData;
	USBMouseData = RECORD
		buttons:				UInt16;
		XDelta:					SInt16;
		YDelta:					SInt16;
	END;

	USBKeyboardDataPtr = ^USBKeyboardData;
	USBKeyboardData = RECORD
		keycount:				UInt16;
		usbkeycode:				ARRAY [0..31] OF UInt16;
	END;

	USBHIDDataPtr = ^USBHIDData;
	USBHIDData = RECORD
		CASE INTEGER OF
		0: (
			kbd:				USBKeyboardData;
			);
		1: (
			mouse:				USBMouseData;
			);
	END;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  StartCompoundClassDriver()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE StartCompoundClassDriver(device: USBDeviceRef; classID: UInt16; subClass: UInt16); C;

{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kUSBCompositeClass			= 0;
	kUSBAudioClass				= 1;
	kUSBCommClass				= 2;
	kUSBHIDClass				= 3;
	kUSBDisplayClass			= 4;
	kUSBPrintingClass			= 7;
	kUSBMassStorageClass		= 8;
	kUSBHubClass				= 9;
	kUSBDataClass				= 10;
	kUSBVendorSpecificClass		= $FF;

	kUSBCompositeSubClass		= 0;
	kUSBHubSubClass				= 1;
	kUSBPrinterSubclass			= 1;
	kUSBVendorSpecificSubClass	= $FF;

	kUSBHIDInterfaceClass		= $03;

	kUSBNoInterfaceSubClass		= $00;
	kUSBBootInterfaceSubClass	= $01;

	kUSBNoInterfaceProtocol		= $00;
	kUSBKeyboardInterfaceProtocol = $01;
	kUSBMouseInterfaceProtocol	= $02;
	kUSBVendorSpecificProtocol	= $FF;

	kUSBPrinterUnidirectionalProtocol = $01;
	kUSBPrinterBidirectionalProtocol = $02;


	kServiceCategoryUSB			= 'usb ';						{  USB }

	kUSBDriverFileType			= 'ndrv';
	kUSBDriverRsrcType			= 'usbd';
	kUSBShimRsrcType			= 'usbs';

	kTheUSBDriverDescriptionSignature = 'usbd';

	kInitialUSBDriverDescriptor	= 0;



TYPE
	USBDriverDescVersion				= UInt32;
	{   Driver Loading Options }
	USBDriverLoadingOptions 	= UInt32;
CONST
	kUSBDoNotMatchGenericDevice	= $00000001;					{  Driver's VendorID must match Device's VendorID }
	kUSBDoNotMatchInterface		= $00000002;					{  Do not load this driver as an interface driver. }
	kUSBProtocolMustMatch		= $00000004;					{  Do not load this driver if protocol field doesn't match. }
	kUSBInterfaceMatchOnly		= $00000008;					{  Only load this driver as an interface driver. }

	kClassDriverPluginVersion	= $00001100;




TYPE
	USBDeviceInfoPtr = ^USBDeviceInfo;
	USBDeviceInfo = RECORD
		usbVendorID:			UInt16;									{  USB Vendor ID }
		usbProductID:			UInt16;									{  USB Product ID. }
		usbDeviceReleaseNumber:	UInt16;									{  Release Number of Device }
		usbDeviceProtocol:		UInt16;									{  Protocol Info. }
	END;

	USBInterfaceInfoPtr = ^USBInterfaceInfo;
	USBInterfaceInfo = RECORD
		usbConfigValue:			SInt8;									{  Configuration Value }
		usbInterfaceNum:		SInt8;									{  Interface Number }
		usbInterfaceClass:		SInt8;									{  Interface Class }
		usbInterfaceSubClass:	SInt8;									{  Interface SubClass }
		usbInterfaceProtocol:	SInt8;									{  Interface Protocol }
	END;

	USBDriverTypePtr = ^USBDriverType;
	USBDriverType = RECORD
		nameInfoStr:			Str31;									{  Driver's name when loading into the Name Registry. }
		usbDriverClass:			SInt8;									{  USB Class this driver belongs to. }
		usbDriverSubClass:		SInt8;									{  Module type }
		usbDriverVersion:		NumVersion;								{  Class driver version number. }
	END;

	USBDriverDescriptionPtr = ^USBDriverDescription;
	USBDriverDescription = RECORD
		usbDriverDescSignature:	OSType;									{  Signature field of this structure. }
		usbDriverDescVersion:	USBDriverDescVersion;					{  Version of this data structure. }
		usbDeviceInfo:			USBDeviceInfo;							{  Product & Vendor Info }
		usbInterfaceInfo:		USBInterfaceInfo;						{  Interface info }
		usbDriverType:			USBDriverType;							{  Driver Info. }
		usbDriverLoadingOptions: USBDriverLoadingOptions;				{  Options for class driver loading. }
	END;

	{
	   Dispatch Table
	   Definition of class driver's HW Validation proc.
	}
{$IFC TYPED_FUNCTION_POINTERS}
	USBDValidateHWProcPtr = FUNCTION(device: USBDeviceRef; pDesc: USBDeviceDescriptorPtr): OSStatus; C;
{$ELSEC}
	USBDValidateHWProcPtr = ProcPtr;
{$ENDC}

	{
	   Definition of class driver's device initialization proc.
	   Called if the driver is being loaded for a device
	}
{$IFC TYPED_FUNCTION_POINTERS}
	USBDInitializeDeviceProcPtr = FUNCTION(device: USBDeviceRef; pDesc: USBDeviceDescriptorPtr; busPowerAvailable: UInt32): OSStatus; C;
{$ELSEC}
	USBDInitializeDeviceProcPtr = ProcPtr;
{$ENDC}

	{  Definition of class driver's interface initialization proc. }
{$IFC TYPED_FUNCTION_POINTERS}
	USBDInitializeInterfaceProcPtr = FUNCTION(interfaceNum: UInt32; pInterface: USBInterfaceDescriptorPtr; pDevice: USBDeviceDescriptorPtr; interfaceRef: USBInterfaceRef): OSStatus; C;
{$ELSEC}
	USBDInitializeInterfaceProcPtr = ProcPtr;
{$ENDC}

	{  Definition of class driver's finalization proc. }
{$IFC TYPED_FUNCTION_POINTERS}
	USBDFinalizeProcPtr = FUNCTION(device: USBDeviceRef; pDesc: USBDeviceDescriptorPtr): OSStatus; C;
{$ELSEC}
	USBDFinalizeProcPtr = ProcPtr;
{$ENDC}

	USBDriverNotification 		= UInt32;
CONST
	kNotifySystemSleepRequest	= $00000001;
	kNotifySystemSleepDemand	= $00000002;
	kNotifySystemSleepWakeUp	= $00000003;
	kNotifySystemSleepRevoke	= $00000004;
	kNotifyHubEnumQuery			= $00000006;
	kNotifyChildMessage			= $00000007;
	kNotifyExpertTerminating	= $00000008;
	kNotifyDriverBeingRemoved	= $0000000B;
	kNotifyAllowROMDriverRemoval = $0000000E;

	{
	   Definition of driver's notification proc.      
	   Added refcon for 1.1 version of dispatch table
	}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	USBDDriverNotifyProcPtr = FUNCTION(notification: USBDriverNotification; pointer: UNIV Ptr; refcon: UInt32): OSStatus; C;
{$ELSEC}
	USBDDriverNotifyProcPtr = ProcPtr;
{$ENDC}

	USBClassDriverPluginDispatchTablePtr = ^USBClassDriverPluginDispatchTable;
	USBClassDriverPluginDispatchTable = RECORD
		pluginVersion:			UInt32;
		validateHWProc:			USBDValidateHWProcPtr;					{  Proc for driver to verify proper HW }
		initializeDeviceProc:	USBDInitializeDeviceProcPtr;			{  Proc that initializes the class driver. }
		initializeInterfaceProc: USBDInitializeInterfaceProcPtr;		{  Proc that initializes a particular interface in the class driver. }
		finalizeProc:			USBDFinalizeProcPtr;					{  Proc that finalizes the class driver. }
		notificationProc:		USBDDriverNotifyProcPtr;				{  Proc to pass notifications to the driver. }
	END;

	{  Shim Defines }

CONST
	kTheUSBShimDescriptionSignature = 'usbs';


TYPE
	USBShimDescVersion 			= UInt32;
CONST
	kCurrentUSBShimDescVers		= $0100;

	{   Shim Loading Options }

TYPE
	USBShimLoadingOptions 		= UInt32;
CONST
	kUSBRegisterShimAsSharedLibrary = $00000001;				{  Driver's VendorID must match Device's VendorID }


TYPE
	USBShimDescriptionPtr = ^USBShimDescription;
	USBShimDescription = RECORD
		usbShimDescSignature:	OSType;									{  Signature field of this structure. }
		usbShimDescVersion:		USBShimDescVersion;						{  Version of this data structure. }
		usbDriverLoadingOptions: USBShimLoadingOptions;					{  Options for shim loading. }
		libraryName:			Str63;									{  For optional shared library registration }
	END;

	{  Hub defines }


CONST
	kUSBHubDescriptorType		= $29;

																{  Hub features  }
	kUSBHubLocalPowerChangeFeature = 0;
	kUSBHubOverCurrentChangeFeature = 1;						{  port features  }
	kUSBHubPortConnectionFeature = 0;
	kUSBHubPortEnableFeature	= 1;
	kUSBHubPortSuspendFeature	= 2;
	kUSBHubPortOverCurrentFeature = 3;
	kUSBHubPortResetFeature		= 4;
	kUSBHubPortPowerFeature		= 8;
	kUSBHubPortLowSpeedFeature	= 9;
	kUSBHubPortConnectionChangeFeature = 16;
	kUSBHubPortEnableChangeFeature = 17;
	kUSBHubPortSuspendChangeFeature = 18;
	kUSBHubPortOverCurrentChangeFeature = 19;
	kUSBHubPortResetChangeFeature = 20;


	kHubPortConnection			= 1;
	kHubPortEnabled				= 2;
	kHubPortSuspend				= 4;
	kHubPortOverCurrent			= 8;
	kHubPortBeingReset			= 16;
	kHubPortPower				= $0100;
	kHubPortSpeed				= $0200;

	kHubLocalPowerStatus		= 1;
	kHubOverCurrentIndicator	= 2;
	kHubLocalPowerStatusChange	= 1;
	kHubOverCurrentIndicatorChange = 2;

	off							= false;
	on							= true;



TYPE
	hubDescriptorPtr = ^hubDescriptor;
	hubDescriptor = PACKED RECORD
																		{  See usbDoc pg 250??  }
		dummy:					UInt8;									{  to align charcteristics  }
		length:					UInt8;
		hubType:				UInt8;
		numPorts:				UInt8;
		characteristics:		UInt16;
		powerOnToGood:			UInt8;									{  Port settling time, in 2ms  }
		hubCurrent:				UInt8;
																		{  These are received packed, will have to be unpacked  }
		removablePortFlags:		PACKED ARRAY [0..7] OF UInt8;
		pwrCtlPortFlags:		PACKED ARRAY [0..7] OF UInt8;
	END;



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := USBIncludes}

{$ENDC} {__USB__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

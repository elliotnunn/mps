{
     File:       HID.p
 
     Contains:   Definition of the interfaces to the HIDLib shared library and
 
     Version:    Technology: HID 1.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT HID;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __HID__}
{$SETC __HID__ := 1}

{$I+}
{$SETC HIDIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
   
    Interfaces for HIDLib
}

{  types of HID reports (input, output, feature) }

CONST
	kHIDInputReport				= 1;
	kHIDOutputReport			= 2;
	kHIDFeatureReport			= 3;
	kHIDUnknownReport			= 255;

	{  constants used in HIDButtonCapabilities and HIDValueCapabilities structures }
																{  While HIDButtonCaps and HIDValueCaps have no version #, they can be }
																{  thought of as version 1 of HIDButtonCapabilities and HIDValueCapabilities. }
	kHIDCurrentCapabilitiesPBVersion = 2;

	{  flags passed to HIDOpenReportDescriptor }
	kHIDFlag_StrictErrorChecking = $00000001;


TYPE
	HIDReportType						= UInt32;
	HIDUsage							= UInt32;
	HIDPreparsedDataRef    = ^LONGINT; { an opaque 32-bit type }
	HIDPreparsedDataRefPtr = ^HIDPreparsedDataRef;  { when a VAR xx:HIDPreparsedDataRef parameter can be nil, it is changed to xx: HIDPreparsedDataRefPtr }
	HIDUsageAndPagePtr = ^HIDUsageAndPage;
	HIDUsageAndPage = RECORD
		usage:					HIDUsage;
		usagePage:				HIDUsage;
	END;

	HIDCapsPtr = ^HIDCaps;
	HIDCaps = RECORD
		usage:					HIDUsage;
		usagePage:				HIDUsage;
		inputReportByteLength:	ByteCount;
		outputReportByteLength:	ByteCount;
		featureReportByteLength: ByteCount;
		numberCollectionNodes:	UInt32;
		numberInputButtonCaps:	UInt32;
		numberInputValueCaps:	UInt32;
		numberOutputButtonCaps:	UInt32;
		numberOutputValueCaps:	UInt32;
		numberFeatureButtonCaps: UInt32;
		numberFeatureValueCaps:	UInt32;
	END;

	HIDCapabilitiesPtr = ^HIDCapabilities;
	HIDCapabilities = RECORD
		usage:					HIDUsage;
		usagePage:				HIDUsage;
		inputReportByteLength:	ByteCount;
		outputReportByteLength:	ByteCount;
		featureReportByteLength: ByteCount;
		numberCollectionNodes:	UInt32;
		numberInputButtonCaps:	UInt32;
		numberInputValueCaps:	UInt32;
		numberOutputButtonCaps:	UInt32;
		numberOutputValueCaps:	UInt32;
		numberFeatureButtonCaps: UInt32;
		numberFeatureValueCaps:	UInt32;
	END;

	HIDCollectionNodePtr = ^HIDCollectionNode;
	HIDCollectionNode = RECORD
		collectionUsage:		HIDUsage;
		collectionUsagePage:	HIDUsage;
		parent:					UInt32;
		numberOfChildren:		UInt32;
		nextSibling:			UInt32;
		firstChild:				UInt32;
	END;

	HIDButtonCapsPtr = ^HIDButtonCaps;
	HIDButtonCaps = RECORD
		usagePage:				HIDUsage;
		reportID:				UInt32;
		bitField:				UInt32;
		collection:				UInt32;
		collectionUsage:		HIDUsage;
		collectionUsagePage:	HIDUsage;
		isRange:				BOOLEAN;
		isStringRange:			BOOLEAN;
		isDesignatorRange:		BOOLEAN;
		isAbsolute:				BOOLEAN;
		CASE INTEGER OF
		0: (
			usageMin:			HIDUsage;
			usageMax:			HIDUsage;
			stringMin:			UInt32;
			stringMax:			UInt32;
			designatorMin:		UInt32;
			designatorMax:		UInt32;
		   );
		1: (
			usage:				HIDUsage;
			reserved1:			HIDUsage;
			stringIndex:		UInt32;
			reserved2:			UInt32;
			designatorIndex:	UInt32;
			reserved3:			UInt32;
		   );
	END;

	HIDButtonCapabilitiesPtr = ^HIDButtonCapabilities;
	HIDButtonCapabilities = RECORD
		usagePage:				HIDUsage;
		reportID:				UInt32;
		bitField:				UInt32;
		collection:				UInt32;
		collectionUsage:		HIDUsage;
		collectionUsagePage:	HIDUsage;
		isRange:				BOOLEAN;
		isStringRange:			BOOLEAN;
		isDesignatorRange:		BOOLEAN;
		isAbsolute:				BOOLEAN;
		unitExponent:			SInt32;
		units:					SInt32;
		reserved:				UInt32;
		pbVersion:				UInt32;
		CASE INTEGER OF
		0: (
			usageMin:			HIDUsage;
			usageMax:			HIDUsage;
			stringMin:			UInt32;
			stringMax:			UInt32;
			designatorMin:		UInt32;
			designatorMax:		UInt32;
		   );
		1: (
			usage:				HIDUsage;
			reserved1:			HIDUsage;
			stringIndex:		UInt32;
			reserved2:			UInt32;
			designatorIndex:	UInt32;
			reserved3:			UInt32;
		   );
	END;

	HIDValueCapsPtr = ^HIDValueCaps;
	HIDValueCaps = RECORD
		usagePage:				HIDUsage;
		reportID:				UInt32;
		bitField:				UInt32;
		collection:				UInt32;
		collectionUsage:		HIDUsage;
		collectionUsagePage:	HIDUsage;
		isRange:				BOOLEAN;
		isStringRange:			BOOLEAN;
		isDesignatorRange:		BOOLEAN;
		isAbsolute:				BOOLEAN;
		bitSize:				UInt32;
		reportCount:			UInt32;
		logicalMin:				SInt32;
		logicalMax:				SInt32;
		physicalMin:			SInt32;
		physicalMax:			SInt32;
		CASE INTEGER OF
		0: (
			usageMin:			HIDUsage;
			usageMax:			HIDUsage;
			stringMin:			UInt32;
			stringMax:			UInt32;
			designatorMin:		UInt32;
			designatorMax:		UInt32;
		   );
		1: (
			usage:				HIDUsage;
			reserved1:			HIDUsage;
			stringIndex:		UInt32;
			reserved2:			UInt32;
			designatorIndex:	UInt32;
			reserved3:			UInt32;
		   );
	END;

	HIDValueCapabilitiesPtr = ^HIDValueCapabilities;
	HIDValueCapabilities = RECORD
		usagePage:				HIDUsage;
		reportID:				UInt32;
		bitField:				UInt32;
		collection:				UInt32;
		collectionUsage:		HIDUsage;
		collectionUsagePage:	HIDUsage;
		isRange:				BOOLEAN;
		isStringRange:			BOOLEAN;
		isDesignatorRange:		BOOLEAN;
		isAbsolute:				BOOLEAN;
		bitSize:				UInt32;
		reportCount:			UInt32;
		logicalMin:				SInt32;
		logicalMax:				SInt32;
		physicalMin:			SInt32;
		physicalMax:			SInt32;
		unitExponent:			SInt32;
		units:					SInt32;
		reserved:				UInt32;
		pbVersion:				UInt32;
		CASE INTEGER OF
		0: (
			usageMin:			HIDUsage;
			usageMax:			HIDUsage;
			stringMin:			UInt32;
			stringMax:			UInt32;
			designatorMin:		UInt32;
			designatorMax:		UInt32;
		   );
		1: (
			usage:				HIDUsage;
			reserved1:			HIDUsage;
			stringIndex:		UInt32;
			reserved2:			UInt32;
			designatorIndex:	UInt32;
			reserved3:			UInt32;
		   );
	END;

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  HIDGetHIDLibVersion()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in HIDLib 1.4.3 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION HIDGetHIDLibVersion: UInt32; C;

{
 *  HIDOpenReportDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDOpenReportDescriptor(hidReportDescriptor: UNIV Ptr; descriptorLength: ByteCount; VAR preparsedDataRef: HIDPreparsedDataRef; flags: UInt32): OSStatus; C;

{
 *  HIDCloseReportDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDCloseReportDescriptor(preparsedDataRef: HIDPreparsedDataRef): OSStatus; C;


{
 *  HIDGetCaps()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetCaps(preparsedDataRef: HIDPreparsedDataRef; capabilities: HIDCapsPtr): OSStatus; C;

{
 *  HIDGetCapabilities()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.4.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetCapabilities(preparsedDataRef: HIDPreparsedDataRef; capabilities: HIDCapabilitiesPtr): OSStatus; C;

{
 *  HIDGetCollectionNodes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetCollectionNodes(collectionNodes: HIDCollectionNodePtr; VAR collectionNodesSize: UInt32; preparsedDataRef: HIDPreparsedDataRef): OSStatus; C;

{
 *  HIDGetButtonCaps()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetButtonCaps(reportType: HIDReportType; buttonCaps: HIDButtonCapsPtr; VAR buttonCapsSize: UInt32; preparsedDataRef: HIDPreparsedDataRef): OSStatus; C;

{
 *  HIDGetButtonCapabilities()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.4.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetButtonCapabilities(reportType: HIDReportType; buttonCaps: HIDButtonCapabilitiesPtr; VAR buttonCapsSize: UInt32; preparsedDataRef: HIDPreparsedDataRef): OSStatus; C;

{
 *  HIDGetValueCaps()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetValueCaps(reportType: HIDReportType; valueCaps: HIDValueCapsPtr; VAR valueCapsSize: UInt32; preparsedDataRef: HIDPreparsedDataRef): OSStatus; C;

{
 *  HIDGetValueCapabilities()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.4.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetValueCapabilities(reportType: HIDReportType; valueCaps: HIDValueCapabilitiesPtr; VAR valueCapsSize: UInt32; preparsedDataRef: HIDPreparsedDataRef): OSStatus; C;

{
 *  HIDGetSpecificButtonCaps()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetSpecificButtonCaps(reportType: HIDReportType; usagePage: HIDUsage; collection: UInt32; usage: HIDUsage; buttonCaps: HIDButtonCapsPtr; VAR buttonCapsSize: UInt32; preparsedDataRef: HIDPreparsedDataRef): OSStatus; C;

{
 *  HIDGetSpecificButtonCapabilities()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.4.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetSpecificButtonCapabilities(reportType: HIDReportType; usagePage: HIDUsage; collection: UInt32; usage: HIDUsage; buttonCaps: HIDButtonCapabilitiesPtr; VAR buttonCapsSize: UInt32; preparsedDataRef: HIDPreparsedDataRef): OSStatus; C;

{
 *  HIDGetSpecificValueCaps()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetSpecificValueCaps(reportType: HIDReportType; usagePage: HIDUsage; collection: UInt32; usage: HIDUsage; valueCaps: HIDValueCapsPtr; VAR valueCapsSize: UInt32; preparsedDataRef: HIDPreparsedDataRef): OSStatus; C;

{
 *  HIDGetSpecificValueCapabilities()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.4.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetSpecificValueCapabilities(reportType: HIDReportType; usagePage: HIDUsage; collection: UInt32; usage: HIDUsage; valueCaps: HIDValueCapabilitiesPtr; VAR valueCapsSize: UInt32; preparsedDataRef: HIDPreparsedDataRef): OSStatus; C;

{
 *  HIDGetNextButtonInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetNextButtonInfo(reportType: HIDReportType; usagePage: HIDUsage; usage: HIDUsage; VAR collection: UInt32; VAR reportID: UInt8; preparsedDataRef: HIDPreparsedDataRef): OSStatus; C;

{
 *  HIDGetNextUsageValueInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetNextUsageValueInfo(reportType: HIDReportType; usagePage: HIDUsage; usage: HIDUsage; VAR collection: UInt32; VAR reportID: UInt8; preparsedDataRef: HIDPreparsedDataRef): OSStatus; C;

{
 *  HIDMaxUsageListLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDMaxUsageListLength(reportType: HIDReportType; usagePage: HIDUsage; preparsedDataRef: HIDPreparsedDataRef): UInt32; C;

{
 *  HIDGetReportLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetReportLength(reportType: HIDReportType; reportID: ByteParameter; VAR reportLength: ByteCount; preparsedDataRef: HIDPreparsedDataRef): OSStatus; C;

{
 *  HIDInitReport()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.4 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDInitReport(reportType: HIDReportType; reportID: ByteParameter; preparsedDataRef: HIDPreparsedDataRef; report: UNIV Ptr; reportLength: ByteCount): OSStatus; C;


{
 *  HIDGetButtons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetButtons(reportType: HIDReportType; collection: UInt32; usageList: HIDUsageAndPagePtr; VAR usageListSize: UInt32; preparsedDataRef: HIDPreparsedDataRef; report: UNIV Ptr; reportLength: ByteCount): OSStatus; C;

{
 *  HIDGetButtonsOnPage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetButtonsOnPage(reportType: HIDReportType; usagePage: HIDUsage; collection: UInt32; VAR usageList: HIDUsage; VAR usageListSize: UInt32; preparsedDataRef: HIDPreparsedDataRef; report: UNIV Ptr; reportLength: ByteCount): OSStatus; C;

{
 *  HIDGetScaledUsageValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetScaledUsageValue(reportType: HIDReportType; usagePage: HIDUsage; collection: UInt32; usage: HIDUsage; VAR usageValue: SInt32; preparsedDataRef: HIDPreparsedDataRef; report: UNIV Ptr; reportLength: ByteCount): OSStatus; C;

{
 *  HIDGetUsageValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetUsageValue(reportType: HIDReportType; usagePage: HIDUsage; collection: UInt32; usage: HIDUsage; VAR usageValue: SInt32; preparsedDataRef: HIDPreparsedDataRef; report: UNIV Ptr; reportLength: ByteCount): OSStatus; C;

{
 *  HIDGetUsageValueArray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDGetUsageValueArray(reportType: HIDReportType; usagePage: HIDUsage; collection: UInt32; usage: HIDUsage; VAR usageValueBuffer: Byte; usageValueBufferSize: ByteCount; preparsedDataRef: HIDPreparsedDataRef; report: UNIV Ptr; reportLength: ByteCount): OSStatus; C;


{
 *  HIDSetButton()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDSetButton(reportType: HIDReportType; usagePage: HIDUsage; collection: UInt32; usage: HIDUsage; preparsedDataRef: HIDPreparsedDataRef; report: UNIV Ptr; reportLength: ByteCount): OSStatus; C;

{
 *  HIDSetButtons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDSetButtons(reportType: HIDReportType; usagePage: HIDUsage; collection: UInt32; VAR usageList: HIDUsage; VAR usageListSize: UInt32; preparsedDataRef: HIDPreparsedDataRef; report: UNIV Ptr; reportLength: ByteCount): OSStatus; C;

{
 *  HIDSetScaledUsageValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDSetScaledUsageValue(reportType: HIDReportType; usagePage: HIDUsage; collection: UInt32; usage: HIDUsage; usageValue: SInt32; preparsedDataRef: HIDPreparsedDataRef; report: UNIV Ptr; reportLength: ByteCount): OSStatus; C;

{
 *  HIDSetUsageValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDSetUsageValue(reportType: HIDReportType; usagePage: HIDUsage; collection: UInt32; usage: HIDUsage; usageValue: SInt32; preparsedDataRef: HIDPreparsedDataRef; report: UNIV Ptr; reportLength: ByteCount): OSStatus; C;

{
 *  HIDSetUsageValueArray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDSetUsageValueArray(reportType: HIDReportType; usagePage: HIDUsage; collection: UInt32; usage: HIDUsage; VAR usageValueBuffer: Byte; usageValueBufferLength: ByteCount; preparsedDataRef: HIDPreparsedDataRef; report: UNIV Ptr; reportLength: ByteCount): OSStatus; C;

{
 *  HIDUsageListDifference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HIDLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HIDUsageListDifference(VAR previousUsageList: HIDUsage; VAR currentUsageList: HIDUsage; VAR breakUsageList: HIDUsage; VAR makeUsageList: HIDUsage; usageListsSize: UInt32): OSStatus; C;

{
   
    Interfaces for a HID device driver
}

{  these are the constants to be passed to HIDGetDeviceInfo }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kHIDGetInfo_VendorID		= 1;
	kHIDGetInfo_ProductID		= 2;
	kHIDGetInfo_VersionNumber	= 3;
	kHIDGetInfo_InterfaceRef	= 4;
	kHIDGetInfo_MaxReportSize	= $10;
	kHIDGetInfo_GetManufacturerString = $0100;
	kHIDGetInfo_GetProductString = $0101;
	kHIDGetInfo_GetSerialNumberString = $0102;
	kHIDGetInfo_VendorSpecificStart = $00010000;

	{  these are the valid permissions to pass to HIDOpenDevice }
	kHIDPerm_ReadOnly			= $0001;
	kHIDPerm_ReadWriteShared	= $0003;
	kHIDPerm_ReadWriteExclusive	= $0013;

	{  these are flags used in HIDInstallReportHandler }
	kHIDFlag_CallbackIsResident	= $0001;


	{  these are the constants to be passed to HIDControlDevice }
	kHIDVendorSpecificControlStart = $00010000;

	{  these constant versions are used in the HIDDeviceDispatchTable structure }
	kHIDCurrentDispatchTableVersion = 3;
	kHIDOldestCompatableDispatchTableVersion = 1;
	kHIDDispatchTableVersion1	= 1;
	kHIDDispatchTableVersion2	= 2;
	kHIDDispatchTableVersion1OldestCompatible = 1;


TYPE
	HIDDeviceConnectionRef    = ^LONGINT; { an opaque 32-bit type }
	HIDDeviceConnectionRefPtr = ^HIDDeviceConnectionRef;  { when a VAR xx:HIDDeviceConnectionRef parameter can be nil, it is changed to xx: HIDDeviceConnectionRefPtr }
	{  HIDGetDeviceInfo is used to get specific information about a HID Device }
{$IFC TYPED_FUNCTION_POINTERS}
	HIDGetDeviceInfoProcPtr = FUNCTION(inInfoSelector: UInt32; outInfo: UNIV Ptr; VAR ioSize: ByteCount): OSStatus; C;
{$ELSEC}
	HIDGetDeviceInfoProcPtr = ProcPtr;
{$ENDC}

	{  HIDGetHIDDescriptor is used to get a specific HID descriptor from a HID device (such as a report descriptor) }
{$IFC TYPED_FUNCTION_POINTERS}
	HIDGetHIDDescriptorProcPtr = FUNCTION(inDescriptorType: UInt32; inDescriptorIndex: UInt32; outDescriptor: UNIV Ptr; VAR ioBufferSize: UInt32): OSStatus; C;
{$ELSEC}
	HIDGetHIDDescriptorProcPtr = ProcPtr;
{$ENDC}

	{  You must first 'open' a device before using it }
{$IFC TYPED_FUNCTION_POINTERS}
	HIDOpenDeviceProcPtr = FUNCTION(VAR outConnectionRef: HIDDeviceConnectionRef; permissions: UInt32; reserved: UInt32): OSStatus; C;
{$ELSEC}
	HIDOpenDeviceProcPtr = ProcPtr;
{$ENDC}

	{  When finished, 'close' a device }
{$IFC TYPED_FUNCTION_POINTERS}
	HIDCloseDeviceProcPtr = FUNCTION(inConnectionRef: HIDDeviceConnectionRef): OSStatus; C;
{$ELSEC}
	HIDCloseDeviceProcPtr = ProcPtr;
{$ENDC}

	{  User provided ProcPtr to be called when HID report is received }
{$IFC TYPED_FUNCTION_POINTERS}
	HIDReportHandlerProcPtr = PROCEDURE(inHIDReport: UNIV Ptr; inHIDReportLength: UInt32; inRefcon: UInt32); C;
{$ELSEC}
	HIDReportHandlerProcPtr = ProcPtr;
{$ENDC}

	{  User provided ProcPtr to be called when indexed string is received }
{$IFC TYPED_FUNCTION_POINTERS}
	HIDStringHandlerProcPtr = PROCEDURE(inHIDReport: UNIV Ptr; inHIDReportLength: UInt32; inRefcon: UInt32; inStatus: OSStatus); C;
{$ELSEC}
	HIDStringHandlerProcPtr = ProcPtr;
{$ENDC}

	{
	   When installed, a report handler is called at defered task time (unless kHIDFlag_CallbackIsResident is passed) 
	   whenever an interrupt packet is recieved on the first interrupt in pipe. The supplied refcon is also passed thru.
	}
{$IFC TYPED_FUNCTION_POINTERS}
	HIDInstallReportHandlerProcPtr = FUNCTION(inConnectionRef: HIDDeviceConnectionRef; flags: UInt32; inReportHandlerProc: HIDReportHandlerProcPtr; inRefcon: UInt32): OSStatus; C;
{$ELSEC}
	HIDInstallReportHandlerProcPtr = ProcPtr;
{$ENDC}

	{  When finished, remove the report handler. }
{$IFC TYPED_FUNCTION_POINTERS}
	HIDRemoveReportHandlerProcPtr = FUNCTION(inConnectionRef: HIDDeviceConnectionRef): OSStatus; C;
{$ELSEC}
	HIDRemoveReportHandlerProcPtr = ProcPtr;
{$ENDC}

	{  If there was a HIDReportHandler installed previous to the one from this connection, pass that one this report }
{$IFC TYPED_FUNCTION_POINTERS}
	HIDCallPreviousReportHandlerProcPtr = FUNCTION(inConnectionRef: HIDDeviceConnectionRef; inHIDReport: UNIV Ptr; inHIDReportLength: UInt32): OSStatus; C;
{$ELSEC}
	HIDCallPreviousReportHandlerProcPtr = ProcPtr;
{$ENDC}

	{
	   HIDGetReport is used to get a report (of type input, output, or feature) directly from a HID device
	   the HIDReportHandler will be called with the report when it is received.
	}
{$IFC TYPED_FUNCTION_POINTERS}
	HIDGetReportProcPtr = FUNCTION(inConnectionRef: HIDDeviceConnectionRef; inReportType: UInt32; inReportID: UInt32; inReportHandlerProc: HIDReportHandlerProcPtr; inRefcon: UInt32): OSStatus; C;
{$ELSEC}
	HIDGetReportProcPtr = ProcPtr;
{$ENDC}

	{  HIDGetSizedReport is used like HIDGetReport, but for devices that require exact size to return report. }
{$IFC TYPED_FUNCTION_POINTERS}
	HIDGetSizedReportProcPtr = FUNCTION(inConnectionRef: HIDDeviceConnectionRef; inReportType: UInt32; inReportID: UInt32; inSize: ByteCount; inReportHandlerProc: HIDReportHandlerProcPtr; inRefcon: UInt32): OSStatus; C;
{$ELSEC}
	HIDGetSizedReportProcPtr = ProcPtr;
{$ENDC}

	{  HIDSetReport is used to send a report (of type input, output, or feature) directly to a HID device }
{$IFC TYPED_FUNCTION_POINTERS}
	HIDSetReportProcPtr = FUNCTION(inConnectionRef: HIDDeviceConnectionRef; inReportType: UInt32; inReportID: UInt32; inInfo: UNIV Ptr; inSize: ByteCount): OSStatus; C;
{$ELSEC}
	HIDSetReportProcPtr = ProcPtr;
{$ENDC}

	{  HIDControlDevice is used to send misc control messages to a device }
{$IFC TYPED_FUNCTION_POINTERS}
	HIDControlDeviceProcPtr = FUNCTION(inConnectionRef: HIDDeviceConnectionRef; inControlSelector: UInt32; ioControlData: UNIV Ptr): OSStatus; C;
{$ELSEC}
	HIDControlDeviceProcPtr = ProcPtr;
{$ENDC}

	{
	   HIDGetIndexedString is used to get a string directly from a HID device.
	   The HIDStringHandler will be called with the string when it is received or nil string if completed with an error.
	}
{$IFC TYPED_FUNCTION_POINTERS}
	HIDGetIndexedStringProcPtr = FUNCTION(inConnectionRef: HIDDeviceConnectionRef; inStringIndex: UInt32; inStringLanguage: UInt32; inStringHandlerProc: HIDStringHandlerProcPtr; inRefcon: UInt32): OSStatus; C;
{$ELSEC}
	HIDGetIndexedStringProcPtr = ProcPtr;
{$ENDC}

	{
	   dispatchTableCurrentVersion is kHIDCurrentDispatchTableVersion
	   dispatchTableOldestVersion is kHIDOldestCompatableDispatchTableVersion
	        (the oldest built client using this API that this HID device driver will work with)
	   vendorID is who wrote this HID device driver (hi word of 0 and USB vendorID is valid)
	}
	HIDDeviceDispatchTablePtr = ^HIDDeviceDispatchTable;
	HIDDeviceDispatchTable = RECORD
		dispatchTableCurrentVersion: UInt32;
		dispatchTableOldestVersion: UInt32;
		vendorID:				UInt32;
		vendorSpecific:			UInt32;
		reserved:				UInt32;
		pHIDGetDeviceInfo:		HIDGetDeviceInfoProcPtr;
		pHIDGetHIDDescriptor:	HIDGetHIDDescriptorProcPtr;
		pHIDOpenDevice:			HIDOpenDeviceProcPtr;
		pHIDCloseDevice:		HIDCloseDeviceProcPtr;
		pHIDInstallReportHandler: HIDInstallReportHandlerProcPtr;
		pHIDRemoveReportHandler: HIDRemoveReportHandlerProcPtr;
		pHIDCallPreviousReportHandler: HIDCallPreviousReportHandlerProcPtr;
		pHIDGetReport:			HIDGetReportProcPtr;					{  new for vers 2, was reserved in version 1 }
		pHIDSetReport:			HIDSetReportProcPtr;					{  new for vers 2, was reserved in version 1 }
		pHIDControlDevice:		HIDControlDeviceProcPtr;
		pHIDGetIndexedString:	HIDGetIndexedStringProcPtr;				{  new for vers 3 }
		pHIDGetSizedReport:		HIDGetSizedReportProcPtr;				{  new for vers 3 }
	END;

	{	 A USB HIDDevice driver should export a HIDDeviceDispatchTable symbol 	}
	{	 in it's PEF container, with the name "\pTheHIDDeviceDispatchTable" 	}


	{	 ****************************************************************************************** 	}
	{	 HID Usage Tables                                                                           	}
	{	                                                                                            	}
	{	 The following constants are from the USB 'HID Usage Tables' specification, revision 1.1rc3 	}
	{	 ****************************************************************************************** 	}

	{	 Usage Pages 	}

CONST
	kHIDPage_Undefined			= $00;
	kHIDPage_GenericDesktop		= $01;
	kHIDPage_Simulation			= $02;
	kHIDPage_VR					= $03;
	kHIDPage_Sport				= $04;
	kHIDPage_Game				= $05;							{  Reserved 0x06  }
	kHIDPage_KeyboardOrKeypad	= $07;							{  USB Device Class Definition for Human Interface Devices (HID). Note: the usage type for all key codes is Selector (Sel).  }
	kHIDPage_LEDs				= $08;
	kHIDPage_Button				= $09;
	kHIDPage_Ordinal			= $0A;
	kHIDPage_Telephony			= $0B;
	kHIDPage_Consumer			= $0C;
	kHIDPage_Digitizer			= $0D;							{  Reserved 0x0E  }
	kHIDPage_PID				= $0F;							{  USB Physical Interface Device definitions for force feedback and related devices.  }
	kHIDPage_Unicode			= $10;							{  Reserved 0x11 - 0x13  }
	kHIDPage_AlphanumericDisplay = $14;							{  Reserved 0x15 - 0x7F  }
																{  Monitor 0x80 - 0x83     USB Device Class Definition for Monitor Devices  }
																{  Power 0x84 - 0x87   USB Device Class Definition for Power Devices  }
																{  Reserved 0x88 - 0x8B  }
	kHIDPage_BarCodeScanner		= $8C;							{  (Point of Sale) USB Device Class Definition for Bar Code Scanner Devices  }
	kHIDPage_Scale				= $8D;							{  (Point of Sale) USB Device Class Definition for Scale Devices  }
																{  ReservedPointofSalepages 0x8E - 0x8F  }
	kHIDPage_CameraControl		= $90;							{  USB Device Class Definition for Image Class Devices  }
	kHIDPage_Arcade				= $91;							{  OAAF Definitions for arcade and coinop related Devices  }
																{  Reserved 0x92 - 0xFEFF  }
																{  VendorDefined 0xFF00 - 0xFFFF  }
	kHIDPage_VendorDefinedStart	= $FF00;

	{	 Undefined Usage for all usage pages 	}
	kHIDUsage_Undefined			= $00;

	{	 GenericDesktop Page (0x01) 	}
	kHIDUsage_GD_Pointer		= $01;							{  Physical Collection  }
	kHIDUsage_GD_Mouse			= $02;							{  Application Collection  }
																{  0x03 Reserved  }
	kHIDUsage_GD_Joystick		= $04;							{  Application Collection  }
	kHIDUsage_GD_GamePad		= $05;							{  Application Collection  }
	kHIDUsage_GD_Keyboard		= $06;							{  Application Collection  }
	kHIDUsage_GD_Keypad			= $07;							{  Application Collection  }
	kHIDUsage_GD_MultiAxisController = $08;						{  Application Collection  }
																{  0x09 - 0x2F Reserved  }
	kHIDUsage_GD_X				= $30;							{  Dynamic Value  }
	kHIDUsage_GD_Y				= $31;							{  Dynamic Value  }
	kHIDUsage_GD_Z				= $32;							{  Dynamic Value  }
	kHIDUsage_GD_Rx				= $33;							{  Dynamic Value  }
	kHIDUsage_GD_Ry				= $34;							{  Dynamic Value  }
	kHIDUsage_GD_Rz				= $35;							{  Dynamic Value  }
	kHIDUsage_GD_Slider			= $36;							{  Dynamic Value  }
	kHIDUsage_GD_Dial			= $37;							{  Dynamic Value  }
	kHIDUsage_GD_Wheel			= $38;							{  Dynamic Value  }
	kHIDUsage_GD_Hatswitch		= $39;							{  Dynamic Value  }
	kHIDUsage_GD_CountedBuffer	= $3A;							{  Logical Collection  }
	kHIDUsage_GD_ByteCount		= $3B;							{  Dynamic Value  }
	kHIDUsage_GD_MotionWakeup	= $3C;							{  One-Shot Control  }
	kHIDUsage_GD_Start			= $3D;							{  On/Off Control  }
	kHIDUsage_GD_Select			= $3E;							{  On/Off Control  }
																{  0x3F Reserved  }
	kHIDUsage_GD_Vx				= $40;							{  Dynamic Value  }
	kHIDUsage_GD_Vy				= $41;							{  Dynamic Value  }
	kHIDUsage_GD_Vz				= $42;							{  Dynamic Value  }
	kHIDUsage_GD_Vbrx			= $43;							{  Dynamic Value  }
	kHIDUsage_GD_Vbry			= $44;							{  Dynamic Value  }
	kHIDUsage_GD_Vbrz			= $45;							{  Dynamic Value  }
	kHIDUsage_GD_Vno			= $46;							{  Dynamic Value  }
																{  0x47 - 0x7F Reserved  }
	kHIDUsage_GD_SystemControl	= $80;							{  Application Collection  }
	kHIDUsage_GD_SystemPowerDown = $81;							{  One-Shot Control  }
	kHIDUsage_GD_SystemSleep	= $82;							{  One-Shot Control  }
	kHIDUsage_GD_SystemWakeUp	= $83;							{  One-Shot Control  }
	kHIDUsage_GD_SystemContextMenu = $84;						{  One-Shot Control  }
	kHIDUsage_GD_SystemMainMenu	= $85;							{  One-Shot Control  }
	kHIDUsage_GD_SystemAppMenu	= $86;							{  One-Shot Control  }
	kHIDUsage_GD_SystemMenuHelp	= $87;							{  One-Shot Control  }
	kHIDUsage_GD_SystemMenuExit	= $88;							{  One-Shot Control  }
	kHIDUsage_GD_SystemMenu		= $89;							{  Selector  }
	kHIDUsage_GD_SystemMenuRight = $8A;							{  Re-Trigger Control  }
	kHIDUsage_GD_SystemMenuLeft	= $8B;							{  Re-Trigger Control  }
	kHIDUsage_GD_SystemMenuUp	= $8C;							{  Re-Trigger Control  }
	kHIDUsage_GD_SystemMenuDown	= $8D;							{  Re-Trigger Control  }
																{  0x8E - 0x8F Reserved  }
	kHIDUsage_GD_DPadUp			= $90;							{  On/Off Control  }
	kHIDUsage_GD_DPadDown		= $91;							{  On/Off Control  }
	kHIDUsage_GD_DPadRight		= $92;							{  On/Off Control  }
	kHIDUsage_GD_DPadLeft		= $93;							{  On/Off Control  }
																{  0x94 - 0xFFFF Reserved  }
	kHIDUsage_GD_Reserved		= $FFFF;

	{	 Simulation Page (0x02) 	}
	{	 This section provides detailed descriptions of the usages employed by simulation devices. 	}
	kHIDUsage_Sim_FlightSimulationDevice = $01;					{  Application Collection  }
	kHIDUsage_Sim_AutomobileSimulationDevice = $02;				{  Application Collection  }
	kHIDUsage_Sim_TankSimulationDevice = $03;					{  Application Collection  }
	kHIDUsage_Sim_SpaceshipSimulationDevice = $04;				{  Application Collection  }
	kHIDUsage_Sim_SubmarineSimulationDevice = $05;				{  Application Collection  }
	kHIDUsage_Sim_SailingSimulationDevice = $06;				{  Application Collection  }
	kHIDUsage_Sim_MotorcycleSimulationDevice = $07;				{  Application Collection  }
	kHIDUsage_Sim_SportsSimulationDevice = $08;					{  Application Collection  }
	kHIDUsage_Sim_AirplaneSimulationDevice = $09;				{  Application Collection  }
	kHIDUsage_Sim_HelicopterSimulationDevice = $0A;				{  Application Collection  }
	kHIDUsage_Sim_MagicCarpetSimulationDevice = $0B;			{  Application Collection  }
	kHIDUsage_Sim_BicycleSimulationDevice = $0C;				{  Application Collection  }
																{  0x0D - 0x1F Reserved  }
	kHIDUsage_Sim_FlightControlStick = $20;						{  Application Collection  }
	kHIDUsage_Sim_FlightStick	= $21;							{  Application Collection  }
	kHIDUsage_Sim_CyclicControl	= $22;							{  Physical Collection  }
	kHIDUsage_Sim_CyclicTrim	= $23;							{  Physical Collection  }
	kHIDUsage_Sim_FlightYoke	= $24;							{  Application Collection  }
	kHIDUsage_Sim_TrackControl	= $25;							{  Physical Collection  }
																{  0x26 - 0xAF Reserved  }
	kHIDUsage_Sim_Aileron		= $B0;							{  Dynamic Value  }
	kHIDUsage_Sim_AileronTrim	= $B1;							{  Dynamic Value  }
	kHIDUsage_Sim_AntiTorqueControl = $B2;						{  Dynamic Value  }
	kHIDUsage_Sim_AutopilotEnable = $B3;						{  On/Off Control  }
	kHIDUsage_Sim_ChaffRelease	= $B4;							{  One-Shot Control  }
	kHIDUsage_Sim_CollectiveControl = $B5;						{  Dynamic Value  }
	kHIDUsage_Sim_DiveBrake		= $B6;							{  Dynamic Value  }
	kHIDUsage_Sim_ElectronicCountermeasures = $B7;				{  On/Off Control  }
	kHIDUsage_Sim_Elevator		= $B8;							{  Dynamic Value  }
	kHIDUsage_Sim_ElevatorTrim	= $B9;							{  Dynamic Value  }
	kHIDUsage_Sim_Rudder		= $BA;							{  Dynamic Value  }
	kHIDUsage_Sim_Throttle		= $BB;							{  Dynamic Value  }
	kHIDUsage_Sim_FlightCommunications = $BC;					{  On/Off Control  }
	kHIDUsage_Sim_FlareRelease	= $BD;							{  One-Shot Control  }
	kHIDUsage_Sim_LandingGear	= $BE;							{  On/Off Control  }
	kHIDUsage_Sim_ToeBrake		= $BF;							{  Dynamic Value  }
	kHIDUsage_Sim_Trigger		= $C0;							{  Momentary Control  }
	kHIDUsage_Sim_WeaponsArm	= $C1;							{  On/Off Control  }
	kHIDUsage_Sim_Weapons		= $C2;							{  Selector  }
	kHIDUsage_Sim_WingFlaps		= $C3;							{  Dynamic Value  }
	kHIDUsage_Sim_Accelerator	= $C4;							{  Dynamic Value  }
	kHIDUsage_Sim_Brake			= $C5;							{  Dynamic Value  }
	kHIDUsage_Sim_Clutch		= $C6;							{  Dynamic Value  }
	kHIDUsage_Sim_Shifter		= $C7;							{  Dynamic Value  }
	kHIDUsage_Sim_Steering		= $C8;							{  Dynamic Value  }
	kHIDUsage_Sim_TurretDirection = $C9;						{  Dynamic Value  }
	kHIDUsage_Sim_BarrelElevation = $CA;						{  Dynamic Value  }
	kHIDUsage_Sim_DivePlane		= $CB;							{  Dynamic Value  }
	kHIDUsage_Sim_Ballast		= $CC;							{  Dynamic Value  }
	kHIDUsage_Sim_BicycleCrank	= $CD;							{  Dynamic Value  }
	kHIDUsage_Sim_HandleBars	= $CE;							{  Dynamic Value  }
	kHIDUsage_Sim_FrontBrake	= $CF;							{  Dynamic Value  }
	kHIDUsage_Sim_RearBrake		= $D0;							{  Dynamic Value  }
																{  0xD1 - 0xFFFF Reserved  }
	kHIDUsage_Sim_Reserved		= $FFFF;

	{	 VR Page (0x03) 	}
	{	 Virtual Reality controls depend on designators to identify the individual controls. Most of the following are 	}
	{	 usages are applied to the collections of entities that comprise the actual device. 	}
	kHIDUsage_VR_Belt			= $01;							{  Application Collection  }
	kHIDUsage_VR_BodySuit		= $02;							{  Application Collection  }
	kHIDUsage_VR_Flexor			= $03;							{  Physical Collection  }
	kHIDUsage_VR_Glove			= $04;							{  Application Collection  }
	kHIDUsage_VR_HeadTracker	= $05;							{  Physical Collection  }
	kHIDUsage_VR_HeadMountedDisplay = $06;						{  Application Collection  }
	kHIDUsage_VR_HandTracker	= $07;							{  Application Collection  }
	kHIDUsage_VR_Oculometer		= $08;							{  Application Collection  }
	kHIDUsage_VR_Vest			= $09;							{  Application Collection  }
	kHIDUsage_VR_AnimatronicDevice = $0A;						{  Application Collection  }
																{  0x0B - 0x1F Reserved  }
	kHIDUsage_VR_StereoEnable	= $20;							{  On/Off Control  }
	kHIDUsage_VR_DisplayEnable	= $21;							{  On/Off Control  }
																{  0x22 - 0xFFFF Reserved  }
	kHIDUsage_VR_Reserved		= $FFFF;

	{	 Sport Page (0x04) 	}
	kHIDUsage_Sprt_BaseballBat	= $01;							{  Application Collection  }
	kHIDUsage_Sprt_GolfClub		= $02;							{  Application Collection  }
	kHIDUsage_Sprt_RowingMachine = $03;							{  Application Collection  }
	kHIDUsage_Sprt_Treadmill	= $04;							{  Application Collection  }
																{  0x05 - 0x2F Reserved  }
	kHIDUsage_Sprt_Oar			= $30;							{  Dynamic Value  }
	kHIDUsage_Sprt_Slope		= $31;							{  Dynamic Value  }
	kHIDUsage_Sprt_Rate			= $32;							{  Dynamic Value  }
	kHIDUsage_Sprt_StickSpeed	= $33;							{  Dynamic Value  }
	kHIDUsage_Sprt_StickFaceAngle = $34;						{  Dynamic Value  }
	kHIDUsage_Sprt_StickHeelOrToe = $35;						{  Dynamic Value  }
	kHIDUsage_Sprt_StickFollowThrough = $36;					{  Dynamic Value  }
	kHIDUsage_Sprt_StickTempo	= $37;							{  Dynamic Value  }
	kHIDUsage_Sprt_StickType	= $38;							{  Named Array  }
	kHIDUsage_Sprt_StickHeight	= $39;							{  Dynamic Value  }
																{  0x3A - 0x4F Reserved  }
	kHIDUsage_Sprt_Putter		= $50;							{  Selector  }
	kHIDUsage_Sprt_1Iron		= $51;							{  Selector  }
	kHIDUsage_Sprt_2Iron		= $52;							{  Selector  }
	kHIDUsage_Sprt_3Iron		= $53;							{  Selector  }
	kHIDUsage_Sprt_4Iron		= $54;							{  Selector  }
	kHIDUsage_Sprt_5Iron		= $55;							{  Selector  }
	kHIDUsage_Sprt_6Iron		= $56;							{  Selector  }
	kHIDUsage_Sprt_7Iron		= $57;							{  Selector  }
	kHIDUsage_Sprt_8Iron		= $58;							{  Selector  }
	kHIDUsage_Sprt_9Iron		= $59;							{  Selector  }
	kHIDUsage_Sprt_10Iron		= $5A;							{  Selector  }
	kHIDUsage_Sprt_11Iron		= $5B;							{  Selector  }
	kHIDUsage_Sprt_SandWedge	= $5C;							{  Selector  }
	kHIDUsage_Sprt_LoftWedge	= $5D;							{  Selector  }
	kHIDUsage_Sprt_PowerWedge	= $5E;							{  Selector  }
	kHIDUsage_Sprt_1Wood		= $5F;							{  Selector  }
	kHIDUsage_Sprt_3Wood		= $60;							{  Selector  }
	kHIDUsage_Sprt_5Wood		= $61;							{  Selector  }
	kHIDUsage_Sprt_7Wood		= $62;							{  Selector  }
	kHIDUsage_Sprt_9Wood		= $63;							{  Selector  }
																{  0x64 - 0xFFFF Reserved  }
	kHIDUsage_Sprt_Reserved		= $FFFF;

	{	 Game Page (0x05) 	}
	kHIDUsage_Game_3DGameController = $01;						{  Application Collection  }
	kHIDUsage_Game_PinballDevice = $02;							{  Application Collection  }
	kHIDUsage_Game_GunDevice	= $03;							{  Application Collection  }
																{  0x04 - 0x1F Reserved  }
	kHIDUsage_Game_PointofView	= $20;							{  Physical Collection  }
	kHIDUsage_Game_TurnRightOrLeft = $21;						{  Dynamic Value  }
	kHIDUsage_Game_PitchUpOrDown = $22;							{  Dynamic Value  }
	kHIDUsage_Game_RollRightOrLeft = $23;						{  Dynamic Value  }
	kHIDUsage_Game_MoveRightOrLeft = $24;						{  Dynamic Value  }
	kHIDUsage_Game_MoveForwardOrBackward = $25;					{  Dynamic Value  }
	kHIDUsage_Game_MoveUpOrDown	= $26;							{  Dynamic Value  }
	kHIDUsage_Game_LeanRightOrLeft = $27;						{  Dynamic Value  }
	kHIDUsage_Game_LeanForwardOrBackward = $28;					{  Dynamic Value  }
	kHIDUsage_Game_HeightOfPOV	= $29;							{  Dynamic Value  }
	kHIDUsage_Game_Flipper		= $2A;							{  Momentary Control  }
	kHIDUsage_Game_SecondaryFlipper = $2B;						{  Momentary Control  }
	kHIDUsage_Game_Bump			= $2C;							{  Momentary Control  }
	kHIDUsage_Game_NewGame		= $2D;							{  One-Shot Control  }
	kHIDUsage_Game_ShootBall	= $2E;							{  One-Shot Control  }
	kHIDUsage_Game_Player		= $2F;							{  One-Shot Control  }
	kHIDUsage_Game_GunBolt		= $30;							{  On/Off Control  }
	kHIDUsage_Game_GunClip		= $31;							{  On/Off Control  }
	kHIDUsage_Game_Gun			= $32;							{  Selector  }
	kHIDUsage_Game_GunSingleShot = $33;							{  Selector  }
	kHIDUsage_Game_GunBurst		= $34;							{  Selector  }
	kHIDUsage_Game_GunAutomatic	= $35;							{  Selector  }
	kHIDUsage_Game_GunSafety	= $36;							{  On/Off Control  }
	kHIDUsage_Game_GamepadFireOrJump = $37;						{  Logical Collection  }
	kHIDUsage_Game_GamepadTrigger = $39;						{  Logical Collection  }
																{  0x3A - 0xFFFF Reserved  }
	kHIDUsage_Game_Reserved		= $FFFF;

	{	 KeyboardOrKeypad Page (0x07) 	}
	{	 This section is the Usage Page for key codes to be used in implementing a USB keyboard.  	}
	{	 A Boot Keyboard (84-, 101- or 104-key) should at a minimum support all associated usage codes as 	}
	{	 indicated in the “Boot” column below. 	}
	{	 The usage type of all key codes is Selectors (Sel), except for the modifier keys Keyboard Left Control (0x224) 	}
	{	 to Keyboard Right GUI (0x231) which are Dynamic Flags (DV). 	}
	{	 Note: A general note on Usages and languages: 	}
	{	 Due to the variation of keyboards from language to language, it is not feasible to specify exact key mappings 	}
	{	 for every language. Where this list is not specific for a key function in a language, the closest equivalent key 	}
	{	 position should be used, so that a keyboard may be modified for a different language by simply printing different 	}
	{	 keycaps. One example is the Y key on a North American keyboard. In Germany this is typically Z. Rather than changing 	}
	{	 the keyboard firmware to put the Z Usage into that place in the descriptor list, the vendor should use the Y Usage on 	}
	{	 both the North American and German keyboards. This continues to be the existing practice in the industry, in order to 	}
	{	 minimize the number of changes to the electronics to accommodate otherlanguages. 	}
	kHIDUsage_KeyboardErrorRollOver = $01;						{  ErrorRollOver  }
	kHIDUsage_KeyboardPOSTFail	= $02;							{  POSTFail  }
	kHIDUsage_KeyboardErrorUndefined = $03;						{  ErrorUndefined  }
	kHIDUsage_KeyboardA			= $04;							{  a or A  }
	kHIDUsage_KeyboardB			= $05;							{  b or B  }
	kHIDUsage_KeyboardC			= $06;							{  c or C  }
	kHIDUsage_KeyboardD			= $07;							{  d or D  }
	kHIDUsage_KeyboardE			= $08;							{  e or E  }
	kHIDUsage_KeyboardF			= $09;							{  f or F  }
	kHIDUsage_KeyboardG			= $0A;							{  g or G  }
	kHIDUsage_KeyboardH			= $0B;							{  h or H  }
	kHIDUsage_KeyboardI			= $0C;							{  i or I  }
	kHIDUsage_KeyboardJ			= $0D;							{  j or J  }
	kHIDUsage_KeyboardK			= $0E;							{  k or K  }
	kHIDUsage_KeyboardL			= $0F;							{  l or L  }
	kHIDUsage_KeyboardM			= $10;							{  m or M  }
	kHIDUsage_KeyboardN			= $11;							{  n or N  }
	kHIDUsage_KeyboardO			= $12;							{  o or O  }
	kHIDUsage_KeyboardP			= $13;							{  p or P  }
	kHIDUsage_KeyboardQ			= $14;							{  q or Q  }
	kHIDUsage_KeyboardR			= $15;							{  r or R  }
	kHIDUsage_KeyboardS			= $16;							{  s or S  }
	kHIDUsage_KeyboardT			= $17;							{  t or T  }
	kHIDUsage_KeyboardU			= $18;							{  u or U  }
	kHIDUsage_KeyboardV			= $19;							{  v or V  }
	kHIDUsage_KeyboardW			= $1A;							{  w or W  }
	kHIDUsage_KeyboardX			= $1B;							{  x or X  }
	kHIDUsage_KeyboardY			= $1C;							{  y or Y  }
	kHIDUsage_KeyboardZ			= $1D;							{  z or Z  }
	kHIDUsage_Keyboard1			= $1E;							{  1 or !  }
	kHIDUsage_Keyboard2			= $1F;							{  2 or @  }
	kHIDUsage_Keyboard3			= $20;							{  3 or #  }
	kHIDUsage_Keyboard4			= $21;							{  4 or $  }
	kHIDUsage_Keyboard5			= $22;							{  5 or %  }
	kHIDUsage_Keyboard6			= $23;							{  6 or ^  }
	kHIDUsage_Keyboard7			= $24;							{  7 or &  }
	kHIDUsage_Keyboard8			= $25;							{  8 or *  }
	kHIDUsage_Keyboard9			= $26;							{  9 or (  }
	kHIDUsage_Keyboard0			= $27;							{  0 or )  }
	kHIDUsage_KeyboardReturnOrEnter = $28;						{  Return (Enter)  }
	kHIDUsage_KeyboardEscape	= $29;							{  Escape  }
	kHIDUsage_KeyboardDeleteOrBackspace = $2A;					{  Delete (Backspace)  }
	kHIDUsage_KeyboardTab		= $2B;							{  Tab  }
	kHIDUsage_KeyboardSpacebar	= $2C;							{  Spacebar  }
	kHIDUsage_KeyboardHyphen	= $2D;							{  - or _  }
	kHIDUsage_KeyboardEqualSign	= $2E;							{  = or +  }
	kHIDUsage_KeyboardOpenBracket = $2F;						{  [ or (  }
	kHIDUsage_KeyboardCloseBracket = $30;						{  ] or )  }
	kHIDUsage_KeyboardBackslash	= $31;							{  \ or |  }
	kHIDUsage_KeyboardNonUSPound = $32;							{  Non-US # or _  }
	kHIDUsage_KeyboardSemicolon	= $33;							{  ; or :  }
	kHIDUsage_KeyboardQuote		= $34;							{  ' or "  }
	kHIDUsage_KeyboardGraveAccentAndTilde = $35;				{  Grave Accent and Tilde  }
	kHIDUsage_KeyboardComma		= $36;							{  , or <  }
	kHIDUsage_KeyboardPeriod	= $37;							{  . or >  }
	kHIDUsage_KeyboardSlash		= $38;							{  / or ?  }
	kHIDUsage_KeyboardCapsLock	= $39;							{  Caps Lock  }
	kHIDUsage_KeyboardF1		= $3A;							{  F1  }
	kHIDUsage_KeyboardF2		= $3B;							{  F2  }
	kHIDUsage_KeyboardF3		= $3C;							{  F3  }
	kHIDUsage_KeyboardF4		= $3D;							{  F4  }
	kHIDUsage_KeyboardF5		= $3E;							{  F5  }
	kHIDUsage_KeyboardF6		= $3F;							{  F6  }
	kHIDUsage_KeyboardF7		= $40;							{  F7  }
	kHIDUsage_KeyboardF8		= $41;							{  F8  }
	kHIDUsage_KeyboardF9		= $42;							{  F9  }
	kHIDUsage_KeyboardF10		= $43;							{  F10  }
	kHIDUsage_KeyboardF11		= $44;							{  F11  }
	kHIDUsage_KeyboardF12		= $45;							{  F12  }
	kHIDUsage_KeyboardPrintScreen = $46;						{  Print Screen  }
	kHIDUsage_KeyboardScrollLock = $47;							{  Scroll Lock  }
	kHIDUsage_KeyboardPause		= $48;							{  Pause  }
	kHIDUsage_KeyboardInsert	= $49;							{  Insert  }
	kHIDUsage_KeyboardHome		= $4A;							{  Home  }
	kHIDUsage_KeyboardPageUp	= $4B;							{  Page Up  }
	kHIDUsage_KeyboardDeleteForward = $4C;						{  Delete Forward  }
	kHIDUsage_KeyboardEnd		= $4D;							{  End  }
	kHIDUsage_KeyboardPageDown	= $4E;							{  Page Down  }
	kHIDUsage_KeyboardRightArrow = $4F;							{  Right Arrow  }
	kHIDUsage_KeyboardLeftArrow	= $50;							{  Left Arrow  }
	kHIDUsage_KeyboardDownArrow	= $51;							{  Down Arrow  }
	kHIDUsage_KeyboardUpArrow	= $52;							{  Up Arrow  }
	kHIDUsage_KeypadNumLock		= $53;							{  Keypad NumLock or Clear  }
	kHIDUsage_KeypadSlash		= $54;							{  Keypad /  }
	kHIDUsage_KeypadAsterisk	= $55;							{  Keypad *  }
	kHIDUsage_KeypadHyphen		= $56;							{  Keypad -  }
	kHIDUsage_KeypadPlus		= $57;							{  Keypad +  }
	kHIDUsage_KeypadEnter		= $58;							{  Keypad Enter  }
	kHIDUsage_Keypad1			= $59;							{  Keypad 1 or End  }
	kHIDUsage_Keypad2			= $5A;							{  Keypad 2 or Down Arrow  }
	kHIDUsage_Keypad3			= $5B;							{  Keypad 3 or Page Down  }
	kHIDUsage_Keypad4			= $5C;							{  Keypad 4 or Left Arrow  }
	kHIDUsage_Keypad5			= $5D;							{  Keypad 5  }
	kHIDUsage_Keypad6			= $5E;							{  Keypad 6 or Right Arrow  }
	kHIDUsage_Keypad7			= $5F;							{  Keypad 7 or Home  }
	kHIDUsage_Keypad8			= $60;							{  Keypad 8 or Up Arrow  }
	kHIDUsage_Keypad9			= $61;							{  Keypad 9 or Page Up  }
	kHIDUsage_Keypad0			= $62;							{  Keypad 0 or Insert  }
	kHIDUsage_KeypadPeriod		= $63;							{  Keypad . or Delete  }
	kHIDUsage_KeyboardNonUSBackslash = $64;						{  Non-US \ or |  }
	kHIDUsage_KeyboardApplication = $65;						{  Application  }
	kHIDUsage_KeyboardPower		= $66;							{  Power  }
	kHIDUsage_KeypadEqualSign	= $67;							{  Keypad =  }
	kHIDUsage_KeyboardF13		= $68;							{  F13  }
	kHIDUsage_KeyboardF14		= $69;							{  F14  }
	kHIDUsage_KeyboardF15		= $6A;							{  F15  }
	kHIDUsage_KeyboardF16		= $6B;							{  F16  }
	kHIDUsage_KeyboardF17		= $6C;							{  F17  }
	kHIDUsage_KeyboardF18		= $6D;							{  F18  }
	kHIDUsage_KeyboardF19		= $6E;							{  F19  }
	kHIDUsage_KeyboardF20		= $6F;							{  F20  }
	kHIDUsage_KeyboardF21		= $70;							{  F21  }
	kHIDUsage_KeyboardF22		= $71;							{  F22  }
	kHIDUsage_KeyboardF23		= $72;							{  F23  }
	kHIDUsage_KeyboardF24		= $73;							{  F24  }
	kHIDUsage_KeyboardExecute	= $74;							{  Execute  }
	kHIDUsage_KeyboardHelp		= $75;							{  Help  }
	kHIDUsage_KeyboardMenu		= $76;							{  Menu  }
	kHIDUsage_KeyboardSelect	= $77;							{  Select  }
	kHIDUsage_KeyboardStop		= $78;							{  Stop  }
	kHIDUsage_KeyboardAgain		= $79;							{  Again  }
	kHIDUsage_KeyboardUndo		= $7A;							{  Undo  }
	kHIDUsage_KeyboardCut		= $7B;							{  Cut  }
	kHIDUsage_KeyboardCopy		= $7C;							{  Copy  }
	kHIDUsage_KeyboardPaste		= $7D;							{  Paste  }
	kHIDUsage_KeyboardFind		= $7E;							{  Find  }
	kHIDUsage_KeyboardMute		= $7F;							{  Mute  }
	kHIDUsage_KeyboardVolumeUp	= $80;							{  Volume Up  }
	kHIDUsage_KeyboardVolumeDown = $81;							{  Volume Down  }
	kHIDUsage_KeyboardLockingCapsLock = $82;					{  Locking Caps Lock  }
	kHIDUsage_KeyboardLockingNumLock = $83;						{  Locking Num Lock  }
	kHIDUsage_KeyboardLockingScrollLock = $84;					{  Locking Scroll Lock  }
	kHIDUsage_KeypadComma		= $85;							{  Keypad Comma  }
	kHIDUsage_KeypadEqualSignAS400 = $86;						{  Keypad Equal Sign for AS/400  }
	kHIDUsage_KeyboardInternational1 = $87;						{  International1  }
	kHIDUsage_KeyboardInternational2 = $88;						{  International2  }
	kHIDUsage_KeyboardInternational3 = $89;						{  International3  }
	kHIDUsage_KeyboardInternational4 = $8A;						{  International4  }
	kHIDUsage_KeyboardInternational5 = $8B;						{  International5  }
	kHIDUsage_KeyboardInternational6 = $8C;						{  International6  }
	kHIDUsage_KeyboardInternational7 = $8D;						{  International7  }
	kHIDUsage_KeyboardInternational8 = $8E;						{  International8  }
	kHIDUsage_KeyboardInternational9 = $8F;						{  International9  }
	kHIDUsage_KeyboardLANG1		= $90;							{  LANG1  }
	kHIDUsage_KeyboardLANG2		= $91;							{  LANG2  }
	kHIDUsage_KeyboardLANG3		= $92;							{  LANG3  }
	kHIDUsage_KeyboardLANG4		= $93;							{  LANG4  }
	kHIDUsage_KeyboardLANG5		= $94;							{  LANG5  }
	kHIDUsage_KeyboardLANG6		= $95;							{  LANG6  }
	kHIDUsage_KeyboardLANG7		= $96;							{  LANG7  }
	kHIDUsage_KeyboardLANG8		= $97;							{  LANG8  }
	kHIDUsage_KeyboardLANG9		= $98;							{  LANG9  }
	kHIDUsage_KeyboardAlternateErase = $99;						{  AlternateErase  }
	kHIDUsage_KeyboardSysReqOrAttention = $9A;					{  SysReq/Attention  }
	kHIDUsage_KeyboardCancel	= $9B;							{  Cancel  }
	kHIDUsage_KeyboardClear		= $9C;							{  Clear  }
	kHIDUsage_KeyboardPrior		= $9D;							{  Prior  }
	kHIDUsage_KeyboardReturn	= $9E;							{  Return  }
	kHIDUsage_KeyboardSeparator	= $9F;							{  Separator  }
	kHIDUsage_KeyboardOut		= $A0;							{  Out  }
	kHIDUsage_KeyboardOper		= $A1;							{  Oper  }
	kHIDUsage_KeyboardClearOrAgain = $A2;						{  Clear/Again  }
	kHIDUsage_KeyboardCrSelOrProps = $A3;						{  CrSel/Props  }
	kHIDUsage_KeyboardExSel		= $A4;							{  ExSel  }
																{  0xA5-0xDF Reserved  }
	kHIDUsage_KeyboardLeftControl = $E0;						{  Left Control  }
	kHIDUsage_KeyboardLeftShift	= $E1;							{  Left Shift  }
	kHIDUsage_KeyboardLeftAlt	= $E2;							{  Left Alt  }
	kHIDUsage_KeyboardLeftGUI	= $E3;							{  Left GUI  }
	kHIDUsage_KeyboardRightControl = $E4;						{  Right Control  }
	kHIDUsage_KeyboardRightShift = $E5;							{  Right Shift  }
	kHIDUsage_KeyboardRightAlt	= $E6;							{  Right Alt  }
	kHIDUsage_KeyboardRightGUI	= $E7;							{  Right GUI  }
																{  0xE8-0xFFFF Reserved  }
	kHIDUsage_Keyboard_Reserved	= $FFFF;

	{	 LEDs Page (0x08) 	}
	{	 An LED or indicator is implemented as an On/Off Control (OOF) using the “Single button toggle” mode, 
	/* where a value of 1 will turn on the indicator, and a value of 0 will turn it off. The exceptions are described below. 	}
	kHIDUsage_LED_NumLock		= $01;							{  On/Off Control  }
	kHIDUsage_LED_CapsLock		= $02;							{  On/Off Control  }
	kHIDUsage_LED_ScrollLock	= $03;							{  On/Off Control  }
	kHIDUsage_LED_Compose		= $04;							{  On/Off Control  }
	kHIDUsage_LED_Kana			= $05;							{  On/Off Control  }
	kHIDUsage_LED_Power			= $06;							{  On/Off Control  }
	kHIDUsage_LED_Shift			= $07;							{  On/Off Control  }
	kHIDUsage_LED_DoNotDisturb	= $08;							{  On/Off Control  }
	kHIDUsage_LED_Mute			= $09;							{  On/Off Control  }
	kHIDUsage_LED_ToneEnable	= $0A;							{  On/Off Control  }
	kHIDUsage_LED_HighCutFilter	= $0B;							{  On/Off Control  }
	kHIDUsage_LED_LowCutFilter	= $0C;							{  On/Off Control  }
	kHIDUsage_LED_EqualizerEnable = $0D;						{  On/Off Control  }
	kHIDUsage_LED_SoundFieldOn	= $0E;							{  On/Off Control  }
	kHIDUsage_LED_SurroundOn	= $0F;							{  On/Off Control  }
	kHIDUsage_LED_Repeat		= $10;							{  On/Off Control  }
	kHIDUsage_LED_Stereo		= $11;							{  On/Off Control  }
	kHIDUsage_LED_SamplingRateDetect = $12;						{  On/Off Control  }
	kHIDUsage_LED_Spinning		= $13;							{  On/Off Control  }
	kHIDUsage_LED_CAV			= $14;							{  On/Off Control  }
	kHIDUsage_LED_CLV			= $15;							{  On/Off Control  }
	kHIDUsage_LED_RecordingFormatDetect = $16;					{  On/Off Control  }
	kHIDUsage_LED_OffHook		= $17;							{  On/Off Control  }
	kHIDUsage_LED_Ring			= $18;							{  On/Off Control  }
	kHIDUsage_LED_MessageWaiting = $19;							{  On/Off Control  }
	kHIDUsage_LED_DataMode		= $1A;							{  On/Off Control  }
	kHIDUsage_LED_BatteryOperation = $1B;						{  On/Off Control  }
	kHIDUsage_LED_BatteryOK		= $1C;							{  On/Off Control  }
	kHIDUsage_LED_BatteryLow	= $1D;							{  On/Off Control  }
	kHIDUsage_LED_Speaker		= $1E;							{  On/Off Control  }
	kHIDUsage_LED_HeadSet		= $1F;							{  On/Off Control  }
	kHIDUsage_LED_Hold			= $20;							{  On/Off Control  }
	kHIDUsage_LED_Microphone	= $21;							{  On/Off Control  }
	kHIDUsage_LED_Coverage		= $22;							{  On/Off Control  }
	kHIDUsage_LED_NightMode		= $23;							{  On/Off Control  }
	kHIDUsage_LED_SendCalls		= $24;							{  On/Off Control  }
	kHIDUsage_LED_CallPickup	= $25;							{  On/Off Control  }
	kHIDUsage_LED_Conference	= $26;							{  On/Off Control  }
	kHIDUsage_LED_StandBy		= $27;							{  On/Off Control  }
	kHIDUsage_LED_CameraOn		= $28;							{  On/Off Control  }
	kHIDUsage_LED_CameraOff		= $29;							{  On/Off Control  }
	kHIDUsage_LED_OnLine		= $2A;							{  On/Off Control  }
	kHIDUsage_LED_OffLine		= $2B;							{  On/Off Control  }
	kHIDUsage_LED_Busy			= $2C;							{  On/Off Control  }
	kHIDUsage_LED_Ready			= $2D;							{  On/Off Control  }
	kHIDUsage_LED_PaperOut		= $2E;							{  On/Off Control  }
	kHIDUsage_LED_PaperJam		= $2F;							{  On/Off Control  }
	kHIDUsage_LED_Remote		= $30;							{  On/Off Control  }
	kHIDUsage_LED_Forward		= $31;							{  On/Off Control  }
	kHIDUsage_LED_Reverse		= $32;							{  On/Off Control  }
	kHIDUsage_LED_Stop			= $33;							{  On/Off Control  }
	kHIDUsage_LED_Rewind		= $34;							{  On/Off Control  }
	kHIDUsage_LED_FastForward	= $35;							{  On/Off Control  }
	kHIDUsage_LED_Play			= $36;							{  On/Off Control  }
	kHIDUsage_LED_Pause			= $37;							{  On/Off Control  }
	kHIDUsage_LED_Record		= $38;							{  On/Off Control  }
	kHIDUsage_LED_Error			= $39;							{  On/Off Control  }
	kHIDUsage_LED_Usage			= $3A;							{  Selector  }
	kHIDUsage_LED_UsageInUseIndicator = $3B;					{  Usage Switch  }
	kHIDUsage_LED_UsageMultiModeIndicator = $3C;				{  Usage Modifier  }
	kHIDUsage_LED_IndicatorOn	= $3D;							{  Selector  }
	kHIDUsage_LED_IndicatorFlash = $3E;							{  Selector  }
	kHIDUsage_LED_IndicatorSlowBlink = $3F;						{  Selector  }
	kHIDUsage_LED_IndicatorFastBlink = $40;						{  Selector  }
	kHIDUsage_LED_IndicatorOff	= $41;							{  Selector  }
	kHIDUsage_LED_FlashOnTime	= $42;							{  Dynamic Value  }
	kHIDUsage_LED_SlowBlinkOnTime = $43;						{  Dynamic Value  }
	kHIDUsage_LED_SlowBlinkOffTime = $44;						{  Dynamic Value  }
	kHIDUsage_LED_FastBlinkOnTime = $45;						{  Dynamic Value  }
	kHIDUsage_LED_FastBlinkOffTime = $46;						{  Dynamic Value  }
	kHIDUsage_LED_UsageIndicatorColor = $47;					{  Usage Modifier  }
	kHIDUsage_LED_IndicatorRed	= $48;							{  Selector  }
	kHIDUsage_LED_IndicatorGreen = $49;							{  Selector  }
	kHIDUsage_LED_IndicatorAmber = $4A;							{  Selector  }
	kHIDUsage_LED_GenericIndicator = $4B;						{  On/Off Control  }
	kHIDUsage_LED_SystemSuspend	= $4C;							{  On/Off Control  }
	kHIDUsage_LED_ExternalPowerConnected = $4D;					{  On/Off Control  }
																{  0x4E - 0xFFFF Reserved  }
	kHIDUsage_LED_Reserved		= $FFFF;

	{	 Button Page (0x09) 	}
	{	 The Button page is the first place an application should look for user selection controls. System graphical user 	}
	{	 interfaces typically employ a pointer and a set of hierarchical selectors to select, move and otherwise manipulate 	}
	{	 their environment. For these purposes the following assignment of significance can be applied to the Button usages: 	}
	{	 • Button 1, Primary Button. Used for object selecting, dragging, and double click activation. On MacOS, this is the 
	/*   only button. Microsoft operating systems call this a logical left button, because it 	}
	{	   is not necessarily physically located on the left of the pointing device. 	}
	{	 • Button 2, Secondary Button. Used by newer graphical user interfaces to browse object properties. Exposed by systems 	}
	{	   to applications that typically assign application-specific functionality. 	}
	{	 • Button 3, Tertiary Button. Optional control. Exposed to applications, but seldom assigned functionality due to prevalence 	}
	{	   of two- and one-button devices. 	}
	{	 • Buttons 4 -55. As the button number increases, its significance as a selector decreases. 	}
	{	 In many ways the assignment of button numbers is similar to the assignment of Effort in Physical descriptors. 	}
	{	 Button 1 would be used to define the button a finger rests on when the hand is in the “at rest” position, that is, virtually 	}
	{	 no effort is required by the user to activate the button. Button values increment as the finger has to stretch to reach a 	}
	{	 control. See Section 6.2.3, “Physical Descriptors,” in the HID Specification for methods of further qualifying buttons. 	}
	kHIDUsage_Button_1			= $01;							{  (primary/trigger)  }
	kHIDUsage_Button_2			= $02;							{  (secondary)  }
	kHIDUsage_Button_3			= $03;							{  (tertiary)  }
	kHIDUsage_Button_4			= $04;							{  4th button  }
																{  ...  }
	kHIDUsage_Button_65535		= $FFFF;

	{	 Ordinal Page (0x0A) 	}
	{	 The Ordinal page allows multiple instances of a control or sets of controls to be declared without requiring individual 	}
	{	 enumeration in the native usage page. For example, it is not necessary to declare usages of Pointer 1, Pointer 2, and so 	}
	{	 forth on the Generic Desktop page. When parsed, the ordinal instance number is, in essence, concatenated to the usages 	}
	{	 attached to the encompassing collection to create Pointer 1, Pointer 2, and so forth. 	}
	{	 For an example, see Section A.5, “Multiple Instances of a Control,” in Appendix A, “Usage Examples.” By convention, 	}
	{	 an Ordinal collection is placed inside the collection for which it is declaring multiple instances. 	}
	{	 Instances do not have to be identical. 	}
																{  0x00 Reserved  }
	kHIDUsage_Ord_Instance1		= $01;							{  Usage Modifier  }
	kHIDUsage_Ord_Instance2		= $02;							{  Usage Modifier  }
	kHIDUsage_Ord_Instance3		= $03;							{  Usage Modifier  }
	kHIDUsage_Ord_Instance4		= $04;							{  Usage Modifier  }
	kHIDUsage_Ord_Instance65535	= $FFFF;						{  Usage Modifier  }

	{	 Telephony Page (0x0B) 	}
	{	 This usage page defines the keytop and control usages for telephony devices. 	}
	{	 Indicators on a phone are handled by wrapping them in LED: Usage In Use Indicator and LED: Usage Selected Indicator 	}
	{	 usages. For example, a message-indicator LED would be identified by a Telephony: Message usage declared as a Feature 	}
	{	 or Output in a LED: Usage In Use Indicator collection. 	}
	{	 See Section 14, “Consumer Page (0x0C),” for audio volume and tone controls. 	}
	kHIDUsage_Tfon_Phone		= $01;							{  Application Collection  }
	kHIDUsage_Tfon_AnsweringMachine = $02;						{  Application Collection  }
	kHIDUsage_Tfon_MessageControls = $03;						{  Logical Collection  }
	kHIDUsage_Tfon_Handset		= $04;							{  Logical Collection  }
	kHIDUsage_Tfon_Headset		= $05;							{  Logical Collection  }
	kHIDUsage_Tfon_TelephonyKeyPad = $06;						{  Named Array  }
	kHIDUsage_Tfon_ProgrammableButton = $07;					{  Named Array  }
																{  0x08 - 0x1F Reserved  }
	kHIDUsage_Tfon_HookSwitch	= $20;							{  On/Off Control  }
	kHIDUsage_Tfon_Flash		= $21;							{  Momentary Control  }
	kHIDUsage_Tfon_Feature		= $22;							{  One-Shot Control  }
	kHIDUsage_Tfon_Hold			= $23;							{  On/Off Control  }
	kHIDUsage_Tfon_Redial		= $24;							{  One-Shot Control  }
	kHIDUsage_Tfon_Transfer		= $25;							{  One-Shot Control  }
	kHIDUsage_Tfon_Drop			= $26;							{  One-Shot Control  }
	kHIDUsage_Tfon_Park			= $27;							{  On/Off Control  }
	kHIDUsage_Tfon_ForwardCalls	= $28;							{  On/Off Control  }
	kHIDUsage_Tfon_AlternateFunction = $29;						{  Momentary Control  }
	kHIDUsage_Tfon_Line			= $2A;							{  One-Shot Control  }
	kHIDUsage_Tfon_SpeakerPhone	= $2B;							{  On/Off Control  }
	kHIDUsage_Tfon_Conference	= $2C;							{  On/Off Control  }
	kHIDUsage_Tfon_RingEnable	= $2D;							{  On/Off Control  }
	kHIDUsage_Tfon_Ring			= $2E;							{  Selector  }
	kHIDUsage_Tfon_PhoneMute	= $2F;							{  On/Off Control  }
	kHIDUsage_Tfon_CallerID		= $30;							{  Momentary Control  }
																{  0x31 - 0x4F Reserved  }
	kHIDUsage_Tfon_SpeedDial	= $50;							{  One-Shot Control  }
	kHIDUsage_Tfon_StoreNumber	= $51;							{  One-Shot Control  }
	kHIDUsage_Tfon_RecallNumber	= $52;							{  One-Shot Control  }
	kHIDUsage_Tfon_PhoneDirectory = $53;						{  On/Off Control  }
																{  0x54 - 0x6F Reserved  }
	kHIDUsage_Tfon_VoiceMail	= $70;							{  On/Off Control  }
	kHIDUsage_Tfon_ScreenCalls	= $71;							{  On/Off Control  }
	kHIDUsage_Tfon_DoNotDisturb	= $72;							{  On/Off Control  }
	kHIDUsage_Tfon_Message		= $73;							{  One-Shot Control  }
	kHIDUsage_Tfon_AnswerOnOrOff = $74;							{  On/Off Control  }
																{  0x75 - 0x8F Reserved  }
	kHIDUsage_Tfon_InsideDialTone = $90;						{  Momentary Control  }
	kHIDUsage_Tfon_OutsideDialTone = $91;						{  Momentary Control  }
	kHIDUsage_Tfon_InsideRingTone = $92;						{  Momentary Control  }
	kHIDUsage_Tfon_OutsideRingTone = $93;						{  Momentary Control  }
	kHIDUsage_Tfon_PriorityRingTone = $94;						{  Momentary Control  }
	kHIDUsage_Tfon_InsideRingback = $95;						{  Momentary Control  }
	kHIDUsage_Tfon_PriorityRingback = $96;						{  Momentary Control  }
	kHIDUsage_Tfon_LineBusyTone	= $97;							{  Momentary Control  }
	kHIDUsage_Tfon_ReorderTone	= $98;							{  Momentary Control  }
	kHIDUsage_Tfon_CallWaitingTone = $99;						{  Momentary Control  }
	kHIDUsage_Tfon_ConfirmationTone1 = $9A;						{  Momentary Control  }
	kHIDUsage_Tfon_ConfirmationTone2 = $9B;						{  Momentary Control  }
	kHIDUsage_Tfon_TonesOff		= $9C;							{  On/Off Control  }
	kHIDUsage_Tfon_OutsideRingback = $9D;						{  Momentary Control  }
																{  0x9E - 0xAF Reserved  }
	kHIDUsage_Tfon_PhoneKey0	= $B0;							{  Selector/One-Shot Control  }
	kHIDUsage_Tfon_PhoneKey1	= $B1;							{  Selector/One-Shot Control  }
	kHIDUsage_Tfon_PhoneKey2	= $B2;							{  Selector/One-Shot Control  }
	kHIDUsage_Tfon_PhoneKey3	= $B3;							{  Selector/One-Shot Control  }
	kHIDUsage_Tfon_PhoneKey4	= $B4;							{  Selector/One-Shot Control  }
	kHIDUsage_Tfon_PhoneKey5	= $B5;							{  Selector/One-Shot Control  }
	kHIDUsage_Tfon_PhoneKey6	= $B6;							{  Selector/One-Shot Control  }
	kHIDUsage_Tfon_PhoneKey7	= $B7;							{  Selector/One-Shot Control  }
	kHIDUsage_Tfon_PhoneKey8	= $B8;							{  Selector/One-Shot Control  }
	kHIDUsage_Tfon_PhoneKey9	= $B9;							{  Selector/One-Shot Control  }
	kHIDUsage_Tfon_PhoneKeyStar	= $BA;							{  Selector/One-Shot Control  }
	kHIDUsage_Tfon_PhoneKeyPound = $BB;							{  Selector/One-Shot Control  }
	kHIDUsage_Tfon_PhoneKeyA	= $BC;							{  Selector/One-Shot Control  }
	kHIDUsage_Tfon_PhoneKeyB	= $BD;							{  Selector/One-Shot Control  }
	kHIDUsage_Tfon_PhoneKeyC	= $BE;							{  Selector/One-Shot Control  }
	kHIDUsage_Tfon_PhoneKeyD	= $BF;							{  Selector/One-Shot Control  }
																{  0xC0 - 0xFFFF Reserved  }
	kHIDUsage_TFon_Reserved		= $FFFF;

	{	 Consumer Page (0x0C) 	}
	{	 All controls on the Consumer page are application-specific. That is, they affect a specific device, not the system as a whole. 	}
	kHIDUsage_Csmr_ConsumerControl = $01;						{  Application Collection  }
	kHIDUsage_Csmr_NumericKeyPad = $02;							{  Named Array  }
	kHIDUsage_Csmr_ProgrammableButtons = $03;					{  Named Array  }
																{  0x03 - 0x1F Reserved  }
	kHIDUsage_Csmr_Plus10		= $20;							{  One-Shot Control  }
	kHIDUsage_Csmr_Plus100		= $21;							{  One-Shot Control  }
	kHIDUsage_Csmr_AMOrPM		= $22;							{  One-Shot Control  }
																{  0x23 - 0x3F Reserved  }
	kHIDUsage_Csmr_Power		= $30;							{  On/Off Control  }
	kHIDUsage_Csmr_Reset		= $31;							{  One-Shot Control  }
	kHIDUsage_Csmr_Sleep		= $32;							{  One-Shot Control  }
	kHIDUsage_Csmr_SleepAfter	= $33;							{  One-Shot Control  }
	kHIDUsage_Csmr_SleepMode	= $34;							{  Re-Trigger Control  }
	kHIDUsage_Csmr_Illumination	= $35;							{  On/Off Control  }
	kHIDUsage_Csmr_FunctionButtons = $36;						{  Named Array  }
																{  0x37 - 0x3F Reserved  }
	kHIDUsage_Csmr_Menu			= $40;							{  On/Off Control  }
	kHIDUsage_Csmr_MenuPick		= $41;							{  One-Shot Control  }
	kHIDUsage_Csmr_MenuUp		= $42;							{  One-Shot Control  }
	kHIDUsage_Csmr_MenuDown		= $43;							{  One-Shot Control  }
	kHIDUsage_Csmr_MenuLeft		= $44;							{  One-Shot Control  }
	kHIDUsage_Csmr_MenuRight	= $45;							{  One-Shot Control  }
	kHIDUsage_Csmr_MenuEscape	= $46;							{  One-Shot Control  }
	kHIDUsage_Csmr_MenuValueIncrease = $47;						{  One-Shot Control  }
	kHIDUsage_Csmr_MenuValueDecrease = $48;						{  One-Shot Control  }
																{  0x49 - 0x5F Reserved  }
	kHIDUsage_Csmr_DataOnScreen	= $60;							{  On/Off Control  }
	kHIDUsage_Csmr_ClosedCaption = $61;							{  On/Off Control  }
	kHIDUsage_Csmr_ClosedCaptionSelect = $62;					{  Selector  }
	kHIDUsage_Csmr_VCROrTV		= $63;							{  On/Off Control  }
	kHIDUsage_Csmr_BroadcastMode = $64;							{  One-Shot Control  }
	kHIDUsage_Csmr_Snapshot		= $65;							{  One-Shot Control  }
	kHIDUsage_Csmr_Still		= $66;							{  One-Shot Control  }
																{  0x67 - 0x7F Reserved  }
	kHIDUsage_Csmr_Selection	= $80;							{  Named Array  }
	kHIDUsage_Csmr_Assign		= $81;							{  Selector  }
	kHIDUsage_Csmr_ModeStep		= $82;							{  One-Shot Control  }
	kHIDUsage_Csmr_RecallLast	= $83;							{  One-Shot Control  }
	kHIDUsage_Csmr_EnterChannel	= $84;							{  One-Shot Control  }
	kHIDUsage_Csmr_OrderMovie	= $85;							{  One-Shot Control  }
	kHIDUsage_Csmr_Channel		= $86;							{  Linear Control  }
	kHIDUsage_Csmr_MediaSelection = $87;						{  Selector  }
	kHIDUsage_Csmr_MediaSelectComputer = $88;					{  Selector  }
	kHIDUsage_Csmr_MediaSelectTV = $89;							{  Selector  }
	kHIDUsage_Csmr_MediaSelectWWW = $8A;						{  Selector  }
	kHIDUsage_Csmr_MediaSelectDVD = $8B;						{  Selector  }
	kHIDUsage_Csmr_MediaSelectTelephone = $8C;					{  Selector  }
	kHIDUsage_Csmr_MediaSelectProgramGuide = $8D;				{  Selector  }
	kHIDUsage_Csmr_MediaSelectVideoPhone = $8E;					{  Selector  }
	kHIDUsage_Csmr_MediaSelectGames = $8F;						{  Selector  }
	kHIDUsage_Csmr_MediaSelectMessages = $90;					{  Selector  }
	kHIDUsage_Csmr_MediaSelectCD = $91;							{  Selector  }
	kHIDUsage_Csmr_MediaSelectVCR = $92;						{  Selector  }
	kHIDUsage_Csmr_MediaSelectTuner = $93;						{  Selector  }
	kHIDUsage_Csmr_Quit			= $94;							{  One-Shot Control  }
	kHIDUsage_Csmr_Help			= $95;							{  On/Off Control  }
	kHIDUsage_Csmr_MediaSelectTape = $96;						{  Selector  }
	kHIDUsage_Csmr_MediaSelectCable = $97;						{  Selector  }
	kHIDUsage_Csmr_MediaSelectSatellite = $98;					{  Selector  }
	kHIDUsage_Csmr_MediaSelectSecurity = $99;					{  Selector  }
	kHIDUsage_Csmr_MediaSelectHome = $9A;						{  Selector  }
	kHIDUsage_Csmr_MediaSelectCall = $9B;						{  Selector  }
	kHIDUsage_Csmr_ChannelIncrement = $9C;						{  One-Shot Control  }
	kHIDUsage_Csmr_ChannelDecrement = $9D;						{  One-Shot Control  }
	kHIDUsage_Csmr_Media		= $9E;							{  Selector  }
																{  0x9F Reserved  }
	kHIDUsage_Csmr_VCRPlus		= $A0;							{  One-Shot Control  }
	kHIDUsage_Csmr_Once			= $A1;							{  One-Shot Control  }
	kHIDUsage_Csmr_Daily		= $A2;							{  One-Shot Control  }
	kHIDUsage_Csmr_Weekly		= $A3;							{  One-Shot Control  }
	kHIDUsage_Csmr_Monthly		= $A4;							{  One-Shot Control  }
																{  0xA5 - 0xAF Reserved  }
	kHIDUsage_Csmr_Play			= $B0;							{  On/Off Control  }
	kHIDUsage_Csmr_Pause		= $B1;							{  On/Off Control  }
	kHIDUsage_Csmr_Record		= $B2;							{  On/Off Control  }
	kHIDUsage_Csmr_FastForward	= $B3;							{  On/Off Control  }
	kHIDUsage_Csmr_Rewind		= $B4;							{  On/Off Control  }
	kHIDUsage_Csmr_ScanNextTrack = $B5;							{  One-Shot Control  }
	kHIDUsage_Csmr_ScanPreviousTrack = $B6;						{  One-Shot Control  }
	kHIDUsage_Csmr_Stop			= $B7;							{  One-Shot Control  }
	kHIDUsage_Csmr_Eject		= $B8;							{  One-Shot Control  }
	kHIDUsage_Csmr_RandomPlay	= $B9;							{  On/Off Control  }
	kHIDUsage_Csmr_SelectDisc	= $BA;							{  Named Array  }
	kHIDUsage_Csmr_EnterDisc	= $BB;							{  Momentary Control  }
	kHIDUsage_Csmr_Repeat		= $BC;							{  One-Shot Control  }
	kHIDUsage_Csmr_Tracking		= $BD;							{  Linear Control  }
	kHIDUsage_Csmr_TrackNormal	= $BE;							{  One-Shot Control  }
	kHIDUsage_Csmr_SlowTracking	= $BF;							{  Linear Control  }
	kHIDUsage_Csmr_FrameForward	= $C0;							{  Re-Trigger Control  }
	kHIDUsage_Csmr_FrameBack	= $C1;							{  Re-Trigger Control  }
	kHIDUsage_Csmr_Mark			= $C2;							{  One-Shot Control  }
	kHIDUsage_Csmr_ClearMark	= $C3;							{  One-Shot Control  }
	kHIDUsage_Csmr_RepeatFromMark = $C4;						{  On/Off Control  }
	kHIDUsage_Csmr_ReturnToMark	= $C5;							{  One-Shot Control  }
	kHIDUsage_Csmr_SearchMarkForward = $C6;						{  One-Shot Control  }
	kHIDUsage_Csmr_SearchMarkBackwards = $C7;					{  One-Shot Control  }
	kHIDUsage_Csmr_CounterReset	= $C8;							{  One-Shot Control  }
	kHIDUsage_Csmr_ShowCounter	= $C9;							{  One-Shot Control  }
	kHIDUsage_Csmr_TrackingIncrement = $CA;						{  Re-Trigger Control  }
	kHIDUsage_Csmr_TrackingDecrement = $CB;						{  Re-Trigger Control  }
	kHIDUsage_Csmr_StopOrEject	= $CC;							{  One-Shot Control  }
	kHIDUsage_Csmr_PlayOrPause	= $CD;							{  One-Shot Control  }
	kHIDUsage_Csmr_PlayOrSkip	= $CE;							{  One-Shot Control  }
																{  0xCF - 0xDF Reserved  }
	kHIDUsage_Csmr_Volume		= $E0;							{  Linear Control  }
	kHIDUsage_Csmr_Balance		= $E1;							{  Linear Control  }
	kHIDUsage_Csmr_Mute			= $E2;							{  On/Off Control  }
	kHIDUsage_Csmr_Bass			= $E3;							{  Linear Control  }
	kHIDUsage_Csmr_Treble		= $E4;							{  Linear Control  }
	kHIDUsage_Csmr_BassBoost	= $E5;							{  On/Off Control  }
	kHIDUsage_Csmr_SurroundMode	= $E6;							{  One-Shot Control  }
	kHIDUsage_Csmr_Loudness		= $E7;							{  On/Off Control  }
	kHIDUsage_Csmr_MPX			= $E8;							{  On/Off Control  }
	kHIDUsage_Csmr_VolumeIncrement = $E9;						{  Re-Trigger Control  }
	kHIDUsage_Csmr_VolumeDecrement = $EA;						{  Re-Trigger Control  }
																{  0xEB - 0xEF Reserved  }
	kHIDUsage_Csmr_Speed		= $F0;							{  Selector  }
	kHIDUsage_Csmr_PlaybackSpeed = $F1;							{  Named Array  }
	kHIDUsage_Csmr_StandardPlay	= $F2;							{  Selector  }
	kHIDUsage_Csmr_LongPlay		= $F3;							{  Selector  }
	kHIDUsage_Csmr_ExtendedPlay	= $F4;							{  Selector  }
	kHIDUsage_Csmr_Slow			= $F5;							{  One-Shot Control  }
																{  0xF6 - 0xFF Reserved  }
	kHIDUsage_Csmr_FanEnable	= $0100;						{  On/Off Control  }
	kHIDUsage_Csmr_FanSpeed		= $0101;						{  Linear Control  }
	kHIDUsage_Csmr_LightEnable	= $0102;						{  On/Off Control  }
	kHIDUsage_Csmr_LightIlluminationLevel = $0103;				{  Linear Control  }
	kHIDUsage_Csmr_ClimateControlEnable = $0104;				{  On/Off Control  }
	kHIDUsage_Csmr_RoomTemperature = $0105;						{  Linear Control  }
	kHIDUsage_Csmr_SecurityEnable = $0106;						{  On/Off Control  }
	kHIDUsage_Csmr_FireAlarm	= $0107;						{  One-Shot Control  }
	kHIDUsage_Csmr_PoliceAlarm	= $0108;						{  One-Shot Control  }
																{  0x109 - 0x14F Reserved  }
	kHIDUsage_Csmr_BalanceRight	= $0150;						{  Re-Trigger Control  }
	kHIDUsage_Csmr_BalanceLeft	= $0151;						{  Re-Trigger Control  }
	kHIDUsage_Csmr_BassIncrement = $0152;						{  Re-Trigger Control  }
	kHIDUsage_Csmr_BassDecrement = $0153;						{  Re-Trigger Control  }
	kHIDUsage_Csmr_TrebleIncrement = $0154;						{  Re-Trigger Control  }
	kHIDUsage_Csmr_TrebleDecrement = $0155;						{  Re-Trigger Control  }
																{  0x156 - 0x15F Reserved  }
	kHIDUsage_Csmr_SpeakerSystem = $0160;						{  Logical Collection  }
	kHIDUsage_Csmr_ChannelLeft	= $0161;						{  Logical Collection  }
	kHIDUsage_Csmr_ChannelRight	= $0162;						{  Logical Collection  }
	kHIDUsage_Csmr_ChannelCenter = $0163;						{  Logical Collection  }
	kHIDUsage_Csmr_ChannelFront	= $0164;						{  Logical Collection  }
	kHIDUsage_Csmr_ChannelCenterFront = $0165;					{  Logical Collection  }
	kHIDUsage_Csmr_ChannelSide	= $0166;						{  Logical Collection  }
	kHIDUsage_Csmr_ChannelSurround = $0167;						{  Logical Collection  }
	kHIDUsage_Csmr_ChannelLowFrequencyEnhancement = $0168;		{  Logical Collection  }
	kHIDUsage_Csmr_ChannelTop	= $0169;						{  Logical Collection  }
	kHIDUsage_Csmr_ChannelUnknown = $016A;						{  Logical Collection  }
																{  0x16B - 0x16F Reserved  }
	kHIDUsage_Csmr_SubChannel	= $0170;						{  Linear Control  }
	kHIDUsage_Csmr_SubChannelIncrement = $0171;					{  One-Shot Control  }
	kHIDUsage_Csmr_SubChannelDecrement = $0172;					{  One-Shot Control  }
	kHIDUsage_Csmr_AlternateAudioIncrement = $0173;				{  One-Shot Control  }
	kHIDUsage_Csmr_AlternateAudioDecrement = $0174;				{  One-Shot Control  }
																{  0x175 - 0x17F Reserved  }
	kHIDUsage_Csmr_ApplicationLaunchButtons = $0180;			{  Named Array  }
	kHIDUsage_Csmr_ALLaunchButtonConfigurationTool = $0181;		{  Selector  }
	kHIDUsage_Csmr_ALProgrammableButtonConfiguration = $0182;	{  Selector  }
	kHIDUsage_Csmr_ALConsumerControlConfiguration = $0183;		{  Selector  }
	kHIDUsage_Csmr_ALWordProcessor = $0184;						{  Selector  }
	kHIDUsage_Csmr_ALTextEditor	= $0185;						{  Selector  }
	kHIDUsage_Csmr_ALSpreadsheet = $0186;						{  Selector  }
	kHIDUsage_Csmr_ALGraphicsEditor = $0187;					{  Selector  }
	kHIDUsage_Csmr_ALPresentationApp = $0188;					{  Selector  }
	kHIDUsage_Csmr_ALDatabaseApp = $0189;						{  Selector  }
	kHIDUsage_Csmr_ALEmailReader = $018A;						{  Selector  }
	kHIDUsage_Csmr_ALNewsreader	= $018B;						{  Selector  }
	kHIDUsage_Csmr_ALVoicemail	= $018C;						{  Selector  }
	kHIDUsage_Csmr_ALContactsOrAddressBook = $018D;				{  Selector  }
	kHIDUsage_Csmr_ALCalendarOrSchedule = $018E;				{  Selector  }
	kHIDUsage_Csmr_ALTaskOrProjectManager = $018F;				{  Selector  }
	kHIDUsage_Csmr_ALLogOrJournalOrTimecard = $0190;			{  Selector  }
	kHIDUsage_Csmr_ALCheckbookOrFinance = $0191;				{  Selector  }
	kHIDUsage_Csmr_ALCalculator	= $0192;						{  Selector  }
	kHIDUsage_Csmr_ALAOrVCaptureOrPlayback = $0193;				{  Selector  }
	kHIDUsage_Csmr_ALLocalMachineBrowser = $0194;				{  Selector  }
	kHIDUsage_Csmr_ALLANOrWANBrowser = $0195;					{  Selector  }
	kHIDUsage_Csmr_ALInternetBrowser = $0196;					{  Selector  }
	kHIDUsage_Csmr_ALRemoteNetworkingOrISPConnect = $0197;		{  Selector  }
	kHIDUsage_Csmr_ALNetworkConference = $0198;					{  Selector  }
	kHIDUsage_Csmr_ALNetworkChat = $0199;						{  Selector  }
	kHIDUsage_Csmr_ALTelephonyOrDialer = $019A;					{  Selector  }
	kHIDUsage_Csmr_ALLogon		= $019B;						{  Selector  }
	kHIDUsage_Csmr_ALLogoff		= $019C;						{  Selector  }
	kHIDUsage_Csmr_ALLogonOrLogoff = $019D;						{  Selector  }
	kHIDUsage_Csmr_ALTerminalLockOrScreensaver = $019E;			{  Selector  }
	kHIDUsage_Csmr_ALControlPanel = $019F;						{  Selector  }
	kHIDUsage_Csmr_ALCommandLineProcessorOrRun = $01A0;			{  Selector  }
	kHIDUsage_Csmr_ALProcessOrTaskManager = $01A1;				{  Selector  }
	kHIDUsage_Csmr_AL			= $01A2;						{  Selector  }
	kHIDUsage_Csmr_ALNextTaskOrApplication = $0143;				{  Selector  }
	kHIDUsage_Csmr_ALPreviousTaskOrApplication = $01A4;			{  Selector  }
	kHIDUsage_Csmr_ALPreemptiveHaltTaskOrApplication = $01A5;	{  Selector  }
																{  0x1A6 - 0x1FF Reserved  }
	kHIDUsage_Csmr_GenericGUIApplicationControls = $0200;		{  Named Array  }
	kHIDUsage_Csmr_ACNew		= $0201;						{  Selector  }
	kHIDUsage_Csmr_ACOpen		= $0202;						{  Selector  }
	kHIDUsage_Csmr_ACClose		= $0203;						{  Selector  }
	kHIDUsage_Csmr_ACExit		= $0204;						{  Selector  }
	kHIDUsage_Csmr_ACMaximize	= $0205;						{  Selector  }
	kHIDUsage_Csmr_ACMinimize	= $0206;						{  Selector  }
	kHIDUsage_Csmr_ACSave		= $0207;						{  Selector  }
	kHIDUsage_Csmr_ACPrint		= $0208;						{  Selector  }
	kHIDUsage_Csmr_ACProperties	= $0209;						{  Selector  }
	kHIDUsage_Csmr_ACUndo		= $021A;						{  Selector  }
	kHIDUsage_Csmr_ACCopy		= $021B;						{  Selector  }
	kHIDUsage_Csmr_ACCut		= $021C;						{  Selector  }
	kHIDUsage_Csmr_ACPaste		= $021D;						{  Selector  }
	kHIDUsage_Csmr_AC			= $021E;						{  Selector  }
	kHIDUsage_Csmr_ACFind		= $021F;						{  Selector  }
	kHIDUsage_Csmr_ACFindandReplace = $0220;					{  Selector  }
	kHIDUsage_Csmr_ACSearch		= $0221;						{  Selector  }
	kHIDUsage_Csmr_ACGoTo		= $0222;						{  Selector  }
	kHIDUsage_Csmr_ACHome		= $0223;						{  Selector  }
	kHIDUsage_Csmr_ACBack		= $0224;						{  Selector  }
	kHIDUsage_Csmr_ACForward	= $0225;						{  Selector  }
	kHIDUsage_Csmr_ACStop		= $0226;						{  Selector  }
	kHIDUsage_Csmr_ACRefresh	= $0227;						{  Selector  }
	kHIDUsage_Csmr_ACPreviousLink = $0228;						{  Selector  }
	kHIDUsage_Csmr_ACNextLink	= $0229;						{  Selector  }
	kHIDUsage_Csmr_ACBookmarks	= $022A;						{  Selector  }
	kHIDUsage_Csmr_ACHistory	= $022B;						{  Selector  }
	kHIDUsage_Csmr_ACSubscriptions = $022C;						{  Selector  }
	kHIDUsage_Csmr_ACZoomIn		= $022D;						{  Selector  }
	kHIDUsage_Csmr_ACZoomOut	= $022E;						{  Selector  }
	kHIDUsage_Csmr_ACZoom		= $022F;						{  Selector  }
	kHIDUsage_Csmr_ACFullScreenView = $0230;					{  Selector  }
	kHIDUsage_Csmr_ACNormalView	= $0231;						{  Selector  }
	kHIDUsage_Csmr_ACViewToggle	= $0232;						{  Selector  }
	kHIDUsage_Csmr_ACScrollUp	= $0233;						{  Selector  }
	kHIDUsage_Csmr_ACScrollDown	= $0234;						{  Selector  }
	kHIDUsage_Csmr_ACScroll		= $0235;						{  Selector  }
	kHIDUsage_Csmr_ACPanLeft	= $0236;						{  Selector  }
	kHIDUsage_Csmr_ACPanRight	= $0237;						{  Selector  }
	kHIDUsage_Csmr_ACPan		= $0238;						{  Selector  }
	kHIDUsage_Csmr_ACNewWindow	= $0239;						{  Selector  }
	kHIDUsage_Csmr_ACTileHorizontally = $023A;					{  Selector  }
	kHIDUsage_Csmr_ACTileVertically = $023B;					{  Selector  }
	kHIDUsage_Csmr_ACFormat		= $023C;						{  Selector  }
																{  0x23D - 0xFFFF Reserved  }
	kHIDUsage_Csmr_Reserved		= $FFFF;

	{	 Digitizer Page (0x0D) 	}
	{	 This section provides detailed descriptions of the usages employed by Digitizer Devices. 	}
	kHIDUsage_Dig_Digitizer		= $01;							{  Application Collection  }
	kHIDUsage_Dig_Pen			= $02;							{  Application Collection  }
	kHIDUsage_Dig_LightPen		= $03;							{  Application Collection  }
	kHIDUsage_Dig_TouchScreen	= $04;							{  Application Collection  }
	kHIDUsage_Dig_TouchPad		= $05;							{  Application Collection  }
	kHIDUsage_Dig_WhiteBoard	= $06;							{  Application Collection  }
	kHIDUsage_Dig_CoordinateMeasuringMachine = $07;				{  Application Collection  }
	kHIDUsage_Dig_3DDigitizer	= $08;							{  Application Collection  }
	kHIDUsage_Dig_StereoPlotter	= $09;							{  Application Collection  }
	kHIDUsage_Dig_ArticulatedArm = $0A;							{  Application Collection  }
	kHIDUsage_Dig_Armature		= $0B;							{  Application Collection  }
	kHIDUsage_Dig_MultiplePointDigitizer = $0C;					{  Application Collection  }
	kHIDUsage_Dig_FreeSpaceWand	= $0D;							{  Application Collection  }
																{  0x0E - 0x1F Reserved  }
	kHIDUsage_Dig_Stylus		= $20;							{  Logical Collection  }
	kHIDUsage_Dig_Puck			= $21;							{  Logical Collection  }
	kHIDUsage_Dig_Finger		= $22;							{  Logical Collection  }
																{  0x23 - 0x2F Reserved  }
	kHIDUsage_Dig_TipPressure	= $30;							{  Dynamic Value  }
	kHIDUsage_Dig_BarrelPressure = $31;							{  Dynamic Value  }
	kHIDUsage_Dig_InRange		= $32;							{  Momentary Control  }
	kHIDUsage_Dig_Touch			= $33;							{  Momentary Control  }
	kHIDUsage_Dig_Untouch		= $34;							{  One-Shot Control  }
	kHIDUsage_Dig_Tap			= $35;							{  One-Shot Control  }
	kHIDUsage_Dig_Quality		= $36;							{  Dynamic Value  }
	kHIDUsage_Dig_DataValid		= $37;							{  Momentary Control  }
	kHIDUsage_Dig_TransducerIndex = $38;						{  Dynamic Value  }
	kHIDUsage_Dig_TabletFunctionKeys = $39;						{  Logical Collection  }
	kHIDUsage_Dig_ProgramChangeKeys = $3A;						{  Logical Collection  }
	kHIDUsage_Dig_BatteryStrength = $3B;						{  Dynamic Value  }
	kHIDUsage_Dig_Invert		= $3C;							{  Momentary Control  }
	kHIDUsage_Dig_XTilt			= $3D;							{  Dynamic Value  }
	kHIDUsage_Dig_YTilt			= $3E;							{  Dynamic Value  }
	kHIDUsage_Dig_Azimuth		= $3F;							{  Dynamic Value  }
	kHIDUsage_Dig_Altitude		= $40;							{  Dynamic Value  }
	kHIDUsage_Dig_Twist			= $41;							{  Dynamic Value  }
	kHIDUsage_Dig_TipSwitch		= $42;							{  Momentary Control  }
	kHIDUsage_Dig_SecondaryTipSwitch = $43;						{  Momentary Control  }
	kHIDUsage_Dig_BarrelSwitch	= $44;							{  Momentary Control  }
	kHIDUsage_Dig_Eraser		= $45;							{  Momentary Control  }
	kHIDUsage_Dig_TabletPick	= $46;							{  Momentary Control  }
																{  0x47 - 0xFFFF Reserved  }
	kHIDUsage_Dig_Reserved		= $FFFF;

	{	 AlphanumericDisplay Page (0x14) 	}
	{	 The Alphanumeric Display page is intended for use by simple alphanumeric displays that are used on consumer devices. 	}
	kHIDUsage_AD_AlphanumericDisplay = $01;						{  Application Collection  }
																{  0x02 - 0x1F Reserved  }
	kHIDUsage_AD_DisplayAttributesReport = $20;					{  Logical Collection  }
	kHIDUsage_AD_ASCIICharacterSet = $21;						{  Static Flag  }
	kHIDUsage_AD_DataReadBack	= $22;							{  Static Flag  }
	kHIDUsage_AD_FontReadBack	= $23;							{  Static Flag  }
	kHIDUsage_AD_DisplayControlReport = $24;					{  Logical Collection  }
	kHIDUsage_AD_ClearDisplay	= $25;							{  Dynamic Flag  }
	kHIDUsage_AD_DisplayEnable	= $26;							{  Dynamic Flag  }
	kHIDUsage_AD_ScreenSaverDelay = $27;						{  Static Value  }
	kHIDUsage_AD_ScreenSaverEnable = $28;						{  Dynamic Flag  }
	kHIDUsage_AD_VerticalScroll	= $29;							{  Static Flag  }
	kHIDUsage_AD_HorizontalScroll = $2A;						{  Static Flag  }
	kHIDUsage_AD_CharacterReport = $2B;							{  Logical Collection  }
	kHIDUsage_AD_DisplayData	= $2C;							{  Dynamic Value  }
	kHIDUsage_AD_DisplayStatus	= $2D;							{  Logical Collection  }
	kHIDUsage_AD_StatNotReady	= $2E;							{  Selector  }
	kHIDUsage_AD_StatReady		= $2F;							{  Selector  }
	kHIDUsage_AD_ErrNotaloadablecharacter = $30;				{  Selector  }
	kHIDUsage_AD_ErrFontdatacannotberead = $31;					{  Selector  }
	kHIDUsage_AD_CursorPositionReport = $32;					{  Logical Collection  }
	kHIDUsage_AD_Row			= $33;							{  Dynamic Value  }
	kHIDUsage_AD_Column			= $34;							{  Dynamic Value  }
	kHIDUsage_AD_Rows			= $35;							{  Static Value  }
	kHIDUsage_AD_Columns		= $36;							{  Static Value  }
	kHIDUsage_AD_CursorPixelPositioning = $37;					{  Static Flag  }
	kHIDUsage_AD_CursorMode		= $38;							{  Dynamic Flag  }
	kHIDUsage_AD_CursorEnable	= $39;							{  Dynamic Flag  }
	kHIDUsage_AD_CursorBlink	= $3A;							{  Dynamic Flag  }
	kHIDUsage_AD_FontReport		= $3B;							{  Logical Collection  }
	kHIDUsage_AD_FontData		= $3C;							{  Buffered Byte  }
	kHIDUsage_AD_CharacterWidth	= $3D;							{  Static Value  }
	kHIDUsage_AD_CharacterHeight = $3E;							{  Static Value  }
	kHIDUsage_AD_CharacterSpacingHorizontal = $3F;				{  Static Value  }
	kHIDUsage_AD_CharacterSpacingVertical = $40;				{  Static Value  }
	kHIDUsage_AD_UnicodeCharacterSet = $41;						{  Static Flag  }
																{  0x42 - 0xFFFF Reserved  }
	kHIDUsage_AD_Reserved		= $FFFF;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := HIDIncludes}

{$ENDC} {__HID__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

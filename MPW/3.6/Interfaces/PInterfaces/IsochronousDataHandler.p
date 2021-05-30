{
     File:       IsochronousDataHandler.p
 
     Contains:   The defines the client API to an Isochronous Data Handler, which is
 
     Version:    Technology: xxx put version here xxx
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1997-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT IsochronousDataHandler;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ISOCHRONOUSDATAHANDLER__}
{$SETC __ISOCHRONOUSDATAHANDLER__ := 1}

{$I+}
{$SETC IsochronousDataHandlerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MOVIESFORMAT__}
{$I MoviesFormat.p}
{$ENDC}
{$IFC UNDEFINED __QUICKTIMECOMPONENTS__}
{$I QuickTimeComponents.p}
{$ENDC}





{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kIDHComponentType			= 'ihlr';						{  Component type }
	kIDHSubtypeDV				= 'dv  ';						{  Subtype for DV (over FireWire) }
	kIDHSubtypeFireWireConference = 'fwc ';						{  Subtype for FW Conference }


	{  Version of Isochronous Data Handler API }
	kIDHInterfaceVersion1		= $0001;						{  Initial relase (Summer '99) }


	{  atom types }

	kIDHDeviceListAtomType		= 'dlst';
	kIDHDeviceAtomType			= 'devc';						{  to be defined elsewhere }
	kIDHIsochServiceAtomType	= 'isoc';
	kIDHIsochModeAtomType		= 'mode';
	kIDHDeviceIDType			= 'dvid';
	kIDHDefaultIOType			= 'dfio';
	kIDHIsochVersionAtomType	= 'iver';
	kIDHUniqueIDType			= 'unid';
	kIDHNameAtomType			= 'name';
	kIDHUseCMPAtomType			= 'ucmp';
	kIDHIsochMediaType			= 'av  ';
	kIDHDataTypeAtomType		= 'dtyp';
	kIDHDataSizeAtomType		= 'dsiz';						{  ??? packet size vs. buffer size }
	kIDHDataBufferSizeAtomType	= 'dbuf';						{  ??? packet size vs. buffer size }
	kIDHDataIntervalAtomType	= 'intv';
	kIDHDataIODirectionAtomType	= 'ddir';
	kIDHSoundMediaAtomType		= 'soun';
	kIDHSoundTypeAtomType		= 'type';
	kIDHSoundChannelCountAtomType = 'ccnt';
	kIDHSoundSampleSizeAtomType	= 'ssiz';
	kIDHSoundSampleRateAtomType	= 'srat';						{  same as video out... (what does this comment mean?) }
	kIDHVideoMediaAtomType		= 'vide';
	kIDHVideoDimensionsAtomType	= 'dimn';
	kIDHVideoResolutionAtomType	= 'resl';
	kIDHVideoRefreshRateAtomType = 'refr';
	kIDHVideoPixelTypeAtomType	= 'pixl';
	kIDHVideoDecompressorAtomType = 'deco';
	kIDHVideoDecompressorTypeAtomType = 'dety';
	kIDHVideoDecompressorContinuousAtomType = 'cont';
	kIDHVideoDecompressorComponentAtomType = 'cmpt';

	{  I/O Flags  }
	kIDHDataTypeIsInput			= $00000001;
	kIDHDataTypeIsOutput		= $00000002;
	kIDHDataTypeIsInputAndOutput = $00000004;


	{  Permission Flags  }
	kIDHOpenForReadTransactions	= $00000001;
	kIDHOpenForWriteTransactions = $00000002;
	kIDHOpenWithExclusiveAccess	= $00000004;
	kIDHOpenWithHeldBuffers		= $00000008;					{  IDH will hold buffer until ReleaseBuffer() }
	kIDHCloseForReadTransactions = $00000010;
	kIDHCloseForWriteTransactions = $00000020;


	{
	   Errors 
	    These REALLY need to be moved into Errors.h
	   ••• needs officially assigned numbers
	}
	kIDHErrDeviceDisconnected	= -14101;
	kIDHErrInvalidDeviceID		= -14102;
	kIDHErrDeviceInUse			= -14104;
	kIDHErrDeviceNotOpened		= -14105;
	kIDHErrDeviceBusy			= -14106;
	kIDHErrDeviceReadError		= -14107;
	kIDHErrDeviceWriteError		= -14108;
	kIDHErrDeviceNotConfigured	= -14109;
	kIDHErrDeviceList			= -14110;
	kIDHErrCompletionPending	= -14111;
	kIDHErrDeviceTimeout		= -14112;
	kIDHErrInvalidIndex			= -14113;
	kIDHErrDeviceCantRead		= -14114;
	kIDHErrDeviceCantWrite		= -14115;
	kIDHErrCallNotSupported		= -14116;




	{  Holds Device Identification... }

TYPE
	IDHDeviceID							= UInt32;

CONST
	kIDHInvalidDeviceID			= 0;
	kIDHDeviceIDEveryDevice		= $FFFFFFFF;


	{   Isoch Interval Atom Data }

TYPE
	IDHIsochIntervalPtr = ^IDHIsochInterval;
	IDHIsochInterval = RECORD
		duration:				SInt32;
		scale:					TimeScale;
	END;

	{  Need to fix this.  For now, cast this as a FWReferenceID }
	PsuedoID    = ^LONGINT; { an opaque 32-bit type }
	PsuedoIDPtr = ^PsuedoID;  { when a VAR xx:PsuedoID parameter can be nil, it is changed to xx: PsuedoIDPtr }
	{
	   Isoch Device Status
	    This is atom-like, but isn’t an atom
	}
	IDHDeviceStatusPtr = ^IDHDeviceStatus;
	IDHDeviceStatus = RECORD
		version:				UInt32;
		physicallyConnected:	BOOLEAN;
		readEnabled:			BOOLEAN;
		writeEnabled:			BOOLEAN;
		exclusiveAccess:		BOOLEAN;
		currentBandwidth:		UInt32;
		currentChannel:			UInt32;
		localNodeID:			PsuedoID;								{ ••• may go in atoms  }
		inputStandard:			SInt16;									{  One of the QT input standards }
		deviceActive:			BOOLEAN;
	END;

	{
	   Isochronous Data Handler Events
	    
	}
	IDHEvent							= UInt32;

CONST
	kIDHEventInvalid			= 0;
	kIDHEventDeviceAdded		= $00000001;					{  A new device has been added to the bus }
	kIDHEventDeviceRemoved		= $00000002;					{  A device has been removed from the bus }
	kIDHEventDeviceChanged		= $00000004;					{  Some device has changed state on the bus }
	kIDHEventReadEnabled		= $00000008;					{  A client has enabled a device for read }
	kIDHEventReserved1			= $00000010;					{  Reserved for future use }
	kIDHEventReadDisabled		= $00000020;					{  A client has disabled a device from read }
	kIDHEventWriteEnabled		= $00000040;					{  A client has enabled a device for write }
	kIDHEventReserved2			= $00000080;					{  Reserved for future use }
	kIDHEventWriteDisabled		= $00000100;					{  A client has disabled a device for write }
	kIDHEventEveryEvent			= $FFFFFFFF;


TYPE
	IDHNotificationID					= UInt32;
	IDHEventHeaderPtr = ^IDHEventHeader;
	IDHEventHeader = RECORD
		deviceID:				IDHDeviceID;							{  Device which generated event }
		notificationID:			IDHNotificationID;
		event:					IDHEvent;								{  What the event is }
	END;




	{
	   IDHGenericEvent
	    An IDH will often have to post events from at interrupt time.  Since memory
	    allocation cannot occur from the interrupt handler, the IDH can preallocate
	    storage needed for handling the event by creating some IDHGenericEvent items.
	    Subsequently, when an event is generated, the type of event (specified in the
	    IDHEventHeader) will dictate how the IDHGenericEvent should be interpretted.
	    
	    IMPORTANT NOTE : This means that a specific event structure can NEVER be greater
	    than the size of the generic one.
	    
	}
	IDHGenericEventPtr = ^IDHGenericEvent;
	IDHGenericEvent = RECORD
		eventHeader:			IDHEventHeader;
		pad:					ARRAY [0..3] OF UInt32;
	END;

	{
	   IDHDeviceConnectionEvent
	    For kIDHEventDeviceAdded or kIDHEventDeviceRemoved events.
	}
	IDHDeviceConnectionEventPtr = ^IDHDeviceConnectionEvent;
	IDHDeviceConnectionEvent = RECORD
		eventHeader:			IDHEventHeader;
	END;

	{
	   IDHDeviceIOEnableEvent
	    For kIDHEventReadEnabled, kIDHEventReadDisabled, kIDHEventWriteEnabled, or
	    kIDHEventWriteDisabled.
	}
	IDHDeviceIOEnableEventPtr = ^IDHDeviceIOEnableEvent;
	IDHDeviceIOEnableEvent = RECORD
		eventHeader:			IDHEventHeader;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	IDHNotificationProc = FUNCTION(VAR event: IDHGenericEvent; userData: UNIV Ptr): OSStatus; C;
{$ELSEC}
	IDHNotificationProc = ProcPtr;
{$ENDC}

	IDHParameterBlockPtr = ^IDHParameterBlock;
	IDHParameterBlock = RECORD
		reserved1:				UInt32;
		reserved2:				UInt16;
		buffer:					Ptr;
		requestedCount:			ByteCount;
		actualCount:			ByteCount;
		completionProc:			IDHNotificationProc;
		refCon:					Ptr;
		result:					OSErr;
	END;

	IDHResolutionPtr = ^IDHResolution;
	IDHResolution = RECORD
		x:						UInt32;
		y:						UInt32;
	END;

	IDHDimensionPtr = ^IDHDimension;
	IDHDimension = RECORD
		x:						Fixed;
		y:						Fixed;
	END;


	{
	 *  IDHGetDeviceList()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in IDHLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         not available
	 	}
FUNCTION IDHGetDeviceList(idh: ComponentInstance; VAR deviceList: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}

{
 *  IDHGetDeviceConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHGetDeviceConfiguration(idh: ComponentInstance; VAR configurationID: QTAtomSpec): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0002, $7000, $A82A;
	{$ENDC}

{
 *  IDHSetDeviceConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHSetDeviceConfiguration(idh: ComponentInstance; {CONST}VAR configurationID: QTAtomSpec): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}

{
 *  IDHGetDeviceStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHGetDeviceStatus(idh: ComponentInstance; {CONST}VAR configurationID: QTAtomSpec; VAR status: IDHDeviceStatus): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0004, $7000, $A82A;
	{$ENDC}

{
 *  IDHGetDeviceClock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHGetDeviceClock(idh: ComponentInstance; VAR clock: Component): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}

{
 *  IDHOpenDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHOpenDevice(idh: ComponentInstance; permissions: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}

{
 *  IDHCloseDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHCloseDevice(idh: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0007, $7000, $A82A;
	{$ENDC}

{
 *  IDHRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHRead(idh: ComponentInstance; VAR pb: IDHParameterBlock): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0008, $7000, $A82A;
	{$ENDC}

{
 *  IDHWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHWrite(idh: ComponentInstance; VAR pb: IDHParameterBlock): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0009, $7000, $A82A;
	{$ENDC}

{
 *  IDHNewNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHNewNotification(idh: ComponentInstance; deviceID: IDHDeviceID; notificationProc: IDHNotificationProc; userData: UNIV Ptr; VAR notificationID: IDHNotificationID): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000A, $7000, $A82A;
	{$ENDC}

{
 *  IDHNotifyMeWhen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHNotifyMeWhen(idh: ComponentInstance; notificationID: IDHNotificationID; events: IDHEvent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000B, $7000, $A82A;
	{$ENDC}

{
 *  IDHCancelNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHCancelNotification(idh: ComponentInstance; notificationID: IDHNotificationID): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}

{
 *  IDHDisposeNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHDisposeNotification(idh: ComponentInstance; notificationID: IDHNotificationID): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}

{
 *  IDHReleaseBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHReleaseBuffer(idh: ComponentInstance; VAR pb: IDHParameterBlock): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000E, $7000, $A82A;
	{$ENDC}

{
 *  IDHCancelPendingIO()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHCancelPendingIO(idh: ComponentInstance; VAR pb: IDHParameterBlock): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000F, $7000, $A82A;
	{$ENDC}

{
 *  IDHGetDeviceControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHGetDeviceControl(idh: ComponentInstance; VAR deviceControl: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0010, $7000, $A82A;
	{$ENDC}

{
 *  IDHUpdateDeviceList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IDHLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         not available
 }
FUNCTION IDHUpdateDeviceList(idh: ComponentInstance; VAR deviceList: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0011, $7000, $A82A;
	{$ENDC}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := IsochronousDataHandlerIncludes}

{$ENDC} {__ISOCHRONOUSDATAHANDLER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

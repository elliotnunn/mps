{
     File:       VideoServices.p
 
     Contains:   Video Services Library Interfaces.
 
     Version:    Technology: PowerSurge 1.0.2
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT VideoServices;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __VIDEOSERVICES__}
{$SETC __VIDEOSERVICES__ := 1}

{$I+}
{$SETC VideoServicesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kTransparentEncoding		= 0;
	kInvertingEncoding			= 1;

	kTransparentEncodingShift	= $00;
	kTransparentEncodedPixel	= $01;
	kInvertingEncodingShift		= $02;
	kInvertingEncodedPixel		= $04;




	kHardwareCursorDescriptorMajorVersion = $0001;
	kHardwareCursorDescriptorMinorVersion = $0000;


TYPE
	UInt32Ptr							= ^UInt32;
	HardwareCursorDescriptorRecPtr = ^HardwareCursorDescriptorRec;
	HardwareCursorDescriptorRec = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		height:					UInt32;
		width:					UInt32;
		bitDepth:				UInt32;
		maskBitDepth:			UInt32;
		numColors:				UInt32;
		colorEncodings:			UInt32Ptr;
		flags:					UInt32;
		supportedSpecialEncodings: UInt32;
		specialEncodings:		ARRAY [0..15] OF UInt32;
	END;

	HardwareCursorDescriptorPtr			= ^HardwareCursorDescriptorRec;

CONST
	kHardwareCursorInfoMajorVersion = $0001;
	kHardwareCursorInfoMinorVersion = $0000;


TYPE
	HardwareCursorInfoRecPtr = ^HardwareCursorInfoRec;
	HardwareCursorInfoRec = RECORD
		majorVersion:			UInt16;									{  Test tool should check for kHardwareCursorInfoMajorVersion1 }
		minorVersion:			UInt16;									{  Test tool should check for kHardwareCursorInfoMinorVersion1 }
		cursorHeight:			UInt32;
		cursorWidth:			UInt32;
		colorMap:				CTabPtr;								{  nil or big enough for hardware's max colors }
		hardwareCursor:			Ptr;
		reserved:				ARRAY [0..5] OF UInt32;					{  Test tool should check for 0s }
	END;

	HardwareCursorInfoPtr				= ^HardwareCursorInfoRec;


CONST
	kVBLInterruptServiceType	= 'vbl ';
	kHBLInterruptServiceType	= 'hbl ';
	kFrameInterruptServiceType	= 'fram';
	kConnectInterruptServiceType = 'dci ';						{  Renamed -- Use kFBCheckInterruptServiceType }
	kFBConnectInterruptServiceType = 'dci ';					{  Demand to check configuration (Hardware unchanged) }
	kFBChangedInterruptServiceType = 'chng';					{  Demand to rebuild (Hardware has reinitialized on dependent change) }
	kFBOfflineInterruptServiceType = 'remv';					{  Demand to remove framebuffer (Hardware not available on dependent change -- but must not buserror) }
	kFBOnlineInterruptServiceType = 'add ';						{  Notice that hardware is available (after being removed) }

	kMaxDisplayConfigDataSize	= 64;							{  Max data size for VSLSetDisplayConfiguration }


TYPE
	InterruptServiceType				= ResType;
	InterruptServiceIDType				= UInt32;
	InterruptServiceIDPtr				= ^InterruptServiceIDType;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  VSLNewInterruptService()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in VideoServicesLib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION VSLNewInterruptService(VAR serviceDevice: RegEntryID; serviceType: InterruptServiceType; serviceID: InterruptServiceIDPtr): OSErr; C;

{
 *  VSLWaitOnInterruptService()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in VideoServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION VSLWaitOnInterruptService(serviceID: InterruptServiceIDType; timeout: Duration): OSErr; C;

{
 *  VSLDisposeInterruptService()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in VideoServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION VSLDisposeInterruptService(serviceID: InterruptServiceIDType): OSErr; C;

{
 *  VSLDoInterruptService()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in VideoServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION VSLDoInterruptService(serviceID: InterruptServiceIDType): OSErr; C;

{
 *  VSLPrepareCursorForHardwareCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in VideoServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION VSLPrepareCursorForHardwareCursor(cursorRef: UNIV Ptr; hardwareDescriptor: HardwareCursorDescriptorPtr; hwCursorInfo: HardwareCursorInfoPtr): BOOLEAN; C;

{
 *  VSLSetDisplayConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION VSLSetDisplayConfiguration(VAR device: RegEntryID; VAR propertyName: RegPropertyName; configData: UNIV Ptr; configDataSize: LONGINT): OSErr; C;


{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := VideoServicesIncludes}

{$ENDC} {__VIDEOSERVICES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

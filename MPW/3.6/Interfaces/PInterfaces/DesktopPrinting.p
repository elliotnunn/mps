{
     File:       DesktopPrinting.p
 
     Contains:   Print driver declarations for classic PrintMonitor and Desktop PrintMonitor
 
     Version:    Technology: Mac OS 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT DesktopPrinting;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DESKTOPPRINTING__}
{$SETC __DESKTOPPRINTING__ := 1}

{$I+}
{$SETC DesktopPrintingIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __PRINTING__}
{$I Printing.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}

{  PrGeneral opcodes for desktop printng }
{  DTP printer types (address types) }

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kDTPUnknownPrinterType		= -1;							{  unknown address type }
	kDTPSerialPrinterType		= 0;							{  serial printer }
	kDTPAppleTalkPrinterType	= 1;							{  AppleTalk printer }
	kDTPTCPIPPrinterType		= 2;							{  TCP/IP printer }
	kDTPSCSIPrinterType			= 3;							{  SCSI printer }
	kDTPUSBPrinterType			= 4;							{  USB printer }

	{  serial ports }
	kDTPUnknownPort				= -1;							{  for drivers that support serial connection by the  }
																{  Comm Toolbox other than modem and printer port }
	kDTPPrinterPort				= 0;							{  printer port }
	kDTPModemPort				= 1;							{  modem port }

	{  PrGeneral opcodes }
	kDTPGetPrinterInfo			= 23;
	kDTPIsSamePrinterInfo		= 24;
	kDTPSetDefaultPrinterInfo	= 25;

	{  serial printer address }

TYPE
	DTPSerialAddressPtr = ^DTPSerialAddress;
	DTPSerialAddress = RECORD
		port:					INTEGER;								{  kDTPPrinterPort, kDTPModemPort or kDTPUnknownPort }
		portName:				Str31;									{  name of the port specified in the port field }
	END;

	{  AppleTalk printer address }
	DTPAppleTalkAddressPtr = ^DTPAppleTalkAddress;
	DTPAppleTalkAddress = RECORD
		nbpName:				Str32;
		nbpZone:				Str32;
		nbpType:				Str32;
	END;

	{  TCP/IP printer address }
	DTPTCPIPAddressPtr = ^DTPTCPIPAddress;
	DTPTCPIPAddress = RECORD
		TCPIPAddress:			Str255;
		queueName:				Str255;
	END;

	{  SCSI printer address }
	DTPSCSIAddressPtr = ^DTPSCSIAddress;
	DTPSCSIAddress = RECORD
		id:						INTEGER;								{  SCSI id }
	END;

	{  USB printer address }
	DTPUSBAddressPtr = ^DTPUSBAddress;
	DTPUSBAddress = RECORD
		name:					Str255;									{  printer name }
	END;

	{  data passed into the PrGeneral calls }
	DTPPrinterInfoPtr = ^DTPPrinterInfo;
	DTPPrinterInfo = RECORD
		dtpDefaultName:			Str31;									{  default name for the desktop printer. }
		printerType:			INTEGER;								{  kDTPSerialPrinterType, kDTPAppleTalkPrinterType, kDTPTCPIPPrinterType, }
																		{  kDTPSCSIPrinterType, kDTPUSBPrinterType or kDTPUnknownPrinterType }
																		{  Info specific to each type of printers }
		CASE INTEGER OF
		0: (
			serial:				DTPSerialAddress;
			);
		1: (
			appleTalk:			DTPAppleTalkAddress;
			);
		2: (
			tcpip:				DTPTCPIPAddress;
			);
		3: (
			scsi:				DTPSCSIAddress;
			);
		4: (
			usb:				DTPUSBAddress;
			);
																		{  optional driver-specific information can be appended here }
	END;

	DTPPrinterInfoHandle				= ^DTPPrinterInfoPtr;
	TDTPPrGeneralDataPtr = ^TDTPPrGeneralData;
	TDTPPrGeneralData = RECORD
		iOpCode:				INTEGER;								{  kDTPGetPrinterInfo, kDTPIsSamePrinterInfo or kDTPSetDefaultPrinterInfo }
		iError:					INTEGER;
		iCommand:				LONGINT;
		printerInfo:			DTPPrinterInfoHandle;
	END;

	{  desktop printer info resource }

CONST
	kDTPInfoResType				= 'dtpi';
	kDTPInfoResID				= -8192;

	{  connection types supported }
	kDTPUnknownConnection		= $00000000;					{  unknown connection type }
	kDTPSerialConnection		= $00000001;					{  serial connection }
	kDTPSCSIConnection			= $00000002;					{  SCSI connection }
	kDTPAppleTalkConnection		= $00000004;					{  AppleTalk connection }
	kDTPTCPIPConnection			= $00000008;					{  TCP/IP connection }
	kDTPUSBConnection			= $00000010;					{  USB connection }

	{  dtp extra features supported }
	kDTPBasicFeatures			= $00000000;					{  only basic dtp funtionalities are supported }


TYPE
	DTPInfoResourcePtr = ^DTPInfoResource;
	DTPInfoResource = RECORD
		features:				LONGINT;								{  kDTPBasicFeatures (only basic features are supported for MacOS 8.5) }
		connectionType:			LONGINT;								{  can be kDTPUnknownConnection or any combination of kDTPSerialConnection,  }
																		{  kDTPSCSIConnection, kDTPAppleTalkConnection, kDTPTCPIPConnection and kDTPUSBConnection }
	END;


CONST
																{  GestaltDTPInfoRec.version }
	kDTPGestaltStructVersion2	= $02008000;					{  version 2.0f0 (for Mac OS 8.0, 8.1 and 7.x) }
	kDTPGestaltStructVersion3	= $03000000;					{  version 3.0 (for Mac OS 8.5) }

	{  DTPInfo }

TYPE
	DTPInfoPtr = ^DTPInfo;
	DTPInfo = RECORD
		vRefNum:				INTEGER;								{  vRefNum of the DTP folder }
		dirID:					LONGINT;								{  directory ID of the DTP folder }
		dtpName:				Str31;									{  name of the DTP folder }
		driverType:				OSType;									{  creator type of the print driver for this DTP }
		current:				BOOLEAN;								{  is this DTP currently the default printer? }
		printerName:			Str32;									{  name of the acutal printer on the net (only for LaserWriter 8 dtps) }
		zoneName:				Str32;									{  zone where this printer resides (only for LaserWriter 8 dtps) }
	END;

	{  data associated with the desktop printer info gestalt }
	GestaltDTPInfoRecPtr = ^GestaltDTPInfoRec;
	GestaltDTPInfoRec = RECORD
		version:				LONGINT;								{  kDTPGestaltStructVersion3 or kDTPGestaltStructVersion2 }
		numDTPs:				INTEGER;								{  number of the active dtps }
		theDTPList:				Handle;									{  handle to a list of DTPInfo for the active dtps }
		theDTPDriverList:		Handle;									{  handle to a list of print driver file specs for each of the active dtp in theDTPList }
		reserved:				LONGINT;
	END;

	GestaltDTPInfoPtr					= ^GestaltDTPInfoRec;
	GestaltDTPInfoHdle					= ^GestaltDTPInfoPtr;
	{  AppleEvents  }

CONST
	kDTPSignature				= 'dtpx';

	aeDTPSetDefaultEventType	= 'pfsd';						{  for setting a desktop printer to be the default }
	aeDTPSyncEventType			= 'pfsc';						{  for notifying Desktop PrintMonitor of a new spool file created in a desktop printer folder }

	{  event data }

TYPE
	DTPAppleEventDataPtr = ^DTPAppleEventData;
	DTPAppleEventData = RECORD
		dtpSignature:			OSType;									{  kDTPSignature }
		dtpEventType:			OSType;									{  aeDTPSetDefaultEventType or aeDTPSyncEventType }
		dtpSpec:				FSSpec;									{  the file spec of the target dtp }
	END;

	{  Notification during de-spooling }
	{  DTPAsyncErrorNotificationUPP }
{$IFC TYPED_FUNCTION_POINTERS}
	DTPAsyncErrorNotificationProcPtr = PROCEDURE(errStr: StringHandle);
{$ELSEC}
	DTPAsyncErrorNotificationProcPtr = ProcPtr;
{$ENDC}

	{  DTPEndNotificationUPP }
{$IFC TYPED_FUNCTION_POINTERS}
	DTPEndNotificationProcPtr = PROCEDURE;
{$ELSEC}
	DTPEndNotificationProcPtr = ProcPtr;
{$ENDC}

	{  DTPInForegroundUPP }
{$IFC TYPED_FUNCTION_POINTERS}
	DTPInForegroundProcPtr = FUNCTION: BOOLEAN;
{$ELSEC}
	DTPInForegroundProcPtr = ProcPtr;
{$ENDC}

	{  DTPStatusMessageUPP }
{$IFC TYPED_FUNCTION_POINTERS}
	DTPStatusMessageProcPtr = PROCEDURE(statusStr: StringHandle);
{$ELSEC}
	DTPStatusMessageProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DTPAsyncErrorNotificationUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DTPAsyncErrorNotificationUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DTPEndNotificationUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DTPEndNotificationUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DTPInForegroundUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DTPInForegroundUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DTPStatusMessageUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DTPStatusMessageUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppDTPAsyncErrorNotificationProcInfo = $000000C0;
	uppDTPEndNotificationProcInfo = $00000000;
	uppDTPInForegroundProcInfo = $00000010;
	uppDTPStatusMessageProcInfo = $000000C0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewDTPAsyncErrorNotificationUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewDTPAsyncErrorNotificationUPP(userRoutine: DTPAsyncErrorNotificationProcPtr): DTPAsyncErrorNotificationUPP; { old name was NewDTPAsyncErrorNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDTPEndNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewDTPEndNotificationUPP(userRoutine: DTPEndNotificationProcPtr): DTPEndNotificationUPP; { old name was NewDTPEndNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDTPInForegroundUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewDTPInForegroundUPP(userRoutine: DTPInForegroundProcPtr): DTPInForegroundUPP; { old name was NewDTPInForegroundProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDTPStatusMessageUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewDTPStatusMessageUPP(userRoutine: DTPStatusMessageProcPtr): DTPStatusMessageUPP; { old name was NewDTPStatusMessageProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeDTPAsyncErrorNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeDTPAsyncErrorNotificationUPP(userUPP: DTPAsyncErrorNotificationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDTPEndNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeDTPEndNotificationUPP(userUPP: DTPEndNotificationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDTPInForegroundUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeDTPInForegroundUPP(userUPP: DTPInForegroundUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDTPStatusMessageUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeDTPStatusMessageUPP(userUPP: DTPStatusMessageUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeDTPAsyncErrorNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeDTPAsyncErrorNotificationUPP(errStr: StringHandle; userRoutine: DTPAsyncErrorNotificationUPP); { old name was CallDTPAsyncErrorNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDTPEndNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeDTPEndNotificationUPP(userRoutine: DTPEndNotificationUPP); { old name was CallDTPEndNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDTPInForegroundUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeDTPInForegroundUPP(userRoutine: DTPInForegroundUPP): BOOLEAN; { old name was CallDTPInForegroundProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDTPStatusMessageUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeDTPStatusMessageUPP(statusStr: StringHandle; userRoutine: DTPStatusMessageUPP); { old name was CallDTPStatusMessageProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{  PrGeneral call that PrintMonitor/Desktop PrintMonitor use to set up the notification procs }

CONST
	kPrintMonitorPrGeneral		= -3;

	{
	   TPrintMonitorPrintingData:
	   for classic background printing and desktop printing that does not support third-party drivers 
	}

TYPE
	TPrintMonitorPrintingDataPtr = ^TPrintMonitorPrintingData;
	TPrintMonitorPrintingData = RECORD
		iOpCode:				INTEGER;								{  kPrintMonitorPrGeneral }
		iError:					INTEGER;
		iReserved:				LONGINT;								{  0 - classic PrintMonitor is running }
		hPrint:					THPrint;
		noProcs:				INTEGER;								{  number of notification procs }
		iReserved2:				LONGINT;
		pAsyncNotificationProc:	DTPAsyncErrorNotificationUPP;			{  UPP to put up a notification }
		pAsyncEndnotifyProc:	DTPEndNotificationUPP;					{  UPP to take down the notification }
		pDTPInForegroundProc:	DTPInForegroundUPP;						{  UPP to check if PrintMonitor is in foreground }
	END;

	{
	   TDesktopPrintMonitorPrintingData:
	   for desktop printing that supports third-party print drivers
	}
	TDesktopPrintMonitorPrintingDataPtr = ^TDesktopPrintMonitorPrintingData;
	TDesktopPrintMonitorPrintingData = RECORD
		iOpCode:				INTEGER;								{  kPrintMonitorPrGeneral }
		iError:					INTEGER;
		iReserved:				LONGINT;								{  1 - Desktop PrintMonitor is running }
		hPrint:					THPrint;
		noProcs:				INTEGER;								{  number of notification procs }
		iReserved2:				LONGINT;
		pAsyncNotificationProc:	DTPAsyncErrorNotificationUPP;			{  UPP to put up a notification }
		pAsyncEndnotifyProc:	DTPEndNotificationUPP;					{  UPP to take down the notification }
		pInForegroundProc:		DTPInForegroundUPP;						{  UPP to check if desktop printing is in foreground }
		pStatusMessageProc:		DTPStatusMessageUPP;					{  UPP to update the printing status message in the desktop printer window }
	END;

	{  Spool file data }

	{  spool file data fork }
	SpoolFileHeaderPtr = ^SpoolFileHeader;
	SpoolFileHeader = RECORD
		version:				INTEGER;								{  should always be 1 }
		fileLen:				LONGINT;								{  length of the spool file including the spool file header }
		fileFlags:				LONGINT;								{  should always be 0 }
		numPages:				INTEGER;								{  total number of pages in the spool file }
		printRecord:			TPrint;									{  used only if PREC 3 can't be read }
	END;

	SpoolFileHeaderHandle				= ^SpoolFileHeaderPtr;
	SpoolPagePtr = ^SpoolPage;
	SpoolPage = RECORD
		pictFlags:				LONGINT;								{  should always be 0 }
		thePict:				Picture;								{  variable length }
		pageOffset:				LONGINT;								{  offset to the beginning of this page's PICT }
	END;

	{
	   spool file resource fork
	   PREC 126
	}
	SpoolPREC126RecordPtr = ^SpoolPREC126Record;
	SpoolPREC126Record = RECORD
		version:				INTEGER;								{  always 1 }
		flags:					INTEGER;								{  always 0 }
		numPages:				INTEGER;								{  total number of pages in the spool file }
		numCopies:				INTEGER;								{  total number of copies for the spool file }
		creator:				OSType;									{  the creator type of the print driver that creates the spool file }
		appName:				Str31;									{  the name of the application used to create the spool file }
	END;

	SpoolPREC126Ptr						= ^SpoolPREC126Record;
	SpoolPREC126Handle					= ^SpoolPREC126Ptr;
	{  PINX -8200 (page index resource) }
	SpoolPageIndexPtr = ^SpoolPageIndex;
	SpoolPageIndex = RECORD
		count:					INTEGER;								{  number of elements in the pageOffset array }
		pageOffset:				ARRAY [0..0] OF LONGINT;				{  the offset from the beginning of the file to the page record }
																		{  e.g. it would be sizeof(SpoolFileHeader) for the first page. }
	END;

	SpoolPageIndexHandle				= ^SpoolPageIndexPtr;
	{
	   jobi 1 (DTP print job information resource)
	   print priorities
	}

CONST
	kDTPPrintJobUrgent			= $00000001;
	kDTPPrintJobAtTime			= $00000002;
	kDTPPrintJobNormal			= $00000003;
	kDTPPrintJobHolding			= $00001003;


TYPE
	DTPPrintJobInfoPtr = ^DTPPrintJobInfo;
	DTPPrintJobInfo = RECORD
		firstPageToPrint:		INTEGER;								{  first page in the spool file to print }
		priority:				INTEGER;								{  print priority (eg kDTPPrintJobNormal) }
		numCopies:				INTEGER;								{  total number of copies }
		numPages:				INTEGER;								{  total number of pages in the spool file }
		timeToPrint:			UInt32;									{  time to print (in seconds) when priority is kDTPPrintJobAtTime }
		documentName:			Str31;									{  name of the document }
		applicationName:		Str31;									{  name of the application that's used to create this spool file }
		printerName:			Str32;									{  name of the target printer (should be the same as what's in PREC 124) }
	END;

	DTPPrintJobInfoHandle				= ^DTPPrintJobInfoPtr;
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DesktopPrintingIncludes}

{$ENDC} {__DESKTOPPRINTING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

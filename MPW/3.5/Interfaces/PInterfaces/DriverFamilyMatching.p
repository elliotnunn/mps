{
     File:       DriverFamilyMatching.p
 
     Contains:   Interfaces for create native drivers NDRV
 
     Version:    Technology: 
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1995-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT DriverFamilyMatching;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DRIVERFAMILYMATCHING__}
{$SETC __DRIVERFAMILYMATCHING__ := 1}

{$I+}
{$SETC DriverFamilyMatchingIncludes := UsingIncludes}
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


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
  ##############################################
   Well known properties in the Name Registry
  ##############################################
}
{ CPassThru }
{
  #########################################################
   Descriptor for Drivers and NDRVs
  #########################################################
}
{ 
    QuickTime 3.0: "DriverType" has a name collision with cross-platform code.
    Use Mac prefix to avoid collision 
}
{ Driver Typing Information Used to Match Drivers With Devices }

TYPE
	MacDriverTypePtr = ^MacDriverType;
	MacDriverType = RECORD
		nameInfoStr:			Str31;									{  Driver Name/Info String }
		version:				NumVersion;								{  Driver Version Number }
	END;

{$IFC TARGET_OS_MAC }
	DriverType							= MacDriverType;
	DriverTypePtr 						= ^DriverType;
{$ENDC}  {TARGET_OS_MAC}

	{	 OS Runtime Information Used to Setup and Maintain a Driver's Runtime Environment 	}
	RuntimeOptions						= OptionBits;

CONST
	kDriverIsLoadedUponDiscovery = $00000001;					{  auto-load driver when discovered }
	kDriverIsOpenedUponLoad		= $00000002;					{  auto-open driver when loaded }
	kDriverIsUnderExpertControl	= $00000004;					{  I/O expert handles loads/opens }
	kDriverIsConcurrent			= $00000008;					{  supports concurrent requests }
	kDriverQueuesIOPB			= $00000010;					{  device manager doesn't queue IOPB }
	kDriverIsLoadedAtBoot		= $00000020;					{  Driver is loaded at the boot time  }
	kDriverIsForVirtualDevice	= $00000040;					{  Driver is for a virtual Device  }
	kDriverSupportDMSuspendAndResume = $00000080;				{  Driver supports Device Manager Suspend and Resume command  }


TYPE
	DriverOSRuntimePtr = ^DriverOSRuntime;
	DriverOSRuntime = RECORD
		driverRuntime:			RuntimeOptions;							{  Options for OS Runtime }
		driverName:				Str31;									{  Driver's name to the OS }
		driverDescReserved:		ARRAY [0..7] OF UInt32;					{  Reserved area }
	END;

	{	 OS Service Information Used To Declare What APIs a Driver Supports 	}
	ServiceCount						= UInt32;
	DriverServiceInfoPtr = ^DriverServiceInfo;
	DriverServiceInfo = RECORD
		serviceCategory:		OSType;									{  Service Category Name }
		serviceType:			OSType;									{  Type within Category }
		serviceVersion:			NumVersion;								{  Version of service }
	END;

	DriverOSServicePtr = ^DriverOSService;
	DriverOSService = RECORD
		nServices:				ServiceCount;							{  Number of Services Supported }
		service:				ARRAY [0..0] OF DriverServiceInfo;		{  The List of Services (at least one) }
	END;

	{	 Categories 	}

CONST
	kServiceCategoryDisplay		= 'disp';						{  Display Manager }
	kServiceCategoryOpenTransport = 'otan';						{  Open Transport }
	kServiceCategoryBlockStorage = 'blok';						{  Block Storage }
	kServiceCategoryNdrvDriver	= 'ndrv';						{  Generic Native Driver }
	kServiceCategoryScsiSIM		= 'scsi';						{  SCSI  }
	kServiceCategoryFileManager	= 'file';						{  File Manager  }
	kServiceCategoryIDE			= 'ide-';						{  ide  }
	kServiceCategoryADB			= 'adb-';						{  adb  }
	kServiceCategoryPCI			= 'pci-';						{  pci bus  }
																{  Nu Bus  }
	kServiceCategoryDFM			= 'dfm-';						{  DFM  }
	kServiceCategoryMotherBoard	= 'mrbd';						{  mother Board  }
	kServiceCategoryKeyboard	= 'kybd';						{  Keyboard  }
	kServiceCategoryPointing	= 'poit';						{  Pointing  }
	kServiceCategoryRTC			= 'rtc-';						{  RTC  }
	kServiceCategoryNVRAM		= 'nram';						{  NVRAM  }
	kServiceCategorySound		= 'sond';						{  Sound (1/3/96 MCS)  }
	kServiceCategoryPowerMgt	= 'pgmt';						{  Power Management  }
	kServiceCategoryGeneric		= 'genr';						{  Generic Service Category to receive general Events  }

	{	 Ndrv ServiceCategory Types 	}
	kNdrvTypeIsGeneric			= 'genr';						{  generic }
	kNdrvTypeIsVideo			= 'vido';						{  video }
	kNdrvTypeIsBlockStorage		= 'blok';						{  block storage }
	kNdrvTypeIsNetworking		= 'netw';						{  networking }
	kNdrvTypeIsSerial			= 'serl';						{  serial }
	kNdrvTypeIsParallel			= 'parl';						{  parallel  }
	kNdrvTypeIsSound			= 'sond';						{  sound }
	kNdrvTypeIsBusBridge		= 'brdg';
	kNdrvTypeIsFWConference		= 'crsh';						{  FireWire conference camera  }
	kNdrvTypeIsAVC				= 'avc ';						{  FireWire AVC devices (DV cameras)  }


TYPE
	DriverDescVersion					= UInt32;
	{	  The Driver Description 	}

CONST
	kTheDescriptionSignature	= 'mtej';
	kDriverDescriptionSignature	= 'pdes';

	kInitialDriverDescriptor	= 0;
	kVersionOneDriverDescriptor	= 1;


TYPE
	DriverDescriptionPtr = ^DriverDescription;
	DriverDescription = RECORD
		driverDescSignature:	OSType;									{  Signature field of this structure }
		driverDescVersion:		DriverDescVersion;						{  Version of this data structure }
		driverType:				MacDriverType;							{  Type of Driver }
		driverOSRuntimeInfo:	DriverOSRuntime;						{  OS Runtime Requirements of Driver }
		driverServices:			DriverOSService;						{  Apple Service API Membership }
	END;



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DriverFamilyMatchingIncludes}

{$ENDC} {__DRIVERFAMILYMATCHING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

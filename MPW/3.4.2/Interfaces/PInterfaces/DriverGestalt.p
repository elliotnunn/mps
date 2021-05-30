{
 	File:		DriverGestalt.p
 
 	Contains:	Driver Gestalt interfaces
 
 	Version:	Technology:	PowerSurge 1.0.2.
 				Package:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.
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
 UNIT DriverGestalt;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DRIVERGESTALT__}
{$SETC __DRIVERGESTALT__ := 1}

{$I+}
{$SETC DriverGestaltIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{$IFC UNDEFINED __SCSI__}
{$I SCSI.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ __________________________________________________________________________________ }
{  The Driver Gestalt bit in the dCtlFlags  }

CONST
	kbDriverGestaltEnable		= 2;
	kmDriverGestaltEnableMask	= $04;

{ __________________________________________________________________________________ }
{  Driver Gestalt related csCodes  }
	kDriverGestaltCode			= 43;							{  various uses  }
	kDriverConfigureCode		= 43;							{  various uses  }
	kdgLowPowerMode				= 70;							{  Sets/Returns the current energy consumption level  }
	kdgReturnDeviceID			= 120;							{  returns SCSI DevID in csParam[0]  }
	kdgGetCDDeviceInfo			= 121;							{  returns CDDeviceCharacteristics in csParam[0]  }

{ __________________________________________________________________________________ }
{  Driver Gestalt selectors  }
	kdgVersion					= 'vers';						{  Version number of the driver in standard Apple format  }
	kdgDeviceType				= 'devt';						{  The type of device the driver is driving.  }
	kdgInterface				= 'intf';						{  The underlying interface that the driver is using (if any)  }
	kdgSync						= 'sync';						{  True if driver only behaves synchronously.  }
	kdgBoot						= 'boot';						{  value to place in PRAM for this drive (long)  }
	kdgWide						= 'wide';						{  True if driver supports ioWPosOffset  }
	kdgPurge					= 'purg';						{  Driver purge permission (True = purge; False = no purge)  }
	kdgSupportsSwitching		= 'lpwr';						{  True if driver supports power switching  }
	kdgMin3VPower				= 'pmn3';						{  Minimum 3.3V power consumption in microWatts  }
	kdgMin5VPower				= 'pmn5';						{  Minimum 5V power consumption in microWatts  }
	kdgMax3VPower				= 'pmx3';						{  Maximum 3.3V power consumption in microWatts  }
	kdgMax5VPower				= 'pmx5';						{  Maximum 5V power consumption in microWatts  }
	kdgInHighPower				= 'psta';						{  True if device is currently in high power mode  }
	kdgSupportsPowerCtl			= 'psup';						{  True if driver supports following five calls  }
	kdgAPI						= 'dAPI';						{  API support for PC Exchange  }
	kdgEject					= 'ejec';						{  Eject options for shutdown/restart <2/03/95>  }
	kdgFlush					= 'flus';						{  Determine if disk driver supports flush and if it needs a flush  }

{ __________________________________________________________________________________ }
{  Driver Configure selectors  }
	kdcFlush					= 'flus';						{  Tell a disk driver to flush its cache and any hardware caches  }

{ __________________________________________________________________________________ }
{  control parameter block for Driver Configure calls  }

TYPE
	DriverConfigParamPtr = ^DriverConfigParam;
	DriverConfigParam = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			ProcPtr;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		ioCRefNum:				INTEGER;								{  refNum for I/O operation  }
		csCode:					INTEGER;								{  == kDriverConfigureCode  }
		driverConfigureSelector: OSType;
		driverConfigureParameter: UInt32;
	END;

{ __________________________________________________________________________________ }
{  status parameter block for Driver Gestalt calls  }
TYPE
	DriverGestaltParamPtr = ^DriverGestaltParam;
	DriverGestaltParam = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		ioTrap:					INTEGER;
		ioCmdAddr:				Ptr;
		ioCompletion:			ProcPtr;
		ioResult:				OSErr;
		ioNamePtr:				StringPtr;
		ioVRefNum:				INTEGER;
		ioCRefNum:				INTEGER;								{  refNum for I/O operation  }
		csCode:					INTEGER;								{ 	== kDriverGestaltCode  }
		driverGestaltSelector:	OSType;									{  'sync', 'vers', etc.  }
		driverGestaltResponse:	UInt32;									{  Could be a pointer, bit field or other format  }
		driverGestaltResponse1:	UInt32;									{  Could be a pointer, bit field or other format  }
		driverGestaltResponse2:	UInt32;									{  Could be a pointer, bit field or other format  }
		driverGestaltResponse3:	UInt32;									{  Could be a pointer, bit field or other format  }
		driverGestaltfiller:	UInt16;									{  To pad out to the size of a controlPB  }
	END;

{
 Note that the various response definitions are overlays of the response fields above.
   For instance the deviceType response would be returned in driverGestaltResponse.
   The DriverGestaltPurgeResponse would be in driverGestaltResponse and driverGestaltResponse1
}
{ __________________________________________________________________________________ }
{  Device Types response  }
	DriverGestaltDevTResponsePtr = ^DriverGestaltDevTResponse;
	DriverGestaltDevTResponse = RECORD
		deviceType:				OSType;
	END;


CONST
	kdgDiskType					= 'disk';						{  standard r/w disk drive  }
	kdgTapeType					= 'tape';						{  tape drive  }
	kdgPrinterType				= 'prnt';						{  printer  }
	kdgProcessorType			= 'proc';						{  processor  }
	kdgWormType					= 'worm';						{  write-once  }
	kdgCDType					= 'cdrm';						{  cd-rom drive  }
	kdgFloppyType				= 'flop';						{  floppy disk drive  }
	kdgScannerType				= 'scan';						{  scanner  }
	kdgFileType					= 'file';						{  Logical Partition type based on a file (Drive Container)  }
	kdgRemovableType			= 'rdsk';						{  A removable media hard disk drive ie. Syquest, Bernioulli  }

{ __________________________________________________________________________________ }
{  Device Interfaces response  }

TYPE
	DriverGestaltIntfResponsePtr = ^DriverGestaltIntfResponse;
	DriverGestaltIntfResponse = RECORD
		interfaceType:			OSType;
	END;


CONST
	kdgScsiIntf					= 'scsi';
	kdgPcmciaIntf				= 'pcmc';
	kdgATAIntf					= 'ata ';
	kdgFireWireIntf				= 'fire';
	kdgExtBus					= 'card';

{ __________________________________________________________________________________ }
{  Power Saving  }

TYPE
	DriverGestaltPowerResponsePtr = ^DriverGestaltPowerResponse;
	DriverGestaltPowerResponse = RECORD
		powerValue:				LONGINT;								{  Power consumed in µWatts  }
	END;

{ __________________________________________________________________________________ }
{  Disk Specific  }
	DriverGestaltSyncResponsePtr = ^DriverGestaltSyncResponse;
	DriverGestaltSyncResponse = RECORD
		behavesSynchronously:	BOOLEAN;
		pad:					PACKED ARRAY [0..2] OF UInt8;
	END;

	DriverGestaltBootResponsePtr = ^DriverGestaltBootResponse;
	DriverGestaltBootResponse = RECORD
		extDev:					SInt8;									{   Packed target (upper 5 bits) LUN (lower 3 bits)  }
		partition:				SInt8;									{   Unused  }
		SIMSlot:				SInt8;									{   Slot  }
		SIMsRSRC:				SInt8;									{   sRsrcID  }
	END;

	DriverGestaltAPIResponsePtr = ^DriverGestaltAPIResponse;
	DriverGestaltAPIResponse = RECORD
		partitionCmds:			INTEGER;								{  if bit 0 is nonzero, supports partition control and status calls  }
																		{ 	 	prohibitMounting (control, kProhibitMounting)  }
																		{  		partitionToVRef (status, kGetPartitionStatus)  }
																		{  		getPartitionInfo (status, kGetPartInfo)  }
		unused1:				INTEGER;								{  all the unused fields should be zero  }
		unused2:				INTEGER;
		unused3:				INTEGER;
		unused4:				INTEGER;
		unused5:				INTEGER;
		unused6:				INTEGER;
		unused7:				INTEGER;
		unused8:				INTEGER;
		unused9:				INTEGER;
		unused10:				INTEGER;
	END;

	DriverGestaltFlushResponsePtr = ^DriverGestaltFlushResponse;
	DriverGestaltFlushResponse = RECORD
		canFlush:				BOOLEAN;								{  Return true if driver supports the  }
																		{  kdcFlush Driver Configure _Control call  }
		needsFlush:				BOOLEAN;								{  Return true if driver/device has data cached  }
																		{  and needs to be flushed when the disk volume  }
																		{  is flushed by the File Manager  }
		pad:					PACKED ARRAY [0..1] OF UInt8;
	END;


{  Flags for purge permissions  }

CONST
	kbCloseOk					= 0;							{  Ok to call Close  }
	kbRemoveOk					= 1;							{  Ok to call RemoveDrvr  }
	kbPurgeOk					= 2;							{  Ok to call DisposePtr  }
	kmNoCloseNoPurge			= 0;
	kmOkCloseNoPurge			= $03;
	kmOkCloseOkPurge			= $07;

{  Driver purge permission structure  }

TYPE
	DriverGestaltPurgeResponsePtr = ^DriverGestaltPurgeResponse;
	DriverGestaltPurgeResponse = RECORD
		purgePermission:		UInt16;									{  0 = Do not change the state of the driver  }
																		{  3 = Do Close() and DrvrRemove() this driver  }
																		{  but don't deallocate driver code  }
																		{  7 = Do Close(), DrvrRemove(), and DisposePtr()  }
		purgeReserved:			UInt16;
		purgeDriverPointer:		Ptr;									{  pointer to the start of the driver block (valid  }
																		{  only of DisposePtr permission is given  }
	END;

	DriverGestaltEjectResponsePtr = ^DriverGestaltEjectResponse;
	DriverGestaltEjectResponse = RECORD
		ejectFeatures:			UInt32;									{    }
	END;

{  Flags for Ejection Features field  }

CONST
	kRestartDontEject			= 0;							{  Dont Want eject during Restart  }
	kShutDownDontEject			= 1;							{  Dont Want eject during Shutdown  }
	kRestartDontEject_Mask		= $01;
	kShutDownDontEject_Mask		= $02;

{ __________________________________________________________________________________ }
{  CD-ROM Specific  }
{
 The CDDeviceCharacteristics result is returned in csParam[0] and csParam[1] of a 
   standard CntrlParam parameter block called with csCode kdgGetCDDeviceInfo.
}

TYPE
	CDDeviceCharacteristicsPtr = ^CDDeviceCharacteristics;
	CDDeviceCharacteristics = RECORD
		speedMajor:				SInt8;									{  High byte of fixed point number containing drive speed  }
		speedMinor:				SInt8;									{  Low byte of "" CD 300 == 2.2, CD_SC == 1.0 etc.  }
		cdFeatures:				UInt16;									{  Flags field for features and transport type of this CD-ROM  }
	END;


CONST
	cdFeatureFlagsMask			= $FFFC;						{  The Flags are in the first 14 bits of the cdFeatures field  }
	cdTransportMask				= $0003;						{  The transport type is in the last 2 bits of the cdFeatures field  }

{  Flags for CD Features field  }
	cdMute						= 0;							{  The following flags have the same bit number  }
	cdLeftToChannel				= 1;							{  as the Audio Mode they represent.  Don't change  }
	cdRightToChannel			= 2;							{  them without changing dControl.c  }
	cdLeftPlusRight				= 3;							{  Reserve some space for new audio mixing features (4-7)  }
	cdSCSI_2					= 8;							{  Supports SCSI2 CD Command Set  }
	cdStereoVolume				= 9;							{  Can support two different volumes (1 on each channel)  }
	cdDisconnect				= 10;							{  Drive supports disconnect/reconnect  }
	cdWriteOnce					= 11;							{  Drive is a write/once (CD-R?) type drive  }
	cdMute_Mask					= $01;
	cdLeftToChannel_Mask		= $02;
	cdRightToChannel_Mask		= $04;
	cdLeftPlusRight_Mask		= $08;
	cdSCSI_2_Mask				= $0100;
	cdStereoVolume_Mask			= $0200;
	cdDisconnect_Mask			= $0400;
	cdWriteOnce_Mask			= $0800;

{  Transport types  }
	cdCaddy						= 0;							{  CD_SC,CD_SC_PLUS,CD-300 etc.  }
	cdTray						= 1;							{  CD_300_PLUS etc.  }
	cdLid						= 2;							{  Power CD - eg no eject mechanism  }


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DriverGestaltIncludes}

{$ENDC} {__DRIVERGESTALT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

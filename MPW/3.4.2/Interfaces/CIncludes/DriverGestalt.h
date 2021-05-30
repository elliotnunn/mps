/*
 	File:		DriverGestalt.h
 
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
 
*/

#ifndef __DRIVERGESTALT__
#define __DRIVERGESTALT__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif
/*	#include <MixedMode.h>										*/
/*	#include <Memory.h>											*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
	kbDriverGestaltEnable		= 2,
	kmDriverGestaltEnableMask	= (1 << kbDriverGestaltEnable)
};

/*__________________________________________________________________________________*/
/* Driver Gestalt related csCodes */
enum {
	kDriverGestaltCode			= 43,							/* various uses */
	kDriverConfigureCode		= 43,							/* various uses */
	kdgLowPowerMode				= 70,							/* Sets/Returns the current energy consumption level */
	kdgReturnDeviceID			= 120,							/* returns SCSI DevID in csParam[0] */
	kdgGetCDDeviceInfo			= 121							/* returns CDDeviceCharacteristics in csParam[0] */
};

/*__________________________________________________________________________________*/
/* Driver Gestalt selectors */
enum {
	kdgVersion					= 'vers',						/* Version number of the driver in standard Apple format */
	kdgDeviceType				= 'devt',						/* The type of device the driver is driving. */
	kdgInterface				= 'intf',						/* The underlying interface that the driver is using (if any) */
	kdgSync						= 'sync',						/* True if driver only behaves synchronously. */
	kdgBoot						= 'boot',						/* value to place in PRAM for this drive (long) */
	kdgWide						= 'wide',						/* True if driver supports ioWPosOffset */
	kdgPurge					= 'purg',						/* Driver purge permission (True = purge; False = no purge) */
	kdgSupportsSwitching		= 'lpwr',						/* True if driver supports power switching */
	kdgMin3VPower				= 'pmn3',						/* Minimum 3.3V power consumption in microWatts */
	kdgMin5VPower				= 'pmn5',						/* Minimum 5V power consumption in microWatts */
	kdgMax3VPower				= 'pmx3',						/* Maximum 3.3V power consumption in microWatts */
	kdgMax5VPower				= 'pmx5',						/* Maximum 5V power consumption in microWatts */
	kdgInHighPower				= 'psta',						/* True if device is currently in high power mode */
	kdgSupportsPowerCtl			= 'psup',						/* True if driver supports following five calls */
	kdgAPI						= 'dAPI',						/* API support for PC Exchange */
	kdgEject					= 'ejec',						/* Eject options for shutdown/restart <2/03/95> */
	kdgFlush					= 'flus'						/* Determine if disk driver supports flush and if it needs a flush */
};

/*__________________________________________________________________________________*/
/* Driver Configure selectors */

enum {
	kdcFlush					= 'flus'						/* Tell a disk driver to flush its cache and any hardware caches */
};

/*__________________________________________________________________________________*/
/* control parameter block for Driver Configure calls */
struct DriverConfigParam {
	QElemPtr 						qLink;
	short 							qType;
	short 							ioTrap;
	Ptr 							ioCmdAddr;
	ProcPtr 						ioCompletion;
	OSErr 							ioResult;
	StringPtr 						ioNamePtr;
	short 							ioVRefNum;
	short 							ioCRefNum;					/* refNum for I/O operation */
	short 							csCode;						/* == kDriverConfigureCode */
	OSType 							driverConfigureSelector;
	UInt32 							driverConfigureParameter;
};
typedef struct DriverConfigParam DriverConfigParam;

/*__________________________________________________________________________________*/
/* status parameter block for Driver Gestalt calls */
struct DriverGestaltParam {
	QElemPtr 						qLink;
	short 							qType;
	short 							ioTrap;
	Ptr 							ioCmdAddr;
	ProcPtr 						ioCompletion;
	OSErr 							ioResult;
	StringPtr 						ioNamePtr;
	short 							ioVRefNum;
	short 							ioCRefNum;					/* refNum for I/O operation */
	short 							csCode;						/*	== kDriverGestaltCode */
	OSType 							driverGestaltSelector;		/* 'sync', 'vers', etc. */
	UInt32 							driverGestaltResponse;		/* Could be a pointer, bit field or other format */
	UInt32 							driverGestaltResponse1;		/* Could be a pointer, bit field or other format */
	UInt32 							driverGestaltResponse2;		/* Could be a pointer, bit field or other format */
	UInt32 							driverGestaltResponse3;		/* Could be a pointer, bit field or other format */
	UInt16 							driverGestaltfiller;		/* To pad out to the size of a controlPB */
};
typedef struct DriverGestaltParam DriverGestaltParam;

/* Note that the various response definitions are overlays of the response fields above.
   For instance the deviceType response would be returned in driverGestaltResponse.
   The DriverGestaltPurgeResponse would be in driverGestaltResponse and driverGestaltResponse1
*/

#define GetDriverGestaltFlushResponse(p) ((DriverGestaltFlushResponse *)(&((p)->driverGestaltResponse)))


/*__________________________________________________________________________________*/
/* Device Types response */
struct DriverGestaltDevTResponse {
	OSType							deviceType;
};
typedef struct DriverGestaltDevTResponse DriverGestaltDevTResponse;


enum {
	kdgDiskType					= 'disk',						/* standard r/w disk drive */
	kdgTapeType					= 'tape',						/* tape drive */
	kdgPrinterType				= 'prnt',						/* printer */
	kdgProcessorType			= 'proc',						/* processor */
	kdgWormType					= 'worm',						/* write-once */
	kdgCDType					= 'cdrm',						/* cd-rom drive */
	kdgFloppyType				= 'flop',						/* floppy disk drive */
	kdgScannerType				= 'scan',						/* scanner */
	kdgFileType					= 'file',						/* Logical Partition type based on a file (Drive Container) */
	kdgRemovableType			= 'rdsk'
};

/*__________________________________________________________________________________*/
/* Device Interfaces response */
struct DriverGestaltIntfResponse {
	OSType							interfaceType;
};
typedef struct DriverGestaltIntfResponse DriverGestaltIntfResponse;


enum {
	kdgScsiIntf					= 'scsi',
	kdgPcmciaIntf				= 'pcmc',
	kdgATAIntf					= 'ata ',
	kdgFireWireIntf				= 'fire',
	kdgExtBus					= 'card'
};

/*__________________________________________________________________________________*/
/* Power Saving */
struct DriverGestaltPowerResponse {
	unsigned long					powerValue;					/* Power consumed in µWatts */
};
typedef struct DriverGestaltPowerResponse DriverGestaltPowerResponse;

/*__________________________________________________________________________________*/
/* Disk Specific */
struct DriverGestaltSyncResponse {
	Boolean							behavesSynchronously;
	UInt8							pad[3];
};
typedef struct DriverGestaltSyncResponse DriverGestaltSyncResponse;

struct DriverGestaltBootResponse {
	UInt8							extDev;						/*  Packed target (upper 5 bits) LUN (lower 3 bits) */
	UInt8							partition;					/*  Unused */
	UInt8							SIMSlot;					/*  Slot */
	UInt8							SIMsRSRC;					/*  sRsrcID */
};
typedef struct DriverGestaltBootResponse DriverGestaltBootResponse;

struct DriverGestaltAPIResponse {
	short							partitionCmds;				/* if bit 0 is nonzero, supports partition control and status calls
								 	prohibitMounting (control, kProhibitMounting)
							 		partitionToVRef (status, kGetPartitionStatus)
							 		getPartitionInfo (status, kGetPartInfo) */
	short							unused1;					/* all the unused fields should be zero */
	short							unused2;
	short							unused3;
	short							unused4;
	short							unused5;
	short							unused6;
	short							unused7;
	short							unused8;
	short							unused9;
	short							unused10;
};
typedef struct DriverGestaltAPIResponse DriverGestaltAPIResponse;

/* Flags for purge permissions */

enum {
	kbCloseOk					= 0,							/* Ok to call Close */
	kbRemoveOk					= 1,							/* Ok to call RemoveDrvr */
	kbPurgeOk					= 2,							/* Ok to call DisposePtr */
	kmNoCloseNoPurge			= 0,
	kmOkCloseNoPurge			= (1 << kbCloseOk) + (1 << kbRemoveOk),
	kmOkCloseOkPurge			= (1 << kbCloseOk) + (1 << kbRemoveOk) + (1 << kbPurgeOk)
};

struct DriverGestaltFlushResponse {
	Boolean 						canFlush;					/* Return true if driver supports the */
																/* kdcFlush Driver Configure _Control call */
	Boolean 						needsFlush;					/* Return true if driver/device has data cached */
																/* and needs to be flushed when the disk volume */
																/* is flushed by the File Manager */
	UInt8 							pad[2];
};
typedef struct DriverGestaltFlushResponse DriverGestaltFlushResponse;


/* Driver purge permission structure */
struct DriverGestaltPurgeResponse {
	UInt16							purgePermission;			/* 0 = Do not change the state of the driver */
/* 3 = Do Close() and DrvrRemove() this driver */
/* but don't deallocate driver code */
/* 7 = Do Close(), DrvrRemove(), and DisposePtr() */
	UInt16							purgeReserved;
	Ptr								purgeDriverPointer;			/* pointer to the start of the driver block (valid */
/* only of DisposePtr permission is given */
};
typedef struct DriverGestaltPurgeResponse DriverGestaltPurgeResponse;

struct DriverGestaltEjectResponse {
	UInt32							ejectFeatures;				/*  */
};
typedef struct DriverGestaltEjectResponse DriverGestaltEjectResponse;

/* Flags for Ejection Features field */

enum {
	kRestartDontEject			= 0,							/* Dont Want eject during Restart */
	kShutDownDontEject			= 1,							/* Dont Want eject during Shutdown */
	kRestartDontEject_Mask		= 1 << kRestartDontEject,
	kShutDownDontEject_Mask		= 1 << kShutDownDontEject
};

/*__________________________________________________________________________________*/
/* CD-ROM Specific */
/* The CDDeviceCharacteristics result is returned in csParam[0] and csParam[1] of a 
   standard CntrlParam parameter block called with csCode kdgGetCDDeviceInfo.
*/
struct CDDeviceCharacteristics {
	UInt8							speedMajor;					/* High byte of fixed point number containing drive speed */
	UInt8							speedMinor;					/* Low byte of "" CD 300 == 2.2, CD_SC == 1.0 etc. */
	UInt16							cdFeatures;					/* Flags field for features and transport type of this CD-ROM */
};
typedef struct CDDeviceCharacteristics CDDeviceCharacteristics;


enum {
	cdFeatureFlagsMask			= 0xFFFC,						/* The Flags are in the first 14 bits of the cdFeatures field */
	cdTransportMask				= 0x0003						/* The transport type is in the last 2 bits of the cdFeatures field */
};

/* Flags for CD Features field */
enum {
	cdMute						= 0,							/* The following flags have the same bit number */
	cdLeftToChannel				= 1,							/* as the Audio Mode they represent.  Don't change */
	cdRightToChannel			= 2,							/* them without changing dControl.c */
	cdLeftPlusRight				= 3,							/* Reserve some space for new audio mixing features (4-7) */
	cdSCSI_2					= 8,							/* Supports SCSI2 CD Command Set */
	cdStereoVolume				= 9,							/* Can support two different volumes (1 on each channel) */
	cdDisconnect				= 10,							/* Drive supports disconnect/reconnect */
	cdWriteOnce					= 11,							/* Drive is a write/once (CD-R?) type drive */
	cdMute_Mask					= 1 << cdMute,
	cdLeftToChannel_Mask		= 1 << cdLeftToChannel,
	cdRightToChannel_Mask		= 1 << cdRightToChannel,
	cdLeftPlusRight_Mask		= 1 << cdLeftPlusRight,
	cdSCSI_2_Mask				= 1 << cdSCSI_2,
	cdStereoVolume_Mask			= 1 << cdStereoVolume,
	cdDisconnect_Mask			= 1 << cdDisconnect,
	cdWriteOnce_Mask			= 1 << cdWriteOnce
};

/* Transport types */
enum {
	cdCaddy						= 0,							/* CD_SC,CD_SC_PLUS,CD-300 etc. */
	cdTray						= 1,							/* CD_300_PLUS etc. */
	cdLid						= 2								/* Power CD - eg no eject mechanism */
};


#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __DRIVERGESTALT__ */

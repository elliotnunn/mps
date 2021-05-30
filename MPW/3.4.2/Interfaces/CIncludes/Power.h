/*
 	File:		Power.h
 
 	Contains:	Power Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.2 on ETO #20
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __POWER__
#define __POWER__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif

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
/* Bit positions for ModemByte */
	modemOnBit					= 0,
	ringWakeUpBit				= 2,
	modemInstalledBit			= 3,
	ringDetectBit				= 4,
	modemOnHookBit				= 5,
/* masks for ModemByte */
	modemOnMask					= 0x01,
	ringWakeUpMask				= 0x04,
	modemInstalledMask			= 0x08,
	ringDetectMask				= 0x10,
	modemOnHookMask				= 0x20,
/* bit positions for BatteryByte */
	chargerConnBit				= 0,
	hiChargeBit					= 1,
	chargeOverFlowBit			= 2,
	batteryDeadBit				= 3,
	batteryLowBit				= 4,
	connChangedBit				= 5,
/* masks for BatteryByte */
	chargerConnMask				= 0x01,
	hiChargeMask				= 0x02,
	chargeOverFlowMask			= 0x04,
	batteryDeadMask				= 0x08,
	batteryLowMask				= 0x10,
	connChangedMask				= 0x20
};

enum {
/* commands to SleepQRec sleepQProc */
	sleepRequest				= 1,
	sleepDemand					= 2,
	sleepWakeUp					= 3,
	sleepRevoke					= 4,
	sleepUnlock					= 4,
	sleepDeny					= 5,
	sleepNow					= 6,
	dozeDemand					= 7,
	dozeWakeUp					= 8,
	dozeRequest					= 9,
/* SleepQRec.sleepQFlags */
	noCalls						= 1,
	noRequest					= 2,
	slpQType					= 16,
	sleepQType					= 16
};

/* bits in bitfield returned by PMFeatures */
enum {
	hasWakeupTimer				= 0,							/* 1=wakeup timer is supported						*/
	hasSharedModemPort			= 1,							/* 1=modem port shared by SCC and internal modem	*/
	hasProcessorCycling			= 2,							/* 1=processor cycling is supported					*/
	mustProcessorCycle			= 3,							/* 1=processor cycling should not be turned off		*/
	hasReducedSpeed				= 4,							/* 1=processor can be started up at reduced speed	*/
	dynamicSpeedChange			= 5,							/* 1=processor speed can be switched dynamically	*/
	hasSCSIDiskMode				= 6,							/* 1=SCSI Disk Mode is supported					*/
	canGetBatteryTime			= 7,							/* 1=battery time can be calculated					*/
	canWakeupOnRing				= 8,							/* 1=can wakeup when the modem detects a ring		*/
	hasDimmingSupport			= 9,							/* 1=has dimming support built in					*/
	hasStartupTimer				= 10							/* 1=startup timer is supported						*/
};

/* bits in bitfield returned by GetIntModemInfo and set by SetIntModemState */
enum {
	hasInternalModem			= 0,							/* 1=internal modem installed						*/
	intModemRingDetect			= 1,							/* 1=internal modem has detected a ring				*/
	intModemOffHook				= 2,							/* 1=internal modem is off hook						*/
	intModemRingWakeEnb			= 3,							/* 1=wakeup on ring is enabled						*/
	extModemSelected			= 4,							/* 1=external modem selected						*/
	modemSetBit					= 15							/* 1=set bit, 0=clear bit (SetIntModemState)		*/
};

/* bits in BatteryInfo.flags 									*/
/* ("chargerConnected" doesn't mean the charger is plugged in)	*/
enum {
	batteryInstalled			= 7,							/* 1=battery is currently connected					*/
	batteryCharging				= 6,							/* 1=battery is being charged						*/
	chargerConnected			= 5								/* 1=charger is connected to the PowerBook			*/
};

enum {
	HDPwrQType					= 'HD',							/* hard disk spindown queue element type			*/
	PMgrStateQType				= 'PM'
};

/* client notification bits in PMgrQueueElement.pmNotifyBits */
enum {
	pmSleepTimeoutChanged		= 0,
	pmSleepEnableChanged		= 1,
	pmHardDiskTimeoutChanged	= 2,
	pmHardDiskSpindownChanged	= 3,
	pmDimmingTimeoutChanged		= 4,
	pmDimmingEnableChanged		= 5,
	pmDiskModeAddressChanged	= 6,
	pmProcessorCyclingChanged	= 7,
	pmProcessorSpeedChanged		= 8,
	pmWakeupTimerChanged		= 9,
	pmStartupTimerChanged		= 10,
	pmHardDiskPowerRemovedbyUser= 11
};

/* System Activity Selectors */
enum {
	OverallAct					= 0,		/* general type of activity							*/
	UsrActivity					= 1,		/* user specific type of activity					*/
	NetActivity					= 2,		/* network specific activity						*/
	HDActivity					= 3			/* Hard Drive activity								*/
};

/* Storage Media sleep mode defines */

enum {
	kMediaModeOn				= 0, 		/* Media active (Drive spinning and at full power)	*/
	kMediaModeStandBy			= 1, 		/* Media standby (not implemented)	*/
	kMediaModeSuspend			= 2, 		/* Media Idle (not implemented)	*/
	kMediaModeOff				= 3 		/* Media Sleep (Drive not spinning and at min power, max recovery time)	*/
};

enum { kMediaPowerCSCode = 70 };

typedef struct ActivityInfo ActivityInfo;

struct ActivityInfo {
	short			ActivityType;			/* Type of activity to be fetched.  Same as UpdateSystemActivity Selectors */	
	unsigned long	ActivityTime;			/* Time of last activity (in ticks) of specified type. */
};

typedef struct BatteryInfo BatteryInfo;

struct BatteryInfo {
	UInt8							flags;						/* misc flags (see below)							*/
	UInt8							warningLevel;				/* scaled warning level (0-255)						*/
	UInt8							reserved;					/* reserved for internal use						*/
	UInt8							batteryLevel;				/* scaled battery level (0-255)						*/
};
typedef SInt8 ModemByte;

typedef SInt8 BatteryByte;

typedef long PMResultCode;

typedef struct SleepQRec SleepQRec, *SleepQRecPtr;

typedef struct HDQueueElement HDQueueElement;

typedef struct PMgrQueueElement PMgrQueueElement;

/*
		SleepQProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

			typedef pascal long (*SleepQProcPtr)(long message, SleepQRecPtr qRecPtr);

		In:
		 => message     	D0.L
		 => qRecPtr     	A0.L
		Out:
		 <= return value	D0.L
*/
typedef pascal void (*HDSpindownProcPtr)(HDQueueElement *theElement);
typedef pascal void (*PMgrStateChangeProcPtr)(PMgrQueueElement *theElement, long stateBits);

#if GENERATINGCFM
typedef UniversalProcPtr SleepQUPP;
typedef UniversalProcPtr HDSpindownUPP;
typedef UniversalProcPtr PMgrStateChangeUPP;
#else
typedef Register68kProcPtr SleepQUPP;
typedef HDSpindownProcPtr HDSpindownUPP;
typedef PMgrStateChangeProcPtr PMgrStateChangeUPP;
#endif

struct SleepQRec {
	struct SleepQRec				*sleepQLink;				/* pointer to next queue element				*/
	short							sleepQType;					/* queue element type (must be SleepQType)		*/
	SleepQUPP						sleepQProc;					/* pointer to sleep universal proc ptr			*/
	short							sleepQFlags;				/* flags										*/
};
struct HDQueueElement {
	struct HDQueueElement			*hdQLink;					/* pointer to next queue element				*/
	short							hdQType;					/* queue element type (must be HDPwrQType)		*/
	short							hdFlags;					/* miscellaneous flags							*/
	HDSpindownUPP					hdProc;						/* pointer to routine to call					*/
	long							hdUser;						/* user-defined (variable storage, etc.)		*/
};
struct PMgrQueueElement {
	struct PMgrQueueElement *		pmQLink;					/* pointer to next queue element				*/
	short 							pmQType;					/* queue element type (must be PMgrStateQType)	*/
	short 							pmFlags;					/* miscellaneous flags							*/
	long 							pmNotifyBits;				/* bitmap of which changes to be notified for	*/
	PMgrStateChangeUPP 				pmProc;						/* pointer to routine to call					*/
	long 							pmUser;						/* user-defined (variable storage, etc.)		*/
};

typedef struct BatteryTimeRec BatteryTimeRec;

struct BatteryTimeRec {
	unsigned long					expectedBatteryTime;		/* estimated battery time remaining (seconds)	*/
	unsigned long					minimumBatteryTime;			/* minimum battery time remaining (seconds)		*/
	unsigned long					maximumBatteryTime;			/* maximum battery time remaining (seconds)		*/
	unsigned long					timeUntilCharged;			/* time until battery is fully charged (seconds)*/
};
typedef struct WakeupTime WakeupTime;

struct WakeupTime {
	unsigned long					wakeTime;					/* wakeup time (same format as current time)		*/
	Boolean							wakeEnabled;				/* 1=enable wakeup timer, 0=disable wakeup timer	*/
	SInt8							filler;
};
typedef struct StartupTime StartupTime;

struct StartupTime {
	unsigned long					startTime;					/* startup time (same format as current time)		*/
	Boolean							startEnabled;				/* 1=enable startup timer, 0=disable startup timer	*/
	SInt8							filler;
};
extern pascal OSErr DisableWUTime(void);
extern pascal OSErr SetWUTime(long WUTime);
extern pascal OSErr GetWUTime(long *WUTime, Byte *WUFlag);
extern pascal OSErr BatteryStatus(Byte *Status, Byte *Power);
extern pascal OSErr ModemStatus(Byte *Status);

#if !GENERATINGCFM
#pragma parameter __D0 IdleUpdate
#endif
extern pascal long IdleUpdate(void)
 ONEWORDINLINE(0xA285);

#if !GENERATINGCFM
#pragma parameter __D0 GetCPUSpeed
#endif
extern pascal long GetCPUSpeed(void)
 TWOWORDINLINE(0x70FF, 0xA485);
extern pascal void EnableIdle(void)
 TWOWORDINLINE(0x7000, 0xA485);
extern pascal void DisableIdle(void)
 TWOWORDINLINE(0x7001, 0xA485);

#if !GENERATINGCFM
#pragma parameter SleepQInstall(__A0)
#endif
extern pascal void SleepQInstall(SleepQRecPtr qRecPtr)
 ONEWORDINLINE(0xA28A);

#if !GENERATINGCFM
#pragma parameter SleepQRemove(__A0)
#endif
extern pascal void SleepQRemove(SleepQRecPtr qRecPtr)
 ONEWORDINLINE(0xA48A);
extern pascal void AOn(void)
 TWOWORDINLINE(0x7004, 0xA685);
extern pascal void AOnIgnoreModem(void)
 TWOWORDINLINE(0x7005, 0xA685);
extern pascal void BOn(void)
 TWOWORDINLINE(0x7000, 0xA685);
extern pascal void AOff(void)
 TWOWORDINLINE(0x7084, 0xA685);
extern pascal void BOff(void)
 TWOWORDINLINE(0x7080, 0xA685);
/* Public Power Management API (NEW!) */

#if !GENERATINGCFM
#pragma parameter __D0 PMSelectorCount
#endif
extern pascal short PMSelectorCount(void)
 TWOWORDINLINE(0x7000, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 PMFeatures
#endif
extern pascal unsigned long PMFeatures(void)
 TWOWORDINLINE(0x7001, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 GetSleepTimeout
#endif
extern pascal UInt8 GetSleepTimeout(void)
 TWOWORDINLINE(0x7002, 0xA09E);

#if !GENERATINGCFM
#pragma parameter SetSleepTimeout(__D0)
#endif
extern pascal void SetSleepTimeout(UInt8 timeout)
 FOURWORDINLINE(0x4840, 0x303C, 0x0003, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 GetHardDiskTimeout
#endif
extern pascal UInt8 GetHardDiskTimeout(void)
 TWOWORDINLINE(0x7004, 0xA09E);

#if !GENERATINGCFM
#pragma parameter SetHardDiskTimeout(__D0)
#endif
extern pascal void SetHardDiskTimeout(UInt8 timeout)
 FOURWORDINLINE(0x4840, 0x303C, 0x0005, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 HardDiskPowered
#endif
extern pascal Boolean HardDiskPowered(void)
 TWOWORDINLINE(0x7006, 0xA09E);

#if !GENERATINGCFM
#pragma parameter SpinDownHardDisk
#endif
extern pascal void SpinDownHardDisk(void)
 TWOWORDINLINE(0x7007, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 IsSpindownDisabled
#endif
extern pascal Boolean IsSpindownDisabled(void)
 TWOWORDINLINE(0x7008, 0xA09E);

#if !GENERATINGCFM
#pragma parameter SetSpindownDisable(__D0)
#endif
extern pascal void SetSpindownDisable(Boolean setDisable)
 FOURWORDINLINE(0x4840, 0x303C, 0x0009, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 HardDiskQInstall(__A0)
#endif
extern pascal OSErr HardDiskQInstall(HDQueueElement *theElement)
 TWOWORDINLINE(0x700A, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 HardDiskQRemove(__A0)
#endif
extern pascal OSErr HardDiskQRemove(HDQueueElement *theElement)
 TWOWORDINLINE(0x700B, 0xA09E);

#if !GENERATINGCFM
#pragma parameter GetScaledBatteryInfo(__D0, __A0)
#endif
extern pascal void GetScaledBatteryInfo(short whichBattery, BatteryInfo *theInfo)
 FIVEWORDINLINE(0x4840, 0x303C, 0x000C, 0xA09E, 0x2080);

#if !GENERATINGCFM
#pragma parameter AutoSleepControl(__D0)
#endif
extern pascal void AutoSleepControl(Boolean enableSleep)
 FOURWORDINLINE(0x4840, 0x303C, 0x000D, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 GetIntModemInfo
#endif
extern pascal unsigned long GetIntModemInfo(void)
 TWOWORDINLINE(0x700E, 0xA09E);

#if !GENERATINGCFM
#pragma parameter SetIntModemState(__D0)
#endif
extern pascal void SetIntModemState(short theState)
 FOURWORDINLINE(0x4840, 0x303C, 0x000F, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 MaximumProcessorSpeed
#endif
extern pascal short MaximumProcessorSpeed(void)
 TWOWORDINLINE(0x7010, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 CurrentProcessorSpeed
#endif
extern pascal short CurrentProcessorSpeed(void)
 TWOWORDINLINE(0x7011, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 FullProcessorSpeed
#endif
extern pascal Boolean FullProcessorSpeed(void)
 TWOWORDINLINE(0x7012, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 SetProcessorSpeed(__D0)
#endif
extern pascal Boolean SetProcessorSpeed(Boolean fullSpeed)
 FOURWORDINLINE(0x4840, 0x303C, 0x0013, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 GetSCSIDiskModeAddress
#endif
extern pascal short GetSCSIDiskModeAddress(void)
 TWOWORDINLINE(0x7014, 0xA09E);

#if !GENERATINGCFM
#pragma parameter SetSCSIDiskModeAddress(__D0)
#endif
extern pascal void SetSCSIDiskModeAddress(short scsiAddress)
 FOURWORDINLINE(0x4840, 0x303C, 0x0015, 0xA09E);

#if !GENERATINGCFM
#pragma parameter GetWakeupTimer(__A0)
#endif
extern pascal void GetWakeupTimer(WakeupTime *theTime)
 TWOWORDINLINE(0x7016, 0xA09E);

#if !GENERATINGCFM
#pragma parameter SetWakeupTimer(__A0)
#endif
extern pascal void SetWakeupTimer(WakeupTime *theTime)
 TWOWORDINLINE(0x7017, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 IsProcessorCyclingEnabled
#endif
extern pascal Boolean IsProcessorCyclingEnabled(void)
 TWOWORDINLINE(0x7018, 0xA09E);

#if !GENERATINGCFM
#pragma parameter EnableProcessorCycling(__D0)
#endif
extern pascal void EnableProcessorCycling(Boolean enable)
 FOURWORDINLINE(0x4840, 0x303C, 0x0019, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 BatteryCount
#endif
extern pascal short BatteryCount(void)
 TWOWORDINLINE(0x701A, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 GetBatteryVoltage(__D0)
#endif
extern pascal Fixed GetBatteryVoltage(short whichBattery)
 FOURWORDINLINE(0x4840, 0x303C, 0x001B, 0xA09E);

#if !GENERATINGCFM
#pragma parameter GetBatteryTimes(__D0, __A0)
#endif
extern pascal void GetBatteryTimes(short whichBattery, BatteryTimeRec *theTimes)
 FOURWORDINLINE(0x4840, 0x303C, 0x001C, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 GetDimmingTimeout
#endif
extern pascal UInt8 GetDimmingTimeout(void)
 TWOWORDINLINE(0x701D, 0xA09E);

#if !GENERATINGCFM
#pragma parameter SetDimmingTimeout(__D0)
#endif
extern pascal void SetDimmingTimeout(UInt8 timeout)
 FOURWORDINLINE(0x4840, 0x303C, 0x001E, 0xA09E);

#if !GENERATINGCFM
#pragma parameter DimmingControl(__D0)
#endif
extern pascal void DimmingControl(Boolean enableSleep)
 FOURWORDINLINE(0x4840, 0x303C, 0x001F, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 IsDimmingControlDisabled
#endif
extern pascal Boolean IsDimmingControlDisabled(void)
 TWOWORDINLINE(0x7020, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 IsAutoSlpControlDisabled
#endif
extern pascal Boolean IsAutoSlpControlDisabled(void)
 TWOWORDINLINE(0x7021, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 PMgrStateQInstall(__A0)
#endif
extern pascal OSErr PMgrStateQInstall(PMgrQueueElement *theElement)
 TWOWORDINLINE(0x7022, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 PMgrStateQRemove(__A0)
#endif
extern pascal OSErr PMgrStateQRemove(PMgrQueueElement *theElement)
 TWOWORDINLINE(0x7023, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 UpdateSystemActivity(__D0)
#endif
extern pascal OSErr UpdateSystemActivity(UInt8 activity)
 FOURWORDINLINE(0x4840, 0x303C, 0x0024, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 DelaySystemIdle
#endif
extern pascal OSErr DelaySystemIdle(void )
 TWOWORDINLINE(0x7025, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 GetStartupTimer(__A0)
#endif
extern pascal OSErr GetStartupTimer(StartupTime *theTime)
 TWOWORDINLINE(0x7026, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 SetStartupTimer(__A0)
#endif
extern pascal OSErr SetStartupTimer(StartupTime *theTime)
 TWOWORDINLINE(0x7027, 0xA09E);

#if !GENERATINGCFM
#pragma parameter __D0 GetLastActivity(__A0)
#endif
extern pascal OSErr GetLastActivity(ActivityInfo *theActivity)
 TWOWORDINLINE(0x7028, 0xA09E);

enum {
	uppSleepQProcInfo = kRegisterBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(long)))
		 | REGISTER_RESULT_LOCATION(kRegisterD0)
		 | REGISTER_ROUTINE_PARAMETER(1, kRegisterD0, SIZE_CODE(sizeof(long)))
		 | REGISTER_ROUTINE_PARAMETER(2, kRegisterA0, SIZE_CODE(sizeof(SleepQRecPtr))),
	uppHDSpindownProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(HDQueueElement*)))
};

#if GENERATINGCFM
#define NewSleepQProc(userRoutine)		\
		(SleepQUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSleepQProcInfo, GetCurrentArchitecture())
#define NewHDSpindownProc(userRoutine)		\
		(HDSpindownUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppHDSpindownProcInfo, GetCurrentArchitecture())
#else
#define NewSleepQProc(userRoutine)		\
		((SleepQUPP) (userRoutine))
#define NewHDSpindownProc(userRoutine)		\
		((HDSpindownUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallSleepQProc(userRoutine, message, qRecPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSleepQProcInfo, (message), (qRecPtr))
#define CallHDSpindownProc(userRoutine, theElement)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppHDSpindownProcInfo, (theElement))
#else
/* (*SleepQProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
#define CallHDSpindownProc(userRoutine, theElement)		\
		(*(userRoutine))((theElement))
#endif


#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __POWER__ */

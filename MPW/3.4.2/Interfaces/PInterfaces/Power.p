{
 	File:		Power.p
 
 	Contains:	Power Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
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
 UNIT Power;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __POWER__}
{$SETC __POWER__ := 1}

{$I+}
{$SETC PowerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{ Bit positions for ModemByte }
	modemOnBit					= 0;
	ringWakeUpBit				= 2;
	modemInstalledBit			= 3;
	ringDetectBit				= 4;
	modemOnHookBit				= 5;
{ masks for ModemByte }
	modemOnMask					= $01;
	ringWakeUpMask				= $04;
	modemInstalledMask			= $08;
	ringDetectMask				= $10;
	modemOnHookMask				= $20;
{ bit positions for BatteryByte }
	chargerConnBit				= 0;
	hiChargeBit					= 1;
	chargeOverFlowBit			= 2;
	batteryDeadBit				= 3;
	batteryLowBit				= 4;
	connChangedBit				= 5;
{ masks for BatteryByte }
	chargerConnMask				= $01;
	hiChargeMask				= $02;
	chargeOverFlowMask			= $04;
	batteryDeadMask				= $08;
	batteryLowMask				= $10;
	connChangedMask				= $20;

{ commands to SleepQRec sleepQProc }
	sleepRequest				= 1;
	sleepDemand					= 2;
	sleepWakeUp					= 3;
	sleepRevoke					= 4;
	sleepUnlock					= 4;
	sleepDeny					= 5;
	sleepNow					= 6;
	dozeDemand					= 7;
	dozeWakeUp					= 8;
	dozeRequest					= 9;
{ SleepQRec.sleepQFlags }
	noCalls						= 1;
	noRequest					= 2;
	slpQType					= 16;
	sleepQType					= 16;

{ bits in bitfield returned by PMFeatures }
	hasWakeupTimer				= 0;							{ 1=wakeup timer is supported						}
	hasSharedModemPort			= 1;							{ 1=modem port shared by SCC and internal modem	}
	hasProcessorCycling			= 2;							{ 1=processor cycling is supported					}
	mustProcessorCycle			= 3;							{ 1=processor cycling should not be turned off		}
	hasReducedSpeed				= 4;							{ 1=processor can be started up at reduced speed	}
	dynamicSpeedChange			= 5;							{ 1=processor speed can be switched dynamically	}
	hasSCSIDiskMode				= 6;							{ 1=SCSI Disk Mode is supported					}
	canGetBatteryTime			= 7;							{ 1=battery time can be calculated					}
	canWakeupOnRing				= 8;							{ 1=can wakeup when the modem detects a ring		}
	hasDimmingSupport			= 9;							{ 1=has dimming support built in					}
	hasStartupTimer				= 10;							{ 1=startup timer is supported						}

{ bits in bitfield returned by GetIntModemInfo and set by SetIntModemState }
	hasInternalModem			= 0;							{ 1=internal modem installed						}
	intModemRingDetect			= 1;							{ 1=internal modem has detected a ring				}
	intModemOffHook				= 2;							{ 1=internal modem is off hook						}
	intModemRingWakeEnb			= 3;							{ 1=wakeup on ring is enabled						}
	extModemSelected			= 4;							{ 1=external modem selected						}
	modemSetBit					= 15;							{ 1=set bit, 0=clear bit (SetIntModemState)		}

{ bits in BatteryInfo.flags 									}
{ ("chargerConnected" doesn't mean the charger is plugged in)	}
	batteryInstalled			= 7;							{ 1=battery is currently connected					}
	batteryCharging				= 6;							{ 1=battery is being charged						}
	chargerConnected			= 5;							{ 1=charger is connected to the PowerBook			}

	HDPwrQType					= 'HD';							{ hard disk spindown queue element type			}
	PMgrStateQType				= 'PM';


TYPE
	BatteryInfo = PACKED RECORD
		flags:					UInt8;									{ misc flags (see below)							}
		warningLevel:			UInt8;									{ scaled warning level (0-255)						}
		reserved:				UInt8;									{ reserved for internal use						}
		batteryLevel:			UInt8;									{ scaled battery level (0-255)						}
	END;

	ModemByte = SInt8;

	BatteryByte = SInt8;

	PMResultCode = LONGINT;

	SleepQRecPtr = ^SleepQRec;

	{
		SleepQProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => message     	D0.L
		 => qRecPtr     	A0.L
		Out:
		 <= return value	D0.L
	}
	SleepQProcPtr = Register68kProcPtr;  { register FUNCTION SleepQ(message: LONGINT; qRecPtr: SleepQRecPtr): LONGINT; }
	HDSpindownProcPtr = ProcPtr;  { PROCEDURE HDSpindown(VAR theElement: HDQueueElement); }
	SleepQUPP = UniversalProcPtr;
	HDSpindownUPP = UniversalProcPtr;

	SleepQRec = RECORD
		sleepQLink:				^SleepQRec;								{ pointer to next queue element				}
		sleepQType:				INTEGER;								{ queue element type (must be SleepQType)		}
		sleepQProc:				SleepQUPP;								{ pointer to sleep universal proc ptr			}
		sleepQFlags:			INTEGER;								{ flags										}
	END;

	HDQueueElement = RECORD
		hdQLink:				^HDQueueElement;						{ pointer to next queue element				}
		hdQType:				INTEGER;								{ queue element type (must be HDPwrQType)		}
		hdFlags:				INTEGER;								{ miscellaneous flags							}
		hdProc:					HDSpindownUPP;							{ pointer to routine to call					}
		hdUser:					LONGINT;								{ user-defined (variable storage, etc.)		}
	END;

	BatteryTimeRec = RECORD
		expectedBatteryTime:	LONGINT;								{ estimated battery time remaining (seconds)	}
		minimumBatteryTime:		LONGINT;								{ minimum battery time remaining (seconds)		}
		maximumBatteryTime:		LONGINT;								{ maximum battery time remaining (seconds)		}
		timeUntilCharged:		LONGINT;								{ time until battery is fully charged (seconds)}
	END;

	WakeupTime = RECORD
		wakeTime:				LONGINT;								{ wakeup time (same format as current time)		}
		wakeEnabled:			BOOLEAN;								{ 1=enable wakeup timer, 0=disable wakeup timer	}
	END;

	StartupTime = RECORD
		startTime:				LONGINT;								{ startup time (same format as current time)		}
		startEnabled:			BOOLEAN;								{ 1=enable startup timer, 0=disable startup timer	}
	END;


FUNCTION DisableWUTime: OSErr;
FUNCTION SetWUTime(WUTime: LONGINT): OSErr;
FUNCTION GetWUTime(VAR WUTime: LONGINT; VAR WUFlag: SignedByte): OSErr;
FUNCTION BatteryStatus(VAR Status: SignedByte; VAR Power: SignedByte): OSErr;
FUNCTION ModemStatus(VAR Status: SignedByte): OSErr;
FUNCTION IdleUpdate: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A285, $2E80;
	{$ENDC}
FUNCTION GetCPUSpeed: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $70FF, $A485, $2E80;
	{$ENDC}
PROCEDURE EnableIdle;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $A485;
	{$ENDC}
PROCEDURE DisableIdle;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $A485;
	{$ENDC}
PROCEDURE SleepQInstall(qRecPtr: SleepQRecPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A28A;
	{$ENDC}
PROCEDURE SleepQRemove(qRecPtr: SleepQRecPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A48A;
	{$ENDC}
PROCEDURE AOn;
	{$IFC NOT GENERATINGCFM}
	INLINE $7004, $A685;
	{$ENDC}
PROCEDURE AOnIgnoreModem;
	{$IFC NOT GENERATINGCFM}
	INLINE $7005, $A685;
	{$ENDC}
PROCEDURE BOn;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $A685;
	{$ENDC}
PROCEDURE AOff;
	{$IFC NOT GENERATINGCFM}
	INLINE $7084, $A685;
	{$ENDC}
PROCEDURE BOff;
	{$IFC NOT GENERATINGCFM}
	INLINE $7080, $A685;
	{$ENDC}
{ Public Power Management API (NEW!) }
FUNCTION PMSelectorCount: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $A09E, $3E80;
	{$ENDC}
FUNCTION PMFeatures: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $A09E, $2E80;
	{$ENDC}
FUNCTION GetSleepTimeout: UInt8;
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $A09E, $1E80;
	{$ENDC}
PROCEDURE SetSleepTimeout(timeout: ByteParameter);
	{$IFC NOT GENERATINGCFM}
	INLINE $101F, $4840, $303C, $0003, $A09E;
	{$ENDC}
FUNCTION GetHardDiskTimeout: UInt8;
	{$IFC NOT GENERATINGCFM}
	INLINE $7004, $A09E, $1E80;
	{$ENDC}
PROCEDURE SetHardDiskTimeout(timeout: ByteParameter);
	{$IFC NOT GENERATINGCFM}
	INLINE $101F, $4840, $303C, $0005, $A09E;
	{$ENDC}
FUNCTION HardDiskPowered: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7006, $A09E, $1E80;
	{$ENDC}
PROCEDURE SpinDownHardDisk;
	{$IFC NOT GENERATINGCFM}
	INLINE $7007, $A09E;
	{$ENDC}
FUNCTION IsSpindownDisabled: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7008, $A09E, $1E80;
	{$ENDC}
PROCEDURE SetSpindownDisable(setDisable: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $101F, $4840, $303C, $0009, $A09E;
	{$ENDC}
FUNCTION HardDiskQInstall(VAR theElement: HDQueueElement): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $700A, $A09E, $3E80;
	{$ENDC}
FUNCTION HardDiskQRemove(VAR theElement: HDQueueElement): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $700B, $A09E, $3E80;
	{$ENDC}
PROCEDURE GetScaledBatteryInfo(whichBattery: INTEGER; VAR theInfo: BatteryInfo);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $301F, $4840, $303C, $000C, $A09E, $2080;
	{$ENDC}
PROCEDURE AutoSleepControl(enableSleep: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $101F, $4840, $303C, $000D, $A09E;
	{$ENDC}
FUNCTION GetIntModemInfo: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $700E, $A09E, $2E80;
	{$ENDC}
PROCEDURE SetIntModemState(theState: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $4840, $303C, $000F, $A09E;
	{$ENDC}
FUNCTION MaximumProcessorSpeed: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $7010, $A09E, $3E80;
	{$ENDC}
FUNCTION CurrentProcessorSpeed: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $7011, $A09E, $3E80;
	{$ENDC}
FUNCTION FullProcessorSpeed: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7012, $A09E, $1E80;
	{$ENDC}
FUNCTION SetProcessorSpeed(fullSpeed: BOOLEAN): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $101F, $4840, $303C, $0013, $A09E, $1E80;
	{$ENDC}
FUNCTION GetSCSIDiskModeAddress: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $7014, $A09E, $3E80;
	{$ENDC}
PROCEDURE SetSCSIDiskModeAddress(scsiAddress: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $4840, $303C, $0015, $A09E;
	{$ENDC}
PROCEDURE GetWakeupTimer(VAR theTime: WakeupTime);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7016, $A09E;
	{$ENDC}
PROCEDURE SetWakeupTimer(VAR theTime: WakeupTime);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $7017, $A09E;
	{$ENDC}
FUNCTION IsProcessorCyclingEnabled: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7018, $A09E, $1E80;
	{$ENDC}
PROCEDURE EnableProcessorCycling(enable: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $101F, $4840, $303C, $0019, $A09E;
	{$ENDC}
FUNCTION BatteryCount: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $701A, $A09E, $3E80;
	{$ENDC}
FUNCTION GetBatteryVoltage(whichBattery: INTEGER): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $4840, $303C, $001B, $A09E, $2E80;
	{$ENDC}
PROCEDURE GetBatteryTimes(whichBattery: INTEGER; VAR theTimes: BatteryTimeRec);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $301F, $4840, $303C, $001C, $A09E;
	{$ENDC}
FUNCTION GetDimmingTimeout: UInt8;
	{$IFC NOT GENERATINGCFM}
	INLINE $701D, $A09E, $1E80;
	{$ENDC}
PROCEDURE SetDimmingTimeout(timeout: ByteParameter);
	{$IFC NOT GENERATINGCFM}
	INLINE $101F, $4840, $303C, $001E, $A09E;
	{$ENDC}
PROCEDURE DimmingControl(enableSleep: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $101F, $4840, $303C, $001F, $A09E;
	{$ENDC}
FUNCTION IsDimmingControlDisabled: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7020, $A09E, $1E80;
	{$ENDC}
FUNCTION IsAutoSlpControlDisabled: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7021, $A09E, $1E80;
	{$ENDC}
CONST
	uppSleepQProcInfo = $00131832; { Register FUNCTION (4 bytes in D0, 4 bytes in A0): 4 bytes in D0; }
	uppHDSpindownProcInfo = $000000C0; { PROCEDURE (4 byte param); }

FUNCTION NewSleepQProc(userRoutine: SleepQProcPtr): SleepQUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewHDSpindownProc(userRoutine: HDSpindownProcPtr): HDSpindownUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallSleepQProc(message: LONGINT; qRecPtr: SleepQRecPtr; userRoutine: SleepQUPP): LONGINT;
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallHDSpindownProc(VAR theElement: HDQueueElement; userRoutine: HDSpindownUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PowerIncludes}

{$ENDC} {__POWER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

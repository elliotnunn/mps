{
     File:       Power.p
 
     Contains:   Power Manager Interfaces.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1990-2001 by Apple Computer, Inc.  All rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __MULTIPROCESSING__}
{$I Multiprocessing.p}
{$ENDC}
{$IFC UNDEFINED __NAMEREGISTRY__}
{$I NameRegistry.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  Bit positions for ModemByte  }
	modemOnBit					= 0;
	ringWakeUpBit				= 2;
	modemInstalledBit			= 3;
	ringDetectBit				= 4;
	modemOnHookBit				= 5;

																{  masks for ModemByte  }
	modemOnMask					= $01;
	ringWakeUpMask				= $04;
	modemInstalledMask			= $08;
	ringDetectMask				= $10;
	modemOnHookMask				= $20;

																{  bit positions for BatteryByte  }
	chargerConnBit				= 0;
	hiChargeBit					= 1;
	chargeOverFlowBit			= 2;
	batteryDeadBit				= 3;
	batteryLowBit				= 4;
	connChangedBit				= 5;

																{  masks for BatteryByte  }
	chargerConnMask				= $01;
	hiChargeMask				= $02;
	chargeOverFlowMask			= $04;
	batteryDeadMask				= $08;
	batteryLowMask				= $10;
	connChangedMask				= $20;

																{  bit positions for SoundMixerByte  }
	MediaBaySndEnBit			= 0;
	PCISndEnBit					= 1;
	ZVSndEnBit					= 2;
	PCCardSndEnBit				= 3;

																{  masks for SoundMixerByte  }
	MediaBaySndEnMask			= $01;
	PCISndEnMask				= $02;
	ZVSndEnMask					= $04;
	PCCardSndEnMask				= $08;

																{  commands to SleepQRec sleepQProc  }
	kSleepRequest				= 1;
	kSleepDemand				= 2;
	kSleepWakeUp				= 3;
	kSleepRevoke				= 4;
	kSleepUnlock				= 4;
	kSleepDeny					= 5;
	kSleepNow					= 6;
	kDozeDemand					= 7;
	kDozeWakeUp					= 8;
	kDozeRequest				= 9;							{  additional messages for Power Mgr 2.0 }
	kEnterStandby				= 10;
	kEnterRun					= 11;
	kSuspendRequest				= 12;
	kSuspendDemand				= 13;
	kSuspendRevoke				= 14;
	kSuspendWakeUp				= 15;
	kGetPowerLevel				= 16;
	kSetPowerLevel				= 17;
	kDeviceInitiatedWake		= 18;
	kWakeToDoze					= 19;
	kDozeToFullWakeUp			= 20;
	kGetPowerInfo				= 21;
	kGetWakeOnNetInfo			= 22;

																{  depreciated commands to SleepQRec sleepQProc  }
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
	enterStandby				= 10;
	enterRun					= 11;
	suspendRequestMsg			= 12;
	suspendDemandMsg			= 13;
	suspendRevokeMsg			= 14;
	suspendWakeUpMsg			= 15;
	getPowerLevel				= 16;
	setPowerLevel				= 17;

	{	 Power Handler func messages 	}

TYPE
	PowerLevel							= UInt32;
	{	 Power levels corresponding to PCI Bus Power Management Interface Spec (PMIS) 	}

CONST
	kPMDevicePowerLevel_On		= 0;							{  fully-powered 'On' state (D0 state)     }
	kPMDevicePowerLevel_D1		= 1;							{  not used by Apple system SW          }
	kPMDevicePowerLevel_D2		= 2;							{  not used by Apple system SW          }
	kPMDevicePowerLevel_Off		= 3;							{  main PCI bus power 'Off', but PCI standby power available (D3cold state)  }

	{	 PowerHandlerProc definition 	}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PowerHandlerProcPtr = FUNCTION(message: UInt32; param: UNIV Ptr; refCon: UInt32; VAR regEntryID: RegEntryID): OSStatus;
{$ELSEC}
	PowerHandlerProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	PowerHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PowerHandlerUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppPowerHandlerProcInfo = $00003FF0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewPowerHandlerUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewPowerHandlerUPP(userRoutine: PowerHandlerProcPtr): PowerHandlerUPP; { old name was NewPowerHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposePowerHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePowerHandlerUPP(userUPP: PowerHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokePowerHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokePowerHandlerUPP(message: UInt32; param: UNIV Ptr; refCon: UInt32; VAR regEntryID: RegEntryID; userRoutine: PowerHandlerUPP): OSStatus; { old name was CallPowerHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{  PCI power management support }

CONST
	kUseDefaultMinimumWakeTime	= 0;							{  Defaults to 5 minutes }
	kPowerSummaryVersion		= 1;							{  Version of PowerSummary structure. }
	kDevicePowerInfoVersion		= 1;							{  Version of DevicePowerInfo structure. }

																{  PowerSummary flags }
	kPCIPowerOffAllowed			= $00000001;					{  PCI power off is allowed. }

																{  DevicePowerInfo flags }
	kDevicePCIPowerOffAllowed	= $00000001;					{  PCI power off is allowed for device. }
	kDeviceSupportsPMIS			= $00000002;					{  Device supports Power Mgt Interface Spec. }
	kDeviceCanAssertPMEDuringSleep = $00000004;					{  Device can assert PME# during sleep. }
	kDeviceUsesCommonLogicPower	= $00000008;					{  Device uses common-logic power }
	kDeviceDriverPresent		= $00000010;					{  Driver present for device. }
	kDeviceDriverSupportsPowerMgt = $00000020;					{  Driver installed a power handler. }


TYPE
	DevicePowerInfoPtr = ^DevicePowerInfo;
	DevicePowerInfo = RECORD
		version:				UInt32;									{  Version of this structure. }
		regID:					RegEntryID;								{  RegEntryID for device. }
		flags:					OptionBits;								{  Flags }
		minimumWakeTime:		UInt32;									{  Minimum seconds before sleeping again. }
		sleepPowerNeeded:		UInt32;									{  Milliwatts needed in the sleep state. }
	END;

	PowerSummaryPtr = ^PowerSummary;
	PowerSummary = RECORD
		version:				UInt32;									{  Version of this structure. }
		flags:					OptionBits;								{  Flags }
		sleepPowerAvailable:	UInt32;									{  Milliwatts available during sleep. }
		sleepPowerNeeded:		UInt32;									{  Milliwatts needed during sleep. }
		minimumWakeTime:		UInt32;									{  Minimum seconds before sleeping again. }
		deviceCount:			ItemCount;								{  Number of device power info records. }
		devices:				ARRAY [0..0] OF DevicePowerInfo;		{  Array of device power info records. }
	END;


CONST
																{  SleepQRec.sleepQFlags  }
	noCalls						= 1;
	noRequest					= 2;
	slpQType					= 16;
	sleepQType					= 16;

	{	 Power Mgt Apple Event types and errors 	}
																{  power mgt class }
	kAEMacPowerMgtEvt			= 'pmgt';						{  event ids }
	kAEMacToWake				= 'wake';
	kAEMacLowPowerSaveData		= 'pmsd';
	kAEMacEmergencySleep		= 'emsl';
	kAEMacEmergencyShutdown		= 'emsd';


	{
	   These are result values returned by a Power Handler when queries
	   by the Power Mgr if the device which that Power Handler represents
	   woke the machine.
	}
	kDeviceDidNotWakeMachine	= 0;							{  device did NOT wake machine }
	kDeviceRequestsFullWake		= 1;							{  device did wake machine and requests full wakeup }
	kDeviceRequestsWakeToDoze	= 2;							{  device did wake machine and requests partial wakeup }

	{	 bits in bitfield returned by PMFeatures 	}
	hasWakeupTimer				= 0;							{  1=wakeup timer is supported                     }
	hasSharedModemPort			= 1;							{  1=modem port shared by SCC and internal modem        }
	hasProcessorCycling			= 2;							{  1=processor cycling is supported                 }
	mustProcessorCycle			= 3;							{  1=processor cycling should not be turned off           }
	hasReducedSpeed				= 4;							{  1=processor can be started up at reduced speed         }
	dynamicSpeedChange			= 5;							{  1=processor speed can be switched dynamically        }
	hasSCSIDiskMode				= 6;							{  1=SCSI Disk Mode is supported                  }
	canGetBatteryTime			= 7;							{  1=battery time can be calculated                 }
	canWakeupOnRing				= 8;							{  1=can wakeup when the modem detects a ring           }
	hasDimmingSupport			= 9;							{  1=has dimming support built in (DPMS standby by default)    }
	hasStartupTimer				= 10;							{  1=startup timer is supported                     }
	hasChargeNotification		= 11;							{  1=client can determine of charge connect status change notifications available  }
	hasDimSuspendSupport		= 12;							{  1=supports dimming LCD and CRT to DPMS suspend state      }
	hasWakeOnNetActivity		= 13;							{  1=hardware supports wake on network activity           }
	hasWakeOnLid				= 14;							{  1=hardware can wake when opened                    }
	canPowerOffPCIBus			= 15;							{  1=hardware can power off PCI bus during sleep if cards allow  }
	hasDeepSleep				= 16;							{  1=hardware supports deep sleep (hibernation) mode    }
	hasSleep					= 17;							{  1=hardware supports normal (PowerBook-like) sleep    }
	supportsServerModeAPIs		= 18;							{  1=hardware supports server mode API routines           }
	supportsUPSIntegration		= 19;							{  1=hardware support UPS integration and reporting       }

	{	 bits in bitfield returned by GetIntModemInfo and set by SetIntModemState 	}
	hasInternalModem			= 0;							{  1=internal modem installed                }
	intModemRingDetect			= 1;							{  1=internal modem has detected a ring           }
	intModemOffHook				= 2;							{  1=internal modem is off hook                }
	intModemRingWakeEnb			= 3;							{  1=wakeup on ring is enabled                  }
	extModemSelected			= 4;							{  1=external modem selected              }
	modemSetBit					= 15;							{  1=set bit, 0=clear bit (SetIntModemState)    }

	{	 bits in BatteryInfo.flags                                    	}
	{	 ("chargerConnected" doesn't mean the charger is plugged in)  	}
	batteryInstalled			= 7;							{  1=battery is currently connected              }
	batteryCharging				= 6;							{  1=battery is being charged                }
	chargerConnected			= 5;							{  1=charger is connected to the PowerBook          }

	HDPwrQType					= $4844;						{  'HD' hard disk spindown queue element type      }
	PMgrStateQType				= $504D;						{  'PM' Power Manager state queue element type        }

	{	 client notification bits in PMgrQueueElement.pmNotifyBits 	}
	pmSleepTimeoutChanged		= 0;
	pmSleepEnableChanged		= 1;
	pmHardDiskTimeoutChanged	= 2;
	pmHardDiskSpindownChanged	= 3;
	pmDimmingTimeoutChanged		= 4;
	pmDimmingEnableChanged		= 5;
	pmDiskModeAddressChanged	= 6;
	pmProcessorCyclingChanged	= 7;
	pmProcessorSpeedChanged		= 8;
	pmWakeupTimerChanged		= 9;
	pmStartupTimerChanged		= 10;
	pmHardDiskPowerRemovedbyUser = 11;
	pmChargeStatusChanged		= 12;
	pmPowerLevelChanged			= 13;
	pmWakeOnNetActivityChanged	= 14;

	pmSleepTimeoutChangedMask	= $01;
	pmSleepEnableChangedMask	= $02;
	pmHardDiskTimeoutChangedMask = $04;
	pmHardDiskSpindownChangedMask = $08;
	pmDimmingTimeoutChangedMask	= $10;
	pmDimmingEnableChangedMask	= $20;
	pmDiskModeAddressChangedMask = $40;
	pmProcessorCyclingChangedMask = $80;
	pmProcessorSpeedChangedMask	= $0100;
	pmWakeupTimerChangedMask	= $0200;
	pmStartupTimerChangedMask	= $0400;
	pmHardDiskPowerRemovedbyUserMask = $0800;
	pmChargeStatusChangedMask	= $1000;
	pmPowerLevelChangedMask		= $2000;
	pmWakeOnNetActivityChangedMask = $4000;

	{	 System Activity Selectors 	}
	OverallAct					= 0;							{  general type of activity                 }
	UsrActivity					= 1;							{  user specific type of activity            }
	NetActivity					= 2;							{  network specific activity              }
	HDActivity					= 3;							{  Hard Drive activity                     }

	{	 Storage Media sleep mode defines 	}
	kMediaModeOn				= 0;							{  Media active (Drive spinning and at full power)     }
	kMediaModeStandBy			= 1;							{  Media standby (not implemented)     }
	kMediaModeSuspend			= 2;							{  Media Idle (not implemented)    }
	kMediaModeOff				= 3;							{  Media Sleep (Drive not spinning and at min power, max recovery time)    }

	kMediaPowerCSCode			= 70;


	{	 definitions for HDQueueElement.hdFlags   	}
	kHDQueuePostBit				= 0;							{  1 = call this routine on the second pass      }
	kHDQueuePostMask			= $01;


TYPE
	ActivityInfoPtr = ^ActivityInfo;
	ActivityInfo = RECORD
		ActivityType:			INTEGER;								{  Type of activity to be fetched.  Same as UpdateSystemActivity Selectors  }
		ActivityTime:			UInt32;									{  Time of last activity (in ticks) of specified type.  }
	END;

	{	 information returned by GetScaledBatteryInfo 	}
	BatteryInfoPtr = ^BatteryInfo;
	BatteryInfo = PACKED RECORD
		flags:					UInt8;									{  misc flags (see below)                   }
		warningLevel:			UInt8;									{  scaled warning level (0-255)                }
		reserved:				UInt8;									{  reserved for internal use              }
		batteryLevel:			UInt8;									{  scaled battery level (0-255)                }
	END;

	ModemByte							= SInt8;
	BatteryByte							= SInt8;
	SoundMixerByte						= SInt8;
	PMResultCode						= LONGINT;
	SleepQRecPtr = ^SleepQRec;
	HDQueueElementPtr = ^HDQueueElement;
	PMgrQueueElementPtr = ^PMgrQueueElement;
{$IFC TYPED_FUNCTION_POINTERS}
	SleepQProcPtr = FUNCTION(message: LONGINT; qRecPtr: SleepQRecPtr): LONGINT;
{$ELSEC}
	SleepQProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	HDSpindownProcPtr = PROCEDURE(theElement: HDQueueElementPtr);
{$ELSEC}
	HDSpindownProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PMgrStateChangeProcPtr = PROCEDURE(theElement: PMgrQueueElementPtr; stateBits: LONGINT);
{$ELSEC}
	PMgrStateChangeProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	SleepQUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SleepQUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	HDSpindownUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	HDSpindownUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PMgrStateChangeUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PMgrStateChangeUPP = UniversalProcPtr;
{$ENDC}	
	SleepQRec = RECORD
		sleepQLink:				SleepQRecPtr;							{  pointer to next queue element           }
		sleepQType:				INTEGER;								{  queue element type (must be SleepQType)        }
		sleepQProc:				SleepQUPP;								{  pointer to sleep universal proc ptr          }
		sleepQFlags:			INTEGER;								{  flags                        }
	END;

	HDQueueElement = RECORD
		hdQLink:				HDQueueElementPtr;						{  pointer to next queue element           }
		hdQType:				INTEGER;								{  queue element type (must be HDPwrQType)        }
		hdFlags:				INTEGER;								{  miscellaneous flags                    }
		hdProc:					HDSpindownUPP;							{  pointer to routine to call            }
		hdUser:					LONGINT;								{  user-defined (variable storage, etc.)    }
	END;

	PMgrQueueElement = RECORD
		pmQLink:				PMgrQueueElementPtr;					{  pointer to next queue element           }
		pmQType:				INTEGER;								{  queue element type (must be PMgrStateQType)     }
		pmFlags:				INTEGER;								{  miscellaneous flags                    }
		pmNotifyBits:			LONGINT;								{  bitmap of which changes to be notified for  }
		pmProc:					PMgrStateChangeUPP;						{  pointer to routine to call            }
		pmUser:					LONGINT;								{  user-defined (variable storage, etc.)    }
	END;


	BatteryTimeRecPtr = ^BatteryTimeRec;
	BatteryTimeRec = RECORD
		expectedBatteryTime:	UInt32;									{  estimated battery time remaining (seconds)  }
		minimumBatteryTime:		UInt32;									{  minimum battery time remaining (seconds)      }
		maximumBatteryTime:		UInt32;									{  maximum battery time remaining (seconds)      }
		timeUntilCharged:		UInt32;									{  time until battery is fully charged (seconds) }
	END;


	WakeupTimePtr = ^WakeupTime;
	WakeupTime = RECORD
		wakeTime:				UInt32;									{  wakeup time (same format as current time)    }
		wakeEnabled:			BOOLEAN;								{  1=enable wakeup timer, 0=disable wakeup timer   }
		filler:					SInt8;
	END;


	StartupTimePtr = ^StartupTime;
	StartupTime = RECORD
		startTime:				UInt32;									{  startup time (same format as current time)      }
		startEnabled:			BOOLEAN;								{  1=enable startup timer, 0=disable startup timer     }
		filler:					SInt8;
	END;

	{  PowerSource version }

CONST
	kVersionOnePowerSource		= 1;
	kVersionTwoPowerSource		= 2;
	kCurrentPowerSourceVersion	= 2;

	{  PowerSourceAttrs bits }

	bSourceIsBattery			= 0;							{  power source is battery }
	bSourceIsAC					= 1;							{  power source is AC }
	bSourceCanBeCharged			= 2;							{  power source can be charged }
	bSourceIsUPS				= 3;							{  power source is UPS. NOTE: software should set bSourceIsBattery and bSourceIsAC also, as appropriate }
	bSourceProvidesWarnLevels	= 4;							{  power source provides low power and dead battery warning levels }
	kSourceIsBatteryMask		= $01;
	kSourceIsACMask				= $02;
	kSourceCanBeChargedMask		= $04;
	kSourceIsUPSMask			= $08;
	kSourceProvidesWarnLevelsMask = $10;

	{  PowerSourceFlags bits }

	bSourceIsAvailable			= 0;							{  power source is installed }
	bSourceIsCharging			= 1;							{  power source being charged }
	bChargerIsAttached			= 2;							{  a charger is connected }
	kSourceIsAvailableMask		= $01;
	kSourceIsChargingMask		= $02;
	kChargerIsAttachedMask		= $04;

	{  Power Capacity Types }

	kCapacityIsActual			= 0;							{  current capacity is expessed as actual capacity in same units as max }
	kCapacityIsPercentOfMax		= 1;							{  current capacity is expressed as a percentage of maximumCapacity }

	{  Net Activity Wake Options }
	kConfigSupportsWakeOnNetBit	= 0;
	kWakeOnNetAdminAccessesBit	= 1;
	kWakeOnAllNetAccessesBit	= 2;
	kUnmountServersBeforeSleepingBit = 3;
	kConfigSupportsWakeOnNetMask = $01;
	kWakeOnNetAdminAccessesMask	= $02;
	kWakeOnAllNetAccessesMask	= $04;
	kUnmountServersBeforeSleepingMask = $08;

	{  Power Source capacity usage types }
	kCurrentCapacityIsActualValue = 0;							{  currentCapacity is a real value in same units as maxCapacity }
	kCurrentCapacityIsPercentOfMax = 1;							{  currentCapacity is expressed as a percentage of maxCapacity. }


TYPE
	PowerSourceID						= SInt16;
	PowerSourceParamBlockPtr = ^PowerSourceParamBlock;
	PowerSourceParamBlock = RECORD
		sourceID:				PowerSourceID;							{  unique id assigned by Power Mgr }
		sourceCapacityUsage:	UInt16;									{  how currentCapacity is used }
		sourceVersion:			UInt32;									{  version of this record }
		sourceAttr:				OptionBits;								{  attribute flags (see below) }
		sourceState:			OptionBits;								{  state flags (see below) }
		currentCapacity:		UInt32;									{  current capacity, in }
																		{    milliwatts or % }
		maxCapacity:			UInt32;									{  full capacity, in milliwatts }
		timeRemaining:			UInt32;									{  time left to deplete,  }
																		{    in milliwatt-hours }
		timeToFullCharge:		UInt32;									{  time to charge,  }
																		{    in milliwatt-hours }
		voltage:				UInt32;									{  voltage in millivolts }
		current:				SInt32;									{  current in milliamperes  }
																		{   (negative if consuming,  }
																		{    positive if charging) }
		lowWarnLevel:			UInt32;									{  low warning level in milliwatts (or % if sourceCapacityUsage is %) }
		deadWarnLevel:			UInt32;									{  dead warning level in milliwatts (or % if sourceCapacityUsage is %) }
		reserved:				ARRAY [0..15] OF UInt32;				{  for future expansion }
	END;

	{
	 *  DisableWUTime()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION DisableWUTime: OSErr;

{
 *  SetWUTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWUTime(wuTime: LONGINT): OSErr;

{$IFC CALL_NOT_IN_CARBON }
{
 *  GetWUTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetWUTime(VAR wuTime: LONGINT; VAR wuFlag: SignedByte): OSErr;

{
 *  BatteryStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION BatteryStatus(VAR status: SignedByte; VAR power: SignedByte): OSErr;

{
 *  ModemStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ModemStatus(VAR status: SignedByte): OSErr;

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  IdleUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IdleUpdate: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A285, $2E80;
	{$ENDC}

{
 *  GetCPUSpeed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCPUSpeed: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $70FF, $A485, $2E80;
	{$ENDC}

{
 *  EnableIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE EnableIdle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $A485;
	{$ENDC}

{
 *  DisableIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisableIdle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $A485;
	{$ENDC}

{
 *  SleepQInstall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SleepQInstall(qRecPtr: SleepQRecPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A28A;
	{$ENDC}

{
 *  SleepQRemove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SleepQRemove(qRecPtr: SleepQRecPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A48A;
	{$ENDC}

{
 *  AOn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE AOn;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $A685;
	{$ENDC}

{
 *  AOnIgnoreModem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE AOnIgnoreModem;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $A685;
	{$ENDC}

{
 *  BOn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE BOn;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $A685;
	{$ENDC}

{
 *  AOff()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE AOff;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7084, $A685;
	{$ENDC}

{
 *  BOff()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE BOff;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7080, $A685;
	{$ENDC}


{ Public Power Management API  }
{
 *  PMSelectorCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMSelectorCount: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7000, $A09E, $3E80;
	{$ENDC}

{
 *  PMFeatures()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMFeatures: UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $A09E, $2E80;
	{$ENDC}

{
 *  GetSleepTimeout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetSleepTimeout: ByteParameter;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $A09E, $1E80;
	{$ENDC}

{
 *  SetSleepTimeout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetSleepTimeout(timeout: ByteParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $0003, $A09E;
	{$ENDC}

{
 *  GetHardDiskTimeout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetHardDiskTimeout: ByteParameter;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $A09E, $1E80;
	{$ENDC}

{
 *  SetHardDiskTimeout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetHardDiskTimeout(timeout: ByteParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $0005, $A09E;
	{$ENDC}

{
 *  HardDiskPowered()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HardDiskPowered: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $A09E, $1E80;
	{$ENDC}

{
 *  SpinDownHardDisk()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SpinDownHardDisk;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $A09E;
	{$ENDC}

{
 *  IsSpindownDisabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsSpindownDisabled: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $A09E, $1E80;
	{$ENDC}

{
 *  SetSpindownDisable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetSpindownDisable(setDisable: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $0009, $A09E;
	{$ENDC}

{
 *  HardDiskQInstall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HardDiskQInstall(VAR theElement: HDQueueElement): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $700A, $A09E, $3E80;
	{$ENDC}

{
 *  HardDiskQRemove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HardDiskQRemove(VAR theElement: HDQueueElement): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $700B, $A09E, $3E80;
	{$ENDC}

{
 *  GetScaledBatteryInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetScaledBatteryInfo(whichBattery: INTEGER; VAR theInfo: BatteryInfo);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $301F, $4840, $303C, $000C, $A09E, $2080;
	{$ENDC}

{
 *  AutoSleepControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE AutoSleepControl(enableSleep: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $000D, $A09E;
	{$ENDC}

{
 *  GetIntModemInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIntModemInfo: UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $A09E, $2E80;
	{$ENDC}

{
 *  SetIntModemState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetIntModemState(theState: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $4840, $303C, $000F, $A09E;
	{$ENDC}

{
 *  MaximumProcessorSpeed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MaximumProcessorSpeed: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $A09E, $3E80;
	{$ENDC}

{
 *  MinimumProcessorSpeed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MinimumProcessorSpeed: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7036, $A09E, $3E80;
	{$ENDC}

{
 *  CurrentProcessorSpeed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CurrentProcessorSpeed: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $A09E, $3E80;
	{$ENDC}

{
 *  FullProcessorSpeed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FullProcessorSpeed: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $A09E, $1E80;
	{$ENDC}

{
 *  SetProcessorSpeed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetProcessorSpeed(fullSpeed: BOOLEAN): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $0013, $A09E, $1E80;
	{$ENDC}

{
 *  GetSCSIDiskModeAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetSCSIDiskModeAddress: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $A09E, $3E80;
	{$ENDC}

{
 *  SetSCSIDiskModeAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetSCSIDiskModeAddress(scsiAddress: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $4840, $303C, $0015, $A09E;
	{$ENDC}

{
 *  GetWakeupTimer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetWakeupTimer(VAR theTime: WakeupTime);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7016, $A09E;
	{$ENDC}

{
 *  SetWakeupTimer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetWakeupTimer(VAR theTime: WakeupTime);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7017, $A09E;
	{$ENDC}

{
 *  IsProcessorCyclingEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsProcessorCyclingEnabled: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7018, $A09E, $1E80;
	{$ENDC}

{
 *  EnableProcessorCycling()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE EnableProcessorCycling(enable: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $0019, $A09E;
	{$ENDC}

{
 *  BatteryCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BatteryCount: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701A, $A09E, $3E80;
	{$ENDC}

{
 *  GetBatteryVoltage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetBatteryVoltage(whichBattery: INTEGER): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $4840, $303C, $001B, $A09E, $2E80;
	{$ENDC}

{
 *  GetBatteryTimes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetBatteryTimes(whichBattery: INTEGER; VAR theTimes: BatteryTimeRec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $301F, $4840, $303C, $001C, $A09E;
	{$ENDC}

{
 *  GetDimmingTimeout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDimmingTimeout: ByteParameter;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701D, $A09E, $1E80;
	{$ENDC}

{
 *  SetDimmingTimeout()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetDimmingTimeout(timeout: ByteParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $001E, $A09E;
	{$ENDC}

{
 *  DimmingControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DimmingControl(enableSleep: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $001F, $A09E;
	{$ENDC}

{
 *  IsDimmingControlDisabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsDimmingControlDisabled: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7020, $A09E, $1E80;
	{$ENDC}

{
 *  IsAutoSlpControlDisabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsAutoSlpControlDisabled: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7021, $A09E, $1E80;
	{$ENDC}

{
 *  PMgrStateQInstall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMgrStateQInstall(VAR theElement: PMgrQueueElement): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7022, $A09E, $3E80;
	{$ENDC}

{
 *  PMgrStateQRemove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PMgrStateQRemove(VAR theElement: PMgrQueueElement): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7023, $A09E, $3E80;
	{$ENDC}

{
 *  UpdateSystemActivity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UpdateSystemActivity(activity: ByteParameter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $0024, $A09E, $3E80;
	{$ENDC}

{
 *  DelaySystemIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DelaySystemIdle: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7025, $A09E, $3E80;
	{$ENDC}

{
 *  GetStartupTimer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetStartupTimer(VAR theTime: StartupTime): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7026, $A09E, $3E80;
	{$ENDC}

{
 *  SetStartupTimer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetStartupTimer(VAR theTime: StartupTime): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7027, $A09E, $3E80;
	{$ENDC}

{
 *  GetLastActivity()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetLastActivity(VAR theActivity: ActivityInfo): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7028, $A09E, $3E80;
	{$ENDC}

{
 *  GetSoundMixerState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetSoundMixerState(VAR theSoundMixerByte: SoundMixerByte): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7029, $A09E, $3E80;
	{$ENDC}

{
 *  SetSoundMixerState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetSoundMixerState(VAR theSoundMixerByte: SoundMixerByte): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702A, $A09E, $3E80;
	{$ENDC}

{
 *  GetDimSuspendState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDimSuspendState: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702B, $A09E, $1E80;
	{$ENDC}

{
 *  SetDimSuspendState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetDimSuspendState(dimSuspendState: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $002C, $A09E;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  GetCoreProcessorTemperature()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetCoreProcessorTemperature(inCpuID: MPCpuID): SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702D, $A09E, $2E80;
	{$ENDC}

{
 *  GetWakeOnNetworkOptions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetWakeOnNetworkOptions: OptionBits;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702E, $A09E, $2E80;
	{$ENDC}

{
 *  SetWakeOnNetworkOptions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetWakeOnNetworkOptions(inOptions: OptionBits);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $702F, $A09E;
	{$ENDC}

{
 *  AddPowerSource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AddPowerSource(VAR ioPowerSource: PowerSourceParamBlock): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7030, $A09E, $2E80;
	{$ENDC}

{
 *  RemovePowerSource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RemovePowerSource(inSourceID: PowerSourceID): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $4840, $303C, $0031, $A09E, $2E80;
	{$ENDC}

{
 *  UpdatePowerSource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UpdatePowerSource(VAR ioSource: PowerSourceParamBlock): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $7032, $A09E, $2E80;
	{$ENDC}

{
 *  IsServerModeEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IsServerModeEnabled: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7033, $A09E, $1E80;
	{$ENDC}

{
 *  EnableServerMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE EnableServerMode(inEnable: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $101F, $4840, $303C, $0034, $A09E;
	{$ENDC}

{ 
   NumBatteriesInstalled is different from BatteryCount in that it
   indicates how many batteries are actually available at the time
   it is called (including UPS batteries). BatteryCount shows a 
   static number of batteries a machine is capable of holding which does NOT
   include UPS batteries. So, while a desktop might show a BatteryCount
   of zero, its NumBatteriesInstalled value might be 1 or more if a UPS
   is attached. 
}
{
 *  NumBatteriesInstalled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in PowerMgrLib 2.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NumBatteriesInstalled: UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7035, $A09E, $2E80;
	{$ENDC}

{ Power Handler Management }
{
 *  IsPCIPowerOffDisabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DriverServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION IsPCIPowerOffDisabled: BOOLEAN; C;

{
 *  EnablePCIPowerOff()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DriverServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE EnablePCIPowerOff(inEnable: BOOLEAN); C;

{
 *  AddDevicePowerHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DriverServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AddDevicePowerHandler(regEntryID: RegEntryIDPtr; handler: PowerHandlerProcPtr; refCon: UInt32; deviceType: CStringPtr): OSStatus; C;

{
 *  RemoveDevicePowerHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DriverServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RemoveDevicePowerHandler(regEntryID: RegEntryIDPtr): OSStatus; C;

{
 *  RemoveDevicePowerHandlerForProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DriverServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION RemoveDevicePowerHandlerForProc(proc: PowerHandlerProcPtr): OSStatus; C;

{
 *  GetDevicePowerLevel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DriverServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetDevicePowerLevel(regEntryID: RegEntryIDPtr; VAR devicePowerLevel: PowerLevel): OSStatus; C;

{
 *  SetDevicePowerLevel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DriverServicesLib 1.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetDevicePowerLevel(regEntryID: RegEntryIDPtr; devicePowerLevel: PowerLevel): OSStatus; C;


{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	uppSleepQProcInfo = $00131832;
	uppHDSpindownProcInfo = $000000C0;
	uppPMgrStateChangeProcInfo = $000003C0;
	{
	 *  NewSleepQUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewSleepQUPP(userRoutine: SleepQProcPtr): SleepQUPP; { old name was NewSleepQProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewHDSpindownUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewHDSpindownUPP(userRoutine: HDSpindownProcPtr): HDSpindownUPP; { old name was NewHDSpindownProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPMgrStateChangeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewPMgrStateChangeUPP(userRoutine: PMgrStateChangeProcPtr): PMgrStateChangeUPP; { old name was NewPMgrStateChangeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeSleepQUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSleepQUPP(userUPP: SleepQUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeHDSpindownUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeHDSpindownUPP(userUPP: HDSpindownUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePMgrStateChangeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposePMgrStateChangeUPP(userUPP: PMgrStateChangeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeSleepQUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSleepQUPP(message: LONGINT; qRecPtr: SleepQRecPtr; userRoutine: SleepQUPP): LONGINT; { old name was CallSleepQProc }
{
 *  InvokeHDSpindownUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeHDSpindownUPP(theElement: HDQueueElementPtr; userRoutine: HDSpindownUPP); { old name was CallHDSpindownProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePMgrStateChangeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokePMgrStateChangeUPP(theElement: PMgrQueueElementPtr; stateBits: LONGINT; userRoutine: PMgrStateChangeUPP); { old name was CallPMgrStateChangeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := PowerIncludes}

{$ENDC} {__POWER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

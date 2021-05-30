{
Created: Thursday, September 28, 1989 at 12:17 PM
	Power.p
	Pascal Interface to the Macintosh Libraries

	Copyright Apple Computer, Inc.	1989
	All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT Power;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingPower}
{$SETC UsingPower := 1}

{$I+}
{$SETC PowerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$SETC UsingIncludes := PowerIncludes}

CONST

{ PMgrResultCode values
 }

pmBusyErr = -13000; 		{ PMgr stuck busy }
pmReplyTOErr = -13001;		{ Timed out waiting to begin reply handshake }
pmSendStartErr = -13002;	{ PMgr did not start handshake }
pmSendEndErr = -13003;		{ During send, PMgr did not finish handshake }
pmRecvStartErr = -13004;	{ During receive, PMgr did not start handshake }
pmRecvEndErr = -13005;		{ During receive, PMgr did not finish handshake }

{ bit positions for PowerClockByte
 }

pmSCCBit = 1;				{SCC clock}
pmModemBit = 3; 			{Internal modem power}
pmSerialBit = 4;			{Serial drivers power}
pmVoltBit = 6;				{-5 volt power}
pmDevEnableBit = 7;

{ Masks for PowerClockByte }

pmSCCMask = $2;
pmModemMask = $8;
pmSerialMask = $10;
pmVoltMask = $40;
pmDevEnableMask = $80;

{ Bit positions for ModemByte
 }

modemOnBit = 0;
ringWakeUpBit = 2;
modemInstalledBit = 3;
ringDetectBit = 4;
modemOnHookBit = 5;

{ masks for ModemByte }

modemOnMask = $1;
ringWakeUpMask = $4;
modemInstalledMask = $8;
ringDetectMask = $10;
modemOnHookMask = $20;

{ bit positions for BatteryByte }

chargerConnBit = 0;
hiChargeBit = 1;
chargeOverFlowBit = 2;
batteryDeadBit = 3;
batteryLowBit = 4;
connChangedBit = 5;

{ masks for BatteryByte }

chargerConnMask = $1;
hiChargeMask = $2;
chargeOverFlowMask = $4;
batteryDeadMask = $8;
batteryLowMask = $10;
connChangedMask = $20;

{ Commands for PMOp function }

powerCntl = $10;			{ Power/clock control }
powerRead = $18;			{ Power/clock control }
modemRead = $58;			{ Internal modem setup }
batteryRead = $68;			{ Battery/charger level and status }
setWakeUp = $80;			{ Set Wake-up timer }
disableWakeUp = $82;		{ Disable Wake-up timer }
readWakeUp = $88;			{ Read Wake-up timer }

{ SleepQRec.sleepQFlags
 }

noCalls = 1;
noRequest = 2;


TYPE

{ Data bytes types for use in transmit and receive buffers }
PowerClockByte = Byte;
ModemByte = Byte;
BatteryByte = Byte;

PMResultCode = LongInt;


PMParamBlockPtr = ^PMParamBlock;
PMParamBlock = RECORD
	pmCommand: INTEGER;
	pmCount: INTEGER;
	pmSendBuff: Ptr;
	pmReceiveBuff: Ptr;
	END;

SleepQRecPtr = ^SleepQRec;
SleepQRec = RECORD
	sleepQLink: SleepQRecPtr;
	sleepQType: INTEGER;	{type = 16}
	sleepQProc: ProcPtr;	{Pointer to sleep routine}
	sleepQFlags: INTEGER;
	END;



FUNCTION PMOp(pBlockPtr: PMParamBlockPtr): PMResultCode;
	INLINE $205F,$A085,$2E80;
FUNCTION IdleUpdate: LONGINT;
	INLINE $A285,$2E80;
FUNCTION GetCPUSpeed: LONGINT;
	INLINE $70FF,$A485,$2E80;
PROCEDURE EnableIdle;
	INLINE $7000,$A485;
PROCEDURE DisableIdle;
	INLINE $7001,$A485;
PROCEDURE SleepQInstall(qRecPtr: SleepQRecPtr);
	INLINE $205F,$A28A;
PROCEDURE SleepQRemove(qRecPtr: SleepQRecPtr);
	INLINE $205F,$A48A;
PROCEDURE AOn;
	INLINE $7004,$A685;
PROCEDURE AOnIgnoreModem;
	INLINE $7005,$A685;
PROCEDURE BOn;
	INLINE $7000,$A685;
PROCEDURE BOnIgnoreModem;
	INLINE $7001,$A685;
PROCEDURE AOff;
	INLINE $7084,$A685;
PROCEDURE BOff;
	INLINE $7080,$A685;

{$ENDC}    { UsingPower }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}


{
 	File:		OSUtils.p
 
 	Contains:	OS Utilities Interfaces.
 
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
 UNIT OSUtils;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __OSUTILS__}
{$SETC __OSUTILS__ := 1}

{$I+}
{$SETC OSUtilsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$IFC UNDEFINED __MEMORY__}
{$I Memory.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	useFree						= 0;
	useATalk					= 1;
	useAsync					= 2;
	useExtClk					= 3;							{Externally clocked}
	useMIDI						= 4;
{ Environs Equates }
	curSysEnvVers				= 2;							{Updated to equal latest SysEnvirons version}
{ Machine Types }
	envMac						= -1;
	envXL						= -2;
	envMachUnknown				= 0;
	env512KE					= 1;
	envMacPlus					= 2;
	envSE						= 3;
	envMacII					= 4;
	envMacIIx					= 5;
	envMacIIcx					= 6;
	envSE30						= 7;
	envPortable					= 8;
	envMacIIci					= 9;
	envMacIIfx					= 11;
{ CPU types }
	envCPUUnknown				= 0;

	env68000					= 1;
	env68010					= 2;
	env68020					= 3;
	env68030					= 4;
	env68040					= 5;
{ Keyboard types }
	envUnknownKbd				= 0;
	envMacKbd					= 1;
	envMacAndPad				= 2;
	envMacPlusKbd				= 3;
	envAExtendKbd				= 4;
	envStandADBKbd				= 5;
	envPrtblADBKbd				= 6;
	envPrtblISOKbd				= 7;
	envStdISOADBKbd				= 8;
	envExtISOADBKbd				= 9;
	false32b					= 0;							{24 bit addressing error}
	true32b						= 1;							{32 bit addressing error}
{ result types for RelString Call }
	sortsBefore					= -1;							{first string < second string}
	sortsEqual					= 0;							{first string = second string}
	sortsAfter					= 1;							{first string > second string}

{ Toggle results }
	toggleUndefined				= 0;
	toggleOK					= 1;
	toggleBadField				= 2;
	toggleBadDelta				= 3;
	toggleBadChar				= 4;
	toggleUnknown				= 5;
	toggleBadNum				= 6;
	toggleOutOfRange			= 7;							{synonym for toggleErr3}
	toggleErr3					= 7;
	toggleErr4					= 8;
	toggleErr5					= 9;
{ Date equates }
	smallDateBit				= 31;							{Restrict valid date/time to range of Time global}
	togChar12HourBit			= 30;							{If toggling hour by char, accept hours 1..12 only}
	togCharZCycleBit			= 29;							{Modifier for togChar12HourBit: accept hours 0..11 only}
	togDelta12HourBit			= 28;							{If toggling hour up/down, restrict to 12-hour range (am/pm)}
	genCdevRangeBit				= 27;							{Restrict date/time to range used by genl CDEV}
	validDateFields				= -1;
	maxDateField				= 10;
	eraMask						= $0001;
	yearMask					= $0002;
	monthMask					= $0004;
	dayMask						= $0008;
	hourMask					= $0010;
	minuteMask					= $0020;
	secondMask					= $0040;
	dayOfWeekMask				= $0080;
	dayOfYearMask				= $0100;
	weekOfYearMask				= $0200;
	pmMask						= $0400;
	dateStdMask					= $007F;						{default for ValidDate flags and ToggleDate TogglePB.togFlags}

	eraField					= 0;
	yearField					= 1;
	monthField					= 2;
	dayField					= 3;
	hourField					= 4;
	minuteField					= 5;
	secondField					= 6;
	dayOfWeekField				= 7;
	dayOfYearField				= 8;
	weekOfYearField				= 9;
	pmField						= 10;
	res1Field					= 11;
	res2Field					= 12;
	res3Field					= 13;

	
TYPE
	LongDateField = SignedByte;


CONST
	dummyType					= 0;
	vType						= 1;
	ioQType						= 2;
	drvQType					= 3;
	evType						= 4;
	fsQType						= 5;
	sIQType						= 6;
	dtQType						= 7;
	nmType						= 8;

	
TYPE
	QTypes = SignedByte;


CONST
	OSTrap						= 0;
	ToolTrap					= 1;

	
TYPE
	TrapType = SignedByte;

	SysParmType = PACKED RECORD
		valid:					UInt8;
		aTalkA:					UInt8;
		aTalkB:					UInt8;
		config:					UInt8;
		portA:					INTEGER;
		portB:					INTEGER;
		alarm:					LONGINT;
		font:					INTEGER;
		kbdPrint:				INTEGER;
		volClik:				INTEGER;
		misc:					INTEGER;
	END;

	SysPPtr = ^SysParmType;

	QElemPtr = ^QElem;

	QElem = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		qData:					ARRAY [0..0] OF INTEGER;
	END;

	QHdrPtr = ^QHdr;

	QHdr = RECORD
		qFlags:					INTEGER;
		qHead:					QElemPtr;
		qTail:					QElemPtr;
	END;

	{
		DeferredTaskProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => dtParam     	A1.L
	}
	DeferredTaskProcPtr = Register68kProcPtr;  { register PROCEDURE DeferredTask(dtParam: LONGINT); }
	DeferredTaskUPP = UniversalProcPtr;

	DeferredTask = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		dtFlags:				INTEGER;
		dtAddr:					DeferredTaskUPP;
		dtParam:				LONGINT;
		dtReserved:				LONGINT;
	END;

	DeferredTaskPtr = ^DeferredTask;

	SysEnvRec = RECORD
		environsVersion:		INTEGER;
		machineType:			INTEGER;
		systemVersion:			INTEGER;
		processor:				INTEGER;
		hasFPU:					BOOLEAN;
		hasColorQD:				BOOLEAN;
		keyBoardType:			INTEGER;
		atDrvrVersNum:			INTEGER;
		sysVRefNum:				INTEGER;
	END;

	MachineLocation = RECORD
		latitude:				Fract;
		longitude:				Fract;
		CASE INTEGER OF
		0: (
			dlsDelta:					SInt8;								{signed byte; daylight savings delta}
		   );
		1: (
			gmtDelta:					LONGINT;							{must mask - see documentation}
		   );
	END;

	DateTimeRec = RECORD
		year:					INTEGER;
		month:					INTEGER;
		day:					INTEGER;
		hour:					INTEGER;
		minute:					INTEGER;
		second:					INTEGER;
		dayOfWeek:				INTEGER;
	END;

	LongDateTime = wide;

	LongDateCvt = RECORD
		CASE INTEGER OF
		0: (
			c:							wide;
		   );
		1: (
			lHigh:						UInt32;
			lLow:						UInt32;
		   );
	END;

	LongDateRec = RECORD
		CASE INTEGER OF
		0: (
			era:						INTEGER;
			year:						INTEGER;
			month:						INTEGER;
			day:						INTEGER;
			hour:						INTEGER;
			minute:						INTEGER;
			second:						INTEGER;
			dayOfWeek:					INTEGER;
			dayOfYear:					INTEGER;
			weekOfYear:					INTEGER;
			pm:							INTEGER;
			res1:						INTEGER;
			res2:						INTEGER;
			res3:						INTEGER;
		   );
		1: (
			list:						ARRAY [0..13] OF INTEGER;			{Index by LongDateField!}
		   );
		2: (
			eraAlt:						INTEGER;
			oldDate:					DateTimeRec;
		   );
	END;

	DateDelta = SInt8;

	TogglePB = RECORD
		togFlags:				LONGINT;								{caller normally sets low word to dateStdMask=$7F}
		amChars:				ResType;								{from 'itl0', but uppercased}
		pmChars:				ResType;								{from 'itl0', but uppercased}
		reserved:				ARRAY [0..3] OF LONGINT;
	END;

	ToggleResults = INTEGER;

CONST
	uppDeferredTaskProcInfo = $0000B802; { Register PROCEDURE (4 bytes in A1); }

FUNCTION NewDeferredTaskProc(userRoutine: DeferredTaskProcPtr): DeferredTaskUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallDeferredTaskProc(dtParam: LONGINT; userRoutine: DeferredTaskUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE LongDateToSeconds({CONST}VAR lDate: LongDateRec; VAR lSecs: LongDateTime);
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8008, $FFF2, $A8B5;
	{$ENDC}
PROCEDURE LongSecondsToDate(VAR lSecs: LongDateTime; VAR lDate: LongDateRec);
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8008, $FFF0, $A8B5;
	{$ENDC}
FUNCTION ToggleDate(VAR lSecs: LongDateTime; field: ByteParameter; delta: ByteParameter; ch: INTEGER; {CONST}VAR params: TogglePB): ToggleResults;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $820E, $FFEE, $A8B5;
	{$ENDC}
FUNCTION ValidDate({CONST}VAR vDate: LongDateRec; flags: LONGINT; VAR newSecs: LongDateTime): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $820C, $FFE4, $A8B5;
	{$ENDC}
FUNCTION IsMetric: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0004, $A9ED;
	{$ENDC}
FUNCTION GetSysPPtr: SysPPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $2EBC, $0000, $01F8;
	{$ENDC}
FUNCTION ReadDateTime(VAR time: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A039, $3E80;
	{$ENDC}
PROCEDURE GetDateTime(VAR secs: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $20B8, $020C;
	{$ENDC}
FUNCTION SetDateTime(time: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $A03A, $3E80;
	{$ENDC}
PROCEDURE SetTime({CONST}VAR d: DateTimeRec);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A9C7, $A03A;
	{$ENDC}
PROCEDURE GetTime(VAR d: DateTimeRec);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $2038, $020C, $A9C6;
	{$ENDC}
PROCEDURE DateToSeconds({CONST}VAR d: DateTimeRec; VAR secs: LONGINT);
PROCEDURE SecondsToDate(secs: LONGINT; VAR d: DateTimeRec);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $201F, $A9C6;
	{$ENDC}
PROCEDURE SysBeep(duration: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A9C8;
	{$ENDC}
FUNCTION DTInstall(dtTaskPtr: DeferredTaskPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A082, $3E80;
	{$ENDC}
FUNCTION GetMMUMode : ByteParameter;
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $1EB8, $0CB2;			{ MOVE.b $0CB2,(SP) }
	{$ENDC}

PROCEDURE SwapMMUMode(VAR mode: SInt8);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $1010, $A05D, $1080;
	{$ENDC}
{$IFC SystemSixOrLater }
FUNCTION SysEnvirons(versionRequested: INTEGER; VAR theWorld: SysEnvRec): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $301F, $A090, $3E80;
	{$ENDC}
{$ELSEC}
FUNCTION SysEnvirons(versionRequested: INTEGER; VAR theWorld: SysEnvRec): OSErr;
{$ENDC}
PROCEDURE Delay(numTicks: LONGINT; VAR finalTicks: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $205F, $A03B, $2280;
	{$ENDC}
{$IFC OLDROUTINENAMES  & NOT GENERATINGCFM }
FUNCTION GetTrapAddress(trapNum: INTEGER): UniversalProcPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $A146, $2E88;
	{$ENDC}
PROCEDURE SetTrapAddress(trapAddr: UniversalProcPtr; trapNum: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $205F, $A047;
	{$ENDC}
{$ENDC}
FUNCTION NGetTrapAddress(trapNum: INTEGER; tTyp: ByteParameter): UniversalProcPtr;
PROCEDURE NSetTrapAddress(trapAddr: UniversalProcPtr; trapNum: INTEGER; tTyp: ByteParameter);
FUNCTION GetOSTrapAddress(trapNum: INTEGER): UniversalProcPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $A346, $2E88;
	{$ENDC}
PROCEDURE SetOSTrapAddress(trapAddr: UniversalProcPtr; trapNum: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $205F, $A247;
	{$ENDC}
FUNCTION GetToolTrapAddress(trapNum: INTEGER): UniversalProcPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $A746, $2E88;
	{$ENDC}
PROCEDURE SetToolTrapAddress(trapAddr: UniversalProcPtr; trapNum: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $205F, $A647;
	{$ENDC}
FUNCTION GetToolboxTrapAddress(trapNum: INTEGER): UniversalProcPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $A746, $2E88;
	{$ENDC}
PROCEDURE SetToolboxTrapAddress(trapAddr: UniversalProcPtr; trapNum: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $205F, $A647;
	{$ENDC}
FUNCTION WriteParam: OSErr;
PROCEDURE Enqueue(qElement: QElemPtr; qHeader: QHdrPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $205F, $A96F;
	{$ENDC}
FUNCTION Dequeue(qElement: QElemPtr; qHeader: QHdrPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $205F, $A96E, $3E80;
	{$ENDC}
FUNCTION SetCurrentA5: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $2E8D, $2A78, $0904;
	{$ENDC}
FUNCTION SetA5(newA5: LONGINT): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F4D, $0004, $2A5F;
	{$ENDC}
{$IFC NOT SystemSevenOrLater }
PROCEDURE Environs(VAR rom: INTEGER; VAR machine: INTEGER);
{$ENDC}
FUNCTION InitUtil: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $A03F, $3E80;
	{$ENDC}
{$IFC GENERATINGPOWERPC }
PROCEDURE MakeDataExecutable(baseAddress: UNIV Ptr; length: LONGINT);
{$ENDC}
{$IFC GENERATING68K }
FUNCTION SwapInstructionCache(cacheEnable: BOOLEAN): BOOLEAN;
PROCEDURE FlushInstructionCache;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $A098;
	{$ENDC}
FUNCTION SwapDataCache(cacheEnable: BOOLEAN): BOOLEAN;
PROCEDURE FlushDataCache;
	{$IFC NOT GENERATINGCFM}
	INLINE $7003, $A098;
	{$ENDC}
PROCEDURE FlushCodeCache;
	{$IFC NOT GENERATINGCFM}
	INLINE $A0BD;
	{$ENDC}
PROCEDURE FlushCodeCacheRange(address: UNIV Ptr; count: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $205F, $7009, $A098;
	{$ENDC}
{$ENDC}
PROCEDURE ReadLocation(VAR loc: MachineLocation);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $203C, $000C, $00E4, $A051;
	{$ENDC}
PROCEDURE WriteLocation({CONST}VAR loc: MachineLocation);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $203C, $000C, $00E4, $A052;
	{$ENDC}
{$IFC OLDROUTINENAMES }
PROCEDURE LongDate2Secs({CONST}VAR lDate: LongDateRec; VAR lSecs: LongDateTime);
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8008, $FFF2, $A8B5;
	{$ENDC}
PROCEDURE LongSecs2Date(VAR lSecs: LongDateTime; VAR lDate: LongDateRec);
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8008, $FFF0, $A8B5;
	{$ENDC}
FUNCTION IUMetric: BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0004, $A9ED;
	{$ENDC}
PROCEDURE Date2Secs({CONST}VAR d: DateTimeRec; VAR secs: LONGINT);
PROCEDURE Secs2Date(secs: LONGINT; VAR d: DateTimeRec);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $201F, $A9C6;
	{$ENDC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := OSUtilsIncludes}

{$ENDC} {__OSUTILS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

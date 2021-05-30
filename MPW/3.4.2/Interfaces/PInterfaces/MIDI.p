{
 	File:		MIDI.p
 
 	Contains:	MIDI Manager Interfaces.
 
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
 UNIT MIDI;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MIDI__}
{$SETC __MIDI__ := 1}

{$I+}
{$SETC MIDIIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
{
						* * *  N O T E  * * * 

	This file has been updated to include MIDI 2.0 interfaces.  
	
	The MIDI 2.0 interfaces were developed for the classic 68K runtime.
	Since then, Apple has created the PowerPC and CFM 68K runtimes.
	Currently, the extra functions in MIDI 2.0 are not in InterfaceLib
	and thus not callable from PowerPC and CFM 68K runtimes (you'll
	get a linker error).  
}

CONST
	midiMaxNameLen				= 31;							{maximum number of characters in port and client names}
{ Time formats }
	midiFormatMSec				= 0;							{milliseconds}
	midiFormatBeats				= 1;							{beats}
	midiFormat24fpsBit			= 2;							{24 frames/sec.}
	midiFormat25fpsBit			= 3;							{25 frames/sec.}
	midiFormat30fpsDBit			= 4;							{30 frames/sec. drop-frame}
	midiFormat30fpsBit			= 5;							{30 frames/sec.}
	midiFormat24fpsQF			= 6;							{24 frames/sec. longInt format }
	midiFormat25fpsQF			= 7;							{25 frames/sec. longInt format }
	midiFormat30fpsDQF			= 8;							{30 frames/sec. drop-frame longInt format }
	midiFormat30fpsQF			= 9;							{30 frames/sec. longInt format }
	midiInternalSync			= 0;							{internal sync}
	midiExternalSync			= 1;							{external sync}
{ Port types}
	midiPortTypeTime			= 0;							{time port}
	midiPortTypeInput			= 1;							{input port}
	midiPortTypeOutput			= 2;							{output port}
	midiPortTypeTimeInv			= 3;							{invisible time port}
	midiPortInvisible			= $8000;						{logical OR this to other types to make invisible ports}
	midiPortTypeMask			= $0007;						{logical AND with this to convert new port types to old,
									  ie. to strip the property bits}
{ OffsetTimes  }
	midiGetEverything			= $7FFFFFFF;					{get all packets, regardless of time stamps}
	midiGetNothing				= $80000000;					{get no packets, regardless of time stamps}
	midiGetCurrent				= $00000000;					{get current packets only}

{    MIDI data and messages are passed in MIDIPacket records (see below).
    The first byte of every MIDIPacket contains a set of flags

    bits 0-1    00 = new MIDIPacket, not continued
                     01 = begining of continued MIDIPacket
                     10 = end of continued MIDIPacket
                     11 = continuation
    bits 2-3     reserved

    bits 4-6      000 = packet contains MIDI data

                  001 = packet contains MIDI Manager message

    bit 7         0 = MIDIPacket has valid stamp
                  1 = stamp with current clock
}
	midiContMask				= $03;
	midiNoCont					= $00;
	midiStartCont				= $01;
	midiMidCont					= $03;
	midiEndCont					= $02;
	midiTypeMask				= $70;
	midiMsgType					= $00;
	midiMgrType					= $10;
	midiTimeStampMask			= $80;
	midiTimeStampCurrent		= $80;
	midiTimeStampValid			= $00;
{ MIDIPacket command words (the first word in the data field for midiMgrType messages) }
	midiOverflowErr				= $0001;
	midiSCCErr					= $0002;
	midiPacketErr				= $0003;
{all command words less than this value are error indicators}
	midiMaxErr					= $00FF;
{ Valid results to be returned by readHooks }
	midiKeepPacket				= 0;
	midiMorePacket				= 1;
	midiNoMorePacket			= 2;
	midiHoldPacket				= 3;
{ Driver calls }
	midiOpenDriver				= 1;
	midiCloseDriver				= 2;

	mdvrAbortNotesOff			= 0;							{abort previous mdvrNotesOff request}
	mdvrChanNotesOff			= 1;							{generate channel note off messages}
	mdvrAllNotesOff				= 2;							{generate all note off messages}
	mdvrStopOut					= 0;							{stop calling MDVROut temporarily}
	mdvrStartOut				= 1;							{resume calling MDVROut}


TYPE
	MIDIPacket = PACKED RECORD
		flags:					UInt8;
		len:					UInt8;
		tStamp:					LONGINT;
		data:					ARRAY [0..248] OF UInt8;
	END;

	MIDIPacketPtr = ^MIDIPacket;

	MIDIReadHookProcPtr = ProcPtr;  { FUNCTION MIDIReadHook(myPacket: MIDIPacketPtr; myRefCon: LONGINT): INTEGER; }
	MIDITimeProcPtr = ProcPtr;  { PROCEDURE MIDITime(curTime: LONGINT; myRefCon: LONGINT); }
	MIDIConnectionProcPtr = ProcPtr;  { PROCEDURE MIDIConnection(refnum: INTEGER; refcon: LONGINT; portType: INTEGER; clientID: OSType; portID: OSType; connect: BOOLEAN; direction: INTEGER); }
	MDVRCommProcPtr = ProcPtr;  { FUNCTION MDVRComm(refnum: INTEGER; request: INTEGER; refCon: LONGINT): LONGINT; }
	MDVRTimeCodeProcPtr = ProcPtr;  { PROCEDURE MDVRTimeCode(refnum: INTEGER; newFormat: INTEGER; refCon: LONGINT); }
	MDVRReadProcPtr = ProcPtr;  { PROCEDURE MDVRRead(midiChars: CStringPtr; length: INTEGER; refCon: LONGINT); }
	MIDIReadHookUPP = UniversalProcPtr;
	MIDITimeUPP = UniversalProcPtr;
	MIDIConnectionUPP = UniversalProcPtr;
	MDVRCommUPP = UniversalProcPtr;
	MDVRTimeCodeUPP = UniversalProcPtr;
	MDVRReadUPP = UniversalProcPtr;

	MIDIClkInfo = RECORD
		syncType:				INTEGER;								{synchronization external/internal}
		curTime:				LONGINT;								{current value of port's clock}
		format:					INTEGER;								{time code format}
	END;

	MIDIIDRec = RECORD
		clientID:				OSType;
		portID:					OSType;
	END;

	MIDIPortInfo = RECORD
		portType:				INTEGER;								{type of port}
		timeBase:				MIDIIDRec;								{MIDIIDRec for time base}
		numConnects:			INTEGER;								{number of connections}
		cList:					ARRAY [0..0] OF MIDIIDRec;				{ARRAY [1..numConnects] of MIDIIDRec}
	END;

	MIDIPortInfoPtr = ^MIDIPortInfo;
	MIDIPortInfoHdl = ^MIDIPortInfoPtr;
	MIDIPortInfoHandle = ^MIDIPortInfoPtr;

	MIDIPortParams = RECORD
		portID:					OSType;									{ID of port, unique within client}
		portType:				INTEGER;								{Type of port - input, output, time, etc.}
		timeBase:				INTEGER;								{refnum of time base, 0 if none}
		offsetTime:				LONGINT;								{offset for current time stamps}
		readHook:				MIDIReadHookUPP;						{routine to call when input data is valid}
		refCon:					LONGINT;								{refcon for port (for client use)}
		initClock:				MIDIClkInfo;							{initial settings for a time base}
		name:					Str255;									{name of the port, This is a real live string, not a ptr.}
	END;

	MIDIPortParamsPtr = ^MIDIPortParams;

	MIDIIDList = RECORD
		numIDs:					INTEGER;
		list:					ARRAY [0..0] OF OSType;
	END;

	MIDIIDListPtr = ^MIDIIDList;
	MIDIIDListHdl = ^MIDIIDListPtr;
	MIDIIDListHandle = ^MIDIIDListPtr;

{ MDVR Control structs}
	MDVRInCtlRec = RECORD
		timeCodeClock:			INTEGER;								{refnum of time base for time code}
		timeCodeFormat:			INTEGER;								{format of time code output}
		readProc:				MDVRReadUPP;							{proc to call with intput characters}
		commProc:				MDVRCommUPP;							{proc to call for handshaking}
		refCon:					LONGINT;								{refCon passed to readProc, commProc}
	END;

	MDVRInCtlPtr = ^MDVRInCtlRec;

	MDVROutCtlRec = RECORD
		timeCodeClock:			INTEGER;								{time base driven by time code}
		timeCodeFormat:			INTEGER;								{format of time code to listen to}
		timeCodeProc:			MDVRTimeCodeUPP;						{proc called on time code fmt change}
		commProc:				MDVRCommUPP;							{proc called for handshaking}
		refCon:					LONGINT;								{refCon passed to timeCodeProc}
		timeCodeFilter:			BOOLEAN;								{filter time code if true}
		padding:				SInt8; (* UInt8 *)						{unused pad byte}
		midiMsgTicks:			LONGINT;								{value of Ticks when MIDI msg rcvd}
		timeCodeTicks:			LONGINT;								{value of Ticks when time code rcvd}
	END;

	MDVROutCtlPtr = ^MDVROutCtlRec;

	MDVRPtr = Ptr;

{ MIDIVersion() return a NumVersion}

FUNCTION MIDIVersion: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, 4, $A800;
	{$ENDC}
FUNCTION MIDISignIn(clientID: OSType; refCon: LONGINT; icon: Handle; name: ConstStr255Param): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, 4, $A800;
	{$ENDC}
PROCEDURE MIDISignOut(clientID: OSType);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, 4, $A800;
	{$ENDC}
FUNCTION MIDIGetClients: MIDIIDListHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, 4, $A800;
	{$ENDC}
PROCEDURE MIDIGetClientName(clientID: OSType; VAR name: Str255);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0010, 4, $A800;
	{$ENDC}
PROCEDURE MIDISetClientName(clientID: OSType; name: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0014, 4, $A800;
	{$ENDC}
FUNCTION MIDIGetPorts(clientID: OSType): MIDIIDListHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0018, 4, $A800;
	{$ENDC}
FUNCTION MIDIAddPort(clientID: OSType; BufSize: INTEGER; VAR refnum: INTEGER; init: MIDIPortParamsPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $001C, 4, $A800;
	{$ENDC}
FUNCTION MIDIGetPortInfo(clientID: OSType; portID: OSType): MIDIPortInfoHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0020, 4, $A800;
	{$ENDC}
FUNCTION MIDIConnectData(srcClID: OSType; srcPortID: OSType; dstClID: OSType; dstPortID: OSType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0024, 4, $A800;
	{$ENDC}
FUNCTION MIDIUnConnectData(srcClID: OSType; srcPortID: OSType; dstClID: OSType; dstPortID: OSType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0028, 4, $A800;
	{$ENDC}
FUNCTION MIDIConnectTime(srcClID: OSType; srcPortID: OSType; dstClID: OSType; dstPortID: OSType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $002C, 4, $A800;
	{$ENDC}
FUNCTION MIDIUnConnectTime(srcClID: OSType; srcPortID: OSType; dstClID: OSType; dstPortID: OSType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0030, 4, $A800;
	{$ENDC}
PROCEDURE MIDIFlush(refnum: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0034, 4, $A800;
	{$ENDC}
FUNCTION MIDIGetReadHook(refnum: INTEGER): ProcPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0038, 4, $A800;
	{$ENDC}
PROCEDURE MIDISetReadHook(refnum: INTEGER; hook: ProcPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $003C, 4, $A800;
	{$ENDC}
PROCEDURE MIDIGetPortName(clientID: OSType; portID: OSType; VAR name: Str255);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0040, 4, $A800;
	{$ENDC}
PROCEDURE MIDISetPortName(clientID: OSType; portID: OSType; name: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0044, 4, $A800;
	{$ENDC}
PROCEDURE MIDIWakeUp(refnum: INTEGER; time: LONGINT; period: LONGINT; timeProc: MIDITimeUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0048, 4, $A800;
	{$ENDC}
PROCEDURE MIDIRemovePort(refnum: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $004C, 4, $A800;
	{$ENDC}
FUNCTION MIDIGetSync(refnum: INTEGER): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0050, 4, $A800;
	{$ENDC}
PROCEDURE MIDISetSync(refnum: INTEGER; sync: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0054, 4, $A800;
	{$ENDC}
FUNCTION MIDIGetCurTime(refnum: INTEGER): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0058, 4, $A800;
	{$ENDC}
PROCEDURE MIDISetCurTime(refnum: INTEGER; time: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $005C, 4, $A800;
	{$ENDC}
PROCEDURE MIDIStartTime(refnum: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0060, 4, $A800;
	{$ENDC}
PROCEDURE MIDIStopTime(refnum: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0064, 4, $A800;
	{$ENDC}
PROCEDURE MIDIPoll(refnum: INTEGER; offsetTime: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0068, 4, $A800;
	{$ENDC}
FUNCTION MIDIWritePacket(refnum: INTEGER; packet: MIDIPacketPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $006C, 4, $A800;
	{$ENDC}
FUNCTION MIDIWorldChanged(clientID: OSType): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0070, 4, $A800;
	{$ENDC}
FUNCTION MIDIGetOffsetTime(refnum: INTEGER): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0074, 4, $A800;
	{$ENDC}
PROCEDURE MIDISetOffsetTime(refnum: INTEGER; offsetTime: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0078, 4, $A800;
	{$ENDC}
FUNCTION MIDIConvertTime(srcFormat: INTEGER; dstFormat: INTEGER; time: LONGINT): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $007C, 4, $A800;
	{$ENDC}
FUNCTION MIDIGetRefCon(refnum: INTEGER): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0080, 4, $A800;
	{$ENDC}
PROCEDURE MIDISetRefCon(refnum: INTEGER; refCon: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0084, 4, $A800;
	{$ENDC}
FUNCTION MIDIGetClRefCon(clientID: OSType): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0088, 4, $A800;
	{$ENDC}
PROCEDURE MIDISetClRefCon(clientID: OSType; refCon: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $008C, 4, $A800;
	{$ENDC}
FUNCTION MIDIGetTCFormat(refnum: INTEGER): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0090, 4, $A800;
	{$ENDC}
PROCEDURE MIDISetTCFormat(refnum: INTEGER; format: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0094, 4, $A800;
	{$ENDC}
PROCEDURE MIDISetRunRate(refnum: INTEGER; rate: INTEGER; time: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0098, 4, $A800;
	{$ENDC}
FUNCTION MIDIGetClientIcon(clientID: OSType): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $009C, 4, $A800;
	{$ENDC}
FUNCTION MIDICallAddress(callNum: INTEGER): ProcPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 164, 4, $A800;
	{$ENDC}
PROCEDURE MIDISetConnectionProc(refNum: INTEGER; connectionProc: ProcPtr; refCon: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 168, 4, $A800;
	{$ENDC}
PROCEDURE MIDIGetConnectionProc(refnum: INTEGER; VAR connectionProc: ProcPtr; VAR refCon: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 172, 4, $A800;
	{$ENDC}
PROCEDURE MIDIDiscardPacket(refnum: INTEGER; packet: MIDIPacketPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 176, 4, $A800;
	{$ENDC}
FUNCTION MDVRSignIn(clientID: OSType; refCon: LONGINT; icon: Handle; VAR name: Str255): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 180, 4, $A800;
	{$ENDC}
PROCEDURE MDVRSignOut(clientID: OSType);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 184, 4, $A800;
	{$ENDC}
FUNCTION MDVROpen(portType: INTEGER; refnum: INTEGER): MDVRPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 188, 4, $A800;
	{$ENDC}
PROCEDURE MDVRClose(driverPtr: MDVRPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 192, 4, $A800;
	{$ENDC}
PROCEDURE MDVRControlIn(portPtr: MDVRPtr; inputCtl: MDVRInCtlPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 196, 4, $A800;
	{$ENDC}
PROCEDURE MDVRControlOut(portPtr: MDVRPtr; outputCtl: MDVROutCtlPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 200, 4, $A800;
	{$ENDC}
PROCEDURE MDVRIn(portPtr: MDVRPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 204, 4, $A800;
	{$ENDC}
PROCEDURE MDVROut(portPtr: MDVRPtr; dataPtr: CStringPtr; length: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 208, 4, $A800;
	{$ENDC}
PROCEDURE MDVRNotesOff(portPtr: MDVRPtr; mode: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, 212, 4, $A800;
	{$ENDC}
CONST
	uppMIDIReadHookProcInfo = $000003E0; { FUNCTION (4 byte param, 4 byte param): 2 byte result; }
	uppMIDITimeProcInfo = $000003C0; { PROCEDURE (4 byte param, 4 byte param); }
	uppMIDIConnectionProcInfo = $0009FB80; { PROCEDURE (2 byte param, 4 byte param, 2 byte param, 4 byte param, 4 byte param, 1 byte param, 2 byte param); }
	uppMDVRCommProcInfo = $00000EB0; { FUNCTION (2 byte param, 2 byte param, 4 byte param): 4 byte result; }
	uppMDVRTimeCodeProcInfo = $00000E80; { PROCEDURE (2 byte param, 2 byte param, 4 byte param); }
	uppMDVRReadProcInfo = $00000EC0; { PROCEDURE (4 byte param, 2 byte param, 4 byte param); }

FUNCTION NewMIDIReadHookProc(userRoutine: MIDIReadHookProcPtr): MIDIReadHookUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMIDITimeProc(userRoutine: MIDITimeProcPtr): MIDITimeUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMIDIConnectionProc(userRoutine: MIDIConnectionProcPtr): MIDIConnectionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMDVRCommProc(userRoutine: MDVRCommProcPtr): MDVRCommUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMDVRTimeCodeProc(userRoutine: MDVRTimeCodeProcPtr): MDVRTimeCodeUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMDVRReadProc(userRoutine: MDVRReadProcPtr): MDVRReadUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallMIDIReadHookProc(myPacket: MIDIPacketPtr; myRefCon: LONGINT; userRoutine: MIDIReadHookUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallMIDITimeProc(curTime: LONGINT; myRefCon: LONGINT; userRoutine: MIDITimeUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallMIDIConnectionProc(refnum: INTEGER; refcon: LONGINT; portType: INTEGER; clientID: OSType; portID: OSType; connect: BOOLEAN; direction: INTEGER; userRoutine: MIDIConnectionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMDVRCommProc(refnum: INTEGER; request: INTEGER; refCon: LONGINT; userRoutine: MDVRCommUPP): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallMDVRTimeCodeProc(refnum: INTEGER; newFormat: INTEGER; refCon: LONGINT; userRoutine: MDVRTimeCodeUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallMDVRReadProc(midiChars: CStringPtr; length: INTEGER; refCon: LONGINT; userRoutine: MDVRReadUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MIDIIncludes}

{$ENDC} {__MIDI__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

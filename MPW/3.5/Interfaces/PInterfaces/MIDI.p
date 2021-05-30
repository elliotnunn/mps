{
     File:       MIDI.p
 
     Contains:   MIDI Manager Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1988-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
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
	midiMaxNameLen				= 31;							{ maximum number of characters in port and client names }

																{  Time formats  }
	midiFormatMSec				= 0;							{ milliseconds }
	midiFormatBeats				= 1;							{ beats }
	midiFormat24fpsBit			= 2;							{ 24 frames/sec. }
	midiFormat25fpsBit			= 3;							{ 25 frames/sec. }
	midiFormat30fpsDBit			= 4;							{ 30 frames/sec. drop-frame }
	midiFormat30fpsBit			= 5;							{ 30 frames/sec. }
	midiFormat24fpsQF			= 6;							{ 24 frames/sec. longInt format  }
	midiFormat25fpsQF			= 7;							{ 25 frames/sec. longInt format  }
	midiFormat30fpsDQF			= 8;							{ 30 frames/sec. drop-frame longInt format  }
	midiFormat30fpsQF			= 9;							{ 30 frames/sec. longInt format  }

	midiInternalSync			= 0;							{ internal sync }
	midiExternalSync			= 1;							{ external sync }

																{  Port types }
	midiPortTypeTime			= 0;							{ time port }
	midiPortTypeInput			= 1;							{ input port }
	midiPortTypeOutput			= 2;							{ output port }
	midiPortTypeTimeInv			= 3;							{ invisible time port }
	midiPortInvisible			= $8000;						{ logical OR this to other types to make invisible ports }
	midiPortTypeMask			= $0007;						{ logical AND with this to convert new port types to old, i.e. to strip the property bits }

																{  OffsetTimes   }
	midiGetEverything			= $7FFFFFFF;					{ get all packets, regardless of time stamps }
	midiGetNothing				= $80000000;					{ get no packets, regardless of time stamps }
	midiGetCurrent				= $00000000;					{ get current packets only }

	{	    MIDI data and messages are passed in MIDIPacket records (see below).
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

																{  MIDIPacket command words (the first word in the data field for midiMgrType messages)  }
	midiOverflowErr				= $0001;
	midiSCCErr					= $0002;
	midiPacketErr				= $0003;						{ all command words less than this value are error indicators }
	midiMaxErr					= $00FF;

																{  Valid results to be returned by readHooks  }
	midiKeepPacket				= 0;
	midiMorePacket				= 1;
	midiNoMorePacket			= 2;
	midiHoldPacket				= 3;

																{  Driver calls  }
	midiOpenDriver				= 1;
	midiCloseDriver				= 2;

	mdvrAbortNotesOff			= 0;							{ abort previous mdvrNotesOff request }
	mdvrChanNotesOff			= 1;							{ generate channel note off messages }
	mdvrAllNotesOff				= 2;							{ generate all note off messages }

	mdvrStopOut					= 0;							{ stop calling MDVROut temporarily }
	mdvrStartOut				= 1;							{ resume calling MDVROut }


TYPE
	MIDIPacketPtr = ^MIDIPacket;
	MIDIPacket = PACKED RECORD
		flags:					UInt8;
		len:					UInt8;
		tStamp:					LONGINT;
		data:					PACKED ARRAY [0..248] OF UInt8;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	MIDIReadHookProcPtr = FUNCTION(myPacket: MIDIPacketPtr; myRefCon: LONGINT): INTEGER;
{$ELSEC}
	MIDIReadHookProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MIDITimeProcPtr = PROCEDURE(curTime: LONGINT; myRefCon: LONGINT);
{$ELSEC}
	MIDITimeProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MIDIConnectionProcPtr = PROCEDURE(refnum: INTEGER; refcon: LONGINT; portType: INTEGER; clientID: OSType; portID: OSType; connect: BOOLEAN; direction: INTEGER);
{$ELSEC}
	MIDIConnectionProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MDVRCommProcPtr = FUNCTION(refnum: INTEGER; request: INTEGER; refCon: LONGINT): LONGINT;
{$ELSEC}
	MDVRCommProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MDVRTimeCodeProcPtr = PROCEDURE(refnum: INTEGER; newFormat: INTEGER; refCon: LONGINT);
{$ELSEC}
	MDVRTimeCodeProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MDVRReadProcPtr = PROCEDURE(midiChars: CStringPtr; length: INTEGER; refCon: LONGINT);
{$ELSEC}
	MDVRReadProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	MIDIReadHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MIDIReadHookUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MIDITimeUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MIDITimeUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MIDIConnectionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MIDIConnectionUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MDVRCommUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MDVRCommUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MDVRTimeCodeUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MDVRTimeCodeUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MDVRReadUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MDVRReadUPP = UniversalProcPtr;
{$ENDC}	
	MIDIClkInfoPtr = ^MIDIClkInfo;
	MIDIClkInfo = RECORD
		syncType:				INTEGER;								{ synchronization external/internal }
		curTime:				LONGINT;								{ current value of port's clock }
		format:					INTEGER;								{ time code format }
	END;

	MIDIIDRecPtr = ^MIDIIDRec;
	MIDIIDRec = RECORD
		clientID:				OSType;
		portID:					OSType;
	END;

	MIDIPortInfoPtr = ^MIDIPortInfo;
	MIDIPortInfo = RECORD
		portType:				INTEGER;								{ type of port }
		timeBase:				MIDIIDRec;								{ MIDIIDRec for time base }
		numConnects:			INTEGER;								{ number of connections }
		cList:					ARRAY [0..0] OF MIDIIDRec;				{ ARRAY [1..numConnects] of MIDIIDRec }
	END;

	MIDIPortInfoHdl						= ^MIDIPortInfoPtr;
	MIDIPortInfoHandle					= ^MIDIPortInfoPtr;
	MIDIPortParamsPtr = ^MIDIPortParams;
	MIDIPortParams = RECORD
		portID:					OSType;									{ ID of port, unique within client }
		portType:				INTEGER;								{ Type of port - input, output, time, etc. }
		timeBase:				INTEGER;								{ refnum of time base, 0 if none }
		offsetTime:				LONGINT;								{ offset for current time stamps }
		readHook:				MIDIReadHookUPP;						{ routine to call when input data is valid }
		refCon:					LONGINT;								{ refcon for port (for client use) }
		initClock:				MIDIClkInfo;							{ initial settings for a time base }
		name:					Str255;									{ name of the port, This is a real live string, not a ptr. }
	END;

	MIDIIDListPtr = ^MIDIIDList;
	MIDIIDList = RECORD
		numIDs:					INTEGER;
		list:					ARRAY [0..0] OF OSType;
	END;

	MIDIIDListHdl						= ^MIDIIDListPtr;
	MIDIIDListHandle					= ^MIDIIDListPtr;
	{  MDVR Control structs }
	MDVRInCtlRecPtr = ^MDVRInCtlRec;
	MDVRInCtlRec = RECORD
		timeCodeClock:			INTEGER;								{ refnum of time base for time code }
		timeCodeFormat:			INTEGER;								{ format of time code output }
		readProc:				MDVRReadUPP;							{ proc to call with intput characters }
		commProc:				MDVRCommUPP;							{ proc to call for handshaking }
		refCon:					LONGINT;								{ refCon passed to readProc, commProc }
	END;

	MDVRInCtlPtr						= ^MDVRInCtlRec;
	MDVROutCtlRecPtr = ^MDVROutCtlRec;
	MDVROutCtlRec = RECORD
		timeCodeClock:			INTEGER;								{ time base driven by time code }
		timeCodeFormat:			INTEGER;								{ format of time code to listen to }
		timeCodeProc:			MDVRTimeCodeUPP;						{ proc called on time code fmt change }
		commProc:				MDVRCommUPP;							{ proc called for handshaking }
		refCon:					LONGINT;								{ refCon passed to timeCodeProc }
		timeCodeFilter:			BOOLEAN;								{ filter time code if true }
		padding:				SInt8;									{ unused pad byte }
		midiMsgTicks:			LONGINT;								{ value of Ticks when MIDI msg rcvd }
		timeCodeTicks:			LONGINT;								{ value of Ticks when time code rcvd }
	END;

	MDVROutCtlPtr						= ^MDVROutCtlRec;
	MDVRPtr								= Ptr;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  MIDIVersion()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION MIDIVersion: NumVersion;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0004, $A800;
	{$ENDC}

{
 *  MIDISignIn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDISignIn(clientID: OSType; refCon: LONGINT; icon: Handle; name: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0004, $A800;
	{$ENDC}

{
 *  MIDISignOut()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDISignOut(clientID: OSType);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0004, $A800;
	{$ENDC}

{
 *  MIDIGetClients()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIGetClients: MIDIIDListHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0004, $A800;
	{$ENDC}

{
 *  MIDIGetClientName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDIGetClientName(clientID: OSType; VAR name: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0004, $A800;
	{$ENDC}

{
 *  MIDISetClientName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDISetClientName(clientID: OSType; name: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0014, $0004, $A800;
	{$ENDC}

{
 *  MIDIGetPorts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIGetPorts(clientID: OSType): MIDIIDListHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0018, $0004, $A800;
	{$ENDC}

{
 *  MIDIAddPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIAddPort(clientID: OSType; BufSize: INTEGER; VAR refnum: INTEGER; init: MIDIPortParamsPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $001C, $0004, $A800;
	{$ENDC}

{
 *  MIDIGetPortInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIGetPortInfo(clientID: OSType; portID: OSType): MIDIPortInfoHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0020, $0004, $A800;
	{$ENDC}

{
 *  MIDIConnectData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIConnectData(srcClID: OSType; srcPortID: OSType; dstClID: OSType; dstPortID: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0024, $0004, $A800;
	{$ENDC}

{
 *  MIDIUnConnectData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIUnConnectData(srcClID: OSType; srcPortID: OSType; dstClID: OSType; dstPortID: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0028, $0004, $A800;
	{$ENDC}

{
 *  MIDIConnectTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIConnectTime(srcClID: OSType; srcPortID: OSType; dstClID: OSType; dstPortID: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $002C, $0004, $A800;
	{$ENDC}

{
 *  MIDIUnConnectTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIUnConnectTime(srcClID: OSType; srcPortID: OSType; dstClID: OSType; dstPortID: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0030, $0004, $A800;
	{$ENDC}

{
 *  MIDIFlush()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDIFlush(refnum: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0034, $0004, $A800;
	{$ENDC}

{
 *  MIDIGetReadHook()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIGetReadHook(refnum: INTEGER): ProcPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0038, $0004, $A800;
	{$ENDC}

{
 *  MIDISetReadHook()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDISetReadHook(refnum: INTEGER; hook: ProcPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $003C, $0004, $A800;
	{$ENDC}

{
 *  MIDIGetPortName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDIGetPortName(clientID: OSType; portID: OSType; VAR name: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0040, $0004, $A800;
	{$ENDC}

{
 *  MIDISetPortName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDISetPortName(clientID: OSType; portID: OSType; name: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0044, $0004, $A800;
	{$ENDC}

{
 *  MIDIWakeUp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDIWakeUp(refnum: INTEGER; time: LONGINT; period: LONGINT; timeProc: MIDITimeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0048, $0004, $A800;
	{$ENDC}

{
 *  MIDIRemovePort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDIRemovePort(refnum: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $004C, $0004, $A800;
	{$ENDC}

{
 *  MIDIGetSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIGetSync(refnum: INTEGER): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0050, $0004, $A800;
	{$ENDC}

{
 *  MIDISetSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDISetSync(refnum: INTEGER; sync: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0054, $0004, $A800;
	{$ENDC}

{
 *  MIDIGetCurTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIGetCurTime(refnum: INTEGER): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0058, $0004, $A800;
	{$ENDC}

{
 *  MIDISetCurTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDISetCurTime(refnum: INTEGER; time: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $005C, $0004, $A800;
	{$ENDC}

{
 *  MIDIStartTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDIStartTime(refnum: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0060, $0004, $A800;
	{$ENDC}

{
 *  MIDIStopTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDIStopTime(refnum: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0064, $0004, $A800;
	{$ENDC}

{
 *  MIDIPoll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDIPoll(refnum: INTEGER; offsetTime: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0068, $0004, $A800;
	{$ENDC}

{
 *  MIDIWritePacket()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIWritePacket(refnum: INTEGER; packet: MIDIPacketPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $006C, $0004, $A800;
	{$ENDC}

{
 *  MIDIWorldChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIWorldChanged(clientID: OSType): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0070, $0004, $A800;
	{$ENDC}

{
 *  MIDIGetOffsetTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIGetOffsetTime(refnum: INTEGER): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0074, $0004, $A800;
	{$ENDC}

{
 *  MIDISetOffsetTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDISetOffsetTime(refnum: INTEGER; offsetTime: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0078, $0004, $A800;
	{$ENDC}

{
 *  MIDIConvertTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIConvertTime(srcFormat: INTEGER; dstFormat: INTEGER; time: LONGINT): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $007C, $0004, $A800;
	{$ENDC}

{
 *  MIDIGetRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIGetRefCon(refnum: INTEGER): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0080, $0004, $A800;
	{$ENDC}

{
 *  MIDISetRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDISetRefCon(refnum: INTEGER; refCon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0084, $0004, $A800;
	{$ENDC}

{
 *  MIDIGetClRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIGetClRefCon(clientID: OSType): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0088, $0004, $A800;
	{$ENDC}

{
 *  MIDISetClRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDISetClRefCon(clientID: OSType; refCon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $008C, $0004, $A800;
	{$ENDC}

{
 *  MIDIGetTCFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIGetTCFormat(refnum: INTEGER): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0090, $0004, $A800;
	{$ENDC}

{
 *  MIDISetTCFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDISetTCFormat(refnum: INTEGER; format: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0094, $0004, $A800;
	{$ENDC}

{
 *  MIDISetRunRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDISetRunRate(refnum: INTEGER; rate: INTEGER; time: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0098, $0004, $A800;
	{$ENDC}

{
 *  MIDIGetClientIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDIGetClientIcon(clientID: OSType): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $009C, $0004, $A800;
	{$ENDC}

{
 *  MIDICallAddress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MIDICallAddress(callNum: INTEGER): ProcPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $00A4, $0004, $A800;
	{$ENDC}

{
 *  MIDISetConnectionProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDISetConnectionProc(refNum: INTEGER; connectionProc: ProcPtr; refCon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $00A8, $0004, $A800;
	{$ENDC}

{
 *  MIDIGetConnectionProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDIGetConnectionProc(refnum: INTEGER; VAR connectionProc: ProcPtr; VAR refCon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $00AC, $0004, $A800;
	{$ENDC}

{
 *  MIDIDiscardPacket()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MIDIDiscardPacket(refnum: INTEGER; packet: MIDIPacketPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $00B0, $0004, $A800;
	{$ENDC}

{
 *  MDVRSignIn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MDVRSignIn(clientID: OSType; refCon: LONGINT; icon: Handle; VAR name: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $00B4, $0004, $A800;
	{$ENDC}

{
 *  MDVRSignOut()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MDVRSignOut(clientID: OSType);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $00B8, $0004, $A800;
	{$ENDC}

{
 *  MDVROpen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MDVROpen(portType: INTEGER; refnum: INTEGER): MDVRPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $00BC, $0004, $A800;
	{$ENDC}

{
 *  MDVRClose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MDVRClose(driverPtr: MDVRPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $00C0, $0004, $A800;
	{$ENDC}

{
 *  MDVRControlIn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MDVRControlIn(portPtr: MDVRPtr; inputCtl: MDVRInCtlPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $00C4, $0004, $A800;
	{$ENDC}

{
 *  MDVRControlOut()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MDVRControlOut(portPtr: MDVRPtr; outputCtl: MDVROutCtlPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $00C8, $0004, $A800;
	{$ENDC}

{
 *  MDVRIn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MDVRIn(portPtr: MDVRPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $00CC, $0004, $A800;
	{$ENDC}

{
 *  MDVROut()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MDVROut(portPtr: MDVRPtr; dataPtr: CStringPtr; length: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $00D0, $0004, $A800;
	{$ENDC}

{
 *  MDVRNotesOff()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE MDVRNotesOff(portPtr: MDVRPtr; mode: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $00D4, $0004, $A800;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	uppMIDIReadHookProcInfo = $000003E0;
	uppMIDITimeProcInfo = $000003C0;
	uppMIDIConnectionProcInfo = $0009FB80;
	uppMDVRCommProcInfo = $00000EB0;
	uppMDVRTimeCodeProcInfo = $00000E80;
	uppMDVRReadProcInfo = $00000EC0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewMIDIReadHookUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewMIDIReadHookUPP(userRoutine: MIDIReadHookProcPtr): MIDIReadHookUPP; { old name was NewMIDIReadHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMIDITimeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewMIDITimeUPP(userRoutine: MIDITimeProcPtr): MIDITimeUPP; { old name was NewMIDITimeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMIDIConnectionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewMIDIConnectionUPP(userRoutine: MIDIConnectionProcPtr): MIDIConnectionUPP; { old name was NewMIDIConnectionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMDVRCommUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewMDVRCommUPP(userRoutine: MDVRCommProcPtr): MDVRCommUPP; { old name was NewMDVRCommProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMDVRTimeCodeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewMDVRTimeCodeUPP(userRoutine: MDVRTimeCodeProcPtr): MDVRTimeCodeUPP; { old name was NewMDVRTimeCodeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMDVRReadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewMDVRReadUPP(userRoutine: MDVRReadProcPtr): MDVRReadUPP; { old name was NewMDVRReadProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeMIDIReadHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeMIDIReadHookUPP(userUPP: MIDIReadHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMIDITimeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeMIDITimeUPP(userUPP: MIDITimeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMIDIConnectionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeMIDIConnectionUPP(userUPP: MIDIConnectionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMDVRCommUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeMDVRCommUPP(userUPP: MDVRCommUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMDVRTimeCodeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeMDVRTimeCodeUPP(userUPP: MDVRTimeCodeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMDVRReadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeMDVRReadUPP(userUPP: MDVRReadUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeMIDIReadHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeMIDIReadHookUPP(myPacket: MIDIPacketPtr; myRefCon: LONGINT; userRoutine: MIDIReadHookUPP): INTEGER; { old name was CallMIDIReadHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMIDITimeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeMIDITimeUPP(curTime: LONGINT; myRefCon: LONGINT; userRoutine: MIDITimeUPP); { old name was CallMIDITimeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMIDIConnectionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeMIDIConnectionUPP(refnum: INTEGER; refcon: LONGINT; portType: INTEGER; clientID: OSType; portID: OSType; connect: BOOLEAN; direction: INTEGER; userRoutine: MIDIConnectionUPP); { old name was CallMIDIConnectionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMDVRCommUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeMDVRCommUPP(refnum: INTEGER; request: INTEGER; refCon: LONGINT; userRoutine: MDVRCommUPP): LONGINT; { old name was CallMDVRCommProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMDVRTimeCodeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeMDVRTimeCodeUPP(refnum: INTEGER; newFormat: INTEGER; refCon: LONGINT; userRoutine: MDVRTimeCodeUPP); { old name was CallMDVRTimeCodeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMDVRReadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeMDVRReadUPP(midiChars: CStringPtr; length: INTEGER; refCon: LONGINT; userRoutine: MDVRReadUPP); { old name was CallMDVRReadProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MIDIIncludes}

{$ENDC} {__MIDI__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

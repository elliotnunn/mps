{
 	File:		Sound.p
 
 	Contains:	Sound Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
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
 UNIT Sound;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SOUND__}
{$SETC __SOUND__ := 1}

{$I+}
{$SETC SoundIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{	MixedMode.p													}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
{
						* * *  N O T E  * * *

	This file has been updated to include Sound Manager 3.2 interfaces.

	Some of the Sound Manager 3.0 interfaces were not put into the InterfaceLib
	that originally shipped with the PowerMacs. These missing functions and the
	new 3.2 interfaces have been released in the SoundLib library for PowerPC
	developers to link with. The runtime library for these functions are
	installed by Sound Manager 3.2. The following functions are found in SoundLib.

		GetCompressionInfo, GetSoundPreference, SetSoundPreference,
		UnsignedFixedMulDiv, SndGetInfo, SndSetInfo
}
{
	Interfaces for Sound Driver, !!! OBSOLETE and NOT SUPPORTED !!!

	These items are no longer defined, but appear here so that someone
	searching the interfaces might find them. If you are using one of these
	items, you must change your code to support the Sound Manager.

		swMode, ftMode, ffMode
		FreeWave, FFSynthRec, Tone, SWSynthRec, Wave, FTSoundRec
		SndCompletionProcPtr
		StartSound, StopSound, SoundDone
}
CONST
	twelfthRootTwo				= 1.05946309435;
	soundListRsrc				= 'snd ';						{Resource type used by Sound Manager}
	rate44khz					= $AC440000;					{44100.00000 in fixed-point}
	rate22050hz					= $56220000;					{22050.00000 in fixed-point}
	rate22khz					= $56EE8BA3;					{22254.54545 in fixed-point}
	rate11khz					= $2B7745D1;					{11127.27273 in fixed-point}
	rate11025hz					= $2B110000;					{11025.00000 in fixed-point}
{synthesizer numbers for SndNewChannel}
	squareWaveSynth				= 1;							{square wave synthesizer}
	waveTableSynth				= 3;							{wave table synthesizer}
	sampledSynth				= 5;							{sampled sound synthesizer}
{old Sound Manager MACE synthesizer numbers}
	MACE3snthID					= 11;
	MACE6snthID					= 13;
	kMiddleC					= 60;							{MIDI note value for middle C}
	kSimpleBeepID				= 1;							{reserved resource ID for Simple Beep}
	kFullVolume					= $0100;						{1.0, setting for full hardware output volume}
	kNoVolume					= 0;							{setting for no sound volume}
{command numbers for SndDoCommand and SndDoImmediate}
	nullCmd						= 0;
	initCmd						= 1;
	freeCmd						= 2;
	quietCmd					= 3;
	flushCmd					= 4;
	reInitCmd					= 5;
	waitCmd						= 10;
	pauseCmd					= 11;
	resumeCmd					= 12;
	callBackCmd					= 13;

	syncCmd						= 14;
	availableCmd				= 24;
	versionCmd					= 25;
	totalLoadCmd				= 26;
	loadCmd						= 27;
	freqDurationCmd				= 40;
	restCmd						= 41;
	freqCmd						= 42;
	ampCmd						= 43;
	timbreCmd					= 44;
	getAmpCmd					= 45;
	volumeCmd					= 46;							{sound manager 3.0 or later only}
	getVolumeCmd				= 47;							{sound manager 3.0 or later only}
	waveTableCmd				= 60;
	phaseCmd					= 61;

	soundCmd					= 80;
	bufferCmd					= 81;
	rateCmd						= 82;
	continueCmd					= 83;
	doubleBufferCmd				= 84;
	getRateCmd					= 85;
	rateMultiplierCmd			= 86;
	getRateMultiplierCmd		= 87;
	sizeCmd						= 90;
	convertCmd					= 91;
	stdQLength					= 128;
	dataOffsetFlag				= $8000;

{channel initialization parameters}
{$IFC OLDROUTINENAMES }
	waveInitChannelMask			= $07;
	waveInitChannel0			= $04;							{wave table only, Sound Manager 2.0 and earlier}
	waveInitChannel1			= $05;							{wave table only, Sound Manager 2.0 and earlier}
	waveInitChannel2			= $06;							{wave table only, Sound Manager 2.0 and earlier}
	waveInitChannel3			= $07;							{wave table only, Sound Manager 2.0 and earlier}
	initChan0					= waveInitChannel0;				{obsolete spelling}
	initChan1					= waveInitChannel1;				{obsolete spelling}
	initChan2					= waveInitChannel2;				{obsolete spelling}
	initChan3					= waveInitChannel3;				{obsolete spelling}

{$ENDC}
	initChanLeft				= $0002;						{left stereo channel}
	initChanRight				= $0003;						{right stereo channel}
	initNoInterp				= $0004;						{no linear interpolation}
	initNoDrop					= $0008;						{no drop-sample conversion}
	initMono					= $0080;						{monophonic channel}
	initStereo					= $00C0;						{stereo channel}
	initMACE3					= $0300;						{MACE 3:1}
	initMACE6					= $0400;						{MACE 6:1}
	initPanMask					= $0003;						{mask for right/left pan values}
	initSRateMask				= $0030;						{mask for sample rate values}
	initStereoMask				= $00C0;						{mask for mono/stereo values}
	initCompMask				= $FF00;						{mask for compression IDs}
	kUseOptionalOutputDevice	= -1;							{only for Sound Manager 3.0 or later}
	notCompressed				= 0;							{compression ID's}
	fixedCompression			= -1;							{compression ID for fixed-sized compression}
	variableCompression			= -2;							{compression ID for variable-sized compression}
	twoToOne					= 1;
	eightToThree				= 2;
	threeToOne					= 3;
	sixToOne					= 4;

	stdSH						= $00;							{Standard sound header encode value}
	extSH						= $FF;							{Extended sound header encode value}
	cmpSH						= $FE;							{Compressed sound header encode value}

	outsideCmpSH				= 0;							{obsolete MACE constant}
	insideCmpSH					= 1;							{obsolete MACE constant}
	aceSuccess					= 0;							{obsolete MACE constant}
	aceMemFull					= 1;							{obsolete MACE constant}
	aceNilBlock					= 2;							{obsolete MACE constant}
	aceBadComp					= 3;							{obsolete MACE constant}
	aceBadEncode				= 4;							{obsolete MACE constant}
	aceBadDest					= 5;							{obsolete MACE constant}
	aceBadCmd					= 6;							{obsolete MACE constant}
	sixToOnePacketSize			= 8;
	threeToOnePacketSize		= 16;
	stateBlockSize				= 64;
	leftOverBlockSize			= 32;
	firstSoundFormat			= $0001;						{general sound format}
	secondSoundFormat			= $0002;						{special sampled sound format (HyperCard)}
	dbBufferReady				= $00000001;					{double buffer is filled}
	dbLastBuffer				= $00000004;					{last double buffer to play}
	sysBeepDisable				= $0000;						{SysBeep() enable flags}
	sysBeepEnable				= 0+(1 * (2**(0)));
	sysBeepSynchronous			= 0+(1 * (2**(1)));				{if bit set, make alert sounds synchronous}
	unitTypeNoSelection			= $FFFF;						{unitTypes for AudioSelection.unitType}
	unitTypeSeconds				= $0000;

{ unsigned fixed-point number }
	
TYPE
	UnsignedFixed = LONGINT;

	SndCommand = PACKED RECORD
		cmd:					INTEGER;
		param1:					INTEGER;
		param2:					LONGINT;
	END;

	SndChannelPtr = ^SndChannel;

	SndCallBackProcPtr = ProcPtr;  { PROCEDURE SndCallBack(chan: SndChannelPtr; VAR cmd: SndCommand); }
	SndCallBackUPP = UniversalProcPtr;

	SndChannel = PACKED RECORD
		nextChan:				SndChannelPtr;
		firstMod:				Ptr;									{ reserved for the Sound Manager }
		callBack:				SndCallBackUPP;
		userInfo:				LONGINT;
		wait:					LONGINT;								{ The following is for internal Sound Manager use only.}
		cmdInProgress:			SndCommand;
		flags:					INTEGER;
		qLength:				INTEGER;
		qHead:					INTEGER;
		qTail:					INTEGER;
		queue:					ARRAY [0..stdQLength-1] OF SndCommand;
	END;

{MACE structures}
	StateBlock = RECORD
		stateVar:				ARRAY [0..stateBlockSize-1] OF INTEGER;
	END;

	StateBlockPtr = ^StateBlock;

	LeftOverBlock = RECORD
		count:					LONGINT;
		sampleArea:				PACKED ARRAY [0..leftOverBlockSize-1] OF SInt8;
	END;

	LeftOverBlockPtr = ^LeftOverBlock;

	ModRef = RECORD
		modNumber:				INTEGER;
		modInit:				LONGINT;
	END;

	SndListResource = RECORD
		format:					INTEGER;
		numModifiers:			INTEGER;
		modifierPart:			ARRAY [0..0] OF ModRef;					{This is a variable length array}
		numCommands:			INTEGER;
		commandPart:			ARRAY [0..0] OF SndCommand;				{This is a variable length array}
		dataPart:				PACKED ARRAY [0..0] OF SInt8;			{This is a variable length array}
	END;

	SndListPtr = ^SndListResource;

	SndListHndl = ^SndListPtr;
	SndListHandle = ^SndListPtr;

{HyperCard sound resource format}
	Snd2ListResource = RECORD
		format:					INTEGER;
		refCount:				INTEGER;
		numCommands:			INTEGER;
		commandPart:			ARRAY [0..0] OF SndCommand;				{This is a variable length array}
		dataPart:				PACKED ARRAY [0..0] OF SInt8;			{This is a variable length array}
	END;

	Snd2ListPtr = ^Snd2ListResource;

	Snd2ListHndl = ^Snd2ListPtr;
	Snd2ListHandle = ^Snd2ListPtr;

	SoundHeader = PACKED RECORD
		samplePtr:				Ptr;									{if NIL then samples are in sampleArea}
		length:					LONGINT;								{length of sound in bytes}
		sampleRate:				UnsignedFixed;							{sample rate for this sound}
		loopStart:				LONGINT;								{start of looping portion}
		loopEnd:				LONGINT;								{end of looping portion}
		encode:					UInt8;									{header encoding}
		baseFrequency:			UInt8;									{baseFrequency value}
		sampleArea:				PACKED ARRAY [0..0] OF SInt8;			{space for when samples follow directly}
	END;

	SoundHeaderPtr = ^SoundHeader;

	CmpSoundHeader = PACKED RECORD
		samplePtr:				Ptr;									{if nil then samples are in sample area}
		numChannels:			LONGINT;								{number of channels i.e. mono = 1}
		sampleRate:				UnsignedFixed;							{sample rate in Apples Fixed point representation}
		loopStart:				LONGINT;								{loopStart of sound before compression}
		loopEnd:				LONGINT;								{loopEnd of sound before compression}
		encode:					UInt8;									{data structure used , stdSH, extSH, or cmpSH}
		baseFrequency:			UInt8;									{same meaning as regular SoundHeader}
		numFrames:				LONGINT;								{length in frames ( packetFrames or sampleFrames )}
		AIFFSampleRate:			extended80;								{IEEE sample rate}
		markerChunk:			Ptr;									{sync track}
		format:					OSType;									{data format type, was futureUse1}
		futureUse2:				LONGINT;								{reserved by Apple}
		stateVars:				StateBlockPtr;							{pointer to State Block}
		leftOverSamples:		LeftOverBlockPtr;						{used to save truncated samples between compression calls}
		compressionID:			INTEGER;								{0 means no compression, non zero means compressionID}
		packetSize:				INTEGER;								{number of bits in compressed sample packet}
		snthID:					INTEGER;								{resource ID of Sound Manager snth that contains NRT C/E}
		sampleSize:				INTEGER;								{number of bits in non-compressed sample}
		sampleArea:				PACKED ARRAY [0..0] OF SInt8;			{space for when samples follow directly}
	END;

	CmpSoundHeaderPtr = ^CmpSoundHeader;

	ExtSoundHeader = PACKED RECORD
		samplePtr:				Ptr;									{if nil then samples are in sample area}
		numChannels:			LONGINT;								{number of channels,  ie mono = 1}
		sampleRate:				UnsignedFixed;							{sample rate in Apples Fixed point representation}
		loopStart:				LONGINT;								{same meaning as regular SoundHeader}
		loopEnd:				LONGINT;								{same meaning as regular SoundHeader}
		encode:					UInt8;									{data structure used , stdSH, extSH, or cmpSH}
		baseFrequency:			UInt8;									{same meaning as regular SoundHeader}
		numFrames:				LONGINT;								{length in total number of frames}
		AIFFSampleRate:			extended80;								{IEEE sample rate}
		markerChunk:			Ptr;									{sync track}
		instrumentChunks:		Ptr;									{AIFF instrument chunks}
		AESRecording:			Ptr;
		sampleSize:				INTEGER;								{number of bits in sample}
		futureUse1:				INTEGER;								{reserved by Apple}
		futureUse2:				LONGINT;								{reserved by Apple}
		futureUse3:				LONGINT;								{reserved by Apple}
		futureUse4:				LONGINT;								{reserved by Apple}
		sampleArea:				PACKED ARRAY [0..0] OF SInt8;			{space for when samples follow directly}
	END;

	ExtSoundHeaderPtr = ^ExtSoundHeader;

	ConversionBlock = RECORD
		destination:			INTEGER;
		unused:					INTEGER;
		inputPtr:				CmpSoundHeaderPtr;
		outputPtr:				CmpSoundHeaderPtr;
	END;

	ConversionBlockPtr = ^ConversionBlock;

	SMStatus = PACKED RECORD
		smMaxCPULoad:			INTEGER;
		smNumChannels:			INTEGER;
		smCurCPULoad:			INTEGER;
	END;

	SMStatusPtr = ^SMStatus;

	SCStatus = RECORD
		scStartTime:			UnsignedFixed;
		scEndTime:				UnsignedFixed;
		scCurrentTime:			UnsignedFixed;
		scChannelBusy:			BOOLEAN;
		scChannelDisposed:		BOOLEAN;
		scChannelPaused:		BOOLEAN;
		scUnused:				BOOLEAN;
		scChannelAttributes:	LONGINT;
		scCPULoad:				LONGINT;
	END;

	SCStatusPtr = ^SCStatus;

	AudioSelection = PACKED RECORD
		unitType:				LONGINT;
		selStart:				UnsignedFixed;
		selEnd:					UnsignedFixed;
	END;

	FilePlayCompletionProcPtr = ProcPtr;  { PROCEDURE FilePlayCompletion(chan: SndChannelPtr); }
	FilePlayCompletionUPP = UniversalProcPtr;

CONST
	uppFilePlayCompletionProcInfo = $000000C0; { PROCEDURE (4 byte param); }

FUNCTION NewFilePlayCompletionProc(userRoutine: FilePlayCompletionProcPtr): FilePlayCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallFilePlayCompletionProc(chan: SndChannelPtr; userRoutine: FilePlayCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	AudioSelectionPtr = ^AudioSelection;

	SndDoubleBuffer = PACKED RECORD
		dbNumFrames:			LONGINT;
		dbFlags:				LONGINT;
		dbUserInfo:				ARRAY [0..1] OF LONGINT;
		dbSoundData:			PACKED ARRAY [0..0] OF SInt8;
	END;

	SndDoubleBufferPtr = ^SndDoubleBuffer;

	SndDoubleBackProcPtr = ProcPtr;  { PROCEDURE SndDoubleBack(channel: SndChannelPtr; doubleBufferPtr: SndDoubleBufferPtr); }
	SndDoubleBackUPP = UniversalProcPtr;

CONST
	uppSndDoubleBackProcInfo = $000003C0; { PROCEDURE (4 byte param, 4 byte param); }

FUNCTION NewSndDoubleBackProc(userRoutine: SndDoubleBackProcPtr): SndDoubleBackUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallSndDoubleBackProc(channel: SndChannelPtr; doubleBufferPtr: SndDoubleBufferPtr; userRoutine: SndDoubleBackUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	SndDoubleBufferHeader = PACKED RECORD
		dbhNumChannels:			INTEGER;
		dbhSampleSize:			INTEGER;
		dbhCompressionID:		INTEGER;
		dbhPacketSize:			INTEGER;
		dbhSampleRate:			UnsignedFixed;
		dbhBufferPtr:			ARRAY [0..1] OF SndDoubleBufferPtr;
		dbhDoubleBack:			SndDoubleBackUPP;
	END;

	SndDoubleBufferHeaderPtr = ^SndDoubleBufferHeader;

	SndDoubleBufferHeader2 = PACKED RECORD
		dbhNumChannels:			INTEGER;
		dbhSampleSize:			INTEGER;
		dbhCompressionID:		INTEGER;
		dbhPacketSize:			INTEGER;
		dbhSampleRate:			UnsignedFixed;
		dbhBufferPtr:			ARRAY [0..1] OF SndDoubleBufferPtr;
		dbhDoubleBack:			SndDoubleBackUPP;
		dbhFormat:				OSType;
	END;

	SndDoubleBufferHeader2Ptr = ^SndDoubleBufferHeader2;

	SoundInfoList = PACKED RECORD
		count:					INTEGER;
		infoHandle:				Handle;
	END;

	SoundInfoListPtr = ^SoundInfoList;

	SoundComponentDataPtr = ^SoundComponentData;

	SoundComponentData = RECORD
		flags:					LONGINT;
		format:					OSType;
		numChannels:			INTEGER;
		sampleSize:				INTEGER;
		sampleRate:				UnsignedFixed;
		sampleCount:			LONGINT;
		buffer:					^Byte;
		reserved:				LONGINT;
	END;

	
	CompressionInfo = RECORD
		recordSize:				LONGINT;
		format:					OSType;
		compressionID:			INTEGER;
		samplesPerPacket:		INTEGER;
		bytesPerPacket:			INTEGER;
		bytesPerFrame:			INTEGER;
		bytesPerSample:			INTEGER;
		futureUse1:				INTEGER;
	END;

	CompressionInfoPtr = ^CompressionInfo;

	CompressionInfoHandle = ^CompressionInfoPtr;
	
{ private thing to use as a reference to a Sound Converter }
	SoundConverter = ^LONGINT;

{ These two routines for Get/SetSoundVol should no longer be used.}
{ They were for old Apple Sound Chip machines, and do not support the DSP or PowerMacs.}
{ Use Get/SetDefaultOutputVolume instead, if you must change the user's machine.}
{$IFC OLDROUTINENAMES  & NOT GENERATINGCFM }

PROCEDURE SetSoundVol(level: INTEGER);
PROCEDURE GetSoundVol(VAR level: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4218, $10B8, $0260;
	{$ENDC}
{$ENDC}

FUNCTION SndDoCommand(chan: SndChannelPtr; {CONST}VAR cmd: SndCommand; noWait: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $A803;
	{$ENDC}
FUNCTION SndDoImmediate(chan: SndChannelPtr; {CONST}VAR cmd: SndCommand): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $A804;
	{$ENDC}
FUNCTION SndNewChannel(VAR chan: SndChannelPtr; synth: INTEGER; init: LONGINT; userRoutine: SndCallBackUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $A807;
	{$ENDC}
FUNCTION SndDisposeChannel(chan: SndChannelPtr; quietNow: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $A801;
	{$ENDC}
FUNCTION SndPlay(chan: SndChannelPtr; sndHdl: SndListHandle; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $A805;
	{$ENDC}
{$IFC OLDROUTINENAMES }
FUNCTION SndAddModifier(chan: SndChannelPtr; modifier: Ptr; id: INTEGER; init: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $A802;
	{$ENDC}
{$ENDC}
FUNCTION SndControl(id: INTEGER; VAR cmd: SndCommand): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $A806;
	{$ENDC}
{ Sound Manager 2.0 and later, uses _SoundDispatch }
FUNCTION SndSoundManagerVersion: NumVersion;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0008, $A800;
	{$ENDC}
FUNCTION SndStartFilePlay(chan: SndChannelPtr; fRefNum: INTEGER; resNum: INTEGER; bufferSize: LONGINT; theBuffer: UNIV Ptr; theSelection: AudioSelectionPtr; theCompletion: FilePlayCompletionUPP; async: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0D00, $0008, $A800;
	{$ENDC}
FUNCTION SndPauseFilePlay(chan: SndChannelPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0204, $0008, $A800;
	{$ENDC}
FUNCTION SndStopFilePlay(chan: SndChannelPtr; quietNow: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0308, $0008, $A800;
	{$ENDC}
FUNCTION SndChannelStatus(chan: SndChannelPtr; theLength: INTEGER; theStatus: SCStatusPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0510, $0008, $A800;
	{$ENDC}
FUNCTION SndManagerStatus(theLength: INTEGER; theStatus: SMStatusPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0314, $0008, $A800;
	{$ENDC}
PROCEDURE SndGetSysBeepState(VAR sysBeepState: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0218, $0008, $A800;
	{$ENDC}
FUNCTION SndSetSysBeepState(sysBeepState: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $011C, $0008, $A800;
	{$ENDC}
FUNCTION SndPlayDoubleBuffer(chan: SndChannelPtr; theParams: SndDoubleBufferHeaderPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0420, $0008, $A800;
	{$ENDC}
{ MACE compression routines }
FUNCTION MACEVersion: NumVersion;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, $0010, $A800;
	{$ENDC}
PROCEDURE Comp3to1(inBuffer: UNIV Ptr; outBuffer: UNIV Ptr; cnt: LONGINT; inState: StateBlockPtr; outState: StateBlockPtr; numChannels: LONGINT; whichChannel: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0010, $A800;
	{$ENDC}
PROCEDURE Exp1to3(inBuffer: UNIV Ptr; outBuffer: UNIV Ptr; cnt: LONGINT; inState: StateBlockPtr; outState: StateBlockPtr; numChannels: LONGINT; whichChannel: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0010, $A800;
	{$ENDC}
PROCEDURE Comp6to1(inBuffer: UNIV Ptr; outBuffer: UNIV Ptr; cnt: LONGINT; inState: StateBlockPtr; outState: StateBlockPtr; numChannels: LONGINT; whichChannel: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0010, $A800;
	{$ENDC}
PROCEDURE Exp1to6(inBuffer: UNIV Ptr; outBuffer: UNIV Ptr; cnt: LONGINT; inState: StateBlockPtr; outState: StateBlockPtr; numChannels: LONGINT; whichChannel: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0010, $0010, $A800;
	{$ENDC}
{ Sound Manager 3.0 and later calls }
FUNCTION GetSysBeepVolume(VAR level: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0224, $0018, $A800;
	{$ENDC}
FUNCTION SetSysBeepVolume(level: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0228, $0018, $A800;
	{$ENDC}
FUNCTION GetDefaultOutputVolume(VAR level: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $022C, $0018, $A800;
	{$ENDC}
FUNCTION SetDefaultOutputVolume(level: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0230, $0018, $A800;
	{$ENDC}
FUNCTION GetSoundHeaderOffset(sndHandle: SndListHandle; VAR offset: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0404, $0018, $A800;
	{$ENDC}
FUNCTION UnsignedFixedMulDiv(value: UnsignedFixed; multiplier: UnsignedFixed; divisor: UnsignedFixed): UnsignedFixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $060C, $0018, $A800;
	{$ENDC}
FUNCTION GetCompressionInfo(compressionID: INTEGER; format: OSType; numChannels: INTEGER; sampleSize: INTEGER; cp: CompressionInfoPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0710, $0018, $A800;
	{$ENDC}
FUNCTION SetSoundPreference(theType: OSType; VAR name: Str255; settings: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0634, $0018, $A800;
	{$ENDC}
FUNCTION GetSoundPreference(theType: OSType; VAR name: Str255; settings: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0638, $0018, $A800;
	{$ENDC}
{ Sound Manager 3.1 and later calls }
FUNCTION SndGetInfo(chan: SndChannelPtr; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $063C, $0018, $A800;
	{$ENDC}
FUNCTION SndSetInfo(chan: SndChannelPtr; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0640, $0018, $A800;
	{$ENDC}
FUNCTION GetSoundOutputInfo(outputDevice: Component; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0644, $0018, $A800;
	{$ENDC}
FUNCTION SetSoundOutputInfo(outputDevice: Component; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0648, $0018, $A800;
	{$ENDC}

{  Sound Manager 3.2 and later calls  }
FUNCTION GetCompressionName(compressionType: OSType; VAR compressionName: Str255): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $044C, $0018, $A800;
	{$ENDC}
FUNCTION SoundConverterOpen({CONST}VAR inputFormat: SoundComponentData; {CONST}VAR outputFormat: SoundComponentData; VAR sc: SoundConverter): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0650, $0018, $A800;
	{$ENDC}
FUNCTION SoundConverterClose(sc: SoundConverter): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0254, $0018, $A800;
	{$ENDC}
FUNCTION SoundConverterGetBufferSizes(sc: SoundConverter; inputBytesTarget: LONGINT; VAR inputFrames: LONGINT; VAR inputBytes: LONGINT; VAR outputBytes: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0A58, $0018, $A800;
	{$ENDC}
FUNCTION SoundConverterBeginConversion(sc: SoundConverter): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $025C, $0018, $A800;
	{$ENDC}
FUNCTION SoundConverterConvertBuffer(sc: SoundConverter; inputPtr: UNIV Ptr; inputFrames: LONGINT; outputPtr: UNIV Ptr; VAR outputFrames: LONGINT; VAR outputBytes: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0C60, $0018, $A800;
	{$ENDC}
FUNCTION SoundConverterEndConversion(sc: SoundConverter; outputPtr: UNIV Ptr; VAR outputFrames: LONGINT; VAR outputBytes: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0864, $0018, $A800;
	{$ENDC}


CONST
	uppSndCallBackProcInfo = $000003C0; { PROCEDURE (4 byte param, 4 byte param); }

FUNCTION NewSndCallBackProc(userRoutine: SndCallBackProcPtr): SndCallBackUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallSndCallBackProc(chan: SndChannelPtr; VAR cmd: SndCommand; userRoutine: SndCallBackUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SoundIncludes}

{$ENDC} {__SOUND__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

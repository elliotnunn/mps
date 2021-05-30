{
 	File:		QuickTimeMusic.p
 
 	Contains:	QuickTime Interfaces.
 
 	Version:	Technology:	QuickTime 2.5
 				Release:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QuickTimeMusic;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QUICKTIMEMUSIC__}
{$SETC __QUICKTIMEMUSIC__ := 1}

{$I+}
{$SETC QuickTimeMusicIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __IMAGECOMPRESSION__}
{$I ImageCompression.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __VIDEO__}
{$I Video.p}
{$ENDC}
{$IFC UNDEFINED __MEMORY__}
{$I Memory.p}
{$ENDC}
{$IFC UNDEFINED __SOUND__}
{$I Sound.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	kaiToneDescType				= 'tone';
	kaiNoteRequestInfoType		= 'ntrq';
	kaiKnobListType				= 'knbl';
	kaiKeyRangeInfoType			= 'sinf';
	kaiSampleDescType			= 'sdsc';
	kaiSampleInfoType			= 'smin';
	kaiSampleDataType			= 'sdat';
	kaiInstInfoType				= 'iinf';
	kaiPictType					= 'pict';
	kaiWriterType				= '©wrt';
	kaiCopyrightType			= '©cpy';
	kaiOtherStrType				= 'str ';
	kaiInstrumentRefType		= 'iref';
	kaiLibraryInfoType			= 'linf';
	kaiLibraryDescType			= 'ldsc';


TYPE
	InstLibDescRecPtr = ^InstLibDescRec;
	InstLibDescRec = RECORD
		libIDName:				Str31;
	END;

	InstKnobRecPtr = ^InstKnobRec;
	InstKnobRec = RECORD
		number:					LONGINT;
		value:					LONGINT;
	END;


CONST
	kInstKnobMissingUnknown		= 0;
	kInstKnobMissingDefault		= $01;


TYPE
	InstKnobListPtr = ^InstKnobList;
	InstKnobList = RECORD
		knobCount:				LONGINT;
		knobFlags:				LONGINT;
		knob:					ARRAY [0..0] OF InstKnobRec;
	END;


CONST
	kMusicLoopTypeNormal		= 0;
	kMusicLoopTypePalindrome	= 1;							{  back & forth }

	instSamplePreProcessFlag	= $01;


TYPE
	InstSampleDescRecPtr = ^InstSampleDescRec;
	InstSampleDescRec = RECORD
		dataFormat:				OSType;
		numChannels:			INTEGER;
		sampleSize:				INTEGER;
		sampleRate:				UnsignedFixed;
		sampleDataID:			INTEGER;
		offset:					LONGINT;								{  offset within SampleData - this could be just for internal use }
		numSamples:				LONGINT;								{  this could also just be for internal use, we'll see }
		loopType:				LONGINT;
		loopStart:				LONGINT;
		loopEnd:				LONGINT;
		pitchNormal:			LONGINT;
		pitchLow:				LONGINT;
		pitchHigh:				LONGINT;
	END;


TYPE
	AtomicInstrument					= Handle;
	AtomicInstrumentPtr					= Ptr;

CONST
	kMusicComponentType			= 'musi';

	kSoftSynthComponentSubType	= 'ss  ';
	kGMSynthComponentSubType	= 'gm  ';


TYPE
	MusicComponent						= ComponentInstance;
{  MusicSynthesizerFlags }

CONST
	kSynthesizerDynamicVoice	= $01;							{  can assign voices on the fly (else, polyphony is very important  }
	kSynthesizerUsesMIDIPort	= $02;							{  must be patched through MIDI Manager  }
	kSynthesizerMicrotone		= $04;							{  can play microtonal scales  }
	kSynthesizerHasSamples		= $08;							{  synthesizer has some use for sampled data  }
	kSynthesizerMixedDrums		= $10;							{  any part can play drum parts, total = instrument parts  }
	kSynthesizerSoftware		= $20;							{  implemented in main CPU software == uses cpu cycles  }
	kSynthesizerHardware		= $40;							{  is a hardware device (such as nubus, or maybe DSP?)  }
	kSynthesizerDynamicChannel	= $80;							{  can move any part to any channel or disable each part. (else we assume it lives on all channels in masks)  }
	kSynthesizerHogsSystemChannel = $0100;						{  can be channelwise dynamic, but always responds on its system channel  }
	kSynthesizerSlowSetPart		= $0400;						{  SetPart() and SetPartInstrumentNumber() calls do not have rapid response, may glitch notes  }
	kSynthesizerOffline			= $1000;						{  can enter an offline synthesis mode  }
	kSynthesizerGM				= $4000;						{  synth is a GM device  }
	kSynthesizerSoundLocalization = $00010000;					{  synth is a GM device  }

{
 * Note that these controller numbers
 * are _not_ identical to the MIDI controller numbers.
 * These are _signed_ 8.8 values, and the LSB's are
 * always sent to a MIDI device. Controllers 32-63 are
 * reserved (for MIDI, they are LSB's for 0-31, but we
 * always send both).
 *
 * The full range, therefore, is -128.00 to 127.7f.
 *
 * _Excepting_ _volume_, all controls default to zero.
 *
 * Pitch bend is specified in fractional semitones! No
 * more "pitch bend range" nonsense. You can bend as far
 * as you want, any time you want.
}

TYPE
	MusicController						= SInt32;

CONST
	kControllerModulationWheel	= 1;
	kControllerBreath			= 2;
	kControllerFoot				= 4;
	kControllerPortamentoTime	= 5;							{  portamento on/off is omitted, 0 time = 'off'  }
	kControllerVolume			= 7;
	kControllerBalance			= 8;
	kControllerPan				= 10;							{  0 - "default", 1 - n: positioned in output 1-n (incl fractions)  }
	kControllerExpression		= 11;
	kControllerLever1			= 16;							{  general purpose controllers  }
	kControllerLever2			= 17;							{  general purpose controllers  }
	kControllerLever3			= 18;							{  general purpose controllers  }
	kControllerLever4			= 19;							{  general purpose controllers  }
	kControllerLever5			= 80;							{  general purpose controllers  }
	kControllerLever6			= 81;							{  general purpose controllers  }
	kControllerLever7			= 82;							{  general purpose controllers  }
	kControllerLever8			= 83;							{  general purpose controllers  }
	kControllerPitchBend		= 32;							{  positive & negative semitones, with 7 bits fraction  }
	kControllerAfterTouch		= 33;							{  aka channel pressure  }
	kControllerSustain			= 64;							{  boolean - positive for on, 0 or negative off  }
	kControllerSostenuto		= 66;							{  boolean  }
	kControllerSoftPedal		= 67;							{  boolean  }
	kControllerReverb			= 91;
	kControllerTremolo			= 92;
	kControllerChorus			= 93;
	kControllerCeleste			= 94;
	kControllerPhaser			= 95;
	kControllerEditPart			= 113;							{  last 16 controllers 113-128 and above are global controllers which respond on part zero  }
	kControllerMasterTune		= 114;

	kControllerMaximum			= $7FFF;						{  +01111111.11111111  }
	kControllerMinimum			= $8000;						{  -10000000.00000000  }


TYPE
	SynthesizerDescriptionPtr = ^SynthesizerDescription;
	SynthesizerDescription = RECORD
		synthesizerType:		OSType;									{  synthesizer type (must be same as component subtype)  }
		name:					Str31;									{  text name of synthesizer type  }
		flags:					LONGINT;								{  from the above enum  }
		voiceCount:				LONGINT;								{  maximum polyphony  }
		partCount:				LONGINT;								{  maximum multi-timbrality (and midi channels)  }
		instrumentCount:		LONGINT;								{  non gm, built in (rom) instruments only  }
		modifiableInstrumentCount: LONGINT;								{  plus n-more are user modifiable  }
		channelMask:			LONGINT;								{  (midi device only) which channels device always uses  }
		drumPartCount:			LONGINT;								{  maximum multi-timbrality of drum parts  }
		drumCount:				LONGINT;								{  non gm, built in (rom) drumkits only  }
		modifiableDrumCount:	LONGINT;								{  plus n-more are user modifiable  }
		drumChannelMask:		LONGINT;								{  (midi device only) which channels device always uses  }
		outputCount:			LONGINT;								{  number of audio outputs (usually two)  }
		latency:				LONGINT;								{  response time in µSec  }
		controllers:			ARRAY [0..3] OF LONGINT;				{  array of 128 bits  }
		gmInstruments:			ARRAY [0..3] OF LONGINT;				{  array of 128 bits  }
		gmDrums:				ARRAY [0..3] OF LONGINT;				{  array of 128 bits  }
	END;


CONST
	kVoiceCountDynamic			= -1;							{  constant to use to specify dynamic voicing  }


TYPE
	ToneDescriptionPtr = ^ToneDescription;
	ToneDescription = RECORD
		synthesizerType:		OSType;									{  synthesizer type  }
		synthesizerName:		Str31;									{  name of instantiation of synth  }
		instrumentName:			Str31;									{  preferred name for human use  }
		instrumentNumber:		LONGINT;								{  inst-number used if synth-name matches  }
		gmNumber:				LONGINT;								{  Best matching general MIDI number  }
	END;


CONST
	kFirstDrumkit				= 16384;						{  (first value is "no drum". instrument numbers from 16384->16384+128 are drumkits, and for GM they are _defined_ drumkits!  }
	kLastDrumkit				= 16512;

{  InstrumentMatch }
	kInstrumentMatchSynthesizerType = 1;
	kInstrumentMatchSynthesizerName = 2;
	kInstrumentMatchName		= 4;
	kInstrumentMatchNumber		= 8;
	kInstrumentMatchGMNumber	= 16;

{  KnobFlags }
	kKnobReadOnly				= 16;							{  knob value cannot be changed by user or with a SetKnob call  }
	kKnobInterruptUnsafe		= 32;							{  only alter this knob from foreground task time (may access toolbox)  }
	kKnobKeyrangeOverride		= 64;							{  knob can be overridden within a single keyrange (software synth only)  }
	kKnobGroupStart				= 128;							{  knob is first in some logical group of knobs  }
	kKnobFixedPoint8			= 1024;
	kKnobFixedPoint16			= 2048;							{  One of these may be used at a time.  }
	kKnobTypeNumber				= $00;
	kKnobTypeGroupName			= $1000;						{  "knob" is really a group name for display purposes  }
	kKnobTypeBoolean			= $2000;						{  if range is greater than 1, its a multi-checkbox field  }
	kKnobTypeNote				= $3000;						{  knob range is equivalent to MIDI keys  }
	kKnobTypePan				= $4000;						{  range goes left/right (lose this? )  }
	kKnobTypeInstrument			= $5000;						{  knob value = reference to another instrument number  }
	kKnobTypeSetting			= $6000;						{  knob value is 1 of n different things (eg, fm algorithms) popup menu  }
	kKnobTypeMilliseconds		= $7000;						{  knob is a millisecond time range  }
	kKnobTypePercentage			= $8000;						{  knob range is displayed as a Percentage  }
	kKnobTypeHertz				= $9000;						{  knob represents frequency  }
	kKnobTypeButton				= $A000;						{  momentary trigger push button  }

	kUnknownKnobValue			= $7FFFFFFF;					{  a knob with this value means, we don't know it.  }
	kDefaultKnobValue			= $7FFFFFFE;					{  used to SET a knob to its default value.  }


TYPE
	KnobDescriptionPtr = ^KnobDescription;
	KnobDescription = RECORD
		name:					Str63;
		lowValue:				LONGINT;
		highValue:				LONGINT;
		defaultValue:			LONGINT;								{  a default instrument is made of all default values  }
		flags:					LONGINT;
		knobID:					LONGINT;
	END;

	GCInstrumentDataPtr = ^GCInstrumentData;
	GCInstrumentData = RECORD
		tone:					ToneDescription;
		knobCount:				LONGINT;
		knob:					ARRAY [0..0] OF LONGINT;
	END;

	GCInstrumentDataHandle				= ^GCInstrumentDataPtr;
	InstrumentAboutInfoPtr = ^InstrumentAboutInfo;
	InstrumentAboutInfo = RECORD
		p:						PicHandle;
		author:					Str255;
		copyright:				Str255;
		other:					Str255;
	END;


CONST
	kMusicPacketPortLost		= 1;							{  received when application loses the default input port  }
	kMusicPacketPortFound		= 2;							{  received when application gets it back out from under someone else's claim  }
	kMusicPacketTimeGap			= 3;							{  data[0] = number of milliseconds to keep the MIDI line silent  }


TYPE
	MusicMIDIPacketPtr = ^MusicMIDIPacket;
	MusicMIDIPacket = RECORD
		length:					INTEGER;
		reserved:				LONGINT;								{  if length zero, then reserved = above enum  }
		data:					PACKED ARRAY [0..248] OF UInt8;
	END;

	MusicMIDISendProcPtr = ProcPtr;  { FUNCTION MusicMIDISend(self: MusicComponent; refCon: LONGINT; VAR mmp: MusicMIDIPacket): ComponentResult; }

	MusicMIDISendUPP = UniversalProcPtr;
	MusicMIDIReadHookProcPtr = ProcPtr;  { FUNCTION MusicMIDIReadHook(VAR mp: MusicMIDIPacket; myRefCon: LONGINT): ComponentResult; }

	MusicMIDIReadHookUPP = UniversalProcPtr;

CONST
	notImplementedMusicErr		= $8000F7E9;
	cantSendToSynthesizerErr	= $8000F7E8;
	cantReceiveFromSynthesizerErr = $8000F7E7;
	illegalVoiceAllocationErr	= $8000F7E6;
	illegalPartErr				= $8000F7E5;
	illegalChannelErr			= $8000F7E4;
	illegalKnobErr				= $8000F7E3;
	illegalKnobValueErr			= $8000F7E2;
	illegalInstrumentErr		= $8000F7E1;
	illegalControllerErr		= $8000F7E0;
	midiManagerAbsentErr		= $8000F7DF;
	synthesizerNotRespondingErr	= $8000F7DE;
	synthesizerErr				= $8000F7DD;
	illegalNoteChannelErr		= $8000F7DC;
	noteChannelNotAllocatedErr	= $8000F7DB;
	tunePlayerFullErr			= $8000F7DA;
	tuneParseErr				= $8000F7D9;

	kGetAtomicInstNoExpandedSamples = $01;
	kGetAtomicInstNoOriginalSamples = $02;
	kGetAtomicInstNoSamples		= $03;
	kGetAtomicInstNoKnobList	= $04;
	kGetAtomicInstNoInstrumentInfo = $08;
	kGetAtomicInstOriginalKnobList = $10;
	kGetAtomicInstAllKnobs		= $20;							{  return even those that are set to default }

{
 For non-gm instruments, instrument number of tone description == 0
 If you want to speed up while running, slam the inst num with what Get instrument number returns
 All missing knobs are slammed to the default value
}
	kSetAtomicInstKeepOriginalInstrument = $01;
	kSetAtomicInstShareAcrossParts = $02;						{  inst disappears when app goes away }
	kSetAtomicInstCallerTosses	= $04;							{  the caller isn't keeping a copy around (for NASetAtomicInstrument) }
	kSetAtomicInstCallerGuarantees = $08;						{  the caller guarantees a copy is around }
	kSetAtomicInstInterruptSafe	= $10;							{  dont move memory at this time (but process at next task time) }
	kSetAtomicInstDontPreprocess = $80;							{  perform no further preprocessing because either 1)you know the instrument is digitally clean, or 2) you got it from a GetPartAtomic }

	kInstrumentNamesModifiable	= 1;
	kInstrumentNamesBoth		= 2;

{
 * Structures specific to the GenericMusicComponent
}
	kGenericMusicComponentSubtype = 'gene';


TYPE
	GenericKnobDescriptionPtr = ^GenericKnobDescription;
	GenericKnobDescription = RECORD
		kd:						KnobDescription;
		hw1:					LONGINT;								{  driver defined  }
		hw2:					LONGINT;								{  driver defined  }
		hw3:					LONGINT;								{  driver defined  }
		settingsID:				LONGINT;								{  resource ID list for boolean and popup names  }
	END;

	GenericKnobDescriptionListPtr = ^GenericKnobDescriptionList;
	GenericKnobDescriptionList = RECORD
		knobCount:				LONGINT;
		knob:					ARRAY [0..0] OF GenericKnobDescription;
	END;

	GenericKnobDescriptionListHandle	= ^GenericKnobDescriptionListPtr;
{  knobTypes for MusicDerivedSetKnob  }

CONST
	kGenericMusicKnob			= 1;
	kGenericMusicInstrumentKnob	= 2;
	kGenericMusicDrumKnob		= 3;
	kGenericMusicGlobalController = 4;

	kGenericMusicResFirst		= 0;
	kGenericMusicResMiscStringList = 1;							{  STR# 1: synth name, 2:about author,3:aboutcopyright,4:aboutother  }
	kGenericMusicResMiscLongList = 2;							{  Long various params, see list below  }
	kGenericMusicResInstrumentList = 3;							{  NmLs of names and shorts, categories prefixed by '••'  }
	kGenericMusicResDrumList	= 4;							{  NmLs of names and shorts  }
	kGenericMusicResInstrumentKnobDescriptionList = 5;			{  Knob  }
	kGenericMusicResDrumKnobDescriptionList = 6;				{  Knob  }
	kGenericMusicResKnobDescriptionList = 7;					{  Knob  }
	kGenericMusicResBitsLongList = 8;							{  Long back to back bitmaps of controllers, gminstruments, and drums  }
	kGenericMusicResModifiableInstrumentHW = 9;					{  Shrt same as the hw shorts trailing the instrument names, a shortlist  }
	kGenericMusicResGMTranslation = 10;							{  Long 128 long entries, 1 for each gm inst, of local instrument numbers 1-n (not hw numbers)  }
	kGenericMusicResROMInstrumentData = 11;						{  knob lists for ROM instruments, so the knob values may be known  }
	kGenericMusicResAboutPICT	= 12;							{  picture for aboutlist. must be present for GetAbout call to work  }
	kGenericMusicResLast		= 13;

{  elements of the misc long list  }
	kGenericMusicMiscLongFirst	= 0;
	kGenericMusicMiscLongVoiceCount = 1;
	kGenericMusicMiscLongPartCount = 2;
	kGenericMusicMiscLongModifiableInstrumentCount = 3;
	kGenericMusicMiscLongChannelMask = 4;
	kGenericMusicMiscLongDrumPartCount = 5;
	kGenericMusicMiscLongModifiableDrumCount = 6;
	kGenericMusicMiscLongDrumChannelMask = 7;
	kGenericMusicMiscLongOutputCount = 8;
	kGenericMusicMiscLongLatency = 9;
	kGenericMusicMiscLongFlags	= 10;
	kGenericMusicMiscLongFirstGMHW = 11;						{  number to add to locate GM main instruments  }
	kGenericMusicMiscLongFirstGMDrumHW = 12;					{  number to add to locate GM drumkits  }
	kGenericMusicMiscLongFirstUserHW = 13;						{  First hw number of user instruments (presumed sequential)  }
	kGenericMusicMiscLongLast	= 14;


TYPE
	GCPartPtr = ^GCPart;
	GCPart = RECORD
		hwInstrumentNumber:		LONGINT;								{  internal number of recalled instrument  }
		controller:				ARRAY [0..127] OF INTEGER;				{  current values for all controllers  }
		volume:					LONGINT;								{  ctrl 7 is special case  }
		polyphony:				LONGINT;
		midiChannel:			LONGINT;								{  1-16 if in use  }
		id:						GCInstrumentData;						{  ToneDescription & knoblist, uncertain length  }
	END;

{
 * Calls specific to the GenericMusicComponent
}

CONST
	kMusicGenericRange			= $0100;
	kMusicDerivedRange			= $0200;

{
 * Flags in GenericMusicConfigure call
}
	kGenericMusicDoMIDI			= $01;							{  implement normal MIDI messages for note, controllers, and program changes 0-127  }
	kGenericMusicBank0			= $02;							{  implement instrument bank changes on controller 0  }
	kGenericMusicBank32			= $04;							{  implement instrument bank changes on controller 32  }
	kGenericMusicErsatzMIDI		= $08;							{  construct MIDI packets, but send them to the derived component  }
	kGenericMusicCallKnobs		= $10;							{  call the derived component with special knob format call  }
	kGenericMusicCallParts		= $20;							{  call the derived component with special part format call  }
	kGenericMusicCallInstrument	= $40;							{  call MusicDerivedSetInstrument for MusicSetInstrument calls  }
	kGenericMusicCallNumber		= $80;							{  call MusicDerivedSetPartInstrumentNumber for MusicSetPartInstrumentNumber calls, & don't send any C0 or bank stuff  }
	kGenericMusicCallROMInstrument = $0100;						{  call MusicSetInstrument for MusicSetPartInstrumentNumber for "ROM" instruments, passing params from the ROMi resource  }
	kGenericMusicAllDefaults	= $0200;						{  indicates that when a new instrument is recalled, all knobs are reset to DEFAULT settings. True for GS modules  }


TYPE
	MusicOfflineDataProcPtr = ProcPtr;  { FUNCTION MusicOfflineData(SoundData: Ptr; numBytes: LONGINT; myRefCon: LONGINT): ComponentResult; }

	MusicOfflineDataUPP = UniversalProcPtr;

TYPE
	OfflineSampleTypePtr = ^OfflineSampleType;
	OfflineSampleType = RECORD
		numChannels:			LONGINT;								{ number of channels,  ie mono = 1 }
		sampleRate:				UnsignedFixed;							{ sample rate in Apples Fixed point representation }
		sampleSize:				INTEGER;								{ number of bits in sample }
	END;


TYPE
	InstrumentInfoRecordPtr = ^InstrumentInfoRecord;
	InstrumentInfoRecord = RECORD
		instrumentNumber:		LONGINT;								{  instrument number (if 0, name is a catagory) }
		flags:					LONGINT;								{  show in picker, etc. }
		toneNameIndex:			LONGINT;								{  index in toneNames (1 based) }
		itxtNameAtomID:			LONGINT;								{  index in itxtNames (itxt/name by index) }
	END;

	InstrumentInfoListPtr = ^InstrumentInfoList;
	InstrumentInfoList = RECORD
		recordCount:			LONGINT;
		toneNames:				Handle;									{  name from tone description }
		itxtNames:				QTAtomContainer;						{  itxt/name atoms for instruments }
		info:					ARRAY [0..0] OF InstrumentInfoRecord;
	END;

	InstrumentInfoListHandle			= ^InstrumentInfoListPtr;
FUNCTION MusicGetDescription(mc: MusicComponent; VAR sd: SynthesizerDescription): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetPart(mc: MusicComponent; part: LONGINT; VAR midiChannel: LONGINT; VAR polyphony: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION MusicSetPart(mc: MusicComponent; part: LONGINT; midiChannel: LONGINT; polyphony: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION MusicSetPartInstrumentNumber(mc: MusicComponent; part: LONGINT; instrumentNumber: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetPartInstrumentNumber(mc: MusicComponent; part: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION MusicStorePartInstrument(mc: MusicComponent; part: LONGINT; instrumentNumber: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetPartAtomicInstrument(mc: MusicComponent; part: LONGINT; VAR ai: AtomicInstrument; flags: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION MusicSetPartAtomicInstrument(mc: MusicComponent; part: LONGINT; aiP: AtomicInstrumentPtr; flags: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $000A, $7000, $A82A;
	{$ENDC}
{  Obsolete calls }
FUNCTION MusicGetInstrumentKnobDescriptionObsolete(mc: MusicComponent; knobIndex: LONGINT; mkd: UNIV Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetDrumKnobDescriptionObsolete(mc: MusicComponent; knobIndex: LONGINT; mkd: UNIV Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetKnobDescriptionObsolete(mc: MusicComponent; knobIndex: LONGINT; mkd: UNIV Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetPartKnob(mc: MusicComponent; part: LONGINT; knobID: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION MusicSetPartKnob(mc: MusicComponent; part: LONGINT; knobID: LONGINT; knobValue: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetKnob(mc: MusicComponent; knobID: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION MusicSetKnob(mc: MusicComponent; knobID: LONGINT; knobValue: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0013, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetPartName(mc: MusicComponent; part: LONGINT; name: StringPtr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0014, $7000, $A82A;
	{$ENDC}
FUNCTION MusicSetPartName(mc: MusicComponent; part: LONGINT; name: StringPtr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0015, $7000, $A82A;
	{$ENDC}
FUNCTION MusicFindTone(mc: MusicComponent; VAR td: ToneDescription; VAR instrumentNumber: LONGINT; VAR fit: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0016, $7000, $A82A;
	{$ENDC}
FUNCTION MusicPlayNote(mc: MusicComponent; part: LONGINT; pitch: LONGINT; velocity: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0017, $7000, $A82A;
	{$ENDC}
FUNCTION MusicResetPart(mc: MusicComponent; part: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}
FUNCTION MusicSetPartController(mc: MusicComponent; part: LONGINT; controllerNumber: MusicController; controllerValue: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0019, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetPartController(mc: MusicComponent; part: LONGINT; controllerNumber: MusicController): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $001A, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetMIDIProc(mc: MusicComponent; VAR midiSendProc: MusicMIDISendUPP; VAR refCon: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $001B, $7000, $A82A;
	{$ENDC}
FUNCTION MusicSetMIDIProc(mc: MusicComponent; midiSendProc: MusicMIDISendUPP; refCon: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $001C, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetInstrumentNames(mc: MusicComponent; modifiableInstruments: LONGINT; VAR instrumentNames: Handle; VAR instrumentCategoryLasts: Handle; VAR instrumentCategoryNames: Handle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0010, $001D, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetDrumNames(mc: MusicComponent; modifiableInstruments: LONGINT; VAR instrumentNumbers: Handle; VAR instrumentNames: Handle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $001E, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetMasterTune(mc: MusicComponent): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $001F, $7000, $A82A;
	{$ENDC}
FUNCTION MusicSetMasterTune(mc: MusicComponent; masterTune: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0020, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetInstrumentAboutInfo(mc: MusicComponent; part: LONGINT; VAR iai: InstrumentAboutInfo): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0022, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetDeviceConnection(mc: MusicComponent; index: LONGINT; VAR id1: LONGINT; VAR id2: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0023, $7000, $A82A;
	{$ENDC}
FUNCTION MusicUseDeviceConnection(mc: MusicComponent; id1: LONGINT; id2: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0024, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetKnobSettingStrings(mc: MusicComponent; knobIndex: LONGINT; isGlobal: LONGINT; VAR settingsNames: Handle; VAR settingsCategoryLasts: Handle; VAR settingsCategoryNames: Handle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0014, $0025, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetMIDIPorts(mc: MusicComponent; VAR inputPortCount: LONGINT; VAR outputPortCount: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0026, $7000, $A82A;
	{$ENDC}
FUNCTION MusicSendMIDI(mc: MusicComponent; portIndex: LONGINT; VAR mp: MusicMIDIPacket): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0027, $7000, $A82A;
	{$ENDC}
FUNCTION MusicReceiveMIDI(mc: MusicComponent; readHook: MusicMIDIReadHookUPP; refCon: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0028, $7000, $A82A;
	{$ENDC}
FUNCTION MusicStartOffline(mc: MusicComponent; VAR numChannels: LONGINT; VAR sampleRate: UnsignedFixed; VAR sampleSize: INTEGER; dataProc: MusicOfflineDataUPP; dataProcRefCon: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0014, $0029, $7000, $A82A;
	{$ENDC}
FUNCTION MusicSetOfflineTimeTo(mc: MusicComponent; newTimeStamp: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $002A, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetInstrumentKnobDescription(mc: MusicComponent; knobIndex: LONGINT; VAR mkd: KnobDescription): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $002B, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetDrumKnobDescription(mc: MusicComponent; knobIndex: LONGINT; VAR mkd: KnobDescription): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $002C, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetKnobDescription(mc: MusicComponent; knobIndex: LONGINT; VAR mkd: KnobDescription): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $002D, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGetInfoText(mc: MusicComponent; selector: LONGINT; VAR textH: Handle; VAR styleH: Handle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $002E, $7000, $A82A;
	{$ENDC}

CONST
	kGetInstrumentInfoNoBuiltIn	= $01;
	kGetInstrumentInfoMidiUserInst = $02;
	kGetInstrumentInfoNoIText	= $04;

FUNCTION MusicGetInstrumentInfo(mc: MusicComponent; getInstrumentInfoFlags: LONGINT; VAR infoListH: InstrumentInfoListHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $002F, $7000, $A82A;
	{$ENDC}
FUNCTION MusicTask(mc: MusicComponent): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0031, $7000, $A82A;
	{$ENDC}
FUNCTION MusicSetPartInstrumentNumberInterruptSafe(mc: MusicComponent; part: LONGINT; instrumentNumber: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0032, $7000, $A82A;
	{$ENDC}
FUNCTION MusicSetPartSoundLocalization(mc: MusicComponent; part: LONGINT; data: Handle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0033, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGenericConfigure(mc: MusicComponent; mode: LONGINT; flags: LONGINT; baseResID: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGenericGetPart(mc: MusicComponent; partNumber: LONGINT; VAR part: GCPartPtr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION MusicGenericGetKnobList(mc: MusicComponent; knobType: LONGINT; VAR gkdlH: GenericKnobDescriptionListHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION MusicDerivedMIDISend(mc: MusicComponent; VAR packet: MusicMIDIPacket): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0200, $7000, $A82A;
	{$ENDC}
FUNCTION MusicDerivedSetKnob(mc: MusicComponent; knobType: LONGINT; knobNumber: LONGINT; knobValue: LONGINT; partNumber: LONGINT; VAR p: GCPart; VAR gkd: GenericKnobDescription): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0018, $0201, $7000, $A82A;
	{$ENDC}
FUNCTION MusicDerivedSetPart(mc: MusicComponent; partNumber: LONGINT; VAR p: GCPart): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0202, $7000, $A82A;
	{$ENDC}
FUNCTION MusicDerivedSetInstrument(mc: MusicComponent; partNumber: LONGINT; VAR p: GCPart): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0203, $7000, $A82A;
	{$ENDC}
FUNCTION MusicDerivedSetPartInstrumentNumber(mc: MusicComponent; partNumber: LONGINT; VAR p: GCPart): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0204, $7000, $A82A;
	{$ENDC}
FUNCTION MusicDerivedSetMIDI(mc: MusicComponent; midiProc: MusicMIDISendProcPtr; refcon: LONGINT; midiChannel: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0205, $7000, $A82A;
	{$ENDC}
FUNCTION MusicDerivedStorePartInstrument(mc: MusicComponent; partNumber: LONGINT; VAR p: GCPart; instrumentNumber: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0206, $7000, $A82A;
	{$ENDC}
{  Mask bit for returned value by InstrumentFind. }

CONST
	kInstrumentExactMatch		= $00020000;
	kInstrumentRecommendedSubstitute = $00010000;
	kInstrumentQualityField		= $FF000000;
	kInstrumentRoland8BitQuality = $05000000;


TYPE
	InstrumentAboutInfoHandle			= ^InstrumentAboutInfoPtr;
	GMInstrumentInfoPtr = ^GMInstrumentInfo;
	GMInstrumentInfo = RECORD
		cmpInstID:				LONGINT;
		gmInstNum:				LONGINT;
		instMatch:				LONGINT;
	END;

	GMInstrumentInfoHandle				= ^GMInstrumentInfoPtr;
	nonGMInstrumentInfoRecordPtr = ^nonGMInstrumentInfoRecord;
	nonGMInstrumentInfoRecord = RECORD
		cmpInstID:				LONGINT;								{  if 0, category name }
		flags:					LONGINT;								{  match, show in picker }
		toneNameIndex:			LONGINT;								{  index in toneNames (1 based) }
		itxtNameAtomID:			LONGINT;								{  index in itxtNames (itxt/name by index) }
	END;

	nonGMInstrumentInfoPtr = ^nonGMInstrumentInfo;
	nonGMInstrumentInfo = RECORD
		recordCount:			LONGINT;
		toneNames:				Handle;									{  name from tone description }
		itxtNames:				QTAtomContainer;						{  itext/name atoms for instruments }
		instInfo:				ARRAY [0..0] OF nonGMInstrumentInfoRecord;
	END;

	nonGMInstrumentInfoHandle			= ^nonGMInstrumentInfoPtr;
	InstCompInfoPtr = ^InstCompInfo;
	InstCompInfo = RECORD
		infoSize:				LONGINT;								{  size of this record }
		InstrumentLibraryName:	Str31;
		InstrumentLibraryITxt:	QTAtomContainer;						{  itext/name atoms for instruments }
		GMinstrumentCount:		LONGINT;
		GMinstrumentInfo:		GMInstrumentInfoHandle;
		GMdrumCount:			LONGINT;
		GMdrumInfo:				GMInstrumentInfoHandle;
		nonGMinstrumentCount:	LONGINT;
		nonGMinstrumentInfo:	nonGMInstrumentInfoHandle;
	END;

	InstCompInfoHandle					= ^InstCompInfoPtr;
FUNCTION InstrumentGetInst(ci: ComponentInstance; instID: LONGINT; VAR atomicInst: AtomicInstrument; flags: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION InstrumentGetInfo(ci: ComponentInstance; getInstrumentInfoFlags: LONGINT; VAR instInfo: InstCompInfoHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION InstrumentInitialize(ci: ComponentInstance; initFormat: LONGINT; initParams: UNIV Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION InstrumentOpenComponentResFile(ci: ComponentInstance; VAR resFile: INTEGER): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION InstrumentCloseComponentResFile(ci: ComponentInstance; resFile: INTEGER): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0002, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION InstrumentGetComponentRefCon(ci: ComponentInstance; VAR refCon: UNIV Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION InstrumentSetComponentRefCon(ci: ComponentInstance; refCon: UNIV Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
{
--------------------------
	Types
--------------------------
}

CONST
	kSynthesizerConnectionMono	= 1;							{  if set, and synth can be mono/poly, then the partCount channels from the system channel are hogged  }
	kSynthesizerConnectionMMgr	= 2;							{  this connection imported from the MIDI Mgr  }
	kSynthesizerConnectionOMS	= 4;							{  this connection imported from OMS  }
	kSynthesizerConnectionQT	= 8;							{  this connection is a QuickTime-only port  }
	kSynthesizerConnectionFMS	= 16;							{  this connection imported from FMS  }

{  used for MIDI device only  }

TYPE
	SynthesizerConnectionsPtr = ^SynthesizerConnections;
	SynthesizerConnections = RECORD
		clientID:				OSType;
		inputPortID:			OSType;									{  terminology death: this port is used to SEND to the midi synth  }
		outputPortID:			OSType;									{  terminology death: this port receives from a keyboard or other control device  }
		midiChannel:			LONGINT;								{  The system channel; others are configurable (or the nubus slot number)  }
		flags:					LONGINT;
		unique:					LONGINT;								{  unique id may be used instead of index, to getinfo and unregister calls  }
		reserved1:				LONGINT;								{  should be zero  }
		reserved2:				LONGINT;								{  should be zero  }
	END;

	QTMIDIPortPtr = ^QTMIDIPort;
	QTMIDIPort = RECORD
		portConnections:		SynthesizerConnections;
		portName:				Str63;
	END;


CONST
	kNoteRequestNoGM			= 1;							{  dont degrade to a GM synth  }
	kNoteRequestNoSynthType		= 2;							{  dont degrade to another synth of same type but different name  }
	kNoteRequestSynthMustMatch	= 4;							{  synthType must be a match, including kGMSynthComponentSubType  }


TYPE
	NoteAllocator						= ComponentInstance;
	NoteRequestInfoPtr = ^NoteRequestInfo;
	NoteRequestInfo = RECORD
		flags:					SInt8;									{  1: dont accept GM match, 2: dont accept same-synth-type match  }
		reserved:				SInt8;									{  must be zero  }
		polyphony:				INTEGER;								{  Maximum number of voices  }
		typicalPolyphony:		Fixed;									{  Hint for level mixing  }
	END;

	NoteRequestPtr = ^NoteRequest;
	NoteRequest = RECORD
		info:					NoteRequestInfo;
		tone:					ToneDescription;
	END;

	NoteChannel = ^LONGINT;

CONST
	kPickDontMix				= 1;							{  dont mix instruments with drum sounds  }
	kPickSameSynth				= 2;							{  only allow the same device that went in, to come out  }
	kPickUserInsts				= 4;							{  show user insts in addition to ROM voices  }
	kPickEditAllowEdit			= 8;							{  lets user switch over to edit mode  }
	kPickEditAllowPick			= 16;							{  lets the user switch over to pick mode  }
	kPickEditSynthGlobal		= 32;							{  edit the global knobs of the synth  }
	kPickEditControllers		= 64;							{  edit the controllers of the notechannel  }

	kNoteAllocatorComponentType	= 'nota';

{
--------------------------------
	Note Allocator Prototypes
--------------------------------
}
FUNCTION NARegisterMusicDevice(ci: NoteAllocator; synthType: OSType; VAR name: Str31; VAR connections: SynthesizerConnections): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0000, $7000, $A82A;
	{$ENDC}
FUNCTION NAUnregisterMusicDevice(ci: NoteAllocator; index: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION NAGetRegisteredMusicDevice(ci: NoteAllocator; index: LONGINT; VAR synthType: OSType; VAR name: Str31; VAR connections: SynthesizerConnections; VAR mc: MusicComponent): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0014, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION NASaveMusicConfiguration(ci: NoteAllocator): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION NANewNoteChannel(ci: NoteAllocator; VAR noteRequest: NoteRequest; VAR outChannel: NoteChannel): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION NADisposeNoteChannel(ci: NoteAllocator; noteChannel: NoteChannel): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION NAGetNoteChannelInfo(ci: NoteAllocator; noteChannel: NoteChannel; VAR index: LONGINT; VAR part: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION NAPrerollNoteChannel(ci: NoteAllocator; noteChannel: NoteChannel): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION NAUnrollNoteChannel(ci: NoteAllocator; noteChannel: NoteChannel): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION NASetNoteChannelVolume(ci: NoteAllocator; noteChannel: NoteChannel; volume: Fixed): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION NAResetNoteChannel(ci: NoteAllocator; noteChannel: NoteChannel): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION NAPlayNote(ci: NoteAllocator; noteChannel: NoteChannel; pitch: LONGINT; velocity: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION NASetController(ci: NoteAllocator; noteChannel: NoteChannel; controllerNumber: LONGINT; controllerValue: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION NASetKnob(ci: NoteAllocator; noteChannel: NoteChannel; knobNumber: LONGINT; knobValue: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION NAFindNoteChannelTone(ci: NoteAllocator; noteChannel: NoteChannel; VAR td: ToneDescription; VAR instrumentNumber: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION NASetInstrumentNumber(ci: NoteAllocator; noteChannel: NoteChannel; instrumentNumber: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION NAPickInstrument(ci: NoteAllocator; filterProc: ModalFilterUPP; prompt: StringPtr; VAR sd: ToneDescription; flags: LONGINT; refCon: LONGINT; reserved1: LONGINT; reserved2: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $001C, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION NAPickArrangement(ci: NoteAllocator; filterProc: ModalFilterUPP; prompt: StringPtr; zero1: LONGINT; zero2: LONGINT; t: Track; songName: StringPtr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0018, $0013, $7000, $A82A;
	{$ENDC}
FUNCTION NASetDefaultMIDIInput(ci: NoteAllocator; VAR sc: SynthesizerConnections): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0015, $7000, $A82A;
	{$ENDC}
FUNCTION NAGetDefaultMIDIInput(ci: NoteAllocator; VAR sc: SynthesizerConnections): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0016, $7000, $A82A;
	{$ENDC}
FUNCTION NAUseDefaultMIDIInput(ci: NoteAllocator; readHook: MusicMIDIReadHookUPP; refCon: LONGINT; flags: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0019, $7000, $A82A;
	{$ENDC}
FUNCTION NALoseDefaultMIDIInput(ci: NoteAllocator): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $001A, $7000, $A82A;
	{$ENDC}
FUNCTION NAStuffToneDescription(ci: NoteAllocator; gmNumber: LONGINT; VAR td: ToneDescription): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $001B, $7000, $A82A;
	{$ENDC}
FUNCTION NACopyrightDialog(ci: NoteAllocator; p: PicHandle; author: StringPtr; copyright: StringPtr; other: StringPtr; title: StringPtr; filterProc: ModalFilterUPP; refCon: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $001C, $001C, $7000, $A82A;
	{$ENDC}
{
	kNADummyOneSelect = 29
	kNADummyTwoSelect = 30
}
FUNCTION NAGetIndNoteChannel(ci: NoteAllocator; index: LONGINT; VAR nc: NoteChannel; VAR seed: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $001F, $7000, $A82A;
	{$ENDC}
FUNCTION NAGetMIDIPorts(ci: NoteAllocator; VAR inputPorts: Handle; VAR outputPorts: Handle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0021, $7000, $A82A;
	{$ENDC}
FUNCTION NAGetNoteRequest(ci: NoteAllocator; noteChannel: NoteChannel; VAR nrOut: NoteRequest): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0022, $7000, $A82A;
	{$ENDC}
FUNCTION NASendMIDI(ci: NoteAllocator; noteChannel: NoteChannel; VAR mp: MusicMIDIPacket): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0023, $7000, $A82A;
	{$ENDC}
FUNCTION NAPickEditInstrument(ci: NoteAllocator; filterProc: ModalFilterUPP; prompt: StringPtr; refCon: LONGINT; nc: NoteChannel; ai: AtomicInstrument; flags: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0018, $0024, $7000, $A82A;
	{$ENDC}
FUNCTION NANewNoteChannelFromAtomicInstrument(ci: NoteAllocator; instrument: AtomicInstrumentPtr; flags: LONGINT; VAR outChannel: NoteChannel): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0025, $7000, $A82A;
	{$ENDC}
FUNCTION NASetAtomicInstrument(ci: NoteAllocator; noteChannel: NoteChannel; instrument: AtomicInstrumentPtr; flags: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0026, $7000, $A82A;
	{$ENDC}
FUNCTION NAGetKnob(ci: NoteAllocator; noteChannel: NoteChannel; knobNumber: LONGINT; VAR knobValue: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0028, $7000, $A82A;
	{$ENDC}
FUNCTION NATask(ci: NoteAllocator): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0029, $7000, $A82A;
	{$ENDC}
FUNCTION NASetNoteChannelBalance(ci: NoteAllocator; noteChannel: NoteChannel; balance: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $002A, $7000, $A82A;
	{$ENDC}
FUNCTION NASetInstrumentNumberInterruptSafe(ci: NoteAllocator; noteChannel: NoteChannel; instrumentNumber: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $002B, $7000, $A82A;
	{$ENDC}
FUNCTION NASetNoteChannelSoundLocalization(ci: NoteAllocator; noteChannel: NoteChannel; data: Handle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $002C, $7000, $A82A;
	{$ENDC}

CONST
	kTuneQueueDepth				= 8;							{  Deepest you can queue tune segments  }


TYPE
	TuneStatusPtr = ^TuneStatus;
	TuneStatus = RECORD
		tune:					LongintPtr;								{  currently playing tune  }
		tunePtr:				LongintPtr;								{  position within currently playing piece  }
		time:					TimeValue;								{  current tune time  }
		queueCount:				INTEGER;								{  how many pieces queued up?  }
		queueSpots:				INTEGER;								{  How many more tunepieces can be queued  }
		queueTime:				TimeValue;								{  How much time is queued up? (can be very inaccurate)  }
		reserved:				ARRAY [0..2] OF LONGINT;
	END;

	TuneCallBackProcPtr = ProcPtr;  { PROCEDURE TuneCallBack((CONST)VAR status: TuneStatus; refCon: LONGINT); }

	TunePlayCallBackProcPtr = ProcPtr;  { PROCEDURE TunePlayCallBack(VAR event: LONGINT; seed: LONGINT; refCon: LONGINT); }

	TuneCallBackUPP = UniversalProcPtr;
	TunePlayCallBackUPP = UniversalProcPtr;
	TunePlayer							= ComponentInstance;

CONST
	kTunePlayerType				= 'tune';

FUNCTION TuneSetHeader(tp: TunePlayer; VAR header: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION TuneGetTimeBase(tp: TunePlayer; VAR tb: TimeBase): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION TuneSetTimeScale(tp: TunePlayer; scale: TimeScale): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION TuneGetTimeScale(tp: TunePlayer; VAR scale: TimeScale): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION TuneGetIndexedNoteChannel(tp: TunePlayer; i: LONGINT; VAR nc: NoteChannel): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0008, $7000, $A82A;
	{$ENDC}
{  Values for when to start.  }

CONST
	kTuneStartNow				= 1;							{  start after buffer is implied  }
	kTuneDontClipNotes			= 2;							{  allow notes to finish their durations outside sample  }
	kTuneExcludeEdgeNotes		= 4;							{  dont play notes that start at end of tune  }
	kTuneQuickStart				= 8;							{  Leave all the controllers where they are, ignore start time  }
	kTuneLoopUntil				= 16;							{  loop a queued tune if there's nothing else in the queue  }
	kTuneStartNewMaster			= 16384;

FUNCTION TuneQueue(tp: TunePlayer; VAR tune: LONGINT; tuneRate: Fixed; tuneStartPosition: LONGINT; tuneStopPosition: LONGINT; queueFlags: LONGINT; callBackProc: TuneCallBackUPP; refCon: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $001C, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION TuneInstant(tp: TunePlayer; tune: UNIV Ptr; tunePosition: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION TuneGetStatus(tp: TunePlayer; VAR status: TuneStatus): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}
{  Values for stopping.  }

CONST
	kTuneStopFade				= 1;							{  do a quick, synchronous fadeout  }
	kTuneStopSustain			= 2;							{  don't silece notes  }
	kTuneStopInstant			= 4;							{  silence notes fast (else, decay them)  }
	kTuneStopReleaseChannels	= 8;							{  afterwards, let the channels go  }

FUNCTION TuneStop(tp: TunePlayer; stopFlags: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION TuneSetVolume(tp: TunePlayer; volume: Fixed): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION TuneGetVolume(tp: TunePlayer): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION TunePreroll(tp: TunePlayer): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION TuneUnroll(tp: TunePlayer): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0013, $7000, $A82A;
	{$ENDC}
FUNCTION TuneSetNoteChannels(tp: TunePlayer; count: LONGINT; VAR noteChannelList: NoteChannel; playCallBackProc: TunePlayCallBackUPP; refCon: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0010, $0014, $7000, $A82A;
	{$ENDC}
FUNCTION TuneSetPartTranspose(tp: TunePlayer; part: LONGINT; transpose: LONGINT; velocityShift: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0015, $7000, $A82A;
	{$ENDC}
FUNCTION TuneGetNoteAllocator(tp: TunePlayer): NoteAllocator;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0017, $7000, $A82A;
	{$ENDC}
FUNCTION TuneSetSofter(tp: TunePlayer; softer: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}
FUNCTION TuneTask(tp: TunePlayer): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0019, $7000, $A82A;
	{$ENDC}
FUNCTION TuneSetBalance(tp: TunePlayer; balance: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $001A, $7000, $A82A;
	{$ENDC}
FUNCTION TuneSetSoundLocalization(tp: TunePlayer; data: Handle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $001B, $7000, $A82A;
	{$ENDC}
FUNCTION TuneSetHeaderWithSize(tp: TunePlayer; VAR header: LONGINT; size: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $001C, $7000, $A82A;
	{$ENDC}

TYPE
	MusicOpWord							= LONGINT;
	MusicOpWordPtr						= ^LONGINT;
{
 	QuickTime Music Track Event Formats:

	At this time, QuickTime music tracks support 5 different event types -- REST events,
	short NOTE events, short CONTROL events, short GENERAL events, Long NOTE events, 
	long CONTROL events, and variable GENERAL events.
 
		• REST Event (4 bytes/event):
	
			(0 0 0) (5-bit UNUSED) (24-bit Rest Duration)
		
		• Short NOTE Events (4 bytes/event):
	
			(0 0 1) (5-bit Part) (6-bit Pitch) (7-bit Volume) (11-bit Duration)
		
			where:	Pitch is offset by 32 (Actual pitch = pitch field + 32)

		• Short CONTROL Events (4 bytes/event):
	
			(0 1 0) (5-bit Part) (8-bit Controller) (1-bit UNUSED) (1-bit Sign) (7-bit MSB) (7-bit LSB)
																		 ( or 15-bit Signed Value)
		• Short GENERAL Event (4 bytes/event):
	
			(0 1 1) (1-bit UNUSED) (12-bit Sub-Type) (16-bit Value)
	
		• Long NOTE Events (8 bytes/event):
	
			(1 0 0 1) (12-bit Part) (1-bit UNUSED) (7-bit Pitch) (1-bit UNUSED) (7-bit Volume)
			(1 0) (8-bit UNUSED) (22-bit Duration)
		
		• Long CONTROL Event (8 bytes/event):
		
			(1 0 1 0) (12-bit Part) (16-bit Value MSB) 
			(1 0) (14-bit Controller) (16-bit Value LSB)
	
		• Long KNOB Event (8 bytes/event):
	
			(1 0 1 1) (12-bit Sub-Type) (16-bit Value MSB)
			(1 0) (14-bit KNOB) (16-bit Value LSB)
	
		• Variable GENERAL Length Events (N bytes/event):
	
			(1 1 1 1) (12-bit Sub-Type) (16-bit Length)
				:
			(32-bit Data values)
				:
			(1 1) (14-bit UNUSED) (16-bit Length)
	
			where:	Length field is the number of LONG words in the record.
					Lengths include the first and last long words (Minimum length = 2)
				
	The following event type values have not been used yet and are reserved for 
	future expansion:
		
		• (1 0 0 0)		(8 bytes/event)
		• (1 1 0 0)		(N bytes/event)
		• (1 1 0 1)		(N bytes/event)
		• (1 1 1 0)		(N bytes/event)
		
	For all events, the following generalizations apply:
	
		-	All duration values are specified in Millisecond units.
		- 	Pitch values are intended to map directly to the MIDI key numbers.
		-	Controllers from 0 to 127 correspond to the standard MIDI controllers.
			Controllers greater than 127 correspond to other controls (i.e., Pitch Bend, 
			Key Pressure, and Channel Pressure).	
}
{  Defines for the implemented music event data fields }

CONST
	kRestEventType				= $00000000;					{  lower 3-bits  }
	kNoteEventType				= $00000001;					{  lower 3-bits  }
	kControlEventType			= $00000002;					{  lower 3-bits  }
	kMarkerEventType			= $00000003;					{  lower 3-bits  }
	kUndefined1EventType		= $00000008;					{  4-bits  }
	kXNoteEventType				= $00000009;					{  4-bits  }
	kXControlEventType			= $0000000A;					{  4-bits  }
	kKnobEventType				= $0000000B;					{  4-bits  }
	kUndefined2EventType		= $0000000C;					{  4-bits  }
	kUndefined3EventType		= $0000000D;					{  4-bits  }
	kUndefined4EventType		= $0000000E;					{  4-bits  }
	kGeneralEventType			= $0000000F;					{  4-bits  }
	kXEventLengthBits			= $00000002;					{  2 bits: indicates 8-byte event record  }
	kGeneralEventLengthBits		= $00000003;					{  2 bits: indicates variable length event record  }
	kEventLen					= 1;							{  length of events in long words  }
	kXEventLen					= 2;
	kRestEventLen				= 1;							{  length of events in long words  }
	kNoteEventLen				= 1;
	kControlEventLen			= 1;
	kMarkerEventLen				= 1;
	kXNoteEventLen				= 2;
	kXControlEventLen			= 2;
	kGeneralEventLen			= 2;							{  2 or more, however  }
																{  Universal Event Defines }
	kEventLengthFieldPos		= 30;							{  by looking at these two bits of the 1st or last word 			  }
	kEventLengthFieldWidth		= 2;							{  of an event you can determine the event length 					  }
																{  length field: 0 & 1 => 1 long; 2 => 2 longs; 3 => variable length  }
	kEventTypeFieldPos			= 29;							{  event type field for short events  }
	kEventTypeFieldWidth		= 3;							{  short type is 3 bits  }
	kXEventTypeFieldPos			= 28;							{  event type field for extended events  }
	kXEventTypeFieldWidth		= 4;							{  extended type is 4 bits  }
	kEventPartFieldPos			= 24;
	kEventPartFieldWidth		= 5;
	kXEventPartFieldPos			= 16;							{  in the 1st long word  }
	kXEventPartFieldWidth		= 12;							{  Rest Events }
	kRestEventDurationFieldPos	= 0;
	kRestEventDurationFieldWidth = 24;
	kRestEventDurationMax		= $00FFFFFF;					{  Note Events }
	kNoteEventPitchFieldPos		= 18;
	kNoteEventPitchFieldWidth	= 6;
	kNoteEventPitchOffset		= 32;							{  add to value in pitch field to get actual pitch  }
	kNoteEventVolumeFieldPos	= 11;
	kNoteEventVolumeFieldWidth	= 7;
	kNoteEventVolumeOffset		= 0;							{  add to value in volume field to get actual volume  }
	kNoteEventDurationFieldPos	= 0;
	kNoteEventDurationFieldWidth = 11;
	kNoteEventDurationMax		= $000007FF;
	kXNoteEventPitchFieldPos	= 0;							{  in the 1st long word  }
	kXNoteEventPitchFieldWidth	= 16;
	kXNoteEventDurationFieldPos	= 0;							{  in the 2nd long word  }
	kXNoteEventDurationFieldWidth = 22;
	kXNoteEventDurationMax		= $003FFFFF;
	kXNoteEventVolumeFieldPos	= 22;							{  in the 2nd long word  }
	kXNoteEventVolumeFieldWidth	= 7;							{  Control Events }
	kControlEventControllerFieldPos = 16;
	kControlEventControllerFieldWidth = 8;
	kControlEventValueFieldPos	= 0;
	kControlEventValueFieldWidth = 16;
	kXControlEventControllerFieldPos = 0;						{  in the 2nd long word  }
	kXControlEventControllerFieldWidth = 16;
	kXControlEventValueFieldPos	= 0;							{  in the 1st long word  }
	kXControlEventValueFieldWidth = 16;							{  Knob Events }
	kKnobEventValueHighFieldPos	= 0;							{  1st long word  }
	kKnobEventValueHighFieldWidth = 16;
	kKnobEventKnobFieldPos		= 16;							{  2nd long word  }
	kKnobEventKnobFieldWidth	= 14;
	kKnobEventValueLowFieldPos	= 0;							{  2nd long word  }
	kKnobEventValueLowFieldWidth = 16;							{  Marker Events }
	kMarkerEventSubtypeFieldPos	= 16;
	kMarkerEventSubtypeFieldWidth = 8;
	kMarkerEventValueFieldPos	= 0;
	kMarkerEventValueFieldWidth	= 16;							{  General Events }
	kGeneralEventSubtypeFieldPos = 16;							{  in the last long word  }
	kGeneralEventSubtypeFieldWidth = 14;
	kGeneralEventLengthFieldPos	= 0;							{  in the 1st & last long words  }
	kGeneralEventLengthFieldWidth = 16;

{  General Event Defined Types }
	kGeneralEventNoteRequest	= 1;							{  Encapsulates NoteRequest data structure  }
	kGeneralEventPartKey		= 4;
	kGeneralEventTuneDifference	= 5;							{  Contains a standard sequence, with end marker, for the tune difference of a sequence piece (halts QuickTime 2.0 Music)  }
	kGeneralEventAtomicInstrument = 6;							{  Encapsulates AtomicInstrument record  }
	kGeneralEventKnob			= 7;							{  knobID/knobValue pairs; smallest event is 4 longs  }
	kGeneralEventMIDIChannel	= 8;							{  used in tune header, one longword identifies the midi channel it originally came from  }
	kGeneralEventPartChange		= 9;							{  used in tune sequence, one longword identifies the tune part which can now take over this part's note channel (similar to program change) (halts QuickTime 2.0 Music) }
	kGeneralEventNoOp			= 10;							{  guaranteed to do nothing and be ignored. (halts QuickTime 2.0 Music)  }
	kGeneralEventUsedNotes		= 11;							{  four longwords specifying which midi notes are actually used, 0..127 msb to lsb  }

{  Marker Event Defined Types		// marker is 60 ee vv vv in hex, where e = event type, and v = value }
	kMarkerEventEnd				= 0;							{  marker type 0 means: value 0 - stop, value != 0 - ignore }
	kMarkerEventBeat			= 1;							{  value 0 = single beat; anything else is 65536ths-of-a-beat (quarter note) }
	kMarkerEventTempo			= 2;							{  value same as beat marker, but indicates that a tempo event should be computed (based on where the next beat or tempo marker is) and emitted upon export }

{  UPP call backs  }
	uppMusicMIDISendProcInfo = $00000FF0;
	uppMusicMIDIReadHookProcInfo = $000003F0;
	uppMusicOfflineDataProcInfo = $00000FF0;
	uppTuneCallBackProcInfo = $000003C0;
	uppTunePlayCallBackProcInfo = $00000FC0;

FUNCTION NewMusicMIDISendProc(userRoutine: MusicMIDISendProcPtr): MusicMIDISendUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMusicMIDIReadHookProc(userRoutine: MusicMIDIReadHookProcPtr): MusicMIDIReadHookUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMusicOfflineDataProc(userRoutine: MusicOfflineDataProcPtr): MusicOfflineDataUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTuneCallBackProc(userRoutine: TuneCallBackProcPtr): TuneCallBackUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTunePlayCallBackProc(userRoutine: TunePlayCallBackProcPtr): TunePlayCallBackUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallMusicMIDISendProc(self: MusicComponent; refCon: LONGINT; VAR mmp: MusicMIDIPacket; userRoutine: MusicMIDISendUPP): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMusicMIDIReadHookProc(VAR mp: MusicMIDIPacket; myRefCon: LONGINT; userRoutine: MusicMIDIReadHookUPP): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMusicOfflineDataProc(SoundData: Ptr; numBytes: LONGINT; myRefCon: LONGINT; userRoutine: MusicOfflineDataUPP): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallTuneCallBackProc({CONST}VAR status: TuneStatus; refCon: LONGINT; userRoutine: TuneCallBackUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallTunePlayCallBackProc(VAR event: LONGINT; seed: LONGINT; refCon: LONGINT; userRoutine: TunePlayCallBackUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QuickTimeMusicIncludes}

{$ENDC} {__QUICKTIMEMUSIC__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

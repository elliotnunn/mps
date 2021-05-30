{
     File:       QuickTimeMusic.p
 
     Contains:   QuickTime Interfaces.
 
     Version:    Technology: QuickTime 5.0.1
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1990-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __VIDEO__}
{$I Video.p}
{$ENDC}
{$IFC UNDEFINED __MACMEMORY__}
{$I MacMemory.p}
{$ENDC}
{$IFC UNDEFINED __SOUND__}
{$I Sound.p}
{$ENDC}
{$IFC UNDEFINED __ENDIAN__}
{$I Endian.p}
{$ENDC}
{$IFC UNDEFINED __IMAGECOMPRESSION__}
{$I ImageCompression.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
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
	kaiSampleDataQUIDType		= 'quid';
	kaiInstInfoType				= 'iinf';
	kaiPictType					= 'pict';
	kaiWriterType				= '©wrt';
	kaiCopyrightType			= '©cpy';
	kaiOtherStrType				= 'str ';
	kaiInstrumentRefType		= 'iref';
	kaiInstGMQualityType		= 'qual';
	kaiLibraryInfoType			= 'linf';
	kaiLibraryDescType			= 'ldsc';


TYPE
	InstLibDescRecPtr = ^InstLibDescRec;
	InstLibDescRec = RECORD
		libIDName:				Str31;
	END;

	InstKnobRecPtr = ^InstKnobRec;
	InstKnobRec = RECORD
		number:					BigEndianLong;
		value:					BigEndianLong;
	END;


CONST
	kInstKnobMissingUnknown		= 0;
	kInstKnobMissingDefault		= $01;


TYPE
	InstKnobListPtr = ^InstKnobList;
	InstKnobList = RECORD
		knobCount:				BigEndianLong;
		knobFlags:				BigEndianLong;
		knob:					ARRAY [0..0] OF InstKnobRec;
	END;


CONST
	kMusicLoopTypeNormal		= 0;
	kMusicLoopTypePalindrome	= 1;							{  back & forth }

	instSamplePreProcessFlag	= $01;


TYPE
	InstSampleDescRecPtr = ^InstSampleDescRec;
	InstSampleDescRec = RECORD
		dataFormat:				BigEndianOSType;
		numChannels:			BigEndianShort;
		sampleSize:				BigEndianShort;
		sampleRate:				BigEndianUnsignedFixed;
		sampleDataID:			BigEndianShort;
		offset:					BigEndianLong;							{  offset within SampleData - this could be just for internal use }
		numSamples:				BigEndianLong;							{  this could also just be for internal use, we'll see }
		loopType:				BigEndianLong;
		loopStart:				BigEndianLong;
		loopEnd:				BigEndianLong;
		pitchNormal:			BigEndianLong;
		pitchLow:				BigEndianLong;
		pitchHigh:				BigEndianLong;
	END;

	AtomicInstrument					= Handle;
	AtomicInstrumentPtr					= Ptr;

CONST
	kQTMIDIComponentType		= 'midi';

	kOMSComponentSubType		= 'OMS ';
	kFMSComponentSubType		= 'FMS ';
	kMIDIManagerComponentSubType = 'mmgr';
	kOSXMIDIComponentSubType	= 'osxm';


TYPE
	QTMIDIComponent						= ComponentInstance;

CONST
	kMusicPacketPortLost		= 1;							{  received when application loses the default input port  }
	kMusicPacketPortFound		= 2;							{  received when application gets it back out from under someone else's claim  }
	kMusicPacketTimeGap			= 3;							{  data[0] = number of milliseconds to keep the MIDI line silent  }

	kAppleSysexID				= $11;							{  apple sysex is followed by 2-byte command. 0001 is the command for samplesize  }
	kAppleSysexCmdSampleSize	= $0001;						{  21 bit number in 3 midi bytes follows sysex ID and 2 cmd bytes  }
	kAppleSysexCmdSampleBreak	= $0002;						{  specifies that the sample should break right here  }
	kAppleSysexCmdAtomicInstrument = $0010;						{  contents of atomic instrument handle  }
	kAppleSysexCmdDeveloper		= $7F00;						{  F0 11 7F 00 ww xx yy zz ... F7 is available for non-Apple developers, where wxyz is unique app signature with 8th bit cleared, unique to developer, and 00 and 7f are reserved  }


TYPE
	MusicMIDIPacketPtr = ^MusicMIDIPacket;
	MusicMIDIPacket = RECORD
		length:					UInt16;
		reserved:				UInt32;									{  if length zero, then reserved = above enum  }
		data:					PACKED ARRAY [0..248] OF UInt8;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	MusicMIDISendProcPtr = FUNCTION(self: ComponentInstance; refCon: LONGINT; VAR mmp: MusicMIDIPacket): ComponentResult;
{$ELSEC}
	MusicMIDISendProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	MusicMIDISendUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MusicMIDISendUPP = UniversalProcPtr;
{$ENDC}	

CONST
	kSynthesizerConnectionFMS	= 1;							{  this connection imported from FMS  }
	kSynthesizerConnectionMMgr	= 2;							{  this connection imported from the MIDI Mgr  }
	kSynthesizerConnectionOMS	= 4;							{  this connection imported from OMS  }
	kSynthesizerConnectionQT	= 8;							{  this connection is a QuickTime-only port  }
	kSynthesizerConnectionOSXMIDI = 16;							{  this connection is an OS X CoreMIDI port  }
																{  lowest five bits are mutually exclusive; combinations reserved for future use. }
	kSynthesizerConnectionUnavailable = 256;					{  port exists, but cannot be used just now  }

	{	
	    The sampleBankFile field of this structure can be used to pass in a pointer to an FSSpec
	    that specifies a SoundFont 2 or DLS file (otherwise set it to NULL ).
	    
	    You then pass in a structure with this field set (all other fields should be zero) to
	    NARegisterMusicDevice:
	        - with synthType as kSoftSynthComponentSubType 
	        - with name being used to return to the application the "name" of the synth 
	        that should be used in the synthesiserName field of the ToneDescription structure
	        and is also used to retrieve a particular MusicComponent with the
	        NAGetRegisteredMusicDevice call
	    
	    This call will create a MusicComponent of kSoftSynthComponentSubType, with the specified
	    sound bank as the sample data source.
	
	    This field requires QuickTime 5.0 or later and should be set to NULL for prior versions.
		}

TYPE
	SynthesizerConnectionsPtr = ^SynthesizerConnections;
	SynthesizerConnections = RECORD
		clientID:				OSType;
		inputPortID:			OSType;									{  terminology death: this port is used to SEND to the midi synth  }
		outputPortID:			OSType;									{  terminology death: this port receives from a keyboard or other control device  }
		midiChannel:			LONGINT;								{  The system channel; others are configurable (or the nubus slot number)  }
		flags:					LONGINT;
		unique:					LONGINT;								{  unique id may be used instead of index, to getinfo and unregister calls  }
		sampleBankFile:			FSSpecPtr;								{  see notes above  }
		reserved2:				LONGINT;								{  should be zero  }
	END;

	QTMIDIPortPtr = ^QTMIDIPort;
	QTMIDIPort = RECORD
		portConnections:		SynthesizerConnections;
		portName:				Str63;
	END;

	QTMIDIPortListPtr = ^QTMIDIPortList;
	QTMIDIPortList = RECORD
		portCount:				INTEGER;
		port:					ARRAY [0..0] OF QTMIDIPort;
	END;

	QTMIDIPortListHandle				= ^QTMIDIPortListPtr;
	{
	 *  QTMIDIGetMIDIPorts()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION QTMIDIGetMIDIPorts(ci: QTMIDIComponent; VAR inputPorts: QTMIDIPortListHandle; VAR outputPorts: QTMIDIPortListHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0001, $7000, $A82A;
	{$ENDC}

{
 *  QTMIDIUseSendPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTMIDIUseSendPort(ci: QTMIDIComponent; portIndex: LONGINT; inUse: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0002, $7000, $A82A;
	{$ENDC}

{
 *  QTMIDISendMIDI()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTMIDISendMIDI(ci: QTMIDIComponent; portIndex: LONGINT; VAR mp: MusicMIDIPacket): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0003, $7000, $A82A;
	{$ENDC}




CONST
	kMusicComponentType			= 'musi';
	kInstrumentComponentType	= 'inst';

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
	kSynthesizerHasSystemChannel = $0200;						{  has some "system channel" notion to distinguish it from multiple instances of the same device (GM devices dont)  }
	kSynthesizerSlowSetPart		= $0400;						{  SetPart() and SetPartInstrumentNumber() calls do not have rapid response, may glitch notes  }
	kSynthesizerOffline			= $1000;						{  can enter an offline synthesis mode  }
	kSynthesizerGM				= $4000;						{  synth is a GM device  }
	kSynthesizerDLS				= $8000;						{  synth supports DLS level 1  }
	kSynthesizerSoundLocalization = $00010000;					{  synth supports extremely baroque, nonstandard, and proprietary "apple game sprockets" localization parameter set  }

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
	kControllerPortamentoTime	= 5;							{  time in 8.8 seconds, portamento on/off is omitted, 0 time = 'off'  }
	kControllerVolume			= 7;							{  main volume control  }
	kControllerBalance			= 8;
	kControllerPan				= 10;							{  0 - "default", 1 - n: positioned in output 1-n (incl fractions)  }
	kControllerExpression		= 11;							{  secondary volume control  }
	kControllerLever1			= 16;							{  general purpose controllers  }
	kControllerLever2			= 17;							{  general purpose controllers  }
	kControllerLever3			= 18;							{  general purpose controllers  }
	kControllerLever4			= 19;							{  general purpose controllers  }
	kControllerLever5			= 80;							{  general purpose controllers  }
	kControllerLever6			= 81;							{  general purpose controllers  }
	kControllerLever7			= 82;							{  general purpose controllers  }
	kControllerLever8			= 83;							{  general purpose controllers  }
	kControllerPitchBend		= 32;							{  positive & negative semitones, with 8 bits fraction, same units as transpose controllers }
	kControllerAfterTouch		= 33;							{  aka channel pressure  }
	kControllerPartTranspose	= 40;							{  identical to pitchbend, for overall part xpose  }
	kControllerTuneTranspose	= 41;							{  another pitchbend, for "song global" pitch offset  }
	kControllerPartVolume		= 42;							{  another volume control, passed right down from note allocator part volume  }
	kControllerTuneVolume		= 43;							{  another volume control, used for "song global" volume - since we share one synthesizer across multiple tuneplayers }
	kControllerSustain			= 64;							{  boolean - positive for on, 0 or negative off  }
	kControllerPortamento		= 65;							{  boolean }
	kControllerSostenuto		= 66;							{  boolean  }
	kControllerSoftPedal		= 67;							{  boolean  }
	kControllerReverb			= 91;
	kControllerTremolo			= 92;
	kControllerChorus			= 93;
	kControllerCeleste			= 94;
	kControllerPhaser			= 95;
	kControllerEditPart			= 113;							{  last 16 controllers 113-128 and above are global controllers which respond on part zero  }
	kControllerMasterTune		= 114;
	kControllerMasterTranspose	= 114;							{  preferred }
	kControllerMasterVolume		= 115;
	kControllerMasterCPULoad	= 116;
	kControllerMasterPolyphony	= 117;
	kControllerMasterFeatures	= 118;


	{  ID's of knobs supported by the QuickTime Music Synthesizer built into QuickTime }

	kQTMSKnobStartID			= $02000000;
	kQTMSKnobVolumeAttackTimeID	= $02000001;
	kQTMSKnobVolumeDecayTimeID	= $02000002;
	kQTMSKnobVolumeSustainLevelID = $02000003;
	kQTMSKnobVolumeRelease1RateID = $02000004;
	kQTMSKnobVolumeDecayKeyScalingID = $02000005;
	kQTMSKnobVolumeReleaseTimeID = $02000006;
	kQTMSKnobVolumeLFODelayID	= $02000007;
	kQTMSKnobVolumeLFORampTimeID = $02000008;
	kQTMSKnobVolumeLFOPeriodID	= $02000009;
	kQTMSKnobVolumeLFOShapeID	= $0200000A;
	kQTMSKnobVolumeLFODepthID	= $0200000B;
	kQTMSKnobVolumeOverallID	= $0200000C;
	kQTMSKnobVolumeVelocity127ID = $0200000D;
	kQTMSKnobVolumeVelocity96ID	= $0200000E;
	kQTMSKnobVolumeVelocity64ID	= $0200000F;
	kQTMSKnobVolumeVelocity32ID	= $02000010;
	kQTMSKnobVolumeVelocity16ID	= $02000011;					{  Pitch related knobs }
	kQTMSKnobPitchTransposeID	= $02000012;
	kQTMSKnobPitchLFODelayID	= $02000013;
	kQTMSKnobPitchLFORampTimeID	= $02000014;
	kQTMSKnobPitchLFOPeriodID	= $02000015;
	kQTMSKnobPitchLFOShapeID	= $02000016;
	kQTMSKnobPitchLFODepthID	= $02000017;
	kQTMSKnobPitchLFOQuantizeID	= $02000018;					{  Stereo related knobs }
	kQTMSKnobStereoDefaultPanID	= $02000019;
	kQTMSKnobStereoPositionKeyScalingID = $0200001A;
	kQTMSKnobPitchLFOOffsetID	= $0200001B;
	kQTMSKnobExclusionGroupID	= $0200001C;					{  Misc knobs, late additions }
	kQTMSKnobSustainTimeID		= $0200001D;
	kQTMSKnobSustainInfiniteID	= $0200001E;
	kQTMSKnobVolumeLFOStereoID	= $0200001F;
	kQTMSKnobVelocityLowID		= $02000020;
	kQTMSKnobVelocityHighID		= $02000021;
	kQTMSKnobVelocitySensitivityID = $02000022;
	kQTMSKnobPitchSensitivityID	= $02000023;
	kQTMSKnobVolumeLFODepthFromWheelID = $02000024;
	kQTMSKnobPitchLFODepthFromWheelID = $02000025;				{  Volume Env again }
	kQTMSKnobVolumeExpOptionsID	= $02000026;					{  Env1 }
	kQTMSKnobEnv1AttackTimeID	= $02000027;
	kQTMSKnobEnv1DecayTimeID	= $02000028;
	kQTMSKnobEnv1SustainLevelID	= $02000029;
	kQTMSKnobEnv1SustainTimeID	= $0200002A;
	kQTMSKnobEnv1SustainInfiniteID = $0200002B;
	kQTMSKnobEnv1ReleaseTimeID	= $0200002C;
	kQTMSKnobEnv1ExpOptionsID	= $0200002D;					{  Env2 }
	kQTMSKnobEnv2AttackTimeID	= $0200002E;
	kQTMSKnobEnv2DecayTimeID	= $0200002F;
	kQTMSKnobEnv2SustainLevelID	= $02000030;
	kQTMSKnobEnv2SustainTimeID	= $02000031;
	kQTMSKnobEnv2SustainInfiniteID = $02000032;
	kQTMSKnobEnv2ReleaseTimeID	= $02000033;
	kQTMSKnobEnv2ExpOptionsID	= $02000034;					{  Pitch Env }
	kQTMSKnobPitchEnvelopeID	= $02000035;
	kQTMSKnobPitchEnvelopeDepthID = $02000036;					{  Filter }
	kQTMSKnobFilterKeyFollowID	= $02000037;
	kQTMSKnobFilterTransposeID	= $02000038;
	kQTMSKnobFilterQID			= $02000039;
	kQTMSKnobFilterFrequencyEnvelopeID = $0200003A;
	kQTMSKnobFilterFrequencyEnvelopeDepthID = $0200003B;
	kQTMSKnobFilterQEnvelopeID	= $0200003C;
	kQTMSKnobFilterQEnvelopeDepthID = $0200003D;				{  Reverb Threshhold }
	kQTMSKnobReverbThresholdID	= $0200003E;
	kQTMSKnobVolumeAttackVelScalingID = $0200003F;
	kQTMSKnobLastIDPlus1		= $02000040;




	kControllerMaximum			= $00007FFF;					{  +01111111.11111111  }
	kControllerMinimum			= $FFFF8000;					{  -10000000.00000000  }


TYPE
	SynthesizerDescriptionPtr = ^SynthesizerDescription;
	SynthesizerDescription = RECORD
		synthesizerType:		OSType;									{  synthesizer type (must be same as component subtype)  }
		name:					Str31;									{  text name of synthesizer type  }
		flags:					UInt32;									{  from the above enum  }
		voiceCount:				UInt32;									{  maximum polyphony  }
		partCount:				UInt32;									{  maximum multi-timbrality (and midi channels)  }
		instrumentCount:		UInt32;									{  non gm, built in (rom) instruments only  }
		modifiableInstrumentCount: UInt32;								{  plus n-more are user modifiable  }
		channelMask:			UInt32;									{  (midi device only) which channels device always uses  }
		drumPartCount:			UInt32;									{  maximum multi-timbrality of drum parts  }
		drumCount:				UInt32;									{  non gm, built in (rom) drumkits only  }
		modifiableDrumCount:	UInt32;									{  plus n-more are user modifiable  }
		drumChannelMask:		UInt32;									{  (midi device only) which channels device always uses  }
		outputCount:			UInt32;									{  number of audio outputs (usually two)  }
		latency:				UInt32;									{  response time in µSec  }
		controllers:			ARRAY [0..3] OF UInt32;					{  array of 128 bits  }
		gmInstruments:			ARRAY [0..3] OF UInt32;					{  array of 128 bits  }
		gmDrums:				ARRAY [0..3] OF UInt32;					{  array of 128 bits  }
	END;


CONST
	kVoiceCountDynamic			= -1;							{  constant to use to specify dynamic voicing  }



TYPE
	ToneDescriptionPtr = ^ToneDescription;
	ToneDescription = RECORD
		synthesizerType:		BigEndianOSType;						{  synthesizer type  }
		synthesizerName:		Str31;									{  name of instantiation of synth  }
		instrumentName:			Str31;									{  preferred name for human use  }
		instrumentNumber:		BigEndianLong;							{  inst-number used if synth-name matches  }
		gmNumber:				BigEndianLong;							{  Best matching general MIDI number  }
	END;


CONST
	kFirstGMInstrument			= $00000001;
	kLastGMInstrument			= $00000080;
	kFirstGSInstrument			= $00000081;
	kLastGSInstrument			= $00003FFF;
	kFirstDrumkit				= $00004000;					{  (first value is "no drum". instrument numbers from 16384->16384+128 are drumkits, and for GM they are _defined_ drumkits!  }
	kLastDrumkit				= $00004080;
	kFirstROMInstrument			= $00008000;
	kLastROMInstrument			= $0000FFFF;
	kFirstUserInstrument		= $00010000;
	kLastUserInstrument			= $0001FFFF;

	{  InstrumentMatch }
	kInstrumentMatchSynthesizerType = 1;
	kInstrumentMatchSynthesizerName = 2;
	kInstrumentMatchName		= 4;
	kInstrumentMatchNumber		= 8;
	kInstrumentMatchGMNumber	= 16;
	kInstrumentMatchGSNumber	= 32;

	{  KnobFlags }
	kKnobBasic					= 8;							{  knob shows up in certain simplified lists of knobs  }
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
	{	 knobTypes for MusicDerivedSetKnob 	}

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

	{	 elements of the misc long list 	}
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
{$IFC TYPED_FUNCTION_POINTERS}
	MusicOfflineDataProcPtr = FUNCTION(SoundData: Ptr; numBytes: LONGINT; myRefCon: LONGINT): ComponentResult;
{$ELSEC}
	MusicOfflineDataProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	MusicOfflineDataUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MusicOfflineDataUPP = UniversalProcPtr;
{$ENDC}	
	OfflineSampleTypePtr = ^OfflineSampleType;
	OfflineSampleType = RECORD
		numChannels:			UInt32;									{ number of channels,  ie mono = 1 }
		sampleRate:				UnsignedFixed;							{ sample rate in Apples Fixed point representation }
		sampleSize:				UInt16;									{ number of bits in sample }
	END;

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
	{
	 *  MusicGetDescription()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION MusicGetDescription(mc: MusicComponent; VAR sd: SynthesizerDescription): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}

{
 *  MusicGetPart()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetPart(mc: MusicComponent; part: LONGINT; VAR midiChannel: LONGINT; VAR polyphony: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0002, $7000, $A82A;
	{$ENDC}

{
 *  MusicSetPart()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicSetPart(mc: MusicComponent; part: LONGINT; midiChannel: LONGINT; polyphony: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0003, $7000, $A82A;
	{$ENDC}

{
 *  MusicSetPartInstrumentNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicSetPartInstrumentNumber(mc: MusicComponent; part: LONGINT; instrumentNumber: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0004, $7000, $A82A;
	{$ENDC}


{
 *  MusicGetPartInstrumentNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetPartInstrumentNumber(mc: MusicComponent; part: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}

{
 *  MusicStorePartInstrument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicStorePartInstrument(mc: MusicComponent; part: LONGINT; instrumentNumber: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0006, $7000, $A82A;
	{$ENDC}


{
 *  MusicGetPartAtomicInstrument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetPartAtomicInstrument(mc: MusicComponent; part: LONGINT; VAR ai: AtomicInstrument; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0009, $7000, $A82A;
	{$ENDC}

{
 *  MusicSetPartAtomicInstrument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicSetPartAtomicInstrument(mc: MusicComponent; part: LONGINT; aiP: AtomicInstrumentPtr; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000A, $7000, $A82A;
	{$ENDC}


{
 *  MusicGetPartKnob()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetPartKnob(mc: MusicComponent; part: LONGINT; knobID: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0010, $7000, $A82A;
	{$ENDC}

{
 *  MusicSetPartKnob()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicSetPartKnob(mc: MusicComponent; part: LONGINT; knobID: LONGINT; knobValue: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0011, $7000, $A82A;
	{$ENDC}

{
 *  MusicGetKnob()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetKnob(mc: MusicComponent; knobID: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}

{
 *  MusicSetKnob()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicSetKnob(mc: MusicComponent; knobID: LONGINT; knobValue: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0013, $7000, $A82A;
	{$ENDC}

{
 *  MusicGetPartName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetPartName(mc: MusicComponent; part: LONGINT; name: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0014, $7000, $A82A;
	{$ENDC}

{
 *  MusicSetPartName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicSetPartName(mc: MusicComponent; part: LONGINT; name: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0015, $7000, $A82A;
	{$ENDC}

{
 *  MusicFindTone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicFindTone(mc: MusicComponent; VAR td: ToneDescription; VAR libraryIndexOut: LONGINT; VAR fit: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0016, $7000, $A82A;
	{$ENDC}

{
 *  MusicPlayNote()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicPlayNote(mc: MusicComponent; part: LONGINT; pitch: LONGINT; velocity: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0017, $7000, $A82A;
	{$ENDC}

{
 *  MusicResetPart()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicResetPart(mc: MusicComponent; part: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}

{
 *  MusicSetPartController()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicSetPartController(mc: MusicComponent; part: LONGINT; controllerNumber: MusicController; controllerValue: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0019, $7000, $A82A;
	{$ENDC}


{
 *  MusicGetPartController()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetPartController(mc: MusicComponent; part: LONGINT; controllerNumber: MusicController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001A, $7000, $A82A;
	{$ENDC}

{
 *  MusicGetMIDIProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetMIDIProc(mc: MusicComponent; VAR midiSendProc: MusicMIDISendUPP; VAR refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001B, $7000, $A82A;
	{$ENDC}

{
 *  MusicSetMIDIProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicSetMIDIProc(mc: MusicComponent; midiSendProc: MusicMIDISendUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001C, $7000, $A82A;
	{$ENDC}

{
 *  MusicGetInstrumentNames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetInstrumentNames(mc: MusicComponent; modifiableInstruments: LONGINT; VAR instrumentNames: Handle; VAR instrumentCategoryLasts: Handle; VAR instrumentCategoryNames: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $001D, $7000, $A82A;
	{$ENDC}

{
 *  MusicGetDrumNames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetDrumNames(mc: MusicComponent; modifiableInstruments: LONGINT; VAR instrumentNumbers: Handle; VAR instrumentNames: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $001E, $7000, $A82A;
	{$ENDC}

{
 *  MusicGetMasterTune()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetMasterTune(mc: MusicComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $001F, $7000, $A82A;
	{$ENDC}

{
 *  MusicSetMasterTune()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicSetMasterTune(mc: MusicComponent; masterTune: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0020, $7000, $A82A;
	{$ENDC}


{
 *  MusicGetInstrumentAboutInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetInstrumentAboutInfo(mc: MusicComponent; part: LONGINT; VAR iai: InstrumentAboutInfo): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0022, $7000, $A82A;
	{$ENDC}

{
 *  MusicGetDeviceConnection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetDeviceConnection(mc: MusicComponent; index: LONGINT; VAR id1: LONGINT; VAR id2: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0023, $7000, $A82A;
	{$ENDC}

{
 *  MusicUseDeviceConnection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicUseDeviceConnection(mc: MusicComponent; id1: LONGINT; id2: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0024, $7000, $A82A;
	{$ENDC}

{
 *  MusicGetKnobSettingStrings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetKnobSettingStrings(mc: MusicComponent; knobIndex: LONGINT; isGlobal: LONGINT; VAR settingsNames: Handle; VAR settingsCategoryLasts: Handle; VAR settingsCategoryNames: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0025, $7000, $A82A;
	{$ENDC}

{
 *  MusicGetMIDIPorts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetMIDIPorts(mc: MusicComponent; VAR inputPortCount: LONGINT; VAR outputPortCount: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0026, $7000, $A82A;
	{$ENDC}

{
 *  MusicSendMIDI()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicSendMIDI(mc: MusicComponent; portIndex: LONGINT; VAR mp: MusicMIDIPacket): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0027, $7000, $A82A;
	{$ENDC}

{
 *  MusicStartOffline()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicStartOffline(mc: MusicComponent; VAR numChannels: UInt32; VAR sampleRate: UnsignedFixed; VAR sampleSize: UInt16; dataProc: MusicOfflineDataUPP; dataProcRefCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0029, $7000, $A82A;
	{$ENDC}

{
 *  MusicSetOfflineTimeTo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicSetOfflineTimeTo(mc: MusicComponent; newTimeStamp: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002A, $7000, $A82A;
	{$ENDC}

{
 *  MusicGetInstrumentKnobDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetInstrumentKnobDescription(mc: MusicComponent; knobIndex: LONGINT; VAR mkd: KnobDescription): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002B, $7000, $A82A;
	{$ENDC}

{
 *  MusicGetDrumKnobDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetDrumKnobDescription(mc: MusicComponent; knobIndex: LONGINT; VAR mkd: KnobDescription): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002C, $7000, $A82A;
	{$ENDC}

{
 *  MusicGetKnobDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetKnobDescription(mc: MusicComponent; knobIndex: LONGINT; VAR mkd: KnobDescription): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002D, $7000, $A82A;
	{$ENDC}

{
 *  MusicGetInfoText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGetInfoText(mc: MusicComponent; selector: LONGINT; VAR textH: Handle; VAR styleH: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $002E, $7000, $A82A;
	{$ENDC}


CONST
	kGetInstrumentInfoNoBuiltIn	= $01;
	kGetInstrumentInfoMidiUserInst = $02;
	kGetInstrumentInfoNoIText	= $04;

	{
	 *  MusicGetInstrumentInfo()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION MusicGetInstrumentInfo(mc: MusicComponent; getInstrumentInfoFlags: LONGINT; VAR infoListH: InstrumentInfoListHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002F, $7000, $A82A;
	{$ENDC}




{
 *  MusicTask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicTask(mc: MusicComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0031, $7000, $A82A;
	{$ENDC}

{
 *  MusicSetPartInstrumentNumberInterruptSafe()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicSetPartInstrumentNumberInterruptSafe(mc: MusicComponent; part: LONGINT; instrumentNumber: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0032, $7000, $A82A;
	{$ENDC}

{
 *  MusicSetPartSoundLocalization()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicSetPartSoundLocalization(mc: MusicComponent; part: LONGINT; data: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0033, $7000, $A82A;
	{$ENDC}

{
 *  MusicGenericConfigure()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGenericConfigure(mc: MusicComponent; mode: LONGINT; flags: LONGINT; baseResID: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0100, $7000, $A82A;
	{$ENDC}

{
 *  MusicGenericGetPart()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGenericGetPart(mc: MusicComponent; partNumber: LONGINT; VAR part: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0101, $7000, $A82A;
	{$ENDC}

{
 *  MusicGenericGetKnobList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGenericGetKnobList(mc: MusicComponent; knobType: LONGINT; VAR gkdlH: GenericKnobDescriptionListHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0102, $7000, $A82A;
	{$ENDC}

{
 *  MusicGenericSetResourceNumbers()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicGenericSetResourceNumbers(mc: MusicComponent; resourceIDH: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}

{
 *  MusicDerivedMIDISend()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicDerivedMIDISend(mc: MusicComponent; VAR packet: MusicMIDIPacket): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0200, $7000, $A82A;
	{$ENDC}

{
 *  MusicDerivedSetKnob()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicDerivedSetKnob(mc: MusicComponent; knobType: LONGINT; knobNumber: LONGINT; knobValue: LONGINT; partNumber: LONGINT; VAR p: GCPart; VAR gkd: GenericKnobDescription): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0201, $7000, $A82A;
	{$ENDC}

{
 *  MusicDerivedSetPart()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicDerivedSetPart(mc: MusicComponent; partNumber: LONGINT; VAR p: GCPart): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0202, $7000, $A82A;
	{$ENDC}

{
 *  MusicDerivedSetInstrument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicDerivedSetInstrument(mc: MusicComponent; partNumber: LONGINT; VAR p: GCPart): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0203, $7000, $A82A;
	{$ENDC}

{
 *  MusicDerivedSetPartInstrumentNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicDerivedSetPartInstrumentNumber(mc: MusicComponent; partNumber: LONGINT; VAR p: GCPart): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0204, $7000, $A82A;
	{$ENDC}

{
 *  MusicDerivedSetMIDI()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicDerivedSetMIDI(mc: MusicComponent; midiProc: MusicMIDISendUPP; refcon: LONGINT; midiChannel: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0205, $7000, $A82A;
	{$ENDC}

{
 *  MusicDerivedStorePartInstrument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicDerivedStorePartInstrument(mc: MusicComponent; partNumber: LONGINT; VAR p: GCPart; instrumentNumber: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0206, $7000, $A82A;
	{$ENDC}

{
 *  MusicDerivedOpenResFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicDerivedOpenResFile(mc: MusicComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0207, $7000, $A82A;
	{$ENDC}

{
 *  MusicDerivedCloseResFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicDerivedCloseResFile(mc: MusicComponent; resRefNum: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0208, $7000, $A82A;
	{$ENDC}






{--------------------------
    Types
--------------------------}

TYPE
	NoteAllocator						= ComponentInstance;

CONST
	kNoteRequestNoGM			= 1;							{  don't degrade to a GM synth  }
	kNoteRequestNoSynthType		= 2;							{  don't degrade to another synth of same type but different name  }
	kNoteRequestSynthMustMatch	= 4;							{  synthType must be a match, including kGMSynthComponentSubType  }


	kNoteRequestSpecifyMIDIChannel = $80;

	{	
	    The midiChannelAssignment field of this structure is used to assign a MIDI channel 
	    when a NoteChannel is created from a NoteRequest.
	    A value of 0 indicates a MIDI channel has *not* been assigned
	    A value of (kNoteRequestSpecifyMIDIChannel | 1->16) is a MIDI channel assignment
	
	    This field requires QuickTime 5.0 or later and should be set to 0 for prior versions.
		}

TYPE
	NoteRequestMIDIChannel				= UInt8;
	NoteRequestInfoPtr = ^NoteRequestInfo;
	NoteRequestInfo = RECORD
		flags:					SInt8;									{  kNoteRequest flags, above  }
		midiChannelAssignment:	SInt8;									{  (kNoteRequestSpecifyMIDIChannel | 1->16) as MIDI Channel assignment or zero - see notes above  }
		polyphony:				BigEndianShort;							{  Maximum number of voices  }
		typicalPolyphony:		BigEndianFixed;							{  Hint for level mixing  }
	END;

	NoteRequestPtr = ^NoteRequest;
	NoteRequest = RECORD
		info:					NoteRequestInfo;
		tone:					ToneDescription;
	END;

	NoteChannel    = ^LONGINT; { an opaque 32-bit type }
	NoteChannelPtr = ^NoteChannel;  { when a VAR xx:NoteChannel parameter can be nil, it is changed to xx: NoteChannelPtr }



CONST
	kPickDontMix				= 1;							{  dont mix instruments with drum sounds  }
	kPickSameSynth				= 2;							{  only allow the same device that went in, to come out  }
	kPickUserInsts				= 4;							{  show user insts in addition to ROM voices  }
	kPickEditAllowEdit			= 8;							{  lets user switch over to edit mode  }
	kPickEditAllowPick			= 16;							{  lets the user switch over to pick mode  }
	kPickEditSynthGlobal		= 32;							{  edit the global knobs of the synth  }
	kPickEditControllers		= 64;							{  edit the controllers of the notechannel  }


	kNoteAllocatorComponentType	= 'nota';


	{	--------------------------------
	    Note Allocator Prototypes
	--------------------------------	}
	{
	 *  NARegisterMusicDevice()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION NARegisterMusicDevice(na: NoteAllocator; synthType: OSType; VAR name: Str31; VAR connections: SynthesizerConnections): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0000, $7000, $A82A;
	{$ENDC}

{
 *  NAUnregisterMusicDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAUnregisterMusicDevice(na: NoteAllocator; index: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}

{
 *  NAGetRegisteredMusicDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAGetRegisteredMusicDevice(na: NoteAllocator; index: LONGINT; VAR synthType: OSType; VAR name: Str31; VAR connections: SynthesizerConnections; VAR mc: MusicComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0002, $7000, $A82A;
	{$ENDC}

{
 *  NASaveMusicConfiguration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NASaveMusicConfiguration(na: NoteAllocator): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0003, $7000, $A82A;
	{$ENDC}

{
 *  NANewNoteChannel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NANewNoteChannel(na: NoteAllocator; VAR noteRequest: NoteRequest; VAR outChannel: NoteChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0004, $7000, $A82A;
	{$ENDC}

{
 *  NADisposeNoteChannel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NADisposeNoteChannel(na: NoteAllocator; noteChannel: NoteChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}

{
 *  NAGetNoteChannelInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAGetNoteChannelInfo(na: NoteAllocator; noteChannel: NoteChannel; VAR index: LONGINT; VAR part: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0006, $7000, $A82A;
	{$ENDC}

{
 *  NAPrerollNoteChannel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAPrerollNoteChannel(na: NoteAllocator; noteChannel: NoteChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}

{
 *  NAUnrollNoteChannel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAUnrollNoteChannel(na: NoteAllocator; noteChannel: NoteChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0008, $7000, $A82A;
	{$ENDC}


{
 *  NASetNoteChannelVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NASetNoteChannelVolume(na: NoteAllocator; noteChannel: NoteChannel; volume: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000B, $7000, $A82A;
	{$ENDC}

{
 *  NAResetNoteChannel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAResetNoteChannel(na: NoteAllocator; noteChannel: NoteChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}

{
 *  NAPlayNote()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAPlayNote(na: NoteAllocator; noteChannel: NoteChannel; pitch: LONGINT; velocity: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000D, $7000, $A82A;
	{$ENDC}

{
 *  NASetController()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NASetController(na: NoteAllocator; noteChannel: NoteChannel; controllerNumber: LONGINT; controllerValue: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000E, $7000, $A82A;
	{$ENDC}

{
 *  NASetKnob()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NASetKnob(na: NoteAllocator; noteChannel: NoteChannel; knobNumber: LONGINT; knobValue: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000F, $7000, $A82A;
	{$ENDC}

{
 *  NAFindNoteChannelTone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAFindNoteChannelTone(na: NoteAllocator; noteChannel: NoteChannel; VAR td: ToneDescription; VAR instrumentNumber: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0010, $7000, $A82A;
	{$ENDC}

{
 *  NASetInstrumentNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NASetInstrumentNumber(na: NoteAllocator; noteChannel: NoteChannel; instrumentNumber: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0011, $7000, $A82A;
	{$ENDC}



{
 *  NAPickInstrument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAPickInstrument(na: NoteAllocator; filterProc: ModalFilterUPP; prompt: StringPtr; VAR sd: ToneDescription; flags: UInt32; refCon: LONGINT; reserved1: LONGINT; reserved2: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001C, $0012, $7000, $A82A;
	{$ENDC}

{
 *  NAPickArrangement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAPickArrangement(na: NoteAllocator; filterProc: ModalFilterUPP; prompt: StringPtr; zero1: LONGINT; zero2: LONGINT; t: Track; songName: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0013, $7000, $A82A;
	{$ENDC}


{
 *  NAStuffToneDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAStuffToneDescription(na: NoteAllocator; gmNumber: LONGINT; VAR td: ToneDescription): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001B, $7000, $A82A;
	{$ENDC}

{
 *  NACopyrightDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NACopyrightDialog(na: NoteAllocator; p: PicHandle; author: StringPtr; copyright: StringPtr; other: StringPtr; title: StringPtr; filterProc: ModalFilterUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001C, $001C, $7000, $A82A;
	{$ENDC}


{
    kNADummyOneSelect = 29
    kNADummyTwoSelect = 30
}

{
 *  NAGetIndNoteChannel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAGetIndNoteChannel(na: NoteAllocator; index: LONGINT; VAR nc: NoteChannel; VAR seed: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $001F, $7000, $A82A;
	{$ENDC}


{
 *  NAGetMIDIPorts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAGetMIDIPorts(na: NoteAllocator; VAR inputPorts: QTMIDIPortListHandle; VAR outputPorts: QTMIDIPortListHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0021, $7000, $A82A;
	{$ENDC}

{
 *  NAGetNoteRequest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAGetNoteRequest(na: NoteAllocator; noteChannel: NoteChannel; VAR nrOut: NoteRequest): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0022, $7000, $A82A;
	{$ENDC}

{
 *  NASendMIDI()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NASendMIDI(na: NoteAllocator; noteChannel: NoteChannel; VAR mp: MusicMIDIPacket): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0023, $7000, $A82A;
	{$ENDC}

{
 *  NAPickEditInstrument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAPickEditInstrument(na: NoteAllocator; filterProc: ModalFilterUPP; prompt: StringPtr; refCon: LONGINT; nc: NoteChannel; ai: AtomicInstrument; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0024, $7000, $A82A;
	{$ENDC}

{
 *  NANewNoteChannelFromAtomicInstrument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NANewNoteChannelFromAtomicInstrument(na: NoteAllocator; instrument: AtomicInstrumentPtr; flags: LONGINT; VAR outChannel: NoteChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0025, $7000, $A82A;
	{$ENDC}

{
 *  NASetAtomicInstrument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NASetAtomicInstrument(na: NoteAllocator; noteChannel: NoteChannel; instrument: AtomicInstrumentPtr; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0026, $7000, $A82A;
	{$ENDC}



{
 *  NAGetKnob()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAGetKnob(na: NoteAllocator; noteChannel: NoteChannel; knobNumber: LONGINT; VAR knobValue: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0028, $7000, $A82A;
	{$ENDC}

{
 *  NATask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NATask(na: NoteAllocator): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0029, $7000, $A82A;
	{$ENDC}

{
 *  NASetNoteChannelBalance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NASetNoteChannelBalance(na: NoteAllocator; noteChannel: NoteChannel; balance: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002A, $7000, $A82A;
	{$ENDC}

{
 *  NASetInstrumentNumberInterruptSafe()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NASetInstrumentNumberInterruptSafe(na: NoteAllocator; noteChannel: NoteChannel; instrumentNumber: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002B, $7000, $A82A;
	{$ENDC}

{
 *  NASetNoteChannelSoundLocalization()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NASetNoteChannelSoundLocalization(na: NoteAllocator; noteChannel: NoteChannel; data: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002C, $7000, $A82A;
	{$ENDC}

{
 *  NAGetController()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NAGetController(na: NoteAllocator; noteChannel: NoteChannel; controllerNumber: LONGINT; VAR controllerValue: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $002D, $7000, $A82A;
	{$ENDC}






CONST
	kTuneQueueDepth				= 8;							{  Deepest you can queue tune segments  }



TYPE
	TuneStatusPtr = ^TuneStatus;
	TuneStatus = RECORD
		tune:					LongIntPtr;								{  currently playing tune  }
		tunePtr:				LongIntPtr;								{  position within currently playing piece  }
		time:					TimeValue;								{  current tune time  }
		queueCount:				INTEGER;								{  how many pieces queued up?  }
		queueSpots:				INTEGER;								{  How many more tunepieces can be queued  }
		queueTime:				TimeValue;								{  How much time is queued up? (can be very inaccurate)  }
		reserved:				ARRAY [0..2] OF LONGINT;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	TuneCallBackProcPtr = PROCEDURE({CONST}VAR status: TuneStatus; refCon: LONGINT);
{$ELSEC}
	TuneCallBackProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TunePlayCallBackProcPtr = PROCEDURE(VAR event: UInt32; seed: LONGINT; refCon: LONGINT);
{$ELSEC}
	TunePlayCallBackProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	TuneCallBackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TuneCallBackUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TunePlayCallBackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TunePlayCallBackUPP = UniversalProcPtr;
{$ENDC}	
	TunePlayer							= ComponentInstance;

CONST
	kTunePlayerComponentType	= 'tune';


	{
	 *  TuneSetHeader()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION TuneSetHeader(tp: TunePlayer; VAR header: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}

{
 *  TuneGetTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneGetTimeBase(tp: TunePlayer; VAR tb: TimeBase): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}

{
 *  TuneSetTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneSetTimeScale(tp: TunePlayer; scale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}

{
 *  TuneGetTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneGetTimeScale(tp: TunePlayer; VAR scale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}

{
 *  TuneGetIndexedNoteChannel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneGetIndexedNoteChannel(tp: TunePlayer; i: LONGINT; VAR nc: NoteChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0008, $7000, $A82A;
	{$ENDC}


{ Values for when to start. }

CONST
	kTuneStartNow				= 1;							{  start after buffer is implied  }
	kTuneDontClipNotes			= 2;							{  allow notes to finish their durations outside sample  }
	kTuneExcludeEdgeNotes		= 4;							{  dont play notes that start at end of tune  }
	kTuneQuickStart				= 8;							{  Leave all the controllers where they are, ignore start time  }
	kTuneLoopUntil				= 16;							{  loop a queued tune if there's nothing else in the queue }
	kTunePlayDifference			= 32;							{  by default, the tune difference is skipped }
	kTunePlayConcurrent			= 64;							{  dont block the next tune sequence with this one }
	kTuneStartNewMaster			= 16384;

	{
	 *  TuneQueue()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION TuneQueue(tp: TunePlayer; VAR tune: UInt32; tuneRate: Fixed; tuneStartPosition: UInt32; tuneStopPosition: UInt32; queueFlags: UInt32; callBackProc: TuneCallBackUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001C, $000A, $7000, $A82A;
	{$ENDC}

{
 *  TuneInstant()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneInstant(tp: TunePlayer; VAR tune: UInt32; tunePosition: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000B, $7000, $A82A;
	{$ENDC}

{
 *  TuneGetStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneGetStatus(tp: TunePlayer; VAR status: TuneStatus): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}

{ Values for stopping. }

CONST
	kTuneStopFade				= 1;							{  do a quick, synchronous fadeout  }
	kTuneStopSustain			= 2;							{  don't silece notes  }
	kTuneStopInstant			= 4;							{  silence notes fast (else, decay them)  }
	kTuneStopReleaseChannels	= 8;							{  afterwards, let the channels go  }

	{
	 *  TuneStop()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION TuneStop(tp: TunePlayer; stopFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}


{
 *  TuneSetVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneSetVolume(tp: TunePlayer; volume: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0010, $7000, $A82A;
	{$ENDC}

{
 *  TuneGetVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneGetVolume(tp: TunePlayer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0011, $7000, $A82A;
	{$ENDC}

{
 *  TunePreroll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TunePreroll(tp: TunePlayer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0012, $7000, $A82A;
	{$ENDC}

{
 *  TuneUnroll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneUnroll(tp: TunePlayer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0013, $7000, $A82A;
	{$ENDC}

{
 *  TuneSetNoteChannels()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneSetNoteChannels(tp: TunePlayer; count: UInt32; VAR noteChannelList: NoteChannel; playCallBackProc: TunePlayCallBackUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0014, $7000, $A82A;
	{$ENDC}

{
 *  TuneSetPartTranspose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneSetPartTranspose(tp: TunePlayer; part: UInt32; transpose: LONGINT; velocityShift: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0015, $7000, $A82A;
	{$ENDC}


{
 *  TuneGetNoteAllocator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneGetNoteAllocator(tp: TunePlayer): NoteAllocator;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0017, $7000, $A82A;
	{$ENDC}

{
 *  TuneSetSofter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneSetSofter(tp: TunePlayer; softer: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}

{
 *  TuneTask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneTask(tp: TunePlayer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0019, $7000, $A82A;
	{$ENDC}

{
 *  TuneSetBalance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneSetBalance(tp: TunePlayer; balance: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001A, $7000, $A82A;
	{$ENDC}

{
 *  TuneSetSoundLocalization()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneSetSoundLocalization(tp: TunePlayer; data: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001B, $7000, $A82A;
	{$ENDC}

{
 *  TuneSetHeaderWithSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneSetHeaderWithSize(tp: TunePlayer; VAR header: UInt32; size: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001C, $7000, $A82A;
	{$ENDC}

{ flags for part mix. }

CONST
	kTuneMixMute				= 1;							{  disable a part  }
	kTuneMixSolo				= 2;							{  if any parts soloed, play only soloed parts  }


	{
	 *  TuneSetPartMix()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION TuneSetPartMix(tp: TunePlayer; partNumber: UInt32; volume: LONGINT; balance: LONGINT; mixFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $001D, $7000, $A82A;
	{$ENDC}

{
 *  TuneGetPartMix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TuneGetPartMix(tp: TunePlayer; partNumber: UInt32; VAR volumeOut: LONGINT; VAR balanceOut: LONGINT; VAR mixFlagsOut: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $001E, $7000, $A82A;
	{$ENDC}






TYPE
	MusicOpWord							= UInt32;
	MusicOpWordPtr						= ^MusicOpWord;
	{	    QuickTime Music Track Event Formats:
	
	    At this time, QuickTime music tracks support 5 different event types -- REST events,
	    short NOTE events, short CONTROL events, short GENERAL events, Long NOTE events, 
	    long CONTROL events, and variable GENERAL events.
	 
	        • REST Event (4 bytes/event):
	    
	            (0 0 0) (5-bit UNUSED) (24-bit Rest Duration)
	        
	        • Short NOTE Events (4 bytes/event):
	    
	            (0 0 1) (5-bit Part) (6-bit Pitch) (7-bit Volume) (11-bit Duration)
	        
	            where:  Pitch is offset by 32 (Actual pitch = pitch field + 32)
	
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
	    
	            where:  Length field is the number of LONG words in the record.
	                    Lengths include the first and last long words (Minimum length = 2)
	                
	    The following event type values have not been used yet and are reserved for 
	    future expansion:
	        
	        • (1 0 0 0)     (8 bytes/event)
	        • (1 1 0 0)     (N bytes/event)
	        • (1 1 0 1)     (N bytes/event)
	        • (1 1 1 0)     (N bytes/event)
	        
	    For all events, the following generalizations apply:
	    
	        -   All duration values are specified in Millisecond units.
	        -   Pitch values are intended to map directly to the MIDI key numbers.
	        -   Controllers from 0 to 127 correspond to the standard MIDI controllers.
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
	kEventLengthFieldPos		= 30;							{  by looking at these two bits of the 1st or last word          }
	kEventLengthFieldWidth		= 2;							{  of an event you can determine the event length                 }
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

{$IFC TARGET_RT_LITTLE_ENDIAN }
	kEndMarkerValue				= $00000060;

{$ELSEC}
	kEndMarkerValue				= $60000000;

{$ENDC}  {TARGET_RT_LITTLE_ENDIAN}

	{  macros for extracting various fields from the QuickTime event records }


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
	kGeneralEventPartMix		= 12;							{  three longwords: Fixed volume, long balance, long flags  }

	{  Marker Event Defined Types       // marker is 60 ee vv vv in hex, where e = event type, and v = value }
	kMarkerEventEnd				= 0;							{  marker type 0 means: value 0 - stop, value != 0 - ignore }
	kMarkerEventBeat			= 1;							{  value 0 = single beat; anything else is 65536ths-of-a-beat (quarter note) }
	kMarkerEventTempo			= 2;							{  value same as beat marker, but indicates that a tempo event should be computed (based on where the next beat or tempo marker is) and emitted upon export }

	kCurrentlyNativeEndian		= 1;
	kCurrentlyNotNativeEndian	= 2;

	{	 UPP call backs 	}
	uppMusicMIDISendProcInfo = $00000FF0;
	uppMusicOfflineDataProcInfo = $00000FF0;
	uppTuneCallBackProcInfo = $000003C0;
	uppTunePlayCallBackProcInfo = $00000FC0;
	{
	 *  NewMusicMIDISendUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewMusicMIDISendUPP(userRoutine: MusicMIDISendProcPtr): MusicMIDISendUPP; { old name was NewMusicMIDISendProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMusicOfflineDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewMusicOfflineDataUPP(userRoutine: MusicOfflineDataProcPtr): MusicOfflineDataUPP; { old name was NewMusicOfflineDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTuneCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewTuneCallBackUPP(userRoutine: TuneCallBackProcPtr): TuneCallBackUPP; { old name was NewTuneCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTunePlayCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewTunePlayCallBackUPP(userRoutine: TunePlayCallBackProcPtr): TunePlayCallBackUPP; { old name was NewTunePlayCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeMusicMIDISendUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMusicMIDISendUPP(userUPP: MusicMIDISendUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMusicOfflineDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMusicOfflineDataUPP(userUPP: MusicOfflineDataUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTuneCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeTuneCallBackUPP(userUPP: TuneCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTunePlayCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeTunePlayCallBackUPP(userUPP: TunePlayCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeMusicMIDISendUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeMusicMIDISendUPP(self: ComponentInstance; refCon: LONGINT; VAR mmp: MusicMIDIPacket; userRoutine: MusicMIDISendUPP): ComponentResult; { old name was CallMusicMIDISendProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMusicOfflineDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeMusicOfflineDataUPP(SoundData: Ptr; numBytes: LONGINT; myRefCon: LONGINT; userRoutine: MusicOfflineDataUPP): ComponentResult; { old name was CallMusicOfflineDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTuneCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeTuneCallBackUPP({CONST}VAR status: TuneStatus; refCon: LONGINT; userRoutine: TuneCallBackUPP); { old name was CallTuneCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTunePlayCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeTunePlayCallBackUPP(VAR event: UInt32; seed: LONGINT; refCon: LONGINT; userRoutine: TunePlayCallBackUPP); { old name was CallTunePlayCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QuickTimeMusicIncludes}

{$ENDC} {__QUICKTIMEMUSIC__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

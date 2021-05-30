{
 	File:		SoundComponents.p
 
 	Contains:	Sound Components Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.3.1
 
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
 UNIT SoundComponents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SOUNDCOMPONENTS__}
{$SETC __SOUNDCOMPONENTS__ := 1}

{$I+}
{$SETC SoundComponentsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{	MixedMode.p													}

{$IFC UNDEFINED __SOUND__}
{$I Sound.p}
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

		AudioGetBass, AudioGetInfo, AudioGetMute, AudioGetOutputDevice,
		AudioGetTreble, AudioGetVolume, AudioMuteOnEvent, AudioSetBass,
		AudioSetMute, AudioSetToDefaults, AudioSetTreble, AudioSetVolume,
		OpenMixerSoundComponent, CloseMixerSoundComponent, SoundComponentAddSource,
		SoundComponentGetInfo, SoundComponentGetSource, SoundComponentGetSourceData,
		SoundComponentInitOutputDevice, SoundComponentPauseSource,
		SoundComponentPlaySourceBuffer, SoundComponentRemoveSource,
		SoundComponentSetInfo, SoundComponentSetOutput, SoundComponentSetSource,
		SoundComponentStartSource, SoundComponentStopSource
}
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{ constants}
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

CONST
	kNoSoundComponentType		= '****';
	kSoundComponentType			= 'sift';						{ component type }
	kSoundComponentPPCType		= 'nift';						{ component type for PowerPC code }
	kRate8SubType				= 'ratb';						{ 8-bit rate converter }
	kRate16SubType				= 'ratw';						{ 16-bit rate converter }
	kConverterSubType			= 'conv';						{ sample format converter }
	kSndSourceSubType			= 'sour';						{ generic source component }
	kMixerType					= 'mixr';
	kMixer8SubType				= 'mixb';						{ 8-bit mixer }
	kMixer16SubType				= 'mixw';						{ 16-bit mixer }
	kSoundOutputDeviceType		= 'sdev';						{ sound output component }
	kClassicSubType				= 'clas';						{ classic hardware, i.e. Mac Plus }
	kASCSubType					= 'asc ';						{ Apple Sound Chip device }
	kDSPSubType					= 'dsp ';						{ DSP device }
	kAwacsSubType				= 'awac';						{ Another of Will's Audio Chips device }
	kGCAwacsSubType				= 'awgc';						{ Awacs audio with Grand Central DMA }
	kSingerSubType				= 'sing';						{ Singer (via Whitney) based sound }
	kSinger2SubType				= 'sng2';						{ Singer 2 (via Whitney) for Acme }
	kWhitSubType				= 'whit';						{ Whit sound component for PrimeTime 3 }
	kSoundBlasterSubType		= 'sbls';						{ Sound Blaster for CHRP }
	kSoundCompressor			= 'scom';
	kSoundDecompressor			= 'sdec';
	kMace3SubType				= 'MAC3';						{ MACE 3:1 }
	kMace6SubType				= 'MAC6';						{ MACE 6:1 }
	kCDXA4SubType				= 'cdx4';						{ CD/XA 4:1 }
	kCDXA2SubType				= 'cdx2';						{ CD/XA 2:1 }
	kIMA4SubType				= 'ima4';						{ IMA 4:1 }
	kULawSubType				= 'ulaw';						{ µLaw 2:1 }
	kLittleEndianSubType		= 'sowt';						{ Little-endian }
	kAudioComponentType			= 'adio';						{ Audio components and sub-types }
	kAwacsPhoneSubType			= 'hphn';
	kAudioVisionSpeakerSubType	= 'telc';
	kAudioVisionHeadphoneSubType = 'telh';
	kPhilipsFaderSubType		= 'tvav';

{sound component set/get info selectors}
	siVolume					= 'volu';
	siHardwareVolume			= 'hvol';
	siSpeakerVolume				= 'svol';
	siHeadphoneVolume			= 'pvol';
	siHardwareVolumeSteps		= 'hstp';
	siHeadphoneVolumeSteps		= 'hdst';
	siHardwareMute				= 'hmut';
	siSpeakerMute				= 'smut';
	siHeadphoneMute				= 'pmut';
	siRateMultiplier			= 'rmul';
	siQuality					= 'qual';
	siWideStereo				= 'wide';
	siHardwareFormat			= 'hwfm';
	siPreMixerSoundComponent	= 'prmx';
	siPostMixerSoundComponent	= 'psmx';
	kOffsetBinary				= 'raw ';						{ format types }
	kTwosComplement				= 'twos';
	kMACE3Compression			= 'MAC3';
	kMACE6Compression			= 'MAC6';

{ features flags }
	k8BitRawIn					= $01;							{ data description }
	k8BitTwosIn					= $02;
	k16BitIn					= $04;
	kStereoIn					= $08;
	k8BitRawOut					= $0100;
	k8BitTwosOut				= $0200;
	k16BitOut					= $0400;
	kStereoOut					= $0800;
	kReverse					= $00010000;					{   function description }
	kRateConvert				= $00020000;
	kCreateSoundSource			= $00040000;
	kHighQuality				= $00400000;					{   performance description }
	kNonRealTime				= $00800000;

{quality flags}
{use interpolation in rate conversion}
	kBestQuality				= 0+(1 * (2**(0)));

{useful bit masks}
	kInputMask					= $000000FF;					{masks off input bits}
	kOutputMask					= $0000FF00;					{masks off output bits}
	kOutputShift				= 8;							{amount output bits are shifted}
	kActionMask					= $00FF0000;					{masks off action bits}
	kSoundComponentBits			= $00FFFFFF;

{SoundComponentPlaySourceBuffer action flags}
	kSourcePaused				= 0+(1 * (2**(0)));
	kPassThrough				= 0+(1 * (2**(16)));
	kNoSoundComponentChain		= 0+(1 * (2**(17)));
{flags for OpenMixerSoundComponent}
	kNoMixing					= 0+(1 * (2**(0)));				{don't mix source}
	kNoSampleRateConversion		= 0+(1 * (2**(1)));				{don't convert sample rate (i.e. 11 kHz -> 22 kHz)}
	kNoSampleSizeConversion		= 0+(1 * (2**(2)));				{don't convert sample size (i.e. 16 -> 8)}
	kNoSampleFormatConversion	= 0+(1 * (2**(3)));				{don't convert sample format (i.e. 'twos' -> 'raw ')}
	kNoChannelConversion		= 0+(1 * (2**(4)));				{don't convert stereo/mono}
	kNoDecompression			= 0+(1 * (2**(5)));				{don't decompress (i.e. 'MAC3' -> 'raw ')}
	kNoVolumeConversion			= 0+(1 * (2**(6)));				{don't apply volume}
	kNoRealtimeProcessing		= 0+(1 * (2**(7)));				{won't run at interrupt time}

{Audio Component constants}
{Values for whichChannel parameter}
	audioAllChannels			= 0;							{All channels (usually interpreted as both left and right)}
	audioLeftChannel			= 1;							{Left channel}
	audioRightChannel			= 2;							{Right channel}
{Values for mute parameter}
	audioUnmuted				= 0;							{Device is unmuted}
	audioMuted					= 1;							{Device is muted}
{Capabilities flags definitions}
	audioDoesMono				= 0+(1 * (2**(0)));				{Device supports mono output}
	audioDoesStereo				= 0+(1 * (2**(1)));				{Device supports stereo output}
	audioDoesIndependentChannels = 0+(1 * (2**(2)));			{Device supports independent software control of each channel}

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{ typedefs}
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{ShortFixed consists of an 8 bit, 2's complement integer part in the high byte,}
{with an 8 bit fractional part in the low byte; its range is -128 to 127.99609375}
	
TYPE
	ShortFixed = INTEGER;

	SoundParamBlockPtr = ^SoundParamBlock;
	SoundParamProcPtr = ProcPtr;  { FUNCTION SoundParam(VAR pb: SoundParamBlockPtr): BOOLEAN; }
	
	SoundParamUPP = UniversalProcPtr;
	SoundParamBlock = RECORD
		recordSize:				LONGINT;								{size of this record in bytes}
		desc:					SoundComponentData;						{description of sound buffer}
		rateMultiplier:			UnsignedFixed;							{rate multiplier to apply to sound}
		leftVolume:				INTEGER;								{volumes to apply to sound}
		rightVolume:			INTEGER;
		quality:				LONGINT;								{quality to apply to sound}
		filter:					ComponentInstance;						{filter to apply to sound}
		moreRtn:				SoundParamUPP;							{routine to call to get more data}
		completionRtn:			SoundParamUPP;							{routine to call when buffer is complete}
		refCon:					LONGINT;								{user refcon}
		result:					INTEGER;								{result}
	END;

{ private thing to reference a Sound Source }
	SoundSource = ^LONGINT;
	SoundSourcePtr						= ^SoundSource;
	SoundComponentLinkPtr = ^SoundComponentLink;
	SoundComponentLink = RECORD
		description:			ComponentDescription;					{ Describes the sound component }
		mixerID:				SoundSource;							{ Reserved by Apple }
		linkID:					SoundSourcePtr;							{ Reserved by Apple }
	END;

	AudioInfo = RECORD
		capabilitiesFlags:		LONGINT;								{Describes device capabilities}
		reserved:				LONGINT;								{Reserved by Apple}
		numVolumeSteps:			INTEGER;								{Number of significant increments between min and max volume}
	END;

	AudioInfoPtr = ^AudioInfo;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{ functions for sound components}
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{Sound Component dispatch selectors}

CONST
{these calls cannot be delegated}
	kSoundComponentInitOutputDeviceSelect = 1;
	kSoundComponentSetSourceSelect = 2;
	kSoundComponentGetSourceSelect = 3;
	kSoundComponentGetSourceDataSelect = 4;
	kSoundComponentSetOutputSelect = 5;
	kDelegatedSoundComponentSelectors = $0100;					{first selector that can be delegated up the chain}
{these calls can be delegated and have own range}
	kSoundComponentAddSourceSelect = kDelegatedSoundComponentSelectors + 1;
	kSoundComponentRemoveSourceSelect = kDelegatedSoundComponentSelectors + 2;
	kSoundComponentGetInfoSelect = kDelegatedSoundComponentSelectors + 3;
	kSoundComponentSetInfoSelect = kDelegatedSoundComponentSelectors + 4;
	kSoundComponentStartSourceSelect = kDelegatedSoundComponentSelectors + 5;
	kSoundComponentStopSourceSelect = kDelegatedSoundComponentSelectors + 6;
	kSoundComponentPauseSourceSelect = kDelegatedSoundComponentSelectors + 7;
	kSoundComponentPlaySourceBufferSelect = kDelegatedSoundComponentSelectors + 8;

{Audio Component selectors}
	kAudioGetVolumeSelect		= 0;
	kAudioSetVolumeSelect		= 1;
	kAudioGetMuteSelect			= 2;
	kAudioSetMuteSelect			= 3;
	kAudioSetToDefaultsSelect	= 4;
	kAudioGetInfoSelect			= 5;
	kAudioGetBassSelect			= 6;
	kAudioSetBassSelect			= 7;
	kAudioGetTrebleSelect		= 8;
	kAudioSetTrebleSelect		= 9;
	kAudioGetOutputDeviceSelect	= 10;
	kAudioMuteOnEventSelect		= 129;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{ Sound Manager 3.0 utilities}

FUNCTION OpenMixerSoundComponent(outputDescription: SoundComponentDataPtr; outputFlags: LONGINT; VAR mixerComponent: ComponentInstance): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0614, $0018, $A800;
	{$ENDC}
FUNCTION CloseMixerSoundComponent(ci: ComponentInstance): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0218, $0018, $A800;
	{$ENDC}
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{ basic sound component functions}
FUNCTION SoundComponentInitOutputDevice(ti: ComponentInstance; actions: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 4, 1, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentSetSource(ti: ComponentInstance; sourceID: SoundSource; source: ComponentInstance): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 8, 2, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentGetSource(ti: ComponentInstance; sourceID: SoundSource; VAR source: ComponentInstance): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 8, 3, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentGetSourceData(ti: ComponentInstance; VAR sourceData: SoundComponentDataPtr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 4, 4, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentSetOutput(ti: ComponentInstance; requested: SoundComponentDataPtr; VAR actual: SoundComponentDataPtr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 8, 5, $7000, $A82A;
	{$ENDC}
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{ junction methods for the mixer, must be called at non-interrupt level}
FUNCTION SoundComponentAddSource(ti: ComponentInstance; VAR sourceID: SoundSource): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 4, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentRemoveSource(ti: ComponentInstance; sourceID: SoundSource): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 4, $0102, $7000, $A82A;
	{$ENDC}
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{ info methods}
FUNCTION SoundComponentGetInfo(ti: ComponentInstance; sourceID: SoundSource; selector: OSType; infoPtr: UNIV Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentSetInfo(ti: ComponentInstance; sourceID: SoundSource; selector: OSType; infoPtr: UNIV Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, $0104, $7000, $A82A;
	{$ENDC}
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{ control methods}
FUNCTION SoundComponentStartSource(ti: ComponentInstance; count: INTEGER; VAR sources: SoundSource): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 6, $0105, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentStopSource(ti: ComponentInstance; count: INTEGER; VAR sources: SoundSource): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 6, $0106, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentPauseSource(ti: ComponentInstance; count: INTEGER; VAR sources: SoundSource): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 6, $0107, $7000, $A82A;
	{$ENDC}
FUNCTION SoundComponentPlaySourceBuffer(ti: ComponentInstance; sourceID: SoundSource; pb: SoundParamBlockPtr; actions: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 12, $0108, $7000, $A82A;
	{$ENDC}
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{ interface for Audio Components}
{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}
{Volume is described as a value between 0 and 1, with 0 indicating minimum
  volume and 1 indicating maximum volume; if the device doesn't support
  software control of volume, then a value of unimpErr is returned, indicating
  that these functions are not supported by the device}
FUNCTION AudioGetVolume(ac: ComponentInstance; whichChannel: INTEGER; VAR volume: ShortFixed): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 6, 0, $7000, $A82A;
	{$ENDC}
FUNCTION AudioSetVolume(ac: ComponentInstance; whichChannel: INTEGER; volume: ShortFixed): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 4, 1, $7000, $A82A;
	{$ENDC}
{If the device doesn't support software control of mute, then a value of unimpErr is}
{returned, indicating that these functions are not supported by the device}
FUNCTION AudioGetMute(ac: ComponentInstance; whichChannel: INTEGER; VAR mute: INTEGER): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 6, 2, $7000, $A82A;
	{$ENDC}
FUNCTION AudioSetMute(ac: ComponentInstance; whichChannel: INTEGER; mute: INTEGER): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 4, 3, $7000, $A82A;
	{$ENDC}
{AudioSetToDefaults causes the associated device to reset its volume and mute values}
{(and perhaps other characteristics, e.g. attenuation) to "factory default" settings}
FUNCTION AudioSetToDefaults(ac: ComponentInstance): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 0, 4, $7000, $A82A;
	{$ENDC}
{This routine is required; it must be implemented by all audio components}
FUNCTION AudioGetInfo(ac: ComponentInstance; info: AudioInfoPtr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 4, 5, $7000, $A82A;
	{$ENDC}
FUNCTION AudioGetBass(ac: ComponentInstance; whichChannel: INTEGER; VAR bass: INTEGER): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 6, 6, $7000, $A82A;
	{$ENDC}
FUNCTION AudioSetBass(ac: ComponentInstance; whichChannel: INTEGER; bass: INTEGER): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 4, 7, $7000, $A82A;
	{$ENDC}
FUNCTION AudioGetTreble(ac: ComponentInstance; whichChannel: INTEGER; VAR Treble: INTEGER): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 6, 8, $7000, $A82A;
	{$ENDC}
FUNCTION AudioSetTreble(ac: ComponentInstance; whichChannel: INTEGER; Treble: INTEGER): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 4, 9, $7000, $A82A;
	{$ENDC}
FUNCTION AudioGetOutputDevice(ac: ComponentInstance; VAR outputDevice: Component): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 4, 10, $7000, $A82A;
	{$ENDC}
{This is routine is private to the AudioVision component.  It enables the watching of the mute key.}
FUNCTION AudioMuteOnEvent(ac: ComponentInstance; muteOnEvent: INTEGER): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, 2, 129, $7000, $A82A;
	{$ENDC}
CONST
	uppSoundParamProcInfo = $000000D0; { FUNCTION (4 byte param): 1 byte result; }

FUNCTION NewSoundParamProc(userRoutine: SoundParamProcPtr): SoundParamUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallSoundParamProc(VAR pb: SoundParamBlockPtr; userRoutine: SoundParamUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SoundComponentsIncludes}

{$ENDC} {__SOUNDCOMPONENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

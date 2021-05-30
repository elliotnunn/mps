{
     File:       Sound.p
 
     Contains:   Sound Manager Interfaces.
 
     Version:    Technology: Sound Manager 3.6
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1986-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
                        * * *  N O T E  * * *

    This file has been updated to include Sound Manager 3.3 interfaces.

    Some of the Sound Manager 3.0 interfaces were not put into the InterfaceLib
    that originally shipped with the PowerMacs. These missing functions and the
    new 3.3 interfaces have been released in the SoundLib library for PowerPC
    developers to link with. The runtime library for these functions are
    installed by the Sound Manager. The following functions are found in SoundLib.

        GetCompressionInfo(), GetSoundPreference(), SetSoundPreference(),
        UnsignedFixedMulDiv(), SndGetInfo(), SndSetInfo(), GetSoundOutputInfo(),
        SetSoundOutputInfo(), GetCompressionName(), SoundConverterOpen(),
        SoundConverterClose(), SoundConverterGetBufferSizes(), SoundConverterBeginConversion(),
        SoundConverterConvertBuffer(), SoundConverterEndConversion(),
        AudioGetBass(), AudioGetInfo(), AudioGetMute(), AudioGetOutputDevice(),
        AudioGetTreble(), AudioGetVolume(), AudioMuteOnEvent(), AudioSetBass(),
        AudioSetMute(), AudioSetToDefaults(), AudioSetTreble(), AudioSetVolume(),
        OpenMixerSoundComponent(), CloseMixerSoundComponent(), SoundComponentAddSource(),
        SoundComponentGetInfo(), SoundComponentGetSource(), SoundComponentGetSourceData(),
        SoundComponentInitOutputDevice(), SoundComponentPauseSource(),
        SoundComponentPlaySourceBuffer(), SoundComponentRemoveSource(),
        SoundComponentSetInfo(), SoundComponentSetOutput(), SoundComponentSetSource(),
        SoundComponentStartSource(), SoundComponentStopSource(),
        ParseAIFFHeader(), ParseSndHeader(), SoundConverterGetInfo(), SoundConverterSetInfo()
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
        SetSoundVol, GetSoundVol
}
{
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   constants
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}
CONST twelfthRootTwo = 1.05946309435;


CONST
	soundListRsrc				= 'snd ';						{ Resource type used by Sound Manager }

	kSimpleBeepID				= 1;							{ reserved resource ID for Simple Beep }

	rate48khz					= $BB800000;					{ 48000.00000 in fixed-point }
	rate44khz					= $AC440000;					{ 44100.00000 in fixed-point }
	rate32khz					= $7D000000;					{ 32000.00000 in fixed-point }
	rate22050hz					= $56220000;					{ 22050.00000 in fixed-point }
	rate22khz					= $56EE8BA3;					{ 22254.54545 in fixed-point }
	rate16khz					= $3E800000;					{ 16000.00000 in fixed-point }
	rate11khz					= $2B7745D1;					{ 11127.27273 in fixed-point }
	rate11025hz					= $2B110000;					{ 11025.00000 in fixed-point }
	rate8khz					= $1F400000;					{  8000.00000 in fixed-point }

	{	synthesizer numbers for SndNewChannel	}
	sampledSynth				= 5;							{ sampled sound synthesizer }

{$IFC CALL_NOT_IN_CARBON }
	squareWaveSynth				= 1;							{ square wave synthesizer }
	waveTableSynth				= 3;							{ wave table synthesizer }
																{ old Sound Manager MACE synthesizer numbers }
	MACE3snthID					= 11;
	MACE6snthID					= 13;

{$ENDC}  {CALL_NOT_IN_CARBON}

	kMiddleC					= 60;							{ MIDI note value for middle C }

	kNoVolume					= 0;							{ setting for no sound volume }
	kFullVolume					= $0100;						{ 1.0, setting for full hardware output volume }

	stdQLength					= 128;

	dataOffsetFlag				= $8000;

	kUseOptionalOutputDevice	= -1;							{ only for Sound Manager 3.0 or later }

	notCompressed				= 0;							{ compression ID's }
	fixedCompression			= -1;							{ compression ID for fixed-sized compression }
	variableCompression			= -2;							{ compression ID for variable-sized compression }

	twoToOne					= 1;
	eightToThree				= 2;
	threeToOne					= 3;
	sixToOne					= 4;
	sixToOnePacketSize			= 8;
	threeToOnePacketSize		= 16;

	stateBlockSize				= 64;
	leftOverBlockSize			= 32;

	firstSoundFormat			= $0001;						{ general sound format }
	secondSoundFormat			= $0002;						{ special sampled sound format (HyperCard) }

{$IFC CALL_NOT_IN_CARBON }
	dbBufferReady				= $00000001;					{ double buffer is filled }
	dbLastBuffer				= $00000004;					{ last double buffer to play }

{$ENDC}  {CALL_NOT_IN_CARBON}

	sysBeepDisable				= $0000;						{ SysBeep() enable flags }
	sysBeepEnable				= $01;
	sysBeepSynchronous			= $02;							{ if bit set, make alert sounds synchronous }

	unitTypeNoSelection			= $FFFF;						{ unitTypes for AudioSelection.unitType }
	unitTypeSeconds				= $0000;

	stdSH						= $00;							{ Standard sound header encode value }
	extSH						= $FF;							{ Extended sound header encode value }
	cmpSH						= $FE;							{ Compressed sound header encode value }

	{	command numbers for SndDoCommand and SndDoImmediate	}
	nullCmd						= 0;
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
	volumeCmd					= 46;							{ sound manager 3.0 or later only }
	getVolumeCmd				= 47;							{ sound manager 3.0 or later only }
	clockComponentCmd			= 50;							{ sound manager 3.2.1 or later only }
	getClockComponentCmd		= 51;							{ sound manager 3.2.1 or later only }
	scheduledSoundCmd			= 52;							{ sound manager 3.3 or later only }
	linkSoundComponentsCmd		= 53;							{ sound manager 3.3 or later only }
	soundCmd					= 80;
	bufferCmd					= 81;
	rateMultiplierCmd			= 86;
	getRateMultiplierCmd		= 87;

{$IFC CALL_NOT_IN_CARBON }
	{	command numbers for SndDoCommand and SndDoImmediate that are not available for use in Carbon 	}
	initCmd						= 1;
	freeCmd						= 2;
	totalLoadCmd				= 26;
	loadCmd						= 27;
	freqDurationCmd				= 40;
	restCmd						= 41;
	freqCmd						= 42;
	ampCmd						= 43;
	timbreCmd					= 44;
	getAmpCmd					= 45;
	waveTableCmd				= 60;
	phaseCmd					= 61;
	rateCmd						= 82;
	continueCmd					= 83;
	doubleBufferCmd				= 84;
	getRateCmd					= 85;
	sizeCmd						= 90;							{ obsolete command }
	convertCmd					= 91;							{ obsolete MACE command }

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC OLDROUTINENAMES }
	{	channel initialization parameters	}
	waveInitChannelMask			= $07;
	waveInitChannel0			= $04;							{ wave table only, Sound Manager 2.0 and earlier }
	waveInitChannel1			= $05;							{ wave table only, Sound Manager 2.0 and earlier }
	waveInitChannel2			= $06;							{ wave table only, Sound Manager 2.0 and earlier }
	waveInitChannel3			= $07;							{ wave table only, Sound Manager 2.0 and earlier }
	initChan0					= $04;							{ obsolete spelling }
	initChan1					= $05;							{ obsolete spelling }
	initChan2					= $06;							{ obsolete spelling }
	initChan3					= $07;							{ obsolete spelling }

	outsideCmpSH				= 0;							{ obsolete MACE constant }
	insideCmpSH					= 1;							{ obsolete MACE constant }
	aceSuccess					= 0;							{ obsolete MACE constant }
	aceMemFull					= 1;							{ obsolete MACE constant }
	aceNilBlock					= 2;							{ obsolete MACE constant }
	aceBadComp					= 3;							{ obsolete MACE constant }
	aceBadEncode				= 4;							{ obsolete MACE constant }
	aceBadDest					= 5;							{ obsolete MACE constant }
	aceBadCmd					= 6;							{ obsolete MACE constant }

{$ENDC}  {OLDROUTINENAMES}

	initChanLeft				= $0002;						{ left stereo channel }
	initChanRight				= $0003;						{ right stereo channel }
	initNoInterp				= $0004;						{ no linear interpolation }
	initNoDrop					= $0008;						{ no drop-sample conversion }
	initMono					= $0080;						{ monophonic channel }
	initStereo					= $00C0;						{ stereo channel }
	initMACE3					= $0300;						{ MACE 3:1 }
	initMACE6					= $0400;						{ MACE 6:1 }
	initPanMask					= $0003;						{ mask for right/left pan values }
	initSRateMask				= $0030;						{ mask for sample rate values }
	initStereoMask				= $00C0;						{ mask for mono/stereo values }
	initCompMask				= $FF00;						{ mask for compression IDs }

	{	Get&Set Sound Information Selectors	}
	siActiveChannels			= 'chac';						{ active channels }
	siActiveLevels				= 'lmac';						{ active meter levels }
	siAGCOnOff					= 'agc ';						{ automatic gain control state }
	siAsync						= 'asyn';						{ asynchronous capability }
	siAVDisplayBehavior			= 'avdb';
	siChannelAvailable			= 'chav';						{ number of channels available }
	siCompressionAvailable		= 'cmav';						{ compression types available }
	siCompressionChannels		= 'cpct';						{ compressor's number of channels }
	siCompressionFactor			= 'cmfa';						{ current compression factor }
	siCompressionHeader			= 'cmhd';						{ return compression header }
	siCompressionNames			= 'cnam';						{ compression type names available }
	siCompressionParams			= 'evaw';						{ compression parameters }
	siCompressionSampleRate		= 'cprt';						{ compressor's sample rate }
	siCompressionType			= 'comp';						{ current compression type }
	siContinuous				= 'cont';						{ continous recording }
	siDecompressionParams		= 'wave';						{ decompression parameters }
	siDeviceBufferInfo			= 'dbin';						{ size of interrupt buffer }
	siDeviceConnected			= 'dcon';						{ input device connection status }
	siDeviceIcon				= 'icon';						{ input device icon }
	siDeviceName				= 'name';						{ input device name }
	siEQSpectrumBands			= 'eqsb';						{  number of spectrum bands }
	siEQSpectrumLevels			= 'eqlv';						{  gets spectum meter levels }
	siEQSpectrumOnOff			= 'eqlo';						{  turn on/off spectum meter levels }
	siEQSpectrumResolution		= 'eqrs';						{  set the resolution of the FFT, 0 = low res (<=16 bands), 1 = high res (16-64 bands) }
	siEQToneControlGain			= 'eqtg';						{  set the bass and treble gain }
	siEQToneControlOnOff		= 'eqtc';						{  turn on equalizer attenuation }
	siHardwareBalance			= 'hbal';
	siHardwareBalanceSteps		= 'hbls';
	siHardwareBass				= 'hbas';
	siHardwareBassSteps			= 'hbst';
	siHardwareBusy				= 'hwbs';						{ sound hardware is in use }
	siHardwareFormat			= 'hwfm';						{ get hardware format }
	siHardwareMute				= 'hmut';						{ mute state of all hardware }
	siHardwareMuteNoPrefs		= 'hmnp';						{ mute state of all hardware, but don't store in prefs  }
	siHardwareTreble			= 'htrb';
	siHardwareTrebleSteps		= 'hwts';
	siHardwareVolume			= 'hvol';						{ volume level of all hardware }
	siHardwareVolumeSteps		= 'hstp';						{ number of volume steps for hardware }
	siHeadphoneMute				= 'pmut';						{ mute state of headphones }
	siHeadphoneVolume			= 'pvol';						{ volume level of headphones }
	siHeadphoneVolumeSteps		= 'hdst';						{ number of volume steps for headphones }
	siInputAvailable			= 'inav';						{ input sources available }
	siInputGain					= 'gain';						{ input gain }
	siInputSource				= 'sour';						{ input source selector }
	siInputSourceNames			= 'snam';						{ input source names }
	siLevelMeterOnOff			= 'lmet';						{ level meter state }
	siModemGain					= 'mgai';						{ modem input gain }
	siMonitorAvailable			= 'mnav';
	siMonitorSource				= 'mons';
	siNumberChannels			= 'chan';						{ current number of channels }
	siOptionsDialog				= 'optd';						{ display options dialog }
	siOSTypeInputSource			= 'inpt';						{ input source by OSType }
	siOSTypeInputAvailable		= 'inav';						{ list of available input source OSTypes }
	siOutputDeviceName			= 'onam';						{ output device name }
	siPlayThruOnOff				= 'plth';						{ playthrough state }
	siPostMixerSoundComponent	= 'psmx';						{ install post-mixer effect }
	siPreMixerSoundComponent	= 'prmx';						{ install pre-mixer effect }
	siQuality					= 'qual';						{ quality setting }
	siRateMultiplier			= 'rmul';						{ throttle rate setting }
	siRecordingQuality			= 'qual';						{ recording quality }
	siSampleRate				= 'srat';						{ current sample rate }
	siSampleRateAvailable		= 'srav';						{ sample rates available }
	siSampleSize				= 'ssiz';						{ current sample size }
	siSampleSizeAvailable		= 'ssav';						{ sample sizes available }
	siSetupCDAudio				= 'sucd';						{ setup sound hardware for CD audio }
	siSetupModemAudio			= 'sumd';						{ setup sound hardware for modem audio }
	siSlopeAndIntercept			= 'flap';						{ floating point variables for conversion }
	siSoundClock				= 'sclk';
	siUseThisSoundClock			= 'sclc';						{ sdev uses this to tell the mixer to use his sound clock }
	siSpeakerMute				= 'smut';						{ mute state of all built-in speaker }
	siSpeakerVolume				= 'svol';						{ volume level of built-in speaker }
	siSSpCPULoadLimit			= '3dll';
	siSSpLocalization			= '3dif';
	siSSpSpeakerSetup			= '3dst';
	siStereoInputGain			= 'sgai';						{ stereo input gain }
	siSubwooferMute				= 'bmut';						{ mute state of sub-woofer }
	siTerminalType				= 'ttyp';						{  usb terminal type  }
	siTwosComplementOnOff		= 'twos';						{ two's complement state }
	siVendorProduct				= 'vpro';						{  vendor and product ID  }
	siVolume					= 'volu';						{ volume level of source }
	siVoxRecordInfo				= 'voxr';						{ VOX record parameters }
	siVoxStopInfo				= 'voxs';						{ VOX stop parameters }
	siWideStereo				= 'wide';						{ wide stereo setting }
	siSupportedExtendedFlags	= 'exfl';						{ which flags are supported in Extended sound data structures }
	siRateConverterRollOffSlope	= 'rcdb';						{ the roll-off slope for the rate converter's filter, in whole dB as a long this value is a long whose range is from 20 (worst quality/fastest performance) to 90 (best quality/slowest performance) }
	siOutputLatency				= 'olte';						{ latency of sound output component }

	siCloseDriver				= 'clos';						{ reserved for internal use only }
	siInitializeDriver			= 'init';						{ reserved for internal use only }
	siPauseRecording			= 'paus';						{ reserved for internal use only }
	siUserInterruptProc			= 'user';						{ reserved for internal use only }

	{  input source Types }
	kInvalidSource				= $FFFFFFFF;					{ this source may be returned from GetInfo if no other source is the monitored source }
	kNoSource					= 'none';						{ no source selection }
	kCDSource					= 'cd  ';						{ internal CD player input }
	kExtMicSource				= 'emic';						{ external mic input }
	kSoundInSource				= 'sinj';						{ sound input jack }
	kRCAInSource				= 'irca';						{ RCA jack input }
	kTVFMTunerSource			= 'tvfm';
	kDAVInSource				= 'idav';						{ DAV analog input }
	kIntMicSource				= 'imic';						{ internal mic input }
	kMediaBaySource				= 'mbay';						{ media bay input }
	kModemSource				= 'modm';						{ modem input (internal modem on desktops, PCI input on PowerBooks) }
	kPCCardSource				= 'pcm ';						{ PC Card pwm input }
	kZoomVideoSource			= 'zvpc';						{ zoom video input }
	kDVDSource					= 'dvda';						{  DVD audio input }
	kMicrophoneArray			= 'mica';						{  microphone array }

	{ Sound Component Types and Subtypes }
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
	kSoundInputDeviceType		= 'sinp';						{ sound input component }
	kWaveInSubType				= 'wavi';						{ Windows waveIn }
	kWaveInSnifferSubType		= 'wisn';						{ Windows waveIn sniffer }
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
	kWaveOutSubType				= 'wavo';						{ Windows waveOut }
	kWaveOutSnifferSubType		= 'wosn';						{ Windows waveOut sniffer }
	kDirectSoundSubType			= 'dsnd';						{ Windows DirectSound }
	kDirectSoundSnifferSubType	= 'dssn';						{ Windows DirectSound sniffer }
	kUNIXsdevSubType			= 'un1x';						{ UNIX base sdev }
	kUSBSubType					= 'usb ';						{ USB device }
	kBlueBoxSubType				= 'bsnd';						{ Blue Box sound component }
	kSoundCompressor			= 'scom';
	kSoundDecompressor			= 'sdec';
	kAudioComponentType			= 'adio';						{ Audio components and sub-types }
	kAwacsPhoneSubType			= 'hphn';
	kAudioVisionSpeakerSubType	= 'telc';
	kAudioVisionHeadphoneSubType = 'telh';
	kPhilipsFaderSubType		= 'tvav';
	kSGSToneSubType				= 'sgs0';
	kSoundEffectsType			= 'snfx';						{ sound effects type }
	kEqualizerSubType			= 'eqal';						{ frequency equalizer }
	kSSpLocalizationSubType		= 'snd3';

	{ Format Types }
	kSoundNotCompressed			= 'NONE';						{ sound is not compressed }
	k8BitOffsetBinaryFormat		= 'raw ';						{ 8-bit offset binary }
	k16BitBigEndianFormat		= 'twos';						{ 16-bit big endian }
	k16BitLittleEndianFormat	= 'sowt';						{ 16-bit little endian }
	kFloat32Format				= 'fl32';						{ 32-bit floating point }
	kFloat64Format				= 'fl64';						{ 64-bit floating point }
	k24BitFormat				= 'in24';						{ 24-bit integer }
	k32BitFormat				= 'in32';						{ 32-bit integer }
	k32BitLittleEndianFormat	= '23ni';						{ 32-bit little endian integer  }
	kMACE3Compression			= 'MAC3';						{ MACE 3:1 }
	kMACE6Compression			= 'MAC6';						{ MACE 6:1 }
	kCDXA4Compression			= 'cdx4';						{ CD/XA 4:1 }
	kCDXA2Compression			= 'cdx2';						{ CD/XA 2:1 }
	kIMACompression				= 'ima4';						{ IMA 4:1 }
	kULawCompression			= 'ulaw';						{ µLaw 2:1 }
	kALawCompression			= 'alaw';						{ aLaw 2:1 }
	kMicrosoftADPCMFormat		= $6D730002;					{ Microsoft ADPCM - ACM code 2 }
	kDVIIntelIMAFormat			= $6D730011;					{ DVI/Intel IMA ADPCM - ACM code 17 }
	kDVAudioFormat				= 'dvca';						{ DV Audio }
	kQDesignCompression			= 'QDMC';						{ QDesign music }
	kQDesign2Compression		= 'QDM2';						{ QDesign2 music }
	kQUALCOMMCompression		= 'Qclp';						{ QUALCOMM PureVoice }
	kOffsetBinary				= 'raw ';						{ for compatibility }
	kTwosComplement				= 'twos';						{ for compatibility }
	kLittleEndianFormat			= 'sowt';						{ for compatibility }
	kMPEGLayer3Format			= $6D730055;					{ MPEG Layer 3, CBR only (pre QT4.1) }
	kFullMPEGLay3Format			= '.mp3';						{ MPEG Layer 3, CBR & VBR (QT4.1 and later) }

{$IFC TARGET_RT_LITTLE_ENDIAN }
	k16BitNativeEndianFormat	= 'sowt';
	k16BitNonNativeEndianFormat	= 'twos';

{$ELSEC}
	k16BitNativeEndianFormat	= 'twos';
	k16BitNonNativeEndianFormat	= 'sowt';

{$ENDC}  {TARGET_RT_LITTLE_ENDIAN}

	{ Features Flags }
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
	kVMAwareness				= $00200000;					{  component will hold its memory }
	kHighQuality				= $00400000;					{   performance description }
	kNonRealTime				= $00800000;

	{ SoundComponentPlaySourceBuffer action flags }
	kSourcePaused				= $01;
	kPassThrough				= $00010000;
	kNoSoundComponentChain		= $00020000;

	{ SoundParamBlock flags, usefull for OpenMixerSoundComponent }
	kNoMixing					= $01;							{ don't mix source }
	kNoSampleRateConversion		= $02;							{ don't convert sample rate (i.e. 11 kHz -> 22 kHz) }
	kNoSampleSizeConversion		= $04;							{ don't convert sample size (i.e. 16 -> 8) }
	kNoSampleFormatConversion	= $08;							{ don't convert sample format (i.e. 'twos' -> 'raw ') }
	kNoChannelConversion		= $10;							{ don't convert stereo/mono }
	kNoDecompression			= $20;							{ don't decompress (i.e. 'MAC3' -> 'raw ') }
	kNoVolumeConversion			= $40;							{ don't apply volume }
	kNoRealtimeProcessing		= $80;							{ won't run at interrupt time }
	kScheduledSource			= $0100;						{ source is scheduled }
	kNonInterleavedBuffer		= $0200;						{ buffer is not interleaved samples }
	kNonPagingMixer				= $0400;						{ if VM is on, use the non-paging mixer }
	kSoundConverterMixer		= $0800;						{ the mixer is to be used by the SoundConverter }
	kPagingMixer				= $1000;						{ the mixer is to be used as a paging mixer when VM is on }
	kVMAwareMixer				= $2000;						{ passed to the output device when the SM is going to deal with VM safety }
	kExtendedSoundData			= $4000;						{ SoundComponentData record is actually an ExtendedSoundComponentData }

	{ SoundParamBlock quality settings }
	kBestQuality				= $01;							{ use interpolation in rate conversion }

	{ useful bit masks }
	kInputMask					= $000000FF;					{ masks off input bits }
	kOutputMask					= $0000FF00;					{ masks off output bits }
	kOutputShift				= 8;							{ amount output bits are shifted }
	kActionMask					= $00FF0000;					{ masks off action bits }
	kSoundComponentBits			= $00FFFFFF;

	{ audio atom types }
	kAudioFormatAtomType		= 'frma';
	kAudioEndianAtomType		= 'enda';
	kAudioVBRAtomType			= 'vbra';
	kAudioTerminatorAtomType	= 0;

	{ siAVDisplayBehavior types }
	kAVDisplayHeadphoneRemove	= 0;							{  monitor does not have a headphone attached }
	kAVDisplayHeadphoneInsert	= 1;							{  monitor has a headphone attached }
	kAVDisplayPlainTalkRemove	= 2;							{  monitor either sending no input through CPU input port or unable to tell if input is coming in }
	kAVDisplayPlainTalkInsert	= 3;							{  monitor sending PlainTalk level microphone source input through sound input port }

	{ Audio Component constants }
																{ Values for whichChannel parameter }
	audioAllChannels			= 0;							{ All channels (usually interpreted as both left and right) }
	audioLeftChannel			= 1;							{ Left channel }
	audioRightChannel			= 2;							{ Right channel }
																{ Values for mute parameter }
	audioUnmuted				= 0;							{ Device is unmuted }
	audioMuted					= 1;							{ Device is muted }
																{ Capabilities flags definitions }
	audioDoesMono				= $00000001;					{ Device supports mono output }
	audioDoesStereo				= $00000002;					{ Device supports stereo output }
	audioDoesIndependentChannels = $00000004;					{ Device supports independent software control of each channel }

	{	Sound Input Qualities	}
	siCDQuality					= 'cd  ';						{ 44.1kHz, stereo, 16 bit }
	siBestQuality				= 'best';						{ 22kHz, mono, 8 bit }
	siBetterQuality				= 'betr';						{ 22kHz, mono, MACE 3:1 }
	siGoodQuality				= 'good';						{ 22kHz, mono, MACE 6:1 }
	siNoneQuality				= 'none';						{ settings don't match any quality for a get call }

	siDeviceIsConnected			= 1;							{ input device is connected and ready for input }
	siDeviceNotConnected		= 0;							{ input device is not connected }
	siDontKnowIfConnected		= -1;							{ can't tell if input device is connected }
	siReadPermission			= 0;							{ permission passed to SPBOpenDevice }
	siWritePermission			= 1;							{ permission passed to SPBOpenDevice }

	{ flags that SoundConverterFillBuffer will return }
	kSoundConverterDidntFillBuffer = $01;						{ set if the converter couldn't completely satisfy a SoundConverterFillBuffer request }
	kSoundConverterHasLeftOverData = $02;						{ set if the converter had left over data after completely satisfying a SoundConverterFillBuffer call }

	{  flags for extendedFlags fields of ExtendedSoundComponentData, ExtendedSoundParamBlock, and ExtendedScheduledSoundHeader }
	kExtendedSoundSampleCountNotValid = $00000001;				{  set if sampleCount of SoundComponentData isn't meaningful; use buffer size instead }
	kExtendedSoundBufferSizeValid = $00000002;					{  set if bufferSize field is valid }

	{
	  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	   typedefs
	  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	}


TYPE
	SndCommandPtr = ^SndCommand;
	SndCommand = PACKED RECORD
		cmd:					UInt16;
		param1:					INTEGER;
		param2:					LONGINT;
	END;

	SndChannelPtr = ^SndChannel;
{$IFC TYPED_FUNCTION_POINTERS}
	SndCallBackProcPtr = PROCEDURE(chan: SndChannelPtr; VAR cmd: SndCommand);
{$ELSEC}
	SndCallBackProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	SndCallBackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SndCallBackUPP = UniversalProcPtr;
{$ENDC}	
	SndChannel = PACKED RECORD
		nextChan:				SndChannelPtr;
		firstMod:				Ptr;									{  reserved for the Sound Manager  }
		callBack:				SndCallBackUPP;
		userInfo:				LONGINT;
		wait:					LONGINT;								{  The following is for internal Sound Manager use only. }
		cmdInProgress:			SndCommand;
		flags:					INTEGER;
		qLength:				INTEGER;
		qHead:					INTEGER;
		qTail:					INTEGER;
		queue:					ARRAY [0..127] OF SndCommand;
	END;


CONST
	uppSndCallBackProcInfo = $000003C0;
	{
	 *  NewSndCallBackUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewSndCallBackUPP(userRoutine: SndCallBackProcPtr): SndCallBackUPP; { old name was NewSndCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeSndCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSndCallBackUPP(userUPP: SndCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeSndCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeSndCallBackUPP(chan: SndChannelPtr; VAR cmd: SndCommand; userRoutine: SndCallBackUPP); { old name was CallSndCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{MACE structures}

TYPE
	StateBlockPtr = ^StateBlock;
	StateBlock = RECORD
		stateVar:				ARRAY [0..63] OF INTEGER;
	END;

	LeftOverBlockPtr = ^LeftOverBlock;
	LeftOverBlock = RECORD
		count:					UInt32;
		sampleArea:				ARRAY [0..31] OF SInt8;
	END;

	ModRefPtr = ^ModRef;
	ModRef = RECORD
		modNumber:				UInt16;
		modInit:				LONGINT;
	END;

	SndListResourcePtr = ^SndListResource;
	SndListResource = RECORD
		format:					INTEGER;
		numModifiers:			INTEGER;
		modifierPart:			ARRAY [0..0] OF ModRef;
		numCommands:			INTEGER;
		commandPart:			ARRAY [0..0] OF SndCommand;
		dataPart:				SInt8;
	END;

	SndListPtr							= ^SndListResource;
	SndListHandle						= ^SndListPtr;
	SndListHndl							= SndListHandle;
	{	HyperCard sound resource format	}
	Snd2ListResourcePtr = ^Snd2ListResource;
	Snd2ListResource = RECORD
		format:					INTEGER;
		refCount:				INTEGER;
		numCommands:			INTEGER;
		commandPart:			ARRAY [0..0] OF SndCommand;
		dataPart:				SInt8;
	END;

	Snd2ListPtr							= ^Snd2ListResource;
	Snd2ListHandle						= ^Snd2ListPtr;
	Snd2ListHndl						= Snd2ListHandle;
	SoundHeaderPtr = ^SoundHeader;
	SoundHeader = PACKED RECORD
		samplePtr:				Ptr;									{ if NIL then samples are in sampleArea }
		length:					UInt32;									{ length of sound in bytes }
		sampleRate:				UnsignedFixed;							{ sample rate for this sound }
		loopStart:				UInt32;									{ start of looping portion }
		loopEnd:				UInt32;									{ end of looping portion }
		encode:					UInt8;									{ header encoding }
		baseFrequency:			UInt8;									{ baseFrequency value }
		sampleArea:				PACKED ARRAY [0..0] OF UInt8;			{ space for when samples follow directly }
	END;

	CmpSoundHeaderPtr = ^CmpSoundHeader;
	CmpSoundHeader = PACKED RECORD
		samplePtr:				Ptr;									{ if nil then samples are in sample area }
		numChannels:			UInt32;									{ number of channels i.e. mono = 1 }
		sampleRate:				UnsignedFixed;							{ sample rate in Apples Fixed point representation }
		loopStart:				UInt32;									{ loopStart of sound before compression }
		loopEnd:				UInt32;									{ loopEnd of sound before compression }
		encode:					UInt8;									{ data structure used , stdSH, extSH, or cmpSH }
		baseFrequency:			UInt8;									{ same meaning as regular SoundHeader }
		numFrames:				UInt32;									{ length in frames ( packetFrames or sampleFrames ) }
		AIFFSampleRate:			extended80;								{ IEEE sample rate }
		markerChunk:			Ptr;									{ sync track }
		format:					OSType;									{ data format type, was futureUse1 }
		futureUse2:				UInt32;									{ reserved by Apple }
		stateVars:				StateBlockPtr;							{ pointer to State Block }
		leftOverSamples:		LeftOverBlockPtr;						{ used to save truncated samples between compression calls }
		compressionID:			INTEGER;								{ 0 means no compression, non zero means compressionID }
		packetSize:				UInt16;									{ number of bits in compressed sample packet }
		snthID:					UInt16;									{ resource ID of Sound Manager snth that contains NRT C/E }
		sampleSize:				UInt16;									{ number of bits in non-compressed sample }
		sampleArea:				PACKED ARRAY [0..0] OF UInt8;			{ space for when samples follow directly }
	END;

	ExtSoundHeaderPtr = ^ExtSoundHeader;
	ExtSoundHeader = PACKED RECORD
		samplePtr:				Ptr;									{ if nil then samples are in sample area }
		numChannels:			UInt32;									{ number of channels,  ie mono = 1 }
		sampleRate:				UnsignedFixed;							{ sample rate in Apples Fixed point representation }
		loopStart:				UInt32;									{ same meaning as regular SoundHeader }
		loopEnd:				UInt32;									{ same meaning as regular SoundHeader }
		encode:					UInt8;									{ data structure used , stdSH, extSH, or cmpSH }
		baseFrequency:			UInt8;									{ same meaning as regular SoundHeader }
		numFrames:				UInt32;									{ length in total number of frames }
		AIFFSampleRate:			extended80;								{ IEEE sample rate }
		markerChunk:			Ptr;									{ sync track }
		instrumentChunks:		Ptr;									{ AIFF instrument chunks }
		AESRecording:			Ptr;
		sampleSize:				UInt16;									{ number of bits in sample }
		futureUse1:				UInt16;									{ reserved by Apple }
		futureUse2:				UInt32;									{ reserved by Apple }
		futureUse3:				UInt32;									{ reserved by Apple }
		futureUse4:				UInt32;									{ reserved by Apple }
		sampleArea:				PACKED ARRAY [0..0] OF UInt8;			{ space for when samples follow directly }
	END;

	SoundHeaderUnionPtr = ^SoundHeaderUnion;
	SoundHeaderUnion = RECORD
		CASE INTEGER OF
		0: (
			stdHeader:			SoundHeader;
			);
		1: (
			cmpHeader:			CmpSoundHeader;
			);
		2: (
			extHeader:			ExtSoundHeader;
			);
	END;

	ConversionBlockPtr = ^ConversionBlock;
	ConversionBlock = RECORD
		destination:			INTEGER;
		unused:					INTEGER;
		inputPtr:				CmpSoundHeaderPtr;
		outputPtr:				CmpSoundHeaderPtr;
	END;

	{  ScheduledSoundHeader flags }

CONST
	kScheduledSoundDoScheduled	= $01;
	kScheduledSoundDoCallBack	= $02;
	kScheduledSoundExtendedHdr	= $04;


TYPE
	ScheduledSoundHeaderPtr = ^ScheduledSoundHeader;
	ScheduledSoundHeader = RECORD
		u:						SoundHeaderUnion;
		flags:					LONGINT;
		reserved:				INTEGER;
		callBackParam1:			INTEGER;
		callBackParam2:			LONGINT;
		startTime:				TimeRecord;
	END;

	ExtendedScheduledSoundHeaderPtr = ^ExtendedScheduledSoundHeader;
	ExtendedScheduledSoundHeader = RECORD
		u:						SoundHeaderUnion;
		flags:					LONGINT;
		reserved:				INTEGER;
		callBackParam1:			INTEGER;
		callBackParam2:			LONGINT;
		startTime:				TimeRecord;
		recordSize:				LONGINT;
		extendedFlags:			LONGINT;
		bufferSize:				LONGINT;
	END;

	SMStatusPtr = ^SMStatus;
	SMStatus = PACKED RECORD
		smMaxCPULoad:			INTEGER;
		smNumChannels:			INTEGER;
		smCurCPULoad:			INTEGER;
	END;

	SCStatusPtr = ^SCStatus;
	SCStatus = RECORD
		scStartTime:			UnsignedFixed;
		scEndTime:				UnsignedFixed;
		scCurrentTime:			UnsignedFixed;
		scChannelBusy:			BOOLEAN;
		scChannelDisposed:		BOOLEAN;
		scChannelPaused:		BOOLEAN;
		scUnused:				BOOLEAN;
		scChannelAttributes:	UInt32;
		scCPULoad:				LONGINT;
	END;

	AudioSelectionPtr = ^AudioSelection;
	AudioSelection = PACKED RECORD
		unitType:				LONGINT;
		selStart:				UnsignedFixed;
		selEnd:					UnsignedFixed;
	END;

{$IFC CALL_NOT_IN_CARBON }
	SndDoubleBufferPtr = ^SndDoubleBuffer;
	SndDoubleBuffer = PACKED RECORD
		dbNumFrames:			LONGINT;
		dbFlags:				LONGINT;
		dbUserInfo:				ARRAY [0..1] OF LONGINT;
		dbSoundData:			ARRAY [0..0] OF SInt8;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	SndDoubleBackProcPtr = PROCEDURE(channel: SndChannelPtr; doubleBufferPtr: SndDoubleBufferPtr);
{$ELSEC}
	SndDoubleBackProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	SndDoubleBackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SndDoubleBackUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppSndDoubleBackProcInfo = $000003C0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewSndDoubleBackUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewSndDoubleBackUPP(userRoutine: SndDoubleBackProcPtr): SndDoubleBackUPP; { old name was NewSndDoubleBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeSndDoubleBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeSndDoubleBackUPP(userUPP: SndDoubleBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeSndDoubleBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeSndDoubleBackUPP(channel: SndChannelPtr; doubleBufferPtr: SndDoubleBufferPtr; userRoutine: SndDoubleBackUPP); { old name was CallSndDoubleBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

TYPE
	SndDoubleBufferHeaderPtr = ^SndDoubleBufferHeader;
	SndDoubleBufferHeader = PACKED RECORD
		dbhNumChannels:			INTEGER;
		dbhSampleSize:			INTEGER;
		dbhCompressionID:		INTEGER;
		dbhPacketSize:			INTEGER;
		dbhSampleRate:			UnsignedFixed;
		dbhBufferPtr:			ARRAY [0..1] OF SndDoubleBufferPtr;
		dbhDoubleBack:			SndDoubleBackUPP;
	END;

	SndDoubleBufferHeader2Ptr = ^SndDoubleBufferHeader2;
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

{$ENDC}  {CALL_NOT_IN_CARBON}

	SoundInfoListPtr = ^SoundInfoList;
	SoundInfoList = PACKED RECORD
		count:					INTEGER;
		infoHandle:				Handle;
	END;

	SoundComponentDataPtr = ^SoundComponentData;
	SoundComponentData = RECORD
		flags:					LONGINT;
		format:					OSType;
		numChannels:			INTEGER;
		sampleSize:				INTEGER;
		sampleRate:				UnsignedFixed;
		sampleCount:			LONGINT;
		buffer:					Ptr;
		reserved:				LONGINT;
	END;

	ExtendedSoundComponentDataPtr = ^ExtendedSoundComponentData;
	ExtendedSoundComponentData = RECORD
		desc:					SoundComponentData;						{ description of sound buffer }
		recordSize:				LONGINT;								{ size of this record in bytes }
		extendedFlags:			LONGINT;								{ flags for extended record }
		bufferSize:				LONGINT;								{ size of buffer in bytes }
	END;

	SoundParamBlockPtr = ^SoundParamBlock;
{$IFC TYPED_FUNCTION_POINTERS}
	SoundParamProcPtr = FUNCTION(VAR pb: SoundParamBlockPtr): BOOLEAN;
{$ELSEC}
	SoundParamProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	SoundParamUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SoundParamUPP = UniversalProcPtr;
{$ENDC}	
	SoundParamBlock = RECORD
		recordSize:				LONGINT;								{ size of this record in bytes }
		desc:					SoundComponentData;						{ description of sound buffer }
		rateMultiplier:			UnsignedFixed;							{ rate multiplier to apply to sound }
		leftVolume:				INTEGER;								{ volumes to apply to sound }
		rightVolume:			INTEGER;
		quality:				LONGINT;								{ quality to apply to sound }
		filter:					ComponentInstance;						{ filter to apply to sound }
		moreRtn:				SoundParamUPP;							{ routine to call to get more data }
		completionRtn:			SoundParamUPP;							{ routine to call when buffer is complete }
		refCon:					LONGINT;								{ user refcon }
		result:					INTEGER;								{ result }
	END;

	ExtendedSoundParamBlockPtr = ^ExtendedSoundParamBlock;
	ExtendedSoundParamBlock = RECORD
		pb:						SoundParamBlock;						{ classic SoundParamBlock except recordSize == sizeof(ExtendedSoundParamBlock) }
		reserved:				INTEGER;
		extendedFlags:			LONGINT;								{ flags }
		bufferSize:				LONGINT;								{ size of buffer in bytes }
	END;

	CompressionInfoPtr = ^CompressionInfo;
	CompressionInfo = RECORD
		recordSize:				LONGINT;
		format:					OSType;
		compressionID:			INTEGER;
		samplesPerPacket:		UInt16;
		bytesPerPacket:			UInt16;
		bytesPerFrame:			UInt16;
		bytesPerSample:			UInt16;
		futureUse1:				UInt16;
	END;

	CompressionInfoHandle				= ^CompressionInfoPtr;
	{ variables for floating point conversion }
	SoundSlopeAndInterceptRecordPtr = ^SoundSlopeAndInterceptRecord;
	SoundSlopeAndInterceptRecord = RECORD
		slope:					Float64;
		intercept:				Float64;
		minClip:				Float64;
		maxClip:				Float64;
	END;

	SoundSlopeAndInterceptPtr			= ^SoundSlopeAndInterceptRecord;
	{ private thing to use as a reference to a Sound Converter }
	SoundConverter    = ^LONGINT; { an opaque 32-bit type }
	SoundConverterPtr = ^SoundConverter;  { when a VAR xx:SoundConverter parameter can be nil, it is changed to xx: SoundConverterPtr }
	{ callback routine to provide data to the Sound Converter }
{$IFC TYPED_FUNCTION_POINTERS}
	SoundConverterFillBufferDataProcPtr = FUNCTION(VAR data: SoundComponentDataPtr; refCon: UNIV Ptr): BOOLEAN;
{$ELSEC}
	SoundConverterFillBufferDataProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	SoundConverterFillBufferDataUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SoundConverterFillBufferDataUPP = UniversalProcPtr;
{$ENDC}	
	{ private thing to use as a reference to a Sound Source }
	SoundSource    = ^LONGINT; { an opaque 32-bit type }
	SoundSourcePtr = ^SoundSource;  { when a VAR xx:SoundSource parameter can be nil, it is changed to xx: SoundSourcePtr }
	SoundComponentLinkPtr = ^SoundComponentLink;
	SoundComponentLink = RECORD
		description:			ComponentDescription;					{ Describes the sound component }
		mixerID:				SoundSource;							{ Reserved by Apple }
		linkID:					SoundSourcePtr;							{ Reserved by Apple }
	END;

	AudioInfoPtr = ^AudioInfo;
	AudioInfo = RECORD
		capabilitiesFlags:		LONGINT;								{ Describes device capabilities }
		reserved:				LONGINT;								{ Reserved by Apple }
		numVolumeSteps:			UInt16;									{ Number of significant increments between min and max volume }
	END;

	AudioFormatAtomPtr = ^AudioFormatAtom;
	AudioFormatAtom = RECORD
		size:					LONGINT;								{  = sizeof(AudioFormatAtom) }
		atomType:				OSType;									{  = kAudioFormatAtomType }
		format:					OSType;
	END;

	AudioEndianAtomPtr = ^AudioEndianAtom;
	AudioEndianAtom = RECORD
		size:					LONGINT;								{  = sizeof(AudioEndianAtom) }
		atomType:				OSType;									{  = kAudioEndianAtomType }
		littleEndian:			INTEGER;
	END;

	AudioTerminatorAtomPtr = ^AudioTerminatorAtom;
	AudioTerminatorAtom = RECORD
		size:					LONGINT;								{  = sizeof(AudioTerminatorAtom) }
		atomType:				OSType;									{  = kAudioTerminatorAtomType }
	END;

	LevelMeterInfoPtr = ^LevelMeterInfo;
	LevelMeterInfo = RECORD
		numChannels:			INTEGER;								{  mono or stereo source }
		leftMeter:				SInt8;									{  0-255 range }
		rightMeter:				SInt8;									{  0-255 range }
	END;

	EQSpectrumBandsRecordPtr = ^EQSpectrumBandsRecord;
	EQSpectrumBandsRecord = RECORD
		count:					INTEGER;
		frequency:				UnsignedFixedPtr;						{  pointer to array of frequencies }
	END;

	{  Sound Input Structures }
	SPBPtr = ^SPB;
	{	user procedures called by sound input routines	}
{$IFC TYPED_FUNCTION_POINTERS}
	SIInterruptProcPtr = PROCEDURE(inParamPtr: SPBPtr; dataBuffer: Ptr; peakAmplitude: INTEGER; sampleSize: LONGINT);
{$ELSEC}
	SIInterruptProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SICompletionProcPtr = PROCEDURE(inParamPtr: SPBPtr);
{$ELSEC}
	SICompletionProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	SIInterruptUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SIInterruptUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	SICompletionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SICompletionUPP = UniversalProcPtr;
{$ENDC}	
	{	Sound Input Parameter Block	}
	SPB = RECORD
		inRefNum:				LONGINT;								{ reference number of sound input device }
		count:					UInt32;									{ number of bytes to record }
		milliseconds:			UInt32;									{ number of milliseconds to record }
		bufferLength:			UInt32;									{ length of buffer in bytes }
		bufferPtr:				Ptr;									{ buffer to store sound data in }
		completionRoutine:		SICompletionUPP;						{ completion routine }
		interruptRoutine:		SIInterruptUPP;							{ interrupt routine }
		userLong:				LONGINT;								{ user-defined field }
		error:					OSErr;									{ error }
		unused1:				LONGINT;								{ reserved - must be zero }
	END;


CONST
	uppSoundParamProcInfo = $000000D0;
	uppSoundConverterFillBufferDataProcInfo = $000003D0;
	uppSIInterruptProcInfo = $1C579802;
	uppSICompletionProcInfo = $000000C0;
	{
	 *  NewSoundParamUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewSoundParamUPP(userRoutine: SoundParamProcPtr): SoundParamUPP; { old name was NewSoundParamProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewSoundConverterFillBufferDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewSoundConverterFillBufferDataUPP(userRoutine: SoundConverterFillBufferDataProcPtr): SoundConverterFillBufferDataUPP; { old name was NewSoundConverterFillBufferDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewSIInterruptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewSIInterruptUPP(userRoutine: SIInterruptProcPtr): SIInterruptUPP; { old name was NewSIInterruptProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewSICompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewSICompletionUPP(userRoutine: SICompletionProcPtr): SICompletionUPP; { old name was NewSICompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeSoundParamUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSoundParamUPP(userUPP: SoundParamUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeSoundConverterFillBufferDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSoundConverterFillBufferDataUPP(userUPP: SoundConverterFillBufferDataUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeSIInterruptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSIInterruptUPP(userUPP: SIInterruptUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeSICompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSICompletionUPP(userUPP: SICompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeSoundParamUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSoundParamUPP(VAR pb: SoundParamBlockPtr; userRoutine: SoundParamUPP): BOOLEAN; { old name was CallSoundParamProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeSoundConverterFillBufferDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSoundConverterFillBufferDataUPP(VAR data: SoundComponentDataPtr; refCon: UNIV Ptr; userRoutine: SoundConverterFillBufferDataUPP): BOOLEAN; { old name was CallSoundConverterFillBufferDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeSIInterruptUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeSIInterruptUPP(inParamPtr: SPBPtr; dataBuffer: Ptr; peakAmplitude: INTEGER; sampleSize: LONGINT; userRoutine: SIInterruptUPP); { old name was CallSIInterruptProc }
{
 *  InvokeSICompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeSICompletionUPP(inParamPtr: SPBPtr; userRoutine: SICompletionUPP); { old name was CallSICompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	FilePlayCompletionProcPtr = PROCEDURE(chan: SndChannelPtr);
{$ELSEC}
	FilePlayCompletionProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	FilePlayCompletionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	FilePlayCompletionUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppFilePlayCompletionProcInfo = $000000C0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewFilePlayCompletionUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewFilePlayCompletionUPP(userRoutine: FilePlayCompletionProcPtr): FilePlayCompletionUPP; { old name was NewFilePlayCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeFilePlayCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeFilePlayCompletionUPP(userUPP: FilePlayCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeFilePlayCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeFilePlayCompletionUPP(chan: SndChannelPtr; userRoutine: FilePlayCompletionUPP); { old name was CallFilePlayCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   prototypes
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
}
{ Sound Manager routines }
{
 *  SysBeep()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SysBeep(duration: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C8;
	{$ENDC}

{
 *  SndDoCommand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndDoCommand(chan: SndChannelPtr; {CONST}VAR cmd: SndCommand; noWait: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A803;
	{$ENDC}

{
 *  SndDoImmediate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndDoImmediate(chan: SndChannelPtr; {CONST}VAR cmd: SndCommand): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A804;
	{$ENDC}

{
 *  SndNewChannel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndNewChannel(VAR chan: SndChannelPtr; synth: INTEGER; init: LONGINT; userRoutine: SndCallBackUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A807;
	{$ENDC}

{
 *  SndDisposeChannel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndDisposeChannel(chan: SndChannelPtr; quietNow: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A801;
	{$ENDC}

{
 *  SndPlay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndPlay(chan: SndChannelPtr; sndHandle: SndListHandle; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A805;
	{$ENDC}

{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
{
 *  SndAddModifier()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SndAddModifier(chan: SndChannelPtr; modifier: Ptr; id: INTEGER; init: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A802;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}

{$IFC CALL_NOT_IN_CARBON }
{
 *  SndControl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SndControl(id: INTEGER; VAR cmd: SndCommand): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A806;
	{$ENDC}

{ Sound Manager 2.0 and later, uses _SoundDispatch }
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  SndSoundManagerVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndSoundManagerVersion: NumVersion;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0008, $A800;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  SndStartFilePlay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SndStartFilePlay(chan: SndChannelPtr; fRefNum: INTEGER; resNum: INTEGER; bufferSize: LONGINT; theBuffer: UNIV Ptr; theSelection: AudioSelectionPtr; theCompletion: FilePlayCompletionUPP; async: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0D00, $0008, $A800;
	{$ENDC}

{
 *  SndPauseFilePlay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SndPauseFilePlay(chan: SndChannelPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0204, $0008, $A800;
	{$ENDC}

{
 *  SndStopFilePlay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SndStopFilePlay(chan: SndChannelPtr; quietNow: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0308, $0008, $A800;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  SndChannelStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndChannelStatus(chan: SndChannelPtr; theLength: INTEGER; theStatus: SCStatusPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0510, $0008, $A800;
	{$ENDC}

{
 *  SndManagerStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndManagerStatus(theLength: INTEGER; theStatus: SMStatusPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0314, $0008, $A800;
	{$ENDC}

{
 *  SndGetSysBeepState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SndGetSysBeepState(VAR sysBeepState: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0218, $0008, $A800;
	{$ENDC}

{
 *  SndSetSysBeepState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndSetSysBeepState(sysBeepState: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $011C, $0008, $A800;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  SndPlayDoubleBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SndPlayDoubleBuffer(chan: SndChannelPtr; theParams: SndDoubleBufferHeaderPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0420, $0008, $A800;
	{$ENDC}

{ MACE compression routines, uses _SoundDispatch }
{
 *  MACEVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MACEVersion: NumVersion;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0010, $A800;
	{$ENDC}

{
 *  Comp3to1()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE Comp3to1(inBuffer: UNIV Ptr; outBuffer: UNIV Ptr; cnt: UInt32; inState: StateBlockPtr; outState: StateBlockPtr; numChannels: UInt32; whichChannel: UInt32);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $0010, $A800;
	{$ENDC}

{
 *  Exp1to3()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE Exp1to3(inBuffer: UNIV Ptr; outBuffer: UNIV Ptr; cnt: UInt32; inState: StateBlockPtr; outState: StateBlockPtr; numChannels: UInt32; whichChannel: UInt32);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $0010, $A800;
	{$ENDC}

{
 *  Comp6to1()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE Comp6to1(inBuffer: UNIV Ptr; outBuffer: UNIV Ptr; cnt: UInt32; inState: StateBlockPtr; outState: StateBlockPtr; numChannels: UInt32; whichChannel: UInt32);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $000C, $0010, $A800;
	{$ENDC}

{
 *  Exp1to6()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE Exp1to6(inBuffer: UNIV Ptr; outBuffer: UNIV Ptr; cnt: UInt32; inState: StateBlockPtr; outState: StateBlockPtr; numChannels: UInt32; whichChannel: UInt32);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0010, $A800;
	{$ENDC}

{ Sound Manager 3.0 and later calls, uses _SoundDispatch }
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  GetSysBeepVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetSysBeepVolume(VAR level: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0224, $0018, $A800;
	{$ENDC}

{
 *  SetSysBeepVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetSysBeepVolume(level: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0228, $0018, $A800;
	{$ENDC}

{
 *  GetDefaultOutputVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDefaultOutputVolume(VAR level: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $022C, $0018, $A800;
	{$ENDC}

{
 *  SetDefaultOutputVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDefaultOutputVolume(level: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0230, $0018, $A800;
	{$ENDC}

{
 *  GetSoundHeaderOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetSoundHeaderOffset(sndHandle: SndListHandle; VAR offset: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0404, $0018, $A800;
	{$ENDC}

{
 *  UnsignedFixedMulDiv()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         not available
 }
FUNCTION UnsignedFixedMulDiv(value: UnsignedFixed; multiplier: UnsignedFixed; divisor: UnsignedFixed): UnsignedFixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $060C, $0018, $A800;
	{$ENDC}

{
 *  GetCompressionInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCompressionInfo(compressionID: INTEGER; format: OSType; numChannels: INTEGER; sampleSize: INTEGER; cp: CompressionInfoPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0710, $0018, $A800;
	{$ENDC}

{
 *  SetSoundPreference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetSoundPreference(theType: OSType; VAR name: Str255; settings: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0634, $0018, $A800;
	{$ENDC}

{
 *  GetSoundPreference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetSoundPreference(theType: OSType; VAR name: Str255; settings: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0638, $0018, $A800;
	{$ENDC}

{
 *  OpenMixerSoundComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OpenMixerSoundComponent(outputDescription: SoundComponentDataPtr; outputFlags: LONGINT; VAR mixerComponent: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0614, $0018, $A800;
	{$ENDC}

{
 *  CloseMixerSoundComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CloseMixerSoundComponent(ci: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0218, $0018, $A800;
	{$ENDC}

{ Sound Manager 3.1 and later calls, uses _SoundDispatch }
{
 *  SndGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndGetInfo(chan: SndChannelPtr; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $063C, $0018, $A800;
	{$ENDC}

{
 *  SndSetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndSetInfo(chan: SndChannelPtr; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0640, $0018, $A800;
	{$ENDC}

{
 *  GetSoundOutputInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetSoundOutputInfo(outputDevice: Component; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0644, $0018, $A800;
	{$ENDC}

{
 *  SetSoundOutputInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetSoundOutputInfo(outputDevice: Component; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0648, $0018, $A800;
	{$ENDC}

{ Sound Manager 3.2 and later calls, uses _SoundDispatch }
{
 *  GetCompressionName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCompressionName(compressionType: OSType; VAR compressionName: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $044C, $0018, $A800;
	{$ENDC}

{
 *  SoundConverterOpen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundConverterOpen({CONST}VAR inputFormat: SoundComponentData; {CONST}VAR outputFormat: SoundComponentData; VAR sc: SoundConverter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0650, $0018, $A800;
	{$ENDC}

{
 *  SoundConverterClose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundConverterClose(sc: SoundConverter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0254, $0018, $A800;
	{$ENDC}

{
 *  SoundConverterGetBufferSizes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundConverterGetBufferSizes(sc: SoundConverter; inputBytesTarget: UInt32; VAR inputFrames: UInt32; VAR inputBytes: UInt32; VAR outputBytes: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0A58, $0018, $A800;
	{$ENDC}

{
 *  SoundConverterBeginConversion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundConverterBeginConversion(sc: SoundConverter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $025C, $0018, $A800;
	{$ENDC}

{
 *  SoundConverterConvertBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundConverterConvertBuffer(sc: SoundConverter; inputPtr: UNIV Ptr; inputFrames: UInt32; outputPtr: UNIV Ptr; VAR outputFrames: UInt32; VAR outputBytes: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0C60, $0018, $A800;
	{$ENDC}

{
 *  SoundConverterEndConversion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundConverterEndConversion(sc: SoundConverter; outputPtr: UNIV Ptr; VAR outputFrames: UInt32; VAR outputBytes: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0864, $0018, $A800;
	{$ENDC}

{ Sound Manager 3.3 and later calls, uses _SoundDispatch }
{
 *  SoundConverterGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.3 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundConverterGetInfo(sc: SoundConverter; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0668, $0018, $A800;
	{$ENDC}

{
 *  SoundConverterSetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.3 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundConverterSetInfo(sc: SoundConverter; selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $066C, $0018, $A800;
	{$ENDC}

{ Sound Manager 3.6 and later calls, uses _SoundDispatch }
{
 *  SoundConverterFillBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.6 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundConverterFillBuffer(sc: SoundConverter; fillBufferDataUPP: SoundConverterFillBufferDataUPP; fillBufferDataRefCon: UNIV Ptr; outputBuffer: UNIV Ptr; outputBufferByteSize: UInt32; VAR bytesWritten: UInt32; VAR framesWritten: UInt32; VAR outputFlags: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $1078, $0018, $A800;
	{$ENDC}

{
 *  SoundManagerGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.6 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundManagerGetInfo(selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $047C, $0018, $A800;
	{$ENDC}

{
 *  SoundManagerSetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.6 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundManagerSetInfo(selector: OSType; infoPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0480, $0018, $A800;
	{$ENDC}

{
  Sound Component Functions
   basic sound component functions
}

{
 *  SoundComponentInitOutputDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundComponentInitOutputDevice(ti: ComponentInstance; actions: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}

{
 *  SoundComponentSetSource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundComponentSetSource(ti: ComponentInstance; sourceID: SoundSource; source: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0002, $7000, $A82A;
	{$ENDC}

{
 *  SoundComponentGetSource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundComponentGetSource(ti: ComponentInstance; sourceID: SoundSource; VAR source: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0003, $7000, $A82A;
	{$ENDC}

{
 *  SoundComponentGetSourceData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundComponentGetSourceData(ti: ComponentInstance; VAR sourceData: SoundComponentDataPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}

{
 *  SoundComponentSetOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundComponentSetOutput(ti: ComponentInstance; requested: SoundComponentDataPtr; VAR actual: SoundComponentDataPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0005, $7000, $A82A;
	{$ENDC}

{  junction methods for the mixer, must be called at non-interrupt level }
{
 *  SoundComponentAddSource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundComponentAddSource(ti: ComponentInstance; VAR sourceID: SoundSource): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}

{
 *  SoundComponentRemoveSource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundComponentRemoveSource(ti: ComponentInstance; sourceID: SoundSource): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}

{  info methods }
{
 *  SoundComponentGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundComponentGetInfo(ti: ComponentInstance; sourceID: SoundSource; selector: OSType; infoPtr: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0103, $7000, $A82A;
	{$ENDC}

{
 *  SoundComponentSetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundComponentSetInfo(ti: ComponentInstance; sourceID: SoundSource; selector: OSType; infoPtr: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0104, $7000, $A82A;
	{$ENDC}

{  control methods }
{
 *  SoundComponentStartSource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundComponentStartSource(ti: ComponentInstance; count: INTEGER; VAR sources: SoundSource): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0105, $7000, $A82A;
	{$ENDC}

{
 *  SoundComponentStopSource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundComponentStopSource(ti: ComponentInstance; count: INTEGER; VAR sources: SoundSource): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0106, $7000, $A82A;
	{$ENDC}

{
 *  SoundComponentPauseSource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundComponentPauseSource(ti: ComponentInstance; count: INTEGER; VAR sources: SoundSource): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0107, $7000, $A82A;
	{$ENDC}

{
 *  SoundComponentPlaySourceBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SoundComponentPlaySourceBuffer(ti: ComponentInstance; sourceID: SoundSource; pb: SoundParamBlockPtr; actions: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0108, $7000, $A82A;
	{$ENDC}

{ Audio Components }
{Volume is described as a value between 0 and 1, with 0 indicating minimum
  volume and 1 indicating maximum volume; if the device doesn't support
  software control of volume, then a value of unimpErr is returned, indicating
  that these functions are not supported by the device
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  AudioGetVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AudioGetVolume(ac: ComponentInstance; whichChannel: INTEGER; VAR volume: ShortFixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0000, $7000, $A82A;
	{$ENDC}

{
 *  AudioSetVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AudioSetVolume(ac: ComponentInstance; whichChannel: INTEGER; volume: ShortFixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}

{If the device doesn't support software control of mute, then a value of unimpErr is
returned, indicating that these functions are not supported by the device.}
{
 *  AudioGetMute()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AudioGetMute(ac: ComponentInstance; whichChannel: INTEGER; VAR mute: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0002, $7000, $A82A;
	{$ENDC}

{
 *  AudioSetMute()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AudioSetMute(ac: ComponentInstance; whichChannel: INTEGER; mute: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}

{AudioSetToDefaults causes the associated device to reset its volume and mute values
(and perhaps other characteristics, e.g. attenuation) to "factory default" settings}
{
 *  AudioSetToDefaults()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AudioSetToDefaults(ac: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0004, $7000, $A82A;
	{$ENDC}

{ This routine is required; it must be implemented by all audio components }

{
 *  AudioGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AudioGetInfo(ac: ComponentInstance; info: AudioInfoPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}

{
 *  AudioGetBass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AudioGetBass(ac: ComponentInstance; whichChannel: INTEGER; VAR bass: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0006, $7000, $A82A;
	{$ENDC}

{
 *  AudioSetBass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AudioSetBass(ac: ComponentInstance; whichChannel: INTEGER; bass: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}

{
 *  AudioGetTreble()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AudioGetTreble(ac: ComponentInstance; whichChannel: INTEGER; VAR Treble: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0008, $7000, $A82A;
	{$ENDC}

{
 *  AudioSetTreble()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AudioSetTreble(ac: ComponentInstance; whichChannel: INTEGER; Treble: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0009, $7000, $A82A;
	{$ENDC}

{
 *  AudioGetOutputDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AudioGetOutputDevice(ac: ComponentInstance; VAR outputDevice: Component): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000A, $7000, $A82A;
	{$ENDC}

{ This is routine is private to the AudioVision component.  It enables the watching of the mute key. }
{
 *  AudioMuteOnEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AudioMuteOnEvent(ac: ComponentInstance; muteOnEvent: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0081, $7000, $A82A;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}



CONST
	kDelegatedSoundComponentSelectors = $0100;

	{	 Sound Input Manager routines, uses _SoundDispatch 	}
	{
	 *  SPBVersion()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION SPBVersion: NumVersion;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0000, $0014, $A800;
	{$ENDC}

{
 *  SndRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndRecord(filterProc: ModalFilterUPP; corner: Point; quality: OSType; VAR sndHandle: SndListHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0804, $0014, $A800;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  SndRecordToFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SndRecordToFile(filterProc: ModalFilterUPP; corner: Point; quality: OSType; fRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0708, $0014, $A800;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  SPBSignInDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SPBSignInDevice(deviceRefNum: INTEGER; deviceName: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $030C, $0014, $A800;
	{$ENDC}

{
 *  SPBSignOutDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SPBSignOutDevice(deviceRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0110, $0014, $A800;
	{$ENDC}

{
 *  SPBGetIndexedDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SPBGetIndexedDevice(count: INTEGER; VAR deviceName: Str255; VAR deviceIconHandle: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0514, $0014, $A800;
	{$ENDC}

{
 *  SPBOpenDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SPBOpenDevice(deviceName: Str255; permission: INTEGER; VAR inRefNum: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0518, $0014, $A800;
	{$ENDC}

{
 *  SPBCloseDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SPBCloseDevice(inRefNum: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $021C, $0014, $A800;
	{$ENDC}

{
 *  SPBRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SPBRecord(inParamPtr: SPBPtr; asynchFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0320, $0014, $A800;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  SPBRecordToFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SPBRecordToFile(fRefNum: INTEGER; inParamPtr: SPBPtr; asynchFlag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0424, $0014, $A800;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  SPBPauseRecording()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SPBPauseRecording(inRefNum: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0228, $0014, $A800;
	{$ENDC}

{
 *  SPBResumeRecording()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SPBResumeRecording(inRefNum: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $022C, $0014, $A800;
	{$ENDC}

{
 *  SPBStopRecording()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SPBStopRecording(inRefNum: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0230, $0014, $A800;
	{$ENDC}

{
 *  SPBGetRecordingStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SPBGetRecordingStatus(inRefNum: LONGINT; VAR recordingStatus: INTEGER; VAR meterLevel: INTEGER; VAR totalSamplesToRecord: UInt32; VAR numberOfSamplesRecorded: UInt32; VAR totalMsecsToRecord: UInt32; VAR numberOfMsecsRecorded: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0E34, $0014, $A800;
	{$ENDC}

{
 *  SPBGetDeviceInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SPBGetDeviceInfo(inRefNum: LONGINT; infoType: OSType; infoData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0638, $0014, $A800;
	{$ENDC}

{
 *  SPBSetDeviceInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SPBSetDeviceInfo(inRefNum: LONGINT; infoType: OSType; infoData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $063C, $0014, $A800;
	{$ENDC}

{
 *  SPBMillisecondsToBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SPBMillisecondsToBytes(inRefNum: LONGINT; VAR milliseconds: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0440, $0014, $A800;
	{$ENDC}

{
 *  SPBBytesToMilliseconds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SPBBytesToMilliseconds(inRefNum: LONGINT; VAR byteCount: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0444, $0014, $A800;
	{$ENDC}

{
 *  SetupSndHeader()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetupSndHeader(sndHandle: SndListHandle; numChannels: INTEGER; sampleRate: UnsignedFixed; sampleSize: INTEGER; compressionType: OSType; baseNote: INTEGER; numBytes: UInt32; VAR headerLen: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0D48, $0014, $A800;
	{$ENDC}

{
 *  SetupAIFFHeader()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetupAIFFHeader(fRefNum: INTEGER; numChannels: INTEGER; sampleRate: UnsignedFixed; sampleSize: INTEGER; compressionType: OSType; numBytes: UInt32; numFrames: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0B4C, $0014, $A800;
	{$ENDC}

{ Sound Input Manager 1.1 and later calls, uses _SoundDispatch }
{
 *  ParseAIFFHeader()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ParseAIFFHeader(fRefNum: INTEGER; VAR sndInfo: SoundComponentData; VAR numFrames: UInt32; VAR dataOffset: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0758, $0014, $A800;
	{$ENDC}

{
 *  ParseSndHeader()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SoundLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ParseSndHeader(sndHandle: SndListHandle; VAR sndInfo: SoundComponentData; VAR numFrames: UInt32; VAR dataOffset: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $085C, $0014, $A800;
	{$ENDC}

{$IFC NOT TARGET_OS_MAC OR TARGET_API_MAC_CARBON }
{  Only to be used if you are writing a sound input component; this }
{  is the param block for a read request from the SoundMgr to the   }
{  sound input component.  Not to be confused with the SPB struct   }
{  above, which is the param block for a read request from an app   }
{  to the SoundMgr.                                                 }

TYPE
	SndInputCmpParamPtr = ^SndInputCmpParam;
{$IFC TYPED_FUNCTION_POINTERS}
	SICCompletionProcPtr = PROCEDURE(SICParmPtr: SndInputCmpParamPtr);
{$ELSEC}
	SICCompletionProcPtr = ProcPtr;
{$ENDC}

	SndInputCmpParam = RECORD
		ioCompletion:			SICCompletionProcPtr;					{  completion routine [pointer] }
		ioInterrupt:			SIInterruptProcPtr;						{  interrupt routine [pointer] }
		ioResult:				OSErr;									{  I/O result code [word] }
		pad:					INTEGER;
		ioReqCount:				UInt32;
		ioActCount:				UInt32;
		ioBuffer:				Ptr;
		ioMisc:					Ptr;
	END;

	{
	 *  SndInputReadAsync()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION SndInputReadAsync(self: ComponentInstance; SICParmPtr: SndInputCmpParamPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}

{
 *  SndInputReadSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndInputReadSync(self: ComponentInstance; SICParmPtr: SndInputCmpParamPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0002, $7000, $A82A;
	{$ENDC}

{
 *  SndInputPauseRecording()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndInputPauseRecording(self: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0003, $7000, $A82A;
	{$ENDC}

{
 *  SndInputResumeRecording()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndInputResumeRecording(self: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0004, $7000, $A82A;
	{$ENDC}

{
 *  SndInputStopRecording()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndInputStopRecording(self: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0005, $7000, $A82A;
	{$ENDC}

{
 *  SndInputGetStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndInputGetStatus(self: ComponentInstance; VAR recordingStatus: INTEGER; VAR totalSamplesToRecord: UInt32; VAR numberOfSamplesRecorded: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0006, $7000, $A82A;
	{$ENDC}

{
 *  SndInputGetDeviceInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndInputGetDeviceInfo(self: ComponentInstance; infoType: OSType; infoData: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0007, $7000, $A82A;
	{$ENDC}

{
 *  SndInputSetDeviceInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndInputSetDeviceInfo(self: ComponentInstance; infoType: OSType; infoData: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0008, $7000, $A82A;
	{$ENDC}

{
 *  SndInputInitHardware()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SndInputInitHardware(self: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0009, $7000, $A82A;
	{$ENDC}

{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SoundIncludes}

{$ENDC} {__SOUND__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

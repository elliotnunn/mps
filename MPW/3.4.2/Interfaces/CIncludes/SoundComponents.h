/*
 	File:		SoundComponents.h
 
 	Contains:	Sound Components Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __SOUNDCOMPONENTS__
#define __SOUNDCOMPONENTS__

#ifndef rez

#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __COMPONENTS__
#include <Components.h>
#endif
/*	#include <MixedMode.h>										*/

#ifndef __SOUND__
#include <Sound.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#endif /* rez */


/*
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
*/


/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* constants*/
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


/*sound component types and subtypes*/
#define kNoSoundComponentType			'****'


#define kSoundComponentType				'sift'
#define kSoundComponentPPCType			'nift',		//component type for PowerPC code

#define 	kRate8SubType				'ratb'		/*8-bit rate converter*/
#define 	kRate16SubType				'ratw'		/*16-bit rate converter*/
#define kConverterSubType				'conv'		/*sample format converter*/
#define kSndSourceSubType				'sour'		/*generic source component*/


#define kMixerType						'mixr'
#define 	kMixer8SubType				'mixb'		/*8-bit mixer*/
#define 	kMixer16SubType				'mixw'		/*16-bit mixer*/


#define kSoundOutputDeviceType			'sdev'		/*sound output component*/
#define		kClassicSubType				'clas'		/*classic hardware, i.e. Mac Plus*/
#define 	kASCSubType					'asc '		/*Apple Sound Chip device*/
#define 	kDSPSubType					'dsp '		/*DSP device*/
#define 	kAwacsSubType				'awac'		/*Another of Will's Audio Chips device*/
#define 	kGCAwacsSubType				'awgc'		/*Awacs audio with Grand Central DMA*/
#define 	kSingerSubType				'sing'		/*Singer (via Whitney) based sound*/
#define 	kSinger2SubType				'sng2'		/*Singer 2 (via Whitney) for Acme*/
#define 	kWhitSubType				'whit',		//Whit sound component for PrimeTime 3
#define 	kSoundBlasterSubType		'sbls',		//Sound Blaster for CHRP

#define kSoundCompressor				'scom'
#define kSoundDecompressor				'sdec'
#define 	kMace3SubType				'MAC3'		/*MACE 3:1*/
#define 	kMace6SubType				'MAC6'		/*MACE 6:1*/
#define 	kCDXA4SubType				'cdx4'		/*CD/XA 4:1*/
#define 	kCDXA2SubType				'cdx2'		/*CD/XA 2:1*/
#define 	kIMA4SubType				'ima4'		/*IMA 4:1*/
#define 	kULawSubType				'ulaw'		/*µLaw 2:1*/
#define		kLittleEndianSubType		'sowt'		/*Little-endian*/


/*Audio components and sub-types*/
#define kAudioComponentType				'adio'
#define		kAwacsPhoneSubType			'hphn'
#define		kAudioVisionSpeakerSubType	'telc'
#define		kAudioVisionHeadphoneSubType 'telh'
#define		kSonyTunerSubType			'tvav'

/*Sound effects components and sub-types*/
#define kSoundEffectsType				'snfx'
#define 	kSSpLocalizationSubType		'snd3'		/*SoundSprocket localization*/


/*features flags*/
#define k8BitRawIn					(1 << 0)	/*data description*/
#define k8BitTwosIn					(1 << 1)
#define k16BitIn					(1 << 2)
#define kStereoIn					(1 << 3)
#define k8BitRawOut					(1 << 8)
#define k8BitTwosOut				(1 << 9)
#define k16BitOut					(1 << 10)
#define kStereoOut					(1 << 11)


#define kReverse					0x00010000   /* (1L << 16) */ /*function description*/
#define kRateConvert				0x00020000   /* (1L << 17) */
#define kCreateSoundSource			0x00040000   /* (1L << 18) */


#define kHighQuality				0x00400000   /* (1L << 22) */ /*performance description*/
#define kNonRealTime				0x00800000   /* (1L << 23) */


#ifndef rez

enum {
/*sound component set/get info selectors*/
	siVolume					= 'volu',
	siHardwareVolume			= 'hvol',
	siSpeakerVolume				= 'svol',
	siHeadphoneVolume			= 'pvol',
	siHardwareVolumeSteps		= 'hstp',
	siHeadphoneVolumeSteps		= 'hdst',
	siHardwareMute				= 'hmut',
	siSpeakerMute				= 'smut',
	siHeadphoneMute				= 'pmut',
	siRateMultiplier			= 'rmul',
	siQuality					= 'qual',
 	siWideStereo				= 'wide',
 	siHardwareFormat			= 'hwfm',
 	siPreMixerSoundComponent	= 'prmx',
 	siPostMixerSoundComponent	= 'psmx',
/*SoundSprocket selectors*/
	siSSpCPULoadLimit			= '3dll',
	siSSpSpeakerSetup			= '3dst',
	siSSpLocalization			= '3dif',
/*format types*/
	kOffsetBinary				= 'raw ',
	kTwosComplement				= 'twos',
	kMACE3Compression			= 'MAC3',
	kMACE6Compression			= 'MAC6'
};

/*quality flags*/
enum {
/*use interpolation in rate conversion*/
	kBestQuality				= (1 << 0)
};

enum {
/*useful bit masks*/
	kInputMask					= 0x000000FF,					/*masks off input bits*/
	kOutputMask					= 0x0000FF00,					/*masks off output bits*/
	kOutputShift				= 8,							/*amount output bits are shifted*/
	kActionMask					= 0x00FF0000,					/*masks off action bits*/
	kSoundComponentBits			= 0x00FFFFFF
};

enum {
/*SoundComponentPlaySourceBuffer action flags*/
	kSourcePaused				= (1 << 0),
	kPassThrough				= (1L << 16),
	kNoSoundComponentChain		= (1L << 17),
/*flags for OpenMixerSoundComponent*/
	kNoMixing					= (1 << 0),						/*don't mix source*/
	kNoSampleRateConversion		= (1 << 1),						/*don't convert sample rate (i.e. 11 kHz -> 22 kHz)*/
	kNoSampleSizeConversion		= (1 << 2),						/*don't convert sample size (i.e. 16 -> 8)*/
	kNoSampleFormatConversion	= (1 << 3),						/*don't convert sample format (i.e. 'twos' -> 'raw ')*/
	kNoChannelConversion		= (1 << 4),						/*don't convert stereo/mono*/
	kNoDecompression			= (1 << 5),						/*don't decompress (i.e. 'MAC3' -> 'raw ')*/
	kNoVolumeConversion			= (1 << 6),						/*don't apply volume*/
	kNoRealtimeProcessing		= (1 << 7)						/*won't run at interrupt time*/
};

/*Audio Component constants*/
enum {
/*Values for whichChannel parameter*/
	audioAllChannels			= 0,							/*All channels (usually interpreted as both left and right)*/
	audioLeftChannel			= 1,							/*Left channel*/
	audioRightChannel			= 2,							/*Right channel*/
/*Values for mute parameter*/
	audioUnmuted				= 0,							/*Device is unmuted*/
	audioMuted					= 1,							/*Device is muted*/
/*Capabilities flags definitions*/
	audioDoesMono				= (1L << 0),					/*Device supports mono output*/
	audioDoesStereo				= (1L << 1),					/*Device supports stereo output*/
	audioDoesIndependentChannels = (1L << 2)					/*Device supports independent software control of each channel*/
};

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* typedefs*/
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


/*ShortFixed consists of an 8 bit, 2's complement integer part in the high byte,*/
/*with an 8 bit fractional part in the low byte; its range is -128 to 127.99609375*/
typedef short ShortFixed;

typedef struct SoundParamBlock SoundParamBlock;

typedef SoundParamBlock *SoundParamBlockPtr;

typedef pascal Boolean (*SoundParamProcPtr)(SoundParamBlockPtr *pb);

#if GENERATINGCFM
typedef UniversalProcPtr SoundParamUPP;
#else
typedef SoundParamProcPtr SoundParamUPP;
#endif

struct SoundParamBlock {
	long							recordSize;					/*size of this record in bytes*/
	SoundComponentData				desc;						/*description of sound buffer*/
	UnsignedFixed					rateMultiplier;				/*rate multiplier to apply to sound*/
	short							leftVolume;					/*volumes to apply to sound*/
	short							rightVolume;
	long							quality;					/*quality to apply to sound*/
	ComponentInstance				filter;						/*filter to apply to sound*/
	SoundParamUPP					moreRtn;					/*routine to call to get more data*/
	SoundParamUPP					completionRtn;				/*routine to call when buffer is complete*/
	long							refCon;						/*user refcon*/
	short							result;						/*result*/
};
typedef struct privateSoundSource *SoundSource;

struct SoundComponentLink {
	ComponentDescription 			description;				/*Describes the sound component*/
	SoundSource 					mixerID;					/*Reserved by Apple*/
	SoundSource *					linkID;						/*Reserved by Apple*/
};
typedef struct SoundComponentLink SoundComponentLink;
typedef SoundComponentLink *SoundComponentLinkPtr;

struct AudioInfo {
	long							capabilitiesFlags;			/*Describes device capabilities*/
	long							reserved;					/*Reserved by Apple*/
	unsigned short					numVolumeSteps;				/*Number of significant increments between min and max volume*/
};
typedef struct AudioInfo AudioInfo;

typedef AudioInfo *AudioInfoPtr;

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* functions for sound components*/
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/*Sound Component dispatch selectors*/

enum {
/*these calls cannot be delegated*/
	kSoundComponentInitOutputDeviceSelect = 1,
	kSoundComponentSetSourceSelect = 2,
	kSoundComponentGetSourceSelect = 3,
	kSoundComponentGetSourceDataSelect = 4,
	kSoundComponentSetOutputSelect = 5,
	kDelegatedSoundComponentSelectors = 0x0100,					/*first selector that can be delegated up the chain*/
/*these calls can be delegated and have own range*/
	kSoundComponentAddSourceSelect = kDelegatedSoundComponentSelectors + 1,
	kSoundComponentRemoveSourceSelect = kDelegatedSoundComponentSelectors + 2,
	kSoundComponentGetInfoSelect = kDelegatedSoundComponentSelectors + 3,
	kSoundComponentSetInfoSelect = kDelegatedSoundComponentSelectors + 4,
	kSoundComponentStartSourceSelect = kDelegatedSoundComponentSelectors + 5,
	kSoundComponentStopSourceSelect = kDelegatedSoundComponentSelectors + 6,
	kSoundComponentPauseSourceSelect = kDelegatedSoundComponentSelectors + 7,
	kSoundComponentPlaySourceBufferSelect = kDelegatedSoundComponentSelectors + 8
};

/*Audio Component selectors*/
enum {
	kAudioGetVolumeSelect		= 0,
	kAudioSetVolumeSelect		= 1,
	kAudioGetMuteSelect			= 2,
	kAudioSetMuteSelect			= 3,
	kAudioSetToDefaultsSelect	= 4,
	kAudioGetInfoSelect			= 5,
	kAudioGetBassSelect			= 6,
	kAudioSetBassSelect			= 7,
	kAudioGetTrebleSelect		= 8,
	kAudioSetTrebleSelect		= 9,
	kAudioGetOutputDeviceSelect	= 10,
	kAudioMuteOnEventSelect		= 129
};



/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* Sound Manager 3.0 utilities*/
extern pascal OSErr OpenMixerSoundComponent(SoundComponentDataPtr outputDescription, long outputFlags, ComponentInstance *mixerComponent)
 FOURWORDINLINE(0x203C, 0x0614, 0x0018, 0xA800);
extern pascal OSErr CloseMixerSoundComponent(ComponentInstance ci)
 FOURWORDINLINE(0x203C, 0x0218, 0x0018, 0xA800);


/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* basic sound component functions*/
extern pascal ComponentResult SoundComponentInitOutputDevice(ComponentInstance ti, long actions)
 FIVEWORDINLINE(0x2F3C, 4, 1, 0x7000, 0xA82A);
extern pascal ComponentResult SoundComponentSetSource(ComponentInstance ti, SoundSource sourceID, ComponentInstance source)
 FIVEWORDINLINE(0x2F3C, 8, 2, 0x7000, 0xA82A);
extern pascal ComponentResult SoundComponentGetSource(ComponentInstance ti, SoundSource sourceID, ComponentInstance *source)
 FIVEWORDINLINE(0x2F3C, 8, 3, 0x7000, 0xA82A);
extern pascal ComponentResult SoundComponentGetSourceData(ComponentInstance ti, SoundComponentDataPtr *sourceData)
 FIVEWORDINLINE(0x2F3C, 4, 4, 0x7000, 0xA82A);
extern pascal ComponentResult SoundComponentSetOutput(ComponentInstance ti, SoundComponentDataPtr requested, SoundComponentDataPtr *actual)
 FIVEWORDINLINE(0x2F3C, 8, 5, 0x7000, 0xA82A);


/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* junction methods for the mixer, must be called at non-interrupt level*/
extern pascal ComponentResult SoundComponentAddSource(ComponentInstance ti, SoundSource *sourceID)
 FIVEWORDINLINE(0x2F3C, 4, 0x0101, 0x7000, 0xA82A);
extern pascal ComponentResult SoundComponentRemoveSource(ComponentInstance ti, SoundSource sourceID)
 FIVEWORDINLINE(0x2F3C, 4, 0x0102, 0x7000, 0xA82A);


/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* info methods*/
extern pascal ComponentResult SoundComponentGetInfo(ComponentInstance ti, SoundSource sourceID, OSType selector, void *infoPtr)
 FIVEWORDINLINE(0x2F3C, 12, 0x0103, 0x7000, 0xA82A);
extern pascal ComponentResult SoundComponentSetInfo(ComponentInstance ti, SoundSource sourceID, OSType selector, void *infoPtr)
 FIVEWORDINLINE(0x2F3C, 12, 0x0104, 0x7000, 0xA82A);


/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* control methods*/
extern pascal ComponentResult SoundComponentStartSource(ComponentInstance ti, short count, SoundSource *sources)
 FIVEWORDINLINE(0x2F3C, 6, 0x0105, 0x7000, 0xA82A);
extern pascal ComponentResult SoundComponentStopSource(ComponentInstance ti, short count, SoundSource *sources)
 FIVEWORDINLINE(0x2F3C, 6, 0x0106, 0x7000, 0xA82A);
extern pascal ComponentResult SoundComponentPauseSource(ComponentInstance ti, short count, SoundSource *sources)
 FIVEWORDINLINE(0x2F3C, 6, 0x0107, 0x7000, 0xA82A);
extern pascal ComponentResult SoundComponentPlaySourceBuffer(ComponentInstance ti, SoundSource sourceID, SoundParamBlockPtr pb, long actions)
 FIVEWORDINLINE(0x2F3C, 12, 0x0108, 0x7000, 0xA82A);


/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* interface for Audio Components*/
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/


/*Volume is described as a value between 0 and 1, with 0 indicating minimum
  volume and 1 indicating maximum volume; if the device doesn't support
  software control of volume, then a value of unimpErr is returned, indicating
  that these functions are not supported by the device*/


extern pascal ComponentResult AudioGetVolume(ComponentInstance ac, short whichChannel, ShortFixed *volume)
 FIVEWORDINLINE(0x2F3C, 6, 0, 0x7000, 0xA82A);
extern pascal ComponentResult AudioSetVolume(ComponentInstance ac, short whichChannel, ShortFixed volume)
 FIVEWORDINLINE(0x2F3C, 4, 1, 0x7000, 0xA82A);


/*If the device doesn't support software control of mute, then a value of unimpErr is*/
/*returned, indicating that these functions are not supported by the device*/
extern pascal ComponentResult AudioGetMute(ComponentInstance ac, short whichChannel, short *mute)
 FIVEWORDINLINE(0x2F3C, 6, 2, 0x7000, 0xA82A);
extern pascal ComponentResult AudioSetMute(ComponentInstance ac, short whichChannel, short mute)
 FIVEWORDINLINE(0x2F3C, 4, 3, 0x7000, 0xA82A);


/*AudioSetToDefaults causes the associated device to reset its volume and mute values*/
/*(and perhaps other characteristics, e.g. attenuation) to "factory default" settings*/
extern pascal ComponentResult AudioSetToDefaults(ComponentInstance ac)
 FIVEWORDINLINE(0x2F3C, 0, 4, 0x7000, 0xA82A);


/*This routine is required; it must be implemented by all audio components*/
extern pascal ComponentResult AudioGetInfo(ComponentInstance ac, AudioInfoPtr info)
 FIVEWORDINLINE(0x2F3C, 4, 5, 0x7000, 0xA82A);
extern pascal ComponentResult AudioGetBass(ComponentInstance ac, short whichChannel, short *bass)
 FIVEWORDINLINE(0x2F3C, 6, 6, 0x7000, 0xA82A);
extern pascal ComponentResult AudioSetBass(ComponentInstance ac, short whichChannel, short bass)
 FIVEWORDINLINE(0x2F3C, 4, 7, 0x7000, 0xA82A);
extern pascal ComponentResult AudioGetTreble(ComponentInstance ac, short whichChannel, short *Treble)
 FIVEWORDINLINE(0x2F3C, 6, 8, 0x7000, 0xA82A);
extern pascal ComponentResult AudioSetTreble(ComponentInstance ac, short whichChannel, short Treble)
 FIVEWORDINLINE(0x2F3C, 4, 9, 0x7000, 0xA82A);
extern pascal ComponentResult AudioGetOutputDevice(ComponentInstance ac, Component *outputDevice)
 FIVEWORDINLINE(0x2F3C, 4, 10, 0x7000, 0xA82A);


/*This is routine is private to the AudioVision component.  It enables the watching of the mute key.*/
extern pascal ComponentResult AudioMuteOnEvent(ComponentInstance ac, short muteOnEvent)
 FIVEWORDINLINE(0x2F3C, 2, 129, 0x7000, 0xA82A);


enum {
	uppSoundParamProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SoundParamBlockPtr*)))
};

#if GENERATINGCFM
#define NewSoundParamProc(userRoutine)		\
		(SoundParamUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSoundParamProcInfo, GetCurrentArchitecture())
#else
#define NewSoundParamProc(userRoutine)		\
		((SoundParamUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallSoundParamProc(userRoutine, pb)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSoundParamProcInfo, (pb))
#else
#define CallSoundParamProc(userRoutine, pb)		\
		(*(userRoutine))((pb))
#endif


#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* rez */
#endif /* __SOUNDCOMPONENTS__ */

/*
 	File:		Sound.h
 
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
 
*/

#ifndef __SOUND__
#define __SOUND__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __COMPONENTS__
#include <Components.h>
#endif
/*	#include <MixedMode.h>										*/

#ifndef __MIXEDMODE__
#include <MixedMode.h>
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



/*
						* * *  N O T E  * * *

	This file has been updated to include Sound Manager 3.2 interfaces.

	Some of the Sound Manager 3.0 interfaces were not put into the InterfaceLib
	that originally shipped with the PowerMacs. These missing functions and the
	new 3.2 interfaces have been released in the SoundLib library for PowerPC
	developers to link with. The runtime library for these functions are
	installed by Sound Manager 3.2. The following functions are found in SoundLib.

		GetCompressionInfo, GetSoundPreference, SetSoundPreference,
		UnsignedFixedMulDiv, SndGetInfo, SndSetInfo
*/
/*
	Interfaces for Sound Driver, !!! OBSOLETE and NOT SUPPORTED !!!

	These items are no longer defined, but appear here so that someone
	searching the interfaces might find them. If you are using one of these
	items, you must change your code to support the Sound Manager.

		swMode, ftMode, ffMode
		FreeWave, FFSynthRec, Tone, SWSynthRec, Wave, FTSoundRec
		SndCompletionProcPtr
		StartSound, StopSound, SoundDone
*/


#define twelfthRootTwo			1.05946309435
enum {
	soundListRsrc				= 'snd ',						/*Resource type used by Sound Manager*/
	rate44khz					= 0xAC440000L,					/*44100.00000 in fixed-point*/
	rate22050hz					= 0x56220000L,					/*22050.00000 in fixed-point*/
	rate22khz					= 0x56EE8BA3L,					/*22254.54545 in fixed-point*/
	rate11khz					= 0x2B7745D1L,					/*11127.27273 in fixed-point*/
	rate11025hz					= 0x2B110000,					/*11025.00000 in fixed-point*/
/*synthesizer numbers for SndNewChannel*/
	squareWaveSynth				= 1,							/*square wave synthesizer*/
	waveTableSynth				= 3,							/*wave table synthesizer*/
	sampledSynth				= 5,							/*sampled sound synthesizer*/
/*old Sound Manager MACE synthesizer numbers*/
	MACE3snthID					= 11,
	MACE6snthID					= 13,
	kMiddleC					= 60,							/*MIDI note value for middle C*/
	kSimpleBeepID				= 1,							/*reserved resource ID for Simple Beep*/
	kFullVolume					= 0x0100,						/*1.0, setting for full hardware output volume*/
	kNoVolume					= 0,							/*setting for no sound volume*/
/*command numbers for SndDoCommand and SndDoImmediate*/
	nullCmd						= 0,
	initCmd						= 1,
	freeCmd						= 2,
	quietCmd					= 3,
	flushCmd					= 4,
	reInitCmd					= 5,
	waitCmd						= 10,
	pauseCmd					= 11,
	resumeCmd					= 12,
	callBackCmd					= 13
};

enum {
	syncCmd						= 14,
	availableCmd				= 24,
	versionCmd					= 25,
	totalLoadCmd				= 26,
	loadCmd						= 27,
	freqDurationCmd				= 40,
	restCmd						= 41,
	freqCmd						= 42,
	ampCmd						= 43,
	timbreCmd					= 44,
	getAmpCmd					= 45,
	volumeCmd					= 46,							/*sound manager 3.0 or later only*/
	getVolumeCmd				= 47,							/*sound manager 3.0 or later only*/
	waveTableCmd				= 60,
	phaseCmd					= 61
};

enum {
	soundCmd					= 80,
	bufferCmd					= 81,
	rateCmd						= 82,
	continueCmd					= 83,
	doubleBufferCmd				= 84,
	getRateCmd					= 85,
	rateMultiplierCmd			= 86,
	getRateMultiplierCmd		= 87,
	sizeCmd						= 90,
	convertCmd					= 91,
	stdQLength					= 128,
	dataOffsetFlag				= 0x8000
};

/*channel initialization parameters*/
#if OLDROUTINENAMES
enum {
	waveInitChannelMask			= 0x07,
	waveInitChannel0			= 0x04,							/*wave table only, Sound Manager 2.0 and earlier*/
	waveInitChannel1			= 0x05,							/*wave table only, Sound Manager 2.0 and earlier*/
	waveInitChannel2			= 0x06,							/*wave table only, Sound Manager 2.0 and earlier*/
	waveInitChannel3			= 0x07,							/*wave table only, Sound Manager 2.0 and earlier*/
	initChan0					= waveInitChannel0,				/*obsolete spelling*/
	initChan1					= waveInitChannel1,				/*obsolete spelling*/
	initChan2					= waveInitChannel2,				/*obsolete spelling*/
	initChan3					= waveInitChannel3				/*obsolete spelling*/
};

#endif
enum {
	initChanLeft				= 0x0002,						/*left stereo channel*/
	initChanRight				= 0x0003,						/*right stereo channel*/
	initNoInterp				= 0x0004,						/*no linear interpolation*/
	initNoDrop					= 0x0008,						/*no drop-sample conversion*/
	initMono					= 0x0080,						/*monophonic channel*/
	initStereo					= 0x00C0,						/*stereo channel*/
	initMACE3					= 0x0300,						/*MACE 3:1*/
	initMACE6					= 0x0400,						/*MACE 6:1*/
	initPanMask					= 0x0003,						/*mask for right/left pan values*/
	initSRateMask				= 0x0030,						/*mask for sample rate values*/
	initStereoMask				= 0x00C0,						/*mask for mono/stereo values*/
	initCompMask				= 0xFF00,						/*mask for compression IDs*/
	kUseOptionalOutputDevice	= -1,							/*only for Sound Manager 3.0 or later*/
	notCompressed				= 0,							/*compression ID's*/
	fixedCompression			= -1,							/*compression ID for fixed-sized compression*/
	variableCompression			= -2,							/*compression ID for variable-sized compression*/
	twoToOne					= 1,
	eightToThree				= 2,
	threeToOne					= 3,
	sixToOne					= 4
};

enum {
	stdSH						= 0x00,							/*Standard sound header encode value*/
	extSH						= 0xFF,							/*Extended sound header encode value*/
	cmpSH						= 0xFE							/*Compressed sound header encode value*/
};

enum {
	outsideCmpSH				= 0,							/*obsolete MACE constant*/
	insideCmpSH					= 1,							/*obsolete MACE constant*/
	aceSuccess					= 0,							/*obsolete MACE constant*/
	aceMemFull					= 1,							/*obsolete MACE constant*/
	aceNilBlock					= 2,							/*obsolete MACE constant*/
	aceBadComp					= 3,							/*obsolete MACE constant*/
	aceBadEncode				= 4,							/*obsolete MACE constant*/
	aceBadDest					= 5,							/*obsolete MACE constant*/
	aceBadCmd					= 6,							/*obsolete MACE constant*/
	sixToOnePacketSize			= 8,
	threeToOnePacketSize		= 16,
	stateBlockSize				= 64,
	leftOverBlockSize			= 32,
	firstSoundFormat			= 0x0001,						/*general sound format*/
	secondSoundFormat			= 0x0002,						/*special sampled sound format (HyperCard)*/
	dbBufferReady				= 0x00000001,					/*double buffer is filled*/
	dbLastBuffer				= 0x00000004,					/*last double buffer to play*/
	sysBeepDisable				= 0x0000,						/*SysBeep() enable flags*/
	sysBeepEnable				= (1 << 0),
	sysBeepSynchronous			= (1 << 1),						/*if bit set, make alert sounds synchronous*/
	unitTypeNoSelection			= 0xFFFF,						/*unitTypes for AudioSelection.unitType*/
	unitTypeSeconds				= 0x0000
};



/* unsigned fixed-point number */
typedef unsigned long UnsignedFixed;

struct SndCommand {
	unsigned short					cmd;
	short							param1;
	long							param2;
};
typedef struct SndCommand SndCommand;

typedef struct SndChannel SndChannel;

typedef SndChannel *SndChannelPtr;

typedef pascal void (*SndCallBackProcPtr)(SndChannelPtr chan, SndCommand *cmd);

#if GENERATINGCFM
typedef UniversalProcPtr SndCallBackUPP;
#else
typedef SndCallBackProcPtr SndCallBackUPP;
#endif

struct SndChannel {
	struct SndChannel				*nextChan;
	Ptr								firstMod;					/* reserved for the Sound Manager */
	SndCallBackUPP					callBack;
	long							userInfo;
	long							wait;						/* The following is for internal Sound Manager use only.*/
	SndCommand						cmdInProgress;
	short							flags;
	short							qLength;
	short							qHead;
	short							qTail;
	SndCommand						queue[stdQLength];
};


/*MACE structures*/
struct StateBlock {
	short							stateVar[stateBlockSize];
};
typedef struct StateBlock StateBlock;

typedef StateBlock *StateBlockPtr;

struct LeftOverBlock {
	unsigned long					count;
	char							sampleArea[leftOverBlockSize];
};
typedef struct LeftOverBlock LeftOverBlock;

typedef LeftOverBlock *LeftOverBlockPtr;

struct ModRef {
	unsigned short					modNumber;
	long							modInit;
};
typedef struct ModRef ModRef;

struct SndListResource {
	short							format;
	short							numModifiers;
	ModRef							modifierPart[1];			/*This is a variable length array*/
	short							numCommands;
	SndCommand						commandPart[1];				/*This is a variable length array*/
	char							dataPart[1];				/*This is a variable length array*/
};
typedef struct SndListResource SndListResource;

typedef SndListResource *SndListPtr;

typedef SndListPtr *SndListHndl, *SndListHandle;

/*HyperCard sound resource format*/
struct Snd2ListResource {
	short							format;
	short							refCount;
	short							numCommands;
	SndCommand						commandPart[1];				/*This is a variable length array*/
	char							dataPart[1];				/*This is a variable length array*/
};
typedef struct Snd2ListResource Snd2ListResource;

typedef Snd2ListResource *Snd2ListPtr;

typedef Snd2ListPtr *Snd2ListHndl, *Snd2ListHandle;

struct SoundHeader {
	Ptr								samplePtr;					/*if NIL then samples are in sampleArea*/
	unsigned long					length;						/*length of sound in bytes*/
	UnsignedFixed					sampleRate;					/*sample rate for this sound*/
	unsigned long					loopStart;					/*start of looping portion*/
	unsigned long					loopEnd;					/*end of looping portion*/
	unsigned char					encode;						/*header encoding*/
	unsigned char					baseFrequency;				/*baseFrequency value*/
	unsigned char					sampleArea[1];				/*space for when samples follow directly*/
};
typedef struct SoundHeader SoundHeader;

typedef SoundHeader *SoundHeaderPtr;

struct CmpSoundHeader {
	Ptr								samplePtr;					/*if nil then samples are in sample area*/
	unsigned long					numChannels;				/*number of channels i.e. mono = 1*/
	UnsignedFixed					sampleRate;					/*sample rate in Apples Fixed point representation*/
	unsigned long					loopStart;					/*loopStart of sound before compression*/
	unsigned long					loopEnd;					/*loopEnd of sound before compression*/
	unsigned char					encode;						/*data structure used , stdSH, extSH, or cmpSH*/
	unsigned char					baseFrequency;				/*same meaning as regular SoundHeader*/
	unsigned long					numFrames;					/*length in frames ( packetFrames or sampleFrames )*/
	extended80						AIFFSampleRate;				/*IEEE sample rate*/
	Ptr								markerChunk;				/*sync track*/
	OSType							format;						/*data format type, was futureUse1*/
	unsigned long					futureUse2;					/*reserved by Apple*/
	StateBlockPtr					stateVars;					/*pointer to State Block*/
	LeftOverBlockPtr				leftOverSamples;			/*used to save truncated samples between compression calls*/
	short							compressionID;				/*0 means no compression, non zero means compressionID*/
	unsigned short					packetSize;					/*number of bits in compressed sample packet*/
	unsigned short					snthID;						/*resource ID of Sound Manager snth that contains NRT C/E*/
	unsigned short					sampleSize;					/*number of bits in non-compressed sample*/
	unsigned char					sampleArea[1];				/*space for when samples follow directly*/
};
typedef struct CmpSoundHeader CmpSoundHeader;

typedef CmpSoundHeader *CmpSoundHeaderPtr;

struct ExtSoundHeader {
	Ptr								samplePtr;					/*if nil then samples are in sample area*/
	unsigned long					numChannels;				/*number of channels,  ie mono = 1*/
	UnsignedFixed					sampleRate;					/*sample rate in Apples Fixed point representation*/
	unsigned long					loopStart;					/*same meaning as regular SoundHeader*/
	unsigned long					loopEnd;					/*same meaning as regular SoundHeader*/
	unsigned char					encode;						/*data structure used , stdSH, extSH, or cmpSH*/
	unsigned char					baseFrequency;				/*same meaning as regular SoundHeader*/
	unsigned long					numFrames;					/*length in total number of frames*/
	extended80						AIFFSampleRate;				/*IEEE sample rate*/
	Ptr								markerChunk;				/*sync track*/
	Ptr								instrumentChunks;			/*AIFF instrument chunks*/
	Ptr								AESRecording;
	unsigned short					sampleSize;					/*number of bits in sample*/
	unsigned short					futureUse1;					/*reserved by Apple*/
	unsigned long					futureUse2;					/*reserved by Apple*/
	unsigned long					futureUse3;					/*reserved by Apple*/
	unsigned long					futureUse4;					/*reserved by Apple*/
	unsigned char					sampleArea[1];				/*space for when samples follow directly*/
};
typedef struct ExtSoundHeader ExtSoundHeader;

typedef ExtSoundHeader *ExtSoundHeaderPtr;

struct ConversionBlock {
	short							destination;
	short							unused;
	CmpSoundHeaderPtr				inputPtr;
	CmpSoundHeaderPtr				outputPtr;
};
typedef struct ConversionBlock ConversionBlock;

typedef ConversionBlock *ConversionBlockPtr;

struct SMStatus {
	short							smMaxCPULoad;
	short							smNumChannels;
	short							smCurCPULoad;
};
typedef struct SMStatus SMStatus;

typedef SMStatus *SMStatusPtr;

struct SCStatus {
	UnsignedFixed					scStartTime;
	UnsignedFixed					scEndTime;
	UnsignedFixed					scCurrentTime;
	Boolean							scChannelBusy;
	Boolean							scChannelDisposed;
	Boolean							scChannelPaused;
	Boolean							scUnused;
	unsigned long					scChannelAttributes;
	long							scCPULoad;
};
typedef struct SCStatus SCStatus;

typedef SCStatus *SCStatusPtr;

struct AudioSelection {
	long							unitType;
	UnsignedFixed					selStart;
	UnsignedFixed					selEnd;
};
typedef pascal void (*FilePlayCompletionProcPtr)(SndChannelPtr chan);

#if GENERATINGCFM
typedef UniversalProcPtr FilePlayCompletionUPP;
#else
typedef FilePlayCompletionProcPtr FilePlayCompletionUPP;
#endif

enum {
	uppFilePlayCompletionProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SndChannelPtr)))
};

#if GENERATINGCFM
#define NewFilePlayCompletionProc(userRoutine)		\
		(FilePlayCompletionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppFilePlayCompletionProcInfo, GetCurrentArchitecture())
#else
#define NewFilePlayCompletionProc(userRoutine)		\
		((FilePlayCompletionUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallFilePlayCompletionProc(userRoutine, chan)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppFilePlayCompletionProcInfo, (chan))
#else
#define CallFilePlayCompletionProc(userRoutine, chan)		\
		(*(userRoutine))((chan))
#endif

typedef struct AudioSelection AudioSelection;

typedef AudioSelection *AudioSelectionPtr;

struct SndDoubleBuffer {
	long							dbNumFrames;
	long							dbFlags;
	long							dbUserInfo[2];
	char							dbSoundData[1];
};
typedef struct SndDoubleBuffer SndDoubleBuffer;

typedef SndDoubleBuffer *SndDoubleBufferPtr;

typedef pascal void (*SndDoubleBackProcPtr)(SndChannelPtr channel, SndDoubleBufferPtr doubleBufferPtr);

#if GENERATINGCFM
typedef UniversalProcPtr SndDoubleBackUPP;
#else
typedef SndDoubleBackProcPtr SndDoubleBackUPP;
#endif

enum {
	uppSndDoubleBackProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SndChannelPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(SndDoubleBufferPtr)))
};

#if GENERATINGCFM
#define NewSndDoubleBackProc(userRoutine)		\
		(SndDoubleBackUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSndDoubleBackProcInfo, GetCurrentArchitecture())
#else
#define NewSndDoubleBackProc(userRoutine)		\
		((SndDoubleBackUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallSndDoubleBackProc(userRoutine, channel, doubleBufferPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSndDoubleBackProcInfo, (channel), (doubleBufferPtr))
#else
#define CallSndDoubleBackProc(userRoutine, channel, doubleBufferPtr)		\
		(*(userRoutine))((channel), (doubleBufferPtr))
#endif

struct SndDoubleBufferHeader {
	short							dbhNumChannels;
	short							dbhSampleSize;
	short							dbhCompressionID;
	short							dbhPacketSize;
	UnsignedFixed					dbhSampleRate;
	SndDoubleBufferPtr				dbhBufferPtr[2];
	SndDoubleBackUPP				dbhDoubleBack;
};
typedef struct SndDoubleBufferHeader SndDoubleBufferHeader;

typedef SndDoubleBufferHeader *SndDoubleBufferHeaderPtr;

struct SndDoubleBufferHeader2 {
	short							dbhNumChannels;
	short							dbhSampleSize;
	short							dbhCompressionID;
	short							dbhPacketSize;
	UnsignedFixed					dbhSampleRate;
	SndDoubleBufferPtr				dbhBufferPtr[2];
	SndDoubleBackUPP				dbhDoubleBack;
	OSType							dbhFormat;
};
typedef struct SndDoubleBufferHeader2 SndDoubleBufferHeader2;

typedef SndDoubleBufferHeader2 *SndDoubleBufferHeader2Ptr;

struct SoundInfoList {
	short							count;
	Handle							infoHandle;
};
typedef struct SoundInfoList SoundInfoList;
typedef SoundInfoList *SoundInfoListPtr;

struct SoundComponentData {
	long			flags;
	OSType			format;
	short			numChannels;
	short			sampleSize;
	UnsignedFixed	sampleRate;
	long			sampleCount;
	Byte			*buffer;
	long			reserved;
};
typedef struct SoundComponentData SoundComponentData;
typedef SoundComponentData *SoundComponentDataPtr;


struct CompressionInfo {
	long							recordSize;
	OSType							format;
	short							compressionID;
	unsigned short					samplesPerPacket;
	unsigned short					bytesPerPacket;
	unsigned short					bytesPerFrame;
	unsigned short					bytesPerSample;
	unsigned short					futureUse1;
};
typedef struct CompressionInfo CompressionInfo;

typedef CompressionInfo *CompressionInfoPtr;

typedef CompressionInfoPtr *CompressionInfoHandle;

/*private thing to use as a reference to a Sound Converter*/
typedef struct OpaqueSoundConverter* SoundConverter;

/* These two routines for Get/SetSoundVol should no longer be used.*/
/* They were for old Apple Sound Chip machines, and do not support the DSP or PowerMacs.*/
/* Use Get/SetDefaultOutputVolume instead, if you must change the user's machine.*/
#if OLDROUTINENAMES && !GENERATINGCFM
extern pascal void SetSoundVol(short level);

#if !GENERATINGCFM
#pragma parameter GetSoundVol(__A0)
#endif
extern pascal void GetSoundVol(short *level)
 THREEWORDINLINE(0x4218, 0x10B8, 0x0260);
#endif

extern pascal OSErr SndDoCommand(SndChannelPtr chan, const SndCommand *cmd, Boolean noWait)
 ONEWORDINLINE(0xA803);
extern pascal OSErr SndDoImmediate(SndChannelPtr chan, const SndCommand *cmd)
 ONEWORDINLINE(0xA804);
extern pascal OSErr SndNewChannel(SndChannelPtr *chan, short synth, long init, SndCallBackUPP userRoutine)
 ONEWORDINLINE(0xA807);
extern pascal OSErr SndDisposeChannel(SndChannelPtr chan, Boolean quietNow)
 ONEWORDINLINE(0xA801);
extern pascal OSErr SndPlay(SndChannelPtr chan, SndListHandle sndHdl, Boolean async)
 ONEWORDINLINE(0xA805);
#if OLDROUTINENAMES
extern pascal OSErr SndAddModifier(SndChannelPtr chan, Ptr modifier, short id, long init)
 ONEWORDINLINE(0xA802);
#endif
extern pascal OSErr SndControl(short id, SndCommand *cmd)
 ONEWORDINLINE(0xA806);


/* Sound Manager 2.0 and later, uses _SoundDispatch */
extern pascal NumVersion SndSoundManagerVersion(void)
 FOURWORDINLINE(0x203C, 0x000C, 0x0008, 0xA800);
extern pascal OSErr SndStartFilePlay(SndChannelPtr chan, short fRefNum, short resNum, long bufferSize, void *theBuffer, AudioSelectionPtr theSelection, FilePlayCompletionUPP theCompletion, Boolean async)
 FOURWORDINLINE(0x203C, 0x0D00, 0x0008, 0xA800);
extern pascal OSErr SndPauseFilePlay(SndChannelPtr chan)
 FOURWORDINLINE(0x203C, 0x0204, 0x0008, 0xA800);
extern pascal OSErr SndStopFilePlay(SndChannelPtr chan, Boolean quietNow)
 FOURWORDINLINE(0x203C, 0x0308, 0x0008, 0xA800);
extern pascal OSErr SndChannelStatus(SndChannelPtr chan, short theLength, SCStatusPtr theStatus)
 FOURWORDINLINE(0x203C, 0x0510, 0x0008, 0xA800);
extern pascal OSErr SndManagerStatus(short theLength, SMStatusPtr theStatus)
 FOURWORDINLINE(0x203C, 0x0314, 0x0008, 0xA800);
extern pascal void SndGetSysBeepState(short *sysBeepState)
 FOURWORDINLINE(0x203C, 0x0218, 0x0008, 0xA800);
extern pascal OSErr SndSetSysBeepState(short sysBeepState)
 FOURWORDINLINE(0x203C, 0x011C, 0x0008, 0xA800);
extern pascal OSErr SndPlayDoubleBuffer(SndChannelPtr chan, SndDoubleBufferHeaderPtr theParams)
 FOURWORDINLINE(0x203C, 0x0420, 0x0008, 0xA800);


/* MACE compression routines */
extern pascal NumVersion MACEVersion(void)
 FOURWORDINLINE(0x203C, 0x0000, 0x0010, 0xA800);
extern pascal void Comp3to1(const void *inBuffer, void *outBuffer, unsigned long cnt, StateBlockPtr inState, StateBlockPtr outState, unsigned long numChannels, unsigned long whichChannel)
 FOURWORDINLINE(0x203C, 0x0004, 0x0010, 0xA800);
extern pascal void Exp1to3(const void *inBuffer, void *outBuffer, unsigned long cnt, StateBlockPtr inState, StateBlockPtr outState, unsigned long numChannels, unsigned long whichChannel)
 FOURWORDINLINE(0x203C, 0x0008, 0x0010, 0xA800);
extern pascal void Comp6to1(const void *inBuffer, void *outBuffer, unsigned long cnt, StateBlockPtr inState, StateBlockPtr outState, unsigned long numChannels, unsigned long whichChannel)
 FOURWORDINLINE(0x203C, 0x000C, 0x0010, 0xA800);
extern pascal void Exp1to6(const void *inBuffer, void *outBuffer, unsigned long cnt, StateBlockPtr inState, StateBlockPtr outState, unsigned long numChannels, unsigned long whichChannel)
 FOURWORDINLINE(0x203C, 0x0010, 0x0010, 0xA800);


/* Sound Manager 3.0 and later calls */
extern pascal OSErr GetSysBeepVolume(long *level)
 FOURWORDINLINE(0x203C, 0x0224, 0x0018, 0xA800);
extern pascal OSErr SetSysBeepVolume(long level)
 FOURWORDINLINE(0x203C, 0x0228, 0x0018, 0xA800);
extern pascal OSErr GetDefaultOutputVolume(long *level)
 FOURWORDINLINE(0x203C, 0x022C, 0x0018, 0xA800);
extern pascal OSErr SetDefaultOutputVolume(long level)
 FOURWORDINLINE(0x203C, 0x0230, 0x0018, 0xA800);
extern pascal OSErr GetSoundHeaderOffset(SndListHandle sndHandle, long *offset)
 FOURWORDINLINE(0x203C, 0x0404, 0x0018, 0xA800);
extern pascal UnsignedFixed UnsignedFixedMulDiv(UnsignedFixed value, UnsignedFixed multiplier, UnsignedFixed divisor)
 FOURWORDINLINE(0x203C, 0x060C, 0x0018, 0xA800);
extern pascal OSErr GetCompressionInfo(short compressionID, OSType format, short numChannels, short sampleSize, CompressionInfoPtr cp)
 FOURWORDINLINE(0x203C, 0x0710, 0x0018, 0xA800);
extern pascal OSErr SetSoundPreference(OSType theType, Str255 name, Handle settings)
 FOURWORDINLINE(0x203C, 0x0634, 0x0018, 0xA800);
extern pascal OSErr GetSoundPreference(OSType theType, Str255 name, Handle settings)
 FOURWORDINLINE(0x203C, 0x0638, 0x0018, 0xA800);


/* Sound Manager 3.1 and later calls */
extern pascal OSErr SndGetInfo(SndChannelPtr chan, OSType selector, void *infoPtr)
 FOURWORDINLINE(0x203C, 0x063C, 0x0018, 0xA800);
extern pascal OSErr SndSetInfo(SndChannelPtr chan, OSType selector, const void *infoPtr)
 FOURWORDINLINE(0x203C, 0x0640, 0x0018, 0xA800);
extern pascal OSErr GetSoundOutputInfo(Component outputDevice, OSType selector, void *infoPtr)
 FOURWORDINLINE(0x203C, 0x0644, 0x0018, 0xA800);
extern pascal OSErr SetSoundOutputInfo(Component outputDevice, OSType selector, const void *infoPtr)
 FOURWORDINLINE(0x203C, 0x0648, 0x0018, 0xA800);

/* Sound Manager 3.2 and later calls */
pascal OSErr GetCompressionName(OSType compressionType, Str255 compressionName)
 FOURWORDINLINE(0x203C,0x044C,0x0018,0xA800);
pascal OSErr SoundConverterOpen(const SoundComponentData *inputFormat, const SoundComponentData *outputFormat, SoundConverter *sc)
 FOURWORDINLINE(0x203C,0x0650,0x0018,0xA800);
pascal OSErr SoundConverterClose(SoundConverter sc)
 FOURWORDINLINE(0x203C,0x0254,0x0018,0xA800);
pascal OSErr SoundConverterGetBufferSizes(SoundConverter sc, unsigned long inputBytesTarget, unsigned long *inputFrames,
 unsigned long *inputBytes, unsigned long *outputBytes)
 FOURWORDINLINE(0x203C,0x0A58,0x0018,0xA800);
pascal OSErr SoundConverterBeginConversion(SoundConverter sc)
 FOURWORDINLINE(0x203C,0x025C,0x0018,0xA800);
pascal OSErr SoundConverterConvertBuffer(SoundConverter sc, const void *inputPtr, unsigned long inputFrames,
 void *outputPtr, unsigned long *outputFrames, unsigned long *outputBytes)
 FOURWORDINLINE(0x203C,0x0C60,0x0018,0xA800);
pascal OSErr SoundConverterEndConversion(SoundConverter sc, void *outputPtr, unsigned long *outputFrames,
 unsigned long *outputBytes)
 FOURWORDINLINE(0x203C,0x0864,0x0018,0xA800);

enum {
	uppSndCallBackProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SndChannelPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(SndCommand*)))
};

#if GENERATINGCFM
#define NewSndCallBackProc(userRoutine)		\
		(SndCallBackUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSndCallBackProcInfo, GetCurrentArchitecture())
#else
#define NewSndCallBackProc(userRoutine)		\
		((SndCallBackUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallSndCallBackProc(userRoutine, chan, cmd)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSndCallBackProcInfo, (chan), (cmd))
#else
#define CallSndCallBackProc(userRoutine, chan, cmd)		\
		(*(userRoutine))((chan), (cmd))
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

#endif /* __SOUND__ */

/*
 	File:		Speech.h
 
 	Contains:	Speech Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __SPEECH__
#define __SPEECH__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __MEMORY__
#include <Memory.h>
#endif
/*	#include <MixedMode.h>										*/

#ifndef __FILES__
#include <Files.h>
#endif
/*	#include <OSUtils.h>										*/
/*	#include <Finder.h>											*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
	kTextToSpeechSynthType		= 'ttsc',
	kTextToSpeechVoiceType		= 'ttvd',
	kTextToSpeechVoiceFileType	= 'ttvf',
	kTextToSpeechVoiceBundleType = 'ttvb'
};

enum {
	kNoEndingProsody			= 1,
	kNoSpeechInterrupt			= 2,
	kPreflightThenPause			= 4
};

enum {
	kImmediate					= 0,
	kEndOfWord					= 1,
	kEndOfSentence				= 2
};

/*------------------------------------------*/
/* GetSpeechInfo & SetSpeechInfo selectors	*/
/*------------------------------------------*/
enum {
	soStatus					= 'stat',
	soErrors					= 'erro',
	soInputMode					= 'inpt',
	soCharacterMode				= 'char',
	soNumberMode				= 'nmbr',
	soRate						= 'rate',
	soPitchBase					= 'pbas',
	soPitchMod					= 'pmod',
	soVolume					= 'volm',
	soSynthType					= 'vers',
	soRecentSync				= 'sync',
	soPhonemeSymbols			= 'phsy',
	soCurrentVoice				= 'cvox',
	soCommandDelimiter			= 'dlim',
	soReset						= 'rset',
	soCurrentA5					= 'myA5',
	soRefCon					= 'refc',
	soTextDoneCallBack			= 'tdcb',
	soSpeechDoneCallBack		= 'sdcb',
	soSyncCallBack				= 'sycb',
	soErrorCallBack				= 'ercb',
	soPhonemeCallBack			= 'phcb',
	soWordCallBack				= 'wdcb',
	soSynthExtension			= 'xtnd',
	soSoundOutput				= 'sndo'
};

/*------------------------------------------*/
/* Speaking Mode Constants 					*/
/*------------------------------------------*/
enum {
	modeText					= 'TEXT',						/* input mode constants 					*/
	modePhonemes				= 'PHON',
	modeNormal					= 'NORM',						/* character mode and number mode constants */
	modeLiteral					= 'LTRL'
};

enum {
	soVoiceDescription			= 'info',
	soVoiceFile					= 'fref'
};

struct SpeechChannelRecord {
	long							data[1];
};
typedef struct SpeechChannelRecord SpeechChannelRecord;

typedef SpeechChannelRecord *SpeechChannel;

struct VoiceSpec {
	OSType							creator;
	OSType							id;
};
typedef struct VoiceSpec VoiceSpec;


enum {
	kNeuter						= 0,
	kMale						= 1,
	kFemale						= 2
};

struct VoiceDescription {
	long							length;
	VoiceSpec						voice;
	long							version;
	Str63							name;
	Str255							comment;
	short							gender;
	short							age;
	short							script;
	short							language;
	short							region;
	long							reserved[4];
};
typedef struct VoiceDescription VoiceDescription;

struct VoiceFileInfo {
	FSSpec							fileSpec;
	short							resID;
};
typedef struct VoiceFileInfo VoiceFileInfo;

struct SpeechStatusInfo {
	Boolean							outputBusy;
	Boolean							outputPaused;
	long							inputBytesLeft;
	short							phonemeCode;
};
typedef struct SpeechStatusInfo SpeechStatusInfo;

struct SpeechErrorInfo {
	short							count;
	OSErr							oldest;
	long							oldPos;
	OSErr							newest;
	long							newPos;
};
typedef struct SpeechErrorInfo SpeechErrorInfo;

struct SpeechVersionInfo {
	OSType							synthType;
	OSType							synthSubType;
	OSType							synthManufacturer;
	long							synthFlags;
	NumVersion						synthVersion;
};
typedef struct SpeechVersionInfo SpeechVersionInfo;

struct PhonemeInfo {
	short							opcode;
	Str15							phStr;
	Str31							exampleStr;
	short							hiliteStart;
	short							hiliteEnd;
};
typedef struct PhonemeInfo PhonemeInfo;

struct PhonemeDescriptor {
	short							phonemeCount;
	PhonemeInfo						thePhonemes[1];
};
typedef struct PhonemeDescriptor PhonemeDescriptor;

struct SpeechXtndData {
	OSType							synthCreator;
	Byte							synthData[2];
};
typedef struct SpeechXtndData SpeechXtndData;

struct DelimiterInfo {
	Byte							startDelimiter[2];
	Byte							endDelimiter[2];
};
typedef struct DelimiterInfo DelimiterInfo;

typedef pascal void (*SpeechTextDoneProcPtr)(SpeechChannel parameter0, long parameter1, Ptr *parameter2, long *parameter3, long *parameter4);
typedef pascal void (*SpeechDoneProcPtr)(SpeechChannel parameter0, long parameter1);
typedef pascal void (*SpeechSyncProcPtr)(SpeechChannel parameter0, long parameter1, OSType parameter2);
typedef pascal void (*SpeechErrorProcPtr)(SpeechChannel parameter0, long parameter1, OSErr parameter2, long parameter3);
typedef pascal void (*SpeechPhonemeProcPtr)(SpeechChannel parameter0, long parameter1, short parameter2);
typedef pascal void (*SpeechWordProcPtr)(SpeechChannel parameter0, long parameter1, long parameter2, short parameter3);

#if GENERATINGCFM
typedef UniversalProcPtr SpeechTextDoneUPP;
typedef UniversalProcPtr SpeechDoneUPP;
typedef UniversalProcPtr SpeechSyncUPP;
typedef UniversalProcPtr SpeechErrorUPP;
typedef UniversalProcPtr SpeechPhonemeUPP;
typedef UniversalProcPtr SpeechWordUPP;
#else
typedef SpeechTextDoneProcPtr SpeechTextDoneUPP;
typedef SpeechDoneProcPtr SpeechDoneUPP;
typedef SpeechSyncProcPtr SpeechSyncUPP;
typedef SpeechErrorProcPtr SpeechErrorUPP;
typedef SpeechPhonemeProcPtr SpeechPhonemeUPP;
typedef SpeechWordProcPtr SpeechWordUPP;
#endif

enum {
	uppSpeechTextDoneProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SpeechChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Ptr*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long*)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(long*))),
	uppSpeechDoneProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SpeechChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long))),
	uppSpeechSyncProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SpeechChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(OSType))),
	uppSpeechErrorProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SpeechChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long))),
	uppSpeechPhonemeProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SpeechChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short))),
	uppSpeechWordProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SpeechChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(short)))
};

#if GENERATINGCFM
#define NewSpeechTextDoneProc(userRoutine)		\
		(SpeechTextDoneUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSpeechTextDoneProcInfo, GetCurrentArchitecture())
#define NewSpeechDoneProc(userRoutine)		\
		(SpeechDoneUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSpeechDoneProcInfo, GetCurrentArchitecture())
#define NewSpeechSyncProc(userRoutine)		\
		(SpeechSyncUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSpeechSyncProcInfo, GetCurrentArchitecture())
#define NewSpeechErrorProc(userRoutine)		\
		(SpeechErrorUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSpeechErrorProcInfo, GetCurrentArchitecture())
#define NewSpeechPhonemeProc(userRoutine)		\
		(SpeechPhonemeUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSpeechPhonemeProcInfo, GetCurrentArchitecture())
#define NewSpeechWordProc(userRoutine)		\
		(SpeechWordUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSpeechWordProcInfo, GetCurrentArchitecture())
#else
#define NewSpeechTextDoneProc(userRoutine)		\
		((SpeechTextDoneUPP) (userRoutine))
#define NewSpeechDoneProc(userRoutine)		\
		((SpeechDoneUPP) (userRoutine))
#define NewSpeechSyncProc(userRoutine)		\
		((SpeechSyncUPP) (userRoutine))
#define NewSpeechErrorProc(userRoutine)		\
		((SpeechErrorUPP) (userRoutine))
#define NewSpeechPhonemeProc(userRoutine)		\
		((SpeechPhonemeUPP) (userRoutine))
#define NewSpeechWordProc(userRoutine)		\
		((SpeechWordUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallSpeechTextDoneProc(userRoutine, parameter0, parameter1, parameter2, parameter3, parameter4)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSpeechTextDoneProcInfo, (parameter0), (parameter1), (parameter2), (parameter3), (parameter4))
#define CallSpeechDoneProc(userRoutine, parameter0, parameter1)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSpeechDoneProcInfo, (parameter0), (parameter1))
#define CallSpeechSyncProc(userRoutine, parameter0, parameter1, parameter2)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSpeechSyncProcInfo, (parameter0), (parameter1), (parameter2))
#define CallSpeechErrorProc(userRoutine, parameter0, parameter1, parameter2, parameter3)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSpeechErrorProcInfo, (parameter0), (parameter1), (parameter2), (parameter3))
#define CallSpeechPhonemeProc(userRoutine, parameter0, parameter1, parameter2)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSpeechPhonemeProcInfo, (parameter0), (parameter1), (parameter2))
#define CallSpeechWordProc(userRoutine, parameter0, parameter1, parameter2, parameter3)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSpeechWordProcInfo, (parameter0), (parameter1), (parameter2), (parameter3))
#else
#define CallSpeechTextDoneProc(userRoutine, parameter0, parameter1, parameter2, parameter3, parameter4)		\
		(*(userRoutine))((parameter0), (parameter1), (parameter2), (parameter3), (parameter4))
#define CallSpeechDoneProc(userRoutine, parameter0, parameter1)		\
		(*(userRoutine))((parameter0), (parameter1))
#define CallSpeechSyncProc(userRoutine, parameter0, parameter1, parameter2)		\
		(*(userRoutine))((parameter0), (parameter1), (parameter2))
#define CallSpeechErrorProc(userRoutine, parameter0, parameter1, parameter2, parameter3)		\
		(*(userRoutine))((parameter0), (parameter1), (parameter2), (parameter3))
#define CallSpeechPhonemeProc(userRoutine, parameter0, parameter1, parameter2)		\
		(*(userRoutine))((parameter0), (parameter1), (parameter2))
#define CallSpeechWordProc(userRoutine, parameter0, parameter1, parameter2, parameter3)		\
		(*(userRoutine))((parameter0), (parameter1), (parameter2), (parameter3))
#endif

extern pascal NumVersion SpeechManagerVersion(void)
 FOURWORDINLINE(0x203C, 0x0000, 0x000C, 0xA800);
extern pascal OSErr MakeVoiceSpec(OSType creator, OSType id, VoiceSpec *voice)
 FOURWORDINLINE(0x203C, 0x0604, 0x000C, 0xA800);
extern pascal OSErr CountVoices(short *numVoices)
 FOURWORDINLINE(0x203C, 0x0108, 0x000C, 0xA800);
extern pascal OSErr GetIndVoice(short index, VoiceSpec *voice)
 FOURWORDINLINE(0x203C, 0x030C, 0x000C, 0xA800);
extern pascal OSErr GetVoiceDescription(VoiceSpec *voice, VoiceDescription *info, long infoLength)
 FOURWORDINLINE(0x203C, 0x0610, 0x000C, 0xA800);
extern pascal OSErr GetVoiceInfo(VoiceSpec *voice, OSType selector, void *voiceInfo)
 FOURWORDINLINE(0x203C, 0x0614, 0x000C, 0xA800);
extern pascal OSErr NewSpeechChannel(VoiceSpec *voice, SpeechChannel *chan)
 FOURWORDINLINE(0x203C, 0x0418, 0x000C, 0xA800);
extern pascal OSErr DisposeSpeechChannel(SpeechChannel chan)
 FOURWORDINLINE(0x203C, 0x021C, 0x000C, 0xA800);
extern pascal OSErr SpeakString(StringPtr s)
 FOURWORDINLINE(0x203C, 0x0220, 0x000C, 0xA800);
extern pascal OSErr SpeakText(SpeechChannel chan, Ptr textBuf, long textBytes)
 FOURWORDINLINE(0x203C, 0x0624, 0x000C, 0xA800);
extern pascal OSErr SpeakBuffer(SpeechChannel chan, Ptr textBuf, long textBytes, long controlFlags)
 FOURWORDINLINE(0x203C, 0x0828, 0x000C, 0xA800);
extern pascal OSErr StopSpeech(SpeechChannel chan)
 FOURWORDINLINE(0x203C, 0x022C, 0x000C, 0xA800);
extern pascal OSErr StopSpeechAt(SpeechChannel chan, long whereToStop)
 FOURWORDINLINE(0x203C, 0x0430, 0x000C, 0xA800);
extern pascal OSErr PauseSpeechAt(SpeechChannel chan, long whereToPause)
 FOURWORDINLINE(0x203C, 0x0434, 0x000C, 0xA800);
extern pascal OSErr ContinueSpeech(SpeechChannel chan)
 FOURWORDINLINE(0x203C, 0x0238, 0x000C, 0xA800);
extern pascal short SpeechBusy(void)
 FOURWORDINLINE(0x203C, 0x003C, 0x000C, 0xA800);
extern pascal short SpeechBusySystemWide(void)
 FOURWORDINLINE(0x203C, 0x0040, 0x000C, 0xA800);
extern pascal OSErr SetSpeechRate(SpeechChannel chan, Fixed rate)
 FOURWORDINLINE(0x203C, 0x0444, 0x000C, 0xA800);
extern pascal OSErr GetSpeechRate(SpeechChannel chan, Fixed *rate)
 FOURWORDINLINE(0x203C, 0x0448, 0x000C, 0xA800);
extern pascal OSErr SetSpeechPitch(SpeechChannel chan, Fixed pitch)
 FOURWORDINLINE(0x203C, 0x044C, 0x000C, 0xA800);
extern pascal OSErr GetSpeechPitch(SpeechChannel chan, Fixed *pitch)
 FOURWORDINLINE(0x203C, 0x0450, 0x000C, 0xA800);
extern pascal OSErr SetSpeechInfo(SpeechChannel chan, OSType selector, void *speechInfo)
 FOURWORDINLINE(0x203C, 0x0654, 0x000C, 0xA800);
extern pascal OSErr GetSpeechInfo(SpeechChannel chan, OSType selector, void *speechInfo)
 FOURWORDINLINE(0x203C, 0x0658, 0x000C, 0xA800);
extern pascal OSErr TextToPhonemes(SpeechChannel chan, Ptr textBuf, long textBytes, Handle phonemeBuf, long *phonemeBytes)
 FOURWORDINLINE(0x203C, 0x0A5C, 0x000C, 0xA800);
extern pascal OSErr UseDictionary(SpeechChannel chan, Handle dictionary)
 FOURWORDINLINE(0x203C, 0x0460, 0x000C, 0xA800);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __SPEECH__ */

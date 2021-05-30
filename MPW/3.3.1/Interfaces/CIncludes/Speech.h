/*
	File:		Speech.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.

*/

#ifndef _SPEECH_
	#define _SPEECH_

#ifndef __TYPES__
	#include <Types.h>
#endif

#ifndef __MEMORY__
	#include <Memory.h>
#endif

#ifndef __FILES__
	#include <Files.h>
#endif

#define kTextToSpeechSynthType 			'ttsc'
#define kTextToSpeechVoiceType 			'ttvd'
#define kTextToSpeechVoiceFileType		'ttvf'
#define kTextToSpeechVoiceBundleType	'ttvb'



enum  
	{
	gestaltSpeechHasPPCGlue		= 1			/* Bit position. If set, this Speech Mgr 	*/
	};										/* version has native PPC glue for API	 	*/


enum  
	{
	kNoEndingProsody			= 1,
	kNoSpeechInterrupt			= 2,
	kPreflightThenPause			= 4
	};

enum  
	{
	kImmediate					= 0,
	kEndOfWord					= 1,
	kEndOfSentence				= 2
	};


/*------------------------------------------*/
/* GetSpeechInfo & SetSpeechInfo selectors	*/
/*------------------------------------------*/
#define soStatus				'stat'		
#define soErrors				'erro'
#define soInputMode				'inpt'
#define soCharacterMode			'char'
#define soNumberMode			'nmbr'
#define soRate					'rate'
#define soPitchBase				'pbas'
#define soPitchMod				'pmod'
#define soVolume				'volm'
#define soSynthType				'vers'
#define soRecentSync			'sync'
#define soPhonemeSymbols		'phsy'
#define soCurrentVoice			'cvox'
#define soCommandDelimiter		'dlim'
#define soReset					'rset'
#define soCurrentA5				'myA5'
#define soRefCon				'refc'
#define soTextDoneCallBack		'tdcb'
#define soSpeechDoneCallBack	'sdcb'
#define soSyncCallBack			'sycb'
#define soErrorCallBack			'ercb'
#define soPhonemeCallBack		'phcb'
#define soWordCallBack			'wdcb'
#define soSynthExtension		'xtnd'
#define soSoundOutput			'sndo'



/*------------------------------------------*/
/* Speaking Mode Constants 					*/
/*------------------------------------------*/

#define modeText		'TEXT'		/* input mode constants 					*/
#define modePhonemes	'PHON'
#define modeNormal		'NORM'		/* character mode and number mode constants */
#define modeLiteral		'LTRL'



enum  
	{
	soVoiceDescription			= 'info',
	soVoiceFile					= 'fref'
	};


#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct SpeechChannelRecord 
{
	long			data[1];
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct SpeechChannelRecord SpeechChannelRecord;
typedef SpeechChannelRecord *SpeechChannel;



#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct VoiceSpec 
	{
	OSType			creator;
	OSType			id;
	};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct VoiceSpec VoiceSpec;




enum  
	{
	kNeuter = 0,
	kMale,
	kFemale
	};




#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct VoiceDescription 
{
	long						length;
	VoiceSpec					voice;
	long						version;
	Str63						name;
	Str255						comment;
	short						gender;
	short						age;
	short						script;
	short						language;
	short						region;
	long						reserved[4];
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct VoiceDescription VoiceDescription;




#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct VoiceFileInfo 
{
	FSSpec						fileSpec;
	short						resID;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct VoiceFileInfo VoiceFileInfo;




#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct SpeechStatusInfo 
{
	Boolean						outputBusy;
	Boolean						outputPaused;
	long						inputBytesLeft;
	short						phonemeCode;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct SpeechStatusInfo SpeechStatusInfo;




#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct SpeechErrorInfo 
{
	short						count;
	OSErr						oldest;
	long						oldPos;
	OSErr						newest;
	long						newPos;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct SpeechErrorInfo SpeechErrorInfo;




#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct SpeechVersionInfo 
{
	OSType						synthType;
	OSType						synthSubType;
	OSType						synthManufacturer;
	long						synthFlags;
	NumVersion					synthVersion;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct SpeechVersionInfo SpeechVersionInfo;




#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct PhonemeInfo 
{
	short						opcode;
	Str15						phStr;
	Str31						exampleStr;
	short						hiliteStart;
	short						hiliteEnd;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct PhonemeInfo PhonemeInfo;





#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct PhonemeDescriptor 
{
	short						phonemeCount;
	PhonemeInfo					thePhonemes[1];
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct PhonemeDescriptor PhonemeDescriptor;




#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct SpeechXtndData 
{
	OSType						synthCreator;
	Byte						synthData[2];
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct SpeechXtndData SpeechXtndData;




#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct DelimiterInfo 
{
	Byte						startDelimiter[2];
	Byte						endDelimiter[2];
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct DelimiterInfo DelimiterInfo;




/*+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-*/
/* Text-done callback routine typedef 	*/
/*+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-*/
typedef pascal void (*SpeechTextDoneProcPtr)(SpeechChannel, long, Ptr *, long *, long *);

#if USESROUTINEDESCRIPTORS
	/*------------------*/
	/* PPC version 		*/
	/*------------------*/
	enum 
		{
		uppSpeechTextDoneProcInfo = kPascalStackBased
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SpeechChannel)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
			 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Ptr*)))
			 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long*)))
			 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(long*)))
		};
	typedef UniversalProcPtr SpeechTextDoneUPP;
	#define CallSpeechTextDoneProc(userRoutine, parameter0, parameter1, parameter2, parameter3, parameter4)		\
			CallUniversalProc((UniversalProcPtr)(userRoutine), uppSpeechTextDoneProcInfo, (parameter0), (parameter1), (parameter2), (parameter3), (parameter4))
	#define NewSpeechTextDoneProc(userRoutine)		\
			(SpeechTextDoneUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSpeechTextDoneProcInfo, GetCurrentISA())
#else
	/*------------------*/
	/* 68K version 		*/
	/*------------------*/
	typedef SpeechTextDoneProcPtr SpeechTextDoneUPP;
	
	#define CallSpeechTextDoneProc(userRoutine, parameter0, parameter1, parameter2, parameter3, parameter4)		\
			(*(userRoutine))((parameter0), (parameter1), (parameter2), (parameter3), (parameter4))
	#define NewSpeechTextDoneProc(userRoutine)		\
			(SpeechTextDoneUPP)(userRoutine)
#endif





/*+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-*/
/* Speech-done callback routine typedef */
/*+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-*/
typedef pascal void (*SpeechDoneProcPtr)(SpeechChannel, long);

#if USESROUTINEDESCRIPTORS
	/*------------------*/
	/* PPC version 		*/
	/*------------------*/
	enum 
		{
		uppSpeechDoneProcInfo = kPascalStackBased
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SpeechChannel)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		};
	typedef UniversalProcPtr SpeechDoneUPP;
	#define CallSpeechDoneProc(userRoutine, parameter0, parameter1)		\
			CallUniversalProc((UniversalProcPtr)(userRoutine), uppSpeechDoneProcInfo, (parameter0), (parameter1))
	#define NewSpeechDoneProc(userRoutine)		\
			(SpeechDoneUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSpeechDoneProcInfo, GetCurrentISA())
#else
	/*------------------*/
	/* 68K version 		*/
	/*------------------*/
	typedef SpeechDoneProcPtr SpeechDoneUPP;
	#define CallSpeechDoneProc(userRoutine, parameter0, parameter1)		\
			(*(userRoutine))((parameter0), (parameter1))
	#define NewSpeechDoneProc(userRoutine)		\
			(SpeechDoneUPP)(userRoutine)
#endif




/*+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-*/
/* Sync callback routine typedef 		*/
/*+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-*/
typedef pascal void (*SpeechSyncProcPtr)(SpeechChannel, long, OSType);

#if USESROUTINEDESCRIPTORS
	/*------------------*/
	/* PPC version 		*/
	/*------------------*/
	enum 
		{
		uppSpeechSyncProcInfo = kPascalStackBased
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SpeechChannel)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
			 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(OSType)))
		};
	typedef UniversalProcPtr SpeechSyncUPP;
	#define CallSpeechSyncProc(userRoutine, parameter0, parameter1, parameter2)		\
			CallUniversalProc((UniversalProcPtr)(userRoutine), uppSpeechSyncProcInfo, (parameter0), (parameter1), (parameter2))
	#define NewSpeechSyncProc(userRoutine)		\
			(SpeechSyncUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSpeechSyncProcInfo, GetCurrentISA())
#else
	/*------------------*/
	/* 68K version 		*/
	/*------------------*/
	typedef SpeechSyncProcPtr SpeechSyncUPP;
	#define CallSpeechSyncProc(userRoutine, parameter0, parameter1, parameter2)		\
			(*(userRoutine))((parameter0), (parameter1), (parameter2))
	#define NewSpeechSyncProc(userRoutine)		\
			(SpeechSyncUPP)(userRoutine)
#endif





/*+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-*/
/* Error callback routine typedef 		*/
/*+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-*/
typedef pascal void (*SpeechErrorProcPtr)(SpeechChannel, long, OSErr, long);

#if USESROUTINEDESCRIPTORS
	/*------------------*/
	/* PPC version 		*/
	/*------------------*/
	enum 
		{
		uppSpeechErrorProcInfo = kPascalStackBased
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SpeechChannel)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
			 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(OSErr)))
			 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long)))
		};
	typedef UniversalProcPtr SpeechErrorUPP;
	#define CallSpeechErrorProc(userRoutine, parameter0, parameter1, parameter2, parameter3)		\
			CallUniversalProc((UniversalProcPtr)(userRoutine), uppSpeechErrorProcInfo, (parameter0), (parameter1), (parameter2), (parameter3))
	#define NewSpeechErrorProc(userRoutine)		\
			(SpeechErrorUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSpeechErrorProcInfo, GetCurrentISA())
#else
	/*------------------*/
	/* 68K version 		*/
	/*------------------*/
	typedef SpeechErrorProcPtr SpeechErrorUPP;
	#define CallSpeechErrorProc(userRoutine, parameter0, parameter1, parameter2, parameter3)		\
			(*(userRoutine))((parameter0), (parameter1), (parameter2), (parameter3))
	#define NewSpeechErrorProc(userRoutine)		\
			(SpeechErrorUPP)(userRoutine)
#endif





/*+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-*/
/* Phoneme callback routine typedef 	*/
/*+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-*/
typedef pascal void (*SpeechPhonemeProcPtr)(SpeechChannel, long, short);

#if USESROUTINEDESCRIPTORS
	/*------------------*/
	/* PPC version 		*/
	/*------------------*/
	enum 
		{
		uppSpeechPhonemeProcInfo = kPascalStackBased
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SpeechChannel)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
			 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short)))
		};
	typedef UniversalProcPtr SpeechPhonemeUPP;
	#define CallSpeechPhonemeProc(userRoutine, parameter0, parameter1, parameter2)		\
			CallUniversalProc((UniversalProcPtr)(userRoutine), uppSpeechPhonemeProcInfo, (parameter0), (parameter1), (parameter2))
	#define NewSpeechPhonemeProc(userRoutine)		\
			(SpeechPhonemeUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSpeechPhonemeProcInfo, GetCurrentISA())
#else
	/*------------------*/
	/* 68K version 		*/
	/*------------------*/
	typedef SpeechPhonemeProcPtr SpeechPhonemeUPP;
	#define CallSpeechPhonemeProc(userRoutine, parameter0, parameter1, parameter2)		\
			(*(userRoutine))((parameter0), (parameter1), (parameter2))
	#define NewSpeechPhonemeProc(userRoutine)		\
			(SpeechPhonemeUPP)(userRoutine)
#endif





/*+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-*/
/* Word callback routine typedef 		*/
/*+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-*/
typedef pascal void (*SpeechWordProcPtr)(SpeechChannel, long, long, short);

#if USESROUTINEDESCRIPTORS
	/*------------------*/
	/* PPC version 		*/
	/*------------------*/
	enum 
		{
		uppSpeechWordProcInfo = kPascalStackBased
			 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SpeechChannel)))
			 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
			 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
			 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(short)))
		};
	typedef UniversalProcPtr SpeechWordUPP;
	#define CallSpeechWordProc(userRoutine, parameter0, parameter1, parameter2, parameter3)		\
			CallUniversalProc((UniversalProcPtr)(userRoutine), uppSpeechWordProcInfo, (parameter0), (parameter1), (parameter2), (parameter3))
	#define NewSpeechWordProc(userRoutine)		\
			(SpeechWordUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSpeechWordProcInfo, GetCurrentISA())
#else
	/*------------------*/
	/* 68K version 		*/
	/*------------------*/
	typedef SpeechWordProcPtr SpeechWordUPP;
	#define CallSpeechWordProc(userRoutine, parameter0, parameter1, parameter2, parameter3)		\
			(*(userRoutine))((parameter0), (parameter1), (parameter2), (parameter3))
	#define NewSpeechWordProc(userRoutine)		\
			(SpeechWordUPP)(userRoutine)
#endif




#ifdef __cplusplus
extern "C" {
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

extern pascal OSErr SetSpeechDefaults(OSType selector, void *defaultInfo)
 FOURWORDINLINE(0x203C, 0x0464, 0x000C, 0xA800);

extern pascal OSErr GetSpeechDefaults(OSType selector, void *defaultInfo)
 FOURWORDINLINE(0x203C, 0x0468, 0x000C, 0xA800);

extern pascal OSErr AddSpeechChannelToList(SpeechChannel ch)
 FOURWORDINLINE(0x203C, 0x026C, 0x000C, 0xA800);

extern pascal OSErr ShutDownSpeechManager(void)
 FOURWORDINLINE(0x203C, 0x0070, 0x000C, 0xA800);

extern pascal OSErr KillIdlePrivateChannels(Boolean curProcessOnly)
 FOURWORDINLINE(0x203C, 0x0174, 0x000C, 0xA800);

extern pascal OSErr KillProcessChannels(void)
 FOURWORDINLINE(0x203C, 0x0078, 0x000C, 0xA800);

extern pascal OSErr RegisterVoices(long whereToSearch)
 FOURWORDINLINE(0x203C, 0x047C, 0x000C, 0xA800);

extern pascal OSErr UnRegisterVoices(unsigned short whichVoices)
 FOURWORDINLINE(0x203C, 0x0480, 0x000C, 0xA800);
#ifdef __cplusplus
}
#endif

#endif


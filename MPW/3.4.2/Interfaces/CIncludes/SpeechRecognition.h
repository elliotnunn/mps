/*
 	File:		SpeechRecognition.h

 	Contains:	Apple Speech Recognition Toolbox Interfaces.
 
 	Version:	Technology:	PlainTalk 1.5
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __SPEECHRECOGNITION__
#define __SPEECHRECOGNITION__

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif


enum {
	gestaltSpeechRecognitionVersion = 'srtb',
	gestaltSpeechRecognitionAttr = 'srta'
};


enum {
	gestaltDesktopSpeechRecognition = 1L << 0,
	gestaltTelephoneSpeechRecognition = 1L << 1
};

/* Error Codes [Speech recognition gets -5100 through -5199] */

enum {
	kSRNotAvailable				= -5100,						/* the service requested is not avail or applicable */
	kSRInternalError			= -5101,						/* a system internal or hardware error condition */
	kSRComponentNotFound		= -5102,						/* a needed system resource was not located */
	kSROutOfMemory				= -5103,						/* an out of memory error occurred in the toolbox memory space */
	kSRNotASpeechObject			= -5104,						/* the object specified is no longer or never was valid */
	kSRBadParameter				= -5105,						/* an invalid parameter was specified */
	kSRParamOutOfRange			= -5106,						/* when we say 0-100, don't pass in 101. */
	kSRBadSelector				= -5107,						/* an unrecognized selector was specified */
	kSRBufferTooSmall			= -5108,						/* returned from attribute access functions */
	kSRNotARecSystem			= -5109,						/* the object used was not a SRRecognitionSystem */
	kSRFeedbackNotAvail			= -5110,						/* there is no feedback window associated with SRRecognizer */
	kSRCantSetProperty			= -5111,						/* a non-settable property was specified */
	kSRCantGetProperty			= -5112,						/* a non-gettable property was specified */
	kSRCantSetDuringRecognition	= -5113,						/* the property can't be set while recognition is in progress -- do before or between utterances. */
	kSRAlreadyListening			= -5114,						/* in response to SRStartListening */
	kSRNotListeningState		= -5115,						/* in response to SRStopListening */
	kSRModelMismatch			= -5116,						/* no acoustical models are avail to match request */
	kSRNoClientLanguageModel	= -5117,						/* trying to access a non-specified SRLanguageModel */
	kSRNoPendingUtterances		= -5118,						/* nothing to continue search on */
	kSRRecognitionCanceled		= -5119,						/* an abort error occurred during search */
	kSRRecognitionDone			= -5120,						/* search has finished, but nothing was recognized */
	kSROtherRecAlreadyModal		= -5121,						/* another recognizer is modal at the moment, so can't set this recognizer's kSRBlockModally property right now */
	kSRHasNoSubItems			= -5122,						/* SRCountItems or related routine was called on an object without subelements -- e.g. a word -- rather than phrase, path, or LM. */
	kSRSubItemNotFound			= -5123,						/* returned when accessing a non-existent sub item of a container */
	kSRLanguageModelTooBig		= -5124,						/* Cant build language models so big */
	kSRAlreadyReleased			= -5125,						/* this object has already been released before */
	kSRAlreadyFinished			= -5126,						/* the language model can't be finished twice */
	kSRWordNotFound				= -5127,						/* the spelling couldn't be found in lookup(s) */
	kSRNotFinishedWithRejection	= -5128,						/* property not found because the LMObj is not finished with rejection */
	kSRExpansionTooDeep			= -5129,						/* Language model is left recursive or is embedded too many levels */
	kSRTooManyElements			= -5130,						/* Too many elements added to phrase or path or other langauge model object */
	kSRCantAdd					= -5131,						/* Can't add given type of object to the base SRLanguageObject (e.g.in SRAddLanguageObject)	*/
	kSRSndInSourceDisconnected	= -5132,						/* Sound input source is disconnected */
	kSRCantReadLanguageObject	= -5133,						/* An error while trying to create new Language object from file or pointer -- possibly bad format */
																/* non-release debugging error codes are included here */
	kSRNotImplementedYet		= -5199							/* you'd better wait for this feature in a future release */
};

/* Type Definitions */
typedef struct OpaqueSRSpeechObject* SRSpeechObject;
typedef SRSpeechObject SRRecognitionSystem;
typedef SRSpeechObject SRRecognizer;
typedef SRSpeechObject SRSpeechSource;
typedef SRSpeechSource SRRecognitionResult;
typedef SRSpeechObject SRLanguageObject;
typedef SRLanguageObject SRLanguageModel;
typedef SRLanguageObject SRPath;
typedef SRLanguageObject SRPhrase;
typedef SRLanguageObject SRWord;
/* between 0 and 100 */
typedef unsigned short SRSpeedSetting;
/* between 0 and 100 */
typedef unsigned short SRRejectionLevel;
/* When an event occurs, the user supplied proc will be called with a pointer	*/
/*	to the param passed in and a flag to indicate conditions such				*/
/*	as interrupt time or system background time.								*/
struct SRCallBackStruct {
	long 							what;						/* one of notification flags */
	long 							message;					/* contains SRRecognitionResult id */
	SRRecognizer 					instance;					/* ID of recognizer being notified */
	OSErr 							status;						/* result status of last search */
	short 							flags;						/* non-zero if occurs during interrupt */
	long 							refCon;						/* user defined - set from SRCallBackParam */
};
typedef struct SRCallBackStruct SRCallBackStruct;

/* Call back procedure definition */
typedef pascal void (*SRCallBackProcPtr)(SRCallBackStruct *param);

#if GENERATINGCFM
typedef UniversalProcPtr SRCallBackUPP;
#else
typedef SRCallBackProcPtr SRCallBackUPP;
#endif

enum {
	uppSRCallBackProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SRCallBackStruct *)))
};

#if GENERATINGCFM
#define NewSRCallBackProc(userRoutine)		\
		(SRCallBackUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSRCallBackProcInfo, GetCurrentArchitecture())
#else
#define NewSRCallBackProc(userRoutine)		\
		((SRCallBackUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallSRCallBackProc(userRoutine, param)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSRCallBackProcInfo, (param))
#else
#define CallSRCallBackProc(userRoutine, param)		\
		(*(userRoutine))((param))
#endif
struct SRCallBackParam {
	SRCallBackUPP 					callBack;
	long 							refCon;
};
typedef struct SRCallBackParam SRCallBackParam;

/* Recognition System Types */

enum {
	kSRDefaultRecognitionSystemID = 0
};

/* Recognition System Properties */

enum {
	kSRFeedbackAndListeningModes = 'fbwn',						/* short: one of kSRNoFeedbackHasListenModes, kSRHasFeedbackHasListenModes, kSRNoFeedbackNoListenModes */
	kSRRejectedWord				= 'rejq',						/* the SRWord used to represent a rejection */
	kSRCleanupOnClientExit		= 'clup'						/* Boolean: Default is true. The rec system and everything it owns is disposed when the client application quits */
};


enum {
	kSRNoFeedbackNoListenModes	= 0,							/* next allocated recognizer has no feedback window and doesn't use listening modes	*/
	kSRHasFeedbackHasListenModes = 1,							/* next allocated recognizer has feedback window and uses listening modes 			*/
	kSRNoFeedbackHasListenModes	= 2								/* next allocated recognizer has no feedback window but does use listening modes 	*/
};

/* Speech Source Types */

enum {
	kSRDefaultSpeechSource		= 0,
	kSRLiveDesktopSpeechSource	= 'dklv',						/* live desktop sound input */
	kSRCanned22kHzSpeechSource	= 'ca22'						/* AIFF file based 16 bit, 22.050 KHz sound input */
};

/* Notification via Apple Event or Callback */
/* Notification Flags */

enum {
	kSRNotifyRecognitionBeginning = 1L << 0,					/* recognition can begin. client must now call SRContinueRecognition or SRCancelRecognition */
	kSRNotifyRecognitionDone	= 1L << 1						/* recognition has terminated. result (if any) is available. */
};

/* Apple Event selectors */
/* AppleEvent message class  */

enum {
	kAESpeechSuite				= 'sprc'
};

/* AppleEvent message event ids */

enum {
	kAESpeechDone				= 'srsd',
	kAESpeechDetected			= 'srbd'
};

/* AppleEvent Parameter ids */

enum {
	keySRRecognizer				= 'krec',
	keySRSpeechResult			= 'kspr',
	keySRSpeechStatus			= 'ksst'
};

/* AppleEvent Parameter types */

enum {
	typeSRRecognizer			= 'trec',
	typeSRSpeechResult			= 'tspr'
};

/* SRRecognizer Properties */

enum {
	kSRNotificationParam		= 'noti',						/* see notification flags below */
	kSRCallBackParam			= 'call',						/* type SRCallBackParam */
	kSRSearchStatusParam		= 'stat',						/* see status flags below */
	kSRAutoFinishingParam		= 'afin',						/* automatic finishing applied on LM for search */
	kSRForegroundOnly			= 'fgon',						/* Boolean. Default is true. If true, client recognizer only active when in foreground.	*/
	kSRBlockBackground			= 'blbg',						/* Boolean. Default is false. If true, when client recognizer in foreground, rest of LMs are inactive.	*/
	kSRBlockModally				= 'blmd',						/* Boolean. Default is false. When true, this client's LM is only active LM; all other LMs are inactive. Be nice, don't be modal for long periods! */
	kSRWantsResultTextDrawn		= 'txfb',						/* Boolean. Default is true. If true, search results are posted to Feedback window */
	kSRWantsAutoFBGestures		= 'dfbr',						/* Boolean. Default is true. If true, client needn't call SRProcessBegin/End to get default feedback behavior */
	kSRSoundInVolume			= 'volu',						/* short in [0..100] log scaled sound input power. Can't set this property */
	kSRReadAudioFSSpec			= 'aurd',						/* *FSSpec. Specify FSSpec where raw audio is to be read (AIFF format) using kSRCanned22kHzSpeechSource. Reads until EOF */
	kSRCancelOnSoundOut			= 'caso',						/* Boolean: Default is true.  If any sound is played out during utterance, recognition is aborted. */
	kSRSpeedVsAccuracyParam		= 'sped'						/* SRSpeedSetting between 0 and 100 */
};

/* 0 means more accurate but slower. */
/* 100 means (much) less accurate but faster. */

enum {
	kSRUseToggleListen			= 0,							/* listen key modes */
	kSRUsePushToTalk			= 1
};


enum {
	kSRListenKeyMode			= 'lkmd',						/* short: either kSRUseToggleListen or kSRUsePushToTalk */
	kSRListenKeyCombo			= 'lkey',						/* short: Push-To-Talk key combination; high byte is high byte of event->modifiers, the low byte is the keycode from event->message */
	kSRListenKeyName			= 'lnam',						/* Str63: string representing ListenKeyCombo */
	kSRKeyWord					= 'kwrd',						/* Str255: keyword preceding spoken commands in kSRUseToggleListen mode */
	kSRKeyExpected				= 'kexp'						/* Boolean: Must the PTT key be depressed or the key word spoken before recognition can occur? */
};

/* Operational Status Flags */

enum {
	kSRIdleRecognizer			= 1L << 0,						/* engine is not active */
	kSRSearchInProgress			= 1L << 1,						/* search is in progress */
	kSRSearchWaitForAllClients	= 1L << 2,						/* search is suspended waiting on all clients' input */
	kSRMustCancelSearch			= 1L << 3,						/* something has occurred (sound played, non-speech detected) requiring the search to abort */
	kSRPendingSearch			= 1L << 4						/* we're about to start searching */
};

/* Recognition Result Properties */

enum {
	kSRTEXTFormat				= 'TEXT',						/* raw text in user supplied memory */
	kSRPhraseFormat				= 'lmph',						/* SRPhrase containing result words */
	kSRPathFormat				= 'lmpt',						/* SRPath containing result phrases or words */
	kSRLanguageModelFormat		= 'lmfm'						/* top level SRLanguageModel for post parse */
};

/* SRLanguageObject Family Properties */

enum {
	kSRSpelling					= 'spel',						/* spelling of a SRWord or SRPhrase or SRPath, or name of a SRLanguageModel */
	kSRLMObjType				= 'lmtp',						/* Returns one of SRLanguageObject Types listed below */
	kSRRefCon					= 'refc',						/* 4 bytes of user storage */
	kSROptional					= 'optl',						/* Boolean -- true if SRLanguageObject is optional	*/
	kSREnabled					= 'enbl',						/* Boolean -- true if SRLanguageObject enabled */
	kSRRepeatable				= 'rptb',						/* Boolean -- true if SRLanguageObject is repeatable */
	kSRRejectable				= 'rjbl',						/* Boolean -- true if SRLanguageObject is rejectable (Recognition System's kSRRejectedWord */
																/*		object can be returned in place of SRLanguageObject with this property)	*/
	kSRRejectionLevel			= 'rjct'						/* SRRejectionLevel between 0 and 100 */
};

/* LM Object Types -- returned as kSRLMObjType property of language model objects */

enum {
	kSRLanguageModelType		= 'lmob',						/* SRLanguageModel */
	kSRPathType					= 'path',						/* SRPath */
	kSRPhraseType				= 'phra',						/* SRPhrase */
	kSRWordType					= 'word'						/* SRWord */
};

/* a normal and reasonable rejection level */

enum {
	kSRDefaultRejectionLevel	= 50
};

/********************************************************************************/
/*						NOTES ON USING THE API									*/
/*																				*/
/*		All operations (with the exception of SRGetRecognitionSystem) are		*/
/*		directed toward an object allocated or begot from New, Get and Read		*/
/*		type calls.																*/
/*																				*/
/*		There is a simple rule in dealing with allocation and disposal:			*/
/*																				*/
/*		*	all toolbox allocations are obtained from a SRRecognitionSystem		*/
/*																				*/
/*		*	if you obtain an object via New or Get, then you own a reference 	*/
/*			to that object and it must be released via SRReleaseObject when		*/
/*			you no longer need it												*/
/*																				*/
/*		*	when you receive a SRRecognitionResult object via AppleEvent or		*/
/*			callback, it has essentially been created on your behalf and so		*/
/*			you are responsible for releasing it as above						*/
/*																				*/
/*		*	when you close a SRRecognitionSystem, all remaining objects which		*/
/*			were allocated with it will be forcefully released and any			*/
/*			remaining references to those objects will be invalid.				*/
/*																				*/
/*		This translates into a very simple guideline:							*/
/*			If you allocate it or have it allocated for you, you must release	*/
/*			it.  If you are only peeking at it, then don't release it.			*/
/*																				*/
/********************************************************************************/
/* Opening and Closing of the SRRecognitionSystem */
extern pascal OSErr SROpenRecognitionSystem(SRRecognitionSystem *system, OSType systemID)
 THREEWORDINLINE(0x303C, 0x0400, 0xAA56);

extern pascal OSErr SRCloseRecognitionSystem(SRRecognitionSystem system)
 THREEWORDINLINE(0x303C, 0x0201, 0xAA56);

/* Accessing Properties of any Speech Object */
extern pascal OSErr SRSetProperty(SRSpeechObject srObject, OSType selector, const void *property, Size propertyLen)
 THREEWORDINLINE(0x303C, 0x0802, 0xAA56);

extern pascal OSErr SRGetProperty(SRSpeechObject srObject, OSType selector, void *property, Size *propertyLen)
 THREEWORDINLINE(0x303C, 0x0803, 0xAA56);

/* Any object obtained via New or Get type calls must be released */
extern pascal OSErr SRReleaseObject(SRSpeechObject srObject)
 THREEWORDINLINE(0x303C, 0x0204, 0xAA56);

extern pascal OSErr SRGetReference(SRSpeechObject srObject, SRSpeechObject *newObjectRef)
 THREEWORDINLINE(0x303C, 0x0425, 0xAA56);

/* SRRecognizer Instance Functions */
extern pascal OSErr SRNewRecognizer(SRRecognitionSystem system, SRRecognizer *recognizer, OSType sourceID)
 THREEWORDINLINE(0x303C, 0x060A, 0xAA56);

extern pascal OSErr SRStartListening(SRRecognizer recognizer)
 THREEWORDINLINE(0x303C, 0x020C, 0xAA56);

extern pascal OSErr SRStopListening(SRRecognizer recognizer)
 THREEWORDINLINE(0x303C, 0x020D, 0xAA56);

extern pascal OSErr SRSetLanguageModel(SRRecognizer recognizer, SRLanguageModel languageModel)
 THREEWORDINLINE(0x303C, 0x040E, 0xAA56);

extern pascal OSErr SRGetLanguageModel(SRRecognizer recognizer, SRLanguageModel *languageModel)
 THREEWORDINLINE(0x303C, 0x040F, 0xAA56);

extern pascal OSErr SRContinueRecognition(SRRecognizer recognizer)
 THREEWORDINLINE(0x303C, 0x0210, 0xAA56);

extern pascal OSErr SRCancelRecognition(SRRecognizer recognizer)
 THREEWORDINLINE(0x303C, 0x0211, 0xAA56);

extern pascal OSErr SRIdle(void )
 THREEWORDINLINE(0x303C, 0x0028, 0xAA56);

/* Language Model Building and Manipulation Functions */
extern pascal OSErr SRNewLanguageModel(SRRecognitionSystem system, SRLanguageModel *model, const void *name, Size nameLength)
 THREEWORDINLINE(0x303C, 0x0812, 0xAA56);

extern pascal OSErr SRNewPath(SRRecognitionSystem system, SRPath *path)
 THREEWORDINLINE(0x303C, 0x0413, 0xAA56);

extern pascal OSErr SRNewPhrase(SRRecognitionSystem system, SRPhrase *phrase, const void *text, Size textLength)
 THREEWORDINLINE(0x303C, 0x0814, 0xAA56);

extern pascal OSErr SRNewWord(SRRecognitionSystem system, SRWord *word, const void *text, Size textLength)
 THREEWORDINLINE(0x303C, 0x0815, 0xAA56);

/* Operations on any object of the SRLanguageObject family */
extern pascal OSErr SRPutLanguageObjectIntoHandle(SRLanguageObject languageObject, Handle lobjHandle)
 THREEWORDINLINE(0x303C, 0x0416, 0xAA56);

extern pascal OSErr SRPutLanguageObjectIntoDataFile(SRLanguageObject languageObject, short fRefNum)
 THREEWORDINLINE(0x303C, 0x0328, 0xAA56);

extern pascal OSErr SRNewLanguageObjectFromHandle(SRRecognitionSystem system, SRLanguageObject *languageObject, Handle lObjHandle)
 THREEWORDINLINE(0x303C, 0x0417, 0xAA56);

extern pascal OSErr SRNewLanguageObjectFromDataFile(SRRecognitionSystem system, SRLanguageObject *languageObject, short fRefNum)
 THREEWORDINLINE(0x303C, 0x0427, 0xAA56);

extern pascal OSErr SREmptyLanguageObject(SRLanguageObject languageObject)
 THREEWORDINLINE(0x303C, 0x0218, 0xAA56);

extern pascal OSErr SRChangeLanguageObject(SRLanguageObject languageObject, const void *text, Size textLength)
 THREEWORDINLINE(0x303C, 0x0619, 0xAA56);

extern pascal OSErr SRAddLanguageObject(SRLanguageObject base, SRLanguageObject addon)
 THREEWORDINLINE(0x303C, 0x041A, 0xAA56);

extern pascal OSErr SRAddText(SRLanguageObject base, const void *text, Size textLength, long refCon)
 THREEWORDINLINE(0x303C, 0x081B, 0xAA56);

extern pascal OSErr SRRemoveLanguageObject(SRLanguageObject base, SRLanguageObject toRemove)
 THREEWORDINLINE(0x303C, 0x041C, 0xAA56);

/* Traversing SRRecognitionResults or SRLanguageObjects */
extern pascal OSErr SRCountItems(SRSpeechObject container, long *count)
 THREEWORDINLINE(0x303C, 0x0405, 0xAA56);

extern pascal OSErr SRGetIndexedItem(SRSpeechObject container, SRSpeechObject *item, long index)
 THREEWORDINLINE(0x303C, 0x0606, 0xAA56);

extern pascal OSErr SRSetIndexedItem(SRSpeechObject container, SRSpeechObject item, long index)
 THREEWORDINLINE(0x303C, 0x0607, 0xAA56);

extern pascal OSErr SRRemoveIndexedItem(SRSpeechObject container, long index)
 THREEWORDINLINE(0x303C, 0x0408, 0xAA56);

/* Utilizing the System Feedback Window */
extern pascal OSErr SRDrawText(SRRecognizer recognizer, const void *dispText, Size dispLength)
 THREEWORDINLINE(0x303C, 0x0621, 0xAA56);

extern pascal OSErr SRDrawRecognizedText(SRRecognizer recognizer, const void *dispText, Size dispLength)
 THREEWORDINLINE(0x303C, 0x0622, 0xAA56);

extern pascal OSErr SRSpeakText(SRRecognizer recognizer, const void *speakText, Size speakLength)
 THREEWORDINLINE(0x303C, 0x0620, 0xAA56);

extern pascal OSErr SRSpeakAndDrawText(SRRecognizer recognizer, const void *text, Size textLength)
 THREEWORDINLINE(0x303C, 0x061F, 0xAA56);

extern pascal OSErr SRStopSpeech(SRRecognizer recognizer)
 THREEWORDINLINE(0x303C, 0x0223, 0xAA56);

extern pascal Boolean SRSpeechBusy(SRRecognizer recognizer)
 THREEWORDINLINE(0x303C, 0x0224, 0xAA56);

extern pascal OSErr SRProcessBegin(SRRecognizer recognizer, Boolean failed)
 THREEWORDINLINE(0x303C, 0x031D, 0xAA56);

extern pascal OSErr SRProcessEnd(SRRecognizer recognizer, Boolean failed)
 THREEWORDINLINE(0x303C, 0x031E, 0xAA56);


#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#ifdef __cplusplus
}
#endif

#endif /* __SPEECHRECOGNITION__ */


{
 	File:		SpeechRecognition.p
 
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
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT SpeechRecognition;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SPEECHRECOGNITION__}
{$SETC __SPEECHRECOGNITION__ := 1}

{$I+}
{$SETC SpeechRecognitionIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MEMORY__}
{$I Memory.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	gestaltSpeechRecognitionVersion = 'srtb';
	gestaltSpeechRecognitionAttr = 'srta';
	gestaltDesktopSpeechRecognition = $00000001;
	gestaltTelephoneSpeechRecognition = $00000002;
{  Error Codes [Speech recognition gets -5100 through -5199]  }
	kSRNotAvailable				= -5100;						{  the service requested is not avail or applicable  }
	kSRInternalError			= -5101;						{  a system internal or hardware error condition  }
	kSRComponentNotFound		= -5102;						{  a needed system resource was not located  }
	kSROutOfMemory				= -5103;						{  an out of memory error occurred in the toolbox memory space  }
	kSRNotASpeechObject			= -5104;						{  the object specified is no longer or never was valid  }
	kSRBadParameter				= -5105;						{  an invalid parameter was specified  }
	kSRParamOutOfRange			= -5106;						{  when we say 0-100, don't pass in 101.  }
	kSRBadSelector				= -5107;						{  an unrecognized selector was specified  }
	kSRBufferTooSmall			= -5108;						{  returned from attribute access functions  }
	kSRNotARecSystem			= -5109;						{  the object used was not a SRRecognitionSystem  }
	kSRFeedbackNotAvail			= -5110;						{  there is no feedback window associated with SRRecognizer  }
	kSRCantSetProperty			= -5111;						{  a non-settable property was specified  }
	kSRCantGetProperty			= -5112;						{  a non-gettable property was specified  }
	kSRCantSetDuringRecognition	= -5113;						{  the property can't be set while recognition is in progress -- do before or between utterances.  }
	kSRAlreadyListening			= -5114;						{  in response to SRStartListening  }
	kSRNotListeningState		= -5115;						{  in response to SRStopListening  }
	kSRModelMismatch			= -5116;						{  no acoustical models are avail to match request  }
	kSRNoClientLanguageModel	= -5117;						{  trying to access a non-specified SRLanguageModel  }
	kSRNoPendingUtterances		= -5118;						{  nothing to continue search on  }
	kSRRecognitionCanceled		= -5119;						{  an abort error occurred during search  }
	kSRRecognitionDone			= -5120;						{  search has finished, but nothing was recognized  }
	kSROtherRecAlreadyModal		= -5121;						{  another recognizer is modal at the moment, so can't set this recognizer's kSRBlockModally property right now  }
	kSRHasNoSubItems			= -5122;						{  SRCountItems or related routine was called on an object without subelements -- e.g. a word -- rather than phrase, path, or LM.  }
	kSRSubItemNotFound			= -5123;						{  returned when accessing a non-existent sub item of a container  }
	kSRLanguageModelTooBig		= -5124;						{  Cant build language models so big  }
	kSRAlreadyReleased			= -5125;						{  this object has already been released before  }
	kSRAlreadyFinished			= -5126;						{  the language model can't be finished twice  }
	kSRWordNotFound				= -5127;						{  the spelling couldn't be found in lookup(s)  }
	kSRNotFinishedWithRejection	= -5128;						{  property not found because the LMObj is not finished with rejection  }
	kSRExpansionTooDeep			= -5129;						{  Language model is left recursive or is embedded too many levels  }
	kSRTooManyElements			= -5130;						{  Too many elements added to phrase or path or other langauge model object  }
	kSRCantAdd					= -5131;						{  Can't add given type of object to the base SRLanguageObject (e.g.in SRAddLanguageObject)	 }
	kSRSndInSourceDisconnected	= -5132;						{  Sound input source is disconnected  }
	kSRCantReadLanguageObject	= -5133;						{  An error while trying to create new Language object from file or pointer -- possibly bad format  }
																{  non-release debugging error codes are included here  }
	kSRNotImplementedYet		= -5199;						{  you'd better wait for this feature in a future release  }
{  Type Definitions  }

TYPE
	SRSpeechObject = ^LONGINT;
	SRRecognitionSystem					= SRSpeechObject;
	SRRecognizer						= SRSpeechObject;
	SRSpeechSource						= SRSpeechObject;
	SRRecognitionResult					= SRSpeechSource;
	SRLanguageObject					= SRSpeechObject;
	SRLanguageModel						= SRLanguageObject;
	SRPath								= SRLanguageObject;
	SRPhrase							= SRLanguageObject;
	SRWord								= SRLanguageObject;
{  between 0 and 100  }
	SRSpeedSetting						= INTEGER;
{  between 0 and 100  }
	SRRejectionLevel					= INTEGER;
{  When an event occurs, the user supplied proc will be called with a pointer	 }
{ 	to the param passed in and a flag to indicate conditions such				 }
{ 	as interrupt time or system background time.								 }
	SRCallBackStructPtr = ^SRCallBackStruct;
	SRCallBackStruct = RECORD
		what:					LONGINT;								{  one of notification flags  }
		message:				LONGINT;								{  contains SRRecognitionResult id  }
		instance:				SRRecognizer;							{  ID of recognizer being notified  }
		status:					OSErr;									{  result status of last search  }
		flags:					INTEGER;								{  non-zero if occurs during interrupt  }
		refCon:					LONGINT;								{  user defined - set from SRCallBackParam  }
	END;

{  Call back procedure definition  }
	SRCallBackProcPtr = ProcPtr;  { PROCEDURE SRCallBack(VAR param: SRCallBackStruct); }

	SRCallBackUPP = UniversalProcPtr;

CONST
	uppSRCallBackProcInfo = $000000C0;

FUNCTION NewSRCallBackProc(userRoutine: SRCallBackProcPtr): SRCallBackUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallSRCallBackProc(VAR param: SRCallBackStruct; userRoutine: SRCallBackUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	SRCallBackParamPtr = ^SRCallBackParam;
	SRCallBackParam = RECORD
		callBack:				SRCallBackUPP;
		refCon:					LONGINT;
	END;

{  Recognition System Types  }

CONST
	kSRDefaultRecognitionSystemID = 0;
{  Recognition System Properties  }
	kSRFeedbackAndListeningModes = 'fbwn';						{  short: one of kSRNoFeedbackHasListenModes, kSRHasFeedbackHasListenModes, kSRNoFeedbackNoListenModes  }
	kSRRejectedWord				= 'rejq';						{  the SRWord used to represent a rejection  }
	kSRCleanupOnClientExit		= 'clup';						{  Boolean: Default is true. The rec system and everything it owns is disposed when the client application quits  }
	kSRNoFeedbackNoListenModes	= 0;							{  next allocated recognizer has no feedback window and doesn't use listening modes	 }
	kSRHasFeedbackHasListenModes = 1;							{  next allocated recognizer has feedback window and uses listening modes 			 }
	kSRNoFeedbackHasListenModes	= 2;							{  next allocated recognizer has no feedback window but does use listening modes 	 }
{  Speech Source Types  }
	kSRDefaultSpeechSource		= 0;
	kSRLiveDesktopSpeechSource	= 'dklv';						{  live desktop sound input  }
	kSRCanned22kHzSpeechSource	= 'ca22';						{  AIFF file based 16 bit, 22.050 KHz sound input  }
{  Notification via Apple Event or Callback  }
{  Notification Flags  }
	kSRNotifyRecognitionBeginning = $00000001;					{  recognition can begin. client must now call SRContinueRecognition or SRCancelRecognition  }
	kSRNotifyRecognitionDone	= $00000002;					{  recognition has terminated. result (if any) is available.  }
{  Apple Event selectors  }
{  AppleEvent message class   }
	kAESpeechSuite				= 'sprc';
{  AppleEvent message event ids  }
	kAESpeechDone				= 'srsd';
	kAESpeechDetected			= 'srbd';
{  AppleEvent Parameter ids  }
	keySRRecognizer				= 'krec';
	keySRSpeechResult			= 'kspr';
	keySRSpeechStatus			= 'ksst';
{  AppleEvent Parameter types  }
	typeSRRecognizer			= 'trec';
	typeSRSpeechResult			= 'tspr';
{  SRRecognizer Properties  }
	kSRNotificationParam		= 'noti';						{  see notification flags below  }
	kSRCallBackParam			= 'call';						{  type SRCallBackParam  }
	kSRSearchStatusParam		= 'stat';						{  see status flags below  }
	kSRAutoFinishingParam		= 'afin';						{  automatic finishing applied on LM for search  }
	kSRForegroundOnly			= 'fgon';						{  Boolean. Default is true. If true, client recognizer only active when in foreground.	 }
	kSRBlockBackground			= 'blbg';						{  Boolean. Default is false. If true, when client recognizer in foreground, rest of LMs are inactive.	 }
	kSRBlockModally				= 'blmd';						{  Boolean. Default is false. When true, this client's LM is only active LM; all other LMs are inactive. Be nice, don't be modal for long periods!  }
	kSRWantsResultTextDrawn		= 'txfb';						{  Boolean. Default is true. If true, search results are posted to Feedback window  }
	kSRWantsAutoFBGestures		= 'dfbr';						{  Boolean. Default is true. If true, client needn't call SRProcessBegin/End to get default feedback behavior  }
	kSRSoundInVolume			= 'volu';						{  short in [0..100] log scaled sound input power. Can't set this property  }
	kSRReadAudioFSSpec			= 'aurd';						{  *FSSpec. Specify FSSpec where raw audio is to be read (AIFF format) using kSRCanned22kHzSpeechSource. Reads until EOF  }
	kSRCancelOnSoundOut			= 'caso';						{  Boolean: Default is true.  If any sound is played out during utterance, recognition is aborted.  }
	kSRSpeedVsAccuracyParam		= 'sped';						{  SRSpeedSetting between 0 and 100  }
{  0 means more accurate but slower.  }
{  100 means (much) less accurate but faster.  }
	kSRUseToggleListen			= 0;							{  listen key modes  }
	kSRUsePushToTalk			= 1;
	kSRListenKeyMode			= 'lkmd';						{  short: either kSRUseToggleListen or kSRUsePushToTalk  }
	kSRListenKeyCombo			= 'lkey';						{  short: Push-To-Talk key combination; high byte is high byte of event->modifiers, the low byte is the keycode from event->message  }
	kSRListenKeyName			= 'lnam';						{  Str63: string representing ListenKeyCombo  }
	kSRKeyWord					= 'kwrd';						{  Str255: keyword preceding spoken commands in kSRUseToggleListen mode  }
	kSRKeyExpected				= 'kexp';						{  Boolean: Must the PTT key be depressed or the key word spoken before recognition can occur?  }
{  Operational Status Flags  }
	kSRIdleRecognizer			= $00000001;					{  engine is not active  }
	kSRSearchInProgress			= $00000002;					{  search is in progress  }
	kSRSearchWaitForAllClients	= $00000004;					{  search is suspended waiting on all clients' input  }
	kSRMustCancelSearch			= $00000008;					{  something has occurred (sound played, non-speech detected) requiring the search to abort  }
	kSRPendingSearch			= $00000010;					{  we're about to start searching  }
{  Recognition Result Properties  }
	kSRTEXTFormat				= 'TEXT';						{  raw text in user supplied memory  }
	kSRPhraseFormat				= 'lmph';						{  SRPhrase containing result words  }
	kSRPathFormat				= 'lmpt';						{  SRPath containing result phrases or words  }
	kSRLanguageModelFormat		= 'lmfm';						{  top level SRLanguageModel for post parse  }
{  SRLanguageObject Family Properties  }
	kSRSpelling					= 'spel';						{  spelling of a SRWord or SRPhrase or SRPath, or name of a SRLanguageModel  }
	kSRLMObjType				= 'lmtp';						{  Returns one of SRLanguageObject Types listed below  }
	kSRRefCon					= 'refc';						{  4 bytes of user storage  }
	kSROptional					= 'optl';						{  Boolean -- true if SRLanguageObject is optional	 }
	kSREnabled					= 'enbl';						{  Boolean -- true if SRLanguageObject enabled  }
	kSRRepeatable				= 'rptb';						{  Boolean -- true if SRLanguageObject is repeatable  }
	kSRRejectable				= 'rjbl';						{  Boolean -- true if SRLanguageObject is rejectable (Recognition System's kSRRejectedWord  }
																{ 		object can be returned in place of SRLanguageObject with this property)	 }
	kSRRejectionLevel			= 'rjct';						{  SRRejectionLevel between 0 and 100  }
{  LM Object Types -- returned as kSRLMObjType property of language model objects  }
	kSRLanguageModelType		= 'lmob';						{  SRLanguageModel  }
	kSRPathType					= 'path';						{  SRPath  }
	kSRPhraseType				= 'phra';						{  SRPhrase  }
	kSRWordType					= 'word';						{  SRWord  }
{  a normal and reasonable rejection level  }
	kSRDefaultRejectionLevel	= 50;
{ ****************************************************************************** }
{ 						NOTES ON USING THE API									 }
{ 																				 }
{ 		All operations (with the exception of SRGetRecognitionSystem) are		 }
{ 		directed toward an object allocated or begot from New, Get and Read		 }
{ 		type calls.																 }
{ 																				 }
{ 		There is a simple rule in dealing with allocation and disposal:			 }
{ 																				 }
{ 		*	all toolbox allocations are obtained from a SRRecognitionSystem		 }
{ 																				 }
{ 		*	if you obtain an object via New or Get, then you own a reference 	 }
{ 			to that object and it must be released via SRReleaseObject when		 }
{ 			you no longer need it												 }
{ 																				 }
{ 		*	when you receive a SRRecognitionResult object via AppleEvent or		 }
{ 			callback, it has essentially been created on your behalf and so		 }
{ 			you are responsible for releasing it as above						 }
{ 																				 }
{ 		*	when you close a SRRecognitionSystem, all remaining objects which		 }
{ 			were allocated with it will be forcefully released and any			 }
{ 			remaining references to those objects will be invalid.				 }
{ 																				 }
{ 		This translates into a very simple guideline:							 }
{ 			If you allocate it or have it allocated for you, you must release	 }
{ 			it.  If you are only peeking at it, then don't release it.			 }
{ 																				 }
{ ****************************************************************************** }
{  Opening and Closing of the SRRecognitionSystem  }
FUNCTION SROpenRecognitionSystem(VAR system: SRRecognitionSystem; systemID: OSType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0400, $AA56;
	{$ENDC}
FUNCTION SRCloseRecognitionSystem(system: SRRecognitionSystem): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0201, $AA56;
	{$ENDC}
{  Accessing Properties of any Speech Object  }
FUNCTION SRSetProperty(srObject: SRSpeechObject; selector: OSType; property: UNIV Ptr; propertyLen: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0802, $AA56;
	{$ENDC}
FUNCTION SRGetProperty(srObject: SRSpeechObject; selector: OSType; property: UNIV Ptr; VAR propertyLen: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0803, $AA56;
	{$ENDC}
{  Any object obtained via New or Get type calls must be released  }
FUNCTION SRReleaseObject(srObject: SRSpeechObject): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0204, $AA56;
	{$ENDC}
FUNCTION SRGetReference(srObject: SRSpeechObject; VAR newObjectRef: SRSpeechObject): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0425, $AA56;
	{$ENDC}
{  SRRecognizer Instance Functions  }
FUNCTION SRNewRecognizer(system: SRRecognitionSystem; VAR recognizer: SRRecognizer; sourceID: OSType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $060A, $AA56;
	{$ENDC}
FUNCTION SRStartListening(recognizer: SRRecognizer): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $020C, $AA56;
	{$ENDC}
FUNCTION SRStopListening(recognizer: SRRecognizer): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $020D, $AA56;
	{$ENDC}
FUNCTION SRSetLanguageModel(recognizer: SRRecognizer; languageModel: SRLanguageModel): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $040E, $AA56;
	{$ENDC}
FUNCTION SRGetLanguageModel(recognizer: SRRecognizer; VAR languageModel: SRLanguageModel): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $040F, $AA56;
	{$ENDC}
FUNCTION SRContinueRecognition(recognizer: SRRecognizer): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0210, $AA56;
	{$ENDC}
FUNCTION SRCancelRecognition(recognizer: SRRecognizer): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0211, $AA56;
	{$ENDC}
FUNCTION SRIdle: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0028, $AA56;
	{$ENDC}
{  Language Model Building and Manipulation Functions  }
FUNCTION SRNewLanguageModel(system: SRRecognitionSystem; VAR model: SRLanguageModel; name: UNIV Ptr; nameLength: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0812, $AA56;
	{$ENDC}
FUNCTION SRNewPath(system: SRRecognitionSystem; VAR path: SRPath): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0413, $AA56;
	{$ENDC}
FUNCTION SRNewPhrase(system: SRRecognitionSystem; VAR phrase: SRPhrase; text: UNIV Ptr; textLength: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0814, $AA56;
	{$ENDC}
FUNCTION SRNewWord(system: SRRecognitionSystem; VAR word: SRWord; text: UNIV Ptr; textLength: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0815, $AA56;
	{$ENDC}
{  Operations on any object of the SRLanguageObject family  }
FUNCTION SRPutLanguageObjectIntoHandle(languageObject: SRLanguageObject; lobjHandle: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0416, $AA56;
	{$ENDC}
FUNCTION SRPutLanguageObjectIntoDataFile(languageObject: SRLanguageObject; fRefNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0328, $AA56;
	{$ENDC}
FUNCTION SRNewLanguageObjectFromHandle(system: SRRecognitionSystem; VAR languageObject: SRLanguageObject; lObjHandle: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0417, $AA56;
	{$ENDC}
FUNCTION SRNewLanguageObjectFromDataFile(system: SRRecognitionSystem; VAR languageObject: SRLanguageObject; fRefNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0427, $AA56;
	{$ENDC}
FUNCTION SREmptyLanguageObject(languageObject: SRLanguageObject): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0218, $AA56;
	{$ENDC}
FUNCTION SRChangeLanguageObject(languageObject: SRLanguageObject; text: UNIV Ptr; textLength: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0619, $AA56;
	{$ENDC}
FUNCTION SRAddLanguageObject(base: SRLanguageObject; addon: SRLanguageObject): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $041A, $AA56;
	{$ENDC}
FUNCTION SRAddText(base: SRLanguageObject; text: UNIV Ptr; textLength: Size; refCon: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $081B, $AA56;
	{$ENDC}
FUNCTION SRRemoveLanguageObject(base: SRLanguageObject; toRemove: SRLanguageObject): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $041C, $AA56;
	{$ENDC}
{  Traversing SRRecognitionResults or SRLanguageObjects  }
FUNCTION SRCountItems(container: SRSpeechObject; VAR count: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0405, $AA56;
	{$ENDC}
FUNCTION SRGetIndexedItem(container: SRSpeechObject; VAR item: SRSpeechObject; index: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0606, $AA56;
	{$ENDC}
FUNCTION SRSetIndexedItem(container: SRSpeechObject; item: SRSpeechObject; index: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0607, $AA56;
	{$ENDC}
FUNCTION SRRemoveIndexedItem(container: SRSpeechObject; index: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0408, $AA56;
	{$ENDC}
{  Utilizing the System Feedback Window  }
FUNCTION SRDrawText(recognizer: SRRecognizer; dispText: UNIV Ptr; dispLength: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0621, $AA56;
	{$ENDC}
FUNCTION SRDrawRecognizedText(recognizer: SRRecognizer; dispText: UNIV Ptr; dispLength: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0622, $AA56;
	{$ENDC}
FUNCTION SRSpeakText(recognizer: SRRecognizer; speakText: UNIV Ptr; speakLength: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0620, $AA56;
	{$ENDC}
FUNCTION SRSpeakAndDrawText(recognizer: SRRecognizer; text: UNIV Ptr; textLength: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $061F, $AA56;
	{$ENDC}
FUNCTION SRStopSpeech(recognizer: SRRecognizer): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0223, $AA56;
	{$ENDC}
FUNCTION SRSpeechBusy(recognizer: SRRecognizer): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0224, $AA56;
	{$ENDC}
FUNCTION SRProcessBegin(recognizer: SRRecognizer; failed: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $031D, $AA56;
	{$ENDC}
FUNCTION SRProcessEnd(recognizer: SRRecognizer; failed: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $031E, $AA56;
	{$ENDC}
{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SpeechRecognitionIncludes}

{$ENDC} {__SPEECHRECOGNITION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

{
     File:       SpeechRecognition.p
 
     Contains:   Apple Speech Recognition Toolbox Interfaces.
 
     Version:    Technology: PlainTalk 1.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1992-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ Error Codes [Speech recognition gets -5100 through -5199] }

CONST
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
	kSRCantAdd					= -5131;						{  Can't add given type of object to the base SRLanguageObject (e.g.in SRAddLanguageObject)    }
	kSRSndInSourceDisconnected	= -5132;						{  Sound input source is disconnected  }
	kSRCantReadLanguageObject	= -5133;						{  An error while trying to create new Language object from file or pointer -- possibly bad format  }
																{  non-release debugging error codes are included here  }
	kSRNotImplementedYet		= -5199;						{  you'd better wait for this feature in a future release  }


	{	 Type Definitions 	}

TYPE
	SRSpeechObject    = ^LONGINT; { an opaque 32-bit type }
	SRSpeechObjectPtr = ^SRSpeechObject;  { when a VAR xx:SRSpeechObject parameter can be nil, it is changed to xx: SRSpeechObjectPtr }
	SRRecognitionSystem					= SRSpeechObject;
	SRRecognizer						= SRSpeechObject;
	SRSpeechSource						= SRSpeechObject;
	SRRecognitionResult					= SRSpeechSource;
	SRLanguageObject					= SRSpeechObject;
	SRLanguageModel						= SRLanguageObject;
	SRPath								= SRLanguageObject;
	SRPhrase							= SRLanguageObject;
	SRWord								= SRLanguageObject;
	{	 between 0 and 100 	}
	SRSpeedSetting						= UInt16;
	{	 between 0 and 100 	}
	SRRejectionLevel					= UInt16;
	{	 When an event occurs, the user supplied proc will be called with a pointer   	}
	{	  to the param passed in and a flag to indicate conditions such               	}
	{	  as interrupt time or system background time.                                	}
	SRCallBackStructPtr = ^SRCallBackStruct;
	SRCallBackStruct = RECORD
		what:					LONGINT;								{  one of notification flags  }
		message:				LONGINT;								{  contains SRRecognitionResult id  }
		instance:				SRRecognizer;							{  ID of recognizer being notified  }
		status:					OSErr;									{  result status of last search  }
		flags:					INTEGER;								{  non-zero if occurs during interrupt  }
		refCon:					LONGINT;								{  user defined - set from SRCallBackParam  }
	END;

	{	 Call back procedure definition 	}
{$IFC TYPED_FUNCTION_POINTERS}
	SRCallBackProcPtr = PROCEDURE(VAR param: SRCallBackStruct);
{$ELSEC}
	SRCallBackProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	SRCallBackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SRCallBackUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppSRCallBackProcInfo = $000000C0;
	{
	 *  NewSRCallBackUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0.2 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewSRCallBackUPP(userRoutine: SRCallBackProcPtr): SRCallBackUPP; { old name was NewSRCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeSRCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSRCallBackUPP(userUPP: SRCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeSRCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeSRCallBackUPP(VAR param: SRCallBackStruct; userRoutine: SRCallBackUPP); { old name was CallSRCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


TYPE
	SRCallBackParamPtr = ^SRCallBackParam;
	SRCallBackParam = RECORD
		callBack:				SRCallBackUPP;
		refCon:					LONGINT;
	END;

	{	 Recognition System Types 	}

CONST
	kSRDefaultRecognitionSystemID = 0;

	{	 Recognition System Properties 	}
	kSRFeedbackAndListeningModes = 'fbwn';						{  short: one of kSRNoFeedbackHasListenModes, kSRHasFeedbackHasListenModes, kSRNoFeedbackNoListenModes  }
	kSRRejectedWord				= 'rejq';						{  the SRWord used to represent a rejection  }
	kSRCleanupOnClientExit		= 'clup';						{  Boolean: Default is true. The rec system and everything it owns is disposed when the client application quits  }

	kSRNoFeedbackNoListenModes	= 0;							{  next allocated recognizer has no feedback window and doesn't use listening modes    }
	kSRHasFeedbackHasListenModes = 1;							{  next allocated recognizer has feedback window and uses listening modes           }
	kSRNoFeedbackHasListenModes	= 2;							{  next allocated recognizer has no feedback window but does use listening modes   }

	{	 Speech Source Types 	}
	kSRDefaultSpeechSource		= 0;
	kSRLiveDesktopSpeechSource	= 'dklv';						{  live desktop sound input  }
	kSRCanned22kHzSpeechSource	= 'ca22';						{  AIFF file based 16 bit, 22.050 KHz sound input  }

	{	 Notification via Apple Event or Callback 	}
	{	 Notification Flags 	}
	kSRNotifyRecognitionBeginning = $00000001;					{  recognition can begin. client must now call SRContinueRecognition or SRCancelRecognition  }
	kSRNotifyRecognitionDone	= $00000002;					{  recognition has terminated. result (if any) is available.  }

	{	 Apple Event selectors 	}
	{	 AppleEvent message class  	}
	kAESpeechSuite				= 'sprc';

	{	 AppleEvent message event ids 	}
	kAESpeechDone				= 'srsd';
	kAESpeechDetected			= 'srbd';

	{	 AppleEvent Parameter ids 	}
	keySRRecognizer				= 'krec';
	keySRSpeechResult			= 'kspr';
	keySRSpeechStatus			= 'ksst';

	{	 AppleEvent Parameter types 	}
	typeSRRecognizer			= 'trec';
	typeSRSpeechResult			= 'tspr';


	{	 SRRecognizer Properties 	}
	kSRNotificationParam		= 'noti';						{  see notification flags below  }
	kSRCallBackParam			= 'call';						{  type SRCallBackParam  }
	kSRSearchStatusParam		= 'stat';						{  see status flags below  }
	kSRAutoFinishingParam		= 'afin';						{  automatic finishing applied on LM for search  }
	kSRForegroundOnly			= 'fgon';						{  Boolean. Default is true. If true, client recognizer only active when in foreground.    }
	kSRBlockBackground			= 'blbg';						{  Boolean. Default is false. If true, when client recognizer in foreground, rest of LMs are inactive.     }
	kSRBlockModally				= 'blmd';						{  Boolean. Default is false. When true, this client's LM is only active LM; all other LMs are inactive. Be nice, don't be modal for long periods!  }
	kSRWantsResultTextDrawn		= 'txfb';						{  Boolean. Default is true. If true, search results are posted to Feedback window  }
	kSRWantsAutoFBGestures		= 'dfbr';						{  Boolean. Default is true. If true, client needn't call SRProcessBegin/End to get default feedback behavior  }
	kSRSoundInVolume			= 'volu';						{  short in [0..100] log scaled sound input power. Can't set this property  }
	kSRReadAudioFSSpec			= 'aurd';						{  *FSSpec. Specify FSSpec where raw audio is to be read (AIFF format) using kSRCanned22kHzSpeechSource. Reads until EOF  }
	kSRCancelOnSoundOut			= 'caso';						{  Boolean: Default is true.  If any sound is played out during utterance, recognition is aborted.  }
	kSRSpeedVsAccuracyParam		= 'sped';						{  SRSpeedSetting between 0 and 100  }

	{	 0 means more accurate but slower. 	}
	{	 100 means (much) less accurate but faster. 	}
	kSRUseToggleListen			= 0;							{  listen key modes  }
	kSRUsePushToTalk			= 1;

	kSRListenKeyMode			= 'lkmd';						{  short: either kSRUseToggleListen or kSRUsePushToTalk  }
	kSRListenKeyCombo			= 'lkey';						{  short: Push-To-Talk key combination; high byte is high byte of event->modifiers, the low byte is the keycode from event->message  }
	kSRListenKeyName			= 'lnam';						{  Str63: string representing ListenKeyCombo  }
	kSRKeyWord					= 'kwrd';						{  Str255: keyword preceding spoken commands in kSRUseToggleListen mode  }
	kSRKeyExpected				= 'kexp';						{  Boolean: Must the PTT key be depressed or the key word spoken before recognition can occur?  }

	{	 Operational Status Flags 	}
	kSRIdleRecognizer			= $00000001;					{  engine is not active  }
	kSRSearchInProgress			= $00000002;					{  search is in progress  }
	kSRSearchWaitForAllClients	= $00000004;					{  search is suspended waiting on all clients' input  }
	kSRMustCancelSearch			= $00000008;					{  something has occurred (sound played, non-speech detected) requiring the search to abort  }
	kSRPendingSearch			= $00000010;					{  we're about to start searching  }

	{	 Recognition Result Properties 	}
	kSRTEXTFormat				= 'TEXT';						{  raw text in user supplied memory  }
	kSRPhraseFormat				= 'lmph';						{  SRPhrase containing result words  }
	kSRPathFormat				= 'lmpt';						{  SRPath containing result phrases or words  }
	kSRLanguageModelFormat		= 'lmfm';						{  top level SRLanguageModel for post parse  }

	{	 SRLanguageObject Family Properties 	}
	kSRSpelling					= 'spel';						{  spelling of a SRWord or SRPhrase or SRPath, or name of a SRLanguageModel  }
	kSRLMObjType				= 'lmtp';						{  Returns one of SRLanguageObject Types listed below  }
	kSRRefCon					= 'refc';						{  4 bytes of user storage  }
	kSROptional					= 'optl';						{  Boolean -- true if SRLanguageObject is optional     }
	kSREnabled					= 'enbl';						{  Boolean -- true if SRLanguageObject enabled  }
	kSRRepeatable				= 'rptb';						{  Boolean -- true if SRLanguageObject is repeatable  }
	kSRRejectable				= 'rjbl';						{  Boolean -- true if SRLanguageObject is rejectable (Recognition System's kSRRejectedWord  }
																{        object can be returned in place of SRLanguageObject with this property)    }
	kSRRejectionLevel			= 'rjct';						{  SRRejectionLevel between 0 and 100  }

	{	 LM Object Types -- returned as kSRLMObjType property of language model objects 	}
	kSRLanguageModelType		= 'lmob';						{  SRLanguageModel  }
	kSRPathType					= 'path';						{  SRPath  }
	kSRPhraseType				= 'phra';						{  SRPhrase  }
	kSRWordType					= 'word';						{  SRWord  }

	{	 a normal and reasonable rejection level 	}
	kSRDefaultRejectionLevel	= 50;

	{	******************************************************************************	}
	{	                      NOTES ON USING THE API                                  	}
	{	                                                                              	}
	{	      All operations (with the exception of SRGetRecognitionSystem) are       	}
	{	      directed toward an object allocated or begot from New, Get and Read     	}
	{	      type calls.                                                             	}
	{	                                                                              	}
	{	      There is a simple rule in dealing with allocation and disposal:         	}
	{	                                                                              	}
	{	      *   all toolbox allocations are obtained from a SRRecognitionSystem     	}
	{	                                                                              	}
	{	      *   if you obtain an object via New or Get, then you own a reference    	}
	{	          to that object and it must be released via SRReleaseObject when     	}
	{	          you no longer need it                                               	}
	{	                                                                              	}
	{	      *   when you receive a SRRecognitionResult object via AppleEvent or     	}
	{	          callback, it has essentially been created on your behalf and so     	}
	{	          you are responsible for releasing it as above                       	}
	{	                                                                              	}
	{	      *   when you close a SRRecognitionSystem, all remaining objects which       	}
	{	          were allocated with it will be forcefully released and any          	}
	{	          remaining references to those objects will be invalid.              	}
	{	                                                                              	}
	{	      This translates into a very simple guideline:                           	}
	{	          If you allocate it or have it allocated for you, you must release   	}
	{	          it.  If you are only peeking at it, then don't release it.          	}
	{	                                                                              	}
	{	******************************************************************************	}
	{	 Opening and Closing of the SRRecognitionSystem 	}
	{
	 *  SROpenRecognitionSystem()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION SROpenRecognitionSystem(VAR system: SRRecognitionSystem; systemID: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0400, $AA56;
	{$ENDC}

{
 *  SRCloseRecognitionSystem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRCloseRecognitionSystem(system: SRRecognitionSystem): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0201, $AA56;
	{$ENDC}

{ Accessing Properties of any Speech Object }
{
 *  SRSetProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRSetProperty(srObject: SRSpeechObject; selector: OSType; property: UNIV Ptr; propertyLen: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0802, $AA56;
	{$ENDC}

{
 *  SRGetProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRGetProperty(srObject: SRSpeechObject; selector: OSType; property: UNIV Ptr; VAR propertyLen: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0803, $AA56;
	{$ENDC}

{ Any object obtained via New or Get type calls must be released }
{
 *  SRReleaseObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRReleaseObject(srObject: SRSpeechObject): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0204, $AA56;
	{$ENDC}

{
 *  SRGetReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRGetReference(srObject: SRSpeechObject; VAR newObjectRef: SRSpeechObject): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0425, $AA56;
	{$ENDC}

{ SRRecognizer Instance Functions }
{
 *  SRNewRecognizer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRNewRecognizer(system: SRRecognitionSystem; VAR recognizer: SRRecognizer; sourceID: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $060A, $AA56;
	{$ENDC}

{
 *  SRStartListening()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRStartListening(recognizer: SRRecognizer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020C, $AA56;
	{$ENDC}

{
 *  SRStopListening()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRStopListening(recognizer: SRRecognizer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020D, $AA56;
	{$ENDC}

{
 *  SRSetLanguageModel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRSetLanguageModel(recognizer: SRRecognizer; languageModel: SRLanguageModel): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040E, $AA56;
	{$ENDC}

{
 *  SRGetLanguageModel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRGetLanguageModel(recognizer: SRRecognizer; VAR languageModel: SRLanguageModel): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040F, $AA56;
	{$ENDC}

{
 *  SRContinueRecognition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRContinueRecognition(recognizer: SRRecognizer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0210, $AA56;
	{$ENDC}

{
 *  SRCancelRecognition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRCancelRecognition(recognizer: SRRecognizer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0211, $AA56;
	{$ENDC}

{
 *  SRIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRIdle: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0028, $AA56;
	{$ENDC}

{ Language Model Building and Manipulation Functions }
{
 *  SRNewLanguageModel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRNewLanguageModel(system: SRRecognitionSystem; VAR model: SRLanguageModel; name: UNIV Ptr; nameLength: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0812, $AA56;
	{$ENDC}

{
 *  SRNewPath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRNewPath(system: SRRecognitionSystem; VAR path: SRPath): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0413, $AA56;
	{$ENDC}

{
 *  SRNewPhrase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRNewPhrase(system: SRRecognitionSystem; VAR phrase: SRPhrase; text: UNIV Ptr; textLength: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0814, $AA56;
	{$ENDC}

{
 *  SRNewWord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRNewWord(system: SRRecognitionSystem; VAR word: SRWord; text: UNIV Ptr; textLength: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0815, $AA56;
	{$ENDC}

{ Operations on any object of the SRLanguageObject family }
{
 *  SRPutLanguageObjectIntoHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRPutLanguageObjectIntoHandle(languageObject: SRLanguageObject; lobjHandle: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0416, $AA56;
	{$ENDC}

{
 *  SRPutLanguageObjectIntoDataFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRPutLanguageObjectIntoDataFile(languageObject: SRLanguageObject; fRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0328, $AA56;
	{$ENDC}

{
 *  SRNewLanguageObjectFromHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRNewLanguageObjectFromHandle(system: SRRecognitionSystem; VAR languageObject: SRLanguageObject; lObjHandle: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0417, $AA56;
	{$ENDC}

{
 *  SRNewLanguageObjectFromDataFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRNewLanguageObjectFromDataFile(system: SRRecognitionSystem; VAR languageObject: SRLanguageObject; fRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0427, $AA56;
	{$ENDC}

{
 *  SREmptyLanguageObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SREmptyLanguageObject(languageObject: SRLanguageObject): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0218, $AA56;
	{$ENDC}

{
 *  SRChangeLanguageObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRChangeLanguageObject(languageObject: SRLanguageObject; text: UNIV Ptr; textLength: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0619, $AA56;
	{$ENDC}

{
 *  SRAddLanguageObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRAddLanguageObject(base: SRLanguageObject; addon: SRLanguageObject): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $041A, $AA56;
	{$ENDC}

{
 *  SRAddText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRAddText(base: SRLanguageObject; text: UNIV Ptr; textLength: Size; refCon: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $081B, $AA56;
	{$ENDC}

{
 *  SRRemoveLanguageObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRRemoveLanguageObject(base: SRLanguageObject; toRemove: SRLanguageObject): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $041C, $AA56;
	{$ENDC}

{ Traversing SRRecognitionResults or SRLanguageObjects }
{
 *  SRCountItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRCountItems(container: SRSpeechObject; VAR count: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0405, $AA56;
	{$ENDC}

{
 *  SRGetIndexedItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRGetIndexedItem(container: SRSpeechObject; VAR item: SRSpeechObject; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0606, $AA56;
	{$ENDC}

{
 *  SRSetIndexedItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRSetIndexedItem(container: SRSpeechObject; item: SRSpeechObject; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0607, $AA56;
	{$ENDC}

{
 *  SRRemoveIndexedItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRRemoveIndexedItem(container: SRSpeechObject; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0408, $AA56;
	{$ENDC}

{ Utilizing the System Feedback Window }
{
 *  SRDrawText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRDrawText(recognizer: SRRecognizer; dispText: UNIV Ptr; dispLength: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0621, $AA56;
	{$ENDC}

{
 *  SRDrawRecognizedText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRDrawRecognizedText(recognizer: SRRecognizer; dispText: UNIV Ptr; dispLength: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0622, $AA56;
	{$ENDC}

{
 *  SRSpeakText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRSpeakText(recognizer: SRRecognizer; speakText: UNIV Ptr; speakLength: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0620, $AA56;
	{$ENDC}

{
 *  SRSpeakAndDrawText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRSpeakAndDrawText(recognizer: SRRecognizer; text: UNIV Ptr; textLength: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $061F, $AA56;
	{$ENDC}

{
 *  SRStopSpeech()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRStopSpeech(recognizer: SRRecognizer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0223, $AA56;
	{$ENDC}

{
 *  SRSpeechBusy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRSpeechBusy(recognizer: SRRecognizer): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0224, $AA56;
	{$ENDC}

{
 *  SRProcessBegin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRProcessBegin(recognizer: SRRecognizer; failed: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $031D, $AA56;
	{$ENDC}

{
 *  SRProcessEnd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in SpeechRecognitionLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SRProcessEnd(recognizer: SRRecognizer; failed: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $031E, $AA56;
	{$ENDC}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SpeechRecognitionIncludes}

{$ENDC} {__SPEECHRECOGNITION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

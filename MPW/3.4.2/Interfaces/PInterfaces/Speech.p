{
 	File:		Speech.p
 
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
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Speech;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SPEECH__}
{$SETC __SPEECH__ := 1}

{$I+}
{$SETC SpeechIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MEMORY__}
{$I Memory.p}
{$ENDC}
{	MixedMode.p													}

{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{	OSUtils.p													}
{	Finder.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	kTextToSpeechSynthType		= 'ttsc';
	kTextToSpeechVoiceType		= 'ttvd';
	kTextToSpeechVoiceFileType	= 'ttvf';
	kTextToSpeechVoiceBundleType = 'ttvb';

	kNoEndingProsody			= 1;
	kNoSpeechInterrupt			= 2;
	kPreflightThenPause			= 4;

	kImmediate					= 0;
	kEndOfWord					= 1;
	kEndOfSentence				= 2;

{------------------------------------------}
{ GetSpeechInfo & SetSpeechInfo selectors	}
{------------------------------------------}
	soStatus					= 'stat';
	soErrors					= 'erro';
	soInputMode					= 'inpt';
	soCharacterMode				= 'char';
	soNumberMode				= 'nmbr';
	soRate						= 'rate';
	soPitchBase					= 'pbas';
	soPitchMod					= 'pmod';
	soVolume					= 'volm';
	soSynthType					= 'vers';
	soRecentSync				= 'sync';
	soPhonemeSymbols			= 'phsy';
	soCurrentVoice				= 'cvox';
	soCommandDelimiter			= 'dlim';
	soReset						= 'rset';
	soCurrentA5					= 'myA5';
	soRefCon					= 'refc';
	soTextDoneCallBack			= 'tdcb';
	soSpeechDoneCallBack		= 'sdcb';
	soSyncCallBack				= 'sycb';
	soErrorCallBack				= 'ercb';
	soPhonemeCallBack			= 'phcb';
	soWordCallBack				= 'wdcb';
	soSynthExtension			= 'xtnd';
	soSoundOutput				= 'sndo';

{------------------------------------------}
{ Speaking Mode Constants 					}
{------------------------------------------}
	modeText					= 'TEXT';						{ input mode constants 					}
	modePhonemes				= 'PHON';
	modeNormal					= 'NORM';						{ character mode and number mode constants }
	modeLiteral					= 'LTRL';

	soVoiceDescription			= 'info';
	soVoiceFile					= 'fref';


TYPE
	SpeechChannelRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	SpeechChannel = ^SpeechChannelRecord;

	VoiceSpec = RECORD
		creator:				OSType;
		id:						OSType;
	END;


CONST
	kNeuter						= 0;
	kMale						= 1;
	kFemale						= 2;


TYPE
	VoiceDescription = RECORD
		length:					LONGINT;
		voice:					VoiceSpec;
		version:				LONGINT;
		name:					Str63;
		comment:				Str255;
		gender:					INTEGER;
		age:					INTEGER;
		script:					INTEGER;
		language:				INTEGER;
		region:					INTEGER;
		reserved:				ARRAY [0..3] OF LONGINT;
	END;

	VoiceFileInfo = RECORD
		fileSpec:				FSSpec;
		resID:					INTEGER;
	END;

	SpeechStatusInfo = RECORD
		outputBusy:				BOOLEAN;
		outputPaused:			BOOLEAN;
		inputBytesLeft:			LONGINT;
		phonemeCode:			INTEGER;
	END;

	SpeechErrorInfo = RECORD
		count:					INTEGER;
		oldest:					OSErr;
		oldPos:					LONGINT;
		newest:					OSErr;
		newPos:					LONGINT;
	END;

	SpeechVersionInfo = RECORD
		synthType:				OSType;
		synthSubType:			OSType;
		synthManufacturer:		OSType;
		synthFlags:				LONGINT;
		synthVersion:			NumVersion;
	END;

	PhonemeInfo = RECORD
		opcode:					INTEGER;
		phStr:					Str15;
		exampleStr:				Str31;
		hiliteStart:			INTEGER;
		hiliteEnd:				INTEGER;
	END;

	PhonemeDescriptor = RECORD
		phonemeCount:			INTEGER;
		thePhonemes:			ARRAY [0..0] OF PhonemeInfo;
	END;

	SpeechXtndData = PACKED RECORD
		synthCreator:			OSType;
		synthData:				ARRAY [0..1] OF Byte;
	END;

	DelimiterInfo = PACKED RECORD
		startDelimiter:			ARRAY [0..1] OF Byte;
		endDelimiter:			ARRAY [0..1] OF Byte;
	END;

	SpeechTextDoneProcPtr = ProcPtr;  { PROCEDURE SpeechTextDone(parameter0: SpeechChannel; parameter1: LONGINT; VAR parameter2: Ptr; VAR parameter3: LONGINT; VAR parameter4: LONGINT); }
	SpeechDoneProcPtr = ProcPtr;  { PROCEDURE SpeechDone(parameter0: SpeechChannel; parameter1: LONGINT); }
	SpeechSyncProcPtr = ProcPtr;  { PROCEDURE SpeechSync(parameter0: SpeechChannel; parameter1: LONGINT; parameter2: OSType); }
	SpeechErrorProcPtr = ProcPtr;  { PROCEDURE SpeechError(parameter0: SpeechChannel; parameter1: LONGINT; parameter2: OSErr; parameter3: LONGINT); }
	SpeechPhonemeProcPtr = ProcPtr;  { PROCEDURE SpeechPhoneme(parameter0: SpeechChannel; parameter1: LONGINT; parameter2: INTEGER); }
	SpeechWordProcPtr = ProcPtr;  { PROCEDURE SpeechWord(parameter0: SpeechChannel; parameter1: LONGINT; parameter2: LONGINT; parameter3: INTEGER); }
	SpeechTextDoneUPP = UniversalProcPtr;
	SpeechDoneUPP = UniversalProcPtr;
	SpeechSyncUPP = UniversalProcPtr;
	SpeechErrorUPP = UniversalProcPtr;
	SpeechPhonemeUPP = UniversalProcPtr;
	SpeechWordUPP = UniversalProcPtr;

CONST
	uppSpeechTextDoneProcInfo = $0000FFC0; { PROCEDURE (4 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param); }
	uppSpeechDoneProcInfo = $000003C0; { PROCEDURE (4 byte param, 4 byte param); }
	uppSpeechSyncProcInfo = $00000FC0; { PROCEDURE (4 byte param, 4 byte param, 4 byte param); }
	uppSpeechErrorProcInfo = $00003BC0; { PROCEDURE (4 byte param, 4 byte param, 2 byte param, 4 byte param); }
	uppSpeechPhonemeProcInfo = $00000BC0; { PROCEDURE (4 byte param, 4 byte param, 2 byte param); }
	uppSpeechWordProcInfo = $00002FC0; { PROCEDURE (4 byte param, 4 byte param, 4 byte param, 2 byte param); }

FUNCTION NewSpeechTextDoneProc(userRoutine: SpeechTextDoneProcPtr): SpeechTextDoneUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSpeechDoneProc(userRoutine: SpeechDoneProcPtr): SpeechDoneUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSpeechSyncProc(userRoutine: SpeechSyncProcPtr): SpeechSyncUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSpeechErrorProc(userRoutine: SpeechErrorProcPtr): SpeechErrorUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSpeechPhonemeProc(userRoutine: SpeechPhonemeProcPtr): SpeechPhonemeUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewSpeechWordProc(userRoutine: SpeechWordProcPtr): SpeechWordUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallSpeechTextDoneProc(parameter0: SpeechChannel; parameter1: LONGINT; VAR parameter2: Ptr; VAR parameter3: LONGINT; VAR parameter4: LONGINT; userRoutine: SpeechTextDoneUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSpeechDoneProc(parameter0: SpeechChannel; parameter1: LONGINT; userRoutine: SpeechDoneUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSpeechSyncProc(parameter0: SpeechChannel; parameter1: LONGINT; parameter2: OSType; userRoutine: SpeechSyncUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSpeechErrorProc(parameter0: SpeechChannel; parameter1: LONGINT; parameter2: OSErr; parameter3: LONGINT; userRoutine: SpeechErrorUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSpeechPhonemeProc(parameter0: SpeechChannel; parameter1: LONGINT; parameter2: INTEGER; userRoutine: SpeechPhonemeUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallSpeechWordProc(parameter0: SpeechChannel; parameter1: LONGINT; parameter2: LONGINT; parameter3: INTEGER; userRoutine: SpeechWordUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION SpeechManagerVersion: NumVersion;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0000, $000C, $A800;
	{$ENDC}
FUNCTION MakeVoiceSpec(creator: OSType; id: OSType; VAR voice: VoiceSpec): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0604, $000C, $A800;
	{$ENDC}
FUNCTION CountVoices(VAR numVoices: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0108, $000C, $A800;
	{$ENDC}
FUNCTION GetIndVoice(index: INTEGER; VAR voice: VoiceSpec): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $030C, $000C, $A800;
	{$ENDC}
FUNCTION GetVoiceDescription(VAR voice: VoiceSpec; VAR info: VoiceDescription; infoLength: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0610, $000C, $A800;
	{$ENDC}
FUNCTION GetVoiceInfo(VAR voice: VoiceSpec; selector: OSType; voiceInfo: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0614, $000C, $A800;
	{$ENDC}
FUNCTION NewSpeechChannel(VAR voice: VoiceSpec; VAR chan: SpeechChannel): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0418, $000C, $A800;
	{$ENDC}
FUNCTION DisposeSpeechChannel(chan: SpeechChannel): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $021C, $000C, $A800;
	{$ENDC}
FUNCTION SpeakString(s: StringPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0220, $000C, $A800;
	{$ENDC}
FUNCTION SpeakText(chan: SpeechChannel; textBuf: Ptr; textBytes: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0624, $000C, $A800;
	{$ENDC}
FUNCTION SpeakBuffer(chan: SpeechChannel; textBuf: Ptr; textBytes: LONGINT; controlFlags: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0828, $000C, $A800;
	{$ENDC}
FUNCTION StopSpeech(chan: SpeechChannel): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $022C, $000C, $A800;
	{$ENDC}
FUNCTION StopSpeechAt(chan: SpeechChannel; whereToStop: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0430, $000C, $A800;
	{$ENDC}
FUNCTION PauseSpeechAt(chan: SpeechChannel; whereToPause: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0434, $000C, $A800;
	{$ENDC}
FUNCTION ContinueSpeech(chan: SpeechChannel): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0238, $000C, $A800;
	{$ENDC}
FUNCTION SpeechBusy: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $003C, $000C, $A800;
	{$ENDC}
FUNCTION SpeechBusySystemWide: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0040, $000C, $A800;
	{$ENDC}
FUNCTION SetSpeechRate(chan: SpeechChannel; rate: Fixed): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0444, $000C, $A800;
	{$ENDC}
FUNCTION GetSpeechRate(chan: SpeechChannel; VAR rate: Fixed): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0448, $000C, $A800;
	{$ENDC}
FUNCTION SetSpeechPitch(chan: SpeechChannel; pitch: Fixed): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $044C, $000C, $A800;
	{$ENDC}
FUNCTION GetSpeechPitch(chan: SpeechChannel; VAR pitch: Fixed): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0450, $000C, $A800;
	{$ENDC}
FUNCTION SetSpeechInfo(chan: SpeechChannel; selector: OSType; speechInfo: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0654, $000C, $A800;
	{$ENDC}
FUNCTION GetSpeechInfo(chan: SpeechChannel; selector: OSType; speechInfo: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0658, $000C, $A800;
	{$ENDC}
FUNCTION TextToPhonemes(chan: SpeechChannel; textBuf: Ptr; textBytes: LONGINT; phonemeBuf: Handle; VAR phonemeBytes: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0A5C, $000C, $A800;
	{$ENDC}
FUNCTION UseDictionary(chan: SpeechChannel; dictionary: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0460, $000C, $A800;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SpeechIncludes}

{$ENDC} {__SPEECH__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

{
 	File:		Movies.p
 
 	Contains:	QuickTime Interfaces.
 
 	Version:	Technology:	QuickTime 2.5
 				Release:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Movies;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MOVIES__}
{$SETC __MOVIES__ := 1}

{$I+}
{$SETC MoviesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __ALIASES__}
{$I Aliases.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __IMAGECOMPRESSION__}
{$I ImageCompression.p}
{$ENDC}
{$IFC UNDEFINED __SOUND__}
{$I Sound.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{   "kFix1" is defined in FixMath as "fixed1"   }
{  error codes are in Errors.[haa]  }
{  gestalt codes are in Gestalt.[hpa]  }

CONST
	MovieFileType				= 'MooV';

	MediaHandlerType			= 'mhlr';
	DataHandlerType				= 'dhlr';

	VideoMediaType				= 'vide';
	SoundMediaType				= 'soun';
	TextMediaType				= 'text';
	BaseMediaType				= 'gnrc';
	MPEGMediaType				= 'MPEG';
	MusicMediaType				= 'musi';
	TimeCodeMediaType			= 'tmcd';
	SpriteMediaType				= 'sprt';
	TweenMediaType				= 'twen';
	ThreeDeeMediaType			= 'qd3d';
	HandleDataHandlerSubType	= 'hndl';
	ResourceDataHandlerSubType	= 'rsrc';

	VisualMediaCharacteristic	= 'eyes';
	AudioMediaCharacteristic	= 'ears';
	kCharacteristicCanSendVideo	= 'vsnd';

	DoTheRightThing				= 0;


TYPE
	MovieRecordPtr = ^MovieRecord;
	MovieRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	Movie								= ^MovieRecord;
	TrackRecordPtr = ^TrackRecord;
	TrackRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	Track								= ^TrackRecord;
	MediaRecordPtr = ^MediaRecord;
	MediaRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	Media								= ^MediaRecord;
	UserDataRecordPtr = ^UserDataRecord;
	UserDataRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	UserData							= ^UserDataRecord;
	TrackEditStateRecordPtr = ^TrackEditStateRecord;
	TrackEditStateRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	TrackEditState						= ^TrackEditStateRecord;
	MovieEditStateRecordPtr = ^MovieEditStateRecord;
	MovieEditStateRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	MovieEditState						= ^MovieEditStateRecord;
	SpriteWorldRecordPtr = ^SpriteWorldRecord;
	SpriteWorldRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	SpriteWorld							= ^SpriteWorldRecord;
	SpriteRecordPtr = ^SpriteRecord;
	SpriteRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	Sprite								= ^SpriteRecord;
	SampleDescriptionPtr = ^SampleDescription;
	SampleDescription = RECORD
		descSize:				LONGINT;
		dataFormat:				LONGINT;
		resvd1:					LONGINT;
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
	END;

	SampleDescriptionHandle				= ^SampleDescriptionPtr;
	QTAtomContainer						= Handle;
	QTAtom								= LONGINT;
	QTAtomType							= LONGINT;
	QTAtomID							= LONGINT;
	SoundDescriptionPtr = ^SoundDescription;
	SoundDescription = RECORD
		descSize:				LONGINT;								{  total size of SoundDescription including extra data  }
		dataFormat:				LONGINT;								{    }
		resvd1:					LONGINT;								{  reserved for apple use  }
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
		version:				INTEGER;								{  which version is this data  }
		revlevel:				INTEGER;								{  what version of that codec did this  }
		vendor:					LONGINT;								{  whose  codec compressed this data  }
		numChannels:			INTEGER;								{  number of channels of sound  }
		sampleSize:				INTEGER;								{  number of bits per sample  }
		compressionID:			INTEGER;								{  sound compression used, 0 if none  }
		packetSize:				INTEGER;								{  packet size for compression, 0 if no compression  }
		sampleRate:				Fixed;									{  sample rate sound is captured at  }
	END;

	SoundDescriptionHandle				= ^SoundDescriptionPtr;
	TextDescriptionPtr = ^TextDescription;
	TextDescription = RECORD
		descSize:				LONGINT;								{  Total size of TextDescription }
		dataFormat:				LONGINT;								{  'text' }
		resvd1:					LONGINT;
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
		displayFlags:			LONGINT;								{  see enum below for flag values }
		textJustification:		LONGINT;								{  Can be: teCenter,teFlush -Default,-Right,-Left }
		bgColor:				RGBColor;								{  Background color }
		defaultTextBox:			Rect;									{  Location to place the text within the track bounds }
		defaultStyle:			ScrpSTElement;							{  Default style (struct defined in TextEdit.h) }
		defaultFontName:		SInt8;									{  Font Name (pascal string - struct extended to fit)  }
	END;

	TextDescriptionHandle				= ^TextDescriptionPtr;
	ThreeDeeDescriptionPtr = ^ThreeDeeDescription;
	ThreeDeeDescription = RECORD
		descSize:				LONGINT;								{  total size of ThreeDeeDescription including extra data  }
		dataFormat:				LONGINT;								{    }
		resvd1:					LONGINT;								{  reserved for apple use  }
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
		version:				LONGINT;								{  which version is this data  }
		rendererType:			LONGINT;								{  which renderer to use, 0 for default  }
	END;

	ThreeDeeDescriptionHandle			= ^ThreeDeeDescriptionPtr;
	DataReferenceRecordPtr = ^DataReferenceRecord;
	DataReferenceRecord = RECORD
		dataRefType:			OSType;
		dataRef:				Handle;
	END;

	DataReferencePtr					= ^DataReferenceRecord;
{
--------------------------
  Music Sample Description
--------------------------
}
	MusicDescriptionPtr = ^MusicDescription;
	MusicDescription = RECORD
		descSize:				LONGINT;
		dataFormat:				LONGINT;								{  'musi'  }
		resvd1:					LONGINT;
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
		musicFlags:				LONGINT;
		headerData:				ARRAY [0..0] OF LONGINT;				{  variable size!  }
	END;

	MusicDescriptionHandle				= ^MusicDescriptionPtr;

CONST
	kMusicFlagDontPlay2Soft		= $00000001;

	dfDontDisplay				= $01;							{  Don't display the text }
	dfDontAutoScale				= $02;							{  Don't scale text as track bounds grows or shrinks }
	dfClipToTextBox				= $04;							{  Clip update to the textbox }
	dfUseMovieBGColor			= $08;							{  Set text background to movie's background color }
	dfShrinkTextBoxToFit		= $10;							{  Compute minimum box to fit the sample }
	dfScrollIn					= $20;							{  Scroll text in until last of text is in view  }
	dfScrollOut					= $40;							{  Scroll text out until last of text is gone (if both set, scroll in then out) }
	dfHorizScroll				= $80;							{  Scroll text horizontally (otherwise it's vertical) }
	dfReverseScroll				= $0100;						{  vert: scroll down rather than up; horiz: scroll backwards (justfication dependent) }
	dfContinuousScroll			= $0200;						{  new samples cause previous samples to scroll out  }
	dfFlowHoriz					= $0400;						{  horiz scroll text flows in textbox rather than extend to right  }
	dfContinuousKaraoke			= $0800;						{  ignore begin offset, hilite everything up to the end offset(karaoke) }
	dfDropShadow				= $1000;						{  display text with a drop shadow  }
	dfAntiAlias					= $2000;						{  attempt to display text anti aliased }
	dfKeyedText					= $4000;						{  key the text over background }
	dfInverseHilite				= $8000;						{  Use inverse hiliting rather than using hilite color }
	dfTextColorHilite			= $00010000;					{  changes text color in place of hiliting.  }

	searchTextDontGoToFoundTime	= $00010000;
	searchTextDontHiliteFoundText = $00020000;
	searchTextOneTrackOnly		= $00040000;
	searchTextEnabledTracksOnly	= $00080000;

	k3DMediaRendererEntry		= 'rend';
	k3DMediaRendererName		= 'name';
	k3DMediaRendererCode		= 'rcod';

{  progress messages  }
	movieProgressOpen			= 0;
	movieProgressUpdatePercent	= 1;
	movieProgressClose			= 2;

{  progress operations  }
	progressOpFlatten			= 1;
	progressOpInsertTrackSegment = 2;
	progressOpInsertMovieSegment = 3;
	progressOpPaste				= 4;
	progressOpAddMovieSelection	= 5;
	progressOpCopy				= 6;
	progressOpCut				= 7;
	progressOpLoadMovieIntoRam	= 8;
	progressOpLoadTrackIntoRam	= 9;
	progressOpLoadMediaIntoRam	= 10;
	progressOpImportMovie		= 11;
	progressOpExportMovie		= 12;

	mediaQualityDraft			= $0000;
	mediaQualityNormal			= $0040;
	mediaQualityBetter			= $0080;
	mediaQualityBest			= $00C0;


TYPE
	MovieRgnCoverProcPtr = ProcPtr;  { FUNCTION MovieRgnCover(theMovie: Movie; changedRgn: RgnHandle; refcon: LONGINT): OSErr; }

	MovieProgressProcPtr = ProcPtr;  { FUNCTION MovieProgress(theMovie: Movie; message: INTEGER; whatOperation: INTEGER; percentDone: Fixed; refcon: LONGINT): OSErr; }

	MovieDrawingCompleteProcPtr = ProcPtr;  { FUNCTION MovieDrawingComplete(theMovie: Movie; refCon: LONGINT): OSErr; }

	TrackTransferProcPtr = ProcPtr;  { FUNCTION TrackTransfer(t: Track; refCon: LONGINT): OSErr; }

	GetMovieProcPtr = ProcPtr;  { FUNCTION GetMovie(offset: LONGINT; size: LONGINT; dataPtr: UNIV Ptr; refCon: UNIV Ptr): OSErr; }

	MoviePreviewCallOutProcPtr = ProcPtr;  { FUNCTION MoviePreviewCallOut(refcon: LONGINT): BOOLEAN; }

	TextMediaProcPtr = ProcPtr;  { FUNCTION TextMedia(theText: Handle; theMovie: Movie; VAR displayFlag: INTEGER; refcon: LONGINT): OSErr; }

	MoviesErrorProcPtr = ProcPtr;  { PROCEDURE MoviesError(theErr: OSErr; refcon: LONGINT); }

	MoviesErrorUPP = UniversalProcPtr;

CONST
	uppMoviesErrorProcInfo = $00000380;

FUNCTION NewMoviesErrorProc(userRoutine: MoviesErrorProcPtr): MoviesErrorUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallMoviesErrorProc(theErr: OSErr; refcon: LONGINT; userRoutine: MoviesErrorUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	MovieRgnCoverUPP = UniversalProcPtr;
	MovieProgressUPP = UniversalProcPtr;
	MovieDrawingCompleteUPP = UniversalProcPtr;
	TrackTransferUPP = UniversalProcPtr;
	GetMovieUPP = UniversalProcPtr;
	MoviePreviewCallOutUPP = UniversalProcPtr;
	TextMediaUPP = UniversalProcPtr;
	MediaHandler						= ComponentInstance;
	DataHandler							= ComponentInstance;
	MediaHandlerComponent				= Component;
	DataHandlerComponent				= Component;
	HandlerError						= ComponentResult;
{  TimeBase equates  }
	TimeValue							= LONGINT;
	TimeScale							= LONGINT;
	CompTimeValue						= wide;
	CompTimeValuePtr 					= ^CompTimeValue;

CONST
	loopTimeBase				= 1;
	palindromeLoopTimeBase		= 2;
	maintainTimeBaseZero		= 4;


TYPE
	TimeBaseFlags						= LONGINT;
	TimeBaseRecordPtr = ^TimeBaseRecord;
	TimeBaseRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	TimeBase							= ^TimeBaseRecord;
	CallBackRecordPtr = ^CallBackRecord;
	CallBackRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	QTCallBack							= ^CallBackRecord;
	TimeRecordPtr = ^TimeRecord;
	TimeRecord = RECORD
		value:					CompTimeValue;							{  units  }
		scale:					TimeScale;								{  units per second  }
		base:					TimeBase;
	END;

{  CallBack equates  }

CONST
	triggerTimeFwd				= $0001;						{  when curTime exceeds triggerTime going forward  }
	triggerTimeBwd				= $0002;						{  when curTime exceeds triggerTime going backwards  }
	triggerTimeEither			= $0003;						{  when curTime exceeds triggerTime going either direction  }
	triggerRateLT				= $0004;						{  when rate changes to less than trigger value  }
	triggerRateGT				= $0008;						{  when rate changes to greater than trigger value  }
	triggerRateEqual			= $0010;						{  when rate changes to equal trigger value  }
	triggerRateLTE				= $0014;
	triggerRateGTE				= $0018;
	triggerRateNotEqual			= $001C;
	triggerRateChange			= 0;
	triggerAtStart				= $0001;
	triggerAtStop				= $0002;


TYPE
	QTCallBackFlags						= INTEGER;

CONST
	timeBaseBeforeStartTime		= 1;
	timeBaseAfterStopTime		= 2;


TYPE
	TimeBaseStatus						= LONGINT;

CONST
	callBackAtTime				= 1;
	callBackAtRate				= 2;
	callBackAtTimeJump			= 3;
	callBackAtExtremes			= 4;
	callBackAtInterrupt			= $8000;
	callBackAtDeferredTask		= $4000;


TYPE
	QTCallBackType						= INTEGER;
	QTCallBackProcPtr = ProcPtr;  { PROCEDURE QTCallBack(cb: QTCallBack; refCon: LONGINT); }

	QTCallBackUPP = UniversalProcPtr;

CONST
	qtcbNeedsRateChanges		= 1;							{  wants to know about rate changes  }
	qtcbNeedsTimeChanges		= 2;							{  wants to know about time changes  }
	qtcbNeedsStartStopChanges	= 4;							{  wants to know when TimeBase start/stop is changed }


TYPE
	QTCallBackHeaderPtr = ^QTCallBackHeader;
	QTCallBackHeader = RECORD
		callBackFlags:			LONGINT;
		reserved1:				LONGINT;
		qtPrivate:				ARRAY [0..39] OF SInt8;
	END;

	QTSyncTaskProcPtr = ProcPtr;  { PROCEDURE QTSyncTask(task: UNIV Ptr); }

	QTSyncTaskUPP = UniversalProcPtr;
	QTSyncTaskRecordPtr = ^QTSyncTaskRecord;
	QTSyncTaskRecord = RECORD
		qLink:					Ptr;
		proc:					QTSyncTaskUPP;
	END;

	QTSyncTaskPtr						= ^QTSyncTaskRecord;

CONST
	keepInRam					= $01;							{  load and make non-purgable }
	unkeepInRam					= $02;							{  mark as purgable }
	flushFromRam				= $04;							{  empty those handles }
	loadForwardTrackEdits		= $08;							{ 	load track edits into ram for playing forward }
	loadBackwardTrackEdits		= $10;							{ 	load track edits into ram for playing in reverse }

	newMovieActive				= $01;
	newMovieDontResolveDataRefs	= $02;
	newMovieDontAskUnresolvedDataRefs = $04;
	newMovieDontAutoAlternates	= $08;
	newMovieDontUpdateForeBackPointers = $10;

{  track usage bits  }
	trackUsageInMovie			= $02;
	trackUsageInPreview			= $04;
	trackUsageInPoster			= $08;

{  Add/GetMediaSample flags  }
	mediaSampleNotSync			= $01;							{  sample is not a sync sample (eg. is frame differenced  }
	mediaSampleShadowSync		= $02;							{  sample is a shadow sync  }

	pasteInParallel				= $01;
	showUserSettingsDialog		= $02;
	movieToFileOnlyExport		= $04;
	movieFileSpecValid			= $08;

	nextTimeMediaSample			= $01;
	nextTimeMediaEdit			= $02;
	nextTimeTrackEdit			= $04;
	nextTimeSyncSample			= $08;
	nextTimeStep				= $10;
	nextTimeEdgeOK				= $4000;
	nextTimeIgnoreActiveSegment	= $8000;


TYPE
	nextTimeFlagsEnum					= INTEGER;

CONST
	createMovieFileDeleteCurFile = $80000000;
	createMovieFileDontCreateMovie = $40000000;
	createMovieFileDontOpenFile	= $20000000;


TYPE
	createMovieFileFlagsEnum			= LONGINT;

CONST
	flattenAddMovieToDataFork	= $00000001;
	flattenActiveTracksOnly		= $00000004;
	flattenDontInterleaveFlatten = $00000008;
	flattenFSSpecPtrIsDataRefRecordPtr = $00000010;


TYPE
	movieFlattenFlagsEnum				= LONGINT;

CONST
	movieInDataForkResID		= -1;							{  magic res ID  }

	mcTopLeftMovie				= $01;							{  usually centered  }
	mcScaleMovieToFit			= $02;							{  usually only scales down  }
	mcWithBadge					= $04;							{  give me a badge  }
	mcNotVisible				= $08;							{  don't show controller  }
	mcWithFrame					= $10;							{  gimme a frame  }

	movieScrapDontZeroScrap		= $01;
	movieScrapOnlyPutMovie		= $02;

	dataRefSelfReference		= $01;
	dataRefWasNotResolved		= $02;


TYPE
	dataRefAttributesFlags				= LONGINT;

CONST
	hintsScrubMode				= $01;							{  mask == && (if flags == scrub on, flags != scrub off)  }
	hintsLoop					= $02;
	hintsDontPurge				= $04;
	hintsUseScreenBuffer		= $20;
	hintsAllowInterlace			= $40;
	hintsUseSoundInterp			= $80;
	hintsHighQuality			= $0100;						{  slooooow  }
	hintsPalindrome				= $0200;
	hintsInactive				= $0800;


TYPE
	playHintsEnum						= LONGINT;

CONST
	mediaHandlerFlagBaseClient	= 1;


TYPE
	mediaHandlerFlagsEnum				= LONGINT;

CONST
	movieTrackMediaType			= $01;
	movieTrackCharacteristic	= $02;
	movieTrackEnabledOnly		= $04;


TYPE
	SampleReferenceRecordPtr = ^SampleReferenceRecord;
	SampleReferenceRecord = RECORD
		dataOffset:				LONGINT;
		dataSize:				LONGINT;
		durationPerSample:		TimeValue;
		numberOfSamples:		LONGINT;
		sampleFlags:			INTEGER;
	END;

	SampleReferencePtr					= ^SampleReferenceRecord;
{
************************
* Initialization Routines 
*************************
}
FUNCTION EnterMovies: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $AAAA;
	{$ENDC}
PROCEDURE ExitMovies;
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $AAAA;
	{$ENDC}
{
************************
* Error Routines 
*************************
}
FUNCTION GetMoviesError: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7003, $AAAA;
	{$ENDC}
PROCEDURE ClearMoviesStickyError;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00DE, $AAAA;
	{$ENDC}
FUNCTION GetMoviesStickyError: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7004, $AAAA;
	{$ENDC}
PROCEDURE SetMoviesErrorProc(errProc: MoviesErrorUPP; refcon: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00EF, $AAAA;
	{$ENDC}
{
************************
* Idle Routines 
*************************
}
PROCEDURE MoviesTask(theMovie: Movie; maxMilliSecToUse: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $7005, $AAAA;
	{$ENDC}
FUNCTION PrerollMovie(theMovie: Movie; time: TimeValue; Rate: Fixed): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7006, $AAAA;
	{$ENDC}
FUNCTION LoadMovieIntoRam(theMovie: Movie; time: TimeValue; duration: TimeValue; flags: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7007, $AAAA;
	{$ENDC}
FUNCTION LoadTrackIntoRam(theTrack: Track; time: TimeValue; duration: TimeValue; flags: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $016E, $AAAA;
	{$ENDC}
FUNCTION LoadMediaIntoRam(theMedia: Media; time: TimeValue; duration: TimeValue; flags: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7008, $AAAA;
	{$ENDC}
PROCEDURE SetMovieActive(theMovie: Movie; active: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $7009, $AAAA;
	{$ENDC}
FUNCTION GetMovieActive(theMovie: Movie): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $700A, $AAAA;
	{$ENDC}
{
************************
* calls for playing movies, previews, posters
*************************
}
PROCEDURE StartMovie(theMovie: Movie);
	{$IFC NOT GENERATINGCFM}
	INLINE $700B, $AAAA;
	{$ENDC}
PROCEDURE StopMovie(theMovie: Movie);
	{$IFC NOT GENERATINGCFM}
	INLINE $700C, $AAAA;
	{$ENDC}
PROCEDURE GoToBeginningOfMovie(theMovie: Movie);
	{$IFC NOT GENERATINGCFM}
	INLINE $700D, $AAAA;
	{$ENDC}
PROCEDURE GoToEndOfMovie(theMovie: Movie);
	{$IFC NOT GENERATINGCFM}
	INLINE $700E, $AAAA;
	{$ENDC}
FUNCTION IsMovieDone(theMovie: Movie): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00DD, $AAAA;
	{$ENDC}
FUNCTION GetMoviePreviewMode(theMovie: Movie): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $700F, $AAAA;
	{$ENDC}
PROCEDURE SetMoviePreviewMode(theMovie: Movie; usePreview: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $7010, $AAAA;
	{$ENDC}
PROCEDURE ShowMoviePoster(theMovie: Movie);
	{$IFC NOT GENERATINGCFM}
	INLINE $7011, $AAAA;
	{$ENDC}
PROCEDURE PlayMoviePreview(theMovie: Movie; callOutProc: MoviePreviewCallOutUPP; refcon: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00F2, $AAAA;
	{$ENDC}
{
************************
* calls for controlling movies & tracks which are playing
*************************
}
FUNCTION GetMovieTimeBase(theMovie: Movie): TimeBase;
	{$IFC NOT GENERATINGCFM}
	INLINE $7012, $AAAA;
	{$ENDC}
PROCEDURE SetMovieMasterTimeBase(theMovie: Movie; tb: TimeBase; {CONST}VAR slaveZero: TimeRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0167, $AAAA;
	{$ENDC}
PROCEDURE SetMovieMasterClock(theMovie: Movie; clockMeister: Component; {CONST}VAR slaveZero: TimeRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0168, $AAAA;
	{$ENDC}
PROCEDURE GetMovieGWorld(theMovie: Movie; VAR port: CGrafPtr; VAR gdh: GDHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $7015, $AAAA;
	{$ENDC}
PROCEDURE SetMovieGWorld(theMovie: Movie; port: CGrafPtr; gdh: GDHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $7016, $AAAA;
	{$ENDC}

CONST
	movieDrawingCallWhenChanged	= 0;
	movieDrawingCallAlways		= 1;

PROCEDURE SetMovieDrawingCompleteProc(theMovie: Movie; flags: LONGINT; proc: MovieDrawingCompleteUPP; refCon: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01DE, $AAAA;
	{$ENDC}
PROCEDURE GetMovieNaturalBoundsRect(theMovie: Movie; VAR naturalBounds: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $022C, $AAAA;
	{$ENDC}
FUNCTION GetNextTrackForCompositing(theMovie: Movie; theTrack: Track): Track;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01FA, $AAAA;
	{$ENDC}
FUNCTION GetPrevTrackForCompositing(theMovie: Movie; theTrack: Track): Track;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01FB, $AAAA;
	{$ENDC}
FUNCTION SetMovieCompositeBufferFlags(theMovie: Movie; flags: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $027E, $AAAA;
	{$ENDC}
FUNCTION GetMovieCompositeBufferFlags(theMovie: Movie; VAR flags: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $027F, $AAAA;
	{$ENDC}
PROCEDURE SetTrackGWorld(theTrack: Track; port: CGrafPtr; gdh: GDHandle; proc: TrackTransferUPP; refCon: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $009D, $AAAA;
	{$ENDC}
FUNCTION GetMoviePict(theMovie: Movie; time: TimeValue): PicHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $701D, $AAAA;
	{$ENDC}
FUNCTION GetTrackPict(theTrack: Track; time: TimeValue): PicHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $701E, $AAAA;
	{$ENDC}
FUNCTION GetMoviePosterPict(theMovie: Movie): PicHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00F7, $AAAA;
	{$ENDC}
{  called between Begin & EndUpdate  }
FUNCTION UpdateMovie(theMovie: Movie): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701F, $AAAA;
	{$ENDC}
FUNCTION InvalidateMovieRegion(theMovie: Movie; invalidRgn: RgnHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $022A, $AAAA;
	{$ENDC}
{ *** spatial movie routines *** }
PROCEDURE GetMovieBox(theMovie: Movie; VAR boxRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00F9, $AAAA;
	{$ENDC}
PROCEDURE SetMovieBox(theMovie: Movie; {CONST}VAR boxRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00FA, $AAAA;
	{$ENDC}
{ * movie display clip  }
FUNCTION GetMovieDisplayClipRgn(theMovie: Movie): RgnHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00FC, $AAAA;
	{$ENDC}
PROCEDURE SetMovieDisplayClipRgn(theMovie: Movie; theClip: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00FD, $AAAA;
	{$ENDC}
{ * movie src clip  }
FUNCTION GetMovieClipRgn(theMovie: Movie): RgnHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0100, $AAAA;
	{$ENDC}
PROCEDURE SetMovieClipRgn(theMovie: Movie; theClip: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0101, $AAAA;
	{$ENDC}
{ * track src clip  }
FUNCTION GetTrackClipRgn(theTrack: Track): RgnHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0102, $AAAA;
	{$ENDC}
PROCEDURE SetTrackClipRgn(theTrack: Track; theClip: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0103, $AAAA;
	{$ENDC}
{ * bounds in display space (not clipped by display clip)  }
FUNCTION GetMovieDisplayBoundsRgn(theMovie: Movie): RgnHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00FB, $AAAA;
	{$ENDC}
FUNCTION GetTrackDisplayBoundsRgn(theTrack: Track): RgnHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0112, $AAAA;
	{$ENDC}
{ * bounds in movie space  }
FUNCTION GetMovieBoundsRgn(theMovie: Movie): RgnHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00FE, $AAAA;
	{$ENDC}
FUNCTION GetTrackMovieBoundsRgn(theTrack: Track): RgnHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00FF, $AAAA;
	{$ENDC}
{ * bounds in track space  }
FUNCTION GetTrackBoundsRgn(theTrack: Track): RgnHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0111, $AAAA;
	{$ENDC}
{ * mattes - always in track space  }
FUNCTION GetTrackMatte(theTrack: Track): PixMapHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0115, $AAAA;
	{$ENDC}
PROCEDURE SetTrackMatte(theTrack: Track; theMatte: PixMapHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0116, $AAAA;
	{$ENDC}
PROCEDURE DisposeMatte(theMatte: PixMapHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $014A, $AAAA;
	{$ENDC}
{
************************
* calls for getting/saving movies
*************************
}
FUNCTION NewMovie(flags: LONGINT): Movie;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0187, $AAAA;
	{$ENDC}
FUNCTION PutMovieIntoHandle(theMovie: Movie; publicMovie: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7022, $AAAA;
	{$ENDC}
FUNCTION PutMovieIntoDataFork(theMovie: Movie; fRefNum: INTEGER; offset: LONGINT; maxSize: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01B4, $AAAA;
	{$ENDC}
PROCEDURE DisposeMovie(theMovie: Movie);
	{$IFC NOT GENERATINGCFM}
	INLINE $7023, $AAAA;
	{$ENDC}
{
************************
* Movie State Routines
*************************
}
FUNCTION GetMovieCreationTime(theMovie: Movie): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7026, $AAAA;
	{$ENDC}
FUNCTION GetMovieModificationTime(theMovie: Movie): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7027, $AAAA;
	{$ENDC}
FUNCTION GetMovieTimeScale(theMovie: Movie): TimeScale;
	{$IFC NOT GENERATINGCFM}
	INLINE $7029, $AAAA;
	{$ENDC}
PROCEDURE SetMovieTimeScale(theMovie: Movie; timeScale: TimeScale);
	{$IFC NOT GENERATINGCFM}
	INLINE $702A, $AAAA;
	{$ENDC}
FUNCTION GetMovieDuration(theMovie: Movie): TimeValue;
	{$IFC NOT GENERATINGCFM}
	INLINE $702B, $AAAA;
	{$ENDC}
FUNCTION GetMovieRate(theMovie: Movie): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $702C, $AAAA;
	{$ENDC}
PROCEDURE SetMovieRate(theMovie: Movie; rate: Fixed);
	{$IFC NOT GENERATINGCFM}
	INLINE $702D, $AAAA;
	{$ENDC}
FUNCTION GetMoviePreferredRate(theMovie: Movie): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00F3, $AAAA;
	{$ENDC}
PROCEDURE SetMoviePreferredRate(theMovie: Movie; rate: Fixed);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00F4, $AAAA;
	{$ENDC}
FUNCTION GetMoviePreferredVolume(theMovie: Movie): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00F5, $AAAA;
	{$ENDC}
PROCEDURE SetMoviePreferredVolume(theMovie: Movie; volume: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00F6, $AAAA;
	{$ENDC}
FUNCTION GetMovieVolume(theMovie: Movie): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $702E, $AAAA;
	{$ENDC}
PROCEDURE SetMovieVolume(theMovie: Movie; volume: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $702F, $AAAA;
	{$ENDC}
PROCEDURE GetMovieMatrix(theMovie: Movie; VAR matrix: MatrixRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $7031, $AAAA;
	{$ENDC}
PROCEDURE SetMovieMatrix(theMovie: Movie; {CONST}VAR matrix: MatrixRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $7032, $AAAA;
	{$ENDC}
PROCEDURE GetMoviePreviewTime(theMovie: Movie; VAR previewTime: TimeValue; VAR previewDuration: TimeValue);
	{$IFC NOT GENERATINGCFM}
	INLINE $7033, $AAAA;
	{$ENDC}
PROCEDURE SetMoviePreviewTime(theMovie: Movie; previewTime: TimeValue; previewDuration: TimeValue);
	{$IFC NOT GENERATINGCFM}
	INLINE $7034, $AAAA;
	{$ENDC}
FUNCTION GetMoviePosterTime(theMovie: Movie): TimeValue;
	{$IFC NOT GENERATINGCFM}
	INLINE $7035, $AAAA;
	{$ENDC}
PROCEDURE SetMoviePosterTime(theMovie: Movie; posterTime: TimeValue);
	{$IFC NOT GENERATINGCFM}
	INLINE $7036, $AAAA;
	{$ENDC}
PROCEDURE GetMovieSelection(theMovie: Movie; VAR selectionTime: TimeValue; VAR selectionDuration: TimeValue);
	{$IFC NOT GENERATINGCFM}
	INLINE $7037, $AAAA;
	{$ENDC}
PROCEDURE SetMovieSelection(theMovie: Movie; selectionTime: TimeValue; selectionDuration: TimeValue);
	{$IFC NOT GENERATINGCFM}
	INLINE $7038, $AAAA;
	{$ENDC}
PROCEDURE SetMovieActiveSegment(theMovie: Movie; startTime: TimeValue; duration: TimeValue);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $015C, $AAAA;
	{$ENDC}
PROCEDURE GetMovieActiveSegment(theMovie: Movie; VAR startTime: TimeValue; VAR duration: TimeValue);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $015D, $AAAA;
	{$ENDC}
FUNCTION GetMovieTime(theMovie: Movie; VAR currentTime: TimeRecord): TimeValue;
	{$IFC NOT GENERATINGCFM}
	INLINE $7039, $AAAA;
	{$ENDC}
PROCEDURE SetMovieTime(theMovie: Movie; {CONST}VAR newtime: TimeRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $703C, $AAAA;
	{$ENDC}
PROCEDURE SetMovieTimeValue(theMovie: Movie; newtime: TimeValue);
	{$IFC NOT GENERATINGCFM}
	INLINE $703D, $AAAA;
	{$ENDC}
FUNCTION GetMovieUserData(theMovie: Movie): UserData;
	{$IFC NOT GENERATINGCFM}
	INLINE $703E, $AAAA;
	{$ENDC}
{
************************
* Track/Media finding routines
*************************
}
FUNCTION GetMovieTrackCount(theMovie: Movie): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $703F, $AAAA;
	{$ENDC}
FUNCTION GetMovieTrack(theMovie: Movie; trackID: LONGINT): Track;
	{$IFC NOT GENERATINGCFM}
	INLINE $7040, $AAAA;
	{$ENDC}
FUNCTION GetMovieIndTrack(theMovie: Movie; index: LONGINT): Track;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0117, $AAAA;
	{$ENDC}
FUNCTION GetMovieIndTrackType(theMovie: Movie; index: LONGINT; trackType: OSType; flags: LONGINT): Track;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0208, $AAAA;
	{$ENDC}
FUNCTION GetTrackID(theTrack: Track): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0127, $AAAA;
	{$ENDC}
FUNCTION GetTrackMovie(theTrack: Track): Movie;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00D0, $AAAA;
	{$ENDC}
{
************************
* Track creation routines
*************************
}
FUNCTION NewMovieTrack(theMovie: Movie; width: Fixed; height: Fixed; trackVolume: INTEGER): Track;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0188, $AAAA;
	{$ENDC}
PROCEDURE DisposeMovieTrack(theTrack: Track);
	{$IFC NOT GENERATINGCFM}
	INLINE $7042, $AAAA;
	{$ENDC}
{
************************
* Track State routines
*************************
}
FUNCTION GetTrackCreationTime(theTrack: Track): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7043, $AAAA;
	{$ENDC}
FUNCTION GetTrackModificationTime(theTrack: Track): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7044, $AAAA;
	{$ENDC}
FUNCTION GetTrackEnabled(theTrack: Track): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7045, $AAAA;
	{$ENDC}
PROCEDURE SetTrackEnabled(theTrack: Track; isEnabled: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $7046, $AAAA;
	{$ENDC}
FUNCTION GetTrackUsage(theTrack: Track): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7047, $AAAA;
	{$ENDC}
PROCEDURE SetTrackUsage(theTrack: Track; usage: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $7048, $AAAA;
	{$ENDC}
FUNCTION GetTrackDuration(theTrack: Track): TimeValue;
	{$IFC NOT GENERATINGCFM}
	INLINE $704B, $AAAA;
	{$ENDC}
FUNCTION GetTrackOffset(theTrack: Track): TimeValue;
	{$IFC NOT GENERATINGCFM}
	INLINE $704C, $AAAA;
	{$ENDC}
PROCEDURE SetTrackOffset(theTrack: Track; movieOffsetTime: TimeValue);
	{$IFC NOT GENERATINGCFM}
	INLINE $704D, $AAAA;
	{$ENDC}
FUNCTION GetTrackLayer(theTrack: Track): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $7050, $AAAA;
	{$ENDC}
PROCEDURE SetTrackLayer(theTrack: Track; layer: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $7051, $AAAA;
	{$ENDC}
FUNCTION GetTrackAlternate(theTrack: Track): Track;
	{$IFC NOT GENERATINGCFM}
	INLINE $7052, $AAAA;
	{$ENDC}
PROCEDURE SetTrackAlternate(theTrack: Track; alternateT: Track);
	{$IFC NOT GENERATINGCFM}
	INLINE $7053, $AAAA;
	{$ENDC}
PROCEDURE SetAutoTrackAlternatesEnabled(theMovie: Movie; enable: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $015E, $AAAA;
	{$ENDC}
PROCEDURE SelectMovieAlternates(theMovie: Movie);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $015F, $AAAA;
	{$ENDC}
FUNCTION GetTrackVolume(theTrack: Track): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $7054, $AAAA;
	{$ENDC}
PROCEDURE SetTrackVolume(theTrack: Track; volume: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $7055, $AAAA;
	{$ENDC}
PROCEDURE GetTrackMatrix(theTrack: Track; VAR matrix: MatrixRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $7056, $AAAA;
	{$ENDC}
PROCEDURE SetTrackMatrix(theTrack: Track; {CONST}VAR matrix: MatrixRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $7057, $AAAA;
	{$ENDC}
PROCEDURE GetTrackDimensions(theTrack: Track; VAR width: Fixed; VAR height: Fixed);
	{$IFC NOT GENERATINGCFM}
	INLINE $705D, $AAAA;
	{$ENDC}
PROCEDURE SetTrackDimensions(theTrack: Track; width: Fixed; height: Fixed);
	{$IFC NOT GENERATINGCFM}
	INLINE $705E, $AAAA;
	{$ENDC}
FUNCTION GetTrackUserData(theTrack: Track): UserData;
	{$IFC NOT GENERATINGCFM}
	INLINE $705F, $AAAA;
	{$ENDC}
FUNCTION GetTrackDisplayMatrix(theTrack: Track; VAR matrix: MatrixRecord): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0263, $AAAA;
	{$ENDC}
FUNCTION GetTrackSoundLocalizationSettings(theTrack: Track; VAR settings: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0282, $AAAA;
	{$ENDC}
FUNCTION SetTrackSoundLocalizationSettings(theTrack: Track; settings: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0283, $AAAA;
	{$ENDC}
{
************************
* get Media routines
*************************
}
FUNCTION NewTrackMedia(theTrack: Track; mediaType: OSType; timeScale: TimeScale; dataRef: Handle; dataRefType: OSType): Media;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $018E, $AAAA;
	{$ENDC}
PROCEDURE DisposeTrackMedia(theMedia: Media);
	{$IFC NOT GENERATINGCFM}
	INLINE $7061, $AAAA;
	{$ENDC}
FUNCTION GetTrackMedia(theTrack: Track): Media;
	{$IFC NOT GENERATINGCFM}
	INLINE $7062, $AAAA;
	{$ENDC}
FUNCTION GetMediaTrack(theMedia: Media): Track;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00C5, $AAAA;
	{$ENDC}
{
************************
* Media State routines
*************************
}
FUNCTION GetMediaCreationTime(theMedia: Media): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7066, $AAAA;
	{$ENDC}
FUNCTION GetMediaModificationTime(theMedia: Media): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7067, $AAAA;
	{$ENDC}
FUNCTION GetMediaTimeScale(theMedia: Media): TimeScale;
	{$IFC NOT GENERATINGCFM}
	INLINE $7068, $AAAA;
	{$ENDC}
PROCEDURE SetMediaTimeScale(theMedia: Media; timeScale: TimeScale);
	{$IFC NOT GENERATINGCFM}
	INLINE $7069, $AAAA;
	{$ENDC}
FUNCTION GetMediaDuration(theMedia: Media): TimeValue;
	{$IFC NOT GENERATINGCFM}
	INLINE $706A, $AAAA;
	{$ENDC}
FUNCTION GetMediaLanguage(theMedia: Media): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $706B, $AAAA;
	{$ENDC}
PROCEDURE SetMediaLanguage(theMedia: Media; language: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $706C, $AAAA;
	{$ENDC}
FUNCTION GetMediaQuality(theMedia: Media): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $706D, $AAAA;
	{$ENDC}
PROCEDURE SetMediaQuality(theMedia: Media; quality: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $706E, $AAAA;
	{$ENDC}
PROCEDURE GetMediaHandlerDescription(theMedia: Media; VAR mediaType: OSType; VAR creatorName: Str255; VAR creatorManufacturer: OSType);
	{$IFC NOT GENERATINGCFM}
	INLINE $706F, $AAAA;
	{$ENDC}
FUNCTION GetMediaUserData(theMedia: Media): UserData;
	{$IFC NOT GENERATINGCFM}
	INLINE $7070, $AAAA;
	{$ENDC}
FUNCTION GetMediaInputMap(theMedia: Media; VAR inputMap: QTAtomContainer): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0249, $AAAA;
	{$ENDC}
FUNCTION SetMediaInputMap(theMedia: Media; inputMap: QTAtomContainer): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $024A, $AAAA;
	{$ENDC}
{
************************
* Media Handler routines
*************************
}
FUNCTION GetMediaHandler(theMedia: Media): MediaHandler;
	{$IFC NOT GENERATINGCFM}
	INLINE $7071, $AAAA;
	{$ENDC}
FUNCTION SetMediaHandler(theMedia: Media; mH: MediaHandlerComponent): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0190, $AAAA;
	{$ENDC}
{
************************
* Media's Data routines
*************************
}
FUNCTION BeginMediaEdits(theMedia: Media): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7072, $AAAA;
	{$ENDC}
FUNCTION EndMediaEdits(theMedia: Media): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7073, $AAAA;
	{$ENDC}
FUNCTION SetMediaDefaultDataRefIndex(theMedia: Media; index: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01E0, $AAAA;
	{$ENDC}
PROCEDURE GetMediaDataHandlerDescription(theMedia: Media; index: INTEGER; VAR dhType: OSType; VAR creatorName: Str255; VAR creatorManufacturer: OSType);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $019E, $AAAA;
	{$ENDC}
FUNCTION GetMediaDataHandler(theMedia: Media; index: INTEGER): DataHandler;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $019F, $AAAA;
	{$ENDC}
FUNCTION SetMediaDataHandler(theMedia: Media; index: INTEGER; dataHandler: DataHandlerComponent): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01A0, $AAAA;
	{$ENDC}
FUNCTION GetDataHandler(dataRef: Handle; dataHandlerSubType: OSType; flags: LONGINT): Component;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01ED, $AAAA;
	{$ENDC}
{
************************
* Media Sample Table Routines
*************************
}
FUNCTION GetMediaSampleDescriptionCount(theMedia: Media): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7077, $AAAA;
	{$ENDC}
PROCEDURE GetMediaSampleDescription(theMedia: Media; index: LONGINT; descH: SampleDescriptionHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $7078, $AAAA;
	{$ENDC}
FUNCTION SetMediaSampleDescription(theMedia: Media; index: LONGINT; descH: SampleDescriptionHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01D0, $AAAA;
	{$ENDC}
FUNCTION GetMediaSampleCount(theMedia: Media): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7079, $AAAA;
	{$ENDC}
PROCEDURE SampleNumToMediaTime(theMedia: Media; logicalSampleNum: LONGINT; VAR sampleTime: TimeValue; VAR sampleDuration: TimeValue);
	{$IFC NOT GENERATINGCFM}
	INLINE $707A, $AAAA;
	{$ENDC}
PROCEDURE MediaTimeToSampleNum(theMedia: Media; time: TimeValue; VAR sampleNum: LONGINT; VAR sampleTime: TimeValue; VAR sampleDuration: TimeValue);
	{$IFC NOT GENERATINGCFM}
	INLINE $707B, $AAAA;
	{$ENDC}
FUNCTION AddMediaSample(theMedia: Media; dataIn: Handle; inOffset: LONGINT; size: LONGINT; durationPerSample: TimeValue; sampleDescriptionH: SampleDescriptionHandle; numberOfSamples: LONGINT; sampleFlags: INTEGER; VAR sampleTime: TimeValue): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $707C, $AAAA;
	{$ENDC}
FUNCTION AddMediaSampleReference(theMedia: Media; dataOffset: LONGINT; size: LONGINT; durationPerSample: TimeValue; sampleDescriptionH: SampleDescriptionHandle; numberOfSamples: LONGINT; sampleFlags: INTEGER; VAR sampleTime: TimeValue): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $707D, $AAAA;
	{$ENDC}
FUNCTION AddMediaSampleReferences(theMedia: Media; sampleDescriptionH: SampleDescriptionHandle; numberOfSamples: LONGINT; sampleRefs: SampleReferencePtr; VAR sampleTime: TimeValue): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01F7, $AAAA;
	{$ENDC}
FUNCTION GetMediaSample(theMedia: Media; dataOut: Handle; maxSizeToGrow: LONGINT; VAR size: LONGINT; time: TimeValue; VAR sampleTime: TimeValue; VAR durationPerSample: TimeValue; sampleDescriptionH: SampleDescriptionHandle; VAR sampleDescriptionIndex: LONGINT; maxNumberOfSamples: LONGINT; VAR numberOfSamples: LONGINT; VAR sampleFlags: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $707E, $AAAA;
	{$ENDC}
FUNCTION GetMediaSampleReference(theMedia: Media; VAR dataOffset: LONGINT; VAR size: LONGINT; time: TimeValue; VAR sampleTime: TimeValue; VAR durationPerSample: TimeValue; sampleDescriptionH: SampleDescriptionHandle; VAR sampleDescriptionIndex: LONGINT; maxNumberOfSamples: LONGINT; VAR numberOfSamples: LONGINT; VAR sampleFlags: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $707F, $AAAA;
	{$ENDC}
FUNCTION GetMediaSampleReferences(theMedia: Media; time: TimeValue; VAR sampleTime: TimeValue; sampleDescriptionH: SampleDescriptionHandle; VAR sampleDescriptionIndex: LONGINT; maxNumberOfEntries: LONGINT; VAR actualNumberofEntries: LONGINT; sampleRefs: SampleReferencePtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0235, $AAAA;
	{$ENDC}
FUNCTION SetMediaPreferredChunkSize(theMedia: Media; maxChunkSize: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01F8, $AAAA;
	{$ENDC}
FUNCTION GetMediaPreferredChunkSize(theMedia: Media; VAR maxChunkSize: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01F9, $AAAA;
	{$ENDC}
FUNCTION SetMediaShadowSync(theMedia: Media; frameDiffSampleNum: LONGINT; syncSampleNum: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0121, $AAAA;
	{$ENDC}
FUNCTION GetMediaShadowSync(theMedia: Media; frameDiffSampleNum: LONGINT; VAR syncSampleNum: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0122, $AAAA;
	{$ENDC}
{
************************
* Editing Routines
*************************
}
FUNCTION InsertMediaIntoTrack(theTrack: Track; trackStart: TimeValue; mediaTime: TimeValue; mediaDuration: TimeValue; mediaRate: Fixed): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0183, $AAAA;
	{$ENDC}
FUNCTION InsertTrackSegment(srcTrack: Track; dstTrack: Track; srcIn: TimeValue; srcDuration: TimeValue; dstIn: TimeValue): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0085, $AAAA;
	{$ENDC}
FUNCTION InsertMovieSegment(srcMovie: Movie; dstMovie: Movie; srcIn: TimeValue; srcDuration: TimeValue; dstIn: TimeValue): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0086, $AAAA;
	{$ENDC}
FUNCTION InsertEmptyTrackSegment(dstTrack: Track; dstIn: TimeValue; dstDuration: TimeValue): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0087, $AAAA;
	{$ENDC}
FUNCTION InsertEmptyMovieSegment(dstMovie: Movie; dstIn: TimeValue; dstDuration: TimeValue): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0088, $AAAA;
	{$ENDC}
FUNCTION DeleteTrackSegment(theTrack: Track; startTime: TimeValue; duration: TimeValue): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0089, $AAAA;
	{$ENDC}
FUNCTION DeleteMovieSegment(theMovie: Movie; startTime: TimeValue; duration: TimeValue): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $008A, $AAAA;
	{$ENDC}
FUNCTION ScaleTrackSegment(theTrack: Track; startTime: TimeValue; oldDuration: TimeValue; newDuration: TimeValue): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $008B, $AAAA;
	{$ENDC}
FUNCTION ScaleMovieSegment(theMovie: Movie; startTime: TimeValue; oldDuration: TimeValue; newDuration: TimeValue): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $008C, $AAAA;
	{$ENDC}
{
************************
* Hi-level Editing Routines
*************************
}
FUNCTION CutMovieSelection(theMovie: Movie): Movie;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $008D, $AAAA;
	{$ENDC}
FUNCTION CopyMovieSelection(theMovie: Movie): Movie;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $008E, $AAAA;
	{$ENDC}
PROCEDURE PasteMovieSelection(theMovie: Movie; src: Movie);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $008F, $AAAA;
	{$ENDC}
PROCEDURE AddMovieSelection(theMovie: Movie; src: Movie);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0152, $AAAA;
	{$ENDC}
PROCEDURE ClearMovieSelection(theMovie: Movie);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00E1, $AAAA;
	{$ENDC}
FUNCTION PasteHandleIntoMovie(h: Handle; handleType: OSType; theMovie: Movie; flags: LONGINT; userComp: ComponentInstance): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00CB, $AAAA;
	{$ENDC}
FUNCTION PutMovieIntoTypedHandle(theMovie: Movie; targetTrack: Track; handleType: OSType; publicMovie: Handle; start: TimeValue; dur: TimeValue; flags: LONGINT; userComp: ComponentInstance): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01CD, $AAAA;
	{$ENDC}
FUNCTION IsScrapMovie(targetTrack: Track): Component;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00CC, $AAAA;
	{$ENDC}
{
************************
* Middle-level Editing Routines
*************************
}
FUNCTION CopyTrackSettings(srcTrack: Track; dstTrack: Track): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0153, $AAAA;
	{$ENDC}
FUNCTION CopyMovieSettings(srcMovie: Movie; dstMovie: Movie): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0154, $AAAA;
	{$ENDC}
FUNCTION AddEmptyTrackToMovie(srcTrack: Track; dstMovie: Movie; dataRef: Handle; dataRefType: OSType; VAR dstTrack: Track): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7074, $AAAA;
	{$ENDC}
{
************************
* movie & track edit state routines
*************************
}
FUNCTION NewMovieEditState(theMovie: Movie): MovieEditState;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0104, $AAAA;
	{$ENDC}
FUNCTION UseMovieEditState(theMovie: Movie; toState: MovieEditState): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0105, $AAAA;
	{$ENDC}
FUNCTION DisposeMovieEditState(state: MovieEditState): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0106, $AAAA;
	{$ENDC}
FUNCTION NewTrackEditState(theTrack: Track): TrackEditState;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0107, $AAAA;
	{$ENDC}
FUNCTION UseTrackEditState(theTrack: Track; state: TrackEditState): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0108, $AAAA;
	{$ENDC}
FUNCTION DisposeTrackEditState(state: TrackEditState): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0109, $AAAA;
	{$ENDC}
{
************************
* track reference routines
*************************
}
FUNCTION AddTrackReference(theTrack: Track; refTrack: Track; refType: OSType; VAR addedIndex: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01F0, $AAAA;
	{$ENDC}
FUNCTION DeleteTrackReference(theTrack: Track; refType: OSType; index: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01F1, $AAAA;
	{$ENDC}
FUNCTION SetTrackReference(theTrack: Track; refTrack: Track; refType: OSType; index: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01F2, $AAAA;
	{$ENDC}
FUNCTION GetTrackReference(theTrack: Track; refType: OSType; index: LONGINT): Track;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01F3, $AAAA;
	{$ENDC}
FUNCTION GetNextTrackReferenceType(theTrack: Track; refType: OSType): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01F4, $AAAA;
	{$ENDC}
FUNCTION GetTrackReferenceCount(theTrack: Track; refType: OSType): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01F5, $AAAA;
	{$ENDC}
{
************************
* high level file conversion routines
*************************
}
FUNCTION ConvertFileToMovieFile({CONST}VAR inputFile: FSSpec; {CONST}VAR outputFile: FSSpec; creator: OSType; scriptTag: ScriptCode; VAR resID: INTEGER; flags: LONGINT; userComp: ComponentInstance; proc: MovieProgressUPP; refCon: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01CB, $AAAA;
	{$ENDC}
FUNCTION ConvertMovieToFile(theMovie: Movie; onlyTrack: Track; VAR outputFile: FSSpec; fileType: OSType; creator: OSType; scriptTag: ScriptCode; VAR resID: INTEGER; flags: LONGINT; userComp: ComponentInstance): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01CC, $AAAA;
	{$ENDC}
{
************************
* Movie Timebase Conversion Routines
*************************
}
FUNCTION TrackTimeToMediaTime(value: TimeValue; theTrack: Track): TimeValue;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0096, $AAAA;
	{$ENDC}
FUNCTION GetTrackEditRate(theTrack: Track; atTime: TimeValue): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0123, $AAAA;
	{$ENDC}
{
************************
* Miscellaneous Routines
*************************
}
FUNCTION GetMovieDataSize(theMovie: Movie; startTime: TimeValue; duration: TimeValue): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0098, $AAAA;
	{$ENDC}
FUNCTION GetTrackDataSize(theTrack: Track; startTime: TimeValue; duration: TimeValue): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0149, $AAAA;
	{$ENDC}
FUNCTION GetMediaDataSize(theMedia: Media; startTime: TimeValue; duration: TimeValue): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0099, $AAAA;
	{$ENDC}
FUNCTION PtInMovie(theMovie: Movie; pt: Point): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $009A, $AAAA;
	{$ENDC}
FUNCTION PtInTrack(theTrack: Track; pt: Point): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $009B, $AAAA;
	{$ENDC}
{
************************
* Group Selection Routines
*************************
}
PROCEDURE SetMovieLanguage(theMovie: Movie; language: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $009C, $AAAA;
	{$ENDC}
{
************************
* User Data
*************************
}
FUNCTION GetUserData(theUserData: UserData; data: Handle; udType: OSType; index: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $009E, $AAAA;
	{$ENDC}
FUNCTION AddUserData(theUserData: UserData; data: Handle; udType: OSType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $009F, $AAAA;
	{$ENDC}
FUNCTION RemoveUserData(theUserData: UserData; udType: OSType; index: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00A0, $AAAA;
	{$ENDC}
FUNCTION CountUserDataType(theUserData: UserData; udType: OSType): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $014B, $AAAA;
	{$ENDC}
FUNCTION GetNextUserDataType(theUserData: UserData; udType: OSType): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01A5, $AAAA;
	{$ENDC}
FUNCTION GetUserDataItem(theUserData: UserData; data: UNIV Ptr; size: LONGINT; udType: OSType; index: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0126, $AAAA;
	{$ENDC}
FUNCTION SetUserDataItem(theUserData: UserData; data: UNIV Ptr; size: LONGINT; udType: OSType; index: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $012E, $AAAA;
	{$ENDC}
FUNCTION AddUserDataText(theUserData: UserData; data: Handle; udType: OSType; index: LONGINT; itlRegionTag: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $014C, $AAAA;
	{$ENDC}
FUNCTION GetUserDataText(theUserData: UserData; data: Handle; udType: OSType; index: LONGINT; itlRegionTag: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $014D, $AAAA;
	{$ENDC}
FUNCTION RemoveUserDataText(theUserData: UserData; udType: OSType; index: LONGINT; itlRegionTag: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $014E, $AAAA;
	{$ENDC}
FUNCTION NewUserData(VAR theUserData: UserData): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $012F, $AAAA;
	{$ENDC}
FUNCTION DisposeUserData(theUserData: UserData): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0130, $AAAA;
	{$ENDC}
FUNCTION NewUserDataFromHandle(h: Handle; VAR theUserData: UserData): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0131, $AAAA;
	{$ENDC}
FUNCTION PutUserDataIntoHandle(theUserData: UserData; h: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0132, $AAAA;
	{$ENDC}
PROCEDURE GetMediaNextInterestingTime(theMedia: Media; interestingTimeFlags: INTEGER; time: TimeValue; rate: Fixed; VAR interestingTime: TimeValue; VAR interestingDuration: TimeValue);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $016D, $AAAA;
	{$ENDC}
PROCEDURE GetTrackNextInterestingTime(theTrack: Track; interestingTimeFlags: INTEGER; time: TimeValue; rate: Fixed; VAR interestingTime: TimeValue; VAR interestingDuration: TimeValue);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00E2, $AAAA;
	{$ENDC}
PROCEDURE GetMovieNextInterestingTime(theMovie: Movie; interestingTimeFlags: INTEGER; numMediaTypes: INTEGER; {CONST}VAR whichMediaTypes: OSType; time: TimeValue; rate: Fixed; VAR interestingTime: TimeValue; VAR interestingDuration: TimeValue);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $010E, $AAAA;
	{$ENDC}
FUNCTION CreateMovieFile({CONST}VAR fileSpec: FSSpec; creator: OSType; scriptTag: ScriptCode; createMovieFileFlags: LONGINT; VAR resRefNum: INTEGER; VAR newmovie: Movie): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0191, $AAAA;
	{$ENDC}
FUNCTION OpenMovieFile({CONST}VAR fileSpec: FSSpec; VAR resRefNum: INTEGER; permission: SInt8): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0192, $AAAA;
	{$ENDC}
FUNCTION CloseMovieFile(resRefNum: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00D5, $AAAA;
	{$ENDC}
FUNCTION DeleteMovieFile({CONST}VAR fileSpec: FSSpec): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0175, $AAAA;
	{$ENDC}
FUNCTION NewMovieFromFile(VAR theMovie: Movie; resRefNum: INTEGER; VAR resId: INTEGER; resName: StringPtr; newMovieFlags: INTEGER; VAR dataRefWasChanged: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00F0, $AAAA;
	{$ENDC}
FUNCTION NewMovieFromHandle(VAR theMovie: Movie; h: Handle; newMovieFlags: INTEGER; VAR dataRefWasChanged: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00F1, $AAAA;
	{$ENDC}
FUNCTION NewMovieFromDataFork(VAR theMovie: Movie; fRefNum: INTEGER; fileOffset: LONGINT; newMovieFlags: INTEGER; VAR dataRefWasChanged: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01B3, $AAAA;
	{$ENDC}
FUNCTION NewMovieFromUserProc(VAR m: Movie; flags: INTEGER; VAR dataRefWasChanged: BOOLEAN; getProc: GetMovieUPP; refCon: UNIV Ptr; defaultDataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01EC, $AAAA;
	{$ENDC}
FUNCTION NewMovieFromDataRef(VAR m: Movie; flags: INTEGER; VAR id: INTEGER; dataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0220, $AAAA;
	{$ENDC}
FUNCTION AddMovieResource(theMovie: Movie; resRefNum: INTEGER; VAR resId: INTEGER; resName: Str255): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00D7, $AAAA;
	{$ENDC}
FUNCTION UpdateMovieResource(theMovie: Movie; resRefNum: INTEGER; resId: INTEGER; resName: Str255): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00D8, $AAAA;
	{$ENDC}
FUNCTION RemoveMovieResource(resRefNum: INTEGER; resId: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0176, $AAAA;
	{$ENDC}
FUNCTION HasMovieChanged(theMovie: Movie): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00D9, $AAAA;
	{$ENDC}
PROCEDURE ClearMovieChanged(theMovie: Movie);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0113, $AAAA;
	{$ENDC}
FUNCTION SetMovieDefaultDataRef(theMovie: Movie; dataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01C1, $AAAA;
	{$ENDC}
FUNCTION GetMovieDefaultDataRef(theMovie: Movie; VAR dataRef: Handle; VAR dataRefType: OSType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01D2, $AAAA;
	{$ENDC}
FUNCTION SetMovieColorTable(theMovie: Movie; ctab: CTabHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0205, $AAAA;
	{$ENDC}
FUNCTION GetMovieColorTable(theMovie: Movie; VAR ctab: CTabHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0206, $AAAA;
	{$ENDC}
PROCEDURE FlattenMovie(theMovie: Movie; movieFlattenFlags: LONGINT; {CONST}VAR theFile: FSSpec; creator: OSType; scriptTag: ScriptCode; createMovieFileFlags: LONGINT; VAR resId: INTEGER; resName: Str255);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $019B, $AAAA;
	{$ENDC}
FUNCTION FlattenMovieData(theMovie: Movie; movieFlattenFlags: LONGINT; {CONST}VAR theFile: FSSpec; creator: OSType; scriptTag: ScriptCode; createMovieFileFlags: LONGINT): Movie;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $019C, $AAAA;
	{$ENDC}
PROCEDURE SetMovieProgressProc(theMovie: Movie; p: MovieProgressUPP; refcon: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $019A, $AAAA;
	{$ENDC}
FUNCTION MovieSearchText(theMovie: Movie; text: Ptr; size: LONGINT; searchFlags: LONGINT; VAR searchTrack: Track; VAR searchTime: TimeValue; VAR searchOffset: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0207, $AAAA;
	{$ENDC}
PROCEDURE GetPosterBox(theMovie: Movie; VAR boxRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $016F, $AAAA;
	{$ENDC}
PROCEDURE SetPosterBox(theMovie: Movie; {CONST}VAR boxRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0170, $AAAA;
	{$ENDC}
FUNCTION GetMovieSegmentDisplayBoundsRgn(theMovie: Movie; time: TimeValue; duration: TimeValue): RgnHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $016C, $AAAA;
	{$ENDC}
FUNCTION GetTrackSegmentDisplayBoundsRgn(theTrack: Track; time: TimeValue; duration: TimeValue): RgnHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $016B, $AAAA;
	{$ENDC}
PROCEDURE SetMovieCoverProcs(theMovie: Movie; uncoverProc: MovieRgnCoverUPP; coverProc: MovieRgnCoverUPP; refcon: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0179, $AAAA;
	{$ENDC}
FUNCTION GetMovieCoverProcs(theMovie: Movie; VAR uncoverProc: MovieRgnCoverUPP; VAR coverProc: MovieRgnCoverUPP; VAR refcon: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01DD, $AAAA;
	{$ENDC}
FUNCTION GetTrackStatus(theTrack: Track): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0172, $AAAA;
	{$ENDC}
FUNCTION GetMovieStatus(theMovie: Movie; VAR firstProblemTrack: Track): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0173, $AAAA;
	{$ENDC}
{
***
	Movie Controller support routines
***
}
FUNCTION NewMovieController(theMovie: Movie; {CONST}VAR movieRect: Rect; someFlags: LONGINT): ComponentInstance;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $018A, $AAAA;
	{$ENDC}
PROCEDURE DisposeMovieController(mc: ComponentInstance);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $018B, $AAAA;
	{$ENDC}
PROCEDURE ShowMovieInformation(theMovie: Movie; filterProc: ModalFilterUPP; refCon: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0209, $AAAA;
	{$ENDC}
{
****
	Scrap routines
****
}
FUNCTION PutMovieOnScrap(theMovie: Movie; movieScrapFlags: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $018C, $AAAA;
	{$ENDC}
FUNCTION NewMovieFromScrap(newMovieFlags: LONGINT): Movie;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $018D, $AAAA;
	{$ENDC}
{
****
	DataRef routines
****
}
FUNCTION GetMediaDataRef(theMedia: Media; index: INTEGER; VAR dataRef: Handle; VAR dataRefType: OSType; VAR dataRefAttributes: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0197, $AAAA;
	{$ENDC}
FUNCTION SetMediaDataRef(theMedia: Media; index: INTEGER; dataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01C9, $AAAA;
	{$ENDC}
FUNCTION SetMediaDataRefAttributes(theMedia: Media; index: INTEGER; dataRefAttributes: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01CA, $AAAA;
	{$ENDC}
FUNCTION AddMediaDataRef(theMedia: Media; VAR index: INTEGER; dataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0198, $AAAA;
	{$ENDC}
FUNCTION GetMediaDataRefCount(theMedia: Media; VAR count: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0199, $AAAA;
	{$ENDC}
{
****
	Playback hint routines
****
}
PROCEDURE SetMoviePlayHints(theMovie: Movie; flags: LONGINT; flagsMask: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01A1, $AAAA;
	{$ENDC}
PROCEDURE SetMediaPlayHints(theMedia: Media; flags: LONGINT; flagsMask: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01A2, $AAAA;
	{$ENDC}
{
****
	Load time track hints
****
}

CONST
	preloadAlways				= $00000001;
	preloadOnlyIfEnabled		= $00000002;

PROCEDURE SetTrackLoadSettings(theTrack: Track; preloadTime: TimeValue; preloadDuration: TimeValue; preloadFlags: LONGINT; defaultHints: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01E3, $AAAA;
	{$ENDC}
PROCEDURE GetTrackLoadSettings(theTrack: Track; VAR preloadTime: TimeValue; VAR preloadDuration: TimeValue; VAR preloadFlags: LONGINT; VAR defaultHints: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01E4, $AAAA;
	{$ENDC}
{
****
	Big screen TV
****
}

CONST
	fullScreenHideCursor		= $00000001;
	fullScreenAllowEvents		= $00000002;
	fullScreenDontChangeMenuBar	= $00000004;
	fullScreenPreflightSize		= $00000008;

FUNCTION BeginFullScreen(VAR restoreState: Ptr; whichGD: GDHandle; VAR desiredWidth: INTEGER; VAR desiredHeight: INTEGER; VAR newWindow: WindowPtr; VAR eraseColor: RGBColor; flags: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0233, $AAAA;
	{$ENDC}
FUNCTION EndFullScreen(fullState: Ptr; flags: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0234, $AAAA;
	{$ENDC}
{
****
	Sprite Toolbox
****
}

CONST
	kBackgroundSpriteLayerNum	= 32767;

{   Sprite Properties }
	kSpritePropertyMatrix		= 1;
	kSpritePropertyImageDescription = 2;
	kSpritePropertyImageDataPtr	= 3;
	kSpritePropertyVisible		= 4;
	kSpritePropertyLayer		= 5;
	kSpritePropertyGraphicsMode	= 6;
	kSpritePropertyImageIndex	= 100;
	kSpriteTrackPropertyBackgroundColor = 101;
	kSpriteTrackPropertyOffscreenBitDepth = 102;
	kSpriteTrackPropertySampleFormat = 103;

{  flagsIn for SpriteWorldIdle }
	kOnlyDrawToSpriteWorld		= $00000001;
	kSpriteWorldPreflight		= $00000002;

{  flagsOut for SpriteWorldIdle }
	kSpriteWorldDidDraw			= $00000001;
	kSpriteWorldNeedsToDraw		= $00000002;

{  flags for sprite track sample format }
	kKeyFrameAndSingleOverride	= $00000002;
	kKeyFrameAndAllOverrides	= $00000004;

FUNCTION NewSpriteWorld(VAR newSpriteWorld: SpriteWorld; destination: GWorldPtr; spriteLayer: GWorldPtr; VAR backgroundColor: RGBColor; background: GWorldPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0239, $AAAA;
	{$ENDC}
PROCEDURE DisposeSpriteWorld(theSpriteWorld: SpriteWorld);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $023A, $AAAA;
	{$ENDC}
FUNCTION SetSpriteWorldClip(theSpriteWorld: SpriteWorld; clipRgn: RgnHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $023B, $AAAA;
	{$ENDC}
FUNCTION SetSpriteWorldMatrix(theSpriteWorld: SpriteWorld; {CONST}VAR matrix: MatrixRecord): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $023C, $AAAA;
	{$ENDC}
FUNCTION SpriteWorldIdle(theSpriteWorld: SpriteWorld; flagsIn: LONGINT; VAR flagsOut: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $023D, $AAAA;
	{$ENDC}
FUNCTION InvalidateSpriteWorld(theSpriteWorld: SpriteWorld; VAR invalidArea: Rect): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $023E, $AAAA;
	{$ENDC}
FUNCTION SpriteWorldHitTest(theSpriteWorld: SpriteWorld; flags: LONGINT; loc: Point; VAR spriteHit: Sprite): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0246, $AAAA;
	{$ENDC}
FUNCTION SpriteHitTest(theSprite: Sprite; flags: LONGINT; loc: Point; VAR wasHit: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0247, $AAAA;
	{$ENDC}
PROCEDURE DisposeAllSprites(theSpriteWorld: SpriteWorld);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $023F, $AAAA;
	{$ENDC}
FUNCTION NewSprite(VAR newSprite: Sprite; itsSpriteWorld: SpriteWorld; idh: ImageDescriptionHandle; imageDataPtr: Ptr; VAR matrix: MatrixRecord; visible: BOOLEAN; layer: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0240, $AAAA;
	{$ENDC}
PROCEDURE DisposeSprite(theSprite: Sprite);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0241, $AAAA;
	{$ENDC}
PROCEDURE InvalidateSprite(theSprite: Sprite);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0242, $AAAA;
	{$ENDC}
FUNCTION SetSpriteProperty(theSprite: Sprite; propertyType: LONGINT; propertyValue: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0243, $AAAA;
	{$ENDC}
FUNCTION GetSpriteProperty(theSprite: Sprite; propertyType: LONGINT; propertyValue: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0244, $AAAA;
	{$ENDC}
{
****
	QT Atom Data Support
****
}

CONST
	kParentAtomIsContainer		= 0;

{  create and dispose QTAtomContainer objects }
FUNCTION QTNewAtomContainer(VAR atomData: QTAtomContainer): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $020C, $AAAA;
	{$ENDC}
FUNCTION QTDisposeAtomContainer(atomData: QTAtomContainer): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $020D, $AAAA;
	{$ENDC}
{  locating nested atoms within QTAtomContainer container }
FUNCTION QTGetNextChildType(container: QTAtomContainer; parentAtom: QTAtom; currentChildType: QTAtomType): QTAtomType;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $020E, $AAAA;
	{$ENDC}
FUNCTION QTCountChildrenOfType(container: QTAtomContainer; parentAtom: QTAtom; childType: QTAtomType): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $020F, $AAAA;
	{$ENDC}
FUNCTION QTFindChildByIndex(container: QTAtomContainer; parentAtom: QTAtom; atomType: QTAtomType; index: INTEGER; VAR id: QTAtomID): QTAtom;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0210, $AAAA;
	{$ENDC}
FUNCTION QTFindChildByID(container: QTAtomContainer; parentAtom: QTAtom; atomType: QTAtomType; id: QTAtomID; VAR index: INTEGER): QTAtom;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $021D, $AAAA;
	{$ENDC}
FUNCTION QTNextChildAnyType(container: QTAtomContainer; parentAtom: QTAtom; currentChild: QTAtom; VAR nextChild: QTAtom): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0200, $AAAA;
	{$ENDC}
{  set a leaf atom's data }
FUNCTION QTSetAtomData(container: QTAtomContainer; atom: QTAtom; dataSize: LONGINT; atomData: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0211, $AAAA;
	{$ENDC}
{  extracting data }
FUNCTION QTCopyAtomDataToHandle(container: QTAtomContainer; atom: QTAtom; targetHandle: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0212, $AAAA;
	{$ENDC}
FUNCTION QTCopyAtomDataToPtr(container: QTAtomContainer; atom: QTAtom; sizeOrLessOK: BOOLEAN; size: LONGINT; targetPtr: UNIV Ptr; VAR actualSize: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0213, $AAAA;
	{$ENDC}
FUNCTION QTGetAtomTypeAndID(container: QTAtomContainer; atom: QTAtom; VAR atomType: QTAtomType; VAR id: QTAtomID): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0232, $AAAA;
	{$ENDC}
{  extract a copy of an atom and all of it's children, caller disposes }
FUNCTION QTCopyAtom(container: QTAtomContainer; atom: QTAtom; VAR targetContainer: QTAtomContainer): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0214, $AAAA;
	{$ENDC}
{  obtaining direct reference to atom data }
FUNCTION QTLockContainer(container: QTAtomContainer): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0215, $AAAA;
	{$ENDC}
FUNCTION QTGetAtomDataPtr(container: QTAtomContainer; atom: QTAtom; VAR dataSize: LONGINT; VAR atomData: Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0216, $AAAA;
	{$ENDC}
FUNCTION QTUnlockContainer(container: QTAtomContainer): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0217, $AAAA;
	{$ENDC}
{
 building QTAtomContainer trees
 creates and inserts new atom at specified index, existing atoms at or after index are moved toward end of list
 used for Top-Down tree creation
}
FUNCTION QTInsertChild(container: QTAtomContainer; parentAtom: QTAtom; atomType: QTAtomType; id: QTAtomID; index: INTEGER; dataSize: LONGINT; data: UNIV Ptr; VAR newAtom: QTAtom): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0218, $AAAA;
	{$ENDC}
{  inserts children from childrenContainer as children of parentAtom }
FUNCTION QTInsertChildren(container: QTAtomContainer; parentAtom: QTAtom; childrenContainer: QTAtomContainer): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0219, $AAAA;
	{$ENDC}
{  destruction }
FUNCTION QTRemoveAtom(container: QTAtomContainer; atom: QTAtom): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $021A, $AAAA;
	{$ENDC}
FUNCTION QTRemoveChildren(container: QTAtomContainer; atom: QTAtom): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $021B, $AAAA;
	{$ENDC}
{  replacement must be same type as target }
FUNCTION QTReplaceAtom(targetContainer: QTAtomContainer; targetAtom: QTAtom; replacementContainer: QTAtomContainer; replacementAtom: QTAtom): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $021C, $AAAA;
	{$ENDC}
FUNCTION QTSwapAtoms(container: QTAtomContainer; atom1: QTAtom; atom2: QTAtom): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $01FF, $AAAA;
	{$ENDC}
FUNCTION QTSetAtomID(container: QTAtomContainer; atom: QTAtom; newID: QTAtomID): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0231, $AAAA;
	{$ENDC}
FUNCTION SetMediaPropertyAtom(theMedia: Media; propertyAtom: QTAtomContainer): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $022E, $AAAA;
	{$ENDC}
FUNCTION GetMediaPropertyAtom(theMedia: Media; VAR propertyAtom: QTAtomContainer): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $022F, $AAAA;
	{$ENDC}
{
****
	QT International Text Atom Support
****
}

CONST
	kITextRemoveEverythingBut	= $00;
	kITextRemoveLeaveSuggestedAlternate = $02;

	kITextAtomType				= 'itxt';
	kITextStringAtomType		= 'text';

FUNCTION ITextAddString(container: QTAtomContainer; parentAtom: QTAtom; theRegionCode: INTEGER; theString: Str255): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $027A, $AAAA;
	{$ENDC}
FUNCTION ITextRemoveString(container: QTAtomContainer; parentAtom: QTAtom; theRegionCode: INTEGER; flags: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $027B, $AAAA;
	{$ENDC}
FUNCTION ITextGetString(container: QTAtomContainer; parentAtom: QTAtom; requestedRegion: INTEGER; VAR foundRegion: INTEGER; theString: StringPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $027C, $AAAA;
	{$ENDC}
{
************************
* modifier track types
*************************
}

CONST
	kTrackModifierInput			= $696E;						{  is really 'in' }
	kTrackModifierType			= $7479;						{  is really 'ty' }
	kTrackModifierReference		= 'ssrc';
	kTrackModifierObjectID		= 'obid';
	kTrackModifierInputName		= 'name';

	kInputMapSubInputID			= 'subi';

	kTrackModifierTypeMatrix	= 1;
	kTrackModifierTypeClip		= 2;
	kTrackModifierTypeGraphicsMode = 5;
	kTrackModifierTypeVolume	= 3;
	kTrackModifierTypeBalance	= 4;
	kTrackModifierTypeImage		= 'vide';						{  was kTrackModifierTypeSpriteImage }
	kTrackModifierObjectMatrix	= 6;
	kTrackModifierObjectGraphicsMode = 7;
	kTrackModifierType3d4x4Matrix = 8;
	kTrackModifierCameraData	= 9;
	kTrackModifierSoundLocalizationData = 10;


TYPE
	ModifierTrackGraphicsModeRecordPtr = ^ModifierTrackGraphicsModeRecord;
	ModifierTrackGraphicsModeRecord = RECORD
		graphicsMode:			LONGINT;
		opColor:				RGBColor;
	END;

{
************************
* tween track types
*************************
}

CONST
	kTweenTypeShort				= 1;
	kTweenTypeLong				= 2;
	kTweenTypeFixed				= 3;
	kTweenTypePoint				= 4;
	kTweenTypeQDRect			= 5;
	kTweenTypeQDRegion			= 6;
	kTweenTypeMatrix			= 7;
	kTweenTypeRGBColor			= 8;
	kTweenTypeGraphicsModeWithRGBColor = 9;
	kTweenType3dScale			= '3sca';
	kTweenType3dTranslate		= '3tra';
	kTweenType3dRotate			= '3rot';
	kTweenType3dRotateAboutPoint = '3rap';
	kTweenType3dRotateAboutAxis	= '3rax';
	kTweenType3dQuaternion		= '3qua';
	kTweenType3dMatrix			= '3mat';
	kTweenType3dCameraData		= '3cam';
	kTweenType3dSoundLocalizationData = '3slc';

	kTweenEntry					= 'twen';
	kTweenData					= 'data';
	kTweenType					= 'twnt';
	kTweenStartOffset			= 'twst';
	kTweenDuration				= 'twdu';
	kTween3dInitialCondition	= 'icnd';
	kTweenInterpolationStyle	= 'isty';
	kTweenRegionData			= 'qdrg';
	kTweenPictureData			= 'PICT';

	internalComponentErr		= -2070;
	notImplementedMusicOSErr	= -2071;
	cantSendToSynthesizerOSErr	= -2072;
	cantReceiveFromSynthesizerOSErr = -2073;
	illegalVoiceAllocationOSErr	= -2074;
	illegalPartOSErr			= -2075;
	illegalChannelOSErr			= -2076;
	illegalKnobOSErr			= -2077;
	illegalKnobValueOSErr		= -2078;
	illegalInstrumentOSErr		= -2079;
	illegalControllerOSErr		= -2080;
	midiManagerAbsentOSErr		= -2081;
	synthesizerNotRespondingOSErr = -2082;
	synthesizerOSErr			= -2083;
	illegalNoteChannelOSErr		= -2084;
	noteChannelNotAllocatedOSErr = -2085;
	tunePlayerFullOSErr			= -2086;
	tuneParseOSErr				= -2087;

{
************************
* Video Media routines
*************************
}
	videoFlagDontLeanAhead		= $00000001;

{  use these two routines at your own peril }
FUNCTION VideoMediaResetStatistics(mh: MediaHandler): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0105, $7000, $A82A;
	{$ENDC}
FUNCTION VideoMediaGetStatistics(mh: MediaHandler): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0106, $7000, $A82A;
	{$ENDC}
{
************************
* Text Media routines
*************************
}
{  Return displayFlags for TextProc  }

CONST
	txtProcDefaultDisplay		= 0;							{ 	Use the media's default }
	txtProcDontDisplay			= 1;							{ 	Don't display the text }
	txtProcDoDisplay			= 2;							{ 	Do display the text }

FUNCTION TextMediaSetTextProc(mh: MediaHandler; TextProc: TextMediaUPP; refcon: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION TextMediaAddTextSample(mh: MediaHandler; text: Ptr; size: LONGINT; fontNumber: INTEGER; fontSize: INTEGER; textFace: ByteParameter; VAR textColor: RGBColor; VAR backColor: RGBColor; textJustification: INTEGER; VAR textBox: Rect; displayFlags: LONGINT; scrollDelay: TimeValue; hiliteStart: INTEGER; hiliteEnd: INTEGER; VAR rgbHiliteColor: RGBColor; duration: TimeValue; VAR sampleTime: TimeValue): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0034, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION TextMediaAddTESample(mh: MediaHandler; hTE: TEHandle; VAR backColor: RGBColor; textJustification: INTEGER; VAR textBox: Rect; displayFlags: LONGINT; scrollDelay: TimeValue; hiliteStart: INTEGER; hiliteEnd: INTEGER; VAR rgbHiliteColor: RGBColor; duration: TimeValue; VAR sampleTime: TimeValue): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0026, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION TextMediaAddHiliteSample(mh: MediaHandler; hiliteStart: INTEGER; hiliteEnd: INTEGER; VAR rgbHiliteColor: RGBColor; duration: TimeValue; VAR sampleTime: TimeValue): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0010, $0104, $7000, $A82A;
	{$ENDC}

CONST
	findTextEdgeOK				= $01;							{  Okay to find text at specified sample time }
	findTextCaseSensitive		= $02;							{  Case sensitive search }
	findTextReverseSearch		= $04;							{  Search from sampleTime backwards }
	findTextWrapAround			= $08;							{  Wrap search when beginning or end of movie is hit }
	findTextUseOffset			= $10;							{  Begin search at the given character offset into sample rather than edge }

FUNCTION TextMediaFindNextText(mh: MediaHandler; text: Ptr; size: LONGINT; findFlags: INTEGER; startTime: TimeValue; VAR foundTime: TimeValue; VAR foundDuration: TimeValue; VAR offset: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $001A, $0105, $7000, $A82A;
	{$ENDC}
FUNCTION TextMediaHiliteTextSample(mh: MediaHandler; sampleTime: TimeValue; hiliteStart: INTEGER; hiliteEnd: INTEGER; VAR rgbHiliteColor: RGBColor): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0106, $7000, $A82A;
	{$ENDC}

CONST
	dropShadowOffsetType		= 'drpo';
	dropShadowTranslucencyType	= 'drpt';

FUNCTION TextMediaSetTextSampleData(mh: MediaHandler; data: UNIV Ptr; dataType: OSType): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0107, $7000, $A82A;
	{$ENDC}
{
************************
* Sprite Media routines
*************************
}
{  flags for HitTestSpriteMedia  }

CONST
	spriteHitTestBounds			= $00000001;					{ 	point must only be within sprite's bounding box }
	spriteHitTestImage			= $00000002;					{   point must be within the shape of the sprite's image }

{  atom types for sprite media  }
	kSpriteAtomType				= 'sprt';
	kSpriteImagesContainerAtomType = 'imct';
	kSpriteImageAtomType		= 'imag';
	kSpriteImageDataAtomType	= 'imda';
	kSpriteSharedDataAtomType	= 'dflt';
	kSpriteNameAtomType			= 'name';

FUNCTION SpriteMediaSetProperty(mh: MediaHandler; spriteIndex: INTEGER; propertyType: LONGINT; propertyValue: UNIV Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000A, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaGetProperty(mh: MediaHandler; spriteIndex: INTEGER; propertyType: LONGINT; propertyValue: UNIV Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000A, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaHitTestSprites(mh: MediaHandler; flags: LONGINT; loc: Point; VAR spriteHitIndex: INTEGER): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0103, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaCountSprites(mh: MediaHandler; VAR numSprites: INTEGER): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0104, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaCountImages(mh: MediaHandler; VAR numImages: INTEGER): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0105, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaGetIndImageDescription(mh: MediaHandler; imageIndex: INTEGER; imageDescription: ImageDescriptionHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0006, $0106, $7000, $A82A;
	{$ENDC}
FUNCTION SpriteMediaGetDisplayedSampleNumber(mh: MediaHandler; VAR sampleNum: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0107, $7000, $A82A;
	{$ENDC}
{
************************
* 3D Media routines
*************************
}
FUNCTION Media3DGetNamedObjectList(mh: MediaHandler; VAR objectList: QTAtomContainer): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION Media3DGetRendererList(mh: MediaHandler; VAR rendererList: QTAtomContainer): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}
{
***************************************
*										*
*  	M O V I E   C O N T R O L L E R		*
*										*
***************************************
}

CONST
	MovieControllerComponentType = 'play';


TYPE
	MovieController						= ComponentInstance;

CONST
	mcActionIdle				= 1;							{  no param }
	mcActionDraw				= 2;							{  param is WindowPtr }
	mcActionActivate			= 3;							{  no param }
	mcActionDeactivate			= 4;							{  no param }
	mcActionMouseDown			= 5;							{  param is pointer to EventRecord }
	mcActionKey					= 6;							{  param is pointer to EventRecord }
	mcActionPlay				= 8;							{  param is Fixed, play rate }
	mcActionGoToTime			= 12;							{  param is TimeRecord }
	mcActionSetVolume			= 14;							{  param is a short }
	mcActionGetVolume			= 15;							{  param is pointer to a short }
	mcActionStep				= 18;							{  param is number of steps (short) }
	mcActionSetLooping			= 21;							{  param is Boolean }
	mcActionGetLooping			= 22;							{  param is pointer to a Boolean }
	mcActionSetLoopIsPalindrome	= 23;							{  param is Boolean }
	mcActionGetLoopIsPalindrome	= 24;							{  param is pointer to a Boolean }
	mcActionSetGrowBoxBounds	= 25;							{  param is a Rect }
	mcActionControllerSizeChanged = 26;							{  no param }
	mcActionSetSelectionBegin	= 29;							{  param is TimeRecord }
	mcActionSetSelectionDuration = 30;							{  param is TimeRecord, action only taken on set-duration }
	mcActionSetKeysEnabled		= 32;							{  param is Boolean }
	mcActionGetKeysEnabled		= 33;							{  param is pointer to Boolean }
	mcActionSetPlaySelection	= 34;							{  param is Boolean }
	mcActionGetPlaySelection	= 35;							{  param is pointer to Boolean }
	mcActionSetUseBadge			= 36;							{  param is Boolean }
	mcActionGetUseBadge			= 37;							{  param is pointer to Boolean }
	mcActionSetFlags			= 38;							{  param is long of flags }
	mcActionGetFlags			= 39;							{  param is pointer to a long of flags }
	mcActionSetPlayEveryFrame	= 40;							{  param is Boolean }
	mcActionGetPlayEveryFrame	= 41;							{  param is pointer to Boolean }
	mcActionGetPlayRate			= 42;							{  param is pointer to Fixed }
	mcActionShowBalloon			= 43;							{  param is a pointer to a boolean. set to false to stop balloon }
	mcActionBadgeClick			= 44;							{  param is pointer to Boolean. set to false to ignore click }
	mcActionMovieClick			= 45;							{  param is pointer to event record. change “what” to nullEvt to kill click }
	mcActionSuspend				= 46;							{  no param }
	mcActionResume				= 47;							{  no param }
	mcActionSetControllerKeysEnabled = 48;						{  param is Boolean }
	mcActionGetTimeSliderRect	= 49;							{  param is pointer to rect }
	mcActionMovieEdited			= 50;							{  no param }
	mcActionGetDragEnabled		= 51;							{  param is pointer to Boolean }
	mcActionSetDragEnabled		= 52;							{  param is Boolean }
	mcActionGetSelectionBegin	= 53;							{  param is TimeRecord }
	mcActionGetSelectionDuration = 54;							{  param is TimeRecord }
	mcActionPrerollAndPlay		= 55;							{  param is Fixed, play rate }
	mcActionGetCursorSettingEnabled = 56;						{  param is pointer to Boolean }
	mcActionSetCursorSettingEnabled = 57;						{  param is Boolean }
	mcActionSetColorTable		= 58;							{  param is CTabHandle }


TYPE
	mcAction							= INTEGER;

CONST
	mcFlagSuppressMovieFrame	= $01;
	mcFlagSuppressStepButtons	= $02;
	mcFlagSuppressSpeakerButton	= $04;
	mcFlagsUseWindowPalette		= $08;
	mcFlagsDontInvalidate		= $10;

	mcPositionDontInvalidate	= $20;


TYPE
	mcFlags								= LONGINT;
	MCActionFilterProcPtr = ProcPtr;  { FUNCTION MCActionFilter(mc: MovieController; VAR action: INTEGER; params: UNIV Ptr): BOOLEAN; }

	MCActionFilterWithRefConProcPtr = ProcPtr;  { FUNCTION MCActionFilterWithRefCon(mc: MovieController; action: INTEGER; params: UNIV Ptr; refCon: LONGINT): BOOLEAN; }

	MCActionFilterUPP = UniversalProcPtr;
	MCActionFilterWithRefConUPP = UniversalProcPtr;
{
	menu related stuff
}

CONST
	mcInfoUndoAvailable			= $01;
	mcInfoCutAvailable			= $02;
	mcInfoCopyAvailable			= $04;
	mcInfoPasteAvailable		= $08;
	mcInfoClearAvailable		= $10;
	mcInfoHasSound				= $20;
	mcInfoIsPlaying				= $40;
	mcInfoIsLooping				= $80;
	mcInfoIsInPalindrome		= $0100;
	mcInfoEditingEnabled		= $0200;
	mcInfoMovieIsInteractive	= $0400;

{  menu item codes }
	mcMenuUndo					= 1;
	mcMenuCut					= 3;
	mcMenuCopy					= 4;
	mcMenuPaste					= 5;
	mcMenuClear					= 6;

{  target management  }
FUNCTION MCSetMovie(mc: MovieController; theMovie: Movie; movieWindow: WindowPtr; where: Point): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetIndMovie(mc: MovieController; index: INTEGER): Movie;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0002, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION MCRemoveAllMovies(mc: MovieController): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION MCRemoveAMovie(mc: MovieController; m: Movie): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION MCRemoveMovie(mc: MovieController): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0006, $7000, $A82A;
	{$ENDC}
{  event handling etc.  }
FUNCTION MCIsPlayerEvent(mc: MovieController; {CONST}VAR e: EventRecord): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
{  obsolete. use MCSetActionFilterWithRefCon instead.  }
FUNCTION MCSetActionFilter(mc: MovieController; blob: MCActionFilterUPP): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0008, $7000, $A82A;
	{$ENDC}
{
	proc is of the form:
		Boolean userPlayerFilter(MovieController mc, short *action, void *params) =
	proc returns TRUE if it handles the action, FALSE if not
	action is passed as a VAR so that it could be changed by filter
	this is consistent with the current dialog manager stuff
	params is any potential parameters that go with the action
		such as set playback rate to xxx.
}
FUNCTION MCDoAction(mc: MovieController; action: INTEGER; params: UNIV Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0006, $0009, $7000, $A82A;
	{$ENDC}
{  state type things  }
FUNCTION MCSetControllerAttached(mc: MovieController; attach: BOOLEAN): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0002, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION MCIsControllerAttached(mc: MovieController): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION MCSetControllerPort(mc: MovieController; gp: CGrafPtr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetControllerPort(mc: MovieController): CGrafPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION MCSetVisible(mc: MovieController; visible: BOOLEAN): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0002, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetVisible(mc: MovieController): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetControllerBoundsRect(mc: MovieController; VAR bounds: Rect): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION MCSetControllerBoundsRect(mc: MovieController; {CONST}VAR bounds: Rect): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetControllerBoundsRgn(mc: MovieController): RgnHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetWindowRgn(mc: MovieController; w: WindowPtr): RgnHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0013, $7000, $A82A;
	{$ENDC}
{  other stuff  }
FUNCTION MCMovieChanged(mc: MovieController; m: Movie): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0014, $7000, $A82A;
	{$ENDC}
{
	called when the app has changed thing about the movie (like bounding rect) or rate. So that we
		can update our graphical (and internal) state accordingly.
}
FUNCTION MCSetDuration(mc: MovieController; duration: TimeValue): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0015, $7000, $A82A;
	{$ENDC}
{
	duration to use for time slider -- will be reset next time MCMovieChanged is called
		or MCSetMovie is called
}
FUNCTION MCGetCurrentTime(mc: MovieController; VAR scale: TimeScale): TimeValue;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0016, $7000, $A82A;
	{$ENDC}
{
	returns the time value and the time scale it is on. if there are no movies, the
		time scale is passed back as 0. scale is an optional parameter

}
FUNCTION MCNewAttachedController(mc: MovieController; theMovie: Movie; w: WindowPtr; where: Point): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0017, $7000, $A82A;
	{$ENDC}
{
	makes theMovie the only movie attached to the controller. makes the controller visible.
	the window and where parameters are passed a long to MCSetMovie and behave as
	described there
}
FUNCTION MCDraw(mc: MovieController; w: WindowPtr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}
FUNCTION MCActivate(mc: MovieController; w: WindowPtr; activate: BOOLEAN): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0006, $0019, $7000, $A82A;
	{$ENDC}
FUNCTION MCIdle(mc: MovieController): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $001A, $7000, $A82A;
	{$ENDC}
FUNCTION MCKey(mc: MovieController; key: SInt8; modifiers: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0006, $001B, $7000, $A82A;
	{$ENDC}
FUNCTION MCClick(mc: MovieController; w: WindowPtr; where: Point; when: LONGINT; modifiers: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0010, $001C, $7000, $A82A;
	{$ENDC}
{
	calls for editing
}
FUNCTION MCEnableEditing(mc: MovieController; enabled: BOOLEAN): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0002, $001D, $7000, $A82A;
	{$ENDC}
FUNCTION MCIsEditingEnabled(mc: MovieController): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $001E, $7000, $A82A;
	{$ENDC}
FUNCTION MCCopy(mc: MovieController): Movie;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $001F, $7000, $A82A;
	{$ENDC}
FUNCTION MCCut(mc: MovieController): Movie;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0020, $7000, $A82A;
	{$ENDC}
FUNCTION MCPaste(mc: MovieController; srcMovie: Movie): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0021, $7000, $A82A;
	{$ENDC}
FUNCTION MCClear(mc: MovieController): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0022, $7000, $A82A;
	{$ENDC}
FUNCTION MCUndo(mc: MovieController): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0023, $7000, $A82A;
	{$ENDC}
{
 *	somewhat special stuff
}
FUNCTION MCPositionController(mc: MovieController; {CONST}VAR movieRect: Rect; {CONST}VAR controllerRect: Rect; someFlags: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0024, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetControllerInfo(mc: MovieController; VAR someFlags: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0025, $7000, $A82A;
	{$ENDC}
FUNCTION MCSetClip(mc: MovieController; theClip: RgnHandle; movieClip: RgnHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0028, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetClip(mc: MovieController; VAR theClip: RgnHandle; VAR movieClip: RgnHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0029, $7000, $A82A;
	{$ENDC}
FUNCTION MCDrawBadge(mc: MovieController; movieRgn: RgnHandle; VAR badgeRgn: RgnHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $002A, $7000, $A82A;
	{$ENDC}
FUNCTION MCSetUpEditMenu(mc: MovieController; modifiers: LONGINT; mh: MenuHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $002B, $7000, $A82A;
	{$ENDC}
FUNCTION MCGetMenuString(mc: MovieController; modifiers: LONGINT; item: INTEGER; VAR aString: Str255): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000A, $002C, $7000, $A82A;
	{$ENDC}
FUNCTION MCSetActionFilterWithRefCon(mc: MovieController; blob: MCActionFilterWithRefConUPP; refCon: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $002D, $7000, $A82A;
	{$ENDC}
FUNCTION MCPtInController(mc: MovieController; thePt: Point; VAR inController: BOOLEAN): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $002E, $7000, $A82A;
	{$ENDC}
FUNCTION MCInvalidate(mc: MovieController; w: WindowPtr; invalidRgn: RgnHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $002F, $7000, $A82A;
	{$ENDC}
{
***************************************
*										*
*  		T  I  M  E  B  A  S  E			*
*										*
***************************************
}
FUNCTION NewTimeBase: TimeBase;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00A5, $AAAA;
	{$ENDC}
PROCEDURE DisposeTimeBase(tb: TimeBase);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00B6, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseTime(tb: TimeBase; s: TimeScale; VAR tr: TimeRecord): TimeValue;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00A6, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseTime(tb: TimeBase; {CONST}VAR tr: TimeRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00A7, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseValue(tb: TimeBase; t: TimeValue; s: TimeScale);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00A8, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseRate(tb: TimeBase): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00A9, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseRate(tb: TimeBase; r: Fixed);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00AA, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseStartTime(tb: TimeBase; s: TimeScale; VAR tr: TimeRecord): TimeValue;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00AB, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseStartTime(tb: TimeBase; {CONST}VAR tr: TimeRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00AC, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseStopTime(tb: TimeBase; s: TimeScale; VAR tr: TimeRecord): TimeValue;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00AD, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseStopTime(tb: TimeBase; {CONST}VAR tr: TimeRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00AE, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseFlags(tb: TimeBase): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00B1, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseFlags(tb: TimeBase; timeBaseFlags: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00B2, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseMasterTimeBase(slave: TimeBase; master: TimeBase; {CONST}VAR slaveZero: TimeRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00B4, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseMasterTimeBase(tb: TimeBase): TimeBase;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00AF, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseMasterClock(slave: TimeBase; clockMeister: Component; {CONST}VAR slaveZero: TimeRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00B3, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseMasterClock(tb: TimeBase): ComponentInstance;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00B0, $AAAA;
	{$ENDC}
PROCEDURE ConvertTime(VAR inout: TimeRecord; newBase: TimeBase);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00B5, $AAAA;
	{$ENDC}
PROCEDURE ConvertTimeScale(VAR inout: TimeRecord; newScale: TimeScale);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00B7, $AAAA;
	{$ENDC}
PROCEDURE AddTime(VAR dst: TimeRecord; {CONST}VAR src: TimeRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $010C, $AAAA;
	{$ENDC}
PROCEDURE SubtractTime(VAR dst: TimeRecord; {CONST}VAR src: TimeRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $010D, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseStatus(tb: TimeBase; VAR unpinnedTime: TimeRecord): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $010B, $AAAA;
	{$ENDC}
PROCEDURE SetTimeBaseZero(tb: TimeBase; VAR zero: TimeRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0128, $AAAA;
	{$ENDC}
FUNCTION GetTimeBaseEffectiveRate(tb: TimeBase): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0124, $AAAA;
	{$ENDC}
{
***************************************
*										*
*  		C  A  L  L  B  A  C  K 			*
*										*
***************************************
}
FUNCTION NewCallBack(tb: TimeBase; cbType: INTEGER): QTCallBack;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00EB, $AAAA;
	{$ENDC}
PROCEDURE DisposeCallBack(cb: QTCallBack);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00EC, $AAAA;
	{$ENDC}
FUNCTION GetCallBackType(cb: QTCallBack): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00ED, $AAAA;
	{$ENDC}
FUNCTION GetCallBackTimeBase(cb: QTCallBack): TimeBase;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00EE, $AAAA;
	{$ENDC}
FUNCTION CallMeWhen(cb: QTCallBack; callBackProc: QTCallBackUPP; refCon: LONGINT; param1: LONGINT; param2: LONGINT; param3: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00B8, $AAAA;
	{$ENDC}
PROCEDURE CancelCallBack(cb: QTCallBack);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $00B9, $AAAA;
	{$ENDC}
{
***************************************
*										*
*  		C L O C K   C A L L B A C K  	*
*  		      S U P P O R T  			*
*										*
***************************************
}
FUNCTION AddCallBackToTimeBase(cb: QTCallBack): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0129, $AAAA;
	{$ENDC}
FUNCTION RemoveCallBackFromTimeBase(cb: QTCallBack): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $012A, $AAAA;
	{$ENDC}
FUNCTION GetFirstCallBack(tb: TimeBase): QTCallBack;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $012B, $AAAA;
	{$ENDC}
FUNCTION GetNextCallBack(cb: QTCallBack): QTCallBack;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $012C, $AAAA;
	{$ENDC}
PROCEDURE ExecuteCallBack(cb: QTCallBack);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $012D, $AAAA;
	{$ENDC}
{
***************************************
*										*
*  		S Y N C    T A S K S		  	*
*  		      S U P P O R T  			*
*										*
***************************************
}
FUNCTION QueueSyncTask(task: QTSyncTaskPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0203, $AAAA;
	{$ENDC}
FUNCTION DequeueSyncTask(qElem: QTSyncTaskPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0204, $AAAA;
	{$ENDC}
{  UPP call backs  }

CONST
	uppMovieRgnCoverProcInfo = $00000FE0;
	uppMovieProgressProcInfo = $0000FAE0;
	uppMovieDrawingCompleteProcInfo = $000003E0;
	uppTrackTransferProcInfo = $000003E0;
	uppGetMovieProcInfo = $00003FE0;
	uppMoviePreviewCallOutProcInfo = $000000D0;
	uppTextMediaProcInfo = $00003FE0;
	uppQTCallBackProcInfo = $000003C0;
	uppQTSyncTaskProcInfo = $000000C0;
	uppMCActionFilterProcInfo = $00000FD0;
	uppMCActionFilterWithRefConProcInfo = $00003ED0;

FUNCTION NewMovieRgnCoverProc(userRoutine: MovieRgnCoverProcPtr): MovieRgnCoverUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMovieProgressProc(userRoutine: MovieProgressProcPtr): MovieProgressUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMovieDrawingCompleteProc(userRoutine: MovieDrawingCompleteProcPtr): MovieDrawingCompleteUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTrackTransferProc(userRoutine: TrackTransferProcPtr): TrackTransferUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewGetMovieProc(userRoutine: GetMovieProcPtr): GetMovieUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMoviePreviewCallOutProc(userRoutine: MoviePreviewCallOutProcPtr): MoviePreviewCallOutUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewTextMediaProc(userRoutine: TextMediaProcPtr): TextMediaUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQTCallBackProc(userRoutine: QTCallBackProcPtr): QTCallBackUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQTSyncTaskProc(userRoutine: QTSyncTaskProcPtr): QTSyncTaskUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMCActionFilterProc(userRoutine: MCActionFilterProcPtr): MCActionFilterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewMCActionFilterWithRefConProc(userRoutine: MCActionFilterWithRefConProcPtr): MCActionFilterWithRefConUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallMovieRgnCoverProc(theMovie: Movie; changedRgn: RgnHandle; refcon: LONGINT; userRoutine: MovieRgnCoverUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMovieProgressProc(theMovie: Movie; message: INTEGER; whatOperation: INTEGER; percentDone: Fixed; refcon: LONGINT; userRoutine: MovieProgressUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMovieDrawingCompleteProc(theMovie: Movie; refCon: LONGINT; userRoutine: MovieDrawingCompleteUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallTrackTransferProc(t: Track; refCon: LONGINT; userRoutine: TrackTransferUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallGetMovieProc(offset: LONGINT; size: LONGINT; dataPtr: UNIV Ptr; refCon: UNIV Ptr; userRoutine: GetMovieUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMoviePreviewCallOutProc(refcon: LONGINT; userRoutine: MoviePreviewCallOutUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallTextMediaProc(theText: Handle; theMovie: Movie; VAR displayFlag: INTEGER; refcon: LONGINT; userRoutine: TextMediaUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQTCallBackProc(cb: QTCallBack; refCon: LONGINT; userRoutine: QTCallBackUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQTSyncTaskProc(task: UNIV Ptr; userRoutine: QTSyncTaskUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMCActionFilterProc(mc: MovieController; VAR action: INTEGER; params: UNIV Ptr; userRoutine: MCActionFilterUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallMCActionFilterWithRefConProc(mc: MovieController; action: INTEGER; params: UNIV Ptr; refCon: LONGINT; userRoutine: MCActionFilterWithRefConUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MoviesIncludes}

{$ENDC} {__MOVIES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

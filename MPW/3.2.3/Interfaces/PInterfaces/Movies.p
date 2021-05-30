
{
Created: Tuesday, October 13, 1992 at 12:36 PM
 Movies.p
 Pascal Interface to the Macintosh Libraries

  Copyright Apple Computer, Inc. 1991,1992
  All rights reserved

}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Movies;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingMovies}
{$SETC UsingMovies := 1}

{$I+}
{$SETC MoviesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingQuickDraw}
{$I $$Shell(PInterfaces)QuickDraw.p}
{$ENDC}
{$IFC UNDEFINED UsingAliases}
{$I $$Shell(PInterfaces)Aliases.p}
{$ENDC}
{$IFC UNDEFINED UsingEvents}
{$I $$Shell(PInterfaces)Events.p}
{$ENDC}
{$IFC UNDEFINED UsingMenus}
{$I $$Shell(PInterfaces)Menus.p}
{$ENDC}
{$IFC UNDEFINED UsingComponents}
{$I $$Shell(PInterfaces)Components.p}
{$ENDC}
{$IFC UNDEFINED UsingImageCompression}
{$I $$Shell(PInterfaces)ImageCompression.p}
{$ENDC}

{$SETC UsingIncludes := MoviesIncludes}

CONST
kFix1 = $10000;

gestaltQuickTime = 'qtim';

MovieFileType = 'MooV';

MediaHandlerType = 'mhlr';
DataHandlerType = 'dhlr';

VideoMediaType = 'vide';
SoundMediaType = 'soun';
TextMediaType = 'text';
GenericMediaType = 'gnrc';

DoTheRightThing = 0;

kFullVolume = $100;				{ 8.8 format }
kNoVolume = 0;


TYPE
Movie = ^MovieRecord;
MovieRecord = RECORD
 data: ARRAY [0..0] OF LONGINT;
 END;

Track = ^TrackRecord;
TrackRecord = RECORD
 data: ARRAY [0..0] OF LONGINT;
 END;

Media = ^MediaRecord;
MediaRecord = RECORD
 data: ARRAY [0..0] OF LONGINT;
 END;

UserData = ^UserDataRecord;
UserDataRecord = RECORD
 data: ARRAY [0..0] OF LONGINT;
 END;

TrackEditState = ^TrackEditStateRecord;
TrackEditStateRecord = RECORD
 data: ARRAY [0..0] OF LONGINT;
 END;

MovieEditState = ^MovieEditStateRecord;
MovieEditStateRecord = RECORD
 data: ARRAY [0..0] OF LONGINT;
 END;

SampleDescriptionPtr = ^SampleDescription;
SampleDescriptionHandle = ^SampleDescriptionPtr;
SampleDescription = RECORD
 descSize: LONGINT;
 dataFormat: LONGINT;
 resvd1:LONGINT;
 resvd2:INTEGER;
 dataRefIndex:INTEGER;
 END;

SoundDescriptionPtr = ^SoundDescription;
SoundDescriptionHandle = ^SoundDescriptionPtr;
SoundDescription = RECORD
 descSize: LONGINT;			{ total size of SoundDescription including extra data }
 dataFormat: LONGINT;
 resvd1: LONGINT;			{ reserved for apple use }
 resvd2: INTEGER;
 dataRefIndex: INTEGER;
 version: INTEGER;			{ which version is this data }
 revlevel: INTEGER;			{ what version of that codec did this }
 vendor: LONGINT;			{ whose  codec compressed this data }
 numChannels: INTEGER;		{ number of channels of sound }
 sampleSize: INTEGER;		{ number of bits per sample }
 compressionID: INTEGER;	{ sound compression used, 0 if none }
 packetSize: INTEGER;		{ packet size for compression, 0 if no compression }
 sampleRate: Fixed;			{ sample rate sound is captured at }
 END;

TextDescriptionPtr = ^TextDescription;
TextDescriptionHandle = ^TextDescriptionPtr;
TextDescription = RECORD
 descSize: LONGINT;
 dataFormat: LONGINT;

 resvd1:LONGINT;
 resvd2:INTEGER;
 dataRefIndex:INTEGER;

 displayFlags: LONGINT;
 textJustification: LONGINT;
	
 bgColor: RGBColor;
	
 defaultTextBox: Rect;
 defaultStyle: ScrpSTElement;
 END;

CONST

dfDontDisplay = 1;			{ Don't display the text}
dfDontAutoScale = 2;		{ Don't scale text as track bounds grows or shrinks}
dfClipToTextBox = 4;		{ Clip update to the textbox}
dfUseMovieBGColor = 8;		{ Set text background to movie's background color}
dfShrinkTextBoxToFit = 16;	{ Compute minimum box to fit the sample}
dfScrollIn = 32;			{ Scroll text in until last of text is in view }
dfScrollOut = 64;			{ Scroll text out until last of text is gone (if both set, scroll in then out)}
dfHorizScroll = 128;		{ Scroll text horizontally (otherwise it's vertical)}
dfReverseScroll = 256;		{ vert: scroll down rather than up; horiz: scroll backwards (justfication dependent)}

{ progress messages }
movieProgressOpen = 0;
movieProgressUpdatePercent = 1;
movieProgressClose = 2;


{ progress operations }
progressOpFlatten = 1;
progressOpInsertTrackSegment = 2;
progressOpInsertMovieSegment = 3;
progressOpPaste = 4;
progressOpAddMovieSelection = 5;
progressOpCopy = 6;
progressOpCut = 7;
progressOpLoadMovieIntoRam = 8;
progressOpLoadTrackIntoRam = 9;
progressOpLoadMediaIntoRam = 10;
progressOpImportMovie = 11;
progressOpExportMovie = 12;

{ media quality settings }
mediaQualityDraft = $0000;
mediaQualityNormal = $0040;
mediaQualityBetter = $0080;
mediaQualityBest = $00C0;

TYPE
MovieRgnCoverProc = ProcPtr;
MovieProgressProcPtr = ProcPtr;


MediaHandler = ComponentInstance;
MediaHandlerComponent = Component;
DataHandler = ComponentInstance;
DataHandlerComponent = Component;
HandlerError = ComponentResult;

TimeValue = LONGINT;
TimeScale = LONGINT;

Int64 = RECORD
 hi: LONGINT;
 lo: LONGINT;
 END;
 
CompTimeValue = Int64;

CONST
loopTimeBase = 1;
palindromeLoopTimeBase = 2;

TYPE
{ TimeBase Routines }
TimeBaseFlags = LONGINT;

TimeBase = ^TimeBaseRecord;
TimeBaseRecord = RECORD
 data: ARRAY [0..0] OF LONGINT;
 END;

QTCallBack = ^CallBackRecord;
CallBackRecord = RECORD
 data: ARRAY [0..0] OF LONGINT;
 END;


TimeRecord = RECORD
 value: CompTimeValue;
 scale: TimeScale;
 base: TimeBase;
 END;


CONST
triggerTimeFwd 		= $0001;		{ when curTime exceeds triggerTime going forward }
triggerTimeBwd 		= $0002;		{ when curTime exceeds triggerTime going backwards }
triggerTimeEither 	= $0003;		{ when curTime exceeds triggerTime going either direction }
triggerRateLT 		= $0004;		{ when rate changes to less than trigger value }
triggerRateGT 		= $0008;		{ when rate changes to greater than trigger value }
triggerRateEqual 	= $0010;	{ when rate changes to equal trigger value }
triggerRateLTE 		= $0014;
triggerRateGTE 		= $0018;
triggerRateNotEqual = $001C;
triggerRateChange 	= 0;
triggerAtStart		= $0001;
triggerAtStop		= $0002;

TYPE
QTCallBackFlags = Byte;

CONST
timeBaseBeforeStartTime = 1;
timeBaseAfterStopTime = 2;

TYPE
TimeBaseStatus = LONGINT;

CONST
callBackAtTime 		= 1;
callBackAtRate 		= 2;
callBackAtTimeJump 	= 3;
callBackAtExtremes 	= 4;
callBackAtInterrupt = $8000;

TYPE
QTCallBackType = Byte;
QTCallBackProc = ProcPtr;

CONST
qtcbNeedsRateChanges 		= 1;
qtcbNeedsTimeChanges 		= 2;
qtcbNeedsStartStopChanges 	= 4;

TYPE
{ CallBack equates }
QTCallBackHeader = RECORD
 callBackFlags	: LONGINT;
 reserved1		: LONGINT;
 qtPrivate		: PACKED ARRAY [0..39] OF Byte;
 END;


CONST 
{ loadintoram flags }
keepInRam = 1;
unkeepInRam = 2;
flushFromRam = 4;
loadForwardTrackEdits = 8;
loadBackwardTrackEdits = 16;

TYPE
MoviePreviewCallOutProc = ProcPtr;
MovieController = ComponentInstance;

CONST
newMovieActive = $1;
newMovieDontResolveDataRefs = $2;
newMovieDontAskUnresolvedDataRefs = $4;
newMovieDontAutoAlternates = $8;

trackUsageInMovie = $2;
trackUsageInPreview = $4;
trackUsageInPoster = $8;

mediaSampleNotSync = 1;
mediaSampleShadowSync = 2;

pasteInParallel = 1;

nextTimeMediaSample = $1;
nextTimeMediaEdit = $2;
nextTimeTrackEdit = $4;
nextTimeSyncSample = $8;
nextTimeEdgeOK = $2000;
nextTimeIgnoreActiveSegment = $4000;

TYPE 
nextTimeFlagsEnum = Byte;

CONST
createMovieFileDeleteCurFile = $80000000;
createMovieFileDontCreateMovie = $40000000;
createMovieFileDontOpenFile = $20000000;

TYPE 
createMovieFileFlagsEnum = LONGINT;

CONST
flattenAddMovieToDataFork = $1;
flattenActiveTracksOnly = $4;
flattenDontInterleaveFlatten = $8;

TYPE
movieFlattenFlagsEnum = LONGINT;

CONST
movieInDataForkResID = -1; 	{ magic res id }

movieScrapDontZeroScrap = $1;
movieScrapOnlyPutMovie = $2;


hintsScrubMode = $1;
hintsUseScreenBuffer = $20;
hintsAllowInterlace = $40;
hintsUseSoundLerp = $80;

TYPE
playHintsEnum = LONGINT;

CONST
mediaHandlerFlagGenericClient = 1;

TYPE
mediaHandlerFlagsEnum = LONGINT;

{  Initialization Routines  }
FUNCTION EnterMovies: OSErr;
 INLINE $303C,$1,$AAAA;
PROCEDURE ExitMovies;
 INLINE $303C,$2,$AAAA;

{  error Routines  }

TYPE
ErrorProcPtr = ProcPtr;

FUNCTION GetMoviesError: OSErr;
 INLINE $303C,$3,$AAAA;
PROCEDURE ClearMoviesStickyError;
 INLINE $303C,$DE,$AAAA;
FUNCTION GetMoviesStickyError: OSErr;
 INLINE $303C,$4,$AAAA;
PROCEDURE SetMoviesErrorProc(errProc: ErrorProcPtr;refcon: LONGINT);
 INLINE $303C,$EF,$AAAA;



{  Idle Routines  }
PROCEDURE MoviesTask(m: Movie;maxMilliSecToUse: LONGINT);
 INLINE $303C,$5,$AAAA;
FUNCTION PrerollMovie(m: Movie;time: TimeValue;Rate: Fixed): OSErr;
 INLINE $303C,$6,$AAAA;
FUNCTION LoadMovieIntoRam(m: Movie;time: TimeValue;duration: TimeValue;
 flags: LONGINT): OSErr;
 INLINE $303C,$7,$AAAA;
FUNCTION LoadTrackIntoRam(t: Track;time: TimeValue;duration: TimeValue;
 flags: LONGINT): OSErr;
 INLINE $303C,$16E,$AAAA;
FUNCTION LoadMediaIntoRam(m: Media;time: TimeValue;duration: TimeValue;
 flags: LONGINT): OSErr;
 INLINE $303C,$8,$AAAA;

PROCEDURE SetMovieActive(m: Movie;active: BOOLEAN);
 INLINE $303C,$9,$AAAA;
FUNCTION GetMovieActive(m: Movie): BOOLEAN;
 INLINE $303C,$A,$AAAA;

{ Calls for playing movies }
PROCEDURE StartMovie(m: Movie);
 INLINE $303C,$B,$AAAA;
PROCEDURE StopMovie(m: Movie);
 INLINE $303C,$C,$AAAA;
PROCEDURE GoToBeginningOfMovie(m: Movie);
 INLINE $303C,$D,$AAAA;
PROCEDURE GoToEndOfMovie(m: Movie);
 INLINE $303C,$E,$AAAA;
FUNCTION IsMovieDone(m: Movie): BOOLEAN;
 INLINE $303C,$DD,$AAAA;

FUNCTION GetMoviePreviewMode(m: Movie): BOOLEAN;
 INLINE $303C,$F,$AAAA;
PROCEDURE SetMoviePreviewMode(m: Movie;usePreview: BOOLEAN);
 INLINE $303C,$10,$AAAA;
PROCEDURE ShowMoviePoster(m: Movie);
 INLINE $303C,$11,$AAAA;
PROCEDURE PlayMoviePreview(m: Movie;callOutProc: MoviePreviewCallOutProc;
 refcon: LONGINT);
 INLINE $303C,$F2,$AAAA;

{ calls for controlling movies & tracks which are playing }
{  movie TimeBase Routines  }
FUNCTION GetMovieTimeBase(m: Movie): TimeBase;
 INLINE $303C,$12,$AAAA;

PROCEDURE SetMovieMasterTimeBase(m: Movie;tb: TimeBase;slaveZero: TimeRecord);
 INLINE $303C,$167,$AAAA;
PROCEDURE SetMovieMasterClock(m: Movie;clockMeister: Component;slaveZero: TimeRecord);
 INLINE $303C,$168,$AAAA;


PROCEDURE GetMovieGWorld(m: Movie;VAR port: CGrafPtr;VAR gdh: GDHandle);
 INLINE $303C,$15,$AAAA;
PROCEDURE SetMovieGWorld(m: Movie;port: CGrafPtr;gdh: GDHandle);
 INLINE $303C,$16,$AAAA;

{  Movie PICT Routines  }
FUNCTION GetMoviePict(m: Movie;time: TimeValue): PicHandle;
 INLINE $303C,$1D,$AAAA;
FUNCTION GetTrackPict(t: Track;time: TimeValue): PicHandle;
 INLINE $303C,$1E,$AAAA;

FUNCTION GetMoviePosterPict(m: Movie): PicHandle;
 INLINE $303C,$F7,$AAAA;

FUNCTION UpdateMovie(m: Movie): OSErr;
 INLINE $303C,$1F,$AAAA;


{  spatial movie Routines  }
PROCEDURE GetMovieBox(m: Movie;VAR boxRect: Rect);
 INLINE $303C,$F9,$AAAA;
PROCEDURE SetMovieBox(m: Movie;boxRect: Rect);
 INLINE $303C,$FA,$AAAA;


{  movie display clip  }
FUNCTION GetMovieDisplayClipRgn(m: Movie): RgnHandle;
 INLINE $303C,$FC,$AAAA;
PROCEDURE SetMovieDisplayClipRgn(m: Movie;theClip: RgnHandle);
 INLINE $303C,$FD,$AAAA;


{  movie clip  }
FUNCTION GetMovieClipRgn(m: Movie): RgnHandle;
 INLINE $303C,$100,$AAAA;
PROCEDURE SetMovieClipRgn(m: Movie;theClip: RgnHandle);
 INLINE $303C,$101,$AAAA;


{  track clip  }
FUNCTION GetTrackClipRgn(t: Track): RgnHandle;
 INLINE $303C,$102,$AAAA;
PROCEDURE SetTrackClipRgn(t: Track;theClip: RgnHandle);
 INLINE $303C,$103,$AAAA;


{  bounds in display space  }
FUNCTION GetMovieDisplayBoundsRgn(m: Movie): RgnHandle;
 INLINE $303C,$FB,$AAAA;
FUNCTION GetTrackDisplayBoundsRgn(t: Track): RgnHandle;
 INLINE $303C,$112,$AAAA;


{  bounds in movie space  }
FUNCTION GetMovieBoundsRgn(m: Movie): RgnHandle;
 INLINE $303C,$FE,$AAAA;
FUNCTION GetTrackMovieBoundsRgn(t: Track): RgnHandle;
 INLINE $303C,$FF,$AAAA;


{  bounds in track space  }
FUNCTION GetTrackBoundsRgn(t: Track): RgnHandle;
 INLINE $303C,$111,$AAAA;

{  mattes - always in track space  }
FUNCTION GetTrackMatte(t: Track): PixMapHandle;
 INLINE $303C,$115,$AAAA;
PROCEDURE SetTrackMatte(t: Track;theMatte: PixMapHandle);
 INLINE $303C,$116,$AAAA;
PROCEDURE DisposeMatte(theMatte: PixMapHandle);
 INLINE $303C,$14A,$AAAA;


FUNCTION NewMovie(newMovieFlags: LONGINT): Movie;
 INLINE $303C,$187,$AAAA;
FUNCTION PutMovieIntoHandle(m: Movie;h: Handle): OSErr;
 INLINE $303C,$22,$AAAA;
FUNCTION PutMovieIntoDataFork(m: Movie; fRefNum: INTEGER; offset: LONGINT; maxSize: LONGINT): OSErr;
 INLINE $303C,$1B4,$AAAA;
PROCEDURE DisposeMovie(m: Movie);
 INLINE $303C,$23,$AAAA;


{  Movie Routines  }
FUNCTION GetMovieCreationTime(m: Movie): LONGINT;
 INLINE $303C,$26,$AAAA;
FUNCTION GetMovieModificationTime(m: Movie): LONGINT;
 INLINE $303C,$27,$AAAA;

FUNCTION GetMovieTimeScale(m: Movie): TimeScale;
 INLINE $303C,$29,$AAAA;
PROCEDURE SetMovieTimeScale(m: Movie;timeScale: TimeScale);
 INLINE $303C,$2A,$AAAA;

FUNCTION GetMovieDuration(m: Movie): TimeValue;
 INLINE $303C,$2B,$AAAA;

FUNCTION GetMovieRate(m: Movie): Fixed;
 INLINE $303C,$2C,$AAAA;
PROCEDURE SetMovieRate(m: Movie;rate: Fixed);
 INLINE $303C,$2D,$AAAA;

FUNCTION GetMoviePreferredRate(m: Movie): Fixed;
 INLINE $303C,$F3,$AAAA;
PROCEDURE SetMoviePreferredRate(m: Movie;rate: Fixed);
 INLINE $303C,$F4,$AAAA;

FUNCTION GetMoviePreferredVolume(m: Movie): INTEGER;
 INLINE $303C,$F5,$AAAA;
PROCEDURE SetMoviePreferredVolume(m: Movie;volume: INTEGER);
 INLINE $303C,$F6,$AAAA;

FUNCTION GetMovieVolume(m: Movie): INTEGER;
 INLINE $303C,$2E,$AAAA;
PROCEDURE SetMovieVolume(m: Movie;volume: INTEGER);
 INLINE $303C,$2F,$AAAA;

PROCEDURE GetMovieMatrix(m: Movie;VAR matrix: MatrixRecord);
 INLINE $303C,$31,$AAAA;
PROCEDURE SetMovieMatrix(m: Movie;matrix: MatrixRecord);
 INLINE $303C,$32,$AAAA;

PROCEDURE GetMoviePreviewTime(m: Movie;VAR previewTime: TimeValue;VAR previewDuration: TimeValue);
 INLINE $303C,$33,$AAAA;
PROCEDURE SetMoviePreviewTime(m: Movie;previewTime: TimeValue;previewDuration: TimeValue);
 INLINE $303C,$34,$AAAA;

FUNCTION GetMoviePosterTime(m: Movie): TimeValue;
 INLINE $303C,$35,$AAAA;
PROCEDURE SetMoviePosterTime(m: Movie;posterTime: TimeValue);
 INLINE $303C,$36,$AAAA;

PROCEDURE GetMovieSelection(m: Movie;VAR selectionTime: TimeValue;VAR selectionDuration: TimeValue);
 INLINE $303C,$37,$AAAA;
PROCEDURE SetMovieSelection(m: Movie;selectionTime: TimeValue;selectionDuration: TimeValue);
 INLINE $303C,$38,$AAAA;

PROCEDURE SetMovieActiveSegment(m: Movie;startTime: TimeValue;duration: TimeValue);
 INLINE $303C,$15C,$AAAA;
PROCEDURE GetMovieActiveSegment(m: Movie;VAR startTime: TimeValue;VAR duration: TimeValue);
 INLINE $303C,$15D,$AAAA;

FUNCTION GetMovieTime(m: Movie;VAR currentTime: TimeRecord): TimeValue;
 INLINE $303C,$39,$AAAA;
PROCEDURE SetMovieTime(m: Movie;newtime: TimeRecord);
 INLINE $303C,$3C,$AAAA;
PROCEDURE SetMovieTimeValue(m: Movie;newtime: TimeValue);
 INLINE $303C,$3D,$AAAA;
FUNCTION GetMovieUserData(m: Movie): UserData;
 INLINE $303C,$3E,$AAAA;

{  Movie/Track/Media finding Routines  }
FUNCTION GetMovieTrackCount(m: Movie): LONGINT;
 INLINE $303C,$3F,$AAAA;
FUNCTION GetMovieTrack(m: Movie;trackID: LONGINT): Track;
 INLINE $303C,$40,$AAAA;

FUNCTION GetMovieIndTrack(m: Movie;index: LONGINT): Track;
 INLINE $303C,$117,$AAAA;

FUNCTION GetTrackID(t: Track): LONGINT;
 INLINE $303C,$127,$AAAA;

FUNCTION GetTrackMovie(t: Track): Movie;
 INLINE $303C,$D0,$AAAA;


{  Track creation Routines  }
FUNCTION NewMovieTrack(m: Movie;width: Fixed;height: Fixed;trackVolume: INTEGER): Track;
 INLINE $303C,$188,$AAAA;
PROCEDURE DisposeMovieTrack(t: Track);
 INLINE $303C,$42,$AAAA;


{  Track Routines  }
FUNCTION GetTrackCreationTime(t: Track): LONGINT;
 INLINE $303C,$43,$AAAA;
FUNCTION GetTrackModificationTime(t: Track): LONGINT;
 INLINE $303C,$44,$AAAA;

FUNCTION GetTrackEnabled(t: Track): BOOLEAN;
 INLINE $303C,$45,$AAAA;
PROCEDURE SetTrackEnabled(t: Track;isEnabled: BOOLEAN);
 INLINE $303C,$46,$AAAA;

FUNCTION GetTrackUsage(t: Track): LONGINT;
 INLINE $303C,$47,$AAAA;
PROCEDURE SetTrackUsage(t: Track;usage: LONGINT);
 INLINE $303C,$48,$AAAA;

FUNCTION GetTrackDuration(t: Track): TimeValue;
 INLINE $303C,$4B,$AAAA;

FUNCTION GetTrackOffset(t: Track): TimeValue;
 INLINE $303C,$4C,$AAAA;
PROCEDURE SetTrackOffset(t: Track;offset: TimeValue);
 INLINE $303C,$4D,$AAAA;

FUNCTION GetTrackLayer(t: Track): INTEGER;
 INLINE $303C,$50,$AAAA;
PROCEDURE SetTrackLayer(t: Track;layer: INTEGER);
 INLINE $303C,$51,$AAAA;

FUNCTION GetTrackAlternate(t: Track): Track;
 INLINE $303C,$52,$AAAA;
PROCEDURE SetTrackAlternate(t: Track;alternateT: Track);
 INLINE $303C,$53,$AAAA;

PROCEDURE SetAutoTrackAlternatesEnabled(m: Movie;enable: BOOLEAN);
 INLINE $303C,$15E,$AAAA;
PROCEDURE SelectMovieAlternates(m: Movie);
 INLINE $303C,$15F,$AAAA;

FUNCTION GetTrackVolume(t: Track): INTEGER;
 INLINE $303C,$54,$AAAA;
PROCEDURE SetTrackVolume(t: Track;volume: INTEGER);
 INLINE $303C,$55,$AAAA;

PROCEDURE GetTrackMatrix(t: Track;VAR matrix: MatrixRecord);
 INLINE $303C,$56,$AAAA;
PROCEDURE SetTrackMatrix(t: Track;matrix: MatrixRecord);
 INLINE $303C,$57,$AAAA;

PROCEDURE GetTrackDimensions(t: Track;VAR width: Fixed;VAR height: Fixed);
 INLINE $303C,$5D,$AAAA;
PROCEDURE SetTrackDimensions(t: Track;width: Fixed;height: Fixed);
 INLINE $303C,$5E,$AAAA;

FUNCTION GetTrackUserData(t: Track): UserData;
 INLINE $303C,$5F,$AAAA;


{  Media creation Routines  }
FUNCTION NewTrackMedia(t: Track;mediaType: OSType;timeScale: TimeScale;
 dataRef: Handle;dataRefType: OSType): Media;
 INLINE $303C,$18E,$AAAA;
PROCEDURE DisposeTrackMedia(m: Media);
 INLINE $303C,$61,$AAAA;
FUNCTION GetTrackMedia(t: Track): Media;
 INLINE $303C,$62,$AAAA;
FUNCTION GetMediaTrack(m: Media): Track;
 INLINE $303C,$C5,$AAAA;


{  Media Routines  }
FUNCTION GetMediaCreationTime(m: Media): LONGINT;
 INLINE $303C,$66,$AAAA;
FUNCTION GetMediaModificationTime(m: Media): LONGINT;
 INLINE $303C,$67,$AAAA;

FUNCTION GetMediaTimeScale(m: Media): TimeScale;
 INLINE $303C,$68,$AAAA;
PROCEDURE SetMediaTimeScale(m: Media;timeScale: TimeScale);
 INLINE $303C,$69,$AAAA;

FUNCTION GetMediaDuration(m: Media): TimeValue;
 INLINE $303C,$6A,$AAAA;

FUNCTION GetMediaLanguage(m: Media): INTEGER;
 INLINE $303C,$6B,$AAAA;
PROCEDURE SetMediaLanguage(m: Media;language: INTEGER);
 INLINE $303C,$6C,$AAAA;

FUNCTION GetMediaQuality(m: Media): INTEGER;
 INLINE $303C,$6D,$AAAA;
PROCEDURE SetMediaQuality(m: Media;quality: INTEGER);
 INLINE $303C,$6E,$AAAA;
PROCEDURE GetMediaHandlerDescription(m: Media;VAR mediaType: OSType;VAR creatorName: Str255;
 VAR creatorManufacturer: OSType);
 INLINE $303C,$6F,$AAAA;

FUNCTION GetMediaUserData(m: Media): UserData;
 INLINE $303C,$70,$AAAA;

{  Media Handler Routines  }
FUNCTION GetMediaHandler(m: Media): MediaHandler;
 INLINE $303C,$71,$AAAA;
FUNCTION SetMediaHandler(m: Media;mH: MediaHandlerComponent): OSErr;
 INLINE $303C,$190,$AAAA;

{ Media's Data Routines }
FUNCTION BeginMediaEdits(m: Media): OSErr;
 INLINE $303C,$72,$AAAA;
FUNCTION EndMediaEdits(m: Media): OSErr;
 INLINE $303C,$73,$AAAA;
PROCEDURE GetMediaDataHandlerDescription(m: Media;index: INTEGER;VAR dhType: OSType;
	VAR creatorName: Str255;VAR creatorManufacturer: OSType);
	INLINE $303C,$19E,$AAAA;
{  Media data handler Routines  }
FUNCTION GetMediaDataHandler(m: Media;index: INTEGER): DataHandler;
 INLINE $303C,$19F,$AAAA;
FUNCTION SetMediaDataHandler(m: Media;index: INTEGER; dataHandler: DataHandlerComponent): OSErr;
 INLINE $303C,$1A0,$AAAA;

{  Media sample Routines  }
FUNCTION GetMediaSampleDescriptionCount(m: Media): LONGINT;
 INLINE $303C,$77,$AAAA;
PROCEDURE GetMediaSampleDescription(m: Media;index: LONGINT;descH: SampleDescriptionHandle);
 INLINE $303C,$78,$AAAA;
FUNCTION GetMediaSampleCount(m: Media): LONGINT;
 INLINE $303C,$79,$AAAA;
PROCEDURE SampleNumToMediaTime(m: Media;logicalSampleNum: LONGINT;VAR sampleTime: TimeValue;
 VAR sampleDuration: TimeValue);
 INLINE $303C,$7A,$AAAA;
PROCEDURE MediaTimeToSampleNum(m: Media;time: TimeValue;VAR sampleNum: LONGINT;
 VAR sampleTime: TimeValue;VAR sampleDuration: TimeValue);
 INLINE $303C,$7B,$AAAA;
FUNCTION AddMediaSample(m: Media;dataIn: Handle;inOffset: LONGINT;size: LONGINT;
 durationPerSample: TimeValue;sampleDescriptionH: SampleDescriptionHandle;
 numberOfSamples: LONGINT;sampleFlags: INTEGER;VAR sampleTime: TimeValue): OSErr;
 INLINE $303C,$7C,$AAAA;
FUNCTION AddMediaSampleReference(m: Media;dataOffset: LONGINT;size: LONGINT;
 durationPerSample: TimeValue;sampleDescriptionH: SampleDescriptionHandle;
 numberOfSamples: LONGINT;sampleFlags: INTEGER;VAR sampleTime: TimeValue): OSErr;
 INLINE $303C,$7D,$AAAA;
FUNCTION GetMediaSample(m: Media;dataOut: Handle;maxSizeToGrow: LONGINT;
 VAR size: LONGINT;time: TimeValue;VAR sampleTime: TimeValue;VAR durationPerSample: TimeValue;
 sampleDescriptionH: SampleDescriptionHandle;VAR sampleDescriptionIndex: LONGINT;
 maxNumberOfSamples: LONGINT;VAR numberOfSamples: LONGINT;VAR sampleFlags: INTEGER): OSErr;
 INLINE $303C,$7E,$AAAA;
FUNCTION GetMediaSampleReference(m: Media;VAR dataOffset: LONGINT;VAR size: LONGINT;
 time: TimeValue;VAR sampleTime: TimeValue;VAR durationPerSample: TimeValue;
 sampleDescriptionH: SampleDescriptionHandle;VAR sampleDescriptionIndex: LONGINT;
 maxNumberOfSamples: LONGINT;VAR numberOfSamples: LONGINT;VAR sampleFlags: INTEGER): OSErr;
 INLINE $303C,$7F,$AAAA;

FUNCTION SetMediaShadowSync(m: Media; frameDiffSampleNum: LONGINT; syncSampleNum: LONGINT): OSErr;
 INLINE $303C,$121,$AAAA;
FUNCTION GetMediaShadowSync(m: Media; frameDiffSampleNum: LONGINT; VAR syncSampleNum: LONGINT): OSErr;
 INLINE $303C,$122,$AAAA;

{  low-level Editing Routines  }
FUNCTION InsertMediaIntoTrack(t: Track;trackStart: TimeValue;mediaTime: TimeValue;
 mediaDuration: TimeValue;mediaRate: Fixed): OSErr;
 INLINE $303C,$183,$AAAA;

{  Middle-level Editing Routines  }
FUNCTION InsertTrackSegment(srcTrack: Track;dstTrack: Track;srcIn: TimeValue;
 srcDuration: TimeValue;dstIn: TimeValue): OSErr;
 INLINE $303C,$85,$AAAA;
FUNCTION InsertMovieSegment(srcMovie: Movie;dstMovie: Movie;srcIn: TimeValue;
 srcDuration: TimeValue;dstIn: TimeValue): OSErr;
 INLINE $303C,$86,$AAAA;
FUNCTION InsertEmptyTrackSegment(dstTrack: Track;dstIn: TimeValue;dstDuration: TimeValue): OSErr;
 INLINE $303C,$87,$AAAA;
FUNCTION InsertEmptyMovieSegment(dstMovie: Movie;dstIn: TimeValue;dstDuration: TimeValue): OSErr;
 INLINE $303C,$88,$AAAA;
FUNCTION DeleteTrackSegment(t: Track;dstIn: TimeValue;duration: TimeValue): OSErr;
 INLINE $303C,$89,$AAAA;
FUNCTION DeleteMovieSegment(m: Movie;dstIn: TimeValue;duration: TimeValue): OSErr;
 INLINE $303C,$8A,$AAAA;
FUNCTION ScaleTrackSegment(t: Track;dstIn: TimeValue;oldDuration: TimeValue;
 newDuration: TimeValue): OSErr;
 INLINE $303C,$8B,$AAAA;
FUNCTION ScaleMovieSegment(m: Movie;dstIn: TimeValue;oldDuration: TimeValue;
 newDuration: TimeValue): OSErr;
 INLINE $303C,$8C,$AAAA;

{  High level editing Routines  }
FUNCTION CutMovieSelection(m: Movie): Movie;
 INLINE $303C,$8D,$AAAA;
FUNCTION CopyMovieSelection(m: Movie): Movie;
 INLINE $303C,$8E,$AAAA;
PROCEDURE PasteMovieSelection(m: Movie;src: Movie);
 INLINE $303C,$8F,$AAAA;
PROCEDURE AddMovieSelection(m: Movie;src: Movie);
 INLINE $303C,$152,$AAAA;
PROCEDURE ClearMovieSelection(m: Movie);
 INLINE $303C,$E1,$AAAA;
FUNCTION PasteHandleIntoMovie(h: Handle; handleType: OSType; m: Movie; flags: LONGINT; userComp: ComponentInstance): OSErr;
 INLINE $303C,$CB,$AAAA;
FUNCTION PutMovieIntoTypedHandle(m: Movie; targetTrack: Track; handleType: OSType; publicMovie: Handle;
 start: TimeValue; dur: TimeValue; flags: LONGINT; userComp: ComponentInstance): OSErr;
 INLINE $303C,$1CD,$AAAA;
FUNCTION IsScrapMovie(targetTrack: Track): Component;
 INLINE $303C,$CC,$AAAA;

FUNCTION CopyTrackSettings(srcTrack: Track;dstTrack: Track): OSErr;
 INLINE $303C,$153,$AAAA;
FUNCTION CopyMovieSettings(srcMovie: Movie;dstMovie: Movie): OSErr;
 INLINE $303C,$154,$AAAA;

{  movie & track edit state Routines  }
FUNCTION NewMovieEditState(m: Movie): MovieEditState;
 INLINE $303C,$104,$AAAA;
FUNCTION UseMovieEditState(m: Movie;toState: MovieEditState): OSErr;
 INLINE $303C,$105,$AAAA;
FUNCTION DisposeMovieEditState(state: MovieEditState): OSErr;
 INLINE $303C,$106,$AAAA;

FUNCTION NewTrackEditState(t: Track): TrackEditState;
 INLINE $303C,$107,$AAAA;
FUNCTION UseTrackEditState(t: Track;state: TrackEditState): OSErr;
 INLINE $303C,$108,$AAAA;
FUNCTION DisposeTrackEditState(state: TrackEditState): OSErr;
 INLINE $303C,$109,$AAAA;

FUNCTION ConvertFileToMovieFile(inputFile: FSSpec; outputFile: FSSpec; creator: OSType;
 scriptTag: ScriptCode; VAR resID: INTEGER; flags: LONGINT; userComp: ComponentInstance;
 proc: ProcPtr; refCon: LONGINT): OSErr;
 INLINE $303C,$1CB,$AAAA;
FUNCTION ConvertMovieToFile(theMovie: Movie; onlyTrack: Track; outputFile: FSSpec;
 fileType: OSType; creator: OSType; scriptTag: ScriptCode; VAR resID: INTEGER;
 flags: LONGINT; userComp: ComponentInstance): OSErr;
 INLINE $303C,$1CC,$AAAA;

{  Miscellaneous Routines  }
FUNCTION TrackTimeToMediaTime(value: TimeValue;t: Track): TimeValue;
 INLINE $303C,$96,$AAAA;
FUNCTION GetTrackEditRate(t: Track;atTime: TimeValue): Fixed;
 INLINE $303C,$123,$AAAA;

FUNCTION GetMovieDataSize(m: Movie;startTime: TimeValue;duration: TimeValue): LONGINT;
 INLINE $303C,$98,$AAAA;
FUNCTION GetTrackDataSize(t: Track;startTime: TimeValue;duration: TimeValue): LONGINT;
 INLINE $303C,$149,$AAAA;
FUNCTION GetMediaDataSize(m: Media;startTime: TimeValue;duration: TimeValue): LONGINT;
 INLINE $303C,$99,$AAAA;

FUNCTION PtInMovie(m: Movie;pt: Point): BOOLEAN;
 INLINE $303C,$9A,$AAAA;
FUNCTION PtInTrack(t: Track;pt: Point): BOOLEAN;
 INLINE $303C,$9B,$AAAA;


{  Alternate Group Selection Routines  }
PROCEDURE SetMovieLanguage(m: Movie;language: LONGINT);
 INLINE $303C,$9C,$AAAA;


{  UserData Routines  }
FUNCTION GetUserData(u: UserData;data: Handle;udType: OSType;index: LONGINT): OSErr;
 INLINE $303C,$9E,$AAAA;
FUNCTION AddUserData(u: UserData;data: Handle;udType: OSType): OSErr;
 INLINE $303C,$9F,$AAAA;
FUNCTION RemoveUserData(u: UserData;udType: OSType;index: LONGINT): OSErr;
 INLINE $303C,$A0,$AAAA;
FUNCTION CountUserDataType(userDataH: UserData;udType: OSType): INTEGER;
 INLINE $303C,$14B,$AAAA;
{ New UserData routines }
FUNCTION GetNextUserDataType(userDataH: UserData;udType: OSType): OSType;
 INLINE $303C,$1A5,$AAAA;
FUNCTION GetUserDataItem(userDataH: UserData;data: Ptr;size: LONGINT;dataType: OSType;index: LONGINT): OSErr;
 INLINE $303C,$126,$AAAA;
FUNCTION SetUserDataItem(userDataH: UserData;data: Ptr;size: LONGINT;dataType: OSType;index: LONGINT): OSErr;
 INLINE $303C,$12E,$AAAA;


FUNCTION AddUserDataText(u: UserData;data: Handle;udType: OSType;index: LONGINT;
 itlRegionTag: INTEGER): OSErr;
 INLINE $303C,$14C,$AAAA;
FUNCTION GetUserDataText(u: UserData;data: Handle;udType: OSType;index: LONGINT;
 itlRegionTag: INTEGER): OSErr;
 INLINE $303C,$14D,$AAAA;
FUNCTION RemoveUserDataText(u: UserData;udType: OSType;index: LONGINT;itlRegionTag: INTEGER): OSErr;
 INLINE $303C,$14E,$AAAA;

FUNCTION NewUserData(VAR ud: UserData): OSErr;
 INLINE $303C,$12F,$AAAA;
FUNCTION DisposeUserData(ud: UserData): OSErr;
 INLINE $303C,$130,$AAAA;
FUNCTION NewUserDataFromHandle(h: Handle; VAR ud: UserData): OSErr;
 INLINE $303C,$131,$AAAA;
FUNCTION PutUserDataIntoHandle(ud: UserData; h: Handle): OSErr;
 INLINE $303C,$132,$AAAA;


{  interesting time Routines  }
PROCEDURE GetMediaNextInterestingTime(m: Media;interestingTimeFlags: INTEGER;
 time: TimeValue;rate: Fixed;VAR interestingTime: TimeValue;VAR interestingDuration: TimeValue);
 INLINE $303C,$16D,$AAAA;
PROCEDURE GetTrackNextInterestingTime(t: Track;interestingTimeFlags: INTEGER;
 time: TimeValue;rate: Fixed;VAR interestingTime: TimeValue;VAR interestingDuration: TimeValue);
 INLINE $303C,$E2,$AAAA;
PROCEDURE GetMovieNextInterestingTime(m: Movie;interestingTimeFlags: INTEGER;
 numMediaTypes: INTEGER; whichMediaTypes: OSTypePtr;time: TimeValue;rate: Fixed;
 VAR interestingTime: TimeValue;VAR interestingDuration: TimeValue);
 INLINE $303C,$10E,$AAAA;


{  movie file Routines  }
FUNCTION CreateMovieFile(fileSpec: FSSpec;creator: OSType;scriptTag: ScriptCode;
 createMovieFileFlags: LONGINT;VAR resRefNum: INTEGER;VAR newMovie: Movie): OSErr;
 INLINE $303C,$191,$AAAA;

FUNCTION OpenMovieFile(fileSpec: FSSpec;VAR resRefNum: INTEGER;perms: SignedByte): OSErr;
 INLINE $303C,$192,$AAAA;
FUNCTION CloseMovieFile(resRefNum: INTEGER): OSErr;
 INLINE $303C,$D5,$AAAA;

FUNCTION DeleteMovieFile(fileSpec: FSSpec): OSErr;
 INLINE $303C,$175,$AAAA;

FUNCTION NewMovieFromFile(VAR m: Movie;resRefNum: INTEGER;VAR resId: INTEGER;
 resName: STR255;newMovieFlags: INTEGER;VAR dataRefWasChanged: BOOLEAN): OSErr;
 INLINE $303C,$F0,$AAAA;
{  movie creation Routines  }
FUNCTION NewMovieFromHandle(VAR m:Movie; h: Handle;newMovieFlags: INTEGER;VAR dataRefWasChanged: BOOLEAN): OSErr;
 INLINE $303C,$F1,$AAAA;
FUNCTION NewMovieFromDataFork(VAR m:Movie; fRefNum: INTEGER; fileOffset: LONGINT;
 flags: INTEGER; VAR dataRefWasChanged: BOOLEAN): OSErr;
 INLINE $303C,$110,$AAAA;

FUNCTION AddMovieResource(m: Movie;resRefNum: INTEGER;VAR resId: INTEGER;
 resName: STR255): OSErr;
 INLINE $303C,$D7,$AAAA;
FUNCTION RemoveMovieResource(resRefNum: INTEGER;resId: INTEGER): OSErr;
 INLINE $303C,$176,$AAAA;
FUNCTION UpdateMovieResource(m: Movie;resRefNum: INTEGER;resId: INTEGER;
 resName: STR255): OSErr;
 INLINE $303C,$D8,$AAAA;

FUNCTION HasMovieChanged(m: Movie): BOOLEAN;
 INLINE $303C,$D9,$AAAA;
PROCEDURE ClearMovieChanged(m: Movie);
 INLINE $303C,$113,$AAAA;

FUNCTION SetMovieDefaultDataRef(theMovie:Movie; dataRef:Handle; dataRefType:OSType):OSErr;
 INLINE $303C,$1C1,$AAAA;
FUNCTION GetMovieDefaultDataRef(theMovie:Movie; VAR dataRef:Handle; VAR dataRefType:OSType):OSErr;
 INLINE $303C,$1D2,$AAAA;

PROCEDURE FlattenMovie(m: Movie;movieFlattenFlags: LONGINT;theFile: FSSpec;
 creator: OSType;scriptTag: ScriptCode;createMovieFileFlags: LONGINT;VAR resId: INTEGER;
 resName: STR255);
 INLINE $303C,$19B,$AAAA;
FUNCTION FlattenMovieData(m: Movie;movieFlattenFlags: LONGINT;theFile: FSSpec;
 creator: OSType;scriptTag: ScriptCode;createMovieFileFlags: LONGINT): Movie;
 INLINE $303C,$19C,$AAAA;
PROCEDURE SetMovieProgressProc(m: Movie;p: MovieProgressProcPtr;refCon: LONGINT);
 INLINE $303C,$19A,$AAAA;


{  Video Media Routines  }
FUNCTION GetVideoMediaGraphicsMode(mh: MediaHandler;VAR graphicsMode: LONGINT;
 VAR opColor: RGBColor): HandlerError;
 INLINE $2F3C,$8,$101,$7000,$A82A;
FUNCTION SetVideoMediaGraphicsMode(mh: MediaHandler;graphicsMode: LONGINT;
 opColor: RGBColor): HandlerError;
 INLINE $2F3C,$8,$102,$7000,$A82A;


{  Sound Media Routines  }
FUNCTION GetSoundMediaBalance(mh: MediaHandler;VAR balance: INTEGER): HandlerError;
 INLINE $2F3C,$4,$101,$7000,$A82A;
FUNCTION SetSoundMediaBalance(mh: MediaHandler;balance: INTEGER): HandlerError;
 INLINE $2F3C,$2,$102,$7000,$A82A;

CONST
txtProcDefaultDisplay = 0;
txtProcDontDisplay = 1;
txtProcDoDisplay = 2;

{  Text Media Routines  }
FUNCTION SetTextProc(mh: MediaHandler;TextProc: ProcPtr): ComponentResult;
 INLINE $2F3C,$8,$101,$7000,$A82A;
FUNCTION AddTextSample(mh: MediaHandler;text: Ptr;size: LONGINT; fontNumber: INTEGER;
 fontSize: INTEGER; textFace: Style; textColor: RGBColor; backColor: RGBColor;
 textJustification: LONGINT; textBox: Rect; displayFlags: LONGINT; shrinkTextBoxToFit: Boolean;
 selStart: LONGINT; selEnd: LONGINT; duration: TimeValue; VAR sampleTime: TimeValue): ComponentResult;
 INLINE $2F3C,$34,$102,$7000,$A82A;
FUNCTION AddTESample(mh: MediaHandler;hTE: TEHandle; backColor: RGBColor;
 textJustification: LONGINT; textBox: Rect; displayFlags: LONGINT; shrinkTextBoxToFit: Boolean;
 selStart: LONGINT; selEnd: LONGINT; duration: TimeValue; VAR sampleTime: TimeValue): ComponentResult;
 INLINE $2F3C,$26,$103,$7000,$A82A;
FUNCTION AddHiliteSample(mh: MediaHandler;selStart: LONGINT; selEnd: LONGINT;
 duration: TimeValue; VAR sampleTime: TimeValue): ComponentResult;
 INLINE $2F3C,$10,$104,$7000,$A82A;

CONST
findTextEdgeOK = 1;			{ Okay to find text at specified sample time }
findTextCaseSensitive = 2;	{ Case sensitive search }
findTextReverseSearch = 4;	{ Search from sampleTime backwards }
findTextWrapAround = 8;		{ Wrap search when beginning or end of movie is hit }

FUNCTION FindNextText(mh:MediaHandler;text:Ptr; size:LONGINT; findFlags:INTEGER;
	startTime:TimeValue;VAR foundTime:TimeValue; VAR foundDuration :TimeValue; VAR offset:LONGINT):ComponentResult;
 INLINE $2F3C,$1A,$105,$7000,$A82A;

FUNCTION HiliteTextSample(mh :MediaHandler; sampleTime:TimeValue; hiliteStart:INTEGER;
	 hiliteEnd :INTEGER;VAR rgbHiliteColor:RGBColor):ComponentResult;
 INLINE $2F3C,$C,$106,$7000,$A82A;

{  movie poster box  }
PROCEDURE GetPosterBox(m: Movie;VAR boxRect: Rect);
 INLINE $303C,$16F,$AAAA;
PROCEDURE SetPosterBox(m: Movie;boxRect: Rect);
 INLINE $303C,$170,$AAAA;

{  movie/track bounds over a range of time  }
FUNCTION GetMovieSegmentDisplayBoundsRgn(m: Movie;time: TimeValue;duration: TimeValue): RgnHandle;
 INLINE $303C,$16C,$AAAA;
FUNCTION GetTrackSegmentDisplayBoundsRgn(t: Track;time: TimeValue;
 duration: TimeValue): RgnHandle;
 INLINE $303C,$16B,$AAAA;

PROCEDURE SetMovieCoverProcs(m: Movie;uncoverProc: MovieRgnCoverProc;coverProc: MovieRgnCoverProc;
 refCon: LONGINT);
 INLINE $303C,$179,$AAAA;

FUNCTION GetTrackStatus(t: Track): ComponentResult;
 INLINE $303C,$172,$AAAA;
FUNCTION GetMovieStatus(m: Movie;VAR firstProblemTrack: Track): ComponentResult;
 INLINE $303C,$173,$AAAA;

{  target management  }
FUNCTION NewMovieController(m: Movie;movieRect: Rect;controllerCreationFlags: LONGINT): MovieController;
 INLINE $303C,$18A,$AAAA;
PROCEDURE DisposeMovieController(mc: MovieController);
 INLINE $303C,$18B,$AAAA;

FUNCTION PutMovieOnScrap(m: Movie;movieScrapFlags: LONGINT): OSErr;
 INLINE $303C,$18C,$AAAA;
FUNCTION NewMovieFromScrap(newMovieFlags: LONGINT): Movie;
 INLINE $303C,$18D,$AAAA;

CONST
dataRefSelfReference = 1;
dataRefWasNotResolved = 2;

TYPE
dataRefAttributesFlags = LONGINT;

{  Media dataRef Routines  }
FUNCTION GetMediaDataRef(m: Media;index: INTEGER;VAR dataRef: Handle;VAR dataRefType: OSType;
 VAR dataRefAttributes: LONGINT): OSErr;
 INLINE $303C,$197,$AAAA;
FUNCTION AddMediaDataRef(m: Media;VAR index: INTEGER;dataRef: Handle;dataRefType: OSType): OSErr;
 INLINE $303C,$198,$AAAA;
FUNCTION SetMediaDataRef(m: Media;index: INTEGER;blob: Handle; blobType: OSType): OSType;
 INLINE $303C,$1C9,$AAAA;
FUNCTION SetMediaDataRefAttributes(m: Media;index: INTEGER;attributes: LONGINT): OSType;
 INLINE $303C,$1CA,$AAAA;
FUNCTION GetMediaDataRefCount(m: Media;VAR count: INTEGER): OSErr;
 INLINE $303C,$199,$AAAA;

PROCEDURE SetMediaPlayHints( movie:Movie; flags:LONGINT; flagsMask:LONGINT );
 INLINE $303C,$1A2,$AAAA;
PROCEDURE SetMoviePlayHints(movie:Movie; flags:LONGINT; flagsMask:LONGINT );
 INLINE $303C,$1A1,$AAAA;

CONST
firstMoviesError = -2000;
couldNotResolveDataRef = -2000;
badImageDescription = -2001;
badPublicMovieAtom = -2002;
cantFindHandler = -2003;
cantOpenHandler = -2004;
badComponentType = -2005;
noMediaHandler = -2006;
noDataHandler = -2007;
invalidMedia = -2008;
invalidTrack = -2009;
invalidMovie = -2010;
invalidSampleTable = -2011;
invalidDataRef = -2012;
invalidHandler = -2013;
invalidDuration = -2014;
invalidTime = -2015;
cantPutPublicMovieAtom = -2016;
badEditList = -2017;
mediaTypesDontMatch = -2018;
progressProcAborted = -2019;
movieToolboxUninitialized = -2020;
wfFileNotFound = -2021;
cantCreateSingleForkFile = -2022;
invalidEditState = -2023;
nonMatchingEditState = -2024;
staleEditState = -2025;
userDataItemNotFound = -2026;
maxSizeToGrowTooSmall = -2027;
badTrackIndex = -2028;
trackIDNotFound = -2029;
trackNotInMovie = -2030;
timeNotInTrack = -2031;
timeNotInMedia = -2032;
badEditIndex = -2033;
internalQuickTimeError = -2034;
cantEnableTrack = -2035;
invalidRect = -2036;
invalidSampleNum = -2037;
invalidChunkNum = -2038;
invalidSampleDescIndex = -2039;
invalidChunkCache = -2040;
invalidSampleDescription = -2041;

{ this should probably be in its own range for data handlers }
dataNotOpenForRead = -2042;
dataNotOpenForWrite = -2043;
dataAlreadyOpenForWrite = -2044;
dataAlreadyClosed = -2045;
endOfDataReached = -2046;
dataNoDataRef = -2047;

noMovieFound = -2048;
invalidDataRefContainer = -2049;
badDataRefIndex = -2050;
noDefaultDataRef = -2051;
couldNotUseAnExistingSample = -2052;
featureUnsupported = -2053;
unsupportedAuxiliaryImportData = -2057;
lastMoviesError = -2056;
noRecordOfApp = movieToolboxUninitialized;			{replica }


CONST

{ Movie Controller Routines }
MovieControllerComponentType = 'play';

mcTopLeftMovie = $1;
mcScaleMovieToFit = $2;
mcWithBadge = $4;
mcNotVisible = $8;
mcWithFrame = $10;

mcActionIdle = 1;
mcActionDraw = 2;
mcActionActivate = 3;
mcActionDeactivate = 4;
mcActionMouseDown = 5;
mcActionKey = 6;
mcActionPlay = 8;
mcActionGoToTime = 12;
mcActionSetVolume = 14;
mcActionGetVolume = 15;
mcActionStep = 18;
mcActionSetLooping = 21;
mcActionGetLooping = 22;
mcActionSetLoopIsPalindrome = 23;
mcActionGetLoopIsPalindrome = 24;
mcActionSetGrowBoxBounds = 25;
mcActionControllerSizeChanged = 26;
mcActionSetSelectionBegin = 29;
mcActionSetSelectionDuration = 30;
mcActionSetKeysEnabled = 32;
mcActionGetKeysEnabled = 33;
mcActionSetPlaySelection = 34;
mcActionGetPlaySelection = 35;
mcActionSetUseBadge = 36;
mcActionGetUseBadge = 37;
mcActionSetFlags = 38;
mcActionGetFlags = 39;
mcActionSetPlayEveryFrame = 40;
mcActionGetPlayEveryFrame = 41;
mcActionGetPlayRate = 42;
mcActionShowBalloon = 43;
mcActionBadgeClick = 44;
mcActionMovieClick = 45;	{ param is pointer to event record. change “what” to nullEvt to kill click }
mcActionSuspend = 46;		{ no param }
mcActionResume = 47;		{ no param }

TYPE
mcAction = INTEGER;

CONST
mcFlagSuppressMovieFrame = 1;
mcFlagSuppressStepButtons = 2;
mcFlagSuppressSpeakerButton = 4;
mcFlagsUseWindowPalette = 8;

mcPositionDontInvalidate = 32;

TYPE
mcFlags = LONGINT;
MCActionFilter = ProcPtr;
MCActionFilterWithRefCon = ProcPtr;

CONST
mcInfoUndoAvailable = $1;
mcInfoCutAvailable = $2;
mcInfoCopyAvailable = $4;
mcInfoPasteAvailable = $8;
mcInfoClearAvailable = $10;
mcInfoHasSound = $20;
mcInfoIsPlaying = $40;
mcInfoIsLooping = $80;
mcInfoIsInPalindrome = $100;
mcInfoEditingEnabled = $200;

{ menu item codes }
mcMenuUndo = 1;
mcMenuCut = 3;
mcMenuCopy = 4;
mcMenuPaste = 5;
mcMenuClear = 6;

{ movie controller error codes }
cannotMoveAttachedController = -9999;
controllerHasFixedHeight = -9998;
cannotSetWidthOfAttachedController = -9997;
controllerBoundsNotExact = -9996;
editingNotAllowed = -9995;
badControllerHeight = -9994;


FUNCTION MCSetMovie(mc: MovieController;m: Movie;movieWindow: WindowPtr;
 where: Point): ComponentResult;
 INLINE $2F3C,$C,$2,$7000,$A82A;
FUNCTION MCGetMovie(mc: MovieController): Movie;
 INLINE $4267, $2F3C,$2,$5,$7000,$A82A;
FUNCTION MCRemoveMovie(mc: MovieController): ComponentResult;
 INLINE $2F3C,$0,$6,$7000,$A82A;


{  event handling etc.  }
FUNCTION MCIsPlayerEvent(mc: MovieController;e: EventRecord): ComponentResult;
 INLINE $2F3C,$4,$7,$7000,$A82A;
FUNCTION MCSetActionFilter(mc: MovieController;filter: MCActionFilter): ComponentResult;
 INLINE $2F3C,$4,$8,$7000,$A82A;
FUNCTION MCDoAction(mc: MovieController;action: INTEGER;params: Ptr): ComponentResult;
 INLINE $2F3C,$6,$9,$7000,$A82A;


{  state type things  }
FUNCTION MCSetControllerAttached(mc: MovieController;attach: BOOLEAN): ComponentResult;
 INLINE $2F3C,$2,$A,$7000,$A82A;
FUNCTION MCIsControllerAttached(mc: MovieController): ComponentResult;
 INLINE $2F3C,$0,$B,$7000,$A82A;
FUNCTION MCSetControllerPort(mc: MovieController;gp: CGrafPtr): ComponentResult;
 INLINE $2F3C,$4,$C,$7000,$A82A;
FUNCTION MCGetControllerPort(mc: MovieController): CGrafPtr;
 INLINE $2F3C,$0,$D,$7000,$A82A;

FUNCTION MCSetVisible(mc: MovieController;show: BOOLEAN): ComponentResult;
 INLINE $2F3C,$2,$E,$7000,$A82A;
FUNCTION MCGetVisible(mc: MovieController): ComponentResult;
 INLINE $2F3C,$0,$F,$7000,$A82A;

FUNCTION MCGetControllerBoundsRect(mc: MovieController;VAR bounds: Rect): ComponentResult;
 INLINE $2F3C,$4,$10,$7000,$A82A;
FUNCTION MCSetControllerBoundsRect(mc: MovieController;bounds: Rect): ComponentResult;
 INLINE $2F3C,$4,$11,$7000,$A82A;
FUNCTION MCGetControllerBoundsRgn(mc: MovieController): RgnHandle;
 INLINE $2F3C,$0,$12,$7000,$A82A;
FUNCTION MCGetWindowRgn(mc: MovieController;w: WindowPtr): RgnHandle;
 INLINE $2F3C,$4,$13,$7000,$A82A;


{  other stuff  }
FUNCTION MCMovieChanged(mc: MovieController;m: Movie): ComponentResult;
 INLINE $2F3C,$4,$14,$7000,$A82A;
FUNCTION MCSetDuration(mc: MovieController;duration: TimeValue): ComponentResult;
 INLINE $2F3C,$4,$15,$7000,$A82A;
FUNCTION MCGetCurrentTime(mc: MovieController;VAR scale: TimeScale): TimeValue;
 INLINE $2F3C,$4,$16,$7000,$A82A;
FUNCTION MCNewAttachedController(mc: MovieController;m: Movie;w: WindowPtr;
 where: Point): ComponentResult;
 INLINE $2F3C,$C,$17,$7000,$A82A;


{  direct event handlers  }
FUNCTION MCDraw(mc: MovieController;w: WindowPtr): ComponentResult;
 INLINE $2F3C,$4,$18,$7000,$A82A;
FUNCTION MCActivate(mc: MovieController;w: WindowPtr;activate: BOOLEAN): ComponentResult;
 INLINE $2F3C,$6,$19,$7000,$A82A;
FUNCTION MCIdle(mc: MovieController): ComponentResult;
 INLINE $2F3C,$0,$1A,$7000,$A82A;
FUNCTION MCKey(mc: MovieController;key: SignedByte;modifiers: LONGINT): ComponentResult;
 INLINE $2F3C,$6,$1B,$7000,$A82A;
FUNCTION MCClick(mc: MovieController;w: WindowPtr;where: Point;when: LONGINT;
 modifiers: LONGINT): ComponentResult;
 INLINE $2F3C,$10,$1C,$7000,$A82A;


{   calls for editing  }
FUNCTION MCEnableEditing(mc: MovieController;enabled: BOOLEAN): ComponentResult;
 INLINE $2F3C,$2,$1D,$7000,$A82A;
FUNCTION MCIsEditingEnabled(mc: MovieController): LONGINT;
 INLINE $2F3C,$0,$1E,$7000,$A82A;
FUNCTION MCCopy(mc: MovieController): Movie;
 INLINE $2F3C,$0,$1F,$7000,$A82A;
FUNCTION MCCut(mc: MovieController): Movie;
 INLINE $2F3C,$0,$20,$7000,$A82A;
FUNCTION MCPaste(mc: MovieController;srcMovie: Movie): ComponentResult;
 INLINE $2F3C,$4,$21,$7000,$A82A;
FUNCTION MCClear(mc: MovieController): ComponentResult;
 INLINE $2F3C,$0,$22,$7000,$A82A;
FUNCTION MCUndo(mc: MovieController): ComponentResult;
 INLINE $2F3C,$0,$23,$7000,$A82A;
FUNCTION MCPositionController(mc: MovieController;VAR movieRect: Rect;VAR controllerRect: Rect;
 controllerCreationFlags: LONGINT): ComponentResult;
 INLINE $2F3C,$C,$24,$7000,$A82A;


{  menu related stuff  }
FUNCTION MCGetControllerInfo(mc: MovieController;VAR mcInfoFlags: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$25,$7000,$A82A;

FUNCTION MCSetClip(mc:MovieController;theClip: RgnHandle;movieClip:RgnHandle):ComponentResult;
INLINE $2f3c,8,40,$7000,$a82a;
FUNCTION MCGetClip(mc:MovieController;VAR theClip: RgnHandle;VAR movieClip:RgnHandle):ComponentResult;
INLINE $2f3c,8,41,$7000,$a82a;

FUNCTION MCDrawBadge(mc:MovieController;movieRgn:RgnHandle;VAR badgeRgn:RgnHandle):ComponentResult;
INLINE $2f3c,8,42,$7000,$a82a;

FUNCTION MCSetUpEditMenu(mc: MovieController;modifiers: LONGINT; mh: MenuHandle): ComponentResult;
 INLINE $2F3C,$8,$2B,$7000,$A82A;
FUNCTION MCGetMenuString(mc: MovieController;modifiers: LONGINT; item: INTEGER; VAR aString:Str255): ComponentResult;
 INLINE $2F3C,$A,$2C,$7000,$A82A;
FUNCTION MCSetActionFilterWithRefCon (mc:MovieController; blob:MCActionFilterWithRefCon; refCon:LONGINT ):ComponentResult;
INLINE $2F3C,$8,$2D,$7000,$A82A;


CONST


{ movie controller routine selectors }
kMCSetMovieSelect = 2;
kMCRemoveMovieSelect = 6;
kMCIsPlayerEventSelect = 7;
kMCSetActionFilterSelect = 8;
kMCDoActionSelect = 9;
kMCSetControllerAttachedSelect = $A;
kMCIsControllerAttachedSelect = $B;
kMCSetControllerPortSelect = $C;
kMCGetControllerPortSelect = $D;
kMCGetVisibleSelect = $E;
kMCSetVisibleSelect = $F;
kMCGetControllerBoundsRectSelect = $10;
kMCSetControllerBoundsRectSelect = $11;
kMCGetControllerBoundsRgnSelect = $12;
kMCGetWindowRgnSelect = $13;
kMCMovieChangedSelect = $14;
kMCSetDurationSelect = $15;
kMCGetCurrentTimeSelect = $16;
kMCNewAttachedControllerSelect = $17;
kMCDrawSelect = $18;
kMCActivateSelect = $19;
kMCIdleSelect = $1A;
kMCKeySelect = $1B;
kMCClickSelect = $1C;
kMCEnableEditingSelect = $1D;
kMCIsEditingEnabledSelect = $1E;
kMCCopySelect = $1F;
kMCCutSelect = $20;
kMCPasteSelect = $21;
kMCClearSelect = $22;
kMCUndoSelect = $23;
kMCPositionControllerSelect = $24;
kMCGetControllerInfoSelect = $25;
kMCSetClipSelect = $28;
kMCGetClipSelect = $29;
kMCDrawBadgeSelect = $2A;
kMCSetUpEditMenuSelect = $2B;
kMCGetMenuStringSelect = $2C;
kMCSetActionFilterWithRefConSelect = $2D;





{  TimeBase Routines  }
FUNCTION NewTimeBase: TimeBase;
 INLINE $303C,$A5,$AAAA;
PROCEDURE DisposeTimeBase(tb: TimeBase);
 INLINE $303C,$B6,$AAAA;

FUNCTION GetTimeBaseTime(tb: TimeBase;s: TimeScale;VAR out: TimeRecord): TimeValue;
 INLINE $303C,$A6,$AAAA;
PROCEDURE SetTimeBaseTime(tb: TimeBase;tr: TimeRecord);
 INLINE $303C,$A7,$AAAA;
PROCEDURE SetTimeBaseValue(tb: TimeBase;t: TimeValue;s: TimeScale);
 INLINE $303C,$A8,$AAAA;

FUNCTION GetTimeBaseRate(tb: TimeBase): Fixed;
 INLINE $303C,$A9,$AAAA;
PROCEDURE SetTimeBaseRate(tb: TimeBase;r: Fixed);
 INLINE $303C,$AA,$AAAA;

FUNCTION GetTimeBaseStartTime(tb: TimeBase;s: TimeScale;VAR out: TimeRecord): TimeValue;
 INLINE $303C,$AB,$AAAA;
PROCEDURE SetTimeBaseStartTime(tb: TimeBase;tr: TimeRecord);
 INLINE $303C,$AC,$AAAA;
FUNCTION GetTimeBaseStopTime(tb: TimeBase;s: TimeScale;VAR out: TimeRecord): TimeValue;
 INLINE $303C,$AD,$AAAA;
PROCEDURE SetTimeBaseStopTime(tb: TimeBase;tr: TimeRecord);
 INLINE $303C,$AE,$AAAA;

FUNCTION GetTimeBaseFlags(tb: TimeBase): LONGINT;
 INLINE $303C,$B1,$AAAA;
PROCEDURE SetTimeBaseFlags(tb: TimeBase;timeBaseFlags: LONGINT);
 INLINE $303C,$B2,$AAAA;

PROCEDURE SetTimeBaseMasterTimeBase(slave: TimeBase;master: TimeBase;slaveZero: TimeRecord);
 INLINE $303C,$B4,$AAAA;
FUNCTION GetTimeBaseMasterTimeBase(tb: TimeBase): TimeBase;
 INLINE $303C,$AF,$AAAA;
PROCEDURE SetTimeBaseMasterClock(slave: TimeBase;clockMeister: Component;
 slaveZero: TimeRecord);
 INLINE $303C,$B3,$AAAA;
FUNCTION GetTimeBaseMasterClock(tb: TimeBase): ComponentInstance;
 INLINE $303C,$B0,$AAAA;

PROCEDURE ConvertTime(VAR inout: TimeRecord;newBase: TimeBase);
 INLINE $303C,$B5,$AAAA;
PROCEDURE ConvertTimeScale(VAR inout: TimeRecord;newScale: TimeScale);
 INLINE $303C,$B7,$AAAA;
PROCEDURE AddTime(VAR dst: TimeRecord;src: TimeRecord);
 INLINE $303C,$10C,$AAAA;
PROCEDURE SubtractTime(VAR dst: TimeRecord;src: TimeRecord);
 INLINE $303C,$10D,$AAAA;

FUNCTION GetTimeBaseStatus(tb: TimeBase;VAR unpinnedTime: TimeRecord): LONGINT;
 INLINE $303C,$10B,$AAAA;

PROCEDURE SetTimeBaseZero(tb: TimeBase;VAR zero: TimeRecord);
 INLINE $303C,$128,$AAAA;
FUNCTION GetTimeBaseEffectiveRate(tb:TimeBase):Fixed;
 INLINE $303C,$124,$AAAA;


{  CallBack Routines  }
FUNCTION NewCallBack(tb: TimeBase;cbType: INTEGER): QTCallBack;
 INLINE $303C,$EB,$AAAA;

PROCEDURE DisposeCallBack(qtCall: QTCallBack);
 INLINE $303C,$EC,$AAAA;

FUNCTION GetCallBackType(qtCall: QTCallBack): INTEGER;
 INLINE $303C,$ED,$AAAA;
FUNCTION GetCallBackTimeBase(qtCall: QTCallBack): TimeBase;
 INLINE $303C,$EE,$AAAA;

FUNCTION CallMeWhen(qtCall: QTCallBack;callBackProc: QTCallBackProc;refCon: LONGINT;
 param1: LONGINT;param2: LONGINT;param3: LONGINT): OSErr;
 INLINE $303C,$B8,$AAAA;

PROCEDURE CancelCallBack(cb: QTCallBack);
 INLINE $303C,$B9,$AAAA;


{  Clock CallBack support Routines  }
FUNCTION AddCallBackToTimeBase(cb: QTCallBack): OSErr;
 INLINE $303C,$129,$AAAA;
FUNCTION RemoveCallBackFromTimeBase(cb: QTCallBack): OSErr;
 INLINE $303C,$12A,$AAAA;
FUNCTION GetFirstCallBack(tb: TimeBase): QTCallBack;
 INLINE $303C,$12B,$AAAA;
FUNCTION GetNextCallBack(cb: QTCallBack): QTCallBack;
 INLINE $303C,$12C,$AAAA;
PROCEDURE ExecuteCallBack(cb: QTCallBack);
 INLINE $303C,$12D,$AAAA;


{$ENDC} { UsingMovies }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}


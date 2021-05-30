/*
 	File:		Movies.h
 
 	Contains:	QuickTime interfaces
 
 	Version:	Technology:	Technology:	QuickTime 2.5
 				Package:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/
#ifndef __MOVIES__
#define __MOVIES__

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
#ifndef __ALIASES__
#include <Aliases.h>
#endif
#ifndef __EVENTS__
#include <Events.h>
#endif
#ifndef __MENUS__
#include <Menus.h>
#endif
#ifndef __COMPONENTS__
#include <Components.h>
#endif
#ifndef __IMAGECOMPRESSION__
#include <ImageCompression.h>
#endif
#ifndef __SOUND__
#include <Sound.h>
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

/*  "kFix1" is defined in FixMath as "fixed1"  */
/* error codes are in Errors.[haa] */
/* gestalt codes are in Gestalt.[hpa] */

enum {
	MovieFileType				= 'MooV'
};


enum {
	MediaHandlerType			= 'mhlr',
	DataHandlerType				= 'dhlr'
};


enum {
	VideoMediaType				= 'vide',
	SoundMediaType				= 'soun',
	TextMediaType				= 'text',
	BaseMediaType				= 'gnrc',
	MPEGMediaType				= 'MPEG',
	MusicMediaType				= 'musi',
	TimeCodeMediaType			= 'tmcd',
	SpriteMediaType				= 'sprt',
	TweenMediaType				= 'twen',
	ThreeDeeMediaType			= 'qd3d',
	HandleDataHandlerSubType	= 'hndl',
	ResourceDataHandlerSubType	= 'rsrc'
};


enum {
	VisualMediaCharacteristic	= 'eyes',
	AudioMediaCharacteristic	= 'ears',
	kCharacteristicCanSendVideo	= 'vsnd'
};


enum {
	DoTheRightThing				= 0
};

struct MovieRecord {
	long 							data[1];
};
typedef struct MovieRecord MovieRecord;

typedef MovieRecord *Movie;
struct TrackRecord {
	long 							data[1];
};
typedef struct TrackRecord TrackRecord;

typedef TrackRecord *Track;
struct MediaRecord {
	long 							data[1];
};
typedef struct MediaRecord MediaRecord;

typedef MediaRecord *Media;
struct UserDataRecord {
	long 							data[1];
};
typedef struct UserDataRecord UserDataRecord;

typedef UserDataRecord *UserData;
struct TrackEditStateRecord {
	long 							data[1];
};
typedef struct TrackEditStateRecord TrackEditStateRecord;

typedef TrackEditStateRecord *TrackEditState;
struct MovieEditStateRecord {
	long 							data[1];
};
typedef struct MovieEditStateRecord MovieEditStateRecord;

typedef MovieEditStateRecord *MovieEditState;
struct SpriteWorldRecord {
	long 							data[1];
};
typedef struct SpriteWorldRecord SpriteWorldRecord;

typedef SpriteWorldRecord *SpriteWorld;
struct SpriteRecord {
	long 							data[1];
};
typedef struct SpriteRecord SpriteRecord;

typedef SpriteRecord *Sprite;
struct SampleDescription {
	long 							descSize;
	long 							dataFormat;
	long 							resvd1;
	short 							resvd2;
	short 							dataRefIndex;
};
typedef struct SampleDescription SampleDescription;

typedef SampleDescription *SampleDescriptionPtr;
typedef SampleDescriptionPtr *SampleDescriptionHandle;
typedef Handle QTAtomContainer;
typedef long QTAtom;
typedef long QTAtomType;
typedef long QTAtomID;
struct SoundDescription {
	long 							descSize;					/* total size of SoundDescription including extra data */
	long 							dataFormat;					/*  */
	long 							resvd1;						/* reserved for apple use */
	short 							resvd2;
	short 							dataRefIndex;
	short 							version;					/* which version is this data */
	short 							revlevel;					/* what version of that codec did this */
	long 							vendor;						/* whose  codec compressed this data */
	short 							numChannels;				/* number of channels of sound */
	short 							sampleSize;					/* number of bits per sample */
	short 							compressionID;				/* sound compression used, 0 if none */
	short 							packetSize;					/* packet size for compression, 0 if no compression */
	Fixed 							sampleRate;					/* sample rate sound is captured at */
};
typedef struct SoundDescription SoundDescription;

typedef SoundDescription *SoundDescriptionPtr;
typedef SoundDescriptionPtr *SoundDescriptionHandle;
struct TextDescription {
	long 							descSize;					/* Total size of TextDescription*/
	long 							dataFormat;					/* 'text'*/

	long 							resvd1;
	short 							resvd2;
	short 							dataRefIndex;

	long 							displayFlags;				/* see enum below for flag values*/

	long 							textJustification;			/* Can be: teCenter,teFlush -Default,-Right,-Left*/

	RGBColor 						bgColor;					/* Background color*/

	Rect 							defaultTextBox;				/* Location to place the text within the track bounds*/
	ScrpSTElement 					defaultStyle;				/* Default style (struct defined in TextEdit.h)*/
	char 							defaultFontName[1];			/* Font Name (pascal string - struct extended to fit) */
};
typedef struct TextDescription TextDescription;

typedef TextDescription *TextDescriptionPtr;
typedef TextDescriptionPtr *TextDescriptionHandle;
struct ThreeDeeDescription {
	long 							descSize;					/* total size of ThreeDeeDescription including extra data */
	long 							dataFormat;					/*  */
	long 							resvd1;						/* reserved for apple use */
	short 							resvd2;
	short 							dataRefIndex;
	long 							version;					/* which version is this data */
	long 							rendererType;				/* which renderer to use, 0 for default */
};
typedef struct ThreeDeeDescription ThreeDeeDescription;

typedef ThreeDeeDescription *ThreeDeeDescriptionPtr;
typedef ThreeDeeDescriptionPtr *ThreeDeeDescriptionHandle;
struct DataReferenceRecord {
	OSType 							dataRefType;
	Handle 							dataRef;
};
typedef struct DataReferenceRecord DataReferenceRecord;

typedef DataReferenceRecord *DataReferencePtr;
/*
--------------------------
  Music Sample Description
--------------------------
*/
struct MusicDescription {
	long 							descSize;
	long 							dataFormat;					/* 'musi' */

	long 							resvd1;
	short 							resvd2;
	short 							dataRefIndex;

	long 							musicFlags;
	unsigned long 					headerData[1];				/* variable size! */

};
typedef struct MusicDescription MusicDescription;

typedef MusicDescription *MusicDescriptionPtr;
typedef MusicDescriptionPtr *MusicDescriptionHandle;

enum {
	kMusicFlagDontPlay2Soft		= 1L << 0
};


enum {
	dfDontDisplay				= 1 << 0,						/* Don't display the text*/
	dfDontAutoScale				= 1 << 1,						/* Don't scale text as track bounds grows or shrinks*/
	dfClipToTextBox				= 1 << 2,						/* Clip update to the textbox*/
	dfUseMovieBGColor			= 1 << 3,						/* Set text background to movie's background color*/
	dfShrinkTextBoxToFit		= 1 << 4,						/* Compute minimum box to fit the sample*/
	dfScrollIn					= 1 << 5,						/* Scroll text in until last of text is in view */
	dfScrollOut					= 1 << 6,						/* Scroll text out until last of text is gone (if both set, scroll in then out)*/
	dfHorizScroll				= 1 << 7,						/* Scroll text horizontally (otherwise it's vertical)*/
	dfReverseScroll				= 1 << 8,						/* vert: scroll down rather than up; horiz: scroll backwards (justfication dependent)*/
	dfContinuousScroll			= 1 << 9,						/* new samples cause previous samples to scroll out */
	dfFlowHoriz					= 1 << 10,						/* horiz scroll text flows in textbox rather than extend to right */
	dfContinuousKaraoke			= 1 << 11,						/* ignore begin offset, hilite everything up to the end offset(karaoke)*/
	dfDropShadow				= 1 << 12,						/* display text with a drop shadow */
	dfAntiAlias					= 1 << 13,						/* attempt to display text anti aliased*/
	dfKeyedText					= 1 << 14,						/* key the text over background*/
	dfInverseHilite				= 1 << 15,						/* Use inverse hiliting rather than using hilite color*/
	dfTextColorHilite			= 1 << 16						/* changes text color in place of hiliting. */
};


enum {
	searchTextDontGoToFoundTime	= 1L << 16,
	searchTextDontHiliteFoundText = 1L << 17,
	searchTextOneTrackOnly		= 1L << 18,
	searchTextEnabledTracksOnly	= 1L << 19
};


enum {
	k3DMediaRendererEntry		= 'rend',
	k3DMediaRendererName		= 'name',
	k3DMediaRendererCode		= 'rcod'
};

/* progress messages */

enum {
	movieProgressOpen			= 0,
	movieProgressUpdatePercent	= 1,
	movieProgressClose			= 2
};

/* progress operations */

enum {
	progressOpFlatten			= 1,
	progressOpInsertTrackSegment = 2,
	progressOpInsertMovieSegment = 3,
	progressOpPaste				= 4,
	progressOpAddMovieSelection	= 5,
	progressOpCopy				= 6,
	progressOpCut				= 7,
	progressOpLoadMovieIntoRam	= 8,
	progressOpLoadTrackIntoRam	= 9,
	progressOpLoadMediaIntoRam	= 10,
	progressOpImportMovie		= 11,
	progressOpExportMovie		= 12
};


enum {
	mediaQualityDraft			= 0x0000,
	mediaQualityNormal			= 0x0040,
	mediaQualityBetter			= 0x0080,
	mediaQualityBest			= 0x00C0
};

typedef pascal OSErr (*MovieRgnCoverProcPtr)(Movie theMovie, RgnHandle changedRgn, long refcon);
typedef pascal OSErr (*MovieProgressProcPtr)(Movie theMovie, short message, short whatOperation, Fixed percentDone, long refcon);
typedef pascal OSErr (*MovieDrawingCompleteProcPtr)(Movie theMovie, long refCon);
typedef pascal OSErr (*TrackTransferProcPtr)(Track t, long refCon);
typedef pascal OSErr (*GetMovieProcPtr)(long offset, long size, void *dataPtr, void *refCon);
typedef pascal Boolean (*MoviePreviewCallOutProcPtr)(long refcon);
typedef pascal OSErr (*TextMediaProcPtr)(Handle theText, Movie theMovie, short *displayFlag, long refcon);
typedef pascal void (*MoviesErrorProcPtr)(OSErr theErr, long refcon);

#if GENERATINGCFM
typedef UniversalProcPtr MoviesErrorUPP;
#else
typedef MoviesErrorProcPtr MoviesErrorUPP;
#endif

enum {
	uppMoviesErrorProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewMoviesErrorProc(userRoutine)		\
		(MoviesErrorUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMoviesErrorProcInfo, GetCurrentArchitecture())
#else
#define NewMoviesErrorProc(userRoutine)		\
		((MoviesErrorUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallMoviesErrorProc(userRoutine, theErr, refcon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMoviesErrorProcInfo, (theErr), (refcon))
#else
#define CallMoviesErrorProc(userRoutine, theErr, refcon)		\
		(*(userRoutine))((theErr), (refcon))
#endif

#if GENERATINGCFM
typedef UniversalProcPtr MovieRgnCoverUPP;
typedef UniversalProcPtr MovieProgressUPP;
typedef UniversalProcPtr MovieDrawingCompleteUPP;
typedef UniversalProcPtr TrackTransferUPP;
typedef UniversalProcPtr GetMovieUPP;
typedef UniversalProcPtr MoviePreviewCallOutUPP;
typedef UniversalProcPtr TextMediaUPP;
#else
typedef MovieRgnCoverProcPtr MovieRgnCoverUPP;
typedef MovieProgressProcPtr MovieProgressUPP;
typedef MovieDrawingCompleteProcPtr MovieDrawingCompleteUPP;
typedef TrackTransferProcPtr TrackTransferUPP;
typedef GetMovieProcPtr GetMovieUPP;
typedef MoviePreviewCallOutProcPtr MoviePreviewCallOutUPP;
typedef TextMediaProcPtr TextMediaUPP;
#endif
typedef ComponentInstance MediaHandler;
typedef ComponentInstance DataHandler;
typedef Component MediaHandlerComponent;
typedef Component DataHandlerComponent;
typedef ComponentResult HandlerError;
/* TimeBase equates */
typedef long TimeValue;
typedef long TimeScale;
typedef wide CompTimeValue;

enum {
	loopTimeBase				= 1,
	palindromeLoopTimeBase		= 2,
	maintainTimeBaseZero		= 4
};

typedef unsigned long TimeBaseFlags;
struct TimeBaseRecord {
	long 							data[1];
};
typedef struct TimeBaseRecord TimeBaseRecord;

typedef TimeBaseRecord *TimeBase;
struct CallBackRecord {
	long 							data[1];
};
typedef struct CallBackRecord CallBackRecord;

typedef CallBackRecord *QTCallBack;
struct TimeRecord {
	CompTimeValue 					value;						/* units */
	TimeScale 						scale;						/* units per second */
	TimeBase 						base;
};
typedef struct TimeRecord TimeRecord;

/* CallBack equates */

enum {
	triggerTimeFwd				= 0x0001,						/* when curTime exceeds triggerTime going forward */
	triggerTimeBwd				= 0x0002,						/* when curTime exceeds triggerTime going backwards */
	triggerTimeEither			= 0x0003,						/* when curTime exceeds triggerTime going either direction */
	triggerRateLT				= 0x0004,						/* when rate changes to less than trigger value */
	triggerRateGT				= 0x0008,						/* when rate changes to greater than trigger value */
	triggerRateEqual			= 0x0010,						/* when rate changes to equal trigger value */
	triggerRateLTE				= triggerRateLT | triggerRateEqual,
	triggerRateGTE				= triggerRateGT | triggerRateEqual,
	triggerRateNotEqual			= triggerRateGT | triggerRateEqual | triggerRateLT,
	triggerRateChange			= 0,
	triggerAtStart				= 0x0001,
	triggerAtStop				= 0x0002
};

typedef unsigned short QTCallBackFlags;

enum {
	timeBaseBeforeStartTime		= 1,
	timeBaseAfterStopTime		= 2
};

typedef unsigned long TimeBaseStatus;

enum {
	callBackAtTime				= 1,
	callBackAtRate				= 2,
	callBackAtTimeJump			= 3,
	callBackAtExtremes			= 4,
	callBackAtInterrupt			= 0x8000,
	callBackAtDeferredTask		= 0x4000
};

typedef unsigned short QTCallBackType;
typedef pascal void (*QTCallBackProcPtr)(QTCallBack cb, long refCon);

#if GENERATINGCFM
typedef UniversalProcPtr QTCallBackUPP;
#else
typedef QTCallBackProcPtr QTCallBackUPP;
#endif

enum {
	qtcbNeedsRateChanges		= 1,							/* wants to know about rate changes */
	qtcbNeedsTimeChanges		= 2,							/* wants to know about time changes */
	qtcbNeedsStartStopChanges	= 4								/* wants to know when TimeBase start/stop is changed*/
};

struct QTCallBackHeader {
	long 							callBackFlags;
	long 							reserved1;
	SInt8 							qtPrivate[40];
};
typedef struct QTCallBackHeader QTCallBackHeader;

typedef pascal void (*QTSyncTaskProcPtr)(void *task);

#if GENERATINGCFM
typedef UniversalProcPtr QTSyncTaskUPP;
#else
typedef QTSyncTaskProcPtr QTSyncTaskUPP;
#endif
struct QTSyncTaskRecord {
	void *							qLink;
	QTSyncTaskUPP 					proc;
};
typedef struct QTSyncTaskRecord QTSyncTaskRecord;

typedef QTSyncTaskRecord *QTSyncTaskPtr;

enum {
	keepInRam					= 1 << 0,						/* load and make non-purgable*/
	unkeepInRam					= 1 << 1,						/* mark as purgable*/
	flushFromRam				= 1 << 2,						/* empty those handles*/
	loadForwardTrackEdits		= 1 << 3,						/*	load track edits into ram for playing forward*/
	loadBackwardTrackEdits		= 1 << 4						/*	load track edits into ram for playing in reverse*/
};


enum {
	newMovieActive				= 1 << 0,
	newMovieDontResolveDataRefs	= 1 << 1,
	newMovieDontAskUnresolvedDataRefs = 1 << 2,
	newMovieDontAutoAlternates	= 1 << 3,
	newMovieDontUpdateForeBackPointers = 1 << 4
};

/* track usage bits */

enum {
	trackUsageInMovie			= 1 << 1,
	trackUsageInPreview			= 1 << 2,
	trackUsageInPoster			= 1 << 3
};

/* Add/GetMediaSample flags */

enum {
	mediaSampleNotSync			= 1 << 0,						/* sample is not a sync sample (eg. is frame differenced */
	mediaSampleShadowSync		= 1 << 1						/* sample is a shadow sync */
};


enum {
	pasteInParallel				= 1 << 0,
	showUserSettingsDialog		= 1 << 1,
	movieToFileOnlyExport		= 1 << 2,
	movieFileSpecValid			= 1 << 3
};


enum {
	nextTimeMediaSample			= 1 << 0,
	nextTimeMediaEdit			= 1 << 1,
	nextTimeTrackEdit			= 1 << 2,
	nextTimeSyncSample			= 1 << 3,
	nextTimeStep				= 1 << 4,
	nextTimeEdgeOK				= 1 << 14,
	nextTimeIgnoreActiveSegment	= 1 << 15
};

typedef unsigned short nextTimeFlagsEnum;

enum {
	createMovieFileDeleteCurFile = 1L << 31,
	createMovieFileDontCreateMovie = 1L << 30,
	createMovieFileDontOpenFile	= 1L << 29
};

typedef unsigned long createMovieFileFlagsEnum;

enum {
	flattenAddMovieToDataFork	= 1L << 0,
	flattenActiveTracksOnly		= 1L << 2,
	flattenDontInterleaveFlatten = 1L << 3,
	flattenFSSpecPtrIsDataRefRecordPtr = 1L << 4
};

typedef unsigned long movieFlattenFlagsEnum;

enum {
	movieInDataForkResID		= -1							/* magic res ID */
};


enum {
	mcTopLeftMovie				= 1 << 0,						/* usually centered */
	mcScaleMovieToFit			= 1 << 1,						/* usually only scales down */
	mcWithBadge					= 1 << 2,						/* give me a badge */
	mcNotVisible				= 1 << 3,						/* don't show controller */
	mcWithFrame					= 1 << 4						/* gimme a frame */
};


enum {
	movieScrapDontZeroScrap		= 1 << 0,
	movieScrapOnlyPutMovie		= 1 << 1
};


enum {
	dataRefSelfReference		= 1 << 0,
	dataRefWasNotResolved		= 1 << 1
};

typedef unsigned long dataRefAttributesFlags;

enum {
	hintsScrubMode				= 1 << 0,						/* mask == && (if flags == scrub on, flags != scrub off) */
	hintsLoop					= 1 << 1,
	hintsDontPurge				= 1 << 2,
	hintsUseScreenBuffer		= 1 << 5,
	hintsAllowInterlace			= 1 << 6,
	hintsUseSoundInterp			= 1 << 7,
	hintsHighQuality			= 1 << 8,						/* slooooow */
	hintsPalindrome				= 1 << 9,
	hintsInactive				= 1 << 11
};

typedef unsigned long playHintsEnum;

enum {
	mediaHandlerFlagBaseClient	= 1
};

typedef unsigned long mediaHandlerFlagsEnum;

enum {
	movieTrackMediaType			= 1 << 0,
	movieTrackCharacteristic	= 1 << 1,
	movieTrackEnabledOnly		= 1 << 2
};

struct SampleReferenceRecord {
	long 							dataOffset;
	long 							dataSize;
	TimeValue 						durationPerSample;
	long 							numberOfSamples;
	short 							sampleFlags;
};
typedef struct SampleReferenceRecord SampleReferenceRecord;

typedef SampleReferenceRecord *SampleReferencePtr;
/*
************************
* Initialization Routines 
*************************
*/
extern pascal OSErr EnterMovies(void )
 TWOWORDINLINE(0x7001, 0xAAAA);

extern pascal void ExitMovies(void )
 TWOWORDINLINE(0x7002, 0xAAAA);

/*
************************
* Error Routines 
*************************
*/
extern pascal OSErr GetMoviesError(void )
 TWOWORDINLINE(0x7003, 0xAAAA);

extern pascal void ClearMoviesStickyError(void )
 THREEWORDINLINE(0x303C, 0x00DE, 0xAAAA);

extern pascal OSErr GetMoviesStickyError(void )
 TWOWORDINLINE(0x7004, 0xAAAA);

extern pascal void SetMoviesErrorProc(MoviesErrorUPP errProc, long refcon)
 THREEWORDINLINE(0x303C, 0x00EF, 0xAAAA);

/*
************************
* Idle Routines 
*************************
*/
extern pascal void MoviesTask(Movie theMovie, long maxMilliSecToUse)
 TWOWORDINLINE(0x7005, 0xAAAA);

extern pascal OSErr PrerollMovie(Movie theMovie, TimeValue time, Fixed Rate)
 TWOWORDINLINE(0x7006, 0xAAAA);

extern pascal OSErr LoadMovieIntoRam(Movie theMovie, TimeValue time, TimeValue duration, long flags)
 TWOWORDINLINE(0x7007, 0xAAAA);

extern pascal OSErr LoadTrackIntoRam(Track theTrack, TimeValue time, TimeValue duration, long flags)
 THREEWORDINLINE(0x303C, 0x016E, 0xAAAA);

extern pascal OSErr LoadMediaIntoRam(Media theMedia, TimeValue time, TimeValue duration, long flags)
 TWOWORDINLINE(0x7008, 0xAAAA);

extern pascal void SetMovieActive(Movie theMovie, Boolean active)
 TWOWORDINLINE(0x7009, 0xAAAA);

extern pascal Boolean GetMovieActive(Movie theMovie)
 TWOWORDINLINE(0x700A, 0xAAAA);

/*
************************
* calls for playing movies, previews, posters
*************************
*/
extern pascal void StartMovie(Movie theMovie)
 TWOWORDINLINE(0x700B, 0xAAAA);

extern pascal void StopMovie(Movie theMovie)
 TWOWORDINLINE(0x700C, 0xAAAA);

extern pascal void GoToBeginningOfMovie(Movie theMovie)
 TWOWORDINLINE(0x700D, 0xAAAA);

extern pascal void GoToEndOfMovie(Movie theMovie)
 TWOWORDINLINE(0x700E, 0xAAAA);

extern pascal Boolean IsMovieDone(Movie theMovie)
 THREEWORDINLINE(0x303C, 0x00DD, 0xAAAA);

extern pascal Boolean GetMoviePreviewMode(Movie theMovie)
 TWOWORDINLINE(0x700F, 0xAAAA);

extern pascal void SetMoviePreviewMode(Movie theMovie, Boolean usePreview)
 TWOWORDINLINE(0x7010, 0xAAAA);

extern pascal void ShowMoviePoster(Movie theMovie)
 TWOWORDINLINE(0x7011, 0xAAAA);

extern pascal void PlayMoviePreview(Movie theMovie, MoviePreviewCallOutUPP callOutProc, long refcon)
 THREEWORDINLINE(0x303C, 0x00F2, 0xAAAA);

/*
************************
* calls for controlling movies & tracks which are playing
*************************
*/
extern pascal TimeBase GetMovieTimeBase(Movie theMovie)
 TWOWORDINLINE(0x7012, 0xAAAA);

extern pascal void SetMovieMasterTimeBase(Movie theMovie, TimeBase tb, const TimeRecord *slaveZero)
 THREEWORDINLINE(0x303C, 0x0167, 0xAAAA);

extern pascal void SetMovieMasterClock(Movie theMovie, Component clockMeister, const TimeRecord *slaveZero)
 THREEWORDINLINE(0x303C, 0x0168, 0xAAAA);

extern pascal void GetMovieGWorld(Movie theMovie, CGrafPtr *port, GDHandle *gdh)
 TWOWORDINLINE(0x7015, 0xAAAA);

extern pascal void SetMovieGWorld(Movie theMovie, CGrafPtr port, GDHandle gdh)
 TWOWORDINLINE(0x7016, 0xAAAA);


enum {
	movieDrawingCallWhenChanged	= 0,
	movieDrawingCallAlways		= 1
};

extern pascal void SetMovieDrawingCompleteProc(Movie theMovie, long flags, MovieDrawingCompleteUPP proc, long refCon)
 THREEWORDINLINE(0x303C, 0x01DE, 0xAAAA);

extern pascal void GetMovieNaturalBoundsRect(Movie theMovie, Rect *naturalBounds)
 THREEWORDINLINE(0x303C, 0x022C, 0xAAAA);

extern pascal Track GetNextTrackForCompositing(Movie theMovie, Track theTrack)
 THREEWORDINLINE(0x303C, 0x01FA, 0xAAAA);

extern pascal Track GetPrevTrackForCompositing(Movie theMovie, Track theTrack)
 THREEWORDINLINE(0x303C, 0x01FB, 0xAAAA);

extern pascal OSErr SetMovieCompositeBufferFlags(Movie theMovie, long flags)
 THREEWORDINLINE(0x303C, 0x027E, 0xAAAA);

extern pascal OSErr GetMovieCompositeBufferFlags(Movie theMovie, long *flags)
 THREEWORDINLINE(0x303C, 0x027F, 0xAAAA);

extern pascal void SetTrackGWorld(Track theTrack, CGrafPtr port, GDHandle gdh, TrackTransferUPP proc, long refCon)
 THREEWORDINLINE(0x303C, 0x009D, 0xAAAA);

extern pascal PicHandle GetMoviePict(Movie theMovie, TimeValue time)
 TWOWORDINLINE(0x701D, 0xAAAA);

extern pascal PicHandle GetTrackPict(Track theTrack, TimeValue time)
 TWOWORDINLINE(0x701E, 0xAAAA);

extern pascal PicHandle GetMoviePosterPict(Movie theMovie)
 THREEWORDINLINE(0x303C, 0x00F7, 0xAAAA);

/* called between Begin & EndUpdate */
extern pascal OSErr UpdateMovie(Movie theMovie)
 TWOWORDINLINE(0x701F, 0xAAAA);

extern pascal OSErr InvalidateMovieRegion(Movie theMovie, RgnHandle invalidRgn)
 THREEWORDINLINE(0x303C, 0x022A, 0xAAAA);

/**** spatial movie routines ****/
extern pascal void GetMovieBox(Movie theMovie, Rect *boxRect)
 THREEWORDINLINE(0x303C, 0x00F9, 0xAAAA);

extern pascal void SetMovieBox(Movie theMovie, const Rect *boxRect)
 THREEWORDINLINE(0x303C, 0x00FA, 0xAAAA);

/** movie display clip */
extern pascal RgnHandle GetMovieDisplayClipRgn(Movie theMovie)
 THREEWORDINLINE(0x303C, 0x00FC, 0xAAAA);

extern pascal void SetMovieDisplayClipRgn(Movie theMovie, RgnHandle theClip)
 THREEWORDINLINE(0x303C, 0x00FD, 0xAAAA);

/** movie src clip */
extern pascal RgnHandle GetMovieClipRgn(Movie theMovie)
 THREEWORDINLINE(0x303C, 0x0100, 0xAAAA);

extern pascal void SetMovieClipRgn(Movie theMovie, RgnHandle theClip)
 THREEWORDINLINE(0x303C, 0x0101, 0xAAAA);

/** track src clip */
extern pascal RgnHandle GetTrackClipRgn(Track theTrack)
 THREEWORDINLINE(0x303C, 0x0102, 0xAAAA);

extern pascal void SetTrackClipRgn(Track theTrack, RgnHandle theClip)
 THREEWORDINLINE(0x303C, 0x0103, 0xAAAA);

/** bounds in display space (not clipped by display clip) */
extern pascal RgnHandle GetMovieDisplayBoundsRgn(Movie theMovie)
 THREEWORDINLINE(0x303C, 0x00FB, 0xAAAA);

extern pascal RgnHandle GetTrackDisplayBoundsRgn(Track theTrack)
 THREEWORDINLINE(0x303C, 0x0112, 0xAAAA);

/** bounds in movie space */
extern pascal RgnHandle GetMovieBoundsRgn(Movie theMovie)
 THREEWORDINLINE(0x303C, 0x00FE, 0xAAAA);

extern pascal RgnHandle GetTrackMovieBoundsRgn(Track theTrack)
 THREEWORDINLINE(0x303C, 0x00FF, 0xAAAA);

/** bounds in track space */
extern pascal RgnHandle GetTrackBoundsRgn(Track theTrack)
 THREEWORDINLINE(0x303C, 0x0111, 0xAAAA);

/** mattes - always in track space */
extern pascal PixMapHandle GetTrackMatte(Track theTrack)
 THREEWORDINLINE(0x303C, 0x0115, 0xAAAA);

extern pascal void SetTrackMatte(Track theTrack, PixMapHandle theMatte)
 THREEWORDINLINE(0x303C, 0x0116, 0xAAAA);

extern pascal void DisposeMatte(PixMapHandle theMatte)
 THREEWORDINLINE(0x303C, 0x014A, 0xAAAA);

/*
************************
* calls for getting/saving movies
*************************
*/
extern pascal Movie NewMovie(long flags)
 THREEWORDINLINE(0x303C, 0x0187, 0xAAAA);

extern pascal OSErr PutMovieIntoHandle(Movie theMovie, Handle publicMovie)
 TWOWORDINLINE(0x7022, 0xAAAA);

extern pascal OSErr PutMovieIntoDataFork(Movie theMovie, short fRefNum, long offset, long maxSize)
 THREEWORDINLINE(0x303C, 0x01B4, 0xAAAA);

extern pascal void DisposeMovie(Movie theMovie)
 TWOWORDINLINE(0x7023, 0xAAAA);

/*
************************
* Movie State Routines
*************************
*/
extern pascal unsigned long GetMovieCreationTime(Movie theMovie)
 TWOWORDINLINE(0x7026, 0xAAAA);

extern pascal unsigned long GetMovieModificationTime(Movie theMovie)
 TWOWORDINLINE(0x7027, 0xAAAA);

extern pascal TimeScale GetMovieTimeScale(Movie theMovie)
 TWOWORDINLINE(0x7029, 0xAAAA);

extern pascal void SetMovieTimeScale(Movie theMovie, TimeScale timeScale)
 TWOWORDINLINE(0x702A, 0xAAAA);

extern pascal TimeValue GetMovieDuration(Movie theMovie)
 TWOWORDINLINE(0x702B, 0xAAAA);

extern pascal Fixed GetMovieRate(Movie theMovie)
 TWOWORDINLINE(0x702C, 0xAAAA);

extern pascal void SetMovieRate(Movie theMovie, Fixed rate)
 TWOWORDINLINE(0x702D, 0xAAAA);

extern pascal Fixed GetMoviePreferredRate(Movie theMovie)
 THREEWORDINLINE(0x303C, 0x00F3, 0xAAAA);

extern pascal void SetMoviePreferredRate(Movie theMovie, Fixed rate)
 THREEWORDINLINE(0x303C, 0x00F4, 0xAAAA);

extern pascal short GetMoviePreferredVolume(Movie theMovie)
 THREEWORDINLINE(0x303C, 0x00F5, 0xAAAA);

extern pascal void SetMoviePreferredVolume(Movie theMovie, short volume)
 THREEWORDINLINE(0x303C, 0x00F6, 0xAAAA);

extern pascal short GetMovieVolume(Movie theMovie)
 TWOWORDINLINE(0x702E, 0xAAAA);

extern pascal void SetMovieVolume(Movie theMovie, short volume)
 TWOWORDINLINE(0x702F, 0xAAAA);

extern pascal void GetMovieMatrix(Movie theMovie, MatrixRecord *matrix)
 TWOWORDINLINE(0x7031, 0xAAAA);

extern pascal void SetMovieMatrix(Movie theMovie, const MatrixRecord *matrix)
 TWOWORDINLINE(0x7032, 0xAAAA);

extern pascal void GetMoviePreviewTime(Movie theMovie, TimeValue *previewTime, TimeValue *previewDuration)
 TWOWORDINLINE(0x7033, 0xAAAA);

extern pascal void SetMoviePreviewTime(Movie theMovie, TimeValue previewTime, TimeValue previewDuration)
 TWOWORDINLINE(0x7034, 0xAAAA);

extern pascal TimeValue GetMoviePosterTime(Movie theMovie)
 TWOWORDINLINE(0x7035, 0xAAAA);

extern pascal void SetMoviePosterTime(Movie theMovie, TimeValue posterTime)
 TWOWORDINLINE(0x7036, 0xAAAA);

extern pascal void GetMovieSelection(Movie theMovie, TimeValue *selectionTime, TimeValue *selectionDuration)
 TWOWORDINLINE(0x7037, 0xAAAA);

extern pascal void SetMovieSelection(Movie theMovie, TimeValue selectionTime, TimeValue selectionDuration)
 TWOWORDINLINE(0x7038, 0xAAAA);

extern pascal void SetMovieActiveSegment(Movie theMovie, TimeValue startTime, TimeValue duration)
 THREEWORDINLINE(0x303C, 0x015C, 0xAAAA);

extern pascal void GetMovieActiveSegment(Movie theMovie, TimeValue *startTime, TimeValue *duration)
 THREEWORDINLINE(0x303C, 0x015D, 0xAAAA);

extern pascal TimeValue GetMovieTime(Movie theMovie, TimeRecord *currentTime)
 TWOWORDINLINE(0x7039, 0xAAAA);

extern pascal void SetMovieTime(Movie theMovie, const TimeRecord *newtime)
 TWOWORDINLINE(0x703C, 0xAAAA);

extern pascal void SetMovieTimeValue(Movie theMovie, TimeValue newtime)
 TWOWORDINLINE(0x703D, 0xAAAA);

extern pascal UserData GetMovieUserData(Movie theMovie)
 TWOWORDINLINE(0x703E, 0xAAAA);

/*
************************
* Track/Media finding routines
*************************
*/
extern pascal long GetMovieTrackCount(Movie theMovie)
 TWOWORDINLINE(0x703F, 0xAAAA);

extern pascal Track GetMovieTrack(Movie theMovie, long trackID)
 TWOWORDINLINE(0x7040, 0xAAAA);

extern pascal Track GetMovieIndTrack(Movie theMovie, long index)
 THREEWORDINLINE(0x303C, 0x0117, 0xAAAA);

extern pascal Track GetMovieIndTrackType(Movie theMovie, long index, OSType trackType, long flags)
 THREEWORDINLINE(0x303C, 0x0208, 0xAAAA);

extern pascal long GetTrackID(Track theTrack)
 THREEWORDINLINE(0x303C, 0x0127, 0xAAAA);

extern pascal Movie GetTrackMovie(Track theTrack)
 THREEWORDINLINE(0x303C, 0x00D0, 0xAAAA);

/*
************************
* Track creation routines
*************************
*/
extern pascal Track NewMovieTrack(Movie theMovie, Fixed width, Fixed height, short trackVolume)
 THREEWORDINLINE(0x303C, 0x0188, 0xAAAA);

extern pascal void DisposeMovieTrack(Track theTrack)
 TWOWORDINLINE(0x7042, 0xAAAA);

/*
************************
* Track State routines
*************************
*/
extern pascal unsigned long GetTrackCreationTime(Track theTrack)
 TWOWORDINLINE(0x7043, 0xAAAA);

extern pascal unsigned long GetTrackModificationTime(Track theTrack)
 TWOWORDINLINE(0x7044, 0xAAAA);

extern pascal Boolean GetTrackEnabled(Track theTrack)
 TWOWORDINLINE(0x7045, 0xAAAA);

extern pascal void SetTrackEnabled(Track theTrack, Boolean isEnabled)
 TWOWORDINLINE(0x7046, 0xAAAA);

extern pascal long GetTrackUsage(Track theTrack)
 TWOWORDINLINE(0x7047, 0xAAAA);

extern pascal void SetTrackUsage(Track theTrack, long usage)
 TWOWORDINLINE(0x7048, 0xAAAA);

extern pascal TimeValue GetTrackDuration(Track theTrack)
 TWOWORDINLINE(0x704B, 0xAAAA);

extern pascal TimeValue GetTrackOffset(Track theTrack)
 TWOWORDINLINE(0x704C, 0xAAAA);

extern pascal void SetTrackOffset(Track theTrack, TimeValue movieOffsetTime)
 TWOWORDINLINE(0x704D, 0xAAAA);

extern pascal short GetTrackLayer(Track theTrack)
 TWOWORDINLINE(0x7050, 0xAAAA);

extern pascal void SetTrackLayer(Track theTrack, short layer)
 TWOWORDINLINE(0x7051, 0xAAAA);

extern pascal Track GetTrackAlternate(Track theTrack)
 TWOWORDINLINE(0x7052, 0xAAAA);

extern pascal void SetTrackAlternate(Track theTrack, Track alternateT)
 TWOWORDINLINE(0x7053, 0xAAAA);

extern pascal void SetAutoTrackAlternatesEnabled(Movie theMovie, Boolean enable)
 THREEWORDINLINE(0x303C, 0x015E, 0xAAAA);

extern pascal void SelectMovieAlternates(Movie theMovie)
 THREEWORDINLINE(0x303C, 0x015F, 0xAAAA);

extern pascal short GetTrackVolume(Track theTrack)
 TWOWORDINLINE(0x7054, 0xAAAA);

extern pascal void SetTrackVolume(Track theTrack, short volume)
 TWOWORDINLINE(0x7055, 0xAAAA);

extern pascal void GetTrackMatrix(Track theTrack, MatrixRecord *matrix)
 TWOWORDINLINE(0x7056, 0xAAAA);

extern pascal void SetTrackMatrix(Track theTrack, const MatrixRecord *matrix)
 TWOWORDINLINE(0x7057, 0xAAAA);

extern pascal void GetTrackDimensions(Track theTrack, Fixed *width, Fixed *height)
 TWOWORDINLINE(0x705D, 0xAAAA);

extern pascal void SetTrackDimensions(Track theTrack, Fixed width, Fixed height)
 TWOWORDINLINE(0x705E, 0xAAAA);

extern pascal UserData GetTrackUserData(Track theTrack)
 TWOWORDINLINE(0x705F, 0xAAAA);

extern pascal OSErr GetTrackDisplayMatrix(Track theTrack, MatrixRecord *matrix)
 THREEWORDINLINE(0x303C, 0x0263, 0xAAAA);

extern pascal OSErr GetTrackSoundLocalizationSettings(Track theTrack, Handle *settings)
 THREEWORDINLINE(0x303C, 0x0282, 0xAAAA);

extern pascal OSErr SetTrackSoundLocalizationSettings(Track theTrack, Handle settings)
 THREEWORDINLINE(0x303C, 0x0283, 0xAAAA);

/*
************************
* get Media routines
*************************
*/
extern pascal Media NewTrackMedia(Track theTrack, OSType mediaType, TimeScale timeScale, Handle dataRef, OSType dataRefType)
 THREEWORDINLINE(0x303C, 0x018E, 0xAAAA);

extern pascal void DisposeTrackMedia(Media theMedia)
 TWOWORDINLINE(0x7061, 0xAAAA);

extern pascal Media GetTrackMedia(Track theTrack)
 TWOWORDINLINE(0x7062, 0xAAAA);

extern pascal Track GetMediaTrack(Media theMedia)
 THREEWORDINLINE(0x303C, 0x00C5, 0xAAAA);

/*
************************
* Media State routines
*************************
*/
extern pascal unsigned long GetMediaCreationTime(Media theMedia)
 TWOWORDINLINE(0x7066, 0xAAAA);

extern pascal unsigned long GetMediaModificationTime(Media theMedia)
 TWOWORDINLINE(0x7067, 0xAAAA);

extern pascal TimeScale GetMediaTimeScale(Media theMedia)
 TWOWORDINLINE(0x7068, 0xAAAA);

extern pascal void SetMediaTimeScale(Media theMedia, TimeScale timeScale)
 TWOWORDINLINE(0x7069, 0xAAAA);

extern pascal TimeValue GetMediaDuration(Media theMedia)
 TWOWORDINLINE(0x706A, 0xAAAA);

extern pascal short GetMediaLanguage(Media theMedia)
 TWOWORDINLINE(0x706B, 0xAAAA);

extern pascal void SetMediaLanguage(Media theMedia, short language)
 TWOWORDINLINE(0x706C, 0xAAAA);

extern pascal short GetMediaQuality(Media theMedia)
 TWOWORDINLINE(0x706D, 0xAAAA);

extern pascal void SetMediaQuality(Media theMedia, short quality)
 TWOWORDINLINE(0x706E, 0xAAAA);

extern pascal void GetMediaHandlerDescription(Media theMedia, OSType *mediaType, Str255 creatorName, OSType *creatorManufacturer)
 TWOWORDINLINE(0x706F, 0xAAAA);

extern pascal UserData GetMediaUserData(Media theMedia)
 TWOWORDINLINE(0x7070, 0xAAAA);

extern pascal OSErr GetMediaInputMap(Media theMedia, QTAtomContainer *inputMap)
 THREEWORDINLINE(0x303C, 0x0249, 0xAAAA);

extern pascal OSErr SetMediaInputMap(Media theMedia, QTAtomContainer inputMap)
 THREEWORDINLINE(0x303C, 0x024A, 0xAAAA);

/*
************************
* Media Handler routines
*************************
*/
extern pascal MediaHandler GetMediaHandler(Media theMedia)
 TWOWORDINLINE(0x7071, 0xAAAA);

extern pascal OSErr SetMediaHandler(Media theMedia, MediaHandlerComponent mH)
 THREEWORDINLINE(0x303C, 0x0190, 0xAAAA);

/*
************************
* Media's Data routines
*************************
*/
extern pascal OSErr BeginMediaEdits(Media theMedia)
 TWOWORDINLINE(0x7072, 0xAAAA);

extern pascal OSErr EndMediaEdits(Media theMedia)
 TWOWORDINLINE(0x7073, 0xAAAA);

extern pascal OSErr SetMediaDefaultDataRefIndex(Media theMedia, short index)
 THREEWORDINLINE(0x303C, 0x01E0, 0xAAAA);

extern pascal void GetMediaDataHandlerDescription(Media theMedia, short index, OSType *dhType, Str255 creatorName, OSType *creatorManufacturer)
 THREEWORDINLINE(0x303C, 0x019E, 0xAAAA);

extern pascal DataHandler GetMediaDataHandler(Media theMedia, short index)
 THREEWORDINLINE(0x303C, 0x019F, 0xAAAA);

extern pascal OSErr SetMediaDataHandler(Media theMedia, short index, DataHandlerComponent dataHandler)
 THREEWORDINLINE(0x303C, 0x01A0, 0xAAAA);

extern pascal Component GetDataHandler(Handle dataRef, OSType dataHandlerSubType, long flags)
 THREEWORDINLINE(0x303C, 0x01ED, 0xAAAA);

/*
************************
* Media Sample Table Routines
*************************
*/
extern pascal long GetMediaSampleDescriptionCount(Media theMedia)
 TWOWORDINLINE(0x7077, 0xAAAA);

extern pascal void GetMediaSampleDescription(Media theMedia, long index, SampleDescriptionHandle descH)
 TWOWORDINLINE(0x7078, 0xAAAA);

extern pascal OSErr SetMediaSampleDescription(Media theMedia, long index, SampleDescriptionHandle descH)
 THREEWORDINLINE(0x303C, 0x01D0, 0xAAAA);

extern pascal long GetMediaSampleCount(Media theMedia)
 TWOWORDINLINE(0x7079, 0xAAAA);

extern pascal void SampleNumToMediaTime(Media theMedia, long logicalSampleNum, TimeValue *sampleTime, TimeValue *sampleDuration)
 TWOWORDINLINE(0x707A, 0xAAAA);

extern pascal void MediaTimeToSampleNum(Media theMedia, TimeValue time, long *sampleNum, TimeValue *sampleTime, TimeValue *sampleDuration)
 TWOWORDINLINE(0x707B, 0xAAAA);

extern pascal OSErr AddMediaSample(Media theMedia, Handle dataIn, long inOffset, unsigned long size, TimeValue durationPerSample, SampleDescriptionHandle sampleDescriptionH, long numberOfSamples, short sampleFlags, TimeValue *sampleTime)
 TWOWORDINLINE(0x707C, 0xAAAA);

extern pascal OSErr AddMediaSampleReference(Media theMedia, long dataOffset, unsigned long size, TimeValue durationPerSample, SampleDescriptionHandle sampleDescriptionH, long numberOfSamples, short sampleFlags, TimeValue *sampleTime)
 TWOWORDINLINE(0x707D, 0xAAAA);

extern pascal OSErr AddMediaSampleReferences(Media theMedia, SampleDescriptionHandle sampleDescriptionH, long numberOfSamples, SampleReferencePtr sampleRefs, TimeValue *sampleTime)
 THREEWORDINLINE(0x303C, 0x01F7, 0xAAAA);

extern pascal OSErr GetMediaSample(Media theMedia, Handle dataOut, long maxSizeToGrow, long *size, TimeValue time, TimeValue *sampleTime, TimeValue *durationPerSample, SampleDescriptionHandle sampleDescriptionH, long *sampleDescriptionIndex, long maxNumberOfSamples, long *numberOfSamples, short *sampleFlags)
 TWOWORDINLINE(0x707E, 0xAAAA);

extern pascal OSErr GetMediaSampleReference(Media theMedia, long *dataOffset, long *size, TimeValue time, TimeValue *sampleTime, TimeValue *durationPerSample, SampleDescriptionHandle sampleDescriptionH, long *sampleDescriptionIndex, long maxNumberOfSamples, long *numberOfSamples, short *sampleFlags)
 TWOWORDINLINE(0x707F, 0xAAAA);

extern pascal OSErr GetMediaSampleReferences(Media theMedia, TimeValue time, TimeValue *sampleTime, SampleDescriptionHandle sampleDescriptionH, long *sampleDescriptionIndex, long maxNumberOfEntries, long *actualNumberofEntries, SampleReferencePtr sampleRefs)
 THREEWORDINLINE(0x303C, 0x0235, 0xAAAA);

extern pascal OSErr SetMediaPreferredChunkSize(Media theMedia, long maxChunkSize)
 THREEWORDINLINE(0x303C, 0x01F8, 0xAAAA);

extern pascal OSErr GetMediaPreferredChunkSize(Media theMedia, long *maxChunkSize)
 THREEWORDINLINE(0x303C, 0x01F9, 0xAAAA);

extern pascal OSErr SetMediaShadowSync(Media theMedia, long frameDiffSampleNum, long syncSampleNum)
 THREEWORDINLINE(0x303C, 0x0121, 0xAAAA);

extern pascal OSErr GetMediaShadowSync(Media theMedia, long frameDiffSampleNum, long *syncSampleNum)
 THREEWORDINLINE(0x303C, 0x0122, 0xAAAA);

/*
************************
* Editing Routines
*************************
*/
extern pascal OSErr InsertMediaIntoTrack(Track theTrack, TimeValue trackStart, TimeValue mediaTime, TimeValue mediaDuration, Fixed mediaRate)
 THREEWORDINLINE(0x303C, 0x0183, 0xAAAA);

extern pascal OSErr InsertTrackSegment(Track srcTrack, Track dstTrack, TimeValue srcIn, TimeValue srcDuration, TimeValue dstIn)
 THREEWORDINLINE(0x303C, 0x0085, 0xAAAA);

extern pascal OSErr InsertMovieSegment(Movie srcMovie, Movie dstMovie, TimeValue srcIn, TimeValue srcDuration, TimeValue dstIn)
 THREEWORDINLINE(0x303C, 0x0086, 0xAAAA);

extern pascal OSErr InsertEmptyTrackSegment(Track dstTrack, TimeValue dstIn, TimeValue dstDuration)
 THREEWORDINLINE(0x303C, 0x0087, 0xAAAA);

extern pascal OSErr InsertEmptyMovieSegment(Movie dstMovie, TimeValue dstIn, TimeValue dstDuration)
 THREEWORDINLINE(0x303C, 0x0088, 0xAAAA);

extern pascal OSErr DeleteTrackSegment(Track theTrack, TimeValue startTime, TimeValue duration)
 THREEWORDINLINE(0x303C, 0x0089, 0xAAAA);

extern pascal OSErr DeleteMovieSegment(Movie theMovie, TimeValue startTime, TimeValue duration)
 THREEWORDINLINE(0x303C, 0x008A, 0xAAAA);

extern pascal OSErr ScaleTrackSegment(Track theTrack, TimeValue startTime, TimeValue oldDuration, TimeValue newDuration)
 THREEWORDINLINE(0x303C, 0x008B, 0xAAAA);

extern pascal OSErr ScaleMovieSegment(Movie theMovie, TimeValue startTime, TimeValue oldDuration, TimeValue newDuration)
 THREEWORDINLINE(0x303C, 0x008C, 0xAAAA);

/*
************************
* Hi-level Editing Routines
*************************
*/
extern pascal Movie CutMovieSelection(Movie theMovie)
 THREEWORDINLINE(0x303C, 0x008D, 0xAAAA);

extern pascal Movie CopyMovieSelection(Movie theMovie)
 THREEWORDINLINE(0x303C, 0x008E, 0xAAAA);

extern pascal void PasteMovieSelection(Movie theMovie, Movie src)
 THREEWORDINLINE(0x303C, 0x008F, 0xAAAA);

extern pascal void AddMovieSelection(Movie theMovie, Movie src)
 THREEWORDINLINE(0x303C, 0x0152, 0xAAAA);

extern pascal void ClearMovieSelection(Movie theMovie)
 THREEWORDINLINE(0x303C, 0x00E1, 0xAAAA);

extern pascal OSErr PasteHandleIntoMovie(Handle h, OSType handleType, Movie theMovie, long flags, ComponentInstance userComp)
 THREEWORDINLINE(0x303C, 0x00CB, 0xAAAA);

extern pascal OSErr PutMovieIntoTypedHandle(Movie theMovie, Track targetTrack, OSType handleType, Handle publicMovie, TimeValue start, TimeValue dur, long flags, ComponentInstance userComp)
 THREEWORDINLINE(0x303C, 0x01CD, 0xAAAA);

extern pascal Component IsScrapMovie(Track targetTrack)
 THREEWORDINLINE(0x303C, 0x00CC, 0xAAAA);

/*
************************
* Middle-level Editing Routines
*************************
*/
extern pascal OSErr CopyTrackSettings(Track srcTrack, Track dstTrack)
 THREEWORDINLINE(0x303C, 0x0153, 0xAAAA);

extern pascal OSErr CopyMovieSettings(Movie srcMovie, Movie dstMovie)
 THREEWORDINLINE(0x303C, 0x0154, 0xAAAA);

extern pascal OSErr AddEmptyTrackToMovie(Track srcTrack, Movie dstMovie, Handle dataRef, OSType dataRefType, Track *dstTrack)
 TWOWORDINLINE(0x7074, 0xAAAA);

/*
************************
* movie & track edit state routines
*************************
*/
extern pascal MovieEditState NewMovieEditState(Movie theMovie)
 THREEWORDINLINE(0x303C, 0x0104, 0xAAAA);

extern pascal OSErr UseMovieEditState(Movie theMovie, MovieEditState toState)
 THREEWORDINLINE(0x303C, 0x0105, 0xAAAA);

extern pascal OSErr DisposeMovieEditState(MovieEditState state)
 THREEWORDINLINE(0x303C, 0x0106, 0xAAAA);

extern pascal TrackEditState NewTrackEditState(Track theTrack)
 THREEWORDINLINE(0x303C, 0x0107, 0xAAAA);

extern pascal OSErr UseTrackEditState(Track theTrack, TrackEditState state)
 THREEWORDINLINE(0x303C, 0x0108, 0xAAAA);

extern pascal OSErr DisposeTrackEditState(TrackEditState state)
 THREEWORDINLINE(0x303C, 0x0109, 0xAAAA);

/*
************************
* track reference routines
*************************
*/
extern pascal OSErr AddTrackReference(Track theTrack, Track refTrack, OSType refType, long *addedIndex)
 THREEWORDINLINE(0x303C, 0x01F0, 0xAAAA);

extern pascal OSErr DeleteTrackReference(Track theTrack, OSType refType, long index)
 THREEWORDINLINE(0x303C, 0x01F1, 0xAAAA);

extern pascal OSErr SetTrackReference(Track theTrack, Track refTrack, OSType refType, long index)
 THREEWORDINLINE(0x303C, 0x01F2, 0xAAAA);

extern pascal Track GetTrackReference(Track theTrack, OSType refType, long index)
 THREEWORDINLINE(0x303C, 0x01F3, 0xAAAA);

extern pascal OSType GetNextTrackReferenceType(Track theTrack, OSType refType)
 THREEWORDINLINE(0x303C, 0x01F4, 0xAAAA);

extern pascal long GetTrackReferenceCount(Track theTrack, OSType refType)
 THREEWORDINLINE(0x303C, 0x01F5, 0xAAAA);

/*
************************
* high level file conversion routines
*************************
*/
extern pascal OSErr ConvertFileToMovieFile(const FSSpec *inputFile, const FSSpec *outputFile, OSType creator, ScriptCode scriptTag, short *resID, long flags, ComponentInstance userComp, MovieProgressUPP proc, long refCon)
 THREEWORDINLINE(0x303C, 0x01CB, 0xAAAA);

extern pascal OSErr ConvertMovieToFile(Movie theMovie, Track onlyTrack, FSSpec *outputFile, OSType fileType, OSType creator, ScriptCode scriptTag, short *resID, long flags, ComponentInstance userComp)
 THREEWORDINLINE(0x303C, 0x01CC, 0xAAAA);

/*
************************
* Movie Timebase Conversion Routines
*************************
*/
extern pascal TimeValue TrackTimeToMediaTime(TimeValue value, Track theTrack)
 THREEWORDINLINE(0x303C, 0x0096, 0xAAAA);

extern pascal Fixed GetTrackEditRate(Track theTrack, TimeValue atTime)
 THREEWORDINLINE(0x303C, 0x0123, 0xAAAA);

/*
************************
* Miscellaneous Routines
*************************
*/
extern pascal long GetMovieDataSize(Movie theMovie, TimeValue startTime, TimeValue duration)
 THREEWORDINLINE(0x303C, 0x0098, 0xAAAA);

extern pascal long GetTrackDataSize(Track theTrack, TimeValue startTime, TimeValue duration)
 THREEWORDINLINE(0x303C, 0x0149, 0xAAAA);

extern pascal long GetMediaDataSize(Media theMedia, TimeValue startTime, TimeValue duration)
 THREEWORDINLINE(0x303C, 0x0099, 0xAAAA);

extern pascal Boolean PtInMovie(Movie theMovie, Point pt)
 THREEWORDINLINE(0x303C, 0x009A, 0xAAAA);

extern pascal Boolean PtInTrack(Track theTrack, Point pt)
 THREEWORDINLINE(0x303C, 0x009B, 0xAAAA);

/*
************************
* Group Selection Routines
*************************
*/
extern pascal void SetMovieLanguage(Movie theMovie, long language)
 THREEWORDINLINE(0x303C, 0x009C, 0xAAAA);

/*
************************
* User Data
*************************
*/
extern pascal OSErr GetUserData(UserData theUserData, Handle data, OSType udType, long index)
 THREEWORDINLINE(0x303C, 0x009E, 0xAAAA);

extern pascal OSErr AddUserData(UserData theUserData, Handle data, OSType udType)
 THREEWORDINLINE(0x303C, 0x009F, 0xAAAA);

extern pascal OSErr RemoveUserData(UserData theUserData, OSType udType, long index)
 THREEWORDINLINE(0x303C, 0x00A0, 0xAAAA);

extern pascal short CountUserDataType(UserData theUserData, OSType udType)
 THREEWORDINLINE(0x303C, 0x014B, 0xAAAA);

extern pascal long GetNextUserDataType(UserData theUserData, OSType udType)
 THREEWORDINLINE(0x303C, 0x01A5, 0xAAAA);

extern pascal OSErr GetUserDataItem(UserData theUserData, void *data, long size, OSType udType, long index)
 THREEWORDINLINE(0x303C, 0x0126, 0xAAAA);

extern pascal OSErr SetUserDataItem(UserData theUserData, void *data, long size, OSType udType, long index)
 THREEWORDINLINE(0x303C, 0x012E, 0xAAAA);

extern pascal OSErr AddUserDataText(UserData theUserData, Handle data, OSType udType, long index, short itlRegionTag)
 THREEWORDINLINE(0x303C, 0x014C, 0xAAAA);

extern pascal OSErr GetUserDataText(UserData theUserData, Handle data, OSType udType, long index, short itlRegionTag)
 THREEWORDINLINE(0x303C, 0x014D, 0xAAAA);

extern pascal OSErr RemoveUserDataText(UserData theUserData, OSType udType, long index, short itlRegionTag)
 THREEWORDINLINE(0x303C, 0x014E, 0xAAAA);

extern pascal OSErr NewUserData(UserData *theUserData)
 THREEWORDINLINE(0x303C, 0x012F, 0xAAAA);

extern pascal OSErr DisposeUserData(UserData theUserData)
 THREEWORDINLINE(0x303C, 0x0130, 0xAAAA);

extern pascal OSErr NewUserDataFromHandle(Handle h, UserData *theUserData)
 THREEWORDINLINE(0x303C, 0x0131, 0xAAAA);

extern pascal OSErr PutUserDataIntoHandle(UserData theUserData, Handle h)
 THREEWORDINLINE(0x303C, 0x0132, 0xAAAA);

extern pascal void GetMediaNextInterestingTime(Media theMedia, short interestingTimeFlags, TimeValue time, Fixed rate, TimeValue *interestingTime, TimeValue *interestingDuration)
 THREEWORDINLINE(0x303C, 0x016D, 0xAAAA);

extern pascal void GetTrackNextInterestingTime(Track theTrack, short interestingTimeFlags, TimeValue time, Fixed rate, TimeValue *interestingTime, TimeValue *interestingDuration)
 THREEWORDINLINE(0x303C, 0x00E2, 0xAAAA);

extern pascal void GetMovieNextInterestingTime(Movie theMovie, short interestingTimeFlags, short numMediaTypes, const OSType *whichMediaTypes, TimeValue time, Fixed rate, TimeValue *interestingTime, TimeValue *interestingDuration)
 THREEWORDINLINE(0x303C, 0x010E, 0xAAAA);

extern pascal OSErr CreateMovieFile(const FSSpec *fileSpec, OSType creator, ScriptCode scriptTag, long createMovieFileFlags, short *resRefNum, Movie *newmovie)
 THREEWORDINLINE(0x303C, 0x0191, 0xAAAA);

extern pascal OSErr OpenMovieFile(const FSSpec *fileSpec, short *resRefNum, SInt8 permission)
 THREEWORDINLINE(0x303C, 0x0192, 0xAAAA);

extern pascal OSErr CloseMovieFile(short resRefNum)
 THREEWORDINLINE(0x303C, 0x00D5, 0xAAAA);

extern pascal OSErr DeleteMovieFile(const FSSpec *fileSpec)
 THREEWORDINLINE(0x303C, 0x0175, 0xAAAA);

extern pascal OSErr NewMovieFromFile(Movie *theMovie, short resRefNum, short *resId, StringPtr resName, short newMovieFlags, Boolean *dataRefWasChanged)
 THREEWORDINLINE(0x303C, 0x00F0, 0xAAAA);

extern pascal OSErr NewMovieFromHandle(Movie *theMovie, Handle h, short newMovieFlags, Boolean *dataRefWasChanged)
 THREEWORDINLINE(0x303C, 0x00F1, 0xAAAA);

extern pascal OSErr NewMovieFromDataFork(Movie *theMovie, short fRefNum, long fileOffset, short newMovieFlags, Boolean *dataRefWasChanged)
 THREEWORDINLINE(0x303C, 0x01B3, 0xAAAA);

extern pascal OSErr NewMovieFromUserProc(Movie *m, short flags, Boolean *dataRefWasChanged, GetMovieUPP getProc, void *refCon, Handle defaultDataRef, OSType dataRefType)
 THREEWORDINLINE(0x303C, 0x01EC, 0xAAAA);

extern pascal OSErr NewMovieFromDataRef(Movie *m, short flags, short *id, Handle dataRef, OSType dataRefType)
 THREEWORDINLINE(0x303C, 0x0220, 0xAAAA);

extern pascal OSErr AddMovieResource(Movie theMovie, short resRefNum, short *resId, ConstStr255Param resName)
 THREEWORDINLINE(0x303C, 0x00D7, 0xAAAA);

extern pascal OSErr UpdateMovieResource(Movie theMovie, short resRefNum, short resId, ConstStr255Param resName)
 THREEWORDINLINE(0x303C, 0x00D8, 0xAAAA);

extern pascal OSErr RemoveMovieResource(short resRefNum, short resId)
 THREEWORDINLINE(0x303C, 0x0176, 0xAAAA);

extern pascal Boolean HasMovieChanged(Movie theMovie)
 THREEWORDINLINE(0x303C, 0x00D9, 0xAAAA);

extern pascal void ClearMovieChanged(Movie theMovie)
 THREEWORDINLINE(0x303C, 0x0113, 0xAAAA);

extern pascal OSErr SetMovieDefaultDataRef(Movie theMovie, Handle dataRef, OSType dataRefType)
 THREEWORDINLINE(0x303C, 0x01C1, 0xAAAA);

extern pascal OSErr GetMovieDefaultDataRef(Movie theMovie, Handle *dataRef, OSType *dataRefType)
 THREEWORDINLINE(0x303C, 0x01D2, 0xAAAA);

extern pascal OSErr SetMovieColorTable(Movie theMovie, CTabHandle ctab)
 THREEWORDINLINE(0x303C, 0x0205, 0xAAAA);

extern pascal OSErr GetMovieColorTable(Movie theMovie, CTabHandle *ctab)
 THREEWORDINLINE(0x303C, 0x0206, 0xAAAA);

extern pascal void FlattenMovie(Movie theMovie, long movieFlattenFlags, const FSSpec *theFile, OSType creator, ScriptCode scriptTag, long createMovieFileFlags, short *resId, ConstStr255Param resName)
 THREEWORDINLINE(0x303C, 0x019B, 0xAAAA);

extern pascal Movie FlattenMovieData(Movie theMovie, long movieFlattenFlags, const FSSpec *theFile, OSType creator, ScriptCode scriptTag, long createMovieFileFlags)
 THREEWORDINLINE(0x303C, 0x019C, 0xAAAA);

extern pascal void SetMovieProgressProc(Movie theMovie, MovieProgressUPP p, long refcon)
 THREEWORDINLINE(0x303C, 0x019A, 0xAAAA);

extern pascal OSErr MovieSearchText(Movie theMovie, Ptr text, long size, long searchFlags, Track *searchTrack, TimeValue *searchTime, long *searchOffset)
 THREEWORDINLINE(0x303C, 0x0207, 0xAAAA);

extern pascal void GetPosterBox(Movie theMovie, Rect *boxRect)
 THREEWORDINLINE(0x303C, 0x016F, 0xAAAA);

extern pascal void SetPosterBox(Movie theMovie, const Rect *boxRect)
 THREEWORDINLINE(0x303C, 0x0170, 0xAAAA);

extern pascal RgnHandle GetMovieSegmentDisplayBoundsRgn(Movie theMovie, TimeValue time, TimeValue duration)
 THREEWORDINLINE(0x303C, 0x016C, 0xAAAA);

extern pascal RgnHandle GetTrackSegmentDisplayBoundsRgn(Track theTrack, TimeValue time, TimeValue duration)
 THREEWORDINLINE(0x303C, 0x016B, 0xAAAA);

extern pascal void SetMovieCoverProcs(Movie theMovie, MovieRgnCoverUPP uncoverProc, MovieRgnCoverUPP coverProc, long refcon)
 THREEWORDINLINE(0x303C, 0x0179, 0xAAAA);

extern pascal OSErr GetMovieCoverProcs(Movie theMovie, MovieRgnCoverUPP *uncoverProc, MovieRgnCoverUPP *coverProc, long *refcon)
 THREEWORDINLINE(0x303C, 0x01DD, 0xAAAA);

extern pascal ComponentResult GetTrackStatus(Track theTrack)
 THREEWORDINLINE(0x303C, 0x0172, 0xAAAA);

extern pascal ComponentResult GetMovieStatus(Movie theMovie, Track *firstProblemTrack)
 THREEWORDINLINE(0x303C, 0x0173, 0xAAAA);

/*
***
	Movie Controller support routines
***
*/
extern pascal ComponentInstance NewMovieController(Movie theMovie, const Rect *movieRect, long someFlags)
 THREEWORDINLINE(0x303C, 0x018A, 0xAAAA);

extern pascal void DisposeMovieController(ComponentInstance mc)
 THREEWORDINLINE(0x303C, 0x018B, 0xAAAA);

extern pascal void ShowMovieInformation(Movie theMovie, ModalFilterUPP filterProc, long refCon)
 THREEWORDINLINE(0x303C, 0x0209, 0xAAAA);

/*
****
	Scrap routines
****
*/
extern pascal OSErr PutMovieOnScrap(Movie theMovie, long movieScrapFlags)
 THREEWORDINLINE(0x303C, 0x018C, 0xAAAA);

extern pascal Movie NewMovieFromScrap(long newMovieFlags)
 THREEWORDINLINE(0x303C, 0x018D, 0xAAAA);

/*
****
	DataRef routines
****
*/
extern pascal OSErr GetMediaDataRef(Media theMedia, short index, Handle *dataRef, OSType *dataRefType, long *dataRefAttributes)
 THREEWORDINLINE(0x303C, 0x0197, 0xAAAA);

extern pascal OSErr SetMediaDataRef(Media theMedia, short index, Handle dataRef, OSType dataRefType)
 THREEWORDINLINE(0x303C, 0x01C9, 0xAAAA);

extern pascal OSErr SetMediaDataRefAttributes(Media theMedia, short index, long dataRefAttributes)
 THREEWORDINLINE(0x303C, 0x01CA, 0xAAAA);

extern pascal OSErr AddMediaDataRef(Media theMedia, short *index, Handle dataRef, OSType dataRefType)
 THREEWORDINLINE(0x303C, 0x0198, 0xAAAA);

extern pascal OSErr GetMediaDataRefCount(Media theMedia, short *count)
 THREEWORDINLINE(0x303C, 0x0199, 0xAAAA);

/*
****
	Playback hint routines
****
*/
extern pascal void SetMoviePlayHints(Movie theMovie, long flags, long flagsMask)
 THREEWORDINLINE(0x303C, 0x01A1, 0xAAAA);

extern pascal void SetMediaPlayHints(Media theMedia, long flags, long flagsMask)
 THREEWORDINLINE(0x303C, 0x01A2, 0xAAAA);

/*
****
	Load time track hints
****
*/

enum {
	preloadAlways				= 1L << 0,
	preloadOnlyIfEnabled		= 1L << 1
};

extern pascal void SetTrackLoadSettings(Track theTrack, TimeValue preloadTime, TimeValue preloadDuration, long preloadFlags, long defaultHints)
 THREEWORDINLINE(0x303C, 0x01E3, 0xAAAA);

extern pascal void GetTrackLoadSettings(Track theTrack, TimeValue *preloadTime, TimeValue *preloadDuration, long *preloadFlags, long *defaultHints)
 THREEWORDINLINE(0x303C, 0x01E4, 0xAAAA);

/*
****
	Big screen TV
****
*/

enum {
	fullScreenHideCursor		= 1L << 0,
	fullScreenAllowEvents		= 1L << 1,
	fullScreenDontChangeMenuBar	= 1L << 2,
	fullScreenPreflightSize		= 1L << 3
};

extern pascal OSErr BeginFullScreen(Ptr *restoreState, GDHandle whichGD, short *desiredWidth, short *desiredHeight, WindowPtr *newWindow, RGBColor *eraseColor, long flags)
 THREEWORDINLINE(0x303C, 0x0233, 0xAAAA);

extern pascal OSErr EndFullScreen(Ptr fullState, long flags)
 THREEWORDINLINE(0x303C, 0x0234, 0xAAAA);

/*
****
	Sprite Toolbox
****
*/

enum {
	kBackgroundSpriteLayerNum	= 32767
};

/*  Sprite Properties*/

enum {
	kSpritePropertyMatrix		= 1,
	kSpritePropertyImageDescription = 2,
	kSpritePropertyImageDataPtr	= 3,
	kSpritePropertyVisible		= 4,
	kSpritePropertyLayer		= 5,
	kSpritePropertyGraphicsMode	= 6,
	kSpritePropertyImageIndex	= 100,
	kSpriteTrackPropertyBackgroundColor = 101,
	kSpriteTrackPropertyOffscreenBitDepth = 102,
	kSpriteTrackPropertySampleFormat = 103
};

/* flagsIn for SpriteWorldIdle*/

enum {
	kOnlyDrawToSpriteWorld		= 1L << 0,
	kSpriteWorldPreflight		= 1L << 1
};

/* flagsOut for SpriteWorldIdle*/

enum {
	kSpriteWorldDidDraw			= 1L << 0,
	kSpriteWorldNeedsToDraw		= 1L << 1
};

/* flags for sprite track sample format*/

enum {
	kKeyFrameAndSingleOverride	= 1L << 1,
	kKeyFrameAndAllOverrides	= 1L << 2
};

extern pascal OSErr NewSpriteWorld(SpriteWorld *newSpriteWorld, GWorldPtr destination, GWorldPtr spriteLayer, RGBColor *backgroundColor, GWorldPtr background)
 THREEWORDINLINE(0x303C, 0x0239, 0xAAAA);

extern pascal void DisposeSpriteWorld(SpriteWorld theSpriteWorld)
 THREEWORDINLINE(0x303C, 0x023A, 0xAAAA);

extern pascal OSErr SetSpriteWorldClip(SpriteWorld theSpriteWorld, RgnHandle clipRgn)
 THREEWORDINLINE(0x303C, 0x023B, 0xAAAA);

extern pascal OSErr SetSpriteWorldMatrix(SpriteWorld theSpriteWorld, const MatrixRecord *matrix)
 THREEWORDINLINE(0x303C, 0x023C, 0xAAAA);

extern pascal OSErr SpriteWorldIdle(SpriteWorld theSpriteWorld, long flagsIn, long *flagsOut)
 THREEWORDINLINE(0x303C, 0x023D, 0xAAAA);

extern pascal OSErr InvalidateSpriteWorld(SpriteWorld theSpriteWorld, Rect *invalidArea)
 THREEWORDINLINE(0x303C, 0x023E, 0xAAAA);

extern pascal OSErr SpriteWorldHitTest(SpriteWorld theSpriteWorld, long flags, Point loc, Sprite *spriteHit)
 THREEWORDINLINE(0x303C, 0x0246, 0xAAAA);

extern pascal OSErr SpriteHitTest(Sprite theSprite, long flags, Point loc, Boolean *wasHit)
 THREEWORDINLINE(0x303C, 0x0247, 0xAAAA);

extern pascal void DisposeAllSprites(SpriteWorld theSpriteWorld)
 THREEWORDINLINE(0x303C, 0x023F, 0xAAAA);

extern pascal OSErr NewSprite(Sprite *newSprite, SpriteWorld itsSpriteWorld, ImageDescriptionHandle idh, Ptr imageDataPtr, MatrixRecord *matrix, Boolean visible, short layer)
 THREEWORDINLINE(0x303C, 0x0240, 0xAAAA);

extern pascal void DisposeSprite(Sprite theSprite)
 THREEWORDINLINE(0x303C, 0x0241, 0xAAAA);

extern pascal void InvalidateSprite(Sprite theSprite)
 THREEWORDINLINE(0x303C, 0x0242, 0xAAAA);

extern pascal OSErr SetSpriteProperty(Sprite theSprite, long propertyType, void *propertyValue)
 THREEWORDINLINE(0x303C, 0x0243, 0xAAAA);

extern pascal OSErr GetSpriteProperty(Sprite theSprite, long propertyType, void *propertyValue)
 THREEWORDINLINE(0x303C, 0x0244, 0xAAAA);

/*
****
	QT Atom Data Support
****
*/

enum {
	kParentAtomIsContainer		= 0
};

/* create and dispose QTAtomContainer objects*/
extern pascal OSErr QTNewAtomContainer(QTAtomContainer *atomData)
 THREEWORDINLINE(0x303C, 0x020C, 0xAAAA);

extern pascal OSErr QTDisposeAtomContainer(QTAtomContainer atomData)
 THREEWORDINLINE(0x303C, 0x020D, 0xAAAA);

/* locating nested atoms within QTAtomContainer container*/
extern pascal QTAtomType QTGetNextChildType(QTAtomContainer container, QTAtom parentAtom, QTAtomType currentChildType)
 THREEWORDINLINE(0x303C, 0x020E, 0xAAAA);

extern pascal short QTCountChildrenOfType(QTAtomContainer container, QTAtom parentAtom, QTAtomType childType)
 THREEWORDINLINE(0x303C, 0x020F, 0xAAAA);

extern pascal QTAtom QTFindChildByIndex(QTAtomContainer container, QTAtom parentAtom, QTAtomType atomType, short index, QTAtomID *id)
 THREEWORDINLINE(0x303C, 0x0210, 0xAAAA);

extern pascal QTAtom QTFindChildByID(QTAtomContainer container, QTAtom parentAtom, QTAtomType atomType, QTAtomID id, short *index)
 THREEWORDINLINE(0x303C, 0x021D, 0xAAAA);

extern pascal OSErr QTNextChildAnyType(QTAtomContainer container, QTAtom parentAtom, QTAtom currentChild, QTAtom *nextChild)
 THREEWORDINLINE(0x303C, 0x0200, 0xAAAA);

/* set a leaf atom's data*/
extern pascal OSErr QTSetAtomData(QTAtomContainer container, QTAtom atom, long dataSize, void *atomData)
 THREEWORDINLINE(0x303C, 0x0211, 0xAAAA);

/* extracting data*/
extern pascal OSErr QTCopyAtomDataToHandle(QTAtomContainer container, QTAtom atom, Handle targetHandle)
 THREEWORDINLINE(0x303C, 0x0212, 0xAAAA);

extern pascal OSErr QTCopyAtomDataToPtr(QTAtomContainer container, QTAtom atom, Boolean sizeOrLessOK, long size, void *targetPtr, long *actualSize)
 THREEWORDINLINE(0x303C, 0x0213, 0xAAAA);

extern pascal OSErr QTGetAtomTypeAndID(QTAtomContainer container, QTAtom atom, QTAtomType *atomType, QTAtomID *id)
 THREEWORDINLINE(0x303C, 0x0232, 0xAAAA);

/* extract a copy of an atom and all of it's children, caller disposes*/
extern pascal OSErr QTCopyAtom(QTAtomContainer container, QTAtom atom, QTAtomContainer *targetContainer)
 THREEWORDINLINE(0x303C, 0x0214, 0xAAAA);

/* obtaining direct reference to atom data*/
extern pascal OSErr QTLockContainer(QTAtomContainer container)
 THREEWORDINLINE(0x303C, 0x0215, 0xAAAA);

extern pascal OSErr QTGetAtomDataPtr(QTAtomContainer container, QTAtom atom, long *dataSize, Ptr *atomData)
 THREEWORDINLINE(0x303C, 0x0216, 0xAAAA);

extern pascal OSErr QTUnlockContainer(QTAtomContainer container)
 THREEWORDINLINE(0x303C, 0x0217, 0xAAAA);

/*
 building QTAtomContainer trees
 creates and inserts new atom at specified index, existing atoms at or after index are moved toward end of list
 used for Top-Down tree creation
*/
extern pascal OSErr QTInsertChild(QTAtomContainer container, QTAtom parentAtom, QTAtomType atomType, QTAtomID id, short index, long dataSize, void *data, QTAtom *newAtom)
 THREEWORDINLINE(0x303C, 0x0218, 0xAAAA);

/* inserts children from childrenContainer as children of parentAtom*/
extern pascal OSErr QTInsertChildren(QTAtomContainer container, QTAtom parentAtom, QTAtomContainer childrenContainer)
 THREEWORDINLINE(0x303C, 0x0219, 0xAAAA);

/* destruction*/
extern pascal OSErr QTRemoveAtom(QTAtomContainer container, QTAtom atom)
 THREEWORDINLINE(0x303C, 0x021A, 0xAAAA);

extern pascal OSErr QTRemoveChildren(QTAtomContainer container, QTAtom atom)
 THREEWORDINLINE(0x303C, 0x021B, 0xAAAA);

/* replacement must be same type as target*/
extern pascal OSErr QTReplaceAtom(QTAtomContainer targetContainer, QTAtom targetAtom, QTAtomContainer replacementContainer, QTAtom replacementAtom)
 THREEWORDINLINE(0x303C, 0x021C, 0xAAAA);

extern pascal OSErr QTSwapAtoms(QTAtomContainer container, QTAtom atom1, QTAtom atom2)
 THREEWORDINLINE(0x303C, 0x01FF, 0xAAAA);

extern pascal OSErr QTSetAtomID(QTAtomContainer container, QTAtom atom, QTAtomID newID)
 THREEWORDINLINE(0x303C, 0x0231, 0xAAAA);

extern pascal OSErr SetMediaPropertyAtom(Media theMedia, QTAtomContainer propertyAtom)
 THREEWORDINLINE(0x303C, 0x022E, 0xAAAA);

extern pascal OSErr GetMediaPropertyAtom(Media theMedia, QTAtomContainer *propertyAtom)
 THREEWORDINLINE(0x303C, 0x022F, 0xAAAA);

/*
****
	QT International Text Atom Support
****
*/

enum {
	kITextRemoveEverythingBut	= 0 << 1,
	kITextRemoveLeaveSuggestedAlternate = 1 << 1
};


enum {
	kITextAtomType				= 'itxt',
	kITextStringAtomType		= 'text'
};

extern pascal OSErr ITextAddString(QTAtomContainer container, QTAtom parentAtom, short theRegionCode, ConstStr255Param theString)
 THREEWORDINLINE(0x303C, 0x027A, 0xAAAA);

extern pascal OSErr ITextRemoveString(QTAtomContainer container, QTAtom parentAtom, short theRegionCode, long flags)
 THREEWORDINLINE(0x303C, 0x027B, 0xAAAA);

extern pascal OSErr ITextGetString(QTAtomContainer container, QTAtom parentAtom, short requestedRegion, short *foundRegion, StringPtr theString)
 THREEWORDINLINE(0x303C, 0x027C, 0xAAAA);

/*
************************
* modifier track types
*************************
*/

enum {
	kTrackModifierInput			= 0x696E,						/* is really 'in'*/
	kTrackModifierType			= 0x7479,						/* is really 'ty'*/
	kTrackModifierReference		= 'ssrc',
	kTrackModifierObjectID		= 'obid',
	kTrackModifierInputName		= 'name'
};


enum {
	kInputMapSubInputID			= 'subi'
};


enum {
	kTrackModifierTypeMatrix	= 1,
	kTrackModifierTypeClip		= 2,
	kTrackModifierTypeGraphicsMode = 5,
	kTrackModifierTypeVolume	= 3,
	kTrackModifierTypeBalance	= 4,
	kTrackModifierTypeSpriteImage = 'vide',
	kTrackModifierObjectMatrix	= 6,
	kTrackModifierObjectGraphicsMode = 7,
	kTrackModifierType3d4x4Matrix = 8,
	kTrackModifierCameraData	= 9,
	kTrackModifierSoundLocalizationData = 10
};

struct ModifierTrackGraphicsModeRecord {
	long 							graphicsMode;
	RGBColor 						opColor;
};
typedef struct ModifierTrackGraphicsModeRecord ModifierTrackGraphicsModeRecord;

/*
************************
* tween track types
*************************
*/

enum {
	kTweenTypeShort				= 1,
	kTweenTypeLong				= 2,
	kTweenTypeFixed				= 3,
	kTweenTypePoint				= 4,
	kTweenTypeQDRect			= 5,
	kTweenTypeQDRegion			= 6,
	kTweenTypeMatrix			= 7,
	kTweenTypeRGBColor			= 8,
	kTweenTypeGraphicsModeWithRGBColor = 9,
	kTweenType3dScale			= '3sca',
	kTweenType3dTranslate		= '3tra',
	kTweenType3dRotate			= '3rot',
	kTweenType3dRotateAboutPoint = '3rap',
	kTweenType3dRotateAboutAxis	= '3rax',
	kTweenType3dQuaternion		= '3qua',
	kTweenType3dMatrix			= '3mat',
	kTweenType3dCameraData		= '3cam',
	kTweenType3dSoundLocalizationData = '3slc'
};


enum {
	kTweenEntry					= 'twen',
	kTweenData					= 'data',
	kTweenType					= 'twnt',
	kTweenStartOffset			= 'twst',
	kTweenDuration				= 'twdu',
	kTween3dInitialCondition	= 'icnd',
	kTweenInterpolationStyle	= 'isty',
	kTweenRegionData			= 'qdrg',
	kTweenPictureData			= 'PICT'
};


#if OLDROUTINENAMES

/*************************
* Video Media routines
**************************/

#define GetVideoMediaGraphicsMode		MediaGetGraphicsMode
#define SetVideoMediaGraphicsMode		MediaSetGraphicsMode

// use these two routines at your own peril
#define ResetVideoMediaStatistics		VideoMediaResetStatistics
#define GetVideoMediaStatistics			VideoMediaGetStatistics(mh)

/*************************
* Sound Media routines
**************************/

#define GetSoundMediaBalance			MediaGetSoundBalance
#define SetSoundMediaBalance			MediaSetSoundBalance

/*************************
* Text Media routines
**************************/

#define SetTextProc			TextMediaSetTextProc
#define AddTextSample		TextMediaAddTextSample
#define AddTESample			TextMediaAddTESample
#define AddHiliteSample		TextMediaAddHiliteSample
#define FindNextText		TextMediaFindNextText
#define HiliteTextSample	TextMediaHiliteTextSample
#define SetTextSampleData	TextMediaSetTextSampleData

/*************************
* Sprite Media routines
**************************/

#define SetSpriteMediaSpriteProperty	SpriteMediaSetProperty
#define GetSpriteMediaSpriteProperty	SpriteMediaGetProperty
#define HitTestSpriteMedia				SpriteMediaHitTestSprites
#define CountSpriteMediaSprites			SpriteMediaCountSprites
#define CountSpriteMediaImages			SpriteMediaCountImages
#define GetSpriteMediaIndImageDescription	SpriteMediaGetIndImageDescription
#define GetDisplayedSampleNumber		SpriteMediaGetDisplayedSampleNumber
#endif /* OLDROUTINENAMES */


enum {
	internalComponentErr		= -2070,
	notImplementedMusicOSErr	= -2071,
	cantSendToSynthesizerOSErr	= -2072,
	cantReceiveFromSynthesizerOSErr = -2073,
	illegalVoiceAllocationOSErr	= -2074,
	illegalPartOSErr			= -2075,
	illegalChannelOSErr			= -2076,
	illegalKnobOSErr			= -2077,
	illegalKnobValueOSErr		= -2078,
	illegalInstrumentOSErr		= -2079,
	illegalControllerOSErr		= -2080,
	midiManagerAbsentOSErr		= -2081,
	synthesizerNotRespondingOSErr = -2082,
	synthesizerOSErr			= -2083,
	illegalNoteChannelOSErr		= -2084,
	noteChannelNotAllocatedOSErr = -2085,
	tunePlayerFullOSErr			= -2086,
	tuneParseOSErr				= -2087
};

/*
************************
* Video Media routines
*************************
*/

enum {
	videoFlagDontLeanAhead		= 1L << 0
};

/* use these two routines at your own peril*/
extern pascal ComponentResult VideoMediaResetStatistics(MediaHandler mh)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0105, 0x7000, 0xA82A);

extern pascal ComponentResult VideoMediaGetStatistics(MediaHandler mh)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0106, 0x7000, 0xA82A);

/*
************************
* Text Media routines
*************************
*/
/* Return displayFlags for TextProc */

enum {
	txtProcDefaultDisplay		= 0,							/*	Use the media's default*/
	txtProcDontDisplay			= 1,							/*	Don't display the text*/
	txtProcDoDisplay			= 2								/*	Do display the text*/
};

extern pascal ComponentResult TextMediaSetTextProc(MediaHandler mh, TextMediaUPP TextProc, long refcon)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0101, 0x7000, 0xA82A);

extern pascal ComponentResult TextMediaAddTextSample(MediaHandler mh, Ptr text, unsigned long size, short fontNumber, short fontSize, Style textFace, RGBColor *textColor, RGBColor *backColor, short textJustification, Rect *textBox, long displayFlags, TimeValue scrollDelay, short hiliteStart, short hiliteEnd, RGBColor *rgbHiliteColor, TimeValue duration, TimeValue *sampleTime)
 FIVEWORDINLINE(0x2F3C, 0x0034, 0x0102, 0x7000, 0xA82A);

extern pascal ComponentResult TextMediaAddTESample(MediaHandler mh, TEHandle hTE, RGBColor *backColor, short textJustification, Rect *textBox, long displayFlags, TimeValue scrollDelay, short hiliteStart, short hiliteEnd, RGBColor *rgbHiliteColor, TimeValue duration, TimeValue *sampleTime)
 FIVEWORDINLINE(0x2F3C, 0x0026, 0x0103, 0x7000, 0xA82A);

extern pascal ComponentResult TextMediaAddHiliteSample(MediaHandler mh, short hiliteStart, short hiliteEnd, RGBColor *rgbHiliteColor, TimeValue duration, TimeValue *sampleTime)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0104, 0x7000, 0xA82A);


enum {
	findTextEdgeOK				= 1 << 0,						/* Okay to find text at specified sample time*/
	findTextCaseSensitive		= 1 << 1,						/* Case sensitive search*/
	findTextReverseSearch		= 1 << 2,						/* Search from sampleTime backwards*/
	findTextWrapAround			= 1 << 3,						/* Wrap search when beginning or end of movie is hit*/
	findTextUseOffset			= 1 << 4						/* Begin search at the given character offset into sample rather than edge*/
};

extern pascal ComponentResult TextMediaFindNextText(MediaHandler mh, Ptr text, long size, short findFlags, TimeValue startTime, TimeValue *foundTime, TimeValue *foundDuration, long *offset)
 FIVEWORDINLINE(0x2F3C, 0x001A, 0x0105, 0x7000, 0xA82A);

extern pascal ComponentResult TextMediaHiliteTextSample(MediaHandler mh, TimeValue sampleTime, short hiliteStart, short hiliteEnd, RGBColor *rgbHiliteColor)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0106, 0x7000, 0xA82A);


enum {
	dropShadowOffsetType		= 'drpo',
	dropShadowTranslucencyType	= 'drpt'
};

extern pascal ComponentResult TextMediaSetTextSampleData(MediaHandler mh, void *data, OSType dataType)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0107, 0x7000, 0xA82A);

/*
************************
* Sprite Media routines
*************************
*/
/* flags for HitTestSpriteMedia */

enum {
	spriteHitTestBounds			= 1L << 0,						/*	point must only be within sprite's bounding box*/
	spriteHitTestImage			= 1L << 1						/*  point must be within the shape of the sprite's image*/
};

/* atom types for sprite media */

enum {
	kSpriteAtomType				= 'sprt',
	kSpriteImagesContainerAtomType = 'imct',
	kSpriteImageAtomType		= 'imag',
	kSpriteImageDataAtomType	= 'imda',
	kSpriteSharedDataAtomType	= 'dflt',
	kSpriteNameAtomType			= 'name'
};

extern pascal ComponentResult SpriteMediaSetProperty(MediaHandler mh, short spriteIndex, long propertyType, void *propertyValue)
 FIVEWORDINLINE(0x2F3C, 0x000A, 0x0101, 0x7000, 0xA82A);

extern pascal ComponentResult SpriteMediaGetProperty(MediaHandler mh, short spriteIndex, long propertyType, void *propertyValue)
 FIVEWORDINLINE(0x2F3C, 0x000A, 0x0102, 0x7000, 0xA82A);

extern pascal ComponentResult SpriteMediaHitTestSprites(MediaHandler mh, long flags, Point loc, short *spriteHitIndex)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0103, 0x7000, 0xA82A);

extern pascal ComponentResult SpriteMediaCountSprites(MediaHandler mh, short *numSprites)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0104, 0x7000, 0xA82A);

extern pascal ComponentResult SpriteMediaCountImages(MediaHandler mh, short *numImages)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0105, 0x7000, 0xA82A);

extern pascal ComponentResult SpriteMediaGetIndImageDescription(MediaHandler mh, short imageIndex, ImageDescriptionHandle imageDescription)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x0106, 0x7000, 0xA82A);

extern pascal ComponentResult SpriteMediaGetDisplayedSampleNumber(MediaHandler mh, long *sampleNum)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0107, 0x7000, 0xA82A);

/*
************************
* 3D Media routines
*************************
*/
extern pascal ComponentResult Media3DGetNamedObjectList(MediaHandler mh, QTAtomContainer *objectList)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0101, 0x7000, 0xA82A);

extern pascal ComponentResult Media3DGetRendererList(MediaHandler mh, QTAtomContainer *rendererList)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0102, 0x7000, 0xA82A);

/*
***************************************
*										*
*  	M O V I E   C O N T R O L L E R		*
*										*
***************************************
*/

enum {
	MovieControllerComponentType = 'play'
};

typedef ComponentInstance MovieController;

enum {
	mcActionIdle				= 1,							/* no param*/
	mcActionDraw				= 2,							/* param is WindowPtr*/
	mcActionActivate			= 3,							/* no param*/
	mcActionDeactivate			= 4,							/* no param*/
	mcActionMouseDown			= 5,							/* param is pointer to EventRecord*/
	mcActionKey					= 6,							/* param is pointer to EventRecord*/
	mcActionPlay				= 8,							/* param is Fixed, play rate*/
	mcActionGoToTime			= 12,							/* param is TimeRecord*/
	mcActionSetVolume			= 14,							/* param is a short*/
	mcActionGetVolume			= 15,							/* param is pointer to a short*/
	mcActionStep				= 18,							/* param is number of steps (short)*/
	mcActionSetLooping			= 21,							/* param is Boolean*/
	mcActionGetLooping			= 22,							/* param is pointer to a Boolean*/
	mcActionSetLoopIsPalindrome	= 23,							/* param is Boolean*/
	mcActionGetLoopIsPalindrome	= 24,							/* param is pointer to a Boolean*/
	mcActionSetGrowBoxBounds	= 25,							/* param is a Rect*/
	mcActionControllerSizeChanged = 26,							/* no param*/
	mcActionSetSelectionBegin	= 29,							/* param is TimeRecord*/
	mcActionSetSelectionDuration = 30,							/* param is TimeRecord, action only taken on set-duration*/
	mcActionSetKeysEnabled		= 32,							/* param is Boolean*/
	mcActionGetKeysEnabled		= 33,							/* param is pointer to Boolean*/
	mcActionSetPlaySelection	= 34,							/* param is Boolean*/
	mcActionGetPlaySelection	= 35,							/* param is pointer to Boolean*/
	mcActionSetUseBadge			= 36,							/* param is Boolean*/
	mcActionGetUseBadge			= 37,							/* param is pointer to Boolean*/
	mcActionSetFlags			= 38,							/* param is long of flags*/
	mcActionGetFlags			= 39,							/* param is pointer to a long of flags*/
	mcActionSetPlayEveryFrame	= 40,							/* param is Boolean*/
	mcActionGetPlayEveryFrame	= 41,							/* param is pointer to Boolean*/
	mcActionGetPlayRate			= 42,							/* param is pointer to Fixed*/
	mcActionShowBalloon			= 43,							/* param is a pointer to a boolean. set to false to stop balloon*/
	mcActionBadgeClick			= 44,							/* param is pointer to Boolean. set to false to ignore click*/
	mcActionMovieClick			= 45,							/* param is pointer to event record. change “what” to nullEvt to kill click*/
	mcActionSuspend				= 46,							/* no param*/
	mcActionResume				= 47,							/* no param*/
	mcActionSetControllerKeysEnabled = 48,						/* param is Boolean*/
	mcActionGetTimeSliderRect	= 49,							/* param is pointer to rect*/
	mcActionMovieEdited			= 50,							/* no param*/
	mcActionGetDragEnabled		= 51,							/* param is pointer to Boolean*/
	mcActionSetDragEnabled		= 52,							/* param is Boolean*/
	mcActionGetSelectionBegin	= 53,							/* param is TimeRecord*/
	mcActionGetSelectionDuration = 54,							/* param is TimeRecord*/
	mcActionPrerollAndPlay		= 55,							/* param is Fixed, play rate*/
	mcActionGetCursorSettingEnabled = 56,						/* param is pointer to Boolean*/
	mcActionSetCursorSettingEnabled = 57,						/* param is Boolean*/
	mcActionSetColorTable		= 58							/* param is CTabHandle*/
};

typedef short mcAction;

enum {
	mcFlagSuppressMovieFrame	= 1 << 0,
	mcFlagSuppressStepButtons	= 1 << 1,
	mcFlagSuppressSpeakerButton	= 1 << 2,
	mcFlagsUseWindowPalette		= 1 << 3,
	mcFlagsDontInvalidate		= 1 << 4
};


enum {
	mcPositionDontInvalidate	= 1 << 5
};

typedef unsigned long mcFlags;
typedef pascal Boolean (*MCActionFilterProcPtr)(MovieController mc, short *action, void *params);
typedef pascal Boolean (*MCActionFilterWithRefConProcPtr)(MovieController mc, short action, void *params, long refCon);

#if GENERATINGCFM
typedef UniversalProcPtr MCActionFilterUPP;
typedef UniversalProcPtr MCActionFilterWithRefConUPP;
#else
typedef MCActionFilterProcPtr MCActionFilterUPP;
typedef MCActionFilterWithRefConProcPtr MCActionFilterWithRefConUPP;
#endif
/*
	menu related stuff
*/

enum {
	mcInfoUndoAvailable			= 1 << 0,
	mcInfoCutAvailable			= 1 << 1,
	mcInfoCopyAvailable			= 1 << 2,
	mcInfoPasteAvailable		= 1 << 3,
	mcInfoClearAvailable		= 1 << 4,
	mcInfoHasSound				= 1 << 5,
	mcInfoIsPlaying				= 1 << 6,
	mcInfoIsLooping				= 1 << 7,
	mcInfoIsInPalindrome		= 1 << 8,
	mcInfoEditingEnabled		= 1 << 9,
	mcInfoMovieIsInteractive	= 1 << 10
};

/* menu item codes*/

enum {
	mcMenuUndo					= 1,
	mcMenuCut					= 3,
	mcMenuCopy					= 4,
	mcMenuPaste					= 5,
	mcMenuClear					= 6
};

/* target management */
extern pascal ComponentResult MCSetMovie(MovieController mc, Movie theMovie, WindowPtr movieWindow, Point where)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0002, 0x7000, 0xA82A);

extern pascal Movie MCGetIndMovie(MovieController mc, short index)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0005, 0x7000, 0xA82A);

#define MCGetMovie(mc) MCGetIndMovie(mc, 0)
extern pascal ComponentResult MCRemoveAllMovies(MovieController mc)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0006, 0x7000, 0xA82A);

extern pascal ComponentResult MCRemoveAMovie(MovieController mc, Movie m)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0003, 0x7000, 0xA82A);

extern pascal ComponentResult MCRemoveMovie(MovieController mc)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0006, 0x7000, 0xA82A);

/* event handling etc. */
extern pascal ComponentResult MCIsPlayerEvent(MovieController mc, const EventRecord *e)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0007, 0x7000, 0xA82A);

/* obsolete. use MCSetActionFilterWithRefCon instead. */
extern pascal ComponentResult MCSetActionFilter(MovieController mc, MCActionFilterUPP blob)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0008, 0x7000, 0xA82A);

/*
	proc is of the form:
		Boolean userPlayerFilter(MovieController mc, short *action, void *params) =
	proc returns TRUE if it handles the action, FALSE if not
	action is passed as a VAR so that it could be changed by filter
	this is consistent with the current dialog manager stuff
	params is any potential parameters that go with the action
		such as set playback rate to xxx.
*/
extern pascal ComponentResult MCDoAction(MovieController mc, short action, void *params)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x0009, 0x7000, 0xA82A);

/* state type things */
extern pascal ComponentResult MCSetControllerAttached(MovieController mc, Boolean attach)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x000A, 0x7000, 0xA82A);

extern pascal ComponentResult MCIsControllerAttached(MovieController mc)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x000B, 0x7000, 0xA82A);

extern pascal ComponentResult MCSetControllerPort(MovieController mc, CGrafPtr gp)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000C, 0x7000, 0xA82A);

extern pascal CGrafPtr MCGetControllerPort(MovieController mc)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x000D, 0x7000, 0xA82A);

extern pascal ComponentResult MCSetVisible(MovieController mc, Boolean visible)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x000E, 0x7000, 0xA82A);

extern pascal ComponentResult MCGetVisible(MovieController mc)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x000F, 0x7000, 0xA82A);

extern pascal ComponentResult MCGetControllerBoundsRect(MovieController mc, Rect *bounds)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0010, 0x7000, 0xA82A);

extern pascal ComponentResult MCSetControllerBoundsRect(MovieController mc, const Rect *bounds)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0011, 0x7000, 0xA82A);

extern pascal RgnHandle MCGetControllerBoundsRgn(MovieController mc)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0012, 0x7000, 0xA82A);

extern pascal RgnHandle MCGetWindowRgn(MovieController mc, WindowPtr w)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0013, 0x7000, 0xA82A);

/* other stuff */
extern pascal ComponentResult MCMovieChanged(MovieController mc, Movie m)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0014, 0x7000, 0xA82A);

/*
	called when the app has changed thing about the movie (like bounding rect) or rate. So that we
		can update our graphical (and internal) state accordingly.
*/
extern pascal ComponentResult MCSetDuration(MovieController mc, TimeValue duration)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0015, 0x7000, 0xA82A);

/*
	duration to use for time slider -- will be reset next time MCMovieChanged is called
		or MCSetMovie is called
*/
extern pascal TimeValue MCGetCurrentTime(MovieController mc, TimeScale *scale)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0016, 0x7000, 0xA82A);

/*
	returns the time value and the time scale it is on. if there are no movies, the
		time scale is passed back as 0. scale is an optional parameter

*/
extern pascal ComponentResult MCNewAttachedController(MovieController mc, Movie theMovie, WindowPtr w, Point where)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0017, 0x7000, 0xA82A);

/*
	makes theMovie the only movie attached to the controller. makes the controller visible.
	the window and where parameters are passed a long to MCSetMovie and behave as
	described there
*/
extern pascal ComponentResult MCDraw(MovieController mc, WindowPtr w)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0018, 0x7000, 0xA82A);

extern pascal ComponentResult MCActivate(MovieController mc, WindowPtr w, Boolean activate)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x0019, 0x7000, 0xA82A);

extern pascal ComponentResult MCIdle(MovieController mc)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x001A, 0x7000, 0xA82A);

extern pascal ComponentResult MCKey(MovieController mc, SInt8 key, long modifiers)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x001B, 0x7000, 0xA82A);

extern pascal ComponentResult MCClick(MovieController mc, WindowPtr w, Point where, long when, long modifiers)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x001C, 0x7000, 0xA82A);

/*
	calls for editing
*/
extern pascal ComponentResult MCEnableEditing(MovieController mc, Boolean enabled)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x001D, 0x7000, 0xA82A);

extern pascal long MCIsEditingEnabled(MovieController mc)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x001E, 0x7000, 0xA82A);

extern pascal Movie MCCopy(MovieController mc)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x001F, 0x7000, 0xA82A);

extern pascal Movie MCCut(MovieController mc)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0020, 0x7000, 0xA82A);

extern pascal ComponentResult MCPaste(MovieController mc, Movie srcMovie)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0021, 0x7000, 0xA82A);

extern pascal ComponentResult MCClear(MovieController mc)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0022, 0x7000, 0xA82A);

extern pascal ComponentResult MCUndo(MovieController mc)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0023, 0x7000, 0xA82A);

/*
 *	somewhat special stuff
*/
extern pascal ComponentResult MCPositionController(MovieController mc, const Rect *movieRect, const Rect *controllerRect, long someFlags)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0024, 0x7000, 0xA82A);

extern pascal ComponentResult MCGetControllerInfo(MovieController mc, long *someFlags)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0025, 0x7000, 0xA82A);

extern pascal ComponentResult MCSetClip(MovieController mc, RgnHandle theClip, RgnHandle movieClip)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0028, 0x7000, 0xA82A);

extern pascal ComponentResult MCGetClip(MovieController mc, RgnHandle *theClip, RgnHandle *movieClip)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0029, 0x7000, 0xA82A);

extern pascal ComponentResult MCDrawBadge(MovieController mc, RgnHandle movieRgn, RgnHandle *badgeRgn)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x002A, 0x7000, 0xA82A);

extern pascal ComponentResult MCSetUpEditMenu(MovieController mc, long modifiers, MenuHandle mh)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x002B, 0x7000, 0xA82A);

extern pascal ComponentResult MCGetMenuString(MovieController mc, long modifiers, short item, Str255 aString)
 FIVEWORDINLINE(0x2F3C, 0x000A, 0x002C, 0x7000, 0xA82A);

extern pascal ComponentResult MCSetActionFilterWithRefCon(MovieController mc, MCActionFilterWithRefConUPP blob, long refCon)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x002D, 0x7000, 0xA82A);

extern pascal ComponentResult MCPtInController(MovieController mc, Point thePt, Boolean *inController)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x002E, 0x7000, 0xA82A);

extern pascal ComponentResult MCInvalidate(MovieController mc, WindowPtr w, RgnHandle invalidRgn)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x002F, 0x7000, 0xA82A);

/*
***************************************
*										*
*  		T  I  M  E  B  A  S  E			*
*										*
***************************************
*/
extern pascal TimeBase NewTimeBase(void )
 THREEWORDINLINE(0x303C, 0x00A5, 0xAAAA);

extern pascal void DisposeTimeBase(TimeBase tb)
 THREEWORDINLINE(0x303C, 0x00B6, 0xAAAA);

extern pascal TimeValue GetTimeBaseTime(TimeBase tb, TimeScale s, TimeRecord *tr)
 THREEWORDINLINE(0x303C, 0x00A6, 0xAAAA);

extern pascal void SetTimeBaseTime(TimeBase tb, const TimeRecord *tr)
 THREEWORDINLINE(0x303C, 0x00A7, 0xAAAA);

extern pascal void SetTimeBaseValue(TimeBase tb, TimeValue t, TimeScale s)
 THREEWORDINLINE(0x303C, 0x00A8, 0xAAAA);

extern pascal Fixed GetTimeBaseRate(TimeBase tb)
 THREEWORDINLINE(0x303C, 0x00A9, 0xAAAA);

extern pascal void SetTimeBaseRate(TimeBase tb, Fixed r)
 THREEWORDINLINE(0x303C, 0x00AA, 0xAAAA);

extern pascal TimeValue GetTimeBaseStartTime(TimeBase tb, TimeScale s, TimeRecord *tr)
 THREEWORDINLINE(0x303C, 0x00AB, 0xAAAA);

extern pascal void SetTimeBaseStartTime(TimeBase tb, const TimeRecord *tr)
 THREEWORDINLINE(0x303C, 0x00AC, 0xAAAA);

extern pascal TimeValue GetTimeBaseStopTime(TimeBase tb, TimeScale s, TimeRecord *tr)
 THREEWORDINLINE(0x303C, 0x00AD, 0xAAAA);

extern pascal void SetTimeBaseStopTime(TimeBase tb, const TimeRecord *tr)
 THREEWORDINLINE(0x303C, 0x00AE, 0xAAAA);

extern pascal long GetTimeBaseFlags(TimeBase tb)
 THREEWORDINLINE(0x303C, 0x00B1, 0xAAAA);

extern pascal void SetTimeBaseFlags(TimeBase tb, long timeBaseFlags)
 THREEWORDINLINE(0x303C, 0x00B2, 0xAAAA);

extern pascal void SetTimeBaseMasterTimeBase(TimeBase slave, TimeBase master, const TimeRecord *slaveZero)
 THREEWORDINLINE(0x303C, 0x00B4, 0xAAAA);

extern pascal TimeBase GetTimeBaseMasterTimeBase(TimeBase tb)
 THREEWORDINLINE(0x303C, 0x00AF, 0xAAAA);

extern pascal void SetTimeBaseMasterClock(TimeBase slave, Component clockMeister, const TimeRecord *slaveZero)
 THREEWORDINLINE(0x303C, 0x00B3, 0xAAAA);

extern pascal ComponentInstance GetTimeBaseMasterClock(TimeBase tb)
 THREEWORDINLINE(0x303C, 0x00B0, 0xAAAA);

extern pascal void ConvertTime(TimeRecord *inout, TimeBase newBase)
 THREEWORDINLINE(0x303C, 0x00B5, 0xAAAA);

extern pascal void ConvertTimeScale(TimeRecord *inout, TimeScale newScale)
 THREEWORDINLINE(0x303C, 0x00B7, 0xAAAA);

extern pascal void AddTime(TimeRecord *dst, const TimeRecord *src)
 THREEWORDINLINE(0x303C, 0x010C, 0xAAAA);

extern pascal void SubtractTime(TimeRecord *dst, const TimeRecord *src)
 THREEWORDINLINE(0x303C, 0x010D, 0xAAAA);

extern pascal long GetTimeBaseStatus(TimeBase tb, TimeRecord *unpinnedTime)
 THREEWORDINLINE(0x303C, 0x010B, 0xAAAA);

extern pascal void SetTimeBaseZero(TimeBase tb, TimeRecord *zero)
 THREEWORDINLINE(0x303C, 0x0128, 0xAAAA);

extern pascal Fixed GetTimeBaseEffectiveRate(TimeBase tb)
 THREEWORDINLINE(0x303C, 0x0124, 0xAAAA);

/*
***************************************
*										*
*  		C  A  L  L  B  A  C  K 			*
*										*
***************************************
*/
extern pascal QTCallBack NewCallBack(TimeBase tb, short cbType)
 THREEWORDINLINE(0x303C, 0x00EB, 0xAAAA);

extern pascal void DisposeCallBack(QTCallBack cb)
 THREEWORDINLINE(0x303C, 0x00EC, 0xAAAA);

extern pascal short GetCallBackType(QTCallBack cb)
 THREEWORDINLINE(0x303C, 0x00ED, 0xAAAA);

extern pascal TimeBase GetCallBackTimeBase(QTCallBack cb)
 THREEWORDINLINE(0x303C, 0x00EE, 0xAAAA);

extern pascal OSErr CallMeWhen(QTCallBack cb, QTCallBackUPP callBackProc, long refCon, long param1, long param2, long param3)
 THREEWORDINLINE(0x303C, 0x00B8, 0xAAAA);

extern pascal void CancelCallBack(QTCallBack cb)
 THREEWORDINLINE(0x303C, 0x00B9, 0xAAAA);

/*
***************************************
*										*
*  		C L O C K   C A L L B A C K  	*
*  		      S U P P O R T  			*
*										*
***************************************
*/
extern pascal OSErr AddCallBackToTimeBase(QTCallBack cb)
 THREEWORDINLINE(0x303C, 0x0129, 0xAAAA);

extern pascal OSErr RemoveCallBackFromTimeBase(QTCallBack cb)
 THREEWORDINLINE(0x303C, 0x012A, 0xAAAA);

extern pascal QTCallBack GetFirstCallBack(TimeBase tb)
 THREEWORDINLINE(0x303C, 0x012B, 0xAAAA);

extern pascal QTCallBack GetNextCallBack(QTCallBack cb)
 THREEWORDINLINE(0x303C, 0x012C, 0xAAAA);

extern pascal void ExecuteCallBack(QTCallBack cb)
 THREEWORDINLINE(0x303C, 0x012D, 0xAAAA);

/*
***************************************
*										*
*  		S Y N C    T A S K S		  	*
*  		      S U P P O R T  			*
*										*
***************************************
*/
extern pascal OSErr QueueSyncTask(QTSyncTaskPtr task)
 THREEWORDINLINE(0x303C, 0x0203, 0xAAAA);

extern pascal OSErr DequeueSyncTask(QTSyncTaskPtr qElem)
 THREEWORDINLINE(0x303C, 0x0204, 0xAAAA);

/* UPP call backs */

#if GENERATINGCFM
#else
#endif

enum {
	uppMovieRgnCoverProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Movie)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(RgnHandle)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long))),
	uppMovieProgressProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Movie)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(Fixed)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(long))),
	uppMovieDrawingCompleteProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Movie)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long))),
	uppTrackTransferProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Track)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long))),
	uppGetMovieProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void *)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(void *))),
	uppMoviePreviewCallOutProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long))),
	uppTextMediaProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Handle)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Movie)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short *)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long))),
	uppQTCallBackProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(QTCallBack)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long))),
	uppQTSyncTaskProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(void *))),
	uppMCActionFilterProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(MovieController)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short *)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void *))),
	uppMCActionFilterWithRefConProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(MovieController)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void *)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewMovieRgnCoverProc(userRoutine)		\
		(MovieRgnCoverUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMovieRgnCoverProcInfo, GetCurrentArchitecture())
#define NewMovieProgressProc(userRoutine)		\
		(MovieProgressUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMovieProgressProcInfo, GetCurrentArchitecture())
#define NewMovieDrawingCompleteProc(userRoutine)		\
		(MovieDrawingCompleteUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMovieDrawingCompleteProcInfo, GetCurrentArchitecture())
#define NewTrackTransferProc(userRoutine)		\
		(TrackTransferUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTrackTransferProcInfo, GetCurrentArchitecture())
#define NewGetMovieProc(userRoutine)		\
		(GetMovieUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGetMovieProcInfo, GetCurrentArchitecture())
#define NewMoviePreviewCallOutProc(userRoutine)		\
		(MoviePreviewCallOutUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMoviePreviewCallOutProcInfo, GetCurrentArchitecture())
#define NewTextMediaProc(userRoutine)		\
		(TextMediaUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTextMediaProcInfo, GetCurrentArchitecture())
#define NewQTCallBackProc(userRoutine)		\
		(QTCallBackUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppQTCallBackProcInfo, GetCurrentArchitecture())
#define NewQTSyncTaskProc(userRoutine)		\
		(QTSyncTaskUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppQTSyncTaskProcInfo, GetCurrentArchitecture())
#define NewMCActionFilterProc(userRoutine)		\
		(MCActionFilterUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMCActionFilterProcInfo, GetCurrentArchitecture())
#define NewMCActionFilterWithRefConProc(userRoutine)		\
		(MCActionFilterWithRefConUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppMCActionFilterWithRefConProcInfo, GetCurrentArchitecture())
#else
#define NewMovieRgnCoverProc(userRoutine)		\
		((MovieRgnCoverUPP) (userRoutine))
#define NewMovieProgressProc(userRoutine)		\
		((MovieProgressUPP) (userRoutine))
#define NewMovieDrawingCompleteProc(userRoutine)		\
		((MovieDrawingCompleteUPP) (userRoutine))
#define NewTrackTransferProc(userRoutine)		\
		((TrackTransferUPP) (userRoutine))
#define NewGetMovieProc(userRoutine)		\
		((GetMovieUPP) (userRoutine))
#define NewMoviePreviewCallOutProc(userRoutine)		\
		((MoviePreviewCallOutUPP) (userRoutine))
#define NewTextMediaProc(userRoutine)		\
		((TextMediaUPP) (userRoutine))
#define NewQTCallBackProc(userRoutine)		\
		((QTCallBackUPP) (userRoutine))
#define NewQTSyncTaskProc(userRoutine)		\
		((QTSyncTaskUPP) (userRoutine))
#define NewMCActionFilterProc(userRoutine)		\
		((MCActionFilterUPP) (userRoutine))
#define NewMCActionFilterWithRefConProc(userRoutine)		\
		((MCActionFilterWithRefConUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallMovieRgnCoverProc(userRoutine, theMovie, changedRgn, refcon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMovieRgnCoverProcInfo, (theMovie), (changedRgn), (refcon))
#define CallMovieProgressProc(userRoutine, theMovie, message, whatOperation, percentDone, refcon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMovieProgressProcInfo, (theMovie), (message), (whatOperation), (percentDone), (refcon))
#define CallMovieDrawingCompleteProc(userRoutine, theMovie, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMovieDrawingCompleteProcInfo, (theMovie), (refCon))
#define CallTrackTransferProc(userRoutine, t, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTrackTransferProcInfo, (t), (refCon))
#define CallGetMovieProc(userRoutine, offset, size, dataPtr, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGetMovieProcInfo, (offset), (size), (dataPtr), (refCon))
#define CallMoviePreviewCallOutProc(userRoutine, refcon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMoviePreviewCallOutProcInfo, (refcon))
#define CallTextMediaProc(userRoutine, theText, theMovie, displayFlag, refcon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTextMediaProcInfo, (theText), (theMovie), (displayFlag), (refcon))
#define CallQTCallBackProc(userRoutine, cb, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppQTCallBackProcInfo, (cb), (refCon))
#define CallQTSyncTaskProc(userRoutine, task)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppQTSyncTaskProcInfo, (task))
#define CallMCActionFilterProc(userRoutine, mc, action, params)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMCActionFilterProcInfo, (mc), (action), (params))
#define CallMCActionFilterWithRefConProc(userRoutine, mc, action, params, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppMCActionFilterWithRefConProcInfo, (mc), (action), (params), (refCon))
#else
#define CallMovieRgnCoverProc(userRoutine, theMovie, changedRgn, refcon)		\
		(*(userRoutine))((theMovie), (changedRgn), (refcon))
#define CallMovieProgressProc(userRoutine, theMovie, message, whatOperation, percentDone, refcon)		\
		(*(userRoutine))((theMovie), (message), (whatOperation), (percentDone), (refcon))
#define CallMovieDrawingCompleteProc(userRoutine, theMovie, refCon)		\
		(*(userRoutine))((theMovie), (refCon))
#define CallTrackTransferProc(userRoutine, t, refCon)		\
		(*(userRoutine))((t), (refCon))
#define CallGetMovieProc(userRoutine, offset, size, dataPtr, refCon)		\
		(*(userRoutine))((offset), (size), (dataPtr), (refCon))
#define CallMoviePreviewCallOutProc(userRoutine, refcon)		\
		(*(userRoutine))((refcon))
#define CallTextMediaProc(userRoutine, theText, theMovie, displayFlag, refcon)		\
		(*(userRoutine))((theText), (theMovie), (displayFlag), (refcon))
#define CallQTCallBackProc(userRoutine, cb, refCon)		\
		(*(userRoutine))((cb), (refCon))
#define CallQTSyncTaskProc(userRoutine, task)		\
		(*(userRoutine))((task))
#define CallMCActionFilterProc(userRoutine, mc, action, params)		\
		(*(userRoutine))((mc), (action), (params))
#define CallMCActionFilterWithRefConProc(userRoutine, mc, action, params, refCon)		\
		(*(userRoutine))((mc), (action), (params), (refCon))
#endif

/* selectors for component calls */
enum {
	kVideoMediaResetStatisticsSelect				= 0x0105,
	kVideoMediaGetStatisticsSelect					= 0x0106,
	kTextMediaSetTextProcSelect						= 0x0101,
	kTextMediaAddTextSampleSelect					= 0x0102,
	kTextMediaAddTESampleSelect						= 0x0103,
	kTextMediaAddHiliteSampleSelect					= 0x0104,
	kTextMediaFindNextTextSelect					= 0x0105,
	kTextMediaHiliteTextSampleSelect				= 0x0106,
	kTextMediaSetTextSampleDataSelect				= 0x0107,
	kSpriteMediaSetPropertySelect					= 0x0101,
	kSpriteMediaGetPropertySelect					= 0x0102,
	kSpriteMediaHitTestSpritesSelect				= 0x0103,
	kSpriteMediaCountSpritesSelect					= 0x0104,
	kSpriteMediaCountImagesSelect					= 0x0105,
	kSpriteMediaGetIndImageDescriptionSelect		= 0x0106,
	kSpriteMediaGetDisplayedSampleNumberSelect		= 0x0107,
	kMedia3DGetNamedObjectListSelect				= 0x0101,
	kMedia3DGetRendererListSelect					= 0x0102,
	kMCSetMovieSelect								= 0x0002,
	kMCGetIndMovieSelect							= 0x0005,
	kMCRemoveAllMoviesSelect						= 0x0006,
	kMCRemoveAMovieSelect							= 0x0003,
	kMCRemoveMovieSelect							= 0x0006,
	kMCIsPlayerEventSelect							= 0x0007,
	kMCSetActionFilterSelect						= 0x0008,
	kMCDoActionSelect								= 0x0009,
	kMCSetControllerAttachedSelect					= 0x000A,
	kMCIsControllerAttachedSelect					= 0x000B,
	kMCSetControllerPortSelect						= 0x000C,
	kMCGetControllerPortSelect						= 0x000D,
	kMCSetVisibleSelect								= 0x000E,
	kMCGetVisibleSelect								= 0x000F,
	kMCGetControllerBoundsRectSelect				= 0x0010,
	kMCSetControllerBoundsRectSelect				= 0x0011,
	kMCGetControllerBoundsRgnSelect					= 0x0012,
	kMCGetWindowRgnSelect							= 0x0013,
	kMCMovieChangedSelect							= 0x0014,
	kMCSetDurationSelect							= 0x0015,
	kMCGetCurrentTimeSelect							= 0x0016,
	kMCNewAttachedControllerSelect					= 0x0017,
	kMCDrawSelect									= 0x0018,
	kMCActivateSelect								= 0x0019,
	kMCIdleSelect									= 0x001A,
	kMCKeySelect									= 0x001B,
	kMCClickSelect									= 0x001C,
	kMCEnableEditingSelect							= 0x001D,
	kMCIsEditingEnabledSelect						= 0x001E,
	kMCCopySelect									= 0x001F,
	kMCCutSelect									= 0x0020,
	kMCPasteSelect									= 0x0021,
	kMCClearSelect									= 0x0022,
	kMCUndoSelect									= 0x0023,
	kMCPositionControllerSelect						= 0x0024,
	kMCGetControllerInfoSelect						= 0x0025,
	kMCSetClipSelect								= 0x0028,
	kMCGetClipSelect								= 0x0029,
	kMCDrawBadgeSelect								= 0x002A,
	kMCSetUpEditMenuSelect							= 0x002B,
	kMCGetMenuStringSelect							= 0x002C,
	kMCSetActionFilterWithRefConSelect				= 0x002D,
	kMCPtInControllerSelect							= 0x002E,
	kMCInvalidateSelect								= 0x002F
};

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#ifdef __cplusplus
}
#endif

#endif /* __MOVIES__ */


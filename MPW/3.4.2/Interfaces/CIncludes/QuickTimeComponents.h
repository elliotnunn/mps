/*
 	File:		QuickTimeComponents.h
 
 	Contains:	QuickTime interfaces
 
 	Version:	Technology:	Technology:	QuickTime 2.5
 				Package:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/
#ifndef __QUICKTIMECOMPONENTS__
#define __QUICKTIMECOMPONENTS__

#ifndef __COMPONENTS__
#include <Components.h>
#endif
#ifndef __IMAGECOMPRESSION__
#include <ImageCompression.h>
#endif
#ifndef __MOVIES__
#include <Movies.h>
#endif
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
#ifndef __VIDEO__
#include <Video.h>
#endif
#ifndef __MEMORY__
#include <Memory.h>
#endif
#ifndef __SOUND__
#include <Sound.h>
#endif
#ifndef __QUICKTIMEMUSIC__
#include <QuickTimeMusic.h>
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
	clockComponentType			= 'clok',
	systemTickClock				= 'tick',						/* subtype: 60ths since boot		*/
	systemSecondClock			= 'seco',						/* subtype: seconds since 1904		*/
	systemMillisecondClock		= 'mill',						/* subtype: 1000ths since boot		*/
	systemMicrosecondClock		= 'micr'						/* subtype: 1000000ths since boot	*/
};


enum {
	kClockRateIsLinear			= 1,
	kClockImplementsCallBacks	= 2
};

#if OLDROUTINENAMES
#define GetClockTime(aClock, out) ClockGetTime(aClock, out)
#endif
/** These are Clock procedures **/
extern pascal ComponentResult ClockGetTime(ComponentInstance aClock, TimeRecord *out)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0001, 0x7000, 0xA82A);

extern pascal QTCallBack ClockNewCallBack(ComponentInstance aClock, TimeBase tb, short callBackType)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x0002, 0x7000, 0xA82A);

extern pascal ComponentResult ClockDisposeCallBack(ComponentInstance aClock, QTCallBack cb)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0003, 0x7000, 0xA82A);

extern pascal ComponentResult ClockCallMeWhen(ComponentInstance aClock, QTCallBack cb, long param1, long param2, long param3)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0004, 0x7000, 0xA82A);

extern pascal ComponentResult ClockCancelCallBack(ComponentInstance aClock, QTCallBack cb)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0005, 0x7000, 0xA82A);

extern pascal ComponentResult ClockRateChanged(ComponentInstance aClock, QTCallBack cb)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0006, 0x7000, 0xA82A);

extern pascal ComponentResult ClockTimeChanged(ComponentInstance aClock, QTCallBack cb)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0007, 0x7000, 0xA82A);

extern pascal ComponentResult ClockSetTimeBase(ComponentInstance aClock, TimeBase tb)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0008, 0x7000, 0xA82A);

extern pascal ComponentResult ClockStartStopChanged(ComponentInstance aClock, QTCallBack cb, Boolean startChanged, Boolean stopChanged)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0009, 0x7000, 0xA82A);

extern pascal ComponentResult ClockGetRate(ComponentInstance aClock, Fixed *rate)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000A, 0x7000, 0xA82A);


enum {
	StandardCompressionType		= 'scdi',
	StandardCompressionSubType	= 'imag'
};

typedef pascal Boolean (*SCModalFilterProcPtr)(DialogPtr theDialog, EventRecord *theEvent, short *itemHit, long refcon);
typedef pascal short (*SCModalHookProcPtr)(DialogPtr theDialog, short itemHit, void *params, long refcon);

#if GENERATINGCFM
typedef UniversalProcPtr SCModalFilterUPP;
typedef UniversalProcPtr SCModalHookUPP;
#else
typedef SCModalFilterProcPtr SCModalFilterUPP;
typedef SCModalHookProcPtr SCModalHookUPP;
#endif
/*	Preference flags.*/

enum {
	scListEveryCodec			= 1L << 1,
	scAllowZeroFrameRate		= 1L << 2,
	scAllowZeroKeyFrameRate		= 1L << 3,
	scShowBestDepth				= 1L << 4,
	scUseMovableModal			= 1L << 5
};

/*	Possible test flags for setting test image.*/

enum {
	scPreferCropping			= 1 << 0,
	scPreferScaling				= 1 << 1,
	scPreferScalingAndCropping	= scPreferScaling | scPreferCropping
};

/*	Dimensions of the image preview box.*/

enum {
	scTestImageWidth			= 80,
	scTestImageHeight			= 80
};

/*	Possible items returned by hookProc.*/

enum {
	scOKItem					= 1,
	scCancelItem				= 2,
	scCustomItem				= 3
};

/*	Result returned when user cancelled.*/

enum {
	scUserCancelled				= 1
};

/* Component selectors*/

enum {
	scPositionRect				= 2,
	scPositionDialog			= 3,
	scSetTestImagePictHandle	= 4,
	scSetTestImagePictFile		= 5,
	scSetTestImagePixMap		= 6,
	scGetBestDeviceRect			= 7,
	scRequestImageSettings		= 10,
	scCompressImage				= 11,
	scCompressPicture			= 12,
	scCompressPictureFile		= 13,
	scRequestSequenceSettings	= 14,
	scCompressSequenceBegin		= 15,
	scCompressSequenceFrame		= 16,
	scCompressSequenceEnd		= 17,
	scDefaultPictHandleSettings	= 18,
	scDefaultPictFileSettings	= 19,
	scDefaultPixMapSettings		= 20,
	scGetInfo					= 21,
	scSetInfo					= 22,
	scNewGWorld					= 23
};

/*	Get/SetInfo structures.*/
struct SCSpatialSettings {
	CodecType 						codecType;
	CodecComponent 					codec;
	short 							depth;
	CodecQ 							spatialQuality;
};
typedef struct SCSpatialSettings SCSpatialSettings;

struct SCTemporalSettings {
	CodecQ 							temporalQuality;
	Fixed 							frameRate;
	long 							keyFrameRate;
};
typedef struct SCTemporalSettings SCTemporalSettings;

struct SCDataRateSettings {
	long 							dataRate;
	long 							frameDuration;
	CodecQ 							minSpatialQuality;
	CodecQ 							minTemporalQuality;
};
typedef struct SCDataRateSettings SCDataRateSettings;

struct SCExtendedProcs {
	SCModalFilterUPP 				filterProc;
	SCModalHookUPP 					hookProc;
	long 							refcon;
	Str31 							customName;
};
typedef struct SCExtendedProcs SCExtendedProcs;

/*	Get/SetInfo selectors*/

enum {
	scSpatialSettingsType		= 'sptl',						/* pointer to SCSpatialSettings struct*/
	scTemporalSettingsType		= 'tprl',						/* pointer to SCTemporalSettings struct*/
	scDataRateSettingsType		= 'drat',						/* pointer to SCDataRateSettings struct*/
	scColorTableType			= 'clut',						/* pointer to CTabHandle*/
	scProgressProcType			= 'prog',						/* pointer to ProgressRecord struct*/
	scExtendedProcsType			= 'xprc',						/* pointer to SCExtendedProcs struct*/
	scPreferenceFlagsType		= 'pref',						/* pointer to long*/
	scSettingsStateType			= 'ssta',						/* pointer to Handle*/
	scSequenceIDType			= 'sequ',						/* pointer to ImageSequence*/
	scWindowPositionType		= 'wndw',						/* pointer to Point*/
	scCodecFlagsType			= 'cflg',						/* pointer to CodecFlags*/
	scCodecSettingsType			= 'cdec',						/* pointer to Handle*/
	scForceKeyValueType			= 'ksim'						/* pointer to long*/
};

/*	scTypeNotFoundErr returned by Get/SetInfo when type cannot be found.*/
struct SCParams {
	long 							flags;
	CodecType 						theCodecType;
	CodecComponent 					theCodec;
	CodecQ 							spatialQuality;
	CodecQ 							temporalQuality;
	short 							depth;
	Fixed 							frameRate;
	long 							keyFrameRate;
	long 							reserved1;
	long 							reserved2;
};
typedef struct SCParams SCParams;


enum {
	scGetCompression			= 1,
	scShowMotionSettings		= 1L << 0,
	scSettingsChangedItem		= -1
};


enum {
	scCompressFlagIgnoreIdenticalFrames = 1
};

#define SCGetCompression(ci, params, where) SCGetCompressionExtended(ci,params,where,0,0,0,0)
/** These are Progress procedures **/
extern pascal ComponentResult SCGetCompressionExtended(ComponentInstance ci, SCParams *params, Point where, SCModalFilterUPP filterProc, SCModalHookUPP hookProc, long refcon, StringPtr customName)
 FIVEWORDINLINE(0x2F3C, 0x0018, 0x0001, 0x7000, 0xA82A);

extern pascal ComponentResult SCPositionRect(ComponentInstance ci, Rect *rp, Point *where)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0002, 0x7000, 0xA82A);

extern pascal ComponentResult SCPositionDialog(ComponentInstance ci, short id, Point *where)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x0003, 0x7000, 0xA82A);

extern pascal ComponentResult SCSetTestImagePictHandle(ComponentInstance ci, PicHandle testPict, Rect *testRect, short testFlags)
 FIVEWORDINLINE(0x2F3C, 0x000A, 0x0004, 0x7000, 0xA82A);

extern pascal ComponentResult SCSetTestImagePictFile(ComponentInstance ci, short testFileRef, Rect *testRect, short testFlags)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0005, 0x7000, 0xA82A);

extern pascal ComponentResult SCSetTestImagePixMap(ComponentInstance ci, PixMapHandle testPixMap, Rect *testRect, short testFlags)
 FIVEWORDINLINE(0x2F3C, 0x000A, 0x0006, 0x7000, 0xA82A);

extern pascal ComponentResult SCGetBestDeviceRect(ComponentInstance ci, Rect *r)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0007, 0x7000, 0xA82A);

extern pascal ComponentResult SCRequestImageSettings(ComponentInstance ci)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x000A, 0x7000, 0xA82A);

extern pascal ComponentResult SCCompressImage(ComponentInstance ci, PixMapHandle src, const Rect *srcRect, ImageDescriptionHandle *desc, Handle *data)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x000B, 0x7000, 0xA82A);

extern pascal ComponentResult SCCompressPicture(ComponentInstance ci, PicHandle srcPicture, PicHandle dstPicture)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x000C, 0x7000, 0xA82A);

extern pascal ComponentResult SCCompressPictureFile(ComponentInstance ci, short srcRefNum, short dstRefNum)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000D, 0x7000, 0xA82A);

extern pascal ComponentResult SCRequestSequenceSettings(ComponentInstance ci)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x000E, 0x7000, 0xA82A);

extern pascal ComponentResult SCCompressSequenceBegin(ComponentInstance ci, PixMapHandle src, const Rect *srcRect, ImageDescriptionHandle *desc)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x000F, 0x7000, 0xA82A);

extern pascal ComponentResult SCCompressSequenceFrame(ComponentInstance ci, PixMapHandle src, const Rect *srcRect, Handle *data, long *dataSize, short *notSyncFlag)
 FIVEWORDINLINE(0x2F3C, 0x0014, 0x0010, 0x7000, 0xA82A);

extern pascal ComponentResult SCCompressSequenceEnd(ComponentInstance ci)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0011, 0x7000, 0xA82A);

extern pascal ComponentResult SCDefaultPictHandleSettings(ComponentInstance ci, PicHandle srcPicture, short motion)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x0012, 0x7000, 0xA82A);

extern pascal ComponentResult SCDefaultPictFileSettings(ComponentInstance ci, short srcRef, short motion)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0013, 0x7000, 0xA82A);

extern pascal ComponentResult SCDefaultPixMapSettings(ComponentInstance ci, PixMapHandle src, short motion)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x0014, 0x7000, 0xA82A);

extern pascal ComponentResult SCGetInfo(ComponentInstance ci, OSType infoType, void *info)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0015, 0x7000, 0xA82A);

extern pascal ComponentResult SCSetInfo(ComponentInstance ci, OSType infoType, void *info)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0016, 0x7000, 0xA82A);

extern pascal ComponentResult SCNewGWorld(ComponentInstance ci, GWorldPtr *gwp, Rect *rp, GWorldFlags flags)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0017, 0x7000, 0xA82A);

extern pascal ComponentResult SCSetCompressFlags(ComponentInstance ci, long flags)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0018, 0x7000, 0xA82A);

extern pascal ComponentResult SCGetCompressFlags(ComponentInstance ci, long *flags)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0019, 0x7000, 0xA82A);


enum {
	TweenComponentType			= 'twen'
};

typedef ComponentInstance TweenerComponent;
typedef struct TweenRecord TweenRecord;
typedef pascal ComponentResult (*TweenerDataProcPtr)(TweenRecord *tr, void *tweenData, long tweenDataSize, long dataDescriptionSeed, Handle dataDescription, ICMCompletionProcRecordPtr asyncCompletionProc, ProcPtr transferProc, void *refCon);

#if GENERATINGCFM
typedef UniversalProcPtr TweenerDataUPP;
#else
typedef TweenerDataProcPtr TweenerDataUPP;
#endif
struct TweenRecord {
	long 							version;

	QTAtomContainer 				container;
	QTAtom 							tweenAtom;
	QTAtom 							dataAtom;
	Fixed 							percent;

	TweenerDataUPP 					dataProc;

	void *							private1;
	void *							private2;
};

extern pascal ComponentResult TweenerInitialize(TweenerComponent tc, QTAtomContainer container, QTAtom tweenAtom, QTAtom dataAtom)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0001, 0x7000, 0xA82A);

extern pascal ComponentResult TweenerDoTween(TweenerComponent tc, TweenRecord *tr)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0002, 0x7000, 0xA82A);

extern pascal ComponentResult TweenerReset(TweenerComponent tc)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0003, 0x7000, 0xA82A);


enum {
	TCSourceRefNameType			= 'name'
};


enum {
	tcDropFrame					= 1 << 0,
	tc24HourMax					= 1 << 1,
	tcNegTimesOK				= 1 << 2,
	tcCounter					= 1 << 3
};

struct TimeCodeDef {
	long 							flags;						/* drop-frame, etc.*/
	TimeScale 						fTimeScale;					/* time scale of frameDuration (eg. 2997)*/
	TimeValue 						frameDuration;				/* duration of each frame (eg. 100)*/
	UInt8 							numFrames;					/* frames/sec for timecode (eg. 30) OR frames/tick for counter mode*/
	UInt8 							padding;					/* unused padding byte*/
};
typedef struct TimeCodeDef TimeCodeDef;


enum {
	tctNegFlag					= 0x80							/* negative bit is in minutes*/
};

struct TimeCodeTime {
	UInt8 							hours;
	UInt8 							minutes;
	UInt8 							seconds;
	UInt8 							frames;
};
typedef struct TimeCodeTime TimeCodeTime;

struct TimeCodeCounter {
	long 							counter;
};
typedef struct TimeCodeCounter TimeCodeCounter;

union TimeCodeRecord {
	TimeCodeTime 					t;
	TimeCodeCounter 				c;
};
typedef union TimeCodeRecord TimeCodeRecord;

struct TimeCodeDescription {
	long 							descSize;					/* standard sample description header*/
	long 							dataFormat;
	long 							resvd1;
	short 							resvd2;
	short 							dataRefIndex;
	long 							flags;						/* timecode specific stuff*/
	TimeCodeDef 					timeCodeDef;
	long 							srcRef[1];
};
typedef struct TimeCodeDescription TimeCodeDescription;

typedef TimeCodeDescription *TimeCodeDescriptionPtr;
typedef TimeCodeDescriptionPtr *TimeCodeDescriptionHandle;

enum {
	tcdfShowTimeCode			= 1 << 0
};

struct TCTextOptions {
	short 							txFont;
	short 							txFace;
	short 							txSize;
	RGBColor 						foreColor;
	RGBColor 						backColor;
};
typedef struct TCTextOptions TCTextOptions;

typedef TCTextOptions *TCTextOptionsPtr;
extern pascal HandlerError TCGetCurrentTimeCode(MediaHandler mh, long *frameNum, TimeCodeDef *tcdef, TimeCodeRecord *tcrec, UserData *srcRefH)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0101, 0x7000, 0xA82A);

extern pascal HandlerError TCGetTimeCodeAtTime(MediaHandler mh, TimeValue mediaTime, long *frameNum, TimeCodeDef *tcdef, TimeCodeRecord *tcdata, UserData *srcRefH)
 FIVEWORDINLINE(0x2F3C, 0x0014, 0x0102, 0x7000, 0xA82A);

extern pascal HandlerError TCTimeCodeToString(MediaHandler mh, TimeCodeDef *tcdef, TimeCodeRecord *tcrec, StringPtr tcStr)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0103, 0x7000, 0xA82A);

extern pascal HandlerError TCTimeCodeToFrameNumber(MediaHandler mh, TimeCodeDef *tcdef, TimeCodeRecord *tcrec, long *frameNumber)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0104, 0x7000, 0xA82A);

extern pascal HandlerError TCFrameNumberToTimeCode(MediaHandler mh, long frameNumber, TimeCodeDef *tcdef, TimeCodeRecord *tcrec)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0105, 0x7000, 0xA82A);

extern pascal HandlerError TCGetSourceRef(MediaHandler mh, TimeCodeDescriptionHandle tcdH, UserData *srefH)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0106, 0x7000, 0xA82A);

extern pascal HandlerError TCSetSourceRef(MediaHandler mh, TimeCodeDescriptionHandle tcdH, UserData srefH)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0107, 0x7000, 0xA82A);

extern pascal HandlerError TCSetTimeCodeFlags(MediaHandler mh, long flags, long flagsMask)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0108, 0x7000, 0xA82A);

extern pascal HandlerError TCGetTimeCodeFlags(MediaHandler mh, long *flags)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0109, 0x7000, 0xA82A);

extern pascal HandlerError TCSetDisplayOptions(MediaHandler mh, TCTextOptionsPtr textOptions)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x010A, 0x7000, 0xA82A);

extern pascal HandlerError TCGetDisplayOptions(MediaHandler mh, TCTextOptionsPtr textOptions)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x010B, 0x7000, 0xA82A);

typedef ComponentInstance MovieImportComponent;
typedef ComponentInstance MovieExportComponent;

enum {
	MovieImportType				= 'eat ',
	MovieExportType				= 'spit'
};


enum {
	canMovieImportHandles		= 1 << 0,
	canMovieImportFiles			= 1 << 1,
	hasMovieImportUserInterface	= 1 << 2,
	canMovieExportHandles		= 1 << 3,
	canMovieExportFiles			= 1 << 4,
	hasMovieExportUserInterface	= 1 << 5,
	dontAutoFileMovieImport		= 1 << 6,
	canMovieExportAuxDataHandle	= 1 << 7,
	canMovieImportValidateHandles = 1 << 8,
	canMovieImportValidateFile	= 1 << 9,
	dontRegisterWithEasyOpen	= 1 << 10,
	canMovieImportInPlace		= 1 << 11,
	movieImportSubTypeIsFileExtension = 1 << 12
};


enum {
	movieImportCreateTrack		= 1,
	movieImportInParallel		= 2,
	movieImportMustUseTrack		= 4
};


enum {
	movieImportResultUsedMultipleTracks = 8
};


enum {
	kMovieExportTextOnly		= 0,
	kMovieExportAbsoluteTime	= 1,
	kMovieExportRelativeTime	= 2
};


enum {
	kMIDIImportSilenceBefore	= 1 << 0,
	kMIDIImportSilenceAfter		= 1 << 1,
	kMIDIImport20Playable		= 1 << 2,
	kMIDIImportWantLyrics		= 1 << 3
};

extern pascal ComponentResult MovieImportHandle(MovieImportComponent ci, Handle dataH, Movie theMovie, Track targetTrack, Track *usedTrack, TimeValue atTime, TimeValue *addedDuration, long inFlags, long *outFlags)
 FIVEWORDINLINE(0x2F3C, 0x0020, 0x0001, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportFile(MovieImportComponent ci, const FSSpec *theFile, Movie theMovie, Track targetTrack, Track *usedTrack, TimeValue atTime, TimeValue *addedDuration, long inFlags, long *outFlags)
 FIVEWORDINLINE(0x2F3C, 0x0020, 0x0002, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportSetSampleDuration(MovieImportComponent ci, TimeValue duration, TimeScale scale)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0003, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportSetSampleDescription(MovieImportComponent ci, SampleDescriptionHandle desc, OSType mediaType)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0004, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportSetMediaFile(MovieImportComponent ci, AliasHandle alias)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0005, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportSetDimensions(MovieImportComponent ci, Fixed width, Fixed height)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0006, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportSetChunkSize(MovieImportComponent ci, long chunkSize)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0007, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportSetProgressProc(MovieImportComponent ci, MovieProgressUPP proc, long refcon)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0008, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportSetAuxiliaryData(MovieImportComponent ci, Handle data, OSType handleType)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0009, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportSetFromScrap(MovieImportComponent ci, Boolean fromScrap)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x000A, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportDoUserDialog(MovieImportComponent ci, const FSSpec *theFile, Handle theData, Boolean *canceled)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x000B, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportSetDuration(MovieImportComponent ci, TimeValue duration)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000C, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportGetAuxiliaryDataType(MovieImportComponent ci, OSType *auxType)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000D, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportValidate(MovieImportComponent ci, const FSSpec *theFile, Handle theData, Boolean *valid)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x000E, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportGetFileType(MovieImportComponent ci, OSType *fileType)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000F, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportDataRef(MovieImportComponent ci, Handle dataRef, OSType dataRefType, Movie theMovie, Track targetTrack, Track *usedTrack, TimeValue atTime, TimeValue *addedDuration, long inFlags, long *outFlags)
 FIVEWORDINLINE(0x2F3C, 0x0024, 0x0010, 0x7000, 0xA82A);

extern pascal ComponentResult MovieImportGetSampleDescription(MovieImportComponent ci, SampleDescriptionHandle *desc, OSType *mediaType)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0011, 0x7000, 0xA82A);

extern pascal ComponentResult MovieExportToHandle(MovieExportComponent ci, Handle dataH, Movie theMovie, Track onlyThisTrack, TimeValue startTime, TimeValue duration)
 FIVEWORDINLINE(0x2F3C, 0x0014, 0x0080, 0x7000, 0xA82A);

extern pascal ComponentResult MovieExportToFile(MovieExportComponent ci, const FSSpec *theFile, Movie theMovie, Track onlyThisTrack, TimeValue startTime, TimeValue duration)
 FIVEWORDINLINE(0x2F3C, 0x0014, 0x0081, 0x7000, 0xA82A);

extern pascal ComponentResult MovieExportGetAuxiliaryData(MovieExportComponent ci, Handle dataH, OSType *handleType)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0083, 0x7000, 0xA82A);

extern pascal ComponentResult MovieExportSetProgressProc(MovieExportComponent ci, MovieProgressUPP proc, long refcon)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0084, 0x7000, 0xA82A);

extern pascal ComponentResult MovieExportSetSampleDescription(MovieExportComponent ci, SampleDescriptionHandle desc, OSType mediaType)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0085, 0x7000, 0xA82A);

extern pascal ComponentResult MovieExportDoUserDialog(MovieExportComponent ci, Movie theMovie, Track onlyThisTrack, TimeValue startTime, TimeValue duration, Boolean *canceled)
 FIVEWORDINLINE(0x2F3C, 0x0014, 0x0086, 0x7000, 0xA82A);

extern pascal ComponentResult MovieExportGetCreatorType(MovieExportComponent ci, OSType *creator)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0087, 0x7000, 0xA82A);

/* Text Export Display Info data structure*/
struct TextDisplayData {
	long 							displayFlags;
	long 							textJustification;
	RGBColor 						bgColor;
	Rect 							textBox;

	short 							beginHilite;
	short 							endHilite;
	RGBColor 						hiliteColor;
	Boolean 						doHiliteColor;
	SInt8 							filler;
	TimeValue 						scrollDelayDur;
	Point 							dropShadowOffset;
	short 							dropShadowTransparency;
};
typedef struct TextDisplayData TextDisplayData;

typedef ComponentInstance TextExportComponent;
extern pascal ComponentResult TextExportGetDisplayData(TextExportComponent ci, TextDisplayData *textDisplay)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0100, 0x7000, 0xA82A);

extern pascal ComponentResult TextExportGetTimeFraction(TextExportComponent ci, long *movieTimeFraction)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0101, 0x7000, 0xA82A);

extern pascal ComponentResult TextExportSetTimeFraction(TextExportComponent ci, long movieTimeFraction)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0102, 0x7000, 0xA82A);

extern pascal ComponentResult TextExportGetSettings(TextExportComponent ci, long *setting)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0103, 0x7000, 0xA82A);

extern pascal ComponentResult TextExportSetSettings(TextExportComponent ci, long setting)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0104, 0x7000, 0xA82A);

extern pascal ComponentResult MIDIImportGetSettings(TextExportComponent ci, long *setting)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0100, 0x7000, 0xA82A);

extern pascal ComponentResult MIDIImportSetSettings(TextExportComponent ci, long setting)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0101, 0x7000, 0xA82A);

/*
**************

	File Preview Components

**************
*/
typedef ComponentInstance pnotComponent;

enum {
	pnotComponentWantsEvents	= 1,
	pnotComponentNeedsNoCache	= 2
};


enum {
	ShowFilePreviewComponentType = 'pnot',
	CreateFilePreviewComponentType = 'pmak'
};

extern pascal ComponentResult PreviewShowData(pnotComponent p, OSType dataType, Handle data, const Rect *inHere)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0001, 0x7000, 0xA82A);

extern pascal ComponentResult PreviewMakePreview(pnotComponent p, OSType *previewType, Handle *previewResult, const FSSpec *sourceFile, ICMProgressProcRecordPtr progress)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0002, 0x7000, 0xA82A);

extern pascal ComponentResult PreviewMakePreviewReference(pnotComponent p, OSType *previewType, short *resID, const FSSpec *sourceFile)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0003, 0x7000, 0xA82A);

extern pascal ComponentResult PreviewEvent(pnotComponent p, EventRecord *e, Boolean *handledEvent)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0004, 0x7000, 0xA82A);

typedef pascal void (*DataHCompletionProcPtr)(Ptr request, long refcon, OSErr err);

#if GENERATINGCFM
typedef UniversalProcPtr DataHCompletionUPP;
#else
typedef DataHCompletionProcPtr DataHCompletionUPP;
#endif

enum {
	kDataHCanRead				= 1L << 0,
	kDataHSpecialRead			= 1L << 1,
	kDataHSpecialReadFile		= 1L << 2,
	kDataHCanWrite				= 1L << 3,
	kDataHSpecialWrite			= 1 << 4,
	kDataHSpecialWriteFile		= 1 << 5,
	kDataHCanStreamingWrite		= 1 << 6,
	kDataHMustCheckDataRef		= 1 << 7
};

struct DataHVolumeListRecord {
	short 							vRefNum;
	long 							flags;
};
typedef struct DataHVolumeListRecord DataHVolumeListRecord;

typedef DataHVolumeListRecord *DataHVolumeListPtr;
typedef DataHVolumeListPtr *DataHVolumeList;

enum {
	kDataHExtendedSchedule		= 'xtnd'
};

struct DataHScheduleRecord {
	TimeRecord 						timeNeededBy;
	long 							extendedID;					/* always is kDataHExtendedSchedule*/
	long 							extendedVers;				/* always set to 0*/
	Fixed 							priority;					/* 100.0 or more means must have. lower numbers…*/
};
typedef struct DataHScheduleRecord DataHScheduleRecord;

typedef DataHScheduleRecord *DataHSchedulePtr;
extern pascal ComponentResult DataHGetData(DataHandler dh, Handle h, long hOffset, long offset, long size)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0002, 0x7000, 0xA82A);

extern pascal ComponentResult DataHPutData(DataHandler dh, Handle h, long hOffset, long *offset, long size)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0003, 0x7000, 0xA82A);

extern pascal ComponentResult DataHFlushData(DataHandler dh)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0004, 0x7000, 0xA82A);

extern pascal ComponentResult DataHOpenForWrite(DataHandler dh)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0005, 0x7000, 0xA82A);

extern pascal ComponentResult DataHCloseForWrite(DataHandler dh)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0006, 0x7000, 0xA82A);

extern pascal ComponentResult DataHOpenForRead(DataHandler dh)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0008, 0x7000, 0xA82A);

extern pascal ComponentResult DataHCloseForRead(DataHandler dh)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0009, 0x7000, 0xA82A);

extern pascal ComponentResult DataHSetDataRef(DataHandler dh, Handle dataRef)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000A, 0x7000, 0xA82A);

extern pascal ComponentResult DataHGetDataRef(DataHandler dh, Handle *dataRef)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000B, 0x7000, 0xA82A);

extern pascal ComponentResult DataHCompareDataRef(DataHandler dh, Handle dataRef, Boolean *equal)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x000C, 0x7000, 0xA82A);

extern pascal ComponentResult DataHTask(DataHandler dh)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x000D, 0x7000, 0xA82A);

extern pascal ComponentResult DataHScheduleData(DataHandler dh, Ptr PlaceToPutDataPtr, long FileOffset, long DataSize, long RefCon, DataHSchedulePtr scheduleRec, DataHCompletionUPP CompletionRtn)
 FIVEWORDINLINE(0x2F3C, 0x0018, 0x000E, 0x7000, 0xA82A);

extern pascal ComponentResult DataHFinishData(DataHandler dh, Ptr PlaceToPutDataPtr, Boolean Cancel)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x000F, 0x7000, 0xA82A);

extern pascal ComponentResult DataHFlushCache(DataHandler dh)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0010, 0x7000, 0xA82A);

extern pascal ComponentResult DataHResolveDataRef(DataHandler dh, Handle theDataRef, Boolean *wasChanged, Boolean userInterfaceAllowed)
 FIVEWORDINLINE(0x2F3C, 0x000A, 0x0011, 0x7000, 0xA82A);

extern pascal ComponentResult DataHGetFileSize(DataHandler dh, long *fileSize)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0012, 0x7000, 0xA82A);

extern pascal ComponentResult DataHCanUseDataRef(DataHandler dh, Handle dataRef, long *useFlags)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0013, 0x7000, 0xA82A);

extern pascal ComponentResult DataHGetVolumeList(DataHandler dh, DataHVolumeList *volumeList)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0014, 0x7000, 0xA82A);

extern pascal ComponentResult DataHWrite(DataHandler dh, Ptr data, long offset, long size, DataHCompletionUPP completion, long refCon)
 FIVEWORDINLINE(0x2F3C, 0x0014, 0x0015, 0x7000, 0xA82A);

extern pascal ComponentResult DataHPreextend(DataHandler dh, long maxToAdd, long *spaceAdded)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0016, 0x7000, 0xA82A);

extern pascal ComponentResult DataHSetFileSize(DataHandler dh, long fileSize)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0017, 0x7000, 0xA82A);

extern pascal ComponentResult DataHGetFreeSpace(DataHandler dh, unsigned long *freeSize)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0018, 0x7000, 0xA82A);

extern pascal ComponentResult DataHCreateFile(DataHandler dh, OSType creator, Boolean deleteExisting)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x0019, 0x7000, 0xA82A);

extern pascal ComponentResult DataHGetPreferredBlockSize(DataHandler dh, long *blockSize)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001A, 0x7000, 0xA82A);

extern pascal ComponentResult DataHGetDeviceIndex(DataHandler dh, long *deviceIndex)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001B, 0x7000, 0xA82A);

extern pascal ComponentResult DataHIsStreamingDataHandler(DataHandler dh, Boolean *yes)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001C, 0x7000, 0xA82A);

extern pascal ComponentResult DataHGetDataInBuffer(DataHandler dh, long startOffset, long *size)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x001D, 0x7000, 0xA82A);

extern pascal ComponentResult DataHGetScheduleAheadTime(DataHandler dh, long *millisecs)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001E, 0x7000, 0xA82A);

extern pascal ComponentResult DataHSetCacheSizeLimit(DataHandler dh, Size cacheSizeLimit)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001F, 0x7000, 0xA82A);

extern pascal ComponentResult DataHGetCacheSizeLimit(DataHandler dh, Size *cacheSizeLimit)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0020, 0x7000, 0xA82A);

extern pascal ComponentResult DataHGetMovie(DataHandler dh, Movie *theMovie, short *id)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0021, 0x7000, 0xA82A);

extern pascal ComponentResult DataHAddMovie(DataHandler dh, Movie theMovie, short *id)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0022, 0x7000, 0xA82A);

extern pascal ComponentResult DataHUpdateMovie(DataHandler dh, Movie theMovie, short id)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x0023, 0x7000, 0xA82A);

extern pascal ComponentResult DataHDoesBuffer(DataHandler dh, Boolean *buffersReads, Boolean *buffersWrites)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0024, 0x7000, 0xA82A);

extern pascal ComponentResult DataHGetFileName(DataHandler dh, Str255 str)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0025, 0x7000, 0xA82A);

extern pascal ComponentResult DataHPlaybackHints(DataHandler dh, long flags, unsigned long minFileOffset, unsigned long maxFileOffset, long bytesPerSecond)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0103, 0x7000, 0xA82A);

/* Standard type for video digitizers */

enum {
	videoDigitizerComponentType	= 'vdig',
	vdigInterfaceRev			= 2
};

/* Input Format Standards */

enum {
	ntscIn						= 0,							/* current input format */
	currentIn					= 0,							/* ntsc input format */
	palIn						= 1,							/* pal input format */
	secamIn						= 2,							/* secam input format */
	ntscReallyIn				= 3								/* ntsc input format */
};

/* Input Formats */

enum {
	compositeIn					= 0,							/* input is composite format */
	sVideoIn					= 1,							/* input is sVideo format */
	rgbComponentIn				= 2,							/* input is rgb component format */
	rgbComponentSyncIn			= 3,							/* input is rgb component format (sync on green?)*/
	yuvComponentIn				= 4,							/* input is yuv component format */
	yuvComponentSyncIn			= 5,							/* input is yuv component format (sync on green?) */
	tvTunerIn					= 6
};

/* Video Digitizer PlayThru States */

enum {
	vdPlayThruOff				= 0,
	vdPlayThruOn				= 1
};

/* Input Color Space Modes */

enum {
	vdDigitizerBW				= 0,							/* black and white */
	vdDigitizerRGB				= 1								/* rgb color */
};

/* Phase Lock Loop Modes */

enum {
	vdBroadcastMode				= 0,							/* Broadcast / Laser Disk video mode */
	vdVTRMode					= 1								/* VCR / Magnetic media mode */
};

/* Field Select Options */

enum {
	vdUseAnyField				= 0,							/* Digitizers choice on field use */
	vdUseOddField				= 1,							/* Use odd field for half size vert and smaller */
	vdUseEvenField				= 2								/* Use even field for half size vert and smaller */
};

/* vdig types */

enum {
	vdTypeBasic					= 0,							/* basic, no clipping */
	vdTypeAlpha					= 1,							/* supports clipping with alpha channel */
	vdTypeMask					= 2,							/* supports clipping with mask plane */
	vdTypeKey					= 3								/* supports clipping with key color(s) */
};

/* Digitizer Input Capability/Current Flags	*/

enum {
	digiInDoesNTSC				= 1L << 0,						/* digitizer supports NTSC input format */
	digiInDoesPAL				= 1L << 1,						/* digitizer supports PAL input format */
	digiInDoesSECAM				= 1L << 2,						/* digitizer supports SECAM input format */
	digiInDoesGenLock			= 1L << 7,						/* digitizer does genlock */
	digiInDoesComposite			= 1L << 8,						/* digitizer supports composite input type */
	digiInDoesSVideo			= 1L << 9,						/* digitizer supports S-Video input type */
	digiInDoesComponent			= 1L << 10,						/* digitizer supports component = rgb, input type */
	digiInVTR_Broadcast			= 1L << 11,						/* digitizer can differentiate between the two */
	digiInDoesColor				= 1L << 12,						/* digitizer supports color */
	digiInDoesBW				= 1L << 13,						/* digitizer supports black & white */
																/* Digitizer Input Current Flags = these are valid only during active operating conditions,	*/
	digiInSignalLock			= 1L << 31						/* digitizer detects input signal is locked, this bit = horiz lock || vertical lock */
};

/* Digitizer Output Capability/Current Flags */

enum {
	digiOutDoes1				= 1L << 0,						/* digitizer supports 1 bit pixels */
	digiOutDoes2				= 1L << 1,						/* digitizer supports 2 bit pixels */
	digiOutDoes4				= 1L << 2,						/* digitizer supports 4 bit pixels */
	digiOutDoes8				= 1L << 3,						/* digitizer supports 8 bit pixels */
	digiOutDoes16				= 1L << 4,						/* digitizer supports 16 bit pixels */
	digiOutDoes32				= 1L << 5,						/* digitizer supports 32 bit pixels */
	digiOutDoesDither			= 1L << 6,						/* digitizer dithers in indexed modes */
	digiOutDoesStretch			= 1L << 7,						/* digitizer can arbitrarily stretch */
	digiOutDoesShrink			= 1L << 8,						/* digitizer can arbitrarily shrink */
	digiOutDoesMask				= 1L << 9,						/* digitizer can mask to clipping regions */
	digiOutDoesDouble			= 1L << 11,						/* digitizer can stretch to exactly double size */
	digiOutDoesQuad				= 1L << 12,						/* digitizer can stretch exactly quadruple size */
	digiOutDoesQuarter			= 1L << 13,						/* digitizer can shrink to exactly quarter size */
	digiOutDoesSixteenth		= 1L << 14,						/* digitizer can shrink to exactly sixteenth size */
	digiOutDoesRotate			= 1L << 15,						/* digitizer supports rotate transformations */
	digiOutDoesHorizFlip		= 1L << 16,						/* digitizer supports horizontal flips Sx < 0 */
	digiOutDoesVertFlip			= 1L << 17,						/* digitizer supports vertical flips Sy < 0 */
	digiOutDoesSkew				= 1L << 18,						/* digitizer supports skew = shear,twist, */
	digiOutDoesBlend			= 1L << 19,
	digiOutDoesWarp				= 1L << 20,
	digiOutDoesHW_DMA			= 1L << 21,						/* digitizer not constrained to local device */
	digiOutDoesHWPlayThru		= 1L << 22,						/* digitizer doesn't need time to play thru */
	digiOutDoesILUT				= 1L << 23,						/* digitizer does inverse LUT for index modes */
	digiOutDoesKeyColor			= 1L << 24,						/* digitizer does key color functions too */
	digiOutDoesAsyncGrabs		= 1L << 25,						/* digitizer supports async grabs */
	digiOutDoesUnreadableScreenBits = 1L << 26,					/* playthru doesn't generate readable bits on screen*/
	digiOutDoesCompress			= 1L << 27,						/* supports alternate output data types */
	digiOutDoesCompressOnly		= 1L << 28,						/* can't provide raw frames anywhere */
	digiOutDoesPlayThruDuringCompress = 1L << 29,				/* digi can do playthru while providing compressed data */
	digiOutDoesCompressPartiallyVisible = 1L << 30				/* digi doesn't need all bits visible on screen to do hardware compress */
};

/* Types */
typedef ComponentInstance VideoDigitizerComponent;
typedef ComponentResult VideoDigitizerError;
struct DigitizerInfo {
	short 							vdigType;
	long 							inputCapabilityFlags;
	long 							outputCapabilityFlags;
	long 							inputCurrentFlags;
	long 							outputCurrentFlags;
	short 							slot;						/* temporary for connection purposes */
	GDHandle 						gdh;						/* temporary for digitizers that have preferred screen */
	GDHandle 						maskgdh;					/* temporary for digitizers that have mask planes */
	short 							minDestHeight;				/* Smallest resizable height */
	short 							minDestWidth;				/* Smallest resizable width */
	short 							maxDestHeight;				/* Largest resizable height */
	short 							maxDestWidth;				/* Largest resizable height */
	short 							blendLevels;				/* Number of blend levels supported (2 if 1 bit mask) */
	long 							reserved;					/* reserved */
};
typedef struct DigitizerInfo DigitizerInfo;

struct VdigType {
	long 							digType;
	long 							reserved;
};
typedef struct VdigType VdigType;

struct VdigTypeList {
	short 							count;
	VdigType 						list[1];
};
typedef struct VdigTypeList VdigTypeList;

struct VdigBufferRec {
	PixMapHandle 					dest;
	Point 							location;
	long 							reserved;
};
typedef struct VdigBufferRec VdigBufferRec;

struct VdigBufferRecList {
	short 							count;
	MatrixRecordPtr 				matrix;
	RgnHandle 						mask;
	VdigBufferRec 					list[1];
};
typedef struct VdigBufferRecList VdigBufferRecList;

typedef VdigBufferRecList *VdigBufferRecListPtr;
typedef VdigBufferRecListPtr *VdigBufferRecListHandle;
typedef pascal void (*VdigIntProcPtr)(long flags, long refcon);

#if GENERATINGCFM
typedef UniversalProcPtr VdigIntUPP;
#else
typedef VdigIntProcPtr VdigIntUPP;
#endif
struct VDCompressionList {
	CodecComponent 					codec;
	CodecType 						cType;
	Str63 							typeName;
	Str63 							name;
	long 							formatFlags;
	long 							compressFlags;
	long 							reserved;
};
typedef struct VDCompressionList VDCompressionList;

typedef VDCompressionList *VDCompressionListPtr;
typedef VDCompressionListPtr *VDCompressionListHandle;

enum {
	dmaDepth1					= 1,
	dmaDepth2					= 2,
	dmaDepth4					= 4,
	dmaDepth8					= 8,
	dmaDepth16					= 16,
	dmaDepth32					= 32,
	dmaDepth2Gray				= 64,
	dmaDepth4Gray				= 128,
	dmaDepth8Gray				= 256
};


enum {
	kVDIGControlledFrameRate	= -1
};

extern pascal VideoDigitizerError VDGetMaxSrcRect(VideoDigitizerComponent ci, short inputStd, Rect *maxSrcRect)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x0001, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetActiveSrcRect(VideoDigitizerComponent ci, short inputStd, Rect *activeSrcRect)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x0002, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetDigitizerRect(VideoDigitizerComponent ci, Rect *digitizerRect)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0003, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetDigitizerRect(VideoDigitizerComponent ci, Rect *digitizerRect)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0004, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetVBlankRect(VideoDigitizerComponent ci, short inputStd, Rect *vBlankRect)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x0005, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetMaskPixMap(VideoDigitizerComponent ci, PixMapHandle maskPixMap)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0006, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetPlayThruDestination(VideoDigitizerComponent ci, PixMapHandle *dest, Rect *destRect, MatrixRecord *m, RgnHandle *mask)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0008, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDUseThisCLUT(VideoDigitizerComponent ci, CTabHandle colorTableHandle)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0009, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetInputGammaValue(VideoDigitizerComponent ci, Fixed channel1, Fixed channel2, Fixed channel3)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x000A, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetInputGammaValue(VideoDigitizerComponent ci, Fixed *channel1, Fixed *channel2, Fixed *channel3)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x000B, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetBrightness(VideoDigitizerComponent ci, unsigned short *brightness)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000C, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetBrightness(VideoDigitizerComponent ci, unsigned short *brightness)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000D, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetContrast(VideoDigitizerComponent ci, unsigned short *contrast)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000E, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetHue(VideoDigitizerComponent ci, unsigned short *hue)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000F, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetSharpness(VideoDigitizerComponent ci, unsigned short *sharpness)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0010, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetSaturation(VideoDigitizerComponent ci, unsigned short *saturation)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0011, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetContrast(VideoDigitizerComponent ci, unsigned short *contrast)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0012, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetHue(VideoDigitizerComponent ci, unsigned short *hue)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0013, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetSharpness(VideoDigitizerComponent ci, unsigned short *sharpness)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0014, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetSaturation(VideoDigitizerComponent ci, unsigned short *saturation)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0015, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGrabOneFrame(VideoDigitizerComponent ci)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0016, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetMaxAuxBuffer(VideoDigitizerComponent ci, PixMapHandle *pm, Rect *r)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0017, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetDigitizerInfo(VideoDigitizerComponent ci, DigitizerInfo *info)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0019, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetCurrentFlags(VideoDigitizerComponent ci, long *inputCurrentFlag, long *outputCurrentFlag)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x001A, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetKeyColor(VideoDigitizerComponent ci, long index)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001B, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetKeyColor(VideoDigitizerComponent ci, long *index)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001C, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDAddKeyColor(VideoDigitizerComponent ci, long *index)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001D, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetNextKeyColor(VideoDigitizerComponent ci, long index)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001E, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetKeyColorRange(VideoDigitizerComponent ci, RGBColor *minRGB, RGBColor *maxRGB)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x001F, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetKeyColorRange(VideoDigitizerComponent ci, RGBColor *minRGB, RGBColor *maxRGB)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0020, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetDigitizerUserInterrupt(VideoDigitizerComponent ci, long flags, VdigIntUPP userInterruptProc, long refcon)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0021, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetInputColorSpaceMode(VideoDigitizerComponent ci, short colorSpaceMode)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0022, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetInputColorSpaceMode(VideoDigitizerComponent ci, short *colorSpaceMode)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0023, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetClipState(VideoDigitizerComponent ci, short clipEnable)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0024, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetClipState(VideoDigitizerComponent ci, short *clipEnable)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0025, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetClipRgn(VideoDigitizerComponent ci, RgnHandle clipRegion)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0026, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDClearClipRgn(VideoDigitizerComponent ci, RgnHandle clipRegion)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0027, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetCLUTInUse(VideoDigitizerComponent ci, CTabHandle *colorTableHandle)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0028, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetPLLFilterType(VideoDigitizerComponent ci, short pllType)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0029, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetPLLFilterType(VideoDigitizerComponent ci, short *pllType)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x002A, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetMaskandValue(VideoDigitizerComponent ci, unsigned short blendLevel, long *mask, long *value)
 FIVEWORDINLINE(0x2F3C, 0x000A, 0x002B, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetMasterBlendLevel(VideoDigitizerComponent ci, unsigned short *blendLevel)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x002C, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetPlayThruDestination(VideoDigitizerComponent ci, PixMapHandle dest, Rect *destRect, MatrixRecord *m, RgnHandle mask)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x002D, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetPlayThruOnOff(VideoDigitizerComponent ci, short state)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x002E, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetFieldPreference(VideoDigitizerComponent ci, short fieldFlag)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x002F, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetFieldPreference(VideoDigitizerComponent ci, short *fieldFlag)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0030, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDPreflightDestination(VideoDigitizerComponent ci, Rect *digitizerRect, PixMap **dest, Rect *destRect, MatrixRecord *m)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0032, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDPreflightGlobalRect(VideoDigitizerComponent ci, GrafPtr theWindow, Rect *globalRect)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0033, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetPlayThruGlobalRect(VideoDigitizerComponent ci, GrafPtr theWindow, Rect *globalRect)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0034, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetInputGammaRecord(VideoDigitizerComponent ci, VDGamRecPtr inputGammaPtr)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0035, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetInputGammaRecord(VideoDigitizerComponent ci, VDGamRecPtr *inputGammaPtr)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0036, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetBlackLevelValue(VideoDigitizerComponent ci, unsigned short *blackLevel)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0037, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetBlackLevelValue(VideoDigitizerComponent ci, unsigned short *blackLevel)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0038, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetWhiteLevelValue(VideoDigitizerComponent ci, unsigned short *whiteLevel)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0039, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetWhiteLevelValue(VideoDigitizerComponent ci, unsigned short *whiteLevel)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x003A, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetVideoDefaults(VideoDigitizerComponent ci, unsigned short *blackLevel, unsigned short *whiteLevel, unsigned short *brightness, unsigned short *hue, unsigned short *saturation, unsigned short *contrast, unsigned short *sharpness)
 FIVEWORDINLINE(0x2F3C, 0x001C, 0x003B, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetNumberOfInputs(VideoDigitizerComponent ci, short *inputs)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x003C, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetInputFormat(VideoDigitizerComponent ci, short input, short *format)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x003D, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetInput(VideoDigitizerComponent ci, short input)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x003E, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetInput(VideoDigitizerComponent ci, short *input)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x003F, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetInputStandard(VideoDigitizerComponent ci, short inputStandard)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0040, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetupBuffers(VideoDigitizerComponent ci, VdigBufferRecListHandle bufferList)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0041, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGrabOneFrameAsync(VideoDigitizerComponent ci, short buffer)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0042, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDDone(VideoDigitizerComponent ci, short buffer)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0043, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetCompression(VideoDigitizerComponent ci, OSType compressType, short depth, Rect *bounds, CodecQ spatialQuality, CodecQ temporalQuality, long keyFrameRate)
 FIVEWORDINLINE(0x2F3C, 0x0016, 0x0044, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDCompressOneFrameAsync(VideoDigitizerComponent ci)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0045, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDCompressDone(VideoDigitizerComponent ci, Boolean *done, Ptr *theData, long *dataSize, UInt8 *similarity, TimeRecord *t)
 FIVEWORDINLINE(0x2F3C, 0x0014, 0x0046, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDReleaseCompressBuffer(VideoDigitizerComponent ci, Ptr bufferAddr)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0047, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetImageDescription(VideoDigitizerComponent ci, ImageDescriptionHandle desc)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0048, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDResetCompressSequence(VideoDigitizerComponent ci)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0049, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetCompressionOnOff(VideoDigitizerComponent ci, Boolean state)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x004A, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetCompressionTypes(VideoDigitizerComponent ci, VDCompressionListHandle h)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x004B, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetTimeBase(VideoDigitizerComponent ci, TimeBase t)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x004C, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetFrameRate(VideoDigitizerComponent ci, Fixed framesPerSecond)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x004D, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetDataRate(VideoDigitizerComponent ci, long *milliSecPerFrame, Fixed *framesPerSecond, long *bytesPerSecond)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x004E, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetSoundInputDriver(VideoDigitizerComponent ci, Str255 soundDriverName)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x004F, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetDMADepths(VideoDigitizerComponent ci, long *depthArray, long *preferredDepth)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0050, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetPreferredTimeScale(VideoDigitizerComponent ci, TimeScale *preferred)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0051, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDReleaseAsyncBuffers(VideoDigitizerComponent ci)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0052, 0x7000, 0xA82A);

/* 83 is reserved for compatibility reasons */
extern pascal VideoDigitizerError VDSetDataRate(VideoDigitizerComponent ci, long bytesPerSecond)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0054, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetTimeCode(VideoDigitizerComponent ci, TimeRecord *atTime, void *timeCodeFormat, void *timeCodeTime)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0055, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDUseSafeBuffers(VideoDigitizerComponent ci, Boolean useSafeBuffers)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0056, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetSoundInputSource(VideoDigitizerComponent ci, long videoInput, long *soundInput)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0057, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDGetCompressionTime(VideoDigitizerComponent ci, OSType compressionType, short depth, Rect *srcRect, CodecQ *spatialQuality, CodecQ *temporalQuality, unsigned long *compressTime)
 FIVEWORDINLINE(0x2F3C, 0x0016, 0x0058, 0x7000, 0xA82A);

extern pascal VideoDigitizerError VDSetPreferredPacketSize(VideoDigitizerComponent ci, long preferredPacketSizeInBytes)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0059, 0x7000, 0xA82A);

/*
	General Sequence Grab stuff
*/
typedef ComponentInstance SeqGrabComponent;
typedef ComponentInstance SGChannel;

enum {
	SeqGrabComponentType		= 'barg',
	SeqGrabChannelType			= 'sgch',
	SeqGrabPanelType			= 'sgpn',
	SeqGrabCompressionPanelType	= 'cmpr',
	SeqGrabSourcePanelType		= 'sour'
};


enum {
	seqGrabToDisk				= 1,
	seqGrabToMemory				= 2,
	seqGrabDontUseTempMemory	= 4,
	seqGrabAppendToFile			= 8,
	seqGrabDontAddMovieResource	= 16,
	seqGrabDontMakeMovie		= 32,
	seqGrabPreExtendFile		= 64,
	seqGrabDataProcIsInterruptSafe = 128,
	seqGrabDataProcDoesOverlappingReads = 256
};

typedef unsigned long SeqGrabDataOutputEnum;

enum {
	seqGrabRecord				= 1,
	seqGrabPreview				= 2,
	seqGrabPlayDuringRecord		= 4
};

typedef unsigned long SeqGrabUsageEnum;

enum {
	seqGrabHasBounds			= 1,
	seqGrabHasVolume			= 2,
	seqGrabHasDiscreteSamples	= 4
};

typedef unsigned long SeqGrabChannelInfoEnum;
struct SeqGrabFrameInfo {
	long 							frameOffset;
	long 							frameTime;
	long 							frameSize;
	SGChannel 						frameChannel;
	long 							frameRefCon;
};
typedef struct SeqGrabFrameInfo SeqGrabFrameInfo;

typedef SeqGrabFrameInfo *SeqGrabFrameInfoPtr;

enum {
	grabPictOffScreen			= 1,
	grabPictIgnoreClip			= 2,
	grabPictCurrentImage		= 4
};


enum {
	sgFlagControlledGrab		= (1 << 0)
};

typedef pascal OSErr (*SGDataProcPtr)(SGChannel c, Ptr p, long len, long *offset, long chRefCon, TimeValue time, short writeType, long refCon);

#if GENERATINGCFM
typedef UniversalProcPtr SGDataUPP;
#else
typedef SGDataProcPtr SGDataUPP;
#endif
struct SGDeviceName {
	Str63 							name;
	Handle 							icon;
	long 							flags;
	long 							refCon;
	long 							reserved;					/* zero*/
};
typedef struct SGDeviceName SGDeviceName;


enum {
	sgDeviceNameFlagDeviceUnavailable = (1 << 0)
};

struct SGDeviceListRecord {
	short 							count;
	short 							selectedIndex;
	long 							reserved;					/* zero*/
	SGDeviceName 					entry[1];
};
typedef struct SGDeviceListRecord SGDeviceListRecord;

typedef SGDeviceListRecord *SGDeviceListPtr;
typedef SGDeviceListPtr *SGDeviceList;

enum {
	sgDeviceListWithIcons		= (1 << 0),
	sgDeviceListDontCheckAvailability = (1 << 1)
};


enum {
	seqGrabWriteAppend			= 0,
	seqGrabWriteReserve			= 1,
	seqGrabWriteFill			= 2
};


enum {
	seqGrabUnpause				= 0,
	seqGrabPause				= 1,
	seqGrabPauseForMenu			= 3
};


enum {
	channelFlagDontOpenResFile	= 2,
	channelFlagHasDependency	= 4
};

typedef pascal Boolean (*SGModalFilterProcPtr)(DialogPtr theDialog, EventRecord *theEvent, short *itemHit, long refCon);

#if GENERATINGCFM
typedef UniversalProcPtr SGModalFilterUPP;
#else
typedef SGModalFilterProcPtr SGModalFilterUPP;
#endif

enum {
	sgPanelFlagForPanel			= 1
};


enum {
	seqGrabSettingsPreviewOnly	= 1
};

struct SGOutputRecord {
	long 							data[1];
};
typedef struct SGOutputRecord SGOutputRecord;

typedef SGOutputRecord *SGOutput;

enum {
	channelPlayNormal			= 0,
	channelPlayFast				= 1,
	channelPlayHighQuality		= 2,
	channelPlayAllData			= 4
};

extern pascal ComponentResult SGInitialize(SeqGrabComponent s)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0001, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetDataOutput(SeqGrabComponent s, const FSSpec *movieFile, long whereFlags)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0002, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetDataOutput(SeqGrabComponent s, FSSpec *movieFile, long *whereFlags)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0003, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetGWorld(SeqGrabComponent s, CGrafPtr gp, GDHandle gd)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0004, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetGWorld(SeqGrabComponent s, CGrafPtr *gp, GDHandle *gd)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0005, 0x7000, 0xA82A);

extern pascal ComponentResult SGNewChannel(SeqGrabComponent s, OSType channelType, SGChannel *ref)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0006, 0x7000, 0xA82A);

extern pascal ComponentResult SGDisposeChannel(SeqGrabComponent s, SGChannel c)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0007, 0x7000, 0xA82A);

extern pascal ComponentResult SGStartPreview(SeqGrabComponent s)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0010, 0x7000, 0xA82A);

extern pascal ComponentResult SGStartRecord(SeqGrabComponent s)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0011, 0x7000, 0xA82A);

extern pascal ComponentResult SGIdle(SeqGrabComponent s)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0012, 0x7000, 0xA82A);

extern pascal ComponentResult SGStop(SeqGrabComponent s)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0013, 0x7000, 0xA82A);

extern pascal ComponentResult SGPause(SeqGrabComponent s, Byte pause)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0014, 0x7000, 0xA82A);

extern pascal ComponentResult SGPrepare(SeqGrabComponent s, Boolean prepareForPreview, Boolean prepareForRecord)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0015, 0x7000, 0xA82A);

extern pascal ComponentResult SGRelease(SeqGrabComponent s)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0016, 0x7000, 0xA82A);

extern pascal Movie SGGetMovie(SeqGrabComponent s)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0017, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetMaximumRecordTime(SeqGrabComponent s, unsigned long ticks)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0018, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetMaximumRecordTime(SeqGrabComponent s, unsigned long *ticks)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0019, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetStorageSpaceRemaining(SeqGrabComponent s, unsigned long *bytes)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001A, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetTimeRemaining(SeqGrabComponent s, long *ticksLeft)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001B, 0x7000, 0xA82A);

extern pascal ComponentResult SGGrabPict(SeqGrabComponent s, PicHandle *p, const Rect *bounds, short offscreenDepth, long grabPictFlags)
 FIVEWORDINLINE(0x2F3C, 0x000E, 0x001C, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetLastMovieResID(SeqGrabComponent s, short *resID)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001D, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetFlags(SeqGrabComponent s, long sgFlags)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001E, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetFlags(SeqGrabComponent s, long *sgFlags)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x001F, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetDataProc(SeqGrabComponent s, SGDataUPP proc, long refCon)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0020, 0x7000, 0xA82A);

extern pascal ComponentResult SGNewChannelFromComponent(SeqGrabComponent s, SGChannel *newChannel, Component sgChannelComponent)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0021, 0x7000, 0xA82A);

extern pascal ComponentResult SGDisposeDeviceList(SeqGrabComponent s, SGDeviceList list)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0022, 0x7000, 0xA82A);

extern pascal ComponentResult SGAppendDeviceListToMenu(SeqGrabComponent s, SGDeviceList list, MenuHandle mh)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0023, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetSettings(SeqGrabComponent s, UserData ud, long flags)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0024, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetSettings(SeqGrabComponent s, UserData *ud, long flags)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0025, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetIndChannel(SeqGrabComponent s, short index, SGChannel *ref, OSType *chanType)
 FIVEWORDINLINE(0x2F3C, 0x000A, 0x0026, 0x7000, 0xA82A);

extern pascal ComponentResult SGUpdate(SeqGrabComponent s, RgnHandle updateRgn)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0027, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetPause(SeqGrabComponent s, Byte *paused)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0028, 0x7000, 0xA82A);

typedef const Component *ConstComponentListPtr;
extern pascal ComponentResult SGSettingsDialog(SeqGrabComponent s, SGChannel c, short numPanels, ConstComponentListPtr panelList, long flags, SGModalFilterUPP proc, long procRefNum)
 FIVEWORDINLINE(0x2F3C, 0x0016, 0x0029, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetAlignmentProc(SeqGrabComponent s, ICMAlignmentProcRecordPtr alignmentProc)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x002A, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetChannelSettings(SeqGrabComponent s, SGChannel c, UserData ud, long flags)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x002B, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetChannelSettings(SeqGrabComponent s, SGChannel c, UserData *ud, long flags)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x002C, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetMode(SeqGrabComponent s, Boolean *previewMode, Boolean *recordMode)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x002D, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetDataRef(SeqGrabComponent s, Handle dataRef, OSType dataRefType, long whereFlags)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x002E, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetDataRef(SeqGrabComponent s, Handle *dataRef, OSType *dataRefType, long *whereFlags)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x002F, 0x7000, 0xA82A);

extern pascal ComponentResult SGNewOutput(SeqGrabComponent s, Handle dataRef, OSType dataRefType, long whereFlags, SGOutput *sgOut)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0030, 0x7000, 0xA82A);

extern pascal ComponentResult SGDisposeOutput(SeqGrabComponent s, SGOutput sgOut)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0031, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetOutputFlags(SeqGrabComponent s, SGOutput sgOut, long whereFlags)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0032, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetChannelOutput(SeqGrabComponent s, SGChannel c, SGOutput sgOut)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0033, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetDataOutputStorageSpaceRemaining(SeqGrabComponent s, SGOutput sgOut, unsigned long *space)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0034, 0x7000, 0xA82A);

extern pascal ComponentResult SGHandleUpdateEvent(SeqGrabComponent s, EventRecord *event, Boolean *handled)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0035, 0x7000, 0xA82A);

/*
	calls from Channel to seqGrab
*/
extern pascal ComponentResult SGWriteMovieData(SeqGrabComponent s, SGChannel c, Ptr p, long len, long *offset)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0100, 0x7000, 0xA82A);

extern pascal ComponentResult SGAddFrameReference(SeqGrabComponent s, SeqGrabFrameInfoPtr frameInfo)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0101, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetNextFrameReference(SeqGrabComponent s, SeqGrabFrameInfoPtr frameInfo, TimeValue *frameDuration, long *frameNumber)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0102, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetTimeBase(SeqGrabComponent s, TimeBase *tb)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0103, 0x7000, 0xA82A);

extern pascal ComponentResult SGSortDeviceList(SeqGrabComponent s, SGDeviceList list)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0104, 0x7000, 0xA82A);

extern pascal ComponentResult SGAddMovieData(SeqGrabComponent s, SGChannel c, Ptr p, long len, long *offset, long chRefCon, TimeValue time, short writeType)
 FIVEWORDINLINE(0x2F3C, 0x001A, 0x0105, 0x7000, 0xA82A);

extern pascal ComponentResult SGChangedSource(SeqGrabComponent s, SGChannel c)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0106, 0x7000, 0xA82A);

/*** Sequence Grab CHANNEL Component Stuff ***/
extern pascal ComponentResult SGSetChannelUsage(SGChannel c, long usage)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0080, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetChannelUsage(SGChannel c, long *usage)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0081, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetChannelBounds(SGChannel c, const Rect *bounds)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0082, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetChannelBounds(SGChannel c, Rect *bounds)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0083, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetChannelVolume(SGChannel c, short volume)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0084, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetChannelVolume(SGChannel c, short *volume)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0085, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetChannelInfo(SGChannel c, long *channelInfo)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0086, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetChannelPlayFlags(SGChannel c, long playFlags)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0087, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetChannelPlayFlags(SGChannel c, long *playFlags)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0088, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetChannelMaxFrames(SGChannel c, long frameCount)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0089, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetChannelMaxFrames(SGChannel c, long *frameCount)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x008A, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetChannelRefCon(SGChannel c, long refCon)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x008B, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetChannelClip(SGChannel c, RgnHandle theClip)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x008C, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetChannelClip(SGChannel c, RgnHandle *theClip)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x008D, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetChannelSampleDescription(SGChannel c, Handle sampleDesc)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x008E, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetChannelDeviceList(SGChannel c, long selectionFlags, SGDeviceList *list)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x008F, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetChannelDevice(SGChannel c, StringPtr name)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0090, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetChannelMatrix(SGChannel c, const MatrixRecord *m)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0091, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetChannelMatrix(SGChannel c, MatrixRecord *m)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0092, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetChannelTimeScale(SGChannel c, TimeScale *scale)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0093, 0x7000, 0xA82A);

extern pascal ComponentResult SGChannelPutPicture(SGChannel c)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0094, 0x7000, 0xA82A);

extern pascal ComponentResult SGChannelSetRequestedDataRate(SGChannel c, long bytesPerSecond)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0095, 0x7000, 0xA82A);

extern pascal ComponentResult SGChannelGetRequestedDataRate(SGChannel c, long *bytesPerSecond)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0096, 0x7000, 0xA82A);

extern pascal ComponentResult SGChannelSetDataSourceName(SGChannel c, ConstStr255Param name, ScriptCode scriptTag)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x0097, 0x7000, 0xA82A);

extern pascal ComponentResult SGChannelGetDataSourceName(SGChannel c, Str255 name, ScriptCode *scriptTag)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0098, 0x7000, 0xA82A);

/*
	calls from seqGrab to Channel
*/
extern pascal ComponentResult SGInitChannel(SGChannel c, SeqGrabComponent owner)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0180, 0x7000, 0xA82A);

extern pascal ComponentResult SGWriteSamples(SGChannel c, Movie m, AliasHandle theFile)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0181, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetDataRate(SGChannel c, long *bytesPerSecond)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0182, 0x7000, 0xA82A);

extern pascal ComponentResult SGAlignChannelRect(SGChannel c, Rect *r)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0183, 0x7000, 0xA82A);

/*
	Dorky dialog panel calls
*/
extern pascal ComponentResult SGPanelGetDitl(SeqGrabComponent s, Handle *ditl)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0200, 0x7000, 0xA82A);

extern pascal ComponentResult SGPanelGetTitle(SeqGrabComponent s, Str255 title)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0201, 0x7000, 0xA82A);

extern pascal ComponentResult SGPanelCanRun(SeqGrabComponent s, SGChannel c)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0202, 0x7000, 0xA82A);

extern pascal ComponentResult SGPanelInstall(SeqGrabComponent s, SGChannel c, DialogPtr d, short itemOffset)
 FIVEWORDINLINE(0x2F3C, 0x000A, 0x0203, 0x7000, 0xA82A);

extern pascal ComponentResult SGPanelEvent(SeqGrabComponent s, SGChannel c, DialogPtr d, short itemOffset, EventRecord *theEvent, short *itemHit, Boolean *handled)
 FIVEWORDINLINE(0x2F3C, 0x0016, 0x0204, 0x7000, 0xA82A);

extern pascal ComponentResult SGPanelItem(SeqGrabComponent s, SGChannel c, DialogPtr d, short itemOffset, short itemNum)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0205, 0x7000, 0xA82A);

extern pascal ComponentResult SGPanelRemove(SeqGrabComponent s, SGChannel c, DialogPtr d, short itemOffset)
 FIVEWORDINLINE(0x2F3C, 0x000A, 0x0206, 0x7000, 0xA82A);

extern pascal ComponentResult SGPanelSetGrabber(SeqGrabComponent s, SeqGrabComponent sg)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0207, 0x7000, 0xA82A);

extern pascal ComponentResult SGPanelSetResFile(SeqGrabComponent s, short resRef)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0208, 0x7000, 0xA82A);

extern pascal ComponentResult SGPanelGetSettings(SeqGrabComponent s, SGChannel c, UserData *ud, long flags)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0209, 0x7000, 0xA82A);

extern pascal ComponentResult SGPanelSetSettings(SeqGrabComponent s, SGChannel c, UserData ud, long flags)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x020A, 0x7000, 0xA82A);

extern pascal ComponentResult SGPanelValidateInput(SeqGrabComponent s, Boolean *ok)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x020B, 0x7000, 0xA82A);

extern pascal ComponentResult SGPanelSetEventFilter(SeqGrabComponent s, SGModalFilterUPP proc, long refCon)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x020C, 0x7000, 0xA82A);

/*** Sequence Grab VIDEO CHANNEL Component Stuff ***/
/*
	Video stuff
*/
struct SGCompressInfo {
	Ptr 							buffer;
	unsigned long 					bufferSize;
	UInt8 							similarity;
	UInt8 							reserved;
};
typedef struct SGCompressInfo SGCompressInfo;

typedef pascal ComponentResult (*SGGrabBottleProcPtr)(SGChannel c, short bufferNum, long refCon);
typedef pascal ComponentResult (*SGGrabCompleteBottleProcPtr)(SGChannel c, short bufferNum, Boolean *done, long refCon);
typedef pascal ComponentResult (*SGDisplayBottleProcPtr)(SGChannel c, short bufferNum, MatrixRecord *mp, RgnHandle clipRgn, long refCon);
typedef pascal ComponentResult (*SGCompressBottleProcPtr)(SGChannel c, short bufferNum, long refCon);
typedef pascal ComponentResult (*SGCompressCompleteBottleProcPtr)(SGChannel c, short bufferNum, Boolean *done, SGCompressInfo *ci, long refCon);
typedef pascal ComponentResult (*SGAddFrameBottleProcPtr)(SGChannel c, short bufferNum, TimeValue atTime, TimeScale scale, const SGCompressInfo *ci, long refCon);
typedef pascal ComponentResult (*SGTransferFrameBottleProcPtr)(SGChannel c, short bufferNum, MatrixRecord *mp, RgnHandle clipRgn, long refCon);
typedef pascal ComponentResult (*SGGrabCompressCompleteBottleProcPtr)(SGChannel c, Boolean *done, SGCompressInfo *ci, TimeRecord *t, long refCon);
typedef pascal ComponentResult (*SGDisplayCompressBottleProcPtr)(SGChannel c, Ptr dataPtr, ImageDescriptionHandle desc, MatrixRecord *mp, RgnHandle clipRgn, long refCon);

#if GENERATINGCFM
typedef UniversalProcPtr SGGrabBottleUPP;
typedef UniversalProcPtr SGGrabCompleteBottleUPP;
typedef UniversalProcPtr SGDisplayBottleUPP;
typedef UniversalProcPtr SGCompressBottleUPP;
typedef UniversalProcPtr SGCompressCompleteBottleUPP;
typedef UniversalProcPtr SGAddFrameBottleUPP;
typedef UniversalProcPtr SGTransferFrameBottleUPP;
typedef UniversalProcPtr SGGrabCompressCompleteBottleUPP;
typedef UniversalProcPtr SGDisplayCompressBottleUPP;
#else
typedef SGGrabBottleProcPtr SGGrabBottleUPP;
typedef SGGrabCompleteBottleProcPtr SGGrabCompleteBottleUPP;
typedef SGDisplayBottleProcPtr SGDisplayBottleUPP;
typedef SGCompressBottleProcPtr SGCompressBottleUPP;
typedef SGCompressCompleteBottleProcPtr SGCompressCompleteBottleUPP;
typedef SGAddFrameBottleProcPtr SGAddFrameBottleUPP;
typedef SGTransferFrameBottleProcPtr SGTransferFrameBottleUPP;
typedef SGGrabCompressCompleteBottleProcPtr SGGrabCompressCompleteBottleUPP;
typedef SGDisplayCompressBottleProcPtr SGDisplayCompressBottleUPP;
#endif
struct VideoBottles {
	short 							procCount;
	SGGrabBottleUPP 				grabProc;
	SGGrabCompleteBottleUPP 		grabCompleteProc;
	SGDisplayBottleUPP 				displayProc;
	SGCompressBottleUPP 			compressProc;
	SGCompressCompleteBottleUPP 	compressCompleteProc;
	SGAddFrameBottleUPP 			addFrameProc;
	SGTransferFrameBottleUPP 		transferFrameProc;
	SGGrabCompressCompleteBottleUPP  grabCompressCompleteProc;
	SGDisplayCompressBottleUPP 		displayCompressProc;
};
typedef struct VideoBottles VideoBottles;

extern pascal ComponentResult SGGetSrcVideoBounds(SGChannel c, Rect *r)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0100, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetVideoRect(SGChannel c, const Rect *r)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0101, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetVideoRect(SGChannel c, Rect *r)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0102, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetVideoCompressorType(SGChannel c, OSType *compressorType)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0103, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetVideoCompressorType(SGChannel c, OSType compressorType)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0104, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetVideoCompressor(SGChannel c, short depth, CompressorComponent compressor, CodecQ spatialQuality, CodecQ temporalQuality, long keyFrameRate)
 FIVEWORDINLINE(0x2F3C, 0x0012, 0x0105, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetVideoCompressor(SGChannel c, short *depth, CompressorComponent *compressor, CodecQ *spatialQuality, CodecQ *temporalQuality, long *keyFrameRate)
 FIVEWORDINLINE(0x2F3C, 0x0014, 0x0106, 0x7000, 0xA82A);

extern pascal ComponentInstance SGGetVideoDigitizerComponent(SGChannel c)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0107, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetVideoDigitizerComponent(SGChannel c, ComponentInstance vdig)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0108, 0x7000, 0xA82A);

extern pascal ComponentResult SGVideoDigitizerChanged(SGChannel c)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0109, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetVideoBottlenecks(SGChannel c, VideoBottles *vb)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x010A, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetVideoBottlenecks(SGChannel c, VideoBottles *vb)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x010B, 0x7000, 0xA82A);

extern pascal ComponentResult SGGrabFrame(SGChannel c, short bufferNum)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x010C, 0x7000, 0xA82A);

extern pascal ComponentResult SGGrabFrameComplete(SGChannel c, short bufferNum, Boolean *done)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x010D, 0x7000, 0xA82A);

extern pascal ComponentResult SGDisplayFrame(SGChannel c, short bufferNum, const MatrixRecord *mp, RgnHandle clipRgn)
 FIVEWORDINLINE(0x2F3C, 0x000A, 0x010E, 0x7000, 0xA82A);

extern pascal ComponentResult SGCompressFrame(SGChannel c, short bufferNum)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x010F, 0x7000, 0xA82A);

extern pascal ComponentResult SGCompressFrameComplete(SGChannel c, short bufferNum, Boolean *done, SGCompressInfo *ci)
 FIVEWORDINLINE(0x2F3C, 0x000A, 0x0110, 0x7000, 0xA82A);

extern pascal ComponentResult SGAddFrame(SGChannel c, short bufferNum, TimeValue atTime, TimeScale scale, const SGCompressInfo *ci)
 FIVEWORDINLINE(0x2F3C, 0x000E, 0x0111, 0x7000, 0xA82A);

extern pascal ComponentResult SGTransferFrameForCompress(SGChannel c, short bufferNum, const MatrixRecord *mp, RgnHandle clipRgn)
 FIVEWORDINLINE(0x2F3C, 0x000A, 0x0112, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetCompressBuffer(SGChannel c, short depth, const Rect *compressSize)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x0113, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetCompressBuffer(SGChannel c, short *depth, Rect *compressSize)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0114, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetBufferInfo(SGChannel c, short bufferNum, PixMapHandle *bufferPM, Rect *bufferRect, GWorldPtr *compressBuffer, Rect *compressBufferRect)
 FIVEWORDINLINE(0x2F3C, 0x0012, 0x0115, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetUseScreenBuffer(SGChannel c, Boolean useScreenBuffer)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0116, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetUseScreenBuffer(SGChannel c, Boolean *useScreenBuffer)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0117, 0x7000, 0xA82A);

extern pascal ComponentResult SGGrabCompressComplete(SGChannel c, Boolean *done, SGCompressInfo *ci, TimeRecord *tr)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0118, 0x7000, 0xA82A);

extern pascal ComponentResult SGDisplayCompress(SGChannel c, Ptr dataPtr, ImageDescriptionHandle desc, MatrixRecord *mp, RgnHandle clipRgn)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0119, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetFrameRate(SGChannel c, Fixed frameRate)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x011A, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetFrameRate(SGChannel c, Fixed *frameRate)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x011B, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetPreferredPacketSize(SGChannel c, long preferredPacketSizeInBytes)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0121, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetPreferredPacketSize(SGChannel c, long *preferredPacketSizeInBytes)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0122, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetUserVideoCompressorList(SGChannel c, Handle compressorTypes)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0123, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetUserVideoCompressorList(SGChannel c, Handle *compressorTypes)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0124, 0x7000, 0xA82A);

/*** Sequence Grab SOUND CHANNEL Component Stuff ***/
/*
	Sound stuff
*/
extern pascal ComponentResult SGSetSoundInputDriver(SGChannel c, ConstStr255Param driverName)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0100, 0x7000, 0xA82A);

extern pascal long SGGetSoundInputDriver(SGChannel c)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0101, 0x7000, 0xA82A);

extern pascal ComponentResult SGSoundInputDriverChanged(SGChannel c)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0102, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetSoundRecordChunkSize(SGChannel c, long seconds)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0103, 0x7000, 0xA82A);

extern pascal long SGGetSoundRecordChunkSize(SGChannel c)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0104, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetSoundInputRate(SGChannel c, Fixed rate)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0105, 0x7000, 0xA82A);

extern pascal Fixed SGGetSoundInputRate(SGChannel c)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0106, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetSoundInputParameters(SGChannel c, short sampleSize, short numChannels, OSType compressionType)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0107, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetSoundInputParameters(SGChannel c, short *sampleSize, short *numChannels, OSType *compressionType)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0108, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetAdditionalSoundRates(SGChannel c, Handle rates)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0109, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetAdditionalSoundRates(SGChannel c, Handle *rates)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x010A, 0x7000, 0xA82A);

/*
	Text stuff
*/
extern pascal ComponentResult SGSetFontName(SGChannel c, StringPtr pstr)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0100, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetFontSize(SGChannel c, short fontSize)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0101, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetTextForeColor(SGChannel c, RGBColor *theColor)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0102, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetTextBackColor(SGChannel c, RGBColor *theColor)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0103, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetJustification(SGChannel c, short just)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0104, 0x7000, 0xA82A);

extern pascal ComponentResult SGGetTextReturnToSpaceValue(SGChannel c, short *rettospace)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0105, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetTextReturnToSpaceValue(SGChannel c, short rettospace)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0106, 0x7000, 0xA82A);

/*
	Music stuff
*/
extern pascal ComponentResult SGGetInstrument(SGChannel c, ToneDescription *td)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0100, 0x7000, 0xA82A);

extern pascal ComponentResult SGSetInstrument(SGChannel c, ToneDescription *td)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0101, 0x7000, 0xA82A);


enum {
	sgChannelAtom				= 'chan',
	sgChannelSettingsAtom		= 'ctom',
	sgChannelDescription		= 'cdsc',
	sgChannelSettings			= 'cset'
};


enum {
	sgDeviceNameType			= 'name',
	sgUsageType					= 'use ',
	sgPlayFlagsType				= 'plyf',
	sgClipType					= 'clip',
	sgMatrixType				= 'mtrx',
	sgVolumeType				= 'volu'
};


enum {
	sgPanelSettingsAtom			= 'ptom',
	sgPanelDescription			= 'pdsc',
	sgPanelSettings				= 'pset'
};


enum {
	sgcSoundCompressionType		= 'scmp',
	sgcSoundSampleRateType		= 'srat',
	sgcSoundChannelCountType	= 'schn',
	sgcSoundSampleSizeType		= 'ssiz',
	sgcSoundInputType			= 'sinp',
	sgcSoundGainType			= 'gain'
};


enum {
	sgcVideoHueType				= 'hue ',
	sgcVideoSaturationType		= 'satr',
	sgcVideoContrastType		= 'trst',
	sgcVideoSharpnessType		= 'shrp',
	sgcVideoBrigtnessType		= 'brit',
	sgcVideoBlackLevelType		= 'blkl',
	sgcVideoWhiteLevelType		= 'whtl',
	sgcVideoInputType			= 'vinp',
	sgcVideoFormatType			= 'vstd',
	sgcVideoFilterType			= 'vflt',
	sgcVideoRectType			= 'vrct',
	sgcVideoDigitizerType		= 'vdig'
};

/* UPP call backs */

#if GENERATINGCFM
#else
#endif

enum {
	uppSCModalFilterProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(DialogPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(EventRecord *)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short *)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long))),
	uppSCModalHookProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(DialogPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void *)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long))),
	uppTweenerDataProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(ComponentResult)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(TweenRecord *)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void *)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(Handle)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(ICMCompletionProcRecordPtr)))
		 | STACK_ROUTINE_PARAMETER(7, SIZE_CODE(sizeof(ProcPtr)))
		 | STACK_ROUTINE_PARAMETER(8, SIZE_CODE(sizeof(void *))),
	uppDataHCompletionProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(OSErr))),
	uppVdigIntProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long))),
	uppSGDataProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SGChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long *)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(TimeValue)))
		 | STACK_ROUTINE_PARAMETER(7, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(8, SIZE_CODE(sizeof(long))),
	uppSGModalFilterProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(DialogPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(EventRecord *)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short *)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long))),
	uppSGGrabBottleProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(ComponentResult)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SGChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long))),
	uppSGGrabCompleteBottleProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(ComponentResult)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SGChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Boolean *)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long))),
	uppSGDisplayBottleProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(ComponentResult)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SGChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(MatrixRecord *)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(RgnHandle)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(long))),
	uppSGCompressBottleProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(ComponentResult)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SGChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long))),
	uppSGCompressCompleteBottleProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(ComponentResult)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SGChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Boolean *)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(SGCompressInfo *)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(long))),
	uppSGAddFrameBottleProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(ComponentResult)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SGChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(TimeValue)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(TimeScale)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(const SGCompressInfo *)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(long))),
	uppSGTransferFrameBottleProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(ComponentResult)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SGChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(MatrixRecord *)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(RgnHandle)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(long))),
	uppSGGrabCompressCompleteBottleProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(ComponentResult)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SGChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Boolean *)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(SGCompressInfo *)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(TimeRecord *)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(long))),
	uppSGDisplayCompressBottleProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(ComponentResult)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(SGChannel)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(ImageDescriptionHandle)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(MatrixRecord *)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(RgnHandle)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewSCModalFilterProc(userRoutine)		\
		(SCModalFilterUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSCModalFilterProcInfo, GetCurrentArchitecture())
#define NewSCModalHookProc(userRoutine)		\
		(SCModalHookUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSCModalHookProcInfo, GetCurrentArchitecture())
#define NewTweenerDataProc(userRoutine)		\
		(TweenerDataUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppTweenerDataProcInfo, GetCurrentArchitecture())
#define NewDataHCompletionProc(userRoutine)		\
		(DataHCompletionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDataHCompletionProcInfo, GetCurrentArchitecture())
#define NewVdigIntProc(userRoutine)		\
		(VdigIntUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppVdigIntProcInfo, GetCurrentArchitecture())
#define NewSGDataProc(userRoutine)		\
		(SGDataUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSGDataProcInfo, GetCurrentArchitecture())
#define NewSGModalFilterProc(userRoutine)		\
		(SGModalFilterUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSGModalFilterProcInfo, GetCurrentArchitecture())
#define NewSGGrabBottleProc(userRoutine)		\
		(SGGrabBottleUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSGGrabBottleProcInfo, GetCurrentArchitecture())
#define NewSGGrabCompleteBottleProc(userRoutine)		\
		(SGGrabCompleteBottleUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSGGrabCompleteBottleProcInfo, GetCurrentArchitecture())
#define NewSGDisplayBottleProc(userRoutine)		\
		(SGDisplayBottleUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSGDisplayBottleProcInfo, GetCurrentArchitecture())
#define NewSGCompressBottleProc(userRoutine)		\
		(SGCompressBottleUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSGCompressBottleProcInfo, GetCurrentArchitecture())
#define NewSGCompressCompleteBottleProc(userRoutine)		\
		(SGCompressCompleteBottleUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSGCompressCompleteBottleProcInfo, GetCurrentArchitecture())
#define NewSGAddFrameBottleProc(userRoutine)		\
		(SGAddFrameBottleUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSGAddFrameBottleProcInfo, GetCurrentArchitecture())
#define NewSGTransferFrameBottleProc(userRoutine)		\
		(SGTransferFrameBottleUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSGTransferFrameBottleProcInfo, GetCurrentArchitecture())
#define NewSGGrabCompressCompleteBottleProc(userRoutine)		\
		(SGGrabCompressCompleteBottleUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSGGrabCompressCompleteBottleProcInfo, GetCurrentArchitecture())
#define NewSGDisplayCompressBottleProc(userRoutine)		\
		(SGDisplayCompressBottleUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppSGDisplayCompressBottleProcInfo, GetCurrentArchitecture())
#else
#define NewSCModalFilterProc(userRoutine)		\
		((SCModalFilterUPP) (userRoutine))
#define NewSCModalHookProc(userRoutine)		\
		((SCModalHookUPP) (userRoutine))
#define NewTweenerDataProc(userRoutine)		\
		((TweenerDataUPP) (userRoutine))
#define NewDataHCompletionProc(userRoutine)		\
		((DataHCompletionUPP) (userRoutine))
#define NewVdigIntProc(userRoutine)		\
		((VdigIntUPP) (userRoutine))
#define NewSGDataProc(userRoutine)		\
		((SGDataUPP) (userRoutine))
#define NewSGModalFilterProc(userRoutine)		\
		((SGModalFilterUPP) (userRoutine))
#define NewSGGrabBottleProc(userRoutine)		\
		((SGGrabBottleUPP) (userRoutine))
#define NewSGGrabCompleteBottleProc(userRoutine)		\
		((SGGrabCompleteBottleUPP) (userRoutine))
#define NewSGDisplayBottleProc(userRoutine)		\
		((SGDisplayBottleUPP) (userRoutine))
#define NewSGCompressBottleProc(userRoutine)		\
		((SGCompressBottleUPP) (userRoutine))
#define NewSGCompressCompleteBottleProc(userRoutine)		\
		((SGCompressCompleteBottleUPP) (userRoutine))
#define NewSGAddFrameBottleProc(userRoutine)		\
		((SGAddFrameBottleUPP) (userRoutine))
#define NewSGTransferFrameBottleProc(userRoutine)		\
		((SGTransferFrameBottleUPP) (userRoutine))
#define NewSGGrabCompressCompleteBottleProc(userRoutine)		\
		((SGGrabCompressCompleteBottleUPP) (userRoutine))
#define NewSGDisplayCompressBottleProc(userRoutine)		\
		((SGDisplayCompressBottleUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallSCModalFilterProc(userRoutine, theDialog, theEvent, itemHit, refcon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSCModalFilterProcInfo, (theDialog), (theEvent), (itemHit), (refcon))
#define CallSCModalHookProc(userRoutine, theDialog, itemHit, params, refcon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSCModalHookProcInfo, (theDialog), (itemHit), (params), (refcon))
#define CallTweenerDataProc(userRoutine, tr, tweenData, tweenDataSize, dataDescriptionSeed, dataDescription, asyncCompletionProc, transferProc, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppTweenerDataProcInfo, (tr), (tweenData), (tweenDataSize), (dataDescriptionSeed), (dataDescription), (asyncCompletionProc), (transferProc), (refCon))
#define CallDataHCompletionProc(userRoutine, request, refcon, err)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDataHCompletionProcInfo, (request), (refcon), (err))
#define CallVdigIntProc(userRoutine, flags, refcon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppVdigIntProcInfo, (flags), (refcon))
#define CallSGDataProc(userRoutine, c, p, len, offset, chRefCon, time, writeType, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSGDataProcInfo, (c), (p), (len), (offset), (chRefCon), (time), (writeType), (refCon))
#define CallSGModalFilterProc(userRoutine, theDialog, theEvent, itemHit, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSGModalFilterProcInfo, (theDialog), (theEvent), (itemHit), (refCon))
#define CallSGGrabBottleProc(userRoutine, c, bufferNum, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSGGrabBottleProcInfo, (c), (bufferNum), (refCon))
#define CallSGGrabCompleteBottleProc(userRoutine, c, bufferNum, done, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSGGrabCompleteBottleProcInfo, (c), (bufferNum), (done), (refCon))
#define CallSGDisplayBottleProc(userRoutine, c, bufferNum, mp, clipRgn, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSGDisplayBottleProcInfo, (c), (bufferNum), (mp), (clipRgn), (refCon))
#define CallSGCompressBottleProc(userRoutine, c, bufferNum, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSGCompressBottleProcInfo, (c), (bufferNum), (refCon))
#define CallSGCompressCompleteBottleProc(userRoutine, c, bufferNum, done, ci, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSGCompressCompleteBottleProcInfo, (c), (bufferNum), (done), (ci), (refCon))
#define CallSGAddFrameBottleProc(userRoutine, c, bufferNum, atTime, scale, ci, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSGAddFrameBottleProcInfo, (c), (bufferNum), (atTime), (scale), (ci), (refCon))
#define CallSGTransferFrameBottleProc(userRoutine, c, bufferNum, mp, clipRgn, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSGTransferFrameBottleProcInfo, (c), (bufferNum), (mp), (clipRgn), (refCon))
#define CallSGGrabCompressCompleteBottleProc(userRoutine, c, done, ci, t, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSGGrabCompressCompleteBottleProcInfo, (c), (done), (ci), (t), (refCon))
#define CallSGDisplayCompressBottleProc(userRoutine, c, dataPtr, desc, mp, clipRgn, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppSGDisplayCompressBottleProcInfo, (c), (dataPtr), (desc), (mp), (clipRgn), (refCon))
#else
#define CallSCModalFilterProc(userRoutine, theDialog, theEvent, itemHit, refcon)		\
		(*(userRoutine))((theDialog), (theEvent), (itemHit), (refcon))
#define CallSCModalHookProc(userRoutine, theDialog, itemHit, params, refcon)		\
		(*(userRoutine))((theDialog), (itemHit), (params), (refcon))
#define CallTweenerDataProc(userRoutine, tr, tweenData, tweenDataSize, dataDescriptionSeed, dataDescription, asyncCompletionProc, transferProc, refCon)		\
		(*(userRoutine))((tr), (tweenData), (tweenDataSize), (dataDescriptionSeed), (dataDescription), (asyncCompletionProc), (transferProc), (refCon))
#define CallDataHCompletionProc(userRoutine, request, refcon, err)		\
		(*(userRoutine))((request), (refcon), (err))
#define CallVdigIntProc(userRoutine, flags, refcon)		\
		(*(userRoutine))((flags), (refcon))
#define CallSGDataProc(userRoutine, c, p, len, offset, chRefCon, time, writeType, refCon)		\
		(*(userRoutine))((c), (p), (len), (offset), (chRefCon), (time), (writeType), (refCon))
#define CallSGModalFilterProc(userRoutine, theDialog, theEvent, itemHit, refCon)		\
		(*(userRoutine))((theDialog), (theEvent), (itemHit), (refCon))
#define CallSGGrabBottleProc(userRoutine, c, bufferNum, refCon)		\
		(*(userRoutine))((c), (bufferNum), (refCon))
#define CallSGGrabCompleteBottleProc(userRoutine, c, bufferNum, done, refCon)		\
		(*(userRoutine))((c), (bufferNum), (done), (refCon))
#define CallSGDisplayBottleProc(userRoutine, c, bufferNum, mp, clipRgn, refCon)		\
		(*(userRoutine))((c), (bufferNum), (mp), (clipRgn), (refCon))
#define CallSGCompressBottleProc(userRoutine, c, bufferNum, refCon)		\
		(*(userRoutine))((c), (bufferNum), (refCon))
#define CallSGCompressCompleteBottleProc(userRoutine, c, bufferNum, done, ci, refCon)		\
		(*(userRoutine))((c), (bufferNum), (done), (ci), (refCon))
#define CallSGAddFrameBottleProc(userRoutine, c, bufferNum, atTime, scale, ci, refCon)		\
		(*(userRoutine))((c), (bufferNum), (atTime), (scale), (ci), (refCon))
#define CallSGTransferFrameBottleProc(userRoutine, c, bufferNum, mp, clipRgn, refCon)		\
		(*(userRoutine))((c), (bufferNum), (mp), (clipRgn), (refCon))
#define CallSGGrabCompressCompleteBottleProc(userRoutine, c, done, ci, t, refCon)		\
		(*(userRoutine))((c), (done), (ci), (t), (refCon))
#define CallSGDisplayCompressBottleProc(userRoutine, c, dataPtr, desc, mp, clipRgn, refCon)		\
		(*(userRoutine))((c), (dataPtr), (desc), (mp), (clipRgn), (refCon))
#endif

/* selectors for component calls */
enum {
	kClockGetTimeSelect								= 0x0001,
	kClockNewCallBackSelect							= 0x0002,
	kClockDisposeCallBackSelect						= 0x0003,
	kClockCallMeWhenSelect							= 0x0004,
	kClockCancelCallBackSelect						= 0x0005,
	kClockRateChangedSelect							= 0x0006,
	kClockTimeChangedSelect							= 0x0007,
	kClockSetTimeBaseSelect							= 0x0008,
	kClockStartStopChangedSelect					= 0x0009,
	kClockGetRateSelect								= 0x000A,
	kSCGetCompressionExtendedSelect					= 0x0001,
	kSCPositionRectSelect							= 0x0002,
	kSCPositionDialogSelect							= 0x0003,
	kSCSetTestImagePictHandleSelect					= 0x0004,
	kSCSetTestImagePictFileSelect					= 0x0005,
	kSCSetTestImagePixMapSelect						= 0x0006,
	kSCGetBestDeviceRectSelect						= 0x0007,
	kSCRequestImageSettingsSelect					= 0x000A,
	kSCCompressImageSelect							= 0x000B,
	kSCCompressPictureSelect						= 0x000C,
	kSCCompressPictureFileSelect					= 0x000D,
	kSCRequestSequenceSettingsSelect				= 0x000E,
	kSCCompressSequenceBeginSelect					= 0x000F,
	kSCCompressSequenceFrameSelect					= 0x0010,
	kSCCompressSequenceEndSelect					= 0x0011,
	kSCDefaultPictHandleSettingsSelect				= 0x0012,
	kSCDefaultPictFileSettingsSelect				= 0x0013,
	kSCDefaultPixMapSettingsSelect					= 0x0014,
	kSCGetInfoSelect								= 0x0015,
	kSCSetInfoSelect								= 0x0016,
	kSCNewGWorldSelect								= 0x0017,
	kSCSetCompressFlagsSelect						= 0x0018,
	kSCGetCompressFlagsSelect						= 0x0019,
	kTweenerInitializeSelect						= 0x0001,
	kTweenerDoTweenSelect							= 0x0002,
	kTweenerResetSelect								= 0x0003,
	kTCGetCurrentTimeCodeSelect						= 0x0101,
	kTCGetTimeCodeAtTimeSelect						= 0x0102,
	kTCTimeCodeToStringSelect						= 0x0103,
	kTCTimeCodeToFrameNumberSelect					= 0x0104,
	kTCFrameNumberToTimeCodeSelect					= 0x0105,
	kTCGetSourceRefSelect							= 0x0106,
	kTCSetSourceRefSelect							= 0x0107,
	kTCSetTimeCodeFlagsSelect						= 0x0108,
	kTCGetTimeCodeFlagsSelect						= 0x0109,
	kTCSetDisplayOptionsSelect						= 0x010A,
	kTCGetDisplayOptionsSelect						= 0x010B,
	kMovieImportHandleSelect						= 0x0001,
	kMovieImportFileSelect							= 0x0002,
	kMovieImportSetSampleDurationSelect				= 0x0003,
	kMovieImportSetSampleDescriptionSelect			= 0x0004,
	kMovieImportSetMediaFileSelect					= 0x0005,
	kMovieImportSetDimensionsSelect					= 0x0006,
	kMovieImportSetChunkSizeSelect					= 0x0007,
	kMovieImportSetProgressProcSelect				= 0x0008,
	kMovieImportSetAuxiliaryDataSelect				= 0x0009,
	kMovieImportSetFromScrapSelect					= 0x000A,
	kMovieImportDoUserDialogSelect					= 0x000B,
	kMovieImportSetDurationSelect					= 0x000C,
	kMovieImportGetAuxiliaryDataTypeSelect			= 0x000D,
	kMovieImportValidateSelect						= 0x000E,
	kMovieImportGetFileTypeSelect					= 0x000F,
	kMovieImportDataRefSelect						= 0x0010,
	kMovieImportGetSampleDescriptionSelect			= 0x0011,
	kMovieExportToHandleSelect						= 0x0080,
	kMovieExportToFileSelect						= 0x0081,
	kMovieExportGetAuxiliaryDataSelect				= 0x0083,
	kMovieExportSetProgressProcSelect				= 0x0084,
	kMovieExportSetSampleDescriptionSelect			= 0x0085,
	kMovieExportDoUserDialogSelect					= 0x0086,
	kMovieExportGetCreatorTypeSelect				= 0x0087,
	kTextExportGetDisplayDataSelect					= 0x0100,
	kTextExportGetTimeFractionSelect				= 0x0101,
	kTextExportSetTimeFractionSelect				= 0x0102,
	kTextExportGetSettingsSelect					= 0x0103,
	kTextExportSetSettingsSelect					= 0x0104,
	kMIDIImportGetSettingsSelect					= 0x0100,
	kMIDIImportSetSettingsSelect					= 0x0101,
	kPreviewShowDataSelect							= 0x0001,
	kPreviewMakePreviewSelect						= 0x0002,
	kPreviewMakePreviewReferenceSelect				= 0x0003,
	kPreviewEventSelect								= 0x0004,
	kDataHGetDataSelect								= 0x0002,
	kDataHPutDataSelect								= 0x0003,
	kDataHFlushDataSelect							= 0x0004,
	kDataHOpenForWriteSelect						= 0x0005,
	kDataHCloseForWriteSelect						= 0x0006,
	kDataHOpenForReadSelect							= 0x0008,
	kDataHCloseForReadSelect						= 0x0009,
	kDataHSetDataRefSelect							= 0x000A,
	kDataHGetDataRefSelect							= 0x000B,
	kDataHCompareDataRefSelect						= 0x000C,
	kDataHTaskSelect								= 0x000D,
	kDataHScheduleDataSelect						= 0x000E,
	kDataHFinishDataSelect							= 0x000F,
	kDataHFlushCacheSelect							= 0x0010,
	kDataHResolveDataRefSelect						= 0x0011,
	kDataHGetFileSizeSelect							= 0x0012,
	kDataHCanUseDataRefSelect						= 0x0013,
	kDataHGetVolumeListSelect						= 0x0014,
	kDataHWriteSelect								= 0x0015,
	kDataHPreextendSelect							= 0x0016,
	kDataHSetFileSizeSelect							= 0x0017,
	kDataHGetFreeSpaceSelect						= 0x0018,
	kDataHCreateFileSelect							= 0x0019,
	kDataHGetPreferredBlockSizeSelect				= 0x001A,
	kDataHGetDeviceIndexSelect						= 0x001B,
	kDataHIsStreamingDataHandlerSelect				= 0x001C,
	kDataHGetDataInBufferSelect						= 0x001D,
	kDataHGetScheduleAheadTimeSelect				= 0x001E,
	kDataHSetCacheSizeLimitSelect					= 0x001F,
	kDataHGetCacheSizeLimitSelect					= 0x0020,
	kDataHGetMovieSelect							= 0x0021,
	kDataHAddMovieSelect							= 0x0022,
	kDataHUpdateMovieSelect							= 0x0023,
	kDataHDoesBufferSelect							= 0x0024,
	kDataHGetFileNameSelect							= 0x0025,
	kDataHPlaybackHintsSelect						= 0x0103,
	kVDGetMaxSrcRectSelect							= 0x0001,
	kVDGetActiveSrcRectSelect						= 0x0002,
	kVDSetDigitizerRectSelect						= 0x0003,
	kVDGetDigitizerRectSelect						= 0x0004,
	kVDGetVBlankRectSelect							= 0x0005,
	kVDGetMaskPixMapSelect							= 0x0006,
	kVDGetPlayThruDestinationSelect					= 0x0008,
	kVDUseThisCLUTSelect							= 0x0009,
	kVDSetInputGammaValueSelect						= 0x000A,
	kVDGetInputGammaValueSelect						= 0x000B,
	kVDSetBrightnessSelect							= 0x000C,
	kVDGetBrightnessSelect							= 0x000D,
	kVDSetContrastSelect							= 0x000E,
	kVDSetHueSelect									= 0x000F,
	kVDSetSharpnessSelect							= 0x0010,
	kVDSetSaturationSelect							= 0x0011,
	kVDGetContrastSelect							= 0x0012,
	kVDGetHueSelect									= 0x0013,
	kVDGetSharpnessSelect							= 0x0014,
	kVDGetSaturationSelect							= 0x0015,
	kVDGrabOneFrameSelect							= 0x0016,
	kVDGetMaxAuxBufferSelect						= 0x0017,
	kVDGetDigitizerInfoSelect						= 0x0019,
	kVDGetCurrentFlagsSelect						= 0x001A,
	kVDSetKeyColorSelect							= 0x001B,
	kVDGetKeyColorSelect							= 0x001C,
	kVDAddKeyColorSelect							= 0x001D,
	kVDGetNextKeyColorSelect						= 0x001E,
	kVDSetKeyColorRangeSelect						= 0x001F,
	kVDGetKeyColorRangeSelect						= 0x0020,
	kVDSetDigitizerUserInterruptSelect				= 0x0021,
	kVDSetInputColorSpaceModeSelect					= 0x0022,
	kVDGetInputColorSpaceModeSelect					= 0x0023,
	kVDSetClipStateSelect							= 0x0024,
	kVDGetClipStateSelect							= 0x0025,
	kVDSetClipRgnSelect								= 0x0026,
	kVDClearClipRgnSelect							= 0x0027,
	kVDGetCLUTInUseSelect							= 0x0028,
	kVDSetPLLFilterTypeSelect						= 0x0029,
	kVDGetPLLFilterTypeSelect						= 0x002A,
	kVDGetMaskandValueSelect						= 0x002B,
	kVDSetMasterBlendLevelSelect					= 0x002C,
	kVDSetPlayThruDestinationSelect					= 0x002D,
	kVDSetPlayThruOnOffSelect						= 0x002E,
	kVDSetFieldPreferenceSelect						= 0x002F,
	kVDGetFieldPreferenceSelect						= 0x0030,
	kVDPreflightDestinationSelect					= 0x0032,
	kVDPreflightGlobalRectSelect					= 0x0033,
	kVDSetPlayThruGlobalRectSelect					= 0x0034,
	kVDSetInputGammaRecordSelect					= 0x0035,
	kVDGetInputGammaRecordSelect					= 0x0036,
	kVDSetBlackLevelValueSelect						= 0x0037,
	kVDGetBlackLevelValueSelect						= 0x0038,
	kVDSetWhiteLevelValueSelect						= 0x0039,
	kVDGetWhiteLevelValueSelect						= 0x003A,
	kVDGetVideoDefaultsSelect						= 0x003B,
	kVDGetNumberOfInputsSelect						= 0x003C,
	kVDGetInputFormatSelect							= 0x003D,
	kVDSetInputSelect								= 0x003E,
	kVDGetInputSelect								= 0x003F,
	kVDSetInputStandardSelect						= 0x0040,
	kVDSetupBuffersSelect							= 0x0041,
	kVDGrabOneFrameAsyncSelect						= 0x0042,
	kVDDoneSelect									= 0x0043,
	kVDSetCompressionSelect							= 0x0044,
	kVDCompressOneFrameAsyncSelect					= 0x0045,
	kVDCompressDoneSelect							= 0x0046,
	kVDReleaseCompressBufferSelect					= 0x0047,
	kVDGetImageDescriptionSelect					= 0x0048,
	kVDResetCompressSequenceSelect					= 0x0049,
	kVDSetCompressionOnOffSelect					= 0x004A,
	kVDGetCompressionTypesSelect					= 0x004B,
	kVDSetTimeBaseSelect							= 0x004C,
	kVDSetFrameRateSelect							= 0x004D,
	kVDGetDataRateSelect							= 0x004E,
	kVDGetSoundInputDriverSelect					= 0x004F,
	kVDGetDMADepthsSelect							= 0x0050,
	kVDGetPreferredTimeScaleSelect					= 0x0051,
	kVDReleaseAsyncBuffersSelect					= 0x0052,
	kVDSetDataRateSelect							= 0x0054,
	kVDGetTimeCodeSelect							= 0x0055,
	kVDUseSafeBuffersSelect							= 0x0056,
	kVDGetSoundInputSourceSelect					= 0x0057,
	kVDGetCompressionTimeSelect						= 0x0058,
	kVDSetPreferredPacketSizeSelect					= 0x0059,
	kSGInitializeSelect								= 0x0001,
	kSGSetDataOutputSelect							= 0x0002,
	kSGGetDataOutputSelect							= 0x0003,
	kSGSetGWorldSelect								= 0x0004,
	kSGGetGWorldSelect								= 0x0005,
	kSGNewChannelSelect								= 0x0006,
	kSGDisposeChannelSelect							= 0x0007,
	kSGStartPreviewSelect							= 0x0010,
	kSGStartRecordSelect							= 0x0011,
	kSGIdleSelect									= 0x0012,
	kSGStopSelect									= 0x0013,
	kSGPauseSelect									= 0x0014,
	kSGPrepareSelect								= 0x0015,
	kSGReleaseSelect								= 0x0016,
	kSGGetMovieSelect								= 0x0017,
	kSGSetMaximumRecordTimeSelect					= 0x0018,
	kSGGetMaximumRecordTimeSelect					= 0x0019,
	kSGGetStorageSpaceRemainingSelect				= 0x001A,
	kSGGetTimeRemainingSelect						= 0x001B,
	kSGGrabPictSelect								= 0x001C,
	kSGGetLastMovieResIDSelect						= 0x001D,
	kSGSetFlagsSelect								= 0x001E,
	kSGGetFlagsSelect								= 0x001F,
	kSGSetDataProcSelect							= 0x0020,
	kSGNewChannelFromComponentSelect				= 0x0021,
	kSGDisposeDeviceListSelect						= 0x0022,
	kSGAppendDeviceListToMenuSelect					= 0x0023,
	kSGSetSettingsSelect							= 0x0024,
	kSGGetSettingsSelect							= 0x0025,
	kSGGetIndChannelSelect							= 0x0026,
	kSGUpdateSelect									= 0x0027,
	kSGGetPauseSelect								= 0x0028,
	kSGSettingsDialogSelect							= 0x0029,
	kSGGetAlignmentProcSelect						= 0x002A,
	kSGSetChannelSettingsSelect						= 0x002B,
	kSGGetChannelSettingsSelect						= 0x002C,
	kSGGetModeSelect								= 0x002D,
	kSGSetDataRefSelect								= 0x002E,
	kSGGetDataRefSelect								= 0x002F,
	kSGNewOutputSelect								= 0x0030,
	kSGDisposeOutputSelect							= 0x0031,
	kSGSetOutputFlagsSelect							= 0x0032,
	kSGSetChannelOutputSelect						= 0x0033,
	kSGGetDataOutputStorageSpaceRemainingSelect		= 0x0034,
	kSGHandleUpdateEventSelect						= 0x0035,
	kSGWriteMovieDataSelect							= 0x0100,
	kSGAddFrameReferenceSelect						= 0x0101,
	kSGGetNextFrameReferenceSelect					= 0x0102,
	kSGGetTimeBaseSelect							= 0x0103,
	kSGSortDeviceListSelect							= 0x0104,
	kSGAddMovieDataSelect							= 0x0105,
	kSGChangedSourceSelect							= 0x0106,
	kSGSetChannelUsageSelect						= 0x0080,
	kSGGetChannelUsageSelect						= 0x0081,
	kSGSetChannelBoundsSelect						= 0x0082,
	kSGGetChannelBoundsSelect						= 0x0083,
	kSGSetChannelVolumeSelect						= 0x0084,
	kSGGetChannelVolumeSelect						= 0x0085,
	kSGGetChannelInfoSelect							= 0x0086,
	kSGSetChannelPlayFlagsSelect					= 0x0087,
	kSGGetChannelPlayFlagsSelect					= 0x0088,
	kSGSetChannelMaxFramesSelect					= 0x0089,
	kSGGetChannelMaxFramesSelect					= 0x008A,
	kSGSetChannelRefConSelect						= 0x008B,
	kSGSetChannelClipSelect							= 0x008C,
	kSGGetChannelClipSelect							= 0x008D,
	kSGGetChannelSampleDescriptionSelect			= 0x008E,
	kSGGetChannelDeviceListSelect					= 0x008F,
	kSGSetChannelDeviceSelect						= 0x0090,
	kSGSetChannelMatrixSelect						= 0x0091,
	kSGGetChannelMatrixSelect						= 0x0092,
	kSGGetChannelTimeScaleSelect					= 0x0093,
	kSGChannelPutPictureSelect						= 0x0094,
	kSGChannelSetRequestedDataRateSelect			= 0x0095,
	kSGChannelGetRequestedDataRateSelect			= 0x0096,
	kSGChannelSetDataSourceNameSelect				= 0x0097,
	kSGChannelGetDataSourceNameSelect				= 0x0098,
	kSGInitChannelSelect							= 0x0180,
	kSGWriteSamplesSelect							= 0x0181,
	kSGGetDataRateSelect							= 0x0182,
	kSGAlignChannelRectSelect						= 0x0183,
	kSGPanelGetDitlSelect							= 0x0200,
	kSGPanelGetTitleSelect							= 0x0201,
	kSGPanelCanRunSelect							= 0x0202,
	kSGPanelInstallSelect							= 0x0203,
	kSGPanelEventSelect								= 0x0204,
	kSGPanelItemSelect								= 0x0205,
	kSGPanelRemoveSelect							= 0x0206,
	kSGPanelSetGrabberSelect						= 0x0207,
	kSGPanelSetResFileSelect						= 0x0208,
	kSGPanelGetSettingsSelect						= 0x0209,
	kSGPanelSetSettingsSelect						= 0x020A,
	kSGPanelValidateInputSelect						= 0x020B,
	kSGPanelSetEventFilterSelect					= 0x020C,
	kSGGetSrcVideoBoundsSelect						= 0x0100,
	kSGSetVideoRectSelect							= 0x0101,
	kSGGetVideoRectSelect							= 0x0102,
	kSGGetVideoCompressorTypeSelect					= 0x0103,
	kSGSetVideoCompressorTypeSelect					= 0x0104,
	kSGSetVideoCompressorSelect						= 0x0105,
	kSGGetVideoCompressorSelect						= 0x0106,
	kSGGetVideoDigitizerComponentSelect				= 0x0107,
	kSGSetVideoDigitizerComponentSelect				= 0x0108,
	kSGVideoDigitizerChangedSelect					= 0x0109,
	kSGSetVideoBottlenecksSelect					= 0x010A,
	kSGGetVideoBottlenecksSelect					= 0x010B,
	kSGGrabFrameSelect								= 0x010C,
	kSGGrabFrameCompleteSelect						= 0x010D,
	kSGDisplayFrameSelect							= 0x010E,
	kSGCompressFrameSelect							= 0x010F,
	kSGCompressFrameCompleteSelect					= 0x0110,
	kSGAddFrameSelect								= 0x0111,
	kSGTransferFrameForCompressSelect				= 0x0112,
	kSGSetCompressBufferSelect						= 0x0113,
	kSGGetCompressBufferSelect						= 0x0114,
	kSGGetBufferInfoSelect							= 0x0115,
	kSGSetUseScreenBufferSelect						= 0x0116,
	kSGGetUseScreenBufferSelect						= 0x0117,
	kSGGrabCompressCompleteSelect					= 0x0118,
	kSGDisplayCompressSelect						= 0x0119,
	kSGSetFrameRateSelect							= 0x011A,
	kSGGetFrameRateSelect							= 0x011B,
	kSGSetPreferredPacketSizeSelect					= 0x0121,
	kSGGetPreferredPacketSizeSelect					= 0x0122,
	kSGSetUserVideoCompressorListSelect				= 0x0123,
	kSGGetUserVideoCompressorListSelect				= 0x0124,
	kSGSetSoundInputDriverSelect					= 0x0100,
	kSGGetSoundInputDriverSelect					= 0x0101,
	kSGSoundInputDriverChangedSelect				= 0x0102,
	kSGSetSoundRecordChunkSizeSelect				= 0x0103,
	kSGGetSoundRecordChunkSizeSelect				= 0x0104,
	kSGSetSoundInputRateSelect						= 0x0105,
	kSGGetSoundInputRateSelect						= 0x0106,
	kSGSetSoundInputParametersSelect				= 0x0107,
	kSGGetSoundInputParametersSelect				= 0x0108,
	kSGSetAdditionalSoundRatesSelect				= 0x0109,
	kSGGetAdditionalSoundRatesSelect				= 0x010A,
	kSGSetFontNameSelect							= 0x0100,
	kSGSetFontSizeSelect							= 0x0101,
	kSGSetTextForeColorSelect						= 0x0102,
	kSGSetTextBackColorSelect						= 0x0103,
	kSGSetJustificationSelect						= 0x0104,
	kSGGetTextReturnToSpaceValueSelect				= 0x0105,
	kSGSetTextReturnToSpaceValueSelect				= 0x0106,
	kSGGetInstrumentSelect							= 0x0100,
	kSGSetInstrumentSelect							= 0x0101
};

#if OLDROUTINENAMES

/* These functions had differnt names in the prerelease QT 2.5 interfaces */
#define SGSetTextColor(c, r) 			SGSetTextForeColor(c, r)
#define SGGetTextRetToSpaceValue(c, r) 	SGGetTextReturnToSpaceValue(c, r)
#define SGSetTextRetToSpaceValue(c, r) 	SGSetTextReturnToSpaceValue(c, r)

enum {
/* These selector values did not follow the standard naming convention before QT 2.5 */
	kSelectVDGetMaxSrcRect 				= kVDGetMaxSrcRectSelect,
	kSelectVDGetActiveSrcRect 			= kVDGetActiveSrcRectSelect,
	kSelectVDSetDigitizerRect 			= kVDSetDigitizerRectSelect,
	kSelectVDGetDigitizerRect 			= kVDGetDigitizerRectSelect,
	kSelectVDGetVBlankRect 				= kVDGetVBlankRectSelect,
	kSelectVDGetMaskPixMap 				= kVDGetMaskPixMapSelect,
	kSelectVDGetPlayThruDestination 	= kVDGetPlayThruDestinationSelect,
	kSelectVDUseThisCLUT 				= kVDUseThisCLUTSelect,
	kSelectVDSetInputGammaValue 		= kVDSetInputGammaValueSelect,
	kSelectVDGetInputGammaValue 		= kVDGetInputGammaValueSelect,
	kSelectVDSetBrightness 				= kVDSetBrightnessSelect,
	kSelectVDGetBrightness 				= kVDGetBrightnessSelect,
	kSelectVDSetContrast 				= kVDSetContrastSelect,
	kSelectVDSetHue 					= kVDSetHueSelect,
	kSelectVDSetSharpness 				= kVDSetSharpnessSelect,
	kSelectVDSetSaturation 				= kVDSetSaturationSelect,
	kSelectVDGetContrast 				= kVDGetContrastSelect,
	kSelectVDGetHue 					= kVDGetHueSelect,
	kSelectVDGetSharpness 				= kVDGetSharpnessSelect,
	kSelectVDGetSaturation 				= kVDGetSaturationSelect,
	kSelectVDGrabOneFrame 				= kVDGrabOneFrameSelect,
	kSelectVDGetMaxAuxBuffer			= kVDGetMaxAuxBufferSelect,
	kSelectVDGetDigitizerInfo 			= kVDGetDigitizerInfoSelect,
	kSelectVDGetCurrentFlags 			= kVDGetCurrentFlagsSelect,
	kSelectVDSetKeyColor 				= kVDSetKeyColorSelect,
	kSelectVDGetKeyColor 				= kVDGetKeyColorSelect,
	kSelectVDAddKeyColor 				= kVDAddKeyColorSelect,
	kSelectVDGetNextKeyColor 			= kVDGetNextKeyColorSelect,
	kSelectVDSetKeyColorRange 			= kVDSetKeyColorRangeSelect,
	kSelectVDGetKeyColorRange 			= kVDGetKeyColorRangeSelect,
	kSelectVDSetDigitizerUserInterrupt	= kVDSetDigitizerUserInterruptSelect,
	kSelectVDSetInputColorSpaceMode 	= kVDSetInputColorSpaceModeSelect,
	kSelectVDGetInputColorSpaceMode 	= kVDGetInputColorSpaceModeSelect,
	kSelectVDSetClipState 				= kVDSetClipStateSelect,
	kSelectVDGetClipState 				= kVDGetClipStateSelect,
	kSelectVDSetClipRgn 				= kVDSetClipRgnSelect,
	kSelectVDClearClipRgn 				= kVDClearClipRgnSelect,
	kSelectVDGetCLUTInUse 				= kVDGetCLUTInUseSelect,
	kSelectVDSetPLLFilterType 			= kVDSetPLLFilterTypeSelect,
	kSelectVDGetPLLFilterType 			= kVDGetPLLFilterTypeSelect,
	kSelectVDGetMaskandValue 			= kVDGetMaskandValueSelect,
	kSelectVDSetMasterBlendLevel 		= kVDSetMasterBlendLevelSelect,
	kSelectVDSetPlayThruDestination 	= kVDSetPlayThruDestinationSelect,
	kSelectVDSetPlayThruOnOff 			= kVDSetPlayThruOnOffSelect,
	kSelectVDSetFieldPreference 		= kVDSetFieldPreferenceSelect,
	kSelectVDGetFieldPreference 		= kVDGetFieldPreferenceSelect,
	kSelectVDPreflightDestination 		= kVDPreflightDestinationSelect,
	kSelectVDPreflightGlobalRect 		= kVDPreflightGlobalRectSelect,
	kSelectVDSetPlayThruGlobalRect 		= kVDSetPlayThruGlobalRectSelect,
	kSelectVDSetInputGammaRecord 		= kVDSetInputGammaRecordSelect,
	kSelectVDGetInputGammaRecord 		= kVDGetInputGammaRecordSelect,
	kSelectVDSetBlackLevelValue 		= kVDSetBlackLevelValueSelect,
	kSelectVDGetBlackLevelValue 		= kVDGetBlackLevelValueSelect,
	kSelectVDSetWhiteLevelValue 		= kVDSetWhiteLevelValueSelect,
	kSelectVDGetWhiteLevelValue 		= kVDGetWhiteLevelValueSelect,
	kSelectVDGetVideoDefaults 			= kVDGetVideoDefaultsSelect,
	kSelectVDGetNumberOfInputs 			= kVDGetNumberOfInputsSelect,
	kSelectVDGetInputFormat 			= kVDGetInputFormatSelect,
	kSelectVDSetInput 					= kVDSetInputSelect,
	kSelectVDGetInput 					= kVDGetInputSelect,
	kSelectVDSetInputStandard 			= kVDSetInputStandardSelect,
	kSelectVDSetupBuffers 				= kVDSetupBuffersSelect,
	kSelectVDGrabOneFrameAsync 			= kVDGrabOneFrameAsyncSelect,
	kSelectVDDone 						= kVDDoneSelect,
	kSelectVDSetCompression 			= kVDSetCompressionSelect,
	kSelectVDCompressOneFrameAsync 		= kVDCompressOneFrameAsyncSelect,
	kSelectVDCompressDone 				= kVDCompressDoneSelect,
	kSelectVDReleaseCompressBuffer 		= kVDReleaseCompressBufferSelect,
	kSelectVDGetImageDescription 		= kVDGetImageDescriptionSelect,
	kSelectVDResetCompressSequence 		= kVDResetCompressSequenceSelect,
	kSelectVDSetCompressionOnOff 		= kVDSetCompressionOnOffSelect,
	kSelectVDGetCompressionTypes 		= kVDGetCompressionTypesSelect,
	kSelectVDSetTimeBase 				= kVDSetTimeBaseSelect,
	kSelectVDSetFrameRate 				= kVDSetFrameRateSelect,
	kSelectVDGetDataRate 				= kVDGetDataRateSelect,
	kSelectVDGetSoundInputDriver 		= kVDGetSoundInputDriverSelect,
	kSelectVDGetDMADepths 				= kVDGetDMADepthsSelect,
	kSelectVDGetPreferredTimeScale 		= kVDGetPreferredTimeScaleSelect,
	kSelectVDReleaseAsyncBuffers 		= kVDReleaseAsyncBuffersSelect,
	kSelectVDSetDataRate 				= kVDSetDataRateSelect,
	kSelectVDGetTimeCode 				= kVDGetTimeCodeSelect,
	kSelectVDUseSafeBuffers				= kVDUseSafeBuffersSelect
};
#endif /* OLDROUTINENAMES */

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#ifdef __cplusplus
}
#endif

#endif /* __QUICKTIMECOMPONENTS__ */


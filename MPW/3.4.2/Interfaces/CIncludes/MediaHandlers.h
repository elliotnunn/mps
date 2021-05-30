/*
 	File:		MediaHandlers.h
 
 	Contains:	QuickTime interfaces
 
 	Version:	Technology:	Technology:	QuickTime 2.5
 				Package:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/
#ifndef __MEDIAHANDLERS__
#define __MEDIAHANDLERS__

#ifndef __MEMORY__
#include <Memory.h>
#endif
#ifndef __IMAGECOMPRESSION__
#include <ImageCompression.h>
#endif
#ifndef __MOVIES__
#include <Movies.h>
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
	handlerHasSpatial			= 1 << 0,
	handlerCanClip				= 1 << 1,
	handlerCanMatte				= 1 << 2,
	handlerCanTransferMode		= 1 << 3,
	handlerNeedsBuffer			= 1 << 4,
	handlerNoIdle				= 1 << 5,
	handlerNoScheduler			= 1 << 6,
	handlerWantsTime			= 1 << 7,
	handlerCGrafPortOnly		= 1 << 8,
	handlerCanSend				= 1 << 9
};

/* media task flags */

enum {
	mMustDraw					= 1 << 3,
	mAtEnd						= 1 << 4,
	mPreflightDraw				= 1 << 5,
	mSyncDrawing				= 1 << 6
};

/* media task result flags */

enum {
	mDidDraw					= 1 << 0,
	mNeedsToDraw				= 1 << 2,
	mDrawAgain					= 1 << 3,
	mPartialDraw				= 1 << 4
};


enum {
	forceUpdateRedraw			= 1 << 0,
	forceUpdateNewBuffer		= 1 << 1
};

struct GetMovieCompleteParams {
	short 							version;
	Movie 							theMovie;
	Track 							theTrack;
	Media 							theMedia;
	TimeScale 						movieScale;
	TimeScale 						mediaScale;
	TimeValue 						movieDuration;
	TimeValue 						trackDuration;
	TimeValue 						mediaDuration;
	Fixed 							effectiveRate;
	TimeBase 						timeBase;
	short 							volume;
	Fixed 							width;
	Fixed 							height;
	MatrixRecord 					trackMovieMatrix;
	CGrafPtr 						moviePort;
	GDHandle 						movieGD;
	PixMapHandle 					trackMatte;
	QTAtomContainer 				inputMap;
};
typedef struct GetMovieCompleteParams GetMovieCompleteParams;


enum {
	kMediaVideoParamBrightness	= 1,
	kMediaVideoParamContrast	= 2,
	kMediaVideoParamHue			= 3,
	kMediaVideoParamSharpness	= 4,
	kMediaVideoParamSaturation	= 5,
	kMediaVideoParamBlackLevel	= 6,
	kMediaVideoParamWhiteLevel	= 7
};

typedef Handle *dataHandlePtr;
typedef dataHandlePtr *dataHandleHandle;
/***** These are the calls for dealing with the Generic media handler *****/
extern pascal ComponentResult MediaInitialize(MediaHandler mh, GetMovieCompleteParams *gmc)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0501, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetHandlerCapabilities(MediaHandler mh, long flags, long flagsMask)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0502, 0x7000, 0xA82A);

extern pascal ComponentResult MediaIdle(MediaHandler mh, TimeValue atMediaTime, long flagsIn, long *flagsOut, const TimeRecord *movieTime)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0503, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGetMediaInfo(MediaHandler mh, Handle h)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0504, 0x7000, 0xA82A);

extern pascal ComponentResult MediaPutMediaInfo(MediaHandler mh, Handle h)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0505, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetActive(MediaHandler mh, Boolean enableMedia)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0506, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetRate(MediaHandler mh, Fixed rate)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0507, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGGetStatus(MediaHandler mh, ComponentResult *statusErr)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0508, 0x7000, 0xA82A);

extern pascal ComponentResult MediaTrackEdited(MediaHandler mh)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0509, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetMediaTimeScale(MediaHandler mh, TimeScale newTimeScale)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x050A, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetMovieTimeScale(MediaHandler mh, TimeScale newTimeScale)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x050B, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetGWorld(MediaHandler mh, CGrafPtr aPort, GDHandle aGD)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x050C, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetDimensions(MediaHandler mh, Fixed width, Fixed height)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x050D, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetClip(MediaHandler mh, RgnHandle theClip)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x050E, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetMatrix(MediaHandler mh, MatrixRecord *trackMovieMatrix)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x050F, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGetTrackOpaque(MediaHandler mh, Boolean *trackIsOpaque)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0510, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetGraphicsMode(MediaHandler mh, long mode, const RGBColor *opColor)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0511, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGetGraphicsMode(MediaHandler mh, long *mode, RGBColor *opColor)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0512, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGSetVolume(MediaHandler mh, short volume)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0513, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetSoundBalance(MediaHandler mh, short balance)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0514, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGetSoundBalance(MediaHandler mh, short *balance)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0515, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGetNextBoundsChange(MediaHandler mh, TimeValue *when)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0516, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGetSrcRgn(MediaHandler mh, RgnHandle rgn, TimeValue atMediaTime)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0517, 0x7000, 0xA82A);

extern pascal ComponentResult MediaPreroll(MediaHandler mh, TimeValue time, Fixed rate)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0518, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSampleDescriptionChanged(MediaHandler mh, long index)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0519, 0x7000, 0xA82A);

extern pascal ComponentResult MediaHasCharacteristic(MediaHandler mh, OSType characteristic, Boolean *hasIt)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x051A, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGetOffscreenBufferSize(MediaHandler mh, Rect *bounds, short depth, CTabHandle ctab)
 FIVEWORDINLINE(0x2F3C, 0x000A, 0x051B, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetHints(MediaHandler mh, long hints)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x051C, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGetName(MediaHandler mh, Str255 name, long requestedLanguage, long *actualLanguage)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x051D, 0x7000, 0xA82A);

extern pascal ComponentResult MediaForceUpdate(MediaHandler mh, long forceUpdateFlags)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x051E, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGetDrawingRgn(MediaHandler mh, RgnHandle *partialRgn)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x051F, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGSetActiveSegment(MediaHandler mh, TimeValue activeStart, TimeValue activeDuration)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0520, 0x7000, 0xA82A);

extern pascal ComponentResult MediaInvalidateRegion(MediaHandler mh, RgnHandle invalRgn)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0521, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGetNextStepTime(MediaHandler mh, short flags, TimeValue mediaTimeIn, TimeValue *mediaTimeOut, Fixed rate)
 FIVEWORDINLINE(0x2F3C, 0x000E, 0x0522, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetNonPrimarySourceData(MediaHandler mh, long inputIndex, long dataDescriptionSeed, Handle dataDescription, void *data, long dataSize, ICMCompletionProcRecordPtr asyncCompletionProc, ProcPtr transferProc, void *refCon)
 FIVEWORDINLINE(0x2F3C, 0x0020, 0x0523, 0x7000, 0xA82A);

extern pascal ComponentResult MediaChangedNonPrimarySource(MediaHandler mh, long inputIndex)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0524, 0x7000, 0xA82A);

extern pascal ComponentResult MediaTrackReferencesChanged(MediaHandler mh)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0525, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGetSampleDataPointer(MediaHandler mh, long sampleNum, Ptr *dataPtr, long *dataSize, long *sampleDescIndex)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0526, 0x7000, 0xA82A);

extern pascal ComponentResult MediaReleaseSampleDataPointer(MediaHandler mh, long sampleNum)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0527, 0x7000, 0xA82A);

extern pascal ComponentResult MediaTrackPropertyAtomChanged(MediaHandler mh)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x0528, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetTrackInputMapReference(MediaHandler mh, QTAtomContainer inputMap)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0529, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetVideoParam(MediaHandler mh, long whichParam, unsigned short *value)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x052B, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGetVideoParam(MediaHandler mh, long whichParam, unsigned short *value)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x052C, 0x7000, 0xA82A);

extern pascal ComponentResult MediaCompare(MediaHandler mh, Boolean *isOK, Media srcMedia, ComponentInstance srcMediaComponent)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x052D, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGetClock(MediaHandler mh, ComponentInstance *clock)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x052E, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetSoundOutputComponent(MediaHandler mh, Component outputComponent)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x052F, 0x7000, 0xA82A);

extern pascal ComponentResult MediaGetSoundOutputComponent(MediaHandler mh, Component *outputComponent)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0530, 0x7000, 0xA82A);

extern pascal ComponentResult MediaSetSoundLocalizationData(MediaHandler mh, Handle data)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0531, 0x7000, 0xA82A);

extern pascal ComponentResult MediaFixSampleDescription(MediaHandler mh, long index, SampleDescriptionHandle desc)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0532, 0x7000, 0xA82A);


/* selectors for component calls */
enum {
	kMediaInitializeSelect							= 0x0501,
	kMediaSetHandlerCapabilitiesSelect				= 0x0502,
	kMediaIdleSelect								= 0x0503,
	kMediaGetMediaInfoSelect						= 0x0504,
	kMediaPutMediaInfoSelect						= 0x0505,
	kMediaSetActiveSelect							= 0x0506,
	kMediaSetRateSelect								= 0x0507,
	kMediaGGetStatusSelect							= 0x0508,
	kMediaTrackEditedSelect							= 0x0509,
	kMediaSetMediaTimeScaleSelect					= 0x050A,
	kMediaSetMovieTimeScaleSelect					= 0x050B,
	kMediaSetGWorldSelect							= 0x050C,
	kMediaSetDimensionsSelect						= 0x050D,
	kMediaSetClipSelect								= 0x050E,
	kMediaSetMatrixSelect							= 0x050F,
	kMediaGetTrackOpaqueSelect						= 0x0510,
	kMediaSetGraphicsModeSelect						= 0x0511,
	kMediaGetGraphicsModeSelect						= 0x0512,
	kMediaGSetVolumeSelect							= 0x0513,
	kMediaSetSoundBalanceSelect						= 0x0514,
	kMediaGetSoundBalanceSelect						= 0x0515,
	kMediaGetNextBoundsChangeSelect					= 0x0516,
	kMediaGetSrcRgnSelect							= 0x0517,
	kMediaPrerollSelect								= 0x0518,
	kMediaSampleDescriptionChangedSelect			= 0x0519,
	kMediaHasCharacteristicSelect					= 0x051A,
	kMediaGetOffscreenBufferSizeSelect				= 0x051B,
	kMediaSetHintsSelect							= 0x051C,
	kMediaGetNameSelect								= 0x051D,
	kMediaForceUpdateSelect							= 0x051E,
	kMediaGetDrawingRgnSelect						= 0x051F,
	kMediaGSetActiveSegmentSelect					= 0x0520,
	kMediaInvalidateRegionSelect					= 0x0521,
	kMediaGetNextStepTimeSelect						= 0x0522,
	kMediaSetNonPrimarySourceDataSelect				= 0x0523,
	kMediaChangedNonPrimarySourceSelect				= 0x0524,
	kMediaTrackReferencesChangedSelect				= 0x0525,
	kMediaGetSampleDataPointerSelect				= 0x0526,
	kMediaReleaseSampleDataPointerSelect			= 0x0527,
	kMediaTrackPropertyAtomChangedSelect			= 0x0528,
	kMediaSetTrackInputMapReferenceSelect			= 0x0529,
	kMediaSetVideoParamSelect						= 0x052B,
	kMediaGetVideoParamSelect						= 0x052C,
	kMediaCompareSelect								= 0x052D,
	kMediaGetClockSelect							= 0x052E,
	kMediaSetSoundOutputComponentSelect				= 0x052F,
	kMediaGetSoundOutputComponentSelect				= 0x0530,
	kMediaSetSoundLocalizationDataSelect			= 0x0531,
	kMediaFixSampleDescriptionSelect				= 0x0532
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

#endif /* __MEDIAHANDLERS__ */


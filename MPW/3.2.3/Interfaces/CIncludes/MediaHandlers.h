/************************************************************

Created: Tuesday, October 13, 1992
 MediaHandlers.h
 C Interface to the Macintosh Libraries


 Copyright Apple Computer, Inc. 1992
 All rights reserved

************************************************************/

#ifndef __MEDIAHANDLERS__
#define __MEDIAHANDLERS__

#include <Movies.h>

enum {
	handlerHasSpatial = 1<<0,
	handlerCanClip = 1<<1,
	handlerCanMatte = 1<<2,
	handlerCanTransferMode = 1<<3,
	handlerNeedsBuffer = 1<<4,
	handlerNoIdle = 1<<5,
	handlerNoScheduler = 1<<6,
	handlerWantsTime = 1<<7,
	handlerCGrafPortOnly = 1<<8
};

enum {
	mMustDraw = 1<<3,
	mAtEnd = 1<<4,
	mPreflightDraw = 1<<5
};
	
enum {
	mDidDraw = 1<<0,
	mNeedsToDraw = 1<<2
};

typedef struct {
	short version;
	Movie theMovie;
	Track theTrack;
	Media theMedia;
	TimeScale movieScale;
	TimeScale mediaScale;
	TimeValue movieDuration;
	TimeValue trackDuration;
	TimeValue mediaDuration;
	Fixed effectiveRate;
	TimeBase timeBase;
	short volume;
	Fixed width;
	Fixed height;
	MatrixRecord trackMovieMatrix;
	CGrafPtr moviePort;
	GDHandle movieGD;
	PixMapHandle trackMatte;
} GetMovieCompleteParams;

enum {
	kMediaInitializeSelect = 0x501,
	kMediaSetHandlerCapabilitiesSelect = 0x502,
	kMediaIdleSelect = 0x503,
	kMediaGetMediaInfoSelect = 0x504,
	kMediaPutMediaInfoSelect = 0x505,
	kMediaSetActiveSelect = 0x506,
	kMediaSetRateSelect = 0x507,
	kMediaGGetStatusSelect = 0x508,
	kMediaTrackEditedSelect = 0x509,
	kMediaSetMediaTimeScaleSelect = 0x50A,
	kMediaSetMovieTimeScaleSelect = 0x50B,
	kMediaSetGWorldSelect = 0x50C,
	kMediaSetDimensionsSelect = 0x50D,
	kMediaSetClipSelect = 0x50E,
	kMediaSetMatrixSelect = 0x50F,
	kMediaGetTrackOpaqueSelect = 0x510,
	kMediaSetGraphicsModeSelect = 0x511,
	kMediaGetGraphicsModeSelect = 0x512,
	kMediaGSetVolumeSelect = 0x513,
	kMediaSetSoundBalanceSelect = 0x514,
	kMediaGetSoundBalanceSelect = 0x515,
	kMediaGetNextBoundsChangeSelect = 0x516,
	kMediaGetSrcRgnSelect = 0x517,
	kMediaPrerollSelect = 0x518,
	kMediaSampleDescriptionChangedSelect = 0x519,
	kMediaHasCharacteristic = 0x51A
};

#ifdef __cplusplus
extern "C" {
#endif __cplusplus

pascal ComponentResult MediaInitialize (ComponentInstance ci, GetMovieCompleteParams *gmc) 
	= {0x2F3C,0x4,0x501,0x7000,0xA82A};
pascal ComponentResult MediaSetHandlerCapabilities (ComponentInstance ci, long flags, long flagsMask ) 
	= {0x2F3C,0x8,0x502,0x7000,0xA82A};
pascal ComponentResult MediaIdle (ComponentInstance ci, TimeValue atMediaTime, long flagsIn, long *flagsOut, const TimeRecord *movieTime) 
	= {0x2F3C,0x10,0x503,0x7000,0xA82A};
pascal ComponentResult MediaGetMediaInfo (ComponentInstance ci, Handle h ) 
	= {0x2F3C,0x4,0x504,0x7000,0xA82A};
pascal ComponentResult MediaPutMediaInfo (ComponentInstance ci, Handle h ) 
	= {0x2F3C,0x4,0x505,0x7000,0xA82A};
pascal ComponentResult MediaSetActive (ComponentInstance ci, Boolean enableMedia ) 
	= {0x2F3C,0x2,0x506,0x7000,0xA82A};
pascal ComponentResult MediaSetRate (ComponentInstance ci, Fixed rate ) 
	= {0x2F3C,0x4,0x507,0x7000,0xA82A};
pascal ComponentResult MediaGGetStatus (ComponentInstance ci, ComponentResult *statusErr ) 
	= {0x2F3C,0x4,0x508,0x7000,0xA82A};
pascal ComponentResult MediaTrackEdited (ComponentInstance ci ) 
	= {0x2F3C,0x0,0x509,0x7000,0xA82A};
pascal ComponentResult MediaSetMediaTimeScale (ComponentInstance ci, TimeScale newTimeScale ) 
	= {0x2F3C,0x4,0x50A,0x7000,0xA82A};
pascal ComponentResult MediaSetMovieTimeScale (ComponentInstance ci, TimeScale newTimeScale ) 
	= {0x2F3C,0x4,0x50B,0x7000,0xA82A};
pascal ComponentResult MediaSetGWorld (ComponentInstance ci, CGrafPtr aPort, GDHandle aGD) 
	= {0x2F3C,0x8,0x50C,0x7000,0xA82A};
pascal ComponentResult MediaSetDimensions (ComponentInstance ci, Fixed width, Fixed height) 
	= {0x2F3C,0x8,0x50D,0x7000,0xA82A};
pascal ComponentResult MediaSetClip (ComponentInstance ci, RgnHandle theClip) 
	= {0x2F3C,0x4,0x50E,0x7000,0xA82A};
pascal ComponentResult MediaSetMatrix (ComponentInstance ci, MatrixRecord *trackMovieMatrix) 
	= {0x2F3C,0x4,0x50F,0x7000,0xA82A};
pascal ComponentResult MediaGetTrackOpaque (ComponentInstance ci, Boolean *trackIsOpaque ) 
	= {0x2F3C,0x4,0x510,0x7000,0xA82A};
pascal ComponentResult MediaSetGraphicsMode (ComponentInstance ci, long mode, RGBColor *opColor ) 
	= {0x2F3C,0x8,0x511,0x7000,0xA82A};
pascal ComponentResult MediaGetGraphicsMode (ComponentInstance ci, long *mode, RGBColor *opColor ) 
	= {0x2F3C,0x8,0x512,0x7000,0xA82A};
pascal ComponentResult MediaGSetVolume (ComponentInstance ci, short volume ) 
	= {0x2F3C,0x2,0x513,0x7000,0xA82A};
pascal ComponentResult MediaSetSoundBalance (ComponentInstance ci, short balance) 
	= {0x2F3C,0x2,0x514,0x7000,0xA82A};
pascal ComponentResult MediaGetSoundBalance (ComponentInstance ci, short *balance ) 
	= {0x2F3C,0x4,0x515,0x7000,0xA82A};
pascal ComponentResult MediaGetNextBoundsChange (ComponentInstance ci, TimeValue *when ) 
	= {0x2F3C,0x4,0x516,0x7000,0xA82A};
pascal ComponentResult MediaGetSrcRgn (ComponentInstance ci, RgnHandle rgn, TimeValue atMediaTime ) 
	= {0x2F3C,0x8,0x517,0x7000,0xA82A};
pascal ComponentResult MediaPreroll (ComponentInstance ci, TimeValue time, Fixed rate ) 
	= {0x2F3C,0x8,0x518,0x7000,0xA82A};
pascal ComponentResult MediaSampleDescriptionChanged (ComponentInstance ci, long index )
	= {0x2F3C,0x4,0x519,0x7000,0xA82A};
pascal ComponentResult MediaHasCharacteristic (ComponentInstance ci, OSType characteristic, Boolean *hasIt )
	= {0x2F3C,0x8,0x51A,0x7000,0xA82A};


#ifdef __cplusplus
}
#endif __cplusplus

#endif __MEDIAHANDLERS__

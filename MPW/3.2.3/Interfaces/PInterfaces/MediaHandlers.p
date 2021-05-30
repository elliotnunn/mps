{************************************************************

Created: Thursday, August 20, 1992 at 12:09 AM
 MediaHandler.h
 C Interface to the Macintosh Libraries


 Copyright Apple Computer, Inc. 1991, 1992
 All rights reserved

************************************************************}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MediaHandlers;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingMediaHandlers}
{$SETC UsingMediaHandlers := 1}

{$I+}
{$SETC MediaHandlersIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingMovies}
{$I $$Shell(PInterfaces)Movies.p}
{$ENDC}

{$SETC UsingIncludes := MediaHandlersIncludes}

CONST
handlerHasSpatial = $1;
handlerCanClip = $2;
handlerCanMatte = $4;
handlerCanTransferMode = $8;
handlerNeedsBuffer = $10;
handlerNoIdle = $20;
handlerNoScheduler = $40;
handlerWantsTime = $80;
handlerCGrafPortOnly = $100;

mMustDraw = $8;
mAtEnd = $10;
mPreflightDraw = $20;

mDidDraw = $1;
mNeedsToDraw = $4;

TYPE

GetMovieCompleteParams = RECORD
	version : INTEGER;
	theMovie: Movie;
	theTrack: Track;
	theMedia: Media;
	movieScale: TimeScale;
	mediaScale: TimeScale;
	movieDuration: TimeValue;
	trackDuration: TimeValue;
	mediaDuration: TimeValue;
	effectiveRate: Fixed;
	timeBase:TimeBase;
	volume:INTEGER;
	width:Fixed;
	height:Fixed;
	trackMovieMatrix:MatrixRecord;
	moviePort:CGrafPtr;
	movieGD:GDHandle;
	trackMatte:PixMapHandle;
END;

CONST
kMediaInitializeSelect = $501;
kMediaSetHandlerCapabilitiesSelect = $502;
kMediaIdleSelect = $503;
kMediaGetMediaInfoSelect = $504;
kMediaPutMediaInfoSelect = $505;
kMediaSetActiveSelect = $506;
kMediaSetRateSelect = $507;
kMediaGGetStatusSelect = $508;
kMediaTrackEditedSelect = $509;
kMediaSetMediaTimeScaleSelect = $50A;
kMediaSetMovieTimeScaleSelect = $50B;
kMediaSetGWorldSelect = $50C;
kMediaSetDimensionsSelect = $50D;
kMediaSetClipSelect = $50E;
kMediaSetMatrixSelect = $50F;
kMediaGetTrackOpaqueSelect = $510;
kMediaSetGraphicsModeSelect = $511;
kMediaGetGraphicsModeSelect = $512;
kMediaGSetVolumeSelect = $513;
kMediaSetSoundBalanceSelect = $514;
kMediaGetSoundBalanceSelect = $515;
kMediaGetNextBoundsChangeSelect = $516;
kMediaGetSrcRgnSelect = $517;
kMediaPrerollSelect = $518;

FUNCTION MediaInitialize (ci:ComponentInstance; VAR gmc : GetMovieCompleteParams):ComponentResult; 
 INLINE $2F3C,$4,$501,$7000,$A82A;
FUNCTION MediaSetHandlerCapabilities (ci:ComponentInstance; flags:LONGINT; flagsMask:LONGINT ):ComponentResult; 
 INLINE $2F3C,$8,$502,$7000,$A82A;
FUNCTION MediaIdle (ci:ComponentInstance; atMediaTime:TimeValue; flagsIn:LONGINT ; VAR flagsOut:LONGINT; VAR movieTime:TimeRecord):ComponentResult; 
 INLINE $2F3C,$10,$503,$7000,$A82A;
FUNCTION MediaGetMediaInfo (ci:ComponentInstance; h:Handle):ComponentResult; 
 INLINE $2F3C,$4,$504,$7000,$A82A;
FUNCTION MediaPutMediaInfo (ci:ComponentInstance; h:Handle):ComponentResult; 
 INLINE $2F3C,$4,$505,$7000,$A82A;
FUNCTION MediaSetActive (ci:ComponentInstance ; enableMedia:BOOLEAN  ):ComponentResult; 
 INLINE $2F3C,$2,$506,$7000,$A82A;
FUNCTION MediaSetRate (ci:ComponentInstance; rate:Fixed  ):ComponentResult; 
 INLINE $2F3C,$4,$507,$7000,$A82A;
FUNCTION MediaGGetStatus (ci:ComponentInstance; VAR statusErr:ComponentResult ):ComponentResult; 
 INLINE $2F3C,$4,$508,$7000,$A82A;
FUNCTION MediaTrackEdited (ci:ComponentInstance):ComponentResult; 
 INLINE $2F3C,$0,$509,$7000,$A82A;
FUNCTION MediaSetMediaTimeScale (ci:ComponentInstance; newTimeScale:TimeScale  ):ComponentResult; 
 INLINE $2F3C,$4,$50A,$7000,$A82A;
FUNCTION MediaSetMovieTimeScale (ci:ComponentInstance ; newTimeScale:TimeScale  ):ComponentResult; 
 INLINE $2F3C,$4,$50B,$7000,$A82A;
FUNCTION MediaSetGWorld (ci:ComponentInstance; aPort:CGrafPtr; aGD:GDHandle ):ComponentResult;
 INLINE $2F3C,$8,$50C,$7000,$A82A;
FUNCTION MediaSetDimensions ( ci:ComponentInstance; width:Fixed; height:Fixed ) :ComponentResult;
 INLINE $2F3C,$8,$50D,$7000,$A82A;
FUNCTION MediaSetClip (ci:ComponentInstance;theClip:RgnHandle ):ComponentResult; 
 INLINE $2F3C,$4,$50E,$7000,$A82A;
FUNCTION MediaSetMatrix (ci:ComponentInstance; VAR trackMovieMatrix :MatrixRecord ) :ComponentResult;
 INLINE $2F3C,$4,$50F,$7000,$A82A;
FUNCTION MediaGetTrackOpaque (ci:ComponentInstance;VAR trackIsOpaque:BOOLEAN ):ComponentResult; 
 INLINE $2F3C,$4,$510,$7000,$A82A;
FUNCTION MediaSetGraphicsMode (ci:ComponentInstance ; mode:LONGINT ; VAR opColor:RGBColor ):ComponentResult; 
 INLINE $2F3C,$8,$511,$7000,$A82A;
FUNCTION MediaGetGraphicsMode (ci:ComponentInstance; VAR mode:LONGINT; VAR opColor:RGBColor ):ComponentResult; 
 INLINE $2F3C,$8,$512,$7000,$A82A;
FUNCTION MediaGSetVolume (ci:ComponentInstance;volume:INTEGER  ):ComponentResult; 
 INLINE $2F3C,$2,$513,$7000,$A82A;
FUNCTION MediaSetSoundBalance (ci:ComponentInstance; balance:INTEGER):ComponentResult; 
 INLINE $2F3C,$2,$514,$7000,$A82A;
FUNCTION MediaGetSoundBalance (ci:ComponentInstance; VAR balance:INTEGER ):ComponentResult; 
 INLINE $2F3C,$4,$515,$7000,$A82A;
FUNCTION MediaGetNextBoundsChange (ci:ComponentInstance; VAR when:TimeValue ):ComponentResult; 
 INLINE $2F3C,$4,$516,$7000,$A82A;
FUNCTION MediaGetSrcRgn (ci:ComponentInstance; rgn:RgnHandle; atMediaTime:TimeValue  ):ComponentResult; 
 INLINE $2F3C,$8,$517,$7000,$A82A;
FUNCTION MediaPreroll (ci:ComponentInstance;time: TimeValue;rate: Fixed  ):ComponentResult; 
 INLINE $2F3C,$8,$518,$7000,$A82A;
FUNCTION MediaSampleDescriptionChanged (ci:ComponentInstance; index:LONGINT ):ComponentResult;
 INLINE $2F3C,$4,$519,$7000,$A82A;
FUNCTION MediaHasCharacteristic (ci:ComponentInstance; characteristic:OSType; VAR hasIt:BOOLEAN ):ComponentResult;
 INLINE $2F3C,$8,$51A,$7000,$A82A;

{$ENDC} { UsingMediaHandlers }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

{
     File:       MediaHandlers.p
 
     Contains:   QuickTime Interfaces.
 
     Version:    Technology: QuickTime 5.0.1
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1990-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MediaHandlers;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MEDIAHANDLERS__}
{$SETC __MEDIAHANDLERS__ := 1}

{$I+}
{$SETC MediaHandlersIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __SOUND__}
{$I Sound.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	PrePrerollCompleteProcPtr = PROCEDURE(mh: MediaHandler; err: OSErr; refcon: UNIV Ptr);
{$ELSEC}
	PrePrerollCompleteProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	PrePrerollCompleteUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PrePrerollCompleteUPP = UniversalProcPtr;
{$ENDC}	

CONST
	handlerHasSpatial			= $01;
	handlerCanClip				= $02;
	handlerCanMatte				= $04;
	handlerCanTransferMode		= $08;
	handlerNeedsBuffer			= $10;
	handlerNoIdle				= $20;
	handlerNoScheduler			= $40;
	handlerWantsTime			= $80;
	handlerCGrafPortOnly		= $0100;
	handlerCanSend				= $0200;
	handlerCanHandleComplexMatrix = $0400;
	handlerWantsDestinationPixels = $0800;
	handlerCanSendImageData		= $1000;
	handlerCanPicSave			= $2000;

	{	 media task flags 	}
	mMustDraw					= $08;
	mAtEnd						= $10;
	mPreflightDraw				= $20;
	mSyncDrawing				= $40;
	mPrecompositeOnly			= $0200;
	mSoundOnly					= $0400;
	mDoIdleActionsBeforeDraws	= $0800;
	mDisableIdleActions			= $1000;

	{	 media task result flags 	}
	mDidDraw					= $01;
	mNeedsToDraw				= $04;
	mDrawAgain					= $08;
	mPartialDraw				= $10;
	mWantIdleActions			= $20;

	forceUpdateRedraw			= $01;
	forceUpdateNewBuffer		= $02;

	{	 media hit test flags 	}
	mHitTestBounds				= $00000001;					{     point must only be within targetRefCon's bounding box  }
	mHitTestImage				= $00000002;					{   point must be within the shape of the targetRefCon's image  }
	mHitTestInvisible			= $00000004;					{   invisible targetRefCon's may be hit tested  }
	mHitTestIsClick				= $00000008;					{   for codecs that want mouse events  }

	{	 media is opaque flags 	}
	mOpaque						= $00000001;
	mInvisible					= $00000002;


	{	 MediaSetPublicInfo/MediaGetPublicInfo selectors 	}
	kMediaQTIdleFrequencySelector = 'idfq';





TYPE
	GetMovieCompleteParamsPtr = ^GetMovieCompleteParams;
	GetMovieCompleteParams = RECORD
		version:				INTEGER;
		theMovie:				Movie;
		theTrack:				Track;
		theMedia:				Media;
		movieScale:				TimeScale;
		mediaScale:				TimeScale;
		movieDuration:			TimeValue;
		trackDuration:			TimeValue;
		mediaDuration:			TimeValue;
		effectiveRate:			Fixed;
		timeBase:				TimeBase;
		volume:					INTEGER;
		width:					Fixed;
		height:					Fixed;
		trackMovieMatrix:		MatrixRecord;
		moviePort:				CGrafPtr;
		movieGD:				GDHandle;
		trackMatte:				PixMapHandle;
		inputMap:				QTAtomContainer;
	END;


CONST
	kMediaVideoParamBrightness	= 1;
	kMediaVideoParamContrast	= 2;
	kMediaVideoParamHue			= 3;
	kMediaVideoParamSharpness	= 4;
	kMediaVideoParamSaturation	= 5;
	kMediaVideoParamBlackLevel	= 6;
	kMediaVideoParamWhiteLevel	= 7;

	{  These are for MediaGetInfo() and MediaSetInfo(). }
	kMHInfoEncodedFrameRate		= 'orat';						{  Parameter is a MHInfoEncodedFrameRateRecord*. }

	{  This holds the frame rate at which the track was encoded. }

TYPE
	MHInfoEncodedFrameRateRecordPtr = ^MHInfoEncodedFrameRateRecord;
	MHInfoEncodedFrameRateRecord = RECORD
		encodedFrameRate:		Fixed;
	END;

	dataHandlePtr						= ^Handle;
	dataHandleHandle					= ^dataHandlePtr;

	QTCustomActionTargetRecordPtr = ^QTCustomActionTargetRecord;
	QTCustomActionTargetRecord = RECORD
		movie:					Movie;
		doMCActionCallbackProc:	DoMCActionUPP;
		callBackRefcon:			LONGINT;
		track:					Track;
		trackObjectRefCon:		LONGINT;
		defaultTrack:			Track;
		defaultObjectRefCon:	LONGINT;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
	END;

	QTCustomActionTargetPtr				= ^QTCustomActionTargetRecord;
	MediaEQSpectrumBandsRecordPtr = ^MediaEQSpectrumBandsRecord;
	MediaEQSpectrumBandsRecord = RECORD
		count:					INTEGER;
		frequency:				UnsignedFixedPtr;						{  pointer to array of frequencies }
	END;

	{
	 *  CallComponentExecuteWiredAction()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
	 *    CarbonLib:        in CarbonLib 1.0.2 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 4.0 and later
	 	}
FUNCTION CallComponentExecuteWiredAction(ci: ComponentInstance; actionContainer: QTAtomContainer; actionAtom: QTAtom; target: QTCustomActionTargetPtr; event: QTEventRecordPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $FFF7, $7000, $A82A;
	{$ENDC}


{ MediaCallRange2 }
{ These are unique to each type of media handler }
{ They are also included in the public interfaces }


{**** These are the calls for dealing with the Generic media handler ****}
{
 *  MediaInitialize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaInitialize(mh: MediaHandler; VAR gmc: GetMovieCompleteParams): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0501, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetHandlerCapabilities()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetHandlerCapabilities(mh: MediaHandler; flags: LONGINT; flagsMask: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0502, $7000, $A82A;
	{$ENDC}

{
 *  MediaIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaIdle(mh: MediaHandler; atMediaTime: TimeValue; flagsIn: LONGINT; VAR flagsOut: LONGINT; {CONST}VAR movieTime: TimeRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0503, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetMediaInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetMediaInfo(mh: MediaHandler; h: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0504, $7000, $A82A;
	{$ENDC}

{
 *  MediaPutMediaInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaPutMediaInfo(mh: MediaHandler; h: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0505, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetActive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetActive(mh: MediaHandler; enableMedia: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0506, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetRate(mh: MediaHandler; rate: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0507, $7000, $A82A;
	{$ENDC}

{
 *  MediaGGetStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGGetStatus(mh: MediaHandler; VAR statusErr: ComponentResult): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0508, $7000, $A82A;
	{$ENDC}

{
 *  MediaTrackEdited()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaTrackEdited(mh: MediaHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0509, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetMediaTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetMediaTimeScale(mh: MediaHandler; newTimeScale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $050A, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetMovieTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetMovieTimeScale(mh: MediaHandler; newTimeScale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $050B, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetGWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetGWorld(mh: MediaHandler; aPort: CGrafPtr; aGD: GDHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $050C, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetDimensions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetDimensions(mh: MediaHandler; width: Fixed; height: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $050D, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetClip(mh: MediaHandler; theClip: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $050E, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetMatrix(mh: MediaHandler; VAR trackMovieMatrix: MatrixRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $050F, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetTrackOpaque()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetTrackOpaque(mh: MediaHandler; VAR trackIsOpaque: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0510, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetGraphicsMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetGraphicsMode(mh: MediaHandler; mode: LONGINT; {CONST}VAR opColor: RGBColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0511, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetGraphicsMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetGraphicsMode(mh: MediaHandler; VAR mode: LONGINT; VAR opColor: RGBColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0512, $7000, $A82A;
	{$ENDC}

{
 *  MediaGSetVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGSetVolume(mh: MediaHandler; volume: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0513, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetSoundBalance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetSoundBalance(mh: MediaHandler; balance: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0514, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetSoundBalance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetSoundBalance(mh: MediaHandler; VAR balance: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0515, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetNextBoundsChange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetNextBoundsChange(mh: MediaHandler; VAR when: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0516, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetSrcRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetSrcRgn(mh: MediaHandler; rgn: RgnHandle; atMediaTime: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0517, $7000, $A82A;
	{$ENDC}

{
 *  MediaPreroll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaPreroll(mh: MediaHandler; time: TimeValue; rate: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0518, $7000, $A82A;
	{$ENDC}

{
 *  MediaSampleDescriptionChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSampleDescriptionChanged(mh: MediaHandler; index: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0519, $7000, $A82A;
	{$ENDC}

{
 *  MediaHasCharacteristic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaHasCharacteristic(mh: MediaHandler; characteristic: OSType; VAR hasIt: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $051A, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetOffscreenBufferSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetOffscreenBufferSize(mh: MediaHandler; VAR bounds: Rect; depth: INTEGER; ctab: CTabHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $051B, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetHints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetHints(mh: MediaHandler; hints: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $051C, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetName(mh: MediaHandler; VAR name: Str255; requestedLanguage: LONGINT; VAR actualLanguage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $051D, $7000, $A82A;
	{$ENDC}

{
 *  MediaForceUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaForceUpdate(mh: MediaHandler; forceUpdateFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $051E, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetDrawingRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetDrawingRgn(mh: MediaHandler; VAR partialRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $051F, $7000, $A82A;
	{$ENDC}

{
 *  MediaGSetActiveSegment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGSetActiveSegment(mh: MediaHandler; activeStart: TimeValue; activeDuration: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0520, $7000, $A82A;
	{$ENDC}

{
 *  MediaInvalidateRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaInvalidateRegion(mh: MediaHandler; invalRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0521, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetNextStepTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetNextStepTime(mh: MediaHandler; flags: INTEGER; mediaTimeIn: TimeValue; VAR mediaTimeOut: TimeValue; rate: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000E, $0522, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetNonPrimarySourceData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetNonPrimarySourceData(mh: MediaHandler; inputIndex: LONGINT; dataDescriptionSeed: LONGINT; dataDescription: Handle; data: UNIV Ptr; dataSize: LONGINT; asyncCompletionProc: ICMCompletionProcRecordPtr; transferProc: ICMConvertDataFormatUPP; refCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0020, $0523, $7000, $A82A;
	{$ENDC}

{
 *  MediaChangedNonPrimarySource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaChangedNonPrimarySource(mh: MediaHandler; inputIndex: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0524, $7000, $A82A;
	{$ENDC}

{
 *  MediaTrackReferencesChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaTrackReferencesChanged(mh: MediaHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0525, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetSampleDataPointer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetSampleDataPointer(mh: MediaHandler; sampleNum: LONGINT; VAR dataPtr: Ptr; VAR dataSize: LONGINT; VAR sampleDescIndex: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0526, $7000, $A82A;
	{$ENDC}

{
 *  MediaReleaseSampleDataPointer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaReleaseSampleDataPointer(mh: MediaHandler; sampleNum: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0527, $7000, $A82A;
	{$ENDC}

{
 *  MediaTrackPropertyAtomChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaTrackPropertyAtomChanged(mh: MediaHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0528, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetTrackInputMapReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetTrackInputMapReference(mh: MediaHandler; inputMap: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0529, $7000, $A82A;
	{$ENDC}


{
 *  MediaSetVideoParam()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetVideoParam(mh: MediaHandler; whichParam: LONGINT; VAR value: UInt16): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $052B, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetVideoParam()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetVideoParam(mh: MediaHandler; whichParam: LONGINT; VAR value: UInt16): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $052C, $7000, $A82A;
	{$ENDC}

{
 *  MediaCompare()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaCompare(mh: MediaHandler; VAR isOK: BOOLEAN; srcMedia: Media; srcMediaComponent: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $052D, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetClock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetClock(mh: MediaHandler; VAR clock: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $052E, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetSoundOutputComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetSoundOutputComponent(mh: MediaHandler; outputComponent: Component): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $052F, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetSoundOutputComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetSoundOutputComponent(mh: MediaHandler; VAR outputComponent: Component): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0530, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetSoundLocalizationData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetSoundLocalizationData(mh: MediaHandler; data: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0531, $7000, $A82A;
	{$ENDC}




{
 *  MediaGetInvalidRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetInvalidRegion(mh: MediaHandler; rgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $053C, $7000, $A82A;
	{$ENDC}


{
 *  MediaSampleDescriptionB2N()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSampleDescriptionB2N(mh: MediaHandler; sampleDescriptionH: SampleDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $053E, $7000, $A82A;
	{$ENDC}

{
 *  MediaSampleDescriptionN2B()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSampleDescriptionN2B(mh: MediaHandler; sampleDescriptionH: SampleDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $053F, $7000, $A82A;
	{$ENDC}

{
 *  MediaQueueNonPrimarySourceData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaQueueNonPrimarySourceData(mh: MediaHandler; inputIndex: LONGINT; dataDescriptionSeed: LONGINT; dataDescription: Handle; data: UNIV Ptr; dataSize: LONGINT; asyncCompletionProc: ICMCompletionProcRecordPtr; {CONST}VAR frameTime: ICMFrameTimeRecord; transferProc: ICMConvertDataFormatUPP; refCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0024, $0540, $7000, $A82A;
	{$ENDC}

{
 *  MediaFlushNonPrimarySourceData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaFlushNonPrimarySourceData(mh: MediaHandler; inputIndex: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0541, $7000, $A82A;
	{$ENDC}


{
 *  MediaGetURLLink()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetURLLink(mh: MediaHandler; displayWhere: Point; VAR urlLink: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0543, $7000, $A82A;
	{$ENDC}


{
 *  MediaMakeMediaTimeTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaMakeMediaTimeTable(mh: MediaHandler; VAR offsets: LongIntPtr; startTime: TimeValue; endTime: TimeValue; timeIncrement: TimeValue; firstDataRefIndex: INTEGER; lastDataRefIndex: INTEGER; VAR retDataRefSkew: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0545, $7000, $A82A;
	{$ENDC}

{
 *  MediaHitTestForTargetRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaHitTestForTargetRefCon(mh: MediaHandler; flags: LONGINT; loc: Point; VAR targetRefCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0546, $7000, $A82A;
	{$ENDC}

{
 *  MediaHitTestTargetRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaHitTestTargetRefCon(mh: MediaHandler; targetRefCon: LONGINT; flags: LONGINT; loc: Point; VAR wasHit: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0547, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetActionsForQTEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaGetActionsForQTEvent(mh: MediaHandler; event: QTEventRecordPtr; targetRefCon: LONGINT; VAR container: QTAtomContainer; VAR atom: QTAtom): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0548, $7000, $A82A;
	{$ENDC}

{
 *  MediaDisposeTargetRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaDisposeTargetRefCon(mh: MediaHandler; targetRefCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0549, $7000, $A82A;
	{$ENDC}

{
 *  MediaTargetRefConsEqual()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaTargetRefConsEqual(mh: MediaHandler; firstRefCon: LONGINT; secondRefCon: LONGINT; VAR equal: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $054A, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetActionsCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaSetActionsCallback(mh: MediaHandler; actionsCallbackProc: ActionsUPP; refcon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $054B, $7000, $A82A;
	{$ENDC}

{
 *  MediaPrePrerollBegin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaPrePrerollBegin(mh: MediaHandler; time: TimeValue; rate: Fixed; completeProc: PrePrerollCompleteUPP; refcon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $054C, $7000, $A82A;
	{$ENDC}

{
 *  MediaPrePrerollCancel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaPrePrerollCancel(mh: MediaHandler; refcon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $054D, $7000, $A82A;
	{$ENDC}

{
 *  MediaEnterEmptyEdit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaEnterEmptyEdit(mh: MediaHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $054F, $7000, $A82A;
	{$ENDC}

{
 *  MediaCurrentMediaQueuedData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MediaCurrentMediaQueuedData(mh: MediaHandler; VAR milliSecs: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0550, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetEffectiveVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaGetEffectiveVolume(mh: MediaHandler; VAR volume: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0551, $7000, $A82A;
	{$ENDC}

{
 *  MediaResolveTargetRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaResolveTargetRefCon(mh: MediaHandler; container: QTAtomContainer; atom: QTAtom; VAR targetRefCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0552, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetSoundLevelMeteringEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaGetSoundLevelMeteringEnabled(mh: MediaHandler; VAR enabled: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0553, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetSoundLevelMeteringEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaSetSoundLevelMeteringEnabled(mh: MediaHandler; enable: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0554, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetSoundLevelMeterInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaGetSoundLevelMeterInfo(mh: MediaHandler; levelInfo: LevelMeterInfoPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0555, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetEffectiveSoundBalance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaGetEffectiveSoundBalance(mh: MediaHandler; VAR balance: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0556, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetScreenLock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaSetScreenLock(mh: MediaHandler; lockIt: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0557, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetDoMCActionCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaSetDoMCActionCallback(mh: MediaHandler; doMCActionCallbackProc: DoMCActionUPP; refcon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0558, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetErrorString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaGetErrorString(mh: MediaHandler; theError: ComponentResult; VAR errorString: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0559, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetSoundEqualizerBands()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaGetSoundEqualizerBands(mh: MediaHandler; spectrumInfo: MediaEQSpectrumBandsRecordPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $055A, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetSoundEqualizerBands()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaSetSoundEqualizerBands(mh: MediaHandler; spectrumInfo: MediaEQSpectrumBandsRecordPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $055B, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetSoundEqualizerBandLevels()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaGetSoundEqualizerBandLevels(mh: MediaHandler; VAR bandLevels: UInt8): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $055C, $7000, $A82A;
	{$ENDC}

{
 *  MediaDoIdleActions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaDoIdleActions(mh: MediaHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $055D, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetSoundBassAndTreble()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaSetSoundBassAndTreble(mh: MediaHandler; bass: INTEGER; treble: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $055E, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetSoundBassAndTreble()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaGetSoundBassAndTreble(mh: MediaHandler; VAR bass: INTEGER; VAR treble: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $055F, $7000, $A82A;
	{$ENDC}

{
 *  MediaTimeBaseChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MediaTimeBaseChanged(mh: MediaHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0560, $7000, $A82A;
	{$ENDC}

{
 *  MediaMCIsPlayerEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION MediaMCIsPlayerEvent(mh: MediaHandler; {CONST}VAR e: EventRecord; VAR handledIt: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0561, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetMediaLoadState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION MediaGetMediaLoadState(mh: MediaHandler; VAR mediaLoadState: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0562, $7000, $A82A;
	{$ENDC}

{
 *  MediaVideoOutputChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION MediaVideoOutputChanged(mh: MediaHandler; vout: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0563, $7000, $A82A;
	{$ENDC}

{
 *  MediaEmptySampleCache()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION MediaEmptySampleCache(mh: MediaHandler; sampleNum: LONGINT; sampleCount: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0564, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetPublicInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION MediaGetPublicInfo(mh: MediaHandler; infoSelector: OSType; infoDataPtr: UNIV Ptr; VAR ioDataSize: Size): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0565, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetPublicInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION MediaSetPublicInfo(mh: MediaHandler; infoSelector: OSType; infoDataPtr: UNIV Ptr; dataSize: Size): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0566, $7000, $A82A;
	{$ENDC}

{
 *  MediaGetUserPreferredCodecs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION MediaGetUserPreferredCodecs(mh: MediaHandler; VAR userPreferredCodecs: CodecComponentHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0567, $7000, $A82A;
	{$ENDC}

{
 *  MediaSetUserPreferredCodecs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION MediaSetUserPreferredCodecs(mh: MediaHandler; userPreferredCodecs: CodecComponentHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0568, $7000, $A82A;
	{$ENDC}




CONST
	uppPrePrerollCompleteProcInfo = $00000EC0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewPrePrerollCompleteUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewPrePrerollCompleteUPP(userRoutine: PrePrerollCompleteProcPtr): PrePrerollCompleteUPP; { old name was NewPrePrerollCompleteProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposePrePrerollCompleteUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposePrePrerollCompleteUPP(userUPP: PrePrerollCompleteUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokePrePrerollCompleteUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokePrePrerollCompleteUPP(mh: MediaHandler; err: OSErr; refcon: UNIV Ptr; userRoutine: PrePrerollCompleteUPP); { old name was CallPrePrerollCompleteProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MediaHandlersIncludes}

{$ENDC} {__MEDIAHANDLERS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

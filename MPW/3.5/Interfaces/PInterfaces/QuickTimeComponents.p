{
     File:       QuickTimeComponents.p
 
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
 UNIT QuickTimeComponents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QUICKTIMECOMPONENTS__}
{$SETC __QUICKTIMECOMPONENTS__ := 1}

{$I+}
{$SETC QuickTimeComponentsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __VIDEO__}
{$I Video.p}
{$ENDC}
{$IFC UNDEFINED __SOUND__}
{$I Sound.p}
{$ENDC}
{$IFC UNDEFINED __IMAGECOMPRESSION__}
{$I ImageCompression.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}
{$IFC UNDEFINED __QUICKTIMEMUSIC__}
{$I QuickTimeMusic.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	clockComponentType			= 'clok';
	systemTickClock				= 'tick';						{  subtype: 60ths since boot    }
	systemSecondClock			= 'seco';						{  subtype: seconds since 1904        }
	systemMillisecondClock		= 'mill';						{  subtype: 1000ths since boot        }
	systemMicrosecondClock		= 'micr';						{  subtype: 1000000ths since boot  }

	kClockRateIsLinear			= 1;
	kClockImplementsCallBacks	= 2;
	kClockCanHandleIntermittentSound = 4;						{  sound clocks only  }

	{	* These are Clock procedures *	}
	{
	 *  ClockGetTime()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION ClockGetTime(aClock: ComponentInstance; VAR out: TimeRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}


{
 *  ClockNewCallBack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION ClockNewCallBack(aClock: ComponentInstance; tb: TimeBase; callBackType: INTEGER): QTCallBack;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0002, $7000, $A82A;
	{$ENDC}

{
 *  ClockDisposeCallBack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION ClockDisposeCallBack(aClock: ComponentInstance; cb: QTCallBack): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}

{
 *  ClockCallMeWhen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION ClockCallMeWhen(aClock: ComponentInstance; cb: QTCallBack; param1: LONGINT; param2: LONGINT; param3: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0004, $7000, $A82A;
	{$ENDC}

{
 *  ClockCancelCallBack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION ClockCancelCallBack(aClock: ComponentInstance; cb: QTCallBack): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}

{
 *  ClockRateChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION ClockRateChanged(aClock: ComponentInstance; cb: QTCallBack): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}

{
 *  ClockTimeChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION ClockTimeChanged(aClock: ComponentInstance; cb: QTCallBack): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}

{
 *  ClockSetTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION ClockSetTimeBase(aClock: ComponentInstance; tb: TimeBase): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0008, $7000, $A82A;
	{$ENDC}

{
 *  ClockStartStopChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION ClockStartStopChanged(aClock: ComponentInstance; cb: QTCallBack; startChanged: BOOLEAN; stopChanged: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0009, $7000, $A82A;
	{$ENDC}

{
 *  ClockGetRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION ClockGetRate(aClock: ComponentInstance; VAR rate: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000A, $7000, $A82A;
	{$ENDC}





CONST
	StandardCompressionType		= 'scdi';
	StandardCompressionSubType	= 'imag';
	StandardCompressionSubTypeSound = 'soun';



TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	SCModalFilterProcPtr = FUNCTION(theDialog: DialogRef; VAR theEvent: EventRecord; VAR itemHit: INTEGER; refcon: LONGINT): BOOLEAN;
{$ELSEC}
	SCModalFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SCModalHookProcPtr = FUNCTION(theDialog: DialogRef; itemHit: INTEGER; params: UNIV Ptr; refcon: LONGINT): INTEGER;
{$ELSEC}
	SCModalHookProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	SCModalFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SCModalFilterUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	SCModalHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SCModalHookUPP = UniversalProcPtr;
{$ENDC}	
	{   Preference flags. }

CONST
	scListEveryCodec			= $00000002;
	scAllowZeroFrameRate		= $00000004;
	scAllowZeroKeyFrameRate		= $00000008;
	scShowBestDepth				= $00000010;
	scUseMovableModal			= $00000020;
	scDisableFrameRateItem		= $00000040;
	scShowDataRateAsKilobits	= $00000080;


	{   Possible test flags for setting test image. }
	scPreferCropping			= $01;
	scPreferScaling				= $02;
	scPreferScalingAndCropping	= $03;
	scDontDetermineSettingsFromTestImage = $04;


	{   Dimensions of the image preview box. }
	scTestImageWidth			= 80;
	scTestImageHeight			= 80;

	{   Possible items returned by hookProc. }
	scOKItem					= 1;
	scCancelItem				= 2;
	scCustomItem				= 3;

	{   Result returned when user cancelled. }
	scUserCancelled				= 1;



	{   Get/SetInfo structures. }


TYPE
	SCSpatialSettingsPtr = ^SCSpatialSettings;
	SCSpatialSettings = RECORD
		codecType:				CodecType;
		codec:					CodecComponent;
		depth:					INTEGER;
		spatialQuality:			CodecQ;
	END;

	SCTemporalSettingsPtr = ^SCTemporalSettings;
	SCTemporalSettings = RECORD
		temporalQuality:		CodecQ;
		frameRate:				Fixed;
		keyFrameRate:			LONGINT;
	END;

	SCDataRateSettingsPtr = ^SCDataRateSettings;
	SCDataRateSettings = RECORD
		dataRate:				LONGINT;
		frameDuration:			LONGINT;
		minSpatialQuality:		CodecQ;
		minTemporalQuality:		CodecQ;
	END;

	SCExtendedProcsPtr = ^SCExtendedProcs;
	SCExtendedProcs = RECORD
		filterProc:				SCModalFilterUPP;
		hookProc:				SCModalHookUPP;
		refcon:					LONGINT;
		customName:				Str31;
	END;

	{   Get/SetInfo selectors }

CONST
	scSpatialSettingsType		= 'sptl';						{  pointer to SCSpatialSettings struct }
	scTemporalSettingsType		= 'tprl';						{  pointer to SCTemporalSettings struct }
	scDataRateSettingsType		= 'drat';						{  pointer to SCDataRateSettings struct }
	scColorTableType			= 'clut';						{  pointer to CTabHandle }
	scProgressProcType			= 'prog';						{  pointer to ProgressRecord struct }
	scExtendedProcsType			= 'xprc';						{  pointer to SCExtendedProcs struct }
	scPreferenceFlagsType		= 'pref';						{  pointer to long }
	scSettingsStateType			= 'ssta';						{  pointer to Handle }
	scSequenceIDType			= 'sequ';						{  pointer to ImageSequence }
	scWindowPositionType		= 'wndw';						{  pointer to Point }
	scCodecFlagsType			= 'cflg';						{  pointer to CodecFlags }
	scCodecSettingsType			= 'cdec';						{  pointer to Handle }
	scForceKeyValueType			= 'ksim';						{  pointer to long }
	scSoundSampleRateType		= 'ssrt';						{  pointer to UnsignedFixed }
	scSoundSampleSizeType		= 'ssss';						{  pointer to short }
	scSoundChannelCountType		= 'sscc';						{  pointer to short }
	scSoundCompressionType		= 'ssct';						{  pointer to OSType }
	scCompressionListType		= 'ctyl';						{  pointer to OSType Handle }
	scCodecManufacturerType		= 'cmfr';						{  pointer to OSType }

	{   scTypeNotFoundErr returned by Get/SetInfo when type cannot be found. }



TYPE
	SCParamsPtr = ^SCParams;
	SCParams = RECORD
		flags:					LONGINT;
		theCodecType:			CodecType;
		theCodec:				CodecComponent;
		spatialQuality:			CodecQ;
		temporalQuality:		CodecQ;
		depth:					INTEGER;
		frameRate:				Fixed;
		keyFrameRate:			LONGINT;
		reserved1:				LONGINT;
		reserved2:				LONGINT;
	END;


CONST
	scGetCompression			= 1;
	scShowMotionSettings		= $00000001;
	scSettingsChangedItem		= -1;

	scCompressFlagIgnoreIdenticalFrames = 1;

	{  QTAtomTypes for atoms found in settings atom containers }
	kQTSettingsVideo			= 'vide';						{  Container for video/image compression related atoms (Get/SetInfo selectors) }
	kQTSettingsSound			= 'soun';						{  Container for sound compression related atoms (Get/SetInfo selectors) }
	kQTSettingsComponentVersion	= 'vers';						{  . Version of component that wrote settings (QTSettingsVersionAtomRecord) }

	{  Format of 'vers' atom found in settings atom containers }

TYPE
	QTSettingsVersionAtomRecordPtr = ^QTSettingsVersionAtomRecord;
	QTSettingsVersionAtomRecord = RECORD
		componentVersion:		LONGINT;								{  standard compression component version }
		flags:					INTEGER;								{  low bit is 1 if little endian platform, 0 if big endian platform }
		reserved:				INTEGER;								{  should be 0 }
	END;

	{	* These are Progress procedures *	}
	{
	 *  SCGetCompressionExtended()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION SCGetCompressionExtended(ci: ComponentInstance; VAR params: SCParams; where: Point; filterProc: SCModalFilterUPP; hookProc: SCModalHookUPP; refcon: LONGINT; customName: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0001, $7000, $A82A;
	{$ENDC}

{
 *  SCPositionRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCPositionRect(ci: ComponentInstance; VAR rp: Rect; VAR where: Point): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0002, $7000, $A82A;
	{$ENDC}

{
 *  SCPositionDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCPositionDialog(ci: ComponentInstance; id: INTEGER; VAR where: Point): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0003, $7000, $A82A;
	{$ENDC}

{
 *  SCSetTestImagePictHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCSetTestImagePictHandle(ci: ComponentInstance; testPict: PicHandle; VAR testRect: Rect; testFlags: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0004, $7000, $A82A;
	{$ENDC}

{
 *  SCSetTestImagePictFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCSetTestImagePictFile(ci: ComponentInstance; testFileRef: INTEGER; VAR testRect: Rect; testFlags: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0005, $7000, $A82A;
	{$ENDC}

{
 *  SCSetTestImagePixMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCSetTestImagePixMap(ci: ComponentInstance; testPixMap: PixMapHandle; VAR testRect: Rect; testFlags: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0006, $7000, $A82A;
	{$ENDC}

{
 *  SCGetBestDeviceRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCGetBestDeviceRect(ci: ComponentInstance; VAR r: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}


{
 *  SCRequestImageSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCRequestImageSettings(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000A, $7000, $A82A;
	{$ENDC}

{
 *  SCCompressImage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCCompressImage(ci: ComponentInstance; src: PixMapHandle; {CONST}VAR srcRect: Rect; VAR desc: ImageDescriptionHandle; VAR data: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000B, $7000, $A82A;
	{$ENDC}

{
 *  SCCompressPicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCCompressPicture(ci: ComponentInstance; srcPicture: PicHandle; dstPicture: PicHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000C, $7000, $A82A;
	{$ENDC}

{
 *  SCCompressPictureFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCCompressPictureFile(ci: ComponentInstance; srcRefNum: INTEGER; dstRefNum: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}

{
 *  SCRequestSequenceSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCRequestSequenceSettings(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000E, $7000, $A82A;
	{$ENDC}

{
 *  SCCompressSequenceBegin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCCompressSequenceBegin(ci: ComponentInstance; src: PixMapHandle; {CONST}VAR srcRect: Rect; VAR desc: ImageDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000F, $7000, $A82A;
	{$ENDC}

{
 *  SCCompressSequenceFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCCompressSequenceFrame(ci: ComponentInstance; src: PixMapHandle; {CONST}VAR srcRect: Rect; VAR data: Handle; VAR dataSize: LONGINT; VAR notSyncFlag: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0010, $7000, $A82A;
	{$ENDC}

{
 *  SCCompressSequenceEnd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCCompressSequenceEnd(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0011, $7000, $A82A;
	{$ENDC}

{
 *  SCDefaultPictHandleSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCDefaultPictHandleSettings(ci: ComponentInstance; srcPicture: PicHandle; motion: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0012, $7000, $A82A;
	{$ENDC}

{
 *  SCDefaultPictFileSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCDefaultPictFileSettings(ci: ComponentInstance; srcRef: INTEGER; motion: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0013, $7000, $A82A;
	{$ENDC}

{
 *  SCDefaultPixMapSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCDefaultPixMapSettings(ci: ComponentInstance; src: PixMapHandle; motion: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0014, $7000, $A82A;
	{$ENDC}

{
 *  SCGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCGetInfo(ci: ComponentInstance; infoType: OSType; info: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0015, $7000, $A82A;
	{$ENDC}

{
 *  SCSetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCSetInfo(ci: ComponentInstance; infoType: OSType; info: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0016, $7000, $A82A;
	{$ENDC}

{
 *  SCNewGWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCNewGWorld(ci: ComponentInstance; VAR gwp: GWorldPtr; VAR rp: Rect; flags: GWorldFlags): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0017, $7000, $A82A;
	{$ENDC}

{
 *  SCSetCompressFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCSetCompressFlags(ci: ComponentInstance; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}

{
 *  SCGetCompressFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCGetCompressFlags(ci: ComponentInstance; VAR flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0019, $7000, $A82A;
	{$ENDC}

{
 *  SCGetSettingsAsText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCGetSettingsAsText(ci: ComponentInstance; VAR text: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001A, $7000, $A82A;
	{$ENDC}

{
 *  SCGetSettingsAsAtomContainer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCGetSettingsAsAtomContainer(ci: ComponentInstance; VAR settings: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001B, $7000, $A82A;
	{$ENDC}

{
 *  SCSetSettingsFromAtomContainer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SCSetSettingsFromAtomContainer(ci: ComponentInstance; settings: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001C, $7000, $A82A;
	{$ENDC}

{ Note: if you're using SCCompressSequenceFrameAsync with a scForceKeyValue setting, you must call SCAsyncIdle occasionally at main task time. }
{
 *  SCCompressSequenceFrameAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION SCCompressSequenceFrameAsync(ci: ComponentInstance; src: PixMapHandle; {CONST}VAR srcRect: Rect; VAR data: Handle; VAR dataSize: LONGINT; VAR notSyncFlag: INTEGER; asyncCompletionProc: ICMCompletionProcRecordPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $001D, $7000, $A82A;
	{$ENDC}

{
 *  SCAsyncIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION SCAsyncIdle(ci: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $001E, $7000, $A82A;
	{$ENDC}





CONST
	TweenComponentType			= 'twen';


TYPE
	TweenerComponent					= ComponentInstance;
	{
	 *  TweenerInitialize()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION TweenerInitialize(tc: TweenerComponent; container: QTAtomContainer; tweenAtom: QTAtom; dataAtom: QTAtom): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0001, $7000, $A82A;
	{$ENDC}

{
 *  TweenerDoTween()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TweenerDoTween(tc: TweenerComponent; VAR tr: TweenRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0002, $7000, $A82A;
	{$ENDC}

{
 *  TweenerReset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TweenerReset(tc: TweenerComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0003, $7000, $A82A;
	{$ENDC}




CONST
	TCSourceRefNameType			= 'name';

	tcDropFrame					= $01;
	tc24HourMax					= $02;
	tcNegTimesOK				= $04;
	tcCounter					= $08;


TYPE
	TimeCodeDefPtr = ^TimeCodeDef;
	TimeCodeDef = RECORD
		flags:					LONGINT;								{  drop-frame, etc. }
		fTimeScale:				TimeScale;								{  time scale of frameDuration (eg. 2997) }
		frameDuration:			TimeValue;								{  duration of each frame (eg. 100) }
		numFrames:				SInt8;									{  frames/sec for timecode (eg. 30) OR frames/tick for counter mode }
		padding:				SInt8;									{  unused padding byte }
	END;


CONST
	tctNegFlag					= $80;							{  negative bit is in minutes }


TYPE
	TimeCodeTimePtr = ^TimeCodeTime;
	TimeCodeTime = RECORD
		hours:					SInt8;
		minutes:				SInt8;
		seconds:				SInt8;
		frames:					SInt8;
	END;

	TimeCodeCounterPtr = ^TimeCodeCounter;
	TimeCodeCounter = RECORD
		counter:				LONGINT;
	END;

	TimeCodeRecordPtr = ^TimeCodeRecord;
	TimeCodeRecord = RECORD
		CASE INTEGER OF
		0: (
			t:					TimeCodeTime;
			);
		1: (
			c:					TimeCodeCounter;
			);
	END;

	TimeCodeDescriptionPtr = ^TimeCodeDescription;
	TimeCodeDescription = RECORD
		descSize:				LONGINT;								{  standard sample description header }
		dataFormat:				LONGINT;
		resvd1:					LONGINT;
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
		flags:					LONGINT;								{  timecode specific stuff }
		timeCodeDef:			TimeCodeDef;
		srcRef:					ARRAY [0..0] OF LONGINT;
	END;

	TimeCodeDescriptionHandle			= ^TimeCodeDescriptionPtr;

CONST
	tcdfShowTimeCode			= $01;



TYPE
	TCTextOptionsPtr = ^TCTextOptions;
	TCTextOptions = RECORD
		txFont:					INTEGER;
		txFace:					INTEGER;
		txSize:					INTEGER;
		pad:					INTEGER;								{  let's make it longword aligned - thanks..  }
		foreColor:				RGBColor;
		backColor:				RGBColor;
	END;

	{
	 *  TCGetCurrentTimeCode()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION TCGetCurrentTimeCode(mh: MediaHandler; VAR frameNum: LONGINT; VAR tcdef: TimeCodeDef; VAR tcrec: TimeCodeRecord; VAR srcRefH: UserData): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0101, $7000, $A82A;
	{$ENDC}

{
 *  TCGetTimeCodeAtTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TCGetTimeCodeAtTime(mh: MediaHandler; mediaTime: TimeValue; VAR frameNum: LONGINT; VAR tcdef: TimeCodeDef; VAR tcdata: TimeCodeRecord; VAR srcRefH: UserData): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0102, $7000, $A82A;
	{$ENDC}

{
 *  TCTimeCodeToString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TCTimeCodeToString(mh: MediaHandler; VAR tcdef: TimeCodeDef; VAR tcrec: TimeCodeRecord; tcStr: StringPtr): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0103, $7000, $A82A;
	{$ENDC}

{
 *  TCTimeCodeToFrameNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TCTimeCodeToFrameNumber(mh: MediaHandler; VAR tcdef: TimeCodeDef; VAR tcrec: TimeCodeRecord; VAR frameNumber: LONGINT): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0104, $7000, $A82A;
	{$ENDC}

{
 *  TCFrameNumberToTimeCode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TCFrameNumberToTimeCode(mh: MediaHandler; frameNumber: LONGINT; VAR tcdef: TimeCodeDef; VAR tcrec: TimeCodeRecord): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0105, $7000, $A82A;
	{$ENDC}

{
 *  TCGetSourceRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TCGetSourceRef(mh: MediaHandler; tcdH: TimeCodeDescriptionHandle; VAR srefH: UserData): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0106, $7000, $A82A;
	{$ENDC}

{
 *  TCSetSourceRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TCSetSourceRef(mh: MediaHandler; tcdH: TimeCodeDescriptionHandle; srefH: UserData): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0107, $7000, $A82A;
	{$ENDC}

{
 *  TCSetTimeCodeFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TCSetTimeCodeFlags(mh: MediaHandler; flags: LONGINT; flagsMask: LONGINT): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0108, $7000, $A82A;
	{$ENDC}

{
 *  TCGetTimeCodeFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TCGetTimeCodeFlags(mh: MediaHandler; VAR flags: LONGINT): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0109, $7000, $A82A;
	{$ENDC}

{
 *  TCSetDisplayOptions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TCSetDisplayOptions(mh: MediaHandler; textOptions: TCTextOptionsPtr): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010A, $7000, $A82A;
	{$ENDC}

{
 *  TCGetDisplayOptions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TCGetDisplayOptions(mh: MediaHandler; textOptions: TCTextOptionsPtr): HandlerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010B, $7000, $A82A;
	{$ENDC}




TYPE
	MovieImportComponent				= ComponentInstance;
	MovieExportComponent				= ComponentInstance;

CONST
	MovieImportType				= 'eat ';
	MovieExportType				= 'spit';

	canMovieImportHandles		= $01;
	canMovieImportFiles			= $02;
	hasMovieImportUserInterface	= $04;
	canMovieExportHandles		= $08;
	canMovieExportFiles			= $10;
	hasMovieExportUserInterface	= $20;
	movieImporterIsXMLBased		= $20;
	dontAutoFileMovieImport		= $40;
	canMovieExportAuxDataHandle	= $80;
	canMovieImportValidateHandles = $0100;
	canMovieImportValidateFile	= $0200;
	dontRegisterWithEasyOpen	= $0400;
	canMovieImportInPlace		= $0800;
	movieImportSubTypeIsFileExtension = $1000;
	canMovieImportPartial		= $2000;
	hasMovieImportMIMEList		= $4000;
	canMovieImportAvoidBlocking	= $8000;
	canMovieExportFromProcedures = $8000;
	canMovieExportValidateMovie	= $00010000;
	movieExportNeedsResourceFork = $00020000;
	canMovieImportDataReferences = $00040000;
	movieExportMustGetSourceMediaType = $00080000;
	canMovieImportWithIdle		= $00100000;
	canMovieImportValidateDataReferences = $00200000;
	reservedForUseByGraphicsImporters = $00800000;

	movieImportCreateTrack		= 1;
	movieImportInParallel		= 2;
	movieImportMustUseTrack		= 4;
	movieImportWithIdle			= 16;

	movieImportResultUsedMultipleTracks = 8;
	movieImportResultNeedIdles	= 32;
	movieImportResultComplete	= 64;

	kMovieExportTextOnly		= 0;
	kMovieExportAbsoluteTime	= 1;
	kMovieExportRelativeTime	= 2;

	kMIDIImportSilenceBefore	= $01;
	kMIDIImportSilenceAfter		= $02;
	kMIDIImport20Playable		= $04;
	kMIDIImportWantLyrics		= $08;


	kQTMediaConfigResourceType	= 'mcfg';
	kQTMediaConfigResourceVersion = 2;
	kQTMediaGroupResourceType	= 'mgrp';
	kQTMediaGroupResourceVersion = 1;


	kQTMediaMIMEInfoHasChanged	= $00000002;					{  the MIME type(s) is(are) new or has changed since the last time }
																{   someone asked about it }
	kQTMediaFileInfoHasChanged	= $00000004;					{  the file extension(s) is(are) new or has changed since the last time }
																{   anyone asked about it }
	kQTMediaConfigCanUseApp		= $00040000;					{  this MIME type can be configured to use app }
	kQTMediaConfigCanUsePlugin	= $00080000;					{  this MIME type can be configured to use plug-in }
	kQTMediaConfigUNUSED		= $00100000;					{  currently unused }
	kQTMediaConfigBinaryFile	= $00800000;					{  file should be transfered in binary mode }
	kQTMediaConfigTextFile		= 0;							{  not a bit, defined for clarity }
	kQTMediaConfigMacintoshFile	= $01000000;					{  file's resource fork is significant }
	kQTMediaConfigAssociateByDefault = $08000000;				{  take this file association by default }
	kQTMediaConfigUseAppByDefault = $10000000;					{  use the app by default for this MIME type }
	kQTMediaConfigUsePluginByDefault = $20000000;				{  use the plug-in by default for this MIME type }
	kQTMediaConfigDefaultsMask	= $30000000;
	kQTMediaConfigDefaultsShift	= 12;							{  ((flags & kQTMediaConfigDefaultsMask) >> kQTMediaConfigDefaultsShift) to get default setting }


	{  mime type group constants for groupID field of 'mcfg' resource }
	kQTMediaConfigStreamGroupID	= 'strm';
	kQTMediaConfigInteractiveGroupID = 'intr';
	kQTMediaConfigVideoGroupID	= 'eyes';
	kQTMediaConfigAudioGroupID	= 'ears';
	kQTMediaConfigMPEGGroupID	= 'mpeg';
	kQTMediaConfigMP3GroupID	= 'mp3 ';
	kQTMediaConfigImageGroupID	= 'ogle';
	kQTMediaConfigMiscGroupID	= 'misc';

	{  file type group constants for groupID field of 'mcfg' resource }
	kQTMediaInfoNetGroup		= 'net ';
	kQTMediaInfoWinGroup		= 'win ';
	kQTMediaInfoMacGroup		= 'mac ';
	kQTMediaInfoMiscGroup		= $3F3F3F3F;					{  '????' }



	kMimeInfoMimeTypeTag		= 'mime';
	kMimeInfoFileExtensionTag	= 'ext ';
	kMimeInfoDescriptionTag		= 'desc';
	kMimeInfoGroupTag			= 'grop';
	kMimeInfoDoNotOverrideExistingFileTypeAssociation = 'nofa';

	kQTFileTypeAIFF				= 'AIFF';
	kQTFileTypeAIFC				= 'AIFC';
	kQTFileTypeDVC				= 'dvc!';
	kQTFileTypeMIDI				= 'Midi';
	kQTFileTypePicture			= 'PICT';
	kQTFileTypeMovie			= 'MooV';
	kQTFileTypeText				= 'TEXT';
	kQTFileTypeWave				= 'WAVE';
	kQTFileTypeSystemSevenSound	= 'sfil';
	kQTFileTypeMuLaw			= 'ULAW';
	kQTFileTypeAVI				= 'VfW ';
	kQTFileTypeSoundDesignerII	= 'Sd2f';
	kQTFileTypeAudioCDTrack		= 'trak';
	kQTFileTypePICS				= 'PICS';
	kQTFileTypeGIF				= 'GIFf';
	kQTFileTypePNG				= 'PNGf';
	kQTFileTypeTIFF				= 'TIFF';
	kQTFileTypePhotoShop		= '8BPS';
	kQTFileTypeSGIImage			= '.SGI';
	kQTFileTypeBMP				= 'BMPf';
	kQTFileTypeJPEG				= 'JPEG';
	kQTFileTypeJFIF				= 'JPEG';
	kQTFileTypeMacPaint			= 'PNTG';
	kQTFileTypeTargaImage		= 'TPIC';
	kQTFileTypeQuickDrawGXPicture = 'qdgx';
	kQTFileTypeQuickTimeImage	= 'qtif';
	kQTFileType3DMF				= '3DMF';
	kQTFileTypeFLC				= 'FLC ';
	kQTFileTypeFlash			= 'SWFL';
	kQTFileTypeFlashPix			= 'FPix';

	{  QTAtomTypes for atoms in import/export settings containers }
	kQTSettingsDVExportNTSC		= 'dvcv';						{  True is export as NTSC, false is export as PAL. (Boolean) }
	kQTSettingsDVExportLockedAudio = 'lock';					{  True if audio locked to video. (Boolean) }
	kQTSettingsEffect			= 'effe';						{  Parent atom whose contents are atoms of an effects description }
	kQTSettingsGraphicsFileImportSequence = 'sequ';				{  Parent atom of graphic file movie import component }
	kQTSettingsGraphicsFileImportSequenceEnabled = 'enab';		{  . If true, import numbered image sequence (Boolean) }
	kQTSettingsMovieExportEnableVideo = 'envi';					{  Enable exporting of video track (Boolean) }
	kQTSettingsMovieExportEnableSound = 'enso';					{  Enable exporting of sound track (Boolean) }
	kQTSettingsMovieExportSaveOptions = 'save';					{  Parent atom of save options }
	kQTSettingsMovieExportSaveForInternet = 'fast';				{  . Save for Internet }
	kQTSettingsMovieExportSaveCompressedMovie = 'cmpm';			{  . Save compressed movie resource }
	kQTSettingsMIDI				= 'MIDI';						{  MIDI import related container }
	kQTSettingsMIDISettingFlags	= 'sttg';						{  . MIDI import settings (UInt32) }
	kQTSettingsText				= 'text';						{  Text related container }
	kQTSettingsTextDescription	= 'desc';						{  . Text import settings (TextDescription record) }
	kQTSettingsTextSize			= 'size';						{  . Width/height to create during import (FixedPoint) }
	kQTSettingsTextSettingFlags	= 'sttg';						{  . Text export settings (UInt32) }
	kQTSettingsTextTimeFraction	= 'timf';						{  . Movie time fraction for export (UInt32) }
	kQTSettingsTime				= 'time';						{  Time related container }
	kQTSettingsTimeDuration		= 'dura';						{  . Time related container }
	kQTSettingsAudioCDTrack		= 'trak';						{  Audio CD track related container }
	kQTSettingsAudioCDTrackRateShift = 'rshf';					{  . Rate shift to be performed (SInt16) }





TYPE
	MovieExportGetDataParamsPtr = ^MovieExportGetDataParams;
	MovieExportGetDataParams = RECORD
		recordSize:				LONGINT;
		trackID:				LONGINT;
		sourceTimeScale:		TimeScale;
		requestedTime:			TimeValue;
		actualTime:				TimeValue;
		dataPtr:				Ptr;
		dataSize:				LONGINT;
		desc:					SampleDescriptionHandle;
		descType:				OSType;
		descSeed:				LONGINT;
		requestedSampleCount:	LONGINT;
		actualSampleCount:		LONGINT;
		durationPerSample:		TimeValue;
		sampleFlags:			LONGINT;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	MovieExportGetDataProcPtr = FUNCTION(refCon: UNIV Ptr; VAR params: MovieExportGetDataParams): OSErr;
{$ELSEC}
	MovieExportGetDataProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MovieExportGetPropertyProcPtr = FUNCTION(refcon: UNIV Ptr; trackID: LONGINT; propertyType: OSType; propertyValue: UNIV Ptr): OSErr;
{$ELSEC}
	MovieExportGetPropertyProcPtr = ProcPtr;
{$ENDC}


CONST
	kQTPresetsListResourceType	= 'stg#';
	kQTPresetsPlatformListResourceType = 'stgp';

	kQTPresetInfoIsDivider		= 1;


TYPE
	QTPresetInfoPtr = ^QTPresetInfo;
	QTPresetInfo = RECORD
		presetKey:				OSType;									{  unique key for this preset in presetsArray  }
		presetFlags:			UInt32;									{  flags about this preset  }
		settingsResourceType:	OSType;									{  resource type of settings resource  }
		settingsResourceID:		SInt16;									{  resource id of settings resource  }
		padding1:				SInt16;
		nameStringListID:		SInt16;									{  name string list resource id  }
		nameStringIndex:		SInt16;									{  name string index  }
		infoStringListID:		SInt16;									{  info string list resource id  }
		infoStringIndex:		SInt16;									{  info string index  }
	END;

	QTPresetListRecordPtr = ^QTPresetListRecord;
	QTPresetListRecord = RECORD
		flags:					UInt32;									{  flags for whole list  }
		count:					UInt32;									{  number of elements in presetsArray  }
		reserved:				UInt32;
		presetsArray:			ARRAY [0..0] OF QTPresetInfo;			{  info about each preset  }
	END;


CONST
	kQTMovieExportSourceInfoResourceType = 'src#';
	kQTMovieExportSourceInfoIsMediaType = $00000001;
	kQTMovieExportSourceInfoIsMediaCharacteristic = $00000002;
	kQTMovieExportSourceInfoIsSourceType = $00000004;


TYPE
	QTMovieExportSourceInfoPtr = ^QTMovieExportSourceInfo;
	QTMovieExportSourceInfo = RECORD
		mediaType:				OSType;									{  Media type of source  }
		minCount:				UInt16;									{  min number of sources of this kind required, zero if none required  }
		maxCount:				UInt16;									{  max number of sources of this kind allowed, -1 if unlimited allowed  }
		flags:					LONGINT;								{  reserved for flags  }
	END;

	QTMovieExportSourceRecordPtr = ^QTMovieExportSourceRecord;
	QTMovieExportSourceRecord = RECORD
		count:					LONGINT;
		reserved:				LONGINT;
		sourceArray:			ARRAY [0..0] OF QTMovieExportSourceInfo;
	END;

{$IFC OPAQUE_UPP_TYPES}
	MovieExportGetDataUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MovieExportGetDataUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MovieExportGetPropertyUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MovieExportGetPropertyUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppSCModalFilterProcInfo = $00003FD0;
	uppSCModalHookProcInfo = $00003EE0;
	uppMovieExportGetDataProcInfo = $000003E0;
	uppMovieExportGetPropertyProcInfo = $00003FE0;
	{
	 *  NewSCModalFilterUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewSCModalFilterUPP(userRoutine: SCModalFilterProcPtr): SCModalFilterUPP; { old name was NewSCModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewSCModalHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewSCModalHookUPP(userRoutine: SCModalHookProcPtr): SCModalHookUPP; { old name was NewSCModalHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMovieExportGetDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewMovieExportGetDataUPP(userRoutine: MovieExportGetDataProcPtr): MovieExportGetDataUPP; { old name was NewMovieExportGetDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMovieExportGetPropertyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewMovieExportGetPropertyUPP(userRoutine: MovieExportGetPropertyProcPtr): MovieExportGetPropertyUPP; { old name was NewMovieExportGetPropertyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeSCModalFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSCModalFilterUPP(userUPP: SCModalFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeSCModalHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSCModalHookUPP(userUPP: SCModalHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMovieExportGetDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMovieExportGetDataUPP(userUPP: MovieExportGetDataUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMovieExportGetPropertyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMovieExportGetPropertyUPP(userUPP: MovieExportGetPropertyUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeSCModalFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSCModalFilterUPP(theDialog: DialogRef; VAR theEvent: EventRecord; VAR itemHit: INTEGER; refcon: LONGINT; userRoutine: SCModalFilterUPP): BOOLEAN; { old name was CallSCModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeSCModalHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSCModalHookUPP(theDialog: DialogRef; itemHit: INTEGER; params: UNIV Ptr; refcon: LONGINT; userRoutine: SCModalHookUPP): INTEGER; { old name was CallSCModalHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMovieExportGetDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeMovieExportGetDataUPP(refCon: UNIV Ptr; VAR params: MovieExportGetDataParams; userRoutine: MovieExportGetDataUPP): OSErr; { old name was CallMovieExportGetDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMovieExportGetPropertyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeMovieExportGetPropertyUPP(refcon: UNIV Ptr; trackID: LONGINT; propertyType: OSType; propertyValue: UNIV Ptr; userRoutine: MovieExportGetPropertyUPP): OSErr; { old name was CallMovieExportGetPropertyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  MovieImportHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportHandle(ci: MovieImportComponent; dataH: Handle; theMovie: Movie; targetTrack: Track; VAR usedTrack: Track; atTime: TimeValue; VAR addedDuration: TimeValue; inFlags: LONGINT; VAR outFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0020, $0001, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportFile(ci: MovieImportComponent; {CONST}VAR theFile: FSSpec; theMovie: Movie; targetTrack: Track; VAR usedTrack: Track; atTime: TimeValue; VAR addedDuration: TimeValue; inFlags: LONGINT; VAR outFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0020, $0002, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportSetSampleDuration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportSetSampleDuration(ci: MovieImportComponent; duration: TimeValue; scale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0003, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportSetSampleDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportSetSampleDescription(ci: MovieImportComponent; desc: SampleDescriptionHandle; mediaType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0004, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportSetMediaFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportSetMediaFile(ci: MovieImportComponent; alias: AliasHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportSetDimensions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportSetDimensions(ci: MovieImportComponent; width: Fixed; height: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0006, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportSetChunkSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportSetChunkSize(ci: MovieImportComponent; chunkSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportSetProgressProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportSetProgressProc(ci: MovieImportComponent; proc: MovieProgressUPP; refcon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0008, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportSetAuxiliaryData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportSetAuxiliaryData(ci: MovieImportComponent; data: Handle; handleType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0009, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportSetFromScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportSetFromScrap(ci: MovieImportComponent; fromScrap: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $000A, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportDoUserDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportDoUserDialog(ci: MovieImportComponent; {CONST}VAR theFile: FSSpec; theData: Handle; VAR canceled: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000B, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportSetDuration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportSetDuration(ci: MovieImportComponent; duration: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportGetAuxiliaryDataType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportGetAuxiliaryDataType(ci: MovieImportComponent; VAR auxType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportValidate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportValidate(ci: MovieImportComponent; {CONST}VAR theFile: FSSpec; theData: Handle; VAR valid: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000E, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportGetFileType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportGetFileType(ci: MovieImportComponent; VAR fileType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000F, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportDataRef(ci: MovieImportComponent; dataRef: Handle; dataRefType: OSType; theMovie: Movie; targetTrack: Track; VAR usedTrack: Track; atTime: TimeValue; VAR addedDuration: TimeValue; inFlags: LONGINT; VAR outFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0024, $0010, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportGetSampleDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportGetSampleDescription(ci: MovieImportComponent; VAR desc: SampleDescriptionHandle; VAR mediaType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0011, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportGetMIMETypeList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportGetMIMETypeList(ci: MovieImportComponent; VAR mimeInfo: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportSetOffsetAndLimit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportSetOffsetAndLimit(ci: MovieImportComponent; offset: UInt32; limit: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0013, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportGetSettingsAsAtomContainer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportGetSettingsAsAtomContainer(ci: MovieImportComponent; VAR settings: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0014, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportSetSettingsFromAtomContainer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieImportSetSettingsFromAtomContainer(ci: MovieImportComponent; settings: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0015, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportSetOffsetAndLimit64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MovieImportSetOffsetAndLimit64(ci: MovieImportComponent; {CONST}VAR offset: wide; {CONST}VAR limit: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0016, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MovieImportIdle(ci: MovieImportComponent; inFlags: LONGINT; VAR outFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0017, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportValidateDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MovieImportValidateDataRef(ci: MovieImportComponent; dataRef: Handle; dataRefType: OSType; VAR valid: UInt8): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0018, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportGetLoadState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION MovieImportGetLoadState(ci: MovieImportComponent; VAR importerLoadState: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0019, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportGetMaxLoadedTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION MovieImportGetMaxLoadedTime(ci: MovieImportComponent; VAR time: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001A, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportEstimateCompletionTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION MovieImportEstimateCompletionTime(ci: MovieImportComponent; VAR time: TimeRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001B, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportSetDontBlock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION MovieImportSetDontBlock(ci: MovieImportComponent; dontBlock: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $001C, $7000, $A82A;
	{$ENDC}

{
 *  MovieImportGetDontBlock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION MovieImportGetDontBlock(ci: MovieImportComponent; VAR willBlock: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001D, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportToHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportToHandle(ci: MovieExportComponent; dataH: Handle; theMovie: Movie; onlyThisTrack: Track; startTime: TimeValue; duration: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0080, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportToFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportToFile(ci: MovieExportComponent; {CONST}VAR theFile: FSSpec; theMovie: Movie; onlyThisTrack: Track; startTime: TimeValue; duration: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0081, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportGetAuxiliaryData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportGetAuxiliaryData(ci: MovieExportComponent; dataH: Handle; VAR handleType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0083, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportSetProgressProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportSetProgressProc(ci: MovieExportComponent; proc: MovieProgressUPP; refcon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0084, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportSetSampleDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportSetSampleDescription(ci: MovieExportComponent; desc: SampleDescriptionHandle; mediaType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0085, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportDoUserDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportDoUserDialog(ci: MovieExportComponent; theMovie: Movie; onlyThisTrack: Track; startTime: TimeValue; duration: TimeValue; VAR canceled: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0086, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportGetCreatorType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportGetCreatorType(ci: MovieExportComponent; VAR creator: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0087, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportToDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportToDataRef(ci: MovieExportComponent; dataRef: Handle; dataRefType: OSType; theMovie: Movie; onlyThisTrack: Track; startTime: TimeValue; duration: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0088, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportFromProceduresToDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportFromProceduresToDataRef(ci: MovieExportComponent; dataRef: Handle; dataRefType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0089, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportAddDataSource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportAddDataSource(ci: MovieExportComponent; trackType: OSType; scale: TimeScale; VAR trackID: LONGINT; getPropertyProc: MovieExportGetPropertyUPP; getDataProc: MovieExportGetDataUPP; refCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $008A, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportValidate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportValidate(ci: MovieExportComponent; theMovie: Movie; onlyThisTrack: Track; VAR valid: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $008B, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportGetSettingsAsAtomContainer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportGetSettingsAsAtomContainer(ci: MovieExportComponent; VAR settings: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008C, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportSetSettingsFromAtomContainer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportSetSettingsFromAtomContainer(ci: MovieExportComponent; settings: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008D, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportGetFileNameExtension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportGetFileNameExtension(ci: MovieExportComponent; VAR extension: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008E, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportGetShortFileTypeString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportGetShortFileTypeString(ci: MovieExportComponent; VAR typeString: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008F, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportGetSourceMediaType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportGetSourceMediaType(ci: MovieExportComponent; VAR mediaType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0090, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportSetGetMoviePropertyProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MovieExportSetGetMoviePropertyProc(ci: MovieExportComponent; getPropertyProc: MovieExportGetPropertyUPP; refCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0091, $7000, $A82A;
	{$ENDC}

{  Text Export Display Info data structure }

TYPE
	TextDisplayDataPtr = ^TextDisplayData;
	TextDisplayData = RECORD
		displayFlags:			LONGINT;
		textJustification:		LONGINT;
		bgColor:				RGBColor;
		textBox:				Rect;
		beginHilite:			INTEGER;
		endHilite:				INTEGER;
		hiliteColor:			RGBColor;
		doHiliteColor:			BOOLEAN;
		filler:					SInt8;
		scrollDelayDur:			TimeValue;
		dropShadowOffset:		Point;
		dropShadowTransparency:	INTEGER;
	END;

	TextExportComponent					= ComponentInstance;
	GraphicImageMovieImportComponent	= ComponentInstance;
	{
	 *  TextExportGetDisplayData()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION TextExportGetDisplayData(ci: TextExportComponent; VAR textDisplay: TextDisplayData): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0100, $7000, $A82A;
	{$ENDC}

{
 *  TextExportGetTimeFraction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TextExportGetTimeFraction(ci: TextExportComponent; VAR movieTimeFraction: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}

{
 *  TextExportSetTimeFraction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TextExportSetTimeFraction(ci: TextExportComponent; movieTimeFraction: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}

{
 *  TextExportGetSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TextExportGetSettings(ci: TextExportComponent; VAR setting: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}

{
 *  TextExportSetSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TextExportSetSettings(ci: TextExportComponent; setting: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0104, $7000, $A82A;
	{$ENDC}


{
 *  MIDIImportGetSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MIDIImportGetSettings(ci: TextExportComponent; VAR setting: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0100, $7000, $A82A;
	{$ENDC}

{
 *  MIDIImportSetSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MIDIImportSetSettings(ci: TextExportComponent; setting: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportNewGetDataAndPropertiesProcs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportNewGetDataAndPropertiesProcs(ci: MovieExportComponent; trackType: OSType; VAR scale: TimeScale; theMovie: Movie; theTrack: Track; startTime: TimeValue; duration: TimeValue; VAR getPropertyProc: MovieExportGetPropertyUPP; VAR getDataProc: MovieExportGetDataUPP; VAR refCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0024, $0100, $7000, $A82A;
	{$ENDC}

{
 *  MovieExportDisposeGetDataAndPropertiesProcs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieExportDisposeGetDataAndPropertiesProcs(ci: MovieExportComponent; getPropertyProc: MovieExportGetPropertyUPP; getDataProc: MovieExportGetDataUPP; refCon: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0101, $7000, $A82A;
	{$ENDC}


CONST
	movieExportUseConfiguredSettings = 'ucfg';					{  pointer to Boolean }
	movieExportWidth			= 'wdth';						{  pointer to Fixed }
	movieExportHeight			= 'hegt';						{  pointer to Fixed }
	movieExportDuration			= 'dura';						{  pointer to TimeRecord }
	movieExportVideoFilter		= 'iflt';						{  pointer to QTAtomContainer }
	movieExportTimeScale		= 'tmsc';						{  pointer to TimeScale }

	{
	 *  GraphicsImageImportSetSequenceEnabled()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION GraphicsImageImportSetSequenceEnabled(ci: GraphicImageMovieImportComponent; enable: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0100, $7000, $A82A;
	{$ENDC}

{
 *  GraphicsImageImportGetSequenceEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GraphicsImageImportGetSequenceEnabled(ci: GraphicImageMovieImportComponent; VAR enable: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}












{**************

    File Preview Components

**************}

TYPE
	pnotComponent						= ComponentInstance;

CONST
	pnotComponentWantsEvents	= 1;
	pnotComponentNeedsNoCache	= 2;

	ShowFilePreviewComponentType = 'pnot';
	CreateFilePreviewComponentType = 'pmak';

	{
	 *  PreviewShowData()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION PreviewShowData(p: pnotComponent; dataType: OSType; data: Handle; {CONST}VAR inHere: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0001, $7000, $A82A;
	{$ENDC}

{
 *  PreviewMakePreview()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION PreviewMakePreview(p: pnotComponent; VAR previewType: OSType; VAR previewResult: Handle; {CONST}VAR sourceFile: FSSpec; progress: ICMProgressProcRecordPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0002, $7000, $A82A;
	{$ENDC}

{
 *  PreviewMakePreviewReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION PreviewMakePreviewReference(p: pnotComponent; VAR previewType: OSType; VAR resID: INTEGER; {CONST}VAR sourceFile: FSSpec): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0003, $7000, $A82A;
	{$ENDC}

{
 *  PreviewEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION PreviewEvent(p: pnotComponent; VAR e: EventRecord; VAR handledEvent: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0004, $7000, $A82A;
	{$ENDC}




TYPE
	DataCompressorComponent				= ComponentInstance;
	DataDecompressorComponent			= ComponentInstance;
	DataCodecComponent					= ComponentInstance;

CONST
	DataCompressorComponentType	= 'dcom';
	DataDecompressorComponentType = 'ddec';
	AppleDataCompressorSubType	= 'adec';
	zlibDataCompressorSubType	= 'zlib';


	{	* These are DataCodec procedures *	}
	{
	 *  DataCodecDecompress()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION DataCodecDecompress(dc: DataCodecComponent; srcData: UNIV Ptr; srcSize: UInt32; dstData: UNIV Ptr; dstBufferSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0001, $7000, $A82A;
	{$ENDC}

{
 *  DataCodecGetCompressBufferSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataCodecGetCompressBufferSize(dc: DataCodecComponent; srcSize: UInt32; VAR dstSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0002, $7000, $A82A;
	{$ENDC}

{
 *  DataCodecCompress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataCodecCompress(dc: DataCodecComponent; srcData: UNIV Ptr; srcSize: UInt32; dstData: UNIV Ptr; dstBufferSize: UInt32; VAR actualDstSize: UInt32; VAR decompressSlop: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0003, $7000, $A82A;
	{$ENDC}

{
 *  DataCodecBeginInterruptSafe()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataCodecBeginInterruptSafe(dc: DataCodecComponent; maxSrcSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}

{
 *  DataCodecEndInterruptSafe()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataCodecEndInterruptSafe(dc: DataCodecComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0005, $7000, $A82A;
	{$ENDC}

{
 *  DataCodecDecompressPartial()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataCodecDecompressPartial(dc: DataCodecComponent; VAR next_in: UNIV Ptr; VAR avail_in: UInt32; VAR total_in: UInt32; VAR next_out: UNIV Ptr; VAR avail_out: UInt32; VAR total_out: UInt32; VAR didFinish: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001C, $0006, $7000, $A82A;
	{$ENDC}

{
 *  DataCodecCompressPartial()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataCodecCompressPartial(dc: DataCodecComponent; VAR next_in: UNIV Ptr; VAR avail_in: UInt32; VAR total_in: UInt32; VAR next_out: UNIV Ptr; VAR avail_out: UInt32; VAR total_out: UInt32; tryToFinish: BOOLEAN; VAR didFinish: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001E, $0007, $7000, $A82A;
	{$ENDC}





TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	DataHCompletionProcPtr = PROCEDURE(request: Ptr; refcon: LONGINT; err: OSErr);
{$ELSEC}
	DataHCompletionProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DataHCompletionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DataHCompletionUPP = UniversalProcPtr;
{$ENDC}	


CONST
	kDataHCanRead				= $00000001;
	kDataHSpecialRead			= $00000002;
	kDataHSpecialReadFile		= $00000004;
	kDataHCanWrite				= $00000008;
	kDataHSpecialWrite			= $10;
	kDataHSpecialWriteFile		= $20;
	kDataHCanStreamingWrite		= $40;
	kDataHMustCheckDataRef		= $80;

	{  Data reference records for specific data ref types }

TYPE
	HandleDataRefRecordPtr = ^HandleDataRefRecord;
	HandleDataRefRecord = RECORD
		dataHndl:				Handle;
	END;

	HandleDataRefPtr					= ^HandleDataRefRecord;
	HandleDataRef						= ^HandleDataRefPtr;
	PointerDataRefRecordPtr = ^PointerDataRefRecord;
	PointerDataRefRecord = RECORD
		data:					Ptr;
		dataLength:				Size;
	END;

	PointerDataRefPtr					= ^PointerDataRefRecord;
	PointerDataRef						= ^PointerDataRefPtr;
	{  Data reference extensions }

CONST
	kDataRefExtensionChokeSpeed	= 'chok';
	kDataRefExtensionFileName	= 'fnam';
	kDataRefExtensionMIMEType	= 'mime';
	kDataRefExtensionMacOSFileType = 'ftyp';
	kDataRefExtensionInitializationData = 'data';

	kDataHChokeToMovieDataRate	= $01;							{  param is 0 }
	kDataHChokeToParam			= $02;							{  param is bytes per second }


TYPE
	DataHChokeAtomRecordPtr = ^DataHChokeAtomRecord;
	DataHChokeAtomRecord = RECORD
		flags:					LONGINT;								{  one of kDataHChokeTo constants }
		param:					LONGINT;
	END;


	DataHVolumeListRecordPtr = ^DataHVolumeListRecord;
	DataHVolumeListRecord = RECORD
		vRefNum:				INTEGER;
		flags:					LONGINT;
	END;

	DataHVolumeListPtr					= ^DataHVolumeListRecord;
	DataHVolumeList						= ^DataHVolumeListPtr;

CONST
	kDataHExtendedSchedule		= 'xtnd';


TYPE
	DataHScheduleRecordPtr = ^DataHScheduleRecord;
	DataHScheduleRecord = RECORD
		timeNeededBy:			TimeRecord;
		extendedID:				LONGINT;								{  always is kDataHExtendedSchedule }
		extendedVers:			LONGINT;								{  always set to 0 }
		priority:				Fixed;									{  100.0 or more means must have. lower numbers… }
	END;

	DataHSchedulePtr					= ^DataHScheduleRecord;
	{  Flags for DataHGetInfoFlags }

CONST
	kDataHInfoFlagNeverStreams	= $01;							{  set if this data handler doesn't stream }
	kDataHInfoFlagCanUpdateDataRefs = $02;						{  set if this data handler might update data reference }
	kDataHInfoFlagNeedsNetworkBandwidth = $04;					{  set if this data handler may need to occupy the network }


	{  Types for DataHGetFileTypeOrdering }
	kDataHFileTypeMacOSFileType	= 'ftyp';
	kDataHFileTypeExtension		= 'fext';
	kDataHFileTypeMIME			= 'mime';


TYPE
	DataHFileTypeOrderingPtr			= ^OSType;
	DataHFileTypeOrderingHandle			= ^DataHFileTypeOrderingPtr;

	{
	 *  DataHGetData()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION DataHGetData(dh: DataHandler; h: Handle; hOffset: LONGINT; offset: LONGINT; size: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0002, $7000, $A82A;
	{$ENDC}

{
 *  DataHPutData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHPutData(dh: DataHandler; h: Handle; hOffset: LONGINT; VAR offset: LONGINT; size: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0003, $7000, $A82A;
	{$ENDC}

{
 *  DataHFlushData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHFlushData(dh: DataHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0004, $7000, $A82A;
	{$ENDC}

{
 *  DataHOpenForWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHOpenForWrite(dh: DataHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0005, $7000, $A82A;
	{$ENDC}

{
 *  DataHCloseForWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHCloseForWrite(dh: DataHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0006, $7000, $A82A;
	{$ENDC}


{
 *  DataHOpenForRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHOpenForRead(dh: DataHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0008, $7000, $A82A;
	{$ENDC}

{
 *  DataHCloseForRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHCloseForRead(dh: DataHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0009, $7000, $A82A;
	{$ENDC}

{
 *  DataHSetDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHSetDataRef(dh: DataHandler; dataRef: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000A, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHGetDataRef(dh: DataHandler; VAR dataRef: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000B, $7000, $A82A;
	{$ENDC}

{
 *  DataHCompareDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHCompareDataRef(dh: DataHandler; dataRef: Handle; VAR equal: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000C, $7000, $A82A;
	{$ENDC}

{
 *  DataHTask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHTask(dh: DataHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000D, $7000, $A82A;
	{$ENDC}

{
 *  DataHScheduleData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHScheduleData(dh: DataHandler; PlaceToPutDataPtr: Ptr; FileOffset: LONGINT; DataSize: LONGINT; RefCon: LONGINT; scheduleRec: DataHSchedulePtr; CompletionRtn: DataHCompletionUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $000E, $7000, $A82A;
	{$ENDC}

{
 *  DataHFinishData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHFinishData(dh: DataHandler; PlaceToPutDataPtr: Ptr; Cancel: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $000F, $7000, $A82A;
	{$ENDC}

{
 *  DataHFlushCache()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHFlushCache(dh: DataHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0010, $7000, $A82A;
	{$ENDC}

{
 *  DataHResolveDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHResolveDataRef(dh: DataHandler; theDataRef: Handle; VAR wasChanged: BOOLEAN; userInterfaceAllowed: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0011, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetFileSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHGetFileSize(dh: DataHandler; VAR fileSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}

{
 *  DataHCanUseDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHCanUseDataRef(dh: DataHandler; dataRef: Handle; VAR useFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0013, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetVolumeList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHGetVolumeList(dh: DataHandler; VAR volumeList: DataHVolumeList): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0014, $7000, $A82A;
	{$ENDC}

{
 *  DataHWrite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHWrite(dh: DataHandler; data: Ptr; offset: LONGINT; size: LONGINT; completion: DataHCompletionUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0015, $7000, $A82A;
	{$ENDC}

{
 *  DataHPreextend()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHPreextend(dh: DataHandler; maxToAdd: UInt32; VAR spaceAdded: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0016, $7000, $A82A;
	{$ENDC}

{
 *  DataHSetFileSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHSetFileSize(dh: DataHandler; fileSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0017, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetFreeSpace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHGetFreeSpace(dh: DataHandler; VAR freeSize: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}

{
 *  DataHCreateFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHCreateFile(dh: DataHandler; creator: OSType; deleteExisting: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0019, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetPreferredBlockSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHGetPreferredBlockSize(dh: DataHandler; VAR blockSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001A, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetDeviceIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHGetDeviceIndex(dh: DataHandler; VAR deviceIndex: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001B, $7000, $A82A;
	{$ENDC}

{
 *  DataHIsStreamingDataHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHIsStreamingDataHandler(dh: DataHandler; VAR yes: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001C, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetDataInBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHGetDataInBuffer(dh: DataHandler; startOffset: LONGINT; VAR size: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001D, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetScheduleAheadTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHGetScheduleAheadTime(dh: DataHandler; VAR millisecs: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001E, $7000, $A82A;
	{$ENDC}

{
 *  DataHSetCacheSizeLimit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHSetCacheSizeLimit(dh: DataHandler; cacheSizeLimit: Size): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001F, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetCacheSizeLimit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHGetCacheSizeLimit(dh: DataHandler; VAR cacheSizeLimit: Size): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0020, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHGetMovie(dh: DataHandler; VAR theMovie: Movie; VAR id: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0021, $7000, $A82A;
	{$ENDC}

{
 *  DataHAddMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHAddMovie(dh: DataHandler; theMovie: Movie; VAR id: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0022, $7000, $A82A;
	{$ENDC}

{
 *  DataHUpdateMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHUpdateMovie(dh: DataHandler; theMovie: Movie; id: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0023, $7000, $A82A;
	{$ENDC}

{
 *  DataHDoesBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHDoesBuffer(dh: DataHandler; VAR buffersReads: BOOLEAN; VAR buffersWrites: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0024, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetFileName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHGetFileName(dh: DataHandler; VAR str: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0025, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetAvailableFileSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHGetAvailableFileSize(dh: DataHandler; VAR fileSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0026, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetMacOSFileType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHGetMacOSFileType(dh: DataHandler; VAR fileType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0027, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetMIMEType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHGetMIMEType(dh: DataHandler; VAR mimeType: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0028, $7000, $A82A;
	{$ENDC}

{
 *  DataHSetDataRefWithAnchor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHSetDataRefWithAnchor(dh: DataHandler; anchorDataRef: Handle; dataRefType: OSType; dataRef: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0029, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetDataRefWithAnchor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHGetDataRefWithAnchor(dh: DataHandler; anchorDataRef: Handle; dataRefType: OSType; VAR dataRef: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $002A, $7000, $A82A;
	{$ENDC}

{
 *  DataHSetMacOSFileType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHSetMacOSFileType(dh: DataHandler; fileType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002B, $7000, $A82A;
	{$ENDC}

{
 *  DataHSetTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHSetTimeBase(dh: DataHandler; tb: TimeBase): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002C, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetInfoFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION DataHGetInfoFlags(dh: DataHandler; VAR flags: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002D, $7000, $A82A;
	{$ENDC}

{
 *  DataHScheduleData64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION DataHScheduleData64(dh: DataHandler; PlaceToPutDataPtr: Ptr; {CONST}VAR FileOffset: wide; DataSize: LONGINT; RefCon: LONGINT; scheduleRec: DataHSchedulePtr; CompletionRtn: DataHCompletionUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $002E, $7000, $A82A;
	{$ENDC}

{
 *  DataHWrite64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION DataHWrite64(dh: DataHandler; data: Ptr; {CONST}VAR offset: wide; size: LONGINT; completion: DataHCompletionUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $002F, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetFileSize64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION DataHGetFileSize64(dh: DataHandler; VAR fileSize: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0030, $7000, $A82A;
	{$ENDC}

{
 *  DataHPreextend64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION DataHPreextend64(dh: DataHandler; {CONST}VAR maxToAdd: wide; VAR spaceAdded: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0031, $7000, $A82A;
	{$ENDC}

{
 *  DataHSetFileSize64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION DataHSetFileSize64(dh: DataHandler; {CONST}VAR fileSize: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0032, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetFreeSpace64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION DataHGetFreeSpace64(dh: DataHandler; VAR freeSize: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0033, $7000, $A82A;
	{$ENDC}

{
 *  DataHAppend64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION DataHAppend64(dh: DataHandler; data: UNIV Ptr; VAR fileOffset: wide; size: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0034, $7000, $A82A;
	{$ENDC}

{
 *  DataHReadAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION DataHReadAsync(dh: DataHandler; dataPtr: UNIV Ptr; dataSize: UInt32; {CONST}VAR dataOffset: wide; completion: DataHCompletionUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0035, $7000, $A82A;
	{$ENDC}

{
 *  DataHPollRead()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION DataHPollRead(dh: DataHandler; dataPtr: UNIV Ptr; VAR dataSizeSoFar: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0036, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetDataAvailability()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION DataHGetDataAvailability(dh: DataHandler; offset: LONGINT; len: LONGINT; VAR missing_offset: LONGINT; VAR missing_len: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0037, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetFileSizeAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION DataHGetFileSizeAsync(dh: DataHandler; VAR fileSize: wide; completionRtn: DataHCompletionUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $003A, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetDataRefAsType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION DataHGetDataRefAsType(dh: DataHandler; requestedType: OSType; VAR dataRef: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $003B, $7000, $A82A;
	{$ENDC}

{
 *  DataHSetDataRefExtension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION DataHSetDataRefExtension(dh: DataHandler; extension: Handle; idType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $003C, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetDataRefExtension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION DataHGetDataRefExtension(dh: DataHandler; VAR extension: Handle; idType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $003D, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetMovieWithFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION DataHGetMovieWithFlags(dh: DataHandler; VAR theMovie: Movie; VAR id: INTEGER; flags: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $003E, $7000, $A82A;
	{$ENDC}


{
 *  DataHGetFileTypeOrdering()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION DataHGetFileTypeOrdering(dh: DataHandler; VAR orderingListHandle: DataHFileTypeOrderingHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0040, $7000, $A82A;
	{$ENDC}

{  flags for DataHCreateFileWithFlags }

CONST
	kDataHCreateFileButDontCreateResFile = $00000001;

	{
	 *  DataHCreateFileWithFlags()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 5.0 and later
	 	}
FUNCTION DataHCreateFileWithFlags(dh: DataHandler; creator: OSType; deleteExisting: BOOLEAN; flags: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0041, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetMIMETypeAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION DataHGetMIMETypeAsync(dh: DataHandler; VAR mimeType: Str255; completionRtn: DataHCompletionUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0042, $7000, $A82A;
	{$ENDC}

{
 *  DataHGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0.1 and later
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X after version 10.0
 *    Mac OS X:         in after version 10.0
 *    Windows:          in qtmlClient.lib 5.0.1 and later
 }
FUNCTION DataHGetInfo(dh: DataHandler; what: OSType; info: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0043, $7000, $A82A;
	{$ENDC}

{
 *  DataHPlaybackHints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DataHPlaybackHints(dh: DataHandler; flags: LONGINT; minFileOffset: UInt32; maxFileOffset: UInt32; bytesPerSecond: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0103, $7000, $A82A;
	{$ENDC}

{
 *  DataHPlaybackHints64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION DataHPlaybackHints64(dh: DataHandler; flags: LONGINT; {CONST}VAR minFileOffset: wide; {CONST}VAR maxFileOffset: wide; bytesPerSecond: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $010E, $7000, $A82A;
	{$ENDC}

{  Symbolic constants for DataHGetDataRate }

CONST
	kDataHGetDataRateInfiniteRate = $7FFFFFFF;					{  all the data arrived instantaneously }

	{
	 *  DataHGetDataRate()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 5.0 and later
	 	}
FUNCTION DataHGetDataRate(dh: DataHandler; flags: LONGINT; VAR bytesPerSecond: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0110, $7000, $A82A;
	{$ENDC}

{  Flags for DataHSetTimeHints }

CONST
	kDataHSetTimeHintsSkipBandwidthRequest = $01;				{  set if this data handler should use the network without requesting bandwidth }

	{
	 *  DataHSetTimeHints()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 5.0 and later
	 	}
FUNCTION DataHSetTimeHints(dh: DataHandler; flags: LONGINT; bandwidthPriority: LONGINT; scale: TimeScale; minTime: TimeValue; maxTime: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0111, $7000, $A82A;
	{$ENDC}





{ Standard type for video digitizers }

CONST
	videoDigitizerComponentType	= 'vdig';
	vdigInterfaceRev			= 2;

	{	 Input Format Standards 	}
	ntscIn						= 0;							{  current input format  }
	currentIn					= 0;							{  ntsc input format  }
	palIn						= 1;							{  pal input format  }
	secamIn						= 2;							{  secam input format  }
	ntscReallyIn				= 3;							{  ntsc input format  }

	{	 Input Formats 	}
	compositeIn					= 0;							{  input is composite format  }
	sVideoIn					= 1;							{  input is sVideo format  }
	rgbComponentIn				= 2;							{  input is rgb component format  }
	rgbComponentSyncIn			= 3;							{  input is rgb component format (sync on green?) }
	yuvComponentIn				= 4;							{  input is yuv component format  }
	yuvComponentSyncIn			= 5;							{  input is yuv component format (sync on green?)  }
	tvTunerIn					= 6;
	sdiIn						= 7;


	{	 Video Digitizer PlayThru States 	}
	vdPlayThruOff				= 0;
	vdPlayThruOn				= 1;

	{	 Input Color Space Modes 	}
	vdDigitizerBW				= 0;							{  black and white  }
	vdDigitizerRGB				= 1;							{  rgb color  }

	{	 Phase Lock Loop Modes 	}
	vdBroadcastMode				= 0;							{  Broadcast / Laser Disk video mode  }
	vdVTRMode					= 1;							{  VCR / Magnetic media mode  }

	{	 Field Select Options 	}
	vdUseAnyField				= 0;							{  Digitizers choice on field use  }
	vdUseOddField				= 1;							{  Use odd field for half size vert and smaller  }
	vdUseEvenField				= 2;							{  Use even field for half size vert and smaller  }

	{	 vdig types 	}
	vdTypeBasic					= 0;							{  basic, no clipping  }
	vdTypeAlpha					= 1;							{  supports clipping with alpha channel  }
	vdTypeMask					= 2;							{  supports clipping with mask plane  }
	vdTypeKey					= 3;							{  supports clipping with key color(s)  }



	{	 Digitizer Input Capability/Current Flags 	}
	digiInDoesNTSC				= $00000001;					{  digitizer supports NTSC input format  }
	digiInDoesPAL				= $00000002;					{  digitizer supports PAL input format  }
	digiInDoesSECAM				= $00000004;					{  digitizer supports SECAM input format  }
	digiInDoesGenLock			= $00000080;					{  digitizer does genlock  }
	digiInDoesComposite			= $00000100;					{  digitizer supports composite input type  }
	digiInDoesSVideo			= $00000200;					{  digitizer supports S-Video input type  }
	digiInDoesComponent			= $00000400;					{  digitizer supports component = rgb, input type  }
	digiInVTR_Broadcast			= $00000800;					{  digitizer can differentiate between the two  }
	digiInDoesColor				= $00001000;					{  digitizer supports color  }
	digiInDoesBW				= $00002000;					{  digitizer supports black & white  }
																{  Digitizer Input Current Flags = these are valid only during active operating conditions,    }
	digiInSignalLock			= $80000000;					{  digitizer detects input signal is locked, this bit = horiz lock || vertical lock  }


	{	 Digitizer Output Capability/Current Flags 	}
	digiOutDoes1				= $00000001;					{  digitizer supports 1 bit pixels  }
	digiOutDoes2				= $00000002;					{  digitizer supports 2 bit pixels  }
	digiOutDoes4				= $00000004;					{  digitizer supports 4 bit pixels  }
	digiOutDoes8				= $00000008;					{  digitizer supports 8 bit pixels  }
	digiOutDoes16				= $00000010;					{  digitizer supports 16 bit pixels  }
	digiOutDoes32				= $00000020;					{  digitizer supports 32 bit pixels  }
	digiOutDoesDither			= $00000040;					{  digitizer dithers in indexed modes  }
	digiOutDoesStretch			= $00000080;					{  digitizer can arbitrarily stretch  }
	digiOutDoesShrink			= $00000100;					{  digitizer can arbitrarily shrink  }
	digiOutDoesMask				= $00000200;					{  digitizer can mask to clipping regions  }
	digiOutDoesDouble			= $00000800;					{  digitizer can stretch to exactly double size  }
	digiOutDoesQuad				= $00001000;					{  digitizer can stretch exactly quadruple size  }
	digiOutDoesQuarter			= $00002000;					{  digitizer can shrink to exactly quarter size  }
	digiOutDoesSixteenth		= $00004000;					{  digitizer can shrink to exactly sixteenth size  }
	digiOutDoesRotate			= $00008000;					{  digitizer supports rotate transformations  }
	digiOutDoesHorizFlip		= $00010000;					{  digitizer supports horizontal flips Sx < 0  }
	digiOutDoesVertFlip			= $00020000;					{  digitizer supports vertical flips Sy < 0  }
	digiOutDoesSkew				= $00040000;					{  digitizer supports skew = shear,twist,  }
	digiOutDoesBlend			= $00080000;
	digiOutDoesWarp				= $00100000;
	digiOutDoesHW_DMA			= $00200000;					{  digitizer not constrained to local device  }
	digiOutDoesHWPlayThru		= $00400000;					{  digitizer doesn't need time to play thru  }
	digiOutDoesILUT				= $00800000;					{  digitizer does inverse LUT for index modes  }
	digiOutDoesKeyColor			= $01000000;					{  digitizer does key color functions too  }
	digiOutDoesAsyncGrabs		= $02000000;					{  digitizer supports async grabs  }
	digiOutDoesUnreadableScreenBits = $04000000;				{  playthru doesn't generate readable bits on screen }
	digiOutDoesCompress			= $08000000;					{  supports alternate output data types  }
	digiOutDoesCompressOnly		= $10000000;					{  can't provide raw frames anywhere  }
	digiOutDoesPlayThruDuringCompress = $20000000;				{  digi can do playthru while providing compressed data  }
	digiOutDoesCompressPartiallyVisible = $40000000;			{  digi doesn't need all bits visible on screen to do hardware compress  }
	digiOutDoesNotNeedCopyOfCompressData = $80000000;			{  digi doesn't need any bufferization when providing compressed data  }

	{	 Types 	}

TYPE
	VideoDigitizerComponent				= ComponentInstance;
	VideoDigitizerError					= ComponentResult;
	DigitizerInfoPtr = ^DigitizerInfo;
	DigitizerInfo = RECORD
		vdigType:				INTEGER;
		inputCapabilityFlags:	LONGINT;
		outputCapabilityFlags:	LONGINT;
		inputCurrentFlags:		LONGINT;
		outputCurrentFlags:		LONGINT;
		slot:					INTEGER;								{  temporary for connection purposes  }
		gdh:					GDHandle;								{  temporary for digitizers that have preferred screen  }
		maskgdh:				GDHandle;								{  temporary for digitizers that have mask planes  }
		minDestHeight:			INTEGER;								{  Smallest resizable height  }
		minDestWidth:			INTEGER;								{  Smallest resizable width  }
		maxDestHeight:			INTEGER;								{  Largest resizable height  }
		maxDestWidth:			INTEGER;								{  Largest resizable width  }
		blendLevels:			INTEGER;								{  Number of blend levels supported (2 if 1 bit mask)  }
		reserved:				LONGINT;								{  reserved  }
	END;

	VdigTypePtr = ^VdigType;
	VdigType = RECORD
		digType:				LONGINT;
		reserved:				LONGINT;
	END;

	VdigTypeListPtr = ^VdigTypeList;
	VdigTypeList = RECORD
		count:					INTEGER;
		list:					ARRAY [0..0] OF VdigType;
	END;

	VdigBufferRecPtr = ^VdigBufferRec;
	VdigBufferRec = RECORD
		dest:					PixMapHandle;
		location:				Point;
		reserved:				LONGINT;
	END;

	VdigBufferRecListPtr = ^VdigBufferRecList;
	VdigBufferRecList = RECORD
		count:					INTEGER;
		matrix:					MatrixRecordPtr;
		mask:					RgnHandle;
		list:					ARRAY [0..0] OF VdigBufferRec;
	END;

	VdigBufferRecListHandle				= ^VdigBufferRecListPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	VdigIntProcPtr = PROCEDURE(flags: LONGINT; refcon: LONGINT);
{$ELSEC}
	VdigIntProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	VdigIntUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	VdigIntUPP = UniversalProcPtr;
{$ENDC}	
	VDCompressionListPtr = ^VDCompressionList;
	VDCompressionList = RECORD
		codec:					CodecComponent;
		cType:					CodecType;
		typeName:				Str63;
		name:					Str63;
		formatFlags:			LONGINT;
		compressFlags:			LONGINT;
		reserved:				LONGINT;
	END;

	VDCompressionListHandle				= ^VDCompressionListPtr;

CONST
	dmaDepth1					= 1;
	dmaDepth2					= 2;
	dmaDepth4					= 4;
	dmaDepth8					= 8;
	dmaDepth16					= 16;
	dmaDepth32					= 32;
	dmaDepth2Gray				= 64;
	dmaDepth4Gray				= 128;
	dmaDepth8Gray				= 256;

	kVDIGControlledFrameRate	= -1;


	{
	 *  VDGetMaxSrcRect()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION VDGetMaxSrcRect(ci: VideoDigitizerComponent; inputStd: INTEGER; VAR maxSrcRect: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0001, $7000, $A82A;
	{$ENDC}

{
 *  VDGetActiveSrcRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetActiveSrcRect(ci: VideoDigitizerComponent; inputStd: INTEGER; VAR activeSrcRect: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0002, $7000, $A82A;
	{$ENDC}

{
 *  VDSetDigitizerRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetDigitizerRect(ci: VideoDigitizerComponent; VAR digitizerRect: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}

{
 *  VDGetDigitizerRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetDigitizerRect(ci: VideoDigitizerComponent; VAR digitizerRect: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}

{
 *  VDGetVBlankRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetVBlankRect(ci: VideoDigitizerComponent; inputStd: INTEGER; VAR vBlankRect: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0005, $7000, $A82A;
	{$ENDC}

{
 *  VDGetMaskPixMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetMaskPixMap(ci: VideoDigitizerComponent; maskPixMap: PixMapHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}

{
 *  VDGetPlayThruDestination()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetPlayThruDestination(ci: VideoDigitizerComponent; VAR dest: PixMapHandle; VAR destRect: Rect; VAR m: MatrixRecord; VAR mask: RgnHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0008, $7000, $A82A;
	{$ENDC}

{
 *  VDUseThisCLUT()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDUseThisCLUT(ci: VideoDigitizerComponent; colorTableHandle: CTabHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0009, $7000, $A82A;
	{$ENDC}

{
 *  VDSetInputGammaValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetInputGammaValue(ci: VideoDigitizerComponent; channel1: Fixed; channel2: Fixed; channel3: Fixed): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000A, $7000, $A82A;
	{$ENDC}

{
 *  VDGetInputGammaValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetInputGammaValue(ci: VideoDigitizerComponent; VAR channel1: Fixed; VAR channel2: Fixed; VAR channel3: Fixed): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000B, $7000, $A82A;
	{$ENDC}

{
 *  VDSetBrightness()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetBrightness(ci: VideoDigitizerComponent; VAR brightness: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}

{
 *  VDGetBrightness()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetBrightness(ci: VideoDigitizerComponent; VAR brightness: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}

{
 *  VDSetContrast()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetContrast(ci: VideoDigitizerComponent; VAR contrast: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000E, $7000, $A82A;
	{$ENDC}

{
 *  VDSetHue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetHue(ci: VideoDigitizerComponent; VAR hue: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000F, $7000, $A82A;
	{$ENDC}

{
 *  VDSetSharpness()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetSharpness(ci: VideoDigitizerComponent; VAR sharpness: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0010, $7000, $A82A;
	{$ENDC}

{
 *  VDSetSaturation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetSaturation(ci: VideoDigitizerComponent; VAR saturation: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0011, $7000, $A82A;
	{$ENDC}

{
 *  VDGetContrast()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetContrast(ci: VideoDigitizerComponent; VAR contrast: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}

{
 *  VDGetHue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetHue(ci: VideoDigitizerComponent; VAR hue: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0013, $7000, $A82A;
	{$ENDC}

{
 *  VDGetSharpness()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetSharpness(ci: VideoDigitizerComponent; VAR sharpness: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0014, $7000, $A82A;
	{$ENDC}

{
 *  VDGetSaturation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetSaturation(ci: VideoDigitizerComponent; VAR saturation: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0015, $7000, $A82A;
	{$ENDC}

{
 *  VDGrabOneFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGrabOneFrame(ci: VideoDigitizerComponent): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0016, $7000, $A82A;
	{$ENDC}

{
 *  VDGetMaxAuxBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetMaxAuxBuffer(ci: VideoDigitizerComponent; VAR pm: PixMapHandle; VAR r: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0017, $7000, $A82A;
	{$ENDC}

{
 *  VDGetDigitizerInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetDigitizerInfo(ci: VideoDigitizerComponent; VAR info: DigitizerInfo): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0019, $7000, $A82A;
	{$ENDC}

{
 *  VDGetCurrentFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetCurrentFlags(ci: VideoDigitizerComponent; VAR inputCurrentFlag: LONGINT; VAR outputCurrentFlag: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001A, $7000, $A82A;
	{$ENDC}

{
 *  VDSetKeyColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetKeyColor(ci: VideoDigitizerComponent; index: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001B, $7000, $A82A;
	{$ENDC}

{
 *  VDGetKeyColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetKeyColor(ci: VideoDigitizerComponent; VAR index: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001C, $7000, $A82A;
	{$ENDC}

{
 *  VDAddKeyColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDAddKeyColor(ci: VideoDigitizerComponent; VAR index: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001D, $7000, $A82A;
	{$ENDC}

{
 *  VDGetNextKeyColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetNextKeyColor(ci: VideoDigitizerComponent; index: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001E, $7000, $A82A;
	{$ENDC}

{
 *  VDSetKeyColorRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetKeyColorRange(ci: VideoDigitizerComponent; VAR minRGB: RGBColor; VAR maxRGB: RGBColor): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $001F, $7000, $A82A;
	{$ENDC}

{
 *  VDGetKeyColorRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetKeyColorRange(ci: VideoDigitizerComponent; VAR minRGB: RGBColor; VAR maxRGB: RGBColor): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0020, $7000, $A82A;
	{$ENDC}

{
 *  VDSetDigitizerUserInterrupt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetDigitizerUserInterrupt(ci: VideoDigitizerComponent; flags: LONGINT; userInterruptProc: VdigIntUPP; refcon: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0021, $7000, $A82A;
	{$ENDC}

{
 *  VDSetInputColorSpaceMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetInputColorSpaceMode(ci: VideoDigitizerComponent; colorSpaceMode: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0022, $7000, $A82A;
	{$ENDC}

{
 *  VDGetInputColorSpaceMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetInputColorSpaceMode(ci: VideoDigitizerComponent; VAR colorSpaceMode: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0023, $7000, $A82A;
	{$ENDC}

{
 *  VDSetClipState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetClipState(ci: VideoDigitizerComponent; clipEnable: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0024, $7000, $A82A;
	{$ENDC}

{
 *  VDGetClipState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetClipState(ci: VideoDigitizerComponent; VAR clipEnable: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0025, $7000, $A82A;
	{$ENDC}

{
 *  VDSetClipRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetClipRgn(ci: VideoDigitizerComponent; clipRegion: RgnHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0026, $7000, $A82A;
	{$ENDC}

{
 *  VDClearClipRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDClearClipRgn(ci: VideoDigitizerComponent; clipRegion: RgnHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0027, $7000, $A82A;
	{$ENDC}

{
 *  VDGetCLUTInUse()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetCLUTInUse(ci: VideoDigitizerComponent; VAR colorTableHandle: CTabHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0028, $7000, $A82A;
	{$ENDC}

{
 *  VDSetPLLFilterType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetPLLFilterType(ci: VideoDigitizerComponent; pllType: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0029, $7000, $A82A;
	{$ENDC}

{
 *  VDGetPLLFilterType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetPLLFilterType(ci: VideoDigitizerComponent; VAR pllType: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002A, $7000, $A82A;
	{$ENDC}

{
 *  VDGetMaskandValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetMaskandValue(ci: VideoDigitizerComponent; blendLevel: UInt16; VAR mask: LONGINT; VAR value: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $002B, $7000, $A82A;
	{$ENDC}

{
 *  VDSetMasterBlendLevel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetMasterBlendLevel(ci: VideoDigitizerComponent; VAR blendLevel: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002C, $7000, $A82A;
	{$ENDC}

{
 *  VDSetPlayThruDestination()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetPlayThruDestination(ci: VideoDigitizerComponent; dest: PixMapHandle; destRect: RectPtr; m: MatrixRecordPtr; mask: RgnHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $002D, $7000, $A82A;
	{$ENDC}

{
 *  VDSetPlayThruOnOff()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetPlayThruOnOff(ci: VideoDigitizerComponent; state: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $002E, $7000, $A82A;
	{$ENDC}

{
 *  VDSetFieldPreference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetFieldPreference(ci: VideoDigitizerComponent; fieldFlag: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $002F, $7000, $A82A;
	{$ENDC}

{
 *  VDGetFieldPreference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetFieldPreference(ci: VideoDigitizerComponent; VAR fieldFlag: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0030, $7000, $A82A;
	{$ENDC}

{
 *  VDPreflightDestination()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDPreflightDestination(ci: VideoDigitizerComponent; VAR digitizerRect: Rect; VAR dest: PixMapPtr; destRect: RectPtr; m: MatrixRecordPtr): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0032, $7000, $A82A;
	{$ENDC}

{
 *  VDPreflightGlobalRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDPreflightGlobalRect(ci: VideoDigitizerComponent; theWindow: GrafPtr; VAR globalRect: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0033, $7000, $A82A;
	{$ENDC}

{
 *  VDSetPlayThruGlobalRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetPlayThruGlobalRect(ci: VideoDigitizerComponent; theWindow: GrafPtr; VAR globalRect: Rect): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0034, $7000, $A82A;
	{$ENDC}

{
 *  VDSetInputGammaRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetInputGammaRecord(ci: VideoDigitizerComponent; inputGammaPtr: VDGamRecPtr): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0035, $7000, $A82A;
	{$ENDC}

{
 *  VDGetInputGammaRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetInputGammaRecord(ci: VideoDigitizerComponent; VAR inputGammaPtr: VDGamRecPtr): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0036, $7000, $A82A;
	{$ENDC}

{
 *  VDSetBlackLevelValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetBlackLevelValue(ci: VideoDigitizerComponent; VAR blackLevel: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0037, $7000, $A82A;
	{$ENDC}

{
 *  VDGetBlackLevelValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetBlackLevelValue(ci: VideoDigitizerComponent; VAR blackLevel: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0038, $7000, $A82A;
	{$ENDC}

{
 *  VDSetWhiteLevelValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetWhiteLevelValue(ci: VideoDigitizerComponent; VAR whiteLevel: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0039, $7000, $A82A;
	{$ENDC}

{
 *  VDGetWhiteLevelValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetWhiteLevelValue(ci: VideoDigitizerComponent; VAR whiteLevel: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $003A, $7000, $A82A;
	{$ENDC}

{
 *  VDGetVideoDefaults()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetVideoDefaults(ci: VideoDigitizerComponent; VAR blackLevel: UInt16; VAR whiteLevel: UInt16; VAR brightness: UInt16; VAR hue: UInt16; VAR saturation: UInt16; VAR contrast: UInt16; VAR sharpness: UInt16): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001C, $003B, $7000, $A82A;
	{$ENDC}

{
 *  VDGetNumberOfInputs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetNumberOfInputs(ci: VideoDigitizerComponent; VAR inputs: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $003C, $7000, $A82A;
	{$ENDC}

{
 *  VDGetInputFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetInputFormat(ci: VideoDigitizerComponent; input: INTEGER; VAR format: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $003D, $7000, $A82A;
	{$ENDC}

{
 *  VDSetInput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetInput(ci: VideoDigitizerComponent; input: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $003E, $7000, $A82A;
	{$ENDC}

{
 *  VDGetInput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetInput(ci: VideoDigitizerComponent; VAR input: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $003F, $7000, $A82A;
	{$ENDC}

{
 *  VDSetInputStandard()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetInputStandard(ci: VideoDigitizerComponent; inputStandard: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0040, $7000, $A82A;
	{$ENDC}

{
 *  VDSetupBuffers()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetupBuffers(ci: VideoDigitizerComponent; bufferList: VdigBufferRecListHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0041, $7000, $A82A;
	{$ENDC}

{
 *  VDGrabOneFrameAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGrabOneFrameAsync(ci: VideoDigitizerComponent; buffer: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0042, $7000, $A82A;
	{$ENDC}

{
 *  VDDone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDDone(ci: VideoDigitizerComponent; buffer: INTEGER): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0043, $7000, $A82A;
	{$ENDC}

{
 *  VDSetCompression()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetCompression(ci: VideoDigitizerComponent; compressType: OSType; depth: INTEGER; VAR bounds: Rect; spatialQuality: CodecQ; temporalQuality: CodecQ; keyFrameRate: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0016, $0044, $7000, $A82A;
	{$ENDC}

{
 *  VDCompressOneFrameAsync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDCompressOneFrameAsync(ci: VideoDigitizerComponent): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0045, $7000, $A82A;
	{$ENDC}

{
 *  VDCompressDone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDCompressDone(ci: VideoDigitizerComponent; VAR done: BOOLEAN; VAR theData: Ptr; VAR dataSize: LONGINT; VAR similarity: UInt8; VAR t: TimeRecord): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0046, $7000, $A82A;
	{$ENDC}

{
 *  VDReleaseCompressBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDReleaseCompressBuffer(ci: VideoDigitizerComponent; bufferAddr: Ptr): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0047, $7000, $A82A;
	{$ENDC}

{
 *  VDGetImageDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetImageDescription(ci: VideoDigitizerComponent; desc: ImageDescriptionHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0048, $7000, $A82A;
	{$ENDC}

{
 *  VDResetCompressSequence()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDResetCompressSequence(ci: VideoDigitizerComponent): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0049, $7000, $A82A;
	{$ENDC}

{
 *  VDSetCompressionOnOff()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetCompressionOnOff(ci: VideoDigitizerComponent; state: BOOLEAN): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $004A, $7000, $A82A;
	{$ENDC}

{
 *  VDGetCompressionTypes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetCompressionTypes(ci: VideoDigitizerComponent; h: VDCompressionListHandle): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $004B, $7000, $A82A;
	{$ENDC}

{
 *  VDSetTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetTimeBase(ci: VideoDigitizerComponent; t: TimeBase): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $004C, $7000, $A82A;
	{$ENDC}

{
 *  VDSetFrameRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetFrameRate(ci: VideoDigitizerComponent; framesPerSecond: Fixed): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $004D, $7000, $A82A;
	{$ENDC}

{
 *  VDGetDataRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetDataRate(ci: VideoDigitizerComponent; VAR milliSecPerFrame: LONGINT; VAR framesPerSecond: Fixed; VAR bytesPerSecond: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $004E, $7000, $A82A;
	{$ENDC}

{
 *  VDGetSoundInputDriver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetSoundInputDriver(ci: VideoDigitizerComponent; VAR soundDriverName: Str255): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $004F, $7000, $A82A;
	{$ENDC}

{
 *  VDGetDMADepths()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetDMADepths(ci: VideoDigitizerComponent; VAR depthArray: LONGINT; VAR preferredDepth: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0050, $7000, $A82A;
	{$ENDC}

{
 *  VDGetPreferredTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetPreferredTimeScale(ci: VideoDigitizerComponent; VAR preferred: TimeScale): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0051, $7000, $A82A;
	{$ENDC}

{
 *  VDReleaseAsyncBuffers()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDReleaseAsyncBuffers(ci: VideoDigitizerComponent): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0052, $7000, $A82A;
	{$ENDC}

{ 83 is reserved for compatibility reasons }
{
 *  VDSetDataRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetDataRate(ci: VideoDigitizerComponent; bytesPerSecond: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0054, $7000, $A82A;
	{$ENDC}

{
 *  VDGetTimeCode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetTimeCode(ci: VideoDigitizerComponent; VAR atTime: TimeRecord; timeCodeFormat: UNIV Ptr; timeCodeTime: UNIV Ptr): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0055, $7000, $A82A;
	{$ENDC}

{
 *  VDUseSafeBuffers()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDUseSafeBuffers(ci: VideoDigitizerComponent; useSafeBuffers: BOOLEAN): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0056, $7000, $A82A;
	{$ENDC}

{
 *  VDGetSoundInputSource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetSoundInputSource(ci: VideoDigitizerComponent; videoInput: LONGINT; VAR soundInput: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0057, $7000, $A82A;
	{$ENDC}

{
 *  VDGetCompressionTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetCompressionTime(ci: VideoDigitizerComponent; compressionType: OSType; depth: INTEGER; VAR srcRect: Rect; VAR spatialQuality: CodecQ; VAR temporalQuality: CodecQ; VAR compressTime: UInt32): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0016, $0058, $7000, $A82A;
	{$ENDC}

{
 *  VDSetPreferredPacketSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetPreferredPacketSize(ci: VideoDigitizerComponent; preferredPacketSizeInBytes: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0059, $7000, $A82A;
	{$ENDC}

{
 *  VDSetPreferredImageDimensions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetPreferredImageDimensions(ci: VideoDigitizerComponent; width: LONGINT; height: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $005A, $7000, $A82A;
	{$ENDC}

{
 *  VDGetPreferredImageDimensions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetPreferredImageDimensions(ci: VideoDigitizerComponent; VAR width: LONGINT; VAR height: LONGINT): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $005B, $7000, $A82A;
	{$ENDC}

{
 *  VDGetInputName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDGetInputName(ci: VideoDigitizerComponent; videoInput: LONGINT; VAR name: Str255): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $005C, $7000, $A82A;
	{$ENDC}

{
 *  VDSetDestinationPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VDSetDestinationPort(ci: VideoDigitizerComponent; destPort: CGrafPtr): VideoDigitizerError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $005D, $7000, $A82A;
	{$ENDC}




CONST
	xmlParseComponentType		= 'pars';
	xmlParseComponentSubType	= 'xml ';

	xmlIdentifierInvalid		= 0;
	xmlIdentifierUnrecognized	= $FFFFFFFF;
	xmlContentTypeInvalid		= 0;
	xmlContentTypeElement		= 1;
	xmlContentTypeCharData		= 2;

	elementFlagAlwaysSelfContained = $00000001;					{     Element doesn't have contents or closing tag even if it doesn't end with />, as in the HTML <img> tag }
	elementFlagPreserveWhiteSpace = $00000002;					{   Preserve whitespace in content, default is to remove it  }
	xmlParseFlagAllowUppercase	= $00000001;					{     Entities and attributes do not have to be lowercase (strict XML), but can be upper or mixed case as in HTML }
	xmlParseFlagAllowUnquotedAttributeValues = $00000002;		{     Attributes values do not have to be enclosed in quotes (strict XML), but can be left unquoted if they contain no spaces }
	xmlParseFlagEventParseOnly	= $00000004;					{     Do event parsing only }

	attributeValueKindCharString = 0;
	attributeValueKindInteger	= $00000001;					{     Number }
	attributeValueKindPercent	= $00000002;					{     Number or percent }
	attributeValueKindBoolean	= $00000004;					{     "true" or "false" }
	attributeValueKindOnOff		= $00000008;					{     "on" or "off" }
	attributeValueKindColor		= $00000010;					{     Either "#rrggbb" or a color name }
	attributeValueKindEnum		= $00000020;					{     one of a number of strings; the enum strings are passed as a zero-separated, double-zero-terminated C string in the attributeKindValueInfo param }
	attributeValueKindCaseSensEnum = $00000040;					{     one of a number of strings; the enum strings are passed as for attributeValueKindEnum, but the values are case-sensitive }
	MAX_ATTRIBUTE_VALUE_KIND	= $00000040;

	nameSpaceIDNone				= 0;

	{   A Parsed XML attribute value, one of number/percent, boolean/on-off, color, or enumerated type }

TYPE
	XMLAttributeValuePtr = ^XMLAttributeValue;
	XMLAttributeValue = RECORD
		CASE INTEGER OF
		0: (
			number:				SInt32;									{     The value when valueKind is attributeValueKindInteger or attributeValueKindPercent }
			);
		1: (
			boolean:			BOOLEAN;								{     The value when valueKind is attributeValueKindBoolean or attributeValueKindOnOff }
			);
		2: (
			color:				RGBColor;								{     The value when valueKind is attributeValueKindColor }
			);
		3: (
			enumType:			UInt32;									{     The value when valueKind is attributeValueKindEnum }
			);
	END;

	{   An XML attribute-value pair }
	XMLAttributePtr = ^XMLAttribute;
	XMLAttribute = RECORD
		identifier:				UInt32;									{     Tokenized identifier, if the attribute name was recognized by the parser }
		name:					CStringPtr;								{     Attribute name, Only present if identifier == xmlIdentifierUnrecognized }
		valueKind:				LONGINT;								{     Type of parsed value, if the value was recognized and parsed; otherwise, attributeValueKindCharString }
		value:					XMLAttributeValue;						{     Parsed attribute value }
		valueStr:				CStringPtr;								{     Always present }
	END;

	{   Forward struct declarations for recursively-defined tree structure }
	XMLContentPtr = ^XMLContent;
	{
	    An XML Element, i.e.
	        <element attr="value" attr="value" ...> [contents] </element>
	    or
	        <element attr="value" attr="value" .../>
	}
	XMLElementPtr = ^XMLElement;
	XMLElement = RECORD
		identifier:				UInt32;									{     Tokenized identifier, if the element name was recognized by the parser }
		name:					CStringPtr;								{     Element name, only present if identifier == xmlIdentifierUnrecognized }
		attributes:				XMLAttributePtr;						{     Array of attributes, terminated with an attribute with identifier == xmlIdentifierInvalid }
		contents:				XMLContentPtr;							{     Array of contents, terminated with a content with kind == xmlIdentifierInvalid }
	END;

	{
	    The content of an XML element is a series of parts, each of which may be either another element
	    or simply character data.
	}
	XMLElementContentPtr = ^XMLElementContent;
	XMLElementContent = RECORD
		CASE INTEGER OF
		0: (
			element:			XMLElement;								{     The contents when the content kind is xmlContentTypeElement }
			);
		1: (
			charData:			CStringPtr;								{     The contents when the content kind is xmlContentTypeCharData }
			);
	END;

	XMLContent = RECORD
		kind:					UInt32;
		actualContent:			XMLElementContent;
	END;

	XMLDocRecordPtr = ^XMLDocRecord;
	XMLDocRecord = RECORD
		xmlDataStorage:			Ptr;									{     opaque storage }
		rootElement:			XMLElement;
	END;

	XMLDoc								= ^XMLDocRecord;
	{ callback routines for event parsing }
{$IFC TYPED_FUNCTION_POINTERS}
	StartDocumentHandler = FUNCTION(refcon: LONGINT): ComponentResult;
{$ELSEC}
	StartDocumentHandler = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	EndDocumentHandler = FUNCTION(refcon: LONGINT): ComponentResult;
{$ELSEC}
	EndDocumentHandler = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	StartElementHandler = FUNCTION(name: ConstCStringPtr; VAR atts: ConstCStringPtr; refcon: LONGINT): ComponentResult;
{$ELSEC}
	StartElementHandler = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	EndElementHandler = FUNCTION(name: ConstCStringPtr; refcon: LONGINT): ComponentResult;
{$ELSEC}
	EndElementHandler = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CharDataHandler = FUNCTION(charData: ConstCStringPtr; refcon: LONGINT): ComponentResult;
{$ELSEC}
	CharDataHandler = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	PreprocessInstructionHandler = FUNCTION(name: ConstCStringPtr; VAR atts: ConstCStringPtr; refcon: LONGINT): ComponentResult;
{$ELSEC}
	PreprocessInstructionHandler = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	CommentHandler = FUNCTION(comment: ConstCStringPtr; refcon: LONGINT): ComponentResult;
{$ELSEC}
	CommentHandler = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	StartDocumentHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	StartDocumentHandlerUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	EndDocumentHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	EndDocumentHandlerUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	StartElementHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	StartElementHandlerUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	EndElementHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	EndElementHandlerUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	CharDataHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CharDataHandlerUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	PreprocessInstructionHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	PreprocessInstructionHandlerUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	CommentHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	CommentHandlerUPP = UniversalProcPtr;
{$ENDC}	
	{
	 *  XMLParseDataRef()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 5.0 and later
	 	}
FUNCTION XMLParseDataRef(aParser: ComponentInstance; dataRef: Handle; dataRefType: OSType; parseFlags: LONGINT; VAR document: XMLDoc): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0001, $7000, $A82A;
	{$ENDC}

{   Parses the XML file pointed to by dataRef, returning a XMLDoc parse tree }
{
 *  XMLParseFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseFile(aParser: ComponentInstance; fileSpec: ConstFSSpecPtr; parseFlags: LONGINT; VAR document: XMLDoc): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0002, $7000, $A82A;
	{$ENDC}

{   Parses the XML file pointed to by fileSpec, returning a XMLDoc parse tree }
{
 *  XMLParseDisposeXMLDoc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseDisposeXMLDoc(aParser: ComponentInstance; document: XMLDoc): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}

{   Disposes of a XMLDoc parse tree }
{
 *  XMLParseGetDetailedParseError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseGetDetailedParseError(aParser: ComponentInstance; VAR errorLine: LONGINT; errDesc: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0004, $7000, $A82A;
	{$ENDC}

{
    Returns a more detailed description of the error and the line in which it occurred, if a
    file failed to parse properly.
}
{
 *  XMLParseAddElement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseAddElement(aParser: ComponentInstance; elementName: CStringPtr; nameSpaceID: UInt32; VAR elementID: UInt32; elementFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0005, $7000, $A82A;
	{$ENDC}

{
    Tell the parser of an element to be recognized. The tokenized element unique identifier is
    passed in *elementID, unless *elementID is zero, whereupon a unique ID is generated and returned.
    Thus, a valid element identifier can never be zero.
}
{
 *  XMLParseAddAttribute()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseAddAttribute(aParser: ComponentInstance; elementID: UInt32; nameSpaceID: UInt32; attributeName: CStringPtr; VAR attributeID: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0006, $7000, $A82A;
	{$ENDC}

{
    Tells the parser of an attribute for the specified element. The tokenized attribute unique
    ID is passed in *attributeID, unless *attributeID is zero, whereupon a unique ID is generated and
    returned. Thus, a valid attribute identifier can never be zero.
}
{
 *  XMLParseAddMultipleAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseAddMultipleAttributes(aParser: ComponentInstance; elementID: UInt32; VAR nameSpaceIDs: UInt32; attributeNames: CStringPtr; VAR attributeIDs: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0007, $7000, $A82A;
	{$ENDC}

{
    Tells the parser of several attributes for the specified element. The attributes are passed
    as a zero-delimited, double-zero-terminated C string in attributeNames, and the attribute
    IDs are passed in on attributeIDs as an array; if any attributeIDs are zero, unique IDs
    are generated for those and returned
}
{
 *  XMLParseAddAttributeAndValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseAddAttributeAndValue(aParser: ComponentInstance; elementID: UInt32; nameSpaceID: UInt32; attributeName: CStringPtr; VAR attributeID: UInt32; attributeValueKind: UInt32; attributeValueKindInfo: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0008, $7000, $A82A;
	{$ENDC}

{
    Tells the parser of an attribute, which may have a particular type of value, for the
    specified element. Params are as in XMLParseAddAttribute, plus all the kinds of values
    the attribute may have are passed in attributeValueKind, and optional additional information
    required to tokenize the particular kind of attribute is passed in attributeValueKindInfo
}
{
 *  XMLParseAddMultipleAttributesAndValues()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseAddMultipleAttributesAndValues(aParser: ComponentInstance; elementID: UInt32; VAR nameSpaceIDs: UInt32; attributeNames: CStringPtr; VAR attributeIDs: UInt32; VAR attributeValueKinds: UInt32; VAR attributeValueKindInfos: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $0009, $7000, $A82A;
	{$ENDC}

{
    Tells the parser of several attributes, which may have a particular type of value, for the
    specified element. Params are as in XMLParseAddMultipleAttributes, plus all the kinds of values
    the attributes may have are passed in attributeValueKinds, and optional additional information
    required to tokenize the particular kind of attributes is passed in attributeValueKindInfos
}
{
 *  XMLParseAddAttributeValueKind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseAddAttributeValueKind(aParser: ComponentInstance; elementID: UInt32; attributeID: UInt32; attributeValueKind: UInt32; attributeValueKindInfo: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $000A, $7000, $A82A;
	{$ENDC}

{
    Tells the parser that the particular attribute may have an additional kind of
    value, as specified by attributeValueKind and attributeValueKindInfo
}
{
 *  XMLParseAddNameSpace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseAddNameSpace(aParser: ComponentInstance; nameSpaceURL: CStringPtr; VAR nameSpaceID: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000B, $7000, $A82A;
	{$ENDC}

{
    Tell the parser of a namespace to be recognized. The tokenized namespace unique identifier is
    passed in *nameSpaceID, unless *nameSpaceID is zero, whereupon a unique ID is generated and returned.
    Thus, a valid nameSpaceID identifier can never be zero.
}
{
 *  XMLParseSetOffsetAndLimit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseSetOffsetAndLimit(aParser: ComponentInstance; offset: UInt32; limit: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000C, $7000, $A82A;
	{$ENDC}

{   Specifies the offset and limit for reading from the dataref to be used when parsing }
{
 *  XMLParseSetEventParseRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseSetEventParseRefCon(aParser: ComponentInstance; refcon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}

{   Set the event parse refcon }
{
 *  XMLParseSetStartDocumentHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseSetStartDocumentHandler(aParser: ComponentInstance; startDocument: StartDocumentHandlerUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000E, $7000, $A82A;
	{$ENDC}

{   Set the start document handler UPP for event parsing }
{
 *  XMLParseSetEndDocumentHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseSetEndDocumentHandler(aParser: ComponentInstance; endDocument: EndDocumentHandlerUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000F, $7000, $A82A;
	{$ENDC}

{   Set the end document handler UPP for event parsing }
{
 *  XMLParseSetStartElementHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseSetStartElementHandler(aParser: ComponentInstance; startElement: StartElementHandlerUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0010, $7000, $A82A;
	{$ENDC}

{   Set the start element handler UPP for event parsing }
{
 *  XMLParseSetEndElementHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseSetEndElementHandler(aParser: ComponentInstance; endElement: EndElementHandlerUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0011, $7000, $A82A;
	{$ENDC}

{   Set the end element handler UPP for event parsing }
{
 *  XMLParseSetCharDataHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseSetCharDataHandler(aParser: ComponentInstance; charData: CharDataHandlerUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}

{   Set the character data handler UPP for event parsing }
{
 *  XMLParseSetPreprocessInstructionHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseSetPreprocessInstructionHandler(aParser: ComponentInstance; preprocessInstruction: PreprocessInstructionHandlerUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0013, $7000, $A82A;
	{$ENDC}

{   Set the preprocess instruction handler UPP for event parsing }
{
 *  XMLParseSetCommentHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION XMLParseSetCommentHandler(aParser: ComponentInstance; comment: CommentHandlerUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0014, $7000, $A82A;
	{$ENDC}

{   Set the comment handler UPP for event parsing }
{
    Helper Macros
    
        These macros allow you to easily add entities and attributes to the parser
        in an error free manner when the identifiers are defined in a particular manner.
        For these to work, you must define the identifiers as follows:
        
        For entities, they must be defined as element_elementName, as in:
        
            enum
            (
                element_xml =   1,      //  "xml"
                element_head,           //  "head"
                element_body            //  "body"
            );
            
        If the element name has characters that are illegal in an identifier,
        some of the macros support that, but the identifier must not contain
        the illegal characters:
        
            enum
            (
                element_rootlayout      //  "root-layout"
            )
            
        For attribute names, similar rules apply except that they must be defined
        as attr_attributeName, as in:
            
            enum
            (
                attr_src    =   1,      //  "src"
                attr_href,
                attr_width,
                attr_height
            )
            
        Finally, the existence of local variables elementID and attributeID is required.
}
{
    Adds the specified element to the parser, i.e. XML_ADD_ELEMENT(head) adds the element "head" with
    a unique identifier of element_head
}
{
    Adds the specified element to the parser, not using the same string to generate the identifier and
    the element name. Use for element names that contain characters which are illegal in identifiers,
    i.e XML_ADD_COMPLEX_ELEMENT("root-layout",rootlayout) adds the element "root-layout" with a unique
    identifier of element_rootlayout
}
{
    Adds the specified attribute to the current element in the parser, i.e. XML_ADD_ATTRIBUTE(src)
    adds the attribute "src" to the current element, and identifies it by attr_src
}
{
    Adds the specified attribute to the current element in the parser, i.e. XML_ADD_ATTRIBUTE(element_img, src)
    adds the attribute "src" to the element_img element, and identifies it by attr_src
    Adds the specified attribute to the current element in the parser, not using the same string to
    generate the identifier and the element name. Use for attribute names that contain characters which
    are illegal in identifiers, i.e XML_ADD_COMPLEX_ATTRIBUTE("http-equiv",httpequiv) adds the element
    "http-equiv" with a unique identifier of attr_httpequiv
}


{
    General Sequence Grab stuff
}

TYPE
	SeqGrabComponent					= ComponentInstance;
	SGChannel							= ComponentInstance;

CONST
	SeqGrabComponentType		= 'barg';
	SeqGrabChannelType			= 'sgch';
	SeqGrabPanelType			= 'sgpn';
	SeqGrabCompressionPanelType	= 'cmpr';
	SeqGrabSourcePanelType		= 'sour';

	seqGrabToDisk				= 1;
	seqGrabToMemory				= 2;
	seqGrabDontUseTempMemory	= 4;
	seqGrabAppendToFile			= 8;
	seqGrabDontAddMovieResource	= 16;
	seqGrabDontMakeMovie		= 32;
	seqGrabPreExtendFile		= 64;
	seqGrabDataProcIsInterruptSafe = 128;
	seqGrabDataProcDoesOverlappingReads = 256;


TYPE
	SeqGrabDataOutputEnum				= UInt32;

CONST
	seqGrabRecord				= 1;
	seqGrabPreview				= 2;
	seqGrabPlayDuringRecord		= 4;


TYPE
	SeqGrabUsageEnum					= UInt32;

CONST
	seqGrabHasBounds			= 1;
	seqGrabHasVolume			= 2;
	seqGrabHasDiscreteSamples	= 4;
	seqGrabDoNotBufferizeData	= 8;
	seqGrabCanMoveWindowWhileRecording = 16;


TYPE
	SeqGrabChannelInfoEnum				= UInt32;
	SGOutputRecordPtr = ^SGOutputRecord;
	SGOutputRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	SGOutput							= ^SGOutputRecord;
	SeqGrabFrameInfoPtr = ^SeqGrabFrameInfo;
	SeqGrabFrameInfo = RECORD
		frameOffset:			LONGINT;
		frameTime:				LONGINT;
		frameSize:				LONGINT;
		frameChannel:			SGChannel;
		frameRefCon:			LONGINT;
	END;

	SeqGrabExtendedFrameInfoPtr = ^SeqGrabExtendedFrameInfo;
	SeqGrabExtendedFrameInfo = RECORD
		frameOffset:			wide;
		frameTime:				LONGINT;
		frameSize:				LONGINT;
		frameChannel:			SGChannel;
		frameRefCon:			LONGINT;
		frameOutput:			SGOutput;
	END;


CONST
	grabPictOffScreen			= 1;
	grabPictIgnoreClip			= 2;
	grabPictCurrentImage		= 4;

	sgFlagControlledGrab		= $01;
	sgFlagAllowNonRGBPixMaps	= $02;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	SGDataProcPtr = FUNCTION(c: SGChannel; p: Ptr; len: LONGINT; VAR offset: LONGINT; chRefCon: LONGINT; time: TimeValue; writeType: INTEGER; refCon: LONGINT): OSErr;
{$ELSEC}
	SGDataProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	SGDataUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SGDataUPP = UniversalProcPtr;
{$ENDC}	
	SGDeviceNamePtr = ^SGDeviceName;
	SGDeviceName = RECORD
		name:					Str63;
		icon:					Handle;
		flags:					LONGINT;
		refCon:					LONGINT;
		reserved:				LONGINT;								{  zero }
	END;


CONST
	sgDeviceNameFlagDeviceUnavailable = $01;


TYPE
	SGDeviceListRecordPtr = ^SGDeviceListRecord;
	SGDeviceListRecord = RECORD
		count:					INTEGER;
		selectedIndex:			INTEGER;
		reserved:				LONGINT;								{  zero }
		entry:					ARRAY [0..0] OF SGDeviceName;
	END;

	SGDeviceListPtr						= ^SGDeviceListRecord;
	SGDeviceList						= ^SGDeviceListPtr;

CONST
	sgDeviceListWithIcons		= $01;
	sgDeviceListDontCheckAvailability = $02;

	seqGrabWriteAppend			= 0;
	seqGrabWriteReserve			= 1;
	seqGrabWriteFill			= 2;

	seqGrabUnpause				= 0;
	seqGrabPause				= 1;
	seqGrabPauseForMenu			= 3;

	channelFlagDontOpenResFile	= 2;
	channelFlagHasDependency	= 4;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	SGModalFilterProcPtr = FUNCTION(theDialog: DialogRef; {CONST}VAR theEvent: EventRecord; VAR itemHit: INTEGER; refCon: LONGINT): BOOLEAN;
{$ELSEC}
	SGModalFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	SGModalFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SGModalFilterUPP = UniversalProcPtr;
{$ENDC}	

CONST
	sgPanelFlagForPanel			= 1;

	seqGrabSettingsPreviewOnly	= 1;

	channelPlayNormal			= 0;
	channelPlayFast				= 1;
	channelPlayHighQuality		= 2;
	channelPlayAllData			= 4;


	{
	 *  SGInitialize()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION SGInitialize(s: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0001, $7000, $A82A;
	{$ENDC}

{
 *  SGSetDataOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetDataOutput(s: SeqGrabComponent; {CONST}VAR movieFile: FSSpec; whereFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0002, $7000, $A82A;
	{$ENDC}

{
 *  SGGetDataOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetDataOutput(s: SeqGrabComponent; VAR movieFile: FSSpec; VAR whereFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0003, $7000, $A82A;
	{$ENDC}

{
 *  SGSetGWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetGWorld(s: SeqGrabComponent; gp: CGrafPtr; gd: GDHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0004, $7000, $A82A;
	{$ENDC}

{
 *  SGGetGWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetGWorld(s: SeqGrabComponent; VAR gp: CGrafPtr; VAR gd: GDHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0005, $7000, $A82A;
	{$ENDC}

{
 *  SGNewChannel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGNewChannel(s: SeqGrabComponent; channelType: OSType; VAR ref: SGChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0006, $7000, $A82A;
	{$ENDC}

{
 *  SGDisposeChannel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGDisposeChannel(s: SeqGrabComponent; c: SGChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}

{
 *  SGStartPreview()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGStartPreview(s: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0010, $7000, $A82A;
	{$ENDC}

{
 *  SGStartRecord()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGStartRecord(s: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0011, $7000, $A82A;
	{$ENDC}

{
 *  SGIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGIdle(s: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0012, $7000, $A82A;
	{$ENDC}

{
 *  SGStop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGStop(s: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0013, $7000, $A82A;
	{$ENDC}

{
 *  SGPause()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGPause(s: SeqGrabComponent; pause: ByteParameter): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0014, $7000, $A82A;
	{$ENDC}

{
 *  SGPrepare()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGPrepare(s: SeqGrabComponent; prepareForPreview: BOOLEAN; prepareForRecord: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0015, $7000, $A82A;
	{$ENDC}

{
 *  SGRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGRelease(s: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0016, $7000, $A82A;
	{$ENDC}

{
 *  SGGetMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetMovie(s: SeqGrabComponent): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0017, $7000, $A82A;
	{$ENDC}

{
 *  SGSetMaximumRecordTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetMaximumRecordTime(s: SeqGrabComponent; ticks: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}

{
 *  SGGetMaximumRecordTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetMaximumRecordTime(s: SeqGrabComponent; VAR ticks: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0019, $7000, $A82A;
	{$ENDC}

{
 *  SGGetStorageSpaceRemaining()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetStorageSpaceRemaining(s: SeqGrabComponent; VAR bytes: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001A, $7000, $A82A;
	{$ENDC}

{
 *  SGGetTimeRemaining()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetTimeRemaining(s: SeqGrabComponent; VAR ticksLeft: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001B, $7000, $A82A;
	{$ENDC}

{
 *  SGGrabPict()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGrabPict(s: SeqGrabComponent; VAR p: PicHandle; {CONST}VAR bounds: Rect; offscreenDepth: INTEGER; grabPictFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000E, $001C, $7000, $A82A;
	{$ENDC}

{
 *  SGGetLastMovieResID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetLastMovieResID(s: SeqGrabComponent; VAR resID: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001D, $7000, $A82A;
	{$ENDC}

{
 *  SGSetFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetFlags(s: SeqGrabComponent; sgFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001E, $7000, $A82A;
	{$ENDC}

{
 *  SGGetFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetFlags(s: SeqGrabComponent; VAR sgFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $001F, $7000, $A82A;
	{$ENDC}

{
 *  SGSetDataProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetDataProc(s: SeqGrabComponent; proc: SGDataUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0020, $7000, $A82A;
	{$ENDC}

{
 *  SGNewChannelFromComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGNewChannelFromComponent(s: SeqGrabComponent; VAR newChannel: SGChannel; sgChannelComponent: Component): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0021, $7000, $A82A;
	{$ENDC}

{
 *  SGDisposeDeviceList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGDisposeDeviceList(s: SeqGrabComponent; list: SGDeviceList): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0022, $7000, $A82A;
	{$ENDC}

{
 *  SGAppendDeviceListToMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGAppendDeviceListToMenu(s: SeqGrabComponent; list: SGDeviceList; mh: MenuRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0023, $7000, $A82A;
	{$ENDC}

{
 *  SGSetSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetSettings(s: SeqGrabComponent; ud: UserData; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0024, $7000, $A82A;
	{$ENDC}

{
 *  SGGetSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetSettings(s: SeqGrabComponent; VAR ud: UserData; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0025, $7000, $A82A;
	{$ENDC}

{
 *  SGGetIndChannel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetIndChannel(s: SeqGrabComponent; index: INTEGER; VAR ref: SGChannel; VAR chanType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0026, $7000, $A82A;
	{$ENDC}

{
 *  SGUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGUpdate(s: SeqGrabComponent; updateRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0027, $7000, $A82A;
	{$ENDC}

{
 *  SGGetPause()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetPause(s: SeqGrabComponent; VAR paused: Byte): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0028, $7000, $A82A;
	{$ENDC}


TYPE
	ConstComponentListPtr				= ^Component;
	{
	 *  SGSettingsDialog()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION SGSettingsDialog(s: SeqGrabComponent; c: SGChannel; numPanels: INTEGER; panelList: ConstComponentListPtr; flags: LONGINT; proc: SGModalFilterUPP; procRefNum: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0016, $0029, $7000, $A82A;
	{$ENDC}

{
 *  SGGetAlignmentProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetAlignmentProc(s: SeqGrabComponent; alignmentProc: ICMAlignmentProcRecordPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $002A, $7000, $A82A;
	{$ENDC}

{
 *  SGSetChannelSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetChannelSettings(s: SeqGrabComponent; c: SGChannel; ud: UserData; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $002B, $7000, $A82A;
	{$ENDC}

{
 *  SGGetChannelSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetChannelSettings(s: SeqGrabComponent; c: SGChannel; VAR ud: UserData; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $002C, $7000, $A82A;
	{$ENDC}

{
 *  SGGetMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetMode(s: SeqGrabComponent; VAR previewMode: BOOLEAN; VAR recordMode: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002D, $7000, $A82A;
	{$ENDC}

{
 *  SGSetDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetDataRef(s: SeqGrabComponent; dataRef: Handle; dataRefType: OSType; whereFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $002E, $7000, $A82A;
	{$ENDC}

{
 *  SGGetDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetDataRef(s: SeqGrabComponent; VAR dataRef: Handle; VAR dataRefType: OSType; VAR whereFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $002F, $7000, $A82A;
	{$ENDC}

{
 *  SGNewOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGNewOutput(s: SeqGrabComponent; dataRef: Handle; dataRefType: OSType; whereFlags: LONGINT; VAR sgOut: SGOutput): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0030, $7000, $A82A;
	{$ENDC}

{
 *  SGDisposeOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGDisposeOutput(s: SeqGrabComponent; sgOut: SGOutput): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0031, $7000, $A82A;
	{$ENDC}

{
 *  SGSetOutputFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetOutputFlags(s: SeqGrabComponent; sgOut: SGOutput; whereFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0032, $7000, $A82A;
	{$ENDC}

{
 *  SGSetChannelOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetChannelOutput(s: SeqGrabComponent; c: SGChannel; sgOut: SGOutput): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0033, $7000, $A82A;
	{$ENDC}

{
 *  SGGetDataOutputStorageSpaceRemaining()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetDataOutputStorageSpaceRemaining(s: SeqGrabComponent; sgOut: SGOutput; VAR space: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0034, $7000, $A82A;
	{$ENDC}

{
 *  SGHandleUpdateEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGHandleUpdateEvent(s: SeqGrabComponent; {CONST}VAR event: EventRecord; VAR handled: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0035, $7000, $A82A;
	{$ENDC}

{
 *  SGSetOutputNextOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetOutputNextOutput(s: SeqGrabComponent; sgOut: SGOutput; nextOut: SGOutput): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0036, $7000, $A82A;
	{$ENDC}

{
 *  SGGetOutputNextOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetOutputNextOutput(s: SeqGrabComponent; sgOut: SGOutput; VAR nextOut: SGOutput): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0037, $7000, $A82A;
	{$ENDC}

{
 *  SGSetOutputMaximumOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetOutputMaximumOffset(s: SeqGrabComponent; sgOut: SGOutput; {CONST}VAR maxOffset: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0038, $7000, $A82A;
	{$ENDC}

{
 *  SGGetOutputMaximumOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetOutputMaximumOffset(s: SeqGrabComponent; sgOut: SGOutput; VAR maxOffset: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0039, $7000, $A82A;
	{$ENDC}

{
 *  SGGetOutputDataReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetOutputDataReference(s: SeqGrabComponent; sgOut: SGOutput; VAR dataRef: Handle; VAR dataRefType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $003A, $7000, $A82A;
	{$ENDC}

{
 *  SGWriteExtendedMovieData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGWriteExtendedMovieData(s: SeqGrabComponent; c: SGChannel; p: Ptr; len: LONGINT; VAR offset: wide; VAR sgOut: SGOutput): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $003B, $7000, $A82A;
	{$ENDC}

{
 *  SGGetStorageSpaceRemaining64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION SGGetStorageSpaceRemaining64(s: SeqGrabComponent; VAR bytes: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $003C, $7000, $A82A;
	{$ENDC}

{
 *  SGGetDataOutputStorageSpaceRemaining64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION SGGetDataOutputStorageSpaceRemaining64(s: SeqGrabComponent; sgOut: SGOutput; VAR space: wide): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $003D, $7000, $A82A;
	{$ENDC}

{
    calls from Channel to seqGrab
}
{
 *  SGWriteMovieData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGWriteMovieData(s: SeqGrabComponent; c: SGChannel; p: Ptr; len: LONGINT; VAR offset: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0100, $7000, $A82A;
	{$ENDC}

{
 *  SGAddFrameReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGAddFrameReference(s: SeqGrabComponent; frameInfo: SeqGrabFrameInfoPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}

{
 *  SGGetNextFrameReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetNextFrameReference(s: SeqGrabComponent; frameInfo: SeqGrabFrameInfoPtr; VAR frameDuration: TimeValue; VAR frameNumber: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0102, $7000, $A82A;
	{$ENDC}

{
 *  SGGetTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetTimeBase(s: SeqGrabComponent; VAR tb: TimeBase): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}

{
 *  SGSortDeviceList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSortDeviceList(s: SeqGrabComponent; list: SGDeviceList): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0104, $7000, $A82A;
	{$ENDC}

{
 *  SGAddMovieData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGAddMovieData(s: SeqGrabComponent; c: SGChannel; p: Ptr; len: LONGINT; VAR offset: LONGINT; chRefCon: LONGINT; time: TimeValue; writeType: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001A, $0105, $7000, $A82A;
	{$ENDC}

{
 *  SGChangedSource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGChangedSource(s: SeqGrabComponent; c: SGChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0106, $7000, $A82A;
	{$ENDC}

{
 *  SGAddExtendedFrameReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGAddExtendedFrameReference(s: SeqGrabComponent; frameInfo: SeqGrabExtendedFrameInfoPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0107, $7000, $A82A;
	{$ENDC}

{
 *  SGGetNextExtendedFrameReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetNextExtendedFrameReference(s: SeqGrabComponent; frameInfo: SeqGrabExtendedFrameInfoPtr; VAR frameDuration: TimeValue; VAR frameNumber: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0108, $7000, $A82A;
	{$ENDC}

{
 *  SGAddExtendedMovieData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGAddExtendedMovieData(s: SeqGrabComponent; c: SGChannel; p: Ptr; len: LONGINT; VAR offset: wide; chRefCon: LONGINT; time: TimeValue; writeType: INTEGER; VAR whichOutput: SGOutput): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001E, $0109, $7000, $A82A;
	{$ENDC}

{
 *  SGAddOutputDataRefToMedia()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGAddOutputDataRefToMedia(s: SeqGrabComponent; sgOut: SGOutput; theMedia: Media; desc: SampleDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $010A, $7000, $A82A;
	{$ENDC}



{** Sequence Grab CHANNEL Component Stuff **}

{
 *  SGSetChannelUsage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetChannelUsage(c: SGChannel; usage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0080, $7000, $A82A;
	{$ENDC}

{
 *  SGGetChannelUsage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetChannelUsage(c: SGChannel; VAR usage: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0081, $7000, $A82A;
	{$ENDC}

{
 *  SGSetChannelBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetChannelBounds(c: SGChannel; {CONST}VAR bounds: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0082, $7000, $A82A;
	{$ENDC}

{
 *  SGGetChannelBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetChannelBounds(c: SGChannel; VAR bounds: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0083, $7000, $A82A;
	{$ENDC}

{
 *  SGSetChannelVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetChannelVolume(c: SGChannel; volume: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0084, $7000, $A82A;
	{$ENDC}

{
 *  SGGetChannelVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetChannelVolume(c: SGChannel; VAR volume: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0085, $7000, $A82A;
	{$ENDC}

{
 *  SGGetChannelInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetChannelInfo(c: SGChannel; VAR channelInfo: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0086, $7000, $A82A;
	{$ENDC}

{
 *  SGSetChannelPlayFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetChannelPlayFlags(c: SGChannel; playFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0087, $7000, $A82A;
	{$ENDC}

{
 *  SGGetChannelPlayFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetChannelPlayFlags(c: SGChannel; VAR playFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0088, $7000, $A82A;
	{$ENDC}

{
 *  SGSetChannelMaxFrames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetChannelMaxFrames(c: SGChannel; frameCount: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0089, $7000, $A82A;
	{$ENDC}

{
 *  SGGetChannelMaxFrames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetChannelMaxFrames(c: SGChannel; VAR frameCount: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008A, $7000, $A82A;
	{$ENDC}

{
 *  SGSetChannelRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetChannelRefCon(c: SGChannel; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008B, $7000, $A82A;
	{$ENDC}

{
 *  SGSetChannelClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetChannelClip(c: SGChannel; theClip: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008C, $7000, $A82A;
	{$ENDC}

{
 *  SGGetChannelClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetChannelClip(c: SGChannel; VAR theClip: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008D, $7000, $A82A;
	{$ENDC}

{
 *  SGGetChannelSampleDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetChannelSampleDescription(c: SGChannel; sampleDesc: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $008E, $7000, $A82A;
	{$ENDC}

{
 *  SGGetChannelDeviceList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetChannelDeviceList(c: SGChannel; selectionFlags: LONGINT; VAR list: SGDeviceList): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $008F, $7000, $A82A;
	{$ENDC}

{
 *  SGSetChannelDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetChannelDevice(c: SGChannel; name: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0090, $7000, $A82A;
	{$ENDC}

{
 *  SGSetChannelMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetChannelMatrix(c: SGChannel; {CONST}VAR m: MatrixRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0091, $7000, $A82A;
	{$ENDC}

{
 *  SGGetChannelMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetChannelMatrix(c: SGChannel; VAR m: MatrixRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0092, $7000, $A82A;
	{$ENDC}

{
 *  SGGetChannelTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetChannelTimeScale(c: SGChannel; VAR scale: TimeScale): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0093, $7000, $A82A;
	{$ENDC}

{
 *  SGChannelPutPicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGChannelPutPicture(c: SGChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0094, $7000, $A82A;
	{$ENDC}

{
 *  SGChannelSetRequestedDataRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGChannelSetRequestedDataRate(c: SGChannel; bytesPerSecond: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0095, $7000, $A82A;
	{$ENDC}

{
 *  SGChannelGetRequestedDataRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGChannelGetRequestedDataRate(c: SGChannel; VAR bytesPerSecond: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0096, $7000, $A82A;
	{$ENDC}

{
 *  SGChannelSetDataSourceName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGChannelSetDataSourceName(c: SGChannel; name: Str255; scriptTag: ScriptCode): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0097, $7000, $A82A;
	{$ENDC}

{
 *  SGChannelGetDataSourceName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGChannelGetDataSourceName(c: SGChannel; VAR name: Str255; VAR scriptTag: ScriptCode): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0098, $7000, $A82A;
	{$ENDC}

{
 *  SGChannelSetCodecSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION SGChannelSetCodecSettings(c: SGChannel; settings: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0099, $7000, $A82A;
	{$ENDC}

{
 *  SGChannelGetCodecSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION SGChannelGetCodecSettings(c: SGChannel; VAR settings: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $009A, $7000, $A82A;
	{$ENDC}

{
 *  SGGetChannelTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION SGGetChannelTimeBase(c: SGChannel; VAR tb: TimeBase): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $009B, $7000, $A82A;
	{$ENDC}

{
    calls from seqGrab to Channel
}
{
 *  SGInitChannel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGInitChannel(c: SGChannel; owner: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0180, $7000, $A82A;
	{$ENDC}

{
 *  SGWriteSamples()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGWriteSamples(c: SGChannel; m: Movie; theFile: AliasHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0181, $7000, $A82A;
	{$ENDC}

{
 *  SGGetDataRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetDataRate(c: SGChannel; VAR bytesPerSecond: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0182, $7000, $A82A;
	{$ENDC}

{
 *  SGAlignChannelRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGAlignChannelRect(c: SGChannel; VAR r: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0183, $7000, $A82A;
	{$ENDC}

{
    Dorky dialog panel calls
}
{
 *  SGPanelGetDitl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGPanelGetDitl(s: SeqGrabComponent; VAR ditl: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0200, $7000, $A82A;
	{$ENDC}

{
 *  SGPanelGetTitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGPanelGetTitle(s: SeqGrabComponent; VAR title: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0201, $7000, $A82A;
	{$ENDC}

{
 *  SGPanelCanRun()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGPanelCanRun(s: SeqGrabComponent; c: SGChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0202, $7000, $A82A;
	{$ENDC}

{
 *  SGPanelInstall()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGPanelInstall(s: SeqGrabComponent; c: SGChannel; d: DialogRef; itemOffset: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0203, $7000, $A82A;
	{$ENDC}

{
 *  SGPanelEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGPanelEvent(s: SeqGrabComponent; c: SGChannel; d: DialogRef; itemOffset: INTEGER; {CONST}VAR theEvent: EventRecord; VAR itemHit: INTEGER; VAR handled: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0016, $0204, $7000, $A82A;
	{$ENDC}

{
 *  SGPanelItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGPanelItem(s: SeqGrabComponent; c: SGChannel; d: DialogRef; itemOffset: INTEGER; itemNum: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0205, $7000, $A82A;
	{$ENDC}

{
 *  SGPanelRemove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGPanelRemove(s: SeqGrabComponent; c: SGChannel; d: DialogRef; itemOffset: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0206, $7000, $A82A;
	{$ENDC}

{
 *  SGPanelSetGrabber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGPanelSetGrabber(s: SeqGrabComponent; sg: SeqGrabComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0207, $7000, $A82A;
	{$ENDC}

{
 *  SGPanelSetResFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGPanelSetResFile(s: SeqGrabComponent; resRef: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0208, $7000, $A82A;
	{$ENDC}

{
 *  SGPanelGetSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGPanelGetSettings(s: SeqGrabComponent; c: SGChannel; VAR ud: UserData; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0209, $7000, $A82A;
	{$ENDC}

{
 *  SGPanelSetSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGPanelSetSettings(s: SeqGrabComponent; c: SGChannel; ud: UserData; flags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $020A, $7000, $A82A;
	{$ENDC}

{
 *  SGPanelValidateInput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGPanelValidateInput(s: SeqGrabComponent; VAR ok: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $020B, $7000, $A82A;
	{$ENDC}

{
 *  SGPanelSetEventFilter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGPanelSetEventFilter(s: SeqGrabComponent; proc: SGModalFilterUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $020C, $7000, $A82A;
	{$ENDC}


{** Sequence Grab VIDEO CHANNEL Component Stuff **}
{
    Video stuff
}

TYPE
	SGCompressInfoPtr = ^SGCompressInfo;
	SGCompressInfo = RECORD
		buffer:					Ptr;
		bufferSize:				UInt32;
		similarity:				SInt8;
		reserved:				SInt8;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	SGGrabBottleProcPtr = FUNCTION(c: SGChannel; bufferNum: INTEGER; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGGrabBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGGrabCompleteBottleProcPtr = FUNCTION(c: SGChannel; bufferNum: INTEGER; VAR done: BOOLEAN; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGGrabCompleteBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGDisplayBottleProcPtr = FUNCTION(c: SGChannel; bufferNum: INTEGER; VAR mp: MatrixRecord; clipRgn: RgnHandle; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGDisplayBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGCompressBottleProcPtr = FUNCTION(c: SGChannel; bufferNum: INTEGER; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGCompressBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGCompressCompleteBottleProcPtr = FUNCTION(c: SGChannel; bufferNum: INTEGER; VAR done: BOOLEAN; VAR ci: SGCompressInfo; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGCompressCompleteBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGAddFrameBottleProcPtr = FUNCTION(c: SGChannel; bufferNum: INTEGER; atTime: TimeValue; scale: TimeScale; {CONST}VAR ci: SGCompressInfo; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGAddFrameBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGTransferFrameBottleProcPtr = FUNCTION(c: SGChannel; bufferNum: INTEGER; VAR mp: MatrixRecord; clipRgn: RgnHandle; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGTransferFrameBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGGrabCompressCompleteBottleProcPtr = FUNCTION(c: SGChannel; VAR done: BOOLEAN; VAR ci: SGCompressInfo; VAR t: TimeRecord; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGGrabCompressCompleteBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	SGDisplayCompressBottleProcPtr = FUNCTION(c: SGChannel; dataPtr: Ptr; desc: ImageDescriptionHandle; VAR mp: MatrixRecord; clipRgn: RgnHandle; refCon: LONGINT): ComponentResult;
{$ELSEC}
	SGDisplayCompressBottleProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	SGGrabBottleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SGGrabBottleUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	SGGrabCompleteBottleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SGGrabCompleteBottleUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	SGDisplayBottleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SGDisplayBottleUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	SGCompressBottleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SGCompressBottleUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	SGCompressCompleteBottleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SGCompressCompleteBottleUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	SGAddFrameBottleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SGAddFrameBottleUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	SGTransferFrameBottleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SGTransferFrameBottleUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	SGGrabCompressCompleteBottleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SGGrabCompressCompleteBottleUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	SGDisplayCompressBottleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	SGDisplayCompressBottleUPP = UniversalProcPtr;
{$ENDC}	
	VideoBottlesPtr = ^VideoBottles;
	VideoBottles = RECORD
		procCount:				INTEGER;
		grabProc:				SGGrabBottleUPP;
		grabCompleteProc:		SGGrabCompleteBottleUPP;
		displayProc:			SGDisplayBottleUPP;
		compressProc:			SGCompressBottleUPP;
		compressCompleteProc:	SGCompressCompleteBottleUPP;
		addFrameProc:			SGAddFrameBottleUPP;
		transferFrameProc:		SGTransferFrameBottleUPP;
		grabCompressCompleteProc: SGGrabCompressCompleteBottleUPP;
		displayCompressProc:	SGDisplayCompressBottleUPP;
	END;

	{
	 *  SGGetSrcVideoBounds()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION SGGetSrcVideoBounds(c: SGChannel; VAR r: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0100, $7000, $A82A;
	{$ENDC}

{
 *  SGSetVideoRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetVideoRect(c: SGChannel; {CONST}VAR r: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}

{
 *  SGGetVideoRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetVideoRect(c: SGChannel; VAR r: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}

{
 *  SGGetVideoCompressorType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetVideoCompressorType(c: SGChannel; VAR compressorType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}

{
 *  SGSetVideoCompressorType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetVideoCompressorType(c: SGChannel; compressorType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0104, $7000, $A82A;
	{$ENDC}

{
 *  SGSetVideoCompressor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetVideoCompressor(c: SGChannel; depth: INTEGER; compressor: CompressorComponent; spatialQuality: CodecQ; temporalQuality: CodecQ; keyFrameRate: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0012, $0105, $7000, $A82A;
	{$ENDC}

{
 *  SGGetVideoCompressor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetVideoCompressor(c: SGChannel; VAR depth: INTEGER; VAR compressor: CompressorComponent; VAR spatialQuality: CodecQ; VAR temporalQuality: CodecQ; VAR keyFrameRate: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0106, $7000, $A82A;
	{$ENDC}

{
 *  SGGetVideoDigitizerComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetVideoDigitizerComponent(c: SGChannel): ComponentInstance;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0107, $7000, $A82A;
	{$ENDC}

{
 *  SGSetVideoDigitizerComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetVideoDigitizerComponent(c: SGChannel; vdig: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0108, $7000, $A82A;
	{$ENDC}

{
 *  SGVideoDigitizerChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGVideoDigitizerChanged(c: SGChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0109, $7000, $A82A;
	{$ENDC}

{
 *  SGSetVideoBottlenecks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetVideoBottlenecks(c: SGChannel; VAR vb: VideoBottles): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010A, $7000, $A82A;
	{$ENDC}

{
 *  SGGetVideoBottlenecks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetVideoBottlenecks(c: SGChannel; VAR vb: VideoBottles): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010B, $7000, $A82A;
	{$ENDC}

{
 *  SGGrabFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGrabFrame(c: SGChannel; bufferNum: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $010C, $7000, $A82A;
	{$ENDC}

{
 *  SGGrabFrameComplete()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGrabFrameComplete(c: SGChannel; bufferNum: INTEGER; VAR done: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $010D, $7000, $A82A;
	{$ENDC}

{
 *  SGDisplayFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGDisplayFrame(c: SGChannel; bufferNum: INTEGER; {CONST}VAR mp: MatrixRecord; clipRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $010E, $7000, $A82A;
	{$ENDC}

{
 *  SGCompressFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGCompressFrame(c: SGChannel; bufferNum: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $010F, $7000, $A82A;
	{$ENDC}

{
 *  SGCompressFrameComplete()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGCompressFrameComplete(c: SGChannel; bufferNum: INTEGER; VAR done: BOOLEAN; VAR ci: SGCompressInfo): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0110, $7000, $A82A;
	{$ENDC}

{
 *  SGAddFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGAddFrame(c: SGChannel; bufferNum: INTEGER; atTime: TimeValue; scale: TimeScale; {CONST}VAR ci: SGCompressInfo): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000E, $0111, $7000, $A82A;
	{$ENDC}

{
 *  SGTransferFrameForCompress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGTransferFrameForCompress(c: SGChannel; bufferNum: INTEGER; {CONST}VAR mp: MatrixRecord; clipRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0112, $7000, $A82A;
	{$ENDC}

{
 *  SGSetCompressBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetCompressBuffer(c: SGChannel; depth: INTEGER; {CONST}VAR compressSize: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0113, $7000, $A82A;
	{$ENDC}

{
 *  SGGetCompressBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetCompressBuffer(c: SGChannel; VAR depth: INTEGER; VAR compressSize: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0114, $7000, $A82A;
	{$ENDC}

{
 *  SGGetBufferInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetBufferInfo(c: SGChannel; bufferNum: INTEGER; VAR bufferPM: PixMapHandle; VAR bufferRect: Rect; VAR compressBuffer: GWorldPtr; VAR compressBufferRect: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0012, $0115, $7000, $A82A;
	{$ENDC}

{
 *  SGSetUseScreenBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetUseScreenBuffer(c: SGChannel; useScreenBuffer: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0116, $7000, $A82A;
	{$ENDC}

{
 *  SGGetUseScreenBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetUseScreenBuffer(c: SGChannel; VAR useScreenBuffer: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0117, $7000, $A82A;
	{$ENDC}

{
 *  SGGrabCompressComplete()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGrabCompressComplete(c: SGChannel; VAR done: BOOLEAN; VAR ci: SGCompressInfo; VAR tr: TimeRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0118, $7000, $A82A;
	{$ENDC}

{
 *  SGDisplayCompress()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGDisplayCompress(c: SGChannel; dataPtr: Ptr; desc: ImageDescriptionHandle; VAR mp: MatrixRecord; clipRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0119, $7000, $A82A;
	{$ENDC}

{
 *  SGSetFrameRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetFrameRate(c: SGChannel; frameRate: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $011A, $7000, $A82A;
	{$ENDC}

{
 *  SGGetFrameRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetFrameRate(c: SGChannel; VAR frameRate: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $011B, $7000, $A82A;
	{$ENDC}


{
 *  SGSetPreferredPacketSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetPreferredPacketSize(c: SGChannel; preferredPacketSizeInBytes: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0121, $7000, $A82A;
	{$ENDC}

{
 *  SGGetPreferredPacketSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetPreferredPacketSize(c: SGChannel; VAR preferredPacketSizeInBytes: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0122, $7000, $A82A;
	{$ENDC}

{
 *  SGSetUserVideoCompressorList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetUserVideoCompressorList(c: SGChannel; compressorTypes: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0123, $7000, $A82A;
	{$ENDC}

{
 *  SGGetUserVideoCompressorList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetUserVideoCompressorList(c: SGChannel; VAR compressorTypes: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0124, $7000, $A82A;
	{$ENDC}

{** Sequence Grab SOUND CHANNEL Component Stuff **}

{
    Sound stuff
}
{
 *  SGSetSoundInputDriver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetSoundInputDriver(c: SGChannel; driverName: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0100, $7000, $A82A;
	{$ENDC}

{
 *  SGGetSoundInputDriver()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetSoundInputDriver(c: SGChannel): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0101, $7000, $A82A;
	{$ENDC}

{
 *  SGSoundInputDriverChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSoundInputDriverChanged(c: SGChannel): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0102, $7000, $A82A;
	{$ENDC}

{
 *  SGSetSoundRecordChunkSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetSoundRecordChunkSize(c: SGChannel; seconds: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}

{
 *  SGGetSoundRecordChunkSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetSoundRecordChunkSize(c: SGChannel): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0104, $7000, $A82A;
	{$ENDC}

{
 *  SGSetSoundInputRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetSoundInputRate(c: SGChannel; rate: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0105, $7000, $A82A;
	{$ENDC}

{
 *  SGGetSoundInputRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetSoundInputRate(c: SGChannel): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0106, $7000, $A82A;
	{$ENDC}

{
 *  SGSetSoundInputParameters()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetSoundInputParameters(c: SGChannel; sampleSize: INTEGER; numChannels: INTEGER; compressionType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0107, $7000, $A82A;
	{$ENDC}

{
 *  SGGetSoundInputParameters()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetSoundInputParameters(c: SGChannel; VAR sampleSize: INTEGER; VAR numChannels: INTEGER; VAR compressionType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0108, $7000, $A82A;
	{$ENDC}

{
 *  SGSetAdditionalSoundRates()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetAdditionalSoundRates(c: SGChannel; rates: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0109, $7000, $A82A;
	{$ENDC}

{
 *  SGGetAdditionalSoundRates()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetAdditionalSoundRates(c: SGChannel; VAR rates: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010A, $7000, $A82A;
	{$ENDC}

{
    Text stuff
}
{
 *  SGSetFontName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetFontName(c: SGChannel; pstr: StringPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0100, $7000, $A82A;
	{$ENDC}

{
 *  SGSetFontSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetFontSize(c: SGChannel; fontSize: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0101, $7000, $A82A;
	{$ENDC}

{
 *  SGSetTextForeColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetTextForeColor(c: SGChannel; VAR theColor: RGBColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}

{
 *  SGSetTextBackColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetTextBackColor(c: SGChannel; VAR theColor: RGBColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}

{
 *  SGSetJustification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetJustification(c: SGChannel; just: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0104, $7000, $A82A;
	{$ENDC}

{
 *  SGGetTextReturnToSpaceValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetTextReturnToSpaceValue(c: SGChannel; VAR rettospace: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0105, $7000, $A82A;
	{$ENDC}

{
 *  SGSetTextReturnToSpaceValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetTextReturnToSpaceValue(c: SGChannel; rettospace: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0106, $7000, $A82A;
	{$ENDC}

{
    Music stuff
}
{
 *  SGGetInstrument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGGetInstrument(c: SGChannel; VAR td: ToneDescription): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0100, $7000, $A82A;
	{$ENDC}

{
 *  SGSetInstrument()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SGSetInstrument(c: SGChannel; VAR td: ToneDescription): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}



CONST
	sgChannelAtom				= 'chan';
	sgChannelSettingsAtom		= 'ctom';
	sgChannelDescription		= 'cdsc';
	sgChannelSettings			= 'cset';

	sgDeviceNameType			= 'name';
	sgUsageType					= 'use ';
	sgPlayFlagsType				= 'plyf';
	sgClipType					= 'clip';
	sgMatrixType				= 'mtrx';
	sgVolumeType				= 'volu';

	sgPanelSettingsAtom			= 'ptom';
	sgPanelDescription			= 'pdsc';
	sgPanelSettings				= 'pset';

	sgcSoundCompressionType		= 'scmp';
	sgcSoundSampleRateType		= 'srat';
	sgcSoundChannelCountType	= 'schn';
	sgcSoundSampleSizeType		= 'ssiz';
	sgcSoundInputType			= 'sinp';
	sgcSoundGainType			= 'gain';

	sgcVideoHueType				= 'hue ';
	sgcVideoSaturationType		= 'satr';
	sgcVideoContrastType		= 'trst';
	sgcVideoSharpnessType		= 'shrp';
	sgcVideoBrigtnessType		= 'brit';
	sgcVideoBlackLevelType		= 'blkl';
	sgcVideoWhiteLevelType		= 'whtl';
	sgcVideoInputType			= 'vinp';
	sgcVideoFormatType			= 'vstd';
	sgcVideoFilterType			= 'vflt';
	sgcVideoRectType			= 'vrct';
	sgcVideoDigitizerType		= 'vdig';





TYPE
	QTVideoOutputComponent				= ComponentInstance;
	{  Component type and subtype enumerations }

CONST
	QTVideoOutputComponentType	= 'vout';
	QTVideoOutputComponentBaseSubType = 'base';


	{  QTVideoOutput Component flags }

	kQTVideoOutputDontDisplayToUser = $00000001;

	{  Display mode atom types }

	kQTVODisplayModeItem		= 'qdmi';
	kQTVODimensions				= 'dimn';						{  atom contains two longs - pixel count - width, height }
	kQTVOResolution				= 'resl';						{  atom contains two Fixed - hRes, vRes in dpi }
	kQTVORefreshRate			= 'refr';						{  atom contains one Fixed - refresh rate in Hz }
	kQTVOPixelType				= 'pixl';						{  atom contains one OSType - pixel format of mode }
	kQTVOName					= 'name';						{  atom contains string (no length byte) - name of mode for display to user }
	kQTVODecompressors			= 'deco';						{  atom contains other atoms indicating supported decompressors }
																{  kQTVODecompressors sub-atoms }
	kQTVODecompressorType		= 'dety';						{  atom contains one OSType - decompressor type code }
	kQTVODecompressorContinuous	= 'cont';						{  atom contains one Boolean - true if this type is displayed continuously }
	kQTVODecompressorComponent	= 'cmpt';						{  atom contains one Component - component id of decompressor }

	{	* These are QTVideoOutput procedures *	}
	{
	 *  QTVideoOutputGetDisplayModeList()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION QTVideoOutputGetDisplayModeList(vo: QTVideoOutputComponent; VAR outputs: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0001, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputGetCurrentClientName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTVideoOutputGetCurrentClientName(vo: QTVideoOutputComponent; VAR str: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0002, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputSetClientName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTVideoOutputSetClientName(vo: QTVideoOutputComponent; str: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputGetClientName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTVideoOutputGetClientName(vo: QTVideoOutputComponent; VAR str: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputBegin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTVideoOutputBegin(vo: QTVideoOutputComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0005, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputEnd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTVideoOutputEnd(vo: QTVideoOutputComponent): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0006, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputSetDisplayMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTVideoOutputSetDisplayMode(vo: QTVideoOutputComponent; displayModeID: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputGetDisplayMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTVideoOutputGetDisplayMode(vo: QTVideoOutputComponent; VAR displayModeID: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0008, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputCustomConfigureDisplay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTVideoOutputCustomConfigureDisplay(vo: QTVideoOutputComponent; filter: ModalFilterUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0009, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputSaveState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTVideoOutputSaveState(vo: QTVideoOutputComponent; VAR state: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000A, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputRestoreState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTVideoOutputRestoreState(vo: QTVideoOutputComponent; state: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000B, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputGetGWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTVideoOutputGetGWorld(vo: QTVideoOutputComponent; VAR gw: GWorldPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputGetGWorldParameters()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTVideoOutputGetGWorldParameters(vo: QTVideoOutputComponent; VAR baseAddr: Ptr; VAR rowBytes: LONGINT; VAR colorTable: CTabHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $000D, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputGetIndSoundOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTVideoOutputGetIndSoundOutput(vo: QTVideoOutputComponent; index: LONGINT; VAR outputComponent: Component): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $000E, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputGetClock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTVideoOutputGetClock(vo: QTVideoOutputComponent; VAR clock: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000F, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputSetEchoPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTVideoOutputSetEchoPort(vo: QTVideoOutputComponent; echoPort: CGrafPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0010, $7000, $A82A;
	{$ENDC}

{
 *  QTVideoOutputGetIndImageDecompressor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION QTVideoOutputGetIndImageDecompressor(vo: QTVideoOutputComponent; index: LONGINT; VAR codec: Component): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0011, $7000, $A82A;
	{$ENDC}

{ UPP call backs }

CONST
	uppDataHCompletionProcInfo = $00000BC0;
	uppVdigIntProcInfo = $000003C0;
	uppStartDocumentHandlerProcInfo = $000000F0;
	uppEndDocumentHandlerProcInfo = $000000F0;
	uppStartElementHandlerProcInfo = $00000FF0;
	uppEndElementHandlerProcInfo = $000003F0;
	uppCharDataHandlerProcInfo = $000003F0;
	uppPreprocessInstructionHandlerProcInfo = $00000FF0;
	uppCommentHandlerProcInfo = $000003F0;
	uppSGDataProcInfo = $003BFFE0;
	uppSGModalFilterProcInfo = $00003FD0;
	uppSGGrabBottleProcInfo = $00000EF0;
	uppSGGrabCompleteBottleProcInfo = $00003EF0;
	uppSGDisplayBottleProcInfo = $0000FEF0;
	uppSGCompressBottleProcInfo = $00000EF0;
	uppSGCompressCompleteBottleProcInfo = $0000FEF0;
	uppSGAddFrameBottleProcInfo = $0003FEF0;
	uppSGTransferFrameBottleProcInfo = $0000FEF0;
	uppSGGrabCompressCompleteBottleProcInfo = $0000FFF0;
	uppSGDisplayCompressBottleProcInfo = $0003FFF0;
	{
	 *  NewDataHCompletionUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewDataHCompletionUPP(userRoutine: DataHCompletionProcPtr): DataHCompletionUPP; { old name was NewDataHCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewVdigIntUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewVdigIntUPP(userRoutine: VdigIntProcPtr): VdigIntUPP; { old name was NewVdigIntProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewStartDocumentHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewStartDocumentHandlerUPP(userRoutine: StartDocumentHandler): StartDocumentHandlerUPP; { old name was NewStartDocumentHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewEndDocumentHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewEndDocumentHandlerUPP(userRoutine: EndDocumentHandler): EndDocumentHandlerUPP; { old name was NewEndDocumentHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewStartElementHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewStartElementHandlerUPP(userRoutine: StartElementHandler): StartElementHandlerUPP; { old name was NewStartElementHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewEndElementHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewEndElementHandlerUPP(userRoutine: EndElementHandler): EndElementHandlerUPP; { old name was NewEndElementHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewCharDataHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewCharDataHandlerUPP(userRoutine: CharDataHandler): CharDataHandlerUPP; { old name was NewCharDataHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewPreprocessInstructionHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewPreprocessInstructionHandlerUPP(userRoutine: PreprocessInstructionHandler): PreprocessInstructionHandlerUPP; { old name was NewPreprocessInstructionHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewCommentHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewCommentHandlerUPP(userRoutine: CommentHandler): CommentHandlerUPP; { old name was NewCommentHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewSGDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewSGDataUPP(userRoutine: SGDataProcPtr): SGDataUPP; { old name was NewSGDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewSGModalFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewSGModalFilterUPP(userRoutine: SGModalFilterProcPtr): SGModalFilterUPP; { old name was NewSGModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewSGGrabBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewSGGrabBottleUPP(userRoutine: SGGrabBottleProcPtr): SGGrabBottleUPP; { old name was NewSGGrabBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewSGGrabCompleteBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewSGGrabCompleteBottleUPP(userRoutine: SGGrabCompleteBottleProcPtr): SGGrabCompleteBottleUPP; { old name was NewSGGrabCompleteBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewSGDisplayBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewSGDisplayBottleUPP(userRoutine: SGDisplayBottleProcPtr): SGDisplayBottleUPP; { old name was NewSGDisplayBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewSGCompressBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewSGCompressBottleUPP(userRoutine: SGCompressBottleProcPtr): SGCompressBottleUPP; { old name was NewSGCompressBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewSGCompressCompleteBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewSGCompressCompleteBottleUPP(userRoutine: SGCompressCompleteBottleProcPtr): SGCompressCompleteBottleUPP; { old name was NewSGCompressCompleteBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewSGAddFrameBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewSGAddFrameBottleUPP(userRoutine: SGAddFrameBottleProcPtr): SGAddFrameBottleUPP; { old name was NewSGAddFrameBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewSGTransferFrameBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewSGTransferFrameBottleUPP(userRoutine: SGTransferFrameBottleProcPtr): SGTransferFrameBottleUPP; { old name was NewSGTransferFrameBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewSGGrabCompressCompleteBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewSGGrabCompressCompleteBottleUPP(userRoutine: SGGrabCompressCompleteBottleProcPtr): SGGrabCompressCompleteBottleUPP; { old name was NewSGGrabCompressCompleteBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewSGDisplayCompressBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewSGDisplayCompressBottleUPP(userRoutine: SGDisplayCompressBottleProcPtr): SGDisplayCompressBottleUPP; { old name was NewSGDisplayCompressBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeDataHCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDataHCompletionUPP(userUPP: DataHCompletionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeVdigIntUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeVdigIntUPP(userUPP: VdigIntUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeStartDocumentHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeStartDocumentHandlerUPP(userUPP: StartDocumentHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeEndDocumentHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeEndDocumentHandlerUPP(userUPP: EndDocumentHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeStartElementHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeStartElementHandlerUPP(userUPP: StartElementHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeEndElementHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeEndElementHandlerUPP(userUPP: EndElementHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeCharDataHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeCharDataHandlerUPP(userUPP: CharDataHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposePreprocessInstructionHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposePreprocessInstructionHandlerUPP(userUPP: PreprocessInstructionHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeCommentHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeCommentHandlerUPP(userUPP: CommentHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeSGDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSGDataUPP(userUPP: SGDataUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeSGModalFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSGModalFilterUPP(userUPP: SGModalFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeSGGrabBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSGGrabBottleUPP(userUPP: SGGrabBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeSGGrabCompleteBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSGGrabCompleteBottleUPP(userUPP: SGGrabCompleteBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeSGDisplayBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSGDisplayBottleUPP(userUPP: SGDisplayBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeSGCompressBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSGCompressBottleUPP(userUPP: SGCompressBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeSGCompressCompleteBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSGCompressCompleteBottleUPP(userUPP: SGCompressCompleteBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeSGAddFrameBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSGAddFrameBottleUPP(userUPP: SGAddFrameBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeSGTransferFrameBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSGTransferFrameBottleUPP(userUPP: SGTransferFrameBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeSGGrabCompressCompleteBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSGGrabCompressCompleteBottleUPP(userUPP: SGGrabCompressCompleteBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeSGDisplayCompressBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeSGDisplayCompressBottleUPP(userUPP: SGDisplayCompressBottleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeDataHCompletionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDataHCompletionUPP(request: Ptr; refcon: LONGINT; err: OSErr; userRoutine: DataHCompletionUPP); { old name was CallDataHCompletionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeVdigIntUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeVdigIntUPP(flags: LONGINT; refcon: LONGINT; userRoutine: VdigIntUPP); { old name was CallVdigIntProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeStartDocumentHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeStartDocumentHandlerUPP(refcon: LONGINT; userRoutine: StartDocumentHandlerUPP): ComponentResult; { old name was CallStartDocumentHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeEndDocumentHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeEndDocumentHandlerUPP(refcon: LONGINT; userRoutine: EndDocumentHandlerUPP): ComponentResult; { old name was CallEndDocumentHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeStartElementHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeStartElementHandlerUPP(name: ConstCStringPtr; VAR atts: ConstCStringPtr; refcon: LONGINT; userRoutine: StartElementHandlerUPP): ComponentResult; { old name was CallStartElementHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeEndElementHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeEndElementHandlerUPP(name: ConstCStringPtr; refcon: LONGINT; userRoutine: EndElementHandlerUPP): ComponentResult; { old name was CallEndElementHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeCharDataHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeCharDataHandlerUPP(charData: ConstCStringPtr; refcon: LONGINT; userRoutine: CharDataHandlerUPP): ComponentResult; { old name was CallCharDataHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokePreprocessInstructionHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokePreprocessInstructionHandlerUPP(name: ConstCStringPtr; VAR atts: ConstCStringPtr; refcon: LONGINT; userRoutine: PreprocessInstructionHandlerUPP): ComponentResult; { old name was CallPreprocessInstructionHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeCommentHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeCommentHandlerUPP(comment: ConstCStringPtr; refcon: LONGINT; userRoutine: CommentHandlerUPP): ComponentResult; { old name was CallCommentHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeSGDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSGDataUPP(c: SGChannel; p: Ptr; len: LONGINT; VAR offset: LONGINT; chRefCon: LONGINT; time: TimeValue; writeType: INTEGER; refCon: LONGINT; userRoutine: SGDataUPP): OSErr; { old name was CallSGDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeSGModalFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSGModalFilterUPP(theDialog: DialogRef; {CONST}VAR theEvent: EventRecord; VAR itemHit: INTEGER; refCon: LONGINT; userRoutine: SGModalFilterUPP): BOOLEAN; { old name was CallSGModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeSGGrabBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSGGrabBottleUPP(c: SGChannel; bufferNum: INTEGER; refCon: LONGINT; userRoutine: SGGrabBottleUPP): ComponentResult; { old name was CallSGGrabBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeSGGrabCompleteBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSGGrabCompleteBottleUPP(c: SGChannel; bufferNum: INTEGER; VAR done: BOOLEAN; refCon: LONGINT; userRoutine: SGGrabCompleteBottleUPP): ComponentResult; { old name was CallSGGrabCompleteBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeSGDisplayBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSGDisplayBottleUPP(c: SGChannel; bufferNum: INTEGER; VAR mp: MatrixRecord; clipRgn: RgnHandle; refCon: LONGINT; userRoutine: SGDisplayBottleUPP): ComponentResult; { old name was CallSGDisplayBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeSGCompressBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSGCompressBottleUPP(c: SGChannel; bufferNum: INTEGER; refCon: LONGINT; userRoutine: SGCompressBottleUPP): ComponentResult; { old name was CallSGCompressBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeSGCompressCompleteBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSGCompressCompleteBottleUPP(c: SGChannel; bufferNum: INTEGER; VAR done: BOOLEAN; VAR ci: SGCompressInfo; refCon: LONGINT; userRoutine: SGCompressCompleteBottleUPP): ComponentResult; { old name was CallSGCompressCompleteBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeSGAddFrameBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSGAddFrameBottleUPP(c: SGChannel; bufferNum: INTEGER; atTime: TimeValue; scale: TimeScale; {CONST}VAR ci: SGCompressInfo; refCon: LONGINT; userRoutine: SGAddFrameBottleUPP): ComponentResult; { old name was CallSGAddFrameBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeSGTransferFrameBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSGTransferFrameBottleUPP(c: SGChannel; bufferNum: INTEGER; VAR mp: MatrixRecord; clipRgn: RgnHandle; refCon: LONGINT; userRoutine: SGTransferFrameBottleUPP): ComponentResult; { old name was CallSGTransferFrameBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeSGGrabCompressCompleteBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSGGrabCompressCompleteBottleUPP(c: SGChannel; VAR done: BOOLEAN; VAR ci: SGCompressInfo; VAR t: TimeRecord; refCon: LONGINT; userRoutine: SGGrabCompressCompleteBottleUPP): ComponentResult; { old name was CallSGGrabCompressCompleteBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeSGDisplayCompressBottleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeSGDisplayCompressBottleUPP(c: SGChannel; dataPtr: Ptr; desc: ImageDescriptionHandle; VAR mp: MatrixRecord; clipRgn: RgnHandle; refCon: LONGINT; userRoutine: SGDisplayCompressBottleUPP): ComponentResult; { old name was CallSGDisplayCompressBottleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QuickTimeComponentsIncludes}

{$ENDC} {__QUICKTIMECOMPONENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

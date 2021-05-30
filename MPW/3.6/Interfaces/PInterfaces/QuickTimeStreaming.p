{
     File:       QuickTimeStreaming.p
 
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
 UNIT QuickTimeStreaming;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QUICKTIMESTREAMING__}
{$SETC __QUICKTIMESTREAMING__ := 1}

{$I+}
{$SETC QuickTimeStreamingIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}
{$IFC UNDEFINED __QUICKTIMECOMPONENTS__}
{$I QuickTimeComponents.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kQTSInfiniteDuration		= $7FFFFFFF;
	kQTSUnknownDuration			= $00000000;
	kQTSNormalForwardRate		= $00010000;
	kQTSStoppedRate				= $00000000;


TYPE
	QTSPresentationRecordPtr = ^QTSPresentationRecord;
	QTSPresentationRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	QTSPresentation						= ^QTSPresentationRecord;
	QTSStreamRecordPtr = ^QTSStreamRecord;
	QTSStreamRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	QTSStream							= ^QTSStreamRecord;
	QTSEditEntryPtr = ^QTSEditEntry;
	QTSEditEntry = RECORD
		presentationDuration:	TimeValue64;
		streamStartTime:		TimeValue64;
		streamRate:				Fixed;
	END;

	QTSEditListPtr = ^QTSEditList;
	QTSEditList = RECORD
		numEdits:				SInt32;
		edits:					ARRAY [0..0] OF QTSEditEntry;
	END;

	QTSEditListHandle					= ^QTSEditListPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	QTSNotificationProcPtr = FUNCTION(inErr: ComponentResult; inNotificationType: OSType; inNotificationParams: UNIV Ptr; inRefCon: UNIV Ptr): ComponentResult;
{$ELSEC}
	QTSNotificationProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	QTSNotificationUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QTSNotificationUPP = UniversalProcPtr;
{$ENDC}	
	{	-----------------------------------------
	    Get / Set Info
	-----------------------------------------	}

CONST
	kQTSGetURLLink				= 'gull';						{  QTSGetURLLinkRecord*  }

	{	 get and set 	}
	kQTSTargetBufferDurationInfo = 'bufr';						{  Fixed* in seconds; expected, not actual  }
	kQTSDurationInfo			= 'dura';						{  QTSDurationAtom*  }
	kQTSSoundLevelMeteringEnabledInfo = 'mtrn';					{  Boolean*  }
	kQTSSoundLevelMeterInfo		= 'levm';						{  LevelMeterInfoPtr  }
	kQTSSourceTrackIDInfo		= 'otid';						{  UInt32*  }
	kQTSSourceLayerInfo			= 'olyr';						{  UInt16*  }
	kQTSSourceLanguageInfo		= 'olng';						{  UInt16*  }
	kQTSSourceTrackFlagsInfo	= 'otfl';						{  SInt32*  }
	kQTSSourceDimensionsInfo	= 'odim';						{  QTSDimensionParams*  }
	kQTSSourceVolumesInfo		= 'ovol';						{  QTSVolumesParams*  }
	kQTSSourceMatrixInfo		= 'omat';						{  MatrixRecord*  }
	kQTSSourceClipRectInfo		= 'oclp';						{  Rect*  }
	kQTSSourceGraphicsModeInfo	= 'ogrm';						{  QTSGraphicsModeParams*  }
	kQTSSourceScaleInfo			= 'oscl';						{  Point*  }
	kQTSSourceBoundingRectInfo	= 'orct';						{  Rect*  }
	kQTSSourceUserDataInfo		= 'oudt';						{  UserData  }
	kQTSSourceInputMapInfo		= 'oimp';						{  QTAtomContainer  }
	kQTSInfo_DataProc			= 'datp';						{  QTSDataProcParams*  }
	kQTSInfo_SendDataExtras		= 'dext';						{  QTSSendDataExtrasParams*  }
	kQTSInfo_HintTrackID		= 'htid';						{  long*  }

	{	 get only 	}
	kQTSStatisticsInfo			= 'stat';						{  QTSStatisticsParams*  }
	kQTSMinStatusDimensionsInfo	= 'mstd';						{  QTSDimensionParams*  }
	kQTSNormalStatusDimensionsInfo = 'nstd';					{  QTSDimensionParams*  }
	kQTSTotalDataRateInfo		= 'drtt';						{  UInt32*, add to what's there  }
	kQTSTotalDataRateInInfo		= 'drti';						{  UInt32*, add to what's there  }
	kQTSTotalDataRateOutInfo	= 'drto';						{  UInt32*, add to what's there  }
	kQTSLostPercentInfo			= 'lpct';						{  QTSLostPercentParams*, add to what's there  }
	kQTSNumViewersInfo			= 'nviw';						{  UInt32*  }
	kQTSMediaTypeInfo			= 'mtyp';						{  OSType*  }
	kQTSNameInfo				= 'name';						{  QTSNameParams*  }
	kQTSCanHandleSendDataType	= 'chsd';						{  QTSCanHandleSendDataTypeParams*  }
	kQTSAnnotationsInfo			= 'meta';						{  QTAtomContainer  }
	kQTSRemainingBufferTimeInfo	= 'btms';						{  UInt32* remaining buffer time before playback, in microseconds  }
	kQTSInfo_SettingsText		= 'sttx';						{  QTSSettingsTextParams*  }


	kQTSTargetBufferDurationTimeScale = 1000;


TYPE
	QTSPanelFilterParamsPtr = ^QTSPanelFilterParams;
	QTSPanelFilterParams = RECORD
		version:				SInt32;
		inStream:				QTSStream;
		inPanelType:			OSType;
		inPanelSubType:			OSType;
		details:				QTAtomSpec;
	END;

	{  return true to keep this panel }
{$IFC TYPED_FUNCTION_POINTERS}
	QTSPanelFilterProcPtr = FUNCTION(VAR inParams: QTSPanelFilterParams; inRefCon: UNIV Ptr): BOOLEAN;
{$ELSEC}
	QTSPanelFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	QTSPanelFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QTSPanelFilterUPP = UniversalProcPtr;
{$ENDC}	

CONST
	kQTSSettingsTextSummary		= 'set1';
	kQTSSettingsTextDetails		= 'setd';


TYPE
	QTSSettingsTextParamsPtr = ^QTSSettingsTextParams;
	QTSSettingsTextParams = RECORD
		flags:					SInt32;									{  None yet defined }
		inSettingsSelector:		OSType;									{  which kind of setting you want from enum above }
		outSettingsAsText:		Handle;									{  QTS allocates; Caller disposes }
		inPanelFilterProc:		QTSPanelFilterUPP;						{  To get a subset filter with this    }
		inPanelFilterProcRefCon: Ptr;
	END;

	QTSCanHandleSendDataTypeParamsPtr = ^QTSCanHandleSendDataTypeParams;
	QTSCanHandleSendDataTypeParams = RECORD
		modifierTypeOrInputID:	SInt32;
		isModifierType:			BOOLEAN;
		returnedCanHandleSendDataType: BOOLEAN;							{  callee sets to true if it can handle it }
	END;

	QTSNameParamsPtr = ^QTSNameParams;
	QTSNameParams = RECORD
		maxNameLength:			SInt32;
		requestedLanguage:		SInt32;
		returnedActualLanguage:	SInt32;
		returnedName:			Ptr;									{  pascal string; caller supplies }
	END;

	QTSLostPercentParamsPtr = ^QTSLostPercentParams;
	QTSLostPercentParams = RECORD
		receivedPkts:			UInt32;
		lostPkts:				UInt32;
		percent:				Fixed;
	END;

	QTSDimensionParamsPtr = ^QTSDimensionParams;
	QTSDimensionParams = RECORD
		width:					Fixed;
		height:					Fixed;
	END;

	QTSVolumesParamsPtr = ^QTSVolumesParams;
	QTSVolumesParams = RECORD
		leftVolume:				SInt16;
		rightVolume:			SInt16;
	END;

	QTSGraphicsModeParamsPtr = ^QTSGraphicsModeParams;
	QTSGraphicsModeParams = RECORD
		graphicsMode:			SInt16;
		opColor:				RGBColor;
	END;

	QTSGetURLLinkRecordPtr = ^QTSGetURLLinkRecord;
	QTSGetURLLinkRecord = RECORD
		displayWhere:			Point;
		returnedURLLink:		Handle;
	END;


CONST
	kQTSDataProcParamsVersion1	= 1;

	kQTSDataProcType_MediaSample = 'mdia';
	kQTSDataProcType_HintSample	= 'hint';


TYPE
	QTSDataProcParamsPtr = ^QTSDataProcParams;
	QTSDataProcParams = RECORD
		version:				SInt32;
		flags:					SInt32;
		stream:					QTSStream;
		procType:				OSType;
		proc:					QTSNotificationUPP;
		procRefCon:				Ptr;
	END;


CONST
	kQTSDataProcSelector_SampleData = 'samp';
	kQTSDataProcSelector_UserData = 'user';

	kQTSSampleDataCallbackParamsVersion1 = 1;


TYPE
	QTSSampleDataCallbackParamsPtr = ^QTSSampleDataCallbackParams;
	QTSSampleDataCallbackParams = RECORD
		version:				SInt32;
		flags:					SInt32;
		stream:					QTSStream;
		procType:				OSType;
		mediaType:				OSType;
		mediaTimeScale:			TimeScale;
		sampleDesc:				SampleDescriptionHandle;
		sampleDescSeed:			UInt32;
		sampleTime:				TimeValue64;
		duration:				TimeValue64;							{  could be 0  }
		sampleFlags:			SInt32;
		dataLength:				UInt32;
		data:					Ptr;
	END;


CONST
	kQTSUserDataCallbackParamsVersion1 = 1;


TYPE
	QTSUserDataCallbackParamsPtr = ^QTSUserDataCallbackParams;
	QTSUserDataCallbackParams = RECORD
		version:				SInt32;
		flags:					SInt32;
		stream:					QTSStream;
		procType:				OSType;
		userDataType:			OSType;
		userDataHandle:			Handle;									{  caller must make copy if it wants to keep the data around }
	END;


CONST
	kQTSSendDataExtrasParamsVersion1 = 1;


TYPE
	QTSSendDataExtrasParamsPtr = ^QTSSendDataExtrasParams;
	QTSSendDataExtrasParams = RECORD
		version:				SInt32;
		flags:					SInt32;
		procType:				OSType;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	QTSModalFilterProcPtr = FUNCTION(inDialog: DialogPtr; {CONST}VAR inEvent: EventRecord; VAR ioItemHit: SInt16; inRefCon: UNIV Ptr): BOOLEAN;
{$ELSEC}
	QTSModalFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	QTSModalFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QTSModalFilterUPP = UniversalProcPtr;
{$ENDC}	
	{	-----------------------------------------
	    Characteristics
	-----------------------------------------	}
	{	 characteristics in Movies.h work here too 	}

CONST
	kQTSSupportsPerStreamControlCharacteristic = 'psct';


TYPE
	QTSVideoParamsPtr = ^QTSVideoParams;
	QTSVideoParams = RECORD
		width:					Fixed;
		height:					Fixed;
		matrix:					MatrixRecord;
		gWorld:					CGrafPtr;
		gdHandle:				GDHandle;
		clip:					RgnHandle;
		graphicsMode:			INTEGER;
		opColor:				RGBColor;
	END;

	QTSAudioParamsPtr = ^QTSAudioParams;
	QTSAudioParams = RECORD
		leftVolume:				SInt16;
		rightVolume:			SInt16;
		bassLevel:				SInt16;
		trebleLevel:			SInt16;
		frequencyBandsCount:	INTEGER;
		frequencyBands:			Ptr;
		levelMeteringEnabled:	BOOLEAN;
	END;

	QTSMediaParamsPtr = ^QTSMediaParams;
	QTSMediaParams = RECORD
		v:						QTSVideoParams;
		a:						QTSAudioParams;
	END;


CONST
	kQTSMustDraw				= $08;
	kQTSAtEnd					= $10;
	kQTSPreflightDraw			= $20;
	kQTSSyncDrawing				= $40;

	{	 media task result flags 	}
	kQTSDidDraw					= $01;
	kQTSNeedsToDraw				= $04;
	kQTSDrawAgain				= $08;
	kQTSPartialDraw				= $10;

	{	============================================================================
	        Notifications
	============================================================================	}
	{	 ------ notification types ------ 	}
	kQTSNullNotification		= 'null';						{  NULL  }
	kQTSErrorNotification		= 'err ';						{  QTSErrorParams*, optional  }
	kQTSNewPresDetectedNotification = 'newp';					{  QTSNewPresDetectedParams*  }
	kQTSPresBeginChangingNotification = 'prcb';					{  NULL  }
	kQTSPresDoneChangingNotification = 'prcd';					{  NULL  }
	kQTSPresentationChangedNotification = 'prch';				{  NULL  }
	kQTSNewStreamNotification	= 'stnw';						{  QTSNewStreamParams*  }
	kQTSStreamBeginChangingNotification = 'stcb';				{  QTSStream  }
	kQTSStreamDoneChangingNotification = 'stcd';				{  QTSStream  }
	kQTSStreamChangedNotification = 'stch';						{  QTSStreamChangedParams*  }
	kQTSStreamGoneNotification	= 'stgn';						{  QTSStreamGoneParams*  }
	kQTSPreviewAckNotification	= 'pvak';						{  QTSStream  }
	kQTSPrerollAckNotification	= 'pack';						{  QTSStream  }
	kQTSStartAckNotification	= 'sack';						{  QTSStream  }
	kQTSStopAckNotification		= 'xack';						{  QTSStream  }
	kQTSStatusNotification		= 'stat';						{  QTSStatusParams*  }
	kQTSURLNotification			= 'url ';						{  QTSURLParams*  }
	kQTSDurationNotification	= 'dura';						{  QTSDurationAtom*  }
	kQTSNewPresentationNotification = 'nprs';					{  QTSPresentation  }
	kQTSPresentationGoneNotification = 'xprs';					{  QTSPresentation  }
	kQTSPresentationDoneNotification = 'pdon';					{  NULL  }
	kQTSBandwidthAlertNotification = 'bwal';					{  QTSBandwidthAlertParams*  }
	kQTSAnnotationsChangedNotification = 'meta';				{  NULL  }


	{	 flags for QTSErrorParams 	}
	kQTSFatalErrorFlag			= $00000001;


TYPE
	QTSErrorParamsPtr = ^QTSErrorParams;
	QTSErrorParams = RECORD
		errorString:			ConstCStringPtr;
		flags:					SInt32;
	END;

	QTSNewPresDetectedParamsPtr = ^QTSNewPresDetectedParams;
	QTSNewPresDetectedParams = RECORD
		data:					Ptr;
	END;

	QTSNewStreamParamsPtr = ^QTSNewStreamParams;
	QTSNewStreamParams = RECORD
		stream:					QTSStream;
	END;

	QTSStreamChangedParamsPtr = ^QTSStreamChangedParams;
	QTSStreamChangedParams = RECORD
		stream:					QTSStream;
		mediaComponent:			ComponentInstance;						{  could be NULL  }
	END;

	QTSStreamGoneParamsPtr = ^QTSStreamGoneParams;
	QTSStreamGoneParams = RECORD
		stream:					QTSStream;
	END;

	QTSStatusParamsPtr = ^QTSStatusParams;
	QTSStatusParams = RECORD
		status:					UInt32;
		statusString:			ConstCStringPtr;
		detailedStatus:			UInt32;
		detailedStatusString:	ConstCStringPtr;
	END;

	QTSInfoParamsPtr = ^QTSInfoParams;
	QTSInfoParams = RECORD
		infoType:				OSType;
		infoParams:				Ptr;
	END;

	QTSURLParamsPtr = ^QTSURLParams;
	QTSURLParams = RECORD
		urlLength:				UInt32;
		url:					ConstCStringPtr;
	END;


CONST
	kQTSBandwidthAlertNeedToStop = $01;
	kQTSBandwidthAlertRestartAt	= $02;


TYPE
	QTSBandwidthAlertParamsPtr = ^QTSBandwidthAlertParams;
	QTSBandwidthAlertParams = RECORD
		flags:					SInt32;
		restartAt:				TimeValue;								{  new field in QT 4.1 }
		reserved:				Ptr;
	END;

	{	============================================================================
	        Presentation
	============================================================================	}
	{	-----------------------------------------
	     Flags
	-----------------------------------------	}
	{	 flags for NewPresentationFromData 	}

CONST
	kQTSAutoModeFlag			= $00000001;
	kQTSDontShowStatusFlag		= $00000008;
	kQTSSendMediaFlag			= $00010000;
	kQTSReceiveMediaFlag		= $00020000;


TYPE
	QTSNewPresentationParamsPtr = ^QTSNewPresentationParams;
	QTSNewPresentationParams = RECORD
		dataType:				OSType;
		data:					Ptr;
		dataLength:				UInt32;
		editList:				QTSEditListHandle;
		flags:					SInt32;
		timeScale:				TimeScale;								{  set to 0 for default timescale  }
		mediaParams:			QTSMediaParamsPtr;
		notificationProc:		QTSNotificationUPP;
		notificationRefCon:		Ptr;
	END;

	QTSPresParamsPtr = ^QTSPresParams;
	QTSPresParams = RECORD
		version:				UInt32;
		editList:				QTSEditListHandle;
		flags:					SInt32;
		timeScale:				TimeScale;								{  set to 0 for default timescale  }
		mediaParams:			QTSMediaParamsPtr;
		notificationProc:		QTSNotificationUPP;
		notificationRefCon:		Ptr;
	END;


CONST
	kQTSPresParamsVersion1		= 1;


TYPE
	QTSPresIdleParamsPtr = ^QTSPresIdleParams;
	QTSPresIdleParams = RECORD
		stream:					QTSStream;
		movieTimeToDisplay:		TimeValue64;
		flagsIn:				SInt32;
		flagsOut:				SInt32;
	END;


CONST
	kQTSExportFlag_ShowDialog	= $00000001;

	kQTSExportParamsVersion1	= 1;


TYPE
	QTSExportParamsPtr = ^QTSExportParams;
	QTSExportParams = RECORD
		version:				SInt32;
		exportType:				OSType;
		exportExtraData:		Ptr;
		destinationContainerType: OSType;
		destinationContainerData: Ptr;
		destinationContainerExtras: Ptr;
		flagsIn:				SInt32;
		flagsOut:				SInt32;
		filterProc:				QTSModalFilterUPP;
		filterProcRefCon:		Ptr;
		exportComponent:		Component;								{  NULL unless you want to override  }
	END;

	{	-----------------------------------------
	    Toolbox Init/Close
	-----------------------------------------	}
	{	 all "apps" must call this 	}
	{
	 *  InitializeQTS()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in QTSClient.lib 4.0 and later
	 	}
FUNCTION InitializeQTS: OSErr; C;

{
 *  TerminateQTS()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION TerminateQTS: OSErr; C;

{-----------------------------------------
    Presentation Functions
-----------------------------------------}
{
 *  QTSNewPresentation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSNewPresentation({CONST}VAR inParams: QTSNewPresentationParams; VAR outPresentation: QTSPresentation): OSErr; C;

{
 *  QTSNewPresentationFromData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 5.0 and later
 }
FUNCTION QTSNewPresentationFromData(inDataType: OSType; inData: UNIV Ptr; {CONST}VAR inDataLength: SInt64; {CONST}VAR inPresParams: QTSPresParams; VAR outPresentation: QTSPresentation): OSErr; C;

{
 *  QTSNewPresentationFromFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 5.0 and later
 }
FUNCTION QTSNewPresentationFromFile({CONST}VAR inFileSpec: FSSpec; {CONST}VAR inPresParams: QTSPresParams; VAR outPresentation: QTSPresentation): OSErr; C;

{
 *  QTSNewPresentationFromDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 5.0 and later
 }
FUNCTION QTSNewPresentationFromDataRef(inDataRef: Handle; inDataRefType: OSType; {CONST}VAR inPresParams: QTSPresParams; VAR outPresentation: QTSPresentation): OSErr; C;

{
 *  QTSDisposePresentation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSDisposePresentation(inPresentation: QTSPresentation; inFlags: SInt32): OSErr; C;

{
 *  QTSPresExport()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 5.0 and later
 }
FUNCTION QTSPresExport(inPresentation: QTSPresentation; inStream: QTSStream; VAR inExportParams: QTSExportParams): OSErr; C;

{
 *  QTSPresIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
PROCEDURE QTSPresIdle(inPresentation: QTSPresentation; VAR ioParams: QTSPresIdleParams); C;

{
 *  QTSPresInvalidateRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresInvalidateRegion(inPresentation: QTSPresentation; inRegion: RgnHandle): OSErr; C;

{-----------------------------------------
    Presentation Configuration
-----------------------------------------}
{
 *  QTSPresSetFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresSetFlags(inPresentation: QTSPresentation; inFlags: SInt32; inFlagsMask: SInt32): OSErr; C;

{
 *  QTSPresGetFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetFlags(inPresentation: QTSPresentation; VAR outFlags: SInt32): OSErr; C;

{
 *  QTSPresGetTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetTimeBase(inPresentation: QTSPresentation; VAR outTimeBase: TimeBase): OSErr; C;

{
 *  QTSPresGetTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetTimeScale(inPresentation: QTSPresentation; VAR outTimeScale: TimeScale): OSErr; C;

{
 *  QTSPresSetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresSetInfo(inPresentation: QTSPresentation; inStream: QTSStream; inSelector: OSType; ioParam: UNIV Ptr): OSErr; C;

{
 *  QTSPresGetInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetInfo(inPresentation: QTSPresentation; inStream: QTSStream; inSelector: OSType; ioParam: UNIV Ptr): OSErr; C;

{
 *  QTSPresHasCharacteristic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresHasCharacteristic(inPresentation: QTSPresentation; inStream: QTSStream; inCharacteristic: OSType; VAR outHasIt: BOOLEAN): OSErr; C;

{
 *  QTSPresSetNotificationProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresSetNotificationProc(inPresentation: QTSPresentation; inNotificationProc: QTSNotificationUPP; inRefCon: UNIV Ptr): OSErr; C;

{
 *  QTSPresGetNotificationProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetNotificationProc(inPresentation: QTSPresentation; VAR outNotificationProc: QTSNotificationUPP; VAR outRefCon: UNIV Ptr): OSErr; C;

{-----------------------------------------
    Presentation Control
-----------------------------------------}
{
 *  QTSPresPreview()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QTSPresPreview(inPresentation: QTSPresentation; inStream: QTSStream; {CONST}VAR inTimeValue: TimeValue64; inRate: Fixed; inFlags: SInt32): OSErr; C;

{
 *  QTSPresPreroll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresPreroll(inPresentation: QTSPresentation; inStream: QTSStream; inTimeValue: UInt32; inRate: Fixed; inFlags: SInt32): OSErr; C;

{
 *  QTSPresPreroll64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.1 and later
 }
FUNCTION QTSPresPreroll64(inPresentation: QTSPresentation; inStream: QTSStream; {CONST}VAR inPrerollTime: TimeValue64; inRate: Fixed; inFlags: SInt32): OSErr; C;

{
 *  QTSPresStart()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresStart(inPresentation: QTSPresentation; inStream: QTSStream; inFlags: SInt32): OSErr; C;

{
 *  QTSPresSkipTo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresSkipTo(inPresentation: QTSPresentation; inTimeValue: UInt32): OSErr; C;

{
 *  QTSPresSkipTo64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.1 and later
 }
FUNCTION QTSPresSkipTo64(inPresentation: QTSPresentation; {CONST}VAR inTimeValue: TimeValue64): OSErr; C;

{
 *  QTSPresStop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresStop(inPresentation: QTSPresentation; inStream: QTSStream; inFlags: SInt32): OSErr; C;

{============================================================================
        Streams
============================================================================}
{-----------------------------------------
    Stream Functions
-----------------------------------------}
{
 *  QTSPresNewStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresNewStream(inPresentation: QTSPresentation; inDataType: OSType; inData: UNIV Ptr; inDataLength: UInt32; inFlags: SInt32; VAR outStream: QTSStream): OSErr; C;

{
 *  QTSDisposeStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSDisposeStream(inStream: QTSStream; inFlags: SInt32): OSErr; C;

{
 *  QTSPresGetNumStreams()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetNumStreams(inPresentation: QTSPresentation): UInt32; C;

{
 *  QTSPresGetIndStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetIndStream(inPresentation: QTSPresentation; inIndex: UInt32): QTSStream; C;

{
 *  QTSGetStreamPresentation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSGetStreamPresentation(inStream: QTSStream): QTSPresentation; C;

{
 *  QTSPresSetPreferredRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresSetPreferredRate(inPresentation: QTSPresentation; inRate: Fixed; inFlags: SInt32): OSErr; C;

{
 *  QTSPresGetPreferredRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetPreferredRate(inPresentation: QTSPresentation; VAR outRate: Fixed): OSErr; C;

{
 *  QTSPresSetEnable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresSetEnable(inPresentation: QTSPresentation; inStream: QTSStream; inEnableMode: BOOLEAN): OSErr; C;

{
 *  QTSPresGetEnable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetEnable(inPresentation: QTSPresentation; inStream: QTSStream; VAR outEnableMode: BOOLEAN): OSErr; C;

{
 *  QTSPresSetPresenting()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresSetPresenting(inPresentation: QTSPresentation; inStream: QTSStream; inPresentingMode: BOOLEAN): OSErr; C;

{
 *  QTSPresGetPresenting()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetPresenting(inPresentation: QTSPresentation; inStream: QTSStream; VAR outPresentingMode: BOOLEAN): OSErr; C;

{
 *  QTSPresSetActiveSegment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.1 and later
 }
FUNCTION QTSPresSetActiveSegment(inPresentation: QTSPresentation; inStream: QTSStream; {CONST}VAR inStartTime: TimeValue64; {CONST}VAR inDuration: TimeValue64): OSErr; C;

{
 *  QTSPresGetActiveSegment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.1 and later
 }
FUNCTION QTSPresGetActiveSegment(inPresentation: QTSPresentation; inStream: QTSStream; VAR outStartTime: TimeValue64; VAR outDuration: TimeValue64): OSErr; C;

{
 *  QTSPresSetPlayHints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresSetPlayHints(inPresentation: QTSPresentation; inStream: QTSStream; inFlags: SInt32; inFlagsMask: SInt32): OSErr; C;

{
 *  QTSPresGetPlayHints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetPlayHints(inPresentation: QTSPresentation; inStream: QTSStream; VAR outFlags: SInt32): OSErr; C;

{-----------------------------------------
    Stream Spatial Functions
-----------------------------------------}
{
 *  QTSPresSetGWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresSetGWorld(inPresentation: QTSPresentation; inStream: QTSStream; inGWorld: CGrafPtr; inGDHandle: GDHandle): OSErr; C;

{
 *  QTSPresGetGWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetGWorld(inPresentation: QTSPresentation; inStream: QTSStream; VAR outGWorld: CGrafPtr; VAR outGDHandle: GDHandle): OSErr; C;

{
 *  QTSPresSetClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresSetClip(inPresentation: QTSPresentation; inStream: QTSStream; inClip: RgnHandle): OSErr; C;

{
 *  QTSPresGetClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetClip(inPresentation: QTSPresentation; inStream: QTSStream; VAR outClip: RgnHandle): OSErr; C;

{
 *  QTSPresSetMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresSetMatrix(inPresentation: QTSPresentation; inStream: QTSStream; {CONST}VAR inMatrix: MatrixRecord): OSErr; C;

{
 *  QTSPresGetMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetMatrix(inPresentation: QTSPresentation; inStream: QTSStream; VAR outMatrix: MatrixRecord): OSErr; C;

{
 *  QTSPresSetDimensions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresSetDimensions(inPresentation: QTSPresentation; inStream: QTSStream; inWidth: Fixed; inHeight: Fixed): OSErr; C;

{
 *  QTSPresGetDimensions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetDimensions(inPresentation: QTSPresentation; inStream: QTSStream; VAR outWidth: Fixed; VAR outHeight: Fixed): OSErr; C;

{
 *  QTSPresSetGraphicsMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresSetGraphicsMode(inPresentation: QTSPresentation; inStream: QTSStream; inMode: INTEGER; {CONST}VAR inOpColor: RGBColor): OSErr; C;

{
 *  QTSPresGetGraphicsMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetGraphicsMode(inPresentation: QTSPresentation; inStream: QTSStream; VAR outMode: INTEGER; VAR outOpColor: RGBColor): OSErr; C;

{
 *  QTSPresGetPicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetPicture(inPresentation: QTSPresentation; inStream: QTSStream; VAR outPicture: PicHandle): OSErr; C;

{-----------------------------------------
    Stream Sound Functions
-----------------------------------------}
{
 *  QTSPresSetVolumes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresSetVolumes(inPresentation: QTSPresentation; inStream: QTSStream; inLeftVolume: INTEGER; inRightVolume: INTEGER): OSErr; C;

{
 *  QTSPresGetVolumes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSPresGetVolumes(inPresentation: QTSPresentation; inStream: QTSStream; VAR outLeftVolume: INTEGER; VAR outRightVolume: INTEGER): OSErr; C;

{-----------------------------------------
    Sourcing
-----------------------------------------}
{
 *  QTSPresGetSettingsAsText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0.1 and later
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X after version 10.0
 *    Mac OS X:         in after version 10.0
 }
FUNCTION QTSPresGetSettingsAsText(inPresentation: QTSPresentation; inStream: QTSStream; inFlags: SInt32; inSettingsType: OSType; VAR outText: Handle; inPanelFilterProc: QTSPanelFilterUPP; inPanelFilterProcRefCon: UNIV Ptr): OSErr; C;

{
 *  QTSPresSettingsDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QTSPresSettingsDialog(inPresentation: QTSPresentation; inStream: QTSStream; inFlags: SInt32; inFilterProc: QTSModalFilterUPP; inFilterProcRefCon: UNIV Ptr): OSErr; C;

{
 *  QTSPresSettingsDialogWithFilters()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0.1 and later
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X after version 10.0
 *    Mac OS X:         in after version 10.0
 }
FUNCTION QTSPresSettingsDialogWithFilters(inPresentation: QTSPresentation; inStream: QTSStream; inFlags: SInt32; inFilterProc: QTSModalFilterUPP; inFilterProcRefCon: UNIV Ptr; inPanelFilterProc: QTSPanelFilterUPP; inPanelFilterProcRefCon: UNIV Ptr): OSErr; C;

{
 *  QTSPresSetSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QTSPresSetSettings(inPresentation: QTSPresentation; inStream: QTSStream; inSettings: QTAtomSpecPtr; inFlags: SInt32): OSErr; C;

{
 *  QTSPresGetSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QTSPresGetSettings(inPresentation: QTSPresentation; inStream: QTSStream; VAR outSettings: QTAtomContainer; inFlags: SInt32): OSErr; C;

{
 *  QTSPresAddSourcer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QTSPresAddSourcer(inPresentation: QTSPresentation; inStream: QTSStream; inSourcer: ComponentInstance; inFlags: SInt32): OSErr; C;

{
 *  QTSPresRemoveSourcer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QTSPresRemoveSourcer(inPresentation: QTSPresentation; inStream: QTSStream; inSourcer: ComponentInstance; inFlags: SInt32): OSErr; C;

{
 *  QTSPresGetNumSourcers()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QTSPresGetNumSourcers(inPresentation: QTSPresentation; inStream: QTSStream): UInt32; C;

{
 *  QTSPresGetIndSourcer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QTSPresGetIndSourcer(inPresentation: QTSPresentation; inStream: QTSStream; inIndex: UInt32; VAR outSourcer: ComponentInstance): OSErr; C;

{============================================================================
        Misc
============================================================================}
{ flags for Get/SetNetworkAppName }

CONST
	kQTSNetworkAppNameIsFullNameFlag = $00000001;

	{
	 *  QTSSetNetworkAppName()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in QTSClient.lib 4.1 and later
	 	}
FUNCTION QTSSetNetworkAppName(inAppName: ConstCStringPtr; inFlags: SInt32): OSErr; C;

{
 *  QTSGetNetworkAppName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.1 and later
 }
FUNCTION QTSGetNetworkAppName(inFlags: SInt32; VAR outCStringPtr: CStringPtr): OSErr; C;

{-----------------------------------------
    Statistics Utilities
-----------------------------------------}

TYPE
	QTSStatHelperRecordPtr = ^QTSStatHelperRecord;
	QTSStatHelperRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	QTSStatHelper						= ^QTSStatHelperRecord;

CONST
	kQTSInvalidStatHelper		= 0;

	{	 flags for QTSStatHelperNextParams 	}
	kQTSStatHelperReturnPascalStringsFlag = $00000001;


TYPE
	QTSStatHelperNextParamsPtr = ^QTSStatHelperNextParams;
	QTSStatHelperNextParams = RECORD
		flags:					SInt32;
		returnedStatisticsType:	OSType;
		returnedStream:			QTSStream;
		maxStatNameLength:		UInt32;
		returnedStatName:		CStringPtr;								{  NULL if you don't want it }
		maxStatStringLength:	UInt32;
		returnedStatString:		CStringPtr;								{  NULL if you don't want it }
		maxStatUnitLength:		UInt32;
		returnedStatUnit:		CStringPtr;								{  NULL if you don't want it }
	END;

	QTSStatisticsParamsPtr = ^QTSStatisticsParams;
	QTSStatisticsParams = RECORD
		statisticsType:			OSType;
		container:				QTAtomContainer;
		parentAtom:				QTAtom;
		flags:					SInt32;
	END;

	{	 general statistics types 	}

CONST
	kQTSAllStatisticsType		= 'all ';
	kQTSShortStatisticsType		= 'shrt';
	kQTSSummaryStatisticsType	= 'summ';

	{	 statistics flags 	}
	kQTSGetNameStatisticsFlag	= $00000001;
	kQTSDontGetDataStatisticsFlag = $00000002;
	kQTSUpdateAtomsStatisticsFlag = $00000004;
	kQTSGetUnitsStatisticsFlag	= $00000008;
	kQTSUpdateAllIfNecessaryStatisticsFlag = $00010000;

	{	 statistics atom types 	}
	kQTSStatisticsStreamAtomType = 'strm';
	kQTSStatisticsNameAtomType	= 'name';						{  chars only, no length or terminator  }
	kQTSStatisticsDataFormatAtomType = 'frmt';					{  OSType  }
	kQTSStatisticsDataAtomType	= 'data';
	kQTSStatisticsUnitsAtomType	= 'unit';						{  OSType  }
	kQTSStatisticsUnitsNameAtomType = 'unin';					{  chars only, no length or terminator  }

	{	 statistics data formats 	}
	kQTSStatisticsSInt32DataFormat = 'si32';
	kQTSStatisticsUInt32DataFormat = 'ui32';
	kQTSStatisticsSInt16DataFormat = 'si16';
	kQTSStatisticsUInt16DataFormat = 'ui16';
	kQTSStatisticsFixedDataFormat = 'fixd';
	kQTSStatisticsUnsignedFixedDataFormat = 'ufix';
	kQTSStatisticsStringDataFormat = 'strg';
	kQTSStatisticsOSTypeDataFormat = 'ostp';
	kQTSStatisticsRectDataFormat = 'rect';
	kQTSStatisticsPointDataFormat = 'pont';

	{	 statistics units types 	}
	kQTSStatisticsNoUnitsType	= 0;
	kQTSStatisticsPercentUnitsType = 'pcnt';
	kQTSStatisticsBitsPerSecUnitsType = 'bps ';
	kQTSStatisticsFramesPerSecUnitsType = 'fps ';

	{	 specific statistics types 	}
	kQTSTotalDataRateStat		= 'drtt';
	kQTSTotalDataRateInStat		= 'drti';
	kQTSTotalDataRateOutStat	= 'drto';
	kQTSNetworkIDStringStat		= 'nids';

	{
	 *  QTSNewStatHelper()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in QTSClient.lib 4.0 and later
	 	}
FUNCTION QTSNewStatHelper(inPresentation: QTSPresentation; inStream: QTSStream; inStatType: OSType; inFlags: SInt32; VAR outStatHelper: QTSStatHelper): OSErr; C;

{
 *  QTSDisposeStatHelper()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSDisposeStatHelper(inStatHelper: QTSStatHelper): OSErr; C;

{
 *  QTSStatHelperGetStats()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSStatHelperGetStats(inStatHelper: QTSStatHelper): OSErr; C;

{
 *  QTSStatHelperResetIter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSStatHelperResetIter(inStatHelper: QTSStatHelper): OSErr; C;

{
 *  QTSStatHelperNext()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSStatHelperNext(inStatHelper: QTSStatHelper; VAR ioParams: QTSStatHelperNextParams): BOOLEAN; C;

{
 *  QTSStatHelperGetNumStats()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSStatHelperGetNumStats(inStatHelper: QTSStatHelper): UInt32; C;

{ used by components to put statistics into the atom container }
{
 *  QTSGetOrMakeStatAtomForStream()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSGetOrMakeStatAtomForStream(inContainer: QTAtomContainer; inStream: QTSStream; VAR outParentAtom: QTAtom): OSErr; C;

{
 *  QTSInsertStatistic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSInsertStatistic(inContainer: QTAtomContainer; inParentAtom: QTAtom; inStatType: OSType; inStatData: UNIV Ptr; inStatDataLength: UInt32; inStatDataFormat: OSType; inFlags: SInt32): OSErr; C;

{
 *  QTSInsertStatisticName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSInsertStatisticName(inContainer: QTAtomContainer; inParentAtom: QTAtom; inStatType: OSType; inStatName: ConstCStringPtr; inStatNameLength: UInt32): OSErr; C;

{
 *  QTSInsertStatisticUnits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSInsertStatisticUnits(inContainer: QTAtomContainer; inParentAtom: QTAtom; inStatType: OSType; inUnitsType: OSType; inUnitsName: ConstCStringPtr; inUnitsNameLength: UInt32): OSErr; C;

{============================================================================
        Data Formats
============================================================================}
{-----------------------------------------
    Data Types
-----------------------------------------}
{ universal data types }

CONST
	kQTSNullDataType			= 'NULL';
	kQTSUnknownDataType			= 'huh?';
	kQTSAtomContainerDataType	= 'qtac';						{  QTAtomContainer  }
	kQTSAtomDataType			= 'qtat';						{  QTSAtomContainerDataStruct*  }
	kQTSAliasDataType			= 'alis';
	kQTSFileDataType			= 'fspc';						{  FSSpec*  }
	kQTSFileSpecDataType		= 'fspc';						{  FSSpec*  }
	kQTSHandleDataType			= 'hndl';						{  Handle*  }
	kQTSDataRefDataType			= 'dref';						{  DataReferencePtr  }

	{	 these data types are specific to presentations 	}
	kQTSRTSPDataType			= 'rtsp';
	kQTSSDPDataType				= 'sdp ';

	{	-----------------------------------------
	    Atom IDs
	-----------------------------------------	}
	kQTSAtomType_Presentation	= 'pres';
	kQTSAtomType_PresentationHeader = 'phdr';					{  QTSPresentationHeaderAtom  }
	kQTSAtomType_MediaStream	= 'mstr';
	kQTSAtomType_MediaStreamHeader = 'mshd';					{  QTSMediaStreamHeaderAtom  }
	kQTSAtomType_MediaDescriptionText = 'mdes';					{  chars, no length  }
	kQTSAtomType_ClipRect		= 'clip';						{  QTSClipRectAtom  }
	kQTSAtomType_Duration		= 'dura';						{  QTSDurationAtom  }
	kQTSAtomType_BufferTime		= 'bufr';						{  QTSBufferTimeAtom  }


TYPE
	QTSAtomContainerDataStructPtr = ^QTSAtomContainerDataStruct;
	QTSAtomContainerDataStruct = RECORD
		container:				QTAtomContainer;
		parentAtom:				QTAtom;
	END;

	{	 flags for QTSPresentationHeaderAtom 	}

CONST
	kQTSPresHeaderTypeIsData	= $00000100;
	kQTSPresHeaderDataIsHandle	= $00000200;


TYPE
	QTSPresentationHeaderAtomPtr = ^QTSPresentationHeaderAtom;
	QTSPresentationHeaderAtom = RECORD
		versionAndFlags:		SInt32;
		conductorOrDataType:	OSType;
		dataAtomType:			OSType;									{  where the data really is }
	END;

	QTSMediaStreamHeaderAtomPtr = ^QTSMediaStreamHeaderAtom;
	QTSMediaStreamHeaderAtom = RECORD
		versionAndFlags:		SInt32;
		mediaTransportType:		OSType;
		mediaTransportDataAID:	OSType;									{  where the data really is }
	END;

	QTSBufferTimeAtomPtr = ^QTSBufferTimeAtom;
	QTSBufferTimeAtom = RECORD
		versionAndFlags:		SInt32;
		bufferTime:				Fixed;
	END;

	QTSDurationAtomPtr = ^QTSDurationAtom;
	QTSDurationAtom = RECORD
		versionAndFlags:		SInt32;
		timeScale:				TimeScale;
		duration:				TimeValue64;
	END;

	QTSClipRectAtomPtr = ^QTSClipRectAtom;
	QTSClipRectAtom = RECORD
		versionAndFlags:		SInt32;
		clipRect:				Rect;
	END;


CONST
	kQTSEmptyEditStreamStartTime = -1;



TYPE
	QTSStatus							= UInt32;

CONST
	kQTSNullStatus				= 0;
	kQTSUninitializedStatus		= 1;
	kQTSConnectingStatus		= 2;
	kQTSOpeningConnectionDetailedStatus = 3;
	kQTSMadeConnectionDetailedStatus = 4;
	kQTSNegotiatingStatus		= 5;
	kQTSGettingDescriptionDetailedStatus = 6;
	kQTSGotDescriptionDetailedStatus = 7;
	kQTSSentSetupCmdDetailedStatus = 8;
	kQTSReceivedSetupResponseDetailedStatus = 9;
	kQTSSentPlayCmdDetailedStatus = 10;
	kQTSReceivedPlayResponseDetailedStatus = 11;
	kQTSBufferingStatus			= 12;
	kQTSPlayingStatus			= 13;
	kQTSPausedStatus			= 14;
	kQTSAutoConfiguringStatus	= 15;
	kQTSDownloadingStatus		= 16;
	kQTSBufferingWithTimeStatus	= 17;
	kQTSWaitingDisconnectStatus	= 100;

	{	-----------------------------------------
	    QuickTime Preferences Types
	-----------------------------------------	}
	kQTSConnectionPrefsType		= 'stcm';						{  root atom that all other atoms are contained in }
																{     kQTSNotUsedForProxyPrefsType = 'nopr',     //        comma-delimited list of URLs that are never used for proxies }
	kQTSConnectionMethodPrefsType = 'mthd';						{       connection method (OSType that matches one of the following three) }
	kQTSDirectConnectPrefsType	= 'drct';						{        used if direct connect (QTSDirectConnectPrefsRecord) }
																{     kQTSRTSPProxyPrefsType =     'rtsp',   //   used if RTSP Proxy (QTSProxyPrefsRecord) }
	kQTSSOCKSPrefsType			= 'sock';						{        used if SOCKS Proxy (QTSProxyPrefsRecord) }

	kQTSDirectConnectHTTPProtocol = 'http';
	kQTSDirectConnectRTSPProtocol = 'rtsp';


TYPE
	QTSDirectConnectPrefsRecordPtr = ^QTSDirectConnectPrefsRecord;
	QTSDirectConnectPrefsRecord = RECORD
		tcpPortID:				UInt32;
		protocol:				OSType;
	END;

	QTSProxyPrefsRecordPtr = ^QTSProxyPrefsRecord;
	QTSProxyPrefsRecord = RECORD
		serverNameStr:			Str255;
		portID:					UInt32;
	END;


CONST
	kConnectionActive			= $00000001;
	kConnectionUseSystemPref	= $00000002;


TYPE
	QTSTransportPrefPtr = ^QTSTransportPref;
	QTSTransportPref = RECORD
		protocol:				OSType;									{  udp, http, tcp, etc }
		portID:					SInt32;									{  port to use for this connection type }
		flags:					UInt32;									{  connection flags }
		seed:					UInt32;									{  seed value last time this setting was read from system prefs }
	END;


CONST
	kProxyActive				= $00000001;
	kProxyUseSystemPref			= $00000002;


TYPE
	QTSProxyPrefPtr = ^QTSProxyPref;
	QTSProxyPref = RECORD
		flags:					UInt32;									{  proxy flags }
		portID:					SInt32;									{  port to use for this connection type }
		seed:					UInt32;									{  seed value last time this setting was read from system prefs }
		serverNameStr:			Str255;									{  proxy server url }
	END;


CONST
	kNoProxyUseSystemPref		= $00000001;


TYPE
	QTSNoProxyPrefPtr = ^QTSNoProxyPref;
	QTSNoProxyPref = RECORD
		flags:					UInt32;									{  no-proxy flags }
		seed:					UInt32;									{  seed value last time this setting was read from system prefs }
		urlList:				SInt8;									{  NULL terminated, comma delimited list of urls }
	END;


CONST
	kQTSTransAndProxyAtomType	= 'strp';						{  transport/proxy prefs root atom }
	kQTSConnectionPrefsVersion	= 'vers';						{    prefs format version }
	kQTSTransportPrefsAtomType	= 'trns';						{    tranport prefs root atom }
	kQTSConnectionAtomType		= 'conn';						{      connection prefs atom type, one for each transport type }
	kQTSUDPTransportType		= 'udp ';						{      udp transport prefs }
	kQTSHTTPTransportType		= 'http';						{      http transport prefs }
	kQTSTCPTransportType		= 'tcp ';						{      tcp transport prefs     }
	kQTSProxyPrefsAtomType		= 'prxy';						{    proxy prefs root atom }
	kQTSHTTPProxyPrefsType		= 'http';						{      http proxy settings }
	kQTSRTSPProxyPrefsType		= 'rtsp';						{      rtsp proxy settings }
	kQTSSOCKSProxyPrefsType		= 'scks';						{      socks proxy settings }
	kQTSProxyUserInfoPrefsType	= 'user';						{    proxy username/password root atom }
	kQTSDontProxyPrefsAtomType	= 'nopr';						{    no-proxy prefs root atom }
	kQTSDontProxyDataType		= 'data';						{      no proxy settings }

	{
	 *  QTSPrefsAddProxySetting()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in QTSClient.lib 4.1 and later
	 	}
FUNCTION QTSPrefsAddProxySetting(proxyType: OSType; portID: SInt32; flags: UInt32; seed: UInt32; VAR srvrURL: Str255): OSErr; C;

{
 *  QTSPrefsFindProxyByType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.1 and later
 }
FUNCTION QTSPrefsFindProxyByType(proxyType: OSType; flags: UInt32; flagsMask: UInt32; VAR proxyHndl: UNIV Ptr; VAR count: SInt16): OSErr; C;

{
 *  QTSPrefsAddConnectionSetting()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.1 and later
 }
FUNCTION QTSPrefsAddConnectionSetting(protocol: OSType; portID: SInt32; flags: UInt32; seed: UInt32): OSErr; C;

{
 *  QTSPrefsFindConnectionByType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.1 and later
 }
FUNCTION QTSPrefsFindConnectionByType(protocol: OSType; flags: UInt32; flagsMask: UInt32; VAR connectionHndl: UNIV Ptr; VAR count: SInt16): OSErr; C;

{
 *  QTSPrefsGetActiveConnection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.1 and later
 }
FUNCTION QTSPrefsGetActiveConnection(protocol: OSType; VAR connectInfo: QTSTransportPref): OSErr; C;

{
 *  QTSPrefsGetNoProxyURLs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.1 and later
 }
FUNCTION QTSPrefsGetNoProxyURLs(VAR noProxyHndl: UNIV Ptr): OSErr; C;

{
 *  QTSPrefsSetNoProxyURLs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.1 and later
 }
FUNCTION QTSPrefsSetNoProxyURLs(urls: CStringPtr; flags: UInt32; seed: UInt32): OSErr; C;

{
 *  QTSPrefsAddProxyUserInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0.1 and later
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X after version 10.0
 *    Mac OS X:         in after version 10.0
 *    Windows:          in QTSClient.lib 5.0.1 and later
 }
FUNCTION QTSPrefsAddProxyUserInfo(proxyType: OSType; flags: SInt32; flagsMask: SInt32; username: StringPtr; password: StringPtr): OSErr; C;

{
 *  QTSPrefsFindProxyUserInfoByType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0.1 and later
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X after version 10.0
 *    Mac OS X:         in after version 10.0
 *    Windows:          in QTSClient.lib 5.0.1 and later
 }
FUNCTION QTSPrefsFindProxyUserInfoByType(proxyType: OSType; flags: SInt32; flagsMask: SInt32; username: StringPtr; password: StringPtr): OSErr; C;



{============================================================================
        Memory Management Services
============================================================================}
{
   These routines allocate normal pointers and handles,
   but do the correct checking, etc.
   Dispose using the normal DisposePtr and DisposeHandle
   Call these routines for one time memory allocations.
   You do not need to set any hints to use these calls.
}

{
 *  QTSNewPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSNewPtr(inByteCount: UInt32; inFlags: SInt32; VAR outFlags: SInt32): Ptr; C;

{
 *  QTSNewHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSNewHandle(inByteCount: UInt32; inFlags: SInt32; VAR outFlags: SInt32): Handle; C;

{  flags in }

CONST
	kQTSMemAllocClearMem		= $00000001;
	kQTSMemAllocDontUseTempMem	= $00000002;
	kQTSMemAllocTryTempMemFirst	= $00000004;
	kQTSMemAllocDontUseSystemMem = $00000008;
	kQTSMemAllocTrySystemMemFirst = $00000010;
	kQTSMemAllocHoldMemory		= $00001000;
	kQTSMemAllocIsInterruptTime	= $01010000;					{  currently not supported for alloc }

	{  flags out }
	kQTSMemAllocAllocatedInTempMem = $00000001;
	kQTSMemAllocAllocatedInSystemMem = $00000002;


TYPE
	QTSMemPtr    = ^LONGINT; { an opaque 32-bit type }
	QTSMemPtrPtr = ^QTSMemPtr;  { when a VAR xx:QTSMemPtr parameter can be nil, it is changed to xx: QTSMemPtrPtr }
	{
	   These routines are for buffers that will be recirculated
	   you must use QTReleaseMemPtr instead of DisposePtr
	   QTSReleaseMemPtr can be used at interrupt time
	   but QTSAllocMemPtr currently cannot 
	}
	{
	 *  QTSAllocMemPtr()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in QTSClient.lib 4.0 and later
	 	}
FUNCTION QTSAllocMemPtr(inByteCount: UInt32; inFlags: SInt32): QTSMemPtr; C;

{
 *  QTSReleaseMemPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
PROCEDURE QTSReleaseMemPtr(inMemPtr: QTSMemPtr; inFlags: SInt32); C;


{============================================================================
        Buffer Management Services
============================================================================}


CONST
	kQTSStreamBufferVersion1	= 1;


TYPE
	QTSStreamBufferPtr = ^QTSStreamBuffer;
	QTSStreamBuffer = RECORD
		reserved1:				QTSStreamBufferPtr;
		reserved2:				QTSStreamBufferPtr;
		next:					QTSStreamBufferPtr;						{  next message block in a message  }
		rptr:					Ptr;									{  first byte with real data in the DataBuffer  }
		wptr:					Ptr;									{  last+1 byte with real data in the DataBuffer  }
		version:				SInt32;
		metadata:				ARRAY [0..3] OF UInt32;					{  usage defined by message sender  }
		flags:					SInt32;									{  reserved  }
		reserved3:				LONGINT;
		reserved4:				LONGINT;
		reserved5:				LONGINT;
		moreMeta:				ARRAY [0..7] OF UInt32;
	END;

	{  flags for QTSDuplicateMessage }

CONST
	kQTSDuplicateBufferFlag_CopyData = $00000001;
	kQTSDuplicateBufferFlag_FlattenMessage = $00000002;


	{
	 *  QTSNewStreamBuffer()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in QTSClient.lib 5.0 and later
	 	}
FUNCTION QTSNewStreamBuffer(inDataSize: UInt32; inFlags: SInt32; VAR outStreamBuffer: UNIV Ptr): OSErr; C;

{
 *  QTSFreeMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
PROCEDURE QTSFreeMessage(VAR inMessage: QTSStreamBuffer); C;

{
    kQTSDuplicateBufferFlag_CopyData - forces a copy of the data itself
    kQTSCopyBufferFlag_FlattenMessage - copies the data if it needs to be flattened
    QTSDuplicateMessage never frees the old message
}
{
 *  QTSDuplicateMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 5.0 and later
 }
FUNCTION QTSDuplicateMessage(VAR inMessage: QTSStreamBuffer; inFlags: SInt32; VAR outDuplicatedMessage: UNIV Ptr): OSErr; C;

{
 *  QTSMessageLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSMessageLength(VAR inMessage: QTSStreamBuffer): UInt32; C;

{
 *  QTSStreamBufferDataInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 5.0 and later
 }
PROCEDURE QTSStreamBufferDataInfo(VAR inStreamBuffer: QTSStreamBuffer; VAR outDataStart: UNIV Ptr; VAR outDataMaxLength: UInt32); C;

{  ---- old calls (don't use these) }

{
 *  QTSAllocBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSAllocBuffer(inSize: SInt32): QTSStreamBufferPtr; C;

{
 *  QTSDupMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSDupMessage(VAR inMessage: QTSStreamBuffer): QTSStreamBufferPtr; C;

{
 *  QTSCopyMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSCopyMessage(VAR inMessage: QTSStreamBuffer): QTSStreamBufferPtr; C;

{
 *  QTSFlattenMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSFlattenMessage(VAR inMessage: QTSStreamBuffer): QTSStreamBufferPtr; C;



{============================================================================
        Misc
============================================================================}
{
 *  QTSGetErrorString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in QTSClient.lib 4.0 and later
 }
FUNCTION QTSGetErrorString(inErrorCode: SInt32; inMaxErrorStringLength: UInt32; outErrorString: CStringPtr; inFlags: SInt32): BOOLEAN; C;

{
 *  QTSInitializeMediaParams()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QTStreamLib 5.0.1 and later
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X after version 10.0
 *    Mac OS X:         in after version 10.0
 *    Windows:          in QTSClient.lib 5.0.1 and later
 }
FUNCTION QTSInitializeMediaParams(VAR inMediaParams: QTSMediaParams): OSErr; C;



{ UPP call backs }

CONST
	uppQTSNotificationProcInfo = $00003FF0;
	uppQTSPanelFilterProcInfo = $000003D0;
	uppQTSModalFilterProcInfo = $00003FD0;
	{
	 *  NewQTSNotificationUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewQTSNotificationUPP(userRoutine: QTSNotificationProcPtr): QTSNotificationUPP; { old name was NewQTSNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQTSPanelFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib on Mac OS X
 *    Mac OS X:         in after version 10.0
 }
FUNCTION NewQTSPanelFilterUPP(userRoutine: QTSPanelFilterProcPtr): QTSPanelFilterUPP; { old name was NewQTSPanelFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQTSModalFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQTSModalFilterUPP(userRoutine: QTSModalFilterProcPtr): QTSModalFilterUPP; { old name was NewQTSModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeQTSNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQTSNotificationUPP(userUPP: QTSNotificationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQTSPanelFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib on Mac OS X
 *    Mac OS X:         in after version 10.0
 }
PROCEDURE DisposeQTSPanelFilterUPP(userUPP: QTSPanelFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQTSModalFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQTSModalFilterUPP(userUPP: QTSModalFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeQTSNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeQTSNotificationUPP(inErr: ComponentResult; inNotificationType: OSType; inNotificationParams: UNIV Ptr; inRefCon: UNIV Ptr; userRoutine: QTSNotificationUPP): ComponentResult; { old name was CallQTSNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQTSPanelFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib on Mac OS X
 *    Mac OS X:         in after version 10.0
 }
FUNCTION InvokeQTSPanelFilterUPP(VAR inParams: QTSPanelFilterParams; inRefCon: UNIV Ptr; userRoutine: QTSPanelFilterUPP): BOOLEAN; { old name was CallQTSPanelFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQTSModalFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeQTSModalFilterUPP(inDialog: DialogPtr; {CONST}VAR inEvent: EventRecord; VAR ioItemHit: SInt16; inRefCon: UNIV Ptr; userRoutine: QTSModalFilterUPP): BOOLEAN; { old name was CallQTSModalFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QuickTimeStreamingIncludes}

{$ENDC} {__QUICKTIMESTREAMING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

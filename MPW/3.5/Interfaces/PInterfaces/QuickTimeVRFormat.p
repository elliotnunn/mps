{
     File:       QuickTimeVRFormat.p
 
     Contains:   QuickTime VR interfaces
 
     Version:    Technology: QuickTime VR 5.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1997-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QuickTimeVRFormat;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QUICKTIMEVRFORMAT__}
{$SETC __QUICKTIMEVRFORMAT__ := 1}

{$I+}
{$SETC QuickTimeVRFormatIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}
{$IFC UNDEFINED __QUICKTIMEVR__}
{$I QuickTimeVR.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{  User data type for the Movie Controller type specifier }

CONST
	kQTControllerType			= 'ctyp';						{  Atom & ID of where our }
	kQTControllerID				= 1;							{  ...controller name is stored }

	{  VRWorld atom types }
	kQTVRWorldHeaderAtomType	= 'vrsc';
	kQTVRImagingParentAtomType	= 'imgp';
	kQTVRPanoImagingAtomType	= 'impn';
	kQTVRObjectImagingAtomType	= 'imob';
	kQTVRNodeParentAtomType		= 'vrnp';
	kQTVRNodeIDAtomType			= 'vrni';
	kQTVRNodeLocationAtomType	= 'nloc';
	kQTVRCursorParentAtomType	= 'vrcp';						{  New with 2.1 }
	kQTVRCursorAtomType			= 'CURS';						{  New with 2.1 }
	kQTVRColorCursorAtomType	= 'crsr';						{  New with 2.1 }

	{  NodeInfo atom types }
	kQTVRNodeHeaderAtomType		= 'ndhd';
	kQTVRHotSpotParentAtomType	= 'hspa';
	kQTVRHotSpotAtomType		= 'hots';
	kQTVRHotSpotInfoAtomType	= 'hsin';
	kQTVRLinkInfoAtomType		= 'link';

	{  Miscellaneous atom types }
	kQTVRStringAtomType			= 'vrsg';
	kQTVRStringEncodingAtomType	= 'vrse';						{  New with 2.1 }
	kQTVRPanoSampleDataAtomType	= 'pdat';
	kQTVRObjectInfoAtomType		= 'obji';
	kQTVRImageTrackRefAtomType	= 'imtr';						{  Parent is kQTVRObjectInfoAtomType. Required if track ref is not 1 as required by 2.0 format. }
	kQTVRHotSpotTrackRefAtomType = 'hstr';						{  Parent is kQTVRObjectInfoAtomType. Required if track ref is not 1 as required by 2.0 format. }
	kQTVRAngleRangeAtomType		= 'arng';
	kQTVRTrackRefArrayAtomType	= 'tref';
	kQTVRPanConstraintAtomType	= 'pcon';
	kQTVRTiltConstraintAtomType	= 'tcon';
	kQTVRFOVConstraintAtomType	= 'fcon';
	kQTVRCubicViewAtomType		= 'cuvw';						{  New with 5.0 }
	kQTVRCubicFaceDataAtomType	= 'cufa';						{  New with 5.0 }

	kQTVRObjectInfoAtomID		= 1;
	kQTVRObjectImageTrackRefAtomID = 1;							{  New with 2.1, it adds a track reference to select between multiple image tracks }
	kQTVRObjectHotSpotTrackRefAtomID = 1;						{  New with 2.1, it adds a track reference to select between multiple hotspot tracks }

	{  Track reference types }
	kQTVRImageTrackRefType		= 'imgt';
	kQTVRHotSpotTrackRefType	= 'hott';

	{  Old hot spot types }
	kQTVRHotSpotNavigableType	= 'navg';

	{  Valid bits used in QTVRLinkHotSpotAtom }
	kQTVRValidPan				= $00000001;
	kQTVRValidTilt				= $00000002;
	kQTVRValidFOV				= $00000004;
	kQTVRValidViewCenter		= $00000008;


	{  Values for flags field in QTVRPanoSampleAtom }
	kQTVRPanoFlagHorizontal		= $00000001;
	kQTVRPanoFlagLast			= $80000000;


	{  Values for locationFlags field in QTVRNodeLocationAtom }
	kQTVRSameFile				= 0;


	{  Header for QTVR track's Sample Description record (vrWorld atom container is appended) }

TYPE
	QTVRSampleDescriptionPtr = ^QTVRSampleDescription;
	QTVRSampleDescription = RECORD
		descSize:				UInt32;									{  total size of the QTVRSampleDescription }
		descType:				UInt32;									{  must be 'qtvr' }
		reserved1:				UInt32;									{  must be zero }
		reserved2:				UInt16;									{  must be zero }
		dataRefIndex:			UInt16;									{  must be zero }
		data:					UInt32;									{  Will be extended to hold vrWorld QTAtomContainer }
	END;

	QTVRSampleDescriptionHandle			= ^QTVRSampleDescriptionPtr;
	{
	  =================================================================================================
	   Definitions and structures used in the VRWorld QTAtomContainer
	  -------------------------------------------------------------------------------------------------
	}

	QTVRStringAtomPtr = ^QTVRStringAtom;
	QTVRStringAtom = RECORD
		stringUsage:			UInt16;
		stringLength:			UInt16;
		theString:				PACKED ARRAY [0..3] OF UInt8;			{  field previously named "string" }
	END;


	QTVRWorldHeaderAtomPtr = ^QTVRWorldHeaderAtom;
	QTVRWorldHeaderAtom = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		nameAtomID:				QTAtomID;
		defaultNodeID:			UInt32;
		vrWorldFlags:			UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;


	{  Valid bits used in QTVRPanoImagingAtom }

CONST
	kQTVRValidCorrection		= $00000001;
	kQTVRValidQuality			= $00000002;
	kQTVRValidDirectDraw		= $00000004;
	kQTVRValidFirstExtraProperty = $00000008;


TYPE
	QTVRPanoImagingAtomPtr = ^QTVRPanoImagingAtom;
	QTVRPanoImagingAtom = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		imagingMode:			UInt32;
		imagingValidFlags:		UInt32;
		correction:				UInt32;
		quality:				UInt32;
		directDraw:				UInt32;
		imagingProperties:		ARRAY [0..5] OF UInt32;					{  for future properties }
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

	QTVRNodeLocationAtomPtr = ^QTVRNodeLocationAtom;
	QTVRNodeLocationAtom = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		nodeType:				OSType;
		locationFlags:			UInt32;
		locationData:			UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

	{
	  =================================================================================================
	   Definitions and structures used in the Nodeinfo QTAtomContainer
	  -------------------------------------------------------------------------------------------------
	}

	QTVRNodeHeaderAtomPtr = ^QTVRNodeHeaderAtom;
	QTVRNodeHeaderAtom = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		nodeType:				OSType;
		nodeID:					QTAtomID;
		nameAtomID:				QTAtomID;
		commentAtomID:			QTAtomID;
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

	QTVRAngleRangeAtomPtr = ^QTVRAngleRangeAtom;
	QTVRAngleRangeAtom = RECORD
		minimumAngle:			Float32;
		maximumAngle:			Float32;
	END;

	QTVRHotSpotInfoAtomPtr = ^QTVRHotSpotInfoAtom;
	QTVRHotSpotInfoAtom = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		hotSpotType:			OSType;
		nameAtomID:				QTAtomID;
		commentAtomID:			QTAtomID;
		cursorID:				ARRAY [0..2] OF SInt32;
																		{  canonical view for this hot spot }
		bestPan:				Float32;
		bestTilt:				Float32;
		bestFOV:				Float32;
		bestViewCenter:			QTVRFloatPoint;
																		{  Bounding box for this hot spot }
		hotSpotRect:			Rect;
		flags:					UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

	QTVRLinkHotSpotAtomPtr = ^QTVRLinkHotSpotAtom;
	QTVRLinkHotSpotAtom = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		toNodeID:				UInt32;
		fromValidFlags:			UInt32;
		fromPan:				Float32;
		fromTilt:				Float32;
		fromFOV:				Float32;
		fromViewCenter:			QTVRFloatPoint;
		toValidFlags:			UInt32;
		toPan:					Float32;
		toTilt:					Float32;
		toFOV:					Float32;
		toViewCenter:			QTVRFloatPoint;
		distance:				Float32;
		flags:					UInt32;
		reserved1:				UInt32;
		reserved2:				UInt32;
	END;

	{
	  =================================================================================================
	   Definitions and structures used in Panorama and Object tracks
	  -------------------------------------------------------------------------------------------------
	}

	QTVRPanoSampleAtomPtr = ^QTVRPanoSampleAtom;
	QTVRPanoSampleAtom = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		imageRefTrackIndex:		UInt32;									{  track reference index of the full res image track }
		hotSpotRefTrackIndex:	UInt32;									{  track reference index of the full res hot spot track }
		minPan:					Float32;
		maxPan:					Float32;
		minTilt:				Float32;
		maxTilt:				Float32;
		minFieldOfView:			Float32;
		maxFieldOfView:			Float32;
		defaultPan:				Float32;
		defaultTilt:			Float32;
		defaultFieldOfView:		Float32;
																		{  Info for highest res version of image track }
		imageSizeX:				UInt32;									{  pixel width of the panorama (e.g. 768) }
		imageSizeY:				UInt32;									{  pixel height of the panorama (e.g. 2496) }
		imageNumFramesX:		UInt16;									{  diced frames wide (e.g. 1) }
		imageNumFramesY:		UInt16;									{  diced frames high (e.g. 24) }
																		{  Info for highest res version of hotSpot track }
		hotSpotSizeX:			UInt32;									{  pixel width of the hot spot panorama (e.g. 768) }
		hotSpotSizeY:			UInt32;									{  pixel height of the hot spot panorama (e.g. 2496) }
		hotSpotNumFramesX:		UInt16;									{  diced frames wide (e.g. 1) }
		hotSpotNumFramesY:		UInt16;									{  diced frames high (e.g. 24) }
		flags:					UInt32;
		panoType:				OSType;
		reserved2:				UInt32;
	END;

	{
	   View atom for cubes (since same fields in QTVRPanoSampleAtom are set to special
	   values for backwards compatibility and hence are ignored by the cubic engine)
	}
	QTVRCubicViewAtomPtr = ^QTVRCubicViewAtom;
	QTVRCubicViewAtom = RECORD
		minPan:					Float32;
		maxPan:					Float32;
		minTilt:				Float32;
		maxTilt:				Float32;
		minFieldOfView:			Float32;
		maxFieldOfView:			Float32;
		defaultPan:				Float32;
		defaultTilt:			Float32;
		defaultFieldOfView:		Float32;
	END;

	QTVRCubicFaceDataPtr = ^QTVRCubicFaceData;
	QTVRCubicFaceData = RECORD
		orientation:			ARRAY [0..3] OF Float32;				{  WXYZ quaternion of absolute orientation }
		center:					ARRAY [0..1] OF Float32;				{  Center of image relative to center of projection (default = (0,0)) in normalized units }
		aspect:					Float32;								{  aspect>1 => tall pixels; aspect <1 => squat pixels (default = 1) }
		skew:					Float32;								{  skew x by y (default = 0) }
	END;

	{  Special resolution values for the Image Track Reference Atoms. Use only one value per track reference. }

CONST
	kQTVRFullTrackRes			= $00000001;
	kQTVRHalfTrackRes			= $00000002;
	kQTVRQuarterTrackRes		= $00000004;
	kQTVRPreviewTrackRes		= $8000;


TYPE
	QTVRTrackRefEntryPtr = ^QTVRTrackRefEntry;
	QTVRTrackRefEntry = RECORD
		trackRefType:			UInt32;
		trackResolution:		UInt16;
		trackRefIndex:			UInt32;
	END;

	{
	  =================================================================================================
	   Object File format 2.0
	  -------------------------------------------------------------------------------------------------
	}

CONST
	kQTVRObjectAnimateViewFramesOn = $00000001;
	kQTVRObjectPalindromeViewFramesOn = $00000002;
	kQTVRObjectStartFirstViewFrameOn = $00000004;
	kQTVRObjectAnimateViewsOn	= $00000008;
	kQTVRObjectPalindromeViewsOn = $00000010;
	kQTVRObjectSyncViewToFrameRate = $00000020;
	kQTVRObjectDontLoopViewFramesOn = $00000040;
	kQTVRObjectPlayEveryViewFrameOn = $00000080;
	kQTVRObjectStreamingViewsOn	= $00000100;

	kQTVRObjectWrapPanOn		= $00000001;
	kQTVRObjectWrapTiltOn		= $00000002;
	kQTVRObjectCanZoomOn		= $00000004;
	kQTVRObjectReverseHControlOn = $00000008;
	kQTVRObjectReverseVControlOn = $00000010;
	kQTVRObjectSwapHVControlOn	= $00000020;
	kQTVRObjectTranslationOn	= $00000040;

	kGrabberScrollerUI			= 1;							{  "Object"  }
	kOldJoyStickUI				= 2;							{   "1.0 Object as Scene"      }
	kJoystickUI					= 3;							{  "Object In Scene" }
	kGrabberUI					= 4;							{  "Grabber only" }
	kAbsoluteUI					= 5;							{  "Absolute pointer" }



TYPE
	QTVRObjectSampleAtomPtr = ^QTVRObjectSampleAtom;
	QTVRObjectSampleAtom = RECORD
		majorVersion:			UInt16;									{  kQTVRMajorVersion }
		minorVersion:			UInt16;									{  kQTVRMinorVersion }
		movieType:				UInt16;									{  ObjectUITypes }
		viewStateCount:			UInt16;									{  The number of view states 1 based }
		defaultViewState:		UInt16;									{  The default view state number. The number must be 1 to viewStateCount }
		mouseDownViewState:		UInt16;									{  The mouse down view state.   The number must be 1 to viewStateCount }
		viewDuration:			UInt32;									{  The duration of each view including all animation frames in a view }
		columns:				UInt32;									{  Number of columns in movie }
		rows:					UInt32;									{  Number rows in movie }
		mouseMotionScale:		Float32;								{  180.0 for kStandardObject or kQTVRObjectInScene, actual degrees for kOldNavigableMovieScene. }
		minPan:					Float32;								{  Start   horizontal pan angle in degrees }
		maxPan:					Float32;								{  End     horizontal pan angle in degrees }
		defaultPan:				Float32;								{  Initial horizontal pan angle in degrees (poster view) }
		minTilt:				Float32;								{  Start   vertical   pan angle in degrees }
		maxTilt:				Float32;								{  End     vertical   pan angle in degrees }
		defaultTilt:			Float32;								{  Initial vertical   pan angle in degrees (poster view)   }
		minFieldOfView:			Float32;								{  minimum field of view setting (appears as the maximum zoom effect) must be >= 1 }
		fieldOfView:			Float32;								{  the field of view range must be >= 1 }
		defaultFieldOfView:		Float32;								{  must be in minFieldOfView and maxFieldOfView range inclusive }
		defaultViewCenterH:		Float32;
		defaultViewCenterV:		Float32;
		viewRate:				Float32;
		frameRate:				Float32;
		animationSettings:		UInt32;									{  32 reserved bit fields }
		controlSettings:		UInt32;									{  32 reserved bit fields }
	END;

	{
	  =================================================================================================
	   QuickTime VR Authoring Components
	  -------------------------------------------------------------------------------------------------
	}

	{
	   ComponentDescription constants for QTVR Export components   
	    (componentType = MovieExportType; componentSubType = MovieFileType)
	}

CONST
	kQTVRFlattenerManufacturer	= 'vrwe';						{  aka QTVRFlattenerType }
	kQTVRSplitterManufacturer	= 'vrsp';
	kQTVRObjExporterManufacturer = 'vrob';

	{  QuickTime VR Flattener atom types }
	kQTVRFlattenerSettingsParentAtomType = 'VRWe';				{  parent of settings atoms (other than compression) }
	kQTVRFlattenerPreviewResAtomType = 'PRes';					{  preview resolution Int16 }
	kQTVRFlattenerImportSpecAtomType = 'ISpe';					{  import file spec FSSpec }
	kQTVRFlattenerCreatePreviewAtomType = 'Prev';				{  Boolean }
	kQTVRFlattenerImportPreviewAtomType = 'IPre';				{  Boolean }
	kQTVRFlattenerBlurPreviewAtomType = 'Blur';					{  Boolean }

	{  QuickTime VR Splitter atom types }
	kQTVRSplitterSettingsParentAtomType = 'VRSp';				{  parent of settings atoms (other than compression) }
	kQTVRSplitterGenerateHTMLAtomType = 'Ghtm';					{  Boolean }
	kQTVRSplitterOverwriteFilesAtomType = 'Owfi';				{  Boolean }
	kQTVRSplitterUseFlattenerAtomType = 'Usef';					{  Boolean }
	kQTVRSplitterShowControllerAtomType = 'Shco';				{  Boolean }
	kQTVRSplitterTargetMyselfAtomType = 'Tgtm';					{  Boolean }

	{  QuickTime VR Object Exporter atom types }
	kQTVRObjExporterSettingsBlockSize = 'bsiz';					{  block size for compression }
	kQTVRObjExporterSettingsTargetSize = 'tsiz';				{  target file size }



{$IFC OLDROUTINENAMES }

TYPE
	VRStringAtom						= QTVRStringAtom;
	VRStringAtomPtr 					= ^VRStringAtom;
	VRWorldHeaderAtom					= QTVRWorldHeaderAtom;
	VRWorldHeaderAtomPtr 				= ^VRWorldHeaderAtom;
	VRPanoImagingAtom					= QTVRPanoImagingAtom;
	VRPanoImagingAtomPtr 				= ^VRPanoImagingAtom;
	VRNodeLocationAtom					= QTVRNodeLocationAtom;
	VRNodeLocationAtomPtr 				= ^VRNodeLocationAtom;
	VRNodeHeaderAtom					= QTVRNodeHeaderAtom;
	VRNodeHeaderAtomPtr 				= ^VRNodeHeaderAtom;
	VRAngleRangeAtom					= QTVRAngleRangeAtom;
	VRAngleRangeAtomPtr 				= ^VRAngleRangeAtom;
	VRHotSpotInfoAtom					= QTVRHotSpotInfoAtom;
	VRHotSpotInfoAtomPtr 				= ^VRHotSpotInfoAtom;
	VRLinkHotSpotAtom					= QTVRLinkHotSpotAtom;
	VRLinkHotSpotAtomPtr 				= ^VRLinkHotSpotAtom;
	VRPanoSampleAtom					= QTVRPanoSampleAtom;
	VRPanoSampleAtomPtr 				= ^VRPanoSampleAtom;
	VRTrackRefEntry						= QTVRTrackRefEntry;
	VRTrackRefEntryPtr 					= ^VRTrackRefEntry;
	VRObjectSampleAtom					= QTVRObjectSampleAtom;
	VRObjectSampleAtomPtr 				= ^VRObjectSampleAtom;
{$ENDC}  {OLDROUTINENAMES}



{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QuickTimeVRFormatIncludes}

{$ENDC} {__QUICKTIMEVRFORMAT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

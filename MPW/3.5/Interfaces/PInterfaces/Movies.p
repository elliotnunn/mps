{
     File:       Movies.p
 
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
 UNIT Movies;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MOVIES__}
{$SETC __MOVIES__ := 1}

{$I+}
{$SETC MoviesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __ALIASES__}
{$I Aliases.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __SOUND__}
{$I Sound.p}
{$ENDC}
{$IFC UNDEFINED __IMAGECOMPRESSION__}
{$I ImageCompression.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{  "kFix1" is defined in FixMath as "fixed1"  }
{ error codes are in Errors.[haa] }
{ gestalt codes are in Gestalt.[hpa] }

CONST
	MovieFileType				= 'MooV';
	MovieScrapType				= 'moov';

	MovieResourceType			= 'moov';
	MovieForwardPointerResourceType = 'fore';
	MovieBackwardPointerResourceType = 'back';

	MovieResourceAtomType		= 'moov';
	MovieDataAtomType			= 'mdat';
	FreeAtomType				= 'free';
	SkipAtomType				= 'skip';
	WideAtomPlaceholderType		= 'wide';

	MediaHandlerType			= 'mhlr';
	DataHandlerType				= 'dhlr';

	VideoMediaType				= 'vide';
	SoundMediaType				= 'soun';
	TextMediaType				= 'text';
	BaseMediaType				= 'gnrc';
	MPEGMediaType				= 'MPEG';
	MusicMediaType				= 'musi';
	TimeCodeMediaType			= 'tmcd';
	SpriteMediaType				= 'sprt';
	FlashMediaType				= 'flsh';
	MovieMediaType				= 'moov';
	TweenMediaType				= 'twen';
	ThreeDeeMediaType			= 'qd3d';
	HandleDataHandlerSubType	= 'hndl';
	PointerDataHandlerSubType	= 'ptr ';
	NullDataHandlerSubType		= 'null';
	ResourceDataHandlerSubType	= 'rsrc';
	URLDataHandlerSubType		= 'url ';
	WiredActionHandlerType		= 'wire';

	VisualMediaCharacteristic	= 'eyes';
	AudioMediaCharacteristic	= 'ears';
	kCharacteristicCanSendVideo	= 'vsnd';
	kCharacteristicProvidesActions = 'actn';
	kCharacteristicNonLinear	= 'nonl';
	kCharacteristicCanStep		= 'step';
	kCharacteristicHasNoDuration = 'noti';

	kUserDataMovieControllerType = 'ctyp';
	kUserDataName				= 'name';
	kUserDataTextAlbum			= '©alb';
	kUserDataTextArtist			= '©ART';
	kUserDataTextAuthor			= '©aut';
	kUserDataTextChapter		= '©chp';
	kUserDataTextComment		= '©cmt';
	kUserDataTextComposer		= '©com';
	kUserDataTextCopyright		= '©cpy';
	kUserDataTextCreationDate	= '©day';
	kUserDataTextDescription	= '©des';
	kUserDataTextDirector		= '©dir';
	kUserDataTextDisclaimer		= '©dis';
	kUserDataTextEncodedBy		= '©enc';
	kUserDataTextFullName		= '©nam';
	kUserDataTextGenre			= '©gen';
	kUserDataTextHostComputer	= '©hst';
	kUserDataTextInformation	= '©inf';
	kUserDataTextKeywords		= '©key';
	kUserDataTextMake			= '©mak';
	kUserDataTextModel			= '©mod';
	kUserDataTextOriginalArtist	= '©ope';
	kUserDataTextOriginalFormat	= '©fmt';
	kUserDataTextOriginalSource	= '©src';
	kUserDataTextPerformers		= '©prf';
	kUserDataTextProducer		= '©prd';
	kUserDataTextProduct		= '©PRD';
	kUserDataTextSoftware		= '©swr';
	kUserDataTextSpecialPlaybackRequirements = '©req';
	kUserDataTextTrack			= '©trk';
	kUserDataTextWarning		= '©wrn';
	kUserDataTextWriter			= '©wrt';
	kUserDataTextURLLink		= '©url';
	kUserDataTextEditDate1		= '©ed1';

	kUserDataUnicodeBit			= $00000080;

	DoTheRightThing				= 0;



TYPE
	MovieRecordPtr = ^MovieRecord;
	MovieRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	Movie								= ^MovieRecord;
	MoviePtr							= ^Movie;
	TrackRecordPtr = ^TrackRecord;
	TrackRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	Track								= ^TrackRecord;
	MediaRecordPtr = ^MediaRecord;
	MediaRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	Media								= ^MediaRecord;
	UserDataRecordPtr = ^UserDataRecord;
	UserDataRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	UserData							= ^UserDataRecord;
	TrackEditStateRecordPtr = ^TrackEditStateRecord;
	TrackEditStateRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	TrackEditState						= ^TrackEditStateRecord;
	MovieEditStateRecordPtr = ^MovieEditStateRecord;
	MovieEditStateRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	MovieEditState						= ^MovieEditStateRecord;
	SpriteWorldRecordPtr = ^SpriteWorldRecord;
	SpriteWorldRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	SpriteWorld							= ^SpriteWorldRecord;
	SpriteRecordPtr = ^SpriteRecord;
	SpriteRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	Sprite								= ^SpriteRecord;
	QTTweenerRecordPtr = ^QTTweenerRecord;
	QTTweenerRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	QTTweener							= ^QTTweenerRecord;
	SampleDescriptionPtr = ^SampleDescription;
	SampleDescription = RECORD
		descSize:				LONGINT;
		dataFormat:				LONGINT;
		resvd1:					LONGINT;
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
	END;

	SampleDescriptionHandle				= ^SampleDescriptionPtr;
	QTBandwidthReference    = ^LONGINT; { an opaque 32-bit type }
	QTBandwidthReferencePtr = ^QTBandwidthReference;  { when a VAR xx:QTBandwidthReference parameter can be nil, it is changed to xx: QTBandwidthReferencePtr }
	QTScheduledBandwidthReference    = ^LONGINT; { an opaque 32-bit type }
	QTScheduledBandwidthReferencePtr = ^QTScheduledBandwidthReference;  { when a VAR xx:QTScheduledBandwidthReference parameter can be nil, it is changed to xx: QTScheduledBandwidthReferencePtr }

CONST
	kQTNetworkStatusNoNetwork	= -2;
	kQTNetworkStatusUncertain	= -1;
	kQTNetworkStatusNotConnected = 0;
	kQTNetworkStatusConnected	= 1;


TYPE
	QTAtomContainer						= Handle;
	QTAtom								= LONGINT;
	QTAtomType							= LONGINT;
	QTAtomID							= LONGINT;
	{  QTFloatDouble is the 64-bit IEEE-754 standard }
	QTFloatDouble						= Float64;
	{  QTFloatSingle is the 32-bit IEEE-754 standard }
	QTFloatSingle						= Float32;


	SoundDescriptionPtr = ^SoundDescription;
	SoundDescription = RECORD
		descSize:				LONGINT;								{  total size of SoundDescription including extra data  }
		dataFormat:				LONGINT;								{  sound format  }
		resvd1:					LONGINT;								{  reserved for apple use. set to zero  }
		resvd2:					INTEGER;								{  reserved for apple use. set to zero  }
		dataRefIndex:			INTEGER;
		version:				INTEGER;								{  which version is this data  }
		revlevel:				INTEGER;								{  what version of that codec did this  }
		vendor:					LONGINT;								{  whose  codec compressed this data  }
		numChannels:			INTEGER;								{  number of channels of sound  }
		sampleSize:				INTEGER;								{  number of bits per sample  }
		compressionID:			INTEGER;								{  unused. set to zero.  }
		packetSize:				INTEGER;								{  unused. set to zero.  }
		sampleRate:				UnsignedFixed;							{  sample rate sound is captured at  }
	END;

	SoundDescriptionHandle				= ^SoundDescriptionPtr;
	{  version 1 of the SoundDescription record }
	SoundDescriptionV1Ptr = ^SoundDescriptionV1;
	SoundDescriptionV1 = RECORD
																		{  original fields }
		desc:					SoundDescription;
																		{  fixed compression ratio information }
		samplesPerPacket:		UInt32;
		bytesPerPacket:			UInt32;
		bytesPerFrame:			UInt32;
		bytesPerSample:			UInt32;
																		{  additional atom based fields ([long size, long type, some data], repeat) }
	END;

	SoundDescriptionV1Handle			= ^SoundDescriptionV1Ptr;
	TextDescriptionPtr = ^TextDescription;
	TextDescription = RECORD
		descSize:				LONGINT;								{  Total size of TextDescription }
		dataFormat:				LONGINT;								{  'text' }
		resvd1:					LONGINT;
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
		displayFlags:			LONGINT;								{  see enum below for flag values }
		textJustification:		LONGINT;								{  Can be: teCenter,teFlush -Default,-Right,-Left }
		bgColor:				RGBColor;								{  Background color }
		defaultTextBox:			Rect;									{  Location to place the text within the track bounds }
		defaultStyle:			ScrpSTElement;							{  Default style (struct defined in TextEdit.h) }
		defaultFontName:		SInt8;									{  Font Name (pascal string - struct extended to fit)  }
	END;

	TextDescriptionHandle				= ^TextDescriptionPtr;
	SpriteDescriptionPtr = ^SpriteDescription;
	SpriteDescription = RECORD
		descSize:				LONGINT;								{  total size of SpriteDescription including extra data  }
		dataFormat:				LONGINT;								{    }
		resvd1:					LONGINT;								{  reserved for apple use  }
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
		version:				LONGINT;								{  which version is this data  }
		decompressorType:		OSType;									{  which decompressor to use, 0 for no decompression  }
		sampleFlags:			LONGINT;								{  how to interpret samples  }
	END;

	SpriteDescriptionHandle				= ^SpriteDescriptionPtr;
	FlashDescriptionPtr = ^FlashDescription;
	FlashDescription = RECORD
		descSize:				LONGINT;
		dataFormat:				LONGINT;
		resvd1:					LONGINT;
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
		version:				LONGINT;								{  which version is this data  }
		decompressorType:		OSType;									{  which decompressor to use, 0 for no decompression  }
		flags:					LONGINT;
	END;

	FlashDescriptionHandle				= ^FlashDescriptionPtr;
	ThreeDeeDescriptionPtr = ^ThreeDeeDescription;
	ThreeDeeDescription = RECORD
		descSize:				LONGINT;								{  total size of ThreeDeeDescription including extra data  }
		dataFormat:				LONGINT;								{    }
		resvd1:					LONGINT;								{  reserved for apple use  }
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
		version:				LONGINT;								{  which version is this data  }
		rendererType:			LONGINT;								{  which renderer to use, 0 for default  }
		decompressorType:		LONGINT;								{  which decompressor to use, 0 for default  }
	END;

	ThreeDeeDescriptionHandle			= ^ThreeDeeDescriptionPtr;
	DataReferenceRecordPtr = ^DataReferenceRecord;
	DataReferenceRecord = RECORD
		dataRefType:			OSType;
		dataRef:				Handle;
	END;

	DataReferencePtr					= ^DataReferenceRecord;
	{	--------------------------
	  Music Sample Description
	--------------------------	}
	MusicDescriptionPtr = ^MusicDescription;
	MusicDescription = RECORD
		descSize:				LONGINT;
		dataFormat:				LONGINT;								{  'musi'  }
		resvd1:					LONGINT;
		resvd2:					INTEGER;
		dataRefIndex:			INTEGER;
		musicFlags:				LONGINT;
		headerData:				ARRAY [0..0] OF UInt32;					{  variable size!  }
	END;

	MusicDescriptionHandle				= ^MusicDescriptionPtr;

CONST
	kMusicFlagDontPlay2Soft		= $00000001;
	kMusicFlagDontSlaveToMovie	= $00000002;


	dfDontDisplay				= $01;							{  Don't display the text }
	dfDontAutoScale				= $02;							{  Don't scale text as track bounds grows or shrinks }
	dfClipToTextBox				= $04;							{  Clip update to the textbox }
	dfUseMovieBGColor			= $08;							{  Set text background to movie's background color }
	dfShrinkTextBoxToFit		= $10;							{  Compute minimum box to fit the sample }
	dfScrollIn					= $20;							{  Scroll text in until last of text is in view  }
	dfScrollOut					= $40;							{  Scroll text out until last of text is gone (if both set, scroll in then out) }
	dfHorizScroll				= $80;							{  Scroll text horizontally (otherwise it's vertical) }
	dfReverseScroll				= $0100;						{  vert: scroll down rather than up; horiz: scroll backwards (justfication dependent) }
	dfContinuousScroll			= $0200;						{  new samples cause previous samples to scroll out  }
	dfFlowHoriz					= $0400;						{  horiz scroll text flows in textbox rather than extend to right  }
	dfContinuousKaraoke			= $0800;						{  ignore begin offset, hilite everything up to the end offset(karaoke) }
	dfDropShadow				= $1000;						{  display text with a drop shadow  }
	dfAntiAlias					= $2000;						{  attempt to display text anti aliased }
	dfKeyedText					= $4000;						{  key the text over background }
	dfInverseHilite				= $8000;						{  Use inverse hiliting rather than using hilite color }
	dfTextColorHilite			= $00010000;					{  changes text color in place of hiliting.  }

	searchTextDontGoToFoundTime	= $00010000;
	searchTextDontHiliteFoundText = $00020000;
	searchTextOneTrackOnly		= $00040000;
	searchTextEnabledTracksOnly	= $00080000;

	{ use these with the text property routines }
																{  set property parameter / get property parameter }
	kTextTextHandle				= 1;							{  Handle / preallocated Handle }
	kTextTextPtr				= 2;							{  Pointer }
	kTextTEStyle				= 3;							{  TextStyle * / TextStyle * }
	kTextSelection				= 4;							{  long [2] / long [2] }
	kTextBackColor				= 5;							{  RGBColor * / RGBColor * }
	kTextForeColor				= 6;							{  RGBColor * / RGBColor * }
	kTextFace					= 7;							{  long / long * }
	kTextFont					= 8;							{  long / long * }
	kTextSize					= 9;							{  long / long * }
	kTextAlignment				= 10;							{  short * / short * }
	kTextHilite					= 11;							{  hiliteRecord * / hiliteRecord * }
	kTextDropShadow				= 12;							{  dropShadowRecord * / dropShadowRecord * }
	kTextDisplayFlags			= 13;							{  long / long * }
	kTextScroll					= 14;							{  TimeValue * / TimeValue * }
	kTextRelativeScroll			= 15;							{  Point * }
	kTextHyperTextFace			= 16;							{  hyperTextSetFace * / hyperTextSetFace * }
	kTextHyperTextColor			= 17;							{  hyperTextSetColor * / hyperTextSetColor * }
	kTextKeyEntry				= 18;							{  short }
	kTextMouseDown				= 19;							{  Point * }
	kTextTextBox				= 20;							{  Rect * / Rect * }
	kTextEditState				= 21;							{  short / short * }
	kTextLength					= 22;							{        / long * }

	k3DMediaRendererEntry		= 'rend';
	k3DMediaRendererName		= 'name';
	k3DMediaRendererCode		= 'rcod';

	{	 progress messages 	}
	movieProgressOpen			= 0;
	movieProgressUpdatePercent	= 1;
	movieProgressClose			= 2;

	{	 progress operations 	}
	progressOpFlatten			= 1;
	progressOpInsertTrackSegment = 2;
	progressOpInsertMovieSegment = 3;
	progressOpPaste				= 4;
	progressOpAddMovieSelection	= 5;
	progressOpCopy				= 6;
	progressOpCut				= 7;
	progressOpLoadMovieIntoRam	= 8;
	progressOpLoadTrackIntoRam	= 9;
	progressOpLoadMediaIntoRam	= 10;
	progressOpImportMovie		= 11;
	progressOpExportMovie		= 12;

	mediaQualityDraft			= $0000;
	mediaQualityNormal			= $0040;
	mediaQualityBetter			= $0080;
	mediaQualityBest			= $00C0;

	{	****
	    Interactive Sprites Support
	****	}
	{  QTEventRecord flags }
	kQTEventPayloadIsQTList		= $00000001;


TYPE
	QTEventRecordPtr = ^QTEventRecord;
	QTEventRecord = RECORD
		version:				LONGINT;
		eventType:				OSType;
		where:					Point;
		flags:					LONGINT;
		payloadRefcon:			LONGINT;								{  from here down only present if version >= 2 }
		param1:					LONGINT;
		param2:					LONGINT;
		param3:					LONGINT;
	END;

	QTAtomSpecPtr = ^QTAtomSpec;
	QTAtomSpec = RECORD
		container:				QTAtomContainer;
		atom:					QTAtom;
	END;

	ResolvedQTEventSpecPtr = ^ResolvedQTEventSpec;
	ResolvedQTEventSpec = RECORD
		actionAtom:				QTAtomSpec;
		targetTrack:			Track;
		targetRefCon:			LONGINT;
	END;


	{  action constants  }

CONST
	kActionMovieSetVolume		= 1024;							{  (short movieVolume)  }
	kActionMovieSetRate			= 1025;							{  (Fixed rate)  }
	kActionMovieSetLoopingFlags	= 1026;							{  (long loopingFlags)  }
	kActionMovieGoToTime		= 1027;							{  (TimeValue time)  }
	kActionMovieGoToTimeByName	= 1028;							{  (Str255 timeName)  }
	kActionMovieGoToBeginning	= 1029;							{  no params  }
	kActionMovieGoToEnd			= 1030;							{  no params  }
	kActionMovieStepForward		= 1031;							{  no params  }
	kActionMovieStepBackward	= 1032;							{  no params  }
	kActionMovieSetSelection	= 1033;							{  (TimeValue startTime, TimeValue endTime)  }
	kActionMovieSetSelectionByName = 1034;						{  (Str255 startTimeName, Str255 endTimeName)  }
	kActionMoviePlaySelection	= 1035;							{  (Boolean selectionOnly)  }
	kActionMovieSetLanguage		= 1036;							{  (long language)  }
	kActionMovieChanged			= 1037;							{  no params  }
	kActionMovieRestartAtTime	= 1038;							{  (TimeValue startTime, Fixed rate)  }
	kActionTrackSetVolume		= 2048;							{  (short volume)  }
	kActionTrackSetBalance		= 2049;							{  (short balance)  }
	kActionTrackSetEnabled		= 2050;							{  (Boolean enabled)  }
	kActionTrackSetMatrix		= 2051;							{  (MatrixRecord matrix)  }
	kActionTrackSetLayer		= 2052;							{  (short layer)  }
	kActionTrackSetClip			= 2053;							{  (RgnHandle clip)  }
	kActionTrackSetCursor		= 2054;							{  (QTATomID cursorID)  }
	kActionTrackSetGraphicsMode	= 2055;							{  (ModifierTrackGraphicsModeRecord graphicsMode)  }
	kActionTrackSetIdleFrequency = 2056;						{  (long frequency)  }
	kActionTrackSetBassTreble	= 2057;							{  (short base, short treble)  }
	kActionSpriteSetMatrix		= 3072;							{  (MatrixRecord matrix)  }
	kActionSpriteSetImageIndex	= 3073;							{  (short imageIndex)  }
	kActionSpriteSetVisible		= 3074;							{  (short visible)  }
	kActionSpriteSetLayer		= 3075;							{  (short layer)  }
	kActionSpriteSetGraphicsMode = 3076;						{  (ModifierTrackGraphicsModeRecord graphicsMode)  }
	kActionSpritePassMouseToCodec = 3078;						{  no params  }
	kActionSpriteClickOnCodec	= 3079;							{  Point localLoc  }
	kActionSpriteTranslate		= 3080;							{  (Fixed x, Fixed y, Boolean isAbsolute)  }
	kActionSpriteScale			= 3081;							{  (Fixed xScale, Fixed yScale)  }
	kActionSpriteRotate			= 3082;							{  (Fixed degrees)  }
	kActionSpriteStretch		= 3083;							{  (Fixed p1x, Fixed p1y, Fixed p2x, Fixed p2y, Fixed p3x, Fixed p3y, Fixed p4x, Fixed p4y)  }
	kActionQTVRSetPanAngle		= 4096;							{  (float panAngle)  }
	kActionQTVRSetTiltAngle		= 4097;							{  (float tiltAngle)  }
	kActionQTVRSetFieldOfView	= 4098;							{  (float fieldOfView)  }
	kActionQTVRShowDefaultView	= 4099;							{  no params  }
	kActionQTVRGoToNodeID		= 4100;							{  (UInt32 nodeID)  }
	kActionQTVREnableHotSpot	= 4101;							{  long ID, Boolean enable  }
	kActionQTVRShowHotSpots		= 4102;							{  Boolean show  }
	kActionQTVRTranslateObject	= 4103;							{  float xMove, float yMove  }
	kActionMusicPlayNote		= 5120;							{  (long sampleDescIndex, long partNumber, long delay, long pitch, long velocity, long duration)  }
	kActionMusicSetController	= 5121;							{  (long sampleDescIndex, long partNumber, long delay, long controller, long value)  }
	kActionCase					= 6144;							{  [(CaseStatementActionAtoms)]  }
	kActionWhile				= 6145;							{  [(WhileStatementActionAtoms)]  }
	kActionGoToURL				= 6146;							{  (C string urlLink)  }
	kActionSendQTEventToSprite	= 6147;							{  ([(SpriteTargetAtoms)], QTEventRecord theEvent)  }
	kActionDebugStr				= 6148;							{  (Str255 theString)  }
	kActionPushCurrentTime		= 6149;							{  no params  }
	kActionPushCurrentTimeWithLabel = 6150;						{  (Str255 theLabel)  }
	kActionPopAndGotoTopTime	= 6151;							{  no params  }
	kActionPopAndGotoLabeledTime = 6152;						{  (Str255 theLabel)  }
	kActionStatusString			= 6153;							{  (C string theString, long stringTypeFlags)  }
	kActionSendQTEventToTrackObject = 6154;						{  ([(TrackObjectTargetAtoms)], QTEventRecord theEvent)  }
	kActionAddChannelSubscription = 6155;						{  (Str255 channelName, C string channelsURL, C string channelsPictureURL)  }
	kActionRemoveChannelSubscription = 6156;					{  (C string channelsURL)  }
	kActionOpenCustomActionHandler = 6157;						{  (long handlerID, ComponentDescription handlerDesc)  }
	kActionDoScript				= 6158;							{  (long scriptTypeFlags, CString command, CString arguments)  }
	kActionDoCompressedActions	= 6159;							{  (compressed QTAtomContainer prefixed with eight bytes: long compressorType, long decompressedSize)  }
	kActionSendAppMessage		= 6160;							{  (long appMessageID)  }
	kActionLoadComponent		= 6161;							{  (ComponentDescription handlerDesc)  }
	kActionSetFocus				= 6162;							{  [(TargetAtoms theObject)]  }
	kActionDontPassKeyEvent		= 6163;							{  no params  }
	kActionSpriteTrackSetVariable = 7168;						{  (QTAtomID variableID, float value)  }
	kActionSpriteTrackNewSprite	= 7169;							{  (QTAtomID spriteID, short imageIndex, MatrixRecord *matrix, short visible, short layer, ModifierTrackGraphicsModeRecord *graphicsMode, QTAtomID actionHandlingSpriteID)  }
	kActionSpriteTrackDisposeSprite = 7170;						{  (QTAtomID spriteID)  }
	kActionSpriteTrackSetVariableToString = 7171;				{  (QTAtomID variableID, C string value)  }
	kActionSpriteTrackConcatVariables = 7172;					{  (QTAtomID firstVariableID, QTAtomID secondVariableID, QTAtomID resultVariableID )  }
	kActionSpriteTrackSetVariableToMovieURL = 7173;				{  (QTAtomID variableID, < optional: [(MovieTargetAtoms)] > )  }
	kActionSpriteTrackSetVariableToMovieBaseURL = 7174;			{  (QTAtomID variableID, < optional: [(MovieTargetAtoms)] > )  }
	kActionApplicationNumberAndString = 8192;					{  (long aNumber, Str255 aString )  }
	kActionQD3DNamedObjectTranslateTo = 9216;					{  (Fixed x, Fixed y, Fixed z )  }
	kActionQD3DNamedObjectScaleTo = 9217;						{  (Fixed xScale, Fixed yScale, Fixed zScale )  }
	kActionQD3DNamedObjectRotateTo = 9218;						{  (Fixed xDegrees, Fixed yDegrees, Fixed zDegrees )  }
	kActionFlashTrackSetPan		= 10240;						{  (short xPercent, short yPercent )  }
	kActionFlashTrackSetZoom	= 10241;						{  (short zoomFactor )  }
	kActionFlashTrackSetZoomRect = 10242;						{  (long left, long top, long right, long bottom )  }
	kActionFlashTrackGotoFrameNumber = 10243;					{  (long frameNumber )  }
	kActionFlashTrackGotoFrameLabel = 10244;					{  (C string frameLabel )  }
	kActionFlashTrackSetFlashVariable = 10245;					{  (C string path, C string name, C string value, Boolean updateFocus)  }
	kActionFlashTrackDoButtonActions = 10246;					{  (C string path, long buttonID, long transition)  }
	kActionMovieTrackAddChildMovie = 11264;						{  (QTAtomID childMovieID, C string childMovieURL)  }
	kActionMovieTrackLoadChildMovie = 11265;					{  (QTAtomID childMovieID)  }
	kActionMovieTrackLoadChildMovieWithQTListParams = 11266;	{  (QTAtomID childMovieID, C string qtlistXML)  }
	kActionTextTrackPasteText	= 12288;						{  (C string theText, long startSelection, long endSelection )  }
	kActionTextTrackSetTextBox	= 12291;						{  (short left, short top, short right, short bottom)  }
	kActionTextTrackSetTextStyle = 12292;						{  (Handle textStyle)  }
	kActionTextTrackSetSelection = 12293;						{  (long startSelection, long endSelection )  }
	kActionTextTrackSetBackgroundColor = 12294;					{  (ModifierTrackGraphicsModeRecord backgroundColor )  }
	kActionTextTrackSetForegroundColor = 12295;					{  (ModifierTrackGraphicsModeRecord foregroundColor )  }
	kActionTextTrackSetFace		= 12296;						{  (long fontFace )  }
	kActionTextTrackSetFont		= 12297;						{  (long fontID )  }
	kActionTextTrackSetSize		= 12298;						{  (long fontSize )  }
	kActionTextTrackSetAlignment = 12299;						{  (short alignment )  }
	kActionTextTrackSetHilite	= 12300;						{  (long startHighlight, long endHighlight, ModifierTrackGraphicsModeRecord highlightColor )  }
	kActionTextTrackSetDropShadow = 12301;						{  (Point dropShadow, short transparency )  }
	kActionTextTrackSetDisplayFlags = 12302;					{  (long flags )  }
	kActionTextTrackSetScroll	= 12303;						{  (long delay )  }
	kActionTextTrackRelativeScroll = 12304;						{  (short deltaX, short deltaY )  }
	kActionTextTrackFindText	= 12305;						{  (long flags, Str255 theText, ModifierTrackGraphicsModeRecord highlightColor )  }
	kActionTextTrackSetHyperTextFace = 12306;					{  (short index, long fontFace )  }
	kActionTextTrackSetHyperTextColor = 12307;					{  (short index, ModifierTrackGraphicsModeRecord highlightColor )  }
	kActionTextTrackKeyEntry	= 12308;						{  (short character )  }
	kActionTextTrackMouseDown	= 12309;						{  no params  }
	kActionTextTrackSetEditable	= 12310;						{  (short editState)  }
	kActionListAddElement		= 13312;						{  (C string parentPath, long atIndex, C string newElementName)  }
	kActionListRemoveElements	= 13313;						{  (C string parentPath, long startIndex, long endIndex)  }
	kActionListSetElementValue	= 13314;						{  (C string elementPath, C string valueString)  }
	kActionListPasteFromXML		= 13315;						{  (C string xml, C string targetParentPath, long startIndex)  }
	kActionListSetMatchingFromXML = 13316;						{  (C string xml, C string targetParentPath)  }
	kActionListSetFromURL		= 13317;						{  (C string url, C string targetParentPath )  }
	kActionListExchangeLists	= 13318;						{  (C string url, C string parentPath)  }
	kActionListServerQuery		= 13319;						{  (C string url, C string keyValuePairs, long flags, C string parentPath)  }


	kOperandExpression			= 1;
	kOperandConstant			= 2;
	kOperandSubscribedToChannel	= 3;							{  C string channelsURL  }
	kOperandUniqueCustomActionHandlerID = 4;
	kOperandCustomActionHandlerIDIsOpen = 5;					{  long ID  }
	kOperandConnectionSpeed		= 6;
	kOperandGMTDay				= 7;
	kOperandGMTMonth			= 8;
	kOperandGMTYear				= 9;
	kOperandGMTHours			= 10;
	kOperandGMTMinutes			= 11;
	kOperandGMTSeconds			= 12;
	kOperandLocalDay			= 13;
	kOperandLocalMonth			= 14;
	kOperandLocalYear			= 15;
	kOperandLocalHours			= 16;
	kOperandLocalMinutes		= 17;
	kOperandLocalSeconds		= 18;
	kOperandRegisteredForQuickTimePro = 19;
	kOperandPlatformRunningOn	= 20;
	kOperandQuickTimeVersion	= 21;
	kOperandComponentVersion	= 22;							{  C string type, C string subType, C string manufacturer  }
	kOperandOriginalHandlerRefcon = 23;
	kOperandTicks				= 24;
	kOperandMaxLoadedTimeInMovie = 25;
	kOperandEventParameter		= 26;							{  short index  }
	kOperandFreeMemory			= 27;
	kOperandNetworkStatus		= 28;
	kOperandQuickTimeVersionRegistered = 29;					{  long version  }
	kOperandSystemVersion		= 30;
	kOperandMovieVolume			= 1024;
	kOperandMovieRate			= 1025;
	kOperandMovieIsLooping		= 1026;
	kOperandMovieLoopIsPalindrome = 1027;
	kOperandMovieTime			= 1028;
	kOperandMovieDuration		= 1029;
	kOperandMovieTimeScale		= 1030;
	kOperandMovieWidth			= 1031;
	kOperandMovieHeight			= 1032;
	kOperandMovieLoadState		= 1033;
	kOperandMovieTrackCount		= 1034;
	kOperandMovieIsActive		= 1035;
	kOperandMovieName			= 1036;
	kOperandMovieID				= 1037;
	kOperandTrackVolume			= 2048;
	kOperandTrackBalance		= 2049;
	kOperandTrackEnabled		= 2050;
	kOperandTrackLayer			= 2051;
	kOperandTrackWidth			= 2052;
	kOperandTrackHeight			= 2053;
	kOperandTrackDuration		= 2054;
	kOperandTrackName			= 2055;
	kOperandTrackID				= 2056;
	kOperandTrackIdleFrequency	= 2057;
	kOperandTrackBass			= 2058;
	kOperandTrackTreble			= 2059;
	kOperandSpriteBoundsLeft	= 3072;
	kOperandSpriteBoundsTop		= 3073;
	kOperandSpriteBoundsRight	= 3074;
	kOperandSpriteBoundsBottom	= 3075;
	kOperandSpriteImageIndex	= 3076;
	kOperandSpriteVisible		= 3077;
	kOperandSpriteLayer			= 3078;
	kOperandSpriteTrackVariable	= 3079;							{  [QTAtomID variableID]  }
	kOperandSpriteTrackNumSprites = 3080;
	kOperandSpriteTrackNumImages = 3081;
	kOperandSpriteID			= 3082;
	kOperandSpriteIndex			= 3083;
	kOperandSpriteFirstCornerX	= 3084;
	kOperandSpriteFirstCornerY	= 3085;
	kOperandSpriteSecondCornerX	= 3086;
	kOperandSpriteSecondCornerY	= 3087;
	kOperandSpriteThirdCornerX	= 3088;
	kOperandSpriteThirdCornerY	= 3089;
	kOperandSpriteFourthCornerX	= 3090;
	kOperandSpriteFourthCornerY	= 3091;
	kOperandSpriteImageRegistrationPointX = 3092;
	kOperandSpriteImageRegistrationPointY = 3093;
	kOperandSpriteTrackSpriteIDAtPoint = 3094;					{  short x, short y  }
	kOperandSpriteName			= 3095;
	kOperandQTVRPanAngle		= 4096;
	kOperandQTVRTiltAngle		= 4097;
	kOperandQTVRFieldOfView		= 4098;
	kOperandQTVRNodeID			= 4099;
	kOperandQTVRHotSpotsVisible	= 4100;
	kOperandQTVRViewCenterH		= 4101;
	kOperandQTVRViewCenterV		= 4102;
	kOperandMouseLocalHLoc		= 5120;							{  [TargetAtoms aTrack]  }
	kOperandMouseLocalVLoc		= 5121;							{  [TargetAtoms aTrack]  }
	kOperandKeyIsDown			= 5122;							{  [short modKeys, char asciiValue]  }
	kOperandRandom				= 5123;							{  [short min, short max]  }
	kOperandCanHaveFocus		= 5124;							{  [(TargetAtoms theObject)]  }
	kOperandHasFocus			= 5125;							{  [(TargetAtoms theObject)]  }
	kOperandTextTrackEditable	= 6144;
	kOperandTextTrackCopyText	= 6145;							{  long startSelection, long endSelection  }
	kOperandTextTrackStartSelection = 6146;
	kOperandTextTrackEndSelection = 6147;
	kOperandTextTrackTextBoxLeft = 6148;
	kOperandTextTrackTextBoxTop	= 6149;
	kOperandTextTrackTextBoxRight = 6150;
	kOperandTextTrackTextBoxBottom = 6151;
	kOperandTextTrackTextLength	= 6152;
	kOperandListCountElements	= 7168;							{  (C string parentPath)  }
	kOperandListGetElementPathByIndex = 7169;					{  (C string parentPath, long index)  }
	kOperandListGetElementValue	= 7170;							{  (C string elementPath)  }
	kOperandListCopyToXML		= 7171;							{  (C string parentPath, long startIndex, long endIndex)  }
	kOperandSin					= 8192;							{  float x     }
	kOperandCos					= 8193;							{  float x     }
	kOperandTan					= 8194;							{  float x     }
	kOperandATan				= 8195;							{  float x     }
	kOperandATan2				= 8196;							{  float y, float x    }
	kOperandDegreesToRadians	= 8197;							{  float x  }
	kOperandRadiansToDegrees	= 8198;							{  float x  }
	kOperandSquareRoot			= 8199;							{  float x  }
	kOperandExponent			= 8200;							{  float x  }
	kOperandLog					= 8201;							{  float x  }
	kOperandFlashTrackVariable	= 9216;							{  [CString path, CString name]  }
	kOperandStringLength		= 10240;						{  (C string text)  }
	kOperandStringCompare		= 10241;						{  (C string aText, C string bText, Boolean caseSensitive, Boolan diacSensitive)  }
	kOperandStringSubString		= 10242;						{  (C string text, long offset, long length)  }
	kOperandStringConcat		= 10243;						{  (C string aText, C string bText)  }

	kFirstMovieAction			= 1024;
	kLastMovieAction			= 1038;
	kFirstTrackAction			= 2048;
	kLastTrackAction			= 2057;
	kFirstSpriteAction			= 3072;
	kLastSpriteAction			= 3083;
	kFirstQTVRAction			= 4096;
	kLastQTVRAction				= 4103;
	kFirstMusicAction			= 5120;
	kLastMusicAction			= 5121;
	kFirstSystemAction			= 6144;
	kLastSystemAction			= 6163;
	kFirstSpriteTrackAction		= 7168;
	kLastSpriteTrackAction		= 7174;
	kFirstApplicationAction		= 8192;
	kLastApplicationAction		= 8192;
	kFirstQD3DNamedObjectAction	= 9216;
	kLastQD3DNamedObjectAction	= 9218;
	kFirstFlashTrackAction		= 10240;
	kLastFlashTrackAction		= 10246;
	kFirstMovieTrackAction		= 11264;
	kLastMovieTrackAction		= 11266;
	kFirstTextTrackAction		= 12288;
	kLastTextTrackAction		= 12310;
	kFirstMultiTargetAction		= 13312;
	kLastMultiTargetAction		= 13319;
	kFirstAction				= 1024;
	kLastAction					= 13319;

	{  target atom types }
	kTargetMovie				= 'moov';						{  no data  }
	kTargetMovieName			= 'mona';						{  (PString movieName)  }
	kTargetMovieID				= 'moid';						{  (long movieID)  }
	kTargetRootMovie			= 'moro';						{  no data  }
	kTargetParentMovie			= 'mopa';						{  no data  }
	kTargetChildMovieTrackName	= 'motn';						{  (PString childMovieTrackName)  }
	kTargetChildMovieTrackID	= 'moti';						{  (long childMovieTrackID)  }
	kTargetChildMovieTrackIndex	= 'motx';						{  (long childMovieTrackIndex)  }
	kTargetChildMovieMovieName	= 'momn';						{  (PString childMovieName)  }
	kTargetChildMovieMovieID	= 'momi';						{  (long childMovieID)  }
	kTargetTrackName			= 'trna';						{  (PString trackName)  }
	kTargetTrackID				= 'trid';						{  (long trackID)  }
	kTargetTrackType			= 'trty';						{  (OSType trackType)  }
	kTargetTrackIndex			= 'trin';						{  (long trackIndex)  }
	kTargetSpriteName			= 'spna';						{  (PString spriteName)  }
	kTargetSpriteID				= 'spid';						{  (QTAtomID spriteID)  }
	kTargetSpriteIndex			= 'spin';						{  (short spriteIndex)  }
	kTargetQD3DNamedObjectName	= 'nana';						{  (CString objectName)  }
	kTargetCurrentQTEventParams	= 'evpa';						{  no data  }

	{  action container atom types }
	kQTEventType				= 'evnt';
	kAction						= 'actn';
	kWhichAction				= 'whic';
	kActionParameter			= 'parm';
	kActionTarget				= 'targ';
	kActionFlags				= 'flag';
	kActionParameterMinValue	= 'minv';
	kActionParameterMaxValue	= 'maxv';
	kActionListAtomType			= 'list';
	kExpressionContainerAtomType = 'expr';
	kConditionalAtomType		= 'test';
	kOperatorAtomType			= 'oper';
	kOperandAtomType			= 'oprn';
	kCommentAtomType			= 'why ';
	kCustomActionHandler		= 'cust';
	kCustomHandlerID			= 'id  ';
	kCustomHandlerDesc			= 'desc';
	kQTEventRecordAtomType		= 'erec';

	{  QTEvent types  }
	kQTEventMouseClick			= 'clik';
	kQTEventMouseClickEnd		= 'cend';
	kQTEventMouseClickEndTriggerButton = 'trig';
	kQTEventMouseEnter			= 'entr';
	kQTEventMouseExit			= 'exit';
	kQTEventMouseMoved			= 'move';
	kQTEventFrameLoaded			= 'fram';
	kQTEventIdle				= 'idle';
	kQTEventKey					= 'key ';						{  qtevent.param1 = key, qtevent.param2 = modifiers, qtEvent.param3 = scanCode  }
	kQTEventMovieLoaded			= 'load';
	kQTEventRequestToModifyMovie = 'reqm';
	kQTEventListReceived		= 'list';

	{  flags for the kActionFlags atom  }
	kActionFlagActionIsDelta	= $00000002;
	kActionFlagParameterWrapsAround = $00000004;
	kActionFlagActionIsToggle	= $00000008;

	{  flags for stringTypeFlags field of the QTStatusStringRecord  }
	kStatusStringIsURLLink		= $00000002;
	kStatusStringIsStreamingStatus = $00000004;
	kStatusHasCodeNumber		= $00000008;					{  high 16 bits of stringTypeFlags is error code number }
	kStatusIsError				= $00000010;

	{  flags for scriptTypeFlags field of the QTDoScriptRecord }
	kScriptIsUnknownType		= $00000001;
	kScriptIsJavaScript			= $00000002;
	kScriptIsLingoEvent			= $00000004;
	kScriptIsVBEvent			= $00000008;
	kScriptIsProjectorCommand	= $00000010;
	kScriptIsAppleScript		= $00000020;

	{  flags for CheckQuickTimeRegistration routine }
	kQTRegistrationDialogTimeOutFlag = $01;
	kQTRegistrationDialogShowDialog = $02;
	kQTRegistrationDialogForceDialog = $04;

	{  constants for kOperatorAtomType IDs (operator types) }
	kOperatorAdd				= 'add ';
	kOperatorSubtract			= 'sub ';
	kOperatorMultiply			= 'mult';
	kOperatorDivide				= 'div ';
	kOperatorOr					= 'or  ';
	kOperatorAnd				= 'and ';
	kOperatorNot				= 'not ';
	kOperatorLessThan			= '<   ';
	kOperatorLessThanEqualTo	= '<=  ';
	kOperatorEqualTo			= '=   ';
	kOperatorNotEqualTo			= '!=  ';
	kOperatorGreaterThan		= '>   ';
	kOperatorGreaterThanEqualTo	= '>=  ';
	kOperatorModulo				= 'mod ';
	kOperatorIntegerDivide		= 'idiv';
	kOperatorAbsoluteValue		= 'abs ';
	kOperatorNegate				= 'neg ';

	{  constants for kOperandPlatformRunningOn }
	kPlatformMacintosh			= 1;
	kPlatformWindows			= 2;

	{  flags for kOperandSystemVersion }
	kSystemIsWindows9x			= $00010000;
	kSystemIsWindowsNT			= $00020000;

	{  constants for MediaPropertiesAtom }
	kMediaPropertyNonLinearAtomType = 'nonl';
	kMediaPropertyHasActions	= 105;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	MovieRgnCoverProcPtr = FUNCTION(theMovie: Movie; changedRgn: RgnHandle; refcon: LONGINT): OSErr;
{$ELSEC}
	MovieRgnCoverProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MovieProgressProcPtr = FUNCTION(theMovie: Movie; message: INTEGER; whatOperation: INTEGER; percentDone: Fixed; refcon: LONGINT): OSErr;
{$ELSEC}
	MovieProgressProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MovieDrawingCompleteProcPtr = FUNCTION(theMovie: Movie; refCon: LONGINT): OSErr;
{$ELSEC}
	MovieDrawingCompleteProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TrackTransferProcPtr = FUNCTION(t: Track; refCon: LONGINT): OSErr;
{$ELSEC}
	TrackTransferProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	GetMovieProcPtr = FUNCTION(offset: LONGINT; size: LONGINT; dataPtr: UNIV Ptr; refCon: UNIV Ptr): OSErr;
{$ELSEC}
	GetMovieProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MoviePreviewCallOutProcPtr = FUNCTION(refcon: LONGINT): BOOLEAN;
{$ELSEC}
	MoviePreviewCallOutProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	TextMediaProcPtr = FUNCTION(theText: Handle; theMovie: Movie; VAR displayFlag: INTEGER; refcon: LONGINT): OSErr;
{$ELSEC}
	TextMediaProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ActionsProcPtr = FUNCTION(refcon: UNIV Ptr; targetTrack: Track; targetRefCon: LONGINT; theEvent: QTEventRecordPtr): OSErr;
{$ELSEC}
	ActionsProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DoMCActionProcPtr = FUNCTION(refcon: UNIV Ptr; action: INTEGER; params: UNIV Ptr; VAR handled: BOOLEAN): OSErr;
{$ELSEC}
	DoMCActionProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MovieExecuteWiredActionsProcPtr = FUNCTION(theMovie: Movie; refcon: UNIV Ptr; flags: LONGINT; wiredActions: QTAtomContainer): OSErr;
{$ELSEC}
	MovieExecuteWiredActionsProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MoviePrePrerollCompleteProcPtr = PROCEDURE(theMovie: Movie; prerollErr: OSErr; refcon: UNIV Ptr);
{$ELSEC}
	MoviePrePrerollCompleteProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MoviesErrorProcPtr = PROCEDURE(theErr: OSErr; refcon: LONGINT);
{$ELSEC}
	MoviesErrorProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	MovieRgnCoverUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MovieRgnCoverUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MovieProgressUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MovieProgressUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MovieDrawingCompleteUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MovieDrawingCompleteUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TrackTransferUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TrackTransferUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	GetMovieUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	GetMovieUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MoviePreviewCallOutUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MoviePreviewCallOutUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	TextMediaUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TextMediaUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ActionsUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ActionsUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DoMCActionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DoMCActionUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MovieExecuteWiredActionsUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MovieExecuteWiredActionsUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MoviePrePrerollCompleteUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MoviePrePrerollCompleteUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MoviesErrorUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MoviesErrorUPP = UniversalProcPtr;
{$ENDC}	
	MediaHandler						= ComponentInstance;
	DataHandler							= ComponentInstance;
	MediaHandlerComponent				= Component;
	DataHandlerComponent				= Component;
	HandlerError						= ComponentResult;
	{	 TimeBase and TimeRecord moved to MacTypes.h 	}
	TimeBaseFlags 				= UInt32;
CONST
	loopTimeBase				= 1;
	palindromeLoopTimeBase		= 2;
	maintainTimeBaseZero		= 4;


TYPE
	CallBackRecordPtr = ^CallBackRecord;
	CallBackRecord = RECORD
		data:					ARRAY [0..0] OF LONGINT;
	END;

	QTCallBack							= ^CallBackRecord;
	{	 CallBack equates 	}
	QTCallBackFlags 			= UInt16;
CONST
	triggerTimeFwd				= $0001;						{  when curTime exceeds triggerTime going forward  }
	triggerTimeBwd				= $0002;						{  when curTime exceeds triggerTime going backwards  }
	triggerTimeEither			= $0003;						{  when curTime exceeds triggerTime going either direction  }
	triggerRateLT				= $0004;						{  when rate changes to less than trigger value  }
	triggerRateGT				= $0008;						{  when rate changes to greater than trigger value  }
	triggerRateEqual			= $0010;						{  when rate changes to equal trigger value  }
	triggerRateLTE				= $0014;
	triggerRateGTE				= $0018;
	triggerRateNotEqual			= $001C;
	triggerRateChange			= 0;
	triggerAtStart				= $0001;
	triggerAtStop				= $0002;


TYPE
	TimeBaseStatus 				= UInt32;
CONST
	timeBaseBeforeStartTime		= 1;
	timeBaseAfterStopTime		= 2;



TYPE
	QTCallBackType 				= UInt16;
CONST
	callBackAtTime				= 1;
	callBackAtRate				= 2;
	callBackAtTimeJump			= 3;
	callBackAtExtremes			= 4;
	callBackAtTimeBaseDisposed	= 5;
	callBackAtInterrupt			= $8000;
	callBackAtDeferredTask		= $4000;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	QTCallBackProcPtr = PROCEDURE(cb: QTCallBack; refCon: LONGINT);
{$ELSEC}
	QTCallBackProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	QTCallBackUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QTCallBackUPP = UniversalProcPtr;
{$ENDC}	

CONST
	qtcbNeedsRateChanges		= 1;							{  wants to know about rate changes  }
	qtcbNeedsTimeChanges		= 2;							{  wants to know about time changes  }
	qtcbNeedsStartStopChanges	= 4;							{  wants to know when TimeBase start/stop is changed }


TYPE
	QTCallBackHeaderPtr = ^QTCallBackHeader;
	QTCallBackHeader = RECORD
		callBackFlags:			LONGINT;
		reserved1:				LONGINT;
		qtPrivate:				ARRAY [0..39] OF SInt8;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	QTSyncTaskProcPtr = PROCEDURE(task: UNIV Ptr);
{$ELSEC}
	QTSyncTaskProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	QTSyncTaskUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QTSyncTaskUPP = UniversalProcPtr;
{$ENDC}	
	QTSyncTaskRecordPtr = ^QTSyncTaskRecord;
	QTSyncTaskRecord = RECORD
		qLink:					Ptr;
		proc:					QTSyncTaskUPP;
	END;

	QTSyncTaskPtr						= ^QTSyncTaskRecord;

CONST
	keepInRam					= $01;							{  load and make non-purgable }
	unkeepInRam					= $02;							{  mark as purgable }
	flushFromRam				= $04;							{  empty those handles }
	loadForwardTrackEdits		= $08;							{     load track edits into ram for playing forward }
	loadBackwardTrackEdits		= $10;							{     load track edits into ram for playing in reverse }

	newMovieActive				= $01;
	newMovieDontResolveDataRefs	= $02;
	newMovieDontAskUnresolvedDataRefs = $04;
	newMovieDontAutoAlternates	= $08;
	newMovieDontUpdateForeBackPointers = $10;
	newMovieDontAutoUpdateClock	= $20;
	newMovieAsyncOK				= $0100;
	newMovieIdleImportOK		= $0400;

	{	 track usage bits 	}
	trackUsageInMovie			= $02;
	trackUsageInPreview			= $04;
	trackUsageInPoster			= $08;

	{	 Add/GetMediaSample flags 	}
	mediaSampleNotSync			= $01;							{  sample is not a sync sample (eg. is frame differenced  }
	mediaSampleShadowSync		= $02;							{  sample is a shadow sync  }

	pasteInParallel				= $01;
	showUserSettingsDialog		= $02;
	movieToFileOnlyExport		= $04;
	movieFileSpecValid			= $08;

	nextTimeMediaSample			= $01;
	nextTimeMediaEdit			= $02;
	nextTimeTrackEdit			= $04;
	nextTimeSyncSample			= $08;
	nextTimeStep				= $10;
	nextTimeEdgeOK				= $4000;
	nextTimeIgnoreActiveSegment	= $8000;


TYPE
	nextTimeFlagsEnum					= UInt16;

CONST
	createMovieFileDeleteCurFile = $80000000;
	createMovieFileDontCreateMovie = $40000000;
	createMovieFileDontOpenFile	= $20000000;
	createMovieFileDontCreateResFile = $10000000;


TYPE
	createMovieFileFlagsEnum			= UInt32;

CONST
	flattenAddMovieToDataFork	= $00000001;
	flattenActiveTracksOnly		= $00000004;
	flattenDontInterleaveFlatten = $00000008;
	flattenFSSpecPtrIsDataRefRecordPtr = $00000010;
	flattenCompressMovieResource = $00000020;
	flattenForceMovieResourceBeforeMovieData = $00000040;


TYPE
	movieFlattenFlagsEnum				= UInt32;

CONST
	movieInDataForkResID		= -1;							{  magic res ID  }

	mcTopLeftMovie				= $01;							{  usually centered  }
	mcScaleMovieToFit			= $02;							{  usually only scales down  }
	mcWithBadge					= $04;							{  give me a badge  }
	mcNotVisible				= $08;							{  don't show controller  }
	mcWithFrame					= $10;							{  gimme a frame  }

	movieScrapDontZeroScrap		= $01;
	movieScrapOnlyPutMovie		= $02;

	dataRefSelfReference		= $01;
	dataRefWasNotResolved		= $02;


TYPE
	dataRefAttributesFlags				= UInt32;

CONST
	kMovieAnchorDataRefIsDefault = $01;							{  data ref returned is movie default data ref  }

	hintsScrubMode				= $01;							{  mask == && (if flags == scrub on, flags != scrub off)  }
	hintsLoop					= $02;
	hintsDontPurge				= $04;
	hintsUseScreenBuffer		= $20;
	hintsAllowInterlace			= $40;
	hintsUseSoundInterp			= $80;
	hintsHighQuality			= $0100;						{  slooooow  }
	hintsPalindrome				= $0200;
	hintsInactive				= $0800;
	hintsOffscreen				= $1000;
	hintsDontDraw				= $2000;
	hintsAllowBlacklining		= $4000;
	hintsDontUseVideoOverlaySurface = $00010000;
	hintsIgnoreBandwidthRestrictions = $00020000;
	hintsPlayingEveryFrame		= $00040000;
	hintsAllowDynamicResize		= $00080000;
	hintsSingleField			= $00100000;
	hintsNoRenderingTimeOut		= $00200000;


TYPE
	playHintsEnum						= UInt32;

CONST
	mediaHandlerFlagBaseClient	= 1;


TYPE
	mediaHandlerFlagsEnum				= UInt32;

CONST
	movieTrackMediaType			= $01;
	movieTrackCharacteristic	= $02;
	movieTrackEnabledOnly		= $04;


TYPE
	SampleReferenceRecordPtr = ^SampleReferenceRecord;
	SampleReferenceRecord = RECORD
		dataOffset:				LONGINT;
		dataSize:				LONGINT;
		durationPerSample:		TimeValue;
		numberOfSamples:		LONGINT;
		sampleFlags:			INTEGER;
	END;

	SampleReferencePtr					= ^SampleReferenceRecord;
	SampleReference64RecordPtr = ^SampleReference64Record;
	SampleReference64Record = RECORD
		dataOffset:				wide;
		dataSize:				UInt32;
		durationPerSample:		TimeValue;
		numberOfSamples:		UInt32;
		sampleFlags:			INTEGER;
	END;

	SampleReference64Ptr				= ^SampleReference64Record;

	{	************************
	* Initialization Routines 
	*************************	}
	{
	 *  CheckQuickTimeRegistration()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
PROCEDURE CheckQuickTimeRegistration(registrationKey: UNIV Ptr; flags: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02DA, $AAAA;
	{$ENDC}

{
 *  EnterMovies()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION EnterMovies: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AAAA;
	{$ENDC}

{
 *  ExitMovies()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE ExitMovies;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AAAA;
	{$ENDC}

{************************
* Error Routines 
*************************}

{
 *  GetMoviesError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMoviesError: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AAAA;
	{$ENDC}

{
 *  ClearMoviesStickyError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE ClearMoviesStickyError;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00DE, $AAAA;
	{$ENDC}

{
 *  GetMoviesStickyError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMoviesStickyError: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $AAAA;
	{$ENDC}

{
 *  SetMoviesErrorProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMoviesErrorProc(errProc: MoviesErrorUPP; refcon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00EF, $AAAA;
	{$ENDC}


{************************
* Idle Routines 
*************************}
{
 *  MoviesTask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE MoviesTask(theMovie: Movie; maxMilliSecToUse: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7005, $AAAA;
	{$ENDC}

{
 *  PrerollMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION PrerollMovie(theMovie: Movie; time: TimeValue; Rate: Fixed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7006, $AAAA;
	{$ENDC}

{
 *  PrePrerollMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION PrePrerollMovie(m: Movie; time: TimeValue; rate: Fixed; proc: MoviePrePrerollCompleteUPP; refcon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02F7, $AAAA;
	{$ENDC}

{
 *  AbortPrePrerollMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
PROCEDURE AbortPrePrerollMovie(m: Movie; err: OSErr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02F8, $AAAA;
	{$ENDC}

{
 *  LoadMovieIntoRam()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION LoadMovieIntoRam(theMovie: Movie; time: TimeValue; duration: TimeValue; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7007, $AAAA;
	{$ENDC}

{
 *  LoadTrackIntoRam()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION LoadTrackIntoRam(theTrack: Track; time: TimeValue; duration: TimeValue; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $016E, $AAAA;
	{$ENDC}

{
 *  LoadMediaIntoRam()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION LoadMediaIntoRam(theMedia: Media; time: TimeValue; duration: TimeValue; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $AAAA;
	{$ENDC}

{
 *  SetMovieActive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieActive(theMovie: Movie; active: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $AAAA;
	{$ENDC}

{
 *  GetMovieActive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieActive(theMovie: Movie): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700A, $AAAA;
	{$ENDC}

{************************
* calls for playing movies, previews, posters
*************************}
{
 *  StartMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE StartMovie(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $AAAA;
	{$ENDC}

{
 *  StopMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE StopMovie(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700C, $AAAA;
	{$ENDC}

{
 *  GoToBeginningOfMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GoToBeginningOfMovie(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700D, $AAAA;
	{$ENDC}

{
 *  GoToEndOfMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GoToEndOfMovie(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $AAAA;
	{$ENDC}

{
 *  IsMovieDone()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION IsMovieDone(theMovie: Movie): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00DD, $AAAA;
	{$ENDC}

{
 *  GetMoviePreviewMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMoviePreviewMode(theMovie: Movie): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $AAAA;
	{$ENDC}

{
 *  SetMoviePreviewMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMoviePreviewMode(theMovie: Movie; usePreview: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $AAAA;
	{$ENDC}

{
 *  ShowMoviePoster()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE ShowMoviePoster(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $AAAA;
	{$ENDC}

{
 *  PlayMoviePreview()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE PlayMoviePreview(theMovie: Movie; callOutProc: MoviePreviewCallOutUPP; refcon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F2, $AAAA;
	{$ENDC}

{************************
* calls for controlling movies & tracks which are playing
*************************}
{
 *  GetMovieTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieTimeBase(theMovie: Movie): TimeBase;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $AAAA;
	{$ENDC}

{
 *  SetMovieMasterTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieMasterTimeBase(theMovie: Movie; tb: TimeBase; {CONST}VAR slaveZero: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0167, $AAAA;
	{$ENDC}

{
 *  SetMovieMasterClock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieMasterClock(theMovie: Movie; clockMeister: Component; {CONST}VAR slaveZero: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0168, $AAAA;
	{$ENDC}

{
 *  GetMovieGWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetMovieGWorld(theMovie: Movie; VAR port: CGrafPtr; VAR gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $AAAA;
	{$ENDC}

{
 *  SetMovieGWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieGWorld(theMovie: Movie; port: CGrafPtr; gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7016, $AAAA;
	{$ENDC}


CONST
	movieDrawingCallWhenChanged	= 0;
	movieDrawingCallAlways		= 1;

	{
	 *  SetMovieDrawingCompleteProc()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
PROCEDURE SetMovieDrawingCompleteProc(theMovie: Movie; flags: LONGINT; proc: MovieDrawingCompleteUPP; refCon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01DE, $AAAA;
	{$ENDC}


{
 *  GetMovieNaturalBoundsRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetMovieNaturalBoundsRect(theMovie: Movie; VAR naturalBounds: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022C, $AAAA;
	{$ENDC}

{
 *  GetNextTrackForCompositing()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetNextTrackForCompositing(theMovie: Movie; theTrack: Track): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01FA, $AAAA;
	{$ENDC}

{
 *  GetPrevTrackForCompositing()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetPrevTrackForCompositing(theMovie: Movie; theTrack: Track): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01FB, $AAAA;
	{$ENDC}

{
 *  SetTrackGWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTrackGWorld(theTrack: Track; port: CGrafPtr; gdh: GDHandle; proc: TrackTransferUPP; refCon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $009D, $AAAA;
	{$ENDC}

{
 *  GetMoviePict()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMoviePict(theMovie: Movie; time: TimeValue): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701D, $AAAA;
	{$ENDC}

{
 *  GetTrackPict()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackPict(theTrack: Track; time: TimeValue): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701E, $AAAA;
	{$ENDC}

{
 *  GetMoviePosterPict()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMoviePosterPict(theMovie: Movie): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F7, $AAAA;
	{$ENDC}

{ called between Begin & EndUpdate }
{
 *  UpdateMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION UpdateMovie(theMovie: Movie): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701F, $AAAA;
	{$ENDC}

{
 *  InvalidateMovieRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION InvalidateMovieRegion(theMovie: Movie; invalidRgn: RgnHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022A, $AAAA;
	{$ENDC}

{*** spatial movie routines ***}
{
 *  GetMovieBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetMovieBox(theMovie: Movie; VAR boxRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F9, $AAAA;
	{$ENDC}

{
 *  SetMovieBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieBox(theMovie: Movie; {CONST}VAR boxRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00FA, $AAAA;
	{$ENDC}

{* movie display clip }
{
 *  GetMovieDisplayClipRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieDisplayClipRgn(theMovie: Movie): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00FC, $AAAA;
	{$ENDC}

{
 *  SetMovieDisplayClipRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieDisplayClipRgn(theMovie: Movie; theClip: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00FD, $AAAA;
	{$ENDC}

{* movie src clip }
{
 *  GetMovieClipRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieClipRgn(theMovie: Movie): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0100, $AAAA;
	{$ENDC}

{
 *  SetMovieClipRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieClipRgn(theMovie: Movie; theClip: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0101, $AAAA;
	{$ENDC}

{* track src clip }
{
 *  GetTrackClipRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackClipRgn(theTrack: Track): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0102, $AAAA;
	{$ENDC}

{
 *  SetTrackClipRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTrackClipRgn(theTrack: Track; theClip: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0103, $AAAA;
	{$ENDC}

{* bounds in display space (not clipped by display clip) }
{
 *  GetMovieDisplayBoundsRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieDisplayBoundsRgn(theMovie: Movie): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00FB, $AAAA;
	{$ENDC}

{
 *  GetTrackDisplayBoundsRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackDisplayBoundsRgn(theTrack: Track): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0112, $AAAA;
	{$ENDC}

{* bounds in movie space }
{
 *  GetMovieBoundsRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieBoundsRgn(theMovie: Movie): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00FE, $AAAA;
	{$ENDC}

{
 *  GetTrackMovieBoundsRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackMovieBoundsRgn(theTrack: Track): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00FF, $AAAA;
	{$ENDC}

{* bounds in track space }
{
 *  GetTrackBoundsRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackBoundsRgn(theTrack: Track): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0111, $AAAA;
	{$ENDC}

{* mattes - always in track space }
{
 *  GetTrackMatte()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackMatte(theTrack: Track): PixMapHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0115, $AAAA;
	{$ENDC}

{
 *  SetTrackMatte()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTrackMatte(theTrack: Track; theMatte: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0116, $AAAA;
	{$ENDC}

{
 *  DisposeMatte()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE DisposeMatte(theMatte: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $014A, $AAAA;
	{$ENDC}

{* video out }
{
 *  SetMovieVideoOutput()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
PROCEDURE SetMovieVideoOutput(theMovie: Movie; vout: ComponentInstance);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0340, $AAAA;
	{$ENDC}

{************************
* calls for getting/saving movies
*************************}
{
 *  NewMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewMovie(flags: LONGINT): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0187, $AAAA;
	{$ENDC}

{
 *  PutMovieIntoHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION PutMovieIntoHandle(theMovie: Movie; publicMovie: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7022, $AAAA;
	{$ENDC}

{
 *  PutMovieIntoDataFork()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION PutMovieIntoDataFork(theMovie: Movie; fRefNum: INTEGER; offset: LONGINT; maxSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01B4, $AAAA;
	{$ENDC}

{
 *  PutMovieIntoDataFork64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION PutMovieIntoDataFork64(theMovie: Movie; fRefNum: LONGINT; {CONST}VAR offset: wide; maxSize: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02EA, $AAAA;
	{$ENDC}

{
 *  DisposeMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE DisposeMovie(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7023, $AAAA;
	{$ENDC}

{************************
* Movie State Routines
*************************}
{
 *  GetMovieCreationTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieCreationTime(theMovie: Movie): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7026, $AAAA;
	{$ENDC}

{
 *  GetMovieModificationTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieModificationTime(theMovie: Movie): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7027, $AAAA;
	{$ENDC}

{
 *  GetMovieTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieTimeScale(theMovie: Movie): TimeScale;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7029, $AAAA;
	{$ENDC}

{
 *  SetMovieTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieTimeScale(theMovie: Movie; timeScale: TimeScale);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702A, $AAAA;
	{$ENDC}

{
 *  GetMovieDuration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieDuration(theMovie: Movie): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702B, $AAAA;
	{$ENDC}

{
 *  GetMovieRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieRate(theMovie: Movie): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702C, $AAAA;
	{$ENDC}

{
 *  SetMovieRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieRate(theMovie: Movie; rate: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702D, $AAAA;
	{$ENDC}

{
 *  GetMoviePreferredRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMoviePreferredRate(theMovie: Movie): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F3, $AAAA;
	{$ENDC}

{
 *  SetMoviePreferredRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMoviePreferredRate(theMovie: Movie; rate: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F4, $AAAA;
	{$ENDC}

{
 *  GetMoviePreferredVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMoviePreferredVolume(theMovie: Movie): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F5, $AAAA;
	{$ENDC}

{
 *  SetMoviePreferredVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMoviePreferredVolume(theMovie: Movie; volume: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F6, $AAAA;
	{$ENDC}

{
 *  GetMovieVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieVolume(theMovie: Movie): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702E, $AAAA;
	{$ENDC}

{
 *  SetMovieVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieVolume(theMovie: Movie; volume: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702F, $AAAA;
	{$ENDC}

{
 *  GetMovieMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetMovieMatrix(theMovie: Movie; VAR matrix: MatrixRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7031, $AAAA;
	{$ENDC}

{
 *  SetMovieMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieMatrix(theMovie: Movie; {CONST}VAR matrix: MatrixRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7032, $AAAA;
	{$ENDC}

{
 *  GetMoviePreviewTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetMoviePreviewTime(theMovie: Movie; VAR previewTime: TimeValue; VAR previewDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7033, $AAAA;
	{$ENDC}

{
 *  SetMoviePreviewTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMoviePreviewTime(theMovie: Movie; previewTime: TimeValue; previewDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7034, $AAAA;
	{$ENDC}

{
 *  GetMoviePosterTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMoviePosterTime(theMovie: Movie): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7035, $AAAA;
	{$ENDC}

{
 *  SetMoviePosterTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMoviePosterTime(theMovie: Movie; posterTime: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7036, $AAAA;
	{$ENDC}

{
 *  GetMovieSelection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetMovieSelection(theMovie: Movie; VAR selectionTime: TimeValue; VAR selectionDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7037, $AAAA;
	{$ENDC}

{
 *  SetMovieSelection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieSelection(theMovie: Movie; selectionTime: TimeValue; selectionDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7038, $AAAA;
	{$ENDC}

{
 *  SetMovieActiveSegment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieActiveSegment(theMovie: Movie; startTime: TimeValue; duration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $015C, $AAAA;
	{$ENDC}

{
 *  GetMovieActiveSegment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetMovieActiveSegment(theMovie: Movie; VAR startTime: TimeValue; VAR duration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $015D, $AAAA;
	{$ENDC}

{
 *  GetMovieTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieTime(theMovie: Movie; VAR currentTime: TimeRecord): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7039, $AAAA;
	{$ENDC}

{
 *  SetMovieTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieTime(theMovie: Movie; {CONST}VAR newtime: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703C, $AAAA;
	{$ENDC}

{
 *  SetMovieTimeValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieTimeValue(theMovie: Movie; newtime: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703D, $AAAA;
	{$ENDC}


{
 *  GetMovieUserData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieUserData(theMovie: Movie): UserData;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703E, $AAAA;
	{$ENDC}


{************************
* Track/Media finding routines
*************************}
{
 *  GetMovieTrackCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieTrackCount(theMovie: Movie): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $703F, $AAAA;
	{$ENDC}

{
 *  GetMovieTrack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieTrack(theMovie: Movie; trackID: LONGINT): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7040, $AAAA;
	{$ENDC}

{
 *  GetMovieIndTrack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieIndTrack(theMovie: Movie; index: LONGINT): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0117, $AAAA;
	{$ENDC}

{
 *  GetMovieIndTrackType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieIndTrackType(theMovie: Movie; index: LONGINT; trackType: OSType; flags: LONGINT): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0208, $AAAA;
	{$ENDC}

{
 *  GetTrackID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackID(theTrack: Track): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0127, $AAAA;
	{$ENDC}

{
 *  GetTrackMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackMovie(theTrack: Track): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00D0, $AAAA;
	{$ENDC}

{************************
* Track creation routines
*************************}
{
 *  NewMovieTrack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewMovieTrack(theMovie: Movie; width: Fixed; height: Fixed; trackVolume: INTEGER): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0188, $AAAA;
	{$ENDC}

{
 *  DisposeMovieTrack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE DisposeMovieTrack(theTrack: Track);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7042, $AAAA;
	{$ENDC}

{************************
* Track State routines
*************************}
{
 *  GetTrackCreationTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackCreationTime(theTrack: Track): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7043, $AAAA;
	{$ENDC}

{
 *  GetTrackModificationTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackModificationTime(theTrack: Track): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7044, $AAAA;
	{$ENDC}


{
 *  GetTrackEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackEnabled(theTrack: Track): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7045, $AAAA;
	{$ENDC}

{
 *  SetTrackEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTrackEnabled(theTrack: Track; isEnabled: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7046, $AAAA;
	{$ENDC}

{
 *  GetTrackUsage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackUsage(theTrack: Track): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7047, $AAAA;
	{$ENDC}

{
 *  SetTrackUsage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTrackUsage(theTrack: Track; usage: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7048, $AAAA;
	{$ENDC}

{
 *  GetTrackDuration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackDuration(theTrack: Track): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $704B, $AAAA;
	{$ENDC}

{
 *  GetTrackOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackOffset(theTrack: Track): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $704C, $AAAA;
	{$ENDC}

{
 *  SetTrackOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTrackOffset(theTrack: Track; movieOffsetTime: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $704D, $AAAA;
	{$ENDC}

{
 *  GetTrackLayer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackLayer(theTrack: Track): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7050, $AAAA;
	{$ENDC}

{
 *  SetTrackLayer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTrackLayer(theTrack: Track; layer: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7051, $AAAA;
	{$ENDC}

{
 *  GetTrackAlternate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackAlternate(theTrack: Track): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7052, $AAAA;
	{$ENDC}

{
 *  SetTrackAlternate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTrackAlternate(theTrack: Track; alternateT: Track);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7053, $AAAA;
	{$ENDC}

{
 *  SetAutoTrackAlternatesEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetAutoTrackAlternatesEnabled(theMovie: Movie; enable: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $015E, $AAAA;
	{$ENDC}

{
 *  SelectMovieAlternates()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SelectMovieAlternates(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $015F, $AAAA;
	{$ENDC}

{
 *  GetTrackVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackVolume(theTrack: Track): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7054, $AAAA;
	{$ENDC}

{
 *  SetTrackVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTrackVolume(theTrack: Track; volume: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7055, $AAAA;
	{$ENDC}

{
 *  GetTrackMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetTrackMatrix(theTrack: Track; VAR matrix: MatrixRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7056, $AAAA;
	{$ENDC}

{
 *  SetTrackMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTrackMatrix(theTrack: Track; {CONST}VAR matrix: MatrixRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7057, $AAAA;
	{$ENDC}

{
 *  GetTrackDimensions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetTrackDimensions(theTrack: Track; VAR width: Fixed; VAR height: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $705D, $AAAA;
	{$ENDC}

{
 *  SetTrackDimensions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTrackDimensions(theTrack: Track; width: Fixed; height: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $705E, $AAAA;
	{$ENDC}

{
 *  GetTrackUserData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackUserData(theTrack: Track): UserData;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $705F, $AAAA;
	{$ENDC}

{
 *  GetTrackDisplayMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackDisplayMatrix(theTrack: Track; VAR matrix: MatrixRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0263, $AAAA;
	{$ENDC}

{
 *  GetTrackSoundLocalizationSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackSoundLocalizationSettings(theTrack: Track; VAR settings: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0282, $AAAA;
	{$ENDC}

{
 *  SetTrackSoundLocalizationSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetTrackSoundLocalizationSettings(theTrack: Track; settings: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0283, $AAAA;
	{$ENDC}

{************************
* get Media routines
*************************}
{
 *  NewTrackMedia()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewTrackMedia(theTrack: Track; mediaType: OSType; timeScale: TimeScale; dataRef: Handle; dataRefType: OSType): Media;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $018E, $AAAA;
	{$ENDC}

{
 *  DisposeTrackMedia()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE DisposeTrackMedia(theMedia: Media);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7061, $AAAA;
	{$ENDC}

{
 *  GetTrackMedia()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackMedia(theTrack: Track): Media;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7062, $AAAA;
	{$ENDC}

{
 *  GetMediaTrack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaTrack(theMedia: Media): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00C5, $AAAA;
	{$ENDC}



{************************
* Media State routines
*************************}
{
 *  GetMediaCreationTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaCreationTime(theMedia: Media): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7066, $AAAA;
	{$ENDC}

{
 *  GetMediaModificationTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaModificationTime(theMedia: Media): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7067, $AAAA;
	{$ENDC}

{
 *  GetMediaTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaTimeScale(theMedia: Media): TimeScale;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7068, $AAAA;
	{$ENDC}

{
 *  SetMediaTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMediaTimeScale(theMedia: Media; timeScale: TimeScale);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7069, $AAAA;
	{$ENDC}

{
 *  GetMediaDuration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaDuration(theMedia: Media): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $706A, $AAAA;
	{$ENDC}

{
 *  GetMediaLanguage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaLanguage(theMedia: Media): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $706B, $AAAA;
	{$ENDC}

{
 *  SetMediaLanguage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMediaLanguage(theMedia: Media; language: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $706C, $AAAA;
	{$ENDC}

{
 *  GetMediaQuality()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaQuality(theMedia: Media): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $706D, $AAAA;
	{$ENDC}

{
 *  SetMediaQuality()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMediaQuality(theMedia: Media; quality: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $706E, $AAAA;
	{$ENDC}

{
 *  GetMediaHandlerDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetMediaHandlerDescription(theMedia: Media; VAR mediaType: OSType; VAR creatorName: Str255; VAR creatorManufacturer: OSType);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $706F, $AAAA;
	{$ENDC}

{
 *  GetMediaUserData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaUserData(theMedia: Media): UserData;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7070, $AAAA;
	{$ENDC}

{
 *  GetMediaInputMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaInputMap(theMedia: Media; VAR inputMap: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0249, $AAAA;
	{$ENDC}

{
 *  SetMediaInputMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetMediaInputMap(theMedia: Media; inputMap: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $024A, $AAAA;
	{$ENDC}

{************************
* Media Handler routines
*************************}
{
 *  GetMediaHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaHandler(theMedia: Media): MediaHandler;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7071, $AAAA;
	{$ENDC}

{
 *  SetMediaHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetMediaHandler(theMedia: Media; mH: MediaHandlerComponent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0190, $AAAA;
	{$ENDC}


{************************
* Media's Data routines
*************************}
{
 *  BeginMediaEdits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION BeginMediaEdits(theMedia: Media): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7072, $AAAA;
	{$ENDC}

{
 *  EndMediaEdits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION EndMediaEdits(theMedia: Media): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7073, $AAAA;
	{$ENDC}

{
 *  SetMediaDefaultDataRefIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetMediaDefaultDataRefIndex(theMedia: Media; index: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01E0, $AAAA;
	{$ENDC}

{
 *  GetMediaDataHandlerDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetMediaDataHandlerDescription(theMedia: Media; index: INTEGER; VAR dhType: OSType; VAR creatorName: Str255; VAR creatorManufacturer: OSType);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $019E, $AAAA;
	{$ENDC}

{
 *  GetMediaDataHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaDataHandler(theMedia: Media; index: INTEGER): DataHandler;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $019F, $AAAA;
	{$ENDC}

{
 *  SetMediaDataHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetMediaDataHandler(theMedia: Media; index: INTEGER; dataHandler: DataHandlerComponent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01A0, $AAAA;
	{$ENDC}

{
 *  GetDataHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetDataHandler(dataRef: Handle; dataHandlerSubType: OSType; flags: LONGINT): Component;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01ED, $AAAA;
	{$ENDC}

{
 *  OpenADataHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION OpenADataHandler(dataRef: Handle; dataHandlerSubType: OSType; anchorDataRef: Handle; anchorDataRefType: OSType; tb: TimeBase; flags: LONGINT; VAR dh: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $031C, $AAAA;
	{$ENDC}

{************************
* Media Sample Table Routines
*************************}
{
 *  GetMediaSampleDescriptionCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaSampleDescriptionCount(theMedia: Media): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7077, $AAAA;
	{$ENDC}

{
 *  GetMediaSampleDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetMediaSampleDescription(theMedia: Media; index: LONGINT; descH: SampleDescriptionHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7078, $AAAA;
	{$ENDC}

{
 *  SetMediaSampleDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetMediaSampleDescription(theMedia: Media; index: LONGINT; descH: SampleDescriptionHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01D0, $AAAA;
	{$ENDC}

{
 *  GetMediaSampleCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaSampleCount(theMedia: Media): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7079, $AAAA;
	{$ENDC}

{
 *  GetMediaSyncSampleCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaSyncSampleCount(theMedia: Media): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02B2, $AAAA;
	{$ENDC}

{
 *  SampleNumToMediaTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SampleNumToMediaTime(theMedia: Media; logicalSampleNum: LONGINT; VAR sampleTime: TimeValue; VAR sampleDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $707A, $AAAA;
	{$ENDC}

{
 *  MediaTimeToSampleNum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE MediaTimeToSampleNum(theMedia: Media; time: TimeValue; VAR sampleNum: LONGINT; VAR sampleTime: TimeValue; VAR sampleDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $707B, $AAAA;
	{$ENDC}


{
 *  AddMediaSample()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION AddMediaSample(theMedia: Media; dataIn: Handle; inOffset: LONGINT; size: UInt32; durationPerSample: TimeValue; sampleDescriptionH: SampleDescriptionHandle; numberOfSamples: LONGINT; sampleFlags: INTEGER; VAR sampleTime: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $707C, $AAAA;
	{$ENDC}

{
 *  AddMediaSampleReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION AddMediaSampleReference(theMedia: Media; dataOffset: LONGINT; size: UInt32; durationPerSample: TimeValue; sampleDescriptionH: SampleDescriptionHandle; numberOfSamples: LONGINT; sampleFlags: INTEGER; VAR sampleTime: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $707D, $AAAA;
	{$ENDC}

{
 *  AddMediaSampleReferences()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION AddMediaSampleReferences(theMedia: Media; sampleDescriptionH: SampleDescriptionHandle; numberOfSamples: LONGINT; sampleRefs: SampleReferencePtr; VAR sampleTime: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F7, $AAAA;
	{$ENDC}

{
 *  AddMediaSampleReferences64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION AddMediaSampleReferences64(theMedia: Media; sampleDescriptionH: SampleDescriptionHandle; numberOfSamples: LONGINT; sampleRefs: SampleReference64Ptr; VAR sampleTime: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02E8, $AAAA;
	{$ENDC}

{
 *  GetMediaSample()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaSample(theMedia: Media; dataOut: Handle; maxSizeToGrow: LONGINT; VAR size: LONGINT; time: TimeValue; VAR sampleTime: TimeValue; VAR durationPerSample: TimeValue; sampleDescriptionH: SampleDescriptionHandle; VAR sampleDescriptionIndex: LONGINT; maxNumberOfSamples: LONGINT; VAR numberOfSamples: LONGINT; VAR sampleFlags: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $707E, $AAAA;
	{$ENDC}

{
 *  GetMediaSampleReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaSampleReference(theMedia: Media; VAR dataOffset: LONGINT; VAR size: LONGINT; time: TimeValue; VAR sampleTime: TimeValue; VAR durationPerSample: TimeValue; sampleDescriptionH: SampleDescriptionHandle; VAR sampleDescriptionIndex: LONGINT; maxNumberOfSamples: LONGINT; VAR numberOfSamples: LONGINT; VAR sampleFlags: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $707F, $AAAA;
	{$ENDC}

{
 *  GetMediaSampleReferences()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaSampleReferences(theMedia: Media; time: TimeValue; VAR sampleTime: TimeValue; sampleDescriptionH: SampleDescriptionHandle; VAR sampleDescriptionIndex: LONGINT; maxNumberOfEntries: LONGINT; VAR actualNumberofEntries: LONGINT; sampleRefs: SampleReferencePtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0235, $AAAA;
	{$ENDC}

{
 *  GetMediaSampleReferences64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION GetMediaSampleReferences64(theMedia: Media; time: TimeValue; VAR sampleTime: TimeValue; sampleDescriptionH: SampleDescriptionHandle; VAR sampleDescriptionIndex: LONGINT; maxNumberOfEntries: LONGINT; VAR actualNumberofEntries: LONGINT; sampleRefs: SampleReference64Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02E9, $AAAA;
	{$ENDC}

{
 *  SetMediaPreferredChunkSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetMediaPreferredChunkSize(theMedia: Media; maxChunkSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F8, $AAAA;
	{$ENDC}

{
 *  GetMediaPreferredChunkSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaPreferredChunkSize(theMedia: Media; VAR maxChunkSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F9, $AAAA;
	{$ENDC}

{
 *  SetMediaShadowSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetMediaShadowSync(theMedia: Media; frameDiffSampleNum: LONGINT; syncSampleNum: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0121, $AAAA;
	{$ENDC}

{
 *  GetMediaShadowSync()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaShadowSync(theMedia: Media; frameDiffSampleNum: LONGINT; VAR syncSampleNum: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0122, $AAAA;
	{$ENDC}

{************************
* Editing Routines
*************************}
{
 *  InsertMediaIntoTrack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION InsertMediaIntoTrack(theTrack: Track; trackStart: TimeValue; mediaTime: TimeValue; mediaDuration: TimeValue; mediaRate: Fixed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0183, $AAAA;
	{$ENDC}

{
 *  InsertTrackSegment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION InsertTrackSegment(srcTrack: Track; dstTrack: Track; srcIn: TimeValue; srcDuration: TimeValue; dstIn: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0085, $AAAA;
	{$ENDC}

{
 *  InsertMovieSegment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION InsertMovieSegment(srcMovie: Movie; dstMovie: Movie; srcIn: TimeValue; srcDuration: TimeValue; dstIn: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0086, $AAAA;
	{$ENDC}

{
 *  InsertEmptyTrackSegment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION InsertEmptyTrackSegment(dstTrack: Track; dstIn: TimeValue; dstDuration: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0087, $AAAA;
	{$ENDC}

{
 *  InsertEmptyMovieSegment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION InsertEmptyMovieSegment(dstMovie: Movie; dstIn: TimeValue; dstDuration: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0088, $AAAA;
	{$ENDC}

{
 *  DeleteTrackSegment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DeleteTrackSegment(theTrack: Track; startTime: TimeValue; duration: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0089, $AAAA;
	{$ENDC}

{
 *  DeleteMovieSegment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DeleteMovieSegment(theMovie: Movie; startTime: TimeValue; duration: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $008A, $AAAA;
	{$ENDC}

{
 *  ScaleTrackSegment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION ScaleTrackSegment(theTrack: Track; startTime: TimeValue; oldDuration: TimeValue; newDuration: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $008B, $AAAA;
	{$ENDC}

{
 *  ScaleMovieSegment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION ScaleMovieSegment(theMovie: Movie; startTime: TimeValue; oldDuration: TimeValue; newDuration: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $008C, $AAAA;
	{$ENDC}


{************************
* Hi-level Editing Routines
*************************}
{
 *  CutMovieSelection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION CutMovieSelection(theMovie: Movie): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $008D, $AAAA;
	{$ENDC}

{
 *  CopyMovieSelection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION CopyMovieSelection(theMovie: Movie): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $008E, $AAAA;
	{$ENDC}

{
 *  PasteMovieSelection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE PasteMovieSelection(theMovie: Movie; src: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $008F, $AAAA;
	{$ENDC}

{
 *  AddMovieSelection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE AddMovieSelection(theMovie: Movie; src: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0152, $AAAA;
	{$ENDC}

{
 *  ClearMovieSelection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE ClearMovieSelection(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00E1, $AAAA;
	{$ENDC}

{
 *  PasteHandleIntoMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION PasteHandleIntoMovie(h: Handle; handleType: OSType; theMovie: Movie; flags: LONGINT; userComp: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00CB, $AAAA;
	{$ENDC}

{
 *  PutMovieIntoTypedHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION PutMovieIntoTypedHandle(theMovie: Movie; targetTrack: Track; handleType: OSType; publicMovie: Handle; start: TimeValue; dur: TimeValue; flags: LONGINT; userComp: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01CD, $AAAA;
	{$ENDC}

{
 *  IsScrapMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION IsScrapMovie(targetTrack: Track): Component;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00CC, $AAAA;
	{$ENDC}

{************************
* Middle-level Editing Routines
*************************}
{
 *  CopyTrackSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION CopyTrackSettings(srcTrack: Track; dstTrack: Track): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0153, $AAAA;
	{$ENDC}

{
 *  CopyMovieSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION CopyMovieSettings(srcMovie: Movie; dstMovie: Movie): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0154, $AAAA;
	{$ENDC}

{
 *  AddEmptyTrackToMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION AddEmptyTrackToMovie(srcTrack: Track; dstMovie: Movie; dataRef: Handle; dataRefType: OSType; VAR dstTrack: Track): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7074, $AAAA;
	{$ENDC}


CONST
	kQTCloneShareSamples		= $01;
	kQTCloneDontCopyEdits		= $02;

	{
	 *  AddClonedTrackToMovie()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 5.0 and later
	 	}
FUNCTION AddClonedTrackToMovie(srcTrack: Track; dstMovie: Movie; flags: LONGINT; VAR dstTrack: Track): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0344, $AAAA;
	{$ENDC}

{************************
* movie & track edit state routines
*************************}
{
 *  NewMovieEditState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewMovieEditState(theMovie: Movie): MovieEditState;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0104, $AAAA;
	{$ENDC}

{
 *  UseMovieEditState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION UseMovieEditState(theMovie: Movie; toState: MovieEditState): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0105, $AAAA;
	{$ENDC}

{
 *  DisposeMovieEditState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DisposeMovieEditState(state: MovieEditState): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0106, $AAAA;
	{$ENDC}

{
 *  NewTrackEditState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewTrackEditState(theTrack: Track): TrackEditState;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0107, $AAAA;
	{$ENDC}

{
 *  UseTrackEditState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION UseTrackEditState(theTrack: Track; state: TrackEditState): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0108, $AAAA;
	{$ENDC}

{
 *  DisposeTrackEditState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DisposeTrackEditState(state: TrackEditState): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0109, $AAAA;
	{$ENDC}

{************************
* track reference routines
*************************}
{
 *  AddTrackReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION AddTrackReference(theTrack: Track; refTrack: Track; refType: OSType; VAR addedIndex: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F0, $AAAA;
	{$ENDC}

{
 *  DeleteTrackReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DeleteTrackReference(theTrack: Track; refType: OSType; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F1, $AAAA;
	{$ENDC}

{
 *  SetTrackReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetTrackReference(theTrack: Track; refTrack: Track; refType: OSType; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F2, $AAAA;
	{$ENDC}

{
 *  GetTrackReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackReference(theTrack: Track; refType: OSType; index: LONGINT): Track;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F3, $AAAA;
	{$ENDC}

{
 *  GetNextTrackReferenceType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetNextTrackReferenceType(theTrack: Track; refType: OSType): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F4, $AAAA;
	{$ENDC}

{
 *  GetTrackReferenceCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackReferenceCount(theTrack: Track; refType: OSType): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01F5, $AAAA;
	{$ENDC}


{************************
* high level file conversion routines
*************************}
{
 *  ConvertFileToMovieFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION ConvertFileToMovieFile({CONST}VAR inputFile: FSSpec; {CONST}VAR outputFile: FSSpec; creator: OSType; scriptTag: ScriptCode; VAR resID: INTEGER; flags: LONGINT; userComp: ComponentInstance; proc: MovieProgressUPP; refCon: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01CB, $AAAA;
	{$ENDC}

{
 *  ConvertMovieToFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION ConvertMovieToFile(theMovie: Movie; onlyTrack: Track; VAR outputFile: FSSpec; fileType: OSType; creator: OSType; scriptTag: ScriptCode; VAR resID: INTEGER; flags: LONGINT; userComp: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01CC, $AAAA;
	{$ENDC}


CONST
	kGetMovieImporterValidateToFind = $00000001;
	kGetMovieImporterAllowNewFile = $00000002;
	kGetMovieImporterDontConsiderGraphicsImporters = $00000004;
	kGetMovieImporterDontConsiderFileOnlyImporters = $00000040;
	kGetMovieImporterAutoImportOnly = $00000400;				{  reject aggressive movie importers which have dontAutoFileMovieImport set }

	{
	 *  GetMovieImporterForDataRef()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION GetMovieImporterForDataRef(dataRefType: OSType; dataRef: Handle; flags: LONGINT; VAR importer: Component): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02C7, $AAAA;
	{$ENDC}



CONST
	kQTGetMIMETypeInfoIsQuickTimeMovieType = 'moov';			{  info is a pointer to a Boolean }
	kQTGetMIMETypeInfoIsUnhelpfulType = 'dumb';					{  info is a pointer to a Boolean }

	{
	 *  QTGetMIMETypeInfo()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 5.0 and later
	 	}
FUNCTION QTGetMIMETypeInfo(mimeStringStart: ConstCStringPtr; mimeStringLength: INTEGER; infoSelector: OSType; infoDataPtr: UNIV Ptr; VAR infoDataSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $036A, $AAAA;
	{$ENDC}

{************************
* Movie Timebase Conversion Routines
*************************}
{
 *  TrackTimeToMediaTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TrackTimeToMediaTime(value: TimeValue; theTrack: Track): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0096, $AAAA;
	{$ENDC}

{
 *  GetTrackEditRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackEditRate(theTrack: Track; atTime: TimeValue): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0123, $AAAA;
	{$ENDC}


{************************
* Miscellaneous Routines
*************************}

{
 *  GetMovieDataSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieDataSize(theMovie: Movie; startTime: TimeValue; duration: TimeValue): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0098, $AAAA;
	{$ENDC}

{
 *  GetMovieDataSize64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION GetMovieDataSize64(theMovie: Movie; startTime: TimeValue; duration: TimeValue; VAR dataSize: wide): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02EB, $AAAA;
	{$ENDC}

{
 *  GetTrackDataSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackDataSize(theTrack: Track; startTime: TimeValue; duration: TimeValue): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0149, $AAAA;
	{$ENDC}

{
 *  GetTrackDataSize64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION GetTrackDataSize64(theTrack: Track; startTime: TimeValue; duration: TimeValue; VAR dataSize: wide): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02EC, $AAAA;
	{$ENDC}

{
 *  GetMediaDataSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaDataSize(theMedia: Media; startTime: TimeValue; duration: TimeValue): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0099, $AAAA;
	{$ENDC}

{
 *  GetMediaDataSize64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION GetMediaDataSize64(theMedia: Media; startTime: TimeValue; duration: TimeValue; VAR dataSize: wide): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02ED, $AAAA;
	{$ENDC}

{
 *  PtInMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION PtInMovie(theMovie: Movie; pt: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $009A, $AAAA;
	{$ENDC}

{
 *  PtInTrack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION PtInTrack(theTrack: Track; pt: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $009B, $AAAA;
	{$ENDC}

{************************
* Group Selection Routines
*************************}

{
 *  SetMovieLanguage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieLanguage(theMovie: Movie; language: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $009C, $AAAA;
	{$ENDC}


{************************
* User Data
*************************}

{
 *  GetUserData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetUserData(theUserData: UserData; data: Handle; udType: OSType; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $009E, $AAAA;
	{$ENDC}

{
 *  AddUserData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION AddUserData(theUserData: UserData; data: Handle; udType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $009F, $AAAA;
	{$ENDC}

{
 *  RemoveUserData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION RemoveUserData(theUserData: UserData; udType: OSType; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00A0, $AAAA;
	{$ENDC}

{
 *  CountUserDataType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION CountUserDataType(theUserData: UserData; udType: OSType): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $014B, $AAAA;
	{$ENDC}

{
 *  GetNextUserDataType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetNextUserDataType(theUserData: UserData; udType: OSType): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01A5, $AAAA;
	{$ENDC}

{
 *  GetUserDataItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetUserDataItem(theUserData: UserData; data: UNIV Ptr; size: LONGINT; udType: OSType; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0126, $AAAA;
	{$ENDC}

{
 *  SetUserDataItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetUserDataItem(theUserData: UserData; data: UNIV Ptr; size: LONGINT; udType: OSType; index: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $012E, $AAAA;
	{$ENDC}

{
 *  AddUserDataText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION AddUserDataText(theUserData: UserData; data: Handle; udType: OSType; index: LONGINT; itlRegionTag: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $014C, $AAAA;
	{$ENDC}

{
 *  GetUserDataText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetUserDataText(theUserData: UserData; data: Handle; udType: OSType; index: LONGINT; itlRegionTag: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $014D, $AAAA;
	{$ENDC}

{
 *  RemoveUserDataText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION RemoveUserDataText(theUserData: UserData; udType: OSType; index: LONGINT; itlRegionTag: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $014E, $AAAA;
	{$ENDC}

{
 *  NewUserData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewUserData(VAR theUserData: UserData): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $012F, $AAAA;
	{$ENDC}

{
 *  DisposeUserData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DisposeUserData(theUserData: UserData): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0130, $AAAA;
	{$ENDC}

{
 *  NewUserDataFromHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewUserDataFromHandle(h: Handle; VAR theUserData: UserData): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0131, $AAAA;
	{$ENDC}

{
 *  PutUserDataIntoHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION PutUserDataIntoHandle(theUserData: UserData; h: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0132, $AAAA;
	{$ENDC}


{
 *  SetMoviePropertyAtom()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION SetMoviePropertyAtom(theMovie: Movie; propertyAtom: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0284, $AAAA;
	{$ENDC}

{
 *  GetMoviePropertyAtom()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION GetMoviePropertyAtom(theMovie: Movie; VAR propertyAtom: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0285, $AAAA;
	{$ENDC}


{
 *  GetMediaNextInterestingTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetMediaNextInterestingTime(theMedia: Media; interestingTimeFlags: INTEGER; time: TimeValue; rate: Fixed; VAR interestingTime: TimeValue; VAR interestingDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $016D, $AAAA;
	{$ENDC}

{
 *  GetTrackNextInterestingTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetTrackNextInterestingTime(theTrack: Track; interestingTimeFlags: INTEGER; time: TimeValue; rate: Fixed; VAR interestingTime: TimeValue; VAR interestingDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00E2, $AAAA;
	{$ENDC}

{
 *  GetMovieNextInterestingTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetMovieNextInterestingTime(theMovie: Movie; interestingTimeFlags: INTEGER; numMediaTypes: INTEGER; {CONST}VAR whichMediaTypes: OSType; time: TimeValue; rate: Fixed; VAR interestingTime: TimeValue; VAR interestingDuration: TimeValue);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $010E, $AAAA;
	{$ENDC}


{
 *  CreateMovieFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION CreateMovieFile({CONST}VAR fileSpec: FSSpec; creator: OSType; scriptTag: ScriptCode; createMovieFileFlags: LONGINT; VAR resRefNum: INTEGER; VAR newmovie: Movie): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0191, $AAAA;
	{$ENDC}

{
 *  OpenMovieFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION OpenMovieFile({CONST}VAR fileSpec: FSSpec; VAR resRefNum: INTEGER; permission: SInt8): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0192, $AAAA;
	{$ENDC}

{
 *  CloseMovieFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION CloseMovieFile(resRefNum: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00D5, $AAAA;
	{$ENDC}

{
 *  DeleteMovieFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION DeleteMovieFile({CONST}VAR fileSpec: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0175, $AAAA;
	{$ENDC}

{
 *  NewMovieFromFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewMovieFromFile(VAR theMovie: Movie; resRefNum: INTEGER; resId: INTEGERPtr; resName: StringPtr; newMovieFlags: INTEGER; VAR dataRefWasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F0, $AAAA;
	{$ENDC}

{
 *  NewMovieFromHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewMovieFromHandle(VAR theMovie: Movie; h: Handle; newMovieFlags: INTEGER; VAR dataRefWasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00F1, $AAAA;
	{$ENDC}

{
 *  NewMovieFromDataFork()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewMovieFromDataFork(VAR theMovie: Movie; fRefNum: INTEGER; fileOffset: LONGINT; newMovieFlags: INTEGER; VAR dataRefWasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01B3, $AAAA;
	{$ENDC}

{
 *  NewMovieFromDataFork64()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION NewMovieFromDataFork64(VAR theMovie: Movie; fRefNum: LONGINT; {CONST}VAR fileOffset: wide; newMovieFlags: INTEGER; VAR dataRefWasChanged: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02EE, $AAAA;
	{$ENDC}

{
 *  NewMovieFromUserProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewMovieFromUserProc(VAR m: Movie; flags: INTEGER; VAR dataRefWasChanged: BOOLEAN; getProc: GetMovieUPP; refCon: UNIV Ptr; defaultDataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01EC, $AAAA;
	{$ENDC}

{
 *  NewMovieFromDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewMovieFromDataRef(VAR m: Movie; flags: INTEGER; VAR id: INTEGER; dataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0220, $AAAA;
	{$ENDC}

{
 *  AddMovieResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION AddMovieResource(theMovie: Movie; resRefNum: INTEGER; VAR resId: INTEGER; resName: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00D7, $AAAA;
	{$ENDC}

{
 *  UpdateMovieResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION UpdateMovieResource(theMovie: Movie; resRefNum: INTEGER; resId: INTEGER; resName: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00D8, $AAAA;
	{$ENDC}

{
 *  RemoveMovieResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION RemoveMovieResource(resRefNum: INTEGER; resId: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0176, $AAAA;
	{$ENDC}

{
 *  HasMovieChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION HasMovieChanged(theMovie: Movie): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00D9, $AAAA;
	{$ENDC}

{
 *  ClearMovieChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE ClearMovieChanged(theMovie: Movie);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0113, $AAAA;
	{$ENDC}

{
 *  SetMovieDefaultDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetMovieDefaultDataRef(theMovie: Movie; dataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01C1, $AAAA;
	{$ENDC}

{
 *  GetMovieDefaultDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieDefaultDataRef(theMovie: Movie; VAR dataRef: Handle; VAR dataRefType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01D2, $AAAA;
	{$ENDC}

{
 *  SetMovieAnchorDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION SetMovieAnchorDataRef(theMovie: Movie; dataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0315, $AAAA;
	{$ENDC}

{
 *  GetMovieAnchorDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION GetMovieAnchorDataRef(theMovie: Movie; VAR dataRef: Handle; VAR dataRefType: OSType; VAR outFlags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0316, $AAAA;
	{$ENDC}

{
 *  SetMovieColorTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetMovieColorTable(theMovie: Movie; ctab: CTabHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0205, $AAAA;
	{$ENDC}

{
 *  GetMovieColorTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieColorTable(theMovie: Movie; VAR ctab: CTabHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0206, $AAAA;
	{$ENDC}

{
 *  FlattenMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE FlattenMovie(theMovie: Movie; movieFlattenFlags: LONGINT; {CONST}VAR theFile: FSSpec; creator: OSType; scriptTag: ScriptCode; createMovieFileFlags: LONGINT; VAR resId: INTEGER; resName: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $019B, $AAAA;
	{$ENDC}

{
 *  FlattenMovieData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION FlattenMovieData(theMovie: Movie; movieFlattenFlags: LONGINT; {CONST}VAR theFile: FSSpec; creator: OSType; scriptTag: ScriptCode; createMovieFileFlags: LONGINT): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $019C, $AAAA;
	{$ENDC}

{
 *  SetMovieProgressProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieProgressProc(theMovie: Movie; p: MovieProgressUPP; refcon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $019A, $AAAA;
	{$ENDC}

{
 *  GetMovieProgressProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
PROCEDURE GetMovieProgressProc(theMovie: Movie; VAR p: MovieProgressUPP; VAR refcon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0300, $AAAA;
	{$ENDC}

{
 *  CreateShortcutMovieFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION CreateShortcutMovieFile({CONST}VAR fileSpec: FSSpec; creator: OSType; scriptTag: ScriptCode; createMovieFileFlags: LONGINT; targetDataRef: Handle; targetDataRefType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02FA, $AAAA;
	{$ENDC}

{
 *  MovieSearchText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MovieSearchText(theMovie: Movie; text: Ptr; size: LONGINT; searchFlags: LONGINT; VAR searchTrack: Track; VAR searchTime: TimeValue; VAR searchOffset: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0207, $AAAA;
	{$ENDC}

{
 *  GetPosterBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetPosterBox(theMovie: Movie; VAR boxRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $016F, $AAAA;
	{$ENDC}

{
 *  SetPosterBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetPosterBox(theMovie: Movie; {CONST}VAR boxRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0170, $AAAA;
	{$ENDC}

{
 *  GetMovieSegmentDisplayBoundsRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieSegmentDisplayBoundsRgn(theMovie: Movie; time: TimeValue; duration: TimeValue): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $016C, $AAAA;
	{$ENDC}

{
 *  GetTrackSegmentDisplayBoundsRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackSegmentDisplayBoundsRgn(theTrack: Track; time: TimeValue; duration: TimeValue): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $016B, $AAAA;
	{$ENDC}

{
 *  SetMovieCoverProcs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMovieCoverProcs(theMovie: Movie; uncoverProc: MovieRgnCoverUPP; coverProc: MovieRgnCoverUPP; refcon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0179, $AAAA;
	{$ENDC}

{
 *  GetMovieCoverProcs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieCoverProcs(theMovie: Movie; VAR uncoverProc: MovieRgnCoverUPP; VAR coverProc: MovieRgnCoverUPP; VAR refcon: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01DD, $AAAA;
	{$ENDC}

{
 *  GetTrackStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTrackStatus(theTrack: Track): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0172, $AAAA;
	{$ENDC}

{
 *  GetMovieStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMovieStatus(theMovie: Movie; VAR firstProblemTrack: Track): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0173, $AAAA;
	{$ENDC}


CONST
	kMovieLoadStateError		= -1;
	kMovieLoadStateLoading		= 1000;
	kMovieLoadStateLoaded		= 2000;
	kMovieLoadStatePlayable		= 10000;
	kMovieLoadStatePlaythroughOK = 20000;
	kMovieLoadStateComplete		= 100000;

	{
	 *  GetMovieLoadState()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 4.1 and later
	 	}
FUNCTION GetMovieLoadState(theMovie: Movie): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0314, $AAAA;
	{$ENDC}

{ Input flags for CanQuickTimeOpenFile/DataRef }

CONST
	kQTDontUseDataToFindImporter = $00000001;
	kQTDontLookForMovieImporterIfGraphicsImporterFound = $00000002;
	kQTAllowOpeningStillImagesAsMovies = $00000004;
	kQTAllowImportersThatWouldCreateNewFile = $00000008;
	kQTAllowAggressiveImporters	= $00000010;					{  eg, TEXT and PICT movie importers }

	{	 Determines whether the file could be opened using a graphics importer or opened in place as a movie. 	}
	{
	 *  CanQuickTimeOpenFile()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 5.0 and later
	 	}
FUNCTION CanQuickTimeOpenFile(fileSpec: FSSpecPtr; fileType: OSType; fileNameExtension: OSType; VAR outCanOpenWithGraphicsImporter: BOOLEAN; VAR outCanOpenAsMovie: BOOLEAN; VAR outPreferGraphicsImporter: BOOLEAN; inFlags: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $033E, $AAAA;
	{$ENDC}

{ Determines whether the file could be opened using a graphics importer or opened in place as a movie. }
{
 *  CanQuickTimeOpenDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION CanQuickTimeOpenDataRef(dataRef: Handle; dataRefType: OSType; VAR outCanOpenWithGraphicsImporter: BOOLEAN; VAR outCanOpenAsMovie: BOOLEAN; VAR outPreferGraphicsImporter: BOOLEAN; inFlags: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $033F, $AAAA;
	{$ENDC}

{***
    Movie Controller support routines
***}
{
 *  NewMovieController()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewMovieController(theMovie: Movie; {CONST}VAR movieRect: Rect; someFlags: LONGINT): ComponentInstance;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $018A, $AAAA;
	{$ENDC}

{
 *  DisposeMovieController()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE DisposeMovieController(mc: ComponentInstance);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $018B, $AAAA;
	{$ENDC}

{
 *  ShowMovieInformation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE ShowMovieInformation(theMovie: Movie; filterProc: ModalFilterUPP; refCon: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0209, $AAAA;
	{$ENDC}


{****
    Scrap routines
****}
{
 *  PutMovieOnScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION PutMovieOnScrap(theMovie: Movie; movieScrapFlags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $018C, $AAAA;
	{$ENDC}

{
 *  NewMovieFromScrap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewMovieFromScrap(newMovieFlags: LONGINT): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $018D, $AAAA;
	{$ENDC}


{****
    DataRef routines
****}

{
 *  GetMediaDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaDataRef(theMedia: Media; index: INTEGER; VAR dataRef: Handle; VAR dataRefType: OSType; VAR dataRefAttributes: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0197, $AAAA;
	{$ENDC}

{
 *  SetMediaDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetMediaDataRef(theMedia: Media; index: INTEGER; dataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01C9, $AAAA;
	{$ENDC}

{
 *  SetMediaDataRefAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetMediaDataRefAttributes(theMedia: Media; index: INTEGER; dataRefAttributes: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01CA, $AAAA;
	{$ENDC}

{
 *  AddMediaDataRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION AddMediaDataRef(theMedia: Media; VAR index: INTEGER; dataRef: Handle; dataRefType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0198, $AAAA;
	{$ENDC}

{
 *  GetMediaDataRefCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaDataRefCount(theMedia: Media; VAR count: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0199, $AAAA;
	{$ENDC}

{
 *  QTNewAlias()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTNewAlias({CONST}VAR fss: FSSpec; VAR alias: AliasHandle; minimal: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0201, $AAAA;
	{$ENDC}

{****
    Playback hint routines
****}
{
 *  SetMoviePlayHints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMoviePlayHints(theMovie: Movie; flags: LONGINT; flagsMask: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01A1, $AAAA;
	{$ENDC}

{
 *  SetMediaPlayHints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetMediaPlayHints(theMedia: Media; flags: LONGINT; flagsMask: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01A2, $AAAA;
	{$ENDC}

{
 *  GetMediaPlayHints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetMediaPlayHints(theMedia: Media; VAR flags: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02CE, $AAAA;
	{$ENDC}

{****
    Load time track hints
****}

CONST
	preloadAlways				= $00000001;
	preloadOnlyIfEnabled		= $00000002;

	{
	 *  SetTrackLoadSettings()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
PROCEDURE SetTrackLoadSettings(theTrack: Track; preloadTime: TimeValue; preloadDuration: TimeValue; preloadFlags: LONGINT; defaultHints: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01E3, $AAAA;
	{$ENDC}

{
 *  GetTrackLoadSettings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE GetTrackLoadSettings(theTrack: Track; VAR preloadTime: TimeValue; VAR preloadDuration: TimeValue; VAR preloadFlags: LONGINT; VAR defaultHints: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01E4, $AAAA;
	{$ENDC}

{****
    Big screen TV
****}

CONST
	fullScreenHideCursor		= $00000001;
	fullScreenAllowEvents		= $00000002;
	fullScreenDontChangeMenuBar	= $00000004;
	fullScreenPreflightSize		= $00000008;

	{
	 *  BeginFullScreen()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION BeginFullScreen(VAR restoreState: Ptr; whichGD: GDHandle; VAR desiredWidth: INTEGER; VAR desiredHeight: INTEGER; VAR newWindow: WindowRef; VAR eraseColor: RGBColor; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0233, $AAAA;
	{$ENDC}

{
 *  EndFullScreen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION EndFullScreen(fullState: Ptr; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0234, $AAAA;
	{$ENDC}

{****
    Wired Actions
****}
{  flags for MovieExecuteWiredActions }

CONST
	movieExecuteWiredActionDontExecute = $00000001;

	{
	 *  AddMovieExecuteWiredActionsProc()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
	 *    CarbonLib:        in CarbonLib 1.0.2 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 4.0 and later
	 	}
FUNCTION AddMovieExecuteWiredActionsProc(theMovie: Movie; proc: MovieExecuteWiredActionsUPP; refCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0302, $AAAA;
	{$ENDC}

{
 *  RemoveMovieExecuteWiredActionsProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION RemoveMovieExecuteWiredActionsProc(theMovie: Movie; proc: MovieExecuteWiredActionsUPP; refCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0303, $AAAA;
	{$ENDC}

{
 *  MovieExecuteWiredActions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MovieExecuteWiredActions(theMovie: Movie; flags: LONGINT; actions: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0304, $AAAA;
	{$ENDC}

{****
    Sprite Toolbox
****}

CONST
	kBackgroundSpriteLayerNum	= 32767;


	{   Sprite Properties }
	kSpritePropertyMatrix		= 1;
	kSpritePropertyImageDescription = 2;
	kSpritePropertyImageDataPtr	= 3;
	kSpritePropertyVisible		= 4;
	kSpritePropertyLayer		= 5;
	kSpritePropertyGraphicsMode	= 6;
	kSpritePropertyImageDataSize = 7;
	kSpritePropertyActionHandlingSpriteID = 8;
	kSpritePropertyImageIndex	= 100;
	kSpriteTrackPropertyBackgroundColor = 101;
	kSpriteTrackPropertyOffscreenBitDepth = 102;
	kSpriteTrackPropertySampleFormat = 103;
	kSpriteTrackPropertyScaleSpritesToScaleWorld = 104;
	kSpriteTrackPropertyHasActions = 105;
	kSpriteTrackPropertyVisible	= 106;
	kSpriteTrackPropertyQTIdleEventsFrequency = 107;
	kSpriteImagePropertyRegistrationPoint = 1000;
	kSpriteImagePropertyGroupID	= 1001;

	{  special value for kSpriteTrackPropertyQTIdleEventsFrequency (the default) }
	kNoQTIdleEvents				= -1;

	{  flagsIn for SpriteWorldIdle }
	kOnlyDrawToSpriteWorld		= $00000001;
	kSpriteWorldPreflight		= $00000002;

	{  flagsOut for SpriteWorldIdle }
	kSpriteWorldDidDraw			= $00000001;
	kSpriteWorldNeedsToDraw		= $00000002;

	{  flags for sprite track sample format }
	kKeyFrameAndSingleOverride	= $00000002;
	kKeyFrameAndAllOverrides	= $00000004;

	{  sprite world flags }
	kScaleSpritesToScaleWorld	= $00000002;
	kSpriteWorldHighQuality		= $00000004;
	kSpriteWorldDontAutoInvalidate = $00000008;
	kSpriteWorldInvisible		= $00000010;

	{
	 *  NewSpriteWorld()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION NewSpriteWorld(VAR newSpriteWorld: SpriteWorld; destination: GWorldPtr; spriteLayer: GWorldPtr; VAR backgroundColor: RGBColor; background: GWorldPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0239, $AAAA;
	{$ENDC}

{
 *  DisposeSpriteWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE DisposeSpriteWorld(theSpriteWorld: SpriteWorld);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $023A, $AAAA;
	{$ENDC}

{
 *  SetSpriteWorldClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetSpriteWorldClip(theSpriteWorld: SpriteWorld; clipRgn: RgnHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $023B, $AAAA;
	{$ENDC}

{
 *  SetSpriteWorldMatrix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetSpriteWorldMatrix(theSpriteWorld: SpriteWorld; {CONST}VAR matrix: MatrixRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $023C, $AAAA;
	{$ENDC}

{
 *  SetSpriteWorldGraphicsMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetSpriteWorldGraphicsMode(theSpriteWorld: SpriteWorld; mode: LONGINT; {CONST}VAR opColor: RGBColor): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02D9, $AAAA;
	{$ENDC}

{
 *  SpriteWorldIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteWorldIdle(theSpriteWorld: SpriteWorld; flagsIn: LONGINT; VAR flagsOut: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $023D, $AAAA;
	{$ENDC}

{
 *  InvalidateSpriteWorld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION InvalidateSpriteWorld(theSpriteWorld: SpriteWorld; VAR invalidArea: Rect): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $023E, $AAAA;
	{$ENDC}

{
 *  SpriteWorldHitTest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteWorldHitTest(theSpriteWorld: SpriteWorld; flags: LONGINT; loc: Point; VAR spriteHit: Sprite): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0246, $AAAA;
	{$ENDC}

{
 *  SpriteHitTest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteHitTest(theSprite: Sprite; flags: LONGINT; loc: Point; VAR wasHit: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0247, $AAAA;
	{$ENDC}

{
 *  DisposeAllSprites()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE DisposeAllSprites(theSpriteWorld: SpriteWorld);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $023F, $AAAA;
	{$ENDC}

{
 *  SetSpriteWorldFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetSpriteWorldFlags(spriteWorld: SpriteWorld; flags: LONGINT; flagsMask: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02C2, $AAAA;
	{$ENDC}

{
 *  NewSprite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewSprite(VAR newSprite: Sprite; itsSpriteWorld: SpriteWorld; idh: ImageDescriptionHandle; imageDataPtr: Ptr; VAR matrix: MatrixRecord; visible: BOOLEAN; layer: INTEGER): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0240, $AAAA;
	{$ENDC}

{
 *  DisposeSprite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE DisposeSprite(theSprite: Sprite);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0241, $AAAA;
	{$ENDC}

{
 *  InvalidateSprite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE InvalidateSprite(theSprite: Sprite);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0242, $AAAA;
	{$ENDC}

{
 *  SetSpriteProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetSpriteProperty(theSprite: Sprite; propertyType: LONGINT; propertyValue: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0243, $AAAA;
	{$ENDC}

{
 *  GetSpriteProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetSpriteProperty(theSprite: Sprite; propertyType: LONGINT; propertyValue: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0244, $AAAA;
	{$ENDC}

{****
    QT Atom Data Support
****}

CONST
	kParentAtomIsContainer		= 0;

	{  create and dispose QTAtomContainer objects }

	{
	 *  QTNewAtomContainer()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION QTNewAtomContainer(VAR atomData: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020C, $AAAA;
	{$ENDC}

{
 *  QTDisposeAtomContainer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTDisposeAtomContainer(atomData: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020D, $AAAA;
	{$ENDC}

{  locating nested atoms within QTAtomContainer container }

{
 *  QTGetNextChildType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTGetNextChildType(container: QTAtomContainer; parentAtom: QTAtom; currentChildType: QTAtomType): QTAtomType;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020E, $AAAA;
	{$ENDC}

{
 *  QTCountChildrenOfType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTCountChildrenOfType(container: QTAtomContainer; parentAtom: QTAtom; childType: QTAtomType): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020F, $AAAA;
	{$ENDC}

{
 *  QTFindChildByIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTFindChildByIndex(container: QTAtomContainer; parentAtom: QTAtom; atomType: QTAtomType; index: INTEGER; VAR id: QTAtomID): QTAtom;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0210, $AAAA;
	{$ENDC}

{
 *  QTFindChildByID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTFindChildByID(container: QTAtomContainer; parentAtom: QTAtom; atomType: QTAtomType; id: QTAtomID; VAR index: INTEGER): QTAtom;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021D, $AAAA;
	{$ENDC}

{
 *  QTNextChildAnyType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTNextChildAnyType(container: QTAtomContainer; parentAtom: QTAtom; currentChild: QTAtom; VAR nextChild: QTAtom): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0200, $AAAA;
	{$ENDC}

{  set a leaf atom's data }
{
 *  QTSetAtomData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTSetAtomData(container: QTAtomContainer; atom: QTAtom; dataSize: LONGINT; atomData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0211, $AAAA;
	{$ENDC}

{  extracting data }
{
 *  QTCopyAtomDataToHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTCopyAtomDataToHandle(container: QTAtomContainer; atom: QTAtom; targetHandle: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0212, $AAAA;
	{$ENDC}

{
 *  QTCopyAtomDataToPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTCopyAtomDataToPtr(container: QTAtomContainer; atom: QTAtom; sizeOrLessOK: BOOLEAN; size: LONGINT; targetPtr: UNIV Ptr; VAR actualSize: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0213, $AAAA;
	{$ENDC}

{
 *  QTGetAtomTypeAndID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTGetAtomTypeAndID(container: QTAtomContainer; atom: QTAtom; VAR atomType: QTAtomType; VAR id: QTAtomID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0232, $AAAA;
	{$ENDC}

{  extract a copy of an atom and all of it's children, caller disposes }
{
 *  QTCopyAtom()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTCopyAtom(container: QTAtomContainer; atom: QTAtom; VAR targetContainer: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0214, $AAAA;
	{$ENDC}

{  obtaining direct reference to atom data }
{
 *  QTLockContainer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTLockContainer(container: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0215, $AAAA;
	{$ENDC}

{
 *  QTGetAtomDataPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTGetAtomDataPtr(container: QTAtomContainer; atom: QTAtom; VAR dataSize: LONGINT; VAR atomData: Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0216, $AAAA;
	{$ENDC}

{
 *  QTUnlockContainer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTUnlockContainer(container: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0217, $AAAA;
	{$ENDC}

{
   building QTAtomContainer trees
   creates and inserts new atom at specified index, existing atoms at or after index are moved toward end of list
   used for Top-Down tree creation
}
{
 *  QTInsertChild()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTInsertChild(container: QTAtomContainer; parentAtom: QTAtom; atomType: QTAtomType; id: QTAtomID; index: INTEGER; dataSize: LONGINT; data: UNIV Ptr; VAR newAtom: QTAtom): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0218, $AAAA;
	{$ENDC}

{  inserts children from childrenContainer as children of parentAtom }
{
 *  QTInsertChildren()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTInsertChildren(container: QTAtomContainer; parentAtom: QTAtom; childrenContainer: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0219, $AAAA;
	{$ENDC}

{  destruction }
{
 *  QTRemoveAtom()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTRemoveAtom(container: QTAtomContainer; atom: QTAtom): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021A, $AAAA;
	{$ENDC}

{
 *  QTRemoveChildren()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTRemoveChildren(container: QTAtomContainer; atom: QTAtom): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021B, $AAAA;
	{$ENDC}

{  replacement must be same type as target }
{
 *  QTReplaceAtom()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTReplaceAtom(targetContainer: QTAtomContainer; targetAtom: QTAtom; replacementContainer: QTAtomContainer; replacementAtom: QTAtom): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021C, $AAAA;
	{$ENDC}

{
 *  QTSwapAtoms()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTSwapAtoms(container: QTAtomContainer; atom1: QTAtom; atom2: QTAtom): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $01FF, $AAAA;
	{$ENDC}

{
 *  QTSetAtomID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTSetAtomID(container: QTAtomContainer; atom: QTAtom; newID: QTAtomID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0231, $AAAA;
	{$ENDC}

{
 *  QTGetAtomParent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION QTGetAtomParent(container: QTAtomContainer; childAtom: QTAtom): QTAtom;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02EF, $AAAA;
	{$ENDC}

{
 *  SetMediaPropertyAtom()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetMediaPropertyAtom(theMedia: Media; propertyAtom: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022E, $AAAA;
	{$ENDC}

{
 *  GetMediaPropertyAtom()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMediaPropertyAtom(theMedia: Media; VAR propertyAtom: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022F, $AAAA;
	{$ENDC}

{****
    Tween Support
****}

TYPE
	TweenRecordPtr = ^TweenRecord;
{$IFC TYPED_FUNCTION_POINTERS}
	TweenerDataProcPtr = FUNCTION(tr: TweenRecordPtr; tweenData: UNIV Ptr; tweenDataSize: LONGINT; dataDescriptionSeed: LONGINT; dataDescription: Handle; asyncCompletionProc: ICMCompletionProcRecordPtr; transferProc: UniversalProcPtr; refCon: UNIV Ptr): ComponentResult;
{$ELSEC}
	TweenerDataProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	TweenerDataUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TweenerDataUPP = UniversalProcPtr;
{$ENDC}	
	TweenRecord = RECORD
		version:				LONGINT;
		container:				QTAtomContainer;
		tweenAtom:				QTAtom;
		dataAtom:				QTAtom;
		percent:				Fixed;
		dataProc:				TweenerDataUPP;
		private1:				Ptr;
		private2:				Ptr;
	END;

	TweenV1RecordPtr = ^TweenV1Record;
	TweenV1Record = RECORD
		version:				LONGINT;
		container:				QTAtomContainer;
		tweenAtom:				QTAtom;
		dataAtom:				QTAtom;
		percent:				Fixed;
		dataProc:				TweenerDataUPP;
		private1:				Ptr;
		private2:				Ptr;
		fractPercent:			Fract;
	END;

	{
	 *  QTNewTween()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION QTNewTween(VAR tween: QTTweener; container: QTAtomContainer; tweenAtom: QTAtom; maxTime: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $029D, $AAAA;
	{$ENDC}

{
 *  QTDisposeTween()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTDisposeTween(tween: QTTweener): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $029F, $AAAA;
	{$ENDC}

{
 *  QTDoTween()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTDoTween(tween: QTTweener; atTime: TimeValue; result: Handle; VAR resultSize: LONGINT; tweenDataProc: TweenerDataUPP; tweenDataRefCon: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $029E, $AAAA;
	{$ENDC}

{****
    Sound Description Manipulations
****}
{
 *  AddSoundDescriptionExtension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION AddSoundDescriptionExtension(desc: SoundDescriptionHandle; extension: Handle; idType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02CF, $AAAA;
	{$ENDC}

{
 *  GetSoundDescriptionExtension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetSoundDescriptionExtension(desc: SoundDescriptionHandle; VAR extension: Handle; idType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02D0, $AAAA;
	{$ENDC}

{
 *  RemoveSoundDescriptionExtension()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION RemoveSoundDescriptionExtension(desc: SoundDescriptionHandle; idType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02D1, $AAAA;
	{$ENDC}

{****
    Preferences
****}
{
 *  GetQuickTimePreference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetQuickTimePreference(preferenceType: OSType; VAR preferenceAtom: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02D4, $AAAA;
	{$ENDC}

{
 *  SetQuickTimePreference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SetQuickTimePreference(preferenceType: OSType; preferenceAtom: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02D5, $AAAA;
	{$ENDC}

{****
    Effects and dialog Support
****}
{  atom types for entries in the effects list }

CONST
	kEffectNameAtom				= 'name';						{  name of effect  }
	kEffectTypeAtom				= 'type';						{  codec sub-type for effect  }
	kEffectManufacturerAtom		= 'manu';						{  codec manufacturer for effect  }


TYPE
	QTParamPreviewRecordPtr = ^QTParamPreviewRecord;
	QTParamPreviewRecord = RECORD
		sourceID:				LONGINT;								{  1 based source identifier }
		sourcePicture:			PicHandle;								{  picture for preview, must not dispose until dialog is disposed }
	END;

	QTParamPreviewPtr					= ^QTParamPreviewRecord;
	QTParamDialogEventRecordPtr = ^QTParamDialogEventRecord;
	QTParamDialogEventRecord = RECORD
		theEvent:				EventRecordPtr;							{  Event received by the dialog  }
		whichDialog:			DialogRef;								{  dialog that event was directed towards  }
		itemHit:				INTEGER;								{  dialog item which was hit  }
	END;

	QTParamDialogEventPtr				= ^QTParamDialogEventRecord;
	QTParamFetchPreviewRecordPtr = ^QTParamFetchPreviewRecord;
	QTParamFetchPreviewRecord = RECORD
		theWorld:				GWorldPtr;								{  the world into which to draw the preview  }
		percentage:				Fixed;									{  frame percentage (from 0.0 - 1.0) to be drawn  }
	END;

	QTParamFetchPreviewPtr				= ^QTParamFetchPreviewRecord;

CONST
	pdActionConfirmDialog		= 1;							{  no param }
	pdActionSetAppleMenu		= 2;							{  param is MenuRef }
	pdActionSetEditMenu			= 3;							{  param is MenuRef }
	pdActionGetDialogValues		= 4;							{  param is QTAtomContainer }
	pdActionSetPreviewUserItem	= 5;							{  param is long }
	pdActionSetPreviewPicture	= 6;							{  param is QTParamPreviewPtr; }
	pdActionSetColorPickerEventProc = 7;						{  param is UserEventUPP }
	pdActionSetDialogTitle		= 8;							{  param is StringPtr  }
	pdActionGetSubPanelMenu		= 9;							{  param is MenuRef*  }
	pdActionActivateSubPanel	= 10;							{  param is long  }
	pdActionConductStopAlert	= 11;							{  param is StringPtr  }
	pdActionModelessCallback	= 12;							{  param is QTParamDialogEventPtr  }
	pdActionFetchPreview		= 13;							{  param is QTParamFetchPreviewPtr  }


TYPE
	QTParameterDialog					= LONGINT;

CONST
	elOptionsIncludeNoneInList	= $00000001;					{  "None" effect is included in list  }


TYPE
	QTEffectListOptions					= LONGINT;

CONST
	pdOptionsCollectOneValue	= $00000001;					{  should collect a single value only }
	pdOptionsAllowOptionalInterpolations = $00000002;			{  non-novice interpolation options are shown  }
	pdOptionsModalDialogBox		= $00000004;					{  dialog box should be modal  }


TYPE
	QTParameterDialogOptions			= LONGINT;

CONST
	effectIsRealtime			= 0;							{  effect can be rendered in real time  }

	{
	 *  QTGetEffectsList()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION QTGetEffectsList(VAR returnedList: QTAtomContainer; minSources: LONGINT; maxSources: LONGINT; getOptions: QTEffectListOptions): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02C9, $AAAA;
	{$ENDC}

{
 *  QTCreateStandardParameterDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTCreateStandardParameterDialog(effectList: QTAtomContainer; parameters: QTAtomContainer; dialogOptions: QTParameterDialogOptions; VAR createdDialog: QTParameterDialog): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02CA, $AAAA;
	{$ENDC}

{
 *  QTIsStandardParameterDialogEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTIsStandardParameterDialogEvent(VAR pEvent: EventRecord; createdDialog: QTParameterDialog): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02CB, $AAAA;
	{$ENDC}

{
 *  QTDismissStandardParameterDialog()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTDismissStandardParameterDialog(createdDialog: QTParameterDialog): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02CC, $AAAA;
	{$ENDC}

{
 *  QTStandardParameterDialogDoAction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTStandardParameterDialogDoAction(createdDialog: QTParameterDialog; action: LONGINT; params: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02CD, $AAAA;
	{$ENDC}

{
 *  QTGetEffectSpeed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTGetEffectSpeed(parameters: QTAtomContainer; VAR pFPS: Fixed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02D2, $AAAA;
	{$ENDC}

{****
    Access Keys
****}

CONST
	kAccessKeyAtomType			= 'acky';

	kAccessKeySystemFlag		= $00000001;

	{
	 *  QTGetAccessKeys()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION QTGetAccessKeys(VAR accessKeyType: Str255; flags: LONGINT; VAR keys: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02B3, $AAAA;
	{$ENDC}

{
 *  QTRegisterAccessKey()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTRegisterAccessKey(VAR accessKeyType: Str255; flags: LONGINT; accessKey: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02B4, $AAAA;
	{$ENDC}

{
 *  QTUnregisterAccessKey()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTUnregisterAccessKey(VAR accessKeyType: Str255; flags: LONGINT; accessKey: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02B5, $AAAA;
	{$ENDC}

{****
    Time table
****}
{
 *  MakeTrackTimeTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MakeTrackTimeTable(trackH: Track; VAR offsets: LongIntPtr; startTime: TimeValue; endTime: TimeValue; timeIncrement: TimeValue; firstDataRefIndex: INTEGER; lastDataRefIndex: INTEGER; VAR retdataRefSkew: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02BE, $AAAA;
	{$ENDC}

{
 *  MakeMediaTimeTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MakeMediaTimeTable(theMedia: Media; VAR offsets: LongIntPtr; startTime: TimeValue; endTime: TimeValue; timeIncrement: TimeValue; firstDataRefIndex: INTEGER; lastDataRefIndex: INTEGER; VAR retdataRefSkew: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02BF, $AAAA;
	{$ENDC}

{
 *  GetMaxLoadedTimeInMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetMaxLoadedTimeInMovie(theMovie: Movie; VAR time: TimeValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02C0, $AAAA;
	{$ENDC}

{
 *  QTMovieNeedsTimeTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTMovieNeedsTimeTable(theMovie: Movie; VAR needsTimeTable: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02C3, $AAAA;
	{$ENDC}

{
 *  QTGetDataRefMaxFileOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTGetDataRefMaxFileOffset(movieH: Movie; dataRefType: OSType; dataRef: Handle; VAR offset: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02C6, $AAAA;
	{$ENDC}


{****
    Bandwidth management support
****}

CONST
	ConnectionSpeedPrefsType	= 'cspd';
	BandwidthManagementPrefsType = 'bwmg';



TYPE
	ConnectionSpeedPrefsRecordPtr = ^ConnectionSpeedPrefsRecord;
	ConnectionSpeedPrefsRecord = RECORD
		connectionSpeed:		LONGINT;
	END;

	ConnectionSpeedPrefsPtr				= ^ConnectionSpeedPrefsRecord;
	ConnectionSpeedPrefsHandle			= ^ConnectionSpeedPrefsPtr;
	BandwidthManagementPrefsRecordPtr = ^BandwidthManagementPrefsRecord;
	BandwidthManagementPrefsRecord = RECORD
		overrideConnectionSpeedForBandwidth: BOOLEAN;
	END;

	BandwidthManagementPrefsPtr			= ^BandwidthManagementPrefsRecord;
	BandwidthManagementPrefsHandle		= ^BandwidthManagementPrefsPtr;

CONST
	kQTIdlePriority				= 10;
	kQTNonRealTimePriority		= 20;
	kQTRealTimeSharedPriority	= 25;
	kQTRealTimePriority			= 30;

	kQTBandwidthNotifyNeedToStop = $00000001;
	kQTBandwidthNotifyGoodToGo	= $00000002;
	kQTBandwidthChangeRequest	= $00000004;
	kQTBandwidthQueueRequest	= $00000008;
	kQTBandwidthScheduledRequest = $00000010;
	kQTBandwidthVoluntaryRelease = $00000020;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	QTBandwidthNotificationProcPtr = FUNCTION(flags: LONGINT; reserved: UNIV Ptr; refcon: UNIV Ptr): OSErr;
{$ELSEC}
	QTBandwidthNotificationProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	QTBandwidthNotificationUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QTBandwidthNotificationUPP = UniversalProcPtr;
{$ENDC}	
	QTScheduledBandwidthRecordPtr = ^QTScheduledBandwidthRecord;
	QTScheduledBandwidthRecord = RECORD
		recordSize:				LONGINT;								{  total number of bytes in QTScheduledBandwidthRecord }
		priority:				LONGINT;
		dataRate:				LONGINT;
		startTime:				CompTimeValue;							{  bandwidth usage start time }
		duration:				CompTimeValue;							{  duration of bandwidth usage (0 if unknown) }
		prerollDuration:		CompTimeValue;							{  time for negotiation before startTime (0 if unknown) }
		scale:					TimeScale;								{  timescale of value/duration/prerollDuration fields }
		base:					TimeBase;								{  timebase }
	END;

	QTScheduledBandwidthPtr				= ^QTScheduledBandwidthRecord;
	QTScheduledBandwidthHandle			= ^QTScheduledBandwidthPtr;
	{
	 *  QTBandwidthRequest()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
	 *    CarbonLib:        in CarbonLib 1.0.2 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 4.0 and later
	 	}
FUNCTION QTBandwidthRequest(priority: LONGINT; callback: QTBandwidthNotificationUPP; refcon: UNIV Ptr; VAR bwRef: QTBandwidthReference; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02F5, $AAAA;
	{$ENDC}

{
 *  QTBandwidthRequestForTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION QTBandwidthRequestForTimeBase(tb: TimeBase; priority: LONGINT; callback: QTBandwidthNotificationUPP; refcon: UNIV Ptr; VAR bwRef: QTBandwidthReference; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0318, $AAAA;
	{$ENDC}

{
 *  QTBandwidthRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION QTBandwidthRelease(bwRef: QTBandwidthReference; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02F6, $AAAA;
	{$ENDC}

{
 *  QTScheduledBandwidthRequest()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION QTScheduledBandwidthRequest(scheduleRec: QTScheduledBandwidthPtr; notificationCallback: QTBandwidthNotificationUPP; refcon: UNIV Ptr; VAR sbwRef: QTScheduledBandwidthReference; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0310, $AAAA;
	{$ENDC}

{
 *  QTScheduledBandwidthRelease()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION QTScheduledBandwidthRelease(sbwRef: QTScheduledBandwidthReference; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0311, $AAAA;
	{$ENDC}

{****
    QT International Text Atom Support
****}

CONST
	kITextRemoveEverythingBut	= $00;
	kITextRemoveLeaveSuggestedAlternate = $02;

	kITextAtomType				= 'itxt';
	kITextStringAtomType		= 'text';

	{
	 *  ITextAddString()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION ITextAddString(container: QTAtomContainer; parentAtom: QTAtom; theRegionCode: RegionCode; theString: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $027A, $AAAA;
	{$ENDC}

{
 *  ITextRemoveString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION ITextRemoveString(container: QTAtomContainer; parentAtom: QTAtom; theRegionCode: RegionCode; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $027B, $AAAA;
	{$ENDC}

{
 *  ITextGetString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION ITextGetString(container: QTAtomContainer; parentAtom: QTAtom; requestedRegion: RegionCode; VAR foundRegion: RegionCode; theString: StringPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $027C, $AAAA;
	{$ENDC}

{
 *  QTTextToNativeText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION QTTextToNativeText(theText: Handle; encoding: LONGINT; flags: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $02DB, $AAAA;
	{$ENDC}

{  QTParseTextHREF inContainer atoms }

CONST
	kQTParseTextHREFText		= 'text';						{  string }
	kQTParseTextHREFBaseURL		= 'burl';						{  string }
	kQTParseTextHREFClickPoint	= 'clik';						{  Point; if present, QTParseTextHREF will expand URLs to support server-side image maps }
	kQTParseTextHREFUseAltDelim	= 'altd';						{  boolean; if no kQTParseTextHREFDelimiter, delim is ':' }
	kQTParseTextHREFDelimiter	= 'delm';						{  character }
	kQTParseTextHREFRecomposeHREF = 'rhrf';						{  Boolean; if true, QTParseTextHREF returns recomposed HREF with URL expanded as appropriate }

	{  QTParseTextHREF outContainer atoms }
	kQTParseTextHREFURL			= 'url ';						{  string }
	kQTParseTextHREFTarget		= 'targ';						{  string }
	kQTParseTextHREFChapter		= 'chap';						{  string }
	kQTParseTextHREFIsAutoHREF	= 'auto';						{  Boolean }
	kQTParseTextHREFIsServerMap	= 'smap';						{  Boolean }
	kQTParseTextHREFHREF		= 'href';						{  string; recomposed HREF with URL expanded as appropriate, suitable for mcActionLinkToURL }
	kQTParseTextHREFEMBEDArgs	= 'mbed';						{  string; text between 'E<' and '>' to be used as new movie's embed tags }

	{
	 *  QTParseTextHREF()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 4.1 and later
	 	}
FUNCTION QTParseTextHREF(href: CStringPtr; hrefLen: SInt32; inContainer: QTAtomContainer; VAR outContainer: QTAtomContainer): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0319, $AAAA;
	{$ENDC}

{************************
* track reference types
*************************}

CONST
	kTrackReferenceChapterList	= 'chap';
	kTrackReferenceTimeCode		= 'tmcd';
	kTrackReferenceModifier		= 'ssrc';

	{	************************
	* modifier track types
	*************************	}
	kTrackModifierInput			= $696E;						{  is really 'in' }
	kTrackModifierType			= $7479;						{  is really 'ty' }
	kTrackModifierReference		= 'ssrc';
	kTrackModifierObjectID		= 'obid';
	kTrackModifierInputName		= 'name';

	kInputMapSubInputID			= 'subi';

	kTrackModifierTypeMatrix	= 1;
	kTrackModifierTypeClip		= 2;
	kTrackModifierTypeGraphicsMode = 5;
	kTrackModifierTypeVolume	= 3;
	kTrackModifierTypeBalance	= 4;
	kTrackModifierTypeImage		= 'vide';						{  was kTrackModifierTypeSpriteImage }
	kTrackModifierObjectMatrix	= 6;
	kTrackModifierObjectGraphicsMode = 7;
	kTrackModifierType3d4x4Matrix = 8;
	kTrackModifierCameraData	= 9;
	kTrackModifierSoundLocalizationData = 10;
	kTrackModifierObjectImageIndex = 11;
	kTrackModifierObjectLayer	= 12;
	kTrackModifierObjectVisible	= 13;
	kTrackModifierAngleAspectCamera = 14;
	kTrackModifierPanAngle		= 'pan ';
	kTrackModifierTiltAngle		= 'tilt';
	kTrackModifierVerticalFieldOfViewAngle = 'fov ';
	kTrackModifierObjectQTEventSend = 'evnt';


TYPE
	ModifierTrackGraphicsModeRecordPtr = ^ModifierTrackGraphicsModeRecord;
	ModifierTrackGraphicsModeRecord = RECORD
		graphicsMode:			LONGINT;
		opColor:				RGBColor;
	END;


	{	************************
	* tween track types
	*************************	}

CONST
	kTweenTypeShort				= 1;
	kTweenTypeLong				= 2;
	kTweenTypeFixed				= 3;
	kTweenTypePoint				= 4;
	kTweenTypeQDRect			= 5;
	kTweenTypeQDRegion			= 6;
	kTweenTypeMatrix			= 7;
	kTweenTypeRGBColor			= 8;
	kTweenTypeGraphicsModeWithRGBColor = 9;
	kTweenTypeQTFloatSingle		= 10;
	kTweenTypeQTFloatDouble		= 11;
	kTweenTypeFixedPoint		= 12;
	kTweenType3dScale			= '3sca';
	kTweenType3dTranslate		= '3tra';
	kTweenType3dRotate			= '3rot';
	kTweenType3dRotateAboutPoint = '3rap';
	kTweenType3dRotateAboutAxis	= '3rax';
	kTweenType3dRotateAboutVector = '3rvc';
	kTweenType3dQuaternion		= '3qua';
	kTweenType3dMatrix			= '3mat';
	kTweenType3dCameraData		= '3cam';
	kTweenType3dAngleAspectCameraData = '3caa';
	kTweenType3dSoundLocalizationData = '3slc';
	kTweenTypePathToMatrixTranslation = 'gxmt';
	kTweenTypePathToMatrixRotation = 'gxpr';
	kTweenTypePathToMatrixTranslationAndRotation = 'gxmr';
	kTweenTypePathToFixedPoint	= 'gxfp';
	kTweenTypePathXtoY			= 'gxxy';
	kTweenTypePathYtoX			= 'gxyx';
	kTweenTypeAtomList			= 'atom';
	kTweenTypePolygon			= 'poly';
	kTweenTypeMultiMatrix		= 'mulm';
	kTweenTypeSpin				= 'spin';
	kTweenType3dMatrixNonLinear	= '3nlr';
	kTweenType3dVRObject		= '3vro';

	kTweenEntry					= 'twen';
	kTweenData					= 'data';
	kTweenType					= 'twnt';
	kTweenStartOffset			= 'twst';
	kTweenDuration				= 'twdu';
	kTweenFlags					= 'flag';
	kTweenOutputMin				= 'omin';
	kTweenOutputMax				= 'omax';
	kTweenSequenceElement		= 'seqe';
	kTween3dInitialCondition	= 'icnd';
	kTweenInterpolationID		= 'intr';
	kTweenRegionData			= 'qdrg';
	kTweenPictureData			= 'PICT';
	kListElementType			= 'type';
	kListElementDataType		= 'daty';
	kNameAtom					= 'name';
	kInitialRotationAtom		= 'inro';
	kNonLinearTweenHeader		= 'nlth';

	{  kTweenFlags }
	kTweenReturnDelta			= $00000001;


TYPE
	TweenSequenceEntryRecordPtr = ^TweenSequenceEntryRecord;
	TweenSequenceEntryRecord = RECORD
		endPercent:				Fixed;
		tweenAtomID:			QTAtomID;
		dataAtomID:				QTAtomID;
	END;




	{	************************
	* Video Media routines
	*************************	}



CONST
	videoFlagDontLeanAhead		= $00000001;




	{  use these five routines at your own peril }
	{
	 *  VideoMediaResetStatistics()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION VideoMediaResetStatistics(mh: MediaHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0105, $7000, $A82A;
	{$ENDC}

{
 *  VideoMediaGetStatistics()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VideoMediaGetStatistics(mh: MediaHandler): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0106, $7000, $A82A;
	{$ENDC}


{
 *  VideoMediaGetStallCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION VideoMediaGetStallCount(mh: MediaHandler; VAR stalls: UInt32): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010E, $7000, $A82A;
	{$ENDC}


{
 *  VideoMediaSetCodecParameter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION VideoMediaSetCodecParameter(mh: MediaHandler; cType: CodecType; parameterID: OSType; parameterChangeSeed: LONGINT; dataPtr: UNIV Ptr; dataSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $010F, $7000, $A82A;
	{$ENDC}

{
 *  VideoMediaGetCodecParameter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION VideoMediaGetCodecParameter(mh: MediaHandler; cType: CodecType; parameterID: OSType; outParameterData: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0110, $7000, $A82A;
	{$ENDC}




{************************
* Text Media routines
*************************}



{ Return displayFlags for TextProc }

CONST
	txtProcDefaultDisplay		= 0;							{     Use the media's default }
	txtProcDontDisplay			= 1;							{     Don't display the text }
	txtProcDoDisplay			= 2;							{     Do display the text }

	{
	 *  TextMediaSetTextProc()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION TextMediaSetTextProc(mh: MediaHandler; TextProc: TextMediaUPP; refcon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0101, $7000, $A82A;
	{$ENDC}

{
 *  TextMediaAddTextSample()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TextMediaAddTextSample(mh: MediaHandler; text: Ptr; size: UInt32; fontNumber: INTEGER; fontSize: INTEGER; textFace: ByteParameter; VAR textColor: RGBColor; VAR backColor: RGBColor; textJustification: INTEGER; VAR textBox: Rect; displayFlags: LONGINT; scrollDelay: TimeValue; hiliteStart: INTEGER; hiliteEnd: INTEGER; VAR rgbHiliteColor: RGBColor; duration: TimeValue; VAR sampleTime: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0034, $0102, $7000, $A82A;
	{$ENDC}

{
 *  TextMediaAddTESample()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TextMediaAddTESample(mh: MediaHandler; hTE: TEHandle; VAR backColor: RGBColor; textJustification: INTEGER; VAR textBox: Rect; displayFlags: LONGINT; scrollDelay: TimeValue; hiliteStart: INTEGER; hiliteEnd: INTEGER; VAR rgbHiliteColor: RGBColor; duration: TimeValue; VAR sampleTime: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0026, $0103, $7000, $A82A;
	{$ENDC}

{
 *  TextMediaAddHiliteSample()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TextMediaAddHiliteSample(mh: MediaHandler; hiliteStart: INTEGER; hiliteEnd: INTEGER; VAR rgbHiliteColor: RGBColor; duration: TimeValue; VAR sampleTime: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0104, $7000, $A82A;
	{$ENDC}

{
 *  TextMediaDrawRaw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION TextMediaDrawRaw(mh: MediaHandler; gw: GWorldPtr; gd: GDHandle; data: UNIV Ptr; dataSize: LONGINT; tdh: TextDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0109, $7000, $A82A;
	{$ENDC}

{
 *  TextMediaSetTextProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION TextMediaSetTextProperty(mh: MediaHandler; atMediaTime: TimeValue; propertyType: LONGINT; data: UNIV Ptr; dataSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $010A, $7000, $A82A;
	{$ENDC}

{
 *  TextMediaRawSetup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION TextMediaRawSetup(mh: MediaHandler; gw: GWorldPtr; gd: GDHandle; data: UNIV Ptr; dataSize: LONGINT; tdh: TextDescriptionHandle; sampleDuration: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0018, $010B, $7000, $A82A;
	{$ENDC}

{
 *  TextMediaRawIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION TextMediaRawIdle(mh: MediaHandler; gw: GWorldPtr; gd: GDHandle; sampleTime: TimeValue; flagsIn: LONGINT; VAR flagsOut: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $010C, $7000, $A82A;
	{$ENDC}

{
 *  TextMediaGetTextProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION TextMediaGetTextProperty(mh: MediaHandler; atMediaTime: TimeValue; propertyType: LONGINT; data: UNIV Ptr; dataSize: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $010D, $7000, $A82A;
	{$ENDC}


CONST
	findTextEdgeOK				= $01;							{  Okay to find text at specified sample time }
	findTextCaseSensitive		= $02;							{  Case sensitive search }
	findTextReverseSearch		= $04;							{  Search from sampleTime backwards }
	findTextWrapAround			= $08;							{  Wrap search when beginning or end of movie is hit }
	findTextUseOffset			= $10;							{  Begin search at the given character offset into sample rather than edge }

	{
	 *  TextMediaFindNextText()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION TextMediaFindNextText(mh: MediaHandler; text: Ptr; size: LONGINT; findFlags: INTEGER; startTime: TimeValue; VAR foundTime: TimeValue; VAR foundDuration: TimeValue; VAR offset: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $001A, $0105, $7000, $A82A;
	{$ENDC}

{
 *  TextMediaHiliteTextSample()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION TextMediaHiliteTextSample(mh: MediaHandler; sampleTime: TimeValue; hiliteStart: INTEGER; hiliteEnd: INTEGER; VAR rgbHiliteColor: RGBColor): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0106, $7000, $A82A;
	{$ENDC}


CONST
	dropShadowOffsetType		= 'drpo';
	dropShadowTranslucencyType	= 'drpt';

	{
	 *  TextMediaSetTextSampleData()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION TextMediaSetTextSampleData(mh: MediaHandler; data: UNIV Ptr; dataType: OSType): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0107, $7000, $A82A;
	{$ENDC}





{************************
* Sprite Media routines
*************************}
{ flags for sprite hit test routines }

CONST
	spriteHitTestBounds			= $00000001;					{     point must only be within sprite's bounding box }
	spriteHitTestImage			= $00000002;					{   point must be within the shape of the sprite's image }
	spriteHitTestInvisibleSprites = $00000004;					{   invisible sprites may be hit tested }
	spriteHitTestIsClick		= $00000008;					{   for codecs that want mouse events }
	spriteHitTestLocInDisplayCoordinates = $00000010;			{     set if you want to pass a display coordiate point to SpriteHitTest }

	{	 atom types for sprite media 	}
	kSpriteAtomType				= 'sprt';
	kSpriteImagesContainerAtomType = 'imct';
	kSpriteImageAtomType		= 'imag';
	kSpriteImageDataAtomType	= 'imda';
	kSpriteImageDataRefAtomType	= 'imre';
	kSpriteImageDataRefTypeAtomType = 'imrt';
	kSpriteImageGroupIDAtomType	= 'imgr';
	kSpriteImageRegistrationAtomType = 'imrg';
	kSpriteImageDefaultImageIndexAtomType = 'defi';
	kSpriteSharedDataAtomType	= 'dflt';
	kSpriteNameAtomType			= 'name';
	kSpriteImageNameAtomType	= 'name';
	kSpriteUsesImageIDsAtomType	= 'uses';						{  leaf data is an array of QTAtomID's, one per image used }
	kSpriteBehaviorsAtomType	= 'beha';
	kSpriteImageBehaviorAtomType = 'imag';
	kSpriteCursorBehaviorAtomType = 'crsr';
	kSpriteStatusStringsBehaviorAtomType = 'sstr';
	kSpriteVariablesContainerAtomType = 'vars';
	kSpriteStringVariableAtomType = 'strv';
	kSpriteFloatingPointVariableAtomType = 'flov';


TYPE
	QTRuntimeSpriteDescStructPtr = ^QTRuntimeSpriteDescStruct;
	QTRuntimeSpriteDescStruct = RECORD
		version:				LONGINT;								{  set to zero }
		spriteID:				QTAtomID;
		imageIndex:				INTEGER;
		matrix:					MatrixRecord;
		visible:				INTEGER;
		layer:					INTEGER;
		graphicsMode:			ModifierTrackGraphicsModeRecord;
		actionHandlingSpriteID:	QTAtomID;
	END;

	QTRuntimeSpriteDescPtr				= ^QTRuntimeSpriteDescStruct;
	{
	   when filling in QTSpriteButtonBehaviorStruct values -1 may be used to indicate that
	   the state transition does not change the property
	}
	QTSpriteButtonBehaviorStructPtr = ^QTSpriteButtonBehaviorStruct;
	QTSpriteButtonBehaviorStruct = RECORD
		notOverNotPressedStateID: QTAtomID;
		overNotPressedStateID:	QTAtomID;
		overPressedStateID:		QTAtomID;
		notOverPressedStateID:	QTAtomID;
	END;

	QTSpriteButtonBehaviorPtr			= ^QTSpriteButtonBehaviorStruct;
	{
	 *  SpriteMediaSetProperty()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION SpriteMediaSetProperty(mh: MediaHandler; spriteIndex: INTEGER; propertyType: LONGINT; propertyValue: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0101, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaGetProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaGetProperty(mh: MediaHandler; spriteIndex: INTEGER; propertyType: LONGINT; propertyValue: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0102, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaHitTestSprites()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaHitTestSprites(mh: MediaHandler; flags: LONGINT; loc: Point; VAR spriteHitIndex: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0103, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaCountSprites()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaCountSprites(mh: MediaHandler; VAR numSprites: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0104, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaCountImages()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaCountImages(mh: MediaHandler; VAR numImages: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0105, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaGetIndImageDescription()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaGetIndImageDescription(mh: MediaHandler; imageIndex: INTEGER; imageDescription: ImageDescriptionHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0106, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaGetDisplayedSampleNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaGetDisplayedSampleNumber(mh: MediaHandler; VAR sampleNum: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0107, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaGetSpriteName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaGetSpriteName(mh: MediaHandler; spriteID: QTAtomID; VAR spriteName: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0108, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaGetImageName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaGetImageName(mh: MediaHandler; imageIndex: INTEGER; VAR imageName: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0109, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaSetSpriteProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaSetSpriteProperty(mh: MediaHandler; spriteID: QTAtomID; propertyType: LONGINT; propertyValue: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $010A, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaGetSpriteProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaGetSpriteProperty(mh: MediaHandler; spriteID: QTAtomID; propertyType: LONGINT; propertyValue: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $010B, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaHitTestAllSprites()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaHitTestAllSprites(mh: MediaHandler; flags: LONGINT; loc: Point; VAR spriteHitID: QTAtomID): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $010C, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaHitTestOneSprite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaHitTestOneSprite(mh: MediaHandler; spriteID: QTAtomID; flags: LONGINT; loc: Point; VAR wasHit: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $010D, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaSpriteIndexToID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaSpriteIndexToID(mh: MediaHandler; spriteIndex: INTEGER; VAR spriteID: QTAtomID): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $010E, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaSpriteIDToIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaSpriteIDToIndex(mh: MediaHandler; spriteID: QTAtomID; VAR spriteIndex: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $010F, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaGetSpriteActionsForQTEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaGetSpriteActionsForQTEvent(mh: MediaHandler; event: QTEventRecordPtr; spriteID: QTAtomID; VAR container: QTAtomContainer; VAR atom: QTAtom): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0110, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaSetActionVariable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaSetActionVariable(mh: MediaHandler; variableID: QTAtomID; {CONST}VAR value: Single): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0111, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaGetActionVariable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaGetActionVariable(mh: MediaHandler; variableID: QTAtomID; VAR value: Single): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0112, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaGetIndImageProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION SpriteMediaGetIndImageProperty(mh: MediaHandler; imageIndex: INTEGER; imagePropertyType: LONGINT; imagePropertyValue: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $0113, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaNewSprite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION SpriteMediaNewSprite(mh: MediaHandler; newSpriteDesc: QTRuntimeSpriteDescPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0114, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaDisposeSprite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION SpriteMediaDisposeSprite(mh: MediaHandler; spriteID: QTAtomID): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0115, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaSetActionVariableToString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION SpriteMediaSetActionVariableToString(mh: MediaHandler; variableID: QTAtomID; theCString: Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0116, $7000, $A82A;
	{$ENDC}

{
 *  SpriteMediaGetActionVariableAsString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION SpriteMediaGetActionVariableAsString(mh: MediaHandler; variableID: QTAtomID; VAR theCString: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0117, $7000, $A82A;
	{$ENDC}



{************************
* Flash Media routines
*************************}

{
 *  FlashMediaSetPan()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION FlashMediaSetPan(mh: MediaHandler; xPercent: INTEGER; yPercent: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}

{
 *  FlashMediaSetZoom()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION FlashMediaSetZoom(mh: MediaHandler; factor: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0102, $7000, $A82A;
	{$ENDC}

{
 *  FlashMediaSetZoomRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION FlashMediaSetZoomRect(mh: MediaHandler; left: LONGINT; top: LONGINT; right: LONGINT; bottom: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0103, $7000, $A82A;
	{$ENDC}

{
 *  FlashMediaGetRefConBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION FlashMediaGetRefConBounds(mh: MediaHandler; refCon: LONGINT; VAR left: LONGINT; VAR top: LONGINT; VAR right: LONGINT; VAR bottom: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0014, $0104, $7000, $A82A;
	{$ENDC}

{
 *  FlashMediaGetRefConID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION FlashMediaGetRefConID(mh: MediaHandler; refCon: LONGINT; VAR refConID: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0105, $7000, $A82A;
	{$ENDC}

{
 *  FlashMediaIDToRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION FlashMediaIDToRefCon(mh: MediaHandler; refConID: LONGINT; VAR refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0106, $7000, $A82A;
	{$ENDC}

{
 *  FlashMediaGetDisplayedFrameNumber()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION FlashMediaGetDisplayedFrameNumber(mh: MediaHandler; VAR flashFrameNumber: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0107, $7000, $A82A;
	{$ENDC}

{
 *  FlashMediaFrameNumberToMovieTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION FlashMediaFrameNumberToMovieTime(mh: MediaHandler; flashFrameNumber: LONGINT; VAR movieTime: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0108, $7000, $A82A;
	{$ENDC}

{
 *  FlashMediaFrameLabelToMovieTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION FlashMediaFrameLabelToMovieTime(mh: MediaHandler; theLabel: Ptr; VAR movieTime: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0109, $7000, $A82A;
	{$ENDC}

{
 *  FlashMediaGetFlashVariable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION FlashMediaGetFlashVariable(mh: MediaHandler; path: CStringPtr; name: CStringPtr; VAR theVariableCStringOut: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $010A, $7000, $A82A;
	{$ENDC}

{
 *  FlashMediaSetFlashVariable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION FlashMediaSetFlashVariable(mh: MediaHandler; path: CStringPtr; name: CStringPtr; value: CStringPtr; updateFocus: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000E, $010B, $7000, $A82A;
	{$ENDC}

{
 *  FlashMediaDoButtonActions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION FlashMediaDoButtonActions(mh: MediaHandler; path: CStringPtr; buttonID: LONGINT; transition: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $010C, $7000, $A82A;
	{$ENDC}

{
 *  FlashMediaGetSupportedSwfVersion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION FlashMediaGetSupportedSwfVersion(mh: MediaHandler; VAR swfVersion: UInt8): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010D, $7000, $A82A;
	{$ENDC}



{  sample format atoms }

CONST
	kMovieMediaDataReference	= 'mmdr';						{  data reference }
	kMovieMediaDefaultDataReferenceID = 'ddri';					{  atom id }
	kMovieMediaSlaveTime		= 'slti';						{  boolean }
	kMovieMediaSlaveAudio		= 'slau';						{  boolean }
	kMovieMediaSlaveGraphicsMode = 'slgr';						{  boolean }
	kMovieMediaAutoPlay			= 'play';						{  boolean }
	kMovieMediaLoop				= 'loop';						{  UInt8 (0=no loop, 1=loop, 2=palindrome loop) }
	kMovieMediaUseMIMEType		= 'mime';						{  string indicating the MIME type to use for the dataref (usually not required) }
	kMovieMediaTitle			= 'titl';						{  string of the media's title (tooltips) }
	kMovieMediaAltText			= 'altt';						{  string of alternate text if media isn't loaded }
	kMovieMediaClipBegin		= 'clpb';						{  MovieMediaTimeRecord of start time of embedded media }
	kMovieMediaClipDuration		= 'clpd';						{  MovieMediaTimeRecord of duration of embedded media }
	kMovieMediaRegionAtom		= 'regi';						{  contains subatoms that describe layout }
	kMovieMediaSlaveTrackDuration = 'sltr';						{  Boolean indicating that media handler should adjust track and media based on actual embedded movie duration }
	kMovieMediaEnableFrameStepping = 'enfs';					{  boolean. if true stepping on external movie steps frames within embedded movie. }
	kMovieMediaBackgroundColor	= 'bkcl';						{  RGBColor. }
	kMovieMediaPrerollTime		= 'prer';						{  SInt32 indicating preroll time }

	{  fit types }
	kMovieMediaFitNone			= 0;
	kMovieMediaFitScroll		= 'scro';
	kMovieMediaFitClipIfNecessary = 'hidd';
	kMovieMediaFitFill			= 'fill';
	kMovieMediaFitMeet			= 'meet';
	kMovieMediaFitSlice			= 'slic';

	{  sub atoms for region atom }
	kMovieMediaSpatialAdjustment = 'fit ';						{  OSType from kMovieMediaFit* }
	kMovieMediaRectangleAtom	= 'rect';
	kMovieMediaTop				= 'top ';
	kMovieMediaLeft				= 'left';
	kMovieMediaWidth			= 'wd  ';
	kMovieMediaHeight			= 'ht  ';

	{  contained movie properties }
	kMoviePropertyDuration		= 'dura';						{  TimeValue * }
	kMoviePropertyTimeScale		= 'tims';						{  TimeValue * }
	kMoviePropertyTime			= 'timv';						{  TimeValue * }
	kMoviePropertyNaturalBounds	= 'natb';						{  Rect * }
	kMoviePropertyMatrix		= 'mtrx';						{  Matrix * }
	kMoviePropertyTrackList		= 'tlst';						{  long *** }


	kTrackPropertyMediaType		= 'mtyp';						{  OSType }
	kTrackPropertyInstantiation	= 'inst';						{  MovieMediaInstantiationInfoRecord }


TYPE
	MovieMediaTimeRecordPtr = ^MovieMediaTimeRecord;
	MovieMediaTimeRecord = RECORD
		time:					wide;
		scale:					TimeScale;
	END;

	MovieMediaInstantiationInfoRecordPtr = ^MovieMediaInstantiationInfoRecord;
	MovieMediaInstantiationInfoRecord = RECORD
		immediately:			BOOLEAN;
		pad:					BOOLEAN;
		bitRate:				SInt32;
	END;

	{	************************
	* Movie Media routines
	*************************	}


	{
	 *  MovieMediaGetChildDoMCActionCallback()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 4.1 and later
	 	}
FUNCTION MovieMediaGetChildDoMCActionCallback(mh: MediaHandler; VAR doMCActionCallbackProc: DoMCActionUPP; VAR refcon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0102, $7000, $A82A;
	{$ENDC}

{
 *  MovieMediaGetDoMCActionCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION MovieMediaGetDoMCActionCallback(mh: MediaHandler; VAR doMCActionCallbackProc: DoMCActionUPP; VAR refcon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0103, $7000, $A82A;
	{$ENDC}

{
 *  MovieMediaGetCurrentMovieProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION MovieMediaGetCurrentMovieProperty(mh: MediaHandler; whichProperty: OSType; value: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0104, $7000, $A82A;
	{$ENDC}

{
 *  MovieMediaGetCurrentTrackProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION MovieMediaGetCurrentTrackProperty(mh: MediaHandler; trackID: LONGINT; whichProperty: OSType; value: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0105, $7000, $A82A;
	{$ENDC}

{
 *  MovieMediaGetChildMovieDataReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION MovieMediaGetChildMovieDataReference(mh: MediaHandler; dataRefID: QTAtomID; dataRefIndex: INTEGER; VAR dataRefType: OSType; VAR dataRef: Handle; VAR dataRefIDOut: QTAtomID; VAR dataRefIndexOut: INTEGER): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0016, $0106, $7000, $A82A;
	{$ENDC}

{
 *  MovieMediaSetChildMovieDataReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION MovieMediaSetChildMovieDataReference(mh: MediaHandler; dataRefID: QTAtomID; dataRefType: OSType; dataRef: Handle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0107, $7000, $A82A;
	{$ENDC}

{
 *  MovieMediaLoadChildMovieFromDataReference()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION MovieMediaLoadChildMovieFromDataReference(mh: MediaHandler; dataRefID: QTAtomID): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0108, $7000, $A82A;
	{$ENDC}



{************************
* 3D Media routines
*************************}
{
 *  Media3DGetNamedObjectList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION Media3DGetNamedObjectList(mh: MediaHandler; VAR objectList: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0101, $7000, $A82A;
	{$ENDC}

{
 *  Media3DGetRendererList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION Media3DGetRendererList(mh: MediaHandler; VAR rendererList: QTAtomContainer): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0102, $7000, $A82A;
	{$ENDC}

{
 *  Media3DGetCurrentGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION Media3DGetCurrentGroup(mh: MediaHandler; group: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0103, $7000, $A82A;
	{$ENDC}

{
 *  Media3DTranslateNamedObjectTo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION Media3DTranslateNamedObjectTo(mh: MediaHandler; objectName: CStringPtr; x: Fixed; y: Fixed; z: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0104, $7000, $A82A;
	{$ENDC}

{
 *  Media3DScaleNamedObjectTo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION Media3DScaleNamedObjectTo(mh: MediaHandler; objectName: CStringPtr; xScale: Fixed; yScale: Fixed; zScale: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0105, $7000, $A82A;
	{$ENDC}

{
 *  Media3DRotateNamedObjectTo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION Media3DRotateNamedObjectTo(mh: MediaHandler; objectName: CStringPtr; xDegrees: Fixed; yDegrees: Fixed; zDegrees: Fixed): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $0106, $7000, $A82A;
	{$ENDC}

{
 *  Media3DSetCameraData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION Media3DSetCameraData(mh: MediaHandler; cameraData: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0107, $7000, $A82A;
	{$ENDC}

{
 *  Media3DGetCameraData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION Media3DGetCameraData(mh: MediaHandler; cameraData: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0108, $7000, $A82A;
	{$ENDC}

{
 *  Media3DSetCameraAngleAspect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION Media3DSetCameraAngleAspect(mh: MediaHandler; fov: QTFloatSingle; aspectRatioXToY: QTFloatSingle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0109, $7000, $A82A;
	{$ENDC}

{
 *  Media3DGetCameraAngleAspect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION Media3DGetCameraAngleAspect(mh: MediaHandler; VAR fov: QTFloatSingle; VAR aspectRatioXToY: QTFloatSingle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $010A, $7000, $A82A;
	{$ENDC}


{
 *  Media3DSetCameraRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION Media3DSetCameraRange(mh: MediaHandler; tQ3CameraRange: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010D, $7000, $A82A;
	{$ENDC}

{
 *  Media3DGetCameraRange()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION Media3DGetCameraRange(mh: MediaHandler; tQ3CameraRange: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010E, $7000, $A82A;
	{$ENDC}

{
 *  Media3DGetViewObject()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.1 and later
 }
FUNCTION Media3DGetViewObject(mh: MediaHandler; tq3viewObject: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $010F, $7000, $A82A;
	{$ENDC}



{***************************************
*                                       *
*   M O V I E   C O N T R O L L E R     *
*                                       *
***************************************}

CONST
	MovieControllerComponentType = 'play';


	kMovieControllerQTVRFlag	= $01;
	kMovieControllerDontDisplayToUser = $02;


TYPE
	MovieController						= ComponentInstance;
	MovieControllerPtr					= ^MovieController;

CONST
	mcActionIdle				= 1;							{  no param }
	mcActionDraw				= 2;							{  param is WindowRef }
	mcActionActivate			= 3;							{  no param }
	mcActionDeactivate			= 4;							{  no param }
	mcActionMouseDown			= 5;							{  param is pointer to EventRecord }
	mcActionKey					= 6;							{  param is pointer to EventRecord }
	mcActionPlay				= 8;							{  param is Fixed, play rate }
	mcActionGoToTime			= 12;							{  param is TimeRecord }
	mcActionSetVolume			= 14;							{  param is a short }
	mcActionGetVolume			= 15;							{  param is pointer to a short }
	mcActionStep				= 18;							{  param is number of steps (short) }
	mcActionSetLooping			= 21;							{  param is Boolean }
	mcActionGetLooping			= 22;							{  param is pointer to a Boolean }
	mcActionSetLoopIsPalindrome	= 23;							{  param is Boolean }
	mcActionGetLoopIsPalindrome	= 24;							{  param is pointer to a Boolean }
	mcActionSetGrowBoxBounds	= 25;							{  param is a Rect }
	mcActionControllerSizeChanged = 26;							{  no param }
	mcActionSetSelectionBegin	= 29;							{  param is TimeRecord }
	mcActionSetSelectionDuration = 30;							{  param is TimeRecord, action only taken on set-duration }
	mcActionSetKeysEnabled		= 32;							{  param is Boolean }
	mcActionGetKeysEnabled		= 33;							{  param is pointer to Boolean }
	mcActionSetPlaySelection	= 34;							{  param is Boolean }
	mcActionGetPlaySelection	= 35;							{  param is pointer to Boolean }
	mcActionSetUseBadge			= 36;							{  param is Boolean }
	mcActionGetUseBadge			= 37;							{  param is pointer to Boolean }
	mcActionSetFlags			= 38;							{  param is long of flags }
	mcActionGetFlags			= 39;							{  param is pointer to a long of flags }
	mcActionSetPlayEveryFrame	= 40;							{  param is Boolean }
	mcActionGetPlayEveryFrame	= 41;							{  param is pointer to Boolean }
	mcActionGetPlayRate			= 42;							{  param is pointer to Fixed }
	mcActionShowBalloon			= 43;							{  param is a pointer to a boolean. set to false to stop balloon }
	mcActionBadgeClick			= 44;							{  param is pointer to Boolean. set to false to ignore click }
	mcActionMovieClick			= 45;							{  param is pointer to event record. change "what" to nullEvt to kill click }
	mcActionSuspend				= 46;							{  no param }
	mcActionResume				= 47;							{  no param }
	mcActionSetControllerKeysEnabled = 48;						{  param is Boolean }
	mcActionGetTimeSliderRect	= 49;							{  param is pointer to rect }
	mcActionMovieEdited			= 50;							{  no param }
	mcActionGetDragEnabled		= 51;							{  param is pointer to Boolean }
	mcActionSetDragEnabled		= 52;							{  param is Boolean }
	mcActionGetSelectionBegin	= 53;							{  param is TimeRecord }
	mcActionGetSelectionDuration = 54;							{  param is TimeRecord }
	mcActionPrerollAndPlay		= 55;							{  param is Fixed, play rate }
	mcActionGetCursorSettingEnabled = 56;						{  param is pointer to Boolean }
	mcActionSetCursorSettingEnabled = 57;						{  param is Boolean }
	mcActionSetColorTable		= 58;							{  param is CTabHandle }
	mcActionLinkToURL			= 59;							{  param is Handle to URL }
	mcActionCustomButtonClick	= 60;							{  param is pointer to EventRecord }
	mcActionForceTimeTableUpdate = 61;							{  no param }
	mcActionSetControllerTimeLimits = 62;						{  param is pointer to 2 time values min/max. do no send this message to controller. used internally only. }
	mcActionExecuteAllActionsForQTEvent = 63;					{  param is ResolvedQTEventSpecPtr }
	mcActionExecuteOneActionForQTEvent = 64;					{  param is ResolvedQTEventSpecPtr }
	mcActionAdjustCursor		= 65;							{  param is pointer to EventRecord (WindowRef is in message parameter) }
	mcActionUseTrackForTimeTable = 66;							{  param is pointer to (long trackID; Boolean useIt). do not send this message to controller.  }
	mcActionClickAndHoldPoint	= 67;							{  param is point (local coordinates). return true if point has click & hold action (e.g., VR object movie autorotate spot) }
	mcActionShowMessageString	= 68;							{  param is a StringPtr }
	mcActionShowStatusString	= 69;							{  param is a QTStatusStringPtr }
	mcActionGetExternalMovie	= 70;							{  param is a QTGetExternalMoviePtr }
	mcActionGetChapterTime		= 71;							{  param is a QTGetChapterTimePtr }
	mcActionPerformActionList	= 72;							{  param is a QTAtomSpecPtr }
	mcActionEvaluateExpression	= 73;							{  param is a QTEvaluateExpressionPtr }
	mcActionFetchParameterAs	= 74;							{  param is a QTFetchParameterAsPtr }
	mcActionGetCursorByID		= 75;							{  param is a QTGetCursorByIDPtr }
	mcActionGetNextURL			= 76;							{  param is a Handle to URL }
	mcActionMovieChanged		= 77;
	mcActionDoScript			= 78;							{  param is QTDoScriptPtr }
	mcActionRestartAtTime		= 79;							{  param is QTResartAtTimePtr }
	mcActionGetIndChapter		= 80;							{  param is QTChapterInfoPtr }
	mcActionLinkToURLExtended	= 81;							{  param is QTAtomContainer as used by QTParseHREF }
	mcActionSetVolumeStep		= 82;							{  param is short containing amount to step volume via arrow keys - default = 64 }
	mcActionAutoPlay			= 83;							{  param is Fixed, play rate }
	mcActionPauseToBuffer		= 84;							{  param is Fixed, play rate on restart }
	mcActionAppMessageReceived	= 85;							{  param is a long, application message }
	mcActionEvaluateExpressionWithType = 89;					{  param is a QTEvaluateExpressionWithTypePtr }
	mcActionGetMovieName		= 90;							{  param is a p String Handle }
	mcActionGetMovieID			= 91;							{  param is pointer to long }
	mcActionGetMovieActive		= 92;							{  param is pointer to Boolean }


TYPE
	mcAction							= INTEGER;

CONST
	mcFlagSuppressMovieFrame	= $01;
	mcFlagSuppressStepButtons	= $02;
	mcFlagSuppressSpeakerButton	= $04;
	mcFlagsUseWindowPalette		= $08;
	mcFlagsDontInvalidate		= $10;
	mcFlagsUseCustomButton		= $20;


	mcPositionDontInvalidate	= $20;


TYPE
	mcFlags								= UInt32;

CONST
	kMCIEEnabledButtonPicture	= 1;
	kMCIEDisabledButtonPicture	= 2;
	kMCIEDepressedButtonPicture	= 3;
	kMCIEEnabledSizeBoxPicture	= 4;
	kMCIEDisabledSizeBoxPicture	= 5;
	kMCIEEnabledUnavailableButtonPicture = 6;
	kMCIEDisabledUnavailableButtonPicture = 7;
	kMCIESoundSlider			= 128;
	kMCIESoundThumb				= 129;
	kMCIEColorTable				= 256;
	kMCIEIsFlatAppearance		= 257;
	kMCIEDoButtonIconsDropOnDepress = 258;


TYPE
	MCInterfaceElement					= UInt32;
{$IFC TYPED_FUNCTION_POINTERS}
	MCActionFilterProcPtr = FUNCTION(mc: MovieController; VAR action: INTEGER; params: UNIV Ptr): BOOLEAN;
{$ELSEC}
	MCActionFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MCActionFilterWithRefConProcPtr = FUNCTION(mc: MovieController; action: INTEGER; params: UNIV Ptr; refCon: LONGINT): BOOLEAN;
{$ELSEC}
	MCActionFilterWithRefConProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	MCActionFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MCActionFilterUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MCActionFilterWithRefConUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MCActionFilterWithRefConUPP = UniversalProcPtr;
{$ENDC}	
	{	
	    menu related stuff
		}

CONST
	mcInfoUndoAvailable			= $01;
	mcInfoCutAvailable			= $02;
	mcInfoCopyAvailable			= $04;
	mcInfoPasteAvailable		= $08;
	mcInfoClearAvailable		= $10;
	mcInfoHasSound				= $20;
	mcInfoIsPlaying				= $40;
	mcInfoIsLooping				= $80;
	mcInfoIsInPalindrome		= $0100;
	mcInfoEditingEnabled		= $0200;
	mcInfoMovieIsInteractive	= $0400;

	{  menu item codes }
	mcMenuUndo					= 1;
	mcMenuCut					= 3;
	mcMenuCopy					= 4;
	mcMenuPaste					= 5;
	mcMenuClear					= 6;

	{  messages to the application via mcActionAppMessageReceived }
	kQTAppMessageSoftwareChanged = 1;							{  notification to app that installed QuickTime software has been updated }
	kQTAppMessageWindowCloseRequested = 3;						{  request for app to close window containing movie controller }
	kQTAppMessageExitFullScreenRequested = 4;					{  request for app to turn off full screen mode if active }
	kQTAppMessageDisplayChannels = 5;							{  request for app to display the channel UI }
	kQTAppMessageEnterFullScreenRequested = 6;					{  request for app to turn on full screen mode }

	{  structures used as mcActionFilterProc params }

TYPE
	QTStatusStringRecordPtr = ^QTStatusStringRecord;
	QTStatusStringRecord = RECORD
		stringTypeFlags:		LONGINT;
		statusString:			CStringPtr;
	END;

	QTStatusStringPtr					= ^QTStatusStringRecord;
	QTGetExternalMovieRecordPtr = ^QTGetExternalMovieRecord;
	QTGetExternalMovieRecord = RECORD
		targetType:				LONGINT;								{  set to kTargetMovieName or kTargetMovieID }
		movieName:				StringPtr;
		movieID:				LONGINT;
		theMovie:				MoviePtr;
		theController:			MovieControllerPtr;
	END;

	QTGetExternalMoviePtr				= ^QTGetExternalMovieRecord;
	QTGetChapterTimeRecordPtr = ^QTGetChapterTimeRecord;
	QTGetChapterTimeRecord = RECORD
		chapterName:			StringPtr;
		chapterTime:			TimeRecord;
	END;

	QTGetChapterTimePtr					= ^QTGetChapterTimeRecord;
	QTChapterInfoRecordPtr = ^QTChapterInfoRecord;
	QTChapterInfoRecord = RECORD
		index:					LONGINT;								{  first chapter has index of 1 }
		time:					TimeValue;								{  -1 if no more chapters available }
		name:					Str255;
	END;

	QTChapterInfoPtr					= ^QTChapterInfoRecord;
	QTEvaluateExpressionRecordPtr = ^QTEvaluateExpressionRecord;
	QTEvaluateExpressionRecord = RECORD
		expressionSpec:			QTAtomSpec;
		expressionResult:		^Single;
	END;

	QTEvaluateExpressionPtr				= ^QTEvaluateExpressionRecord;
	QTEvaluateExpressionWithTypeRecordPtr = ^QTEvaluateExpressionWithTypeRecord;
	QTEvaluateExpressionWithTypeRecord = RECORD
		recordSize:				LONGINT;								{  Size of structure (fill in at allocation)  }
		expressionSpec:			QTAtomSpec;
		expressionResult:		^Single;
		fetchAsType:			LONGINT;
		nonNumericResult:		Handle;
																		{  Current size is 24  }
	END;

	QTEvaluateExpressionWithTypePtr		= ^QTEvaluateExpressionWithTypeRecord;
	QTFetchParameterAsRecordPtr = ^QTFetchParameterAsRecord;
	QTFetchParameterAsRecord = RECORD
		paramListSpec:			QTAtomSpec;
		paramIndex:				LONGINT;
		paramType:				LONGINT;
		allowedFlags:			LONGINT;
		min:					Ptr;
		max:					Ptr;
		currentValue:			Ptr;
		newValue:				Ptr;
		isUnsignedValue:		BOOLEAN;
	END;

	QTFetchParameterAsPtr				= ^QTFetchParameterAsRecord;
	QTGetCursorByIDRecordPtr = ^QTGetCursorByIDRecord;
	QTGetCursorByIDRecord = RECORD
		cursorID:				INTEGER;
		colorCursorData:		Handle;
		reserved1:				LONGINT;
	END;

	QTGetCursorByIDPtr					= ^QTGetCursorByIDRecord;
	QTDoScriptRecordPtr = ^QTDoScriptRecord;
	QTDoScriptRecord = RECORD
		scriptTypeFlags:		LONGINT;
		command:				CStringPtr;
		arguments:				CStringPtr;
	END;

	QTDoScriptPtr						= ^QTDoScriptRecord;
	QTRestartAtTimeRecordPtr = ^QTRestartAtTimeRecord;
	QTRestartAtTimeRecord = RECORD
		startTime:				TimeValue;								{  time scale is the movie timescale }
		rate:					Fixed;									{  if rate is zero, the movie's current rate is maintained }
	END;

	QTRestartAtTimePtr					= ^QTRestartAtTimeRecord;
	{  values for paramType field of QTFetchParameterAsRecord }

CONST
	kFetchAsBooleanPtr			= 1;
	kFetchAsShortPtr			= 2;
	kFetchAsLongPtr				= 3;
	kFetchAsMatrixRecordPtr		= 4;
	kFetchAsModifierTrackGraphicsModeRecord = 5;
	kFetchAsHandle				= 6;
	kFetchAsStr255				= 7;
	kFetchAsFloatPtr			= 8;
	kFetchAsPointPtr			= 9;
	kFetchAsNewAtomContainer	= 10;
	kFetchAsQTEventRecordPtr	= 11;
	kFetchAsFixedPtr			= 12;
	kFetchAsSetControllerValuePtr = 13;
	kFetchAsRgnHandle			= 14;							{  flipped to native }
	kFetchAsComponentDescriptionPtr = 15;
	kFetchAsCString				= 16;

	kQTCursorOpenHand			= -19183;
	kQTCursorClosedHand			= -19182;
	kQTCursorPointingHand		= -19181;
	kQTCursorRightArrow			= -19180;
	kQTCursorLeftArrow			= -19179;
	kQTCursorDownArrow			= -19178;
	kQTCursorUpArrow			= -19177;
	kQTCursorIBeam				= -19176;





	{	 target management 	}
	{
	 *  MCSetMovie()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 *    Windows:          in qtmlClient.lib 3.0 and later
	 	}
FUNCTION MCSetMovie(mc: MovieController; theMovie: Movie; movieWindow: WindowRef; where: Point): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0002, $7000, $A82A;
	{$ENDC}

{
 *  MCGetIndMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCGetIndMovie(mc: MovieController; index: INTEGER): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $0005, $7000, $A82A;
	{$ENDC}


{
 *  MCRemoveAllMovies()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCRemoveAllMovies(mc: MovieController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0006, $7000, $A82A;
	{$ENDC}

{
 *  MCRemoveAMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCRemoveAMovie(mc: MovieController; m: Movie): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}

{
 *  MCRemoveMovie()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCRemoveMovie(mc: MovieController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0006, $7000, $A82A;
	{$ENDC}

{ event handling etc. }
{
 *  MCIsPlayerEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCIsPlayerEvent(mc: MovieController; {CONST}VAR e: EventRecord): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}

{ obsolete. use MCSetActionFilterWithRefCon instead. }
{
 *  MCSetActionFilter()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCSetActionFilter(mc: MovieController; blob: MCActionFilterUPP): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0008, $7000, $A82A;
	{$ENDC}

{
    proc is of the form:
        Boolean userPlayerFilter(MovieController mc, short *action, void *params) =
    proc returns TRUE if it handles the action, FALSE if not
    action is passed as a VAR so that it could be changed by filter
    this is consistent with the current dialog manager stuff
    params is any potential parameters that go with the action
        such as set playback rate to xxx.
}
{
 *  MCDoAction()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCDoAction(mc: MovieController; action: INTEGER; params: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0009, $7000, $A82A;
	{$ENDC}

{ state type things }
{
 *  MCSetControllerAttached()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCSetControllerAttached(mc: MovieController; attach: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $000A, $7000, $A82A;
	{$ENDC}

{
 *  MCIsControllerAttached()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCIsControllerAttached(mc: MovieController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000B, $7000, $A82A;
	{$ENDC}

{
 *  MCSetControllerPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCSetControllerPort(mc: MovieController; gp: CGrafPtr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}

{
 *  MCGetControllerPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCGetControllerPort(mc: MovieController): CGrafPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000D, $7000, $A82A;
	{$ENDC}

{
 *  MCSetVisible()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCSetVisible(mc: MovieController; visible: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $000E, $7000, $A82A;
	{$ENDC}

{
 *  MCGetVisible()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCGetVisible(mc: MovieController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $000F, $7000, $A82A;
	{$ENDC}

{
 *  MCGetControllerBoundsRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCGetControllerBoundsRect(mc: MovieController; VAR bounds: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0010, $7000, $A82A;
	{$ENDC}

{
 *  MCSetControllerBoundsRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCSetControllerBoundsRect(mc: MovieController; {CONST}VAR bounds: Rect): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0011, $7000, $A82A;
	{$ENDC}

{
 *  MCGetControllerBoundsRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCGetControllerBoundsRgn(mc: MovieController): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0012, $7000, $A82A;
	{$ENDC}

{
 *  MCGetWindowRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCGetWindowRgn(mc: MovieController; w: WindowRef): RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0013, $7000, $A82A;
	{$ENDC}


{ other stuff }
{
 *  MCMovieChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCMovieChanged(mc: MovieController; m: Movie): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0014, $7000, $A82A;
	{$ENDC}


{
    called when the app has changed thing about the movie (like bounding rect) or rate. So that we
        can update our graphical (and internal) state accordingly.
}
{
 *  MCSetDuration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCSetDuration(mc: MovieController; duration: TimeValue): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0015, $7000, $A82A;
	{$ENDC}

{
    duration to use for time slider -- will be reset next time MCMovieChanged is called
        or MCSetMovie is called
}
{
 *  MCGetCurrentTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCGetCurrentTime(mc: MovieController; VAR scale: TimeScale): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0016, $7000, $A82A;
	{$ENDC}

{
    returns the time value and the time scale it is on. if there are no movies, the
        time scale is passed back as 0. scale is an optional parameter

}
{
 *  MCNewAttachedController()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCNewAttachedController(mc: MovieController; theMovie: Movie; w: WindowRef; where: Point): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0017, $7000, $A82A;
	{$ENDC}

{
    makes theMovie the only movie attached to the controller. makes the controller visible.
    the window and where parameters are passed a long to MCSetMovie and behave as
    described there
}
{
 *  MCDraw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCDraw(mc: MovieController; w: WindowRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0018, $7000, $A82A;
	{$ENDC}

{
 *  MCActivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCActivate(mc: MovieController; w: WindowRef; activate: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0019, $7000, $A82A;
	{$ENDC}

{
 *  MCIdle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCIdle(mc: MovieController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $001A, $7000, $A82A;
	{$ENDC}

{
 *  MCKey()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCKey(mc: MovieController; key: SInt8; modifiers: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $001B, $7000, $A82A;
	{$ENDC}

{
 *  MCClick()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCClick(mc: MovieController; w: WindowRef; where: Point; when: LONGINT; modifiers: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0010, $001C, $7000, $A82A;
	{$ENDC}


{
    calls for editing
}
{
 *  MCEnableEditing()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCEnableEditing(mc: MovieController; enabled: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0002, $001D, $7000, $A82A;
	{$ENDC}

{
 *  MCIsEditingEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCIsEditingEnabled(mc: MovieController): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $001E, $7000, $A82A;
	{$ENDC}

{
 *  MCCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCCopy(mc: MovieController): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $001F, $7000, $A82A;
	{$ENDC}

{
 *  MCCut()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCCut(mc: MovieController): Movie;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0020, $7000, $A82A;
	{$ENDC}

{
 *  MCPaste()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCPaste(mc: MovieController; srcMovie: Movie): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0021, $7000, $A82A;
	{$ENDC}

{
 *  MCClear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCClear(mc: MovieController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0022, $7000, $A82A;
	{$ENDC}

{
 *  MCUndo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCUndo(mc: MovieController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0023, $7000, $A82A;
	{$ENDC}


{
 *  somewhat special stuff
 }
{
 *  MCPositionController()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCPositionController(mc: MovieController; {CONST}VAR movieRect: Rect; {CONST}VAR controllerRect: Rect; someFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0024, $7000, $A82A;
	{$ENDC}


{
 *  MCGetControllerInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCGetControllerInfo(mc: MovieController; VAR someFlags: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0004, $0025, $7000, $A82A;
	{$ENDC}



{
 *  MCSetClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCSetClip(mc: MovieController; theClip: RgnHandle; movieClip: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0028, $7000, $A82A;
	{$ENDC}

{
 *  MCGetClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCGetClip(mc: MovieController; VAR theClip: RgnHandle; VAR movieClip: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0029, $7000, $A82A;
	{$ENDC}


{
 *  MCDrawBadge()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCDrawBadge(mc: MovieController; movieRgn: RgnHandle; VAR badgeRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002A, $7000, $A82A;
	{$ENDC}

{
 *  MCSetUpEditMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCSetUpEditMenu(mc: MovieController; modifiers: LONGINT; mh: MenuRef): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002B, $7000, $A82A;
	{$ENDC}

{
 *  MCGetMenuString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCGetMenuString(mc: MovieController; modifiers: LONGINT; item: INTEGER; VAR aString: Str255): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000A, $002C, $7000, $A82A;
	{$ENDC}

{
 *  MCSetActionFilterWithRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCSetActionFilterWithRefCon(mc: MovieController; blob: MCActionFilterWithRefConUPP; refCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002D, $7000, $A82A;
	{$ENDC}

{
 *  MCPtInController()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCPtInController(mc: MovieController; thePt: Point; VAR inController: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002E, $7000, $A82A;
	{$ENDC}

{
 *  MCInvalidate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCInvalidate(mc: MovieController; w: WindowRef; invalidRgn: RgnHandle): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $002F, $7000, $A82A;
	{$ENDC}

{
 *  MCAdjustCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCAdjustCursor(mc: MovieController; w: WindowRef; where: Point; modifiers: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $000C, $0030, $7000, $A82A;
	{$ENDC}

{
 *  MCGetInterfaceElement()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MCGetInterfaceElement(mc: MovieController; whichElement: MCInterfaceElement; element: UNIV Ptr): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0031, $7000, $A82A;
	{$ENDC}

{
 *  MCGetDoActionsProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 4.0 and later
 }
FUNCTION MCGetDoActionsProc(mc: MovieController; VAR doMCActionProc: DoMCActionUPP; VAR doMCActionRefCon: LONGINT): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0032, $7000, $A82A;
	{$ENDC}

{
 *  MCAddMovieSegment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION MCAddMovieSegment(mc: MovieController; srcMovie: Movie; scaled: BOOLEAN): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0006, $0033, $7000, $A82A;
	{$ENDC}

{
 *  MCTrimMovieSegment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 5.0 and later
 }
FUNCTION MCTrimMovieSegment(mc: MovieController): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0000, $0034, $7000, $A82A;
	{$ENDC}





{***************************************
*                                       *
*       T  I  M  E  B  A  S  E          *
*                                       *
***************************************}
{
 *  NewTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewTimeBase: TimeBase;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00A5, $AAAA;
	{$ENDC}

{
 *  DisposeTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE DisposeTimeBase(tb: TimeBase);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B6, $AAAA;
	{$ENDC}

{
 *  GetTimeBaseTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTimeBaseTime(tb: TimeBase; s: TimeScale; VAR tr: TimeRecord): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00A6, $AAAA;
	{$ENDC}

{
 *  SetTimeBaseTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTimeBaseTime(tb: TimeBase; {CONST}VAR tr: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00A7, $AAAA;
	{$ENDC}

{
 *  SetTimeBaseValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTimeBaseValue(tb: TimeBase; t: TimeValue; s: TimeScale);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00A8, $AAAA;
	{$ENDC}

{
 *  GetTimeBaseRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTimeBaseRate(tb: TimeBase): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00A9, $AAAA;
	{$ENDC}

{
 *  SetTimeBaseRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTimeBaseRate(tb: TimeBase; r: Fixed);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00AA, $AAAA;
	{$ENDC}

{
 *  GetTimeBaseStartTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTimeBaseStartTime(tb: TimeBase; s: TimeScale; VAR tr: TimeRecord): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00AB, $AAAA;
	{$ENDC}

{
 *  SetTimeBaseStartTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTimeBaseStartTime(tb: TimeBase; {CONST}VAR tr: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00AC, $AAAA;
	{$ENDC}

{
 *  GetTimeBaseStopTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTimeBaseStopTime(tb: TimeBase; s: TimeScale; VAR tr: TimeRecord): TimeValue;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00AD, $AAAA;
	{$ENDC}

{
 *  SetTimeBaseStopTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTimeBaseStopTime(tb: TimeBase; {CONST}VAR tr: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00AE, $AAAA;
	{$ENDC}

{
 *  GetTimeBaseFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTimeBaseFlags(tb: TimeBase): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B1, $AAAA;
	{$ENDC}

{
 *  SetTimeBaseFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTimeBaseFlags(tb: TimeBase; timeBaseFlags: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B2, $AAAA;
	{$ENDC}

{
 *  SetTimeBaseMasterTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTimeBaseMasterTimeBase(slave: TimeBase; master: TimeBase; {CONST}VAR slaveZero: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B4, $AAAA;
	{$ENDC}

{
 *  GetTimeBaseMasterTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTimeBaseMasterTimeBase(tb: TimeBase): TimeBase;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00AF, $AAAA;
	{$ENDC}

{
 *  SetTimeBaseMasterClock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTimeBaseMasterClock(slave: TimeBase; clockMeister: Component; {CONST}VAR slaveZero: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B3, $AAAA;
	{$ENDC}

{
 *  GetTimeBaseMasterClock()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTimeBaseMasterClock(tb: TimeBase): ComponentInstance;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B0, $AAAA;
	{$ENDC}

{
 *  ConvertTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE ConvertTime(VAR theTime: TimeRecord; newBase: TimeBase);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B5, $AAAA;
	{$ENDC}

{
 *  ConvertTimeScale()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE ConvertTimeScale(VAR theTime: TimeRecord; newScale: TimeScale);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B7, $AAAA;
	{$ENDC}

{
 *  AddTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE AddTime(VAR dst: TimeRecord; {CONST}VAR src: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $010C, $AAAA;
	{$ENDC}

{
 *  SubtractTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SubtractTime(VAR dst: TimeRecord; {CONST}VAR src: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $010D, $AAAA;
	{$ENDC}

{
 *  GetTimeBaseStatus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTimeBaseStatus(tb: TimeBase; VAR unpinnedTime: TimeRecord): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $010B, $AAAA;
	{$ENDC}

{
 *  SetTimeBaseZero()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE SetTimeBaseZero(tb: TimeBase; VAR zero: TimeRecord);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0128, $AAAA;
	{$ENDC}

{
 *  GetTimeBaseEffectiveRate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetTimeBaseEffectiveRate(tb: TimeBase): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0124, $AAAA;
	{$ENDC}


{***************************************
*                                       *
*       C  A  L  L  B  A  C  K          *
*                                       *
***************************************}
{
 *  NewCallBack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION NewCallBack(tb: TimeBase; cbType: INTEGER): QTCallBack;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00EB, $AAAA;
	{$ENDC}

{
 *  DisposeCallBack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE DisposeCallBack(cb: QTCallBack);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00EC, $AAAA;
	{$ENDC}

{
 *  GetCallBackType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetCallBackType(cb: QTCallBack): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00ED, $AAAA;
	{$ENDC}

{
 *  GetCallBackTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetCallBackTimeBase(cb: QTCallBack): TimeBase;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00EE, $AAAA;
	{$ENDC}

{
 *  CallMeWhen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION CallMeWhen(cb: QTCallBack; callBackProc: QTCallBackUPP; refCon: LONGINT; param1: LONGINT; param2: LONGINT; param3: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B8, $AAAA;
	{$ENDC}

{
 *  CancelCallBack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE CancelCallBack(cb: QTCallBack);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $00B9, $AAAA;
	{$ENDC}


{***************************************
*                                       *
*       C L O C K   C A L L B A C K     *
*             S U P P O R T             *
*                                       *
***************************************}
{
 *  AddCallBackToTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION AddCallBackToTimeBase(cb: QTCallBack): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0129, $AAAA;
	{$ENDC}

{
 *  RemoveCallBackFromTimeBase()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION RemoveCallBackFromTimeBase(cb: QTCallBack): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $012A, $AAAA;
	{$ENDC}

{
 *  GetFirstCallBack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetFirstCallBack(tb: TimeBase): QTCallBack;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $012B, $AAAA;
	{$ENDC}

{
 *  GetNextCallBack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION GetNextCallBack(cb: QTCallBack): QTCallBack;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $012C, $AAAA;
	{$ENDC}

{
 *  ExecuteCallBack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
PROCEDURE ExecuteCallBack(cb: QTCallBack);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $012D, $AAAA;
	{$ENDC}





{
 *  MusicMediaGetIndexedTunePlayer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 *    Windows:          in qtmlClient.lib 3.0 and later
 }
FUNCTION MusicMediaGetIndexedTunePlayer(ti: ComponentInstance; sampleDescIndex: LONGINT; VAR tp: ComponentInstance): ComponentResult;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $0008, $0101, $7000, $A82A;
	{$ENDC}


{ UPP call backs }

CONST
	uppMovieRgnCoverProcInfo = $00000FE0;
	uppMovieProgressProcInfo = $0000FAE0;
	uppMovieDrawingCompleteProcInfo = $000003E0;
	uppTrackTransferProcInfo = $000003E0;
	uppGetMovieProcInfo = $00003FE0;
	uppMoviePreviewCallOutProcInfo = $000000D0;
	uppTextMediaProcInfo = $00003FE0;
	uppActionsProcInfo = $00003FE0;
	uppDoMCActionProcInfo = $00003EE0;
	uppMovieExecuteWiredActionsProcInfo = $00003FE0;
	uppMoviePrePrerollCompleteProcInfo = $00000EC0;
	uppMoviesErrorProcInfo = $00000380;
	uppQTCallBackProcInfo = $000003C0;
	uppQTSyncTaskProcInfo = $000000C0;
	uppTweenerDataProcInfo = $003FFFF0;
	uppQTBandwidthNotificationProcInfo = $00000FE0;
	uppMCActionFilterProcInfo = $00000FD0;
	uppMCActionFilterWithRefConProcInfo = $00003ED0;
	{
	 *  NewMovieRgnCoverUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewMovieRgnCoverUPP(userRoutine: MovieRgnCoverProcPtr): MovieRgnCoverUPP; { old name was NewMovieRgnCoverProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMovieProgressUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewMovieProgressUPP(userRoutine: MovieProgressProcPtr): MovieProgressUPP; { old name was NewMovieProgressProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMovieDrawingCompleteUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewMovieDrawingCompleteUPP(userRoutine: MovieDrawingCompleteProcPtr): MovieDrawingCompleteUPP; { old name was NewMovieDrawingCompleteProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTrackTransferUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewTrackTransferUPP(userRoutine: TrackTransferProcPtr): TrackTransferUPP; { old name was NewTrackTransferProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewGetMovieUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewGetMovieUPP(userRoutine: GetMovieProcPtr): GetMovieUPP; { old name was NewGetMovieProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMoviePreviewCallOutUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewMoviePreviewCallOutUPP(userRoutine: MoviePreviewCallOutProcPtr): MoviePreviewCallOutUPP; { old name was NewMoviePreviewCallOutProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTextMediaUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewTextMediaUPP(userRoutine: TextMediaProcPtr): TextMediaUPP; { old name was NewTextMediaProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewActionsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewActionsUPP(userRoutine: ActionsProcPtr): ActionsUPP; { old name was NewActionsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDoMCActionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDoMCActionUPP(userRoutine: DoMCActionProcPtr): DoMCActionUPP; { old name was NewDoMCActionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMovieExecuteWiredActionsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewMovieExecuteWiredActionsUPP(userRoutine: MovieExecuteWiredActionsProcPtr): MovieExecuteWiredActionsUPP; { old name was NewMovieExecuteWiredActionsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMoviePrePrerollCompleteUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewMoviePrePrerollCompleteUPP(userRoutine: MoviePrePrerollCompleteProcPtr): MoviePrePrerollCompleteUPP; { old name was NewMoviePrePrerollCompleteProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMoviesErrorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewMoviesErrorUPP(userRoutine: MoviesErrorProcPtr): MoviesErrorUPP; { old name was NewMoviesErrorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQTCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQTCallBackUPP(userRoutine: QTCallBackProcPtr): QTCallBackUPP; { old name was NewQTCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQTSyncTaskUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQTSyncTaskUPP(userRoutine: QTSyncTaskProcPtr): QTSyncTaskUPP; { old name was NewQTSyncTaskProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewTweenerDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewTweenerDataUPP(userRoutine: TweenerDataProcPtr): TweenerDataUPP; { old name was NewTweenerDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQTBandwidthNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQTBandwidthNotificationUPP(userRoutine: QTBandwidthNotificationProcPtr): QTBandwidthNotificationUPP; { old name was NewQTBandwidthNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMCActionFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewMCActionFilterUPP(userRoutine: MCActionFilterProcPtr): MCActionFilterUPP; { old name was NewMCActionFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMCActionFilterWithRefConUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewMCActionFilterWithRefConUPP(userRoutine: MCActionFilterWithRefConProcPtr): MCActionFilterWithRefConUPP; { old name was NewMCActionFilterWithRefConProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeMovieRgnCoverUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMovieRgnCoverUPP(userUPP: MovieRgnCoverUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMovieProgressUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMovieProgressUPP(userUPP: MovieProgressUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMovieDrawingCompleteUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMovieDrawingCompleteUPP(userUPP: MovieDrawingCompleteUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTrackTransferUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeTrackTransferUPP(userUPP: TrackTransferUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeGetMovieUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeGetMovieUPP(userUPP: GetMovieUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMoviePreviewCallOutUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMoviePreviewCallOutUPP(userUPP: MoviePreviewCallOutUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTextMediaUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeTextMediaUPP(userUPP: TextMediaUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeActionsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeActionsUPP(userUPP: ActionsUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDoMCActionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDoMCActionUPP(userUPP: DoMCActionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMovieExecuteWiredActionsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMovieExecuteWiredActionsUPP(userUPP: MovieExecuteWiredActionsUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMoviePrePrerollCompleteUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMoviePrePrerollCompleteUPP(userUPP: MoviePrePrerollCompleteUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMoviesErrorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMoviesErrorUPP(userUPP: MoviesErrorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQTCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQTCallBackUPP(userUPP: QTCallBackUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQTSyncTaskUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQTSyncTaskUPP(userUPP: QTSyncTaskUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeTweenerDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeTweenerDataUPP(userUPP: TweenerDataUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQTBandwidthNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQTBandwidthNotificationUPP(userUPP: QTBandwidthNotificationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMCActionFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMCActionFilterUPP(userUPP: MCActionFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMCActionFilterWithRefConUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMCActionFilterWithRefConUPP(userUPP: MCActionFilterWithRefConUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeMovieRgnCoverUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeMovieRgnCoverUPP(theMovie: Movie; changedRgn: RgnHandle; refcon: LONGINT; userRoutine: MovieRgnCoverUPP): OSErr; { old name was CallMovieRgnCoverProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMovieProgressUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeMovieProgressUPP(theMovie: Movie; message: INTEGER; whatOperation: INTEGER; percentDone: Fixed; refcon: LONGINT; userRoutine: MovieProgressUPP): OSErr; { old name was CallMovieProgressProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMovieDrawingCompleteUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeMovieDrawingCompleteUPP(theMovie: Movie; refCon: LONGINT; userRoutine: MovieDrawingCompleteUPP): OSErr; { old name was CallMovieDrawingCompleteProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTrackTransferUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeTrackTransferUPP(t: Track; refCon: LONGINT; userRoutine: TrackTransferUPP): OSErr; { old name was CallTrackTransferProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeGetMovieUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeGetMovieUPP(offset: LONGINT; size: LONGINT; dataPtr: UNIV Ptr; refCon: UNIV Ptr; userRoutine: GetMovieUPP): OSErr; { old name was CallGetMovieProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMoviePreviewCallOutUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeMoviePreviewCallOutUPP(refcon: LONGINT; userRoutine: MoviePreviewCallOutUPP): BOOLEAN; { old name was CallMoviePreviewCallOutProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTextMediaUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeTextMediaUPP(theText: Handle; theMovie: Movie; VAR displayFlag: INTEGER; refcon: LONGINT; userRoutine: TextMediaUPP): OSErr; { old name was CallTextMediaProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeActionsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeActionsUPP(refcon: UNIV Ptr; targetTrack: Track; targetRefCon: LONGINT; theEvent: QTEventRecordPtr; userRoutine: ActionsUPP): OSErr; { old name was CallActionsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDoMCActionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeDoMCActionUPP(refcon: UNIV Ptr; action: INTEGER; params: UNIV Ptr; VAR handled: BOOLEAN; userRoutine: DoMCActionUPP): OSErr; { old name was CallDoMCActionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMovieExecuteWiredActionsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeMovieExecuteWiredActionsUPP(theMovie: Movie; refcon: UNIV Ptr; flags: LONGINT; wiredActions: QTAtomContainer; userRoutine: MovieExecuteWiredActionsUPP): OSErr; { old name was CallMovieExecuteWiredActionsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMoviePrePrerollCompleteUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeMoviePrePrerollCompleteUPP(theMovie: Movie; prerollErr: OSErr; refcon: UNIV Ptr; userRoutine: MoviePrePrerollCompleteUPP); { old name was CallMoviePrePrerollCompleteProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMoviesErrorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeMoviesErrorUPP(theErr: OSErr; refcon: LONGINT; userRoutine: MoviesErrorUPP); { old name was CallMoviesErrorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQTCallBackUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQTCallBackUPP(cb: QTCallBack; refCon: LONGINT; userRoutine: QTCallBackUPP); { old name was CallQTCallBackProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQTSyncTaskUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQTSyncTaskUPP(task: UNIV Ptr; userRoutine: QTSyncTaskUPP); { old name was CallQTSyncTaskProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeTweenerDataUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeTweenerDataUPP(tr: TweenRecordPtr; tweenData: UNIV Ptr; tweenDataSize: LONGINT; dataDescriptionSeed: LONGINT; dataDescription: Handle; asyncCompletionProc: ICMCompletionProcRecordPtr; transferProc: UniversalProcPtr; refCon: UNIV Ptr; userRoutine: TweenerDataUPP): ComponentResult; { old name was CallTweenerDataProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQTBandwidthNotificationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeQTBandwidthNotificationUPP(flags: LONGINT; reserved: UNIV Ptr; refcon: UNIV Ptr; userRoutine: QTBandwidthNotificationUPP): OSErr; { old name was CallQTBandwidthNotificationProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMCActionFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeMCActionFilterUPP(mc: MovieController; VAR action: INTEGER; params: UNIV Ptr; userRoutine: MCActionFilterUPP): BOOLEAN; { old name was CallMCActionFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMCActionFilterWithRefConUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeMCActionFilterWithRefConUPP(mc: MovieController; action: INTEGER; params: UNIV Ptr; refCon: LONGINT; userRoutine: MCActionFilterWithRefConUPP): BOOLEAN; { old name was CallMCActionFilterWithRefConProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MoviesIncludes}

{$ENDC} {__MOVIES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

{
 	File:		MoviesFormat.p
 
 	Contains:	QuickTime Interfaces.
 
 	Version:	Technology:	QuickTime 2.5
 				Release:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MoviesFormat;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MOVIESFORMAT__}
{$SETC __MOVIESFORMAT__ := 1}

{$I+}
{$SETC MoviesFormatIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
{$ENDC}
{$IFC UNDEFINED __IMAGECOMPRESSION__}
{$I ImageCompression.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kMovieVersion				= 0;							{  version number of the format here described  }

{
***************************************
*
*   General Types -
*		These types are used in more than one of the
*		directory types.
*
***************************************
}
{  MoviesUserData is the type used for user data in movie and track directories  }

TYPE
	MoviesUserDataPtr = ^MoviesUserData;
	MoviesUserData = RECORD
		size:					LONGINT;								{  size of this user data  }
		udType:					LONGINT;								{  type of user data  }
		data:					SInt8;									{  the user data  }
	END;

	UserDataAtomPtr = ^UserDataAtom;
	UserDataAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;
		userData:				ARRAY [0..0] OF MoviesUserData;
	END;

{
 MoviesDataDescription tells us where the data for the movie or track lives.
   The data can follow the directory, be in the datafork of the same file as the directory resource,
   be in the resource fork of the same file as the directory resource, be in another file in the
   data fork or resource fork, or require a specific bottleneck to fetch the data. 
}
{
***************************************
*
*   MediaDirectory information -
*		The MediaDirectory is tightly coupled to the data.
*
***************************************
}
	SampleDescriptionAtomPtr = ^SampleDescriptionAtom;
	SampleDescriptionAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'stsd'  }
		flags:					LONGINT;								{  1 byte of version / 3 bytes of flags  }
		numEntries:				LONGINT;
		sampleDescTable:		ARRAY [0..0] OF SampleDescription;
	END;

{  TimeToSampleNum maps physical sample time to physical sample number.  }
	TimeToSampleNumPtr = ^TimeToSampleNum;
	TimeToSampleNum = RECORD
		sampleCount:			LONGINT;
		sampleDuration:			TimeValue;
	END;

	TimeToSampleNumAtomPtr = ^TimeToSampleNumAtom;
	TimeToSampleNumAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'stts'  }
		flags:					LONGINT;								{  1 byte of version / 3 bytes of flags  }
		numEntries:				LONGINT;
		timeToSampleNumTable:	ARRAY [0..0] OF TimeToSampleNum;
	END;

{  SyncSamples is a list of the physical samples which are self contained.  }
	SyncSampleAtomPtr = ^SyncSampleAtom;
	SyncSampleAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'stss'  }
		flags:					LONGINT;								{  1 byte of version / 3 bytes of flags  }
		numEntries:				LONGINT;
		syncSampleTable:		ARRAY [0..0] OF LONGINT;
	END;

{  SampleToChunk maps physical sample number to chunk number.  }
{  same as SampleToChunk, but redundant first sample is removed  }
	SampleToChunkPtr = ^SampleToChunk;
	SampleToChunk = RECORD
		firstChunk:				LONGINT;
		samplesPerChunk:		LONGINT;
		sampleDescriptionID:	LONGINT;
	END;

	SampleToChunkAtomPtr = ^SampleToChunkAtom;
	SampleToChunkAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'stsc'  }
		flags:					LONGINT;								{  1 byte of version / 3 bytes of flags  }
		numEntries:				LONGINT;
		sampleToChunkTable:		ARRAY [0..0] OF SampleToChunk;
	END;

	ChunkOffsetAtomPtr = ^ChunkOffsetAtom;
	ChunkOffsetAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'stco'  }
		flags:					LONGINT;								{  1 byte of version / 3 bytes of flags  }
		numEntries:				LONGINT;
		chunkOffsetTable:		ARRAY [0..0] OF LONGINT;
	END;

	SampleSizeAtomPtr = ^SampleSizeAtom;
	SampleSizeAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'stsz'  }
		flags:					LONGINT;								{  1 byte of version / 3 bytes of flags  }
		sampleSize:				LONGINT;
		numEntries:				LONGINT;
		sampleSizeTable:		ARRAY [0..0] OF LONGINT;
	END;

	ShadowSyncPtr = ^ShadowSync;
	ShadowSync = RECORD
		fdSampleNum:			LONGINT;
		syncSampleNum:			LONGINT;
	END;

	ShadowSyncAtomPtr = ^ShadowSyncAtom;
	ShadowSyncAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'stsz'  }
		flags:					LONGINT;								{  1 byte of version / 3 bytes of flags  }
		numEntries:				LONGINT;
		shadowSyncTable:		ARRAY [0..0] OF ShadowSync;
	END;

	SampleTableAtomPtr = ^SampleTableAtom;
	SampleTableAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'stbl'  }
		sampleDescription:		SampleDescriptionAtom;
		timeToSampleNum:		TimeToSampleNumAtom;
		sampleToChunk:			SampleToChunkAtom;
		syncSample:				SyncSampleAtom;
		sampleSize:				SampleSizeAtom;
		chunkOffset:			ChunkOffsetAtom;
		shadowSync:				ShadowSyncAtom;
	END;

	PublicHandlerInfoPtr = ^PublicHandlerInfo;
	PublicHandlerInfo = RECORD
		flags:					LONGINT;								{  1 byte of version / 3 bytes of flags  }
		componentType:			LONGINT;
		componentSubType:		LONGINT;
		componentManufacturer:	LONGINT;
		componentFlags:			LONGINT;
		componentFlagsMask:		LONGINT;
		componentName:			SInt8;
	END;

	HandlerAtomPtr = ^HandlerAtom;
	HandlerAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'hdlr'  }
		hInfo:					PublicHandlerInfo;
	END;

{  a data reference is a private structure  }
	DataRefAtom							= LONGINT;
	DataInfoAtomPtr = ^DataInfoAtom;
	DataInfoAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'dinf'  }
		dataRef:				DataRefAtom;
	END;

	RgnAtomPtr = ^RgnAtom;
	RgnAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;
		rgnSize:				INTEGER;
		rgnBBox:				Rect;
		data:					SInt8;
	END;

	MatteCompressedAtomPtr = ^MatteCompressedAtom;
	MatteCompressedAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;
		flags:					LONGINT;								{  1 byte of version / 3 bytes of flags  }
		matteImageDescription:	ImageDescription;
		matteData:				SInt8;
	END;

	MatteAtomPtr = ^MatteAtom;
	MatteAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;
		aCompressedMatte:		MatteCompressedAtom;
	END;

	ClippingAtomPtr = ^ClippingAtom;
	ClippingAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;
		aRgnClip:				RgnAtom;
	END;

{
**********************
* Media Info Example Structures
**********************
}
	VideoMediaInfoHeaderPtr = ^VideoMediaInfoHeader;
	VideoMediaInfoHeader = RECORD
		flags:					LONGINT;								{  1 byte of version / 3 bytes of flags  }
		graphicsMode:			INTEGER;								{  for QD - transfer mode  }
		opColorRed:				INTEGER;								{  opcolor for transfer mode  }
		opColorGreen:			INTEGER;
		opColorBlue:			INTEGER;
	END;

	VideoMediaInfoHeaderAtomPtr = ^VideoMediaInfoHeaderAtom;
	VideoMediaInfoHeaderAtom = RECORD
		size:					LONGINT;								{  size of Media info  }
		atomType:				LONGINT;								{  = 'vmhd'  }
		vmiHeader:				VideoMediaInfoHeader;
	END;

	VideoMediaInfoPtr = ^VideoMediaInfo;
	VideoMediaInfo = RECORD
		size:					LONGINT;								{  size of Media info  }
		atomType:				LONGINT;								{  = 'minf'  }
		header:					VideoMediaInfoHeaderAtom;
		dataHandler:			HandlerAtom;
		dataInfo:				DataInfoAtom;
		sampleTable:			SampleTableAtom;
	END;

	SoundMediaInfoHeaderPtr = ^SoundMediaInfoHeader;
	SoundMediaInfoHeader = RECORD
		flags:					LONGINT;								{  1 byte of version / 3 bytes of flags  }
		balance:				INTEGER;
		rsrvd:					INTEGER;
	END;

	SoundMediaInfoHeaderAtomPtr = ^SoundMediaInfoHeaderAtom;
	SoundMediaInfoHeaderAtom = RECORD
		size:					LONGINT;								{  size of Media info  }
		atomType:				LONGINT;								{  = 'vmhd'  }
		smiHeader:				SoundMediaInfoHeader;
	END;

	SoundMediaInfoPtr = ^SoundMediaInfo;
	SoundMediaInfo = RECORD
		size:					LONGINT;								{  size of Media info  }
		atomType:				LONGINT;								{  = 'minf'  }
		header:					SoundMediaInfoHeaderAtom;
		dataHandler:			HandlerAtom;
		dataReference:			DataRefAtom;
		sampleTable:			SampleTableAtom;
	END;

{  whatever data the media handler needs goes after the atomType  }
	MediaInfoPtr = ^MediaInfo;
	MediaInfo = RECORD
		size:					LONGINT;
		atomType:				LONGINT;
	END;

{
**********************
* Media Directory Structures
**********************
}
	MediaHeaderPtr = ^MediaHeader;
	MediaHeader = RECORD
		flags:					LONGINT;								{  1 byte of version / 3 bytes of flags  }
		creationTime:			LONGINT;								{  seconds since Jan 1904 when directory was created  }
		modificationTime:		LONGINT;								{  seconds since Jan 1904 when directory was appended  }
		timeScale:				TimeValue;								{  start time for Media (Media time)  }
		duration:				TimeValue;								{  length of Media (Media time)  }
		language:				INTEGER;
		quality:				INTEGER;
	END;

	MediaHeaderAtomPtr = ^MediaHeaderAtom;
	MediaHeaderAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;
		header:					MediaHeader;
	END;

	MediaDirectoryPtr = ^MediaDirectory;
	MediaDirectory = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'mdia'  }
		mediaHeader:			MediaHeaderAtom;						{  standard Media information  }
		mediaHandler:			HandlerAtom;
		mediaInfo:				MediaInfo;
	END;

{
**********************
* Track Structures
**********************
}

CONST
	TrackEnable					= $01;
	TrackInMovie				= $02;
	TrackInPreview				= $04;
	TrackInPoster				= $08;


TYPE
	TrackHeaderPtr = ^TrackHeader;
	TrackHeader = RECORD
		flags:					LONGINT;								{  1 byte of version / 3 bytes of flags  }
		creationTime:			LONGINT;								{  seconds since Jan 1904 when directory was created  }
		modificationTime:		LONGINT;								{  seconds since Jan 1904 when directory was appended  }
		trackID:				LONGINT;
		reserved1:				LONGINT;
		duration:				TimeValue;								{  length of track (track time)  }
		reserved2:				LONGINT;
		reserved3:				LONGINT;
		layer:					INTEGER;
		alternateGroup:			INTEGER;
		volume:					INTEGER;
		reserved4:				INTEGER;
		matrix:					MatrixRecord;
		trackWidth:				Fixed;
		trackHeight:			Fixed;
	END;

	TrackHeaderAtomPtr = ^TrackHeaderAtom;
	TrackHeaderAtom = RECORD
		size:					LONGINT;								{  size of track header  }
		atomType:				LONGINT;								{  = 'tkhd'  }
		header:					TrackHeader;
	END;

	EditListTypePtr = ^EditListType;
	EditListType = RECORD
		trackDuration:			TimeValue;
		mediaTime:				TimeValue;
		mediaRate:				Fixed;
	END;

	EditListAtomPtr = ^EditListAtom;
	EditListAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = elst  }
		flags:					LONGINT;								{  1 byte of version / 3 bytes of flags  }
		numEntries:				LONGINT;
		editListTable:			ARRAY [0..0] OF EditListType;
	END;

	EditsAtomPtr = ^EditsAtom;
	EditsAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = edts  }
		editList:				EditListAtom;
	END;

	TrackLoadSettingsPtr = ^TrackLoadSettings;
	TrackLoadSettings = RECORD
		preloadStartTime:		TimeValue;
		preloadDuration:		TimeValue;
		preloadFlags:			LONGINT;
		defaultHints:			LONGINT;
	END;

	TrackLoadSettingsAtomPtr = ^TrackLoadSettingsAtom;
	TrackLoadSettingsAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = load  }
		settings:				TrackLoadSettings;
	END;

	TrackDirectoryPtr = ^TrackDirectory;
	TrackDirectory = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'trak'  }
		trackHeader:			TrackHeaderAtom;						{  standard track information  }
		trackClip:				ClippingAtom;
		edits:					EditsAtom;
		media:					MediaDirectory;
		userData:				UserDataAtom;							{  space for extending with new data types  }
	END;

{
***************************************
*
*   MovieDirectory -
*		The MovieDirectory is the top level structure which
*		holds the TrackInstance describing where the
*		TrackDirectories are.
*
***************************************
}
	MovieHeaderPtr = ^MovieHeader;
	MovieHeader = RECORD
		flags:					LONGINT;								{  1 byte of version / 3 bytes of flags  }
		creationTime:			LONGINT;								{  seconds since Jan 1904 when directory was created  }
		modificationTime:		LONGINT;								{  seconds since Jan 1904 when directory was appended  }
		timeScale:				TimeValue;								{  Time specifications  }
		duration:				TimeValue;
		preferredRate:			Fixed;									{  rate at which to play this movie  }
		preferredVolume:		INTEGER;								{  volume to play movie at  }
		reserved1:				INTEGER;
		preferredLong1:			LONGINT;
		preferredLong2:			LONGINT;
		matrix:					MatrixRecord;
		previewTime:			TimeValue;								{  time in track the proxy begins (track time)  }
		previewDuration:		TimeValue;								{  how long the proxy lasts (track time)  }
		posterTime:				TimeValue;								{  time in track the proxy begins (track time)  }
		selectionTime:			TimeValue;								{  time in track the proxy begins (track time)  }
		selectionDuration:		TimeValue;								{  time in track the proxy begins (track time)  }
		currentTime:			TimeValue;								{  time in track the proxy begins (track time)  }
		nextTrackID:			LONGINT;								{  next value to use for a TrackID  }
	END;

	MovieHeaderAtomPtr = ^MovieHeaderAtom;
	MovieHeaderAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'mvhd'  }
		header:					MovieHeader;
	END;

	TrackDirectoryEntryPtr = ^TrackDirectoryEntry;
	TrackDirectoryEntry = RECORD
		trackDirectory:			TrackDirectory;							{  Track directory information  }
	END;

	MovieDirectoryPtr = ^MovieDirectory;
	MovieDirectory = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'moov'  }
		header:					MovieHeaderAtom;
		movieClip:				ClippingAtom;
																		{  Track Directories  }
		track:					ARRAY [0..0] OF TrackDirectoryEntry;	{  Track directory information  }
																		{  User data for Movie  }
		userData:				UserDataAtom;							{  space for user extensions  }
	END;

{
***************************************
***************************************
}
{  Movie formats and tags  }

CONST
																{  some system defined format IDs  }
	MOVIE_TYPE					= 'moov';
	TRACK_TYPE					= 'trak';
	MEDIA_TYPE					= 'mdia';
	VIDEO_TYPE					= 'vide';
	SOUND_TYPE					= 'soun';

{  atom id's  }
	MovieAID					= 'moov';
	MovieHeaderAID				= 'mvhd';
	ClipAID						= 'clip';
	RgnClipAID					= 'crgn';
	MatteAID					= 'matt';
	MatteCompAID				= 'kmat';
	TrackAID					= 'trak';
	UserDataAID					= 'udta';
	TrackHeaderAID				= 'tkhd';
	EditsAID					= 'edts';
	EditListAID					= 'elst';
	MediaAID					= 'mdia';
	MediaHeaderAID				= 'mdhd';
	MediaInfoAID				= 'minf';
	VideoMediaInfoHeaderAID		= 'vmhd';
	SoundMediaInfoHeaderAID		= 'smhd';
	GenericMediaInfoHeaderAID	= 'gmhd';
	GenericMediaInfoAID			= 'gmin';
	DataInfoAID					= 'dinf';
	DataRefAID					= 'dref';
	SampleTableAID				= 'stbl';
	STSampleDescAID				= 'stsd';
	STTimeToSampAID				= 'stts';
	STSyncSampleAID				= 'stss';
	STSampleToChunkAID			= 'stsc';
	STShadowSyncAID				= 'stsh';
	HandlerAID					= 'hdlr';
	STSampleSizeAID				= 'stsz';
	STChunkOffsetAID			= 'stco';
	STChunkOffset64AID			= 'co64';
	DataRefContainerAID			= 'drfc';
	TrackReferenceAID			= 'tref';
	ColorTableAID				= 'ctab';
	LoadSettingsAID				= 'load';
	PropertyAtomAID				= 'code';
	InputMapAID					= 'imap';
	MovieBufferHintsAID			= 'mbfh';
	MovieDataRefAliasAID		= 'mdra';
	SoundLocalizationAID		= 'sloc';

{  Text ATOM definitions }

TYPE
	TextBoxAtomPtr = ^TextBoxAtom;
	TextBoxAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'tbox'  }
		textBox:				Rect;									{  New text box (overrides defaultTextBox) }
	END;

	HiliteAtomPtr = ^HiliteAtom;
	HiliteAtom = RECORD
		size:					LONGINT;
		atomType:				LONGINT;								{  = 'hlit'  }
		selStart:				LONGINT;								{  hilite selection start character }
		selEnd:					LONGINT;								{  hilite selection end character }
	END;

	KaraokeRecPtr = ^KaraokeRec;
	KaraokeRec = RECORD
		timeVal:				TimeValue;
		beginHilite:			INTEGER;
		endHilite:				INTEGER;
	END;

	KaraokeAtomPtr = ^KaraokeAtom;
	KaraokeAtom = RECORD
		numEntries:				LONGINT;
		karaokeEntries:			ARRAY [0..0] OF KaraokeRec;
	END;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MoviesFormatIncludes}

{$ENDC} {__MOVIESFORMAT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

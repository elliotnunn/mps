
{************************************************************
Created: Monday, August 17, 1992 at 5:13 PM
 MoviesFormat.p
 Pascal Interface to the Macintosh Libraries


 Copyright Apple Computer, Inc. 1991, 1992
 All rights reserved

************************************************************}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MoviesFormat;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingMoviesFormat}
{$SETC UsingMoviesFormat := 1}

{$I+}
{$SETC MoviesFormatIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED UsingMovies}
{$I $$Shell(PInterfaces)Movies.p}
{$ENDC}
{$IFC UNDEFINED UsingImageCompression}
{$I $$Shell(PInterfaces)ImageCompression.p}
{$ENDC}
{$SETC UsingIncludes := MoviesFormatIncludes}

CONST
kMovieVersion = 0;				{ version number of the format here described }


{****************************************
*
*   General Types -
*		These types are used in more than one of the
*		directory types.
*
****************************************}

{ MoviesUserData is the type used for user data in movie and track directories }

TYPE

MoviesUserData = RECORD
	size	:	LONGINT;		 { size of this user data }
	udType	:	LONGINT;		 { type of user data  }
	data	:	PACKED ARRAY[0..0] OF Byte;		 { the user data } 
END;

UserDataAtom = RECORD
	size		:	LONGINT;	
	atomType	:	LONGINT; 
	userData	:	ARRAY[0..0] OF MoviesUserData;
END;


{ MoviesDataDescription tells us where the data for the movie or track lives.
   The data can follow the directory, be in the datafork of the same file as the directory resource,
   be in the resource fork of the same file as the directory resource, be in another file in the 
   data fork or resource fork, or require a specific bottleneck to fetch the data. }


{***************************************
*
*   MediaDirectory information -
*		The MediaDirectory is tightly coupled to the data.
*
***************************************}

{ The SampleDescriptionTable holds the SampleDescriptions needed to decompress chunks given the
   SampleDescriptionID. There is a table per Media. }

{
SampleDescription = RECORD
	size		:	LONGINT;
	dataFormat	:	LONGINT;
	resvd1		:	LONGINT;
	resvdA		:	INTEGER;
	dataRefId	:	INTEGER;
END;
SampleDescriptionHandle = ^^SampleDescription;
}

SampleDescriptionAtom = RECORD
	size			:	LONGINT;
	atomType		:	LONGINT;			{ = 'stsd' }
	flags			:	LONGINT;			{ 1 byte of version / 3 bytes of flags }
	numEntries		:	LONGINT;
	sampleDescTable	:	ARRAY[0..0] OF SampleDescription;
END;

{ TimeToSampleNum maps physical sample time to physical sample number. }

TimeToSampleNum = RECORD
	sampleCount 	:	LONGINT;
	sampleDuration	:	TimeValue;
END;

TimeToSampleNumAtom = RECORD
	size		:	LONGINT;
	atomType	:	LONGINT;			{ = 'stts' }
	flags		:	LONGINT;			{ 1 byte of version / 3 bytes of flags }
	numEntries	:	LONGINT;
	timeToSampleNumTable : ARRAY[0..0] OF TimeToSampleNum;
END;

{ SyncSamples is a list of the physical samples which are self contained. }

SyncSampleAtom = RECORD
	size			:	LONGINT;
	atomType		:	LONGINT;		{ = 'stss' }
	flags			:	LONGINT;		{ 1 byte of version / 3 bytes of flags }
	numEntries		:	LONGINT;
	syncSampleTable	:	ARRAY[0..0] OF LONGINT;
END;

SampleToChunk = RECORD
	firstChunk			:	LONGINT;
	samplesPerChunk		:	LONGINT;
	sampleDescriptionID	:	LONGINT;
END;

SampleToChunkAtom = RECORD
	size				:	LONGINT;		
	atomType			:	LONGINT;	{ = 'stsc' }
	flags				:	LONGINT;	{ 1 byte of version / 3 bytes of flags }
	numEntries			:	LONGINT;		
	sampleToChunkTable 	:	ARRAY[0..0] OF SampleToChunk;
END;

ChunkOffsetAtom = RECORD
	size				:	LONGINT;	
	atomType			:	LONGINT;				{ = 'stco' }
	flags				:	LONGINT;				{ 1 byte of version / 3 bytes of flags }
	numEntries			:	LONGINT;	
	chunkOffsetTable	:	ARRAY[0..0] OF LONGINT;
END;

SampleSizeAtom = RECORD
	size			:	LONGINT;		
	atomType		:	LONGINT;		{ = 'stsz' }
	flags			:	LONGINT;		{ 1 byte of version / 3 bytes of flags }
	sampleSize		:	LONGINT;		
	numEntries		:	LONGINT;		
	sampleSizeTable :	ARRAY[0..0] OF LONGINT;
END;

ShadowSync = RECORD
	fdSampleNum		:	LONGINT;
	syncSampleNum 	:	LONGINT;
END;

ShadowSyncAtom = RECORD
	size			:	LONGINT;
	atomType		:	LONGINT;
	flags			:	LONGINT;
	numEntries		:	LONGINT;
	shadowSyncTable	:	ARRAY[0..0] OF ShadowSync;
END;

SampleTableAtom = RECORD
	size				:	LONGINT;	
	atomType			:	LONGINT;		{ = 'stbl' }
	sampleDescription	:	SampleDescriptionAtom;
	timeToSampleNum		:	TimeToSampleNumAtom;
	sampleToChunk		:	SampleToChunkAtom;
	syncSample			:	SyncSampleAtom;
	sampleSize			:	SampleSizeAtom;
	chunkOffset			:	ChunkOffsetAtom;
	shadowSync			:	ShadowSyncAtom;
END;

PublicHandlerInfo = RECORD
	flags					:	LONGINT;	{ 1 byte of version / 3 bytes of flags }
	componentType			:	LONGINT;			
	componentSubType		:	LONGINT;				
	componentManufacturer	:	LONGINT;				
	componentFlags			:	LONGINT;				
	componentFlagsMask		:	LONGINT;				
	componentName			:	PACKED ARRAY[0..0] OF Byte;
END;
	
HandlerAtom = RECORD
	size		:	LONGINT;		
	atomType	:	LONGINT;		{ = 'hdlr' }
	hInfo		:	PublicHandlerInfo;	
END;
	
DataRefAtom = LONGINT;

DataInfoAtom = RECORD
	size		:	LONGINT;		
	atomType	:	LONGINT;			{ = 'dinf' }
	dataRef		:	DataRefAtom;
END;

RgnAtom = RECORD
	size		:	LONGINT;		
	atomType	:	LONGINT;		
	rgnSize		:	INTEGER;		{ this is the contents of a region }
	rgnBBox		:	Rect;
	data		:	ARRAY[0..0] OF Byte;
END;

MatteCompressedAtom = RECORD
	size		:	LONGINT;				
	atomType	:	LONGINT;				
	flags		:	LONGINT;			{ 1 byte of version / 3 bytes of flags }
	matteImageDescription 	: 	ImageDescription;
	matteData 				:	PACKED ARRAY[0..0] OF Byte;
END;

MatteAtom = RECORD
	size				:	LONGINT;				
	atomType			:	LONGINT;			
	aCompressedMatte	:	MatteCompressedAtom;
END;

ClippingAtom = RECORD
	size		:	LONGINT;	
	atomType	:	LONGINT;		
	aRgnClip	:	RgnAtom;
END;
	
{***********************
* Media Info Example Structures 
***********************}	

VideoMediaInfoHeader = RECORD
	flags			:	LONGINT;		{ 1 byte of version / 3 bytes of flags }
	graphicsMode	:	INTEGER;		{ for QD - transfer mode }
	opColorRed		:	INTEGER;		{ opcolor for transfer mode }
	opColorGreen	:	INTEGER;
	opColorBlue		:	INTEGER;
END;

VideoMediaInfoHeaderAtom = RECORD
	size		:	LONGINT;				{ size of Media info }
	atomType	:	LONGINT;				{ = 'vmhd' }
	vmiHeader	:	VideoMediaInfoHeader;
END;

VideoMediaInfo = RECORD
	size		:	LONGINT;			{ size of Media info }
	atomType	:	LONGINT;			{ = 'minf' }
	header		:	VideoMediaInfoHeaderAtom;
	dataHandler	:	HandlerAtom;
	dataInfo	:	DataInfoAtom;
	sampleTable	:	SampleTableAtom;
END;

SoundMediaInfoHeader = RECORD
	flags	:	LONGINT;			{ 1 byte of version / 3 bytes of flags }
	balance	:	INTEGER;				
	rsrvd	:	INTEGER;
END;

SoundMediaInfoHeaderAtom = RECORD
	size		:	LONGINT;			{ size of Media info }
	atomType	:	LONGINT;			{ = 'vmhd' }
	smiHeader	:	SoundMediaInfoHeader;	
END;

SoundMediaInfo = RECORD
	size			:	LONGINT;		{ size of Media info }
	atomType		:	LONGINT;		{ = 'minf' }
	header			:	SoundMediaInfoHeaderAtom;
	dataHandler		:	HandlerAtom;
	dataReference	:	DataRefAtom;
	sampleTable		:	SampleTableAtom;
END;

MediaInfo = RECORD
	size		:	LONGINT;	
	atomType	:	LONGINT;	
	{ whatever data the media handler needs goes here }
END;


{**********************
* Media Directory Structures 
**********************}	

MediaHeader = RECORD
	flags				:	LONGINT;	{ 1 byte of version / 3 bytes of flags }
	creationTime		:	LONGINT;	{ seconds since Jan 1904 when directory was created }
	modificationTime	:	LONGINT;	{ seconds since Jan 1904 when directory was appended }
	timeScale			:	TimeValue;	{ start time for Media (Media time) }
	duration			:	TimeValue;	{ length of Media (Media time) }
	language			:	INTEGER;
	quality				:	INTEGER;
END;

MediaHeaderAtom = RECORD
	size		:	LONGINT; 		
	atomType	:	LONGINT;				
	header		:	MediaHeader;
END;

MediaDirectory = RECORD
	size			:	LONGINT;
	atomType		:	LONGINT;			{ = 'mdia' }
	mediaHeader 	: 	MediaHeaderAtom;	{ standard Media information }
	mHandler 		: 	HandlerAtom;
	mediaInfo		:	MediaInfo;
END;

{**********************
* Track Structures 
**********************}	

CONST	
	TrackEnable 	= 1;
	TrackInMovie 	= 2;
	TrackInPreview 	= 4;
	TrackInPoster 	= 8;
	
TYPE	
TrackHeader = RECORD
	flags			:	LONGINT;	{ 1 byte of version / 3 bytes of flags }
	creationTime	:	LONGINT;	{ seconds since Jan 1904 when directory was created }
	modificationTime :	LONGINT;	{ seconds since Jan 1904 when directory was appended }
	trackID			:	LONGINT;
	reserved1		:	LONGINT;
	duration		:	TimeValue;	{ length of track (track time) }
	reserved2		:	LONGINT;
	reserved3		:	LONGINT;
	layer			:	INTEGER;
	alternateGroup	:	INTEGER;
	volume			:	INTEGER;
	reserved4		:	INTEGER;
	matrix			:	MatrixRecord;
	trackWidth		:	Fixed;
	trackHeight		:	Fixed;
END;

TrackHeaderAtom = RECORD 
	size		:	LONGINT;	{ size of track header }
	atomType	:	LONGINT;	{ = 'tkhd' }
	header		:	TrackHeader;
END;

EditListType = RECORD 
	trackDuration 	: 	TimeValue;
	mediaTime		:	TimeValue;
	mediaRate		:	Fixed;
END;

EditListAtom	=	RECORD
	size			:	LONGINT;
	atomType		:	LONGINT; 	{ = elst }
	flags			:	LONGINT;	{ 1 byte of version / 3 bytes of flags }
	numEntries		:	LONGINT;
	editListTable 	: 	ARRAY[0..0] OF EditListType;
END;

EditsAtom = RECORD
	size		:	LONGINT;
	atomType	:	LONGINT;	{ = edts }
	editList	:	EditListAtom;
END;

TrackDirectory = RECORD
	size			:	LONGINT;
	atomType		:	LONGINT;			{ = 'trak' }
	trackHeader		:	TrackHeaderAtom;	{ standard track information }
	trackClip		:	ClippingAtom;
	edits			:	EditsAtom;
	media			:	MediaDirectory;
 	userData		:	UserDataAtom;		{ space for extending with new data types }
END;

MovieHeader = RECORD
	flags				:	LONGINT;		{ 1 byte of version / 3 bytes of flags }
	creationTime		:	LONGINT;		{ seconds since Jan 1904 when directory was created }
	modificationTime 	:	LONGINT;		{ seconds since Jan 1904 when directory was appended }

	{ Time specifications }
	timeScale		:	TimeValue;
	duration		:	TimeValue;
	
	preferredRate	:	Fixed;			{ rate at which to play this movie }
	preferredVolume	:	INTEGER;		{ volume to play movie at }
	reserved1		:	INTEGER;			

	{ Graphics specifications }
	reserved2			:	LONGINT;					
	reserved3			:	LONGINT;					

	matrix				:	MatrixRecord;
	
	previewTime			:	TimeValue;		{ time in track the proxy begins (track time) }
	previewDuration		:	TimeValue;		{ how long the proxy lasts (track time) }
	posterTime 			:	TimeValue;		{ time in track the proxy begins (track time) }
	selectionTime		:	TimeValue;		{ time in track the proxy begins (track time) }
	selectionDuration	:	TimeValue;		{ time in track the proxy begins (track time) }
	currentTime			:	TimeValue;		{ time in track the proxy begins (track time) }
	nextTrackID			:	LONGINT;		{ next value to use for a TrackID }
END;

MovieHeaderAtom = RECORD
	size		:	LONGINT;
	atomType	:	LONGINT;						{ = 'mvhd' }
	header		:	MovieHeader;
END;

MovieDirectory = RECORD
	size		:	LONGINT;
	atomType	:	LONGINT;						{ = 'moov' }
	header		:	MovieHeaderAtom;
	movieClip	:	ClippingAtom;				
	{ Track Directories }
	track		:	RECORD
					trackDirectory : ARRAY[0..0] OF TrackDirectory;
 					END;
 	{ User data for Movie }
 	userData	:	UserDataAtom;					{ space for user extensions }
END;

CONST
{ Movie formats and tags }
	{ some system defined format IDs }
	MOVIE_TYPE	=	'moov';
	TRACK_TYPE	=	'trak';
	MEDIA_TYPE	=	'mdia';
	VIDEO_TYPE	=	'vide';
	SOUND_TYPE	=	'soun';

{ atom id's }
	MovieAID				=	'moov';
	MovieHeaderAID			=	'mvhd';
	ClipAID					=	'clip';
	RgnClipAID				=	'crgn';
	MatteAID				=	'matt';
	MatteCompAID			=	'kmat';
	TrackAID				=	'trak';
	UserDataAID				=	'udta';
	TrackHeaderAID			=	'tkhd';
	EditsAID				=	'edts';
	EditListAID				=	'elst';
	MediaAID				=	'mdia';
	MediaHeaderAID			=	'mdhd';
	MediaInfoAID			=	'minf';
	VideoMediaInfoHeaderAID	=	'vmhd';
	SoundMediaInfoHeaderAID	=	'smhd';
	GenericMediaInfoHeaderAID = 'gmhd';
	GenericMediaInfoAID		=	'gmin';
	DataInfoAID				=	'dinf';
	DataRefAID				=	'dref';
	SampleTableAID			=	'stbl';
	STSampleDescAID			=	'stsd';
	STTimeToSampAID			=	'stts';
	STSyncSampleAID			=	'stss';
	STSampleToChunkAID		=	'stsc';
	STShadowSyncAID			=	'stsh';
	HandlerAID				=	'hdlr';
	STSampleSizeAID			=	'stsz';
	STChunkOffsetAID		=	'stco';
	DataRefContainerAID 	=	'drfc';
	
{$ENDC} { UsingMoviesFormat }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

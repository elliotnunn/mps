/************************************************************

Created: Wednesday, October 21, 1992 at 2:55 PM
 MoviesFormat.h
 C Interface to the Macintosh Libraries


 Copyright Apple Computer, Inc. 1991, 1992
 All rights reserved

************************************************************/

#ifndef __MOVIESFORMAT__
#define __MOVIESFORMAT__

#ifndef __MOVIES__
#include <Movies.h>
#endif

#define kMovieVersion	(0)				/* version number of the format here described */

#ifndef kSmallestArray
	#define kSmallestArray	1
#endif

/****************************************
*
*   General Types -
*		These types are used in more than one of the
*		directory types.
*
****************************************/

/* MoviesUserData is the type used for user data in movie and track directories */

struct MoviesUserData {
	long		size;						/* size of this user data */
	long		type;						/* type of user data */
	char 		data[kSmallestArray];		/* the user data */
	};
typedef struct MoviesUserData MoviesUserData;

struct UserDataAtom {
	long 			size;
	long			type;
	MoviesUserData	userData[kSmallestArray];
	};
typedef struct UserDataAtom UserDataAtom;

/* MoviesDataDescription tells us where the data for the movie or track lives.
   The data can follow the directory, be in the datafork of the same file as the directory resource,
   be in the resource fork of the same file as the directory resource, be in another file in the 
   data fork or resource fork, or require a specific bottleneck to fetch the data. */


/****************************************
*
*   MediaDirectory information -
*		The MediaDirectory is tightly coupled to the data.
*
****************************************/

/* The SampleDescriptionTable holds the SampleDescriptions needed to decompress chunks given the
   SampleDescriptionID. There is a table per Media. */

/*
struct SampleDescription {
	long		size;
	long		type;
	long		resvd1;
	short		resvdA;
	short		dataRefId;
	};
typedef struct SampleDescription SampleDescription;
typedef SampleDescription **SampleDescriptionHandle;
*/

struct SampleDescriptionAtom {
	long		size;
	long		type;							/* = 'stsd' */
	long		flags;							/* 1 byte of version / 3 bytes of flags */
	long		numEntries;
	SampleDescription	sampleDescTable[kSmallestArray];
	};
typedef struct SampleDescriptionAtom SampleDescriptionAtom;

/* TimeToSampleNum maps physical sample time to physical sample number. */
struct TimeToSampleNum {
	long		sampleCount;
	TimeValue	sampleDuration;
	};
typedef struct TimeToSampleNum TimeToSampleNum;

struct TimeToSampleNumAtom {
	long		size;
	long		type;							/* = 'stts' */
	long		flags;							/* 1 byte of version / 3 bytes of flags */
	long		numEntries;
	TimeToSampleNum	timeToSampleNumTable[kSmallestArray];
	};
typedef struct TimeToSampleNumAtom TimeToSampleNumAtom;
	

/* SyncSamples is a list of the physical samples which are self contained. */

struct SyncSampleAtom {
	long		size;
	long		type;								/* = 'stss' */
	long		flags;								/* 1 byte of version / 3 bytes of flags */
	long		numEntries;
	long		syncSampleTable[kSmallestArray];
	};
typedef struct SyncSampleAtom SyncSampleAtom;

/* SampleToChunk maps physical sample number to chunk number.
 */
 
struct SampleToChunk {				/* same as SampleToChunk, but redundant first sample is removed */
	long		firstChunk;
	long		samplesPerChunk;
	long		sampleDescriptionID;
	};
typedef struct SampleToChunk SampleToChunk;

struct SampleToChunkAtom {
	long		size;
	long		type;								/* = 'stsc' */
	long		flags;								/* 1 byte of version / 3 bytes of flags */
	long		numEntries;
	SampleToChunk	sampleToChunkTable[kSmallestArray];
	};
typedef struct SampleToChunkAtom SampleToChunkAtom;

struct ChunkOffsetAtom {
	long		size;
	long		type;								/* = 'stco' */
	long		flags;								/* 1 byte of version / 3 bytes of flags */
	long		numEntries;
	long		chunkOffsetTable[kSmallestArray];
	};
typedef struct ChunkOffsetAtom ChunkOffsetAtom;

struct SampleSizeAtom {
	long		size;
	long		type;								/* = 'stsz' */
	long		flags;								/* 1 byte of version / 3 bytes of flags */
	long		sampleSize;
	long		numEntries;
	long		sampleSizeTable[kSmallestArray];
	};
typedef struct SampleSizeAtom SampleSizeAtom;

struct ShadowSync {
	long		fdSampleNum;
	long		syncSampleNum;
	};
typedef struct ShadowSync ShadowSync;

struct ShadowSyncAtom {
	long		size;
	long		type;								/* = 'stsz' */
	long		flags;								/* 1 byte of version / 3 bytes of flags */
	long		numEntries;
	ShadowSync		shadowSyncTable[kSmallestArray];
	};
typedef struct ShadowSyncAtom ShadowSyncAtom;

struct SampleTableAtom {
	long		size;
	long		type;			/* = 'stbl' */

	SampleDescriptionAtom	sampleDescription;
	TimeToSampleNumAtom		timeToSampleNum;
	SampleToChunkAtom		sampleToChunk;
	SyncSampleAtom			syncSample;
	SampleSizeAtom			sampleSize;
	ChunkOffsetAtom			chunkOffset;
	ShadowSyncAtom			shadowSync;
	
	};
typedef struct SampleTableAtom SampleTableAtom;
	
struct PublicHandlerInfo {
	long				flags;							/* 1 byte of version / 3 bytes of flags */
	
	long				componentType;					
	long				componentSubType;				
	long				componentManufacturer;
	long				componentFlags;
	long				componentFlagsMask;
	char				componentName[kSmallestArray];
	
	};
typedef struct PublicHandlerInfo PublicHandlerInfo;

struct HandlerAtom {
	long				size;
	long				type;							/* = 'hdlr' */
	
	PublicHandlerInfo	hInfo;	
	};
typedef struct HandlerAtom HandlerAtom;
	
typedef long DataRefAtom;								/* a data reference is a private structure */

struct DataInfoAtom {
	long				size;
	long				type;							/* = 'dinf' */
	
	DataRefAtom			dataRef;
	};
typedef struct DataInfoAtom DataInfoAtom;

struct RgnAtom {
	long		size;
	long		type;
	
	short		rgnSize;
	Rect		rgnBBox;
	char		data[kSmallestArray];
	};
typedef struct RgnAtom RgnAtom;

struct MatteCompressedAtom {
	long				size;
	long				type;
	
	long				flags;							/* 1 byte of version / 3 bytes of flags */
	
	ImageDescription	matteImageDescription;

	char				matteData[kSmallestArray];
	};
typedef struct MatteCompressedAtom MatteCompressedAtom;

struct MatteAtom {
	long		size;
	long		type;
	
	MatteCompressedAtom	aCompressedMatte;
	};
typedef struct MatteAtom MatteAtom;

struct ClippingAtom {
	long		size;
	long		type;
	
	RgnAtom		aRgnClip;
	};
typedef struct ClippingAtom ClippingAtom;

/***********************
* Media Info Example Structures 
***********************/	

	
struct VideoMediaInfoHeader {
	long				flags;							/* 1 byte of version / 3 bytes of flags */

	short				graphicsMode;					/* for QD - transfer mode */
	short				opColorRed;						/* opcolor for transfer mode */
	short				opColorGreen;
	short				opColorBlue;
	
	};
typedef struct VideoMediaInfoHeader VideoMediaInfoHeader;


struct VideoMediaInfoHeaderAtom {
	long				size;							/* size of Media info */
	long				type;							/* = 'vmhd' */
	VideoMediaInfoHeader	vmiHeader;
	};
typedef struct VideoMediaInfoHeaderAtom VideoMediaInfoHeaderAtom;

struct VideoMediaInfo {
	long				size;							/* size of Media info */
	long				type;							/* = 'minf' */
	
	VideoMediaInfoHeaderAtom	header;
	
	HandlerAtom			dataHandler;
	
	DataInfoAtom		dataInfo;
	
	SampleTableAtom		sampleTable;
	};
typedef struct VideoMediaInfo VideoMediaInfo;

struct SoundMediaInfoHeader {
	long				flags;							/* 1 byte of version / 3 bytes of flags */

 	short				balance;				
	short				rsrvd;
	
	};
typedef struct SoundMediaInfoHeader SoundMediaInfoHeader;

struct SoundMediaInfoHeaderAtom {
	long				size;							/* size of Media info */
	long				type;							/* = 'vmhd' */
	
	SoundMediaInfoHeader	smiHeader;	
	};
typedef struct SoundMediaInfoHeaderAtom SoundMediaInfoHeaderAtom;

struct SoundMediaInfo {
	long				size;							/* size of Media info */
	long				type;							/* = 'minf' */
	
	SoundMediaInfoHeaderAtom	header;
	
	HandlerAtom			dataHandler;
	
	DataRefAtom			dataReference;
	
	SampleTableAtom		sampleTable;
	};
typedef struct SoundMediaInfo SoundMediaInfo;

struct MediaInfo {
	long			size;
	long			type;
	
	/* whatever data the media handler needs goes here */
	};
typedef struct MediaInfo MediaInfo;

/***********************
* Media Directory Structures 
***********************/	

struct MediaHeader {
	long				flags;							/* 1 byte of version / 3 bytes of flags */
	
	long				creationTime;					/* seconds since Jan 1904 when directory was created */
	long				modificationTime;				/* seconds since Jan 1904 when directory was appended */

	TimeValue			timeScale;						/* start time for Media (Media time) */
	TimeValue			duration;						/* length of Media (Media time) */

	short				language;
	short				quality;
	};
typedef struct MediaHeader MediaHeader;

struct MediaHeaderAtom {
	long 		size;
	long		type;			
	
	MediaHeader	header;
	};
typedef struct MediaHeaderAtom MediaHeaderAtom;

struct MediaDirectory {
	long				size;
	long				type;							/* = 'mdia' */
	
	MediaHeaderAtom			mediaHeader;				/* standard Media information */

	HandlerAtom			mediaHandler;

	MediaInfo			mediaInfo;
};
typedef struct MediaDirectory MediaDirectory;


/***********************
* Track Structures 
***********************/	
	
enum {
	TrackEnable = 1<<0,
	TrackInMovie = 1<<1,
	TrackInPreview = 1<<2,
	TrackInPoster = 1<<3
	};
	
struct TrackHeader {
	long				flags;							/* 1 byte of version / 3 bytes of flags */

	long				creationTime;					/* seconds since Jan 1904 when directory was created */
	long				modificationTime;				/* seconds since Jan 1904 when directory was appended */

	long				trackID;

	long				reserved1;

	TimeValue			duration;						/* length of track (track time) */

	long				reserved2;
	long				reserved3;

	short				layer;
	short				alternateGroup;

	short				volume;
	short				reserved4;

	MatrixRecord		matrix;
	Fixed				trackWidth;
	Fixed				trackHeight;
		
};
typedef struct TrackHeader TrackHeader;

struct TrackHeaderAtom {
	long				size;							/* size of track header */
	long				type;							/* = 'tkhd' */
		
	TrackHeader		header;
	};
typedef struct TrackHeaderAtom TrackHeaderAtom;

struct EditListType {
	TimeValue		trackDuration;
	TimeValue		mediaTime;
	Fixed			mediaRate;
	};
typedef struct EditListType EditListType;

struct EditListAtom {
	long				size;
	long				type;							/* = elst */
	
	long				flags;							/* 1 byte of version / 3 bytes of flags */

	long				numEntries;
	EditListType		editListTable[kSmallestArray];
	};
typedef struct EditListAtom EditListAtom;

struct EditsAtom {
	long			size;
	long			type;								/* = edts */
	
	EditListAtom	editList;
	};
typedef struct EditsAtom EditsAtom;

	
struct TrackDirectory {
	long				size;
	long				type;							/* = 'trak' */

	TrackHeaderAtom			trackHeader;				/* standard track information */

	ClippingAtom		trackClip;

	EditsAtom			edits;
	
	MediaDirectory		media;
	
 	UserDataAtom		userData;						/* space for extending with new data types */
};
typedef struct TrackDirectory TrackDirectory;

/****************************************
*
*   MovieDirectory -
*		The MovieDirectory is the top level structure which 
*		holds the TrackInstance describing where the
*		TrackDirectories are.
*
****************************************/

struct MovieHeader{
	long				flags;							/* 1 byte of version / 3 bytes of flags */

	long				creationTime;					/* seconds since Jan 1904 when directory was created */
	long				modificationTime;				/* seconds since Jan 1904 when directory was appended */

	/* Time specifications */
	TimeValue			timeScale;
	TimeValue			duration;
	Fixed				preferredRate;					/* rate at which to play this movie */

	short				preferredVolume;				/* volume to play movie at */
	short				reserved1;			

	/* Graphics specifications */
	long				preferredLong1;					
	long				preferredLong2;					

	MatrixRecord		matrix;

	TimeValue			previewTime;					/* time in track the proxy begins (track time) */
	TimeValue			previewDuration;				/* how long the proxy lasts (track time) */

	TimeValue			posterTime;						/* time in track the proxy begins (track time) */

	TimeValue			selectionTime;					/* time in track the proxy begins (track time) */
	TimeValue			selectionDuration;				/* time in track the proxy begins (track time) */
	TimeValue			currentTime;					/* time in track the proxy begins (track time) */

	long 				nextTrackID;					/* next value to use for a TrackID */

	};
typedef struct MovieHeader MovieHeader;

struct MovieHeaderAtom {
	long				size;
	long				type;							/* = 'mvhd' */

	MovieHeader 	header;
	};
typedef struct MovieHeaderAtom MovieHeaderAtom;

struct MovieDirectory {
	long				size;
	long				type;							/* = 'moov' */
	
	MovieHeaderAtom		header;
	
	ClippingAtom		movieClip;				
	
	/* Track Directories */
	struct {
		TrackDirectory  trackDirectory; 				/* Track directory information */	
		} 				track[kSmallestArray];
 		
 	/* User data for Movie */
 	UserDataAtom		userData;						/* space for user extensions */
 	
	};
typedef struct MovieDirectory MovieDirectory;


/****************************************
****************************************/


/* Movie formats and tags */
	/* some system defined format IDs */
	#define	MOVIE_TYPE		'moov'
	#define TRACK_TYPE		'trak'
	#define MEDIA_TYPE		'mdia'
	#define VIDEO_TYPE		'vide'
	#define SOUND_TYPE		'soun'


/* atom id's */
	#define MovieAID				'moov'
	#define MovieHeaderAID			'mvhd'
	#define ClipAID					'clip'
	#define RgnClipAID				'crgn'
	#define MatteAID				'matt'
	#define MatteCompAID			'kmat'
	#define TrackAID				'trak'
	#define	UserDataAID				'udta'
	#define	TrackHeaderAID			'tkhd'
	#define EditsAID				'edts'
	#define EditListAID				'elst'
	#define MediaAID				'mdia'
	#define MediaHeaderAID			'mdhd'
	#define	MediaInfoAID			'minf'
	#define VideoMediaInfoHeaderAID	'vmhd'
	#define SoundMediaInfoHeaderAID	'smhd'
	#define GenericMediaInfoHeaderAID	'gmhd'
	#define GenericMediaInfoAID		'gmin'
	#define DataInfoAID				'dinf'
	#define DataRefAID				'dref'
	#define SampleTableAID			'stbl'
	#define STSampleDescAID			'stsd'
	#define STTimeToSampAID			'stts'
	#define STSyncSampleAID			'stss'
	#define STSampleToChunkAID		'stsc'
	#define STShadowSyncAID			'stsh'
	#define HandlerAID				'hdlr'
	#define STSampleSizeAID			'stsz'
	#define STChunkOffsetAID		'stco'
	#define DataRefContainerAID 	'drfc'
	
#endif __MOVIESFORMAT__

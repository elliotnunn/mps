{
 	File:		AIFF.p
 
 	Contains:	Definition of AIFF file format components.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AIFF;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __AIFF__}
{$SETC __AIFF__ := 1}

{$I+}
{$SETC AIFFIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	AIFFID						= 'AIFF';
	AIFCID						= 'AIFC';
	FormatVersionID				= 'FVER';
	CommonID					= 'COMM';
	FORMID						= 'FORM';
	SoundDataID					= 'SSND';
	MarkerID					= 'MARK';
	InstrumentID				= 'INST';
	MIDIDataID					= 'MIDI';
	AudioRecordingID			= 'AESD';
	ApplicationSpecificID		= 'APPL';
	CommentID					= 'COMT';
	NameID						= 'NAME';
	AuthorID					= 'AUTH';
	CopyrightID					= '(c) ';
	AnnotationID				= 'ANNO';

	NoLooping					= 0;
	ForwardLooping				= 1;
	ForwardBackwardLooping		= 2;
{ AIFF-C Versions }
	AIFCVersion1				= $A2805140;

{ Compression Names }
	NoneName     = 'not compressed';
	ACE2to1Name  = 'ACE 2-to-1';
	ACE8to3Name  = 'ACE 8-to-3';
	MACE3to1Name = 'MACE 3-to-1';
	MACE6to1Name = 'MACE 6-to-1';

{ Compression Types }
	NoneType					= 'NONE';
	ACE2Type					= 'ACE2';
	ACE8Type					= 'ACE8';
	MACE3Type					= 'MAC3';
	MACE6Type					= 'MAC6';

	
TYPE
	ID = LONGINT;

	MarkerIdType = INTEGER;

	ChunkHeader = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
	END;

	ContainerChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		formType:				ID;
	END;

	FormatVersionChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		timestamp:				LONGINT;
	END;

	FormatVersionChunkPtr = ^FormatVersionChunk;

	CommonChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		numChannels:			INTEGER;
		numSampleFrames:		LONGINT;
		sampleSize:				INTEGER;
		sampleRate:				extended80;
	END;

	CommonChunkPtr = ^CommonChunk;

	ExtCommonChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		numChannels:			INTEGER;
		numSampleFrames:		LONGINT;
		sampleSize:				INTEGER;
		sampleRate:				extended80;
		compressionType:		ID;
		compressionName:		PACKED ARRAY [0..0] OF CHAR;			{ variable length array, Pascal string }
	END;

	ExtCommonChunkPtr = ^ExtCommonChunk;

	SoundDataChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		offset:					LONGINT;
		blockSize:				LONGINT;
	END;

	SoundDataChunkPtr = ^SoundDataChunk;

	Marker = RECORD
		id:						MarkerIdType;
		position:				LONGINT;
		markerName:				Str255;
	END;

	MarkerChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		numMarkers:				INTEGER;
		Markers:				ARRAY [0..0] OF Marker;					{ variable length array }
	END;

	MarkerChunkPtr = ^MarkerChunk;

	AIFFLoop = RECORD
		playMode:				INTEGER;
		beginLoop:				MarkerIdType;
		endLoop:				MarkerIdType;
	END;

	InstrumentChunk = PACKED RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		baseFrequency:			UInt8;
		detune:					UInt8;
		lowFrequency:			UInt8;
		highFrequency:			UInt8;
		lowVelocity:			UInt8;
		highVelocity:			UInt8;
		gain:					INTEGER;
		sustainLoop:			AIFFLoop;
		releaseLoop:			AIFFLoop;
	END;

	InstrumentChunkPtr = ^InstrumentChunk;

	MIDIDataChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		MIDIdata:				PACKED ARRAY [0..0] OF SInt8; (* UInt8 *) { variable length array }
	END;

	MIDIDataChunkPtr = ^MIDIDataChunk;

	AudioRecordingChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		AESChannelStatus:		PACKED ARRAY [0..23] OF SInt8; (* UInt8 *)
	END;

	AudioRecordingChunkPtr = ^AudioRecordingChunk;

	ApplicationSpecificChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		applicationSignature:	OSType;
		data:					PACKED ARRAY [0..0] OF SInt8; (* UInt8 *) { variable length array }
	END;

	ApplicationSpecificChunkPtr = ^ApplicationSpecificChunk;

	Comment = RECORD
		timeStamp:				LONGINT;
		marker:					MarkerIdType;
		count:					INTEGER;
		text:					PACKED ARRAY [0..0] OF CHAR;			{ variable length array, Pascal string }
	END;

	CommentsChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		numComments:			INTEGER;
		comments:				PACKED ARRAY [0..0] OF Comment;			{ variable length array }
	END;

	CommentsChunkPtr = ^CommentsChunk;

	TextChunk = RECORD
		ckID:					ID;
		ckSize:					LONGINT;
		text:					PACKED ARRAY [0..0] OF CHAR;			{ variable length array, Pascal string }
	END;

	TextChunkPtr = ^TextChunk;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AIFFIncludes}

{$ENDC} {__AIFF__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

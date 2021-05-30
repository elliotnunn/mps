
/************************************************************

Created: Monday, December 2, 1991 at 5:00 PM
 AIFF.h
 C Interface to the Macintosh Libraries


  Copyright Apple Computer, Inc. 1990-1991
  All rights reserved

************************************************************/


#ifndef __AIFF__
#define __AIFF__

#ifndef __TYPES__
#include <Types.h>
#endif


enum {


#define AIFFID 'AIFF'
#define AIFCID 'AIFC'
#define FormatVersionID 'FVER'
#define CommonID 'COMM'
#define FORMID 'FORM'
#define SoundDataID 'SSND'
#define MarkerID 'MARK'
#define InstrumentID 'INST'
#define MIDIDataID 'MIDI'
#define AudioRecordingID 'AESD'
#define ApplicationSpecificID 'APPL'
#define CommentID 'COMT'
#define NameID 'NAME'
#define AuthorID 'AUTH'
#define CopyrightID '(c) '
#define AnnotationID 'ANNO'

 NoLooping = 0,
 ForwardLooping = 1,
 ForwardBackwardLooping = 2,

/* AIFF-C Versions */
 AIFCVersion1 = 0xA2805140

/* Compression Names */

#define NoneName "\pnot compressed"
#define ACE2to1Name "\pACE 2-to-1"
#define ACE8to3Name "\pACE 8-to-3"
#define MACE3to1Name "\pMACE 3-to-1"
#define MACE6to1Name "\pMACE 6-to-1"

/* Compression Types */
#define NoneType 'NONE'
#define ACE2Type 'ACE2'
#define ACE8Type 'ACE8'
#define MACE3Type 'MAC3'
#define MACE6Type 'MAC6'
};

typedef unsigned long ID;
typedef short MarkerIdType;

struct ChunkHeader {
 ID ckID;
 long ckSize;
};

typedef struct ChunkHeader ChunkHeader;

struct ContainerChunk {
 ID ckID;
 long ckSize;
 ID formType;
};

typedef struct ContainerChunk ContainerChunk;

struct FormatVersionChunk {
 ID ckID;
 long ckSize;
 unsigned long timestamp;
};

typedef struct FormatVersionChunk FormatVersionChunk;
typedef FormatVersionChunk *FormatVersionChunkPtr;

struct CommonChunk {
 ID ckID;
 long ckSize;
 short numChannels;
 unsigned long numSampleFrames;
 short sampleSize;
 extended80 sampleRate;
};

typedef struct CommonChunk CommonChunk;
typedef CommonChunk *CommonChunkPtr;

struct ExtCommonChunk {
 ID ckID;
 long ckSize;
 short numChannels;
 unsigned long numSampleFrames;
 short sampleSize;
 extended80 sampleRate;
 ID compressionType;
 char compressionName[1];
};

typedef struct ExtCommonChunk ExtCommonChunk;
typedef ExtCommonChunk *ExtCommonChunkPtr;

struct SoundDataChunk {
 ID ckID;
 long ckSize;
 unsigned long offset;
 unsigned long blockSize;
};

typedef struct SoundDataChunk SoundDataChunk;
typedef SoundDataChunk *SoundDataChunkPtr;

struct Marker {
 MarkerIdType id;
 unsigned long position;
 Str255 markerName;
};

typedef struct Marker Marker;

struct MarkerChunk {
 ID ckID;
 long ckSize;
 unsigned short numMarkers;
 Marker Markers[1];
};

typedef struct MarkerChunk MarkerChunk;
typedef MarkerChunk *MarkerChunkPtr;

struct AIFFLoop {
 short playMode;
 MarkerIdType beginLoop;
 MarkerIdType endLoop;
};

typedef struct AIFFLoop AIFFLoop;

struct InstrumentChunk {
 ID ckID;
 long ckSize;
 char baseFrequency;
 char detune;
 char lowFrequency;
 char highFrequency;
 char lowVelocity;
 char highVelocity;
 short gain;
 AIFFLoop sustainLoop;
 AIFFLoop releaseLoop;
};

typedef struct InstrumentChunk InstrumentChunk;
typedef InstrumentChunk *InstrumentChunkPtr;

struct MIDIDataChunk {
 ID ckID;
 long ckSize;
 unsigned char MIDIdata[1];
};

typedef struct MIDIDataChunk MIDIDataChunk;
typedef MIDIDataChunk *MIDIDataChunkPtr;

struct AudioRecordingChunk {
 ID ckID;
 long ckSize;
 unsigned char AESChannelStatus[24];
};

typedef struct AudioRecordingChunk AudioRecordingChunk;
typedef AudioRecordingChunk *AudioRecordingChunkPtr;

struct ApplicationSpecificChunk {
 ID ckID;
 long ckSize;
 OSType applicationSignature;
 char data[1];
};

typedef struct ApplicationSpecificChunk ApplicationSpecificChunk;
typedef ApplicationSpecificChunk *ApplicationSpecificChunkPtr;

struct Comment {
 unsigned long timeStamp;
 MarkerIdType marker;
 unsigned short count;
 char text[1];
};

typedef struct Comment Comment;

struct CommentsChunk {
 ID ckID;
 long ckSize;
 unsigned short numComments;
 Comment comments[1];
};

typedef struct CommentsChunk CommentsChunk;
typedef CommentsChunk *CommentsChunkPtr;

struct TextChunk {
 ID ckID;
 long ckSize;
 char text[1];
};

typedef struct TextChunk TextChunk;
typedef TextChunk *TextChunkPtr;



#endif

/*
	File:		ImageCompression.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.

	WARNING
	This file was auto generated by the interfacer tool. Modifications
	must be made to the master file.

*/

#ifndef __IMAGECOMPRESSION__
#define __IMAGECOMPRESSION__

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*		#include <MixedMode.h>									*/
/*			#include <Traps.h>									*/
/*	#include <QuickdrawText.h>									*/
/*		#include <IntlResources.h>								*/
#endif

#ifndef __QDOFFSCREEN__
#include <QDOffscreen.h>
#endif

#ifndef __TYPES__
#endif

#ifndef __COMPONENTS__
#include <Components.h>
#endif

#ifndef __STANDARDFILE__
#include <StandardFile.h>
/*	#include <Dialogs.h>										*/
/*		#include <Windows.h>									*/
/*			#include <Events.h>									*/
/*				#include <OSUtils.h>							*/
/*			#include <Controls.h>								*/
/*				#include <Menus.h>								*/
/*		#include <TextEdit.h>									*/
/*	#include <Files.h>											*/
/*		#include <SegLoad.h>									*/
#endif

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct MatrixRecord {
	Fixed						matrix[3][3];
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct MatrixRecord MatrixRecord;

typedef MatrixRecord *MatrixRecordPtr;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct FixedPoint {
	Fixed						x;
	Fixed						y;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct FixedPoint FixedPoint;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct FixedRect {
	Fixed						left;
	Fixed						top;
	Fixed						right;
	Fixed						bottom;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct FixedRect FixedRect;

#define codecInfoDoes1 (1L<<0)

#define codecInfoDoes2 (1L<<1)

#define codecInfoDoes4 (1L<<2)

#define codecInfoDoes8 (1L<<3)

#define codecInfoDoes16 (1L<<4)

#define codecInfoDoes32 (1L<<5)

#define codecInfoDoesDither (1L<<6)

#define codecInfoDoesStretch (1L<<7)

#define codecInfoDoesShrink (1L<<8)

#define codecInfoDoesMask (1L<<9)

#define codecInfoDoesTemporal (1L<<10)

#define codecInfoDoesDouble (1L<<11)

#define codecInfoDoesQuad (1L<<12)

#define codecInfoDoesHalf (1L<<13)

#define codecInfoDoesQuarter (1L<<14)

#define codecInfoDoesRotate (1L<<15)

#define codecInfoDoesHorizFlip (1L<<16)

#define codecInfoDoesVertFlip (1L<<17)

#define codecInfoDoesSkew (1L<<18)

#define codecInfoDoesBlend (1L<<19)

#define codecInfoDoesWarp (1L<<20)

#define codecInfoDoesRecompress (1L<<21)

#define codecInfoDoesSpool (1L<<22)

#define codecInfoDoesRateConstrain (1L<<23)

#define codecInfoDepth1 (1L<<0)

#define codecInfoDepth2 (1L<<1)

#define codecInfoDepth4 (1L<<2)

#define codecInfoDepth8 (1L<<3)

#define codecInfoDepth16 (1L<<4)

#define codecInfoDepth32 (1L<<5)

#define codecInfoDepth24 (1L<<6)

#define codecInfoDepth33 (1L<<7)

#define codecInfoDepth34 (1L<<8)

#define codecInfoDepth36 (1L<<9)

#define codecInfoDepth40 (1L<<10)

#define codecInfoStoresClut (1L<<11)

#define codecInfoDoesLossless (1L<<12)

#define codecInfoSequenceSensitive (1L<<13)

#define codecFlagUseImageBuffer (1L<<0)

#define codecFlagUseScreenBuffer (1L<<1)

#define codecFlagUpdatePrevious (1L<<2)

#define codecFlagNoScreenUpdate (1L<<3)

#define codecFlagWasCompressed (1L<<4)

#define codecFlagDontOffscreen (1L<<5)

#define codecFlagUpdatePreviousComp (1L<<6)

#define codecFlagForceKeyFrame (1L<<7)

#define codecFlagOnlyScreenUpdate (1L<<8)

#define codecFlagLiveGrab (1L<<9)

#define codecFlagDontUseNewImageBuffer (1L<<10)

#define codecFlagInterlaceUpdate (1L<<11)

#define codecFlagUsedNewImageBuffer (1L<<14)

#define codecFlagUsedImageBuffer (1L<<15)

#define codecMinimumDataSize 32768

#define compressorComponentType 'imco'

#define decompressorComponentType 'imdc'

typedef Component CompressorComponent;

typedef Component DecompressorComponent;

typedef Component CodecComponent;

#define anyCodec ((CodecComponent)0)

#define bestSpeedCodec ((CodecComponent)-1)

#define bestFidelityCodec ((CodecComponent)-2)

#define bestCompressionCodec ((CodecComponent)-3)

typedef long CodecType;

typedef unsigned short CodecFlags;

typedef unsigned long CodecQ;

#define codecLosslessQuality 0x400L

#define codecMaxQuality 0x3ffL

#define codecMinQuality 0x000L

#define codecLowQuality 0x100L

#define codecNormalQuality 0x200L

#define codecHighQuality 0x300L

typedef pascal OSErr (*ICMDataProcPtr)(Ptr *dataP, long bytesNeeded, long refcon);

enum {
	uppICMDataProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
};

#if USESROUTINEDESCRIPTORS
typedef UniversalProcPtr ICMDataUPP;

#define CallICMDataProc(userRoutine, dataP, bytesNeeded, refcon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppICMDataProcInfo, (dataP), (bytesNeeded), (refcon))
#define NewICMDataProc(userRoutine)		\
		(ICMDataUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppICMDataProcInfo, GetCurrentISA())
#else
typedef ICMDataProcPtr ICMDataUPP;

#define CallICMDataProc(userRoutine, dataP, bytesNeeded, refcon)		\
		(*(userRoutine))((dataP), (bytesNeeded), (refcon))
#define NewICMDataProc(userRoutine)		\
		(ICMDataUPP)(userRoutine)
#endif

typedef pascal OSErr (*ICMFlushProcPtr)(Ptr data, long bytesAdded, long refcon);

enum {
	uppICMFlushProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
};

#if USESROUTINEDESCRIPTORS
typedef UniversalProcPtr ICMFlushUPP;

#define CallICMFlushProc(userRoutine, data, bytesAdded, refcon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppICMFlushProcInfo, (data), (bytesAdded), (refcon))
#define NewICMFlushProc(userRoutine)		\
		(ICMFlushUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppICMFlushProcInfo, GetCurrentISA())
#else
typedef ICMFlushProcPtr ICMFlushUPP;

#define CallICMFlushProc(userRoutine, data, bytesAdded, refcon)		\
		(*(userRoutine))((data), (bytesAdded), (refcon))
#define NewICMFlushProc(userRoutine)		\
		(ICMFlushUPP)(userRoutine)
#endif

typedef pascal void (*ICMCompletionProcPtr)(OSErr result, short flags, long refcon);

enum {
	uppICMCompletionProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
};

#if USESROUTINEDESCRIPTORS
typedef UniversalProcPtr ICMCompletionUPP;

#define CallICMCompletionProc(userRoutine, result, flags, refcon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppICMCompletionProcInfo, (result), (flags), (refcon))
#define NewICMCompletionProc(userRoutine)		\
		(ICMCompletionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppICMCompletionProcInfo, GetCurrentISA())
#else
typedef ICMCompletionProcPtr ICMCompletionUPP;

#define CallICMCompletionProc(userRoutine, result, flags, refcon)		\
		(*(userRoutine))((result), (flags), (refcon))
#define NewICMCompletionProc(userRoutine)		\
		(ICMCompletionUPP)(userRoutine)
#endif

#define codecCompletionSource (1<<0)

#define codecCompletionDest (1<<1)

typedef pascal OSErr (*ICMProgressProcPtr)(short message, Fixed completeness, long refcon);

enum {
	uppICMProgressProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Fixed)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
};

#if USESROUTINEDESCRIPTORS
typedef UniversalProcPtr ICMProgressUPP;

#define CallICMProgressProc(userRoutine, message, completeness, refcon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppICMProgressProcInfo, (message), (completeness), (refcon))
#define NewICMProgressProc(userRoutine)		\
		(ICMProgressUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppICMProgressProcInfo, GetCurrentISA())
#else
typedef ICMProgressProcPtr ICMProgressUPP;

#define CallICMProgressProc(userRoutine, message, completeness, refcon)		\
		(*(userRoutine))((message), (completeness), (refcon))
#define NewICMProgressProc(userRoutine)		\
		(ICMProgressUPP)(userRoutine)
#endif

#define codecProgressOpen 0

#define codecProgressUpdatePercent 1

#define codecProgressClose 2

typedef pascal void (*StdPixProcPtr)(PixMap *src, Rect *srcRect, MatrixRecord *matrix, short mode, RgnHandle mask, PixMap *matte, Rect *matteRect, short flags);

enum {
	uppStdPixProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(PixMap*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Rect*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(MatrixRecord*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(RgnHandle)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(PixMap*)))
		 | STACK_ROUTINE_PARAMETER(7, SIZE_CODE(sizeof(Rect*)))
		 | STACK_ROUTINE_PARAMETER(8, SIZE_CODE(sizeof(short)))
};

#if USESROUTINEDESCRIPTORS
typedef UniversalProcPtr StdPixUPP;

#define CallStdPixProc(userRoutine, src, srcRect, matrix, mode, mask, matte, matteRect, flags)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppStdPixProcInfo, (src), (srcRect), (matrix), (mode), (mask), (matte), (matteRect), (flags))
#define NewStdPixProc(userRoutine)		\
		(StdPixUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppStdPixProcInfo, GetCurrentISA())
#else
typedef StdPixProcPtr StdPixUPP;

#define CallStdPixProc(userRoutine, src, srcRect, matrix, mode, mask, matte, matteRect, flags)		\
		(*(userRoutine))((src), (srcRect), (matrix), (mode), (mask), (matte), (matteRect), (flags))
#define NewStdPixProc(userRoutine)		\
		(StdPixUPP)(userRoutine)
#endif

typedef pascal void (*ICMAlignmentProcPtr)(Rect *rp, long refcon);

enum {
	uppICMAlignmentProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Rect*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
};

#if USESROUTINEDESCRIPTORS
typedef UniversalProcPtr ICMAlignmentUPP;

#define CallICMAlignmentProc(userRoutine, rp, refcon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppICMAlignmentProcInfo, (rp), (refcon))
#define NewICMAlignmentProc(userRoutine)		\
		(ICMAlignmentUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppICMAlignmentProcInfo, GetCurrentISA())
#else
typedef ICMAlignmentProcPtr ICMAlignmentUPP;

#define CallICMAlignmentProc(userRoutine, rp, refcon)		\
		(*(userRoutine))((rp), (refcon))
#define NewICMAlignmentProc(userRoutine)		\
		(ICMAlignmentUPP)(userRoutine)
#endif

typedef long ImageSequence;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct ICMProgressProcRecord {
	ICMProgressUPP				progressProc;
	long						progressRefCon;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct ICMProgressProcRecord ICMProgressProcRecord;

typedef ICMProgressProcRecord *ICMProgressProcRecordPtr;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct ICMCompletionProcRecord {
	ICMCompletionUPP			completionProc;
	long						completionRefCon;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct ICMCompletionProcRecord ICMCompletionProcRecord;

typedef ICMCompletionProcRecord *ICMCompletionProcRecordPtr;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct ICMDataProcRecord {
	ICMDataUPP					dataProc;
	long						dataRefCon;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct ICMDataProcRecord ICMDataProcRecord;

typedef ICMDataProcRecord *ICMDataProcRecordPtr;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct ICMFlushProcRecord {
	ICMFlushUPP					flushProc;
	long						flushRefCon;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct ICMFlushProcRecord ICMFlushProcRecord;

typedef ICMFlushProcRecord *ICMFlushProcRecordPtr;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct ICMAlignmentProcRecord {
	ICMAlignmentUPP				alignmentProc;
	long						alignmentRefCon;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct ICMAlignmentProcRecord ICMAlignmentProcRecord;

typedef ICMAlignmentProcRecord *ICMAlignmentProcRecordPtr;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct DataRateParams {
	long						dataRate;
	long						dataOverrun;
	long						frameDuration;
	long						keyFrameRate;
	CodecQ						minSpatialQuality;
	CodecQ						minTemporalQuality;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct DataRateParams DataRateParams;

typedef DataRateParams *DataRateParamsPtr;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct ImageDescription {
	long						idSize;
	CodecType					cType;
	long						resvd1;
	short						resvd2;
	short						dataRefIndex;
	short						version;
	short						revisionLevel;
	long						vendor;
	CodecQ						temporalQuality;
	CodecQ						spatialQuality;
	short						width;
	short						height;
	Fixed						hRes;
	Fixed						vRes;
	long						dataSize;
	short						frameCount;
	Str31						name;
	short						depth;
	short						clutID;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct ImageDescription ImageDescription;

typedef ImageDescription *ImageDescriptionPtr;

typedef ImageDescription **ImageDescriptionHandle;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct CodecInfo {
	Str31						typeName;
	short						version;
	short						revisionLevel;
	long						vendor;
	long						decompressFlags;
	long						compressFlags;
	long						formatFlags;
	unsigned char				compressionAccuracy;
	unsigned char				decompressionAccuracy;
	unsigned short				compressionSpeed;
	unsigned short				decompressionSpeed;
	unsigned char				compressionLevel;
	char						resvd;
	short						minimumHeight;
	short						minimumWidth;
	short						decompressPipelineLatency;
	short						compressPipelineLatency;
	long						privateData;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct CodecInfo CodecInfo;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct CodecNameSpec {
	CodecComponent				codec;
	CodecType					cType;
	Str31						typeName;
	Handle						name;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct CodecNameSpec CodecNameSpec;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct CodecNameSpecList {
	short						count;
	CodecNameSpec				list[1];
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct CodecNameSpecList CodecNameSpecList;

typedef CodecNameSpecList *CodecNameSpecListPtr;

#define defaultDither 0

#define forceDither 1

#define suppressDither 2

#define useColorMatching 4

#ifdef __cplusplus
extern "C" {
#endif

extern pascal OSErr CodecManagerVersion(long *version)
 TWOWORDINLINE(0x7000, 0xAAA3);
extern pascal OSErr GetCodecNameList(CodecNameSpecListPtr *list, short showAll)
 TWOWORDINLINE(0x7001, 0xAAA3);
extern pascal OSErr DisposeCodecNameList(CodecNameSpecListPtr list)
 TWOWORDINLINE(0x700F, 0xAAA3);
extern pascal OSErr GetCodecInfo(CodecInfo *info, CodecType cType, CodecComponent codec)
 TWOWORDINLINE(0x7003, 0xAAA3);
extern pascal OSErr GetMaxCompressionSize(PixMapHandle src, const Rect *srcRect, short colorDepth, CodecQ quality, CodecType cType, CompressorComponent codec, long *size)
 TWOWORDINLINE(0x7004, 0xAAA3);
extern pascal OSErr GetCompressionTime(PixMapHandle src, const Rect *srcRect, short colorDepth, CodecType cType, CompressorComponent codec, CodecQ *spatialQuality, CodecQ *temporalQuality, unsigned long *compressTime)
 TWOWORDINLINE(0x7005, 0xAAA3);
extern pascal OSErr CompressImage(PixMapHandle src, const Rect *srcRect, CodecQ quality, CodecType cType, ImageDescriptionHandle desc, Ptr data)
 TWOWORDINLINE(0x7006, 0xAAA3);
extern pascal OSErr FCompressImage(PixMapHandle src, const Rect *srcRect, short colorDepth, CodecQ quality, CodecType cType, CompressorComponent codec, CTabHandle clut, CodecFlags flags, long bufferSize, ICMFlushProcRecordPtr flushProc, ICMProgressProcRecordPtr progressProc, ImageDescriptionHandle desc, Ptr data)
 TWOWORDINLINE(0x7007, 0xAAA3);
extern pascal OSErr DecompressImage(Ptr data, ImageDescriptionHandle desc, PixMapHandle dst, const Rect *srcRect, const Rect *dstRect, short mode, RgnHandle mask)
 TWOWORDINLINE(0x7008, 0xAAA3);
extern pascal OSErr FDecompressImage(Ptr data, ImageDescriptionHandle desc, PixMapHandle dst, const Rect *srcRect, MatrixRecordPtr matrix, short mode, RgnHandle mask, PixMapHandle matte, const Rect *matteRect, CodecQ accuracy, DecompressorComponent codec, long bufferSize, ICMDataProcRecordPtr dataProc, ICMProgressProcRecordPtr progressProc)
 TWOWORDINLINE(0x7009, 0xAAA3);
extern pascal OSErr CompressSequenceBegin(ImageSequence *seqID, PixMapHandle src, PixMapHandle prev, const Rect *srcRect, const Rect *prevRect, short colorDepth, CodecType cType, CompressorComponent codec, CodecQ spatialQuality, CodecQ temporalQuality, long keyFrameRate, CTabHandle clut, CodecFlags flags, ImageDescriptionHandle desc)
 TWOWORDINLINE(0x700A, 0xAAA3);
extern pascal OSErr CompressSequenceFrame(ImageSequence seqID, PixMapHandle src, const Rect *srcRect, CodecFlags flags, Ptr data, long *dataSize, unsigned char *similarity, ICMCompletionProcRecordPtr asyncCompletionProc)
 TWOWORDINLINE(0x700B, 0xAAA3);
extern pascal OSErr DecompressSequenceBegin(ImageSequence *seqID, ImageDescriptionHandle desc, CGrafPtr port, GDHandle gdh, const Rect *srcRect, MatrixRecordPtr matrix, short mode, RgnHandle mask, CodecFlags flags, CodecQ accuracy, DecompressorComponent codec)
 TWOWORDINLINE(0x700D, 0xAAA3);
extern pascal OSErr DecompressSequenceBeginS(ImageSequence *seqID, ImageDescriptionHandle desc, Ptr data, long dataSize, CGrafPtr port, GDHandle gdh, const Rect *srcRect, MatrixRecordPtr matrix, short mode, RgnHandle mask, CodecFlags flags, CodecQ accuracy, DecompressorComponent codec)
 FOURWORDINLINE(0x203C, 0x30, 0x5D, 0xAAA3);
extern pascal OSErr DecompressSequenceFrame(ImageSequence seqID, Ptr data, CodecFlags inFlags, CodecFlags *outFlags, ICMCompletionProcRecordPtr asyncCompletionProc)
 TWOWORDINLINE(0x700E, 0xAAA3);
extern pascal OSErr DecompressSequenceFrameS(ImageSequence seqID, Ptr data, long dataSize, CodecFlags inFlags, CodecFlags *outFlags, ICMCompletionProcRecordPtr asyncCompletionProc)
 FOURWORDINLINE(0x203C, 0x16, 0x47, 0xAAA3);
extern pascal OSErr SetDSequenceMatrix(ImageSequence seqID, MatrixRecordPtr matrix)
 TWOWORDINLINE(0x7010, 0xAAA3);
extern pascal OSErr SetDSequenceMatte(ImageSequence seqID, PixMapHandle matte, const Rect *matteRect)
 TWOWORDINLINE(0x7011, 0xAAA3);
extern pascal OSErr SetDSequenceMask(ImageSequence seqID, RgnHandle mask)
 TWOWORDINLINE(0x7012, 0xAAA3);
extern pascal OSErr SetDSequenceTransferMode(ImageSequence seqID, short mode, const RGBColor *opColor)
 TWOWORDINLINE(0x7013, 0xAAA3);
extern pascal OSErr SetDSequenceDataProc(ImageSequence seqID, ICMDataProcRecordPtr dataProc, long bufferSize)
 TWOWORDINLINE(0x7014, 0xAAA3);
extern pascal OSErr SetDSequenceAccuracy(ImageSequence seqID, CodecQ accuracy)
 TWOWORDINLINE(0x7034, 0xAAA3);
extern pascal OSErr SetDSequenceSrcRect(ImageSequence seqID, const Rect *srcRect)
 TWOWORDINLINE(0x7035, 0xAAA3);
extern pascal OSErr GetDSequenceImageBuffer(ImageSequence seqID, GWorldPtr *gworld)
 TWOWORDINLINE(0x7015, 0xAAA3);
extern pascal OSErr GetDSequenceScreenBuffer(ImageSequence seqID, GWorldPtr *gworld)
 TWOWORDINLINE(0x7016, 0xAAA3);
extern pascal OSErr SetCSequenceQuality(ImageSequence seqID, CodecQ spatialQuality, CodecQ temporalQuality)
 TWOWORDINLINE(0x7017, 0xAAA3);
extern pascal OSErr SetCSequencePrev(ImageSequence seqID, PixMapHandle prev, const Rect *prevRect)
 TWOWORDINLINE(0x7018, 0xAAA3);
extern pascal OSErr SetCSequenceFlushProc(ImageSequence seqID, ICMFlushProcRecordPtr flushProc, long bufferSize)
 TWOWORDINLINE(0x7033, 0xAAA3);
extern pascal OSErr SetCSequenceKeyFrameRate(ImageSequence seqID, long keyframerate)
 TWOWORDINLINE(0x7036, 0xAAA3);
extern pascal OSErr GetCSequenceKeyFrameRate(ImageSequence seqID, long *keyframerate)
 FOURWORDINLINE(0x203C, 0x8, 0x4B, 0xAAA3);
extern pascal OSErr GetCSequencePrevBuffer(ImageSequence seqID, GWorldPtr *gworld)
 TWOWORDINLINE(0x7019, 0xAAA3);
extern pascal OSErr CDSequenceBusy(ImageSequence seqID)
 TWOWORDINLINE(0x701A, 0xAAA3);
extern pascal OSErr CDSequenceEnd(ImageSequence seqID)
 TWOWORDINLINE(0x701B, 0xAAA3);
extern pascal OSErr GetCompressedImageSize(ImageDescriptionHandle desc, Ptr data, long bufferSize, ICMDataProcRecordPtr dataProc, long *dataSize)
 TWOWORDINLINE(0x701C, 0xAAA3);
extern pascal OSErr GetSimilarity(PixMapHandle src, const Rect *srcRect, ImageDescriptionHandle desc, Ptr data, Fixed *similarity)
 TWOWORDINLINE(0x701D, 0xAAA3);
extern pascal OSErr GetImageDescriptionCTable(ImageDescriptionHandle desc, CTabHandle *ctable)
 TWOWORDINLINE(0x701E, 0xAAA3);
extern pascal OSErr SetImageDescriptionCTable(ImageDescriptionHandle desc, CTabHandle ctable)
 TWOWORDINLINE(0x701F, 0xAAA3);
extern pascal OSErr GetImageDescriptionExtension(ImageDescriptionHandle desc, Handle *extension, long type, long index)
 TWOWORDINLINE(0x7020, 0xAAA3);
extern pascal OSErr SetImageDescriptionExtension(ImageDescriptionHandle desc, Handle extension, long type)
 TWOWORDINLINE(0x7021, 0xAAA3);
extern pascal OSErr RemoveImageDescriptionExtension(ImageDescription **desc, long type, long index)
 FOURWORDINLINE(0x203C, 0xC, 0x3A, 0xAAA3);
extern pascal OSErr CountImageDescriptionExtensionType(ImageDescription **desc, long type, long *count)
 FOURWORDINLINE(0x203C, 0xC, 0x3B, 0xAAA3);
extern pascal OSErr GetNextImageDescriptionExtensionType(ImageDescription **desc, long *type)
 FOURWORDINLINE(0x203C, 0x8, 0x3C, 0xAAA3);
extern pascal OSErr FindCodec(CodecType cType, CodecComponent specCodec, CompressorComponent *compressor, DecompressorComponent *decompressor)
 TWOWORDINLINE(0x7023, 0xAAA3);
extern pascal OSErr CompressPicture(PicHandle srcPicture, PicHandle dstPicture, CodecQ quality, CodecType cType)
 TWOWORDINLINE(0x7024, 0xAAA3);
extern pascal OSErr FCompressPicture(PicHandle srcPicture, PicHandle dstPicture, short colorDepth, CTabHandle clut, CodecQ quality, short doDither, short compressAgain, ICMProgressProcRecordPtr progressProc, CodecType cType, CompressorComponent codec)
 TWOWORDINLINE(0x7025, 0xAAA3);
extern pascal OSErr CompressPictureFile(short srcRefNum, short dstRefNum, CodecQ quality, CodecType cType)
 TWOWORDINLINE(0x7026, 0xAAA3);
extern pascal OSErr FCompressPictureFile(short srcRefNum, short dstRefNum, short colorDepth, CTabHandle clut, CodecQ quality, short doDither, short compressAgain, ICMProgressProcRecordPtr progressProc, CodecType cType, CompressorComponent codec)
 TWOWORDINLINE(0x7027, 0xAAA3);
extern pascal OSErr GetPictureFileHeader(short refNum, Rect *frame, OpenCPicParams *header)
 TWOWORDINLINE(0x7028, 0xAAA3);
extern pascal OSErr DrawPictureFile(short refNum, const Rect *frame, ICMProgressProcRecordPtr progressProc)
 TWOWORDINLINE(0x7029, 0xAAA3);
extern pascal OSErr DrawTrimmedPicture(PicHandle srcPicture, const Rect *frame, RgnHandle trimMask, short doDither, ICMProgressProcRecordPtr progressProc)
 TWOWORDINLINE(0x702E, 0xAAA3);
extern pascal OSErr DrawTrimmedPictureFile(short srcRefnum, const Rect *frame, RgnHandle trimMask, short doDither, ICMProgressProcRecordPtr progressProc)
 TWOWORDINLINE(0x702F, 0xAAA3);
extern pascal OSErr MakeThumbnailFromPicture(PicHandle picture, short colorDepth, PicHandle thumbnail, ICMProgressProcRecordPtr progressProc)
 TWOWORDINLINE(0x702A, 0xAAA3);
extern pascal OSErr MakeThumbnailFromPictureFile(short refNum, short colorDepth, PicHandle thumbnail, ICMProgressProcRecordPtr progressProc)
 TWOWORDINLINE(0x702B, 0xAAA3);
extern pascal OSErr MakeThumbnailFromPixMap(PixMapHandle src, const Rect *srcRect, short colorDepth, PicHandle thumbnail, ICMProgressProcRecordPtr progressProc)
 TWOWORDINLINE(0x702C, 0xAAA3);
extern pascal OSErr TrimImage(ImageDescriptionHandle desc, Ptr inData, long inBufferSize, ICMDataProcRecordPtr dataProc, Ptr outData, long outBufferSize, ICMFlushProcRecordPtr flushProc, Rect *trimRect, ICMProgressProcRecordPtr progressProc)
 TWOWORDINLINE(0x702D, 0xAAA3);
extern pascal OSErr ConvertImage(ImageDescriptionHandle srcDD, Ptr srcData, short colorDepth, CTabHandle clut, CodecQ accuracy, CodecQ quality, CodecType cType, CodecComponent codec, ImageDescriptionHandle dstDD, Ptr dstData)
 TWOWORDINLINE(0x7030, 0xAAA3);
extern pascal OSErr GetCompressedPixMapInfo(PixMapPtr pix, ImageDescriptionHandle *desc, Ptr *data, long *bufferSize, ICMDataProcRecord *dataProc, ICMProgressProcRecord *progressProc)
 TWOWORDINLINE(0x7037, 0xAAA3);
extern pascal OSErr SetCompressedPixMapInfo(PixMapPtr pix, ImageDescriptionHandle desc, Ptr data, long bufferSize, ICMDataProcRecordPtr dataProc, ICMProgressProcRecordPtr progressProc)
 TWOWORDINLINE(0x7038, 0xAAA3);
extern pascal void StdPix(PixMapPtr src, const Rect *srcRect, MatrixRecordPtr matrix, short mode, RgnHandle mask, PixMapPtr matte, const Rect *matteRect, short flags)
 TWOWORDINLINE(0x700C, 0xAAA3);
extern pascal OSErr TransformRgn(MatrixRecordPtr matrix, RgnHandle rgn)
 TWOWORDINLINE(0x7039, 0xAAA3);
extern pascal void SFGetFilePreview(Point where, ConstStr255Param prompt, FileFilterUPP fileFilter, short numTypes, SFTypeList typeList, DlgHookUPP dlgHook, SFReply *reply)
 THREEWORDINLINE(0x303C, 0x41, 0xAAA3);
extern pascal void SFPGetFilePreview(Point where, ConstStr255Param prompt, FileFilterUPP fileFilter, short numTypes, SFTypeList typeList, DlgHookUPP dlgHook, SFReply *reply, short dlgID, ModalFilterUPP filterProc)
 THREEWORDINLINE(0x303C, 0x42, 0xAAA3);
extern pascal void StandardGetFilePreview(FileFilterUPP fileFilter, short numTypes, SFTypeList typeList, StandardFileReply *reply)
 THREEWORDINLINE(0x303C, 0x43, 0xAAA3);
extern pascal void CustomGetFilePreview(FileFilterYDUPP fileFilter, short numTypes, SFTypeList typeList, StandardFileReply *reply, short dlgID, Point where, DlgHookYDUPP dlgHook, ModalFilterYDUPP filterProc, short *activeList, ActivateYDUPP activateProc, void *yourDataPtr)
 THREEWORDINLINE(0x303C, 0x44, 0xAAA3);
extern pascal OSErr MakeFilePreview(short resRefNum, ICMProgressProcRecordPtr progress)
 THREEWORDINLINE(0x303C, 0x45, 0xAAA3);
extern pascal OSErr AddFilePreview(short resRefNum, OSType previewType, Handle previewData)
 THREEWORDINLINE(0x303C, 0x46, 0xAAA3);
#ifdef __cplusplus
}
#endif

enum  {
	sfpItemPreviewAreaUser		= 11,
	sfpItemPreviewStaticText	= 12,
	sfpItemPreviewDividerUser	= 13,
	sfpItemCreatePreviewButton	= 14,
	sfpItemShowPreviewButton	= 15
};

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct PreviewResourceRecord {
	unsigned long				modDate;
	short						version;
	OSType						resType;
	short						resID;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct PreviewResourceRecord PreviewResourceRecord;

typedef PreviewResourceRecord *PreviewResourcePtr, **PreviewResource;

#ifdef __cplusplus
extern "C" {
#endif

extern pascal void AlignScreenRect(Rect *rp, ICMAlignmentProcRecordPtr alignmentProc)
 FOURWORDINLINE(0x203C, 0x8, 0x4C, 0xAAA3);
extern pascal void AlignWindow(WindowPtr wp, Boolean front, const Rect *alignmentRect, ICMAlignmentProcRecordPtr alignmentProc)
 FOURWORDINLINE(0x203C, 0xE, 0x4D, 0xAAA3);
extern pascal void DragAlignedWindow(WindowPtr wp, Point startPt, Rect *boundsRect, Rect *alignmentRect, ICMAlignmentProcRecordPtr alignmentProc)
 FOURWORDINLINE(0x203C, 0x14, 0x4E, 0xAAA3);
extern pascal long DragAlignedGrayRgn(RgnHandle theRgn, Point startPt, Rect *boundsRect, Rect *slopRect, short axis, UniversalProcPtr actionProc, Rect *alignmentRect, ICMAlignmentProcRecordPtr alignmentProc)
 FOURWORDINLINE(0x203C, 0x1E, 0x4F, 0xAAA3);
extern pascal OSErr SetCSequenceDataRateParams(ImageSequence seqID, DataRateParamsPtr params)
 FOURWORDINLINE(0x203C, 0x8, 0x50, 0xAAA3);
extern pascal OSErr SetCSequenceFrameNumber(ImageSequence seqID, long frameNumber)
 FOURWORDINLINE(0x203C, 0x8, 0x51, 0xAAA3);
extern pascal QDErr NewImageGWorld(GWorldPtr *gworld, ImageDescription **idh, GWorldFlags flags)
 FOURWORDINLINE(0x203C, 0xC, 0x52, 0xAAA3);
extern pascal OSErr GetCSequenceDataRateParams(ImageSequence seqID, DataRateParamsPtr params)
 FOURWORDINLINE(0x203C, 0x8, 0x53, 0xAAA3);
extern pascal OSErr GetCSequenceFrameNumber(ImageSequence seqID, long *frameNumber)
 FOURWORDINLINE(0x203C, 0x8, 0x54, 0xAAA3);
extern pascal OSErr GetBestDeviceRect(GDHandle *gdh, Rect *rp)
 FOURWORDINLINE(0x203C, 0x8, 0x55, 0xAAA3);
extern pascal OSErr SetSequenceProgressProc(ImageSequence seqID, ICMProgressProcRecord *progressProc)
 FOURWORDINLINE(0x203C, 0x8, 0x56, 0xAAA3);
extern pascal OSErr GDHasScale(GDHandle gdh, short depth, Fixed *scale)
 FOURWORDINLINE(0x203C, 0xA, 0x5A, 0xAAA3);
extern pascal OSErr GDGetScale(GDHandle gdh, Fixed *scale, short *flags)
 FOURWORDINLINE(0x203C, 0xC, 0x5B, 0xAAA3);
extern pascal OSErr GDSetScale(GDHandle gdh, Fixed scale, short flags)
 FOURWORDINLINE(0x203C, 0xA, 0x5C, 0xAAA3);
#ifdef __cplusplus
}
#endif

enum  {
	identityMatrixType			= 0x00,
	translateMatrixType			= 0x01,
	scaleMatrixType				= 0x02,
	scaleTranslateMatrixType	= 0x03,
	linearMatrixType			= 0x04,
	linearTranslateMatrixType	= 0x05,
	perspectiveMatrixType		= 0x06
};

typedef unsigned short MatrixFlags;

#ifdef __cplusplus
extern "C" {
#endif

extern pascal short GetMatrixType(MatrixRecord *m)
 TWOWORDINLINE(0x7014, 0xABC2);
extern pascal void CopyMatrix(MatrixRecord *m1, MatrixRecord *m2)
 TWOWORDINLINE(0x7020, 0xABC2);
extern pascal Boolean EqualMatrix(const MatrixRecord *m1, const MatrixRecord *m2)
 TWOWORDINLINE(0x7021, 0xABC2);
extern pascal void SetIdentityMatrix(MatrixRecord *matrix)
 TWOWORDINLINE(0x7015, 0xABC2);
extern pascal void TranslateMatrix(MatrixRecord *m, Fixed deltaH, Fixed deltaV)
 TWOWORDINLINE(0x7019, 0xABC2);
extern pascal void RotateMatrix(MatrixRecord *m, Fixed degrees, Fixed aboutX, Fixed aboutY)
 TWOWORDINLINE(0x7016, 0xABC2);
extern pascal void ScaleMatrix(MatrixRecord *m, Fixed scaleX, Fixed scaleY, Fixed aboutX, Fixed aboutY)
 TWOWORDINLINE(0x7017, 0xABC2);
extern pascal void SkewMatrix(MatrixRecord *m, Fixed skewX, Fixed skewY, Fixed aboutX, Fixed aboutY)
 TWOWORDINLINE(0x7018, 0xABC2);
extern pascal OSErr TransformFixedPoints(MatrixRecord *m, FixedPoint *fpt, long count)
 TWOWORDINLINE(0x7022, 0xABC2);
extern pascal OSErr TransformPoints(MatrixRecord *mp, Point *pt1, long count)
 TWOWORDINLINE(0x7023, 0xABC2);
extern pascal Boolean TransformFixedRect(MatrixRecord *m, FixedRect *fr, FixedPoint *fpp)
 TWOWORDINLINE(0x7024, 0xABC2);
extern pascal Boolean TransformRect(MatrixRecord *m, Rect *r, FixedPoint *fpp)
 TWOWORDINLINE(0x7025, 0xABC2);
extern pascal Boolean InverseMatrix(MatrixRecord *m, MatrixRecord *im)
 TWOWORDINLINE(0x701C, 0xABC2);
extern pascal void ConcatMatrix(MatrixRecord *a, MatrixRecord *b)
 TWOWORDINLINE(0x701B, 0xABC2);
extern pascal void RectMatrix(MatrixRecord *matrix, Rect *srcRect, Rect *dstRect)
 TWOWORDINLINE(0x701E, 0xABC2);
extern pascal void MapMatrix(MatrixRecord *matrix, Rect *fromRect, Rect *toRect)
 TWOWORDINLINE(0x701D, 0xABC2);
#ifdef __cplusplus
}
#endif

#endif


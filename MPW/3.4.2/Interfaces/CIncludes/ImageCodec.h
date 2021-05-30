/*
 	File:		ImageCodec.h
 
 	Contains:	QuickTime interfaces
 
 	Version:	Technology:	Technology:	QuickTime 2.5
 				Package:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/
#ifndef __IMAGECODEC__
#define __IMAGECODEC__

#ifndef __TYPES__
#include <Types.h>
#endif
#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
#ifndef __QDOFFSCREEN__
#include <QDOffscreen.h>
#endif
#ifndef __WINDOWS__
#include <Windows.h>
#endif
#ifndef __IMAGECOMPRESSION__
#include <ImageCompression.h>
#endif
#ifndef __COMPONENTS__
#include <Components.h>
#endif
#ifndef __MOVIES__
#include <Movies.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

/*	codec capabilities flags	*/

enum {
	codecCanScale				= 1L << 0,
	codecCanMask				= 1L << 1,
	codecCanMatte				= 1L << 2,
	codecCanTransform			= 1L << 3,
	codecCanTransferMode		= 1L << 4,
	codecCanCopyPrev			= 1L << 5,
	codecCanSpool				= 1L << 6,
	codecCanClipVertical		= 1L << 7,
	codecCanClipRectangular		= 1L << 8,
	codecCanRemapColor			= 1L << 9,
	codecCanFastDither			= 1L << 10,
	codecCanSrcExtract			= 1L << 11,
	codecCanCopyPrevComp		= 1L << 12,
	codecCanAsync				= 1L << 13,
	codecCanMakeMask			= 1L << 14,
	codecCanShift				= 1L << 15,
	codecCanAsyncWhen			= 1L << 16,
	codecCanShieldCursor		= 1L << 17,
	codecCanManagePrevBuffer	= 1L << 18,
	codecHasVolatileBuffer		= 1L << 19,
	codecWantsRegionMask		= 1L << 20,
	codecImageBufferIsOnScreen	= 1L << 21,
	codecWantsDestinationPixels	= 1L << 22
};

struct CodecCapabilities {
	long 							flags;
	short 							wantedPixelSize;
	short 							extendWidth;
	short 							extendHeight;
	short 							bandMin;
	short 							bandInc;
	short 							pad;
	unsigned long 					time;
};
typedef struct CodecCapabilities CodecCapabilities;

/*	codec condition flags	*/

enum {
	codecConditionFirstBand		= 1L << 0,
	codecConditionLastBand		= 1L << 1,
	codecConditionFirstFrame	= 1L << 2,
	codecConditionNewDepth		= 1L << 3,
	codecConditionNewTransform	= 1L << 4,
	codecConditionNewSrcRect	= 1L << 5,
	codecConditionNewMask		= 1L << 6,
	codecConditionNewMatte		= 1L << 7,
	codecConditionNewTransferMode = 1L << 8,
	codecConditionNewClut		= 1L << 9,
	codecConditionNewAccuracy	= 1L << 10,
	codecConditionNewDestination = 1L << 11,
	codecConditionFirstScreen	= 1L << 12,
	codecConditionDoCursor		= 1L << 13,
	codecConditionCatchUpDiff	= 1L << 14,
	codecConditionMaskMayBeChanged = 1L << 15,
	codecConditionToBuffer		= 1L << 16,
	codecConditionCodecChangedMask = 1L << 31
};


enum {
	codecInfoResourceType		= 'cdci',						/* codec info resource type */
	codecInterfaceVersion		= 2								/* high word returned in component GetVersion */
};

struct CDSequenceDataSource {
	long 							recordSize;

	void *							next;

	ImageSequence 					seqID;
	ImageSequenceDataSource 		sourceID;
	OSType 							sourceType;
	long 							sourceInputNumber;
	void *							dataPtr;
	Handle 							dataDescription;
	long 							changeSeed;
	ICMConvertDataFormatUPP 		transferProc;
	void *							transferRefcon;
																/* The following fields only exist for QuickTime 2.5 and greater */
	long 							dataSize;
};
typedef struct CDSequenceDataSource CDSequenceDataSource;

typedef CDSequenceDataSource *CDSequenceDataSourcePtr;
struct CodecCompressParams {
	ImageSequence 					sequenceID;					/* precompress,bandcompress */
	ImageDescriptionHandle 			imageDescription;			/* precompress,bandcompress */
	Ptr 							data;
	long 							bufferSize;
	long 							frameNumber;
	long 							startLine;
	long 							stopLine;
	long 							conditionFlags;
	CodecFlags 						callerFlags;
	CodecCapabilities *				capabilities;				/* precompress,bandcompress */
	ICMProgressProcRecord 			progressProcRecord;
	ICMCompletionProcRecord 		completionProcRecord;
	ICMFlushProcRecord 				flushProcRecord;

	PixMap 							srcPixMap;					/* precompress,bandcompress */
	PixMap 							prevPixMap;
	CodecQ 							spatialQuality;
	CodecQ 							temporalQuality;
	Fixed 							similarity;
	DataRateParamsPtr 				dataRateParams;
	long 							reserved;

																/* The following fields only exist for QuickTime 2.1 and greater */
	UInt16 							majorSourceChangeSeed;
	UInt16 							minorSourceChangeSeed;
	CDSequenceDataSourcePtr 		sourceData;

																/* The following fields only exit for QuickTime 2.5 and greater */
	long 							preferredPacketSizeInBytes;
};
typedef struct CodecCompressParams CodecCompressParams;

struct CodecDecompressParams {
	ImageSequence 					sequenceID;					/* predecompress,banddecompress */
	ImageDescriptionHandle 			imageDescription;			/* predecompress,banddecompress */
	Ptr 							data;
	long 							bufferSize;
	long 							frameNumber;
	long 							startLine;
	long 							stopLine;
	long 							conditionFlags;
	CodecFlags 						callerFlags;
	CodecCapabilities *				capabilities;				/* predecompress,banddecompress */
	ICMProgressProcRecord 			progressProcRecord;
	ICMCompletionProcRecord 		completionProcRecord;
	ICMDataProcRecord 				dataProcRecord;

	CGrafPtr 						port;						/* predecompress,banddecompress */
	PixMap 							dstPixMap;					/* predecompress,banddecompress */
	BitMapPtr 						maskBits;
	PixMapPtr 						mattePixMap;
	Rect 							srcRect;					/* predecompress,banddecompress */
	MatrixRecord *					matrix;						/* predecompress,banddecompress */
	CodecQ 							accuracy;					/* predecompress,banddecompress */
	short 							transferMode;				/* predecompress,banddecompress */
	ICMFrameTimePtr 				frameTime;					/* banddecompress */
	long 							reserved[1];
																/* The following fields only exist for QuickTime 2.0 and greater */
	SInt8 							matrixFlags;				/* high bit set if 2x resize */
	SInt8 							matrixType;
	Rect 							dstRect;					/* only valid for simple transforms */
																/* The following fields only exist for QuickTime 2.1 and greater */
	UInt16 							majorSourceChangeSeed;
	UInt16 							minorSourceChangeSeed;
	CDSequenceDataSourcePtr 		sourceData;

	RgnHandle 						maskRegion;

																/* The following fields only exist for QuickTime 2.5 and greater */

	OSType **						wantedDestinationPixelTypes; /* Handle to 0-terminated list of OSTypes */

	long 							screenFloodMethod;
	long 							screenFloodValue;
	short 							preferredOffscreenPixelSize;
};
typedef struct CodecDecompressParams CodecDecompressParams;


enum {
	matrixFlagScale2x			= 1L << 7,
	matrixFlagScale1x			= 1L << 6,
	matrixFlagScaleHalf			= 1L << 5
};


enum {
	kScreenFloodMethodNone		= 0,
	kScreenFloodMethodKeyColor	= 1,
	kScreenFloodMethodAlpha		= 2
};

/*	codec selectors 0-127 are reserved by Apple */
/*	codec selectors 128-191 are subtype specific */
/*	codec selectors 192-255 are vendor specific */
/*	codec selectors 256-32767 are available for general use */
/*	negative selectors are reserved by the Component Manager */
extern pascal ComponentResult ImageCodecGetCodecInfo(ComponentInstance ci, CodecInfo *info)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0000, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecGetCompressionTime(ComponentInstance ci, PixMapHandle src, const Rect *srcRect, short depth, CodecQ *spatialQuality, CodecQ *temporalQuality, unsigned long *time)
 FIVEWORDINLINE(0x2F3C, 0x0016, 0x0001, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecGetMaxCompressionSize(ComponentInstance ci, PixMapHandle src, const Rect *srcRect, short depth, CodecQ quality, long *size)
 FIVEWORDINLINE(0x2F3C, 0x0012, 0x0002, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecPreCompress(ComponentInstance ci, CodecCompressParams *params)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0003, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecBandCompress(ComponentInstance ci, CodecCompressParams *params)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0004, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecPreDecompress(ComponentInstance ci, CodecDecompressParams *params)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0005, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecBandDecompress(ComponentInstance ci, CodecDecompressParams *params)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0006, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecBusy(ComponentInstance ci, ImageSequence seq)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0007, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecGetCompressedImageSize(ComponentInstance ci, ImageDescriptionHandle desc, Ptr data, long bufferSize, ICMDataProcRecordPtr dataProc, long *dataSize)
 FIVEWORDINLINE(0x2F3C, 0x0014, 0x0008, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecGetSimilarity(ComponentInstance ci, PixMapHandle src, const Rect *srcRect, ImageDescriptionHandle desc, Ptr data, Fixed *similarity)
 FIVEWORDINLINE(0x2F3C, 0x0014, 0x0009, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecTrimImage(ComponentInstance ci, ImageDescriptionHandle Desc, Ptr inData, long inBufferSize, ICMDataProcRecordPtr dataProc, Ptr outData, long outBufferSize, ICMFlushProcRecordPtr flushProc, Rect *trimRect, ICMProgressProcRecordPtr progressProc)
 FIVEWORDINLINE(0x2F3C, 0x0024, 0x000A, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecRequestSettings(ComponentInstance ci, Handle settings, Rect *rp, ModalFilterUPP filterProc)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x000B, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecGetSettings(ComponentInstance ci, Handle settings)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000C, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecSetSettings(ComponentInstance ci, Handle settings)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x000D, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecFlush(ComponentInstance ci)
 FIVEWORDINLINE(0x2F3C, 0x0000, 0x000E, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecSetTimeCode(ComponentInstance ci, void *timeCodeFormat, void *timeCodeTime)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x000F, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecIsImageDescriptionEquivalent(ComponentInstance ci, ImageDescriptionHandle newDesc, Boolean *equivalent)
 FIVEWORDINLINE(0x2F3C, 0x0008, 0x0010, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecNewMemory(ComponentInstance ci, Ptr *data, Size dataSize, long dataUse, ICMMemoryDisposedUPP memoryGoneProc, void *refCon)
 FIVEWORDINLINE(0x2F3C, 0x0014, 0x0011, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecDisposeMemory(ComponentInstance ci, Ptr data)
 FIVEWORDINLINE(0x2F3C, 0x0004, 0x0012, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecHitTestData(ComponentInstance ci, ImageDescriptionHandle desc, void *data, Size dataSize, Point where, Boolean *hit)
 FIVEWORDINLINE(0x2F3C, 0x0014, 0x0013, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecNewImageBufferMemory(ComponentInstance ci, CodecDecompressParams *params, long flags, ICMMemoryDisposedUPP memoryGoneProc, void *refCon)
 FIVEWORDINLINE(0x2F3C, 0x0010, 0x0014, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecExtractAndCombineFields(ComponentInstance ci, long fieldFlags, void *data1, long dataSize1, ImageDescriptionHandle desc1, void *data2, long dataSize2, ImageDescriptionHandle desc2, void *outputData, long *outDataSize, ImageDescriptionHandle descOut)
 FIVEWORDINLINE(0x2F3C, 0x0028, 0x0015, 0x7000, 0xA82A);

extern pascal ComponentResult ImageCodecGetMaxCompressionSizeWithSources(ComponentInstance ci, PixMapHandle src, const Rect *srcRect, short depth, CodecQ quality, CDSequenceDataSourcePtr sourceData, long *size)
 FIVEWORDINLINE(0x2F3C, 0x0016, 0x0016, 0x7000, 0xA82A);


/* selectors for component calls */
enum {
	kImageCodecGetCodecInfoSelect					= 0x0000,
	kImageCodecGetCompressionTimeSelect				= 0x0001,
	kImageCodecGetMaxCompressionSizeSelect			= 0x0002,
	kImageCodecPreCompressSelect					= 0x0003,
	kImageCodecBandCompressSelect					= 0x0004,
	kImageCodecPreDecompressSelect					= 0x0005,
	kImageCodecBandDecompressSelect					= 0x0006,
	kImageCodecBusySelect							= 0x0007,
	kImageCodecGetCompressedImageSizeSelect			= 0x0008,
	kImageCodecGetSimilaritySelect					= 0x0009,
	kImageCodecTrimImageSelect						= 0x000A,
	kImageCodecRequestSettingsSelect				= 0x000B,
	kImageCodecGetSettingsSelect					= 0x000C,
	kImageCodecSetSettingsSelect					= 0x000D,
	kImageCodecFlushSelect							= 0x000E,
	kImageCodecSetTimeCodeSelect					= 0x000F,
	kImageCodecIsImageDescriptionEquivalentSelect	= 0x0010,
	kImageCodecNewMemorySelect						= 0x0011,
	kImageCodecDisposeMemorySelect					= 0x0012,
	kImageCodecHitTestDataSelect					= 0x0013,
	kImageCodecNewImageBufferMemorySelect			= 0x0014,
	kImageCodecExtractAndCombineFieldsSelect		= 0x0015,
	kImageCodecGetMaxCompressionSizeWithSourcesSelect = 0x0016
};

enum {
	kMotionJPEGTag				= 'mjpg'
};

struct MotionJPEGApp1Marker {
	long 							unused;
	long 							tag;
	long 							fieldSize;
	long 							paddedFieldSize;
	long 							offsetToNextField;
	long 							qTableOffset;
	long 							huffmanTableOffset;
	long 							sofOffset;
	long 							sosOffset;
	long 							soiOffset;
};
typedef struct MotionJPEGApp1Marker MotionJPEGApp1Marker;

extern pascal ComponentResult QTPhotoSetSampling(ComponentInstance codec, short yH, short yV, short cbH, short cbV, short crH, short crV)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0100, 0x7000, 0xA82A);

extern pascal ComponentResult QTPhotoSetRestartInterval(ComponentInstance codec, unsigned short restartInterval)
 FIVEWORDINLINE(0x2F3C, 0x0002, 0x0101, 0x7000, 0xA82A);

extern pascal ComponentResult QTPhotoDefineHuffmanTable(ComponentInstance codec, short componentNumber, Boolean isDC, unsigned char *lengthCounts, unsigned char *values)
 FIVEWORDINLINE(0x2F3C, 0x000C, 0x0102, 0x7000, 0xA82A);

extern pascal ComponentResult QTPhotoDefineQuantizationTable(ComponentInstance codec, short componentNumber, unsigned char *table)
 FIVEWORDINLINE(0x2F3C, 0x0006, 0x0103, 0x7000, 0xA82A);


/* selectors for component calls */
enum {
	kQTPhotoSetSamplingSelect						= 0x0100,
	kQTPhotoSetRestartIntervalSelect				= 0x0101,
	kQTPhotoDefineHuffmanTableSelect				= 0x0102,
	kQTPhotoDefineQuantizationTableSelect			= 0x0103
};

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#ifdef __cplusplus
}
#endif

#endif /* __IMAGECODEC__ */


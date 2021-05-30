/************************************************************

Created: Wednesday, October 21, 1992 at 2:55 PM
 ImageCodec.h
 C Interface to the Macintosh Libraries


 Copyright Apple Computer, Inc. 1991, 1992
 All rights reserved

************************************************************/

#ifndef	__IMAGECODEC__

#define	__IMAGECODEC__

#ifndef __QUICKDRAW__
#include <QuickDraw.h>
#endif

#ifndef __QDOFFSCREEN__
#include <QDOffscreen.h>
#endif

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __COMPONENTS__
#include <Components.h>
#endif

#ifndef	__IMAGECOMPRESSION__
#include <ImageCompression.h>
#endif




/*	codec component selectors	*/

#define	codecGetCodecInfo					0x00
#define	codecGetCompressionTime				0x01
#define	codecGetMaxCompressionSize			0x02
#define	codecPreCompress					0x03
#define	codecBandCompress					0x04
#define	codecPreDecompress					0x05
#define	codecBandDecompress					0x06
#define	codecCDSequenceBusy					0x07
#define	codecGetCompressedImageSize			0x08
#define	codecGetSimilarity					0x09
#define	codecTrimImage						0x0a

/*	codec selectors 0-127 are reserved by Apple */
/*	codec selectors 128-191 are subtype specific */
/*	codec selectors 192-255 are vendor specific */
/*	codec selectors 256-32767 are available for general use */
/*	negative selectors are reserved by the Component Manager */



/*	codec capabilities flags	*/

#define	codecCanScale						(1L<<0)
#define	codecCanMask						(1L<<1)
#define	codecCanMatte						(1L<<2)
#define	codecCanTransform					(1L<<3)
#define	codecCanTransferMode				(1L<<4)
#define	codecCanCopyPrev					(1L<<5)
#define	codecCanSpool						(1L<<6)
#define	codecCanClipVertical				(1L<<7)
#define	codecCanClipRectangular				(1L<<8)
#define	codecCanRemapColor					(1L<<9)
#define	codecCanFastDither					(1L<<10)
#define	codecCanSrcExtract					(1L<<11)
#define	codecCanCopyPrevComp				(1L<<12)
#define	codecCanAsync						(1L<<13)
#define	codecCanMakeMask					(1L<<14)
#define codecCanShift						(1L<<15)


typedef	struct {
	long	flags;
	short	wantedPixelSize;
	short	extendWidth;
	short	extendHeight;
	short	bandMin;
	short	bandInc;
	short	pad;
	unsigned long	time;
} CodecCapabilities;



/*	codec condition flags	*/

#define	codecConditionFirstBand				(1L<<0)	
#define	codecConditionLastBand				(1L<<1)	
#define	codecConditionFirstFrame			(1L<<2)
#define	codecConditionNewDepth				(1L<<3)
#define	codecConditionNewTransform			(1L<<4)
#define	codecConditionNewSrcRect			(1L<<5)
#define	codecConditionNewMask				(1L<<6)
#define	codecConditionNewMatte				(1L<<7)
#define	codecConditionNewTransferMode		(1L<<8)
#define	codecConditionNewClut				(1L<<9)
#define	codecConditionNewAccuracy			(1L<<10)
#define	codecConditionNewDestination		(1L<<11)
#define	codecConditionCodecChangedMask		(1L<<31)	


#define	codecInfoResourceType		'cdci'			/* codec info resource type */

#define	codecInterfaceVersion		1				/* high word returned in component GetVersion */


typedef	struct {	
	ImageSequence 			sequenceID;				/* precompress,bandcompress */
	ImageDescriptionHandle 	imageDescription;		/* precompress,bandcompress */
	Ptr 					data;
	long 					bufferSize;
	long 					frameNumber;
	long 					startLine;
	long 					stopLine;
	long					conditionFlags;
	CodecFlags 				callerFlags;
	CodecCapabilities		*capabilities;			/* precompress,bandcompress */
	ProgressProcRecord		progressProcRecord;
	CompletionProcRecord	completionProcRecord;	
	FlushProcRecord 		flushProcRecord;

	PixMap 					srcPixMap;				/* precompress,bandcompress */
	PixMap 					prevPixMap;
	CodecQ 					spatialQuality;
	CodecQ 					temporalQuality;
	Fixed		 			similarity;
	DataRateParamsPtr		dataRateParams;
	long					reserved;
} CodecCompressParams;

typedef	struct {	
	ImageSequence 			sequenceID;				/* predecompress,banddecompress */
	ImageDescriptionHandle 	imageDescription;		/* predecompress,banddecompress */
	Ptr 					data;
	long 					bufferSize;
	long 					frameNumber;
	long 					startLine;
	long 					stopLine;
	long					conditionFlags;
	CodecFlags 				callerFlags;
	CodecCapabilities 		*capabilities;			/* predecompress,banddecompress */
	ProgressProcRecord		progressProcRecord;
	CompletionProcRecord	completionProcRecord;
	DataProcRecord			dataProcRecord;

	CGrafPtr 				port;					/* predecompress,banddecompress */
	PixMap 					dstPixMap;				/* predecompress,banddecompress */
	BitMapPtr 				maskBits;
	PixMapPtr 				mattePixMap;
	Rect 					srcRect;				/* predecompress,banddecompress */
	MatrixRecord	 		*matrix;				/* predecompress,banddecompress */
	CodecQ 					accuracy;				/* predecompress,banddecompress */
	short 					transferMode;			/* predecompress,banddecompress */
	long					reserved[2];
} CodecDecompressParams;



#define	PREAMBLE	Handle	storage

pascal ComponentResult
CDGetCodecInfo(PREAMBLE,CodecInfo *info)
;

pascal ComponentResult
CDGetCompressionTime(PREAMBLE,PixMapHandle src,Rect *srcRect, short depth,CodecQ *spatialQuality,
	CodecQ *temporalQuality,unsigned long *time)
;

pascal ComponentResult
CDGetMaxCompressionSize(PREAMBLE,PixMapHandle src,Rect *srcRect, short depth,CodecQ quality,long *size)
;


pascal ComponentResult
CDPreCompress(PREAMBLE,CodecCompressParams *params)
;

pascal ComponentResult
CDBandCompress(PREAMBLE,CodecCompressParams *params)
;

pascal ComponentResult
CDPreDecompress(PREAMBLE,CodecDecompressParams *params)
;

pascal ComponentResult
CDBandDecompress(PREAMBLE,CodecDecompressParams *params)
;

pascal ComponentResult
CDCodecBusy(PREAMBLE,ImageSequence seq)
;


pascal ComponentResult
CDGetCompressedImageSize(PREAMBLE,ImageDescriptionHandle desc,Ptr data,long bufferSize, 
	DataProcRecordPtr dataProc,long *dataSize)
;

pascal ComponentResult
CDGetSimilarity(PREAMBLE,PixMapHandle src,Rect *srcRect,ImageDescriptionHandle desc,Ptr data,Fixed *similarity)
;

pascal ComponentResult
CDTrimImage(PREAMBLE,ImageDescriptionHandle Desc,Ptr inData,long inBufferSize, DataProcRecordPtr dataProc,
	Ptr outData,long outBufferSize,FlushProcRecordPtr flushProc,Rect *trimRect,ProgressProcRecordPtr progressProc)
;


#endif	__IMAGECODEC__

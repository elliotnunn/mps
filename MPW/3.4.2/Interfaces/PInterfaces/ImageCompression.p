{
 	File:		ImageCompression.p
 
 	Contains:	QuickTime Image Compression Interfaces.
 
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
 UNIT ImageCompression;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __IMAGECOMPRESSION__}
{$SETC __IMAGECOMPRESSION__ := 1}

{$I+}
{$SETC ImageCompressionIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __QDOFFSCREEN__}
{$I QDOffscreen.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
{$ENDC}
{$IFC UNDEFINED __STANDARDFILE__}
{$I StandardFile.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

TYPE
	MatrixRecordPtr = ^MatrixRecord;
	MatrixRecord = RECORD
		matrix:					ARRAY [0..2,0..2] OF Fixed;
	END;

	FixedPointPtr = ^FixedPoint;
	FixedPoint = RECORD
		x:						Fixed;
		y:						Fixed;
	END;

	FixedRectPtr = ^FixedRect;
	FixedRect = RECORD
		left:					Fixed;
		top:					Fixed;
		right:					Fixed;
		bottom:					Fixed;
	END;


CONST
	kRawCodecType				= 'raw ';
	kCinepakCodecType			= 'cvid';
	kGraphicsCodecType			= 'smc ';
	kAnimationCodecType			= 'rle ';
	kVideoCodecType				= 'rpza';
	kComponentVideoCodecType	= 'yuv2';
	kJPEGCodecType				= 'jpeg';
	kMotionJPEGACodecType		= 'mjpa';
	kMotionJPEGBCodecType		= 'mjpb';
	kSGICodecType				= '.SGI';
	kPlanarRGBCodecType			= '8BPS';
	kMacPaintCodecType			= 'PNTG';
	kGIFCodecType				= 'gif ';
	kPhotoCDCodecType			= 'kpcd';
	kQuickDrawGXCodecType		= 'qdgx';

{  These are the bits that are set in the Component flags, and also in the codecInfo struct.  }
	codecInfoDoes1				= $00000001;
	codecInfoDoes2				= $00000002;
	codecInfoDoes4				= $00000004;
	codecInfoDoes8				= $00000008;
	codecInfoDoes16				= $00000010;
	codecInfoDoes32				= $00000020;
	codecInfoDoesDither			= $00000040;
	codecInfoDoesStretch		= $00000080;
	codecInfoDoesShrink			= $00000100;
	codecInfoDoesMask			= $00000200;
	codecInfoDoesTemporal		= $00000400;
	codecInfoDoesDouble			= $00000800;
	codecInfoDoesQuad			= $00001000;
	codecInfoDoesHalf			= $00002000;
	codecInfoDoesQuarter		= $00004000;
	codecInfoDoesRotate			= $00008000;
	codecInfoDoesHorizFlip		= $00010000;
	codecInfoDoesVertFlip		= $00020000;
	codecInfoDoesSkew			= $00040000;
	codecInfoDoesBlend			= $00080000;
	codecInfoDoesWarp			= $00100000;
	codecInfoDoesRecompress		= $00200000;
	codecInfoDoesSpool			= $00400000;
	codecInfoDoesRateConstrain	= $00800000;

	codecInfoDepth1				= $00000001;
	codecInfoDepth2				= $00000002;
	codecInfoDepth4				= $00000004;
	codecInfoDepth8				= $00000008;
	codecInfoDepth16			= $00000010;
	codecInfoDepth32			= $00000020;
	codecInfoDepth24			= $00000040;
	codecInfoDepth33			= $00000080;
	codecInfoDepth34			= $00000100;
	codecInfoDepth36			= $00000200;
	codecInfoDepth40			= $00000400;
	codecInfoStoresClut			= $00000800;
	codecInfoDoesLossless		= $00001000;
	codecInfoSequenceSensitive	= $00002000;

	codecFlagUseImageBuffer		= $00000001;
	codecFlagUseScreenBuffer	= $00000002;
	codecFlagUpdatePrevious		= $00000004;
	codecFlagNoScreenUpdate		= $00000008;
	codecFlagWasCompressed		= $00000010;
	codecFlagDontOffscreen		= $00000020;
	codecFlagUpdatePreviousComp	= $00000040;
	codecFlagForceKeyFrame		= $00000080;
	codecFlagOnlyScreenUpdate	= $00000100;
	codecFlagLiveGrab			= $00000200;
	codecFlagDontUseNewImageBuffer = $00000400;
	codecFlagInterlaceUpdate	= $00000800;
	codecFlagCatchUpDiff		= $00001000;
	codecFlagImageBufferNotSourceImage = $00002000;
	codecFlagUsedNewImageBuffer	= $00004000;
	codecFlagUsedImageBuffer	= $00008000;

																{  The minimum data size for spooling in or out data  }
	codecMinimumDataSize		= 32768;

	compressorComponentType		= 'imco';						{  the type for "Components" which compress images  }
	decompressorComponentType	= 'imdc';						{  the type for "Components" which decompress images  }


TYPE
	CompressorComponent					= Component;
	DecompressorComponent				= Component;
	CodecComponent						= Component;

CONST
	anyCodec					= 0;							{  take first working codec of given type  }
	bestSpeedCodec				= -1;							{  take fastest codec of given type  }
	bestFidelityCodec			= -2;							{  take codec which is most accurate  }
	bestCompressionCodec		= -3;							{  take codec of given type that is most accurate  }


TYPE
	CodecType							= LONGINT;
	CodecFlags							= INTEGER;
	CodecQ								= LONGINT;

CONST
	codecLosslessQuality		= $00000400;
	codecMaxQuality				= $000003FF;
	codecMinQuality				= $00000000;
	codecLowQuality				= $00000100;
	codecNormalQuality			= $00000200;
	codecHighQuality			= $00000300;

	codecCompletionSource		= $01;							{  asynchronous codec is done with source data  }
	codecCompletionDest			= $02;							{  asynchronous codec is done with destination data  }
	codecCompletionDontUnshield	= $04;							{  on dest complete don't unshield cursor  }

	codecProgressOpen			= 0;
	codecProgressUpdatePercent	= 1;
	codecProgressClose			= 2;


TYPE
	ICMDataProcPtr = ProcPtr;  { FUNCTION ICMData(VAR dataP: Ptr; bytesNeeded: LONGINT; refcon: LONGINT): OSErr; }

	ICMFlushProcPtr = ProcPtr;  { FUNCTION ICMFlush(data: Ptr; bytesAdded: LONGINT; refcon: LONGINT): OSErr; }

	ICMCompletionProcPtr = ProcPtr;  { PROCEDURE ICMCompletion(result: OSErr; flags: INTEGER; refcon: LONGINT); }

	ICMProgressProcPtr = ProcPtr;  { FUNCTION ICMProgress(message: INTEGER; completeness: Fixed; refcon: LONGINT): OSErr; }

	StdPixProcPtr = ProcPtr;  { PROCEDURE StdPix(VAR src: PixMap; VAR srcRect: Rect; VAR matrix: MatrixRecord; mode: INTEGER; mask: RgnHandle; VAR matte: PixMap; VAR matteRect: Rect; flags: INTEGER); }

	ICMAlignmentProcPtr = ProcPtr;  { PROCEDURE ICMAlignment(VAR rp: Rect; refcon: LONGINT); }

	ICMCursorShieldedProcPtr = ProcPtr;  { PROCEDURE ICMCursorShielded((CONST)VAR r: Rect; refcon: UNIV Ptr; flags: LONGINT); }

	ICMMemoryDisposedProcPtr = ProcPtr;  { PROCEDURE ICMMemoryDisposed(memoryBlock: Ptr; refcon: UNIV Ptr); }

	ICMCursorNotify						= Ptr;
	ICMConvertDataFormatProcPtr = ProcPtr;  { FUNCTION ICMConvertDataFormat(refCon: UNIV Ptr; flags: LONGINT; desiredFormat: Handle; srcData: UNIV Ptr; srcDataSize: LONGINT; VAR dstData: UNIV Ptr; VAR dstDataSize: LONGINT): OSErr; }

	ICMDataUPP = UniversalProcPtr;
	ICMFlushUPP = UniversalProcPtr;
	ICMCompletionUPP = UniversalProcPtr;
	ICMProgressUPP = UniversalProcPtr;
	StdPixUPP = UniversalProcPtr;
	ICMAlignmentUPP = UniversalProcPtr;
	ICMCursorShieldedUPP = UniversalProcPtr;
	ICMMemoryDisposedUPP = UniversalProcPtr;
	ICMConvertDataFormatUPP = UniversalProcPtr;
	ImageSequence						= LONGINT;
	ImageSequenceDataSource				= LONGINT;
	ImageTranscodeSequence				= LONGINT;
	ImageFieldSequence					= LONGINT;
	ICMProgressProcRecordPtr = ^ICMProgressProcRecord;
	ICMProgressProcRecord = RECORD
		progressProc:			ICMProgressUPP;
		progressRefCon:			LONGINT;
	END;

	ICMCompletionProcRecordPtr = ^ICMCompletionProcRecord;
	ICMCompletionProcRecord = RECORD
		completionProc:			ICMCompletionUPP;
		completionRefCon:		LONGINT;
	END;

	ICMDataProcRecordPtr = ^ICMDataProcRecord;
	ICMDataProcRecord = RECORD
		dataProc:				ICMDataUPP;
		dataRefCon:				LONGINT;
	END;

	ICMFlushProcRecordPtr = ^ICMFlushProcRecord;
	ICMFlushProcRecord = RECORD
		flushProc:				ICMFlushUPP;
		flushRefCon:			LONGINT;
	END;

	ICMAlignmentProcRecordPtr = ^ICMAlignmentProcRecord;
	ICMAlignmentProcRecord = RECORD
		alignmentProc:			ICMAlignmentUPP;
		alignmentRefCon:		LONGINT;
	END;

	DataRateParamsPtr = ^DataRateParams;
	DataRateParams = RECORD
		dataRate:				LONGINT;
		dataOverrun:			LONGINT;
		frameDuration:			LONGINT;
		keyFrameRate:			LONGINT;
		minSpatialQuality:		CodecQ;
		minTemporalQuality:		CodecQ;
	END;

	ImageDescriptionPtr = ^ImageDescription;
	ImageDescription = PACKED RECORD
		idSize:					LONGINT;								{  total size of ImageDescription including extra data ( CLUTs and other per sequence data )  }
		cType:					CodecType;								{  what kind of codec compressed this data  }
		resvd1:					LONGINT;								{  reserved for Apple use  }
		resvd2:					INTEGER;								{  reserved for Apple use  }
		dataRefIndex:			INTEGER;								{  set to zero   }
		version:				INTEGER;								{  which version is this data  }
		revisionLevel:			INTEGER;								{  what version of that codec did this  }
		vendor:					LONGINT;								{  whose  codec compressed this data  }
		temporalQuality:		CodecQ;									{  what was the temporal quality factor   }
		spatialQuality:			CodecQ;									{  what was the spatial quality factor  }
		width:					INTEGER;								{  how many pixels wide is this data  }
		height:					INTEGER;								{  how many pixels high is this data  }
		hRes:					Fixed;									{  horizontal resolution  }
		vRes:					Fixed;									{  vertical resolution  }
		dataSize:				LONGINT;								{  if known, the size of data for this image descriptor  }
		frameCount:				INTEGER;								{  number of frames this description applies to  }
		name:					Str31;									{  name of codec ( in case not installed )   }
		depth:					INTEGER;								{  what depth is this data (1-32) or ( 33-40 grayscale )  }
		clutID:					INTEGER;								{  clut id or if 0 clut follows  or -1 if no clut  }
	END;

	ImageDescriptionHandle				= ^ImageDescriptionPtr;
	CodecInfoPtr = ^CodecInfo;
	CodecInfo = PACKED RECORD
		typeName:				Str31;									{  name of the codec type i.e.: 'Apple Image Compression'  }
		version:				INTEGER;								{  version of the codec data that this codec knows about  }
		revisionLevel:			INTEGER;								{  revision level of this codec i.e: 0x00010001 (1.0.1)  }
		vendor:					LONGINT;								{  Maker of this codec i.e: 'appl'  }
		decompressFlags:		LONGINT;								{  codecInfo flags for decompression capabilities  }
		compressFlags:			LONGINT;								{  codecInfo flags for compression capabilities  }
		formatFlags:			LONGINT;								{  codecInfo flags for compression format details  }
		compressionAccuracy:	UInt8;									{  measure (1-255) of accuracy of this codec for compress (0 if unknown)  }
		decompressionAccuracy:	UInt8;									{  measure (1-255) of accuracy of this codec for decompress (0 if unknown)  }
		compressionSpeed:		INTEGER;								{  ( millisecs for compressing 320x240 on base mac II) (0 if unknown)   }
		decompressionSpeed:		INTEGER;								{  ( millisecs for decompressing 320x240 on mac II)(0 if unknown)   }
		compressionLevel:		UInt8;									{  measure (1-255) of compression level of this codec (0 if unknown)   }
		resvd:					UInt8;									{  pad  }
		minimumHeight:			INTEGER;								{  minimum height of image (block size)  }
		minimumWidth:			INTEGER;								{  minimum width of image (block size)  }
		decompressPipelineLatency: INTEGER;								{  in milliseconds ( for asynchronous codecs )  }
		compressPipelineLatency: INTEGER;								{  in milliseconds ( for asynchronous codecs )  }
		privateData:			LONGINT;
	END;

	CodecNameSpecPtr = ^CodecNameSpec;
	CodecNameSpec = RECORD
		codec:					CodecComponent;
		cType:					CodecType;
		typeName:				Str31;
		name:					Handle;
	END;

	CodecNameSpecListPtr = ^CodecNameSpecList;
	CodecNameSpecList = RECORD
		count:					INTEGER;
		list:					ARRAY [0..0] OF CodecNameSpec;
	END;


CONST
	defaultDither				= 0;
	forceDither					= 1;
	suppressDither				= 2;
	useColorMatching			= 4;

	callStdBits					= 1;
	callOldBits					= 2;
	noDefaultOpcodes			= 4;

	graphicsModeStraightAlpha	= 256;
	graphicsModePreWhiteAlpha	= 257;
	graphicsModePreBlackAlpha	= 258;
	graphicsModeCompostion		= 259;
	graphicsModeStraightAlphaBlend = 260;

	evenField1ToEvenFieldOut	= $01;
	evenField1ToOddFieldOut		= $02;
	oddField1ToEvenFieldOut		= $04;
	oddField1ToOddFieldOut		= $08;
	evenField2ToEvenFieldOut	= $10;
	evenField2ToOddFieldOut		= $20;
	oddField2ToEvenFieldOut		= $40;
	oddField2ToOddFieldOut		= $80;


TYPE
	ICMFrameTimeRecordPtr = ^ICMFrameTimeRecord;
	ICMFrameTimeRecord = RECORD
		value:					wide;									{  frame time }
		scale:					LONGINT;								{  timescale of value/duration fields }
		base:					Ptr;									{  timebase }
		duration:				LONGINT;								{  duration frame is to be displayed (0 if unknown) }
		rate:					Fixed;									{  rate of timebase relative to wall-time }
		recordSize:				LONGINT;								{  total number of bytes in ICMFrameTimeRecord }
		frameNumber:			LONGINT;								{  number of frame, zero if not known }
	END;

	ICMFrameTimePtr						= ^ICMFrameTimeRecord;

CONST
	uppICMDataProcInfo = $00000FE0;
	uppICMFlushProcInfo = $00000FE0;
	uppICMCompletionProcInfo = $00000E80;
	uppICMProgressProcInfo = $00000FA0;
	uppStdPixProcInfo = $002FEFC0;
	uppICMAlignmentProcInfo = $000003C0;
	uppICMCursorShieldedProcInfo = $00000FC0;
	uppICMMemoryDisposedProcInfo = $000003C0;
	uppICMConvertDataFormatProcInfo = $000FFFE0;

FUNCTION NewICMDataProc(userRoutine: ICMDataProcPtr): ICMDataUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewICMFlushProc(userRoutine: ICMFlushProcPtr): ICMFlushUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewICMCompletionProc(userRoutine: ICMCompletionProcPtr): ICMCompletionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewICMProgressProc(userRoutine: ICMProgressProcPtr): ICMProgressUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewStdPixProc(userRoutine: StdPixProcPtr): StdPixUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewICMAlignmentProc(userRoutine: ICMAlignmentProcPtr): ICMAlignmentUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewICMCursorShieldedProc(userRoutine: ICMCursorShieldedProcPtr): ICMCursorShieldedUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewICMMemoryDisposedProc(userRoutine: ICMMemoryDisposedProcPtr): ICMMemoryDisposedUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewICMConvertDataFormatProc(userRoutine: ICMConvertDataFormatProcPtr): ICMConvertDataFormatUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallICMDataProc(VAR dataP: Ptr; bytesNeeded: LONGINT; refcon: LONGINT; userRoutine: ICMDataUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallICMFlushProc(data: Ptr; bytesAdded: LONGINT; refcon: LONGINT; userRoutine: ICMFlushUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallICMCompletionProc(result: OSErr; flags: INTEGER; refcon: LONGINT; userRoutine: ICMCompletionUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallICMProgressProc(message: INTEGER; completeness: Fixed; refcon: LONGINT; userRoutine: ICMProgressUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallStdPixProc(VAR src: PixMap; VAR srcRect: Rect; VAR matrix: MatrixRecord; mode: INTEGER; mask: RgnHandle; VAR matte: PixMap; VAR matteRect: Rect; flags: INTEGER; userRoutine: StdPixUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallICMAlignmentProc(VAR rp: Rect; refcon: LONGINT; userRoutine: ICMAlignmentUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallICMCursorShieldedProc({CONST}VAR r: Rect; refcon: UNIV Ptr; flags: LONGINT; userRoutine: ICMCursorShieldedUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallICMMemoryDisposedProc(memoryBlock: Ptr; refcon: UNIV Ptr; userRoutine: ICMMemoryDisposedUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallICMConvertDataFormatProc(refCon: UNIV Ptr; flags: LONGINT; desiredFormat: Handle; srcData: UNIV Ptr; srcDataSize: LONGINT; VAR dstData: UNIV Ptr; VAR dstDataSize: LONGINT; userRoutine: ICMConvertDataFormatUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
FUNCTION CodecManagerVersion(VAR version: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7000, $AAA3;
	{$ENDC}
FUNCTION GetCodecNameList(VAR list: CodecNameSpecListPtr; showAll: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $AAA3;
	{$ENDC}
FUNCTION DisposeCodecNameList(list: CodecNameSpecListPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700F, $AAA3;
	{$ENDC}
FUNCTION GetCodecInfo(VAR info: CodecInfo; cType: CodecType; codec: CodecComponent): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7003, $AAA3;
	{$ENDC}
FUNCTION GetMaxCompressionSize(src: PixMapHandle; {CONST}VAR srcRect: Rect; colorDepth: INTEGER; quality: CodecQ; cType: CodecType; codec: CompressorComponent; VAR size: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7004, $AAA3;
	{$ENDC}
FUNCTION GetCSequenceMaxCompressionSize(seqID: ImageSequence; src: PixMapHandle; VAR size: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0074, $AAA3;
	{$ENDC}
FUNCTION GetCompressionTime(src: PixMapHandle; {CONST}VAR srcRect: Rect; colorDepth: INTEGER; cType: CodecType; codec: CompressorComponent; VAR spatialQuality: CodecQ; VAR temporalQuality: CodecQ; VAR compressTime: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7005, $AAA3;
	{$ENDC}
FUNCTION CompressImage(src: PixMapHandle; {CONST}VAR srcRect: Rect; quality: CodecQ; cType: CodecType; desc: ImageDescriptionHandle; data: Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7006, $AAA3;
	{$ENDC}
FUNCTION FCompressImage(src: PixMapHandle; {CONST}VAR srcRect: Rect; colorDepth: INTEGER; quality: CodecQ; cType: CodecType; codec: CompressorComponent; ctable: CTabHandle; flags: CodecFlags; bufferSize: LONGINT; flushProc: ICMFlushProcRecordPtr; progressProc: ICMProgressProcRecordPtr; desc: ImageDescriptionHandle; data: Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7007, $AAA3;
	{$ENDC}
FUNCTION DecompressImage(data: Ptr; desc: ImageDescriptionHandle; dst: PixMapHandle; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; mode: INTEGER; mask: RgnHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7008, $AAA3;
	{$ENDC}
FUNCTION FDecompressImage(data: Ptr; desc: ImageDescriptionHandle; dst: PixMapHandle; {CONST}VAR srcRect: Rect; matrix: MatrixRecordPtr; mode: INTEGER; mask: RgnHandle; matte: PixMapHandle; {CONST}VAR matteRect: Rect; accuracy: CodecQ; codec: DecompressorComponent; bufferSize: LONGINT; dataProc: ICMDataProcRecordPtr; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7009, $AAA3;
	{$ENDC}
FUNCTION CompressSequenceBegin(VAR seqID: ImageSequence; src: PixMapHandle; prev: PixMapHandle; {CONST}VAR srcRect: Rect; {CONST}VAR prevRect: Rect; colorDepth: INTEGER; cType: CodecType; codec: CompressorComponent; spatialQuality: CodecQ; temporalQuality: CodecQ; keyFrameRate: LONGINT; ctable: CTabHandle; flags: CodecFlags; desc: ImageDescriptionHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700A, $AAA3;
	{$ENDC}
FUNCTION CompressSequenceFrame(seqID: ImageSequence; src: PixMapHandle; {CONST}VAR srcRect: Rect; flags: CodecFlags; data: Ptr; VAR dataSize: LONGINT; VAR similarity: UInt8; asyncCompletionProc: ICMCompletionProcRecordPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700B, $AAA3;
	{$ENDC}
FUNCTION DecompressSequenceBegin(VAR seqID: ImageSequence; desc: ImageDescriptionHandle; port: CGrafPtr; gdh: GDHandle; {CONST}VAR srcRect: Rect; matrix: MatrixRecordPtr; mode: INTEGER; mask: RgnHandle; flags: CodecFlags; accuracy: CodecQ; codec: DecompressorComponent): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700D, $AAA3;
	{$ENDC}
FUNCTION DecompressSequenceBeginS(VAR seqID: ImageSequence; desc: ImageDescriptionHandle; data: Ptr; dataSize: LONGINT; port: CGrafPtr; gdh: GDHandle; {CONST}VAR srcRect: Rect; matrix: MatrixRecordPtr; mode: INTEGER; mask: RgnHandle; flags: CodecFlags; accuracy: CodecQ; codec: DecompressorComponent): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0030, $005D, $AAA3;
	{$ENDC}
FUNCTION DecompressSequenceFrame(seqID: ImageSequence; data: Ptr; inFlags: CodecFlags; VAR outFlags: CodecFlags; asyncCompletionProc: ICMCompletionProcRecordPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $700E, $AAA3;
	{$ENDC}
FUNCTION DecompressSequenceFrameS(seqID: ImageSequence; data: Ptr; dataSize: LONGINT; inFlags: CodecFlags; VAR outFlags: CodecFlags; asyncCompletionProc: ICMCompletionProcRecordPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0016, $0047, $AAA3;
	{$ENDC}
FUNCTION DecompressSequenceFrameWhen(seqID: ImageSequence; data: Ptr; dataSize: LONGINT; inFlags: CodecFlags; VAR outFlags: CodecFlags; asyncCompletionProc: ICMCompletionProcRecordPtr; {CONST}VAR frameTime: ICMFrameTimeRecord): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $001A, $005E, $AAA3;
	{$ENDC}
FUNCTION CDSequenceFlush(seqID: ImageSequence): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $005F, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceMatrix(seqID: ImageSequence; matrix: MatrixRecordPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7010, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceMatte(seqID: ImageSequence; matte: PixMapHandle; {CONST}VAR matteRect: Rect): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7011, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceMask(seqID: ImageSequence; mask: RgnHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7012, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceTransferMode(seqID: ImageSequence; mode: INTEGER; {CONST}VAR opColor: RGBColor): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7013, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceDataProc(seqID: ImageSequence; dataProc: ICMDataProcRecordPtr; bufferSize: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7014, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceAccuracy(seqID: ImageSequence; accuracy: CodecQ): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7034, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceSrcRect(seqID: ImageSequence; {CONST}VAR srcRect: Rect): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7035, $AAA3;
	{$ENDC}
FUNCTION GetDSequenceImageBuffer(seqID: ImageSequence; VAR gworld: GWorldPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7015, $AAA3;
	{$ENDC}
FUNCTION GetDSequenceScreenBuffer(seqID: ImageSequence; VAR gworld: GWorldPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7016, $AAA3;
	{$ENDC}
FUNCTION SetCSequenceQuality(seqID: ImageSequence; spatialQuality: CodecQ; temporalQuality: CodecQ): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7017, $AAA3;
	{$ENDC}
FUNCTION SetCSequencePrev(seqID: ImageSequence; prev: PixMapHandle; {CONST}VAR prevRect: Rect): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7018, $AAA3;
	{$ENDC}
FUNCTION SetCSequenceFlushProc(seqID: ImageSequence; flushProc: ICMFlushProcRecordPtr; bufferSize: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7033, $AAA3;
	{$ENDC}
FUNCTION SetCSequenceKeyFrameRate(seqID: ImageSequence; keyFrameRate: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7036, $AAA3;
	{$ENDC}
FUNCTION GetCSequenceKeyFrameRate(seqID: ImageSequence; VAR keyFrameRate: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $004B, $AAA3;
	{$ENDC}
FUNCTION GetCSequencePrevBuffer(seqID: ImageSequence; VAR gworld: GWorldPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7019, $AAA3;
	{$ENDC}
FUNCTION CDSequenceBusy(seqID: ImageSequence): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701A, $AAA3;
	{$ENDC}
FUNCTION CDSequenceEnd(seqID: ImageSequence): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701B, $AAA3;
	{$ENDC}
FUNCTION CDSequenceEquivalentImageDescription(seqID: ImageSequence; newDesc: ImageDescriptionHandle; VAR equivalent: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0065, $AAA3;
	{$ENDC}
FUNCTION GetCompressedImageSize(desc: ImageDescriptionHandle; data: Ptr; bufferSize: LONGINT; dataProc: ICMDataProcRecordPtr; VAR dataSize: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701C, $AAA3;
	{$ENDC}
FUNCTION GetSimilarity(src: PixMapHandle; {CONST}VAR srcRect: Rect; desc: ImageDescriptionHandle; data: Ptr; VAR similarity: Fixed): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701D, $AAA3;
	{$ENDC}
FUNCTION GetImageDescriptionCTable(desc: ImageDescriptionHandle; VAR ctable: CTabHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701E, $AAA3;
	{$ENDC}
FUNCTION SetImageDescriptionCTable(desc: ImageDescriptionHandle; ctable: CTabHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $701F, $AAA3;
	{$ENDC}
FUNCTION GetImageDescriptionExtension(desc: ImageDescriptionHandle; VAR extension: Handle; idType: LONGINT; index: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7020, $AAA3;
	{$ENDC}
FUNCTION AddImageDescriptionExtension(desc: ImageDescriptionHandle; extension: Handle; idType: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7021, $AAA3;
	{$ENDC}
FUNCTION RemoveImageDescriptionExtension(desc: ImageDescriptionHandle; idType: LONGINT; index: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $003A, $AAA3;
	{$ENDC}
FUNCTION CountImageDescriptionExtensionType(desc: ImageDescriptionHandle; idType: LONGINT; VAR count: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $003B, $AAA3;
	{$ENDC}
FUNCTION GetNextImageDescriptionExtensionType(desc: ImageDescriptionHandle; VAR idType: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $003C, $AAA3;
	{$ENDC}
FUNCTION FindCodec(cType: CodecType; specCodec: CodecComponent; VAR compressor: CompressorComponent; VAR decompressor: DecompressorComponent): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7023, $AAA3;
	{$ENDC}
FUNCTION CompressPicture(srcPicture: PicHandle; dstPicture: PicHandle; quality: CodecQ; cType: CodecType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7024, $AAA3;
	{$ENDC}
FUNCTION FCompressPicture(srcPicture: PicHandle; dstPicture: PicHandle; colorDepth: INTEGER; ctable: CTabHandle; quality: CodecQ; doDither: INTEGER; compressAgain: INTEGER; progressProc: ICMProgressProcRecordPtr; cType: CodecType; codec: CompressorComponent): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7025, $AAA3;
	{$ENDC}
FUNCTION CompressPictureFile(srcRefNum: INTEGER; dstRefNum: INTEGER; quality: CodecQ; cType: CodecType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7026, $AAA3;
	{$ENDC}
FUNCTION FCompressPictureFile(srcRefNum: INTEGER; dstRefNum: INTEGER; colorDepth: INTEGER; ctable: CTabHandle; quality: CodecQ; doDither: INTEGER; compressAgain: INTEGER; progressProc: ICMProgressProcRecordPtr; cType: CodecType; codec: CompressorComponent): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7027, $AAA3;
	{$ENDC}
FUNCTION GetPictureFileHeader(refNum: INTEGER; VAR frame: Rect; VAR header: OpenCPicParams): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7028, $AAA3;
	{$ENDC}
FUNCTION DrawPictureFile(refNum: INTEGER; {CONST}VAR frame: Rect; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7029, $AAA3;
	{$ENDC}
FUNCTION DrawTrimmedPicture(srcPicture: PicHandle; {CONST}VAR frame: Rect; trimMask: RgnHandle; doDither: INTEGER; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $702E, $AAA3;
	{$ENDC}
FUNCTION DrawTrimmedPictureFile(srcRefnum: INTEGER; {CONST}VAR frame: Rect; trimMask: RgnHandle; doDither: INTEGER; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $702F, $AAA3;
	{$ENDC}
FUNCTION MakeThumbnailFromPicture(picture: PicHandle; colorDepth: INTEGER; thumbnail: PicHandle; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $702A, $AAA3;
	{$ENDC}
FUNCTION MakeThumbnailFromPictureFile(refNum: INTEGER; colorDepth: INTEGER; thumbnail: PicHandle; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $702B, $AAA3;
	{$ENDC}
FUNCTION MakeThumbnailFromPixMap(src: PixMapHandle; {CONST}VAR srcRect: Rect; colorDepth: INTEGER; thumbnail: PicHandle; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $702C, $AAA3;
	{$ENDC}
FUNCTION TrimImage(desc: ImageDescriptionHandle; inData: Ptr; inBufferSize: LONGINT; dataProc: ICMDataProcRecordPtr; outData: Ptr; outBufferSize: LONGINT; flushProc: ICMFlushProcRecordPtr; VAR trimRect: Rect; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $702D, $AAA3;
	{$ENDC}
FUNCTION ConvertImage(srcDD: ImageDescriptionHandle; srcData: Ptr; colorDepth: INTEGER; ctable: CTabHandle; accuracy: CodecQ; quality: CodecQ; cType: CodecType; codec: CodecComponent; dstDD: ImageDescriptionHandle; dstData: Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7030, $AAA3;
	{$ENDC}
FUNCTION GetCompressedPixMapInfo(pix: PixMapPtr; VAR desc: ImageDescriptionHandle; VAR data: Ptr; VAR bufferSize: LONGINT; VAR dataProc: ICMDataProcRecord; VAR progressProc: ICMProgressProcRecord): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7037, $AAA3;
	{$ENDC}
FUNCTION SetCompressedPixMapInfo(pix: PixMapPtr; desc: ImageDescriptionHandle; data: Ptr; bufferSize: LONGINT; dataProc: ICMDataProcRecordPtr; progressProc: ICMProgressProcRecordPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7038, $AAA3;
	{$ENDC}
PROCEDURE StdPix(src: PixMapPtr; {CONST}VAR srcRect: Rect; matrix: MatrixRecordPtr; mode: INTEGER; mask: RgnHandle; matte: PixMapPtr; {CONST}VAR matteRect: Rect; flags: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $700C, $AAA3;
	{$ENDC}
FUNCTION TransformRgn(matrix: MatrixRecordPtr; rgn: RgnHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7039, $AAA3;
	{$ENDC}
{
**********
	preview stuff
**********
}
PROCEDURE SFGetFilePreview(where: Point; prompt: Str255; fileFilter: FileFilterUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; dlgHook: DlgHookUPP; VAR reply: SFReply);
	{$IFC NOT GENERATINGCFM}
	INLINE $7041, $AAA3;
	{$ENDC}
PROCEDURE SFPGetFilePreview(where: Point; prompt: Str255; fileFilter: FileFilterUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; dlgHook: DlgHookUPP; VAR reply: SFReply; dlgID: INTEGER; filterProc: ModalFilterUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $7042, $AAA3;
	{$ENDC}
PROCEDURE StandardGetFilePreview(fileFilter: FileFilterUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; VAR reply: StandardFileReply);
	{$IFC NOT GENERATINGCFM}
	INLINE $7043, $AAA3;
	{$ENDC}
PROCEDURE CustomGetFilePreview(fileFilter: FileFilterYDUPP; numTypes: INTEGER; typeList: ConstSFTypeListPtr; VAR reply: StandardFileReply; dlgID: INTEGER; where: Point; dlgHook: DlgHookYDUPP; filterProc: ModalFilterYDUPP; activeList: ActivationOrderListPtr; activateProc: ActivateYDUPP; yourDataPtr: UNIV Ptr);
	{$IFC NOT GENERATINGCFM}
	INLINE $7044, $AAA3;
	{$ENDC}
FUNCTION MakeFilePreview(resRefNum: INTEGER; progress: ICMProgressProcRecordPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7045, $AAA3;
	{$ENDC}
FUNCTION AddFilePreview(resRefNum: INTEGER; previewType: OSType; previewData: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7046, $AAA3;
	{$ENDC}

CONST
	sfpItemPreviewAreaUser		= 11;
	sfpItemPreviewStaticText	= 12;
	sfpItemPreviewDividerUser	= 13;
	sfpItemCreatePreviewButton	= 14;
	sfpItemShowPreviewButton	= 15;


TYPE
	PreviewResourceRecordPtr = ^PreviewResourceRecord;
	PreviewResourceRecord = RECORD
		modDate:				LONGINT;
		version:				INTEGER;
		resType:				OSType;
		resID:					INTEGER;
	END;

	PreviewResourcePtr					= ^PreviewResourceRecord;
	PreviewResource						= ^PreviewResourcePtr;
PROCEDURE AlignScreenRect(VAR rp: Rect; alignmentProc: ICMAlignmentProcRecordPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $004C, $AAA3;
	{$ENDC}
PROCEDURE AlignWindow(wp: WindowPtr; front: BOOLEAN; {CONST}VAR alignmentRect: Rect; alignmentProc: ICMAlignmentProcRecordPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000E, $004D, $AAA3;
	{$ENDC}
PROCEDURE DragAlignedWindow(wp: WindowPtr; startPt: Point; VAR boundsRect: Rect; VAR alignmentRect: Rect; alignmentProc: ICMAlignmentProcRecordPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0014, $004E, $AAA3;
	{$ENDC}
FUNCTION DragAlignedGrayRgn(theRgn: RgnHandle; startPt: Point; VAR boundsRect: Rect; VAR slopRect: Rect; axis: INTEGER; actionProc: UniversalProcPtr; VAR alignmentRect: Rect; alignmentProc: ICMAlignmentProcRecordPtr): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $001E, $004F, $AAA3;
	{$ENDC}
FUNCTION SetCSequenceDataRateParams(seqID: ImageSequence; params: DataRateParamsPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0050, $AAA3;
	{$ENDC}
FUNCTION SetCSequenceFrameNumber(seqID: ImageSequence; frameNumber: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0051, $AAA3;
	{$ENDC}
FUNCTION SetCSequencePreferredPacketSize(seqID: ImageSequence; preferredPacketSizeInBytes: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0078, $AAA3;
	{$ENDC}
FUNCTION NewImageGWorld(VAR gworld: GWorldPtr; idh: ImageDescriptionHandle; flags: GWorldFlags): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0052, $AAA3;
	{$ENDC}
FUNCTION GetCSequenceDataRateParams(seqID: ImageSequence; params: DataRateParamsPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0053, $AAA3;
	{$ENDC}
FUNCTION GetCSequenceFrameNumber(seqID: ImageSequence; VAR frameNumber: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0054, $AAA3;
	{$ENDC}
FUNCTION GetBestDeviceRect(VAR gdh: GDHandle; VAR rp: Rect): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0055, $AAA3;
	{$ENDC}
FUNCTION SetSequenceProgressProc(seqID: ImageSequence; VAR progressProc: ICMProgressProcRecord): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0056, $AAA3;
	{$ENDC}
FUNCTION GDHasScale(gdh: GDHandle; depth: INTEGER; VAR scale: Fixed): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000A, $005A, $AAA3;
	{$ENDC}
FUNCTION GDGetScale(gdh: GDHandle; VAR scale: Fixed; VAR flags: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $005B, $AAA3;
	{$ENDC}
FUNCTION GDSetScale(gdh: GDHandle; scale: Fixed; flags: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000A, $005C, $AAA3;
	{$ENDC}
FUNCTION ICMShieldSequenceCursor(seqID: ImageSequence): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0062, $AAA3;
	{$ENDC}
PROCEDURE ICMDecompressComplete(seqID: ImageSequence; err: OSErr; flag: INTEGER; completionRtn: ICMCompletionProcRecordPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0063, $AAA3;
	{$ENDC}
FUNCTION SetDSequenceTimeCode(seqID: ImageSequence; timeCodeFormat: UNIV Ptr; timeCodeTime: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0064, $AAA3;
	{$ENDC}
FUNCTION CDSequenceNewMemory(seqID: ImageSequence; VAR data: Ptr; dataSize: Size; dataUse: LONGINT; memoryGoneProc: ICMMemoryDisposedUPP; refCon: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0018, $0066, $AAA3;
	{$ENDC}
FUNCTION CDSequenceDisposeMemory(seqID: ImageSequence; data: Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0067, $AAA3;
	{$ENDC}
FUNCTION CDSequenceNewDataSource(seqID: ImageSequence; VAR sourceID: ImageSequenceDataSource; sourceType: OSType; sourceInputNumber: LONGINT; dataDescription: Handle; transferProc: UNIV Ptr; refCon: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $001C, $0068, $AAA3;
	{$ENDC}
FUNCTION CDSequenceDisposeDataSource(sourceID: ImageSequenceDataSource): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0069, $AAA3;
	{$ENDC}
FUNCTION CDSequenceSetSourceData(sourceID: ImageSequenceDataSource; data: UNIV Ptr; dataSize: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $006A, $AAA3;
	{$ENDC}
FUNCTION CDSequenceChangedSourceData(sourceID: ImageSequenceDataSource): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $006B, $AAA3;
	{$ENDC}
FUNCTION PtInDSequenceData(seqID: ImageSequence; data: UNIV Ptr; dataSize: Size; where: Point; VAR hit: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0014, $006C, $AAA3;
	{$ENDC}
FUNCTION GetGraphicsImporterForFile({CONST}VAR theFile: FSSpec; VAR gi: ComponentInstance): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $006E, $AAA3;
	{$ENDC}
FUNCTION GetGraphicsImporterForDataRef(dataRef: Handle; dataRefType: OSType; VAR gi: ComponentInstance): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $000C, $0077, $AAA3;
	{$ENDC}
FUNCTION ImageTranscodeSequenceBegin(VAR its: ImageTranscodeSequence; srcDesc: ImageDescriptionHandle; destType: OSType; VAR dstDesc: ImageDescriptionHandle; data: UNIV Ptr; dataSize: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0018, $006F, $AAA3;
	{$ENDC}
FUNCTION ImageTranscodeSequenceEnd(its: ImageTranscodeSequence): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0070, $AAA3;
	{$ENDC}
FUNCTION ImageTranscodeFrame(its: ImageTranscodeSequence; srcData: UNIV Ptr; srcDataSize: LONGINT; VAR dstData: UNIV Ptr; VAR dstDataSize: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0014, $0071, $AAA3;
	{$ENDC}
FUNCTION ImageTranscodeDisposeFrameData(its: ImageTranscodeSequence; dstData: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0072, $AAA3;
	{$ENDC}
FUNCTION CDSequenceInvalidate(seqID: ImageSequence; invalRgn: RgnHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0008, $0073, $AAA3;
	{$ENDC}
FUNCTION ImageFieldSequenceBegin(VAR ifs: ImageFieldSequence; desc1: ImageDescriptionHandle; desc2: ImageDescriptionHandle; descOut: ImageDescriptionHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0010, $006D, $AAA3;
	{$ENDC}
FUNCTION ImageFieldSequenceExtractCombine(ifs: ImageFieldSequence; fieldFlags: LONGINT; data1: UNIV Ptr; dataSize1: LONGINT; data2: UNIV Ptr; dataSize2: LONGINT; outputData: UNIV Ptr; VAR outDataSize: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0020, $0075, $AAA3;
	{$ENDC}
FUNCTION ImageFieldSequenceEnd(ifs: ImageFieldSequence): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $203C, $0004, $0076, $AAA3;
	{$ENDC}

CONST
	identityMatrixType			= $00;							{  result if matrix is identity  }
	translateMatrixType			= $01;							{  result if matrix translates  }
	scaleMatrixType				= $02;							{  result if matrix scales  }
	scaleTranslateMatrixType	= $03;							{  result if matrix scales and translates  }
	linearMatrixType			= $04;							{  result if matrix is general 2 x 2  }
	linearTranslateMatrixType	= $05;							{  result if matrix is general 2 x 2 and translates  }
	perspectiveMatrixType		= $06;							{  result if matrix is general 3 x 3  }


TYPE
	MatrixFlags							= INTEGER;
FUNCTION GetMatrixType({CONST}VAR m: MatrixRecord): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $7014, $ABC2;
	{$ENDC}
PROCEDURE CopyMatrix({CONST}VAR m1: MatrixRecord; VAR m2: MatrixRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $7020, $ABC2;
	{$ENDC}
FUNCTION EqualMatrix({CONST}VAR m1: MatrixRecord; {CONST}VAR m2: MatrixRecord): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7021, $ABC2;
	{$ENDC}
PROCEDURE SetIdentityMatrix(VAR matrix: MatrixRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $7015, $ABC2;
	{$ENDC}
PROCEDURE TranslateMatrix(VAR m: MatrixRecord; deltaH: Fixed; deltaV: Fixed);
	{$IFC NOT GENERATINGCFM}
	INLINE $7019, $ABC2;
	{$ENDC}
PROCEDURE RotateMatrix(VAR m: MatrixRecord; degrees: Fixed; aboutX: Fixed; aboutY: Fixed);
	{$IFC NOT GENERATINGCFM}
	INLINE $7016, $ABC2;
	{$ENDC}
PROCEDURE ScaleMatrix(VAR m: MatrixRecord; scaleX: Fixed; scaleY: Fixed; aboutX: Fixed; aboutY: Fixed);
	{$IFC NOT GENERATINGCFM}
	INLINE $7017, $ABC2;
	{$ENDC}
PROCEDURE SkewMatrix(VAR m: MatrixRecord; skewX: Fixed; skewY: Fixed; aboutX: Fixed; aboutY: Fixed);
	{$IFC NOT GENERATINGCFM}
	INLINE $7018, $ABC2;
	{$ENDC}
FUNCTION TransformFixedPoints({CONST}VAR m: MatrixRecord; VAR fpt: FixedPoint; count: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7022, $ABC2;
	{$ENDC}
FUNCTION TransformPoints({CONST}VAR mp: MatrixRecord; VAR pt1: Point; count: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $7023, $ABC2;
	{$ENDC}
FUNCTION TransformFixedRect({CONST}VAR m: MatrixRecord; VAR fr: FixedRect; VAR fpp: FixedPoint): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7024, $ABC2;
	{$ENDC}
FUNCTION TransformRect({CONST}VAR m: MatrixRecord; VAR r: Rect; VAR fpp: FixedPoint): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $7025, $ABC2;
	{$ENDC}
FUNCTION InverseMatrix({CONST}VAR m: MatrixRecord; VAR im: MatrixRecord): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $701C, $ABC2;
	{$ENDC}
PROCEDURE ConcatMatrix({CONST}VAR a: MatrixRecord; VAR b: MatrixRecord);
	{$IFC NOT GENERATINGCFM}
	INLINE $701B, $ABC2;
	{$ENDC}
PROCEDURE RectMatrix(VAR matrix: MatrixRecord; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $701E, $ABC2;
	{$ENDC}
PROCEDURE MapMatrix(VAR matrix: MatrixRecord; {CONST}VAR fromRect: Rect; {CONST}VAR toRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $701D, $ABC2;
	{$ENDC}
PROCEDURE CompAdd(VAR src: wide; VAR dst: wide);
	{$IFC NOT GENERATINGCFM}
	INLINE $7001, $ABC2;
	{$ENDC}
PROCEDURE CompSub(VAR src: wide; VAR dst: wide);
	{$IFC NOT GENERATINGCFM}
	INLINE $7002, $ABC2;
	{$ENDC}
PROCEDURE CompNeg(VAR dst: wide);
	{$IFC NOT GENERATINGCFM}
	INLINE $7003, $ABC2;
	{$ENDC}
PROCEDURE CompShift(VAR src: wide; shift: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $7004, $ABC2;
	{$ENDC}
PROCEDURE CompMul(src1: LONGINT; src2: LONGINT; VAR dst: wide);
	{$IFC NOT GENERATINGCFM}
	INLINE $7005, $ABC2;
	{$ENDC}
FUNCTION CompDiv(VAR numerator: wide; denominator: LONGINT; VAR remainder: LONGINT): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7006, $ABC2;
	{$ENDC}
PROCEDURE CompFixMul(VAR compSrc: wide; fixSrc: Fixed; VAR compDst: wide);
	{$IFC NOT GENERATINGCFM}
	INLINE $7007, $ABC2;
	{$ENDC}
PROCEDURE CompMulDiv(VAR co: wide; mul: LONGINT; divisor: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $7008, $ABC2;
	{$ENDC}
PROCEDURE CompMulDivTrunc(VAR co: wide; mul: LONGINT; divisor: LONGINT; VAR remainder: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $700C, $ABC2;
	{$ENDC}
FUNCTION CompCompare(VAR a: wide; VAR minusb: wide): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $7009, $ABC2;
	{$ENDC}
FUNCTION FixMulDiv(src: Fixed; mul: Fixed; divisor: Fixed): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $700A, $ABC2;
	{$ENDC}
FUNCTION UnsignedFixMulDiv(src: Fixed; mul: Fixed; divisor: Fixed): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $700D, $ABC2;
	{$ENDC}
FUNCTION FracSinCos(degree: Fixed; VAR cosOut: Fract): Fract;
	{$IFC NOT GENERATINGCFM}
	INLINE $700B, $ABC2;
	{$ENDC}
FUNCTION FixExp2(src: Fixed): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $700E, $ABC2;
	{$ENDC}
FUNCTION FixLog2(src: Fixed): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $700F, $ABC2;
	{$ENDC}
FUNCTION FixPow(base: Fixed; exp: Fixed): Fixed;
	{$IFC NOT GENERATINGCFM}
	INLINE $7010, $ABC2;
	{$ENDC}

TYPE
	GraphicsImportComponent				= ComponentInstance;

CONST
	GraphicsImporterComponentType = 'grip';

{ * These are GraphicsImport procedures * }
FUNCTION GraphicsImportSetDataReference(ci: GraphicsImportComponent; dataRef: Handle; dataReType: OSType): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDataReference(ci: GraphicsImportComponent; VAR dataRef: Handle; VAR dataReType: OSType): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetDataFile(ci: GraphicsImportComponent; {CONST}VAR theFile: FSSpec): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDataFile(ci: GraphicsImportComponent; VAR theFile: FSSpec): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetDataHandle(ci: GraphicsImportComponent; h: Handle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDataHandle(ci: GraphicsImportComponent; VAR h: Handle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetImageDescription(ci: GraphicsImportComponent; VAR desc: ImageDescriptionHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDataOffsetAndSize(ci: GraphicsImportComponent; VAR offset: LONGINT; VAR size: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportReadData(ci: GraphicsImportComponent; dataPtr: UNIV Ptr; dataOffset: LONGINT; dataSize: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetClip(ci: GraphicsImportComponent; clipRgn: RgnHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetClip(ci: GraphicsImportComponent; VAR clipRgn: RgnHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetSourceRect(ci: GraphicsImportComponent; {CONST}VAR sourceRect: Rect): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetSourceRect(ci: GraphicsImportComponent; VAR sourceRect: Rect): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetNaturalBounds(ci: GraphicsImportComponent; VAR naturalBounds: Rect): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportDraw(ci: GraphicsImportComponent): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetGWorld(ci: GraphicsImportComponent; port: CGrafPtr; gd: GDHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetGWorld(ci: GraphicsImportComponent; VAR port: CGrafPtr; VAR gd: GDHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetMatrix(ci: GraphicsImportComponent; {CONST}VAR matrix: MatrixRecord): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetMatrix(ci: GraphicsImportComponent; VAR matrix: MatrixRecord): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0013, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetBoundsRect(ci: GraphicsImportComponent; {CONST}VAR bounds: Rect): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0014, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetBoundsRect(ci: GraphicsImportComponent; VAR bounds: Rect): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0015, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSaveAsPicture(ci: GraphicsImportComponent; {CONST}VAR fss: FSSpec; scriptTag: ScriptCode): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0006, $0016, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetGraphicsMode(ci: GraphicsImportComponent; graphicsMode: LONGINT; {CONST}VAR opColor: RGBColor): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0017, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetGraphicsMode(ci: GraphicsImportComponent; VAR graphicsMode: LONGINT; VAR opColor: RGBColor): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0018, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetQuality(ci: GraphicsImportComponent; quality: CodecQ): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0019, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetQuality(ci: GraphicsImportComponent; VAR quality: CodecQ): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $001A, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSaveAsQuickTimeImageFile(ci: GraphicsImportComponent; {CONST}VAR fss: FSSpec; scriptTag: ScriptCode): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0006, $001B, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportSetDataReferenceOffsetAndLimit(ci: GraphicsImportComponent; offset: LONGINT; limit: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $001C, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetDataReferenceOffsetAndLimit(ci: GraphicsImportComponent; VAR offset: LONGINT; VAR limit: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $001D, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportGetAliasedDataReference(ci: GraphicsImportComponent; VAR dataRef: Handle; VAR dataRefType: OSType): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $001E, $7000, $A82A;
	{$ENDC}
FUNCTION GraphicsImportValidate(ci: GraphicsImportComponent; VAR valid: BOOLEAN): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $001F, $7000, $A82A;
	{$ENDC}

TYPE
	ImageTranscoderComponent			= ComponentInstance;

CONST
	ImageTranscodererComponentType = 'imtc';

{ * These are ImageTranscoder procedures * }
FUNCTION ImageTranscoderBeginSequence(itc: ImageTranscoderComponent; srcDesc: ImageDescriptionHandle; VAR dstDesc: ImageDescriptionHandle; data: UNIV Ptr; dataSize: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0010, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION ImageTranscoderConvert(itc: ImageTranscoderComponent; srcData: UNIV Ptr; srcDataSize: LONGINT; VAR dstData: UNIV Ptr; VAR dstDataSize: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0010, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION ImageTranscoderDisposeData(itc: ImageTranscoderComponent; dstData: UNIV Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION ImageTranscoderEndSequence(itc: ImageTranscoderComponent): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $0004, $7000, $A82A;
	{$ENDC}
{  UPP call backs  }

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ImageCompressionIncludes}

{$ENDC} {__IMAGECOMPRESSION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

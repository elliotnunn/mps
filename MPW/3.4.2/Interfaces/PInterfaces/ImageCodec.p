{
 	File:		ImageCodec.p
 
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
 UNIT ImageCodec;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __IMAGECODEC__}
{$SETC __IMAGECODEC__ := 1}

{$I+}
{$SETC ImageCodecIncludes := UsingIncludes}
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
{$IFC UNDEFINED __WINDOWS__}
{$I Windows.p}
{$ENDC}
{$IFC UNDEFINED __IMAGECOMPRESSION__}
{$I ImageCompression.p}
{$ENDC}
{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}
{$IFC UNDEFINED __MOVIES__}
{$I Movies.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ 	codec capabilities flags	 }

CONST
	codecCanScale				= $00000001;
	codecCanMask				= $00000002;
	codecCanMatte				= $00000004;
	codecCanTransform			= $00000008;
	codecCanTransferMode		= $00000010;
	codecCanCopyPrev			= $00000020;
	codecCanSpool				= $00000040;
	codecCanClipVertical		= $00000080;
	codecCanClipRectangular		= $00000100;
	codecCanRemapColor			= $00000200;
	codecCanFastDither			= $00000400;
	codecCanSrcExtract			= $00000800;
	codecCanCopyPrevComp		= $00001000;
	codecCanAsync				= $00002000;
	codecCanMakeMask			= $00004000;
	codecCanShift				= $00008000;
	codecCanAsyncWhen			= $00010000;
	codecCanShieldCursor		= $00020000;
	codecCanManagePrevBuffer	= $00040000;
	codecHasVolatileBuffer		= $00080000;
	codecWantsRegionMask		= $00100000;
	codecImageBufferIsOnScreen	= $00200000;
	codecWantsDestinationPixels	= $00400000;


TYPE
	CodecCapabilitiesPtr = ^CodecCapabilities;
	CodecCapabilities = RECORD
		flags:					LONGINT;
		wantedPixelSize:		INTEGER;
		extendWidth:			INTEGER;
		extendHeight:			INTEGER;
		bandMin:				INTEGER;
		bandInc:				INTEGER;
		pad:					INTEGER;
		time:					LONGINT;
	END;

{ 	codec condition flags	 }

CONST
	codecConditionFirstBand		= $00000001;
	codecConditionLastBand		= $00000002;
	codecConditionFirstFrame	= $00000004;
	codecConditionNewDepth		= $00000008;
	codecConditionNewTransform	= $00000010;
	codecConditionNewSrcRect	= $00000020;
	codecConditionNewMask		= $00000040;
	codecConditionNewMatte		= $00000080;
	codecConditionNewTransferMode = $00000100;
	codecConditionNewClut		= $00000200;
	codecConditionNewAccuracy	= $00000400;
	codecConditionNewDestination = $00000800;
	codecConditionFirstScreen	= $00001000;
	codecConditionDoCursor		= $00002000;
	codecConditionCatchUpDiff	= $00004000;
	codecConditionMaskMayBeChanged = $00008000;
	codecConditionToBuffer		= $00010000;
	codecConditionCodecChangedMask = $80000000;

	codecInfoResourceType		= 'cdci';						{  codec info resource type  }
	codecInterfaceVersion		= 2;							{  high word returned in component GetVersion  }


TYPE
	CDSequenceDataSourcePtr = ^CDSequenceDataSource;
	CDSequenceDataSource = RECORD
		recordSize:				LONGINT;
		next:					Ptr;
		seqID:					ImageSequence;
		sourceID:				ImageSequenceDataSource;
		sourceType:				OSType;
		sourceInputNumber:		LONGINT;
		dataPtr:				Ptr;
		dataDescription:		Handle;
		changeSeed:				LONGINT;
		transferProc:			ICMConvertDataFormatUPP;
		transferRefcon:			Ptr;
																		{  The following fields only exist for QuickTime 2.5 and greater  }
		dataSize:				LONGINT;
	END;

	CodecCompressParamsPtr = ^CodecCompressParams;
	CodecCompressParams = RECORD
		sequenceID:				ImageSequence;							{  precompress,bandcompress  }
		imageDescription:		ImageDescriptionHandle;					{  precompress,bandcompress  }
		data:					Ptr;
		bufferSize:				LONGINT;
		frameNumber:			LONGINT;
		startLine:				LONGINT;
		stopLine:				LONGINT;
		conditionFlags:			LONGINT;
		callerFlags:			CodecFlags;
		capabilities:			CodecCapabilitiesPtr;					{  precompress,bandcompress  }
		progressProcRecord:		ICMProgressProcRecord;
		completionProcRecord:	ICMCompletionProcRecord;
		flushProcRecord:		ICMFlushProcRecord;
		srcPixMap:				PixMap;									{  precompress,bandcompress  }
		prevPixMap:				PixMap;
		spatialQuality:			CodecQ;
		temporalQuality:		CodecQ;
		similarity:				Fixed;
		dataRateParams:			DataRateParamsPtr;
		reserved:				LONGINT;
																		{  The following fields only exist for QuickTime 2.1 and greater  }
		majorSourceChangeSeed:	UInt16;
		minorSourceChangeSeed:	UInt16;
		sourceData:				CDSequenceDataSourcePtr;
																		{  The following fields only exit for QuickTime 2.5 and greater  }
		preferredPacketSizeInBytes: LONGINT;
	END;

	CodecDecompressParamsPtr = ^CodecDecompressParams;
	CodecDecompressParams = RECORD
		sequenceID:				ImageSequence;							{  predecompress,banddecompress  }
		imageDescription:		ImageDescriptionHandle;					{  predecompress,banddecompress  }
		data:					Ptr;
		bufferSize:				LONGINT;
		frameNumber:			LONGINT;
		startLine:				LONGINT;
		stopLine:				LONGINT;
		conditionFlags:			LONGINT;
		callerFlags:			CodecFlags;
		capabilities:			CodecCapabilitiesPtr;					{  predecompress,banddecompress  }
		progressProcRecord:		ICMProgressProcRecord;
		completionProcRecord:	ICMCompletionProcRecord;
		dataProcRecord:			ICMDataProcRecord;
		port:					CGrafPtr;								{  predecompress,banddecompress  }
		dstPixMap:				PixMap;									{  predecompress,banddecompress  }
		maskBits:				BitMapPtr;
		mattePixMap:			PixMapPtr;
		srcRect:				Rect;									{  predecompress,banddecompress  }
		matrix:					MatrixRecordPtr;						{  predecompress,banddecompress  }
		accuracy:				CodecQ;									{  predecompress,banddecompress  }
		transferMode:			INTEGER;								{  predecompress,banddecompress  }
		frameTime:				ICMFrameTimePtr;						{  banddecompress  }
		reserved:				ARRAY [0..0] OF LONGINT;
																		{  The following fields only exist for QuickTime 2.0 and greater  }
		matrixFlags:			SInt8;									{  high bit set if 2x resize  }
		matrixType:				SInt8;
		dstRect:				Rect;									{  only valid for simple transforms  }
																		{  The following fields only exist for QuickTime 2.1 and greater  }
		majorSourceChangeSeed:	UInt16;
		minorSourceChangeSeed:	UInt16;
		sourceData:				CDSequenceDataSourcePtr;
		maskRegion:				RgnHandle;
																		{  The following fields only exist for QuickTime 2.5 and greater  }
		wantedDestinationPixelTypes: ^OSTypePtr;						{  Handle to 0-terminated list of OSTypes  }
		screenFloodMethod:		LONGINT;
		screenFloodValue:		LONGINT;
		preferredOffscreenPixelSize: INTEGER;
	END;


CONST
	matrixFlagScale2x			= $00000080;
	matrixFlagScale1x			= $00000040;
	matrixFlagScaleHalf			= $00000020;

	kScreenFloodMethodNone		= 0;
	kScreenFloodMethodKeyColor	= 1;
	kScreenFloodMethodAlpha		= 2;

{ 	codec selectors 0-127 are reserved by Apple  }
{ 	codec selectors 128-191 are subtype specific  }
{ 	codec selectors 192-255 are vendor specific  }
{ 	codec selectors 256-32767 are available for general use  }
{ 	negative selectors are reserved by the Component Manager  }
FUNCTION ImageCodecGetCodecInfo(ci: ComponentInstance; VAR info: CodecInfo): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0000, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecGetCompressionTime(ci: ComponentInstance; src: PixMapHandle; {CONST}VAR srcRect: Rect; depth: INTEGER; VAR spatialQuality: CodecQ; VAR temporalQuality: CodecQ; VAR time: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0016, $0001, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecGetMaxCompressionSize(ci: ComponentInstance; src: PixMapHandle; {CONST}VAR srcRect: Rect; depth: INTEGER; quality: CodecQ; VAR size: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0012, $0002, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecPreCompress(ci: ComponentInstance; VAR params: CodecCompressParams): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0003, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecBandCompress(ci: ComponentInstance; VAR params: CodecCompressParams): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0004, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecPreDecompress(ci: ComponentInstance; VAR params: CodecDecompressParams): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0005, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecBandDecompress(ci: ComponentInstance; VAR params: CodecDecompressParams): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0006, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecBusy(ci: ComponentInstance; seq: ImageSequence): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0007, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecGetCompressedImageSize(ci: ComponentInstance; desc: ImageDescriptionHandle; data: Ptr; bufferSize: LONGINT; dataProc: ICMDataProcRecordPtr; VAR dataSize: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0014, $0008, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecGetSimilarity(ci: ComponentInstance; src: PixMapHandle; {CONST}VAR srcRect: Rect; desc: ImageDescriptionHandle; data: Ptr; VAR similarity: Fixed): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0014, $0009, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecTrimImage(ci: ComponentInstance; Desc: ImageDescriptionHandle; inData: Ptr; inBufferSize: LONGINT; dataProc: ICMDataProcRecordPtr; outData: Ptr; outBufferSize: LONGINT; flushProc: ICMFlushProcRecordPtr; VAR trimRect: Rect; progressProc: ICMProgressProcRecordPtr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0024, $000A, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecRequestSettings(ci: ComponentInstance; settings: Handle; VAR rp: Rect; filterProc: ModalFilterUPP): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $000B, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecGetSettings(ci: ComponentInstance; settings: Handle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $000C, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecSetSettings(ci: ComponentInstance; settings: Handle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $000D, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecFlush(ci: ComponentInstance): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0000, $000E, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecSetTimeCode(ci: ComponentInstance; timeCodeFormat: UNIV Ptr; timeCodeTime: UNIV Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $000F, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecIsImageDescriptionEquivalent(ci: ComponentInstance; newDesc: ImageDescriptionHandle; VAR equivalent: BOOLEAN): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0008, $0010, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecNewMemory(ci: ComponentInstance; VAR data: Ptr; dataSize: Size; dataUse: LONGINT; memoryGoneProc: ICMMemoryDisposedUPP; refCon: UNIV Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0014, $0011, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecDisposeMemory(ci: ComponentInstance; data: Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0004, $0012, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecHitTestData(ci: ComponentInstance; desc: ImageDescriptionHandle; data: UNIV Ptr; dataSize: Size; where: Point; VAR hit: BOOLEAN): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0014, $0013, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecNewImageBufferMemory(ci: ComponentInstance; VAR params: CodecDecompressParams; flags: LONGINT; memoryGoneProc: ICMMemoryDisposedUPP; refCon: UNIV Ptr): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0010, $0014, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecExtractAndCombineFields(ci: ComponentInstance; fieldFlags: LONGINT; data1: UNIV Ptr; dataSize1: LONGINT; desc1: ImageDescriptionHandle; data2: UNIV Ptr; dataSize2: LONGINT; desc2: ImageDescriptionHandle; outputData: UNIV Ptr; VAR outDataSize: LONGINT; descOut: ImageDescriptionHandle): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0028, $0015, $7000, $A82A;
	{$ENDC}
FUNCTION ImageCodecGetMaxCompressionSizeWithSources(ci: ComponentInstance; src: PixMapHandle; {CONST}VAR srcRect: Rect; depth: INTEGER; quality: CodecQ; sourceData: CDSequenceDataSourcePtr; VAR size: LONGINT): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0016, $0016, $7000, $A82A;
	{$ENDC}

CONST
	kMotionJPEGTag				= 'mjpg';


TYPE
	MotionJPEGApp1MarkerPtr = ^MotionJPEGApp1Marker;
	MotionJPEGApp1Marker = RECORD
		unused:					LONGINT;
		tag:					LONGINT;
		fieldSize:				LONGINT;
		paddedFieldSize:		LONGINT;
		offsetToNextField:		LONGINT;
		qTableOffset:			LONGINT;
		huffmanTableOffset:		LONGINT;
		sofOffset:				LONGINT;
		sosOffset:				LONGINT;
		soiOffset:				LONGINT;
	END;

FUNCTION QTPhotoSetSampling(codec: ComponentInstance; yH: INTEGER; yV: INTEGER; cbH: INTEGER; cbV: INTEGER; crH: INTEGER; crV: INTEGER): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0100, $7000, $A82A;
	{$ENDC}
FUNCTION QTPhotoSetRestartInterval(codec: ComponentInstance; restartInterval: INTEGER): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0002, $0101, $7000, $A82A;
	{$ENDC}
FUNCTION QTPhotoDefineHuffmanTable(codec: ComponentInstance; componentNumber: INTEGER; isDC: BOOLEAN; VAR lengthCounts: UInt8; VAR values: UInt8): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $000C, $0102, $7000, $A82A;
	{$ENDC}
FUNCTION QTPhotoDefineQuantizationTable(codec: ComponentInstance; componentNumber: INTEGER; VAR table: UInt8): ComponentResult;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $0006, $0103, $7000, $A82A;
	{$ENDC}
{  UPP call backs  }

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ImageCodecIncludes}

{$ENDC} {__IMAGECODEC__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

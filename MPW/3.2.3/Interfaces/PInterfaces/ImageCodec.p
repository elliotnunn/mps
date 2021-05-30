{

Created: Tuesday, October 13, 1992 
 ImageCodec.p
 Pascal Interface to the Macintosh Libraries


 Copyright Apple Computer, Inc. 1991, 1992
 All rights reserved

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ImageCodec;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingImageCodec}
{$SETC UsingImageCodec := 1}

{$I+}
{$SETC ImageCodecIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingQuickDraw}
{$I $$Shell(PInterfaces)QuickDraw.p}
{$ENDC}
{$IFC UNDEFINED UsingQDOffscreen}
{$I $$Shell(PInterfaces)QDOffscreen.p}
{$ENDC}

{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}

{$IFC UNDEFINED UsingComponents}
{$I $$Shell(PInterfaces)Components.p}
{$ENDC}

{$IFC UNDEFINED UsingImageCompression}
{$I $$Shell(PInterfaces)ImageCompression.p}
{$ENDC}


{$SETC UsingIncludes := ImageCodecIncludes}


{	codec component selectors	}
{	codec selectors 0-127 are reserved by Apple }
{	codec selectors 128-191 are subtype specific }
{	codec selectors 192-255 are vendor specific }
{ 	codec selectors 256-32767 are reserved by Apple }
{	negative selectors are reserved by the Component Manager }

CONST
codecGetCodecInfo					= $00;
codecGetCompressionTime				= $01;
codecGetMaxCompressionSize			= $02;
codecPreCompress					= $03;
codecBandCompress					= $04;
codecPreDecompress					= $05;
codecBandDecompress					= $06;
codecCDSequenceBusy					= $07;
codecGetCompressedImageSize			= $08;
codecGetSimilarity					= $09;
codecTrimImage						= $0a;


{	codec capabilities flags	}

codecCanScale						= $1;
codecCanMask						= $2;
codecCanMatte						= $4;
codecCanTransform					= $8;
codecCanTransferMode				= $10;
codecCanCopyPrev					= $20;
codecCanSpool						= $40;
codecCanClipVertical				= $80;
codecCanClipRectangular				= $100;
codecCanRemapColor					= $200;
codecCanFastDither					= $400;
codecCanSrcExtract					= $800;
codecCanCopyPrevComp				= $1000;
codecCanAsync						= $2000;
codecCanMakeMask					= $4000;
codecCanShift						= $8000;

TYPE
CodecCapabilitiesPtr =  ^CodecCapabilities;
CodecCapabilities = RECORD
	flags:	LONGINT;
	wantedPixelSize: INTEGER;
	extendWidth: INTEGER;
	extendHeight: INTEGER;
	bandMin: INTEGER;
	bandInc: INTEGER;
	pad: INTEGER;
	time: INTEGER;
END;

CONST
codecConditionFirstBand				= $1;	
codecConditionLastBand				= $2;
codecConditionFirstFrame			= $4;
codecConditionNewDepth				= $8;
codecConditionNewTransform			= $10;
codecConditionNewSrcRect			= $20;
codecConditionNewMask				= $40;
codecConditionNewMatte				= $80;
codecConditionNewTransferMode		= $100;
codecConditionNewClut				= $200;
codecConditionNewAccuracy			= $400;
codecConditionNewDestination		= $800;
codecConditionCodecChangedMask		= $80000000;


codecInfoResourceType	=	'cdci';					{ codec info resource type }
codecInterfaceVersion = 1;


TYPE
CodecCompressParamsPtr = ^CodecCompressParams;
CodecCompressParams = RECORD
	sequenceID :ImageSequence ;						{ precompress,bandcompress }
	imageDescription: ImageDescriptionHandle;		{ precompress,bandcompress }
	data : Ptr;
	bufferSize : LONGINT;
	frameNumber: LONGINT;
	startLine: LONGINT;
	stopLine: LONGINT;
	conditionFlags: LONGINT;
	callerFlags : CodecFlags;
	capabilities : CodecCapabilitiesPtr;			{ precompress,bandcompress }
	progressProcRecord : ProgressProcRecord;
	completionProcRecord : CompletionProcRecord;	
	flushProcRecord : FlushProcRecord;
	srcPixMap  :PixMap;								{ precompress,bandcompress }
	prevPixMap : PixMap;
	spatialQuality : CodecQ;
	temporalQuality : CodecQ;
	similarity : fixed;
	reserved: ARRAY [0..1] OF LONGINT;		
END;

CodecDecompressParamsPtr = ^CodecDecompressParams;
CodecDecompressParams = RECORD
	sequenceID : ImageSequence;						{ predecompress,banddecompress }
	imageDescription : ImageDescriptionHandle;		{ predecompress,banddecompress }
	data : Ptr;
	bufferSize : LONGINT;
	frameNumber : LONGINT;
	startLine : LONGINT;
	stopLine : LONGINT;
	conditionFlags : LONGINT;
	callerFlags : CodecFlags;
	capabilities : CodecCapabilitiesPtr;			{ predecompress,banddecompress }
	progressProcRecord : ProgressProcRecord;
	completionProcRecord : CompletionProcRecord;
	dataProcRecord : DataProcRecord;
	port : CGrafPtr;								{ predecompress,banddecompress }
	dstPixMap : PixMap;								{ predecompress,banddecompress }
	maskBits : BitMapPtr;
	mattePixMap : PixMapPtr;
	srcRect : Rect;									{ predecompress,banddecompress }
	matrix : MatrixRecordPtr;						{ predecompress,banddecompress }
	accuracy : CodecQ;								{ predecompress,banddecompress }
	transferMode : INTEGER;							{ predecompress,banddecompress }
	reserved : ARRAY [0..1] OF LONGINT;				
END;


FUNCTION CDGetCodecInfo(storage : Handle;VAR info: CodecInfo) : ComponentResult;

FUNCTION CDGetCompressionTime(storage : Handle; src: PixMapHandle; srcRect : Rect;  depth  :INTEGER ;
	 VAR spatialQuality: CodecQ; VAR temporalQuality: CodecQ;VAR time: LONGINT): ComponentResult;
 
FUNCTION CDGetMaxCompressionSize(storage : Handle; src : PixMapHandle; srcRect : Rect; 
	depth : INTEGER; quality : CodecQ;VAR size : LONGINT) : ComponentResult;

FUNCTION CDPreCompress(storage : Handle;params : CodecCompressParamsPtr) : ComponentResult;

FUNCTION CDBandCompress(storage : Handle;params: CodecCompressParamsPtr) : ComponentResult;

FUNCTION CDPreDecompress(storage : Handle;params: CodecDecompressParamsPtr) : ComponentResult;

FUNCTION CDBandDecompress(storage : Handle;params: CodecDecompressParamsPtr) : ComponentResult;
 
FUNCTION CDCodecBusy(storage : Handle;seq : ImageSequence) : ComponentResult;
 
FUNCTION CDGetCompressedImageSize(storage : Handle; desc : ImageDescriptionHandle;data : PTR;
	bufferSize :LONGINT;  dataProc : DataProcRecordPtr;VAR dataSize: LONGINT) : ComponentResult;

FUNCTION CDGetSimilarity(storage : Handle; src : PixMapHandle; srcRect : Rect;
	 desc : ImageDescriptionHandle; data : Ptr; VAR similarity : Fixed) : ComponentResult;

FUNCTION CDTrimImage(storage : Handle; desc : ImageDescriptionHandle; inData: Ptr; inBufferSize : LONGINT; 
	 dataProc : DataProcRecordPtr; outData : Ptr; outBufferSize : LONGINT; 
	 flushProc : FlushProcRecordPtr; VAR trimRect : Rect; progressProc : ProgressProcRecordPtr) : ComponentResult;



{$ENDC} { UsingImageCodec }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}


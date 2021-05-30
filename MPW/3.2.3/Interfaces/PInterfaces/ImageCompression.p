{ All rights reserved

Created: Wednesday, January 27, 1992 at 5:31 PM
 ImageCompression.p
 Pascal Interface to the Macintosh Libraries

 Copyright Apple Computer, Inc. 1991, 1992
 All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT ImageCompression;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingImageCompression}
{$SETC UsingImageCompression := 1}

{$I+}
{$SETC ImageCompressionIncludes := UsingIncludes}
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
{$IFC UNDEFINED UsingStandardFile}
{$I $$Shell(PInterfaces)StandardFile.p}
{$ENDC}
{$SETC UsingIncludes := ImageCompressionIncludes}

CONST
gestaltCompressionMgr = 'icmp';

TYPE
{  Matrix stuff  }
MatrixRecord = RECORD
 matrix: ARRAY [0..2,0..2] OF Fixed;
 END;
MatrixRecordPtr = ^MatrixRecord;

FixedPoint = RECORD
 x: Fixed;
 y: Fixed;
 END;

FixedRect = RECORD
 left: Fixed;
 top: Fixed;
 right: Fixed;
 bottom: Fixed;
 END;

CONST
{ These are the bits that are set in the Component flags, and also in the codecInfo struct. }

codecInfoDoes1 = $1;					{ codec can work with 1-bit pixels }
codecInfoDoes2 = $2;					{ codec can work with 2-bit pixels }
codecInfoDoes4 = $4;					{ codec can work with 4-bit pixels }
codecInfoDoes8 = $8;					{ codec can work with 8-bit pixels }
codecInfoDoes16 = $10;					{ codec can work with 16-bit pixels }
codecInfoDoes32 = $20;					{ codec can work with 32-bit pixels }
codecInfoDoesDither = $40;				{ codec can do ditherMode }
codecInfoDoesStretch = $80;				{ codec can stretch to arbitrary sizes }
codecInfoDoesShrink = $100;				{ codec can shrink to arbitrary sizes }
codecInfoDoesMask = $200;				{ codec can mask to clipping regions }

codecInfoDoesTemporal = $400;			{ codec can handle temporal redundancy }

codecInfoDoesDouble = $800;				{ codec can stretch to double size exactly }
codecInfoDoesQuad = $1000;				{ codec can stretch to quadruple size exactly }
codecInfoDoesHalf = $2000;				{ codec can shrink to half size }
codecInfoDoesQuarter = $4000;			{ codec can shrink to quarter size }

codecInfoDoesRotate = $8000;			{ codec can rotate on decompress }
codecInfoDoesHorizFlip = $10000;		{ codec can flip horizontally on decompress }
codecInfoDoesVertFlip = $20000;			{ codec can flip vertically on decompress }
codecInfoDoesSkew = $40000;				{ codec can skew on decompress }
codecInfoDoesBlend = $80000;			{ codec can blend on decompress }
codecInfoDoesWarp = $100000;			{ codec can warp arbitrarily on decompress }
codecInfoDoesRecompress = $200000;		{ codec can recompress image without accumulating errors }
codecInfoDoesSpool = $400000;			{ codec can spool image data }
codecInfoDoesRateConstrain = $800000;

codecInfoDepth1 = $1;					{ compressed data at 1 bpp depth available }
codecInfoDepth2 = $2;					{ compressed data at 2 bpp depth available }
codecInfoDepth4 = $4;					{ compressed data at 4 bpp depth available }
codecInfoDepth8 = $8;					{ compressed data at 8 bpp depth available }
codecInfoDepth16 = $10;					{ compressed data at 16 bpp depth available }
codecInfoDepth32 = $20;					{ compressed data at 32 bpp depth available }
codecInfoDepth24 = $40;					{ compressed data at 24 bpp depth available }
codecInfoDepth33 = $80;					{ compressed data at 1 bpp monochrome depth  available }
codecInfoDepth34 = $100;				{ compressed data at 2 bpp grayscale depth available }
codecInfoDepth36 = $200;				{ compressed data at 4 bpp grayscale depth available }
codecInfoDepth40 = $400;				{ compressed data at 8 bpp grayscale depth available }
codecInfoStoresClut = $800;				{ compressed data can have custom cluts }
codecInfoDoesLossless = $1000;			{ compressed data can be stored in lossless format }
codecInfoSequenceSensitive = $2000;

codecFlagUseImageBuffer = $1;			{ (input) allocate buffer for whole image on decompress sequence }
codecFlagUseScreenBuffer = $2;			{ (input) allocate buffer for screen on decompress sequence for faster updates }
codecFlagUpdatePrevious = $4;			{ (input) udate previous buffer on compress sequence }
codecFlagNoScreenUpdate = $8;			{ (input) dont update screen, but do update image buffer if allocated }
codecFlagWasCompressed = $10;			{ (input) hint to compressor that image was previously compressed }
codecFlagDontOffscreen = $20;			{ (input) return error instead of automatically going offscreen }
codecFlagUpdatePreviousComp = $40;		{ (input) udate previous buffer on compress sequence }
codecFlagForceKeyFrame = $80;			{ (input) when sent to CompressSequenceFrame, forces that frame to be a key frame }
codecFlagOnlyScreenUpdate = $100;		{ (input) only update screen from }
codecFlagLiveGrab	= $200;				{ (input) data being compressed is from live source (speed is critical) }
codecFlagDontUseNewImageBuffer = $400; 	{ (input) return error if image buffer is new or reallocated }
codecFlagInterlaceUpdate = $800;		{ (input) use interlaced update }


codecFlagUsedNewImageBuffer	= $4000;	{ (output) indicates that image buffer was first used on this decompress sequence }
codecFlagUsedImageBuffer = $8000;		{ (output) indicates that image buffer was used on this decompress sequence }

codecErr = -8960;						{ the codec returned an error }
noCodecErr = -8961;						{ the specified codec could not be found }
codecUnimpErr = -8962;					{ this feature is not implemented by the specified codec }
codecSizeErr = -8963;
codecScreenBufErr = -8964;				{ the screen buffer could not be allocated }
codecImageBufErr = -8965;				{ the image buffer could not be allocated }
codecSpoolErr = -8966;					{ the compressed data must be in memory (spooling did not work) }
codecAbortErr = -8967;					{ the operation was aborted by the progress proc }
codecWouldOffscreenErr = -8968;			{ an offscreen access would have been used, but wasn't allowed because codecFlagDontOffscreen was set }
codecBadDataErr = -8969;				{ compressed data was found to have inconsistencies }
codecDataVersErr = -8970;				{ compressed data was of a format version that codec couldn't handle }
codecExtensionNotFoundErr = -8971;
codecConditionErr = -8972;				{ codec can not do requested operation }
codecOpenErr = -8973;					{ the codec  could not be opened }

codecMinimumDataSize = 32768;			{ The minimum data size for spooling in or out data }

compressorComponentType = 'imco';		{ the type for "Components" which compress images }
decompressorComponentType = 'imdc';		{ the type for "Components" which decompress images }

TYPE
CompressorComponent = Component;		{ a Component which compresses images }
DecompressorComponent = Component;		{ a Component which decompresses images }
CodecComponent = Component;				{ a Component which decompresses or compresses images }

CONST
anyCodec 				=  0;			{ take first working codec of given type }
bestSpeedCodec 			= -1;			{ take fastest codec of given type }
bestFidelityCodec		= -2;			{ take codec which is most accurate}
bestCompressionCodec	= -3;			{ take codec of given type that is most accurate }

TYPE
CodecType = OsType;					{ type descriptor for codecs i.e: 'appl','jpeg','rle ' }

CodecFlags = INTEGER;					{ flags for codec manager calls }

CodecQ = LONGINT;

CONST
codecLosslessQuality	= $400;
codecMaxQuality			= $3FF;
codecMinQuality			= $000;
codecLowQuality			= $100;
codecNormalQuality		= $200;
codecHighQuality		= $300;

TYPE
DataProcPtr = ProcPtr;
FlushProcPtr = ProcPtr;
CompletionProcPtr = ProcPtr;

CONST
codecCompletionSource = 1;				{ asynchronous codec is done with source data  }
codecCompletionDest = 2;				{ asynchronous codec is done with destination data  }

TYPE
ProgressProcPtr = ProcPtr;

CONST
codecProgressOpen = 0;
codecProgressUpdatePercent = 1;
codecProgressClose = 2;

TYPE
StdPixProcPtr = ProcPtr;

ImageSequence = LONGINT;

ProgressProcRecordPtr = ^ProgressProcRecord;
ProgressProcRecord = RECORD
 progressProc: ProgressProcPtr;
 progressRefCon: LONGINT;
 END;

CompletionProcRecordPtr = ^CompletionProcRecord;
CompletionProcRecord = RECORD
 completionProc: CompletionProcPtr;
 completionRefCon: LONGINT;
 END;

DataProcRecordPtr = ^DataProcRecord;
DataProcRecord = RECORD
 dataProc: DataProcPtr;
 dataRefCon: LONGINT;
 END;

FlushProcRecordPtr = ^FlushProcRecord;
FlushProcRecord = RECORD
 flushProc: FlushProcPtr;
 flushRefCon: LONGINT;
 END;


AlignmentProcPtr = ProcPtr;

AlignmentProcRecordPtr = ^AlignmentProcRecord;
AlignmentProcRecord = RECORD
	alignmentProc: AlignmentProcPtr;
	alignmentRefCon: LONGINT;
 END;

DataRateParamsPtr = ^DataRateParams;
DataRateParams = RECORD
	dataRate: LONGINT;
	dataOverrun: LONGINT;
	frameDuration: LONGINT;
	keyFrameRate: LONGINT;
	minSpatialQuality: CodecQ;
	minTemporalQuality: CodecQ;
 END;


{ 
    The ImageDescription is private data which is produced when an image or sequence 
    is compressed. It fully describes the format of the compressed data.}

ImageDescriptionPtr = ^ImageDescription;
ImageDescriptionHandle = ^ImageDescriptionPtr;
ImageDescription = PACKED RECORD
 idSize: LONGINT;						{ total size of ImageDescription including extra data ( CLUTs and other per sequence data }
 cType: CodecType;						{ what kind of codec compressed this data }
 resvd1: LONGINT;						{ reserved for apple use }
 resvd2: INTEGER;						{ reserved for apple use }
 dataRefIndex: INTEGER;					{ set to zero }
 version: INTEGER;						{ which version is this data }
 revisionLevel: INTEGER;				{ what version of that codec did this }
 vendor: LONGINT;						{ whose  codec compressed this data }
 temporalQuality: CodecQ;				{ what was the temporal quality factor          }
 spatialQuality: CodecQ;				{ what was the spatial quality factor          }
 width: INTEGER;						{ how many pixels wide is this data }
 height: INTEGER;						{ how many pixels high is this data }
 hRes: Fixed;							{ horizontal resolution }
 vRes: Fixed;							{ vertical resolution }
 dataSize: LONGINT;						{ if known, the size of data for this image descriptor }
 frameCount: INTEGER;					{ number of frames this description applies to }
 name: PACKED ARRAY [0..31] OF CHAR;	{ name of codec ( in case not installed ) }
 depth: INTEGER;						{ what depth is this data (1-32) or ( 33-40 grayscale ) }
 clutID: INTEGER;						{ clut id or if 0 clut follows  or -1 if no clut }
 END;

{ 
    The CodecInfo is the information returned as the codecInfo struct by a codec Component
    to the codec manager or to the caller. It is specific to the particular codec
    implementation and not to the codec type.}

CodecInfo = PACKED RECORD
 typeName: PACKED ARRAY [0..31] OF CHAR;{ name of the codec type i.e.: 'Apple Image Compression' }
 version: INTEGER;						{ version of the codec data that this codec knows about }
 revisionLevel: INTEGER;				{ revision level of this codec i.e: 0x00010001 (1.0.1) }
 vendor: LONGINT;						{ Maker of this codec i.e: 'appl' }
 decompressFlags: LONGINT;				{ codecInfo flags for decompression capabilities }
 compressFlags: LONGINT;				{ codecInfo flags for compression capabilities }
 formatFlags: LONGINT;					{ codecInfo flags for compression format details }
 compressionAccuracy: CHAR;				{ measure (1-255) of accuracy of this codec for compress (0 if unknown) }
 decompressionAccuracy: CHAR;			{ measure (1-255) of accuracy of this codec for decompress (0 if unknown) }
 compressionSpeed: INTEGER;				{ ( millisecs for compressing 320x240 on base mac II) (0 if unknown) }
 decompressionSpeed: INTEGER;			{ ( millisecs for decompressing 320x240 on mac II)(0 if unknown) }
 compressionLevel: CHAR;				{ measure (1-255) of compression level of this codec (0 if unknown) }
 resvd: CHAR;							{ pad }
 minimumHeight: INTEGER;				{ minimum height of image (block size) }
 minimumWidth: INTEGER;					{ minimum width of image (block size) }
 decompressPipelineLatency: INTEGER;	{ in milliseconds ( for asynchronous codecs ) }
 compressPipelineLatency: INTEGER;		{ in milliseconds ( for asynchronous codecs ) }
 privateData: LONGINT;
 END;

{ Name list returned by GetCodecNameList. }
CodecNameSpec = PACKED RECORD
 codec: CodecComponent;
 cType: CodecType;
 typeName: PACKED ARRAY [0..31] OF CHAR;
 name: Handle;
 END;

CodecNameSpecListPtr = ^CodecNameSpecList;
CodecNameSpecList = RECORD
 count: INTEGER;
 list: ARRAY [0..0] OF CodecNameSpec;
 END;

CONST
defaultDither	= 0;
forceDither		= 1;
suppressDither	= 2;


FUNCTION CodecManagerVersion(VAR version: LONGINT): OSErr;
 INLINE $7000,$AAA3;
FUNCTION GetCodecNameList(VAR list: CodecNameSpecListPtr;showAll: INTEGER): OSErr;
 INLINE $7001,$AAA3;
FUNCTION DisposeCodecNameList(list: CodecNameSpecListPtr): OSErr;
INLINE  $700F,$AAA3;
FUNCTION GetCodecInfo(VAR info: CodecInfo;cType: CodecType;codec: CodecComponent): OSErr;
 INLINE $7003,$AAA3;
FUNCTION GetMaxCompressionSize(src: PixMapHandle;srcRect: Rect;colorDepth: INTEGER;
 quality: CodecQ;cType: CodecType;codec: CompressorComponent;VAR size: LONGINT): OSErr;
 INLINE $7004,$AAA3;
FUNCTION GetCompressionTime(src: PixMapHandle; srcRect: Rect;colorDepth: INTEGER;
 cType: CodecType;codec: CompressorComponent;VAR spatialQuality: CodecQ;
 VAR temporalQuality: CodecQ;VAR compressTime: LONGINT): OSErr;
 INLINE $7005,$AAA3;
FUNCTION CompressImage(src: PixMapHandle; srcRect: Rect;quality: CodecQ;
 cType: CodecType;desc: ImageDescriptionHandle;data: Ptr): OSErr;
 INLINE $7006,$AAA3;
FUNCTION FCompressImage(src: PixMapHandle; srcRect: Rect;colorDepth: INTEGER;
 quality: CodecQ;cType: CodecType;codec: CompressorComponent;clut: CTabHandle;
 flags: CodecFlags;bufferSize: LONGINT;flushProc: FlushProcRecordPtr;progressProc: ProgressProcRecordPtr;
 desc: ImageDescriptionHandle;data: Ptr): OSErr;
 INLINE $7007,$AAA3;
FUNCTION DecompressImage(data: Ptr;desc: ImageDescriptionHandle;dst: PixMapHandle;
  srcRect: Rect; dstRect: Rect;mode: INTEGER;mask: RgnHandle): OSErr;
 INLINE $7008,$AAA3;
FUNCTION FDecompressImage(data: Ptr;desc: ImageDescriptionHandle;dst: PixMapHandle;
  srcRect: Rect;matrix: MatrixRecordPtr;mode: INTEGER;mask: RgnHandle;
 matte: PixMapHandle; matteRect: Rect;accuracy: CodecQ;codec: DecompressorComponent;
 bufferSize: LONGINT;dataProc: DataProcRecordPtr;progressProc: ProgressProcRecordPtr): OSErr;
 INLINE $7009,$AAA3;
FUNCTION CompressSequenceBegin(VAR seqID: ImageSequence;src: PixMapHandle;
 prev: PixMapHandle; srcRect: Rect; prevRect: Rect;colorDepth: INTEGER;
 cType: CodecType;codec: CompressorComponent;spatialQuality: CodecQ;temporalQuality: CodecQ;
 keyFrameRate: LONGINT;clut: CTabHandle;flags: CodecFlags;desc: ImageDescriptionHandle): OSErr;
 INLINE $700A,$AAA3;
FUNCTION CompressSequenceFrame(seqID: ImageSequence;src: PixMapHandle; srcRect: Rect;
 flags: CodecFlags;data: Ptr;VAR dataSize: LONGINT;VAR similarity: Byte;
 asyncCompletionProc: CompletionProcRecordPtr): OSErr;
  INLINE $206F,$0004,$4250,$52AF,$0004,$700B,$AAA3;
FUNCTION DecompressSequenceBegin(VAR seqID: ImageSequence;desc: ImageDescriptionHandle;
 port: CGrafPtr;gdh: GDHandle; srcRect: Rect;matrix: MatrixRecordPtr;
 mode: INTEGER;mask: RgnHandle;flags: CodecFlags;accuracy: CodecQ;codec: DecompressorComponent): OSErr;
 INLINE $700D,$AAA3;
FUNCTION DecompressSequenceFrame(seqID: ImageSequence;data: Ptr;inFlags: CodecFlags;
 VAR outFlags: CodecFlags;asyncCompletionProc: CompletionProcRecordPtr): OSErr;
 INLINE $700E,$AAA3;
FUNCTION SetDSequenceMatrix(seqID: ImageSequence;matrix: MatrixRecordPtr): OSErr;
 INLINE $7010,$AAA3;
FUNCTION SetDSequenceMatte(seqID: ImageSequence;matte: PixMapHandle; matteRect: Rect): OSErr;
 INLINE $7011,$AAA3;
FUNCTION SetDSequenceMask(seqID: ImageSequence;mask: RgnHandle): OSErr;
 INLINE $7012,$AAA3;
FUNCTION SetDSequenceTransferMode(seqID: ImageSequence;mode: INTEGER; opColor: RGBColor): OSErr;
 INLINE $7013,$AAA3;
FUNCTION SetDSequenceDataProc(seqID: ImageSequence;dataProc: DataProcRecordPtr;
 bufferSize: LONGINT): OSErr;
 INLINE $7014,$AAA3;
FUNCTION SetDSequenceAccuracy(seqID: ImageSequence;accuracy: CodecQ): OSErr;
 INLINE $7034,$AAA3;
FUNCTION SetDSequenceSrcRect(seqID: ImageSequence; srcRect: Rect): OSErr;
 INLINE $7035,$AAA3;
FUNCTION GetDSequenceImageBuffer(seqID: ImageSequence;VAR gworld: GWorldPtr): OSErr;
 INLINE $7015,$AAA3;
FUNCTION GetDSequenceScreenBuffer(seqID: ImageSequence;VAR gworld: GWorldPtr): OSErr;
 INLINE $7016,$AAA3;
FUNCTION SetCSequenceQuality(seqID: ImageSequence;spatialQuality: CodecQ;
 temporalQuality: CodecQ): OSErr;
 INLINE $7017,$AAA3;
FUNCTION SetCSequencePrev(seqID: ImageSequence;prev: PixMapHandle; prevRect: Rect): OSErr;
 INLINE $7018,$AAA3;
FUNCTION SetCSequenceFlushProc(seqID: ImageSequence;flushProc: FlushProcRecordPtr;
 bufferSize: LONGINT): OSErr;
 INLINE $7033,$AAA3;
FUNCTION SetCSequenceKeyFrameRate(seqID: ImageSequence;keyframerate: LONGINT): OSErr;
 INLINE $7036,$AAA3;
FUNCTION GetCSequenceKeyFrameRate(seqID: ImageSequence; VAR keyframerate: LONGINT): OSErr;
 INLINE $203C,12,75,$AAA3;
FUNCTION GetCSequencePrevBuffer(seqID: ImageSequence;VAR gworld: GWorldPtr): OSErr;
 INLINE $7019,$AAA3;
FUNCTION CDSequenceBusy(seqID: ImageSequence): OSErr;
 INLINE $701A,$AAA3;
FUNCTION CDSequenceEnd(seqID: ImageSequence): OSErr;
 INLINE $701B,$AAA3;
FUNCTION GetCompressedImageSize(desc: ImageDescriptionHandle;data: Ptr;
 bufferSize: LONGINT;dataProc: DataProcRecordPtr;VAR dataSize: LONGINT): OSErr;
 INLINE $701C,$AAA3;
FUNCTION GetSimilarity(src: PixMapHandle; srcRect: Rect;desc: ImageDescriptionHandle;
 data: Ptr;VAR similarity: Fixed): OSErr;
 INLINE $701D,$AAA3;
FUNCTION GetImageDescriptionCTable(desc: ImageDescriptionHandle;VAR ctable: CTabHandle): OSErr;
 INLINE $701E,$AAA3;
FUNCTION SetImageDescriptionCTable(desc: ImageDescriptionHandle;ctable: CTabHandle): OSErr;
 INLINE $701F,$AAA3;
FUNCTION GetImageDescriptionExtension(desc: ImageDescriptionHandle;VAR extension: Handle;
 idType: LONGINT;index: LONGINT): OSErr;
 INLINE $7020,$AAA3;
FUNCTION SetImageDescriptionExtension(desc: ImageDescriptionHandle;extension: Handle;
 idType: LONGINT): OSErr;
 INLINE $7021,$AAA3;
FUNCTION RemoveImageDescriptionExtension(desc: ImageDescriptionHandle; idType: LONGINT; index: LONGINT): OSErr;
 INLINE $203C,12,$003A,$AAA3;
FUNCTION CountImageDescriptionExtensionType(desc: ImageDescriptionHandle; idType: LONGINT; VAR count: LONGINT): OSErr;
 INLINE $203C,12,$003B,$AAA3;
FUNCTION GetNextImageDescriptionExtensionType(desc: ImageDescriptionHandle; VAR idType: LONGINT): OSErr;
 INLINE $203C,8,$003C,$AAA3;
FUNCTION FindCodec(cType: CodecType;specCodec: CodecComponent;VAR compressor: CompressorComponent;
 VAR decompressor: DecompressorComponent): OSErr;
 INLINE $7023,$AAA3;
FUNCTION CompressPicture(srcPicture: PicHandle;dstPicture: PicHandle;quality: CodecQ;
 cType: CodecType): OSErr;
 INLINE $7024,$AAA3;
FUNCTION FCompressPicture(srcPicture: PicHandle;dstPicture: PicHandle;colorDepth: INTEGER;
 clut: CTabHandle;quality: CodecQ;doDither: INTEGER;compressAgain: INTEGER;
 progressProc: ProgressProcRecordPtr;cType: CodecType;codec: CompressorComponent): OSErr;
 INLINE $7025,$AAA3;
FUNCTION CompressPictureFile(srcRefNum: INTEGER;dstRefNum: INTEGER;quality: CodecQ;
 cType: CodecType): OSErr;
 INLINE $7026,$AAA3;
FUNCTION FCompressPictureFile(srcRefNum: INTEGER;dstRefNum: INTEGER;colorDepth: INTEGER;
 clut: CTabHandle;quality: CodecQ;doDither: INTEGER;compressAgain: INTEGER;
 progressProc: ProgressProcRecordPtr;cType: CodecType;codec: CompressorComponent): OSErr;
 INLINE $7027,$AAA3;
FUNCTION GetPictureFileHeader(refNum: INTEGER;VAR frame: Rect;VAR header: OpenCPicParams): OSErr;
 INLINE $7028,$AAA3;
FUNCTION DrawPictureFile(refNum: INTEGER; frame: Rect;progressProc: ProgressProcRecordPtr): OSErr;
 INLINE $7029,$AAA3;
FUNCTION DrawTrimmedPicture(srcPicture: PicHandle; frame: Rect;trimMask: RgnHandle;
 doDither: INTEGER;progressProc: ProgressProcRecordPtr): OSErr;
 INLINE $702E,$AAA3;
FUNCTION DrawTrimmedPictureFile(srcRefnum: INTEGER; frame: Rect;trimMask: RgnHandle;
 doDither: INTEGER;progressProc: ProgressProcRecordPtr): OSErr;
 INLINE $702F,$AAA3;
FUNCTION MakeThumbnailFromPicture(picture: PicHandle;colorDepth: INTEGER;
 thumbnail: PicHandle;progressProc: ProgressProcRecordPtr): OSErr;
 INLINE $702A,$AAA3;
FUNCTION MakeThumbnailFromPictureFile(refNum: INTEGER;colorDepth: INTEGER;
 thumbnail: PicHandle;progressProc: ProgressProcRecordPtr): OSErr;
 INLINE $702B,$AAA3;
FUNCTION MakeThumbnailFromPixMap(src: PixMapHandle; srcRect: Rect;colorDepth: INTEGER;
 thumbnail: PicHandle;progressProc: ProgressProcRecordPtr): OSErr;
 INLINE $702C,$AAA3;
FUNCTION TrimImage(desc: ImageDescriptionHandle;inData: Ptr;inBufferSize: LONGINT;
 dataProc: DataProcRecordPtr;outData: Ptr;outBufferSize: LONGINT;flushProc: FlushProcRecordPtr;
  VAR trimRect: Rect;progressProc: ProgressProcRecordPtr): OSErr;
 INLINE $702D,$AAA3;
FUNCTION ConvertImage(srcDD: ImageDescriptionHandle;srcData: Ptr;colorDepth: INTEGER;
 clut: CTabHandle;accuracy: CodecQ;quality: CodecQ;cType: CodecType;codec: CodecComponent;
 dstDD: ImageDescriptionHandle;dstData: Ptr): OSErr;
 INLINE $7030,$AAA3;
FUNCTION GetCompressedPixMapInfo(pix: PixMapPtr;VAR desc: ImageDescriptionHandle;
 VAR data: Ptr;VAR bufferSize: LONGINT; dataProc: DataProcRecordPtr; progressProc: ProgressProcRecordPtr): OSErr;
 INLINE $7037,$AAA3;
FUNCTION SetCompressedPixMapInfo(pix: PixMapPtr;desc: ImageDescriptionHandle;
 data: Ptr;bufferSize: LONGINT;dataProc: DataProcRecordPtr;progressProc: ProgressProcRecordPtr): OSErr;
 INLINE $7038,$AAA3;
FUNCTION StdPix( src: PixMapPtr;  srcRect :Rect; matrix : MatrixRecordPtr; mode : INTEGER;
	mask: RgnHandle ;  matte: PixMapPtr;  matteRect: Rect; flags : INTEGER ) : OSErr;
INLINE $700C,$AAA3;

{   Standard Preview  }
 
PROCEDURE SFGetFilePreview(where: Point;
                    prompt: Str255;
                    fileFilter: FileFilterProcPtr;
                    numTypes: INTEGER;
                    typeList: SFTypeList;
                    dlgHook: DlgHookProcPtr;
                    VAR reply: SFReply);
 INLINE $303C,$41,$AAA3;

PROCEDURE SFPGetFilePreview(where: Point;
                     prompt: Str255;
                     fileFilter: FileFilterProcPtr;
                     numTypes: INTEGER;
                     typeList: SFTypeList;
                     dlgHook: DlgHookProcPtr;
                     VAR reply: SFReply;
                     dlgID: INTEGER;
                     filterProc: ModalFilterProcPtr);
 INLINE $303C,$42,$AAA3;

PROCEDURE StandardGetFilePreview(fileFilter: FileFilterProcPtr;
                          numTypes: INTEGER;
                          typeList: SFTypeList;
                          VAR reply: StandardFileReply);
 INLINE $303C,$43,$AAA3;

PROCEDURE CustomGetFilePreview(fileFilter: FileFilterYDProcPtr;
                        numTypes: INTEGER;
                        typeList: SFTypeList;
                        VAR reply: StandardFileReply;
                        dlgID: INTEGER;
                        where: Point;
                        dlgHook: DlgHookYDProcPtr;
                        filterProc: ModalFilterYDProcPtr;
                        activeList: Ptr;
                        activateProc: ActivateYDProcPtr;
                        yourDataPtr: UNIV Ptr);
 INLINE $303C,$44,$AAA3;

FUNCTION MakeFilePreview(resRefNum: INTEGER;  progress: ProgressProcRecordPtr): OSErr;
 INLINE $303C,$45,$AAA3;

FUNCTION AddFilePreview(resRefNum: INTEGER; previewType: OSType; previewData: Handle): OSErr;
 INLINE $303C,$46,$AAA3;

CONST
    sfpItemPreviewAreaUser = 11;
    sfpItemPreviewStaticText = 12;
    sfpItemPreviewDividerUser = 13;
    sfpItemCreatePreviewButton = 14;
    sfpItemShowPreviewButton = 15;

TYPE

PreviewResourcePtr = ^PreviewResourceRecord;
PreviewResourceHandle = ^PreviewResourcePtr;
PreviewResourceRecord = RECORD
	modDate : LONGINT;
	version : INTEGER;
	resType : OSType;
	resID : INTEGER;
END;

PROCEDURE AlignScreenRect(VAR rp: Rect; alignmentProc:AlignmentProcRecordPtr);
 INLINE $203C,$8,$4C,$AAA3;
PROCEDURE AlignWindow(wp: WindowPtr; front: Boolean; alignmentRect: RectPtr; alignmentProc:AlignmentProcRecordPtr );
 INLINE $203C,$E,$4D,$AAA3;
PROCEDURE DragAlignedWindow(wp: WindowPtr; startPt: Point; VAR boundsRect: Rect; VAR alignmentRect: Rect; alignmentProc:AlignmentProcRecordPtr);
 INLINE $203C,$14,$4E,$AAA3;
FUNCTION DragAlignedGrayRgn(theRgn: RgnHandle; startPt: Point; VAR boundsRect: Rect;
 VAR slopRect: Rect; axis: INTEGER; actionProc: ProcPtr; VAR alignmentRect: Rect; alignmentProc:AlignmentProcRecordPtr): LONGINT;
 INLINE $203C,$1E,$4F,$AAA3;

FUNCTION SetCSequenceDataRateParams(seqID: ImageSequence; params: DataRateParamsPtr): OSErr;
 INLINE $203C,$8,$50,$AAA3;
FUNCTION SetCSequenceFrameNumber(seqID: ImageSequence; frameNumber: LONGINT): OSErr;
 INLINE $203C,$8,$51,$AAA3;
FUNCTION NewImageGWorld(VAR gworld: GWorldPtr; idh: ImageDescriptionHandle; flags :GWorldFlags): OSErr;
 INLINE $203C,$C,$52,$AAA3;
FUNCTION GetCSequenceDataRateParams(seqID: ImageSequence; params: DataRateParamsPtr): OSErr;
 INLINE $203C,$8,$53,$AAA3;
FUNCTION GetCSequenceFrameNumber(seqID: ImageSequence; VAR frameNumber: LONGINT): OSErr;
 INLINE $203C,$8,$54,$AAA3;
FUNCTION GetBestDeviceRect(VAR gdh: GDHandle; VAR rp: Rect): OSErr;
 INLINE $203C,$8,$55,$AAA3;


CONST
 identityMatrixType			= $00; 						{ result if matrix is identity }
 translateMatrixType		= $01; 						{ result if matrix translates }
 scaleMatrixType			= $02; 						{ result if matrix scales }
 scaleTranslateMatrixType	= $03; 						{ result if matrix scales and translates }
 linearMatrixType			= $04; 						{ result if matrix is general 2 x 2 }
 linearTranslateMatrixType	= $05; 						{ result if matrix is general 2 x 2 and translates }
 perspectiveMatrixType		= $06; 						{ result if matrix is general 3 x 3 }


FUNCTION GetMatrixType( m: MatrixRecord): INTEGER;
 INLINE $7014,$ABC2;
PROCEDURE CopyMatrix(m1: MatrixRecord;VAR m2: MatrixRecord);
 INLINE $7020,$ABC2;
FUNCTION EqualMatrix(m1: MatrixRecord; m2: MatrixRecord): BOOLEAN;
 INLINE $7021,$ABC2;
PROCEDURE SetIdentityMatrix(VAR matrix: MatrixRecord);
 INLINE $7015,$ABC2;
PROCEDURE TranslateMatrix(VAR m: MatrixRecord;deltaH: Fixed;deltaV: Fixed);
 INLINE $7019,$ABC2;
PROCEDURE RotateMatrix(VAR m: MatrixRecord;degrees: Fixed;aboutX: Fixed;
 aboutY: Fixed);
 INLINE $7016,$ABC2;
PROCEDURE ScaleMatrix(VAR m: MatrixRecord;scaleX: Fixed;scaleY: Fixed;aboutX: Fixed;
 aboutY: Fixed);
 INLINE $7017,$ABC2;
PROCEDURE SkewMatrix(VAR m: MatrixRecord;skewX: Fixed;skewY: Fixed;aboutX: Fixed;
 aboutY: Fixed);
 INLINE $7018,$ABC2;
FUNCTION TransformFixedPoints( m: MatrixRecord;VAR fpt: FixedPoint;count: LONGINT): OSErr;
 INLINE $7022,$ABC2;
FUNCTION TransformPoints( mp: MatrixRecord;VAR pt1: Point;count: LONGINT): OSErr;
 INLINE $7023,$ABC2;
FUNCTION TransformFixedRect( m: MatrixRecord;VAR fr: FixedRect;VAR fpp: FixedPoint): BOOLEAN;
 INLINE $7024,$ABC2;
FUNCTION TransformRect( m: MatrixRecord;VAR r: Rect;VAR fpp: FixedPoint): BOOLEAN;
 INLINE $7025,$ABC2;
FUNCTION TransformRgn( mp: MatrixRecord;r: RgnHandle): OSErr;
 INLINE $7039,$AAA3;
FUNCTION InverseMatrix(m: MatrixRecord; VAR im: MatrixRecord): BOOLEAN;
 INLINE $701C,$ABC2;
PROCEDURE ConcatMatrix(a: MatrixRecord;VAR b: MatrixRecord);
 INLINE $701B,$ABC2;
PROCEDURE RectMatrix(VAR matrix: MatrixRecord; srcRect: Rect; dstRect: Rect);
 INLINE $701E,$ABC2;
PROCEDURE MapMatrix(VAR matrix: MatrixRecord; fromRect: Rect; toRect: Rect);
 INLINE $701D,$ABC2;


{$ENDC} { UsingImageCompression }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

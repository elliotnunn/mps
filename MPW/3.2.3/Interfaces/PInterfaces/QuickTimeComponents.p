
{
Created: Wednesday, January 27, 1992 at 5:31 PM
 QuickTimeComponents.p
 Pascal Interface to the Macintosh Libraries

 Copyright Apple Computer, Inc. 1991, 1992
 All rights reserved

}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT QuickTimeComponents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingQuickTimeComponents}
{$SETC UsingQuickTimeComponents := 1}

{$I+}
{$SETC QuickTimeComponentsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingComponents}
{$I $$Shell(PInterfaces)Components.p}
{$ENDC}
{$IFC UNDEFINED UsingImageCompression}
{$I $$Shell(PInterfaces)ImageCompression.p}
{$ENDC}
{$IFC UNDEFINED UsingMovies}
{$I $$Shell(PInterfaces)Movies.p}
{$ENDC}
{$IFC UNDEFINED UsingQuickDraw}
{$I $$Shell(PInterfaces)QuickDraw.p}
{$ENDC}
{$IFC UNDEFINED UsingMenus}
{$I $$Shell(PInterfaces)Menus.p}
{$ENDC}
{$IFC UNDEFINED UsingVideo}
{$I $$Shell(PInterfaces)Video.p}
{$ENDC}
{$SETC UsingIncludes := QuickTimeComponentsIncludes}

CONST

{****

 Clock Component

****}
clockComponentType 		= 'clok';
systemTickClock 		= 'tick';			{ subtype: 60ths since boot }
systemSecondClock 		= 'seco';			{ subtype: 1000000ths since boot }
systemMillisecondClock	= 'mill';			{ subtype: 1000ths since boot	}
systemMicrosecondClock	= 'micr';			{ subtype: 1000000ths since boot }

kClockRateIsLinear = 1;
kClockImplementsCallBacks = 2;



kClockGetClockTimeSelect = $1;
kClockNewCallBackSelect = $2;
kClockDisposeCallBackSelect = $3;
kClockCallMeWhenSelect = $4;
kClockCancelCallBackSelect = $5;
kClockRateChangedSelect = $6;
kClockTimeChangedSelect = $7;
kClockSetTimeBaseSelect = $8;
kClockStartStopChangedSelect = $9;
kClockGetRateSelect = $A;

{ Same Calls }
FUNCTION ClockGetTime(aClock: ComponentInstance;VAR out: TimeRecord): ComponentResult;
 INLINE $2F3C,$4,$1,$7000,$A82A;
FUNCTION GetClockTime(aClock: ComponentInstance;VAR out: TimeRecord): ComponentResult;
 INLINE $2F3C,$4,$1,$7000,$A82A;
 
FUNCTION ClockNewCallBack(aClock: ComponentInstance;tb: TimeBase;callBackType: INTEGER): QTCallBack;
 INLINE $2F3C,$6,$2,$7000,$A82A;
FUNCTION ClockDisposeCallBack(aClock: ComponentInstance;cb: QTCallBack): ComponentResult;
 INLINE $2F3C,$4,$3,$7000,$A82A;
FUNCTION ClockCallMeWhen(clock: ComponentInstance;cb: QTCallBack;param1: LONGINT;
 param2: LONGINT;param3: LONGINT): ComponentResult;
 INLINE $2F3C,$10,$4,$7000,$A82A;
FUNCTION ClockCancelCallBack(clock: ComponentInstance;cb: QTCallBack): ComponentResult;
 INLINE $2F3C,$4,$5,$7000,$A82A;
FUNCTION ClockRateChanged(clock: ComponentInstance;cb: QTCallBack): ComponentResult;
 INLINE $2F3C,$4,$6,$7000,$A82A;
FUNCTION ClockTimeChanged(clock: ComponentInstance;cb: QTCallBack): ComponentResult;
 INLINE $2F3C,$4,$7,$7000,$A82A;
FUNCTION ClockSetTimeBase(clock: ComponentInstance;tb: TimeBase): ComponentResult;
 INLINE $2F3C,$4,$8,$7000,$A82A;
FUNCTION ClockStartStopChanged(clock: ComponentInstance;cb: QTCallBack; startChanged: Boolean; stopChanged: Boolean): ComponentResult;
 INLINE $2F3C,$8,$9,$7000,$A82A;
FUNCTION ClockGetRate(aClock:ComponentInstance;VAR rate:Fixed) :ComponentResult;
 INLINE $2F3C,$4,$A,$7000,$A82A;



TYPE
{ Sequence Grab Component }
SeqGrabComponent = ComponentInstance;
SGChannel = ComponentInstance;

CONST
SeqGrabComponentType = 'barg';
SeqGrabChannelType = 'sgch';

SeqGrabPanelType = 'sgpn';
SeqGrabCompressionPanelType = 'comp';
SeqGrabSourcePanelType = 'sour';

seqGrabToDisk = 1;
seqGrabToMemory = 2;
seqGrabUseTempMemory = 4;
seqGrabAppendToFile = 8;
seqGrabDontAddMovieResource = $10;
seqGrabDontMakeMovie = $20;
seqGrabPreExtendFile = $40;

TYPE
SeqGrabDataOutputEnum = LONGINT;

CONST
seqGrabRecord = 1;
seqGrabPreview = 2;
seqGrabPlayDuringRecord = 4;

TYPE 
SeqGrabUsageEnum = LONGINT;

CONST
seqGrabHasBounds = 1;
seqGrabHasVolume = 2;
seqGrabHasDiscreteSamples = 4;

TYPE
SeqGrabChannelInfoEnum = LONGINT;

SeqGrabFrameInfo = RECORD
 frameOffset: LONGINT;
 frameTime: LONGINT;
 frameSize: LONGINT;
 frameChannel: SGChannel;
 frameRefCon: LONGINT;
 END;

CONST
grabPictOffScreen = 1;
grabPictIgnoreClip = 2;

sgFlagControlledGrab = 1;

TYPE
SGDataProc = ProcPtr;

SGDeviceName = RECORD
		name	: Str63;
		icon	: Handle;
		flags	: LONGINT;
		refCon	: LONGINT;
		reserved: LONGINT;		{ zero }
END;

CONST
sgDeviceNameFlagDeviceUnavailable = 1;

TYPE
SGDeviceListPtr = ^SGDeviceListRecord;
SGDeviceList = ^SGDeviceListPtr;
SGDeviceListRecord = RECORD
	count:INTEGER;
	selectedIndex:INTEGER;
	reserved:LONGINT;
	entry:ARRAY[0..0] OF SGDeviceName;
END;

CONST
sgDeviceListWithIcons = 1;
sgDeviceListDontCheckAvailability = 2;

seqGrabWriteAppend = 0;
seqGrabWriteReserve = 1;
seqGrabWrite = 2;

seqGrabUnpause = 0;
seqGrabPause = 1;
seqGrabPauseForMenu = 3;

channelFlagDontOpenResFile = 2;
channelFlagHasDependency = 4;

TYPE
SGModalFilterProcPtr = ProcPtr;

CONST
sgPanelFlagForPanel = 1;


channelPlayNormal = 0;
channelPlayFast = 1;
channelPlayHighQuality = 2;
channelPlayAllData = 4;


FUNCTION SGInitialize(s: SeqGrabComponent): ComponentResult;
 INLINE $2F3C,$0,$1,$7000,$A82A;
 
FUNCTION SGSetDataOutput(s: SeqGrabComponent;movieFile: FSSpec;whereFlags: LONGINT): ComponentResult;
 INLINE $2F3C,$8,$2,$7000,$A82A;
FUNCTION SGGetDataOutput(s: SeqGrabComponent;VAR movieFile: FSSpec;VAR whereFlags: LONGINT): ComponentResult;
 INLINE $2F3C,$8,$3,$7000,$A82A;

FUNCTION SGSetGWorld(s: SeqGrabComponent;gp: CGrafPtr;gd: GDHandle): ComponentResult;
 INLINE $2F3C,$8,$4,$7000,$A82A;
FUNCTION SGGetGWorld(s: SeqGrabComponent;VAR gp: CGrafPtr;VAR gd: GDHandle): ComponentResult;
 INLINE $2F3C,$8,$5,$7000,$A82A;

FUNCTION SGNewChannel(s: SeqGrabComponent;channelType: OSType;VAR ref: SGChannel): ComponentResult;
 INLINE $2F3C,$8,$6,$7000,$A82A;
FUNCTION SGDisposeChannel(s: SeqGrabComponent;c: SGChannel): ComponentResult;
 INLINE $2F3C,$4,$7,$7000,$A82A;

FUNCTION SGStartPreview(s: SeqGrabComponent): ComponentResult;
 INLINE $2F3C,$0,$10,$7000,$A82A;
FUNCTION SGStartRecord(s: SeqGrabComponent): ComponentResult;
 INLINE $2F3C,$0,$11,$7000,$A82A;
FUNCTION SGIdle(s: SeqGrabComponent): ComponentResult;
 INLINE $2F3C,$0,$12,$7000,$A82A;
FUNCTION SGStop(s: SeqGrabComponent): ComponentResult;
 INLINE $2F3C,$0,$13,$7000,$A82A;

FUNCTION SGPause(s: SeqGrabComponent;pause: BOOLEAN): ComponentResult;
 INLINE $2F3C,$2,$14,$7000,$A82A;

FUNCTION SGPrepare(s: SeqGrabComponent;prepareForPreview: BOOLEAN;prepareForRecord: BOOLEAN): ComponentResult;
 INLINE $2F3C,$4,$15,$7000,$A82A;
FUNCTION SGRelease(s: SeqGrabComponent): ComponentResult;
 INLINE $2F3C,$0,$16,$7000,$A82A;

FUNCTION SGGetMovie(s: SeqGrabComponent): Movie;
 INLINE $2F3C,$0,$17,$7000,$A82A;

FUNCTION SGSetMaximumRecordTime(s: SeqGrabComponent;ticks: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$18,$7000,$A82A;
FUNCTION SGGetMaximumRecordTime(s: SeqGrabComponent;VAR ticks: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$19,$7000,$A82A;

FUNCTION SGGetStorageSpaceRemaining(s: SeqGrabComponent;VAR bytes: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$1A,$7000,$A82A;
FUNCTION SGGetTimeRemaining(s: SeqGrabComponent;VAR ticksLeft: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$1B,$7000,$A82A;


FUNCTION SGGrabPict(s: SeqGrabComponent; VAR p: PicHandle; bounds: Rect;
 offscreenDepth: INTEGER; grabPictFlags: LONGINT): ComponentResult;
 INLINE $2F3C,$E,$1C,$7000,$A82A;

FUNCTION SGGetLastMovieResID(s: SeqGrabComponent; VAR resID: INTEGER): ComponentResult;
 INLINE $2F3C,$4,$1D,$7000,$A82A;

FUNCTION SGSetFlags(s: SeqGrabComponent; sgFlags: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$1E,$7000,$A82A;
FUNCTION SGGetFlags(s: SeqGrabComponent; VAR sgFlags: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$1F,$7000,$A82A;

FUNCTION SGSetDataProc (s:SeqGrabComponent;proc:SGDataProc;refCon:LONGINT):ComponentResult;
 INLINE $2F3C,$8,$20,$7000,$A82A;
FUNCTION SGNewChannelFromComponent (s:SeqGrabComponent;VAR newChannel:SGChannel; 
	sgChannelComponent:Component):ComponentResult;
 INLINE $2F3C,$8,$21,$7000,$A82A;
FUNCTION SGDisposeDeviceList (s:SeqGrabComponent;list:SGDeviceList):ComponentResult;
 INLINE $2F3C,$4,$22,$7000,$A82A;
FUNCTION SGAppendDeviceListToMenu (s:SeqGrabComponent;list:SGDeviceList;mh: MenuHandle):ComponentResult;
 INLINE $2F3C,$8,$23,$7000,$A82A;
FUNCTION SGSetSettings (s:SeqGrabComponent; ud:UserData;flags:LONGINT):ComponentResult;
 INLINE $2F3C,$8,$24,$7000,$A82A;
FUNCTION SGGetSettings (s:SeqGrabComponent; VAR ud:UserData; flags:LONGINT):ComponentResult;
 INLINE $2F3C,$8,$25,$7000,$A82A;
FUNCTION SGGetIndChannel (s:SeqGrabComponent;index:INTEGER; VAR ref: SGChannel;VAR chanType: OSType):ComponentResult;
 INLINE $2F3C,$A,$26,$7000,$A82A;
FUNCTION SGUpdate (s:SeqGrabComponent; updateRgn:RgnHandle):ComponentResult;
 INLINE $2F3C,$4,$27,$7000,$A82A;
FUNCTION SGGetPause (s:SeqGrabComponent; VAR paused:Byte):ComponentResult;
 INLINE $2F3C,$4,$28,$7000,$A82A;
FUNCTION SGSettingsDialog (s:SeqGrabComponent;c:SGChannel; numPanels:INTEGER;
	 panelList:ComponentPtr; flags:LONGINT; proc:SGModalFilterProcPtr ; procRefNum:LONGINT):ComponentResult;
 INLINE $2F3C,$16,$29,$7000,$A82A;
FUNCTION SGGetAlignmentProc (s:SeqGrabComponent;alignmentProc:AlignmentProcRecordPtr ):ComponentResult;
 INLINE $F3C,$4,$2A,$7000,$A82A;
FUNCTION SGSetChannelSettings (s:SeqGrabComponent;c:SGChannel; ud:UserData;flags:LONGINT):ComponentResult;
 INLINE $2F3C,$C,$2B,$7000,$A82A;
FUNCTION SGGetChannelSettings (s:SeqGrabComponent;c:SGChannel; VAR ud:UserData;flags:LONGINT):ComponentResult;
 INLINE $2F3C,$C,$2C,$7000,$A82A;
 
 {   calls from Channel to seqGrab   }
FUNCTION SGWriteMovieData(s: SeqGrabComponent;c: SGChannel;p: Ptr;len: LONGINT;
 VAR offset: LONGINT): ComponentResult;
 INLINE $2F3C,$10,$100,$7000,$A82A;
FUNCTION SGAddFrameReference(s: SeqGrabComponent;VAR frameInfo: SeqGrabFrameInfo): ComponentResult;
 INLINE $2F3C,$4,$101,$7000,$A82A;
FUNCTION SGGetNextFrameReference(s: SeqGrabComponent;VAR frameInfo: SeqGrabFrameInfo;
 VAR frameDuration: TimeValue;VAR frameNumber: LONGINT): ComponentResult;
 INLINE $2F3C,$C,$102,$7000,$A82A;
FUNCTION SGGetTimeBase(s: SeqGrabComponent;VAR tb: TimeBase): ComponentResult;
 INLINE $2F3C,$4,$103,$7000,$A82A;
FUNCTION SGSortDeviceList (s:SeqGrabComponent;list:SGDeviceList):ComponentResult;
 INLINE $2F3C,$4,$104,$7000,$A82A;
FUNCTION SGAddMovieData (s:SeqGrabComponent;c:SGChannel;p:Ptr;len:LONGINT; VAR offset:LONGINT; 
	chRefCon:LONGINT; time:TimeValue; writeType:INTEGER):ComponentResult;
 INLINE $2F3C,$1A,$105,$7000,$A82A;
FUNCTION SGChangedSource (s:SeqGrabComponent;c:SGChannel):ComponentResult;
 INLINE $2F3C,$4,$106,$7000,$A82A;



 {   General Channel Routines   }
FUNCTION SGSetChannelUsage(c: SGChannel;usage: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$80,$7000,$A82A;
FUNCTION SGGetChannelUsage(c: SGChannel;VAR usage: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$81,$7000,$A82A;

FUNCTION SGSetChannelBounds(c: SGChannel;bounds: Rect): ComponentResult;
 INLINE $2F3C,$4,$82,$7000,$A82A;
FUNCTION SGGetChannelBounds(c: SGChannel;VAR bounds: Rect): ComponentResult;
 INLINE $2F3C,$4,$83,$7000,$A82A;

FUNCTION SGSetChannelVolume(c: SGChannel;volume: INTEGER): ComponentResult;
 INLINE $2F3C,$2,$84,$7000,$A82A;
FUNCTION SGGetChannelVolume(c: SGChannel;VAR volume: INTEGER): ComponentResult;
 INLINE $2F3C,$4,$85,$7000,$A82A;

FUNCTION SGGetChannelInfo(c: SGChannel;VAR channelInfo: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$86,$7000,$A82A;

FUNCTION SGSetChannelPlayFlags(c: SGChannel;playFlags: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$87,$7000,$A82A;
FUNCTION SGGetChannelPlayFlags(c: SGChannel;VAR playFlags: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$88,$7000,$A82A;

FUNCTION SGSetChannelMaxFrames(c: SGChannel;frameCount: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$89,$7000,$A82A;
FUNCTION SGGetChannelMaxFrames(c: SGChannel;VAR frameCount: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$8A,$7000,$A82A;

FUNCTION SGSetChannelRefCon(c: SGChannel;refCon: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$8B,$7000,$A82A;

FUNCTION SGSetChannelClip (c:SGChannel; theClip:RgnHandle ):ComponentResult;
 INLINE $2F3C,$4,$8C,$7000,$A82A;

FUNCTION SGGetChannelClip (c:SGChannel ;VAR theClip:RgnHandle):ComponentResult;
 INLINE $2F3C,$4,$8D,$7000,$A82A;

FUNCTION SGGetChannelSampleDescription (c:SGChannel;sampleDesc:Handle):ComponentResult;
 INLINE $2F3C,$4,$8E,$7000,$A82A;

FUNCTION SGGetChannelDeviceList (c:SGChannel; selectionFlags:LONGINT;VAR list: SGDeviceList):ComponentResult;
 INLINE $2F3C,$8,$8F,$7000,$A82A;

FUNCTION SGSetChannelDevice (c:SGChannel; name:StringPtr):ComponentResult;
 INLINE $2F3C,$4,$90,$7000,$A82A;

FUNCTION SGSetChannelMatrix (c:SGChannel; VAR m:MatrixRecord):ComponentResult;
 INLINE $2F3C,$4,$91,$7000,$A82A;

FUNCTION SGGetChannelMatrix (c:SGChannel; VAR m:MatrixRecord):ComponentResult;
 INLINE $2F3C,$4,$92,$7000,$A82A;

FUNCTION SGGetChannelTimeScale (c:SGChannel; VAR scale:TimeScale):ComponentResult;
 INLINE $2F3C,$4,$93,$7000,$A82A;

{   calls from seqGrab to Channel   }
FUNCTION SGInitChannel(c: SGChannel;owner: SeqGrabComponent): ComponentResult;
 INLINE $2F3C,$4,$180,$7000,$A82A;
FUNCTION SGWriteSamples(c: SGChannel;m: Movie;theFile: AliasHandle): ComponentResult;
 INLINE $2F3C,$8,$181,$7000,$A82A;
FUNCTION SGGetDataRate(c: SGChannel;VAR bytesPerSecond: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$182,$7000,$A82A;
FUNCTION SGAlignChannelRect (c:SGChannel; VAR r:Rect):ComponentResult;
 INLINE $2F3C,$4,$183,$7000,$A82A;

FUNCTION SGPanelGetDitl(s:SeqGrabComponent; VAR ditl:Handle):ComponentResult;
 INLINE $2F3C,$4,$200,$7000,$A82A;
FUNCTION SGPanelGetTitle (s:SeqGrabComponent; title:Str255 ):ComponentResult;
 INLINE $2F3C,$4,$201,$7000,$A82A;
FUNCTION SGPanelCanRun(s:SeqGrabComponent; c:SGChannel):ComponentResult;
 INLINE $2F3C,$4,$202,$7000,$A82A;
FUNCTION SGPanelInstall (s:SeqGrabComponent; c:SGChannel; d: DialogPtr; itemOffset:INTEGER):ComponentResult;
 INLINE $2F3C,$A,$203,$7000,$A82A;
FUNCTION SGPanelEvent(s:SeqGrabComponent; c:SGChannel; d: DialogPtr; itemOffset:INTEGER;
		VAR theEvent:EventRecord; VAR itemHit:INTEGER; VAR handled:BOOLEAN):ComponentResult;
 INLINE $2F3C,$16,$204,$7000,$A82A;
FUNCTION SGPanelItem(s:SeqGrabComponent; c:SGChannel;d: DialogPtr; 
	itemOffset:INTEGER; itemNum: INTEGER) :ComponentResult;
 INLINE $2F3C,$C,$205,$7000,$A82A;
FUNCTION SGPanelRemove(s:SeqGrabComponent; c:SGChannel; d: DialogPtr; 
	itemOffset:INTEGER):ComponentResult;
 INLINE $2F3C,$A,$206,$7000,$A82A;
FUNCTION SGPanelSetGrabber(s:SeqGrabComponent; sg:SeqGrabComponent ):ComponentResult;
 INLINE $2F3C,$4,$207,$7000,$A82A;
FUNCTION SGPanelSetResFile(s:SeqGrabComponent;  resRef:INTEGER):ComponentResult;
 INLINE $2F3C,$2,$208,$7000,$A82A;
FUNCTION SGPanelGetSettings(s:SeqGrabComponent; c:SGChannel; VAR ud:UserData;
	flags:LONGINT) :ComponentResult;
 INLINE $2F3C,$C,$209,$7000,$A82A;
FUNCTION SGPanelSetSettings(s:SeqGrabComponent; c:SGChannel; ud:UserData;
	 flags:LONGINT):ComponentResult;
 INLINE $2F3C,$C,$20A,$7000,$A82A;
FUNCTION SGPanelValidateInput(s:SeqGrabComponent; VAR ok:BOOLEAN) :ComponentResult;
 INLINE $2F3C,$4,$20B,$7000,$A82A;


TYPE
{ Video Routines }

SGCompressInfo = PACKED RECORD
  buffer: Ptr;
  bufferSize: LONGINT;
  similarity: CHAR;
  reserved: CHAR;
 END;

GrabProc = ProcPtr;
GrabCompleteProc = ProcPtr;
DisplayProc = ProcPtr;
CompressProc = ProcPtr;
CompressCompleteProc = ProcPtr;
AddFrameProc = ProcPtr;
TransferFrameProc = ProcPtr;
GrabCompressCompleteProc = ProcPtr;
DisplayCompressProc = ProcPtr;

VideoBottles = RECORD
 procCount					: INTEGER;
 grabProc					: GrabProc;
 grabCompleteProc			: GrabCompleteProc;
 displayProc				: DisplayProc;
 compressProc				: CompressProc;
 compressCompleteProc		: CompressCompleteProc;
 addFrameProc				: AddFrameProc;
 transferFrameProc			: TransferFrameProc;
 grabCompressCompleteProc	: GrabCompressCompleteProc;
 displayCompressProc		: DisplayCompressProc;
 END;




FUNCTION SGGetSrcVideoBounds(c: SGChannel;VAR r: Rect): ComponentResult;
 INLINE $2F3C,$4,$100,$7000,$A82A;
FUNCTION SGSetVideoRect(c: SGChannel;r: Rect): ComponentResult;
 INLINE $2F3C,$4,$101,$7000,$A82A;
FUNCTION SGGetVideoRect(c: SGChannel;VAR r: Rect): ComponentResult;
 INLINE $2F3C,$4,$102,$7000,$A82A;

FUNCTION SGGetVideoCompressorType(c: SGChannel;VAR compressorType: OSType): ComponentResult;
 INLINE $2F3C,$4,$103,$7000,$A82A;
FUNCTION SGSetVideoCompressorType(c: SGChannel;compressorType: OSType): ComponentResult;
 INLINE $2F3C,$4,$104,$7000,$A82A;

FUNCTION SGSetVideoCompressor(c: SGChannel;depth: INTEGER;compressor: CompressorComponent;
 spatialQuality: CodecQ;temporalQuality: CodecQ;keyFrameRate: LONGINT): ComponentResult;
 INLINE $2F3C,$12,$105,$7000,$A82A;
FUNCTION SGGetVideoCompressor(c: SGChannel;VAR depth: INTEGER;VAR compressor: CompressorComponent;
 VAR spatialQuality: CodecQ;VAR temporalQuality: CodecQ;VAR keyFrameRate: LONGINT): ComponentResult;
 INLINE $2F3C,$14,$106,$7000,$A82A;

FUNCTION SGGetVideoDigitizerComponent(c: SGChannel): ComponentInstance;
 INLINE $2F3C,$0,$107,$7000,$A82A;
FUNCTION SGSetVideoDigitizerComponent(c: SGChannel;vdig: ComponentInstance): ComponentResult;
 INLINE $2F3C,$4,$108,$7000,$A82A;
FUNCTION SGVideoDigitizerChanged(c: SGChannel): ComponentResult;
 INLINE $2F3C,$0,$109,$7000,$A82A;

FUNCTION SGSetVideoBottlenecks(c: SGChannel;VAR vb: VideoBottles): ComponentResult;
 INLINE $2F3C,$4,$10A,$7000,$A82A;
FUNCTION SGGetVideoBottlenecks(c: SGChannel;VAR vb: VideoBottles): ComponentResult;
 INLINE $2F3C,$4,$10B,$7000,$A82A;

FUNCTION SGGrabFrame(c: SGChannel;bufferNum: INTEGER): ComponentResult;
 INLINE $2F3C,$2,$10C,$7000,$A82A;
FUNCTION SGGrabFrameComplete(c: SGChannel;bufferNum:INTEGER;VAR done:Boolean): ComponentResult;
 INLINE $2F3C,$6,$10D,$7000,$A82A;

FUNCTION SGDisplayFrame(c: SGChannel;bufferNum: INTEGER;mp: MatrixRecord;
 clipRgn: RgnHandle): ComponentResult;
 INLINE $2F3C,$A,$10E,$7000,$A82A;
FUNCTION SGCompressFrame(c: SGChannel;bufferNum:INTEGER): ComponentResult;
 INLINE $2F3C,$2,$10F,$7000,$A82A;
FUNCTION SGCompressFrameComplete(c: SGChannel;bufferNum:INTEGER;VAR done:Boolean;
 VAR ci:SGCompressInfo): ComponentResult;
 INLINE $2F3C,$A,$110,$7000,$A82A;
FUNCTION SGAddFrame(c: SGChannel;bufferNum:INTEGER;atTime: TimeValue;scale: TimeScale;
 ci: SGCompressInfo): ComponentResult;
 INLINE $2F3C,$E,$111,$7000,$A82A;

FUNCTION SGTransferFrameForCompress(c: SGChannel;bufferNum:INTEGER;mp: MatrixRecord;
 clipRgn: RgnHandle): ComponentResult;
 INLINE $2F3C,$A,$112,$7000,$A82A;

FUNCTION SGSetCompressBuffer(c: SGChannel;depth: INTEGER;compressSize: Rect): ComponentResult;
 INLINE $2F3C,$6,$113,$7000,$A82A;

FUNCTION SGGetCompressBuffer(c: SGChannel;VAR depth: INTEGER; VAR compressSize: Rect): ComponentResult;
 INLINE $2F3C,$8,$114,$7000,$A82A;

FUNCTION SGGetBufferInfo(c: SGChannel;bufferNum: INTEGER; VAR bufferPM: PixMapHandle;
 VAR bufferRect: Rect;VAR compressBuffer: GWorldPtr;
 VAR compressBufferRect: Rect): ComponentResult;
 INLINE $2F3C,$12,$115,$7000,$A82A;

FUNCTION SGSetUseScreenBuffer (c:SGChannel; useScreenBuffer:BOOLEAN ):ComponentResult;  
 INLINE $2F3C,$2,$116,$7000,$A82A;

FUNCTION SGGetUseScreenBuffer (c:SGChannel; VAR useScreenBuffer:BOOLEAN):ComponentResult;  
 INLINE $2F3C,$4,$117,$7000,$A82A;

FUNCTION SGGrabCompressComplete (c:SGChannel; VAR done:BOOLEAN; VAR ci:SGCompressInfo; VAR tr:TimeRecord) :ComponentResult; 
 INLINE $2F3C,$C,$118,$7000,$A82A;
FUNCTION SGDisplayCompress (c:SGChannel; dataPtr:Ptr;desc:ImageDescriptionHandle; VAR mp: MatrixRecord; clipRgn:RgnHandle ):ComponentResult;  
 INLINE $2F3C,$10,$119,$7000,$A82A;

FUNCTION SGSetFrameRate (c:SGChannel; frameRate:Fixed ):ComponentResult;  
 INLINE $2F3C,$4,$11A,$7000,$A82A;

FUNCTION SGGetFrameRate (c:SGChannel; VAR frameRate:Fixed):ComponentResult;  
 INLINE $2F3C,$4,$11B,$7000,$A82A;




{   Sound Routines   }
FUNCTION SGSetSoundInputDriver(c: SGChannel;driverName: Str255): ComponentResult;
 INLINE $2F3C,$4,$100,$7000,$A82A;
FUNCTION SGGetSoundInputDriver(c: SGChannel): LONGINT;
 INLINE $2F3C,$0,$101,$7000,$A82A;
FUNCTION SGSoundInputDriverChanged(c: SGChannel): ComponentResult;
 INLINE $2F3C,$0,$102,$7000,$A82A;

FUNCTION SGSetSoundRecordChunkSize(c: SGChannel;seconds: LONGINT): ComponentResult;
 INLINE $2F3C,$4,$103,$7000,$A82A;
FUNCTION SGGetSoundRecordChunkSize(c: SGChannel): LONGINT;
 INLINE $2F3C,$0,$104,$7000,$A82A;

FUNCTION SGSetSoundInputRate(c: SGChannel;rate: Fixed): ComponentResult;
 INLINE $2F3C,$4,$105,$7000,$A82A;
FUNCTION SGGetSoundInputRate(c: SGChannel): Fixed;
 INLINE $2F3C,$0,$106,$7000,$A82A;

FUNCTION SGSetSoundInputParameters (c:SGChannel; sampleSize:INTEGER; numChannels:INTEGER;
						compressionType:OSType ):ComponentResult;
	INLINE $2F3C,$8,$107,$7000,$A82A;
FUNCTION SGGetSoundInputParameters (c:SGChannel; VAR sampleSize:INTEGER; VAR numChannels:INTEGER;
						VAR compressionType:OSType ):ComponentResult;
	INLINE $2F3C,$C,$108,$7000,$A82A;



CONST
sgChannelAtom = 'chan';

sgChannelSettingsAtom ='ctom';
sgChannelDescription ='cdsc';
sgChannelSettings ='cset';

sgDeviceNameType ='name';
sgUsageType ='use ';
sgPlayFlagsType ='plyf';
sgClipType ='clip';
sgMatrixType ='mtrx';
sgVolumeType ='volu';

sgPanelSettingsAtom ='ptom';
sgPanelDescription ='pdsc';
sgPanelSettings ='pset';

sgcSoundCompressionType ='scmp';
sgcSoundSampleRateType ='srat';
sgcSoundChannelCountType ='schn';
sgcSoundSampleSizeType ='ssiz';
sgcSoundInputType ='sinp';
sgcSoundGainType ='gain';

sgcVideoHueType ='hue ';
sgcVideoSaturationType ='satr';
sgcVideoContrastType ='trst';
sgcVideoSharpnessType ='shrp';
sgcVideoBrigtnessType ='brit';
sgcVideoBlackLevelType ='blkl';
sgcVideoWhiteLevelType ='whtl';

sgcVideoInputType ='vinp';
sgcVideoFormatType ='vstd';
sgcVideoFilterType ='vflt';

sgcVideoRectType ='vrct';
sgVideoDigitizerType ='vdig';

noDeviceForChannel = -9400;
grabTimeComplete = -9401;
cantDoThatInCurrentMode = -9402;
notEnoughMemoryToGrab = -9403;
notEnoughDiskSpaceToGrab = -9404;
couldntGetRequiredComponent = -9405;
badSGChannel = -9406;
seqGrabInfoNotAvailable = -9407;
deviceCantMeetRequest = -9408;

	kSGInitializeSelect = $1;
	kSGSetDataOutputSelect = $2;
	kSGGetDataOutputSelect = $3;
	kSGSetGWorldSelect = $4;
	kSGGetGWorldSelect = $5;
	kSGNewChannelSelect = $6;
	kSGDisposeChannelSelect = $7;
	kSGStartPreviewSelect = $10;
	kSGStartRecordSelect = $11;
	kSGIdleSelect = $12;
	kSGStopSelect = $13;
	kSGPauseSelect = $14;
	kSGPrepareSelect = $15;
	kSGReleaseSelect = $16;
	kSGGetMovieSelect = $17;
	kSGSetMaximumRecordTimeSelect = $18;
	kSGGetMaximumRecordTimeSelect = $19;
	kSGGetStorageSpaceRemainingSelect = $1A;
	kSGGetTimeRemainingSelect = $1B;
	kSGGrabPictSelect = $1C;
	kSGGetLastMovieResIDSelect = $1D;
	kSGSetFlagsSelect = $1E;
	kSGGetFlagsSelect = $1F;

	kSGSetDataProcSelect = $20;
	kSGNewChannelFromComponentSelect = $21;
	kSGDisposeDeviceListSelect = $22;
	kSGAppendDeviceListToMenuSelect = $23;
	kSGSetSettingsSelect = $24;
	kSGGetSettingsSelect = $25;
	kSGGetIndChannelSelect = $26;
	kSGUpdateSelect = $27;
	kSGGetPauseSelect = $28;
	kSGSettingsDialogSelect = $29;
	kSGGetAlignmentProcSelect = $2A;
	kSGSetChannelSettingsSelect = $2B;
	kSGGetChannelSettingsSelect = $2C;
	
	kSGWriteMovieDataSelect = $100;
	kSGAddFrameReferenceSelect = $101;
	kSGGetNextFrameReferenceSelect = $102;
	kSGGetTimeBaseSelect = $103;
	kSGSortDeviceListSelect = $104;
	kSGAddMovieDataSelect = $105;
	kSGChangedSourceSelect = $106;

	kSGCSetChannelUsageSelect = $80;
	kSGCGetChannelUsageSelect = $81;
	kSGCSetChannelBoundsSelect = $82;
	kSGCGetChannelBoundsSelect = $83;
	kSGCSetChannelVolumeSelect = $84;
	kSGCGetChannelVolumeSelect = $85;
	kSGCGetChannelInfoSelect = $86;
	kSGCSetChannelPlayFlagsSelect = $87;
	kSGCGetChannelPlayFlagsSelect = $88;
	kSGCSetChannelMaxFramesSelect = $89;
	kSGCGetChannelMaxFramesSelect = $8A;
	kSGCSetChannelRefConSelect = $8B;
	kSGCSetChannelClipSelect = $8C;
	kSGCGetChannelClipSelect = $8D;
	kSGCGetChannelSampleDescriptionSelect = $8E;
	kSGCGetChannelDeviceListSelect = $8F;
	kSGCSetChannelDeviceSelect = $90;
	kSGCSetChannelMatrixSelect = $91;
	kSGCGetChannelMatrixSelect = $92;
	kSGCGetChannelTimeScaleSelect = $93;
	
	kSGCInitChannelSelect = $180;
	kSGCWriteSamplesSelect = $181;
	kSGCGetDataRateSelect = $182;
	kSGCAlignChannelRectSelect = $183;
	
	kSGCPanelGetDitlSelect = $200;
	kSGCPanelGetTitleSelect = $201;
	kSGCPanelCanRunSelect = $202;
	kSGCPanelInstallSelect = $203;
	kSGCPanelEventSelect = $204;
	kSGCPanelItemSelect = $205;
	kSGCPanelRemoveSelect = $206;
	kSGCPanelSetGrabberSelect = $207;
	kSGCPanelSetResFileSelect = $208;
	kSGCPanelGetSettingsSelect = $209;
	kSGCPanelSetSettingsSelect = $20A;
	kSGCPanelValidateInputSelect = $20B;


	kSGCGetSrcVideoBoundsSelect = $100;
	kSGCSetVideoRectSelect = $101;
	kSGCGetVideoRectSelect = $102;
	kSGCGetVideoCompressorTypeSelect = $103;
	kSGCSetVideoCompressorTypeSelect = $104;
	kSGCSetVideoCompressorSelect = $105;
	kSGCGetVideoCompressorSelect = $106;
	kSGCGetVideoDigitizerComponentSelect = $107;
	kSGCSetVideoDigitizerComponentSelect = $108;
	kSGCVideoDigitizerChangedSelect = $109;
	kSGCSetVideoBottlenecksSelect = $10A;
	kSGCGetVideoBottlenecksSelect = $10B;
	kSGCGrabFrameSelect = $10C;
	kSGCGrabFrameCompleteSelect = $10D;
	kSGCDisplayFrameSelect = $10E;
	kSGCCompressFrameSelect = $10F;
	kSGCCompressFrameCompleteSelect = $110;
	kSGCAddFrameSelect = $111;
	kSGCTransferFrameForCompressSelect = $112;
	kSGCSetCompressBufferSelect = $113;
	kSGCGetCompressBufferSelect = $114;
	kSGCGetBufferInfoSelect = $115;
	kSGCSetUseScreenBufferSelect = $116;
	kSGCGetUseScreenBufferSelect = $117;
	kSGCGrabCompressCompleteSelect = $118;
	kSGCDisplayCompressSelect = $119;
	kSGCSetFrameRateSelect = $11A;
	kSGCGetFrameRateSelect = $11B;

	kSGCSetSoundInputDriverSelect = $100;
	kSGCGetSoundInputDriverSelect = $101;
	kSGCSoundInputDriverChangedSelect = $102;
	kSGCSetSoundRecordChunkSizeSelect = $103;
	kSGCGetSoundRecordChunkSizeSelect = $104;
	kSGCSetSoundInputRateSelect = $105;
	kSGCGetSoundInputRateSelect = $106;
	kSGCSetSoundInputParametersSelect = $107;
	kSGCGetSoundInputParametersSelect = $108; 


CONST

{
 Video Digitizer Component


  Standard type for video digitizers }
videoDigitizerComponentType = 'vdig';
vdigInterfaceRev = 2;

{ Input Format Standards }
ntscIn = 0;							{ ntsc input format }
currentIn = 0;
palIn = 1;							{ pal input format }
secamIn = 2;						{ secam input format }
ntscReallyIn = 3;

{ Input Formats }
compositeIn = 0;					{ input is composite format }
sVideoIn = 1;						{ input is sVideo format }
rgbComponentIn = 2;					{ input is rgb component format }


{ Video Digitizer PlayThru States }
vdPlayThruOff = 0;
vdPlayThruOn = 1;


{ Input Color Space Modes }
vdDigitizerBW = 0;					{ black and white }
vdDigitizerRGB = 1;					{ rgb color }


{ Phase Lock Loop Modes }
vdBroadcastMode = 0;				{ Broadcast / Laser Disk video mode }
vdVTRMode = 1;						{ VCR / Magnetic media mode }


{ Field Select Options }
vdUseAnyField = 0;
vdUseOddField = 1;
vdUseEvenField = 2;

{ vdig types }
vdTypeBasic = 0;					{ basic, no clipping }
vdTypeAlpha = 1;					{ supports clipping with alpha channel }
vdTypeMask = 2;						{ supports clipping with mask plane }
vdTypeKey = 3;						{ supports clipping with key color(s) }


{ Digitizer Error Codes }
digiUnimpErr = -2201;				{ feature unimplemented }
qtParamErr = -2202;					{ bad input parameter ( out of range, etc ) }
matrixErr = -2203;					{ bad matrix, digitizer did nothing }
notExactMatrix = -2204;				{ warning of bad matrix, digitizer did its best }
noMoreKeyColors = -2205;			{ all key indexes in use }
notExactSize = -2206;				{ Can’t do exact size requested }
badDepth = -2207;					{ Can’t digitize into this depth }
noDMA = -2208;						{ Can’t do DMA digitizing ( i.e. can't go to requested dest }
badCallOrder = -2209;				{ Usually due to a status call being called prior to being setup first }

{ Digitizer Input Capability/Current Flags }
digiInDoesNTSC = $1;				{ digitizer supports NTSC input format }
digiInDoesPAL = $2;					{ digitizer supports PAL input format }
digiInDoesSECAM = $4;				{ digitizer supports SECAM input format }
digiInDoesGenLock = $80;			{ digitizer does genlock }

digiInDoesComposite = $100;			{ digitizer supports composite input type }
digiInDoesSVideo = $200;			{ digitizer supports S-Video input type }
digiInDoesComponent = $400;			{ digitizer supports component (rgb) input type }
digiInVTR_Broadcast = $800;			{ digitizer can differentiate between the two }

digiInDoesColor = $1000;			{ digitizer supports color }
digiInDoesBW = $2000;				{ digitizer supports black & white }


{ Digitizer Input Current Flags (these are valid only during active operating conditions) }
digiInSignalLock = $80000000;		{ digitizer detects input signal is locked - this bit = horiz lock || vertical lock }


{ Digitizer Output Capability/Current Flags }
digiOutDoes1 = $1;					{ digitizer supports 1 bit pixels }
digiOutDoes2 = $2;					{ digitizer supports 2 bit pixels }
digiOutDoes4 = $4;					{ digitizer supports 4 bit pixels }
digiOutDoes8 = $8;					{ digitizer supports 8 bit pixels }
digiOutDoes16 = $10;				{ digitizer supports 16 bit pixels }
digiOutDoes32 = $20;				{ digitizer supports 32 bit pixels }
digiOutDoesDither = $40;			{ digitizer dithers in indexed modes }
digiOutDoesStretch = $80;			{ digitizer can arbitrarily stretch }
digiOutDoesShrink = $100;			{ digitizer can arbitrarily shrink }
digiOutDoesMask = $200;				{ digitizer can mask to clipping regions }

digiOutDoesDouble = $800;			{ digitizer can stretch to exactly double size }
digiOutDoesQuad = $1000;			{ digitizer can stretch exactly quadruple size }
digiOutDoesQuarter = $2000;			{ digitizer can shrink to exactly quarter size }
digiOutDoesSixteenth = $4000;		{ digitizer can shrink to exactly sixteenth size }

digiOutDoesRotate = $8000;			{ digitizer supports rotate transformations }
digiOutDoesHorizFlip = $10000;		{ digitizer supports horizontal flips Sx < 0 }
digiOutDoesVertFlip = $20000;		{ digitizer supports vertical flips Sy < 0 }
digiOutDoesSkew = $40000;			{ digitizer supports skew (shear, twist) }
digiOutDoesBlend = $80000;
digiOutDoesWarp = $100000;

digiOutDoesHW_DMA = $200000;		{ digitizer not constrained to local device }
digiOutDoesHWPlayThru = $400000;	{ digitizer doesn't need time to play thru }
digiOutDoesILUT = $800000;			{ digitizer does inverse LUT for index modes }
digiOutDoesKeyColor = $1000000;		{ digitizer does key color functions too }
digiOutDoesAsyncGrabs = $2000000;	{ digitizer supports async grabs }
digiOutDoesUnreadableScreenBits = $4000000;	{playthru doesn't generate readable bits on screen}
digiOutDoesCompress	=	$8000000;	{ supports alternate output data types }
digiOutDoesCompressOnly =	$10000000;	{ can't provide raw frames anywhere }
digiOutDoesPlayThruDuringCompress = $2000000;	{ digi can do playthru while providing compressed data }

TYPE
VideoDigitizerComponent = ComponentInstance;
VideoDigitizerError = ComponentResult;

{ Types }
DigitizerInfo = RECORD
 vdigType: INTEGER;
 inputCapabilityFlags: LONGINT;
 outputCapabilityFlags: LONGINT;
 inputCurrentFlags: LONGINT;
 outputCurrentFlags: LONGINT;
 slot: INTEGER;						{ temporary for connection purposes }
 gdh: GDHandle;						{ temporary for digitizers that have preferred screen }
 maskgdh: GDHandle;					{ temporary for digitizers that have mask planes }
 minDestHeight: INTEGER;			{ Smallest resizable height }
 minDestWidth: INTEGER;				{ Smallest resizable width }
 maxDestHeight: INTEGER;			{ Largest resizable height }
 maxDestWidth: INTEGER;				{ Largest resizable height }
 blendLevels: INTEGER;				{ Number of blend levels supported (2 if 1 bit mask) }
 Private: LONGINT;					{ reserved }
 END;

VdigType = RECORD
 digType: LONGINT;
 Private: LONGINT;
 END;

VdigTypeListPtr = ^VdigTypeList;
VdigTypeListHandle = ^VdigTypeListPtr;
VdigTypeList = RECORD
 count: INTEGER;
 list: ARRAY [0..0] OF VdigType;
 END;

VdigBufferRec = RECORD
	dest: PixMapHandle;
	location: Point;
	reserved: LONGINT;
	END;

VdigBufferRecListPtr = ^VdigBufferRecList;
VdigBufferRecListHandle = ^VdigBufferRecListPtr;
VdigBufferRecList = RECORD
	count: INTEGER;
	matrix: MatrixRecordPtr ;
	mask: RgnHandle;
	list: ARRAY [0..0] OF VdigBufferRec;
	END;
	
VdigIntProc = ProcPtr;

VDCompressionListPtr = ^VDCompressionList;
VDCompressionListHandle = ^VDCompressionListPtr;
VDCompressionList = RECORD
	codec	:	CodecComponent;
	cType	:	CodecType;
	typeName :	Str63;
	name	:	Str63;
	formatFlags : LONGINT;
	compressFlags : LONGINT;
	reserved 		:	LONGINT;
END; 


CONST

dmaDepth1 = 1;
dmaDepth2 = 2;
dmaDepth4 = 4;
dmaDepth8 = 8;
dmaDepth16 = $10;
dmaDepth32 = $20;
dmaDepth2Gray = $40;
dmaDepth4Gray = $80;
dmaDepth8Gray = $100;

kvdigSelectors = $52;

FUNCTION VDGetMaxSrcRect(ci: VideoDigitizerComponent;inputStd: INTEGER;VAR maxSrcRect: Rect): VideoDigitizerError;
 INLINE $2F3C,$6,$1,$7000,$A82A;
FUNCTION VDGetActiveSrcRect(ci: VideoDigitizerComponent;inputStd: INTEGER;VAR activeSrcRect: Rect): VideoDigitizerError;
 INLINE $2F3C,$6,$2,$7000,$A82A;
FUNCTION VDSetDigitizerRect(ci: VideoDigitizerComponent;VAR digitizerRect: Rect): VideoDigitizerError;
 INLINE $2F3C,$4,$3,$7000,$A82A;
FUNCTION VDGetDigitizerRect(ci: VideoDigitizerComponent;VAR digitizerRect: Rect): VideoDigitizerError;
 INLINE $2F3C,$4,$4,$7000,$A82A;
FUNCTION VDGetVBlankRect(ci: VideoDigitizerComponent;inputStd: INTEGER;VAR vBlankRect: Rect): VideoDigitizerError;
 INLINE $2F3C,$6,$5,$7000,$A82A;
FUNCTION VDGetMaskPixMap(ci: VideoDigitizerComponent;maskPixMap: PixMapHandle): VideoDigitizerError;
 INLINE $2F3C,$4,$6,$7000,$A82A;
FUNCTION VDGetPlayThruDestination(ci: VideoDigitizerComponent;VAR dest: PixMapHandle;
 VAR destRect: Rect;VAR m: MatrixRecord;VAR mask: RgnHandle): VideoDigitizerError;
 INLINE $2F3C,$10,$8,$7000,$A82A;
FUNCTION VDUseThisCLUT(ci: VideoDigitizerComponent;colorTableHandle: CTabHandle): VideoDigitizerError;
 INLINE $2F3C,$4,$9,$7000,$A82A;
FUNCTION VDSetInputGammaValue(ci: VideoDigitizerComponent;channel1: Fixed;channel2: Fixed;
 channel3: Fixed): VideoDigitizerError;
 INLINE $2F3C,$C,$A,$7000,$A82A;
FUNCTION VDGetInputGammaValue(ci: VideoDigitizerComponent;VAR channel1: Fixed;
 VAR channel2: Fixed;VAR channel3: Fixed): VideoDigitizerError;
 INLINE $2F3C,$C,$B,$7000,$A82A;
FUNCTION VDSetBrightness(ci: VideoDigitizerComponent;VAR brightness: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$C,$7000,$A82A;
FUNCTION VDGetBrightness(ci: VideoDigitizerComponent;VAR brightness: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$D,$7000,$A82A;
FUNCTION VDSetContrast(ci: VideoDigitizerComponent;VAR contrast: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$E,$7000,$A82A;
FUNCTION VDSetHue(ci: VideoDigitizerComponent;VAR hue: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$F,$7000,$A82A;
FUNCTION VDSetSharpness(ci: VideoDigitizerComponent;VAR sharpness: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$10,$7000,$A82A;
FUNCTION VDSetSaturation(ci: VideoDigitizerComponent;VAR saturation: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$11,$7000,$A82A;
FUNCTION VDGetContrast(ci: VideoDigitizerComponent;VAR contrast: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$12,$7000,$A82A;
FUNCTION VDGetHue(ci: VideoDigitizerComponent;VAR hue: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$13,$7000,$A82A;
FUNCTION VDGetSharpness(ci: VideoDigitizerComponent;VAR sharpness: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$14,$7000,$A82A;
FUNCTION VDGetSaturation(ci: VideoDigitizerComponent;VAR saturation: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$15,$7000,$A82A;
FUNCTION VDGrabOneFrame(ci: VideoDigitizerComponent): VideoDigitizerError;
 INLINE $2F3C,$0,$16,$7000,$A82A;
FUNCTION VDGetMaxAuxBuffer(ci: VideoDigitizerComponent;VAR pm: PixMapHandle;
 VAR r: Rect): VideoDigitizerError;
 INLINE $2F3C,$8,$17,$7000,$A82A;
FUNCTION VDGetDigitizerInfo(ci: VideoDigitizerComponent;VAR info: DigitizerInfo): VideoDigitizerError;
 INLINE $2F3C,$4,$19,$7000,$A82A;
FUNCTION VDGetCurrentFlags(ci: VideoDigitizerComponent;VAR inputCurrentFlag: LONGINT;
 VAR outputCurrentFlag: LONGINT): VideoDigitizerError;
 INLINE $2F3C,$8,$1A,$7000,$A82A;
FUNCTION VDSetKeyColor(ci: VideoDigitizerComponent;index: LONGINT): VideoDigitizerError;
 INLINE $2F3C,$4,$1B,$7000,$A82A;
FUNCTION VDGetKeyColor(ci: VideoDigitizerComponent;VAR index: LONGINT): VideoDigitizerError;
 INLINE $2F3C,$4,$1C,$7000,$A82A;
FUNCTION VDAddKeyColor(ci: VideoDigitizerComponent;VAR index: LONGINT): VideoDigitizerError;
 INLINE $2F3C,$4,$1D,$7000,$A82A;
FUNCTION VDGetNextKeyColor(ci: VideoDigitizerComponent;index: LONGINT): VideoDigitizerError;
 INLINE $2F3C,$4,$1E,$7000,$A82A;
FUNCTION VDSetKeyColorRange(ci: VideoDigitizerComponent;VAR minRGB: RGBColor;
 VAR maxRGB: RGBColor): VideoDigitizerError;
 INLINE $2F3C,$8,$1F,$7000,$A82A;
FUNCTION VDGetKeyColorRange(ci: VideoDigitizerComponent;VAR minRGB: RGBColor;
 VAR maxRGB: RGBColor): VideoDigitizerError;
 INLINE $2F3C,$8,$20,$7000,$A82A;
FUNCTION VDSetDigitizerUserInterrupt(ci: VideoDigitizerComponent;flags: LONGINT;
 userInterruptProc: VdigIntProc;refcon: LONGINT): VideoDigitizerError;
 INLINE $2F3C,$C,$21,$7000,$A82A;
FUNCTION VDSetInputColorSpaceMode(ci: VideoDigitizerComponent;colorSpaceMode: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$2,$22,$7000,$A82A;
FUNCTION VDGetInputColorSpaceMode(ci: VideoDigitizerComponent;VAR colorSpaceMode: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$23,$7000,$A82A;
FUNCTION VDSetClipState(ci: VideoDigitizerComponent;clipEnable: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$2,$24,$7000,$A82A;
FUNCTION VDGetClipState(ci: VideoDigitizerComponent;VAR clipEnable: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$25,$7000,$A82A;
FUNCTION VDSetClipRgn(ci: VideoDigitizerComponent;clipRegion: RgnHandle): VideoDigitizerError;
 INLINE $2F3C,$4,$26,$7000,$A82A;
FUNCTION VDClearClipRgn(ci: VideoDigitizerComponent;clipRegion: RgnHandle): VideoDigitizerError;
 INLINE $2F3C,$4,$27,$7000,$A82A;
FUNCTION VDGetCLUTInUse(ci: VideoDigitizerComponent;VAR colorTableHandle: CTabHandle): VideoDigitizerError;
 INLINE $2F3C,$4,$28,$7000,$A82A;
FUNCTION VDSetPLLFilterType(ci: VideoDigitizerComponent;pllType: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$2,$29,$7000,$A82A;
FUNCTION VDGetPLLFilterType(ci: VideoDigitizerComponent;VAR pllType: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$2A,$7000,$A82A;
FUNCTION VDGetMaskandValue(ci: VideoDigitizerComponent;blendLevel: INTEGER;
 VAR mask: LONGINT;VAR value: LONGINT): VideoDigitizerError;
 INLINE $2F3C,$A,$2B,$7000,$A82A;
FUNCTION VDSetMasterBlendLevel(ci: VideoDigitizerComponent;VAR blendLevel: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$2C,$7000,$A82A;
FUNCTION VDSetPlayThruDestination(ci: VideoDigitizerComponent;dest: PixMapHandle;
 VAR destRect: Rect;VAR m: MatrixRecord;mask: RgnHandle): VideoDigitizerError;
 INLINE $2F3C,$10,$2D,$7000,$A82A;
FUNCTION VDSetPlayThruOnOff(ci: VideoDigitizerComponent;state: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$2,$2E,$7000,$A82A;
FUNCTION VDSetFieldPreference(ci: VideoDigitizerComponent;fieldFlag: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$2,$2F,$7000,$A82A;
FUNCTION VDGetFieldPreference(ci: VideoDigitizerComponent;VAR fieldFlag: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$30,$7000,$A82A;
FUNCTION VDPreflightDestination(ci: VideoDigitizerComponent;VAR digitizerRect: Rect;
 dest: PixMapHandle;VAR destRect: Rect;VAR m: MatrixRecord): VideoDigitizerError;
 INLINE $2F3C,$10,$32,$7000,$A82A;
FUNCTION VDPreflightGlobalRect(ci: VideoDigitizerComponent;theWindow: GrafPtr;
 VAR globalRect: Rect): VideoDigitizerError;
 INLINE $2F3C,$8,$33,$7000,$A82A;
FUNCTION VDSetPlayThruGlobalRect(ci: VideoDigitizerComponent;theWindow: GrafPtr;
 VAR globalRect: Rect): VideoDigitizerError;
 INLINE $2F3C,$8,$34,$7000,$A82A;
FUNCTION VDSetInputGammaRecord(ci: VideoDigitizerComponent;inputGammaPtr: VDGamRecPtr): VideoDigitizerError;
 INLINE $2F3C,$4,$35,$7000,$A82A;
FUNCTION VDGetInputGammaRecord(ci: VideoDigitizerComponent;VAR inputGammaPtr: VDGamRecPtr): VideoDigitizerError;
 INLINE $2F3C,$4,$36,$7000,$A82A;
FUNCTION VDSetBlackLevelValue(ci: VideoDigitizerComponent;VAR blackLevel: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$37,$7000,$A82A;
FUNCTION VDGetBlackLevelValue(ci: VideoDigitizerComponent;VAR blackLevel: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$38,$7000,$A82A;
FUNCTION VDSetWhiteLevelValue(ci: VideoDigitizerComponent;VAR whiteLevel: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$39,$7000,$A82A;
FUNCTION VDGetWhiteLevelValue(ci: VideoDigitizerComponent;VAR whiteLevel: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$3A,$7000,$A82A;
FUNCTION VDGetVideoDefaults(ci: VideoDigitizerComponent;VAR blackLevel: INTEGER;
 VAR whiteLevel: INTEGER;VAR brightness: INTEGER;VAR hue: INTEGER;VAR saturation: INTEGER;
 VAR contrast: INTEGER;VAR sharpness: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$1C,$3B,$7000,$A82A;
FUNCTION VDGetNumberOfInputs(ci: VideoDigitizerComponent;VAR inputs: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$3C,$7000,$A82A;
FUNCTION VDGetInputFormat(ci: VideoDigitizerComponent;input: INTEGER;VAR format: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$6,$3D,$7000,$A82A;
FUNCTION VDSetInput(ci: VideoDigitizerComponent;input: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$2,$3E,$7000,$A82A;
FUNCTION VDGetInput(ci: VideoDigitizerComponent;VAR input: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$4,$3F,$7000,$A82A;
FUNCTION VDSetInputStandard(ci: VideoDigitizerComponent;inputStandard: INTEGER): VideoDigitizerError;
 INLINE $2F3C,$2,$40,$7000,$A82A;
FUNCTION 	VDSetupBuffers(ci: VideoDigitizerComponent; bufferList: VdigBufferRecListHandle ) : VideoDigitizerError;
 INLINE $2F3C,$4,$41,$7000,$A82A;
FUNCTION 	VDGrabOneFrameAsync(ci: VideoDigitizerComponent; buffer : INTEGER) : VideoDigitizerError;
 INLINE $2F3C,$2,$42,$7000,$A82A;
FUNCTION 	VDDone(ci: VideoDigitizerComponent; buffer : INTEGER) : LONGINT;
 INLINE $2F3C,$2,$43,$7000,$A82A;
FUNCTION VDSetCompression(ci:VideoDigitizerComponent; compressType:OSType; depth:INTEGER; VAR bounds:Rect;
			spatialQuality:CodecQ; temporalQuality:CodecQ; keyFrameRate:LONGINT ) :VideoDigitizerError;
 INLINE $2F3C,$16,$44,$7000,$A82A;

FUNCTION VDCompressOneFrameAsync(ci:VideoDigitizerComponent ):VideoDigitizerError;
 INLINE $2F3C,0,$45,$7000,$A82A;

{ See CompressSequenceFrame in ImageCompression.p for the reason behind this massive glue }
FUNCTION VDCompressDone(ci:VideoDigitizerComponent; VAR done :BOOLEAN; VAR theData:Ptr; VAR dataSize:LONGINT; 
	VAR similarity:Byte; VAR t:TimeRecord):VideoDigitizerError;
 INLINE $206F,$0004,$4250,$52AF,$0004,$2F3C,$14,$46,$7000,$A82A;

FUNCTION VDReleaseCompressBuffer(ci:VideoDigitizerComponent; bufferAddr:Ptr ):VideoDigitizerError;
 INLINE $2F3C,$4,$47,$7000,$A82A;

FUNCTION VDGetImageDescription(ci:VideoDigitizerComponent; desc:ImageDescriptionHandle):VideoDigitizerError;
 INLINE $2F3C,$4,$48,$7000,$A82A;

FUNCTION VDResetCompressSequence(ci:VideoDigitizerComponent ):VideoDigitizerError;
 INLINE $2F3C,0,$49,$7000,$A82A;

FUNCTION VDSetCompressionOnOff(ci:VideoDigitizerComponent; state:BOOLEAN ):VideoDigitizerError; 
 INLINE $2F3C,$2,$4A,$7000,$A82A;

FUNCTION VDGetCompressionTypes(ci:VideoDigitizerComponent; h:VDCompressionListHandle ):VideoDigitizerError; 
 INLINE $2F3C,$4,$4B,$7000,$A82A;

FUNCTION VDSetTimeBase(ci:VideoDigitizerComponent; t:TimeBase ):VideoDigitizerError; 
 INLINE $2F3C,$4,$4C,$7000,$A82A;

FUNCTION VDSetFrameRate(ci:VideoDigitizerComponent; framesPerSecond:Fixed ):VideoDigitizerError; 
 INLINE $2F3C,$4,$4D,$7000,$A82A;

FUNCTION VDGetDataRate(ci:VideoDigitizerComponent; VAR milliSecPerFrame: LONGINT; VAR framesPerSecond:Fixed; VAR bytesPerSecond:LONGINT):VideoDigitizerError;
 INLINE $2F3C,$C,$4E,$7000,$A82A;

FUNCTION VDGetSoundInputDriver(ci:VideoDigitizerComponent; soundDriverName:Str255 ):VideoDigitizerError;
 INLINE $2F3C,$4,$4F,$7000,$A82A;

FUNCTION VDGetDMADepths(ci:VideoDigitizerComponent; VAR depthArray:LONGINT; VAR preferredDepth:LONGINT):VideoDigitizerError;
 INLINE $2F3C,$8,$50,$7000,$A82A;

FUNCTION VDGetPreferredTimeScale(ci:VideoDigitizerComponent; VAR preferred:TimeScale):VideoDigitizerError;
 INLINE $2F3C,$4,$51,$7000,$A82A;

FUNCTION VDReleaseAsyncBuffers(ci:VideoDigitizerComponent):VideoDigitizerError;
 INLINE $2F3C,0,$52,$7000,$A82A;

CONST
{ Video Digitizer Interface }
kSelectVDGetMaxSrcRect = $1;
kSelectVDGetActiveSrcRect = $2;
kSelectVDSetDigitizerRect = $3;
kSelectVDGetDigitizerRect = $4;
kSelectVDGetVBlankRect = $5;
kSelectVDGetMaskPixMap = $6;
kSelectVDGetPlayThruDestination = $8;
kSelectVDUseThisCLUT = $9;
kSelectVDSetInputGammaValue = $A;
kSelectVDGetInputGammaValue = $B;
kSelectVDSetBrightness = $C;
kSelectVDGetBrightness = $D;
kSelectVDSetContrast = $E;
kSelectVDSetHue = $F;
kSelectVDSetSharpness = $10;
kSelectVDSetSaturation = $11;
kSelectVDGetContrast = $12;
kSelectVDGetHue = $13;
kSelectVDGetSharpness = $14;
kSelectVDGetSaturation = $15;
kSelectVDGrabOneFrame = $16;
kSelectVDGetMaxAuxBuffer = $17;
kSelectVDGetDigitizerInfo = $19;
kSelectVDGetCurrentFlags = $1A;
kSelectVDSetKeyColor = $1B;
kSelectVDGetKeyColor = $1C;
kSelectVDAddKeyColor = $1D;
kSelectVDGetNextKeyColor = $1E;
kSelectVDSetKeyColorRange = $1F;
kSelectVDGetKeyColorRange = $20;
kSelectVDSetDigitizerUserInterrupt = $21;
kSelectVDSetInputColorSpaceMode = $22;
kSelectVDGetInputColorSpaceMode = $23;
kSelectVDSetClipState = $24;
kSelectVDGetClipState = $25;
kSelectVDSetClipRgn = $26;
kSelectVDClearClipRgn = $27;
kSelectVDGetCLUTInUse = $28;
kSelectVDSetPLLFilterType = $29;
kSelectVDGetPLLFilterType = $2A;
kSelectVDGetMaskandValue = $2B;
kSelectVDSetMasterBlendLevel = $2C;
kSelectVDSetPlayThruDestination = $2D;
kSelectVDSetPlayThruOnOff = $2E;
kSelectVDSetFieldPreference = $2F;
kSelectVDGetFieldPreference = $30;
kSelectVDPreflightDestination = $32;
kSelectVDPreflightGlobalRect = $33;
kSelectVDSetPlayThruGlobalRect = $34;
kSelectVDSetInputGammaRecord = $35;
kSelectVDGetInputGammaRecord = $36;
kSelectVDSetBlackLevelValue = $37;
kSelectVDGetBlackLevelValue = $38;
kSelectVDSetWhiteLevelValue = $39;
kSelectVDGetWhiteLevelValue = $3A;
kSelectVDGetVideoDefaults = $3B;
kSelectVDGetNumberOfInputs = $3C;
kSelectVDGetInputFormat = $3D;
kSelectVDSetInput = $3E;
kSelectVDGetInput = $3F;
kSelectVDSetInputStandard = $40;
kSelectVDSetupBuffers = $41;
kSelectVDGrabOneFrameAsync = $42;
kSelectVDDone = $43;
kSelectVDSetCompression = $44;
kSelectVDCompressOneFrameAsync = $45;
kSelectVDCompressDone = $46;
kSelectVDReleaseCompressBuffer = $47;
kSelectVDGetImageDescription = $48;
kSelectVDResetCompressSequence = $49;
kSelectVDSetCompressionOnOff = $4A;
kSelectVDGetCompressionTypes = $4B;
kSelectVDSetTimeBase = $4C;
kSelectVDSetFrameRate = $4D;
kSelectVDGetDataRate = $4E;
kSelectVDGetSoundInputDriver = $4F;
kSelectVDGetDMADepths = $50;
kSelectVDGetPreferredTimeScale = $51;
kSelectVDReleaseAsyncBuffers = $52;


CONST
StandardCompressionType	=	'scdi';
StandardCompressionSubType =	'imag';

TYPE
SCModalFilterProcPtr = ProcPtr;
SCModalHookProcPtr = ProcPtr;


CONST
	scListEveryCodec = $2;
	scAllowZeroFrameRate = $4;
	scAllowZeroKeyFrameRate = $8;
	scShowBestDepth = $10;
	scUseMovableModal = $20;

	scPreferCropping = 1;
	scPreferScaling = 2;
	scPreferScalingAndCropping = 3;

	scTestImageWidth = 80;
	scTestImageHeight = 80;

	scOKItem = 1;
	scCancelItem = 2;
	scCustomItem = 3;

	scUserCancelled	=	1;
	
	
TYPE

SCSpatialSettings = RECORD 
	cType 			: CodecType;
	codec 			: CodecComponent;
	depth 			: INTEGER;
	spatialQuality 	: CodecQ;
END;

SCTemporalSettings = RECORD
	temporalQuality : CodecQ;
	frameRate 		: Fixed;
	keyFrameRate	: LONGINT;
END;


SCDataRateSettings = RECORD 
	dataRate			:LONGINT;
	frameDuration		:LONGINT;
	minSpatialQuality	:CodecQ;
	minTemporalQuality	:CodecQ;
END;

SCExtendedProcs = RECORD 
	filterProc	:SCModalFilterProcPtr;
	hookProc	:SCModalHookProcPtr;
	refCon		:LONGINT;
	customName	:Str31;
END; 

CONST
	
	scSpatialSettingsType	=	'sptl';		{	pointer to SCSpatialSettings struct	}	
	scTemporalSettingsType	=	'tprl';		{ pointer to SCTemporalSettings struct	}
	scDataRateSettingsType	=	'drat';		{ pointer to SCDataRateSettings struct	}
	scColorTableType		=	'clut';			{	Pointer to CTabHandle	}
	scProgressProcType		=	'prog';		{ pointer to ProgressRecord struct	}
	scExtendedProcsType		=	'xprc';		{	pointer to SCExtendedProcs struct	}
	scPreferenceFlagsType	=	'pref';	{	pointer to long	}
	scSettingsStateType		=	'ssta';		{	pointer to Handle	}
	scSequenceIDType		=	'sequ';			{	pointer to ImageSequence	}
	scWindowPositionType	=	'wndw';	{	pointer to Point	}
	scCodecFlagsType		=	'cflg';			{	pointer to CodecFlags	}
	
	scInfoNotFoundErr	=	-8971;


FUNCTION SCPositionRect(ci:ComponentInstance;r:RectPtr;VAR where:Point): ComponentResult;
 INLINE $2F3C,$8,$2,$7000,$A82A;
FUNCTION SCPositionDialog(ci:ComponentInstance;id:INTEGER;VAR where:Point): ComponentResult;
 INLINE $2F3C,$6,$3,$7000,$A82A;
FUNCTION SCSetTestImagePictHandle(ci:ComponentInstance;testPict:PicHandle;testRect:RectPtr;testFlags:INTEGER): ComponentResult;
 INLINE $2F3C,$A,$4,$7000,$A82A;
FUNCTION SCSetTestImagePictFile(ci:ComponentInstance;testFileRef:INTEGER;testRect:RectPtr;testFlags:INTEGER): ComponentResult;
 INLINE $2F3C,$8,$5,$7000,$A82A;
FUNCTION SCSetTestImagePixMap(ci:ComponentInstance;testPixMap:PixMapHandle;testRect:RectPtr;testFlags:INTEGER): ComponentResult;
 INLINE $2F3C,$A,$6,$7000,$A82A;
FUNCTION SCGetBestDeviceRect(ci:ComponentInstance;r:RectPtr): ComponentResult;
 INLINE $2F3C,$4,$7,$7000,$A82A;
FUNCTION SCRequestImageSettings(ci:ComponentInstance): ComponentResult;
 INLINE $2F3C,$0,$A,$7000,$A82A;
FUNCTION SCCompressImage(ci:ComponentInstance;src:PixMapHandle;srcRect:Rect;VAR desc:ImageDescriptionHandle; VAR data:Handle): ComponentResult;
 INLINE $2F3C,$10,$B,$7000,$A82A;
FUNCTION SCCompressPicture(ci:ComponentInstance;src,dst:PicHandle): ComponentResult;
 INLINE $2F3C,$8,$C,$7000,$A82A;
FUNCTION SCCompressPictureFile(ci:ComponentInstance;srcRef,dstRef:INTEGER): ComponentResult;
 INLINE $2F3C,$4,$D,$7000,$A82A;
FUNCTION SCRequestSequenceSettings(ci:ComponentInstance): ComponentResult;
 INLINE $2F3C,$0,$E,$7000,$A82A;
FUNCTION SCCompressSequenceBegin(ci:ComponentInstance;src:PixMapHandle;srcRect:Rect;VAR desc:ImageDescriptionHandle): ComponentResult;
 INLINE $2F3C,$C,$F,$7000,$A82A;
FUNCTION SCCompressSequenceFrame(ci:ComponentInstance;src:PixMapHandle;srcRect:Rect;VAR data:Handle;VAR dataSize:LONGINT; VAR notSyncFlag: BOOLEAN): ComponentResult;
 INLINE $2F3C,$14,$10,$7000,$A82A;
FUNCTION SCCompressSequenceEnd(ci:ComponentInstance): ComponentResult;
 INLINE $2F3C,$0,$11,$7000,$A82A;
FUNCTION SCDefaultPictHandleSettings(ci:ComponentInstance;src:PicHandle;motion:BOOLEAN): ComponentResult;
 INLINE $2F3C,$6,$12,$7000,$A82A;
FUNCTION SCDefaultPictFileSettings(ci:ComponentInstance;srcRef:INTEGER;motion:BOOLEAN): ComponentResult;
 INLINE $2F3C,$4,$13,$7000,$A82A;
FUNCTION SCDefaultPixMapSettings(ci:ComponentInstance;src:PixMapHandle;motion:BOOLEAN): ComponentResult;
 INLINE $2F3C,$4,$14,$7000,$A82A;
FUNCTION SCGetInfo(ci:ComponentInstance;infoType:OSType;info:Ptr): ComponentResult;
 INLINE $2F3C,$8,$15,$7000,$A82A;
FUNCTION SCSetInfo(ci:ComponentInstance;infoType:OSType;info:Ptr): ComponentResult;
 INLINE $2F3C,$8,$16,$7000,$A82A;
FUNCTION SCNewGWorld(ci:ComponentInstance; VAR gwp:GWorldPtr; VAR rp:Rect; flags: GWorldFlags):ComponentResult;
 INLINE $2F3C,$C,$17,$7000,$A82A;

CONST
	
	kScPositionRect			=	2;
	kScPositionDialog		=	3;
	kScSetTestImagePictHandle=	4;
	kScSetTestImagePictFile	=	5;
	kScSetTestImagePixMap	=	6;
	kScGetBestDeviceRect		=	7;

	kScRequestImageSettings	=	$A;
	kScCompressImage			=	$B;
	kScCompressPicture		=	$C;
	kScCompressPictureFile	=	$D;
	kScRequestSequenceSettings=	$E;
	kScCompressSequenceBegin	=	$F;
	kScCompressSequenceFrame	=	$10;
	kScCompressSequenceEnd	=	$11;
	kScDefaultPictHandleSettings=	$12;
	kScDefaultPictFileSettings=	$13;
	kScDefaultPixMapSettings	=	$14;
	kScGetInfo				=	$15;
	kScSetInfo				=	$16;
	kScNewGWorld				=	$17;

{ For compatibility }
TYPE
SCParams = RECORD
	flags		:	LONGINT;
	theCodecType:	CodecType;
	theCodec	:	CodecComponent;
	spatialQuality : CodecQ;
	temporalQuality : CodecQ;
	depth			: INTEGER;
	frameRate		: Fixed;
	keyFrameRate	: LONGINT;
	reserved1		: LONGINT;
	reserved2		:	LONGINT;
END; 

CONST
	kScShowMotionSettings = 1;
	kScGetCompression = 1;
	kScSettingsChangedItem = -1;
	
FUNCTION OpenStdCompression : ComponentInstance;
FUNCTION SCGetCompressionExtended(ci:ComponentInstance;VAR sparams:SCParams;where:Point;
 filterProc:SCModalFilterProcPtr;hookProc:SCModalHookProcPtr;refcon:LONGINT;customName:Str255): ComponentResult;
 INLINE $2F3C,$18,$1,$7000,$A82A;
FUNCTION SCGetCompression(ci:ComponentInstance;VAR sparams:SCParams;where:Point): ComponentResult;
 INLINE $42A7,$42A7,$42A7,$42A7,$2F3C,$18,$1,$7000,$A82A;


{

		Movie Import Components

}


TYPE
	MovieImportComponent = ComponentInstance;
	MovieExportComponent = ComponentInstance;

CONST
	MovieImportType = 'eat ';
	MovieExportType = 'spit';
	
	canMovieImportHandles = 1;
	canMovieImportFiles = 2;
	hasMovieImportUserInterface = 4;
	canMovieExportHandles = 8;
	canMovieExportFiles = $10;
	hasMovieExportUserInterface = $20;
	dontAutoFileMovieImport = $40;

	kMovieImportExportOpenSelect = kComponentOpenSelect;
	kMovieImportExportCloseSelect = kComponentCloseSelect;
	kMovieImportExportCanDoSelect = kComponentCanDoSelect;
	kMovieImportExportVersionSelect = kComponentVersionSelect; 

	kMovieImportHandleSelect = 1;
	kMovieImportFileSelect = 2;
	kMovieImportSetFrameDurationSelect = 3;
	kMovieImportSetSampleDescriptionSelect = 4;
	kMovieImportSetMediaFileSelect = 5;
	kMovieImportSetDimensionsSelect = 6;
	kMovieImportSetChunkSizeSelect = 7;
	kMovieImportSetProgressProcSelect = 8;
	kMovieImportSetAuxiliaryDataSelect = 9;
	kMovieImportSetFromScrapSelect = $A;
	kMovieImportDoUserDialogSelect = $B;
	kMovieImportSetDuration = $C;

	kMovieExportToHandleSelect = $80;
	kMovieExportToFileSelect = $81;
	kMovieExportDoUserDialogSelect = $82;
	kMovieExportGetAuxiliaryDataSelect = $83;
	kMovieExportSetProgressProcSelect = $84;

	movieImportCreateTrack = 1;
	movieImportInParallel = 2;
	movieImportMustUseTrack = 4;

	movieImportResultUsedMultipleTracks = 8;


FUNCTION	MovieImportHandle(ci:MovieImportComponent; dataH: Handle; theMovie: Movie; targetTrack: Track; VAR usedTrack: Track; atTime: TimeValue; VAR addedDuration: TimeValue;
		inFlags: LONGINT; VAR outFlags: LONGINT): ComponentResult;
	INLINE $2F3C,$20,$1,$7000,$A82A;

FUNCTION	MovieImportFile(ci:MovieImportComponent; theFile:FSSpec; theMovie: Movie; targetTrack: Track; VAR usedTrack: Track; atTime: TimeValue; VAR addedDuration: TimeValue;
	inFlags: LONGINT; VAR outFlags: LONGINT): ComponentResult;
	INLINE $2F3C,$20,$2,$7000,$A82A;

FUNCTION	MovieImportSetSampleDuration(ci:MovieImportComponent; duration: TimeValue; scale: TimeScale): ComponentResult;
	INLINE $2F3C,$8,$3,$7000,$A82A;

FUNCTION	MovieImportSetSampleDescription(ci:MovieImportComponent; desc: SampleDescriptionHandle; mediaType: OSType): ComponentResult;
	INLINE $2F3C,$8,$4,$7000,$A82A;

FUNCTION	MovieImportSetMediaFile(ci:MovieImportComponent; alias: AliasHandle): ComponentResult;
	INLINE $2F3C,$4,$5,$7000,$A82A;

FUNCTION	MovieImportSetDimensions(ci:MovieImportComponent; width,height: Fixed): ComponentResult;
	INLINE $2F3C,$8,$6,$7000,$A82A;

FUNCTION	MovieImportSetChunkSize(ci:MovieImportComponent; chunkSize:LONGINT): ComponentResult;
	INLINE $2F3C,$4,$7,$7000,$A82A;

FUNCTION	MovieImportSetProgressProc(ci:MovieImportComponent; proc: ProcPtr; refCon: LONGINT): ComponentResult;
	INLINE $2F3C,$8,$8,$7000,$A82A;

FUNCTION	MovieImportSetAuxiliaryData(ci:MovieImportComponent; data: Handle; handleType: OSType): ComponentResult;
	INLINE	$2F3C,$8,$9,$7000,$A82A;

FUNCTION	MovieImportSetFromScrap(ci:MovieImportComponent; fromScrap: BOOLEAN): ComponentResult;
	INLINE	$2F3C,$2,$A,$7000,$A82A;

FUNCTION	MovieImportDoUserDialog(ci:MovieImportComponent; srcFile: FSSpec; data: Handle; VAR canceled: BOOLEAN): ComponentResult;
	INLINE	$2F3C,$C,$B,$7000,$A82A;

FUNCTION	MovieImportSetDuration(ci:MovieImportComponent; duration: TimeValue):ComponentResult;
 INLINE $2F3C,$4,$C,$7000,$A82A;

FUNCTION	MovieExportToHandle(ci:MovieExportComponent; data: Handle; theMovie: Movie; onlyThisTrack: Track; startTime: TimeValue; duration: TimeValue): ComponentResult;
	INLINE	$2F3C,$14,$80,$7000,$A82A;

FUNCTION	MovieExportToFile(ci:MovieExportComponent;dstFile: FSSpec; theMovie: Movie; onlyThisTrack: Track; startTime: TimeValue; duration: TimeValue): ComponentResult;
	INLINE	$2F3C,$14,$81,$7000,$A82A;

FUNCTION	MovieExportDoUserDialog(ci:MovieExportComponent; dstFile: FSSpec; data: Handle; VAR canceled: BOOLEAN): ComponentResult;
	INLINE	$2F3C,$C,$82,$7000,$A82A;

FUNCTION	MovieExportGetAuxiliaryData(ci:MovieExportComponent; dstFile: Handle; VAR handleType: OSType): ComponentResult;
	INLINE	$2F3C,$8,$83,$7000,$A82A;

FUNCTION	MovieExportSetProgressProc(ci:MovieExportComponent; proc: ProcPtr; refCon: LONGINT): ComponentResult;
	INLINE	$2F3C,$8,$84,$7000,$A82A;


TYPE

pnotComponent = ComponentInstance;

CONST
pnotComponentWantsEvents = 1;
pnotComponentNeedsNoCache = 2;

kPreviewOpenSelector = 0;
kPreviewCloseSelector = -1;
kPreviewCanDoSelector = -2;
kPreviewVersionSelector = -3; 

kPreviewShowDataSelector = 1;
kPreviewMakePreviewSelector = 2;
kPreviewMakePreviewReferenceSelector = 3;
kPreviewEventSelector = 4;

ShowFilePreviewComponentType = 'pnot';
CreateFilePreviewrComponentType = 'pmak';

FUNCTION PreviewShowData(p:pnotComponent; dataType:OSType; data:Handle;
		VAR inHere:Rect): ComponentResult;
	INLINE	$2F3C,$C,$1,$7000,$A82A;

FUNCTION PreviewMakePreview(p:pnotComponent; VAR previewType:OSType; VAR previewResult: Handle;
			VAR sourceFile:FSSpec; progress:ProgressProcRecordPtr ): ComponentResult;
	INLINE	$2F3C,$10,$2,$7000,$A82A;

FUNCTION PreviewMakePreviewReference(p:pnotComponent; VAR previewType:OSType; VAR reID:INTEGER;
			VAR sourceFile: FSSpec): ComponentResult;
	INLINE	$2F3C,$C,$3,$7000,$A82A;

FUNCTION PreviewEvent(p:pnotComponent; VAR e:EventRecord; VAR handledEvent:BOOLEAN): ComponentResult;
	INLINE	$2F3C,$8,$4,$7000,$A82A;


{$ENDC} { UsingQuickTimeComponents }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}


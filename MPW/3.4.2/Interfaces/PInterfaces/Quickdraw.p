{
 	File:		Quickdraw.p
 
 	Contains:	QuickDraw Graphics Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.3
 
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
 UNIT Quickdraw;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __QUICKDRAW__}
{$SETC __QUICKDRAW__ := 1}

{$I+}
{$SETC QuickdrawIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}

{$IFC UNDEFINED __QUICKDRAWTEXT__}
{$I QuickdrawText.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	invalColReq					= -1;							{invalid color table request}
{ transfer modes }
	srcCopy						= 0;							{the 16 transfer modes}
	srcOr						= 1;
	srcXor						= 2;
	srcBic						= 3;
	notSrcCopy					= 4;
	notSrcOr					= 5;
	notSrcXor					= 6;
	notSrcBic					= 7;
	patCopy						= 8;
	patOr						= 9;
	patXor						= 10;
	patBic						= 11;
	notPatCopy					= 12;
	notPatOr					= 13;
	notPatXor					= 14;
	notPatBic					= 15;
{ Special Text Transfer Mode }
	grayishTextOr				= 49;
	hilitetransfermode			= 50;
{ Arithmetic transfer modes }
	blend						= 32;
	addPin						= 33;

	addOver						= 34;
	subPin						= 35;
	addMax						= 37;
	adMax						= 37;
	subOver						= 38;
	adMin						= 39;
	ditherCopy					= 64;
{ Transparent mode constant }
	transparent					= 36;
	italicBit					= 1;
	ulineBit					= 2;
	outlineBit					= 3;
	shadowBit					= 4;
	condenseBit					= 5;
	extendBit					= 6;
{ QuickDraw color separation constants }
	normalBit					= 0;							{normal screen mapping}
	inverseBit					= 1;							{inverse screen mapping}
	redBit						= 4;							{RGB additive mapping}
	greenBit					= 3;
	blueBit						= 2;
	cyanBit						= 8;							{CMYBk subtractive mapping}
	magentaBit					= 7;
	yellowBit					= 6;
	blackBit					= 5;
	blackColor					= 33;							{colors expressed in these mappings}
	whiteColor					= 30;
	redColor					= 205;

	greenColor					= 341;
	blueColor					= 409;
	cyanColor					= 273;
	magentaColor				= 137;
	yellowColor					= 69;
	picLParen					= 0;							{standard picture comments}
	picRParen					= 1;
	clutType					= 0;							{0 if lookup table}
	fixedType					= 1;							{1 if fixed table}
	directType					= 2;							{2 if direct values}
	gdDevType					= 0;							{0 = monochrome 1 = color}

	interlacedDevice			= 2;							{ 1 if single pixel lines look bad }
	roundedDevice				= 5;							{ 1 if device has been “rounded” into the GrayRgn }
	hasAuxMenuBar				= 6;							{ 1 if device has an aux menu bar on it }
	burstDevice					= 7;
	ext32Device					= 8;
	ramInit						= 10;							{1 if initialized from 'scrn' resource}
	mainScreen					= 11;							{ 1 if main screen }
	allInit						= 12;							{ 1 if all devices initialized }
	screenDevice				= 13;							{1 if screen device [not used]}
	noDriver					= 14;							{ 1 if no driver for this GDevice }
	screenActive				= 15;							{1 if in use}
	hiliteBit					= 7;							{flag bit in HiliteMode (lowMem flag)}
	pHiliteBit					= 0;							{flag bit in HiliteMode used with BitClr procedure}
	defQDColors					= 127;							{resource ID of clut for default QDColors}
{ pixel type }
	RGBDirect					= 16;							{ 16 & 32 bits/pixel pixelType value }
{ pmVersion values }
	baseAddr32					= 4;							{pixmap base address is 32-bit address}

	sysPatListID				= 0;
	iBeamCursor					= 1;
	crossCursor					= 2;
	plusCursor					= 3;
	watchCursor					= 4;

	kQDGrafVerbFrame			= 0;
	kQDGrafVerbPaint			= 1;
	kQDGrafVerbErase			= 2;
	kQDGrafVerbInvert			= 3;
	kQDGrafVerbFill				= 4;

{$IFC OLDROUTINENAMES }
	frame						= kQDGrafVerbFrame;
	paint						= kQDGrafVerbPaint;
	erase						= kQDGrafVerbErase;
	invert						= kQDGrafVerbInvert;
	fill						= kQDGrafVerbFill;
{$ENDC}

TYPE
	GrafVerb = SInt8;


CONST
	chunky						= 0;
	chunkyPlanar				= 1;
	planar						= 2;

	
TYPE
	PixelType = SInt8;

	Bits16 = ARRAY [0..15] OF INTEGER;

{**************   IMPORTANT NOTE REGARDING Pattern  **************************************
   Patterns were originally defined as:
   
		C: 			typedef unsigned char Pattern[8];
		Pascal:		Pattern = PACKED ARRAY [0..7] OF 0..255;
		
   The old array defintion of Pattern would cause 68000 based CPU's to crash in certain circum-
   stances. The new struct definition is safe, but may require source code changes to compile.
   Read the details in TechNote "Platforms & Tools" #PT 38.
	
********************************************************************************************}
	Pattern = RECORD
		pat:					PACKED ARRAY [0..7] OF SInt8; (* UInt8 *)
	END;

{
 ConstPatternParam is now longer needed.  It was first created when Pattern was an array.
 Now that Pattern is a struct, it is more straight forward just add the "const" qualifier
 on the parameter type (e.g. "const Pattern * pat" instead of "ConstPatternParam pat").
}
	PatPtr = ^Pattern;

	PatHandle = ^PatPtr;

	QDByte = SignedByte;

	QDPtr = Ptr;

	QDHandle = Handle;

	QDErr = INTEGER;


CONST
	singleDevicesBit			= 0;
	dontMatchSeedsBit			= 1;
	allDevicesBit				= 2;

	singleDevices				= 1 * (2**(singleDevicesBit));
	dontMatchSeeds				= 1 * (2**(dontMatchSeedsBit));
	allDevices					= 1 * (2**(allDevicesBit));

	
TYPE
	DeviceLoopFlags = LONGINT;

	BitMap = RECORD
		baseAddr:				Ptr;
		rowBytes:				INTEGER;
		bounds:					Rect;
	END;

	BitMapPtr = ^BitMap;
	BitMapHandle = ^BitMapPtr;

	Cursor = RECORD
		data:					Bits16;
		mask:					Bits16;
		hotSpot:				Point;
	END;

	CursPtr = ^Cursor;
	CursHandle = ^CursPtr;

	PenState = RECORD
		pnLoc:					Point;
		pnSize:					Point;
		pnMode:					INTEGER;
		pnPat:					Pattern;
	END;

	Region = RECORD
		rgnSize:				INTEGER;								{size in bytes}
		rgnBBox:				Rect;									{enclosing rectangle}
	END;

	RgnPtr = ^Region;
	RgnHandle = ^RgnPtr;

	Picture = RECORD
		picSize:				INTEGER;
		picFrame:				Rect;
	END;

	PicPtr = ^Picture;
	PicHandle = ^PicPtr;

	Polygon = RECORD
		polySize:				INTEGER;
		polyBBox:				Rect;
		polyPoints:				ARRAY [0..0] OF Point;
	END;

	PolyPtr = ^Polygon;
	PolyHandle = ^PolyPtr;

	QDTextProcPtr = ProcPtr;  { PROCEDURE QDText(byteCount: INTEGER; textBuf: Ptr; numer: Point; denom: Point); }
	QDLineProcPtr = ProcPtr;  { PROCEDURE QDLine(newPt: Point); }
	QDRectProcPtr = ProcPtr;  { PROCEDURE QDRect(verb: ByteParameter; VAR r: Rect); }
	QDRRectProcPtr = ProcPtr;  { PROCEDURE QDRRect(verb: ByteParameter; VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER); }
	QDOvalProcPtr = ProcPtr;  { PROCEDURE QDOval(verb: ByteParameter; VAR r: Rect); }
	QDArcProcPtr = ProcPtr;  { PROCEDURE QDArc(verb: ByteParameter; VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER); }
	QDPolyProcPtr = ProcPtr;  { PROCEDURE QDPoly(verb: ByteParameter; poly: PolyHandle); }
	QDRgnProcPtr = ProcPtr;  { PROCEDURE QDRgn(verb: ByteParameter; rgn: RgnHandle); }
	QDBitsProcPtr = ProcPtr;  { PROCEDURE QDBits(VAR srcBits: BitMap; VAR srcRect: Rect; VAR dstRect: Rect; mode: INTEGER; maskRgn: RgnHandle); }
	QDCommentProcPtr = ProcPtr;  { PROCEDURE QDComment(kind: INTEGER; dataSize: INTEGER; dataHandle: Handle); }
	QDTxMeasProcPtr = ProcPtr;  { FUNCTION QDTxMeas(byteCount: INTEGER; textAddr: Ptr; VAR numer: Point; VAR denom: Point; VAR info: FontInfo): INTEGER; }
	QDGetPicProcPtr = ProcPtr;  { PROCEDURE QDGetPic(dataPtr: Ptr; byteCount: INTEGER); }
	QDPutPicProcPtr = ProcPtr;  { PROCEDURE QDPutPic(dataPtr: Ptr; byteCount: INTEGER); }
	QDOpcodeProcPtr = ProcPtr;  { PROCEDURE QDOpcode(VAR fromRect: Rect; VAR toRect: Rect; opcode: INTEGER; version: INTEGER); }
	QDJShieldCursorProcPtr = ProcPtr;  { PROCEDURE QDJShieldCursor(left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER); }
	QDTextUPP = UniversalProcPtr;
	QDLineUPP = UniversalProcPtr;
	QDRectUPP = UniversalProcPtr;
	QDRRectUPP = UniversalProcPtr;
	QDOvalUPP = UniversalProcPtr;
	QDArcUPP = UniversalProcPtr;
	QDPolyUPP = UniversalProcPtr;
	QDRgnUPP = UniversalProcPtr;
	QDBitsUPP = UniversalProcPtr;
	QDCommentUPP = UniversalProcPtr;
	QDTxMeasUPP = UniversalProcPtr;
	QDGetPicUPP = UniversalProcPtr;
	QDPutPicUPP = UniversalProcPtr;
	QDOpcodeUPP = UniversalProcPtr;
	QDJShieldCursorUPP = UniversalProcPtr;

	QDProcs = RECORD
		textProc:				QDTextUPP;
		lineProc:				QDLineUPP;
		rectProc:				QDRectUPP;
		rRectProc:				QDRRectUPP;
		ovalProc:				QDOvalUPP;
		arcProc:				QDArcUPP;
		polyProc:				QDPolyUPP;
		rgnProc:				QDRgnUPP;
		bitsProc:				QDBitsUPP;
		commentProc:			QDCommentUPP;
		txMeasProc:				QDTxMeasUPP;
		getPicProc:				QDGetPicUPP;
		putPicProc:				QDPutPicUPP;
	END;

	QDProcsPtr = ^QDProcs;

CONST
	uppQDTextProcInfo = $00003F80; { PROCEDURE (2 byte param, 4 byte param, 4 byte param, 4 byte param); }
	uppQDLineProcInfo = $000000C0; { PROCEDURE (4 byte param); }
	uppQDRectProcInfo = $00000340; { PROCEDURE (1 byte param, 4 byte param); }
	uppQDRRectProcInfo = $00002B40; { PROCEDURE (1 byte param, 4 byte param, 2 byte param, 2 byte param); }
	uppQDOvalProcInfo = $00000340; { PROCEDURE (1 byte param, 4 byte param); }
	uppQDArcProcInfo = $00002B40; { PROCEDURE (1 byte param, 4 byte param, 2 byte param, 2 byte param); }
	uppQDPolyProcInfo = $00000340; { PROCEDURE (1 byte param, 4 byte param); }
	uppQDRgnProcInfo = $00000340; { PROCEDURE (1 byte param, 4 byte param); }
	uppQDBitsProcInfo = $0000EFC0; { PROCEDURE (4 byte param, 4 byte param, 4 byte param, 2 byte param, 4 byte param); }
	uppQDCommentProcInfo = $00000E80; { PROCEDURE (2 byte param, 2 byte param, 4 byte param); }
	uppQDTxMeasProcInfo = $0000FFA0; { FUNCTION (2 byte param, 4 byte param, 4 byte param, 4 byte param, 4 byte param): 2 byte result; }
	uppQDGetPicProcInfo = $000002C0; { PROCEDURE (4 byte param, 2 byte param); }
	uppQDPutPicProcInfo = $000002C0; { PROCEDURE (4 byte param, 2 byte param); }
	uppQDOpcodeProcInfo = $00002BC0; { PROCEDURE (4 byte param, 4 byte param, 2 byte param, 2 byte param); }
	uppQDJShieldCursorProcInfo = $00002A80; { PROCEDURE (2 byte param, 2 byte param, 2 byte param, 2 byte param); }

FUNCTION NewQDTextProc(userRoutine: QDTextProcPtr): QDTextUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDLineProc(userRoutine: QDLineProcPtr): QDLineUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDRectProc(userRoutine: QDRectProcPtr): QDRectUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDRRectProc(userRoutine: QDRRectProcPtr): QDRRectUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDOvalProc(userRoutine: QDOvalProcPtr): QDOvalUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDArcProc(userRoutine: QDArcProcPtr): QDArcUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDPolyProc(userRoutine: QDPolyProcPtr): QDPolyUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDRgnProc(userRoutine: QDRgnProcPtr): QDRgnUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDBitsProc(userRoutine: QDBitsProcPtr): QDBitsUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDCommentProc(userRoutine: QDCommentProcPtr): QDCommentUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDTxMeasProc(userRoutine: QDTxMeasProcPtr): QDTxMeasUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDGetPicProc(userRoutine: QDGetPicProcPtr): QDGetPicUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDPutPicProc(userRoutine: QDPutPicProcPtr): QDPutPicUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDOpcodeProc(userRoutine: QDOpcodeProcPtr): QDOpcodeUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewQDJShieldCursorProc(userRoutine: QDJShieldCursorProcPtr): QDJShieldCursorUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallQDTextProc(byteCount: INTEGER; textBuf: Ptr; numer: Point; denom: Point; userRoutine: QDTextUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQDLineProc(newPt: Point; userRoutine: QDLineUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQDRectProc(verb: ByteParameter; VAR r: Rect; userRoutine: QDRectUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQDRRectProc(verb: ByteParameter; VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER; userRoutine: QDRRectUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQDOvalProc(verb: ByteParameter; VAR r: Rect; userRoutine: QDOvalUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQDArcProc(verb: ByteParameter; VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER; userRoutine: QDArcUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQDPolyProc(verb: ByteParameter; poly: PolyHandle; userRoutine: QDPolyUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQDRgnProc(verb: ByteParameter; rgn: RgnHandle; userRoutine: QDRgnUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQDBitsProc(VAR srcBits: BitMap; VAR srcRect: Rect; VAR dstRect: Rect; mode: INTEGER; maskRgn: RgnHandle; userRoutine: QDBitsUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQDCommentProc(kind: INTEGER; dataSize: INTEGER; dataHandle: Handle; userRoutine: QDCommentUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallQDTxMeasProc(byteCount: INTEGER; textAddr: Ptr; VAR numer: Point; VAR denom: Point; VAR info: FontInfo; userRoutine: QDTxMeasUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQDGetPicProc(dataPtr: Ptr; byteCount: INTEGER; userRoutine: QDGetPicUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQDPutPicProc(dataPtr: Ptr; byteCount: INTEGER; userRoutine: QDPutPicUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQDOpcodeProc(VAR fromRect: Rect; VAR toRect: Rect; opcode: INTEGER; version: INTEGER; userRoutine: QDOpcodeUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallQDJShieldCursorProc(left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER; userRoutine: QDJShieldCursorUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	GrafPort = RECORD
		device:					INTEGER;
		portBits:				BitMap;
		portRect:				Rect;
		visRgn:					RgnHandle;
		clipRgn:				RgnHandle;
		bkPat:					Pattern;
		fillPat:				Pattern;
		pnLoc:					Point;
		pnSize:					Point;
		pnMode:					INTEGER;
		pnPat:					Pattern;
		pnVis:					INTEGER;
		txFont:					INTEGER;
		txFace:					Style;									{txFace is unpacked byte but push as short}
		txMode:					INTEGER;
		txSize:					INTEGER;
		spExtra:				Fixed;
		fgColor:				LONGINT;
		bkColor:				LONGINT;
		colrBit:				INTEGER;
		patStretch:				INTEGER;
		picSave:				Handle;
		rgnSave:				Handle;
		polySave:				Handle;
		grafProcs:				QDProcsPtr;
	END;

	GrafPtr = ^GrafPort;

{
 *	This set of definitions "belongs" in Windows.
 *	But, there is a circularity in the headers where Windows includes Controls and
 *	Controls includes Windows. To break the circle, the information
 *	needed by Controls is moved from Windows to Quickdraw.
 }
	WindowPtr = GrafPtr;

	WindowRef = WindowPtr;

	DragConstraint = UInt16;


CONST
	kNoConstraint				= 0;
	kVerticalConstraint			= 1;
	kHorizontalConstraint		= 2;

{
 *	Here ends the list of things that "belong" in Windows.
 }

TYPE
	RGBColor = RECORD
		red:					INTEGER;								{magnitude of red component}
		green:					INTEGER;								{magnitude of green component}
		blue:					INTEGER;								{magnitude of blue component}
	END;

	RGBColorPtr = ^RGBColor;
	RGBColorHdl = ^RGBColorPtr;

	DragGrayRgnProcPtr = ProcPtr;  { PROCEDURE DragGrayRgn; }
	ColorSearchProcPtr = ProcPtr;  { FUNCTION ColorSearch(VAR rgb: RGBColor; VAR position: LONGINT): BOOLEAN; }
	ColorComplementProcPtr = ProcPtr;  { FUNCTION ColorComplement(VAR rgb: RGBColor): BOOLEAN; }
	DragGrayRgnUPP = UniversalProcPtr;
	ColorSearchUPP = UniversalProcPtr;
	ColorComplementUPP = UniversalProcPtr;

CONST
	uppDragGrayRgnProcInfo = $00000000; { PROCEDURE ; }
	uppColorSearchProcInfo = $000003D0; { FUNCTION (4 byte param, 4 byte param): 1 byte result; }
	uppColorComplementProcInfo = $000000D0; { FUNCTION (4 byte param): 1 byte result; }

FUNCTION NewDragGrayRgnProc(userRoutine: DragGrayRgnProcPtr): DragGrayRgnUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewColorSearchProc(userRoutine: ColorSearchProcPtr): ColorSearchUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewColorComplementProc(userRoutine: ColorComplementProcPtr): ColorComplementUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallDragGrayRgnProc(userRoutine: DragGrayRgnUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallColorSearchProc(VAR rgb: RGBColor; VAR position: LONGINT; userRoutine: ColorSearchUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallColorComplementProc(VAR rgb: RGBColor; userRoutine: ColorComplementUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	ColorSpec = RECORD
		value:					INTEGER;								{index or other value}
		rgb:					RGBColor;								{true color}
	END;

	ColorSpecPtr = ^ColorSpec;

	CSpecArray = ARRAY [0..0] OF ColorSpec;

	xColorSpec = RECORD
		value:					INTEGER;								{index or other value}
		rgb:					RGBColor;								{true color}
		xalpha:					INTEGER;
	END;

	xColorSpecPtr = ^xColorSpec;

	xCSpecArray = ARRAY [0..0] OF xColorSpec;

	ColorTable = RECORD
		ctSeed:					LONGINT;								{unique identifier for table}
		ctFlags:				INTEGER;								{high bit: 0 = PixMap; 1 = device}
		ctSize:					INTEGER;								{number of entries in CTTable}
		ctTable:				CSpecArray;								{array [0..0] of ColorSpec}
	END;

	CTabPtr = ^ColorTable;
	CTabHandle = ^CTabPtr;

	MatchRec = RECORD
		red:					INTEGER;
		green:					INTEGER;
		blue:					INTEGER;
		matchData:				LONGINT;
	END;

	PixMap = RECORD
		baseAddr:				Ptr;									{pointer to pixels}
		rowBytes:				INTEGER;								{offset to next line}
		bounds:					Rect;									{encloses bitmap}
		pmVersion:				INTEGER;								{pixMap version number}
		packType:				INTEGER;								{defines packing format}
		packSize:				LONGINT;								{length of pixel data}
		hRes:					Fixed;									{horiz. resolution (ppi)}
		vRes:					Fixed;									{vert. resolution (ppi)}
		pixelType:				INTEGER;								{defines pixel type}
		pixelSize:				INTEGER;								{# bits in pixel}
		cmpCount:				INTEGER;								{# components in pixel}
		cmpSize:				INTEGER;								{# bits per component}
		planeBytes:				LONGINT;								{offset to next plane}
		pmTable:				CTabHandle;								{color map for this pixMap}
		pmReserved:				LONGINT;								{for future use. MUST BE 0}
	END;

	PixMapPtr = ^PixMap;
	PixMapHandle = ^PixMapPtr;

	PixPat = RECORD
		patType:				INTEGER;								{type of pattern}
		patMap:					PixMapHandle;							{the pattern's pixMap}
		patData:				Handle;									{pixmap's data}
		patXData:				Handle;									{expanded Pattern data}
		patXValid:				INTEGER;								{flags whether expanded Pattern valid}
		patXMap:				Handle;									{Handle to expanded Pattern data}
		pat1Data:				Pattern;								{old-Style pattern/RGB color}
	END;

	PixPatPtr = ^PixPat;
	PixPatHandle = ^PixPatPtr;

	CCrsr = RECORD
		crsrType:				INTEGER;								{type of cursor}
		crsrMap:				PixMapHandle;							{the cursor's pixmap}
		crsrData:				Handle;									{cursor's data}
		crsrXData:				Handle;									{expanded cursor data}
		crsrXValid:				INTEGER;								{depth of expanded data (0 if none)}
		crsrXHandle:			Handle;									{future use}
		crsr1Data:				Bits16;									{one-bit cursor}
		crsrMask:				Bits16;									{cursor's mask}
		crsrHotSpot:			Point;									{cursor's hotspot}
		crsrXTable:				LONGINT;								{private}
		crsrID:					LONGINT;								{private}
	END;

	CCrsrPtr = ^CCrsr;
	CCrsrHandle = ^CCrsrPtr;

{$IFC OLDROUTINELOCATIONS }
	CIcon = RECORD
		iconPMap:				PixMap;									{the icon's pixMap}
		iconMask:				BitMap;									{the icon's mask}
		iconBMap:				BitMap;									{the icon's bitMap}
		iconData:				Handle;									{the icon's data}
		iconMaskData:			ARRAY [0..0] OF INTEGER;				{icon's mask and BitMap data}
	END;

	CIconPtr = ^CIcon;
	CIconHandle = ^CIconPtr;

{$ENDC}
	GammaTbl = RECORD
		gVersion:				INTEGER;								{gamma version number}
		gType:					INTEGER;								{gamma data type}
		gFormulaSize:			INTEGER;								{Formula data size}
		gChanCnt:				INTEGER;								{number of channels of data}
		gDataCnt:				INTEGER;								{number of values/channel}
		gDataWidth:				INTEGER;								{bits/corrected value (data packed to next larger byte size)}
		gFormulaData:			ARRAY [0..0] OF INTEGER;				{data for formulas followed by gamma values}
	END;

	GammaTblPtr = ^GammaTbl;
	GammaTblHandle = ^GammaTblPtr;

	ITab = RECORD
		iTabSeed:				LONGINT;								{copy of CTSeed from source CTable}
		iTabRes:				INTEGER;								{bits/channel resolution of iTable}
		iTTable:				ARRAY [0..0] OF SInt8; (* Byte *)		{byte colortable index values}
	END;

	ITabPtr = ^ITab;
	ITabHandle = ^ITabPtr;

	SProcRec = RECORD
		nxtSrch:				Handle;									{SProcHndl Handle to next SProcRec}
		srchProc:				ColorSearchUPP;							{search procedure proc ptr}
	END;

	SProcPtr = ^SProcRec;
	SProcHndl = ^SProcPtr;

	CProcRec = RECORD
		nxtComp:				Handle;									{CProcHndl Handle to next CProcRec}
		compProc:				ColorComplementUPP;						{complement procedure proc ptr}
	END;

	CProcPtr = ^CProcRec;
	CProcHndl = ^CProcPtr;

	GDevice = RECORD
		gdRefNum:				INTEGER;								{driver's unit number}
		gdID:					INTEGER;								{client ID for search procs}
		gdType:					INTEGER;								{fixed/CLUT/direct}
		gdITable:				ITabHandle;								{Handle to inverse lookup table}
		gdResPref:				INTEGER;								{preferred resolution of GDITable}
		gdSearchProc:			SProcHndl;								{search proc list head}
		gdCompProc:				CProcHndl;								{complement proc list}
		gdFlags:				INTEGER;								{grafDevice flags word}
		gdPMap:					PixMapHandle;							{describing pixMap}
		gdRefCon:				LONGINT;								{reference value}
		gdNextGD:				Handle;									{GDHandle Handle of next gDevice}
		gdRect:					Rect;									{ device's bounds in global coordinates}
		gdMode:					LONGINT;								{device's current mode}
		gdCCBytes:				INTEGER;								{depth of expanded cursor data}
		gdCCDepth:				INTEGER;								{depth of expanded cursor data}
		gdCCXData:				Handle;									{Handle to cursor's expanded data}
		gdCCXMask:				Handle;									{Handle to cursor's expanded mask}
		gdReserved:				LONGINT;								{future use. MUST BE 0}
	END;

	GDPtr = ^GDevice;
	GDHandle = ^GDPtr;

	GrafVars = RECORD
		rgbOpColor:				RGBColor;								{color for addPin  subPin and average}
		rgbHiliteColor:			RGBColor;								{color for hiliting}
		pmFgColor:				Handle;									{palette Handle for foreground color}
		pmFgIndex:				INTEGER;								{index value for foreground}
		pmBkColor:				Handle;									{palette Handle for background color}
		pmBkIndex:				INTEGER;								{index value for background}
		pmFlags:				INTEGER;								{flags for Palette Manager}
	END;

	GVarPtr = ^GrafVars;
	GVarHandle = ^GVarPtr;

	CQDProcs = RECORD
		textProc:				QDTextUPP;
		lineProc:				QDLineUPP;
		rectProc:				QDRectUPP;
		rRectProc:				QDRRectUPP;
		ovalProc:				QDOvalUPP;
		arcProc:				QDArcUPP;
		polyProc:				QDPolyUPP;
		rgnProc:				QDRgnUPP;
		bitsProc:				QDBitsUPP;
		commentProc:			QDCommentUPP;
		txMeasProc:				QDTxMeasUPP;
		getPicProc:				QDGetPicUPP;
		putPicProc:				QDPutPicUPP;
		opcodeProc:				QDOpcodeUPP;							{fields added to QDProcs}
		newProc1:				UniversalProcPtr;
		newProc2:				UniversalProcPtr;
		newProc3:				UniversalProcPtr;
		newProc4:				UniversalProcPtr;
		newProc5:				UniversalProcPtr;
		newProc6:				UniversalProcPtr;
	END;

	CQDProcsPtr = ^CQDProcs;

	CGrafPort = RECORD
		device:					INTEGER;
		portPixMap:				PixMapHandle;							{port's pixel map}
		portVersion:			INTEGER;								{high 2 bits always set}
		grafVars:				Handle;									{Handle to more fields}
		chExtra:				INTEGER;								{character extra}
		pnLocHFrac:				INTEGER;								{pen fraction}
		portRect:				Rect;
		visRgn:					RgnHandle;
		clipRgn:				RgnHandle;
		bkPixPat:				PixPatHandle;							{background pattern}
		rgbFgColor:				RGBColor;								{RGB components of fg}
		rgbBkColor:				RGBColor;								{RGB components of bk}
		pnLoc:					Point;
		pnSize:					Point;
		pnMode:					INTEGER;
		pnPixPat:				PixPatHandle;							{pen's pattern}
		fillPixPat:				PixPatHandle;							{fill pattern}
		pnVis:					INTEGER;
		txFont:					INTEGER;
		txFace:					Style;									{txFace is unpacked byte  push as short}
		txMode:					INTEGER;
		txSize:					INTEGER;
		spExtra:				Fixed;
		fgColor:				LONGINT;
		bkColor:				LONGINT;
		colrBit:				INTEGER;
		patStretch:				INTEGER;
		picSave:				Handle;
		rgnSave:				Handle;
		polySave:				Handle;
		grafProcs:				CQDProcsPtr;
	END;

	CGrafPtr = ^CGrafPort;

	CWindowPtr = CGrafPtr;

	ReqListRec = RECORD
		reqLSize:				INTEGER;								{request list size}
		reqLData:				ARRAY [0..0] OF INTEGER;				{request list data}
	END;

	OpenCPicParams = RECORD
		srcRect:				Rect;
		hRes:					Fixed;
		vRes:					Fixed;
		version:				INTEGER;
		reserved1:				INTEGER;
		reserved2:				LONGINT;
	END;


CONST
	kCursorImageMajorVersion	= $0001;
	kCursorImageMinorVersion	= $0000;


TYPE
	CursorImageRec = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		cursorPixMap:			PixMapHandle;
		cursorBitMask:			BitMapHandle;
	END;

	CursorImagePtr = ^CursorImageRec;

	DeviceLoopDrawingProcPtr = ProcPtr;  { PROCEDURE DeviceLoopDrawing(depth: INTEGER; deviceFlags: INTEGER; targetDevice: GDHandle; userData: LONGINT); }
	DeviceLoopDrawingUPP = UniversalProcPtr;

CONST
	uppDeviceLoopDrawingProcInfo = $00003E80; { PROCEDURE (2 byte param, 2 byte param, 4 byte param, 4 byte param); }

FUNCTION NewDeviceLoopDrawingProc(userRoutine: DeviceLoopDrawingProcPtr): DeviceLoopDrawingUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallDeviceLoopDrawingProc(depth: INTEGER; deviceFlags: INTEGER; targetDevice: GDHandle; userData: LONGINT; userRoutine: DeviceLoopDrawingUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

TYPE
	QDGlobals = RECORD
		privates:				PACKED ARRAY [0..75] OF CHAR;
		randSeed:				LONGINT;
		screenBits:				BitMap;
		arrow:					Cursor;
		dkGray:					Pattern;
		ltGray:					Pattern;
		gray:					Pattern;
		black:					Pattern;
		white:					Pattern;
		thePort:				GrafPtr;
	END;

	QDGlobalsPtr = ^QDGlobals;
	QDGlobalsHdl = ^QDGlobalsPtr;


{ To be in sync with the C interface to QuickDraw globals, pascal code must now }
{ qualify the QuickDraw globals with “qd.” (e.g. InitGraf(@qd.thePort);  )       }
VAR
	{$PUSH}
	{$J+}
	qd: QDGlobals;
	{$POP}

PROCEDURE InitGraf(globalPtr: UNIV Ptr);
	{$IFC NOT GENERATINGCFM}
	INLINE $A86E;
	{$ENDC}
PROCEDURE OpenPort(port: GrafPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $A86F;
	{$ENDC}
PROCEDURE InitPort(port: GrafPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $A86D;
	{$ENDC}
PROCEDURE ClosePort(port: GrafPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $A87D;
	{$ENDC}
PROCEDURE SetPort(port: GrafPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $A873;
	{$ENDC}
PROCEDURE GetPort(VAR port: GrafPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $A874;
	{$ENDC}
PROCEDURE GrafDevice(device: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A872;
	{$ENDC}
PROCEDURE SetPortBits({CONST}VAR bm: BitMap);
	{$IFC NOT GENERATINGCFM}
	INLINE $A875;
	{$ENDC}
PROCEDURE PortSize(width: INTEGER; height: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A876;
	{$ENDC}
PROCEDURE MovePortTo(leftGlobal: INTEGER; topGlobal: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A877;
	{$ENDC}
PROCEDURE SetOrigin(h: INTEGER; v: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A878;
	{$ENDC}
PROCEDURE SetClip(rgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A879;
	{$ENDC}
PROCEDURE GetClip(rgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A87A;
	{$ENDC}
PROCEDURE ClipRect({CONST}VAR r: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A87B;
	{$ENDC}
PROCEDURE BackPat({CONST}VAR pat: Pattern);
	{$IFC NOT GENERATINGCFM}
	INLINE $A87C;
	{$ENDC}
PROCEDURE InitCursor;
	{$IFC NOT GENERATINGCFM}
	INLINE $A850;
	{$ENDC}
PROCEDURE SetCursor({CONST}VAR crsr: Cursor);
	{$IFC NOT GENERATINGCFM}
	INLINE $A851;
	{$ENDC}
PROCEDURE HideCursor;
	{$IFC NOT GENERATINGCFM}
	INLINE $A852;
	{$ENDC}
PROCEDURE ShowCursor;
	{$IFC NOT GENERATINGCFM}
	INLINE $A853;
	{$ENDC}
PROCEDURE ObscureCursor;
	{$IFC NOT GENERATINGCFM}
	INLINE $A856;
	{$ENDC}
PROCEDURE HidePen;
	{$IFC NOT GENERATINGCFM}
	INLINE $A896;
	{$ENDC}
PROCEDURE ShowPen;
	{$IFC NOT GENERATINGCFM}
	INLINE $A897;
	{$ENDC}
PROCEDURE GetPen(VAR pt: Point);
	{$IFC NOT GENERATINGCFM}
	INLINE $A89A;
	{$ENDC}
PROCEDURE GetPenState(VAR pnState: PenState);
	{$IFC NOT GENERATINGCFM}
	INLINE $A898;
	{$ENDC}
PROCEDURE SetPenState({CONST}VAR pnState: PenState);
	{$IFC NOT GENERATINGCFM}
	INLINE $A899;
	{$ENDC}
PROCEDURE PenSize(width: INTEGER; height: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A89B;
	{$ENDC}
PROCEDURE PenMode(mode: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A89C;
	{$ENDC}
PROCEDURE PenPat({CONST}VAR pat: Pattern);
	{$IFC NOT GENERATINGCFM}
	INLINE $A89D;
	{$ENDC}
PROCEDURE PenNormal;
	{$IFC NOT GENERATINGCFM}
	INLINE $A89E;
	{$ENDC}
PROCEDURE MoveTo(h: INTEGER; v: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A893;
	{$ENDC}
PROCEDURE Move(dh: INTEGER; dv: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A894;
	{$ENDC}
PROCEDURE LineTo(h: INTEGER; v: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A891;
	{$ENDC}
PROCEDURE Line(dh: INTEGER; dv: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A892;
	{$ENDC}
PROCEDURE ForeColor(color: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $A862;
	{$ENDC}
PROCEDURE BackColor(color: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $A863;
	{$ENDC}
PROCEDURE ColorBit(whichBit: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A864;
	{$ENDC}
PROCEDURE SetRect(VAR r: Rect; left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8A7;
	{$ENDC}
PROCEDURE OffsetRect(VAR r: Rect; dh: INTEGER; dv: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8A8;
	{$ENDC}
PROCEDURE InsetRect(VAR r: Rect; dh: INTEGER; dv: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8A9;
	{$ENDC}
FUNCTION SectRect({CONST}VAR src1: Rect; {CONST}VAR src2: Rect; VAR dstRect: Rect): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8AA;
	{$ENDC}
PROCEDURE UnionRect({CONST}VAR src1: Rect; {CONST}VAR src2: Rect; VAR dstRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8AB;
	{$ENDC}
FUNCTION EqualRect({CONST}VAR rect1: Rect; {CONST}VAR rect2: Rect): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8A6;
	{$ENDC}
FUNCTION EmptyRect({CONST}VAR r: Rect): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8AE;
	{$ENDC}
PROCEDURE FrameRect({CONST}VAR r: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8A1;
	{$ENDC}
PROCEDURE PaintRect({CONST}VAR r: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8A2;
	{$ENDC}
PROCEDURE EraseRect({CONST}VAR r: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8A3;
	{$ENDC}
PROCEDURE InvertRect({CONST}VAR r: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8A4;
	{$ENDC}
PROCEDURE FillRect({CONST}VAR r: Rect; {CONST}VAR pat: Pattern);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8A5;
	{$ENDC}
PROCEDURE FrameOval({CONST}VAR r: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8B7;
	{$ENDC}
PROCEDURE PaintOval({CONST}VAR r: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8B8;
	{$ENDC}
PROCEDURE EraseOval({CONST}VAR r: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8B9;
	{$ENDC}
PROCEDURE InvertOval({CONST}VAR r: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8BA;
	{$ENDC}
PROCEDURE FillOval({CONST}VAR r: Rect; {CONST}VAR pat: Pattern);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8BB;
	{$ENDC}
PROCEDURE FrameRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8B0;
	{$ENDC}
PROCEDURE PaintRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8B1;
	{$ENDC}
PROCEDURE EraseRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8B2;
	{$ENDC}
PROCEDURE InvertRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8B3;
	{$ENDC}
PROCEDURE FillRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER; {CONST}VAR pat: Pattern);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8B4;
	{$ENDC}
PROCEDURE FrameArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8BE;
	{$ENDC}
PROCEDURE PaintArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8BF;
	{$ENDC}
PROCEDURE EraseArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8C0;
	{$ENDC}
PROCEDURE InvertArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8C1;
	{$ENDC}
PROCEDURE FillArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER; {CONST}VAR pat: Pattern);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8C2;
	{$ENDC}
FUNCTION NewRgn: RgnHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8D8;
	{$ENDC}
PROCEDURE OpenRgn;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8DA;
	{$ENDC}
PROCEDURE CloseRgn(dstRgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8DB;
	{$ENDC}
{$IFC NOT SystemSevenOrLater }
FUNCTION BitMapToRegionGlue(region: RgnHandle; {CONST}VAR bMap: BitMap): OSErr;
{$ENDC}
FUNCTION BitMapToRegion(region: RgnHandle; {CONST}VAR bMap: BitMap): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8D7;
	{$ENDC}
PROCEDURE DisposeRgn(rgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8D9;
	{$ENDC}
PROCEDURE CopyRgn(srcRgn: RgnHandle; dstRgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8DC;
	{$ENDC}
PROCEDURE SetEmptyRgn(rgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8DD;
	{$ENDC}
PROCEDURE SetRectRgn(rgn: RgnHandle; left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8DE;
	{$ENDC}
PROCEDURE RectRgn(rgn: RgnHandle; {CONST}VAR r: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8DF;
	{$ENDC}
PROCEDURE OffsetRgn(rgn: RgnHandle; dh: INTEGER; dv: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8E0;
	{$ENDC}
PROCEDURE InsetRgn(rgn: RgnHandle; dh: INTEGER; dv: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8E1;
	{$ENDC}
PROCEDURE SectRgn(srcRgnA: RgnHandle; srcRgnB: RgnHandle; dstRgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8E4;
	{$ENDC}
PROCEDURE UnionRgn(srcRgnA: RgnHandle; srcRgnB: RgnHandle; dstRgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8E5;
	{$ENDC}
PROCEDURE DiffRgn(srcRgnA: RgnHandle; srcRgnB: RgnHandle; dstRgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8E6;
	{$ENDC}
PROCEDURE XorRgn(srcRgnA: RgnHandle; srcRgnB: RgnHandle; dstRgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8E7;
	{$ENDC}
FUNCTION RectInRgn({CONST}VAR r: Rect; rgn: RgnHandle): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8E9;
	{$ENDC}
FUNCTION EqualRgn(rgnA: RgnHandle; rgnB: RgnHandle): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8E3;
	{$ENDC}
FUNCTION EmptyRgn(rgn: RgnHandle): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8E2;
	{$ENDC}
PROCEDURE FrameRgn(rgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8D2;
	{$ENDC}
PROCEDURE PaintRgn(rgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8D3;
	{$ENDC}
PROCEDURE EraseRgn(rgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8D4;
	{$ENDC}
PROCEDURE InvertRgn(rgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8D5;
	{$ENDC}
PROCEDURE FillRgn(rgn: RgnHandle; {CONST}VAR pat: Pattern);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8D6;
	{$ENDC}
PROCEDURE ScrollRect({CONST}VAR r: Rect; dh: INTEGER; dv: INTEGER; updateRgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8EF;
	{$ENDC}
PROCEDURE CopyBits({CONST}VAR srcBits: BitMap; {CONST}VAR dstBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; mode: INTEGER; maskRgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8EC;
	{$ENDC}
PROCEDURE SeedFill(srcPtr: UNIV Ptr; dstPtr: UNIV Ptr; srcRow: INTEGER; dstRow: INTEGER; height: INTEGER; words: INTEGER; seedH: INTEGER; seedV: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A839;
	{$ENDC}
PROCEDURE CalcMask(srcPtr: UNIV Ptr; dstPtr: UNIV Ptr; srcRow: INTEGER; dstRow: INTEGER; height: INTEGER; words: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A838;
	{$ENDC}
PROCEDURE CopyMask({CONST}VAR srcBits: BitMap; {CONST}VAR maskBits: BitMap; {CONST}VAR dstBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR maskRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A817;
	{$ENDC}
FUNCTION OpenPicture({CONST}VAR picFrame: Rect): PicHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8F3;
	{$ENDC}
PROCEDURE PicComment(kind: INTEGER; dataSize: INTEGER; dataHandle: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8F2;
	{$ENDC}
PROCEDURE ClosePicture;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8F4;
	{$ENDC}
PROCEDURE DrawPicture(myPicture: PicHandle; {CONST}VAR dstRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8F6;
	{$ENDC}
PROCEDURE KillPicture(myPicture: PicHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8F5;
	{$ENDC}
FUNCTION OpenPoly: PolyHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8CB;
	{$ENDC}
PROCEDURE ClosePoly;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8CC;
	{$ENDC}
PROCEDURE KillPoly(poly: PolyHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8CD;
	{$ENDC}
PROCEDURE OffsetPoly(poly: PolyHandle; dh: INTEGER; dv: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8CE;
	{$ENDC}
PROCEDURE FramePoly(poly: PolyHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8C6;
	{$ENDC}
PROCEDURE PaintPoly(poly: PolyHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8C7;
	{$ENDC}
PROCEDURE ErasePoly(poly: PolyHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8C8;
	{$ENDC}
PROCEDURE InvertPoly(poly: PolyHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8C9;
	{$ENDC}
PROCEDURE FillPoly(poly: PolyHandle; {CONST}VAR pat: Pattern);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8CA;
	{$ENDC}
PROCEDURE SetPt(VAR pt: Point; h: INTEGER; v: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A880;
	{$ENDC}
PROCEDURE LocalToGlobal(VAR pt: Point);
	{$IFC NOT GENERATINGCFM}
	INLINE $A870;
	{$ENDC}
PROCEDURE GlobalToLocal(VAR pt: Point);
	{$IFC NOT GENERATINGCFM}
	INLINE $A871;
	{$ENDC}
FUNCTION Random: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $A861;
	{$ENDC}
PROCEDURE StuffHex(thingPtr: UNIV Ptr; s: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $A866;
	{$ENDC}
FUNCTION GetPixel(h: INTEGER; v: INTEGER): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A865;
	{$ENDC}
PROCEDURE ScalePt(VAR pt: Point; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8F8;
	{$ENDC}
PROCEDURE MapPt(VAR pt: Point; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8F9;
	{$ENDC}
PROCEDURE MapRect(VAR r: Rect; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8FA;
	{$ENDC}
PROCEDURE MapRgn(rgn: RgnHandle; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8FB;
	{$ENDC}
PROCEDURE MapPoly(poly: PolyHandle; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8FC;
	{$ENDC}
PROCEDURE SetStdProcs(VAR procs: QDProcs);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8EA;
	{$ENDC}
PROCEDURE StdRect(verb: ByteParameter; {CONST}VAR r: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8A0;
	{$ENDC}
PROCEDURE StdRRect(verb: ByteParameter; {CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8AF;
	{$ENDC}
PROCEDURE StdOval(verb: ByteParameter; {CONST}VAR r: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8B6;
	{$ENDC}
PROCEDURE StdArc(verb: ByteParameter; {CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8BD;
	{$ENDC}
PROCEDURE StdPoly(verb: ByteParameter; poly: PolyHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8C5;
	{$ENDC}
PROCEDURE StdRgn(verb: ByteParameter; rgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8D1;
	{$ENDC}
PROCEDURE StdBits({CONST}VAR srcBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; mode: INTEGER; maskRgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8EB;
	{$ENDC}
PROCEDURE StdComment(kind: INTEGER; dataSize: INTEGER; dataHandle: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8F1;
	{$ENDC}
PROCEDURE StdGetPic(dataPtr: UNIV Ptr; byteCount: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8EE;
	{$ENDC}
PROCEDURE StdPutPic(dataPtr: UNIV Ptr; byteCount: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8F0;
	{$ENDC}
PROCEDURE AddPt(src: Point; VAR dst: Point);
	{$IFC NOT GENERATINGCFM}
	INLINE $A87E;
	{$ENDC}
FUNCTION EqualPt(pt1: Point; pt2: Point): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A881;
	{$ENDC}
FUNCTION PtInRect(pt: Point; {CONST}VAR r: Rect): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8AD;
	{$ENDC}
PROCEDURE Pt2Rect(pt1: Point; pt2: Point; VAR dstRect: Rect);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8AC;
	{$ENDC}
PROCEDURE PtToAngle({CONST}VAR r: Rect; pt: Point; VAR angle: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $A8C3;
	{$ENDC}
PROCEDURE SubPt(src: Point; VAR dst: Point);
	{$IFC NOT GENERATINGCFM}
	INLINE $A87F;
	{$ENDC}
FUNCTION PtInRgn(pt: Point; rgn: RgnHandle): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $A8E8;
	{$ENDC}
PROCEDURE StdLine(newPt: Point);
	{$IFC NOT GENERATINGCFM}
	INLINE $A890;
	{$ENDC}
PROCEDURE OpenCPort(port: CGrafPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA00;
	{$ENDC}
PROCEDURE InitCPort(port: CGrafPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA01;
	{$ENDC}
PROCEDURE CloseCPort(port: CGrafPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $A87D;
	{$ENDC}
FUNCTION NewPixMap: PixMapHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA03;
	{$ENDC}
PROCEDURE DisposePixMap(pm: PixMapHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA04;
	{$ENDC}
PROCEDURE CopyPixMap(srcPM: PixMapHandle; dstPM: PixMapHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA05;
	{$ENDC}
FUNCTION NewPixPat: PixPatHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA07;
	{$ENDC}
PROCEDURE DisposePixPat(pp: PixPatHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA08;
	{$ENDC}
PROCEDURE CopyPixPat(srcPP: PixPatHandle; dstPP: PixPatHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA09;
	{$ENDC}
PROCEDURE PenPixPat(pp: PixPatHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA0A;
	{$ENDC}
PROCEDURE BackPixPat(pp: PixPatHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA0B;
	{$ENDC}
FUNCTION GetPixPat(patID: INTEGER): PixPatHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA0C;
	{$ENDC}
PROCEDURE MakeRGBPat(pp: PixPatHandle; {CONST}VAR myColor: RGBColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA0D;
	{$ENDC}
PROCEDURE FillCRect({CONST}VAR r: Rect; pp: PixPatHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA0E;
	{$ENDC}
PROCEDURE FillCOval({CONST}VAR r: Rect; pp: PixPatHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA0F;
	{$ENDC}
PROCEDURE FillCRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER; pp: PixPatHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA10;
	{$ENDC}
PROCEDURE FillCArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER; pp: PixPatHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA11;
	{$ENDC}
PROCEDURE FillCRgn(rgn: RgnHandle; pp: PixPatHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA12;
	{$ENDC}
PROCEDURE FillCPoly(poly: PolyHandle; pp: PixPatHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA13;
	{$ENDC}
PROCEDURE RGBForeColor({CONST}VAR color: RGBColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA14;
	{$ENDC}
PROCEDURE RGBBackColor({CONST}VAR color: RGBColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA15;
	{$ENDC}
PROCEDURE SetCPixel(h: INTEGER; v: INTEGER; {CONST}VAR cPix: RGBColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA16;
	{$ENDC}
PROCEDURE SetPortPix(pm: PixMapHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA06;
	{$ENDC}
PROCEDURE GetCPixel(h: INTEGER; v: INTEGER; VAR cPix: RGBColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA17;
	{$ENDC}
PROCEDURE GetForeColor(VAR color: RGBColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA19;
	{$ENDC}
PROCEDURE GetBackColor(VAR color: RGBColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA1A;
	{$ENDC}
PROCEDURE SeedCFill({CONST}VAR srcBits: BitMap; {CONST}VAR dstBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; seedH: INTEGER; seedV: INTEGER; matchProc: ColorSearchUPP; matchData: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA50;
	{$ENDC}
PROCEDURE CalcCMask({CONST}VAR srcBits: BitMap; {CONST}VAR dstBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; {CONST}VAR seedRGB: RGBColor; matchProc: ColorSearchUPP; matchData: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA4F;
	{$ENDC}
FUNCTION OpenCPicture({CONST}VAR newHeader: OpenCPicParams): PicHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA20;
	{$ENDC}
PROCEDURE OpColor({CONST}VAR color: RGBColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA21;
	{$ENDC}
PROCEDURE HiliteColor({CONST}VAR color: RGBColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA22;
	{$ENDC}
PROCEDURE DisposeCTable(cTable: CTabHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA24;
	{$ENDC}
FUNCTION GetCTable(ctID: INTEGER): CTabHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA18;
	{$ENDC}
FUNCTION GetCCursor(crsrID: INTEGER): CCrsrHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA1B;
	{$ENDC}
PROCEDURE SetCCursor(cCrsr: CCrsrHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA1C;
	{$ENDC}
PROCEDURE AllocCursor;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA1D;
	{$ENDC}
PROCEDURE DisposeCCursor(cCrsr: CCrsrHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA26;
	{$ENDC}
{$IFC OLDROUTINELOCATIONS }
FUNCTION GetCIcon(iconID: INTEGER): CIconHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA1E;
	{$ENDC}
PROCEDURE PlotCIcon({CONST}VAR theRect: Rect; theIcon: CIconHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA1F;
	{$ENDC}
PROCEDURE DisposeCIcon(theIcon: CIconHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA25;
	{$ENDC}
{$ENDC}
PROCEDURE SetStdCProcs(VAR procs: CQDProcs);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA4E;
	{$ENDC}
FUNCTION GetMaxDevice({CONST}VAR globalRect: Rect): GDHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA27;
	{$ENDC}
FUNCTION GetCTSeed: LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA28;
	{$ENDC}
FUNCTION GetDeviceList: GDHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA29;
	{$ENDC}
FUNCTION GetMainDevice: GDHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA2A;
	{$ENDC}
FUNCTION GetNextDevice(curDevice: GDHandle): GDHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA2B;
	{$ENDC}
FUNCTION TestDeviceAttribute(gdh: GDHandle; attribute: INTEGER): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA2C;
	{$ENDC}
PROCEDURE SetDeviceAttribute(gdh: GDHandle; attribute: INTEGER; value: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA2D;
	{$ENDC}
PROCEDURE InitGDevice(qdRefNum: INTEGER; mode: LONGINT; gdh: GDHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA2E;
	{$ENDC}
FUNCTION NewGDevice(refNum: INTEGER; mode: LONGINT): GDHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA2F;
	{$ENDC}
PROCEDURE DisposeGDevice(gdh: GDHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA30;
	{$ENDC}
PROCEDURE SetGDevice(gd: GDHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA31;
	{$ENDC}
FUNCTION GetGDevice: GDHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA32;
	{$ENDC}
FUNCTION Color2Index({CONST}VAR myColor: RGBColor): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA33;
	{$ENDC}
PROCEDURE Index2Color(index: LONGINT; VAR aColor: RGBColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA34;
	{$ENDC}
PROCEDURE InvertColor(VAR myColor: RGBColor);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA35;
	{$ENDC}
FUNCTION RealColor({CONST}VAR color: RGBColor): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA36;
	{$ENDC}
PROCEDURE GetSubTable(myColors: CTabHandle; iTabRes: INTEGER; targetTbl: CTabHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA37;
	{$ENDC}
PROCEDURE MakeITable(cTabH: CTabHandle; iTabH: ITabHandle; res: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA39;
	{$ENDC}
PROCEDURE AddSearch(searchProc: ColorSearchUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA3A;
	{$ENDC}
PROCEDURE AddComp(compProc: ColorComplementUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA3B;
	{$ENDC}
PROCEDURE DelSearch(searchProc: ColorSearchUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA4C;
	{$ENDC}
PROCEDURE DelComp(compProc: ColorComplementUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA4D;
	{$ENDC}
PROCEDURE SetClientID(id: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA3C;
	{$ENDC}
PROCEDURE ProtectEntry(index: INTEGER; protect: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA3D;
	{$ENDC}
PROCEDURE ReserveEntry(index: INTEGER; reserve: BOOLEAN);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA3E;
	{$ENDC}
PROCEDURE SetEntries(start: INTEGER; count: INTEGER; VAR aTable: CSpecArray);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA3F;
	{$ENDC}
PROCEDURE SaveEntries(srcTable: CTabHandle; resultTable: CTabHandle; VAR selection: ReqListRec);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA49;
	{$ENDC}
PROCEDURE RestoreEntries(srcTable: CTabHandle; dstTable: CTabHandle; VAR selection: ReqListRec);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA4A;
	{$ENDC}
FUNCTION QDError: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA40;
	{$ENDC}
PROCEDURE CopyDeepMask({CONST}VAR srcBits: BitMap; {CONST}VAR maskBits: BitMap; {CONST}VAR dstBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR maskRect: Rect; {CONST}VAR dstRect: Rect; mode: INTEGER; maskRgn: RgnHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA51;
	{$ENDC}
PROCEDURE DeviceLoop(drawingRgn: RgnHandle; drawingProc: DeviceLoopDrawingUPP; userData: LONGINT; flags: DeviceLoopFlags);
	{$IFC NOT GENERATINGCFM}
	INLINE $ABCA;
	{$ENDC}
FUNCTION GetMaskTable: Ptr;
	{$IFC NOT GENERATINGCFM}
	INLINE $A836, $2E88;
	{$ENDC}
FUNCTION GetPattern(patternID: INTEGER): PatHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9B8;
	{$ENDC}
FUNCTION GetCursor(cursorID: INTEGER): CursHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9B9;
	{$ENDC}
FUNCTION GetPicture(pictureID: INTEGER): PicHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9BC;
	{$ENDC}
FUNCTION DeltaPoint(ptA: Point; ptB: Point): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A94F;
	{$ENDC}
PROCEDURE ShieldCursor({CONST}VAR shieldRect: Rect; offsetPt: Point);
	{$IFC NOT GENERATINGCFM}
	INLINE $A855;
	{$ENDC}
PROCEDURE ScreenRes(VAR scrnHRes: INTEGER; VAR scrnVRes: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $225F, $32B8, $0102, $225F, $32B8, $0104;
	{$ENDC}
PROCEDURE GetIndPattern(VAR thePat: Pattern; patternListID: INTEGER; index: INTEGER);
{$IFC OLDROUTINENAMES }
PROCEDURE DisposPixMap(pm: PixMapHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA04;
	{$ENDC}
PROCEDURE DisposPixPat(pp: PixPatHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA08;
	{$ENDC}
PROCEDURE DisposCTable(cTable: CTabHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA24;
	{$ENDC}
PROCEDURE DisposCCursor(cCrsr: CCrsrHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA26;
	{$ENDC}
{$IFC OLDROUTINELOCATIONS }
PROCEDURE DisposCIcon(theIcon: CIconHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA25;
	{$ENDC}
{$ENDC}
PROCEDURE DisposGDevice(gdh: GDHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA30;
	{$ENDC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QuickdrawIncludes}

{$ENDC} {__QUICKDRAW__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

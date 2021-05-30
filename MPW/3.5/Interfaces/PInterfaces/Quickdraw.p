{
     File:       Quickdraw.p
 
     Contains:   Interface to Quickdraw Graphics
 
     Version:    Technology: 
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __COMPONENTS__}
{$I Components.p}
{$ENDC}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAWTEXT__}
{$I QuickdrawText.p}
{$ENDC}
{$IFC UNDEFINED __CGCONTEXT__}
{$I CGContext.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	invalColReq					= -1;							{ invalid color table request }

																{  transfer modes  }
	srcCopy						= 0;							{ the 16 transfer modes }
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
	notPatBic					= 15;							{  Special Text Transfer Mode  }
	grayishTextOr				= 49;
	hilitetransfermode			= 50;
	hilite						= 50;							{  Arithmetic transfer modes  }
	blend						= 32;
	addPin						= 33;
	addOver						= 34;
	subPin						= 35;
	addMax						= 37;
	adMax						= 37;
	subOver						= 38;
	adMin						= 39;
	ditherCopy					= 64;							{  Transparent mode constant  }
	transparent					= 36;

	italicBit					= 1;
	ulineBit					= 2;
	outlineBit					= 3;
	shadowBit					= 4;
	condenseBit					= 5;
	extendBit					= 6;

																{  QuickDraw color separation constants  }
	normalBit					= 0;							{ normal screen mapping }
	inverseBit					= 1;							{ inverse screen mapping }
	redBit						= 4;							{ RGB additive mapping }
	greenBit					= 3;
	blueBit						= 2;
	cyanBit						= 8;							{ CMYBk subtractive mapping }
	magentaBit					= 7;
	yellowBit					= 6;
	blackBit					= 5;

	blackColor					= 33;							{ colors expressed in these mappings }
	whiteColor					= 30;
	redColor					= 205;
	greenColor					= 341;
	blueColor					= 409;
	cyanColor					= 273;
	magentaColor				= 137;
	yellowColor					= 69;

	picLParen					= 0;							{ standard picture comments }
	picRParen					= 1;
	clutType					= 0;							{ 0 if lookup table }
	fixedType					= 1;							{ 1 if fixed table }
	directType					= 2;							{ 2 if direct values }
	gdDevType					= 0;							{ 0 = monochrome 1 = color }

	interlacedDevice			= 2;							{  1 if single pixel lines look bad  }
	roundedDevice				= 5;							{  1 if device has been “rounded” into the GrayRgn  }
	hasAuxMenuBar				= 6;							{  1 if device has an aux menu bar on it  }
	burstDevice					= 7;
	ext32Device					= 8;
	ramInit						= 10;							{ 1 if initialized from 'scrn' resource }
	mainScreen					= 11;							{  1 if main screen  }
	allInit						= 12;							{  1 if all devices initialized  }
	screenDevice				= 13;							{ 1 if screen device [not used] }
	noDriver					= 14;							{  1 if no driver for this GDevice  }
	screenActive				= 15;							{ 1 if in use }
	hiliteBit					= 7;							{ flag bit in LMGet/SetHiliteMode }
	pHiliteBit					= 0;							{ flag bit in LMGet/SetHiliteMode when used with BitClr }
	defQDColors					= 127;							{ resource ID of clut for default QDColors }
																{  pixel type  }
	RGBDirect					= 16;							{  16 & 32 bits/pixel pixelType value  }
																{  pmVersion values  }
	baseAddr32					= 4;							{ pixmap base address is 32-bit address }


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
	frame						= 0;
	paint						= 1;
	erase						= 2;
	invert						= 3;
	fill						= 4;

{$ENDC}  {OLDROUTINENAMES}


TYPE
	GrafVerb							= SInt8;

CONST
	chunky						= 0;
	chunkyPlanar				= 1;
	planar						= 2;


TYPE
	PixelType							= SInt8;
	Bits16								= ARRAY [0..15] OF INTEGER;

	{	**************   IMPORTANT NOTE REGARDING Pattern  **************************************
	   Patterns were originally defined as:
	   
	        C:          typedef unsigned char Pattern[8];
	        Pascal:     Pattern = PACKED ARRAY [0..7] OF 0..255;
	        
	   The old array definition of Pattern would cause 68000 based CPU's to crash in certain circum-
	   stances. The new struct definition is safe, but may require source code changes to compile.
	    
	********************************************************************************************	}
	PatternPtr = ^Pattern;
	Pattern = RECORD
		pat:					PACKED ARRAY [0..7] OF UInt8;
	END;

	PatPtr								= ^Pattern;
	PatHandle							= ^PatPtr;
	QDByte								= SignedByte;
	QDPtr								= Ptr;
	QDHandle							= Handle;
	QDErr								= INTEGER;

CONST
	singleDevicesBit			= 0;
	dontMatchSeedsBit			= 1;
	allDevicesBit				= 2;

	singleDevices				= $01;
	dontMatchSeeds				= $02;
	allDevices					= $04;


TYPE
	DeviceLoopFlags						= UInt32;
	{	
	    PrinterStatusOpcode.  For communication with downloading and printing services.
		}
	PrinterStatusOpcode					= SInt32;

CONST
	kPrinterFontStatus			= 0;
	kPrinterScalingStatus		= 1;


TYPE
	PrinterFontStatusPtr = ^PrinterFontStatus;
	PrinterFontStatus = RECORD
		oResult:				SInt32;
		iFondID:				SInt16;
		iStyle:					SInt8;
	END;

	PrinterScalingStatusPtr = ^PrinterScalingStatus;
	PrinterScalingStatus = RECORD
		oScalingFactors:		Point;
	END;

	BitMapPtr = ^BitMap;
	BitMap = RECORD
		baseAddr:				Ptr;
		rowBytes:				INTEGER;
		bounds:					Rect;
	END;

	BitMapHandle						= ^BitMapPtr;
	CursorPtr = ^Cursor;
	Cursor = RECORD
		data:					Bits16;
		mask:					Bits16;
		hotSpot:				Point;
	END;

	CursPtr								= ^Cursor;
	CursHandle							= ^CursPtr;
	PenStatePtr = ^PenState;
	PenState = RECORD
		pnLoc:					Point;
		pnSize:					Point;
		pnMode:					INTEGER;
		pnPat:					Pattern;
	END;

{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	MacRegionPtr = ^MacRegion;
	MacRegion = RECORD
		rgnSize:				UInt16;									{ size in bytes }
		rgnBBox:				Rect;									{ enclosing rectangle }
	END;

	{
	   The type name "Region" has a name space collision on Win32.
	   Use MacRegion to be cross-platfrom safe.
	}
{$IFC TARGET_OS_MAC }
	Region								= MacRegion;
	RegionPtr 							= ^Region;
{$ENDC}  {TARGET_OS_MAC}
	RgnPtr								= ^MacRegion;
	RgnHandle							= ^RgnPtr;
{$ELSEC}
	RgnHandle    = ^LONGINT; { an opaque 32-bit type }
	RgnHandlePtr = ^RgnHandle;  { when a VAR xx:RgnHandle parameter can be nil, it is changed to xx: RgnHandlePtr }
{$ENDC}

	PicturePtr = ^Picture;
	Picture = RECORD
		picSize:				INTEGER;
		picFrame:				Rect;
	END;

	PicPtr								= ^Picture;
	PicHandle							= ^PicPtr;
	MacPolygonPtr = ^MacPolygon;
	MacPolygon = RECORD
		polySize:				INTEGER;
		polyBBox:				Rect;
		polyPoints:				ARRAY [0..0] OF Point;
	END;

	{
	   The type name "Polygon" has a name space collision on Win32.
	   Use MacPolygon to be cross-platfrom safe.
	}
{$IFC TARGET_OS_MAC }
	Polygon								= MacPolygon;
	PolygonPtr 							= ^Polygon;
{$ENDC}  {TARGET_OS_MAC}

	PolyPtr								= ^MacPolygon;
	PolyHandle							= ^PolyPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	QDTextProcPtr = PROCEDURE(byteCount: INTEGER; textBuf: UNIV Ptr; numer: Point; denom: Point);
{$ELSEC}
	QDTextProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDLineProcPtr = PROCEDURE(newPt: Point);
{$ELSEC}
	QDLineProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDRectProcPtr = PROCEDURE(verb: GrafVerb; {CONST}VAR r: Rect);
{$ELSEC}
	QDRectProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDRRectProcPtr = PROCEDURE(verb: GrafVerb; {CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
{$ELSEC}
	QDRRectProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDOvalProcPtr = PROCEDURE(verb: GrafVerb; {CONST}VAR r: Rect);
{$ELSEC}
	QDOvalProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDArcProcPtr = PROCEDURE(verb: GrafVerb; {CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
{$ELSEC}
	QDArcProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDPolyProcPtr = PROCEDURE(verb: GrafVerb; poly: PolyHandle);
{$ELSEC}
	QDPolyProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDRgnProcPtr = PROCEDURE(verb: GrafVerb; rgn: RgnHandle);
{$ELSEC}
	QDRgnProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDBitsProcPtr = PROCEDURE({CONST}VAR srcBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; mode: INTEGER; maskRgn: RgnHandle);
{$ELSEC}
	QDBitsProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDCommentProcPtr = PROCEDURE(kind: INTEGER; dataSize: INTEGER; dataHandle: Handle);
{$ELSEC}
	QDCommentProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDTxMeasProcPtr = FUNCTION(byteCount: INTEGER; textAddr: UNIV Ptr; VAR numer: Point; VAR denom: Point; VAR info: FontInfo): INTEGER;
{$ELSEC}
	QDTxMeasProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDGetPicProcPtr = PROCEDURE(dataPtr: UNIV Ptr; byteCount: INTEGER);
{$ELSEC}
	QDGetPicProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDPutPicProcPtr = PROCEDURE(dataPtr: UNIV Ptr; byteCount: INTEGER);
{$ELSEC}
	QDPutPicProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDOpcodeProcPtr = PROCEDURE({CONST}VAR fromRect: Rect; {CONST}VAR toRect: Rect; opcode: UInt16; version: SInt16);
{$ELSEC}
	QDOpcodeProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDStdGlyphsProcPtr = FUNCTION(dataStream: UNIV Ptr; size: ByteCount): OSStatus; C;
{$ELSEC}
	QDStdGlyphsProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDJShieldCursorProcPtr = PROCEDURE(left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER);
{$ELSEC}
	QDJShieldCursorProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	QDTextUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDTextUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QDLineUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDLineUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QDRectUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDRectUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QDRRectUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDRRectUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QDOvalUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDOvalUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QDArcUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDArcUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QDPolyUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDPolyUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QDRgnUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDRgnUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QDBitsUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDBitsUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QDCommentUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDCommentUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QDTxMeasUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDTxMeasUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QDGetPicUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDGetPicUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QDPutPicUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDPutPicUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QDOpcodeUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDOpcodeUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QDStdGlyphsUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDStdGlyphsUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	QDJShieldCursorUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDJShieldCursorUPP = UniversalProcPtr;
{$ENDC}	
	QDProcsPtr = ^QDProcs;
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


CONST
	uppQDTextProcInfo = $00003F80;
	uppQDLineProcInfo = $000000C0;
	uppQDRectProcInfo = $00000340;
	uppQDRRectProcInfo = $00002B40;
	uppQDOvalProcInfo = $00000340;
	uppQDArcProcInfo = $00002B40;
	uppQDPolyProcInfo = $00000340;
	uppQDRgnProcInfo = $00000340;
	uppQDBitsProcInfo = $0000EFC0;
	uppQDCommentProcInfo = $00000E80;
	uppQDTxMeasProcInfo = $0000FFA0;
	uppQDGetPicProcInfo = $000002C0;
	uppQDPutPicProcInfo = $000002C0;
	uppQDOpcodeProcInfo = $00002BC0;
	uppQDStdGlyphsProcInfo = $000003F1;
	uppQDJShieldCursorProcInfo = $00002A80;
	{
	 *  NewQDTextUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewQDTextUPP(userRoutine: QDTextProcPtr): QDTextUPP; { old name was NewQDTextProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQDLineUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQDLineUPP(userRoutine: QDLineProcPtr): QDLineUPP; { old name was NewQDLineProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQDRectUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQDRectUPP(userRoutine: QDRectProcPtr): QDRectUPP; { old name was NewQDRectProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQDRRectUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQDRRectUPP(userRoutine: QDRRectProcPtr): QDRRectUPP; { old name was NewQDRRectProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQDOvalUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQDOvalUPP(userRoutine: QDOvalProcPtr): QDOvalUPP; { old name was NewQDOvalProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQDArcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQDArcUPP(userRoutine: QDArcProcPtr): QDArcUPP; { old name was NewQDArcProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQDPolyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQDPolyUPP(userRoutine: QDPolyProcPtr): QDPolyUPP; { old name was NewQDPolyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQDRgnUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQDRgnUPP(userRoutine: QDRgnProcPtr): QDRgnUPP; { old name was NewQDRgnProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQDBitsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQDBitsUPP(userRoutine: QDBitsProcPtr): QDBitsUPP; { old name was NewQDBitsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQDCommentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQDCommentUPP(userRoutine: QDCommentProcPtr): QDCommentUPP; { old name was NewQDCommentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQDTxMeasUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQDTxMeasUPP(userRoutine: QDTxMeasProcPtr): QDTxMeasUPP; { old name was NewQDTxMeasProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQDGetPicUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQDGetPicUPP(userRoutine: QDGetPicProcPtr): QDGetPicUPP; { old name was NewQDGetPicProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQDPutPicUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQDPutPicUPP(userRoutine: QDPutPicProcPtr): QDPutPicUPP; { old name was NewQDPutPicProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQDOpcodeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQDOpcodeUPP(userRoutine: QDOpcodeProcPtr): QDOpcodeUPP; { old name was NewQDOpcodeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQDStdGlyphsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQDStdGlyphsUPP(userRoutine: QDStdGlyphsProcPtr): QDStdGlyphsUPP; { old name was NewQDStdGlyphsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewQDJShieldCursorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewQDJShieldCursorUPP(userRoutine: QDJShieldCursorProcPtr): QDJShieldCursorUPP; { old name was NewQDJShieldCursorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeQDTextUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDTextUPP(userUPP: QDTextUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQDLineUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDLineUPP(userUPP: QDLineUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQDRectUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDRectUPP(userUPP: QDRectUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQDRRectUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDRRectUPP(userUPP: QDRRectUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQDOvalUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDOvalUPP(userUPP: QDOvalUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQDArcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDArcUPP(userUPP: QDArcUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQDPolyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDPolyUPP(userUPP: QDPolyUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQDRgnUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDRgnUPP(userUPP: QDRgnUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQDBitsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDBitsUPP(userUPP: QDBitsUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQDCommentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDCommentUPP(userUPP: QDCommentUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQDTxMeasUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDTxMeasUPP(userUPP: QDTxMeasUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQDGetPicUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDGetPicUPP(userUPP: QDGetPicUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQDPutPicUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDPutPicUPP(userUPP: QDPutPicUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQDOpcodeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDOpcodeUPP(userUPP: QDOpcodeUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQDStdGlyphsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDStdGlyphsUPP(userUPP: QDStdGlyphsUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeQDJShieldCursorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeQDJShieldCursorUPP(userUPP: QDJShieldCursorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeQDTextUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQDTextUPP(byteCount: INTEGER; textBuf: UNIV Ptr; numer: Point; denom: Point; userRoutine: QDTextUPP); { old name was CallQDTextProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQDLineUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQDLineUPP(newPt: Point; userRoutine: QDLineUPP); { old name was CallQDLineProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQDRectUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQDRectUPP(verb: GrafVerb; {CONST}VAR r: Rect; userRoutine: QDRectUPP); { old name was CallQDRectProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQDRRectUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQDRRectUPP(verb: GrafVerb; {CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER; userRoutine: QDRRectUPP); { old name was CallQDRRectProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQDOvalUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQDOvalUPP(verb: GrafVerb; {CONST}VAR r: Rect; userRoutine: QDOvalUPP); { old name was CallQDOvalProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQDArcUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQDArcUPP(verb: GrafVerb; {CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER; userRoutine: QDArcUPP); { old name was CallQDArcProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQDPolyUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQDPolyUPP(verb: GrafVerb; poly: PolyHandle; userRoutine: QDPolyUPP); { old name was CallQDPolyProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQDRgnUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQDRgnUPP(verb: GrafVerb; rgn: RgnHandle; userRoutine: QDRgnUPP); { old name was CallQDRgnProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQDBitsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQDBitsUPP({CONST}VAR srcBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; mode: INTEGER; maskRgn: RgnHandle; userRoutine: QDBitsUPP); { old name was CallQDBitsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQDCommentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQDCommentUPP(kind: INTEGER; dataSize: INTEGER; dataHandle: Handle; userRoutine: QDCommentUPP); { old name was CallQDCommentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQDTxMeasUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeQDTxMeasUPP(byteCount: INTEGER; textAddr: UNIV Ptr; VAR numer: Point; VAR denom: Point; VAR info: FontInfo; userRoutine: QDTxMeasUPP): INTEGER; { old name was CallQDTxMeasProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQDGetPicUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQDGetPicUPP(dataPtr: UNIV Ptr; byteCount: INTEGER; userRoutine: QDGetPicUPP); { old name was CallQDGetPicProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQDPutPicUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQDPutPicUPP(dataPtr: UNIV Ptr; byteCount: INTEGER; userRoutine: QDPutPicUPP); { old name was CallQDPutPicProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQDOpcodeUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQDOpcodeUPP({CONST}VAR fromRect: Rect; {CONST}VAR toRect: Rect; opcode: UInt16; version: SInt16; userRoutine: QDOpcodeUPP); { old name was CallQDOpcodeProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeQDStdGlyphsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeQDStdGlyphsUPP(dataStream: UNIV Ptr; size: ByteCount; userRoutine: QDStdGlyphsUPP): OSStatus; { old name was CallQDStdGlyphsProc }
{
 *  InvokeQDJShieldCursorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeQDJShieldCursorUPP(left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER; userRoutine: QDJShieldCursorUPP); { old name was CallQDJShieldCursorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }

TYPE
	GrafPortPtr = ^GrafPort;
	GrafPort = RECORD
		device:					INTEGER;								{  not available in Carbon }
		portBits:				BitMap;									{  in Carbon use GetPortBitMapForCopyBits or IsPortColor }
		portRect:				Rect;									{  in Carbon use Get/SetPortBounds }
		visRgn:					RgnHandle;								{  in Carbon use Get/SetPortVisibleRegion }
		clipRgn:				RgnHandle;								{  in Carbon use Get/SetPortClipRegion }
		bkPat:					Pattern;								{  not available in Carbon all GrafPorts are CGrafPorts }
		fillPat:				Pattern;								{  not available in Carbon all GrafPorts are CGrafPorts }
		pnLoc:					Point;									{  in Carbon use GetPortPenLocation or MoveTo }
		pnSize:					Point;									{  in Carbon use Get/SetPortPenSize }
		pnMode:					INTEGER;								{  in Carbon use Get/SetPortPenMode }
		pnPat:					Pattern;								{  not available in Carbon all GrafPorts are CGrafPorts }
		pnVis:					INTEGER;								{  in Carbon use GetPortPenVisibility or Show/HidePen }
		txFont:					INTEGER;								{  in Carbon use GetPortTextFont or TextFont }
		txFace:					StyleField;								{  in Carbon use GetPortTextFace or TextFace }
																		{ StyleField occupies 16-bits, but only first 8-bits are used }
		txMode:					INTEGER;								{  in Carbon use GetPortTextMode or TextMode }
		txSize:					INTEGER;								{  in Carbon use GetPortTextSize or TextSize }
		spExtra:				Fixed;									{  in Carbon use GetPortSpExtra or SpaceExtra }
		fgColor:				LONGINT;								{  not available in Carbon  }
		bkColor:				LONGINT;								{  not available in Carbon }
		colrBit:				INTEGER;								{  not available in Carbon }
		patStretch:				INTEGER;								{  not available in Carbon }
		picSave:				Handle;									{  in Carbon use IsPortPictureBeingDefined }
		rgnSave:				Handle;									{  not available in Carbon }
		polySave:				Handle;									{  not available in Carbon }
		grafProcs:				QDProcsPtr;								{  not available in Carbon all GrafPorts are CGrafPorts }
	END;

	GrafPtr								= ^GrafPort;
	{	
	 *  This set of definitions "belongs" in Windows.
	 *  But, there is a circularity in the headers where Windows includes Controls and
	 *  Controls includes Windows. To break the circle, the information
	 *  needed by Controls is moved from Windows to Quickdraw.
	 	}
	WindowPtr							= GrafPtr;
	DialogPtr							= WindowPtr;
{$ELSEC}

TYPE
	WindowPtr    = ^LONGINT; { an opaque 32-bit type }
	WindowPtrPtr = ^WindowPtr;  { when a VAR xx:WindowPtr parameter can be nil, it is changed to xx: WindowPtrPtr }
	DialogPtr    = ^LONGINT; { an opaque 32-bit type }
	DialogPtrPtr = ^DialogPtr;  { when a VAR xx:DialogPtr parameter can be nil, it is changed to xx: DialogPtrPtr }
	GrafPtr    = ^LONGINT; { an opaque 32-bit type }
	GrafPtrPtr = ^GrafPtr;  { when a VAR xx:GrafPtr parameter can be nil, it is changed to xx: GrafPtrPtr }
{$ENDC}

	WindowRef							= WindowPtr;
	{  DragConstraint constants to pass to DragGray,DragTheRgn, or ConstrainedDragRgn }
	DragConstraint						= UInt16;

CONST
	kNoConstraint				= 0;
	kVerticalConstraint			= 1;
	kHorizontalConstraint		= 2;



TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	DragGrayRgnProcPtr = PROCEDURE;
{$ELSEC}
	DragGrayRgnProcPtr = ProcPtr;
{$ENDC}

	{	
	 *  Here ends the list of things that "belong" in Windows.
	 	}


	RGBColorPtr = ^RGBColor;
	RGBColor = RECORD
		red:					UInt16;									{ magnitude of red component }
		green:					UInt16;									{ magnitude of green component }
		blue:					UInt16;									{ magnitude of blue component }
	END;

	RGBColorHdl							= ^RGBColorPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	ColorSearchProcPtr = FUNCTION(VAR rgb: RGBColor; VAR position: LONGINT): BOOLEAN;
{$ELSEC}
	ColorSearchProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ColorComplementProcPtr = FUNCTION(VAR rgb: RGBColor): BOOLEAN;
{$ELSEC}
	ColorComplementProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DragGrayRgnUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DragGrayRgnUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ColorSearchUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ColorSearchUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ColorComplementUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ColorComplementUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppDragGrayRgnProcInfo = $00000000;
	uppColorSearchProcInfo = $000003D0;
	uppColorComplementProcInfo = $000000D0;
	{
	 *  NewDragGrayRgnUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewDragGrayRgnUPP(userRoutine: DragGrayRgnProcPtr): DragGrayRgnUPP; { old name was NewDragGrayRgnProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewColorSearchUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewColorSearchUPP(userRoutine: ColorSearchProcPtr): ColorSearchUPP; { old name was NewColorSearchProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewColorComplementUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewColorComplementUPP(userRoutine: ColorComplementProcPtr): ColorComplementUPP; { old name was NewColorComplementProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeDragGrayRgnUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDragGrayRgnUPP(userUPP: DragGrayRgnUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeColorSearchUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeColorSearchUPP(userUPP: ColorSearchUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeColorComplementUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeColorComplementUPP(userUPP: ColorComplementUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeDragGrayRgnUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDragGrayRgnUPP(userRoutine: DragGrayRgnUPP); { old name was CallDragGrayRgnProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeColorSearchUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeColorSearchUPP(VAR rgb: RGBColor; VAR position: LONGINT; userRoutine: ColorSearchUPP): BOOLEAN; { old name was CallColorSearchProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeColorComplementUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeColorComplementUPP(VAR rgb: RGBColor; userRoutine: ColorComplementUPP): BOOLEAN; { old name was CallColorComplementProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


TYPE
	ColorSpecPtr = ^ColorSpec;
	ColorSpec = RECORD
		value:					INTEGER;								{ index or other value }
		rgb:					RGBColor;								{ true color }
	END;

	CSpecArray							= ARRAY [0..0] OF ColorSpec;
	ColorTablePtr = ^ColorTable;
	ColorTable = RECORD
		ctSeed:					LONGINT;								{ unique identifier for table }
		ctFlags:				INTEGER;								{ high bit: 0 = PixMap; 1 = device }
		ctSize:					INTEGER;								{ number of entries in CTTable }
		ctTable:				CSpecArray;								{ array [0..0] of ColorSpec }
	END;

	CTabPtr								= ^ColorTable;
	CTabHandle							= ^CTabPtr;
	xColorSpecPtr = ^xColorSpec;
	xColorSpec = RECORD
		value:					INTEGER;								{ index or other value }
		rgb:					RGBColor;								{ true color }
		xalpha:					INTEGER;
	END;

	xCSpecArray							= ARRAY [0..0] OF xColorSpec;
	MatchRecPtr = ^MatchRec;
	MatchRec = RECORD
		red:					UInt16;
		green:					UInt16;
		blue:					UInt16;
		matchData:				LONGINT;
	END;

	{	
	    QuickTime 3.0 makes PixMap data structure available on non-Mac OS's.
	    In order to implement PixMap in these alternate environments, the PixMap
	    had to be extended. The pmReserved field was changed to pmExt which is
	    a Handle to extra info.  The planeBytes field was changed to pixelFormat.
	    
	    In OS X, Quickdraw also uses the new PixMap data structure.
		}
{$IFC UNDEFINED OLDPIXMAPSTRUCT }
{$IFC TARGET_OS_MAC AND TARGET_API_MAC_OS8 }
{$SETC OLDPIXMAPSTRUCT := 1 }
{$ELSEC}
{$SETC OLDPIXMAPSTRUCT := 0 }
{$ENDC}
{$ENDC}

	{  pixel formats }

CONST
	k1MonochromePixelFormat		= $00000001;					{  1 bit indexed }
	k2IndexedPixelFormat		= $00000002;					{  2 bit indexed }
	k4IndexedPixelFormat		= $00000004;					{  4 bit indexed }
	k8IndexedPixelFormat		= $00000008;					{  8 bit indexed }
	k16BE555PixelFormat			= $00000010;					{  16 bit BE rgb 555 (Mac) }
	k24RGBPixelFormat			= $00000018;					{  24 bit rgb  }
	k32ARGBPixelFormat			= $00000020;					{  32 bit argb    (Mac) }
	k1IndexedGrayPixelFormat	= $00000021;					{  1 bit indexed gray }
	k2IndexedGrayPixelFormat	= $00000022;					{  2 bit indexed gray }
	k4IndexedGrayPixelFormat	= $00000024;					{  4 bit indexed gray }
	k8IndexedGrayPixelFormat	= $00000028;					{  8 bit indexed gray }


	{  values for PixMap.pixelFormat }
	k16LE555PixelFormat			= 'L555';						{  16 bit LE rgb 555 (PC) }
	k16LE5551PixelFormat		= '5551';						{  16 bit LE rgb 5551 }
	k16BE565PixelFormat			= 'B565';						{  16 bit BE rgb 565 }
	k16LE565PixelFormat			= 'L565';						{  16 bit LE rgb 565 }
	k24BGRPixelFormat			= '24BG';						{  24 bit bgr  }
	k32BGRAPixelFormat			= 'BGRA';						{  32 bit bgra    (Matrox) }
	k32ABGRPixelFormat			= 'ABGR';						{  32 bit abgr     }
	k32RGBAPixelFormat			= 'RGBA';						{  32 bit rgba     }
	kYUVSPixelFormat			= 'yuvs';						{  YUV 4:2:2 byte ordering 16-unsigned = 'YUY2' }
	kYUVUPixelFormat			= 'yuvu';						{  YUV 4:2:2 byte ordering 16-signed }
	kYVU9PixelFormat			= 'YVU9';						{  YVU9 Planar    9 }
	kYUV411PixelFormat			= 'Y411';						{  YUV 4:1:1 Interleaved  16 }
	kYVYU422PixelFormat			= 'YVYU';						{  YVYU 4:2:2 byte ordering   16 }
	kUYVY422PixelFormat			= 'UYVY';						{  UYVY 4:2:2 byte ordering   16 }
	kYUV211PixelFormat			= 'Y211';						{  YUV 2:1:1 Packed   8 }
	k2vuyPixelFormat			= '2vuy';						{  UYVY 4:2:2 byte ordering   16 }



TYPE
	PixMapPtr = ^PixMap;
	PixMap = RECORD
		baseAddr:				Ptr;									{ pointer to pixels }
		rowBytes:				INTEGER;								{ offset to next line }
		bounds:					Rect;									{ encloses bitmap }
		pmVersion:				INTEGER;								{ pixMap version number }
		packType:				INTEGER;								{ defines packing format }
		packSize:				LONGINT;								{ length of pixel data }
		hRes:					Fixed;									{ horiz. resolution (ppi) }
		vRes:					Fixed;									{ vert. resolution (ppi) }
		pixelType:				INTEGER;								{ defines pixel type }
		pixelSize:				INTEGER;								{ # bits in pixel }
		cmpCount:				INTEGER;								{ # components in pixel }
		cmpSize:				INTEGER;								{ # bits per component }
		planeBytes:				LONGINT;								{ offset to next plane }
		pmTable:				CTabHandle;								{ color map for this pixMap }
		pmReserved:				LONGINT;
	END;

	PixMapHandle						= ^PixMapPtr;
	PixPatPtr = ^PixPat;
	PixPat = RECORD
		patType:				INTEGER;								{ type of pattern }
		patMap:					PixMapHandle;							{ the pattern's pixMap }
		patData:				Handle;									{ pixmap's data }
		patXData:				Handle;									{ expanded Pattern data }
		patXValid:				INTEGER;								{ flags whether expanded Pattern valid }
		patXMap:				Handle;									{ Handle to expanded Pattern data }
		pat1Data:				Pattern;								{ old-Style pattern/RGB color }
	END;

	PixPatHandle						= ^PixPatPtr;
	CCrsrPtr = ^CCrsr;
	CCrsr = RECORD
		crsrType:				INTEGER;								{ type of cursor }
		crsrMap:				PixMapHandle;							{ the cursor's pixmap }
		crsrData:				Handle;									{ cursor's data }
		crsrXData:				Handle;									{ expanded cursor data }
		crsrXValid:				INTEGER;								{ depth of expanded data (0 if none) }
		crsrXHandle:			Handle;									{ future use }
		crsr1Data:				Bits16;									{ one-bit cursor }
		crsrMask:				Bits16;									{ cursor's mask }
		crsrHotSpot:			Point;									{ cursor's hotspot }
		crsrXTable:				LONGINT;								{ private }
		crsrID:					LONGINT;								{ private }
	END;

	CCrsrHandle							= ^CCrsrPtr;
	GammaTblPtr = ^GammaTbl;
	GammaTbl = RECORD
		gVersion:				INTEGER;								{ gamma version number }
		gType:					INTEGER;								{ gamma data type }
		gFormulaSize:			INTEGER;								{ Formula data size }
		gChanCnt:				INTEGER;								{ number of channels of data }
		gDataCnt:				INTEGER;								{ number of values/channel }
		gDataWidth:				INTEGER;								{ bits/corrected value (data packed to next larger byte size) }
		gFormulaData:			ARRAY [0..0] OF INTEGER;				{ data for formulas followed by gamma values }
	END;

	GammaTblHandle						= ^GammaTblPtr;
	ITabPtr = ^ITab;
	ITab = RECORD
		iTabSeed:				LONGINT;								{ copy of CTSeed from source CTable }
		iTabRes:				INTEGER;								{ bits/channel resolution of iTable }
		iTTable:				SInt8;									{ byte colortable index values }
	END;

	ITabHandle							= ^ITabPtr;
	SProcRecPtr = ^SProcRec;
	SProcRec = RECORD
		nxtSrch:				Handle;									{ SProcHndl Handle to next SProcRec }
		srchProc:				ColorSearchUPP;							{ search procedure proc ptr }
	END;

	SProcPtr							= ^SProcRec;
	SProcHndl							= ^SProcPtr;
	CProcRecPtr = ^CProcRec;
	CProcRec = RECORD
		nxtComp:				Handle;									{ CProcHndl Handle to next CProcRec }
		compProc:				ColorComplementUPP;						{ complement procedure proc ptr }
	END;

	CProcPtr							= ^CProcRec;
	CProcHndl							= ^CProcPtr;
	{	
	    QuickTime 3.0 makes GDevice data structure available on non-Mac OS's.
	    In order to implement GDevice in these alternate environments, the GDevice
	    had to be extended. The gdReserved field was changed to gdExt which is
	    a Handle to extra info.  
		}
{$IFC UNDEFINED OLDGDEVICESTRUCT }
{$IFC TARGET_OS_MAC AND TARGET_API_MAC_OS8 }
{$SETC OLDGDEVICESTRUCT := 1 }
{$ELSEC}
{$SETC OLDGDEVICESTRUCT := 0 }
{$ENDC}
{$ENDC}

	GDevicePtr = ^GDevice;
	GDPtr								= ^GDevice;
	GDHandle							= ^GDPtr;
	GDevice = RECORD
		gdRefNum:				INTEGER;								{ driver's unit number }
		gdID:					INTEGER;								{ client ID for search procs }
		gdType:					INTEGER;								{ fixed/CLUT/direct }
		gdITable:				ITabHandle;								{ Handle to inverse lookup table }
		gdResPref:				INTEGER;								{ preferred resolution of GDITable }
		gdSearchProc:			SProcHndl;								{ search proc list head }
		gdCompProc:				CProcHndl;								{ complement proc list }
		gdFlags:				INTEGER;								{ grafDevice flags word }
		gdPMap:					PixMapHandle;							{ describing pixMap }
		gdRefCon:				LONGINT;								{ reference value }
		gdNextGD:				GDHandle;								{ GDHandle Handle of next gDevice }
		gdRect:					Rect;									{  device's bounds in global coordinates }
		gdMode:					LONGINT;								{ device's current mode }
		gdCCBytes:				INTEGER;								{ depth of expanded cursor data }
		gdCCDepth:				INTEGER;								{ depth of expanded cursor data }
		gdCCXData:				Handle;									{ Handle to cursor's expanded data }
		gdCCXMask:				Handle;									{ Handle to cursor's expanded mask }
		gdReserved:				LONGINT;								{ future use. MUST BE 0 }
	END;

    GrafVars = RECORD
        rgbOpColor:             RGBColor;                               { color for addPin  subPin and average }
        rgbHiliteColor:         RGBColor;                               { color for hiliting }
        pmFgColor:              Handle;                                 { palette Handle for foreground color }
        pmFgIndex:              INTEGER;                                { index value for foreground }
        pmBkColor:              Handle;                                 { palette Handle for background color }
        pmBkIndex:              INTEGER;                                { index value for background }
        pmFlags:                INTEGER;                                { flags for Palette Manager }
    END;
	GVarPtr								= ^GrafVars;
	GVarHandle							= ^GVarPtr;

{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	CGrafPortPtr = ^CGrafPort;
	CGrafPtr							= ^CGrafPort;
{$ELSEC}
	CGrafPtr							= GrafPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	QDPrinterStatusProcPtr = FUNCTION(opcode: PrinterStatusOpcode; currentPort: CGrafPtr; printerStatus: UNIV Ptr): OSStatus; C;
{$ELSEC}
	QDPrinterStatusProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	QDPrinterStatusUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	QDPrinterStatusUPP = UniversalProcPtr;
{$ENDC}	

	CQDProcsPtr = ^CQDProcs;
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
		opcodeProc:				QDOpcodeUPP;
		newProc1:				UniversalProcPtr;						{  this is the StdPix bottleneck -- see ImageCompression.h  }
		glyphsProc:				QDStdGlyphsUPP;							{  was newProc2; now used in Unicode text drawing  }
		printerStatusProc:		QDPrinterStatusUPP;						{  was newProc3;  now used to communicate status between Printing code and System imaging code  }
		newProc4:				UniversalProcPtr;
		newProc5:				UniversalProcPtr;
		newProc6:				UniversalProcPtr;
	END;

{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	CGrafPort = RECORD
		device:					INTEGER;								{  not available in Carbon }
		portPixMap:				PixMapHandle;							{  in Carbon use GetPortPixMap }
		portVersion:			INTEGER;								{  in Carbon use IsPortColor }
		grafVars:				Handle;									{  not available in Carbon }
		chExtra:				INTEGER;								{  in Carbon use GetPortChExtra }
		pnLocHFrac:				INTEGER;								{  in Carbon use Get/SetPortFracHPenLocation }
		portRect:				Rect;									{  in Carbon use Get/SetPortBounds }
		visRgn:					RgnHandle;								{  in Carbon use Get/SetPortVisibleRegion }
		clipRgn:				RgnHandle;								{  in Carbon use Get/SetPortClipRegion }
		bkPixPat:				PixPatHandle;							{  in Carbon use GetPortBackPixPat or BackPixPat }
		rgbFgColor:				RGBColor;								{  in Carbon use GetPortForeColor or RGBForeColor }
		rgbBkColor:				RGBColor;								{  in Carbon use GetPortBackColor or RGBBackColor }
		pnLoc:					Point;									{  in Carbon use GetPortPenLocation or MoveTo }
		pnSize:					Point;									{  in Carbon use Get/SetPortPenSize }
		pnMode:					INTEGER;								{  in Carbon use Get/SetPortPenMode }
		pnPixPat:				PixPatHandle;							{  in Carbon use Get/SetPortPenPixPat }
		fillPixPat:				PixPatHandle;							{  in Carbon use GetPortFillPixPat }
		pnVis:					INTEGER;								{  in Carbon use GetPortPenVisibility or Show/HidePen }
		txFont:					INTEGER;								{  in Carbon use GetPortTextFont or TextFont }
		txFace:					StyleField;								{  in Carbon use GetPortTextFace or TextFace }
																		{ StyleField occupies 16-bits, but only first 8-bits are used }
		txMode:					INTEGER;								{  in Carbon use GetPortTextMode or TextMode }
		txSize:					INTEGER;								{  in Carbon use GetPortTextSize or TextSize }
		spExtra:				Fixed;									{  in Carbon use GetPortSpExtra or SpaceExtra }
		fgColor:				LONGINT;								{  not available in Carbon }
		bkColor:				LONGINT;								{  not available in Carbon }
		colrBit:				INTEGER;								{  not available in Carbon }
		patStretch:				INTEGER;								{  not available in Carbon }
		picSave:				Handle;									{  in Carbon use IsPortPictureBeingDefined }
		rgnSave:				Handle;									{  in Carbon use IsPortRegionBeingDefined }
		polySave:				Handle;									{  in Carbon use IsPortPolyBeingDefined }
		grafProcs:				CQDProcsPtr;							{  in Carbon use Get/SetPortGrafProcs }
	END;

{$ENDC}

{$IFC OPAQUE_TOOLBOX_STRUCTS }
	CWindowPtr							= WindowPtr;
{$ELSEC}
	CWindowPtr							= CGrafPtr;
{$ENDC}  {OPAQUE_TOOLBOX_STRUCTS}

	ReqListRecPtr = ^ReqListRec;
	ReqListRec = RECORD
		reqLSize:				INTEGER;								{ request list size }
		reqLData:				ARRAY [0..0] OF INTEGER;				{ request list data }
	END;

	OpenCPicParamsPtr = ^OpenCPicParams;
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
	CursorImageRecPtr = ^CursorImageRec;
	CursorImageRec = RECORD
		majorVersion:			UInt16;
		minorVersion:			UInt16;
		cursorPixMap:			PixMapHandle;
		cursorBitMask:			BitMapHandle;
	END;

	CursorImagePtr						= ^CursorImageRec;
{$IFC TYPED_FUNCTION_POINTERS}
	DeviceLoopDrawingProcPtr = PROCEDURE(depth: INTEGER; deviceFlags: INTEGER; targetDevice: GDHandle; userData: LONGINT);
{$ELSEC}
	DeviceLoopDrawingProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	DeviceLoopDrawingUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DeviceLoopDrawingUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppQDPrinterStatusProcInfo = $00000FF1;
	uppDeviceLoopDrawingProcInfo = $00003E80;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewQDPrinterStatusUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewQDPrinterStatusUPP(userRoutine: QDPrinterStatusProcPtr): QDPrinterStatusUPP; { old name was NewQDPrinterStatusProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  NewDeviceLoopDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDeviceLoopDrawingUPP(userRoutine: DeviceLoopDrawingProcPtr): DeviceLoopDrawingUPP; { old name was NewDeviceLoopDrawingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  DisposeQDPrinterStatusUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeQDPrinterStatusUPP(userUPP: QDPrinterStatusUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  DisposeDeviceLoopDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDeviceLoopDrawingUPP(userUPP: DeviceLoopDrawingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  InvokeQDPrinterStatusUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeQDPrinterStatusUPP(opcode: PrinterStatusOpcode; currentPort: CGrafPtr; printerStatus: UNIV Ptr; userRoutine: QDPrinterStatusUPP): OSStatus; { old name was CallQDPrinterStatusProc }
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  InvokeDeviceLoopDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDeviceLoopDrawingUPP(depth: INTEGER; deviceFlags: INTEGER; targetDevice: GDHandle; userData: LONGINT; userRoutine: DeviceLoopDrawingUPP); { old name was CallDeviceLoopDrawingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$IFC NOT OPAQUE_TOOLBOX_STRUCTS OR NOT TARGET_API_MAC_CARBON }

TYPE
	QDGlobalsPtr = ^QDGlobals;
	QDGlobals = RECORD
		privates:				PACKED ARRAY [0..75] OF CHAR;
		randSeed:				LONGINT;								{  in Carbon use GetQDGlobalsRandomSeed }
		screenBits:				BitMap;									{  in Carbon use GetQDGlobalsScreenBits }
		arrow:					Cursor;									{  in Carbon use GetQDGlobalsArrow }
		dkGray:					Pattern;								{  in Carbon use GetQDGlobalsDarkGray }
		ltGray:					Pattern;								{  in Carbon use GetQDGlobalsLightGray }
		gray:					Pattern;								{  in Carbon use GetQDGlobalsGray }
		black:					Pattern;								{  in Carbon use GetQDGlobalsBlack }
		white:					Pattern;								{  in Carbon use GetQDGlobalsWhite }
		thePort:				GrafPtr;								{  in Carbon use GetQDGlobalsThePort }
	END;

	QDGlobalsHdl						= ^QDGlobalsPtr;

{ To be in sync with the C interface to QuickDraw globals, pascal code must now }
{ qualify the QuickDraw globals with “qd.” (e.g. InitGraf(@qd.thePort);  )       }
VAR
    {$PUSH}
    {$J+}
    qd: QDGlobals;
    {$POP}
{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  InitGraf()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InitGraf(globalPtr: UNIV Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A86E;
	{$ENDC}

{
 *  OpenPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OpenPort(port: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A86F;
	{$ENDC}

{
 *  InitPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InitPort(port: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A86D;
	{$ENDC}

{
 *  ClosePort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ClosePort(port: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A87D;
	{$ENDC}

{
   These are Carbon only routines. They do nothing at all on
   Mac OS 8, but work flawlessly on Mac OS X.
}
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  LockPortBits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LockPortBits(port: GrafPtr): OSErr;

{
 *  UnlockPortBits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UnlockPortBits(port: GrafPtr): OSErr;

{  Break a region up into rectangles. }


CONST
	kQDParseRegionFromTop		= $01;
	kQDParseRegionFromBottom	= $02;
	kQDParseRegionFromLeft		= $04;
	kQDParseRegionFromRight		= $08;
	kQDParseRegionFromTopLeft	= $05;
	kQDParseRegionFromBottomRight = $0A;


TYPE
	QDRegionParseDirection				= SInt32;

CONST
	kQDRegionToRectsMsgInit		= 1;
	kQDRegionToRectsMsgParse	= 2;
	kQDRegionToRectsMsgTerminate = 3;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	RegionToRectsProcPtr = FUNCTION(message: UInt16; rgn: RgnHandle; {CONST}VAR rect: Rect; refCon: UNIV Ptr): OSStatus; C;
{$ELSEC}
	RegionToRectsProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	RegionToRectsUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	RegionToRectsUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppRegionToRectsProcInfo = $00003FB1;
	{
	 *  NewRegionToRectsUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewRegionToRectsUPP(userRoutine: RegionToRectsProcPtr): RegionToRectsUPP; { old name was NewRegionToRectsProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeRegionToRectsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeRegionToRectsUPP(userUPP: RegionToRectsUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeRegionToRectsUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeRegionToRectsUPP(message: UInt16; rgn: RgnHandle; {CONST}VAR rect: Rect; refCon: UNIV Ptr; userRoutine: RegionToRectsUPP): OSStatus; { old name was CallRegionToRectsProc }
{
 *  QDRegionToRects()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QDRegionToRects(rgn: RgnHandle; dir: QDRegionParseDirection; proc: RegionToRectsUPP; userData: UNIV Ptr): OSStatus; C;

{$IFC NOT TARGET_OS_MAC }
{$IFC CALL_NOT_IN_CARBON }
{
 *  UpdatePort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UpdatePort(port: GrafPtr): OSErr;

{
 *  GetPortNativeWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetPortNativeWindow(macPort: GrafPtr): Ptr;

{
 *  GetNativeWindowPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetNativeWindowPort(nativeWindow: UNIV Ptr): GrafPtr;

{
 *  MacRegionToNativeRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MacRegionToNativeRegion(macRegion: RgnHandle): Ptr;

{
 *  NativeRegionToMacRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NativeRegionToMacRegion(nativeRegion: UNIV Ptr): RgnHandle;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{$IFC TARGET_OS_WIN32 }
{$IFC CALL_NOT_IN_CARBON }
{
 *  GetPortHWND()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetPortHWND(port: GrafPtr): Ptr;

{
 *  GetHWNDPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetHWNDPort(theHWND: UNIV Ptr): GrafPtr;

{
 *  GetPortHDC()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetPortHDC(port: GrafPtr): Ptr;

{
 *  GetPortHBITMAP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetPortHBITMAP(port: GrafPtr): Ptr;

{
 *  GetPortHPALETTE()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetPortHPALETTE(port: GrafPtr): Ptr;

{
 *  GetPortHFONT()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetPortHFONT(port: GrafPtr): Ptr;

{
 *  GetDIBFromPICT()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetDIBFromPICT(hPict: PicHandle): Ptr;

{
 *  GetPICTFromDIB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetPICTFromDIB(h: UNIV Ptr): PicHandle;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_WIN32}

{
 *  [Mac]SetPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPort(port: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A873;
	{$ENDC}

{
 *  GetPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetPort(VAR port: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A874;
	{$ENDC}

{
 *  GrafDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GrafDevice(device: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A872;
	{$ENDC}

{
 *  SetPortBits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPortBits({CONST}VAR bm: BitMap);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A875;
	{$ENDC}

{
 *  PortSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PortSize(width: INTEGER; height: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A876;
	{$ENDC}

{
 *  MovePortTo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MovePortTo(leftGlobal: INTEGER; topGlobal: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A877;
	{$ENDC}

{
 *  SetOrigin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetOrigin(h: INTEGER; v: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A878;
	{$ENDC}

{
 *  SetClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetClip(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A879;
	{$ENDC}

{
 *  GetClip()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetClip(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A87A;
	{$ENDC}

{
 *  ClipRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ClipRect({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A87B;
	{$ENDC}

{
 *  BackPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE BackPat({CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A87C;
	{$ENDC}

{
 *  InitCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InitCursor;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A850;
	{$ENDC}

{
 *  [Mac]SetCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetCursor({CONST}VAR crsr: Cursor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A851;
	{$ENDC}

{
 *  HideCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HideCursor;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A852;
	{$ENDC}

{
 *  [Mac]ShowCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ShowCursor;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A853;
	{$ENDC}

{
 *  ObscureCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ObscureCursor;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A856;
	{$ENDC}

{
 *  HidePen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HidePen;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A896;
	{$ENDC}

{
 *  ShowPen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ShowPen;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A897;
	{$ENDC}

{
 *  GetPen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetPen(VAR pt: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A89A;
	{$ENDC}

{
 *  GetPenState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetPenState(VAR pnState: PenState);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A898;
	{$ENDC}

{
 *  SetPenState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPenState({CONST}VAR pnState: PenState);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A899;
	{$ENDC}

{
 *  PenSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PenSize(width: INTEGER; height: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A89B;
	{$ENDC}

{
 *  PenMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PenMode(mode: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A89C;
	{$ENDC}

{
 *  PenPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PenPat({CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A89D;
	{$ENDC}

{
 *  PenNormal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PenNormal;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A89E;
	{$ENDC}

{
 *  MoveTo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MoveTo(h: INTEGER; v: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A893;
	{$ENDC}

{
 *  Move()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE Move(dh: INTEGER; dv: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A894;
	{$ENDC}

{
 *  [Mac]LineTo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LineTo(h: INTEGER; v: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A891;
	{$ENDC}

{
 *  Line()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE Line(dh: INTEGER; dv: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A892;
	{$ENDC}

{
 *  ForeColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ForeColor(color: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A862;
	{$ENDC}

{
 *  BackColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE BackColor(color: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A863;
	{$ENDC}

{
 *  ColorBit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ColorBit(whichBit: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A864;
	{$ENDC}

{
 *  [Mac]SetRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetRect(VAR r: Rect; left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A7;
	{$ENDC}

{
 *  [Mac]OffsetRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE OffsetRect(VAR r: Rect; dh: INTEGER; dv: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A8;
	{$ENDC}

{
 *  [Mac]InsetRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InsetRect(VAR r: Rect; dh: INTEGER; dv: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A9;
	{$ENDC}

{
 *  SectRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SectRect({CONST}VAR src1: Rect; {CONST}VAR src2: Rect; VAR dstRect: Rect): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8AA;
	{$ENDC}

{
 *  [Mac]UnionRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE UnionRect({CONST}VAR src1: Rect; {CONST}VAR src2: Rect; VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8AB;
	{$ENDC}

{
 *  [Mac]EqualRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION EqualRect({CONST}VAR rect1: Rect; {CONST}VAR rect2: Rect): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A6;
	{$ENDC}

{
 *  EmptyRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION EmptyRect({CONST}VAR r: Rect): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8AE;
	{$ENDC}

{
 *  [Mac]FrameRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FrameRect({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A1;
	{$ENDC}

{
 *  PaintRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PaintRect({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A2;
	{$ENDC}

{
 *  EraseRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE EraseRect({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A3;
	{$ENDC}

{
 *  [Mac]InvertRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvertRect({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A4;
	{$ENDC}

{
 *  [Mac]FillRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FillRect({CONST}VAR r: Rect; {CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A5;
	{$ENDC}

{
 *  FrameOval()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FrameOval({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B7;
	{$ENDC}

{
 *  PaintOval()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PaintOval({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B8;
	{$ENDC}

{
 *  EraseOval()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE EraseOval({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B9;
	{$ENDC}

{
 *  InvertOval()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvertOval({CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8BA;
	{$ENDC}

{
 *  FillOval()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FillOval({CONST}VAR r: Rect; {CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8BB;
	{$ENDC}

{
 *  FrameRoundRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FrameRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B0;
	{$ENDC}

{
 *  PaintRoundRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PaintRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B1;
	{$ENDC}

{
 *  EraseRoundRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE EraseRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B2;
	{$ENDC}

{
 *  InvertRoundRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvertRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B3;
	{$ENDC}

{
 *  FillRoundRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FillRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER; {CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B4;
	{$ENDC}

{
 *  FrameArc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FrameArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8BE;
	{$ENDC}

{
 *  PaintArc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PaintArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8BF;
	{$ENDC}

{
 *  EraseArc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE EraseArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C0;
	{$ENDC}

{
 *  InvertArc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvertArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C1;
	{$ENDC}

{
 *  FillArc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FillArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER; {CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C2;
	{$ENDC}

{
 *  NewRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewRgn: RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D8;
	{$ENDC}

{
 *  OpenRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE OpenRgn;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8DA;
	{$ENDC}

{
 *  CloseRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CloseRgn(dstRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8DB;
	{$ENDC}

{
 *  BitMapToRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BitMapToRegion(region: RgnHandle; {CONST}VAR bMap: BitMap): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D7;
	{$ENDC}

{
 *  HandleToRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HandleToRgn(oldRegion: Handle; region: RgnHandle);

{
 *  RgnToHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in after version 10.0
 }
PROCEDURE RgnToHandle(region: RgnHandle; flattenedRgnDataHdl: Handle);

{
 *  DisposeRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeRgn(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D9;
	{$ENDC}

{
 *  [Mac]CopyRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CopyRgn(srcRgn: RgnHandle; dstRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8DC;
	{$ENDC}

{
 *  SetEmptyRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetEmptyRgn(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8DD;
	{$ENDC}

{
 *  [Mac]SetRectRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetRectRgn(rgn: RgnHandle; left: INTEGER; top: INTEGER; right: INTEGER; bottom: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8DE;
	{$ENDC}

{
 *  RectRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE RectRgn(rgn: RgnHandle; {CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8DF;
	{$ENDC}

{
 *  [Mac]OffsetRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE OffsetRgn(rgn: RgnHandle; dh: INTEGER; dv: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E0;
	{$ENDC}

{
 *  InsetRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InsetRgn(rgn: RgnHandle; dh: INTEGER; dv: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E1;
	{$ENDC}

{
 *  SectRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SectRgn(srcRgnA: RgnHandle; srcRgnB: RgnHandle; dstRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E4;
	{$ENDC}

{
 *  [Mac]UnionRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE UnionRgn(srcRgnA: RgnHandle; srcRgnB: RgnHandle; dstRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E5;
	{$ENDC}

{
 *  DiffRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DiffRgn(srcRgnA: RgnHandle; srcRgnB: RgnHandle; dstRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E6;
	{$ENDC}

{
 *  [Mac]XorRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE XorRgn(srcRgnA: RgnHandle; srcRgnB: RgnHandle; dstRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E7;
	{$ENDC}

{
 *  RectInRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RectInRgn({CONST}VAR r: Rect; rgn: RgnHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E9;
	{$ENDC}

{
 *  [Mac]EqualRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION EqualRgn(rgnA: RgnHandle; rgnB: RgnHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E3;
	{$ENDC}

{
 *  EmptyRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION EmptyRgn(rgn: RgnHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E2;
	{$ENDC}

{
 *  [Mac]FrameRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FrameRgn(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D2;
	{$ENDC}

{
 *  [Mac]PaintRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PaintRgn(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D3;
	{$ENDC}

{
 *  EraseRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE EraseRgn(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D4;
	{$ENDC}

{
 *  [Mac]InvertRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvertRgn(rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D5;
	{$ENDC}

{
 *  [Mac]FillRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FillRgn(rgn: RgnHandle; {CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D6;
	{$ENDC}

{
 *  ScrollRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ScrollRect({CONST}VAR r: Rect; dh: INTEGER; dv: INTEGER; updateRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8EF;
	{$ENDC}

{
 *  CopyBits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CopyBits({CONST}VAR srcBits: BitMap; {CONST}VAR dstBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; mode: INTEGER; maskRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8EC;
	{$ENDC}

{
 *  SeedFill()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SeedFill(srcPtr: UNIV Ptr; dstPtr: UNIV Ptr; srcRow: INTEGER; dstRow: INTEGER; height: INTEGER; words: INTEGER; seedH: INTEGER; seedV: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A839;
	{$ENDC}

{
 *  CalcMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CalcMask(srcPtr: UNIV Ptr; dstPtr: UNIV Ptr; srcRow: INTEGER; dstRow: INTEGER; height: INTEGER; words: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A838;
	{$ENDC}

{
 *  CopyMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CopyMask({CONST}VAR srcBits: BitMap; {CONST}VAR maskBits: BitMap; {CONST}VAR dstBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR maskRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A817;
	{$ENDC}

{
 *  OpenPicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OpenPicture({CONST}VAR picFrame: Rect): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F3;
	{$ENDC}

{
 *  PicComment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PicComment(kind: INTEGER; dataSize: INTEGER; dataHandle: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F2;
	{$ENDC}

{
 *  ClosePicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ClosePicture;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F4;
	{$ENDC}

{
 *  DrawPicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DrawPicture(myPicture: PicHandle; {CONST}VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F6;
	{$ENDC}

{
 *  KillPicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE KillPicture(myPicture: PicHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F5;
	{$ENDC}

{
 *  OpenPoly()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OpenPoly: PolyHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8CB;
	{$ENDC}

{
 *  ClosePoly()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ClosePoly;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8CC;
	{$ENDC}

{
 *  KillPoly()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE KillPoly(poly: PolyHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8CD;
	{$ENDC}

{
 *  OffsetPoly()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE OffsetPoly(poly: PolyHandle; dh: INTEGER; dv: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8CE;
	{$ENDC}

{
 *  FramePoly()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FramePoly(poly: PolyHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C6;
	{$ENDC}

{
 *  PaintPoly()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PaintPoly(poly: PolyHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C7;
	{$ENDC}

{
 *  ErasePoly()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ErasePoly(poly: PolyHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C8;
	{$ENDC}

{
 *  InvertPoly()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvertPoly(poly: PolyHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C9;
	{$ENDC}

{
 *  FillPoly()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FillPoly(poly: PolyHandle; {CONST}VAR pat: Pattern);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8CA;
	{$ENDC}

{
 *  SetPt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPt(VAR pt: Point; h: INTEGER; v: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A880;
	{$ENDC}

{
 *  LocalToGlobal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LocalToGlobal(VAR pt: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A870;
	{$ENDC}

{
 *  GlobalToLocal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GlobalToLocal(VAR pt: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A871;
	{$ENDC}

{
 *  Random()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION Random: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A861;
	{$ENDC}

{
 *  StuffHex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE StuffHex(thingPtr: UNIV Ptr; s: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A866;
	{$ENDC}

{
 *  [Mac]GetPixel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPixel(h: INTEGER; v: INTEGER): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A865;
	{$ENDC}

{
 *  ScalePt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ScalePt(VAR pt: Point; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F8;
	{$ENDC}

{
 *  MapPt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MapPt(VAR pt: Point; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F9;
	{$ENDC}

{
 *  MapRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MapRect(VAR r: Rect; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8FA;
	{$ENDC}

{
 *  MapRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MapRgn(rgn: RgnHandle; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8FB;
	{$ENDC}

{
 *  MapPoly()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MapPoly(poly: PolyHandle; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8FC;
	{$ENDC}

{
 *  SetStdProcs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetStdProcs(VAR procs: QDProcs);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8EA;
	{$ENDC}

{
 *  StdRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE StdRect(verb: GrafVerb; {CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8A0;
	{$ENDC}

{
 *  StdRRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE StdRRect(verb: GrafVerb; {CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8AF;
	{$ENDC}

{
 *  StdOval()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE StdOval(verb: GrafVerb; {CONST}VAR r: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8B6;
	{$ENDC}

{
 *  StdArc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE StdArc(verb: GrafVerb; {CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8BD;
	{$ENDC}

{
 *  StdPoly()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE StdPoly(verb: GrafVerb; poly: PolyHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C5;
	{$ENDC}

{
 *  StdRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE StdRgn(verb: GrafVerb; rgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D1;
	{$ENDC}

{
 *  StdBits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE StdBits({CONST}VAR srcBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; mode: INTEGER; maskRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8EB;
	{$ENDC}

{
 *  StdComment()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE StdComment(kind: INTEGER; dataSize: INTEGER; dataHandle: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F1;
	{$ENDC}

{
 *  StdGetPic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE StdGetPic(dataPtr: UNIV Ptr; byteCount: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8EE;
	{$ENDC}

{
 *  StdPutPic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE StdPutPic(dataPtr: UNIV Ptr; byteCount: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8F0;
	{$ENDC}

{
 *  StdOpcode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE StdOpcode({CONST}VAR fromRect: Rect; {CONST}VAR toRect: Rect; opcode: UInt16; version: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $ABF8;
	{$ENDC}

{
 *  AddPt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE AddPt(src: Point; VAR dst: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A87E;
	{$ENDC}

{
 *  EqualPt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION EqualPt(pt1: Point; pt2: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A881;
	{$ENDC}

{
 *  [Mac]PtInRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PtInRect(pt: Point; {CONST}VAR r: Rect): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8AD;
	{$ENDC}

{
 *  Pt2Rect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE Pt2Rect(pt1: Point; pt2: Point; VAR dstRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8AC;
	{$ENDC}

{
 *  PtToAngle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PtToAngle({CONST}VAR r: Rect; pt: Point; VAR angle: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C3;
	{$ENDC}

{
 *  SubPt()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SubPt(src: Point; VAR dst: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A87F;
	{$ENDC}

{
 *  PtInRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PtInRgn(pt: Point; rgn: RgnHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8E8;
	{$ENDC}

{
 *  StdLine()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE StdLine(newPt: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A890;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  OpenCPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE OpenCPort(port: CGrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA00;
	{$ENDC}

{
 *  InitCPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InitCPort(port: CGrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA01;
	{$ENDC}

{
 *  CloseCPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CloseCPort(port: CGrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA02;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  NewPixMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewPixMap: PixMapHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA03;
	{$ENDC}

{
 *  DisposePixMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposePixMap(pm: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA04;
	{$ENDC}

{
 *  CopyPixMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CopyPixMap(srcPM: PixMapHandle; dstPM: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA05;
	{$ENDC}

{
 *  NewPixPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewPixPat: PixPatHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA07;
	{$ENDC}

{
 *  DisposePixPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposePixPat(pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA08;
	{$ENDC}

{
 *  CopyPixPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CopyPixPat(srcPP: PixPatHandle; dstPP: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA09;
	{$ENDC}

{
 *  PenPixPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PenPixPat(pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA0A;
	{$ENDC}

{
 *  BackPixPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE BackPixPat(pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA0B;
	{$ENDC}

{
 *  GetPixPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPixPat(patID: INTEGER): PixPatHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA0C;
	{$ENDC}

{
 *  MakeRGBPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MakeRGBPat(pp: PixPatHandle; {CONST}VAR myColor: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA0D;
	{$ENDC}

{
 *  FillCRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FillCRect({CONST}VAR r: Rect; pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA0E;
	{$ENDC}

{
 *  FillCOval()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FillCOval({CONST}VAR r: Rect; pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA0F;
	{$ENDC}

{
 *  FillCRoundRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FillCRoundRect({CONST}VAR r: Rect; ovalWidth: INTEGER; ovalHeight: INTEGER; pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA10;
	{$ENDC}

{
 *  FillCArc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FillCArc({CONST}VAR r: Rect; startAngle: INTEGER; arcAngle: INTEGER; pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA11;
	{$ENDC}

{
 *  FillCRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FillCRgn(rgn: RgnHandle; pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA12;
	{$ENDC}

{
 *  FillCPoly()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FillCPoly(poly: PolyHandle; pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA13;
	{$ENDC}

{
 *  RGBForeColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE RGBForeColor({CONST}VAR color: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA14;
	{$ENDC}

{
 *  RGBBackColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE RGBBackColor({CONST}VAR color: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA15;
	{$ENDC}

{
 *  SetCPixel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetCPixel(h: INTEGER; v: INTEGER; {CONST}VAR cPix: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA16;
	{$ENDC}

{
 *  SetPortPix()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPortPix(pm: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA06;
	{$ENDC}

{
 *  GetCPixel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetCPixel(h: INTEGER; v: INTEGER; VAR cPix: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA17;
	{$ENDC}

{
 *  GetForeColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetForeColor(VAR color: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA19;
	{$ENDC}

{
 *  GetBackColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetBackColor(VAR color: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA1A;
	{$ENDC}

{
 *  SeedCFill()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SeedCFill({CONST}VAR srcBits: BitMap; {CONST}VAR dstBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; seedH: INTEGER; seedV: INTEGER; matchProc: ColorSearchUPP; matchData: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA50;
	{$ENDC}

{
 *  CalcCMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CalcCMask({CONST}VAR srcBits: BitMap; {CONST}VAR dstBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR dstRect: Rect; {CONST}VAR seedRGB: RGBColor; matchProc: ColorSearchUPP; matchData: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4F;
	{$ENDC}

{
 *  OpenCPicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OpenCPicture({CONST}VAR newHeader: OpenCPicParams): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA20;
	{$ENDC}

{
 *  OpColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE OpColor({CONST}VAR color: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA21;
	{$ENDC}

{
 *  HiliteColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HiliteColor({CONST}VAR color: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA22;
	{$ENDC}

{
 *  DisposeCTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeCTable(cTable: CTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA24;
	{$ENDC}

{
 *  GetCTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCTable(ctID: INTEGER): CTabHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA18;
	{$ENDC}

{
 *  GetCCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCCursor(crsrID: INTEGER): CCrsrHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA1B;
	{$ENDC}

{
 *  SetCCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetCCursor(cCrsr: CCrsrHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA1C;
	{$ENDC}

{
 *  AllocCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE AllocCursor;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA1D;
	{$ENDC}

{
 *  DisposeCCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeCCursor(cCrsr: CCrsrHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA26;
	{$ENDC}

{  GetCIcon(), PlotCIcon(), and DisposeCIcon() moved to Icons.h }

{
 *  SetStdCProcs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetStdCProcs(VAR procs: CQDProcs);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4E;
	{$ENDC}

{
 *  GetMaxDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMaxDevice({CONST}VAR globalRect: Rect): GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA27;
	{$ENDC}

{
 *  GetCTSeed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCTSeed: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA28;
	{$ENDC}

{
 *  GetDeviceList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDeviceList: GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA29;
	{$ENDC}

{
 *  GetMainDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMainDevice: GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA2A;
	{$ENDC}

{
 *  GetNextDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetNextDevice(curDevice: GDHandle): GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA2B;
	{$ENDC}

{
 *  TestDeviceAttribute()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TestDeviceAttribute(gdh: GDHandle; attribute: INTEGER): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA2C;
	{$ENDC}

{
 *  SetDeviceAttribute()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetDeviceAttribute(gdh: GDHandle; attribute: INTEGER; value: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA2D;
	{$ENDC}

{
 *  InitGDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InitGDevice(qdRefNum: INTEGER; mode: LONGINT; gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA2E;
	{$ENDC}

{
 *  NewGDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewGDevice(refNum: INTEGER; mode: LONGINT): GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA2F;
	{$ENDC}

{
 *  DisposeGDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeGDevice(gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA30;
	{$ENDC}

{
 *  SetGDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetGDevice(gd: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA31;
	{$ENDC}

{
 *  GetGDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetGDevice: GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA32;
	{$ENDC}

{
 *  Color2Index()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION Color2Index({CONST}VAR myColor: RGBColor): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA33;
	{$ENDC}

{
 *  Index2Color()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE Index2Color(index: LONGINT; VAR aColor: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA34;
	{$ENDC}

{
 *  InvertColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvertColor(VAR myColor: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA35;
	{$ENDC}

{
 *  RealColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RealColor({CONST}VAR color: RGBColor): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA36;
	{$ENDC}

{
 *  GetSubTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetSubTable(myColors: CTabHandle; iTabRes: INTEGER; targetTbl: CTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA37;
	{$ENDC}

{
 *  MakeITable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MakeITable(cTabH: CTabHandle; iTabH: ITabHandle; res: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA39;
	{$ENDC}

{
 *  AddSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE AddSearch(searchProc: ColorSearchUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA3A;
	{$ENDC}

{
 *  AddComp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE AddComp(compProc: ColorComplementUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA3B;
	{$ENDC}

{
 *  DelSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DelSearch(searchProc: ColorSearchUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4C;
	{$ENDC}

{
 *  DelComp()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DelComp(compProc: ColorComplementUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4D;
	{$ENDC}

{
 *  SetClientID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetClientID(id: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA3C;
	{$ENDC}

{
 *  ProtectEntry()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ProtectEntry(index: INTEGER; protect: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA3D;
	{$ENDC}

{
 *  ReserveEntry()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ReserveEntry(index: INTEGER; reserve: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA3E;
	{$ENDC}

{
 *  SetEntries()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetEntries(start: INTEGER; count: INTEGER; VAR aTable: CSpecArray);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA3F;
	{$ENDC}

{
 *  SaveEntries()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SaveEntries(srcTable: CTabHandle; resultTable: CTabHandle; VAR selection: ReqListRec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA49;
	{$ENDC}

{
 *  RestoreEntries()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE RestoreEntries(srcTable: CTabHandle; dstTable: CTabHandle; VAR selection: ReqListRec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA4A;
	{$ENDC}

{
 *  QDError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QDError: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA40;
	{$ENDC}

{
 *  CopyDeepMask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CopyDeepMask({CONST}VAR srcBits: BitMap; {CONST}VAR maskBits: BitMap; {CONST}VAR dstBits: BitMap; {CONST}VAR srcRect: Rect; {CONST}VAR maskRect: Rect; {CONST}VAR dstRect: Rect; mode: INTEGER; maskRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA51;
	{$ENDC}

{
 *  DeviceLoop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DeviceLoop(drawingRgn: RgnHandle; drawingProc: DeviceLoopDrawingUPP; userData: LONGINT; flags: DeviceLoopFlags);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $ABCA;
	{$ENDC}



{
 *  GetMaskTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMaskTable: Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A836, $2E88;
	{$ENDC}


{
 *  GetPattern()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPattern(patternID: INTEGER): PatHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B8;
	{$ENDC}

{
 *  [Mac]GetCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCursor(cursorID: INTEGER): CursHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B9;
	{$ENDC}

{
 *  GetPicture()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPicture(pictureID: INTEGER): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9BC;
	{$ENDC}

{
 *  DeltaPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DeltaPoint(ptA: Point; ptB: Point): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94F;
	{$ENDC}

{
 *  ShieldCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ShieldCursor({CONST}VAR shieldRect: Rect; offsetPt: Point);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A855;
	{$ENDC}

{
 *  ScreenRes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ScreenRes(VAR scrnHRes: INTEGER; VAR scrnVRes: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $32B8, $0102, $225F, $32B8, $0104;
	{$ENDC}

{
 *  GetIndPattern()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetIndPattern(VAR thePat: Pattern; patternListID: INTEGER; index: INTEGER);

{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
{
 *  DisposPixMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposPixMap(pm: PixMapHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA04;
	{$ENDC}

{
 *  DisposPixPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposPixPat(pp: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA08;
	{$ENDC}

{
 *  DisposCTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposCTable(cTable: CTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA24;
	{$ENDC}

{
 *  DisposCCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposCCursor(cCrsr: CCrsrHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA26;
	{$ENDC}

{
 *  DisposGDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposGDevice(gdh: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA30;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}

{
    From ToolUtils.i
}
{
 *  PackBits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PackBits(VAR srcPtr: Ptr; VAR dstPtr: Ptr; srcBytes: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8CF;
	{$ENDC}

{
 *  UnpackBits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE UnpackBits(VAR srcPtr: Ptr; VAR dstPtr: Ptr; dstBytes: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8D0;
	{$ENDC}

{
 *  SlopeFromAngle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SlopeFromAngle(angle: INTEGER): Fixed;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8BC;
	{$ENDC}

{
 *  AngleFromSlope()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AngleFromSlope(slope: Fixed): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A8C4;
	{$ENDC}

{ New transfer modes }

CONST
	colorXorXFer				= 52;
	noiseXFer					= 53;
	customXFer					= 54;

	{	 Custom XFer flags 	}
	kXFer1PixelAtATime			= $00000001;					{  1 pixel passed to custom XFer proc }
	kXFerConvertPixelToRGB32	= $00000002;					{  All color depths converted to 32 bit RGB }


TYPE
	CustomXFerRecPtr = ^CustomXFerRec;
	CustomXFerRec = RECORD
		version:				UInt32;
		srcPixels:				Ptr;
		destPixels:				Ptr;
		resultPixels:			Ptr;
		refCon:					UInt32;
		pixelSize:				UInt32;
		pixelCount:				UInt32;
		firstPixelHV:			Point;
		destBounds:				Rect;
	END;

{$IFC TYPED_FUNCTION_POINTERS}
	CustomXFerProcPtr = PROCEDURE(info: CustomXFerRecPtr);
{$ELSEC}
	CustomXFerProcPtr = ProcPtr;
{$ENDC}

	{
	 *  GetPortCustomXFerProc()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION GetPortCustomXFerProc(port: CGrafPtr; VAR proc: CustomXFerProcPtr; VAR flags: UInt32; VAR refCon: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $0019, $AB1D;
	{$ENDC}

{
 *  SetPortCustomXFerProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetPortCustomXFerProc(port: CGrafPtr; proc: CustomXFerProcPtr; flags: UInt32; refCon: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0010, $001A, $AB1D;
	{$ENDC}



CONST
	kCursorComponentsVersion	= $00010001;

	kCursorComponentType		= 'curs';

	{	 Cursor Component capabilities flags 	}
	cursorDoesAnimate			= $00000001;
	cursorDoesHardware			= $00000002;
	cursorDoesUnreadableScreenBits = $00000004;

	{	 Cursor Component output mode flags 	}
	kRenderCursorInHardware		= $00000001;
	kRenderCursorInSoftware		= $00000002;

	{	 Cursor Component Info 	}

TYPE
	CursorInfoPtr = ^CursorInfo;
	CursorInfo = RECORD
		version:				LONGINT;								{  use kCursorComponentsVersion  }
		capabilities:			LONGINT;
		animateDuration:		LONGINT;								{  approximate time between animate tickles  }
		bounds:					Rect;
		hotspot:				Point;
		reserved:				LONGINT;								{  must set to zero  }
	END;

	{	 Cursor Component Selectors 	}

CONST
	kCursorComponentInit		= $0001;
	kCursorComponentGetInfo		= $0002;
	kCursorComponentSetOutputMode = $0003;
	kCursorComponentSetData		= $0004;
	kCursorComponentReconfigure	= $0005;
	kCursorComponentDraw		= $0006;
	kCursorComponentErase		= $0007;
	kCursorComponentMove		= $0008;
	kCursorComponentAnimate		= $0009;
	kCursorComponentLastReserved = $0050;

	{
	 *  OpenCursorComponent()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION OpenCursorComponent(c: Component; VAR ci: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $000B, $ABE0;
	{$ENDC}

{
 *  CloseCursorComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CloseCursorComponent(ci: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000C, $ABE0;
	{$ENDC}

{
 *  SetCursorComponent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetCursorComponent(ci: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000D, $ABE0;
	{$ENDC}

{
 *  CursorComponentChanged()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CursorComponentChanged(ci: ComponentInstance): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0004, $000E, $ABE0;
	{$ENDC}

{
 *  CursorComponentSetData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CursorComponentSetData(ci: ComponentInstance; data: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $203C, $0008, $000F, $ABE0;
	{$ENDC}

{ Quickdraw-specific ColorSync matching }
{ Available in CarbonLib... }
{
 *  IsValidPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsValidPort(port: CGrafPtr): BOOLEAN;


{$IFC ACCESSOR_CALLS_ARE_FUNCTIONS }
{ GrafPort }
{ Getters }
{
 *  GetPortPixMap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortPixMap(port: CGrafPtr): PixMapHandle;

{
 *  GetPortBitMapForCopyBits()
 *  
 *  Discussion:
 *    GetPortBitMapForCopyBits is provided for the specific purpose of
 *    using the return value as a parameter to CopyBits. The return
 *    value can be used as the srcBits or dstBits parameter to CopyBits
 *    regardless of whether the port is color. If the port parameter is
 *    a color port, however, the returned BitMapPtr does not actually
 *    point to a BitMap; it points to the PixMapHandle and other fields
 *    in the CGrafPort structure. You should not dereference the
 *    BitMapPtr or otherwise depend on its contents unless you've
 *    confirmed that this port is a non-color port.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortBitMapForCopyBits(port: CGrafPtr): BitMapPtr;

{
 *  GetPortBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortBounds(port: CGrafPtr; VAR rect: Rect): RectPtr;

{
 *  GetPortForeColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortForeColor(port: CGrafPtr; VAR foreColor: RGBColor): RGBColorPtr;

{
 *  GetPortBackColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortBackColor(port: CGrafPtr; VAR backColor: RGBColor): RGBColorPtr;

{
 *  GetPortOpColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortOpColor(port: CGrafPtr; VAR opColor: RGBColor): RGBColorPtr;

{
 *  GetPortHiliteColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortHiliteColor(port: CGrafPtr; VAR hiliteColor: RGBColor): RGBColorPtr;

{
 *  GetPortGrafProcs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortGrafProcs(port: CGrafPtr): CQDProcsPtr;

{
 *  GetPortTextFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortTextFont(port: CGrafPtr): INTEGER;

{
 *  GetPortTextFace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortTextFace(port: CGrafPtr): ByteParameter;

{
 *  GetPortTextMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortTextMode(port: CGrafPtr): INTEGER;

{
 *  GetPortTextSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortTextSize(port: CGrafPtr): INTEGER;

{
 *  GetPortChExtra()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortChExtra(port: CGrafPtr): INTEGER;

{
 *  GetPortFracHPenLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortFracHPenLocation(port: CGrafPtr): INTEGER;

{
 *  GetPortSpExtra()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortSpExtra(port: CGrafPtr): Fixed;

{
 *  GetPortPenVisibility()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortPenVisibility(port: CGrafPtr): INTEGER;

{
 *  GetPortVisibleRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortVisibleRegion(port: CGrafPtr; visRgn: RgnHandle): RgnHandle;

{
 *  GetPortClipRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortClipRegion(port: CGrafPtr; clipRgn: RgnHandle): RgnHandle;

{
 *  GetPortBackPixPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortBackPixPat(port: CGrafPtr; backPattern: PixPatHandle): PixPatHandle;

{
 *  GetPortPenPixPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortPenPixPat(port: CGrafPtr; penPattern: PixPatHandle): PixPatHandle;

{
 *  GetPortFillPixPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortFillPixPat(port: CGrafPtr; fillPattern: PixPatHandle): PixPatHandle;

{
 *  GetPortPenSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortPenSize(port: CGrafPtr; VAR penSize: Point): PointPtr;

{
 *  GetPortPenMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortPenMode(port: CGrafPtr): SInt32;

{
 *  GetPortPenLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPortPenLocation(port: CGrafPtr; VAR penLocation: Point): PointPtr;

{
 *  IsPortRegionBeingDefined()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsPortRegionBeingDefined(port: CGrafPtr): BOOLEAN;

{
 *  IsPortPictureBeingDefined()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsPortPictureBeingDefined(port: CGrafPtr): BOOLEAN;

{
 *  IsPortPolyBeingDefined()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.3 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsPortPolyBeingDefined(port: CGrafPtr): BOOLEAN;

{
 *  IsPortOffscreen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsPortOffscreen(port: CGrafPtr): BOOLEAN;

{
 *  IsPortColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsPortColor(port: CGrafPtr): BOOLEAN;

{ Setters }
{
 *  SetPortBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPortBounds(port: CGrafPtr; {CONST}VAR rect: Rect);

{
 *  SetPortOpColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPortOpColor(port: CGrafPtr; {CONST}VAR opColor: RGBColor);

{
 *  SetPortGrafProcs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPortGrafProcs(port: CGrafPtr; VAR procs: CQDProcs);

{
 *  SetPortVisibleRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPortVisibleRegion(port: CGrafPtr; visRgn: RgnHandle);

{
 *  SetPortClipRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPortClipRegion(port: CGrafPtr; clipRgn: RgnHandle);

{
 *  SetPortPenPixPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPortPenPixPat(port: CGrafPtr; penPattern: PixPatHandle);

{
 *  SetPortFillPixPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.2 and later
 *    CarbonLib:        in CarbonLib 1.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPortFillPixPat(port: CGrafPtr; penPattern: PixPatHandle);

{
 *  SetPortBackPixPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPortBackPixPat(port: CGrafPtr; backPattern: PixPatHandle);

{
 *  SetPortPenSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPortPenSize(port: CGrafPtr; penSize: Point);

{
 *  SetPortPenMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPortPenMode(port: CGrafPtr; penMode: SInt32);

{
 *  SetPortFracHPenLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetPortFracHPenLocation(port: CGrafPtr; pnLocHFrac: INTEGER);

{ PixMap }
{
 *  GetPixBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPixBounds(pixMap: PixMapHandle; VAR bounds: Rect): RectPtr;

{
 *  GetPixDepth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetPixDepth(pixMap: PixMapHandle): INTEGER;

{ QDGlobals }
{ Getters }
{
 *  GetQDGlobalsRandomSeed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetQDGlobalsRandomSeed: LONGINT;

{
 *  GetQDGlobalsScreenBits()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetQDGlobalsScreenBits(VAR screenBits: BitMap): BitMapPtr;

{
 *  GetQDGlobalsArrow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetQDGlobalsArrow(VAR arrow: Cursor): CursorPtr;

{
 *  GetQDGlobalsDarkGray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetQDGlobalsDarkGray(VAR dkGray: Pattern): PatternPtr;

{
 *  GetQDGlobalsLightGray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetQDGlobalsLightGray(VAR ltGray: Pattern): PatternPtr;

{
 *  GetQDGlobalsGray()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetQDGlobalsGray(VAR gray: Pattern): PatternPtr;

{
 *  GetQDGlobalsBlack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetQDGlobalsBlack(VAR black: Pattern): PatternPtr;

{
 *  GetQDGlobalsWhite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetQDGlobalsWhite(VAR white: Pattern): PatternPtr;

{
 *  GetQDGlobalsThePort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetQDGlobalsThePort: CGrafPtr;

{ Setters }
{
 *  SetQDGlobalsRandomSeed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetQDGlobalsRandomSeed(randomSeed: LONGINT);

{
 *  SetQDGlobalsArrow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetQDGlobalsArrow({CONST}VAR arrow: Cursor);

{ Regions }
{
 *  GetRegionBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetRegionBounds(region: RgnHandle; VAR bounds: Rect): RectPtr;

{
 *  IsRegionRectangular()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsRegionRectangular(region: RgnHandle): BOOLEAN;

{ Utilities }
{ To prevent upward dependencies, GetWindowFromPort() is defined in Window Manager interface: }
{      pascal WindowRef        GetWindowFromPort(CGrafPtr port); }
{ NewPtr/OpenCPort doesn't work with opaque structures }
{
 *  CreateNewPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateNewPort: CGrafPtr;

{
 *  DisposePort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposePort(port: CGrafPtr);


{
 *  SetQDError()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetQDError(err: OSErr);

{$ENDC}  {ACCESSOR_CALLS_ARE_FUNCTIONS}

{
   Routines available on Mac OS X to flush buffered window ports...
   These calls do nothing on Mac OS 8/9. QDIsPortBuffered will always return false there.
}

{
 *  QDIsPortBuffered()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QDIsPortBuffered(port: CGrafPtr): BOOLEAN;

{
 *  QDIsPortBufferDirty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QDIsPortBufferDirty(port: CGrafPtr): BOOLEAN;

{
 *  QDFlushPortBuffer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE QDFlushPortBuffer(port: CGrafPtr; region: RgnHandle);

{
 *  QDGetDirtyRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QDGetDirtyRegion(port: CGrafPtr; rgn: RgnHandle): OSStatus;

{
 *  QDSetDirtyRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QDSetDirtyRegion(port: CGrafPtr; rgn: RgnHandle): OSStatus;


{
 *  CreateCGContextForPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateCGContextForPort(inPort: CGrafPtr; VAR outContext: CGContextRef): OSStatus; C;

{
 *  ClipCGContextToRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ClipCGContextToRegion(gc: CGContextRef; {CONST}VAR portRect: Rect; region: RgnHandle): OSStatus; C;

{
 *  SyncCGContextOriginWithPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SyncCGContextOriginWithPort(inContext: CGContextRef; port: CGrafPtr): OSStatus; C;

{
   Developers need a way to go from a CGDirectDisplay environment to Quickdraw.
   The following is equivalent to CreateNewPort(), but instead of taking the
   portPixMap from the current GDevice, it uses the GDevice corresponding to
   the CGSDisplayID passed in. If the CGSDisplayID is invalid, the mainDevice
   is used instead.
}
{
 *  CreateNewPortForCGDisplayID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateNewPortForCGDisplayID(inCGDisplayID: UInt32): CGrafPtr; C;

{
   In Mac OS X, developers should be able to turn the WaitCursor (spinning wheel)
   on and off. QDDisplayWaitCursor() keeps track of nested calls.
   Passing FALSE will resume automatic wait cursor operation.
   Call this function only from an application in the foreground.
}
{
 *  QDDisplayWaitCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE QDDisplayWaitCursor(forceWaitCursor: BOOLEAN); C;

{
 *  QDSetPatternOrigin()
 *  
 *  Summary:
 *    Sets the pattern origin for the current port.
 *  
 *  Discussion:
 *    When a QuickDraw drawing operation uses a pattern (either a
 *    black&white pattern or a PixPat), the pattern's image is aligned
 *    with port origin, modified by the pattern origin of the port. For
 *    example, if the background pattern is a 10x10 image, and a
 *    rectangle with coordinates (3, 3, 10, 10) is filled with that
 *    pattern, then only the bottom right 7x7 portion of the pattern
 *    image will be drawn into the rectangle. When drawing a pattern,
 *    QuickDraw always starts with the port origin and then adjusts it
 *    by the pattern origin to determine the actual origin point of
 *    pattern drawing. QDSetPatternOrigin can be used to set the
 *    pattern origin relative to the port origin. It is often used in
 *    conjuction with SetOrigin to maintain the pattern alignment at
 *    (0,0) in a window's content area, regardless of the port origin;
 *    for example, after changing the port's origin to (10,10), an
 *    application might change the port's pattern origin to (-10, -10)
 *    so that patterns are still aligned with the window's content area.
 *  
 *  Parameters:
 *    
 *    origin:
 *      The new pattern origin of the port.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NQD 8.5 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE QDSetPatternOrigin(origin: Point); C;

{
 *  QDGetPatternOrigin()
 *  
 *  Summary:
 *    Returns the pattern origin of the current port.
 *  
 *  Parameters:
 *    
 *    origin:
 *      On exit, contains the current port's pattern origin.
 *  
 *  Availability:
 *    Non-Carbon CFM:   in NQD 8.5 and later
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE QDGetPatternOrigin(VAR origin: Point); C;


{ 
    LowMem accessor functions previously in LowMem.h
}
{
 *  LMGetScrVRes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetScrVRes: SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0102;
	{$ENDC}

{
 *  LMSetScrVRes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetScrVRes(value: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $31DF, $0102;
	{$ENDC}

{
 *  LMGetScrHRes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetScrHRes: SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0104;
	{$ENDC}

{
 *  LMSetScrHRes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetScrHRes(value: SInt16);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $31DF, $0104;
	{$ENDC}

{
 *  LMGetMainDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetMainDevice: GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $08A4;
	{$ENDC}

{
 *  LMSetMainDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetMainDevice(value: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $21DF, $08A4;
	{$ENDC}

{
 *  LMGetDeviceList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetDeviceList: GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $08A8;
	{$ENDC}

{
 *  LMSetDeviceList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetDeviceList(value: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $21DF, $08A8;
	{$ENDC}

{
 *  LMGetQDColors()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetQDColors: Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $08B0;
	{$ENDC}

{
 *  LMSetQDColors()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetQDColors(value: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $21DF, $08B0;
	{$ENDC}

{
 *  LMGetWidthListHand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetWidthListHand: Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $08E4;
	{$ENDC}

{
 *  LMSetWidthListHand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetWidthListHand(value: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $21DF, $08E4;
	{$ENDC}

{
 *  LMGetHiliteMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetHiliteMode: ByteParameter;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $1EB8, $0938;
	{$ENDC}

{
 *  LMSetHiliteMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetHiliteMode(value: ByteParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $11DF, $0938;
	{$ENDC}

{
 *  LMGetWidthPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetWidthPtr: Ptr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $0B10;
	{$ENDC}

{
 *  LMSetWidthPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetWidthPtr(value: Ptr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $21DF, $0B10;
	{$ENDC}

{
 *  LMGetWidthTabHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetWidthTabHandle: Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $0B2A;
	{$ENDC}

{
 *  LMSetWidthTabHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetWidthTabHandle(value: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $21DF, $0B2A;
	{$ENDC}

{
 *  LMGetLastSPExtra()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetLastSPExtra: SInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $0B4C;
	{$ENDC}

{
 *  LMSetLastSPExtra()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetLastSPExtra(value: SInt32);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $21DF, $0B4C;
	{$ENDC}

{
 *  LMGetLastFOND()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetLastFOND: Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $0BC2;
	{$ENDC}

{
 *  LMSetLastFOND()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetLastFOND(value: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $21DF, $0BC2;
	{$ENDC}

{
 *  LMGetFractEnable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetFractEnable: ByteParameter;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $1EB8, $0BF4;
	{$ENDC}

{
 *  LMSetFractEnable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetFractEnable(value: ByteParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $11DF, $0BF4;
	{$ENDC}

{
 *  LMGetTheGDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetTheGDevice: GDHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $0CC8;
	{$ENDC}

{
 *  LMSetTheGDevice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetTheGDevice(value: GDHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $21DF, $0CC8;
	{$ENDC}


{$IFC TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM }
{$IFC CALL_NOT_IN_CARBON }
{
 *  LMGetHiliteRGB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE LMGetHiliteRGB(VAR hiliteRGBValue: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $225F, $41F8, $0DA0, $22D8, $32D8;
	{$ENDC}

{
 *  LMSetHiliteRGB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE LMSetHiliteRGB({CONST}VAR hiliteRGBValue: RGBColor);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $43F8, $0DA0, $22D8, $32D8;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ELSEC}
{
 *  LMGetHiliteRGB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMGetHiliteRGB(VAR hiliteRGBValue: RGBColor);

{
 *  LMSetHiliteRGB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetHiliteRGB({CONST}VAR hiliteRGBValue: RGBColor);

{$ENDC}

{
 *  LMGetCursorNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetCursorNew: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $1EB8, $08CE;
	{$ENDC}

{
 *  LMSetCursorNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LMSetCursorNew(value: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $11DF, $08CE;
	{$ENDC}

















{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := QuickdrawIncludes}

{$ENDC} {__QUICKDRAW__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

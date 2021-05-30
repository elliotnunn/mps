{
  File: ToolIntf.p

 Copyright Apple Computer, Inc. 1984-1987
 All Rights Reserved
}


UNIT ToolIntf;

  INTERFACE

	USES {$U MemTypes.p } MemTypes,
	{$U QuickDraw.p } QuickDraw,
	{$U OsIntf.p	} OsIntf;

	CONST
	{ for Font Manager }

	commandMark = $11;
	checkMark = $12;
	diamondMark = $13;
	appleMark = $14;

	systemFont = 0;
	applFont = 1;
	newYork = 2;
	geneva = 3;
	monaco = 4;
	venice = 5;
	london = 6;
	athens = 7;
	sanFran = 8;
	toronto = 9;
	cairo = 11;
	losAngeles = 12;
	times = 20;
	helvetica = 21;
	courier = 22;
	symbol = 23;
	mobile = 24;

	propFont = $9000;
	prpFntH = $9001;
	prpFntW = $9002;
	prpFntHW = $9003;

	fixedFont = $B000;
	fxdFntH = $B001;
	fxdFntW = $B002;
	fxdFntHW = $B003;

	fontWid = $ACB0;

	{for Window Manager}

	{window messages}
	wDraw = 0;
	wHit = 1;
	wCalcRgns = 2;
	wNew = 3;
	wDispose = 4;
	wGrow = 5;
	wDrawGIcon = 6;

	{types of windows}
	dialogKind = 2;
	userKind = 8;

	{desk pattern resource ID}
	deskPatID = 16;

	{window definition PROCEDURE IDs}
	documentProc = 0;
	dBoxProc = 1;
	plainDBox = 2;
	altDBoxProc = 3;
	noGrowDocProc = 4;
	zoomDocProc = 8;
	zoomNoGrow = 12;
	rDocProc = 16;

	{FindWindow Result Codes}
	inDesk = 0;
	inMenuBar = 1;
	inSysWindow = 2;
	inContent = 3;
	inDrag = 4;
	inGrow = 5;
	inGoAway = 6;

	{new 128K ROM}
	inZoomIn = 7;
	inZoomOut = 8;

	{defProc hit test codes}
	wNoHit = 0;
	wInContent = 1;
	wInDrag = 2;
	wInGrow = 3;
	wInGoAway = 4;

	{new 128K ROM}
	wInZoomIn = 5;
	wInZoomOut = 6;

	{axis constraints for DragGrayRgn call}
	noConstraint = 0;
	hAxisOnly = 1;
	vAxisOnly = 2;

	{for TextEdit}

	teJustLeft = 0;
	teJustRight = - 1;
	teJustCenter = 1;
	teForceLeft = -2; 	{for Arabic fonts, force left justification }

	{for Resource Manager}

	{Resource attribute byte}
	resSysHeap = 64; { System or application heap? }
	resPurgeable = 32; { Purgeable resource? }
	resLocked = 16; { Load it in locked? }
	resProtected = 8; { Protected? }
	resPreload = 4; { Load in on OpenResFile? }
	resChanged = 2; { Resource changed? }

	mapReadOnly = 128; { Resource file read-only }
	mapCompact = 64; { Compact resource file }
	mapChanged = 32; { Write map out at update }

	resNotFound = -192; { Resource not found }
	resFNotFound = -193; { Resource file not found }
	addResFailed = -194; { AddResource failed }
	rmvResFailed = -196; { RmveResource failed }
	rmvRefFailed = -197; { RmveReference failed }
	resAttrErr = -198; { attribute inconsistent with operation }
	mapReadErr = -199; { map inconsistent with operation }

	{ID's for resources provided in sysResDef}

	{standard cursor definitions}
	iBeamCursor = 1; {text selection cursor}
	crossCursor = 2; {for drawing graphics}
	plusCursor = 3; {for structured selection}
	watchCursor = 4; {for indicating a long delay}

	{icons}
	stopIcon = 0;
	noteIcon = 1;
	cautionIcon = 2;

	{patterns}
	sysPatListID = 0; {ID of PAT# which contains 38 patterns}

	{for Control Manager}

	{control messages}
	drawCntl = 0;
	testCntl = 1;
	calcCRgns = 2;
	initCntl = 3;
	dispCntl = 4;
	posCntl = 5;
	thumbCntl = 6;
	dragCntl = 7;
	autoTrack = 8;

	{FindControl Result Codes}
	inButton = 10;
	inCheckbox = 11;
	inUpButton = 20;
	inDownButton = 21;
	inPageUp = 22;
	inPageDown = 23;
	inThumb = 129;

	{control definition proc ID's}
	pushButProc = 0;
	checkBoxProc = 1;
	radioButProc = 2;
	scrollBarProc = 16;

	useWFont = 8;

	{for Dialog Manager}

	userItem = 0;
	ctrlItem = 4;
	btnCtrl = 0; { Low two bits specify what kind of control }
	chkCtrl = 1;
	radCtrl = 2;
	resCtrl = 3;

	statText = 8; { Static text }
	editText = 16; { Editable text }
	iconItem = 32; { Icon item }
	picItem = 64; { Picture item }
	itemDisable = 128; { Disable item if set }

	ok = 1; { OK button is first by convention }
	cancel = 2; { Cancel button is second by convention }

	{for Menu Manager}

	noMark = 0; { mark symbol for MarkItem }
	textMenuProc = 0;

	{ menu defProc messages }
	mDrawMsg = 0;
	mChooseMsg = 1;
	mSizeMsg = 2;

	{for Scrap Manager}

	noScrapErr = - 100; {desk scrap isn't initialized}
	noTypeErr = - 102;

	{package manager}
	listMgr = 0; {list manager}
	dskInit = 2; {Disk Initializaton}
	stdFile = 3; {Standard File}
	flPoint = 4; {Floating-Point Arithmetic}
	trFunc = 5; {Transcendental FUNCTIONs}
	intUtil = 6; {International Utilities}
	bdConv = 7; {Binary/Decimal Conversion}


{************** NEW TOOL CONSTANTS ************}					

{Text Edit}

doFont		= 1;	{ set font (family) number	}
doFace		= 2;	{ set character style		}
doSize		= 4;	{ set type size 			}
doColor 	= 8;	{ set color 				}
doAll		= 15;	{ set all attributes		}
addSize 	= 16;	{ adjust type size			}
		
{Color Window Manager}

	{Window Part Identifiers which correlate color table
		entries with window color table elements}

wContentColor	=		0;
wFrameColor 	=		1;
wTextColor		=		2;
wHiliteColor	=		3;
wTitleBarColor	=		4;

{Color Control Manager}

	{Control Part Identifiers which correlate color table
		entries with control color table elements}

cFrameColor 	=	 0;
cBodyColor		=	 1;
cTextColor		=	 2;
cThumbColor 	=	 3;

{Menu Manager}

hMenuCmd		=	$1B;	{itemCmd == $1B ==> hierarchical menu}
hierMenu		=	-1; 	{a hierarchical menu - for InsertMenu call}
mPopUpMsg		=	3;		{ menu defProc messages }
mctAllItems 	=	-98;	{ search for all Items for the given ID }
mctLastIDIndic	=	-99;	{ last color table entry has this in ID field }

{ Menu Manager Errors }

dsMBarNFnd		=	85;
dsHMenuFindErr	=	86;

	TYPE

	{General Utilities}

	Int64Bit = RECORD
				 hiLong: LONGINT;
				 loLong: LONGINT;
				 END;

	CursPtr = ^Cursor;
	CursHandle = ^CursPtr;

	PatPtr = ^Pattern;
	PatHandle = ^PatPtr;

	{for Font Manager}

	FMInput = PACKED RECORD
				family: INTEGER;
				size: INTEGER;
				face: Style;
				needBits: BOOLEAN;
				device: INTEGER;
				numer: Point;
				denom: Point;
				END;

	FMOutPtr = ^FMOutPut;

	FMOutPut = PACKED RECORD
				 errNum: INTEGER;
				 fontHandle: Handle;
				 bold: Byte;
				 italic: Byte;
				 ulOffset: Byte;
				 ulShadow: Byte;
				 ulThick: Byte;
				 shadow: Byte;
				 extra: SignedByte;
				 ascent: Byte;
				 descent: Byte;
				 widMax: Byte;
				 leading: SignedByte;
				 unused: Byte;
				 numer: Point;
				 denom: Point;
				 END;

	FontRec = RECORD
				fontType: INTEGER; { font type }
				firstChar: INTEGER; { ASCII code of first character }
				lastChar: INTEGER; { ASCII code of last character }
				widMax: INTEGER; { maximum character width }
				kernMax: INTEGER; { negative of maximum character kern }
				nDescent: INTEGER; { negative of descent }
				fRectWidth: INTEGER; { width of font rectangle }
				fRectHeight: INTEGER; { height of font rectangle }
				oWTLoc: INTEGER; { offset to offset/width table }
				ascent: INTEGER; { ascent }
				descent: INTEGER; { descent }
				leading: INTEGER; { leading }
				rowWords: INTEGER; { row width of bit image / 2 }
				{ bitImage:    ARRAY[1..rowWords,1..fRectHeight] OF INTEGER;
				locTable:    ARRAY[firstChar..lastChar+2] OF INTEGER;
				owTable:	ARRAY[firstChar..lastChar+2] OF INTEGER;
				widthTable: ARRAY[firstChar..lastChar+2] OF INTEGER;
				heightTable: ARRAY[firstChar..lastChar+2] OF INTEGER; }
				END;

	{new 128K ROM}

	FMetricRec = RECORD
					 ascent: Fixed; {base line to top}
					 descent: Fixed; {base line to bottom}
					 leading: Fixed; {leading between lines}
					 widMax: Fixed; {maximum character width}
					 wTabHandle: Fixed; {handle to font width table}
				 END;

	WidTable = RECORD
				 numWidths: INTEGER; {number of entries - 1}
						{widList: ARRAY[1..numWidths] of WidEntry}
				 END;

	WidEntry = RECORD
				 widStyle: INTEGER; {style entry applies to}
					 {widRec: ARRAY[firstChar..lastChar] of INTEGER}
				 END;

	AsscEntry = RECORD
					fontSize: INTEGER;
					fontStyle: INTEGER;
					fontID: INTEGER; {font resource ID}
				END;

	FontAssoc = RECORD
					numAssoc: INTEGER; {number of entries - 1}
						{asscTable: ARRAY[1..numAssoc] OF AsscEntry}
				END;

	StyleTable = RECORD
					 fontClass: INTEGER;
					 offset: LONGINT;
					 reserved: LONGINT;
					 indexes: ARRAY [0..47] OF SignedByte;
				 END;

	NameTable = RECORD
					stringCount: INTEGER;
					baseFontName: Str255;
							{strings: ARRAY[2..stringCount]  OF STRING}
							{the lengths of the strings are arbitrary}
				END;

	KernPair = RECORD
				 kernFirst: CHAR; {1st character of kerned pair}
				 kernSecond: CHAR; {2nd character of kerned pair}
				 kernWidth: INTEGER; {kerning in 1pt fixed format}
				 END;

	KernEntry = RECORD
					kernLength: INTEGER; {length of this entry}
					kernStyle: INTEGER; {style the entry applies to}
						 {kernRec: ARRAY[1..(kernLength/4)-1] OF KernPair}
				END;

	KernTable = RECORD
					numKerns: INTEGER; {number of kerning entries}
						{kernList: ARRAY[1..numKerns] OF KernEntry}
				END;

	WidthTable = PACKED RECORD
					 tabData: ARRAY [1..256] OF Fixed; {character widths}
					 tabFont: Handle; {font record used to build table}
					 sExtra: LONGINT; {space extra used for table}
					 Style: LONGINT; {extra due to style}
					 fID: INTEGER; {font family ID}
					 fSize: INTEGER; {font size request}
					 face: INTEGER; {style (face) request}
					 device: INTEGER; {device requested}
					 vInScale: Fixed; {scale factors requested}
					 hInScale: Fixed; {scale factors requested}
					 aFID: INTEGER; {actual font family ID for table}
					 fHand: Handle; {family record used to build up table}
					 usedFam: BOOLEAN; {used fixed point family widths}
					 aFace: Byte; {actual face produced}
					 vOutput: INTEGER; {vertical scale output value}
					 hOutput: INTEGER; {horizontal scale output value}
					 vFactor: INTEGER; {vertical scale output value}
					 hFactor: INTEGER; {horizontal scale output value}
					 aSize: INTEGER; {actual size of actual font used}
					 tabSize: INTEGER; {total size of table}
				 END;

	FamRec = RECORD
				 ffFlags: INTEGER; {flags for family}
				 ffFamID: INTEGER; {family ID number}
				 ffFirstChar: INTEGER; {ASCII code of 1st character}
				 ffLastChar: INTEGER; {ASCII code of last character}
				 ffAscent: INTEGER; {maximum ascent for 1pt font}
				 ffDescent: INTEGER; {maximum descent for 1pt font}
				 ffLeading: INTEGER; {maximum leading for 1pt font}
				 ffWidMax: INTEGER; {maximum widMax for 1pt font}
				 ffWTabOff: LONGINT; {offset to width table}
				 ffKernOff: LONGINT; {offset to kerning table}
				 ffStylOff: LONGINT; {offset to style mapping table}
				 ffProperty: ARRAY [1..9] OF INTEGER; {style property info}
				 ffIntl: ARRAY [1..2] OF INTEGER; {for international use}
				 ffVersion: INTEGER; {version number}
					{ffAssoc:    FontAssoc;} {font association table}
					{ffWidthTab: WidTable;} {width table}
					{ffStyTab:   StyleTable;} {style mapping table}
					{ffKernTab:  KernTable;} {kerning table}
			 END;

	{for Event Manager}

	{the Event Record is defined in OsIntf}

	KeyMap = PACKED ARRAY [0..127] OF BOOLEAN;

	{for Window Manager}

	WindowPtr = GrafPtr;
	WindowPeek = ^WindowRecord;
	ControlHandle = ^ControlPtr; {for Control Manager}

	WindowRecord = RECORD
					 port: GrafPort;
					 windowKind: INTEGER;
					 visible: BOOLEAN;
					 hilited: BOOLEAN;
					 goAwayFlag: BOOLEAN;
					 spareFlag: BOOLEAN;
					 strucRgn: RgnHandle;
					 contRgn: RgnHandle;
					 updateRgn: RgnHandle;
					 windowDefProc: Handle;
					 dataHandle: Handle;
					 titleHandle: StringHandle;
					 titleWidth: INTEGER;
					 ControlList: ControlHandle;
					 nextWindow: WindowPeek;
					 windowPic: PicHandle;
					 refCon: LONGINT;
					 END;

	WStateData = RECORD
					 userState: Rect;
					 stdState: Rect;
					 END;

	{for TextEdit}

	TERec = RECORD
				destRect: Rect; {Destination rectangle}
				viewRect: Rect; {view rectangle}
				selRect: Rect; {Select rectangle}
				lineHeight: INTEGER; {Current font lineheight}
				fontAscent: INTEGER; {Current font ascent}
				selPoint: Point; {Selection point(mouseLoc)}

				selStart: INTEGER; {Selection start}
				selEnd: INTEGER; {Selection end}

				active: INTEGER; {<>0 if active}

				wordBreak: ProcPtr; {Word break routine}
				clikLoop: ProcPtr; {Click loop routine}

				clickTime: LONGINT; {Time of first click}
				clickLoc: INTEGER; {Char. location of click}

				caretTime: LONGINT; {Time for next caret blink}
				caretState: INTEGER; {On/active booleans}

				just: INTEGER; {fill style}

				teLength: INTEGER; {Length of text below}
				hText: Handle; {Handle to actual text}

				recalBack: INTEGER; {<>0 if recal in background}
				recalLines: INTEGER; {Line being recal'ed}
				clikStuff: INTEGER; {click stuff (internal)}

				crOnly: INTEGER; {Set to -1 if CR line breaks only}

				txFont: INTEGER; {Text Font}
				txFace: Style; {Text Face}
				txMode: INTEGER; {Text Mode}
				txSize: INTEGER; {Text Size}

				inPort: GrafPtr; {Grafport}

				highHook: ProcPtr; {Highlighting hook}
				caretHook: ProcPtr; {Highlighting hook}

				nLines: INTEGER; {Number of lines}
				lineStarts: ARRAY [0..16000] OF INTEGER; {Actual line starts
												themselves}
			END; {RECORD}
	TEPtr = ^TERec;
	TEHandle = ^TEPtr;

	CharsHandle = ^CharsPtr;
	CharsPtr = ^Chars;
	Chars = PACKED ARRAY [0..32000] OF CHAR;

	{for Resource Manager}

	ResType = PACKED ARRAY [1..4] OF CHAR;

	{for Control Manager}

	ControlPtr = ^ControlRecord;

	ControlRecord = PACKED RECORD
					nextControl: ControlHandle;
					contrlOwner: WindowPtr;
					contrlRect: Rect;
					contrlVis: Byte;
					contrlHilite: Byte;
					contrlValue: INTEGER;
					contrlMin: INTEGER;
					contrlMax: INTEGER;
					contrlDefProc: Handle;
					contrlData: Handle;
					contrlAction: ProcPtr;
					contrlrfCon: LONGINT;
					contrlTitle: Str255;
					END; {ControlRecord}

	{for Dialog Manager}

	DialogPtr = WindowPtr;
	DialogPeek = ^DialogRecord;
	DialogRecord = RECORD
					 window: WindowRecord;
					 Items: Handle;
					 textH: TEHandle;
					 editField: INTEGER;
					 editOpen: INTEGER;
					 aDefItem: INTEGER;
					 END;

	DialogTHndl = ^DialogTPtr;
	DialogTPtr = ^DialogTemplate;
	DialogTemplate = RECORD
					 boundsRect: Rect;
					 procID: INTEGER;
					 visible: BOOLEAN;
					 filler1: BOOLEAN;
					 goAwayFlag: BOOLEAN;
					 filler2: BOOLEAN;
					 refCon: LONGINT;
					 ItemsID: INTEGER;
					 title: Str255;
					 END;

	StageList = PACKED RECORD
					boldItm4: 0..1;
					boxDrwn4: BOOLEAN;
					sound4: 0..3;
					boldItm3: 0..1;
					boxDrwn3: BOOLEAN;
					sound3: 0..3;
					boldItm2: 0..1;
					boxDrwn2: BOOLEAN;
					sound2: 0..3;
					boldItm1: 0..1;
					boxDrwn1: BOOLEAN;
					sound1: 0..3;
				END;

	AlertTHndl = ^AlertTPtr;
	AlertTPtr = ^AlertTemplate;
	AlertTemplate = RECORD
					boundsRect: Rect;
					ItemsID: INTEGER;
					stages: StageList;
					END;

	{for Menu Manager}

	MenuPtr = ^MenuInfo;
	MenuHandle = ^MenuPtr;
	MenuInfo = RECORD
				 menuId: INTEGER;
				 menuWidth: INTEGER;
				 menuHeight: INTEGER;
				 menuProc: Handle;
				 enableFlags: LONGINT;
				 menuData: Str255;
				 END;

	{for Scrap Manager}

	ScrapStuff = RECORD
					 scrapSize: LONGINT;
					 scrapHandle: Handle;
					 scrapCount: INTEGER;
					 scrapState: INTEGER;
					 scrapName: StringPtr;
				 END;
	pScrapStuff = ^ScrapStuff;

{************** NEW TOOL TYPES ************}					

{Text Edit}

	StyleRun		= RECORD
					startChar	: INTEGER;	{ starting character position	}
					styleIndex	: INTEGER;	{ index in style table	}
					END;
		
	STHandle		= ^STPtr;
	STPtr			= ^TEStyleTable;
		
	STElement		= RECORD
					stCount 	: INTEGER;	{ number of runs in this style	}
					stHeight	: INTEGER;	{ line height	}
					stAscent	: INTEGER;	{ font ascent	}
					stFont		: INTEGER;	{ font (family) number	}
					stFace		: Style;	{ character style	}
					stSize		: INTEGER;	{ size in points	}
					stColor 	: RGBColor; { absolut (RGB) color	}
					END;
					
	TEStyleTable		= ARRAY [0..1776] OF STElement;
		
	LHHandle		= ^LHPtr;
	LHPtr			= ^LHTable;
		
	LHElement		= RECORD
					lhHeight	: INTEGER;	{ maximum height in line	}
					lhAscent	: INTEGER;	{ maximum ascent in line	}
					END;
					
	LHTable 		= ARRAY [0..8000] OF LHElement;
		
	ScrpSTElement = RECORD
					scrpStartChar:	LONGINT; {starting character position}
					scrpHeight: 	INTEGER;
					scrpAscent: 	INTEGER;
					scrpFont:		INTEGER;
					scrpFace:		Style;
					scrpSize:		INTEGER;
					scrpColor:		RGBColor;
				END;
	ScrpSTTable 	= ARRAY[0..1600] OF ScrpSTElement;

	StScrpHandle = ^StScrpPtr;
	StScrpPtr	= ^StScrpRec;
	StScrpRec	= RECORD
				scrpNStyles : INTEGER;		{ number of styles in scrap }
				scrpStyleTab : ScrpSTTable; { table of styles for scrap }
			END;
					
	NullStHandle = ^NullStPtr;
	NullStPtr	= ^NullStRec;
	NullStRec	= RECORD
				teReserved		: LONGINT;		{ reserved for future expansion }
				nullScrap		: StScrpHandle; { handle to scrap style table. }
			END;
		
	TEStyleHandle = ^TEStylePtr;
	TEStylePtr	= ^TEStyleRec;
	TEStyleRec	= RECORD
					nRuns		: INTEGER;	{ number of style runs	}
					nStyles 	: INTEGER;	{ size of style table	}
					styleTab	: STHandle; { handle to style table }
					lhTab		: LHHandle; { handle to line-height table	}
					teRefCon	: LONGINT;	{ reserved for application use	}
					nullStyle	: NullStHandle; { Handle to style set at null selection }
					runs		: ARRAY [0..8000] OF StyleRun;
				END;
		
	TextStyle	= RECORD
					tsFont		: INTEGER;	{ font (family) number	}
					tsFace		: Style;	{ character style	}
					tsSize		: INTEGER;	{ size in point }
					tsColor 	: RGBColor; { absolute (RGB) color	}
				END;
					
{Color Control Manager}
				
	CCTabHandle = ^CCTabPtr;				{ handle to a control color table }
	CCTabPtr	= ^CtlCTab;
	CtlCTab = RECORD
				ccSeed: 		LONGINT;	{ reserved }
				ccRider:		INTEGER;	{ see what you have done - reserved }
				ctSize: 		INTEGER;	{ usually 3 for controls}
				ctTable:		ARRAY [0..3] OF ColorSpec;
			END;

	
	AuxCtlHndl	=	^AuxCtlPtr;
	AuxCtlPtr	=	^AuxCtlRec;
	AuxCtlRec = RECORD
				acNext: 		AuxCtlHndl; 	{handle to next AuxCtlRec}
				acOwner:		ControlHandle;	{control handle of control of which this is the aux record}
				acCTable:		CCTabHandle;	{color table for this control}
				acFlags:		INTEGER;		{misc flags [word]}
				acReserved: 	LONGINT;		{reserved for use by Apple}
				acRefCon:		LONGINT;		{for use by application}
			END;
{Color Window Manager}

	AuxWinHndl = ^AuxWinPtr;
	AuxWinPtr = ^AuxWinRec;
	AuxWinRec = RECORD
				 awNext:		AuxWinHndl; {handle to next AuxWinRec}
				 awOwner:		WindowPtr;	{ptr to window}
				 awCTable:		CTabHandle; {color table for this window}
				 dialogCTable:	Handle; 	{handle to dialog manager structures}
				 awFlags:		LONGINT;	{reserved}
				 awResrv:		LONGINT;	{reserved}
				 awRefCon:		LONGINT;	{user constant}
				END;
	
	WCTabHandle = ^WCTabPtr;				{ handle to a window color table	}
	WCTabPtr	= ^WinCTab;
	WinCTab = RECORD
				wCSeed: 		LONGINT;	{ reserved }
				wCReserved: 	INTEGER;	{ reserved }
				ctSize: 		INTEGER;	{ usually 4 for windows}
				ctTable:		ARRAY [0..4] OF ColorSpec;
			END;


{Color Menu Manager}

	MCEntry = RECORD
				 mctID: 		INTEGER;	{menu ID.  ID = 0 is the menu bar}
				 mctItem:		INTEGER;	{menu Item. Item = 0 is a title}
				 mctRGB1:		RGBColor;	{usage depends on ID and Item}
				 mctRGB2:		RGBColor;	{usage depends on ID and Item}
				 mctRGB3:		RGBColor;	{usage depends on ID and Item}
				 mctRGB4:		RGBColor;	{usage depends on ID and Item}
				 mctReserved:	INTEGER;	{reserved for internal use}
				END;
	MCEntryPtr = ^MCEntry;
	MCTable = ARRAY [0..0] OF MCEntry;		{the entries themselves}
	MCTablePtr = ^MCTable;
	MCTableHandle = ^MCTablePtr;


	{General Utilities}

	FUNCTION BitAnd(long1, long2: LONGINT): LONGINT;
	INLINE $A858;

	FUNCTION BitOr(long1, long2: LONGINT): LONGINT;
	INLINE $A85B;

	FUNCTION BitXor(long1, long2: LONGINT): LONGINT;
	INLINE $A859;

	FUNCTION BitNot(long: LONGINT): LONGINT;
	INLINE $A85A;

	FUNCTION BitShift(long: LONGINT; count: INTEGER): LONGINT;
	INLINE $A85C;

	FUNCTION BitTst(bytePtr: Ptr; bitNum: LONGINT): BOOLEAN;
	INLINE $A85D;

	PROCEDURE BitSet(bytePtr: Ptr; bitNum: LONGINT);
	INLINE $A85E;

	PROCEDURE BitClr(bytePtr: Ptr; bitNum: LONGINT);
	INLINE $A85F;

	PROCEDURE LongMul(a, b: LONGINT; VAR dst: Int64Bit);
	INLINE $A867;

	FUNCTION FixMul(a, b: Fixed): Fixed;
	INLINE $A868;

	FUNCTION FixRatio(numer, denom: INTEGER): Fixed;
	INLINE $A869;

	FUNCTION HiWord(x: LONGINT): INTEGER;
	INLINE $A86A;

	FUNCTION LoWord(x: LONGINT): INTEGER;
	INLINE $A86B;

	FUNCTION FixRound(x: Fixed): INTEGER;
	INLINE $A86C;

	PROCEDURE PackBits(VAR srcPtr, dstPtr: Ptr; srcBytes: INTEGER);
	INLINE $A8CF;

	PROCEDURE UnPackBits(VAR srcPtr, dstPtr: Ptr; dstBytes: INTEGER);
	INLINE $A8D0;

	FUNCTION SlopeFromAngle(angle: INTEGER): Fixed;
	INLINE $A8BC;

	FUNCTION AngleFromSlope(slope: Fixed): INTEGER;
	INLINE $A8C4;

	FUNCTION DeltaPoint(ptA, ptB: Point): LONGINT;
	INLINE $A94F;

	FUNCTION NewString(theString: Str255): StringHandle;
	INLINE $A906;

	PROCEDURE SetString(theString: StringHandle; strNew: Str255);
	INLINE $A907;

	FUNCTION GetString(stringID: INTEGER): StringHandle;
	INLINE $A9BA;

	PROCEDURE GetIndString(VAR theString: Str255; strListID: INTEGER;
					 index: INTEGER);

	FUNCTION Munger(h: Handle; offset: LONGINT; ptr1: Ptr; len1: LONGINT;
					ptr2: Ptr; len2: LONGINT): LONGINT;
	INLINE $A9E0;

	FUNCTION GetIcon(iconID: INTEGER): Handle;
	INLINE $A9BB;

	PROCEDURE PlotIcon(theRect: Rect; theIcon: Handle);
	INLINE $A94B;

	FUNCTION GetCursor(cursorID: INTEGER): CursHandle;
	INLINE $A9B9;

	FUNCTION GetPattern(patID: INTEGER): PatHandle;
	INLINE $A9B8;

	FUNCTION GetPicture(picID: INTEGER): PicHandle;
	INLINE $A9BC;

	PROCEDURE GetIndPattern(VAR thePat: Pattern; patListID: INTEGER;
						index: INTEGER);

	PROCEDURE ShieldCursor(shieldRect: Rect; offsetPt: Point);
	INLINE $A855;

	PROCEDURE ScreenRes(VAR scrnHRes, scrnVRes: INTEGER);

	{for Font Manager}

	PROCEDURE InitFonts;
	INLINE $A8FE;

	PROCEDURE GetFontName(familyID: INTEGER; VAR theName: Str255);
	INLINE $A8FF;

	PROCEDURE GetFNum(theName: Str255; VAR familyID: INTEGER);
	INLINE $A900;

	PROCEDURE SetFontLock(lockFlag: BOOLEAN);
	INLINE $A903;

	FUNCTION FMSwapFont(inRec: FMInput): FMOutPtr;
	INLINE $A901;

	FUNCTION RealFont(famID: INTEGER; size: INTEGER): BOOLEAN;
	INLINE $A902;

	{new 128K ROM}

	PROCEDURE SetFScaleDisable(scaleDisable: BOOLEAN);
	INLINE $A834;

	PROCEDURE FontMetrics(VAR theMetrics: FMetricRec);
	INLINE $A835;

	{for Event Manager}

	FUNCTION EventAvail(mask: INTEGER; VAR theEvent: EventRecord): BOOLEAN;
	INLINE $A971;

	FUNCTION GetNextEvent(mask: INTEGER; VAR theEvent: EventRecord): BOOLEAN;
	INLINE $A970;

	FUNCTION WaitNextEvent(mask: INTEGER; VAR event: EventRecord;
					 sleep: LONGINT; mouseRgn: RgnHandle): BOOLEAN;
	INLINE $A860;

	FUNCTION StillDown: BOOLEAN;
	INLINE $A973;

	FUNCTION WaitMouseUp: BOOLEAN;
	INLINE $A977;

	PROCEDURE GetMouse(VAR pt: Point);
	INLINE $A972;

	FUNCTION TickCount: LONGINT;
	INLINE $A975;

	FUNCTION Button: BOOLEAN;
	INLINE $A974;

	PROCEDURE GetKeys(VAR k: KeyMap);
	INLINE $A976;

	FUNCTION GetDblTime: LONGINT;
	INLINE $2EB8, $02F0;

	FUNCTION GetCaretTime: LONGINT;
	INLINE $2EB8, $02F4;

	{for Window Manager}

	PROCEDURE ClipAbove(window: WindowPeek);
	INLINE $A90B;

	PROCEDURE PaintOne(window: WindowPeek; clobbered: RgnHandle);
	INLINE $A90C;

	PROCEDURE PaintBehind(startWindow: WindowPeek; clobbered: RgnHandle);
	INLINE $A90D;

	PROCEDURE SaveOld(window: WindowPeek);
	INLINE $A90E;

	PROCEDURE DrawNew(window: WindowPeek; fUpdate: BOOLEAN);
	INLINE $A90F;

	PROCEDURE CalcVis(window: WindowPeek);
	INLINE $A909;

	PROCEDURE CalcVisBehind(startWindow: WindowPeek; clobbered: RgnHandle);
	INLINE $A90A;

	PROCEDURE ShowHide(window: WindowPtr; showFlag: BOOLEAN);
	INLINE $A908;

	FUNCTION CheckUpdate(VAR theEvent: EventRecord): BOOLEAN;
	INLINE $A911;

	PROCEDURE GetWMgrPort(VAR wPort: GrafPtr);
	INLINE $A910;

	PROCEDURE InitWindows;
	INLINE $A912;

	FUNCTION NewWindow(wStorage: Ptr; boundsRect: Rect; title: Str255;
					 visible: BOOLEAN; theProc: INTEGER; behind: WindowPtr;
					 goAwayFlag: BOOLEAN; refCon: LONGINT): WindowPtr;
	INLINE $A913;

	PROCEDURE DisposeWindow(theWindow: WindowPtr);
	INLINE $A914;

	PROCEDURE CloseWindow(theWindow: WindowPtr);
	INLINE $A92D;

	PROCEDURE MoveWindow(theWindow: WindowPtr; h, v: INTEGER;
					 BringToFront: BOOLEAN);
	INLINE $A91B;

	PROCEDURE SizeWindow(theWindow: WindowPtr; width, height: INTEGER;
					 fUpdate: BOOLEAN);
	INLINE $A91D;

	FUNCTION GrowWindow(theWindow: WindowPtr; startPt: Point;
					bBox: Rect): LONGINT;
	INLINE $A92B;

	PROCEDURE DragWindow(theWindow: WindowPtr; startPt: Point; boundsRect: Rect);
	INLINE $A925;

	PROCEDURE ShowWindow(theWindow: WindowPtr);
	INLINE $A915;

	PROCEDURE HideWindow(theWindow: WindowPtr);
	INLINE $A916;

	PROCEDURE SetWTitle(theWindow: WindowPtr; title: Str255);
	INLINE $A91A;

	PROCEDURE GetWTitle(theWindow: WindowPtr; VAR title: Str255);
	INLINE $A919;

	PROCEDURE HiliteWindow(theWindow: WindowPtr; fHiLite: BOOLEAN);
	INLINE $A91C;

	PROCEDURE BeginUpdate(theWindow: WindowPtr);
	INLINE $A922;

	PROCEDURE EndUpdate(theWindow: WindowPtr);
	INLINE $A923;

	PROCEDURE SetWRefCon(theWindow: WindowPtr; data: LONGINT);
	INLINE $A918;

	FUNCTION GetWRefCon(theWindow: WindowPtr): LONGINT;
	INLINE $A917;

	PROCEDURE SetWindowPic(theWindow: WindowPtr; thePic: PicHandle);
	INLINE $A92E;

	FUNCTION GetWindowPic(theWindow: WindowPtr): PicHandle;
	INLINE $A92F;

	PROCEDURE BringToFront(theWindow: WindowPtr);
	INLINE $A920;

	PROCEDURE SendBehind(theWindow, behindWindow: WindowPtr);
	INLINE $A921;

	FUNCTION FrontWindow: WindowPtr;
	INLINE $A924;

	PROCEDURE SelectWindow(theWindow: WindowPtr);
	INLINE $A91F;

	FUNCTION TrackGoAway(theWindow: WindowPtr; thePt: Point): BOOLEAN;
	INLINE $A91E;

	PROCEDURE DrawGrowIcon(theWindow: WindowPtr);
	INLINE $A904;

	PROCEDURE ValidRect(goodRect: Rect);
	INLINE $A92A;

	PROCEDURE ValidRgn(goodRgn: RgnHandle);
	INLINE $A929;

	PROCEDURE InvalRect(badRect: Rect);
	INLINE $A928;

	PROCEDURE InvalRgn(badRgn: RgnHandle);
	INLINE $A927;

	FUNCTION FindWindow(thePoint: Point; VAR theWindow: WindowPtr): INTEGER;
	INLINE $A92C;

	FUNCTION GetNewWindow(windowID: INTEGER; wStorage: Ptr;
					behind: WindowPtr): WindowPtr;
	INLINE $A9BD;

	FUNCTION PinRect(theRect: Rect; thePt: Point): LONGINT;
	INLINE $A94E;

	FUNCTION DragGrayRgn(theRgn: RgnHandle; startPt: Point; boundsRect,
					 slopRect: Rect; axis: INTEGER;
					 actionProc: ProcPtr): LONGINT;
	INLINE $A905;

	{new 128K ROM}

	FUNCTION TrackBox(theWindow: WindowPtr; thePt: Point;
					partCode: INTEGER): BOOLEAN;
	INLINE $A83B;

	PROCEDURE ZoomWindow(theWindow: WindowPtr; partCode: INTEGER; front: BOOLEAN);
	INLINE $A83A;

	{For TextEdit}

	PROCEDURE TEActivate(h: TEHandle);
	INLINE $A9D8;

	PROCEDURE TECalText(h: TEHandle);
	INLINE $A9D0;

	PROCEDURE TEClick(pt: Point; extend: BOOLEAN; h: TEHandle);
	INLINE $A9D4;

	PROCEDURE TECopy(h: TEHandle);
	INLINE $A9D5;

	PROCEDURE TECut(h: TEHandle);
	INLINE $A9D6;

	PROCEDURE TEDeActivate(h: TEHandle);
	INLINE $A9D9;

	PROCEDURE TEDelete(h: TEHandle);
	INLINE $A9D7;

	PROCEDURE TEDispose(h: TEHandle);
	INLINE $A9CD;

	PROCEDURE TEIdle(h: TEHandle);
	INLINE $A9DA;

	PROCEDURE TEInit;
	INLINE $A9CC;

	PROCEDURE TEKey(key: CHAR; h: TEHandle);
	INLINE $A9DC;

	FUNCTION TENew(dest, view: Rect): TEHandle;
	INLINE $A9D2;

	PROCEDURE TEPaste(h: TEHandle);
	INLINE $A9DB;

	PROCEDURE TEScroll(dh, dv: INTEGER; h: TEHandle);
	INLINE $A9DD;

	PROCEDURE TESetSelect(selStart, selEnd: LONGINT; h: TEHandle);
	INLINE $A9D1;

	PROCEDURE TESetText(inText: Ptr; textLength: LONGINT; h: TEHandle);
	INLINE $A9CF;

	PROCEDURE TEInsert(inText: Ptr; textLength: LONGINT; h: TEHandle);
	INLINE $A9DE;

	PROCEDURE TEUpdate(rUpdate: Rect; h: TEHandle);
	INLINE $A9D3;

	PROCEDURE TESetJust(just: INTEGER; h: TEHandle);
	INLINE $A9DF;

	FUNCTION TEGetText(h: TEHandle): CharsHandle;
	INLINE $A9CB;

	FUNCTION TEScrapHandle: Handle;
	INLINE $2EB8, $0AB4;

	FUNCTION TEGetScrapLen: LONGINT;

	PROCEDURE TESetScrapLen(length: LONGINT);

	FUNCTION TEFromScrap: OSErr;

	FUNCTION TEToScrap: OSErr;

	PROCEDURE SetWordBreak(wBrkProc: ProcPtr; hTE: TEHandle);

	PROCEDURE SetClikLoop(clikProc: ProcPtr; hTE: TEHandle);

	{new 128K ROM}

	PROCEDURE TESelView(hTE: TEHandle);
	INLINE $A811;

	PROCEDURE TEPinScroll(dh, dv: INTEGER; hTE: TEHandle);
	INLINE $A812;

	PROCEDURE TEAutoView(auto: BOOLEAN; hTE: TEHandle);
	INLINE $A813;

	{Box drawing utility}

	PROCEDURE TextBox(inText: Ptr; textLength: LONGINT; r: Rect; Style: INTEGER);
	INLINE $A9CE;

	{for Resource Manager}

	FUNCTION InitResources: INTEGER;
	INLINE $A995;

	PROCEDURE RsrcZoneInit;
	INLINE $A996;

	PROCEDURE CreateResFile(fileName: Str255);
	INLINE $A9B1;

	FUNCTION OpenResFile(fileName: Str255): INTEGER;
	INLINE $A997;

	PROCEDURE UseResFile(refNum: INTEGER);
	INLINE $A998;

	FUNCTION GetResFileAttrs(refNum: INTEGER): INTEGER;
	INLINE $A9F6;

	PROCEDURE SetResFileAttrs(refNum: INTEGER; attrs: INTEGER);
	INLINE $A9F7;

	PROCEDURE UpdateResFile(refNum: INTEGER);
	INLINE $A999;

	PROCEDURE CloseResFile(refNum: INTEGER);
	INLINE $A99A;

	PROCEDURE SetResPurge(install: BOOLEAN);
	INLINE $A993;

	PROCEDURE SetResLoad(AutoLoad: BOOLEAN);
	INLINE $A99B;

	FUNCTION CountResources(theType: ResType): INTEGER;
	INLINE $A99C;

	FUNCTION GetIndResource(theType: ResType; index: INTEGER): Handle;
	INLINE $A99D;

	FUNCTION CountTypes: INTEGER;
	INLINE $A99E;

	PROCEDURE GetIndType(VAR theType: ResType; index: INTEGER);
	INLINE $A99F;

	FUNCTION UniqueID(theType: ResType): INTEGER;
	INLINE $A9C1;

	FUNCTION GetResource(theType: ResType; ID: INTEGER): Handle;
	INLINE $A9A0;

	FUNCTION GetNamedResource(theType: ResType; name: Str255): Handle;
	INLINE $A9A1;

	PROCEDURE LoadResource(theResource: Handle);
	INLINE $A9A2;

	PROCEDURE ReleaseResource(theResource: Handle);
	INLINE $A9A3;

	PROCEDURE DetachResource(theResource: Handle);
	INLINE $A992;

	PROCEDURE ChangedResource(theResource: Handle);
	INLINE $A9AA;

	PROCEDURE WriteResource(theResource: Handle);
	INLINE $A9B0;

	FUNCTION HomeResFile(theResource: Handle): INTEGER;
	INLINE $A9A4;

	FUNCTION CurResFile: INTEGER;
	INLINE $A994;

	FUNCTION GetResAttrs(theResource: Handle): INTEGER;
	INLINE $A9A6;

	PROCEDURE SetResAttrs(theResource: Handle; attrs: INTEGER);
	INLINE $A9A7;

	PROCEDURE GetResInfo(theResource: Handle; VAR theID: INTEGER;
					 VAR theType: ResType; VAR name: Str255);
	INLINE $A9A8;

	PROCEDURE SetResInfo(theResource: Handle; theID: INTEGER; name: Str255);
	INLINE $A9A9;

	PROCEDURE AddResource(theResource: Handle; theType: ResType; theID: INTEGER;
					name: Str255);
	INLINE $A9AB;

	PROCEDURE RmveResource(theResource: Handle);
	INLINE $A9AD;

	FUNCTION SizeResource(theResource: Handle): LONGINT;
	INLINE $A9A5;

	FUNCTION ResError: INTEGER;
	INLINE $A9AF;

	{new 128K ROM}

	FUNCTION Get1IndResource(theType: ResType; index: INTEGER): Handle;
	INLINE $A80E;

	FUNCTION Count1Types: INTEGER;
	INLINE $A81C;

	FUNCTION Get1Resource(theType: ResType; theID: INTEGER): Handle;
	INLINE $A81F;

	FUNCTION Get1NamedResource(theType: ResType; name: Str255): Handle;
	INLINE $A820;

	PROCEDURE Get1IndType(VAR theType: ResType; index: INTEGER);
	INLINE $A80F;

	FUNCTION Unique1ID(theType: ResType): INTEGER;
	INLINE $A810;

	FUNCTION Count1Resources(theType: ResType): INTEGER;
	INLINE $A80D;

	FUNCTION MaxSizeRsrc(theResource: Handle): LONGINT;
	INLINE $A821;

	FUNCTION RsrcMapEntry(theResource: Handle): LONGINT;
	INLINE $A9C5;

	FUNCTION OpenRFPerm(fileName: Str255; vRefNum: INTEGER;
					permission: SignedByte): INTEGER;
	INLINE $A9C4;

	{for Control Manager}

	FUNCTION NewControl(curWindow: WindowPtr; boundsRect: Rect; title: Str255;
					visible: BOOLEAN; value: INTEGER; min: INTEGER;
					max: INTEGER; contrlProc: INTEGER;
					refCon: LONGINT): ControlHandle;
	INLINE $A954;

	PROCEDURE DisposeControl(theControl: ControlHandle);
	INLINE $A955;

	PROCEDURE KillControls(theWindow: WindowPtr);
	INLINE $A956;

	PROCEDURE MoveControl(theControl: ControlHandle; h, v: INTEGER);
	INLINE $A959;

	PROCEDURE SizeControl(theControl: ControlHandle; w, h: INTEGER);
	INLINE $A95C;

	PROCEDURE DragControl(theControl: ControlHandle; startPt: Point; bounds: Rect;
					slopRect: Rect; axis: INTEGER);
	INLINE $A967;

	PROCEDURE ShowControl(theControl: ControlHandle);
	INLINE $A957;

	PROCEDURE HideControl(theControl: ControlHandle);
	INLINE $A958;

	PROCEDURE SetCTitle(theControl: ControlHandle; title: Str255);
	INLINE $A95F;

	PROCEDURE GetCTitle(theControl: ControlHandle; VAR title: Str255);
	INLINE $A95E;

	PROCEDURE HiliteControl(theControl: ControlHandle; hiliteState: INTEGER);
	INLINE $A95D;

	PROCEDURE SetCRefCon(theControl: ControlHandle; data: LONGINT);
	INLINE $A95B;

	FUNCTION GetCRefCon(theControl: ControlHandle): LONGINT;
	INLINE $A95A;

	PROCEDURE SetCtlValue(theControl: ControlHandle; theValue: INTEGER);
	INLINE $A963;

	FUNCTION GetCtlValue(theControl: ControlHandle): INTEGER;
	INLINE $A960;

	FUNCTION GetCtlMin(theControl: ControlHandle): INTEGER;
	INLINE $A961;

	FUNCTION GetCtlMax(theControl: ControlHandle): INTEGER;
	INLINE $A962;

	PROCEDURE SetCtlMin(theControl: ControlHandle; theValue: INTEGER);
	INLINE $A964;

	PROCEDURE SetCtlMax(theControl: ControlHandle; theValue: INTEGER);
	INLINE $A965;

	FUNCTION GetCtlAction(theControl: ControlHandle): ProcPtr;
	INLINE $A96A;

	PROCEDURE SetCtlAction(theControl: ControlHandle; newProc: ProcPtr);
	INLINE $A96B;

	FUNCTION TestControl(theControl: ControlHandle; thePt: Point): INTEGER;
	INLINE $A966;

	FUNCTION TrackControl(theControl: ControlHandle; thePt: Point;
					actionProc: ProcPtr): INTEGER;
	INLINE $A968;

	FUNCTION FindControl(thePoint: Point; theWindow: WindowPtr;
					 VAR theControl: ControlHandle): INTEGER;
	INLINE $A96C;

	PROCEDURE DrawControls(theWindow: WindowPtr);
	INLINE $A969;

	FUNCTION GetNewControl(controlID: INTEGER; owner: WindowPtr): ControlHandle;
	INLINE $A9BE;

	{new 128K ROM}

	PROCEDURE UpdtControl(theWindow: WindowPtr; updateRgn: RgnHandle);
	INLINE $A953;

	PROCEDURE Draw1Control(theControl: ControlHandle);
	INLINE $A96D;

	{for Dialog Manager}

	PROCEDURE InitDialogs(resumeProc: ProcPtr);
	INLINE $A97B;

	FUNCTION GetNewDialog(dialogID: INTEGER; wStorage: Ptr;
					behind: WindowPtr): DialogPtr;
	INLINE $A97C;

	FUNCTION NewDialog(wStorage: Ptr; boundsRect: Rect; title: Str255;
					 visible: BOOLEAN; theProc: INTEGER; behind: WindowPtr;
					 goAwayFlag: BOOLEAN; refCon: LONGINT;
					 itmLstHndl: Handle): DialogPtr;
	INLINE $A97D;

	FUNCTION IsDialogEvent(event: EventRecord): BOOLEAN;
	INLINE $A97F;

	FUNCTION DialogSelect(event: EventRecord; VAR theDialog: DialogPtr;
					VAR itemHit: INTEGER): BOOLEAN;
	INLINE $A980;

	PROCEDURE ModalDialog(filterProc: ProcPtr; VAR itemHit: INTEGER);
	INLINE $A991;

	PROCEDURE DrawDialog(theDialog: DialogPtr);
	INLINE $A981;

	PROCEDURE CloseDialog(theDialog: DialogPtr);
	INLINE $A982;

	PROCEDURE DisposDialog(theDialog: DialogPtr);
	INLINE $A983;

	FUNCTION Alert(alertID: INTEGER; filterProc: ProcPtr): INTEGER;
	INLINE $A985;

	FUNCTION StopAlert(alertID: INTEGER; filterProc: ProcPtr): INTEGER;
	INLINE $A986;

	FUNCTION NoteAlert(alertID: INTEGER; filterProc: ProcPtr): INTEGER;
	INLINE $A987;

	FUNCTION CautionAlert(alertID: INTEGER; filterProc: ProcPtr): INTEGER;
	INLINE $A988;

	PROCEDURE CouldAlert(alertID: INTEGER);
	INLINE $A989;

	PROCEDURE FreeAlert(alertID: INTEGER);
	INLINE $A98A;

	PROCEDURE CouldDialog(DlgID: INTEGER);
	INLINE $A979;

	PROCEDURE FreeDialog(DlgID: INTEGER);
	INLINE $A97A;

	PROCEDURE ParamText(cite0, cite1, cite2, cite3: Str255);
	INLINE $A98B;

	PROCEDURE ErrorSound(sound: ProcPtr);
	INLINE $A98C;

	PROCEDURE GetDItem(theDialog: DialogPtr; itemNo: INTEGER; VAR kind: INTEGER;
					 VAR item: Handle; VAR box: Rect);
	INLINE $A98D;

	PROCEDURE SetDItem(dialog: DialogPtr; itemNo: INTEGER; kind: INTEGER;
					 item: Handle; box: Rect);
	INLINE $A98E;

	PROCEDURE SetIText(item: Handle; text: Str255);
	INLINE $A98F;

	PROCEDURE GetIText(item: Handle; VAR text: Str255);
	INLINE $A990;

	PROCEDURE SelIText(theDialog: DialogPtr; itemNo: INTEGER; startSel,
					 endSel: INTEGER);
	INLINE $A97E;

	{routines designed only for use in Pascal}

	FUNCTION GetAlrtStage: INTEGER;
	INLINE $3EB8, $0A9A;

	PROCEDURE ResetAlrtStage;
	INLINE $4278, $0A9A;

	PROCEDURE DlgCut(theDialog: DialogPtr);

	PROCEDURE DlgPaste(theDialog: DialogPtr);

	PROCEDURE DlgCopy(theDialog: DialogPtr);

	PROCEDURE DlgDelete(theDialog: DialogPtr);

	PROCEDURE SetDAFont(fontNum: INTEGER);
	INLINE $31DF, $0AFA;

	{new 128K ROM}

	PROCEDURE HideDItem(theDialog: DialogPtr; itemNo: INTEGER);
	INLINE $A827;

	PROCEDURE ShowDItem(theDialog: DialogPtr; itemNo: INTEGER);
	INLINE $A828;

	PROCEDURE UpdtDialog(theDialog: DialogPtr; updateRgn: RgnHandle);
	INLINE $A978;

	FUNCTION FindDItem(theDialog: DialogPtr; thePt: Point): INTEGER;
	INLINE $A984;

	{for Desk Manager}

	FUNCTION SystemEvent(myEvent: EventRecord): BOOLEAN;
	INLINE $A9B2;

	PROCEDURE SystemClick(theEvent: EventRecord; theWindow: WindowPtr);
	INLINE $A9B3;

	PROCEDURE SystemTask;
	INLINE $A9B4;

	PROCEDURE SystemMenu(menuResult: LONGINT);
	INLINE $A9B5;

	FUNCTION SystemEdit(editCode: INTEGER): BOOLEAN;
	INLINE $A9C2;

	FUNCTION OpenDeskAcc(theAcc: STR255): INTEGER;
	INLINE $A9B6;

	PROCEDURE CloseDeskAcc(refNum: INTEGER);
	INLINE $A9B7;

	{for Menu Manager}

	PROCEDURE InitMenus;
	INLINE $A930;

	FUNCTION NewMenu(menuId: INTEGER; menuTitle: Str255): MenuHandle;
	INLINE $A931;

	FUNCTION GetMenu(rsrcID: INTEGER): MenuHandle;
	INLINE $A9BF;

	PROCEDURE DisposeMenu(menu: MenuHandle);
	INLINE $A932;

	PROCEDURE AppendMenu(menu: MenuHandle; data: Str255);
	INLINE $A933;

	PROCEDURE InsertMenu(menu: MenuHandle; beforeId: INTEGER);
	INLINE $A935;

	PROCEDURE DeleteMenu(menuId: INTEGER);
	INLINE $A936;

	PROCEDURE DrawMenuBar;
	INLINE $A937;

	PROCEDURE ClearMenuBar;
	INLINE $A934;

	FUNCTION GetMenuBar: Handle;
	INLINE $A93B;

	FUNCTION GetNewMBar(menuBarID: INTEGER): Handle;
	INLINE $A9C0;

	PROCEDURE SetMenuBar(menuList: Handle);
	INLINE $A93C;

	FUNCTION MenuSelect(startPt: Point): LONGINT;
	INLINE $A93D;

	FUNCTION MenuKey(ch: CHAR): LONGINT;
	INLINE $A93E;

	PROCEDURE HiliteMenu(menuId: INTEGER);
	INLINE $A938;

	PROCEDURE SetItem(menu: MenuHandle; item: INTEGER; itemString: Str255);
	INLINE $A947;

	PROCEDURE GetItem(menu: MenuHandle; item: INTEGER; VAR itemString: Str255);
	INLINE $A946;

	PROCEDURE EnableItem(menu: MenuHandle; item: INTEGER);
	INLINE $A939;

	PROCEDURE DisableItem(menu: MenuHandle; item: INTEGER);
	INLINE $A93A;

	PROCEDURE CheckItem(menu: MenuHandle; item: INTEGER; checked: BOOLEAN);
	INLINE $A945;

	PROCEDURE SetItemIcon(menu: MenuHandle; item: INTEGER; iconNum: Byte);
	INLINE $A940;

	PROCEDURE GetItemIcon(menu: MenuHandle; item: INTEGER; VAR iconNum: Byte);
	INLINE $A93F;

	PROCEDURE SetItemStyle(menu: MenuHandle; item: INTEGER; styleVal: Style);
	INLINE $A942;

	PROCEDURE GetItemStyle(menu: MenuHandle; item: INTEGER; VAR styleVal: Style);

	PROCEDURE SetItemMark(menu: MenuHandle; item: INTEGER; markChar: CHAR);
	INLINE $A944;

	PROCEDURE GetItemMark(menu: MenuHandle; item: INTEGER; VAR markChar: CHAR);
	INLINE $A943;

	PROCEDURE SetMenuFlash(flashCount: INTEGER);
	INLINE $A94A;

	PROCEDURE FlashMenuBar(menuId: INTEGER);
	INLINE $A94C;

	FUNCTION GetMHandle(menuId: INTEGER): MenuHandle;
	INLINE $A949;

	FUNCTION CountMItems(menu: MenuHandle): INTEGER;
	INLINE $A950;

	PROCEDURE AddResMenu(menu: MenuHandle; theType: ResType);
	INLINE $A94D;

	PROCEDURE InsertResMenu(menu: MenuHandle; theType: ResType;
						afterItem: INTEGER);
	INLINE $A951;

	PROCEDURE CalcMenuSize(menu: MenuHandle);
	INLINE $A948;

	{new 128K ROM}

	PROCEDURE InsMenuItem(theMenu: MenuHandle; itemString: Str255;
					afterItem: INTEGER);
	INLINE $A826;

	PROCEDURE DelMenuItem(theMenu: MenuHandle; item: INTEGER);
	INLINE $A952;

	{for Scrap Manager}

	FUNCTION GetScrap(hDest: Handle; what: ResType; VAR offset: LONGINT): LONGINT;
	INLINE $A9FD;

	FUNCTION InfoScrap: pScrapStuff;
	INLINE $A9F9;

	FUNCTION LoadScrap: LONGINT;
	INLINE $A9FB;

	FUNCTION PutScrap(length: LONGINT; what: ResType; source: Ptr): LONGINT;
	INLINE $A9FE;

	FUNCTION UnloadScrap: LONGINT;
	INLINE $A9FA;

	FUNCTION ZeroScrap: LONGINT;
	INLINE $A9FC;

	{package manager}

	PROCEDURE InitAllPacks;
	INLINE $A9E6;

	PROCEDURE InitPack(packID: INTEGER);
	INLINE $A9E5;

{******** NEW TOOL CALLS HERE *********}

{Text Edit}


FUNCTION  TEStylNew 	(destRect,viewRect: Rect): TEHandle;
	INLINE $A83E;
PROCEDURE SetStylHandle (theHandle: TEStyleHandle; hTE: TEHandle);
FUNCTION  GetStylHandle (hTE: TEHandle): TEStyleHandle;
FUNCTION  TEGetOffset	(pt: Point; hTE: TEHandle): INTEGER;
	INLINE $A83C;
PROCEDURE TEGetStyle	(offset: INTEGER; VAR theStyle: TextStyle;
					 VAR lineHeight,fontAscent: INTEGER; hTE: TEHandle);
PROCEDURE TEStylPaste	(hTE: TEHandle);
PROCEDURE TESetStyle	(mode: INTEGER; newStyle: TextStyle; redraw: BOOLEAN;
					 hTE: TEHandle);
PROCEDURE TEReplaceStyle (mode: INTEGER; oldStyle,newStyle: TextStyle;
					redraw: BOOLEAN; hTE: TEHandle);
FUNCTION  GetStylScrap	(hTE: TEHandle): StScrpHandle;
PROCEDURE TEStylInsert	(text: Ptr; length: LONGINT; hST: StScrpHandle;
					 hTE: TEHandle);
FUNCTION  TEGetPoint	(offset: INTEGER; hTE: TEHandle): Point;
FUNCTION  TEGetHeight	(endLine, startLine: LONGINT; hTE: TEHandle): LONGINT;

{Color Control Manager}

PROCEDURE SetCtlColor(theControl:ControlHandle;newColorTable: CCTabHandle);
	INLINE $AA43;
FUNCTION GetAuxCtl (theControl:ControlHandle; acHndl:AuxCtlHndl) : BOOLEAN;
	INLINE $AA44;
FUNCTION GetCVariant (theControl:ControlHandle) : INTEGER;
	INLINE $A809;

{Color Window Manager}

PROCEDURE CGetWMgrPort(VAR wMgrCPort: CGrafPtr);
	INLINE $AA48;
PROCEDURE SetWinColor(theWindow: WindowPtr; newColorTable: WCTabHandle);
	INLINE $AA41;
FUNCTION GetAuxWin (theWindow: WindowPtr; VAR awHndl: AuxWinHndl) : BOOLEAN;
	INLINE $AA42;
PROCEDURE SetDeskCPat(deskPixPat: PixPatHandle);
	INLINE $AA47;
FUNCTION NewCWindow(wStorage: Ptr; boundsRect: Rect; title: Str255;
					visible: BOOLEAN; procID: INTEGER; behind: WindowPtr;
					goAwayFlag: BOOLEAN; refCon: LONGINT): WindowPtr;
	INLINE $AA45;
FUNCTION GetNewCWindow(windowID: INTEGER; wStorage: Ptr;
					 behind: WindowPtr): WindowPtr;
	INLINE $AA46;
FUNCTION GetWVariant (theWindow: WindowPtr) : INTEGER;
	INLINE $A80A;
FUNCTION GetGrayRgn: RgnHandle;
	
{Menu Manager}

PROCEDURE InitProcMenu(resID: INTEGER);
	INLINE $A808;
PROCEDURE GetItemCmd (menu: MenuHandle; item: INTEGER; VAR cmdChar: CHAR);
	INLINE	$A84E;
PROCEDURE SetItemCmd (menu: MenuHandle; item: INTEGER; cmdChar: CHAR);
	INLINE	$A84F;
FUNCTION PopUpMenuSelect (menu: MenuHandle; top, left, popUpItem: INTEGER): LONGINT;
	INLINE	$A80B;
FUNCTION MenuChoice : LONGINT;
	INLINE	$AA66;

{Color Menu Manager}

PROCEDURE DelMCEntries (menuID, menuItem: INTEGER);
	INLINE	$AA60;
FUNCTION GetMCInfo : MCTableHandle;
	INLINE	$AA61;
PROCEDURE SetMCInfo (menuCTbl: MCTableHandle);
	INLINE	$AA62;
PROCEDURE DispMCInfo (menuCTbl: MCTableHandle);
	INLINE	$AA63;
FUNCTION GetMCEntry(menuID, menuItem: INTEGER): MCEntryPtr;
	INLINE	$AA64;
PROCEDURE SetMCEntries (numEntries: INTEGER; menuCEntries: MCTablePtr);
	INLINE	$AA65;

{Dialog Manager}

FUNCTION NewCDialog(dStorage: Ptr; boundsRect: Rect; title: STR255;
				visible: BOOLEAN; procID: INTEGER; behind: WindowPtr;
				goAwayFlag: BOOLEAN; refCon: LONGINT; items: Handle): DialogPtr;
	INLINE $AA4B;

{Font Manager}

PROCEDURE SetFractEnable(fractEnable: Boolean);

{Resource Manager}

FUNCTION RGetResource(theType: ResType; theID: INTEGER): Handle;
	INLINE $A80C;

END.

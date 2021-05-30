{
  File: PackIntf.p

 Copyright Apple Computer, Inc. 1984-1987
 All Rights Reserved
}

UNIT PackIntf;

  INTERFACE

	USES {$U MemTypes.p } MemTypes,
	{$U QuickDraw.p } QuickDraw,
	{$U OsIntf.p	} OsIntf,
	{$U ToolIntf.p  } ToolIntf;

	{ Package Manager ----------------------------------------------------}

	{ These routines are currently in ToolIntf.p }

	{ Disk Initialization Package ----------------------------------------}

	PROCEDURE DILoad;

	PROCEDURE DIUnload;

	FUNCTION DIBadMount(where: Point; evtMessage: LONGINT): INTEGER;

	FUNCTION DIFormat(drvNum: INTEGER): OSErr;

	FUNCTION DIVerify(drvNum: INTEGER): OSErr;

	FUNCTION DIZero(drvNum: INTEGER; volName: Str255): OSErr;

	{ Standard File Package ----------------------------------------------}

	CONST

	putDlgID = - 3999; {SFPutFile dialog template ID}

	putSave = 1; {save button}
	putCancel = 2; {cancel button}
	putEject = 5; {eject button}
	putDrive = 6; {drive button}
	putName = 7; {editTExt item for file name}

	getDlgID = - 4000; {SFGetFile dialog template ID}

	getOpen = 1; {open button}
	getCancel = 3; {cancel button}
	getEject = 5; {eject button}
	getDrive = 6; {drive button}
	getNmList = 7; {userItem for file name list}
	getScroll = 8; {userItem for scroll bar}

	TYPE

	SFReply = RECORD
				good: BOOLEAN; {ignore command if FALSE}
				copy: BOOLEAN; {not used}
				fType: OsType; {file type or not used}
				vRefNum: INTEGER; {volume reference number}
				version: INTEGER; {file's version number}
				fName: String[63]; {file name}
				END; {SFReply}
	SFTypeList = ARRAY [0..3] OF OsType;

	PROCEDURE SFPutFile(where: Point; prompt: Str255; origName: Str255;
						dlgHook: ProcPtr; VAR reply: SFReply);

	PROCEDURE SFPPutFile(where: Point; prompt: Str255; origName: Str255;
						 dlgHook: ProcPtr; VAR reply: SFReply; dlgID: INTEGER;
						 filterProc: ProcPtr);

	PROCEDURE SFGetFile(where: Point; prompt: Str255; fileFilter: ProcPtr;
						numTypes: INTEGER; typeList: SFTypeList; dlgHook: ProcPtr;
						VAR reply: SFReply);

	PROCEDURE SFPGetFile(where: Point; prompt: Str255; fileFilter: ProcPtr;
						 numTypes: INTEGER; typeList: SFTypeList;
						 dlgHook: ProcPtr; VAR reply: SFReply; dlgID: INTEGER;
						 filterProc: ProcPtr);

	{ International Utilities Package ------------------------------------}

	CONST

	{constants for manipulation of international resources}
	{masks used for setting and testing currency format flags}
	currSymLead = 16; {set if currency symbol leads, reset if trails}
	currNegSym = 32; {set if minus sign for negative num, reset if parentheses}
	currTrailingZ = 64; {set if trailing zero}
	currLeadingZ = 128; {set if leading zero}

	{constants specifying absolute value of short date form}
	MDY = 0; {month,day,year}
	DMY = 1; {day,month,year}
	YMD = 2; {year,month,day}

	{masks used for date element format flags}
	dayLdingZ = 32; {set if leading zero for day}
	mntLdingZ = 64; {set if leading 0 for month}
	century = 128; {set if century, reset if no century}

	{masks used for time element format flags}
	secLeadingZ = 32; {set if leading zero for seconds}
	minLeadingZ = 64; {set if leading zero for minutes}
	hrLeadingZ = 128; {set if leading zero for hours}

	{country codes for version numbers}
	verUS = 0;
	verFrance = 1;
	verBritain = 2;
	verGermany = 3;
	verItaly = 4;
	verNetherlands = 5;
	verBelgiumLux = 6;
	verSweden = 7;
	verSpain = 8;
	verDenmark = 9;
	verPortugal = 10;
	verFrCanada = 11;
	verNorway = 12;
	verIsrael = 13;
	verJapan = 14;
	verAustralia = 15;
	verArabia = 16;
	verFinland = 17;
	verFrSwiss = 18;
	verGrSwiss = 19;
	verGreece = 20;
	verIceland = 21;
	verMalta = 22;
	verCyprus = 23;
	verTurkey = 24;
	verYugoslavia = 25;

	TYPE

	intl0Hndl = ^intl0Ptr;
	intl0Ptr = ^intl0Rec;
	intl0Rec = PACKED RECORD
				 decimalPt: char; {ASCII character for decimal point}
				 thousSep: char; {ASCII character for thousand separator}
				 listSep: char; {ASCII character for list separator}
				 currSym1: char; {ASCII for currency symbol (3 bytes long)}
				 currSym2: char;
				 currSym3: char;
				 currFmt: Byte; {currency format flags}
				 dateOrder: Byte; {short date form - DMY,YMD, or MDY}
				 shrtDateFmt: Byte; {date elements format flag}
				 dateSep: char; {ASCII for date separator}
				 timeCycle: Byte; {indicates 12 or 24 hr cycle}
				 timeFmt: Byte; {time elements format flags}
				 mornStr: PACKED ARRAY [1..4] OF char; {ASCII for trailing string
				 										from 0:00 to 11:59}
				 eveStr: PACKED ARRAY [1..4] OF char; {ASCII for trailing string
														from 12:00 to 23:59}
				 timeSep: char; {ASCII for the time separator}
				 time1Suff: char; {suffix string used in 24 hr mode}
				 time2Suff: char; {8 characters long}
				 time3Suff: char;
				 time4Suff: char;
				 time5Suff: char;
				 time6Suff: char;
				 time7Suff: char;
				 time8Suff: char;
				 metricSys: Byte; {indicates metric or English system}
				 intl0Vers: INTEGER; {version: high byte = country, low byte =
										vers}
				 END; {intl0Rec}

	intl1Hndl = ^intl1Ptr;
	intl1Ptr = ^intl1REc;
	intl1REc = PACKED RECORD
				 days: ARRAY [1..7] OF String[15]; {length and word for Sunday
													through Monday}
				 months: ARRAY [1..12] OF String[15]; {length and word for
													January to December}
				 suppressDay: Byte; {0 for day of week, 255 for no day of week}
				 lngDateFmt: Byte; {expanded date format 0 or 255}
				 dayLeading0: Byte; {255 for leading 0, 0 for no leading 0}
				 abbrLen: Byte; {length of abbreviated names in long form}
				 st0: PACKED ARRAY [1..4] OF char; {the string st0}
				 st1: PACKED ARRAY [1..4] OF char; {the string st1}
				 st2: PACKED ARRAY [1..4] OF char; {the string st2}
				 st3: PACKED ARRAY [1..4] OF char; {the string st3}
				 st4: PACKED ARRAY [1..4] OF char; {the string st4}
				 intl1Vers: INTEGER; {version word}
				 localRtn: INTEGER; {routine for localizing mag comp; }
						 {minimal case is $4E75 for RTS, but }
						 {routine may be longer than one integer.}
				 END; {intl1Rec}

	DateForm = (shortDate, longDate, abbrevDate);

	FUNCTION IUGetIntl(theID: INTEGER): Handle;

	PROCEDURE IUSetIntl(refNum: INTEGER; theID: INTEGER; intlParam: Handle);

	PROCEDURE IUDateString(dateTime: LongInt; longFlag: DateForm;
						 VAR result: Str255);

	PROCEDURE IUDatePString(dateTime: LongInt; longFlag: DateForm;
							VAR result: Str255; intlParam: Handle);

	PROCEDURE IUTimeString(dateTime: LongInt; wantSeconds: BOOLEAN;
						 VAR result: Str255);

	PROCEDURE IUTimePString(dateTime: LongInt; wantSeconds: BOOLEAN;
							VAR result: Str255; intlParam: Handle);

	FUNCTION IUMetric: BOOLEAN;

	FUNCTION IUCompString(aStr, bStr: Str255): INTEGER;

	FUNCTION IUEqualString(aStr, bStr: Str255): INTEGER;

	FUNCTION IUMagString(aPtr, bPtr: Ptr; aLen, bLen: INTEGER): INTEGER;

	FUNCTION IUMagIDString(aPtr, bPtr: Ptr; aLen, bLen: INTEGER): INTEGER;

	{ Binary-Decimal Conversion Package ----------------------------------}

	PROCEDURE StringToNum(theString: Str255; VAR theNum: LongInt);

	PROCEDURE NumToString(theNum: LongInt; VAR theString: Str255);

	{list manager}

	CONST

	{for list manager}

	{ Masks for selection flags (selFlags) }

	LOnlyOne = - 128; { 0 = multiple selections, 1 = one }
	LExtendDrag = 64; { 1 = drag select without shift key }
	LNoDisjoint = 32; { 1 = turn off selections on click }
	LNoExtend = 16; { 1 = don't extend shift selections }
	LNoRect = 8; { 1 = don't grow (shift,drag) selection as rect }
	LUseSense = 4; { 1 = shift should use sense of start cell }
	LNoNilHilite = 2; { 1 = don't hilite empty cells }

	{ Masks for other flags (listFlags) }

	LDoVAutoscroll = 2; { 1 = allow vertical autoscrolling }
	LDoHAutoscroll = 1; { 1 = allow horizontal autoscrolling }

	{ Messages to list definition procedure }

	LInitMsg = 0; { tell drawing routines to init themselves }
	LDrawMsg = 1; { draw (and de/select) the indicated data }
	LHiliteMsg = 2; { invert hilite state of specified cell }
	LCloseMsg = 3; { shut down, the list is being disposed }

	TYPE

	Cell = Point;

	dataArray = PACKED ARRAY [0..32000] OF char;
	dataPtr = ^dataArray;
	dataHandle = ^dataPtr;

	ListPtr = ^ListRec;
	ListHandle = ^ListPtr;
	ListRec = RECORD
				rView: Rect; {Rect in which we are viewed}
				port: GrafPtr; {Grafport that owns us}

				indent: Point; {Indent pixels in cell}
				cellSize: Point; {Cell size}

				visible: Rect; {visible row/column bounds}

				vScroll: ControlHandle; {vertical scroll bar (or NIL)}
				hScroll: ControlHandle; {horizontal scroll bar (or NIL)}

				selFlags: SignedByte; { defines selection characteristics }
				LActive: BOOLEAN; { active or not }
				LReserved: SignedByte; { internally used flags }
				listFlags: SignedByte; { other flags }

				clikTime: LongInt; { save time of last click }
				clikLoc: Point; { save position of last click }
				mouseLoc: Point; { current mouse position }
				LClikLoop: Ptr; { routine called repeatedly during ListClick }
				lastClick: Cell; { the last cell clicked in }

				refCon: LongInt; { reference value }

				listDefProc: Handle; { Handle to the defProc }
				userHandle: Handle; { General purpose handle for user}

				dataBounds: Rect; { Total number of rows/columns}
				cells: dataHandle; { Handle to data}

				maxIndex: INTEGER; { index past the last element}
				cellArray: ARRAY [1..1] OF INTEGER; { offsets to elements }
				END;

	PROCEDURE LActivate(act: BOOLEAN; lHandle: ListHandle);

	FUNCTION LAddColumn(count, colNum: INTEGER; lHandle: ListHandle): INTEGER;

	FUNCTION LAddRow(count, rowNum: INTEGER; lHandle: ListHandle): INTEGER;

	PROCEDURE LAddToCell(dataPtr: Ptr; dataLen: INTEGER; theCell: Cell;
						 lHandle: ListHandle);

	PROCEDURE LAutoScroll(lHandle: ListHandle);

	PROCEDURE LCellSize(cSize: Point; lHandle: ListHandle);

	FUNCTION LClick(pt: Point; modifiers: INTEGER; lHandle: ListHandle): BOOLEAN;

	PROCEDURE LClrCell(theCell: Cell; lHandle: ListHandle);

	PROCEDURE LDelColumn(count, colNum: INTEGER; lHandle: ListHandle);

	PROCEDURE LDelRow(count, rowNum: INTEGER; lHandle: ListHandle);

	PROCEDURE LDispose(lHandle: ListHandle);

	PROCEDURE LDoDraw(drawIt: BOOLEAN; lHandle: ListHandle);

	PROCEDURE LDraw(theCell: Cell; lHandle: ListHandle);

	PROCEDURE LFind(VAR offset, len: INTEGER; theCell: Cell; lHandle: ListHandle);

	PROCEDURE LGetCell(dataPtr: Ptr; VAR dataLen: INTEGER; theCell: Cell;
					 lHandle: ListHandle);

	FUNCTION LGetSelect(next: BOOLEAN; VAR theCell: Cell;
						lHandle: ListHandle): BOOLEAN;

	FUNCTION LLastClick(lHandle: ListHandle): Cell;

	FUNCTION LNew(rView, dataBounds: Rect; cSize: Point; theProc: INTEGER;
				theWindow: WindowPtr; drawIt, hasGrow, scrollHoriz,
				scrollVert: BOOLEAN): ListHandle;

	FUNCTION LNextCell(hNext, vNext: BOOLEAN; VAR theCell: Cell;
					 lHandle: ListHandle): BOOLEAN;

	PROCEDURE LRect(VAR cellRect: Rect; theCell: Cell; lHandle: ListHandle);

	PROCEDURE LScroll(dRows, dCols: INTEGER; lHandle: ListHandle);

	FUNCTION LSearch(dataPtr: Ptr; dataLen: INTEGER; searchProc: Ptr;
					 VAR theCell: Cell; lHandle: ListHandle): BOOLEAN;

	PROCEDURE LSetCell(dataPtr: Ptr; dataLen: INTEGER; theCell: Cell;
					 lHandle: ListHandle);

	PROCEDURE LSetSelect(setIt: BOOLEAN; theCell: Cell; lHandle: ListHandle);

	PROCEDURE LSize(listWidth, listHeight: INTEGER; lHandle: ListHandle);

	PROCEDURE LUpdate(theRgn: RgnHandle; lHandle: ListHandle);

END.

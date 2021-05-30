{
 	File:		Lists.p
 
 	Contains:	List Manager Interfaces.
 
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
 UNIT Lists;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __LISTS__}
{$SETC __LISTS__ := 1}

{$I+}
{$SETC ListsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}
{	Quickdraw.p													}
{		MixedMode.p												}
{		QuickdrawText.p											}
{	Menus.p														}
{		Memory.p												}

{$IFC UNDEFINED __MEMORY__}
{$I Memory.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	lDoVAutoscroll				= 2;
	lDoHAutoscroll				= 1;
	lOnlyOne					= -128;
	lExtendDrag					= 64;
	lNoDisjoint					= 32;
	lNoExtend					= 16;
	lNoRect						= 8;
	lUseSense					= 4;
	lNoNilHilite				= 2;

	lDoVAutoscrollBit			= 1;
	lDoHAutoscrollBit			= 0;
	lOnlyOneBit					= 7;
	lExtendDragBit				= 6;
	lNoDisjointBit				= 5;
	lNoExtendBit				= 4;
	lNoRectBit					= 3;
	lUseSenseBit				= 2;
	lNoNilHiliteBit				= 1;

	lInitMsg					= 0;
	lDrawMsg					= 1;
	lHiliteMsg					= 2;
	lCloseMsg					= 3;

TYPE
	ListPtr = ^ListRec;
	ListHandle = ^ListPtr;

	ListRef = ListHandle;

	Cell = Point;

	ListBounds = Rect;

	DataArray = PACKED ARRAY [0..32000] OF CHAR;

	DataPtr = ^DataArray;
	DataHandle = ^DataPtr;

	ListSearchProcPtr = ProcPtr;  { FUNCTION ListSearch(aPtr: Ptr; bPtr: Ptr; aLen: INTEGER; bLen: INTEGER): INTEGER; }
	{
		ListClickLoopProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 =>             	.?
		Out:
		 <= return value	D0.B
	}
	ListClickLoopProcPtr = Register68kProcPtr;  { register FUNCTION ListClickLoop: BOOLEAN; }
	ListSearchUPP = UniversalProcPtr;
	ListClickLoopUPP = UniversalProcPtr;

	ListRec = RECORD
		rView:					Rect;
		port:					GrafPtr;
		indent:					Point;
		cellSize:				Point;
		visible:				ListBounds;
		vScroll:				ControlRef;
		hScroll:				ControlRef;
		selFlags:				SInt8;
		lActive:				BOOLEAN;
		lReserved:				SInt8;
		listFlags:				SInt8;
		clikTime:				LONGINT;
		clikLoc:				Point;
		mouseLoc:				Point;
		lClickLoop:				ListClickLoopUPP;
		lastClick:				Cell;
		refCon:					LONGINT;
		listDefProc:			Handle;
		userHandle:				Handle;
		dataBounds:				ListBounds;
		cells:					DataHandle;
		maxIndex:				INTEGER;
		cellArray:				ARRAY [0..0] OF INTEGER;
	END;

	ListDefProcPtr = ProcPtr;  { PROCEDURE ListDef(lMessage: INTEGER; lSelect: BOOLEAN; VAR lRect: Rect; lCell: Cell; lDataOffset: INTEGER; lDataLen: INTEGER; lHandle: ListRef); }
	ListCellDrawProcPtr = ProcPtr;  { PROCEDURE ListCellDraw(lMessage: INTEGER; lSelect: BOOLEAN; VAR lRect: Rect; lCell: Cell; dataPtr: UNIV Ptr; lDataLen: INTEGER; lHandle: ListRef); }
	ListDefUPP = UniversalProcPtr;
	ListCellDrawUPP = UniversalProcPtr;

CONST
	uppListSearchProcInfo = $00002BE0; { FUNCTION (4 byte param, 4 byte param, 2 byte param, 2 byte param): 2 byte result; }
	uppListClickLoopProcInfo = $00000012; { Register FUNCTION : 1 byte in D0; }
	uppListDefProcInfo = $000EBD80; { PROCEDURE (2 byte param, 1 byte param, 4 byte param, 4 byte param, 2 byte param, 2 byte param, 4 byte param); }
	uppListCellDrawProcInfo = $000EFD80; { PROCEDURE (2 byte param, 1 byte param, 4 byte param, 4 byte param, 4 byte param, 2 byte param, 4 byte param); }

FUNCTION NewListSearchProc(userRoutine: ListSearchProcPtr): ListSearchUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewListClickLoopProc(userRoutine: ListClickLoopProcPtr): ListClickLoopUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewListDefProc(userRoutine: ListDefProcPtr): ListDefUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION NewListCellDrawProc(userRoutine: ListCellDrawProcPtr): ListCellDrawUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallListSearchProc(aPtr: Ptr; bPtr: Ptr; aLen: INTEGER; bLen: INTEGER; userRoutine: ListSearchUPP): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION CallListClickLoopProc(userRoutine: ListClickLoopUPP): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

PROCEDURE CallListDefProc(lMessage: INTEGER; lSelect: BOOLEAN; VAR lRect: Rect; lCell: Cell; lDataOffset: INTEGER; lDataLen: INTEGER; lHandle: ListRef; userRoutine: ListDefUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

PROCEDURE CallListCellDrawProc(lMessage: INTEGER; lSelect: BOOLEAN; VAR lRect: Rect; lCell: Cell; dataPtr: UNIV Ptr; lDataLen: INTEGER; lHandle: ListRef; userRoutine: ListCellDrawUPP);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}

FUNCTION LNew({CONST}VAR rView: Rect; {CONST}VAR dataBounds: ListBounds; cSize: Point; theProc: INTEGER; theWindow: WindowRef; drawIt: BOOLEAN; hasGrow: BOOLEAN; scrollHoriz: BOOLEAN; scrollVert: BOOLEAN): ListRef;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0044, $A9E7;
	{$ENDC}
PROCEDURE LDispose(lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0028, $A9E7;
	{$ENDC}
FUNCTION LAddColumn(count: INTEGER; colNum: INTEGER; lHandle: ListRef): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0004, $A9E7;
	{$ENDC}
FUNCTION LAddRow(count: INTEGER; rowNum: INTEGER; lHandle: ListRef): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0008, $A9E7;
	{$ENDC}
PROCEDURE LDelColumn(count: INTEGER; colNum: INTEGER; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0020, $A9E7;
	{$ENDC}
PROCEDURE LDelRow(count: INTEGER; rowNum: INTEGER; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0024, $A9E7;
	{$ENDC}
FUNCTION LGetSelect(next: BOOLEAN; VAR theCell: Cell; lHandle: ListRef): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $003C, $A9E7;
	{$ENDC}
FUNCTION LLastClick(lHandle: ListRef): Cell;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0040, $A9E7;
	{$ENDC}
FUNCTION LNextCell(hNext: BOOLEAN; vNext: BOOLEAN; VAR theCell: Cell; lHandle: ListRef): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0048, $A9E7;
	{$ENDC}
FUNCTION LSearch(dataPtr: UNIV Ptr; dataLen: INTEGER; searchProc: ListSearchUPP; VAR theCell: Cell; lHandle: ListRef): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0054, $A9E7;
	{$ENDC}
PROCEDURE LSize(listWidth: INTEGER; listHeight: INTEGER; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0060, $A9E7;
	{$ENDC}
PROCEDURE LSetDrawingMode(drawIt: BOOLEAN; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $002C, $A9E7;
	{$ENDC}
PROCEDURE LScroll(dCols: INTEGER; dRows: INTEGER; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0050, $A9E7;
	{$ENDC}
PROCEDURE LAutoScroll(lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0010, $A9E7;
	{$ENDC}
PROCEDURE LUpdate(theRgn: RgnHandle; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0064, $A9E7;
	{$ENDC}
PROCEDURE LActivate(act: BOOLEAN; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $4267, $A9E7;
	{$ENDC}
PROCEDURE LCellSize(cSize: Point; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0014, $A9E7;
	{$ENDC}
FUNCTION LClick(pt: Point; modifiers: INTEGER; lHandle: ListRef): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0018, $A9E7;
	{$ENDC}
PROCEDURE LAddToCell(dataPtr: UNIV Ptr; dataLen: INTEGER; theCell: Cell; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000C, $A9E7;
	{$ENDC}
PROCEDURE LClrCell(theCell: Cell; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $001C, $A9E7;
	{$ENDC}
PROCEDURE LGetCell(dataPtr: UNIV Ptr; VAR dataLen: INTEGER; theCell: Cell; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0038, $A9E7;
	{$ENDC}
PROCEDURE LRect(VAR cellRect: Rect; theCell: Cell; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $004C, $A9E7;
	{$ENDC}
PROCEDURE LSetCell(dataPtr: UNIV Ptr; dataLen: INTEGER; theCell: Cell; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0058, $A9E7;
	{$ENDC}
PROCEDURE LSetSelect(setIt: BOOLEAN; theCell: Cell; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $005C, $A9E7;
	{$ENDC}
PROCEDURE LDraw(theCell: Cell; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0030, $A9E7;
	{$ENDC}
PROCEDURE LGetCellDataLocation(VAR offset: INTEGER; VAR len: INTEGER; theCell: Cell; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0034, $A9E7;
	{$ENDC}
{$IFC OLDROUTINENAMES }
PROCEDURE LDoDraw(drawIt: BOOLEAN; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $002C, $A9E7;
	{$ENDC}
PROCEDURE LFind(VAR offset: INTEGER; VAR len: INTEGER; theCell: Cell; lHandle: ListRef);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0034, $A9E7;
	{$ENDC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ListsIncludes}

{$ENDC} {__LISTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

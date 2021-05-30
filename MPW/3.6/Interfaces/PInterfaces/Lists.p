{
     File:       Lists.p
 
     Contains:   List Manager Interfaces.
 
     Version:    Technology: Mac OS 9
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
 UNIT Lists;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __LISTS__}
{$SETC __LISTS__ := 1}

{$I+}
{$SETC ListsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	Cell								= Point;
	CellPtr 							= ^Cell;
	ListBounds							= Rect;
	ListBoundsPtr 						= ^ListBounds;
	DataArray							= PACKED ARRAY [0..32000] OF CHAR;
	DataPtr								= ^DataArray;
	DataHandle							= ^DataPtr;
{$IFC TYPED_FUNCTION_POINTERS}
	ListSearchProcPtr = FUNCTION(aPtr: Ptr; bPtr: Ptr; aLen: INTEGER; bLen: INTEGER): INTEGER;
{$ELSEC}
	ListSearchProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ListClickLoopProcPtr = FUNCTION: BOOLEAN;
{$ELSEC}
	ListClickLoopProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ListSearchUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ListSearchUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ListClickLoopUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ListClickLoopUPP = UniversalProcPtr;
{$ENDC}	
{$IFC NOT TARGET_OS_MAC }
	{	 QuickTime 3.0 	}
	ListNotification					= LONGINT;

CONST
	listNotifyNothing			= 'nada';						{  No (null) notification }
	listNotifyClick				= 'clik';						{  Control was clicked }
	listNotifyDoubleClick		= 'dblc';						{  Control was double-clicked }
	listNotifyPreClick			= 'pclk';						{  Control about to be clicked }

{$ENDC}


TYPE
	ListRecPtr = ^ListRec;
	ListRec = RECORD
		rView:					Rect;									{  in Carbon use Get/SetListViewBounds }
		port:					GrafPtr;								{  in Carbon use Get/SetListPort }
		indent:					Point;									{  in Carbon use Get/SetListCellIndent }
		cellSize:				Point;									{  in Carbon use Get/SetListCellSize }
		visible:				ListBounds;								{  in Carbon use GetListVisibleCells }
		vScroll:				ControlRef;								{  in Carbon use GetListVerticalScrollBar }
		hScroll:				ControlRef;								{  in Carbon use GetListHorizontalScrollBar }
		selFlags:				SInt8;									{  in Carbon use Get/SetListSelectionFlags }
		lActive:				BOOLEAN;								{  in Carbon use LActivate, GetListActive }
		lReserved:				SInt8;									{  not supported in Carbon  }
		listFlags:				SInt8;									{  in Carbon use Get/SetListFlags  }
		clikTime:				LONGINT;								{  in Carbon use Get/SetListClickTime }
		clikLoc:				Point;									{  in Carbon use GetListClickLocation }
		mouseLoc:				Point;									{  in Carbon use GetListMouseLocation }
		lClickLoop:				ListClickLoopUPP;						{  in Carbon use Get/SetListClickLoop }
		lastClick:				Cell;									{  in Carbon use SetListLastClick }
		refCon:					LONGINT;								{  in Carbon use Get/SetListRefCon }
		listDefProc:			Handle;									{  not supported in Carbon  }
		userHandle:				Handle;									{  in Carbon use Get/SetListUserHandle }
		dataBounds:				ListBounds;								{  in Carbon use GetListDataBounds }
		cells:					DataHandle;								{  in Carbon use LGet/SetCell }
		maxIndex:				INTEGER;								{  in Carbon use LGet/SetCell }
		cellArray:				ARRAY [0..0] OF INTEGER;				{  in Carbon use LGet/SetCell }
	END;

	ListPtr								= ^ListRec;
	ListHandle							= ^ListPtr;
	{  ListRef is obsolete.  Use ListHandle.  }
	ListRef								= ListHandle;



CONST
																{  ListRec.listFlags bits }
	lDrawingModeOffBit			= 3;
	lDoVAutoscrollBit			= 1;
	lDoHAutoscrollBit			= 0;

																{  ListRec.listFlags masks }
	lDrawingModeOff				= 8;
	lDoVAutoscroll				= 2;
	lDoHAutoscroll				= 1;


																{  ListRec.selFlags bits }
	lOnlyOneBit					= 7;
	lExtendDragBit				= 6;
	lNoDisjointBit				= 5;
	lNoExtendBit				= 4;
	lNoRectBit					= 3;
	lUseSenseBit				= 2;
	lNoNilHiliteBit				= 1;


																{  ListRec.selFlags masks }
	lOnlyOne					= -128;
	lExtendDrag					= 64;
	lNoDisjoint					= 32;
	lNoExtend					= 16;
	lNoRect						= 8;
	lUseSense					= 4;
	lNoNilHilite				= 2;


																{  LDEF messages }
	lInitMsg					= 0;
	lDrawMsg					= 1;
	lHiliteMsg					= 2;
	lCloseMsg					= 3;

	{
	   StandardIconListCellDataRec is the cell data format for
	   use with the standard icon list (kListDefStandardIconType).
	}

TYPE
	StandardIconListCellDataRecPtr = ^StandardIconListCellDataRec;
	StandardIconListCellDataRec = RECORD
		iconHandle:				Handle;
		font:					INTEGER;
		face:					INTEGER;
		size:					INTEGER;
		name:					Str255;
	END;

	StandardIconListCellDataPtr			= ^StandardIconListCellDataRec;


{$IFC TYPED_FUNCTION_POINTERS}
	ListDefProcPtr = PROCEDURE(lMessage: INTEGER; lSelect: BOOLEAN; VAR lRect: Rect; lCell: Cell; lDataOffset: INTEGER; lDataLen: INTEGER; lHandle: ListHandle);
{$ELSEC}
	ListDefProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ListDefUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ListDefUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppListSearchProcInfo = $00002BE0;
	uppListClickLoopProcInfo = $00000012;
	uppListDefProcInfo = $000EBD80;
	{
	 *  NewListSearchUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewListSearchUPP(userRoutine: ListSearchProcPtr): ListSearchUPP; { old name was NewListSearchProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewListClickLoopUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewListClickLoopUPP(userRoutine: ListClickLoopProcPtr): ListClickLoopUPP; { old name was NewListClickLoopProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewListDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewListDefUPP(userRoutine: ListDefProcPtr): ListDefUPP; { old name was NewListDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeListSearchUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeListSearchUPP(userUPP: ListSearchUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeListClickLoopUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeListClickLoopUPP(userUPP: ListClickLoopUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeListDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeListDefUPP(userUPP: ListDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeListSearchUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeListSearchUPP(aPtr: Ptr; bPtr: Ptr; aLen: INTEGER; bLen: INTEGER; userRoutine: ListSearchUPP): INTEGER; { old name was CallListSearchProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeListClickLoopUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeListClickLoopUPP(userRoutine: ListClickLoopUPP): BOOLEAN; { old name was CallListClickLoopProc }
{
 *  InvokeListDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeListDefUPP(lMessage: INTEGER; lSelect: BOOLEAN; VAR lRect: Rect; lCell: Cell; lDataOffset: INTEGER; lDataLen: INTEGER; lHandle: ListHandle; userRoutine: ListDefUPP); { old name was CallListDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


CONST
	kListDefProcPtr				= 0;
	kListDefUserProcType		= 0;
	kListDefStandardTextType	= 1;
	kListDefStandardIconType	= 2;


TYPE
	ListDefType							= UInt32;
	ListDefSpecPtr = ^ListDefSpec;
	ListDefSpec = RECORD
		defType:				ListDefType;
		CASE INTEGER OF
		0: (
			userProc:			ListDefUPP;
			);
	END;

	{
	 *  CreateCustomList()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateCustomList({CONST}VAR rView: Rect; {CONST}VAR dataBounds: ListBounds; cellSize: Point; {CONST}VAR theSpec: ListDefSpec; theWindow: WindowRef; drawIt: BOOLEAN; hasGrow: BOOLEAN; scrollHoriz: BOOLEAN; scrollVert: BOOLEAN; VAR outList: ListHandle): OSStatus;


{$IFC NOT TARGET_OS_MAC }
{ QuickTime 3.0 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	ListNotificationProcPtr = PROCEDURE(theList: ListHandle; notification: ListNotification; param: LONGINT);
{$ELSEC}
	ListNotificationProcPtr = ProcPtr;
{$ENDC}

	ListNotificationUPP					= ListNotificationProcPtr;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  LSetNotificationCallback()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE LSetNotificationCallback(callBack: ListNotificationProcPtr; lHandle: ListHandle); C;

{
 *  GetListVisibleBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetListVisibleBounds(theList: ListHandle; VAR visibleBounds: Rect); C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{
 *  LNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LNew({CONST}VAR rView: Rect; {CONST}VAR dataBounds: ListBounds; cSize: Point; theProc: INTEGER; theWindow: WindowRef; drawIt: BOOLEAN; hasGrow: BOOLEAN; scrollHoriz: BOOLEAN; scrollVert: BOOLEAN): ListHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0044, $A9E7;
	{$ENDC}

{
 *  LDispose()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LDispose(lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0028, $A9E7;
	{$ENDC}

{
 *  LAddColumn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LAddColumn(count: INTEGER; colNum: INTEGER; lHandle: ListHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0004, $A9E7;
	{$ENDC}

{
 *  LAddRow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LAddRow(count: INTEGER; rowNum: INTEGER; lHandle: ListHandle): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0008, $A9E7;
	{$ENDC}

{
 *  LDelColumn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LDelColumn(count: INTEGER; colNum: INTEGER; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0020, $A9E7;
	{$ENDC}

{
 *  LDelRow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LDelRow(count: INTEGER; rowNum: INTEGER; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0024, $A9E7;
	{$ENDC}

{
 *  LGetSelect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LGetSelect(next: BOOLEAN; VAR theCell: Cell; lHandle: ListHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $003C, $A9E7;
	{$ENDC}

{
 *  LLastClick()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LLastClick(lHandle: ListHandle): Cell;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0040, $A9E7;
	{$ENDC}

{
 *  LNextCell()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LNextCell(hNext: BOOLEAN; vNext: BOOLEAN; VAR theCell: Cell; lHandle: ListHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0048, $A9E7;
	{$ENDC}

{
 *  LSearch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LSearch(dataPtr: UNIV Ptr; dataLen: INTEGER; searchProc: ListSearchUPP; VAR theCell: Cell; lHandle: ListHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0054, $A9E7;
	{$ENDC}

{
 *  LSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LSize(listWidth: INTEGER; listHeight: INTEGER; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0060, $A9E7;
	{$ENDC}

{
 *  LSetDrawingMode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LSetDrawingMode(drawIt: BOOLEAN; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $002C, $A9E7;
	{$ENDC}

{
 *  LScroll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LScroll(dCols: INTEGER; dRows: INTEGER; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0050, $A9E7;
	{$ENDC}

{
 *  LAutoScroll()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LAutoScroll(lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0010, $A9E7;
	{$ENDC}

{
 *  LUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LUpdate(theRgn: RgnHandle; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0064, $A9E7;
	{$ENDC}

{
 *  LActivate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LActivate(act: BOOLEAN; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $4267, $A9E7;
	{$ENDC}

{
 *  LCellSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LCellSize(cSize: Point; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0014, $A9E7;
	{$ENDC}

{
 *  LClick()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LClick(pt: Point; modifiers: EventModifiers; lHandle: ListHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0018, $A9E7;
	{$ENDC}

{
 *  LAddToCell()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LAddToCell(dataPtr: UNIV Ptr; dataLen: INTEGER; theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000C, $A9E7;
	{$ENDC}

{
 *  LClrCell()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LClrCell(theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $001C, $A9E7;
	{$ENDC}

{
 *  LGetCell()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LGetCell(dataPtr: UNIV Ptr; VAR dataLen: INTEGER; theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0038, $A9E7;
	{$ENDC}

{
 *  LRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LRect(VAR cellRect: Rect; theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $004C, $A9E7;
	{$ENDC}

{
 *  LSetCell()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LSetCell(dataPtr: UNIV Ptr; dataLen: INTEGER; theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0058, $A9E7;
	{$ENDC}

{
 *  LSetSelect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LSetSelect(setIt: BOOLEAN; theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $005C, $A9E7;
	{$ENDC}

{
 *  LDraw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LDraw(theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0030, $A9E7;
	{$ENDC}

{
 *  LGetCellDataLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LGetCellDataLocation(VAR offset: INTEGER; VAR len: INTEGER; theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0034, $A9E7;
	{$ENDC}

{  Routines available in Carbon only }

{
 *  RegisterListDefinition()
 *  
 *  Summary:
 *    Registers a binding between a resource ID and a list definition
 *    function.
 *  
 *  Discussion:
 *    In the Mac OS 8.x List Manager, a 'ldes' resource can contain an
 *    embedded LDEF procID that is used by the List Manager as the
 *    resource ID of an 'LDEF' resource to measure and draw the list.
 *    Since LDEFs can no longer be packaged as code resources on
 *    Carbon, the procID can no longer refer directly to an LDEF
 *    resource. However, using RegisterListDefinition you can instead
 *    specify a UniversalProcPtr pointing to code in your application
 *    code fragment.
 *  
 *  Parameters:
 *    
 *    inResID:
 *      An LDEF proc ID, as used in a 'ldes' resource.
 *    
 *    inDefSpec:
 *      Specifies the ListDefUPP that should be used for lists with the
 *      given LDEF procID.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RegisterListDefinition(inResID: SInt16; inDefSpec: ListDefSpecPtr): OSStatus;

{$IFC CALL_NOT_IN_CARBON }
{$IFC CALL_NOT_IN_CARBON }
{
 *  SetListDefinitionProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetListDefinitionProc(resID: SInt16; defProc: ListDefUPP): OSErr;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC NOT TARGET_OS_MAC }
{ QuickTime 3.0 }
{$IFC CALL_NOT_IN_CARBON }
{
 *  LSetLDEF()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE LSetLDEF(proc: ListDefProcPtr; lHandle: ListRef); C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
{
 *  LDoDraw()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE LDoDraw(drawIt: BOOLEAN; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $002C, $A9E7;
	{$ENDC}

{
 *  LFind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE LFind(VAR offset: INTEGER; VAR len: INTEGER; theCell: Cell; lHandle: ListHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0034, $A9E7;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}

{$IFC ACCESSOR_CALLS_ARE_FUNCTIONS }
{ Getters }
{
 *  GetListViewBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListViewBounds(list: ListRef; VAR view: Rect): RectPtr;

{
 *  GetListPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListPort(list: ListRef): CGrafPtr;

{
 *  GetListCellIndent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListCellIndent(list: ListRef; VAR indent: Point): PointPtr;

{
 *  GetListCellSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListCellSize(list: ListRef; VAR size: Point): PointPtr;

{
 *  GetListVisibleCells()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListVisibleCells(list: ListRef; VAR visible: ListBounds): ListBoundsPtr;

{
 *  GetListVerticalScrollBar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListVerticalScrollBar(list: ListRef): ControlRef;

{
 *  GetListHorizontalScrollBar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListHorizontalScrollBar(list: ListRef): ControlRef;

{
 *  GetListActive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListActive(list: ListRef): BOOLEAN;

{
 *  GetListClickTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListClickTime(list: ListRef): SInt32;

{
 *  GetListClickLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListClickLocation(list: ListRef; VAR click: Point): PointPtr;

{
 *  GetListMouseLocation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListMouseLocation(list: ListRef; VAR mouse: Point): PointPtr;

{
 *  GetListClickLoop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListClickLoop(list: ListRef): ListClickLoopUPP;

{
 *  GetListRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListRefCon(list: ListRef): SInt32;

{
 *  GetListDefinition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListDefinition(list: ListRef): Handle;

{
 *  GetListUserHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListUserHandle(list: ListRef): Handle;

{
 *  GetListDataBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListDataBounds(list: ListRef; VAR bounds: ListBounds): ListBoundsPtr;

{
 *  GetListDataHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListDataHandle(list: ListRef): DataHandle;

{
 *  GetListFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListFlags(list: ListRef): OptionBits;

{
 *  GetListSelectionFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetListSelectionFlags(list: ListRef): OptionBits;

{ Setters }
{
 *  SetListViewBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetListViewBounds(list: ListRef; {CONST}VAR view: Rect);

{
 *  SetListPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetListPort(list: ListRef; port: CGrafPtr);

{
 *  SetListCellIndent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetListCellIndent(list: ListRef; VAR indent: Point);

{
 *  SetListClickTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetListClickTime(list: ListRef; time: SInt32);

{
 *  SetListClickLoop()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetListClickLoop(list: ListRef; clickLoop: ListClickLoopUPP);

{
 *  SetListLastClick()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetListLastClick(list: ListRef; VAR lastClick: Cell);

{
 *  SetListRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetListRefCon(list: ListRef; refCon: SInt32);

{
 *  SetListUserHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetListUserHandle(list: ListRef; userHandle: Handle);

{
 *  SetListFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetListFlags(list: ListRef; listFlags: OptionBits);

{
 *  SetListSelectionFlags()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetListSelectionFlags(list: ListRef; selectionFlags: OptionBits);

{$ENDC}  {ACCESSOR_CALLS_ARE_FUNCTIONS}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ListsIncludes}

{$ENDC} {__LISTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

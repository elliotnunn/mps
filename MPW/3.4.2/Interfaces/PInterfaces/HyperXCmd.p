{
 	File:		HyperXCmd.p
 
 	Contains:	Interfaces for HyperCard XCMD's
 
 	Version:	Technology:	HyperCard 2.3
 				Package:	Universal Interfaces 2.1.1 in “MPW Latest” on ETO #19
 
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
 UNIT HyperXCmd;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __HYPERXCMD__}
{$SETC __HYPERXCMD__ := 1}

{$I+}
{$SETC HyperXCmdIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{	Quickdraw.p													}
{		MixedMode.p												}
{		QuickdrawText.p											}
{	OSUtils.p													}
{		Memory.p												}
{		Patches.p												}

{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}

{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}

{$IFC UNDEFINED __STANDARDFILE__}
{$I StandardFile.p}
{$ENDC}
{	Dialogs.p													}
{		Errors.p												}
{		Controls.p												}
{		Windows.p												}
{	Files.p														}
{		Finder.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
{ result codes }

CONST
	xresSucc					= 0;
	xresFail					= 1;
	xresNotImp					= 2;

{ XCMDBlock constants for event.what... }
	xOpenEvt					= 1000;							{ the first event after you are created }
	xCloseEvt					= 1001;							{ your window is being forced close (Quit?) }
	xGiveUpEditEvt				= 1002;							{ you are losing Edit... }
	xGiveUpSoundEvt				= 1003;							{ you are losing the sound channel... }
	xHidePalettesEvt			= 1004;							{ someone called HideHCPalettes }
	xShowPalettesEvt			= 1005;							{ someone called ShowHCPalettes }
	xEditUndo					= 1100;							{ Edit——Undo }
	xEditCut					= 1102;							{ Edit——Cut }
	xEditCopy					= 1103;							{ Edit——Copy }
	xEditPaste					= 1104;							{ Edit——Paste }
	xEditClear					= 1105;							{ Edit——Clear }
	xSendEvt					= 1200;							{ script has sent you a message (text) }
	xSetPropEvt					= 1201;							{ set a window property }
	xGetPropEvt					= 1202;							{ get a window property }
	xCursorWithin				= 1300;							{ cursor is within the window }
	xMenuEvt					= 1400;							{ user has selected an item in your menu }
	xMBarClickedEvt				= 1401;							{ a menu is about to be shown--update if needed }
	xShowWatchInfoEvt			= 1501;							{ for variable and message watchers }
	xScriptErrorEvt				= 1502;							{ place the insertion point }
	xDebugErrorEvt				= 1503;							{ user clicked "Debug" at a complaint }
	xDebugStepEvt				= 1504;							{ hilite the line }
	xDebugTraceEvt				= 1505;							{ same as step but tracing }
	xDebugFinishedEvt			= 1506;							{ script ended }

	paletteProc					= 2048;							{ Windoid with grow box }
	palNoGrowProc				= 2052;							{ standard Windoid defproc }
	palZoomProc					= 2056;							{ Windoid with zoom and grow }
	palZoomNoGrow				= 2060;							{ Windoid with zoom and no grow }
	hasZoom						= 8;
	hasTallTBar					= 2;
	toggleHilite				= 1;

{ paramCount is set to these constants when first calling special XThings }
	xMessageWatcherID			= -2;
	xVariableWatcherID			= -3;
	xScriptEditorID				= -4;
	xDebuggerID					= -5;

{ XTalkObjectPtr->objectKind values }
	stackObj					= 1;
	bkgndObj					= 2;
	cardObj						= 3;
	fieldObj					= 4;
	buttonObj					= 5;

{ selectors for ShowHCAlert's dialogs (shown as buttonID:buttonText) }
	errorDlgID					= 1;							{ 1:OK (default) }
	confirmDlgID				= 2;							{ 1:OK (default) and 2:Cancel }
	confirmDelDlgID				= 3;							{ 1:Cancel (default) and 2:Delete }
	yesNoCancelDlgID			= 4;							{ 1:Yes (default), 2:Cancel, and 3:No }

{ type definitions }

TYPE
	XCmdBlock = RECORD
		paramCount:				INTEGER;								{ If = -1 then new use for XWindoids }
		params:					ARRAY [1..16] OF Handle;
		returnValue:			Handle;
		passFlag:				BOOLEAN;
		filler1:				SignedByte;
		entryPoint:				UniversalProcPtr;						{ to call back to HyperCard }
		request:				INTEGER;
		result:					INTEGER;
		inArgs:					ARRAY [1..8] OF LONGINT;
		outArgs:				ARRAY [1..4] OF LONGINT;
	END;

	XCmdPtr = ^XCmdBlock;

	XWEventInfo = RECORD
		event:					EventRecord;
		eventWindow:			WindowPtr;
		eventParams:			ARRAY [1..9] OF LONGINT;
		eventResult:			Handle;
	END;

	XWEventInfoPtr = ^XWEventInfo;

	XTalkObject = RECORD
		objectKind:				INTEGER;								{ stack, bkgnd, card, field, or button }
		stackNum:				LONGINT;								{ reference number of the source stack }
		bkgndID:				LONGINT;
		cardID:					LONGINT;
		buttonID:				LONGINT;
		fieldID:				LONGINT;
	END;

	XTalkObjectPtr = ^XTalkObject;

{ maximum number of checkpoints in a script }

CONST
	maxCachedChecks				= 16;


TYPE
	CheckPts = RECORD
		checks:					ARRAY [1..16] OF INTEGER;
	END;

	CheckPtPtr = ^CheckPts;

	CheckPtHandle = ^CheckPtPtr;

{
		HyperTalk Utilities  
}

FUNCTION EvalExpr(paramPtr: XCmdPtr; expr: ConstStr255Param): Handle;
PROCEDURE SendCardMessage(paramPtr: XCmdPtr; msg: ConstStr255Param);
PROCEDURE SendHCMessage(paramPtr: XCmdPtr; msg: ConstStr255Param);
PROCEDURE RunHandler(paramPtr: XCmdPtr; handler: Handle);
{
		Memory Utilities  
}
FUNCTION GetGlobal(paramPtr: XCmdPtr; globName: ConstStr255Param): Handle;
PROCEDURE SetGlobal(paramPtr: XCmdPtr; globName: ConstStr255Param; globValue: Handle);
PROCEDURE ZeroBytes(paramPtr: XCmdPtr; dstPtr: UNIV Ptr; longCount: LONGINT);
{
		String Utilities  
}
PROCEDURE ScanToReturn(paramPtr: XCmdPtr; VAR scanPtr: Ptr);
PROCEDURE ScanToZero(paramPtr: XCmdPtr; VAR scanPtr: Ptr);
FUNCTION StringEqual(paramPtr: XCmdPtr; str1: ConstStr255Param; str2: ConstStr255Param): BOOLEAN;
FUNCTION StringLength(paramPtr: XCmdPtr; strPtr: UNIV Ptr): LONGINT;
FUNCTION StringMatch(paramPtr: XCmdPtr; pattern: ConstStr255Param; target: UNIV Ptr): Ptr;
PROCEDURE ZeroTermHandle(paramPtr: XCmdPtr; hndl: Handle);
{
		String Conversions  
}
PROCEDURE BoolToStr(paramPtr: XCmdPtr; bool: BOOLEAN; VAR str: Str255);
PROCEDURE Double_tToStr(paramPtr: XCmdPtr; num: double_t; VAR str: Str255);
PROCEDURE LongToStr(paramPtr: XCmdPtr; posNum: LONGINT; VAR str: Str255);
PROCEDURE NumToHex(paramPtr: XCmdPtr; num: LONGINT; nDigits: INTEGER; VAR str: Str255);
PROCEDURE NumToStr(paramPtr: XCmdPtr; num: LONGINT; VAR str: Str255);
FUNCTION PasToZero(paramPtr: XCmdPtr; str: ConstStr255Param): Handle;
PROCEDURE PointToStr(paramPtr: XCmdPtr; pt: Point; VAR str: Str255);
PROCEDURE RectToStr(paramPtr: XCmdPtr; {CONST}VAR rct: Rect; VAR str: Str255);
PROCEDURE ReturnToPas(paramPtr: XCmdPtr; zeroStr: UNIV Ptr; VAR pasStr: Str255);
FUNCTION StrToBool(paramPtr: XCmdPtr; str: ConstStr255Param): BOOLEAN;
FUNCTION StrToDouble_t(paramPtr: XCmdPtr; str: ConstStr255Param): double_t;
FUNCTION StrToLong(paramPtr: XCmdPtr; str: ConstStr255Param): LONGINT;
FUNCTION StrToNum(paramPtr: XCmdPtr; str: ConstStr255Param): LONGINT;
PROCEDURE StrToPoint(paramPtr: XCmdPtr; str: ConstStr255Param; VAR pt: Point);
PROCEDURE StrToRect(paramPtr: XCmdPtr; str: ConstStr255Param; VAR rct: Rect);
PROCEDURE ZeroToPas(paramPtr: XCmdPtr; zeroStr: UNIV Ptr; VAR pasStr: Str255);
{
		Field Utilities  
}
FUNCTION GetFieldByID(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldID: INTEGER): Handle;
FUNCTION GetFieldByName(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldName: ConstStr255Param): Handle;
FUNCTION GetFieldByNum(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldNum: INTEGER): Handle;
PROCEDURE SetFieldByID(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldID: INTEGER; fieldVal: Handle);
PROCEDURE SetFieldByName(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldName: ConstStr255Param; fieldVal: Handle);
PROCEDURE SetFieldByNum(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldNum: INTEGER; fieldVal: Handle);
FUNCTION GetFieldTE(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldID: INTEGER; fieldNum: INTEGER; fieldName: ConstStr255Param): TEHandle;
PROCEDURE SetFieldTE(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldID: INTEGER; fieldNum: INTEGER; fieldName: ConstStr255Param; fieldTE: TEHandle);
{
		Miscellaneous Utilities  
}
PROCEDURE BeginXSound(paramPtr: XCmdPtr; window: WindowPtr);
PROCEDURE EndXSound(paramPtr: XCmdPtr);
FUNCTION GetFilePath(paramPtr: XCmdPtr; fileName: ConstStr255Param; numTypes: INTEGER; typeList: ConstSFTypeListPtr; askUser: BOOLEAN; VAR fileType: OSType; VAR fullName: Str255): BOOLEAN;
PROCEDURE GetXResInfo(paramPtr: XCmdPtr; VAR resFile: INTEGER; VAR resID: INTEGER; VAR rType: ResType; VAR name: Str255);
PROCEDURE Notify(paramPtr: XCmdPtr);
PROCEDURE SendHCEvent(paramPtr: XCmdPtr; {CONST}VAR event: EventRecord);
PROCEDURE SendWindowMessage(paramPtr: XCmdPtr; windPtr: WindowPtr; windowName: ConstStr255Param; msg: ConstStr255Param);
FUNCTION FrontDocWindow(paramPtr: XCmdPtr): WindowPtr;
FUNCTION StackNameToNum(paramPtr: XCmdPtr; stackName: ConstStr255Param): LONGINT;
FUNCTION ShowHCAlert(paramPtr: XCmdPtr; dlgID: INTEGER; promptStr: ConstStr255Param): INTEGER;
FUNCTION AbortInQueue(paramPtr: XCmdPtr): BOOLEAN;
PROCEDURE FlushStackFile(paramPtr: XCmdPtr);
{
		Creating and Disposing XWindoids  
}
FUNCTION NewXWindow(paramPtr: XCmdPtr; {CONST}VAR boundsRect: Rect; title: ConstStr255Param; visible: BOOLEAN; procID: INTEGER; color: BOOLEAN; floating: BOOLEAN): WindowPtr;
FUNCTION GetNewXWindow(paramPtr: XCmdPtr; templateType: ResType; templateID: INTEGER; color: BOOLEAN; floating: BOOLEAN): WindowPtr;
PROCEDURE CloseXWindow(paramPtr: XCmdPtr; window: WindowPtr);
{
		XWindoid Utilities  
}
PROCEDURE HideHCPalettes(paramPtr: XCmdPtr);
PROCEDURE ShowHCPalettes(paramPtr: XCmdPtr);
PROCEDURE RegisterXWMenu(paramPtr: XCmdPtr; window: WindowPtr; menu: MenuHandle; registering: BOOLEAN);
PROCEDURE SetXWIdleTime(paramPtr: XCmdPtr; window: WindowPtr; interval: LONGINT);
PROCEDURE XWHasInterruptCode(paramPtr: XCmdPtr; window: WindowPtr; haveCode: BOOLEAN);
PROCEDURE XWAlwaysMoveHigh(paramPtr: XCmdPtr; window: WindowPtr; moveHigh: BOOLEAN);
PROCEDURE XWAllowReEntrancy(paramPtr: XCmdPtr; window: WindowPtr; allowSysEvts: BOOLEAN; allowHCEvts: BOOLEAN);
{
		Text Editing Utilities  
}
PROCEDURE BeginXWEdit(paramPtr: XCmdPtr; window: WindowPtr);
PROCEDURE EndXWEdit(paramPtr: XCmdPtr; window: WindowPtr);
FUNCTION HCWordBreakProc(paramPtr: XCmdPtr): WordBreakUPP;
PROCEDURE PrintTEHandle(paramPtr: XCmdPtr; hTE: TEHandle; header: StringPtr);
{
		Script Editor support  
}
FUNCTION GetCheckPoints(paramPtr: XCmdPtr): CheckPtHandle;
PROCEDURE SetCheckPoints(paramPtr: XCmdPtr; checkLines: CheckPtHandle);
PROCEDURE FormatScript(paramPtr: XCmdPtr; scriptHndl: Handle; VAR insertionPoint: LONGINT; quickFormat: BOOLEAN);
PROCEDURE SaveXWScript(paramPtr: XCmdPtr; scriptHndl: Handle);
PROCEDURE GetObjectName(paramPtr: XCmdPtr; xObjPtr: XTalkObjectPtr; VAR objName: Str255);
PROCEDURE GetObjectScript(paramPtr: XCmdPtr; xObjPtr: XTalkObjectPtr; VAR scriptHndl: Handle);
PROCEDURE SetObjectScript(paramPtr: XCmdPtr; xObjPtr: XTalkObjectPtr; scriptHndl: Handle);
{
		Debugging Tools support  
}
PROCEDURE AbortScript(paramPtr: XCmdPtr);
PROCEDURE GoScript(paramPtr: XCmdPtr);
PROCEDURE StepScript(paramPtr: XCmdPtr; stepInto: BOOLEAN);
PROCEDURE CountHandlers(paramPtr: XCmdPtr; VAR handlerCount: INTEGER);
PROCEDURE GetHandlerInfo(paramPtr: XCmdPtr; handlerNum: INTEGER; VAR handlerName: Str255; VAR objectName: Str255; VAR varCount: INTEGER);
PROCEDURE GetVarInfo(paramPtr: XCmdPtr; handlerNum: INTEGER; varNum: INTEGER; VAR varName: Str255; VAR isGlobal: BOOLEAN; VAR varValue: Str255; varHndl: Handle);
PROCEDURE SetVarValue(paramPtr: XCmdPtr; handlerNum: INTEGER; varNum: INTEGER; varHndl: Handle);
FUNCTION GetStackCrawl(paramPtr: XCmdPtr): Handle;
PROCEDURE TraceScript(paramPtr: XCmdPtr; traceInto: BOOLEAN);

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := HyperXCmdIncludes}

{$ENDC} {__HYPERXCMD__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

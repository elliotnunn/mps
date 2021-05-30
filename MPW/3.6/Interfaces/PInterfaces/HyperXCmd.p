{
     File:       HyperXCmd.p
 
     Contains:   Interfaces for HyperCard XCMD's
 
     Version:    Technology: HyperCard 2.3
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1987-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
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

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __FP__}
{$I fp.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __STANDARDFILE__}
{$I StandardFile.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ result codes }

CONST
	xresSucc					= 0;
	xresFail					= 1;
	xresNotImp					= 2;

	{	 XCMDBlock constants for event.what... 	}
	xOpenEvt					= 1000;							{  the first event after you are created  }
	xCloseEvt					= 1001;							{  your window is being forced close (Quit?)  }
	xGiveUpEditEvt				= 1002;							{  you are losing Edit...  }
	xGiveUpSoundEvt				= 1003;							{  you are losing the sound channel...  }
	xHidePalettesEvt			= 1004;							{  someone called HideHCPalettes  }
	xShowPalettesEvt			= 1005;							{  someone called ShowHCPalettes  }
	xEditUndo					= 1100;							{  Edit——Undo  }
	xEditCut					= 1102;							{  Edit——Cut  }
	xEditCopy					= 1103;							{  Edit——Copy  }
	xEditPaste					= 1104;							{  Edit——Paste  }
	xEditClear					= 1105;							{  Edit——Clear  }
	xSendEvt					= 1200;							{  script has sent you a message (text)  }
	xSetPropEvt					= 1201;							{  set a window property  }
	xGetPropEvt					= 1202;							{  get a window property  }
	xCursorWithin				= 1300;							{  cursor is within the window  }
	xMenuEvt					= 1400;							{  user has selected an item in your menu  }
	xMBarClickedEvt				= 1401;							{  a menu is about to be shown--update if needed  }
	xShowWatchInfoEvt			= 1501;							{  for variable and message watchers  }
	xScriptErrorEvt				= 1502;							{  place the insertion point  }
	xDebugErrorEvt				= 1503;							{  user clicked "Debug" at a complaint  }
	xDebugStepEvt				= 1504;							{  hilite the line  }
	xDebugTraceEvt				= 1505;							{  same as step but tracing  }
	xDebugFinishedEvt			= 1506;							{  script ended  }

	paletteProc					= 2048;							{  Windoid with grow box  }
	palNoGrowProc				= 2052;							{  standard Windoid defproc  }
	palZoomProc					= 2056;							{  Windoid with zoom and grow  }
	palZoomNoGrow				= 2060;							{  Windoid with zoom and no grow  }

	hasZoom						= 8;
	hasTallTBar					= 2;
	toggleHilite				= 1;

	{	 paramCount is set to these constants when first calling special XThings 	}
	xMessageWatcherID			= -2;
	xVariableWatcherID			= -3;
	xScriptEditorID				= -4;
	xDebuggerID					= -5;

	{	 XTalkObjectPtr->objectKind values 	}
	stackObj					= 1;
	bkgndObj					= 2;
	cardObj						= 3;
	fieldObj					= 4;
	buttonObj					= 5;

	{	 selectors for ShowHCAlert's dialogs (shown as buttonID:buttonText) 	}
	errorDlgID					= 1;							{  1:OK (default)  }
	confirmDlgID				= 2;							{  1:OK (default) and 2:Cancel  }
	confirmDelDlgID				= 3;							{  1:Cancel (default) and 2:Delete  }
	yesNoCancelDlgID			= 4;							{  1:Yes (default), 2:Cancel, and 3:No  }


	{	 type definitions 	}

TYPE
	XCmdBlockPtr = ^XCmdBlock;
	XCmdBlock = RECORD
		paramCount:				INTEGER;								{  If = -1 then new use for XWindoids  }
		params:					ARRAY [1..16] OF Handle;
		returnValue:			Handle;
		passFlag:				BOOLEAN;
		filler1:				SignedByte;
		entryPoint:				UniversalProcPtr;						{  to call back to HyperCard  }
		request:				INTEGER;
		result:					INTEGER;
		inArgs:					ARRAY [1..8] OF LONGINT;
		outArgs:				ARRAY [1..4] OF LONGINT;
	END;

	XCmdPtr								= ^XCmdBlock;

	XWEventInfoPtr = ^XWEventInfo;
	XWEventInfo = RECORD
		event:					EventRecord;
		eventWindow:			WindowRef;
		eventParams:			ARRAY [1..9] OF LONGINT;
		eventResult:			Handle;
	END;

	XTalkObjectPtr = ^XTalkObject;
	XTalkObject = RECORD
		objectKind:				INTEGER;								{  stack, bkgnd, card, field, or button  }
		stackNum:				LONGINT;								{  reference number of the source stack  }
		bkgndID:				LONGINT;
		cardID:					LONGINT;
		buttonID:				LONGINT;
		fieldID:				LONGINT;
	END;

	{	 maximum number of checkpoints in a script 	}

CONST
	maxCachedChecks				= 16;


TYPE
	CheckPtsPtr = ^CheckPts;
	CheckPts = RECORD
		checks:					ARRAY [1..16] OF INTEGER;
	END;

	CheckPtPtr							= ^CheckPts;
	CheckPtHandle						= ^CheckPtPtr;
	{	
	        HyperTalk Utilities  
		}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  EvalExpr()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION EvalExpr(paramPtr: XCmdPtr; expr: Str255): Handle;

{
 *  SendCardMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SendCardMessage(paramPtr: XCmdPtr; msg: Str255);

{
 *  SendHCMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SendHCMessage(paramPtr: XCmdPtr; msg: Str255);

{
 *  RunHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE RunHandler(paramPtr: XCmdPtr; handler: Handle);


{
        Memory Utilities  
}
{
 *  GetGlobal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetGlobal(paramPtr: XCmdPtr; globName: Str255): Handle;

{
 *  SetGlobal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetGlobal(paramPtr: XCmdPtr; globName: Str255; globValue: Handle);

{
 *  ZeroBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ZeroBytes(paramPtr: XCmdPtr; dstPtr: UNIV Ptr; longCount: LONGINT);


{
        String Utilities  
}
{
 *  ScanToReturn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ScanToReturn(paramPtr: XCmdPtr; VAR scanPtr: Ptr);

{
 *  ScanToZero()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ScanToZero(paramPtr: XCmdPtr; VAR scanPtr: Ptr);

{
 *  StringEqual()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION StringEqual(paramPtr: XCmdPtr; str1: Str255; str2: Str255): BOOLEAN;

{
 *  StringLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION StringLength(paramPtr: XCmdPtr; strPtr: UNIV Ptr): LONGINT;

{
 *  StringMatch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION StringMatch(paramPtr: XCmdPtr; pattern: Str255; target: UNIV Ptr): Ptr;

{
 *  ZeroTermHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ZeroTermHandle(paramPtr: XCmdPtr; hndl: Handle);


{
        String Conversions  
}
{
 *  BoolToStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE BoolToStr(paramPtr: XCmdPtr; value: BOOLEAN; VAR str: Str255);

{
 *  Double_tToStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE Double_tToStr(paramPtr: XCmdPtr; num: double_t; VAR str: Str255);

{
 *  LongToStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE LongToStr(paramPtr: XCmdPtr; posNum: LONGINT; VAR str: Str255);

{
 *  NumToHex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE NumToHex(paramPtr: XCmdPtr; num: LONGINT; nDigits: INTEGER; VAR str: Str255);

{
 *  NumToStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE NumToStr(paramPtr: XCmdPtr; num: LONGINT; VAR str: Str255);

{
 *  PasToZero()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION PasToZero(paramPtr: XCmdPtr; str: Str255): Handle;

{
 *  PointToStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE PointToStr(paramPtr: XCmdPtr; pt: Point; VAR str: Str255);

{
 *  RectToStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE RectToStr(paramPtr: XCmdPtr; {CONST}VAR rct: Rect; VAR str: Str255);

{
 *  ReturnToPas()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ReturnToPas(paramPtr: XCmdPtr; zeroStr: UNIV Ptr; VAR pasStr: Str255);

{
 *  StrToBool()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION StrToBool(paramPtr: XCmdPtr; str: Str255): BOOLEAN;

{
 *  StrToDouble_t()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION StrToDouble_t(paramPtr: XCmdPtr; str: Str255): double_t;

{
 *  StrToLong()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION StrToLong(paramPtr: XCmdPtr; str: Str255): LONGINT;

{
 *  StrToNum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION StrToNum(paramPtr: XCmdPtr; str: Str255): LONGINT;

{
 *  StrToPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE StrToPoint(paramPtr: XCmdPtr; str: Str255; VAR pt: Point);

{
 *  StrToRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE StrToRect(paramPtr: XCmdPtr; str: Str255; VAR rct: Rect);

{
 *  ZeroToPas()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ZeroToPas(paramPtr: XCmdPtr; zeroStr: UNIV Ptr; VAR pasStr: Str255);


{
        Field Utilities  
}
{
 *  GetFieldByID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetFieldByID(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldID: INTEGER): Handle;

{
 *  GetFieldByName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetFieldByName(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldName: Str255): Handle;

{
 *  GetFieldByNum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetFieldByNum(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldNum: INTEGER): Handle;

{
 *  SetFieldByID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetFieldByID(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldID: INTEGER; fieldVal: Handle);

{
 *  SetFieldByName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetFieldByName(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldName: Str255; fieldVal: Handle);

{
 *  SetFieldByNum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetFieldByNum(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldNum: INTEGER; fieldVal: Handle);

{
 *  GetFieldTE()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetFieldTE(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldID: INTEGER; fieldNum: INTEGER; fieldName: Str255): TEHandle;

{
 *  SetFieldTE()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetFieldTE(paramPtr: XCmdPtr; cardFieldFlag: BOOLEAN; fieldID: INTEGER; fieldNum: INTEGER; fieldName: Str255; fieldTE: TEHandle);


{
        Miscellaneous Utilities  
}
{
 *  BeginXSound()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE BeginXSound(paramPtr: XCmdPtr; window: WindowRef);

{
 *  EndXSound()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE EndXSound(paramPtr: XCmdPtr);

{
 *  GetFilePath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetFilePath(paramPtr: XCmdPtr; fileName: Str255; numTypes: INTEGER; typeList: ConstSFTypeListPtr; askUser: BOOLEAN; VAR fileType: OSType; VAR fullName: Str255): BOOLEAN;

{
 *  GetXResInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetXResInfo(paramPtr: XCmdPtr; VAR resFile: INTEGER; VAR resID: INTEGER; VAR rType: ResType; VAR name: Str255);

{
 *  Notify()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE Notify(paramPtr: XCmdPtr);

{
 *  SendHCEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SendHCEvent(paramPtr: XCmdPtr; {CONST}VAR event: EventRecord);

{
 *  SendWindowMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SendWindowMessage(paramPtr: XCmdPtr; windPtr: WindowRef; windowName: Str255; msg: Str255);

{
 *  FrontDocWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION FrontDocWindow(paramPtr: XCmdPtr): WindowRef;

{
 *  StackNameToNum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION StackNameToNum(paramPtr: XCmdPtr; stackName: Str255): LONGINT;

{
 *  ShowHCAlert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION ShowHCAlert(paramPtr: XCmdPtr; dlgID: INTEGER; promptStr: Str255): INTEGER;

{
 *  AbortInQueue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AbortInQueue(paramPtr: XCmdPtr): BOOLEAN;

{
 *  FlushStackFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FlushStackFile(paramPtr: XCmdPtr);


{
        Creating and Disposing XWindoids  
}
{
 *  NewXWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewXWindow(paramPtr: XCmdPtr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; procID: INTEGER; color: BOOLEAN; floating: BOOLEAN): WindowRef;

{
 *  GetNewXWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetNewXWindow(paramPtr: XCmdPtr; templateType: ResType; templateID: INTEGER; color: BOOLEAN; floating: BOOLEAN): WindowRef;

{
 *  CloseXWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CloseXWindow(paramPtr: XCmdPtr; window: WindowRef);

{
        XWindoid Utilities  
}
{
 *  HideHCPalettes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE HideHCPalettes(paramPtr: XCmdPtr);

{
 *  ShowHCPalettes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ShowHCPalettes(paramPtr: XCmdPtr);

{
 *  RegisterXWMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE RegisterXWMenu(paramPtr: XCmdPtr; window: WindowRef; menu: MenuRef; registering: BOOLEAN);

{
 *  SetXWIdleTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetXWIdleTime(paramPtr: XCmdPtr; window: WindowRef; interval: LONGINT);

{
 *  XWHasInterruptCode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE XWHasInterruptCode(paramPtr: XCmdPtr; window: WindowRef; haveCode: BOOLEAN);

{
 *  XWAlwaysMoveHigh()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE XWAlwaysMoveHigh(paramPtr: XCmdPtr; window: WindowRef; moveHigh: BOOLEAN);

{
 *  XWAllowReEntrancy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE XWAllowReEntrancy(paramPtr: XCmdPtr; window: WindowRef; allowSysEvts: BOOLEAN; allowHCEvts: BOOLEAN);


{
        Text Editing Utilities  
}
{
 *  BeginXWEdit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE BeginXWEdit(paramPtr: XCmdPtr; window: WindowRef);

{
 *  EndXWEdit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE EndXWEdit(paramPtr: XCmdPtr; window: WindowRef);

{
 *  HCWordBreakProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HCWordBreakProc(paramPtr: XCmdPtr): WordBreakUPP;

{
 *  PrintTEHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE PrintTEHandle(paramPtr: XCmdPtr; hTE: TEHandle; header: StringPtr);


{
        Script Editor support  
}
{
 *  GetCheckPoints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetCheckPoints(paramPtr: XCmdPtr): CheckPtHandle;

{
 *  SetCheckPoints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetCheckPoints(paramPtr: XCmdPtr; checkLines: CheckPtHandle);

{
 *  FormatScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE FormatScript(paramPtr: XCmdPtr; scriptHndl: Handle; VAR insertionPoint: LONGINT; quickFormat: BOOLEAN);

{
 *  SaveXWScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SaveXWScript(paramPtr: XCmdPtr; scriptHndl: Handle);

{
 *  GetObjectName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetObjectName(paramPtr: XCmdPtr; xObjPtr: XTalkObjectPtr; VAR objName: Str255);

{
 *  GetObjectScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetObjectScript(paramPtr: XCmdPtr; xObjPtr: XTalkObjectPtr; VAR scriptHndl: Handle);

{
 *  SetObjectScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetObjectScript(paramPtr: XCmdPtr; xObjPtr: XTalkObjectPtr; scriptHndl: Handle);


{
        Debugging Tools support  
}
{
 *  AbortScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE AbortScript(paramPtr: XCmdPtr);

{
 *  GoScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GoScript(paramPtr: XCmdPtr);

{
 *  StepScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE StepScript(paramPtr: XCmdPtr; stepInto: BOOLEAN);

{
 *  CountHandlers()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CountHandlers(paramPtr: XCmdPtr; VAR handlerCount: INTEGER);

{
 *  GetHandlerInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetHandlerInfo(paramPtr: XCmdPtr; handlerNum: INTEGER; VAR handlerName: Str255; VAR objectName: Str255; VAR varCount: INTEGER);

{
 *  GetVarInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetVarInfo(paramPtr: XCmdPtr; handlerNum: INTEGER; varNum: INTEGER; VAR varName: Str255; VAR isGlobal: BOOLEAN; VAR varValue: Str255; varHndl: Handle);

{
 *  SetVarValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetVarValue(paramPtr: XCmdPtr; handlerNum: INTEGER; varNum: INTEGER; varHndl: Handle);

{
 *  GetStackCrawl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetStackCrawl(paramPtr: XCmdPtr): Handle;

{
 *  TraceScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE TraceScript(paramPtr: XCmdPtr; traceInto: BOOLEAN);

{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := HyperXCmdIncludes}

{$ENDC} {__HYPERXCMD__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

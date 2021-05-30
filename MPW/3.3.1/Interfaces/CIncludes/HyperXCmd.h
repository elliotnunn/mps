/*
 	File:		HyperXCmd.h
 
 	Copyright:	© 1984-1994 by Apple Computer, Inc.
 				All rights reserved.
 
*/

#ifndef __HYPERXCMD__
#define __HYPERXCMD__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __EVENTS__
#include <Events.h>
#endif
/*	#include <Quickdraw.h>										*/
/*		#include <MixedMode.h>									*/
/*			#include <Traps.h>									*/
/*		#include <QuickdrawText.h>								*/
/*			#include <IntlResources.h>							*/
/*	#include <OSUtils.h>										*/

#ifndef __TEXTEDIT__
#include <TextEdit.h>
#endif

#ifndef __MENUS__
#include <Menus.h>
#endif

#ifndef __STANDARDFILE__
#include <StandardFile.h>
#endif
/*	#include <Dialogs.h>										*/
/*		#include <Windows.h>									*/
/*			#include <Controls.h>								*/
/*	#include <Files.h>											*/
/*		#include <SegLoad.h>									*/

/* result codes */
enum {
	xresSucc	=	0,
	xresFail	=	1,
	xresNotImp	=	2
};

/* XCMDBlock constants for event.what... */
enum {
	xOpenEvt				= 1000,	/* the first event after you are created */
	xCloseEvt				= 1001,	/* your window is being forced close (Quit?) */
	xGiveUpEditEvt			= 1002,	/* you are losing Edit... */
	xGiveUpSoundEvt			= 1003,	/* you are losing the sound channel... */
	xHidePalettesEvt		= 1004,	/* someone called HideHCPalettes */
	xShowPalettesEvt		= 1005,	/* someone called ShowHCPalettes */
	xEditUndo				= 1100,	/* Edit——Undo */
	xEditCut				= 1102,	/* Edit——Cut */
	xEditCopy				= 1103,	/* Edit——Copy */
	xEditPaste				= 1104,	/* Edit——Paste */
	xEditClear				= 1105,	/* Edit——Clear */
	xSendEvt				= 1200,	/* script has sent you a message (text) */
	xSetPropEvt				= 1201,	/* set a window property */
	xGetPropEvt				= 1202,	/* get a window property */
	xCursorWithin			= 1300,	/* cursor is within the window */
	xMenuEvt				= 1400,	/* user has selected an item in your menu */
	xMBarClickedEvt			= 1401,	/* a menu is about to be shown--update if needed */

	xShowWatchInfoEvt		= 1501,	/* for variable and message watchers */
	xScriptErrorEvt			= 1502,	/* place the insertion point */
	xDebugErrorEvt			= 1503,	/* user clicked "Debug" at a complaint */
	xDebugStepEvt			= 1504,	/* hilite the line */
	xDebugTraceEvt			= 1505,	/* same as step but tracing */
	xDebugFinishedEvt		= 1506	/* script ended */
};

enum {
	paletteProc				= 2048,	/* Windoid with grow box */
	palNoGrowProc			= 2052,	/* standard Windoid defproc */
	palZoomProc				= 2056,	/* Windoid with zoom and grow */
	palZoomNoGrow			= 2060,	/* Windoid with zoom and no grow */
	hasZoom					= 8,
	hasTallTBar				= 2,
	toggleHilite			= 1
};

enum {
	/* paramCount is set to these constants when first calling special XThings */
	xMessageWatcherID 		= -2,
	xVariableWatcherID 		= -3,
	xScriptEditorID 		= -4,
	xDebuggerID 			= -5,

	/* XTalkObjectPtr->objectKind values */
	stackObj 				= 1,
	bkgndObj 				= 2,
	cardObj 				= 3,
	fieldObj 				= 4,
	buttonObj 				= 5
};

/* maximum number of checkpoints in a script */
#define	maxCachedChecks 	16

typedef struct XCmdBlock *XCmdPtr;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct XCmdBlock {
	short							paramCount;					/* If = -1 then new use for XWindoids */
	Handle							params[16];
	Handle							returnValue;
	Boolean							passFlag;
	Ptr								entryPoint;					/* to call back to HyperCard */
	short							request;
	short							result;
	long							inArgs[8];
	long							outArgs[4];
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct XWEventInfo *XWEventInfoPtr;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct XWEventInfo {
	EventRecord						event;
	WindowPtr						eventWindow;
	long							eventParams[9];
	Handle							eventResult;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct XTalkObject *XTalkObjectPtr;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct XTalkObject {
	short							objectKind;					/* stack, bkgnd, card, field, or button */
	long							stackNum;					/* reference number of the source stack */
	long							bkgndID;
	long							cardID;
	long							buttonID;
	long							fieldID;
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif

typedef struct CheckPts *CheckPtPtr;

typedef CheckPtPtr *CheckPtHandle;

#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
struct CheckPts {
	short							checks[maxCachedChecks];
};
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif


#ifdef __cplusplus
extern "C" {
#endif

/****  HyperTalk Utilities  ****/

extern pascal Handle EvalExpr(XCmdPtr paramPtr, StringPtr expr);
extern pascal void SendCardMessage(XCmdPtr paramPtr, StringPtr msg);
extern pascal void SendHCMessage(XCmdPtr paramPtr, StringPtr msg);
extern pascal void RunHandler(XCmdPtr paramPtr, Handle handler);

/****  Memory Utilities  ****/

extern pascal Handle GetGlobal(XCmdPtr paramPtr, StringPtr globName);
extern pascal void SetGlobal(XCmdPtr paramPtr, StringPtr globName, Handle globValue);
extern pascal void ZeroBytes(XCmdPtr paramPtr, Ptr dstPtr, long longCount);

/****  String Utilities  ****/

extern pascal void ScanToReturn(XCmdPtr paramPtr, Ptr *scanPtr);
extern pascal void ScanToZero(XCmdPtr paramPtr, Ptr *scanPtr);
extern pascal Boolean StringEqual(XCmdPtr paramPtr, StringPtr str1, StringPtr str2);
extern pascal long StringLength(XCmdPtr paramPtr, Ptr strPtr);
extern pascal Ptr StringMatch(XCmdPtr paramPtr, StringPtr pattern, Ptr target);
extern pascal void ZeroTermHandle(XCmdPtr paramPtr, Handle hndl);

/****  String Conversions  ****/

extern pascal void BoolToStr(XCmdPtr paramPtr, Boolean bool, StringPtr str);
extern pascal void ExtToStr(XCmdPtr paramPtr, extended80 num, StringPtr str);
extern pascal void LongToStr(XCmdPtr paramPtr, long posNum, StringPtr str);
extern pascal void NumToHex(XCmdPtr paramPtr, long num, short nDigits, StringPtr str);
extern pascal void NumToStr(XCmdPtr paramPtr, long num, StringPtr str);
extern pascal Handle PasToZero(XCmdPtr paramPtr, StringPtr str);
extern pascal void PointToStr(XCmdPtr paramPtr, Point pt, StringPtr str);
extern pascal void RectToStr(XCmdPtr paramPtr, Rect *rct, StringPtr str);
extern pascal void ReturnToPas(XCmdPtr paramPtr, Ptr zeroStr, StringPtr pasStr);
extern pascal Boolean StrToBool(XCmdPtr paramPtr, StringPtr str);
extern pascal extended80 StrToExt(XCmdPtr paramPtr, StringPtr str);
extern pascal long StrToLong(XCmdPtr paramPtr, StringPtr str);
extern pascal long StrToNum(XCmdPtr paramPtr, StringPtr str);
extern pascal void StrToPoint(XCmdPtr paramPtr, StringPtr str, Point *pt);
extern pascal void StrToRect(XCmdPtr paramPtr, StringPtr str, Rect *rct);
extern pascal void ZeroToPas(XCmdPtr paramPtr, Ptr zeroStr, StringPtr pasStr);

/****  Field Utilities  ****/

extern pascal Handle GetFieldByID(XCmdPtr paramPtr, Boolean cardFieldFlag, short fieldID);
extern pascal Handle GetFieldByName(XCmdPtr paramPtr, Boolean cardFieldFlag, StringPtr fieldName);
extern pascal Handle GetFieldByNum(XCmdPtr paramPtr, Boolean cardFieldFlag, short fieldNum);
extern pascal void SetFieldByID(XCmdPtr paramPtr, Boolean cardFieldFlag, short fieldID, Handle fieldVal);
extern pascal void SetFieldByName(XCmdPtr paramPtr, Boolean cardFieldFlag, StringPtr fieldName, Handle fieldVal);
extern pascal void SetFieldByNum(XCmdPtr paramPtr, Boolean cardFieldFlag, short fieldNum, Handle fieldVal);
extern pascal TEHandle GetFieldTE(XCmdPtr paramPtr, Boolean cardFieldFlag, short fieldID, short fieldNum, StringPtr fieldNamePtr);
extern pascal void SetFieldTE(XCmdPtr paramPtr, Boolean cardFieldFlag, short fieldID, short fieldNum, StringPtr fieldNamePtr, TEHandle fieldTE);

/****  Miscellaneous Utilities  ****/

extern pascal void BeginXSound(XCmdPtr paramPtr, WindowPtr window);
extern pascal void EndXSound(XCmdPtr paramPtr);
extern pascal Boolean GetFilePath(XCmdPtr paramPtr, StringPtr fileName, short numTypes, SFTypeList typeList, Boolean askUser, OSType *fileType, StringPtr fullName);
extern pascal void GetXResInfo(XCmdPtr paramPtr, short *resFile, short *resID, ResType *rType, StringPtr name);
extern pascal void Notify(XCmdPtr paramPtr);
extern pascal void SendHCEvent(XCmdPtr paramPtr, EventRecord *event);
extern pascal void SendWindowMessage(XCmdPtr paramPtr, WindowPtr windPtr, StringPtr windowName, Handle msg);
extern pascal WindowPtr FrontDocWindow(XCmdPtr paramPtr);
extern pascal long StackNameToNum(XCmdPtr paramPtr, StringPtr stackName);
extern pascal short ShowHCAlert(XCmdPtr paramPtr, short dlgID, StringPtr promptStr);

/****  Creating and Disposing XWindoids  ****/

extern pascal WindowPtr NewXWindow(XCmdPtr paramPtr, Rect *boundsRect, StringPtr title, Boolean visible, short procID, Boolean color, Boolean floating);
extern pascal WindowPtr GetNewXWindow(XCmdPtr paramPtr, ResType templateType, short templateID, Boolean color, Boolean floating);
extern pascal void CloseXWindow(XCmdPtr paramPtr, WindowPtr window);

/****  XWindoid Utilities  ****/

extern pascal void HideHCPalettes(XCmdPtr paramPtr);
extern pascal void ShowHCPalettes(XCmdPtr paramPtr);
extern pascal void RegisterXWMenu(XCmdPtr paramPtr, WindowPtr window, MenuHandle menu, Boolean registering);
extern pascal void SetXWIdleTime(XCmdPtr paramPtr, WindowPtr window, long interval);
extern pascal void XWHasInterruptCode(XCmdPtr paramPtr, WindowPtr window, Boolean haveCode);
extern pascal void XWAlwaysMoveHigh(XCmdPtr paramPtr, WindowPtr window, Boolean moveHigh);
extern pascal void XWAllowReEntrancy(XCmdPtr paramPtr, WindowPtr window, Boolean allowSysEvts, Boolean allowHCEvts);

/****  Text Editing Utilities  ****/

extern pascal void BeginXWEdit(XCmdPtr paramPtr, WindowPtr window);
extern pascal void EndXWEdit(XCmdPtr paramPtr, WindowPtr window);
extern pascal Ptr HCWordBreakProc(XCmdPtr paramPtr);
extern pascal void PrintTEHandle(XCmdPtr paramPtr, TEHandle hTE, StringPtr header);

/****  Script Editor support  ****/

extern pascal CheckPtHandle GetCheckPoints(XCmdPtr paramPtr);
extern pascal void SetCheckPoints(XCmdPtr paramPtr, CheckPtHandle checkLines);
extern pascal void FormatScript(XCmdPtr paramPtr, Handle scriptHndl, long *insertionPoint, Boolean quickFormat);
extern pascal void SaveXWScript(XCmdPtr paramPtr, Handle scriptHndl);
extern pascal void GetObjectName(XCmdPtr paramPtr, XTalkObjectPtr object, StringPtr objName);
extern pascal void GetObjectScript(XCmdPtr paramPtr, XTalkObjectPtr object, Handle *scriptHndl);
extern pascal void SetObjectScript(XCmdPtr paramPtr, XTalkObjectPtr object, Handle scriptHndl);

/****  Debugging Tools support  ****/

extern pascal void AbortScript(XCmdPtr paramPtr);
extern pascal void GoScript(XCmdPtr paramPtr);
extern pascal void StepScript(XCmdPtr paramPtr, Boolean stepInto);
extern pascal void CountHandlers(XCmdPtr paramPtr, short *handlerCount);
extern pascal void GetHandlerInfo(XCmdPtr paramPtr, short handlerNum, StringPtr handlerName, StringPtr objectName, short *varCount);
extern pascal void GetVarInfo(XCmdPtr paramPtr, short handlerNum, short varNum, StringPtr varName, Boolean *isGlobal, StringPtr varValue, Handle varHndl);
extern pascal void SetVarValue(XCmdPtr paramPtr, short handlerNum, short varNum, Handle varHndl);
extern pascal Handle GetStackCrawl(XCmdPtr paramPtr);
extern pascal void TraceScript(XCmdPtr paramPtr, Boolean traceInto);

#ifdef __cplusplus
}
#endif

#endif /* __HYPERXCMD__ */

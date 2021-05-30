/*
 	File:		HyperXCmd.h
 
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
/*		#include <QuickdrawText.h>								*/
/*	#include <OSUtils.h>										*/
/*		#include <Memory.h>										*/
/*		#include <Patches.h>									*/

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
/*		#include <Errors.h>										*/
/*		#include <Controls.h>									*/
/*		#include <Windows.h>									*/
/*	#include <Files.h>											*/
/*		#include <Finder.h>										*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

/* result codes */

enum {
	xresSucc					= 0,
	xresFail					= 1,
	xresNotImp					= 2
};

/* XCMDBlock constants for event.what... */
enum {
	xOpenEvt					= 1000,							/* the first event after you are created */
	xCloseEvt					= 1001,							/* your window is being forced close (Quit?) */
	xGiveUpEditEvt				= 1002,							/* you are losing Edit... */
	xGiveUpSoundEvt				= 1003,							/* you are losing the sound channel... */
	xHidePalettesEvt			= 1004,							/* someone called HideHCPalettes */
	xShowPalettesEvt			= 1005,							/* someone called ShowHCPalettes */
	xEditUndo					= 1100,							/* Edit——Undo */
	xEditCut					= 1102,							/* Edit——Cut */
	xEditCopy					= 1103,							/* Edit——Copy */
	xEditPaste					= 1104,							/* Edit——Paste */
	xEditClear					= 1105,							/* Edit——Clear */
	xSendEvt					= 1200,							/* script has sent you a message (text) */
	xSetPropEvt					= 1201,							/* set a window property */
	xGetPropEvt					= 1202,							/* get a window property */
	xCursorWithin				= 1300,							/* cursor is within the window */
	xMenuEvt					= 1400,							/* user has selected an item in your menu */
	xMBarClickedEvt				= 1401,							/* a menu is about to be shown--update if needed */
	xShowWatchInfoEvt			= 1501,							/* for variable and message watchers */
	xScriptErrorEvt				= 1502,							/* place the insertion point */
	xDebugErrorEvt				= 1503,							/* user clicked "Debug" at a complaint */
	xDebugStepEvt				= 1504,							/* hilite the line */
	xDebugTraceEvt				= 1505,							/* same as step but tracing */
	xDebugFinishedEvt			= 1506							/* script ended */
};

enum {
	paletteProc					= 2048,							/* Windoid with grow box */
	palNoGrowProc				= 2052,							/* standard Windoid defproc */
	palZoomProc					= 2056,							/* Windoid with zoom and grow */
	palZoomNoGrow				= 2060,							/* Windoid with zoom and no grow */
	hasZoom						= 8,
	hasTallTBar					= 2,
	toggleHilite				= 1
};

/* paramCount is set to these constants when first calling special XThings */
enum {
	xMessageWatcherID			= -2,
	xVariableWatcherID			= -3,
	xScriptEditorID				= -4,
	xDebuggerID					= -5
};

/* XTalkObjectPtr->objectKind values */
enum {
	stackObj					= 1,
	bkgndObj					= 2,
	cardObj						= 3,
	fieldObj					= 4,
	buttonObj					= 5
};

/* selectors for ShowHCAlert's dialogs (shown as buttonID:buttonText) */
enum {
	errorDlgID					= 1,							/* 1:OK (default) */
	confirmDlgID				= 2,							/* 1:OK (default) and 2:Cancel */
	confirmDelDlgID				= 3,							/* 1:Cancel (default) and 2:Delete */
	yesNoCancelDlgID			= 4								/* 1:Yes (default), 2:Cancel, and 3:No */
};

/* type definitions */
struct XCmdBlock {
	short							paramCount;					/* If = -1 then new use for XWindoids */
	Handle							params[16];
	Handle							returnValue;
	Boolean							passFlag;
	SignedByte						filler1;
	UniversalProcPtr				entryPoint;					/* to call back to HyperCard */
	short							request;
	short							result;
	long							inArgs[8];
	long							outArgs[4];
};
typedef struct XCmdBlock XCmdBlock;

typedef XCmdBlock *XCmdPtr;

struct XWEventInfo {
	EventRecord						event;
	WindowPtr						eventWindow;
	long							eventParams[9];
	Handle							eventResult;
};
typedef struct XWEventInfo XWEventInfo;

typedef XWEventInfo *XWEventInfoPtr;

struct XTalkObject {
	short							objectKind;					/* stack, bkgnd, card, field, or button */
	long							stackNum;					/* reference number of the source stack */
	long							bkgndID;
	long							cardID;
	long							buttonID;
	long							fieldID;
};
typedef struct XTalkObject XTalkObject;

typedef XTalkObject *XTalkObjectPtr;

/* maximum number of checkpoints in a script */

enum {
	maxCachedChecks				= 16
};

struct CheckPts {
	short							checks[16];
};
typedef struct CheckPts CheckPts;

typedef CheckPts *CheckPtPtr;

typedef CheckPtPtr *CheckPtHandle;

/*
		HyperTalk Utilities  
*/
extern pascal Handle EvalExpr(XCmdPtr paramPtr, ConstStr255Param expr);
extern pascal void SendCardMessage(XCmdPtr paramPtr, ConstStr255Param msg);
extern pascal void SendHCMessage(XCmdPtr paramPtr, ConstStr255Param msg);
extern pascal void RunHandler(XCmdPtr paramPtr, Handle handler);
/*
		Memory Utilities  
*/
extern pascal Handle GetGlobal(XCmdPtr paramPtr, ConstStr255Param globName);
extern pascal void SetGlobal(XCmdPtr paramPtr, ConstStr255Param globName, Handle globValue);
extern pascal void ZeroBytes(XCmdPtr paramPtr, void *dstPtr, long longCount);
/*
		String Utilities  
*/
extern pascal void ScanToReturn(XCmdPtr paramPtr, Ptr *scanPtr);
extern pascal void ScanToZero(XCmdPtr paramPtr, Ptr *scanPtr);
extern pascal Boolean StringEqual(XCmdPtr paramPtr, ConstStr255Param str1, ConstStr255Param str2);
extern pascal long StringLength(XCmdPtr paramPtr, void *strPtr);
extern pascal void *StringMatch(XCmdPtr paramPtr, ConstStr255Param pattern, void *target);
extern pascal void ZeroTermHandle(XCmdPtr paramPtr, Handle hndl);
/*
		String Conversions  
*/
extern pascal void BoolToStr(XCmdPtr paramPtr, Boolean bool, Str255 str);
extern pascal void Double_tToStr(XCmdPtr paramPtr, double_t num, Str255 str);
extern pascal void LongToStr(XCmdPtr paramPtr, long posNum, Str255 str);
extern pascal void NumToHex(XCmdPtr paramPtr, long num, short nDigits, Str255 str);
extern pascal void NumToStr(XCmdPtr paramPtr, long num, Str255 str);
extern pascal Handle PasToZero(XCmdPtr paramPtr, ConstStr255Param str);
extern pascal void PointToStr(XCmdPtr paramPtr, Point pt, Str255 str);
extern pascal void RectToStr(XCmdPtr paramPtr, const Rect *rct, Str255 str);
extern pascal void ReturnToPas(XCmdPtr paramPtr, void *zeroStr, Str255 pasStr);
extern pascal Boolean StrToBool(XCmdPtr paramPtr, ConstStr255Param str);
extern pascal double_t StrToDouble_t(XCmdPtr paramPtr, ConstStr255Param str);
extern pascal long StrToLong(XCmdPtr paramPtr, ConstStr255Param str);
extern pascal long StrToNum(XCmdPtr paramPtr, ConstStr255Param str);
extern pascal void StrToPoint(XCmdPtr paramPtr, ConstStr255Param str, Point *pt);
extern pascal void StrToRect(XCmdPtr paramPtr, ConstStr255Param str, Rect *rct);
extern pascal void ZeroToPas(XCmdPtr paramPtr, void *zeroStr, Str255 pasStr);
/*
		Field Utilities  
*/
extern pascal Handle GetFieldByID(XCmdPtr paramPtr, Boolean cardFieldFlag, short fieldID);
extern pascal Handle GetFieldByName(XCmdPtr paramPtr, Boolean cardFieldFlag, ConstStr255Param fieldName);
extern pascal Handle GetFieldByNum(XCmdPtr paramPtr, Boolean cardFieldFlag, short fieldNum);
extern pascal void SetFieldByID(XCmdPtr paramPtr, Boolean cardFieldFlag, short fieldID, Handle fieldVal);
extern pascal void SetFieldByName(XCmdPtr paramPtr, Boolean cardFieldFlag, ConstStr255Param fieldName, Handle fieldVal);
extern pascal void SetFieldByNum(XCmdPtr paramPtr, Boolean cardFieldFlag, short fieldNum, Handle fieldVal);
extern pascal TEHandle GetFieldTE(XCmdPtr paramPtr, Boolean cardFieldFlag, short fieldID, short fieldNum, ConstStr255Param fieldName);
extern pascal void SetFieldTE(XCmdPtr paramPtr, Boolean cardFieldFlag, short fieldID, short fieldNum, ConstStr255Param fieldName, TEHandle fieldTE);
/*
		Miscellaneous Utilities  
*/
extern pascal void BeginXSound(XCmdPtr paramPtr, WindowPtr window);
extern pascal void EndXSound(XCmdPtr paramPtr);
extern pascal Boolean GetFilePath(XCmdPtr paramPtr, ConstStr255Param fileName, short numTypes, ConstSFTypeListPtr typeList, Boolean askUser, OSType *fileType, Str255 fullName);
extern pascal void GetXResInfo(XCmdPtr paramPtr, short *resFile, short *resID, ResType *rType, Str255 name);
extern pascal void Notify(XCmdPtr paramPtr);
extern pascal void SendHCEvent(XCmdPtr paramPtr, const EventRecord *event);
extern pascal void SendWindowMessage(XCmdPtr paramPtr, WindowPtr windPtr, ConstStr255Param windowName, ConstStr255Param msg);
extern pascal WindowPtr FrontDocWindow(XCmdPtr paramPtr);
extern pascal long StackNameToNum(XCmdPtr paramPtr, ConstStr255Param stackName);
extern pascal short ShowHCAlert(XCmdPtr paramPtr, short dlgID, ConstStr255Param promptStr);
extern pascal Boolean AbortInQueue(XCmdPtr paramPtr);
extern pascal void FlushStackFile(XCmdPtr paramPtr);
/*
		Creating and Disposing XWindoids  
*/
extern pascal WindowPtr NewXWindow(XCmdPtr paramPtr, const Rect *boundsRect, ConstStr255Param title, Boolean visible, short procID, Boolean color, Boolean floating);
extern pascal WindowPtr GetNewXWindow(XCmdPtr paramPtr, ResType templateType, short templateID, Boolean color, Boolean floating);
extern pascal void CloseXWindow(XCmdPtr paramPtr, WindowPtr window);
/*
		XWindoid Utilities  
*/
extern pascal void HideHCPalettes(XCmdPtr paramPtr);
extern pascal void ShowHCPalettes(XCmdPtr paramPtr);
extern pascal void RegisterXWMenu(XCmdPtr paramPtr, WindowPtr window, MenuHandle menu, Boolean registering);
extern pascal void SetXWIdleTime(XCmdPtr paramPtr, WindowPtr window, long interval);
extern pascal void XWHasInterruptCode(XCmdPtr paramPtr, WindowPtr window, Boolean haveCode);
extern pascal void XWAlwaysMoveHigh(XCmdPtr paramPtr, WindowPtr window, Boolean moveHigh);
extern pascal void XWAllowReEntrancy(XCmdPtr paramPtr, WindowPtr window, Boolean allowSysEvts, Boolean allowHCEvts);
/*
		Text Editing Utilities  
*/
extern pascal void BeginXWEdit(XCmdPtr paramPtr, WindowPtr window);
extern pascal void EndXWEdit(XCmdPtr paramPtr, WindowPtr window);
extern pascal WordBreakUPP HCWordBreakProc(XCmdPtr paramPtr);
extern pascal void PrintTEHandle(XCmdPtr paramPtr, TEHandle hTE, StringPtr header);
/*
		Script Editor support  
*/
extern pascal CheckPtHandle GetCheckPoints(XCmdPtr paramPtr);
extern pascal void SetCheckPoints(XCmdPtr paramPtr, CheckPtHandle checkLines);
extern pascal void FormatScript(XCmdPtr paramPtr, Handle scriptHndl, long *insertionPoint, Boolean quickFormat);
extern pascal void SaveXWScript(XCmdPtr paramPtr, Handle scriptHndl);
extern pascal void GetObjectName(XCmdPtr paramPtr, XTalkObjectPtr xObjPtr, Str255 objName);
extern pascal void GetObjectScript(XCmdPtr paramPtr, XTalkObjectPtr xObjPtr, Handle *scriptHndl);
extern pascal void SetObjectScript(XCmdPtr paramPtr, XTalkObjectPtr xObjPtr, Handle scriptHndl);
/*
		Debugging Tools support  
*/
extern pascal void AbortScript(XCmdPtr paramPtr);
extern pascal void GoScript(XCmdPtr paramPtr);
extern pascal void StepScript(XCmdPtr paramPtr, Boolean stepInto);
extern pascal void CountHandlers(XCmdPtr paramPtr, short *handlerCount);
extern pascal void GetHandlerInfo(XCmdPtr paramPtr, short handlerNum, Str255 handlerName, Str255 objectName, short *varCount);
extern pascal void GetVarInfo(XCmdPtr paramPtr, short handlerNum, short varNum, Str255 varName, Boolean *isGlobal, Str255 varValue, Handle varHndl);
extern pascal void SetVarValue(XCmdPtr paramPtr, short handlerNum, short varNum, Handle varHndl);
extern pascal Handle GetStackCrawl(XCmdPtr paramPtr);
extern pascal void TraceScript(XCmdPtr paramPtr, Boolean traceInto);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __HYPERXCMD__ */

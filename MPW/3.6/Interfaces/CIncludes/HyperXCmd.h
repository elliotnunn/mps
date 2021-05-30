/*
     File:       HyperXCmd.h
 
     Contains:   Interfaces for HyperCard XCMD's
 
     Version:    Technology: HyperCard 2.3
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1987-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __HYPERXCMD__
#define __HYPERXCMD__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __FP__
#include <fp.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __TEXTEDIT__
#include <TextEdit.h>
#endif

#ifndef __MENUS__
#include <Menus.h>
#endif

#ifndef __STANDARDFILE__
#include <StandardFile.h>
#endif




#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
    #pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
    #pragma pack(2)
#endif

/* result codes */
enum {
  xresSucc                      = 0,
  xresFail                      = 1,
  xresNotImp                    = 2
};

/* XCMDBlock constants for event.what... */
enum {
  xOpenEvt                      = 1000, /* the first event after you are created */
  xCloseEvt                     = 1001, /* your window is being forced close (Quit?) */
  xGiveUpEditEvt                = 1002, /* you are losing Edit... */
  xGiveUpSoundEvt               = 1003, /* you are losing the sound channel... */
  xHidePalettesEvt              = 1004, /* someone called HideHCPalettes */
  xShowPalettesEvt              = 1005, /* someone called ShowHCPalettes */
  xEditUndo                     = 1100, /* Edit——Undo */
  xEditCut                      = 1102, /* Edit——Cut */
  xEditCopy                     = 1103, /* Edit——Copy */
  xEditPaste                    = 1104, /* Edit——Paste */
  xEditClear                    = 1105, /* Edit——Clear */
  xSendEvt                      = 1200, /* script has sent you a message (text) */
  xSetPropEvt                   = 1201, /* set a window property */
  xGetPropEvt                   = 1202, /* get a window property */
  xCursorWithin                 = 1300, /* cursor is within the window */
  xMenuEvt                      = 1400, /* user has selected an item in your menu */
  xMBarClickedEvt               = 1401, /* a menu is about to be shown--update if needed */
  xShowWatchInfoEvt             = 1501, /* for variable and message watchers */
  xScriptErrorEvt               = 1502, /* place the insertion point */
  xDebugErrorEvt                = 1503, /* user clicked "Debug" at a complaint */
  xDebugStepEvt                 = 1504, /* hilite the line */
  xDebugTraceEvt                = 1505, /* same as step but tracing */
  xDebugFinishedEvt             = 1506  /* script ended */
};

enum {
  paletteProc                   = 2048, /* Windoid with grow box */
  palNoGrowProc                 = 2052, /* standard Windoid defproc */
  palZoomProc                   = 2056, /* Windoid with zoom and grow */
  palZoomNoGrow                 = 2060  /* Windoid with zoom and no grow */
};

enum {
  hasZoom                       = 8,
  hasTallTBar                   = 2,
  toggleHilite                  = 1
};

/* paramCount is set to these constants when first calling special XThings */
enum {
  xMessageWatcherID             = -2,
  xVariableWatcherID            = -3,
  xScriptEditorID               = -4,
  xDebuggerID                   = -5
};

/* XTalkObjectPtr->objectKind values */
enum {
  stackObj                      = 1,
  bkgndObj                      = 2,
  cardObj                       = 3,
  fieldObj                      = 4,
  buttonObj                     = 5
};

/* selectors for ShowHCAlert's dialogs (shown as buttonID:buttonText) */
enum {
  errorDlgID                    = 1,    /* 1:OK (default) */
  confirmDlgID                  = 2,    /* 1:OK (default) and 2:Cancel */
  confirmDelDlgID               = 3,    /* 1:Cancel (default) and 2:Delete */
  yesNoCancelDlgID              = 4     /* 1:Yes (default), 2:Cancel, and 3:No */
};


/* type definitions */
struct XCmdBlock {
  short               paramCount;             /* If = -1 then new use for XWindoids */
  Handle              params[16];
  Handle              returnValue;
  Boolean             passFlag;
  SignedByte          filler1;
  UniversalProcPtr    entryPoint;             /* to call back to HyperCard */
  short               request;
  short               result;
  long                inArgs[8];
  long                outArgs[4];
};
typedef struct XCmdBlock                XCmdBlock;
typedef XCmdBlock *                     XCmdPtr;

struct XWEventInfo {
  EventRecord         event;
  WindowRef           eventWindow;
  long                eventParams[9];
  Handle              eventResult;
};
typedef struct XWEventInfo              XWEventInfo;
typedef XWEventInfo *                   XWEventInfoPtr;
struct XTalkObject {
  short               objectKind;             /* stack, bkgnd, card, field, or button */
  long                stackNum;               /* reference number of the source stack */
  long                bkgndID;
  long                cardID;
  long                buttonID;
  long                fieldID;
};
typedef struct XTalkObject              XTalkObject;
typedef XTalkObject *                   XTalkObjectPtr;
/* maximum number of checkpoints in a script */
enum {
  maxCachedChecks               = 16
};

struct CheckPts {
  short               checks[16];
};
typedef struct CheckPts                 CheckPts;
typedef CheckPts *                      CheckPtPtr;
typedef CheckPtPtr *                    CheckPtHandle;
/*
        HyperTalk Utilities  
*/
#if CALL_NOT_IN_CARBON
/*
 *  EvalExpr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
EvalExpr(
  XCmdPtr            paramPtr,
  ConstStr255Param   expr);


/*
 *  SendCardMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SendCardMessage(
  XCmdPtr            paramPtr,
  ConstStr255Param   msg);


/*
 *  SendHCMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SendHCMessage(
  XCmdPtr            paramPtr,
  ConstStr255Param   msg);


/*
 *  RunHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
RunHandler(
  XCmdPtr   paramPtr,
  Handle    handler);



/*
        Memory Utilities  
*/
/*
 *  GetGlobal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
GetGlobal(
  XCmdPtr            paramPtr,
  ConstStr255Param   globName);


/*
 *  SetGlobal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SetGlobal(
  XCmdPtr            paramPtr,
  ConstStr255Param   globName,
  Handle             globValue);


/*
 *  ZeroBytes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
ZeroBytes(
  XCmdPtr   paramPtr,
  void *    dstPtr,
  long      longCount);



/*
        String Utilities  
*/
/*
 *  ScanToReturn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
ScanToReturn(
  XCmdPtr   paramPtr,
  Ptr *     scanPtr);


/*
 *  ScanToZero()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
ScanToZero(
  XCmdPtr   paramPtr,
  Ptr *     scanPtr);


/*
 *  StringEqual()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
StringEqual(
  XCmdPtr            paramPtr,
  ConstStr255Param   str1,
  ConstStr255Param   str2);


/*
 *  StringLength()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( long )
StringLength(
  XCmdPtr   paramPtr,
  void *    strPtr);


/*
 *  StringMatch()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void * )
StringMatch(
  XCmdPtr            paramPtr,
  ConstStr255Param   pattern,
  void *             target);


/*
 *  ZeroTermHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
ZeroTermHandle(
  XCmdPtr   paramPtr,
  Handle    hndl);



/*
        String Conversions  
*/
/*
 *  BoolToStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
BoolToStr(
  XCmdPtr   paramPtr,
  Boolean   value,
  Str255    str);


/*
 *  Double_tToStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
Double_tToStr(
  XCmdPtr    paramPtr,
  double_t   num,
  Str255     str);


/*
 *  LongToStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
LongToStr(
  XCmdPtr   paramPtr,
  long      posNum,
  Str255    str);


/*
 *  NumToHex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
NumToHex(
  XCmdPtr   paramPtr,
  long      num,
  short     nDigits,
  Str255    str);


/*
 *  NumToStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
NumToStr(
  XCmdPtr   paramPtr,
  long      num,
  Str255    str);


/*
 *  PasToZero()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
PasToZero(
  XCmdPtr            paramPtr,
  ConstStr255Param   str);


/*
 *  PointToStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
PointToStr(
  XCmdPtr   paramPtr,
  Point     pt,
  Str255    str);


/*
 *  RectToStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
RectToStr(
  XCmdPtr       paramPtr,
  const Rect *  rct,
  Str255        str);


/*
 *  ReturnToPas()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
ReturnToPas(
  XCmdPtr   paramPtr,
  void *    zeroStr,
  Str255    pasStr);


/*
 *  StrToBool()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
StrToBool(
  XCmdPtr            paramPtr,
  ConstStr255Param   str);


/*
 *  StrToDouble_t()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( double_t )
StrToDouble_t(
  XCmdPtr            paramPtr,
  ConstStr255Param   str);


/*
 *  StrToLong()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( long )
StrToLong(
  XCmdPtr            paramPtr,
  ConstStr255Param   str);


/*
 *  StrToNum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( long )
StrToNum(
  XCmdPtr            paramPtr,
  ConstStr255Param   str);


/*
 *  StrToPoint()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
StrToPoint(
  XCmdPtr            paramPtr,
  ConstStr255Param   str,
  Point *            pt);


/*
 *  StrToRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
StrToRect(
  XCmdPtr            paramPtr,
  ConstStr255Param   str,
  Rect *             rct);


/*
 *  ZeroToPas()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
ZeroToPas(
  XCmdPtr   paramPtr,
  void *    zeroStr,
  Str255    pasStr);



/*
        Field Utilities  
*/
/*
 *  GetFieldByID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
GetFieldByID(
  XCmdPtr   paramPtr,
  Boolean   cardFieldFlag,
  short     fieldID);


/*
 *  GetFieldByName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
GetFieldByName(
  XCmdPtr            paramPtr,
  Boolean            cardFieldFlag,
  ConstStr255Param   fieldName);


/*
 *  GetFieldByNum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
GetFieldByNum(
  XCmdPtr   paramPtr,
  Boolean   cardFieldFlag,
  short     fieldNum);


/*
 *  SetFieldByID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SetFieldByID(
  XCmdPtr   paramPtr,
  Boolean   cardFieldFlag,
  short     fieldID,
  Handle    fieldVal);


/*
 *  SetFieldByName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SetFieldByName(
  XCmdPtr            paramPtr,
  Boolean            cardFieldFlag,
  ConstStr255Param   fieldName,
  Handle             fieldVal);


/*
 *  SetFieldByNum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SetFieldByNum(
  XCmdPtr   paramPtr,
  Boolean   cardFieldFlag,
  short     fieldNum,
  Handle    fieldVal);


/*
 *  GetFieldTE()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( TEHandle )
GetFieldTE(
  XCmdPtr            paramPtr,
  Boolean            cardFieldFlag,
  short              fieldID,
  short              fieldNum,
  ConstStr255Param   fieldName);


/*
 *  SetFieldTE()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SetFieldTE(
  XCmdPtr            paramPtr,
  Boolean            cardFieldFlag,
  short              fieldID,
  short              fieldNum,
  ConstStr255Param   fieldName,
  TEHandle           fieldTE);



/*
        Miscellaneous Utilities  
*/
/*
 *  BeginXSound()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
BeginXSound(
  XCmdPtr     paramPtr,
  WindowRef   window);


/*
 *  EndXSound()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
EndXSound(XCmdPtr paramPtr);


/*
 *  GetFilePath()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
GetFilePath(
  XCmdPtr              paramPtr,
  ConstStr255Param     fileName,
  short                numTypes,
  ConstSFTypeListPtr   typeList,
  Boolean              askUser,
  OSType *             fileType,
  Str255               fullName);


/*
 *  GetXResInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
GetXResInfo(
  XCmdPtr    paramPtr,
  short *    resFile,
  short *    resID,
  ResType *  rType,
  Str255     name);


/*
 *  Notify()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
Notify(XCmdPtr paramPtr);


/*
 *  SendHCEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SendHCEvent(
  XCmdPtr              paramPtr,
  const EventRecord *  event);


/*
 *  SendWindowMessage()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SendWindowMessage(
  XCmdPtr            paramPtr,
  WindowRef          windPtr,
  ConstStr255Param   windowName,
  ConstStr255Param   msg);


/*
 *  FrontDocWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( WindowRef )
FrontDocWindow(XCmdPtr paramPtr);


/*
 *  StackNameToNum()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( long )
StackNameToNum(
  XCmdPtr            paramPtr,
  ConstStr255Param   stackName);


/*
 *  ShowHCAlert()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( short )
ShowHCAlert(
  XCmdPtr            paramPtr,
  short              dlgID,
  ConstStr255Param   promptStr);


/*
 *  AbortInQueue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
AbortInQueue(XCmdPtr paramPtr);


/*
 *  FlushStackFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
FlushStackFile(XCmdPtr paramPtr);



/*
        Creating and Disposing XWindoids  
*/
/*
 *  NewXWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( WindowRef )
NewXWindow(
  XCmdPtr            paramPtr,
  const Rect *       boundsRect,
  ConstStr255Param   title,
  Boolean            visible,
  short              procID,
  Boolean            color,
  Boolean            floating);


/*
 *  GetNewXWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( WindowRef )
GetNewXWindow(
  XCmdPtr   paramPtr,
  ResType   templateType,
  short     templateID,
  Boolean   color,
  Boolean   floating);


/*
 *  CloseXWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
CloseXWindow(
  XCmdPtr     paramPtr,
  WindowRef   window);


/*
        XWindoid Utilities  
*/
/*
 *  HideHCPalettes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
HideHCPalettes(XCmdPtr paramPtr);


/*
 *  ShowHCPalettes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
ShowHCPalettes(XCmdPtr paramPtr);


/*
 *  RegisterXWMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
RegisterXWMenu(
  XCmdPtr     paramPtr,
  WindowRef   window,
  MenuRef     menu,
  Boolean     registering);


/*
 *  SetXWIdleTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SetXWIdleTime(
  XCmdPtr     paramPtr,
  WindowRef   window,
  long        interval);


/*
 *  XWHasInterruptCode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
XWHasInterruptCode(
  XCmdPtr     paramPtr,
  WindowRef   window,
  Boolean     haveCode);


/*
 *  XWAlwaysMoveHigh()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
XWAlwaysMoveHigh(
  XCmdPtr     paramPtr,
  WindowRef   window,
  Boolean     moveHigh);


/*
 *  XWAllowReEntrancy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
XWAllowReEntrancy(
  XCmdPtr     paramPtr,
  WindowRef   window,
  Boolean     allowSysEvts,
  Boolean     allowHCEvts);



/*
        Text Editing Utilities  
*/
/*
 *  BeginXWEdit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
BeginXWEdit(
  XCmdPtr     paramPtr,
  WindowRef   window);


/*
 *  EndXWEdit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
EndXWEdit(
  XCmdPtr     paramPtr,
  WindowRef   window);


/*
 *  HCWordBreakProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( WordBreakUPP )
HCWordBreakProc(XCmdPtr paramPtr);


/*
 *  PrintTEHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
PrintTEHandle(
  XCmdPtr     paramPtr,
  TEHandle    hTE,
  StringPtr   header);



/*
        Script Editor support  
*/
/*
 *  GetCheckPoints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( CheckPtHandle )
GetCheckPoints(XCmdPtr paramPtr);


/*
 *  SetCheckPoints()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SetCheckPoints(
  XCmdPtr         paramPtr,
  CheckPtHandle   checkLines);


/*
 *  FormatScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
FormatScript(
  XCmdPtr   paramPtr,
  Handle    scriptHndl,
  long *    insertionPoint,
  Boolean   quickFormat);


/*
 *  SaveXWScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SaveXWScript(
  XCmdPtr   paramPtr,
  Handle    scriptHndl);


/*
 *  GetObjectName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
GetObjectName(
  XCmdPtr          paramPtr,
  XTalkObjectPtr   xObjPtr,
  Str255           objName);


/*
 *  GetObjectScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
GetObjectScript(
  XCmdPtr          paramPtr,
  XTalkObjectPtr   xObjPtr,
  Handle *         scriptHndl);


/*
 *  SetObjectScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SetObjectScript(
  XCmdPtr          paramPtr,
  XTalkObjectPtr   xObjPtr,
  Handle           scriptHndl);



/*
        Debugging Tools support  
*/
/*
 *  AbortScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
AbortScript(XCmdPtr paramPtr);


/*
 *  GoScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
GoScript(XCmdPtr paramPtr);


/*
 *  StepScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
StepScript(
  XCmdPtr   paramPtr,
  Boolean   stepInto);


/*
 *  CountHandlers()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
CountHandlers(
  XCmdPtr   paramPtr,
  short *   handlerCount);


/*
 *  GetHandlerInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
GetHandlerInfo(
  XCmdPtr   paramPtr,
  short     handlerNum,
  Str255    handlerName,
  Str255    objectName,
  short *   varCount);


/*
 *  GetVarInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
GetVarInfo(
  XCmdPtr    paramPtr,
  short      handlerNum,
  short      varNum,
  Str255     varName,
  Boolean *  isGlobal,
  Str255     varValue,
  Handle     varHndl);


/*
 *  SetVarValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SetVarValue(
  XCmdPtr   paramPtr,
  short     handlerNum,
  short     varNum,
  Handle    varHndl);


/*
 *  GetStackCrawl()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Handle )
GetStackCrawl(XCmdPtr paramPtr);


/*
 *  TraceScript()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in HyperXLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
TraceScript(
  XCmdPtr   paramPtr,
  Boolean   traceInto);


#endif  /* CALL_NOT_IN_CARBON */


#if PRAGMA_STRUCT_ALIGN
    #pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
    #pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __HYPERXCMD__ */


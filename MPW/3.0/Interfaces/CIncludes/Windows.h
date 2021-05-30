/************************************************************

Created: Tuesday, October 4, 1988 at 10:12 PM
    Windows.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved

************************************************************/


#ifndef __WINDOWS__
#define __WINDOWS__

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __CONTROLS__
#include <Controls.h>
#endif

#define documentProc 0
#define dBoxProc 1
#define plainDBox 2
#define altDBoxProc 3
#define noGrowDocProc 4
#define zoomDocProc 8
#define zoomNoGrow 12
#define rDocProc 16
#define dialogKind 2
#define userKind 8

/* FindWindow Result Codes */

#define inDesk 0
#define inMenuBar 1
#define inSysWindow 2
#define inContent 3
#define inDrag 4
#define inGrow 5
#define inGoAway 6
#define inZoomIn 7
#define inZoomOut 8

/* window messages */

#define wDraw 0
#define wHit 1
#define wCalcRgns 2
#define wNew 3
#define wDispose 4
#define wGrow 5
#define wDrawGIcon 6

/* defProc hit test codes */

#define wNoHit 0
#define wInContent 1
#define wInDrag 2
#define wInGrow 3
#define wInGoAway 4
#define wInZoomIn 5
#define wInZoomOut 6
#define deskPatID 16

/* Window Part Identifiers which correlate color table entries with window elements */

#define wContentColor 0
#define wFrameColor 1
#define wTextColor 2
#define wHiliteColor 3
#define wTitleBarColor 4

typedef pascal void (*DragGrayRgnProcPtr)(void);

struct WindowRecord {
    GrafPort port;
    short windowKind;
    Boolean visible;
    Boolean hilited;
    Boolean goAwayFlag;
    Boolean spareFlag;
    RgnHandle strucRgn;
    RgnHandle contRgn;
    RgnHandle updateRgn;
    Handle windowDefProc;
    Handle dataHandle;
    StringHandle titleHandle;
    short titleWidth;
    ControlHandle controlList;
    struct WindowRecord *nextWindow;
    PicHandle windowPic;
    long refCon;
};

#ifndef __cplusplus
typedef struct WindowRecord WindowRecord;
#endif

typedef WindowRecord *WindowPeek;

struct CWindowRecord {
    CGrafPort port;
    short windowKind;
    Boolean visible;
    Boolean hilited;
    Boolean goAwayFlag;
    Boolean spareFlag;
    RgnHandle strucRgn;
    RgnHandle contRgn;
    RgnHandle updateRgn;
    Handle windowDefProc;
    Handle dataHandle;
    StringHandle titleHandle;
    short titleWidth;
    ControlHandle controlList;
    struct CWindowRecord *nextWindow;
    PicHandle windowPic;
    long refCon;
};

#ifndef __cplusplus
typedef struct CWindowRecord CWindowRecord;
#endif

typedef CWindowRecord *CWindowPeek;

struct WStateData {
    Rect userState;             /*user state*/
    Rect stdState;              /*standard state*/
};

#ifndef __cplusplus
typedef struct WStateData WStateData;
#endif

struct AuxWinRec {
    struct AuxWinRec **awNext;  /*handle to next AuxWinRec*/
    WindowPtr awOwner;          /*ptr to window */
    CTabHandle awCTable;        /*color table for this window*/
    Handle dialogCItem;         /*handle to dialog manager structures*/
    long awFlags;               /*reserved for expansion*/
    CTabHandle awReserved;      /*reserved for expansion*/
    long awRefCon;              /*user Constant*/
};

#ifndef __cplusplus
typedef struct AuxWinRec AuxWinRec;
#endif

typedef AuxWinRec *AuxWinPtr, **AuxWinHndl;

struct WinCTab {
    long wCSeed;                /*reserved*/
    short wCReserved;           /*reserved*/
    short ctSize;               /*usually 4 for windows*/
    ColorSpec ctTable[5];
};

#ifndef __cplusplus
typedef struct WinCTab WinCTab;
#endif

typedef WinCTab *WCTabPtr, **WCTabHandle;

#ifdef __safe_link
extern "C" {
#endif
pascal void InitWindows(void)
    = 0xA912; 
pascal void GetWMgrPort(GrafPtr *wPort)
    = 0xA910; 
pascal WindowPtr NewWindow(Ptr wStorage,const Rect *boundsRect,const Str255 title,
    Boolean visible,short theProc,WindowPtr behind,Boolean goAwayFlag,long refCon)
    = 0xA913; 
pascal WindowPtr GetNewWindow(short windowID,Ptr wStorage,WindowPtr behind)
    = 0xA9BD; 
pascal void CloseWindow(WindowPtr theWindow)
    = 0xA92D; 
pascal void DisposeWindow(WindowPtr theWindow)
    = 0xA914; 
void setwtitle(WindowPtr theWindow,char *title); 
pascal void GetWTitle(WindowPtr theWindow,Str255 title)
    = 0xA919; 
pascal void SelectWindow(WindowPtr theWindow)
    = 0xA91F; 
pascal void HideWindow(WindowPtr theWindow)
    = 0xA916; 
pascal void ShowWindow(WindowPtr theWindow)
    = 0xA915; 
pascal void ShowHide(WindowPtr theWindow,Boolean showFlag)
    = 0xA908; 
pascal void HiliteWindow(WindowPtr theWindow,Boolean fHilite)
    = 0xA91C; 
pascal void BringToFront(WindowPtr theWindow)
    = 0xA920; 
pascal void SendBehind(WindowPtr theWindow,WindowPtr behindWindow)
    = 0xA921; 
pascal WindowPtr FrontWindow(void)
    = 0xA924; 
pascal void DrawGrowIcon(WindowPtr theWindow)
    = 0xA904; 
pascal void MoveWindow(WindowPtr theWindow,short hGlobal,short vGlobal,
    Boolean front)
    = 0xA91B; 
pascal void SizeWindow(WindowPtr theWindow,short w,short h,Boolean fUpdate)
    = 0xA91D; 
pascal void ZoomWindow(WindowPtr theWindow,short partCode,Boolean front)
    = 0xA83A; 
pascal void InvalRect(const Rect *badRect)
    = 0xA928; 
pascal void InvalRgn(RgnHandle badRgn)
    = 0xA927; 
pascal void ValidRect(const Rect *goodRect)
    = 0xA92A; 
pascal void ValidRgn(RgnHandle goodRgn)
    = 0xA929; 
pascal void BeginUpdate(WindowPtr theWindow)
    = 0xA922; 
pascal void EndUpdate(WindowPtr theWindow)
    = 0xA923; 
pascal void SetWRefCon(WindowPtr theWindow,long data)
    = 0xA918; 
pascal long GetWRefCon(WindowPtr theWindow)
    = 0xA917; 
pascal void SetWindowPic(WindowPtr theWindow,PicHandle pic)
    = 0xA92E; 
pascal PicHandle GetWindowPic(WindowPtr theWindow)
    = 0xA92F; 
pascal Boolean CheckUpdate(EventRecord *theEvent)
    = 0xA911; 
pascal void ClipAbove(WindowPeek window)
    = 0xA90B; 
pascal void SaveOld(WindowPeek window)
    = 0xA90E; 
pascal void DrawNew(WindowPeek window,Boolean update)
    = 0xA90F; 
pascal void PaintOne(WindowPeek window,RgnHandle clobberedRgn)
    = 0xA90C; 
pascal void PaintBehind(WindowPeek startWindow,RgnHandle clobberedRgn)
    = 0xA90D; 
pascal void CalcVis(WindowPeek window)
    = 0xA909; 
pascal void CalcVisBehind(WindowPeek startWindow,RgnHandle clobberedRgn)
    = 0xA90A; 
pascal long GrowWindow(WindowPtr theWindow,Point startPt,const Rect *bBox)
    = 0xA92B; 
Boolean trackgoaway(WindowPtr theWindow,Point *thePt); 
pascal short FindWindow(Point thePoint,WindowPtr *theWindow)
    = 0xA92C; 
short findwindow(Point *thePoint,WindowPtr *theWindow); 
pascal long PinRect(const Rect *theRect,Point thePt)
    = 0xA94E; 
pascal long DragGrayRgn(RgnHandle theRgn,Point startPt,const Rect *boundsRect,
    const Rect *slopRect,short axis,DragGrayRgnProcPtr actionProc)
    = 0xA905; 
pascal Boolean TrackBox(WindowPtr theWindow,Point thePt,short partCode)
    = 0xA83B; 
pascal void GetCWMgrPort(CGrafPtr *wMgrCPort)
    = 0xAA48; 
void getwtitle(WindowPtr theWindow,char *title); 
pascal void SetWinColor(WindowPtr theWindow,WCTabHandle newColorTable)
    = 0xAA41; 
pascal Boolean GetAuxWin(WindowPtr theWindow,AuxWinHndl *awHndl)
    = 0xAA42; 
long growwindow(WindowPtr theWindow,Point *startPt,const Rect *bBox); 
pascal void SetDeskCPat(PixPatHandle deskPixPat)
    = 0xAA47; 
WindowPtr newwindow(Ptr wStorage,const Rect *boundsRect,char *title,Boolean visible,
    short theProc,WindowPtr behind,Boolean goAwayFlag,long refCon); 
pascal WindowPtr NewCWindow(Ptr wStorage,const Rect *boundsRect,const Str255 title,
    Boolean visible,short procID,WindowPtr behind,Boolean goAwayFlag,long refCon)
    = 0xAA45; 
WindowPtr newcwindow(Ptr wStorage,const Rect *boundsRect,char *title,Boolean visible,
    short procID,WindowPtr behind,Boolean goAwayFlag,long refCon); 
pascal WindowPtr GetNewCWindow(short windowID,Ptr wStorage,WindowPtr behind)
    = 0xAA46; 
pascal short GetWVariant(WindowPtr theWindow)
    = 0xA80A; 
long pinrect(const Rect *theRect,Point *thePt); 
pascal RgnHandle GetGrayRgn(void); 
pascal void SetWTitle(WindowPtr theWindow,const Str255 title)
    = 0xA91A; 
Boolean trackbox(WindowPtr theWindow,Point *thePt,short partCode); 
pascal Boolean TrackGoAway(WindowPtr theWindow,Point thePt)
    = 0xA91E; 
pascal void DragWindow(WindowPtr theWindow,Point startPt,const Rect *boundsRect)
    = 0xA925; 
long draggrayrgn(RgnHandle theRgn,Point *startPt,const Rect *boundsRect,
    const Rect *slopRect,short axis,DragGrayRgnProcPtr actionProc); 
void dragwindow(WindowPtr theWindow,Point *startPt,const Rect *boundsRect); 
#ifdef __safe_link
}
#endif

#endif

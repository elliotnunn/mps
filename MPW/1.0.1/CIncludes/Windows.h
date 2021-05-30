/*
	 Windows.h -- Window Manager

	 C Interface to the Macintosh Libraries
	 Copyright Apple Computer,Inc. 1985,1986
	 All rights reserved.
*/

#ifndef __WINDOWS__
#define __WINDOWS__
#ifndef __QUICKDRAW__
#include <QuickDraw.h>
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
#define inDesk 0
#define inMenuBar 1
#define inSysWindow 2
#define inContent 3
#define inDrag 4
#define inGrow 5
#define inGoAway 6
#define inZoomIn 7
#define inZoomOut 8
#define noConstraint 0
#define hAxisOnly 1
#define vAxisOnly 2
#define wDraw 0
#define wHit 1
#define wCalcRgns 2
#define wNew 3
#define wDispose 4
#define wGrow 5
#define wDrawGIcon 6
#define wNoHit 0
#define wInContent 1
#define wInDrag 2
#define wInGrow 3
#define wInGoAway 4
#define wInZoomIn 5
#define wInZoomOut 6
#define deskPatID 16

typedef GrafPtr WindowPtr;
typedef struct WindowRecord {
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
	 struct ControlRecord **controlList;
	 struct WindowRecord *nextWindow;
	 PicHandle windowPic;
	 long refCon;
} WindowRecord,*WindowPeek;
typedef struct WStateData {
	 Rect userState;
	 Rect stdState;
} WStateData;

pascal void InitWindows()
	 extern 0xA912;
pascal void GetWMgrPort(wPort)
	 GrafPtr *wPort;
	 extern 0xA910;
WindowPtr NewWindow();
pascal WindowPtr GetNewWindow(windowID,wStorage,behind)
	 short windowID;
	 Ptr wStorage;
	 WindowPtr behind;
	 extern 0xA9BD;
pascal void CloseWindow(theWindow)
	 WindowPtr theWindow;
	 extern 0xA92D;
pascal void DisposeWindow(theWindow)
	 WindowPtr theWindow;
	 extern 0xA914;
pascal void SelectWindow(theWindow)
	 WindowPtr theWindow;
	 extern 0xA91F;
pascal void HideWindow(theWindow)
	 WindowPtr theWindow;
	 extern 0xA916;
pascal void ShowWindow(theWindow)
	 WindowPtr theWindow;
	 extern 0xA915;
pascal void ShowHide(theWindow,showFlag)
	 WindowPtr theWindow;
	 Boolean showFlag;
	 extern 0xA908;
pascal void HiliteWindow(theWindow,fHilite)
	 WindowPtr theWindow;
	 Boolean fHilite;
	 extern 0xA91C;
pascal void BringToFront(theWindow)
	 WindowPtr theWindow;
	 extern 0xA920;
pascal void SendBehind(theWindow,behindWindow)
	 WindowPtr theWindow,behindWindow;
	 extern 0xA921;
pascal WindowPtr FrontWindow()
	 extern 0xA924;
pascal void DrawGrowIcon(theWindow)
	 WindowPtr theWindow;
	 extern 0xA904;
pascal void MoveWindow(theWindow,hGlobal,vGlobal,front)
	 WindowPtr theWindow;
	 short hGlobal,vGlobal;
	 Boolean front;
	 extern 0xA91B;
pascal void SizeWindow(theWindow,w,h,fUpdate)
	 WindowPtr theWindow;
	 short w,h;
	 Boolean fUpdate;
	 extern 0xA91D;
pascal void ZoomWindow(theWindow,partCode,front)
	 WindowPtr theWindow;
	 short partCode;
	 Boolean front;
	 extern 0xA83A;
pascal void InvalRect(badRect)
	 Rect *badRect;
	 extern 0xA928;
pascal void InvalRgn(badRgn)
	 RgnHandle badRgn;
	 extern 0xA927;
pascal void ValidRect(goodRect)
	 Rect *goodRect;
	 extern 0xA92A;
pascal void ValidRgn(goodRgn)
	 RgnHandle goodRgn;
	 extern 0xA929;
pascal void BeginUpdate(theWindow)
	 WindowPtr theWindow;
	 extern 0xA922;
pascal void EndUpdate(theWindow)
	 WindowPtr theWindow;
	 extern 0xA923;
pascal void SetWRefCon(theWindow,data)
	 WindowPtr theWindow;
	 long data;
	 extern 0xA918;
pascal long GetWRefCon(theWindow)
	 WindowPtr theWindow;
	 extern 0xA917;
pascal void SetWindowPic(theWindow,pic)
	 WindowPtr theWindow;
	 PicHandle pic;
	 extern 0xA92E;
pascal PicHandle GetWindowPic(theWindow)
	 WindowPtr theWindow;
	 extern 0xA92F;
pascal Boolean CheckUpdate(theEvent)
	 struct EventRecord *theEvent;
	 extern 0xA911;
pascal void ClipAbove(window)
	 WindowPeek window;
	 extern 0xA90B;
pascal void SaveOld(window)
	 WindowPeek window;
	 extern 0xA90E;
pascal void DrawNew(window,update)
	 WindowPeek window;
	 Boolean update;
	 extern 0xA90F;
pascal void PaintOne(window,clobberedRgn)
	 WindowPeek window;
	 RgnHandle clobberedRgn;
	 extern 0xA90C;
pascal void PaintBehind(startWindow,clobberedRgn)
	 WindowPeek startWindow;
	 RgnHandle clobberedRgn;
	 extern 0xA90D;
pascal void CalcVis(window)
	 WindowPeek window;
	 extern 0xA909;
pascal void CalcVisBehind(startWindow,clobberedRgn)
	 WindowPeek startWindow;
	 RgnHandle clobberedRgn;
	 extern 0xA90A;
#endif

/************************************************************

Created: Tuesday, October 4, 1988 at 5:23 PM
    Controls.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc. 1985-1988 
    All rights reserved

************************************************************/


#ifndef __CONTROLS__
#define __CONTROLS__

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#define pushButProc 0
#define checkBoxProc 1
#define radioButProc 2
#define useWFont 8
#define scrollBarProc 16
#define inButton 10
#define inCheckBox 11
#define inUpButton 20
#define inDownButton 21
#define inPageUp 22
#define inPageDown 23
#define inThumb 129

/* 
axis constraints for DragGrayRgn call */

#define noConstraint 0
#define hAxisOnly 1
#define vAxisOnly 2

/* 
control messages */

#define drawCntl 0
#define testCntl 1
#define calcCRgns 2
#define initCntl 3
#define dispCntl 4
#define posCntl 5
#define thumbCntl 6
#define dragCntl 7
#define autoTrack 8
#define cFrameColor 0
#define cBodyColor 1
#define cTextColor 2
#define cThumbColor 3

struct ControlRecord {
    struct ControlRecord **nextControl;
    WindowPtr contrlOwner;
    Rect contrlRect;
    unsigned char contrlVis;
    unsigned char contrlHilite;
    short contrlValue;
    short contrlMin;
    short contrlMax;
    Handle contrlDefProc;
    Handle contrlData;
    ProcPtr contrlAction;
    long contrlRfCon;
    Str255 contrlTitle;
};

#ifndef __cplusplus
typedef struct ControlRecord ControlRecord;
#endif

typedef ControlRecord *ControlPtr, **ControlHandle;

struct CtlCTab {
    long ccSeed;            /*reserved*/
    short ccRider;          /*see what you have done - reserved*/
    short ctSize;           /*usually 3 for controls*/
    ColorSpec ctTable[4];
};

#ifndef __cplusplus
typedef struct CtlCTab CtlCTab;
#endif

typedef CtlCTab *CCTabPtr, **CCTabHandle;

struct AuxCtlRec {
    Handle acNext;          /*handle to next AuxCtlRec*/
    ControlHandle acOwner;  /*handle for aux record's control*/
    CCTabHandle acCTable;   /*color table for this control*/
    short acFlags;          /*misc flag byte*/
    long acReserved;        /*reserved for use by Apple*/
    long acRefCon;          /*for use by application*/
};

#ifndef __cplusplus
typedef struct AuxCtlRec AuxCtlRec;
#endif

typedef AuxCtlRec *AuxCtlPtr, **AuxCtlHndl;

#ifdef __safe_link
extern "C" {
#endif
pascal ControlHandle NewControl(WindowPtr theWindow,const Rect *boundsRect,
    const Str255 title,Boolean visible,short value,short min,short max,short procID,
    long refCon)
    = 0xA954; 
pascal void SetCTitle(ControlHandle theControl,const Str255 title)
    = 0xA95F; 
pascal void GetCTitle(ControlHandle theControl,Str255 title)
    = 0xA95E; 
pascal ControlHandle GetNewControl(short controlID,WindowPtr owner)
    = 0xA9BE; 
pascal void DisposeControl(ControlHandle theControl)
    = 0xA955; 
pascal void KillControls(WindowPtr theWindow)
    = 0xA956; 
pascal void HideControl(ControlHandle theControl)
    = 0xA958; 
pascal void ShowControl(ControlHandle theControl)
    = 0xA957; 
pascal void DrawControls(WindowPtr theWindow)
    = 0xA969; 
pascal void Draw1Control(ControlHandle theControl)
    = 0xA96D; 
pascal void HiliteControl(ControlHandle theControl,short hiliteState)
    = 0xA95D; 
pascal void UpdtControl(WindowPtr theWindow,RgnHandle updateRgn)
    = 0xA953; 
pascal void MoveControl(ControlHandle theControl,short h,short v)
    = 0xA959; 
pascal void SizeControl(ControlHandle theControl,short w,short h)
    = 0xA95C; 
pascal void SetCtlValue(ControlHandle theControl,short theValue)
    = 0xA963; 
pascal short GetCtlValue(ControlHandle theControl)
    = 0xA960; 
pascal void SetCtlMin(ControlHandle theControl,short minValue)
    = 0xA964; 
pascal short GetCtlMin(ControlHandle theControl)
    = 0xA961; 
pascal void SetCtlMax(ControlHandle theControl,short maxValue)
    = 0xA965; 
pascal short GetCtlMax(ControlHandle theControl)
    = 0xA962; 
pascal void SetCRefCon(ControlHandle theControl,long data)
    = 0xA95B; 
pascal long GetCRefCon(ControlHandle theControl)
    = 0xA95A; 
pascal void SetCtlAction(ControlHandle theControl,ProcPtr actionProc)
    = 0xA96B; 
pascal ProcPtr GetCtlAction(ControlHandle theControl)
    = 0xA96A; 
pascal void DragControl(ControlHandle theControl,Point startPt,const Rect *limitRect,
    const Rect *slopRect,short axis)
    = 0xA967; 
pascal short TestControl(ControlHandle theControl,Point thePt)
    = 0xA966; 
pascal short TrackControl(ControlHandle theControl,Point thePoint,ProcPtr actionProc)
    = 0xA968; 
pascal short FindControl(Point thePoint,WindowPtr theWindow,ControlHandle *theControl)
    = 0xA96C; 
pascal void SetCtlColor(ControlHandle theControl,CCTabHandle newColorTable)
    = 0xAA43; 
pascal Boolean GetAuxCtl(ControlHandle theControl,AuxCtlHndl *acHndl)
    = 0xAA44; 
pascal short GetCVariant(ControlHandle theControl)
    = 0xA809; 
void dragcontrol(ControlHandle theControl,Point *startPt,const Rect *limitRect,
    const Rect *slopRect,short axis); 
ControlHandle newcontrol(WindowPtr theWindow,const Rect *boundsRect,char *title,
    Boolean visible,short value,short min,short max,short procID,long refCon); 
short findcontrol(Point *thePoint,WindowPtr theWindow,ControlHandle *theControl); 
void getctitle(ControlHandle theControl,char *title); 
void setctitle(ControlHandle theControl,char *title); 
short trackcontrol(ControlHandle theControl,Point *thePoint,ProcPtr actionProc); 
short testcontrol(ControlHandle theControl,Point *thePt); 
#ifdef __safe_link
}
#endif

#endif

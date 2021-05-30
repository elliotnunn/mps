/************************************************************

Created: Friday, October 21, 1988 at 3:40 AM
    Lists.h
    C Interface to the Macintosh Libraries


    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved

************************************************************/


#ifndef __LISTS__
#define __LISTS__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __CONTROLS__
#include <Controls.h>
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif

#define lDoVAutoscroll 2
#define lDoHAutoscroll 1
#define lOnlyOne -128
#define lExtendDrag 64
#define lNoDisjoint 32
#define lNoExtend 16
#define lNoRect 8
#define lUseSense 4
#define lNoNilHilite 2
#define lInitMsg 0
#define lDrawMsg 1
#define lHiliteMsg 2
#define lCloseMsg 3

typedef Point Cell;

typedef char DataArray[32001],*DataPtr,**DataHandle;

typedef pascal short (*SearchProcPtr)(Ptr aPtr, Ptr bPtr, short aLen, short bLen);


struct ListRec {
    Rect rView;
    GrafPtr port;
    Point indent;
    Point cellSize;
    Rect visible;
    ControlHandle vScroll;
    ControlHandle hScroll;
    char selFlags;
    Boolean lActive;
    char lReserved;
    char listFlags;
    long clikTime;
    Point clikLoc;
    Point mouseLoc;
    ProcPtr lClikLoop;
    Cell lastClick;
    long refCon;
    Handle listDefProc;
    Handle userHandle;
    Rect dataBounds;
    DataHandle cells;
    short maxIndex;
    short cellArray[1];
};

#ifndef __cplusplus
typedef struct ListRec ListRec;
#endif

typedef ListRec *ListPtr, **ListHandle;

#ifdef __safe_link
extern "C" {
#endif
ListHandle lnew(Rect *rView,Rect *dataBounds,Point *cSize,short theProc,
    WindowPtr theWindow,Boolean drawIt,Boolean hasGrow,Boolean scrollHoriz,
    Boolean scrollVert); 
pascal ListHandle LNew(const Rect *rView,const Rect *dataBounds,Point cSize,
    short theProc,WindowPtr theWindow,Boolean drawIt,Boolean hasGrow,Boolean scrollHoriz,
    Boolean scrollVert)
    = {0x3F3C,0x0044,0xA9E7}; 
pascal void LDispose(ListHandle lHandle)
    = {0x3F3C,0x0028,0xA9E7}; 
pascal short LAddColumn(short count,short colNum,ListHandle lHandle)
    = {0x3F3C,0x0004,0xA9E7}; 
pascal short LAddRow(short count,short rowNum,ListHandle lHandle)
    = {0x3F3C,0x0008,0xA9E7}; 
pascal void LDelColumn(short count,short colNum,ListHandle lHandle)
    = {0x3F3C,0x0020,0xA9E7}; 
pascal void LDelRow(short count,short rowNum,ListHandle lHandle)
    = {0x3F3C,0x0024,0xA9E7}; 
pascal Boolean LGetSelect(Boolean next,Cell *theCell,ListHandle lHandle)
    = {0x3F3C,0x003C,0xA9E7}; 
pascal Cell LLastClick(ListHandle lHandle)
    = {0x3F3C,0x0040,0xA9E7}; 
pascal Boolean LNextCell(Boolean hNext,Boolean vNext,Cell *theCell,ListHandle lHandle)
    = {0x3F3C,0x0048,0xA9E7}; 
pascal Boolean LSearch(Ptr dataPtr,short dataLen,SearchProcPtr searchProc,
    Cell *theCell,ListHandle lHandle)
    = {0x3F3C,0x0054,0xA9E7}; 
pascal void LSize(short listWidth,short listHeight,ListHandle lHandle)
    = {0x3F3C,0x0060,0xA9E7}; 
pascal void LDoDraw(Boolean drawIt,ListHandle lHandle)
    = {0x3F3C,0x002C,0xA9E7}; 
pascal void LScroll(short dCols,short dRows,ListHandle lHandle)
    = {0x3F3C,0x0050,0xA9E7}; 
pascal void LAutoScroll(ListHandle lHandle)
    = {0x3F3C,0x0010,0xA9E7}; 
pascal void LUpdate(RgnHandle theRgn,ListHandle lHandle)
    = {0x3F3C,0x0064,0xA9E7}; 
pascal void LActivate(Boolean act,ListHandle lHandle)
    = {0x3F3C,0x0000,0xA9E7}; 
pascal void LCellSize(Point cSize,ListHandle lHandle)
    = {0x3F3C,0x0014,0xA9E7}; 
pascal Boolean LClick(Point pt,short modifiers,ListHandle lHandle)
    = {0x3F3C,0x0018,0xA9E7}; 
pascal void LAddToCell(Ptr dataPtr,short dataLen,Cell theCell,ListHandle lHandle)
    = {0x3F3C,0x000C,0xA9E7}; 
pascal void LClrCell(Cell theCell,ListHandle lHandle)
    = {0x3F3C,0x001C,0xA9E7}; 
pascal void LGetCell(Ptr dataPtr,short *dataLen,Cell theCell,ListHandle lHandle)
    = {0x3F3C,0x0038,0xA9E7}; 
pascal void LFind(short *offset,short *len,Cell theCell,ListHandle lHandle)
    = {0x3F3C,0x0034,0xA9E7}; 
pascal void LRect(Rect *cellRect,Cell theCell,ListHandle lHandle)
    = {0x3F3C,0x004C,0xA9E7}; 
pascal void LSetCell(Ptr dataPtr,short dataLen,Cell theCell,ListHandle lHandle)
    = {0x3F3C,0x0058,0xA9E7}; 
pascal void LSetSelect(Boolean setIt,Cell theCell,ListHandle lHandle)
    = {0x3F3C,0x005C,0xA9E7}; 
pascal void LDraw(Cell theCell,ListHandle lHandle)
    = {0x3F3C,0x0030,0xA9E7}; 
void ldraw(Cell *theCell,ListHandle lHandle); 
Boolean lclick(Point *pt,short modifiers,ListHandle lHandle); 
void lcellsize(Point *cSize,ListHandle lHandle); 
#ifdef __safe_link
}
#endif

#endif

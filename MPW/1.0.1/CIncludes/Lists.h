/*
	Lists.h -- List Manager

	C Interface to the Macintosh Libraries
	Copyright Apple Computer,Inc. 1985,1986
	All rights reserved.
*/

#ifndef __LISTS__
#define __LISTS__
#ifndef __TYPES__
#include <Types.h>
#endif

#define lDoVAutoscroll 2
#define lDoHAutoscroll 1
#define lOnlyOne (-128)
#define lExtendDrag 0x40
#define lNoDisjoint 0x20
#define lNoExtend 0x10
#define lNoRect 0x08
#define lUseSense 0x04
#define lNoNilHilite 0x02

#define lInitMsg 0
#define lDrawMsg 1
#define lHiliteMsg 2
#define lCloseMsg 3

typedef Point Cell;
typedef struct ListRec {
	Rect rView;
	struct GrafPort *port;
	Point indent;
	Point cellSize;
	Rect visible;
	struct ControlRecord **vScroll;
	struct ControlRecord **hScroll;
	char selFlags;
	char lActive;
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
	Handle cells;
	short maxIndex;
	short cellArray[1];
} ListRec,*ListPtr,**ListHandle;

extern ListHandle LNew();
pascal void LDispose(lHandle)
	ListHandle lHandle;
	extern;
pascal short LAddColumn(count,colNum,lHandle)
	short count,colNum;
	ListHandle lHandle;
	extern;
pascal short LAddRow(count,rowNum,lHandle)
	short count,rowNum;
	ListHandle lHandle;
	extern;
pascal void LDelColumn(count,colNum,lHandle)
	short count,colNum;
	ListHandle lHandle;
	extern;
pascal void LDelRow(count,rowNum,lHandle)
	short count,rowNum;
	ListHandle lHandle;
	extern;
pascal Boolean LGetSelect (next,theCell,lHandle)
	Boolean next;
	Cell *theCell;
	ListHandle lHandle;
	extern;
pascal Cell LLastClick (lHandle)
	ListHandle lHandle;
	extern;
pascal Boolean LNextCell(hNext,vNext,theCell,lHandle)
	Boolean hNext,vNext;
	Cell *theCell;
	ListHandle lHandle;
	extern;
pascal Boolean LSearch(dataPtr,dataLen,searchProc,theCell,lHandle)
	Ptr dataPtr;
	short dataLen;
	ProcPtr searchProc;
	Cell *theCell;
	ListHandle lHandle;
	extern;
pascal void LSize(listWidth,listHeight,lHandle)
	short listWidth,listHeight;
	ListHandle lHandle;
	extern;
pascal void LDoDraw(drawIt,lHandle)
	Boolean drawIt;
	ListHandle lHandle;
	extern;
pascal void LScroll(dCols,dRows,lHandle)
	short dCols,dRows;
	ListHandle lHandle;
	extern;
pascal void LAutoScroll(lHandle)
	ListHandle lHandle;
	extern;
pascal void LUpdate(theRgn,lHandle)
	struct Region **theRgn;
	ListHandle lHandle;
	extern;
pascal void LActivate(act,lHandle)
	Boolean act;
	ListHandle lHandle;
	extern;
#endif

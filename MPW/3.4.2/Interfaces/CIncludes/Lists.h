/*
 	File:		Lists.h
 
 	Contains:	List Manager Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.3
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __LISTS__
#define __LISTS__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __CONTROLS__
#include <Controls.h>
#endif
/*	#include <Quickdraw.h>										*/
/*		#include <MixedMode.h>									*/
/*		#include <QuickdrawText.h>								*/
/*	#include <Menus.h>											*/
/*		#include <Memory.h>										*/

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

enum {
	lDoVAutoscroll				= 2,
	lDoHAutoscroll				= 1,
	lOnlyOne					= -128,
	lExtendDrag					= 64,
	lNoDisjoint					= 32,
	lNoExtend					= 16,
	lNoRect						= 8,
	lUseSense					= 4,
	lNoNilHilite				= 2
};

enum {
	lDoVAutoscrollBit			= 1,
	lDoHAutoscrollBit			= 0,
	lOnlyOneBit					= 7,
	lExtendDragBit				= 6,
	lNoDisjointBit				= 5,
	lNoExtendBit				= 4,
	lNoRectBit					= 3,
	lUseSenseBit				= 2,
	lNoNilHiliteBit				= 1
};


enum {
	lInitMsg					= 0,
	lDrawMsg					= 1,
	lHiliteMsg					= 2,
	lCloseMsg					= 3
};

typedef struct ListRec ListRec, *ListPtr, **ListHandle;

typedef ListHandle ListRef;

typedef Point Cell;

typedef Rect ListBounds;

typedef char DataArray[32001];

typedef char *DataPtr, **DataHandle;

typedef pascal short (*ListSearchProcPtr)(Ptr aPtr, Ptr bPtr, short aLen, short bLen);
/*
		ListClickLoopProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

			typedef pascal Boolean (*ListClickLoopProcPtr)(void);

		In:
		 =>             	.?
		Out:
		 <= return value	D0.B
*/

#if GENERATINGCFM
typedef UniversalProcPtr ListSearchUPP;
typedef UniversalProcPtr ListClickLoopUPP;
#else
typedef ListSearchProcPtr ListSearchUPP;
typedef Register68kProcPtr ListClickLoopUPP;
#endif

struct ListRec {
	Rect							rView;
	GrafPtr							port;
	Point							indent;
	Point							cellSize;
	ListBounds						visible;
	ControlRef						vScroll;
	ControlRef						hScroll;
	SInt8							selFlags;
	Boolean							lActive;
	SInt8							lReserved;
	SInt8							listFlags;
	long							clikTime;
	Point							clikLoc;
	Point							mouseLoc;
	ListClickLoopUPP				lClickLoop;
	Cell							lastClick;
	long							refCon;
	Handle							listDefProc;
	Handle							userHandle;
	ListBounds						dataBounds;
	DataHandle						cells;
	short							maxIndex;
	short							cellArray[1];
};

typedef pascal void (*ListDefProcPtr)(short lMessage, Boolean lSelect, Rect *lRect, Cell lCell, short lDataOffset, short lDataLen, ListRef lHandle);
typedef pascal void (*ListCellDrawProcPtr)(short lMessage, Boolean lSelect, Rect *lRect, Cell lCell, void *dataPtr, short lDataLen, ListRef lHandle);

#if GENERATINGCFM
typedef UniversalProcPtr ListDefUPP;
typedef UniversalProcPtr ListCellDrawUPP;
#else
typedef ListDefProcPtr ListDefUPP;
typedef ListCellDrawProcPtr ListCellDrawUPP;
#endif

enum {
	uppListSearchProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(short))),
	uppListClickLoopProcInfo = kRegisterBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | REGISTER_RESULT_LOCATION(kRegisterD0),
	uppListDefProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Rect*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(Cell)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(7, SIZE_CODE(sizeof(ListRef))),
	uppListCellDrawProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Rect*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(Cell)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(7, SIZE_CODE(sizeof(ListRef)))
};

#if GENERATINGCFM
#define NewListSearchProc(userRoutine)		\
		(ListSearchUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppListSearchProcInfo, GetCurrentArchitecture())
#define NewListClickLoopProc(userRoutine)		\
		(ListClickLoopUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppListClickLoopProcInfo, GetCurrentArchitecture())
#define NewListDefProc(userRoutine)		\
		(ListDefUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppListDefProcInfo, GetCurrentArchitecture())
#define NewListCellDrawProc(userRoutine)		\
		(ListCellDrawUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppListCellDrawProcInfo, GetCurrentArchitecture())
#else
#define NewListSearchProc(userRoutine)		\
		((ListSearchUPP) (userRoutine))
#define NewListClickLoopProc(userRoutine)		\
		((ListClickLoopUPP) (userRoutine))
#define NewListDefProc(userRoutine)		\
		((ListDefUPP) (userRoutine))
#define NewListCellDrawProc(userRoutine)		\
		((ListCellDrawUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallListSearchProc(userRoutine, aPtr, bPtr, aLen, bLen)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppListSearchProcInfo, (aPtr), (bPtr), (aLen), (bLen))
#define CallListClickLoopProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppListClickLoopProcInfo)
#define CallListDefProc(userRoutine, lMessage, lSelect, lRect, lCell, lDataOffset, lDataLen, lHandle)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppListDefProcInfo, (lMessage), (lSelect), (lRect), (lCell), (lDataOffset), (lDataLen), (lHandle))
#define CallListCellDrawProc(userRoutine, lMessage, lSelect, lRect, lCell, dataPtr, lDataLen, lHandle)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppListCellDrawProcInfo, (lMessage), (lSelect), (lRect), (lCell), (dataPtr), (lDataLen), (lHandle))
#else
#define CallListSearchProc(userRoutine, aPtr, bPtr, aLen, bLen)		\
		(*(userRoutine))((aPtr), (bPtr), (aLen), (bLen))
/* (*ListClickLoopProcPtr) cannot be called from a high-level language without the Mixed Mode Manager */
#define CallListDefProc(userRoutine, lMessage, lSelect, lRect, lCell, lDataOffset, lDataLen, lHandle)		\
		(*(userRoutine))((lMessage), (lSelect), (lRect), (lCell), (lDataOffset), (lDataLen), (lHandle))
#define CallListCellDrawProc(userRoutine, lMessage, lSelect, lRect, lCell, dataPtr, lDataLen, lHandle)		\
		(*(userRoutine))((lMessage), (lSelect), (lRect), (lCell), (dataPtr), (lDataLen), (lHandle))
#endif

extern pascal ListRef LNew(const Rect *rView, const ListBounds *dataBounds, Point cSize, short theProc, WindowRef theWindow, Boolean drawIt, Boolean hasGrow, Boolean scrollHoriz, Boolean scrollVert)
 THREEWORDINLINE(0x3F3C, 0x0044, 0xA9E7);
extern pascal void LDispose(ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0028, 0xA9E7);
extern pascal short LAddColumn(short count, short colNum, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0004, 0xA9E7);
extern pascal short LAddRow(short count, short rowNum, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0008, 0xA9E7);
extern pascal void LDelColumn(short count, short colNum, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0020, 0xA9E7);
extern pascal void LDelRow(short count, short rowNum, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0024, 0xA9E7);
extern pascal Boolean LGetSelect(Boolean next, Cell *theCell, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x003C, 0xA9E7);
extern pascal Cell LLastClick(ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0040, 0xA9E7);
extern pascal Boolean LNextCell(Boolean hNext, Boolean vNext, Cell *theCell, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0048, 0xA9E7);
extern pascal Boolean LSearch(const void *dataPtr, short dataLen, ListSearchUPP searchProc, Cell *theCell, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0054, 0xA9E7);
extern pascal void LSize(short listWidth, short listHeight, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0060, 0xA9E7);
extern pascal void LSetDrawingMode(Boolean drawIt, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x002C, 0xA9E7);
extern pascal void LScroll(short dCols, short dRows, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0050, 0xA9E7);
extern pascal void LAutoScroll(ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0010, 0xA9E7);
extern pascal void LUpdate(RgnHandle theRgn, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0064, 0xA9E7);
extern pascal void LActivate(Boolean act, ListRef lHandle)
 TWOWORDINLINE(0x4267, 0xA9E7);
extern pascal void LCellSize(Point cSize, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0014, 0xA9E7);
extern pascal Boolean LClick(Point pt, short modifiers, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0018, 0xA9E7);
extern pascal void LAddToCell(const void *dataPtr, short dataLen, Cell theCell, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x000C, 0xA9E7);
extern pascal void LClrCell(Cell theCell, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x001C, 0xA9E7);
extern pascal void LGetCell(void *dataPtr, short *dataLen, Cell theCell, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0038, 0xA9E7);
extern pascal void LRect(Rect *cellRect, Cell theCell, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x004C, 0xA9E7);
extern pascal void LSetCell(const void *dataPtr, short dataLen, Cell theCell, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0058, 0xA9E7);
extern pascal void LSetSelect(Boolean setIt, Cell theCell, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x005C, 0xA9E7);
extern pascal void LDraw(Cell theCell, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0030, 0xA9E7);
extern pascal void LGetCellDataLocation(short *offset, short *len, Cell theCell, ListRef lHandle)
 THREEWORDINLINE(0x3F3C, 0x0034, 0xA9E7);
#if CGLUESUPPORTED
extern void laddtocell(Ptr dataPtr, short dataLen, Cell *theCell, ListRef lHandle);
extern void lclrcell(Cell *theCell, ListRef lHandle);
extern void lgetcelldatalocation(short *offset, short *len, Cell *theCell, ListRef lHandle);
extern void lgetcell(Ptr dataPtr, short *dataLen, Cell *theCell, ListRef lHandle);
extern ListRef lnew(Rect *rView, ListBounds *dataBounds, Point *cSize, short theProc, WindowRef theWindow, Boolean drawIt, Boolean hasGrow, Boolean scrollHoriz, Boolean scrollVert);
extern void lrect(Rect *cellRect, Cell *theCell, ListRef lHandle);
extern void lsetcell(Ptr dataPtr, short dataLen, Cell *theCell, ListRef lHandle);
extern void lsetselect(Boolean setIt, Cell *theCell, ListRef lHandle);
extern void ldraw(Cell *theCell, ListRef lHandle);
extern Boolean lclick(Point *pt, short modifiers, ListRef lHandle);
extern void lcellsize(Point *cSize, ListRef lHandle);
#endif
#if OLDROUTINENAMES
#define LDoDraw(drawIt, lHandle) LSetDrawingMode(drawIt, lHandle)
#define LFind(offset, len, theCell, lHandle)  \
	LGetCellDataLocation(offset, len, theCell, lHandle)
#if CGLUESUPPORTED
#define lfind(offset, len, theCell, lHandle)  \
	lgetcelldatalocation(offset, len, theCell, lHandle)
#endif
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __LISTS__ */

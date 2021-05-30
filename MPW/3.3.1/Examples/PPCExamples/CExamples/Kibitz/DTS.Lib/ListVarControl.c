/*
** Apple Macintosh Developer Technical Support
**
** Program:         listvarcontrol.c
** Written by:      Eric Soldan
**
** Copyright © 1991 Apple Computer, Inc.
** All rights reserved.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */


/*

A number of developers have expressed a desire to have the List Manager support
variable-size cells.  In response to this, the List control has been extended to
support variable-size rows and columns.

The first problem is where to store the size for each row and column.  This
implementation expects the sizes for the individual column widths to be stored
in row 0, cells 1 through numCols, and the individual row widths to be stored in
column 0, rows 1 through numRows.  The values are placed in the cells in decimal
ascii.  (This is so that the AppsToGo editor can easily be used to create lists
with variable-size cells.  You just enter the decimal ascii value in the editor.)
Any row or column without a decimal ascii entry for the size will get the regular
size for a cell.

Since row 0 and column 0 are used to store the widths, these cells are not available
in the list.  They are not displayed, and you can not scroll into them.  Due to this,
the list is one column narrower and one row shorter than a regular list.

The variable-size list expects the dataBounds upper-left to be 0,0.  Any other
upper-left for the dataBounds will cause the variable-size list to misbehave.  
A dataBounds other than 0,0 is very rare, and unnecessary, so it seemed better
to not have the code to support it, than to code for a feature almost never used.

Bit 14 of the mode field needs to be set to true for the list to be converted to
a variable-size list.  Also, CLVInitialize() has to be called at some time, or else
the framework will create the list as a regular list.  (Start.c is a good place.)

For the most part, the List control is managed just like the regular List control.
If you need to access the List itself, it is stored in the refCon of the List control.
However, since the List Manager calls aren't expecting the list to be of variable-size
cells, you can't make all of the calls to the List Manager you would normally make.

If you create a regular list, and then place decimal ascii values in row 0 and
column 0 (where needed), you can then directly call CLVVariableSizeCells() for that
list, and it will be converted.  (If you call CLVVariableSizeCells() directly, you
don't actually need to call CLVInitialize(), as it does this for you.)

Below are the List Manager calls, and how they should be handled when using a
variable-size list:


LActivate:
	Call CLActivate().

LAddColumn:
	Call CLVAddColumn().

LAddRow:
	Call CLVAddRow().

LAddToCell:
	Okay to call.  Cell won't be drawn, though.  Standard list drawing is disabled
	when using variable-size cell mode.  Call CLVDraw() afterwards to draw the cell.

LAutoScroll:
	Call CLVAutoScroll().

LCellSize:
	New meaning.  You can set the size of a column or row.  To do, do the following:
		1)	LGetCell() for the row or column width to change.  Example:
				For column 3,
					short	len, locSize[2];
					Point	cell;

					len = 2 * sizeof(short);
					cell.h = 3;
					cell.v = 0;
					LGetCell(locSize, &len, cell, list);
		2)	Set the size (2nd word) to new size (locSize[1] = newSize).
		3)	LSetCell(locSize, len, cell, list);
		4)	CLVAdjustCellLocs(list)
		5)	CLVUpdate(list)

LClick:
	Call CLVClick().

LClrCell:
	Okay to call.  Cell won't be drawn, though.  Standard list drawing is disabled
	when using variable-size cell mode.  Call CLVDraw() afterwards to draw the cell.

LDelColumn:
	Call LDelColumn(), followed by CLVAdjustCellLocs() and CLVUpdate().

LDelRow:
	Call LDelRow(), followed by CLVAdjustCellLocs() and CLVUpdate().

LDispose:
	Don't call it.  Dispose by DisposeControl(CLViewFromList(list)).

LDoDraw:
	Don't call it.  The variable-sized control should always have doDraw false.
	(You can hide the list by making the control invisible.)

LDraw:
	Call CLVDraw().

LFind:
	Okay to call.

LGetCell:
	Okay to call.

LGetSelect:
	Okay to call.

LLastClick:
	Okay to call.

LNextCell:
	Okay to call.

LRect:
	Call CLVGetCellInfo().
	It's overkill, since it gets everything, but tough.  There aren't too many
	occasions for the app to get the cell rect, so I'm not going to have another
	call to do it.

LScroll:
	Don't call.

LSearch:
	Okay to call.

LSetCell:
	Okay to call.  Cell won't be drawn, though.  Standard list drawing is disabled
	when using variable-size cell mode.  Call CLVDraw() afterwards to draw the cell.

LSetSelect:
	Call CLVSetSelect().

LUpdate:
	Call CLVUpdate

*/


/*****************************************************************************/



#ifndef __CONTROLS__
#include <Controls.h>
#endif

#ifndef __DTSLib__
#include "DTS.Lib.h"
#endif

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __LISTCONTROL__
#include "ListControl.h"
#endif

#ifndef __CLPROCS__
#include "ListControlProcs.h"
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifndef __PACKAGES__
#include <Packages.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __UTILITIES__
#include "Utilities.h"
#endif



/*****************************************************************************/



typedef pascal void	(*LDEFProcPtr)(short lMessage, Boolean lSelect, Rect *lRect, Cell lCell,
								   short lDataOffset, short lDataLen, ListHandle list);

static ListHandle	gCLVList;

static void			CLVScrollContent(short h, short v);
static WindowPtr	CLVSetClip(ListHandle list);


Boolean		gMoveCell;
Point		gMoveCellStart, gMoveCellEnd;



/*****************************************************************************/



#pragma segment ListControl
void	CLVInitialize(void)
{
	if (!gclvVariableSizeCells) {
		gclvVariableSizeCells = CLVVariableSizeCells;
		gclvGetCellRect       = CLVGetCellRect;
		gclvUpdate            = CLVUpdate;
		gclvAutoScroll        = CLVAutoScroll;
		gclvSetSelect         = CLVSetSelect;
		gclvClick             = CLVClick;
		gclvAdjustScrollBars  = CLVAdjustScrollBars;
	}
}



/*****************************************************************************/



#pragma segment ListControl

static void	CLVScrollContent(short h, short v)
{
	RgnHandle	updateRgn;
	Rect		rView;

	rView  = (*gCLVList)->rView;
	ScrollRect(&rView, h, v, updateRgn = NewRgn());
	CLVUpdate(updateRgn, gCLVList);
	DisposeRgn(updateRgn);
}

static pascal void	CLVScrollAction(ControlHandle ctl, short part);
static pascal void	CLVScrollAction(ControlHandle ctl, short part)
{
	short		delta, value;
	short		oldValue, max, dx, dy;
	Boolean		vert;
	Rect		rct, rr;

	vert = (((*ctl)->contrlRect.right - (*ctl)->contrlRect.left) == 16);
	rct  = (*gCLVList)->visible;
	if ((part == inUpButton) || (part == inPageUp)) {
		for (;;) {
			if (vert) {
				if (rct.top == 1) break;
				--rct.top;
			}
			if (!vert) {
				if (rct.left == 1) break;
				--rct.left;
			}
			CLVGetCellRect(gCLVList, rct.left, rct.top, &rr);
			if (!EmptyRect(&rr)) break;
		}
	}
	CLVGetCellRect(gCLVList, rct.left, rct.top, &rct);

	if (part) {						/* If it was actually in the control. */

		delta = (vert) ? (rct.bottom - rct.top) : (rct.right - rct.left);
		if ((part == inPageUp) || (part == inPageDown)) {
			if (vert) delta = (*gCLVList)->rView.bottom - (*gCLVList)->rView.top  - delta;
			else      delta = (*gCLVList)->rView.right  - (*gCLVList)->rView.left - delta;
			if (delta < 0) delta = 0;
		}

		if ( (part == inUpButton) || (part == inPageUp) )
			delta = -delta;		/* Reverse direction for an upper. */

		value = (oldValue = GetCtlValue(ctl)) + delta;
		if (value < 0)						value = 0;
		if (value > (max = GetCtlMax(ctl))) value = max;

		if (value != oldValue) {
			SetCtlValue(ctl, value);
			dx = (vert) ? 0 : (oldValue - value);
			dy = (vert) ? (oldValue - value) : 0;
			CLVAdjustScrollBars(gCLVList);
			CLVScrollContent(dx, dy);
		}
	}
}

static Boolean	CLVScroll(ControlHandle ctl, short part, Point where);
static Boolean	CLVScroll(ControlHandle ctl, short part, Point where)
{
	ControlHandle	cc;
	short			oldValue, newValue, vv, dx, dy, nn;
	Point			pp, cell;
	Rect			rView, rct;
	Boolean			vert;

	static ControlActionUPP	cupp;

	oldValue = newValue = GetCtlValue(ctl);
	switch (part) {
		case inThumb:
			if (TrackControl(ctl, where, nil)) {
				newValue = GetCtlValue(ctl);
				if (oldValue != newValue) {
					if ((*gCLVList)->hScroll) (*gCLVList)->visible.left = 1;
					if ((*gCLVList)->vScroll) (*gCLVList)->visible.top  = 1;
					vert = (((*ctl)->contrlRect.right - (*ctl)->contrlRect.left) == 16);
					vv = 0;
					if (vert) {
						if (cc = (*gCLVList)->hScroll)
							vv = (*cc)->contrlValue;
					}
					else {
						if (cc = (*gCLVList)->vScroll)
							vv = (*cc)->contrlValue;
					}
					(vert) ? (pp.h = vv, pp.v = newValue) : (pp.h = newValue, pp.v = vv);
					rView = (*gCLVList)->rView;
					pp.h += rView.left;
					pp.v += rView.top;
					CLVFindCell(gCLVList, pp, &cell);
					CLVGetCellRect(gCLVList, cell.h, cell.v, &rct);

					if (vert) nn = newValue + ((rct.bottom - rct.top) / 2);
					else	  nn = newValue + ((rct.right  - rct.left) / 2);
					(vert) ? (pp.h = vv, pp.v = nn) : (pp.h = nn, pp.v = vv);
					pp.h += rView.left;
					pp.v += rView.top;
					CLVFindCell(gCLVList, pp, &cell);
					CLVGetCellRect(gCLVList, cell.h, cell.v, &rct);

					OffsetRect(&rct, -rView.left, -rView.top);
					newValue = (vert) ? rct.top : rct.left;
					SetCtlValue(ctl, newValue);
					newValue = (*ctl)->contrlValue;

					dx = (vert) ? 0 : (oldValue - newValue);
					dy = (vert) ? (oldValue - newValue) : 0;
					CLVAdjustScrollBars(gCLVList);
					CLVScrollContent(dx, dy);
					rct = (*gCLVList)->visible;
				}
			}
			break;
		default:
			if (!cupp) cupp = NewControlActionProc(CLVScrollAction);
			TrackControl(ctl, where, cupp);
			newValue = GetCtlValue(ctl);
			break;
	}

	return((oldValue != newValue) ? true : false);
}



/*****************************************************************************/



#pragma segment ListControl
void	CLVUpdate(RgnHandle clipRgn, ListHandle list)
{
	WindowPtr	oldPort;
	Rect		vbnds, cbnds, rView;
	short		xx, yy, cellNum, ofst, len, select;
	Point		cell;
	RgnHandle	oldClip, newClip;

	GetPort(&oldPort);
	SetPort((*list)->port);

	rView = (*list)->rView;
	GetClip(oldClip = NewRgn());
	RectRgn(newClip = NewRgn(), &rView);
	SectRgn(newClip, oldClip, newClip);
	SectRgn(newClip, clipRgn, newClip);
	SetClip(newClip);

	vbnds = (*list)->visible;
	for (yy = vbnds.top; yy < vbnds.bottom; ++yy) {
		for (xx = vbnds.left; xx < vbnds.right; ++xx) {
			CLVGetCellInfo(list, xx, yy, &cbnds, &cellNum, &select, &ofst, &len);
			cell.h = xx;
			cell.v = yy;
			CLVCallDefProc(lDrawMsg, select, &cbnds, cell, ofst, len, list);
		}
	}

	SetClip(oldClip);
	DisposeRgn(oldClip);
	DisposeRgn(newClip);
	SetPort(oldPort);
}



/*****************************************************************************/



#pragma segment ListControl
static void	CLVCallDefProc(short lMessage, short lSelect, Rect *lRect, Cell lCell,
						   short lDataOffset, short lDataLen, ListHandle list)
{
	Handle		ldp;
	LDEFProcPtr	proc;

	if (!(ldp = (*list)->listDefProc)) return;

	if (!*ldp) LoadResource(ldp);
	if (!*ldp) return;

	HLock(ldp);
	proc = (LDEFProcPtr)*ldp;
	lSelect = (lSelect) ? true: false;
	CallUniversalProc((UniversalProcPtr) proc, uppListDefProcInfo, lMessage, lSelect, lRect, lCell, lDataOffset, lDataLen, list);
	HUnlock(ldp);
}



/*****************************************************************************/



#pragma segment ListControl
Boolean	CLVClick(Point mouseLoc, short modifiers, ListHandle list)
{
	WindowPtr		oldPort, window;
	ControlHandle	ctl;
	RgnHandle		oldClip, newClip;
	Boolean			dbl, tracked, turnOff, doRects, inBounds;
	Point			cc, dd, cell, lastCell, anchor, ulSel, lrSel, pp, mm;
	short			cellNum, ofst, len, newsel, oldsel, sense, part, dx, dy, data1len, data2len;
	Rect			rView, cbnds, rr, rct, dbnds, vbnds;
	long			ll, ctime;
	char			selFlags, listFlags;
	char			data1[256], data2[256];

	gMoveCellStart.v = gMoveCellStart.h = gMoveCellEnd.v = gMoveCellEnd.h = -1;

	GetPort(&oldPort);
	SetPort(window = (*list)->port);

	rView    = (*list)->rView;
	selFlags = (*list)->selFlags;
	if (selFlags & lOnlyOne) {
		selFlags  &= (lNoNilHilite | lUseSense | lOnlyOne);
		modifiers &= (0xFFFF - shiftKey - cmdKey);
	}

	(*list)->clikLoc = mouseLoc;

	if (WhichControl(mouseLoc, 0, window, &ctl)) {
		if (!(part = FindControl(mouseLoc, window, &ctl))) {
			(*list)->clikTime = 0L;
			return(false);
		}
		if ((ctl == (*list)->hScroll) || (ctl == (*list)->vScroll)) {
			gCLVList = list;
			tracked  = CLVScroll(ctl, part, mouseLoc);
			return(false);
		}
	}

	if (!PtInRect(mouseLoc, &rView)) {
		(*list)->clikTime = 0L;
		return(false);
	}

	CLVFindCell(list, mouseLoc, &cell);
	(*list)->clikLoc = mouseLoc;
	if (cell.h == -1) {
		(*list)->clikTime = 0L;
		return(false);
	}
	if (gMoveCell) gMoveCellStart = cell;

	CLVGetCellInfo(list, cell.h, cell.v, &cbnds, &cellNum, &sense, &ofst, &len);

	GetClip(oldClip = NewRgn());
	RectRgn(newClip = NewRgn(), &rView);
	SectRgn(newClip, oldClip, newClip);
	SetClip(newClip);

	ulSel.h = ulSel.v = 0x7FFF;
	lrSel.h = lrSel.v = 0;

	if (selFlags & lUseSense) {
		if (modifiers & shiftKey) {
			modifiers |= cmdKey;
		}
	}

	cc.h = cc.v = 1;
	turnOff = true;
	if (modifiers & shiftKey) {
		if (!(selFlags & lUseSense)) turnOff = false;
		if (!sense)                  turnOff = false;
		if (selFlags & lNoExtend)    turnOff = false;
	}
	else {
		if (modifiers & cmdKey)   turnOff = false;
		if (sense)                turnOff = false;
	}
	while (LGetSelect(true, &cc, list)) {
		CLVGetCellInfo(list, cc.h, cc.v, &cbnds, &cellNum, &oldsel, &ofst, &len);
		if (turnOff) {
			if ((cell.h != cc.h) || (cell.v != cc.v)) {
				(*list)->cellArray[cellNum] &= 0x7FFF;
				CLVCallDefProc(lHiliteMsg, false, &cbnds, cc, ofst, len, list);
			}
		}
		else {
			if (ulSel.v > cc.v) ulSel.v = cc.v;
			if (ulSel.h > cc.h) ulSel.h = cc.h;
			if (lrSel.v < cc.v) lrSel.v = cc.v;
			if (lrSel.h < cc.h) lrSel.h = cc.h;
			if (selFlags & lNoDisjoint) {
				(*list)->cellArray[cellNum] &= 0x7FFF;
				CLVCallDefProc(lHiliteMsg, false, &cbnds, cc, ofst, len, list);
			}
		}
		if (!LNextCell(true, true, &cc, list)) break;
	}

	anchor = cell;
	if (!(selFlags & lNoExtend)) {
		if (lrSel.v) {
			for (;;) {
				if (cell.h <= ulSel.h) {
					anchor = lrSel;
					break;
				}
				if (cell.v <= ulSel.v) {
					anchor = lrSel;
					break;
				}
				anchor = ulSel;
				break;
			}
		}
	}

	lastCell.h = lastCell.v = -1;

	cc  = (*list)->lastClick;
	dbl = ((cc.h == cell.h) && (cc.v == cell.v)) ? true : false;
	(*list)->lastClick = cell;
	ctime = (*list)->clikTime;
	(*list)->clikTime = TickCount();

	doRects = true;

	do {

		if ((cell.h != lastCell.h) || (cell.v != lastCell.v)) {

			for (;;) {

				if (doRects) {
					if (modifiers & shiftKey) {
						rr.top    = (cell.v < anchor.v) ? cell.v : anchor.v;
						rr.left   = (cell.h < anchor.h) ? cell.h : anchor.h;
						rr.bottom = (cell.v > anchor.v) ? cell.v : anchor.v;
						rr.right  = (cell.h > anchor.h) ? cell.h : anchor.h;
						++rr.bottom;
						++rr.right;
						cc.h = cc.v = 1;
						turnOff = true;
						if (selFlags & lNoExtend) turnOff = false;
						if (turnOff) {
							while (LGetSelect(true, &cc, list)) {
								if (!PtInRect(cc, &rr)) {
									CLVGetCellInfo(list, cc.h, cc.v, &cbnds, &cellNum,
												   &oldsel, &ofst, &len);
									(*list)->cellArray[cellNum] &= 0x7FFF;
									CLVCallDefProc(lHiliteMsg, false, &cbnds, cc, ofst, len, list);
								}
								if (!LNextCell(true, true, &cc, list)) break;
							}
						}
						for (cc.v = rr.top; cc.v < rr.bottom; ++cc.v) {
							for (cc.h = rr.left; cc.h < rr.right; ++cc.h) {
								oldsel = (LGetSelect(false, &cc, list)) ? 0x8000 : 0x0000;
								newsel = 0x8000;
								if (selFlags & lUseSense)
									newsel = sense ^ 0x8000;
								if (selFlags & lNoNilHilite)
									if (!len)
										newsel = 0;
								if (newsel != oldsel) {
									CLVGetCellInfo(list, cc.h, cc.v, &cbnds, &cellNum,
												   &oldsel, &ofst, &len);
									(*list)->cellArray[cellNum] &= 0x7FFF;
									(*list)->cellArray[cellNum] |= newsel;
									CLVCallDefProc(lHiliteMsg, newsel, &cbnds, cc, ofst, len, list);
								}
							}
						}
						if (selFlags & lNoRect) doRects = false;
						break;
					}
				}

				if (lastCell.h != -1) {
					oldsel = (LGetSelect(false, &lastCell, list)) ? 0x8000 : 0x0000;
					newsel = 0;
					if (modifiers & cmdKey) newsel = (sense ^ 0x8000);
					else {
						if (selFlags & lNoRect) 
							if (modifiers & shiftKey)
								newsel = 0x8000;
					}
					if (selFlags & lExtendDrag)
						if (!(modifiers & (cmdKey | shiftKey)))
							newsel = 0x8000;
					if (newsel != oldsel) {
						CLVGetCellInfo(list, lastCell.h, lastCell.v, &cbnds, &cellNum,
									   &oldsel, &ofst, &len);
						(*list)->cellArray[cellNum] &= 0x7FFF;
						(*list)->cellArray[cellNum] |= newsel;
						CLVCallDefProc(lHiliteMsg, false, &cbnds, lastCell, ofst, len, list);
					}
				}
				if (cell.h != -1) {
					oldsel = (LGetSelect(false, &cell, list)) ? 0x8000 : 0x0000;
					newsel = 0x8000;
					if (modifiers & cmdKey) newsel = (sense ^ 0x8000);
					if (selFlags & lNoNilHilite)
						if (!len)
							newsel = 0;
					if (newsel != oldsel) {
						CLVGetCellInfo(list, cell.h, cell.v, &cbnds, &cellNum,
									   &oldsel, &ofst, &len);
						(*list)->cellArray[cellNum] &= 0x7FFF;
						(*list)->cellArray[cellNum] |= newsel;
						CLVCallDefProc(lHiliteMsg, newsel, &cbnds, cc, ofst, len, list);
					}
				}

				break;
			}
		}

		GetMouse(&mouseLoc);
		lastCell = cell;
		dbnds    = (*list)->dataBounds;

		CLVGetCellRect(list, dbnds.right - 1, dbnds.bottom - 1, &rct);
		rr = rView;
		rr.right  = rct.right;
		rr.bottom = rct.bottom;
		SectRect(&rView, &rr, &rr);
		ll = PinRect(&rr, mouseLoc);
		mm = *(Point *)&ll;
		CLVFindCell(list, mm, &cc);
		if (!EqualPt(cc, lastCell)) {
			cell = lastCell;
			if (cc.h > lastCell.h) ++cell.h;
			if (cc.h < lastCell.h) --cell.h;
			if (cc.v > lastCell.v) ++cell.v;
			if (cc.v < lastCell.v) --cell.v;
			if (gMoveCell) {
				data1len = data2len = 256;
				LGetCell(data1, &data1len, cell,     list);
				LGetCell(data2, &data2len, lastCell, list);
				LSetCell(data1,  data1len, lastCell, list);
				LSetCell(data2,  data2len, cell,     list);
				CLVGetCellInfo(list, cell.h,     cell.v,     &cbnds, &cellNum, &sense, &ofst, &len);
				CLVCallDefProc(lDrawMsg, sense, &cbnds, cell, ofst, len, list);
				CLVGetCellInfo(list, lastCell.h, lastCell.v, &cbnds, &cellNum, &sense, &ofst, &len);
				CLVCallDefProc(lDrawMsg, sense, &cbnds, cell, ofst, len, list);
				gMoveCellEnd = cell;
			}
			continue;
		}

		if (!PtInRect(mouseLoc, &rView)) {
			listFlags = (*list)->listFlags;
			vbnds = (*list)->visible;
			dx = dy = 0;
			if (listFlags & lDoHAutoscroll) {
				if (mouseLoc.h <  rView.left)  dx = -1;
				if (mouseLoc.h >= rView.right) dx = 1;
			}
			if (listFlags & lDoVAutoscroll) {
				if (mouseLoc.v <  rView.top)    dy = -1;
				if (mouseLoc.v >= rView.bottom) dy = 1;
			}

			CLVGetCellRect(list, vbnds.right - 1, vbnds.bottom - 1, &rct);
			if (dx == 1)
				if (vbnds.right >= dbnds.right)
					if (rct.right <= rView.right)
						dx = 0;
			if (dy == 1)
				if (vbnds.bottom >= dbnds.bottom)
					if (rct.bottom <= rView.bottom)
						dy = 0;

			if (dx | dy) {
				pp.h  = (*list)->visible.left;
				pp.v  = (*list)->visible.top;
				cc    = pp;
				for (;;) {
					inBounds = false;
					cc.h += dx;
					cc.v += dy;
					if (!cc.h)				  break;
					if (!cc.v)				  break;
					if (cc.h == dbnds.right)  break;
					if (cc.v == dbnds.bottom) break;
					inBounds = true;
					CLVGetCellRect(list, cc.h, cc.v, &rr);
					if (!EmptyRect(&rr)) break;
				}
				if (inBounds) {
					CLVGetCellRect(list, pp.h, pp.v, &rct);
					gCLVList = list;
					dx = rr.left - rct.left;
					dy = rr.top  - rct.top;
					SetClip(oldClip);
					if (ctl = (*list)->hScroll)
						SetCtlValue(ctl, (*ctl)->contrlValue + dx);
					if (ctl = (*list)->vScroll)
						SetCtlValue(ctl, (*ctl)->contrlValue + dy);
					SetClip(newClip);
					CLVAdjustScrollBars(list);
					CLVScrollContent(-dx, -dy);

					CLVGetCellRect(list, dbnds.right - 1, dbnds.bottom - 1, &rct);
					rr = rView;
					rr.right  = rct.right;
					rr.bottom = rct.bottom;
					SectRect(&rView, &rr, &rr);
					ll = PinRect(&rr, mouseLoc);
					mm = *(Point *)&ll;
					CLVFindCell(list, mm, &cell);
					if (gMoveCell) {
						if (cell.v >= 0) {
							cc = lastCell;
							for (cc = lastCell; !EqualPt(cc, cell); cc = dd) {
								dd = cc;
								if (dd.h < cell.h) ++dd.h;
								if (dd.h > cell.h) --dd.h;
								if (dd.v < cell.v) ++dd.v;
								if (dd.v > cell.v) --dd.v;
								data1len = data2len = 256;
								LGetCell(data1, &data1len, cc, list);
								LGetCell(data2, &data2len, dd, list);
								LSetCell(data1,  data1len, dd, list);
								LSetCell(data2,  data2len, cc, list);
								CLVGetCellInfo(list, cc.h, cc.v, &cbnds, &cellNum, &sense, &ofst, &len);
								CLVCallDefProc(lDrawMsg, sense, &cbnds, cell, ofst, len, list);
								CLVGetCellInfo(list, dd.h, dd.v, &cbnds, &cellNum, &sense, &ofst, &len);
								CLVCallDefProc(lDrawMsg, sense, &cbnds, cell, ofst, len, list);
								gMoveCellEnd = cell;
							}
						}
					}
				}
			}
		}

	} while (StillDown());

	SetClip(oldClip);
	DisposeRgn(oldClip);
	DisposeRgn(newClip);
	SetPort(oldPort);

	if (dbl) {
		cc = (*list)->lastClick;
		if ((cc.h == cell.h) && (cc.v == cell.v)) {
			if (TickCount() > (ctime + GetDblTime()))
				dbl = false;
			else
				(*list)->clikTime = 0L;
		}
		else {
			dbl = false;
			(*list)->clikTime = 0L;
		}
	}

	return(dbl);
}



/*****************************************************************************/



#pragma segment ListControl
static WindowPtr	CLVSetClip(ListHandle list)
{
	static WindowPtr	oldPort;
	WindowPtr			window;
	static RgnHandle	oldClip;
	RgnHandle			newClip;
	Rect				rView;

	if (list) {
		GetPort(&oldPort);
		SetPort(window = (*list)->port);
		rView = (*list)->rView;
		GetClip(oldClip = NewRgn());
		RectRgn(newClip = NewRgn(), &rView);
		SectRgn(newClip, oldClip, newClip);
		SetClip(newClip);
		DisposeRgn(newClip);
	}
	else {
		SetClip(oldClip);
		SetPort(oldPort);
	}

	return(window);
}



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



#pragma segment ListControl
void	CLVVariableSizeCells(ListHandle list)
{
	ControlHandle	viewCtl;
	CLDataHndl		listData;
	short			mode, len;
	short			locSize[2];
	Rect			dbnds;
	Point			cell;
	Str255			pstr;

	CLVInitialize();

	if (!(viewCtl = CLViewFromList(list))) return;

	listData = (CLDataHndl)(*viewCtl)->contrlData;
	mode     = (*listData)->mode;
	if (mode & clVariable) return;		/* List already variable mode. */

	mode |= clVariable;
	(*listData)->mode = mode;
	LDoDraw(false, list);				/* We're doing it now.  Don't let List Manager play. */

	dbnds = (*list)->dataBounds;

	for (locSize[0] = cell.h = cell.v = 0; ++cell.h < dbnds.right;) {
		len = 255;
		LGetCell(pstr + 1, &len, cell, list);
		pstr[0] = len;
		locSize[1] = (pstr[0]) ? p2dec(pstr, nil) : (*list)->cellSize.h;
		LSetCell(locSize, (2 * sizeof(short)), cell, list);
		locSize[0] += locSize[1];
	}

	for (locSize[0] = cell.h = cell.v = 0; ++cell.v < dbnds.bottom;) {
		len = 255;
		LGetCell(pstr + 1, &len, cell, list);
		pstr[0] = len;
		locSize[1] = (pstr[0]) ? p2dec(pstr, nil) : (*list)->cellSize.v;
		LSetCell(locSize, (2 * sizeof(short)), cell, list);
		locSize[0] += locSize[1];
	}

	CLVAdjustScrollBars(list);		/* Fix scrollbars to reflect the size of the List. */
									/* This also fixes the visible field of the list.  */
}



/*****************************************************************************/


/* Figure out which cells are at least partially visible.  It's a pain...
** This also saves the visible cells rect into (*list)->visible so that other functions
** can get it quicker than the below hunk-o-code. */

#pragma segment ListControl
void	CLVGetVisCells(ListHandle list, Rect *vbnds)
{
	Rect			rView, cellRct, rct;
	ControlHandle	ctl;
	short			len, locSize[2], dx, dy;
	Point			cell;

	*vbnds = (*list)->dataBounds;
	rView  = (*list)->rView;

	if (ctl = (*list)->hScroll) dx = (*ctl)->contrlValue;
	else {
		cell.v = 0;
		if (!(cell.h = (*list)->visible.left)) ++cell.h;
		len = 2 * sizeof(short);
		LGetCell(locSize, &len, cell, list);
		dx = locSize[0];
	}
	if (ctl = (*list)->vScroll) dy = (*ctl)->contrlValue;
	else {
		cell.h = 0;
		if (!(cell.v = (*list)->visible.top)) ++cell.v;
		len = 2 * sizeof(short);
		LGetCell(locSize, &len, cell, list);
		dy = locSize[0];
	}

	OffsetRect(&rView, dx, dy);
	(*list)->visible.left = (*list)->visible.top = 1;

	for (; vbnds->left < vbnds->right; ++vbnds->left) {
		CLVGetCellRect(list, vbnds->left, 1, &cellRct);
		cellRct.top    = rView.top;
		cellRct.bottom = rView.bottom;
		SectRect(&rView, &cellRct, &rct);
		if (!EmptyRect(&rct)) break;
	}
	for (; vbnds->right > vbnds->left;) {
		CLVGetCellRect(list, --vbnds->right, 1, &cellRct);
		cellRct.top    = rView.top;
		cellRct.bottom = rView.bottom;
		SectRect(&rView, &cellRct, &rct);
		if (!EmptyRect(&rct)) {
			++vbnds->right;
			break;
		}
	}

	for (; vbnds->top < vbnds->bottom; ++vbnds->top) {
		CLVGetCellRect(list, 1, vbnds->top, &cellRct);
		cellRct.left  = rView.left;
		cellRct.right = rView.right;
		SectRect(&rView, &cellRct, &rct);
		if (!EmptyRect(&rct)) break;
	}
	for (; vbnds->bottom > vbnds->top;) {
		CLVGetCellRect(list, 1, --vbnds->bottom, &cellRct);
		cellRct.left  = rView.left;
		cellRct.right = rView.right;
		SectRect(&rView, &cellRct, &rct);
		if (!EmptyRect(&rct)) {
			++vbnds->bottom;
			break;
		}
	}

	(*list)->visible = *vbnds;

	return;
}



/*****************************************************************************/



/* This function looks up the position of cell x,y by getting the info from
** x,0 and 0,y cells.  Row 0 and column 0 are never displayed.  They hold the
** row and column sizes. */

#pragma segment ListControl
void	CLVGetCellRect(ListHandle list, short xx, short yy, Rect *cbnds)
{
	Point	cell;
	short	len, locSize[2], dx, dy;

	if ((!xx) || (!yy)) {
		SetRect(cbnds, 0, 0, 0, 0);
		return;
	}

	cell.h = 0;
	cell.v = yy;
	len = 2 * sizeof(short);
	LGetCell(locSize, &len, cell, list);
	cbnds->top    = locSize[0];
	cbnds->bottom = locSize[0] + locSize[1];

	cell.h = xx;
	cell.v = 0;
	len = 2 * sizeof(short);
	LGetCell(locSize, &len, cell, list);
	cbnds->left   = locSize[0];
	cbnds->right  = locSize[0] + locSize[1];

	OffsetRect(cbnds, (*list)->rView.left, (*list)->rView.top);

	if (!(cell.h = (*list)->visible.left)) ++cell.h;
	cell.v = 0;
	len = 2 * sizeof(short);
	LGetCell(locSize, &len, cell, list);
	dx = locSize[0];

	cell.h = 0;
	if (!(cell.v = (*list)->visible.top)) ++cell.v;
	len = 2 * sizeof(short);
	LGetCell(locSize, &len, cell, list);
	dy = locSize[0];

	OffsetRect(cbnds, -dx, -dy);
}



/*****************************************************************************/



#pragma segment ListControl
void	CLVFindCell(ListHandle list, Point mouseLoc, Point *cell)
{
	Rect	dbnds, rrct, rct;
	short	xx, yy;

	dbnds = (*list)->dataBounds;

	CLVGetCellRect(list, 1, 1, &rct);
	rrct.left = rct.left;
	CLVGetCellRect(list, dbnds.right - 1, 1, &rct);
	rrct.right = rct.right;

	for (yy = dbnds.top; yy < dbnds.bottom; ++yy) {
		CLVGetCellRect(list, 1, yy, &rct);
		rrct.top    = rct.top;
		rrct.bottom = rct.bottom;
		if (PtInRect(mouseLoc, &rrct)) break;
	}

	if (yy < dbnds.bottom) {
		for (xx = dbnds.left; xx < dbnds.right; ++xx) {
			CLVGetCellRect(list, xx, yy, &rct);
			if (PtInRect(mouseLoc, &rct)) {
				cell->h = xx;
				cell->v = yy;
				return;
			}
		}
	}

	cell->h = cell->v = -1;
	return;
}



/*****************************************************************************/



#pragma segment ListControl
void	CLVGetCellInfo(ListHandle list, short xx, short yy, Rect *cbnds, short *cellNum,
					   short *select, short *ofst, short *len)
{
	short	ww;

	CLVGetCellRect(list, xx, yy, cbnds);
	ww       = (*list)->dataBounds.right - (*list)->dataBounds.left;
	*cellNum = ww * yy + xx;
	*ofst    = (*list)->cellArray[*cellNum];
	*len     = (*list)->cellArray[*cellNum + 1] & 0x7FFF;
	*select  = *ofst & 0x8000;
	*ofst   &= 0x7FFF;
	*len    -= *ofst;
}



/*****************************************************************************/



#pragma segment ListControl
void	CLVAdjustScrollBars(ListHandle list)
{
	Rect			rView, dbnds, rct;
	short			oldx, oldy, max;
	ControlHandle	ctl;
	Point			pp, cell;

	rView = (*list)->rView;
	dbnds = (*list)->dataBounds;
	++rView.right;			/* Account for the fact that the top of a rect is in, whereas the */
	++rView.bottom;			/* bottom of a rect is out.  This makes top and bottom the same.  */

	if ((*list)->hScroll) (*list)->visible.left = 1;
	if ((*list)->vScroll) (*list)->visible.top  = 1;

	oldx = oldy = 0;
	if (ctl = (*list)->hScroll) {
		oldx = (*ctl)->contrlValue;
		CLVGetCellRect(list, dbnds.right - 1, 1, &rct);
		max = rct.right - rView.right;
		if (max < 0) max = 0;
		else {
			pp.h = rView.left + max;
			pp.v = rView.top;
			CLVFindCell(list, pp, &cell);
			CLVGetCellRect(list, cell.h, cell.v, &rct);
			max = rct.right - rView.left;
		}
		SetCtlMax(ctl, max);
	}
	if (ctl = (*list)->vScroll) {
		oldy = (*ctl)->contrlValue;
		CLVGetCellRect(list, 1, dbnds.bottom - 1, &rct);
		max = rct.bottom - rView.bottom;
		if (max < 0) max = 0;
		else {
			pp.h = rView.left;
			pp.v = rView.top + max;
			CLVFindCell(list, pp, &cell);
			CLVGetCellRect(list, cell.h, cell.v, &rct);
			max = rct.bottom - rView.top;
		}
		SetCtlMax(ctl, max);
	}

	CLVGetVisCells(list, &rct);		/* Calc vis area and store in list. */
}



/*****************************************************************************/



#pragma segment ListControl
void	CLVSetSelect(Boolean select, Point cell, ListHandle list)
{
	WindowPtr	oldPort;
	RgnHandle	oldClip, newClip;
	Rect		rView, cbnds;
	short		cellNum, oldsel, newsel, ofst, len;

	GetPort(&oldPort);
	SetPort((*list)->port);
	rView = (*list)->rView;
	GetClip(oldClip = NewRgn());
	RectRgn(newClip = NewRgn(), &rView);
	SectRgn(newClip, oldClip, newClip);
	SetClip(newClip);

	CLVGetCellInfo(list, cell.h, cell.v, &cbnds, &cellNum, &oldsel, &ofst, &len);
	newsel = (select) ? 0x8000 : 0x0000;
	if (newsel != oldsel) {
		(*list)->cellArray[cellNum] &= 0x7FFF;
		(*list)->cellArray[cellNum] |= newsel;
		CLVCallDefProc(lHiliteMsg, newsel, &cbnds, cell, ofst, len, list);
	}

	SetClip(oldClip);
	DisposeRgn(oldClip);
	DisposeRgn(newClip);
	SetPort(oldPort);
}



/*****************************************************************************/



#pragma segment ListControl
void	CLVAutoScroll(ListHandle list)
{
	WindowPtr		oldPort;
	RgnHandle		oldClip, newClip;
	Rect			rView, dbnds, vbnds, rct, rr;
	Point			cell, cc, pp;
	short			dx, dy, ddx, ddy;
	ControlHandle	ctl;
	Boolean			inBounds;

	ddx = ddy = 0;
	cell.h = cell.v = 1;

	if (LGetSelect(true, &cell, list)) {

		rView = (*list)->rView;
		dbnds = (*list)->dataBounds;
		vbnds = (*list)->visible;

		while ((!PtInRect(cell, &vbnds))) {

			if (EmptyRect(&vbnds)) return;
					/* This shouldn't happen, but it would be bad if it did. */

			dx = dy = 0;
			if (cell.h <  vbnds.left)   dx = -1;
			if (cell.h >= vbnds.right)  dx = 1;
			if (cell.v <  vbnds.top)    dy = -1;
			if (cell.v >= vbnds.bottom) dy = 1;

			CLVGetCellRect(list, vbnds.right - 1, vbnds.bottom - 1, &rct);
			if (dx == 1)
				if (vbnds.right >= dbnds.right)
					if (rct.right <= rView.right)
						dx = 0;
			if (dy == 1)
				if (vbnds.bottom >= dbnds.bottom)
					if (rct.bottom <= rView.bottom)
						dy = 0;
			if ((!dx) && (!dy)) break;

			pp.h  = (*list)->visible.left;
			pp.v  = (*list)->visible.top;
			cc    = pp;

			for (;;) {
				inBounds = false;
				cc.h += dx;
				cc.v += dy;
				if (!cc.h)				  break;
				if (!cc.v)				  break;
				if (cc.h == dbnds.right)  break;
				if (cc.v == dbnds.bottom) break;
				inBounds = true;
				CLVGetCellRect(list, cc.h, cc.v, &rr);
				if (!EmptyRect(&rr)) break;
			}
			if (!inBounds) break;

			CLVGetCellRect(list, pp.h, pp.v, &rct);
			ddx += rr.left - rct.left;
			ddy += rr.top  - rct.top;

			OffsetRect(&vbnds, dx, dy);
			(*list)->visible = vbnds;
			if (ctl = (*list)->hScroll) (*ctl)->contrlValue += ddx;
			if (ctl = (*list)->vScroll) (*ctl)->contrlValue += ddy;
			CLVGetVisCells(list, &vbnds);
			if (ctl = (*list)->hScroll) (*ctl)->contrlValue -= ddx;
			if (ctl = (*list)->vScroll) (*ctl)->contrlValue -= ddy;
		}

		if ((ddx) || (ddy)) {

			GetPort(&oldPort);
			SetPort((*list)->port);

			if (ctl = (*list)->hScroll) SetCtlValue(ctl, (*ctl)->contrlValue + ddx);
			if (ctl = (*list)->vScroll) SetCtlValue(ctl, (*ctl)->contrlValue + ddy);

			GetClip(oldClip = NewRgn());
			RectRgn(newClip = NewRgn(), &rView);
			SectRgn(newClip, oldClip, newClip);
			SetClip(newClip);
			
			CLVAdjustScrollBars(list);
			gCLVList = list;
			CLVScrollContent(-ddx, -ddy);

			SetClip(oldClip);
			DisposeRgn(oldClip);
			DisposeRgn(newClip);
			SetPort(oldPort);
		}
	}
}



/*****************************************************************************/



#pragma segment ListControl
void	CLVAdjustCellLocs(ListHandle list)
{
	short	len, locSize[2], ls[2];
	Rect	dbnds;
	Point	cell;

	dbnds = (*list)->dataBounds;

	for (locSize[0] = cell.h = cell.v = 0; ++cell.h < dbnds.right;) {
		len = 2 * sizeof(short);
		LGetCell(ls, &len, cell, list);
		locSize[1] = ls[1];
		LSetCell(locSize, len, cell, list);
		locSize[0] += locSize[1];
	}

	for (locSize[0] = cell.h = cell.v = 0; ++cell.v < dbnds.bottom;) {
		len = 2 * sizeof(short);
		LGetCell(ls, &len, cell, list);
		locSize[1] = ls[1];
		LSetCell(locSize, len, cell, list);
		locSize[0] += locSize[1];
	}

	CLVAdjustScrollBars(list);
}



/*****************************************************************************/



#pragma segment ListControl
short	CLVAddColumn(short count, short colNum, short ww, ListHandle list)
{
	short	rval, locSize[2], xx;
	Point	cell;

	rval = LAddColumn(count, colNum, list);

	cell.v = 0;
	locSize[0] = 0;
	locSize[1] = ww;
	for (xx = 0; xx < count; ++xx) {
		cell.h = rval + xx;
		LSetCell(locSize, (2 * sizeof(short)), cell, list);
	}
	CLVAdjustCellLocs(list);

	return(rval);
}



/*****************************************************************************/



#pragma segment ListControl
short	CLVAddRow(short count, short rowNum, short hh, ListHandle list)
{
	short	rval, locSize[2], yy;
	Point	cell;

	rval = LAddRow(count, rowNum, list);

	cell.h = 0;
	locSize[0] = 0;
	locSize[1] = hh;
	for (yy = 0; yy < count; ++yy) {
		cell.v = rval + yy;
		LSetCell(locSize, (2 * sizeof(short)), cell, list);
	}
	CLVAdjustCellLocs(list);

	return(rval);
}



/*****************************************************************************/



#pragma segment ListControl
void	CLVDraw(Point cell, ListHandle list)
{
	Rect			cbnds;
	short			cellNum, select, ofst, len;

	if (list) {
		CLVSetClip(list);
		CLVGetCellInfo(list, cell.h, cell.v, &cbnds, &cellNum, &select, &ofst, &len);
		CLVCallDefProc(lDrawMsg, select, &cbnds, cell, ofst, len, list);
		CLVSetClip(nil);
	}
}




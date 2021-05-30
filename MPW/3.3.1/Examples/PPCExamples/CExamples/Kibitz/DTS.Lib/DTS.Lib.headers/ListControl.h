#ifndef __LISTCONTROL__
#define __LISTCONTROL__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __LISTS__
#include <Lists.h>
#endif

#ifndef __WINDOWS__
#include <Windows.h>
#endif

typedef void	(*CLGetCompareDataProcPtr)(void *src, short srclen, void *dst, short *dstlen);
typedef short	(*CLDoCompareDataProcPtr)(void *ptra, void *ptrb, short lena, short lenb);
typedef Boolean	(*CLKeyFilterProcPtr)(ListHandle list, EventRecord *event);

typedef struct CLDataRec {
	short					mode;
	CLGetCompareDataProcPtr	getCompareData;
	CLDoCompareDataProcPtr	doCompareData;
	CLKeyFilterProcPtr		keyFilter;
} CLDataRec;
typedef CLDataRec *CLDataPtr, **CLDataHndl;

void			CLActivate(Boolean makeActive, ListHandle listHndl);
	/* makeActive:	true to make the control the active control.
	**			  	false to inactivate the control.
	** ListHandle:	The list to activate or deactivate.
	**
	** Activate this List record.  Activation is not done by calling LActivate().
	** The active control is indicated by the 2-pixel thick border around the
	** List control.  This allows all List controls in a window to display which
	** cells are selected.  This behavior can be overridden by calling LActivate()
	** on the List record for List controls.
	** Human interface dictates that at most only a single List control has this
	** active border.  For this reason, this function scans for other List
	** controls in the window and removes the border from any other that it finds. */

Boolean			CLClick(WindowPtr window, EventRecord *event, short *action);
	/* window:	The window to check for a List control click in.
	**
	** event:	The event record holding the mouseDown event.
	**
	** action:	Used to return the action taken by CLClick.  (Pass in nil if you don't care.)
	**			If 0 returned:	 No action taken.
	**			If 1 returned:	 The active list control used the click.
	**			If -1 returned:	 A new List control was activated (and the old one deactivated.)
	**
	** This is called when a mouseDown occurs in the content of a window.  It
	** returns true if the mouseDown caused a List action to occur.  Events
	** that are handled include if the user clicks on a scrollbar that is
	** associated with a List control. */

ControlHandle	CLCtlHit(void);
	/* The List control that was hit by calling FindControl is saved in a
	** global variable, since the CDEF has no way of returning what kind it was.
	** To determine that it was a List control that was hit, first call this
	** function.  The first call returns the old value in the global variable,
	** plus it resets the global to nil.  Then call FindControl(), and then
	** call this function again.  If it returns nil, then a List control
	** wasn't hit.  If it returns non-nil, then it was a List control that
	** was hit, and specifically the one returned. */

Boolean			CLEvent(WindowPtr window, EventRecord *event, short *action);
	/* window:	The window to check for a List control click in.
	**
	** event:	The event record holding the mouseDown event.
	**
	** action:	Used to return the action taken by CLClick.  (Pass in nil if you don't care.)
	**			For click events:
	**				If 0 returned:	 No action taken.
	**				If 1 returned:	 The active list control used the click.
	**				If -1 returned:	 A new List control was activated (and the old one deactivated.)
	**			For key events:
	**				If 0 returned:	 No action taken.
	**				If 1 returned:	 Key positioning occured on the active control.
	**
	** Handle the event if it applies to the active List control.  If some
	** action occured due to the event, return true. */

ListHandle		CLFindActive(WindowPtr window);
	/* Returns the active List control, if any.  If nil is passed in, then
	** the return value represents whatever List control is active, independent
	** of what window it is in.  If a window is passed in, then it returns a
	** List control only if the active control is in the specified window.
	** If the active List control is in some other window, then nil is returned. */

ControlHandle	CLFindCtl(WindowPtr window, EventRecord *event, ListHandle *listHndl, ControlHandle *ctlHit);
	/* This determines if a List control was clicked on, or if a related scrollbar was
	** clicked on.  If a List control or List scrollbar was clicked on, then true is returned,
	** as well as the List handle and the handle to the view control. */

ListHandle		CLFromScroll(ControlHandle scrollCtl, ControlHandle *retCtl);
	/* Find the List record that is related to the indicated scrollbar. */

ListHandle		CLGetList(WindowPtr window, short lnum);
/* Get the Nth List control in the control list of a window. */

short			CLInsert(ListHandle listHndl, char *data, short dataLen, short row, short col);
	/* Insert a cell alphabetically into the list.  Whichever parameter is passed in
	** as -1, either row or column, that is the dimension that is determined.  The method of
	** handling he comparisons has been changed to allow customization of the list data and
	** search methods.  Before, it was assumed that the cell content was text, and that the
	** default LDEF was being used.  If you write a custom LDEF that uses a different data
	** format, you had problems before.  Now, with the addition of two procedure pointers, you
	** can customize the data comparisons.
	** The two new procs are:
	**	  1) getCompareData
	**	  2) doCompareData
	** The first proc, getCompareData, if nil, simply gets the data out of the cell for
	** comparison purposes.  If it is not nil, then the proc is called, and the proc gets
	** the data out of the cell.  The proc can then get whatever data it needs to for the
	** purpose of comparing to other cells and finding the insert location in the list.
	** The second proc, doCompareData, if nil tells the List control to call IUMagString
	** for the purpose of comparison.  If it is not nil, then the proc is called instead of
	** IUMagString, and you can do whatever kind of comparison you wish.  Your proc is a
	** replacement for IUMagString, so it should be of that form, except that the prototype
	** is a C prototype, instead of type pascal.
	**
	** The prototypes are:
	**
	** typedef void  (*CLGetCompareDataProcPtr)(void *src, short srclen, void *dst, short *dstlen);
	** typedef short (*CLDoCompareDataProcPtr)(void *ptra, void *ptrb, short lena, short lenb);
	**
	** The GetCompareData proc is passed in a reference to the data, and a length.  Its job is to
	** then return the data and data length of what the compare data should look like.
	**
	** The DoCompareData proc is just a replacement for IUMagString.  Parameters are as expected.
	** To set the procs, you first need to have a List control.  The below example assumes that
	** the window has a single List control.
	**
	**
	** static short		MyDoCompareData(void *ptra, void *ptrb, short lena, short lenb);
	** static void		MyGetCompareData(void *src, short srclen, void *dst, short *dstlen);
	** static Boolean	MyKeyFilter(ListHandle list, EventRecord *event);
	**
	** ControlHandle	ctl;
	** ListHandle		list;
	** CLDataHndl		listData;
	**
	** ctl = CLNext(window, &list, nil, 1, false);	     Get first (only) List control in window.
	** listData = (CLDataHndl)(*ctl)->contrlData;	     Get the listData handle for the control.
	** (*listData)->getCompareData = MyGetCompareData;   Set the procs.
	** (*listData)->getCompareData = MyDoCompareData;
	** (*listData)->keyFilter      = MyKeyFilter;
	*/

Boolean			CLKey(WindowPtr window, EventRecord *event);
	/* See if the keypress event applies to the List control, and if it does, handle it and
	** return true.  The keypress can only be used by the List control if the List control
	** has key-positioning set. */

ListHandle		CLNew(short viewID, Boolean vis, Rect *vRect, short numRows, short numCols,
					  short cellHeight, short cellWidth, short theLProc,
					  WindowPtr window, short mode);
	/* Create a new List control.  See “=Using ListControl.c” for how to use this call. */

ControlHandle	CLNext(WindowPtr window, ListHandle *listHndl, ControlHandle ctl,
					   short dir, Boolean justActive);
	/* Get the next List control in the window.  You pass it a control handle
	** for the view control, or nil to start at the beginning of the window.
	** It returns both a List handle and the view control handle for that
	** List record.  If none is found, nil is returned.  This allows you to
	** repeatedly call this function and walk through all the List controls
	** in a window. */

void			CLPrint(RgnHandle clipRgn, ListHandle listHndl, short *row, short *col,
						short leftEdge, Rect *drawRct);
	/* From the starting for or column, print as many cells as will fit into the
	** designated rect.  Pass in a starting row and column, and they will be
	** adjusted to indicate the first cell that didn't fit into the rect.  If all
	** remaining cells were printed, the row is returned as -1.  The bottom of the
	** rect to print in is also adjusted to indicate where the actual cut-off
	** point was. */

short			CLRowOrColSearch(ListHandle listHndl, void *data, short dataLen,
								 short row, short col);
	/* Find the location in the list where the data would belong if inserted.  The row
	** and column are passed in.  If either is -1, that is the dimension that will be
	** determined and returned.  The two comparison procs getCompareData and doCompareData are
	** used in this function.  See CLInsert for a description of these procs. */

void			CLUpdate(RgnHandle clipRgn, ListHandle list);
	/* Draw the List control in the correct form. */

ControlHandle	CLViewFromList(ListHandle listHndl);
	/* Return the control handle for the view control that owns the List
	** record.  Use this to find the view to do customizations such as changing
	** the update procedure for this List control. */

ListHandle		CLWindActivate(WindowPtr window, Boolean displayIt);
	/* This window is becoming active or inactive.  The borders of the List
	** controls need to be redrawn due to this.  For each List control in the
	** window, redraw the active border. */

void			CLSize(ListHandle list, short newH, short newV);
	/* This resizes the list and it's viewCtl. */

void			CLMove(ListHandle list, short newH, short newV);
	/* This moves the list and its viewCtl. */

void			CLShow(ListHandle list);
Rect			CLHide(ListHandle list);

void			CLVInitialize(void);
	/* Call this upon startup of any application that wants to be able to use the
	** variable-size cell feature of the List control.  For AppsToGo-created List control
	** definitions to be variable-size automatically, this must be called first.
	** You can call CLVVariableSizeCells() at a later time to utilize this feature, as it
	** calls CLVInitialize(). */

void			CLVVariableSizeCells(ListHandle list);
	/* This is called to convert a List control to one that has variable size rows and columns. */


void			CLVAdjustScrollBars(ListHandle list);
void			CLVFindCell(ListHandle list, Point mouseLoc, Point *cell);
void			CLVGetCellRect(ListHandle list, short xx, short yy, Rect *cbnds);
void			CLVGetVisCells(ListHandle list, Rect *visRct);
void			CLVGetCellInfo(ListHandle list, short xx, short yy, Rect *cbnds, short *cellNum,
							   short *select, short *ofst, short *len);
void			CLVSetSelect(Boolean select, Point cell, ListHandle list);
void			CLVAutoScroll(ListHandle list);

void			CLVAdjustCellLocs(ListHandle list);
short			CLVAddColumn(short count, short colNum, short ww, ListHandle list);
short			CLVAddRow(short count, short colNum, short hh, ListHandle list);
void			CLVDraw(Point cell, ListHandle list);

Boolean			CLVClick(Point mouseLoc, short modifiers, ListHandle list);
void			CLVUpdate(RgnHandle clipRgn, ListHandle list);
void			CLVCallDefProc(short lMessage, short lSelect, Rect *lRect, Cell lCell,
							   short lDataOffset, short lDataLen, ListHandle list);


typedef void			(*CLActivateProcPtr)(Boolean active, ListHandle listHndl);
typedef Boolean			(*CLClickProcPtr)(WindowPtr window, EventRecord *event, short *action);
typedef ControlHandle	(*CLCtlHitProcPtr)(void);
typedef ListHandle		(*CLFindActiveProcPtr)(WindowPtr window);
typedef Boolean			(*CLKeyProcPtr)(WindowPtr window, EventRecord *event);
typedef ControlHandle	(*CLNextProcPtr)(WindowPtr window, ListHandle *listHndl, ControlHandle ctl, short dir, Boolean justActive);
typedef ControlHandle	(*CLViewFromListProcPtr)(ListHandle listHndl);
typedef ListHandle		(*CLWindActivateProcPtr)(WindowPtr window, Boolean displayIt);

typedef void			(*CLVVariableSizeCellsProcPtr)(ListHandle list);
typedef void			(*CLVGetCellRectProcPtr)(ListHandle list, short xx, short yy, Rect *cbnds);
typedef void			(*CLVUpdateProcPtr)(RgnHandle clipRgn, ListHandle list);
typedef void			(*CLVAutoScrollProcPtr)(ListHandle list);
typedef void			(*CLVSetSelectProcPtr)(Boolean select, Point cell, ListHandle list);
typedef Boolean			(*CLVClickProcPtr)(Point mouseLoc, short modifiers, ListHandle list);
typedef void			(*CLVAdjustScrollBarsProcPtr)(ListHandle list);


#define rListCtl		4016

#define clHScroll		0x0002
#define clVScroll		0x0008
#define clActive		0x0020
#define clShowActive	0x0040
#define clKeyPos		0x0080
#define clTwoStep		0x0100
#define clHasGrow		0x0200
#define clVariable		0x4000
#define clDrawIt		0x8000

#endif


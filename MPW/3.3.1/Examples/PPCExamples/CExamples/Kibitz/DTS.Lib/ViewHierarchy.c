/*
** Apple Macintosh Developer Technical Support
**
** Program:     DTS.Lib
** File:        viewhierarchy.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1993 Apple Computer, Inc.
** All rights reserved.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */



/*****************************************************************************/



#include "DTS.Lib2.h"
#include "DTS.Lib.protos.h"

#ifndef __CTLHANDLER__
#include "CtlHandler.h"
#endif

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __FONTS__
#include <Fonts.h>
#endif

#ifndef __LISTCONTROL__
#include "ListControl.h"
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef THINK_C
#ifndef __STRINGS__
#include <Strings.h>
#endif
#endif

#ifndef __TEXTEDITCONTROL__
#include "TextEditControl.h"
#endif



/*****************************************************************************/



typedef struct ViewHierFileTypeRec {
	FileStateRec	fileState;
	ConnectRec		connect;
	ViewDoc			vh;
} ViewHierFileTypeRec;


extern short	gTECtl;
extern short	gListCtl;

extern short			gPrintPage;			/* Non-zero means we are printing. */
extern TreeObjProcPtr	gTreeObjMethods[];
extern Cursor			*gCursorPtr;
extern TreeObjHndl		gWindowFormats;

static void		VHContentClick(WindowPtr window, EventRecord *event, Boolean firstClick);
static Boolean	VHContentKey(WindowPtr window, EventRecord *event, Boolean *passThrough);
static OSErr	VHImageDocument(FileRecHndl frHndl);
static OSErr	VHInitContent(FileRecHndl frHndl, WindowPtr window);
static Boolean	VHDisplayFilter(TEHandle teHndl, EventRecord *event, short *handled);
static void		VHNewView(FileRecHndl frHndl, char *newText, short newTextLen, Boolean updatePList);
static OSErr	VHUpdateInfo(FileRecHndl frHndl, Boolean updatePList);
static Boolean	VHWindowCursor(FileRecHndl frHndl, WindowPtr window, Point globalPt);



/*****************************************************************************/
/*****************************************************************************/



/* This is called when a mouse-down event occurs in the content of a window.
** Other applications might want to call FindControl, TEClick, etc., to
** further process the click. */

#pragma segment Window
void	VHContentClick(WindowPtr window, EventRecord *event, Boolean firstClick)
{
#pragma unused (firstClick)

	FileRecHndl		frHndl;
	ControlHandle	ctl;
	short			ctlNum, action, len, selStart;
	ListHandle		plist, clist;
	TEHandle		te, display;
	char			newText[33];
	Point			cell;

	frHndl = (FileRecHndl)GetWRefCon(window);

	ctlNum = IsCtlEvent(window, event, &ctl, &action);
	switch (ctlNum) {
		case 101:
			display = (*frHndl)->d.vh.display;
			te = CTEFindActive(window);
			if (!te)
				te = display;
			ctl = CTEViewFromTE(te);
			if (te == display) {
				CTEActivate(true, te);
				CLActivate(false, CLFindActive(window));
				CTESetSelect(0, (*te)->teLength, display);
			}
			len = (*te)->selEnd - (selStart = (*te)->selStart);
			if (len > 32)
				len = 32;
			BlockMove(*((*te)->hText) + selStart, newText, len);
			VHNewView(frHndl, newText, len, true);
			break;
		case 102:
			if (action == 1) {
				plist = (*frHndl)->d.vh.plist;
				cell  = LLastClick(plist);
				len   = 8;
				LGetCell(newText, &len, cell, plist);
				VHNewView(frHndl, newText, len, false);
			}
			break;
		case 103:
			if (action == 1) {
				clist = (*frHndl)->d.vh.clist;
				cell  = LLastClick(clist);
				len   = 8;
				LGetCell(newText, &len, cell, clist);
				VHNewView(frHndl, newText, len, true);
			}
			break;
	}
}



/*****************************************************************************/



/* This is called when a key event occurs and it is determined that it isn't
** a menu key. */

#pragma segment Window
Boolean	VHContentKey(WindowPtr window, EventRecord *event, Boolean *passThrough)
{
#pragma unused (passThrough)

	FileRecHndl		frHndl;
	char			key;
	ControlHandle	ctl;
	short			action, selStart, len;
	TEHandle		te, display;
	char			newText[33];
	TreeObjHndl		pobj, cobj;

	frHndl = (FileRecHndl)GetWRefCon(window);
	key = event->message & charCodeMask;

	if ((key == chEnter) || (key == chReturn)) {
		SelectButton(ctl = (*frHndl)->d.vh.newView);
		display = (*frHndl)->d.vh.display;
		te = CTEFindActive(window);
		if (!te)
			te = display;
		ctl = CTEViewFromTE(te);
		if (te == display) {
			CTEActivate(true, te);
			CLActivate(false, CLFindActive(window));
			CTESetSelect(0, (*te)->teLength, display);
		}
		len = (*te)->selEnd - (selStart = (*te)->selStart);
		if (len > 32)
			len = 32;
		BlockMove(*((*te)->hText) + selStart, newText, len);
		VHNewView(frHndl, newText, len, true);
		return(true);
	}
	if (key == chFwdDelete) {
		if (event->modifiers & optionKey) {
			cobj = (*frHndl)->d.vh.root;
			if (pobj = (*cobj)->parent) {
				DisposeChild(NO_EDIT, pobj, GetChildNum(cobj));
				ccpyhex(newText, 0, 8, 8, (long)pobj);
				VHNewView(frHndl, newText, 8, true);
			}
		}
	}

	return(IsCtlEvent(window, event, &ctl, &action));
}



/*****************************************************************************/



/* Image the document into the current port. */

#pragma segment Window
OSErr	VHImageDocument(FileRecHndl frHndl)
{
#pragma unused (frHndl)

	WindowPtr		curPort;

	GetPort(&curPort);

	if (!gPrintPage) {										/* If not printing... */
		DoDrawControls(curPort, false);						/* Draw the content controls. */
		OutlineControl((*frHndl)->d.vh.newView);
	}
	else {
		gPrintPage = 0;
	}

	return(noErr);
}



/*****************************************************************************/



/* This function does the remaining window initialization. */

#pragma segment Window
OSErr	VHInitContent(FileRecHndl frHndl, WindowPtr window)
{
	FileRecPtr		frPtr;
	FileRecHndl		refFrHndl;
	WindowPtr		oldPort;
	ControlHandle	ctl;
	TEHandle		dump, display;
	ListHandle		plist, clist;
	ControlHandle	newView;
	OSErr			err;

	GetPort(&oldPort);
	SetPort(window);

	if (err = AddControlSet(window, (*frHndl)->fileState.sfType, kwStandardVis, 0, 0, nil))
		return(err);

	CNum2Ctl(window, 100, &ctl);
	dump = (TEHandle)GetCRefCon(ctl);

	CNum2Ctl(window, 101, &ctl);
	display = (TEHandle)GetCRefCon(ctl);
	CTESetKeyFilter(display, VHDisplayFilter);

	CNum2Ctl(window, 102, &ctl);
	plist = (ListHandle)GetCRefCon(ctl);

	CNum2Ctl(window, 103, &ctl);
	clist = (ListHandle)GetCRefCon(ctl);

	CNum2Ctl(window, 104, &newView);

	frPtr = *frHndl;
	frPtr->d.vh.dump    = dump;
	frPtr->d.vh.display = display;
	frPtr->d.vh.plist   = plist;
	frPtr->d.vh.clist   = clist;
	frPtr->d.vh.newView = newView;

	refFrHndl = mDerefRoot(frPtr->d.vh.root)->frHndl;
	NewWindowTitle(window, (*refFrHndl)->fileState.fss.name);
	VHUpdateInfo(frHndl, true);

	SetPort(oldPort);
	return(noErr);
}



/*****************************************************************************/



#pragma segment Window
static Boolean	VHWindowCursor(FileRecHndl frHndl, WindowPtr window, Point globalPt)
{
#pragma unused (frHndl, window, globalPt)

	SetCursor(gCursorPtr = &qd.arrow);
	return(true);
}



/*****************************************************************************/



#pragma segment Window
Boolean	VHDisplayFilter(TEHandle teHndl, EventRecord *event, short *handled)
{
#pragma unused (teHndl, handled)
	char	key;
	short	arrowKey;

	key = event->message & charCodeMask;
	arrowKey = ((key >= chLeft) && (key <= chDown));
	if (
		(arrowKey) ||
		(key == chBackspace) ||
		(key == chTab) ||
		((key >= '0') && (key <= '9')) ||
		((key >= 'A') && (key <= 'F')) ||
		((key >= 'a') && (key <= 'f'))
	) {
		return(false);
	}

	return(true);
}



/*****************************************************************************/



/* This function adds the application's controls to a window. */

#pragma segment Window
void	VHNewView(FileRecHndl frHndl, char *newText, short newTextLen, Boolean updatePList)
{
	TEHandle	te;
	short		len, i;
	long		newHndl;
	char		workText[33];

	if (!newText) {
		newText    = workText;
		newTextLen = 0;
	}
	if (!(len = newTextLen)) {
		te = (*frHndl)->d.vh.display;
		BlockMove(*((*te)->hText), newText, len = (*te)->teLength);
	}

	for (newHndl = 0, i = 0; i < len; ++i) {
		if ((newText[i] >= '0') && (newText[i] <= '9')) {
			newHndl *= 16;
			newHndl += (newText[i] - '0');
			continue;
		}
		if ((newText[i] >= 'a') && (newText[i] <= 'f'))
			newText[i] -= 32;
		if ((newText[i] >= 'A') && (newText[i] <= 'F')) {
			newHndl *= 16;
			newHndl += (newText[i] - 'A' + 10);
		}
	}

	if (newHndl) {
		GetHandleSize((Handle)newHndl);
		if (!MemError()) {
			(*frHndl)->d.vh.root = (TreeObjHndl)newHndl;
			VHUpdateInfo(frHndl, updatePList);
		}
		else SysBeep(1);
	}
}



/*****************************************************************************/



/* This function adds the application's controls to a window. */

#pragma segment Window
OSErr	VHUpdateInfo(FileRecHndl frHndl, Boolean updatePList)
{
	WindowPtr		oldPort;
	TreeObjHndl		root, chndl, phndl;
	TEHandle		dump;
	ListHandle		plist, clist;
	Handle			text;
	char			*cptr, *kcptr;
	long			dataSize, x, v;
	short			*dptr, cnum, depth, ctype;
	Point			cell;
	char			ctext[32], ptext[32];
	RgnHandle		rgn;
	Boolean			customFormat;
	TreeObjProcPtr	proc;
	VHFormatData	cf;

	root  = (*frHndl)->d.vh.root;
	dump  = (*frHndl)->d.vh.dump;
	plist = (*frHndl)->d.vh.plist;
	clist = (*frHndl)->d.vh.clist;

	DoNumberTree(root);

	text = NewHandle(32767);
	if (!text)
		return(MemError());

	GetPort(&oldPort);
	SetPort((*frHndl)->fileState.window);

	HLock(text);
	cptr = kcptr = StripAddress(*text);

	ccpy   (cptr, "$");
	ccathex(cptr, '0', 8, 8, (long)root);
	ccatchr(cptr, 13, 2);

	ccat   (cptr, "$00:        type = $");
	ccathex(cptr, '0', 4, 4, ctype = (*root)->type);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "$02: numChildren = $");
	ccathex(cptr, '0', 4, 4, (*root)->numChildren);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "$04:    dataSize = $");
	ccathex(cptr, '0', 8, 8, dataSize = (*root)->dataSize);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "$08:      treeID = $");
	ccathex(cptr, '0', 8, 8, (*root)->treeID);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "$0C:      parent = $");
	ccathex(cptr, '0', 8, 8, (long)(*root)->parent);

	customFormat = false;
	if (proc = gTreeObjMethods[ctype]) {		/* If this object type has a proc...   */
		cptr     += clen(cptr);
		cf.text   = text;
		cf.header = kcptr;
		cf.data   = cptr;
		customFormat = (*proc)(root, VHMESSAGE, (long)&cf);
		HLock(text);
		cptr = kcptr = StripAddress(*text);
		cptr += clen(cptr);
	}

	if (!customFormat) {
		dptr = (short *)GetDataPtr(root);
		for (x = 0; (cptr += clen(cptr)), (x < dataSize); x += sizeof(short)) {
			v = *dptr++;
			v &= 0x0000FFFF;
			if ((dataSize - x) == 1) {
				v >>= 8;
				v  &= 0x00FF;
			}
			if (!(x & 0x3F)) {
				ccatchr(cptr, 13, 2);
				ccat   (cptr, "$");
				ccathex(cptr, '0', 8, 8, x + sizeof(TreeObj));
				ccat   (cptr, ":");
			}
			if (!(x & 0x0F)) {
				ccatchr(cptr, 13, 1);
				ccat   (cptr, " ");
			}
			ccat   (cptr, " ");
			if ((dataSize - x) == 1)
				ccathex(cptr, '0', 2, 2, v);
			else
				ccathex(cptr, '0', 4, 4, v);
			if ((cptr - kcptr) > 32000) break;
		}
	}

	HUnlock(text);
	SetHandleSize(text, cptr - kcptr);

	UseControlStyle(CTEViewFromTE(dump));
	DisposeHandle(CTESwapText(dump, text, nil, true));
	UseControlStyle(nil);

	UseControlStyle(CLViewFromList(clist));
	LDelRow(0, 0, clist);
	LDoDraw(false, clist);
	cell.h = cell.v = 0;
	for (cnum = (*root)->numChildren; cnum;) {
		chndl = GetChildHndl(root, --cnum);
		ccpyhex(ctext, '0', 8, 8, (long)chndl);
		LAddRow(1, 0, clist);
		LSetCell(ctext, 8, cell, clist);
	}
	LDoDraw(true, clist);
	rgn = NewRgn();
	GetClip(rgn);
	LUpdate(rgn, clist);
	DisposeRgn(rgn);
	UseControlStyle(nil);

	UseControlStyle(CLViewFromList(plist));
	if (updatePList) {
		LDelRow(0, 0, plist);
		LDoDraw(false, plist);
		cell.h = cell.v = 0;
		for (depth = 0, phndl = root; phndl; phndl = (*phndl)->parent, ++depth) {
			ccpyhex(ptext, '0', 8, 8, (long)phndl);
			LAddRow(1, 0, plist);
			LSetCell(ptext, 8, cell, plist);
		}
		cell.v = depth - 1;
		LSetSelect(true, cell, plist);
		LAutoScroll(plist);
		LDoDraw(true, plist);
		rgn = NewRgn();
		GetClip(rgn);
		LUpdate(rgn, plist);
		DisposeRgn(rgn);
	}
	else LAutoScroll(plist);
	UseControlStyle(nil);

	SetPort(oldPort);
	return(noErr);
}



/*****************************************************************************/
/*****************************************************************************/



#pragma segment Window
OSErr	VHInitDocument(FileRecHndl frHndl)
{
	FileRecPtr	frPtr;
	FileRecHndl	refFrHndl;
	WindowPtr	window;

	frPtr = *frHndl;
	if (!gWindowFormats) {
		frPtr->fileState.windowID   = rVHWindow;
		frPtr->fileState.attributes = kwVHAppWindow;
	}
	frPtr->fileState.calcFrameRgnProc        = nil;
	frPtr->fileState.contentClickProc        = VHContentClick;
	frPtr->fileState.contentKeyProc          = VHContentKey;
	frPtr->fileState.drawFrameProc           = nil;
	frPtr->fileState.freeDocumentProc        = nil;
	frPtr->fileState.freeWindowProc          = nil;
	frPtr->fileState.imageProc               = VHImageDocument;
	frPtr->fileState.initContentProc         = VHInitContent;
	frPtr->fileState.readDocumentProc        = nil;
	frPtr->fileState.readDocumentHeaderProc  = nil;
	frPtr->fileState.resizeContentProc       = nil;
	frPtr->fileState.scrollFrameProc         = nil;
	frPtr->fileState.undoFixupProc           = nil;
	frPtr->fileState.windowCursorProc        = VHWindowCursor;
	frPtr->fileState.writeDocumentProc       = nil;
	frPtr->fileState.writeDocumentHeaderProc = nil;
		/* View Hierarchy method declarations. */

	/* Document-specific fields are already initialized to 0, so we do nothing. */

	for (window = nil; window = GetNextWindow(window, 0);) {
		if (!((WindowPeek)window)->visible) continue;
		if (refFrHndl = (FileRecHndl)GetWRefCon(window)) {
			if ((*refFrHndl)->fileState.defaultDoc) {
				(*frHndl)->d.vh.root = (*refFrHndl)->d.vh.root;
					/* This view hierarchy window, which isn't created yet, will reference
					** the data in the topmost window that uses the default document
					** architecture.  As the view hierarchy window is only for debugging
					** purposes, there is no prevision to guarantee that the data being
					** pointed to will continue to exist or continue to be valid.
					** The document that this references could be closed, and therefore
					** the reference would point to non-existent data.  (You are warned.) */
				return(noErr);
			}
		}
	} 

	return(memFullErr);
		/* Memory really isn't full.  We just need to pass back an error so that
		** the application knows that the view hierarchy document wasn't successfully
		** created.  It wasn't successfull created because it couldn't find any documents
		** that use the document hierarchy.  This really shouldn't occur, as the application
		** shouldn't have the menu option available for the view hierarchy window if there
		** is nothing to view.  However, since the view hierarchy window is just for
		** debugging, it seems annoying to demand that the application set the state of
		** the menu item correctly.  Returning any error here should be enough for the
		** application to be graceful. */
}



/*****************************************************************************/



#pragma segment Window
long	VHFileTypeSize(void)
{
	return(sizeof(ViewHierFileTypeRec));
}



/*****************************************************************************/



#pragma segment Window
void	VHRootInfo(TreeObjHndl root, char *cptr)
{
	ccat   (cptr, "$10: TRootObj:");
	ccatchr(cptr, 13, 1);
	ccat   (cptr, "  $00: undo        = $");
	ccathex(cptr, '0', 8, 8, (long)mDerefUndo(root)->root);
	ccatchr(cptr, 13, 1);
	ccat   (cptr, "  $04: frHndl      = $");
	ccathex(cptr, '0', 8, 8, (long)mDerefUndo(root)->frHndl);
	ccatchr(cptr, 13, 1);
}



/*****************************************************************************/



#pragma segment Window
void	VHFileRecInfo(TreeObjHndl root, char *cptr)
{
	FileRecHndl	frHndl;
	Str255		str;
	char		hstate;
	Rect		rct;
	long		offset;

	frHndl = mDerefRoot(root)->frHndl;
	hstate = LockHandleHigh((Handle)frHndl);

	ccat   (cptr, "(*frHndl)->fileState:");
	ccatchr(cptr, 13, 1);
	ccat   (cptr, "  sfType                  = '");
	BlockMove(&(*frHndl)->fileState.sfType, str, sizeof(long));
	str[sizeof(long)] = 0;
	ccat   (cptr, (char *)str);
	ccat   (cptr, "'");
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  defaultDoc              = ");
	ccatdec(cptr, (*frHndl)->fileState.defaultDoc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  movie                   = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.movie);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  movieResID              = ");
	ccatdec(cptr, (*frHndl)->fileState.movieResID);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  movieFlags              = $");
	ccathex(cptr, '0', 4, 4, (*frHndl)->fileState.movieFlags);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  movieDataRefWasChanged  = ");
	ccatdec(cptr, (*frHndl)->fileState.movieDataRefWasChanged);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  docDirty                = ");
	ccatdec(cptr, (*frHndl)->fileState.docDirty);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  modNum                  = ");
	ccatdec(cptr, (*frHndl)->fileState.modNum);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  modTick                 = ");
	ccatdec(cptr, (*frHndl)->fileState.modTick);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  readOnly                = ");
	ccatdec(cptr, (*frHndl)->fileState.readOnly);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  refNum                  = ");
	ccatdec(cptr, (*frHndl)->fileState.refNum);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  resRefNum               = ");
	ccatdec(cptr, (*frHndl)->fileState.resRefNum);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  fss.vRefNum             = ");
	ccatdec(cptr, (*frHndl)->fileState.fss.vRefNum);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  fss.parID               = $");
	ccathex(cptr, '0', 8, 8, (*frHndl)->fileState.fss.parID);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  fss.name                = ");
	pcpy   (str, (*frHndl)->fileState.fss.name);
	p2c    (str);
	ccat   (cptr, (char *)str);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  windowID                = ");
	ccatnum(cptr, (*frHndl)->fileState.windowID, 10);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  window                  = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.window);
	ccatchr(cptr, 13, 1);

	cptr += clen(cptr);

	ccat   (cptr, "  getDocWindow            = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.getDocWindow);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  calcFrameRgnProc        = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.calcFrameRgnProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  contentClickProc        = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.contentClickProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  contentKeyProc          = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.contentKeyProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  drawFrameProc           = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.drawFrameProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  freeDocumentProc        = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.freeDocumentProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  freeWindowProc          = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.freeWindowProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  imageProc               = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.imageProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  initContentProc         = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.initContentProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  readDocumentProc        = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.readDocumentProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  readDocumentHeaderProc  = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.readDocumentHeaderProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  resizeContentProc       = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.resizeContentProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  scrollFrameProc         = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.scrollFrameProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  undoFixupProc           = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.undoFixupProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  windowCursorProc        = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.windowCursorProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  writeDocumentProc       = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.writeDocumentProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  writeDocumentHeaderProc = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.writeDocumentHeaderProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  adjustMenuItemsProc     = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.adjustMenuItemsProc);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  doMenuItemProc          = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.doMenuItemProc);
	ccatchr(cptr, 13, 1);

	cptr += clen(cptr);

	ccat   (cptr, "  attributes              = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.attributes);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  windowSizeBounds        = ($");
	rct = (*frHndl)->fileState.windowSizeBounds;
	ccathex(cptr, 0, 4, 4, rct.top);
	ccat   (cptr, ",$");
	ccathex(cptr, 0, 4, 4, rct.left);
	ccat   (cptr, ",");
	ccatchr(cptr, 13, 1);
	ccatchr(cptr, ' ', 29);
	ccat   (cptr, "$");
	ccathex(cptr, 0, 4, 4, rct.bottom);
	ccat   (cptr, ",$");
	ccathex(cptr, 0, 4, 4, rct.right);
	ccat   (cptr, ")");
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  hScroll                 = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.hScroll);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  vScroll                 = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->fileState.vScroll);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  hScrollIndent           = ");
	ccatdec(cptr, (*frHndl)->fileState.hScrollIndent);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  vScrollIndent           = ");
	ccatdec(cptr, (*frHndl)->fileState.vScrollIndent);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  leftSidebar             = ");
	ccatdec(cptr, (*frHndl)->fileState.leftSidebar);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  topSidebar              = ");
	ccatdec(cptr, (*frHndl)->fileState.topSidebar);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  hArrowVal               = ");
	ccatdec(cptr, (*frHndl)->fileState.hArrowVal);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  vArrowVal               = ");
	ccatdec(cptr, (*frHndl)->fileState.vArrowVal);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  hPageVal                = ");
	ccatdec(cptr, (*frHndl)->fileState.hPageVal);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  vPageVal                = ");
	ccatdec(cptr, (*frHndl)->fileState.vPageVal);
	ccatchr(cptr, 13, 2);

	cptr += clen(cptr);

	ccat   (cptr, "(*frHndl)->connect:");
	ccatchr(cptr, 13, 1);
	ccat   (cptr, "  windowTag[0]             = ");
	ccatdec(cptr, (*frHndl)->connect.windowTag[0]);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  windowTag[1]             = ");
	ccatdec(cptr, (*frHndl)->connect.windowTag[1]);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  connected                = ");
	ccatdec(cptr, (*frHndl)->connect.connected);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  remoteLoc.descriptorType = '");
	BlockMove(&(*frHndl)->connect.remoteLoc.descriptorType, str, sizeof(long));
	str[sizeof(long)] = 0;
	ccat   (cptr, (char *)str);
	ccat   (cptr, "'");
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  remoteLoc.dataHandle     = $");
	ccathex(cptr, '0', 8, 8, (long)(*frHndl)->connect.remoteLoc.dataHandle);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  remoteName    = ");
	pcpy   (str, (*frHndl)->connect.remoteName);
	p2c    (str);
	ccat   (cptr, (char *)str);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  remoteZone    = ");
	pcpy   (str, (*frHndl)->connect.remoteZone);
	p2c    (str);
	ccat   (cptr, (char *)str);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  remoteMachine = ");
	pcpy   (str, (*frHndl)->connect.remoteMachine);
	p2c    (str);
	ccat   (cptr, (char *)str);
	ccatchr(cptr, 13, 2);

	ccat   (cptr, "  remotePath    = ");
	pcpy   (str, (*frHndl)->connect.remotePath);
	p2c    (str);
	ccat   (cptr, (char *)str);
	ccatchr(cptr, 13, 2);

	ccat   (cptr, "  remoteApp     = ");
	pcpy   (str, (*frHndl)->connect.remoteApp);
	p2c    (str);
	ccat   (cptr, (char *)str);
	ccatchr(cptr, 13, 2);

	cptr += clen(cptr);

	ccat   (cptr, "(*frHndl)->d.doc.fhInfo:");
	ccatchr(cptr, 13, 1);
	ccat   (cptr, "  version       = ");
	ccatdec(cptr, (*frHndl)->d.doc.fhInfo.version);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  printRecValid = ");
	ccatdec(cptr, (*frHndl)->d.doc.fhInfo.printRecValid);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  print         = (char *)(*frHndl) + $");
	offset  = (long)StripAddress(&(*frHndl)->d.doc.fhInfo.print);
	offset -= (long)StripAddress(*frHndl);
	ccathex(cptr, '0', 4, 4, (long)offset);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  structureRect = ($");
	rct = (*frHndl)->d.doc.fhInfo.structureRect;
	ccathex(cptr, 0, 4, 4, rct.top);
	ccat   (cptr, ",$");
	ccathex(cptr, 0, 4, 4, rct.left);
	ccat   (cptr, ",$");
	ccathex(cptr, 0, 4, 4, rct.bottom);
	ccat   (cptr, ",$");
	ccathex(cptr, 0, 4, 4, rct.right);
	ccat   (cptr, ")");
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  contentRect   = ($");
	rct = (*frHndl)->d.doc.fhInfo.contentRect;
	ccathex(cptr, 0, 4, 4, rct.top);
	ccat   (cptr, ",$");
	ccathex(cptr, 0, 4, 4, rct.left);
	ccat   (cptr, ",$");
	ccathex(cptr, 0, 4, 4, rct.bottom);
	ccat   (cptr, ",$");
	ccathex(cptr, 0, 4, 4, rct.right);
	ccat   (cptr, ")");
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  stdState      = ($");
	rct = (*frHndl)->d.doc.fhInfo.stdState;
	ccathex(cptr, 0, 4, 4, rct.top);
	ccat   (cptr, ",$");
	ccathex(cptr, 0, 4, 4, rct.left);
	ccat   (cptr, ",$");
	ccathex(cptr, 0, 4, 4, rct.bottom);
	ccat   (cptr, ",$");
	ccathex(cptr, 0, 4, 4, rct.right);
	ccat   (cptr, ")");
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  userState     = ($");
	rct = (*frHndl)->d.doc.fhInfo.userState;
	ccathex(cptr, 0, 4, 4, rct.top);
	ccat   (cptr, ",$");
	ccathex(cptr, 0, 4, 4, rct.left);
	ccat   (cptr, ",$");
	ccathex(cptr, 0, 4, 4, rct.bottom);
	ccat   (cptr, ",$");
	ccathex(cptr, 0, 4, 4, rct.right);
	ccat   (cptr, ")");
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  hDocSize      = ");
	ccatdec(cptr, (*frHndl)->d.doc.fhInfo.hDocSize);
	ccatchr(cptr, 13, 1);

	ccat   (cptr, "  vDocSize      = ");
	ccatdec(cptr, (*frHndl)->d.doc.fhInfo.vDocSize);
	ccatchr(cptr, 13, 1);

	HSetState((Handle)frHndl, hstate);
}




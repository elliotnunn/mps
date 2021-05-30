#ifndef __TEXTEDITCONTROL__
#define __TEXTEDITCONTROL__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __TEXTEDIT__
#include <TextEdit.h>
#endif

#ifndef __TEXTSERVICES__
#include <TextServices.h>	
#endif

#ifndef	__TSMTE__
#include "TSMTE.h"
#endif

#ifndef __WINDOWS__
#include <Windows.h>
#endif

typedef Boolean	(*CTEKeyFilterProcPtr)(TEHandle teHndl, EventRecord *event, short *handled);
typedef Boolean	(*CTEFastKeysProcPtr)(TEHandle teHndl, EventRecord *event);

typedef struct CTEDataRec {
	short				maxTextLen;
	Boolean				newUndo;
	short				undoSelStart;
	short				undoSelEnd;
	Handle				undoText;
	StScrpHandle		undoStyl;
	short				mode;
	Rect				brdrRect;
	CTEKeyFilterProcPtr	keyFilter;
	CTEFastKeysProcPtr	fastKeys;
	TSMDocumentID		docID;
} CTEDataRec;
typedef CTEDataRec *CTEDataPtr, **CTEDataHndl;

pascal void		ASMNOCARET(Rect *caretRect);
pascal Boolean	ASMTECLIKLOOP(void);
	/* Entry-points for the assembly glue. */

void			CTEActivate(Boolean active, TEHandle teHndl);
	/* Activate this TextEdit record.  If another is currently active, deactivate
	** that one.  The view control for this TextEdit record is also flagged to
	** indicate which was the last active one for this window.  If the previous
	** active TextEdit record was in the same window, then flag the old one off
	** for this window.  The whole point for this per-window flagging is so that
	** activate events can reactivate the correct TextEdit control per window. */

Boolean			CTEClick(WindowPtr window, EventRecord *event, short *action);
	/* This is called when a mouseDown occurs in the content of a window.  It
	** returns true if the mouseDown caused a TextEdit action to occur.  Events
	** that are handled include if the user clicks on a scrollbar that is
	** associated with a TextEdit control.
	**
	** if CTEClick returns false, action is 0
	** if CTEClick returns true,  action is:
	**	  -1 if control was activated by clicking on the TextEdit control or related scrollbar.
	**	   0 if control that was clicked on was already active. */

void			CTEClikLoop(void);
	/* Do the cut-copy-paste-clear operations for the currently active
	** TextEdit control.  Caller assumes appropriateness of the call.  Typically,
	** this routine won't be called at an inappropriate time, since the menu
	** item should be enabled or disabled correctly.
	** Use CTEEditMenu to set the menu items undo-cut-copy-paste-clear correctly
	** for the active TextEdit control.  Since undo isn't currently supported,
	** all that CTEEditMenu does for the undo case is to deactivate it right now. */

ControlHandle	CTEClipboard(short menuID);
	/* Do the cut-copy-paste-clear operations for the currently active
	** TextEdit control.  Caller assumes appropriateness of the call.  Typically,
	** this routine won't be called at an inappropriate time, since the menu
	** item should be enabled or disabled correctly.
	** Use CTEEditMenu to set the menu items undo-cut-copy-paste-clear correctly
	** for the active TextEdit control.  Since undo isn't currently supported,
	** all that CTEEditMenu does for the undo case is to deactivate it right now.
	** If a TextEdit control content changes due to this operation, the control
	** handle is returned. */

void			CTEConvertClipboard(Boolean convertClipboard, Boolean becomingActive);
	/* Call this for activate events to manage importing and exporting the TextEdit local scrap. */

ControlHandle	CTECtlHit(void);
	/* The TextEdit control that was hit by calling FindControl is saved in a
	** global variable, since the CDEF has no way of returning what kind it was.
	** To determine that it was a TextEdit control that was hit, first call this
	** function.  The first call returns the old value in the global variable,
	** plus it resets the global to nil.  Then call FindControl(), and then
	** call this function again.  If it returns nil, then a TextEdit control
	** wasn't hit.  If it returns non-nil, then it was a TextEdit control that
	** was hit, and specifically the one returned. */

void			CTEDispose(TEHandle teHndl);
	/* Disposes of the TERecord, TextEdit control, and any related scrollbars. */

TEHandle		CTEDisposeView(ControlHandle viewCtl);
	/* Dispose of the view control and related scrollbars.  This function also
	** returns the handle to the TextEdit record, since it was just orphaned.
	** Use this function if you want to get rid of a TextEdit control, but you
	** want to keep the TextEdit record. */

short			CTEDocHeight(TEHandle teHndl);
	/* Returns the full document height. */

Boolean			CTEEditMenu(Boolean *activeItem, short editMenu, short undoID, short cutID);
	/* Enable or disable edit menu items based on the active TextEdit control.
	** You pass the menu ID of the undo item in undoID, and the menu ID of the
	** cut item in cutID.  If undoID or cutID is non-zero, then some action is
	** performed.  If you pass a non-zero value for cutID, then the other menu
	** items cut-copy-paste-clear are updated to reflect the status of the
	** active TextEdit control. */

Boolean			CTEEvent(WindowPtr window, EventRecord *event, short *action);
	/* Handle the event if it applies to the active TextEdit control.  If some
	** action occured due to the event, return true.
	**
	** if event not handled, false is returned and action is 0
	** if event handled, true is returned and action is:
	**	  -1: an inactive control was clicked on and it was made active.
	**	   0: an active control was clicked on and tracked.
	**	   1: the control took the keypress, but no change occured to the TERecord.
	**	   2: the control took the keypress and the TERecord changed. */

TEHandle		CTEFindActive(WindowPtr window);
	/* Returns the active TextEdit control, if any.  If nil is passed in, then
	** the return value represents whatever TextEdit control is active, independent
	** of what window it is in.  If a window is passed in, then it returns a
	** TextEdit control only if the active control is in the specified window.
	** If the active TextEdit control is in some other window, then nil is returned. */

ControlHandle	CTEFindCtl(WindowPtr window, EventRecord *event, TEHandle *teHndl,
						   ControlHandle *ctlHit);
	/* This determines if a TextEdit control was clicked on directly.  The control found
	** and returned is the TextEdit control.  The control hit may be the same, or it may be
	** a related scrollbar. */

TEHandle		CTEFromScroll(ControlHandle scrollCtl, ControlHandle *retCtl);
	/* Find the TextEdit record that is related to the indicated scrollbar. */

Rect			CTEHide(TEHandle teHndl);
	/* Hide the designated TextEdit control and related scrollbars. */

void			CTEIdle(void);
	/* Blink the caret in the active TextEdit control.  The active TextEdit
	** control may be read-only, in which case the caret does not blink. */

short			CTEKey(WindowPtr window, EventRecord *event);
	/* See if the keypress event applies to the TextEdit control, and if it does,
	** handle it and return non-zero.
	**
	** if CTEKey returns 0, TextEdit control didn't handle the event.
	** if CTEKey returns 1, TextEdit control did handle the event, but the TERecord didn't change.
	** if CTEKey returns 2, TextEdit control did handle the event, and the TERecord changed. */

void			CTEMove(TEHandle teHndl, short newH, short newV);
	/* This function is used to move a TextEdit control.  Pass it the TextEdit
	** record to move, plus the new position.  It will move the TextEdit control,
	** along with any scrollbars the control may have.  All areas that need
	** updating are cleared and invalidated. */

OSErr			CTENew(short viewID, Boolean vis, WindowPtr window, TEHandle *teHndl, Rect *cRect,
					   Rect *dRect, Rect *vRect, Rect *bRect, short maxTextLen, short mode);
	/* Create a new TextEdit control.  See the file “=Using TextEditControl.c” for more
	** information on this call. */

void			CTENewUndo(ControlHandle viewCtl, Boolean alwaysNewUndo);
	/* Save the data (if appropriate) so that user can undo. */

ControlHandle	CTENext(WindowPtr window, TEHandle *teHndl, ControlHandle ctl, short dir, Boolean justActive);
	/* Get the next TextEdit control in the window.  You pass it a control handle
	** for the view control, or nil to start at the beginning of the window.
	** It returns both a TextEdit handle and the view control handle for that
	** TextEdit record.  If none is found, nil is returned.  This allows you to
	** repeatedly call this function and walk through all the TextEdit controls
	** in a window. */

short			CTENumTextLines(TEHandle teHndl);
	/* Return the number of lines of text.  This is because there is a bug in
	** TextEdit where the number of lines returned is incorrect if the text
	** ends with a c/r.  This function adjusts for this bug. */

OSErr			CTEPrint(TEHandle teHndl, short *offset, Rect *rct);
	/* Use this function to print the contents of a TextEdit record.  Pass it a
	** TextEdit handle, a pointer to a text offset, and a pointer to a rect to
	** print the text in.  The offset should be initialized to what character
	** in the TextEdit record you wish to start printing at (most likely 0).
	** The print function prints as much text as will fit in the rect, and
	** then updates the offset to tell you what is the first character that didn't
	** print.  You can then call the print function again with another rect with
	** this new offset, and it will print the text starting at the new offset.
	** This method is very useful when a single TextEdit record is longer than a
	** single page, and you wish the text to break at the end of the page.
	** The bottom of rect is also updated, along with the offset.  The bottom edge
	** of the rect is changed to reflect the actual bottom of the text printed.
	** This is useful because the rect passed in didn't necessarily hold an
	** integer number of lines of text.  The bottom of the rect is adjusted so
	** it exactly holds complete lines of text.
	** It is also possible that the rect could hold substantially more lines of
	** text than there are remaining.  Again, in this situation, the bottom of
	** rect is adjusted so that the rect tightly bounds the text printed.
	** The remaining piece of information passed back is an indicator that the
	** text through the end of the TextEdit record was printed.  When the end
	** of the text is reached, the offset for the next text to be printed is
	** returned as -1.  This indicates that processing of the TextEdit record
	** is complete. */

Boolean			CTEReadOnly(TEHandle teHndl);
	/* Return if the TextEdit control is read-write (true) or read-only (false). */

ControlHandle	CTEScrollFromTE(TEHandle teHndl, Boolean vertScroll);
	/* Return the control handle for the TextEdit control's scrollbar, either
	** vertical or horizontal.  If the scrollbar doesn't, nil is returned. */

ControlHandle	CTEScrollFromView(ControlHandle viewCtl, Boolean vertScroll);
	/* Return the control handle for the scrollbar related to the view control,
	** either horizontal or vertical.  If the scrollbar doesn't exist, return nil. */

void			CTESetKeyFilter(TEHandle teHndl, CTEKeyFilterProcPtr proc);
	/* A TextEdit control can have an optional key filter, which is called whenever
	** CTEKey() is called.  If you pass in nil, then the filtering is turned off.
	** This allows individual TextEdit controls to handle their own filtering.
	** The filter procedure is of the form:
	**     Boolean (*CTEKeyFilterProcPtr)(TEHandle teHndl, EventRecord *event, Boolean *handled);
	** If true is returned, then CTEKey() is aborted, and the value in "handled" is
	** returned.  By having a separate abort value and return value, you can determine
	** if processing of the event should be continued or not, independent of whether
	** or not you aborted CTEKey(). */

void			CTESetFastKeys(TEHandle teHndl, CTEFastKeysProcPtr proc);
	/* Set your own fast-keys procedure.  The fast-keys procedure returns whether or not
	** the particular keypress can be handled without returning to the application. */

void			CTESetSelect(short start, short end, TEHandle teHndl);
	/* Select a range of text.  TESetSelect can't be used alone because it doesn't
	** update the scrollbars.  This function calls TESetSelect, and then fixes up
	** the scrollbars. */

void			CTEShow(TEHandle teHndl);
	/* Show the designated TextEdit control and related scrollbars. */

void			CTESize(TEHandle teHndl, short newH, short newV, Boolean newDest);
	/* This function is used to resize a TextEdit control.  Pass it the TextEdit
	** record to resize, plus the new horizontal and vertical size.  It will
	** resize the TextEdit control, realign the text, if necessary, plus it will
	** resize and adjust any scrollbars the TextEdit control may have.  All areas
	** that need updating are cleared and invalidated. */

Handle			CTESwapText(TEHandle teHndl, Handle newText, StScrpHandle styl, Boolean update);
	/* Swap the TextEdit text handle with the text handle passed in.  If a non-nil styl
	** value is passed in, apply the style scrap to the new text. */

WindowPtr		CTETargetInfo(TEHandle *teHndl, Rect *teView);
	/* Return information for the currently active TextEdit control.  The currently
	** active TextEdit control is stored in gActiveTEHndl, and can be accessed
	** directly.  If gActiveTEHndl is nil, then there is no currently active one.
	** The information that we return is the viewRect and window of the active
	** TextEdit control.  This is information that could be gotten directly, but
	** this call makes it a little more convenient. */

ControlHandle	CTEUndo(void);
	/* Perform an undo function for the TextEdit control.
	** If a TextEdit control content changes due to this operation, the control
	** handle is returned. */

void			CTEUpdate(TEHandle teHndl, ControlHandle ctl, Boolean justShowActive);
	/* Draw the TextEdit control and frame. */

ControlHandle	CTEViewFromTE(TEHandle teHndl);
	/* Return the control handle for the view control that owns the TextEdit
	** record.  Use this to find the view to do customizations such as changing
	** the update procedure for this TextEdit control. */

TEHandle		CTEWindActivate(WindowPtr window, Boolean displayIt);
	/* Call this when a window with TextEdit controls is being activated.  This
	** will make the TextEdit control that was last active in this window the
	** active TextEdit control again. */

void			CTEAdjustTEBottom(TEHandle teHndl);
	/* This function is called after an edit to make sure that there is no extra
	** white space at the bottom of the viewRect.  If there are blank lines at
	** the bottom of the viewRect, and there is text scrolled off the top of the
	** viewRect, then the TextEdit control is scrolled to fill this space, or as
	** much of it as possible. */

void			CTEAdjustScrollValues(TEHandle teHndl);
	/* Bring the scrollbar values up to date with the current document position
	** and length. */

StScrpHandle	CTEGetFullStylScrap(TEHandle teHndl);
	/* This function gets the style scrap for the entire TextEdit control.  It doesn't
	** matter what the current selection range is.  The TextEdit control is left unaffected. */

void			CTESetStylScrap(short begRng, short endRng, StScrpHandle styles, TEHandle teHndl);
	/* This function applies the style scrap to the TextEdit record.  This function works better
	** than the toolbox function TESetStylScrap(). */

short			CTEGetLineNum(TEHandle te, short offset);
	/* This function returns the line number associated with the offset passed in. */

short			CTEGetLineHeight(TEHandle te, short lineNum, short *ascent);
	/* This function returns the line height of the requested line number. */

void			CTEGetPStr(ControlHandle ctl, StringPtr pstr);
	/* This function returns the TextEdit control text as a pascal string.  The maximum text
	** returned is 255 chars. */

void			CTESetPStr(ControlHandle ctl, StringPtr pstr);
#define			CTEPutPStr CTESetPStr
	/* This function sets the TextEdit control text to the pascal string. */

Boolean			CTEUseTSMTE(void);
	/* Call this function if you want the TextEdit control to use TSMTE.  You still need to
	** register and unregister your application with the TextServices Manager.  That isn't
	** handled for you.  AppWannabe's Start.c file shows how this is done:
	**
	**	if(CTEUseTSMTE())
	**		InitTSMAwareApplication();
	**
	**	... do app things here ...
	**
	**	if(CTEUseTSMTE())
	**		CloseTSMAwareApplication();
	**
	**	ExitToShell();
	*/

Boolean			TSMTEAvailable(void);
	/* This function says if the TextServices init TSMTE is available for inline-input for
	** TextEdit.  Note that you should do the following at startup:
	**
	** 		if(TSMTEAvailable())
	**			InitTSMAwareApplication();
	**
	** And at application shutdown, you should do the following:
	**
	** 		if(TSMTEAvailable())
	**			CloseTSMAwareApplication();
	*/


typedef void			(*CTEActivateProcPtr)(Boolean active, TEHandle teHndl);
typedef Boolean			(*CTEClickProcPtr)(WindowPtr window, EventRecord *event, short *action);
typedef ControlHandle	(*CTECtlHitProcPtr)(void);
typedef TEHandle		(*CTEFindActiveProcPtr)(WindowPtr window);
typedef short			(*CTEKeyProcPtr)(WindowPtr window, EventRecord *event);
typedef ControlHandle	(*CTENextProcPtr)(WindowPtr window, TEHandle *teHndl, ControlHandle ctl, short dir, Boolean justActive);
typedef void			(*CTESetSelectProcPtr)(short start, short end, TEHandle teHndl);
typedef ControlHandle	(*CTEViewFromTEProcPtr)(TEHandle teHndl);
typedef TEHandle		(*CTEWindActivateProcPtr)(WindowPtr window, Boolean displayIt);

#define rTECtl				4000

#define cteReadOnly			0x0001
#define cteHScroll			0x0002
#define cteHScrollLessGrow	0x0006
#define cteVScroll			0x0008
#define cteVScrollLessGrow	0x0018
#define cteActive			0x0020
#define cteNoBorder			0x0040
#define cteShowActive		0x0080
#define cteTabSelectAll		0x0100
#define cteTwoStep			0x0200
#define cteScrollFullLines	0x0400
#define cteStyledTE			0x0800
#define cteCenterJustify	0x1000
#define cteRightJustify		0x2000
#define cteNoFastKeys		0x4000
#define cteTSMTE			0x8000

#endif

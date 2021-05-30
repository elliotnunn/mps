***** TextEditControl.c usage documentation *****/

Purpose:  To simplify TextEdit handling within a window.

Implementing a TextEdit control does the following:

1) Makes using TextEdit in a non-dialog window easy.
2) The TERecord is automatically associated with the window, since
   it is in the window's control list.
3) The TextEdit control can have scrollbars associated with it, and these
   are also kept in the window's control list, and also associated with
   the TextEdit control.
4) Updating of the TERecord is much simpler, since all that is
   necessary is to draw the control (or all the window's controls with
   a DrawControls call).
5) What isn't handled automatically by tracking the control can be handled
   with a direct call.  There are simple calls to handle TextEdit events.
6) Undo is already supported.
7) A TERecord length can be specified.  This length will not be exceeded
   when editing the TERecord.
8) When you close the window, the TERecord is disposed of.
   (This automatic disposal can easily be defeated.)


To create a TextEdit control, you only need a single call.  For example:

	mode = cteVScrollLessGrow;	/* TERecord read-write, with vertical scroll		 */
								/* that leaves space for grow box.					 */

	CTENew(rViewCtl,			/* Resource ID of view control for TextEdit control. */
		   window,				/* Window to hold TERecord.							 */
		   true,				/* Initially visible.								 */
		   &teHndl,				/* Return handle for TERecord.						 */
		   &ctlRect,			/* Rect for TextEdit view control.					 */
		   &destRect,			/* destRect for TERecord							 */
		   &viewRect,			/* viewRect for TERecord							 */
		   &brdrRect,			/* Used to frame a border.							 */
		   32000,				/* Max size for TERecord text.						 */
		   mode);

The various choices for the TextEdit control are defined as follows:

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

cteReadOnly:		Don't allow editing.  When selected, don't blink a caret.
					Allow text selection and copy-to-clipboard.
cteHScroll:			Create and manage a horizontal scrollbar for the TextEdit control.
cteHScrollLessGrow:	Create and manage a horizontal scrollbar for the TextEdit control,
					but leave space for a growIcon on the right end of the scrollbar.
cteVScroll:			Create and manage a vertical scrollbar for the TextEdit control.
cteVScrollLessGrow:	Create and manage a vertical scrollbar for the TextEdit control,
					but leave space for a growIcon on the bottom end of the scrollbar.
cteActive:			Make this the initially active control for the window.
cteNoBorder:		By default, you get a border around the TextEdit control.  To turn this
					off, set this bit.
cteShowActive:		When the control is active, show that it is by drawing a selection
					border around the control.  This is the new 7.0 human-interface
					method of showing which control is active.  (This can be an important
					indicator because if you have readOnly TextEdit controls, they don't
					have a blinking caret.  If they also don't have any text selected,
					there will be no indication that it is the active control.
cteTabSelectAll:	When using IsCtlEvent() (discussed under "! using CtlHandler.c"),
					tab changes the active TextEdit (or List) control.  When a TextEdit
					control is made active, sometimes it is desirable to initially select
					all of the text for the user.  Setting this bit accomplishes this.
cteTwoStep:			When using IsCtlEvent(), you may want the initial click on a TextEdit
					control to just select the control, or you may wish the click to start
					tracking in addition to selecting the control.  The tracking is
					considered the second step, so by setting this bit, you will get
					tracking of the control on the initial click.
cteScrollFullLines:	This does as it sounds, but only if the TextEdit control isn't styled.
cteStyledTE:		If you don't need styles for this TextEdit control, leave this bit off.
cteCenterJustify:	As it sounds.
cteRightJustify:	As it sounds.
cteNoFastKeys:		The fast-keys feature allows the TextEdit control to check the OSEvent queue
					to see if there is another key event.  If there is, it will handle it
					before returning control to the application.  This local event processing
					allows a great speed increase in TextEdit performance, especially on
					slower Macs.  Some applications will want to inhibit this behavior.  Set
					this bit if you do.

Simply initialize ctlRect, destRect, viewRect, and brdrRect appropriately, and
then call CTENew (which stands for Control TENew).  If teHndl is returned
nil, then CTENew failed.  Otherwise, you now have a TextEdit control in the
window.  If it fails, it also returns an error stating why it failed
(memFullErr or resNotFound).

NOTE: There is a TextEdit bug (no way!!) such that you may need to set the
      viewRect right edge 2 bigger than the right edge of destRect.  If you
      do not do this, then there will be some clipping on the right edge in
      some cases.  Of course, you may want this.  You may want horizontal
      scrolling, and therefore you would want the destRect substantially
      larger than the viewRect.  If you don't want horizontal scrolling,
      then you probably don't want any clipping horizontally, and therefore
      you will need to set destRect.right 2 less than viewRect.right.


If the CTENew call succeeds, you then have a TextEdit control in your
window.  It will be automatically disposed of when you close the window.
If you don't waht this to happen, then you can detach it from the
view control which owns it.  To do this, you would to the following:

	viewCtl = CTEViewFromTE(theTextEditHndl);
	if (viewCtl) SetCRefCon(viewCtl, nil);

The view control keeps a reference to the TERecord in the refCon.
If the refCon is cleared, then the view control does nothing.  So, all that
is needed to detach a TERecord from a view control is to set the
view control's refCon nil.  Now if you close the window, you will still
have the TERecord.


To remove a TextEdit control completely from a window, you make one call:

	CTEDispose(theTextEditHndl);

This disposes of the TERecord, the view control, and any scrollbar
controls that were created when the TextEdit control was created with
the call CTENew.


Events for TERecord are handled nearly automatically.  You can
make one of 3 calls:

	CTEClick(window, eventPtr, &action);
	CTEEvent(window, eventPtr, &action);
	CTEKey(window, eventPtr);

In each case, if the event was handled, non-zero is returned.  CTEEvent simply
calls either CTEClick or CTEKey, whichever is appropriate.

Another call you will want to use is CTEEditMenu.  This is used to set the
state of cut/copy/paste/clear for TextEdit controls.  It checks the active
control to see if text is selected, if the control is read-only, etc.
Based on this information, it sets cut/copy/paste/clear either active
or inactive.  If any menu items are set active, it returns true.


One more high-level call is CTEUndo().  In response to an undo menu item
being selected by the user, just call CTEUndo(), and the edits the user
has made will be undone.  (This includes undoing an undo.)


The last high-level call for managing the edit menu is CTEClipboard.  Call it
when you want to do a cut/copy/paste/clear for the active TextEdit control.
The value to pass is as follows:

 2: cut
 3: copy
 4: paste
 5: clear

These are the same values you would pass to a DA for these actions.



For a complete list of the TextEdit control functions and a description as to
their purpose, see the file TextEditControl.h.


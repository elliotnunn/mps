***** ListControl.c usage documentation *****/

Purpose:  To simplify List handling within a window.

Implementing a List control does the following:

1) Makes using lists in a non-dialog window easier.
2) The List is automatically associated with the window, since
   it is in the window's control list.
4) Updating of the List is much simpler, since all that is
   necessary is to draw the control (or all the window's controls with
   a DrawControls call).
5) What isn't handled automatically by tracking the control can be handled
   with a direct call.  There are simple calls to handle List events.
6) When you close the window, the ListRecord is disposed of.
   (This automatic disposal can easily be defeated.)



To create a List control, you only need a single call.  For example:

	list = CLNew(rViewCtl,			/* Resource ID of view control for List control. */
				 true,				/* Initially visible.							 */
				 &viewRect,			/* View rect of list.							 */
				 numRows,			/* Number of rows to create List with.			 */
				 numCols,			/* Number of columns to create List with.		 */
				 cellHeight,
				 cellWidth,
				 theLProc,			/* Custom List procedure resource ID.			 */
				 window,			/* Window to hold List control.					 */
				 clHScroll | blBrdr | clActive);	/* Horizontal scrollbar, active List. */

The various choices for the List control are defined as follows:

#define clHScroll		0x0002
#define clVScroll		0x0008
#define clActive		0x0020
#define clShowActive	0x0040
#define clKeyPos		0x0080
#define clTwoStep		0x0100
#define clHasGrow		0x0200
#define clDrawIt		0x8000

clHScroll:			Create a list that includes a horizontal scrollbar.
clVScroll:			Create a list that includes a vertical scrollbar.
clActive:			Make this the initially active control for the window.
clShowActive:		When the control is active, show that it is by drawing a selection
					border around the control.  This is the new 7.0 human-interface
					method of showing which control is active.  (It also works in system 6.)
clKeyPos:			Allow list positioning, based on user keypresses.  This assumes that
					the list is alphabetized so that key presses for location make sense.
					If typing by the user is fast enough, multiple characters will be
					used for the positioning.
clTwoStep:			When using IsCtlEvent(), you may want the initial click on a List
					control to just select the control, or you may wish the click to start
					tracking in addition to selecting the control.  The tracking is
					considered the second step.  By setting this bit, you indicate that you
					want control selection and item selection to be a 2-step process.
					Setting this bit means that it will take 2 separate clicks by the
					user to select an item in the list if the list is inactive.
clHasGrow:			This makes sure that there is space for the growIcon if the list
					has a scrollbar.  If the list occupies an entire window, then if there
					is only one scrollbar, the scrollbar has to be shrunk to make room
					for the growIcon.  The List Manager supposedly has this ability, but
					it doesn't work.  The List control manages it correctly.
clDrawIt:			This is a List manager flag that is needed for the LNew() call.


If the CLNew call succeeds, you then have a List control in your
window.  It will be automatically disposed of when you close the window.
If you don't want this to happen, then you can detach it from the
view control which owns it.  To do this, you would to the following:

	viewCtl = CLViewFromList(theListHndl);
	if (viewCtl) SetCRefCon(viewCtl, nil);

The view control keeps a reference to the List record in the refCon.
If the refCon is cleared, then the view control does nothing.  So, all that
is needed to detach a List record from a view control is to set the
view control's refCon nil.  Now if you close the window, you will still
have the List record.


To remove a List control completely from a window, just dispose of the view
control that holds the List record.  To do this, just do something like the below:

	DisposeControl(CLViewFromList(theListHndl));

This completely disposes of the List control.


Events for the List record are handled nearly automatically.  Just make the
following call:

	CLEvent(window, eventPtr, &action);

If the event was handled, true is returned.  If the event is false, then the
event doesn't belong to a List control, and further processing of the event
should be done.



For a complete list of the List control functions and their descriptions,
see the file ListControl.h.


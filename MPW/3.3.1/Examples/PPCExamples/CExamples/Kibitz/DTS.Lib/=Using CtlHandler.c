***** CtlHandler.c usage documentation *****/

Purpose:  To simplify and standardize control handling within a window.


This code implements the new 7.0 human-interface standards for both
TextEdit and List controls.  These standards include the following features:

1) Tabbing between TextEdit and List controls within a window.
2) Displaying what item is active.  The active TextEdit item is indicated
   by either a blinking caret, or a selection range.
3) List positioning via the keyboard.  Entries on the keyboard automatically
   select and display the closest List item.  Also, the up and down arrows
   scroll through the list.
4) Document window scrollbars are handled.


The main call for handling the control events is:

short	IsCtlEvent(WindowPtr window, EventRecord *event, ControlHandle *retCtl, short *retAction);

This call handles the following:
	1) Document scrolling.
	2) TextEdit control events.
	3) List control events.
	4) Tabbing between TextEdit and list controls.
	5) Displaying the selected TextEdit or List control.
	6) Buttons.
	7) Radio buttons.
	8) Check boxes.
	9) Popups and other controls.
   10) Balloon help for controls.

The document content is scrolled automatically.  The updateRgn is set to include the
area scrolled into view and the window update procedure is automatically called.

TextEdit and List control events are completely handled.  Since the controls are just
containers for TERecords or ListRecords, all other access is up to the application.

Simple buttons are simply tracked.

Radio buttons are updated to reflect the new selection.  Radio buttons are handled as
families.  The refCon field holds the family number.  For any given family, there can
only be one selected radio button.  When a new one is clicked on, the old selected
radio button is deselected automatically.

Check boxes are simply toggled on and off, as there is no family relationship between
checkboxes.

Popups are simply tracked.  To determine what the popup choice is, the popup control
value will have to be retreived.

The return value of IsCtlEvent is non-zero if the event was handled.  The values are
as follows:

0x8000:				IsCtlEvent() scrolled the document.  The constant kScrollEvent is defined as
					0x8000 for this purpose.
0:					IsCtlEvent didn't handle the event.
any other value:	The control number of the control that handled the event.  Remember that
					a TextEdit control may actually consist of up to 3 controls.  There is the
					main container control for the TERecord.  There may also be 1 or 2 scrollbar
					controls that are related to the TERecord.  The control number reflects which
					control was hit.  This allows determination as to whether or not the scrollbar
					was hit.
					For TextEdit and list controls, even if a related scrollbar was hit, the
					control handle returned is the handle for the TextEdit control.

Just because a control number was returned doesn't mean that a control handle was returned.
If an inactive scrollbar is clicked on, then FindControl() returns nil, instead of the
control handle (really).  The control that is returned is what FindControl returns, and
therefore it is possibly nil.

For TextEdit and List controls, IsCtlEvent simply calls CTEClick(), CTEKey(), CLClick() or
CLKey().  The value returned as the action depends on which function was called.  The true/false
returned by these functions as to whether or not the control handled the event is expanded to
be the control number.  If false is returned by any of these functions, then IsCtlEvent()
returns 0 for the control number.

IsCtlEvent() has no way of determining if you are actually using TextEdit or List controls.
Since it has to make function calls service these controls, code may get linked into your
application that you don't need.  To prevent this, IsCtlEvent() calls the appropriate
functions by function pointer.  The default functions are just stub functions that return
appropriate results as if there were no such controls.  This allows IsCtlEvent() to handle
the case where these controls aren't used without linking in a bunch of code.

So what about the case where you DO want to use these controls?  To create one of these
controls, you have to call either CTENew() or CLNew(), for TextEdit and List controls,
respectively.  (Or, if you are using the AppsToGo program editor, you simply create them
in a fashion similar to ResEdit.)

When CTENew() is called, it calls CTEInitialize().  CTEInitialize() replaces all
of the stub function procedure pointers with pointers to the actual functions.
If you call CTENew(), then CTENew() will get linked in.  Since CTENew() calls
CTEInitialize(), CTEInitialize() will get linked in.  Since it references the actual
code, the actual code will get linked in.  This allows you to not have to worry about
specific implementations linking in too much code.  If you call it, it will link.  The
above process is also done for List controls.



The remaining functions aren't nearly as interesting, but they can prove to be useful.
See the file CtlHandler.h for a list and description of these functions.


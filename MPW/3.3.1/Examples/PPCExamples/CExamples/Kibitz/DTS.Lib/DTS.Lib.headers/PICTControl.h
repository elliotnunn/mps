#ifndef __PICTCONTROL__
#define __PICTCONTROL__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __CONTROLS__
#include <Controls.h>
#endif

#ifndef __WINDOWS__
#include <Windows.h>
#endif

ControlHandle	CPICTNew(WindowPtr window, Rect *r, StringPtr title, Boolean vis, short val,
						 short min, short max, short viewID, short refcon);
	/* Create a new PICT control.  All the parameters are what you would expect for creating
	** a new control. */

ControlHandle	CPICTNext(WindowPtr window, ControlHandle ctl, short dir, Boolean justActive);
	/* Return the next PICT control from a window's control list. 
	**
	** window:		The window whose control list is to be searched.
	** ctl:			The control to start the search with (nil to start at the beginning).
	** dir:			1 (forward through the control list) or -1 (backward through the control list)
	** justActive:	only return active, visible PICT controls.
	**
	** To get the first control in the window's control list, pass in a nil for ctl.
	** Pass in either 1 or -1 for the direction of the search.  Passing in a 1 means to
	** return the control just after the one passed in (or the first one if nil is passed in).
	** Passing in a -1 means to return the control just prior to the one passed in (or the
	** last control if nil is passed in).  If there are no more controls, then nil is returned.
	** The justActive field indicates if you want to return only visible, active controls.
	** If false is passed in, then the next control is returned, independent of state.
	** If true is passed in, then the next visible, active control is returned. */

Boolean			IsPICTCtl(ControlHandle ctl);
	/* Check to see if the control is a PICT control. */

#endif


#ifndef __BALLOONS__
#include <Balloons.h>
#endif

#ifndef __CTLHANDLER__
#define __CTLHANDLER__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __WINDOWS__
#include <Windows.h>
#endif

#define kScrollEvent	0x8000

short	IsCtlEvent(WindowPtr window, EventRecord *event, ControlHandle *ctl, short *action);
	/* See the file “=Using CtlHandler.c” for a complete description of this function.
	**
	** window:	Window to handle the event.
	**				(Usually whatever window was passed in to ContentClick() or ContentKey().)
	** event:	Event to be handled (or not)
	**				(Usually whatever event was passed in to ContentClick() or ContentKey().)
	** ctl:		Place to return the control that handled the event.
	**				(If you don't care, pass in nil.)
	** action:	The action taken by the control.  The action value returned varies according to
	**			the control that took the action.
	**				(If you don't care, pass in nil.)
	** return value is the ID of the control that handled the event.  If event not handled,
	** 0 is returned.  If a document scrollbar handled the event, then kScrollEvent is returned. */

short	CNum2Ctl(WindowPtr window, short ctlNum, ControlHandle *ctl);
	/* This function converts a control number to a control handle.  The function
	** simply walks the window's control list counting down until it has reached
	** the right control number.  It also returns the number of controls traversed.
	** While often this will be the same as the control number passed in, if the
	** number passed in is greater than the number of controls in the list, then
	** the number returned is the number of controls in the list.
	**
	** NOTE:	Now that controls can have styles applied to them, controls can have a fixed
	**			control ID.  If a control has a style, and the ctlID field if the style is
	**			non-zero, then that control has a fixed control ID.  Due to this, CNum2Ctl
	**			first scans all of the controls for a control with a style that has the
	**			designated ctlID.  If one is found, then that's the control returned.  If none
	**			is found, then the behavior for this function is as before (for the purpose of
	**			backwards-compatibility). */

short	Ctl2CNum(ControlHandle ctl);
	/* Convert a control handle to a control number.  This allows you to convert what
	** is normally a runtime variable into something that can be equated to a constant,
	** thus allowing you to code your control handling into case statements.  This function
	** does the opposite of CNum2Ctl. */

void	DoCtlActivate(WindowPtr window);
	/* This reactivates the TextEdit or List control that was active for a particular window.
	** When a window is moved from the front, the controls are supposed to become inactive.
	** This is handled, but the control that was last active for a window is remembered.
	** When the window is brought to the front, that particular control can be reactivated
	** by calling DoCtlActivate(). */

void	GetCheckBoxValues(WindowPtr window, Boolean checkBoxVal[]);
	/* This returns all of the checkbox values for a window all at once.  The array has
	** to have at least as many elements as there are checkboxes in the window.  Once
	** this call is made, you can simply reference the value in the appropriate position
	** in the array. */

short	GetRadioButtonChoice(WindowPtr window, short famNum);
	/* Given a particular family number, return which radio button is the currently selected
	** button.  If the requested family isn't found, or there are no selected radio buttons
	** in the family, -1 is returned.  If the family is found, the control number of the the
	** selected radio button minus the control number of the first in the family is returned.
	** • The first in the family is the control with the smallest ID. •
	** This means that for most situations, you will simply get an integer from 0-N for the
	** radio button selection, as in most cases, the radio button ID's will be sequential in
	** the control list. */

ControlHandle	CDataNext(WindowPtr window, ControlHandle ctl);
	/* When a set of controls defined with the AppsToGo editor is added to a window, an
	** additional Data control is also added.  The purpose of the Data control is to keep
	** track of which controls were added as a set of controls.  (The Data control "groups"
	** the set of controls.)  CDataNext allows you to get the next data control out of the
	** window's control list.  (Normally you won't need this function.) */

Boolean			ControlBalloonHelp(WindowPtr window, short modifiers, Point mouseLoc);
	/* This function is actually in Help.c, but it is specifically for managing
	** balloon help for controls.  IsCtlEvent calls it, although you can call it
	** yourself, if you want.  (There shouldn't be any reason for an application
	** to call this directly. */

ControlHandle	ControlBalloonMessage(WindowPtr window, Point mouseLoc, HMMessageRecord *msg, Rect *msgRct,
									  short *pos, short *hrctID, short *itemID);

PicHandle		BalloonText2PICT(WindowPtr window, HMMessageRecord *msg);


#endif

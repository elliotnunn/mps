/*
** Apple Macintosh Developer Technical Support
**
** File:        ppcbrowseroverride.c
** Written by:  C.K. Haun
**
** Copyright © 1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __CONTROLS__
#include <Controls.h>
#endif

#ifndef __OSEVENTS__
#include <OSEvents.h>
#endif

#ifndef __TRAPS__
#include <Traps.h>
#endif



/*****************************************************************************/



/* Thanks to C.K. for his Hack-To-Go service here in DTS.  Just leave a message,
** and the hack will show up via QuickMail really soon.  This is really interesting,
** since I've seen him type.  I don't know how he gets them done so fast.
** My only figuring is that he doesn't waste too much time with the space or tab keys
** on his keyboard.  (I added the spaces and tabs.) */

/* Theory of hack:
** Lots of zones (which describes Apple) is a real pain to browse looking for a game
** of chess.  This hack allows a really slimy way of coercing PPCBrowser to scan the
** zones until it finds a zone that has a machine running Kibitz.  Since we figure
** that this need doesn't apply to many companies (how many companies have hundreds
** of zones?), there really isn't much need to spend too much time polishing this
** “feature”.
**
** Since it is a really slimy hack, it was implemented into Kibitz as a hiddel feature.
** If you hold down the shift key when you do the menu command to connect to another
** player, then you have this auto-scan-of-zones feature active.  If the feature is
** active, then if you are displaying a zone that has no machine running Kibitz, after
** a maximum of 10 seconds, the patch posts a down-arrow.  The down arrow moves the
** zone list to the next available zone, assuming that the zone list is the active
** list.
**
** Of course, if the zone list isn't the active zone, this feature isn't too useful.
** This is why it is a hack.  It does the job, if you know what you are doing.
**
** It actually works reasonably well, as it beats the heck of choosing on the next
** zone by hand to see if anybody's running Kibitz in that zone.
*/



typedef struct myParamBlock {
	short	activeFlag;
	short	dialogUp;
	short	scrollActive;
	long	tickCounter;
	long	oldGND;
	long	oldMD;
	long	oldDD;
	long	oldFilter;
} myParamBlock;
myParamBlock OurParamBlock;

/* this define contains the ASCII and the keycode, in case anyone cares */
/* This is, by the way, for a US keyboard in US script.  Your script may */
/* vary, please check your owners manual */

#define kDownArrowKey 0x27D1F
#define kFiveSeconds 300

extern void		GNDPatch(void);  /* the actual paramter passing doesn't matter here */
extern void		MDPatch(void);
extern void		DDPatch(void);

void			TogglePPCPatches(Boolean on);
Boolean			CheckMachineList(void);
void			DoModalFilter(void);
ControlHandle	FindSB(WindowPtr theWindow);



/*****************************************************************************/



void	TogglePPCPatches(Boolean on) {
#pragma unused (on)

#if 0
#ifndef powerc

	if (on) {		/* turn everything on */
		OurParamBlock.activeFlag   = true;
		OurParamBlock.dialogUp     = false;
		OurParamBlock.scrollActive = false;
		OurParamBlock.tickCounter  = 0;
		OurParamBlock.oldGND       = NGetTrapAddress(_GetNewDialog,ToolTrap);
		OurParamBlock.oldMD        = NGetTrapAddress(_ModalDialog,ToolTrap);
		OurParamBlock.oldDD        = NGetTrapAddress(_DisposDialog,ToolTrap);

		/* and set them to what we want please */

		NSetTrapAddress((long)GNDPatch,_GetNewDialog,ToolTrap);
		NSetTrapAddress((long)MDPatch,_ModalDialog,ToolTrap);
		NSetTrapAddress((long)DDPatch,_DisposDialog,ToolTrap);
	}
	else {		/* turning off.  Kill ebbybiddy */
		OurParamBlock.activeFlag   = false;
		OurParamBlock.dialogUp     = false;
		OurParamBlock.scrollActive = false;
		OurParamBlock.tickCounter  = 0;

		/* revert the routines */

		NSetTrapAddress((long)OurParamBlock.oldGND,_GetNewDialog,ToolTrap);
		NSetTrapAddress((long)OurParamBlock.oldMD,_ModalDialog,ToolTrap);
		NSetTrapAddress((long)OurParamBlock.oldDD,_DisposDialog,ToolTrap);
	}
#endif
#endif
}



/*****************************************************************************/



Boolean	CheckMachineList(void) {
	short			v1, v2;
	WindowPtr		theWind    = FrontWindow();
	ControlHandle	theControl = ((WindowPeek)theWind)->controlList;
	Rect			minRect    = {16000, 16000, 16000, 16000};
	ControlHandle	minCtl     = nil;

	/* walk through the controls in the Front Window and find the scrollbar for the */
	/* machine list.  If there are no machines listed, then we're happening. */
	/* NOTE!!!! Avert young children's eyes at this point, please!  */
	/* I'm being cheap and sleazy here, and using information about the */
	/* PPC browser dialog (that you can see in MacsBug) itself to do this fast.*/

	while(theControl) {
		v1 = (*theControl)->contrlRect.top + (*theControl)->contrlRect.left;
		v2 = minRect.top + minRect.left;
		if (v1 < v2) {
			minRect = (*theControl)->contrlRect;
			minCtl  = theControl;
		}
		theControl = (*theControl)->nextControl;
	}

	if (minCtl)
		if ((*minCtl)->contrlMax == -6)
			return(true);

	 return(false);
}



/*****************************************************************************/



/* here's the workhorse for us */
/* we make the following assumptions */
/* well, only one really....	*/
/* the FrontWindow IS the PPC browser! */
/* if this isn't true, then things are too weird for words */

void	DoModalFilter(void) {
	if(TickCount() > OurParamBlock.tickCounter) {
		OurParamBlock.tickCounter = TickCount() + kFiveSeconds;
		if(CheckMachineList()) {
			PostEvent(keyDown,kDownArrowKey);
			PostEvent(keyUp,kDownArrowKey);
		}
	}
}



/*****************************************************************************/



ControlHandle	FindSB(WindowPtr theWindow) {
	Ptr				sBarProc, otherProc;
	ControlHandle	theControls, fakeScroll;
	WindowPeek		theWind = (WindowPeek)theWindow;
	Rect			theRect = {0, 0, 9, 9};

	fakeScroll = NewControl((WindowPtr)theWind, &theRect, "\p", false, 0, 0, 10, 16, 0);
	sBarProc   = *((*fakeScroll)->contrlDefProc);
	StripAddress(&sBarProc);
	DisposeControl(fakeScroll);

	theControls = theWind->controlList;
	while (theControls) {
		/* don't test against my sample */
		if (theControls != fakeScroll) {
			otherProc = *((*theControls)->contrlDefProc);
			StripAddress(&otherProc);
			if (otherProc == sBarProc)
				return(theControls);
		}
	}
	theControls = (*theControls)->nextControl;

	return(nil);
}




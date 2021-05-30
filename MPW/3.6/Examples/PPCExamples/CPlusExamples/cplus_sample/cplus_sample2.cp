//
//	cplus_sample2 - utility portion of simple C++ program
//
//
//	Copyright © 1993, Apple Computer, Inc.  All rights reserved.
//

#include "cplus_sample.h"
#include <Menus.h>
#include <Devices.h>
#include <Events.h> 

TSampleClass::TSampleClass ()
{
    /* The (char *) was necessary because CPlus creates a unsigned char temporary
	   and get's real unhappy. */
	   
	strcpy (this->theMessage, (char *) "\pPress the Mouse Button to Continue...");
}


void TSampleClass::showMessage (WindowPtr theWindow)
{	
	SetPort (theWindow);
	MoveTo (((theWindow->portRect.right-theWindow->portRect.left) / 2) - 
	         (StringWidth ((ConstStr255Param)theMessage) / 2), 
			 (theWindow->portRect.bottom-theWindow->portRect.top) / 2);
	TextFont (systemFont);
	DrawString ((ConstStr255Param)this->theMessage);
}


void TSampleClass::myPause ()
{
	while (!Button ())   /* wait for user to click */
	  SystemTask ();     /* Give some cpu time to other tasks. */
}


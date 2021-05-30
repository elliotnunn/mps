//
//	SharedLib.c - Source file for simple shared library
//
//
//	Copyright © 1993, Apple Computer, Inc.  All rights reserved.
//

#include "SharedLib.h"
#include <Menus.h>
#include <Devices.h>
#include <Events.h> 

char theMessage[80];


static void showMessage (WindowPtr theWindow);
static void myPause (void);


void DoMessage (WindowPtr aWindow)
{
	strcpy (theMessage, (const char *) "\pIn Shared Library");
	showMessage (aWindow);
	myPause ();
}


static void showMessage (WindowPtr theWindow)
{	
	SetPort (theWindow);
	MoveTo (((theWindow->portRect.right-theWindow->portRect.left) / 2) - 
	         (StringWidth ((ConstStr255Param)theMessage) / 2), 
			 (theWindow->portRect.bottom-theWindow->portRect.top) / 2);
	TextFont (systemFont);
	DrawString ((ConstStr255Param)theMessage);
}


static void myPause (void)
{
	while (!Button ())   /* wait for user to click */
	  SystemTask ();  /* Give some cpu time to other things running. */
}


/*
 *	c_sample2 - utility portion of simple C program
 *
 *
 *	Copyright © 1993, 1994 Apple Computer, Inc.  All rights reserved.
 */

#include "c_sample.h"
#include <Desk.h>


void showMessage (WindowPtr theWindow)
{
	char	theMessage[] = "\pPress the Mouse Button to Continue...";
	
	SetPort (theWindow);
	MoveTo (((theWindow->portRect.right-theWindow->portRect.left) / 2) - (StringWidth ((unsigned char*)theMessage) / 2),
	        (theWindow->portRect.bottom-theWindow->portRect.top) / 2);
	TextFont (systemFont);
	DrawString ((unsigned char*)theMessage);
}


void myPause (void)
{
	while (!Button ())   /* wait for user to click */
	   SystemTask();
}

/*

	NotPPC.c

		Source code for NotPPC application.

*/

#include <TextUtils.h>
#include <Sound.h>
#include <Fonts.h>
#include <Gestalt.h>
#include <Resources.h>

#include "NotPPC.h"

/* Not defined in {CIncludes} */
	
#define gestaltSysArchitecture 'sysa'
#define gestalt68k 1

QDGlobals	qd;

void main ()
{
    long        Architecture;
    OSErr       err;
	short		itemHit;
	AlertTHndl	theAlertTemplate;
	Handle		theDITLHandle;
	Str255		theMessage;

	InitGraf ((Ptr) &qd.thePort);
	InitFonts ();
	InitWindows ();
	InitMenus ();
	TEInit ();
	InitDialogs (nil);
	InitCursor ();
	
	/* set cursor to an arrow */
	SetCursor (&qd.arrow);

	/* pre-flight everything first */
	theAlertTemplate = (AlertTHndl)GetResource ('ALRT', RESOURCE_ID);		/* is the ALRT resource around? */
	if (theAlertTemplate)
  	   theDITLHandle = GetResource ('DITL', (*theAlertTemplate)->itemsID);	/* How about the DITL? */
	   
    err = Gestalt (gestaltSysArchitecture, & Architecture);                 /* Which message to print? */
	if (err || (Architecture == gestalt68k) )
 	   GetIndString (theMessage, RESOURCE_ID, Mac68KmsgID);
	 else
	   GetIndString (theMessage, RESOURCE_ID, PowerMacMsgID);

	if ((theAlertTemplate) && (theDITLHandle) && (theMessage[0] != 0))
	{
		/* Success at last... */
	
		ParamText (theMessage, (ConstStr255Param) "\p", 				/* Use the loaded STR resource to replace */
		           (ConstStr255Param) "\p", (ConstStr255Param) "\p");	/*    ^0 in alert's DITL. */	
		itemHit = Alert (RESOURCE_ID, nil);								/* Run the alert. */
	}
	else
	{
		/* give some indication we're hosed... */
		SysBeep(2); 
	}
}
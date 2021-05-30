/*
** Apple Macintosh Developer Technical Support
**
** Program:	     DTS.Lib
** File:	     AEUtils.c
** Written by:   Keith Rollin
** Modified by:  Eric Soldan
**
** Copyright © 1990-1991 Apple Computer, Inc.
** All rights reserved.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */



/*****************************************************************************/



#include "DTS.Lib2.h"
#include "DTS.Lib.protos.h"

#ifndef __NOTIFICATION__
#include <Notification.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __EPPC__
#include <EPPC.h>
#endif



/*****************************************************************************/



extern Boolean		gHasPPCToolbox;

Boolean				gNotifyUser   = true;
static Boolean		gNotifyActive = false;
static NMRec		gNotifyUserInfo = {
	nil,		/* qLink */
	nmType,		/* qType */
	0,			/* nmFlags */
	0L,			/* nmPrivate */
	0,			/* nmReserved */
	1,			/* nmMark */
	nil,		/* nmIcon */
	(Handle)-1,	/* nmSound */
	nil,		/* nmStr */
	nil,		/* nmResp */
	0L			/* nmRefCon */
};



/*****************************************************************************/
/*****************************************************************************/



/* Simply calls AEProcessAppleEvent and reports any errors.
** AEProcessAppleEvent looks in its table of registered events and sees if
** the current event is registered.  If so, off we go. */

#pragma segment AppleEvents
void	DoHighLevelEvent(EventRecord *event)
{
	AEProcessAppleEvent(event);
}



/*****************************************************************************/



/* This function returns the zone, machine, and application name for the
** indicated target descriptor. */

#pragma segment AppleEvents
OSErr	GetTargetInfo(AEAddressDesc targetDesc, StringPtr zone,
					  StringPtr machine, StringPtr application)
{
	ProcessSerialNumber targetPSN;
	PortInfoRec			portInfo;
	TargetID			theTargetID;
	OSErr				err;

	zone[0]        = 0;
	machine[0]     = 0;
	application[0] = 0;
	err = noErr;

	if (targetDesc.descriptorType == typeProcessSerialNumber) {
		targetPSN = **(ProcessSerialNumber **)(targetDesc.dataHandle);
		err = GetPortNameFromProcessSerialNumber(&portInfo.name, &targetPSN);
		if (!err)
			pcpy(application, portInfo.name.name);
		return(err);
	}

	if (targetDesc.descriptorType == typeTargetID) {
		theTargetID = **(TargetID **)(targetDesc.dataHandle);
		switch (theTargetID.location.locationKindSelector) {
			case ppcNoLocation:
				break;
			case ppcNBPLocation:
				pcpy(zone,    theTargetID.location.u.nbpEntity.zoneStr);
				pcpy(machine, theTargetID.location.u.nbpEntity.objStr);
				break;
			case ppcNBPTypeLocation:
				break;
		}
		pcpy(application, theTargetID.name.name);
		return(noErr);
	}

	return(errAEWrongDataType);
}



/*****************************************************************************/



/* Creates a TargetID.
**
** If sendDirect is TRUE, the target is specified by setting a
** ProcessSerialNumber to kCurrentProcess.  This has the advantage of sending
** the message directly to ourselves, bypassing ePPC and gaining about a 10-15x
** speed improvement.  If sendDirect is FALSE, we see if we have the
** PPCToolBox.  If not, then we are forced to do a direct send.  If we do have
** the PPCToolbox, then we call PPCBrowser.  We then look at the reply, and
** factor in the mode we are going to use in AESend.  If that mode is
** kAEWaitReply and the user selected us as the target, we have to turn that
** into a direct send.  This is because the AppleEvent Manager will otherwise
** post the event as a high-level event.  However, we are busy waiting for a
** reply, not looking for events, so we'll hang.  We avoid this by forcing a
** direct send. */

#pragma segment AppleEvents
OSErr	MakeTarget(AEAddressDesc *target, Boolean sendDirect, short replyMode,
				   Str255 prompt, Str255 applListLabel,
				   PPCFilterUPP portFilter,
				   char *theLocNBPType)
{
	OSErr					err;
	ProcessSerialNumber 	targetPSN;
	ProcessSerialNumber 	myPSN;
	TargetID				theTargetID;
	Boolean					sendingToSelf;

	static LocationNameRec	location;
	static PortInfoRec		portInfo;
	static Boolean			defaultOK = false;

	err = noErr;	/* Make sure we do the code for the second main if. */

	target->dataHandle = nil;
		/* Assume we will fail and nil this descriptor out. */

	if (!sendDirect) {
		if (!gHasPPCToolbox)
			sendDirect = true;	/* No tools to send with, so send direct. */

		else {		/* We are not sending to self. */
					/* sendDirect is false.		   */
			err = PPCBrowser(
				prompt,			/* Browse dialog box prompt.		   */
				applListLabel,	/* The 'programs' list title.		   */
				defaultOK,		/* Initially false.					   */
				&location,		/* Correct if defaultOK is true.	   */
				&portInfo,		/* Correct if defaultOK is true.	   */
				portFilter,		/* Port filtering.					   */
				(StringPtr)theLocNBPType	/* List ports of this type */
			);

			if (!err) {					/* If user didn't cancel... */
				defaultOK = true;		/* Default to the same port next time. */
				if (replyMode == kAEWaitReply) {
					/* Sender wants a reply and will be waiting... */

					sendingToSelf = false;
						/* Assume that we aren't sending to ourselves. */

					if (!location.locationKindSelector) {
						/* Hey, we are sending to ourselves! */

						err = GetProcessSerialNumberFromPortName(
								&portInfo.name, &targetPSN);
						if (!err) {
							GetCurrentProcess(&myPSN);
							err = SameProcess(&targetPSN, &myPSN, &sendingToSelf);
						}
					}

					if (sendingToSelf)
						sendDirect = true;

				}
			}
		}
	}

	if (!err) {
		if (sendDirect) {
			/* Finally, we get to the point... */

			targetPSN.highLongOfPSN = 0;
			targetPSN.lowLongOfPSN = kCurrentProcess;
				/* Process serial # is equal to kCurrentProcess.  This
				** bypasses ePPC and speeds up things considerably. */

			err = AECreateDesc(
				typeProcessSerialNumber,	/* Standard PSN descriptor type. */
				(Ptr)&targetPSN,			/* "No ePPC" process serial #.	 */
				sizeof(targetPSN),			/* Size of data (2 longs).		 */
				target						/* Wherefore art thou desc.		 */
			);
		}
		else {
			theTargetID.location = location;
			theTargetID.name     = portInfo.name;
				/* The fields sessionID does not need to be filled in now.
				** The sessionID is returned when you actually connect to
				** a port.  You can then use the sessionID from that point
				** on to improve speed.
				**
				** You also don't need to fill in the recvrName field at this
				** point.  This is filled in, again, when the session is
				** actually established.
				**
				** The amount of data for a non-us target is bigger.
				** We need the whole dealie for our target, since
				** it is out on the net somewhere. */

			err = AECreateDesc(
				typeTargetID,			/* Standard target descriptor type. */
				(Ptr)&theTargetID,		/* The data for the descriptor.		*/
				sizeof(theTargetID),	/* Size of the data.				*/
				target					/* Wherefore art thou desc.			*/
			);
		}
	}
	return (err);
}



/*****************************************************************************/



/* Used to check for any unread required parameters. Returns true if we
** missed at least one. */

#pragma segment AppleEvents
Boolean	MissedAnyParameters(AppleEvent *message)
{
	OSErr		err;
	DescType	ignoredActualType;
	AEKeyword	missedKeyword;
	Size		ignoredActualSize;
	EventRecord	event;

	err = AEGetAttributePtr(	/* SEE IF PARAMETERS ARE ALL USED UP.		  */
		message,				/* AppleEvent to check.						  */
		keyMissedKeywordAttr,	/* Look for unread parameters.				  */
		typeWildCard,			/* So we can see what type we missed, if any. */
		&ignoredActualType,		/* What it would have been if not coerced.	  */
		(Ptr)&missedKeyword,	/* Data area.  (Keyword not handled.)		  */
		sizeof(missedKeyword),	/* Size of data area.						  */
		&ignoredActualSize		/* Actual data size.						  */
	);

/* No error means that we found some unused parameters. */

	if (err == noErr) {
		event.message = *(long *) &ignoredActualType;
		event.where = *(Point *) &missedKeyword;
		err = errAEEventNotHandled;
	}

/* errAEDescNotFound means that there are no more parameters.  If we get
** an error code other than that, flag it. */

	return(err != errAEDescNotFound);
}



/*****************************************************************************/



#pragma segment AppleEvents
void	NotifyCancel(void)
{
	if (gNotifyActive) {
		NMRemove((NMRecPtr)&gNotifyUserInfo);
		gNotifyActive = false;
	}
}



/*****************************************************************************/



#pragma segment AppleEvents
void	NotifyUser(void)
{
	if (gNotifyUser) {
		if (gInBackground) {
			if (!gNotifyActive) {
				gNotifyUserInfo.nmIcon = GetResource('SICN', 128);
				NMInstall(&gNotifyUserInfo);
				gNotifyActive = true;
			}
		}
	}
}




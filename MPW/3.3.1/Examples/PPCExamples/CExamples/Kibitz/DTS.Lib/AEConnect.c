/*
** Apple Macintosh Developer Technical Support
**
** Program:	    DTS.Lib
** File:	    AEConnect.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1991 Apple Computer, Inc.
** All rights reserved.
**
** This is the custom AppleEvents code used for establishing a connection
** to another window.  DTS.Lib targets a specific window in an application,
** not just an application.  It also sends and returns more information
** about the connection, such as user name, zone, and machine.  This
** information is two-way, so each user can know who they are connected to.
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

#ifndef __LOWMEM__
#include <LowMem.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif



/*****************************************************************************/



extern OSType		gDocCreator;
extern short		gMinVersion, gMaxVersion;
extern Boolean		gHasAppleEvents;
extern Cursor		*gCursorPtr;

static pascal OSErr		DoAEAnswer(AppleEvent *message, AppleEvent *reply, long refcon);
static pascal OSErr		ReceiveConnect(AppleEvent *message, AppleEvent *reply, long refcon);
static pascal OSErr		ReceiveConnectReply(AppleEvent *message, AppleEvent *reply);



/*****************************************************************************/



static AEHandler keywordsToInstall[] = {
	{ kCoreEventClass,		kAEAnswer,			(ProcPtr)DoAEAnswer,		nil },
	{ kCustomEventClass,	keyAppConnect,		(ProcPtr)ReceiveConnect,	nil },
};		/* These are the custom AppleEvents. */

#define kNumKeywords (sizeof(keywordsToInstall) / sizeof(AEHandler))



/*****************************************************************************/
/*****************************************************************************/



/* Install the AppleEvents we use to establish a connection to a specific
** window.  This is done in addition to installing the required AppleEvents.
** InitAppleEvents, which installs the required AppleEvents, must be called
** first, since it sets up some global values. */

#pragma segment AppleEvents
void	InitConnectAppleEvents(void)
{
	OSErr	err;
	short	i;

	if (gHasAppleEvents) {
		for (i = 0; i < kNumKeywords; ++i) {

			if (!keywordsToInstall[i].theUPP)
				keywordsToInstall[i].theUPP = NewAEEventHandlerProc(keywordsToInstall[i].theHandler);

			err = AEInstallEventHandler(
				keywordsToInstall[i].theEventClass,	/* What class to install.  */
				keywordsToInstall[i].theEventID,	/* Keywords to install.    */
				keywordsToInstall[i].theUPP,		/* The AppleEvent handler. */
				0L,									/* Unused refcon.		   */
				false								/* Only for our app.	   */
			);

			if (err) {
				HCenteredAlert(rErrorAlert, nil, gAlertFilterUPP);
				return;
			}
		}
	}
}



/*****************************************************************************/



/* This function handles the connect reply.  DTS.framework sends the connect request
** via kAEQueueReply.  This means that it doesn't necessarily come back immediately.
** (It actually comes back right away if it is connected to itself.)  The reply
** normally comes in via a high-level event.  Until this reply comes in, the
** connection isn't established.  When this reply does come in, the remaining
** information necessary to establish the connection to a particular window in
** the target application is recorded. */

#pragma segment AppleEvents
static pascal OSErr	DoAEAnswer(AppleEvent *message, AppleEvent *reply, long refcon)
{
#pragma unused (refcon)

	gCursorPtr = nil;		/* Force re-calc of cursor region and cursor to use. */
	return(ReceiveConnectReply(message, reply));
}



/*****************************************************************************/



/* This is the function that is called to establish a connection to another
** DTS.framework-based application.  The "other" DTS.framework-based application is probably
** the same application on another machine.  This code does a bit more than simply connecting
** to another application.  It targets a specific window within that application.  It doesn't
** just target zone/machine/application, which is the granularity that AppleEvents gives you.
** It also passes back and forth some information that is kind of a pain to get, but
** is nice to have.  One such piece of information is the user name.  This needs to be
** sent.  It can't be determined from the message from an AppleEvent.  The sender sends
** the user name, and the receiver returns the remote user name.  The user name is
** placed in the document record for the window to be used if you wish. */

#pragma segment AppleEvents
OSErr	SendConnect(FileRecHndl frHndl, char *theLocNBPType)
{
	AEAddressDesc	remoteLoc;
	OSErr			err;
	long			windTag[2], size;
	char			hstate;
	Ptr				ptr1, ptr2;
	AppleEvent		theAevt, reply;
	Str255			macText, appText;
	Str32			remoteName;
	Handle			remoteNameHndl;
	OSType			sftype;
	FSSpec			myFSS;
	Str255			thisPath;
	Str32			thisApp;
	static PPCFilterUPP	aePortFilterUPP = nil;

	err = noErr;

	theAevt.dataHandle = reply.dataHandle = nil;
		/* Make sure disposing of the descriptors is okay in all cases.
		** theAevt and reply aren't necessarily instantiated correctly, so
		** we need to make sure that the dispose is safe, even if they aren't
		** valid.  theAevt isn't valid if MakeTarget returns an error.  If
		** MakeTarget returns an error, then AECreateAppleEvent isn't called
		** for theAevt.  Similarly, if AESend isn't called, reply isn't valid. */

	GetIndString(macText, rPPCText, sTitleText);
	GetIndString(appText, rPPCText, sAppText);

	remoteLoc = (*frHndl)->connect.remoteLoc;
	if (!remoteLoc.dataHandle) {
		if (!aePortFilterUPP)
			aePortFilterUPP = NewPPCFilterProc (AEPortFilter);
		err = MakeTarget(&remoteLoc, false, kAEWaitReply, macText, appText,
						aePortFilterUPP, theLocNBPType);
			/* Generate the target for the remote user. */
	}

	(*frHndl)->connect.remoteLoc    = remoteLoc;
	(*frHndl)->connect.windowTag[0] = windTag[0] = (TickCount() & 0xFFFFFFFE);
	(*frHndl)->connect.windowTag[1] = windTag[0];
		/* The windTag fields are used to determine which window is the target
		** for an incomming AppleEvent.  windTag[0] for the application doing
		** the connecting will be even, and windTag[1] (the target's ID) will
		** be odd.  This prevents any accidental occurance where the windTag
		** fields are the same.  The target application will store these values
		** reversed.  Any incomming AppleEvent, from either application, will
		** invert these fields and then scan the window list looking for a window
		** that has the correct values in these fields.  If there is no such
		** window, then the window was closed at some point.  Initially, the sender
		** sets these values to be the same.  Until the sender receives a return
		** reply for the connect message, the windows aren't officially connected.
		** When the reply comes in, then the windTag[1] field is set to the reply's
		** return value. */

	if (!err) {		/* Create the AppleEvent... */
		err = AECreateAppleEvent(		/* Create empty AppleEvent.	   */
			kCustomEventClass,			/*   Event class.			   */
			typeAppConnect,				/*   Event ID.				   */
			&remoteLoc,					/*   Address of receiving app. */
			kAutoGenerateReturnID,		/*   This value causes the	   */
										/*   AppleEvent manager to	   */
										/*   assign a return ID that   */
										/*   is unique to the session. */
			kAnyTransactionID,			/*   Ignore transaction ID.	   */
			&theAevt					/*   Location of event.		   */
		);
	}

	if (!err) {
		sftype = (*frHndl)->fileState.sfType;
		err = AEPutParamPtr(	/* Add document type to AppleEvent. */
			&theAevt,			/*   AppleEvent to add to. */
			keySFType,			/*   AEKeyword.			   */
			typeLongInteger,	/*   Actual type.		   */
			(Ptr)&sftype,		/*   Pointer to the data.  */
			sizeof(OSType)		/*   Size of the data.	   */
		);
	}

	if (!err) {
		myFSS = (*frHndl)->fileState.fss;
		err = AEPutParamPtr(	/* Add document name (which is in the FSSpec) to AppleEvent. */
			&theAevt,			/*   AppleEvent to add to. */
			keyFSS,				/*   AEKeyword.			   */
			typeFSS,			/*   Desired type.		   */
			(Ptr)&myFSS,		/*   Pointer to the data.  */
			sizeof(FSSpec)		/*   Size of the data.	   */
		);
	}

	if (!err) {
		hstate = HGetState((Handle)frHndl);
		HLock((Handle)frHndl);
		ptr1   = (Ptr)&((*frHndl)->connect);
		ptr2   = (Ptr)&((*frHndl)->connect.endSendInfo);
		size   = (long)ptr2 - (long)ptr1;
		err = AEPutParamPtr(	/* Add file connect info to the AppleEvent. */
			&theAevt,			/*   AppleEvent to add to.			 */
			keyAppConnect,		/*   AEKeyword.						 */
			typeAppConnect,		/*   Desired type.					 */
			ptr1,				/*   Pointer to the data to be sent. */
			size				/*   Size of the data to be sent.	 */
		);
		HSetState((Handle)frHndl, hstate);
	}

	if (!err) {
		remoteName[0] = 0;
		if (remoteNameHndl = GetAppResource('STR ', -16096, nil))
			pcpy(remoteName, (StringPtr)(*remoteNameHndl));
		err = AEPutParamPtr(	/* Add user name to AppleEvent. */
			&theAevt,			/*   AppleEvent to add to. */
			keyPascal,			/*   AEKeyword.			   */
			typePascal,			/*   Desired type.		   */
			(Ptr)remoteName,	/*   Pointer to the data.  */
			remoteName[0] + 1	/*   Size of the data.	   */
		);
	}

	if (!(*frHndl)->connect.remotePath[0]) (*frHndl)->connect.remoteApp[0]  = 0;
	if (!(*frHndl)->connect.remoteApp[0])  (*frHndl)->connect.remotePath[0] = 0;

	if (!err) {
		pcpy(thisPath, (*frHndl)->connect.remotePath);	/* We're the remote to the other guy. */
		err = AEPutParamPtr(		/* Add user name to AppleEvent. */
			&theAevt,				/*   AppleEvent to add to. */
			typePascal2,			/*   AEKeyword.			   */
			typePascal2,			/*   Desired type.		   */
			(Ptr)thisPath,			/*   Pointer to the data.  */
			thisPath[0] + 1			/*   Size of the data.	   */
		);
	}
	(*frHndl)->connect.remotePath[0] = 0;

	if (!err) {
		pcpy(thisApp, (*frHndl)->connect.remoteApp);	/* We're the remote to the other guy. */
		err = AEPutParamPtr(	/* Add user name to AppleEvent. */
			&theAevt,			/*   AppleEvent to add to. */
			typePascal3,		/*   AEKeyword.			   */
			typePascal3,		/*   Desired type.		   */
			(Ptr)thisApp,		/*   Pointer to the data.  */
			thisApp[0] + 1		/*   Size of the data.	   */
		);
	}
	(*frHndl)->connect.remoteApp[0] = 0;

	if (!err) {		/* If we have an AppleEvent ready to send... */
		err = AESend(			/* Send AppleEvent.			  */
			&theAevt,			/*   Our Apple Event to send. */
			&reply,				/*   We may have a reply.	  */
			kAEQueueReply,		/*   Type of reply.			  */
			kAENormalPriority,	/*   App. send priority.	  */
			0,					/*   We aren't waiting.		  */
			nil,				/*   We aren't waiting.		  */
			nil					/*   EventFilterProcPtr.	  */
		);
	}
	if (remoteLoc.descriptorType == typeProcessSerialNumber)
		err = ReceiveConnectReply(&reply, &reply);
			/* If we want a queue reply, and if we are sending to ourselves,
			** then we already have the reply.  Since we are sending to
			** ourselves, everything happens right away, even for queue reply, so
			** we must handle the connect reply here.  If we are sending to another
			** machine, then the reply will come in as a high-level event and we
			** will process it through the event loop. */

	AEDisposeDesc(&theAevt);
	AEDisposeDesc(&reply);
		/* Dispose of the descriptors, created or not.
		** If not created, no harm done by calling. */

	if (err) {
		AEDisposeDesc(&remoteLoc);
		(*frHndl)->connect.remoteLoc.dataHandle = nil;
			/* If we didn't connect, get rid of the target descriptor.  If we
			** succeeded at connecting, then we keep the descriptor until the
			** connection is broken by the application. */

		(*frHndl)->connect.windowTag[0] = 0;
		(*frHndl)->connect.windowTag[1] = 0;
			/* Mark this window so that it will never be found if we somehow
			** do get an answer from the receiver, even after failure. */
	}

	return(err);
}



/*****************************************************************************/



/* This function receives a connect message from SendConnect.  The connection
** tasks that the receiver has to do are done here, such as opening a window for
** this end of the connection, etc.  It also returns whether or not it succeeded,
** and the user name.  Basically, it establishes the connection, while keeping
** some data as to whom it is connected to. */

#pragma segment AppleEvents
static pascal OSErr	ReceiveConnect(AppleEvent *message, AppleEvent *reply, long refcon)
{
#pragma unused (refcon)

	OSErr			err;
	FileRecHndl		frHndl;
	char			hstate;
	Ptr				ptr1, ptr2;
	long			size, windTag[2];
	AEAddressDesc	senderTarget;
	DescType		ignoredType;
	Size			ignoredSize;
	OSType			sftype;
	FSSpec			myFSS;
	Str32			remoteZone, remoteMachine, remoteName, remoteApp;
	Str255			theOtherPath, thisPath;
	Str32			theOtherApp,  thisApp;
	Handle			remoteNameHndl;
	short			vers;

	err = AEGetParamPtr(	/* Get OSType to determine document type. */
		message,			/*   The AppleEvent. 		   */
		keySFType,			/*   AEKeyword				   */
		typeLongInteger,	/*   Desired type.			   */
		&ignoredType,		/*   Type code.				   */
		(Ptr)&sftype,		/*   Pointer to area for data. */ 
		sizeof(OSType),		/*   Size of the data.		   */
		&ignoredSize		/*   Returned size of data.	   */
	);

	if (!err)
		err = NewDocument(&frHndl, sftype, false);

	if (err) return(err);

	if (!err) {
		hstate = HGetState((Handle)frHndl);
		HLock((Handle)frHndl);
		ptr1   = (Ptr)&((*frHndl)->connect);
		ptr2   = (Ptr)&((*frHndl)->connect.endSendInfo);
		size   = (long)ptr2 - (long)ptr1;
		err = AEGetParamPtr(	/* Get connect info from the AppleEvent. */
			message,			/*   The AppleEvent. 		   */
			keyAppConnect,		/*   AEKeyword				   */
			typeAppConnect,		/*   Desired type.			   */
			&ignoredType,		/*   Type code.				   */
			ptr1,				/*   Pointer to area for data. */ 
			size,				/*   Size of data area.		   */
			&ignoredSize		/*   Returned size of data.	   */
		);
		HSetState((Handle)frHndl, hstate);
	}

	if (!err) {
		err = AEGetAttributeDesc(	/* Get address of sender.	 */
			message,				/*   Get address of sender from message. */
			keyAddressAttr,			/*   We want an address.				 */
			typeWildCard,			/*   We want the address of the sender.	 */
			&senderTarget			/*   Address of sender.					 */
		);
		if (!err) {
			(*frHndl)->connect.remoteLoc = senderTarget;
			err = AEGetParamPtr(	/* Get FSSpec (for document name) from AppleEvent. */
				message,			/*   The AppleEvent. 		   */
				keyFSS,				/*   AEKeyword				   */
				typeFSS,			/*   Desired type.			   */
				&ignoredType,		/*   Type code.				   */
				(Ptr)&myFSS,		/*   Pointer to area for data. */ 
				sizeof(FSSpec),		/*   Size of the data.		   */
				&ignoredSize		/*   Returned size of data.	   */
			);
			if (!err)
				pcpy((*frHndl)->fileState.fss.name, (StringPtr)myFSS.name);
		}
		if (!err) {
			err = AEGetParamPtr(	/* Get user name from AppleEvent. */
				message,			/*   The AppleEvent. 		   */
				keyPascal,			/*   AEKeyword				   */
				typePascal,			/*   Desired type.			   */
				&ignoredType,		/*   Type code.				   */
				(Ptr)remoteName,	/*   Pointer to area for data. */ 
				sizeof(Str255),		/*   Size of the data.		   */
				&ignoredSize		/*   Returned size of data.	   */
			);
			(*frHndl)->connect.remoteName[0] = 0;
			if (!err) {
				pcpy((*frHndl)->connect.remoteName, remoteName);
				remoteZone[0] = remoteMachine[0] = 0;
				GetTargetInfo(senderTarget, remoteZone, remoteMachine, remoteApp);
				pcpy((*frHndl)->connect.remoteZone, remoteZone);
				pcpy((*frHndl)->connect.remoteMachine, remoteMachine);
			}
		}

		theOtherPath[0] = theOtherApp[0] = 0;
		if (!err) {
			err = AEGetParamPtr(	/* Get user name from AppleEvent. */
				message,			/*   The AppleEvent. 		   */
				typePascal2,		/*   AEKeyword				   */
				typePascal2,		/*   Desired type.			   */
				&ignoredType,		/*   Type code.				   */
				(Ptr)theOtherPath,	/*   Pointer to area for data. */ 
				sizeof(Str255),		/*   Size of the data.		   */
				&ignoredSize		/*   Returned size of data.	   */
			);
		}
		if (!err) {
			err = AEGetParamPtr(	/* Get user name from AppleEvent. */
				message,			/*   The AppleEvent. 		   */
				typePascal3,		/*   AEKeyword				   */
				typePascal3,		/*   Desired type.			   */
				&ignoredType,		/*   Type code.				   */
				(Ptr)theOtherApp,	/*   Pointer to area for data. */ 
				sizeof(Str255),		/*   Size of the data.		   */
				&ignoredSize		/*   Returned size of data.	   */
			);
		}
	}

	if (!err) {		/* If we got the remote user address... */

		(*frHndl)->connect.windowTag[0] = windTag[0] = (TickCount() | 0x01);
		(*frHndl)->connect.connected = true;

		vers = (*frHndl)->d.doc.fhInfo.version;
		if ((vers < gMinVersion) || (vers > gMaxVersion))
			err = errAEWrongDataType;
				/* Incompatible file format. */

		if (!err) {
			windTag[1] = (*frHndl)->connect.windowTag[1];
			err = AEPutParamPtr(	/* Return receiver window ID. */
				reply,				/*   The AppleEvent. 		   */
				keyWindowTag,		/*   AEKeyword				   */
				typeDoubleLong,		/*   Type code.				   */
				(Ptr)&windTag[0],	/*   Pointer to area for data. */ 
				2 * sizeof(long)	/*   Size of data area.		   */
			);
		}

		if (!err) {
			remoteName[0] = 0;
			if (remoteNameHndl = GetAppResource('STR ', -16096, nil))
				pcpy(remoteName, (StringPtr)(*remoteNameHndl));
			err = AEPutParamPtr(	/* Return receiver user name. */
				reply,				/*   The AppleEvent. 		   */
				keyPascal,			/*   AEKeyword				   */
				typePascal,			/*   Type code.				   */
				(Ptr)remoteName,	/*   Pointer to area for data. */ 
				remoteName[0] + 1	/*   Size of data area.		   */
			);
		}

		if (!err) {
			if (theOtherPath[0]) {
				pcpy((*frHndl)->connect.remotePath, theOtherPath);
				pcpy((*frHndl)->connect.remoteApp,  theOtherApp);
				GetFullPathAndAppName(thisPath, thisApp);
				err = AEPutParamPtr(	/* Return receiver user name. */
					reply,				/*   The AppleEvent. 		   */
					typePascal2,		/*   AEKeyword				   */
					typePascal2,		/*   Type code.				   */
					(Ptr)thisPath,		/*   Pointer to area for data. */ 
					thisPath[0] + 1		/*   Size of data area.		   */
				);
				if (!err) {
					err = AEPutParamPtr(	/* Return receiver user name. */
						reply,				/*   The AppleEvent. 		   */
						typePascal3,		/*   AEKeyword				   */
						typePascal3,		/*   Type code.				   */
						(Ptr)thisApp,		/*   Pointer to area for data. */ 
						thisApp[0] + 1		/*   Size of data area.		   */
					);
				}
			}
		}

		if (!err)
			err = DoNewWindow(frHndl, nil, FrontWindow(), (WindowPtr)-1);
				/* If connecting worked, create a window for the document. */
	}

	if (err)
		DisposeDocument(frHndl);

	if (!err)
		NotifyUser();

	return(err);
}



/*****************************************************************************/



/* This function is called when you want to determine which window an AppleEvent
** is targeted for.  DTS.framework AppleEvents send two long values along with the AppleEvent
** to determine which window is the target window.  One of the longs is an ID for the
** sender, and the other is an ID for the receiver.  When a connection is established,
** these values are saved for both the sender and the receiver.  This allows the
** AppleEvent to be sent in either direction and still be targeted to the correct window.
** To find which window is the target, get these two longs out of the AppleEvent and then
** call GetAEWindow.  The first value is always the ID of the machine itself, and the
** second value is always the ID of the remote machine.  Due to this, you will need to
** reverse the order of these ID's for incomming DTS.framework AppleEvents. */

#pragma segment AppleEvents
static pascal OSErr	ReceiveConnectReply(AppleEvent *message, AppleEvent *reply)
{
#pragma unused (reply)

	OSErr			err, replyErr;
	DescType		actualType;
	long			windTag[2], actualSize;
	WindowPtr		window;
	FileRecHndl		frHndl;
	Str32			remoteZone, remoteMachine, remoteApp, remoteName;
	Str255			theOtherPath;
	Str32			theOtherApp;

	err = AEGetParamPtr(		/* Check for a receiver error... */
		message,				/*   The AppleEvent. 		   */
		keyReplyErr,			/*   AEKeyword				   */
		typeShortInteger,		/*   Desired type.			   */
		&actualType,			/*   Type code.				   */
		(Ptr)&replyErr,			/*   Pointer to area for data. */ 
		sizeof(short),			/*   Size of data area.		   */
		&actualSize				/*   Returned size of data.	   */
	);
	if (err == errAEDescNotFound)
		err = noErr;
	else
		if (!err)
			err = replyErr;

	if (!err) {
		err = AEGetParamPtr(	/* Get receiver window ID. */
			message,			/*   The AppleEvent. 		   */
			keyWindowTag,		/*   AEKeyword				   */
			typeDoubleLong,		/*   Desired type.			   */
			&actualType,		/*   Type code.				   */
			(Ptr)&windTag[0],	/*   Pointer to area for data. */ 
			2 * sizeof(long),	/*   Size of data area.		   */
			&actualSize			/*   Returned size of data.	   */
		);
	}

	if (!err) {		/* If we got the receiver window ID... */

		window = GetAEWindow(windTag[1], windTag[1]);
			/* The ID's are still both ours, since this is where we
			** get the receiver's ID returned.  windTag[0] holds the
			** receiver's ID, and windTag[1] holds ours. */

		if (window) {
			frHndl = (FileRecHndl)GetWRefCon(window);
			if (!(*frHndl)->connect.connected) {
				err = AEGetParamPtr(
					message,			/* The AppleEvent. 			 */
					keyPascal,			/* AEKeyword				 */
					typePascal,			/* Desired type.			 */
					&actualType,		/* Type code.				 */
					(Ptr)remoteName,	/* Pointer to area for data. */ 
					sizeof(Str255),		/* Size of data area.		 */
					&actualSize			/* Returned size of data.	 */
				);

				if (!err) {
					err = AEGetParamPtr(
						message,			/* The AppleEvent. 			 */
						typePascal2,		/* AEKeyword				 */
						typePascal2,		/* Desired type.			 */
						&actualType,		/* Type code.				 */
						(Ptr)theOtherPath,	/* Pointer to area for data. */ 
						sizeof(Str255),		/* Size of data area.		 */
						&actualSize			/* Returned size of data.	 */
					);
				}
				if (err == errAEDescNotFound) {
					theOtherPath[0] = 0;
					err = noErr;
				}
				if (!err) {
					err = AEGetParamPtr(
						message,			/* The AppleEvent. 			 */
						typePascal3,		/* AEKeyword				 */
						typePascal3,		/* Desired type.			 */
						&actualType,		/* Type code.				 */
						(Ptr)theOtherApp,	/* Pointer to area for data. */ 
						sizeof(Str255),		/* Size of data area.		 */
						&actualSize			/* Returned size of data.	 */
					);
				}
				if (err == errAEDescNotFound) {
					theOtherApp[0] = 0;
					err = noErr;
				}

				(*frHndl)->connect.remoteName[0] = 0;
				if (!err) {		/* Connection is for sure, so remember what we need. */
					(*frHndl)->connect.windowTag[1] = windTag[0];
					pcpy((*frHndl)->connect.remoteName, remoteName);
					GetTargetInfo((*frHndl)->connect.remoteLoc,
								  remoteZone, remoteMachine, remoteApp);
					pcpy((*frHndl)->connect.remoteZone,    remoteZone);
					pcpy((*frHndl)->connect.remoteMachine, remoteMachine);
					pcpy((*frHndl)->connect.remotePath,    theOtherPath);
					pcpy((*frHndl)->connect.remoteApp,     theOtherApp);
					(*frHndl)->connect.connected = true;
				}
				else
					(*frHndl)->connect.windowTag[0] = (*frHndl)->connect.windowTag[1] = 0;
			}
		}
	}

	return(err);
}



/*****************************************************************************/



/* Find the window with the specified window ID's. */

#pragma segment AppleEvents
WindowPtr	GetAEWindow(long windTag_0, long windTag_1)
{
	WindowPeek	window;
	FileRecHndl	frHndl;

	for (window = LMGetWindowList(); window; window = window->nextWindow) {
		if (IsAppWindow((WindowPtr)window)) {
			frHndl = (FileRecHndl)GetWRefCon((WindowPtr)window);
			if (
				((*frHndl)->connect.windowTag[0] == windTag_0) &&
				((*frHndl)->connect.windowTag[1] == windTag_1)
			) return((WindowPtr)window);
		}
	}

	return(nil);
}



/*****************************************************************************/



#pragma segment AppleEvents
void	GetFullPathAndAppName(StringPtr path, StringPtr app)
{
	ProcessSerialNumber	psn;
	ProcessInfoRec		pinfo;
	FSSpec				fss;

	pinfo.processInfoLength = sizeof(ProcessInfoRec);
	pinfo.processName       = app;
	pinfo.processAppSpec    = &fss;

	psn.lowLongOfPSN  = kCurrentProcess;
	psn.highLongOfPSN = kNoProcess;
	GetProcessInformation(&psn, &pinfo);

	PathNameFromDirID(pinfo.processAppSpec->parID, pinfo.processAppSpec->vRefNum, path);
}



/*****************************************************************************/



#pragma segment AppleEvents
void	AllowAutoReconnect(FileRecHndl frHndl)
{
	Str255	path;
	Str32	app;

	GetFullPathAndAppName(path, app);
	pcpy((*frHndl)->connect.remotePath, path);
	pcpy((*frHndl)->connect.remoteApp,  app);
}



/*****************************************************************************/



/* This function doesn't allow the PPCBrowser to display any applications other
** than the designated application(s). */

#pragma segment AppleEvents
pascal Boolean	AEPortFilter(LocationNamePtr locationName, PortInfoPtr thePortInfo)
{
#pragma unused (locationName)

	OSType	type;

	if (thePortInfo->name.portKindSelector == ppcByString) {
		BlockMove(thePortInfo->name.u.portTypeStr + 1, (Ptr)&type, 4);
			/* The BlockMove is so that we don't get an address error
			** on a 68000-based machine due to referencing a long at
			** an odd-address. */
		if (type == gDocCreator) return(true);
	}

	return(false);
}



/*****************************************************************************/



#pragma segment AppleEvents
OSErr	GetRemoteProcessTarget(FileRecHndl frHndl, AEDesc *retDesc, GRPTProcPtr proc)
{
	OSErr			err;
	char			hstate;
	PortInfoRec		info;		/* Just one, please. */
	LocationNameRec	loc;
	short			indx, reqCount, actCount;
	TargetID		theID;

	retDesc->dataHandle = nil;		/* So caller can dispose always. */

	hstate = LockHandleHigh((Handle)frHndl);
	loc.locationKindSelector = ppcNBPLocation;		/* Using an NBP construct. */
	pcpy(loc.u.nbpEntity.objStr,  (*frHndl)->connect.remoteMachine);
	pcpy(loc.u.nbpEntity.zoneStr, (*frHndl)->connect.remoteZone);
	pcpy(loc.u.nbpEntity.typeStr, "\pPPCToolBox");
	HSetState((Handle)frHndl, hstate);

	indx     = 0;
	reqCount = 1;
	actCount = 0;
	if (err = DoIPCListPorts(&indx, &reqCount, &actCount, &loc, &info, proc)) return(err);

	if (actCount) {
		theID.name = info.name;
		theID.location = loc;
		err = AECreateDesc(typeTargetID, (Ptr)&theID, sizeof(theID), retDesc);
	}

	return(err);
}



/*****************************************************************************/



/* Don't allow DoIPCListPorts to find anything but the finder. */

#pragma segment AppleEvents
static pascal Boolean	FinderFilter(LocationNamePtr locationName, PortInfoPtr thePortInfo);
static pascal Boolean	FinderFilter(LocationNamePtr locationName, PortInfoPtr thePortInfo)
{
#pragma unused (locationName)

	OSType	type;

	if (thePortInfo->name.portKindSelector == ppcByString) {
		BlockMove(thePortInfo->name.u.portTypeStr + 1, (Ptr)&type, 4);
			/* The BlockMove is so that we don't get an address error
			** on a 68000-based machine due to referencing a long at
			** an odd-address. */
		if (type == 'MACS') return(true);
	}

	return(false);
}

/***/

OSErr	LaunchRemoteApp(FileRecHndl frHndl)
{
	OSErr			err;
	AEDesc			remoteDesc, aeDirDesc, listElem, fileList;
	AppleEvent		aevt, aeReply;
	char			hstate;
	Str255			path;
	Str255			app;
	AliasHandle		dirAlias, fileAlias;
	ConnectRec		ac;

	err = noErr;
	ac  = (*frHndl)->connect;

	if (ac.remotePath[0]) {

		DoSetCursor(*GetCursor(watchCursor));

		if (!GetRemoteProcessTarget(frHndl, &remoteDesc, FinderFilter)) {

			err = AECreateAppleEvent('FNDR', 'sope', &remoteDesc,
									  kAutoGenerateReturnID, kAnyTransactionID, &aevt);
			AEDisposeDesc(&remoteDesc);

			if (!err) {

				hstate = LockHandleHigh((Handle)frHndl);
				pcpy(path, (*frHndl)->connect.remotePath);
				pcpy(app, path);
				pcat(app,  (*frHndl)->connect.remoteApp);
				HSetState((Handle)frHndl, hstate);
				NewAliasMinimalFromFullPath(path[0], (path + 1), "\p", "\p", &dirAlias);
				NewAliasMinimalFromFullPath(app[0],  (app + 1),  "\p", "\p", &fileAlias);

				err = AECreateList(nil, 0, false, &fileList);

				if (!err) {
					hstate = LockHandleHigh((Handle)dirAlias);
					err = AECreateDesc(typeAlias, (Ptr)*dirAlias,
									   GetHandleSize((Handle)dirAlias), &aeDirDesc);
					HSetState((Handle)dirAlias, hstate);
				}
				DisposeHandle((Handle)dirAlias);

				if (!err) {
					err = AEPutParamDesc(&aevt, keyDirectObject, &aeDirDesc);
					AEDisposeDesc(&aeDirDesc);
				}

				if (!err) {
					hstate = LockHandleHigh((Handle)fileAlias);
					err = AECreateDesc(typeAlias, (Ptr)*fileAlias,
									   GetHandleSize((Handle)fileAlias), &listElem);
					HSetState((Handle)dirAlias, hstate);
				}
				DisposeHandle((Handle)fileAlias);

				if (!err) {
					err = AEPutDesc(&fileList, 0, &listElem);
					AEDisposeDesc(&listElem);
				}

				if (!err) {
					err = AEPutParamDesc(&aevt, 'fsel', &fileList);
					AEDisposeDesc(&fileList);
				}

				if (!err) {
					err = AESend(&aevt, &aeReply,
								(kAENoReply + kAEAlwaysInteract + kAECanSwitchLayer),
								kAENormalPriority, kAEDefaultTimeout, nil, nil);
					AEDisposeDesc(&aeReply);
				}

				AEDisposeDesc(&aevt);
			}
		}
	}

	return(err);
}




/*
** Apple Macintosh Developer Technical Support
**
** File:		AEWFMT.c
** Written by:	Eric Soldan
**
** Copyright © 1993 Apple Computer, Inc.
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

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __RESOURCES__
#include "Resources.h"
#endif

#ifndef __TEXTEDITCONTROL__
#include "TextEditControl.h"
#endif

#ifndef __TOOLUTILS__
#include "ToolUtils.h"
#endif



/*****************************************************************************/



extern Boolean			gHasAppleEvents, gQuitApplication;
extern TreeObjHndl		gWindowFormats;

static pascal OSErr		ReceiveWFMT(AppleEvent *message, AppleEvent *reply, long refcon);
static void				MergeAppResources(StringPtr suffix);

#define keyPascalReply 'PSTR'
#define typePascal     'PSTR'



/*****************************************************************************/



static AEHandler keywordsToInstall[] = {
	{ kCustomEventClass, keyWFMTMessage, (ProcPtr)ReceiveWFMT, nil }
};

#define kNumKeywords (sizeof(keywordsToInstall) / sizeof(AEHandler))



/*****************************************************************************/
/*****************************************************************************/



/* Install our custom AppleEvents.  This is done in addition to installing
** the required AppleEvents.  InitAppleEvents, which installs the required
** AppleEvents, must be called first, since it sets up some global values. */

#pragma segment AppleEvents
void	InitWFMTAppleEvents(void)
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



/* Send a message to the running application for various application-editing functions.
** This is used by the AppsToGo application editor for editing running applications. */

#pragma segment AppleEvents
OSErr	SendWFMTMessage(FileRecHndl frHndl, TreeObjHndl wobj, short messageType,
						ResType rtype, short resID, Handle *resHndl, StringPtr suffix)
{
	AEAddressDesc	remoteLoc;
	OSErr			err;
	AppleEvent		theAevt, reply;
	WindowPtr		oldPort;
	Handle			mssgData;
	long			mssgSize, actualSize, oldSize, blockNum;
	DescType		actualType;
	AEKeyword		keym;
	DescType		typem;
	char			hstate;

	if (!(*frHndl)->connect.connected) return(noErr);

	oldPort = SetFilePort(frHndl);

	theAevt.dataHandle = reply.dataHandle = nil;
		/* Make sure disposing of the descriptors is okay in all cases. */
		/* Even though the AppleEvent manager nils out the handle upon failure,
		** the below code doesn't necessarily call the AppleEvent manager for each
		** descriptor.  By etting them to nil here, this allows us to just try to
		** dispose of the descriptors at the bottom of the function. */

	remoteLoc = (*frHndl)->connect.remoteLoc;

	err = AECreateAppleEvent(		/* CREATE EMPTY APPLEEVENT.	 */
		kCustomEventClass,			/* Event class.				 */
		typeWFMTMessage,			/* Event ID.				 */
		&remoteLoc,					/* Address of receiving app. */
		kAutoGenerateReturnID,		/* This value causes the	 */
									/* AppleEvent manager to	 */
									/* assign a return ID that	 */
									/* is unique to the session. */
		kAnyTransactionID,			/* Ignore transaction ID.	 */
		&theAevt					/* Location of event.		 */
	);

	if (!err)			/* Say what the message is. */
		AEPutParamPtr(&theAevt, keyDirectObject, typeShortInteger, (Ptr)&messageType, sizeof(short));

	if (!err) {
		blockNum = 0;
		AEPutParamPtr(&theAevt, typeBlockNum, typeBlockNum, (Ptr)&blockNum, sizeof(long));
	}

	/* The stuff that applies to all messages is now done.  Now specifically
	** handle all the different message types. */

	mssgData = nil;

	if (!err) {

		if (messageType == kMergeAppResourcesMssg) {
			messageType =  kSetWFMTMssg;
			err = AEPutParamPtr(
				&theAevt,
				keyPascalReply,
				typePascal,
				(Ptr)suffix,
				sizeof(Str32)
			);
		}

		switch (messageType) {

			case kGetWFMTMssg:
				break;

			case kSetWFMTMssg:
				err = HWriteTree(wobj, mssgData = NewHandle(0));
				if (!err) {
					mssgSize = GetHandleSize(mssgData);
					if (mssgSize > 30000) mssgSize = 30000;
					HLock(mssgData);
					err = AEPutParamPtr(
						&theAevt,
						keyWFMTMessage,
						typeWFMTMessage,
						*mssgData,
						mssgSize
					);
					HUnlock(mssgData);
				}
				break;

			case kGetAppResourceMssg:
				err = AEPutParamPtr(
					&theAevt,
					typeRSRCType,
					typeRSRCType,
					(Ptr)&rtype,
					sizeof(ResType)
				);
				if (!err) {
					err = AEPutParamPtr(
						&theAevt,
						typeRSRCID,
						typeRSRCID,
						(Ptr)&resID,
						sizeof(short)
					);
				}
				break;

			case kSetAppResourceMssg:
				err = AEPutParamPtr(
					&theAevt,
					typeRSRCType,
					typeRSRCType,
					(Ptr)&rtype,
					sizeof(ResType)
				);
				if (!err) {
					err = AEPutParamPtr(
						&theAevt,
						typeRSRCID,
						typeRSRCID,
						(Ptr)&resID,
						sizeof(short)
					);
				}
				if (!err) {
					hstate = HGetState(*resHndl);
					HLock(*resHndl);
					mssgSize = GetHandleSize(*resHndl);
					err = AEPutParamPtr(
						&theAevt,
						keyWFMTMessage,
						typeWFMTMessage,
						**resHndl,
						mssgSize
					);
					HSetState(*resHndl, hstate);
				}
				if (!err) {
					err = AESend(					/* SEND APPLEEVENT.				*/
						&theAevt,					/* Our Apple Event to send.		*/
						&reply,						/* We may have a reply.			*/
						kAEWaitReply,
						kAENormalPriority,			/* App. send priority.			*/
						300,
						nil,						/* No wait, no filter.			*/
						nil							/* EventFilterProcPtr.			*/
					);
				}
				break;
		}
	}

	if (!err) {
		if ((messageType == kGetWFMTMssg) || (messageType == kGetAppResourceMssg)) {

			if (resHndl) *resHndl = nil;

			mssgData = NewHandle(0);
			for (;;) {

				err = AESend(					/* SEND APPLEEVENT.				*/
					&theAevt,					/* Our Apple Event to send.		*/
					&reply,						/* We may have a reply.			*/
					kAEWaitReply,
					kAENormalPriority,			/* App. send priority.			*/
					300,
					nil,						/* No wait, no filter.			*/
					nil							/* EventFilterProcPtr.			*/
				);
				if (err) break;

				keym  = (messageType == kGetWFMTMssg) ? keyWFMTMessage  : keyRSRCMessage;
				typem = (messageType == kGetWFMTMssg) ? typeWFMTMessage : typeRSRCMessage;
				err = AEGetParamPtr(
					&reply,					/* The AppleEvent. 			 */
					keym,					/* AEKeyword				 */
					typem,					/* Desired type.			 */
					&actualType,			/* Type code.				 */
					nil,					/* Pointer to area for data. */ 
					0,						/* Size of data area.		 */
					&mssgSize				/* Returned size of data.	 */
				);
				if (err) break;

				oldSize = GetHandleSize(mssgData);
				SetHandleSize(mssgData, oldSize + mssgSize);
				if (err = MemError()) break;

				HLock(mssgData);
				err = AEGetParamPtr(
					&reply,					/* The AppleEvent. 			 */
					keym,					/* AEKeyword				 */
					typem,					/* Desired type.			 */
					&actualType,			/* Type code.				 */
					*mssgData + oldSize,	/* Pointer to area for data. */ 
					mssgSize,				/* Size of data area.		 */
					&actualSize				/* Returned size of data.	 */
				);
				HUnlock(mssgData);
				if (err) break;

				if (mssgSize < 30000) break;

				++blockNum;
				err = AEPutParamPtr(
					&theAevt,
					typeBlockNum,
					typeBlockNum,
					(Ptr)&blockNum,
					sizeof(long)
				);
				if (err) break;

			}

			if (messageType == kGetWFMTMssg) {
				if (!err)
					HReadTree(wobj, mssgData);
				if (mssgData)
					DisposeHandle(mssgData);
			}
			else {
				if (err) {
					if (mssgData) {
						DisposeHandle(mssgData);
						mssgData = nil;
					}
				}
				*resHndl = mssgData;
			}
		}
	}

	if (!err) {		/* If everything looks good... */
		if (messageType == kSetWFMTMssg) {
			do {
				if (err) {
					if (mssgData) {
						DisposeHandle(mssgData);
						mssgData = nil;
					}
					break;
				}
				err = AESend(					/* SEND APPLEEVENT.				*/
					&theAevt,					/* Our Apple Event to send.		*/
					&reply,						/* We may have a reply.			*/
					kAEWaitReply,
					kAENormalPriority,			/* App. send priority.			*/
					300,
					nil,						/* No wait, no filter.			*/
					nil							/* EventFilterProcPtr.			*/
				);
				if (err) continue;
				if (mssgData) {
					mssgSize = GetHandleSize(mssgData);
					if (mssgSize < 30000) {
						DisposeHandle(mssgData);
						mssgData = nil;
						break;
					}
					mssgSize -= 30000;
					BlockMove(*mssgData + 30000, *mssgData, mssgSize);
					SetHandleSize(mssgData, mssgSize);
					if (mssgSize > 30000) mssgSize = 30000;
					HLock(mssgData);
					err = AEPutParamPtr(
						&theAevt,
						keyWFMTMessage,
						typeWFMTMessage,
						*mssgData,
						mssgSize
					);
					HUnlock(mssgData);
					if (err) continue;
					++blockNum;
					err = AEPutParamPtr(
						&theAevt,
						typeBlockNum,
						typeBlockNum,
						(Ptr)&blockNum,
						sizeof(long)
					);
				}
			} while (mssgData);
#if 0
			if (!err) {
				AEDisposeDesc(&theAevt);
				AEDisposeDesc(&reply);
				err = AECreateAppleEvent(		/* CREATE EMPTY APPLEEVENT.	 */
					kCoreEventClass,			/* Event class.				 */
					kAEOpenApplication,			/* Event ID.				 */
					&remoteLoc,					/* Address of receiving app. */
					kAutoGenerateReturnID,		/* This value causes the	 */
												/* AppleEvent manager to	 */
												/* assign a return ID that	 */
												/* is unique to the session. */
					kAnyTransactionID,			/* Ignore transaction ID.	 */
					&theAevt					/* Location of event.		 */
				);
				if (!err) {
					err = AESend(					/* SEND APPLEEVENT.				*/
						&theAevt,					/* Our Apple Event to send.		*/
						&reply,						/* We may have a reply.			*/
						kAEWaitReply,
						kAENormalPriority,			/* App. send priority.			*/
						300,
						nil,						/* No wait, no filter.			*/
						nil							/* EventFilterProcPtr.			*/
					);
				}
			}
#endif
		}
	}

	AEDisposeDesc(&theAevt);
	AEDisposeDesc(&reply);
		/* Dispose of the descriptors, created or not.  If not created, no harm done by calling. */

	SetPort(oldPort);
	return(err);
}



/*****************************************************************************/



#pragma segment AppleEvents
static pascal OSErr	ReceiveWFMT(AppleEvent *message, AppleEvent *reply, long refcon)
{
#pragma unused (reply, refcon)

	OSErr			err;
	short			messageType, oldRes, i, vRefNum, resID;
	char			hstate;
	ResType			rtype;
	Handle			oldr, rsrc;
	WindowPtr		window;
	FileRecHndl		frHndl;
	DescType		actualType;
	long			actualSize, dirID, blockNum, blockBeg, blockSiz;
	MenuHandle		menu;
	long			mssgSize;
	Str32			fileName, suffix;
	Handle			mssgData;
	static Handle	accumMssgData;
	static short	count;

	err = AEGetParamPtr(		/* GET THE MESSAGE TYPE.	 */
		message,				/* The AppleEvent. 			 */
		keyDirectObject,		/* AEKeyword				 */
		typeShortInteger,		/* Desired type.			 */
		&actualType,			/* Type code.				 */
		(Ptr)&messageType,		/* Pointer to area for data. */ 
		sizeof(short),			/* Size of data area.		 */
		&actualSize				/* Returned size of data.	 */
	);

	if (!err) {		/* If everything is cool, then do the specific task... */

		switch(messageType) {

			case kGetWFMTMssg:
				mssgData = NewHandle(0);
				if (gWindowFormats)
					err = HWriteTree(gWindowFormats, mssgData);
				if (!err) {
					err = AEGetParamPtr(
						message,
						typeBlockNum,
						typeBlockNum,
						&actualType,
						(Ptr)&blockNum,
						sizeof(long),
						&actualSize
					);
					if (!err) {
						mssgSize = GetHandleSize(mssgData);
						blockBeg = blockNum * 30000;
						blockSiz = mssgSize - blockBeg;
						if (blockSiz < 0)     blockSiz = 0;
						if (blockSiz > 30000) blockSiz = 30000;
						HLock(mssgData);
						err = AEPutParamPtr(
							reply,
							keyWFMTMessage,
							typeWFMTMessage,
							*mssgData + blockBeg,
							blockSiz
						);
					}
				}
				DisposeHandle(mssgData);
				break;

			case kSetWFMTMssg:
			case kMergeAppResourcesMssg:
				err = AEGetParamPtr(
					message,
					typeBlockNum,
					typeBlockNum,
					&actualType,
					(Ptr)&blockNum,
					sizeof(long),
					&actualSize
				);
				if (err) break;
				err = AEGetParamPtr(
					message,				/* The AppleEvent. 			 */
					keyWFMTMessage,			/* AEKeyword				 */
					typeWFMTMessage,		/* Desired type.			 */
					&actualType,			/* Type code.				 */
					nil,					/* Pointer to area for data. */ 
					0,						/* Size of data area.		 */
					&mssgSize				/* Returned size of data.	 */
				);
				if (err) break;

				if ((blockNum) && (!accumMssgData)) {
					err = memFullErr;
					break;
				}

				if (!blockNum)
					if (!accumMssgData)
						accumMssgData = NewHandle(0);

				SetHandleSize(accumMssgData, blockNum * 30000 + mssgSize);
				err = MemError();
				if (err) {
					DisposeHandle(accumMssgData);
					accumMssgData = nil;
					break;
				}

				HLock(accumMssgData);
				err = AEGetParamPtr(
					message,							/* The AppleEvent. 			 */
					keyWFMTMessage,						/* AEKeyword				 */
					typeWFMTMessage,					/* Desired type.			 */
					&actualType,						/* Type code.				 */
					*accumMssgData + blockNum * 30000,	/* Pointer to area for data. */ 
					mssgSize,							/* Size of data area.		 */
					&actualSize							/* Returned size of data.	 */
				);
				HUnlock(accumMssgData);

				if (mssgSize == 30000) break;		/* More blocks to come. */

				if (!err) {
					while (window = GetNextWindow(nil, 0)) {
						frHndl = (FileRecHndl)GetWRefCon(window);
						(*frHndl)->fileState.docDirty = false;
							/* Prevent save-before-closing dialogs. */
						(*frHndl)->fileState.attributes &= (0xFFFFFFFFL - kwHideOnClose);
							/* Make sure that we aren't just hiding old windows. */
						DisposeOneWindow(window, kClose);
						gQuitApplication = false;
							/* App may only have one window, and when it is closed,
							** the app quits.  This behavior of the app is like DA's.
							** Prevent the app from quitting. */
					}
					if (!err) {
						oldRes = CurResFile();
						UseResFile(gAppResRef);
						if (oldr = Get1Resource('WFMT', 128)) {
							RmveResource(oldr);
							DisposeHandle(oldr);
						}
						AddResource(accumMssgData, 'WFMT', 128, nil);
						ChangedResource(accumMssgData);
						WriteResource(accumMssgData);
						UpdateResFile(gAppResRef);
						DetachResource(accumMssgData);
						if (!GetFileLocation(gAppResRef, &vRefNum, &dirID, fileName))
							FlushVol(nil, vRefNum);
						UseResFile(oldRes);
					}
					HReadWindowFormats(accumMssgData);
				}

				if (accumMssgData) {
					DisposeHandle(accumMssgData);
					accumMssgData = nil;
				}

				oldRes = CurResFile();
				UseResFile(gAppResRef);
				for (i = Count1Resources('MENU'); i; --i) {
					menu = (MenuHandle)Get1IndResource('MENU', i);
					if (!menu) continue;
					DeleteMenu(**(short **)menu);
					DisposeMenu(menu);
				}
				UseResFile(oldRes);

				if (messageType == kMergeAppResourcesMssg) {
					pcpy(suffix, "\p copy");
					AEGetParamPtr(
						message,
						keyPascalReply,
						typePascal,
						&actualType,
						(Ptr)suffix,
						sizeof(Str32),
						&actualSize
					);
					MergeAppResources(suffix);
				}

				UseResFile(gAppResRef);
				StandardMenuSetup(rMenuBar, mApple);
				UseResFile(oldRes);

				OpenRuntimeOnlyAutoNewWindows();
				DoOpenApplication();
				DoAEOpenApplication(nil, nil, 0L);

				break;

			case kGetAppResourceMssg:
				err = AEGetParamPtr(
					message,
					typeRSRCType,
					typeRSRCType,
					&actualType,
					(Ptr)&rtype,
					sizeof(ResType),
					&actualSize
				);
				if (!err) {
					err = AEGetParamPtr(
						message,
						typeRSRCID,
						typeRSRCID,
						&actualType,
						(Ptr)&resID,
						sizeof(long),
						&actualSize
					);
				}
				if (!err) {
					rsrc = GetAppResource(rtype, resID, nil);
					if (rsrc) {
						hstate = HGetState(rsrc);
						HLock(rsrc);
						err = AEGetParamPtr(
							message,
							typeBlockNum,
							typeBlockNum,
							&actualType,
							(Ptr)&blockNum,
							sizeof(long),
							&actualSize
						);
						if (!err) {
							mssgSize = GetHandleSize(rsrc);
							blockBeg = blockNum * 30000;
							blockSiz = mssgSize - blockBeg;
							if (blockSiz < 0)     blockSiz = 0;
							if (blockSiz > 30000) blockSiz = 30000;
							err = AEPutParamPtr(
								reply,
								keyRSRCMessage,
								typeRSRCMessage,
								*rsrc + blockBeg,
								mssgSize
							);
						}
						HSetState(rsrc, hstate);
					}
				}
				break;

			case kSetAppResourceMssg:
				err = AEGetParamPtr(
					message,
					typeRSRCType,
					typeRSRCType,
					&actualType,
					(Ptr)&rtype,
					sizeof(ResType),
					&actualSize
				);
				if (!err) {
					err = AEGetParamPtr(
						message,
						typeRSRCID,
						typeRSRCID,
						&actualType,
						(Ptr)&resID,
						sizeof(long),
						&actualSize
					);
				}
				err = AEGetParamPtr(
					message,				/* The AppleEvent. 			 */
					keyWFMTMessage,			/* AEKeyword				 */
					typeWFMTMessage,		/* Desired type.			 */
					&actualType,			/* Type code.				 */
					nil,					/* Pointer to area for data. */ 
					0,						/* Size of data area.		 */
					&mssgSize				/* Returned size of data.	 */
				);
				if (err) break;
				mssgData = NewHandle(mssgSize);
				if (!mssgData) break;
				HLock(mssgData);
				err = AEGetParamPtr(
					message,				/* The AppleEvent. 			 */
					keyWFMTMessage,			/* AEKeyword				 */
					typeWFMTMessage,		/* Desired type.			 */
					&actualType,			/* Type code.				 */
					*mssgData,				/* Pointer to area for data. */ 
					mssgSize,				/* Size of data area.		 */
					&actualSize				/* Returned size of data.	 */
				);
				HUnlock(mssgData);
				if (!err) {
					oldRes = CurResFile();
					UseResFile(gAppResRef);
					if (oldr = Get1Resource(rtype, resID)) {
						RmveResource(oldr);
						DisposeHandle(oldr);
					}
					AddResource(mssgData, rtype, resID, nil);
					ChangedResource(mssgData);
					WriteResource(mssgData);
					UpdateResFile(gAppResRef);
					DetachResource(mssgData);
					if (!GetFileLocation(gAppResRef, &vRefNum, &dirID, fileName))
						FlushVol(nil, vRefNum);
					UseResFile(oldRes);
				}
				DisposeHandle(mssgData);
				break;
		}
	}

	return(err);
}




/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



#pragma segment AppleEvents
static void	MergeAppResources(StringPtr suffix)
{
	short				oldRes, numAppTypes, numAppItems, numCpyTypes, numCpyItems;
	short				tt, ii, dd, mergeRsrc, rid, cid, vRefNum;
	char				appAttr, cpyAttr;
	ResType				appType, cpyType, rtype, ddType, ctype;
	long				l, cpySize, dirID;
	ProcessSerialNumber	psn;
	ProcessInfoRec		pinfo;
	FSSpec				fss;
	Str255				rname, cname;
	Str32				dontDo, fileName;
	Handle				appr, cpyr;
	OSErr				err;

	oldRes = CurResFile();

	pinfo.processInfoLength = sizeof(ProcessInfoRec);
	pinfo.processName       = gAppName;
	pinfo.processAppSpec    = &fss;

	psn.lowLongOfPSN  = kCurrentProcess;
	psn.highLongOfPSN = kNoProcess;
	GetProcessInformation(&psn, &pinfo);

	pcat(fss.name, suffix);

	SetResLoad(false);
	mergeRsrc = HOpenResFile(fss.vRefNum, fss.parID, fss.name, fsRdPerm);
	err = ResError();
	SetResLoad(true);
	if (err) return;

	UseResFile(gAppResRef);
	numAppTypes = Count1Types();

	for (tt = numAppTypes; tt; --tt) {
		Get1IndType(&appType, tt);
		numAppItems = Count1Resources(appType);

		for (ii = numAppItems; ii; --ii) {

			appr = Get1IndResource(appType, ii);
			if (!appr) continue;

			GetResInfo(appr, &rid, &rtype, rname);
			appAttr  = GetResAttrs(appr);

			if (rtype == 'WFMT') continue;
				/* ResEdit doesn't modify this one.  DTSFW.App.Editor does. */

			if ((rtype == 'STR#') && (rid == 128)) continue;
				/* This is the resource that describes what resources can be replaced/modified.
				** We don't want to replace or modify what is telling us what to do. */

			for (dd = 1;; ++dd) {
				GetIndString(dontDo, 128, dd);
				if (!dontDo[0]) break;
				BlockMove(dontDo + 1, &ddType, sizeof(long));
				if (appType == ddType) break;
			}
			if (dontDo[0]) continue;

			UseResFile(mergeRsrc);
			cpyr = Get1Resource(rtype, rid);
			if (cpyr) {
				GetResInfo(cpyr, &cid, &ctype, cname);
				cpyAttr = GetResAttrs(cpyr);
				DetachResource(cpyr);
				HNoPurge(cpyr);
			}
			UseResFile(gAppResRef);
			appr = Get1IndResource(appType, ii);		/* In case it's purgeable and got purged. */
			if (!appr) {								/* Just to be really safe. */
				DisposeHandle(cpyr);
				continue;
			}

			if (!cpyr) {
				RmveResource(appr);
				DisposeHandle(appr);
				continue;
			}

			if (appAttr != cpyAttr) {
				SetResAttrs(appr, cpyAttr);
				ChangedResource(appr);
				WriteResource(appr);
			}
			appr = Get1IndResource(appType, ii);		/* In case it's purgeable and got purged. */
			if (!appr) {								/* Just to be really safe. */
				DisposeHandle(cpyr);
				continue;
			}

			if (pcmp(rname, cname)) {
				SetResInfo(appr, rid, cname);
				ChangedResource(appr);
				WriteResource(appr);
			}
			appr = Get1IndResource(appType, ii);		/* In case it's purgeable and got purged. */
			if (!appr) {								/* Just to be really safe. */
				DisposeHandle(cpyr);
				continue;
			}

			if (GetHandleSize(appr) != (cpySize = GetHandleSize(cpyr))) {
				HNoPurge(appr);
				HUnlock(appr);
				SetHandleSize(appr, cpySize);
				err = MemError();
				SetResAttrs(appr, cpyAttr);
				if (err) {
					DisposeHandle(cpyr);
					continue;
				}
				BlockMove(*cpyr, *appr, cpySize);
				ChangedResource(appr);
				WriteResource(appr);
				DisposeHandle(cpyr);
				continue;
			}

			for (l = 0; l < cpySize; ++l) {
				if ((*appr)[l] != (*cpyr)[l]) {
					BlockMove(*cpyr, *appr, cpySize);
					ChangedResource(appr);
					WriteResource(appr);
					DisposeHandle(cpyr);
					break;
				}
			}
			if (l < cpySize) continue;

			DisposeHandle(cpyr);
		}
	}

	UseResFile(mergeRsrc);
	numCpyTypes = Count1Types();

	for (tt = numCpyTypes; tt; --tt) {
		Get1IndType(&cpyType, tt);
		numCpyItems = Count1Resources(cpyType);

		for (ii = numCpyItems; ii; --ii) {

			cpyr = Get1IndResource(cpyType, ii);
			if (!cpyr) continue;

			cpyAttr = GetResAttrs(cpyr);
			GetResInfo(cpyr, &cid, &ctype, cname);
			DetachResource(cpyr);

			UseResFile(gAppResRef);
			appr = Get1Resource(ctype, cid);
			UseResFile(mergeRsrc);

			if (!appr) {
				UseResFile(gAppResRef);
				AddResource(cpyr, ctype, cid, cname);
				SetResAttrs(cpyr, cpyAttr);
				ChangedResource(cpyr);
				WriteResource(cpyr);
				DetachResource(cpyr);
				UseResFile(mergeRsrc);
			}

			DisposeHandle(cpyr);
		}
	}

	CloseResFile(mergeRsrc);
	UpdateResFile(gAppResRef);

	if (!GetFileLocation(gAppResRef, &vRefNum, &dirID, fileName))
		FlushVol(nil, vRefNum);

	UseResFile(oldRes);
}




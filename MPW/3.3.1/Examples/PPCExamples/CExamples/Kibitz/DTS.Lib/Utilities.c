/*
**	Apple Macintosh Developer Technical Support
**
**	Collection of Utilities for DTS Sample code
**
**	File:		Utilities.c
**
**	Copyright © 1988-1993 Apple Computer, Inc.
**	All rights reserved.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */

/* We require GetAppParms from SegLoad.h for pre-System 7.0 68K compatibility, so define OBSOLETE */
#ifndef powerc
#define OBSOLETE
#endif
#ifndef __SEGLOAD__
#include <SegLoad.h>
#endif
#ifndef powerc
#undef OBSOLETE
#endif

#ifndef __CONTROLS__
#include <Controls.h>
#endif

#ifndef __DESK__
#include <Desk.h>
#endif

#ifndef __DEVICES__
#include <Devices.h>
#endif

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __FONTS__
#include <Fonts.h>
#endif

#ifndef __GWLAYERS__
#include "GWLayers.h"
#endif

#ifndef __LOWMEM__
#include <LowMem.h>
#endif

#ifndef __MENUS__
#include <Menus.h>
#endif

#ifndef __NOTIFICATION__
#include <Notification.h>
#endif

#ifndef __OSEVENTS__
#include <OSEvents.h>
#endif

#ifndef __PACKAGES__
#include <Packages.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __SCRIPT__
#include <Script.h>
#endif

#ifndef __STDLIB__
#include <StdLib.h>
#endif

#ifndef __STRINGS__
#include <Strings.h>
#endif

#ifndef __TEXTEDIT__
#include <TextEdit.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif

#ifndef __COMPONENTS__
#include <Components.h>
#endif

#ifndef __FIXMATH__
#include <FixMath.h>
#endif

#ifndef __GESTALTEQU__
#include <GestaltEqu.h>
#endif

#ifndef __FOLDERS__
#include <Folders.h>
#endif

#ifndef __MOVIES__
#include <Movies.h>
#endif

#ifndef __PALETTES__
#include <Palettes.h>
#endif

#ifndef __STRINGUTILS__
#include "StringUtils.h"
#endif

#ifndef __TRAPS__
#include <Traps.h>
#endif

#include "Utilities.h"



/*****************************************************************************/



/* Global variables -- See Utilities.h for more explanation. */

short			gMachineType;			/* which machine this is */
short			gSystemVersion;			/* System version number */
short			gProcessorType;			/* which CPU this is */
Boolean			gHasFPU;				/* true if machine has an FPU */
short			gQDVersion;				/* major QD version #; 0 for original,
													1 for color QD, 2 for 32-bit QD */
short			gKeyboardType;			/* which type of keyboard is present */
short			gAppleTalkVersion;		/* AppleTalk version number */
Boolean			gHasPMMU;				/* true if machine has a PMMU or equivalent */
short			gAUXVersion;			/* major A/UX version number (0 if not present) */

Boolean			gHasWaitNextEvent;
short			gAppResRef;
Boolean			gInBackground;
Str255			gAppName;
OSType			gSignature = '\?\?\?\?';
Boolean			gHaveSystemInfo;

GrafPtr			gScreenPort;

long			gQTVersion;					/* QuickTime version (0 means not available). */
Component		gMovieControllerComponent;	/* QuickTime movie controller component reference. */
											/* Call InitQuickTime to initialize these globals. */

OSErr			gGetWindowErr;
WindowTemplate	gWindowTemplate;
WindowTemplate	gOpenedWindowTemplate;
ControlHandle	gWhichCtlHit;
long			gWhichCtlWhen;
Boolean			gWhichCtlDbl;
Boolean			gWhichCtlTracking;

static Handle	gScrollProc;
Handle			gPopupProc;
static Handle	gButtonProcs[radioButProc + useWFont + 1];
static Rect		gWindowPlacementRect;

static DrawControlProc	gDrawControl;

/* For PowerPC, we must supply an instantiation of the qd globals - MPW does it for you */
#ifdef powerc
QDGlobals		qd;
#endif

/* 
 *	The following creates global routine descriptors in our global address space.
 *	It saves us having to check at runtime whether or not they are initialized and
 *	then having to allocate them on the heap using NewRoutineDescriptor.
 *	But it has the disadvantage of requiring some conditional compilation.
 */
#if USESROUTINEDESCRIPTORS
static RoutineDescriptor gAlertFilterRD		= BUILD_ROUTINE_DESCRIPTOR (uppModalFilterProcInfo, AlertFilter);
static RoutineDescriptor gKeyEquivFilterRD	= BUILD_ROUTINE_DESCRIPTOR (uppModalFilterProcInfo, KeyEquivFilter);
ModalFilterUPP	gAlertFilterUPP				= &gAlertFilterRD;
ModalFilterUPP	gKeyEquivFilterUPP			= &gKeyEquivFilterRD;
#else
ModalFilterUPP	gAlertFilterUPP				= AlertFilter;
ModalFilterUPP	gKeyEquivFilterUPP			= KeyEquivFilter;
#endif

/*****************************************************************************/



#pragma segment UtilMain
Rect	SetWindowPlacementRect(Rect *rct)
{
	Rect	r;

	r = gWindowPlacementRect;
	if (rct) gWindowPlacementRect = *rct;
	return(r);
}



/*****************************************************************************/



/* Given an alert ID and a window pointer the alert relates to, this function
** will center the alert’s rectangle before showing it on the proper screen.
** This follows the Apple Human Interface Guidelines for where to place a
** centered window on the screen.  If the alert is not closely associated with
** another window, pass a nil for the window pointer of the related window.  If
** you pass a nil, the alert is simply displayed where the resource
** would indicate.  Note that if an error occurs when getting the resource for
** the alert, then the alert is not displayed, and the returned value is not
** the item hit, but is the error that occured when reading the resource. */

#pragma segment UtilMain
short	CenteredAlert(short alertID, WindowPtr relatedWindow, ModalFilterUPP filter)
{
	AlertTHndl	alertHandle;
	WindowPtr	tempWindow;
	Rect		alertRect, sizeInfo;
	short		itemHit;
	char		hstate;
	OSErr		err;

	itemHit = 1;

	if (!SimpleCanDialog()) {
		alertHandle = (AlertTHndl)GetAppResource('ALRT', alertID, &err);
		if (err) return((short)err);

		hstate = LockHandleHigh((Handle)alertHandle);
			/* Do our part to help prevent fragmentation. */

		alertRect = (*alertHandle)->boundsRect;
			/* Preserve the real alert bounding rectangle. */

		if (tempWindow = NewWindow(nil, &alertRect, "\p", false, dBoxProc,
								  (WindowPtr)nil, false, 0)) {
			/* Use an invisible temporary window to calculate where the alert will go. */

			SetRect(&sizeInfo, 0, 0, 0, 0);
			(*alertHandle)->boundsRect = CenterWindow(tempWindow, relatedWindow, sizeInfo);
			DisposeWindow(tempWindow);
		}

		itemHit = Alert(alertID, filter);

		if (alertHandle = (AlertTHndl)GetAppResource('ALRT', alertID, &err)) {
			(*alertHandle)->boundsRect = alertRect;
			HSetState((Handle)alertHandle, hstate);
		}		/* Restore the resource's bounding rect, so if this resource is ever used
				** not through this function, it will open where the resource indicates. */

	}

	return(itemHit);
}



/*****************************************************************************/



/* Given two rects, this function centers the second one within the first. */

#pragma segment UtilMain
void	CenterRectInRect(Rect outerRect, Rect *innerRect)
{
	PositionRectInRect(outerRect, innerRect, FixRatio(1, 2), FixRatio(1, 2));
}



/*****************************************************************************/



/* Center a window within a particular device.  The device to center the window
** within is determined by passing a related window.  This allows related
** windows to be kept on the same device.  This is useful if an alert is related
** to a specific window, for example. */

#pragma segment UtilMain
Rect	CenterWindow(WindowPtr window, WindowPtr relatedWindow, Rect sizeInfo)
{
	WindowPtr	whichDevice;
	Rect		deviceRect, oldWindowRect, newWindowRect, contentRect;
	short		h, v, hh, vv;

	if (!(whichDevice = relatedWindow))
		whichDevice = window;
			/* If we have a window to center against, use the device for that window,
			** else use the device for the window that is getting centered. */

	deviceRect = GetWindowDeviceRectNMB(whichDevice);
		/* We now have the rectangle of the device we want to center within. */

	if (!EmptyRect(&gWindowPlacementRect))
		deviceRect = gWindowPlacementRect;

	contentRect = GetWindowContentRect(window);		/* Get where the window is now. */
	h = hh = contentRect.right  - contentRect.left;
	v = vv = contentRect.bottom - contentRect.top;
	if (sizeInfo.left)
		if (h < sizeInfo.left)
			h = sizeInfo.left;
	if (sizeInfo.right)
		if (h > sizeInfo.right)
			h = sizeInfo.right;
	if (sizeInfo.top)
		if (v < sizeInfo.top)
			v = sizeInfo.top;
	if (sizeInfo.bottom)
		if (v > sizeInfo.bottom)
			v = sizeInfo.bottom;
	contentRect.right  = contentRect.left + h;
	contentRect.bottom = contentRect.top  + v;

	oldWindowRect = GetWindowStructureRect(window);
	oldWindowRect.right  += (h - hh);
	oldWindowRect.bottom += (v - vv);
	newWindowRect = oldWindowRect;

	PositionRectInRect(deviceRect, &newWindowRect, FixRatio(1, 2), FixRatio(1, 3));
		/* Figure out the new window strucRect so we can compare it against
		** the old strucRect.  This will tell us how much to move the window. */

	OffsetRect(&contentRect, newWindowRect.left - oldWindowRect.left,
							newWindowRect.top  - oldWindowRect.top);
		/* Calculate the new content rect. */

	MoveWindow(window, contentRect.left, contentRect.top, false);
		/* Move the window to the new location. */

	return(contentRect);
}



/*****************************************************************************/



/* Close a window.  This handles desk accessory and application windows.  Use
** this call (instead of DisposeAnyWindow) if the memory for the window was
** allocated by you.  (Same as CloseWindow v.s. DisposeWindow.) */

#pragma segment UtilMain
void	CloseAnyWindow(WindowPtr window)
{
	if (IsDAWindow(window))
		CloseDeskAcc(((WindowPeek)window)->windowKind);
	else {
		HideWindow(window);
		if (IsAppWindow(window))
			CloseWindow(window);
		else if (((WindowPeek)window)->windowKind >= dialogKind)
			CloseDialog((DialogPtr)window);
	}
}



/*****************************************************************************/



/* Dispose a window.  This handles desk accessory and application windows.  Use
** this call (instead of CloseAnyWindow) if you want the memory for the window
** record to be disposed of.  (Same as CloseWindow v.s. DisposeWindow.) */

#pragma segment UtilMain
void	DisposeAnyWindow(WindowPtr window)
{
	if (IsDAWindow(window))
		CloseDeskAcc(((WindowPeek)window)->windowKind);
	else {
		HideWindow(window);
		if (IsAppWindow(window))
			DisposeWindow(window);
		else if (((WindowPeek)window)->windowKind >= dialogKind)
			DisposDialog((DialogPtr)window);
	}
}



/*****************************************************************************/



/* Display an alert that tells the user an error occurred, then exit the
** program.  This function is used as an ultimate bail-out for serious errors
** that prohibit the continuation of the application.  Errors that do not
** require the termination of the application should be handled in a different
** manner. */

#pragma segment UtilMain
void	DeathAlert(short errResID, short errStringIndex)
{
	ErrorAlert(errResID, errStringIndex);
	ExitToShell();
}



/*****************************************************************************/



/* Display an alert that tells the user an error occurred, then exit the
** program.  This function is used as an ultimate bail-out for serious errors
** that prohibit the continuation of the application.  Errors that do not
** require the termination of the application should be handled in a different
** manner.  The message parameter is an error code that is to be displayed. */

#pragma segment UtilMain
void	DeathAlertMessage(short errResID, short errStringIndex, short message)
{
	ErrorAlertMessage(errResID, errStringIndex, message);
	ExitToShell();
}



/*****************************************************************************/



/* Display an alert that tells the user an error occurred. */

#pragma segment UtilMain
void	ErrorAlert(short errResID, short errStringIndex)
{
	ErrorAlertMessage(errResID, errStringIndex, 0);
}



/*****************************************************************************/



/* Display an alert to inform the user of an error.  errStringIndex acts as an
** index into a STR# resource of error messages.  If no errStringIndex is
** given, i.e. = 0, then use a standard message.  If message is not noErr then
** display it as well.
**
** BUG NOTE:  GetIndString returns a bogus String if the index is
**            not positive. */

#pragma segment UtilMain
void	ErrorAlertMessage(short errResID, short errStringIndex, short message)
{
	Str255	msg1, msg2;

	SetCursor(&QD(arrow));

	if (errStringIndex <= 0) {
		errStringIndex = eStandardErr;
		errResID = rUtilStrings;
	}
	GetIndString(msg1, errResID, errStringIndex);

	if (message == noErr) {
		ParamText(msg1, "\p", "\p", "\p");
		CenteredAlert(rUtilErrorAlert, nil, nil);
	} else {
		pcpydec(msg2, message);
		ParamText(msg1, msg2, "\p", "\p");
		CenteredAlert(rUtilErrorMessageAlert, nil, nil);
	}
}



/*****************************************************************************/



/* FindSysFolder returns the (real) vRefNum, and the DirID of the current
** system folder.  It uses the Folder Manager if present, otherwise it falls
** back to SysEnvirons.  It returns zero on success, otherwise a standard
** system error. */

#pragma segment UtilMain
OSErr	FindSysFolder(short *foundVRefNum, long *foundDirID)
{
	long			gesResponse;
	SysEnvRec		envRec;
	WDPBRec			myWDPB;
	unsigned char	volName[34];
	OSErr			err;

	*foundVRefNum = 0;
	*foundDirID = 0;
	if (!Gestalt(gestaltFindFolderAttr, &gesResponse) &&
		BTstQ(gesResponse, gestaltFindFolderPresent)) {		/* Does Folder Manager exist? */
			err = FindFolder(kOnSystemDisk, kSystemFolderType, kDontCreateFolder,
				foundVRefNum, foundDirID);
	} else {
		/* Gestalt can't give us the answer, so we resort to SysEnvirons */
		if (!(err = SysEnvirons(curSysEnvVers, &envRec))) {
			myWDPB.ioVRefNum = envRec.sysVRefNum;
			volName[0] = '\000';					/* Zero volume name */
			myWDPB.ioNamePtr = volName;
			myWDPB.ioWDIndex = 0;
			myWDPB.ioWDProcID = 0;
			if (!(err = PBGetWDInfo(&myWDPB, 0))) {
				*foundVRefNum = myWDPB.ioWDVRefNum;
				*foundDirID = myWDPB.ioWDDirID;
			}
		}
	}
	return(err);
}



/*****************************************************************************/



/* GetAppIndResource gets a resource from the application's resource file
** by index. */

#pragma segment UtilMain
Handle	GetAppIndResource(ResType theType, short index, OSErr *err)
{
	short	savedResFile;
	Handle	returnHandle;

	savedResFile = CurResFile();
	UseResFile(gAppResRef);
	returnHandle = Get1IndResource(theType, index);
	if (err) *err = ResError();
	UseResFile(savedResFile);
	return(returnHandle);
}



/*****************************************************************************/



/* GetAppNamedResource gets a resource from the application's resource file
** by name. */

#pragma segment UtilMain
Handle	GetAppNamedResource(ResType theType, StringPtr name, OSErr *err)
{
	short	savedResFile;
	Handle	returnHandle;

	savedResFile = CurResFile();
	UseResFile(gAppResRef);
	returnHandle = Get1NamedResource(theType, name);
	if (err) *err = ResError();
	UseResFile(savedResFile);
	return(returnHandle);
}



/*****************************************************************************/



/* GetAppResource gets a resource from the application's resource file by
** resource ID. */

#pragma segment UtilMain
Handle	GetAppResource(ResType theType, short theID, OSErr *err)
{
	short	savedResFile;
	Handle	returnHandle;

	savedResFile = CurResFile();
	UseResFile(gAppResRef);
	returnHandle = Get1Resource(theType, theID);
	if (err) *err = ResError();
	UseResFile(savedResFile);
	return(returnHandle);
}



/*****************************************************************************/



/* Checks for the presence of A/UX by whatever means is appropriate.  Returns
** the major version number of A/UX (i.e. 0 if A/UX is not present, 1 for
** any 1.x.x version 2 for any 2.x version, etc.
**
** This code should work for all past, present and future A/UX systems. */

#define HWCfgFlags	0xB22	/* Low memory global used to check if A/UX is running */

#pragma segment UtilMain
short	GetAUXVersion(void)
{
	long	auxVersion;
	short	err;
	short	*flagPtr;

	/* This code assumes the Gestalt glue checks for the presence of the _Gestalt
	** trap and does something intelligent if the trap is unavailable, i.e.
	** return unknown selector. */

	auxVersion = 0;
	err = Gestalt(gestaltAUXVersion, &auxVersion);

	/* If gestaltUnknownErr or gestaltUndefSelectorErr was returned, then either
	** we weren't running on A/UX, or the _Gestalt trap is unavailable so use
	** HWCfgFlags instead.
	** All other errors are ignored (implies A/UX not present). */

	if (err == gestaltUnknownErr || err == gestaltUndefSelectorErr) {	/* Use HWCfgFlags */
		flagPtr = (short *) HWCfgFlags;
		if (BTstQ(*flagPtr, 9))
			auxVersion = 0x100;			/* Do Have A/UX, so assume version 1.x.x */
	}

	/* Now right shift auxVersion by 8 bits to get major version number. */

	auxVersion >>= 8;
	return((short)auxVersion);
}



/*****************************************************************************/



#pragma segment UtilMain
OSErr	SimpleCanDialog(void)
{
	OSErr				err;
	ProcessSerialNumber	cpsn, fpsn;
	Boolean				procsSame;

	err = noErr;
	if (gSystemVersion >= 0x0700) {
		err = AEInteractWithUser(kAEDefaultTimeout, nil, nil);
			/* Ask the AppleEvent Manager if we can come forward */
		GetCurrentProcess(&cpsn);		/* We may have been moved to the front. */
		GetFrontProcess(&fpsn);
		SameProcess(&cpsn, &fpsn, &procsSame);
		gInBackground = !procsSame;
	}

/* Three results are possible here....
**   noErr
**     If the call completes with noErr, you can assume that you are
**     (or have been made) the frontmost application, and you are free
**     to interact with the user as much as you'd like.  Put up dialogs,
**     flash alerts, whatever.
**     If you were already in the foreground, AEInteractWithUser
**     immediatly returns with a noErr, so you _should_ always call it.
**
**   errAETimeout
**     If you pass a timeout value, or kAEDefaultTimeout, it is possible
**     for the AEInteractWithUser call to timeout and return control to
**     you before any state change has happened, you are still in the background.
**     What you do at this point is a design decision you'll have to make.
**     You can re-post the AEInteract call, perhaps with a larger timeout
**     or kNoTimeOut, and see if you come forward this time.
**     Or, you can continue on knowing that you are in the background and
**     not interact at all.
**
**   errAENoUserInteraction
**     If you get this error code back, this means that you
**     MUST NOT interact with the user.  Do NOT put up any dialogs, alerts,
**     or cause any other action that requires direct user intervention.
**     This error code will be returned, for example, if any application
**     has used the AESetInteractionAllowed call to specify no interaction,
**     or if there is a pending AppleEvent that has interaction denied.
**     This will also be returned if your application is being run by
**     a script system, since an AppleEvent script cannot press buttons.
**     By the way, if this is the case the AEinteractWithUser call has
**     also not posted the notification.
*/

	return(err);
}



/*****************************************************************************/



/* Given a dialog ID and a window pointer the dialog relates to, this function
** will center the dialog’s rectangle before showing it on the proper screen.
** This follows the Apple Human Interface Guidelines for where to place a
** centered window on the screen.  If the dialog is not closely associated with
** another window, pass a nil for the window pointer of the related window.  If
** you pass a nil, the dialog is simply displayed where the resource
** would indicate. */

#pragma segment UtilMain
DialogPtr	GetCenteredDialog(short id, DialogPtr storage, WindowPtr relatedWindow, WindowPtr behind)
{
	DialogTHndl	dlogResource;
	DialogPtr	dialog;
	Boolean		oldVis;
	char		hstate;
	OSErr		err;
	Rect		sizeInfo;

	dialog = nil;
	if (!SimpleCanDialog()) {
		if (dlogResource = (DialogTHndl)GetAppResource('DLOG', id, &err)) {
			hstate = LockHandleHigh((Handle)dlogResource);
			oldVis = (*dlogResource)->visible;
			(*dlogResource)->visible = false;
			if (dialog = GetNewDialog(id, storage, behind)) {
				SetRect(&sizeInfo, 0, 0, 0, 0);
				CenterWindow(dialog, relatedWindow, sizeInfo);
				if (oldVis)
					ShowWindow(dialog);
			}
			if (dlogResource = (DialogTHndl)GetAppResource('DLOG', id, &err)) {
				(*dlogResource)->visible = oldVis;
				HSetState((Handle)dlogResource, hstate);
			}
		}
	}
	return(dialog);
}



/*****************************************************************************/



/* Given a window ID and a window pointer the window relates to, this function
** will center the window’s rectangle before showing it on the proper screen.
** This follows the Apple Human Interface Guidelines for where to place a
** centered window on the screen.  If the window is not closely associated with
** another window, pass a nil for the window pointer of the related window.  If
** you pass a nil, the window is simply displayed where the resource
** would indicate. */

#pragma segment UtilMain
WindowPtr	GetCenteredWindow(short id, Ptr storage, Boolean vis, WindowPtr relWindow,
							  WindowPtr behind, Boolean inColor, Rect sizeInfo, long refCon)
{
	return(GetSomeKindOfWindow(CenterWindow, id, storage, vis, relWindow,
							   behind, inColor, sizeInfo, refCon));
}



/*****************************************************************************/



/* GetGestaltResult returns the result value from Gestalt for the specified
** selector.  If Gestalt returned an error GetGestaltResult returns zero.
** Use of this function is only cool if we don't care whether Gestalt returned
** an error.  In many cases you may need to know the exact Gestalt error code
** so then this function would be inappropriate.
** See GetAUXVersion for an example. */

#pragma segment UtilMain
long	GetGestaltResult(OSType gestaltSelector)
{
	long	gestaltResult;

	if (Gestalt(gestaltSelector, &gestaltResult) == noErr)
		return(gestaltResult);
	else
		return(0);
}



/*****************************************************************************/



/* Get the global coordinates of the mouse. */

#pragma segment UtilMain
Point	GetGlobalMouse(void)
{
	WindowPtr	oldPort, wmPort;
	Point		pt;

	GetPort(&oldPort);
	GetWMgrPort(&wmPort);
	SetPort(wmPort);
	GetMouse(&pt);
	LocalToGlobal(&pt);
	SetPort(oldPort);
	return(pt);
}



/*****************************************************************************/



/* Given a window, this will return the top left point of the window’s port in
** global coordinates.  Something this doesn’t include is the window’s drag
** region (or title bar).  This returns the top left point of the window’s
** content area only. */

#pragma segment UtilMain
Point	GetGlobalTopLeft(WindowPtr window)
{
	GrafPtr	oldPort;
	Point	globalPt;

	GetPort(&oldPort);
	SetPort(window);
	globalPt = TopLeft(window->portRect);
	LocalToGlobal(&globalPt);
	SetPort(oldPort);
	return(globalPt);
}



/*****************************************************************************/



/* Return the amount of free space on the volume in KBytes. -1 is returned as
** the size if there is an error. */

#pragma segment UtilMain
long	GetKFreeSpace(short vRefNum)
{
	HParamBlockRec	pb;
	OSErr			err;

	pb.volumeParam.ioNamePtr = nil;			/* we don't care about the name */
	pb.volumeParam.ioVRefNum = vRefNum;
	pb.volumeParam.ioVolIndex = 0;			/* use ioVRefNum only */
	err = PBHGetVInfo(&pb, false);

	if (err == noErr)
		return((pb.volumeParam.ioVFrBlk * pb.volumeParam.ioVAlBlkSiz) / 1024);
	else
		return(-1);
}



/*****************************************************************************/



#pragma segment UtilMain
Rect	GetMainScreenRect(void)
{
	GDHandle	mainDevice;
	GrafPtr		mainPort;

	if (gQDVersion > kQDOriginal) {
		mainDevice = GetMainDevice();
		return((*mainDevice)->gdRect);
	}
	else {
		GetWMgrPort(&mainPort);
		return(mainPort->portRect);
	}
}



/*****************************************************************************/



/* Find the greatest overlap device for the given global rectangle. */

#pragma segment UtilMain
GDHandle	GetRectDevice(Rect globalRect)
{
	long		area, maxArea;
	GDHandle	device, deviceToReturn;
	Rect		intersection;

	deviceToReturn = GetMainDevice();			/* Use as default choice. */
	maxArea = 0;

	for (device = GetDeviceList(); device; device = GetNextDevice(device)) {
		if (TestDeviceAttribute(device, screenDevice)
		  && TestDeviceAttribute(device, screenActive)
		  && SectRect(&globalRect, &((*device)->gdRect), &intersection)) {
			area = ((long)(intersection.right - intersection.left)) *
				   ((long)(intersection.bottom - intersection.top));
			if (area > maxArea) {
				deviceToReturn = device;
				maxArea = area;
			}
		}
	}
	return(deviceToReturn);
}



/*****************************************************************************/



/* Find the rect of the greatest overlap device for the given global rect. */

#pragma segment UtilMain
Rect	GetRectDeviceRect(Rect globalRect)
{
	if (gQDVersion > kQDOriginal)
		return((*GetRectDevice(globalRect))->gdRect);
	else
		return(GetMainScreenRect());
}



/*****************************************************************************/



/* Given a window positioning procedure pointer, a window ID and a window
** pointer the window relates to, this function open a new window by either
** a NewCWindow or a NewWindow call, depending on the value of inColor.  The
** window will be opened invisible, independent of what the resource says.
** Once the window is opened successfully, the positioning procedure is
** called.  The positioning procedure is passed a pointer to the just-opened
** invisible window and a pointer to the related window.  It is up to the
** positioning procedure to move the invisible window to the correct location
** on the correct device.  Once the positioning procedure returns, the window
** will be made visible if so indicated by the resource. */

#pragma segment UtilMain
WindowPtr	GetSomeKindOfWindow(PositionWndProcPtr whatKind, short windID, Ptr storage,
								Boolean vis, WindowPtr relatedWindow, WindowPtr behind,
								Boolean inColor, Rect sizeInfo, long refCon)
{
	WindowTHndl		windowResource;
	WindowTemplate	wt;
	WindowPtr		window;
	PaletteHandle	wpalette;
	Ptr				allocStg;
	OSErr			err;

	gGetWindowErr = noErr;

	window = nil;		/* Assume we will fail.  (Good attitude.) */
	SetRect(&gOpenedWindowTemplate.boundsRect, 0, 0, 0, 0);

	if (gQDVersion == kQDOriginal)
		inColor = false;

	if (!(allocStg = storage))
		if (!(allocStg = NewPtr(sizeof(WindowRecord))))
			gGetWindowErr = memFullErr;

	if (allocStg) {			/* If we have memory for the window record... */

		wt = gWindowTemplate;
		if (EmptyRect(&wt.boundsRect)) {
			if (windowResource = (WindowTHndl)GetAppResource('WIND', windID, &err))
				wt = **windowResource;		/* Make local copy of resource. */
			else
				gGetWindowErr = resNotFound;
		}

		if (!EmptyRect(&wt.boundsRect)) {
			window = (inColor ? NewCWindow(allocStg, &wt.boundsRect,
										   wt.title, false, wt.procID,
										   behind, wt.goAwayFlag, wt.refCon)
							   : NewWindow(allocStg, &wt.boundsRect, wt.title,
										   false, wt.procID,
										   behind, wt.goAwayFlag, wt.refCon));
				/* Open either a regular or color window. */

			if (window) {		/* If we were able to open a window... */
				if (inColor)
					if (wpalette = GetNewPalette(windID))
						SetPalette(window, wpalette, true);

				SetWRefCon(window, refCon);
				if (whatKind)
					(*whatKind)(window, relatedWindow, sizeInfo);
						/* Call the designated window positioning procedure. */

				if (vis)
					ShowWindow(window);
						/* If caller says window should be visible, make it so. */
			}
		}
		if (!window) {
			if (allocStg != storage)
				DisposPtr(storage);
		}			/* If we failed, then get rid of window record memory. */
		else
			gOpenedWindowTemplate = wt;
	}

	return(window);
}



/*****************************************************************************/



/* Given a window ID and a window pointer the window relates to, this function
** will stagger the window’s rectangle before showing it on the proper screen.
** This follows the Apple Human Interface Guidelines for where to place a
** staggered window on the screen.  If the window is not closely associated
** with another window, pass a nil for the window pointer of the related
** window.  If you pass a nil, the window is simply displayed where the
** resource would indicate. */

#pragma segment UtilMain
WindowPtr	GetStaggeredWindow(short id, Ptr storage, Boolean vis, WindowPtr relWindow,
							   WindowPtr behind, Boolean inColor, Rect sizeInfo, long refCon)
{
	return(GetSomeKindOfWindow(StaggerWindow, id, storage, vis, relWindow,
							   behind, inColor, sizeInfo, refCon));
}



/*****************************************************************************/



/*	Check the bits of a trap number to determine its type. */

#pragma segment UtilMain
TrapType	GetTrapType(short theTrap)
{
	/* OS traps start with A0, Tool with A8 or AA. */
	if ((theTrap & 0x0800) == 0)					/* per D.A. */
		return(OSTrap);
	else
		return(ToolTrap);
}



/*****************************************************************************/



/* Given a window pointer, return the global rectangle that encloses the
** content area of the window. */

#pragma segment UtilMain
Rect	GetWindowContentRect(WindowPtr window)
{
	WindowPtr	oldPort;
	Rect		contentRect;

	SetRect(&contentRect, 0, 0, 0, 0);
	if (window) {
		GetPort(&oldPort);
		SetPort(window);
		contentRect = window->portRect;
		LocalToGlobalRect(&contentRect);
		SetPort(oldPort);
	}

	return(contentRect);
}



/*****************************************************************************/



/* This procedure counts the number of windows in the application plane.
** You have the choices of also including DAs and invisible windows in
** this count. */

#pragma segment UtilMain
short	GetWindowCount(Boolean includeDAs, Boolean includeDLOGs, Boolean includeInvisibles)
{
	WindowPeek	window;
	short		count;

	for (count = 0, window = LMGetWindowList(); (window != nil); window = window->nextWindow) {
		if ((window->windowKind < 0) && (!includeDAs)) continue;
		if ((window->windowKind < userKind) && (!includeDLOGs)) continue;
		if ((window->visible) || (includeInvisibles))
			count++;
	}
	return(count);
}



/*****************************************************************************/



/* Find the greatest overlap device for the given window. */

#pragma segment UtilMain
GDHandle	GetWindowDevice(WindowPtr window)
{
	return(GetRectDevice(GetWindowStructureRect(window)));
}



/*****************************************************************************/



/* Given a window pointer, find the device that contains most of the window
** and return the device's bounding rectangle. */

#pragma segment UtilMain
Rect	GetWindowDeviceRect(WindowPtr window)
{
	if (gQDVersion > kQDOriginal)
		return((*GetWindowDevice(window))->gdRect);
	else
		return(GetMainScreenRect());
}



/*****************************************************************************/



/* Given a window pointer, find the device that contains most of the window
** and return the device's bounding rectangle.  If this device is the main
** device, then remove the menubar area from the rectangle. */

#pragma segment UtilMain
Rect	GetWindowDeviceRectNMB(WindowPtr window)
{
	Rect	deviceRect, tempRect;

	SetRect(&deviceRect, 0, 0, 0, 0);

	if (window) {
		deviceRect = GetWindowDeviceRect(window);
		tempRect = GetMainScreenRect();
		if (EqualRect(&deviceRect, &tempRect))
			deviceRect.top += GetMBarHeight();
	}

	return(deviceRect);
}



/*****************************************************************************/



/* This procedure is used to get the rectangle that surrounds the entire
** structure of a window.  This is true whether or not the window is visible.
** If the window is visible, then it is a simple matter of using the bounding
** rectangle of the structure region.  If the window is invisible, then the
** strucRgn is not correct.  To make it correct, then window has to be moved
** way off the screen and then made visible.  This generates a valid strucRgn,
** although it is valid for the position that is way off the screen.  It still
** needs to be offset back into the original position.  Once the bounding
** rectangle for the strucRgn is obtained, the window can then be hidden again
** and moved back to its correct location.  Note that ShowHide is used,
** instead of ShowWindow and HideWindow.  HideWindow can change the plane of
** the window.  Also, ShowHide does not affect the hiliting of windows.
** Note that using ShowHide to make the window visible has the unfortunate
** side-effect of changing the userState rect.  Since we make the window
** invisible prior to moving it back, userState gets left funky.  Due to this,
** we have to cache it prior to doing the ShowHide games. */

#pragma segment UtilMain
Rect	GetWindowStructureRect(WindowPtr window)
{
#define kOffscreenLoc 0x4000

	GrafPtr	oldPort;
	Rect	structureRect, userState;
	Point	windowLoc;

	SetRect(&structureRect, 0, 0, 0, 0);

	if (window) {

		if (((WindowPeek)window)->visible)
			structureRect = (*(((WindowPeek)window)->strucRgn))->rgnBBox;

		else {
			GetPort(&oldPort);
			SetPort(window);
			windowLoc  = GetGlobalTopLeft(window);
			if (((WindowPeek)window)->spareFlag)
				userState = (*(WStateDataHandle)(((WindowPeek)window)->dataHandle))->userState;
			MoveWindow(window, kOffscreenLoc, kOffscreenLoc, false);
			ShowHide(window, true);
			structureRect = (*(((WindowPeek)window)->strucRgn))->rgnBBox;
			ShowHide(window, false);
			MoveWindow(window, windowLoc.h, windowLoc.v, false);
			if (((WindowPeek)window)->spareFlag)
				(*(WStateDataHandle)(((WindowPeek)window)->dataHandle))->userState = userState;
			SetPort(oldPort);
			OffsetRect(&structureRect, windowLoc.h - kOffscreenLoc, windowLoc.v - kOffscreenLoc);
		}
	}

	return(structureRect);
}



/*****************************************************************************/



#pragma segment UtilMain
void	GlobalToLocalRect(Rect *aRect)
{
	GlobalToLocal(&TopLeft(*aRect));
	GlobalToLocal(&BotRight(*aRect));
}



/*****************************************************************************/



#pragma segment UtilMain
void	InitToolBox(void)
{
	InitGraf((Ptr) &QD(thePort));
	InitFonts();
	InitWindows();
	InitMenus();
	TEInit();
	InitDialogs(nil);
	InitCursor();
}



/*****************************************************************************/



/* GetSystemInfo sets up some global variables for use by the utilities
** package and your application.  If you call StandardInitialization, you
** don't need to call this, as it will do it for you. */

#pragma segment UtilMain
void	GetSystemInfo(void)
{
	Handle			apParam;
	Handle			bndlResource;
	OSErr			err;
	short			ignoreRefNum;

	if (!gHaveSystemInfo) {

		/* Init all the Gestalt variables */
		gMachineType   = GetGestaltResult(gestaltMachineType);
		gSystemVersion = GetGestaltResult(gestaltSystemVersion);
		gProcessorType = GetGestaltResult(gestaltProcessorType);

		/* We only concern ourselves with there being an FPU, not which type it is. */
		gHasFPU = (GetGestaltResult(gestaltFPUType) != gestaltNoFPU);

		/* We only concern ourselves with the major QD version number
		** 0 for original QD, 1 for 8-bit color QD, and 2 for 32-bit QD. */

		gQDVersion = (GetGestaltResult(gestaltQuickdrawVersion) >> 8) & 0xFF;
		gKeyboardType = GetGestaltResult(gestaltKeyboardType);

		if (!OpenDriver("\p.MPP", &ignoreRefNum))
			gAppleTalkVersion = GetGestaltResult(gestaltAppleTalkVersion);
				/* Under system 6, the driver isn't necessarily open, so open it for sure.
				** If the driver isn't opened, then the gestalt selector isn't installed,
				** and therefore returns 0, which isn't really the case. */

		/* We only concern ourselves with there being an PMMU, not which type it is. */
		gHasPMMU = GetGestaltResult(gestaltMMUType) >= gestalt68851;
		gAUXVersion = GetAUXVersion();

		gHasWaitNextEvent = TrapExists(_WaitNextEvent);
		gInBackground = false;

		/* 
		 * PowerPC doesn't support GetAppParms for native code (use AppleEvents!!!), so we find 
		 * the information in other ways. 
		 */
#ifdef powerc
		{
			ProcessSerialNumber		currentPSN;
			ProcessInfoRec			currentProcRec;
			
			/* It's safe to assume we have a Process Manager on PowerPC */
			GetCurrentProcess (&currentPSN);
			currentProcRec.processInfoLength = sizeof (currentProcRec);
			currentProcRec.processName = gAppName;
			currentProcRec.processAppSpec = nil;
			GetProcessInformation (&currentPSN, &currentProcRec);
			gAppResRef = CurResFile();			/* This is lazy and assumes no one has mucked with the resource chain */
		}
#else
		GetAppParms(gAppName, &gAppResRef, &apParam);
#endif
#ifdef THINK_C
		gAppResRef = CurResFile();			/* returns refNum of .rsrc file */
			/* 10/16/90 pvh/MacDTS
			** With GetAppParams(), THINK C in project mode returns the project resource
			** file AND NOT the .rsrc file, which is what one really wants (trust me).
			** If THINK is present we will return CurResFile() which will be the .rsrc
			** file instead.  The name will still be the project name in project mode,
			** so be aware of that. */
#endif

		bndlResource = GetAppIndResource('BNDL', 1, &err);
		if (bndlResource)
			gSignature = *(OSType *)(*bndlResource);

		gHaveSystemInfo = true;
	}
}



/*****************************************************************************/



/* Check to see if a window belongs to the application.  If the window pointer
** passed was nil, then it could not be an application window.  WindowKinds
** that are negative belong to the system and windowKinds less than userKind
** are reserved by Apple except for windowKinds equal to dialogKind, which
** mean it is a dialog. */

#pragma segment UtilMain
Boolean	IsAppWindow(WindowPtr window)
{
	if (window) return(((WindowPeek)window)->windowKind >= userKind);
	else		return(false);
}



/*****************************************************************************/



/* Check to see if a window belongs to a desk accessory. */

#pragma segment UtilMain
Boolean	IsDAWindow(WindowPtr window)
{
	if (window)	/* DA windows have negative windowKinds */
		return(((WindowPeek) window)->windowKind < 0);
	else
		return(false);
}



/*****************************************************************************/



#pragma segment UtilMain
void	LocalToGlobalRect(Rect *aRect)
{
	LocalToGlobal(&TopLeft(*aRect));
	LocalToGlobal(&BotRight(*aRect));
}



/*****************************************************************************/



#pragma segment UtilMain
char	LockHandleHigh(Handle theHandle)
{
	char	hstate;

	hstate = HGetState(theHandle);
	MoveHHi(theHandle);
	HLock(theHandle);
	return(hstate);
}



/*****************************************************************************/



/* InitGraf is always implemented (trap $A86E).  If the trap table is big
** enough, trap $AA6E will always point to either Unimplemented or some other
** trap, but will never be the same as InitGraf.  Thus, you can check the size
** of the trap table by asking if the address of trap $A86E is the same as
** $AA6E. */

#pragma segment UtilMain
short	NumToolboxTraps(void)
{
	if (NGetTrapAddress(_InitGraf, ToolTrap) == NGetTrapAddress(0xAA6E, ToolTrap))
		return(0x200);
	else
		return(0x400);
}



/*****************************************************************************/



/* Given two rectangles, this function positions the second within the first
** one so that it maintains the spacing specified by the horzRatio and
** vertRatio parameters.  In other words, to center an inner rectangle
** hoizontally, but have its center be 1/3 from the top of the outer rectangle,
** call this function with horzRatio = FixRatio(1, 2), vertRatio =
** FixRatio(1, 3).  We use Fixed rather than floating point to avoid
** complications when mixing MC68881/non-MC68881 versions of Utilities. */

#pragma segment UtilMain
void	PositionRectInRect(Rect outerRect, Rect *innerRect, Fixed horzRatio, Fixed vertRatio)
{
	short	outerRectHeight;
	short	outerRectWidth;
	short	innerRectHeight;
	short	innerRectWidth;
	short	yLocation;
	short	xLocation;

	outerRectHeight = outerRect.bottom - outerRect.top;
	outerRectWidth = outerRect.right - outerRect.left;

	innerRectHeight = innerRect->bottom - innerRect->top;
	innerRectWidth = innerRect->right - innerRect->left;
		yLocation = Fix2Long(FixMul(Long2Fix(outerRectHeight - innerRectHeight), vertRatio))
			+ outerRect.top;
		xLocation = Fix2Long(FixMul(Long2Fix(outerRectWidth - innerRectWidth), horzRatio))
			+ outerRect.left;

	innerRect->top = yLocation;
	innerRect->left = xLocation;
	innerRect->bottom = yLocation + innerRectHeight;
	innerRect->right = xLocation + innerRectWidth;
}



/*****************************************************************************/



#pragma segment UtilMain
void	PullApplicationToFront(void)
{
#define kBroughtToFront 3

	EventRecord event;
	short		count;

	for (count = 1; count <= kBroughtToFront; count++)
		EventAvail(everyEvent, &event);
}



/*****************************************************************************/



/* This algorithm for staggering windows does quite a good job.  It also is
** quite gnarly.  Here's the deal:
** There are pre-designated positions that we will try when positioning a
** window.  These slots will be tried from the upper-left corner towards the
** lower-right corner.  If there are other windows in that slot, then we will
** consider that slot taken, and proceed to the next slot.  A slot is
** determined to be taken by checking a point with a slop area.  This slop
** area is diamond-shaped, not simply rectangular.  If there is no other
** visible window with an upper-left corner within the slopt diamond, then
** we are allowed to position our window there.
** The above rule holds true unless this forces the window to be partly
** off the screen.  If the window ends up partly off the screen, then we try
** a new diagonal just below the first diagonal we tried.  We keep trying
** lower and lower diagonals until we find a spot for the window, or the
** diagonal doesn't fit on the screen at all.  If the diagonal doesn't fit,
** then we try diagonals to the right of the first diagonal.  If even this
** doesn't work, then we give up and put the window in the original spot
** we tried. */

#pragma segment UtilMain
Rect	StaggerWindow(WindowPtr window, WindowPtr relatedWindow, Rect sizeInfo)
{
	WindowPtr	whichDevice, staggerFromWindow;
	Rect		deviceRect, oldWindowRect, newWindowRect, slot1;
	Rect		testRct1, testRct2, contentRect, staggerFromRect;
	Point		delta, absdelta;
	Boolean		contained, vertTry;
	short		diamondSize, diagNum, tryNum, h, v, hh, vv;

	if (!(whichDevice = relatedWindow))
		whichDevice = window;
			/* If we have a window to stagger from, use the device for that window,
			** else use the device for the window that is getting staggered. */

	deviceRect = GetWindowDeviceRectNMB(whichDevice);
		/* We now have the rect of the device we want to stagger within. */

	if (!EmptyRect(&gWindowPlacementRect))
		deviceRect = gWindowPlacementRect;

	contentRect = GetWindowContentRect(window);		/* Get where the window is now. */
	h = hh = contentRect.right  - contentRect.left;
	v = vv = contentRect.bottom - contentRect.top;
	if (sizeInfo.left)
		if (h < sizeInfo.left)
			h = sizeInfo.left;
	if (sizeInfo.right)
		if (h > sizeInfo.right)
			h = sizeInfo.right;
	if (sizeInfo.top)
		if (v < sizeInfo.top)
			v = sizeInfo.top;
	if (sizeInfo.bottom)
		if (v > sizeInfo.bottom)
			v = sizeInfo.bottom;
	contentRect.right  = contentRect.left + h;
	contentRect.bottom = contentRect.top  + v;

	oldWindowRect = GetWindowStructureRect(window);

	newWindowRect.top    = deviceRect.top  + kStartPtV;
	newWindowRect.left   = deviceRect.left + kStartPtH;
	newWindowRect.bottom = newWindowRect.top  + oldWindowRect.bottom - oldWindowRect.top;
	newWindowRect.right  = newWindowRect.left + oldWindowRect.right  - oldWindowRect.left;
	newWindowRect.right  += (h - hh);
	newWindowRect.bottom += (v - vv);
		/* We now have a new rect for the first window position slot. */

	slot1 = newWindowRect;
		/* We keep this slot in case we find no acceptable slots.  If we
		** don't find an acceptable one, we will use this one anyway. */

	diamondSize = (kStaggerH < kStaggerV) ? kStaggerH : kStaggerV;
	for (diagNum = 0, vertTry = true;;) {
		for (tryNum = 0;; ++tryNum) {

			SectRect(&newWindowRect, &deviceRect, &testRct1);
			if (!(contained = EqualRect(&newWindowRect, &testRct1))) break;
				/* Break if the slot we are testing went off the device. */

			for (staggerFromWindow = FrontWindow(); staggerFromWindow;
				 staggerFromWindow = (WindowPtr)((WindowPeek)staggerFromWindow)->nextWindow) {
				if (!((WindowPeek)staggerFromWindow)->visible) continue;
					/* This window is invisible.  Staggering from an invisible
					** window is going to confuse the user, so don't do it. */

				testRct1 = GetWindowDeviceRect(staggerFromWindow);
				testRct2 = GetRectDeviceRect(deviceRect);
				if (!EqualRect(&testRct1, &testRct2)) continue;
					/* This window doesn't belong to the device we are trying to
					** stagger on, so skip it and go to the next window. */

				staggerFromRect = GetWindowStructureRect(staggerFromWindow);
				delta.v = staggerFromRect.top  - newWindowRect.top;
				delta.h = staggerFromRect.left - newWindowRect.left;
				if ((absdelta.v = delta.v) < 0)
					absdelta.v = -delta.v;
				if ((absdelta.h = delta.h) < 0)
					absdelta.h = -delta.h;
				if ((absdelta.h + absdelta.v) < diamondSize) {
					if ((delta.h + delta.v) > 0)
						OffsetRect(&newWindowRect, delta.h, delta.v);
							/* If the window that took our slot is closer to
							** the lower-right corner than we are, then use
							** this window's location as the basis for the
							** slots from now on.  This will align new windows
							** with previous windows that are not gridded to
							** the default slot positions.  The check for > 0
							** is necessary to prevent bouncing between two
							** existing windows.  This check guarantees that
							** we are progressing with the evaluation. */
					break;
						/* Break because this slot is already used. */
				}
			}

			if (!staggerFromWindow) break;
				/* If the window pointer is nil, then we tried all the windows
				** and none of them occupied this slot.  This means that the
				** slot is available for the new window. */

				OffsetRect(&newWindowRect, kStaggerH, kStaggerV);
				/* Since this slot was taken, try the next slot and go through
				** the window list again. */
		}

		if (contained) break;
		newWindowRect = slot1;
		if (!tryNum) {
			if (!vertTry) break;		/* Nothing works.  No spots at all. */
			vertTry = false;			/* Try across for the next pass. */
			diagNum = 0;
		}
		++diagNum;
		if (vertTry)
			OffsetRect(&newWindowRect, 0, diagNum * kStaggerV);
		else
			OffsetRect(&newWindowRect, diagNum * kStaggerH, 0);
	}

	OffsetRect(&contentRect, newWindowRect.left - oldWindowRect.left,
							newWindowRect.top  - oldWindowRect.top);
		/* Calculate the new content rect. */

	MoveWindow(window, contentRect.left, contentRect.top, false);
		/* Move the window to the new location. */

	oldWindowRect = newWindowRect;

	if (newWindowRect.right > (deviceRect.right - 2))
		newWindowRect.right = (deviceRect.right - 2);

	if (newWindowRect.bottom > (deviceRect.bottom - 2))
		newWindowRect.bottom = (deviceRect.bottom - 2);

	h = newWindowRect.right  - oldWindowRect.right;
	v = newWindowRect.bottom - oldWindowRect.bottom;

	SizeWindow(window, contentRect.right  - contentRect.left + h,
					   contentRect.bottom - contentRect.top + v, false);
		/* The window may have also changed size, due to sizeInfo or not fitting on the screen. */


	return(contentRect);
}



/*****************************************************************************/



#pragma segment UtilMain
void	StandardAbout(short appNameStringID)
{
	StringHandle	apNameHndl;
	VersRecHndl		curVersion;
	Str255			apName;
	Str255			verNum = "\p????";
	Ptr				verNumLocation;
	OSErr			err;

	apNameHndl = (StringHandle)nil;
	if (appNameStringID != kUseRealAppName) {
		if (appNameStringID != kUseCreatorString)
			apNameHndl = GetString(appNameStringID);
		if (!apNameHndl)
			apNameHndl = (StringHandle)GetAppResource(gSignature, 0, &err);
	}

	if ((!apNameHndl) || (appNameStringID == kUseRealAppName))
		pcpy(apName, gAppName);
	else
		pcpy(apName, *apNameHndl);

	curVersion = (VersRecHndl) GetAppResource('vers', 1, &err);
	if (curVersion) {
		verNumLocation = (Ptr)((long)(*curVersion)->shortVersion +
						 (long)*(*curVersion)->shortVersion + 1);
		pcpy(verNum, (StringPtr)verNumLocation);
	}

	ParamText(apName, verNum, "\p", "\p");

	CenteredAlert(rStdAboutAlert, nil, nil);
}



/*****************************************************************************/



#pragma segment UtilMain
void	StandardInitialization(short callsToMoreMasters)
{
	InitToolBox();

	while (callsToMoreMasters--) MoreMasters();

	PullApplicationToFront();
	GetSystemInfo();
}



/*****************************************************************************/



#pragma segment UtilMain
void	StandardMenuSetup(short mbarID, short appleMenuID)
{
	Handle	mbar;
	short	i, id;

	mbar = GetNewMBar(mbarID);						/* Read menus into menu bar. */
	if (!mbar) return;								/* Maybe we're faceless, so we're done. */

	SetMenuBar(mbar);								/* Install menus. */
	DisposHandle(mbar);
	AddResMenu(GetMHandle(appleMenuID), 'DRVR');	/* Add DA names to Apple menu. */

	mbar = GetResource('MBAR', mbarID);
	for (i = **(short **)mbar; i; --i) {
		mbar = GetResource('MBAR', mbarID);			/* Make sure it's in memory for dereference. */
		id   = (*(short **)mbar)[i];
		InsertHierMenus(GetMHandle(id));
	}

	DrawMenuBar();
}



/*****************************************************************************/



#pragma segment UtilMain
void	InsertHierMenus(MenuHandle menu)
{
	short		item, cmd, mark;
	MenuHandle	hier;

	for (item = CountMItems(menu); item; --item) {
		GetItemCmd(menu, item, &cmd);
		if (cmd == 0x1B) {
			GetItemMark(menu, item, &mark);
			if (hier = GetMenu(mark)) {
				InsertMenu(hier, -1);
				InsertHierMenus(hier);
			}
		}
	}
}



/*****************************************************************************/



/* Check to see if a given trap is implemented. */

#pragma segment UtilMain
Boolean TrapExists(short theTrap)
{
	TrapType	theTrapType;

	theTrapType = GetTrapType(theTrap);
	if ((theTrapType == ToolTrap) && ((theTrap &= 0x07FF) >= NumToolboxTraps()))
		theTrap = _Unimplemented;

	return(NGetTrapAddress(_Unimplemented, ToolTrap) != NGetTrapAddress(theTrap, theTrapType));
}



/*****************************************************************************/



/* Zoom the window to the size appropriate for the device that contains the
** most of the window.  An additional feature is that you can state the
** maximum that a window should be zoomed, either horizontally or vertically.
** If you pass in a maximum of 0 for the zoom for either direction, then that
** direction will be zoomed to fit the device. */

#pragma segment UtilMain
void	ZoomToWindowDevice(WindowPtr window, short maxWidth, short maxHeight,
						   short zoomDir, Boolean front)
{
 	GrafPtr	oldPort;
	Rect	contentRect, structureRect, deviceRect, newRect;
	short	width, height, dx, dy;

	GetPort(&oldPort);
	SetPort(window);
	EraseRect(&window->portRect); 		/* Recommended for cosmetic reasons. */

	/* If there is the possibility of multiple gDevices, then we must check them to
	** make sure we are zooming onto the right display device when zooming out. */

	if (zoomDir == inZoomOut) {

		contentRect	  = GetWindowContentRect(window);
		structureRect = GetWindowStructureRect(window);
		deviceRect	  = GetWindowDeviceRectNMB(window);

		deviceRect.left   += (contentRect.left - structureRect.left + 2);
		deviceRect.top    += (contentRect.top - structureRect.top + 2);
		deviceRect.right  -= (structureRect.right - contentRect.right + 1);
		deviceRect.bottom -= (structureRect.bottom - contentRect.bottom + 1);
		newRect = deviceRect;

		if (maxWidth)
			if ((width = deviceRect.right - deviceRect.left) > maxWidth)
				newRect.right = (newRect.left = contentRect.left) + maxWidth;
		if (maxHeight)
			if ((height = deviceRect.bottom - deviceRect.top) > maxHeight)
				newRect.bottom = (newRect.top = contentRect.top) + maxHeight;
		if ((dx = deviceRect.left - newRect.left) < 0)
			if ((dx = deviceRect.right - newRect.right) > 0)
				dx = 0;
		if ((dy = deviceRect.top - newRect.top) < 0)
			if ((dy = deviceRect.bottom - newRect.bottom) > 0)
				dy = 0;
		OffsetRect(&newRect, dx, dy);

		(*(WStateDataHandle)(((WindowPeek)window)->dataHandle))->stdState = newRect;
			/* Set up the WStateData record for this window. */
	}

	ZoomWindow(window, zoomDir, front);
	SetPort(oldPort);
}



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



#pragma segment UtilMain
void	DoDrawGrowIcon(WindowPtr window, Boolean horLine, Boolean verLine)
{
	WindowPtr	oldPort;
	Rect		rct;
	RgnHandle	oldClip, newClip;

	GetPort(&oldPort);
	SetPort(window);

	rct = window->portRect;
	rct.left = rct.right  - 15;
	rct.top  = rct.bottom - 15;

	if (!((WindowPeek)window)->hilited) {
		FrameRect(&rct);
		++rct.top;
		++rct.left;
		EraseRect(&rct);
		SetPort(oldPort);
		return;
	}

	oldClip = NewRgn();
	newClip = NewRgn();

	if (horLine)
		rct.left = window->portRect.left;
	if (verLine)
		rct.top  = window->portRect.top;
	RectRgn(newClip, &rct);

	GetClip(oldClip);
	SetClip(newClip);
	DrawGrowIcon(window);		/* Draw grow icon without scrollbar lines. */

	SetClip(oldClip);
	DisposeRgn(oldClip);
	DisposeRgn(newClip);

	SetPort(oldPort);
}



/*****************************************************************************/



/* This is used to "intelligently" insert a menu item into a menu.  Pass it
** the menu to be modified, the text of the item being added, plus where the
** item is to be inserted.  The location to be inserted is described by two
** parameters:  section & where.
**
** section:  Indicates which group of menu items you wish to add an item to.
**           Menu item section 1 is all of the items before the first
**           dividing line.  Menu item section 2 is all items after the
**           first dividing line and before the second, and so on.  If you
**           have no dividing lines, you have just 1 section so pass in 1.
**
** where:    Indicates the item position relative to the section.  To add an
**           item such that it is the first item in a section, pass in a 1.
**           It will be added in front of the first item in the section.
**
**           NOTE:  You should never pass in a section or where parameter of 0.
**
** Negative values for "where" are magic.  If where = kMenuItemTxtInsert, then
** it inserts the item alphabetically into the section.  A where of
** kMenuItemNumInsert works the same as kMenuItemTxtInsert, except it treats
** the strings are numbers for comparison purposes.  If you want to add the
** item to the end of a section, use kMenuItemSectionEnd.
**
** As a final goodie, SmartInsMenuItem returns the menu item # from the
** beginning of the menu, not section.
*/

#pragma segment UtilMain
short	SmartInsMenuItem(MenuHandle theMenu, StringPtr theText, short section, short where)
{
	short	numItems, base, i;
	short	insertType, val;
	Str255	cmpTxt, txt;

	numItems = CountMItems(theMenu);	/* Total number of items in menu. */

	if (--section < 0)
		section = 0;					/* We want section 0-based. */

	for (base = 0, i = 1; (section) && (i <= numItems); ++i) {
		GetItem(theMenu, base + i, txt);
		if (txt[1] == '-') {
			base = i;
			--section;
		}
	}		/* base now tells us our section starting offset. */

	if (where < 0) {		/* If magic mode... */

		InsMenuItem(theMenu, theText, 0);		/* Take out meta characters */
		GetItem(theMenu, 1, cmpTxt);			/* for comparison purposes. */
		DelMenuItem(theMenu, 1);

		insertType = where;
		val = p2num(cmpTxt, 10, nil);

		for (where = 1; i <= (numItems - base); ++where) {
			GetItem(theMenu, where + base, txt);
			if (txt[1] == '-') break;
			if ((insertType == kMenuItemTxtInsert) && ((IUCompString(cmpTxt, txt) < 0))) break;
			if ((insertType == kMenuItemNumInsert) && (val < p2num(txt, 10, nil)))       break;
		}
	}

	where += base;
	InsMenuItem(theMenu, theText, where - 1);		/* InsMenuItem does an insert-after. */

	return(where);
}



/*****************************************************************************/



#pragma segment UtilMain
short	CountMSections(MenuHandle theMenu)
{
	short	numItems, numSections, i;
	Str255	txt;

	numItems = CountMItems(theMenu);	/* Total number of items in menu. */

	for (numSections = i = 1; i <= numItems; ++i) {
		GetItem(theMenu, i, txt);
		if (txt[1] == '-')
			++numSections;
	}

	return(numSections);
}



/*****************************************************************************/



#pragma segment UtilMain
short	FindMenuItem(MenuHandle theMenu, StringPtr cmpTxt)
{
	short	item;
	Str255	txt;

	for (item = CountMItems(theMenu); item; --item) {
		GetItem(theMenu, item, txt);
		if (!IUCompString(cmpTxt, txt)) break;
	}

	return(item);
}



/*****************************************************************************/



#pragma segment UtilMain
OSErr	PersistFSSpec(PFSSpecPtr pfss)
{
	OSErr			err;
	HParamBlockRec	pb;
	char			delim;

	SetMem(&pb, 0, sizeof(HParamBlockRec));		/* Make us a happy ParamBlock. */
	pb.volumeParam.ioNamePtr = pfss->volName;

	if (!(pfss->fss.name[0])) {				/* If no file name, then there's no file. */
		pfss->volName[0] = 0;				/* Zap all remnants of file specification. */
		pfss->fss.vRefNum = 0;
		return(noErr);
	}

	if (pb.volumeParam.ioVRefNum = pfss->fss.vRefNum) {
		pfss->volName[0] = 0;	/* If we are passed in a vRefNum, then we are
								** wanting the volume name.  This is what we are
								** looking to get, so show it as currently missing. */
		err = PBHGetVInfo(&pb, false);
	}
	else {
		if (!(pfss->volName[0])) return(noErr);

		pb.volumeParam.ioVolIndex = -1;		/* Use the name to find the vRefNum. */
		delim = (gAUXVersion) ? '/' : ':';
		if (pfss->volName[pfss->volName[0]] != delim)
			pfss->volName[++(pfss->volName[0])] = delim;
				/* Make sure that volume name ends with a delimiter. */

		if (!(err = PBHGetVInfo(&pb, false)))
			pfss->fss.vRefNum = pb.volumeParam.ioVRefNum;
	}

	return(err);
}



/*****************************************************************************/



#pragma segment UtilMain
StringPtr	PathNameFromDirID(long dirID, short vRefNum, StringPtr str)
{
	CInfoPBRec	block;
	Str255		directoryName;

	*str = 0;
	block.dirInfo.ioNamePtr = directoryName;
	block.dirInfo.ioDrParID = dirID;

	do {
		block.dirInfo.ioVRefNum   = vRefNum;
		block.dirInfo.ioFDirIndex = -1;
		block.dirInfo.ioDrDirID   = block.dirInfo.ioDrParID;

		if (PBGetCatInfo(&block, false)) {
			*str = 0;
			break;
		}

		if (gAUXVersion) {
			if (directoryName[1] != '/')
				pcat(directoryName, "\p/");
					/* If this isn't root (i.e. '/'), append a slash ('/'). */
		} else pcat(directoryName, "\p:");
			/* Append a Macintosh style colon (':'). */

		pcat(directoryName, str);
		pcpy(str, directoryName);

	} while (block.dirInfo.ioDrDirID != fsRtDirID);

	return(str);
}



/*****************************************************************************/



#pragma segment UtilMain
void	InitQuickTime(void)
{
	ComponentDescription	controllerDescriptor;
#ifdef powerc
	long					qtFeatures;
#endif

	if (!gQTVersion) {
		if (!(Gestalt(gestaltQuickTime, &gQTVersion))) {
#ifdef powerc
			if ((!(Gestalt (gestaltQuickTimeFeatures, &qtFeatures)) &&
				(qtFeatures & (1 << gestaltPPCQuickTimeLibPresent))))
#endif
				if (EnterMovies())
					gQTVersion = 0;
				else {
					controllerDescriptor.componentType         = 'play';
					controllerDescriptor.componentSubType      = 0;
					controllerDescriptor.componentManufacturer = 0;
					controllerDescriptor.componentFlags        = 0;
					controllerDescriptor.componentFlagsMask    = 0;
					gMovieControllerComponent = FindNextComponent((Component)0, &controllerDescriptor);
			}
		}
	}
}



/*****************************************************************************/



#pragma segment Controls
RgnHandle	LocalScreenDepthRegion(short depth)
{
	RgnHandle	retRgn;
	GrafPtr		oldPort;
	Point		pt;

	retRgn = ScreenDepthRegion(depth);
	if (gScreenPort) {
		GetPort(&oldPort);
		SetPort(gScreenPort);
	}

	pt.h = pt.v = 0;
	GlobalToLocal(&pt);
	OffsetRgn(retRgn, pt.h, pt.v);

	if (gScreenPort) SetPort(oldPort);
	return(retRgn);
}



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



#pragma segment Controls
pascal Boolean	AlertFilter(DialogPtr dlg, EventRecord *event, short *item)
{
	short	what, theChr, theMod, handled;

	what = event->what;
	if (event->what == keyDown) {
		theChr = event->message   & charCodeMask;
		theMod = event->modifiers & keyCodeMask;
		if ((theChr != 0x0D) && (theChr != 0x03))
			event->what = nullEvent;
		if (theMod & (cmdKey + optionKey + controlKey))
			event->what = nullEvent;
	}
	handled = KeyEquivFilter(dlg, event, item);
	event->what = what;
	return(handled);
}



/*****************************************************************************/



/* This code expects the key equivalents to be in item #2, which is a StatText
** item that is located so the text is outside of the dialog.  This allows us
** to put key equivalent information in the resource fork, so the key
** equivalents are localizable.
**
** An example save changes before closing or quitting res source with
** keyEquiv info would look like:
**
** resource 'DITL' (rYesNoCancel, purgeable) {
**     {
**         {71, 315, 91, 367}, Button     { enabled, "Save" },
**         {0, -1000, 20, 2},  StaticText { disabled,
**             "=S190001,=s190001,=D190003,=d190003,=.190104,1B190004" },
**         {71, 80, 91, 162},  Button { enabled, "Don’t Save" },
**         {71, 244, 91, 302}, Button { enabled, "Cancel" },
**         {11, 78, 61, 366},  StaticText { disabled,
**             "Save changes to the document “^0” before ^1?" },
**         {11, 23, 43, 55},        Icon { disabled, 2 }
**     }
** };
**
** The document name would be the string for param #0.
** The text "closing" or "quitting" would be the string for param #1.
**
** The keyEquiv entry is item #2, which has a rect that pushes it out of the
** dialog.  The string info is interpreted as to what the key/modifier combo
** is, and what dialog item it relates to.
**
** A single key equiv entry is 8 characters.  Entries are separated by commas.
**
** If the first character of an entry is an =, then the next character is the
** key.  If the first character isn't an =, then the first two characters are
** the hex value of the key.  (Ex:  =S or =s for save, 1B for ESC.)
**
** If the key pressed is the same as the key value for any of the entries, then
** the next two characters are the hex value for which modifiers to test.  This
** modifier test value is anded with the modifier.  The result is then compared
** to the value of the next two hex digits.  If they are equal, then the
** modifiers are correct, as well as the key.  If this is so, we have a winner.
**
** "=S190001,=s190001,=D190003,=d190003,=.190104,1B190004"
**
** The above string breaks down as follows:
** =S190001  =S  if event keypress is an S, check the modifier values
**           19  check controlKey/optionKey/cmdKey
**           00  all modifiers we are testing for should be false
**           01  if above is true, keypress maps to item # 1
** =s190001  Same as =S, but lowercase
** =D190001  Same as =S, but maps to item #3
** =d190001  Same as =D, but lowercase
** =.190104  =.  if event keypress is a period, check the modifier values
**           19  check controlKey/optionKey/cmdKey
**           01  controlKey/optionKey should be false, cmdKey should be true
**           04  if above is true, keypress maps to item # 4
** 1B190004  1B  if event keypress is an ESC, check the modifier values
**           19  check controlKey/optionKey/cmdKey
**           00  all modifiers we are testing for should be false
**           04  if above is true, keypress maps to item # 4
*/

#pragma segment Controls
pascal Boolean	KeyEquivFilter(DialogPtr dlg, EventRecord *event, short *item)
{
	short	itemType;
	Handle	itemHndl;
	Rect	itemRect;
	Str255	itemText;
	short	i, theChr, cc, theMod, equivChr, modMask, modVal, itemNum;

	if (event->what == updateEvt) {
		if (dlg == (DialogPtr)event->message)
			OutlineDialogItem(dlg, 1);
		return(false);
	}

	if (event->what != keyDown) return(false);

	itemNum = 0;

	theChr = event->message   & charCodeMask;
	theMod = event->modifiers & keyCodeMask;

	if ((theChr == 0x0D) || (theChr == 0x03)) {		/* If return or enter... */
		if (!(theMod & (cmdKey + optionKey + controlKey))) {
			*item = 1;
			return(true);
		}
	}

	GetDItem(dlg, 2, &itemType, &itemHndl, &itemRect);
	if (itemHndl) {
		GetIText(itemHndl, itemText);
		for (i = 1; i <= *itemText; i += 9) {
			cc = theChr;
			if (itemText[i] == (unsigned char)'≈')
				if ((cc >= 'a') && (cc <= 'z')) cc -= 32;
			equivChr = GetHexByte((char *)(itemText + i));
			modMask  = GetHexByte((char *)(itemText + i + 2)) << 8;
			modVal   = GetHexByte((char *)(itemText + i + 4)) << 8;
			itemNum  = GetHexByte((char *)(itemText + i + 6));
			if (cc == equivChr)
				if ((theMod & modMask) == modVal) break;
			itemNum = 0;
		}
	}

	if (itemNum) {
		GetDItem(dlg, itemNum, &itemType, &itemHndl, &itemRect);
		SelectButton((ControlHandle)itemHndl);
		*item = itemNum;
		return(true);
	}

	return(false);
}



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



/* This function returns which kind of button the control is.  This does more
** than GetCVariant in that it makes sure that the control is actually a
** button.  It does this by comparing the defProc against the known defProc
** for the various button types.  For 7.0, there is only one defProc for all
** variants, but for pre-7.0, there is one defProc value for each variant.
** The method below handles either case. */

#pragma segment Controls
short	GetButtonVariant(ControlHandle ctl)
{
	short			i;
	Rect			dummy;
	ControlHandle	dummyCtl;

	if (ctl) {
		for (i = pushButProc; i <= radioButProc + useWFont; ++i) {
			if (i == radioButProc + 1)
				i = pushButProc + useWFont;
			if (!gButtonProcs[i]) {
				SetRect(&dummy, 0, 0, 0, 0);
				dummyCtl = NewControl((*ctl)->contrlOwner, &dummy, (ConstStr255Param)"\p",
									  false, 1, 0, 1, i, 0L);
				if (dummyCtl) {
					gButtonProcs[i] = (*dummyCtl)->contrlDefProc;
					DisposeControl(dummyCtl);
				}
			}
			if (*(*ctl)->contrlDefProc == *gButtonProcs[i])
				return(GetCVariant(ctl) & (0xFFFF - useWFont));
					/* The handle may be locked, which means that the hi-bit
					** may be on, thus invalidating the compare.  Dereference the
					** handles to get rid of this possibility. */
		}
	}

	return(-1);
}



/*****************************************************************************/



#pragma segment Controls
Boolean GetCheckOrRadio(DialogPtr dlgPtr, short itemNo)
{
	short	iKind;
	Handle	iHandle;
	Rect	iRect;

	GetDItem(dlgPtr, itemNo, &iKind, &iHandle, &iRect);
	return(GetCtlValue((ControlHandle)iHandle) != 0);
}



/*****************************************************************************/



#pragma segment Controls
Boolean	IsScrollBar(ControlHandle ctl)
{
	Rect			dummy;
	ControlHandle	dummyCtl;

	if (!ctl) return(false);

	if (!gScrollProc) {
		SetRect(&dummy, 0, 0, 16, 100);
		dummyCtl = NewControl((*ctl)->contrlOwner, &dummy, (ConstStr255Param)"\p",
							  false, 1, 0, 1, scrollBarProc, 0L);
		if (dummyCtl) {
			gScrollProc = (*dummyCtl)->contrlDefProc;
			DisposeControl(dummyCtl);
		}
	}

	return((*(*ctl)->contrlDefProc) == (*gScrollProc));
		/* The handle may be locked, which means that the hi-bit
		** may be on, thus invalidating the compare.  Dereference the
		** handles to get rid of this possibility. */
}



/*****************************************************************************/



#pragma segment Controls
void	MoveStyledControl(ControlHandle ctl, short xloc, short yloc)
{
	char	vv, hh;

	if (GetCtlValue(ctl)) {
		if (GetButtonVariant(ctl) == pushButProc) {
			hh = (*ctl)->contrlHilite;
			(*ctl)->contrlHilite = 1;		/* Force outline off. */
			OutlineControl(ctl);
			(*ctl)->contrlHilite = hh;
		}
	}

	vv = (*ctl)->contrlVis;
	HideStyledControl(ctl);
	MoveControl(ctl, xloc, yloc);
	(*ctl)->contrlVis = vv;

	DoDraw1Control(ctl, false);
}



/*****************************************************************************/



#pragma segment Controls
void	SizeStyledControl(ControlHandle ctl, short xsize, short ysize)
{
	char	vv, hh;

	if (GetCtlValue(ctl)) {
		if (GetButtonVariant(ctl) == pushButProc) {
			hh = (*ctl)->contrlHilite;
			(*ctl)->contrlHilite = 1;		/* Force outline off. */
			OutlineControl(ctl);
			(*ctl)->contrlHilite = hh;
		}
	}

	vv = (*ctl)->contrlVis;
	HideStyledControl(ctl);
	SizeControl(ctl, xsize, ysize);
	(*ctl)->contrlVis = vv;

	DoDraw1Control(ctl, false);
}



/*****************************************************************************/



#pragma segment Controls
void	SetStyledCtlValue(ControlHandle ctl, short value)
{
	char	hh;

	if (value < (*ctl)->contrlMin) value = (*ctl)->contrlMin;	/* Don't let it draw on its own. */
	if (value > (*ctl)->contrlMax) value = (*ctl)->contrlMax;
	if ((*ctl)->contrlValue != value) {
		(*ctl)->contrlValue  = value;
		DoDraw1Control(ctl, false);		/* This routine does the right thing for popups. */
	}

	if (GetButtonVariant(ctl) == pushButProc) {
		if (!value) {
			hh = (*ctl)->contrlHilite;
			(*ctl)->contrlHilite = 1;		/* Force outline off. */
			OutlineControl(ctl);
			(*ctl)->contrlHilite = hh;
		}
		else
			OutlineControl(ctl);
	}
}



/*****************************************************************************/



#pragma segment Controls
void	ShowStyledControl(ControlHandle ctl)
{
	Boolean		didPopup;
	WindowPtr	oldPort, window;
	RgnHandle	oldClip, newClip;
	Point		org;
	Rect		srct;

	if (!(*ctl)->contrlVis) {

		didPopup = false;
		if (gPopupProc) {		/* The popup control does not handle negative coords. */
			if ((*(*ctl)->contrlDefProc) == (*gPopupProc)) {
				didPopup = true;
				GetPort(&oldPort);
				SetPort(window = (*ctl)->contrlOwner);
				GetClip(oldClip = NewRgn());	/* We draw it once, so that internals   */
				SetRect(&srct, 0, 0, 0, 0);		/* are fixed up.  We don't want to show */
				ClipRect(&srct);				/* a flash though. */

				RectRgn(newClip = NewRgn(), &(window->portRect));
				org.h = window->portRect.left;
				org.v = window->portRect.top;
				SetOrigin(0, 0);

				UseControlStyle(ctl);
				OffsetRect(&((*ctl)->contrlRect), -org.h, -org.v);	/* Completely clipped out. */
				ShowControl(ctl);									/* Just to fix internals.  */
				Draw1Control(ctl);

				SectRgn(newClip, oldClip, newClip);
				OffsetRgn(newClip, -org.h, -org.v);
				SetClip(newClip);
				Draw1Control(ctl);				/* Now really show it. */
				UseControlStyle(nil);

				OffsetRect(&((*ctl)->contrlRect), org.h, org.v);
				SetOrigin(org.h, org.v);
				SetClip(oldClip);
				DisposeRgn(newClip);
				DisposeRgn(oldClip);

				SetPort(oldPort);
			}
		}

		if (!didPopup) {
			(*ctl)->contrlVis = 255;
			DoDraw1Control(ctl, false);
		}
	}
}



/*****************************************************************************/



#pragma segment Controls
void	HideStyledControl(ControlHandle ctl)
{
	char		hh;
	Boolean		didPopup;
	WindowPtr	oldPort, window;
	RgnHandle	oldClip, newClip;
	Point		org;
	Rect		srct;

	if (GetButtonVariant(ctl) == pushButProc) {
		if ((*ctl)->contrlValue) {
			hh = (*ctl)->contrlHilite;
			(*ctl)->contrlHilite = 1;		/* Force outline off. */
			OutlineControl(ctl);
			(*ctl)->contrlHilite = hh;
			if ((*ctl)->contrlVis) {
				GetPort(&oldPort);
				SetPort(window = (*ctl)->contrlOwner);
				srct = (*ctl)->contrlRect;
				InsetRect(&srct, kButtonFrameInset, kButtonFrameInset);
				InvalRect(&srct);
				SetPort(oldPort);
			}
		}
	}

	didPopup = false;
	if (gPopupProc) {		/* The popup control does not handle negative coords. */
		if ((*(*ctl)->contrlDefProc) == (*gPopupProc)) {
			didPopup = true;
			GetPort(&oldPort);
			SetPort(window = (*ctl)->contrlOwner);
			GetClip(oldClip = NewRgn());	/* We draw it once, so that internals   */
			SetRect(&srct, 0, 0, 0, 0);		/* are fixed up.  We don't want to show */
			ClipRect(&srct);				/* a flash though. */

			RectRgn(newClip = NewRgn(), &(window->portRect));
			org.h = window->portRect.left;
			org.v = window->portRect.top;
			SetOrigin(0, 0);

			OffsetRect(&((*ctl)->contrlRect), -org.h, -org.v);	/* Completely clipped out. */
			Draw1Control(ctl);									/* Just to fix internals.  */

			SectRgn(newClip, oldClip, newClip);
			OffsetRgn(newClip, -org.h, -org.v);
			SetClip(newClip);
			HideControl(ctl);				/* Now really hide it. */

			OffsetRect(&((*ctl)->contrlRect), org.h, org.v);
			SetOrigin(org.h, org.v);
			SetClip(oldClip);
			DisposeRgn(newClip);
			DisposeRgn(oldClip);

			SetPort(oldPort);
		}
	}

	if (!didPopup) HideControl(ctl);
}



/*****************************************************************************/



#pragma segment Controls
void	OffsetControl(ControlHandle ctl, short dx, short dy)
{
	Rect	ctlRect;

	ctlRect = (*ctl)->contrlRect;
	MoveStyledControl(ctl, ctlRect.left + dx, ctlRect.top + dy);
}



/*****************************************************************************/



/* Given any control handle, this will draw an outline around it.  This is used
** for the default button of a window.  The extra nice feature here is that
** I’ll erase the outline for buttons that are inactive.  Seems like there
** should be a Toolbox call for getting a control’s hilite state.  Since there
** isn’t, I have to look into the control record myself.  This should be called
** for update and activate events.
**
** The method for determining the oval diameters for the roundrect is a little
** different than that recommended by Inside Mac. IM I-407 suggests that you
** use a hardcoded (16,16) for the diameters.  However, this only looks good
** for small roundrects.  For larger ones, the outline doesn’t follow the inner
** roundrect because the CDEF for simple buttons doesn’t use (16,16).  Instead,
** it uses half the height of the button as the diameter.  By using this
** formula, too, our outlines look better. */

#pragma segment Controls
void	OutlineControl(ControlHandle button)
{
	WindowPtr	oldPort;
	Rect		theRect;
	PenState	curPen;
	short		buttonOval;
	RgnHandle	oldClip, newClip;
	RGBColor	oldrgb;

	static RGBColor	whitergb = {0xFFFF, 0xFFFF, 0xFFFF};
	static RGBColor	grayrgb  = {0x8000, 0x8000, 0x8000};
	static RGBColor	blackrgb = {0x0000, 0x0000, 0x0000};

	if (button) {
		if ((*button)->contrlVis) {
			GetPort(&oldPort);
			SetPort((*button)->contrlOwner);
			GetPenState(&curPen);
			PenNormal();
			PenSize(kButtonFrameSize, kButtonFrameSize);

			theRect = (*button)->contrlRect;
			InsetRect(&theRect, kButtonFrameInset, kButtonFrameInset);
			buttonOval = (theRect.bottom - theRect.top) / 2 + 2;

			GetClip(oldClip = NewRgn());
			newClip = LocalScreenDepthRegion(4);
			SectRgn(oldClip, newClip, newClip);
			SetClip(newClip);

			if (!EmptyRgn(newClip)) {
				GetForeColor(&oldrgb);
				switch ((*button)->contrlHilite) {
					case kCntlActivate:
						RGBForeColor(&blackrgb);
						break;
					case kCntlDeactivate:
						RGBForeColor(&grayrgb);
						break;
					default:
						RGBForeColor(&whitergb);
						break;
				}
				FrameRoundRect(&theRect, buttonOval, buttonOval);
				RGBForeColor(&oldrgb);
			}

			DiffRgn(oldClip, newClip, newClip);
			SetClip(newClip);
			if (!EmptyRgn(newClip)) {
				switch ((*button)->contrlHilite) {
					case kCntlActivate:
						PenPat((ConstPatternParam)&QD(black));
						break;
					case kCntlDeactivate:
						PenPat((ConstPatternParam)&QD(gray));
						break;
					default:
						PenPat((ConstPatternParam)&QD(white));
						break;
				}
				FrameRoundRect(&theRect, buttonOval, buttonOval);
			}

			SetClip(oldClip);
			DisposeRgn(oldClip);
			DisposeRgn(newClip);

			SetPenState(&curPen);
			SetPort(oldPort);
		}
	}
}



/*****************************************************************************/



#pragma segment Controls
void	OutlineDialogItem(DialogPtr dlgPtr, short item)
{
	short	iKind;
	Handle	iHandle;
	Rect	iRect;

	GetDItem(dlgPtr, item, &iKind, &iHandle, &iRect);
	OutlineControl((ControlHandle) iHandle);
}



/*****************************************************************************/



/* Given the button control handle, this will cause the button to look as if it
** has been clicked in.  This is nice to do for the user if they type return or
** enter to select the default item. */

#pragma segment Controls
void	SelectButton(ControlHandle button)
{
	long	finalTicks;

	UseControlStyle(button);
	HiliteControl(button, kSelect);
	Delay(kDelayTime, &finalTicks);
	HiliteControl(button, kDeselect);
	UseControlStyle(nil);
}



/*****************************************************************************/



/* Handy function for setting the value of a radio button.  Given a dialog
** pointer, and item number, and a state, this function will take care of the
** rest. */

#pragma segment Controls
void	SetCheckOrRadioButton(DialogPtr dlgPtr, short itemNo, short state)
{
	short	iKind;
	Handle	iHandle;
	Rect	iRect;

	GetDItem(dlgPtr, itemNo, &iKind, &iHandle, &iRect);
	SetCtlValue((ControlHandle)iHandle, state);
}



/*****************************************************************************/



#pragma segment Controls
void	ToggleCheck(DialogPtr dlgPtr, short chkItem)
{
	short	iKind;
	Handle	iHandle;
	Rect	iRect;

	GetDItem(dlgPtr, chkItem, &iKind, &iHandle, &iRect);
	SetCtlValue((ControlHandle) iHandle, !GetCtlValue((ControlHandle)iHandle));
}



/*****************************************************************************/



#pragma segment Controls
Boolean	WhichControl(Point mouseLoc, long when, WindowPtr window, ControlHandle *ctlHit)
{
	Boolean					found;
	Rect					rct;
	ControlHandle			ctl, lastCtl;
	static ControlHandle	lastWhenCtl;

	gWhichCtlTracking = false;

	found   = false;
	lastCtl = nil;

	if (ctlHit)
		*ctlHit = nil;

	if (window) {
		ctl = ((WindowPeek)window)->controlList;
		while (ctl) {
			if ((*ctl)->contrlVis) {
				rct = (*ctl)->contrlRect;
				if (PtInRect(mouseLoc, &rct)) {
					found = true;			/* Return the last hit in the linked list, as */
					lastCtl = ctl;			/* it is drawn last, and therefore on top.    */
				}
			}
			ctl = (*ctl)->nextControl;
		}
	}

	if (ctlHit)
		*ctlHit = lastCtl;

	gWhichCtlDbl = false;
	if (when) {
		gWhichCtlHit = lastWhenCtl;
		lastWhenCtl  = lastCtl;
		if (gWhichCtlHit == lastCtl)
			if (when < gWhichCtlWhen + 30)
				gWhichCtlDbl = true;
		gWhichCtlWhen = when;
	}
	gWhichCtlHit = lastCtl;

	return(found);
}



/*****************************************************************************/



#pragma segment Controls
void	DoDrawControls(WindowPtr window, Boolean scrollBarsOnly)
{
	ControlHandle	ctl;

	ctl = ((WindowPeek)window)->controlList;
	while (ctl) {
		DoDraw1Control(ctl, scrollBarsOnly);
		ctl = (*ctl)->nextControl;
	}
}



/*****************************************************************************/



#pragma segment Controls
void	DoDraw1Control(ControlHandle ctl, Boolean scrollBarsOnly)
{
	WindowPtr	window, oldPort;
	Rect		rct, srct;
	Point		org;
	RgnHandle	oldClip, newClip;
	Boolean		didPopup;

	window = (*ctl)->contrlOwner;
	rct  = (*(window->visRgn))->rgnBBox;
	srct = (*(window->clipRgn))->rgnBBox;
	SectRect(&rct, &srct, &srct);

	rct = (*ctl)->contrlRect;
	if ((*ctl)->contrlValue)
		if (GetButtonVariant(ctl) == pushButProc)
			InsetRect(&rct, kButtonFrameInset, kButtonFrameInset);
	SectRect(&rct, &srct, &srct);
	if (EmptyRect(&srct))
		if (!(window->picSave))
			return;

	if (IsScrollBar(ctl)) {
		if (((WindowPeek)window)->hilited)
			Draw1Control(ctl);
		else {
			if ((*ctl)->contrlVis) {
				GetPort(&oldPort);
				SetPort(window);
				rct = (*ctl)->contrlRect;
				FrameRect(&rct);
				InsetRect(&rct, 1, 1);
				EraseRect(&rct);
				SetPort(oldPort);
			}
		}
	}
	else {
		if (!scrollBarsOnly) {
			UseControlStyle(ctl);
			didPopup = false;
			if (gPopupProc) {		/* The popup control does not handle negative coords. */
				if ((*(*ctl)->contrlDefProc) == (*gPopupProc)) {
					didPopup = true;
					GetPort(&oldPort);
					SetPort(window);
					GetClip(oldClip = NewRgn());	/* We draw it once, so that internals   */
					SetRect(&srct, 0, 0, 0, 0);		/* are fixed up.  We don't want to show */
					ClipRect(&srct);				/* a flash though. */

					RectRgn(newClip = NewRgn(), &(window->portRect));
					org.h = window->portRect.left;
					org.v = window->portRect.top;
					SetOrigin(0, 0);

					OffsetRect(&((*ctl)->contrlRect), -org.h, -org.v);	/* Completely clipped out. */
					Draw1Control(ctl);									/* Just to fix internals.  */

					SectRgn(newClip, oldClip, newClip);
					OffsetRgn(newClip, -org.h, -org.v);
					SetClip(newClip);
					Draw1Control(ctl);				/* Now really draw it. */

					OffsetRect(&((*ctl)->contrlRect), org.h, org.v);
					SetOrigin(org.h, org.v);
					SetClip(oldClip);
					DisposeRgn(newClip);
					DisposeRgn(oldClip);

					SetPort(oldPort);
				}
			}
			if (!didPopup) {
				if ((*ctl)->contrlVis) {
					if (gDrawControl)
						(*gDrawControl)(ctl);
					else
						Draw1Control(ctl);
				}
			}
			UseControlStyle(nil);
			if (GetCtlValue(ctl)) {
				if (GetButtonVariant(ctl) == pushButProc)
					OutlineControl(ctl);
			}
		}
	}
}



/*****************************************************************************/



/* GetPopupCtlHandle takes a dialog and its item number and (assuming it is a
** popup menu control) and returns the control handle for the popup. */

#pragma segment Controls
ControlHandle	GetPopupCtlHandle(DialogPtr theDialog, short itemNum)
{
	short		theType;
	Handle		theHndl;
	Rect		theBox;

	GetDItem(theDialog, itemNum, &theType, &theHndl, &theBox);
	return((ControlHandle)theHndl);
}



/*****************************************************************************/



/* GetPopupMenuHandle takes a popup control and returns the menu handle from
** the control. */

#pragma segment Controls
MenuHandle	GetPopupMenuHandle(ControlHandle popupCtl)
{
	PopupCtlDataHandle	popupData;

	if (popupData = (PopupCtlDataHandle)(*popupCtl)->contrlData)
		return((*popupData)->mHandle);

	return(nil);
}



/*****************************************************************************/



/* GetPopupCtlValue returns value for the popup control. */

#pragma segment Controls
short	GetPopupCtlValue(DialogPtr theDialog, short popItem)
{
	ControlHandle	popupCtl;

	if (popupCtl = GetPopupCtlHandle(theDialog, popItem))
		return(GetCtlValue(popupCtl));

	return(-1);
}



/*****************************************************************************/



/* SetPopupCtlValue makes value the new value for the popup control. */

#pragma segment Controls
void	SetPopupCtlValue(DialogPtr theDialog, short popItem, short value)
{
	ControlHandle	popupCtl;

	if (popupCtl = GetPopupCtlHandle(theDialog, popItem)) {
		(*popupCtl)->contrlValue = value;
		DoDraw1Control(popupCtl, false);
	}
}



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



#pragma segment Controls
OSErr	SetControlStyle(ControlHandle ctl, ControlStyleInfoPtr cinfo)
{
	short				len, tlen, ofst;
	OSErr				err;
	ControlStyleInfo	cin;
	Ptr					ptr1, ptr2;

	tlen = (*ctl)->contrlTitle[0];
	ofst = offsetof(ControlRecord,contrlTitle) + tlen + 1;
	if (!cinfo) {
		SetHandleSize((Handle)ctl, ofst);
		return(noErr);
	}		/* If no info, then control is normalized. */

	cin   = *cinfo;
	ptr1  = (Ptr)&cin + offsetof(ControlStyleInfo,font);			/* Point at font. */
	ptr1 += ptr1[0] + 1;											/* Point at packed keyEquivs. */
	ptr2  = (Ptr)&cin + offsetof(ControlStyleInfo,keyEquivs);		/* Point at keyEquivs. */
	BlockMove(ptr2, ptr1, ptr2[0] + 1);
	ptr1 += ptr1[0] + 1;											/* Point at packed balloonHelp. */
	ptr2  = (Ptr)&cin + offsetof(ControlStyleInfo,balloonHelp);		/* Point at balloonHelp. */
	BlockMove(ptr2, ptr1, ptr2[0] + 1);
	ptr1 += ptr1[0] + 1;											/* Point past packed balloonHelp. */

	len = ptr1 - (Ptr)&cin;
	SetHandleSize((Handle)ctl, ofst + len);
	if (err = MemError()) {
		SetHandleSize((Handle)ctl, ofst);
		return(err);
	}

	BlockMove((Ptr)&cin, ((Ptr)*ctl) + ofst, len);
	return(noErr);
}



/*****************************************************************************/



#pragma segment Controls
Boolean	GetControlStyle(ControlHandle ctl, ControlStyleInfoPtr cinfo)
{
	short	clen, tlen, ofst, ofst2, ofst3;
	Ptr		ptr;

	clen = GetHandleSize((Handle)ctl);
	tlen = (*ctl)->contrlTitle[0];
	ofst = offsetof(ControlRecord,contrlTitle) + tlen + 1;
	if (clen < ofst + sizeof(short)) return(false);

	if (cinfo) {
		ptr = (Ptr)*ctl;
		BlockMove(ptr + ofst, (Ptr)cinfo, clen - ofst);
		ptr   = (Ptr)cinfo;
		ofst  = offsetof(ControlStyleInfo,font);		/* font */
		ofst2 = ofst  + ptr[ofst]  + 1;					/* keyEquivs */
		ofst3 = ofst2 + ptr[ofst2] + 1;					/* balloonHelp */
		BlockMove(ptr + ofst3, ptr + offsetof(ControlStyleInfo,balloonHelp), ptr[ofst3] + 1);
		BlockMove(ptr + ofst2, ptr + offsetof(ControlStyleInfo,keyEquivs),   ptr[ofst2] + 1);
	}

	return(true);
}



/*****************************************************************************/



#pragma segment Controls
void	SetTrackControlProc(ControlHandle ctl, TrackControlProcPtr proc)
{
	ControlStyleInfo	cinfo;

	if (GetControlStyle(ctl, &cinfo)) {
		cinfo.trackProc = proc;
		SetControlStyle(ctl, &cinfo);
	}
}



/*****************************************************************************/



#pragma segment Controls
short	GetControlID(ControlHandle ctl)
{
	short	tlen, ofst, id;

	tlen = (*ctl)->contrlTitle[0];
	ofst = offsetof(ControlRecord,contrlTitle) + tlen + 1;
	if (GetHandleSize((Handle)ctl) < ofst + sizeof(short)) return(0);

	BlockMove(((Ptr)*ctl) + ofst, &id, sizeof(short));
	return(id);
}



/*****************************************************************************/



#pragma segment Controls
void	SetStyledCTitle(ControlHandle ctl, StringPtr title)
{
	ControlStyleInfo	cinfo;
	Boolean				hasStyle;
	char				vv;

	vv = (*ctl)->contrlVis;
	(*ctl)->contrlVis = 0;

	hasStyle = GetControlStyle(ctl, &cinfo);
	SetCTitle(ctl, title);
	if (hasStyle)
		SetControlStyle(ctl, &cinfo);

	(*ctl)->contrlVis = vv;
	DoDraw1Control(ctl, false);
}



/*****************************************************************************/



#pragma segment Controls
void	UseControlStyle(ControlHandle ctl)
{
	WindowPtr			oldPort;
	short				fnum;
	ControlStyleInfo	cinfo;
	static short		txFont, txSize;
	static Style		txFace;
	static WindowPtr	ctlWindow;

	if (!ctl) {
		gDrawControl = nil;
		if (ctlWindow) {
			GetPort(&oldPort);
			SetPort(ctlWindow);
			TextFont(txFont);
			TextSize(txSize);
			TextFace(txFace);
			SetPort(oldPort);
		}
		return;
	}

	ctlWindow = nil;
	if (GetControlStyle(ctl, &cinfo)) {
		gDrawControl = cinfo.drawControl;
		if (GetCVariant(ctl) & useWFont) {
			GetPort(&oldPort);
			SetPort(ctlWindow = (*ctl)->contrlOwner);
			txFont = ctlWindow->txFont;
			txSize = ctlWindow->txSize;
			txFace = ctlWindow->txFace;
			TextFace(cinfo.fontStyle);
			fnum = systemFont;
			if (cinfo.font[0])
				GetFNum(cinfo.font, &fnum);
			TextFont(fnum);
			TextSize(cinfo.fontSize);
			SetPort(oldPort);
		}
	}
}



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



#pragma segment Controls
Boolean	ControlKeyEquiv(WindowPtr window, EventRecord *event, ControlHandle *retCtl, StringPtr defaultEquivs)
{
	ControlHandle		ctl;
	ControlStyleInfo	cinfo;
	short				i, theChr, cc, theMod, equivChr, modMask, modVal, pass;

	if (retCtl)
		*retCtl = nil;

	if (event->what != keyDown) return(false);

	theChr = event->message   & charCodeMask;
	theMod = event->modifiers & keyCodeMask;

	for (pass = 0; pass < 2; ++pass) {
		for (ctl = ((WindowPeek)window)->controlList; ctl; ctl = (*ctl)->nextControl) {
			if (!(*ctl)->contrlVis)   continue;		/* Control not visible, so next control. */
			if ((*ctl)->contrlHilite) continue;		/* Control not active, so next control. */
			cinfo.keyEquivs[0] = 0;
			switch (pass) {
				case 0:
					GetControlStyle(ctl, &cinfo);
					break;
				case 1:
					if (GetButtonVariant(ctl) == pushButProc)				/* If simple button... */
						if (GetCtlValue(ctl))								/* If is outlined button... */
							if (defaultEquivs)								/* If default equiv text passed in... */
								pcpy(cinfo.keyEquivs, defaultEquivs)	;	/* Use it. */
					break;
			}
			for (i = 1; i < cinfo.keyEquivs[0]; i += 7) {
				if (cinfo.keyEquivs[i] == (unsigned char)':') break;
				cc = theChr;
				if (cinfo.keyEquivs[i] == (unsigned char)'≈')
					if ((cc >= 'a') && (cc <= 'z')) cc -= 32;
				equivChr = GetHexByte((char *)(cinfo.keyEquivs + i));
				modMask  = GetHexByte((char *)(cinfo.keyEquivs + i + 2)) << 8;
				modVal   = GetHexByte((char *)(cinfo.keyEquivs + i + 4)) << 8;
				if (cc == equivChr) {
					if ((theMod & modMask) == modVal) {
						if (retCtl)
							*retCtl = ctl;
						return(true);
					}
				}
			}
		}
	}

	return(false);
}




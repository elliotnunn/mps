/*
	file HTMLSample.c
	
	Description:
	This file contains the main application program for the HTMLSample.
	Routines in this file are responsible for handling events directed
	at the application.
	
	HTMLSample is an application illustrating how to use the new
	HTMLRenderingLib services found in Mac OS 9. HTMLRenderingLib
	is Apple's light-weight HTML rendering engine capable of
	displaying HTML files.

	by John Montbriand, 1999.

	Copyright: © 1999 by Apple Computer, Inc.
	all rights reserved.
	
	Disclaimer:
	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "DSC Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.
	
	Change History (most recent first):
	10/16/99 created by John Montbriand
*/

#include "HTMLSample.h"
#include "debugf.h"

#include <Menus.h>
#include <Windows.h>
#include <Dialogs.h>
#include <Events.h>
#include <Fonts.h>
#include <SegLoad.h>
#include <Resources.h>
#include <Balloons.h>
#include <Devices.h>
#include <AppleEvents.h>
#include <StdIO.h>
#include <StdArg.h>
#include <StandardFile.h>
#include <string.h>
#include <ToolUtils.h>
#include <Appearance.h>
#include <Navigation.h>
#include <Sound.h>


#include <HTMLRendering.h>

#include "RenderingWindow.h"
#include "SampleUtils.h"
#include "AboutBox.h"

	/* true while the app is running */
Boolean gRunning = true;



/* OpenOneFile is called for each file the application is asked to open
	either by way of Apple event or from the file menu.  spec points to
	a file specification record referring to the file to open.  The file will
	be opened in a new window. */
static OSErr OpenOneFile(FSSpec *spec) {
	Handle urlHandle, errorPageLink;
	WindowPtr rWindow;
	Str255 errStr;
	OSErr err;
		/* initial state */
	urlHandle = NULL;
	rWindow = NULL;
		/* allocate locals */
	urlHandle = NewHandle(0);
	if (urlHandle == NULL) { err = memFullErr; goto bail; }
	errorPageLink = GetResource(kCStyleStringResourceType, kErrorPageURLString);
	if (errorPageLink == NULL)  { err = resNotFound; goto bail; }
		/* convert the fsspec to a url */
	err = HRUtilGetURLFromFSSpec(spec, urlHandle);
	if (err != noErr) goto bail;
		/* open the window */
	err = RWOpen(&rWindow);
	if (err != noErr) goto bail;
		/* attempt to open the url */
	MoveHHi(urlHandle);
	HLock(urlHandle);
	err = RWGotoURL(rWindow, *urlHandle, true);
	HUnlock(urlHandle);
		/* if that fails, try to show the error page */
	if (err != noErr) {
		MoveHHi(errorPageLink);
		HLock(errorPageLink);
		err = RWGotoAppRelLink(rWindow, *errorPageLink, true);
		HUnlock(errorPageLink);
		if (err != noErr) goto bail;
	}
		/* clean up and leave */
	DisposeHandle(urlHandle);
	return noErr;
bail:
		/* we display an alert here if there's an error. returning
		an error from this routine will abort any open routine that
		is going on--even if we're in the middle of a list of files. */
	NumToString(err, errStr);
	ParamAlert(kOpenFileErrorAlert, errStr, spec->name);
	if (rWindow != NULL) RWCloseWindow(rWindow);
	if (urlHandle != NULL) DisposeHandle(urlHandle);
	return err;
}

/* IdentifyPackage identifies a Mac OS 9 package and returns a reference
	to it's main file inside of mainPackageFile.  In Mac OS 9, packages are
	the special folders that have their bundle bits set and contain an alias
	at their topmost level referring to a file somewhere in the package. */
static Boolean IdentifyPackage(FSSpec *target, FSSpec *mainPackageFile) {
	CInfoPBRec cat;
	OSErr err;
	long pDir;
	Str255 name;
	FSSpec aliasFile;
	Boolean targetIsFolder, wasAliased;
		/* check the target's flags */
	cat.dirInfo.ioNamePtr = target->name;
	cat.dirInfo.ioVRefNum = target->vRefNum;
	cat.dirInfo.ioFDirIndex = 0;
	cat.dirInfo.ioDrDirID = target->parID;
	err = PBGetCatInfoSync(&cat);
	if (err != noErr) return false;
		/* if it's a folder and the bundle bit is set....*/
	if (((cat.dirInfo.ioFlAttrib & 16) != 0) && ((cat.dirInfo.ioDrUsrWds.frFlags & kHasBundle) != 0)) {
			/* search for a top level alias file.  Here, we enumerate all of the
			objects in the directory until we find a file with the alias flag set. */
		pDir = cat.dirInfo.ioDrDirID;
		cat.dirInfo.ioNamePtr = name;
		cat.dirInfo.ioVRefNum = target->vRefNum;
		cat.dirInfo.ioFDirIndex = 1;
		cat.dirInfo.ioDrDirID = pDir;
		while (PBGetCatInfoSync(&cat) == noErr) {
				/* if the thing we're looking at is not a directory and it's alias flag is set,
				try to resolve it as an alias file. */
			if (((cat.dirInfo.ioFlAttrib & 16) == 0) && ((cat.dirInfo.ioDrUsrWds.frFlags & kIsAlias) != 0)) {
				err = FSMakeFSSpec(target->vRefNum, pDir, name, &aliasFile);
				if (err != noErr) return false;
				err = ResolveAliasFile(&aliasFile, false, &targetIsFolder, &wasAliased);
				if (err != noErr) return false;
				if (mainPackageFile != NULL)
					*mainPackageFile = aliasFile;
				return true;
			}
				/* move on to the next file in the directory. */
			cat.dirInfo.ioFDirIndex++;
			cat.dirInfo.ioDrDirID = pDir;
		}
	}
		/* we found nothing matching our criteria, so we
		fail. */
	return false;
}


/* OpenTheDocuments is called to open a list of documents provided by
	either an open documents Apple event or one of the Navigation services
	dialogs.  */
static OSErr OpenTheDocuments(AEDescList *theDocuments) {
	OSErr err;
	long i, n;
	FSSpec fileSpec, packageSpec;
	AEKeyword keyWd;
	DescType typeCd;
	Size actSz;
	
		/* open them */
	err = AECountItems(theDocuments, &n);
	if (err != noErr) goto bail;
		/* and then open each one */
	for (i = 1 ; i <= n; i++) {
			/* get the i'th FSSpec record.  NOTE: implicity, we are calling
			a coercion handler because this list actually contains alias records. 
			In particular, the coercion handler converts them from alias records
			into FSSpec records. */
		err = AEGetNthPtr(theDocuments, i, typeFSS, &keyWd, &typeCd,
			(Ptr) &fileSpec, sizeof(fileSpec), (actSz = sizeof(fileSpec), &actSz));
		if (err != noErr) goto bail;
			/* if it's a package, we'll open it's main file, otherwise
			we'll open the file itself */
		if (IdentifyPackage(&fileSpec, &packageSpec))
			err = OpenOneFile(&packageSpec);
		else err = OpenOneFile(&fileSpec);
		if (err != noErr) goto bail;
	}
	return noErr;
bail:
	return err;
}


/* MyNavFilterProc This is the filter function we provide for the Navigation services
	dialogs.  We only allow files of type TEXT. */
static pascal Boolean MyNavFilterProc( AEDesc* theItem, void* info, NavCallBackUserData callBackUD, NavFilterModes filterMode) {
	NavFileOrFolderInfo* theInfo;
	if ( theItem->descriptorType == typeFSS ) {
		theInfo = (NavFileOrFolderInfo*) info;
		if ( theInfo->isFolder ) return true;
		if ( theInfo->fileAndFolder.fileInfo.finderInfo.fdType != 'TEXT' )
			return false;
	}
	return true;
}


/* NavEventCallBack is the event handling call back we provide for Navigation
	services.  It's presence is important so our windows will be updated appropriately
	when the navigation window is resized or moved. */
static pascal void NavEventCallBack( NavEventCallbackMessage callBackSelector,
			NavCBRecPtr callBackParms, NavCallBackUserData callBackUD) {
	if (callBackSelector == kNavCBEvent && callBackParms->eventData.eventDataParms.event->what == updateEvt) {

		HandleEvent(callBackParms->eventData.eventDataParms.event);

	}
}


/* MyFileFilterProc is used by the older standard file calls.  We fall back to
	standard file when navigation services is not present or unavailable.  In this
	routine, we filter out all invisible files. */
static pascal Boolean MyFileFilterProc(CInfoPBPtr pb) {
		/* don't display invisible files */
	return ((pb->hFileInfo.ioFlFndrInfo.fdFlags & kIsInvisible) != 0);
}


/* SelectAndOpenFile is the inner workings of the Open... command
	when it is chosen from the file menu.  Here, we use the navigation
	services dialogs when they are available, but if they're not, then we
	use the standard file ones. */
static OSStatus SelectAndOpenFile(void) {
	NavDialogOptions dialogOptions;
	NavReplyRecord theReply;
	NavEventUPP eventf;
	NavObjectFilterUPP filterf;
	FileFilterUPP stdFilterf;
	Boolean hasreply;
	OSStatus err;
		/* set up locals */
	eventf = NULL;
	filterf = NULL;
	stdFilterf = NULL;
	hasreply = false;
	BlockZero(&theReply, 0);
		/* if Navigation services is available, then we
		use those calls. */
	if (NavServicesAvailable()) {
			/* allocate data */
		filterf = NewNavObjectFilterUPP(MyNavFilterProc);
		if (filterf == NULL) { err = memFullErr; goto bail; }
		eventf = NewNavEventUPP(NavEventCallBack);
		if (eventf == NULL) { err = memFullErr; goto bail; }
			/* set up dialog options */
		err = NavGetDefaultDialogOptions(&dialogOptions);
		if (err != noErr) goto bail;
			/* NOTE: by setting the kNavAllowMultipleFiles flag, we make it possible
			for the user to select more than one file.  And, setting the kNavSupportPackages
			flag allows us to open package documents. */
		dialogOptions.dialogOptionFlags = (kNavDontAutoTranslate | kNavAllowMultipleFiles | kNavSupportPackages);
		GetIndString(dialogOptions.message, kMainStringList, kNavMessageString);
			/* pick one or more files */
		err = NavChooseFile(NULL, &theReply, &dialogOptions, eventf,  NULL,  filterf,  NULL, NULL);
		if (err != noErr) goto bail;
		if (!theReply.validRecord) { err = userCanceledErr; goto bail; }
		hasreply = true;
			/* if we have a valid reply, then call our
			open documents routine. */
		err = OpenTheDocuments(&theReply.selection);
		if (err != noErr) goto bail;
			/* clean up the structures we allocated */
		NavDisposeReply(&theReply);
		DisposeNavEventUPP(eventf);
		DisposeNavObjectFilterUPP(filterf);
	}
	return noErr;
bail:
	if (hasreply) NavDisposeReply(&theReply);
	if (eventf != NULL) DisposeNavEventUPP(eventf);
	if (filterf != NULL) DisposeNavObjectFilterUPP(filterf);
	return err;
}




/* ResetMenus is called immediately before all calls to
	MenuSelect or MenuKey.  In this routine, we re-build
	or enable the menus as appropriate depending on the
	current environment */
static void ResetMenus(void) {
	WindowPtr target;
	target = FrontWindow();
		/* if the front most window is a rendering
		window, then we let the window handle the
		menu. */
	if (IsARenderingWindow(target))
		RWResetGotoMenu(target);
	else {
		MenuHandle goMenu;
			/* otherwise, we clear the menu
			and disable all of its commands. */
		goMenu = GetMenuHandle(mGo);
		DisableMenuItem(goMenu, iBack);
		DisableMenuItem(goMenu, iForward);
		DisableMenuItem(goMenu, iHome);
		while (CountMenuItems(goMenu) >= iGoSep)
			DeleteMenuItem(goMenu, iGoSep);
	}
}


/* DoMenuCommand is called in response to MenuKey
	or MenuSelect.  Here, we dispatch the menu command
	to its appropriate handler, or if it's a small action
	we do it here. */
static void DoMenuCommand(long rawMenuSelectResult) {
	short menu, item;
		/* decode the MenuSelect result */
	menu = (rawMenuSelectResult >> 16);
	if (menu == 0) return;
	item = (rawMenuSelectResult & 0x0000FFFF);
		/* dispatch on result */
	switch (menu) {
			/* apple menu commands */
		case mApple:
			if (item == iAbout) {
				WindowPtr aboutBox;
				OSStatus err;
					/* open the about box */
				err = OpenAboutBox(&aboutBox);
				if (err != noErr) {
					Str255 errStr;
					NumToString(err, errStr);
					ParamAlert(kNoAboutBoxErrorAlert, errStr, NULL);
				}
			}
			break;
			
				/* file menu commands */
		case mFile:
			if (item == iOpen) {
				SelectAndOpenFile();
			} else if (item == iQuit) {
				if (CloseRenderingWindows() == noErr)
					gRunning = false;
			}
			break;
			
				/* selections in the Go menu are handled by
				the frontmost rendering window. */
		case mGo:
			{	WindowPtr target;
				target = FrontWindow();
				if (IsARenderingWindow(target))
					RWHandleGotoMenu(target, item);
			}
			break;

	}
		/* unhilite the menu bar */
	HiliteMenu(0);
}


/* QuitAppleEventHandler is our quit Apple event handler.  this routine
	is called when a quit Apple event is sent to our application.  Here,
	we set the gRunning flag to false. NOTE:  it is not appropriate to
	call ExitToShell here.  Instead, by setting the flag to false we
	fall through the bottom of our main loop the next time we're called. 
	Here, if we are unable to close all of the rendering windows,
	we return an error.  This will abort the shutdown process,
	if that's why we were called.  */
static pascal OSErr QuitAppleEventHandler(const AppleEvent *appleEvt, AppleEvent* reply, long refcon) {
	if (CloseRenderingWindows() == noErr) {
		gRunning = false;
		return noErr;
	} else return userCanceledErr;
}


/* OpenAppleEventHandler is called when our application receives
	an 'open application' apple event.  Here, we put up a window
	referring to the default page. */
static pascal OSErr OpenAppleEventHandler(const AppleEvent *appleEvt, AppleEvent* reply, long refcon) {
	WindowPtr rWin;
	Handle urlHandle;
	OSErr err;
		/* creat a rendering window. */
	err = RWOpen(&rWin);
	if (err != noErr) return err;
		/* get the link to the default page from the resource
		file. */
	urlHandle = GetResource(kCStyleStringResourceType, kDefaultPageURLString);
	if (urlHandle == NULL) return memFullErr;
		/* lock down the resource and point the rendering
		window at it. */
	MoveHHi(urlHandle);
	HLock(urlHandle);
	RWGotoAppRelLink(rWin, *urlHandle, true);
	HUnlock(urlHandle);
		/* done */
	return noErr;
}


/* ReOpenAppleEventHandler is called whenever the application receives
	a re-open Apple event.  This will happen if the application is already
	running and the user attempts to open it again by either double clicking
	on its icon in the Finder or by selecting its icon and choosing Open in
	the Finder's file menu. Here, if there is no window showing, then we
	open a new one as we would if an open application event was received. */
static pascal OSErr ReOpenAppleEventHandler(const AppleEvent *appleEvt, AppleEvent* reply, long refcon) {
	
	if (FrontWindow() == NULL)
		return OpenAppleEventHandler(appleEvt, reply, refcon);
	else return noErr;
	
	return noErr;
}


/* OpenDocumentsEventHandler is called whenever we receive an open documents
	Apple event.  Here, we extract the list of documents from the event
	and pass them along to our OpenTheDocuments routine. */
static pascal OSErr OpenDocumentsEventHandler(const AppleEvent *appleEvt, AppleEvent* reply, long refcon) {
	OSErr err;
	AEDescList documents;
	
		/* initial state */
	AECreateDesc(typeNull, NULL, 0, &documents);
	
		/* get the open parameter */
	err = AEGetParamDesc(appleEvt, keyDirectObject, typeAEList, &documents);
	if (err != noErr) goto bail;
	
		/* open the documents */
	err = OpenTheDocuments(&documents);
	if (err != noErr) goto bail;

bail:
	AEDisposeDesc(&documents);
	return err;
}





/* HandleMouseDown is called for mouse down events.  Processing of
	mouse down events in the HTML rendering area of windows is 
	handled by the HTMLRenderinLib, but clicks in the controls and
	other parts of the windows are handled here. */
static void HandleMouseDown(EventRecord *ev) {
	WindowPtr theWindow;
	short partcode;
	Rect r;
	partcode = FindWindow(ev->where, &theWindow);
	switch (partcode) {
			/* inside the window's content area */
		case inContent:
			if (theWindow != FrontWindow()) {
					/* if it's not the frontmost window,
					then make it the frontmost window. */
				SelectWindow(theWindow);
			} else {
					/* otherwise, if it's a rendering window,
					pass the click along to the window. */
				Point where;
				SetPortWindowPort(theWindow);
				SetOrigin(0, 0);
				where = ev->where;
				GlobalToLocal(&where);
				if (IsARenderingWindow(theWindow))
					RWHandleMouseDown(theWindow, where);
			}
			break;
			
			/* menu bar clicks */
		case inMenuBar:
			ResetMenus();
			DoMenuCommand(MenuSelect(ev->where));
			break;
			
			/* track clicks in the close box */
		case inGoAway:
			if (TrackGoAway(theWindow, ev->where)) {
				if (IsARenderingWindow(theWindow))
					RWCloseWindow(theWindow);
				else if (IsAboutBox(theWindow))
					AboutBoxCloseWindow(theWindow);
			}
			break;
			
			/* allow window drags */
		case inDrag:
			{	Rect boundsRect = {0,0, 32000, 32000};
				DragWindow(theWindow, ev->where, &boundsRect);
			}
			break;
			
			/* allow window drags */
		case inGrow:
			{	Rect sizerect;
				long grow_result;
				SetRect(&sizerect, 300, 150, 32767, 32767);
				grow_result = GrowWindow(theWindow, ev->where, &sizerect);
				if (grow_result != 0) {
					SizeWindow(theWindow, LoWord(grow_result), HiWord(grow_result), true);
					SetPortWindowPort(theWindow);
					InvalWindowRect(theWindow, GetPortBounds(GetWindowPort(theWindow), &r));
					if (IsARenderingWindow(theWindow))
						RWRecalculateSize(theWindow);

				}
			}
			break;
			
			/* zoom box clicks.  NOTE:  since the rendering window
			always sets the standard rectangle to the 'best size' for
			displaying the current HTML window, the inZoomOut partcode
			will zoom the window to that size rather than the entire screen.*/
		case inZoomIn:
		case inZoomOut:
			SetPortWindowPort(theWindow);
			EraseRect(GetPortBounds(GetWindowPort(theWindow), &r));
			ZoomWindow(theWindow, partcode, true);
			SetPortWindowPort(theWindow);
			if (IsARenderingWindow(theWindow))
				RWRecalculateSize(theWindow);
			break;
			
	}
}


/* HandleEvent is the main event handling routine for the
	application.  ev points to an event record returned by
	WaitNextEvent. */
void HandleEvent(EventRecord *ev) {
	WindowPtr target;
		/* process menu key events */
	if (((ev->what == keyDown) || (ev->what == autoKey)) && ((ev->modifiers & cmdKey) != 0)) {
		ResetMenus();
		DoMenuCommand(MenuKey((char) (ev->message & charCodeMask)));
		ev->what = nullEvent;
	}
	
		/* process HR events.  NOTE: this call handles most of the events
		for the active HTML rendering object.  But, be careful it may set
		the clip region and origin of that window to an unknown state. */
	if (HRIsHREvent(ev))
		ev->what = nullEvent;
	
		/* process other event types */
	switch (ev->what) {
			/* the application may be switching in to the forground
			or into the background.  Either way, we need to activate
			the frontmost window accordingly. */
		case osEvt:
			target = FrontWindow();
			if (IsARenderingWindow(target))
				RWActivate(target, ((ev->message & resumeFlag) != 0));
			else if (IsAboutBox(target))
				AboutBoxActivate(target, ((ev->message & resumeFlag) != 0));
			break;
			
			/* for activate events we call the window's activate event
			handler. */
		case activateEvt:
			target = (WindowPtr) ev->message;
			if (IsARenderingWindow(target))
				RWActivate(target, ((ev->modifiers&1) != 0));
			else if (IsAboutBox(target))
				AboutBoxActivate(target, ((ev->modifiers&1) != 0));
			break;
			
			/* for update events we call the window's update event
			handler. if the window is of an unknown type, we ignore the
			event. */
		case updateEvt:
			target = (WindowPtr) ev->message;
			if (IsARenderingWindow(target))
				RWUpdate(target);
			else if (IsAboutBox(target))
				AboutBoxUpdate(target);
			else {
				BeginUpdate(target);
				EndUpdate(target);
			}
			break;	
			
			/* for mouse events we call the the HandleMouseDown routine
			defined above. */
		case mouseDown:
			HandleMouseDown(ev);
			break;
		
			/* for key down events we call the window's key down event
			handler. */
		case keyDown:
		case autoKey:
			target = FrontWindow();
			if (IsARenderingWindow(target))
				RWKeyDown(target, (char) (ev->message & charCodeMask));
			break;
		
			/* Apple events. */
		case kHighLevelEvent:
			AEProcessAppleEvent(ev);
			break;
	}
}


/* FDPIdleProcedure is the idle procedure called by AEInteractWithUser while we are waiting
	for the application to be pulled into the forground.  It simply passes the event along
	to HandleNextEvent */
static pascal Boolean MyIdleInteractProc(EventRecord *theEvent, long *sleepTime, RgnHandle *mouseRgn) {
	HandleEvent(theEvent);
	return ( ! gRunning ); /* quit waiting if we're not running */
}


/* ParamAlert is a general alert handling routine.  If Apple events exist, then it
	calls AEInteractWithUser to ensure the application is in the forground, and then
	it displays an alert after passing the s1 and s2 parameters to ParamText. */
short ParamAlert(short alertID, StringPtr s1, StringPtr s2) {
	AEIdleUPP aeIdleProc;
	OSStatus err;
	aeIdleProc = NewAEIdleUPP(MyIdleInteractProc);
	if (aeIdleProc == NULL) { err = memFullErr; goto bail; }
	err = AEInteractWithUser(kNoTimeOut, NULL, aeIdleProc);
	if (err != noErr) goto bail;
	ParamText(s1, s2, NULL, NULL);
	err = Alert(alertID, NULL);
	DisposeAEIdleUPP(aeIdleProc);
	return err;
bail:
	if (aeIdleProc != NULL) DisposeAEIdleUPP(aeIdleProc);
	return err;
}


/* MyGrowZone is called by the Memory Manager whenever it
	cannot fulfil a memory request.  Here, we try to get back
	enough memory for the request by asking the HTML rendering
	library to free up some cache space. */
static pascal long MyGrowZone(Size cbNeeded) {
	return HRFreeMemory(cbNeeded);
}



	/* the main program */

int main(void) {
	OSStatus err;
	Str255 errStr;
	
	InitCursor();
		
		/* install our event handlers */
	err = AEInstallEventHandler(kCoreEventClass, kAEOpenApplication, NewAEEventHandlerUPP(OpenAppleEventHandler), 0, false);
	if (err != noErr) goto bail;
	err = AEInstallEventHandler(kCoreEventClass, 'rapp', NewAEEventHandlerUPP(ReOpenAppleEventHandler), 0, false);
	if (err != noErr) goto bail;
	err = AEInstallEventHandler(kCoreEventClass, kAEOpenDocuments, NewAEEventHandlerUPP(OpenDocumentsEventHandler), 0, false);
	if (err != noErr) goto bail;
	err = AEInstallEventHandler(kCoreEventClass, kAEQuitApplication, NewAEEventHandlerUPP(QuitAppleEventHandler), 0, false);
	if (err != noErr) goto bail;

		/* set up the menu bar */
	SetMenuBar(GetNewMBar(kMenuBarID));
	DrawMenuBar();

		/* set up the rendering library */
	if ( ! HRHTMLRenderingLibAvailable() ) {
		ParamAlert(kNoRenderingLibErrorAlert, NULL, NULL);
		err = userCanceledErr;
		goto bail;
	}

		/* install our memory manger grow zone
		routine.  This will have to be done differently in
		Mac OS X... */
	SetGrowZone(NewGrowZoneUPP(MyGrowZone));

		/* initialize the rendering windows library */
	err = InitRenderingWindows();
	if (err != noErr) goto bail;

		/* run the app */
	while (gRunning) {
		EventRecord ev;
		
			/* get the next event */
		if ( ! WaitNextEvent(everyEvent, &ev,  GetCaretTime(), NULL))
			ev.what = nullEvent;
			
			/* call our handler to deal with it. */
		HandleEvent(&ev);

	}
	
		/* close all of our windows. */
	CloseRenderingWindows();
	EnsureAboutBoxIsClosed();
	
		/* unregister ourselves with the appearance manager. */
	UnregisterAppearanceClient();
	ExitToShell();
	return 0;
bail:
	NumToString(err, errStr);
	if (err != userCanceledErr)
		ParamAlert(kOpenApplicationErrorAlert, errStr, NULL);
	ExitToShell();
	return 0;
}
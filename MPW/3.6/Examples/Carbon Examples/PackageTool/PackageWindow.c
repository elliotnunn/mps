/*
    File: PackageWindow.c
    
    Description:
        Routines for managing the PackageWindow displayed by the
	PackageTool application.  This file also contains the routines used
	for converting folders into packages and packages back into folders.

    Copyright:
        © Copyright 1999 Apple Computer, Inc. All rights reserved.
    
    Disclaimer:
        IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
        ("Apple") in consideration of your agreement to the following terms, and your
        use, installation, modification or redistribution of this Apple software
        constitutes acceptance of these terms.  If you do not agree with these terms,
        please do not use, install, modify or redistribute this Apple software.

        In consideration of your agreement to abide by the following terms, and subject
        to these terms, Apple grants you a personal, non-exclusive license, under Apple’s
        copyrights in this original Apple software (the "Apple Software"), to use,
        reproduce, modify and redistribute the Apple Software, with or without
        modifications, in source and/or binary forms; provided that if you redistribute
        the Apple Software in its entirety and without modifications, you must retain
        this notice and the following text and disclaimers in all such redistributions of
        the Apple Software.  Neither the name, trademarks, service marks or logos of
        Apple Computer, Inc. may be used to endorse or promote products derived from the
        Apple Software without specific prior written permission from Apple.  Except as
        expressly stated in this notice, no other rights or licenses, express or implied,
        are granted by Apple herein, including but not limited to any patent rights that
        may be infringed by your derivative works or by other works in which the Apple
        Software may be incorporated.

        The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
        WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
        WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
        PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
        COMBINATION WITH YOUR PRODUCTS.

        IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
        CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
        GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
        ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION
        OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT
        (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN
        ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

    Change History (most recent first):
        Wed, Dec 22, 1999 -- created
*/



#include "PackageWindow.h"
#include "PackageTool.h"
#include "PackageUtils.h"
#include "Utilities.h"
//#include <Drag.h>
//#include <Controls.h>
//#include <Dialogs.h>
//#include <Appearance.h>
//#include <Icons.h>
//#include <Sound.h>
//#include <TextUtils.h>
//#include <PLStringFuncs.h>
//#include <Navigation.h>
//#include <ControlDefinitions.h>





enum {	/* picture displayed when selection is empty */
	kSpashPictResource = 128
};



	/* main window constants */
enum {
	kPackageDialogResource = 128,
	kPackageUserItem = 1,
	kFolderItem = 2,
	kPackageItem = 3,
	kSelectButtonItem = 4,
		/* kFolderIsPackage and kFolderIsFolder are used for
		internal tracking of the state of the kFolderItem and
		the kPackageItem dialog controls. */
	kFolderIsPackage = 100,	/* item being displayed is a package */
	kFolderIsFolder = 101	/* item being displayed is a folder */
};



	/* variables used to record properties of the main window */
DialogPtr gPackageWindow = NULL; /* a pointer to the main dialog */
PicHandle gSplashPict; /* splash image displayed in gIconBox when there is no file selected */
Rect gIconBox; /* area in the window where the information about the current file is drawn */ 
Rect gIconImage; /* area inside of gIconBox where the icon is drawn */
ControlHandle gPackageButton; /* control for setting gFolderTypeSelection to kFolderIsPackage */
ControlHandle gFolderButton; /* control for setting gFolderTypeSelection to kFolderIsFolder */
ControlHandle gSelectButton; /* control providing command equivalence to the select file menu command */



	/* variables used to record information about the file being displayed */
Boolean gFileInDisplay = false; /* true when gFileAlias contains an alias handle */
AliasHandle gFileAlias = NULL; /* an alias to the last file dragged into the gIconBox */
IconRef gIconRef = NULL; /* an icon services reference to an icon for the file */
short gFolderTypeSelection = kFolderIsFolder; /* determines the type of data we will provide for drags */
Boolean gPWActive = false;



	/* these variables are used both in the receive handler and inside of the
		tracking handler.  The following variables are shared between
		MyDragTrackingHandler and MyDragReceiveHandler.  */
static Boolean gApprovedDrag = false; /* set to true if the drag is approved */
static Boolean gInIconBox = false; /* set true if the drag is inside our drop box */



	/* procedure pointers used in the main window */
DragReceiveHandlerUPP gMainReceiveHandler = NULL; /* receive handler for the main dialog */
DragTrackingHandlerUPP gMainTrackingHandler = NULL; /* tracking handler for the main dialog */
UserItemUPP myUserItem; /* UPP for the icon's user item.  This routine draws into gIconBox */




Boolean IsPackageWindow(WindowPtr target) {
	return (target == GetDialogWindow(gPackageWindow));
}




/* ApproveDragReference is called by the drag tracking handler to determine
	if the contents of the drag can be handled by our receive handler.
	here, we only allow packages and folders.  */
static pascal OSErr ApproveDragReference(DragReference theDragRef, Boolean *approved) {
	OSErr err;
	UInt16 itemCount;
	DragAttributes dragAttrs;
	ItemReference theItem;
	HFSFlavor targetFile;
	long theSize;
	
		/* we cannot drag to our own window */
	if ((err = GetDragAttributes(theDragRef, &dragAttrs)) != noErr) goto bail;
	if ((dragAttrs & kDragInsideSenderWindow) != 0) { err = userCanceledErr; goto bail; }
	
		/* we only accept drags containing one item */
	if ((err = CountDragItems(theDragRef, &itemCount)) != noErr) goto bail;
	if (itemCount != 1) { err = paramErr; goto bail; }
		
		/* gather information about the drag & a reference to item one. */
	if ((err = GetDragItemReferenceNumber(theDragRef, 1, &theItem)) != noErr) goto bail;
		
		/* try to get a  HFSFlavor*/
	theSize = sizeof(HFSFlavor);
	err = GetFlavorData(theDragRef, theItem, flavorTypeHFS, &targetFile, &theSize, 0);
	if (err != noErr) goto bail;

		/* it must be a folder or a package */
	if (IdentifyPackage(&targetFile.fileSpec, NULL))
		*approved = true;
	else if (targetFile.fileCreator == 'MACS' && targetFile.fileType == 'fold')
		*approved = true;
	else {
		err = paramErr;
		goto bail;
	}
				
	return noErr;
bail:
		/* an error occured, clean up.  set result to false. */
	*approved = false;
	return err;
}




/* MyDragTrackingHandler is called for tracking the mouse while a drag is passing over our
	window.  if the drag is approved, then the drop box will be hilitied appropriately
	as the mouse passes over it.  */
static pascal OSErr MyDragTrackingHandler(DragTrackingMessage message, WindowPtr theWindow, void *refCon, DragReference theDragRef) {
		/* we're drawing into the image well if we hilite... */
	switch (message) {
	
		case kDragTrackingEnterWindow:
			{	Point mouse;
				gApprovedDrag = false;
				if (theWindow == FrontWindow()) {
					if (ApproveDragReference(theDragRef, &gApprovedDrag) != noErr) break;
					if ( ! gApprovedDrag ) break;
					SetPort(GetWindowPort(theWindow));
					GetMouse(&mouse);
					if (PtInRect(mouse, &gIconBox)) {  /* if we're in the box, hilite... */
						gInIconBox = (ShowDragHiliteBox(theDragRef, &gIconBox) == noErr);
					}
				}
			}
			break;

		case kDragTrackingInWindow:
			if (gApprovedDrag) {
				Point mouse;
				SetPort(GetWindowPort(theWindow));
				GetMouse(&mouse);
				if (PtInRect(mouse, &gIconBox)) {
					if ( ! gInIconBox) {  /* if we're entering the box, hilite... */
						gInIconBox = (ShowDragHiliteBox(theDragRef, &gIconBox) == noErr);
					}
				} else if (gInIconBox) {  /* if we're exiting the box, unhilite... */
					HideDragHilite(theDragRef);
					gInIconBox = false;
				}
			}
			break;

		case kDragTrackingLeaveWindow:
			if (gApprovedDrag && gInIconBox) {
				HideDragHilite(theDragRef);
			}
			gApprovedDrag = gInIconBox = false;
			break;
	}
	return noErr; // there's no point in confusing Drag Manager or its caller
}






/* MyDragReceiveHandler receives drags that are dropped into the
	main window.  here, we only receive packages or folders. */
static pascal OSErr MyDragReceiveHandler(WindowPtr theWindow, void *refcon, DragReference theDragRef) {
	ItemReference theItem;
	HFSFlavor targetFile;
	Size theSize;
	OSErr err;
	
		/* validate the drag.  Recall the receive handler will only be called after
		the tracking handler has received a kDragTrackingInWindow event.  As a result,
		the gApprovedDrag and gInIconBox will be defined when we arrive here.  Hence,
		there is no need to spend extra time validating the drag at this point. */
	if ( ! (gApprovedDrag && gInIconBox) ) { err = userCanceledErr; goto bail; }
	
		/* get the first item reference */
	err = GetDragItemReferenceNumber(theDragRef, 1, &theItem);
	if (err != noErr) goto bail;
		
		/* try to get a  HFSFlavor*/
	theSize = sizeof(HFSFlavor);
	err = GetFlavorData(theDragRef, theItem, flavorTypeHFS, &targetFile, &theSize, 0);
	if (err != noErr) goto bail;
	
		/* display the located file*/
	SetNewDisplay(&targetFile.fileSpec);
	return noErr;
bail:
	return err;
}







/* MyNavFilterProc This is the filter function we provide for the Navigation services
	dialogs. */
static pascal Boolean MyNavFilterProc( AEDesc* theItem, void* info, NavCallBackUserData callBackUD, NavFilterModes filterMode) {
	NavFileOrFolderInfo* theInfo;
	if ( theItem->descriptorType == typeFSS ) {
		theInfo = (NavFileOrFolderInfo*) info;
		return theInfo->isFolder;
	}
	return true;
}




/* NavEventCallBack is the event handling call back we provide for Navigation
	services.  It's presence is important so our windows will be updated appropriately
	when the navigation window is resized or moved. */
static pascal void NavEventCallBack( NavEventCallbackMessage callBackSelector,
			NavCBRecPtr callBackParms, NavCallBackUserData callBackUD) {
	if (callBackSelector == kNavCBEvent) {
		EventRecord *ev;
		ev = callBackParms->eventData.eventDataParms.event;
		if (ev->what == updateEvt || ev->what == activateEvt)
			HandleNextEvent(ev);
	}
}




/* SelectFolderOrPackage provides user interaction through calling
	navigation services that allows the user to choose a package or
	a folder for display in the main window.   */
OSStatus SelectFolderOrPackage(void) {
	NavDialogOptions dialogOptions;
	NavReplyRecord theReply;
	NavEventUPP eventf;
	NavObjectFilterUPP filterf;
	Boolean hasreply;
	OSStatus err;
	AEDescList documents;
	Boolean watchCursorON;
	Cursor theArrow;
		/* set up locals */
	eventf = NULL;
	filterf = NULL;
	hasreply = false;
	watchCursorON = false;
	BlockZero(&theReply, sizeof(theReply));
	AECreateDesc(typeNull, NULL, 0, &documents);
	GetQDGlobalsArrow(&theArrow);
		/* Let's put up the watch cursor while we *wait* for the navigation
		services window to appear. */
	SetCursor(*GetCursor(watchCursor));
	watchCursorON = true;
		/* allocate data */
	filterf = NewNavObjectFilterUPP(MyNavFilterProc);
	if (filterf == NULL) { err = memFullErr; goto bail; }
	eventf = NewNavEventUPP(NavEventCallBack);
	if (eventf == NULL) { err = memFullErr; goto bail; }
		/* set up dialog options */
	err = NavGetDefaultDialogOptions(&dialogOptions);
	if (err != noErr) goto bail;
		/* NOTE: Setting the kNavSupportPackages flag allows us to
		select Mac OS 9 packages. */
	dialogOptions.dialogOptionFlags = (kNavDontAutoTranslate | kNavSupportPackages);
		/* pick one or more files */
	err = NavChooseObject(NULL, &theReply, &dialogOptions, eventf, filterf,  NULL);
		/* reset the cursor to a known state*/
	SetCursor(&theArrow);
	watchCursorON = false;
		/* dispatch on our nav services reply */
	if (err != noErr) goto bail;
	if (!theReply.validRecord) { err = userCanceledErr; goto bail; }
	hasreply = true;
		/* standardize the document list returned by navigation services.
		Note:
		when you select a package in Navigation Services, it it will be returned
		as if it were a folder.  And, in Nav Services replies, that means the
		FSSpec referring to the folder will contain a zero length name and
		the directory ID of the folder.  The following routine automatically
		coerces all such Nav-format-FSSpecs into FSMakeFSSpec format
		and stores them into a list that has the same format as the list
		passed to your 'odoc' Apple event handler.  By doing this, we only
		need to have one OpenDocumentList routine in our application.  */
	err = NavReplyToODOCList(&theReply.selection, &documents);
	if (err != noErr) goto bail;
		/* if we have a valid reply, then call our
		open documents routine. */
	err = OpenDocumentList(&theReply.selection);
	if (err != noErr) goto bail;
		/* clean up the structures we allocated */
	NavDisposeReply(&theReply);
	DisposeNavEventUPP(eventf);
	DisposeNavObjectFilterUPP(filterf);
	return noErr;
bail:
	AEDisposeDesc(&documents);
	if (hasreply) NavDisposeReply(&theReply);
	if (eventf != NULL) DisposeNavEventUPP(eventf);
	if (filterf != NULL) DisposeNavObjectFilterUPP(filterf);
	if (watchCursorON) SetCursor(&theArrow);
	return err;
}




/* SetNewDisplay is called to set the file or folder being displayed in the main window.
	Here, structures are deallocated and an alias is saved referring to the file. 
	SetNewDisplay is called from the drag receive handler and since it is not
	safe to call "GetIconSuiteFromFinder()" from inside of the drag receive handler
	(it uses apple events), the flag is used to defer that operation
	until the next time ValidateFDPWindowDisplay.  ValidateFDPWindowDisplay is
	called from the main loop.  If targetFile is NULL, then the display is cleared. */
void SetNewDisplay(FSSpec *targetFile) {
	SInt16 theLabel;
	FSSpec mainPackageFile;
		/* remove the old file */
	if (gFileInDisplay) {
		DisposeHandle((Handle) gFileAlias);
		gFileAlias = NULL;
		ReleaseIconRef(gIconRef);
		gIconRef = NULL;
		gFileInDisplay = false;
		InvalWindowRect(GetDialogWindow(gPackageWindow), &gIconBox);
	}
		/* if there's no new file, we're done */
	if (targetFile == NULL) goto bail;
		/* create the new alias */
	if (NewAliasMinimal(targetFile, &gFileAlias) != noErr) goto bail;
		/* determine the kind of object we're displaying */
	if (IdentifyPackage(targetFile, &mainPackageFile)) {
		if (GetIconRefFromFile(&mainPackageFile, &gIconRef, &theLabel) != noErr) goto bail;
		gFolderTypeSelection = kFolderIsPackage;
	} else {
		if (GetIconRefFromFile(targetFile, &gIconRef, &theLabel) != noErr) goto bail;
		gFolderTypeSelection = kFolderIsFolder;
	}
		/* set up the controls */
	SetControlValue(gPackageButton, (gFolderTypeSelection == kFolderIsPackage ? 1 : 0));
	SetControlValue(gFolderButton, (gFolderTypeSelection == kFolderIsFolder ? 1 : 0));
	if (gPWActive) {
		ActivateControl(gPackageButton);
		ActivateControl(gFolderButton);
	} else {
		DeactivateControl(gPackageButton);
		DeactivateControl(gFolderButton);
	}
		/* update the window */
	InvalWindowRect(GetDialogWindow(gPackageWindow), &gIconBox);
		/* set the flag and return */
	gFileInDisplay = true;
	return;
bail:
	if (gFileAlias != NULL) DisposeHandle((Handle) gFileAlias);
	if (gIconRef != NULL) ReleaseIconRef(gIconRef);
	DeactivateControl(gPackageButton);
	DeactivateControl(gFolderButton);
	InvalWindowRect(GetDialogWindow(gPackageWindow), &gIconBox);
	gFileInDisplay = false;
}




/* ActivatePackageWindow handles an activate event for the
	package window. */
void ActivatePackageWindow(WindowPtr target, Boolean activate) {
	if (activate != gPWActive) {
		gPWActive = activate;
		if (gPWActive) {
			if (gFileInDisplay) {
				ActivateControl(gPackageButton);
				ActivateControl(gFolderButton);
			} else {
				DeactivateControl(gPackageButton);
				DeactivateControl(gFolderButton);
			}
			if (NavServicesAvailable()) {
				ActivateControl(gSelectButton);
			} else DeactivateControl(gSelectButton);
		} else {
			DeactivateControl(gPackageButton);
			DeactivateControl(gFolderButton);
			DeactivateControl(gSelectButton);
		}
		DrawDialog(gPackageWindow);
	}
}




/* PackageWindowUserItem draws the image in the drop box in the window.  If the window
	is not the active window, then the image is drawn grayed out.  If appearance
	is in use, then the drop box is drawn as a generic well. */
static pascal void PackageWindowUserItem(DialogPtr theWindow, DialogItemIndex itemNo) {
	RGBColor sForground, sBackground;
	RGBColor rgbWhite = {0xFFFF, 0xFFFF, 0xFFFF}, rgbBlack = {0, 0, 0}, rgbGray = {0x7FFF, 0x7FFF, 0x7FFF};
	FSSpec target;
	ThemeDrawState themeDrawState;
	Boolean wasChanged;
	WindowPtr wp;
		/* set up */
	wp = GetDialogWindow(theWindow);
	SetPort(GetWindowPort(wp));
		/* set the colors we're using for drawing */
	GetForeColor(&sForground);
	GetBackColor(&sBackground);
	RGBForeColor(&rgbBlack);
	RGBBackColor(&rgbWhite);
		/* draw the frame */
	themeDrawState = (gPWActive ? kThemeStateActive : kThemeStateInactive);
	DrawThemeGenericWell(&gIconBox, themeDrawState,  true);
		/* verify that we still have a file */
	if (ResolveAlias(NULL, gFileAlias, &target, &wasChanged) != noErr) {
		DisposeHandle((Handle) gFileAlias);
		gFileAlias = NULL;
		ReleaseIconRef(gIconRef);
		gIconRef = NULL;
		gFileInDisplay = false;
	}
		/* draw the file information */
	if (gFileInDisplay) {
		OSErr err;
		short baseLine;
		FontInfo fin;
		Str255 name;
			/* begin drawing */
		TextFont(kFontIDGeneva); /* geneva */
		TextSize(9);
		GetFontInfo(&fin);
			/* draw the icon image */
		err = PlotIconRef(&gIconImage, kAlignNone, kTransformNone, kIconServicesNormalUsageFlag, gIconRef);
			/* draw the file name */
		baseLine = gIconImage.bottom + fin.ascent;
		PLstrcpy(name, target.name);
		TruncString(gIconBox.right - gIconBox.left - 4, name,  truncEnd);
		MoveTo((gIconBox.left + gIconBox.right - StringWidth(name))/2, baseLine);
		DrawString(name);
			/* end drawing */
		TextFont(systemFont); /* back to the system font */
		TextSize(12);
	} else {
		Rect rPic;
		rPic = (**gSplashPict).picFrame;
		OffsetRect(&rPic, -rPic.left, -rPic.top);
		OffsetRect(&rPic, (gIconBox.left + gIconBox.right - rPic.right)/2, (gIconBox.top + gIconBox.bottom - rPic.bottom)/2);
		DrawPicture(gSplashPict, &rPic);
	}
		/* gray the image if we're in the background */
	if ( !  gPWActive )
		GrayOutBox(&gIconBox);
		/* restore previous colors */
	RGBForeColor(&sForground);
	RGBBackColor(&sBackground);
}




/* VerifyPackage is called before we attempt to convert a folder into
	a package.  This routine verifies that the contents of the folder are
	formatted correctly and the environmental conditions are right
	so that if the folder is turned into a package, the package will
	be formatted correctly.  *packageFolder is a file specification record
	pointing to the folder we would like to turn into a package.  *mustRebuildChain
	will be set to true by this routine if (a) the package's main file is in
	the package's root directory or (b) there is a chain of alias files
	and one of those files along the way is outside of the package's folder
	or is in the same directory as the previous one.  Normally, folder
	packages aren't created, but or those intersted in experimenting
	they can be created by holding down the option key.  if allowFolderPackages
	is true, then will not abort if the main object in a package happens
	to be a folder. */
static Boolean VerifyPackage(FSSpec *packageFolder, Boolean *mustRebuildChain, Boolean allowFolderPackages) {
	CInfoPBRec cat;
	OSErr err;
	long packageFolderDirID;
	Str255 name, errstr;
	FSSpec topAliasFile, nextAliasFile, prevAliasFile, mainTargetFile;
	Boolean targetIsFolder, wasAliased;
	long aliasCount;
	
		/* set up locals */
	aliasCount = 0;
	*mustRebuildChain = false;
	
		/* make sure file sharing is turned off */
	if ( FileSharingAppIsRunning() ) {
		GetIndString(errstr, kMainStringList, kFileSharingOn);
		ParamAlert(kPackageDidNotVerify, packageFolder->name, errstr);
		return false;
	}
		/* verify the package folder is a folder */
	BlockZero(&cat, sizeof(cat));
	cat.dirInfo.ioNamePtr = packageFolder->name;
	cat.dirInfo.ioVRefNum = packageFolder->vRefNum;
	cat.dirInfo.ioFDirIndex = 0;
	cat.dirInfo.ioDrDirID = packageFolder->parID;
	err = PBGetCatInfoSync(&cat);
	if (err != noErr) return false;
	if ((cat.dirInfo.ioFlAttrib & 16) == 0) {
		GetIndString(errstr, kMainStringList, kNotAFolder);
		ParamAlert(kPackageDidNotVerify, packageFolder->name, errstr);
		return false;
	}
	packageFolderDirID = cat.dirInfo.ioDrDirID;
	
		/* if the bundle flag is set and we arrive here,
		then we didn't recognize the package in the first
		place.  That's an internal error. */
	if ((cat.dirInfo.ioDrUsrWds.frFlags & kHasBundle) != 0) {
		GetIndString(errstr, kMainStringList, kBundleAlreadySet);
		ParamAlert(kPackageDidNotVerify, packageFolder->name, errstr);
		return false;
	}
	
		/* search for a top level alias file */
	BlockZero(&cat, sizeof(cat));
	cat.dirInfo.ioNamePtr = name;
	cat.dirInfo.ioVRefNum = packageFolder->vRefNum;
	cat.dirInfo.ioFDirIndex = 1;
	cat.dirInfo.ioDrDirID = packageFolderDirID;
	while (PBGetCatInfoSync(&cat) == noErr) {
		if (((cat.dirInfo.ioFlAttrib & 16) == 0) && ((cat.dirInfo.ioDrUsrWds.frFlags & kIsAlias) != 0)) {
				/* increment the alias counter.  There can be only one. */
			aliasCount += 1;
			if (aliasCount > 1) {
				GetIndString(errstr, kMainStringList, kMoreThanOneAlias);
				ParamAlert(kPackageDidNotVerify, packageFolder->name, errstr);
				return false;
			}
				/* get a reference to the alias file */
			err = FSMakeFSSpec(packageFolder->vRefNum, packageFolderDirID, name, &topAliasFile);
			if (err != noErr) return false;
				/* chain through all alias files one at a time making sure that each
				file is in the package heirarchy.  Set the *mustRebuildChain flag if
				any two files are in the same directory.  We must do this because
				relative alias files do not work when any two files in the chain
				are in the same directory.  */
			nextAliasFile = topAliasFile;
			while (true) {
					/* move on to the next file */
				prevAliasFile = nextAliasFile;
				err = ResolveAliasFile(&nextAliasFile, false, &targetIsFolder, &wasAliased);
				if (err != noErr) {
					GetIndString(errstr, kMainStringList, kBrokenAlias);
					ParamAlert(kPackageDidNotVerify, packageFolder->name, errstr);
					return false;
				}
					/* exit this loop once we've found the main target file */
				if ( ! wasAliased ) {
					mainTargetFile = nextAliasFile; /* we found the main target file */
					break;
				}
					/* if any one of the files is in the same directory as the previous one,
					then the alias chain needs to be rebuilt.... */
				if ( prevAliasFile.parID == nextAliasFile.parID ) {
					*mustRebuildChain |= true;
				}
					/* ......and, if it's an alias file somewhere between the first alias and
					the main target file AND it is outside of the package directory,
					then the alias chain needs to be rebuilt.  */
				if ( ! FSSpecIsInDirectory(&nextAliasFile, packageFolder->vRefNum, packageFolderDirID) ) {
					*mustRebuildChain |= true;
				}
			}
				/* ....but we only need an alias chain if the package's main file
				is in the package's root directory.  i.e., it's in the same directory
				as the top level alias file. */
			if ( mainTargetFile.parID != topAliasFile.parID ) {
				*mustRebuildChain = false;
			}
				/* make sure the main target file is inside of the package directory */
			if ( ! FSSpecIsInDirectory(&mainTargetFile, packageFolder->vRefNum, packageFolderDirID) ) {
				GetIndString(errstr, kMainStringList, kMainOutsideOfPackage);
				ParamAlert(kPackageDidNotVerify, packageFolder->name, errstr);
				return false;
			}
				/* special permission (the option key) is required to make folder packages. */
			if (targetIsFolder) {
					/* If we're allowing folder packages, make sure it's
					not a package folder. */
				if (allowFolderPackages) {
					CInfoPBRec targetCat;
					BlockZero(&targetCat, sizeof(targetCat));
					targetCat.dirInfo.ioNamePtr = mainTargetFile.name;
					targetCat.dirInfo.ioVRefNum = mainTargetFile.vRefNum;
					targetCat.dirInfo.ioFDirIndex = 0;
					targetCat.dirInfo.ioDrDirID = mainTargetFile.parID;
					err = PBGetCatInfoSync(&targetCat);
					if (err != noErr) return false;
					if ( ((targetCat.dirInfo.ioDrUsrWds.frFlags & kHasBundle) != 0) ) {
						GetIndString(errstr, kMainStringList, kAliasRefersToPackage);
						ParamAlert(kPackageDidNotVerify, mainTargetFile.name, errstr);
						return false;
					}
				} else {
					GetIndString(errstr, kMainStringList, kAliasRefersToFolder);
					ParamAlert(kPackageDidNotVerify, mainTargetFile.name, errstr);
					return false;
				}
			}
		} /* if alias */
		cat.dirInfo.ioFDirIndex++;
		cat.dirInfo.ioDrDirID = packageFolderDirID;
	} /* of directory loop */
	
		/* make sure we found at least one alias */
	if (aliasCount == 0) {
		GetIndString(errstr, kMainStringList, kNoAliasPresent);
		ParamAlert(kPackageDidNotVerify, packageFolder->name, errstr);
		return false;
	}
		/* all tests successful */
	return true;
}




/* FolderToPackage converts a folder into a Mac OS 9 package.  This routine
	assumes the folder is set up correctly (i.e. VerifyPackage was called for
	the folder and it returned true.  if constructChain is true, then a chain
	of relative alias files will be created.  This should be the value returned
	by VerifyPackage in the *mustRebuildChain parameter.  A chain of alias
	files must be created when the package's main file is stored in the
	package's root folder.  This is because there is a long standing Alias Manager
	but that prevents relative alias files from being resolved when the
	alias file and the target file are in the same folder. */
static OSStatus FolderToPackage(FSSpec *packageFolder, Boolean constructChain) {
	CInfoPBRec cat;
	OSErr err;
	FSSpec topAliasFile, mainTargetFile, chainAliasFile, chainAliasFolder;
	long packageFolderDirID, chainAliasFolderDirID;
	Boolean foundAlias, targetIsFolder, wasAliased;
	Str255 name, folderName, aliasName, errstr;
		/* set up locals */
	foundAlias = false;
		/* find out the folder's directory ID */
	BlockZero(&cat, sizeof(cat));
	cat.dirInfo.ioNamePtr = packageFolder->name;
	cat.dirInfo.ioVRefNum = packageFolder->vRefNum;
	cat.dirInfo.ioFDirIndex = 0;
	cat.dirInfo.ioDrDirID = packageFolder->parID;
	err = PBGetCatInfoSync(&cat);
	if (err != noErr) return err;
	packageFolderDirID = cat.dirInfo.ioDrDirID;
		/* search for a top level alias file */
	BlockZero(&cat, sizeof(cat));
	cat.dirInfo.ioNamePtr = name;
	cat.dirInfo.ioVRefNum = packageFolder->vRefNum;
	cat.dirInfo.ioFDirIndex = 1;
	cat.dirInfo.ioDrDirID = packageFolderDirID;
	while (PBGetCatInfoSync(&cat) == noErr) {
		if (((cat.dirInfo.ioFlAttrib & 16) == 0) && ((cat.dirInfo.ioDrUsrWds.frFlags & kIsAlias) != 0)) {
			foundAlias = true;
			break;
		}
		cat.dirInfo.ioFDirIndex++;
		cat.dirInfo.ioDrDirID = packageFolderDirID;
	}
	if ( ! foundAlias) return paramErr;
		/* resolve the alias file to the main target file */
	err = FSMakeFSSpec(packageFolder->vRefNum, packageFolderDirID, name, &topAliasFile);
	if (err != noErr) return err;
	mainTargetFile = topAliasFile;
	err = ResolveAliasFile(&mainTargetFile, true, &targetIsFolder, &wasAliased);
	if (err != noErr) return err;
		/* create a sub directory if needed */
	if (constructChain) {
			/* set up the folder FSSpec */
		GetIndString(folderName, kMainStringList, kAliasRedirectFolderName);
		err = FSMakeFSSpec(packageFolder->vRefNum, packageFolderDirID, folderName, &chainAliasFolder);
		if (err == fnfErr) err = noErr;
		if (err != noErr) return err;
			/* find or create a sub directory for the indirect alias. */
		err = FSpGetDirID(&chainAliasFolder, &chainAliasFolderDirID);
		if (err != noErr)
			err = FSpDirCreate(&chainAliasFolder, smSystemScript, &chainAliasFolderDirID);
		if (err != noErr) {
			GetIndString(errstr, kMainStringList, kErrorRedirectingAlias);
			ParamAlert(kRerouteFailedAlert, errstr, NULL);
			return err;
		}
			/* create a reference to the indirect alias file */
		GetIndString(aliasName, kMainStringList, kRedirectAliasName);
		err = FSMakeFSSpec(packageFolder->vRefNum, chainAliasFolderDirID, aliasName, &chainAliasFile);
		if (err == fnfErr) err = noErr;
		if (err != noErr) return err;
			/* create an indirect alias file referencing the main target file */
		err = UpdateRelativeAliasFile(&chainAliasFile, &mainTargetFile, true);
		if (err != noErr) return err;
			/* create an alias file referring to the indirect file. */
		err = UpdateRelativeAliasFile(&topAliasFile, &chainAliasFile, false);
		if (err != noErr) return err;
	} else {
			/* update the alias file to a relative path */
		err = UpdateRelativeAliasFile(&topAliasFile, &mainTargetFile, false);
		if (err != noErr) return err;
	}
		/* set the package flag */
	cat.dirInfo.ioNamePtr = packageFolder->name;
	cat.dirInfo.ioVRefNum = packageFolder->vRefNum;
	cat.dirInfo.ioFDirIndex = 0;
	cat.dirInfo.ioDrDirID = packageFolder->parID;
	err = PBGetCatInfoSync(&cat);
	if (err != noErr) return err;
	cat.dirInfo.ioDrDirID = packageFolder->parID;
	cat.dirInfo.ioDrUsrWds.frFlags |= kHasBundle;
	err = PBSetCatInfoSync(&cat);
	if (err != noErr) return err;
	return noErr;
}




/* PackageToFolder converts a Mac OS 9 package into a regular
	folder.  It does this by clearing the package bit in the folder's
	Finder flags. */
static OSStatus PackageToFolder(FSSpec *target) {
	CInfoPBRec cat;
	OSErr err;
	cat.dirInfo.ioNamePtr = target->name;
	cat.dirInfo.ioVRefNum = target->vRefNum;
	cat.dirInfo.ioFDirIndex = 0;
	cat.dirInfo.ioDrDirID = target->parID;
	err = PBGetCatInfoSync(&cat);
	if (err != noErr) return err;
	cat.dirInfo.ioDrDirID = target->parID;
	cat.dirInfo.ioDrUsrWds.frFlags &= ~ kHasBundle;
	err = PBSetCatInfoSync(&cat);
	return err;
}





/* HitPackageWindow is called when the dialog manager's DialogSelect indicates
	that an item in the main finder drag pro window has been hit.  Here,
	either we begin a drag, or we adjust the promise/regular hfs controls */
void HitPackageWindow(DialogPtr theDialog, EventRecord *event, short itemNo) {
	switch (itemNo) {
		case kPackageUserItem:
			break;
			
		case kFolderItem: /* turn it into a folder */
			if (gFolderTypeSelection != kFolderIsFolder) {
				FSSpec target;
				Boolean wasChanged;
				if (ResolveAlias(NULL, gFileAlias, &target, &wasChanged) != noErr) {
					SetNewDisplay(NULL);
				} else {
					if (PackageToFolder(&target) == noErr) {
						SetNewDisplay(&target); /* update the view */
						ShowChangesInFinderWindow(target.vRefNum, target.parID);
					}
				}
			}
			break;
			
		case kPackageItem: /* turn it into a package */
			if (gFolderTypeSelection != kFolderIsPackage) {
				FSSpec target;
				Boolean wasChanged;
				if (ResolveAlias(NULL, gFileAlias, &target, &wasChanged) != noErr) {
					SetNewDisplay(NULL);
				} else {
					Boolean mustRebuildChain;
					if ( VerifyPackage(&target, &mustRebuildChain, ((event->modifiers & optionKey) != 0)) ) {
						OSStatus err;
						err = FolderToPackage(&target, mustRebuildChain);
						if (err != noErr) {
							Str255 errStr;
							NumToString(err, errStr);
							ParamAlert(kFailedToCreatePackage, errStr, target.name);
						} else {
							SetNewDisplay(&target); /* update the view */
							ShowChangesInFinderWindow(target.vRefNum, target.parID);
						}
					}
				}
			}
			break;
			
		case kSelectButtonItem:	/* call the select routine defined in PackageTool.c */
			SelectFolderOrPackage();
			break;
	}
}




/* CreatePackageWindow creates the package window.  If it cannot be
	created, then an error is returned. */
OSStatus CreatePackageWindow(void) {
	OSErr err;
	Boolean installedTracker, installedReceiver;
	short itemt;
	Rect itemb;
	Handle itemh;
	DialogPtr dialog;
	long itemSize;
	Point where;
	
		/* set up locals for recovery */
	dialog = NULL;
	installedTracker = installedReceiver = false;
	
		/* get other resources */
	gSplashPict = GetPicture(kSpashPictResource);
	if (gSplashPict == NULL) { err = resNotFound; goto bail; }
		/* create the dialog */
	dialog = GetNewDialog(kPackageDialogResource, NULL, (WindowPtr) (-1));	
	if (dialog == NULL) { err = memFullErr; goto bail; }
	
		/* grab and set up our dialog items */
	GetDialogItem(dialog, kPackageUserItem, &itemt, (Handle*) &itemh, &gIconBox);
	myUserItem = NewUserItemUPP(PackageWindowUserItem);
	if (myUserItem == NULL) { err = memFullErr; goto bail; }
	SetDialogItem(dialog, kPackageUserItem, userItem, (Handle) myUserItem, &gIconBox);
	GetDialogItem(dialog, kFolderItem, &itemt, (Handle*) &gFolderButton, &itemb);
	GetDialogItem(dialog, kPackageItem, &itemt, (Handle*) &gPackageButton, &itemb);
	GetDialogItem(dialog, kSelectButtonItem, &itemt, (Handle*) &gSelectButton, &itemb);
		
		/* set initial control values */
	SetControlValue(gPackageButton, (gFolderTypeSelection == kFolderIsPackage ? 1 : 0));
	SetControlValue(gFolderButton, (gFolderTypeSelection == kFolderIsFolder ? 1 : 0));
	DeactivateControl(gPackageButton);
	DeactivateControl(gFolderButton);

		/* calculate the drawn icon's boundary */
	SetRect(&gIconImage, 0, 0, 32, 32);
	OffsetRect(&gIconImage, (gIconBox.right + gIconBox.left - 32) / 2, gIconBox.top + 32);

		/* install the drag handlers */
	gMainTrackingHandler = NewDragTrackingHandlerUPP(MyDragTrackingHandler);
	if (gMainTrackingHandler == NULL) { err = memFullErr; goto bail; }
	err = InstallTrackingHandler(gMainTrackingHandler, GetDialogWindow(dialog), NULL);
	if (err != noErr) { err = memFullErr; goto bail; }
	installedTracker = true;

	gMainReceiveHandler = NewDragReceiveHandlerUPP(MyDragReceiveHandler);
	if (gMainReceiveHandler == NULL) { err = memFullErr; goto bail; }
	err = InstallReceiveHandler(gMainReceiveHandler, GetDialogWindow(dialog), NULL);
	if (err != noErr) { err = memFullErr; goto bail; }
	installedReceiver = true;

		/* position the window, if necessary */
	if (GetCollectionItem(GetCollectedPreferences(),  'QDPt', 1, (itemSize = sizeof(where), &itemSize),  &where) == noErr) {
		MoveWindow(GetDialogWindow(dialog), where.h, where.v, true);
	}
		/* done, window complete */
	ShowWindow(GetDialogWindow(dialog));
	gPackageWindow = dialog;
	return noErr;

bail:
	if (installedReceiver)
		RemoveReceiveHandler(gMainReceiveHandler, GetDialogWindow(dialog));
	if (installedTracker)
		RemoveTrackingHandler(gMainTrackingHandler, GetDialogWindow(dialog));
	if (dialog != NULL) DisposeDialog(dialog);
	return err;
}





/* ClosePackageWindow closes the package window and disposes of
	any structures allocated when it was opened. */
void ClosePackageWindow(void) {
	Point where;
	WindowPtr wp;
	CGrafPtr gp;
	Rect r;
	wp = GetDialogWindow(gPackageWindow);
	gp = GetWindowPort(wp);
	SetPort(gp);
	GetPortBounds(gp, &r);
	where = * (Point*) &r;
	LocalToGlobal(&where);
	AddCollectionItem(GetCollectedPreferences(), 'QDPt', 1, sizeof(where), &where);
	SetNewDisplay(NULL);
	DisposeDialog(gPackageWindow);
}


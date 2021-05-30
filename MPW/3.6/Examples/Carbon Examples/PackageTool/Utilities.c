/*
    File: Utilities.c
    
    Description:
        This file contains the a number of utility routines used in the
	PackagTool example.  they have been moved to this file
	to simplify the example.
	
	PackageTool is an application illustrating how to create application
	packages in Mac OS 9.  It provides a simple interface for converting
	correctly formatted folders into packages and vice versa.

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
        Fri, Dec 17, 1999 -- created
*/


#include "Utilities.h"
//#include <QuickDraw.h>
//#include <Gestalt.h>
//#include <Palettes.h>
//#include <Threads.h>
//#include <fp.h>
//#include <FinderRegistry.h>
//#include <Resources.h>
//#include <Processes.h>

/* ValidFSSpec verifies that *spec refers is formatted correctly, and it
	verifies that it refers to an existing file in an existing directory on
	and existing volume. If *spec is valid, the function returns noErr,
	otherwise an error is returned. */
OSErr ValidFSSpec(FSSpec *spec) {
	FInfo fndrInfo;
		/* check the name's size */
	if (spec->name[0] + (sizeof(FSSpec) - sizeof(spec->name)) > sizeof(FSSpec)) return paramErr;
		/* ckeck if it refers to a file */
	return FSpGetFInfo(spec, &fndrInfo);
}


/* ResolveAliasQuietly resolves an alias using a fast search with no user interaction.  Our main loop
	periodically resolves gFileAlias comparing the result to gTargetFile to keep the display up to date.
	As a result, we would like the resolve alias call to be as quick as possible AND since the application
	may be in the background when  it is called, we don't want any user interaction. */
OSErr ResolveAliasQuietly(ConstFSSpecPtr fromFile, AliasHandle alias, FSSpec *target, Boolean *wasChanged) {
	short aliasCount;
	Boolean needsUpdate;
	OSErr err;
		/* set up locals */
	aliasCount = 1;
	needsUpdate = false;
	*wasChanged = false;
		/* call MatchAlias to resolve the alias.  
			kARMNoUI = no user interaction,
			kARMSearch = do a fast search. */
	err = MatchAlias(NULL, (kARMNoUI | kARMSearch), alias, &aliasCount, target, &needsUpdate, NULL, NULL);
	if (err == noErr) {
			/* if the alias was changed, update it. */
		err = UpdateAlias(fromFile, target, alias, wasChanged);
	}
	return err;
}




/* GrayOutBox grays out an area of the screen in the current grafport.  
	*theBox is in local coordinates in the current grafport. This routine
	is for direct screen drawing only.  */
void GrayOutBox(Rect *theBox) {
	long response;
	Rect globalBox;
	GDHandle maxDevice;
	RGBColor rgbWhite = {0xFFFF, 0xFFFF, 0xFFFF}, rgbBlack = {0, 0, 0}, sForground, sBackground;
	PenState penSave;
		/* save the current drawing state */
	GetPenState(&penSave);
		/* if no color quickdraw, fail...*/
	if (Gestalt(gestaltQuickdrawVersion, &response) != noErr) response = 0;
	if (response >= gestalt8BitQD) {
			/* get the device for the rectangle */
		globalBox = *theBox;
		LocalToGlobal((Point*) &globalBox.top);
		LocalToGlobal((Point*) &globalBox.bottom);
		maxDevice = GetMaxDevice(&globalBox);
		if (maxDevice != NULL) {
				/* calculate the best gray */
			if ( GetGray(maxDevice, &rgbWhite, &rgbBlack)) {
					/* draw over the area in gray using addMax transfer mode */
				GetForeColor(&sForground);
				GetBackColor(&sBackground);
				RGBForeColor(&rgbBlack);
				RGBBackColor(&rgbWhite);
				PenMode(addMax);
				PaintRect(theBox);
				RGBForeColor(&sForground);
				RGBBackColor(&sBackground);
					/* restore the pen state and leave */
				SetPenState(&penSave);
				return;
			}
		}
	}
		/* fall through to using the gray pattern */
	{	Pattern ggray;
		GetQDGlobalsGray(&ggray);
		PenPat(&ggray);
		PenMode(notPatBic);
		PaintRect(theBox);
		SetPenState(&penSave);
	}
}


/* ShowDragHiliteBox is called to hilite the drop box area in the
	main window.  Here, we draw a 3 pixel wide border around *boxBounds.  */
OSErr ShowDragHiliteBox(DragReference theDragRef, Rect *boxBounds) {
	RgnHandle boxRegion, insetRegion;
	OSErr err;
	Rect box;
		/* set up locals */
	boxRegion = insetRegion = NULL;
		/* create the region */
	if ((boxRegion = NewRgn()) == NULL) { err = memFullErr; goto bail; }
	if ((insetRegion = NewRgn()) == NULL) { err = memFullErr; goto bail; }
	box = *boxBounds;
	InsetRect(&box, -5, -5);
	RectRgn(boxRegion, &box);
	InsetRect(&box, 3, 3);
	RectRgn(insetRegion, &box);
	DiffRgn(boxRegion, insetRegion, boxRegion);
		/* hilite the region */
	err = ShowDragHilite(theDragRef, boxRegion, true);
bail:
		/* clean up and leave */
	if (boxRegion != NULL) DisposeRgn(boxRegion);
	if (insetRegion != NULL) DisposeRgn(insetRegion);
	return err;
}


/* FSpGetDirID returns the directory ID number for the directory
	pointed to by the file specification record *spec.  */
OSErr FSpGetDirID(FSSpec *spec, long *theDirID) {
	CInfoPBRec cat;
	OSErr err;
	BlockZero(&cat, sizeof(cat));
	cat.dirInfo.ioNamePtr = spec->name;
	cat.dirInfo.ioVRefNum = spec->vRefNum;
	cat.dirInfo.ioFDirIndex = 0;
	cat.dirInfo.ioDrDirID = spec->parID;
	err = PBGetCatInfoSync(&cat);
	if (err != noErr) return err;
	if ((cat.dirInfo.ioFlAttrib & 16) == 0) return paramErr;
	*theDirID = cat.dirInfo.ioDrDirID;
	return noErr;
}

/* UpdateRelativeAliasFile updates the alias file located at aliasDest referring to the targetFile.
	relative path information is stored in the new file.  It is appropriate for targetFile to refer
	to either a file or a folder.  */
OSErr UpdateRelativeAliasFile(FSSpec *theAliasFile, FSSpec *targetFile, Boolean createIfNecessary) {
	CInfoPBRec cat;
	FInfo fndrInfo;
	AliasHandle theAlias;
	Boolean wasChanged;
	short rsrc;
	OSErr err;
	 	/* set up locals */
	rsrc = -1;
		/* set up the Finder information record */
	BlockZero(&fndrInfo, sizeof(fndrInfo));
	BlockZero(&cat, sizeof(cat));
	cat.dirInfo.ioNamePtr = targetFile->name;
	cat.dirInfo.ioVRefNum = targetFile->vRefNum;
	cat.dirInfo.ioFDirIndex = 0;
	cat.dirInfo.ioDrDirID = targetFile->parID;
	err = PBGetCatInfoSync(&cat);
	if (err != noErr) goto bail;
	if ((cat.dirInfo.ioFlAttrib & 16) == 0) {	/* file alias */
		switch (cat.hFileInfo.ioFlFndrInfo.fdType) {
			case 'APPL': fndrInfo.fdType = kApplicationAliasType; break;
			case 'APPC': fndrInfo.fdType = kApplicationCPAliasType; break;
			case 'APPD': fndrInfo.fdType = kApplicationDAAliasType; break;
			default: fndrInfo.fdType = cat.hFileInfo.ioFlFndrInfo.fdType; break;
		}
		fndrInfo.fdCreator = cat.hFileInfo.ioFlFndrInfo.fdCreator;
	} else {
		fndrInfo.fdType = kContainerFolderAliasType;
		fndrInfo.fdCreator = 'MACS';
	}
	fndrInfo.fdFlags = kIsAlias;
	 	/* set the file information or the new file */
	err = FSpSetFInfo(theAliasFile, &fndrInfo);
	if ((err == fnfErr) && createIfNecessary) {
		FSpCreateResFile( theAliasFile, fndrInfo.fdCreator, fndrInfo.fdType, smSystemScript);
		if ((err = ResError()) != noErr) goto bail;
		err = FSpSetFInfo( theAliasFile, &fndrInfo);
		if (err != noErr) goto bail;
	} else if (err != noErr) goto bail;
	 	/* save the resource */
	rsrc = FSpOpenResFile(theAliasFile, fsRdWrPerm);
	if (rsrc == -1) { err = ResError(); goto bail; }
	UseResFile(rsrc);
	theAlias = (AliasHandle) Get1IndResource(rAliasType, 1);
	if (theAlias != NULL) {
		err = UpdateAlias(theAliasFile, targetFile, theAlias, &wasChanged);
		if (err != noErr) goto bail;
		if (wasChanged)
			ChangedResource((Handle) theAlias);
	} else {
		err = NewAlias(theAliasFile, targetFile, &theAlias);
		if (err != noErr) goto bail;
		AddResource((Handle) theAlias, rAliasType, 0, theAliasFile->name);
		if ((err = ResError()) != noErr) goto bail;
	}
	CloseResFile(rsrc);
	rsrc = -1;
		/* done */
	return noErr;
 bail:
	if (rsrc != -1) CloseResFile(rsrc);
	return err;
 }
 
 
enum {
	kFileSharingSignature = 'hhgg' /* Macintosh File Sharing */
};

/* FileSharingAppIsRunning returns true if the file sharing
	extension is running. */
Boolean FileSharingAppIsRunning(void) {
	ProcessSerialNumber psn;
	ProcessInfoRec pinfo;

	psn.highLongOfPSN = psn.lowLongOfPSN = kNoProcess;
	pinfo.processInfoLength = sizeof(ProcessInfoRec);
	pinfo.processName = NULL;
	pinfo.processAppSpec = NULL;
	while (GetNextProcess(&psn) == noErr)
		if (GetProcessInformation(&psn, &pinfo) == noErr)
			if (pinfo.processSignature == kFileSharingSignature)
				return true;
	return false;
}


/* FSSpecIsInDirectory returns true if the file system object
	referred to by theSpec is somewhere in the directory referred
	to by (vRefNum, dirID) */
Boolean FSSpecIsInDirectory(FSSpec *theSpec, short vRefNum, long dirID) {
	CInfoPBRec cat;
	HParamBlockRec fvol, dirvol;
	long currentDir;
		/* check the volumes */
	fvol.volumeParam.ioVRefNum = theSpec->vRefNum;
	fvol.volumeParam.ioNamePtr = NULL;
	fvol.volumeParam.ioVolIndex = 0;
	if (PBHGetVInfoSync(&fvol)) return false;
	dirvol.volumeParam.ioVRefNum = vRefNum;
	dirvol.volumeParam.ioNamePtr = NULL;
	dirvol.volumeParam.ioVolIndex = 0;
	if (PBHGetVInfoSync(&dirvol) != noErr) return false;
	if (fvol.volumeParam.ioVRefNum != dirvol.volumeParam.ioVRefNum) return false;
		/* check if the directory is one of the file's parents */
	currentDir = theSpec->parID;
	while (true) {
		if (dirID == currentDir) return true;
		if (currentDir == 2) return false;
			/* make sure it refers to a file in the package's directory */
		BlockZero(&cat, sizeof(cat));
		cat.dirInfo.ioNamePtr = NULL;
		cat.dirInfo.ioVRefNum = theSpec->vRefNum;
		cat.dirInfo.ioFDirIndex = -1;
		cat.dirInfo.ioDrDirID = currentDir;
		if (PBGetCatInfoSync(&cat) != noErr) return false;
		currentDir = cat.dirInfo.ioDrParID;
	}
}


/* FSSpecIsAFolder returns true if the FSSpec pointed
	to by target refers to a folder. */
Boolean FSSpecIsAFolder(FSSpec *target) {
	CInfoPBRec cat;
	OSErr err;
		/* check the target's flags */
	cat.dirInfo.ioNamePtr = target->name;
	cat.dirInfo.ioVRefNum = target->vRefNum;
	cat.dirInfo.ioFDirIndex = 0;
	cat.dirInfo.ioDrDirID = target->parID;
	err = PBGetCatInfoSync(&cat);
	if (err != noErr) return false;
	return ((cat.dirInfo.ioFlAttrib & 16) != 0);
}


/* ShowChangesInFinderWindow asks the finder redraw a directory
	window by either sending a update container event to the
	finder if this facility exists, or by bumping the parent directorie's
	modification date */
OSErr ShowChangesInFinderWindow(short vRefNum, long dirID) {
    OSErr err;
    long response;
	CInfoPBRec cat;
	Str255 name;
		/* get information about the directory */
	cat.hFileInfo.ioNamePtr = name;
	cat.hFileInfo.ioVRefNum = vRefNum;
	cat.hFileInfo.ioDirID = dirID;
	cat.hFileInfo.ioFDirIndex = -1;
	if ((err = PBGetCatInfoSync(&cat)) != noErr) return err;
		/* determine what we can do... */
	if (Gestalt(gestaltFinderAttr, &response) != noErr) response = 0;
	if ((response & (1<<gestaltOSLCompliantFinder)) != 0) {
    	AppleEvent the_apple_event, the_reply;
		AEAddressDesc target_desc;
		FSSpec spec;
		OSType app_creator;
		long actualSize, the_error;
		DescType actualType;
	
			/* set up a recoverable state */
		AECreateDesc(typeNull, NULL, 0, &the_apple_event);
		AECreateDesc(typeNull, NULL, 0, &target_desc);
		AECreateDesc(typeNull, NULL, 0, &the_reply);

			/* create an update event targeted at the finder */
		app_creator = 'MACS';
		err = AECreateDesc(typeApplSignature, (Ptr) &app_creator,
			sizeof(app_creator), &target_desc);
		if (err != noErr) goto send_update_abort;
		err = AECreateAppleEvent(kAEFinderSuite, kAEUpdate,
			&target_desc, kAutoGenerateReturnID,
			kAnyTransactionID, &the_apple_event);
		if (err != noErr) goto send_update_abort;

			/* add the FSSpec parameter */
		err = FSMakeFSSpec(vRefNum, cat.dirInfo.ioDrParID, name, &spec);
		if (err != noErr) goto send_update_abort;
		err = AEPutParamPtr(&the_apple_event, keyDirectObject, typeFSS, &spec, sizeof(FSSpec));
		if (err != noErr) goto send_update_abort;

			/* send the apple event */
		err = AESend(&the_apple_event, &the_reply, kAENoReply,
			kAENormalPriority, kNoTimeOut, NULL, NULL);
		
		err = AEGetParamPtr(&the_reply, keyErrorNumber, typeLongInteger,
			&actualType, &the_error, 4, &actualSize);
		if (err == errAEDescNotFound)
			err = noErr;
		else if (err == noErr)
			err = the_error;

	send_update_abort:
		AEDisposeDesc(&the_apple_event);
		AEDisposeDesc(&target_desc);
		AEDisposeDesc(&the_reply);

	} else {	/* bump the date for the directory so the finder notices */
		unsigned long secs;
		GetDateTime(&secs);
		cat.hFileInfo.ioFlMdDat = (secs == cat.hFileInfo.ioFlMdDat) ? (++secs) : (secs);
		cat.hFileInfo.ioDirID = cat.dirInfo.ioDrParID;
		err = PBSetCatInfoSync(&cat);
	}
	return err;
}


/* NavReplyToODOCList converts a document list returned by a Navigation Services
	dialog into a document list structure that is the same format as the one
	the system sends to your application's open document Apple event handler
	routine.  Replies returned by Navigation Services may contain special
	references to folders that may be incompatible with some document opening
	strategies or routines.  By converting navigation replies into 'odoc' list
	format, your application only needs to implement one document opening
	routine that receives dcoument lists from both Apple events and navigation
	services.  NOTE:  this is really only an issue if your application is set
	up to open packages, or folders.  In these cases, you may want to correct
	the Navigation Services reply structure to ensure your document opening
	routine receives consistent data. */
OSStatus NavReplyToODOCList(AEDescList *navReply, AEDescList *odocList) {
	OSErr err;
	long i, n;
	FSSpec fileSpec;
	AEKeyword keyWd;
	DescType typeCd;
	Size actSz;
	AliasHandle alias;
	AEDescList theDocuments;
		/* set up initial state */
	AECreateDesc(typeNull, NULL, 0, &theDocuments);
	alias = NULL;
		/* create the list */
	err = AECreateList(NULL, 0, false, &theDocuments);
	if (err != noErr) goto bail;
		/* count the documents in the list, there must be at least one */
	err = AECountItems(navReply, &n);
	if (err != noErr) goto bail;
		/* iterate through the documents */
	for ( i = 1; i <= n; i++) {
			/* get the i'th one from the source */
		err = AEGetNthPtr(navReply, i, typeFSS, &keyWd, &typeCd,
			(Ptr) &fileSpec, sizeof(fileSpec), (actSz = sizeof(fileSpec), &actSz));
		if (err != noErr) goto bail;
			/* standardize the fsspec.  */
		if (fileSpec.name[0] == 0) {
			CInfoPBRec cat;
			Str255 name;
			BlockZero(&cat, sizeof(cat));
			cat.dirInfo.ioNamePtr = name;
			cat.dirInfo.ioVRefNum = fileSpec.vRefNum;
			cat.dirInfo.ioFDirIndex = -1;
			cat.dirInfo.ioDrDirID = fileSpec.parID;
			err = PBGetCatInfoSync(&cat);
			if (err != noErr) goto bail;
			err = FSMakeFSSpec(fileSpec.vRefNum, cat.dirInfo.ioDrParID, name, &fileSpec);
			if (err != noErr) goto bail;
		}
			/* create an alias to it */
		err = NewAliasMinimal(&fileSpec, &alias);
		if (err != noErr) goto bail;
			/* add the alias to the document list.  */
		HLock((Handle) alias);
		err = AEPutPtr(&theDocuments, i, typeAlias, *alias, GetHandleSize((Handle) alias));
		if (err != noErr) goto bail;
			/* done with that one...  */
		DisposeHandle((Handle) alias);
		alias = NULL;
	}
		/* save result and return */
	*odocList = theDocuments;
	return noErr;
bail:
	AEDisposeDesc(&theDocuments);
	if (alias != NULL) DisposeHandle((Handle) alias);
	return err;
}

/*
** Apple Macintosh Developer Technical Support
**
** Program:         DTS.Lib
** File:            file2.c
** Some code from:  Traffic Light 2.0 version, by Keith Rollin & John Harvey
** Modified by:     Eric Soldan
**
** Copyright © 1990-1993 Apple Computer, Inc.
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

#ifndef __FILES__
#include <Files.h>
#endif

#if __MOVIESUPPORT__

#ifndef __IMAGECOMPRESSION__
#include <ImageCompression.h>
#endif

#ifndef __MOVIES__
#include <Movies.h>
#endif

#endif

#ifndef __PACKAGES__
#include <Packages.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif



/*****************************************************************************/



extern OSType		gDocCreator;	/* Initialized to gSignature by Init. */
extern long			gAppWindowAttr;	/* Initialized by app in Window.c. */
extern long			gQTVersion;		/* Initialized by Utilities.c in InitQuickTime. */

extern TreeObjHndl	gWindowFormats;	/* If non-nil, then get descriptions of windows from here. */

extern short		gTypeListLen;	/* Initialized by app in File.c. */
extern OSType		*gTypeListPtr;	/* Initialized by app in File.c. */

FileFilterUPP		gSFGetFileFilter;

static OSErr		Create_OpenFile(FSSpec *file, short *refNum, OSType sftype);



/*****************************************************************************/
/*****************************************************************************/



/* This function disposes of the document.  It checks to see if a file is
** currently open for the document.  If it is, then the document is closed.
** Once there is no open file for the document, the memory occupied by the
** document is released. */

#pragma segment File
OSErr	DisposeDocument(FileRecHndl frHndl)
{
	OSErr		err, err2;
	short		refNum;
	WindowPtr	window;
	Movie		movie;

	err = noErr;

	if (frHndl) {

		if ((refNum = (*frHndl)->fileState.refNum) != kInvalRefNum) {		/* If file open... */

			if ((*frHndl)->fileState.sfType == MovieFileType)		/* If movie file... */
				err = CloseMovieFile(refNum);						/* Close it. */

			else													/* If not movie file... */
				err = FSClose(refNum);								/* Close it.       */
		}

		CloseDocResFile(frHndl);					/* Close resource fork, if opened. */

		window = (*frHndl)->fileState.window;
		err2    = DoFreeDocument(frHndl);			/* Free all application-specific document ram. */

		if (movie = (*frHndl)->fileState.movie)
			DisposeMovie(movie);					/* If we have a movie, dispose it. */

		if (window)
			SetWRefCon(window, (long)nil);			/* Mark window as no longer having a document. */

		if (!err)
			err = err2;

		DisposeHandle((Handle)frHndl);				/* Release memory for the document handle. */
	}

	return(err);
}



/*****************************************************************************/



/* This function creates a new document.  A handle is created as the
** reference to the document.  Header information is placed in this handle.
** The application-specific data follows this header information.  The
** handle is returned (or nil upon failure), and typically the handle is
** then stored in the refCon field of the window.  Note that this is a
** convention, and is not mandatory.  This allows a document to exist that
** has no window.  A document with no window is useful when the application
** is called from the finder in response to a print request.  The document
** can be loaded and printed without involving a window on the screen. */

#pragma segment File
OSErr	NewDocument(FileRecHndl *returnHndl, OSType sftype, Boolean incTitleNum)
{
	long				size;
	FileRecHndl			frHndl;
	FileRecPtr			frPtr;
	Str255				untitled;
	StringPtr			pstr;
	OSErr				err;
	short				i;
	Movie				movie;
	TreeObjHndl			wobj;
	PositionWndProcPtr	windowPlacementProc;
	static short		untitledCount;

	if (!sftype) {
		if (returnHndl == (FileRecHndl *)-1)
			--untitledCount;
		if (!returnHndl)
			untitledCount = 0;
		return(noErr);
	}

	if (returnHndl)
		*returnHndl = nil;

	err  = memFullErr;				/* Assume that we will fail. */

	size = InitDocumentSize(sftype);
		/* Call the application and ask it how big the frHndl should be for
		** this document type.  We can't know, so we'll ask. */

	if (frHndl = (FileRecHndl)NewHandleClear(size)) {
		/* Create (or try to) the frHndl, initialized to all 0's */

		if (returnHndl)
			*returnHndl = frHndl;

		windowPlacementProc = StaggerWindow;
		wobj = nil;
		if (gWindowFormats) {
			for (i = 0; i < (*gWindowFormats)->numChildren; ++i) {
				wobj = GetChildHndl(gWindowFormats, i);
				if (sftype == mDerefWFMT(wobj)->sfType) {
					windowPlacementProc = nil;
						/* If using 'WFMT' descriptions, this will be fully determined later. */
					pcpy(untitled, (StringPtr)mDerefWFMT(wobj)->title);
					if (untitled[0])
						if (untitled[1] == ' ')
							untitled[0] = 0;
								/* If title begins with a space, it's just a comment. */

					break;
				}
				wobj = nil;
			}
		}
		if (!wobj) {
			for (i = gTypeListLen; --i;) if (sftype == gTypeListPtr[i]) break;
				/* Walk the typeList to find this file type.  We are interested in
				** where we find the entry.  The position we find it is used as a
				** string number into the rDefaultTitles STR# resource.  We get
				** an individual string from this location.  This allows us to
				** have different default titles for different document types. */
	
			for (++i; i; i--) {
				GetIndString(untitled, rDefaultTitles, i);
				if (untitled[0]) break;		/* Quit if we succeeded at getting one. */
			}
		}

		(*frHndl)->fileState.modNum = GetModNum();
			/* In case GetModNum gets moved to another code segment, set this value
			** prior to dereferencing frHndl into frPtr. */

		frPtr = *frHndl;
		frPtr->fileState.sfType                  = sftype;
		frPtr->fileState.modTick                 = TickCount();
		frPtr->fileState.refNum                  = kInvalRefNum;
		frPtr->fileState.resRefNum               = kInvalRefNum;
		frPtr->fileState.fss.vRefNum             = kInvalVRefNum;
		frPtr->fileState.windowID                = rWindow;
			/* The above sets the fileState constants for the document.  Note
			** that we use a default 'WIND' ID for the expected window resource.
			** This can be changed later, if the default isn't good enough. */

		if (wobj) {
			frPtr->fileState.windowID      = mDerefWFMT(wobj)->windowID;
			frPtr->fileState.attributes    = mDerefWFMT(wobj)->attributes;
			frPtr->fileState.hScrollIndent = mDerefWFMT(wobj)->hScrollIndent;
			frPtr->fileState.vScrollIndent = mDerefWFMT(wobj)->vScrollIndent;
			frPtr->fileState.leftSidebar   = mDerefWFMT(wobj)->leftSidebar;
			frPtr->fileState.topSidebar    = mDerefWFMT(wobj)->topSidebar;
				/* Set window attributes as described in resource. */
		}
		else
			frPtr->fileState.attributes = gAppWindowAttr;
				/* Set window attributes for the main document type. If the document
				** is not the main type, then the application's InitDocument function
				** will have to change it. */

		frPtr->fileState.getDocWindow        = windowPlacementProc;
		frPtr->fileState.adjustMenuItemsProc = AdjustMenuItems;
		frPtr->fileState.doMenuItemProc      = DoMenuItem;
		switch (frPtr->fileState.attributes & (kwIsPalette | kwIsModalDialog)) {
			case kwIsPalette:
				frPtr->fileState.calcFrameRgnProc  = PaletteCalcFrameRgn;
				frPtr->fileState.contentClickProc  = PaletteContentClick;
				frPtr->fileState.contentKeyProc    = PaletteContentKey;
				frPtr->fileState.drawFrameProc     = PaletteDrawFrame;
				frPtr->fileState.freeDocumentProc  = PaletteFreeDocument;
				frPtr->fileState.freeWindowProc    = PaletteFreeWindow;
				frPtr->fileState.imageProc         = PaletteImageDocument;
				frPtr->fileState.initContentProc   = PaletteInitContent;
				frPtr->fileState.readDocumentProc  = nil;
				frPtr->fileState.resizeContentProc = PaletteResizeContent;
				frPtr->fileState.scrollFrameProc   = PaletteScrollFrame;
				frPtr->fileState.undoFixupProc     = PaletteUndoFixup;
				frPtr->fileState.windowCursorProc  = PaletteWindowCursor;
				frPtr->fileState.writeDocumentProc = nil;
				break;
			case kwIsModalDialog:
				frPtr->fileState.calcFrameRgnProc    = DialogCalcFrameRgn;
				frPtr->fileState.contentClickProc    = DialogContentClick;
				frPtr->fileState.contentKeyProc      = DialogContentKey;
				frPtr->fileState.drawFrameProc       = DialogDrawFrame;
				frPtr->fileState.freeDocumentProc    = DialogFreeDocument;
				frPtr->fileState.freeWindowProc      = DialogFreeWindow;
				frPtr->fileState.imageProc           = DialogImageDocument;
				frPtr->fileState.initContentProc     = DialogInitContent;
				frPtr->fileState.readDocumentProc    = nil;
				frPtr->fileState.resizeContentProc   = DialogResizeContent;
				frPtr->fileState.scrollFrameProc     = DialogScrollFrame;
				frPtr->fileState.undoFixupProc       = DialogUndoFixup;
				frPtr->fileState.windowCursorProc    = DialogWindowCursor;
				frPtr->fileState.writeDocumentProc   = nil;
				frPtr->fileState.adjustMenuItemsProc = DialogAdjustMenuItems;
				frPtr->fileState.doMenuItemProc      = DialogDoMenuItem;
				break;
			default:
				frPtr->fileState.calcFrameRgnProc  = CalcFrameRgn;
				frPtr->fileState.contentClickProc  = ContentClick;
				frPtr->fileState.contentKeyProc    = ContentKey;
				frPtr->fileState.drawFrameProc     = DrawFrame;
				frPtr->fileState.freeDocumentProc  = FreeDocument;
				frPtr->fileState.freeWindowProc    = FreeWindow;
				frPtr->fileState.imageProc         = ImageDocument;
				frPtr->fileState.initContentProc   = InitContent;
				frPtr->fileState.readDocumentProc  = ReadDocument;
				frPtr->fileState.resizeContentProc = ResizeContent;
				frPtr->fileState.scrollFrameProc   = ScrollFrame;
				frPtr->fileState.undoFixupProc     = UndoFixup;
				frPtr->fileState.windowCursorProc  = WindowCursor;
				frPtr->fileState.writeDocumentProc = WriteDocument;
				break;
		}

		frPtr->fileState.windowSizeBounds.left   = kMinWindowWidth;
		frPtr->fileState.windowSizeBounds.top    = kMinWindowHeight;
		frPtr->fileState.windowSizeBounds.right  = kMaxWindowWidth;
		frPtr->fileState.windowSizeBounds.bottom = kMaxWindowHeight;
			/* Default min/max window size for growIcon. */

		pstr = frPtr->fileState.fss.name;
		pcpy(pstr, untitled);
		if (pstr[0]) {
			if (incTitleNum)
				++untitledCount;
			pcatdec(pstr, untitledCount);
				/* Create the default document title.  It is stored in the FSSpec,
				** as we can't place it in the window title.  We don't have a window
				** yet to "title".  This will happen later.  The title is gotten from
				** the FSSpec, so we are effectively done. */
		}

		err = InitDocument(frHndl);
			/* Call the application for any additional document initialization.
			** Other handles may need to be allocated.  The default values above
			** may be incorrect for a certain document type.  This gives the
			** application a chance to change any defaults that are incorrect. */

		if ((*frHndl)->fileState.sfType == MovieFileType) {
			InitQuickTime();
			if (!gQTVersion) return(paramErr);
			movie = NewMovie(newMovieActive);
			err   = GetMoviesError();
			if (!err) {
				ClearMovieChanged(movie);
				(*frHndl)->fileState.movie = movie;
			}
		}

		if (err) {
			DisposeHandle((Handle)frHndl);
			if (returnHndl)
				*returnHndl = nil;
					/* If the application couldn't complete the document
					** initialization, pitch the handle. */
		}
	}

	return(err);
}



/*****************************************************************************/



#pragma segment File
OSErr	OpenDocument(FileRecHndl *result, FSSpecPtr fileToOpen, char permission)
{
	StandardFileReply	reply;
	short				refNum;
	FileRecHndl			frHndl;
	OSErr				err;
	FSSpec				myFileSpec;
	DialogPtr			openDialog;
	short				item;
	FInfo				finderInfo;
	Boolean				openMovie;
	Movie				movie;
	static SFTypeList	typeList = {MovieFileType};

	*result = nil;		/* Assume we will fail. */

	openMovie = false;
	if (fileToOpen == kOpenMovie) {
		if (!gQTVersion) return(paramErr);		/* Can't do movies without QuickTime. */
		fileToOpen = nil;
		openMovie  = true;
	}

	if (!fileToOpen) {
		if (openMovie) {
			StandardGetFilePreview(0L, 1, typeList, &reply);
			if (reply.sfGood)
				myFileSpec = reply.sfFile;
			else
				return(userCanceledErr);	/* User canceled. */
		}
		else {
			if (DisplayGetFile(&reply, gTypeListLen, gTypeListPtr))	/* Let user pick file. */
				myFileSpec = reply.sfFile;							/* User's choice.	   */
			else
				return(userCanceledErr);	/* User canceled. */
		}
	}
	else {
		err = HGetFInfo(fileToOpen->vRefNum, fileToOpen->parID, fileToOpen->name, &finderInfo);
		if (err) return(err);
		reply.sfType = finderInfo.fdType;		/* OSType of file. */
		myFileSpec   = *fileToOpen;				/* Pre-designated file to open. */
	}

	err = NewDocument(&frHndl, reply.sfType, false);
	if (err) return(err);
		/* We couldn't create an empty document, so give it up. */

	err = HOpenDF(myFileSpec.vRefNum, myFileSpec.parID, myFileSpec.name, permission, &refNum);
	if (err == paramErr)
		err = HOpen(myFileSpec.vRefNum, myFileSpec.parID, myFileSpec.name, permission, &refNum);

	if (err == permErr) {
		permission = fsRdPerm;
		err = HOpenDF(myFileSpec.vRefNum, myFileSpec.parID, myFileSpec.name, permission, &refNum);
		if (err == paramErr)
			err = HOpen(myFileSpec.vRefNum, myFileSpec.parID, myFileSpec.name, permission, &refNum);
		if (!err)
			(*frHndl)->fileState.readOnly = true;
	}

	if (err == opWrErr) {

		ParamText(myFileSpec.name, nil, nil, nil);
		openDialog = GetCenteredDialog(rOpenReadOnly, nil, nil, (WindowPtr)-1L);
		if (!openDialog) {
			DisposeDocument(frHndl);
			return(err);
		}

		OutlineDialogItem(openDialog, kOpenYes);
		DoSetCursor(&qd.arrow);
		UnhiliteWindows();
		ModalDialog(gKeyEquivFilterUPP, &item);
		DisposeDialog(openDialog);
		HiliteWindows();
		if (item != kOpenYes) {
			DisposeDocument(frHndl);
			return(userCanceledErr);
		}

		(*frHndl)->fileState.readOnly = true;
		permission = fsRdPerm;
		err = HOpenDF(myFileSpec.vRefNum, myFileSpec.parID, myFileSpec.name, permission, &refNum);
		if (err == paramErr)
			err = HOpen(myFileSpec.vRefNum, myFileSpec.parID, myFileSpec.name, permission, &refNum);
	}

	if (err) {
		DisposeDocument(frHndl);
		return(err);
	}

	if ((*frHndl)->fileState.sfType == MovieFileType) {
		FSClose(refNum);							/* Close file, as it wasn't opened as movie. */
		if (movie = (*frHndl)->fileState.movie) {
			DisposeMovie(movie);					/* NewDocument created an empty movie, */
			(*frHndl)->fileState.movie = nil;		/* so first get rid of it. */
		}
		err = OpenMovieFile(&myFileSpec, &refNum, permission);
		if (err) {
			DisposeDocument(frHndl);
			return(err);
		}
	}

	(*frHndl)->fileState.fss    = myFileSpec;
	(*frHndl)->fileState.refNum = refNum;

	if (err = DoReadDocument(frHndl)) {
		DisposeDocument(frHndl);
		return(err);
	}

	*result = frHndl;
	return(noErr);
}



/*****************************************************************************/



#pragma segment File
OSErr	SaveDocument(FileRecHndl frHndl, WindowPtr window, short saveMode)
{
	Str255				closeOrQuit;
	short				item, refNum, resID, resWasOpen;
	long				createFlags;
	StandardFileReply	reply;
	OSErr				err;
	Movie				movie;
	Boolean				doPrompt;
	DialogPtr			saveDialog;

	err = noErr;

/*	When entering, saveMode is set to the menu command number of the
**	the item that prompted this. Current settings are kSave, kSaveAs,
**	kClose, and kQuit. */

	if (saveMode != kSaveAs) {							/* If not save as...				  */
		if (!(*frHndl)->fileState.docDirty) {			/* If file clean...					  */
			if ((*frHndl)->fileState.refNum)			/* If document has a file...		  */
				if (!(*frHndl)->fileState.readOnly)		/* If we are allowed to touch file... */
					if ((*frHndl)->fileState.attributes & kwOpenAtOldLoc)
						DoWriteDocumentHeader(frHndl);
							/* Write out document location and print record information. */
							/* Ignore errors, as saving the location is a bonus. */
			return(noErr);								/* Consider it saved. */
		}
	}

	pcpy(reply.sfFile.name, (*frHndl)->fileState.fss.name);

	if ((saveMode == kClose) || (saveMode == kQuit)) {
		/* If implicit save... */

		GetIndString(closeOrQuit, rFileIOStrings,
					 (saveMode == kClose) ? sWClosing : sQuitting);
		ParamText(reply.sfFile.name, closeOrQuit, nil, nil);

		saveDialog = GetCenteredDialog(rYesNoCancel, nil, window, (WindowPtr)-1L);

		if (saveDialog) {
			OutlineDialogItem(saveDialog, kSaveYes);
			DoSetCursor(&qd.arrow);
			UnhiliteWindows();
			ModalDialog(gKeyEquivFilterUPP, &item);
			DisposeDialog(saveDialog);
			HiliteWindows();
		}
		else
			item = kSaveNo;
				/* If the dialog isn't displayed, then AppleScript doesn't want it to.
				** In this case, we were probably AppleScripted the whole time, so
				** the document is an AppleScript-produced document.  The script is
				** done with the document, so ditch the document. */

		if (item != kSaveYes) {
			err = noErr;
			if (item == kSaveCanceled)
				err = userCanceledErr;
			return(err);
		}
	}

	doPrompt = (
		(saveMode == kSaveAs) ||
		((*frHndl)->fileState.refNum == kInvalRefNum)
	);

	if (doPrompt) {
		/* Prompt with SFGetFile if doing a Save As or have never saved before. */

		if (!DisplayPutFile(&reply)) return(userCanceledErr);	/* User canceled the save. */

		if ((*frHndl)->fileState.sfType != MovieFileType) {
			if ((*frHndl)->fileState.refNum != kInvalRefNum) {
				if ((*frHndl)->fileState.sfType != MovieFileType) {
					resWasOpen = (*frHndl)->fileState.resRefNum;
					CloseDocResFile(frHndl);		/* Close resource fork, if opened. */
					FSClose((*frHndl)->fileState.refNum);
				}
			}			/* Close the old file.  Don't respond to any error here because
						** the user may be trying to do a save-as because their old file
						** is bad.  If we fail to close the old file, and then respond
						** to the error, the user won't get the opportunity to save
						** their document to a new file. */

			(*frHndl)->fileState.refNum      = kInvalRefNum;
			(*frHndl)->fileState.fss.vRefNum = kInvalVRefNum;
			if (err = Create_OpenFile(&reply.sfFile, &refNum, (*frHndl)->fileState.sfType))
				return(err);
		}
		else {
			createFlags = createMovieFileDeleteCurFile;
			err = CreateMovieFile(&reply.sfFile, gDocCreator, 0, createFlags, &refNum, nil);
			if (err) return(err);
			resID = 0;
			err = AddMovieResource((*frHndl)->fileState.movie, refNum, &resID, nil);
			if (err) return(err);
			(*frHndl)->fileState.movieResID = resID;
		}

		(*frHndl)->fileState.fss    = reply.sfFile;		/* This is the new file. */
		(*frHndl)->fileState.refNum = refNum;

		if (resWasOpen) {
			UseDocResFile(frHndl, &resWasOpen, fsRdWrPerm);
			UseResFile(resWasOpen);
		}

		if (window)
			NewWindowTitle(window, nil);
	}
	else {
		if ((*frHndl)->fileState.sfType == MovieFileType) {
			movie  = (*frHndl)->fileState.movie;
			refNum = (*frHndl)->fileState.refNum;
			resID  = (*frHndl)->fileState.movieResID;
			err = UpdateMovieResource(movie, refNum, resID, nil);
			if (err) return(err);
		}
	}

	if (err = DoWriteDocument(frHndl)) return(err);

	(*frHndl)->fileState.docDirty = false;
	(*frHndl)->fileState.readOnly = false;
	return(noErr);
}



/*****************************************************************************/



/* ConvertOldToNewSFReply
**
** struct StandardFileReply {			struct SFReply {
** 	Boolean 	sfGood;				<-	Boolean good;
** 	Boolean 	sfReplacing;		<-	Boolean copy;
** 	OSType 		sfType;				<-	OSType fType;
** 	FSSpec		sfFile;
** 					vRefNum;		<-	real vRefnum from (short vRefNum)
** 					parID;			<-	real dirID from (short vRefNum)
** 					name;			<-	Str63 fName;
** 	ScriptCode	sfScript;			<-	iuSystemScript
** 	short 		sfFlags;			<-	0
** 	Boolean 	sfIsFolder;			<-	false
** 	Boolean 	sfIsVolume;			<-	false
** 	long		sfReserved1;		<-	0
** 	short		sfReserved2;		<-	0
** };									};
*/

#pragma segment File
void	ConvertOldToNewSFReply(SFReply *oldReply, StandardFileReply *newReply)
{
	OSErr		err;
	long		ignoredProcID;

	newReply->sfGood		= oldReply->good;
	newReply->sfReplacing	= oldReply->copy;		/* Correct assignment? */
	newReply->sfType		= oldReply->fType;

	err = GetWDInfo(oldReply->vRefNum,
					&newReply->sfFile.vRefNum,
					&newReply->sfFile.parID,
					&ignoredProcID);
	pcpy(newReply->sfFile.name, oldReply->fName);

	/* Punt on the rest... */
	newReply->sfScript		= iuSystemScript;
	newReply->sfFlags		= 0;
	newReply->sfIsFolder	= false;
	newReply->sfIsVolume	= false;
	newReply->sfReserved1	= 0;
	newReply->sfReserved2	= 0;
}



/*****************************************************************************/



/* Opens the file specified by the passed FSSpec, creating it if it doesn't
** already exist. Returns the refnum of the open file to the application.
** File Manager errors are reported and returned. */

#pragma segment File
static OSErr	Create_OpenFile(FSSpec *file, short *refNum, OSType sftype)
{
	OSErr	err;

	err = HCreate(file->vRefNum, file->parID, file->name, gDocCreator, sftype);
	if (err == dupFNErr) {

		/* The user already told Standard File to replace the old file
		   so let's get rid of it. */

		HDelete(file->vRefNum, file->parID, file->name);

		/* Try creating it again. */
		err = HCreate(file->vRefNum, file->parID, file->name, gDocCreator, sftype);
	}

	if (!err) {
		err = HOpenDF(file->vRefNum, file->parID, file->name, fsRdWrPerm, refNum);
		if (err == paramErr)
			err = HOpen(file->vRefNum, file->parID, file->name, fsRdWrPerm, refNum);
		if (err)
			HDelete(file->vRefNum, file->parID, file->name);
	}

	return(err);
}



/*****************************************************************************/



/* Simple routine to display a list of files with our file type. */

#pragma segment File
Boolean	DisplayGetFile(StandardFileReply *reply, short typeListLen, SFTypeList typeList)
{
	Point		where = {100, 100};
	SFReply		oldReply;

	if (gSystemVersion >= 0x0700)		/* If new standard file available... */
		StandardGetFile(gSFGetFileFilter, typeListLen, typeList, reply);

	else {
		SFGetFile(where, "\pSelect a document to open.",
						 gSFGetFileFilter, typeListLen, typeList, nil, &oldReply);
		ConvertOldToNewSFReply(&oldReply, reply);
	}

	return(reply->sfGood);
}



/*****************************************************************************/



/* Displays the StandardFile PutFile dialog box. Fills out the passed reply
** record, and returns the sfGood field as a result. */

#pragma segment File
Boolean	DisplayPutFile(StandardFileReply *reply)
{
	Str255		prompt;
	Point		where = {100, 100};
	SFReply		oldReply;

	GetIndString(prompt, rFileIOStrings, sSFprompt);

	if (gSystemVersion >= 0x0700)	/* If new standard file available... */
		StandardPutFile(prompt, reply->sfFile.name, reply);
	else {
		SFPutFile(where, prompt, reply->sfFile.name, nil, &oldReply);
		ConvertOldToNewSFReply(&oldReply, reply);
	}

	return(reply->sfGood);
}



/*****************************************************************************/



/* Use the resource fork for the designated document file.  This function
** also returns the old CurResFile, so you can set it back when you are done.
** Simply call this function, whether or not you have a resource fork.  If
** there isn't a resource fork, then one will be created.  If there is one,
** but it isn't open yet, it will be opened.  If it is already opened, it
** sets it as the current resource fork.  What more do you want? */

#define fcbFlgRBit 0x200

#pragma segment File
OSErr	UseDocResFile(FileRecHndl frHndl, short *oldRes, char perm)
{
	OSErr		err;
	FSSpec		fss;
	short		res, vrn;
	long		pid;
	FCBPBRec	pb;
	CInfoPBRec	resOpen;

	if (oldRes)
		*oldRes = CurResFile();

	if ((res = (*frHndl)->fileState.resRefNum) != kInvalRefNum) {
		UseResFile(res);		/* If the resource fork already open, use it. */
		return(ResError());
	}

	SetMem(&pb, 0, sizeof(FCBPBRec));			/* Make most of the param block happy. */
	pb.ioRefNum = res = (*frHndl)->fileState.refNum;
	if (err = PBGetFCBInfoSync(&pb)) return(err);
	if (pb.ioFCBFlags & fcbFlgRBit) {
		(*frHndl)->fileState.resRefNum = res;
		UseResFile(res);
		return(ResError());
	}

	fss = (*frHndl)->fileState.fss;
	vrn = fss.vRefNum;
	pid = fss.parID;

	SetMem(&resOpen, 0, sizeof(CInfoPBRec));	/* Make most of the param block happy. */
	resOpen.hFileInfo.ioVRefNum = vrn;
	resOpen.hFileInfo.ioDirID   = pid;
	resOpen.hFileInfo.ioNamePtr = fss.name;
	if (err = PBGetCatInfoSync(&resOpen))    return(err);
	if (resOpen.hFileInfo.ioFlAttrib & 0x04) {
		/* The 0x04 is to look at the bit that says whether or not the resource fork is
		** already open.  Why did we do this?  To keep from re-opening a resource fork.
		** Reopening it actually works, but things get a bit ugly when it is closed.  The
		** one-and-only reference to the open resource fork would get closed if we thought
		** we opened it.  This keeps us from doing way-bad things later. */
		UseResFile(resOpen.hFileInfo.ioFRefNum);
		return(ResError());
	}

	if ((*frHndl)->fileState.readOnly)
		if (perm  & fsWrPerm) perm ^= fsWrPerm;

	SetResLoad(false);
	res = HOpenResFile(vrn, pid, fss.name, perm);
	err = ResError();
	SetResLoad(true);
		/* Try opening the resource fork. */

	if (err) {
		if (err != eofErr) return(err);					/* Some errors we can't handle here. */
		HCreateResFile(vrn, pid, fss.name);				/* No resource fork, so create one.  */
		if (err = ResError()) return(err);				/* Error creating the resource fork. */
		res = HOpenResFile(vrn, pid, fss.name, perm);	/* Now that it exists, open it.  */
		err = ResError();								/* Return whatever error occurs. */
	}

	if (!err) {		/* If no error, then we can use the resource fork. */
		(*frHndl)->fileState.resRefNum = res;
		UseResFile(res);
		err = ResError();
	}

	return(err);
}



/*****************************************************************************/



/* If there is a resource fork open for this document, this closes it. */

#pragma segment File
OSErr	CloseDocResFile(FileRecHndl frHndl)
{
	short	res;

	if ((res = (*frHndl)->fileState.resRefNum) == kInvalRefNum) return(noErr);
		/* If it was never opened, then there's nothing to close. */

	if ((*frHndl)->fileState.refNum == res) {
		(*frHndl)->fileState.resRefNum = kInvalRefNum;
		return(noErr);
	}

	CloseResFile(res);									/* Close the resource fork. */
	(*frHndl)->fileState.resRefNum = kInvalRefNum;		/* Mark it as closed. */

	return(ResError());
}



/*****************************************************************************/



#pragma segment File
long	GetModNum(void)
{
	static	modNum = 0;

	return(++modNum);
}



/*****************************************************************************/



/* This function returns the state of the document.  If the document
** is dirty, then true is returned.  If the document is clean, then false
** is returned. */

#pragma segment File
Boolean	GetDocDirty(FileRecHndl frHndl)
{
	if (frHndl) return((*frHndl)->fileState.docDirty);
	return(false);
}



/*****************************************************************************/



/* This function returns the state of the window's document.  If the document
** is dirty, then true is returned.  If the document is clean, or the window
** has no document, then false is returned. */

#pragma segment File
Boolean	GetWindowDirty(WindowPtr window)
{
	if (IsAppWindow(window)) return(GetDocDirty((FileRecHndl)GetWRefCon(window)));
	return(false);
}



/*****************************************************************************/



#pragma segment File
void	SetDocDirty(FileRecHndl frHndl)
{
	if (frHndl) {
		if (!((*frHndl)->fileState.attributes & kwRuntimeOnlyDoc)) {
			(*frHndl)->fileState.docDirty = true;
			(*frHndl)->fileState.modNum   = GetModNum();
			(*frHndl)->fileState.modTick  = TickCount();
		}
	}
}



/*****************************************************************************/



#pragma segment File
void	SetWindowDirty(WindowPtr window)
{
	if (IsAppWindow(window))
		SetDocDirty((FileRecHndl)GetWRefCon(window));
}



/*****************************************************************************/



/*  The SetDefault function sets the default volume and directory to the volume specified
**  by newVRefNum and the directory specified by newDirID. The current default volume 
**  and directory are returned in oldVRefNum and oldDir and should be used to restore 
**  things to their previous condition *as soon as possible* with the RestoreDefault 
**  function. These two functions are designed to be used as a wrapper around
**  Standard C I/O routines where the location of the file is implied to be the
**  default volume and directory. In other words, this is how you should use these
**  functions:
**
**		err = SetDefault(newVRefNum, newDirID, &oldVRefNum, &oldDirID);
**		if (!err)
**			{
**				-- call the Stdio functions like remove, rename, tmpfile, fopen,   --
**				-- freopen, etc. or non-ANSI extentions like fdopen, fsetfileinfo, --
**				-- create, open, unlink, etc. here!								   --
**
**				err = RestoreDefault(oldVRefNum, oldDirID);
**			}
**
**  By using these functions as a wrapper, you won't need to open a working directory 
**  (because they use HSetVol) and you won't have to worry about the effects of using
**  HSetVol (documented in Technical Note #140: Why PBHSetVol is Dangerous 
**  and in the Inside Macintosh: Files book in the description of the HSetVol and 
**  PBHSetVol functions) because the default volume/directory is restored before 
**  giving up control to code that might be affected by HSetVol.
** Use this and the below call instead of the old-style FSpSetWD and FSpResetWD. */

#pragma segment File
OSErr	SetDefault(short newVRefNum, long newDirID, short *oldVRefNum, long *oldDirID)
{
	OSErr	err;

	err = HGetVol(nil, oldVRefNum, oldDirID);
		/* Get the current default volume/directory. */

	if (!err)
		err = HSetVol(nil, newVRefNum, newDirID);
			/* Set the new default volume/directory */

	return(err);
}



/*****************************************************************************/



#pragma segment File
OSErr	RestoreDefault(short oldVRefNum, long oldDirID)
{
	OSErr	err;
	short	defaultVRefNum;
	long	defaultDirID;
	long	defaultProcID;

	err = GetWDInfo(oldVRefNum, &defaultVRefNum, &defaultDirID, &defaultProcID);
		/* Determine if the default volume was a wdRefNum. */

	if (!err) {
		/* Restore the old default volume/directory, one way or the other. */

		if (defaultDirID != fsRtDirID)
			err = SetVol(nil, oldVRefNum);
				/* oldVRefNum was a wdRefNum - use SetVol */
		else
			err = HSetVol(nil, oldVRefNum, oldDirID);
				/* oldVRefNum was a real vRefNum - use HSetVol */
	}

	return(err);
}



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



/* Get the vRefNum and dirID of a file, which is its location. */

#pragma segment File
OSErr	GetFileLocation(short refNum, short *vRefNum, long *dirID, StringPtr fileName)
{
	FCBPBRec pb;
	OSErr err;

	pb.ioNamePtr = fileName;
	pb.ioVRefNum = 0;
	pb.ioRefNum  = refNum;
	pb.ioFCBIndx = 0;

	err = PBGetFCBInfoSync(&pb);

	if (vRefNum)
		*vRefNum = pb.ioFCBVRefNum;
	if (dirID)
		*dirID = pb.ioFCBParID;

	return(err);
}



/*****************************************************************************/



/* After getting a resource, you can't actually be sure that it came from the current
** resource file.  Even if you make a call such as Get1Resource, starting with system 7.1,
** you can't really be sure that it came from the current resource file.  (The resource
** files may be overridden, or they may be flagged to be extended, as is the case with
** font files.)  This checks to see that the resource actually came from the current
** resource file.  If it didn't, then the handle returned is nil, and the error returned
** is resNotFound.  (You probably don't need this function unless you are doing some kind
** of resource-editing function.) */

#pragma segment File
OSErr	CurResOnly(Handle *hndl)
{
	short	cr, hr;
	OSErr	err;

	cr  = CurResFile();
	hr  = HomeResFile(*hndl);
	err = ResError();
	if (hr == -1) err = resNotFound;
	if (!hr)      hr  = 2;				/* Home res file is the system file. */

	if (cr != hr) *hndl = nil;
	return(err);
}




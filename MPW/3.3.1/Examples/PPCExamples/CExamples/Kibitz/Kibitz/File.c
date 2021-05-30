/*
** Apple Macintosh Developer Technical Support
**
** File:            file.c
** Some code from:  Traffic Light 2.0 version, by Keith Rollin & John Harvey
** Modified by:     Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __ALIASES__
#include <Aliases.h>
#endif

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifndef __PACKAGES__
#include <Packages.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/



static Boolean	gIncNewFileNumFlag = true;



/*****************************************************************************/
/*****************************************************************************/



/* This function disposes of the document.  It checks to see if a file is
** currently open for the document.  If it is, then the document is closed.
** Once there is no open file for the document, the memory occupied by the
** document is released. */

#pragma segment File
OSErr	AppDisposeDocument(FileRecHndl frHndl)
{
	OSErr		err;
	Handle		snd;

	err = noErr;

	if (frHndl) {
		SetOpponentType(frHndl, kOnePlayer);
			/* Disconnect from opponent. */

		if ((*frHndl)->fileState.fss.vRefNum != kInvalVRefNum)
			err = FSClose((*frHndl)->fileState.refNum);
				/* Close the file, if opened. */

		DisposHandle((Handle)(*frHndl)->doc.legalMoves);
		DisposHandle((Handle)(*frHndl)->doc.gameMoves);
		if (snd = (*frHndl)->doc.sound)
			DisposHandle(snd);
				/* Release all handles hanging off the document. */

		DisposHandle((Handle)frHndl);
			/* Release memory for the document handle. */
	}

	return(err);
}



/*****************************************************************************/



/* This function returns whether or not the document is dirty. */

#pragma segment File
Boolean	AppDocumentDirty(FileRecHndl frHndl)
{
	return((*frHndl)->fileState.docDirty);
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
OSErr	AppNewDocument(FileRecHndl *returnHndl, short winNameType)
{
	static short	untitledCount;
	FileRecHndl		frHndl;
	FileRecPtr		frPtr;
	Str255			untitled;
	StringPtr		pstr;
	MoveListHndl	legalMovesHndl;
	GameListHndl	gameMovesHndl;

	*returnHndl = nil;

	if (frHndl = (FileRecHndl)NewHandle(sizeof(FileRec))) {

		GetIndString(untitled, rMiscStrings, winNameType);
		frPtr = *frHndl;
		frPtr->fileState.docDirty    = false;
		frPtr->fileState.readOnly    = false;
		frPtr->fileState.fss.vRefNum = kInvalVRefNum;
		frPtr->fileState.window      = nil;
		pstr = frPtr->fileState.fss.name;
		pcpy(pstr, untitled);
		if (gIncNewFileNumFlag) ++untitledCount;
		pcatdec(pstr, untitledCount);

		legalMovesHndl = (MoveListHndl)NewHandle(0);
		if (!legalMovesHndl) {
			DisposHandle((Handle)frHndl);
			return(memFullErr);
		}

		gameMovesHndl = (GameListHndl)NewHandle(0);
		if (!gameMovesHndl) {
			DisposHandle((Handle)frHndl);
			DisposHandle((Handle)legalMovesHndl);
			return(memFullErr);
		}

		NewGame(frHndl);		/* Initialize the game. */

		frPtr = *frHndl;
		frPtr->doc.legalMoves = legalMovesHndl;
		frPtr->doc.gameMoves  = gameMovesHndl;
		if (winNameType == ksMssgName) frPtr->doc.myColor = kMessageDoc;

		*returnHndl = frHndl;
		return(noErr);			/* All is well. */
	}

	return(memFullErr);
}



/*****************************************************************************/



#pragma segment File
OSErr	AppOpenDocument(FileRecHndl *result, FSSpecPtr fileToOpen, char permission)
{
	StandardFileReply	reply;
	short				fileRefNum;
	FileRecHndl			frHndl;
	OSErr				err;
	FSSpec				myFileSpec;
	DialogPtr			openDialog;
	short				item, winNameType;

	*result = nil;		/* Assume we will fail. */

	if (!fileToOpen) {
		if (DisplayGetFile(&reply))		/* Let the user decide which file. */
			myFileSpec = reply.sfFile;	/* User's choice.				   */
		else
			return(userCanceledErr);	/* User canceled. */
	}
	else
		myFileSpec = *fileToOpen;		/* Pre-designated file to open. */

	winNameType = ksOrigName;
	if (reply.sfType != gameFileType) winNameType = ksMssgName;

	IncNewFileNum(false);
	err = AppNewDocument(&frHndl, winNameType);
	IncNewFileNum(true);
	if (err) return(err);
		/* We couldn't create an empty document, so give it up. */

	err = HOpen(myFileSpec.vRefNum, myFileSpec.parID,
				myFileSpec.name, permission, &fileRefNum);

	if (err == opWrErr) {

		ParamText(myFileSpec.name, nil, nil, nil);
		openDialog = GetCenteredDialog(rOpenReadOnly, nil, nil, (WindowPtr)-1L);
		if (!openDialog) {
			AppDisposeDocument(frHndl);
			return(err);
		}

		OutlineDialogItem(openDialog, kOpenYes);
		DoSetCursor(&qd.arrow);
		ModalDialog(gKeyEquivFilterUPP, &item);
		DisposDialog(openDialog);
		if (item != kOpenYes) return(userCanceledErr);

		(*frHndl)->fileState.readOnly = true;
		err = HOpen(myFileSpec.vRefNum, myFileSpec.parID,
					myFileSpec.name, fsRdPerm, &fileRefNum);
	}

	if (err) {
		AppDisposeDocument(frHndl);
		return(err);
	}

	(*frHndl)->fileState.fss    = myFileSpec;
	(*frHndl)->fileState.refNum = fileRefNum;

	if (err = AppReadDocument(frHndl, reply.sfType)) {
		AppDisposeDocument(frHndl);
		return(err);
	}

	if ((*frHndl)->fileState.readOnly) {
		FSClose((*frHndl)->fileState.refNum);
		(*frHndl)->fileState.fss.vRefNum = kInvalVRefNum;
	}		/* If it's read-only, we don't need the file left open. */

	*result = frHndl;
	return(err);
}



/*****************************************************************************/



#pragma segment File
OSErr	AppSaveDocument(FileRecHndl frHndl, WindowPtr window, short saveMode)
{
	Str255				closeOrQuit;
	short				item, gameStatus;
	StandardFileReply	reply;
	OSErr				err;
	short				fileRefNum;
	DialogPtr			saveDialog;
	Boolean				doPrompt;
	Boolean				youLose;
	OSType				theFileType;

/*	When entering, saveMode is set to the menu command number of the
**	the item that prompted this.  Current settings are iSave, iSaveAs,
**	iClose, and iQuit. */

	if (saveMode != iSaveAs) {						/* If regular save... */
		if (!AppDocumentDirty(frHndl))				/* If file clean...   */
			return(noErr);							/* Consider it saved. */
	}

	pcpy(reply.sfFile.name, (*frHndl)->fileState.fss.name);

	if ((saveMode == iClose) || (saveMode == iQuit)) {
		/* If implicit save... */

		GetIndString(closeOrQuit, rMiscStrings,
					 (saveMode == iClose) ? ksClosing : ksQuitting);
		ParamText(reply.sfFile.name, closeOrQuit, nil, nil);

		gameStatus = GameStatus(frHndl);
		youLose = ((gameStatus == kYouLose) || (gameStatus == kYouLoseOnTime));
		if ((gameStatus == kWhiteResigns) && ((*frHndl)->doc.myColor == WHITE))
			youLose = true;
		if ((gameStatus == kBlackResigns) && ((*frHndl)->doc.myColor == BLACK))
			youLose = true;
		if (youLose)
			saveDialog = GetCenteredDialog(rNoYesCancel, nil, window, (WindowPtr)-1L);
		else
			saveDialog = GetCenteredDialog(rYesNoCancel, nil, window, (WindowPtr)-1L);

		if (saveDialog) {
			OutlineDialogItem(saveDialog, kSaveYes);
			DoSetCursor(&qd.arrow);
			ModalDialog(gKeyEquivFilterUPP, &item);
			DisposDialog(saveDialog);
			if (youLose)
				if (item != kSaveCanceled)
					item = (item == kSaveYes) ? kSaveNo : kSaveYes;
		}
		else
			item = kSaveYes;

		if (item != kSaveYes) {
			err = noErr;
			if (item == kSaveCanceled) err = userCanceledErr;
			return(err);
		}
	}

	doPrompt = (
		(saveMode == iSaveAs) ||
		((*frHndl)->fileState.fss.vRefNum == kInvalVRefNum)
	);

	if (doPrompt) {
		/* Prompt with SFGetFile if doing a Save As or have never saved before. */

		if (!DisplayPutFile(&reply))
			return(userCanceledErr);
				/* User canceled the save. */

		if ((*frHndl)->fileState.fss.vRefNum != kInvalVRefNum)
			FSClose((*frHndl)->fileState.refNum);
				/* Close the old file.  Don't respond to any error here because
				** the user may be trying to do a save-as because their old file
				** is bad.  If we fail to close the old file, and then respond
				** to the error, the user won't get the opportunity to save
				** their document to a new file.
				*/

		theFileType = gameFileType;
		if ((*frHndl)->doc.myColor == kMessageDoc) theFileType = mssgFileType;

		if (err = Create_OpenFile(&reply.sfFile, &fileRefNum, theFileType)) {
			(*frHndl)->fileState.fss.vRefNum = kInvalVRefNum;
			return(err);
		}

		(*frHndl)->fileState.fss    = reply.sfFile;
		(*frHndl)->fileState.refNum = fileRefNum;
			/* This is the new file. */

		if (window) AppNewWindowTitle(window);
	}

	if (err = AppWriteDocument(frHndl))
		return(err);

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
** };
**}; */

#pragma segment File
void	ConvertOldToNewSFReply(SFReply *oldReply, StandardFileReply *newReply)
{
	OSErr	err;
	long	ignoredProcID;

	newReply->sfGood		= oldReply->good;
	newReply->sfReplacing	= oldReply->copy;		/* Correct assignment? */
	newReply->sfType		= oldReply->fType;

	err = GetWDInfo(oldReply->vRefNum,
					&newReply->sfFile.vRefNum,
					&newReply->sfFile.parID,
					&ignoredProcID);
	BlockMove((Ptr)&oldReply->fName,
			  (Ptr)&newReply->sfFile.name,
			  oldReply->fName[0]+1);

	/* Punt on the rest. */
	newReply->sfScript		= iuSystemScript;
	newReply->sfFlags		= 0;
	newReply->sfIsFolder	= false;
	newReply->sfIsVolume	= false;
	newReply->sfReserved1	= 0;
	newReply->sfReserved2	= 0;
}



/*****************************************************************************/



/* Create_OpenFile
**
** Opens the file specified by the passed FSSpec, creating it if it doesn't
** already exist. Refturns the refnum of the open file to the application.
** File Manager errors are reported and returned. */

#pragma segment File
OSErr	Create_OpenFile(FSSpec *file, short *refNum, OSType theFileType)
{
	OSErr	err;

	err = HCreate(file->vRefNum, file->parID, file->name, gameCreator, theFileType);
	if (err == dupFNErr) {

		/* The user already told Standard File to replace the old file
		   so let's get rid of it. */

		HDelete(file->vRefNum, file->parID, file->name);

		/* Try creating it again. */
		err = HCreate(file->vRefNum, file->parID, file->name, gameCreator, theFileType);
	}

	if (!err) {
		err = HOpen(file->vRefNum, file->parID, file->name, fsRdWrPerm, refNum);
		if (err)
			HDelete(file->vRefNum, file->parID, file->name);
	}

	return(err);
}



/*****************************************************************************/



/* DisplayGetFile
**
** Simple routine to display a list of files with our file type. */

#pragma segment File
Boolean DisplayGetFile(StandardFileReply *reply)
{
	SFTypeList	typeList = {gameFileType, mssgFileType, typeChar};
	Point		where = {100, 100};
	SFReply		oldReply;

	if (gSystemVersion >= 0x0700)	/* If new standard file available... */
		StandardGetFile(nil, 3, typeList, reply);

	else {
		SFGetFile(where, "\pSelect a document to open.",
						 nil, 3, typeList, nil, &oldReply);

		ConvertOldToNewSFReply(&oldReply, reply);
	}

	return(reply->sfGood);
}



/*****************************************************************************/



/* DisplayPutFile
**
** Displays the StandardFile PutFile dialog box. Fills out the passed reply
** record, and returns the sfGood field as a result. */

#pragma segment File
Boolean DisplayPutFile(StandardFileReply *reply)
{
	Str255		prompt;
	Point		where = {100, 100};
	SFReply		oldReply;

	GetIndString(prompt, rMiscStrings, ksSFprompt);

	if (gSystemVersion >= 0x0700)	/* If new standard file available... */
		StandardPutFile(prompt, reply->sfFile.name, reply);
	else {
		SFPutFile(where, prompt, reply->sfFile.name, nil, &oldReply);
		ConvertOldToNewSFReply(&oldReply, reply);
	}

	return(reply->sfGood);
}



/*****************************************************************************/



#pragma segment File
void	IncNewFileNum(Boolean flag)
{
	gIncNewFileNumFlag = flag;
}



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



/* AppReadDocument
**
** Reads in specified file into the data portion of a document handle. */

#pragma segment File
OSErr	AppReadDocument(FileRecHndl frHndl, OSType ftype)
{
	short			fileRefNum, vers, i;
	OSErr			err;
	char			hstate;
	Ptr				ptr1, ptr2;
	long			count;
	GameListHndl	gameMovesHndl;
	Handle			textHndl;

	fileRefNum = (*frHndl)->fileState.refNum;

	err = SetFPos(fileRefNum, fsFromStart, 0);
		/* Set the file position to the beginning of the file. */

	if (ftype != typeChar) {
		if (!err) {		/* Read board info from file. */
			hstate = LockHandleHigh((Handle)frHndl);
			ptr1   = (Ptr)&((*frHndl)->doc);
			ptr2   = (Ptr)&((*frHndl)->doc.endFileInfo1);
			count  = (long)ptr2 - (long)ptr1;
			err    = FSRead(fileRefNum, &count, ptr1);
			HSetState((Handle)frHndl, hstate);
			vers = (*frHndl)->doc.version;
			if ((vers > kVersion) | (vers < kLeastVersion)) err = vers;
		}

		if (!err) {
			switch (vers) {
				case kLeastVersion:
					(*frHndl)->doc.version = kVersion;
					break;
				case kVersion:
					hstate = LockHandleHigh((Handle)frHndl);
					ptr1   = (Ptr)&((*frHndl)->doc.reconnectZone);
					ptr2   = (Ptr)&((*frHndl)->doc.endFileInfo2);
					count  = (long)ptr2 - (long)ptr1;
					err    = FSRead(fileRefNum, &count, ptr1);
					HSetState((Handle)frHndl, hstate);
					(*frHndl)->doc.compMovesWhite = (*frHndl)->doc.keepCMWhite;
					(*frHndl)->doc.compMovesBlack = (*frHndl)->doc.keepCMBlack;
					if ((*frHndl)->doc.timeLeft[0] != -1)
						for (i = 0; i < 2; ++i)
							(*frHndl)->doc.timeLeft[i] = (*frHndl)->doc.defaultTime[i];
					break;
			}
		}

		if (!err) {		/* Read move info from file. */
			gameMovesHndl = (*frHndl)->doc.gameMoves;
			count         = (*frHndl)->doc.numGameMoves * sizeof(GameElement);
			SetHandleSize((Handle)gameMovesHndl, count);
			err = MemError();
			if (!err) {
				hstate = LockHandleHigh((Handle)gameMovesHndl);
				err = FSRead(fileRefNum, &count, (Ptr)(*gameMovesHndl));
				HSetState((Handle)gameMovesHndl, hstate);
				(*frHndl)->doc.timerRefTick = TickCount();
				(*frHndl)->doc.displayTime[0] = -1;
				(*frHndl)->doc.displayTime[1] = -1;
				(*frHndl)->doc.freezeTime[0] = -1;
				(*frHndl)->doc.freezeTime[1] = -1;
				(*frHndl)->fileState.docDirty = false;
				if (!err)
					if ((*frHndl)->doc.version != kVersion)
						err = kWrongVersion;
			}
		}
	}

	if (!err) {		/* Read TextEdit text from file. */
		textHndl = (Handle)(*frHndl)->doc.legalMoves;
			/* There may be text saved to the file.  If there is any, this text
			** belongs in the out-box TextEdit control.  AppNewWindow creates
			** this control.  The problem is that a document is read before the
			** window for it is created.  Therefore the text will be placed
			** temporarily in the legalMoves handle.  Once GenerateLegalMoves
			** is called, the content of this handle will be overwritten.
			** GenereteLegalMoves isn't called until the window is created, so
			** this is an easy way to pass the text to AppNewWindow. */
		count = 32000;
			/* The size of the text isn't saved to disk.  This is the maximum
			** that we will accept. */
		SetHandleSize(textHndl, count);
		if (!(err = MemError())) {
			hstate = LockHandleHigh(textHndl);
			err    = FSRead(fileRefNum, &count, *textHndl);
			HSetState((Handle)frHndl, hstate);
			if (err == eofErr) err = noErr;
			if (err) count = 0;
			SetHandleSize(textHndl, count);
				/* Set the handle to the actual size of the text on disk. */
		}
	}

	return(err);
}



/*****************************************************************************/



/* AppWriteDocument
**
** Writes the data portion of a document handle to the specified file. */

#pragma segment File
OSErr	AppWriteDocument(FileRecHndl frHndl)
{
	short			fileRefNum;
	OSErr			err;
	char			hstate;
	Ptr				ptr1, ptr2;
	long			count, fpos;
	GameListHndl	gameMovesHndl;
	TEHandle		te;
	Handle			textHndl;
	WindowPtr		window;
	short			width;

	fileRefNum = (*frHndl)->fileState.refNum;

	err = SetFPos(fileRefNum, fsFromStart, 0);
		/* Set the file position to the beginning of the file. */

	if (!err) {		/* Write board info to file. */
		hstate = LockHandleHigh((Handle)frHndl);
		ptr1   = (Ptr)&((*frHndl)->doc);
		ptr2   = (Ptr)&((*frHndl)->doc.endFileInfo1);
		count  = (long)ptr2 - (long)ptr1;
		err    = FSWrite(fileRefNum, &count, ptr1);
		HSetState((Handle)frHndl, hstate);
	}

	if (!err) {		/* Write board info to file. */
		hstate = LockHandleHigh((Handle)frHndl);
		(*frHndl)->doc.reconnectZone[0]    = 0;
		(*frHndl)->doc.reconnectMachine[0] = 0;
		if ((*frHndl)->doc.twoPlayer) {
			pcpy((*frHndl)->doc.reconnectZone,    (*frHndl)->doc.opponentZone);
			pcpy((*frHndl)->doc.reconnectMachine, (*frHndl)->doc.opponentMachine);
		}
		(*frHndl)->doc.justBoardWindow = false;
		if (window = (*frHndl)->fileState.window) {
			width = window->portRect.right - window->portRect.left;
			if (width == rJustBoardWindowWidth) (*frHndl)->doc.justBoardWindow = true;
		}
		(*frHndl)->doc.keepCMWhite = (*frHndl)->doc.compMovesWhite;
		(*frHndl)->doc.keepCMBlack = (*frHndl)->doc.compMovesBlack;
		ptr1  = (Ptr)&((*frHndl)->doc.reconnectZone);
		ptr2  = (Ptr)&((*frHndl)->doc.endFileInfo2);
		count = (long)ptr2 - (long)ptr1;
		err   = FSWrite(fileRefNum, &count, ptr1);
		HSetState((Handle)frHndl, hstate);
	}

	if (!err) {		/* Write move info to file. */
		gameMovesHndl = (*frHndl)->doc.gameMoves;
		count         = (*frHndl)->doc.numGameMoves * sizeof(GameElement);
		hstate = LockHandleHigh((Handle)gameMovesHndl);
		err = FSWrite(fileRefNum, &count, (Ptr)(*gameMovesHndl));
		HSetState((Handle)gameMovesHndl, hstate);
	}

	if (!err) {		/* Write out-box TextEdit control text to file. */
		te       = (*frHndl)->doc.message[kMessageOut];
		textHndl = (*te)->hText;
		count    = (*te)->teLength;
		hstate   = LockHandleHigh(textHndl);
		err      = FSWrite(fileRefNum, &count, *textHndl);
		HSetState(textHndl, hstate);
	}

	if (!err) {
		err = GetFPos(fileRefNum, &fpos);
		if (!err) err = SetEOF(fileRefNum, fpos);
	}

	return(err);
}



/*****************************************************************************/



#pragma segment File
OSErr	AppDuplicateDocument(FileRecHndl oldFrHndl, FileRecHndl *newFrHndl)
{
	OSErr			err;
	GameListHndl	oldMoves, newMoves;
	Ptr				ptr1, ptr2;
	long			oldMovesSize, dataSize;
	Handle			oldText, newText;
	TEHandle		te;
	short			winNameType;

	winNameType = ksOrigName;
	if ((*oldFrHndl)->doc.myColor == kMessageDoc) winNameType = ksMssgName;

	err = AppNewDocument(newFrHndl, winNameType);
	if (!err) {
		oldMoves = (*oldFrHndl)->doc.gameMoves;
		newMoves = (**newFrHndl)->doc.gameMoves;
		oldMovesSize = GetHandleSize((Handle)oldMoves);
		SetHandleSize((Handle)newMoves, oldMovesSize);
		err = MemError();
		if (!err) {
			ptr1     = (Ptr)&((*oldFrHndl)->doc);
			ptr2     = (Ptr)&((*oldFrHndl)->doc.endFileInfo1);
			dataSize = (long)ptr2 - (long)ptr1;
			ptr2     = (Ptr)&((**newFrHndl)->doc);
			BlockMove(ptr1, ptr2, dataSize);
			(**newFrHndl)->doc.timeLeft[0] = (**newFrHndl)->doc.timeLeft[1] = -1;
			BlockMove((Ptr)*oldMoves, (Ptr)*newMoves, oldMovesSize);
			if ((*oldFrHndl)->doc.myColor == kMessageDoc) {
				te = (*oldFrHndl)->doc.message[kMessageOut];
				oldText = (*te)->hText;
				newText = (Handle)(**newFrHndl)->doc.legalMoves;
				SetHandleSize(newText, (*te)->teLength);
				err = MemError();
				if (!err) BlockMove(*oldText, *newText, (*te)->teLength);
			}
		}
	}
	return(err);
}



/*****************************************************************************/



#pragma segment File
OSErr	AppAutoLaunch(FileRecHndl frHndl)
{
	OSErr			err;
	AEDesc			remoteDesc, aeDirDesc, listElem, fileList;
	AppleEvent		aevt, aeReply;
	char			hstate;
	Str255			path;
	Str255			app;
	AliasHandle		dirAlias, fileAlias;

	err = noErr;

	if ((*frHndl)->doc.reconnectZone[0]) {

		DoSetCursor(*GetCursor(watchCursor));

		if (!GetRemoteProcessTarget(frHndl, &remoteDesc, FinderFilter)) {

			err = AECreateAppleEvent('FNDR', 'sope', &remoteDesc,
									  kAutoGenerateReturnID, kAnyTransactionID, &aevt);
			AEDisposeDesc(&remoteDesc);

			if (!err) {

				hstate = LockHandleHigh((Handle)frHndl);
				pcpy(path, (*frHndl)->doc.reconnectPath);
				pcpy(app, path);
				pcat(app,  (*frHndl)->doc.reconnectApp);
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

				if (!err) SendGame(frHndl, kIsMove, "\pKibitz");

			}
		}
	}

	return(err);
}




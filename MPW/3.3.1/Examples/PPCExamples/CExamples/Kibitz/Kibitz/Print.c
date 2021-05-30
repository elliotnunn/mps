/*
** Apple Macintosh Developer Technical Support
**
** MultiFinder-Aware Shell Application
**
** File:        print.c
** Written by:  Eric Soldan
** Based on:    Code from Pete "Luke" Alexander.
**
** Copyright © 1989-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif



/*****************************************************************************/



pascal void			PrintIdleProc(void);
short				gPrintPage;
static DialogPtr	PrintingStatusDialog;



/*****************************************************************************/



/* This print-loop function is designed to be called under various situations.
** The big issue that it handles is finder printing.  If multiple documents
** are to be printed from the finder, the user should only see one job dialog
** for all the files.  (If a job dialog is shown for each file, how does the
** user know for which file the dialog is for?)  So, for situations where
** there is more than one file to be printed, call this code the first time
** with the firstJob boolean true.  Normally, the jobDlg boolean will also
** be true, except that under 7.0, you may be printing in the background.
** If this is the case, you don't want a job dialog for even the first file,
** and you should pass in false for the jobDlg boolean in this case.  For
** files 2-N, you should pass false for both booleans.  For regular application
** printing, you should pass true for both booleans, since the file is the
** first (only) file, and you are not in the background.
**
** After calling this function to print a document, you need to call it
** again with a nil document handle.  The print record for the first (or only)
** document printed is preserved in a static variable.  This is so that the
** job dialog information can be passed on to documents 2-N in the print job.
** Calling this function with the document handle nil tells this function
** that you are done printing documents, and that the print record for the
** first job can be disposed of. */

#pragma segment Print
OSErr	AppPrintDocument(FileRecHndl frHndl, Boolean jobDlg, Boolean firstJob)
{
	OSErr			err;
	THPrint			prRecHndl;
	TPPrPort		printPort;
	GrafPtr			oldPort;
	short			i, keepResFile, copies, fstPage, lstPage;
	TPrStatus		status;
	ControlHandle	proceedButton;
	Rect 			rct;
	
	static PrIdleUPP	printIdleUPP = nil;
	static THPrint		prMergeHndl;

	if (!frHndl) {
		if (prMergeHndl) {
			DisposHandle((Handle)prMergeHndl);
			prMergeHndl = nil;
		}
		return(noErr);
	}

	PrintingStatusDialog = nil;

	if (!(prRecHndl = (THPrint)NewHandle(sizeof(TPrint)))) return(memFullErr);
		/* If we can't generate a print record handle, we are out of here. */

	BlockMove((Ptr)&((*frHndl)->doc.print), (Ptr)(*prRecHndl), sizeof(TPrint));
		/* Get the document's print info into the print record handle. */

	GetPort(&oldPort);

	DoSetCursor(&qd.arrow);
	PrOpen();
	err = PrError();

	if (!err) {
		keepResFile = CurResFile();

		if (!(*frHndl)->doc.printRecValid) {
			PrintDefault(prRecHndl);			/* The document print record was never 
			err = PrError();					** initialized.  Now is is. */
		}			
		if (!err) {
			PrValidate(prRecHndl);		/* Do this just 'cause Apple says so. */
			err = PrError();
		}
		if (!err) {
			if (jobDlg) {				/* User gets to click some buttons. */
				if (!(PrJobDialog(prRecHndl))) err = userCanceledErr;
				else						   err = PrError();
			}
		}
		if (!err) {
			if (!firstJob) {
				fstPage = (*prMergeHndl)->prJob.iFstPage;
				lstPage = (*prMergeHndl)->prJob.iLstPage;
				PrJobMerge(prMergeHndl, prRecHndl);
				(*prMergeHndl)->prJob.iFstPage = (*prRecHndl)->prJob.iFstPage = fstPage;
				(*prMergeHndl)->prJob.iLstPage = (*prRecHndl)->prJob.iLstPage = lstPage;
				err = PrError();
			}
		}

		if (!err) {			/* Put the defaulted/validated/jobDlg'ed print record in the doc. */
			fstPage = (*prRecHndl)->prJob.iFstPage;
			lstPage = (*prRecHndl)->prJob.iLstPage;
			copies  = (*prRecHndl)->prJob.iCopies;
			BlockMove((Ptr)(*prRecHndl), (Ptr)&((*frHndl)->doc.print), sizeof(TPrint));
			(*frHndl)->doc.printRecValid = true;

			ParamText((*frHndl)->fileState.fss.name, nil, nil, nil);
			PrintingStatusDialog = GetNewDialog(rPrStatusDlg, nil, (WindowPtr)-1);
			if (PrintingStatusDialog) {
				GetDItem(PrintingStatusDialog, 1, &i, (Handle *)&proceedButton, &rct);
				HiliteControl(proceedButton, 255);
					/* Setup the proceed/pause/cancel dialog with the document name. */
				if (!printIdleUPP)
					printIdleUPP = NewPrIdleProc (PrintIdleProc);
				(*prRecHndl)->prJob.pIdleProc = printIdleUPP;
				UseResFile(keepResFile);
					/* Hook in the proceed/pause/cancel dialog. */
			}

			for (i = 1; (i <= copies) && (!err); ++i) {

				printPort = PrOpenDoc(prRecHndl, nil, nil);
				if (!(err = PrError())) {

					gPrintPage = 1;
					while (gPrintPage <= lstPage) {

						PrOpenPage(printPort, nil);

						if (!(err = PrError()))
							ImageDocument(frHndl, false);
								/* Do the print thing here. */

						PrClosePage(printPort);

						if (!gPrintPage) break;
						++gPrintPage;
					}
					gPrintPage = 0;
					PrCloseDoc(printPort);
				}
			}
		}

		if (
			(!err) &&
			((*prRecHndl)->prJob.bJDocLoop == bSpoolLoop) &&
			(!(err = PrError()))
		) {
			PrPicFile(prRecHndl, nil, nil, nil, &status);
			err = PrError();
		}
	}

	if (firstJob) prMergeHndl = prRecHndl;
	else		  DisposHandle((Handle)prRecHndl);

	if (PrintingStatusDialog) DisposDialog(PrintingStatusDialog);

	PrClose();
	SetPort(oldPort);

	return(err);
}



/*****************************************************************************/



/* PrintIdleProc will handle events in the 'Printing Status Dialog' which
** gives the user the option to 'Proceed', 'Pause', or 'Cancel' the current
** printing job during print time.
**
** The buttons:
**		1: Proceed
**		2: Pause
**		3: Cancel  */

#pragma segment Print
pascal void		PrintIdleProc(void)
{
	Boolean				button, paused;
	ControlHandle		pauseButton, proceedButton;
    DialogPtr			aDialog;
	EventRecord			anEvent;
    GrafPtr				oldPort;
	Rect 				rct;
    short				item, itemType, keepResFile;

	GetPort(&oldPort);

	UseResFile(keepResFile = CurResFile());

	GetDItem(PrintingStatusDialog, 1, &itemType, (Handle *)&proceedButton, &rct);
	HiliteControl(proceedButton, 255);
	GetDItem(PrintingStatusDialog, 2, &itemType, (Handle *)&pauseButton, &rct);

	paused = false;
	do {
		if (GetNextEvent((mDownMask + mUpMask + updateMask), &anEvent)) {
			if (PrintingStatusDialog != FrontWindow ())
			SelectWindow(PrintingStatusDialog);

			if (IsDialogEvent(&anEvent)) {
				button = DialogSelect(&anEvent, &aDialog, &item);

				if ((button) && (aDialog == PrintingStatusDialog)) {
					switch (item) {
						case 1:
							HiliteControl(pauseButton, 0);		/* Enable PAUSE    */
							HiliteControl(proceedButton, 255);	/* Disable PROCEED */
							paused = false;
							break;
						case 2:
							HiliteControl(pauseButton, 255);	/* Disable PAUSE  */
							HiliteControl(proceedButton, 0);	/* Enable PROCEED */
							paused = true;
							break;
						case 3:
							PrSetError(iPrAbort);               /* CANCEL printing */
							paused = false;
							break;
					}
				}
			}
		}
	} while (paused != false); 

	SetPort(oldPort);
}



/*****************************************************************************/



#pragma segment Print
OSErr	PresentStyleDialog(FileRecHndl frHndl)
{
	OSErr		err;
	THPrint		prRecHndl;

	if (!(prRecHndl = (THPrint)NewHandle(sizeof(TPrint))))
		return(memFullErr);

	PrOpen();

	if (!(err = PrError())) {

		BlockMove((Ptr)&(*frHndl)->doc.print, (Ptr)*prRecHndl, sizeof(TPrint));
			/* Get data, valid or not. */

		if (!(*frHndl)->doc.printRecValid) PrintDefault(prRecHndl);
		else								PrValidate(prRecHndl);
		if (!(err = PrError())) {
			if (PrStlDialog(prRecHndl)) {
				BlockMove((Ptr)*prRecHndl, (Ptr)&(*frHndl)->doc.print, sizeof(TPrint));
				(*frHndl)->doc.printRecValid  = true;
				(*frHndl)->fileState.docDirty = true;
			}
			else err = userCanceledErr;
		}
	}

	DisposHandle((Handle)prRecHndl);
	PrClose();

	return(err);
}




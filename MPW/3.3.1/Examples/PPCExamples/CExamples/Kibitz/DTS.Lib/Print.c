/*
** Apple Macintosh Developer Technical Support
**
** Program:     DTS.Lib
** File:        print.c
** Written by:  Eric Soldan
** Based on:    Code from Pete "Luke" Alexander.
**
** Copyright © 1989-1991 Apple Computer, Inc.
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
#include <Resources.h>
#endif

#ifndef __STRINGUTILS__
#include "StringUtils.h"
#endif



/*****************************************************************************/



static pascal void	PrintIdleProc(void);
short				gPrintPage;
static DialogPtr	gPrintingStatusDialog;



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
OSErr	PrintDocument(FileRecHndl frHndl, Boolean jobDlg, Boolean firstJob)
{
	OSErr			err;
	THPrint			prRecHndl;
	TPPrPort		printPort;
	GrafPtr			oldPort;
	short			i, keepResFile, copies, fstPage, lstPage;
	TPrStatus		status;
	ControlHandle	proceedButton;
	Rect 			rct;
	Handle			txtHndl;
	Str255			txt, txt2;
	
	static PrIdleUPP	printIdleUPP = nil;
	static THPrint		prMergeHndl;

	if (!frHndl) {
		if (prMergeHndl) {
			DisposeHandle((Handle)prMergeHndl);
			prMergeHndl = nil;
		}
		return(noErr);
	}

	gPrintingStatusDialog = nil;

	if (!(prRecHndl = (THPrint)NewHandle(sizeof(TPrint)))) return(memFullErr);
		/* If we can't generate a print record handle, we are out of here. */

	BlockMove((Ptr)&((*frHndl)->d.doc.fhInfo.print), (Ptr)(*prRecHndl), sizeof(TPrint));
		/* Get the document's print info into the print record handle. */

	GetPort(&oldPort);

	DoSetCursor(&qd.arrow);

	keepResFile = CurResFile();
	PrOpen();
	err = PrError();

	if (!err) {
		if (!(*frHndl)->d.doc.fhInfo.printRecValid) {
			PrintDefault(prRecHndl);			/* The document print record was never 
			err = PrError();					** initialized.  Now is is. */
		}
		if (!err) {
			PrValidate(prRecHndl);		/* Do this just 'cause Apple says so. */
			err = PrError();
		}
		if (!err) {
			if (jobDlg) {				/* User gets to click some buttons. */
				UnhiliteWindows();
				if (!(PrJobDialog(prRecHndl)))
					err = userCanceledErr;
				else
					err = PrError();
				HiliteWindows();
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
					/* For documents other than the first, do the PrJobMerge thing.
					** Unfortunately, PrJobMerge is kind of broken.  The first and last
					** page fields have to be cached and put back.  The rest of PrJobMerge
					** seems to work okay. */
			}
		}

		if (!err) {			/* Put the defaulted/validated/jobDlg'ed print record in the doc. */
			fstPage = (*prRecHndl)->prJob.iFstPage;
			lstPage = (*prRecHndl)->prJob.iLstPage;
			copies  = (*prRecHndl)->prJob.iCopies;
			BlockMove((Ptr)(*prRecHndl), (Ptr)&((*frHndl)->d.doc.fhInfo.print), sizeof(TPrint));
			(*frHndl)->d.doc.fhInfo.printRecValid = true;

			gPrintingStatusDialog = nil;
			i = ((*prRecHndl)->prStl.wDev >> 8) & 0xFF;
			if ((i == 1) || (i == 2))
				gPrintingStatusDialog = GetNewDialog(rPrStatusDlg, nil, (WindowPtr)-1);
			if (gPrintingStatusDialog) {
					/* The ImageWriter driver uses ParamText, so we can’t.
					** If we try to, then the printer name shows up, instead of
					** the document name.  Due to this, we have to parse our
					** own text.  We expect dialog item#4 to have a c/r in it.
					** We use the c/r instead of ^0, due to the ImageWriter driver.
					** We just replace the c/r with the name of the document. */
				GetDItem(gPrintingStatusDialog, 4, &i, (Handle *)&txtHndl, &rct);
				GetIText(txtHndl, txt);
				for (i = *txt; i; --i) {
					if (txt[i] == 13) {
						txt[i] = *txt - i;
						txt[0] = i - 1;
						break;
					}
				}		/* We now have two pascal strings -- one right after the other. */
				pcpy(txt2, txt);								/* Copy the first string. */
				pcat(txt2, (*frHndl)->fileState.fss.name);		/* Append the document name. */
				pcat(txt2, txt + *txt + 1);						/* Append the second string. */
				SetIText(txtHndl, txt2);
				GetDItem(gPrintingStatusDialog, 1, &i, (Handle *)&proceedButton, &rct);
				HiliteControl(proceedButton, 255);
					/* Setup the proceed/pause/cancel dialog with the document name. */
				if (!printIdleUPP)
					printIdleUPP = NewPrIdleProc (PrintIdleProc);
				(*prRecHndl)->prJob.pIdleProc = printIdleUPP;
				UseResFile(keepResFile);		/* Hook in the proceed/pause/cancel dialog. */
				UnhiliteWindows();
			}

			for (i = 1; (i <= copies) && (!err); ++i) {

				printPort = PrOpenDoc(prRecHndl, nil, nil);
				if (!(err = PrError())) {

					gPrintPage = 1;
					while (gPrintPage <= lstPage) {

						PrOpenPage(printPort, nil);

						if (!(err = PrError()))
							err = DoImageDocument(frHndl);
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

	if (firstJob)
		prMergeHndl = prRecHndl;
	else
		DisposeHandle((Handle)prRecHndl);

	if (gPrintingStatusDialog)
		DisposeDialog(gPrintingStatusDialog);

	PrClose();
	UseResFile(keepResFile);

	SetPort(oldPort);
	HiliteWindows();

	if (err == iIOAbortErr)
		err = noErr;

	return(err);
}



/*****************************************************************************/



/* DonePrinting makes sure that PrintDocument gets rid of the prMergeHndl
** print record that is used for multiple document printing.  Call this after
** or the last document is printed, or you get a memory leak. */

#pragma segment Print
void	DonePrinting(void)
{
	PrintDocument(nil, false, false);
}



/*****************************************************************************/



/* PrintIdleProc will handle events in the 'Printing Status Dialog' which
** gives the user the option to 'Proceed', 'Pause', or 'Cancel' the current
** printing job during print time.
**
** The buttons:
**		1: Proceed
**		2: Pause
**		3: Cancel
*/

#pragma segment Print
pascal void	PrintIdleProc(void)
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

	GetDItem(gPrintingStatusDialog, 1, &itemType, (Handle *)&proceedButton, &rct);
	HiliteControl(proceedButton, 255);
	GetDItem(gPrintingStatusDialog, 2, &itemType, (Handle *)&pauseButton, &rct);

	paused = false;
	do {
		if (GetNextEvent((mDownMask + mUpMask + updateMask), &anEvent)) {
			if (gPrintingStatusDialog != FrontWindow())
				SelectWindow(gPrintingStatusDialog);

			if (IsDialogEvent(&anEvent)) {
				button = DialogSelect(&anEvent, &aDialog, &item);

				if ((button) && (aDialog == gPrintingStatusDialog)) {
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



/* Call this from the application to present a style dialog.  The changes are
** automatically saved in the document. */

#pragma segment Print
OSErr	PresentStyleDialog(FileRecHndl frHndl)
{
	OSErr		err;
	THPrint		prRecHndl;
	short		oldRes;

	if (!(prRecHndl = (THPrint)NewHandle(sizeof(TPrint)))) return(memFullErr);

	oldRes = CurResFile();
	PrOpen();

	if (!(err = PrError())) {

		BlockMove((Ptr)&(*frHndl)->d.doc.fhInfo.print, (Ptr)*prRecHndl, sizeof(TPrint));
			/* Get data, valid or not. */

		if (!(*frHndl)->d.doc.fhInfo.printRecValid)
			PrintDefault(prRecHndl);
		else
			PrValidate(prRecHndl);

		if (!(err = PrError())) {
			UnhiliteWindows();
			if (PrStlDialog(prRecHndl)) {
				BlockMove((Ptr)*prRecHndl, (Ptr)&(*frHndl)->d.doc.fhInfo.print, sizeof(TPrint));
				(*frHndl)->d.doc.fhInfo.printRecValid = true;
			}
			else err = userCanceledErr;
			HiliteWindows();
		}
	}

	DisposeHandle((Handle)prRecHndl);
	PrClose();
	UseResFile(oldRes);

	return(err);
}




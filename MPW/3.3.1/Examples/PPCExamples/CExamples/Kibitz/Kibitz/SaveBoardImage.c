/*
** Apple Macintosh Developer Technical Support
**
** File:        saveboardimage.c
** Writtem by:  Eric Soldan
**
** Copyright © 1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/


typedef struct TMDHdr {
	OSType	fType;
	short	hdrID;
	short	version;
	short	prRec[60];
	Fixed	xOrigin;
	Fixed	yOrigin;
	Point	xScale;
	Point	yScale;
	short	atrState[31];
	short	lCnt;
	short	lTot;
	long	lSiz;
	Rect	lR2D;
	short	filler1[145];
} TMDhdr;

static TMDhdr	boardHeader = {
	'PICT',
	0x0000		/* NOT MacDraw II specific data.  Just simple PICT. */
};

extern short	gPrintPage;



/*****************************************************************************/



#pragma segment File
OSErr	SaveBoardImage(FileRecHndl frHndl)
{
	StandardFileReply	reply;
	FInfo				finfo;
	WindowPtr			oldPort;
	Rect				boardRect;
	short				fileRefNum;
	PicHandle			boardImage;
	long				count;
	OSErr				err;

	reply.sfFile.name[0] = 0;
	if (!DisplayPutFile(&reply)) return(userCanceledErr);		/* User canceled the save. */

	if (err = Create_OpenFile(&reply.sfFile, &fileRefNum, 'PICT')) return(err);		/* Oops. */

	HGetFInfo(reply.sfFile.vRefNum, reply.sfFile.parID, reply.sfFile.name, &finfo);
	finfo.fdCreator = 'ttxt';
	HSetFInfo(reply.sfFile.vRefNum, reply.sfFile.parID, reply.sfFile.name, &finfo);

	oldPort = SetFilePort(frHndl);

	boardRect = BoardRect();
	InsetRect(&boardRect, -1, -1);
	boardImage = OpenPicture(&boardRect);
	if (!boardImage) {
		SetPort(oldPort);
		return(memFullErr);
	}

	ImageBoardLines(1, kBoardHOffset, kBoardVOffset);
	gPrintPage = -1;
	ImageDocument(frHndl, true);
	gPrintPage = 0;

	ClosePicture();

	err = SetFPos(fileRefNum, fsFromStart, 0);
		/* Set the file position to the beginning of the file. */

	if (!err) {
		count = sizeof(TMDhdr);
		err   = FSWrite(fileRefNum, &count, (Ptr)&boardHeader);
	}

	if (!err) {
		HLock((Handle)boardImage);
		count = GetHandleSize((Handle)boardImage);
		err   = FSWrite(fileRefNum, &count, (Ptr)*boardImage);
	}
	KillPicture(boardImage);

	FSClose(fileRefNum);
	SetPort(oldPort);

	return(err);
}




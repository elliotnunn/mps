/*
** Apple Macintosh Developer Technical Support
**
** Program:         datacontrol.c
** Written by:      Eric Soldan
**
** Copyright © 1992 Apple Computer, Inc.
** All rights reserved.
*/

/* Data control theory of operation:
**
** The Data control is used simply as a data holder for data related to a window.
** The advantage to using this control is that when the window is disposed of,
** the data is automatically disposed of.  This allows you to create a handle for
** storage of auxiliary window data and not have to worry about its disposal. */

/* The Data control is always invisible, inactive, and non-hittable.  As it does nothing,
** you can use most fields for storage of information.  The fields you can use are:
**
** struct ControlRecord {
**    struct ControlRecord **nextControl;
**    WindowPtr contrlOwner;
**    Rect contrlRect;						can use
**    unsigned char contrlVis;
**    unsigned char contrlHilite;
**    short contrlValue;					can use
**    short contrlMin;						can use
**    short contrlMax;						can use
**    Handle contrlDefProc;
**    Handle contrlData;					can use to store a handle
**    ProcPtr contrlAction;
**    long contrlRfCon;						can use
**    Str255 contrlTitle;					can use
** };
**
** The contrlData field is either nil or it holds a handle.  If not nil, then the
** handle is dispose of when the control is disposed of. */



/*****************************************************************************/



#ifndef __CONTROLS__
#include <Controls.h>
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif



pascal long		CDataCtl   (short varCode, ControlHandle ctl, short msg, long parm);



/*****************************************************************************/



#pragma segment DataCDEF
pascal long	CDataCtl(short varCode, ControlHandle ctl, short msg, long parm)
{
#pragma unused (varCode)

	Rect	rct;

	switch (msg) {

		case drawCntl:
			break;

		case testCntl:
			if (varCode == 1) {
				rct = (*ctl)->contrlRect;
				if (PtInRect(*(Point *)&parm, &rct)) return(1);
			}
			break;

		case calcCRgns:
		case calcCntlRgn:
			if (msg == calcCRgns)
				parm &= 0x00FFFFFF;
			SetRectRgn((RgnHandle)parm, 0, 0, 0, 0);
			break;

		case initCntl:
			(*ctl)->contrlData = nil;
			break;

		case dispCntl:
			if ((*ctl)->contrlData)
				DisposeHandle((Handle)(*ctl)->contrlData);
			break;

		case posCntl:
			break;

		case thumbCntl:
			break;

		case dragCntl:
			break;

		case autoTrack:
			break;
	}

	return(0);
}




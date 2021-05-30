/*
** Apple Macintosh Developer Technical Support
**
** Program:         ICONCDEF.c
** Written by:      Eric Soldan
**
** Copyright © 1992 Apple Computer, Inc.
** All rights reserved.
*/



/*****************************************************************************/



#ifndef __CONTROLS__
#include <Controls.h>
#endif

#ifndef __FONTS__
#include <Fonts.h>
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif



pascal long		CICONCtl(short varCode, ControlHandle ctl, short msg, long parm);



/*****************************************************************************/



#pragma segment ICONCDEF
pascal long	CICONCtl(short varCode, ControlHandle ctl, short msg, long parm)
{
	Rect			rct;
	Handle			icn;
	unsigned char	gray[8];

	rct = (*ctl)->contrlRect;

	switch (msg) {

		case drawCntl:
			switch (varCode & (short)0xFFF7) {
				case 0:
					if (icn = GetIcon((*ctl)->contrlRfCon)) PlotIcon(&rct, icn);
					break;
				case 1:
					FrameRect(&rct);
					break;
				case 2:
					gray[0] = gray[2] = gray[4] = gray[6] = 0xAA;
					gray[1] = gray[3] = gray[5] = gray[7] = 0x55;
					PenPat((ConstPatternParam)gray);
					FrameRect(&rct);
					PenNormal();
					break;
				case 3:
					EraseRect(&rct);
					break;
			}
			break;

		case testCntl:
			break;

		case calcCRgns:
		case calcCntlRgn:
			if (msg == calcCRgns)
				parm &= 0x00FFFFFF;
			RectRgn((RgnHandle)parm, &rct);
			break;

		case initCntl:
			break;

		case dispCntl:
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




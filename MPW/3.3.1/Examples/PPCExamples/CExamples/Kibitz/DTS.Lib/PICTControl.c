/*
** Apple Macintosh Developer Technical Support
**
** Program:         pictcontrol.c
** Written by:      Eric Soldan
**
** Copyright © 1993 Apple Computer, Inc.
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



#ifndef __PICTCONTROL__
#include "PICTControl.h"
#endif

#ifndef __CONTROLS__
#include <Controls.h>
#endif

#ifndef __DTSLib__
#include "DTS.Lib.h"
#endif

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __FONTS__
#include <Fonts.h>
#endif

#ifndef __GWLAYERS__
#include "GWLayers.h"
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifndef __PACKAGES__
#include <Packages.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __STRINGUTILS__
#include "StringUtils.h"
#endif

#ifndef __UTILITIES__
#include "Utilities.h"
#endif



/*****************************************************************************/



#if defined(powerc) || defined (__powerc)
#pragma options align=mac68k
#endif
typedef struct cdefRsrcJMP {
	long	jsrInst;
	long	moveInst;
	short	jmpInst;
	long	jmpAddress;
} cdefRsrcJMP;
typedef cdefRsrcJMP *cdefRsrcJMPPtr, **cdefRsrcJMPHndl;
#if defined(powerc) || defined(__powerc)
#pragma options align=reset
#endif



/*****************************************************************************/



short	gPICTCtl = rPICTCtl;

extern ControlHandle	gWhichCtlHit;
extern Boolean			gWhichCtlDbl;
extern Boolean			gWhichCtlTracking;

static pascal long		CPICTCtl   (short varCode, ControlHandle ctl, short msg, long parm);
static pascal void		CPICTAction(ControlHandle ctl, short part);
static pascal void		NoRect(GrafVerb verb, Rect *r);

static cdefRsrcJMPHndl	gCDEF;



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



#pragma segment Controls
static pascal long	CPICTCtl(short varCode, ControlHandle ctl, short msg, long parm)
{
	Rect				viewRct, r;
	short				thisHilite, keepHilite;
	unsigned long		resPICTID, id, variant, sticky, offScreen, srcOrMode;
	PicHandle			pict;
	ControlHandle		cc;
	WindowPtr			ww, curPort, keepPort;
	LayerObj			wlayer, blayer;
	RgnHandle			oldClip, newClip, colorRgn;
	short				txFont, txSize, txMode, fnum;
	Style				txFace;
	QDProcs				qdp;
	QDProcsPtr			oldqdp;
	FontInfo			finfo;
	ControlStyleInfo	cinfo;

	static QDRectUPP	qdrupp;

	viewRct    = (*ctl)->contrlRect;
	thisHilite = (*ctl)->contrlHilite;
	resPICTID  = (*ctl)->contrlRfCon & 0x0000FFFFL;
	variant    = (*ctl)->contrlRfCon & 0xFFFF0000L;
	sticky     = variant & 0x00010000L;
	offScreen  = variant & 0x00020000L;
	srcOrMode  = variant & 0x00080000L;

	switch (msg) {

		case drawCntl:

			GetPort(&curPort);						/* Find out color area v.s. b/w area. */
			if (offScreen) {
				NewLayer(&wlayer, nil, nil, curPort, 0, 0);
				if (srcOrMode) (*wlayer)->xferMode = srcOr;
				r = curPort->portRect;
				SectRect(&r, &viewRct, &r);
				(*wlayer)->dstRect = r;				/* Minimize the size of the offscreen. */
				NewLayer(&blayer, wlayer, nil, nil, (*ctl)->contrlMin, 0);
				SetLayerWorld(blayer);
				InvalLayer(wlayer, r, false);
			}

			if (sticky) {
				if (thisHilite < 2)
					thisHilite = (*ctl)->contrlValue;
				if (thisHilite == 2)
					thisHilite = 255;
			}

			switch (thisHilite) {
				case 1:
				case 255:
					id = (thisHilite == 1) ? (resPICTID + 2) :(resPICTID + 4);
					if (!Get1Resource('PICT', id)) id = resPICTID;
					(*ctl)->contrlRfCon = (id + variant - offScreen);
					keepHilite = (*ctl)->contrlHilite;
					(*ctl)->contrlHilite = 99;
					CPICTCtl(varCode, ctl, msg, parm);
					(*ctl)->contrlHilite = keepHilite;
					(*ctl)->contrlRfCon  = (resPICTID | variant);
					if (thisHilite == 1)
						if (id == resPICTID)
							InvertRect(&viewRct);
								/* If there is no hilite==1 'PICT', invert the base 'PICT'. */
					break;
				default:
					EraseRect(&viewRct);		/* Start pict fresh and clean. */

					if (!(pict = (PicHandle)Get1Resource('PICT', resPICTID))) {
						FrameRect(&viewRct);
						break;
					}

					GetPort(&keepPort);
					SetPort((*ctl)->contrlOwner);
					colorRgn = LocalScreenDepthRegion(4);
					SetPort(keepPort);

					oldClip = NewRgn();
					newClip = NewRgn();
					GetClip(oldClip);			/* Draw color area first. */
					RectRgn(newClip, &curPort->portRect);
					SectRgn(newClip, colorRgn, newClip);
					SetClip(newClip);
					DrawPicture(pict, &viewRct);

					pict = (PicHandle)Get1Resource('PICT', resPICTID + 1);
					if (!pict)
						pict = (PicHandle)Get1Resource('PICT', resPICTID);
					if (pict) {
						RectRgn(newClip, &curPort->portRect);	/* Draw b/w pict area. */
						DiffRgn(newClip, colorRgn, newClip);
						SetClip(newClip);
						DrawPicture(pict, &viewRct);
					}

					SetClip(oldClip);
					DisposeRgn(oldClip);
					DisposeRgn(newClip);
					DisposeRgn(colorRgn);

					break;
			}

			GetPort(&ww);
			txFont = ww->txFont;
			txFace = ww->txFace;
			txSize = ww->txSize;
			if (!(variant & useWFont)) {
				TextFont(systemFont);
				TextFace(normal);
				TextSize(0);
			}
			else {
				if (GetControlStyle(ctl, &cinfo)) {
					TextFace(cinfo.fontStyle);
					fnum = systemFont;
					if (cinfo.font[0])
						GetFNum(cinfo.font, &fnum);
					TextFont(fnum);
					TextSize(cinfo.fontSize);
				}
			}

			if (oldqdp = ww->grafProcs)
				BlockMove(oldqdp, &qdp, sizeof(QDProcs));
			else
				SetStdProcs(&qdp);
			if (!qdrupp) {
#if USES68KINLINES
				qdrupp = (QDRectUPP)NoRect;
#else
				qdrupp = NewQDRectProc(NoRect);
#endif
			}
			qdp.rectProc = qdrupp;
			ww->grafProcs = &qdp;
			txMode = ww->txMode;
			TextMode(srcOr);

			HLock((Handle)ctl);
			GetFontInfo(&finfo);
			viewRct.top += (finfo.ascent + finfo.descent) / 2;
			if (viewRct.top < viewRct.bottom)
				TextBox((*ctl)->contrlTitle + 1, (*ctl)->contrlTitle[0], &viewRct, teCenter);
			HUnlock((Handle)ctl);

			ww->grafProcs = oldqdp;
			TextMode(txMode);

			TextFont(txFont);
			TextFace(txFace);
			TextSize(txSize);

			if (offScreen) {
				UpdateLayer(wlayer);
				ResetLayerWorld(blayer);
				DisposeThisAndBelowLayers(wlayer);
			}

			break;

		case testCntl:

			if ((*ctl)->contrlHilite == 255) return(0);
				/* Control disabled, so no click.  (We probably don't get called in this case. */

			if (!sticky) return(PtInRect(*(Point *)&parm, &viewRct));
				/* Don't make user call WhichControl unless the variant
				** is for double-clicking.  (Then it has to be called.) */

			if (ctl != gWhichCtlHit) return(0);
				/* WhichControl already found the control hit.  Unless it is the one
				** found by WhichControl, consider it unhit. */

			if (gWhichCtlTracking) return(1);
				/* We already handled it, but the control manager is insistent. */

			if (!(*ctl)->contrlValue) {			/* Turn off any other controls in this family. */
				ww = (*ctl)->contrlOwner;
				for (cc = nil; cc = CPICTNext(ww, cc, 1, true);) {
					if (cc != ctl) {
						if (((*cc)->contrlMax & 0xFFF0) == ((*ctl)->contrlMax & 0xFFF0)) {
							if ((*cc)->contrlValue) {
								(*cc)->contrlValue  = 0;
								(*cc)->contrlHilite = 0;
								CPICTCtl(varCode, cc, drawCntl, 0);
							}
						}
					}
				}
			}

			(*ctl)->contrlValue = 1;
			if (gWhichCtlDbl)						/* If user double-clicked... */
				if (!((*ctl)->contrlMax & 0x01))	/* If double-clicking allowed... */
					(*ctl)->contrlValue = 2;

			CPICTCtl(varCode, ctl, drawCntl, 0);

			gWhichCtlTracking = true;
			return(1);

			break;

		case calcCRgns:
		case calcCntlRgn:
			if (msg == calcCRgns)
				parm &= 0x00FFFFFF;
			RectRgn((RgnHandle)parm, &viewRct);
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



/*****************************************************************************/



#pragma segment Controls
ControlHandle	CPICTNew(WindowPtr window, Rect *r, StringPtr title, Boolean vis, short val,
						 short min, short max, short viewID, short refcon)
{
	WindowPtr		oldPort;
	Rect			viewRct, rct;
	Boolean			err;
	ControlHandle	viewCtl;
	unsigned long	variant;
	PicHandle		pict;

	static ControlActionUPP	cupp;
	static ControlDefUPP	cdefupp;

	GetPort(&oldPort);
	SetPort(window);

	viewRct = *r;
	viewCtl = nil;

	err = false;

	if (!gCDEF) {
		gCDEF = (cdefRsrcJMPHndl)GetResource('CDEF', (viewID / 16));
		if (gCDEF) {
			if (!cdefupp) {
				cdefupp = NewControlDefProc(CPICTCtl);
			}
			(*gCDEF)->jmpAddress = (long)cdefupp;
			FlushInstructionCache();	/* Make sure that instruction caches don't kill us. */
		}
		else err = true;
	}

	if (!err) {
		if (viewID & 0x04) {
			viewID -= 0x04;
			if (pict = (PicHandle)Get1Resource('PICT', refcon)) {
				rct = (*pict)->picFrame;
				viewRct.right  = viewRct.left + (rct.right  - rct.left);
				viewRct.bottom = viewRct.top  + (rct.bottom - rct.top);
			}
		}
		variant   = (viewID & 0x0F);
		variant <<= 16;
		viewCtl = NewControl(window, &viewRct, title, vis, val, min, max, viewID, (variant | refcon));
		if (viewCtl) {
			if (!cupp) cupp = NewControlActionProc(CPICTAction);
			SetCtlAction(viewCtl, cupp);
		}
		else
			err = true;
	}

	SetPort(oldPort);

	return(viewCtl);
}



/*****************************************************************************/



#pragma segment Controls
ControlHandle	CPICTNext(WindowPtr window, ControlHandle ctl, short dir, Boolean justActive)
{
	ControlHandle	nextCtl, priorCtl;

	if (!window) return(nil);
	if (!gCDEF)  return(nil);

	if (dir > 0) {
		if (!ctl)
			ctl = ((WindowPeek)window)->controlList;
		else
			ctl = (*ctl)->nextControl;
		while (ctl) {
			if ((!justActive) || ((*ctl)->contrlVis)) {
				if ((!justActive) || ((*ctl)->contrlHilite != 255)) {
					if (*(*ctl)->contrlDefProc == *(Handle)gCDEF)
						return(ctl);
							/* The handle may be locked, which means that the hi-bit
							** may be on, thus invalidating the compare.  Dereference the
							** handles to get rid of this possibility. */
				}
			}
			ctl = (*ctl)->nextControl;
		}
		return(ctl);
	}

	nextCtl = ((WindowPeek)window)->controlList;
	for (priorCtl = nil; ;nextCtl = (*nextCtl)->nextControl) {
		if ((!nextCtl) || (nextCtl == ctl)) return(priorCtl);
		if ((!justActive) || ((*nextCtl)->contrlVis)) {
			if ((!justActive) || ((*nextCtl)->contrlHilite != 255)) {
				if (*(*ctl)->contrlDefProc == *(Handle)gCDEF)
					priorCtl = nextCtl;
						/* The handle may be locked, which means that the hi-bit
						** may be on, thus invalidating the compare.  Dereference the
						** handles to get rid of this possibility. */
			}
		}
	}
}



/*****************************************************************************/



#pragma segment Controls
Boolean	IsPICTCtl(ControlHandle ctl)
{
	if (ctl)
		if (*(*ctl)->contrlDefProc == *(Handle)gCDEF)
			return(true);
				/* The handle may be locked, which means that the hi-bit
				** may be on, thus invalidating the compare.  Dereference the
				** handles to get rid of this possibility. */
	return(false);
}



/*****************************************************************************/



#pragma segment Controls
static pascal void	CPICTAction(ControlHandle ctl, short part)
{
	static short	lastPart = 0;

	if (lastPart != part) {
		lastPart = part;
		CPICTCtl(0, ctl, drawCntl, part);
	}
}



/*****************************************************************************/



#pragma segment Controls
static pascal void	NoRect(GrafVerb verb, Rect *r)
{
#pragma unused (verb, r)
}




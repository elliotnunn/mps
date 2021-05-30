/*
** Apple Macintosh Developer Technical Support
**
** Program:         cciconcontrol.c
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

/* CIcon control theory of operation:
**
** The CIcon control stores the id passed to it in the refCon field of the control.
** When the defProc is called, it draws the 'cicn' smartly using the GWLayers CIcon
** utilities.  (These utilities can draw the 'cicn', even if PlotCIcon isn't available.)
**
** When the CIcon control is hit, it draws that 'cicn' number plus 1.  So, if your id
** for the control is 1000, 'cicn' #1000 is the up-state of the button, and #1001 is
** the down state.  It doesn't just invert the base 'cicn', as that doesn't allow for
** some effects, such as buttons that push in when clicked on.
**
** If there is no base+1 'cicn', then the base 'cicn' is inverted for hilite==1 state.
**
** For hilite==255, if there is a base+2 'cicn', it is drawn, otherwise the base 'cicn' is used.
**
** base, base+1, and base+2 are slight simplifications.  The actual case is base, base+n, base+n+n,
** where n is the number of 'cicn's necessary to tile the control rect.
** 'cicn' #base is upper-left, #base+1 is just to the right, etc.
**
** A variant usage of the CIcon control is a family of buttons.  Instead of tracking
** the single CIcon control, and having it revert back to the unclicked state after
** release, this variation is used for buttons that push in and stick.
**
** The below rules apply for variant #1 of the CIcon control:
**
** • The user clicks on a CIcon control.  As usual, the hilite==1 state is displayed.
** • In addition to the above, any CIcon control in the window with the same family
**   is redrawn in hilite==0 state, and it's value is turned off.  The CIcon control
**   that was clicked on has it's value immediately set to 1.
** • Any variant #1 CIcon control when drawn in hilite==0 state draws as if it is in
**   hilite==1 state.  This means that once the control is clicked on, it's stuck in
**   hilite==1 state.
** • The hilite==255 rules still apply.
** • To allow for a value of 1 to be stored, the max value for the control has to be
**   at least 1.
** • A third state for the control is optional.  The third state is for double-clicking
**   the control down.  Many applications want to make a tool either a one-shot use
**   or permanent use tool.  By allowing double-clicking on the CIcon control, we can
**   accomplish this.
** • The value for a double-clicked CIcon control is 2.  This indicates to the
**   control that it should draw the 'cicn' #base+n+n.
** • To allow for a value of 2, the max value of the control has to be at least 2.
** • The max value for the CIcon control is used as the family number.  The family number
**   is used to determine which other CIcon control to turn off when this control is
**   clicked down.  Due to this other usage of the max value, bit-0 of the max value
**   is used to determine if double-clicking is allowed.
**       odd  family number (max value), single-clicking only.
**       even family number (max value), double-clicking feature enabled.
*/



/*****************************************************************************/



#ifndef __CICONCONTROL__
#include "CIconControl.h"
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

typedef struct CbtnInfo {
	short		resIconID;
	short		hicons, vicons;
	short		variant;
} CbtnInfo;
typedef CbtnInfo *CbtnInfoPtr, **CbtnInfoHndl;



/*****************************************************************************/



short	gCIconCtl = rCIconCtl;

extern ControlHandle	gWhichCtlHit;
extern Boolean			gWhichCtlDbl;
extern Boolean			gWhichCtlTracking;

static pascal long		CCIconCtl   (short varCode, ControlHandle ctl, short msg, long parm);
static pascal void		CCIconAction(ControlHandle ctl, short part);
static pascal void		NoRect(GrafVerb verb, Rect *r);

static cdefRsrcJMPHndl	gCDEF;



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



#pragma segment Controls
static pascal long	CCIconCtl(short varCode, ControlHandle ctl, short msg, long parm)
{
	Rect				viewRct, r;
	short				resIconID;
	CbtnInfoHndl		info;
	short				hicons, vicons, i, h, v, variant, oldCtlVal;
	short				thisHilite, keepHilite, fnum;
	CIconHandle			icon;
	ControlHandle		cc;
	WindowPtr			ww;
	short				txFont, txSize, txMode;
	Style				txFace;
	QDProcs				qdp;
	QDProcsPtr			oldqdp;
	FontInfo			finfo;
	ControlStyleInfo	cinfo;
	LayerObj			wlayer, blayer;

	static QDRectUPP	qdrupp;

	if (!(info = (CbtnInfoHndl)(*ctl)->contrlRfCon)) return(0);

	viewRct    = (*ctl)->contrlRect;
	thisHilite = (*ctl)->contrlHilite;
	variant    = ((*info)->variant & 0xFFF7);

	switch (msg) {

		case drawCntl:

			resIconID = (*info)->resIconID;
			hicons    = (*info)->hicons;
			vicons    = (*info)->vicons;

			if (variant & 0x01) {
				if (thisHilite < 2)
					thisHilite = (*ctl)->contrlValue;
				if (thisHilite == 2)
					thisHilite = 255;
			}

			wlayer = nil;

			switch (thisHilite) {
				case 1:
				case 255:
					i = (thisHilite == 1) ? (resIconID + vicons * hicons) :
											(resIconID + 2 * vicons * hicons);
					if (!Get1Resource('cicn', i)) i = resIconID;
					if (Get1Resource('cicn', i)) {
						(*info)->resIconID = i;
						keepHilite = (*ctl)->contrlHilite;
						(*ctl)->contrlHilite = 99;
						CCIconCtl(varCode, ctl, msg, parm);
						(*ctl)->contrlHilite = keepHilite;
						(*info)->resIconID = resIconID;
						if (thisHilite == 1)
							if (i == resIconID)
								InvertRect(&viewRct);
									/* If there is no hilite==1 'cicn', invert the base 'cicn'. */
					}
					break;
				default:
					if (!Get1Resource('cicn', resIconID)) {
						EraseRect(&viewRct);
						FrameRect(&viewRct);
						break;
					}
					for (i = v = 0; v < vicons;) {
						r.top    = viewRct.top + 64 * v;
						r.bottom = r.top  + 64;
						if (++v == vicons)
							r.bottom = viewRct.bottom;
						if (variant & 0x02) {
							NewLayer(&wlayer, nil, nil, (*ctl)->contrlOwner, 0, 0);
							(*wlayer)->dstRect = viewRct;			/* Minimize the size of the offscreen. */
							NewLayer(&blayer, wlayer, nil, nil, 0, 0);
							SetLayerWorld(blayer);
							EraseRect(&viewRct);
							InvalLayer(wlayer, viewRct, false);
						}
						for (h = 0; h < hicons; ++i) {
							r.left  = viewRct.left + 64 * h;
							r.right = r.left + 64;
							if (++h == hicons)
								r.right = viewRct.right;
							if (icon = ReadCIcon(resIconID + i)) {
								DrawCIcon(icon, r);
								KillCIcon(icon);
							}
						}
					}
					break;
			}

			GetPort(&ww);
			txFont = ww->txFont;
			txFace = ww->txFace;
			txSize = ww->txSize;
			if (!((*info)->variant & useWFont)) {
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

			if (wlayer) {
				UpdateLayer(wlayer);
				ResetLayerWorld(blayer);
				DisposeThisAndBelowLayers(wlayer);
			}

			break;

		case testCntl:

			oldCtlVal = (*ctl)->contrlValue;

			if ((*ctl)->contrlHilite == 255) return(0);
				/* Control disabled, so no click.  (We probably don't get called in this case. */

			if (!(variant & 0x01)) return(PtInRect(*(Point *)&parm, &viewRct));
				/* Don't make user call WhichControl unless the variant
				** is for double-clicking.  (Then it has to be called.) */

			if (ctl != gWhichCtlHit) return(0);
				/* WhichControl already found the control hit.  Unless it is the one
				** found by WhichControl, consider it unhit. */

			if (gWhichCtlTracking) return(1);
				/* We already handled it, but the control manager is insistent. */

			if (!(*ctl)->contrlValue) {			/* Turn off any other controls in this family. */
				ww = (*ctl)->contrlOwner;
				for (cc = nil; cc = CCIconNext(ww, cc, 1, true);) {
					if (cc != ctl) {
						if (((*cc)->contrlMax & 0xFFF0) == ((*ctl)->contrlMax & 0xFFF0)) {
							if ((*cc)->contrlValue) {
								(*cc)->contrlValue  = 0;
								(*cc)->contrlHilite = 0;
								CCIconCtl(varCode, cc, drawCntl, 0);
							}
						}
					}
				}
			}

			(*ctl)->contrlValue = 1;
			if (gWhichCtlDbl)							/* If user double-clicked... */
				if (!((*ctl)->contrlMax & 0x01))		/* If double-clicking allowed... */
					(*ctl)->contrlValue = 2;

			if (oldCtlVal != (*ctl)->contrlValue)
				CCIconCtl(varCode, ctl, drawCntl, 0);

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
			DisposeHandle((Handle)(*ctl)->contrlRfCon);
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
ControlHandle	CCIconNew(WindowPtr window, Rect *r, StringPtr title, Boolean vis, short val,
						  short min, short max, short viewID, short refcon)
{
	WindowPtr		oldPort;
	Rect			viewRct;
	Boolean			err;
	ControlHandle	viewCtl;
	CbtnInfoHndl	info;
	short			hicons, vicons;

	static ControlActionUPP	cupp;
	static ControlDefUPP	cdefupp;

	GetPort(&oldPort);
	SetPort(window);

	viewRct = *r;
	viewCtl = nil;
	info    = nil;

	err = false;

	if (!gCDEF) {
		gCDEF = (cdefRsrcJMPHndl)GetResource('CDEF', (viewID / 16));
		if (gCDEF) {
			if (!cdefupp) {
				cdefupp = NewControlDefProc(CCIconCtl);
			}
			(*gCDEF)->jmpAddress = (long)cdefupp;
			FlushInstructionCache();	/* Make sure that instruction caches don't kill us. */
		}
		else err = true;
	}

	if (!err) {
		info = (CbtnInfoHndl)NewHandleClear(sizeof(CbtnInfo));
		if (info) {
			hicons = (viewRct.right - viewRct.left - 1) / 64 + 1;
			if (hicons < 1) hicons = 1;
			vicons = (viewRct.bottom - viewRct.top - 1) / 64 + 1;
			if (vicons < 1) vicons = 1;
	
			(*info)->resIconID = refcon;
			(*info)->hicons    = hicons;
			(*info)->vicons    = vicons;
			(*info)->variant   = (viewID & 0x0F);
		}
		else err = true;
	}

	if (!err) {
		viewCtl = NewControl(window, &viewRct, title, vis, val, min, max, viewID, (long)info);
		if (viewCtl) {
			if (!cupp) cupp = NewControlActionProc(CCIconAction);
			SetCtlAction(viewCtl, cupp);
		}
		else
			err = true;
	}

	SetPort(oldPort);

	if (err) {		/* Oops.  Somebody wasn't happy. */
		if (info)
			DisposeHandle((Handle)info);
				/* viewCtl exists only if no error, so we just have to possibly clean up info. */
	}

	return(viewCtl);
}



/*****************************************************************************/



#pragma segment Controls
ControlHandle	CCIconNext(WindowPtr window, ControlHandle ctl, short dir, Boolean justActive)
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
Boolean	IsCIconCtl(ControlHandle ctl)
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
static pascal void	CCIconAction(ControlHandle ctl, short part)
{
	static short	lastPart = 0;

	if (lastPart != part) {
		lastPart = part;
		CCIconCtl(0, ctl, drawCntl, part);
	}
}



/*****************************************************************************/



#pragma segment Controls
static pascal void	NoRect(GrafVerb verb, Rect *r)
{
#pragma unused (verb, r)
}




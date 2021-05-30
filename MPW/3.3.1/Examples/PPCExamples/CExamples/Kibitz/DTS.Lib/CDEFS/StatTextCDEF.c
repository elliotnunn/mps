/*
** Apple Macintosh Developer Technical Support
**
** Program:         StatTextCDEF.c
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

#ifndef __GESTALTEQU__
#include <GestaltEqu.h>
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#ifndef __TEXTEDIT__
#include <TextEdit.h>
#endif

#ifndef __WINDOWS__
#include <Windows.h>
#endif



pascal long			main        (short varCode, ControlHandle ctl, short msg, long parm);
pascal long			CStatTextCtl(short varCode, ControlHandle ctl, short msg, long parm);
static pascal void	NoRect(GrafVerb verb, Rect *r);
static Boolean		GetCtlColor(ControlHandle ctl, short part, RGBColor *rgb);
static short		GetQDVersion(void);
static RgnHandle	ScreenDepthRegion(short depth);



/*****************************************************************************/



#pragma segment StatTextCDEF
#if THINK_C
pascal long	main(short varCode, ControlHandle ctl, short msg, long parm)
#else
pascal long	CStatTextCtl(short varCode, ControlHandle ctl, short msg, long parm)
#endif
{
	Rect		rct;
	WindowPtr	curPort;
	short		txFont, txSize, txMode, mode, depth;
	Style		txFace;
	QDProcs		qdp;
	QDProcsPtr	oldqdp;
	Boolean		doColor;
	RGBColor	rgb, oldrgb;
	RgnHandle	oldClip, newClip, rgn1, rgn2;
	Point		pt;

	rct = (*ctl)->contrlRect;

	switch (msg) {

		case drawCntl:

			GetPort(&curPort);
			GetClip(oldClip = NewRgn());

			if (varCode & 0x0002) {				/* Figure out where drawing is allowed. */
				depth = (*ctl)->contrlMin;
				if (depth < 1) depth = 1;
				newClip = ScreenDepthRegion(depth);
				pt.h = pt.v = 0;
				GlobalToLocal(&pt);
				OffsetRgn(newClip, pt.h, pt.v);
				SectRgn(oldClip, newClip, newClip);
				SetClip(newClip);
				DisposeRgn(newClip);
			}

			txFont = curPort->txFont;
			txFace = curPort->txFace;
			txSize = curPort->txSize;
			if (!(varCode & useWFont)) {
				TextFont(systemFont);
				TextFace(normal);
				TextSize(0);
			}

			if (varCode & 0x0001) {
				if (oldqdp = curPort->grafProcs)
					BlockMove(oldqdp, &qdp, sizeof(QDProcs));
				else
					SetStdProcs(&qdp);
				qdp.rectProc = (QDRectUPP)NoRect;
				curPort->grafProcs = &qdp;
				txMode = curPort->txMode;
				TextMode(srcOr);
			}

			HLock((Handle)ctl);
			mode = (varCode & 0x0004) ? teCenter : teFlushDefault;

			if (doColor = GetCtlColor(ctl, cTextColor, &rgb)) {
				GetForeColor(&oldrgb);
				RGBForeColor(&rgb);
				depth = (*ctl)->contrlMax;
				if (depth < 1) depth = 1;
				newClip = ScreenDepthRegion(depth);
				pt.h = pt.v = 0;
				GlobalToLocal(&pt);
				OffsetRgn(newClip, pt.h, pt.v);
				rgn1 = NewRgn();
				rgn2 = NewRgn();
				GetClip(rgn1);
				SectRgn(rgn1, newClip, rgn2);
				SetClip(rgn2);
				TextBox((*ctl)->contrlTitle + 1, (*ctl)->contrlTitle[0], &rct, mode);
				DiffRgn(rgn1, newClip, rgn2);
				SetClip(rgn2);
				DisposeRgn(newClip);
				DisposeRgn(rgn1);
				DisposeRgn(rgn2);
				RGBForeColor(&oldrgb);
			}

			TextBox((*ctl)->contrlTitle + 1, (*ctl)->contrlTitle[0], &rct, mode);

			HUnlock((Handle)ctl);

			if (varCode & 0x0001) {
				curPort->grafProcs = oldqdp;
				TextMode(txMode);
			}

			TextFont(txFont);
			TextFace(txFace);
			TextSize(txSize);

			SetClip(oldClip);
			DisposeRgn(oldClip);
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



/*****************************************************************************/



#pragma segment StatTextCDEF
static pascal void	NoRect(GrafVerb verb, Rect *r)
{
#pragma unused (verb, r)
}



/*****************************************************************************/



#pragma segment StatTextCDEF
static Boolean	GetCtlColor(ControlHandle ctl, short part, RGBColor *rgb)
{
	Boolean			ret;
	AuxCtlHandle	aux;
	CCTabHandle		ctab;
	ColorSpec		cspec;
	short			i;

	rgb->red = rgb->green = rgb->blue = 0;

	if (!GetQDVersion()) return(false);

	if (ret = GetAuxCtl(ctl, &aux)) {
		if (ctab = (*aux)->acCTable) {
			for (i = (*ctab)->ctSize; cspec = (*ctab)->ctTable[i], i; --i)
				if (cspec.value == part) break;
			*rgb = cspec.rgb;
		}
		else ret = false;
	}

	return(ret);
}



/*****************************************************************************/



#pragma segment StatTextCDEF
static short	GetQDVersion(void)
{
	long	gestaltResult;

	if (Gestalt(gestaltQuickdrawVersion, &gestaltResult))
		gestaltResult = 0;

	return((gestaltResult >> 8) & 0xFF);
}



/*****************************************************************************/



#pragma segment StatTextCDEF
static RgnHandle	ScreenDepthRegion(short depth)
{
	RgnHandle		retRgn, tmpRgn;
	GDHandle		device;
	PixMapHandle	pmap;
	Rect			rct;
	GrafPtr			mainPort;

	retRgn = NewRgn();

	if (!GetQDVersion()) {
		if (depth == 1) {
			GetWMgrPort(&mainPort);
			rct = mainPort->portRect;
			RectRgn(retRgn, &rct);
		}
	}
	else {
		tmpRgn = NewRgn();
		for (device = GetDeviceList(); device; device = GetNextDevice(device)) {
			if (
				(TestDeviceAttribute(device, screenDevice)) &&
				(TestDeviceAttribute(device, screenActive))
			) {
				pmap = (*device)->gdPMap;
				if ((*pmap)->pixelSize >= depth) {
					rct = (*device)->gdRect;
					RectRgn(tmpRgn, &rct);
					UnionRgn(retRgn, tmpRgn, retRgn);
				}
			}
		}
		DisposeRgn(tmpRgn);
	}

	return(retRgn);
}




/*
** Apple Macintosh Developer Technical Support
**
** Program:	    DTS.Lib
** File:	    ctlhandler.c
** Written by:  Eric Soldan
**
** Copyright © 1991-1993 Apple Computer, Inc.
** All rights reserved.
*/

/* You may incorporate this sample code into your applications without
** restriction, though the sample code has been provided "AS IS" and the
** responsibility for its operation is 100% yours.  However, what you are
** not permitted to do is to redistribute the source as "DSC Sample Code"
** after having made changes. If you're going to re-distribute the source,
** we require that you make it clear in the source that the code was
** descended from Apple Sample Code, but that you've made changes. */

/* This code implements the new 7.0 human-interface standards for both
** TextEdit and List controls.  These standards include the following features:
**
** 1) Tabbing between TextEdit and List controls within a window.
** 2) Displaying what item is active.  The active TextEdit item is indicated
**    by either a blinking caret, or a selection range.
** 3) List positioning via the keyboard.  Entries on the keyboard automatically
**    select and display the closest List item.  Also, the up and down arrows
**    scroll through the list.
** 4) Window scrollbars are handled.
*/



/*****************************************************************************/



#include "DTS.Lib2.h"
#include "DTS.Lib.protos.h"

#include "ListControlProcs.h"
#include "TextEditControlProcs.h"

static short	HandleScrollEvent(WindowPtr window, EventRecord *event);



/*****************************************************************************/



extern short		gBeginUpdateNested;
extern Handle		gPopupProc;

short				gDataCtl = rDataCtl;

static FileRecHndl	gFrHndl;
static Rect			gScrollRct;
static Point		gKeepOrg;
static Boolean		gVert;

static pascal void	ScrollActionProc(ControlHandle scrollCtl, short part);
static void			ScrollTheContent(WindowPtr window, short h, short v);
static short		GetCtlPosition(ControlHandle ctl);



/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/



/* This function converts a control number to a control handle.  The function
** simply walks the window's control list counting down until it has reached
** the right control number.  It also returns the number of controls traversed.
** While often this will be the same as the control number passed in, if the
** number passed in is greater than the number of controls in the list, then
** the number returned is the number of controls in the list. */

/* NOTE: Additional support for control id's has been added.  To store the control id (cid),
** the control handle is grown, and the cid is stored after the control title.  This means
** that you can't directly call SetCTitle without losing the cid, as SetCTitle resizes the
** control handle.  You should instead call SetStyledCTitle, which preserves the cid.
** For backwards compatibility, CNum2Ctl and Ctl2CNum support both the old-style control
** numbers and the new-style control id's.  While backwards compatibility may be a good
** thing, what this means is that you have to assign your cid's so that the value is greater
** than the number of controls in the window. */

#pragma segment Controls
short	CNum2Ctl(WindowPtr window, short ctlNum, ControlHandle *ctl)
{
	short	numCtls, cid;

	*ctl = nil;
	if (!ctlNum) return(0);

	cid = ctlNum;	/* Caller may have actually passed us a cid. */

	*ctl = ((WindowPeek)window)->controlList;
	for (numCtls = 1; --ctlNum;  ++numCtls) {
		if (!*ctl) {
			--numCtls;
			break;
		}
		if (GetControlID(*ctl) == cid) break;
		*ctl = (**ctl)->nextControl;
	}

	return(numCtls);
}



/*****************************************************************************/



/* This function converts a control handle to a control number.  The function
** simply walks the window's control list and counts how many controls it
** has to traverse before finding the target control.  The smallest control
** number that can be returned is 1.  This makes control numbers similar to
** dialog item numbers. */

/* NOTE: Additional support for control id's has been added.  To store the control id (cid),
** the control handle is grown, and the cid is stored after the control title.  This means
** that you can't directly call SetCTitle without losing the cid, as SetCTitle resizes the
** control handle.  You should instead call SetStyledCTitle, which preserves the cid.
** For backwards compatibility, CNum2Ctl and Ctl2CNum support both the old-style control
** numbers and the new-style control id's.  While backwards compatibility may be a good
** thing, what this means is that you have to assign your cid's so that the value is greater
** than the number of controls in the window. */

#pragma segment Controls
short	Ctl2CNum(ControlHandle ctl)
{
	ControlHandle	nextCtl;
	short			ctlNum;

	if (!ctl)                 return(0);
	if (ctlNum = GetControlID(ctl)) return(ctlNum);

	nextCtl = ((WindowPeek)(*ctl)->contrlOwner)->controlList;
	for (ctlNum = 0;;) {
		if (!nextCtl) break;
		++ctlNum;
		if (ctl == nextCtl) break;
		nextCtl = (*nextCtl)->nextControl;
	}
	return(ctlNum);
}



/*****************************************************************************/



/* This function reactivates the last active TextEdit or List control for
** the indicated window. */

#pragma segment Controls
void	DoCtlActivate(WindowPtr window)
{
	ListHandle	list;
	TEHandle	te, oldte;
	WindowPtr	oldww;

	if (list = (*gclWindActivate)(window, false)) {
		if ((*list)->rView.left < -8192)
			BeginFrame(window);
		else
			BeginContent(window);
		(*gclWindActivate)(window, true);		/* Reactivate the list. */
		EndContent(window);						/* Same as EndFrame().  */
	}

	oldte = (*gcteFindActive)(nil);
	te    = (*gcteWindActivate)(window, false);
	if (te != oldte) {
		if (oldte) {
			oldww = (*oldte)->inPort;
			if ((*oldte)->viewRect.left < -8192)
				BeginFrame(oldww);
			else
				BeginContent(oldww);
			(*gcteWindActivate)(oldww, true);
			EndContent(oldww);
		}
		if (te) {
			if ((*te)->viewRect.left < -8192)
				BeginFrame(window);
			else
				BeginContent(window);
			(*gcteWindActivate)(window, true);
			EndContent(window);
		}
	}
}



/*****************************************************************************/



/* This function returns all the checkBox values into the dsignated array.
** The function walks the control list, and when it finds a checkBox control,
** it gets the control value and places it in the next position in the array.
** This allows a single call to retrieve all the checkBox values at once. */

#pragma segment Controls
void	GetCheckBoxValues(WindowPtr window, Boolean checkBoxVal[])
{
	ControlHandle	nextCtl;
	short			checkBoxIndx;

	nextCtl = ((WindowPeek)window)->controlList;
	for (checkBoxIndx = 0;;) {
		if (!nextCtl) return;
		if (GetButtonVariant(nextCtl) == checkBoxProc)
			checkBoxVal[checkBoxIndx++] = GetCtlValue(nextCtl);
		nextCtl = (*nextCtl)->nextControl;
	}
}



/*****************************************************************************/



/* This function returns which radio button is selected for a particular
** family of radio buttons.  It finds the radio button of the target family
** with the lowest control number and it subtracts this number from the
** selected radio button of the same family.  This gives a relative radio
** button number as a return result.  This way the position of the family
** of radio buttons can change in the window and the return result is the
** same.  The family number is stored in the control's refCon field. */

#pragma segment Controls
short	GetRadioButtonChoice(WindowPtr window, short famNum)
{
	ControlHandle	nextCtl;
	short			firstInFam, cnum, chosen;

	nextCtl = ((WindowPeek)window)->controlList;
	for (firstInFam = chosen = 0;;) {
		if (!nextCtl) {
			if (!chosen) return(-1);
				/* If a proper radio button family was passed in, this can't
				** happen.  The -1 is an error that indicates that the
				** requested family didn't exist, or that there was no selected
				** radio of the requested family. */
			return(chosen - firstInFam);
		}
		if (GetButtonVariant(nextCtl) == radioButProc) {
			if (GetCRefCon(nextCtl) == famNum) {
				cnum = Ctl2CNum(nextCtl);
				if (!firstInFam)
					firstInFam = cnum;
				else {
					if (firstInFam > cnum)
						firstInFam = cnum;
				}
				if (GetCtlValue(nextCtl)) chosen = cnum;
			}
		}
		nextCtl = (*nextCtl)->nextControl;
	}
}



/*****************************************************************************/



/* This function currently handles events for TextEdit, List, and button
** controls in a window.  It also handles the window scrollbars and
** scrolling of the window. */

#pragma segment Controls
short	IsCtlEvent(WindowPtr window, EventRecord *event, ControlHandle *retCtl, short *retAction)
{
	RgnHandle			docScroller, docFrame, oldClip, newClip, rgn;
	TEHandle			te, oldte, teNext;
	ListHandle			list, oldlist, listNext;
	ControlHandle		xxx, activeCtl, teCtl, listCtl, nextCtl, newCtl, dataCtl, cc;
	short				ctlNum, key, modifiers, mode, action, dir, pass, visMode;
	short				thisNum, teNum, listNum, i, oldVal, newVal, dpass, part;
	Boolean				hitFrame, hitScrollBar, tracked, hasBalloon, didPopup;
	CTEDataHndl			teData;
	CLDataHndl			listData;
	EventRecord			evt;
	WindowPtr			ww;
	ControlStyleInfo	cinfo;
	short				targetChr, targetMod;
	Str255				dataCtlTitle;
	OSType				sftype;
	Rect				org;
	Point				org2;
	Point				mouseLoc;
	FileRecHndl			ff;

	static ControlActionUPP	cupp;

	pass = 0;

	if (!retCtl)    retCtl    = &xxx;
	if (!retAction) retAction = &action;

	*retCtl    = nil;
	*retAction = 0;

	evt = *event;

	if (evt.what == nullEvent) {
		mouseLoc = GetGlobalMouse();
		window   = FrontWindowOfType(kwIsModalDialog, true);

		if (window)
			if (ff = (FileRecHndl)GetWRefCon(window))
				if ((*ff)->fileState.sfType == '6hlp')
					for (;window = GetNextWindow(window, 0) ;)
						if (((WindowPeek)window)->visible) break;

		if (!window) {
			part = FindWindow(mouseLoc, &window);
			if (ww = GetNextWindow(nil, '6hlp')) {
				if (ww == window) {		/* We found the help window -- that's bad. */
					CopyRgn(((WindowPeek)ww)->strucRgn, rgn = NewRgn());
					OffsetRgn(((WindowPeek)ww)->strucRgn, 16384, 0);
					OffsetRgn(((WindowPeek)ww)->contRgn,  16384, 0);
					CalcVisBehind((WindowPeek)ww, rgn);
					DisposeRgn(rgn);
					part = FindWindow(mouseLoc, &window);
					OffsetRgn(((WindowPeek)ww)->strucRgn, -16384, 0);
					OffsetRgn(((WindowPeek)ww)->contRgn,  -16384, 0);
					CalcVisBehind((WindowPeek)ww, ((WindowPeek)ww)->strucRgn);
				}
			}
			if (part == inContent)
				if (!(((WindowPeek)window)->hilited))
					window = nil;
		}
		hasBalloon = false;
		if (window) {
			if (PtInRgn(mouseLoc, ((WindowPeek)window)->contRgn)) {
				SetPort(window);
				org = window->portRect;

				docFrame = DoCalcFrameRgn(window);
				hitFrame = PtInRgn(mouseLoc, docFrame);
				DisposeRgn(docFrame);

				if (hitFrame) {
					BeginFrame(window);		/* This sets the origin for the frame. */
					EndFrame(window);		/* This DOESN'T reset the origin for the frame, so the origin is now set correctly. */
					hasBalloon = ControlBalloonHelp(window, event->modifiers, mouseLoc);
				}
				else {
					BeginContent(window);	/* This sets the origin for the content. */
					EndContent(window);		/* This DOESN'T reset the origin for the content, so the origin is now set correctly. */
					hasBalloon = ControlBalloonHelp(window, event->modifiers, mouseLoc);
				}
				SetOrigin(org.left, org.top);
			}
		}
		if (!hasBalloon) {
			if (ww = GetNextWindow(nil, '6hlp')) DisposeOneWindow(ww, kClose);
			ControlBalloonHelp(nil, event->modifiers, mouseLoc);
		}
		return(0);
	}

	if (!window) return(0);

	org = window->portRect;

	if (evt.what == mouseDown) {

		docScroller = DoCalcScrollRgn(window);
		hitFrame    = PtInRgn(evt.where, docScroller);
		DisposeRgn(docScroller);
		if (hitFrame) return(HandleScrollEvent(window, &evt));
			/* If window scrollbar is clicked on, handle the window scroll event. */

		docFrame = DoCalcFrameRgn(window);
		hitFrame = PtInRgn(evt.where, docFrame);
		DisposeRgn(docFrame);

		evt.where = event->where;
		if (hitFrame)
			BeginFrame(window);
		else
			BeginContent(window);
		GlobalToLocal(&evt.where);

		(*gcteCtlHit)();	/* Clear CTECtl defProc's last hit CTECtl. */
		(*gclCtlHit)();		/* Clear CLCtl defProc's last hit CLCtl. */

		if (WhichControl(evt.where, 0, window, retCtl)) {
				/* WhichControl also finds inactive controls.  We need this for scrollbars.
				** If an inactive scrollbar is hit, we should activate the related
				** TextEdit or List control. */

			hitScrollBar = IsScrollBar(*retCtl);
				/* The List controls and TextEdit controls may have scrollbars.
				** Find out if a scrollbar was pressed, because it may belong
				** to a TextEdit or List control. */

			part = FindControl(evt.where, window, retCtl);
				/* WhichControl doesn't call the scrollProc.  FindControl does.
				** We need it called so we can determine below if a TextEdit or
				** List control was hit.  CTECtlHit() and CLCtlHit() return
				** the last hit respective control. */

			ctlNum = Ctl2CNum(*retCtl);

			if ((hitScrollBar) || ((*gcteCtlHit)())) {
					/* This test is for speed.  CTEClick would find out if a TextEdit
					** control handled the mouse click, but not as fast as we would
					** like.  The above test determines if it is worth investigating. */

				if (cc = CTEFindCtl(window, event, &te, nil)) {

					if ((*cc)->contrlHilite != 255) {
						ww = CTETargetInfo(&oldte, nil);
						SetOrigin(org.left, org.top);
						EndContent(window);

						if ((oldte) && (te != oldte)) {
							if ((*oldte)->viewRect.left < -8192)
								BeginFrame(ww);
							else
								BeginContent(ww);
							(*gcteActivate)(false, oldte);
							SetOrigin(org.left, org.top);
							EndContent(ww);
						}
						if (list = (*gclFindActive)(window)) {
							cc = CLViewFromList(list);
							listData = (CLDataHndl)(*cc)->contrlData;
							mode     = (*listData)->mode;
							if (mode & (clShowActive | clKeyPos)) {
								if ((*list)->rView.left < -8192)
									BeginFrame(window);
								else
									BeginContent(window);
								(*gclActivate)(false, list);
								SetOrigin(org.left, org.top);
								EndContent(window);
							}
						}
						if (evt.where.h < -8192)
							BeginFrame(window);
						else
							BeginContent(window);
					}

					if ((*gcteClick)(window, event, retAction)) {	/* If click for TE control... */
						if (*retAction == -1) {
							*retCtl = (*gcteViewFromTE)(CTEFindActive(window));
							teData  = (CTEDataHndl)(**retCtl)->contrlData;
							mode    = (*teData)->mode;
							if (!(mode & cteTwoStep))
								(*gcteClick)(window, event, retAction);
						}
						SetOrigin(org.left, org.top);
						EndContent(window);
						return(ctlNum);
					}
				}
			}

			if ((hitScrollBar) || ((*gclCtlHit)())) {
					/* This test is for speed.  CLClick would find out if a List
					** control handled the mouse click, but not as fast as we would
					** like.  The above test determines if it is worth investigating. */

				if (cc = CLFindCtl(window, event, &list, nil)) {
					if ((*cc)->contrlHilite != 255) {
						oldlist = CLFindActive(window);
						SetOrigin(org.left, org.top);
						EndContent(window);
						if ((oldlist) && (list != oldlist)) {
							if ((*oldlist)->rView.left < -8192)
								BeginFrame(window);
							else
								BeginContent(window);
							(*gclActivate)(false, oldlist);
							SetOrigin(org.left, org.top);
							EndContent(window);
						}
						if (list) {
							cc = CLViewFromList(list);
							listData = (CLDataHndl)(*cc)->contrlData;
							mode     = (*listData)->mode;
							if (mode & (clShowActive | clKeyPos)) {
								if (te = (*gcteFindActive)(window)) {
									if ((*te)->viewRect.left < -8192)
										BeginFrame(window);
									else
										BeginContent(window);
									(*gcteActivate)(false, te);
									SetOrigin(org.left, org.top);
									EndContent(window);
								}
							}
						}
						if (evt.where.h < -8192)
							BeginFrame(window);
						else
							BeginContent(window);
					}

					if ((*gclClick)(window, event, retAction)) {	/* If click for List control... */
						if (*retAction == -1) {		/* Just activated a List control... */
							*retCtl  = (*gclViewFromList)((*gclFindActive)(window));
							listData = (CLDataHndl)(**retCtl)->contrlData;
							mode     = (*listData)->mode;
							if (!(mode & clTwoStep))
								(*gclClick)(window, event, retAction);
						}
						SetOrigin(org.left, org.top);
						EndContent(window);
						return(ctlNum);
					}
				}
			}

			didPopup = tracked = false;
			WhichControl(evt.where, 0, window, retCtl);
			if (gPopupProc) {		/* The popup control does not handle negative coords. */
				if ((*(**retCtl)->contrlDefProc) == (*gPopupProc)) {
					didPopup = true;
					org2.h = window->portRect.left;
					org2.v = window->portRect.top;
					GetClip(oldClip = NewRgn());
					RectRgn(newClip = NewRgn(), &(window->portRect));
					SectRgn(newClip, oldClip, newClip);
					SetOrigin(0, 0);
					OffsetRgn(newClip, -org2.h, -org2.v);
					SetClip(newClip);
					OffsetRect(&((**retCtl)->contrlRect), -org2.h, -org2.v);
					oldVal  = (**retCtl)->contrlValue;
					UseControlStyle(*retCtl);
					cinfo.trackProc = nil;
					GetControlStyle(*retCtl, &cinfo);
					if (cinfo.trackProc)
						tracked = (*cinfo.trackProc)(*retCtl, part, &evt);
					else {
						if (!cupp) cupp = (ControlActionUPP)(-1);
						tracked = TrackControl(*retCtl, evt.where, cupp);
					}
					newVal = (**retCtl)->contrlValue;
					UseControlStyle(nil);
					ctlNum = 0;
					if (oldVal != newVal) {
						tracked = true;
						ctlNum  = Ctl2CNum(*retCtl);
					}
					OffsetRect(&((**retCtl)->contrlRect), org2.h, org2.v);
					SetOrigin(org2.h, org2.v);
					SetClip(oldClip);
					DisposeRgn(oldClip);
					DisposeRgn(newClip);
					DoDraw1Control(*retCtl, false);
				}
			}

			*retAction = 0;

			if (!didPopup) {
				FindControl(evt.where, window, retCtl);
				if (!*retCtl) {
					SetOrigin(org.left, org.top);
					EndContent(window);
					return(ctlNum);
				}

				WhichControl(evt.where, evt.when, window, nil);
					/* WhichControl places the hit control in the global gWhichCtl.
					** This global is used by CCIconCtl to determine double-clicks.
					** Double-clicking is also calculated by WhichControl.  The global
					** gWhichCtlDbl is set true if the control was double-clicked on.
					** We call WhichControl with the click time just prior to tracking
					** the control.  When a non-0 tick is passed in, it compares the found
					** control against the last found control, and the tick against the last
					** tick.  The globals are set accordingly. */

				oldVal = (**retCtl)->contrlValue;
				UseControlStyle(*retCtl);
				cinfo.trackProc = nil;
				GetControlStyle(*retCtl, &cinfo);
				if (cinfo.trackProc)
					tracked = (*cinfo.trackProc)(*retCtl, part, &evt);
				else {
					if (!cupp) cupp = (ControlActionUPP)(-1);
					tracked = TrackControl(*retCtl, evt.where, cupp);
				}
				UseControlStyle(nil);
			}
	
			if (tracked) {					/* Handle other controls. */

				switch(GetButtonVariant(*retCtl)) {
					case pushButProc:
						break;
					case checkBoxProc:
						SetStyledCtlValue(*retCtl, GetCtlValue(*retCtl) ^ 1);
								/* Toggle checkBox value. */
						break;
					case radioButProc:
						nextCtl = ((WindowPeek)window)->controlList;
							/* The below loop walks the control list for the window and
							** finds radio buttons of the correct family number.  If
							** the found radio button is the one that was clicked on,
							** the value is set true, otherwise it is set false. */
						for (; nextCtl; nextCtl = (*nextCtl)->nextControl) {
							if (GetButtonVariant(nextCtl) == radioButProc)
								if (GetCRefCon(nextCtl) == GetCRefCon(*retCtl))
									SetStyledCtlValue(nextCtl, (nextCtl == *retCtl));
						}
						break;
				}

				newVal = (**retCtl)->contrlValue;

				if (GetControlStyle(*retCtl, &cinfo)) {
					for (i = 1;; i += 6) {
						if (i >= cinfo.keyEquivs[0]) break;
						if (cinfo.keyEquivs[i] == (unsigned char)',') ++i;
						if (cinfo.keyEquivs[i] == (unsigned char)':') {
							targetChr = GetHexByte((char *)(cinfo.keyEquivs + i + 1));
							targetMod = GetHexByte((char *)(cinfo.keyEquivs + i + 2 + 1)) << 8;
							evt.what       = keyDown;
							evt.message    = targetChr;
							evt.modifiers &= 0x00FF;
							evt.modifiers |= (targetMod << 8);
							pass = 1;
							if (cinfo.keyEquivs[0] > i + 4)
								if (cinfo.keyEquivs[i + 5] == '<')
									pass = 0;
										/* If delimiter is a <, then reprocess with
										** pass #0.  This could cause an infinite loop
										** if the targetEquiv is the same as what was
										** pressed.  The reason that this is done is if
										** the targetEquiv is different than the original
										** event, and we want to give non-te, non-list controls
										** a chance to process the equiv.  Normally the whole
										** purpose for this feature is to first notice that a
										** pass-0 control has an equiv, and then we want to pass
										** this key onto a te control. */
						}
					}
				}

				if (oldVal != newVal) {
					*retAction = 3;
					oldVal -= (**retCtl)->contrlMin;
					newVal -= (**retCtl)->contrlMin;
					CNum2Ctl(window, -ctlNum, &dataCtl);
					if (dataCtl) {
						GetCTitle(dataCtl, dataCtlTitle);
						switch (GetCVariant(dataCtl)) {
							case 0:
								for (dpass = 0; dpass < 2; ++dpass) {
									i  = (dpass) ? newVal : oldVal;
									i *= 7;
									i += 2;
									if (i <= dataCtlTitle[0] - 3) {
										BlockMove(dataCtlTitle + i, &sftype, sizeof(OSType));
										visMode = (dpass) ? kwStandardVis : kwHideAll;
										DisplayControlSet(window, sftype, visMode);
									}
								}
								break;
						}
					}
				}
			}
			else {
				*retCtl = nil;
				ctlNum = 0;
			}

			SetOrigin(org.left, org.top);
			EndContent(window);

			if (evt.what != keyDown) return(ctlNum);
		}

		if (evt.what != keyDown) {
			SetOrigin(org.left, org.top);
			EndContent(window);
			return(0);
		}
	}

	if ((evt.what == keyDown) || (evt.what == autoKey)) {		/* If event was keypress... */

		modifiers = evt.modifiers;
		key       = evt.message & charCodeMask;
		dir       = (modifiers & shiftKey) ? -1 : 1;

		if (key == chTab) {		/* If tab... */

			teNext    = nil;
			listNext  = nil;
			activeCtl = nil;

			if (list = (*gclFindActive)(window)) {
				activeCtl = (*gclViewFromList)(list);	/* Find what the active control is. */
				listData = (CLDataHndl)(*activeCtl)->contrlData;
				mode     = (*listData)->mode;
				if (!(mode & (clShowActive | clKeyPos)))
					activeCtl = nil;
						/* Find out if active List control supports key
						** positioning and/or show active. */
			}

			if (te = (*gcteFindActive)(window))
				activeCtl = (*gcteViewFromTE)(te);

			if (!(teCtl = (*gcteNext)(window, &teNext, activeCtl, dir, true)))
				teCtl = (*gcteNext)(window, &teNext, nil, dir, true);
					/* Find the next TextEdit control from the active control. */

			for (listCtl = activeCtl; listCtl = (*gclNext)(window, &listNext, listCtl, dir, true);) {
				listData = (CLDataHndl)(*listCtl)->contrlData;
				mode     = (*listData)->mode;
				if (mode & (clShowActive | clKeyPos)) break;
			}
			if (!listCtl) {
				for (; listCtl = (*gclNext)(window, &listNext, listCtl, dir, true);) {
					listData = (CLDataHndl)(*listCtl)->contrlData;
					mode     = (*listData)->mode;
					if (mode & (clShowActive | clKeyPos)) break;
				}
			}

			if ((!teNext) && (!listNext)) return(0);
				/* No TextEdit or List controls in window, so we are done. */

			thisNum = GetCtlPosition(activeCtl);
			teNum   = GetCtlPosition(teCtl);
			listNum = GetCtlPosition(listCtl);

			newCtl = activeCtl;
			if (dir == 1) {
				if (!teNum)   teNum   = 32767;
				if (!listNum) listNum = 32767;
				if (teNum   <= thisNum) teNum   += 16384;
				if (listNum <= thisNum) listNum += 16384;
				if (teNum < listNum) newCtl = teCtl;
				if (listNum < teNum) newCtl = listCtl;
			}
			else {
				if (!teNum)   teNum   = -32767;
				if (!listNum) listNum = -32767;
				if (teNum   >= thisNum) teNum   -= 16384;
				if (listNum >= thisNum) listNum -= 16384;
				if (teNum > listNum) newCtl = teCtl;
				if (listNum > teNum) newCtl = listCtl;
			}

			if (activeCtl == newCtl) {
				if (newCtl == teCtl) {
					if ((*teNext)->viewRect.left < -8192)
						BeginFrame(window);
					else
						BeginContent(window);
					(*gcteActivate)(true, teNext);
					teData = (CTEDataHndl)(*teCtl)->contrlData;
					if ((*teData)->mode & cteTabSelectAll)
						(*gcteSetSelect)(0, (*teNext)->teLength, teNext);
							/* If the "select all TextEdit text when tabbed into" bit is
							** set, then do that very thing. */
					SetOrigin(org.left, org.top);
					EndContent(window);
				}
				return(0);
			}

			if (te) {			/* If old ctl is te, deactivate it. */
				if ((*te)->viewRect.left < -8192)
					BeginFrame(window);
				else
					BeginContent(window);
				(*gcteActivate)(false, te);
				SetOrigin(org.left, org.top);
				EndContent(window);
			}

			if (list) {			/* If old ctl is list, deactivate it. */
				if ((*list)->rView.left < -8192)
					BeginFrame(window);
				else
					BeginContent(window);
				(*gclActivate)(false, list);
				SetOrigin(org.left, org.top);
				EndContent(window);
			}

			if (newCtl == teCtl) {
				if ((*teNext)->viewRect.left < -8192)
					BeginFrame(window);
				else
					BeginContent(window);
				(*gcteActivate)(true, teNext);
				teData = (CTEDataHndl)(*teCtl)->contrlData;
				if ((*teData)->mode & cteTabSelectAll)
					(*gcteSetSelect)(0, (*teNext)->teLength, teNext);
						/* If the "select all TextEdit text when tabbed into" bit is
						** set, then do that very thing. */
				SetOrigin(org.left, org.top);
				EndContent(window);
				return(Ctl2CNum(*retCtl = teCtl));
			}

			if (newCtl == listCtl) {
				if ((*listNext)->rView.left < -8192)
					BeginFrame(window);
				else
					BeginContent(window);
				(*gclActivate)(true, listNext);
				SetOrigin(org.left, org.top);
				EndContent(window);		/* Remove the clipping. */
				return(Ctl2CNum(*retCtl = listCtl));
			}
		}

		for (; pass < 3; ++pass) {
			switch (pass) {
				case 0:
				case 2:
					if (ControlKeyEquiv(window, &evt, retCtl, ((pass) ? "\p031900,0D1900" :
																		"\p031900"))) {
						if ((**retCtl)->contrlRect.left < -8192)
							BeginFrame(window);
						else
							BeginContent(window);
						SelectButton(*retCtl);
						oldVal = GetCtlValue(*retCtl);
						switch(GetButtonVariant(*retCtl)) {
							case pushButProc:
								break;
							case checkBoxProc:
								SetStyledCtlValue(*retCtl, GetCtlValue(*retCtl) ^ 1);
										/* Toggle checkBox value. */
								break;
							case radioButProc:
								nextCtl = ((WindowPeek)window)->controlList;
									/* The below loop walks the control list for the window and
									** finds radio buttons of the correct family number.  If
									** the found radio button is the one that was clicked on,
									** the value is set true, otherwise it is set false. */
								for (; nextCtl; nextCtl = (*nextCtl)->nextControl) {
									if (GetButtonVariant(nextCtl) == radioButProc)
										if (GetCRefCon(nextCtl) == GetCRefCon(*retCtl))
											SetStyledCtlValue(nextCtl, (nextCtl == *retCtl));
								}
								break;
						}
						SetOrigin(org.left, org.top);
						EndContent(window);
						newVal = GetCtlValue(*retCtl);
						if (oldVal != newVal) *retAction = 3;

						if (!pass) {
							if (GetControlStyle(*retCtl, &cinfo)) {
								for (i = 1;; i += 6) {
									if (i >= cinfo.keyEquivs[0]) break;
									if (cinfo.keyEquivs[i] == (unsigned char)',') ++i;
									if (cinfo.keyEquivs[i] == (unsigned char)':') {
										targetChr = GetHexByte((char *)(cinfo.keyEquivs + i + 1));
										targetMod = GetHexByte((char *)(cinfo.keyEquivs + i + 2 + 1)) << 8;
										evt.message    = targetChr;
										evt.modifiers &= 0x00FF;
										evt.modifiers |= (targetMod << 8);
										if (cinfo.keyEquivs[0] > i + 4)
											if (cinfo.keyEquivs[i + 5] == '<')
												--pass;
													/* If delimiter is a <, then reprocess with pass #0.
													** This could cause an infinite loop if the targetEquiv
													** is the same as what was pressed.  The reason that this
													** is done is if the targetEquiv is different than the
													** original event, and we want to give non-te, non-list controls
													** a chance to process the equiv.  Normally the whole purpose for
													** this feature is to first notice that a pass-0 control has an
													** equiv, and then we want to pass this key onto a te control. */
										i = 999;
									}
								}
								if (i >= 999) continue;
							}
						}

						return(Ctl2CNum(*retCtl));
					}

					break;
				case 1:
					if (evt.modifiers & cmdKey) break;		/* Don't allow command keys to go to te and list controls. */
					if (te = (*gcteFindActive)(window)) {	/* If TextEdit control is active... */
						if ((*te)->viewRect.left < -8192)
							BeginFrame(window);
						else
							BeginContent(window);
						*retAction = (*gcteKey)(window, &evt);	/* Allow processing by TE control. */
						SetOrigin(org.left, org.top);
						EndContent(window);
						*retCtl = (*gcteViewFromTE)(te);
						return(Ctl2CNum(*retCtl));
					}
					if (list = (*gclFindActive)(window)) {		/* If List control is active... */
						if ((*list)->rView.left < -8192)
							BeginFrame(window);
						else
							BeginContent(window);
						(*gclKey)(window, &evt);
						SetOrigin(org.left, org.top);
						EndContent(window);
						*retCtl = (*gclViewFromList)(list);
						return(Ctl2CNum(*retCtl));
					}
					break;
			}
		}
	}

	return(0);
}



/*****************************************************************************/



#pragma segment Controls
static short	HandleScrollEvent(WindowPtr window, EventRecord *event)
{
	WindowPtr		oldPort;
	Point			clickLoc;
	short			part;
	ControlHandle	ctl;
	short			value, h, v;

	static ControlActionUPP	cupp;

	GetPort(&oldPort);
	SetPort(window);
	gScrollRct = window->portRect;

	gKeepOrg.h = gScrollRct.left;
	gKeepOrg.v = gScrollRct.top;

	SetOrigin(0, -16384);
	clickLoc = event->where;
	GlobalToLocal(&clickLoc);
		/* Scrollbars for window are offset -16384 vertically.  Get a local
		** coordinate that corresponds to this negative space. */

	if (!(part = FindControl(clickLoc, window, &ctl))) {
		SetOrigin(gKeepOrg.h, gKeepOrg.v);			/* Restore the origin. */
		SetPort(oldPort);
		return(kScrollEvent);
	}

	gFrHndl = (FileRecHndl)GetWRefCon(window);
	if ((*gFrHndl)->fileState.vScroll)
		gScrollRct.right  -= 15;
	if ((*gFrHndl)->fileState.hScroll)
		gScrollRct.bottom -= 15;

	gScrollRct.left += (*gFrHndl)->fileState.leftSidebar;
	gScrollRct.top  += (*gFrHndl)->fileState.topSidebar;

	gVert = (((*ctl)->contrlRect.right - (*ctl)->contrlRect.left) == 16);
	switch (part) {
		case inThumb:
			value = GetCtlValue(ctl);
			SetOrigin(0, -16384);
			part = TrackControl(ctl, clickLoc, nil);
			SetOrigin(gKeepOrg.h, gKeepOrg.v);			/* Restore the origin. */
			if (part) {
				value -= GetCtlValue(ctl);
					/* Value now has CHANGE in position.  if position changed, scroll. */
				if (value) {
					h = v = 0;
					if (gVert)
						v = value;
					else
						h = value;
					ScrollTheContent(window, h, v);
				}
			}
			break;
		default:
			SetOrigin(0, -16384);
			if (!cupp) cupp = NewControlActionProc(ScrollActionProc);
			TrackControl(ctl, clickLoc, cupp);
			SetOrigin(gKeepOrg.h, gKeepOrg.v);			/* Restore the origin. */
			break;
	}

	AdjustScrollBars(window);

	SetPort(oldPort);
	return(kScrollEvent);
}



/*****************************************************************************/
/*****************************************************************************/



#pragma segment Controls
static pascal void	ScrollActionProc(ControlHandle scrollCtl, short part)
{
	WindowPtr	window;
	short		delta, value, h, v;
	short		oldValue, max;
	Point		org;
	RgnHandle	contPart, framePart;

	GetPort(&window);

	if (part) {						/* If it was actually in the control. */

		switch (part) {
			case inUpButton:
			case inDownButton:		/* One line. */
				delta = (gVert) ? (*gFrHndl)->fileState.vArrowVal : (*gFrHndl)->fileState.hArrowVal;
				break;
			case inPageUp:			/* One page. */
			case inPageDown:
				delta = (gVert) ? (*gFrHndl)->fileState.vPageVal : (*gFrHndl)->fileState.hPageVal;
				break;
		}

		if ( (part == inUpButton) || (part == inPageUp) )
			delta = -delta;		/* Reverse direction for an upper. */

		value = (oldValue = GetCtlValue(scrollCtl)) + delta;
		if (value < 0)
			value = 0;
		if (value > (max = GetCtlMax(scrollCtl)))
			value = max;

		if (value != oldValue) {

			SetCtlValue(scrollCtl, value);
			SetOrigin(gKeepOrg.h, gKeepOrg.v);
			h = oldValue - value;
			v = 0;
			if (gVert) {
				v = h;
				h = 0;
			}

			ScrollTheContent(window, h, v);

			DoUpdateSeparate(window, &contPart, &framePart);
			if (contPart) {
				CopyRgn(contPart, ((WindowPeek)window)->updateRgn);
				DisposeRgn(contPart);
				++gBeginUpdateNested;
				BeginUpdate(window);
				GetContentOrigin(window, &org);
				SetOrigin(org.h, org.v);
				DoImageDocument(gFrHndl);
				EndUpdate(window);
				--gBeginUpdateNested;
			}
			if (framePart) {
				CopyRgn(framePart, ((WindowPeek)window)->updateRgn);
				DisposeRgn(framePart);
			}

			SetOrigin(0, -16384);
		}
	}
}



/*****************************************************************************/



#pragma segment Controls
static void	ScrollTheContent(WindowPtr window, short h, short v)
{
	Point		org;
	RgnHandle	updateRgn;

	org.h = window->portRect.left;
	org.v = window->portRect.top;
	BeginContent(window);
	SetOrigin(org.h, org.v);
	ScrollRect(&gScrollRct, h, v, updateRgn = NewRgn());
	EndContent(window);
	InvalRgn(updateRgn);
	DisposeRgn(updateRgn);
	DoScrollFrame(window, h, v);
}



/*****************************************************************************/



#pragma segment Controls
static short	GetCtlPosition(ControlHandle ctl)
{
	ControlHandle	nextCtl;
	short			ctlNum;

	if (!ctl) return(0);

	nextCtl = ((WindowPeek)(*ctl)->contrlOwner)->controlList;
	for (ctlNum = 0;;) {
		if (!nextCtl) break;
		++ctlNum;
		if (ctl == nextCtl) break;
		nextCtl = (*nextCtl)->nextControl;
	}
	return(ctlNum);
}



/*****************************************************************************/



/* Get the next Data control in the control list for a window. */

#pragma segment Controls
ControlHandle	CDataNext(WindowPtr window, ControlHandle ctl)
{
	ControlHandle	tempCtl;
	Rect			rct;
	static Handle	defProc;

	if (!window) return(nil);

	if (!defProc) {
		SetRect(&rct, 0, 0, 0, 0);
		if (tempCtl = NewControl(window, &rct, "\p", false, 0, 0, 0, gDataCtl, 0)) {
			defProc = (*tempCtl)->contrlDefProc;
			DisposeControl(tempCtl);
		}
	}

	if (!ctl)
		ctl = ((WindowPeek)window)->controlList;
	else
		ctl = (*ctl)->nextControl;

	while (ctl) {
		if (*(*ctl)->contrlDefProc == *defProc) return(ctl);
			/* The handle may be locked, which means that the hi-bit
			** may be on, thus invalidating the compare.  Dereference the
			** handles to get rid of this possibility. */
		ctl = (*ctl)->nextControl;
	}

	return(ctl);
}




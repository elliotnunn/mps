/*
** Apple Macintosh Developer Technical Support
**
** File:        config.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __PACKAGES__
#include <Packages.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/



#define kConfigOK		1
#define kConfigEquivs	2
#define kConfigCancel	3
#define kPlayWhite		4
#define kPlayBlack		5
#define kCompWhite		6
#define kCompBlack		7
#define kTimerToggle	8
#define kDivider1		9
#define kDivider2		10
#define kDivider3		11
#define kWhiteClock		12
#define kBlackClock		13
#define kStatText1		14
#define kStatText2		15
#define kStatText3		16
#define kStatText4		17
#define kStatText5		18
#define kSpeech			20

static short	gOption;

static pascal Boolean	configFilter(DialogPtr dlg, EventRecord *event, short *item);



/*****************************************************************************/



static TheDoc	newConfig;
static short	iconNum[3] = {rConfigBase, rConfigBase + 1, rConfigBase + 2};

pascal void		DoConfigureGameProc(DialogPtr dialog, short userItem);



/*****************************************************************************/
/*****************************************************************************/



#pragma segment Config
void	DoConfigureGame(FileRecHndl frHndl)
{
	WindowPtr		oldPort, window;
	DialogPtr		dialog;
	short			item, userItemType, i, val, part, option;
	Handle			itemHndl;
	Rect			userItemRect;
	Str255			zone, machine, userName, timeStamp;
	Point					mouseLoc;
	unsigned long			tick, timeInSecs;
	long					defaultTime, defaultMinutes;
	Boolean					colorChange, timeChange;
	TheDocPtr				docPtr;
	static	UserItemUPP		configureGameUPP = nil;
	static	ModalFilterUPP	configFilterUPP = nil;

	oldPort = SetFilePort(frHndl);

	newConfig = (*frHndl)->doc;
		/* So DoConfigureGameProc can know, too.  This also allows us to cancel,
		** without changes. */

	zone[0] = machine[0] = userName[0] = timeStamp[0] = 0;
	colorChange = timeChange = 0;

	window = (*frHndl)->fileState.window;
	if (dialog = GetCenteredDialog(rConfigureGame, nil, window, (WindowPtr)-1L)) {

		if (!SpeechAvailable())
			HideDItem(dialog, kSpeech);

		for (item = kPlayWhite; item <= kSpeech; ++item) {
			GetDItem(dialog, item, &userItemType, &itemHndl, &userItemRect);
			val = 0;
			switch (item) {
				case kPlayWhite:
				case kPlayBlack:
					if ((newConfig.myColor) == item - kPlayWhite) ++val;
					break;
				case kCompWhite:
					if (newConfig.compMovesWhite) ++val;
					break;
				case kCompBlack:
					if (newConfig.compMovesBlack) ++val;
					break;
				case kTimerToggle:
					if (newConfig.timeLeft[0] != -1) ++val;
					break;
				case kDivider1:
				case kDivider2:
				case kDivider3:
				case kWhiteClock:
				case kBlackClock:
					if (!configureGameUPP)
						configureGameUPP = NewUserItemProc (DoConfigureGameProc);
					itemHndl = (Handle)configureGameUPP;
					SetDItem(dialog, item, userItemType, itemHndl, &userItemRect);
					break;
				case kStatText3:
					pcpy(userName, &newConfig.opponentName[0]);
					pcpy(zone, &newConfig.opponentZone[0]);
					pcpy(machine, &newConfig.opponentMachine[0]);
					if (timeInSecs = newConfig.timeLastReceive)
						IUTimeString(timeInSecs, false, timeStamp);
					break;
				case kSpeech:
					val = newConfig.doSpeech;
					break;
			}

			if (val) SetCtlValue((ControlHandle)itemHndl, val);
		}

		ParamText(zone, machine, userName, timeStamp);
		OutlineDialogItem(dialog, kConfigOK);

		for (option = 0;;) {

			SetPort(dialog);
			if (!configFilterUPP)
				configFilterUPP = NewModalFilterProc (configFilter);
			ModalDialog(configFilterUPP, &item);

			if (item == kConfigOK) {

				docPtr = &((*frHndl)->doc);
				docPtr->compMovesWhite = newConfig.compMovesWhite;
				docPtr->compMovesBlack = newConfig.compMovesBlack;
					/* This is between us and us. */

				docPtr->doSpeech = newConfig.doSpeech;

				if (timeChange) {
					for (i = 0; i < 2; ++i) {
						if (option) {
							if (newConfig.timeLeft[i] == -1)
								docPtr->freezeTime[i] = docPtr->timeLeft[i];
							else
								newConfig.timeLeft[i] = docPtr->freezeTime[i];
						}
						else docPtr->freezeTime[i] = -1;
						docPtr->displayTime[i] = newConfig.defaultTime[i];
						docPtr->defaultTime[i] = newConfig.defaultTime[i];
						docPtr->timeLeft[i]    = newConfig.timeLeft[i];
					}
					(*frHndl)->doc.timerRefTick = TickCount();
					UpdateGameStatus(frHndl);
					SendMssg(frHndl, kTimeMssg);
					DrawTime(frHndl);
				}

				if (colorChange)
					SendMssg(frHndl, newConfig.myColor);

				break;
			}

			if (item == kConfigCancel) break;

			GetDItem(dialog, item, &userItemType, &itemHndl, &userItemRect);
			switch (item) {
				case kPlayWhite:
				case kPlayBlack:
					if (!GetCtlValue((ControlHandle)itemHndl)) {
						colorChange = true;
						SetCtlValue((ControlHandle)itemHndl, true);
						GetDItem(dialog, (kPlayWhite + kPlayBlack) - item,
								 &userItemType, &itemHndl, &userItemRect);
						SetCtlValue((ControlHandle)itemHndl, false);
						newConfig.myColor ^= 1;
					}
					break;
				case kCompWhite:
				case kCompBlack:
					val = (GetCtlValue((ControlHandle)itemHndl) ^ 1);
					SetCtlValue((ControlHandle)itemHndl, val);
					if (item == kCompWhite)
						newConfig.compMovesWhite = val;
					else
						newConfig.compMovesBlack = val;
					break;
				case kTimerToggle:
					option = gOption;
					timeChange = true;
					val = (GetCtlValue((ControlHandle)itemHndl) ^ 1);
					SetCtlValue((ControlHandle)itemHndl, val);
					if (val) {
						for (i = 0; i < 2; ++i)
							newConfig.timeLeft[i] = newConfig.displayTime[i] =
								newConfig.defaultTime[i];
					}
					else {
						for (i = 0; i < 2; ++i)
							newConfig.timeLeft[i] = -1;
					}						
					for (item = kWhiteClock; item <= kBlackClock; ++item)
						DoConfigureGameProc(dialog, item);
					break;
				case kWhiteClock:
				case kBlackClock:
					if (newConfig.timeLeft[0] == -1) break;

					userItemRect.right  -= 2;
					userItemRect.bottom -= 2;
						/* Don't include the drop shadow in hit area. */

					part = 0;
					tick = TickCount();

					GetMouse(&mouseLoc);
					if (PtInRect(mouseLoc, &userItemRect)) {
						if (mouseLoc.h < userItemRect.left + 16) {
							userItemRect.right = userItemRect.left + 16;
							part = 1;
						}
						else {
							if (mouseLoc.h > userItemRect.right - 16) {
								userItemRect.left = userItemRect.right - 16;
								part = 3;
							}
						}
						if (part) {
							if (mouseLoc.v > userItemRect.top + 12) {
								++part;
								userItemRect.top += 12;
							}
							else
								userItemRect.bottom = userItemRect.top + 12;
						}
					}
					if (!PtInRect(mouseLoc, &userItemRect)) part = 0;
						/* After calculating which rect we are supposed to be in,
						** make sure we are actually in it.  (We might not be.) */

					do {
						GetMouse(&mouseLoc);
						if (PtInRect(mouseLoc, &userItemRect)) {
							if (part) {
								timeChange = true;
								defaultTime = newConfig.defaultTime[item - kWhiteClock];
								if (part >= 3) {
									defaultMinutes = defaultTime;
									defaultTime /= 216000L;
									defaultTime *= 216000L;
									defaultMinutes -= defaultTime;
								}
							}
							switch (part) {
								case 1:
									iconNum[0] = rConfigBase + 3;
									defaultTime += 216000L;
									if (defaultTime >= (216000L * 4))
										defaultTime -= (216000L * 4);
									if (!defaultTime)
										defaultTime = 216000L;
									break;
								case 2:
									iconNum[0] = rConfigBase + 4;
									defaultTime -= 216000L;
									if (defaultTime < 0)
										defaultTime += (216000L * 4);
									if (!defaultTime)
										defaultTime = (216000L * 3);
									break;
								case 3:
									iconNum[2] = rConfigBase + 5;
									defaultMinutes += 3600;
									if (defaultMinutes >= 216000L)
										defaultMinutes -= 216000L;
									defaultTime += defaultMinutes;
									if (!defaultTime)
										defaultTime = 3600;
									break;
								case 4:
									iconNum[2] = rConfigBase + 6;
									defaultMinutes -= 3600;
									if (defaultMinutes < 0)
										defaultMinutes += 216000L;
									defaultTime += defaultMinutes;
									if (!defaultTime)
										defaultTime = (216000L - 3600);
									break;
							}
						}
						if (part) {
							newConfig.defaultTime[item - kWhiteClock] = defaultTime;
							for (i = 0; i < 2; ++i)
								newConfig.timeLeft[i] = newConfig.displayTime[i] =
									newConfig.defaultTime[i];
							DoConfigureGameProc(dialog, item);
							iconNum[0] = rConfigBase;
							iconNum[2] = rConfigBase + 2;
						}

						while ((StillDown()) && (tick + 30 > TickCount()));
						tick += 3;

					} while (StillDown());

					DoConfigureGameProc(dialog, item);
					break;

				case kSpeech:
					val = (GetCtlValue((ControlHandle)itemHndl) ^ 1);
					SetCtlValue((ControlHandle)itemHndl, val);
					newConfig.doSpeech = val;
					break;
			}
		}
		DisposDialog(dialog);
	}

	SetPort(oldPort);
}



/*****************************************************************************/



#pragma segment Config
pascal void	DoConfigureGameProc(DialogPtr dialog, short userItem)
{
	short			userItemType;
	Handle			userProc;
	Rect			userItemRect;
	Rect			clockRect;
	short			i, time[3];
	unsigned long	defaultTime;
	Handle			clockPart;
	RgnHandle		oldClip, newClip, textClip;
	Str32			pstr;
	Boolean			timed;

	GetDItem(dialog, userItem, &userItemType, &userProc, &userItemRect);
	if (userItem < kWhiteClock) {
		PenPat((ConstPatternParam)&qd.gray);
		FrameRect(&userItemRect);
		PenNormal();
	}
	else {
		timed = (newConfig.timeLeft[0] != -1);

		oldClip = NewRgn();
		GetClip(oldClip);
		newClip = NewRgn();
		RectRgn(newClip, &userItemRect);
		SetRectRgn(textClip = NewRgn(),
			userItemRect.left   + 16,
			userItemRect.top    + 2,
			userItemRect.right  - 19,
			userItemRect.bottom - 4);
		if (timed) DiffRgn(newClip, textClip, newClip);
		SetClip(newClip);

		clockRect = userItemRect;
		clockRect.right  = clockRect.left + 32;
		clockRect.bottom = clockRect.top  + 32;
		for (i = 0; i < 3; ++i) {
			if (clockPart = GetResource('ICN#', iconNum[i]))
				PlotIcon(&clockRect, clockPart);
			OffsetRect(&clockRect, 24, 0);
		}

		if (timed) {
			SetClip(textClip);
			TextMode(srcCopy);
			defaultTime = newConfig.defaultTime[userItem - kWhiteClock];
			for (i = 3; i;) {
				defaultTime /= 60;
				time[--i] = defaultTime % 60;
			}
			for (i = 0; i < 2; ++i) {
				MoveTo(userItemRect.left + 21 + 20 * i, userItemRect.top + 15);
				pcpydec(pstr, time[i]);
				if (pstr[0] == 1) DrawChar('0');
				DrawString(pstr);
				DrawChar(": "[i]);
			}
			TextMode(srcOr);
		}

		SetClip(oldClip);
		DisposeRgn(oldClip);
		DisposeRgn(newClip);
		DisposeRgn(textClip);
	}
}



/*****************************************************************************/



#pragma segment Config
pascal Boolean	configFilter(DialogPtr dlg, EventRecord *event, short *item)
{
	static unsigned long	lastIdle;

	gOption = (event->modifiers) & optionKey;

	if (KeyEquivFilter(dlg, event, item))
		return(true);

	if (lastIdle + 30 < TickCount()) {
		lastIdle = TickCount();
		DoIdleTasks(false);
		SetPort(dlg);
	}

	return(false);
}




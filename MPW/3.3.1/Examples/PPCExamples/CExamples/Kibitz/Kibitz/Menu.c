/*
** Apple Macintosh Developer Technical Support
**
** File:        menu.c
** Written by:  Eric Soldan
**
** Copyright © 1990-1992 Apple Computer, Inc.
** All rights reserved. */



/*****************************************************************************/



#include "Kibitz.h"				/* Get the Kibitz includes/typedefs, etc.	*/
#include "KibitzCommon.h"		/* Get the stuff in common with rez.		*/
#include "Kibitz.protos"		/* Get the prototypes for Kibitz.			*/

#ifndef __DESK__
#include <Desk.h>
#endif

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __MENUS__
#include <Menus.h>
#endif

#ifndef __STRING__
#include <String.h>
#endif

#ifndef __TEXTEDITCONTROL__
#include <TextEditControl.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif

#ifndef __UTILITIES__
#include <Utilities.h>
#endif



/*****************************************************************************/



extern Boolean	gQuitApplication;
extern Boolean	gHasAppleEvents;
extern Boolean	gHasPPCToolbox;
extern Boolean	gSendToSelf;
extern short	gReplyMode;

short			gMenuMods;



/*****************************************************************************/
/*****************************************************************************/



/* Enable and disable menus based on the current state.  The user can only
** select enabled menu items.  We set up all the menu items before calling
** MenuSelect or MenuKey, since these are the only times that a menu item can
** be selected.  Note that MenuSelect is also the only time the user will see
** menu items.  This approach to deciding what enable/ disable state a menu
** item has the advantage of concentrating all the decision-making in one
** routine, as opposed to being spread throughout the application.  Other
** application designs may take a different approach that is just as valid. */

#pragma segment Menu
void	AdjustMenus(void)
{
	WindowPtr		window;
	MenuHandle		menu;
	short			numWindows, activeItem;
	Boolean			maxWindows, menuEnabled, redrawMenuBar, winIsDirty, fileIsOpen;
	TEHandle		teHndl;
	Rect			rct;
	FileRecHndl		frHndl;
	static Boolean	editMenuEnabled   = true;
	static Boolean	gameMenuEnabled   = true;

	redrawMenuBar = false;
	window = FrontWindow();

	if (IsAppWindow(window)) frHndl = (FileRecHndl)GetWRefCon(window);

	menu = GetMHandle(mFile);

	EnableItem(menu, iNew);				/* Set these for the no-windows state. */
	EnableItem(menu, iOpen);
	EnableItem(menu, iMessage);
	if (MaxBlock() < 0x10000L) {
		if (CompactMem(0x10000L) < 0x10000L) {
			DisableItem(menu, iNew);	/* Running low on RAM. */
			DisableItem(menu, iOpen);
		}
	}

	DisableItem(menu, iClose);
	DisableItem(menu, iSave);
	DisableItem(menu, iSaveAs);
	DisableItem(menu, iSaveBoardImage);
	DisableItem(menu, iDuplicate);
	DisableItem(menu, iRevert);
	DisableItem(menu, iPageSetup);
	DisableItem(menu, iPrint);
		/* Quit is always hilited. */



	if (IsDAWindow(window)) {
		DisableItem(menu, iNew);		/* DAs don't get to do a new. */
		DisableItem(menu, iOpen);		/* DAs don't get to do an open. */
		DisableItem(menu, iMessage);	/* DAs don't get to do a new. */
		EnableItem(menu, iClose);		/* Let DAs do a close from the menu. */
	}

	if (IsAppWindow(window)) {
		numWindows = GetWindowCount(false, false, false);
		maxWindows = (numWindows < kMaxNumWindows);
		EnableOrDisableItem(menu, iNew, maxWindows);
		EnableOrDisableItem(menu, iOpen, maxWindows);
		EnableOrDisableItem(menu, iMessage, maxWindows);
			/* Allow a new and open only if max number of files not reached. */

		winIsDirty = AppWindowDirty(window);
		fileIsOpen = ((*frHndl)->fileState.fss.vRefNum != kInvalVRefNum);

		EnableItem(menu, iClose);
		EnableOrDisableItem(menu, iSave, winIsDirty);
		EnableItem(menu, iSaveAs);
		if ((*frHndl)->doc.myColor != kMessageDoc) EnableItem(menu, iSaveBoardImage);
		EnableItem(menu, iDuplicate);
		EnableOrDisableItem(menu, iRevert, ((winIsDirty) && (fileIsOpen)));

		EnableItem(menu, iPageSetup);
		EnableItem(menu, iPrint);
	}



	menu = GetMHandle(mEdit);
	DisableItem(menu, iSelectAll);
	if (IsDAWindow(window)) {		/* A desk accessory may need edit menu. */
		menuEnabled = true;
		EnableItem(menu, iUndo);
		EnableItem(menu, iCut);
		EnableItem(menu, iCopy);
		EnableItem(menu, iPaste);
		EnableItem(menu, iClear);
	} else {
		menuEnabled = false;
		if (window) {
			CTEEditMenu(&menuEnabled, mEdit, iUndo, iCut);
			if (CTETargetInfo(&teHndl, &rct) == window) {
				if ((*teHndl)->teLength) {
					EnableItem(menu, iSelectAll);
					menuEnabled = true;
				}
			}
		}
	}
	if (editMenuEnabled != menuEnabled) {
		redrawMenuBar = true;
		if (editMenuEnabled = menuEnabled) EnableItem(menu, 0);
		else							   DisableItem(menu, 0);
	}



	menu = GetMHandle(mGame);				/* Start by disabling everything. */
	menuEnabled = false;
	DisableItem(menu, iConfigureGame);
	DisableItem(menu, iInvertBoard);
	DisableItem(menu, iArrangeBoard);
	DisableItem(menu, iPlayOnePlayer);
	DisableItem(menu, iPlayTwoPlayer);
	DisableItem(menu, iFindTwoPlayer);
	DisableItem(menu, iGoToMove);
	DisableItem(menu, iAlgOut);
	DisableItem(menu, iAlgIn);

	CheckItem(menu, iArrangeBoard, false);
	CheckItem(menu, iPlayOnePlayer, false);
	CheckItem(menu, iPlayTwoPlayer, false);
	CheckItem(menu, iFindTwoPlayer, false);

	if (IsAppWindow(window)) {

		if (!(*frHndl)->fileState.readOnly) {

			if ((*frHndl)->doc.myColor != kMessageDoc) {

				menuEnabled = true;

				if (!(*frHndl)->doc.arrangeBoard) {
					EnableItem(menu, iConfigureGame);
					EnableItem(menu, iArrangeBoard);
				}
				EnableItem(menu, iInvertBoard);
				EnableItem(menu, iPlayOnePlayer);
				if (gHasAppleEvents) {				/* Now the 7.0 goodie... */
					EnableItem(menu, iPlayTwoPlayer);
					EnableItem(menu, iFindTwoPlayer);
				}

				if ((*frHndl)->doc.numGameMoves)
					EnableItem(menu, iGoToMove);

				if ((*frHndl)->doc.gameIndex < (*frHndl)->doc.numGameMoves)
					EnableItem(menu, iAlgOut);

				teHndl = (*frHndl)->doc.message[kMessageOut];
				if ((*teHndl)->selStart != (*teHndl)->selEnd)
					EnableItem(menu, iAlgIn);

				activeItem = iPlayOnePlayer + (*frHndl)->doc.twoPlayer;
				if ((*frHndl)->doc.arrangeBoard) activeItem = iArrangeBoard;
				DisableItem(menu, activeItem);
				if (activeItem == iPlayTwoPlayer) DisableItem(menu, iFindTwoPlayer);
				CheckItem(menu, activeItem, true);
			}
		}
	}
	if (gameMenuEnabled != menuEnabled) {
		redrawMenuBar = true;
		if (gameMenuEnabled = menuEnabled)
			 EnableItem(menu, 0);
		else DisableItem(menu, 0);
	}



	if (redrawMenuBar) DrawMenuBar();
}



/*****************************************************************************/



/* This function either enables or disables a menu item. */

#pragma segment Menu
void	EnableOrDisableItem(MenuHandle menu, short item, Boolean enable)
{
	if (enable) EnableItem(menu, item);
	else		DisableItem(menu, item);
}



/*****************************************************************************/



/* This is called when an item is chosen from the menu bar (after calling
** MenuSelect or MenuKey).  It performs the right operation for each command.
** It is good to have both the result of MenuSelect and MenuKey go to one
** routine like this to keep everything organized. */

#pragma segment Menu
void	DoMenuCommand(long menuResult, EventRecord *event)
{
	short		menuID;			/* The resource ID of the selected menu. */
	short		menuItem;		/* The item number of the selected menu. */
	Str255		daName;
	short		daRefNum, arrangeBoard;
	FileRecHndl	frHndl, newFrHndl;
	OSErr		err;
	WindowPtr	window, oldPort;
	short		itemHit;
	DialogPtr	dlg;
	StringPtr	nbpType;
	TEHandle	teHndl;
	Rect		rct;

	gMenuMods = event->modifiers;

	if (window = FrontWindow())
		frHndl = (FileRecHndl)GetWRefCon(window);
			/* frHndl is valid only if it is one of our windows. */

	menuID = HiWord(menuResult);	/* Use macros for efficiency to get */
	menuItem = LoWord(menuResult);	/* menu item number and menu number. */

	switch (menuID) {

		case mApple:
			switch (menuItem) {
				case iAbout:	/* Bring up alert for About. */
					Alert(rAboutAlert, gAlertFilterUPP);
					break;
				default:		/* All non-About items in this menu are DAs. */
					GetItem(GetMHandle(mApple), menuItem, daName);
					daRefNum = OpenDeskAcc(daName);
					break;
			}
			break;

		case mFile:
			switch (menuItem) {
				case iNew:
					err = AppNewDocument(&frHndl, ksOrigName);
					if (!err) {
						(*frHndl)->doc.compMovesBlack = true;
						if (err = AppNewWindow(frHndl, nil, (WindowPtr)-1))
							AppDisposeDocument(frHndl);
					}
					if (err) Alert(rErrorAlert, gAlertFilterUPP);
					break;
				case iOpen:
					err = AppOpenDocument(&frHndl, nil, fsRdWrPerm);
					if (!err) {
						if (err = AppNewWindow(frHndl, nil, (WindowPtr)-1))
							AppDisposeDocument(frHndl);
						else
							AppAutoLaunch(frHndl);
					}
					if ((err) && (err != userCanceledErr))
						Alert(rErrorAlert, gAlertFilterUPP);
					break;
				case iMessage:
					err = AppNewDocument(&frHndl, ksMssgName);
					if (!err) {
						if (err = AppNewWindow(frHndl, nil, (WindowPtr)-1))
							AppDisposeDocument(frHndl);
					}
					if (err) Alert(rErrorAlert, gAlertFilterUPP);
					break;
				case iClose:
					CloseOneWindow(window, iClose);
					break;
				case iSave:
					err = AppSaveDocument(frHndl, window, iSave);
					if ((err) && (err != userCanceledErr))
						Alert(rErrorAlert, gAlertFilterUPP);
					break;
				case iSaveAs:
					err = AppSaveDocument(frHndl, window, iSaveAs);
					if ((err) && (err != userCanceledErr))
						Alert(rErrorAlert, gAlertFilterUPP);
					break;
				case iSaveBoardImage:
					err = SaveBoardImage(frHndl);
					if ((err) && (err != userCanceledErr))
						Alert(rErrorAlert, gAlertFilterUPP);
					break;
				case iDuplicate:
					err = AppDuplicateDocument(frHndl, &newFrHndl);
					if (!err) {
						if (err = AppNewWindow(newFrHndl, nil, (WindowPtr)-1))
							AppDisposeDocument(newFrHndl);
					}
					if (err) Alert(rErrorAlert, gAlertFilterUPP);
					break;
				case iRevert:
					DoSetCursor(&qd.arrow);
					if (dlg = GetCenteredDialog(rRevertWarning, nil,
												FrontWindow(), (WindowPtr)-1L)) {
						OutlineDialogItem(dlg, 1);
						ModalDialog(gKeyEquivFilterUPP, &itemHit);
						DisposeDialog(dlg);
						if (itemHit == 3) break;
					}
					if ((*frHndl)->doc.twoPlayer) SetOpponentType(frHndl, kOnePlayer);
					if (!(AppReadDocument(frHndl, gameFileType))) {
						arrangeBoard = (*frHndl)->doc.arrangeBoard;
						if (arrangeBoard)
							if (CTETargetInfo(&teHndl, &rct) == window)
								CTEActivate(false, teHndl);
						oldPort = SetFilePort(frHndl);
						rct = window->portRect;
						EraseRect(&rct);
						ImageDocument(frHndl, false);
						if (!arrangeBoard) AdjustGameSlider(frHndl);
						UpdateGameStatus(frHndl);
						DrawTime(frHndl);
						SetPort(oldPort);
						if (!arrangeBoard) CTEWindActivate(window, true);
					}
					break;
				case iPageSetup:
					DoSetCursor(&qd.arrow);
					PresentStyleDialog(frHndl);
					break;
				case iPrint:
					DoSetCursor(&qd.arrow);
					err = noErr;
					if (!(*frHndl)->doc.printRecValid)
						err = PresentStyleDialog(frHndl);
					if (!err) {
						err = AppPrintDocument(frHndl, true, true);
						AppPrintDocument(nil, false, false);
					}
					if ((err) && (err != userCanceledErr))
						Alert(rErrorAlert, gAlertFilterUPP);
					break;
				case iQuit:
					gQuitApplication = CloseAllWindows();
					break;
			}
			break;

		case mEdit:			/* Call SystemEdit for DA editing & MultiFinder. */
			if (IsAppWindow(window)) {
				switch (menuItem) {
					case iUndo:
						CTEUndo();
						break;
					case iCut:
					case iCopy:
					case iPaste:
					case iClear:
						CTEClipboard(menuItem - iCut + 2);
						if (menuItem != iCopy) (*frHndl)->fileState.docDirty = true;
						break;
					case iSelectAll:
						if (CTETargetInfo(&teHndl, &rct) == window) CTESetSelect(0, 32000, teHndl);
						break;
				}
			}
			else SystemEdit(menuItem - 1);
			break;

		case mGame:
			switch (menuItem) {
				case iConfigureGame:
					DoSetCursor(&qd.arrow);
					DoConfigureGame(frHndl);
					break;
				case iInvertBoard:
					(*frHndl)->doc.invertBoard ^= 1;
					if (!(*frHndl)->doc.twoPlayer) {
						if ((*frHndl)->doc.compMovesWhite + (*frHndl)->doc.compMovesBlack == 1) {
							if ((*frHndl)->doc.compMovesWhite == (*frHndl)->doc.myColor) {
								(*frHndl)->doc.compMovesWhite ^= true;
								(*frHndl)->doc.compMovesBlack ^= true;
								(*frHndl)->doc.myColor        ^= true;
							}
						}
					}
					SetPort(window);
					ImageDocument(frHndl, true);
					DrawTime(frHndl);
					break;
				case iArrangeBoard:
				case iPlayOnePlayer:
				case iPlayTwoPlayer:
				case iFindTwoPlayer:
					DoSetCursor(&qd.arrow);
					if ((menuItem == iArrangeBoard) && ((*frHndl)->doc.numGameMoves)) {
						if (dlg = GetCenteredDialog(rArrangeWarning, nil,
													FrontWindow(), (WindowPtr)-1L)) {
							OutlineDialogItem(dlg, 1);
							ModalDialog(gKeyEquivFilterUPP, &itemHit);
							DisposeDialog(dlg);
							if (itemHit == 3) break;
						}
					}
					nbpType = nil;
					if (menuItem == iFindTwoPlayer) {
						menuItem = iPlayTwoPlayer;
						nbpType = "\pKibitz";
					}
					if (menuItem == iPlayTwoPlayer) {
						if (!(*frHndl)->doc.twoPlayer) SendGame(frHndl, kIsMove, nbpType);
					}
					else SetOpponentType(frHndl, menuItem - iPlayOnePlayer + kOnePlayer);
					break;
				case iGoToMove:
					DoGoToMove(frHndl);
					break;
				case iAlgOut:
					DoSetCursor(*GetCursor(watchCursor));
					MovesToOutBox(frHndl, event);
					break;
				case iAlgIn:
					DoSetCursor(*GetCursor(watchCursor));
					teHndl = (*frHndl)->doc.message[kMessageOut];
					MovesFromText(frHndl, (*teHndl)->hText, (*teHndl)->teLength,
								  (*teHndl)->selStart, (*teHndl)->selEnd, false);
					break;
			}
			break;

	}

	HiliteMenu(0);		/* Unhighlight what MenuSelect (or MenuKey) hilited. */
}




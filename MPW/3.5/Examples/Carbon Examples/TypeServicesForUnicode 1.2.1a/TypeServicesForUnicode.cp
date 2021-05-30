/*
	File:		TypeServicesForUnicode.cp

	Description:This is a very simple sample program that demonstrates how to use the new 
				Apple Text Services For Unicode Imaging technology introduced in Mac OS 8.5.

	Author:		ES

	Copyright:	Copyright © 1998-2000 by Apple Computer, Inc., All Rights Reserved.

	Disclaimer:	IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
				("Apple") in consideration of your agreement to the following terms, and your
				use, installation, modification or redistribution of this Apple software
				constitutes acceptance of these terms.  If you do not agree with these terms,
				please do not use, install, modify or redistribute this Apple software.

				In consideration of your agreement to abide by the following terms, and subject
				to these terms, Apple grants you a personal, non-exclusive license, under Apple’s
				copyrights in this original Apple software (the "Apple Software"), to use,
				reproduce, modify and redistribute the Apple Software, with or without
				modifications, in source and/or binary forms; provided that if you redistribute
				the Apple Software in its entirety and without modifications, you must retain
				this notice and the following text and disclaimers in all such redistributions of
				the Apple Software.  Neither the name, trademarks, service marks or logos of
				Apple Computer, Inc. may be used to endorse or promote products derived from the
				Apple Software without specific prior written permission from Apple.  Except as
				expressly stated in this notice, no other rights or licenses, express or implied,
				are granted by Apple herein, including but not limited to any patent rights that
				may be infringed by your derivative works or by other works in which the Apple
				Software may be incorporated.

				The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
				WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
				WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
				PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
				COMBINATION WITH YOUR PRODUCTS.

				IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
				CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
				GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
				ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION
				OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT
				(INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN
				ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

	Change History (most recent first):
				 7/27/1999	KG				Updated for Metrowerks Codewarror Pro 2.1				
				 9/01/1998	AD				Updated
				 7/01/1998	ES				Created
				

*/

#ifdef __MWERKS__

// includes for MetroWerks CodeWarrior

#include <ATSUnicode.h>
#include <ControlDefinitions.h>
#include <Dialogs.h>
#include <Fonts.h>
#include <Windows.h>
#include <TextEdit.h>
#include <Gestalt.h>
#include <Devices.h>

#else

#ifdef __APPLE_CC__

// includes for ProjectBuilder

#include <Carbon/Carbon.h>

#else

// includes for MPW

#include <Carbon.h>
#include <CoreServices.h>

#endif

#endif


#include "SomeUnicodeStuff.h"
#include "WindowUtilities.h"
#include "TypeServicesForUnicode.h"
#include "SampleWindows.h"

Boolean stop;
Boolean sawMemoryAlert;

int main(void)
{
	InitializeMac();
	if (!CanUseATSUI())
		{
		StopAlert(128, NULL);
		return 0;
		}
	InitializeAppl();
	
	do MainEventLoop(); while (stop == false);

	return 0;	
}

// 
//	Initialize the Toolbox
//

void InitializeMac()
{
	/* Initialize all the needed managers. */
#if !TARGET_API_MAC_CARBON
	InitGraf(&qd.thePort);
	InitFonts();
	InitWindows();
	InitMenus();
	TEInit();
	InitDialogs(NULL);
#endif

	InitCursor();
	FlushEvents(everyEvent,0);
	
#if !TARGET_API_MAC_CARBON
	MaxApplZone();
#endif
}

// 
//	Initialize the Application
//

void InitializeAppl()
{
	Handle menuBar = GetNewMBar(128);
	SetMenuBar(menuBar);
	DrawMenuBar();
	DisposeHandle(menuBar);
#if TARGET_API_MAC_CARBON
	if (IsThisAqua()) // removing the Quit menu item
		{
		MenuHandle menu = GetMenuHandle(128);
		DeleteMenuItem(menu, 3);
		DeleteMenuItem(menu, 2);
		}
#else
	AppendResMenu(GetMenuHandle(1), 'DRVR');
#endif
	InstallAppleEventHandlers();
	stop = false;
	sawMemoryAlert = false;
}

// 
//	Initialize the standard Apple event handlers
//

void InstallAppleEventHandlers()
	{
	long result;
	OSErr err = Gestalt(gestaltAppleEventsAttr, &result);
	if (err == noErr)
		{	// we should care for the return values of AEInstallEventHandler but since it's just a sample...
		AEInstallEventHandler(kCoreEventClass, kAEOpenApplication, NewAEEventHandlerUPP(HandleOapp), 0, false);
		AEInstallEventHandler(kCoreEventClass, kAEOpenDocuments,   NewAEEventHandlerUPP(HandleOdoc), 0, false);
		AEInstallEventHandler(kCoreEventClass, kAEPrintDocuments,  NewAEEventHandlerUPP(HandlePdoc), 0, false);
		AEInstallEventHandler(kCoreEventClass, kAEQuitApplication, NewAEEventHandlerUPP(HandleQuit), 0, false);
		}
	}

#if !TARGET_API_MAC_CARBON
pascal OSErr HandleOapp (AEDescList *aevt, AEDescList *reply, long refCon)
#else
pascal OSErr HandleOapp (const AppleEvent *aevt, AEDescList *reply, long refCon)
#endif
	{
#pragma unused (aevt, reply, refCon)
	return noErr;
	}

#if !TARGET_API_MAC_CARBON
pascal OSErr HandleOdoc (AEDescList *aevt, AEDescList *reply, long refCon)
#else
pascal OSErr HandleOdoc (const AppleEvent *aevt, AEDescList *reply, long refCon)
#endif
	{
#pragma unused (aevt, reply, refCon)
	return errAEEventNotHandled;
	}

#if !TARGET_API_MAC_CARBON
pascal OSErr HandlePdoc (AEDescList *aevt, AEDescList *reply, long refCon)
#else
pascal OSErr HandlePdoc (const AppleEvent *aevt, AEDescList *reply, long refCon)
#endif
	{
#pragma unused (aevt, reply, refCon)
	return errAEEventNotHandled;
	}

#if !TARGET_API_MAC_CARBON
pascal OSErr HandleQuit (AEDescList *aevt, AEDescList *reply, long refCon)
#else
pascal OSErr HandleQuit (const AppleEvent *aevt, AEDescList *reply, long refCon)
#endif
	{
#pragma unused (aevt, reply, refCon)
	stop = true;
	return noErr;
	}

Boolean CanUseATSUI()
	{
	long result;
	OSErr err = Gestalt(gestaltATSUVersion, &result);
	return (err == noErr);
	}

void MainEventLoop()
	{
	EventRecord theEvent;
	WindowPtr theWind;
	long sleep = 4;
	while (!stop)
		{
		if (!sawMemoryAlert && (FreeMem() < 100000))
			{
			StopAlert(130, NULL);
			sawMemoryAlert = true;
			}
		if (WaitNextEvent(everyEvent, &theEvent, sleep, 0L))
			switch (theEvent.what)
				{
				case mouseDown:
					switch (FindWindow(theEvent.where, &theWind))
						{
						case inMenuBar:
							AdjustMenus();
							DoMenuCommand(MenuSelect(theEvent.where));
							break;
						case inSysWindow:
#if !TARGET_API_MAC_CARBON
							SystemClick(&theEvent, theWind);
#endif
							break;
						case inContent:
							if ((theWind != gFontFeaturesWindow) && (theWind != FrontNonFloatingWindow()))
								SelectWindow(theWind);
							else
								{
								Point thePoint = theEvent.where;
								ControlHandle theControl;
								GrafPtr savePort;
								GetPort(&savePort);
#if !TARGET_API_MAC_CARBON
								SetPort(theWind);
#else
								SetPortWindowPort(theWind);
#endif
								GlobalToLocal(&thePoint);
								short partCode = FindControl(thePoint, theWind, &theControl);
								if (partCode != 0)
									{
									short finalPartCode = TrackControl(theControl, thePoint, NULL);
									if (partCode == finalPartCode)
										{
										WindowDataPtr wdataP = GetWindowData(theWind);
										if ((theWind == gFontFeaturesWindow) && (gFontFeaturesWindow != NULL))
											ChangeTheFeature(theControl);
										else if (wdataP != NULL)
											{
											long whichControlRef = GetControlReference(theControl);
											switch (wdataP->sampleKind)
												{
												case 3: // only 1 button...
													RotateTheLine(wdataP);
													break;
												case 4: // Smaller or Bigger, 1 gives 1, 2 gives -1...
													SmallerBiggerFont(wdataP, ff(1 - 2 * (whichControlRef - 1)));
													break;
												case 5:
													if (whichControlRef <= 4)
														HilightAndOrMove(wdataP, GetControlReference(theControl));
													else
														{
														UnhilightCurrentSelection(wdataP);
														((Sample5_PrivateData *)wdataP->privateData)->withHilight = false;
														SmallerBiggerFont(wdataP, ff(1 - 2 * (whichControlRef - 5)));
														}
													break;
												case 7:
													if (whichControlRef == 1)
														DoShowClipboard();
													else DoCopy(wdataP);
													break;
												}
											}
										}
									else if (finalPartCode == kControlMenuPart)
										{
										WindowDataPtr wdataP = GetWindowData(theWind);
										if (wdataP != NULL)
											{
											switch (wdataP->sampleKind)
												{
												case 9:
													ChangeTheFont(wdataP);
													break;
												}
											}
										}
									}
								else
									{
									WindowDataPtr wdataP = GetWindowData(theWind);
									if (wdataP != NULL)
										if ((wdataP->sampleKind == 6) || (wdataP->sampleKind == 7))
											ClickInSample6Window(wdataP, &theEvent);
									}
								SetPort(savePort);
								}
							break;
						case inDrag:
							Rect bounds;
#if !TARGET_API_MAC_CARBON
							bounds = qd.screenBits.bounds;
#else
							BitMap bmap;
							GetQDGlobalsScreenBits(&bmap);
							bounds = bmap.bounds;
#endif
							DragWindow(theWind, theEvent.where, &bounds);
							break;
						case inGrow:
							break;
						case inGoAway:
							if (TrackGoAway(theWind, theEvent.where))
								if (theEvent.modifiers & optionKey)
									CloseAllWindows();
								else
									DoCloseWindow(theWind);
							break;
						case inZoomIn: case inZoomOut: default:
							break;
						}
					break;
				case keyDown: case autoKey:
					if (theEvent.modifiers & cmdKey)
						{
						AdjustMenus();
						DoMenuCommand(MenuKey(theEvent.message & charCodeMask));
						}
					else
						{
						// something...
						}
					break;
				case activateEvt:
					{
					theWind = (WindowPtr)theEvent.message;
					WindowDataPtr wdataP = GetWindowData(theWind);
					if (wdataP != NULL)
						if ((wdataP->sampleKind == 5) || (wdataP->sampleKind == 6) || (wdataP->sampleKind == 7))
							ActivateSample5Window(theWind, wdataP, theEvent.modifiers & activeFlag);
					}
					break;
				case updateEvt:
					DoUpdateWindow((WindowPtr)theEvent.message);
					break;
				case osEvt:
					if ((theEvent.message & osEvtMessageMask) == 0x01000000)
						{
						theWind = FrontNonFloatingWindow();
						WindowDataPtr wdataP = GetWindowData(theWind);
						if (theEvent.message & 1)
							{/* resume */
							sleep = 4;
							Cursor arrow;
#if !TARGET_API_MAC_CARBON
							arrow = qd.arrow;
#else
							GetQDGlobalsArrow(&arrow);
#endif
							SetCursor(&arrow);
							if (wdataP != NULL)
								if ((wdataP->sampleKind == 5) || (wdataP->sampleKind == 6) || (wdataP->sampleKind == 7))
									ActivateSample5Window(theWind, wdataP, true);
							ShowFloatingWindows();
							}
						else
							{/* suspend  */
							sleep = 60;
							if (wdataP != NULL)
								if ((wdataP->sampleKind == 5) || (wdataP->sampleKind == 6) || (wdataP->sampleKind == 7))
									ActivateSample5Window(theWind, wdataP, false);
							HideFloatingWindows();
							}
						}
					break;
				case kHighLevelEvent:
					AEProcessAppleEvent(&theEvent);
					break;
				}
		}
	}

void AdjustMenus()
	{
	}

void DoMenuCommand(long menuResult)
	{
	switch(menuResult >> 16)
		{
		case 1:
			if ((menuResult & 0x0FFFF) == 1)
				{
				Alert(129, NULL);
				}
#if !TARGET_API_MAC_CARBON
			else
				{
				Str255 daName;
				GetMenuItemText(GetMenuHandle(1), (menuResult & 0x0FFFF), daName);
				OpenDeskAcc(daName);
				}
#endif
			break;
		case 128:
			switch(menuResult & 0x0FFFF)
				{
				case 1:
					{
					WindowPtr aWindow = FrontWindow();
					if (aWindow != NULL) DoCloseWindow(aWindow);
					}
					break;
				case 3:
					stop = true;
					break;
				}
			break;
		case 129:
			switch(menuResult & 0x0FFFF)
				{
				case 1:
					NewSingleLineSingleStyleWindow();
					break;
				case 2:
					NewSingleLineMultipleStylesWindow();
					break;
				case 3:
					NewSingleVerticalLineMultipleStylesWindow();
					break;
				case 4:
					NewParagraphsWindow();
					break;
				case 5:
					NewHighlightingCaretsCursorMovementsWindow();
					break;
				case 6:
					NewHitTestingWindow();
					break;
				case 7:
					NewClipboardUsingWindow();
					break;
				case 8:
					ShowATSUITextBox();
					break;
				case 9:
					ShowFontMenu();
					break;
				}
			break;
		}
	HiliteMenu(0);
	}

void DoUpdateWindow(WindowPtr theWind)
	{
	GrafPtr savePort;
	GetPort(&savePort);
#if !TARGET_API_MAC_CARBON
	SetPort(theWind);
#else
	SetPortWindowPort(theWind);
#endif
	BeginUpdate(theWind);
    if (theWind != gFontFeaturesWindow)
		{
		WindowDataPtr wdataP = GetWindowData(theWind);
		if (wdataP != NULL)
			{
			if (wdataP->sampleKind == 100)
				{
				// global clipboard window
				UpdateClipboard();
				}
			else if (wdataP->numberOfLines == 1)
				{
				// only 1 line to draw
				OSStatus status = ATSUDrawText(wdataP->textLayout, 0, wdataP->uTextLength, wdataP->xLocation, wdataP->yLocation);
				if (status != noErr) DebugStr("\p ATSUDrawText failed");
				}
			else
                {
				// the following code is only for multi-lines text (and horizontal only)
				ItemCount i;
				ATSUTextMeasurement y = wdataP->yLocation;
				UniCharArrayOffset lineStart = 0, lineEnd;
				for (i = 0; i < wdataP->numberOfLines; i++)
					{
					lineEnd = wdataP->endOfLines[i];
					OSStatus status = ATSUDrawText(wdataP->textLayout, lineStart, lineEnd-lineStart, wdataP->xLocation, y);
					if (status != noErr) DebugStr("\p ATSUDrawText failed");
					y += wdataP->lineHeight;
					lineStart = lineEnd;
					}
				}
			if ((wdataP->sampleKind == 5) || (wdataP->sampleKind == 6) || (wdataP->sampleKind == 7))
				UpdateSample5Window(theWind, wdataP);
			}
		}
#if !TARGET_API_MAC_CARBON
	UpdateControls(theWind, theWind->visRgn);
#else
	RgnHandle visibleRegion = NewRgn();
	GetPortVisibleRegion(GetWindowPort(theWind), visibleRegion);
	UpdateControls(theWind, visibleRegion);
	DisposeRgn(visibleRegion);
#endif
	EndUpdate(theWind);
	SetPort(savePort);
	}

void DoCloseWindow(WindowPtr theWind)
	{
	if (theWind == gFontFeaturesWindow)
		{
		HideWindow(gFontFeaturesWindow);
		return;
		}
	WindowDataPtr wdataP = GetWindowData(theWind);
	if (wdataP != NULL)
		{
		if (wdataP->sampleKind == 100)
			{
			// global clipboard window
			HideWindow(theWind);
			return;
			}
		if ((wdataP->sampleKind == 5) || (wdataP->sampleKind == 6) || (wdataP->sampleKind == 7))
			DisposeSample5Window(wdataP);
		if (wdataP->sampleKind == 9)
			DisposeSample9Window(wdataP);
		DisposeWindowDataPtr(wdataP);
		}
	DisposeWindow((WindowPtr)theWind);
	}

void RecursiveCloseWindow(WindowPtr theWind)
	{
#if !TARGET_API_MAC_CARBON
	WindowPtr nextWind = (WindowPtr)(((WindowPeek)theWind)->nextWindow);
#else
	WindowPtr nextWind = GetNextWindow(theWind);
#endif
	if (nextWind) RecursiveCloseWindow(nextWind);
	DoCloseWindow((WindowPtr)theWind);
	}

void CloseAllWindows()
	{
	WindowPtr theWind = FrontWindow();
	if (theWind) RecursiveCloseWindow(theWind);
	}

// some debug stuff

				/*{
				ItemCount nbFonts;
				OSStatus stat2 = ATSUFontCount(&nbFonts);
				ATSUFontID *fontIDArray = (ATSUFontID *)NewPtr(nbFonts * sizeof(ATSUFontID));
				stat2 = ATSUGetFontIDs(fontIDArray, nbFonts, &nbFonts);
				ItemCount i;
				for (i=0; i < nbFonts; i++)
					{
					ItemCount nbNames;
					stat2 = ATSUCountFontNames(fontIDArray[i], &nbNames);
					ItemCount j;
					char buffer[1000];
					ByteCount actualLength;
					FontNameCode name;
					FontPlatformCode platform;
					FontScriptCode script;
					FontLanguageCode language;
					for (j=0; j < 10; j++)
						{
						stat2 = ATSUGetIndFontName(fontIDArray[i], j, 1000, (Ptr)buffer, &actualLength, &name, &platform, &script, &language);
						buffer[actualLength] = 0;
						printf("%ld, %ld, %ld, %ld, %ld, %ld, '%s'\n", i, j, name, platform, script, language, buffer);
						}
					}
				}*/

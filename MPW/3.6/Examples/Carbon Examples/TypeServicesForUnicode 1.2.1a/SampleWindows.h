/*
	File:		SampleWindows.h

	Description:All the Text Demos

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
				10/14/1999	AD				Updated	
				7/27/1999	KG				Updated for Metrowerks Codewarror Pro 2.1
											moved all sample windows into one file
				 9/01/1998	AD				Updated
				 7/01/1998	ES				Created
				

*/

#ifndef __SAMPLEWINDOWS__
#define __SAMPLEWINDOWS__

#ifdef __MWERKS__

// includes for MetroWerks CodeWarrior

#include <TextEdit.h>
#include <Controls.h>

#else

#ifdef __APPLE_CC__

// includes for ProjectBuilder

#include <Carbon/Carbon.h>

#else

// includes for MPW

#include <Carbon.h>

#endif

#endif

#pragma mark •Single Line & Single Style
OSErr NewSingleLineSingleStyleWindow();
#pragma mark •Single Vertical Line & Multiple Styles
OSErr NewSingleLineMultipleStylesWindow();
#pragma mark •Single Vertical Line & Multiple Styles
OSErr NewSingleVerticalLineMultipleStylesWindow();
void RotateTheLine(WindowDataPtr wdataP);
#pragma mark •Paragraphs
OSErr NewParagraphsWindow();
void BreakTheTextInLines(WindowPtr aWind, WindowDataPtr wdataP);
void SmallerBiggerFont(WindowDataPtr wdataP, Fixed variation);
#pragma mark •Highlighting, Carets & Cursor Movements
typedef struct
	{
	UniCharArrayOffset selStart;		// start of the selected block in the line
	UniCharCount selLength;				// length of the selected block
	ATSUTextMeasurement xLineSel;		// graphical position of the line start at x
	ATSUTextMeasurement yLineSel;		//                                     and y
	ItemCount lineNumber;				// which line is this?
	} SelectedBlock;

typedef struct
	{
	Boolean withHilight;				// do we currently have hilighted text
	UniCharArrayOffset caret;			// logical position of the caret
	UniCharCount length;				// length of the selection
	ItemCount numberOfSelectedLines;	// number of lines on which the selection extends
	SelectedBlock *selBlocks;			// array of selected blocks
	} Sample5_PrivateData;

OSErr NewHighlightingCaretsCursorMovementsWindow();
void SetSelectedBlocks(WindowDataPtr wdataP);
void HilightAndOrMove(WindowDataPtr wdataP, long what);
void ActivateSample5Window(WindowPtr theWind, WindowDataPtr wdataP, Boolean active);
void UpdateSample5Window(WindowPtr theWind, WindowDataPtr wdataP);
void DisposeSample5Window(WindowDataPtr wdataP);
void HilightCurrentSelection(WindowDataPtr wdataP);
void UnhilightCurrentSelection(WindowDataPtr wdataP);
void BetterSmallerBiggerFont(WindowDataPtr wdataP, Fixed variation);
#pragma mark •Hit Testing
typedef struct
	{
	Boolean withHilight;				//
	UniCharArrayOffset caret;			//
	UniCharCount length;				// these 5 first fields are exactly the same
	ItemCount numberOfSelectedLines;	// as those defined in Sample5_PrivateData
	SelectedBlock *selBlocks;			//
	
	long lastClickTime;					// time and Point of last click to check
	Point lastClickPoint;				// for double-click
	} Sample6_PrivateData;

OSErr NewHitTestingWindow();
UniCharArrayOffset WhereInTextIsThisPoint(WindowDataPtr wdataP, Point thePoint, Boolean *leading);
void ClickInSample6Window(WindowDataPtr wdataP, EventRecord *theEvent);
Boolean GotDoubleClick(WindowDataPtr wdataP, EventRecord *theEvent);
void SelectWord(WindowDataPtr wdataP, UniCharArrayOffset thePos, Boolean leading, UniCharArrayOffset *startSel, UniCharArrayOffset *endSel);
void ModifySelection(WindowDataPtr wdataP, UniCharArrayOffset newStart, UniCharArrayOffset newEnd);

#pragma mark •Using the Clipboard
typedef struct
	{
	TEHandle justTheText;
	TEHandle textWithStyl;
	} SimpleQDText;

typedef struct
	{
	ItemCount nbStyles;
	UniCharCount runLengths;
	} ustlResouceStart, *ustlResourcePtr, **ustResourceHdl;

OSErr NewClipboardUsingWindow();
OSErr CreateClipboardWindow();
void DoCopy(WindowDataPtr wdataP);
void DoPaste();
void DoShowClipboard();
void UpdateClipboard();
#pragma mark •ATSU Text Box
pascal Boolean myFilter(DialogPtr currentDialog, EventRecord *theEventIn, short *theDialogItem);
OSStatus UpdateUserItem(DialogPtr theDialog);
OSErr ShowATSUITextBox();

#pragma mark •Font Menu
typedef struct
	{
	short menuID;
	void *menuLookupCookie;
	MenuHandle theMenu;
	ControlHandle button;
	} Sample9_PrivateData;

typedef struct
	{
	long group;
	ATSUFontFeatureType type;
	ATSUFontFeatureSelector sel;
	ControlHandle *cntlList;
	} FeatureGroup;

extern WindowPtr gFontFeaturesWindow;

OSErr ShowFontMenu();
void DisposeSample9Window(WindowDataPtr wdataP);
short UniqueMenuId();
void ChangeTheFont(WindowDataPtr wdataP);
void DoShowFontFeatures();
void SetUpFontFeaturesWindow(ATSUFontID theFontID, ATSUStyle tempS);
OSStatus CreateFontFeaturesWindow();
void ChangeTheFeature(ControlHandle theControl);

#endif

/*
	File:		SampleWindows.cp

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

#ifdef __MWERKS__

// includes for MetroWerks CodeWarrior

#include <ATSUnicode.h>
#include <stddef.h>
#include <ControlDefinitions.h>
#include <Windows.h>
#include <Scrap.h>
#include <Sound.h>
#include <FixMath.h>

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
#include "MoreATSUnicode.h"
#include "WindowUtilities.h"
#include "ATSUTextConversion.h"
#include "TypeServicesForUnicode.h"
#include "SampleWindows.h"

#pragma mark •Single Line & Single Style
OSErr NewSingleLineSingleStyleWindow()
	{
	OSStatus status = noErr;
	WindowPtr aWind;
	Rect boundsRect = {50, 50, 200, 500};
	
	WindowDataPtr wdataP = DefaultWindowDataPtr();
	aWind = NewCWindow(NULL, &boundsRect, "\pSingle Line & Single Style", true, noGrowDocProc, (WindowPtr)-1L, true, (long)wdataP);
	
	// let's use some text
	QuickAndDirtySetUnicodeTextFromASCII_C_Chars(kHelloWorldUnicodeText, &(wdataP->theUnicodeText), &(wdataP->uTextLength));

	// only 1 style thus only 1 run
	wdataP->numberOfRuns = 1;
	wdataP->runLengths = (UniCharCount *)NewPtr(wdataP->numberOfRuns * sizeof(UniCharCount));
	wdataP->runLengths[0] = wdataP->uTextLength;

	// and it's the default style
	wdataP->styles = (ATSUStyle *)NewPtr(wdataP->numberOfRuns * sizeof(ATSUStyle));
	ATSUStyle tempS;
	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");
	wdataP->styles[0] = tempS;

	// and we create the text layout
	ATSUTextLayout tempTL;
	status = ATSUCreateTextLayoutWithTextPtr(wdataP->theUnicodeText, 0, wdataP->uTextLength, wdataP->uTextLength, wdataP->numberOfRuns, wdataP->runLengths, wdataP->styles, &tempTL);
	if (status != noErr) DebugStr("\p ATSUCreateTextLayoutWithTextPtr failed");
	wdataP->textLayout = tempTL;
	
	// to be drawn at
	wdataP->xLocation = ff(10);
#if !TARGET_API_MAC_CARBON
	wdataP->yLocation = ff(aWind->portRect.bottom-10);
#else
	Rect thePortRect;
	GetWindowPortBounds(aWind, &thePortRect);
	wdataP->yLocation = ff(thePortRect.bottom-10);
#endif
	
	return status;
	}
#pragma mark •Single Line & Multiple Styles
OSErr NewSingleLineMultipleStylesWindow()
	{
	OSStatus status = noErr;
	WindowPtr aWind;
	Rect boundsRect = {50, 10, 200, 630};
	
	WindowDataPtr wdataP = DefaultWindowDataPtr();
	aWind = NewCWindow(NULL, &boundsRect, "\pSingle Line & Multiple Styles", true, noGrowDocProc, (WindowPtr)-1L, true, (long)wdataP);
	
	// let's use some text
	QuickAndDirtySetUnicodeTextFromASCII_C_Chars(kSomeLongerUnicodeText, &(wdataP->theUnicodeText), &(wdataP->uTextLength));

	// let's have 5 runs, setting the 4th word "much" and the last word "styles" in a different style
	wdataP->numberOfRuns = 5;
	wdataP->runLengths = (UniCharCount *)NewPtr(wdataP->numberOfRuns * sizeof(UniCharCount));
	wdataP->runLengths[0] = 10;
	wdataP->runLengths[1] = 4;
	wdataP->runLengths[2] = 39;
	wdataP->runLengths[3] = 6;
	wdataP->runLengths[4] = wdataP->uTextLength - (10 + 4 + 39 + 6);

	// we only use 3 styles, the 3rd and 5th runs use the same one as the first
	// but we still have to dimension the styles array the same as the runLengths array
	wdataP->styles = (ATSUStyle *)NewPtr(wdataP->numberOfRuns * sizeof(ATSUStyle));
	ATSUStyle tempS;
	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");

	// let's change the font
	TryToSetFontTo(tempS, "\pHelvetica");
	
	// let's add some attributes to the main style
	Fixed thePointSize = ff(12);
	ATSUAttributeTag theTag = kATSUSizeTag;
	ByteCount theSize = sizeof(Fixed);
	ATSUAttributeValuePtr theValuePtr = &thePointSize;
	status = ATSUSetAttributes(tempS, 1, &theTag, &theSize, &theValuePtr);
	if (status != noErr) DebugStr("\p ATSUSetAttributes failed");
	
	// We can use the same style object for multiple runs.
	// This is more efficient than copying it.
	wdataP->styles[0] = wdataP->styles[2] = wdataP->styles[4] = tempS;

	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");
	
	// and let's add some different attributes to the 2nd style (vertical direction, italic, blue, size 48)
	thePointSize = ff(48);
	RGBColor blueColor = {0, 0, 0xFFFF};
	Boolean italic = true;
	ATSUVerticalCharacterType direction = kATSUStronglyVertical;
	ATSUAttributeTag tags[] = {kATSUSizeTag, kATSUColorTag, kATSUQDItalicTag, kATSUVerticalCharacterTag};
	ByteCount sizes[] = {sizeof(Fixed), sizeof(RGBColor), sizeof(Boolean), sizeof(ATSUVerticalCharacterType)};
#ifdef __MRC__
	ATSUAttributeValuePtr values[4];
	values[0] = &thePointSize;
	values[1] = &blueColor;
	values[2] = &italic;
	values[3] = &direction;
#else
	ATSUAttributeValuePtr values[] = {&thePointSize, &blueColor, &italic, &direction};
#endif
	status = ATSUSetAttributes(tempS, 4, tags, sizes, values);
	if (status != noErr) DebugStr("\p ATSUSetAttributes failed");
	
	wdataP->styles[1] = tempS;

	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");

	// and let's add some different attributes to the 3rd style (Times 60 underline)
	thePointSize = ff(60);
	Boolean underline = true;
	ATSUFontID timesID = GetFontIDFromMacFontName("\pTimes");
	ATSUAttributeTag tags2[] = {kATSUSizeTag, kATSUQDUnderlineTag, kATSUFontTag};
	ByteCount sizes2[] = {sizeof(Fixed), sizeof(Boolean), sizeof(ATSUFontID)};
#ifdef __MRC__
	ATSUAttributeValuePtr values2[3];
	values2[0] = &thePointSize;
	values2[1] = &underline;
	values2[2] = &timesID;
#else
	ATSUAttributeValuePtr values2[] = {&thePointSize, &underline, &timesID};
#endif
	if (timesID != kATSUInvalidFontID)
		status = ATSUSetAttributes(tempS, 3, tags2, sizes2, values2);
	else
		status = ATSUSetAttributes(tempS, 2, tags2, sizes2, values2);
	if (status != noErr) DebugStr("\p ATSUSetAttributes failed");

	wdataP->styles[3] = tempS;

	// and we create the text layout
	ATSUTextLayout tempTL;
	status = ATSUCreateTextLayoutWithTextPtr(wdataP->theUnicodeText, 0, wdataP->uTextLength, wdataP->uTextLength, wdataP->numberOfRuns, wdataP->runLengths, wdataP->styles, &tempTL);
	if (status != noErr) DebugStr("\p ATSUCreateTextLayoutWithTextPtr failed");	
	wdataP->textLayout = tempTL;
	
	// to be drawn at
	wdataP->xLocation = ff(10);
#if !TARGET_API_MAC_CARBON
	wdataP->yLocation = ff(aWind->portRect.bottom-30);
#else
	Rect thePortRect;
	GetWindowPortBounds(aWind, &thePortRect);
	wdataP->yLocation = ff(thePortRect.bottom-30);
#endif
	
	return status;
	}

#pragma mark •Single Vertical Line & Multiple Styles
//
// NOTE - NOTE - NOTE
//
// The source code for this function would be the same (but for the last 10 lines)
// as NewSingleLineMultipleStylesWindow except that it uses the More ATSUI routines
// to make it clearer. Please compare to the source code in SampleWindow_2.cp
//
OSErr NewSingleVerticalLineMultipleStylesWindow()
	{
	OSStatus status = noErr;
	WindowPtr aWind;
	Rect boundsRect = {50, 10, 700, 630};
	
	WindowDataPtr wdataP = DefaultWindowDataPtr();
	aWind = NewCWindow(NULL, &boundsRect, "\pSingle Line & Multiple Styles", true, noGrowDocProc, (WindowPtr)-1L, true, (long)wdataP);
	
	// let's use some text
	QuickAndDirtySetUnicodeTextFromASCII_C_Chars(kSomeLongerUnicodeText, &(wdataP->theUnicodeText), &(wdataP->uTextLength));

	// let's have 5 runs, setting the 4th word "much" and the last word "styles" in a different style
	wdataP->numberOfRuns = 5;
	wdataP->runLengths = (UniCharCount *)NewPtr(wdataP->numberOfRuns * sizeof(UniCharCount));
	wdataP->runLengths[0] = 10;
	wdataP->runLengths[1] = 4;
	wdataP->runLengths[2] = 39;
	wdataP->runLengths[3] = 6;
	wdataP->runLengths[4] = wdataP->uTextLength - (10 + 4 + 39 + 6);

	// we only use 3 styles, the 3rd and 5th runs use the same one as the first
	// but we still have to dimension the styles array the same as the runLengths array
	wdataP->styles = (ATSUStyle *)NewPtr(wdataP->numberOfRuns * sizeof(ATSUStyle));
	ATSUStyle tempS;
	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");

	// let's change the font
	TryToSetFontTo(tempS, "\pHelvetica");
	
	// let's add some attributes to the main style
	status = atsuSetSize(tempS, ff(12));
	if (status != noErr) DebugStr("\p atsuSetSize failed");
	
	// we can use the same style object for multiple runs.
	// this is more efficient than making copies.
	wdataP->styles[0] = wdataP->styles[2] = wdataP->styles[4] = tempS;

	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");
	
	// and let's add some different attributes to the 2nd style (vertical direction, italic, blue, size 48)
	status = atsuSetSize(tempS, ff(48));
	if (status != noErr) DebugStr("\p atsuSetSize failed");
	status = atsuSetQDItalic(tempS, true);
	if (status != noErr) DebugStr("\p atsuSetQDItalic failed");
	status = atsuSetVerticalCharacter(tempS, kATSUStronglyVertical);
	if (status != noErr) DebugStr("\p atsuSetVerticalCharacter failed");
	RGBColor blueColor = {0, 0, 0xFFFF};
	status = atsuSetColor(tempS, blueColor);
	if (status != noErr) DebugStr("\p atsuSetColor failed");
		
	wdataP->styles[1] = tempS;

	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");

	// and let's add some different attributes to the 3rd style (Times 60 underline)
	TryToSetFontTo(tempS, "\pTimes");
	status = atsuSetSize(tempS, ff(60));
	if (status != noErr) DebugStr("\p atsuSetSize failed");
	status = atsuSetQDUnderline(tempS, true);
	if (status != noErr) DebugStr("\p atsuSetQDUnderline failed");

	wdataP->styles[3] = tempS;

	// and we create the text layout
	ATSUTextLayout tempTL;
	status = ATSUCreateTextLayoutWithTextPtr(wdataP->theUnicodeText, 0, wdataP->uTextLength, wdataP->uTextLength, wdataP->numberOfRuns, wdataP->runLengths, wdataP->styles, &tempTL);
	if (status != noErr) DebugStr("\p ATSUCreateTextLayoutWithTextPtr failed");	
	wdataP->textLayout = tempTL;
	
	// let's rotate the line
	status = atsuSetLineRotation(tempTL, ff(0), ff(-90));
	if (status != noErr) DebugStr("\p atsuSetLineRotation failed");
	
	wdataP->textLayout = tempTL;
	
	// to be drawn at
	wdataP->xLocation = ff(30);
	wdataP->yLocation = ff(10);
	
	// to identify the window when we click on the button (see below)
	wdataP->sampleKind = 3;
	
	// let's add a button
	Rect buttonRect = {622, 540, 640, 610};
	ControlHandle button = NewControl(aWind, &buttonRect, "\pRotate!", true, 0, 0, 1, pushButProc, 1);
	
	return status;
	}

void RotateTheLine(WindowDataPtr wdataP)
	{
	GrafPtr currentPort;
	GetPort(&currentPort);
#if !TARGET_API_MAC_CARBON
	EraseRect(&currentPort->portRect);
#else
	Rect thePortRect;
	GetPortBounds(currentPort, &thePortRect);
	EraseRect(&thePortRect);
#endif
	
	// iterate angle and draw
	long i;
	for (i = 0; i >= -90; i -= 5)
		{
		OSStatus status = atsuSetLineRotation(wdataP->textLayout, ff(0), ff(i));
		if (status != noErr) DebugStr("\p atsuSetLineRotation failed");

		status = ATSUDrawText(wdataP->textLayout, 0, wdataP->uTextLength, wdataP->xLocation, wdataP->yLocation);
		if (status != noErr) DebugStr("\p ATSUDrawText failed");
		}

	// ask for an update...
#if !TARGET_API_MAC_CARBON
	EraseRect(&currentPort->portRect);
	InvalRect(&currentPort->portRect);
#else
	EraseRect(&thePortRect);
	InvalWindowRect(GetWindowFromPort(currentPort), &thePortRect);
#endif
	}
#pragma mark •Paragraphs
OSErr NewParagraphsWindow()
	{
	OSStatus status = noErr;
	WindowPtr aWind;
	Rect boundsRect = {50, 10, 470, 630};
	
	WindowDataPtr wdataP = DefaultWindowDataPtr();
	aWind = NewCWindow(NULL, &boundsRect, "\pParagraphs", true, noGrowDocProc, (WindowPtr)-1L, true, (long)wdataP);
	
	// let's use some very long text
	QuickAndDirtySetUnicodeTextFromASCII_C_Chars(kSomeVeryLongUnicodeText, &(wdataP->theUnicodeText), &(wdataP->uTextLength));

	// only 1 style thus only 1 run
	wdataP->numberOfRuns = 1;
	wdataP->runLengths = (UniCharCount *)NewPtr(wdataP->numberOfRuns * sizeof(UniCharCount));
	wdataP->runLengths[0] = wdataP->uTextLength;

	// and it's the default style
	wdataP->styles = (ATSUStyle *)NewPtr(wdataP->numberOfRuns * sizeof(ATSUStyle));
	ATSUStyle tempS;
	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");

	TryToSetFontTo(tempS, "\pChicago");

	// let's set the font size
	status = atsuSetSize(tempS, ff(14));
	if (status != noErr) DebugStr("\p atsuSetSize failed");

	wdataP->styles[0] = tempS;

	// and we create the text layout
	ATSUTextLayout tempTL;
	status = ATSUCreateTextLayoutWithTextPtr(wdataP->theUnicodeText, 0, wdataP->uTextLength, wdataP->uTextLength, wdataP->numberOfRuns, wdataP->runLengths, wdataP->styles, &tempTL);
	if (status != noErr) DebugStr("\p ATSUCreateTextLayoutWithTextPtr failed");
	wdataP->textLayout = tempTL;
	
	// to be drawn at
	wdataP->xLocation = ff(10);
	wdataP->yLocation = ff(20);
	
	// now, let's break the text in pieces
	BreakTheTextInLines(aWind, wdataP);
	
	// to identify the window when we click on the button (see below)
	wdataP->sampleKind = 4;
	
	// let's add 2 buttons
	Rect button1Rect = {392, 540, 410, 610};
	ControlHandle button1 = NewControl(aWind, &button1Rect, "\pBigger", true, 0, 0, 1, pushButProc, 1);
	Rect button2Rect = {392, 460, 410, 530};
	ControlHandle button2 = NewControl(aWind, &button2Rect, "\pSmaller", true, 0, 0, 1, pushButProc, 2);
	
	return status;
	}

void BreakTheTextInLines(WindowPtr aWind, WindowDataPtr wdataP)
	{
	OSStatus status;
#if !TARGET_API_MAC_CARBON
	ATSUTextMeasurement lineWidth = ff(aWind->portRect.right - aWind->portRect.left - 20);
#else
	Rect thePortRect;
	GetWindowPortBounds(aWind, &thePortRect);
	ATSUTextMeasurement lineWidth = ff(thePortRect.right - thePortRect.left - 20);
#endif
	UniCharArrayOffset offset = 0, endLineOffset;
	ItemCount nbLines = 0;
	ATSUTextMeasurement ascent, descent;
	
	wdataP->maxAscent = wdataP->maxDescent = 0;
	
	// measure and break each line, thus setting a soft line break that we'll grab back later
	while (offset < wdataP->uTextLength)
		{
		status = ATSUBreakLine(wdataP->textLayout, offset, lineWidth, true, &endLineOffset);
		if (status != noErr) DebugStr("\p ATSUBreakLine failed");
		
		// it could be that the line width is so narrow that even a single character won't fit.
		// in that case, ATSUBreakLine returns noErr but endLineOffset returns equal to offset.
		// if that's the case, let's break out...
		if (endLineOffset == offset) break;
		
		// let's get ascent & descent to calculate the line height later.
		status = ATSUMeasureText(wdataP->textLayout, offset, endLineOffset-offset, NULL, NULL, &ascent, &descent);
		if (status != noErr) DebugStr("\p ATSUMeasureText failed");

		if (ascent > wdataP->maxAscent) wdataP->maxAscent = ascent;
		if (descent > wdataP->maxDescent) wdataP->maxDescent = descent;
		
		offset = endLineOffset;
		nbLines++;
		}
	
	// let's grab back all the soft line breaks in the array we'll keep around
	UniCharArrayOffset *endOfLines = (UniCharArrayOffset *)NewPtr(nbLines * sizeof(UniCharArrayOffset));
	if (endOfLines == NULL) DebugStr("\p NewPtr failed");
	ItemCount softBreakCount;
	status = ATSUGetSoftLineBreaks(wdataP->textLayout, 0, wdataP->uTextLength, nbLines, endOfLines, &softBreakCount);

	// the number of softbreaks should always be one less than the number of lines
	// since ATSUBreakLine does not insert a softbreak at the end of the text.
	if ((status != noErr) || (softBreakCount != nbLines-1)) DebugStr("\p ATSUGetSoftLineBreaks failed");
	
	// so let's set the last entry of the array
	endOfLines[softBreakCount] = wdataP->uTextLength;

	wdataP->endOfLines = endOfLines;
	wdataP->numberOfLines = nbLines;
	wdataP->lineHeight = wdataP->maxAscent + wdataP->maxDescent + ff(2);
	}

void SmallerBiggerFont(WindowDataPtr wdataP, Fixed variation)
	{
	OSStatus status;
	GrafPtr currentPort;
	GetPort(&currentPort);
	
	// iterate over all the styles, making sure to not change them more than once.
	int i;
	for (i = 0; i < wdataP->numberOfRuns; i++)
		{
		ATSUStyle tempS = wdataP->styles[i];
		Boolean seenIt = false;
		
		// see if we've already done this style
		int j;
		for (j = i-1; j >= 0; j--)
			{
			if (wdataP->styles[j] == tempS)
				{
				seenIt = true;
				break;
				}
			}
		
		if (!seenIt)
			{
			// get the current font size
			Fixed thePointSize;
			status = atsuGetSize(tempS, &thePointSize);
			if (status != noErr) DebugStr("\p atsuGetSize failed");

			// add the variation
			thePointSize += variation;
			
			// let's have reasonable values:
			if (variation > 0)
				if (thePointSize > ff(24)) thePointSize = ff(24);
			if (variation < 0)
				if (thePointSize < ff(4)) thePointSize = ff(4);

			// set the new font size in the style
			status = atsuSetSize(tempS, thePointSize);
			if (status != noErr) DebugStr("\p atsuSetSize failed");
			}
		}
		
	// dispose of the current endOfLines array
	if (wdataP->endOfLines != NULL) DisposePtr((Ptr)wdataP->endOfLines);
	
	// and let's break the text in pieces again
#if !TARGET_API_MAC_CARBON
	BreakTheTextInLines(currentPort, wdataP);
#else
	BreakTheTextInLines(GetWindowFromPort(currentPort), wdataP);
#endif

	// ask for an update...
#if !TARGET_API_MAC_CARBON
	EraseRect(&currentPort->portRect);
	InvalRect(&currentPort->portRect);
#else
	Rect thePortRect;
	GetPortBounds(currentPort, &thePortRect);
	EraseRect(&thePortRect);
	InvalWindowRect(GetWindowFromPort(currentPort), &thePortRect);
#endif
	}
#pragma mark •Highlighting, Carets & Cursor Movements
OSErr NewHighlightingCaretsCursorMovementsWindow()
	{
	OSStatus status = noErr;
	WindowPtr aWind;
	Rect boundsRect = {50, 10, 470, 630};
	
	WindowDataPtr wdataP = DefaultWindowDataPtr();
	aWind = NewCWindow(NULL, &boundsRect, "\pHilighting, Carets & Cursor movements", true, noGrowDocProc, (WindowPtr)-1L, true, (long)wdataP);
	
	// let's use some very long text
	QuickAndDirtySetUnicodeTextFromASCII_C_Chars(kSomeMixedUnicodeText, &(wdataP->theUnicodeText), &(wdataP->uTextLength));

	// only 3 styles thus only 5 runs
	wdataP->numberOfRuns = 5;
	wdataP->runLengths = (UniCharCount *)NewPtr(wdataP->numberOfRuns * sizeof(UniCharCount));
	wdataP->runLengths[0] = 243;
	wdataP->runLengths[1] = 36;
	wdataP->runLengths[2] = 143;
	wdataP->runLengths[3] = 43;
	wdataP->runLengths[4] = wdataP->uTextLength - 243 - 36 - 143 - 43;

	// and it's the default style
	wdataP->styles = (ATSUStyle *)NewPtr(wdataP->numberOfRuns * sizeof(ATSUStyle));
	ATSUStyle tempS;
	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");

	TryToSetFontTo(tempS, "\pTimes");

	// let's set the font size
	status = atsuSetSize(tempS, ff(16));
	if (status != noErr) DebugStr("\p atsuSetSize failed");

	// we use the same style object for multiple runs.
	// this is more efficient than copying the style for each run.
	wdataP->styles[0] = wdataP->styles[2] = wdataP->styles[4] = tempS;

	// second style
	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");

	TryToSetFontTo(tempS, "\pHelvetica");

	// let's set different style attributes
	status = atsuSetSize(tempS, ff(20));
	if (status != noErr) DebugStr("\p atsuSetSize failed");
	status = atsuSetQDUnderline(tempS, true);
	if (status != noErr) DebugStr("\p atsuSetQDUnderline failed");

	wdataP->styles[1] = tempS;

	// third style
	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");

	TryToSetFontTo(tempS, "\pCourier");

	// let's set different style attributes
	status = atsuSetSize(tempS, ff(20));
	if (status != noErr) DebugStr("\p atsuSetSize failed");
	status = atsuSetQDItalic(tempS, true);
	if (status != noErr) DebugStr("\p atsuSetQDItalic failed");
	status = atsuSetQDUnderline(tempS, true);
	if (status != noErr) DebugStr("\p atsuSetQDUnderline failed");

	wdataP->styles[3] = tempS;

	// and we create the text layout
	ATSUTextLayout tempTL;
	status = ATSUCreateTextLayoutWithTextPtr(wdataP->theUnicodeText, 0, wdataP->uTextLength, wdataP->uTextLength, wdataP->numberOfRuns, wdataP->runLengths, wdataP->styles, &tempTL);
	if (status != noErr) DebugStr("\p ATSUCreateTextLayoutWithTextPtr failed");
	wdataP->textLayout = tempTL;
	
	// to be drawn at
	wdataP->xLocation = ff(10);
	wdataP->yLocation = ff(20);
	
	// now, let's break the text in pieces
	BreakTheTextInLines(aWind, wdataP);
	
	// to identify the window when we click on the button (see below)
	wdataP->sampleKind = 5;
	
	// let's add 6 buttons
	Rect button1Rect = {392, 490, 410, 610};
	ControlHandle button1 = NewControl(aWind, &button1Rect, "\pHilight next 30", true, 0, 0, 1, pushButProc, 1);
	Rect button2Rect = {392, 340, 410, 480};
	ControlHandle button2 = NewControl(aWind, &button2Rect, "\pMove to next word", true, 0, 0, 1, pushButProc, 2);
	Rect button3Rect = {392, 160, 410, 330};
	ControlHandle button3 = NewControl(aWind, &button3Rect, "\pMove to previous word", true, 0, 0, 1, pushButProc, 3);
	Rect button4Rect = {392, 90, 410, 150};
	ControlHandle button4 = NewControl(aWind, &button4Rect, "\pHome", true, 0, 0, 1, pushButProc, 4);

	Rect button5Rect = {392, 50, 410, 80};
	ControlHandle button5 = NewControl(aWind, &button5Rect, "\p++", true, 0, 0, 1, pushButProc, 5);
	Rect button6Rect = {392, 10, 410, 40};
	ControlHandle button6 = NewControl(aWind, &button6Rect, "\p--", true, 0, 0, 1, pushButProc, 6);
	
	// some default values for our private data...
	wdataP->privateData = (void *)NewPtr(sizeof(Sample5_PrivateData));
	((Sample5_PrivateData *)wdataP->privateData)->withHilight = false;
	((Sample5_PrivateData *)wdataP->privateData)->caret = 0;
	((Sample5_PrivateData *)wdataP->privateData)->length = 30;
	((Sample5_PrivateData *)wdataP->privateData)->numberOfSelectedLines = 0;
	((Sample5_PrivateData *)wdataP->privateData)->selBlocks = NULL;
	
	return status;
	}

void DisposeSample5Window(WindowDataPtr wdataP)
	{
	Sample5_PrivateData *priv = (Sample5_PrivateData *)wdataP->privateData;
	if (priv->selBlocks != NULL) DisposePtr((Ptr)priv->selBlocks);
	}

void SetSelectedBlocks(WindowDataPtr wdataP)
	{
	Sample5_PrivateData *priv = (Sample5_PrivateData *)wdataP->privateData;
	ItemCount i, firstLine = -1, lastLine = -1;
	
	// find the first line where the selection starts
	for (i = 0; (i < wdataP->numberOfLines) && (firstLine == -1); i++)
		if (priv->caret < wdataP->endOfLines[i]) firstLine = i;
	if (firstLine == -1) firstLine = wdataP->numberOfLines - 1;
		
	// find the last line where the selection ends
	for (i = firstLine; (i < wdataP->numberOfLines) && (lastLine == -1); i++)
		if ((priv->caret+priv->length) < wdataP->endOfLines[i]) lastLine = i;
	if (lastLine == -1) lastLine = wdataP->numberOfLines - 1;
	
	// let's allocate (deallocating first if it's previously been allocated)...
	priv->numberOfSelectedLines = lastLine - firstLine + 1;
	if (priv->selBlocks != NULL) DisposePtr((Ptr)priv->selBlocks);
	priv->selBlocks = (SelectedBlock *)NewPtr(priv->numberOfSelectedLines * sizeof(SelectedBlock));
	
	// and fill the values
	UniCharArrayOffset pos = priv->caret;
	UniCharCount length, lengthToSelect = priv->length;
	for (i = 0; i < priv->numberOfSelectedLines; i++)
		{
		SelectedBlock *sb = &(priv->selBlocks[i]);
		sb->selStart = pos;
		sb->lineNumber = firstLine + i;
		length = wdataP->endOfLines[firstLine + i] - pos;
		if (length >= lengthToSelect) length = lengthToSelect;
		sb->selLength = length;
		lengthToSelect -= length;
		pos = wdataP->endOfLines[sb->lineNumber];
		sb->xLineSel = wdataP->xLocation;
		sb->yLineSel = wdataP->yLocation + (sb->lineNumber) * wdataP->lineHeight;
		}
	}

void HilightAndOrMove(WindowDataPtr wdataP, long what)
	{
	OSStatus status = noErr;
	Sample5_PrivateData *priv = (Sample5_PrivateData *)wdataP->privateData;
	switch (what)
		{
		case 1:
			// first let's unhilight the current hilight if there's one
			UnhilightCurrentSelection(wdataP);

			// let's find out on how many lines the selection extends
			if ((wdataP->numberOfLines == 1) || (wdataP->endOfLines == NULL))
				{
				// this one is simple...
				priv->numberOfSelectedLines = 1;
				priv->selBlocks = (SelectedBlock *)NewPtr(priv->numberOfSelectedLines * sizeof(SelectedBlock));
				priv->selBlocks[0].selLength = priv->length;
				priv->selBlocks[0].selStart = priv->caret;
				priv->selBlocks[0].xLineSel = wdataP->xLocation;
				priv->selBlocks[0].yLineSel = wdataP->yLocation;
				}
			else
				{
				ItemCount i, firstLine = -1, lastLine = -1;
				
				// find the first line where the selection starts
				for (i = 0; (i < wdataP->numberOfLines) && (firstLine == -1); i++)
					if (priv->caret < wdataP->endOfLines[i]) firstLine = i;
					
				// find the last line where the selection ends
				for (i = firstLine; (i < wdataP->numberOfLines) && (lastLine == -1); i++)
					if ((priv->caret+priv->length) < wdataP->endOfLines[i]) lastLine = i;
				
				// let's allocate (deallocating first if it's previously been allocated)...
				priv->numberOfSelectedLines = lastLine - firstLine + 1;
				if (priv->selBlocks != NULL) DisposePtr((Ptr)priv->selBlocks);
				priv->selBlocks = (SelectedBlock *)NewPtr(priv->numberOfSelectedLines * sizeof(SelectedBlock));
				
				// and fill the values
				UniCharArrayOffset pos = priv->caret;
				UniCharCount length, lengthToSelect = priv->length;
				for (i = 0; i < priv->numberOfSelectedLines; i++)
					{
					SelectedBlock *sb = &(priv->selBlocks[i]);
					sb->selStart = pos;
					length = wdataP->endOfLines[firstLine + i] - pos;
					if (length >= lengthToSelect) length = lengthToSelect;
					sb->selLength = length;
					lengthToSelect -= length;
					pos = wdataP->endOfLines[firstLine + i];
					sb->xLineSel = wdataP->xLocation;
					sb->yLineSel = wdataP->yLocation + (firstLine + i) * wdataP->lineHeight;
					}
				}

			// let's hilight the selection we just computed
			HilightCurrentSelection(wdataP);
			priv->withHilight = true;

			// move the caret by priv->length for next time or go back to home if end reached.
			priv->caret += priv->length;
			if ((priv->caret+priv->length) >= wdataP->uTextLength) priv->caret = 0;
			
			break;
		case 2:
			{
			// first let's unhilight the current hilight if there's one
			UnhilightCurrentSelection(wdataP);

			// first let's move the caret back priv->length chars if needed and then search for the first word forward
			if (priv->withHilight) 
				{
				if (priv->caret > priv->length)
					priv->caret -= priv->length;
				else
					priv->caret = 0;
				}
			UniCharArrayOffset pos;
			status = ATSUNextCursorPosition(wdataP->textLayout, priv->caret, kATSUByWord, &pos);
			if (status != noErr)
				{
				DebugStr("\p ATSUNextCursorPosition failed");
				priv->caret = 0;
				}
			else priv->caret = ((pos+priv->length) >= wdataP->uTextLength)?0:pos;

			priv->withHilight = false;
			HilightAndOrMove(wdataP, 1);
			}
			break;
		case 3:
			{
			// first let's unhilight the current hilight if there's one
			UnhilightCurrentSelection(wdataP);

			// first let's move the caret back priv->length chars if needed and then search for the first word backward
			if (priv->withHilight) 
				{
				if (priv->caret > priv->length)
					priv->caret -= priv->length;
				else
					priv->caret = 0;
				}
			UniCharArrayOffset pos;
			status = ATSUPreviousCursorPosition(wdataP->textLayout, priv->caret, kATSUByWord, &pos);
			if (status != noErr)
				{
				DebugStr("\p ATSUNextCursorPosition failed");
				priv->caret = 0;
				}
			else priv->caret = pos;

			priv->withHilight = false;
			HilightAndOrMove(wdataP, 1);
			}
			break;
		case 4:
			// first let's unhilight the current hilight if there's one
			UnhilightCurrentSelection(wdataP);

			// and move the caret home.
			priv->caret = 0;

			priv->withHilight = false;
			break;
		}
	}

// To correctly hilight or unhilight the current selection when the window is
// activated, deactivated and/or updated, we have to complete the default
// behavior.

// Since a double Hilight means no hilight, we have to take extra care with the
// update region when activating/updating the window.

void ActivateSample5Window(WindowPtr theWind, WindowDataPtr wdataP, Boolean active)
	{
	// let's unhilight or rehilight the current hilight if there's one
	Sample5_PrivateData *priv = (Sample5_PrivateData *)wdataP->privateData;
	if (priv->withHilight)
		{
		GrafPtr savePort;
		GetPort(&savePort);
#if !TARGET_API_MAC_CARBON
		SetPort(theWind);
#else
		SetPortWindowPort(theWind);
#endif
		
		// first save the current clip
		RgnHandle saveClipRgn = NewRgn();
		GetClip(saveClipRgn);
		
		// copy the update region to a new region and move it in local coordinate space
		Point thePoint = {0, 0};
		LocalToGlobal(&thePoint);
		RgnHandle updateRgn = NewRgn();
#if !TARGET_API_MAC_CARBON
		CopyRgn(((WindowPeek)theWind)->updateRgn, updateRgn);
#else
		GetWindowRegion(theWind, kWindowUpdateRgn, updateRgn);
#endif
		OffsetRgn(updateRgn, -thePoint.h, -thePoint.v);
		
		// since the update mechanism will take care of hilighting within the update region
		// we want to take care here of the visible region minus the update region 
		RgnHandle clipRgn = NewRgn();
#if !TARGET_API_MAC_CARBON
		DiffRgn(theWind->visRgn, updateRgn, clipRgn);
#else
		RgnHandle visibleRgn = NewRgn();
		GetPortVisibleRegion(GetWindowPort(theWind), visibleRgn);
		DiffRgn(visibleRgn, updateRgn, clipRgn);
		DisposeRgn(visibleRgn);
#endif
		SetClip(clipRgn);
		
		if (!active)
			UnhilightCurrentSelection(wdataP);
		else
			HilightCurrentSelection(wdataP);
		
		SetClip(saveClipRgn);
		DisposeRgn(clipRgn);
		SetPort(savePort);
		}
	}

void UpdateSample5Window(WindowPtr theWind, WindowDataPtr wdataP)
	{
	// let's hilight the current hilight if there's one (and if the window is active)
	Sample5_PrivateData *priv = (Sample5_PrivateData *)wdataP->privateData;
#if !TARGET_API_MAC_CARBON
	if ((priv->withHilight) && ((WindowPeek)theWind)->hilited)
#else
	if ((priv->withHilight) && IsWindowHilited(theWind))
#endif
		{
		// we only hilight in the visRgn (which was the update region before BeginUpdate)
		// because the activate mechanism took care of the rest.
		RgnHandle saveClipRgn = NewRgn();
		GetClip(saveClipRgn);
#if !TARGET_API_MAC_CARBON
		SetClip(theWind->visRgn);
#else
		RgnHandle visibleRgn = NewRgn();
		GetPortVisibleRegion(GetWindowPort(theWind), visibleRgn);
		SetClip(visibleRgn);
#endif
		HilightCurrentSelection(wdataP);
		SetClip(saveClipRgn);
#if !TARGET_API_MAC_CARBON
#else
		DisposeRgn(visibleRgn);
#endif
		}
	}

void HilightCurrentSelection(WindowDataPtr wdataP)
	{
	OSStatus status = noErr;
	Sample5_PrivateData *priv = (Sample5_PrivateData *)wdataP->privateData;
	ItemCount i;
	for (i = 0; i < priv->numberOfSelectedLines; i++)
		{
		SelectedBlock *sb = &(priv->selBlocks[i]);
		status = ATSUHighlightText(wdataP->textLayout, sb->xLineSel, sb->yLineSel, sb->selStart, sb->selLength);
		if (status != noErr) DebugStr("\p ATSUHighlightText failed");
		}
	}

void UnhilightCurrentSelection(WindowDataPtr wdataP)
	{
	Sample5_PrivateData *priv = (Sample5_PrivateData *)wdataP->privateData;
	if (!priv->withHilight) return;

	OSStatus status = noErr;
	ItemCount i;
	for (i = 0; i < priv->numberOfSelectedLines; i++)
		{
		SelectedBlock *sb = &(priv->selBlocks[i]);
		status = ATSUUnhighlightText(wdataP->textLayout, sb->xLineSel, sb->yLineSel, sb->selStart, sb->selLength);
		if (status != noErr) DebugStr("\p ATSUUnhighlightText failed");
		}
	}
#pragma mark •Hit Testing

#define max(x, y) ((y) > (x) ? (y) : (x))
#define min(x, y) ((y) < (x) ? (y) : (x))

OSErr NewHitTestingWindow()
	{
	OSStatus status = noErr;
	WindowPtr aWind;
	Rect boundsRect = {50, 10, 470, 630};
	
	WindowDataPtr wdataP = DefaultWindowDataPtr();
	aWind = NewCWindow(NULL, &boundsRect, "\pHit Testing", true, noGrowDocProc, (WindowPtr)-1L, true, (long)wdataP);
	
	// let's use some very long text
	QuickAndDirtySetUnicodeTextFromASCII_C_Chars(kSomeOtherMixedUnicodeText, &(wdataP->theUnicodeText), &(wdataP->uTextLength));

	// only 3 styles thus only 5 runs
	wdataP->numberOfRuns = 5;
	wdataP->runLengths = (UniCharCount *)NewPtr(wdataP->numberOfRuns * sizeof(UniCharCount));
	wdataP->runLengths[0] = 243;
	wdataP->runLengths[1] = 36;
	wdataP->runLengths[2] = 143;
	wdataP->runLengths[3] = 43;
	wdataP->runLengths[4] = wdataP->uTextLength - 243 - 36 - 143 - 43;

	// and it's the default style
	wdataP->styles = (ATSUStyle *)NewPtr(wdataP->numberOfRuns * sizeof(ATSUStyle));
	ATSUStyle tempS;
	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");

	TryToSetFontTo(tempS, "\pTimes");

	// let's set the font size
	status = atsuSetSize(tempS, ff(16));
	if (status != noErr) DebugStr("\p atsuSetSize failed");
	
	// we use the same style object for multiple runs.
	// this is more efficient than copying the style for each run.
	wdataP->styles[0] = wdataP->styles[2] = wdataP->styles[4] = tempS;

	// second style
	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");

	TryToSetFontTo(tempS, "\pHelvetica");

	// let's set different style attributes
	status = atsuSetSize(tempS, ff(20));
	if (status != noErr) DebugStr("\p atsuSetSize failed");
	status = atsuSetQDUnderline(tempS, true);
	if (status != noErr) DebugStr("\p atsuSetQDUnderline failed");

	wdataP->styles[1] = tempS;

	// third style
	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");

	TryToSetFontTo(tempS, "\pCourier");

	// let's set different style attributes
	status = atsuSetSize(tempS, ff(20));
	if (status != noErr) DebugStr("\p atsuSetSize failed");
	status = atsuSetQDItalic(tempS, true);
	if (status != noErr) DebugStr("\p atsuSetQDItalic failed");
	status = atsuSetQDUnderline(tempS, true);
	if (status != noErr) DebugStr("\p atsuSetQDUnderline failed");

	wdataP->styles[3] = tempS;

	// and we create the text layout
	ATSUTextLayout tempTL;
	status = ATSUCreateTextLayoutWithTextPtr(wdataP->theUnicodeText, 0, wdataP->uTextLength, wdataP->uTextLength, wdataP->numberOfRuns, wdataP->runLengths, wdataP->styles, &tempTL);
	if (status != noErr) DebugStr("\p ATSUCreateTextLayoutWithTextPtr failed");
	wdataP->textLayout = tempTL;
	
	// to be drawn at
	wdataP->xLocation = ff(10);
	wdataP->yLocation = ff(20);
	
	// now, let's break the text in pieces
	BreakTheTextInLines(aWind, wdataP);
	
	// we want the highlight to fill the entire line, so we force ATSUI to use ours.
	// compare this to the highlighting you get in sample 5.
	status = atsuSetLayoutLineSpan(wdataP->textLayout, wdataP->maxAscent, wdataP->lineHeight - wdataP->maxAscent);
	
	// to identify the window when we click on the button (see below)
	wdataP->sampleKind = 6;
	
	// some default values for our private data...
	wdataP->privateData = (void *)NewPtr(sizeof(Sample6_PrivateData));
	((Sample6_PrivateData *)wdataP->privateData)->withHilight = false;
	((Sample6_PrivateData *)wdataP->privateData)->caret = 0;
	((Sample6_PrivateData *)wdataP->privateData)->length = 0;
	((Sample6_PrivateData *)wdataP->privateData)->numberOfSelectedLines = 0;
	((Sample6_PrivateData *)wdataP->privateData)->selBlocks = NULL;
	((Sample6_PrivateData *)wdataP->privateData)->lastClickTime = 0;
	((Sample6_PrivateData *)wdataP->privateData)->lastClickPoint.h = -50;
	((Sample6_PrivateData *)wdataP->privateData)->lastClickPoint.v = -50;
	
	return status;
	}

UniCharArrayOffset WhereInTextIsThisPoint(WindowDataPtr wdataP, Point thePoint, Boolean *leading)
	{
	OSStatus status = noErr;
	UniCharArrayOffset result;

	// let's test for the out of bounds first
	if (ff(thePoint.v) < (wdataP->yLocation - wdataP->maxAscent))
		{
		result = 0;
		*leading = true;	// leading is always true if we were above our text.
		}
	else if (ff(thePoint.v) > (wdataP->yLocation + ((wdataP->numberOfLines - 1) * wdataP->lineHeight) + wdataP->maxDescent))
		{
		result = wdataP->uTextLength;
		*leading = false;	// leading is always false if we were beyond our text.
		}
	else
		{
		// determine first which line
		ItemCount theLine = (ff(thePoint.v) - (wdataP->yLocation - wdataP->maxAscent)) / wdataP->lineHeight;
		
		// which gives us the base line start
		ATSUTextMeasurement xl = wdataP->xLocation;
		ATSUTextMeasurement yl = wdataP->yLocation + theLine * wdataP->lineHeight;
		
		// and we call the right stuff
		UniCharArrayOffset there, notThere;
		// we seed the offset with the first Character Offset of that line
		if (theLine == 0)
			there = 0;
		else
			there = wdataP->endOfLines[theLine-1];
		xl = ff(thePoint.h) - xl;
		yl = ff(thePoint.v) - yl;
		status = ATSUPositionToOffset(wdataP->textLayout, xl, yl, &there, leading, &notThere);
		if (status != noErr)
			{
			DebugStr("\p ATSUPositionToOffset failed");
			result = 0;
			}
		else result = there;
		}
	
	// sanity check
	if (result > (wdataP->uTextLength - 1)) result = wdataP->uTextLength;

	return result;
	}

void SelectWord(WindowDataPtr wdataP, UniCharArrayOffset thePos, Boolean leading, UniCharArrayOffset *startSel, UniCharArrayOffset *endSel)
	{
	OSStatus status = noErr;
	Sample6_PrivateData *priv = (Sample6_PrivateData *)wdataP->privateData;

	// let's get the end and the start of the word
	// the input position needs to be adjusted so that we don't grab the next word by mistake
	// note that leading *must* be true if thePos is the beginning of the text and false if it's the end
	status = ATSUNextCursorPosition(wdataP->textLayout, leading ? thePos : thePos - 1, kATSUByWord, endSel);
	if (status != noErr) DebugStr("\p ATSUNextCursorPosition failed");
	status = ATSUPreviousCursorPosition(wdataP->textLayout, leading ? thePos + 1 : thePos, kATSUByWord, startSel);
	if (status != noErr) DebugStr("\p ATSUPreviousCursorPosition failed");

	// and we set all the proper values.
	priv->caret = *startSel;
	priv->length = *endSel - *startSel;
	}

Boolean GotDoubleClick(WindowDataPtr wdataP, EventRecord *theEvent)
	{
	// no comment
	Sample6_PrivateData *priv = (Sample6_PrivateData *)wdataP->privateData;
	long deltaH = theEvent->where.h - priv->lastClickPoint.h;
	long deltaV = theEvent->where.v - priv->lastClickPoint.v;
	if (deltaH < 0) deltaH = -deltaH;
	if (deltaV < 0) deltaV = -deltaV;
	if (	(deltaH < 5) &&
			(deltaV < 5) &&
			((theEvent->when - priv->lastClickTime) < GetDblTime())		)
		return true;
	return false;
	}

void ClickInSample6Window(WindowDataPtr wdataP, EventRecord *theEvent)
	{
	OSStatus status = noErr;
	Sample6_PrivateData *priv = (Sample6_PrivateData *)wdataP->privateData;
	Boolean leading, withShift = ((theEvent->modifiers & shiftKey) != 0), trackWord = false;
	Point thePoint = theEvent->where;
	GlobalToLocal(&thePoint);
	UniCharArrayOffset newPos, startSel, endSel, anchor, anchor1;
	
	newPos = WhereInTextIsThisPoint(wdataP, thePoint, &leading);
	if (!withShift)
		{
		// test for double-click
		if (GotDoubleClick(wdataP, theEvent))
			{
			SelectWord(wdataP, newPos, leading, &startSel, &endSel);
			anchor = startSel; anchor1 = endSel;	// we'll need both ends for tracking by word
			trackWord = true;
			}
		else
			{
			// if simple click, then disable current selection if any first
			UnhilightCurrentSelection(wdataP);
			priv->withHilight = false;
			priv->length = 0;
			priv->caret = newPos;
			anchor = startSel = endSel = priv->caret;
			
			priv->lastClickTime = theEvent->when;
			priv->lastClickPoint = theEvent->where;
			}
		}
	else
		{
		// if shift click, then extends the current selection if any
		startSel = priv->caret;
		endSel = startSel + priv->length;
		if (newPos < startSel)
			{
			startSel = newPos;
			anchor = endSel;
			}
		else
			{
			endSel = newPos;
			anchor = startSel;
			}
		priv->caret = startSel;
		priv->length = endSel - startSel;
		}

	if (priv->length > 0)
		{
		ModifySelection(wdataP, startSel, endSel);
		priv->withHilight = true;
		}
	
	// as long as the mouse button is down, dragging...
	// !!! if we selected a word, we should extend by word, too.
	Point lastPoint = thePoint;
	UniCharArrayOffset oldPos = newPos;
	while (StillDown())
		{
		GetMouse(&thePoint);
		if ((*((long *)&thePoint)) == (*((long *)&lastPoint))) continue;
		lastPoint = thePoint;
		newPos = WhereInTextIsThisPoint(wdataP, thePoint, &leading);
		if (newPos == oldPos) continue;
		oldPos = newPos;

		if (!trackWord)
			{
			if (newPos < anchor)
				{
				startSel = newPos;
				endSel = anchor;
				}
			else
				{
				endSel = newPos;
				startSel = anchor;
				}
			}
		else
			{
			if (newPos < anchor)
				{
				endSel = anchor1;
				status = ATSUPreviousCursorPosition(wdataP->textLayout, leading ? newPos + 1 : newPos, kATSUByWord, &startSel);
				if (status != noErr) DebugStr("\p ATSUPreviousCursorPosition failed");
				}
			else
				{
				startSel = anchor;
				status = ATSUNextCursorPosition(wdataP->textLayout, leading ? newPos : newPos - 1, kATSUByWord, &endSel);
				if (status != noErr) DebugStr("\p ATSUNextCursorPosition failed");
				}
			}

		if (startSel != priv->caret || endSel != priv->caret + priv->length)
			ModifySelection(wdataP, startSel, endSel);
		priv->withHilight = true;
		}
	}

// if we just unhighlight the old and then highlight the new, we will flash.
void ModifySelection(WindowDataPtr wdataP, UniCharArrayOffset newStart, UniCharArrayOffset newEnd)
	{
	Sample6_PrivateData *priv = (Sample6_PrivateData *)wdataP->privateData;
	
	OSStatus status;
	
	priv->caret = newStart;
	priv->length = newEnd - newStart;
	
	if (priv->withHilight)
		{
		// exercise for the reader: combine the update of the selected blocks data structure with the highlight updates.
		ItemCount i;
		
		// update the old highlights as necessary. 
		for (i = 0; i < priv->numberOfSelectedLines; i++)
			{
			SelectedBlock *sb = &(priv->selBlocks[i]);
			UniCharArrayOffset	selEnd = sb->selStart + sb->selLength;
			UniCharArrayOffset	thisLineStart = sb->lineNumber ? wdataP->endOfLines[sb->lineNumber - 1] : 0;
			UniCharArrayOffset	thisLineEnd = wdataP->endOfLines[sb->lineNumber];
			UniCharArrayOffset	tempStart = max(thisLineStart, min(newStart, thisLineEnd));
			UniCharArrayOffset	tempEnd = min(thisLineEnd, max(newEnd, thisLineStart));
			
			status = noErr;
			if (tempStart > sb->selStart)	// unlighlight on left
				status = ATSUUnhighlightText(wdataP->textLayout, sb->xLineSel, sb->yLineSel, sb->selStart, tempStart - sb->selStart);
			else if (tempEnd < selEnd)	// unhighlight on right
				status = ATSUUnhighlightText(wdataP->textLayout, sb->xLineSel, sb->yLineSel, tempEnd, selEnd - tempEnd);

			if (status != noErr) DebugStr("\p ATSUUnhighlightText failed");
			
			status = noErr;
			if (tempStart < sb->selStart)	// highlight on left
				status = ATSUHighlightText(wdataP->textLayout, sb->xLineSel, sb->yLineSel, tempStart, sb->selStart - tempStart);
			else if (tempEnd > selEnd)	// highlight on right
				status = ATSUHighlightText(wdataP->textLayout, sb->xLineSel, sb->yLineSel, selEnd, tempEnd - selEnd);

			if (status != noErr) DebugStr("\p ATSUHighlightText failed");
			}
		
		// take care of any new lines in the highlight
		ItemCount oldFirstLine = priv->selBlocks[0].lineNumber;
		ItemCount oldLastLine = priv->selBlocks[priv->numberOfSelectedLines - 1].lineNumber;
		ItemCount newFirstLine = -1, newLastLine = -1;
		
		// find the first line where the new selection starts
		for (i = 0; (i < wdataP->numberOfLines) && (newFirstLine == -1); i++)
			if (newStart < wdataP->endOfLines[i]) newFirstLine = i;
		if (newFirstLine == -1) newFirstLine = wdataP->numberOfLines - 1;
		
		// find the last line where the new selection ends
		for (i = newFirstLine; (i < wdataP->numberOfLines) && (newLastLine == -1); i++)
			if (newEnd <= wdataP->endOfLines[i]) newLastLine = i;
		if (newLastLine == -1) newLastLine = wdataP->numberOfLines - 1;
		
		for (i = newFirstLine; i <= newLastLine; i++)
			{
			if (i < oldFirstLine || i > oldLastLine)
				{
				UniCharArrayOffset thisLineStart = max(i ? wdataP->endOfLines[i - 1] : 0, newStart);
				UniCharArrayOffset thisLineEnd = min(wdataP->endOfLines[i], newEnd);
				status = ATSUHighlightText(wdataP->textLayout, wdataP->xLocation, wdataP->yLocation + i * wdataP->lineHeight, thisLineStart, thisLineEnd - thisLineStart);
				if (status != noErr) DebugStr("\p ATSUHighlightText failed");
				}
			}
			
		SetSelectedBlocks(wdataP);
		}
	else
		{
		SetSelectedBlocks(wdataP);
		HilightCurrentSelection(wdataP);
		}
	}
#pragma mark •Using the Clipboard
WindowPtr gClipboardWindow = NULL;

Rect r1 = {  9, 8, 102, 612};
Rect r2 = {112, 8, 205, 612};
Rect r3 = {215, 8, 308, 612};
Rect r4 = {318, 8, 411, 612};

OSErr NewClipboardUsingWindow()
	{
	OSStatus status = noErr;
	WindowPtr aWind;
	Rect boundsRect = {50, 10, 470, 630};
	
	WindowDataPtr wdataP = DefaultWindowDataPtr();
	aWind = NewCWindow(NULL, &boundsRect, "\pClipboard Testing", true, noGrowDocProc, (WindowPtr)-1L, true, (long)wdataP);
	
	// let's use some very long text
	QuickAndDirtySetUnicodeTextFromASCII_C_Chars(kSomeMixedAgainUnicodeText, &(wdataP->theUnicodeText), &(wdataP->uTextLength));

	// only 3 styles thus only 5 runs
	wdataP->numberOfRuns = 5;
	wdataP->runLengths = (UniCharCount *)NewPtr(wdataP->numberOfRuns * sizeof(UniCharCount));
	wdataP->runLengths[0] = 243;
	wdataP->runLengths[1] = 36;
	wdataP->runLengths[2] = 143;
	wdataP->runLengths[3] = 43;
	wdataP->runLengths[4] = wdataP->uTextLength - 243 - 36 - 143 - 43;

	// and it's the default style
	wdataP->styles = (ATSUStyle *)NewPtr(wdataP->numberOfRuns * sizeof(ATSUStyle));
	ATSUStyle tempS;
	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");

	TryToSetFontTo(tempS, "\pTimes");

	// let's set the font size
	status = atsuSetSize(tempS, ff(16));
	if (status != noErr) DebugStr("\p atsuSetSize failed");

	// we use the same style object for multiple runs.
	// this is more efficient than copying the style for each run.
	wdataP->styles[0] = wdataP->styles[2] = wdataP->styles[4] = tempS;

	// second style
	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");

	TryToSetFontTo(tempS, "\pHelvetica");

	// let's set different style attributes
	status = atsuSetSize(tempS, ff(20));
	if (status != noErr) DebugStr("\p atsuSetSize failed");
	status = atsuSetQDUnderline(tempS, true);
	if (status != noErr) DebugStr("\p atsuSetQDUnderline failed");

	wdataP->styles[1] = tempS;

	// third style
	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");

	TryToSetFontTo(tempS, "\pCourier");

	// let's set different style attributes
	status = atsuSetSize(tempS, ff(20));
	if (status != noErr) DebugStr("\p atsuSetSize failed");
	status = atsuSetQDItalic(tempS, true);
	if (status != noErr) DebugStr("\p atsuSetQDItalic failed");
	status = atsuSetQDUnderline(tempS, true);
	if (status != noErr) DebugStr("\p atsuSetQDUnderline failed");

	wdataP->styles[3] = tempS;

	// and we create the text layout
	ATSUTextLayout tempTL;
	status = ATSUCreateTextLayoutWithTextPtr(wdataP->theUnicodeText, 0, wdataP->uTextLength, wdataP->uTextLength, wdataP->numberOfRuns, wdataP->runLengths, wdataP->styles, &tempTL);
	if (status != noErr) DebugStr("\p ATSUCreateTextLayoutWithTextPtr failed");
	wdataP->textLayout = tempTL;
	
	// to be drawn at
	wdataP->xLocation = ff(10);
	wdataP->yLocation = ff(20);
	
	// now, let's break the text in pieces
	BreakTheTextInLines(aWind, wdataP);
	
	// to identify the window when we click on the button (see below)
	wdataP->sampleKind = 7;
	
	// some default values for our private data...
	wdataP->privateData = (void *)NewPtr(sizeof(Sample6_PrivateData));
	((Sample6_PrivateData *)wdataP->privateData)->withHilight = false;
	((Sample6_PrivateData *)wdataP->privateData)->caret = 0;
	((Sample6_PrivateData *)wdataP->privateData)->length = 0;
	((Sample6_PrivateData *)wdataP->privateData)->numberOfSelectedLines = 0;
	((Sample6_PrivateData *)wdataP->privateData)->selBlocks = NULL;
	((Sample6_PrivateData *)wdataP->privateData)->lastClickTime = 0;
	((Sample6_PrivateData *)wdataP->privateData)->lastClickPoint.h = -50;
	((Sample6_PrivateData *)wdataP->privateData)->lastClickPoint.v = -50;
	
	// let's add 2 buttons
	Rect button1Rect = {392, 490, 410, 610};
	ControlHandle button1 = NewControl(aWind, &button1Rect, "\pShow Clipboard", true, 0, 0, 1, pushButProc, 1);
	Rect button2Rect = {392, 430, 410, 480};
	ControlHandle button2 = NewControl(aWind, &button2Rect, "\pCopy", true, 0, 0, 1, pushButProc, 2);
	
	return status;
	}

OSErr CreateClipboardWindow()
	{
	OSStatus status = noErr;
	Rect boundsRect = {150, 110, 570, 730};
	
	WindowDataPtr wdataP = DefaultWindowDataPtr();
	gClipboardWindow = NewCWindow(NULL, &boundsRect, "\pClipboard", false, noGrowDocProc, (WindowPtr)-1L, true, (long)wdataP);
	
	// let's use some default text
	UniCharArrayPtr unicodeText;
	UniCharCount unicodeTextLength;
	QuickAndDirtySetUnicodeTextFromASCII_C_Chars(kNothingUnicodeText, &unicodeText, &unicodeTextLength);
	
	// and put it in the scrap as unicode text
#if !TARGET_API_MAC_CARBON
	ZeroScrap();
#else
	ScrapRef scrapRef;
	ClearCurrentScrap();
	status = GetCurrentScrap(&scrapRef);
	if (status != noErr) DebugStr("\p GetCurrentScrap failed");
#endif

	ByteCount byteLength = unicodeTextLength * sizeof(UniChar);
	Handle hUnicodeText = NewHandle(byteLength);
	HLock(hUnicodeText);
	BlockMoveData((Ptr)unicodeText, *hUnicodeText, byteLength);

#if !TARGET_API_MAC_CARBON
	PutScrap(byteLength, 'utxt', *hUnicodeText);
#else
	status = PutScrapFlavor(scrapRef, 'utxt', kScrapFlavorMaskNone, byteLength, *hUnicodeText);
	if (status != noErr) DebugStr("\p PutScrapFlavor utxt failed");
#endif

	// and ASCII text
	char *ASCIIText;
	QuickAndDirtySetASCII_C_CharsFromUnicodeText(&ASCIIText, (UniCharArrayPtr)*hUnicodeText, unicodeTextLength);
	Handle hText = NewHandle(unicodeTextLength);
	HLock(hText);
	BlockMoveData((Ptr)ASCIIText, *hText, unicodeTextLength);

#if !TARGET_API_MAC_CARBON
	PutScrap(unicodeTextLength, 'TEXT', *hText);
#else
	status = PutScrapFlavor(scrapRef, 'TEXT', kScrapFlavorMaskNone, unicodeTextLength, *hText);
	if (status != noErr) DebugStr("\p PutScrapFlavor TEXT failed");
#endif

	DisposeHandle(hUnicodeText);
	DisposeHandle(hText);
	DisposePtr((Ptr)ASCIIText);
	
	// simulate a paste
	DoPaste();
	
	return status;
	}

void DoCopy(WindowDataPtr wdataP)
	{
	// certain attributes should always be included in a flattened style because they have variable default values
	// •••WORKAROUND••• There's a bug in ATSUI 1.0 that gives random results or crashes when fetching a style's
	// language. Until that's fixed, we leave it out of the required attribute list.
	static const ATSUAttributeTag requiredAttributes[] = { kATSUFontTag, kATSUSizeTag /*, kATSULanguageTag*/ };
	static const ByteCount requiredAttrSizes[] = { sizeof(ATSUFontID), sizeof(Fixed) /*, sizeof(RegionCode)*/ };
	static const ItemCount numRequiredAttributes = sizeof(requiredAttributes) / sizeof(ATSUAttributeTag);
	
	OSStatus status = noErr;
	Sample6_PrivateData *priv = (Sample6_PrivateData *)wdataP->privateData;
	if (priv->length == 0)
		{
		// nothing to copy...
		SysBeep(1);
		return;
		}

	if (gClipboardWindow == NULL) CreateClipboardWindow();
#if !TARGET_API_MAC_CARBON
	Boolean wasVisible = ((WindowPeek)gClipboardWindow)->visible;
#else
	Boolean wasVisible = IsWindowVisible(gClipboardWindow);
#endif
	if (wasVisible) HideWindow(gClipboardWindow);

	// let's grab the selected text
#if !TARGET_API_MAC_CARBON
	ZeroScrap();
#else
	ScrapRef scrapRef;
	ClearCurrentScrap();
	status = GetCurrentScrap(&scrapRef);
	if (status != noErr) DebugStr("\p GetCurrentScrap failed");
#endif

	ByteCount byteLength = priv->length * sizeof(UniChar);
	Handle hUnicodeText = NewHandle(byteLength);
	HLock(hUnicodeText);
	BlockMoveData((Ptr)((long)wdataP->theUnicodeText + priv->caret * sizeof(UniChar)), *hUnicodeText, byteLength);

	// let's create the 'ustl' handle.
	// just look at ATSUTextConversion.h to get the detail of the structure.
	//
	// REMEMBER, don't use PPC (long) alignment or else sizeof(ATSUVersionType) will return 2
	//           but be aligned as 4 in the structures...
	//
	Size bufSize = 2000, realSize = 0, currentStyleOffset;
	Handle ustl = NewHandle(bufSize);
	HLock(ustl);
	
	ATSUStyleStreamHeader *ssh = (ATSUStyleStreamHeader *)(*ustl);
	ssh->fVersion = kATSUustlVersion;
	ssh->fTextLength = priv->length;
	ssh->fLayoutRunCount = 1; // in this sample code, we only have one layout
	ssh->fLayoutRunOffset = kATSUStyleStreamHeaderSize;
	realSize = kATSUStyleStreamHeaderSize;

	// emit a single layout control run that contains the one required control
	Boolean lineDirection;
	status = atsuGetLayoutLineDirection(wdataP->textLayout, &lineDirection);
	if (status != noErr) DebugStr("\patsuGetLineDirection failed");
	
	ATSULayoutRunStreamHeader *lrsh = (ATSULayoutRunStreamHeader*)((long)*ustl + ssh->fLayoutRunOffset);
	lrsh->fRunLength		= priv->length;
    lrsh->fRunDataSize		= sizeof(ATSULayoutRunStreamHeader) - offsetof(ATSULayoutRunStreamHeader, fRunStreamVersion) // header
    						+ sizeof(ATSUAttributeInfo) + sizeof(Boolean); // line direction control
    lrsh->fRunStreamVersion	= kATSUFlattenedLineCtrlVersion;
	lrsh->fRunControlCount	= 1;
	
	ATSUAttributeInfo *lih = (ATSUAttributeInfo *)((long)lrsh + sizeof(ATSULayoutRunStreamHeader));
	lih->fTag = kATSULineDirectionTag;
	lih->fValueSize = sizeof(Boolean);
	*(Boolean*)((long)lih + sizeof(ATSUAttributeInfo)) = lineDirection;
	
	realSize += lrsh->fRunDataSize + offsetof(ATSULayoutRunStreamHeader, fRunStreamVersion);
	
	// now deal with the style runs.
	ssh->fStyleRunOffset = currentStyleOffset = realSize;
	ATSUStyleRunStreamHeader *srsh = (ATSUStyleRunStreamHeader *)((long)*ustl + currentStyleOffset);
	
	// let's grab all the styles of the selected text
	ItemCount nbStyles = 0;
	UniCharArrayOffset here = 0, start;
	UniCharCount length;
	while (here < priv->length)
		{
		ATSUStyle tempS;
		status = ATSUGetRunStyle(wdataP->textLayout, priv->caret+here, &tempS, &start, &length);
		if (status != noErr)
			{
			DebugStr("\p ATSUGetRunStyle failed");
			break;
			}
		if ((start + length) > (priv->caret + priv->length))
			length = priv->caret + priv->length - start;
		srsh->fRunLength = start + length - priv->caret - here;
		ByteCount dataLength = sizeof(ATSUStyleRunStreamHeader) - offsetof(ATSUStyleRunStreamHeader, fRunStreamVersion); // count size from the version field
		srsh->fRunStreamVersion = kATSUFlattenedStyleVersion;
		srsh->fRunFeatureCount = 0; // in this sample code, we don't deal with font features.
		srsh->fRunVariationCount = 0; // in this sample code, we don't deal with font variations.

		// getting all attributes
		ItemCount attributeCount;
		// let's first know how many ...
		status = atsuCountStyleAttributes(tempS, &attributeCount);
		if (status != noErr) DebugStr("\p atsuCountStyleAttributes failed");
		// ... to allocate appropriately (we add extra slots for the required attributes)
		ATSUAttributeInfo *attributeInfoArray = (ATSUAttributeInfo *)NewPtr((attributeCount + numRequiredAttributes) * sizeof(ATSUAttributeInfo));
		// and get them
		status = ATSUGetAllAttributes(tempS, attributeInfoArray, attributeCount, &attributeCount);
		if (status != noErr) DebugStr("\p ATSUGetAllAttributes second time failed");
		
		// make sure we pick up the required attributes whether or not they've been set.
		ByteCount	attrLength;
		for (int i = 0; i < numRequiredAttributes; i++)
			{
			status = ATSUGetAttribute(tempS, requiredAttributes[i], requiredAttrSizes[i], NULL, &attrLength);
			if ((status != noErr) && (status != kATSUNotSetErr)) DebugStr("\p ATSUGetAttribute failed");
			if (status == kATSUNotSetErr)
				{
				attributeInfoArray[attributeCount].fTag			= requiredAttributes[i];
				attributeInfoArray[attributeCount].fValueSize	= attrLength;
				attributeCount++;
				}
			}
		
		srsh->fRunAttributeCount = attributeCount;
		realSize += sizeof(ATSUStyleRunStreamHeader);
		ATSUAttributeInfo *aih = (ATSUAttributeInfo *)((long)*ustl + realSize);
		
		ItemCount attr;
		for (attr = 0; attr < attributeCount; attr++)
			{
			if (attributeInfoArray[attr].fTag != kATSULanguageTag)	// •••WORKAROUND••• getting the language is broken in ATSUI 1.0
				{
				attrLength = attributeInfoArray[attr].fValueSize;
				Ptr p = NewPtr(attrLength);
				status = ATSUGetAttribute(tempS, attributeInfoArray[attr].fTag, attrLength, p, &attrLength);
				if ((status != noErr) && (status != kATSUNotSetErr)) DebugStr("\p ATSUGetAttribute failed");
				
				// if we get the kATSUFontTag tag, then we issue the font name rather than the font ID
				if (attributeInfoArray[attr].fTag == kATSUFontTag)
					{
					ATSUFontID theFontID = *((ATSUFontID *) p);
					// get the index and length of the first unique name in the font.
					// this should be the only unique name in a well-formed font.
					ItemCount fontNameIndex;
					status = ATSUFindFontName( theFontID, 
										3,	// kFontUniqueName,		(constant missing from SFNTTypes.h)
										-1, // kFontNoPlatform, 	(constant missing from SFNTTypes.h)
										-1, // kFontNoScript, 		(constant missing from SFNTTypes.h)
										-1, // kFontNoLanguage, 	(constant missing from SFNTTypes.h)
										0, 
										NULL, // don't actually get the name this first pass
										&attrLength, 
										&fontNameIndex );
					if ((status != noErr) || (attrLength == 0)) DebugStr("\p ATSUFindFontName failed");
					
					// now that we know the name length, get a new value buffer for it.
					DisposePtr(p);
					p = NewPtr(attrLength);

					// get the font name. we don't bother recording the platform script and language
					// since there should only be one unique name in any font.
					status = ATSUGetIndFontName( theFontID, 
										fontNameIndex,
										attrLength,
										p,
										NULL, 		// already have the font name length
										NULL, 		// don't need the font name code here
										NULL, 		// don't need the platform, script, or language since there is only one unique font name
										NULL,
										NULL );
					if (status != noErr) DebugStr("\p ATSUGetIndFontName failed");
					}
				
				// using the 300 margin, we only deal with size modification here
				if (realSize + attrLength > bufSize - 300)
					{
					bufSize += 2000;
					HUnlock(ustl);
					SetHandleSize(ustl, bufSize);
					HLock(ustl);
					aih = (ATSUAttributeInfo *)((long)*ustl + realSize);
					}
				
				aih->fTag = attributeInfoArray[attr].fTag;
				aih->fValueSize = attrLength;
				BlockMoveData(p, (Ptr)((long)aih + sizeof(ATSUAttributeInfo)), attrLength);
				
				dataLength += sizeof(ATSUAttributeInfo) + attrLength;
				realSize += sizeof(ATSUAttributeInfo) + attrLength;
				aih = (ATSUAttributeInfo *)((long)*ustl + realSize);
				DisposePtr(p);
				}
			else
				{
				--srsh->fRunAttributeCount;	// •••WORKAROUND••• we didn't include the language after all.
				}
			}

		srsh = (ATSUStyleRunStreamHeader *)((long)*ustl + currentStyleOffset);
		srsh->fRunDataSize = dataLength;
		currentStyleOffset = realSize;
		srsh = (ATSUStyleRunStreamHeader *)((long)*ustl + currentStyleOffset);
		
		nbStyles++;
		here = start + length - priv->caret;
		}

	// let's adjust the size
	ssh = (ATSUStyleStreamHeader *)(*ustl);
	ssh->fStyleRunCount = nbStyles;
	HUnlock(ustl);
	SetHandleSize(ustl, realSize);
	HLock(ustl);

	// pre-allocating the handles
	Handle hTEText, hTEStyles;
	hTEText = NewHandle(0);
	hTEStyles = NewHandle(0);

	// converting...
	status = ATSUConvertToTEStyledText(hUnicodeText, ustl, hTEText, hTEStyles);
	if (status != noErr) DebugStr("\p ATSUConvertToTEStyledText failed");
	
	HLock(hTEText);
	HLock(hTEStyles);

	// putting in scrap
#if !TARGET_API_MAC_CARBON
	PutScrap(byteLength, 'utxt', *hUnicodeText);
	PutScrap(GetHandleSize((Handle)ustl), 'ustl', *ustl);
	PutScrap(GetHandleSize((Handle)hTEText), 'TEXT', *hTEText);
	PutScrap(GetHandleSize((Handle)hTEStyles), 'styl', *hTEStyles);
#else
	status = PutScrapFlavor(scrapRef, 'utxt', kScrapFlavorMaskNone, byteLength, *hUnicodeText);
	if (status != noErr) DebugStr("\p PutScrapFlavor utxt failed");
	status = PutScrapFlavor(scrapRef, 'ustl', kScrapFlavorMaskNone, GetHandleSize((Handle)ustl), *ustl);
	if (status != noErr) DebugStr("\p PutScrapFlavor ustl failed");
	status = PutScrapFlavor(scrapRef, 'TEXT', kScrapFlavorMaskNone, GetHandleSize((Handle)hTEText), *hTEText);
	if (status != noErr) DebugStr("\p PutScrapFlavor TEXT failed");
	status = PutScrapFlavor(scrapRef, 'styl', kScrapFlavorMaskNone, GetHandleSize((Handle)hTEStyles), *hTEStyles);
	if (status != noErr) DebugStr("\p PutScrapFlavor styl failed");
#endif

	// and cleaning up.
	DisposeHandle(hUnicodeText);
	DisposeHandle(ustl);
	DisposeHandle(hTEText);
	DisposeHandle(hTEStyles);

	DoPaste();

	if (wasVisible) DoShowClipboard();

	return;
	}

void DoPaste()
	{
	OSStatus status = noErr;
	ATSUStyle tempS;
	Boolean lineDirectionSaved;
	Boolean gotLineDirection = false;

	// first the memory cleanup
	WindowDataPtr clipDataP = GetWindowData(gClipboardWindow);
	WindowDataPtr justTheUnicodeText = (WindowDataPtr)clipDataP->privateData;
	if (justTheUnicodeText != NULL)
		{
		SimpleQDText *sqdt = (SimpleQDText *)justTheUnicodeText->privateData;
		if (sqdt != NULL)
			{
			if (sqdt->justTheText != NULL) TEDispose(sqdt->justTheText);
			if (sqdt->textWithStyl != NULL) TEDispose(sqdt->textWithStyl);
			}
		DisposeWindowDataPtr(justTheUnicodeText);
		}
	DisposeWindowDataPtr(clipDataP);
	clipDataP = DefaultWindowDataPtr();
	SetWRefCon(gClipboardWindow, (long)clipDataP);

	// getting the scrap
#if !TARGET_API_MAC_CARBON
	LoadScrap();
#else
	ScrapRef scrapRef;
	status = GetCurrentScrap(&scrapRef);
	if (status != noErr) DebugStr("\p GetCurrentScrap failed");
#endif

#if !TARGET_API_MAC_CARBON
	long offset, byteLength = GetScrap(NULL, 'utxt', &offset);
#else
	long byteLength;
	status = GetScrapFlavorSize(scrapRef, 'utxt', &byteLength);
	if (status != noErr) DebugStr("\p GetScrapFlavorSize utxt failed");
#endif

	if (byteLength <= 0) return;

#if !TARGET_API_MAC_CARBON
	Handle hUnicodeText = NewHandle(0);
	GetScrap(hUnicodeText, 'utxt', &offset);
#endif
	
	// let's grab the text from the scrap
	clipDataP->uTextLength = byteLength / sizeof(UniChar);
	clipDataP->theUnicodeText = (UniCharArrayPtr)NewPtr(byteLength);

#if !TARGET_API_MAC_CARBON
	HLock(hUnicodeText);
	BlockMoveData(*hUnicodeText, (Ptr)clipDataP->theUnicodeText, byteLength);
#else
	status = GetScrapFlavorData(scrapRef, 'utxt', &byteLength, clipDataP->theUnicodeText);
	if (status != noErr) DebugStr("\p GetScrapFlavorData utxt failed");
#endif
	
	// let's grab the styles from the scrap
#if !TARGET_API_MAC_CARBON
	long styleLength = GetScrap(NULL, 'ustl', &offset);
#else
	long styleLength;
	status = GetScrapFlavorSize(scrapRef, 'ustl', &styleLength);
	if (status == noTypeErr)
		{
		status = noErr;
		styleLength = 0;
		}
	if (status != noErr) DebugStr("\p GetScrapFlavorSize ustl failed");
#endif

	if (styleLength <= 0)
		{
		// no 'ustl' resource or something went wrong...
		// going back to the default...
		
		// only 1 style thus only 1 run
		clipDataP->numberOfRuns = 1;
		clipDataP->runLengths = (UniCharCount *)NewPtr(clipDataP->numberOfRuns * sizeof(UniCharCount));
		clipDataP->runLengths[0] = clipDataP->uTextLength;

		// and it's the default style
		clipDataP->styles = (ATSUStyle *)NewPtr(clipDataP->numberOfRuns * sizeof(ATSUStyle));
		status = ATSUCreateStyle(&tempS);
		if (status != noErr) DebugStr("\p ATSUCreateStyle failed");
		clipDataP->styles[0] = tempS;
		}
	else
		{
		// getting the ustl resource
#if !TARGET_API_MAC_CARBON
		Handle ustl = NewHandle(0);
		GetScrap(ustl, 'ustl', &offset);
		HLock(ustl);
#else
		Handle ustl = NewHandle(styleLength);
		HLock(ustl);
		status = GetScrapFlavorData(scrapRef, 'ustl', &styleLength, *ustl);
		if (status != noErr) DebugStr("\p GetScrapFlavorData ustl failed");
#endif

		// allocating the arrays
		ATSUStyleStreamHeader *ssh = (ATSUStyleStreamHeader *)(*ustl);
		if (ssh->fVersion != kATSUustlVersion) DebugStr("\pGot unexpected utsl version");
		clipDataP->numberOfRuns = ssh->fStyleRunCount;
		clipDataP->runLengths = (UniCharCount *)NewPtr(clipDataP->numberOfRuns * sizeof(UniCharCount));
		clipDataP->styles = (ATSUStyle *)NewPtr(clipDataP->numberOfRuns * sizeof(ATSUStyle));

		// getting back all the styles
		ItemCount i;
		Ptr pos = (Ptr)((long)(*ustl) + ssh->fStyleRunOffset);
		for (i = 0; i < clipDataP->numberOfRuns; i++)
			{
			status = ATSUCreateStyle(&tempS);
			if (status != noErr) DebugStr("\p ATSUCreateStyle failed");
			
			ATSUStyleRunStreamHeader *srsh = (ATSUStyleRunStreamHeader *)pos;
			if (srsh->fRunStreamVersion != kATSUFlattenedStyleVersion) DebugStr("\pGot unexpected style version");
			clipDataP->runLengths[i] = srsh->fRunLength;
			ByteCount dataLength = sizeof(UniCharCount) + sizeof(ByteCount) + srsh->fRunDataSize;
			Ptr pos2 = pos + sizeof(ATSUStyleRunStreamHeader);
			pos += dataLength;
			
			ItemCount attr;
			for (attr = 0; attr < srsh->fRunAttributeCount; attr++)
				{
				ATSUAttributeInfo *aih = (ATSUAttributeInfo *)pos2;
				ATSUAttributeTag theTag = aih->fTag;
				ByteCount theLength = aih->fValueSize;
				Ptr thePtr = pos2 + sizeof(ATSUAttributeInfo);
				pos2 += sizeof(ATSUAttributeInfo) + theLength;
				
				// if we get the kATSUFontTag tag, we have a unique name and need to look up the font ID.
				ATSUFontID theFontID;
				if (theTag == kATSUFontTag)
					{
					status = ATSUFindFontFromName(	thePtr,
															theLength,
															3,	// kFontUniqueName,		(constant missing from SFNTTypes.h)
															-1, // kFontNoPlatform, 	(constant missing from SFNTTypes.h)
															-1, // kFontNoScript, 		(constant missing from SFNTTypes.h)
															-1, // kFontNoLanguage, 	(constant missing from SFNTTypes.h)
										 					&theFontID );
					if ( status == noErr && theFontID != kATSUInvalidFontID )
						{
						theLength = sizeof( ATSUFontID );
						thePtr = (Ptr)&theFontID;
						}
					}
				// set the attributes one by one.
				if ( status == noErr )
					{
					status = ATSUSetAttributes(tempS, 1, &theTag, &theLength, (ATSUAttributeValuePtr *)&thePtr);
					if (status != noErr) DebugStr("\p ATSUSetAttributes failed");
					}
				}
			
			clipDataP->styles[i] = tempS;
			}
			
		// get the line direction back. this code is purely illustrative. in general, you'd write
		// a loop similar to the one above that reconstituted styles from the flattened data.
		if (ssh->fLayoutRunCount == 1)
			{
			pos = (Ptr)((long)(*ustl) + ssh->fLayoutRunOffset + sizeof(ATSULayoutRunStreamHeader));
			ATSUAttributeInfo	*aih = (ATSUAttributeInfo *)pos;
		
			if (aih->fTag == kATSULineDirectionTag)
				{
				pos += sizeof(ATSUAttributeInfo);
				lineDirectionSaved = *((Boolean*)pos);
				gotLineDirection = true;
				}
			else
				DebugStr("\punexpected layout control");
			}
		else
			DebugStr("\punexpected number of layout control runs");
		
		DisposeHandle(ustl);
		}

	// and we create the text layout
	ATSUTextLayout tempTL;
	status = ATSUCreateTextLayoutWithTextPtr(clipDataP->theUnicodeText, 0, clipDataP->uTextLength, clipDataP->uTextLength, clipDataP->numberOfRuns, clipDataP->runLengths, clipDataP->styles, &tempTL);
	if (status != noErr) DebugStr("\p ATSUCreateTextLayoutWithTextPtr failed");
	clipDataP->textLayout = tempTL;
	
	// set the lineDirection we read from the clipboard (this is merely an illustration)
	if (gotLineDirection)
		{
		status = atsuSetLayoutLineDirection(clipDataP->textLayout, lineDirectionSaved);
		if (status != noErr) DebugStr("\p atsuSetLineDirection failed");
		}

	// now, let's break the text in pieces
	BreakTheTextInLines(gClipboardWindow, clipDataP);

	// another time just for the unicode text
	justTheUnicodeText = (WindowDataPtr)NewPtr(sizeof(WindowData));

	// let's grab the text
	justTheUnicodeText->uTextLength = byteLength / sizeof(UniChar);
	justTheUnicodeText->theUnicodeText = (UniCharArrayPtr)NewPtr(byteLength);

#if !TARGET_API_MAC_CARBON
	BlockMoveData(*hUnicodeText, (Ptr)justTheUnicodeText->theUnicodeText, byteLength);
	DisposeHandle(hUnicodeText);
#else
	BlockMoveData((Ptr)clipDataP->theUnicodeText, (Ptr)justTheUnicodeText->theUnicodeText, byteLength);
#endif
	
	// only 1 style thus only 1 run
	justTheUnicodeText->numberOfRuns = 1;
	justTheUnicodeText->runLengths = (UniCharCount *)NewPtr(justTheUnicodeText->numberOfRuns * sizeof(UniCharCount));
	justTheUnicodeText->runLengths[0] = justTheUnicodeText->uTextLength;

	// and it's the default style
	justTheUnicodeText->styles = (ATSUStyle *)NewPtr(justTheUnicodeText->numberOfRuns * sizeof(ATSUStyle));
	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");
	justTheUnicodeText->styles[0] = tempS;

	// and we create the text layout
	status = ATSUCreateTextLayoutWithTextPtr(justTheUnicodeText->theUnicodeText, 0, justTheUnicodeText->uTextLength, justTheUnicodeText->uTextLength, justTheUnicodeText->numberOfRuns, justTheUnicodeText->runLengths, justTheUnicodeText->styles, &tempTL);
	if (status != noErr) DebugStr("\p ATSUCreateTextLayoutWithTextPtr failed");
	justTheUnicodeText->textLayout = tempTL;
	
	// now, let's break the text in pieces
	BreakTheTextInLines(gClipboardWindow, justTheUnicodeText);
	
	justTheUnicodeText->privateData = (void *)NewPtr(sizeof(SimpleQDText));
	
	// let's fill the TEHandles
	TEHandle aTE;
	GrafPtr savePort;
	GetPort(&savePort);
#if !TARGET_API_MAC_CARBON
	SetPort(gClipboardWindow);
#else
	SetPortWindowPort(gClipboardWindow);
#endif
	
	TextFont(1);
	TextSize(9);
	
	TEFromScrap();
	
	Rect ra = r1;
	InsetRect(&ra, 2, 2);
	aTE = TEStyleNew(&ra, &ra);
	// just a TEPaste for the simple ASCII text
	TEPaste(aTE);
	((SimpleQDText *)(justTheUnicodeText->privateData))->justTheText = aTE;
	
	Rect rb = r2;
	InsetRect(&rb, 2, 2);
	aTE = TEStyleNew(&rb, &rb);
	// a TEStylePaste to also get the styles (as best as we can...)
	TEStylePaste(aTE);
	((SimpleQDText *)(justTheUnicodeText->privateData))->textWithStyl = aTE;

	SetPort(savePort);

	clipDataP->privateData = (void *)justTheUnicodeText;
	
	// to identify the window and validate all fields
	clipDataP->sampleKind = 100;
	}

void UpdateClipboard()
	{
	RgnHandle saveClip;
	saveClip = NewRgn();
	GetClip(saveClip);

	WindowDataPtr wdataP = GetWindowData(gClipboardWindow);
	if (wdataP->sampleKind == 100)
		{
		// all fields are valid
		TEHandle aTE;
		WindowDataPtr justTheUnicodeText = (WindowDataPtr)wdataP->privateData;
	
		TextFont(1);
		TextSize(9);

		// let's update just the ASCII text first
		Rect rb = r1;
		InsetRect(&rb, 2, 2);
		ClipRect(&rb);
		aTE = ((SimpleQDText *)(justTheUnicodeText->privateData))->justTheText;
		TEUpdate(&rb, aTE);
		
		// then TextEdit with Style
		Rect ra = r2;
		InsetRect(&ra, 2, 2);
		ClipRect(&ra);
		aTE = ((SimpleQDText *)(justTheUnicodeText->privateData))->textWithStyl;
		TEUpdate(&ra, aTE);

		TextFont(1);
		TextSize(9);

		// then just the Unicode Text in the single default style
		ClipRect(&r3);
			{
			ItemCount i;
			ATSUTextMeasurement x = ff(r3.left + 1);
			ATSUTextMeasurement y = ff(r3.top + 1) + justTheUnicodeText->lineHeight;
			UniCharArrayOffset lineStart = 0, lineEnd;
			for (i = 0; i < justTheUnicodeText->numberOfLines; i++)
				{
				lineEnd = justTheUnicodeText->endOfLines[i];
				OSStatus status = ATSUDrawText(justTheUnicodeText->textLayout, lineStart, lineEnd-lineStart, x, y);
				if (status != noErr) DebugStr("\p ATSUDrawText failed");
				y += justTheUnicodeText->lineHeight;
				lineStart = lineEnd;
				}
			}
		
		// and finally, the full Unicode Text and Styles
		ClipRect(&r4);
			{
			ItemCount i;
			ATSUTextMeasurement x = ff(r4.left + 1);
			ATSUTextMeasurement y = ff(r4.top + 1) + wdataP->lineHeight;
			UniCharArrayOffset lineStart = 0, lineEnd;
			for (i = 0; i < wdataP->numberOfLines; i++)
				{
				lineEnd = wdataP->endOfLines[i];
				OSStatus status = ATSUDrawText(wdataP->textLayout, lineStart, lineEnd-lineStart, x, y);
				if (status != noErr) DebugStr("\p ATSUDrawText failed");
				y += wdataP->lineHeight;
				lineStart = lineEnd;
				}
			}
		}
	
	SetClip(saveClip);
	DisposeRgn(saveClip);

	// some frames to be nice
	FrameRect(&r1);
	FrameRect(&r2);
	FrameRect(&r3);
	FrameRect(&r4);
	
	TextFont(1);
	TextSize(9);
	
	// and reminder labels
	MoveTo(r1.left, r1.bottom + 8); DrawString("\pTEXT");
	MoveTo(r2.left, r2.bottom + 8); DrawString("\pTEXT + styl");
	MoveTo(r3.left, r3.bottom + 8); DrawString("\putxt");
	MoveTo(r4.left, r4.bottom + 8); DrawString("\putxt + ustl");
	}

void DoShowClipboard()
	{
	if (gClipboardWindow == NULL) CreateClipboardWindow();
	ShowWindow(gClipboardWindow);
	SelectWindow(gClipboardWindow);
	}

#pragma mark •ATSU Text Box
#define kJustShortMax 10000

UniCharArrayPtr gDlgUnicodeText;			// the Text in Unicode
UniCharCount gDlgTextLength;				// its length

OSStatus UpdateUserItem(DialogPtr theDialog)
	{
	OSStatus status = noErr;

	short itemType;
	Handle item;
	Rect box;
	
	// get the values selected by the user for the flushness...
	short flushness;
	GetDialogItem(theDialog, 1, &itemType, &item, &box);
	if (GetControlValue((ControlHandle)item) == 1) flushness = teFlushLeft;
	else
		{
		GetDialogItem(theDialog, 2, &itemType, &item, &box);
		if (GetControlValue((ControlHandle)item) == 1) flushness = teCenter;
		else flushness = teFlushRight;
		}
	
	// ...justification...
	Fract justification;
	GetDialogItem(theDialog, 5, &itemType, &item, &box);
	short justShortValue = GetControlValue((ControlHandle)item);
	justification = Fix2Frac(FixDiv(ff(justShortValue), ff(kJustShortMax)));
	
	// .. and orientation
	short textOrientation;
	GetDialogItem(theDialog, 6, &itemType, &item, &box);
	if (GetControlValue((ControlHandle)item) == 1) textOrientation = katsuHorizontalText;
	else textOrientation = katsuVerticalText;
	
	GetDialogItem(theDialog, 4, &itemType, &item, &box);
	
	GrafPtr savePort;
	GetPort(&savePort);
#if !TARGET_API_MAC_CARBON
	SetPort(theDialog);
#else
	SetPortDialogPort(theDialog);
#endif
	TextFont(1); // let's use the default application font
	EraseRect(&box);
	// and draw
	status = atsuTextBox(gDlgUnicodeText, gDlgTextLength, &box, flushness, justification, textOrientation, true);
	TextFont(0); // let's go back to the default system font
	SetPort(savePort);

	return status;
	}

OSErr ShowATSUITextBox()
	{
	OSStatus status = noErr;

	QuickAndDirtySetUnicodeTextFromASCII_C_Chars(kSomeVeryLongUnicodeText, &gDlgUnicodeText, &gDlgTextLength);

	DialogPtr theDialog = GetNewDialog(256, NULL, (WindowPtr)-1L);
	
	// set up everything
	short itemType;
	Handle item;
	Rect box;

	// default is left ...
	GetDialogItem(theDialog, 1, &itemType, &item, &box);
	SetControlValue((ControlHandle)item, 1);
	GetDialogItem(theDialog, 2, &itemType, &item, &box);
	SetControlValue((ControlHandle)item, 0);
	GetDialogItem(theDialog, 3, &itemType, &item, &box);
	SetControlValue((ControlHandle)item, 0);

	// ... no justification (0) ...
	GetDialogItem(theDialog, 5, &itemType, &item, &box);
	SetControlMaximum((ControlHandle)item, kJustShortMax);
	SetControlValue((ControlHandle)item, 0);

	// ... and horizontal
	GetDialogItem(theDialog, 6, &itemType, &item, &box);
	SetControlValue((ControlHandle)item, 1);
	GetDialogItem(theDialog, 7, &itemType, &item, &box);
	SetControlValue((ControlHandle)item, 0);

	UpdateUserItem(theDialog);
	
	// somewhat standard modal dialog loop
	short itemHit;
	ModalFilterUPP myFilterProc = NewModalFilterUPP(myFilter);
	do	{
		Boolean somethingChanged = false;
		ModalDialog(myFilterProc, &itemHit);
		switch (itemHit)
			{
			case 1:
			case 2:
			case 3:
				if (itemHit != 1)
					{
					GetDialogItem(theDialog, 1, &itemType, &item, &box);
					if (GetControlValue((ControlHandle)item) == 1)
						{
						somethingChanged = true;
						SetControlValue((ControlHandle)item, 0);
						}
					}
				if (itemHit != 2)
					{
					GetDialogItem(theDialog, 2, &itemType, &item, &box);
					if (GetControlValue((ControlHandle)item) == 1)
						{
						somethingChanged = true;
						SetControlValue((ControlHandle)item, 0);
						}
					}
				if (itemHit != 3)
					{
					GetDialogItem(theDialog, 3, &itemType, &item, &box);
					if (GetControlValue((ControlHandle)item) == 1)
						{
						somethingChanged = true;
						SetControlValue((ControlHandle)item, 0);
						}
					}
				GetDialogItem(theDialog, itemHit, &itemType, &item, &box);
				SetControlValue((ControlHandle)item, 1);
				break;
			case 5:
				somethingChanged = true;
				break;
			case 6:
			case 7:
				if (itemHit != 6)
					{
					GetDialogItem(theDialog, 6, &itemType, &item, &box);
					if (GetControlValue((ControlHandle)item) == 1)
						{
						somethingChanged = true;
						SetControlValue((ControlHandle)item, 0);
						}
					}
				if (itemHit != 7)
					{
					GetDialogItem(theDialog, 7, &itemType, &item, &box);
					if (GetControlValue((ControlHandle)item) == 1)
						{
						somethingChanged = true;
						SetControlValue((ControlHandle)item, 0);
						}
					}
				GetDialogItem(theDialog, itemHit, &itemType, &item, &box);
				SetControlValue((ControlHandle)item, 1);
				break;
			}
		if (somethingChanged) UpdateUserItem(theDialog);
		} while (itemHit != 11);
	DisposeDialog(theDialog);
	DisposePtr((Ptr)gDlgUnicodeText);
	return status;
	}

// somewhat standard filter proc
pascal Boolean myFilter(DialogPtr currentDialog, EventRecord *theEventIn, short *theDialogItem)
	{
	Boolean returnVal = false;
	WindowPtr temp;
	if((theEventIn->what == updateEvt) && (theEventIn->message != (long)currentDialog))
		{
	 	DoUpdateWindow((WindowPtr)theEventIn->message);
	    }
	if((theEventIn->what == updateEvt) && (theEventIn->message == (long)currentDialog))
		{
	 	UpdateUserItem(currentDialog);
	    }
#if !TARGET_API_MAC_CARBON
	else if((theEventIn->what == mouseDown) && (FindWindow(theEventIn->where, &temp) == inDrag) && (temp == currentDialog))
#else
	else if((theEventIn->what == mouseDown) && (FindWindow(theEventIn->where, &temp) == inDrag) && (temp == GetDialogWindow(currentDialog)))
#endif
		{
		Rect bounds;
#if !TARGET_API_MAC_CARBON
		bounds = qd.screenBits.bounds;
#else
		BitMap bmap;
		GetQDGlobalsScreenBits(&bmap);
		bounds = bmap.bounds;
#endif
		DragWindow(temp, theEventIn->where, &bounds);
		}
	else
		{
		GrafPtr savePort;
		GetPort(&savePort);
#if !TARGET_API_MAC_CARBON
		SetPort(currentDialog);
#else
		SetPortDialogPort(currentDialog);
#endif
		returnVal= StdFilterProc(currentDialog, theEventIn, theDialogItem);
		SetPort(savePort);
		}
	return(returnVal);
	}

#pragma mark •Font Menu

WindowPtr gFontFeaturesWindow = NULL;

OSErr ShowFontMenu()
	{
	OSStatus status = noErr;
	WindowPtr aWind;
	Rect boundsRect = {50, 10, 590, 610};
	
	WindowDataPtr wdataP = DefaultWindowDataPtr();
	aWind = NewCWindow(NULL, &boundsRect, "\pFont Menu", true, noGrowDocProc, (WindowPtr)-1L, true, (long)wdataP);
	
	// let's use some very long text
	QuickAndDirtySetUnicodeTextFromASCII_C_Chars(kSomeVeryLongUnicodeText, &(wdataP->theUnicodeText), &(wdataP->uTextLength));

	// only 1 style thus only 1 run
	wdataP->numberOfRuns = 1;
	wdataP->runLengths = (UniCharCount *)NewPtr(wdataP->numberOfRuns * sizeof(UniCharCount));
	wdataP->runLengths[0] = wdataP->uTextLength;

	// and it's the default style
	wdataP->styles = (ATSUStyle *)NewPtr(wdataP->numberOfRuns * sizeof(ATSUStyle));
	ATSUStyle tempS;
	status = ATSUCreateStyle(&tempS);
	if (status != noErr) DebugStr("\p ATSUCreateStyle failed");

	TryToSetFontTo(tempS, "\pChicago");

	// let's set the font size
	status = atsuSetSize(tempS, ff(24));
	if (status != noErr) DebugStr("\p atsuSetSize failed");

	wdataP->styles[0] = tempS;

	// and we create the text layout
	ATSUTextLayout tempTL;
	status = ATSUCreateTextLayoutWithTextPtr(wdataP->theUnicodeText, 0, wdataP->uTextLength, wdataP->uTextLength, wdataP->numberOfRuns, wdataP->runLengths, wdataP->styles, &tempTL);
	if (status != noErr) DebugStr("\p ATSUCreateTextLayoutWithTextPtr failed");
	wdataP->textLayout = tempTL;
	
	// to be drawn at
	wdataP->xLocation = ff(10);
	wdataP->yLocation = ff(20);
	
	// now, let's break the text in pieces
#if !TARGET_API_MAC_CARBON
	aWind->portRect.right -= 80;
#else
	Rect thePortRect;
	CGrafPtr wPort = GetWindowPort(aWind);
	GetPortBounds(wPort, &thePortRect);
	thePortRect.right -= 80;
	SetPortBounds(wPort, &thePortRect);
#endif
	BreakTheTextInLines(aWind, wdataP);
#if !TARGET_API_MAC_CARBON
	aWind->portRect.right += 80;
#else
	thePortRect.right += 80;
	SetPortBounds(wPort, &thePortRect);
#endif
	
	// to identify the window when we click on the button (see below)
	wdataP->sampleKind = 9;
	
	// let's add the menu button
	void *menuLookupCookie;
	short menuID = UniqueMenuId();
	MenuHandle theMenu = NewMenu(menuID, "\pFonts");
	status = atsuAppendFontMenu(theMenu, menuID+1, NULL, &menuLookupCookie);
	if (status != noErr) DebugStr("\p atsuAppendFontMenu failed");
	
//	Rect buttonRect = {392, 540, 410, 610};
	Rect buttonRect = { 10, 520,  28, 590};
	InsertMenu(theMenu, -1);
	ControlHandle button = NewControl(aWind, &buttonRect, "\pFonts", true, menuID,
							kControlBehaviorCommandMenu + kControlContentTextOnly, 0,
							kControlBevelButtonNormalBevelProc, (long)wdataP);

	// let's keep some stuff around...
	wdataP->privateData = (void *)NewPtr(sizeof(Sample9_PrivateData));
	((Sample9_PrivateData *)wdataP->privateData)->menuID = menuID;
	((Sample9_PrivateData *)wdataP->privateData)->menuLookupCookie = menuLookupCookie;
	((Sample9_PrivateData *)wdataP->privateData)->theMenu = theMenu;
	((Sample9_PrivateData *)wdataP->privateData)->button = button;
	
	return status;
	}

void ChangeTheFeature(ControlHandle theControl)
	{
	FeatureGroup *cRef = (FeatureGroup *)GetControlReference(theControl);
	if (cRef == NULL) return;

	WindowPtr theWind = (WindowPtr)GetWRefCon(gFontFeaturesWindow);
	WindowDataPtr wdataP = GetWindowData(theWind);
	Sample9_PrivateData *priv = (Sample9_PrivateData *)wdataP->privateData;
	
	GrafPtr savePort;
	GetPort(&savePort);
#if !TARGET_API_MAC_CARBON
	SetPort(theWind);
#else
	SetPortWindowPort(theWind);
#endif
	
	// let's grab the unique style:
	ATSUStyle tempS;
	OSStatus status;
	status = ATSUGetRunStyle(wdataP->textLayout, 0, &tempS, NULL, NULL);
	if (status != noErr) DebugStr("\p ATSUGetRunStyle failed");

	// deal with the control itself and its companions if need be
	// and set or clear the new feature or variation in the style.
	// there's no need to reapply the style.
	if (cRef->group == -1)
		{ // variation
		Fixed value = (Fixed)GetControlValue(theControl);
		value <<= 8;
		status = ATSUSetVariations(tempS, 1, (ATSUFontVariationAxis *)&(cRef->type), &value);
		if (status != noErr) DebugStr("\p ATSUSetVariations failed");
		}
	else if (cRef->group == 0)
		{ // check box for a non-mutually exclusive feature
		if (GetControlValue(theControl) == 1)
			{
			status = ATSUClearFontFeatures(tempS, 1, &(cRef->type), &(cRef->sel));
			if (status != noErr) DebugStr("\p ATSUSetFontFeatures failed");
			SetControlValue(theControl, 0);
			}
		else
			{
			status = ATSUSetFontFeatures(tempS, 1, &(cRef->type), &(cRef->sel));
			if (status != noErr) DebugStr("\p ATSUSetFontFeatures failed");
			SetControlValue(theControl, 1);
			}
		}
	else if (GetControlValue(theControl) == 0)
		{ // radio in a group of mutually exclusive features
		long i;
		for(i=0; i<cRef->group; i++)
			if (GetControlValue(cRef->cntlList[i]) == 1)
				{
				FeatureGroup *cRef2 = (FeatureGroup *)GetControlReference(cRef->cntlList[i]);
				if (cRef2 != NULL)
					{
					status = ATSUClearFontFeatures(tempS, 1, &(cRef2->type), &(cRef2->sel));
					if (status != noErr) DebugStr("\p ATSUSetFontFeatures failed");
					}
				SetControlValue(cRef->cntlList[i], 0);
				}
		status = ATSUSetFontFeatures(tempS, 1, &(cRef->type), &(cRef->sel));
		if (status != noErr) DebugStr("\p ATSUSetFontFeatures failed");
		SetControlValue(theControl, 1);
		}
	
	// clear all the current soft breaks
	status = ATSUClearSoftLineBreaks(wdataP->textLayout, 0, wdataP->uTextLength);
	if (status != noErr) DebugStr("\p ATSUClearSoftLineBreaks failed");
	
	// dispose of the current endOfLines array
	if (wdataP->endOfLines != NULL) DisposePtr((Ptr)wdataP->endOfLines);
	
	// and let's break the text in pieces again
#if !TARGET_API_MAC_CARBON
	theWind->portRect.right -= 80;
#else
	Rect thePortRect;
	CGrafPtr wPort = GetWindowPort(theWind);
	GetPortBounds(wPort, &thePortRect);
	thePortRect.right -= 80;
	SetPortBounds(wPort, &thePortRect);
#endif
	BreakTheTextInLines(theWind, wdataP);
#if !TARGET_API_MAC_CARBON
	theWind->portRect.right += 80;
#else
	thePortRect.right += 80;
	SetPortBounds(wPort, &thePortRect);
#endif

	// ask for an update...
#if !TARGET_API_MAC_CARBON
	EraseRect(&theWind->portRect);
	InvalRect(&theWind->portRect);
#else
	EraseRect(&thePortRect);
	InvalWindowRect(theWind, &thePortRect);
#endif
	SetPort(savePort);
	}

void ChangeTheFont(WindowDataPtr wdataP)
	{
	Sample9_PrivateData *priv = (Sample9_PrivateData *)wdataP->privateData;
	
	// which value?
	SInt16 value;
	GetBevelButtonMenuValue(priv->button, &value);
	
	// in which menu (or submenu...)
	Size outActualSize;
	short aMenuID;
	GetControlData(priv->button, 0, kControlBevelButtonLastMenuTag, sizeof(SInt16), (Ptr)&aMenuID, &outActualSize);
	
	atsuInstanceIndex theFontInstance;
	ATSUFontID theFontID = atsuGetFontForFontMenuItem(aMenuID, value, priv->menuLookupCookie, &theFontInstance);
	if (theFontID == kATSUInvalidFontID)
		{
		DebugStr("\p atsuGetFontForFontMenuItem failed");
		return;
		}
	
	GrafPtr currentPort;
	GetPort(&currentPort);
	
	// let's grab the unique style:
	ATSUStyle tempS;
	OSStatus status;
	status = ATSUGetRunStyle(wdataP->textLayout, 0, &tempS, NULL, NULL);
	if (status != noErr) DebugStr("\p ATSUGetRunStyle failed");

	// set the new font in the style. there's no need to reapply the style.
	status = atsuSetStyleFontInstance(tempS, theFontID, theFontInstance);
	if (status != noErr) DebugStr("\p atsuSetStyleFontInstance failed");
	
	// and clear all the current font features
	// variations are already cleared by atsuSetStyleFontInstance
	status = ATSUClearFontFeatures(tempS, kATSUClearAll, NULL, NULL);
	if (status != noErr) DebugStr("\p ATSUClearFontFeatures failed");
	
	// dispose of the current endOfLines array
	if (wdataP->endOfLines != NULL) DisposePtr((Ptr)wdataP->endOfLines);
	
	// and let's break the text in pieces again
#if !TARGET_API_MAC_CARBON
	currentPort->portRect.right -= 80;
	BreakTheTextInLines(currentPort, wdataP);
	currentPort->portRect.right += 80;
#else
	Rect thePortRect;
	GetPortBounds(currentPort, &thePortRect);
	thePortRect.right -= 80;
	SetPortBounds(currentPort, &thePortRect);
	BreakTheTextInLines(GetWindowFromPort(currentPort), wdataP);
	thePortRect.right += 80;
	SetPortBounds(currentPort, &thePortRect);
#endif

	// ask for an update...
#if !TARGET_API_MAC_CARBON
	EraseRect(&currentPort->portRect);
	InvalRect(&currentPort->portRect);
#else
	EraseRect(&thePortRect);
	InvalWindowRect(GetWindowFromPort(currentPort), &thePortRect);
#endif

	if (gFontFeaturesWindow == NULL) CreateFontFeaturesWindow();
#if !TARGET_API_MAC_CARBON
	Boolean wasVisible = ((WindowPeek)gFontFeaturesWindow)->visible;
#else
	Boolean wasVisible = IsWindowVisible(gFontFeaturesWindow);
#endif
	if (wasVisible) HideWindow(gFontFeaturesWindow);

	SetUpFontFeaturesWindow(theFontID, tempS);

	DoShowFontFeatures();
/*
	printf("\n\nmenuid = %ld, value = %ld, ", aMenuID, value);
	ItemCount oFontNameCount;
	status = ATSUCountFontNames(theFontID, &oFontNameCount);
	if (status != noErr) DebugStr("\p ATSUCountFontNames failed");
	printf("font names = %ld:\n", oFontNameCount);

	ItemCount i, j, k;
	Str255 oName;
	ByteCount oActualNameLength;
	FontNameCode oFontNameCode;
	FontPlatformCode oFontNamePlatform;
	FontScriptCode oFontNameScript;
	FontLanguageCode oFontNameLanguage;
	for(i=0; i<oFontNameCount; i++)
		{
		status = ATSUGetIndFontName(theFontID, i, 255, (char *)oName, &oActualNameLength, &oFontNameCode, &oFontNamePlatform, &oFontNameScript, &oFontNameLanguage);
		if (status != noErr) DebugStr("\p ATSUGetIndFontName failed");
		if (oActualNameLength > 255) oActualNameLength = 255;
		oName[oActualNameLength] = 0;
		if (oFontNameCode <= kFontLastReservedName)
			printf("code = %ld, platform = %ld, script = %ld, language = %ld, name = %s\n", oFontNameCode, oFontNamePlatform, oFontNameScript, oFontNameLanguage, oName);
		}

	ItemCount oFontNameIndex, oVariationCount;
	status = ATSUCountFontVariations(theFontID, &oVariationCount);
	if (status != noErr) DebugStr("\p ATSUCountFontVariations failed");
	printf("\nfont variations = %ld:\n", oVariationCount);
	ATSUFontVariationAxis oATSUFontVariationAxis;
	ATSUFontVariationValue oMinimumValue, oMaximumValue, oDefaultValue;
	for(i=0; i<oVariationCount; i++)
		{
		status = ATSUGetIndFontVariation(theFontID, i, &oATSUFontVariationAxis, &oMinimumValue, &oMaximumValue, &oDefaultValue);
		if (status != noErr) DebugStr("\p ATSUGetIndFontVariation failed");
		status = ATSUGetFontVariationNameCode(theFontID, oATSUFontVariationAxis, &oFontNameCode);
		if (status != noErr) DebugStr("\p ATSUGetFontVariationNameCode failed");
		status = ATSUFindFontName(theFontID, oFontNameCode, kFontNoPlatform, kFontNoScript, kFontNoLanguage, 255, (char *)oName, &oActualNameLength, &oFontNameIndex);
		if (status != noErr) DebugStr("\p ATSUFindFontName failed");
		if (oActualNameLength > 255) oActualNameLength = 255;
		oName[oActualNameLength] = 0;
		printf("code = %ld, min = %X, max = %X, val = %X, name = %s\n", oFontNameCode, oMinimumValue, oMaximumValue, oDefaultValue, oName);
		}
	
	ItemCount oTypeCount, oActualTypeCount, oSelectorCount, oActualSelectorCount;
	status = ATSUCountFontFeatureTypes(theFontID, &oTypeCount);
	if (status != noErr) DebugStr("\p ATSUCountFontFeatureTypes failed");
	printf("\nfont feature types = %ld:\n", oTypeCount);
	ATSUFontFeatureType oTypes[300];
	ATSUFontFeatureSelector oSelectors[300];
	Boolean oIsMutuallyExclusive, oSelectorIsOnByDefault[300];
	status = ATSUGetFontFeatureTypes(theFontID, 300, oTypes, &oActualTypeCount);
	if (status != noErr) DebugStr("\p ATSUGetFontFeatureTypes failed");
	if (oTypeCount > 300) oTypeCount = 300;
	for(i=0; i<oTypeCount; i++)
		{
		status = ATSUCountFontFeatureSelectors(theFontID, oTypes[i], &oSelectorCount);
		if (status != noErr) DebugStr("\p ATSUCountFontFeatureSelectors failed");
		status = ATSUGetFontFeatureSelectors(theFontID, oTypes[i], 300, oSelectors, oSelectorIsOnByDefault, &oActualSelectorCount, &oIsMutuallyExclusive);
		if (status != noErr) DebugStr("\p ATSUCountFontFeatureSelectors failed");
		if (oIsMutuallyExclusive)
				printf("\nfont feature type selectors for %ld (MUTUALLY EXCLUSIVE) = %ld:\n", oTypes[i], oSelectorCount);
		else	printf("\nfont feature type selectors for %ld = %ld:\n", oTypes[i], oSelectorCount);
		if (oSelectorCount > 300) oSelectorCount = 300;
		
		for(j=0; j<oSelectorCount; j++)
			{
			FontNameCode theFontNameCode;
			status = ATSUGetFontFeatureNameCode(theFontID, oTypes[i], oSelectors[j], &theFontNameCode);
			if (status != noErr) DebugStr("\p ATSUGetFontFeatureNameCode failed");
			status = ATSUFindFontName(theFontID, theFontNameCode, kFontNoPlatform, kFontNoScript, kFontNoLanguage, 255, (char *)oName, &oActualNameLength, &oFontNameIndex);
			if (status != noErr) DebugStr("\p ATSUFindFontName failed");
			if (oActualNameLength > 255) oActualNameLength = 255;
			oName[oActualNameLength] = 0;
			if (oSelectorIsOnByDefault[j])
					printf("selector = %ld, code = %ld, ON by default, name = %s\n", oSelectors[j], theFontNameCode, oName);
			else	printf("selector = %ld, code = %ld, name = %s\n", oSelectors[j], theFontNameCode, oName);

			for(k=0; k<oFontNameCount; k++)
				{
				status = ATSUGetIndFontName(theFontID, k, 255, (char *)oName, &oActualNameLength, &oFontNameCode, &oFontNamePlatform, &oFontNameScript, &oFontNameLanguage);
				if (status != noErr) DebugStr("\p ATSUGetIndFontName failed");
				if (oActualNameLength > 255) oActualNameLength = 255;
				oName[oActualNameLength] = 0;
				if ((oFontNameCode == theFontNameCode) && (k != oFontNameIndex))
					printf("            lang. = %ld, name = %s\n", oFontNameLanguage, oName);
				}

			}
		}
*/
	}

void SetUpFontFeaturesWindow(ATSUFontID theFontID, ATSUStyle tempS)
	{
	//setup
	long cntlHeight2 = 20, cntlHeight3 = 1;
#if !TARGET_API_MAC_CARBON
	long cntlHeight = 14, cntlWidthMargin = 24, cntlWidthTextMargin = 10;
#else
	long cntlHeight, cntlWidthMargin, cntlWidthTextMargin;
	if (IsThisAqua())
		{
		cntlHeight = 18; cntlWidthMargin = 48; cntlWidthTextMargin = 16;
		}
	else
		{
		cntlHeight = 14; cntlWidthMargin = 24; cntlWidthTextMargin = 10;
		}
#endif
	// cleanup...
#if !TARGET_API_MAC_CARBON
	ControlHandle theControl = (ControlHandle)(((WindowPeek)gFontFeaturesWindow)->controlList);
	while (theControl != NULL)
#else
	UInt16 numChildren, index;
	ControlRef rootControl, theControl;
	GetRootControl(gFontFeaturesWindow, &rootControl);
	CountSubControls(rootControl, &numChildren);
	for (index = numChildren; index >= 1; index--)
#endif
		{
#if TARGET_API_MAC_CARBON
		GetIndexedSubControl(rootControl, index, &theControl);
#endif
		FeatureGroup *cRef = (FeatureGroup *)GetControlReference(theControl);
		if (cRef != NULL)
			{
			if (cRef->cntlList != NULL) DisposePtr((Ptr)cRef->cntlList);
			DisposePtr((Ptr)cRef);
			}
		DisposeControl(theControl);
#if !TARGET_API_MAC_CARBON
		theControl = (ControlHandle)(((WindowPeek)gFontFeaturesWindow)->controlList);
#endif
		}
	
	GrafPtr savePort;
	GetPort(&savePort);
#if !TARGET_API_MAC_CARBON
	SetPort(gFontFeaturesWindow);
#else
	SetPortWindowPort(gFontFeaturesWindow);
#endif
	TextFont(systemFont);
	TextSize(12);
	
	short y = 0, MaxWidth = 0;
	
	ItemCount i, j, oTypeCount, oActualTypeCount, oSelectorCount, oActualSelectorCount, oFontNameIndex, oVariationCount;
	Str255 oName;
	Rect cntlRect;
	ControlHandle aControl;
	ByteCount oActualNameLength;
	FontNameCode theFontNameCode;
	OSStatus status = ATSUCountFontFeatureTypes(theFontID, &oTypeCount);
	if (status != noErr) DebugStr("\p ATSUCountFontFeatureTypes failed");
	ATSUFontFeatureType oTypes[300];
	ATSUFontFeatureSelector oSelectors[300];
	Boolean oIsMutuallyExclusive, oSelectorIsOnByDefault[300];
	FeatureGroup *cRef;
	ControlHandle *cntlList;
	status = ATSUGetFontFeatureTypes(theFontID, 300, oTypes, &oActualTypeCount);
	if (status != noErr) DebugStr("\p ATSUGetFontFeatureTypes failed");
	if (oTypeCount > 300) oTypeCount = 300;
	for(i=0; i<oTypeCount; i++)
		{
		status = ATSUCountFontFeatureSelectors(theFontID, oTypes[i], &oSelectorCount);
		if (status != noErr) DebugStr("\p ATSUCountFontFeatureSelectors failed");
		status = ATSUGetFontFeatureSelectors(theFontID, oTypes[i], 300, oSelectors, oSelectorIsOnByDefault, &oActualSelectorCount, &oIsMutuallyExclusive);
		if (status != noErr) DebugStr("\p ATSUCountFontFeatureSelectors failed");
		if (oIsMutuallyExclusive)
			cntlList = (ControlHandle *)NewPtr(oSelectorCount * sizeof(ControlHandle));
		else cntlList = NULL;
		if (oSelectorCount > 300) oSelectorCount = 300;
		
		for(j=0; j<oSelectorCount; j++)
			{
			status = ATSUGetFontFeatureNameCode(theFontID, oTypes[i], oSelectors[j], &theFontNameCode);
			if (status != noErr) DebugStr("\p ATSUGetFontFeatureNameCode failed");
			status = ATSUFindFontName(theFontID, theFontNameCode, kFontNoPlatform, kFontNoScript, kFontNoLanguage, 255, (char *)&oName[1], &oActualNameLength, &oFontNameIndex);
			if (status != noErr) DebugStr("\p ATSUFindFontName failed");
			if (oActualNameLength > 255) oActualNameLength = 255;
			oName[0] = oActualNameLength;

			cRef = (FeatureGroup *)NewPtr(sizeof(FeatureGroup));
			if (oIsMutuallyExclusive)
				cRef->group = oSelectorCount;
			else cRef->group = 0;
			cRef->type = oTypes[i];
			cRef->sel = oSelectors[j];
			cRef->cntlList = cntlList;
			
			short theWidth = StringWidth(oName);
			if (theWidth > MaxWidth) MaxWidth = theWidth;
			SetRect(&cntlRect, 0, y, theWidth+cntlWidthMargin, y+cntlHeight);
			SInt16 theProcID = (oIsMutuallyExclusive)?kControlRadioButtonProc:kControlCheckBoxProc;
			aControl = NewControl(gFontFeaturesWindow, &cntlRect, oName, true, 0, 0, 1, theProcID, (SInt32)cRef);
			if (oIsMutuallyExclusive) cntlList[j] = aControl;
			if (oSelectorIsOnByDefault[j]) SetControlValue(aControl, 1);
			y += cntlHeight;
			}
		
		SetRect(&cntlRect, 0, y, 2000, y+cntlHeight3);
		aControl = NewControl(gFontFeaturesWindow, &cntlRect, "\p", true, 0, 0, 1, kControlSeparatorLineProc, 0);
		y += cntlHeight3;
		}

	status = ATSUCountFontVariations(theFontID, &oVariationCount);
	if (status != noErr) DebugStr("\p ATSUCountFontVariations failed");
	ATSUFontVariationAxis oATSUFontVariationAxis;
	ATSUFontVariationValue oMinimumValue, oMaximumValue, oDefaultValue;
	if (oVariationCount != 0)
		{
		SetRect(&cntlRect, 0, y, 2000, y+cntlHeight3);
		aControl = NewControl(gFontFeaturesWindow, &cntlRect, "\p", true, 0, 0, 1, kControlSeparatorLineProc, 0);
		y += 4;
		}
	for(i=0; i<oVariationCount; i++)
		{
		status = ATSUGetIndFontVariation(theFontID, i, &oATSUFontVariationAxis, &oMinimumValue, &oMaximumValue, &oDefaultValue);
		if (status != noErr) DebugStr("\p ATSUGetIndFontVariation failed");
		
		status = ATSUGetFontVariationValue(tempS, oATSUFontVariationAxis, &oDefaultValue);
		if (status != noErr) DebugStr("\p ATSUGetFontVariationValue failed");
		
		status = ATSUGetFontVariationNameCode(theFontID, oATSUFontVariationAxis, &theFontNameCode);
		if (status != noErr) DebugStr("\p ATSUGetFontVariationNameCode failed");
		status = ATSUFindFontName(theFontID, theFontNameCode, kFontNoPlatform, kFontNoScript, kFontNoLanguage, 255, (char *)&oName[1], &oActualNameLength, &oFontNameIndex);
		if (status != noErr) DebugStr("\p ATSUFindFontName failed");
		if (oActualNameLength > 255) oActualNameLength = 255;
		oName[0] = oActualNameLength;

		short theWidth = StringWidth(oName);
		SetRect(&cntlRect, 4, y, (theWidth+cntlWidthTextMargin), y+cntlHeight2);
		aControl = NewControl(gFontFeaturesWindow, &cntlRect, oName, true, 0, 0, 0, kControlStaticTextProc, 0);
		SetControlData(aControl, kControlNoPart, kControlStaticTextTextTag, oActualNameLength, (Ptr) &(oName[1]));

		cRef = (FeatureGroup *)NewPtr(sizeof(FeatureGroup));
		cRef->group = -1;
		*((ATSUFontVariationAxis *)&(cRef->type)) = oATSUFontVariationAxis;
		cRef->cntlList = NULL;

		SetRect(&cntlRect, (theWidth+cntlWidthTextMargin), y, (theWidth+150), y+cntlHeight2);
		if ((theWidth+150) > MaxWidth) MaxWidth = (theWidth+150);
		aControl = NewControl(gFontFeaturesWindow, &cntlRect, oName, true, oDefaultValue >> 8, oMinimumValue >> 8, oMaximumValue >> 8, kControlSliderProc, (SInt32)cRef);
		y += cntlHeight2;
		}
	if (oVariationCount != 0)
		{
		SetRect(&cntlRect, 0, y, 2000, y+cntlHeight3);
		aControl = NewControl(gFontFeaturesWindow, &cntlRect, "\p", true, 0, 0, 1, kControlSeparatorLineProc, 0);
		y += cntlHeight3;
		}
	
	SizeWindow(gFontFeaturesWindow, MaxWidth+cntlWidthMargin, y-cntlHeight3, true);
	
	SetPort(savePort);
	}

OSStatus CreateFontFeaturesWindow()
	{
	OSStatus status = noErr;
	Rect boundsRect = {150, 110, 570, 730};
	status = CreateNewWindow(kFloatingWindowClass, kWindowStandardFloatingAttributes, &boundsRect, &gFontFeaturesWindow);
#if TARGET_API_MAC_CARBON
	ControlRef rootControl;
	if (gFontFeaturesWindow != NULL) CreateRootControl(gFontFeaturesWindow, &rootControl);
#endif
	return status;
	}

void DoShowFontFeatures()
	{
	if (gFontFeaturesWindow == NULL) CreateFontFeaturesWindow();
	SetWRefCon(gFontFeaturesWindow, (long)FrontNonFloatingWindow());
	ShowWindow(gFontFeaturesWindow);
	SelectWindow(gFontFeaturesWindow);
	}

void DisposeSample9Window(WindowDataPtr wdataP)
	{
	Sample9_PrivateData *priv = (Sample9_PrivateData *)wdataP->privateData;
	DeleteMenu(priv->menuID);
	if (priv->theMenu != nil) DisposeMenu(priv->theMenu);
	atsuDisposeFontMenuLookupCookie(priv->menuLookupCookie);
	}

short UniqueMenuId()
	{
	short i, result = -1;
	for (i = 20000; result == -1; i+=100) if (GetMenuHandle(i) == nil) result = i;
	return result;
	}


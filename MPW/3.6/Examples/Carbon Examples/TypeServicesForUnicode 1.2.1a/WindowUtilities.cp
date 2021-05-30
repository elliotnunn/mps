/*
	File:		WindowUtilities.cp

	Description:Some storage utility functions

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
				10/14/1999	AD				Give up if GetFNum fails
				 7/27/1999	KG				Updated for Metrowerks Codewarror Pro 2.1				
				 9/01/1998	AD				Updated
				 7/01/1998	ES				Created
				

*/

#ifdef __MWERKS__

// includes for MetroWerks CodeWarrior

#include <ATSUnicode.h>
#include <Windows.h>
#include <Gestalt.h>

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

#include "MoreATSUnicode.h"

/* not in Universal Interfaces yet... */
#define gestaltMenuMgrAquaLayoutMask (1L << 1)

Boolean IsThisAqua()
	{
	long response;
	OSErr err = Gestalt(gestaltMenuMgrAttr, &response);
	return ((err == noErr) && (response & gestaltMenuMgrAquaLayoutMask));
	}

WindowDataPtr GetWindowData(WindowPtr theWind)
	{
	WindowDataPtr result = NULL;
#if !TARGET_API_MAC_CARBON
	if ((theWind != NULL) && (((WindowPeek)theWind)->windowKind == kApplicationWindowKind))
#else
	if ((theWind != NULL) && (GetWindowKind(theWind) == kApplicationWindowKind))
#endif
		result = (WindowDataPtr)GetWRefCon(theWind);
	return result;
	}

WindowDataPtr DefaultWindowDataPtr()
	{
	WindowDataPtr wdataP = (WindowDataPtr)NewPtr(sizeof(WindowData));
	if (wdataP != NULL)
		{
		wdataP->sampleKind = 0;
		wdataP->privateData = NULL;
		wdataP->theUnicodeText = NULL;
		wdataP->uTextLength = -1;
		wdataP->xLocation = ff(10);
		wdataP->yLocation = ff(10);
		wdataP->lineHeight = 0;
		wdataP->numberOfLines = 1;
		wdataP->endOfLines = NULL;
		wdataP->numberOfRuns = -1;
		wdataP->runLengths = NULL;
		wdataP->styles = NULL;
		wdataP->textLayout = NULL;
		}
	return wdataP;
	}

void DisposeWindowDataPtr(WindowDataPtr wdataP)
	{
	if (wdataP->privateData != NULL) DisposePtr((Ptr)wdataP->privateData);
	if (wdataP->theUnicodeText != NULL) DisposePtr((Ptr)wdataP->theUnicodeText);
	if (wdataP->endOfLines != NULL) DisposePtr((Ptr)wdataP->endOfLines);
	if (wdataP->runLengths != NULL) DisposePtr((Ptr)wdataP->runLengths);
	if (wdataP->styles != NULL)
		{
		long i;
		for (i=0; i < wdataP->numberOfRuns; i++)
			if (wdataP->styles[i] != NULL)
				{
				long j;
				for (j=i+1; j < wdataP->numberOfRuns; j++)
					if (wdataP->styles[i] == wdataP->styles[j])
						wdataP->styles[j] = NULL;	// so that we don't try to dispose it again
				ATSUDisposeStyle(wdataP->styles[i]);
				}
		DisposePtr((Ptr)wdataP->styles);
		}
	if (wdataP->textLayout != NULL) ATSUDisposeTextLayout(wdataP->textLayout);
	}

ATSUFontID GetFontIDFromMacFontName(Str255 fontName)
	{
	ATSUFontID result = kATSUInvalidFontID, found;
	short iFONDNumber;
	GetFNum(fontName, &iFONDNumber);
	if (!iFONDNumber) return kATSUInvalidFontID;	// GetFNum return 0 if not found.
	OSStatus status = ATSUFONDtoFontID(iFONDNumber, NULL, &found);
	if (status == noErr) result = found;
	return result;
	}

void TryToSetFontTo(ATSUStyle theStyle, Str255 fontName)
	{
	ATSUFontID theFontID = GetFontIDFromMacFontName(fontName);
	if (theFontID == kATSUInvalidFontID) DebugStr("\p can't find this font");
	else
		{
		OSStatus status = atsuSetFont(theStyle, theFontID);
		if (status != noErr) DebugStr("\p ATSUSetAttributes kATSUFontTag failed");
		}
	}

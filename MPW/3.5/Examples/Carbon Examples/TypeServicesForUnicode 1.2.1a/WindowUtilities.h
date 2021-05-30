/*
	File:		WindowUtilities.h

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

#ifndef __WINDOWUTILITIES__
#define __WINDOWUTILITIES__

#ifndef IntToFixed
#define IntToFixed(a)	   ((Fixed)(a) << 16)
#endif

#ifndef ff
#define ff(a)			   IntToFixed(a)
#endif

typedef struct
	{
	long sampleKind;						// to identify the kind of sample (1..8)
	void *privateData;						// some storage

	UniCharArrayPtr theUnicodeText;			// the Text in Unicode
	UniCharCount uTextLength;				// its length
	ATSUTextMeasurement xLocation;			// where it starts drawing at x
	ATSUTextMeasurement yLocation;			//                        and y
	ATSUTextMeasurement maxAscent;			// maximum ascent for the whole text
	ATSUTextMeasurement maxDescent;			// maximum descent for the whole text
	ATSUTextMeasurement lineHeight;			// its line height (maxAscent + maxDescent)
	ItemCount numberOfLines;				// number of lines to draw
	UniCharArrayOffset*	endOfLines;			// positions of the end of line breaks
	ItemCount numberOfRuns;					// number of style runs
	UniCharCount *runLengths;				// array of the lengths of each style run
	ATSUStyle *styles;						// array of styles
	ATSUTextLayout textLayout;				// the resulting text layout
	} WindowData, *WindowDataPtr;

Boolean IsThisAqua();

WindowDataPtr GetWindowData(WindowPtr theWind);
WindowDataPtr DefaultWindowDataPtr();
void DisposeWindowDataPtr(WindowDataPtr wdataP);

ATSUFontID GetFontIDFromMacFontName(Str255 fontName);
void TryToSetFontTo(ATSUStyle theStyle, Str255 fontName);

#endif

/*
	File:		Utilities.c

	Contains:	utility code for NavSample

	Version:	1.4

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

	Copyright © 1996-2001 Apple Computer, Inc., All Rights Reserved
*/


//#include "NavSampleHeader.h"
#ifdef __APPLE_CC__
#include <Carbon/Carbon.h>
#else
#include <TextEdit.h>
#include <TextUtils.h>
#include <Scrap.h>
#endif

short myTECut( TEHandle theTE );
short myTEPaste( TEHandle theTE, short* spaceBefore, short* spaceAfter );
short TEIsFrontOfLine( short offset, TEHandle theTE );
short TEGetLine( short offset, TEHandle theTE );


// *****************************************************************************
// *
// *	myTECut( )
// *
// *****************************************************************************
short myTECut( TEHandle theTE )
{	
	OffsetTable	startOffsets;
	OffsetTable	endOffsets;
	short		selStart, selEnd, characters;
	Handle		theScrap;

	if (!(characters = (**theTE).selStart - (**theTE).selEnd))
		return 0;
		
	FindWordBreaks( *((**theTE).hText), (**theTE).teLength, (**theTE).selStart, true, 0L, startOffsets, smSystemScript);
	FindWordBreaks( *((**theTE).hText), (**theTE).teLength, (**theTE).selEnd, false, 0L, endOffsets, smSystemScript );

	if ((startOffsets[0].offFirst == (**theTE).selStart) &&
		(endOffsets[0].offSecond  == (**theTE).selEnd))
	{
		// both the beginning and end of the current selection is on word boundaries
		selStart = (**theTE).selStart;
		selEnd = (**theTE).selEnd;
		if ((*((**theTE).hText))[selStart - 1] == ' ')
		{
			TESetSelect(selStart - 1,selEnd,theTE);
			TECut(theTE);
			theScrap = TEScrapHandle();
			BlockMove((char*)(*theScrap) + 1,(*theScrap),TEGetScrapLength() - 1);
			TESetScrapLength(TEGetScrapLength() - 1);
#if TARGET_API_MAC_CARBON
			ClearCurrentScrap( );
#else
			ZeroScrap( );
#endif
			TEToScrap( );
			characters--;
		}
		else
			if ((*((**theTE).hText))[selEnd] == ' ')
			{
				TESetSelect(selStart,selEnd + 1,theTE);
				TECut(theTE);
				TESetScrapLength(TEGetScrapLength() - 1);
#if TARGET_API_MAC_CARBON
				ClearCurrentScrap( );
#else
				ZeroScrap( );
#endif
				TEToScrap();
				characters--;
			}
			else
				TECut(theTE);
	}
	else
		TECut(theTE);

	return characters;
}


// *****************************************************************************
// *
// *	myTEPaste( )
// *
// *****************************************************************************
short myTEPaste( TEHandle theTE, short* spaceBefore, short* spaceAfter )
{	
	OffsetTable	startOffsets;
	OffsetTable	endOffsets;
	short		addSpaceAfter;
	short		characters;

	characters = (**theTE).selStart - (**theTE).selEnd;

	if (spaceBefore)
		*spaceBefore = false;
	if (spaceAfter)
		*spaceAfter = false;

	FindWordBreaks( *((**theTE).hText), (**theTE).teLength, (**theTE).selStart, false, 0L, startOffsets, smSystemScript );
	FindWordBreaks( *((**theTE).hText), (**theTE).teLength, (**theTE).selEnd, true, 0L, endOffsets, smSystemScript );

	addSpaceAfter = ((endOffsets[0].offFirst == (**theTE).selEnd) && ((*((**theTE).hText))[(**theTE).selEnd] != ' '));

	if ((startOffsets[0].offSecond == (**theTE).selStart) && ((*((**theTE).hText))[(**theTE).selStart - 1] != ' '))
	{
		TEKey(' ',theTE);
		characters++;
		if (spaceBefore)
			*spaceBefore = true;
	}

	TEPaste(theTE);
	characters += TEGetScrapLength();

	if (addSpaceAfter)
	{
		TEKey(' ',theTE);
		characters++;
		if (spaceAfter)
			*spaceAfter = true;
	}
		
	return characters;
}


// *****************************************************************************
// *
// *	TEIsFrontOfLine( )
// *
// *****************************************************************************
short TEIsFrontOfLine( short offset, TEHandle theTE )
{	
	short line = 0;

	if ((**theTE).teLength == 0)
		return(true);

	if (offset >= (**theTE).teLength)
		return ((*((**theTE).hText))[(**theTE).teLength - 1] == 0x0d);

	while ((**theTE).lineStarts[line] < offset)
		line++;

	return ((**theTE).lineStarts[line] == offset);
}


// *****************************************************************************
// *
// *	TEGetLine( )
// *
// *****************************************************************************
short TEGetLine( short offset, TEHandle theTE )
{
	short line = 0;

	if (offset > (**theTE).teLength)
		return((**theTE).nLines);

	while ((**theTE).lineStarts[line] < offset)
		line++;
	
	return line;
}

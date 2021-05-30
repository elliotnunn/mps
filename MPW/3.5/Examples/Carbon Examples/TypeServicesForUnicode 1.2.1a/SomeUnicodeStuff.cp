/*
	File:		SomeUnicodeStuff.cp

	Description:Since the purpose of the TypeServicesForUnicode Sample Application is to
				demonstrate the use of Apple Text Services For Unicode Imaging technology
				introduced in Mac OS 8.5, and since we need Unicode text to display,
				the purpose of this header and source code is to deal with this Unicode text.

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

#include <Memory.h>
#include <TextEncodingConverter.h>

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

char * MyStrCpy(char * buf, char * str);
char * MyStrCpy(char * buf, char * str)
	{
	char *p, *q;
	for (p=buf, q=str; *q; *p++ = *q++) {};
	*p = *q;
	return buf;
	}

long MyStrLen(char * str);
long MyStrLen(char * str)
	{
	long result = 0;
	char *p;
	for (p=str; *p; p++, result++) {};
	return result;
	}

char * MyStrCat(char * buf, char * str);
char * MyStrCat(char * buf, char * str)
	{
	char *p, *q;
	for (p=buf; *p; p++) {};
	for (q=str; *q; *p++ = *q++) {};
	*p = *q;
	return buf;
	}

void QuickAndDirtySetUnicodeTextFromASCII_C_Chars(long whichText, UniCharArrayPtr *ucap, UniCharCount *ucc)
	{
	char *someText;
	switch (whichText)
		{
		case kHelloWorldUnicodeText:
			someText = "Hello World!";
			break;

		case kSomeLongerUnicodeText:
			someText = "This is a much longer text so that we can apply some styles!";
			//         "123456789012345678901234567890123456789012345678901234567890"
			break;

		case kSomeVeryLongUnicodeText:
			{
			// let's use some very long text
			// notice the single \n at the end of sentence1 and the double \n at the end of sentence5

			//                 "                                                                                                    1                                                                                                   2                                       ";
			//                 "0         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2         3         ";
			//                 "012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789";
			char sentence1[] = "This chapter provides an overview of Apple Type Services for Unicode™ Imaging (ATSUI), an enhancement of QuickDraw that enables your application to do direct Unicode drawing with support for full multilingual text and advanced typography.\n";
			char sentence2[] = "The basic intent of ATSUI is to provide the ability to use Unicode text directly in a QuickDraw-based application. ";
			char sentence3[] = "Unlike QuickDraw GX, ATSUI can only be used to draw Unicode. ";
			char sentence4[] = "This simplifies the interface and implementation and provides for the greatest flexibility at the least expense. ";
			char sentence5[] = "ATSUI also provides more extensive ancillary support for text-drawing, such as word- and line-breaking functions.\n\n";
			char sentence6[] = "In addition to providing support for low-end Unicode drawing, ATSUI also provides access to advanced typography features. ";
			char sentence7[] = "It enables font designers to build stylistic sophistication like swash variants and arbitrary ligatures.";
			char bigbuffer[3000];
			MyStrCpy(bigbuffer, sentence1);
			MyStrCat(bigbuffer, sentence2);
			MyStrCat(bigbuffer, sentence3);
			MyStrCat(bigbuffer, sentence4);
			MyStrCat(bigbuffer, sentence5);
			MyStrCat(bigbuffer, sentence6);
			MyStrCat(bigbuffer, sentence7);
			someText = bigbuffer;
			}
			break;

		case kSomeMixedUnicodeText:
			{
			// sentence2 will contain some Right-to-left text
			char sentence1[] = "This chapter provides an overview of Apple Type Services for Unicode™ Imaging (ATSUI), an enhancement of QuickDraw that enables your application to do direct Unicode drawing with support for full multilingual text and advanced typography.\n";
			char sentence2[] = "The ~basic intent of ATSUI is to provide~ the ability to use Unicode text directly in a QuickDraw-based application. ";
			char sentence3[] = "Unlike QuickDraw GX, ATSUI can only be used to draw Unicode. ";
			char sentence4[] = "This simplifies the interface and implementation and provides for the greatest flexibility at the least expense. ";
			char sentence5[] = "ATSUI also provides more extensive ancillary support for text-drawing, such as word- and line-breaking functions.\n";
			char sentence6[] = "In addition to providing support for low-end Unicode drawing, ATSUI also provides access to advanced typography features. ";
			char sentence7[] = "It enables font designers to build stylistic sophistication like swash variants and arbitrary ligatures.\n\n";
			char sentence8[] = "The ‘--’ and ‘++’ buttons decrease and increase the text sizes. The ‘Home’ button moves the caret to the start of the text without any selection.";
			char sentence9[] = "The ‘Move to previous word’ and ‘Move to next word’ buttons move the left-edge of the 30-characters selection by one Unicode Word. The ‘Hilight next 30’ button moves the selection by 30 characters.";
			char bigbuffer[3000];
			MyStrCpy(bigbuffer, sentence1);
			MyStrCat(bigbuffer, sentence2);
			MyStrCat(bigbuffer, sentence3);
			MyStrCat(bigbuffer, sentence4);
			MyStrCat(bigbuffer, sentence5);
			MyStrCat(bigbuffer, sentence6);
			MyStrCat(bigbuffer, sentence7);
			MyStrCat(bigbuffer, sentence8);
			MyStrCat(bigbuffer, sentence9);
			someText = bigbuffer;
			}
			break;

		case kSomeOtherMixedUnicodeText:
			{
			// sentence 8 contains runs of blanks and of punctuation to test the double-clicking
			char sentence1[] = "This chapter provides an overview of Apple Type Services for Unicode™ Imaging (ATSUI), an enhancement of QuickDraw that enables your application to do direct Unicode drawing with support for full multilingual text and advanced typography.\n";
			char sentence2[] = "The ~basic intent of ATSUI is to provide~ the ability to use Unicode text directly in a QuickDraw-based application. ";
			char sentence3[] = "Unlike QuickDraw GX, ATSUI can only be used to draw Unicode. ";
			char sentence4[] = "This simplifies the interface and implementation and provides for the greatest flexibility at the least expense. ";
			char sentence5[] = "ATSUI also provides more extensive ancillary support for text-drawing, such as word- and line-breaking functions.\n\n";
			char sentence6[] = "In addition to providing support for low-end Unicode drawing, ATSUI also provides access to advanced typography features. ";
			char sentence7[] = "It enables font designers to build stylistic sophistication like swash variants and arbitrary ligatures.\n\n";
			char sentence8[] = "This last sentence is there to [hit-]test the double-clicking with runs of blanks:     or of punctuation ,.;:.";
			char bigbuffer[3000];
			MyStrCpy(bigbuffer, sentence1);
			MyStrCat(bigbuffer, sentence2);
			MyStrCat(bigbuffer, sentence3);
			MyStrCat(bigbuffer, sentence4);
			MyStrCat(bigbuffer, sentence5);
			MyStrCat(bigbuffer, sentence6);
			MyStrCat(bigbuffer, sentence7);
			MyStrCat(bigbuffer, sentence8);
			someText = bigbuffer;
			}
			break;

		case kNothingUnicodeText:
			someText = "Nothing in Clipboard!";
			break;

		case kSomeMixedAgainUnicodeText:
			{
			char sentence1[] = "This chapter provides an overview of Apple Type Services for Unicode™ Imaging (ATSUI), an enhancement of QuickDraw that enables your application to do direct Unicode drawing with support for full multilingual text and advanced typography.\n";
			char sentence2[] = "The ~basic intent of ATSUI is to provide~ the ability to use Unicode text directly in a QuickDraw-based application. ";
			char sentence3[] = "Unlike QuickDraw GX, ATSUI can only be used to draw Unicode. ";
			char sentence4[] = "This simplifies the interface and implementation and provides for the greatest flexibility at the least expense. ";
			char sentence5[] = "ATSUI also provides more extensive ancillary support for text-drawing, such as word- and line-breaking functions.\n\n";
			char sentence6[] = "In addition to providing support for low-end Unicode drawing, ATSUI also provides access to advanced typography features. ";
			char sentence7[] = "It enables font designers to build stylistic sophistication like swash variants and arbitrary ligatures.";
			char bigbuffer[3000];
			MyStrCpy(bigbuffer, sentence1);
			MyStrCat(bigbuffer, sentence2);
			MyStrCat(bigbuffer, sentence3);
			MyStrCat(bigbuffer, sentence4);
			MyStrCat(bigbuffer, sentence5);
			MyStrCat(bigbuffer, sentence6);
			MyStrCat(bigbuffer, sentence7);
			someText = bigbuffer;
			}
			break;
		}
	
	TECObjectRef ec;
	OSStatus status = TECCreateConverter(&ec, kTextEncodingMacRoman, kTextEncodingUnicodeDefault);
	if (status != noErr) DebugStr("\p TECCreateConverter failed");
	ByteCount ail, aol, iLen = MyStrLen(someText), oLen = 2 * iLen;
	Ptr buffer = NewPtr(oLen);
	status = TECConvertText(ec, (ConstTextPtr)someText, iLen, &ail, (TextPtr)buffer, oLen, &aol);
	if (status != noErr) DebugStr("\p TECConvertText failed");
	status = TECDisposeConverter(ec);
	if (status != noErr) DebugStr("\p TECDisposeConverter failed");
	*ucap = (UniCharArrayPtr)NewPtr(aol);
	BlockMove(buffer, (*ucap), aol);
	DisposePtr(buffer);
	*ucc = aol / 2;

	switch (whichText)
		{
		case kSomeMixedUnicodeText:
		case kSomeOtherMixedUnicodeText:
		case kSomeMixedAgainUnicodeText:
			(*ucap)[243] = 0x202E; // Right-To-Left Override in Unicode.
			(*ucap)[279] = 0x202C; // Pop Directional Formatting in Unicode.
			break;
		}
	}

void QuickAndDirtySetASCII_C_CharsFromUnicodeText(char **text, UniCharArrayPtr ucap, UniCharCount ucc)
	{
	ByteCount ail, aol, bigLength = 2 * ucc;
	Ptr buffer = NewPtr(bigLength);
	TECObjectRef ec;
	OSStatus status = TECCreateConverter(&ec, kTextEncodingUnicodeDefault, kTextEncodingMacRoman);
	if (status != noErr) DebugStr("\p TECCreateConverter failed");
	status = TECConvertText(ec, (ConstTextPtr)ucap, bigLength, &ail, (TextPtr)buffer, bigLength, &aol);
	if (status != noErr) DebugStr("\p TECConvertText failed");
	status = TECDisposeConverter(ec);
	if (status != noErr) DebugStr("\p TECDisposeConverter failed");
	*text = (char *)NewPtr(aol);
	BlockMove(buffer, (*text), aol);
	DisposePtr(buffer);
	}

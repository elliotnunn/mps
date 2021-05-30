/*
	File:		SomeUnicodeStuff.h

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
#ifndef __SOMEUNICODESTUFF__
#define __SOMEUNICODESTUFF__

#ifdef __MWERKS__

// includes for MetroWerks CodeWarrior

#include <ATSUnicode.h>

#endif

enum {
	kHelloWorldUnicodeText		= 0,
	kSomeLongerUnicodeText		= 1,
	kSomeVeryLongUnicodeText	= 2,
	kSomeMixedUnicodeText		= 3,
	kSomeOtherMixedUnicodeText	= 4,
	kNothingUnicodeText			= 5,
	kSomeMixedAgainUnicodeText	= 6
};

extern Boolean gHasLineControlFeature;

void QuickAndDirtySetUnicodeTextFromASCII_C_Chars(long whichText, UniCharArrayPtr *ucap, UniCharCount *ucc);
void QuickAndDirtySetASCII_C_CharsFromUnicodeText(char **text, UniCharArrayPtr ucap, UniCharCount ucc);

#endif

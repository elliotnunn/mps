/*
    File: MLTEUserPane.h
    
    Description:
        This file contains constant declarations and exported routine prototypes
	used in the MLTEUserPane application.
	
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

	Copyright © 2000-2001 Apple Computer, Inc., All Rights Reserved
*/

#ifndef __MLTEUserPane__
#define __MLTEUserPane__

#ifdef __APPLE_CC__
#include <Carbon/Carbon.h>
#else
#include <Carbon.h>
#endif

	/* the resource ID of the main menu bar list. */
enum {
	kMenuBarID = 128
};

	/* the resource id of the main string list */
enum {
	kMainStringList = 128,
	kNavMessageString = 1
};

	/* constants referring to the apple menu */
enum {
	mApple = 128,
	iAbout = 1
};

	/* constants referring to the file menu */
enum {
	mFile = 129,
	iQuit = 1
};

	/* constants referring to the edit menu */
enum {
	mEdit = 130,
	iUndo = 1,
	iCut = 3,
	iCopy = 4,
	iPaste = 5,
	iClear = 6
};

	/* resource ID numbers for alerts that are called
	to report different error conditions. */
enum {
	kAboutBoxAlert = 129
};

	/* resource ID numbers for alerts that are called
	to report different error conditions. */
enum {
	kMainDialogBox = 128,
	kEditItemOne = 2,
	kEditItemTwo = 3,
	kEditItemThree = 4
};
	/* 'STUP' resource ID's used for filling text
	in the edit items displayed in the main dialog box. */
enum {
	kEditItemOneText = 128,
	kEditItemTwoText = 129,
	kEditItemThreeText = 130
};


/* ParamAlert is a general alert handling routine.  If Apple events exist, then it
	calls AEInteractWithUser to ensure the application is in the forground, and then
	it displays an alert after passing the s1 and s2 parameters to ParamText. */
short ParamAlert(short alertID, StringPtr s1, StringPtr s2);


/* HandleEvent is the main event handling routine for the
	application.  ev points to an event record returned by
	WaitNextEvent. */
void HandleEvent(EventRecord *ev);

#endif

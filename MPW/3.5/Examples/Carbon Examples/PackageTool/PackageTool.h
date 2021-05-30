/*
    File: PackageTool.h
    
    Description:
        PackageTool is an application illustrating how to create application
	packages in Mac OS 9.  It provides a simple interface for converting
	correctly formatted folders into packages and vice versa.

    Copyright:
        © Copyright 1999 Apple Computer, Inc. All rights reserved.
    
    Disclaimer:
        IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
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
        Fri, Dec 17, 1999 -- created
*/


#ifndef __PACKAGETOOL__
#define __PACKAGETOOL__

#ifndef __CARBON__
#include <Carbon.h>
#endif

//#include <MacTypes.h>
//#include <Events.h>
//#include <AppleEvents.h>
//#include <Collections.h>

enum {
	kAppCreatorType = 'pTeZ',
	kAppPrefsType = 'PREF'
	
};

	/* apple menu constants */
enum {
	mApple = 128,
	iAbout = 1,
	iFirstAppleItem = 3
};

	/* file menu constants */
enum {
	mFile = 129,
	iSelect = 1,
	iQuit = 3
};

	/* edit menu constants */
enum {
	mEdit = 130,
	iUndo = 1,
	iCut = 3,
	iCopy = 4,
	iPaste = 5,
	iClear = 6
};

enum {	/* the main menu bar resource */
	kMenuBarResource = 128
};

	/* alert id numbers */
enum {
	kPackageDidNotVerify = 129,
	kFailedToCreatePackage = 130,
	kOpenAppFailedAlert = 135,
	kMainFailedAlert = 136,
	kAboutBoxAlert = 137,
	kRerouteFailedAlert = 138,
	kGenericAlert = 139
};

	/* main string list resource constants */
enum {
	kMainStringList = 128,
	kNotAFolder = 1,
	kBundleAlreadySet = 2,
	kBrokenAlias = 3,
	kMoreThanOneAlias = 4,
	kMainOutsideOfPackage = 6,
	kNoAliasPresent = 7,
	kInSameDirectory = 8,
	kFileSharingOn = 9,
	kAliasRefersToPackage = 10,
	kAliasRedirectFolderName = 11,
	kRedirectAliasName = 12,
	kErrorRedirectingAlias = 13,
	kMustHaveOS9 = 14,
	kAliasRefersToFolder = 15,
	kAliasOutsideOfPackage = 16
};

	
/* routine prototypes */

/* ParamAlert is a general alert handling routine. It calls AEInteractWithUser
	to ensure the application is in the forground, and then it displays an alert
	after passing the s1 and s2 parameters to ParamText. */
OSStatus ParamAlert(short alertID, StringPtr s1, StringPtr s2);


/* GetCollectedPreferences returns the collection that is used for storing
	application preferences. */
Collection GetCollectedPreferences(void);


/* HandleNextEvent handles the event in the event record *ev dispatching
	the event to appropriate routines.   */
void HandleNextEvent(EventRecord *ev);


/* IsFrontProcess returns true when our
	application is the frontmost process. */
Boolean IsFrontProcess(void);


/* OpenDocumentList is called when the application receives a document a list of
	documents to open.  */
OSErr OpenDocumentList(AEDescList *documents);

#endif

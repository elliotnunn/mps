/*
	File:		CallMachOFramework.c

	Contains:	Sample showing how to call Mach-O frameworks from CFM.

	Written by:	Quinn

	Copyright:	Copyright © 2001 by Apple Computer, Inc., All Rights Reserved.

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

*/

#include "MoreSetup.h"
#include "CFMLateImport.h"

#ifdef __MRC__
#include <MacTypes.h>
#include <CFBundle.h>
#include <Gestalt.h>
#include <Folders.h>
#endif

#include <stdio.h>

// Start of stuff stolen from "unistd.h".

int      gethostname(char *, int);

// End of stuff stolen from "unistd.h".

#if !defined(USE_CFM_LATE_IMPORT)
	#error You must define USE_CFM_LATE_IMPORT one way or the other.
#endif

#if USE_CFM_LATE_IMPORT

	static CFragConnectionID 			gFragToFixConnID;
	static FSSpec 						gFragToFixFile;
	static CFragSystem7DiskFlatLocator 	gFragToFixLocator;

	extern OSErr FragmentInit(const CFragInitBlock *initBlock);
	extern OSErr FragmentInit(const CFragInitBlock *initBlock)
	{
		MoreAssertQ(initBlock->fragLocator.where == kDataForkCFragLocator);
		gFragToFixConnID	= (CFragConnectionID) initBlock->closureID;
		gFragToFixFile 		= *(initBlock->fragLocator.u.onDisk.fileSpec);
		gFragToFixLocator 	= initBlock->fragLocator.u.onDisk;
		gFragToFixLocator.fileSpec = &gFragToFixFile;
		
		return noErr;
	}

	extern void DummyExport(void);
	#pragma export list DummyExport
	extern void DummyExport(void)
	{
	}

#else

	typedef int (*gethostnamePtr)(char *, int);

#endif

#if UNIVERSAL_INTERFACES_VERSION < 0x0335

	// These definitions were stolen from Universal Interfaces 3.4a6.
	// The sample currently compiles with UI 3.3.2.  If you upgrade 
	// your development environment to a later UI, you can remove them.

	enum {
	  kOnAppropriateDisk            = -32767 /* Generally, the same as kOnSystemDisk, but it's clearer that this isn't always the 'boot' disk.*/
	                                        /* Folder Domains - Carbon only.  The constants above can continue to be used, but the folder/volume returned will*/
	                                        /* be from one of the domains below.*/
	};

	enum {
		kFrameworksFolderType = FOUR_CHAR_CODE('fram') /* Contains MacOS X Framework folders     */
	};

	/*
	 *  FSFindFolder()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available in InterfaceLib 9.1 and later
	 *    CarbonLib:        available in CarbonLib 1.1 and later
	 *    Mac OS X:         available
	 */
	EXTERN_API( OSErr )
	FSFindFolder( 
	  short                   vRefNum,
	  OSType                  folderType,
	  Boolean                 createFolder,
	  FSRef *                 foundRef)                           TWOWORDINLINE(0x7034, 0xA823);

	/*
	 *  CFURLCreateFromFSRef()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        available in CarbonLib 1.1 and later
	 *    Mac OS X:         available
	 */
	EXTERN_API_C( CFURLRef )
	CFURLCreateFromFSRef( 
	  CFAllocatorRef          allocator,
	  const FSRef *           fsRef);

	/* These functions all treat the base URL of the supplied url as */
	/* invariant.  In other words, the URL returned will always have */
	/* the same base as the URL supplied as an argument. */
	/*
	 *  CFURLCreateCopyAppendingPathComponent()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        available in CarbonLib 1.1 and later
	 *    Mac OS X:         available
	 */
	EXTERN_API_C( CFURLRef )
	CFURLCreateCopyAppendingPathComponent( 
	  CFAllocatorRef          allocator,
	  CFURLRef                url,
	  CFStringRef             pathComponent,
	  Boolean                 isDirectory);

#endif

static Boolean RunningOnCarbonX(void)
{
    UInt32 response;
    
    return (Gestalt(gestaltSystemVersion, 
                    (SInt32 *) &response) == noErr)
                && (response >= 0x01000);
}

static OSStatus LoadFrameworkBundle(CFStringRef framework, CFBundleRef *bundlePtr)
{
	OSStatus 	err;
	FSRef 		frameworksFolderRef;
	CFURLRef	baseURL;
	CFURLRef	bundleURL;
	
	MoreAssertQ(bundlePtr != nil);
	
	*bundlePtr = nil;
	
	baseURL = nil;
	bundleURL = nil;
	
	err = FSFindFolder(kOnAppropriateDisk, kFrameworksFolderType, true, &frameworksFolderRef);
	if (err == noErr) {
		baseURL = CFURLCreateFromFSRef(kCFAllocatorSystemDefault, &frameworksFolderRef);
		if (baseURL == nil) {
			err = coreFoundationUnknownErr;
		}
	}
	if (err == noErr) {
		bundleURL = CFURLCreateCopyAppendingPathComponent(kCFAllocatorSystemDefault, baseURL, framework, false);
		if (bundleURL == nil) {
			err = coreFoundationUnknownErr;
		}
	}
	if (err == noErr) {
		*bundlePtr = CFBundleCreate(kCFAllocatorSystemDefault, bundleURL);
		if (*bundlePtr == nil) {
			err = coreFoundationUnknownErr;
		}
	}
	if (err == noErr) {
	    if ( ! CFBundleLoadExecutable( *bundlePtr ) ) {
			err = coreFoundationUnknownErr;
	    }
	}

	// Clean up.
	
	if (err != noErr && *bundlePtr != nil) {
		CFRelease(*bundlePtr);
		*bundlePtr = nil;
	}
	if (bundleURL != nil) {
		CFRelease(bundleURL);
	}	
	if (baseURL != nil) {
		CFRelease(baseURL);
	}	
	
	return err;
}

void main(void)
{
	OSStatus 			err;
	CFBundleRef 		sysBundle;
	char				hostname[256];
	
	printf("Hello Cruel World!\n");
	printf("Standard.c\n");
	
	err = noErr;
	if ( ! RunningOnCarbonX() ) {
		printf("It does not make sense to run this sample on traditional Mac OS.\n");
		err = -1;
	}
	if (err == noErr) {
		err = LoadFrameworkBundle(CFSTR("System.framework"), &sysBundle);
	}
	if (err == noErr) {
		#if USE_CFM_LATE_IMPORT
			MoreAssertQ( (void *) gethostname == (void *) kUnresolvedCFragSymbolAddress );
	
			err = CFMLateImportBundle(&gFragToFixLocator, gFragToFixConnID, "\pDummyExport", "\pSystemFrameworkLib", sysBundle);
			if (err == noErr) {
				err = gethostname(hostname, sizeof(hostname));
			}
		#else
			{
				gethostnamePtr ghnPtr;

				ghnPtr = (gethostnamePtr) CFBundleGetFunctionPointerForName( sysBundle, CFSTR("gethostname") );
				if (ghnPtr == nil) {
					err = cfragNoSymbolErr;
				}
			
				if (err == noErr) {
					err = ghnPtr(hostname, sizeof(hostname));
				}
			}
		#endif
	}

	if (err == noErr) {	
		printf("hostname = %s\n", hostname);
	}

	if (err == noErr) {
		printf("Success.\n");
	} else {
		printf("Failed with error %d.\n", err);
	}
	
	printf("Done.  Press command-Q to Quit.\n");
}

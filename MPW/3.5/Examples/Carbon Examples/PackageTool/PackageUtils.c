/*
    File: PackageUtils.c
    
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



#include "PackageUtils.h"
//#include <Aliases.h>

/* IdentifyPackage returns true if the file system object refered to
	by *target refers to a package.  If it is a package, then 
	*mainPackageFile is set to refer to the package's main file. */
Boolean IdentifyPackage(FSSpec *target, FSSpec *mainPackageFile) {
	CInfoPBRec cat;
	OSErr err;
	long packageFolderDirID;
	Str255 name;
	FSSpec aliasFile;
	Boolean targetIsFolder, wasAliased;
		/* check the target's flags */
	cat.dirInfo.ioNamePtr = target->name;
	cat.dirInfo.ioVRefNum = target->vRefNum;
	cat.dirInfo.ioFDirIndex = 0;
	cat.dirInfo.ioDrDirID = target->parID;
	err = PBGetCatInfoSync(&cat);
	if (err != noErr) return false;
	if (((cat.dirInfo.ioFlAttrib & 16) != 0) && ((cat.dirInfo.ioDrUsrWds.frFlags & kHasBundle) != 0)) {
			/* search for a top level alias file */
		packageFolderDirID = cat.dirInfo.ioDrDirID;
		cat.dirInfo.ioNamePtr = name;
		cat.dirInfo.ioVRefNum = target->vRefNum;
		cat.dirInfo.ioFDirIndex = 1;
		cat.dirInfo.ioDrDirID = packageFolderDirID;
			/* find the first alias file in the directory */
		while (PBGetCatInfoSync(&cat) == noErr) {
			if (((cat.dirInfo.ioFlAttrib & 16) == 0) && ((cat.dirInfo.ioDrUsrWds.frFlags & kIsAlias) != 0)) {
				err = FSMakeFSSpec(target->vRefNum, packageFolderDirID, name, &aliasFile);
				if (err != noErr) return false;
				err = ResolveAliasFile(&aliasFile, false, &targetIsFolder, &wasAliased);
				if (err != noErr) return false;
				if (mainPackageFile != NULL)
					*mainPackageFile = aliasFile;
				return true;
			}
			cat.dirInfo.ioFDirIndex++;
			cat.dirInfo.ioDrDirID = packageFolderDirID;
		}
	}
		/* no matching files found */
	return false;
}


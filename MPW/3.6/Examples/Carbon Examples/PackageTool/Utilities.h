/*
    File: Utilities.h
    
    Description:
        This file contains a number of utility routines used in the
	PackageTool application.  these routines have been moved here
	to simplify the example.
	
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


#ifndef __UTILITIES__
#define __UTILITIES__

#ifndef __CARBON__
#include <Carbon.h>
#endif

//#include <MacTypes.h>
//#include <Files.h>
//#include <Aliases.h>
//#include <Drag.h>
//#include <Icons.h>
//#include <QDOffscreen.h>
//#include <Script.h>


/* ValidFSSpec verifies that *spec refers is formatted correctly, and it
	verifies that it refers to an existing file in an existing directory on
	and existing volume. If *spec is valid, the function returns noErr,
	otherwise an error is returned. */
OSErr ValidFSSpec(FSSpec *spec);


/* ResolveAliasQuietly resolves an alias using a fast search with no user interaction.  Our main loop
	periodically resolves gFileAlias comparing the result to gTargetFile to keep the display up to date.
	As a result, we would like the resolve alias call to be as quick as possible AND since the application
	may be in the background when  it is called, we don't want any user interaction. */
OSErr ResolveAliasQuietly(ConstFSSpecPtr fromFile, AliasHandle alias, FSSpec *target, Boolean *wasChanged);


/* GrayOutBox grays out an area of the screen in the current grafport.  
	*theBox is in local coordinates in the current grafport. This routine
	is for direct screen drawing only.  */
void GrayOutBox(Rect *theBox);


/* ShowDragHiliteBox is called to hilite the drop box area in the
	main window.  Here, we draw a 3 pixel wide border around *boxBounds.  */
OSErr ShowDragHiliteBox(DragReference theDragRef, Rect *boxBounds);


/* FSpGetDirID returns the directory ID number for the directory
	pointed to by the file specification record *spec.  */
OSErr FSpGetDirID(FSSpec *spec, long *theDirID);


/* UpdateRelativeAliasFile updates the alias file located at
     aliasDest referring to the targetFile.  relative path
     information is stored in the new file. */
OSErr UpdateRelativeAliasFile(FSSpec *theAliasFile, FSSpec *targetFile, Boolean createIfNecessary);


/* FileSharingAppIsRunning returns true if the file sharing
	extension is running. */
Boolean FileSharingAppIsRunning(void);


/* FSSpecIsInDirectory returns true if the file system object
	referred to by theSpec is somewhere in the directory referred
	to by (vRefNum, dirID) */
Boolean FSSpecIsInDirectory(FSSpec *theSpec, short vRefNum, long dirID);


/* FSSpecIsAFolder returns true if the FSSpec pointed
	to by target refers to a folder. */
Boolean FSSpecIsAFolder(FSSpec *target);


/* ShowChangesInFinderWindow asks the finder redraw a directory
	window by either sending a update container event to the
	finder if this facility exists, or by bumping the parent directorie's
	modification date */
OSErr ShowChangesInFinderWindow(short vRefNum, long dirID);


/* NavReplyToODOCList converts a document list returned by a Navigation Services
	dialog into a document list structure that is the same format as the one
	the system sends to your application's open document Apple event handler
	routine.  Replies returned by Navigation Services may contain special
	references to folders that may be incompatible with some document opening
	strategies or routines.  By converting navigation replies into 'odoc' list
	format, your application only needs to implement one document opening
	routine that receives dcoument lists from both Apple events and navigation
	services.  NOTE:  this is really only an issue if your application is set
	up to open packages or folders. */
OSStatus NavReplyToODOCList(AEDescList *navReply, AEDescList *odocList);

#endif

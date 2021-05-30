/*
	file PackageWindow.h
	
	Description:
	This file contains routine declarations used for accessing the main
	window displayed by the PackageTool application.
	
	PackageTool is an application illustrating how to create application
	packages in Mac OS 9.  It provides a simple interface for converting
	correctly formatted folders into packages and vice versa.

	Copyright: © 1999 by Apple Computer, Inc.
	all rights reserved.
	
	Disclaimer:
	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "DSC Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.
	
	Change History (most recent first):
	10/19/99 created
*/


#ifndef __PACKAGEWINDOW__
#define __PACKAGEWINDOW__

#ifndef __CARBON__
#include <Carbon.h>
#endif

//#include <Types.h>
//#include <Files.h>
//#include <Windows.h>

/* CreatePackageWindow creates the package window.  If it cannot be
	created, then an error is returned. */
OSStatus CreatePackageWindow(void);


/* ClosePackageWindow closes the package window and disposes of
	any structures allocated when it was opened. */
void ClosePackageWindow(void);


/* SetNewDisplay is to set the display to a new package or folder.  If
	targetFile is NULL, then the display is cleared. */
void SetNewDisplay(FSSpec *targetFile);


/* IsPackageWindow returns true if the window pointed to by
	target is the package window. */
Boolean IsPackageWindow(WindowPtr target);


/* ActivatePackageWindow handles an activate event for the
	package window. */
void ActivatePackageWindow(WindowPtr target, Boolean activate);


/* HitPackageWindow should be called when DialogSelect indicates
	that an item in the package window has been hit. */
void HitPackageWindow(DialogPtr theDialog, EventRecord *event, short itemNo);


/* SelectFolderOrPackage provides user interaction through calling
	navigation services that allows the user to choose a package or
	a folder for display in the main window.   */
OSStatus SelectFolderOrPackage(void);

#endif

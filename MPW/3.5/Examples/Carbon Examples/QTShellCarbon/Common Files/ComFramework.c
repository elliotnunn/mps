/*

	File:		ComFramework.c

	Contains:	Code for the QuickTime sample code framework that is common to both Macintosh and Windows.

	Written by:	Tim Monroe
				Based on the QTShell code written by Tim Monroe, which in turn was based on the MovieShell
				code written by Kent Sandvik (Apple DTS). This current version is now very far removed from
				MovieShell.

	Change History (most recent first):
	   
	   <15>	 	03/02/00	rtm		made changes to get things running under CarbonLib
	   <14>	 	02/16/00	rtm		added QTFrame_GetWindowPtrFromWindowReference
	   <13>	 	01/19/00	rtm		revised QTFrame_IsAppWindow (dialog windows no longer count as application
									windows); added QTFrame_BuildFileTypeList and QTFrame_AddComponentFileTypes
									to avoid calling GetMovieImporterForDataRef in QTFrame_FilterFiles; removed
									the hard-coded file types
	   <12>	 	01/14/00	rtm		added support for graphics files, using graphics importers
	   <11>	 	12/28/99	rtm		added QTFrame_ConvertMacToWinRect and QTFrame_ConvertWinToMacRect
	   <10>	 	12/21/99	rtm		hard-coded some file types into QTFrame_FilterFiles; if we let QuickTime
									to do all the testing (using GetMovieImporterForDataRef), it takes too long
	   <9>	 	12/17/99	rtm		added some code to QTFrame_SetMenuItemState to work around a problem that
									appears under MacOS 8.5.1 (as far as I can tell...)
	   <8>	 	12/16/99	rtm		added QTApp_HandleMenu calls to _HandleFileMenuItem and _HandleEditMenuItem
									to allow the application-specific code to intercept menu item selections;
									added QTFrame_FilterFiles
	   <7>	 	12/15/99	rtm		added QTApp_Idle call to QTFrame_IdleMovieWindows
	   <6>	 	12/11/99	rtm		added GetMenuState call to Windows portion of QTFrame_SetMenuItemLabel;
									tweaked _SizeWindowToMovie to guard against NULL movie and/or controller
	   <5>	 	11/30/99	rtm		added QTFrame_CloseMovieWindows
	   <4>	 	11/27/99	rtm		added QTFrame_GetFileFilterUPP
	   <3>	 	11/17/99	rtm		finished support for Navigation Services; added QTFrame_IdleMovieWindows
	   <2>	 	11/16/99	rtm		begun support for Navigation Services
	   <1>	 	11/05/99	rtm		first file

	This file contains several kinds of functions: (1) functions that use completely cross-platform APIs and
	which therefore can be compiled and run for both Mac and Windows platforms with no changes whatsoever (a
	good example of this is QTFrame_SaveAsMovieFile); (2) functions that are substantially the same on both
	platforms but which require several short platform-dependent #ifdef TARGET_OS_ blocks (a good example of
	this is QTFrame_AdjustMenus); (3) functions that retrieve data from framework-specific data structures (a
	good example of this is QTFrame_GetWindowObjectFromWindow); (4) functions that provide a platform-neutral
	interface to platform-specific operations (a good example of this is QTFrame_Beep). In a nutshell, this
	file attempts to provide platform-independent services to its callers, typically functions in the files
	MacFramework.c, WinFramework.c, and ComApplication.c.

	In general, you should not need to modify this file. Your application-specific code should usually be put
	into the file ComApplication.c.

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
*/

//////////
//
// header files
//
//////////

#include "ComFramework.h"


//////////
//
// global variables
//
//////////

Rect					gMCResizeBounds;						// maximum size for any movie window
OSType 					*gValidFileTypes = NULL;				// the list of file types that our application can open

#if TARGET_OS_WIN32
extern HWND				ghWnd;
extern HWND				ghWndMDIClient;
extern BOOL				gWeAreSizingWindow;
#endif

#if TARGET_OS_MAC
extern Str255			gAppName;
void					QTFrame_HandleEvent (EventRecord *theEvent);
#endif


///////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Menu-handling functions.
//
// Use these functions to handle items in the File and Edit menus.
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////
//
// QTFrame_HandleFileMenuItem
// Handle the specified File menu item.
//
//////////

void QTFrame_HandleFileMenuItem (WindowReference theWindow, UInt16 theMenuItem)
{
	// give the application-specific code a chance to intercept the menu item selection
	if (QTApp_HandleMenu(theMenuItem))
		return;
		
	switch (theMenuItem) {
	
		case IDM_FILENEW:
			QTFrame_CreateNewMovie();
			break;

		case IDM_FILEOPEN:
			QTFrame_OpenMovieInWindow(NULL, NULL);
			break;

		case IDM_FILECLOSE:
			QTFrame_DestroyMovieWindow(theWindow);
			break;

		case IDM_FILESAVE:
			QTFrame_UpdateMovieFile(theWindow);
			break;

		case IDM_FILESAVEAS:
			QTFrame_SaveAsMovieFile(theWindow);
			break;
			
		case IDM_EXIT:
			QTFrame_QuitFramework();
			break;

		default:
			break;
	} // switch (theMenuItem)
	
}


//////////
//
// QTFrame_HandleEditMenuItem
// Perform the specified edit operation on the specified window.
//
//////////

void QTFrame_HandleEditMenuItem (WindowReference theWindow, UInt16 theMenuItem)
{
	WindowObject		myWindowObject = NULL;
	MovieController 	myMC = NULL;
	Movie			 	myEditMovie = NULL;				// the movie created by some editing operations
	
	// give the application-specific code a chance to intercept the menu item selection
	if (QTApp_HandleMenu(theMenuItem))
		return;
	
	myWindowObject = QTFrame_GetWindowObjectFromWindow(theWindow);
	myMC = QTFrame_GetMCFromWindow(theWindow);
	
	// make sure we have a valid movie controller and a valid window object
	if ((myMC == NULL) || (myWindowObject == NULL))
		return;

	switch (theMenuItem) {
	
		case IDM_EDITUNDO:
			MCUndo(myMC);
			(**myWindowObject).fIsDirty = true;
			break;

		case IDM_EDITCUT:
			myEditMovie = MCCut(myMC);
			(**myWindowObject).fIsDirty = true;
			break;

		case IDM_EDITCOPY:
			myEditMovie = MCCopy(myMC);
			break;

		case IDM_EDITPASTE:
			MCPaste(myMC, NULL);
			(**myWindowObject).fIsDirty = true;
			break;

		case IDM_EDITCLEAR:
			MCClear(myMC);
			(**myWindowObject).fIsDirty = true;
			break;
			
		case IDM_EDITSELECTALL:
			QTUtils_SelectAllMovie(myMC);
			break;

		case IDM_EDITSELECTNONE:
			QTUtils_SelectNoneMovie(myMC);
			break;

		default:
			break;
	} // switch (theMenuItem)
	
	// place any cut or copied movie segment onto the scrap
	if (myEditMovie != NULL) {
		PutMovieOnScrap(myEditMovie, 0L);
		DisposeMovie(myEditMovie);
	}
}


//////////
//
// QTFrame_AdjustMenus 
// Adjust the application's menus.
//
// On Windows, the theWindow parameter is a handle to the active MDI *child* window, if any.
// On Mac, the theWindow parameter is a pointer to the frontmost window, if any.
//
//////////

int QTFrame_AdjustMenus (WindowReference theWindow, MenuReference theMenu)
{
#if TARGET_OS_MAC
#pragma unused(theMenu)
#endif

	WindowObject		myWindowObject = NULL; 
	MovieController 	myMC = NULL;
	MenuReference		myMenu = NULL;
	
#if TARGET_OS_WIN32
	myMenu = theMenu;
#endif

	if (theWindow != NULL)
		myWindowObject = QTFrame_GetWindowObjectFromWindow(theWindow);

	if (myWindowObject != NULL)
		myMC = (**myWindowObject).fController;

	//////////
	//
	// configure the Edit menu
	//
	//////////
	
#if TARGET_OS_MAC
	myMenu = GetMenuHandle(kEditMenuResID);
#endif
	if (myMC != NULL) {
		long	myFlags;
		
		MCGetControllerInfo(myMC, &myFlags);
	
		QTFrame_SetMenuItemState(myMenu, IDM_EDITUNDO, myFlags & mcInfoUndoAvailable ? kEnableMenuItem : kDisableMenuItem);
		QTFrame_SetMenuItemState(myMenu, IDM_EDITCUT, myFlags & mcInfoCutAvailable ? kEnableMenuItem : kDisableMenuItem);
		QTFrame_SetMenuItemState(myMenu, IDM_EDITCOPY, myFlags & mcInfoCopyAvailable ? kEnableMenuItem : kDisableMenuItem);
		QTFrame_SetMenuItemState(myMenu, IDM_EDITPASTE, myFlags & mcInfoPasteAvailable ? kEnableMenuItem : kDisableMenuItem);
		QTFrame_SetMenuItemState(myMenu, IDM_EDITCLEAR, myFlags & mcInfoClearAvailable ? kEnableMenuItem : kDisableMenuItem);
		QTFrame_SetMenuItemState(myMenu, IDM_EDITSELECTALL, myFlags & mcInfoEditingEnabled ? kEnableMenuItem : kDisableMenuItem);
		QTFrame_SetMenuItemState(myMenu, IDM_EDITSELECTNONE, myFlags & mcInfoEditingEnabled ? kEnableMenuItem : kDisableMenuItem);
	} else {
		QTFrame_SetMenuItemState(myMenu, IDM_EDITUNDO, kDisableMenuItem);
		QTFrame_SetMenuItemState(myMenu, IDM_EDITCUT, kDisableMenuItem);
		QTFrame_SetMenuItemState(myMenu, IDM_EDITCOPY, kDisableMenuItem);
		QTFrame_SetMenuItemState(myMenu, IDM_EDITPASTE, kDisableMenuItem);
		QTFrame_SetMenuItemState(myMenu, IDM_EDITCLEAR, kDisableMenuItem);
		QTFrame_SetMenuItemState(myMenu, IDM_EDITSELECTALL, kDisableMenuItem);
		QTFrame_SetMenuItemState(myMenu, IDM_EDITSELECTNONE, kDisableMenuItem);
	}

	//////////
	//
	// configure the File menu
	//
	//////////
	
#if TARGET_OS_MAC
	myMenu = GetMenuHandle(kFileMenuResID);
#endif
	if (theWindow != NULL) {				// there is a window open
		// handle the Close command
		QTFrame_SetMenuItemState(myMenu, IDM_FILECLOSE, kEnableMenuItem);
		
		// handle the Save As and Save commands
		if (myWindowObject != NULL) {
			QTFrame_SetMenuItemState(myMenu, IDM_FILESAVEAS, kEnableMenuItem);
			QTFrame_SetMenuItemState(myMenu, IDM_FILESAVE, (**myWindowObject).fIsDirty ? kEnableMenuItem : kDisableMenuItem);
		} else {
			QTFrame_SetMenuItemState(myMenu, IDM_FILESAVEAS, kDisableMenuItem);
			QTFrame_SetMenuItemState(myMenu, IDM_FILESAVE, kDisableMenuItem);
		}
	
	} else {								// there is no window open	
		QTFrame_SetMenuItemState(myMenu, IDM_FILESAVE, kDisableMenuItem);
		QTFrame_SetMenuItemState(myMenu, IDM_FILESAVEAS, kDisableMenuItem);
		QTFrame_SetMenuItemState(myMenu, IDM_FILECLOSE, kDisableMenuItem);		
	}

	// adjust any application-specific menus
	QTApp_AdjustMenus(theWindow, theMenu);

	return(0);
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Movie-handling functions.
//
// Use these functions to create new movies, open existing movies, save movies, and so forth.
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////
//
// QTFrame_CreateNewMovie
// Create a new movie in a window; returns true if successful.
//
// NOTE: There are several user interface issues that are blissfully ignored by this routine,
// principally the preferred names and the on-screen locations of the new windows. 
//
//////////

Boolean QTFrame_CreateNewMovie (void)
{
	Movie				myMovie = NULL;
	FSSpec				myFSSpec;
	StringPtr 			myName = QTUtils_ConvertCToPascalString(kNewMovieName);
	
	myMovie = NewMovie(newMovieActive);
	if (myMovie == NULL)
		return(false);
	
	// create a default FSSpec
	FSMakeFSSpec(0, 0L, myName, &myFSSpec);
	
	free(myName);
	
	return(QTFrame_OpenMovieInWindow(myMovie, &myFSSpec));
}


//////////
//
// QTFrame_OpenMovieInWindow
// Open a movie in a new movie window; return true if successful.
//
// This function is called from several places in our framework. The following combinations are possible:
//	* theMovie == NULL, theFSSpec == NULL: no movie, no file; elicit a movie file from user and open it
//	* theMovie != NULL, theFSSpec == NULL: new movie, no file (yet)
//	* theMovie == NULL, theFSSpec != NULL: no movie, but we have an FSSpec; so just open the specified movie file
//	* theMovie != NULL, theFSSpec != NULL: new movie, theFSSpec contains (at least) the movie name
//
//////////

Boolean QTFrame_OpenMovieInWindow (Movie theMovie, FSSpec *theFSSpec)
{
	WindowObject			myWindowObject = NULL;
	Movie					myMovie = NULL;
	MovieController			myMC = NULL;
	GraphicsImportComponent	myImporter = NULL;
	WindowReference			myWindow = NULL;
	FSSpec					myFSSpec;
	short					myRefNum = kInvalidFileRefNum;
	short					myResID = 0;
	OSType 					myTypeList[] = {kQTFileTypeMovie, kQTFileTypeQuickTimeImage};
	short					myNumTypes = 2;
	GrafPtr					mySavedPort;
	Rect					myRect = {0, 0, 0, 0};
	Point					myPoint;
	QTFrameFileFilterUPP	myFileFilterUPP = NULL;
	OSErr					myErr = noErr;

#if TARGET_OS_MAC
	myNumTypes = 0;
#endif

	// get the current port; we may need to restore it if we cannot successfully create a new window
	GetPort(&mySavedPort);
	
	// if we got neither a movie nor an FSSpec passed in, prompt the user for a movie file
	if ((theMovie == NULL) && (theFSSpec == NULL)) {
		myFileFilterUPP = QTFrame_GetFileFilterUPP((ProcPtr)QTFrame_FilterFiles);
	
		myErr = QTFrame_GetOneFileWithPreview(myNumTypes, (QTFrameTypeListPtr)myTypeList, &myFSSpec, myFileFilterUPP);
	
		if (myFileFilterUPP != NULL)
			DisposeNavObjectFilterUPP(myFileFilterUPP);

		if (myErr != noErr)
			goto bail;
	}
	
	// if we got an FSSpec passed in, copy it into myFSSpec
	if (theFSSpec != NULL) {
		FSMakeFSSpec(theFSSpec->vRefNum, theFSSpec->parID, theFSSpec->name, &myFSSpec);		
	}

	// if we got no movie passed in, read one from the specified file
	if (theMovie == NULL) {

		// see if the FSSpec picks out an image file; if so, skip the movie-opening code
//		myErr = GetGraphicsImporterForFile(&myFSSpec, &myImporter);
//		if (myImporter != NULL)
//			goto gotImageFile;
			
		// ideally, we'd like read and write permission, but we'll settle for read-only permission
		myErr = OpenMovieFile(&myFSSpec, &myRefNum, fsRdWrPerm);
		if (myErr != noErr)
			myErr = OpenMovieFile(&myFSSpec, &myRefNum, fsRdPerm);

		// if we couldn't open the file with even just read-only permission, bail....
		if (myErr != noErr)
			goto bail;

		// now fetch the first movie from the file
		myResID = 0;
		myErr = NewMovieFromFile(&myMovie, myRefNum, &myResID, NULL, newMovieActive, NULL);
		if (myErr != noErr)
			goto bail;
	} else {
		myMovie = theMovie;
	}

	//////////
	//
	// at this point, myMovie is an open movie, but myFSSpec may or may not be a valid FSSpec
	//
	//////////
	
	// set the default progress procedure for the movie
	SetMovieProgressProc(myMovie, (MovieProgressUPP)-1, 0);
		
gotImageFile:
	// create a new window to display the movie in
	myWindow = QTFrame_CreateMovieWindow();
	if (myWindow == NULL)
		goto bail;
	
	myWindowObject = QTFrame_GetWindowObjectFromWindow(myWindow);
	if (myWindowObject == NULL)
		goto bail;
	
	// set the window title
	QTFrame_SetWindowTitleFromFSSpec(myWindow, &myFSSpec, true);

	// make sure the movie or image file uses the window GWorld
	if (myMovie != NULL)
		SetMovieGWorld(myMovie, (CGrafPtr)QTFrame_GetPortFromWindowReference(myWindow), NULL);

	if (myImporter != NULL)
		GraphicsImportSetGWorld(myImporter, (CGrafPtr)QTFrame_GetPortFromWindowReference(myWindow), NULL);

	// create and configure the movie controller
	myMC = QTFrame_SetupController(myMovie, myWindow, true);
		
	// store movie info in the window record
	(**myWindowObject).fMovie = myMovie;
	(**myWindowObject).fController = myMC;
	(**myWindowObject).fGraphicsImporter = myImporter;
	(**myWindowObject).fFileResID = myResID;
	(**myWindowObject).fFileRefNum = myRefNum;
	(**myWindowObject).fCanResizeWindow = true;
	(**myWindowObject).fIsDirty = false;
	(**myWindowObject).fIsQTVRMovie = QTUtils_IsQTVRMovie(myMovie);
	(**myWindowObject).fInstance = NULL;
	(**myWindowObject).fAppData = NULL;
	(**myWindowObject).fFileFSSpec = myFSSpec;
	
	// do any application-specific window object initialization
	QTApp_SetupWindowObject(myWindowObject);
	
	// size the window to fit the movie and controller
	QTFrame_SizeWindowToMovie(myWindowObject);

	// set the movie's play hints to allow dynamic resizing
	SetMoviePlayHints(myMovie, hintsAllowDynamicResize, hintsAllowDynamicResize);

	// set the movie's position, if it has a 'WLOC' user data atom
	myErr = QTUtils_GetWindowPositionFromFile(myMovie, &myPoint);

	// show the window
#if TARGET_OS_MAC
	MoveWindow(myWindow, myPoint.h, myPoint.v, false);
	ShowWindow(myWindow);
	SelectWindow(myWindow);								// make it front-most, since it's just been created
	InvalWindowRect(myWindow, GetWindowPortBounds(myWindow, &myRect));
#endif
#if TARGET_OS_WIN32
	SetWindowPos(myWindow, 0, myPoint.h, myPoint.v, 0, 0, SWP_NOZORDER | SWP_NOSIZE);
	ShowWindow(myWindow, SW_SHOW);
	UpdateWindow(myWindow);
#endif

	// if the movie is a streamed movie, then start it playing immediately
	if (QTUtils_IsStreamedMovie(myMovie))
		MCDoAction(myMC, mcActionPrerollAndPlay, (void *)GetMoviePreferredRate(myMovie));
		
	return(true);
	
bail:
	if (myWindow != NULL)
#if TARGET_OS_MAC
		DisposeWindow(myWindow);
#endif
#if TARGET_OS_WIN32
		SendMessage(ghWndMDIClient, WM_MDIDESTROY, (WPARAM)myWindow, 0L);
#endif
		
	if (myMC != NULL)
		DisposeMovieController(myMC);
		
	if (myMovie != NULL)
		DisposeMovie(myMovie);
		
	if (myRefNum != 0)
		CloseMovieFile(myRefNum);

	if (myImporter != NULL)
		CloseComponent(myImporter);
		
	MacSetPort(mySavedPort);	// restore the port that was active when this function was called

	return(false);
}


//////////
//
// QTFrame_SetupController
// Create and configure the movie controller.
//
//////////

MovieController QTFrame_SetupController (Movie theMovie, WindowReference theWindow, Boolean theMoveWindow)
{
#if TARGET_OS_WIN32
#pragma unused(theMoveWindow)
#endif

	MovieController			myMC = NULL;
	Rect					myRect;
	WindowObject			myWindowObject = NULL;
	GrafPtr					mySavedPort;

	if ((theMovie == NULL) || (theWindow == NULL))
		return(NULL);
		
	// get our window specific data
	myWindowObject = QTFrame_GetWindowObjectFromWindow(theWindow);
	if (myWindowObject == NULL)
		return(NULL);
		
	GetPort(&mySavedPort);
	MacSetPort(QTFrame_GetPortFromWindowReference(theWindow));
	
	// resize the movie bounding rect and offset to 0,0
	GetMovieBox(theMovie, &myRect);
	MacOffsetRect(&myRect, -myRect.left, -myRect.top);
	SetMovieBox(theMovie, &myRect);
	AlignWindow(QTFrame_GetWindowFromWindowReference(theWindow), false, &myRect, NULL);

	// create the movie controller
	myMC = NewMovieController(theMovie, &myRect, mcTopLeftMovie);
	if (myMC == NULL)
		return(NULL);
		
	// enable the default movie controller editing
	MCEnableEditing(myMC, true);
		
	// suppress movie badge
	MCDoAction(myMC, mcActionSetUseBadge, (void *)false);

	// set the initial looping state of the movie
	QTUtils_SetLoopingStateFromFile(theMovie, myMC);
	
	// install an action filter that does any application-specific movie controller action processing
	MCSetActionFilterWithRefCon(myMC, NewMCActionFilterWithRefConUPP(QTApp_MCActionFilterProc), (long)myWindowObject);

	// add grow box for the movie controller
	if ((**myWindowObject).fCanResizeWindow) {
#if TARGET_OS_WIN32
		RECT				myRect;

		GetWindowRect(GetDesktopWindow(), &myRect);
		OffsetRect(&myRect, -myRect.left, -myRect.top);
		QTFrame_ConvertWinToMacRect(&myRect, &gMCResizeBounds);
#endif
#if TARGET_OS_MAC
		GetRegionBounds(GetGrayRgn(), &gMCResizeBounds);
#endif

		MCDoAction(myMC, mcActionSetGrowBoxBounds, &gMCResizeBounds);
	}
	
#if TARGET_OS_MAC
	if (theMoveWindow)
		MoveWindow(theWindow, kDefaultWindowX, kDefaultWindowY, false);
#endif

	MacSetPort(mySavedPort);

	// add any application-specific controller functionality
	QTApp_SetupController(myMC);
		
	return(myMC);
}


//////////
//
// QTFrame_SaveAsMovieFile
// Save the movie in the specified window under a new name.
//
// Human interface guidelines for "Save As..." dictate that, if the user selects a new file name
// for the current movie, then that new file shall become the active one. This means that we need
// to close the current movie file and open the new one.
//
//////////

OSErr QTFrame_SaveAsMovieFile (WindowReference theWindow)
{
	WindowObject		myWindowObject = NULL;
	Movie 				myMovie = NULL;
	FSSpec				myFile;
	Boolean				myIsSelected = false;
	Boolean				myIsReplacing = false;	
	StringPtr 			myPrompt = QTUtils_ConvertCToPascalString(kSavePrompt);
	StringPtr 			myFileName = QTUtils_ConvertCToPascalString(kSaveMovieFileName);
	OSErr				myErr = paramErr;
	
	// get the window object associated with the specified window
	myWindowObject = QTFrame_GetWindowObjectFromWindow(theWindow);
	if (myWindowObject == NULL)
		goto bail;
		
	myMovie = (**myWindowObject).fMovie;
	if (myMovie == NULL)
		goto bail;
		
	QTFrame_PutFile(myPrompt, myFileName, &myFile, &myIsSelected, &myIsReplacing);
	if (myIsSelected) {
		Movie			myNewMovie = NULL;
		MovieController	myMC = NULL;
		long			myFlags;
		short			myRefNum = kInvalidFileRefNum;
		short			myResID = movieInDataForkResID;
		
		//////////
		//
		// we have a valid FSSpec for the new movie file; now we want to create a new movie file,
		// save the movie data into the new file, close the existing movie file, and then swap
		// the window object data
		//
		//////////
		
		// delete any existing file of that name
		if (myIsReplacing) {
			myErr = DeleteMovieFile(&myFile);
			if (myErr != noErr)
				goto bail;
		}
		
		myFlags = createMovieFileDeleteCurFile | createMovieFileDontOpenFile | createMovieFileDontCreateMovie | createMovieFileDontCreateResFile;
		myErr = CreateMovieFile(&myFile, sigMoviePlayer, smSystemScript, myFlags, NULL, NULL);
		if (myErr != noErr)
			goto bail;
		
		myErr = OpenMovieFile(&myFile, &myRefNum, fsRdWrPerm);
		if (myErr != noErr)
			goto bail;
			
		// write existing movie's data into new movie file
		myErr = AddMovieResource(myMovie, myRefNum, &myResID, myFile.name);
		if (myErr != noErr)
			goto bail;

		// get the new movie from the file
		myErr = NewMovieFromFile(&myNewMovie, myRefNum, &myResID, NULL, newMovieActive, NULL);		
		if (myErr != noErr)
			goto bail;
		
		// create a new movie controller
		myMC = QTFrame_SetupController(myNewMovie, theWindow, false);
		
		//////////
		//
		// if we got to here, we've successfully created a new movie file, and NewMovieFromFile has
		// returned the new movie to us; so we need to close down the current movie and install the
		// new movie in its place
		//
		//////////
		
		// close the existing movie file
		if ((**myWindowObject).fFileRefNum != kInvalidFileRefNum)
			CloseMovieFile((**myWindowObject).fFileRefNum);
		
		// dispose of the existing movie controller and movie resource
		DisposeMovieController((**myWindowObject).fController);
		DisposeMovie(myMovie);
		
		// keep track of the new info
		(**myWindowObject).fMovie = myNewMovie;
		(**myWindowObject).fController = myMC;
		(**myWindowObject).fFileFSSpec = myFile;
		(**myWindowObject).fFileResID = myResID;
		(**myWindowObject).fFileRefNum = myRefNum;
		(**myWindowObject).fIsDirty = false;

		// make sure the movie uses the window GWorld in all situations
		SetMovieGWorld(myNewMovie, (CGrafPtr)QTFrame_GetPortFromWindowReference((**myWindowObject).fWindow), NULL);

		// set the window title
		QTFrame_SetWindowTitleFromFSSpec(theWindow, &myFile, true);
	} else {
		myErr = userCanceledErr;
	}

bail:
	free(myPrompt);
	free(myFileName);
	
	return(myErr);
}


//////////
//
// QTFrame_UpdateMovieFile
// Update the file (if any) attached to the movie.
//
//////////

Boolean QTFrame_UpdateMovieFile (WindowReference theWindow)
{
	WindowObject		myWindowObject = NULL;
	Movie 				myMovie = NULL;
	OSErr				myErr = noErr;
	
	// get the window object associated with the specified window
	myWindowObject = QTFrame_GetWindowObjectFromWindow(theWindow);
	if (myWindowObject == NULL)
		return(false);
		
	myMovie = (**myWindowObject).fMovie;
	if (myMovie == NULL)
		return(false);
	
	// update the current volume setting
	QTUtils_UpdateMovieVolumeSetting(myMovie);
	
	if ((**myWindowObject).fFileRefNum == kInvalidFileRefNum)		// brand new movie, so no file attached to it
		myErr = QTFrame_SaveAsMovieFile(theWindow);
	else															// we have an existing file; just update the movie resource
		myErr = UpdateMovieResource(myMovie, (**myWindowObject).fFileRefNum, (**myWindowObject).fFileResID, NULL);
	
	(**myWindowObject).fIsDirty = false;

	return(myErr == noErr);
}


//////////
//
// QTFrame_IdleMovieWindows
// Do idle-time processing on all open movie windows.
//
//////////

void QTFrame_IdleMovieWindows (void)
{	
	WindowReference			myWindow = NULL;
	MovieController			myMC = NULL;
	
	myWindow = QTFrame_GetFrontMovieWindow();
	while (myWindow != NULL) {
		myMC = QTFrame_GetMCFromWindow(myWindow);
		if (myMC != NULL)
			MCIdle(myMC);
			
		QTApp_Idle(myWindow);
		
		myWindow = QTFrame_GetNextMovieWindow(myWindow);
	}
}


//////////
//
// QTFrame_CloseMovieWindows
// Close all open movie windows.
//
//////////

void QTFrame_CloseMovieWindows (void)
{
#if TARGET_OS_MAC	
	WindowReference			myWindow = NULL;
	WindowReference			myNextWindow = NULL;

	myWindow = QTFrame_GetFrontMovieWindow();
	while (myWindow != NULL) {
		myNextWindow = QTFrame_GetNextMovieWindow(myWindow);
		QTFrame_DestroyMovieWindow(myWindow);
		myWindow = myNextWindow;
	}
#endif
#if TARGET_OS_WIN32
	SendMessage(ghWnd, WM_COMMAND, (WPARAM)IDM_WINDOWCLOSEALL, 0L);
#endif
}


//////////
//
// QTFrame_CreateWindowObject
// Create a new window object associated with the specified window.
//
//////////

void QTFrame_CreateWindowObject (WindowReference theWindow)
{
	WindowObject			myWindowObject = NULL;

	if (theWindow == NULL)
		return;
		
	// allocate space for a window object record and fill in some of its fields
	myWindowObject = (WindowObject)NewHandleClear(sizeof(WindowObjectRecord));
	if (myWindowObject != NULL) {
		(**myWindowObject).fWindow = theWindow;
		(**myWindowObject).fController = NULL;
		(**myWindowObject).fObjectType = kApplicationSignature;
		(**myWindowObject).fCanResizeWindow = true;
		(**myWindowObject).fInstance = NULL;
		(**myWindowObject).fIsDirty = false;
		(**myWindowObject).fAppData = NULL;
	}
	
	// associate myWindowObject (which may be NULL) with the window
#if TARGET_OS_MAC
	SetWRefCon(theWindow, (long)myWindowObject);
#endif
#if TARGET_OS_WIN32
	SetWindowLong(theWindow, GWL_USERDATA, (LPARAM)myWindowObject);
	
	// associate a GrafPort with this window 
	CreatePortAssociation(theWindow, NULL, 0L);
#endif
	
	// set the current port to the new window
	MacSetPort(QTFrame_GetPortFromWindowReference(theWindow));
}


//////////
//
// QTFrame_CloseWindowObject
// Close a window object and any associated data.
//
//////////

void QTFrame_CloseWindowObject (WindowObject theWindowObject)
{
	if (theWindowObject == NULL)
		return;
		
	// close the movie file
	if ((**theWindowObject).fFileRefNum != kInvalidFileRefNum) {
		CloseMovieFile((**theWindowObject).fFileRefNum);
		(**theWindowObject).fFileRefNum = kInvalidFileRefNum;
	}
	
	// dispose movie controller and movie 
	if ((**theWindowObject).fController != NULL) {
		MCSetActionFilterWithRefCon((**theWindowObject).fController, NULL, 0L);
		DisposeMovieController((**theWindowObject).fController);
		(**theWindowObject).fController = NULL;
	}
	
	if ((**theWindowObject).fMovie != NULL) {
		DisposeMovie((**theWindowObject).fMovie);
		(**theWindowObject).fMovie = NULL;
	}
	
	// close the graphics importer, if any
	if ((**theWindowObject).fGraphicsImporter != NULL) {
		CloseComponent((**theWindowObject).fGraphicsImporter);
		(**theWindowObject).fGraphicsImporter = NULL;
	}
	
	// do any application-specific window clean-up
	QTApp_RemoveWindowObject(theWindowObject);
	
	DisposeHandle((Handle)theWindowObject);
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Window-walking utilities.
//
// Use these functions to iterate through all windows or movie windows belonging to the application.
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////
//
// QTFrame_GetFrontAppWindow
// Return a reference to the frontmost application window (whether or not it's a movie window).
//
//////////

WindowReference QTFrame_GetFrontAppWindow (void)
{
#if TARGET_OS_MAC
	return(FrontWindow());
#endif
#if TARGET_OS_WIN32
	return(GetWindow(ghWnd, GW_HWNDFIRST));
#endif
}


//////////
//
// QTFrame_GetNextAppWindow
// Return a reference to the next application window (whether or not it's a movie window).
//
//////////

WindowReference QTFrame_GetNextAppWindow (WindowReference theWindow)
{
#if TARGET_OS_MAC
	return(theWindow == NULL ? NULL : GetNextWindow(theWindow));
#endif
#if TARGET_OS_WIN32
	return(GetWindow(theWindow, GW_HWNDNEXT));
#endif
}


//////////
//
// QTFrame_GetFrontMovieWindow
// Return a reference to the frontmost movie window.
//
//////////

WindowReference QTFrame_GetFrontMovieWindow (void)
{
	WindowReference			myWindow;

#if TARGET_OS_MAC
	myWindow = QTFrame_GetFrontAppWindow();
	while ((myWindow != NULL) && (QTFrame_GetWindowObjectFromWindow(myWindow) == NULL))
		myWindow = QTFrame_GetNextAppWindow(myWindow);
#endif

#if TARGET_OS_WIN32
	myWindow = (HWND)SendMessage(ghWndMDIClient, WM_MDIGETACTIVE, 0, 0L);
#endif

	return(myWindow);
}


//////////
//
// QTFrame_GetNextMovieWindow
// Return a reference to the next movie window.
//
//////////

WindowReference QTFrame_GetNextMovieWindow (WindowReference theWindow)
{
	WindowReference			myWindow;

#if TARGET_OS_MAC
	myWindow = QTFrame_GetNextAppWindow(theWindow);
	while ((myWindow != NULL) && (QTFrame_GetWindowObjectFromWindow(myWindow) == NULL))
		myWindow = QTFrame_GetNextAppWindow(myWindow);
#endif

#if TARGET_OS_WIN32
	myWindow = GetWindow(theWindow, GW_HWNDNEXT);
#endif

	return(myWindow);
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Data-retrieval utilities.
//
// Use the following functions to retrieve the window object, the application-specific data, or the movie
// controller that is associated with a window.
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////
//
// QTFrame_GetWindowObjectFromFrontWindow
// Get the window object (if any) associated with the front window.
//
//////////

WindowObject QTFrame_GetWindowObjectFromFrontWindow (void)
{
	return(QTFrame_GetWindowObjectFromWindow(QTFrame_GetFrontMovieWindow()));
}


//////////
//
// QTFrame_GetWindowObjectFromWindow
// Get the window object (if any) associated with the specified window.
//
//////////

WindowObject QTFrame_GetWindowObjectFromWindow (WindowReference theWindow)
{
	WindowObject		myWindowObject = NULL;

	if (!QTFrame_IsAppWindow(theWindow))
		return(NULL);
			
#if TARGET_OS_MAC
	myWindowObject = (WindowObject)GetWRefCon(theWindow);
#endif
#if TARGET_OS_WIN32
	myWindowObject = (WindowObject)GetWindowLong(theWindow, GWL_USERDATA);
#endif

	// make sure this is a window object
	if (!QTFrame_IsWindowObjectOurs(myWindowObject))
		return(NULL);
		
	return(myWindowObject);
}


//////////
//
// QTFrame_GetMCFromFrontWindow
// Get the movie controller (if any) associated with the front window.
//
//////////

MovieController QTFrame_GetMCFromFrontWindow (void)
{
	return(QTFrame_GetMCFromWindow(QTFrame_GetFrontMovieWindow()));
}


//////////
//
// QTFrame_GetMCFromWindow
// Get the movie controller (if any) associated with the specified window.
//
//////////

MovieController QTFrame_GetMCFromWindow (WindowReference theWindow)
{
	MovieController 	myMC = NULL;
	WindowObject		myWindowObject = NULL;
		
	myWindowObject = QTFrame_GetWindowObjectFromWindow(theWindow);
	if (myWindowObject != NULL)
		myMC = (**myWindowObject).fController;
		
	return(myMC);
}


//////////
//
// QTFrame_GetQTVRInstanceFromFrontWindow
// Get the QTVRInstance (if any) associated with the front window.
//
//////////

QTVRInstance QTFrame_GetQTVRInstanceFromFrontWindow (void)
{
	return(QTFrame_GetQTVRInstanceFromWindow(QTFrame_GetFrontMovieWindow()));
}


//////////
//
// QTFrame_GetQTVRInstanceFromWindow
// Get the QTVRInstance (if any) associated with the specified window.
//
//////////

QTVRInstance QTFrame_GetQTVRInstanceFromWindow (WindowReference theWindow)
{
	QTVRInstance	 	myInstance = NULL;
	WindowObject		myWindowObject = NULL;
	
	myWindowObject = QTFrame_GetWindowObjectFromWindow(theWindow);
	if (myWindowObject != NULL)
		myInstance = (**myWindowObject).fInstance;
		
	return(myInstance);
}


//////////
//
// QTFrame_GetAppDataFromFrontWindow
// Get the application-specific data associated with the front window.
//
//////////

Handle QTFrame_GetAppDataFromFrontWindow (void)
{
	return(QTFrame_GetAppDataFromWindow(QTFrame_GetFrontMovieWindow()));
}


//////////
//
// QTFrame_GetAppDataFromWindow
// Get the application-specific data associated with the specified window.
//
//////////

Handle QTFrame_GetAppDataFromWindow (WindowReference theWindow)
{
	WindowObject		myWindowObject = NULL;
	
	myWindowObject = QTFrame_GetWindowObjectFromWindow(theWindow);
	if (myWindowObject == NULL)
		return(NULL);
		
	return(QTFrame_GetAppDataFromWindowObject(myWindowObject));
}


//////////
//
// QTFrame_GetAppDataFromWindowObject
// Get the application-specific data associated with the specified window object.
//
//////////

Handle QTFrame_GetAppDataFromWindowObject (WindowObject theWindowObject)
{
	// make sure this is a window object belonging to our application
	if (!QTFrame_IsWindowObjectOurs(theWindowObject))
		return(NULL);
	
	return((**theWindowObject).fAppData);
}


//////////
//
// QTFrame_IsWindowObjectOurs
// Does the specified window object belong to our application?
//
//////////

Boolean QTFrame_IsWindowObjectOurs (WindowObject theWindowObject)
{
	OSType		myType = 0L;

	if ((theWindowObject == NULL) || (*theWindowObject == NULL))
		return(false);
		
	myType = (**theWindowObject).fObjectType;
	return(myType == kApplicationSignature);
}


//////////
//
// QTFrame_IsAppWindow
// Does the specified window belong to our application?
//
//////////

Boolean QTFrame_IsAppWindow (WindowReference theWindow)
{
	if (theWindow == NULL)
		return(false);

#if TARGET_OS_MAC
	return(GetWindowKind(theWindow) >= kApplicationWindowKind);
#endif
#if TARGET_OS_WIN32
	return(true);
#endif
}


//////////
//
// QTFrame_IsDocWindow
// Is the specified window a document window (having a WindowObject refcon)?
//
//////////

Boolean QTFrame_IsDocWindow (WindowReference theWindow)
{
	if (theWindow == NULL)
		return(false);

#if TARGET_OS_MAC
	return(GetWindowKind(theWindow) >= kApplicationWindowKind);
#endif
#if TARGET_OS_WIN32
	return(true);
#endif
}


//////////
//
// QTFrame_ActivateController
// Activate or deactivate the movie controller in the specified window.
//
//////////

void QTFrame_ActivateController (WindowReference theWindow, Boolean IsActive)
{
	WindowObject 		myWindowObject = NULL;
	MovieController		myMC = NULL;
	GrafPtr				mySavedPort = NULL;
	
	if (theWindow == NULL)
		return;
	
	GetPort(&mySavedPort);
	MacSetPort(QTFrame_GetPortFromWindowReference(theWindow));
	
	// get the window object associated with the specified window
	myWindowObject = QTFrame_GetWindowObjectFromWindow(theWindow);
	if (myWindowObject != NULL) {
		myMC = (**myWindowObject).fController;
		if (myMC != NULL)
			MCActivate(myMC, QTFrame_GetWindowFromWindowReference(theWindow), IsActive);
	}
	
	MacSetPort(mySavedPort);
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Miscellaneous utilities.
//
// Use the following functions to play beeps, manipulate menus, and do other miscellaneous things.
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////
//
// QTFrame_Beep
// Beep.
//
//////////

void QTFrame_Beep (void)
{
#if TARGET_OS_MAC
	SysBeep(30);
#endif
#if TARGET_OS_WIN32
	MessageBeep(MB_OK);
#endif
}


//////////
//
// QTFrame_SetMenuState
// Set the enabled/disabled state of a menu.
//
// On Windows, the theMenuItem parameter must be the (0-based) index in the menu bar of the
// desired pull-down menu.
//
//////////

void QTFrame_SetMenuState (MenuReference theMenu, UInt16 theMenuItem, short theState)
{
#if TARGET_OS_MAC
#pragma unused(theMenuItem)
	QTFrame_SetMenuItemState(theMenu, 0, theState);		// menu item == 0 means the entire menu
#endif
#if TARGET_OS_WIN32
	QTFrame_SetMenuItemState(theMenu, theMenuItem, theState | MF_BYPOSITION);
#endif
}


//////////
//
// QTFrame_SetMenuItemState
// Set the enabled/disabled state of a menu item.
//
// When running under MacOS 8.5.1, EnableMenuItem and DisableMenuItem seem to do nasty things
// to the keyboard equivalents associated with a menu; so we'll work around that problem here.
//
//////////

void QTFrame_SetMenuItemState (MenuReference theMenu, UInt16 theMenuItem, short theState)
{
#if TARGET_OS_MAC
	UInt8		myModifiers;
	
	// get the existing menu item modifiers
	GetMenuItemModifiers(theMenu, MENU_ITEM(theMenuItem), &myModifiers);
	
	if (theState == kEnableMenuItem)
		EnableMenuItem(theMenu, MENU_ITEM(theMenuItem));
	else
		DisableMenuItem(theMenu, MENU_ITEM(theMenuItem));
		
	// restore the previous menu item modifiers
	SetMenuItemModifiers(theMenu, MENU_ITEM(theMenuItem), myModifiers);
#endif
#if TARGET_OS_WIN32
	EnableMenuItem(theMenu, (UINT)theMenuItem, (UINT)theState);
#endif
}


//////////
//
// QTFrame_SetMenuItemLabel
// Set the label (that is, the text) of a menu item.
//
//////////

void QTFrame_SetMenuItemLabel (MenuReference theMenu, UInt16 theMenuItem, char *theText)
{
#if TARGET_OS_MAC
	Str255		myString;
	short		mySIndex, myTIndex;

	// we need to remove the '&' character while converting to a Pascal string	
	mySIndex = 1;
	for (myTIndex = 0; myTIndex < strlen(theText); myTIndex++) {
		if (theText[myTIndex] != '&') {
			myString[mySIndex] = theText[myTIndex];
			mySIndex++;
		}
	}
	
	myString[0] = mySIndex - 1;
	
	SetMenuItemText(theMenu, MENU_ITEM(theMenuItem), myString);
#endif
#if TARGET_OS_WIN32
	UINT		myState;
	
	// make sure that we preserve the current menu state
	myState = GetMenuState(theMenu, (UINT)theMenuItem, MF_BYCOMMAND);
	ModifyMenu(theMenu, (UINT)theMenuItem, MF_BYCOMMAND | MF_STRING | myState, (UINT)theMenuItem, (LPSTR)theText);
#endif
}


//////////
//
// QTFrame_SetMenuItemCheck
// Set the check mark state state of a menu item.
//
//////////

void QTFrame_SetMenuItemCheck (MenuReference theMenu, UInt16 theMenuItem, Boolean theState)
{
#if TARGET_OS_MAC
	MacCheckMenuItem(theMenu, MENU_ITEM(theMenuItem), theState);
#endif
#if TARGET_OS_WIN32
	CheckMenuItem(theMenu, (UINT)theMenuItem, theState ? MF_CHECKED : MF_UNCHECKED);
#endif
}


//////////
//
// QTFrame_GetPortFromWindowReference 
// Return the graphics port associated with a window reference.
//
//////////

GrafPtr QTFrame_GetPortFromWindowReference (WindowReference theWindow)
{
#if TARGET_OS_MAC
	return((GrafPtr)GetWindowPort(theWindow));
#endif
#if TARGET_OS_WIN32
	return(GetNativeWindowPort(theWindow));
#endif
}


//////////
//
// QTFrame_GetWindowReferenceFromPort
// Return the window reference associated with a graphics port.
//
//////////

WindowReference QTFrame_GetWindowReferenceFromPort (GrafPtr thePort)
{
#if TARGET_OS_MAC
	return((WindowReference)GetWindowFromPort((CGrafPtr)thePort));
#endif
#if TARGET_OS_WIN32
	return((WindowReference)GetPortNativeWindow(thePort));
#endif
}


//////////
//
// QTFrame_GetWindowFromWindowReference
// Return the Macintosh window associated with a window reference.
//
//////////

WindowPtr QTFrame_GetWindowFromWindowReference (WindowReference theWindow)
{
#if TARGET_OS_MAC
	return((WindowPtr)theWindow);
#endif
#if TARGET_OS_WIN32
	return((WindowPtr)GetNativeWindowPort(theWindow));
#endif
}


/////////
//
// QTFrame_GetWindowWidth
// Return the width of the specified window.
//
//////////

short QTFrame_GetWindowWidth (WindowReference theWindow)
{
#if TARGET_OS_MAC
	Rect		myRect = {0, 0, 0, 0};

	if (theWindow != NULL)
		GetWindowPortBounds(theWindow, &myRect);
#endif
#if TARGET_OS_WIN32
	RECT		myRect = {0L, 0L, 0L, 0L};

	if (theWindow != NULL)
		GetWindowRect(theWindow, &myRect);
#endif

	return((short)(myRect.right - myRect.left));
}


//////////
//
// QTFrame_SetWindowTitleFromFSSpec
// Set the title of the specified window, using the name contained in the specified FSSpec.
//
//////////

void QTFrame_SetWindowTitleFromFSSpec (WindowReference theWindow, FSSpecPtr theFSSpecPtr, Boolean theAddToRecentDocs)
{
#if TARGET_OS_MAC
#pragma unused(theAddToRecentDocs)
	SetWTitle(theWindow, theFSSpecPtr->name);
#endif
#if TARGET_OS_WIN32
	char	*myTempName;
	char	myWindName[MAX_PATH];

	// get the full pathname contained in the FSSpec (which is a Str255)
	myTempName = QTUtils_ConvertPascalToCString(theFSSpecPtr->name);

	// get the movie file name from the full pathname
	QTFrame_GetDisplayName(myTempName, myWindName);

	// set the window title
	SetWindowText(theWindow, myWindName);
	
	// add this document to the Documents list, if so instructed
	if (theAddToRecentDocs)
		SHAddToRecentDocs(SHARD_PATH, myTempName);
	
	free(myTempName);
#endif
}


//////////
//
// QTFrame_SizeWindowToMovie
// Set the window size to exactly fit the movie and controller (if visible).
//
//////////

void QTFrame_SizeWindowToMovie (WindowObject theWindowObject)
{
	Rect					myMovieBounds;
	Movie					myMovie = NULL;
	MovieController			myMC = NULL;
	GraphicsImportComponent	myImporter = NULL;

#if TARGET_OS_WIN32
	gWeAreSizingWindow = true;
#endif

	if (theWindowObject == NULL)
		goto bail;
	
	myMovie = (**theWindowObject).fMovie;
	myMC = (**theWindowObject).fController;
	myImporter = (**theWindowObject).fGraphicsImporter;

	if (myImporter != NULL) {
		GraphicsImportGetBoundsRect(myImporter, &myMovieBounds);
		goto gotBounds;
	}

	if (myMovie == NULL)
		return;

	GetMovieBox(myMovie, &myMovieBounds);

	if (myMC != NULL)
		if (MCGetVisible(myMC))
			MCGetControllerBoundsRect(myMC, &myMovieBounds);
	
	// make sure that the movie has a non-zero width;
	// a zero height is okay (for example, with a music movie with no controller bar)
	if (myMovieBounds.right - myMovieBounds.left == 0) {
		myMovieBounds.left = 0;
		myMovieBounds.right = QTFrame_GetWindowWidth((**theWindowObject).fWindow);
	}

gotBounds:	
	SizeWindow(QTFrame_GetWindowFromWindowReference((**theWindowObject).fWindow),
											myMovieBounds.right - myMovieBounds.left,
											myMovieBounds.bottom - myMovieBounds.top,
											true);

bail:										
#if TARGET_OS_WIN32
	gWeAreSizingWindow = false;
#endif

	return;
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// File-opening and -saving utilities.
//
// The functions are meant to provide replacements for StandardGetFilePreview and StandardPutFile, which
// are not supported under Carbon. However, Navigation Services is not (yet, at any rate) supported under
// Windows, so we still need to call through to the Standard File Package.
//
// The Navigation Services portion of this code is based selectively on the file NavigationServicesSupport.c
// by Yan Arrouye and on the developer documentation "Programming With Navigation Services 1.1". The code that
// determines which files can be opened by QuickTime is based on code by Sam Bushell in CarbonMovieEditor.c.
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////
//
// QTFrame_PutFile
// Save a file under the specified name. Return Boolean values indicating whether the user selected a file
// and whether the selected file is replacing an existing file.
//
//////////

OSErr QTFrame_PutFile (ConstStr255Param thePrompt, ConstStr255Param theFileName, FSSpecPtr theFSSpecPtr, Boolean *theIsSelected, Boolean *theIsReplacing)
{
#if TARGET_OS_WIN32
	StandardFileReply	myReply;
#endif
#if TARGET_OS_MAC
	NavReplyRecord		myReply;
	NavDialogOptions	myDialogOptions;
	NavEventUPP			myEventUPP = NewNavEventUPP(QTFrame_HandleNavEvent);
#endif
	OSErr				myErr = noErr;

	if ((theFSSpecPtr == NULL) || (theIsSelected == NULL) || (theIsReplacing == NULL))
		return(paramErr);
	
	// deactivate any frontmost movie window
	QTFrame_ActivateController(QTFrame_GetFrontMovieWindow(), false);

	// assume we are not replacing an existing file
	*theIsReplacing = false;
	
#if TARGET_OS_WIN32
	StandardPutFile(thePrompt, theFileName, &myReply);
	*theFSSpecPtr = myReply.sfFile;
	*theIsSelected = myReply.sfGood;
	if (myReply.sfGood)
		*theIsReplacing = myReply.sfReplacing;
#endif

#if TARGET_OS_MAC
	// specify the options for the dialog box
	NavGetDefaultDialogOptions(&myDialogOptions);
	myDialogOptions.dialogOptionFlags += kNavNoTypePopup;
	myDialogOptions.dialogOptionFlags += kNavDontAutoTranslate;
	BlockMoveData(theFileName, myDialogOptions.savedFileName, theFileName[0] + 1);
	BlockMoveData(gAppName, myDialogOptions.clientName, gAppName[0] + 1);
	BlockMoveData(thePrompt, myDialogOptions.message, thePrompt[0] + 1);
	
	// prompt the user for a file
	myErr = NavPutFile(NULL, &myReply, &myDialogOptions, myEventUPP, MovieFileType, sigMoviePlayer, NULL);
	if ((myErr == noErr) && myReply.validRecord) {
		AEKeyword		myKeyword;
		DescType		myActualType;
		Size			myActualSize = 0;
		
		// get the FSSpec for the selected file
		if (theFSSpecPtr != NULL)
			myErr = AEGetNthPtr(&(myReply.selection), 1, typeFSS, &myKeyword, &myActualType, theFSSpecPtr, sizeof(FSSpec), &myActualSize);

		NavDisposeReply(&myReply);
	}
		
	*theIsSelected = myReply.validRecord;
	if (myReply.validRecord)
		*theIsReplacing = myReply.replacing;

	DisposeNavEventUPP(myEventUPP);
#endif

	return(myErr);
}
	

//////////
//
// QTFrame_GetOneFileWithPreview
// Display the appropriate file-opening dialog box, with an optional QuickTime preview pane. If the user
// selects a file, return information about it using the theFSSpecPtr parameter.
//
// Note that both StandardGetFilePreview and NavGetFile use the function specified by theFilterProc as a
// file filter. This framework always passes NULL in the theFilterProc parameter. If you use this function
// in your own code, keep in mind that on Windows the function specifier must be of type FileFilterUPP and 
// on Macintosh it must be of type NavObjectFilterUPP. (You can use the QTFrame_GetFileFilterUPP to create
// a function specifier of the appropriate type.) Also keep in mind that Navigation Services expects a file 
// filter function to return true if a file is to be displayed, while the Standard File Package expects the
// filter to return false if a file is to be displayed.
//
//////////

OSErr QTFrame_GetOneFileWithPreview (short theNumTypes, QTFrameTypeListPtr theTypeList, FSSpecPtr theFSSpecPtr, void *theFilterProc)
{
#if TARGET_OS_WIN32
	StandardFileReply	myReply;
#endif
#if TARGET_OS_MAC
	NavReplyRecord		myReply;
	NavDialogOptions	myDialogOptions;
	NavTypeListHandle	myOpenList = NULL;
	NavEventUPP			myEventUPP = NewNavEventUPP(QTFrame_HandleNavEvent);
#endif
	OSErr				myErr = noErr;
	
	if (theFSSpecPtr == NULL)
		return(paramErr);
	
	// deactivate any frontmost movie window
	QTFrame_ActivateController(QTFrame_GetFrontMovieWindow(), false);

#if TARGET_OS_WIN32
	// prompt the user for a file
	StandardGetFilePreview((FileFilterUPP)theFilterProc, theNumTypes, (ConstSFTypeListPtr)theTypeList, &myReply);
	if (!myReply.sfGood)
		return(userCanceledErr);
	
	// make an FSSpec record
	myErr = FSMakeFSSpec(myReply.sfFile.vRefNum, myReply.sfFile.parID, myReply.sfFile.name, theFSSpecPtr);
#endif

#if TARGET_OS_MAC
	// specify the options for the dialog box
	NavGetDefaultDialogOptions(&myDialogOptions);
	myDialogOptions.dialogOptionFlags -= kNavNoTypePopup;
	myDialogOptions.dialogOptionFlags -= kNavAllowMultipleFiles;
	BlockMoveData(gAppName, myDialogOptions.clientName, gAppName[0] + 1);
	
	// create a handle to an 'open' resource
	myOpenList = (NavTypeListHandle)QTFrame_CreateOpenHandle(kApplicationSignature, theNumTypes, theTypeList);
	if (myOpenList != NULL)
		HLock((Handle)myOpenList);
	
	// prompt the user for a file
	myErr = NavGetFile(NULL, &myReply, &myDialogOptions, myEventUPP, NULL, (NavObjectFilterUPP)theFilterProc, myOpenList, NULL);
	if ((myErr == noErr) && myReply.validRecord) {
		AEKeyword		myKeyword;
		DescType		myActualType;
		Size			myActualSize = 0;
		
		// get the FSSpec for the selected file
		if (theFSSpecPtr != NULL)
			myErr = AEGetNthPtr(&(myReply.selection), 1, typeFSS, &myKeyword, &myActualType, theFSSpecPtr, sizeof(FSSpec), &myActualSize);

		NavDisposeReply(&myReply);
	}
	
	if (myOpenList != NULL) {
		HUnlock((Handle)myOpenList);
		DisposeHandle((Handle)myOpenList);
	}
	
	DisposeNavEventUPP(myEventUPP);
#endif
 
	return(myErr);
}


//////////
//
// QTFrame_HandleNavEvent
// A callback procedure that handles events while a Navigation Service dialog box is displayed.
//
//////////

PASCAL_RTN void QTFrame_HandleNavEvent (NavEventCallbackMessage theCallBackSelector, NavCBRecPtr theCallBackParms, void *theCallBackUD)
{
#pragma unused(theCallBackUD)
	WindowReference		myWindow = NULL;	
	
	if (theCallBackSelector == kNavCBEvent) {
		switch (theCallBackParms->eventData.eventDataParms.event->what) {
			case updateEvt:
#if TARGET_OS_MAC
				QTFrame_HandleEvent(theCallBackParms->eventData.eventDataParms.event);
#endif
				break;
			case nullEvent:
				QTFrame_IdleMovieWindows();
				break;
		}
	}
}


//////////
//
// QTFrame_CreateOpenHandle
// Return a handle to a dynamically-created 'open' resource.
//
//////////

Handle QTFrame_CreateOpenHandle (OSType theApplicationSignature, short theNumTypes, QTFrameTypeListPtr theTypeList)
{
	Handle			myHandle = NULL;
	
	if (theTypeList == NULL)
		return(myHandle);
	
	if (theNumTypes > 0) {
		myHandle = NewHandle(sizeof(NavTypeList) + (theNumTypes * sizeof(OSType)));
		if (myHandle != NULL) {
			NavTypeListHandle 	myOpenResHandle	= (NavTypeListHandle)myHandle;
			
			(*myOpenResHandle)->componentSignature = theApplicationSignature;
			(*myOpenResHandle)->osTypeCount = theNumTypes;
			BlockMoveData(theTypeList, (*myOpenResHandle)->osType, theNumTypes * sizeof(OSType));
		}
	}
	
	return(myHandle);
}


//////////
//
// QTFrame_GetFileFilterUPP
// Return a UPP for the specified file-selection filter function.
//
// The caller is responsible for disposing of the UPP returned by this function (by calling DisposeRoutineDescriptor).
//
//////////

QTFrameFileFilterUPP QTFrame_GetFileFilterUPP (ProcPtr theFileFilterProc)
{
#if TARGET_OS_MAC
	return(NewNavObjectFilterUPP((NavObjectFilterProcPtr)theFileFilterProc));
#endif
#if TARGET_OS_WIN32
	return(NewFileFilterProc(theFileFilterProc));
#endif
}


//////////
//
// QTFrame_FilterFiles
// Filter files for a file-opening dialog box.
//
// The default behavior here is to accept all files that can be opened by QuickTime, whether directly
// or using a movie importer or a graphics importer.
//
//////////

#if TARGET_OS_MAC
PASCAL_RTN Boolean QTFrame_FilterFiles (AEDesc *theItem, void *theInfo, void *theCallBackUD, NavFilterModes theFilterMode)
{
#pragma unused(theCallBackUD, theFilterMode)
	NavFileOrFolderInfo		*myInfo = (NavFileOrFolderInfo *)theInfo;
	
	if (gValidFileTypes == NULL)
		QTFrame_BuildFileTypeList();

	if (theItem->descriptorType == typeFSS) {
		if (!myInfo->isFolder) {
			OSType			myType = myInfo->fileAndFolder.fileInfo.finderInfo.fdType;
			short			myCount;
			short			myIndex;
			
			// see whether the file type is in the list of file types that our application can open 
			myCount = GetPtrSize((Ptr)gValidFileTypes) / sizeof(OSType);
			for (myIndex = 0; myIndex < myCount; myIndex++)
				if (myType == gValidFileTypes[myIndex])
					return(true);

			// if we got to here, it's a file we cannot open
			return(false);		
		}
	}
	
	// if we got to here, it's a folder or non-HFS object
	return(true);
}
#endif
#if TARGET_OS_WIN32
PASCAL_RTN Boolean QTFrame_FilterFiles (CInfoPBPtr thePBPtr)
{
#pragma unused(thePBPtr)
	return(false);
}
#endif


//////////
//
// QTFrame_BuildFileTypeList
// Build a list of file types that QuickTime can open.
//
//////////

OSErr QTFrame_BuildFileTypeList (void)
{
	long		myIndex = 0;
	OSErr		myErr = noErr;

	// if we've already built the list, just return
	if (gValidFileTypes != NULL)
		return(myErr);
	
	// allocate a block of memory to hold a preset number of file types; we'll resize this block
	// while building the list if we need more room; we always resize it after building the list,
	// to truncate it to the exact size required
	gValidFileTypes = (OSType *)NewPtrClear(sizeof(OSType) * kDefaultFileTypeCount);
	if (gValidFileTypes == NULL)
		return(memFullErr);
	
	// we can open any files of type kQTFileTypeMovie
	gValidFileTypes[myIndex++] = kQTFileTypeMovie;
	
	// we can open any files for which QuickTime supplies a movie importer component
	QTFrame_AddComponentFileTypes(MovieImportType, &myIndex);
	
	// we can open any files for which QuickTime supplies a graphics importer component
	QTFrame_AddComponentFileTypes(GraphicsImporterComponentType, &myIndex);

	// resize the pointer to hold the exact number of valid file types
	SetPtrSize((Ptr)gValidFileTypes, myIndex * sizeof(OSType));
	myErr = MemError();
	
	return(myErr);
}


//////////
//
// QTFrame_AddComponentFileTypes
// Add all subtypes of the specified component type to the global list of file types.
//
//////////

static void QTFrame_AddComponentFileTypes (OSType theComponentType, long *theNextIndex)
{
	ComponentDescription		myFindCompDesc = {0, 0, 0, 0, 0};
	ComponentDescription		myInfoCompDesc = {0, 0, 0, 0, 0};
	Component					myComponent = NULL;

	myFindCompDesc.componentType = theComponentType;
	myFindCompDesc.componentFlags = 0;
	myFindCompDesc.componentFlagsMask = movieImportSubTypeIsFileExtension;

	myComponent = FindNextComponent(myComponent, &myFindCompDesc);
	while (myComponent != NULL) {
		GetComponentInfo(myComponent, &myInfoCompDesc, NULL, NULL, NULL);
		gValidFileTypes[*theNextIndex] = myInfoCompDesc.componentSubType;
		*theNextIndex += 1;
		
		// resize the block of file types, if we are about to reach the limit
		if (*theNextIndex == GetPtrSize((Ptr)gValidFileTypes) / (long)sizeof(OSType)) {
			SetPtrSize((Ptr)gValidFileTypes, GetPtrSize((Ptr)gValidFileTypes) + (kDefaultFileTypeCount * sizeof(OSType)));
			if (MemError() != noErr)
				return;
		}
		
		myComponent = FindNextComponent(myComponent, &myFindCompDesc);
	}
}


#if TARGET_OS_WIN32
//////////
//
// QTFrame_ConvertMacToWinRect
// Convert a Macintosh Rect structure into a Windows RECT structure.
//
//////////

void QTFrame_ConvertMacToWinRect (Rect *theMacRect, RECT *theWinRect)
{
	theWinRect->top = (long)theMacRect->top;
	theWinRect->left = (long)theMacRect->left;
	theWinRect->bottom = (long)theMacRect->bottom;
	theWinRect->right = (long)theMacRect->right;
}


//////////
//
// QTFrame_ConvertWinToMacRect
// Convert a Windows RECT structure into a Macintosh Rect structure.
//
//////////

void QTFrame_ConvertWinToMacRect (RECT *theWinRect, Rect *theMacRect)
{
	theMacRect->top = (short)theWinRect->top;
	theMacRect->left = (short)theWinRect->left;
	theMacRect->bottom = (short)theWinRect->bottom;
	theMacRect->right = (short)theWinRect->right;
}
#endif

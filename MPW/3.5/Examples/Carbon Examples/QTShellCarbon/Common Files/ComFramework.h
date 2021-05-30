/*

	File:		ComFramework.h

	Contains:	Code for the QuickTime sample code framework that is common to both Macintosh and Windows. 

	Written by:	Tim Monroe
				Based on the QTShell code written by Tim Monroe, which in turn was based on the MovieShell
				code written by Kent Sandvik (Apple DTS). This current version is now very far removed from
				MovieShell.

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

#pragma once


//////////
//	   
// header files
//	   
//////////

#ifndef __Prefix_File__
#if TARGET_OS_MAC
#include <MacPrefix.h>
#elif TARGET_OS_WIN32
#include <WinPrefix.h>
#endif	// Mac/Win prefix
#endif

#ifdef __MRC__
#ifndef __CONTROLDEFINITIONS__
#include <ControlDefinitions.h>
#endif
#endif	// __MRC__

#ifndef __FILETYPESANDCREATORS__
#include <FileTypesAndCreators.h>
#endif

#ifdef __MRC__
#ifndef __MOVIES__
#include <Movies.h>
#endif

#ifndef __NAVIGATION__
#include <Navigation.h>
#endif

#ifndef __QUICKTIMEVR__
#include <QuickTimeVR.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __SOUND__
#include <Sound.h>
#endif

#ifndef __TEXTUTILS__
#include <TextUtils.h>
#endif

#ifndef _STRING_H
#include <string.h>
#endif
#endif	// __MRC__

#ifndef __QTUtilities__
#include "QTUtilities.h"
#endif

#include "ComResource.h"

#if TARGET_OS_WIN32
#ifndef __QTML__
#include <QTML.h>
#endif

#include <shlobj.h>											// for SHAddToRecentDocs
#endif

// revert to older names, to keep the linker happy
#if TARGET_CPU_68K
#define EnableMenuItem						EnableItem
#define DisableMenuItem						DisableItem
#endif


//////////
//
// constants
//
//////////

#define kInvalidFileRefNum					-1				// an invalid file reference number

#define kDefaultFileTypeCount				100				// a generous guess at the number of file types we can open

// constants for selecting InitApplication phase
enum {
	kInitAppPhase_BeforeCreateFrameWindow 	= 1L << 0,		// MDI frame window is not yet created
	kInitAppPhase_AfterCreateFrameWindow	= 1L << 1,		// MDI frame window is already created
	kInitAppPhase_BothPhases				= kInitAppPhase_BeforeCreateFrameWindow | kInitAppPhase_AfterCreateFrameWindow
};

// constants for selecting StopApplication phase
enum {
	kStopAppPhase_BeforeDestroyWindows 		= 1L << 0,		// movie windows are not yet torn down
	kStopAppPhase_AfterDestroyWindows		= 1L << 1,		// movie windows are already torn down
	kStopAppPhase_BothPhases				= kStopAppPhase_BeforeDestroyWindows | kStopAppPhase_AfterDestroyWindows
};

enum {
	kApplicationSignature  					= FOUR_CHAR_CODE('QTsh')
};

// parameters to the SetMenuItemState function
#if TARGET_OS_MAC
#define kEnableMenuItem						0x00000000L
#define kDisableMenuItem					0x00000001L
#endif

#if TARGET_OS_WIN32
#define kEnableMenuItem						MF_ENABLED
#define kDisableMenuItem					MF_GRAYED
#endif

// constants for standard modal dialog filter proc
#define kMyButtonDelay						8
#define kReturnKey							(char)0x0D	
#define kEnterKey							(char)0x03	
#define kEscapeKey							(char)0x1B	
#define kPeriod								'.'

// items in Save Changes dialog box
#if TARGET_OS_MAC
#define kSaveChanges						1						// save the changes before closing window
#define kCancelClose						2						// no, don't close the window or save changes
#define kDontSaveChanges					3						// discard any unsaved changes
#define kOKButtonUserItem					4
#endif

#if TARGET_OS_WIN32
#define kSaveChanges						IDYES					// save the changes before closing window
#define kCancelClose						IDCANCEL				// no, don't close the window or save changes
#define kDontSaveChanges					IDNO					// discard any unsaved changes
#endif

// default name of a movie created by "New" menu command
#if TARGET_OS_MAC
#define kNewMovieName						"untitled.mov"
#endif
#if TARGET_OS_WIN32
#define kNewMovieName						"C:\\untitled.mov"
#endif

// default window positions
#ifndef kDefaultWindowX
#define kDefaultWindowX						100
#endif

#ifndef kDefaultWindowY
#define kDefaultWindowY						100
#endif


/////////
//
// macros
//
//////////

// macros for converting Mac menu ID/menu item pairs into a single "menu item identifier"
#define MENU_IDENTIFIER(menuID,menuItem)	((menuID<<8)+(menuItem))
#define MENU_ID(menuIdentifier)				((menuIdentifier&0xff00)>>8)
#define MENU_ITEM(menuIdentifier)			((menuIdentifier&0x00ff))


//////////
//
// data types
//
//////////

typedef const OSType *		QTFrameTypeListPtr;

#if TARGET_OS_MAC
typedef MenuHandle			MenuReference;
typedef WindowPtr			WindowReference;
typedef NavObjectFilterUPP	QTFrameFileFilterUPP;
#endif

#if TARGET_OS_WIN32
typedef HMENU				MenuReference;
typedef HWND				WindowReference;
typedef FileFilterUPP		QTFrameFileFilterUPP;
#endif


//////////
//
// structures
//
//////////

// WindowObjectRecord is a data structure attached to a movie window.
// We use this structure to associate data with any window presented.
// If you have application-specific data that you want associated with
// a movie or movie window, use the fAppData field to hold a handle to
// that data.

typedef struct {
	WindowReference			fWindow;			// the window
	Movie					fMovie;				// the movie
	MovieController 		fController;		// the movie controller
	GraphicsImportComponent fGraphicsImporter;	// the graphics import component (if an image file)
	FSSpec					fFileFSSpec;		// location of the movie file
	short					fFileResID;			// the resource ID that the movie was loaded from
	short					fFileRefNum;		// the file reference number for the movie file
	Boolean					fCanResizeWindow;	// can the window be resized?
	Boolean					fIsDirty;			// has the movie data changed since the last save?
	Boolean					fIsQTVRMovie;		// is this a QuickTime VR movie?
	QTVRInstance			fInstance;			// the QTVRInstance, if it's a QuickTime VR movie
	OSType					fObjectType;		// a tag indicating that the window object belongs to our application
	Handle					fAppData;			// a handle to application-specific window data
} WindowObjectRecord, *WindowObjectPtr, **WindowObject;


//////////
//
// function prototypes
//	   
//////////

// the following functions are defined in MacFramework.c and/or WinFramework.c
void						QTFrame_QuitFramework (void);
WindowReference				QTFrame_CreateMovieWindow (void);
void 						QTFrame_DestroyMovieWindow (WindowReference theWindow);
void 						QTFrame_ShowAboutBox (void);
void						QTFrame_GetDisplayName (char *thePathName, char *theDispName);

// the following functions are defined in ComFramework.c
void						QTFrame_HandleFileMenuItem (WindowReference theWindow, UInt16 theMenuItem);
void						QTFrame_HandleEditMenuItem (WindowReference theWindow, UInt16 theMenuItem);
int							QTFrame_AdjustMenus (WindowReference theWindow, MenuReference theMenu);

Boolean 					QTFrame_CreateNewMovie (void);
Boolean 					QTFrame_OpenMovieInWindow (Movie theMovie, FSSpec *theFSSpec);
MovieController				QTFrame_SetupController (Movie theMovie, WindowReference theWindow, Boolean theMoveWindow);
OSErr						QTFrame_SaveAsMovieFile (WindowReference theWindow);
Boolean 					QTFrame_UpdateMovieFile (WindowReference theWindow);
void						QTFrame_IdleMovieWindows (void);
void						QTFrame_CloseMovieWindows (void);
void						QTFrame_CreateWindowObject (WindowReference theWindow);
void						QTFrame_CloseWindowObject (WindowObject theWindowObject);

WindowReference				QTFrame_GetFrontAppWindow (void);
WindowReference				QTFrame_GetNextAppWindow (WindowReference theWindow);
WindowReference				QTFrame_GetFrontMovieWindow (void);
WindowReference				QTFrame_GetNextMovieWindow (WindowReference theWindow);
WindowObject				QTFrame_GetWindowObjectFromFrontWindow (void);
WindowObject				QTFrame_GetWindowObjectFromWindow (WindowReference theWnd);
MovieController  			QTFrame_GetMCFromFrontWindow (void);
MovieController				QTFrame_GetMCFromWindow (WindowReference theWindow);
QTVRInstance				QTFrame_GetQTVRInstanceFromFrontWindow (void);
QTVRInstance				QTFrame_GetQTVRInstanceFromWindow (WindowReference theWindow);
Handle						QTFrame_GetAppDataFromFrontWindow (void);
Handle						QTFrame_GetAppDataFromWindow (WindowReference theWnd);
Handle						QTFrame_GetAppDataFromWindowObject (WindowObject theWindowObject);
Boolean 					QTFrame_IsWindowObjectOurs (WindowObject theWindowObject);
Boolean						QTFrame_IsAppWindow (WindowReference theWindow);
Boolean						QTFrame_IsDocWindow (WindowReference theWindow);
void 						QTFrame_ActivateController (WindowReference theWindow, Boolean IsActive);

void						QTFrame_Beep (void);
void						QTFrame_SetMenuState (MenuReference theMenu, UInt16 theMenuRank, short theState);
void						QTFrame_SetMenuItemState (MenuReference theMenu, UInt16 theMenuItem, short theState);
void						QTFrame_SetMenuItemLabel (MenuReference theMenu, UInt16 theMenuItem, char *theText);
void						QTFrame_SetMenuItemCheck (MenuReference theMenu, UInt16 theMenuItem, Boolean theState);
GrafPtr						QTFrame_GetPortFromWindowReference (WindowReference theWindow);
WindowReference				QTFrame_GetWindowReferenceFromPort (GrafPtr thePort);
WindowPtr					QTFrame_GetWindowFromWindowReference (WindowReference theWindow);
short						QTFrame_GetWindowWidth (WindowReference theWindow);
void						QTFrame_SetWindowTitleFromFSSpec (WindowReference theWindow, FSSpecPtr theFSSpecPtr, Boolean theAddToRecentDocs);
void						QTFrame_SizeWindowToMovie (WindowObject theWindowObject);

OSErr						QTFrame_PutFile (ConstStr255Param thePrompt, ConstStr255Param theFileName, FSSpecPtr theFSSpecPtr, Boolean *theIsSelected, Boolean *theIsReplacing);
OSErr						QTFrame_GetOneFileWithPreview (short theNumTypes, QTFrameTypeListPtr theTypeList, FSSpecPtr theFSSpecPtr, void *theFilterProc);
PASCAL_RTN void				QTFrame_HandleNavEvent (NavEventCallbackMessage theCallBackSelector, NavCBRecPtr theCallBackParms, void *theCallBackUD);
Handle						QTFrame_CreateOpenHandle (OSType theApplicationSignature, short theNumTypes, QTFrameTypeListPtr theTypeList);
QTFrameFileFilterUPP		QTFrame_GetFileFilterUPP (ProcPtr theFileFilterProc);
OSErr						QTFrame_BuildFileTypeList (void);
static void					QTFrame_AddComponentFileTypes (OSType theComponentType, long *theNextIndex);

#if TARGET_OS_MAC
PASCAL_RTN Boolean			QTFrame_FilterFiles (AEDesc *theItem, void *theInfo, void *theCallBackUD, NavFilterModes theFilterMode);
#endif
#if TARGET_OS_WIN32
PASCAL_RTN Boolean			QTFrame_FilterFiles (CInfoPBPtr thePBPtr);
void						QTFrame_ConvertMacToWinRect (Rect *theMacRect, RECT *theWinRect);
void						QTFrame_ConvertWinToMacRect (RECT *theWinRect, Rect *theMacRect);
#endif


//////////
//
// application-specific function prototypes
//
// These are defined in the file ComApplication.c; both MacFramework.c and WinFramework.c
// call these functions at specific times; you can use them to customize a specific application.
//	   
//////////

void						QTApp_Init (UInt32 theStartPhase);
void						QTApp_Stop (UInt32 theStopPhase);
void						QTApp_Idle (WindowReference theWindow);
void						QTApp_Draw (WindowReference theWindow, Rect *theRefrehArea);
void 						QTApp_HandleContentClick (WindowReference theWindow, EventRecord *theEvent);
Boolean						QTApp_HandleKeyPress (char theCharCode);
Boolean 					QTApp_HandleMenu (UInt16 theMenuItem);
void						QTApp_AdjustMenus (WindowReference theWindow, MenuReference theMenu);
Boolean						QTApp_HandleEvent (EventRecord *theEvent);
void						QTApp_SetupController (MovieController theMC);
void						QTApp_SetupWindowObject (WindowObject theWindowObject);
void						QTApp_RemoveWindowObject (WindowObject theWindowObject);
PASCAL_RTN Boolean			QTApp_MCActionFilterProc (MovieController theMC, short theAction, void *theParams, long theRefCon);


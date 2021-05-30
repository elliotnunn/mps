/*------------------------------------------------------------------------------
#
#	MultiFinder-Aware Simple Shapes Sample Application
#
#	CPlusShapesApp
#
#	This file: ShapesApp.cp - Implementation of the TShapesApp Class
#
#	Copyright © 1988 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	1.0 				3/89
#
#	Components:
#			CPlusShapesApp.make		March 1, 1989
#			TApplicationCommon.h	March 1, 1989
#			TApplication.h			March 1, 1989
#			TDocument.h				March 1, 1989
#			ShapesAppCommon.h		March 1, 1989
#			ShapesApp.h				March 1, 1989
#			ShapesDocument.h		March 1, 1989
#			TApplication.cp			March 1, 1989
#			TDocument.cp			March 1, 1989
#			ShapesApp.cp			March 1, 1989
#			ShapesDocument.cp		March 1, 1989
#			TApplication.r			March 1, 1989
#			ShapesApp.r				March 1, 1989
#
#   There are four main classes in this program. Each of
#   these classes has a definition (.h) file and an
#   implementation (.cp) file.  
#   
#   The TApplication class does all of the basic event
#   handling and initialization necessary for Mac Toolbox
#   applications. It maintains a list of TDocument objects,
#   and passes events to the correct TDocument class when
#   apropriate. 
#   
#   The TDocument class does all of the basic document
#   handling work. TDocuments are objects that are
#   associated with a window. Methods are provided to deal
#   with update, activate, mouse-click, key down, and other
#   events. Some additional classes which implement a
#   linked list of TDocument objects are provided. 
#   
#   The TApplication and TDocument classes together define
#   a basic framework for Mac applications, without having
#   any specific knowledge about the type of data being
#   displayed by the application's documents. They are a
#   (very) crude implementation of the MacApp application
#   model, without the sophisticated view heirarchies or
#   any real error handling. 
#   
#   The TShapesApp class is a subclass of TApplication. It
#   overrides several TApplication methods, including those
#   for handling menu commands and cursor adjustment, and
#   it does some necessary initialization.
#   
#   The TShapesDocument class is a subclass of TDocument. This
#   class contains most of the special purpose code for
#   shape drawing. In addition to overriding several of the
#   TDocument methods, it defines a few additional
#   methods which are used by the TShapesApp class to get
#   information on the document state.  
#
#------------------------------------------------------------------------------*/
#include <Types.h>
#include <QuickDraw.h>
#include <Fonts.h>
#include <Events.h>
#include <Controls.h>
#include <Windows.h>
#include <Menus.h>
#include <TextEdit.h>
#include <Dialogs.h>
#include <Desk.h>
#include <Scrap.h>
#include <ToolUtils.h>
#include <Memory.h>
#include <SegLoad.h>
#include <Files.h>
#include <OSUtils.h>
#include <Traps.h>

// our class definitions
#include "ShapesDocument.h"
#include "ShapesApp.h"

// ExtremeNeg and ExtremePos are used to set up wide open rectangles and regions.
const short kExtremeNeg = -32768;
const short kExtremePos = 32767 - 1; // required to address an old region bug

// kMaxOpenDocuments is used to determine whether a new document can be opened
// or created. We keep track of the number of open documents, and disable the
// menu items that create a new document when the maximum is reached. If the
// number of documents falls below the maximum, the items are enabled again. */
const short	kMaxOpenDocuments = 1;
	
// Define HiWrd and LoWrd macros for efficiency.
#define HiWrd(aLong)	(((aLong) >> 16) & 0xFFFF)
#define LoWrd(aLong)	((aLong) & 0xFFFF)

// Our application object, initialized in main(). We make it
// global so our functions which don't belong to any class
// can find the active document.
TShapesApp *gTheApplication;

// main is the entrypoint to the program
int main(void)
{
	// Create our application object. This MUST be the FIRST thing
	// done in main(), since it initializes the Toolbox for us.
	gTheApplication = new TShapesApp;
	if (gTheApplication == nil)		// if we couldn't allocate object (impossible!?)
	  return 0;						// go back to Finder
	
	// Start our main event loop running. This won't return until user quits
	gTheApplication->EventLoop();

	// We always return a value, like good little ANSI worshippers
	return 0;
}

// the constructor for our class, called automatically when we create
// an instance of this class. In this particular case, we only want
// one instance since the constructor does all the menu setups and
// creates our (untitled) document.
TShapesApp::TShapesApp(void)
{
	Handle	menuBar;

	// read menus into menu bar
	menuBar = GetNewMBar(rMenuBar);
	// install menus
	SetMenuBar(menuBar);
	DisposHandle(menuBar);
	// add DA names to Apple menu
	AddResMenu(GetMHandle(mApple), 'DRVR');
	DrawMenuBar();

	// create empty mouse region
	fMouseRgn = NewRgn();
	// create a single empty document
	DoNew();
}

// Tell TApplication class how much heap we need
long TShapesApp::HeapNeeded(void)
{
	return (kMinSize * 1024);
}

// Calculate a sleep value for WaitNextEvent. This takes into account the things
// that DoIdle does with idle time.

unsigned long TShapesApp::SleepVal(void)
{
	unsigned long sleep;
	const long kSleepTime = 0x7fffffff;	// a very large positive number

	sleep = kSleepTime;				// default value for sleep
	if ((!fInBackground))
	{
		  sleep = GetCaretTime();	// A reasonable time interval for MenuClocks, etc.
	}
	return sleep;
}

// Enable and disable menus based on the current state. The
// user can only select enabled menu items. We set up all the
// menu items before calling MenuSelect or MenuKey, since
// these are the only times that a menu item can be selected.
// Note that MenuSelect is also the only time the user will
// see menu items. This approach to deciding what enable/
// disable state a menu item has the advantage of
// concentrating all the decision-making in one routine, as
// opposed to being spread throughout the application. Other
// application designs may take a different approach that may
// or may not be as valid. 

void TShapesApp::AdjustMenus(void)
{
	WindowPtr	frontmost;
	MenuHandle	menu;
	Boolean		undo;
	Boolean		cutCopyClear;
	Boolean		paste;
	Boolean		shape, move;
	TShapesDocument* fShapesCurDoc = (TShapesDocument*) fCurDoc;

	frontmost = FrontWindow();

	menu = GetMHandle(mFile);
	if ( fDocList->NumDocs() < kMaxOpenDocuments )
	  EnableItem(menu, iNew);			// New is enabled when we can open more documents 
	else DisableItem(menu, iNew);
	if ( frontmost != (WindowPtr) nil )	// Close is enabled when there is a window to close 
	  EnableItem(menu, iClose);
	else DisableItem(menu, iClose);

	undo = false;
	cutCopyClear = false;
	paste = false;
	shape = false;
	move = false;
	
	if ( fShapesCurDoc == nil )
	  {
		undo = true;				// all editing is enabled for DA windows 
		cutCopyClear = true;
		paste = true;
	  }
	else
	  {
		shape = true;
		if (fShapesCurDoc->HasShape()) move = true;
	  }
	  
	menu = GetMHandle(mEdit);
	if ( undo )
		EnableItem(menu, iUndo);
	else
		DisableItem(menu, iUndo);
	
	if ( cutCopyClear )
	  {
		EnableItem(menu, iCut);
		EnableItem(menu, iCopy);
		EnableItem(menu, iClear);
	  } 
	else
	  {
		DisableItem(menu, iCut);
		DisableItem(menu, iCopy);
		DisableItem(menu, iClear);
	  }
	  
	if ( paste )
		EnableItem(menu, iPaste);
	else
		DisableItem(menu, iPaste);
		
	menu = GetMHandle(mShapes);
	if ( shape )
	  {
		EnableItem(menu, iRRect);
		EnableItem(menu, iOval);
		EnableItem(menu, iArc);
	  }
	else
	  {
		DisableItem(menu, iRRect);
		DisableItem(menu, iOval);
		DisableItem(menu, iArc);
	  }
		
	if ( move )
		EnableItem(menu, iMove);
	else
		DisableItem(menu, iMove);
	
} // AdjustMenus


// This is called when an item is chosen from the menu bar (after calling
// MenuSelect or MenuKey). It does the right thing for each command.

void TShapesApp::DoMenuCommand(short menuID, short menuItem)
{
	short		itemHit;
	Str255		daName;
	short		daRefNum;
	WindowPtr	window;
	Rect		moveRect;
	TShapesDocument* fShapesCurDoc = (TShapesDocument*) fCurDoc;

	window = FrontWindow();
	switch ( menuID )
	  {
		case mApple:
			switch ( menuItem )
			  {
				case iAbout:		// bring up alert for About 
					itemHit = Alert(rAboutAlert, nil);
					break;
				default:			// all non-About items in this menu are DAs et al 
					GetItem(GetMHandle(mApple), menuItem, daName);
					daRefNum = OpenDeskAcc(daName);
					break;
			  }
			break;
		case mFile:
			switch ( menuItem )
			  {
				case iNew:
					DoNew();
					break;
				case iClose:
					if (fShapesCurDoc != nil)
					  {
						fDocList->RemoveDoc(fShapesCurDoc);
						delete fShapesCurDoc;
					  }
					else CloseDeskAcc(((WindowPeek) fWhichWindow)->windowKind);
					break;
				case iQuit:
					Terminate();
					break;
			  }
			break;
		case mEdit:					// call SystemEdit for DA editing & MultiFinder 
			if ( !SystemEdit(menuItem-1) )
			  {
				switch ( menuItem )
				  {
					case iCut:
						break;
					case iCopy:
						break;
					case iPaste:
						break;
					case iClear:
						break;
				   }
			  }
			break;
		case mShapes:
			switch ( menuItem )
			  {
				case iMove:
					if (fShapesCurDoc != nil && fShapesCurDoc->HasShape()) {
						// Get the window size to constrain the move
						moveRect = (fShapesCurDoc->GetDocWindow())->portRect;
						
						fShapesCurDoc->GetShape()->Erase();
						fShapesCurDoc->GetShape()->Move(&moveRect);
						fShapesCurDoc->GetShape()->Draw(qd.gray);
					}
					break;
				default:
					if (fShapesCurDoc != nil)
						fShapesCurDoc->ChangeShape(menuItem);
					break;
			   }
			break;
	  }
	HiliteMenu(0);					// unhighlight what MenuSelect (or MenuKey) hilited 
} // DoMenuCommand

// Create a new document and window. 

void TShapesApp::DoNew(void)
{
	TShapesDocument* tShapesDoc;
	
	tShapesDoc = new TShapesDocument(rDocWindow);
	// if we didn't get an allocation error, add it to list
	if (tShapesDoc != nil)
	  fDocList->AddDoc(tShapesDoc);
} // DoNew

// Clean up the application and exits. We close all of the windows so that
// they can update their documents.

void TShapesApp::Terminate(void)
{
	// FIX: close all docs
	ExitLoop();
} // Terminate


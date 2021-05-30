/*------------------------------------------------------------------------------
#
#	MultiFinder-Aware Simple Shapes Sample Application
#
#	CPlusShapesApp
#
#	This file: ShapesApp.cp - Implementation of the TShapesDocument Class
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
// Mac Includes
#include <Types.h>
#include <QuickDraw.h>
#include <Fonts.h>
#include <Events.h>
#include <Controls.h>
#include <Windows.h>
#include <Menus.h>
#include <Dialogs.h>
#include <Desk.h>
#include <Scrap.h>
#include <ToolUtils.h>
#include <Memory.h>
#include <SegLoad.h>
#include <Files.h>
#include <OSUtils.h>
#include <Traps.h>

#include "ShapesDocument.h"
#include "ShapesApp.h"

// kMinDocDim is used to limit the minimum dimension of a window when GrowWindow
// is called.
const short	kMinDocDim = 64;
	
// Define HiWrd and LoWrd macros for efficiency.
#define HiWrd(aLong)	(((aLong) >> 16) & 0xFFFF)
#define LoWrd(aLong)	((aLong) & 0xFFFF)

// Define TopLeft and BotRight macros for convenience. Notice the implicit
// dependency on the ordering of fields within a Rect
#define TopLeft(aRect)	(* (Point *) &(aRect).top)
#define BotRight(aRect)	(* (Point *) &(aRect).bottom)

// notice that we pass the resID parameter up to our base class,
// which actually creates the window for us
TShapesDocument::TShapesDocument(short resID)	: (resID)
{
	fShapeObj = nil;
	
	ShowWindow(fDocWindow);		// Make sure the window is visible
}

// At this point, if there was a document associated with a
// window, you could do any document saving processing if it is 'dirty'.
// DoCloseWindow would return true if the window actually closed, i.e.,
// the user didn’t cancel from a save dialog. This result is handy when
// the user quits an application, but then cancels the save of a document
// associated with a window.

TShapesDocument::~TShapesDocument(void)
{
	HideWindow(fDocWindow);
	
	if (fShapeObj) delete fShapeObj;
	
	// base class destructor will dispose of window
}

void TShapesDocument::DoUpdate(void)
{
	BeginUpdate(fDocWindow);				// this sets up the visRgn 
	if ( ! EmptyRgn(fDocWindow->visRgn) )	// draw if updating needs to be done 
	  {
		DrawWindow();
	  }
	EndUpdate(fDocWindow);
}

// Draw the contents of an application window. 

void TShapesDocument::DrawWindow(void)
{
	SetPort(fDocWindow);
	EraseRect(&fDocWindow->portRect);

	if (HasShape())
		fShapeObj->Draw(qd.gray);

} // DrawWindow

// Change the type of shape displayed in the window

void TShapesDocument::ChangeShape(int newShape)
{
	Rect newRect = fDocWindow->portRect;
	
	SetPort(fDocWindow);

	if (HasShape()) {
		fShapeObj->Erase();
		delete fShapeObj;
		fShapeObj = nil;
	}
	
	switch (newShape) {
		case iRRect:
			fShapeObj = new TRoundRect(&newRect);
			break;
		case iOval:
			fShapeObj = new TOval(&newRect);
			break;
		case iArc:
			fShapeObj = new TArc(&newRect);
			break;
	}
	
	fShapeObj->Draw(qd.gray);
}

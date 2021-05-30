/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple TextEdit Sample Application
#
#	CPlusTESample
#
#	TESample.cp	-	C++ source
#
#	Copyright © 1989 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	
#			1.20					10/91
#			1.10 					07/89
#			1.00 					04/89
#
#	Components:
#			CPlusTESample.make		July 9, 1989
#			TApplicationCommon.h	July 9, 1989
#			TApplication.h			July 9, 1989
#			TDocument.h				July 9, 1989
#			TECommon.h				July 9, 1989
#			TESample.h				July 9, 1989
#			TEDocument.h			July 9, 1989
#			TESample.cp				July 9, 1989
#			TESample.r				July 9, 1989
#
#	CPlusTESample is an example application that demonstrates
#	how to initialize the commonly used toolbox managers,
#	operate successfully under MultiFinder, handle desk
#	accessories and create, grow, and zoom windows. The
#	fundamental TextEdit toolbox calls and TextEdit autoscroll
#	are demonstrated. It also shows how to create and maintain
#	scrollbar controls. 
#
#	This version of TESample has been substantially reworked in
#	C++ to show how a "typical" object oriented program could
#	be written. To this end, what was once a single source code
#	file has been restructured into a set of classes which
#	demonstrate the advantages of object-oriented programming.
#
------------------------------------------------------------------------------*/


/*
Segmentation strategy:

    This program has only one segment, since the issues
    surrounding segmentation within a class's methods have
    not been investigated yet. We DO unload the data
    initialization segment at startup time, which frees up
    some memory 

SetPort strategy:

    Toolbox routines do not change the current port. In
    spite of this, in this program we use a strategy of
    calling SetPort whenever we want to draw or make calls
    which depend on the current port. This makes us less
    vulnerable to bugs in other software which might alter
    the current port (such as the bug (feature?) in many
    desk accessories which change the port on OpenDeskAcc).
    Hopefully, this also makes the routines from this
    program more self-contained, since they don't depend on
    the current port setting. 

Clipboard strategy:

    This program does not maintain a private scrap.
    Whenever a cut, copy, or paste occurs, we import/export
    from the public scrap to TextEdit's scrap right away,
    using the TEToScrap and TEFromScrap routines. If we did
    use a private scrap, the import/export would be in the
    activate/deactivate event and suspend/resume event
    routines. 
*/

#include <Types.h>
#include <Quickdraw.h>
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
#include "TEDocument.h"
#include "TESample.h"

// ExtremeNeg and ExtremePos are used to set up wide open rectangles and regions.
const short kExtremeNeg = -32768;
const short kExtremePos = 32767 - 1; // required to address an old region bug

// kMaxOpenDocuments is used to determine whether a new document can be opened
// or created. We keep track of the number of open documents, and disable the
// menu items that create a new document when the maximum is reached. If the
// number of documents falls below the maximum, the items are enabled again. */
const short	kMaxOpenDocuments = 1;
	
// Define max and min macros for efficiency.
#define max(a,b)		((a) > (b) ? (a) : (b))
#define min(a,b)		((a) < (b) ? (a) : (b))

// Our application object, initialized in main(). We make it
// global so our functions which don't belong to any class
// can find the active document.
	TESample *gTheApplication;



/***********************************************************************/
//
// TESample
//
/***********************************************************************/

//-----------------------------------------------------------------------
// main -	main is the entrypoint to the program
// 
	int main( void )
	{
		// Create our application object. This MUST be the FIRST thing
		// done in main(), since it initializes the Toolbox for us.
			gTheApplication = new TESample;
			if (gTheApplication == nil)						// if we couldn't allocate object (impossible!?)
				return 0;									// go back to Finder
		
		// Start our main event loop running. This won't return until user quits
			gTheApplication->EventLoop();
	
		// We always return a value, like good little ANSI worshippers
			return 0;
			
	} /* main */



/***********************************************************************/
//
// TESample class declarations
//
/***********************************************************************/

//-----------------------------------------------------------------------
// TESample::TESample -	the constructor for our class, called automatically when we create
// 						an instance of this class. In this particular case, we only want
// 						one instance since the constructor does all the menu setups and
// 						creates our (untitled) document.
//
	TESample::TESample( void )
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
		
		// make sure we have a valid cursor region
			AdjustCursor();
			
	} /* TESample (constructor) */


//-----------------------------------------------------------------------
// TESample::HeapNeeded -	Tell TApplication class how much heap we need
//
	long TESample::HeapNeeded( void )
	{
		return ( kMinSize * 1024 );
		
	} /* TESample::HeapNeeded */


//-----------------------------------------------------------------------
// TESample::HeapNeeded -	Calculate a sleep value for WaitNextEvent. This
//							takes into account the things that DoIdle does
//							with idle time.
//
	unsigned long TESample::SleepVal( void )
	{
		unsigned long sleep;
	
		sleep = kMaxSleepTime;				// default value for sleep
		
		// if we aren't in background, let document tell us how long to sleep
			if (( !fInBackground ) && ( fCurDoc != nil ))
				sleep = min( sleep, fCurDoc->CalcIdle());
				
			return sleep;
		
	} /* TESample::SleepVal */


//-----------------------------------------------------------------------
// TESample::DoIdle -	This is called whenever we get a null event et al.
// 						It takes care of necessary periodic actions. For this program,
// 						it calls TEIdle.
//
	void TESample::DoIdle( void )
	{
		TEDocument* fTECurDoc = (TEDocument*) fCurDoc;
	
		if ( fTECurDoc != nil )
			fTECurDoc->DoIdle();
		  
	} /* TESample::DoIdle */


//-----------------------------------------------------------------------
// TESample::AdjustCursor -	This is called whenever we get a null event et al.
// 							Change the cursor's shape, depending on its position.
//							This also calculates a region that includes the
//							cursor for WaitNextEvent.
//
	void TESample::AdjustCursor( void )
	{
		TEDocument* fTECurDoc = (TEDocument*) fCurDoc;
	
		// notice that we don't change cursor if front window isn't ours
			if (( !fInBackground ) && ( fTECurDoc != nil ))
			  {
				RgnHandle	arrowRgn;
				RgnHandle	iBeamRgn;
				Point		mouse;
				
				// get mouse location and convert to global coordinates
					GetMouse( &mouse );
					LocalToGlobal( &mouse );
		
				// calculate regions for different cursor shapes
					arrowRgn = NewRgn();
					iBeamRgn = NewRgn();
				
				// start arrowRgn wide open
					SetRectRgn(arrowRgn, kExtremeNeg, kExtremeNeg, kExtremePos, kExtremePos);
					
				// calculate iBeamRgn
					fTECurDoc->GetVisTERgn( iBeamRgn );
					
				// subtract iBeamRgn from arrowRgn 
					DiffRgn(arrowRgn, iBeamRgn, arrowRgn);
		
				// change the cursor and the region parameter 
					if ( PtInRgn(mouse, iBeamRgn ))
					{
						SetCursor( *GetCursor( iBeamCursor ));
						CopyRgn( iBeamRgn, fMouseRgn );
					}
					else
					{
						SetCursor( &qd.arrow );
						CopyRgn( arrowRgn, fMouseRgn );
					}
					
				// get rid of regions we don't need anymore
					DisposeRgn( arrowRgn );
					DisposeRgn( iBeamRgn );
			  }
	} /* TESample::AdjustCursor */


//-----------------------------------------------------------------------
// TESample::AdjustMenus -	Enable and disable menus based on the current state.
// 							The user can only select enabled menu items. We set
//							up all the menu items before calling MenuSelect or
//							MenuKey, since these are the only times that a menu
//							item can be selected. Note that MenuSelect is also
//							the only time the user will see menu items. This
//							approach to deciding what enable/disable state a
//							menu item has the advantage of concentrating all the
//							decision-making in one routine, as opposed to being
//							spread throughout the application. Other application
//							designs may take a different approach that may or may
//							not be as valid. 
//
	void TESample::AdjustMenus( void )
	{
		WindowPtr	frontmost;
		MenuHandle	menu;
		long		offset;
		Boolean		undo;
		Boolean		cutCopyClear;
		Boolean		paste;
		TEDocument* fTECurDoc = (TEDocument*) fCurDoc;
	
		frontmost = FrontWindow();
	
		menu = GetMHandle( mFile );
		if ( fDocList->NumDocs() < kMaxOpenDocuments )	// New is enabled when we can open more documents 
			EnableItem( menu, iNew );					
		else
			DisableItem( menu, iNew );
		
		if ( frontmost != (WindowPtr) nil )				// Close is enabled when there is a window to close 
			EnableItem( menu, iClose );
		else
			DisableItem( menu, iClose );
	
		menu = GetMHandle( mEdit );
		undo = false;
		cutCopyClear = false;
		paste = false;
		
		if ( frontmost != nil )
		{
			if ( fTECurDoc == nil )
			{
				undo = true;							// all editing is enabled for DA windows 
				cutCopyClear = true;
				paste = true;
			}
			else
			{
				// Cut, Copy, and Clear is enabled for app. windows with selections 
					if ( fTECurDoc->HaveSelection())
						cutCopyClear = true;
					
				// If we have any TEXT in the scrap, enable paste
					if ( GetScrap( nil, 'TEXT', &offset ))
						paste = true; 
			}
		}
		
		if ( undo )
			EnableItem( menu, iUndo );
		else
			DisableItem( menu, iUndo );
			
		if ( cutCopyClear )
		{
			EnableItem( menu, iCut );
			EnableItem( menu, iCopy );
			EnableItem( menu, iClear );
		} 
		else
		{
			DisableItem( menu, iCut );
			DisableItem( menu, iCopy );
			DisableItem( menu, iClear );
		}
		
		if ( paste )
			EnableItem( menu, iPaste );
		else
			DisableItem( menu, iPaste );
			
	} /* TESample::AdjustMenus */


//-----------------------------------------------------------------------
// TESample::DoMenuCommand -	This is called when an item is chosen from the 
//								menu bar (after calling MenuSelect or MenuKey).
//								It does the right thing for each command.
//
	void TESample::DoMenuCommand( short menuID, short menuItem )
	{
		short		itemHit;
		Str255		daName;
		short		daRefNum;
		WindowPtr	window;
		TEDocument* fTECurDoc = (TEDocument*) fCurDoc;
	
		window = FrontWindow();
		switch ( menuID )
		{
			case mApple:	switch ( menuItem )
							{
								case iAbout:	itemHit = Alert( rAboutAlert, nil );					// bring up alert for About 
												break;
									
								default:		GetItem( GetMHandle(mApple), menuItem, daName );		// all non-About items in this menu are DAs et al 
												daRefNum = OpenDeskAcc( daName );
												break;
							}
							break;
							
			case mFile:		switch ( menuItem )
							{
								case iNew:		DoNew();
												break;
												
								case iClose:	if (fTECurDoc != nil)
												{
													fDocList->RemoveDoc( fTECurDoc );
													fTECurDoc->DoClose();
												}
												else
													CloseDeskAcc(((WindowPeek) fWhichWindow)->windowKind );
													
												// make sure our current document/window references are valid
													fWhichWindow = FrontWindow();
													if ( fWhichWindow != nil )
													{
														fCurDoc = fDocList->FindDoc( fWhichWindow );
														SetPort( fWhichWindow );
													}
													else
														fCurDoc = nil;
												break;
												
								case iQuit:		Terminate();
												break;
							}
							break;
							
			case mEdit:		if ( !SystemEdit( menuItem-1 ))							// call SystemEdit for DA editing & MultiFinder 
							{
								switch ( menuItem )
								{
									case iCut:		fTECurDoc->DoCut();
													break;
												
									case iCopy:		fTECurDoc->DoCopy();
													break;
												
									case iPaste:	fTECurDoc->DoPaste();
													break;
													
									case iClear:	fTECurDoc->DoClear();
													break;
								}
							}
							break;
			
			case mDebug:	
							DebugStr ((ConstStr255Param) "\pEntering Debugger...");
							break;
							
		}
		HiliteMenu( 0 );	// unhighlight what MenuSelect (or MenuKey) hilited 
		
	} /* TESample::DoMenuCommand */


//-----------------------------------------------------------------------
// TESample::DoNew -	Create a new document and window. 
//
	void TESample::DoNew( void )
	{
		TEDocument* tDoc;
	
		tDoc = new TEDocument( rDocWindow );
		
		// if we didn't get an allocation error, add it to list
			if ( tDoc != nil )
				fDocList->AddDoc( tDoc );
			else
				AlertUser( kTEDocErrStrings, eNoWindow );
			
	} /* TESample::DoNew */


//-----------------------------------------------------------------------
// TESample::Terminate -	Clean up the application and exits. You might
//							want to close all of your documents (and ask
//							the user to save them) here.
//
	void TESample::Terminate( void )
	{
		ExitLoop();
		
	} /* TESample::Terminate */


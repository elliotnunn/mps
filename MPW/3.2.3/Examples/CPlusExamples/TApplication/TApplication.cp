/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple Application Framework
#
#	TApplication
#
#	TApplication.cp		-	C++ source
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
#			TApplicationCommon.h	July 9, 1989
#			TApplication.h			July 9, 1989
#			TApplication.cp			July 9, 1989
#			TApplication.r			July 9, 1989
#			TDocument.h				July 9, 1989
#
#	TApplication is a rudimentary application framework
#	for C++. The applications CPlusShapesApp and CPlusTESample
#	are built using CPlusAppLib.
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

// Mac Includes
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

#include "TApplication.h"					// use the local version. If you make changes
											// that you've debugged and want other files
											// to use, simple copy this header file into
											// the C++ Includes folder (don't forget to
											// copy the TApplication object library to the C++
											// Libraries folder)!

// OSEvent is the event number of the suspend/resume and mouse-moved events sent
// by MultiFinder. Once we determine that an event is an osEvent, we look at the
// high byte of the message sent to determine which kind it is. To differentiate
// suspend and resume events we check the resumeMask bit.
const short kOsEvent = app4Evt;				// event used by MultiFinder
const short kSuspendResumeMessage = 0x01;	// high byte of suspend/resume event message
const short kClipConvertMask = 0x02;		// bit of message field clip conversion
const short kResumeMask = 0x01;				// bit of message field for resume vs. suspend
const short kMouseMovedMessage = 0xFA;		// high byte of mouse-moved event message

extern "C"
{ 
	// from MPW standard library
		void _DataInit(void);				// sets up A5 globals
};

/***********************************************************************/
//
// TApplication class declarations
//
/***********************************************************************/

//-----------------------------------------------------------------------
// TApplication::TApplication - 	
//
	TApplication::TApplication( void )
	{
		SysEnvRec envRec;
		long stkNeeded, heapSize;
	
		// initialize Mac Toolbox components
			InitGraf((Ptr) &qd.thePort );
			InitFonts();
			InitWindows();
			InitMenus();
			TEInit();
			InitDialogs((ResumeProcPtr) nil);
			InitCursor();
	
		// Unload data segment: note that _DataInit must not be in Main!
			UnloadSeg((ProcPtr) _DataInit);
	
		// ignore the error returned from SysEnvirons; even if an error occurred,
		// the SysEnvirons glue will fill in the SysEnvRec
			( void ) SysEnvirons( curSysEnvVers, &envRec );
	
		// Are we running on a 128K ROM machine or better???
			if ( envRec.machineType < 0 )
				BigBadError( kErrStrings,eWrongMachine );		// if not, alert & quit
	
		// if we need more stack space, get it now
			stkNeeded = StackNeeded();
			if (stkNeeded > StackSpace())
			{
				// new address is heap size + current stack - needed stack
					SetApplLimit((Ptr) ((long) GetApplLimit() - stkNeeded + StackSpace()));
			}
	
		// Check for minimum heap size
			heapSize = (long) GetApplLimit() - (long) ApplicZone();
			if ( heapSize < HeapNeeded())
				BigBadError( kErrStrings, eSmallSize );
	
		// expand the heap so new code segments load at the top
			MaxApplZone();
	
		// allocate an empty document list
			fDocList = new TDocumentList;
	
		// check to see if WaitNextEvent is implemented
			fHaveWaitNextEvent = TrapAvailable( _WaitNextEvent, ToolTrap );
	
		// initialize our class variables
			fCurDoc = nil;
			fDone = false;
			fInBackground = false;
			fMouseRgn = nil;
			fWhichWindow = nil;
			
	} /* TApplication (constructor) */


//-----------------------------------------------------------------------
// TApplication::ExitLoop - 	we're quitting the application; let's
//								do whatever needs to be done to clean up.
//								In our case, there isn't much to be done.
//
	void TApplication::ExitLoop( void )
	{
		fDone = true;
	}


//-----------------------------------------------------------------------
// TApplication::EventLoop - 	keep track of events and handle them
//								appropriately.
//
	void TApplication::EventLoop( void )
	{
		int gotEvent;
		EventRecord tEvt;
	
		SetUp();					// call setup routine
		DoIdle();					// do idle once
	
		while (fDone == false)
		  {
			// always set up fWhichWindow before doing anything
				fWhichWindow = FrontWindow();
				
			// see if window belongs to a document
				fCurDoc = fDocList->FindDoc(fWhichWindow);
				
			// make sure we always draw into correct window
				SetPort(fWhichWindow);
	
			// let's allow others to use the cpu if they need (Multifinder friendliness).
				DoIdle();			// call idle time handler. this lets apps blink the caret
									// or whatever else they wish to do
			
			// 	determine if an event has occurred and what to do about it
				if ( fHaveWaitNextEvent )
				{
					gotEvent = WaitNextEvent( everyEvent, &tEvt, SleepVal(), fMouseRgn );
				}
				else
				{
					SystemTask();
					gotEvent = GetNextEvent( everyEvent, &tEvt );
				}
				fTheEvent = tEvt;
	
			// make sure we got a real event
				if ( gotEvent )
				{
					AdjustCursor();
					switch (fTheEvent.what)
					{
						case mouseDown :	DoMouseDown();
											break;
											
						case mouseUp :		DoMouseUp();
											break;
											
						case keyDown :
						case autoKey :		DoKeyDown();
											break;
											
						case updateEvt :	DoUpdateEvt();				
											break;
											
						case diskEvt :		DoDiskEvt();
											break;
											
						case activateEvt :	DoActivateEvt();
											break;
											
						case kOsEvent :		DoOSEvent();
											break;
											
						default :			break;
						
					} // end switch (fTheEvent.what)
				}
				
			// update the cursor shape as needed after the event
				AdjustCursor();
		}
		// call cleanup handler
		CleanUp();
		
	}  /* TApplication::EventLoop */


//-----------------------------------------------------------------------
// TApplication::DoKeyDown - 	simple routine to handle key presses.
//
	void TApplication::DoKeyDown( void )
	{
		char key;
		long mResult;
	
		key = (char) ( fTheEvent.message & charCodeMask );
		if (( fTheEvent.modifiers & cmdKey ) && ( fTheEvent.what == keyDown ))
		{
			// only do command keys if we are not autokeying
				AdjustMenus();					// make sure menus are up to date
				mResult = MenuKey( key );
				if ( mResult != 0 )				// if it wasn't a menu key, pass it through
				{
					DoMenuCommand( HiWrd( mResult ), LoWrd( mResult ));
					return;
				}
		}
		
		if ( fCurDoc != nil )
		{
			EventRecord tEvt;
	
			// we copy event record so that we don't pass reference to object field 
			tEvt = fTheEvent;
			fCurDoc->DoKeyDown( &tEvt );
		}
		  
	}  /* TApplication::DoKeyDown */


//-----------------------------------------------------------------------
// TApplication::DoActivateEvt - 	a window is becoming active. if it is
//									one of ours, call the document's activate
//									routine.
//
	void TApplication::DoActivateEvt( void )
	{
		// event record contains window ptr
			fWhichWindow = (WindowPtr) fTheEvent.message;

		// see if window belongs to a document
			fCurDoc = fDocList->FindDoc( fWhichWindow );
			SetPort( fWhichWindow );
	
		if ( fCurDoc != nil )
		  fCurDoc->DoActivate(( fTheEvent.modifiers & activeFlag ) != 0 );
	
	}  /* TApplication::DoActivateEvt */


//-----------------------------------------------------------------------
// TApplication::DoUpdateEvt - 	a window needs to be updated. If it is one
//								of ours, call the document's update routine
//								to redraw it.
//
	void TApplication::DoUpdateEvt(void)
	{
		// event record contains window ptr
			fWhichWindow = (WindowPtr) fTheEvent.message;

		// see if window belongs to a document
			fCurDoc = fDocList->FindDoc( fWhichWindow );
			SetPort( fWhichWindow );
		
			if ( fCurDoc != nil )
				fCurDoc->DoUpdate();
		  
	}  /* TApplication::DoUpdateEvt */


//-----------------------------------------------------------------------
// TApplication::DoSuspend - 	although our suspend and resume routine are
//								identical, let's use two distinct routines
//								so that a subclass can choose to override one
//								without having to rewrite the other.
//
	void TApplication::DoSuspend( Boolean doClipConvert )
	{
		doClipConvert = false;		// this is here because I HATE compiler warnings!!
		if (fCurDoc != nil)
		  fCurDoc->DoActivate( !fInBackground );
		  
	}  /* TApplication::DoSuspend */


//-----------------------------------------------------------------------
// TApplication::DoResume - 	although our suspend and resume routine are
//								identical, let's use two distinct routines
//								so that a subclass can choose to override one
//								without having to rewrite the other.
//
	void TApplication::DoResume( Boolean doClipConvert )
	{
		doClipConvert = false;		// this is here because I HATE compiler warnings!!
		if ( fCurDoc != nil )
		  fCurDoc->DoActivate( !fInBackground );
		  
	}  /* TApplication::DoResume */


//-----------------------------------------------------------------------
// TApplication::DoOSEvent - 	handle multifinder events accordingly.
//
	void TApplication::DoOSEvent(void)
	{
		Boolean doConvert;
		unsigned char evType;
	
		// is it a multifinder event?
			evType = (unsigned char) (fTheEvent.message >> 24) & 0x00ff;
			switch ( evType )					// high byte of message is type of event
			{ 									
				case kMouseMovedMessage :		DoIdle();					// mouse-moved is also an idle event
												break;
					
				case kSuspendResumeMessage :	doConvert = ( fTheEvent.message & kClipConvertMask ) != 0;
												fInBackground = ( fTheEvent.message & kResumeMask ) == 0;
												
												// depending on whether or not we're in the background call suspend or resume
													if ( fInBackground )
														DoSuspend( doConvert );
													else
														DoResume( doConvert );
												
												break;
			}
		
	}  /* TApplication::DoOSEvent */


//-----------------------------------------------------------------------
// TApplication::DoMouseDown - 	simple routine to handle a mouse click.
//
	void TApplication::DoMouseDown( void )
	{
		long		mResult;
		short		partCode;
		WindowPtr	tWind;
		EventRecord	tEvt;
	
		// gotta watch those object field dereferences
			partCode = FindWindow( fTheEvent.where, &tWind );
			fWhichWindow = tWind;
			tEvt = fTheEvent;
			switch ( partCode )
			{
				case inSysWindow :	DoMouseInSysWindow();
									break;
									
				case inMenuBar :	AdjustMenus();
									mResult = MenuSelect( tEvt.where );
									if ( mResult != 0 )
									  DoMenuCommand(HiWrd( mResult ), LoWrd( mResult ));
									break;
									
				case inGoAway :		DoGoAway();					
									break;
									
				case inDrag :		DoDrag();
									break;
									
				case inGrow :		if ( fCurDoc != nil )
					  					fCurDoc->DoGrow( &tEvt );					
									break;
				case inZoomIn :
				case inZoomOut :	if (( TrackBox(fWhichWindow, tEvt.where, partCode )) && ( fCurDoc != nil ))
										fCurDoc->DoZoom(partCode);
									break;
									
				case inContent :	// If window is not in front, make it so
										if ( fWhichWindow != FrontWindow() )
											SelectWindow(fWhichWindow);
										else
											if (fCurDoc != nil)
					 							fCurDoc->DoContent(&tEvt);					
									break;
			}
		  
	}  /* TApplication::DoMouseDown */


//-----------------------------------------------------------------------
// TApplication::DoDrag - 	have the system track the mouse movements and
//							drag the window accordingly.
//
	void TApplication::DoDrag( void )
	{
		DragWindow( fWhichWindow, fTheEvent.where, &qd.screenBits.bounds );
		
	}  /* TApplication::DoDrag */


//-----------------------------------------------------------------------
// TApplication::DoGoAway - 	a mousedown event occurred in the go away region
//								of the active window; continue tracking it. If
//								the mouse is released in the region, then close
//								the window.
//
	void TApplication::DoGoAway( void )
	{
		if ( TrackGoAway( fWhichWindow, fTheEvent.where ))			// was the mouse released in the goAway region?
		{															// yes, but is the window ours?
			if ( fCurDoc != nil )
			{														// it is our window, let's close it
				fDocList->RemoveDoc( fCurDoc );
				fCurDoc->DoClose();
			}
			else													// no, the window must belong to the system, let them handle it
				CloseDeskAcc(((WindowPeek) fWhichWindow )->windowKind );
				
			// make sure our current document/window references are valid
				if ( fWhichWindow != nil )							// does an active window remain? 
				{
					fCurDoc = fDocList->FindDoc( fWhichWindow );	// yes, update the current document pointer
					SetPort( fWhichWindow );						// be sure to make future drawings to the new window
				}
				else
					fCurDoc = nil;									// no active window remains
		}
	}  /* TApplication::DoGoAway */


//-----------------------------------------------------------------------
// TApplication::TrapAvailable - 	Check and see if the trap exists. 
//
	Boolean TApplication::TrapAvailable(short tNumber,TrapType tType)
	{
		// On 64K ROM machines, tType will be ignored.
			return NGetTrapAddress( tNumber, tType ) != GetTrapAddress( _Unimplemented );
		
	}  /* TApplication::TrapAvailable */


//-----------------------------------------------------------------------
// TApplication::AlertUser - 	Simple routine to display an alert dialog
//								using str# resources. Although this routine
//								exists and is used in this sample, a more
//								streamlined approach would be to create a
//								dialog library (or even an object) which
//								could be linked in. Using such a method,only
//								one source copy would exist.
//
	void TApplication::AlertUser( short errResID, short errCode )
	{
		Str255 message;
	
		SetCursor( &qd.arrow );
		GetIndString( message, errResID, errCode );
		ParamText( message, "\p", "\p", "\p" );
		(void) Alert( rUserAlert, (ModalFilterProcPtr) nil);
		
	}  /* TApplication::AlertUser */

//-----------------------------------------------------------------------
// TApplication::BigBadError - 	A variation of AlertUser which aborts to
//								the finder. 
//
	void TApplication::BigBadError(short errResID, short errCode)
	{
		AlertUser( errResID,errCode );
		ExitToShell();
		
	}  /* TApplication::BigBadError */
	
// That's all, folks...

/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple Application Framework
#
#	TApplication
#
#	TApplication.h	-	C++ source
#
#	Copyright © 1991 Apple Computer, Inc.
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
#	CPlusAppLib is a rudimentary application framework
#	for C++.
#
------------------------------------------------------------------------------*/

#ifndef TAPPLICATION_H
#define TAPPLICATION_H

// Include necessary interface files
#include <Types.h>
#include <Desk.h>
#include <Events.h>
#include <OSUtils.h>

// we need resource ids
#include "TApplicationCommon.h"			// use the local version. If you make changes
										// that you've debugged and want other files
										// to use, simple copy the header files into
										// the C++ Includes folder (don't forget to
										// copy the TApplication object library to the C++
										// Libraries folder)!

// we need definitions of DocumentList class
#include "TDocument.h"


/*
	TApplication:

	This is our class which implements a basic Macintosh style program,
	including a MultiFinder-aware event loop. 
*/

// we derive from handle object to prevent fragmentation
class TApplication 
#ifdef applec
	: public HandleObject
#endif
{
	public:
		//	these member functions can be called by anyone
					TApplication			( void );										// Our constructor & destructor
			void	EventLoop				( void );										// Call this routine to start event loop running
			inline	TDocumentList* DocList	( void )		{ return fDocList; }			// a utility routine that you may need to use
			Boolean TrapAvailable			( short tNumber, TrapType tType );				// Is trap implemented???
	
	protected:
		// useful variables
			Boolean			fHaveWaitNextEvent;		// true if we have WaitNextEvent trap
			Boolean			fDone;					// set to true when we are ready to quit
			EventRecord		fTheEvent;				// our event record
			WindowPtr		fWhichWindow;			// currently active window
			Boolean			fInBackground;			// true if our app is suspended
			Boolean			fWantFrontClicks;		// true if we want front clicks
			RgnHandle		fMouseRgn;				// mouse moved region (set it in your DoIdle)
			TDocument*		fCurDoc;				// currently active document (if any)
			TDocumentList*	fDocList;				// the list of documents

		// Returns total stack space required in bytes.
		// Returns 0 by default, which tells the initialization code
		// to use the default stack size.
			virtual long StackNeeded		( void ) 	{ return 0; }
	
		// Returns total heap space required in bytes.
		// Returns 0 by default, which tells the initialization code
		// to use whatever heap size is given.
			virtual long HeapNeeded			( void )	{ return 0; }
	
		// Loop control methods you may need to override
			virtual void AdjustMenus		( void )	{}				// menu updater routine
			virtual void CleanUp			( void )	{}				// run at end of loop
			virtual void DoIdle				( void )	{}				// idle time handler (blink caret, background tasks)
			virtual void ExitLoop			( void );					// to end loop, call this routine
			virtual void SetUp				( void )	{}				// Run before event loop starts
	
		// event handlers you shouldn't need to override in a typical application
			virtual void DoMouseInSysWindow	( void ) 	{ SystemClick(&fTheEvent, fWhichWindow); }
			virtual void DoOSEvent			( void );					// Calls DoSuspend, DoResume and DoIdle as apropos
			virtual void DoMouseDown		( void );					// Calls DoContent, DoGrow, DoZoom, etc
			virtual void DoKeyDown			( void );					// also called for autokey events
			virtual void DoActivateEvt		( void );					// handles setup, and calls DoActivate ( below)
			virtual void DoGoAway			( void );					// handles setup, calls TDocument::DoClose
			virtual void DoUpdateEvt		( void );					// handles setup, and calls DoUpdate ( below )
			virtual void DoDrag				( void );
	
		// handlers you will need to override for functionality:
			// called by EventLoop and its handlers:
				virtual void AdjustCursor	( void )	{}				// cursor adjust routine, should setup mouseRgn
				virtual void DoMenuCommand	( short menuID, short menuItem )	{ (void) menuID; (void) menuItem; /* avoid "not used" warning */}
	
			// called by OSEvent (just calls DoActivate by default, so no clip conversion
			// is done). If you want to convert clipboard, override these routines
				virtual void DoSuspend(Boolean doClipConvert);
				virtual void DoResume(Boolean doClipConvert);
		
		// If you have an app that needs to know about these, override them
			virtual void DoMouseUp( void ) {}
			virtual void DoDiskEvt( void ) {}
	
		// Utility routines you need to provide to do MultiFinder stuff
			virtual unsigned long SleepVal( void ) { return 0; }		// how long to sleep in WaitNextEvent

		// some other handy utility routines
			// display alert, using specified error STR# resource and error code as index
				void AlertUser( short errResID, short errCode );
			
			// call AlertUser to display error message, then quit...
				void BigBadError( short errResID, short errCode );

}; /* class TApplication */

#endif

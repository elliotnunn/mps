/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple TextEdit Sample Application
#
#	CPlusTESample
#
#	TEDocument.h	-	C++ source
#
#	Copyright © 1989 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	
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
#			TApplication.cp			July 9, 1989
#			TDocument.cp			July 9, 1989
#			TESample.cp				July 9, 1989
#			TEDocument.cp			July 9, 1989
#			TESampleGlue.a			July 9, 1989
#			TApplication.r			July 9, 1989
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

#ifndef TEDocument_Defs
#define TEDocument_Defs

#include <Types.h>
#include <TextEdit.h>
#include <Controls.h>
#include <Events.h>
#include <Terminals.h>

#include <TDocument.h>

class TEDocument : public TDocument
{
	TEHandle				fDocTE;			// our text
	ControlHandle			fDocVScroll;	// vertical scrollbar
	ControlHandle			fDocHScroll;	// horizontal scrollbar
	TerminalClikLoopProcPtr	fDocClik;		// our clik loop

	// methods not intended for use outside of this class
		void GetTERect			( Rect *teRect );
		void AdjustTE			( void );
		void DrawWindow			( void );
		void AdjustViewRect		( void );
		void ResizeWindow		( void );
		void AdjustHV			( Boolean isVert, Boolean mustRedraw );
		void AdjustScrollSizes	( void );
		void AdjustScrollbars	( Boolean needsResize );

public:
	TEDocument(short resID);
	~TEDocument(void);

	// methods from TDocument we override
		void DoZoom				( short partCode );
		void DoGrow				( EventRecord* theEvent );
		void DoContent			( EventRecord* theEvent );
		void DoKeyDown			( EventRecord* theEvent );
		void DoActivate			( Boolean becomingActive );
		void DoIdle				( void );
		void DoUpdate			( void );
		void DoCut				( void );
		void DoCopy				( void );
		void DoPaste			( void );
		void DoClear			( void );
		unsigned long CalcIdle	( void );
		Boolean HaveSelection	( void );

	// new public methods
		void					AdjustScrollValues	( Boolean mustRedraw );
		TerminalClikLoopProcPtr	GetClikLoop			( void );
		TEHandle				GetTEHandle			( void );
		void					GetVisTERgn			( RgnHandle rgn );

	
};  /* class TEDocument */

	// methods for housekeeping
			void	AlertUser					( short errResID, short errCode );				// display alert, using specified error STR# resource and error code as index
	inline	void	SetWindowDoc				( WindowPtr theWindow, TEDocument *theDoc )	{ SetWRefCon( theWindow, long( theDoc )); }
	inline			TEDocument* GetWindowDoc	( WindowPtr theWindow )						{ return (TEDocument*) ( GetWRefCon( theWindow )); }

#endif TEDocument_Defs

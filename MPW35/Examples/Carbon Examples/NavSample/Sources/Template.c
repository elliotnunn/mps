/*
	File:		Template.c

	Contains:	Main application code for NavSample

	Version:	1.4

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

	Copyright © 1996-2001 Apple Computer, Inc., All Rights Reserved
*/

#ifndef Common_Defs
#include "Common.h"
#endif

#include "modern.h"

#ifndef __myFILE__
#include "file.h"	// for myFilterProc proto
#endif

#include "document.h"
#ifdef __APPLE_CC__
#include <Carbon/Carbon.h>
#else
#include <Resources.h>
#endif

#if !TARGET_API_MAC_CARBON && defined(__MRC__)
QDGlobals	qd;
#endif

// global variables:
short				gAppResRef;
short				gQuit, gQuitting;
short				gDocumentCount;
Document*			gDocumentList[kMaxDocumentCount];
short				gFontItem, gSizeItem;
short				gInBackground;
Document*			gFrontDocument;
short				gCanUndoDrag;
WindowPtr			gUndoFrontmost, gLastFrontmost;
Boolean				gCanDrag;
Boolean				gCanPrint;

// Nav Services stuff:
Boolean				gNavServicesExists;
NavDialogRef		gAppNavDialog;
NavTypeListHandle	gOpenList;

// AppleEvent handlers:
AEEventHandlerUPP	myODOCEventHandler;
AEEventHandlerUPP	myQAPPEventHandler;
AEEventHandlerUPP	myOAPPEventHandler;
ControlActionUPP 	myActionProcUPP;

// Nav Services callbacks:
NavEventUPP 		gEventProc;
NavObjectFilterUPP	gModernFilterProc;
NavObjectFilterUPP	gFilterProc;

NavObjectFilterUPP 	gModernCustomShowFilterProc;
NavEventUPP 		gModernCustomShowEventProc;


// prototypes:
void InitializeToolbox( void );
void InitializeGlobals( void );
void SetupMenus( void );
void CleanUp( void );
void InstallEventHandlers( void );


// *****************************************************************************
// *
// *	InitializeToolbox( )
// *
// *****************************************************************************
void InitializeToolbox( )
{			
#if !TARGET_API_MAC_CARBON
	InitGraf( &qd.thePort );

	InitFonts( );
	InitWindows( );
	InitMenus( );
	TEInit( );
	InitDialogs( 0L );

	// give us more memory
	MoreMasters( );
	MoreMasters( );	
	MaxApplZone( );
#endif
	
	InitCursor( );
	
	FlushEvents( everyEvent, 0 );

	gAppResRef = CurResFile( );
}


// *****************************************************************************
// *
// *	InitializeGlobals( )
// *
// *****************************************************************************
void InitializeGlobals( )
{	
	long result = 0;

	gQuit 			= gQuitting = false;
	gDocumentCount 	= 0;
	gFontItem 		= gSizeItem = 0;
	gInBackground 	= false;
	gCanUndoDrag 	= slCantUndo;

	if ((Gestalt( gestaltDragMgrAttr, &result ) != noErr) || (!(result & (1 << gestaltDragMgrPresent))))
		gCanDrag = false;
	else
		gCanDrag = true;

	gCanPrint = false;

	// Check for Navigation Services 
	gNavServicesExists = NavServicesAvailable( );
	if ( gNavServicesExists )
		NavLoad( );

#if TARGET_API_MAC_CARBON		
	gEventProc = NewNavEventUPP( modernEventProc );
	gModernFilterProc = NewNavObjectFilterUPP( modernFilterProc );
	
	gModernCustomShowFilterProc = NewNavObjectFilterUPP( customShowFilterProc );
	gModernCustomShowEventProc = NewNavEventUPP( customShowEventProc );
#endif
	gFilterProc = NewNavObjectFilterUPP( myFilterProc );
	
	gOpenList = (NavTypeListHandle)GetResource( kOpenRsrcType, kOpenRsrcID );
}


// *****************************************************************************
// *
// *	CleanUp( )
// *
// *****************************************************************************
void CleanUp( )
{
    if ( myODOCEventHandler != NULL )
        DisposeAEEventHandlerUPP( myODOCEventHandler );
    if ( myQAPPEventHandler != NULL )
        DisposeAEEventHandlerUPP( myQAPPEventHandler );
    if ( myOAPPEventHandler != NULL )
        DisposeAEEventHandlerUPP( myOAPPEventHandler );
    if ( myActionProcUPP != NULL )
        DisposeControlActionUPP( myActionProcUPP );
    
    if ( gEventProc != NULL )
       	DisposeNavEventUPP( gEventProc );
  	if ( gModernFilterProc != NULL )
       	DisposeNavObjectFilterUPP( gModernFilterProc );
       	
    if ( gModernCustomShowFilterProc != NULL )
       	DisposeNavObjectFilterUPP( gModernCustomShowFilterProc );
    if ( gModernCustomShowEventProc != NULL )
    	DisposeNavEventUPP( gModernCustomShowEventProc );
    	       
	if ( gFilterProc != NULL )
        DisposeNavObjectFilterUPP( gFilterProc );
        
#if TARGET_API_MAC_CARBON
	ModernCleanUp( );	// clean up any memory allocated via the modern Nav Services API
#endif
    
    if ( gNavServicesExists )
    	NavUnload( );
    	
    if ( gOpenList != NULL )
    	ReleaseResource( (Handle)gOpenList );
}


// *****************************************************************************
// *
// *	SetupMenus( )
// *
// *****************************************************************************
void SetupMenus( )
{	
	MenuBarHandle theMenuBar = NULL;
	theMenuBar = GetNewMBar( MenuBarID );
	if ( theMenuBar != NULL )
	{
		Str255	theStr;
		long 	result = 0;
		
		SetMenuBar( theMenuBar );
		DisposeHandle( theMenuBar );
		
		GetIndString( theStr, MenuStringsID, slCantUndo );
		SetMenuItemText( GetMenuHandle( idEditMenu ), iUndo, theStr );
		
		// check for Aqua menu layouts to see if we are to remove out 'Quit' menu item:
		Gestalt( gestaltMenuMgrAttr, &result );
		if ( result & gestaltMenuMgrAquaLayoutMask )
		{
			MenuRef menu = GetMenuHandle( idFileMenu );
			DeleteMenuItem( menu, QuitItem );
			DeleteMenuItem( menu, QuitSeperator );
		}
	}
	
#if !TARGET_API_MAC_CARBON
	AppendResMenu( GetMenuHandle( idAppleMenu ), 'DRVR' );	// this is done automatically for us in Carbon
#endif

	InvalMenuBar( );
}


// *****************************************************************************
// *
// *	InstallEventHandlers( )
// *
// *****************************************************************************
void InstallEventHandlers( )
{
	long 	result = 0;
	OSErr 	theErr = noErr;
	
	if ( (theErr = Gestalt( gestaltAppleEventsAttr, &result )) == noErr )
	{
		myODOCEventHandler = NewAEEventHandlerUPP( MyHandleODOC );
		myQAPPEventHandler = NewAEEventHandlerUPP( MyHandleQUIT );
		myOAPPEventHandler = NewAEEventHandlerUPP( MyHandleOAPP );

		(void)AEInstallEventHandler( kCoreEventClass, kAEOpenApplication, myOAPPEventHandler, 0, false );	
		(void)AEInstallEventHandler( kCoreEventClass, kAEQuitApplication, myQAPPEventHandler, 0, false );
		(void)AEInstallEventHandler( kCoreEventClass, kAEOpenDocuments, myODOCEventHandler, 0, false );
	}
}


// *****************************************************************************
int main( int argc, char* argv[] )
{	
#pragma unused( argc, argv )
    
	InitializeToolbox( );
	InitializeGlobals( );
	InstallEventHandlers( );
	
	SetupMenus( );
	AdjustMenus( );
					
	myActionProcUPP = NewControlActionUPP( ScrollProc );
     
	DoNewDocument( false );
        
	EventLoop( );

	CleanUp( );
		
	return 0;
}
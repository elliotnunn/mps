/*
    File:	 PlugInHost.c
	
    Description: Basic CFPlugIn sample code shell, Carbon API

    Copyright: 	 © Copyright 2001 Apple Computer, Inc. All rights reserved.

    Disclaimer:	 IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
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

#ifdef __APPLE_CC__
#include <Carbon/Carbon.h>
#else
#include <Carbon.h>
#endif

#include <stdio.h>

//  PlugInInterface.h defines our plug-in's interface.

#include "PlugInInterface.h"

//  Constants

#define kPlugInName		"PlugIn.bundle"

//  Globals

static DrawBallInterfaceStruct **gDrawBallInterface = NULL;

//  Function prototypes

static CFPlugInRef MyLoadPlugIn( void );
static void Initialize( void );
static pascal OSStatus MyCloseHandler( EventHandlerCallRef inHandlerRef, EventRef inEvent,
                                       void *inUserData );
static pascal void MyTimerHandler( EventLoopTimerRef inTimer, void *inUserData );

/************************************************************************************************
*
*  MyLoadPlugIn
*
*  Load the plug-in specified by kPlugInName that is contained in our "PlugIns" directory.
*  If the plug-in is successfully loaded, return a reference to it. 
*
*       Out     CFPlugInRef             A reference to the plug-in or NULL if the load failed.
*
************************************************************************************************/

static CFPlugInRef MyLoadPlugIn( void )
{
    CFPlugInRef		newPlugIn;
    CFURLRef		bundleURL, plugInURL;

    //  Obtain a URL to the PlugIns directory inside our application.

    bundleURL = CFBundleCopyBuiltInPlugInsURL( CFBundleGetMainBundle() );
    
    //  We just want to load our test plug-in, so append its name to the URL.

    plugInURL = CFURLCreateCopyAppendingPathComponent( NULL, bundleURL, CFSTR( kPlugInName ),
                                                       FALSE );

    //  Create a CFPlugin using the URL. This step causes the plug-in's types and factories to
    //  be registered with the system. Note that the plug-in's code is not actually loaded at
    //  this stage unless the plug-in is using dynamic registration.

    newPlugIn = CFPlugInCreate( NULL, plugInURL );

    CFRelease( bundleURL );
    CFRelease( plugInURL );

    //  The plug-in was located. Now locate the interface.

    if( newPlugIn ) {

        //  See if this plug-in implements the Test type.

        CFArrayRef factories = CFPlugInFindFactoriesForPlugInType( kTestTypeID );

        //  If there are factories for the Test type, attempt to get the IUnknown interface.

        if ( factories != NULL && CFArrayGetCount( factories ) > 0 ) {

            //  Get the factory ID for the first location in the array of IDs.
			
            CFUUIDRef factoryID = (CFUUIDRef)CFArrayGetValueAtIndex( factories, 0 );

            //  Use the factory ID to get an IUnknown interface. Here the plug-in code is loaded.
            
            IUnknownVTbl **iunknown = (IUnknownVTbl **)CFPlugInInstanceCreate( NULL, factoryID,
                                                                               kTestTypeID );
            
            //  If this is an IUnknown interface, query for the test interface.

            if( iunknown ) {
                (*iunknown)->QueryInterface( iunknown, CFUUIDGetUUIDBytes( kTestInterfaceID ),
                                             (LPVOID *)( &gDrawBallInterface ) );

                // Now we are done with IUnknown

                (*iunknown)->Release( iunknown );

                if ( gDrawBallInterface == NULL ) {
                    CFRelease( newPlugIn );
                    newPlugIn = NULL;
                }
            }
            else {
                CFRelease( newPlugIn );
                newPlugIn = NULL;
            }
        }
        else {
            CFRelease( newPlugIn );
            newPlugIn = NULL;
        }
    }
    return newPlugIn;
}

/************************************************************************************************
*
*  main
*
*  The application entry point. Here we load our test plug-in, create a window, and start the
*  main application event loop. 
*
************************************************************************************************/

int main( void )
{
    CFPlugInRef         plugIn;
	
    //  Load our plugin.
	
    plugIn = MyLoadPlugIn();
    if( plugIn ) {
	
        //  Initialize the application -- create the main window, set up its event handlers
        //  and install a event loop timer to periodically draw balls.
	
        Initialize();
		
        //  Start the main event loop. RunApplicationEventLoop will not complete until
        //  QuitApplicationEventLoop is called.
		
        RunApplicationEventLoop();
		
        //  We're done with the drawBall interface now, so call its release function to let
        //  it do any cleanup.

        (*gDrawBallInterface)->Release( gDrawBallInterface );
 
        //  Finally, release the CFPlugInRef itself.
 
        CFRelease( plugIn );
    }
    return 0;
}
 
/************************************************************************************************
*
*  Initialize
*
*  Initialize basic stuff. Create a new window, install event handlers, and install an event loop
*  timer where we periodically call our plug-in. 
*
************************************************************************************************/

static void Initialize( void )
{
    EventLoopTimerRef   timerRef;
    EventTypeSpec       eventTypeSpec = { kEventClassWindow, kEventWindowClose };
    Rect                bounds;
    WindowRef           window;

    InitCursor();

    //  Create a window and install an event handler to handle the close button.

    SetRect( &bounds, 50, 50, 600, 200 );
    CreateNewWindow( kDocumentWindowClass,
                     kWindowCloseBoxAttribute + kWindowStandardHandlerAttribute,
                     &bounds,
                     &window );
    SetWTitle( window, "\pPlugIn Host -- Close Window To Quit" );
    InstallWindowEventHandler( window, NewEventHandlerUPP( MyCloseHandler ), 1, &eventTypeSpec,
                               NULL, NULL );
							   
    //	Create a timer to handle ball-drawing in the window.
	
    InstallEventLoopTimer( GetCurrentEventLoop(), kEventDurationSecond, kEventDurationSecond,
                           NewEventLoopTimerUPP( MyTimerHandler ), window, &timerRef );

    ShowWindow( window );
}

/************************************************************************************************
*
*  MyCloseHandler
*
*  This routine is called in response to close events for our main window. In this sample, we
*  call QuitApplicationEventLoop to terminate our main event loop and exit the application.
*
*       In      inHandlerRef            Unused here.
*               inEvent                 Unused here.
*               inUserData              Unused here.
*
*	Out	OSStatus		A toolbox error code.
*
************************************************************************************************/

static pascal OSStatus MyCloseHandler( EventHandlerCallRef inHandlerRef, EventRef inEvent,
                                       void *inUserData )
{
#pragma unused (inHandlerRef, inEvent, inUserData)

    QuitApplicationEventLoop();
    return noErr;
}

/************************************************************************************************
*
*  MyTimerHandler
*
*  This routine is called when our event loop timer fires. In this sample, we call the plug-in
*  function "drawBall" which is defined in the plug-in interface.
*
*       In      inTimer                 Unused here.
*               inUserData              Unused here.
*
************************************************************************************************/

static pascal void MyTimerHandler( EventLoopTimerRef inTimer, void *inUserData )
{
#pragma unused (inTimer)

    CGrafPtr            currentPort;
    Rect                currentPortRect;
    RgnHandle           flushRegion;

    SetPortWindowPort( (WindowRef) inUserData );

    //  Call the plug-in function "drawBall" which is defined in the plug-in interface.

    (*gDrawBallInterface)->drawBall( gDrawBallInterface );

    //  We are not drawing in response to an update or draw event, so if the window is buffered
    //  (i.e. on Mac OS X) we need to flush the content to be drawn in the window.

    GetPort( &currentPort );
    if( QDIsPortBuffered( currentPort ) ) {
    	GetPortBounds( currentPort, &currentPortRect );
    	flushRegion = NewRgn();
    	RectRgn( flushRegion, &currentPortRect );
        QDFlushPortBuffer( currentPort, flushRegion );
        DisposeRgn( flushRegion );
    }
}
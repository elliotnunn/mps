/*
	File:		CallIORegistry.c
	
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

	Copyright © 1999-2001 Apple Computer, Inc., All Rights Reserved
*/

#define TARGET_API_MAC_CARBON 1
#include <Carbon.h>
//#include <CFURL.h>
//#include <CFBundle.h>
#include <stdio.h>
#include <string.h>

//#include <CarbonEvents.h>
//#include <Gestalt.h>
//#include <MacTextEditor.h>

// Typedef for the function pointer.
typedef short (*GetClockFrequencyFunctionPtr)( CFDictionaryRef *rootProperties, CFDictionaryRef *deviceTypeProperties ); 

// Function pointer.
GetClockFrequencyFunctionPtr	GetClockFrequency	= NULL;

typedef struct			
{
	char	machineString[32];
	SInt32	clockFrequencyDevice;
	SInt32	busFrequency;
	SInt32	timeBaseFrequency;
	SInt32	dCacheSize;
	SInt32	iCacheSize;
	SInt32	cpuVersion;
} RegistryInfo;

typedef struct			
{
	CFURLRef		bundleURL;
	CFBundleRef		myBundle;
	RegistryInfo	registryInfo;
} GlobalsRec;

GlobalsRec	g;						//	The globals



static OSStatus InstallStandardMenuBar(void);
static pascal OSStatus MyWindowEventHandler(EventHandlerCallRef myHandler, EventRef event, void* userData);
static void	HandleWindowUpdate(WindowRef window);
static pascal OSErr QuitAppleEventHandler(const AppleEvent *appleEvt, AppleEvent* reply, long refcon);
static	SInt32	GetDictSInt32( CFDictionaryRef dict, CFStringRef key );
static	void	CallIORegistry( void );
static	StringPtr	C2P( char *s );

#define mFile 129
#define iQuit 1

void main(void)
{
    Rect		bounds = { 100, 100, 300, 500 };
    WindowRef	window;
    OSStatus	err;
    EventHandlerRef	ref;
	EventTypeSpec	list[] = { {kEventClassWindow, kEventWindowClose },
								{ kEventClassWindow, kEventWindowDrawContent } };
	
	InitCursor();
   
    err = InstallStandardMenuBar();
    
    err = AEInstallEventHandler(kCoreEventClass, kAEQuitApplication, NewAEEventHandlerUPP(QuitAppleEventHandler), 0, false);

	err = CreateNewWindow(kDocumentWindowClass,
                  kWindowStandardDocumentAttributes | kWindowStandardHandlerAttribute,
                  &bounds, &window);

    InstallWindowEventHandler(window, NewEventHandlerUPP(MyWindowEventHandler), 2, list, 0, &ref);
    
    CallIORegistry();
    
    ShowWindow(window);
    RunApplicationEventLoop();
    ExitToShell();
}

static pascal OSStatus
MyWindowEventHandler(EventHandlerCallRef myHandler, EventRef event, void* userData)
{
#pragma unused (myHandler, userData)

    WindowRef			window;
    OSStatus			result = eventNotHandledErr;

    GetEventParameter(event, kEventParamDirectObject, typeWindowRef, NULL, sizeof(window), NULL, &window);

    if (GetEventKind(event) == kEventWindowDrawContent)
    {
        HandleWindowUpdate(window);
        result = noErr;
    }
    else if (GetEventKind(event) == kEventWindowClose)
    {
        DisposeWindow(window);
        QuitApplicationEventLoop();
        result = noErr;
    }
    
    return result;
}

static void HandleWindowUpdate(WindowRef window)
{
    Rect		bounds;
    //SInt16		textWidth;
	char		text[1024];

    SetPortWindowPort( window );
	EraseRect( GetWindowPortBounds(window, &bounds) );
     
	sprintf( text, "machine %s\r---------------------\rclock-frequency	%ld = %08lx\rbus-frequency	%ld = %08lx\rtimebase-frequency	%ld = %08lx\rd-cache-size	%ld = %08lx\ri-cache-size	%ld = %08lx\rcpu-version	%ld = %08lx",
		g.registryInfo.machineString,
		g.registryInfo.clockFrequencyDevice, g.registryInfo.clockFrequencyDevice,
		g.registryInfo.busFrequency, g.registryInfo.busFrequency,
		g.registryInfo.timeBaseFrequency, g.registryInfo.timeBaseFrequency,
		g.registryInfo.dCacheSize, g.registryInfo.dCacheSize,
		g.registryInfo.iCacheSize, g.registryInfo.iCacheSize,
		g.registryInfo.cpuVersion, g.registryInfo.cpuVersion
	);
     
    TextSize( 12 );    
    SetRect( &bounds, bounds.top+20, bounds.left+20, bounds.bottom, bounds.right );
    
	TETextBox( text, strlen(text), &bounds, teJustLeft );
    
	//	Preferably we would use a CFString for the string handling, in this
	//	case in conjunction with TXNDrawUnicodeTextBox. 
	//	SetRect(&bounds, bounds.top,bounds.left,bounds.top + 50,bounds.left+textWidth);
	//	TXNDrawCFStringTextBox(CFSTR("Hello World!"), &bounds, NULL, NULL);
}

static OSStatus InstallStandardMenuBar(void)
{
	Handle		menuBar;
	MenuRef 	menu;
	long 		response;
	OSStatus	err = noErr;

	menuBar = GetNewMBar(128);
	if (menuBar)
	{
		SetMenuBar(menuBar);

		// check to see if we should modify the File menu's quit item in
		// order to follow the Aqua HI quit guideline
		err = Gestalt(gestaltMenuMgrAttr, &response);
		if ((err == noErr) && (response & gestaltMenuMgrAquaLayoutMask))
		{
			menu = GetMenuHandle(mFile);
			DeleteMenuItem(menu, iQuit);
		}

		DrawMenuBar();
	}
	return err;
}

static pascal OSErr QuitAppleEventHandler(const AppleEvent *appleEvt, AppleEvent* reply, long refcon)
{
#pragma unused (appleEvt, reply, refcon)

	QuitApplicationEventLoop();
	return(noErr);
}


static	void	CallIORegistry()
{
	short		err;
	Boolean		didLoad		= false;						//	Flag that indicates the status returned when attempting to load a bundle's executable code.
   
    memset( &g, 0, sizeof(GlobalsRec) );						//	Initialize the globals

	//	Make a CFURLRef from the CFString representation of the bundle's path.
	//	See the Core Foundation URL Services chapter for details.
	g.bundleURL	= CFURLCreateWithFileSystemPath( 
				nil, 										//	workaround for Radar # 2452789
				CFSTR("/Test.bundle"),						//	hard coded path for sample
				kCFURLPOSIXPathStyle,
				true );
	if ( g.bundleURL != NULL )

	// Make a bundle instance using the URLRef.
	g.myBundle	= CFBundleCreate(
				NULL /* kCFAllocatorDefault */, 			//	workaround for Radar # 2452789
				g.bundleURL );

	if ( g.myBundle != NULL )
	{
	    didLoad	= CFBundleLoadExecutable( g.myBundle );		//	Try to load the executable from my bundle.
	
	    if ( didLoad == true )								//	If the code was successfully loaded, look for our function.
	    {		
			// Now that the code is loaded, search for the function we want by name.
			GetClockFrequency = (void*)CFBundleGetFunctionPointerForName( g.myBundle, CFSTR("GetClockFrequency") );
	    	
	    	// If our function was found in the loaded code, call it with a test value.
	    	if ( GetClockFrequency != nil )
	    	{
				CFDataRef			data;
	    		CFDictionaryRef		rootProperties			= nil;
	    		CFDictionaryRef		deviceTypeProperties	= nil;
				
				err	= GetClockFrequency( &rootProperties, &deviceTypeProperties );	// This Calls our mach-o function
	 			
	 			if ( err == 0 )
	 			{
	     			data	= CFDictionaryGetValue( rootProperties, CFSTR("compatible") );
					if( data != nil )
	    				strcpy( g.registryInfo.machineString, (char*) CFDataGetBytePtr(data) );
				    			    
					g.registryInfo.clockFrequencyDevice	= GetDictSInt32( deviceTypeProperties, CFSTR( "clock-frequency" ) );
					g.registryInfo.busFrequency			= GetDictSInt32( deviceTypeProperties, CFSTR( "bus-frequency" ) );
					g.registryInfo.timeBaseFrequency	= GetDictSInt32( deviceTypeProperties, CFSTR( "timebase-frequency" ) );
					g.registryInfo.dCacheSize			= GetDictSInt32( deviceTypeProperties, CFSTR( "d-cache-size" ) );
					g.registryInfo.iCacheSize			= GetDictSInt32( deviceTypeProperties, CFSTR( "i-cache-size" ) );
					g.registryInfo.cpuVersion			= GetDictSInt32( deviceTypeProperties, CFSTR( "cpu-version" ) );
				    
				    CFRelease( rootProperties );
				    CFRelease( deviceTypeProperties );
	    		}
			}
	        
			CFBundleUnloadExecutable( g.myBundle );			//	Unload the bundle's executable code. 
	    }
	}
	else
	{
		(void) Alert( 128, nil );
	}

	// Any CF objects returned from functions with "create" or "copy" in their names must be released by us!
	if ( g.bundleURL != NULL ) CFRelease( g.bundleURL );
	if ( g.myBundle != NULL ) CFRelease( g.myBundle );
}


static	SInt32	GetDictSInt32( CFDictionaryRef dict, CFStringRef key )
{
	UInt32		value;
	CFDataRef	data	= CFDictionaryGetValue( dict, key );
	
	if( (data != nil) && (CFDataGetLength(data) >= sizeof(value)) )
		value	= *((UInt32 *)CFDataGetBytePtr( data ));
	else
		value	= -1;									//	our flag for "not found"
		
	return( value );
}

static	StringPtr	C2P( char *s )
{
	int	len	= strlen( s );
	BlockMoveData( s, s+1, len );
	s[0]	= len;
	return( (StringPtr) s );
}

/*
	File:		CFM_MachO_CFM.c
	
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

//	This sample demonstrates how to call a Mach-O routine, and pass in a CFM based function pointer as a callback parameter.

#define TARGET_API_MAC_CARBON 1
#include <Carbon.h>
#include <string.h>


// Typedef for the function pointer.
typedef void (*MainSysBeepFunctionPtr)( short numBeeps );			//	Callback routine
typedef short (*GetFooWithCallBackFunctionPtr)( short numBeeps, MainSysBeepFunctionPtr callBackFunctionPtr ); //	Mach-O function



// Function pointer.
GetFooWithCallBackFunctionPtr	GetFooWithCallBack	= NULL;
MainSysBeepFunctionPtr			SysBeepCallBack		= NULL;


typedef struct			
{
	CFURLRef		bundleURL;
	CFBundleRef		myBundle;
} GlobalsRec;

GlobalsRec	g;						//	The globals


void	MainSysBeep( short numBeeps );

static	OSStatus	InstallStandardMenuBar(void);
static	pascal	OSStatus MyWindowEventHandler(EventHandlerCallRef myHandler, EventRef event, void* userData);
static	void	HandleWindowUpdate(WindowRef window);
static	pascal	OSErr QuitAppleEventHandler(const AppleEvent *appleEvt, AppleEvent* reply, long refcon);
static	void	DoTheStuff( void );
void	*MachOFunctionPointerForCFMFunctionPointer( void *cfmfp );

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
    
    DoTheStuff();
    
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


//
//	This function allocates a block of CFM glue code which contains the instructions to call CFM routines
//
UInt32 template[6] = {0x3D800000, 0x618C0000, 0x800C0000, 0x804C0004, 0x7C0903A6, 0x4E800420};

void	*MachOFunctionPointerForCFMFunctionPointer( void *cfmfp )
{
    UInt32	*mfp = (UInt32*) NewPtr( sizeof(template) );		//	Must later dispose of allocated memory
    mfp[0] = template[0] | ((UInt32)cfmfp >> 16);
    mfp[1] = template[1] | ((UInt32)cfmfp & 0xFFFF);
    mfp[2] = template[2];
    mfp[3] = template[3];
    mfp[4] = template[4];
    mfp[5] = template[5];
    MakeDataExecutable( mfp, sizeof(template) );
    return( mfp );
}

static	void	DoTheStuff()
{
	short		err;
	Boolean		didLoad		= false;						//	Flag that indicates the status returned when attempting to load a bundle's executable code.
   
    memset( &g, 0, sizeof(GlobalsRec) );						//	Initialize the globals

	//	Make a CFURLRef from the CFString representation of the bundle's path.
	//	See the Core Foundation URL Services chapter for details.
	g.bundleURL	= CFURLCreateWithFileSystemPath( 
				nil, 										//	workaround for Radar # 2452789
				CFSTR("/Test.bundle"),						//	hard coded path for sample
				0,
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
			GetFooWithCallBack = (void*)CFBundleGetFunctionPointerForName( g.myBundle, CFSTR("GetFooWithCallBack") );
	    	
	    	// If our function was found in the loaded code, call it with a test value.
	    	if ( GetFooWithCallBack != nil )
	    	{
				SysBeepCallBack	= MachOFunctionPointerForCFMFunctionPointer( MainSysBeep );
				
				err	= GetFooWithCallBack( 3, SysBeepCallBack );	// This Calls our mach-o function
				
				DisposePtr( (Ptr) SysBeepCallBack );
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

void	MainSysBeep( short numBeeps )
{
	short	i;
	
	for ( i=0 ; i<numBeeps ; i++ )
		SysBeep( 5 );
}



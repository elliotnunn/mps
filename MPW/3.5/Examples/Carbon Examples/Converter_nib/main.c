/*

File:		main.c



Description: 	This little application shows the use of nib files (containing UI elements) in a Carbon application. 

				Nib files can be used in applications linking against CarbonLib 1.2 and higher.  

				Since you cannot add a .nib file to a CodeWarrior project (yet, as of Pro6), the approach used in

				this sample application is to build the package manually, place the nib file in the

				Contents:Resources: package folder, and then have CodeWarrior's output directory set to Contents:MacOS:

				inside the package. Nib files can be created and edited using Interface Builder in MacOS X.



Authors:		JM & MCF



Copyright: 	© Copyright 2000-2001 Apple Computer, Inc. All rights reserved.



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

                

Change History (most recent first):



01/2001 - MCF - tweak to remove dependence on string.h

12/2000 - MCF - tweak to avoid Public Beta workaround, since the finalized release of Mac OS X should fix that bug

10/2000 - JM & MCF - initial version





*/

#include <Carbon.h>





#define kConvertCommand 'conv'

#define kConvertSignature 'conv'

#define kFahrenheitFieldID 128

#define kCelsiusFieldID 129

pascal OSStatus MainWindowCommandHandler( EventHandlerCallRef handlerRef, EventRef event, void *userData );

pascal void ConvertCommandHandler(WindowRef window);



static pascal OSErr QuitAppleEventHandler(const AppleEvent *appleEvt, AppleEvent* reply, long refcon)

{

#pragma unused (appleEvt, reply, refcon)

	QuitApplicationEventLoop();

	return noErr;

}



int main(void)

{

    IBNibRef 		nibRef;

    WindowRef 		window;

    CFBundleRef		bundleRef;

    long			systemVersion;

    long			carbonVersion;

    long			menuManagerAttr;

    

    OSStatus		err;

    EventTypeSpec	commSpec = { kEventClassCommand, kEventProcessCommand };





	InitCursor();

	bundleRef=CFBundleGetMainBundle();

	

	if (Gestalt(gestaltSystemVersion, &systemVersion)!=noErr) systemVersion=0;

	if (Gestalt(gestaltCarbonVersion, &carbonVersion)!=noErr) carbonVersion=0;

	if (Gestalt(gestaltMenuMgrAttr, &menuManagerAttr)!=noErr) menuManagerAttr=0;

	//We have to workaround a CFBundle bug in Mac OS X Public Beta by editing the bundle path to point

	//to the actual bundle, not the executable, since CFBundleGetMainBundle() does the wrong thing

	//if the executable is in the MacOSClassic folder in the application package.  Uncomment the following

	//code if you want this sample to run on Public Beta.

	/*if ((systemVersion == 0x00001000) && (carbonVersion == 0x00000110))

	{

		CFURLRef		bundleURL,finalBundleURL;

    	CFStringRef		urlString;

		CFRange			rangeResult;



		bundleURL=CFBundleCopyBundleURL(bundleRef);

		urlString=CFURLGetString(bundleURL);

		CFStringFindWithOptions(urlString, CFSTR("/"), CFRangeMake(0,CFStringGetLength(urlString)-1), kCFCompareBackwards, &rangeResult);

		CFStringFindWithOptions(urlString, CFSTR("/"), CFRangeMake(0,rangeResult.location-1), kCFCompareBackwards, &rangeResult);

		finalBundleURL=CFURLCreateWithString(kCFAllocatorDefault,CFStringCreateWithSubstring(kCFAllocatorDefault,urlString,CFRangeMake(0,rangeResult.location+1)),NULL);

		// Make a bundle instance using the new URLRef, finalBundleURL.

		bundleRef = CFBundleCreate(kCFAllocatorDefault,finalBundleURL);

		CFRelease(bundleURL);

		CFRelease(finalBundleURL);

	}*/



	//We'll load a different version of the nib depending upon whether we're on 

	//CarbonLib (pre-OSX) or the Carbon environment in OSX because of the menu layout differences

	if (menuManagerAttr & gestaltMenuMgrAquaLayoutMask)

	{		

	    // Create a Nib reference passing the name of the bundle and the nib file (without the .nib extension)

	     err = CreateNibReferenceWithCFBundle(bundleRef,CFSTR("mainX"), &nibRef);

	    require_noerr( err, CantGetNibRef );

    }

    else

    {

	    // Create a Nib reference passing the name of the bundle and the nib file (without the .nib extension)

	     err = CreateNibReferenceWithCFBundle(bundleRef,CFSTR("main9"), &nibRef);

	    require_noerr( err, CantGetNibRef );

    }

    

    //We can release our reference to the bundle now

    CFRelease(bundleRef);

    

    // Once the nib reference is created, set the menu bar. "MainMenu" is the name of the menu bar

    // object. This name is set in InterfaceBuilder when the nib is created.

    err = SetMenuBarFromNib(nibRef, CFSTR("MainMenu"));

    require_noerr( err, CantSetMenuBar );

    

    // Then create a window. "MainWindow" is the name of the window object. This name is set in 

    // InterfaceBuilder when the nib is created.

    err = CreateWindowFromNib(nibRef, CFSTR("MainWindow"), &window);

    require_noerr( err, CantCreateWindow );



    // We don't need the nib reference anymore.

    DisposeNibReference(nibRef);

    

    // The window was created hidden so show it.

    ShowWindow( window );

    

    InstallWindowEventHandler( window,

        NewEventHandlerUPP(MainWindowCommandHandler),

        1, &commSpec, (void *) window, NULL );

     

    err = AEInstallEventHandler( kCoreEventClass, kAEQuitApplication, NewAEEventHandlerUPP(QuitAppleEventHandler), 0, false );   

    

    // Call the event loop

    RunApplicationEventLoop();



CantCreateWindow:

CantSetMenuBar:

CantGetNibRef:

	return err;

}



pascal OSStatus MainWindowCommandHandler( EventHandlerCallRef handlerRef,

	EventRef event, void *userData )

{

#pragma unused (handlerRef)

    OSStatus 	err = eventNotHandledErr;

    HICommand 	command; 



    GetEventParameter( event, kEventParamDirectObject, typeHICommand,

                       NULL, sizeof(HICommand), NULL,  &command );



    switch( command.commandID ) {

        case kConvertCommand:

            ConvertCommandHandler( (WindowRef) userData );

            err = noErr;

            break;

    }

    return err;

}



pascal void ConvertCommandHandler(WindowRef window)

{

	char			ctrlStr[256];

    ControlHandle	fahrenheitField, celsiusField;

    ControlID		fahrenheitControlID = 

                            { kConvertSignature, kFahrenheitFieldID };

    ControlID	celsiusControlID = 

                            { kConvertSignature, kCelsiusFieldID };

    Size		actualSize;

    double		fahrenheitTemp, celsiusTemp;

    decform 	df={FIXEDDECIMAL,0,0};

    decimal		d;

    short		ix,vp;

    Str255		ctrlStrPascal;



    GetControlByID( window, &fahrenheitControlID, &fahrenheitField );

    GetControlByID( window, &celsiusControlID, &celsiusField );

    

    //we could use CFStrings to hold the control data and help with the conversion, but 

    //they don't work properly with Get/SetControlData in CarbonLib 1.2 (i.e. pre-OSX)

    GetControlData( fahrenheitField, 0, kControlEditTextTextTag, 

                    sizeof(ctrlStr), &ctrlStr, &actualSize );

    

    //we convert the string to a decimal number to do the calculation                

    ctrlStr[actualSize]='\0';

    ix=0; vp=0;

    str2dec(ctrlStr,&ix,&d,&vp);

    fahrenheitTemp=dec2f(&d);

        

    celsiusTemp = ( fahrenheitTemp - 32.0 ) * 5.0 / 9.0;

    

    //we now convert the decimal result back to a C String before stuffing it in the static text field

    num2dec(&df,celsiusTemp,&d);

    dec2str(&df, &d,ctrlStr);

    CopyCStringToPascal(ctrlStr,ctrlStrPascal); 

    SetControlData( celsiusField, 0, kControlEditTextTextTag, 

                    ctrlStrPascal[0], ctrlStr);                                                

    DrawOneControl( celsiusField );

}


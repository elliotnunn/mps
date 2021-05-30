/*
	File:		SomePre8.5MenuAPI.c
	
	Contains:	Because they've been removed from CarbonAccessors.o,
				here are implementations for the following pre-8.5 APIs: 
				InvalWindowRect,
				ValidWindowRect,
				InvalWindowRgn,
				ValidWindowRgn,
				EnableMenuItem, 
				DisableMenuItem, 
				IsMenuItemEnabled.
				
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

	Copyright © 1998-2001 Apple Computer, Inc., All Rights Reserved
*/

//——————————————————————————————————————————————————————————————————————————————————————————————————
// InvalWindowRect
pascal OSStatus InvalWindowRect(WindowPtr window, const Rect *bounds)
{
	GrafPtr	oldPort;
	
	GetPort(&oldPort);
	SetPort(window);
	InvalRect(bounds);
	SetPort(oldPort);

	return noErr;
}

//——————————————————————————————————————————————————————————————————————————————————————————————————
// ValidWindowRect
pascal OSStatus ValidWindowRect(WindowPtr window, const Rect *bounds)
{
	GrafPtr	oldPort;
	
	GetPort(&oldPort);
	SetPort(window);
	ValidRect(bounds);
	SetPort(oldPort);

	return noErr;
}

//——————————————————————————————————————————————————————————————————————————————————————————————————
// InvalWindowRgn
pascal OSStatus InvalWindowRgn(WindowPtr window, RgnHandle region)
{
	GrafPtr	oldPort;
	
	GetPort(&oldPort);
	SetPort(window);
	InvalRgn(region);
	SetPort(oldPort);

	return noErr;
}

//——————————————————————————————————————————————————————————————————————————————————————————————————
//	ValidWindowRgn
pascal OSStatus ValidWindowRgn(WindowPtr window, RgnHandle region)
{
	GrafPtr	oldPort;
	
	GetPort(&oldPort);
	SetPort(window);
	ValidRgn(region);
	SetPort(oldPort);

	return noErr;
}

typedef UInt16                          MenuItemIndex;

//——————————————————————————————————————————————————————————————————————————————————————————————————
// EnableMenuItem
// Note that before 8.5, we're limited to enabling the first 31 items.

typedef pascal void (*DoMenuItemProcPtr)(MenuHandle menu, MenuItemIndex item);

pascal void EnableMenuItem(MenuHandle menu, MenuItemIndex item)
{
	static DoMenuItemProcPtr      	tEnableMenuItemProcPtr = nil;
    CFragConnectionID   			connectionID;
    Ptr                 			mainAddress;
    Str255              			errorString;
    OSErr               			anErr;

	if (nil == tEnableMenuItemProcPtr)	// if it's not defined yet…
	{
		// Resolve the symbol against the 8.5 MenusLib.  If it isn't there, get it from InterfaceLib.
	    anErr = GetSharedLibrary("\pMenusLib", kPowerPCCFragArch, kFindCFrag, 
	    							&connectionID, &mainAddress, errorString);
	    if (noErr == anErr)
	    {
	       	CFragSymbolClass    symbolClass;
	        anErr = FindSymbol(connectionID, "\pEnableMenuItem", 
	        					(Ptr *) &tEnableMenuItemProcPtr, &symbolClass);     
	        if (noErr != anErr)
	        	tEnableMenuItemProcPtr = nil;
	   	 }
		
		if (nil == tEnableMenuItemProcPtr)
		{
	    	anErr = GetSharedLibrary("\pInterfaceLib", kPowerPCCFragArch, kFindCFrag, 
	    								&connectionID, &mainAddress, errorString);
	    	if (noErr == anErr)
	    	{
	        	CFragSymbolClass    symbolClass;
	        	anErr = FindSymbol(connectionID, "\pEnableItem", 
	        						(Ptr *) &tEnableMenuItemProcPtr, &symbolClass);     
		        if (noErr != anErr)
		        	tEnableMenuItemProcPtr = nil;
	    	}
		}
	}
	
	if (nil != tEnableMenuItemProcPtr)
		(*tEnableMenuItemProcPtr)(menu, item);
	
	if (item == 0)  // if item is the menu title
		InvalMenuBar();
}

//——————————————————————————————————————————————————————————————————————————————————————————————————
// DisableMenuItem
// Note that before 8.5, we're limited to disabling the first 31 items.
pascal void DisableMenuItem(MenuHandle menu, MenuItemIndex item)
{
	static DoMenuItemProcPtr      	tDisableMenuItemProcPtr = nil;
    CFragConnectionID   			connectionID;
    Ptr                 			mainAddress;
    Str255              			errorString;
    OSErr               			anErr;

	if (nil == tDisableMenuItemProcPtr)	// if it's not defined yet…
	{
		// Resolve the symbol against the 8.5 MenusLib.  If it isn't there, get it from InterfaceLib.
	    anErr = GetSharedLibrary("\pMenusLib", kPowerPCCFragArch, kFindCFrag, 
	    							&connectionID, &mainAddress, errorString);
	    if (noErr == anErr)
	    {
	       	CFragSymbolClass    symbolClass;
	        FindSymbol(connectionID, "\pDisableMenuItem", 
	        			(Ptr *) &tDisableMenuItemProcPtr, &symbolClass);     
	   	 }
		
		if (nil == tDisableMenuItemProcPtr)
		{
	    	anErr = GetSharedLibrary("\pInterfaceLib", kPowerPCCFragArch, kFindCFrag, 
	    								&connectionID, &mainAddress, errorString);
	    	if (noErr == anErr)
	    	{
	        	CFragSymbolClass    symbolClass;
	        	anErr = FindSymbol(connectionID, "\pDisableItem", 
	        						(Ptr *) &tDisableMenuItemProcPtr, &symbolClass);
		        if (noErr != anErr)
		        	tDisableMenuItemProcPtr = nil;
	    	}
		}
	}

	if (nil != tDisableMenuItemProcPtr)
		(*tDisableMenuItemProcPtr)(menu, item);
	
	if (item == 0)  // if item is the menu title
		InvalMenuBar();
}

//——————————————————————————————————————————————————————————————————————————————————————————————————
// IsMenuItemEnabled
pascal Boolean IsMenuItemEnabled(MenuHandle menu, MenuItemIndex item)
{
	static DoMenuItemProcPtr      	tIsMenuItemEnabledProcPtr = nil;
    CFragConnectionID   			connectionID;
    Ptr                 			mainAddress;
    Str255              			errorString;
    OSErr               			anErr;

	if (nil == tIsMenuItemEnabledProcPtr)	// if not defined yet…
	{
		// Try to resolve the symbol against the 8.5 MenusLib.
	    anErr = GetSharedLibrary("\pMenusLib", kPowerPCCFragArch, kFindCFrag, &connectionID, &mainAddress, errorString);
	    if (noErr == anErr)
	    {
	       	CFragSymbolClass    symbolClass;
	        anErr = FindSymbol(connectionID, "\pIsMenuItemEnabled", (Ptr *) &tIsMenuItemEnabledProcPtr, &symbolClass);
	        if (noErr != anErr)
	        	tIsMenuItemEnabledProcPtr = nil;
		}
	}
   	 
	if (nil != tIsMenuItemEnabledProcPtr)
		(*tIsMenuItemEnabledProcPtr)(menu, item);
	else
	{
		if (item <= 31)
			return ((*menu)->enableFlags & (1L << item)) != 0;
		else
			// return the same enable state as the menu title flag
			return ((*menu)->enableFlags & 1L ) != 0;
	}
}
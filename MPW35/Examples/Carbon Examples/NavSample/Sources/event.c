/*
	File:		event.c

	Contains:	event code for NavSample

	Version:	1.4

	Disclaimer:	IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
				("Apple") in consideration of your agreement to the following terms, and your
				use, installation, modification or redistribution of this Apple software
				constitutes acceptance of these terms.  If you do not agree with these terms,
				please do not use, install, modify or redistribute this Apple software.

				In consideration of your agreement to abide by the following terms, and subject
				to these terms, Apple grants you a personal, non-exclusive license, under AppleÕs
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

#ifndef __DOCUMENT__
#include "document.h"
#endif

#include "NavDrag.h"
#include "file.h"

extern Document*	gFrontDocument;
extern short 		gQuit, gQuitting;
extern short 		gInBackground;
extern Boolean		gCanDrag;

void DoContent( Document* theDocument, EventRecord* theEvent );
void DoBackgroundContent( Document* theDocument, EventRecord* theEvent );
void DoMouseDown( EventRecord* theEvent );
void DoKey( char theChar );
void DoKeyDown( EventRecord* theEvent );
void DoActivate( EventRecord* theEvent );
void DoUpdate( EventRecord* theEvent );
void DoOSEvent( EventRecord* theEvent );
void DoHighLevelEvent( EventRecord* theEvent );
void DoEvent( EventRecord* theEvent );
void DoIdle( void );

extern ControlActionUPP myActionProcUPP;	// for Mixed Mode

#define	SleepDuration		20		// WaitNextEvent() sleep constant


// *****************************************************************************
// *
// *	DoContent()
// *
// *	Handles mouseDown events in the content region of a document window.
// *
// *	(1)	If the mouseDown is on a control, handle the click by calling TrackControl.
// *
// *	(2)	If the mouseDown is on a draggable object (the document's hiliteRgn) and a
// *		successful drag occurs, no further processing is necessary.
// *
// *	(3)	If the mouseDown is on a draggable object and the mouse is released without
// *		dragging, set the insertion point to the original mouseDown location by calling
// *		TEClick with the mouseDown information.
// *
// *	(4)	If the mouseDown is not on a draggable object and within the viewRect of the
// *		TextEdit field, call TEClick to handle the mouseDown.
// *
// *****************************************************************************
void DoContent( Document* theDocument, EventRecord* theEvent )
{	
	short			thePart;
	Point			thePoint;
	ControlHandle	theControl;

	if ( theDocument->theTE != NULL )
	{
		SetPort( (GrafPtr)GetWindowPort( theDocument->theWindow ) );

		thePoint = theEvent->where;
		GlobalToLocal(&thePoint);

		thePart = FindControl( thePoint, (WindowRef)theDocument->theWindow, &theControl );
		if ( thePart != 0 )
			{
			if (theControl == theDocument->vScroll)
			{
				if ( thePart == kControlIndicatorPart )
				{
					TrackControl( theControl,thePoint, 0L );
					AdjustDocumentView( theDocument );
				}
				else
					TrackControl( theControl, thePoint, myActionProcUPP );

				AdjustScrollBar( theDocument );
			}
		}
		else
			if ( PtInRgn( thePoint, theDocument->hiliteRgn ))
			{
				if ( gCanDrag )
					if (!DragTheText( theDocument, theEvent, theDocument->hiliteRgn ))
						TEClick( thePoint, false, theDocument->theTE );
			}
			else
				if ( PtInRect( thePoint, &(**(theDocument->theTE)).viewRect ))
					TEClick( thePoint, (theEvent->modifiers & shiftKey) != 0, theDocument->theTE );

		if ( gCanDrag )
			TEGetHiliteRgn( theDocument->hiliteRgn, theDocument->theTE );
	}
}


// *****************************************************************************
// *
// *	DoBackgroundContent()
// *
// *	Handles mouseDown events in the content region of a document window
// *	when the window is not frontmost. The following bullet items describe how this background
// *	mouseDown event is handled:
// *
// *	(1)	If the mouseDown is not in a draggable object (not in the document's hiliteRgn) call
// *		SelectWindow to bring the window to the front as usual.
// *
// *	(2)	If the mouseDown is in a draggable object and the mouse is released without
// *		dragging, call SelectWindow when the mouse is released.
// *
// *	(3)	If the mouseDown is in a draggable object and a successful drag occurs, SelectWindow
// *		should only be called if the drop occurred in the same window (the DragTheText function
// *		calls SelectWindow in this case).
// *
// *****************************************************************************
void DoBackgroundContent( Document* theDocument, EventRecord* theEvent )
{	
	Point thePoint;

	SetPort( (GrafPtr)GetWindowPort( theDocument->theWindow ) );

	thePoint = theEvent->where;
	GlobalToLocal( &thePoint );

	if ( theDocument->hiliteRgn != NULL )
	{
		if ( PtInRgn( thePoint, theDocument->hiliteRgn ) )
		{
			if ( !DragTheText(theDocument, theEvent, theDocument->hiliteRgn ))
				SelectWindow( (WindowRef)theDocument->theWindow );
		 	else
				SelectWindow( (WindowRef)theDocument->theWindow );
		}
		else
		{
			SelectWindow( theDocument->theWindow );
			DoContent( theDocument, theEvent );
		}
	}
	else
	{
		SelectWindow( theDocument->theWindow );
		DoContent( theDocument, theEvent );
	}
}


// *****************************************************************************
// *
// *	DoMouseDown( )
// *
// *	(1)	If the mouseDown is not in a draggable object (not in the document's hiliteRgn) call
// *		SelectWindow to bring the window to the front as usual.
// *
// *	(2)	If the mouseDown is in a draggable object and the mouse is released without
// *		dragging, call SelectWindow when the mouse is released.
// *
// *	(3)	If the mouseDown is in a draggable object and a successful drag occurs, SelectWindow
// *		should only be called if the drop occurred in the same window (the DragTheText function
// *		calls SelectWindow in this case).
// *
// *****************************************************************************
void DoMouseDown( EventRecord* theEvent )
{	
	short		thePart = 0;
	WindowPtr	theWindow = NULL;
	Document*	theDocument = NULL;

	thePart = FindWindow( theEvent->where, &theWindow );
	switch( thePart )
	{
		case inMenuBar:
		{
			AdjustMenus( );
			DoMenuCommand( MenuSelect( theEvent->where ) );
			break;
		}
			
#if !TARGET_API_MAC_CARBON
		case inSysWindow:
		{
			if ( theWindow != NULL )
				SystemClick( theEvent, theWindow );
			break;
		}
#endif
			
		case inContent:
		{
			if ( theWindow != NULL )
			{
				theDocument = IsDocumentWindow( theWindow );
				if ( theDocument != NULL )
				{
					if ( theWindow == FrontWindow( ) )
						DoContent( theDocument, theEvent );
					else
						DoBackgroundContent( theDocument, theEvent );
				}
			}
			break;
		}
			
		case inDrag:
		{
			if ( theWindow != NULL )
			{
				Rect	dragRect;
				BitMap 	screenBits;
				
				GetQDGlobalsScreenBits( &screenBits );
				
				if ( theWindow != FrontWindow( ) )
					SelectWindow( (WindowRef)theWindow );
				
				dragRect = screenBits.bounds;
				DragWindow( (WindowRef)theWindow, theEvent->where, &dragRect );
			}
			break;
		}
			
		case inGrow:
		{
			if ( theWindow != NULL )
			{
				theDocument = IsDocumentWindow( theWindow );
				if ( theDocument != NULL )
				{
					GrowDocumentWindow( theWindow, theEvent->where );
					if ( theDocument->theTE != NULL )
						TEGetHiliteRgn( theDocument->hiliteRgn, theDocument->theTE );
				}
			}
			break;
		}
		
		case inZoomIn:
		case inZoomOut:
		{
			if ( theWindow != NULL )
			{
				theDocument = IsDocumentWindow( theWindow );
				if ( theDocument != NULL )
					if ( (TrackBox( theWindow, theEvent->where, thePart )) && theDocument )
						DoZoomDocument( theDocument, theWindow, thePart );
			}
			break;
		}

		case inGoAway:
		{
			if ( theWindow != NULL )
			{
				theDocument = IsDocumentWindow( theWindow );
				if ( theDocument != NULL )
					if ( TrackGoAway( theWindow, theEvent->where ) )
					{
						CloseDocument( theDocument, false );
						AdjustMenus( );
						DrawMenuBar( );
					}
			}
			break;
		}
	}
}


// *****************************************************************************
// *
// *	DoKey( )
// *
// *	Called each time a character is typed on the keyboard to
// *	be entered into a document window.
// *
// *****************************************************************************
void DoKey( char theChar )
{	
	WindowPtr	theWindow = NULL;
	Document*	theDocument;

	theWindow = FrontWindow( );
	if ( theWindow != NULL )
	{
		theDocument = IsDocumentWindow( theWindow );
		if ( theDocument != NULL )
		{
			SetPort( (GrafPtr)GetWindowPort( theDocument->theWindow ) );

			if ( theDocument->theTE != NULL )
			{
				TEKey( theChar, theDocument->theTE );
				AdjustScrollBar( theDocument );
				theDocument->dirty = true;
				TEGetHiliteRgn( theDocument->hiliteRgn, theDocument->theTE );

				if ( (theChar < 0x1C) || (theChar > 0x1F) )
					DisableUndoDrag();
			}
		}
	}
}


// *****************************************************************************
// *
// *	DoKeyDown( )
// *
// *****************************************************************************
void DoKeyDown( EventRecord* theEvent )
{	
	char theChar;

	theChar = theEvent->message & charCodeMask;

	if ( theEvent->modifiers & cmdKey )
	{
		AdjustMenus( );
		DoMenuCommand( MenuKey( theChar ) );
	}
	else
		DoKey(theChar);
}


// *****************************************************************************
// *
// *	DoActivate( )
// *
// *****************************************************************************
void DoActivate( EventRecord* theEvent )
{	
	WindowPtr	theWindow = NULL;
	Document*	theDocument = NULL;

	theWindow = (WindowPtr)theEvent->message;
	if ( theWindow != NULL )
	{
		theDocument = IsDocumentWindow( theWindow );
		if (theDocument != NULL )
			DoActivateDocument( theDocument, (theEvent->modifiers & activeFlag) );
	}
}


// *****************************************************************************
// *
// *	DoUpdate( )
// *
// *****************************************************************************
void DoUpdate( EventRecord* theEvent )
{	
	Document* theDocument = NULL;

	theDocument = IsDocumentWindow( (WindowPtr)theEvent->message );
	
	if ( theDocument != NULL )
		UpdateWindow( theDocument );
}


// *****************************************************************************
// *
// *	DoOSEvent( )
// *
// *****************************************************************************
void DoOSEvent( EventRecord* theEvent )
{	
	Document* theDocument = NULL;
	WindowPtr theWindow = NULL;
	
	theWindow = FrontWindow( );
	
	switch ((theEvent->message >> 24) & 0x0FF)
	{
		case suspendResumeMessage:
			gInBackground = (theEvent->message & resumeFlag) == 0;
			if ( theWindow != NULL )
			{
				theDocument = IsDocumentWindow( theWindow );
				if ( theDocument != NULL )
					DoActivateDocument( theDocument, !gInBackground );
			}
			break;
	}
}


// *****************************************************************************
// *
// *	MyHandleOAPP()
// *
// *****************************************************************************
#if UNIVERSAL_INTERFACES_VERSION<=0x0335
pascal OSErr MyHandleOAPP( const AppleEvent* theAppleEvent, AppleEvent* reply, UInt32 handlerRefCon )
#else
pascal OSErr MyHandleOAPP( const AppleEvent* theAppleEvent, AppleEvent* reply, long handlerRefCon )
#endif
{
#pragma unused ( theAppleEvent, reply, handlerRefCon )
	return noErr;
}


// *****************************************************************************
// *
// *	MyHandleODOC()
// *
// *****************************************************************************
#if UNIVERSAL_INTERFACES_VERSION<=0x0335
pascal OSErr MyHandleODOC( const AppleEvent* theAppleEvent, AppleEvent* reply, UInt32 handlerRefCon )
#else
pascal OSErr MyHandleODOC( const AppleEvent* theAppleEvent, AppleEvent* reply, long handlerRefCon )
#endif
{	
#pragma unused ( reply, handlerRefCon )

	AEDescList	docList;
	AEKeyword	keyword;
	DescType	returnedType;
	FSSpec		theFSSpec;
	Size		actualSize;
	long		itemsInList;
	short		index;
	OSErr		result = noErr;
	FInfo		fileInfo;

	result = AEGetParamDesc( theAppleEvent, keyDirectObject, typeAEList, &docList );
	if ( result != noErr )
		return result;

	result = AECountItems( &docList, &itemsInList );
	if ( result != noErr )
		return result;

	for ( index=1; index<=itemsInList; index++ )
	{
		result = AEGetNthPtr( &docList, index, typeFSS, &keyword, &returnedType, (Ptr)&theFSSpec, sizeof(FSSpec), &actualSize );
		if ( result != noErr )
			return result;

		// decide if the doc we are opening is a PICT or TEXT
		result = FSpGetFInfo( &theFSSpec, &fileInfo );
		if ( result == noErr )
		{
			if ( fileInfo.fdType == 'TEXT' )
				DoOpenFile( &theFSSpec, false );
			else
				DoOpenFile( &theFSSpec, true );
		}
	}
	return result;
}


// *****************************************************************************
// *
// *	MyHandleQUIT()
// *
// *****************************************************************************
#if UNIVERSAL_INTERFACES_VERSION<=0x0335
pascal OSErr MyHandleQUIT( const AppleEvent* theAppleEvent, AppleEvent* reply, UInt32 handlerRefCon )
#else
pascal OSErr MyHandleQUIT( const AppleEvent* theAppleEvent, AppleEvent* reply, long handlerRefCon )
#endif

{	
#pragma unused ( theAppleEvent, reply, handlerRefCon )

	Document* theDocument;
	WindowPtr theWindow = NULL;
	
	gQuitting = true;
	
	theWindow = FrontWindow( );	// do we have any open windows?
	if ( theWindow != NULL )
	{
		theDocument = IsDocumentWindow( theWindow );
		while ( gQuitting && theDocument != NULL )
		{
			if ( theDocument != NULL )
				CloseDocument( theDocument, true );
			theDocument = IsDocumentWindow( theWindow );
		}
	}
	
	if ( gQuitting )
		gQuit = true;

	return noErr;
}


// *****************************************************************************
// *
// *	ScrollProc()
// *
// *****************************************************************************
pascal void ScrollProc(ControlHandle theControl, short theCode)
{	
	short		delta = 0, pageDelta;
	Document*	theDocument;
	Rect		viewRect;
	SInt32 		theCtrlRef = GetControlReference(theControl);

	if (theCode == 0)
		return;

	theDocument = (Document*)theCtrlRef;
	
	viewRect = (**(theDocument->theTE)).viewRect;
	pageDelta = ((viewRect.bottom - viewRect.top) / ScrollResolution) - 1;

	switch(theCode)
		{
		case kControlUpButtonPart:
			delta = -1;
			break;
		case kControlDownButtonPart:
			delta = 1;
			break;
		case kControlPageUpPart:
			delta = -pageDelta;
			break;
		case kControlPageDownPart:
			delta = pageDelta;
			break;
		}

	SetControlValue(theControl,GetControlValue(theControl) + delta);
	AdjustDocumentView((Document*)theDocument);
}


// *****************************************************************************
// *
// *	DoHighLevelEvent()
// *
// *****************************************************************************
void DoHighLevelEvent(EventRecord* theEvent)
{
	AEProcessAppleEvent(theEvent);
}


// *****************************************************************************
// *
// *	DoEvent()
// *
// *****************************************************************************
void DoEvent( EventRecord* theEvent )
{	
	WindowPtr	theWindow = NULL;
	Document*	theDocument;

	theWindow = FrontWindow( );
	if ( theWindow != NULL )
	{
		theDocument = IsDocumentWindow( theWindow );
		if ( theDocument != NULL )
			gFrontDocument = theDocument;
	}

	switch( theEvent->what )
	{
		case mouseDown:
			DoMouseDown(theEvent);
			break;
		case mouseUp:
			break;
		case keyDown:
		case autoKey:
			DoKeyDown(theEvent);
			break;
		case activateEvt:
			DoActivate(theEvent);
			break;
		case updateEvt:
			DoUpdate(theEvent);
			break;
		case osEvt:
			DoOSEvent(theEvent);
			break;
		case kHighLevelEvent:
			DoHighLevelEvent(theEvent);
			break;
	}
}


// *****************************************************************************
// *
// *	DoIdle( )
// *
// *****************************************************************************
void DoIdle( )
{	
	WindowPtr	theWindow = NULL;
	Document*	theDocument;

	theWindow = FrontWindow( );
	if ( theWindow != NULL )
	{
		theDocument = IsDocumentWindow( theWindow );
		if ( theDocument != NULL )
			if ( theDocument->theTE != NULL )
			{
				SetPort( (GrafPtr)GetWindowPort( theDocument->theWindow ) );
				TEIdle( theDocument->theTE );
			}
	}
}


// *****************************************************************************
// *
// *	EventLoop()
// *
// *****************************************************************************
void EventLoop()
{	
	short		gotEvent;
	EventRecord	theEvent;
	RgnHandle	theMouseRgn;

	theMouseRgn = NewRgn( );
	do 
	{
		gotEvent = WaitNextEvent( everyEvent, &theEvent, SleepDuration, theMouseRgn );
		if ( gotEvent )
		{
			AdjustCursor( theEvent.where, theMouseRgn );
			DoEvent( &theEvent );
			AdjustCursor( theEvent.where, theMouseRgn );
		}
		else
			DoIdle( );
	}
	while( !gQuit );

	DisposeRgn( theMouseRgn );
}
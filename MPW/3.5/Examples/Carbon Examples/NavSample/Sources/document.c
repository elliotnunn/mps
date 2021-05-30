/*
	File:		document.c

	Contains:	document code for NavSample

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

#ifdef __MRC__
#include <ToolUtils.h>
#endif	// __MRC__

#ifndef __DOCUMENT__
#include "document.h"
#endif

#ifndef __myFILE__
#include "file.h"
#endif


// minimum grow dimensions for text window:
#define kMinHeight 	200
#define kMinWidth	200

extern short 		gDocumentCount;
extern Document*	gDocumentList[kMaxDocumentCount];
extern short 		gQuitting;
extern short		gCanUndoDrag;
extern WindowPtr	gUndoFrontmost, gLastFrontmost;
extern Boolean		gCanDrag;
extern Boolean		gNavServicesExists;

extern pascal OSErr MyTrackingHandler( short message, WindowPtr theWindow, void* handlerRefCon, DragReference theDrag );
extern pascal OSErr MyReceiveDropHandler( WindowPtr theWindow, void* handlerRefCon, DragReference theDrag );

void PositionDocumentParts( Document* theDocument );
void DoDrawGrowIcon( WindowPtr theWindow );

DragReceiveHandlerUPP 	receiveHandler;
DragTrackingHandlerUPP 	trackingHandler;
DragSendDataUPP 		sendHandler;

NavAskSaveChangesResult OpenAskSaveChanges( unsigned char* docName, Boolean quitting );


// **********************************************************************
// *
// *	AddText( )
// *
// **********************************************************************
void AddText( Document* theDocument, Ptr text, long len )
{
	if ( theDocument->theTE != NULL )
	{
		TEInsert( text, len, theDocument->theTE );
		theDocument->dirty = true;
		TESelView( theDocument->theTE );
		AdjustScrollBar( (Document*)GetWRefCon( theDocument->theWindow ) );
	}
}


// **********************************************************************
// *
// *	AdjustDocumentView( )
// *
// **********************************************************************
void AdjustDocumentView( Document* theDocument )
{	
	short	delta, docTop, docTopLimit;

	delta = (theDocument->vScrollPos - GetControlValue( theDocument->vScroll )) * ScrollResolution;

	if ( delta && theDocument->theTE != NULL )
	{
		if ( delta > 0 )
		{
			docTop = (**(theDocument->theTE)).destRect.top;
			docTopLimit = (**(theDocument->theTE)).viewRect.top + TopMargin;
			if ( docTop + delta > docTopLimit )
				delta = docTopLimit - docTop;
		}
		TEScroll(0,delta,theDocument->theTE);
		theDocument->vScrollPos = GetControlValue( theDocument->vScroll );
	}
}


// **********************************************************************
// *
// *	AdjustScrollBar( )
// *
// **********************************************************************
void AdjustScrollBar( Document* theDocument )
{	
	if ( theDocument->theTE != NULL )
	{
		short		docTop, docBottom, viewTop, viewBottom;
		short		offTop, offBottom;
		RgnHandle	viewRgn;
	
		docTop = (**(theDocument->theTE)).destRect.top;
		docBottom = docTop + TEGetHeight( 32767, 0, theDocument->theTE );
		viewTop = (**(theDocument->theTE)).viewRect.top;
		viewBottom = (**(theDocument->theTE)).viewRect.bottom;
	
		offTop = ((viewTop - (docTop - TopMargin)) + ScrollResolution - 1) / ScrollResolution;
		offBottom = (((docBottom + BottomMargin) - viewBottom) + ScrollResolution - 1) / ScrollResolution;
		if ( offTop < 0 )
			offTop = 0;
		if ( offBottom < 0 )
			offBottom = 0;
	
		theDocument->vScrollPos = offTop;
	
		SetControlMaximum( theDocument->vScroll,offTop + offBottom );
		SetControlValue( theDocument->vScroll, offTop );
	
		viewRgn = NewRgn( );
		RectRgn( viewRgn, &(**(theDocument->theTE)).viewRect );
		SectRgn( viewRgn, theDocument->hiliteRgn, theDocument->hiliteRgn );
		DisposeRgn( viewRgn );
	}
}


// **********************************************************************
// *
// *	PositionDocumentParts( )
// *
// **********************************************************************
void PositionDocumentParts( Document* theDocument )
{	
	Rect globalBounds;

	GetPortBounds( GetWindowPort( theDocument->theWindow ), &globalBounds );

	// size the vertical scrollbar:
	SizeControl( theDocument->vScroll, kScrollBarWidth, (globalBounds.bottom - globalBounds.top - kScrollBarPos) + 4 );
	MoveControl( theDocument->vScroll, globalBounds.right + 2 - kScrollBarPos, -1 );

	// size the horizontal scrollbar:
	SizeControl( theDocument->hScroll, (globalBounds.right - globalBounds.left - kScrollBarPos) + 4, kScrollBarWidth );
	MoveControl( theDocument->hScroll, -1, (globalBounds.bottom - globalBounds.top - kScrollBarPos) + 2 );

	if ( theDocument->theTE != NULL )
	{
		Rect theRect;
		
		theRect = globalBounds;
		theRect.right  -= 15;
		theRect.bottom -= 15;
		theRect.left += LeftMargin;
		theRect.top += TopMargin;
		
 		(**(theDocument->theTE)).viewRect = theRect;
		(**(theDocument->theTE)).destRect.right = theRect.right - RightMargin;
			
		TECalText( theDocument->theTE );
	}
}


// **********************************************************************
// *
// *	SizeDocWindow( )
// *
// **********************************************************************
void SizeDocWindow( Document* theDocument )
{
	short 	length = 0;
	short 	width = 0;

	if ( theDocument->fPict != NULL )	
	{		
		// this is a PICT document:
		BitMap 	screenBits;
		Rect 	screenBounds = GetQDGlobalsScreenBits( &screenBits )->bounds;
	
		if ((**((PicHandle)theDocument->fPict)).picFrame.right >= screenBounds.right )
			width = screenBounds.right - 40;
		else
			width = (**((PicHandle)theDocument->fPict)).picFrame.right;

		if ((**((PicHandle)theDocument->fPict)).picFrame.bottom >= screenBounds.right )
			length = screenBounds.bottom - 10 - GetMBarHeight( ) - 27;
		else
			length = (**((PicHandle)theDocument->fPict)).picFrame.bottom;
	}
	else
	{
		// this is a text document:
		length = kWindowHeight;
		width = kWindowWidth;
	}
	SizeWindow( theDocument->theWindow, width, length, true );
}


// **********************************************************************
// *
// *	NewDocument( )
// *
// **********************************************************************
Document* NewDocument( Boolean newDocAsPICT )
{	
	OSErr			theErr = noErr;
	Document*		theDocument = NULL;
	Rect			theRect = {0,0,16,16};
	TextStyle		theStyle;
	TEStyleHandle	theStyleHandle;
  	Str255			windTitle, numDocsStr;
	short			strSize;
	short 			offset = 0;
        
	if ( gDocumentCount == kMaxDocumentCount )
   		return NULL;
		
	theDocument = gDocumentList[gDocumentCount++] = (Document*)NewPtr( sizeof( Document ) );
	if ( theDocument != NULL )
	{
 		Rect theSize = {0,0,1,1};
 					
		offset = gDocumentCount - 1;
			
		// create the window:
		theDocument->theWindow = NewCWindow( NULL, &theSize, "\p", false, zoomDocProc, (WindowPtr)-1, true, 0 );

		// setup the window title
		GetIndString( windTitle, rAppStringsID, sUntitled );
		NumToString( gDocumentCount, numDocsStr );
		strSize = numDocsStr[0] + windTitle[0];
		BlockMoveData( numDocsStr+1, windTitle + windTitle[0] + 1, numDocsStr[0] );
		windTitle[0] = strSize;
		SetWTitle( theDocument->theWindow, windTitle );
		
		SetWRefCon( theDocument->theWindow, (long)theDocument );

		SetPort( (GrafPtr)GetWindowPort( theDocument->theWindow ) );

		theDocument->hiliteRgn = NewRgn( );
		theDocument->undoDragText = 0L;
               
		theDocument->fPict = NULL;
 		theDocument->fPictLength = 0;

		SizeDocWindow( theDocument );
		
		if ( newDocAsPICT )
		{
			theDocument->theTE = NULL;
			theDocument->fHeader = NULL;
		}
		else
		{
			Rect destRect;

			theDocument->vScroll = NewControl( theDocument->theWindow, &theRect, (ConstStr255Param)"\p", true, 0, 0, 0, scrollBarProc, (long)theDocument );
			theDocument->hScroll = NewControl( theDocument->theWindow, &theRect, (ConstStr255Param)"\p", true, 0, 0, 0, scrollBarProc, (long)theDocument );

 			SetRect( &destRect, LeftMargin, TopMargin, 32767, 32767 );
     		theDocument->theTE = TEStyleNew( &destRect, &destRect );
                        
			TEAutoView( true, theDocument->theTE );

			TEFeatureFlag( teFOutlineHilite, teBitSet, theDocument->theTE );

			theStyleHandle = TEGetStyleHandle( theDocument->theTE );
			(**theStyleHandle).teRefCon = (long)theDocument;

			theStyle.tsFont = 21;
			theStyle.tsSize = 12;
			TESetStyle( doFont + doSize, &theStyle, false, theDocument->theTE );
			
			theDocument->vScrollPos = 0;
			
			PositionDocumentParts( theDocument );

			if ( gCanDrag && theDocument->theTE != NULL )
			{
				receiveHandler = NewDragReceiveHandlerUPP( MyReceiveDropHandler );
				trackingHandler = NewDragTrackingHandlerUPP( MyTrackingHandler );
				
				theErr = InstallReceiveHandler( receiveHandler, theDocument->theWindow, (void*)theDocument );
				theErr = InstallTrackingHandler( trackingHandler, theDocument->theWindow, (void*)theDocument );
			}
		}
		
		theDocument->fRefNum = 0;
		
		theDocument->dirty = false;
		theDocument->fileLocked = false;

#if TARGET_API_MAC_CARBON
		theDocument->fConfirmEventProc = NewNavEventUPP( modernConfirmEventProc );
#endif
		theDocument->fNavigationDialog = NULL;	// no Nav dialog yet
		
		// finally, set the window's screen position:
		MoveWindow( theDocument->theWindow, (10+(offset*20)), (27+(offset*20)+GetMBarHeight( )), true );
		
		return theDocument;
	}
	else
		return NULL;
}

// **********************************************************************
// *
// *	OpenAskSaveChanges( )
// *
// **********************************************************************
NavAskSaveChangesResult OpenAskSaveChanges( unsigned char* docName, Boolean quitting )
{
	OSErr 					theErr 			= noErr;
	NavAskSaveChangesResult	reply 			= 0;
	NavAskSaveChangesAction	action 			= 0;
	NavEventUPP				eventUPP 		= NewNavEventUPP( myEventProc );
	NavDialogOptions		dialogOptions;
	
	if (quitting)
		action = kNavSaveChangesQuittingApplication;
	else
		action = kNavSaveChangesClosingDocument;
		
	NavGetDefaultDialogOptions( &dialogOptions );

	BlockMoveData( docName, dialogOptions.savedFileName, docName[0]+1 );
	GetIndString( dialogOptions.clientName, rAppStringsID, sApplicationName );

	theErr = NavAskSaveChanges(	&dialogOptions,
								action,
								&reply,
								eventUPP,
								(NavCallBackUserData)&gDocumentList);
	
	DisposeNavEventUPP( eventUPP );

	return reply;
}


// **********************************************************************
// *
// *	CloseDocument( )
// *
// **********************************************************************
void CloseDocument( Document* theDocument, Boolean quitting )
{	
	short index = 0;

	while ( gDocumentList[index] != theDocument && index < kMaxDocumentCount )
		index++;

	if ( gDocumentList[index] == theDocument )
	{
		OSErr theErr = noErr;
		
		if ( theDocument->dirty && !theDocument->fileLocked )
		{
			Str255 theName;
			
			if ( gNavServicesExists )
			{
				NavAskSaveChangesResult result = 0;
				
				GetWTitle( theDocument->theWindow, (unsigned char*)&theName );
				result = OpenAskSaveChanges( theName, quitting );
				switch (result)
				{
					case kNavAskSaveChangesSave:
					{
						if ( !DoSaveDocument( theDocument ) )
						{
							gQuitting = false;	// don't quit yet!
						}
						break;
					}
						
					case kNavAskSaveChangesCancel:
					{
						gQuitting = false;	// don't quit yet!
						break;
					}
				}
				if ( result == kNavAskSaveChangesCancel )
					return;	// don't close the document
			}
			else
			{
				short 	response = 0;
				Str255 	theVerb;
				
				GetWTitle( theDocument->theWindow, (unsigned char*)&theName );
				GetIndString( (unsigned char*)&theVerb, rAppStringsID, (gQuitting) ? slQuittingIndex : slClosingIndex );
				ParamText( (ConstStr255Param)&theName, (ConstStr255Param)&theVerb, (ConstStr255Param)"\p", (ConstStr255Param)"\p" );
				
				InitCursor( );
				response = Alert( rSaveChangesID, 0L );

				if ( response == 1 )
				{	// Save
					if ( !DoSaveDocument( theDocument ) )
					{
						gQuitting = false;
						return;
					}
				}
				else
					if ( response == 3 )
					{	// Don't Save
						;
					}
					else
					{	// Cancel
						gQuitting = false;
						return;
					}
			}
		}

		if ( theDocument->fRefNum )
			FSClose( theDocument->fRefNum );

		if ( gCanDrag && theDocument->theTE != NULL )
		{
			theErr = RemoveReceiveHandler( receiveHandler, theDocument->theWindow );
			theErr = RemoveTrackingHandler( trackingHandler, theDocument->theWindow );
		}
		
		if ( theDocument->theTE != NULL )
		{
			DisposeRgn( theDocument->hiliteRgn );
			TEDispose( theDocument->theTE );
			
			if ( theDocument->undoDragText )
			{
				DisposeHandle( theDocument->undoDragText );
				theDocument->undoDragText = 0L;
			}
		}
		else
		{
			if ( theDocument->fPict != NULL )
				KillPicture( (PicHandle)theDocument->fPict );	
			if ( theDocument->fHeader != NULL )
				DisposeHandle( theDocument->fHeader );
		}

		if ( theDocument->fConfirmEventProc != NULL )
			DisposeNavEventUPP( theDocument->fConfirmEventProc );
		
		DisposeWindow( theDocument->theWindow );

		while ( index < kMaxDocumentCount )
		{
			gDocumentList[index] = gDocumentList[index + 1];
			index++;
		}

		DisposePtr( (Ptr)theDocument );
		gDocumentCount--;
	}
}


// **********************************************************************
// *
// *	DoActivateDocument( )
// *
// **********************************************************************
void DoActivateDocument( Document* theDocument, short activate )
{	
	if ( theDocument->theTE != NULL )
	{
		if ( activate )
		{
			TEActivate( theDocument->theTE );
			HiliteControl( theDocument->vScroll,0 );
			HiliteControl( theDocument->hScroll,0 );
			DoDrawGrowIcon( theDocument->theWindow );
			TEGetHiliteRgn( theDocument->hiliteRgn, theDocument->theTE );
		}
		else
		{
			TEDeactivate( theDocument->theTE );
			HiliteControl( theDocument->vScroll,255 );
			HiliteControl( theDocument->hScroll,255 );
			DoDrawGrowIcon( theDocument->theWindow );
		}
	}
}


// **********************************************************************
// *
// *	IsDocumentWindow( )
// *
// **********************************************************************
Document* IsDocumentWindow( WindowPtr theWindow )
{	
	Document* theDocument = NULL;

	theDocument = (Document*)GetWRefCon( theWindow );
	if ( theDocument != NULL )
	{
		short index = 0;
		
		while ( (gDocumentList[index] != theDocument) && (index < gDocumentCount) )
			index++;

		if ( gDocumentList[index] == theDocument )
			return( theDocument );
		else
			return( (Document*)0L );
	}
	else
		return( (Document*)0L );
}


// **********************************************************************
// *
// *	DoSelectAllDocument( )
// *
// **********************************************************************
void DoSelectAllDocument( Document* theDocument )
{
	if ( theDocument && theDocument->theTE != NULL )
		TESetSelect( 0, 32767, theDocument->theTE );
}


// **********************************************************************
// *
// *	DisableUndoDrag( )
// *
// **********************************************************************
void DisableUndoDrag( )
{	
	short		index;
	Document*	theDoc = NULL;

	gCanUndoDrag = slCantUndo;

	index = gDocumentCount;
	while (index--)
	{
		theDoc = gDocumentList[index];
		if ( theDoc != NULL && theDoc->undoDragText )
		{
			DisposeHandle( theDoc->undoDragText );
			theDoc->undoDragText = 0L;
		}
	}
}


// **********************************************************************
// *
// *	DoUndoDrag( )
// *
// **********************************************************************
void DoUndoDrag( )
{	
	if ( gCanUndoDrag != slCantUndo )
	{
		short		index, selStart, selEnd;
		Document*	theDoc;
		Handle		theText = NULL;	
		Rect		theRect;
		WindowPtr	theWindow = NULL;
		
		index = gDocumentCount;
		while (index--)
		{
			theDoc = gDocumentList[index];

			SetPort( (GrafPtr)GetWindowPort( theDoc->theWindow ) );
			
			theText = theDoc->undoDragText;
			if ( theText != NULL )
			{
				Rect bounds;
				GetPortBounds( GetWindowPort( theDoc->theWindow ), &bounds );

				theDoc->undoDragText = (**theDoc->theTE).hText;
				(**theDoc->theTE).hText = theText;

				TECalText( theDoc->theTE );

				selStart = theDoc->undoSelStart;
				selEnd   = theDoc->undoSelEnd;
				TESetSelect( selStart, selEnd, theDoc->theTE );
				theDoc->undoSelStart = theDoc->lastSelStart;
				theDoc->undoSelEnd   = theDoc->lastSelEnd;
				theDoc->lastSelStart = selStart;
				theDoc->lastSelEnd   = selEnd;

				theRect = bounds;
				theRect.right  -= 15;
				theRect.bottom -= 15;
				EraseRect( &theRect );
				TEUpdate( &theRect, theDoc->theTE );
			}
		}

		if ( gCanUndoDrag == slUndoDrag )
			gCanUndoDrag = slRedoDrag;
		else
			gCanUndoDrag = slUndoDrag;

		theWindow = gUndoFrontmost;
		gUndoFrontmost = gLastFrontmost;
		gLastFrontmost = theWindow;
	}
}


// *****************************************************************************
// *
// *	DoDrawGrowIcon( )
// *
// *****************************************************************************
void DoDrawGrowIcon( WindowPtr theWindow )
{
	RgnHandle saveClipRgn = NULL;
	saveClipRgn = NewRgn( );
	if ( saveClipRgn != NULL )
	{
		Rect portBounds;
		Rect tempRect;
	
		GetClip( saveClipRgn );
		
		GetPortBounds( GetWindowPort( theWindow ), &portBounds );

		SetRect( &tempRect,
				portBounds.right-15,
				portBounds.bottom-15,
				portBounds.right,
				portBounds.bottom );
		ClipRect( &tempRect );
		DrawGrowIcon( theWindow );
		
		SetClip( saveClipRgn );
		DisposeRgn( saveClipRgn );
	}
	else
		DrawGrowIcon( theWindow );
}


// *****************************************************************************
// *
// *	UpdateWindow( )
// *
// *	Update event is received for a document window.
// *
// *****************************************************************************
void UpdateWindow( Document* theDocument )
{	
	WindowPtr 	theWindow = theDocument->theWindow;
	Rect 		bounds;
	
	GetPortBounds( GetWindowPort( theDocument->theWindow ), &bounds );
	
	SetPort( (GrafPtr)GetWindowPort( theWindow ) );
	
	BeginUpdate( theWindow );

	EraseRect( &bounds );
	if ( theDocument->theTE != NULL )
	{
		DrawControls( theWindow );
		DoDrawGrowIcon( theWindow );
		if ( theDocument->theTE )
			TEUpdate( &bounds, theDocument->theTE );
	}
	else
	{
		if ( theDocument->fPict != NULL )
			DrawPicture( (PicHandle)theDocument->fPict, &((**((PicHandle)theDocument->fPict)).picFrame) );
	}
	
	EndUpdate( theWindow );
}


// *****************************************************************************
// *
// *	DoZoomDocument( )
// *
// *****************************************************************************
void DoZoomDocument( Document* theDocument, WindowPtr theWindow, short thePart )
{
	Rect 	bounds;
	GrafPtr	oldPort;
	
	GetPort( &oldPort );
	
	SetPort( (GrafPtr)GetWindowPort( theWindow ) );
		
	GetPortBounds( GetWindowPort( theWindow ), &bounds );

	EraseRect( &bounds );

	ZoomWindow( theWindow, thePart, theWindow == FrontWindow( ) );
	
	if ( theDocument->theTE != NULL )
	{
		PositionDocumentParts( (Document*)GetWRefCon( theWindow ) );
		AdjustScrollBar( (Document*)GetWRefCon( theWindow ) );
		DoDrawGrowIcon( theWindow );
	}

	GetPortBounds( GetWindowPort( theWindow ), &bounds );
	InvalWindowRect( theWindow, &bounds );
	
	SetPort( oldPort );
}


// *****************************************************************************
// *
// *	GrowDocumentWindow( )
// *
// *****************************************************************************
void GrowDocumentWindow( WindowPtr theWindow, Point thePoint )
{	
	long		result;
	Rect		bounds, r;
	RgnHandle 	theGrayRgn;
	GrafPtr		oldPort;
	
	GetPort( &oldPort );
	
	GetPortBounds( GetWindowPort( theWindow ), &bounds );

	SetPort( (GrafPtr)GetWindowPort( theWindow ) );
			
	theGrayRgn = GetGrayRgn( );
	GetRegionBounds( theGrayRgn, &r );
	r.top = kMinHeight;
	r.left = kMinWidth;
		
	if ((result = GrowWindow( theWindow, thePoint, &r )) != noErr)
		return;
		
	SizeWindow( theWindow, LoWord( result ), HiWord( result ), false );

	PositionDocumentParts( (Document*)GetWRefCon( theWindow ) );

	AdjustScrollBar( (Document*)GetWRefCon( theWindow ) );

	DoDrawGrowIcon( theWindow );

	SetPort( oldPort );
	
	GetPortBounds( GetWindowPort( theWindow ), &bounds );
	InvalWindowRect( theWindow, &bounds );
}


#if TARGET_API_MAC_CARBON
// *****************************************************************************
// *
// *	modernConfirmEventProc( )
// *
// *****************************************************************************
pascal void modernConfirmEventProc( NavEventCallbackMessage callBackSelector, NavCBRecPtr callBackParms, void* callBackUD )
{	      	
  	switch( callBackSelector )
	{
		case kNavCBTerminate:
		{
			Document* theDocument = (Document*)callBackUD;
			if ( 	theDocument != NULL &&
					theDocument->fNavigationDialog != NULL )
			{		
				switch( callBackParms->userAction )
	 			{
	  				case kNavUserActionSaveChanges:
	               		break;
	                    
					case kNavUserActionDiscardChanges:
	              		break;
	                	                
	           		case kNavUserActionCancel:
	             		break;
	            }
	            
	         	// this Nav dialog belongs to a certain document:
	         	NavDialogDispose( theDocument->fNavigationDialog );
	        	theDocument->fNavigationDialog = NULL;
        	}
        	break;
        }
    }
}
#endif // TARGET_API_MAC_CARBON
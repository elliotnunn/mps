/*
	File:		drag.c

	Contains:	NavSample's code for dragging text

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
#include <Folders.h>
#endif	// __MRC__

#ifndef __DOCUMENT__
#include "document.h"
#endif

#include "navdrag.h"


static long		caretTime;
static short	caretOffset, caretShow, lastOffset, insertPosition, canAcceptItems;
static short	cursorInContent;

#define	gCaretTime			((short)*((long*)0x02F4))	// provides access to TextEdit's caretTime.
#define	kTextFlavorType		'TEXT'
#define kStylFlavorType		'styl'

short HitTest( Point theLoc, Document** theDoc );
void DrawCaret( short offset, TEHandle theTE );
char GetCharAtOffset( short offset, TEHandle theTE );
Boolean WhiteSpace( char theChar );
Boolean WhiteSpaceAtOffset( short offset, TEHandle theTE );
void InsertTextAtOffset( short offset, char* theBuf, long size, StScrpHandle theStyl, TEHandle theTE );
short GetSelectionSize( Document* theDocument );
Ptr GetSelectedTextPtr( Document* theDocument );

pascal OSErr MySendDataProc( FlavorType theType, void* refCon, ItemReference theItem, DragReference theDrag );
pascal OSErr myDrawingProc( DragRegionMessage message, RgnHandle showRgn, Point showOrigin, RgnHandle hideRgn, Point hideOrigin, void* dragDrawingRefCon, DragReference theDragRef );
pascal OSErr MyReceiveDropHandler( WindowPtr theWindow, void* handlerRefCon, DragReference theDrag);
pascal OSErr MyTrackingHandler( short message, WindowPtr theWindow, void* handlerRefCon, DragReference theDrag );

Boolean DropLocationIsFinderTrash( AEDesc* dropLocation );

extern DragSendDataUPP sendHandler;


// *****************************************************************************
// *
// *	myDrawingProc( )
// *
// *****************************************************************************
pascal OSErr myDrawingProc( DragRegionMessage message, RgnHandle showRgn, Point showOrigin, RgnHandle hideRgn, Point hideOrigin, void* dragDrawingRefCon, DragReference theDragRef )
{
#pragma unused( showOrigin, hideOrigin, dragDrawingRefCon, theDragRef )

    OSErr		result = paramErr;
	RgnHandle	tempRgn;

	switch( message )
	{
		case kDragRegionBegin:
			result = noErr;
			break;

		case kDragRegionDraw:
			MacXorRgn( showRgn, hideRgn, tempRgn = NewRgn( ) );
			InvertRgn( tempRgn );
			DisposeRgn( tempRgn );
			result = noErr;
			break;

		case kDragRegionHide:
			InvertRgn( hideRgn );
			result = noErr;
			break;
	}
	return result;
}


// *****************************************************************************
// *
// *	HitTest( )
// *
// *	Given a point in global coordinates, HitTest returns a pointer to a
// *	document structure if the point is inside a document window on the screen.
// *	If the point is not inside a document window, HitTest return NULL in
// *	theDoc. If the point is in a doument window and also in the viewRect of
// *	the document's TextEdit field, HitTest also returns the offset into
// *	the text that corresponds to that point. If the point is not in the text,
// *	HitTest returns -1.
// *
// *****************************************************************************
short HitTest( Point theLoc, Document** theDoc )
{	
	WindowPtr	theWindow;
	short		offset;

	*theDoc = 0L;
	offset = -1;

	if ( FindWindow( theLoc, &theWindow ) == inContent )
	{
		*theDoc = IsDocumentWindow( theWindow );
		if ( *theDoc != NULL )
		{
			SetPort( (GrafPtr)GetWindowPort( theWindow ) );
			GlobalToLocal( &theLoc );

			if ((PtInRect( theLoc, &(**((**theDoc).theTE)).viewRect )) && 
				(PtInRect( theLoc, &(**((**theDoc).theTE)).destRect )))
			{
				offset = TEGetOffset(theLoc,(**theDoc).theTE);

				if ((TEIsFrontOfLine( offset, (**theDoc).theTE )) && (offset) &&			
						((*((**((**theDoc).theTE)).hText))[offset - 1] != 0x0D) &&
						(TEGetPoint( offset - 1, (**theDoc).theTE).h < theLoc.h) )
				{
						offset--;
				}
			}
		}
	}
	return offset;
}


// *****************************************************************************
// *
// *	DrawCaret( )
// *
// *	Draws a caret in a TextEdit field at the given offset. DrawCaret
// *	expects the port to be set to the port that the TextEdit field is in.
// *	DrawCaret inverts the image of the caret onto the screen.
// *
// *****************************************************************************
void DrawCaret( short offset, TEHandle theTE )
{	
	Point	theLoc;
	short	theLine, lineHeight;

	// get the coordinates and the line of the offset to draw the caret
	theLoc  = TEGetPoint( offset, theTE );
	theLine = TEGetLine( offset, theTE );

	//	For some reason, TextEdit dosen't return the proper coordinates
	//	of the last offset in the field if the last character in the record
	//	is a carriage return. TEGetPoint returns a point that is one line
	//	higher than expected. The following code fixes this problem.
	if ((offset == (**theTE).teLength) && (*((**theTE).hText))[(**theTE).teLength - 1] == 0x0D)
		theLoc.v += TEGetHeight( theLine, theLine, theTE );

	PenMode( patXor );									//	invert the caret when drawing
	lineHeight = TEGetHeight( theLine, theLine, theTE );	// get the height of the line that the offset points to

	MoveTo( theLoc.h - 1, theLoc.v - 1 );
	Line( 0, 1 - lineHeight );								// draw the appropriate caret image

	PenNormal( );
}


// *****************************************************************************
// *
// *	GetCharAtOffset( )
// *
// *****************************************************************************
char GetCharAtOffset( short offset, TEHandle theTE )
{
	if ( offset < 0 )
		return( 0x0D );
	return (((char *) *((**theTE).hText))[offset]);
}


// *****************************************************************************
// *
// *	WhiteSpace( )
// *
// *****************************************************************************
Boolean WhiteSpace( char theChar )
{
	return ((theChar == ' ') || (theChar == 0x0D));
}


// *****************************************************************************
// *
// *	WhiteSpaceAtOffset( )
// *
// *****************************************************************************
Boolean WhiteSpaceAtOffset( short offset, TEHandle theTE )
{	
	char theChar;

	if ((offset < 0) || (offset > (**theTE).teLength - 1))
		return true;

	theChar = ((char *) *((**theTE).hText))[offset];
	return ((theChar == ' ') || (theChar == 0x0D));
}


// *****************************************************************************
// *
// *	InsertTextAtOffset( )
// *
// *****************************************************************************
void InsertTextAtOffset( short offset, char* theBuf, long size, StScrpHandle theStyl, TEHandle theTE )
{
	if ( size == 0 )
		return;

	//	If inserting at the end of a word and the selection does not begin with
	//	a space, insert a space before the insertion.
	if (!WhiteSpaceAtOffset( offset - 1, theTE ) &&
		WhiteSpaceAtOffset( offset, theTE ) &&
		!WhiteSpace( theBuf[0] ))
	{
		TESetSelect( offset, offset, theTE );
		TEKey( ' ', theTE );
		offset++;
	}

	//	If inserting at the beginning of a word and the selection does not end
	//	with a space, insert a space after the insertion.
	if (WhiteSpaceAtOffset( offset - 1, theTE ) &&
		!WhiteSpaceAtOffset( offset, theTE ) &&
		!WhiteSpace( theBuf[size - 1] ))
	{
		TESetSelect( offset, offset, theTE );
		TEKey( ' ', theTE );
	}

	TESetSelect( offset, offset, theTE );
	TEStyleInsert( theBuf, size, theStyl, theTE );
	TESetSelect( offset, offset + size, theTE );
}


// *****************************************************************************
// *
// *	GetSelectionSize( )
// *
// *****************************************************************************
short GetSelectionSize( Document* theDocument )
{
	return((**(theDocument->theTE)).selEnd - (**(theDocument->theTE)).selStart);
}


// *****************************************************************************
// *
// *	GetSelectedTextPtr( )
// *
// *****************************************************************************
Ptr GetSelectedTextPtr( Document* theDocument )
{
	return((*(**(theDocument->theTE)).hText) + (**(theDocument->theTE)).selStart);
}


// *****************************************************************************
// *
// *	MySendDataProc( )
// *
// *	Will provide 'styl' data for the drag when requested.
// *
// *****************************************************************************
pascal OSErr MySendDataProc( FlavorType theType, void* refCon, ItemReference theItem, DragReference theDrag )
{	
	Document*		theDocument = (Document*)refCon;
	StScrpHandle	theStyl;

	if ( theType == kStylFlavorType ) 
	{
		theStyl = TEGetStyleScrapHandle( theDocument->theTE );

		// Call SetDragItemFlavorData to provide the requested data.
		HLock( (Handle)theStyl );
		SetDragItemFlavorData( theDrag, theItem, kStylFlavorType, (Ptr)*theStyl, GetHandleSize( (Handle)theStyl), 0L );
		HUnlock( (Handle)theStyl );
		DisposeHandle(( Handle)theStyl );
	} 
	else
		return badDragFlavorErr;

	return noErr;
}


// *****************************************************************************
// *
// *	MyReceiveDropHandler( )
// *
// *****************************************************************************
pascal OSErr MyReceiveDropHandler( WindowPtr theWindow, void* handlerRefCon, DragReference theDrag )
{	
	OSErr				result;
	TEHandle			tempTE;
	Rect				theRect, srcRect;
	unsigned short		items, index;
	ItemReference		theItem;
	DragAttributes		attributes;
	Ptr					textData;
	StScrpHandle		stylHandle;
	Size				textSize, stylSize;
	short				offset, selStart, selEnd, mouseDownModifiers, mouseUpModifiers, moveText;
	Document*			theDocument = (Document*)handlerRefCon;
	Point				thePoint;

	if ((!canAcceptItems) || (insertPosition == -1))
		return dragNotAcceptedErr;

	SetPort( (GrafPtr)GetWindowPort( theWindow ) );

	GetDragAttributes( theDrag, &attributes );
	GetDragModifiers( theDrag, 0L, &mouseDownModifiers, &mouseUpModifiers );

	moveText = (attributes & kDragInsideSenderWindow) &&
			   (!((mouseDownModifiers & optionKey) | (mouseUpModifiers & optionKey)));

	//	Loop through all of the drag items contained in this drag and collect the text
	//	into the tempTE record.
	
	SetRect( &theRect, 0, 0, 0, 0 );
	tempTE = TEStyleNew( &theRect, &theRect );

	CountDragItems( theDrag, &items );

	for ( index = 1; index <= items; index++ )
	{
		StScrpHandle styleH = NULL;
		
		GetDragItemReferenceNumber(theDrag, index, &theItem);

		//	get the flags for a 'TEXT' flavor. If this returns noErr,
		//	then we know that a 'TEXT' flavor exists in the item.

		result = GetFlavorDataSize( theDrag, theItem, kTextFlavorType, &textSize );

		if (result == noErr) 
		{
			textData = NewPtr( textSize );
			if ( textData == 0L )
			{
				TEDispose( tempTE );
				return memFullErr;
			}

			GetFlavorData( theDrag, theItem, kTextFlavorType, textData, &textSize, 0L );

			// check for optional styl data for the TEXT.
			result = GetFlavorDataSize( theDrag, theItem, kStylFlavorType, &stylSize );
			if ( result == noErr )
			{
				styleH = (StScrpHandle)NewHandle( stylSize );
				if ( styleH == 0L )
				{
					TEDispose( tempTE );
					DisposePtr( textData );
					return memFullErr;
				}

				HLock( (Handle)styleH );
				GetFlavorData( theDrag, theItem, kStylFlavorType, *styleH, &stylSize, 0L );
				HUnlock( (Handle)styleH );
			}

			// insert this drag item's text into the tempTE

			TESetSelect( 32767, 32767, tempTE );
			TEStyleInsert( textData, textSize, styleH, tempTE );

			DisposePtr( textData );
			if ( styleH )
				DisposeHandle( (Handle) styleH );
		}
	}

	// pull the TEXT and styl data out of the tempTE handle.

	textData = NewPtr( textSize = (**tempTE).teLength );
	if ( textData == 0L )
	{
		TEDispose( tempTE );
		return memFullErr;
	}
	BlockMove( *(**tempTE).hText, textData, textSize );

	TESetSelect( 0, 32767, tempTE );
	stylHandle = TEGetStyleScrapHandle( tempTE );

	TEDispose( tempTE );

	// if we actually received text, insert it into the destination

	if ( textSize != 0 )
	{
		// if the caret or highlighting is on the screen, remove it/them

		offset = caretOffset;

		if ( caretOffset != -1 )
		{
			DrawCaret( caretOffset, theDocument->theTE );
			caretOffset = -1;
		}

		if ( attributes & kDragHasLeftSenderWindow )
			HideDragHilite( theDrag );

		//	If the drag occurred completely within the same window and the window is not
		//	frontmost, bring the window forward and update its contents before completing
		//	the drag.

		if ((attributes & kDragInsideSenderWindow) && (theDocument->theWindow != FrontWindow( )))
		{
			SelectWindow( theDocument->theWindow );
			UpdateWindow( theDocument );
			TEActivate( theDocument->theTE );
		}

		// if the window is not active, must activate TE before inserting
		// text or the background hilite will not update correctly.

		if ( !IsWindowHilited( theDocument->theWindow ) )
			TEActivate( theDocument->theTE );

		// if this window is also the sender, delete source selection if no option key.
		if ( moveText )
		{
			RgnHandle tempRgn;
			
			selStart = (**(theDocument->theTE)).selStart;
			selEnd   = (**(theDocument->theTE)).selEnd;
			if ( WhiteSpaceAtOffset(selStart - 1, theDocument->theTE) &&
				!WhiteSpaceAtOffset(selStart, theDocument->theTE) &&
				!WhiteSpaceAtOffset(selEnd - 1, theDocument->theTE) &&
				 WhiteSpaceAtOffset(selEnd, theDocument->theTE))
			{
				if (GetCharAtOffset(selEnd, theDocument->theTE) == ' ')
					(**(theDocument->theTE)).selEnd++;
			}
			if (insertPosition > selStart)
			{
				insertPosition -= ((**(theDocument->theTE)).selEnd -
								   (**(theDocument->theTE)).selStart);
			}
			tempRgn = theDocument->hiliteRgn;
			GetRegionBounds( tempRgn, &srcRect );
						
			TEDelete( theDocument->theTE );
		}

		InsertTextAtOffset( insertPosition, textData, textSize, stylHandle, theDocument->theTE );

		TEGetHiliteRgn( theDocument->hiliteRgn, theDocument->theTE );

		//	If the text is moving (not copying) within the same window, provide a ZoomRects
		//	from the source to the destination before revealing the reflowed text.

		if ( moveText )
		{
			RgnHandle tempRgn = theDocument->hiliteRgn;
			GetRegionBounds( tempRgn, &theRect );
			thePoint.h = thePoint.v = 0;
			
			SetPort( (GrafPtr)GetWindowPort( theWindow ) );

			LocalToGlobal( &thePoint );
			OffsetRect( &srcRect, thePoint.h, thePoint.v );
			OffsetRect( &theRect, thePoint.h, thePoint.v );
			ZoomRects( &srcRect, &theRect, 12, kZoomDecelerate );
		}
		theDocument->dirty = true;
	}

	DisposePtr( textData );

	// undo the TEActivate, if needed:
	if ( !IsWindowHilited( theDocument->theWindow ) )
		TEDeactivate( theDocument->theTE );

	return noErr;
}


// *****************************************************************************
// *
// *	MyTrackingHandler( )
// *
// *	This is the drag tracking handler for windows in the application.
// *
// *****************************************************************************
pascal OSErr MyTrackingHandler( short message, WindowPtr theWindow, void* handlerRefCon, DragReference theDrag )
{
#pragma unused( theWindow )

    short				result, offset;
	long				theTime = TickCount();
	unsigned short		count, index;
	unsigned long		flavorFlags, attributes;
	ItemReference		theItem;
	RgnHandle			theRgn;
	Document*			theDocument = (Document*)handlerRefCon;
	Document*			hitDoc;
	Point				theMouse, localMouse;

	if ( (message != kDragTrackingEnterHandler) && !canAcceptItems )
		return noErr;

	GetDragAttributes( theDrag, &attributes );

	switch( message )
	{
		case kDragTrackingEnterHandler:

			//	We get called with this message the first time that a drag enters ANY
			//	window in our application. Check to see if all of the drag items contain
			//	TEXT. We only accept a drag if all of the items in the drag can be accepted.
			
			canAcceptItems = true;

			CountDragItems( theDrag, &count );

			for ( index = 1; index <= count; index++ )
			{
				GetDragItemReferenceNumber( theDrag, index, &theItem );

				result = GetFlavorFlags( theDrag, theItem, kTextFlavorType, &flavorFlags );

				if (result != noErr)
				{
					canAcceptItems = false;
					break;
				}
			}
			break;

		case kDragTrackingEnterWindow:
		{
			//	We receive an EnterWindow message each time a drag enters one of our
			//	application's windows. We initialize our global variables for tracking
			//	the drag through the window.

			caretTime = theTime;
			caretOffset = lastOffset = -1;
			caretShow = true;

			cursorInContent = false;

			break;
		}
		
		case kDragTrackingInWindow:
		{
			//	We receive InWindow messages as long as the mouse is in one of our windows
			//	during a drag. We draw the window highlighting and blink the insertion caret
			//	when we get these messages.

			GetDragMouse( theDrag, &theMouse, 0L );
			localMouse = theMouse;
			GlobalToLocal( &localMouse );

			//	Show or hide the window highlighting when the mouse enters or leaves the
			//	TextEdit field in our window (we don't want to show the highlighting when
			//	the mouse is over the window title bar or over the scroll bars).

			if ( attributes & kDragHasLeftSenderWindow ) 
			{
				if ( PtInRect(localMouse, &(**(theDocument->theTE)).viewRect) )
				{
					if ( !cursorInContent )
					{
						RectRgn( theRgn = NewRgn( ), &(**(theDocument->theTE)).viewRect );
						ShowDragHilite( theDrag, theRgn, true );
						DisposeRgn( theRgn );
					}
					cursorInContent = true;
				}
				else
				{
					if ( cursorInContent )
						HideDragHilite( theDrag );
					cursorInContent = false;
				}
			}

			offset = HitTest( theMouse, &hitDoc );

			//	If this application is the sender, do not allow tracking through
			//	the selection in the window that sourced the drag.

			if ( attributes & kDragInsideSenderWindow )
			{
				if ((offset >= (**(theDocument->theTE)).selStart) &&
					(offset <= (**(theDocument->theTE)).selEnd))
						offset = -1;
			}

			if ( hitDoc == theDocument )
			{
				insertPosition = offset;

				//	Reset flashing counter if the offset has moved. This makes the
				//	caret blink only after the caret has stopped moving long enough.

				if ( offset != lastOffset )
				{
					caretTime = theTime;
					caretShow = true;
				}
				lastOffset = offset;

				// flash caret

#if TARGET_API_MAC_CARBON 
				if ( theTime - caretTime > (**(theDocument->theTE)).caretTime )
#else
				if ( theTime - caretTime > gCaretTime )
#endif
				{
					caretShow = !caretShow;
					caretTime = theTime;
				}
				if ( !caretShow )
					offset = -1;

				// if caret offset has changed, move caret on screen

				if ( offset != caretOffset )
				{
					if ( caretOffset != -1 )
					{
						DrawCaret( caretOffset, theDocument->theTE );
					}
					if ( offset != -1 )
					{
						DrawCaret( offset, theDocument->theTE );
					}
				}

				caretOffset = offset;
			}
			else 
			{
				lastOffset = offset;
				insertPosition = -1;
			}
			break;
		}
		
		case kDragTrackingLeaveWindow:
		{
			// if the caret is on the screen, remove it.

			if ( caretOffset != -1 )
			{
				DrawCaret( caretOffset, theDocument->theTE );
				caretOffset = -1;
			}

			// remove window highlighting, if showing.

			if ( cursorInContent && (attributes & kDragHasLeftSenderWindow) )
				HideDragHilite( theDrag );
			break;
		}
		
		case kDragTrackingLeaveHandler:
			break;

	}
	return noErr;
}


// *****************************************************************************
// *
// *	DropLocationIsFinderTrash( )
// *
// *	Returns true if the given dropLocation AEDesc is a descriptor of the Finder's Trash.
// *
// *****************************************************************************
Boolean DropLocationIsFinderTrash( AEDesc* dropLocation )
{	
	OSErr	theErr = noErr;
	AEDesc	dropSpec;
	Boolean	result = false;

	//	Coerce the dropLocation descriptor to an FSSpec. If there's no dropLocation or
	//	it can't be coerced into an FSSpec, then it couldn't have been the Trash.
	//
	if ( (dropLocation->descriptorType != typeNull ) &&
		(AECoerceDesc( dropLocation, typeFSS, &dropSpec ) == noErr))
	{
		FSSpec		theSpec;
		CInfoPBRec	thePB;
		DescType 	type = typeFSS;
		ByteCount 	actualSize;
		
		myAEGetDescData( &dropSpec, &type, &theSpec, sizeof( FSSpec ), &actualSize );
		
		// get the directory ID of the given dropLocation object
		thePB.dirInfo.ioCompletion = NULL;
		thePB.dirInfo.ioNamePtr = (StringPtr)theSpec.name;
		thePB.dirInfo.ioVRefNum = theSpec.vRefNum;
		thePB.dirInfo.ioFDirIndex = 0;
		thePB.dirInfo.ioDrDirID = theSpec.parID;

		theErr = PBGetCatInfoSync( &thePB );

		AEDisposeDesc( &dropSpec );

		if ( theErr == noErr )
		{
			// if the result is not a directory, it must not be the Trash.
			if ((thePB.dirInfo.ioFlAttrib & (1 << 4)))
			{
				long trashDirID;
				short trashVRefNum;
				
				// get information about the Trash folder
				FindFolder( theSpec.vRefNum, kTrashFolderType, kCreateFolder, &trashVRefNum, &trashDirID );

				//	if the directory ID of the dropLocation object is the same as the directory ID
				//	returned by FindFolder, then the drop must have occurred into the Trash.

				if ( thePB.dirInfo.ioDrDirID == trashDirID )
					result = true;
			}
		}
	}
	return result;
}


// *****************************************************************************
// *
// *	DragTheText( )
// *
// *****************************************************************************
short DragTheText( Document* theDocument, EventRecord* theEvent, RgnHandle hiliteRgn )
{	
	OSErr				theErr = noErr;
	short				result;
	RgnHandle			dragRegion, tempRgn;
	Point				theLoc;
	DragReference		theDrag;
	StScrpHandle		theStyl;
	AEDesc				dropLocation;
	DragAttributes		attributes;
	short				mouseDownModifiers, mouseUpModifiers, copyText;
	Rect				dragBounds;

	// copy the hilite region into dragRegion and offset it into global coordinates.
	CopyRgn( hiliteRgn, dragRegion = NewRgn( ) );
	SetPt( &theLoc, 0, 0 );
	LocalToGlobal( &theLoc );
	OffsetRgn( dragRegion, theLoc.h, theLoc.v );

	if ( !WaitMouseMoved( theEvent->where ) )
		return false;
		
	NewDrag( &theDrag );

	AddDragItemFlavor( theDrag, 1, kTextFlavorType, GetSelectedTextPtr( theDocument ), GetSelectionSize( theDocument ), 0 );

	theStyl = TEGetStyleScrapHandle( theDocument->theTE );
	HLock( (Handle)theStyl );
	AddDragItemFlavor( theDrag, 1, kStylFlavorType, (Ptr)*theStyl, GetHandleSize( (Handle)theStyl ), 0 );
	HUnlock( (Handle)theStyl );
	DisposeHandle( (Handle)theStyl );

	sendHandler = NewDragSendDataUPP( &MySendDataProc );
	theErr = SetDragSendProc( theDrag, sendHandler, (void*)theDocument );
		
	GetRegionBounds( dragRegion, &dragBounds );
	SetDragItemBounds( theDrag, 1, &dragBounds );

	// prepare the drag region
	tempRgn = NewRgn( );
	CopyRgn( dragRegion, tempRgn );
	InsetRgn( tempRgn, 1, 1 );
	DiffRgn( dragRegion, tempRgn, dragRegion );
	DisposeRgn( tempRgn );

	result = TrackDrag( theDrag, theEvent, dragRegion );

	if ( result != noErr && result != userCanceledErr )
		return true;

	// check to see if the drop occurred in the Finder's Trash. If the drop occurred
	// in the Finder's Trash and a copy operation wasn't specified, delete the source selection

	GetDragAttributes(theDrag,&attributes);
	if (!(attributes & kDragInsideSenderApplication))
	{
		if (( theErr = GetDropLocation( theDrag, &dropLocation )) == noErr )
		{
			GetDragModifiers( theDrag, 0L, &mouseDownModifiers, &mouseUpModifiers );
			copyText = (mouseDownModifiers | mouseUpModifiers) & optionKey;

			if ( !copyText && (DropLocationIsFinderTrash( &dropLocation ) ))
			{
				TEDelete( theDocument->theTE );
				theDocument->dirty = true;
			}
			AEDisposeDesc( &dropLocation );
		}
	}

	DisposeDrag( theDrag );
	DisposeRgn( dragRegion );

	return true;
}
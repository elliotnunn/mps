/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple Application Framework
#
#	TDocument.cp
#
#	TDocument.cp	-	C++ source containing the implementations for a basic
#						document class as well as a implementation to maintain
#						a linked list of active documents.
#
#	Copyright © 1991 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	
#			1.20					10/91
#			1.10 					07/89
#			1.00 					04/89
#
#	Components:
#			TDocument.h				July 9, 1989
#			TDocument.cp			July 9, 1989
#
#
------------------------------------------------------------------------------*/

/*
Segmentation strategy:

    This program has only one segment, since the issues
    surrounding segmentation within a class's methods have
    not been investigated yet.
	
SetPort strategy:

    Toolbox routines do not change the current port. In
    spite of this, in this program we use a strategy of
    calling SetPort whenever we want to draw or make calls
    which depend on the current port. This makes us less
    vulnerable to bugs in other software which might alter
    the current port (such as the bug (feature?) in many
    desk accessories which change the port on OpenDeskAcc).
    Hopefully, this also makes the routines from this
    program more self-contained, since they don't depend on
    the current port setting. 

Clipboard strategy:

    This program does not maintain a private scrap.
    Whenever a cut, copy, or paste occurs, we import/export
    from the public scrap to TextEdit's scrap right away,
    using the TEToScrap and TEFromScrap routines. If we did
    use a private scrap, the import/export would be in the
    activate/deactivate event and suspend/resume event
    routines. 
*/

// Mac Includes
#include <Types.h>
#include <Quickdraw.h>
#include <Fonts.h>
#include <Events.h>
#include <Controls.h>
#include <Windows.h>
#include <Menus.h>
#include <TextEdit.h>
#include <Dialogs.h>
#include <Desk.h>
#include <Scrap.h>
#include <ToolUtils.h>
#include <Memory.h>
#include <SegLoad.h>
#include <Files.h>
#include <OSUtils.h>
#include <Traps.h>

#include "TDocument.h"		// use the local version. If you make changes
							// that you've debugged and want other files
							// to use, simple copy this header file into
							// the C++ Includes folder (don't forget to
							// copy the TDocument object library to the C++
							// Libraries folder)!



/***********************************************************************/
//
// TDocument class declarations
//
/***********************************************************************/

//-----------------------------------------------------------------------
// TDocument::TDocument - 	automatically open a new window for the document
//							using resID as the resource id for the window.
//							If you modify this so that it doesn't create a
//							window, be sure to take that into account in the
//							application class so that it doesn't believe an
//							error occurred (as version 1.20 of TApplication
//							would).
//
	TDocument::TDocument( short resID )
	{
		fDocWindow = GetNewWindow( resID, nil, (WindowPtr) -1 );
		SetPort( fDocWindow );
		
	} /* TDocument (constructor) */


//-----------------------------------------------------------------------
// TDocument::~TDocument -	we need to deallocate the storage that was used
//							to create the document's window before we lose
//							access to it.
//
	TDocument::~TDocument( void )
	{
		DisposeWindow( fDocWindow );
		
	} /* TDocument (destructor) */



/***********************************************************************/
//
// TDocumentLink class declarations
//
/***********************************************************************/

//-----------------------------------------------------------------------
// TDocumentLink::TDocumentLink -	simply initialize the linked list
//									using the passed parameters.
//
	TDocumentLink::TDocumentLink( TDocumentLink *n, TDocument *v )
	{
		fNext = n;
		fDoc = v;
		
	} /* TDocumentLink (constructor) */



/***********************************************************************/
//
// TDocumentList class declarations
//
/***********************************************************************/

//-----------------------------------------------------------------------
// TDocumentList::TDocumentList -	since this is a brand new list,
//									initialize the list to indicate that
//									there are no active documents.
//
	TDocumentList::TDocumentList( void )
	{
		fDocList = nil;
		fNumDocs = 0;
		
	} /* TDocumentList (constructor) */


//-----------------------------------------------------------------------
// TDocumentList::FindDoc -	given a pointer to a window, determine if the
//							window belongs to any document in the current
//							list of active documents. If it does, return
//							a pointer to that document; otherwise, return
//							nil.
//
	TDocument* TDocumentList::FindDoc( WindowPtr window )
	{
		TDocumentLink* temp;
		TDocument* tDoc;
	
		for ( temp = fDocList; temp != nil; temp = temp->GetNext())
		{
			tDoc = temp->GetDoc();
			if ( tDoc->GetDocWindow() == window )			// does the window belongs to the current document?
			  return tDoc;									// yes, let the calling routine know
		}
		return nil;											// sorry, none of the documents own that window
		
	} /* TDocumentList::FindDoc */


//-----------------------------------------------------------------------
// TDocumentList::AddDoc -	add the designated document to the linked list
//							of active documents. Also, be sure to update
//							the number of those active documents.
//
	void TDocumentList::AddDoc( TDocument* doc )
	{
		TDocumentLink* temp;
	
		temp = new TDocumentLink( fDocList, doc );
		fDocList = temp;
		fNumDocs++;
		
	} /* TDocumentList::AddDoc */


//-----------------------------------------------------------------------
// TDocumentList::RemoveDoc -	remove the designated document from the
//								linked list of active documents. Also, be
//								sure to update the number of those active
//								documents.
//
	void TDocumentList::RemoveDoc( TDocument* doc )
	{
		TDocumentLink* temp;
		TDocumentLink* last;
	
		last = nil;
		for ( temp = fDocList; temp != nil; temp = temp->GetNext())
			if ( temp->GetDoc() == doc )					// is the current document the one to be removed?
			{												// yes, remove it
				// if first item in list, just set first
					if ( last == nil )				
						fDocList = temp->GetNext();
					else
						last->SetNext( temp->GetNext());
				
				// free the TDocumentLink		
					delete temp;					
					fNumDocs--;
					
				// we're done; no need to continue onto the next document
					return;
			}
			else											// no, go onto the next document in the list
				last = temp;
				
	} /* TDocumentList::RemoveDoc */

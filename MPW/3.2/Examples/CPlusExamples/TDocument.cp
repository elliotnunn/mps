/*------------------------------------------------------------------------------
#
#	Apple Macintosh Developer Technical Support
#
#	MultiFinder-Aware Simple Application Framework
#
#	CPlusAppLib
#
#	TDocument.cp	-	C++ source
#
#	Copyright © 1989 Apple Computer, Inc.
#	All rights reserved.
#
#	Versions:	
#			1.10 					07/89
#			1.00 					04/89
#
#	Components:
#			TApplicationCommon.h	July 9, 1989
#			TApplication.h			July 9, 1989
#			TDocument.h				July 9, 1989
#			TApplication.cp			July 9, 1989
#			TDocument.cp			July 9, 1989
#			TApplication.r			July 9, 1989
#
#	CPlusAppLib is a rudimentary application framework
#	for C++. The applications CPlusShapesApp and CPlusTESample
#	are built using CPlusAppLib.
#
------------------------------------------------------------------------------*/

/*
Segmentation strategy:

    This program has only one segment, since the issues
    surrounding segmentation within a class's methods have
    not been investigated yet. We DO unload the data
    initialization segment at startup time, which frees up
    some memory 

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
#include <QuickDraw.h>
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

#include "TDocument.h"

TDocument::TDocument(short resID)
{
	fDocWindow = GetNewWindow(resID,nil,(WindowPtr) -1);
	SetPort(fDocWindow);
}

TDocument::~TDocument(void)
{
	DisposeWindow(fDocWindow);
}

TDocumentLink::TDocumentLink(TDocumentLink *n, TDocument *v)
{
	fNext = n;
	fDoc = v;
}

TDocumentList::TDocumentList(void)
{
	fDocList = nil;
	fNumDocs = 0;
}

// find the TDocument associated with the window
TDocument* TDocumentList::FindDoc(WindowPtr window)
{
	TDocumentLink* temp;
	TDocument* tDoc;

	for (temp = fDocList; temp != nil; temp = temp->GetNext())
	  {
		tDoc = temp->GetDoc();
		if (tDoc->GetDocWindow() == window)
		  return tDoc;
	  }
	return nil;
}

// private list management routines
void TDocumentList::AddDoc(TDocument* doc)
{
	TDocumentLink* temp;

	temp = new TDocumentLink(fDocList,doc);
	fDocList = temp;
	fNumDocs++;
}

void TDocumentList::RemoveDoc(TDocument* doc)
{
	TDocumentLink* temp;
	TDocumentLink* last;

	last = nil;
	for (temp = fDocList; temp != nil; temp = temp->GetNext())
	  if (temp->GetDoc() == doc)
	    {
		  if (last == nil)				// if first item in list, just set first
			fDocList = temp->GetNext();
		  else last->SetNext(temp->GetNext());
		  delete temp;					// free the TDocumentLink
		  fNumDocs--;
		  return;
		}
	  else last = temp;
}

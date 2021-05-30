/*
	File:		BaseWindow.cp

	Contains:	Base class for a window.

	Version:    CarbonLib 1.0.2 SDK

	You may incorporate this sample code into your applications without
	restriction, though the sample code has been provided "AS IS" and the
	responsibility for its operation is 100% yours.  However, what you are
	not permitted to do is to redistribute the source as "Apple Sample Code"
	after having made changes. If you're going to re-distribute the source,
	we require that you make it clear in the source that the code was
	descended from Apple Sample Code, but that you've made changes.

	© 1997-2000 by Apple Computer, Inc. All rights reserved.
*/

#ifdef __MRC__
#include <MacWindows.h>
#endif	// __MRC__
#include "BaseWindow.h"

BaseWindow::BaseWindow()
{
	fWindow = nil;
	fPort = nil;
}

BaseWindow::BaseWindow( SInt16 resID )
{
	fWindow = GetNewCWindow( resID, NULL, (WindowRef)-1L );
	fPort = GetWindowPort( fWindow );

	SetWindowKind( fWindow, 2000 );
	SetWRefCon( fWindow, (long)this );
}

void BaseWindow::DoDragClick(EventRecord *event)
{
    BitMap		bitMap;
    DragWindow( fWindow, event->where, &GetQDGlobalsScreenBits( &bitMap )->bounds );
}

BaseWindow::~BaseWindow()
{
	MenuHandle theMenu;
	
	if ( fWindow ) DisposeWindow( fWindow );

	theMenu = GetMyMenu();
	
	if (theMenu)
	{
 		DeleteMenu( GetMenuID( theMenu ) );
 		DrawMenuBar();
	}
}

void
BaseWindow::Idle()
{
}

void
BaseWindow::AdjustMenus()
{
}

void
BaseWindow::HandleMenuSelection( SInt16 menuID, SInt16 itemNo )
{
#pragma unused( menuID, itemNo )
}

void
BaseWindow::Activate( EventRecord& )
{
	MenuHandle theMenu = GetMyMenu();
	
	if ( theMenu )
	{
		InsertMenu( theMenu, 0 );
		DrawMenuBar();
	}
}

void
BaseWindow::Deactivate( EventRecord& )
{
	MenuHandle theMenu = GetMyMenu();

	if ( theMenu )
	{
		DeleteMenu( GetMenuID( theMenu ) );
		InvalMenuBar();
	}
}

void
BaseWindow::Update( EventRecord& )
{
	BeginUpdate( fWindow );
	Draw();
	EndUpdate( fWindow );
}

void
BaseWindow::Draw()
{
}

void
BaseWindow::HandleKeyDown( EventRecord& )
{
}

void
BaseWindow::Resize( SInt16 width, SInt16 height )
{
	SizeWindow( fWindow, width, height, true );
}

void
BaseWindow::HandleClick( EventRecord& event )
{
#pragma unused( event )
}

MenuHandle BaseWindow::GetMyMenu(void)
{
	return(nil);  // if someone hasn't overridden this, they don't have a menu to get!
}


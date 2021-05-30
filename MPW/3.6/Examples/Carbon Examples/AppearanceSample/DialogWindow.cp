/*
	File:		DialogWindow.cp

	Contains:	Dialog example using Appearance Manager primitives.

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

/*#include <Appearance.h>
#include <MacWindows.h>*/
#include "DialogWindow.h"

DialogWindow::DialogWindow() : BaseWindow( 129 )
{
	::SetThemeWindowBackground( fWindow, kThemeActiveDialogBackgroundBrush, true );
}

DialogWindow::~DialogWindow()
{
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä Activate
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Activate our window by drawing all of our items in the active state.
//
void
DialogWindow::Activate( EventRecord& )
{
	Rect			editTextRect = { 9, 9, 27, 101 };
	Rect			portRect;

	::SetPort( fPort );
	GetPortBounds( fPort, &portRect );
	::DrawThemeModelessDialogFrame( &portRect, kThemeStateActive );
	DrawFakeEditText( kThemeStateActive );
	DrawFakeListBox( kThemeStateActive );
	DrawGroups( kThemeStateActive );
	DrawSeparators( kThemeStateActive );
	::DrawThemeFocusRect( &editTextRect, true );
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä Deactivate
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Deactivate our window by drawing all of our items in the inactive state.
//
void
DialogWindow::Deactivate( EventRecord& )
{
	Rect		portRect;
	Rect		editTextRect = { 9, 9, 27, 101 };
	
	::SetPort( fPort );
	::GetPortBounds( fPort, &portRect );
	::DrawThemeModelessDialogFrame( &portRect, kThemeStateDisabled );
	DrawFakeEditText( kThemeStateDisabled );
	DrawFakeListBox( kThemeStateDisabled );
	DrawGroups( kThemeStateDisabled );
	DrawSeparators( kThemeStateDisabled );
	::DrawThemeFocusRect( &editTextRect, false );
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä Draw
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Draws our dialog frame, edit text, list box, group box frames, as well as visual
//	separators.
//
void
DialogWindow::Draw()
{
	ThemeDrawState		state;
	Rect				portRect;

	::SetPort( fPort );

	state = IsWindowHilited( fWindow ) ?
				(ThemeDrawState)kThemeStateActive :
				(ThemeDrawState)kThemeStateDisabled;

	::GetPortBounds( fPort, &portRect );
	::DrawThemeModelessDialogFrame( &portRect, state );

	DrawFakeEditText( state );
	DrawFakeListBox( state );
	DrawGroups( state );
	DrawSeparators( state );
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä DrawFakeEditText
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Draws a mock-up of an edit text box. Note that the edit text frame can actually
//	be drawn outside of the rectangle given. You essentially pass it the content
//	rectangle and it figures out where the frame and bevel should be.
//
void
DialogWindow::DrawFakeEditText( ThemeDrawState drawState )
{
	Rect				editTextRect = { 10, 10, 26, 100 };
	ThemeDrawingState  	state;
	
	::SetPort( fPort );
	
	::GetThemeDrawingState( &state );
	::NormalizeThemeDrawingState();
	
	::EraseRect( &editTextRect );
	::DrawThemeEditTextFrame( &editTextRect, drawState );
	
	::InsetRect( &editTextRect, -1, -1 );
	::DrawThemeFocusRect( &editTextRect, IsWindowHilited( fWindow ) );

	::SetThemeDrawingState( state, true );
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä DrawFakeListBox
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Draws a mock-up of an list box. Note that the list frame can actually
//	be drawn outside of the rectangle given. You essentially pass it the content
//	rectangle and it figures out where the frame and bevel should be.
//
void
DialogWindow::DrawFakeListBox( ThemeDrawState drawState )
{
	Rect				editTextRect = { 36, 10, 100, 100 };
	ThemeDrawingState  	state;
	
	::SetPort( fPort );
	
	::GetThemeDrawingState( &state );
	::NormalizeThemeDrawingState();
	
	::EraseRect( &editTextRect );
	::DrawThemeListBoxFrame( &editTextRect, drawState );
	::SetThemeDrawingState( state, true );
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä DrawGroups
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Draws a primary and secondary group box.
//
void
DialogWindow::DrawGroups( ThemeDrawState drawState )
{
	Rect		primaryRect = { 10, 110, 110, 210 };
	Rect		secondaryRect = { 20, 120, 100, 200 };
	
	::DrawThemePrimaryGroup( &primaryRect, drawState );
	::DrawThemeSecondaryGroup( &secondaryRect, drawState );
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä DrawSeparators
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Simple visual separators
//
void
DialogWindow::DrawSeparators( ThemeDrawState drawState )
{
	Rect		vertRect = { 120, 110, 125, 210 };
	Rect		horizRect = { 10, 220, 110, 225 };
	
	::DrawThemeSeparator( &vertRect, drawState );
	::DrawThemeSeparator( &horizRect, drawState );
}


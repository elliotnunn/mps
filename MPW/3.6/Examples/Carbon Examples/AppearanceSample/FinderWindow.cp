/*
	File:		FinderWindow.cp

	Contains:	Finder window simulating using the Appearance Manager.

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

//
//	This module demonstrates an Appearance adoption example for a Finder-like window.
//	It uses actual Appearance Manager primitives to draw some of the window elements,
//	such as the window header and placard. Normally, it would be best to use the
//	window header and placard controls, since they take care of enabling and disabling
//	themselves. This, however, is a good example of how to use lower level routines
//	and still be theme savvy.
//
//	Although this window has scroll bars, it doesn't actually scroll anything. It's
//	more an example of getting the visual appearance together.
//

#ifdef __MRC__
#include <Appearance.h>
#include <ControlDefinitions.h>
#include <MacWindows.h>
#endif	// __MRC__
#include "FinderWindow.h"
#include "Assertions.h"

#define width( r )		( (r).right - (r).left )
#define height( r )		( (r).bottom - (r).top )

FinderWindow::FinderWindow() : BaseWindow( 128 )
{				
	Rect		rect;
	
		// Note the use of the new defProc constants here.
		// This eliminates the need to go thru the mapping
		// CDEF for scroll bars, which would normally happen
		// after calling RegisterAppearanceClient.
		
	CalcVertScrollBarRect( rect );
	fVertScrollBar = NewControl( fWindow, &rect, "\p", true, 0, 0, 100, kControlScrollBarProc, 0 );
	
	CalcHorizScrollBarRect( rect );
	fHorizScrollBar = NewControl( fWindow, &rect, "\p", true, 0, 0, 100, kControlScrollBarProc, 0 );	
}

FinderWindow::~FinderWindow()
{
	if ( fVertScrollBar )
		DisposeControl( fVertScrollBar );
	
	if ( fHorizScrollBar )
		DisposeControl( fHorizScrollBar );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä Activate
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Activates the contents of the window.
//
void
FinderWindow::Activate( EventRecord& )
{
	Rect		rect;
	
	SetPort( fPort );
	GetPortBounds( fPort, &rect );
	InsetRect( &rect, -1, -1 );
	rect.bottom = rect.top + 40;
	::DrawThemeWindowHeader( &rect, kThemeStateActive );
	ValidWindowRect( fWindow, &rect );
	
	DrawPlacard( kThemeStateActive, true );

		// Here we use the new ActivateControl call. We
		// could have still used HiliteControl, but this
		// is much more straightforward. It also works
		// right with and without embedding, so it's a
		// real good idea to start using it.
		
	ActivateControl( fHorizScrollBar );
	ActivateControl( fVertScrollBar );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä Deactivate
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Deactivates the contents of the window.
//
void
FinderWindow::Deactivate( EventRecord& )
{
	Rect		rect;
	
	SetPort( fPort );
	GetPortBounds( fPort, &rect );
	InsetRect( &rect, -1, -1 );
	rect.bottom = rect.top + 40;
	::DrawThemeWindowHeader( &rect, kThemeStateDisabled );
	ValidWindowRect( fWindow, &rect );
	
	DrawPlacard( kThemeStateDisabled, true );
	
		// Here we use the new DeactivateControl call. We
		// could have still used HiliteControl, but this
		// is much more straightforward. It also works
		// right with and without embedding, so it's a
		// real good idea to start using it.
		
	DeactivateControl( fHorizScrollBar );
	DeactivateControl( fVertScrollBar );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä Draw
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Draws our window. Appearance Manager calls handle multiple devices properly. We
//	need to call DeviceLoop to handle drawing our list view, though.
//
void
FinderWindow::Draw()
{
	Rect					rect;
	ThemeDrawState			drawState;
	RgnHandle				rgn;
	DeviceLoopDrawingUPP	proc;
	
        drawState = IsWindowHilited( fWindow ) ?
                        (ThemeDrawState)kThemeStateActive :
                        (ThemeDrawState)kThemeStateDisabled;

	rgn = NewRgn();
	
	if ( rgn )
	{
        ::SetPort( fPort );
        ::GetPortBounds( fPort, &rect );
        ::UpdateControls( fWindow, GetPortVisibleRegion( fPort, rgn ) );

        ::InsetRect( &rect, -1, -1 );
        rect.bottom = rect.top + 40;
        ::DrawThemeWindowHeader( &rect, drawState );

        GetContentRect( rect );

        RectRgn( rgn, &rect );

        proc = NewDeviceLoopDrawingUPP( DrawListView );
        DeviceLoop( rgn, proc, (long)this, 0 );
        DisposeDeviceLoopDrawingUPP( proc );

        DisposeRgn( rgn );
	}
	DrawPlacard( drawState, false );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä DrawListView
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Draws our list view columns, using the correct theme brushes.
//
pascal void
FinderWindow::DrawListView( SInt16 depth, SInt16 flags, GDHandle /*device*/, long userData )
{
	FinderWindow*		window = (FinderWindow*)userData;
	Rect				rect;
	ThemeDrawingState	state;
	SInt16				baseLine;
	
	window->GetContentRect( rect );
	
		// Because the brushes used by the Appearance Manager could
		// be colors or patterns, our GetColorAndPenState routine
		// always saves the current background pattern as well as the
		// fore and back colors.
		
	::GetThemeDrawingState( &state );

	::SetThemeBackground( kThemeListViewBackgroundBrush, depth, (flags & gdDevType) != 0 );
	::EraseRect( &rect );
	
	rect.left += 40;
	rect.right = rect.left + 120;
	
	::SetThemeBackground( kThemeListViewSortColumnBackgroundBrush, depth, (flags & gdDevType) != 0 );
	::EraseRect( &rect );

	::SetThemePen( kThemeListViewSeparatorBrush, depth, (flags & gdDevType) != 0 );

	window->GetContentRect( rect );
	
	for ( baseLine = rect.top; baseLine <= rect.bottom; baseLine += 15 )
	{
		::MoveTo( rect.left, baseLine );
		::LineTo( rect.right - 1, baseLine );
	}
	
	::SetThemeDrawingState( state, true );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä Resize
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Resize our window to the appropriate size specified in width and height. Make sure
//	the scroll bars are repositioned properly.
//
void
FinderWindow::Resize( SInt16 width, SInt16 height )
{
	Rect		horizRect, vertRect, bounds;
	
	GetPortBounds( fPort, &bounds );
	if ( width > width( bounds ) )
	{
		bounds.left = bounds.right - 5;
		bounds.bottom = 40;
		InvalWindowRect( fWindow, &bounds );
	}

	InvalidateScrollBars();
	InvalidatePlacard();
	
	BaseWindow::Resize( width, height );
	
	InvalidateScrollBars();
	InvalidatePlacard();
	
	CalcHorizScrollBarRect( horizRect );
	CalcVertScrollBarRect( vertRect );
	
	MoveControl( fHorizScrollBar, horizRect.left, horizRect.top );
	MoveControl( fVertScrollBar, vertRect.left, vertRect.top );
	SizeControl( fHorizScrollBar, width( horizRect ), height( horizRect ) );
	SizeControl( fVertScrollBar, width( vertRect ), height( vertRect ) );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä HandleClick
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Simple routine to handle scroll bar tracking, even though they don't do anything.
//
void
FinderWindow::HandleClick( EventRecord& event )
{
	ControlHandle		control;
	SInt16				part;
	Point				localPt;
	ControlActionUPP	actionProc;
	
	SetPort( fPort );
	localPt = event.where;
	GlobalToLocal( &localPt );
	
	part = FindControl( localPt, fWindow, &control );
	switch ( part )
	{
		case kControlUpButtonPart:
		case kControlDownButtonPart:
		case kControlPageUpPart:
		case kControlPageDownPart:
			actionProc = NewControlActionUPP( ScrollBarAction );
			TrackControl( control, localPt, actionProc );
			DisposeControlActionUPP( actionProc );
			break;
		
		case kControlIndicatorPart:
			TrackControl( control, localPt, (ControlActionUPP)-1L );
			break;
	}
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä GetContentRect
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Get our content rect, which is the area not including the scroll bars and the
//	window header. It is basically the list view area.
//
void
FinderWindow::GetContentRect( Rect& rect )
{
	GetPortBounds( fPort, &rect );
	
	rect.bottom -= 15;
	rect.right -= 15;
	rect.top += 39;
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä DrawPlacard
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Draws our placard next to the horizontal scroll bar.
//
void
FinderWindow::DrawPlacard( ThemeDrawState state, Boolean validate )
{
	Rect		rect;
	
	GetPortBounds( fPort, &rect );
	
	rect.bottom++;
	rect.left--;
	rect.top = rect.bottom - 16;
	rect.right = 121;
	
	::DrawThemePlacard( &rect, state );
	if ( validate )
		ValidWindowRect( fWindow, &rect );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä InvalidateScrollBars
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Invalidates the scroll bar areas.
//
void
FinderWindow::InvalidateScrollBars()
{
	Rect		tempRect;
	
	SetPort( fPort );
	CalcHorizScrollBarRect( tempRect );
	InvalWindowRect( fWindow, &tempRect );
	EraseRect( &tempRect );
	
	CalcVertScrollBarRect( tempRect );
	InvalWindowRect( fWindow, &tempRect );
	EraseRect( &tempRect );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä InvalidatePlacard
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Invalidates the placard area.
//
void
FinderWindow::InvalidatePlacard()
{
	Rect		rect;
	
	GetPortBounds( fPort, &rect );
	
	rect.bottom++;
	rect.top = rect.bottom - 16;
	rect.right = 121;
	rect.left--;

	InvalWindowRect( fWindow, &rect );
	EraseRect( &rect );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä CalcHorizScrollBarRect
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Calculates the position where the horizontal scroll bar should be placed.
//
void
FinderWindow::CalcHorizScrollBarRect( Rect& rect )
{
	GetPortBounds( fPort, &rect );
	rect.bottom++;
	rect.left = rect.left + 120;
	rect.top = rect.bottom - 16;
	rect.right -= 14;
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä CalcVertScrollBarRect
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Calculates the position where the vertical scroll bar should be placed.
//
void
FinderWindow::CalcVertScrollBarRect( Rect& rect )
{
	GetPortBounds( fPort, &rect );
	rect.right++;
	rect.left = rect.right - 16;
	rect.bottom -= 14;
	rect.top = 38;
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä ScrollBarAction
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	A simple callback to give some feedback when clicking the scroll arrows or page
//	up/down areas.
//
pascal void
FinderWindow::ScrollBarAction( ControlHandle control, SInt16 part )
{
	switch ( part )
	{
		case kControlUpButtonPart:
			if ( GetControlValue( control) > GetControlMinimum( control ) )
				SetControlValue( control, GetControlValue( control ) - 1 );
			break;
		
		case kControlDownButtonPart:
			if ( GetControlValue( control) < GetControlMaximum( control ) )
				SetControlValue( control, GetControlValue( control ) + 1 );
			break;
			
		case kControlPageUpPart:
			if ( GetControlValue( control) > GetControlMinimum( control ) )
				SetControlValue( control, GetControlValue( control ) - 10 );
			break;
			
		case kControlPageDownPart:
			if ( GetControlValue( control) < GetControlMaximum( control ) )
				SetControlValue( control, GetControlValue( control ) + 10 );
			break;
	}			
}


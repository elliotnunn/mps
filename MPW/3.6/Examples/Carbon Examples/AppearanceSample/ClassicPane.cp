/*
	File:		ClassicPane.cp

	Contains:	Class to drive our classic pane, showing new versions of old favorites.

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

//#include <Appearance.h>
#include "ClassicPane.h"
#include "AppearanceHelpers.h"
#include "UDialogUtils.h"

#define MIN( a, b )		( ( (a) < (b) ) ? (a) : (b) )
#define MAX( a, b )		( ( (a) > (b) ) ? (a) : (b) )

enum
{
	kEngageButton		 	= 1,
	kMakeItSoButton			= 2,
	kEjectCoreButton		= 3,
	kRaiseShieldsButton		= 4,
	kUserItem				= 6,
	kVerticalScrollBar		= 7,
	kHorizontalScrollBar	= 8,
	kTuneUpCheckBox 		= 9,
	kConstrictorsCheckBox	= 10,
	kIntermixCheckBox		= 11,
	kRadioGroup				= 12,
	kDessertRadio			= 13,
	kFloorWaxRadio			= 14,
	kBothButton				= 15
};

enum
{
	kConstrictorsMask		= 1,
	kIntermixMask			= 2,
	kAllCheckMask			= 3
};

ControlActionUPP	ClassicPane::fScrollBarProc = NewControlActionUPP( ClassicPane::ScrollingFeedbackProc );
ControlUserPaneDrawUPP	ClassicPane::fDrawProc = NewControlUserPaneDrawUPP( ClassicPane::DrawPictureProc );

ClassicPane::ClassicPane( DialogPtr dialog, SInt16 items ) : MegaPane( dialog, items )
{
	ControlHandle		control;
	Rect				bounds;

	AppendDialogItemList( dialog, 6003, overlayDITL );

	GetDialogItemAsControl( dialog, kTuneUpCheckBox + items, &control );
	SetControlMaximum( control, 2 );

	GetDialogItemAsControl( dialog, kMakeItSoButton + items, &control );
	SetPushButtonDefaultState( control, true );
	
	GetDialogItemAsControl( dialog, kEjectCoreButton + items, &control );
	DeactivateControl( control );

	GetDialogItemAsControl( dialog, items + kHorizontalScrollBar, &fHorizontalScrollBar );
	GetDialogItemAsControl( dialog, items + kVerticalScrollBar, &fVerticalScrollBar );
	
	SetControlReference( fHorizontalScrollBar, (long)this );
	SetControlReference( fVerticalScrollBar, (long)this );
	
	fPictOffset.h = 0;
	fPictOffset.v = 0;
	
	fPicture = GetPicture( 6003 );
	fPictWidth = (**fPicture).picFrame.right - (**fPicture).picFrame.left;
	fPictHeight = (**fPicture).picFrame.bottom - (**fPicture).picFrame.top;
	
	GetDialogItemAsControl( dialog, items + kUserItem, &fUserItem );
	SetControlReference( fUserItem, (long)this );
	SetControlData( fUserItem, 0, kControlUserPaneDrawProcTag, sizeof( fDrawProc ), (Ptr)&fDrawProc );

	GetControlBounds( fUserItem, &bounds );
	fUserItemHeight = bounds.bottom - bounds.top;
	fUserItemWidth = bounds.right - bounds.left;
	
	SetControlMaximum( fHorizontalScrollBar, fPictWidth - fUserItemWidth );
	SetControlMaximum( fVerticalScrollBar, fPictHeight - fUserItemHeight );
	
	SetControlAction( fHorizontalScrollBar, fScrollBarProc );
	SetControlAction( fVerticalScrollBar, fScrollBarProc );
	
	GetDialogItemAsControl( dialog, fOrigItems + kDessertRadio, &control );
	SetControlMaximum( control, kControlCheckBoxMixedValue );
	GetDialogItemAsControl( dialog, fOrigItems + kFloorWaxRadio, &control );
	SetControlMaximum( control, kControlCheckBoxMixedValue );
}

ClassicPane::~ClassicPane()
{
	ShortenDITL( fDialog, CountDITL( fDialog ) - fOrigItems );
}

void
ClassicPane::ItemHit( SInt16 item )
{
	SInt16			localItem;
	ControlHandle	control;
	SInt16			value;
	Boolean			syncCheck = false;
	SInt16			checkValues = 0;
	
	localItem = item - fOrigItems;
	
	switch ( localItem )
	{
		case kTuneUpCheckBox:
			GetDialogItemAsControl( fDialog, item, &control );
			value = GetControlValue( control );
			
			if ( value == kControlCheckBoxUncheckedValue )
			{
				SetControlValue( control, kControlCheckBoxCheckedValue );
				GetDialogItemAsControl( fDialog, fOrigItems + kConstrictorsCheckBox, &control );
				SetControlValue( control, kControlCheckBoxCheckedValue );
				GetDialogItemAsControl( fDialog, fOrigItems + kIntermixCheckBox, &control );
				SetControlValue( control, kControlCheckBoxCheckedValue );
			}
			else if ( value == kControlCheckBoxCheckedValue )
			{
				SetControlValue( control, kControlCheckBoxUncheckedValue );
				GetDialogItemAsControl( fDialog, fOrigItems + kConstrictorsCheckBox, &control );
				SetControlValue( control, kControlCheckBoxUncheckedValue );
				GetDialogItemAsControl( fDialog, fOrigItems + kIntermixCheckBox, &control );
				SetControlValue( control, kControlCheckBoxUncheckedValue );
			}
			else if ( value == kControlCheckBoxMixedValue )
			{
				SetControlValue( control, kControlCheckBoxCheckedValue );
				GetDialogItemAsControl( fDialog, fOrigItems + kConstrictorsCheckBox, &control );
				SetControlValue( control, kControlCheckBoxCheckedValue );
				GetDialogItemAsControl( fDialog, fOrigItems + kIntermixCheckBox, &control );
				SetControlValue( control, kControlCheckBoxCheckedValue );
			}
			break;
			
		case kConstrictorsCheckBox:
		case kIntermixCheckBox:
			UDialogUtils::ToggleCheckBox( fDialog, item );
			GetDialogItemAsControl( fDialog, fOrigItems + kConstrictorsCheckBox, &control );

			if ( GetControlValue( control ) )
				checkValues |= kConstrictorsMask;
			else
				checkValues &= ~kConstrictorsMask;
			
			GetDialogItemAsControl( fDialog, fOrigItems + kIntermixCheckBox, &control );

			if ( GetControlValue( control ) )
				checkValues |= kIntermixMask;
			else
				checkValues &= ~kIntermixMask;
			
			syncCheck = true;
			break;
		
		case kBothButton:
			GetDialogItemAsControl( fDialog, fOrigItems + kDessertRadio, &control );
			SetControlValue( control, kControlCheckBoxMixedValue );
			GetDialogItemAsControl( fDialog, fOrigItems + kFloorWaxRadio, &control );
			SetControlValue( control, kControlCheckBoxMixedValue );
			break;
	}
	
	if ( syncCheck )
	{
		GetDialogItemAsControl( fDialog, fOrigItems + kTuneUpCheckBox, &control );

		if ( checkValues == 0 )
			SetControlValue( control, kControlCheckBoxUncheckedValue );
		else if ( checkValues == kAllCheckMask )
			SetControlValue( control, kControlCheckBoxCheckedValue );
		else
			SetControlValue( control, kControlCheckBoxMixedValue );
	}
}

pascal void
ClassicPane::DrawPictureProc( ControlHandle control, SInt16 part )
{
	#pragma unused( part )
	
	Rect			bounds;
	RgnHandle		saveClip;
	ClassicPane*	pane;
	
	pane = (ClassicPane*)GetControlReference( control );
	GetControlBounds( control, &bounds );
	
	FrameRect( &bounds );
	InsetRect( &bounds, 1, 1 );
	
	saveClip = NewRgn();
	GetClip( saveClip );
	
	ClipRect( &bounds );

	bounds.top -= pane->fPictOffset.v;
	bounds.left -= pane->fPictOffset.h;
	bounds.bottom = bounds.top + pane->fPictHeight;
	bounds.right = bounds.left + pane->fPictWidth;
	
	DrawPicture( pane->fPicture, &bounds );
	
	SetClip( saveClip );
	DisposeRgn( saveClip );
}

pascal void
ClassicPane::ScrollingFeedbackProc( ControlHandle control, SInt16 part )
{
	SInt16			startValue, delta, min, max;
	ClassicPane*	pane;
	
	pane = (ClassicPane*)GetControlReference( control );

	startValue = GetControlValue( control );
	min = GetControlMinimum( control );
	max = GetControlMaximum( control );
	
	delta = 0;
	
	switch ( part )
	{
		case kControlUpButtonPart:
			if ( startValue > min )
				delta = MAX( -5, min - startValue );
			break;
		
		case kControlDownButtonPart:
			if ( startValue < max )
				delta = MIN( 5, max - startValue );
			break;
		
		case kControlPageUpPart:
			if ( startValue > min )
				if ( control == pane->fHorizontalScrollBar )
					delta = MAX( -(pane->fUserItemWidth - 1), min - startValue );
				else
					delta = MAX( -(pane->fUserItemHeight - 1), min - startValue );
			break;
		
		case kControlPageDownPart:
			if ( startValue < max )
				if ( control == pane->fHorizontalScrollBar )
					delta = MIN( pane->fUserItemWidth - 1, max - startValue );
				else
					delta = MAX( -(pane->fUserItemHeight - 1), max - startValue );
			break;
	}

	if ( delta )
	{
		SetControlValue( control, startValue + delta );
		if ( control == pane->fHorizontalScrollBar )
			pane->fPictOffset.h += delta;
		if ( control == pane->fVerticalScrollBar )
			pane->fPictOffset.v += delta;
		
			// pretty inefficient scrolling here, but you get the point.
			
		DrawOneControl( pane->fUserItem );
	}
	else if ( part == kControlIndicatorPart )
	{
		if ( control == pane->fHorizontalScrollBar )
			pane->fPictOffset.h = startValue - min;
			
		if ( control == pane->fVerticalScrollBar )
			pane->fPictOffset.v = startValue - min;

		DrawOneControl( pane->fUserItem );
	}
}

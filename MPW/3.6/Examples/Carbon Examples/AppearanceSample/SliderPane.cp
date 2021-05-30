/*
	File:		SliderPane.cp

	Contains:	Class to drive our example slider pane.

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
#include <TextUtils.h>*/
#include "SliderPane.h"
#include "UDialogUtils.h"
#include "AppearanceHelpers.h"
#include "Offscreen.h"

enum
{
	kHorizontalSlider1		= 1,
	kHorizontalSlider2		= 2,
	kHorizontalSlider3		= 3,
	kVerticalSlider1		= 4,
	kVerticalSlider2		= 5,
	kVerticalSlider3		= 6,
	kLiveFeedbackCheckBox	= 7,
	kStaticText				= 8,
	kUserPane				= 9
};

#define MIN( a, b )		( ( (a) < (b) ) ? (a) : (b) )
#define MAX( a, b )		( ( (a) > (b) ) ? (a) : (b) )

ControlActionUPP	SliderPane::fSliderProc = NewControlActionUPP( SliderPane::SliderFeedbackProc );
ControlUserPaneDrawUPP	SliderPane::fDrawProc = NewControlUserPaneDrawUPP( SliderPane::DrawPictureProc );

SliderPane::SliderPane( DialogPtr dialog, SInt16 items ) : MegaPane( dialog, items )
{
	AppendDialogItemList( dialog, 6002, overlayDITL );
	
	GetDialogItemAsControl( dialog, items + kHorizontalSlider1, &fHorizontalSlider1 );
	GetDialogItemAsControl( dialog, items + kHorizontalSlider2, &fHorizontalSlider2 );
	GetDialogItemAsControl( dialog, items + kHorizontalSlider3, &fHorizontalSlider3 );
	GetDialogItemAsControl( dialog, items + kVerticalSlider1, &fVerticalSlider1 );
	GetDialogItemAsControl( dialog, items + kVerticalSlider2, &fVerticalSlider2 );
	GetDialogItemAsControl( dialog, items + kVerticalSlider3, &fVerticalSlider3 );
	
	SetControlReference( fHorizontalSlider1, (long)this );
	SetControlReference( fHorizontalSlider2, (long)this );
	SetControlReference( fHorizontalSlider3, (long)this );
	SetControlReference( fVerticalSlider1, (long)this );
	SetControlReference( fVerticalSlider2, (long)this );
	SetControlReference( fVerticalSlider3, (long)this );
	
	GetDialogItemAsControl( dialog, items + kUserPane, &fUserPane );
	SetControlReference( fUserPane, (long)this );
	SetControlData( fUserPane, 0, kControlUserPaneDrawProcTag, sizeof( fDrawProc ), (Ptr)&fDrawProc );

	fPicture = GetPicture( 6002 );
	if (fPicture == nil)
	{
		fPictWidth = 127;
		fPictHeight = 95;
	}
	else
	{
		fPictWidth = (**fPicture).picFrame.right - (**fPicture).picFrame.left;
		fPictHeight = (**fPicture).picFrame.bottom - (**fPicture).picFrame.top;
	}
}

SliderPane::~SliderPane()
{
	ShortenDITL( fDialog, CountDITL( fDialog ) - fOrigItems );
}

void
SliderPane::ItemHit( SInt16 item )
{
	SInt16			localItem;
	ControlHandle	control;
	
	localItem = item - fOrigItems;
	
	switch ( localItem )
	{
		case kHorizontalSlider1:
		case kHorizontalSlider2:
		case kHorizontalSlider3:
		case kVerticalSlider1:
		case kVerticalSlider2:
		case kVerticalSlider3:
			if ( UDialogUtils::GetItemValue( fDialog, fOrigItems + kLiveFeedbackCheckBox ) == 0 )
			{
				GetDialogItemAsControl( fDialog, item, &control );
				SliderFeedbackProc( control, kControlIndicatorPart );
			}
			break;
			
		case kLiveFeedbackCheckBox:
			UDialogUtils::ToggleCheckBox( fDialog, item );
			GetDialogItemAsControl( fDialog, item, &control );
			if ( GetControlValue( control ) == 0 )
			{
				SetControlAction( fHorizontalSlider1, nil );
				SetControlAction( fHorizontalSlider2, nil );
				SetControlAction( fHorizontalSlider3, nil );
				SetControlAction( fVerticalSlider1, nil );
				SetControlAction( fVerticalSlider2, nil );
				SetControlAction( fVerticalSlider3, nil );
			}
			else
			{
				SetControlAction( fHorizontalSlider1, fSliderProc );
				SetControlAction( fHorizontalSlider2, fSliderProc );
				SetControlAction( fHorizontalSlider3, fSliderProc );
				SetControlAction( fVerticalSlider1, fSliderProc );
				SetControlAction( fVerticalSlider2, fSliderProc );
				SetControlAction( fVerticalSlider3, fSliderProc );
			}
			break;
	}
}

pascal void
SliderPane::SliderFeedbackProc( ControlHandle control, SInt16 part )
{
	#pragma unused( part )
	
	ControlHandle		text;
	Str255				valueText;
	SliderPane*			pane;
	SInt16				startValue;

	startValue = GetControlValue( control );
	
	pane = (SliderPane*)GetControlReference( control );

	GetDialogItemAsControl( pane->fDialog, kStaticText + pane->fOrigItems, &text );
	NumToString( GetControlValue( control ), valueText );
	SetStaticTextText( text, valueText, true );

	if ( control == pane->fHorizontalSlider1 )
	{
		SetControlValue( pane->fHorizontalSlider2, startValue );
		SetControlValue( pane->fHorizontalSlider3, startValue );
		SetControlValue( pane->fVerticalSlider1, startValue );
		SetControlValue( pane->fVerticalSlider2, startValue );
		SetControlValue( pane->fVerticalSlider3, startValue );
	}
	else if ( control == pane->fHorizontalSlider2 )
	{
		SetControlValue( pane->fHorizontalSlider1, startValue );
		SetControlValue( pane->fHorizontalSlider3, startValue );
		SetControlValue( pane->fVerticalSlider1, startValue );
		SetControlValue( pane->fVerticalSlider2, startValue );
		SetControlValue( pane->fVerticalSlider3, startValue );
	}
	else if ( control == pane->fHorizontalSlider3 )
	{
		SetControlValue( pane->fHorizontalSlider1, startValue );
		SetControlValue( pane->fHorizontalSlider2, startValue );
		SetControlValue( pane->fVerticalSlider1, startValue );
		SetControlValue( pane->fVerticalSlider2, startValue );
		SetControlValue( pane->fVerticalSlider3, startValue );
	}
	else if ( control == pane->fVerticalSlider1 )
	{
		SetControlValue( pane->fHorizontalSlider1, startValue );
		SetControlValue( pane->fHorizontalSlider2, startValue );
		SetControlValue( pane->fHorizontalSlider3, startValue );
		SetControlValue( pane->fVerticalSlider2, startValue );
		SetControlValue( pane->fVerticalSlider3, startValue );
	}
	else if ( control == pane->fVerticalSlider2 )
	{
		SetControlValue( pane->fHorizontalSlider1, startValue );
		SetControlValue( pane->fHorizontalSlider2, startValue );
		SetControlValue( pane->fHorizontalSlider3, startValue );
		SetControlValue( pane->fVerticalSlider1, startValue );
		SetControlValue( pane->fVerticalSlider3, startValue );
	}
	else if ( control == pane->fVerticalSlider3 )
	{
		SetControlValue( pane->fHorizontalSlider1, startValue );
		SetControlValue( pane->fHorizontalSlider2, startValue );
		SetControlValue( pane->fHorizontalSlider3, startValue );
		SetControlValue( pane->fVerticalSlider1, startValue );
		SetControlValue( pane->fVerticalSlider2, startValue );
	}
	DrawPictureProc( pane->fUserPane, 0 );
}

pascal void
SliderPane::DrawPictureProc( ControlHandle control, SInt16 part )
{
	#pragma unused( part )
	
	Rect				bounds;
	RgnHandle			saveClip;
	SliderPane*			pane;
	CGrafPtr			currPort;
	GDHandle			currDevice;
	Rect				globalBounds;
	ThemeDrawingState	state;
	Offscreen			mainBuffer;
	Offscreen			pictBuffer;
	RGBColor			alphaColor;
	SInt16				value;
	SInt16				component;
	
	GetThemeDrawingState( &state );
	
	pane = (SliderPane*)GetControlReference( control );
	GetControlBounds( control, &bounds );

	FrameRect( &bounds );
	InsetRect( &bounds, 1, 1 );
	
	saveClip = NewRgn();
	GetClip( saveClip );
	
	ClipRect( &bounds );

	bounds.bottom = bounds.top + pane->fPictHeight;
	bounds.right = bounds.left + pane->fPictWidth;
	
	globalBounds = bounds;
	LocalToGlobal( &topLeft( globalBounds ) );
	LocalToGlobal( &botRight( globalBounds ) );
	
	GetGWorld( &currPort, &currDevice );

	value = GetControlValue( pane->fVerticalSlider1 );
	component = value << 8;
	component |= value;
	
	alphaColor.red = alphaColor.green = alphaColor.blue = component;

	mainBuffer.StartDrawing( bounds );
	pictBuffer.StartDrawing( bounds );
	
	DrawPicture( pane->fPicture, &bounds );
	
	pictBuffer.EndDrawingAndBlend( alphaColor );
	mainBuffer.EndDrawing();
	
	SetThemeDrawingState( state, true );
	
	SetClip( saveClip );
	DisposeRgn( saveClip );
}

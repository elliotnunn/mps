/*
	File:		LiveFeedbackDialog.cp

	Contains:	Demonstration of live feedback.

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
//	This file implements a dialog demonstrating live feedback with sliders
//	and scroll bars. In this case, we have one of each control. They are
//	connected to a text field showing the current value as well as each
//	other, i.e. moving one automatically adjusts the other.
//

//#include <TextUtils.h>
#include "LiveFeedbackDialog.h"
//#include <Appearance.h>
#include "AppearanceHelpers.h"

enum {
	kScrollBar			= 1,
	kSlider				= 2,
	kStaticText			= 4
};

ControlActionUPP	LiveFeedbackDialog::fProc = NewControlActionUPP( LiveFeedbackDialog::LiveActionProc );

LiveFeedbackDialog::LiveFeedbackDialog() : BaseDialog( 1004 )
{
	if ( fWindow )
	{
			// These controls have been created with a live scrolling
			// variant. We'll set the action proc using SetControlAction.
			
		GetDialogItemAsControl( fDialog, kScrollBar, &fScrollBar );
		SetControlReference( fScrollBar, (long)this );
		GetDialogItemAsControl( fDialog, kSlider, &fSlider );
		SetControlReference( fSlider, (long)this );

		SetControlAction( fScrollBar, fProc );
		SetControlAction( fSlider, fProc );
	}
}

LiveFeedbackDialog::~LiveFeedbackDialog()
{
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä LiveActionProc
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Here's our ControlActionUPP that also handles the indicator. At last, we can
//	actually use the same function callback for both! There is a difference when
//	called with the indicator as the part, as opposed to the up/down arrows, etc.
//	If we are called because the indicator is being dragged, the value has already
//	been calculated for us. If we are being called because the scroll bar arrows
//	have been pressed, then we must determine how much to scroll by and set the
//	scroll bar value accordingly. This allows us to have control over the amount
//	that arrows scroll by. We can allow the indicator dragging to determine the
//	value because the indicator always shows a percentage.
//
pascal void
LiveFeedbackDialog::LiveActionProc( ControlHandle control, SInt16 part )
{
	ControlHandle		text;
	Str255				valueText;
	LiveFeedbackDialog*	dialog;
	SInt16				startValue;
	SInt16				delta;
	
	startValue = GetControlValue( control );
	
	delta = 0;
	
	switch ( part )
	{
		case kControlUpButtonPart:
			if ( startValue > GetControlMinimum( control ) )
				delta = -1;
			break;
		
		case kControlDownButtonPart:
			if ( startValue < GetControlMaximum( control ) )
				delta = 1;
			break;
		
		case kControlPageUpPart:
			if ( startValue > GetControlMinimum( control ) )
				delta = -10;
			break;
		
		case kControlPageDownPart:
			if ( startValue < GetControlMaximum( control ) )
				delta = 10;
			break;
	}
	if ( delta )
		SetControlValue( control, startValue + delta );

	if ( part != kControlIndicatorPart && delta == 0 )
		return;

	dialog = (LiveFeedbackDialog*)GetControlReference( control );

	GetDialogItemAsControl( dialog->fDialog, kStaticText, &text );
	NumToString( GetControlValue( control ), valueText );
	SetStaticTextText( text, valueText, true );

	if ( control == dialog->fScrollBar )
		SetControlValue( dialog->fSlider, GetControlValue( control ) );
	else
		SetControlValue( dialog->fScrollBar, GetControlValue( control ) );
}

/*
	File:		MegaDialog.cp

	Contains:	Code to drive our MegaDialog example.

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
#include "MegaDialog.h"
#include "ProgressPane.h"
#include "SliderPane.h"
#include "ClassicPane.h"
#include "TextPane.h"
#include "LayoutPane.h"
#include "NewButtonPane.h"

enum
{
	kNoPane			= 0,
	kClassicPane	= 1,
	kSliderPane		= 2,
	kTextPane	 	= 3,
	kProgressPane	= 4,
	kLayoutPane		= 5,
	kNewPane		= 6
};

MegaDialog::MegaDialog() : BaseDialog( 6000 )
{
	fPane = nil;
	SwitchPane( kClassicPane );
}

MegaDialog::~MegaDialog()
{
	delete fPane;
}

void
MegaDialog::Idle()
{
	if ( fPane ) fPane->Idle();
}

void
MegaDialog::SwitchPane( SInt16 paneIndex )
{
	ControlHandle		control;

	if ( paneIndex == 0 ) return;

	delete fPane;
	fPane = nil;	
		
	GetDialogItemAsControl( fDialog, 1, &control );
	SetControlValue( control, paneIndex );

	switch ( paneIndex )
	{
		case kProgressPane:
			fPane = new ProgressPane( fDialog, CountDITL( fDialog ) );
			break;

		case kSliderPane:
			fPane = new SliderPane( fDialog, CountDITL( fDialog ) );
			break;

		case kClassicPane:
			fPane = new ClassicPane( fDialog, CountDITL( fDialog ) );
			break;

		case kTextPane:
			fPane = new TextPane( fDialog, CountDITL( fDialog ) );
			break;
		
		case kLayoutPane:
			fPane = new LayoutPane( fDialog, CountDITL( fDialog ) );
			break;
		
		case kNewPane:
			fPane = new NewButtonPane( fDialog, CountDITL( fDialog ) );
			break;
	}	
}

void
MegaDialog::HandleItemHit( SInt16 item )
{
	if ( item == 1 )
	{
		ControlHandle		control;
		
		GetDialogItemAsControl( fDialog, 1, &control );
		SwitchPane( GetControlValue( control ) );
	}
	else if ( fPane )
	{
		fPane->ItemHit( item );
	}
}
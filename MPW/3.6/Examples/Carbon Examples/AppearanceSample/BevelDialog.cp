/*
	File:		BevelDialog.cp

	Contains:	Bevel Button examples dialog.

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
//	This file implements a simple dialog which shows a myriad of bevel
//	button possibilities. Even with all it shows, it does not show all
//	the possible variations.
//

#ifdef __MRC__
#include <Appearance.h>
#include <Folders.h>
#include <Fonts.h>
#include <Controls.h>
#include <Icons.h>
#endif	// __MRC__
#include "BevelDialog.h"
#include "AppearanceHelpers.h"

void	HandleBevelDialog( DialogPtr dialog, short itemHit );

void	EnableDisableAll( DialogPtr dialog, Boolean enable );
void	SetControlValues( DialogPtr dialog, short value );
void	SetUpBevelDialog( DialogPtr dialog );


enum {
	kDisableButton		= 1,
	kEnableButton		= 2,
	kOnButton			= 3,
	kOffButton			= 4,
	kMixedButton		= 5,
	kFirstButton 		= 6,
	kLastButton 		= 32
};

BevelDialog::BevelDialog() : BaseDialog( 1001 )
{
	GrafPtr			savePort;
	ControlHandle	control;
	
	if ( fWindow )
	{
		GetPort( &savePort );
		SetPort( fPort );
		TextFont( applFont );
		TextSize( 10 );
		SetPort( savePort );


			// This next bit of code sets one of our bevel buttons up to
			// make the text always appear 0 pixels from the edge in an
			// internationalized fashion, i.e. in left-to-right scripts
			// it will be placed starting 0 pixels from the left.
			// In right-to-left scripts it will be 0 pixels in from the
			// right.
			
		GetDialogItemAsControl( fDialog, 18, &control );	
		SetBevelButtonTextAlignment( control, kControlBevelButtonAlignTextFlushLeft, 0 );
		GetDialogItemAsControl( fDialog, 19, &control );	
		SetBevelButtonTextAlignment( control, kControlBevelButtonAlignTextFlushLeft, 0 );
		GetDialogItemAsControl( fDialog, 20, &control );	
		SetBevelButtonTextAlignment( control, kControlBevelButtonAlignTextFlushRight, 0 );
		GetDialogItemAsControl( fDialog, 21, &control );	
		SetBevelButtonTextAlignment( control, kControlBevelButtonAlignTextFlushLeft, 5 );

			// This code sets up some of the buttons to align the text
			// and graphics so they fit together side by side (or above
			// each other).
			
		GetDialogItemAsControl( fDialog, 26, &control );
		SetBevelButtonTextPlacement( control, kControlBevelButtonPlaceToRightOfGraphic );
		GetDialogItemAsControl( fDialog, 27, &control );
		SetBevelButtonTextPlacement( control, kControlBevelButtonPlaceToLeftOfGraphic );
		GetDialogItemAsControl( fDialog, 28, &control );
		SetBevelButtonTextPlacement( control, kControlBevelButtonPlaceBelowGraphic );
		GetDialogItemAsControl( fDialog, 29, &control );
		SetBevelButtonTextPlacement( control, kControlBevelButtonPlaceAboveGraphic );
		GetDialogItemAsControl( fDialog, 30, &control );
		SetBevelButtonTextPlacement( control, kControlBevelButtonPlaceSysDirection );
		SetBevelButtonGraphicAlignment( control, kControlBevelButtonAlignSysDirection, 0, 0 );

		GetDialogItemAsControl( fDialog, 31, &control );
		SetBevelButtonTextPlacement( control, kControlBevelButtonPlaceToRightOfGraphic );
		SetBevelButtonGraphicAlignment( control, kControlBevelButtonAlignLeft, 2, 0 );

		GetDialogItemAsControl( fDialog, 32, &control );
		SetBevelButtonTextPlacement( control, kControlBevelButtonPlaceToLeftOfGraphic );
		SetBevelButtonGraphicAlignment( control, kControlBevelButtonAlignRight, 2, 0 );

		// ÄÄ†MAA TEMPORARY CODE
		IconRef theIconRef;
		
		GetIconRef( kOnSystemDisk, kSystemIconsCreator, kGenericFloppyIcon, &theIconRef );
		if (theIconRef)
		{
            MenuHandle theMenuHandle = GetMenu(131);

            if (theMenuHandle)
                SetMenuItemIconHandle(theMenuHandle, 1, kMenuIconRefType, (Handle)theIconRef);
            else
                DebugStr("\pGot no menu handle.");
		}
		else
			DebugStr("\pgot nil IconRef");

		ShowWindow( fWindow );
	}
}

BevelDialog::~BevelDialog()
{
}

void
BevelDialog::HandleItemHit( short itemHit )
{
	switch ( itemHit ) {
		case kDisableButton:
			EnableDisableAll( false );
			break;
		
		case kEnableButton:
			EnableDisableAll( true );
			break;
		
		case kOnButton:
			SetControlValues( kControlCheckBoxCheckedValue );
			break;
		
		case kOffButton:
			SetControlValues( kControlCheckBoxUncheckedValue );
			break;
		
		case kMixedButton:
			SetControlValues( kControlCheckBoxMixedValue );
			break;
			
	}
}

void
BevelDialog::EnableDisableAll( Boolean enable )
{
	ControlHandle control;
	short		i;
	
	for ( i = kFirstButton; i <= kLastButton; i++ )
	{
		GetDialogItemAsControl( fDialog, i, &control);
		HiliteControl( control, enable ? 0 : kControlInactivePart );
	}
}

void
BevelDialog::SetControlValues( short value )
{
	ControlHandle control;
	short		i;
	
	for ( i = kFirstButton; i <= kLastButton; i++ )
	{
		GetDialogItemAsControl( fDialog, i, &control);
		SetControlValue( control, value );
	}
}

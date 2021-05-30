/*
	File:		LayoutPane.cp

	Contains:	Class to drive our layout pane, demonstrating group boxes.

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

#include "LayoutPane.h"
#include "AppearanceHelpers.h"
#include "UDialogUtils.h"

enum
{
	kPrimaryGroup		= 1,
	kUserPane			= 2,
	kSecondaryGroup		= 3,
	kSeparator			= 4,
	kRadioGroup			= 5,
	kLevel1Radio		= 6,
	kLevel2Radio		= 7,
	kLevel3Radio		= 8,
	kUseMilliCheck		= 9,
	kFullCheck			= 10
};

LayoutPane::LayoutPane( DialogPtr dialog, SInt16 items ) : MegaPane( dialog, items )
{
	ControlHandle	control;
	
	AppendDialogItemList( dialog, 6005, overlayDITL );
	
	UDialogUtils::SetItemValue( dialog, fOrigItems + kPrimaryGroup, 1 );
	
	GetDialogItemAsControl( dialog, fOrigItems + kLevel1Radio, &control );
	SetControlMaximum( control, 2 );
	GetDialogItemAsControl( dialog, fOrigItems + kLevel2Radio, &control );
	SetControlMaximum( control, 2 );
	GetDialogItemAsControl( dialog, fOrigItems + kLevel3Radio, &control );
	SetControlMaximum( control, 2 );
	UDialogUtils::SetItemValue( dialog, fOrigItems + kRadioGroup, 2 );
	UDialogUtils::SetItemValue( dialog, fOrigItems + kLevel3Radio, 1 );
	UDialogUtils::SetItemValue( dialog, fOrigItems + kLevel1Radio, 2 );
	UDialogUtils::SetItemValue( dialog, fOrigItems + kLevel1Radio, 0 );
	UDialogUtils::SetItemValue( dialog, fOrigItems + kLevel2Radio, 1 );
}

LayoutPane::~LayoutPane()
{
	ShortenDITL( fDialog, CountDITL( fDialog ) - fOrigItems );
}

void
LayoutPane::ItemHit( SInt16 item )
{
	SInt16			localItem;
	ControlHandle	control;
	
	localItem = item - fOrigItems;
	
	switch( localItem )
	{
		case kPrimaryGroup:
			UDialogUtils::ToggleCheckBox( fDialog, item );
			GetDialogItemAsControl( fDialog, fOrigItems + kUserPane, &control );
			if ( UDialogUtils::GetItemValue( fDialog, item ) == 1 )
				ActivateControl( control );
			else
				DeactivateControl( control );
			break;
		
		case kUseMilliCheck:
		case kFullCheck:
			UDialogUtils::ToggleCheckBox( fDialog, item );
			break;
			
	}
}

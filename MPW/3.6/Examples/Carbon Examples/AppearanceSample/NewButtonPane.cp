/*
	File:		NewButtonPane.cp

	Contains:	Code to demonstrate new button types available with Appearance.

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
#include "NewButtonPane.h"
#include "AppearanceHelpers.h"
#include "UDialogUtils.h"

enum
{
	kBevel1			= 1,
	kToRightBevel	= 2,
	kBelowBevel 	= 3,
	kAboveBevel		= 4,
	kToLeftBevel	= 5,
	kMenuBevel		= 8,
	kMultiMenuBevel	= 9,
	kBevelGroup		= 18,
	kLeftJustBevel	= 19,
	kCenterJustBevel= 20,
	kRightJustBevel = 21,
	kFullJustBevel	= 22
};

#define MIN( a, b )		( ( (a) < (b) ) ? (a) : (b) )
#define MAX( a, b )		( ( (a) > (b) ) ? (a) : (b) )

NewButtonPane::NewButtonPane( DialogPtr dialog, SInt16 items ) : MegaPane( dialog, items )
{
	ControlHandle		control;
	Boolean				kTrue = true;
	SInt32				delay = 30;

	AppendDialogItemList( dialog, 6006, overlayDITL );
	
	GetDialogItemAsControl( dialog, fOrigItems + kToRightBevel, &control );
	SetBevelButtonTextPlacement( control, kControlBevelButtonPlaceToRightOfGraphic );

	GetDialogItemAsControl( dialog, fOrigItems + kBelowBevel, &control );
	SetBevelButtonTextPlacement( control, kControlBevelButtonPlaceBelowGraphic );

	GetDialogItemAsControl( dialog, fOrigItems + kAboveBevel, &control );
	SetBevelButtonTextPlacement( control, kControlBevelButtonPlaceAboveGraphic );

	GetDialogItemAsControl( dialog, fOrigItems + kToLeftBevel, &control );
	SetBevelButtonTextPlacement( control, kControlBevelButtonPlaceToLeftOfGraphic );

	GetDialogItemAsControl( dialog, fOrigItems + kMenuBevel, &control );
	SetBevelButtonTextAlignment( control, kControlBevelButtonAlignTextFlushLeft, 3 );
	SetControlData( control, 0, 'pglc', sizeof( kTrue ), (Ptr)&kTrue );

	GetDialogItemAsControl( dialog, fOrigItems + kMultiMenuBevel, &control );
	SetBevelButtonTextAlignment( control, kControlBevelButtonAlignTextFlushLeft, 3 );
	SetControlData( control, 0, 'pglc', sizeof( kTrue ), (Ptr)&kTrue );

	GetDialogItemAsControl( dialog, fOrigItems + kMultiMenuBevel, &control );
	SetControlData( control, 0, kControlBevelButtonMenuDelayTag, sizeof( SInt32 ), (Ptr)&delay );
	
	InsertMenu( GetMenu( 147 ), -1 );
}

NewButtonPane::~NewButtonPane()
{
	ShortenDITL( fDialog, CountDITL( fDialog ) - fOrigItems );
}

void
NewButtonPane::ItemHit( SInt16 item )
{
	SInt16			localItem;
	
	localItem = item - fOrigItems;
	
	switch ( localItem )
	{
		case kMultiMenuBevel:
			{
				ControlHandle	control;
				Size			realSize;
				SInt16			menuID;
				
				GetDialogItemAsControl( fDialog, fOrigItems + kMultiMenuBevel, &control );
				GetControlData( control, 0, kControlBevelButtonLastMenuTag, sizeof( menuID ), (Ptr)&menuID, &realSize );
			}
			break;
	}
}

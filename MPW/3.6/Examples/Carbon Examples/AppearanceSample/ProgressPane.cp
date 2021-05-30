/*
	File:		ProgressPane.cp

	Contains:	Demonstration of different progress indicators.

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
#include <Resources.h>*/
#include "ProgressPane.h"
#include "AppearanceHelpers.h"

enum
{
	kProgress1 = 1,
	kProgress2 = 2,
	kMovie		= 4
};

ProgressPane::ProgressPane( DialogPtr dialog, SInt16 items ) : MegaPane( dialog, items )
{
	AppendDialogItemList( dialog, 6001, overlayDITL );
	
	fProgressValue = 0;
	fIsAscending = true;
	
	GetDialogItemAsControl( dialog, items + kProgress1, &fProgress1 );
	GetDialogItemAsControl( dialog, items + kProgress2, &fProgress2 );
	
	SetProgressIndicatorState( fProgress2, false );
}

ProgressPane::~ProgressPane()
{
	ShortenDITL( fDialog, CountDITL( fDialog ) - fOrigItems );
}

void
ProgressPane::Idle()
{
	IdleControls( GetDialogWindow( fDialog ) );
	
	if ( fIsAscending )
	{
		fProgressValue += 2;
		if ( fProgressValue > 100 )
		{
			fProgressValue = 98;
			fIsAscending = false;
		}
	}
	else
	{
		fProgressValue -= 2;
		if ( fProgressValue < 0 )
		{
			fProgressValue = 2;
			fIsAscending = true;
		}
	}
	SetControlValue( fProgress1, fProgressValue );
}

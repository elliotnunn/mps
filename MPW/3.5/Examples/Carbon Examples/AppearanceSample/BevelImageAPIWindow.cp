/*
	File:		BevelImageAPIWindow.cp

	Contains:	Bevel Button content type examples.
			
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
//	This file implements a dialog demonstrating the different
//	methods of setting bevel button content types, such as pictures,
//	icons, and text.
//

#ifdef __MRC__
#include <Folders.h>
#include <Appearance.h>
#endif	// __MRC__
#include "BevelImageAPIWindow.h"
#include "AppearanceHelpers.h"

void	HandleBevelDialog( DialogPtr dialog, short itemHit );

void	EnableDisableAll( DialogPtr dialog, Boolean enable );
void	SetControlValues( DialogPtr dialog, short value );
void	SetUpBevelDialog( DialogPtr dialog );

#define DIRECT		1

enum {
	kBevelButton		= 1,
	kImageWell			= 2,

	kBBIconSuite		= 4,
	kBBColorIcon		= 5,
	kBBPicture			= 6,
	kBBTextOnly 		= 7,

	kIWIconSuite		= 8,
	kIWColorIcon		= 9,
	kIWPicture			= 10,
	
	kIWIconSuiteHandle	= 11,
	kIWColorIconHandle	= 12,
	kIWPictureHandle	= 13,
	
	kBBIconSuiteHandle	= 14,
	kBBColorIconHandle	= 15,
	kBBPictureHandle	= 16
};

BevelImageAPIWindow::BevelImageAPIWindow() : BaseDialog( 1002 )
{
	if ( fWindow )
	{
		ShowWindow( fWindow );
		
		GetIconSuite( &fIconSuite, 128, svAllAvailableData );
		fColorIcon = GetCIcon( 128 );
		
		OSErr err = GetIconRef( kOnSystemDisk, kSystemIconsCreator, kClippingPictureTypeIcon, &fIconRef );
		if ( err ) fIconRef = nil;
	}
}

BevelImageAPIWindow::~BevelImageAPIWindow()
{
	if ( fWindow )
	{
		if ( fIconSuite )
			DisposeIconSuite( fIconSuite, true );
		
		if ( fColorIcon )
			DisposeCIcon( fColorIcon );

		if ( fIconRef )
			ReleaseIconRef( fIconRef );
	}
}

void
BevelImageAPIWindow::HandleItemHit( short itemHit )
{
	ControlHandle				control;
	ControlButtonContentInfo	info;
	OSErr						err;
	
	switch ( itemHit ) {
		case kBBIconSuite:
			GetDialogItemAsControl( fDialog, kBevelButton, &control );
			
			info.contentType = kControlContentIconSuiteRes;
			info.u.resID = 128;
			err = SetBevelButtonContentInfo( control, &info );
			
			SetControlTitle( control, "\p" );
			
			if ( err == noErr )
				DrawOneControl( control );
				
			break;
		
		case kBBColorIcon:
			GetDialogItemAsControl( fDialog, kBevelButton, &control );
			
			info.contentType = kControlContentCIconRes;
			info.u.resID = 128;
			err = SetBevelButtonContentInfo( control, &info );
			
			SetControlTitle( control, "\p" );

			if ( err == noErr )
				DrawOneControl( control );
				
			break;
		
		case kBBPicture:
			GetDialogItemAsControl( fDialog, kBevelButton, &control );
			
			info.contentType = kControlContentPictRes;
			info.u.resID = 129;
			err = SetBevelButtonContentInfo( control, &info );
			
			SetControlTitle( control, "\p" );

			if ( err == noErr )
				DrawOneControl( control );
				
			break;
		
		case kBBTextOnly:
			GetDialogItemAsControl( fDialog, kBevelButton, &control );
			
			info.contentType = kControlContentTextOnly;
			info.u.resID = 0;
			err = SetBevelButtonContentInfo( control, &info );
			
			SetControlTitle( control, "\pTesting" );
							
			break;
			

		case kBBIconSuiteHandle:
			GetDialogItemAsControl( fDialog, kBevelButton, &control );
			
			info.contentType = kControlContentIconSuiteHandle;
			info.u.iconSuite = fIconSuite;
			err = SetBevelButtonContentInfo( control, &info );
			
			if ( err == noErr )
				DrawOneControl( control );
				
			break;
		
		case kBBColorIconHandle:
			GetDialogItemAsControl( fDialog, kBevelButton, &control );
			
#if 0
			info.contentType = kControlContentCIconHandle;
			info.u.cIconHandle = fColorIcon;
#else
			if ( fIconRef )
			{
                info.contentType = kControlContentIconRef;
                info.u.iconRef = fIconRef;
			}
#endif
			err = SetBevelButtonContentInfo( control, &info );
			
			if ( err == noErr )
				DrawOneControl( control );
				
			break;
		
		case kBBPictureHandle:
			GetDialogItemAsControl( fDialog, kBevelButton, &control );
			
			info.contentType = kControlContentPictHandle;
			info.u.picture = GetPicture( 129 );
			err = SetBevelButtonContentInfo( control, &info );
			
			if ( err == noErr )
				DrawOneControl( control );
				
		case kIWIconSuite:
			GetDialogItemAsControl( fDialog, kImageWell, &control );
			
			info.contentType = kControlContentIconSuiteRes;
			info.u.resID = 128;
			err = SetBevelButtonContentInfo( control, &info );
			
			if ( err == noErr )
				DrawOneControl( control );
				
			break;
		
		case kIWColorIcon:
			GetDialogItemAsControl( fDialog, kImageWell, &control );
			
			info.contentType = kControlContentCIconRes;
			info.u.resID = 128;
			err = SetBevelButtonContentInfo( control, &info );
			
			if ( err == noErr )
				DrawOneControl( control );
				
			break;
		
		case kIWPicture:
			GetDialogItemAsControl( fDialog, kImageWell, &control );
			
			info.contentType = kControlContentPictRes;
			info.u.resID = 129;
			err = SetBevelButtonContentInfo( control, &info );
			
			if ( err == noErr )
				DrawOneControl( control );
				
			break;			

		case kIWIconSuiteHandle:
			GetDialogItemAsControl( fDialog, kImageWell, &control );
			
			info.contentType = kControlContentIconSuiteHandle;
			info.u.iconSuite = fIconSuite;
			err = SetBevelButtonContentInfo( control, &info );
			
			if ( err == noErr )
				DrawOneControl( control );
				
			break;
		
		case kIWColorIconHandle:
			GetDialogItemAsControl( fDialog, kImageWell, &control );
			
			info.contentType = kControlContentCIconHandle;
			info.u.cIconHandle = fColorIcon;
			err = SetBevelButtonContentInfo( control, &info );
			
			if ( err == noErr )
				DrawOneControl( control );
				
			break;
		
		case kIWPictureHandle:
			GetDialogItemAsControl( fDialog, kImageWell, &control );
			
			info.contentType = kControlContentPictHandle;
			info.u.picture = GetPicture( 129 );
			err = SetBevelButtonContentInfo( control, &info );
			
			if ( err == noErr )
				DrawOneControl( control );
				
			break;			
	}
}

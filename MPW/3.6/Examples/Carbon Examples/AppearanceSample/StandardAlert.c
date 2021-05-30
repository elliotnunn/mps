/*
	File:		StandardAlert.c

	Contains:	Sample code showing the use of StandardAlert.

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
#include "UDialogUtils.h"

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Dialog Item numbers
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã

enum
{
	kOKButton			= 1,
	kCancelButton		= 2,
	kErrorText			= 4,
	kExplainText		= 6,
	kMovableCheck		= 7,
	kButtonGroup		= 8,
	kButton1Group		= 9,
	kButton2Group		= 10,
	kButton3Group		= 11,
	kButton2Check		= 13,
	kButton3Check		= 14,
	kUseDefault1Check	= 15,
	kUseDefault2Check	= 16,
	kUseDefault3Check	= 17,
	kButton1Text		= 18,
	kButton2Text		= 19,
	kButton3Text		= 20,
	kTypePopup			= 22,
	kHelpCheck			= 23
};

void	TestStandardAlert();

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä TestStandardAlert
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	This routine puts up an alert using the StandardAlert routine. It first
//	requests information via a dialog. It uses a 'dlog' resource for this
//	dialog and has embedding enabled. After reviewing the DITL in ResEdit
//	and looking at the code below, it should provide some good clues as to
//	how you can take advantage of embedding features. You'll notice that I've
//	used it implicity below when I disable the contents of the secondary
//	groups containing the 'Use Default' check box and the button name edit
//	text box. This allows me to properly save the state of the Use Default
//	check box when checking and unchecking the 'Button <n>' check boxes. If I
//	had the 'Use Default' check box off when I click the Button 2 check box
//	off, the next time I turn the Button 2 check box on, the Use Default button
//	will still be enabled.
//
//	You'll also notice just how easy it is to disable edit text fields here.
//	Its just a call to the utility to enable/disable a dialog item. When in
//	embedding mode, all items are controls, so you can treat everything the
//	same way!
//
//	This routine also shows an example of the SetControlFontStyle routine,
//	which allows you to set the font of any control that supports font
//	styles. All new controls delivered with appearance that display text
//	obey the new font style doodad. Alternatively, we could have created a
//	'dftb' resource to set the font styles.
//
void
TestStandardAlert()
{
	DialogPtr		dialog;
	SInt16			itemHit;
	Str255			text, desc;
	Str63			button1Text, button2Text, button3Text;
	StringPtr		btn1, btn2, btn3;
	Boolean			movable;
	SInt16			alertType;
	ControlFontStyleRec	style;
	Boolean			useHelp;
	AlertStdAlertParamRec	param;
	
	dialog = GetNewDialog( 1000, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return;
	
	SetDialogDefaultItem( dialog, kOKButton );
	SetDialogCancelItem( dialog, kCancelButton );
	
	SelectDialogItemText( dialog, kErrorText, 0, 32768 );
	
	UDialogUtils::ToggleCheckBox( dialog, kUseDefault1Check );
	UDialogUtils::ToggleCheckBox( dialog, kUseDefault2Check );
	UDialogUtils::ToggleCheckBox( dialog, kUseDefault3Check );

	UDialogUtils::EnableDialogItem( dialog, kButton1Text, false );
	UDialogUtils::EnableDialogItem( dialog, kButton2Text, false );
	UDialogUtils::EnableDialogItem( dialog, kButton3Text, false );

	UDialogUtils::EnableDialogItem( dialog, kButton2Group, false );
	UDialogUtils::EnableDialogItem( dialog, kButton3Group, false );

	style.flags = kControlUseFontMask;
	style.font = kControlFontSmallBoldSystemFont;
	UDialogUtils::SetFontStyle( dialog, kButtonGroup, style );

	ShowWindow( GetDialogWindow( dialog ) );
	
	itemHit = 0;
	while ( itemHit != kOKButton && itemHit != kCancelButton )
	{
		ModalDialog( nil, &itemHit );
		
		switch ( itemHit )
		{
			case kMovableCheck:
			case kHelpCheck:
				UDialogUtils::ToggleCheckBox( dialog, itemHit );
				break;
			
			case kButton2Check:
				UDialogUtils::ToggleCheckBox( dialog, kButton2Check );
				if ( UDialogUtils::GetItemValue( dialog, kButton2Check ) == 0 )
					UDialogUtils::EnableDialogItem( dialog, kButton2Group, false );
				else
					UDialogUtils::EnableDialogItem( dialog, kButton2Group, true );
				break;
			
			case kButton3Check:
				UDialogUtils::ToggleCheckBox( dialog, kButton3Check );
				if ( UDialogUtils::GetItemValue( dialog, kButton3Check ) == 0 )
					UDialogUtils::EnableDialogItem( dialog, kButton3Group, false );
				else
					UDialogUtils::EnableDialogItem( dialog, kButton3Group, true );
				break;
			
			case kUseDefault1Check:
				UDialogUtils::ToggleCheckBox( dialog, kUseDefault1Check );
				if ( UDialogUtils::GetItemValue( dialog, kUseDefault1Check ) == 1 )
					UDialogUtils::EnableDialogItem( dialog, kButton1Text, false );
				else
					UDialogUtils::EnableDialogItem( dialog, kButton1Text, true );
				break;
				
			case kUseDefault2Check:
				UDialogUtils::ToggleCheckBox( dialog, kUseDefault2Check );
				if ( UDialogUtils::GetItemValue( dialog, kUseDefault2Check ) == 1 )
					UDialogUtils::EnableDialogItem( dialog, kButton2Text, false );
				else
					UDialogUtils::EnableDialogItem( dialog, kButton2Text, true );
				break;
				
			case kUseDefault3Check:
				UDialogUtils::ToggleCheckBox( dialog, kUseDefault3Check );
				if ( UDialogUtils::GetItemValue( dialog, kUseDefault3Check ) == 1 )
					UDialogUtils::EnableDialogItem( dialog, kButton3Text, false );
				else
					UDialogUtils::EnableDialogItem( dialog, kButton3Text, true );
				break;
		}
			
	}
	if ( itemHit == kOKButton )
	{
		
		alertType = UDialogUtils::GetItemValue( dialog, kTypePopup ) - 1;
		
		movable = UDialogUtils::GetItemValue( dialog, kMovableCheck ) == 1;
		
		UDialogUtils::GetItemText( dialog, kErrorText, text );
		UDialogUtils::GetItemText( dialog, kExplainText, desc );
		
		if ( UDialogUtils::GetItemValue( dialog, kUseDefault1Check ) == 1 )
		{
			btn1 = (StringPtr)-1L;
		}
		else
		{
			UDialogUtils::GetItemText( dialog, kButton1Text, button1Text );
			btn1 = button1Text;
		}
		
		if ( UDialogUtils::GetItemValue( dialog, kButton2Check ) == 1 )
		{
			if ( UDialogUtils::GetItemValue( dialog, kUseDefault2Check ) == 1 )
			{
				btn2 = (StringPtr)-1L;
			}
			else
			{
				UDialogUtils::GetItemText( dialog, kButton2Text, button2Text );
				btn2 = button2Text;
			}
		}
		else
			btn2 = nil;
			
		if ( UDialogUtils::GetItemValue( dialog, kButton3Check ) == 1 )
		{
			if ( UDialogUtils::GetItemValue( dialog, kUseDefault3Check ) == 1 )
			{
				btn3 = (StringPtr)-1L;
			}
			else
			{
				UDialogUtils::GetItemText( dialog, kButton3Text, button3Text );
				btn3 = button3Text;
			}
		}
		else
			btn3 = nil;
		
		useHelp = ( UDialogUtils::GetItemValue( dialog, kHelpCheck ) == 1 );

			// Finally! Now we can call StandardAlert.
			
		DisposeDialog( dialog );
		
			// I'm not passing a filter proc here. So, if you want to handle
			// update events in the background windows, add one here. I've left that
			// as an exercise for you, the good people of Mac-dom.
			
		param.movable 		= movable;
		param.filterProc 	= nil;
		param.defaultText 	= btn1;
		param.cancelText 	= btn2;
		param.otherText 	= btn3;
		param.helpButton 	= useHelp;
		param.defaultButton = kAlertStdAlertOKButton;
		param.cancelButton 	= btn2 ? kAlertStdAlertCancelButton : 0;
		param.position 		= 0;
		
		StandardAlert( alertType, text, desc, &param, &itemHit );
	}
	else
		DisposeDialog( dialog );
}

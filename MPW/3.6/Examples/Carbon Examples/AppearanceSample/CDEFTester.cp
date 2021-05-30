/*
	File:		CDEFTester.cp

	Contains:	Code to demonstrate all types of controls.

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
//	This file opens a dialog and adds a menu to the menu bar which allows the user
//	to create and play with the different control types.
//

#ifdef __MRC__
#include <Appearance.h>
#include <ControlDefinitions.h>
#include <Dialogs.h>
#include <TextUtils.h>
#endif
#include "CDEFTester.h"
#include "CDEFTesterUtils.h"

extern MenuHandle		gFontMenu;		// Menu used to choose a font

enum
{
	kBevelButton		= 1,
	kChasingArrows		= 2,
	kDisclosureTriangle	= 3,
	kDivider			= 4,
	kEditText			= 5,
	kFinderHeader		= 6,
	kGroupBox			= 7,
	kIconCDEF			= 8,
	kImageWell			= 9,
	kLittleArrows		= 10,
	kPictureCDEF		= 11,
	kPlacard			= 12,
	kPopupArrow			= 13,
	kProgressBar		= 14,
	kScrollBar			= 15,
	kStaticText			= 16,
	kTabs				= 17,
	kUserPane			= 18,
	kPushButton			= 19,
	kCheckBox			= 20,
	kRadioButton		= 21,
	kSlider				= 22,
	kClock				= 23,
	kList				= 24
};

enum
{
	kValueText			= 2,
	kValueOK			= 3,
	kValueCancel		= 4
};

#define Height( r )		( (r).bottom - (r).top )
#define Width( r )		( (r).right - (r).left )

MenuHandle CDEFTester::fMenu = nil;


CDEFTester::CDEFTester() : BaseWindow( 130 )
{
	ControlRef		control;
	Rect			bounds;
	CGrafPtr		port;

	if (fMenu == nil)
		fMenu = GetMenu(133);
		
	fControl = nil;
	fIsTab = false;

	port = GetWindowPort( fWindow );
	GetPortBounds( port, &fPartRect );
	
	fPartRect.top = fPartRect.bottom - 20;
	fPartRect.right = fPartRect.left + 260;
	OffsetRect( &fPartRect, 5, -5 );
	
	CreateRootControl( fWindow, &control );
	
	bounds = fPartRect;
	bounds.right = bounds.left + 60;
	
	OffsetRect( &bounds, 275, 0 );
	fDisableButton = NewControl( fWindow, &bounds, "\pDisable", true, 0, 0, 1, kControlPushButtonProc, 0 );

	bounds.right = bounds.left + 70;
	OffsetRect( &bounds, 70, 0 );
	fSetValueButton = NewControl( fWindow, &bounds, "\pSet Value", true, 0, 0, 1, kControlPushButtonProc, 0 );

	DeactivateControl( fDisableButton );
	DeactivateControl( fSetValueButton );
}

CDEFTester::~CDEFTester()
{
	MenuHandle theMenu;
	theMenu = GetMyMenu();
	
	if (theMenu)
	{
 		DeleteMenu( GetMenuID( theMenu ) );
 		InvalMenuBar();
	}

	if ( fControl ) 
		DisposeControl( fControl );

	if (gFontMenu)
	{
		DisableMenuItem(gFontMenu, 0);
		InvalMenuBar();
	}
}

void
CDEFTester::Activate( EventRecord& event )
{
	ControlRef		root;
	
	BaseWindow::Activate( event );
	
	if ( GetRootControl( fWindow, &root ) == noErr )
		ActivateControl( root );

	if ((gFontMenu) && (fControl))
	{
		EnableMenuItem(gFontMenu, 0);
		InvalMenuBar();
	}
}

void
CDEFTester::Deactivate( EventRecord& event )
{
	ControlRef		root;
	
	BaseWindow::Deactivate( event );
	
	if ( GetRootControl( fWindow, &root ) == noErr )
		DeactivateControl( root );
		
	if (gFontMenu)
	{
		DisableMenuItem(gFontMenu, 0);
		InvalMenuBar();
	}
}

void
CDEFTester::Draw()
{
	DrawControls( fWindow );
}

void
CDEFTester::HandleClick( EventRecord& event )
{
	Point		where = event.where;
	ControlRef	control;
	SInt16		part;
	
	SetPort( GetWindowPort( fWindow ) );
	GlobalToLocal( &where );
	
	part = FindControl( where, fWindow, &control );
	
	if ( control == fDisableButton )
	{
		if ( TrackControl( control, where, (ControlActionUPP)-1L ) )
		{
			if ( GetControlReference( control ) == 0 )
			{
				DeactivateControl( fControl );
				SetControlTitle( control, "\pEnable" );
				SetControlReference( control, 1 );
			}
			else
			{
				ActivateControl( fControl );
				SetControlTitle( control, "\pDisable" );
				SetControlReference( control, 0 );
			}
		}
	}
	else if ( control == fSetValueButton )
	{
		if ( TrackControl( control, where, (ControlActionUPP)-1L ) )
		{
			SetValue();
		}
	}
	else
	{
		DisplayPartCode( part );
		
		if ( part )
		{
			part = TrackControl( control, where, (ControlActionUPP)-1L );
			DisplayPartCode( part );
		}
	}
}



//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä HandleKeyDown
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Call HandleControlKey to give the key to the control
//

void CDEFTester::HandleKeyDown(EventRecord &event)
{
	HandleControlKey(this->fControl, (event.message & keyCodeMask)>>8, event.message & charCodeMask, event.modifiers);
}


//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä Idle
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Call IdleControls to give time to controls like edit text, chasing arrows,
//	and the indeterminate progress indicator.
//
void
CDEFTester::Idle()
{
	IdleControls( fWindow );
}

void CDEFTester::ChangeControlFont(SInt16 menuID, SInt16 itemNo)
{
	ControlFontStyleRec fontStyleRec;
	MenuHandle theMenu = GetMenuHandle(menuID);
	SInt16 fontID;
	OSErr theErr;
	Rect bounds;
	SInt16			baseLine;

	if (fControl)
	{
		GetMenuItemFontID(theMenu, itemNo, &fontID);	
		fontStyleRec.flags = kControlUseFontMask;
		fontStyleRec.font = fontID;
		theErr = SetControlFontStyle(fControl, &fontStyleRec);

		HideControl(fControl); // the rect is going to change.. want to erase old rect..
		// reset the font bounds since we changed the size..
		if ( GetBestControlRect( fControl, &bounds, &baseLine ) == noErr )
			SetControlBounds( fControl, &bounds );

		ShowControl(fControl);
	}
}

	

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä HandleMenuSelection
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Create the right type of control. Ignore any menu items not from our menu.
//
void
CDEFTester::HandleMenuSelection( SInt16 menuID, SInt16 itemNo )
{
	ControlRef		newControl = nil;
	
	if ((menuID != GetMenuID( GetMyMenu() )) && (menuID != kMenuFonts)) return;
	
	if (menuID == kMenuFonts)
	{
		ChangeControlFont(menuID, itemNo);
		return;
	}
	
	fIsTab = false;
	
	switch ( itemNo )
	{
		case kTabs:
			newControl = CreateTabs( fWindow );
			if (newControl)
				fIsTab = true;
			break;
			
		case kUserPane:
			newControl = CreateUserPane( fWindow );
			break;
			
  		case kStaticText:
  			newControl = CreateStaticText( fWindow );
  			break;

  		case kEditText:
  			newControl = CreateEditText( fWindow );
  			break;

		case kPushButton:
			newControl = CreatePushButton( fWindow );
			break;
		
		case kCheckBox:
			newControl = CreateCheckBox( fWindow );
			break;
		
		case kSlider:
			newControl = CreateSlider( fWindow );
			break;
		
		case kClock:
			newControl = CreateClock( fWindow );
			break;
		
		case kRadioButton:
			newControl = CreateRadioButton( fWindow );
			break;
			
		case kBevelButton:
			newControl = CreateBevelButton( fWindow );
			break;

		case kChasingArrows:
			newControl = CreateChasingArrows( fWindow );
			break;

		case kDivider:
			newControl = CreateDivider( fWindow );
			break;

		case kDisclosureTriangle:
			newControl = CreateTriangle( fWindow );
			break;

		case kFinderHeader:
			newControl = CreateFinderHeader( fWindow );
			break;

		case kIconCDEF:
			newControl = CreateIconCDEF( fWindow );
			break;

		case kPictureCDEF:
			newControl = CreatePictureCDEF( fWindow );
			break;

		case kProgressBar:
			newControl = CreateProgressBar( fWindow );
			break;

		case kLittleArrows:
			newControl = CreateLittleArrows( fWindow );
			break;

		case kGroupBox:
			newControl = CreateGroupBox( fWindow );
			break;

		case kPlacard:
			newControl = CreatePlacard( fWindow );
			break;

		case kPopupArrow:
			newControl = CreatePopupArrow( fWindow );
			break;

		case kScrollBar:
			newControl = CreateScrollBar( fWindow );
			break;

		case kImageWell:
			newControl = CreateImageWell( fWindow );
			break;

		case kList:
			newControl = CreateList( fWindow );
			break;
	}

	if ( newControl )
	{
		Rect bounds;
		SInt16			baseLine;
	
		if ( fControl ) DisposeControl( fControl );
		fControl = newControl;
		if ( GetBestControlRect( fControl, &bounds, &baseLine ) == noErr )
			SetControlBounds( fControl, &bounds );
		
		CenterControlInWindow();
		ShowControl( fControl );
		
		SetControlTitle( fDisableButton, "\pDisable" );
		SetControlReference( fDisableButton, 0 );
		ActivateControl( fDisableButton );
		ActivateControl( fSetValueButton );
		
		//now the WYSIWYG menu can be used
		if (gFontMenu)
		{
			EnableMenuItem(gFontMenu, 0);
			InvalMenuBar();
		}
	}
	else if ( fControl == nil )
	{
		SetControlTitle( fDisableButton, "\pDisable" );
		SetControlReference( fDisableButton, 0 );
		DeactivateControl( fDisableButton );
		DeactivateControl( fSetValueButton );
	}
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä CenterControlInWindow
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Moves the control into the center of the window.
//
void
CDEFTester::CenterControlInWindow()
{
	Rect		bounds;
	SInt16		left, top, height, width;
	CGrafPtr	port;
	Rect		portRect;

	if ( fControl == nil ) return;
	
	GetControlBounds( fControl, &bounds );
	
	height = Height( bounds );
	width = Width( bounds );

	port = GetWindowPort( fWindow );
	GetPortBounds( port, &portRect );
	
	left = (( Width( portRect ) - width ) / 2 ) + portRect.left;
	top = (( Height( portRect ) - height ) / 2 ) + portRect.top;
	
	SetRect( &bounds, left, top, left + width, top + height );
	SetControlBounds( fControl, &bounds );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä SetValue
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Allows the user to choose a specific value for the control.
//
void
CDEFTester::SetValue()
{
	DialogPtr		dialog;
	SInt16			itemNo;
	Str255			text;
	SInt32			number;
	ControlKeyFilterUPP	filterProc;
	ControlHandle	control;
	
	dialog = GetNewDialog( 2004, nil, (WindowRef)-1L );
	if ( dialog == nil ) return;
	
	SetDialogDefaultItem( dialog, kValueOK );
	SetDialogCancelItem( dialog, kValueCancel );
	
	// Set the text item to the current control value
	GetDialogItemAsControl( dialog, kValueText, &control );
	NumToString( GetControlValue( fControl ), text );
	SetDialogItemText( (Handle)control, text );
	
	// make sure its selected
	SelectDialogItemText( dialog, kValueText, 0, 32767 );
	
	// add our simple numbers-only key filter
	filterProc = NewControlKeyFilterUPP( NumericFilter );
	SetControlData( control, 0, kControlEditTextKeyFilterTag, sizeof( filterProc ),
					(Ptr)&filterProc );

	itemNo = 0;
	while( itemNo != kValueCancel && itemNo != kValueOK )
	{
		ModalDialog( nil, &itemNo );
	}
	DisposeControlKeyFilterUPP( filterProc );
	
	if ( itemNo == kValueCancel )
	{
		DisposeDialog( dialog );
		return;
	}
		
	// Get the text
	GetDialogItemAsControl( dialog, kValueText, &control );
	GetDialogItemText( (Handle)control, text );
	StringToNum( text, &number );
	
	DisposeDialog( dialog );
	
	SetControlValue( fControl, number );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä DisplayPartCode
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Prints the constant for the part code passed in.
//
void
CDEFTester::DisplayPartCode( SInt16 part )
{
	Str255		lastString;
	
	SetPort( GetWindowPort( fWindow ) );
	
	EraseRect( &fPartRect );
	MoveTo( fPartRect.left, fPartRect.bottom - 4 );
	
	DrawString( "\pLast Part: " );
	NumToString( part, lastString );
	DrawString( lastString );
	
	if (!fIsTab) 
	// Tabs return part codes corresponding to the new tab you're pushing on/selecting.  The part numbers
	// don't represent the standard part numbers as shown below.
	{
		DrawString( "\p (" );
		switch ( part )
		{
			case kControlNoPart:
				DrawString( "\pkControlNoPart" );
				break;
				
			case kControlClockPart:
				DrawString( "\pkControlClockPart" );
				break;
				
			case kControlLabelPart:
				DrawString( "\pkControlLabelPart" );
				break;
	
			case kControlMenuPart:
				DrawString( "\pkControlMenuPart" );
				break;
	
			case kControlEditTextPart:
				DrawString( "\pkControlEditTextPart" );
				break;
	
			case kControlIconPart:
				DrawString( "\pkControlIconPart" );
				break;
	
			case kControlPicturePart:
				DrawString( "\pkControlPicturePart" );
				break;
	
			case kControlTrianglePart:
				DrawString( "\pkControlTrianglePart" );
				break;
	
			case kControlButtonPart:
				DrawString( "\pkControlButtonPart" );
				break;
	
			case kControlCheckBoxPart:
				DrawString( "\pkControlCheckBoxPart" );
				break;
	
			case kControlUpButtonPart:
				DrawString( "\pkControlUpButtonPart" );
				break;
	
			case kControlDownButtonPart:
				DrawString( "\pkControlDownButtonPart" );
				break;
	
			case kControlPageUpPart:
				DrawString( "\pkControlPageUpPart" );
				break;
	
			case kControlPageDownPart:
				DrawString( "\pkControlPageDownPart" );
				break;
	
			case kControlIndicatorPart:
				DrawString( "\pkControlIndicatorPart" );
				break;
	
			case kControlDisabledPart:
				DrawString( "\pkControlInactivePart" );
				break;
	
			case kControlInactivePart:
				DrawString( "\pkControlInactivePart" );
				break;
	
		}
		DrawString( "\p)" );
	}
}

MenuHandle CDEFTester::GetMyMenu(void)
{
	return(fMenu);
}


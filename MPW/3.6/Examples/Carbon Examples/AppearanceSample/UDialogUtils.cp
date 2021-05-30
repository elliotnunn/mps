/*
	File:		UDialogUtils.cp

	Contains:	Dialog item utilities

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

#include "UDialogUtils.h"

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä GetItemHandle
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Returns the handle to the specified dialog item.
//
Handle
UDialogUtils::GetItemHandle( DialogPtr theDialog, SInt16 item )
{
	SInt16		itemType;
	Handle		itemHand;
	Rect		itemRect;
	
	::GetDialogItem( theDialog, item, &itemType, &itemHand, &itemRect );
	return itemHand;
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä SetItemHandle
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Sets the handle of the specified dialog item to the handle given.
//
void
UDialogUtils::SetItemHandle( DialogPtr theDialog, SInt16 item, Handle handle )
{
	SInt16		itemType;
	Handle		itemHand;
	Rect		itemRect;
	
	::GetDialogItem( theDialog, item, &itemType, &itemHand, &itemRect );
	::SetDialogItem( theDialog, item, itemType, handle, &itemRect );
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä GetItemRect
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Gets the bounding rectangle of the specified dialog item.
//
void
UDialogUtils::GetItemRect( DialogPtr theDialog, SInt16 item, Rect& rect )
{
	SInt16		itemType;
	Handle		itemHand;
	
	::GetDialogItem( theDialog, item, &itemType, &itemHand, &rect );
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä SetItemRect
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Sets the bounding rectangle of the specified dialog item to the given rectangle.
//
void
UDialogUtils::SetItemRect( DialogPtr theDialog, SInt16 item, const Rect& rect )
{
	SInt16		itemType;
	Handle		itemHand;
	Rect		itemRect;
	
	::GetDialogItem( theDialog, item, &itemType, &itemHand, &itemRect );
	::SetDialogItem( theDialog, item, itemType, itemHand, &rect );
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä FlashItem
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	This routine is used to flash a button for the cases when the user presses a key that
//	'clicks' a dialog button. If the item specified is not a button, the routine does nothing.
//
void
UDialogUtils::FlashItem( DialogPtr theDialog, SInt16 item )
{
	ControlHandle	control;
	UInt32			ticks;
	OSErr			err;
	
	err = ::GetDialogItemAsControl( theDialog, item, &control );
	if ( err == noErr )
	{
		HiliteControl( control, 1 );
		Delay( 8, &ticks );
		HiliteControl( control, 0 );
	}
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä ToggleCheckBox
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	This routine simply toggles a check box.
//
void
UDialogUtils::ToggleCheckBox( DialogPtr dialog, SInt16 item )
{
	SInt16	newState = 0;
	
	if ( GetItemValue( dialog, item ) == 0 )
		newState = 1;
	SetItemValue( dialog, item, newState );
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä SetItemValue
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	This routine sets the value of the given item to the value passed in.
//
void
UDialogUtils::SetItemValue( DialogPtr dialog, SInt16 item, SInt16 value )
{
	ControlHandle	control;
	OSErr			err;
		
	err = ::GetDialogItemAsControl( dialog, item, &control );
	if ( err ) return;
	
	::SetControlValue( control, value );
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä GetItemValue
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	This routine gets the value of the given item and returns it.
//
SInt16
UDialogUtils::GetItemValue( DialogPtr dialog, SInt16 item )
{
	ControlHandle	control;
	OSErr			err;
	
	err = ::GetDialogItemAsControl( dialog, item, &control );
	if ( err ) return 0;
	
	return ::GetControlValue( control );
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä SetItemText
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	This routine sets the text of the given item to the value passed in.
//
void
UDialogUtils::SetItemText( DialogPtr dialog, SInt16 item, StringPtr text )
{
	SInt16		itemType;
	Handle		itemHand;
	Rect		itemRect;
	ControlHandle	root;
	
	if ( GetRootControl( GetDialogWindow( dialog ), &root ) == noErr )
		::GetDialogItemAsControl( dialog, item, (ControlHandle*)&itemHand );
	else
		::GetDialogItem( dialog, item, &itemType, &itemHand, &itemRect );
	::SetDialogItemText( itemHand, text );
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä GetItemText
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	This routine gets the text of the given item and returns it.
//
void
UDialogUtils::GetItemText( DialogPtr dialog, SInt16 item, StringPtr text )
{
	SInt16		itemType;
	Handle		itemHand;
	Rect		itemRect;
	
	::GetDialogItem( dialog, item, &itemType, &itemHand, &itemRect );
	::GetDialogItemText( itemHand, text );
}


//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä EnableDialogItem
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	This routine enables or disables a specified item. enableIt is true for enabling, false
//	to disable.
//
void
UDialogUtils:: EnableDialogItem( DialogPtr dialog, SInt16 item, Boolean enableIt )
{
	ControlHandle		control;
	OSErr				err;
	
	err = ::GetDialogItemAsControl( dialog, item, &control );
	if ( err ) return;
	
	if ( enableIt )
		::ActivateControl( control );
	else
	{
		::DeactivateControl( control );
	}
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä SetFontStyle
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	This routine sets the font style of a dialog item.
//
void
UDialogUtils::SetFontStyle( DialogPtr dialog, SInt16 item, ControlFontStyleRec& style )
{
	ControlHandle 	control;
	OSErr			err;
	
	err = ::GetDialogItemAsControl( dialog, item, &control );
	
	if ( err == noErr )
		::SetControlFontStyle( control, &style );
}

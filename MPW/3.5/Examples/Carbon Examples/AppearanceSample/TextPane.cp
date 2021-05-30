/*
	File:		TextPane.cp

	Contains:	Class to drive our text pane in MegaDialog.

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

#ifdef __MRC__
#include <Appearance.h>
#include <Sound.h>
#include <TextUtils.h>
#endif	// __MRC__
#include "TextPane.h"
#include "AppearanceHelpers.h"

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Enums, etc.
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã

enum
{
	kStaticText			= 1,
	kDisabledStaticText	= 2,
	kEditText 			= 3,
	kPasswordEditText	= 4,
	kEditFilterText		= 5,
	kClock				= 6,
	kListBox			= 7,
	kShowPasswordButton	= 8,
	kPasswordStaticText	= 10
};

enum
{
	kLeftArrow		= 0x1C,
	kRightArrow		= 0x1D,
	kUpArrow		= 0x1E,
	kDownArrow		= 0x1F,
	kBackspace		= 0x08
};

enum
{
	kListBoxStringsID	= 130
};

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Our keyfilter callback.
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã

ControlKeyFilterUPP TextPane::fFilterProc = NewControlKeyFilterUPP( TextPane::NumericFilter );

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä TextPane
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Constructor. Append our DITL and load our list box, etc.
//
TextPane::TextPane( DialogPtr dialog, SInt16 items ) : MegaPane( dialog, items )
{
	ControlHandle		control;
	ListHandle			list;
	OSErr				err;
	
	AppendDialogItemList( dialog, 6004, overlayDITL );
	
	GetDialogItemAsControl( dialog, items + kDisabledStaticText, &control );
	DeactivateControl( control );
	
	GetDialogItemAsControl( dialog, items + kListBox, &control );
	err = GetListBoxListHandle( control, &list );
	if ( err == noErr )
	{
		Cell		cell;
		SInt16		i;
		Str255		string;
		Rect		dataBounds;

		cell.h = 0;
		
		for ( i = 1; true; i++ )
		{
			GetIndString( string, kListBoxStringsID, i );
			if ( string[0] == 0 ) break;
					
			GetListDataBounds( list, &dataBounds );
			LAddRow( 1, dataBounds.bottom, list );

			GetListDataBounds( list, &dataBounds );
			cell.v = dataBounds.bottom - 1;
			LSetCell( (Ptr)(string + 1), string[0], cell, list );
		}
	}
	
	GetDialogItemAsControl( dialog, items + kEditFilterText, &control );
	SetEditTextKeyFilter( control, fFilterProc );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä ~TextPane
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Destructor. Get rid of our DITL items.
//
TextPane::~TextPane()
{
	ShortenDITL( fDialog, CountDITL( fDialog ) - fOrigItems );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä Idle
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Give our dialog some idle time.
//
void
TextPane::Idle()
{
	IdleControls( GetDialogWindow( fDialog ) );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä ItemHit
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Our item hit handler. Here we handle clicks on our items.
//
void
TextPane::ItemHit( SInt16 itemHit )
{
	SInt16			localItem = itemHit - fOrigItems;
	ControlHandle	control;
	Str255			text;
	
	switch ( localItem )
	{
		case kShowPasswordButton:
			GetDialogItemAsControl( fDialog, fOrigItems + kPasswordEditText, &control );
			GetEditTextPasswordText( control, text );
			GetDialogItemAsControl( fDialog, fOrigItems + kPasswordStaticText, &control );
			SetStaticTextText( control, text, true );
			break;
	}
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä NumericFilter															CALLBACK
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Our numeric key filter. This is called each time the edit field this controls is
//	attached to receives a keystroke. We can either accept the keystroke or block it.
//	To do this, we return either kControlKeyFilterPassKey or kControlKeyFilterBlockKey.
//
pascal ControlKeyFilterResult
TextPane::NumericFilter( ControlHandle control, SInt16* keyCode, SInt16* charCode, EventModifiers* modifiers)
{
	#pragma unused( control, keyCode, modifiers )

	if ( ((char)*charCode >= '0') && ((char)*charCode <= '9') )
		return kControlKeyFilterPassKey;
	
	switch ( *charCode )
	{
		case '-':
		case kLeftArrow:
		case kRightArrow:
		case kUpArrow:
		case kDownArrow:
		case kBackspace:
			return kControlKeyFilterPassKey;

		default:
			SysBeep( 10 );
			return kControlKeyFilterBlockKey;
	}
}


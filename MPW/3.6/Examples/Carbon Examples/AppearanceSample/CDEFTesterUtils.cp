/*
	File:		CDEFTesterUtils.cp

	Contains:	Code to demonstrate creating and using all types of controls.

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
#include <TextUtils.h>
#include <Appearance.h>
#include <Resources.h>
#include <Controls.h>
#include <Lists.h>
#include <NumberFormatting.h>
#endif	// __MRC__
#include "CDEFTesterUtils.h"
#include "BevelButtonItems.h"
#include "RadioGroup.h"
#include "AppearanceHelpers.h"

enum
{
	kLeftArrow		= 0x1C,
	kRightArrow		= 0x1D,
	kUpArrow		= 0x1E,
	kDownArrow		= 0x1F,
	kBackspace		= 0x08
};

enum { kSmall = 1, kNormal, kLarge };
enum { kMomentary = 1, kToggles, kSticky };
enum { kTextOnly = 1, kIconSuite, kColorIcon, kPicture };
enum { kPlaceNormal = 1, kPlaceLeft, kPlaceRight, kPlaceAbove, kPlaceBelow, kPlaceSys };
enum { kTextSysDir = 1, kTextLeft, kTextRight, kTextCenter };
enum { kGraphicSysDir = 1, kGraphicCenter, kGraphicLeft, kGraphicRight,
		kGraphicTop, kGraphicBottom, kGraphicTopLeft, kGraphicBotLeft,
		kGraphicTopRight, kGraphicBotRight };

static void				GetPictureSize( SInt16 resID, SInt32* height, SInt32* width );
static void				GetIconSize( SInt16 resID, SInt32* height, SInt32* width );
static ControlHandle	CreatePictureOrIconCDEF( WindowPtr window, SInt16 procID );
static ControlHandle	CreateCheckBoxOrRadioButton( WindowPtr window, SInt16 procID );
static pascal void		UserPaneDrawProc(ControlHandle theControl, SInt16 thePart);

ControlHandle
CreateBevelButton( WindowPtr window )
{
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	ControlHandle		control = nil;
	SInt16			type;
	Handle			handle;
	Rect			rect;
	SInt32			min = 0;
	SInt32			max, value;
	SInt32			procID = 0;
	Str255			text, title;
	Rect			bounds = { 0, 0, 48, 48 };
	
	ControlButtonGraphicAlignment	graphicAlign;
	ControlButtonTextPlacement	placement;
	ControlButtonTextAlignment	alignment;
	SInt32				longOffset;
	SInt16				offset;
	SInt32				temp;
	Point				graphicOffset;
	ControlHandle		tempControl;
	
	dialog = GetNewDialog( 2000, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	GetDialogItemAsControl( dialog, kBevelSizePopup, &tempControl );
	SetControlValue( tempControl, kSmall );
	
	GetDialogItemAsControl( dialog, kBevelBehaviorPopup, &tempControl );
	SetControlValue( tempControl, kMomentary );
	
	GetDialogItemAsControl( dialog, kBevelContentPopup, &tempControl );
	SetControlValue( tempControl, kTextOnly );

	GetDialogItemAsControl( dialog, kBevelTextPlacePopup, &tempControl );
	SetControlValue( tempControl, kPlaceNormal );

	GetDialogItemAsControl( dialog, kBevelTextAlignPopup, &tempControl );
	SetControlValue( tempControl, kTextCenter );

	GetDialogItemAsControl( dialog, kBevelGraphicAlignPopup, &tempControl );
	SetControlValue( tempControl, kGraphicCenter );

	SetDialogDefaultItem( dialog, kBevelOKButton );
	SetDialogCancelItem( dialog, kBevelCancelButton );
		
	ShowWindow( GetDialogWindow( dialog ) );
	
	while ( itemHit != kBevelCancelButton && itemHit != kBevelOKButton )
	{
		ModalDialog( nil, &itemHit );
		
		GetDialogItemAsControl( dialog, itemHit, &tempControl );
		switch ( itemHit )
		{
			case kBevelOffsetCheck:
			case kBevelMultiMenuCheck:
			case kBevelMenuOnRightCheck:
				{
					SInt16	value = GetControlValue( tempControl );
					SetControlValue( tempControl, !value );
				}
				break;

		}
	}
	
	if ( itemHit == kBevelCancelButton )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
		// Get the content type from the popup into min.
		
	GetDialogItemAsControl( dialog, kBevelContentPopup, &tempControl );
	switch ( GetControlValue( tempControl ) )
	{
		case kTextOnly:		min = kControlContentTextOnly;		break;
		case kIconSuite:	min = kControlContentIconSuiteRes;	break;
		case kColorIcon:	min = kControlContentCIconRes;		break;
		case kPicture:		min = kControlContentPictRes;		break;
	}
	
		// Now get the resource ID for the content, if we
		// have chosen something other than text only.
		// put the ID into max.
		
	if ( min != kControlContentTextOnly )
	{
		GetDialogItem( dialog, kBevelContentIDText, &type, &handle, &rect );
		GetDialogItemText( handle, text );
		StringToNum( text, &max );
	}
	else
		max = 0;
	
		// Get the menu ID
		
	GetDialogItem( dialog, kBevelMenuIDText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &value );
	
	GetDialogItemAsControl( dialog, kBevelSizePopup, &tempControl );
	switch( GetControlValue( tempControl ) )
	{
		case kSmall:	procID = kControlBevelButtonSmallBevelProc;		break;
		case kNormal: 	procID = kControlBevelButtonNormalBevelProc; 	break;
		case kLarge: 	procID = kControlBevelButtonLargeBevelProc;		break;
	}

		// OR our behavior into min.

	GetDialogItemAsControl( dialog, kBevelBehaviorPopup, &tempControl );
	switch( GetControlValue( (ControlHandle)handle ) )
	{
		case kToggles: 		min |= kControlBehaviorToggles; 	break;
		case kSticky: 		min |= kControlBehaviorSticky;		break;
	}

		// See if we should offset the contents and OR the right bit
		// into min.
		
	GetDialogItemAsControl( dialog, kBevelOffsetCheck, &tempControl );
	if ( GetControlValue( tempControl ) == 1 )
		min |= kControlBehaviorOffsetContents;
	
		// See if we have a multi-value menu and OR the right bit
		// into min.
		
	GetDialogItemAsControl( dialog, kBevelMultiMenuCheck, &tempControl );
	if ( GetControlValue( tempControl ) == 1 )
		min |= kControlBehaviorMultiValueMenu;
	
		// See if the menu shoule be on the right and OR the right bit
		// into min.
		
	GetDialogItemAsControl( dialog, kBevelMenuOnRightCheck, &tempControl );
	if ( GetControlValue( tempControl ) == 1 )
		procID |= kControlBevelButtonMenuOnRight;
	
		// Calculate the size of our button
		
	GetDialogItem( dialog, kBevelHeightText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &temp );
	bounds.bottom = temp;
	GetDialogItem( dialog, kBevelWidthText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &temp );
	bounds.right = temp;
	
		// Get the text alignment, offset, and placement
	
	GetDialogItemAsControl( dialog, kBevelTextAlignPopup, &tempControl );
	switch ( GetControlValue( tempControl ) )
	{
		case kTextSysDir:	alignment = kControlBevelButtonAlignTextSysDirection;	break;
		case kTextLeft:		alignment = kControlBevelButtonAlignTextFlushLeft;		break;
		case kTextRight:	alignment = kControlBevelButtonAlignTextFlushRight;		break;
		case kTextCenter:	alignment = kControlBevelButtonAlignTextCenter;			break;
	}
	
	GetDialogItem( dialog, kBevelTextOffsetText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &longOffset );
	offset = longOffset;

	GetDialogItemAsControl( dialog, kBevelTextPlacePopup, &tempControl );
	switch ( GetControlValue( tempControl ) )
	{
		case kPlaceNormal:	placement = kControlBevelButtonPlaceNormally;			break;
		case kPlaceLeft:	placement = kControlBevelButtonPlaceToLeftOfGraphic;	break;
		case kPlaceRight:	placement = kControlBevelButtonPlaceToRightOfGraphic;	break;
		case kPlaceAbove:	placement = kControlBevelButtonPlaceAboveGraphic;		break;
		case kPlaceBelow:	placement = kControlBevelButtonPlaceBelowGraphic;		break;
		case kPlaceSys:		placement = kControlBevelButtonPlaceSysDirection;		break;
	}

		// Get the graphic alignment and offsets
			
	GetDialogItemAsControl( dialog, kBevelGraphicAlignPopup, &tempControl );
	switch ( GetControlValue( tempControl ) )
	{
		case kGraphicSysDir:	graphicAlign = kControlBevelButtonAlignSysDirection;	break;
		case kGraphicCenter:	graphicAlign = kControlBevelButtonAlignCenter;			break;
		case kGraphicLeft:		graphicAlign = kControlBevelButtonAlignLeft;			break;
		case kGraphicRight:		graphicAlign = kControlBevelButtonAlignRight;			break;
		case kGraphicTop:		graphicAlign = kControlBevelButtonAlignTop;				break;
		case kGraphicBottom:	graphicAlign = kControlBevelButtonAlignBottom;			break;
		case kGraphicTopLeft:	graphicAlign = kControlBevelButtonAlignTopLeft;			break;
		case kGraphicBotLeft:	graphicAlign = kControlBevelButtonAlignBottomLeft;		break;
		case kGraphicTopRight:	graphicAlign = kControlBevelButtonAlignTopRight;		break;
		case kGraphicBotRight:	graphicAlign = kControlBevelButtonAlignBottomRight;		break;
	}

	GetDialogItem( dialog, kBevelGraphicHOffsetText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &longOffset );
	graphicOffset.h = longOffset;
	GetDialogItem( dialog, kBevelGraphicVOffsetText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &longOffset );
	graphicOffset.v = longOffset;
	
		// Get the title.
		
	GetDialogItem( dialog, kBevelTitleText, &type, &handle, &rect );
	GetDialogItemText( handle, title );
	
	DisposeDialog( dialog );
	
	control = NewControl( window, &bounds, title, false, value, min, max, procID, 0 );
	if ( control == nil ) return nil;
	
	SetControlData( control, 0, kControlBevelButtonTextPlaceTag, sizeof( ControlButtonTextPlacement ),
		(Ptr)&placement );
		
	SetControlData( control, 0, kControlBevelButtonTextAlignTag, sizeof( ControlButtonTextAlignment ),
		(Ptr)&alignment );

	SetControlData( control, 0, kControlBevelButtonGraphicAlignTag, sizeof( ControlButtonGraphicAlignment ),
		(Ptr)&graphicAlign );

	SetControlData( control, 0, kControlBevelButtonTextOffsetTag, sizeof( SInt16 ), (Ptr)&offset );
	SetControlData( control, 0, kControlBevelButtonGraphicOffsetTag, sizeof( Point ), (Ptr)&graphicOffset );
		
	return control;
}


static pascal void
UserPaneDrawProc (ControlHandle theControl, SInt16 thePart)
{
	#pragma unused( thePart )
	Rect		bounds;
	
	GetControlBounds( theControl, &bounds );
	
	FrameRect( &bounds );
}


/***
	This is just a very simplistic User Pane that that draws a rectangle around its frame, and 
	returns an incrementing number for the part codes.  It shows how to set up a few of the 
	various procedures needed for User Panes.
***/
ControlHandle
CreateUserPane( WindowPtr window )
{
	Rect		bounds = { 0, 0, 100, 100 };
	ControlHandle theControl;
	
	theControl =  NewControl( window, &bounds, "\p", false, 0, 0, 0, kControlUserPaneProc, 0 );
	if (theControl)
		{
			ControlUserPaneDrawUPP myPaneDrawProc;
			
			myPaneDrawProc = NewControlUserPaneDrawUPP(UserPaneDrawProc);
			SetControlData(theControl, 0, kControlUserPaneDrawProcTag, sizeof(ControlUserPaneDrawUPP), (Ptr) &myPaneDrawProc);

			return(theControl);
		}
		
	return(nil);
}


ControlHandle
CreateChasingArrows( WindowPtr window )
{
	Rect		bounds = { 0, 0, 16, 16 };
	
	return NewControl( window, &bounds, "\p", false, 0, 0, 0, kControlChasingArrowsProc, 0 );
}

ControlHandle
CreateDivider( WindowPtr window )
{
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	ControlHandle	control = nil;
	SInt16			type;
	Handle			handle;
	Rect			rect;
	SInt32			length;
	Str255			text;
	Rect			bounds = { 0, 0, 4, 4 };
	ControlHandle	tempControl;
	
	dialog = GetNewDialog( 2001, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	SetDialogDefaultItem( dialog, kDividerOKButton );
	SetDialogCancelItem( dialog, kDividerCancelButton );
		
	while ( itemHit != kDividerCancelButton && itemHit != kDividerOKButton )
	{
		ModalDialog( nil, &itemHit );
	}
	
	if ( itemHit == kDividerCancelButton )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
	GetDialogItem( dialog, kLengthText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &length );
	
	GetDialogItemAsControl( dialog, kDividerRadioGroup, &tempControl );
	if ( GetControlValue( tempControl ) == 1 )
		bounds.right = bounds.left + length;
	else
		bounds.bottom = bounds.top + length;
	
	DisposeDialog( dialog );
	
	control = NewControl( window, &bounds, "\p", false, 0, 0, 0, kControlSeparatorLineProc, 0 );
	if ( control == nil ) return nil;
	
	return control;
}

ControlHandle
CreateTriangle( WindowPtr window )
{
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	ControlHandle	control = nil;
	Rect			bounds = { 0, 0, 12, 12 };
	SInt16			procID;
	ControlHandle	tempControl;
	
	dialog = GetNewDialog( 2002, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	SetDialogDefaultItem( dialog, kTriangleOKButton );
	SetDialogCancelItem( dialog, kTriangleCancelButton );
		
	while ( itemHit != kTriangleCancelButton && itemHit != kTriangleOKButton )
	{
		ModalDialog( nil, &itemHit );
		
		GetDialogItemAsControl( dialog, itemHit, &tempControl );
		switch ( itemHit )
		{
			case kLeftFacingCheck:
			case kAutoTrackCheck:
				SetControlValue( tempControl, !GetControlValue( tempControl ) );
				break;
		}
	}
	
	if ( itemHit == kTriangleCancelButton )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
	procID = kControlTriangleProc;

	GetDialogItemAsControl( dialog, kLeftFacingCheck, &tempControl );
	if ( GetControlValue( tempControl ) == 1 )
		procID |= 1;
		
	GetDialogItemAsControl( dialog, kAutoTrackCheck, &tempControl );
	if ( GetControlValue( tempControl ) == 1 )
		procID |= 2;
	
	DisposeDialog( dialog );
	
	control = NewControl( window, &bounds, "\pTriangle", false, 0, 0, 1, procID, 0 );
	if ( control == nil ) return nil;
	
	return control;
}

ControlHandle
CreateEditText( WindowPtr window )
{
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	ControlHandle	control = nil;
	Rect			bounds = { 20, 20, 36, 200 };
	SInt16			procID;
	ControlHandle	tempControl;
	unsigned char *string = "\pSample Text";
	
	dialog = GetNewDialog( 2014, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	SetDialogDefaultItem( dialog, kETOKButton );
	SetDialogCancelItem( dialog, kETCancelButton );
		
	while ( itemHit != kETCancelButton && itemHit != kETOKButton )
	{
		ModalDialog( nil, &itemHit );
		
		GetDialogItemAsControl( dialog, itemHit, &tempControl );
		if (itemHit == kETPasswordCheck)
			SetControlValue(tempControl, !GetControlValue(tempControl));
	}
	
	if ( itemHit == kETCancelButton )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
	GetDialogItemAsControl( dialog, kETPasswordCheck, &tempControl );
	if (GetControlValue( tempControl ))
		procID = kControlEditTextPasswordProc;
	else
		procID = kControlEditTextProc;

	DisposeDialog( dialog );
	
	control = NewControl( window, &bounds, "\pEdit Text", false, 0, 0, 0, procID, 0 );
	if (!control) return nil;
	
	SetKeyboardFocus(window, control, kControlFocusNextPart);
	
	if (procID != kControlEditTextPasswordProc)
		SetControlData(control,kControlNoPart,kControlEditTextTextTag,*string,(Ptr) string + 1);
	
	return control;
}

ControlHandle
CreateSlider( WindowPtr window )
{
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	ControlHandle	dialogControl,tempControl;
	SInt16			procID = kControlSliderProc;
	Rect			bounds = { 20, 20, 80, 200 };
	Boolean 		enableItems,alreadyEnabled;
	
	dialog = GetNewDialog( 2016, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	SetDialogDefaultItem( dialog, kStdOkItemIndex );
	SetDialogCancelItem( dialog, kStdCancelItemIndex );
	GetDialogItemAsControl(dialog, kSliderDirectional, &tempControl);
	SetControlValue(tempControl, 1);
	ShowWindow( GetDialogWindow( dialog ) );
		
	while ( itemHit != kStdOkItemIndex && itemHit != kStdCancelItemIndex )
		{
			ModalDialog( nil, &itemHit );
			
			GetDialogItemAsControl(dialog, itemHit, &dialogControl);
			
			if ((itemHit == kSliderTickMarks) || (itemHit == kSliderReverse))
				SetControlValue(dialogControl, !GetControlValue(dialogControl)); // toggle checkbox

			if ((itemHit == kSliderNonDirectional) || (itemHit == kSliderDirectional))
				{
					alreadyEnabled = GetControlValue(dialogControl);
					
					SetControlValue(dialogControl, 1);
					GetDialogItemAsControl(dialog, (itemHit == kSliderNonDirectional) ? kSliderDirectional : kSliderNonDirectional, &tempControl);
					SetControlValue(tempControl, 0);
					
					enableItems = (itemHit == kSliderDirectional);
					
					if (!alreadyEnabled) // don't enable/disable sub-items every time, it flickers
						{
							GetDialogItemAsControl(dialog, kSliderTickMarks, &tempControl);
							HiliteControl(tempControl, enableItems ? 0 : kControlDisabledPart);
							GetDialogItemAsControl(dialog, kSliderReverse, &tempControl);
							HiliteControl(tempControl, enableItems ? 0 : kControlDisabledPart);
						}
				}
		}

	if ( itemHit == kStdCancelItemIndex )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
	GetDialogItemAsControl(dialog, kSliderNonDirectional, &tempControl);

	if (GetControlValue(tempControl))
		procID += kControlSliderNonDirectional;
	else
		{  // kSliderNonDirectional overrides all others..
			GetDialogItemAsControl(dialog, kSliderTickMarks, &tempControl);
		
			if (GetControlValue(tempControl))
				procID += kControlSliderHasTickMarks;
			
			GetDialogItemAsControl(dialog, kSliderReverse, &tempControl);
		
			if (GetControlValue(tempControl))
				procID += kControlSliderReverseDirection;
		}

	DisposeDialog( dialog );
	
	return(NewControl( window, &bounds, "\pSlider", false, 5, 0, 100, procID, 0));  // value is number of tickmarks
}

ControlHandle
CreateClock( WindowPtr window )
{
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	ControlHandle	control = nil,dialogControl,tempControl;
	Rect			bounds = { 0, 0, 23, 125 };
	SInt16		procIDs[4] = {kControlClockTimeProc, kControlClockTimeSecondsProc, kControlClockDateProc, kControlClockMonthYearProc};
	short itemIndex,kindIndex=0;
	
	dialog = GetNewDialog( 2017, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	SetDialogDefaultItem( dialog, kStdOkItemIndex );
	SetDialogCancelItem( dialog, kStdCancelItemIndex );
	GetDialogItemAsControl(dialog, kClockTime, &tempControl);
	SetControlValue(tempControl, 1);
	ShowWindow( GetDialogWindow( dialog ) );
		
	while ((itemHit != kStdOkItemIndex) && (itemHit != kStdCancelItemIndex))
		{
			ModalDialog( nil, &itemHit );
			
			GetDialogItemAsControl(dialog, itemHit, &dialogControl);
			
			if ((itemHit >= kClockTime) && (itemHit <= kClockMonthYear) && !GetControlValue(dialogControl)) 
			// if it's radio buttons and the radio button isn't already selected
				{
					for(itemIndex=kClockTime;itemIndex<=kClockMonthYear;itemIndex++)
						{
							GetDialogItemAsControl(dialog, itemIndex, &tempControl);
						
							if (itemIndex == itemHit)
								SetControlValue(tempControl, 1);
							else
								SetControlValue(tempControl, 0);
						}
				}
						
		}

	if ( itemHit == kStdCancelItemIndex )
	{
		DisposeDialog( dialog );
		return nil;
	}

	for(itemIndex=kClockTime;itemIndex<=kClockMonthYear;itemIndex++)
	{	
		GetDialogItemAsControl(dialog, itemIndex, &tempControl);
		
		if (GetControlValue(tempControl))
			kindIndex = itemIndex - kClockTime;
	}

	DisposeDialog( dialog );
	
	control = NewControl( window, &bounds, "\pClock", false, kControlClockNoFlags, 0, 0, procIDs[kindIndex], 0 );

	SetKeyboardFocus(window, control, kControlFocusNextPart);
	
	return(control);
}

ControlHandle
CreateStaticText( WindowPtr window )
{
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	ControlHandle	control = nil;
	Rect			bounds = { 20, 20, 52, 200 };
	DialogItemType	dummyType;
	Handle			textItem;
	Rect			dummyRect;
	Str255			text;
	
	dialog = GetNewDialog( 2015, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	SetDialogDefaultItem( dialog, kSTOKButton );
	SetDialogCancelItem( dialog, kSTCancelButton );
		
	while ( itemHit != kSTCancelButton && itemHit != kSTOKButton )
		ModalDialog( nil, &itemHit );
		

	if ( itemHit == kSTCancelButton )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
	GetDialogItem(dialog, 3, &dummyType, &textItem, &dummyRect);
	
	GetDialogItemText(textItem, text);

	DisposeDialog( dialog );
	
	control = NewControl( window, &bounds, "\pStatic Text", false, 0, 0, 0, kControlStaticTextProc, 0 );
	
	if (!control)
		return(nil);
	
	SetControlData(control, kControlNoPart, kControlStaticTextTextTag, *text, (Ptr) &(text[1]));

	return(control);
}



ControlHandle
CreateFinderHeader( WindowPtr window )
{
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	ControlHandle	control = nil;
	SInt16			type;
	Handle			handle;
	Rect			rect;
	Rect			bounds = { 0, 0, 0, 0 };
	SInt16			procID;
	Str255			text;
	SInt32			number;
	ControlHandle	tempControl;
	
	dialog = GetNewDialog( 2003, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	SetDialogDefaultItem( dialog, kFHOKButton );
	SetDialogCancelItem( dialog, kFHCancelButton );
		
	while ( itemHit != kFHCancelButton && itemHit != kFHOKButton )
	{
		ModalDialog( nil, &itemHit );
		
		GetDialogItemAsControl( dialog, itemHit, &tempControl );
		switch ( itemHit )
		{
			case kFHListViewCheck:
				SetControlValue( tempControl, !GetControlValue( tempControl ) );
				break;
		}
	}
	
	if ( itemHit == kFHCancelButton )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
	procID = kControlWindowHeaderProc;

	GetDialogItemAsControl( dialog, kFHListViewCheck, &tempControl );
	if ( GetControlValue( tempControl ) == 1 )
		procID |= 1;

	GetDialogItem( dialog, kFHHeightText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &number );
	bounds.bottom = number;
	
	GetDialogItem( dialog, kFHWidthText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &number );
	bounds.right = number;
	
	DisposeDialog( dialog );
	
	control = NewControl( window, &bounds, "\p", false, 0, 0, 0, procID, 0 );
	if ( control == nil ) return nil;
	
	return control;
}

ControlHandle
CreateIconCDEF( WindowPtr window )
{
	return CreatePictureOrIconCDEF( window, kControlIconProc );
}

ControlHandle
CreatePictureCDEF( WindowPtr window )
{
	return CreatePictureOrIconCDEF( window, kControlPictureProc );
}

static ControlHandle
CreatePictureOrIconCDEF( WindowPtr window, SInt16 procID )
{
	DialogPtr		dialog;
	SInt16			itemNo;
	SInt16			type;
	Handle			handle;
	Rect			rect;
	Str255			text;
	SInt32			resID, height, width;
	Rect			bounds = { 0, 0, 0, 0 };
	ControlKeyFilterUPP	filterProc;
	ControlHandle		tempControl;
	
	dialog = GetNewDialog( 2005, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;
	
	if ( procID == kControlIconProc )
		SetWTitle( GetDialogWindow( dialog ), "\pIcon CDEF" );
	else
		SetWTitle( GetDialogWindow( dialog ), "\pPicture CDEF" );
		
	SetDialogDefaultItem( dialog, kIconOK );
	SetDialogCancelItem( dialog, kIconCancel );
	
	filterProc = NewControlKeyFilterUPP( NumericFilter );
	GetDialogItemAsControl( dialog, kIconResIDText, &tempControl );
	SetEditTextKeyFilter( tempControl, filterProc );
	GetDialogItemAsControl( dialog, kIconHeightText, &tempControl );
	SetEditTextKeyFilter( tempControl, filterProc );
	GetDialogItemAsControl( dialog, kIconWidthText, &tempControl );
	SetEditTextKeyFilter( tempControl, filterProc );
					
	ShowWindow( GetDialogWindow( dialog ) );
					
	while( itemNo != kIconCancel && itemNo != kIconOK )
	{
		ModalDialog( nil, &itemNo );

		GetDialogItemAsControl( dialog, itemNo, &tempControl );
		switch ( itemNo )
		{
			case kIconNoHitCheck:
				SetControlValue( tempControl, !GetControlValue( tempControl ) );
				break;

			case kIconUseRectCheck:
				SetControlValue( tempControl, !GetControlValue( tempControl ) );
				if ( GetControlValue( tempControl ) == 1 )
				{
					GetDialogItemAsControl( dialog, kIconHeightLabelText, &tempControl );
					DeactivateControl( tempControl );
					GetDialogItemAsControl( dialog, kIconWidthLabelText, &tempControl );
					DeactivateControl( tempControl );
					GetDialogItemAsControl( dialog, kIconHeightText, &tempControl );
					DeactivateControl( tempControl );
					GetDialogItemAsControl( dialog, kIconWidthText, &tempControl );
					DeactivateControl( tempControl );
				}
				else
				{
					GetDialogItemAsControl( dialog, kIconHeightLabelText, &tempControl );
					ActivateControl( tempControl );
					GetDialogItemAsControl( dialog, kIconWidthLabelText, &tempControl );
					ActivateControl( tempControl );
					GetDialogItemAsControl( dialog, kIconHeightText, &tempControl );
					ActivateControl( tempControl );
					GetDialogItemAsControl( dialog, kIconWidthText, &tempControl );
					ActivateControl( tempControl );
				}
				break;
		}
	}
	DisposeControlKeyFilterUPP( filterProc );

	if ( itemNo == kIconCancel )
	{
		DisposeDialog( dialog );
		return nil;
	}

	GetDialogItem( dialog, kIconResIDText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &resID );
	
	GetDialogItemAsControl( dialog, kIconUseRectCheck, &tempControl );
	if ( GetControlValue( tempControl ) == 1 )
	{
		if ( procID == kControlPictureProc )
			GetPictureSize( resID, &height, &width );
		else
			GetIconSize( resID, &height, &width );
	}
	else
	{
		GetDialogItem( dialog, kIconHeightText, &type, &handle, &rect );
		GetDialogItemText( handle, text );
		StringToNum( text, &height );
		
		GetDialogItem( dialog, kIconWidthText, &type, &handle, &rect );
		GetDialogItemText( handle, text );
		StringToNum( text, &width );
	}	
	GetDialogItemAsControl( dialog, kIconNoHitCheck, &tempControl );
	if ( GetControlValue( tempControl ) == 1 )
		procID |= 1;
	
	DisposeDialog( dialog );
	
	bounds.bottom = bounds.top + height;
	bounds.right = bounds.left + width;
	return(NewControl( window, &bounds, "\p", false, resID, 0, 0, procID, 0 ));
}

ControlHandle
CreateProgressBar( WindowPtr window )
{
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	ControlHandle	control = nil;
	SInt16			type;
	Handle			handle;
	Rect			rect;
	Rect			bounds = { 0, 0, 16, 0 };
	Str255			text;
	SInt32			number;
	Boolean			indeterminate;
	ControlHandle	tempControl;
	
	dialog = GetNewDialog( 2006, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	SetDialogDefaultItem( dialog, kProgOKButton );
	SetDialogCancelItem( dialog, kProgCancelButton );
		
	while ( itemHit != kProgCancelButton && itemHit != kProgOKButton )
	{
		ModalDialog( nil, &itemHit );
		
		GetDialogItemAsControl( dialog, itemHit, &tempControl );
		switch ( itemHit )
		{
			case kProgIndeterminateCheck:
				SetControlValue( tempControl, !GetControlValue( tempControl ) );
				break;
		}
	}
	
	if ( itemHit == kProgCancelButton )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
	GetDialogItemAsControl( dialog, kProgIndeterminateCheck, &tempControl );
	indeterminate = ( GetControlValue( tempControl ) == 1 );

	GetDialogItem( dialog, kProgLengthText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &number );
	bounds.right = number;
	
	DisposeDialog( dialog );
	
	control = NewControl( window, &bounds, "\p", false, 50, 0, 100, kControlProgressBarProc, 0 );
	if ( control == nil ) return nil;
	
	if ( indeterminate )
		SetProgressIndicatorState( control, false );
		
	return control;
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä CreateLittleArrows													PUBLIC
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Creates the little arrows CDEF. We just use a standard size - no options.
//
ControlHandle
CreateLittleArrows( WindowPtr window )
{
	Rect		bounds = { 0, 0, 24, 13 };
	
	return NewControl( window, &bounds, "\p", false, 0, 0, 100, kControlLittleArrowsProc, 0 );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä CreateGroupBox															PUBLIC
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Creates a group box.
//
ControlHandle
CreateGroupBox( WindowPtr window )
{
	enum { kPrimary, kSecondary };
	enum { kText = 1, kCheckBox, kPopup };
	
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	SInt16			type;
	Handle			handle;
	Rect			rect;
	Rect			bounds = { 0, 0, 16, 0 };
	ControlKeyFilterUPP	filterProc;
	Str255			text, title;
	SInt32			height, width, min, max, value;
	SInt16			procID;
	ControlHandle	tempControl;
	
	dialog = GetNewDialog( 2007, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	filterProc = NewControlKeyFilterUPP( NumericFilter );

	GetDialogItemAsControl( dialog, kGroupMenuIDLabelText, &tempControl );
	DeactivateControl( tempControl );
	GetDialogItemAsControl( dialog, kGroupMenuIDText, &tempControl );
	DeactivateControl( tempControl );

	GetDialogItemAsControl( dialog, kGroupMenuIDText, &tempControl );
	SetEditTextKeyFilter( tempControl, filterProc );
	GetDialogItemAsControl( dialog, kGroupHeightText, &tempControl );
	SetEditTextKeyFilter( tempControl, filterProc );
	GetDialogItemAsControl( dialog, kGroupWidthText, &tempControl );
	SetEditTextKeyFilter( tempControl, filterProc );

	SetDialogDefaultItem( dialog, kGroupOKButton );
	SetDialogCancelItem( dialog, kGroupCancelButton );
	
	while ( itemHit != kGroupCancelButton && itemHit != kGroupOKButton )
	{
		ModalDialog( nil, &itemHit );
		
		GetDialogItemAsControl( dialog, itemHit, &tempControl );
		switch ( itemHit )
		{
			case kGroupVariantPopup:
				if ( GetControlValue( tempControl ) == kPopup )
				{
					GetDialogItemAsControl( dialog, kGroupMenuIDLabelText, &tempControl );
					ActivateControl( tempControl );
					GetDialogItemAsControl( dialog, kGroupMenuIDText, &tempControl );
					ActivateControl( tempControl );
				}
				else
				{
					GetDialogItemAsControl( dialog, kGroupMenuIDLabelText, &tempControl );
					DeactivateControl( tempControl );
					GetDialogItemAsControl( dialog, kGroupMenuIDText, &tempControl );
					DeactivateControl( tempControl );
				}
		}
	}
	DisposeControlKeyFilterUPP( filterProc );
	
	if ( itemHit == kGroupCancelButton )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
		// Add the primary/secondary variant bit in
		
	procID = kControlGroupBoxTextTitleProc;
	
	GetDialogItemAsControl( dialog, kGroupRadioGroup, &tempControl );
	if ( GetControlValue( tempControl ) == 2 )
		procID |= 4;
	
		// Calculate the bounding rectangle based on width/height
		
	GetDialogItem( dialog, kGroupHeightText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &height );
	GetDialogItem( dialog, kGroupWidthText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &width );

	bounds.bottom = height;
	bounds.right = width;
	
		// Get the title of the control
		
	GetDialogItem( dialog, kGroupTitleText, &type, &handle, &rect );
	GetDialogItemText( handle, title );
	
	min = max = value = 0;
	
	GetDialogItemAsControl( dialog, kGroupVariantPopup, &tempControl );
	switch ( GetControlValue( tempControl ) )
	{
		case kCheckBox:
			procID |= 1;
			break;
		
		case kPopup:
			procID |= 2;
			GetDialogItem( dialog, kGroupMenuIDText, &type, &handle, &rect );
			GetDialogItemText( handle, text );
			StringToNum( text, &min );
			break;
	}			
	DisposeDialog( dialog );

	return NewControl( window, &bounds, title, false, value, min, max, procID, 0 );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä CreatePlacard															PUBLIC
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	This routine creates a placard in any size the user wants.
//
ControlHandle
CreatePlacard( WindowPtr window )
{
	DialogPtr			dialog;
	SInt16				itemHit = 0;
	ControlHandle		control = nil;
	SInt16				type;
	Handle				handle;
	Rect				rect;
	Rect				bounds = { 0, 0, 0, 0 };
	Str255				text;
	SInt32				number;
	ControlKeyFilterUPP	filterProc;
	ControlHandle		tempControl;
	
	dialog = GetNewDialog( 2008, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	filterProc = NewControlKeyFilterUPP( NumericFilter );

	GetDialogItemAsControl( dialog, kPlacardHeightText, &tempControl );
	SetEditTextKeyFilter( tempControl, filterProc );
	GetDialogItemAsControl( dialog, kPlacardWidthText, &tempControl );
	SetEditTextKeyFilter( tempControl, filterProc );

	SetDialogDefaultItem( dialog, kPlacardOKButton );
	SetDialogCancelItem( dialog, kPlacardCancelButton );
		
	while ( itemHit != kPlacardCancelButton && itemHit != kPlacardOKButton )
	{
		ModalDialog( nil, &itemHit );
	}
	DisposeControlKeyFilterUPP( filterProc );
	
	if ( itemHit == kPlacardCancelButton )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
	GetDialogItem( dialog, kPlacardHeightText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &number );
	bounds.bottom = number;
	
	GetDialogItem( dialog, kPlacardWidthText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &number );
	bounds.right = number;
	
	DisposeDialog( dialog );
	
	control = NewControl( window, &bounds, "\p", false, 0, 0, 0, kControlPlacardProc, 0 );
	if ( control == nil ) return nil;
	
	return control;
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä CreatePopupArrow														PUBLIC
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	This routine creates a popup arrow in any direction and size the user wants.
//
ControlHandle
CreatePopupArrow( WindowPtr window )
{
	enum { kEast = 1, kWest, kNorth, kSouth };
	
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	Rect			bounds = { 0, 0, 50, 50 };
	SInt16			procID;
	ControlHandle	tempControl;
	
	dialog = GetNewDialog( 2009, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	SetDialogDefaultItem( dialog, kPopArrowOKButton );
	SetDialogCancelItem( dialog, kPopArrowCancelButton );
		
	while ( itemHit != kPopArrowCancelButton && itemHit != kPopArrowOKButton )
	{
		ModalDialog( nil, &itemHit );
		
		GetDialogItemAsControl( dialog, itemHit, &tempControl );
		switch ( itemHit )
		{
			case kPopArrowSmallCheck:
				SetControlValue( tempControl, !GetControlValue( tempControl ) );
				break;
		}
	}
	
	if ( itemHit == kPopArrowCancelButton )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
	procID = kControlPopupArrowEastProc;

	GetDialogItemAsControl( dialog, kPopArrowSmallCheck, &tempControl );
	if ( GetControlValue( tempControl ) == 1 )
		procID |= 4;

	GetDialogItemAsControl( dialog, kPopArrowDirPopup, &tempControl );
	switch ( GetControlValue( tempControl ) )
	{
		case kEast:
			break;
		
		case kWest:
			procID |= 1;
			break;
		
		case kNorth:
			procID |= 2;
			break;
		
		case kSouth:
			procID |= 3;
			break;
	}
	
	DisposeDialog( dialog );
	
	return(NewControl( window, &bounds, "\p", false, 0, 0, 0, procID, 0 ));
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä CreateScrollBar													PUBLIC
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Creates a scroll bar.
//
ControlHandle
CreateScrollBar( WindowPtr window )
{
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	SInt16			type;
	Handle			handle;
	Rect			rect;
	SInt32			length;
	Str255			text;
	Rect			bounds = { 0, 0, 16, 16 };
	ControlHandle	tempControl;
	
	dialog = GetNewDialog( 2010, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	SetDialogDefaultItem( dialog, kScrollOKButton );
	SetDialogCancelItem( dialog, kScrollCancelButton );
		
	while ( itemHit != kScrollCancelButton && itemHit != kScrollOKButton )
	{
		ModalDialog( nil, &itemHit );
	}
	
	if ( itemHit == kScrollCancelButton )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
	GetDialogItem( dialog, kScrollLengthText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &length );
	
	GetDialogItemAsControl( dialog, kScrollRadioGroup, &tempControl );
	if ( GetControlValue( tempControl ) == 1 )
		bounds.right = length;
	else
		bounds.bottom = length;
	
	DisposeDialog( dialog );
	
	return(NewControl( window, &bounds, "\p", false, 0, 0, 100, kControlScrollBarProc, 0 ));
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä CreateTabs														PUBLIC
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Creates a standard push button.
//
ControlHandle
CreateTabs( WindowPtr window )
{
	enum { kEast = 1, kWest, kNorth, kSouth };

	DialogPtr		dialog;
	SInt16			itemHit = 0;
	ControlHandle	control = nil;
	ControlHandle		handle;
	Str255			text;
	Rect			bounds = { 0, 0, 100, 300 };
	Boolean			useIcons;
	ControlKeyFilterUPP	filterProc;
	SInt16			procID = 0;
	short			i;
	ControlTabInfoRec infoRec;
	SInt32			numTabs;
	unsigned char			*titles[4] = {"\pA","\pBunch","\pOf","\pTitles."};
	
	dialog = GetNewDialog( 2018, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	SetDialogDefaultItem( dialog, kStdOkItemIndex );
	SetDialogCancelItem( dialog, kStdCancelItemIndex );

	filterProc = NewControlKeyFilterUPP( NumericFilter );

	GetDialogItemAsControl( dialog, kTabNumberTabs, &control );
	SetEditTextKeyFilter( control, filterProc );
		
	while ( itemHit != kStdCancelItemIndex && itemHit != kStdOkItemIndex )
	{
		ModalDialog( nil, &itemHit );
		
		GetDialogItemAsControl( dialog, itemHit, &handle );
		if (itemHit == kTabUseIcon)
			SetControlValue( (ControlHandle)handle, !GetControlValue( (ControlHandle)handle ) );
	}
	
	if ( itemHit == kStdCancelItemIndex )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
	GetDialogItemAsControl( dialog, kTabNumberTabs, &handle );
	GetDialogItemText( (Handle) handle, text );
	StringToNum( text, &numTabs );
	
	// determine which direction the user chose from the popup
	GetDialogItemAsControl( dialog, kTabDirectionPopup, &handle);
	switch (GetControlValue(handle))
		{
			case kEast:  procID = kControlTabLargeEastProc;
						 break;

			case kWest:  procID = kControlTabLargeWestProc;
						 break;

			case kNorth: procID = kControlTabLargeNorthProc;
						 break;

			case kSouth: procID = kControlTabLargeSouthProc;
						 break;
		}
						 
	
	
	GetDialogItemAsControl( dialog, kTabSizeGroup, &handle);
	
	if (GetControlValue(handle) != 1)
		procID |= 1; // small variants are one higher than the large variants, and large ones are even.

	GetDialogItemAsControl( dialog, kTabUseIcon, &handle);
	
	useIcons = GetControlValue(handle);

	DisposeDialog( dialog );
	
	control = NewControl( window, &bounds, text, false, 0, 0, numTabs, procID, 0 );
	if ( control == nil ) return nil;

	/**	now set the tab names manually (rather than via a tab# resource. The number of Tabs was set in the NewControl maximum parameter**/
		
	infoRec.version = kControlTabInfoVersionZero;
	infoRec.iconSuiteID = useIcons ? 128 : 0;
	
	for(i=1;i<=numTabs;i++)
		{
			// cycle through the sample titles
//			memcpy(&infoRec.name,titles[(i-1) % 4], *titles[(i-1) % 4]+1);
			BlockMove(titles[(i-1) % 4], &infoRec.name, *titles[(i-1) % 4]+1);
								 
			SetControlData(control, i, kControlTabInfoTag, sizeof(ControlTabInfoRec), (Ptr) &infoRec);
		}
	
	return control;
}




//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä CreatePushButton														PUBLIC
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Creates a standard push button.
//
ControlHandle
CreatePushButton( WindowPtr window )
{
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	ControlHandle	control = nil;
	SInt16			type;
	Handle			handle;
	Rect			rect;
	Str255			text;
	Rect			bounds = { 0, 0, 22, 22 };
	Boolean			isDefault;
	SInt16			baseLine;
	ControlHandle	tempControl;
	
	dialog = GetNewDialog( 2012, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	SetDialogDefaultItem( dialog, kPushButtonOKButton );
	SetDialogCancelItem( dialog, kPushButtonCancelButton );
		
	while ( itemHit != kPushButtonCancelButton && itemHit != kPushButtonOKButton )
	{
		ModalDialog( nil, &itemHit );
		
		GetDialogItem( dialog, itemHit, &type, &handle, &rect );
		switch ( itemHit )
		{
			case kPushButtonDefaultCheck:
				SetControlValue( (ControlHandle)handle, !GetControlValue( (ControlHandle)handle ) );
				break;
		}
	}
	
	if ( itemHit == kPushButtonCancelButton )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
	GetDialogItem( dialog, kPushButtonTitleText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	
	GetDialogItemAsControl( dialog, kPushButtonDefaultCheck, &tempControl );
	isDefault = (GetControlValue( tempControl ) == 1 );
		
	DisposeDialog( dialog );
	
	control = NewControl( window, &bounds, text, false, 0, 0, 1, kControlPushButtonProc, 0 );
	if ( control == nil ) return nil;
	
	if ( isDefault )
	{
		SetControlData( control, 0, kControlPushButtonDefaultTag, sizeof( isDefault ),
			(Ptr)&isDefault );
	}
	
	if ( GetBestControlRect( control, &bounds, &baseLine ) == noErr )
		SetControlBounds( control, &bounds );
	
	return control;
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä CreateCheckBox															PUBLIC
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Creates a standard check box.
//
ControlHandle
CreateCheckBox( WindowPtr window )
{
	return CreateCheckBoxOrRadioButton( window, kControlCheckBoxProc );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä CreateRadioButton															PUBLIC
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Creates a standard radio button.
//
ControlHandle
CreateRadioButton( WindowPtr window )
{
	return CreateCheckBoxOrRadioButton( window, kControlRadioButtonProc );
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä CreateCheckBoxOrRadioButton												PRIVATE
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Creates a standard check box or radio button.
//
static ControlHandle
CreateCheckBoxOrRadioButton( WindowPtr window, SInt16 procID )
{
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	ControlHandle	control = nil;
	Handle			handle;
	Str255			text;
	Rect			bounds = { 0, 0, 22, 22 };
	SInt16			baseLine;
	Boolean 		doAutoToggle;
	
	dialog = GetNewDialog( 2013, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	GetDialogItemAsControl(dialog, kCheckBoxTitleText, (ControlHandle *) &handle);
	
	if ( procID == kControlCheckBoxProc )
		{
			SetWTitle( (WindowPtr) dialog, "\pCheck Box" );
			SetDialogItemText( handle, "\pCheck Box");
		}
	else
		{
			SetWTitle( (WindowPtr) dialog, "\pRadio Button" );
			SetDialogItemText( handle, "\pRadio Button");
		}

	SetDialogDefaultItem( dialog, kCheckBoxOKButton );
	SetDialogCancelItem( dialog, kCheckBoxCancelButton );
		
	ShowWindow( GetDialogWindow( dialog ) );
	
	while ( itemHit != kCheckBoxCancelButton && itemHit != kCheckBoxOKButton )
	{
		ModalDialog( nil, &itemHit );
		
		if (itemHit == 5)
			{
				GetDialogItemAsControl(dialog, 5, (ControlHandle *) &handle);
				SetControlValue((ControlHandle) handle, !GetControlValue((ControlHandle) handle));
			}
	}
	
	if ( itemHit == kCheckBoxCancelButton )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
	GetDialogItemAsControl(dialog, kCheckBoxTitleText, (ControlHandle *) &handle);
	GetDialogItemText( handle, text );

	GetDialogItemAsControl(dialog, 5, (ControlHandle *) &handle);
	doAutoToggle = GetControlValue((ControlHandle) handle) == 1;
	
	DisposeDialog( dialog );

	if (doAutoToggle)
		{
			if (procID == kControlCheckBoxProc)
				procID = kControlCheckBoxAutoToggleProc;	// the procIDs are a constant 2 apart now, but this is more
			else											// readable and will allow simple recompilation if the procIDs change
				procID = kControlRadioButtonAutoToggleProc;
		}
	
	control = NewControl( window, &bounds, text, false, 0, 0, 2, procID, 0 );
	if ( control == nil ) return nil;
	
	if ( GetBestControlRect( control, &bounds, &baseLine ) == noErr )
		SetControlBounds( control, &bounds );
	
	return control;
}


//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä CreateImageWell														PUBLIC
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	This routine creates an image well.
//
ControlHandle
CreateImageWell( WindowPtr window )
{
	DialogPtr		dialog;
	SInt16			itemHit = 0;
	SInt16			type;
	Handle			handle;
	Rect			rect;
	Rect			bounds = { 0, 0, 0, 0 };
	Str255			text;
	SInt32			number;
	SInt32			resID, min = 0;
	ControlKeyFilterUPP	filterProc;
	ControlHandle	tempControl;
	
	dialog = GetNewDialog( 2011, nil, (WindowPtr)-1L );
	if ( dialog == nil ) return nil;

	filterProc = NewControlKeyFilterUPP( NumericFilter );

	GetDialogItemAsControl( dialog, kImageHeightText, &tempControl );
	SetEditTextKeyFilter( tempControl, filterProc );

	GetDialogItemAsControl( dialog, kImageWidthText, &tempControl );
	SetEditTextKeyFilter( tempControl, filterProc );

	GetDialogItemAsControl( dialog, kImageResIDText, &tempControl );
	SetEditTextKeyFilter( tempControl, filterProc );

	SetDialogDefaultItem( dialog, kImageOKButton );
	SetDialogCancelItem( dialog, kImageCancelButton );
		
	while ( itemHit != kImageCancelButton && itemHit != kImageOKButton )
	{
		ModalDialog( nil, &itemHit );
	}
	DisposeControlKeyFilterUPP( filterProc );
	
	if ( itemHit == kImageCancelButton )
	{
		DisposeDialog( dialog );
		return nil;
	}
	
	GetDialogItem( dialog, kImageHeightText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &number );
	bounds.bottom = number;
	
	GetDialogItem( dialog, kImageWidthText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &number );
	bounds.right = number;
	
	GetDialogItem( dialog, kImageResIDText, &type, &handle, &rect );
	GetDialogItemText( handle, text );
	StringToNum( text, &resID );
	
	GetDialogItemAsControl( dialog, kImageContentPopup, &tempControl );
	switch ( GetControlValue( tempControl ) )
	{
		case 1:
			min = kControlContentIconSuiteRes;
			break;
		
		case 2:
			min = kControlContentCIconRes;
			break;
		
		case 3:
			min = kControlContentPictRes;
			break;	
	}
	
	DisposeDialog( dialog );
	
	return NewControl( window, &bounds, "\p", false, resID, min, 0, kControlImageWellProc, 0 );
}

ControlHandle
CreateList(WindowPtr window)
{
	ControlHandle myListControl;
	Rect			bounds = { 50, 50, 200, 200 };
	AlertStdAlertParamRec myAlertParam = {true, false, nil, "\pListBox", "\pListBoxAutoSize",nil, 1, 0, kWindowDefaultPosition};
	SInt16 outItemHit,procID;

#if !CARBON	
	StandardAlert(kAlertPlainAlert, "\pWould you like it to use kControlListBoxProc or kControlListBoxAutoSizeProc?",nil, 
					&myAlertParam, &outItemHit);
#else
	outItemHit = 1;
#endif

	if (outItemHit == 1)
		procID = kControlListBoxProc;
	else
		procID = kControlListBoxAutoSizeProc;
	
	myListControl = NewControl(window, &bounds, "\pList", false, 128, 0, 0, procID, 0);
	if (myListControl)
	{
		ListHandle theList;
		Size actualSize;
		OSErr theError;
		
		theError = GetControlData(myListControl, kControlNoPart, kControlListBoxListHandleTag, 4, (Ptr) &theList, &actualSize);
		
		if (theError == noErr)
		{
			short i,j;
			Str255 theString;
			long theNum=1;
			Cell whichCell;
			
			for(i=0; i<30; i++)
				for(j=0; j<30; j++)
					{
						NumToString(theNum, theString);
						theNum++;
						whichCell.h = i;
						whichCell.v = j;
						LSetCell(&theString[1], theString[0],whichCell, theList);
					}
		}
	}
	return (myListControl);
}



//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä GetIconSize															UTILITY
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	This routine attempts to get the height and width of the icon specified by resID.
//	It assumes that ICONs are always 32x32. For cicns, we go into the resource and look
//	at the pixmap's bounding rectangle.
//
static void
GetPictureSize( SInt16 resID, SInt32* height, SInt32* width )
{
	PicHandle		picture;
	
	*height = 0;
	*width = 0;
	
	picture = GetPicture( resID );
	if ( picture == nil ) return;
	
	*height = (**picture).picFrame.bottom - (**picture).picFrame.top;
	*width = (**picture).picFrame.right - (**picture).picFrame.left;
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä GetIconSize															UTILITY
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	This routine attempts to get the height and width of the icon specified by resID.
//	It assumes that ICONs are always 32x32. For cicns, we go into the resource and look
//	at the pixmap's bounding rectangle.
//
static void
GetIconSize( SInt16 resID, SInt32* height, SInt32* width )
{
	Handle		icon;
	
	*height = 0;
	*width = 0;
	
	icon = GetResource( 'ICON', resID );
	if ( icon == nil )
	{
		icon = GetResource( 'cicn', resID );
		if ( icon == nil ) return;
	
		*height = (**(CIconHandle)icon).iconPMap.bounds.bottom - (**(CIconHandle)icon).iconPMap.bounds.top;
		*width = (**(CIconHandle)icon).iconPMap.bounds.right - (**(CIconHandle)icon).iconPMap.bounds.left;
	}
	else
	{	
		*height = *width = 32;
	}
}

//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä NumericFilter															PUBLIC
//ãããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	This function is a key filter for edit text fields. It ensures that all input is
//	numeric. It also allows editing keys to pass thru so that the edit text actually
//	remains editable!
//
pascal ControlKeyFilterResult
NumericFilter( ControlHandle control, SInt16* keyCode, SInt16* charCode, EventModifiers* modifiers )
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
			return kControlKeyFilterBlockKey;
	}
}

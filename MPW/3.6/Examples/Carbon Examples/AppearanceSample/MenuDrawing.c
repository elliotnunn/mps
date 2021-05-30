/*
	File:		MenuDrawing.c

	Contains:	Code to demonstrate menu drawing routines of the Appearance Manager.

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
#include <MacWindows.h>
#include <Appearance.h>
#endif	// __MRC__

void	DrawMenuStuff();
static pascal void	DrawMenuTitle( const Rect* bounds, SInt16 depth, Boolean colorDevice, long userData );
static void	DrawPhonyMenu();

static WindowPtr 	gMenuWindow = nil;
static Str255		gMenuItems[] =
					{
						"\pFirst Item",
						"\pSecond Item",
						"\pThird Item",
						"\p-",
						"\pFourth Item",
						"\pFifth Item"
					};
static ThemeMenuItemType	gMenuItemTypes[] =
					{
						kThemeMenuItemScrollUpArrow,
						kThemeMenuItemHierarchical,
						kThemeMenuItemPlain,
						kThemeMenuItemPlain,
						kThemeMenuItemPlain,
						kThemeMenuItemScrollDownArrow
					};

#if TARGET_RT_MAC_CFM
MenuTitleDrawingUPP	sDrawMenuTitleProc	= NewMenuTitleDrawingUPP( DrawMenuTitle );
#define DrawMenuTitleProc_()		&sDrawMenuTitleProc
#else
#define DrawMenuTitleProc_()		DrawMenuTitle
#endif

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä DrawMenuStuff
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Draws the menu bar, menu background, etc. for the current theme.
//
void
DrawMenuStuff()
{
	Rect					bounds, menuBarRect;
	UInt32					junk;
	Rect					tempRect, portRect;
	SInt16					height, widthExtra;
	OSErr					err;
	CGrafPtr				port;
	MenuTitleDrawingUPP		menuTitleDrawUPP;

	if ( gMenuWindow == nil )
	{
		gMenuWindow = GetNewCWindow( 200, nil, (WindowPtr)-1L );
		if ( gMenuWindow == nil ) return;
	}

	port = GetWindowPort( gMenuWindow );
	SetPort( port );
    GetPortBounds( port, &portRect );
    EraseRect( &portRect );
	
	TextFont( 0 );
	TextSize( 0 );
	
	bounds = portRect;
	InsetRect( &bounds, 60, 60 );

	GetThemeMenuBarHeight( &height );

	menuBarRect = bounds;
	menuBarRect.bottom = menuBarRect.top + height;
	
		// Draw a blank normal menu bar
		
	DrawThemeMenuBarBackground( &menuBarRect, kThemeMenuBarNormal, 0 );
	Delay( 60, &junk );

		// Draw a blank hilited menu bar
		
	DrawThemeMenuBarBackground( &menuBarRect, kThemeMenuBarSelected, 0 );
	Delay( 60, &junk );

		// Draw a menu bar with one menu title
		
	DrawThemeMenuBarBackground( &menuBarRect, kThemeMenuBarNormal, 0 );
	
	menuTitleDrawUPP = NewMenuTitleDrawingUPP( DrawMenuTitle );
	
	GetThemeMenuTitleExtra( &widthExtra, false );
	tempRect = menuBarRect;
	tempRect.left += 10;
	tempRect.right = tempRect.left + widthExtra + StringWidth( "\pFile" );
	DrawThemeMenuTitle( &menuBarRect, &tempRect, (UInt16)kThemeMenuActive, 0, menuTitleDrawUPP, (long)"\pFile" );
	Delay( 60, &junk );

		// Draw a menu bar with one selected title
		
	DrawThemeMenuBarBackground( &menuBarRect, kThemeMenuBarNormal, 0 );
	tempRect = menuBarRect;
	tempRect.left += 10;
	tempRect.right = tempRect.left + widthExtra + StringWidth( "\pFile" );
	err = DrawThemeMenuTitle( &menuBarRect, &tempRect, (UInt16)kThemeMenuSelected, 0, menuTitleDrawUPP, (long)"\pFile" );
	Delay( 60, &junk );

		// Draw a menu bar with one disabled title
		
	DrawThemeMenuBarBackground( &menuBarRect, kThemeMenuBarNormal, 0 );
	tempRect = menuBarRect;
	tempRect.left += 10;
	tempRect.right = tempRect.left + widthExtra + StringWidth( "\pFile" );
	err = DrawThemeMenuTitle( &menuBarRect, &tempRect, (UInt16)kThemeMenuDisabled, 0, menuTitleDrawUPP, (long)"\pFile" );
	Delay( 60, &junk );

	EraseRect( &portRect );
	tempRect = bounds;
	DrawThemeMenuBackground( &tempRect, kThemeMenuTypePullDown );
	Delay( 60, &junk );

	EraseRect( &portRect );
	tempRect = bounds;
	DrawThemeMenuBackground( &tempRect, kThemeMenuTypePopUp );
	Delay( 60, &junk );

	EraseRect( &portRect );
	tempRect = bounds;
	DrawThemeMenuSeparator( &tempRect );
	

	SInt16 theHeight, theWidth;
	GetThemeMenuSeparatorHeight( &theHeight );	
	GetThemeMenuItemExtra( kThemeMenuItemPlain, &theHeight, &theWidth );

	Delay( 60, &junk );

	Rect	temp2;
	
	EraseRect( &portRect );
	tempRect = bounds;
	temp2 = tempRect;
//	InsetRect( &temp2, 0, 20 );
	DrawThemeMenuItem( &temp2, &tempRect, temp2.top, temp2.bottom, kThemeMenuActive, kThemeMenuItemPlain, nil, 0 );
	Delay( 60, &junk );
	DrawThemeMenuItem( &temp2, &tempRect, temp2.top, temp2.bottom, kThemeMenuSelected, kThemeMenuItemPlain, nil, 0 );
	Delay( 60, &junk );
	
	EraseRect( &portRect );
	DrawPhonyMenu();
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä DrawMenuTitle
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Draws the menu title centered in the rectangle passed.
//
static pascal void
DrawMenuTitle( const Rect* bounds, SInt16 depth, Boolean colorDevice, long userData )
{
	#pragma unused( depth, colorDevice )
	
	short			height, space, h, v;
	short			charHeight;
	FontInfo		fontInfo;
	StringPtr		string = (StringPtr)userData;
	
	height = bounds->bottom - bounds->top;
	space = bounds->right - bounds->left;
	
	GetFontInfo( &fontInfo );
	
	h = bounds->left;
	charHeight = fontInfo.ascent + fontInfo.descent;
	v = ( height - charHeight ) / 2 + bounds->top + fontInfo.ascent;
	MoveTo( h, v );

	DrawString( string );
}

//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Ä DrawPhonyMenu
//ããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããããã
//	Draws a menu complete with items. It uses the Appearance Manager routines to calculate
//	the item width and height and also iterates over each item, hiliting and unhiliting it.
//
static void
DrawPhonyMenu()
{
	Rect					menuRect, itemRect;
	SInt16					height, width, temp;
	SInt16					i, itemHeight;
	SInt16					extraHeight, extraWidth, sepHeight, maxExtraWidth;
	FontInfo				fontInfo;
	UInt32					junk;
	MenuItemDrawingUPP		menuItemDrawUPP;
		// Calculate the width and height of our menu.
	
	GetFontInfo( &fontInfo );
	GetThemeMenuSeparatorHeight( &sepHeight );
	
	height = 0;
	width = 0;
	maxExtraWidth = 0;
	
	itemHeight = fontInfo.ascent + fontInfo.descent + fontInfo.leading;
	
	for ( i = 1; i <= 6; i++ )
	{
		if ( gMenuItems[ i - 1 ][1] != '-' )
		{
				// Depending on the type of menu item background you're going
				// to draw, the width may differ. We must make sure we've use the biggest
				// extraWidth we get, so call GetThemeMenuItemExtra each time thru.
				
			GetThemeMenuItemExtra( gMenuItemTypes[ i-1 ],  &extraHeight, &extraWidth );

			temp = StringWidth( gMenuItems[ i - 1 ] );
			if ( temp > width )
				width = temp;
			
			if ( extraWidth > maxExtraWidth )
				maxExtraWidth = extraWidth;
			
			height += (itemHeight + extraHeight);
		}
		else
			height += sepHeight;
	}
	
	width += maxExtraWidth;
	
		// OK, now that we've gotten our height and width, lets draw the menu
		// background for fun.
		
	menuRect.top = 10;
	menuRect.left = 10;
	menuRect.bottom = menuRect.top + height;
	menuRect.right = menuRect.left + width;
	
	DrawThemeMenuBackground( &menuRect, kThemeMenuTypePullDown );
	
		// Now let's draw each item, using the calculations made above. Here
		// we assume that the itemHeights are all the same, but we could have
		// stored the heights and used each individual item's height.
		
	itemRect = menuRect;
	itemRect.bottom = itemRect.top;
	
	menuItemDrawUPP = NewMenuItemDrawingUPP( DrawMenuTitle );
	
	for ( i = 1; i <= 6; i++ )
	{
		if ( gMenuItems[ i - 1 ][1] != '-' )
		{
			itemRect.bottom = itemRect.top + itemHeight + extraHeight;
			DrawThemeMenuItem( &menuRect, &itemRect, menuRect.top, menuRect.bottom, (UInt16)kThemeMenuActive, gMenuItemTypes[ i-1 ], menuItemDrawUPP, (long)&gMenuItems[ i - 1] );
		}
		else
		{
			itemRect.bottom = itemRect.top + sepHeight;
			DrawThemeMenuSeparator( &itemRect );
		}
		itemRect.top = itemRect.bottom;
	}
	Delay( 60, &junk );
	
		// Swell, now let's step thru each item, drawing it in the selected, active,
		// disabled, and then in the active state again.
		
	itemRect = menuRect;
	itemRect.bottom = itemRect.top;
	
	for ( i = 1; i <= 6; i++ )
	{
		if ( gMenuItems[ i - 1 ][1] != '-' )
		{
			itemRect.bottom = itemRect.top + itemHeight + extraHeight;
			DrawThemeMenuItem( &menuRect, &itemRect, menuRect.top, menuRect.bottom, (UInt16)kThemeMenuSelected, gMenuItemTypes[ i-1 ], menuItemDrawUPP,  (long)&gMenuItems[ i - 1] );
			Delay( 30, &junk );
			DrawThemeMenuItem( &menuRect, &itemRect, menuRect.top, menuRect.bottom, (UInt16)kThemeMenuActive, gMenuItemTypes[ i-1 ], menuItemDrawUPP,  (long)&gMenuItems[ i - 1] );
			Delay( 30, &junk );
			DrawThemeMenuItem( &menuRect, &itemRect, menuRect.top, menuRect.bottom, (UInt16)kThemeMenuDisabled, gMenuItemTypes[ i-1 ], menuItemDrawUPP,  (long)&gMenuItems[ i - 1] );
			Delay( 30, &junk );
			DrawThemeMenuItem( &menuRect, &itemRect, menuRect.top, menuRect.bottom, (UInt16)kThemeMenuActive, gMenuItemTypes[ i-1 ], menuItemDrawUPP,  (long)&gMenuItems[ i - 1] );
			Delay( 30, &junk );
		}
		else
		{
			itemRect.bottom = itemRect.top + sepHeight;
			DrawThemeMenuSeparator( &itemRect );
		}
		itemRect.top = itemRect.bottom;
	}
}

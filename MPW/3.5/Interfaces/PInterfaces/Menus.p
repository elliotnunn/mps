{
     File:       Menus.p
 
     Contains:   Menu Manager Interfaces.
 
     Version:    Technology: Carbon
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Menus;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MENUS__}
{$SETC __MENUS__ := 1}

{$I+}
{$SETC MenusIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __FONTS__}
{$I Fonts.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __PROCESSES__}
{$I Processes.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __COLLECTIONS__}
{$I Collections.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}



{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{
 *  Menu Manager
 }
{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Constants                                                                    }
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	noMark						= 0;							{  mark symbol for SetItemMark; other mark symbols are defined in Fonts.h  }

	{	
	    A Short Course on Menu Definition Functions
	    
	    A menu definition function is used to implement a custom visual appearance for a menu.
	    Menu definition functions are still supported in Carbon, but the messages sent to a
	    menu definition function in Carbon are different than for a non-Carbon application.
	    
	    In general, Apple recommends using the system menu definition whenever possible.
	    Menu definition functions will continue to be supported, but it is not easy to write
	    a correct menu definition, especially one that attempts to imitate the standard system
	    menu appearance. If you require special features in your menu that the system menu
	    definition does not support, please mail <toolbox@apple.com> and describe your requirements;
	    we would much rather enhance the system menu definition than have you write a custom one.
	    
	    Menu definition functions before Carbon used the following messages:
	    
	        kMenuDrawMsg
	        kMenuChooseMsg
	        kMenuSizeMsg
	        kMenuPopUpMsg
	        kMenuDrawItemMsg
	        kMenuCalcItemMsg
	        kMenuThemeSavvyMsg
	        
	    kMenuChooseMsg and kMenuDrawItemMsg are not supported in Carbon and are not sent to
	    Carbon menu definitions. In Carbon, kMenuChooseMsg is replaced by kMenuFindItemMsg and
	    kMenuHiliteItemMsg. Menu definition functions in Carbon use the following messages:
	    
	        kMenuInitMsg
	        kMenuDisposeMsg
	        kMenuFindItemMsg
	        kMenuHiliteItemMsg
	        kMenuDrawItemsMsg
	        kMenuDrawMsg
	        kMenuSizeMsg
	        kMenuPopUpMsg
	        kMenuCalcItemMsg
	        kMenuThemeSavvyMsg
	        
	    The rest of this documentation will focus on Carbon menu definitions only.
	    
	    Menu Definition Messages
	    
	        Carbon menu definition functions should support the following messages:
	        
	        kMenuInitMsg
	            
	            menuRect        unused
	            hitPt           unused
	            whichItem       OSErr*
	        
	            Sent when a menu is created. This message gives the menu definition an opportunity
	            to initialize its own state. If the menu definition encounters an error while
	            initializing, it should set *whichItem to a non-zero error code; this will cause the
	            Menu Manager to destroy the menu and return an error back from the API that was used
	            to create the menu.
	        
	        kMenuDisposeMsg
	            
	            menuRect        unused
	            hitPt           unused
	            whichItem       unused
	            
	            Sent when a menu is destroyed. This message gives the menu definition an opportunity
	            to destroy its own data.
	            
	        kMenuFindItemMsg
	            
	            menuRect        menu bounds
	            hitPt           point to hit-test
	            whichItem       MenuTrackingData*
	            
	            Sent when the Menu Manager is displaying a menu and needs to know what item is under
	            the mouse. The whichItem parameter is actually a pointer to a MenuTrackingData structure.
	            On entry, the menu, virtualMenuTop, and virtualMenuBottom fields of this structure are
	            valid. The menu definition should determine which item containst the given point, if any,
	            and fill in the itemUnderMouse, itemSelected, and itemRect fields. If an item is found,
	            the menu definition should always fill in the itemUnderMouse and itemRect fields. The
	            menu definition should only fill in the itemSelected field if the item is available for
	            selection; if it is unavailable (because it is disabled, or for some other reason), the
	            menu definition should set the itemSelected field to zero.
	            
	            The values placed in the itemUnderMouse and itemSelected fields should be less than or
	            equal to the number of items returned by CountMenuItems on this menu.
	            
	            The menu definition should not hilite the found item during this message. The Menu 
	            Manager will send a separate kMenuHiliteItemMsg to request hiliting of the item.
	            
	            If the menu definition supports scrolling, it should scroll the menu during this message,
	            and update the virtualMenuTop and virtualMenuBottom fields of the MenuTrackingData to
	            indicate the menu's new scrolled position.
	            
	            The menu definition should not modify the menu field of the MenuTrackingData.
	            
	        kMenuHiliteItemMsg
	        
	            menuRect        menu bounds
	            hitPt           unused
	            whichItem       MDEFHiliteItemData*
	            
	            Sent when the Menu Manager is displaying a menu and needs to hilite a newly selected
	            item. The whichItem parameter is actually a pointer to a MDEFHiliteItemData structure.
	            The menu definition should unhilite the item in the previousItem field, if non-zero,
	            and hilite the item in the newItem field.
	            
	            If the menu definition uses QuickDraw to draw, it should draw into the current port.
	    
	            If the menu definition uses CoreGraphics to draw, it should create a CGContextRef based
	            on the current port and draw into that context.
	            
	        kMenuDrawItemsMsg
	        
	            menuRect        menu bounds
	            hitPt           unused
	            whichItem       MDEFDrawItemsData*
	            
	            Sent when the Menu Manager is displaying a menu and needs to redraw a portion of the
	            menu. This message is used by the dynamic menu item support code in the Menu Manager;
	            for example, if items five and six in a menu are a dynamic group, the Menu Manager will
	            send a DrawItems message when the group's modifier key is pressed or released to redraw
	            the appropriate item, but no other items in the menu.
	            
	            The whichItem parameter for this message is actually a pointer to a MDEFDrawItemsData
	            structure. The menu definition should redraw the items starting with firstItem and
	            ending with lastItem, inclusive.
	            
	            If the menu definition uses QuickDraw to draw, it should draw into the current port.
	    
	            If the menu definition uses CoreGraphics to draw, it should use the CGContextRef passed
	            in the context field of the MDEFDrawItemsData structure.
	            
	        kMenuDrawMsg
	            
	            menuRect        menu bounds
	            hitPt           unused
	            whichItem       MenuTrackingData*
	            
	            Sent when the Menu Manager is displaying a menu and needs to redraw the entire menu.
	            The whichItem parameter is actually a pointer to a MenuTrackingData structure. On entry,
	            the menu field of this structure is valid. The menu definition should draw the menu and,
	            if it supports scrolling, should also fill in the virtualMenuTop and virtualMenuBottom
	            fields of the structure to indicate the menu's initial unscrolled position; typically, 
	            virtualMenuTop would be set to the same value as the top coordinate of the menu rect,
	            and virtualMenuBottom would be set to virtualMenuTop plus the virtual height of the menu.
	            
	            If the menu definition uses QuickDraw to draw, it should draw into the current port.
	    
	            If the menu definition uses CoreGraphics to draw, it should create a CGContextRef based
	            on the current port and draw into that context.
	            
	        kMenuSizeMsg
	        
	            menuRect        unused
	            hitPt           maximum width and height of the menu
	            whichItem       unused
	            
	            Sent when the Menu Manager needs to determine the size of a menu. The menu definition
	            should calculate the width and height of the menu and store the sizes into the menu with
	            SetMenuWidth and SetMenuHeight.
	            
	            If the gestaltMenuMgrSendsMenuBoundsToDefProc bit is set in the Menu Manager's Gestalt
	            value, then the hitPt parameter to this message is the maximum width (hitPt.h) and height
	            (hitPt.v) of the menu. The menu defintion should ensure that the width and height that it
	            places in the menu do not exceed these values. If the gestalt bit is not set, the menu
	            definition should just use the main GDevice's width and height as constraints on the menu's
	            width and height.
	            
	        kMenuPopUpMsg
	        
	            menuRect        on entry, constraints on the menu's position; on exit, menu bounds
	            hitPt           requested menu location, with swapped coordinates
	            whichItem       on entry, requested initial selection; on exit, virtual menu top
	            
	            Sent when the Menu Manager is about to display a popup menu. The menu definition should
	            calculate the appropriate menu bounds to contain the menu based on the requested menu
	            location and selected item. It should write the menuBounds into the rect given by the
	            menuRect parameter.
	            
	            If the gestaltMenuMgrSendsMenuBoundsToDefProc bit is set in the Menu Manager's Gestalt
	            value, then the menuRect parameter on entry to this message contains a constraint rect,
	            in global coordinates, outside of which the popup menu should not be positioned. The menu
	            definition should take this constraint rect into account as it calculates the menu bounds.
	            If the gestalt bit is not set, the menu definition should use the bounds of the GDevice
	            containing the menu's top left corner as a constraint on the menu's position.
	            
	            The hitPt parameter is a requested location for the top left corner of the menu. The
	            coordinates of this parameter are swapped from their normal order; the h field of the
	            hitPt parameter contains the vertical coordinate, and the v field of hitPt contains
	            the horizontal coordinate.
	            
	            On entry, the whichItem parameter points at a menu item index which is requested to be
	            the initial selection when the menu is displayed. After calculating the menu's bounds,
	            the menu definition should write the menu's virtual top coordinate into the location
	            pointed at by the whichItem parameter. If displaying the menu at the requested location
	            does not require scrolling, the virtual top will be the same as the menu bounds top;
	            if the menu must scroll to fit in the requested location, the virtual top may be different.
	            
	        kMenuCalcItemMsg
	        
	            menuRect        on exit, item bounds
	            hitPt           unused
	            whichItem       the item whose rect to calculate
	            
	            Sent when the Menu Manager needs to know the bounds of a menu item. The menu definition
	            should calculate the size of the item specified by the whichItem parameter, and store 
	            the bounds in the rect specified by the menuRect parameter.
	            
	        kMenuThemeSavvyMsg
	        
	            menuRect        unused
	            hitPt           unused
	            whichItem       on exit, indicates theme-savvyness of the menu definition
	            
	            Sent by the Menu Manager to determine whether the MDEF uses the Appearance Manager 
	            menu-drawing functions to draw its menu. If it does, the menu definition should return
	            kThemeSavvyMenuResponse in the location pointed to by whichItem. If the menu definition
	            draws its own custom content without using the Appearance Manager menu-drawing functions,
	            it should ignore this message.
	    
	    Low-memory Global Replacements
	    
	        Pre-Carbon menu definitions needed to use several low-memory globals to communicate with the
	        Menu Manager. These globals have all been replaced or made obsolete in Carbon, as follows:
	        
	        MenuDisable
	            
	            MenuDisable is now set automatically by the Menu Manager using the value returned in the
	            itemUnderMouse field of the MenuTrackingData structure passed to kMenuFindItemMsg.
	            
	        TopMenuItem
	        AtMenuBottom
	        
	            TopMenuItem and AtMenuBottom are now set automatically by the Menu Manager using the
	            values returned in the virtualMenuTop and virtualMenuBottom fields of the MenuTrackingData
	            structure passed to kMenuDrawMsg and kMenuFindItemMsg.
	            
	        mbSaveLoc
	    
	            This undocumented low-memory global was used by pre-Carbon menu definitions to store
	            the bounding rect of the currently selected item and to avoid drawing glitches while
	            the menu definition was scrolling the contents of a menu that had submenus. The Menu
	            Manager now automatically sets the selected item bounds using the value returned in
	            the itemRect field of the MenuTrackingData structure passed to kMenuFindItemMsg. In
	            order to correctly support scrolling of menus with submenus, a menu definition should
	            verify, before scrolling the menu contents, that no submenus of the scrolling menu are
	            currently visible. A menu definition can use GetMenuTrackingData to verify this condition,
	            as follows:
	            
	                Boolean SafeToScroll( MenuRef menuBeingScrolled )
	                (
	                    MenuTrackingData lastMenuData;
	                    return GetMenuTrackingData( NULL, &lastMenuData ) == noErr
	                           && lastMenuData.menu == menuBeingScrolled;
	                )
	            
	            If SafeToScroll returns false, the menu definition should not scroll the menu.
		}
																{  menu defProc messages  }
	kMenuDrawMsg				= 0;
	kMenuSizeMsg				= 2;
	kMenuPopUpMsg				= 3;
	kMenuCalcItemMsg			= 5;
	kMenuThemeSavvyMsg			= 7;							{  is your MDEF theme-savvy?  If so, return kThemeSavvyMenuResponse in the whichItem parameter }
	mDrawMsg					= 0;
	mSizeMsg					= 2;
	mPopUpMsg					= 3;							{  position the popup menu rect appropriately  }
	mCalcItemMsg				= 5;

{$IFC CALL_NOT_IN_CARBON }
	{
	   Carbon MDEFs must replace mChooseMsg with the new messages kMenuFindItemMsg and kMenuHiliteItemMsg. 
	   mDrawItemMsg was used by the popup menu control before 8.5, but is no longer used. 
	}
	mChooseMsg					= 1;
	mDrawItemMsg				= 4;
	kMenuChooseMsg				= 1;
	kMenuDrawItemMsg			= 4;

{$ENDC}  {CALL_NOT_IN_CARBON}

	kThemeSavvyMenuResponse		= $7473;						{  should be returned in *whichItem when handling kMenuThemeSavvyMsg }

	{  these MDEF messages are only supported in Carbon }
	kMenuInitMsg				= 8;
	kMenuDisposeMsg				= 9;
	kMenuFindItemMsg			= 10;
	kMenuHiliteItemMsg			= 11;
	kMenuDrawItemsMsg			= 12;

	textMenuProc				= 0;
	hMenuCmd					= 27;							{ itemCmd == 0x001B ==> hierarchical menu }
	hierMenu					= -1;							{ a hierarchical menu - for InsertMenu call }
	kInsertHierarchicalMenu		= -1;							{ a better name for hierMenu  }
	mctAllItems					= -98;							{ search for all Items for the given ID }
	mctLastIDIndic				= -99;							{ last color table entry has this in ID field }

	{  Constants for use with MacOS 8.0 (Appearance 1.0) and later }
	kMenuStdMenuProc			= 63;
	kMenuStdMenuBarProc			= 63;

	{  For use with Get/SetMenuItemModifiers }
	kMenuNoModifiers			= 0;							{  Mask for no modifiers }
	kMenuShiftModifier			= $01;							{  Mask for shift key modifier }
	kMenuOptionModifier			= $02;							{  Mask for option key modifier }
	kMenuControlModifier		= $04;							{  Mask for control key modifier }
	kMenuNoCommandModifier		= $08;							{  Mask for no command key modifier }

	{  For use with Get/SetMenuItemIconHandle }
	kMenuNoIcon					= 0;							{  No icon }
	kMenuIconType				= 1;							{  Type for ICON }
	kMenuShrinkIconType			= 2;							{  Type for ICON plotted 16 x 16 }
	kMenuSmallIconType			= 3;							{  Type for SICN }
	kMenuColorIconType			= 4;							{  Type for cicn }
	kMenuIconSuiteType			= 5;							{  Type for Icon Suite }
	kMenuIconRefType			= 6;							{  Type for Icon Ref }
	kMenuCGImageRefType			= 7;							{  Type for a CGImageRef (Mac OS X only) }

	{  For use with Get/SetMenuItemKeyGlyph }
	kMenuNullGlyph				= $00;							{  Null (always glyph 1) }
	kMenuTabRightGlyph			= $02;							{  Tab to the right key (for left-to-right script systems) }
	kMenuTabLeftGlyph			= $03;							{  Tab to the left key (for right-to-left script systems) }
	kMenuEnterGlyph				= $04;							{  Enter key }
	kMenuShiftGlyph				= $05;							{  Shift key }
	kMenuControlGlyph			= $06;							{  Control key }
	kMenuOptionGlyph			= $07;							{  Option key }
	kMenuSpaceGlyph				= $09;							{  Space (always glyph 3) key }
	kMenuDeleteRightGlyph		= $0A;							{  Delete to the right key (for right-to-left script systems) }
	kMenuReturnGlyph			= $0B;							{  Return key (for left-to-right script systems) }
	kMenuReturnR2LGlyph			= $0C;							{  Return key (for right-to-left script systems) }
	kMenuNonmarkingReturnGlyph	= $0D;							{  Nonmarking return key }
	kMenuPencilGlyph			= $0F;							{  Pencil key }
	kMenuDownwardArrowDashedGlyph = $10;						{  Downward dashed arrow key }
	kMenuCommandGlyph			= $11;							{  Command key }
	kMenuCheckmarkGlyph			= $12;							{  Checkmark key }
	kMenuDiamondGlyph			= $13;							{  Diamond key }
	kMenuAppleLogoFilledGlyph	= $14;							{  Apple logo key (filled) }
	kMenuParagraphKoreanGlyph	= $15;							{  Unassigned (paragraph in Korean) }
	kMenuDeleteLeftGlyph		= $17;							{  Delete to the left key (for left-to-right script systems) }
	kMenuLeftArrowDashedGlyph	= $18;							{  Leftward dashed arrow key }
	kMenuUpArrowDashedGlyph		= $19;							{  Upward dashed arrow key }
	kMenuRightArrowDashedGlyph	= $1A;							{  Rightward dashed arrow key }
	kMenuEscapeGlyph			= $1B;							{  Escape key }
	kMenuClearGlyph				= $1C;							{  Clear key }
	kMenuLeftDoubleQuotesJapaneseGlyph = $1D;					{  Unassigned (left double quotes in Japanese) }
	kMenuRightDoubleQuotesJapaneseGlyph = $1E;					{  Unassigned (right double quotes in Japanese) }
	kMenuTrademarkJapaneseGlyph	= $1F;							{  Unassigned (trademark in Japanese) }
	kMenuBlankGlyph				= $61;							{  Blank key }
	kMenuPageUpGlyph			= $62;							{  Page up key }
	kMenuCapsLockGlyph			= $63;							{  Caps lock key }
	kMenuLeftArrowGlyph			= $64;							{  Left arrow key }
	kMenuRightArrowGlyph		= $65;							{  Right arrow key }
	kMenuNorthwestArrowGlyph	= $66;							{  Northwest arrow key }
	kMenuHelpGlyph				= $67;							{  Help key }
	kMenuUpArrowGlyph			= $68;							{  Up arrow key }
	kMenuSoutheastArrowGlyph	= $69;							{  Southeast arrow key }
	kMenuDownArrowGlyph			= $6A;							{  Down arrow key }
	kMenuPageDownGlyph			= $6B;							{  Page down key }
	kMenuAppleLogoOutlineGlyph	= $6C;							{  Apple logo key (outline) }
	kMenuContextualMenuGlyph	= $6D;							{  Contextual menu key }
	kMenuPowerGlyph				= $6E;							{  Power key }
	kMenuF1Glyph				= $6F;							{  F1 key }
	kMenuF2Glyph				= $70;							{  F2 key }
	kMenuF3Glyph				= $71;							{  F3 key }
	kMenuF4Glyph				= $72;							{  F4 key }
	kMenuF5Glyph				= $73;							{  F5 key }
	kMenuF6Glyph				= $74;							{  F6 key }
	kMenuF7Glyph				= $75;							{  F7 key }
	kMenuF8Glyph				= $76;							{  F8 key }
	kMenuF9Glyph				= $77;							{  F9 key }
	kMenuF10Glyph				= $78;							{  F10 key }
	kMenuF11Glyph				= $79;							{  F11 key }
	kMenuF12Glyph				= $7A;							{  F12 key }
	kMenuF13Glyph				= $87;							{  F13 key }
	kMenuF14Glyph				= $88;							{  F14 key }
	kMenuF15Glyph				= $89;							{  F15 key }
	kMenuControlISOGlyph		= $8A;							{  Control key (ISO standard) }


	{
	 *  MenuAttributes
	 *  
	 *  Summary:
	 *    Menu attributes control behavior of the entire menu. They are
	 *    used with the Get/ChangeMenuAttributes APIs.
	 	}

TYPE
	MenuAttributes 				= UInt32;
CONST
	kMenuAttrExcludesMarkColumn	= $01;
	kMenuAttrAutoDisable		= $04;
	kMenuAttrUsePencilGlyph		= $08;


	{
	 *  MenuItemAttributes
	 *  
	 *  Summary:
	 *    Menu item attributes control behavior of individual menu items.
	 *    They are used with the Get/ChangeMenuItemAttributes APIs.
	 	}

TYPE
	MenuItemAttributes 			= UInt32;
CONST
	kMenuItemAttrDisabled		= $01;
	kMenuItemAttrIconDisabled	= $02;
	kMenuItemAttrSubmenuParentChoosable = $04;
	kMenuItemAttrDynamic		= $08;
	kMenuItemAttrNotPreviousAlternate = $10;
	kMenuItemAttrHidden			= $20;
	kMenuItemAttrSeparator		= $40;
	kMenuItemAttrSectionHeader	= $80;
	kMenuItemAttrIgnoreMeta		= $0100;
	kMenuItemAttrAutoRepeat		= $0200;
	kMenuItemAttrUseVirtualKey	= $0400;


	{
	 *  MenuTrackingMode
	 *  
	 *  Summary:
	 *    A menu tracking mode constant is part of the
	 *    kEventMenuBeginTracking and kEventMenuChangeTrackingMode Carbon
	 *    events. It indicates whether menus are being tracked using the
	 *    mouse or keyboard.
	 	}

TYPE
	MenuTrackingMode 			= UInt32;
CONST
	kMenuTrackingModeMouse		= 1;
	kMenuTrackingModeKeyboard	= 2;


	{
	 *  MenuEventOptions
	 *  
	 *  Summary:
	 *    Menu event options control how the menus are searched for an item
	 *    matching a particular keyboard event. They are used with the
	 *    IsMenuKeyEvent API.
	 	}

TYPE
	MenuEventOptions 			= UInt32;
CONST
	kMenuEventIncludeDisabledItems = $0001;
	kMenuEventQueryOnly			= $0002;
	kMenuEventDontCheckSubmenus	= $0004;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Menu Types                                                                        	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

TYPE
	MenuID								= SInt16;
	MenuItemIndex						= UInt16;
	MenuCommand							= UInt32;
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	MenuInfoPtr = ^MenuInfo;
	MenuInfo = RECORD
		menuID:					MenuID;									{  in Carbon use Get/SetMenuID }
		menuWidth:				INTEGER;								{  in Carbon use Get/SetMenuWidth }
		menuHeight:				INTEGER;								{  in Carbon use Get/SetMenuHeight }
		menuProc:				Handle;									{  not supported in Carbon }
		enableFlags:			LONGINT;								{  in Carbon use Enable/DisableMenuItem, IsMenuItemEnable }
		menuData:				Str255;									{  in Carbon use Get/SetMenuTitle }
	END;

	MenuPtr								= ^MenuInfo;
	MenuHandle							= ^MenuPtr;
{$ELSEC}
	MenuHandle    = ^LONGINT; { an opaque 32-bit type }
	MenuHandlePtr = ^MenuHandle;  { when a VAR xx:MenuHandle parameter can be nil, it is changed to xx: MenuHandlePtr }
{$ENDC}

	{  MenuRef and MenuHandle are equivalent. Use either. We don't care. }
	MenuRef								= MenuHandle;
	MenuBarHandle						= Handle;
	MCEntryPtr = ^MCEntry;
	MCEntry = RECORD
		mctID:					MenuID;									{ menu ID.  ID = 0 is the menu bar }
		mctItem:				INTEGER;								{ menu Item. Item = 0 is a title }
		mctRGB1:				RGBColor;								{ usage depends on ID and Item }
		mctRGB2:				RGBColor;								{ usage depends on ID and Item }
		mctRGB3:				RGBColor;								{ usage depends on ID and Item }
		mctRGB4:				RGBColor;								{ usage depends on ID and Item }
		mctReserved:			INTEGER;								{ reserved for internal use }
	END;

	MCTable								= ARRAY [0..0] OF MCEntry;
	MCTablePtr							= ^MCTable;
	MCTableHandle						= ^MCTablePtr;
	MenuCRsrcPtr = ^MenuCRsrc;
	MenuCRsrc = RECORD
		numEntries:				INTEGER;								{ number of entries }
		mcEntryRecs:			MCTable;								{ ARRAY [1..numEntries] of MCEntry }
	END;

	MenuCRsrcHandle						= ^MenuCRsrcPtr;
{$IFC TARGET_OS_WIN32 }
	{	 QuickTime 3.0 	}
	MenuAccessKeyRecPtr = ^MenuAccessKeyRec;
	MenuAccessKeyRec = RECORD
		count:					INTEGER;
		flags:					LONGINT;
		keys:					SInt8;
	END;

	MenuAccessKeyPtr					= ^MenuAccessKeyRec;
	MenuAccessKeyHandle					= ^MenuAccessKeyPtr;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  SetMenuItemHotKey()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE SetMenuItemHotKey(menu: MenuRef; itemID: INTEGER; hotKey: ByteParameter; flags: LONGINT); C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_WIN32}


{
 *  MenuTrackingData
 *  
 *  Summary:
 *    The MenuTrackingData structure contains information about a menu
 *    currently being displayed. It is used with the
 *    GetMenuTrackingData API.
 }

TYPE
	MenuTrackingDataPtr = ^MenuTrackingData;
	MenuTrackingData = RECORD
		menu:					MenuRef;
		itemSelected:			MenuItemIndex;
		itemUnderMouse:			MenuItemIndex;
		itemRect:				Rect;
		virtualMenuTop:			SInt32;
		virtualMenuBottom:		SInt32;
	END;


	{
	 *  MDEFHiliteItemData
	 *  
	 *  Summary:
	 *    The MDEFHiliteItemData structure contains information about which
	 *    menu items should be hilited and unhilited as the user moves
	 *    through the menus. It is used by menu definition functions, which
	 *    receive a pointer to an MDEFHiliteItemData structure as the
	 *    whichItem parameter during kMenuHiliteItemMsg.
	 	}
	MDEFHiliteItemDataPtr = ^MDEFHiliteItemData;
	MDEFHiliteItemData = RECORD
		previousItem:			MenuItemIndex;
		newItem:				MenuItemIndex;
	END;

	HiliteMenuItemData					= MDEFHiliteItemData;
	HiliteMenuItemDataPtr 				= ^HiliteMenuItemData;

	{
	 *  MDEFDrawItemsData
	 *  
	 *  Summary:
	 *    The MDEFDrawItemsData structure contains information about which
	 *    menu items to redraw. It is used by menu definition functions,
	 *    which receive a pointer to an MDEFDrawItemsData structure as the
	 *    whichItem parameter during kMenuDrawItemsMsg.
	 	}
	MDEFDrawItemsDataPtr = ^MDEFDrawItemsData;
	MDEFDrawItemsData = RECORD
		firstItem:				MenuItemIndex;
		lastItem:				MenuItemIndex;
		trackingData:			MenuTrackingDataPtr;
		context:				Ptr;
	END;


	{
	 *  Summary:
	 *    A MenuItemDataFlags value indicates which fields of a
	 *    MenuItemDataRec structure should be used by the
	 *    Copy/SetMenuItemData APIs. All MenuItemDataFlags may be used when
	 *    getting or setting the contents of a menu item; some may also be
	 *    used when getting or setting information about the menu itself,
	 *    if the item index given to Copy/SetMenuItemData is 0.
	 	}

CONST
	kMenuItemDataText			= $01;
	kMenuItemDataMark			= $02;
	kMenuItemDataCmdKey			= $04;
	kMenuItemDataCmdKeyGlyph	= $08;
	kMenuItemDataCmdKeyModifiers = $10;
	kMenuItemDataStyle			= $20;
	kMenuItemDataEnabled		= $40;
	kMenuItemDataIconEnabled	= $80;
	kMenuItemDataIconID			= $0100;
	kMenuItemDataIconHandle		= $0200;
	kMenuItemDataCommandID		= $0400;
	kMenuItemDataTextEncoding	= $0800;
	kMenuItemDataSubmenuID		= $1000;
	kMenuItemDataSubmenuHandle	= $2000;
	kMenuItemDataFontID			= $4000;
	kMenuItemDataRefcon			= $8000;
	kMenuItemDataAttributes		= $00010000;
	kMenuItemDataCFString		= $00020000;
	kMenuItemDataProperties		= $00040000;
	kMenuItemDataIndent			= $00080000;
	kMenuItemDataCmdVirtualKey	= $00100000;
	kMenuItemDataAllDataVersionOne = $000FFFFF;
	kMenuItemDataAllDataVersionTwo = $001FFFFF;


TYPE
	MenuItemDataFlags					= UInt64;
	MenuItemDataFlagsPtr 				= ^MenuItemDataFlags;

	{
	 *  MenuItemDataRec
	 *  
	 *  Summary:
	 *    The MenuItemDataRec structure is used to get and change aspects
	 *    of a menu item. It is used with the Copy/SetMenuItemData APIs.
	 *  
	 *  Discussion:
	 *    When using this structure with Copy/SetMenuItemData, the caller
	 *    must first set the whichData field to a combination of
	 *    MenuItemDataFlags indicating which specific data should be
	 *    retrieved or set. Some fields also require initialization before
	 *    calling CopyMenuItemData; see the individual MenuItemDataFlags
	 *    documentation for details.
	 	}
	MenuItemDataRecPtr = ^MenuItemDataRec;
	MenuItemDataRec = RECORD
		whichData:				MenuItemDataFlags;
		text:					StringPtr;
		mark:					UniChar;
		cmdKey:					UniChar;
		cmdKeyGlyph:			UInt32;
		cmdKeyModifiers:		UInt32;
		style:					SInt8;
		enabled:				BOOLEAN;
		iconEnabled:			BOOLEAN;
		filler1:				SInt8;
		iconID:					SInt32;
		iconType:				UInt32;
		iconHandle:				Handle;
		cmdID:					MenuCommand;
		encoding:				TextEncoding;
		submenuID:				MenuID;
		submenuHandle:			MenuRef;
		fontID:					SInt32;
		refcon:					UInt32;
		attr:					OptionBits;
		cfText:					CFStringRef;
		properties:				Collection;
		indent:					UInt32;
		cmdVirtualKey:			UInt16;
	END;

	MenuItemDataPtr						= ^MenuItemDataRec;
	MenuItemID							= UInt32;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Menu ProcPtrs                                                                     	}
	{	                                                                                      	}
	{	  All of these procs are considered deprecated.  Developers interested in portability 	}
	{	  to Carbon should avoid them entirely, if at all possible.                           	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
{$IFC TYPED_FUNCTION_POINTERS}
	MenuDefProcPtr = PROCEDURE(message: INTEGER; theMenu: MenuRef; VAR menuRect: Rect; hitPt: Point; VAR whichItem: INTEGER);
{$ELSEC}
	MenuDefProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	MenuDefUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MenuDefUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppMenuDefProcInfo = $0000FF80;
	{
	 *  NewMenuDefUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewMenuDefUPP(userRoutine: MenuDefProcPtr): MenuDefUPP; { old name was NewMenuDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeMenuDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMenuDefUPP(userUPP: MenuDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeMenuDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeMenuDefUPP(message: INTEGER; theMenu: MenuRef; VAR menuRect: Rect; hitPt: Point; VAR whichItem: INTEGER; userRoutine: MenuDefUPP); { old name was CallMenuDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	MenuBarDefProcPtr = FUNCTION(selector: INTEGER; message: INTEGER; parameter1: INTEGER; parameter2: LONGINT): LONGINT;
{$ELSEC}
	MenuBarDefProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MenuHookProcPtr = PROCEDURE;
{$ELSEC}
	MenuHookProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MBarHookProcPtr = FUNCTION(VAR menuRect: Rect): INTEGER;
{$ELSEC}
	MBarHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	MenuBarDefUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MenuBarDefUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MenuHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MenuHookUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MBarHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MBarHookUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppMenuBarDefProcInfo = $00003AB0;
	uppMenuHookProcInfo = $00000000;
	uppMBarHookProcInfo = $000000CF;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewMenuBarDefUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewMenuBarDefUPP(userRoutine: MenuBarDefProcPtr): MenuBarDefUPP; { old name was NewMenuBarDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMenuHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewMenuHookUPP(userRoutine: MenuHookProcPtr): MenuHookUPP; { old name was NewMenuHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMBarHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewMBarHookUPP(userRoutine: MBarHookProcPtr): MBarHookUPP; { old name was NewMBarHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeMenuBarDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeMenuBarDefUPP(userUPP: MenuBarDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMenuHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeMenuHookUPP(userUPP: MenuHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMBarHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeMBarHookUPP(userUPP: MBarHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeMenuBarDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeMenuBarDefUPP(selector: INTEGER; message: INTEGER; parameter1: INTEGER; parameter2: LONGINT; userRoutine: MenuBarDefUPP): LONGINT; { old name was CallMenuBarDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMenuHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeMenuHookUPP(userRoutine: MenuHookUPP); { old name was CallMenuHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMBarHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeMBarHookUPP(VAR menuRect: Rect; userRoutine: MBarHookUPP): INTEGER; { old name was CallMBarHookProc }
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kMenuDefProcPtr				= 0;							{  raw proc-ptr access based on old MDEF  }


TYPE
	MenuDefType							= UInt32;
	MenuDefSpecPtr = ^MenuDefSpec;
	MenuDefSpec = RECORD
		defType:				MenuDefType;
		CASE INTEGER OF
		0: (
			defProc:			MenuDefUPP;
			);
	END;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Menu Manager Initialization                                                       	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  InitProcMenu()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE InitProcMenu(resID: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A808;
	{$ENDC}

{
 *  InitMenus()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InitMenus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A930;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Manipulation                                                                 }
{——————————————————————————————————————————————————————————————————————————————————————}
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  NewMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewMenu(menuID: MenuID; menuTitle: Str255): MenuRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A931;
	{$ENDC}

{
 *  [Mac]GetMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenu(resourceID: INTEGER): MenuRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9BF;
	{$ENDC}

{
 *  DisposeMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMenu(theMenu: MenuRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A932;
	{$ENDC}

{
 *  CalcMenuSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CalcMenuSize(theMenu: MenuRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A948;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  CountMItems()
 *  
 *  Summary:
 *    Renamed to CountMenuItems in Carbon
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION CountMItems(theMenu: MenuRef): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A950;
	{$ENDC}


{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  CountMenuItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.3 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CountMenuItems(theMenu: MenuRef): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A950;
	{$ENDC}



{  Routines available in Mac OS 8.5 and later, and on Mac OS 8.1 and later using CarbonLib 1.1 and later }

{
 *  GetMenuFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuFont(menu: MenuRef; VAR outFontID: SInt16; VAR outFontSize: UInt16): OSStatus;

{
 *  SetMenuFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuFont(menu: MenuRef; inFontID: SInt16; inFontSize: UInt16): OSStatus;

{
 *  GetMenuExcludesMarkColumn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuExcludesMarkColumn(menu: MenuRef): BOOLEAN;

{
 *  SetMenuExcludesMarkColumn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuExcludesMarkColumn(menu: MenuRef; excludesMark: BOOLEAN): OSStatus;

{
 *  RegisterMenuDefinition()
 *  
 *  Summary:
 *    Registers or unregisters a binding between a resource ID and a
 *    menu definition function.
 *  
 *  Discussion:
 *    In the Mac OS 8.x Menu Manager, a 'MENU' resource can contain an
 *    embedded MDEF procID that is used by the Menu Manager as the
 *    resource ID of an 'MDEF' resource to measure and draw the menu.
 *    The 'MDEF' resource is loaded by the Menu Manager when you load
 *    the menu with GetMenu. Since MDEFs can no longer be packaged as
 *    code resources on Carbon, the procID can no longer refer directly
 *    to an MDEF resource. However, using RegisterMenuDefinition you
 *    can instead specify a UniversalProcPtr pointing to code in your
 *    application code fragment.
 *  
 *  Parameters:
 *    
 *    inResID:
 *      An MDEF proc ID, as used in a 'MENU' resource.
 *    
 *    inDefSpec:
 *      Specifies the MenuDefUPP that should be used for menus with the
 *      given MDEF proc ID. Passing NULL allows you to unregister the
 *      menu definition that had been associated with the given MDEF
 *      proc ID.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RegisterMenuDefinition(inResID: SInt16; inDefSpec: MenuDefSpecPtr): OSStatus;

{
 *  CreateNewMenu()
 *  
 *  Summary:
 *    Creates a new, untitled, empty menu.
 *  
 *  Discussion:
 *    CreateNewMenu is preferred over NewMenu because it allows you to
 *    specify the menu's attributes and it does not require you to
 *    specify a Str255-based menu title. To set the menu title, you can
 *    use either SetMenuTitle or SetMenuTitleWithCFString.
 *  
 *  Parameters:
 *    
 *    inMenuID:
 *      The menu ID to use for the new menu.
 *    
 *    inMenuAttributes:
 *      The menu attributes to use for the new menu.
 *    
 *    outMenuRef:
 *      On exit, contains the new menu.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateNewMenu(inMenuID: MenuID; inMenuAttributes: MenuAttributes; VAR outMenuRef: MenuRef): OSStatus;

{
 *  CreateCustomMenu()
 *  
 *  Summary:
 *    Creates a new, untitled, empty menu using a custom menu
 *    definition function.
 *  
 *  Discussion:
 *    Similar to CreateNewMenu, but also allows you to specify a custom
 *    menu definition function.
 *  
 *  Parameters:
 *    
 *    inDefSpec:
 *      Specifies a custom menu definition function. defSpec->defType
 *      must be kMenuDefProcPtr.
 *    
 *    inMenuID:
 *      The menu ID to use for the new menu.
 *    
 *    inMenuAttributes:
 *      The menu attributes to use for the new menu.
 *    
 *    outMenuRef:
 *      On exit, contains the new menu.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateCustomMenu({CONST}VAR inDefSpec: MenuDefSpec; inMenuID: MenuID; inMenuAttributes: MenuAttributes; VAR outMenuRef: MenuRef): OSStatus;

{
 *  IsValidMenu()
 *  
 *  Summary:
 *    Determines if a menu is valid.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu to check for validity.
 *  
 *  Result:
 *    Indicates whether the menu is valid.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsValidMenu(inMenu: MenuRef): BOOLEAN;

{
 *  GetMenuRetainCount()
 *  
 *  Summary:
 *    Returns the retain count of this menu.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu whose retain count to increment.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuRetainCount(inMenu: MenuRef): ItemCount;

{
 *  RetainMenu()
 *  
 *  Summary:
 *    Increments the retain count of a menu.
 *  
 *  Discussion:
 *    RetainMenu does not create a new menu. It simply adds one to the
 *    retain count. If called on a menu that was not created by
 *    CarbonLib, it will not affect the menu's retain count.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu whose retain count to increment.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RetainMenu(inMenu: MenuRef): OSStatus;

{
 *  ReleaseMenu()
 *  
 *  Summary:
 *    Decrements the retain count of a menu.
 *  
 *  Discussion:
 *    If called on a menu that was not created by CarbonLib, it will
 *    not affect the menu's retain count.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu whose retain count to decrement. If the retain count
 *      falls to zero, the menu is destroyed.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ReleaseMenu(inMenu: MenuRef): OSStatus;

{
 *  DuplicateMenu()
 *  
 *  Summary:
 *    Creates a new menu that is a copy of another menu.
 *  
 *  Discussion:
 *    Unlike CloneMenu, DuplicateMenu creates an entirely new menu that
 *    is an exact copy of the original menu. The MDEF for the new menu
 *    will receive an init message after the menu has been fully
 *    created.
 *  
 *  Parameters:
 *    
 *    inSourceMenu:
 *      The menu to duplicate.
 *    
 *    outMenu:
 *      On exit, a copy of the source menu.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DuplicateMenu(inSourceMenu: MenuRef; VAR outMenu: MenuRef): OSStatus;

{
 *  CopyMenuTitleAsCFString()
 *  
 *  Summary:
 *    Returns a CFString containing the title of a menu.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu whose title to return.
 *    
 *    outString:
 *      On exit, a CFString containing the menu's title. This string
 *      must be released by the caller.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CopyMenuTitleAsCFString(inMenu: MenuRef; VAR outString: CFStringRef): OSStatus;

{
 *  SetMenuTitleWithCFString()
 *  
 *  Summary:
 *    Sets the title of a menu to the text contained in a CFString.
 *  
 *  Discussion:
 *    The Menu Manager will make its own copy of the CFString before
 *    returning from SetMenuTitleWithCFString. Modifying the string
 *    after calling SetMenuTitleWithCFString will have no effect on the
 *    menu's actual title. The caller may release the string after
 *    calling SetMenuTitleWithCFString.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu whose title to set.
 *    
 *    inString:
 *      The string containing the new menu title text.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuTitleWithCFString(inMenu: MenuRef; inString: CFStringRef): OSStatus;

{
 *  SetMenuTitleIcon()
 *  
 *  Summary:
 *    Sets the title of a menu to be an icon.
 *  
 *  Discussion:
 *    The Menu Manager takes ownership of the supplied icon after this
 *    call. When a menu with an title icon is disposed, the Menu
 *    Manager will dispose the icon also; the Menu Manager will also
 *    dispose of the current title icon when a new text or icon title
 *    is supplied for a menu. If an IconRef is specified, the Menu
 *    Manager will increment its refcount, so you may freely release
 *    your reference to the IconRef without invalidating the Menu
 *    Manager's copy. The menubar will be invalidated by this call, and
 *    redrawn at the next opportunity.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu whose title to set.
 *    
 *    inType:
 *      The type of icon being used to specify the icon title; use
 *      kMenuNoIcon to remove the icon from the menu title. The
 *      supported types are kMenuIconSuiteType and kMenuIconRefType.
 *    
 *    inIcon:
 *      The icon; must be NULL if inType is kMenuNoIcon. The supported
 *      icon formats are IconSuiteRef and IconRef.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuTitleIcon(inMenu: MenuRef; inType: UInt32; inIcon: UNIV Ptr): OSStatus;

{
 *  GetMenuTitleIcon()
 *  
 *  Summary:
 *    Retrieves the icon, if any, being used as the title of a menu.
 *  
 *  Discussion:
 *    This API does not increment a refcount on the returned icon. The
 *    caller should not release the icon.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu whose icon title to retrieve.
 *    
 *    outType:
 *      On exit, contains the type of icon being used as the title of
 *      the menu. Contains kMenuNoIcon if the menu does not have an
 *      icon title.
 *    
 *    outIcon:
 *      On exit, contains the IconSuiteRef or IconRef being used as the
 *      title of the menu, or NULL if the menu does not have an icon
 *      title. May be NULL.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuTitleIcon(inMenu: MenuRef; VAR outType: UInt32; outIcon: UNIV Ptr): OSStatus;

{
 *  InvalidateMenuSize()
 *  
 *  Summary:
 *    Invalidates the menu size so that it will be recalculated when
 *    next displayed.
 *  
 *  Discussion:
 *    The pre-Carbon technique for invalidating the menu size was to
 *    set the width and height to -1. Although this technique still
 *    works, for best compatibility it's preferable to use the
 *    InvalidateMenuSize API so that the Menu Manager has explicit
 *    notification that the menu is invalid.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu whose size to invalidate.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvalidateMenuSize(inMenu: MenuRef): OSStatus;

{
 *  IsMenuSizeInvalid()
 *  
 *  Summary:
 *    Determines if a menu's size is invalid and should be recalculated.
 *  
 *  Discussion:
 *    The pre-Carbon technique for determining if a menu's size is
 *    invalid was to check if the width or height was -1. This
 *    technique is not always reliable on Carbon due to implementation
 *    changes in the Menu Manager. You should now use IsMenuSizeInvalid
 *    instead.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu whose size to examine.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsMenuSizeInvalid(inMenu: MenuRef): BOOLEAN;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Item Insertion                                                               }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  [Mac]AppendMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE AppendMenu(menu: MenuRef; data: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A933;
	{$ENDC}

{
 *  InsertResMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InsertResMenu(theMenu: MenuRef; theType: ResType; afterItem: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A951;
	{$ENDC}

{
 *  AppendResMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE AppendResMenu(theMenu: MenuRef; theType: ResType);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94D;
	{$ENDC}

{
 *  [Mac]InsertMenuItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InsertMenuItem(theMenu: MenuRef; itemString: Str255; afterItem: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A826;
	{$ENDC}

{
 *  DeleteMenuItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DeleteMenuItem(theMenu: MenuRef; item: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A952;
	{$ENDC}

{
 *  InsertFontResMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InsertFontResMenu(theMenu: MenuRef; afterItem: INTEGER; scriptFilter: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0400, $A825;
	{$ENDC}

{
 *  InsertIntlResMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InsertIntlResMenu(theMenu: MenuRef; theType: ResType; afterItem: INTEGER; scriptFilter: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0601, $A825;
	{$ENDC}

{
 *  AppendMenuItemText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AppendMenuItemText(menu: MenuRef; inString: Str255): OSStatus;

{
 *  InsertMenuItemText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InsertMenuItemText(menu: MenuRef; inString: Str255; afterItem: MenuItemIndex): OSStatus;

{
 *  CopyMenuItems()
 *  
 *  Summary:
 *    Copies menu items from one menu to another.
 *  
 *  Parameters:
 *    
 *    inSourceMenu:
 *      The menu from which to copy items.
 *    
 *    inFirstItem:
 *      The first item to copy.
 *    
 *    inNumItems:
 *      The number of items to copy.
 *    
 *    inDestMenu:
 *      The menu to which to copy items.
 *    
 *    inInsertAfter:
 *      The menu item in the destination menu after which to insert the
 *      copied items.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CopyMenuItems(inSourceMenu: MenuRef; inFirstItem: MenuItemIndex; inNumItems: ItemCount; inDestMenu: MenuRef; inInsertAfter: MenuItemIndex): OSStatus;

{
 *  DeleteMenuItems()
 *  
 *  Summary:
 *    Deletes multiple menu items.
 *  
 *  Discussion:
 *    This API is more efficient than calling DeleteMenuItem multiple
 *    times.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu from which to delete items.
 *    
 *    inFirstItem:
 *      The first item to delete.
 *    
 *    inNumItems:
 *      The number of items to delete.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DeleteMenuItems(inMenu: MenuRef; inFirstItem: MenuItemIndex; inNumItems: ItemCount): OSStatus;

{
 *  AppendMenuItemTextWithCFString()
 *  
 *  Summary:
 *    Appends a new menu item with text from a CFString.
 *  
 *  Discussion:
 *    The Menu Manager will make its own copy of the CFString before
 *    returning from AppendMenuItemWithTextCFString. Modifying the
 *    string after calling AppendMenuItemTextWithCFString will have no
 *    effect on the menu item's actual text. The caller may release the
 *    string after calling AppendMenuItemTextWithCFString.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu to which to append the new item.
 *    
 *    inString:
 *      The text of the new item.
 *    
 *    inAttributes:
 *      The attributes of the new item.
 *    
 *    inCommandID:
 *      The command ID of the new item.
 *    
 *    outNewItem:
 *      On exit, the index of the new item. May be NULL if the caller
 *      does not need this information.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AppendMenuItemTextWithCFString(inMenu: MenuRef; inString: CFStringRef; inAttributes: MenuItemAttributes; inCommandID: MenuCommand; VAR outNewItem: MenuItemIndex): OSStatus;

{
 *  InsertMenuItemTextWithCFString()
 *  
 *  Summary:
 *    Inserts a new menu item with text from a CFString.
 *  
 *  Discussion:
 *    The Menu Manager will make its own copy of the CFString before
 *    returning from InsertMenuItemWithCFString. Modifying the string
 *    after calling InsertMenuItemTextWithCFString will have no effect
 *    on the menu item's actual text. The caller may release the string
 *    after calling InsertMenuItemTextWithCFString.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu in which to insert the new item.
 *    
 *    inString:
 *      The text of the new item.
 *    
 *    inAfterItem:
 *      The item after which to insert the new item.
 *    
 *    inAttributes:
 *      The attributes of the new item.
 *    
 *    inCommandID:
 *      The command ID of the new item.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InsertMenuItemTextWithCFString(inMenu: MenuRef; inString: CFStringRef; inAfterItem: MenuItemIndex; inAttributes: MenuItemAttributes; inCommandID: MenuCommand): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Events                                                                       }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  MenuKey()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MenuKey(ch: CharParameter): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93E;
	{$ENDC}

{
 *  MenuSelect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MenuSelect(startPt: Point): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93D;
	{$ENDC}

{
 *  PopUpMenuSelect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PopUpMenuSelect(menu: MenuRef; top: INTEGER; left: INTEGER; popUpItem: INTEGER): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A80B;
	{$ENDC}

{
 *  MenuChoice()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MenuChoice: LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA66;
	{$ENDC}

{
 *  MenuEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MenuEvent({CONST}VAR inEvent: EventRecord): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020C, $A825;
	{$ENDC}

{
 *  IsMenuKeyEvent()
 *  
 *  Summary:
 *    Determines if an event corresponds to a menu command key.
 *  
 *  Discussion:
 *    By default, IsMenuKeyEvent searches the menus in the current menu
 *    bar and hilites the menu title of the menu containing the
 *    selected item.
 *  
 *  Parameters:
 *    
 *    inStartMenu:
 *      IsMenuKeyEvent searches for matching menu items in this menu
 *      and all of its submenus. May be NULL to search the current menu
 *      bar contents.
 *    
 *    inEvent:
 *      The event to match against. Non-keyboard events are ignored.
 *    
 *    inOptions:
 *      Options controlling how to search. Pass kNilOptions for the
 *      default behavior.
 *    
 *    outMenu:
 *      On exit, the menu containing the matching item. May be NULL.
 *    
 *    outMenuItem:
 *      On exit, the menu item that matched. May be NULL.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsMenuKeyEvent(inStartMenu: MenuRef; inEvent: EventRef; inOptions: MenuEventOptions; VAR outMenu: MenuRef; VAR outMenuItem: MenuItemIndex): BOOLEAN;

{
 *  InvalidateMenuEnabling()
 *  
 *  Summary:
 *    Causes the menu enable state to be recalculated at the next
 *    convenient opportunity.
 *  
 *  Discussion:
 *    It is common for state changes in an application (for example,
 *    selection of text) to cause a change in the enabling of items in
 *    the application's menu (for example, the Copy menu item might
 *    become enabled). In a Carbon-event-savvy application, menu items
 *    are enabled or disabled in response to an
 *    kEventCommandUpdateStatus event; however, this event is normally
 *    only sent before a command key press or a click in the menubar.
 *    You can request an explicit recalculation of a menu's enable
 *    state with the InvalidateMenuEnabling API. The Carbon Event
 *    Manager will automatically invalidate the enable state of all
 *    top-level menus when a user event is dispatched, the user focus
 *    changes, or the active window changes, so in many cases you will
 *    not need to explicitly invalidate the menu enabling state.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      A menu to re-enable, or NULL if all menus in the root menu
 *      should be re-enabled.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvalidateMenuEnabling(inMenu: MenuRef): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Bar                                                                          }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  GetMBarHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMBarHeight: INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0BAA;
	{$ENDC}

{
 *  [Mac]DrawMenuBar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DrawMenuBar;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A937;
	{$ENDC}

{
 *  InvalMenuBar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvalMenuBar;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A81D;
	{$ENDC}

{
 *  IsMenuBarInvalid()
 *  
 *  Summary:
 *    Determines if the menubar is invalid and should be redrawn.
 *  
 *  Parameters:
 *    
 *    rootMenu:
 *      The root menu for the menubar to be examined. Pass NULL to
 *      check the state of the current menubar.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsMenuBarInvalid(rootMenu: MenuRef): BOOLEAN;

{
 *  HiliteMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HiliteMenu(menuID: MenuID);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A938;
	{$ENDC}

{
 *  GetNewMBar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetNewMBar(menuBarID: INTEGER): MenuBarHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C0;
	{$ENDC}

{
 *  GetMenuBar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuBar: MenuBarHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93B;
	{$ENDC}

{
 *  SetMenuBar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetMenuBar(mbar: MenuBarHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93C;
	{$ENDC}

{
 *  DuplicateMenuBar()
 *  
 *  Summary:
 *    Duplicates a menubar handle.
 *  
 *  Discussion:
 *    This API should be used in Carbon applications when duplicating a
 *    handle returned from GetMenuBar or GetNewMBar. You should not use
 *    Memory Manager APIs (HandToHand, NewHandle, etc) to duplicate
 *    such a handle. This is necessary in Carbon so that the refcounts
 *    of the menus in the menubar handle can be incremented when the
 *    handle is duplicated.
 *  
 *  Parameters:
 *    
 *    inMbar:
 *      The menubar handle to duplicate.
 *    
 *    outMbar:
 *      On exit, contains the new menubar handle.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DuplicateMenuBar(inMbar: MenuBarHandle; VAR outMbar: MenuBarHandle): OSStatus;

{
 *  DisposeMenuBar()
 *  
 *  Summary:
 *    Releases a menubar handle.
 *  
 *  Discussion:
 *    This API should be used in Carbon applications when releasing a
 *    handle returned from GetMenuBar or GetNewMBar. You should not use
 *    DisposeHandle to release such a handle. This is necessary in
 *    Carbon so that the refcounts of the menus in the menubar handle
 *    can be decremented when the handle is released.
 *  
 *  Parameters:
 *    
 *    inMbar:
 *      The menubar handle to release.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DisposeMenuBar(inMbar: MenuBarHandle): OSStatus;

{
 *  GetMenuHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuHandle(menuID: MenuID): MenuRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A949;
	{$ENDC}

{
 *  [Mac]InsertMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InsertMenu(theMenu: MenuRef; beforeID: MenuID);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A935;
	{$ENDC}

{
 *  [Mac]DeleteMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DeleteMenu(menuID: MenuID);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A936;
	{$ENDC}

{
 *  ClearMenuBar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ClearMenuBar;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A934;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  SetMenuFlash()
 *  
 *  Summary:
 *    Renamed to SetMenuFlashCount in Carbon
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetMenuFlash(count: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94A;
	{$ENDC}


{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  SetMenuFlashCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.3 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetMenuFlashCount(count: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94A;
	{$ENDC}


{
 *  FlashMenuBar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE FlashMenuBar(menuID: MenuID);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94C;
	{$ENDC}

{  These are obsolete because Carbon does not support desk accessories. }
{$IFC CALL_NOT_IN_CARBON }
{
 *  SystemEdit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SystemEdit(editCmd: INTEGER): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9C2;
	{$ENDC}

{
 *  SystemMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SystemMenu(menuResult: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9B5;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  IsMenuBarVisible()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsMenuBarVisible: BOOLEAN;

{
 *  ShowMenuBar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ShowMenuBar;

{
 *  HideMenuBar()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HideMenuBar;

{
 *  AcquireRootMenu()
 *  
 *  Summary:
 *    Get the menu whose contents are displayed in the menubar.
 *  
 *  Discussion:
 *    The refcount of the root menu is incremented by this API. The
 *    caller should release a refcount with ReleaseMenu when it’s done
 *    with the menu.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AcquireRootMenu: MenuRef;

{
 *  SetRootMenu()
 *  
 *  Summary:
 *    Sets the menu whose contents are displayed in the menubar.
 *  
 *  Discussion:
 *    The refcount of the root menu is incremented by this API. The
 *    caller may release the menu after calling SetRootMenu.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The new root menu.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetRootMenu(inMenu: MenuRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Item Accessors                                                               }
{——————————————————————————————————————————————————————————————————————————————————————}
{$IFC CALL_NOT_IN_CARBON }
{
 *  CheckItem()
 *  
 *  Summary:
 *    Renamed to CheckMenuItem in Carbon
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CheckItem(theMenu: MenuRef; item: INTEGER; checked: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A945;
	{$ENDC}


{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  [Mac]CheckMenuItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.3 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CheckMenuItem(theMenu: MenuRef; item: INTEGER; checked: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A945;
	{$ENDC}


{
 *  SetMenuItemText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetMenuItemText(theMenu: MenuRef; item: INTEGER; itemString: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A947;
	{$ENDC}

{
 *  GetMenuItemText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetMenuItemText(theMenu: MenuRef; item: INTEGER; VAR itemString: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A946;
	{$ENDC}

{
 *  SetItemMark()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetItemMark(theMenu: MenuRef; item: INTEGER; markChar: CharParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A944;
	{$ENDC}

{
 *  GetItemMark()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetItemMark(theMenu: MenuRef; item: INTEGER; VAR markChar: CharParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A943;
	{$ENDC}

{
 *  SetItemCmd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetItemCmd(theMenu: MenuRef; item: INTEGER; cmdChar: CharParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A84F;
	{$ENDC}

{
 *  GetItemCmd()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetItemCmd(theMenu: MenuRef; item: INTEGER; VAR cmdChar: CharParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A84E;
	{$ENDC}

{
 *  SetItemIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetItemIcon(theMenu: MenuRef; item: INTEGER; iconIndex: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A940;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  GetItemIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetItemIcon(theMenu: MenuRef; item: INTEGER; VAR iconIndex: Byte);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93F;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  SetItemStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetItemStyle(theMenu: MenuRef; item: INTEGER; chStyle: StyleParameter);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A942;
	{$ENDC}

{
 *  GetItemStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetItemStyle(theMenu: MenuRef; item: INTEGER; VAR chStyle: Style);

{ These APIs are not supported in Carbon. Please use EnableMenuItem and }
{ DisableMenuItem (available back through Mac OS 8.5) instead.          }
{$IFC CALL_NOT_IN_CARBON }
{
 *  DisableItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisableItem(theMenu: MenuRef; item: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A93A;
	{$ENDC}

{
 *  EnableItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE EnableItem(theMenu: MenuRef; item: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A939;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  SetMenuItemCommandID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuItemCommandID(inMenu: MenuRef; inItem: SInt16; inCommandID: MenuCommand): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0502, $A825;
	{$ENDC}

{
 *  GetMenuItemCommandID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuItemCommandID(inMenu: MenuRef; inItem: SInt16; VAR outCommandID: MenuCommand): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0503, $A825;
	{$ENDC}

{
 *  SetMenuItemModifiers()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuItemModifiers(inMenu: MenuRef; inItem: SInt16; inModifiers: ByteParameter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0404, $A825;
	{$ENDC}

{
 *  GetMenuItemModifiers()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuItemModifiers(inMenu: MenuRef; inItem: SInt16; VAR outModifiers: UInt8): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0505, $A825;
	{$ENDC}

{
 *  SetMenuItemIconHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuItemIconHandle(inMenu: MenuRef; inItem: SInt16; inIconType: ByteParameter; inIconHandle: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0606, $A825;
	{$ENDC}

{
 *  GetMenuItemIconHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuItemIconHandle(inMenu: MenuRef; inItem: SInt16; VAR outIconType: UInt8; VAR outIconHandle: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0707, $A825;
	{$ENDC}

{
 *  SetMenuItemTextEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuItemTextEncoding(inMenu: MenuRef; inItem: SInt16; inScriptID: TextEncoding): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0408, $A825;
	{$ENDC}

{
 *  GetMenuItemTextEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuItemTextEncoding(inMenu: MenuRef; inItem: SInt16; VAR outScriptID: TextEncoding): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0509, $A825;
	{$ENDC}

{
 *  SetMenuItemHierarchicalID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuItemHierarchicalID(inMenu: MenuRef; inItem: SInt16; inHierID: MenuID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040D, $A825;
	{$ENDC}

{
 *  GetMenuItemHierarchicalID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuItemHierarchicalID(inMenu: MenuRef; inItem: SInt16; VAR outHierID: MenuID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050E, $A825;
	{$ENDC}

{
 *  SetMenuItemFontID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuItemFontID(inMenu: MenuRef; inItem: SInt16; inFontID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040F, $A825;
	{$ENDC}

{
 *  GetMenuItemFontID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuItemFontID(inMenu: MenuRef; inItem: SInt16; VAR outFontID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0510, $A825;
	{$ENDC}

{
 *  SetMenuItemRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuItemRefCon(inMenu: MenuRef; inItem: SInt16; inRefCon: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050A, $A825;
	{$ENDC}

{
 *  GetMenuItemRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuItemRefCon(inMenu: MenuRef; inItem: SInt16; VAR outRefCon: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050B, $A825;
	{$ENDC}

{  Please use the menu item property APIs in Carbon. }
{$IFC CALL_NOT_IN_CARBON }
{
 *  SetMenuItemRefCon2()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION SetMenuItemRefCon2(inMenu: MenuRef; inItem: SInt16; inRefCon2: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0511, $A825;
	{$ENDC}

{
 *  GetMenuItemRefCon2()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetMenuItemRefCon2(inMenu: MenuRef; inItem: SInt16; VAR outRefCon2: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0512, $A825;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  SetMenuItemKeyGlyph()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuItemKeyGlyph(inMenu: MenuRef; inItem: SInt16; inGlyph: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0513, $A825;
	{$ENDC}

{
 *  GetMenuItemKeyGlyph()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuItemKeyGlyph(inMenu: MenuRef; inItem: SInt16; VAR outGlyph: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0514, $A825;
	{$ENDC}

{  Routines available in Mac OS 8.5 and later (supporting enabling/disabling of > 31 items) }

{
 *  [Mac]EnableMenuItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE EnableMenuItem(theMenu: MenuRef; item: MenuItemIndex);

{
 *  DisableMenuItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisableMenuItem(theMenu: MenuRef; item: MenuItemIndex);

{
 *  IsMenuItemEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsMenuItemEnabled(menu: MenuRef; item: MenuItemIndex): BOOLEAN;

{
 *  EnableMenuItemIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE EnableMenuItemIcon(theMenu: MenuRef; item: MenuItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0019, $A825;
	{$ENDC}

{
 *  DisableMenuItemIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisableMenuItemIcon(theMenu: MenuRef; item: MenuItemIndex);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0020, $A825;
	{$ENDC}

{
 *  IsMenuItemIconEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsMenuItemIconEnabled(menu: MenuRef; item: MenuItemIndex): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0018, $A825;
	{$ENDC}

{
 *  SetMenuItemHierarchicalMenu()
 *  
 *  Summary:
 *    Attaches a submenu to a menu item.
 *  
 *  Discussion:
 *    Using SetMenuItemHierarchicalMenu, it is possible to directly
 *    specify the submenu for a menu item without specifying its menu
 *    ID. It is not necessary to insert the submenu into the
 *    hierarchical portion of the menubar, and it is not necessary for
 *    the submenu to have a unique menu ID; it is recommended that you
 *    use 0 as the menu ID for the submenu, and identify selections
 *    from the menu by command ID.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The parent menu.
 *    
 *    inItem:
 *      The parent item.
 *    
 *    inHierMenu:
 *      The submenu.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuItemHierarchicalMenu(inMenu: MenuRef; inItem: MenuItemIndex; inHierMenu: MenuRef): OSStatus;

{
 *  GetMenuItemHierarchicalMenu()
 *  
 *  Summary:
 *    Returns the submenu attached to a menu item.
 *  
 *  Discussion:
 *    GetMenuItemHierarchicalMenu will return the submenu attached to a
 *    menu item regardless of how the submenu was specified. If the
 *    submenu was specified by menu ID (using SetItemCmd or
 *    SetMenuItemHierarchicalID), GetMenuItemHierarchicalMenu will
 *    return the currently installed menu with that ID, if any. The
 *    only case where GetMenuItemHierarchicalMenu will fail to return
 *    the item's submenu is when the submenu is specified by menu ID,
 *    but the submenu is not currently inserted in the menu bar.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The parent menu.
 *    
 *    inItem:
 *      The parent item.
 *    
 *    outHierMenu:
 *      On exit, the item's submenu, or NULL if it does not have one.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuItemHierarchicalMenu(inMenu: MenuRef; inItem: MenuItemIndex; VAR outHierMenu: MenuRef): OSStatus;

{
 *  CopyMenuItemTextAsCFString()
 *  
 *  Summary:
 *    Returns a CFString containing the text of a menu item.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu containing the item.
 *    
 *    inItem:
 *      The item whose text to return.
 *    
 *    outString:
 *      On exit, a CFString containing the item's text. This string
 *      must be released by the caller.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CopyMenuItemTextAsCFString(inMenu: MenuRef; inItem: MenuItemIndex; VAR outString: CFStringRef): OSStatus;

{
 *  SetMenuItemTextWithCFString()
 *  
 *  Summary:
 *    Sets the text of a menu item to the text contained in a CFString.
 *  
 *  Discussion:
 *    The Menu Manager will make its own copy of the CFString before
 *    returning from SetMenuItemTextWithCFString. Modifying the string
 *    after calling SetMenuItemTextWithCFString will have no effect on
 *    the item's actual text. The caller may release the string after
 *    calling SetMenuItemTextWithCFString.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu containing the item.
 *    
 *    inItem:
 *      The item whose text to return.
 *    
 *    inString:
 *      The string containing the new menu item text.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuItemTextWithCFString(inMenu: MenuRef; inItem: MenuItemIndex; inString: CFStringRef): OSStatus;

{
 *  GetMenuItemIndent()
 *  
 *  Summary:
 *    Gets the indent level of a menu item.
 *  
 *  Discussion:
 *    The indent level of an item is an amount of extra space added to
 *    the left of the item's icon or checkmark. The level is simply a
 *    number, starting at zero, which the Menu Manager multiplies by a
 *    constant to get the indent in pixels. The default indent level is
 *    zero.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu containing the item.
 *    
 *    inItem:
 *      The item whose indent to retrieve.
 *    
 *    outIndent:
 *      On exit, the indent level of the item.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuItemIndent(inMenu: MenuRef; inItem: MenuItemIndex; VAR outIndent: UInt32): OSStatus;

{
 *  SetMenuItemIndent()
 *  
 *  Summary:
 *    Sets the indent level of a menu item.
 *  
 *  Discussion:
 *    The indent level of an item is an amount of extra space added to
 *    the left of the item's icon or checkmark. The level is simply a
 *    number, starting at zero, which the Menu Manager multiplies by a
 *    constant to get the indent in pixels. The default indent level is
 *    zero.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu containing the item.
 *    
 *    inItem:
 *      The item whose indent to set.
 *    
 *    inIndent:
 *      The new indent level of the item.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuItemIndent(inMenu: MenuRef; inItem: MenuItemIndex; inIndent: UInt32): OSStatus;

{
 *  GetMenuItemCommandKey()
 *  
 *  Summary:
 *    Gets the keyboard equivalent of a menu item.
 *  
 *  Discussion:
 *    A menu item's keyboard equivalent may be either a character code
 *    or a virtual keycode. An item's character code and virtual
 *    keycode are stored separately and may contain different values,
 *    but only one is used by the Menu Manager at any given time. When
 *    requesting a menu item's virtual keycode equivalent, you should
 *    first check that the item is using a virtual keycode by testing
 *    the kMenuItemAttrUseVirtualKey attribute for that item. If this
 *    attribute is not set, the item's virtual keycode is ignored by
 *    the Menu Manager. Note that zero is a valid virtual keycode, so
 *    you cannot test the returned keycode against zero to determine if
 *    the item is using a virtual keycode equivalent. You must test the
 *    kMenuItemAttrUseVirtualKey attribute.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu containing the item.
 *    
 *    inItem:
 *      The item whose keyboard equivalent to retrieve.
 *    
 *    inGetVirtualKey:
 *      Indicates whether to retrieve the item's character code or
 *      virtual keycode equivalent.
 *    
 *    outKey:
 *      On exit, the keyboard equivalent of the item.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuItemCommandKey(inMenu: MenuRef; inItem: MenuItemIndex; inGetVirtualKey: BOOLEAN; VAR outKey: UInt16): OSStatus;

{
 *  SetMenuItemCommandKey()
 *  
 *  Summary:
 *    Sets the keyboard equivalent of a menu item.
 *  
 *  Discussion:
 *    A menu item's keyboard equivalent may be either a character code
 *    or a virtual keycode. The character code is always used to draw
 *    the item's keyboard equivalent in the menu, but either may be
 *    used for keyboard equivalent matching by MenuEvent and
 *    IsMenuKeyEvent, depending on whether the
 *    kMenuItemAttrUseVirtualKey item attribute is set. If
 *    SetMenuItemCommandKey is used to set the virtual keycode
 *    equivalent for a menu item, it also automatically sets the
 *    kMenuItemAttrUseVirtualKey item attribute. To make the menu item
 *    stop using the virtual keycode equivalent and use the character
 *    code equivalent instead, use ChangeMenuItemAttributes to clear
 *    the kMenuItemAttrUseVirtualKey item attribute.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu containing the item.
 *    
 *    inItem:
 *      The item whose keyboard equivalent to set.
 *    
 *    inSetVirtualKey:
 *      Indicates whether to set the item's character code or virtual
 *      keycode equivalent.
 *    
 *    inKey:
 *      The item's new character code or virtual keycode equivalent.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuItemCommandKey(inMenu: MenuRef; inItem: MenuItemIndex; inSetVirtualKey: BOOLEAN; inKey: UInt16): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu Item Color Tables                                                            }
{                                                                                      }
{  Menu color manipulation is considered deprecated with the advent of the Appearance  }
{  Manager.  Avoid using these routines if possible                                    }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  DeleteMCEntries()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DeleteMCEntries(menuID: MenuID; menuItem: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA60;
	{$ENDC}

{
 *  GetMCInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMCInfo: MCTableHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA61;
	{$ENDC}

{
 *  SetMCInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetMCInfo(menuCTbl: MCTableHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA62;
	{$ENDC}

{
 *  DisposeMCInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMCInfo(menuCTbl: MCTableHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA63;
	{$ENDC}

{
 *  GetMCEntry()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMCEntry(menuID: MenuID; menuItem: INTEGER): MCEntryPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA64;
	{$ENDC}

{
 *  SetMCEntries()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetMCEntries(numEntries: INTEGER; menuCEntries: MCTablePtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA65;
	{$ENDC}


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Properties  (Mac OS 8.5 and later)                                                 }
{                                                                                      }
{ With the following property APIs, you can attach any piece of data you'd like to a   }
{ menu or menu item. Passing zero for the item number parameter indicates you'd like   }
{ to attach the data to the menu itself, and not to any specific menu item.            }
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	kMenuPropertyPersistent		= $00000001;					{  whether this property gets saved when flattening the menu }

	{
	 *  GetMenuItemProperty()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in MenusLib 8.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION GetMenuItemProperty(menu: MenuRef; item: MenuItemIndex; propertyCreator: OSType; propertyTag: OSType; bufferSize: UInt32; VAR actualSize: UInt32; propertyBuffer: UNIV Ptr): OSStatus;

{
 *  GetMenuItemPropertySize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuItemPropertySize(menu: MenuRef; item: MenuItemIndex; propertyCreator: OSType; propertyTag: OSType; VAR size: UInt32): OSStatus;

{
 *  SetMenuItemProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuItemProperty(menu: MenuRef; item: MenuItemIndex; propertyCreator: OSType; propertyTag: OSType; propertySize: UInt32; propertyData: UNIV Ptr): OSStatus;

{
 *  RemoveMenuItemProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MenusLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveMenuItemProperty(menu: MenuRef; item: MenuItemIndex; propertyCreator: OSType; propertyTag: OSType): OSStatus;

{
 *  GetMenuItemPropertyAttributes()
 *  
 *  Summary:
 *    Gets the attributes of a menu item property.
 *  
 *  Parameters:
 *    
 *    menu:
 *      The menu.
 *    
 *    item:
 *      The menu item.
 *    
 *    propertyCreator:
 *      The creator code of the property.
 *    
 *    propertyTag:
 *      The property tag.
 *    
 *    attributes:
 *      On exit, contains the attributes of the property.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuItemPropertyAttributes(menu: MenuRef; item: MenuItemIndex; propertyCreator: OSType; propertyTag: OSType; VAR attributes: UInt32): OSStatus;

{
 *  ChangeMenuItemPropertyAttributes()
 *  
 *  Summary:
 *    Changes the attributes of a menu item property.
 *  
 *  Parameters:
 *    
 *    menu:
 *      The menu.
 *    
 *    item:
 *      The menu item.
 *    
 *    propertyCreator:
 *      The creator code of the property.
 *    
 *    propertyTag:
 *      The property tag.
 *    
 *    attributesToSet:
 *      The attributes to add to the menu item property.
 *    
 *    attributesToClear:
 *      The attributes to remove from the menu item property.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ChangeMenuItemPropertyAttributes(menu: MenuRef; item: MenuItemIndex; propertyCreator: OSType; propertyTag: OSType; attributesToSet: UInt32; attributesToClear: UInt32): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Attributes (Carbon and later)                                                     }
{                                                                                      }
{  Each menu and menu item has attribute flags.                                        }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  GetMenuAttributes()
 *  
 *  Summary:
 *    Gets the attributes of a menu.
 *  
 *  Parameters:
 *    
 *    menu:
 *      The menu.
 *    
 *    outAttributes:
 *      On exit, contains the attributes of the menu.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuAttributes(menu: MenuRef; VAR outAttributes: MenuAttributes): OSStatus;

{
 *  ChangeMenuAttributes()
 *  
 *  Summary:
 *    Changes the attributes of a menu.
 *  
 *  Parameters:
 *    
 *    menu:
 *      The menu.
 *    
 *    setTheseAttributes:
 *      The attributes to add to the menu.
 *    
 *    clearTheseAttributes:
 *      The attributes to remove from the menu.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ChangeMenuAttributes(menu: MenuRef; setTheseAttributes: MenuAttributes; clearTheseAttributes: MenuAttributes): OSStatus;

{
 *  GetMenuItemAttributes()
 *  
 *  Summary:
 *    Gets the attributes of a menu item.
 *  
 *  Parameters:
 *    
 *    menu:
 *      The menu.
 *    
 *    item:
 *      The menu item.
 *    
 *    outAttributes:
 *      On exit, contains the attributes of the menu item.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuItemAttributes(menu: MenuRef; item: MenuItemIndex; VAR outAttributes: MenuItemAttributes): OSStatus;

{
 *  ChangeMenuItemAttributes()
 *  
 *  Summary:
 *    Changes the attributes of a menu item.
 *  
 *  Parameters:
 *    
 *    menu:
 *      The menu.
 *    
 *    item:
 *      The menu item.
 *    
 *    setTheseAttributes:
 *      The attributes to add to the menu item.
 *    
 *    clearTheseAttributes:
 *      The attributes to remove from the menu item.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ChangeMenuItemAttributes(menu: MenuRef; item: MenuItemIndex; setTheseAttributes: MenuItemAttributes; clearTheseAttributes: MenuItemAttributes): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Mass menu item enabling and disabling (Carbon and later)                          }
{                                                                                      }
{  Useful when rewriting code that modifies the enableFlags field directly.            }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  DisableAllMenuItems()
 *  
 *  Summary:
 *    Disables all items in a menu.
 *  
 *  Discussion:
 *    This API is equivalent to pre-Carbon code that masked the
 *    enableFlags field of the MenuInfo with 0x01. It disables all
 *    items (including items past item 31) but does not affect the
 *    state of the menu title.
 *  
 *  Parameters:
 *    
 *    theMenu:
 *      The menu whose items to disable.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisableAllMenuItems(theMenu: MenuRef);

{
 *  EnableAllMenuItems()
 *  
 *  Summary:
 *    Enables all items in a menu.
 *  
 *  Discussion:
 *    This API is equivalent to pre-Carbon code that or'd the
 *    enableFlags field of the MenuInfo with 0xFFFFFFFE. It enables all
 *    items (including items past item 31) but does not affect the
 *    state of the menu title.
 *  
 *  Parameters:
 *    
 *    theMenu:
 *      The menu whose items to enable.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE EnableAllMenuItems(theMenu: MenuRef);

{
 *  MenuHasEnabledItems()
 *  
 *  Summary:
 *    Determines if any items in a menu are enabled.
 *  
 *  Discussion:
 *    This API is equivalent to pre-Carbon code that compared the
 *    enableFlags field of the MenuInfo with 0. It checks the enable
 *    state of all items to see if any are enabled, but ignores the
 *    state of the menu title. It will return true even if the menu
 *    title is disabled.
 *  
 *  Parameters:
 *    
 *    theMenu:
 *      The menu whose items to examine.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MenuHasEnabledItems(theMenu: MenuRef): BOOLEAN;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Menu tracking status (Carbon and later)                                           }
{                                                                                      }
{  Get info about the selected menu item during menu tracking. Replaces direct access  }
{  to low-mem globals that previously held this info.                                  }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  GetMenuTrackingData()
 *  
 *  Summary:
 *    Gets information about the menu currently selected by the user.
 *  
 *  Discussion:
 *    This API replaces direct access to the low-memory globals
 *    TopMenuItem, AtMenuBottom, MenuDisable, and mbSaveLoc. It is only
 *    valid to call this API while menu tracking is occurring. This API
 *    will most commonly be used by custom MDEFs.
 *  
 *  Parameters:
 *    
 *    theMenu:
 *      The menu about which to get tracking information. May be NULL
 *      to get information about the menu that the user is currently
 *      selecting. If the menu is not currently open, menuNotFoundErr
 *      is returned.
 *    
 *    outData:
 *      On exit, contains tracking data about the menu. On CarbonLib,
 *      the itemRect field is not supported and is always set to an
 *      empty rect.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuTrackingData(theMenu: MenuRef; VAR outData: MenuTrackingData): OSStatus;

{
 *  GetMenuType()
 *  
 *  Summary:
 *    Gets the display type (pulldown, hierarchical, or popup) of a
 *    menu.
 *  
 *  Discussion:
 *    This API may only be called when the menu is displayed. If the
 *    menu is not currently open, an error is returned. The display
 *    type of a menu may vary from one menu tracking session to
 *    another; for example, the same menu might be displayed as a
 *    pulldown menu and as a popup menu.
 *  
 *  Parameters:
 *    
 *    theMenu:
 *      The menu whose type to get.
 *    
 *    outType:
 *      On exit, the type of the menu. The returned value will be one
 *      of the ThemeMenuType constants: kThemeMenuTypePullDown, PopUp,
 *      or Hierarchical. The kThemeMenuTypeInactive bit will never be
 *      set.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuType(theMenu: MenuRef; VAR outType: UInt16): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Universal command ID access (Carbon and later)                                    }
{                                                                                      }
{  These APIs allow you to operate on menu items strictly by command ID, with no       }
{  knowledge of a menu item's index.                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  CountMenuItemsWithCommandID()
 *  
 *  Summary:
 *    Counts the menu items with a specified command ID.
 *  
 *  Discussion:
 *    In CarbonLib 1.0.x and 1.1, this API will always return zero or
 *    one; it stops after finding the first menu item with the
 *    specified command ID. In CarbonLib 1.2 and Mac OS X 1.0, it will
 *    count all menu items with the specified command ID.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu in which to begin searching for items with the
 *      specified command ID. Pass NULL to hegin searching with the
 *      root menu. The search will descend into all submenus of this
 *      menu.
 *    
 *    inCommandID:
 *      The command ID for which to search.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CountMenuItemsWithCommandID(inMenu: MenuRef; inCommandID: MenuCommand): ItemCount;

{
 *  GetIndMenuItemWithCommandID()
 *  
 *  Summary:
 *    Finds a menu item with a specified command ID.
 *  
 *  Discussion:
 *    This API searches the specified menu and its submenus for the
 *    n'th menu item with the specified command ID. In CarbonLib 1.0.x
 *    and 1.1, only the first menu item will be returned. In CarbonLib
 *    1.2 and Mac OS X 1.0, this API will iterate over all menu items
 *    with the specified command ID.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu in which to begin searching for items with the
 *      specified command ID. Pass NULL to hegin searching with the
 *      root menu. The search will descend into all submenus of this
 *      menu.
 *    
 *    inCommandID:
 *      The command ID for which to search.
 *    
 *    inItemIndex:
 *      The 1-based index of the menu item to retrieve. In CarbonLib
 *      1.0.x and 1.1, this parameter must be 1. In CarbonLib 1.2 and
 *      Mac OS X 1.0, this parameter may vary from 1 to the number of
 *      menu items with the specified command ID.
 *    
 *    outMenu:
 *      On exit, the menu containing the menu item with the specified
 *      command ID.
 *    
 *    outIndex:
 *      On exit, the item index of the menu item with the specified
 *      command ID.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIndMenuItemWithCommandID(inMenu: MenuRef; inCommandID: MenuCommand; inItemIndex: UInt32; VAR outMenu: MenuRef; VAR outIndex: MenuItemIndex): OSStatus;

{
 *  EnableMenuCommand()
 *  
 *  Summary:
 *    Enables the menu item with a specified command ID.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu in which to begin searching for the item. Pass NULL to
 *      begin searching with the root menu. The search will descend
 *      into all submenus of this menu.
 *    
 *    inCommandID:
 *      The command ID of the menu item to be enabled. If more than one
 *      item has this command ID, only the first will be enabled.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE EnableMenuCommand(inMenu: MenuRef; inCommandID: MenuCommand);

{
 *  DisableMenuCommand()
 *  
 *  Summary:
 *    Disables the menu item with a specified command ID.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu in which to begin searching for the item. Pass NULL to
 *      begin searching with the root menu. The search will descend
 *      into all submenus of this menu.
 *    
 *    inCommandID:
 *      The command ID of the menu item to be disabled. If more than
 *      one item has this command ID, only the first will be disabled.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisableMenuCommand(inMenu: MenuRef; inCommandID: MenuCommand);

{
 *  IsMenuCommandEnabled()
 *  
 *  Summary:
 *    Determines if the menu item with a specified command ID is
 *    enabled.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu in which to begin searching for the item. Pass NULL to
 *      begin searching with the root menu. The search will descend
 *      into all submenus of this menu.
 *    
 *    inCommandID:
 *      The command ID of the menu item to examine. If more than one
 *      item has this command ID, only the first will be examined.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsMenuCommandEnabled(inMenu: MenuRef; inCommandID: MenuCommand): BOOLEAN;

{
 *  SetMenuCommandMark()
 *  
 *  Summary:
 *    Locates the menu item with a specified command ID and sets its
 *    mark character.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu in which to begin searching for the item. Pass NULL to
 *      begin searching with the root menu. The search will descend
 *      into all submenus of this menu.
 *    
 *    inCommandID:
 *      The command ID of the menu item to be modified. If more than
 *      one item has this command ID, only the first will be modified.
 *    
 *    inMark:
 *      The new mark character. This is a Unicode character. On Mac OS
 *      8.x, the low byte of this character will be used as the mark
 *      character. On Mac OS X, the entire UniChar will be used and
 *      drawn.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuCommandMark(inMenu: MenuRef; inCommandID: MenuCommand; inMark: UniChar): OSStatus;

{
 *  GetMenuCommandMark()
 *  
 *  Summary:
 *    Locates the menu item with a specified command ID and returns its
 *    mark character.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu in which to begin searching for the item. Pass NULL to
 *      begin searching with the root menu. The search will descend
 *      into all submenus of this menu.
 *    
 *    inCommandID:
 *      The command ID of the menu item to be examined. If more than
 *      one item has this command ID, only the first will be examined.
 *    
 *    outMark:
 *      On exit, the menu item's mark character.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuCommandMark(inMenu: MenuRef; inCommandID: MenuCommand; VAR outMark: UniChar): OSStatus;

{
 *  GetMenuCommandProperty()
 *  
 *  Summary:
 *    Retrives property data for a menu item with a specified command
 *    ID.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu in which to begin searching for the item. Pass NULL to
 *      begin searching with the root menu. The search will descend
 *      into all submenus of this menu.
 *    
 *    inCommandID:
 *      The command ID of the menu item containing the property. If
 *      more than one item has this command ID, only the first will be
 *      used.
 *    
 *    inPropertyCreator:
 *      The property creator.
 *    
 *    inPropertyTag:
 *      The property tag.
 *    
 *    inBufferSize:
 *      The size of the output buffer, in bytes.
 *    
 *    outActualSize:
 *      On exit, contains the actual size of the property data. May be
 *      NULL if you do not need this information.
 *    
 *    inPropertyBuffer:
 *      The address of a buffer in which to place the property data.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuCommandProperty(inMenu: MenuRef; inCommandID: MenuCommand; inPropertyCreator: OSType; inPropertyTag: OSType; inBufferSize: ByteCount; VAR outActualSize: ByteCount; inPropertyBuffer: UNIV Ptr): OSStatus;

{
 *  GetMenuCommandPropertySize()
 *  
 *  Summary:
 *    Retrives the size of property data for a menu item with a
 *    specified command ID.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu in which to begin searching for the item. Pass NULL to
 *      begin searching with the root menu. The search will descend
 *      into all submenus of this menu.
 *    
 *    inCommandID:
 *      The command ID of the menu item containing the property. If
 *      more than one item has this command ID, only the first will be
 *      used.
 *    
 *    inPropertyCreator:
 *      The property creator.
 *    
 *    inPropertyTag:
 *      The property tag.
 *    
 *    outSize:
 *      On exit, contains the size of the property data.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuCommandPropertySize(inMenu: MenuRef; inCommandID: MenuCommand; inPropertyCreator: OSType; inPropertyTag: OSType; VAR outSize: ByteCount): OSStatus;

{
 *  SetMenuCommandProperty()
 *  
 *  Summary:
 *    Sets property data for a menu item with a specified command ID.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu in which to begin searching for the item. Pass NULL to
 *      begin searching with the root menu. The search will descend
 *      into all submenus of this menu.
 *    
 *    inCommandID:
 *      The command ID of the menu item that will receive the property.
 *      If more than one item has this command ID, only the first will
 *      be modified.
 *    
 *    inPropertyCreator:
 *      The property creator.
 *    
 *    inPropertyTag:
 *      The property tag.
 *    
 *    inPropertySize:
 *      The size of the property data, in bytes.
 *    
 *    inPropertyData:
 *      The address of the property data.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuCommandProperty(inMenu: MenuRef; inCommandID: MenuCommand; inPropertyCreator: OSType; inPropertyTag: OSType; inPropertySize: ByteCount; inPropertyData: UNIV Ptr): OSStatus;

{
 *  RemoveMenuCommandProperty()
 *  
 *  Summary:
 *    Removes a property from a menu item with a specified command ID.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu in which to begin searching for the item. Pass NULL to
 *      begin searching with the root menu. The search will descend
 *      into all submenus of this menu.
 *    
 *    inCommandID:
 *      The command ID of the menu item from which the property will be
 *      removed. If more than one item has this command ID, only the
 *      first will be modified.
 *    
 *    inPropertyCreator:
 *      The property creator.
 *    
 *    inPropertyTag:
 *      The property tag.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveMenuCommandProperty(inMenu: MenuRef; inCommandID: MenuCommand; inPropertyCreator: OSType; inPropertyTag: OSType): OSStatus;


{
 *  CopyMenuItemData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CopyMenuItemData(menu: MenuRef; item: MenuItemID; isCommandID: BOOLEAN; outData: MenuItemDataPtr): OSStatus;

{
 *  SetMenuItemData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuItemData(menu: MenuRef; item: MenuItemID; isCommandID: BOOLEAN; {CONST}VAR data: MenuItemDataRec): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{  • Dynamic menu item support (CarbonLib 1.1 and Carbon for Mac OS X, and later)      }
{                                                                                      }
{  Dynamic menu item support allows a menu item to be redrawn while the menu is open   }
{  and visible to the user. Carbon contains automatic support for dynamic items based  }
{  on keyboard modifier state. If you need to implement your own variable item state   }
{  based on other system state, you can use these APIs to implement it.                }
{                                                                                      }
{  To use the built-in support for dynamic items, you should create a menu containing  }
{  several contiguous items with the same command key but different text and modifier  }
{  keys. For example, you might have:                                                  }
{                                                                                      }
{      Close       cmd-W                                                               }
{      Close All   cmd-option-W                                                        }
{                                                                                      }
{  In your MENU resource, you would create the Close and Close All items and give      }
{  them each the letter 'W' as the command key; using an associated xmnu resource,     }
{  you would specify kMenuOptionModifier as the modifier for the Close All item.       }
{                                                                                      }
{  After loading your menu from the resource, you must set the kMenuItemAttrDynamic    }
{  flag for each dynamic item. In this example, you would use:                         }
{                                                                                      }
{      ChangeMenuItemAttributes( menu, kCloseItem, kMenuItemAttrDynamic, 0 );          }
{      ChangeMenuItemAttributes( menu, kCloseAllItem, kMenuItemAttrDynamic, 0 );       }
{                                                                                      }
{  The Menu Manager will now automatically display the correct item depending on       }
{  whether the Option key is pressed. The result from MenuSelect will be the item      }
{  number of the item that was visible when the menu closed.                           }
{                                                                                      }
{  If the Menu Manager's built-in support is not sufficient, you can also change the   }
{  attributes of an item yourself and use the UpdateInvalidMenuItems API to cause      }
{  the menu to redraw. Changes to a menu item (changing text, command key, style,      }
{  etc.) that occur while the menu is open will cause the menu item to be invalidated, }
{  but not redrawn. If you need to invalidate the item explicitly yourself, perhaps    }
{  because you have a custom MDEF that depends on state not accessed using Menu        }
{  Manager APIs, you can use the InvalidateMenuItems API. UpdateInvalidMenuItems will  }
{  scan the menu for invalid items and redraw each, clearing its invalid flag          }
{  afterwards.                                                                         }
{                                                                                      }
{  If you need to change menu contents based on modifier key state without using the   }
{  built-in support in the Menu Manager, we recommend that you install a Carbon event  }
{  handler on your menu for the [kEventClassKeyboard, kEventRawKeyModifiersChanged]    }
{  event. Modifier key events are passed to the currently open menu before being sent  }
{  to the user focus target.                                                           }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  IsMenuItemInvalid()
 *  
 *  Summary:
 *    Determines if a menu item is invalid and should be redrawn.
 *  
 *  Parameters:
 *    
 *    menu:
 *      The menu whose item to examine.
 *    
 *    item:
 *      The item to examine.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsMenuItemInvalid(menu: MenuRef; item: MenuItemIndex): BOOLEAN;

{
 *  InvalidateMenuItems()
 *  
 *  Summary:
 *    Invalidates a group of menu items so that they will be redrawn
 *    when UpdateInvalidMenuItems is next called.
 *  
 *  Discussion:
 *    Menu items are automatically invalidated when their contents are
 *    changed using Menu Manager APIs while the menu is open. However,
 *    you might need to use this API if you have a custom MDEF that
 *    draws using state not contained in the menu.
 *  
 *  Parameters:
 *    
 *    menu:
 *      The menu whose items to invalidate.
 *    
 *    firstItem:
 *      The first item to invalidate.
 *    
 *    numItems:
 *      The number of items to invalidate.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvalidateMenuItems(menu: MenuRef; firstItem: MenuItemIndex; numItems: ItemCount): OSStatus;

{
 *  UpdateInvalidMenuItems()
 *  
 *  Summary:
 *    Redraws the invalid items of an open menu.
 *  
 *  Discussion:
 *    It is not necessary to use UpdateInvalidMenuItems if you are
 *    using Carbon's built-in support for dynamic items based on
 *    modifier key state. However, if you are modifying items
 *    dynamically using your own implementation, you should call
 *    UpdateInvalidMenuItems after completing your modifications for a
 *    single menu. It will redraw any items that have been marked as
 *    invalid, and clear the invalid flag for those items.
 *  
 *  Parameters:
 *    
 *    menu:
 *      The menu to update.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UpdateInvalidMenuItems(menu: MenuRef): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{  • Standard font menu (Carbon and later)                                             }
{                                                                                      }
{  These APIs allow you to create and use the standard font menu.                      }
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	kHierarchicalFontMenuOption	= $00000001;

	{
	 *  CreateStandardFontMenu()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateStandardFontMenu(menu: MenuRef; afterItem: MenuItemIndex; firstHierMenuID: MenuID; options: OptionBits; VAR outHierMenuCount: ItemCount): OSStatus;

{
 *  UpdateStandardFontMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UpdateStandardFontMenu(menu: MenuRef; VAR outHierMenuCount: ItemCount): OSStatus;

{
 *  GetFontFamilyFromMenuSelection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetFontFamilyFromMenuSelection(menu: MenuRef; item: MenuItemIndex; VAR outFontFamily: FMFontFamily; VAR outStyle: FMFontStyle): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{  • Contextual Menu routines and constants                                            }
{  available with Conxtextual Menu extension 1.0 and later                             }
{——————————————————————————————————————————————————————————————————————————————————————}
{ Gestalt Selector for classic 68K apps only. }
{ CFM apps should weak link and check the symbols. }

CONST
	gestaltContextualMenuAttr	= 'cmnu';
	gestaltContextualMenuUnusedBit = 0;
	gestaltContextualMenuTrapAvailable = 1;

	{	 Values indicating what kind of help the application supports 	}
	kCMHelpItemNoHelp			= 0;
	kCMHelpItemAppleGuide		= 1;
	kCMHelpItemOtherHelp		= 2;

	{	 Values indicating what was chosen from the menu 	}
	kCMNothingSelected			= 0;
	kCMMenuItemSelected			= 1;
	kCMShowHelpSelected			= 3;

	{
	 *  InitContextualMenus()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in ContextualMenu 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION InitContextualMenus: OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7001, $AA72;
	{$ENDC}

{
 *  IsShowContextualMenuClick()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ContextualMenu 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsShowContextualMenuClick({CONST}VAR inEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AA72;
	{$ENDC}

{
 *  IsShowContextualMenuEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsShowContextualMenuEvent(inEvent: EventRef): BOOLEAN;

{
 *  ContextualMenuSelect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ContextualMenu 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ContextualMenuSelect(inMenu: MenuRef; inGlobalLocation: Point; inReserved: BOOLEAN; inHelpType: UInt32; inHelpItemString: ConstStringPtr; inSelection: {Const}AEDescPtr; VAR outUserSelectionType: UInt32; VAR outMenuID: SInt16; VAR outMenuItem: MenuItemIndex): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7003, $AA72;
	{$ENDC}

{
 *  ProcessIsContextualMenuClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ContextualMenu 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ProcessIsContextualMenuClient(VAR inPSN: ProcessSerialNumber): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7004, $AA72;
	{$ENDC}


{——————————————————————————————————————————————————————————————————————————————————————}
{  • Contextual Menu Plugin Notes                                                      }
{                                                                                      }
{  For Mac OS X, we will support a new type of Contextual Menu Plugin: the CFM-based   }
{  plugin. Each plugin must be a separate file in the Contextual Menu Items subfolder  }
{  of the system folder. It must export two functions and has the option of exporting  }
{  a third; these three functions are virtually identical to the methods that must be  }
{  supported by a SOM-based plugin.                                                        }
{                                                                                      }
{  The required symbols must be named "ExamineContext" and "HandleSelection".          }
{  The optional symbol must be named "PostMenuCleanup".                                }
{                                                                                      }
{  The ExamineContext routine must have the following prototype:                       }
{      pascal OSStatus ExamineContext( const AEDesc* inContext,                        }
{                                      AEDescList* outCommandPairs );                  }
{                                                                                      }
{  The HandleSelection routine must have the following prototype:                      }
{      pascal OSStatus HandleSelection(    const AEDesc* inContext,                    }
{                                          SInt32 inCommandID );                       }
{                                                                                      }
{  The PostMenuCleanup routine must have the following prototype:                      }
{      pascal void PostMenuCleanup(     void );                                            }
{——————————————————————————————————————————————————————————————————————————————————————}

{ previously in LowMem.h.  This functions return the menu ID of the hilited menu }
{
 *  LMGetTheMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LMGetTheMenu: SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3EB8, $0A26;
	{$ENDC}



{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
{
 *  AddResMenu()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE AddResMenu(theMenu: MenuRef; theType: ResType);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94D;
	{$ENDC}

{
 *  InsMenuItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InsMenuItem(theMenu: MenuRef; itemString: Str255; afterItem: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A826;
	{$ENDC}

{
 *  DelMenuItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DelMenuItem(theMenu: MenuRef; item: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A952;
	{$ENDC}

{
 *  SetItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetItem(theMenu: MenuRef; item: INTEGER; itemString: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A947;
	{$ENDC}

{
 *  GetItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetItem(theMenu: MenuRef; item: INTEGER; VAR itemString: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A946;
	{$ENDC}

{
 *  GetMHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetMHandle(menuID: MenuID): MenuRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A949;
	{$ENDC}

{
 *  DelMCEntries()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DelMCEntries(menuID: MenuID; menuItem: INTEGER);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA60;
	{$ENDC}

{
 *  DispMCInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DispMCInfo(menuCTbl: MCTableHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA63;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}

{$IFC ACCESSOR_CALLS_ARE_FUNCTIONS }
{ Getters }
{
 *  GetMenuID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuID(menu: MenuRef): MenuID;

{
 *  GetMenuWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuWidth(menu: MenuRef): SInt16;

{
 *  GetMenuHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuHeight(menu: MenuRef): SInt16;

{
 *  GetMenuTitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuTitle(menu: MenuRef; VAR title: Str255): StringPtr;

{
 *  GetMenuDefinition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuDefinition(menu: MenuRef; outDefSpec: MenuDefSpecPtr): OSStatus;

{ Setters }
{
 *  SetMenuID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetMenuID(menu: MenuRef; menuID: MenuID);

{
 *  SetMenuWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetMenuWidth(menu: MenuRef; width: SInt16);

{
 *  SetMenuHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetMenuHeight(menu: MenuRef; height: SInt16);

{
 *  SetMenuTitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuTitle(menu: MenuRef; title: Str255): OSStatus;

{
 *  SetMenuDefinition()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetMenuDefinition(menu: MenuRef; {CONST}VAR defSpec: MenuDefSpec): OSStatus;

{$ENDC}  {ACCESSOR_CALLS_ARE_FUNCTIONS}




{$IFC TARGET_OS_WIN32 }
{$ENDC}  {TARGET_OS_WIN32}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MenusIncludes}

{$ENDC} {__MENUS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

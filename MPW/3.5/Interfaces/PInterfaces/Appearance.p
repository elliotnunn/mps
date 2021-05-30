{
     File:       Appearance.p
 
     Contains:   Appearance Manager Interfaces.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Appearance;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __APPEARANCE__}
{$SETC __APPEARANCE__ := 1}

{$I+}
{$SETC AppearanceIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}
{$IFC UNDEFINED __QDOFFSCREEN__}
{$I QDOffscreen.p}
{$ENDC}
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}
{$IFC UNDEFINED __TEXTUTILS__}
{$I TextUtils.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{——————————————————————————————————————————————————————————————————————————————————}
{ Appearance Manager constants, etc.                                               }
{——————————————————————————————————————————————————————————————————————————————————}
{ Appearance Manager Apple Events (1.1 and later)              }

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
	kAppearanceEventClass		= 'appr';						{  Event Class  }
	kAEAppearanceChanged		= 'thme';						{  Appearance changed (e.g. platinum to hi-tech)  }
	kAESystemFontChanged		= 'sysf';						{  system font changed  }
	kAESmallSystemFontChanged	= 'ssfn';						{  small system font changed  }
	kAEViewsFontChanged			= 'vfnt';						{  views font changed  }

	{	——————————————————————————————————————————————————————————————————————————————————	}
	{	 Appearance Manager file types                                                    	}
	{	——————————————————————————————————————————————————————————————————————————————————	}
	kThemeDataFileType			= 'thme';						{  file type for theme files  }
	kThemePlatinumFileType		= 'pltn';						{  file type for platinum appearance  }
	kThemeCustomThemesFileType	= 'scen';						{  file type for user themes  }
	kThemeSoundTrackFileType	= 'tsnd';


	kThemeBrushDialogBackgroundActive = 1;						{  Dialogs  }
	kThemeBrushDialogBackgroundInactive = 2;					{  Dialogs  }
	kThemeBrushAlertBackgroundActive = 3;
	kThemeBrushAlertBackgroundInactive = 4;
	kThemeBrushModelessDialogBackgroundActive = 5;
	kThemeBrushModelessDialogBackgroundInactive = 6;
	kThemeBrushUtilityWindowBackgroundActive = 7;				{  Miscellaneous  }
	kThemeBrushUtilityWindowBackgroundInactive = 8;				{  Miscellaneous  }
	kThemeBrushListViewSortColumnBackground = 9;				{  Finder  }
	kThemeBrushListViewBackground = 10;
	kThemeBrushIconLabelBackground = 11;
	kThemeBrushListViewSeparator = 12;
	kThemeBrushChasingArrows	= 13;
	kThemeBrushDragHilite		= 14;
	kThemeBrushDocumentWindowBackground = 15;
	kThemeBrushFinderWindowBackground = 16;

	{	 Brushes available in Appearance 1.1 or later 	}
	kThemeBrushScrollBarDelimiterActive = 17;
	kThemeBrushScrollBarDelimiterInactive = 18;
	kThemeBrushFocusHighlight	= 19;
	kThemeBrushPopupArrowActive	= 20;
	kThemeBrushPopupArrowPressed = 21;
	kThemeBrushPopupArrowInactive = 22;
	kThemeBrushAppleGuideCoachmark = 23;
	kThemeBrushIconLabelBackgroundSelected = 24;
	kThemeBrushStaticAreaFill	= 25;
	kThemeBrushActiveAreaFill	= 26;
	kThemeBrushButtonFrameActive = 27;
	kThemeBrushButtonFrameInactive = 28;
	kThemeBrushButtonFaceActive	= 29;
	kThemeBrushButtonFaceInactive = 30;
	kThemeBrushButtonFacePressed = 31;
	kThemeBrushButtonActiveDarkShadow = 32;
	kThemeBrushButtonActiveDarkHighlight = 33;
	kThemeBrushButtonActiveLightShadow = 34;
	kThemeBrushButtonActiveLightHighlight = 35;
	kThemeBrushButtonInactiveDarkShadow = 36;
	kThemeBrushButtonInactiveDarkHighlight = 37;
	kThemeBrushButtonInactiveLightShadow = 38;
	kThemeBrushButtonInactiveLightHighlight = 39;
	kThemeBrushButtonPressedDarkShadow = 40;
	kThemeBrushButtonPressedDarkHighlight = 41;
	kThemeBrushButtonPressedLightShadow = 42;
	kThemeBrushButtonPressedLightHighlight = 43;
	kThemeBrushBevelActiveLight	= 44;
	kThemeBrushBevelActiveDark	= 45;
	kThemeBrushBevelInactiveLight = 46;
	kThemeBrushBevelInactiveDark = 47;

	{	 Brushes available in Appearance 1.1.1 or later 	}
	kThemeBrushNotificationWindowBackground = 48;

	{	 Brushes available in Appearance X or later 	}
	kThemeBrushMovableModalBackground = 49;
	kThemeBrushSheetBackground	= 50;
	kThemeBrushDrawerBackground	= 51;

	{	 These values are meta-brushes, specific colors that do not       	}
	{	 change from theme to theme. You can use them instead of using    	}
	{	 direct RGB values.                                               	}
	kThemeBrushBlack			= -1;
	kThemeBrushWhite			= -2;


TYPE
	ThemeBrush							= SInt16;

CONST
	kThemeTextColorDialogActive	= 1;
	kThemeTextColorDialogInactive = 2;
	kThemeTextColorAlertActive	= 3;
	kThemeTextColorAlertInactive = 4;
	kThemeTextColorModelessDialogActive = 5;
	kThemeTextColorModelessDialogInactive = 6;
	kThemeTextColorWindowHeaderActive = 7;
	kThemeTextColorWindowHeaderInactive = 8;
	kThemeTextColorPlacardActive = 9;
	kThemeTextColorPlacardInactive = 10;
	kThemeTextColorPlacardPressed = 11;
	kThemeTextColorPushButtonActive = 12;
	kThemeTextColorPushButtonInactive = 13;
	kThemeTextColorPushButtonPressed = 14;
	kThemeTextColorBevelButtonActive = 15;
	kThemeTextColorBevelButtonInactive = 16;
	kThemeTextColorBevelButtonPressed = 17;
	kThemeTextColorPopupButtonActive = 18;
	kThemeTextColorPopupButtonInactive = 19;
	kThemeTextColorPopupButtonPressed = 20;
	kThemeTextColorIconLabel	= 21;
	kThemeTextColorListView		= 22;

	{	 Text Colors available in Appearance 1.0.1 or later 	}
	kThemeTextColorDocumentWindowTitleActive = 23;
	kThemeTextColorDocumentWindowTitleInactive = 24;
	kThemeTextColorMovableModalWindowTitleActive = 25;
	kThemeTextColorMovableModalWindowTitleInactive = 26;
	kThemeTextColorUtilityWindowTitleActive = 27;
	kThemeTextColorUtilityWindowTitleInactive = 28;
	kThemeTextColorPopupWindowTitleActive = 29;
	kThemeTextColorPopupWindowTitleInactive = 30;
	kThemeTextColorRootMenuActive = 31;
	kThemeTextColorRootMenuSelected = 32;
	kThemeTextColorRootMenuDisabled = 33;
	kThemeTextColorMenuItemActive = 34;
	kThemeTextColorMenuItemSelected = 35;
	kThemeTextColorMenuItemDisabled = 36;
	kThemeTextColorPopupLabelActive = 37;
	kThemeTextColorPopupLabelInactive = 38;


	{	 Text colors available in Appearance 1.1 or later 	}
	kThemeTextColorTabFrontActive = 39;
	kThemeTextColorTabNonFrontActive = 40;
	kThemeTextColorTabNonFrontPressed = 41;
	kThemeTextColorTabFrontInactive = 42;
	kThemeTextColorTabNonFrontInactive = 43;
	kThemeTextColorIconLabelSelected = 44;
	kThemeTextColorBevelButtonStickyActive = 45;
	kThemeTextColorBevelButtonStickyInactive = 46;

	{	 Text colors available in Appearance 1.1.1 or later 	}
	kThemeTextColorNotification	= 47;

	{	 These values are specific colors that do not change from             	}
	{	 theme to theme. You can use them instead of using direct RGB values. 	}
	kThemeTextColorBlack		= -1;
	kThemeTextColorWhite		= -2;


TYPE
	ThemeTextColor						= SInt16;
	{	 States to draw primitives: disabled, active, and pressed (hilited) 	}

CONST
	kThemeStateInactive			= 0;
	kThemeStateActive			= 1;
	kThemeStatePressed			= 2;
	kThemeStateRollover			= 6;
	kThemeStateUnavailable		= 7;
	kThemeStateUnavailableInactive = 8;

	{	 obsolete name 	}
	kThemeStateDisabled			= 0;

	kThemeStatePressedUp		= 2;							{  draw with up pressed     (increment/decrement buttons)  }
	kThemeStatePressedDown		= 3;							{  draw with down pressed (increment/decrement buttons)  }


TYPE
	ThemeDrawState						= UInt32;
	{	——————————————————————————————————————————————————————————————————————————————————	}
	{	 Theme cursor selectors available in Appearance 1.1 or later                      	}
	{	——————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeArrowCursor			= 0;
	kThemeCopyArrowCursor		= 1;
	kThemeAliasArrowCursor		= 2;
	kThemeContextualMenuArrowCursor = 3;
	kThemeIBeamCursor			= 4;
	kThemeCrossCursor			= 5;
	kThemePlusCursor			= 6;
	kThemeWatchCursor			= 7;							{  Can Animate  }
	kThemeClosedHandCursor		= 8;
	kThemeOpenHandCursor		= 9;
	kThemePointingHandCursor	= 10;
	kThemeCountingUpHandCursor	= 11;							{  Can Animate  }
	kThemeCountingDownHandCursor = 12;							{  Can Animate  }
	kThemeCountingUpAndDownHandCursor = 13;						{  Can Animate  }
	kThemeSpinningCursor		= 14;							{  Can Animate  }
	kThemeResizeLeftCursor		= 15;
	kThemeResizeRightCursor		= 16;
	kThemeResizeLeftRightCursor	= 17;


TYPE
	ThemeCursor							= UInt32;
	{	——————————————————————————————————————————————————————————————————————————————————	}
	{	 Theme menu bar drawing states                                                    	}
	{	——————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeMenuBarNormal			= 0;
	kThemeMenuBarSelected		= 1;


TYPE
	ThemeMenuBarState					= UInt16;
	{	 attributes 	}

CONST
	kThemeMenuSquareMenuBar		= $01;

	{	——————————————————————————————————————————————————————————————————————————————————	}
	{	 Theme menu drawing states                                                        	}
	{	——————————————————————————————————————————————————————————————————————————————————	}
	kThemeMenuActive			= 0;
	kThemeMenuSelected			= 1;
	kThemeMenuDisabled			= 3;


TYPE
	ThemeMenuState						= UInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 MenuType: add kThemeMenuTypeInactive to menu type for DrawThemeMenuBackground if entire  	}
	{	 menu is inactive                                                                         	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeMenuTypePullDown		= 0;
	kThemeMenuTypePopUp			= 1;
	kThemeMenuTypeHierarchical	= 2;
	kThemeMenuTypeInactive		= $0100;


TYPE
	ThemeMenuType						= UInt16;

CONST
	kThemeMenuItemPlain			= 0;
	kThemeMenuItemHierarchical	= 1;							{  item has hierarchical arrow }
	kThemeMenuItemScrollUpArrow	= 2;							{  for scrollable menus, indicates item is scroller }
	kThemeMenuItemScrollDownArrow = 3;
	kThemeMenuItemAtTop			= $0100;						{  indicates item is being drawn at top of menu }
	kThemeMenuItemAtBottom		= $0200;						{  indicates item is being drawn at bottom of menu }
	kThemeMenuItemHierBackground = $0400;						{  item is within a hierarchical menu }
	kThemeMenuItemPopUpBackground = $0800;						{  item is within a popped up menu }
	kThemeMenuItemHasIcon		= $8000;						{  add into non-arrow type when icon present. }


TYPE
	ThemeMenuItemType					= UInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Theme Backgrounds                                                                        	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeBackgroundTabPane		= 1;
	kThemeBackgroundPlacard		= 2;
	kThemeBackgroundWindowHeader = 3;
	kThemeBackgroundListViewWindowHeader = 4;
	kThemeBackgroundSecondaryGroupBox = 5;


TYPE
	ThemeBackgroundKind					= UInt32;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Theme Collection tags for Get/SetTheme                                                   	}
	{	                                                                                          	}
	{	  X ALERT: Please note that Get/SetTheme are severely neutered under Mac OS X at present. 	}
	{	           The first group of tags below are available to get under both 9 and X. The     	}
	{	           second group is 9 only. None of the tags can be used in SetTheme on X, as it   	}
	{	           is completely inert on X, and will return unimpErr.                            	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeNameTag				= 'name';						{  Str255 }
	kThemeVariantNameTag		= 'varn';						{  Str255 }
	kThemeHighlightColorTag		= 'hcol';						{  RGBColor }
	kThemeScrollBarArrowStyleTag = 'sbar';						{  ThemeScrollBarArrowStyle }
	kThemeScrollBarThumbStyleTag = 'sbth';						{  ThemeScrollBarThumbStyle }
	kThemeSoundsEnabledTag		= 'snds';						{  Boolean }
	kThemeDblClickCollapseTag	= 'coll';						{  Boolean }

	kThemeAppearanceFileNameTag	= 'thme';						{  Str255 }
	kThemeSystemFontTag			= 'lgsf';						{  Str255 }
	kThemeSmallSystemFontTag	= 'smsf';						{  Str255 }
	kThemeViewsFontTag			= 'vfnt';						{  Str255 }
	kThemeViewsFontSizeTag		= 'vfsz';						{  SInt16 }
	kThemeDesktopPatternNameTag	= 'patn';						{  Str255 }
	kThemeDesktopPatternTag		= 'patt';						{  <variable-length data> (flattened pattern) }
	kThemeDesktopPictureNameTag	= 'dpnm';						{  Str255 }
	kThemeDesktopPictureAliasTag = 'dpal';						{  <alias handle> }
	kThemeDesktopPictureAlignmentTag = 'dpan';					{  UInt32 }
	kThemeHighlightColorNameTag	= 'hcnm';						{  Str255 }
	kThemeExamplePictureIDTag	= 'epic';						{  SInt16 }
	kThemeSoundTrackNameTag		= 'sndt';						{  Str255 }
	kThemeSoundMaskTag			= 'smsk';						{  UInt32 }
	kThemeUserDefinedTag		= 'user';						{  Boolean (this should _always_ be true if present - used by Control Panel). }
	kThemeSmoothFontEnabledTag	= 'smoo';						{  Boolean }
	kThemeSmoothFontMinSizeTag	= 'smos';						{  UInt16 (must be >= 12 and <= 24) }

	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Theme Control Settings                                                                   	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	kThemeCheckBoxClassicX		= 0;							{  check box with an 'X' }
	kThemeCheckBoxCheckMark		= 1;							{  check box with a real check mark }


TYPE
	ThemeCheckBoxStyle					= UInt16;

CONST
	kThemeScrollBarArrowsSingle	= 0;							{  single arrow on each end }
	kThemeScrollBarArrowsLowerRight = 1;						{  double arrows only on right or bottom }


TYPE
	ThemeScrollBarArrowStyle			= UInt16;

CONST
	kThemeScrollBarThumbNormal	= 0;							{  normal, classic thumb size }
	kThemeScrollBarThumbProportional = 1;						{  proportional thumbs }


TYPE
	ThemeScrollBarThumbStyle			= UInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Font constants                                                                           	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeSystemFont			= 0;
	kThemeSmallSystemFont		= 1;
	kThemeSmallEmphasizedSystemFont = 2;
	kThemeViewsFont				= 3;							{  The following ID's are only available with MacOS X or CarbonLib 1.3 and later }
	kThemeEmphasizedSystemFont	= 4;
	kThemeApplicationFont		= 5;
	kThemeLabelFont				= 6;
	kThemeMenuTitleFont			= 100;
	kThemeMenuItemFont			= 101;
	kThemeMenuItemMarkFont		= 102;
	kThemeMenuItemCmdKeyFont	= 103;
	kThemeWindowTitleFont		= 104;
	kThemePushButtonFont		= 105;
	kThemeUtilityWindowTitleFont = 106;
	kThemeAlertHeaderFont		= 107;
	kThemeCurrentPortFont		= 200;


TYPE
	ThemeFontID							= UInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Tab constants                                                                            	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeTabNonFront			= 0;
	kThemeTabNonFrontPressed	= 1;
	kThemeTabNonFrontInactive	= 2;
	kThemeTabFront				= 3;
	kThemeTabFrontInactive		= 4;
	kThemeTabNonFrontUnavailable = 5;
	kThemeTabFrontUnavailable	= 6;


TYPE
	ThemeTabStyle						= UInt16;

CONST
	kThemeTabNorth				= 0;
	kThemeTabSouth				= 1;
	kThemeTabEast				= 2;
	kThemeTabWest				= 3;


TYPE
	ThemeTabDirection					= UInt16;
	{	 NOTE ON TAB HEIGHT                                                                       	}
	{	 Use the kThemeSmallTabHeightMax and kThemeLargeTabHeightMax when calculating the rects   	}
	{	 to draw tabs into. This height includes the tab frame overlap. Tabs that are not in the  	}
	{	 front are only drawn down to where they meet the frame, as if the height was just        	}
	{	 kThemeLargeTabHeight, for example, as opposed to the ...Max constant. Remember that for  	}
	{	 East and West tabs, the height referred to below is actually the width.                  	}

CONST
	kThemeSmallTabHeight		= 16;							{  amount small tabs protrude from frame. }
	kThemeLargeTabHeight		= 21;							{  amount large tabs protrude from frame. }
	kThemeTabPaneOverlap		= 3;							{  amount tabs overlap frame. }
	kThemeSmallTabHeightMax		= 19;							{  small tab height + overlap }
	kThemeLargeTabHeightMax		= 24;							{  large tab height + overlap }

	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Track kinds                                                                              	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	kThemeMediumScrollBar		= 0;
	kThemeSmallScrollBar		= 1;
	kThemeMediumSlider			= 2;
	kThemeMediumProgressBar		= 3;
	kThemeMediumIndeterminateBar = 4;
	kThemeRelevanceBar			= 5;
	kThemeSmallSlider			= 6;
	kThemeLargeProgressBar		= 7;
	kThemeLargeIndeterminateBar	= 8;


TYPE
	ThemeTrackKind						= UInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Track enable states                                                                      	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
																{  track states  }
	kThemeTrackActive			= 0;
	kThemeTrackDisabled			= 1;
	kThemeTrackNothingToScroll	= 2;
	kThemeTrackInactive			= 3;


TYPE
	ThemeTrackEnableState				= UInt8;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Track pressed states                                                                     	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
																{  press states (ignored unless track is active)  }
	kThemeLeftOutsideArrowPressed = $01;
	kThemeLeftInsideArrowPressed = $02;
	kThemeLeftTrackPressed		= $04;
	kThemeThumbPressed			= $08;
	kThemeRightTrackPressed		= $10;
	kThemeRightInsideArrowPressed = $20;
	kThemeRightOutsideArrowPressed = $40;
	kThemeTopOutsideArrowPressed = $01;
	kThemeTopInsideArrowPressed	= $02;
	kThemeTopTrackPressed		= $04;
	kThemeBottomTrackPressed	= $10;
	kThemeBottomInsideArrowPressed = $20;
	kThemeBottomOutsideArrowPressed = $40;


TYPE
	ThemeTrackPressState				= UInt8;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Thumb directions                                                                         	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
																{  thumb direction  }
	kThemeThumbPlain			= 0;
	kThemeThumbUpward			= 1;
	kThemeThumbDownward			= 2;


TYPE
	ThemeThumbDirection					= UInt8;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Track attributes                                                                         	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeTrackHorizontal		= $01;							{  track is drawn horizontally }
	kThemeTrackRightToLeft		= $02;							{  track progresses from right to left }
	kThemeTrackShowThumb		= $04;							{  track's thumb should be drawn }
	kThemeTrackThumbRgnIsNotGhost = $08;						{  the provided thumbRgn should be drawn opaque, not as a ghost }
	kThemeTrackNoScrollBarArrows = $10;							{  the scroll bar doesn't have arrows }


TYPE
	ThemeTrackAttributes				= UInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Track info block                                                                         	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	ScrollBarTrackInfoPtr = ^ScrollBarTrackInfo;
	ScrollBarTrackInfo = RECORD
		viewsize:				SInt32;									{  current view range size  }
		pressState:				SInt8;									{  pressed parts state  }
	END;

	SliderTrackInfoPtr = ^SliderTrackInfo;
	SliderTrackInfo = RECORD
		thumbDir:				SInt8;									{  thumb direction  }
		pressState:				SInt8;									{  pressed parts state  }
	END;

	ProgressTrackInfoPtr = ^ProgressTrackInfo;
	ProgressTrackInfo = RECORD
		phase:					SInt8;									{  phase for indeterminate progress  }
	END;

	ThemeTrackDrawInfoPtr = ^ThemeTrackDrawInfo;
	ThemeTrackDrawInfo = RECORD
		kind:					ThemeTrackKind;							{  what kind of track this info is for  }
		bounds:					Rect;									{  track basis rectangle  }
		min:					SInt32;									{  min track value  }
		max:					SInt32;									{  max track value  }
		value:					SInt32;									{  current thumb value  }
		reserved:				UInt32;
		attributes:				ThemeTrackAttributes;					{  various track attributes  }
		enableState:			SInt8;									{  enable state  }
		filler1:				SInt8;
		CASE INTEGER OF
		0: (
			scrollbar:			ScrollBarTrackInfo;
			);
		1: (
			slider:				SliderTrackInfo;
			);
		2: (
			progress:			ProgressTrackInfo;
			);
	END;

	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 ThemeWindowAttributes                                                                    	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeWindowHasGrow			= $01;							{  can the size of the window be changed by the user?  }
	kThemeWindowHasHorizontalZoom = $08;						{  window can zoom only horizontally  }
	kThemeWindowHasVerticalZoom	= $10;							{  window can zoom only vertically  }
	kThemeWindowHasFullZoom		= $18;							{  window zooms in all directions  }
	kThemeWindowHasCloseBox		= $20;							{  window has a close box  }
	kThemeWindowHasCollapseBox	= $40;							{  window has a collapse box  }
	kThemeWindowHasTitleText	= $80;							{  window has a title/title icon  }
	kThemeWindowIsCollapsed		= $0100;						{  window is in the collapsed state  }
	kThemeWindowHasDirty		= $0200;


TYPE
	ThemeWindowAttributes				= UInt32;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Window Types Supported by the Appearance Manager                                         	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeDocumentWindow		= 0;
	kThemeDialogWindow			= 1;
	kThemeMovableDialogWindow	= 2;
	kThemeAlertWindow			= 3;
	kThemeMovableAlertWindow	= 4;
	kThemePlainDialogWindow		= 5;
	kThemeShadowDialogWindow	= 6;
	kThemePopupWindow			= 7;
	kThemeUtilityWindow			= 8;
	kThemeUtilitySideWindow		= 9;
	kThemeSheetWindow			= 10;


TYPE
	ThemeWindowType						= UInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Window Widgets Supported by the Appearance Manager                                       	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeWidgetCloseBox		= 0;
	kThemeWidgetZoomBox			= 1;
	kThemeWidgetCollapseBox		= 2;
	kThemeWidgetDirtyCloseBox	= 6;


TYPE
	ThemeTitleBarWidget					= UInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Popup arrow orientations                                                                 	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeArrowLeft				= 0;
	kThemeArrowDown				= 1;
	kThemeArrowRight			= 2;
	kThemeArrowUp				= 3;


TYPE
	ThemeArrowOrientation				= UInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Popup arrow sizes                                                                        	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeArrow3pt				= 0;
	kThemeArrow5pt				= 1;
	kThemeArrow7pt				= 2;
	kThemeArrow9pt				= 3;


TYPE
	ThemePopupArrowSize					= UInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Grow box directions                                                                      	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeGrowLeft				= $01;							{  can grow to the left  }
	kThemeGrowRight				= $02;							{  can grow to the right  }
	kThemeGrowUp				= $04;							{  can grow up  }
	kThemeGrowDown				= $08;							{  can grow down  }


TYPE
	ThemeGrowDirection					= UInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Button kinds                                                                             	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemePushButton			= 0;
	kThemeCheckBox				= 1;
	kThemeRadioButton			= 2;
	kThemeBevelButton			= 3;							{  bevel button (obsolete)  }
	kThemeArrowButton			= 4;							{  popup button without text (no label). See ThemeButtonAdornment for glyphs.  }
	kThemePopupButton			= 5;							{  popup button  }
	kThemeDisclosureButton		= 6;
	kThemeIncDecButton			= 7;							{  increment/decrement buttons  (no label)  }
	kThemeSmallBevelButton		= 8;							{  small-shadow bevel button  }
	kThemeMediumBevelButton		= 3;							{  med-shadow bevel button  }
	kThemeLargeBevelButton		= 9;							{  large-shadow bevel button  }
	kThemeListHeaderButton		= 10;							{  sort button for top of list  }
	kThemeRoundButton			= 11;							{  round button  }
	kThemeLargeRoundButton		= 12;							{  large round button  }
	kThemeSmallCheckBox			= 13;							{  small checkbox  }
	kThemeSmallRadioButton		= 14;							{  small radio button  }
	kThemeRoundedBevelButton	= 15;							{  rounded bevel button  }
	kThemeNormalCheckBox		= 1;
	kThemeNormalRadioButton		= 2;


TYPE
	ThemeButtonKind						= UInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Common button values                                                                     	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeButtonOff				= 0;
	kThemeButtonOn				= 1;
	kThemeButtonMixed			= 2;
	kThemeDisclosureRight		= 0;
	kThemeDisclosureDown		= 1;
	kThemeDisclosureLeft		= 2;


TYPE
	ThemeButtonValue					= UInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Button adornment types                                                                   	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeAdornmentNone			= 0;
	kThemeAdornmentDefault		= $01;							{  if set, draw default ornamentation ( for push button and generic well )  }
	kThemeAdornmentFocus		= $04;							{  if set, draw focus  }
	kThemeAdornmentRightToLeft	= $10;							{  if set, draw right to left label  }
	kThemeAdornmentDrawIndicatorOnly = $20;						{  if set, don't draw or erase label ( radio, check, disclosure )  }
	kThemeAdornmentHeaderButtonLeftNeighborSelected = $40;		{  if set, draw the left border of the button as selected ( list header button only )  }
	kThemeAdornmentHeaderButtonRightNeighborSelected = $80;		{  if set, draw the right border of the button ( list header button only )  }
	kThemeAdornmentHeaderButtonSortUp = $0100;					{  if set, draw the sort indicator pointing upward ( list header button only )  }
	kThemeAdornmentHeaderMenuButton = $0200;					{  if set, draw as a header menu button ( list header button only )  }
	kThemeAdornmentHeaderButtonNoShadow = $0400;				{  if set, draw the non-shadow area of the button ( list header button only )  }
	kThemeAdornmentHeaderButtonShadowOnly = $0800;				{  if set, draw the only the shadow area of the button ( list header button only )  }
	kThemeAdornmentNoShadow		= $0400;						{  old name  }
	kThemeAdornmentShadowOnly	= $0800;						{  old name  }
	kThemeAdornmentArrowLeftArrow = $40;						{  If set, draw a left arrow on the arrow button  }
	kThemeAdornmentArrowDownArrow = $80;						{  If set, draw a down arrow on the arrow button  }
	kThemeAdornmentArrowDoubleArrow = $0100;					{  If set, draw a double arrow on the arrow button  }
	kThemeAdornmentArrowUpArrow	= $0200;						{  If set, draw a up arrow on the arrow button  }


TYPE
	ThemeButtonAdornment				= UInt16;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Button drawing info block                                                                	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	ThemeButtonDrawInfoPtr = ^ThemeButtonDrawInfo;
	ThemeButtonDrawInfo = RECORD
		state:					ThemeDrawState;
		value:					ThemeButtonValue;
		adornment:				ThemeButtonAdornment;
	END;

	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Sound Support                                                                            	}
	{	                                                                                          	}
	{	  X ALERT: Please note that none of the theme sound APIs currently function on X.         	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Sound classes                                                                            	}
	{	                                                                                          	}
	{	 You can use the constants below to set what sounds are active using the SetTheme API.    	}
	{	 Use these with the kThemeSoundMask tag.                                                  	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeNoSounds				= 0;
	kThemeWindowSoundsMask		= $01;
	kThemeMenuSoundsMask		= $02;
	kThemeControlSoundsMask		= $04;
	kThemeFinderSoundsMask		= $08;


	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Drag Sounds                                                                              	}
	{	                                                                                          	}
	{	 Drag sounds are looped for the duration of the drag.                                     	}
	{	                                                                                          	}
	{	 Call BeginThemeDragSound at the start of the drag.                                       	}
	{	 Call EndThemeDragSound when the drag has finished.                                       	}
	{	                                                                                          	}
	{	 Note that in order to maintain a consistent user experience, only one drag sound may     	}
	{	 occur at a time.  The sound should be attached to a mouse action, start after the        	}
	{	 mouse goes down and stop when the mouse is released.                                     	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	kThemeDragSoundNone			= 0;
	kThemeDragSoundMoveWindow	= 'wmov';
	kThemeDragSoundGrowWindow	= 'wgro';
	kThemeDragSoundMoveUtilWindow = 'umov';
	kThemeDragSoundGrowUtilWindow = 'ugro';
	kThemeDragSoundMoveDialog	= 'dmov';
	kThemeDragSoundMoveAlert	= 'amov';
	kThemeDragSoundMoveIcon		= 'imov';
	kThemeDragSoundSliderThumb	= 'slth';
	kThemeDragSoundSliderGhost	= 'slgh';
	kThemeDragSoundScrollBarThumb = 'sbth';
	kThemeDragSoundScrollBarGhost = 'sbgh';
	kThemeDragSoundScrollBarArrowDecreasing = 'sbad';
	kThemeDragSoundScrollBarArrowIncreasing = 'sbai';
	kThemeDragSoundDragging		= 'drag';


TYPE
	ThemeDragSoundKind					= OSType;
	{	——————————————————————————————————————————————————————————————————————————	}
	{	 State-change sounds                                                      	}
	{	                                                                          	}
	{	 State-change sounds are played asynchonously as a one-shot.              	}
	{	                                                                          	}
	{	 Call PlayThemeSound to play the sound.  The sound will play              	}
	{	 asynchronously until complete, then stop automatically.                  	}
	{	——————————————————————————————————————————————————————————————————————————	}

CONST
	kThemeSoundNone				= 0;
	kThemeSoundMenuOpen			= 'mnuo';						{  menu sounds  }
	kThemeSoundMenuClose		= 'mnuc';
	kThemeSoundMenuItemHilite	= 'mnui';
	kThemeSoundMenuItemRelease	= 'mnus';
	kThemeSoundWindowClosePress	= 'wclp';						{  window sounds  }
	kThemeSoundWindowCloseEnter	= 'wcle';
	kThemeSoundWindowCloseExit	= 'wclx';
	kThemeSoundWindowCloseRelease = 'wclr';
	kThemeSoundWindowZoomPress	= 'wzmp';
	kThemeSoundWindowZoomEnter	= 'wzme';
	kThemeSoundWindowZoomExit	= 'wzmx';
	kThemeSoundWindowZoomRelease = 'wzmr';
	kThemeSoundWindowCollapsePress = 'wcop';
	kThemeSoundWindowCollapseEnter = 'wcoe';
	kThemeSoundWindowCollapseExit = 'wcox';
	kThemeSoundWindowCollapseRelease = 'wcor';
	kThemeSoundWindowDragBoundary = 'wdbd';
	kThemeSoundUtilWinClosePress = 'uclp';						{  utility window sounds  }
	kThemeSoundUtilWinCloseEnter = 'ucle';
	kThemeSoundUtilWinCloseExit	= 'uclx';
	kThemeSoundUtilWinCloseRelease = 'uclr';
	kThemeSoundUtilWinZoomPress	= 'uzmp';
	kThemeSoundUtilWinZoomEnter	= 'uzme';
	kThemeSoundUtilWinZoomExit	= 'uzmx';
	kThemeSoundUtilWinZoomRelease = 'uzmr';
	kThemeSoundUtilWinCollapsePress = 'ucop';
	kThemeSoundUtilWinCollapseEnter = 'ucoe';
	kThemeSoundUtilWinCollapseExit = 'ucox';
	kThemeSoundUtilWinCollapseRelease = 'ucor';
	kThemeSoundUtilWinDragBoundary = 'udbd';
	kThemeSoundWindowOpen		= 'wopn';						{  window close and zoom action  }
	kThemeSoundWindowClose		= 'wcls';
	kThemeSoundWindowZoomIn		= 'wzmi';
	kThemeSoundWindowZoomOut	= 'wzmo';
	kThemeSoundWindowCollapseUp	= 'wcol';
	kThemeSoundWindowCollapseDown = 'wexp';
	kThemeSoundWindowActivate	= 'wact';
	kThemeSoundUtilWindowOpen	= 'uopn';
	kThemeSoundUtilWindowClose	= 'ucls';
	kThemeSoundUtilWindowZoomIn	= 'uzmi';
	kThemeSoundUtilWindowZoomOut = 'uzmo';
	kThemeSoundUtilWindowCollapseUp = 'ucol';
	kThemeSoundUtilWindowCollapseDown = 'uexp';
	kThemeSoundUtilWindowActivate = 'uact';
	kThemeSoundDialogOpen		= 'dopn';
	kThemeSoundDialogClose		= 'dlgc';
	kThemeSoundAlertOpen		= 'aopn';
	kThemeSoundAlertClose		= 'altc';
	kThemeSoundPopupWindowOpen	= 'pwop';
	kThemeSoundPopupWindowClose	= 'pwcl';
	kThemeSoundButtonPress		= 'btnp';						{  button  }
	kThemeSoundButtonEnter		= 'btne';
	kThemeSoundButtonExit		= 'btnx';
	kThemeSoundButtonRelease	= 'btnr';
	kThemeSoundDefaultButtonPress = 'dbtp';						{  default button  }
	kThemeSoundDefaultButtonEnter = 'dbte';
	kThemeSoundDefaultButtonExit = 'dbtx';
	kThemeSoundDefaultButtonRelease = 'dbtr';
	kThemeSoundCancelButtonPress = 'cbtp';						{  cancel button  }
	kThemeSoundCancelButtonEnter = 'cbte';
	kThemeSoundCancelButtonExit	= 'cbtx';
	kThemeSoundCancelButtonRelease = 'cbtr';
	kThemeSoundCheckboxPress	= 'chkp';						{  checkboxes  }
	kThemeSoundCheckboxEnter	= 'chke';
	kThemeSoundCheckboxExit		= 'chkx';
	kThemeSoundCheckboxRelease	= 'chkr';
	kThemeSoundRadioPress		= 'radp';						{  radio buttons  }
	kThemeSoundRadioEnter		= 'rade';
	kThemeSoundRadioExit		= 'radx';
	kThemeSoundRadioRelease		= 'radr';
	kThemeSoundScrollArrowPress	= 'sbap';						{  scroll bars  }
	kThemeSoundScrollArrowEnter	= 'sbae';
	kThemeSoundScrollArrowExit	= 'sbax';
	kThemeSoundScrollArrowRelease = 'sbar';
	kThemeSoundScrollEndOfTrack	= 'sbte';
	kThemeSoundScrollTrackPress	= 'sbtp';
	kThemeSoundSliderEndOfTrack	= 'slte';						{  sliders  }
	kThemeSoundSliderTrackPress	= 'sltp';
	kThemeSoundBalloonOpen		= 'blno';						{  help balloons  }
	kThemeSoundBalloonClose		= 'blnc';
	kThemeSoundBevelPress		= 'bevp';						{  Bevel buttons  }
	kThemeSoundBevelEnter		= 'beve';
	kThemeSoundBevelExit		= 'bevx';
	kThemeSoundBevelRelease		= 'bevr';
	kThemeSoundLittleArrowUpPress = 'laup';						{  Little Arrows  }
	kThemeSoundLittleArrowDnPress = 'ladp';
	kThemeSoundLittleArrowEnter	= 'lare';
	kThemeSoundLittleArrowExit	= 'larx';
	kThemeSoundLittleArrowUpRelease = 'laur';
	kThemeSoundLittleArrowDnRelease = 'ladr';
	kThemeSoundPopupPress		= 'popp';						{  Popup Buttons  }
	kThemeSoundPopupEnter		= 'pope';
	kThemeSoundPopupExit		= 'popx';
	kThemeSoundPopupRelease		= 'popr';
	kThemeSoundDisclosurePress	= 'dscp';						{  Disclosure Buttons  }
	kThemeSoundDisclosureEnter	= 'dsce';
	kThemeSoundDisclosureExit	= 'dscx';
	kThemeSoundDisclosureRelease = 'dscr';
	kThemeSoundTabPressed		= 'tabp';						{  Tabs  }
	kThemeSoundTabEnter			= 'tabe';
	kThemeSoundTabExit			= 'tabx';
	kThemeSoundTabRelease		= 'tabr';
	kThemeSoundDragTargetHilite	= 'dthi';						{  drag manager  }
	kThemeSoundDragTargetUnhilite = 'dtuh';
	kThemeSoundDragTargetDrop	= 'dtdr';
	kThemeSoundEmptyTrash		= 'ftrs';						{  finder  }
	kThemeSoundSelectItem		= 'fsel';
	kThemeSoundNewItem			= 'fnew';
	kThemeSoundReceiveDrop		= 'fdrp';
	kThemeSoundCopyDone			= 'fcpd';
	kThemeSoundResolveAlias		= 'fral';
	kThemeSoundLaunchApp		= 'flap';
	kThemeSoundDiskInsert		= 'dski';
	kThemeSoundDiskEject		= 'dske';
	kThemeSoundFinderDragOnIcon	= 'fdon';
	kThemeSoundFinderDragOffIcon = 'fdof';


TYPE
	ThemeSoundKind						= OSType;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Window Metrics                                                                           	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	  Window metrics are used by the Appearance manager to fill in the blanks necessary to    	}
	{	  draw windows. If a value is not appropriate for the type of window, be sure to fill in  	}
	{	  the slot in the structure with zero.    For the popupTabOffset parameter, you can pass a	}
	{	  real value based on the left edge of the window. This value might be interpreted in a   	}
	{	  different manner when depending on the value of the popupTabPosition field. The values  	}
	{	  you can pass into popupTabPosition are:                                                 	}
	{	                                                                                          	}
	{	  kThemePopupTabNormalPosition                                                            	}
	{	      Starts the tab left edge at the position indicated by the popupTabOffset field.     	}
	{	                                                                                          	}
	{	  kThemePopupTabCenterOnWindow                                                            	}
	{	      tells us to ignore the offset field and instead simply center the width of the      	}
	{	      handle on the window.                                                               	}
	{	                                                                                          	}
	{	  kThemePopupTabCenterOnOffset                                                            	}
	{	      tells us to center the width of the handle around the value passed in offset.       	}
	{	                                                                                          	}
	{	  The Appearance Manager will try its best to accomodate the requested placement, but may 	}
	{	  move the handle slightly to make it fit correctly.                                      	}
	{	                                                                                          	}

CONST
	kThemePopupTabNormalPosition = 0;
	kThemePopupTabCenterOnWindow = 1;
	kThemePopupTabCenterOnOffset = 2;


TYPE
	ThemeWindowMetricsPtr = ^ThemeWindowMetrics;
	ThemeWindowMetrics = RECORD
		metricSize:				UInt16;									{  should be always be sizeof( ThemeWindowMetrics ) }
		titleHeight:			SInt16;
		titleWidth:				SInt16;
		popupTabOffset:			SInt16;
		popupTabWidth:			SInt16;
		popupTabPosition:		UInt16;
	END;

	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Theme Metrics                                                                            	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	  Theme metrics allow you to find out sizes of things in the current environment, such as 	}
	{	  how wide a scroll bar is, etc.                                                          	}

CONST
	kThemeMetricScrollBarWidth	= 0;
	kThemeMetricSmallScrollBarWidth = 1;
	kThemeMetricCheckBoxHeight	= 2;
	kThemeMetricRadioButtonHeight = 3;
	kThemeMetricEditTextWhitespace = 4;
	kThemeMetricEditTextFrameOutset = 5;
	kThemeMetricListBoxFrameOutset = 6;
	kThemeMetricFocusRectOutset	= 7;
	kThemeMetricImageWellThickness = 8;
	kThemeMetricScrollBarOverlap = 9;
	kThemeMetricLargeTabHeight	= 10;
	kThemeMetricLargeTabCapsWidth = 11;
	kThemeMetricTabFrameOverlap	= 12;
	kThemeMetricTabIndentOrStyle = 13;
	kThemeMetricTabOverlap		= 14;
	kThemeMetricSmallTabHeight	= 15;
	kThemeMetricSmallTabCapsWidth = 16;
	kThemeMetricDisclosureButtonHeight = 17;
	kThemeMetricRoundButtonSize	= 18;
	kThemeMetricPushButtonHeight = 19;
	kThemeMetricListHeaderHeight = 20;
	kThemeMetricSmallCheckBoxHeight = 21;
	kThemeMetricDisclosureButtonWidth = 22;
	kThemeMetricSmallDisclosureButtonHeight = 23;
	kThemeMetricSmallDisclosureButtonWidth = 24;
	kThemeMetricDisclosureTriangleHeight = 25;
	kThemeMetricDisclosureTriangleWidth = 26;
	kThemeMetricLittleArrowsHeight = 27;
	kThemeMetricLittleArrowsWidth = 28;
	kThemeMetricPaneSplitterHeight = 29;
	kThemeMetricPopupButtonHeight = 30;
	kThemeMetricSmallPopupButtonHeight = 31;
	kThemeMetricLargeProgressBarThickness = 32;
	kThemeMetricPullDownHeight	= 33;
	kThemeMetricSmallPullDownHeight = 34;
	kThemeMetricSmallPushButtonHeight = 35;
	kThemeMetricSmallRadioButtonHeight = 36;
	kThemeMetricRelevanceIndicatorHeight = 37;
	kThemeMetricResizeControlHeight = 38;
	kThemeMetricSmallResizeControlHeight = 39;
	kThemeMetricLargeRoundButtonSize = 40;
	kThemeMetricHSliderHeight	= 41;
	kThemeMetricHSliderTickHeight = 42;
	kThemeMetricSmallHSliderHeight = 43;
	kThemeMetricSmallHSliderTickHeight = 44;
	kThemeMetricVSliderWidth	= 45;
	kThemeMetricVSliderTickWidth = 46;
	kThemeMetricSmallVSliderWidth = 47;
	kThemeMetricSmallVSliderTickWidth = 48;
	kThemeMetricTitleBarControlsHeight = 49;
	kThemeMetricCheckBoxWidth	= 50;
	kThemeMetricSmallCheckBoxWidth = 51;
	kThemeMetricRadioButtonWidth = 52;
	kThemeMetricSmallRadioButtonWidth = 53;
	kThemeMetricSmallHSliderMinThumbWidth = 54;
	kThemeMetricSmallVSliderMinThumbHeight = 55;
	kThemeMetricSmallHSliderTickOffset = 56;
	kThemeMetricSmallVSliderTickOffset = 57;
	kThemeMetricNormalProgressBarThickness = 58;
	kThemeMetricProgressBarShadowOutset = 59;
	kThemeMetricSmallProgressBarShadowOutset = 60;
	kThemeMetricPrimaryGroupBoxContentInset = 61;
	kThemeMetricSecondaryGroupBoxContentInset = 62;


TYPE
	ThemeMetric							= UInt32;
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Drawing State                                                                            	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	ThemeDrawingState    = ^LONGINT; { an opaque 32-bit type }
	ThemeDrawingStatePtr = ^ThemeDrawingState;  { when a VAR xx:ThemeDrawingState parameter can be nil, it is changed to xx: ThemeDrawingStatePtr }
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Callback procs                                                                           	}
	{	——————————————————————————————————————————————————————————————————————————————————————————	}
{$IFC TYPED_FUNCTION_POINTERS}
	ThemeTabTitleDrawProcPtr = PROCEDURE({CONST}VAR bounds: Rect; style: ThemeTabStyle; direction: ThemeTabDirection; depth: SInt16; isColorDev: BOOLEAN; userData: UInt32);
{$ELSEC}
	ThemeTabTitleDrawProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ThemeEraseProcPtr = PROCEDURE({CONST}VAR bounds: Rect; eraseData: UInt32; depth: SInt16; isColorDev: BOOLEAN);
{$ELSEC}
	ThemeEraseProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ThemeButtonDrawProcPtr = PROCEDURE({CONST}VAR bounds: Rect; kind: ThemeButtonKind; {CONST}VAR info: ThemeButtonDrawInfo; userData: UInt32; depth: SInt16; isColorDev: BOOLEAN);
{$ELSEC}
	ThemeButtonDrawProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	WindowTitleDrawingProcPtr = PROCEDURE({CONST}VAR bounds: Rect; depth: SInt16; colorDevice: BOOLEAN; userData: UInt32);
{$ELSEC}
	WindowTitleDrawingProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	ThemeIteratorProcPtr = FUNCTION(inFileName: Str255; resID: SInt16; inThemeSettings: Collection; inUserData: UNIV Ptr): BOOLEAN;
{$ELSEC}
	ThemeIteratorProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ThemeTabTitleDrawUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ThemeTabTitleDrawUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ThemeEraseUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ThemeEraseUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ThemeButtonDrawUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ThemeButtonDrawUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	WindowTitleDrawingUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	WindowTitleDrawingUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ThemeIteratorUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ThemeIteratorUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppThemeTabTitleDrawProcInfo = $00036AC0;
	uppThemeEraseProcInfo = $00001BC0;
	uppThemeButtonDrawProcInfo = $0001BEC0;
	uppWindowTitleDrawingProcInfo = $000036C0;
	uppThemeIteratorProcInfo = $00003ED0;
	{
	 *  NewThemeTabTitleDrawUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewThemeTabTitleDrawUPP(userRoutine: ThemeTabTitleDrawProcPtr): ThemeTabTitleDrawUPP; { old name was NewThemeTabTitleDrawProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewThemeEraseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewThemeEraseUPP(userRoutine: ThemeEraseProcPtr): ThemeEraseUPP; { old name was NewThemeEraseProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewThemeButtonDrawUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewThemeButtonDrawUPP(userRoutine: ThemeButtonDrawProcPtr): ThemeButtonDrawUPP; { old name was NewThemeButtonDrawProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewWindowTitleDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewWindowTitleDrawingUPP(userRoutine: WindowTitleDrawingProcPtr): WindowTitleDrawingUPP; { old name was NewWindowTitleDrawingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewThemeIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewThemeIteratorUPP(userRoutine: ThemeIteratorProcPtr): ThemeIteratorUPP; { old name was NewThemeIteratorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeThemeTabTitleDrawUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeThemeTabTitleDrawUPP(userUPP: ThemeTabTitleDrawUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeThemeEraseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeThemeEraseUPP(userUPP: ThemeEraseUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeThemeButtonDrawUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeThemeButtonDrawUPP(userUPP: ThemeButtonDrawUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeWindowTitleDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeWindowTitleDrawingUPP(userUPP: WindowTitleDrawingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeThemeIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeThemeIteratorUPP(userUPP: ThemeIteratorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeThemeTabTitleDrawUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeThemeTabTitleDrawUPP({CONST}VAR bounds: Rect; style: ThemeTabStyle; direction: ThemeTabDirection; depth: SInt16; isColorDev: BOOLEAN; userData: UInt32; userRoutine: ThemeTabTitleDrawUPP); { old name was CallThemeTabTitleDrawProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeThemeEraseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeThemeEraseUPP({CONST}VAR bounds: Rect; eraseData: UInt32; depth: SInt16; isColorDev: BOOLEAN; userRoutine: ThemeEraseUPP); { old name was CallThemeEraseProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeThemeButtonDrawUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeThemeButtonDrawUPP({CONST}VAR bounds: Rect; kind: ThemeButtonKind; {CONST}VAR info: ThemeButtonDrawInfo; userData: UInt32; depth: SInt16; isColorDev: BOOLEAN; userRoutine: ThemeButtonDrawUPP); { old name was CallThemeButtonDrawProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeWindowTitleDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeWindowTitleDrawingUPP({CONST}VAR bounds: Rect; depth: SInt16; colorDevice: BOOLEAN; userData: UInt32; userRoutine: WindowTitleDrawingUPP); { old name was CallWindowTitleDrawingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeThemeIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeThemeIteratorUPP(inFileName: Str255; resID: SInt16; inThemeSettings: Collection; inUserData: UNIV Ptr; userRoutine: ThemeIteratorUPP): BOOLEAN; { old name was CallThemeIteratorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————}
{ Menu Drawing callbacks                                                           }
{——————————————————————————————————————————————————————————————————————————————————}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	MenuTitleDrawingProcPtr = PROCEDURE({CONST}VAR inBounds: Rect; inDepth: SInt16; inIsColorDevice: BOOLEAN; inUserData: SInt32);
{$ELSEC}
	MenuTitleDrawingProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	MenuItemDrawingProcPtr = PROCEDURE({CONST}VAR inBounds: Rect; inDepth: SInt16; inIsColorDevice: BOOLEAN; inUserData: SInt32);
{$ELSEC}
	MenuItemDrawingProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	MenuTitleDrawingUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MenuTitleDrawingUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	MenuItemDrawingUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	MenuItemDrawingUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppMenuTitleDrawingProcInfo = $000036C0;
	uppMenuItemDrawingProcInfo = $000036C0;
	{
	 *  NewMenuTitleDrawingUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewMenuTitleDrawingUPP(userRoutine: MenuTitleDrawingProcPtr): MenuTitleDrawingUPP; { old name was NewMenuTitleDrawingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewMenuItemDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewMenuItemDrawingUPP(userRoutine: MenuItemDrawingProcPtr): MenuItemDrawingUPP; { old name was NewMenuItemDrawingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeMenuTitleDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMenuTitleDrawingUPP(userUPP: MenuTitleDrawingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeMenuItemDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeMenuItemDrawingUPP(userUPP: MenuItemDrawingUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeMenuTitleDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeMenuTitleDrawingUPP({CONST}VAR inBounds: Rect; inDepth: SInt16; inIsColorDevice: BOOLEAN; inUserData: SInt32; userRoutine: MenuTitleDrawingUPP); { old name was CallMenuTitleDrawingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeMenuItemDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeMenuItemDrawingUPP({CONST}VAR inBounds: Rect; inDepth: SInt16; inIsColorDevice: BOOLEAN; inUserData: SInt32; userRoutine: MenuItemDrawingUPP); { old name was CallMenuItemDrawingProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————}
{  Appearance Manager APIs                                                         }
{——————————————————————————————————————————————————————————————————————————————————}
{ Registering Appearance-Savvy Applications }
{
 *  RegisterAppearanceClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RegisterAppearanceClient: OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0015, $AA74;
	{$ENDC}

{
 *  UnregisterAppearanceClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UnregisterAppearanceClient: OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0016, $AA74;
	{$ENDC}

{
 *  IsAppearanceClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsAppearanceClient({CONST}VAR process: ProcessSerialNumber): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $FFFF, $AA74;
	{$ENDC}

{****************************************************************************
    NOTES ON THEME BRUSHES
    Theme brushes can be either colors or patterns, depending on the theme.
    Because of this, you should be prepared to handle the case where a brush
    is a pattern and save and restore the pnPixPat and bkPixPat fields of
    your GrafPorts when saving the fore and back colors. Also, since patterns
    in bkPixPat override the background color of the window, you should use
    BackPat to set your background pattern to a normal white pattern. This
    will ensure that you can use RGBBackColor to set your back color to white,
    call EraseRect and get the expected results.
****************************************************************************}

{
 *  SetThemePen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetThemePen(inBrush: ThemeBrush; inDepth: SInt16; inIsColorDevice: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0001, $AA74;
	{$ENDC}

{
 *  SetThemeBackground()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetThemeBackground(inBrush: ThemeBrush; inDepth: SInt16; inIsColorDevice: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0002, $AA74;
	{$ENDC}

{
 *  SetThemeTextColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetThemeTextColor(inColor: ThemeTextColor; inDepth: SInt16; inIsColorDevice: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0003, $AA74;
	{$ENDC}

{
 *  SetThemeWindowBackground()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetThemeWindowBackground(inWindow: WindowRef; inBrush: ThemeBrush; inUpdate: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0004, $AA74;
	{$ENDC}

{ Window Placards, Headers and Frames }
{
 *  DrawThemeWindowHeader()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeWindowHeader({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0005, $AA74;
	{$ENDC}

{
 *  DrawThemeWindowListViewHeader()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeWindowListViewHeader({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0006, $AA74;
	{$ENDC}

{
 *  DrawThemePlacard()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemePlacard({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0007, $AA74;
	{$ENDC}

{
 *  DrawThemeEditTextFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeEditTextFrame({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0009, $AA74;
	{$ENDC}

{
 *  DrawThemeListBoxFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeListBoxFrame({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000A, $AA74;
	{$ENDC}

{ Keyboard Focus Drawing }
{
 *  DrawThemeFocusRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeFocusRect({CONST}VAR inRect: Rect; inHasFocus: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000B, $AA74;
	{$ENDC}

{ Dialog Group Boxes and Separators }
{
 *  DrawThemePrimaryGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemePrimaryGroup({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000C, $AA74;
	{$ENDC}

{
 *  DrawThemeSecondaryGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeSecondaryGroup({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000D, $AA74;
	{$ENDC}

{
 *  DrawThemeSeparator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeSeparator({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000E, $AA74;
	{$ENDC}

{—————————————————————————————— BEGIN APPEARANCE 1.0.1 ————————————————————————————————————————————}
{ The following Appearance Manager APIs are only available }
{ in Appearance 1.0.1 or later                             }
{
 *  DrawThemeModelessDialogFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeModelessDialogFrame({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0008, $AA74;
	{$ENDC}

{
 *  DrawThemeGenericWell()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeGenericWell({CONST}VAR inRect: Rect; inState: ThemeDrawState; inFillCenter: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0022, $AA74;
	{$ENDC}

{
 *  DrawThemeFocusRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeFocusRegion(inRegion: RgnHandle; inHasFocus: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0023, $AA74;
	{$ENDC}

{
 *  IsThemeInColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsThemeInColor(inDepth: SInt16; inIsColorDevice: BOOLEAN): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0024, $AA74;
	{$ENDC}

{ IMPORTANT: GetThemeAccentColors will only work in the platinum theme. Any other theme will }
{ most likely return an error }
{
 *  GetThemeAccentColors()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeAccentColors(VAR outColors: CTabHandle): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0025, $AA74;
	{$ENDC}

{
 *  DrawThemeMenuBarBackground()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeMenuBarBackground({CONST}VAR inBounds: Rect; inState: ThemeMenuBarState; inAttributes: UInt32): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0018, $AA74;
	{$ENDC}

{
 *  DrawThemeMenuTitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeMenuTitle({CONST}VAR inMenuBarRect: Rect; {CONST}VAR inTitleRect: Rect; inState: ThemeMenuState; inAttributes: UInt32; inTitleProc: MenuTitleDrawingUPP; inTitleData: UInt32): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0019, $AA74;
	{$ENDC}


{
 *  GetThemeMenuBarHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeMenuBarHeight(VAR outHeight: SInt16): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001A, $AA74;
	{$ENDC}

{
 *  DrawThemeMenuBackground()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeMenuBackground({CONST}VAR inMenuRect: Rect; inMenuType: ThemeMenuType): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001B, $AA74;
	{$ENDC}

{
 *  GetThemeMenuBackgroundRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeMenuBackgroundRegion({CONST}VAR inMenuRect: Rect; menuType: ThemeMenuType; region: RgnHandle): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001C, $AA74;
	{$ENDC}

{
 *  DrawThemeMenuItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeMenuItem({CONST}VAR inMenuRect: Rect; {CONST}VAR inItemRect: Rect; inVirtualMenuTop: SInt16; inVirtualMenuBottom: SInt16; inState: ThemeMenuState; inItemType: ThemeMenuItemType; inDrawProc: MenuItemDrawingUPP; inUserData: UInt32): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001D, $AA74;
	{$ENDC}

{
 *  DrawThemeMenuSeparator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeMenuSeparator({CONST}VAR inItemRect: Rect): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001E, $AA74;
	{$ENDC}

{
 *  GetThemeMenuSeparatorHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeMenuSeparatorHeight(VAR outHeight: SInt16): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $001F, $AA74;
	{$ENDC}

{
 *  GetThemeMenuItemExtra()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeMenuItemExtra(inItemType: ThemeMenuItemType; VAR outHeight: SInt16; VAR outWidth: SInt16): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0020, $AA74;
	{$ENDC}

{
 *  GetThemeMenuTitleExtra()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeMenuTitleExtra(VAR outWidth: SInt16; inIsSquished: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0021, $AA74;
	{$ENDC}

{——————————————————————————————— BEGIN APPEARANCE 1.1 —————————————————————————————————————————————}
{—————————————————————————————————— THEME SWITCHING ———————————————————————————————————————————————}
{                                                                                                  }
{  X ALERT: Please note that Get/SetTheme are severely neutered under Mac OS X at present.         }
{           See the note above regarding what collection tags are supported under X.               }

{
 *  GetTheme()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetTheme(ioCollection: Collection): OSStatus;

{
 *  SetTheme()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetTheme(ioCollection: Collection): OSStatus;

{
 *  IterateThemes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IterateThemes(inProc: ThemeIteratorUPP; inUserData: UNIV Ptr): OSStatus;

{———————————————————————————————————————— TABS ————————————————————————————————————————————————————}
{
 *  DrawThemeTabPane()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeTabPane({CONST}VAR inRect: Rect; inState: ThemeDrawState): OSStatus;

{
 *  DrawThemeTab()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeTab({CONST}VAR inRect: Rect; inStyle: ThemeTabStyle; inDirection: ThemeTabDirection; labelProc: ThemeTabTitleDrawUPP; userData: UInt32): OSStatus;

{
 *  GetThemeTabRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeTabRegion({CONST}VAR inRect: Rect; inStyle: ThemeTabStyle; inDirection: ThemeTabDirection; ioRgn: RgnHandle): OSStatus;

{——————————————————————————————————————— CURSORS ——————————————————————————————————————————————————}
{
 *  SetThemeCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetThemeCursor(inCursor: ThemeCursor): OSStatus;

{
 *  SetAnimatedThemeCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetAnimatedThemeCursor(inCursor: ThemeCursor; inAnimationStep: UInt32): OSStatus;

{———————————————————————————————— CONTROL STYLE SETTINGS ——————————————————————————————————————————}
{
 *  GetThemeScrollBarThumbStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeScrollBarThumbStyle(VAR outStyle: ThemeScrollBarThumbStyle): OSStatus;

{
 *  GetThemeScrollBarArrowStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeScrollBarArrowStyle(VAR outStyle: ThemeScrollBarArrowStyle): OSStatus;

{
 *  GetThemeCheckBoxStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeCheckBoxStyle(VAR outStyle: ThemeCheckBoxStyle): OSStatus;

{———————————————————————————————————————— FONTS/TEXT ——————————————————————————————————————————————}
{
 *  UseThemeFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UseThemeFont(inFontID: ThemeFontID; inScript: ScriptCode): OSStatus;

{
 *  GetThemeFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeFont(inFontID: ThemeFontID; inScript: ScriptCode; outFontName: StringPtr; VAR outFontSize: SInt16; VAR outStyle: Style): OSStatus;

{
 *  DrawThemeTextBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeTextBox(inString: CFStringRef; inFontID: ThemeFontID; inState: ThemeDrawState; inWrapToWidth: BOOLEAN; {CONST}VAR inBoundingBox: Rect; inJust: SInt16; inContext: UNIV Ptr): OSStatus;

{
 *  TruncateThemeText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TruncateThemeText(inString: CFMutableStringRef; inFontID: ThemeFontID; inState: ThemeDrawState; inPixelWidthLimit: SInt16; inTruncWhere: TruncCode; VAR outTruncated: BOOLEAN): OSStatus;

{
 *  GetThemeTextDimensions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeTextDimensions(inString: CFStringRef; inFontID: ThemeFontID; inState: ThemeDrawState; inWrapToWidth: BOOLEAN; VAR ioBounds: Point; VAR outBaseline: SInt16): OSStatus;

{
 *  GetThemeTextShadowOutset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeTextShadowOutset(inFontID: ThemeFontID; inState: ThemeDrawState; VAR outOutset: Rect): OSStatus;

{———————————————————————————————————————— TRACKS ——————————————————————————————————————————————————}
{
 *  DrawThemeTrack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeTrack({CONST}VAR drawInfo: ThemeTrackDrawInfo; rgnGhost: RgnHandle; eraseProc: ThemeEraseUPP; eraseData: UInt32): OSStatus;

{
 *  HitTestThemeTrack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HitTestThemeTrack({CONST}VAR drawInfo: ThemeTrackDrawInfo; mousePoint: Point; VAR partHit: ControlPartCode): BOOLEAN;

{
 *  GetThemeTrackBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeTrackBounds({CONST}VAR drawInfo: ThemeTrackDrawInfo; VAR bounds: Rect): OSStatus;

{
 *  GetThemeTrackThumbRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeTrackThumbRgn({CONST}VAR drawInfo: ThemeTrackDrawInfo; thumbRgn: RgnHandle): OSStatus;

{
 *  GetThemeTrackDragRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeTrackDragRect({CONST}VAR drawInfo: ThemeTrackDrawInfo; VAR dragRect: Rect): OSStatus;

{
 *  DrawThemeTrackTickMarks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeTrackTickMarks({CONST}VAR drawInfo: ThemeTrackDrawInfo; numTicks: ItemCount; eraseProc: ThemeEraseUPP; eraseData: UInt32): OSStatus;

{
 *  GetThemeTrackThumbPositionFromOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeTrackThumbPositionFromOffset({CONST}VAR drawInfo: ThemeTrackDrawInfo; thumbOffset: Point; VAR relativePosition: SInt32): OSStatus;

{
 *  GetThemeTrackThumbPositionFromRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeTrackThumbPositionFromRegion({CONST}VAR drawInfo: ThemeTrackDrawInfo; thumbRgn: RgnHandle; VAR relativePosition: SInt32): OSStatus;

{
 *  GetThemeTrackLiveValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeTrackLiveValue({CONST}VAR drawInfo: ThemeTrackDrawInfo; relativePosition: SInt32; VAR value: SInt32): OSStatus;

{——————————————————————————————————— SCROLLBAR ARROWS —————————————————————————————————————————————}
{
 *  DrawThemeScrollBarArrows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeScrollBarArrows({CONST}VAR bounds: Rect; enableState: ByteParameter; pressState: ByteParameter; isHoriz: BOOLEAN; VAR trackBounds: Rect): OSStatus;

{
 *  GetThemeScrollBarTrackRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeScrollBarTrackRect({CONST}VAR bounds: Rect; enableState: ByteParameter; pressState: ByteParameter; isHoriz: BOOLEAN; VAR trackBounds: Rect): OSStatus;

{
 *  HitTestThemeScrollBarArrows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HitTestThemeScrollBarArrows({CONST}VAR scrollBarBounds: Rect; enableState: ByteParameter; pressState: ByteParameter; isHoriz: BOOLEAN; ptHit: Point; VAR trackBounds: Rect; VAR partcode: ControlPartCode): BOOLEAN;

{———————————————————————————————————————— WINDOWS —————————————————————————————————————————————————}
{
 *  GetThemeWindowRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeWindowRegion(flavor: ThemeWindowType; {CONST}VAR contRect: Rect; state: ThemeDrawState; {CONST}VAR metrics: ThemeWindowMetrics; attributes: ThemeWindowAttributes; winRegion: WindowRegionCode; rgn: RgnHandle): OSStatus;

{
 *  DrawThemeWindowFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeWindowFrame(flavor: ThemeWindowType; {CONST}VAR contRect: Rect; state: ThemeDrawState; {CONST}VAR metrics: ThemeWindowMetrics; attributes: ThemeWindowAttributes; titleProc: WindowTitleDrawingUPP; titleData: UInt32): OSStatus;

{
 *  DrawThemeTitleBarWidget()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeTitleBarWidget(flavor: ThemeWindowType; {CONST}VAR contRect: Rect; state: ThemeDrawState; {CONST}VAR metrics: ThemeWindowMetrics; attributes: ThemeWindowAttributes; widget: ThemeTitleBarWidget): OSStatus;

{
 *  GetThemeWindowRegionHit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeWindowRegionHit(flavor: ThemeWindowType; {CONST}VAR inContRect: Rect; state: ThemeDrawState; {CONST}VAR metrics: ThemeWindowMetrics; inAttributes: ThemeWindowAttributes; inPoint: Point; VAR outRegionHit: WindowRegionCode): BOOLEAN;

{
 *  DrawThemeScrollBarDelimiters()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeScrollBarDelimiters(flavor: ThemeWindowType; {CONST}VAR inContRect: Rect; state: ThemeDrawState; attributes: ThemeWindowAttributes): OSStatus;


{———————————————————————————————————————— BUTTONS —————————————————————————————————————————————————}
{
 *  DrawThemeButton()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeButton({CONST}VAR inBounds: Rect; inKind: ThemeButtonKind; {CONST}VAR inNewInfo: ThemeButtonDrawInfo; inPrevInfo: {Const}ThemeButtonDrawInfoPtr; inEraseProc: ThemeEraseUPP; inLabelProc: ThemeButtonDrawUPP; inUserData: UInt32): OSStatus;

{
 *  GetThemeButtonRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeButtonRegion({CONST}VAR inBounds: Rect; inKind: ThemeButtonKind; {CONST}VAR inNewInfo: ThemeButtonDrawInfo; outRegion: RgnHandle): OSStatus;

{
 *  GetThemeButtonContentBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeButtonContentBounds({CONST}VAR inBounds: Rect; inKind: ThemeButtonKind; {CONST}VAR inDrawInfo: ThemeButtonDrawInfo; VAR outBounds: Rect): OSStatus;

{
 *  GetThemeButtonBackgroundBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeButtonBackgroundBounds({CONST}VAR inBounds: Rect; inKind: ThemeButtonKind; {CONST}VAR inDrawInfo: ThemeButtonDrawInfo; VAR outBounds: Rect): OSStatus;


{————————————————————————————————————— INTERFACE SOUNDS ———————————————————————————————————————————}
{                                                                                                  }
{  X ALERT: Please note that the sound APIs do not work on Mac OS X at present.                    }
{
 *  PlayThemeSound()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PlayThemeSound(kind: ThemeSoundKind): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0026, $AA74;
	{$ENDC}

{
 *  BeginThemeDragSound()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BeginThemeDragSound(kind: ThemeDragSoundKind): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0027, $AA74;
	{$ENDC}

{
 *  EndThemeDragSound()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION EndThemeDragSound: OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0028, $AA74;
	{$ENDC}

{—————————————————————————————————————— PRIMITIVES ————————————————————————————————————————————————}
{
 *  DrawThemeTickMark()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeTickMark({CONST}VAR bounds: Rect; state: ThemeDrawState): OSStatus;

{
 *  DrawThemeChasingArrows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeChasingArrows({CONST}VAR bounds: Rect; index: UInt32; state: ThemeDrawState; eraseProc: ThemeEraseUPP; eraseData: UInt32): OSStatus;

{
 *  DrawThemePopupArrow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemePopupArrow({CONST}VAR bounds: Rect; orientation: ThemeArrowOrientation; size: ThemePopupArrowSize; state: ThemeDrawState; eraseProc: ThemeEraseUPP; eraseData: UInt32): OSStatus;

{
 *  DrawThemeStandaloneGrowBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeStandaloneGrowBox(origin: Point; growDirection: ThemeGrowDirection; isSmall: BOOLEAN; state: ThemeDrawState): OSStatus;

{
 *  DrawThemeStandaloneNoGrowBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DrawThemeStandaloneNoGrowBox(origin: Point; growDirection: ThemeGrowDirection; isSmall: BOOLEAN; state: ThemeDrawState): OSStatus;

{
 *  GetThemeStandaloneGrowBoxBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeStandaloneGrowBoxBounds(origin: Point; growDirection: ThemeGrowDirection; isSmall: BOOLEAN; VAR bounds: Rect): OSStatus;

{————————————————————————————————————— DRAWING STATE ——————————————————————————————————————————————}
{ The following routines help you save and restore the drawing state in a theme-savvy manner. With }
{ these weapons in your arsenal, there is no grafport you cannot tame. Use ThemeGetDrawingState to }
{ get the current drawing settings for the current port. It will return an opaque object for you   }
{ to pass into ThemeSetDrawingState later on. When you are finished with the state, call the       }
{ ThemeDisposeDrawingState routine. You can alternatively pass true into the inDisposeNow          }
{ parameter of the ThemeSetDrawingState routine.  You can use this routine to copy the drawing     }
{ state from one port to another as well.                                                          }
{                                                                                                  }
{ As of this writing (Mac OS 9.1 and Mac OS X), Get/SetThemeDrawingState will save and restore     }
{ this data in the port:                                                                           }
{                                                                                                  }
{      pen size                                                                                    }
{      pen location                                                                                }
{      pen mode                                                                                    }
{      pen Pattern and PixPat                                                                      }
{      background Pattern and PixPat                                                               }
{      RGB foreground and background colors                                                        }
{      text mode                                                                                   }
{      pattern origin                                                                              }
{                                                                                                  }
{ Get/SetThemeDrawingState may save and restore additional port state in the future, but you can   }
{ rely on them to always save at least this port state.                                            }
{
 *  NormalizeThemeDrawingState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NormalizeThemeDrawingState: OSStatus;

{
 *  GetThemeDrawingState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeDrawingState(VAR outState: ThemeDrawingState): OSStatus;

{
 *  SetThemeDrawingState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetThemeDrawingState(inState: ThemeDrawingState; inDisposeNow: BOOLEAN): OSStatus;

{
 *  DisposeThemeDrawingState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DisposeThemeDrawingState(inState: ThemeDrawingState): OSStatus;

{————————————————————————————————————— MISCELLANEOUS ——————————————————————————————————————————————}
{ ApplyThemeBackground is used to set up the background for embedded controls  }
{ It is normally called by controls that are embedders. The standard controls  }
{ call this API to ensure a correct background for the current theme. You pass }
{ in the same rectangle you would if you were calling the drawing primitive.   }
{
 *  ApplyThemeBackground()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ApplyThemeBackground(inKind: ThemeBackgroundKind; {CONST}VAR bounds: Rect; inState: ThemeDrawState; inDepth: SInt16; inColorDev: BOOLEAN): OSStatus;

{
 *  SetThemeTextColorForWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetThemeTextColorForWindow(window: WindowRef; isActive: BOOLEAN; depth: SInt16; isColorDev: BOOLEAN): OSStatus;

{
 *  IsValidAppearanceFileType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsValidAppearanceFileType(fileType: OSType): BOOLEAN;

{
 *  GetThemeBrushAsColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeBrushAsColor(inBrush: ThemeBrush; inDepth: SInt16; inColorDev: BOOLEAN; VAR outColor: RGBColor): OSStatus;

{
 *  GetThemeTextColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeTextColor(inColor: ThemeTextColor; inDepth: SInt16; inColorDev: BOOLEAN; VAR outColor: RGBColor): OSStatus;

{——————————————————————————————————————— BEGIN CARBON —————————————————————————————————————————————}
{
 *  GetThemeMetric()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThemeMetric(inMetric: ThemeMetric; VAR outMetric: SInt32): OSStatus;

{
 *  GetTextAndEncodingFromCFString()
 *  
 *  Summary:
 *    Converts the contents of a CFString to the one- or two-byte
 *    encoding that most accurately represents the original Unicode
 *    characters in the string.
 *  
 *  Discussion:
 *    Because the Macintosh toolbox has had, until Carbon, little
 *    support for Unicode, you may often find that your applications
 *    need to translate a CFString (containing Unicode characters) back
 *    to a one- or two-byte encoding of the string in order to draw,
 *    measure, or otherwise use the text in the string.
 *    GetTextAndEncodingFromCFString is a utility that may be helpful
 *    to do this, in some circumstances. The Carbon toolbox uses this
 *    API itself when translating CFStrings to Pascal strings.
 *    GetTextAndEncodingFromCFString attempts to convert the Unicode
 *    characters in the string to the closest non-Unicode
 *    representation of the string. For example, a string containing
 *    only Unicode characters that are present in the MacRoman one-byte
 *    encoding will be translated to MacRoman, and
 *    kTextEncodingMacRoman will be returned as the encoding of the
 *    text. A string containing Unicode characters that are present in
 *    the MacJapanese two-byte encoding will be translated to
 *    MacJapanese (Shift-JIS), and kTextEncodingMacJapanese will be
 *    returned as the encoding of the text.
 *    GetTextAndEncodingFromCFString is designed to be used for simple
 *    strings which contain only text from a single language. It is not
 *    designed to translate strings with multiple runs of text from
 *    different languages, and will only return the first run of such a
 *    string; for example, if you pass it a string containing a run of
 *    Roman characters followed by a run of Japanese characters, it
 *    will only return the Roman characters in the output buffer. For
 *    more complex text translation, you should call the Unicode
 *    converter directly (see ConvertFromUnicodeToTextRun, which
 *    GetTextAndEncodingFromCFString uses internally).
 *  
 *  Parameters:
 *    
 *    inString:
 *      The string to convert.
 *    
 *    outText:
 *      The output buffer in which to place the converted text.
 *    
 *    inTextMaxLength:
 *      The length in bytes of the input buffer.
 *    
 *    outTextLength:
 *      On exit, contains the length in bytes of the text that was
 *      placed into the output buffer.
 *    
 *    outEncoding:
 *      On exit, contains the encoding of the text that was placed into
 *      the output buffer.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.2.5 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetTextAndEncodingFromCFString(inString: CFStringRef; outText: BytePtr; inTextMaxLength: ByteCount; VAR outTextLength: ByteCount; VAR outEncoding: TextEncoding): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————————————————}
{ Obsolete symbolic names                                                                          }
{——————————————————————————————————————————————————————————————————————————————————————————————————}
{ Obsolete error codes - use the new ones, s'il vous plait / kudasai }

CONST
	appearanceBadBrushIndexErr	= -30560;						{  pattern index invalid  }
	appearanceProcessRegisteredErr = -30561;
	appearanceProcessNotRegisteredErr = -30562;
	appearanceBadTextColorIndexErr = -30563;
	appearanceThemeHasNoAccents	= -30564;
	appearanceBadCursorIndexErr	= -30565;

	kThemeActiveDialogBackgroundBrush = 1;
	kThemeInactiveDialogBackgroundBrush = 2;
	kThemeActiveAlertBackgroundBrush = 3;
	kThemeInactiveAlertBackgroundBrush = 4;
	kThemeActiveModelessDialogBackgroundBrush = 5;
	kThemeInactiveModelessDialogBackgroundBrush = 6;
	kThemeActiveUtilityWindowBackgroundBrush = 7;
	kThemeInactiveUtilityWindowBackgroundBrush = 8;
	kThemeListViewSortColumnBackgroundBrush = 9;
	kThemeListViewBackgroundBrush = 10;
	kThemeIconLabelBackgroundBrush = 11;
	kThemeListViewSeparatorBrush = 12;
	kThemeChasingArrowsBrush	= 13;
	kThemeDragHiliteBrush		= 14;
	kThemeDocumentWindowBackgroundBrush = 15;
	kThemeFinderWindowBackgroundBrush = 16;

	kThemeActiveScrollBarDelimiterBrush = 17;
	kThemeInactiveScrollBarDelimiterBrush = 18;
	kThemeFocusHighlightBrush	= 19;
	kThemeActivePopupArrowBrush	= 20;
	kThemePressedPopupArrowBrush = 21;
	kThemeInactivePopupArrowBrush = 22;
	kThemeAppleGuideCoachmarkBrush = 23;

	kThemeActiveDialogTextColor	= 1;
	kThemeInactiveDialogTextColor = 2;
	kThemeActiveAlertTextColor	= 3;
	kThemeInactiveAlertTextColor = 4;
	kThemeActiveModelessDialogTextColor = 5;
	kThemeInactiveModelessDialogTextColor = 6;
	kThemeActiveWindowHeaderTextColor = 7;
	kThemeInactiveWindowHeaderTextColor = 8;
	kThemeActivePlacardTextColor = 9;
	kThemeInactivePlacardTextColor = 10;
	kThemePressedPlacardTextColor = 11;
	kThemeActivePushButtonTextColor = 12;
	kThemeInactivePushButtonTextColor = 13;
	kThemePressedPushButtonTextColor = 14;
	kThemeActiveBevelButtonTextColor = 15;
	kThemeInactiveBevelButtonTextColor = 16;
	kThemePressedBevelButtonTextColor = 17;
	kThemeActivePopupButtonTextColor = 18;
	kThemeInactivePopupButtonTextColor = 19;
	kThemePressedPopupButtonTextColor = 20;
	kThemeIconLabelTextColor	= 21;
	kThemeListViewTextColor		= 22;

	kThemeActiveDocumentWindowTitleTextColor = 23;
	kThemeInactiveDocumentWindowTitleTextColor = 24;
	kThemeActiveMovableModalWindowTitleTextColor = 25;
	kThemeInactiveMovableModalWindowTitleTextColor = 26;
	kThemeActiveUtilityWindowTitleTextColor = 27;
	kThemeInactiveUtilityWindowTitleTextColor = 28;
	kThemeActivePopupWindowTitleColor = 29;
	kThemeInactivePopupWindowTitleColor = 30;
	kThemeActiveRootMenuTextColor = 31;
	kThemeSelectedRootMenuTextColor = 32;
	kThemeDisabledRootMenuTextColor = 33;
	kThemeActiveMenuItemTextColor = 34;
	kThemeSelectedMenuItemTextColor = 35;
	kThemeDisabledMenuItemTextColor = 36;
	kThemeActivePopupLabelTextColor = 37;
	kThemeInactivePopupLabelTextColor = 38;

	kAEThemeSwitch				= 'thme';						{  Event ID's: Theme Switched  }

	kThemeNoAdornment			= 0;
	kThemeDefaultAdornment		= $01;
	kThemeFocusAdornment		= $04;
	kThemeRightToLeftAdornment	= $10;
	kThemeDrawIndicatorOnly		= $20;

	kThemeBrushPassiveAreaFill	= 25;

	kThemeMetricCheckBoxGlyphHeight = 2;
	kThemeMetricRadioButtonGlyphHeight = 3;
	kThemeMetricDisclosureButtonSize = 17;
	kThemeMetricBestListHeaderHeight = 20;
	kThemeMetricSmallProgressBarThickness = 58;					{  obsolete  }
	kThemeMetricProgressBarThickness = 32;						{  obsolete  }

	kThemeScrollBar				= 0;
	kThemeSlider				= 2;
	kThemeProgressBar			= 3;
	kThemeIndeterminateBar		= 4;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AppearanceIncludes}

{$ENDC} {__APPEARANCE__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

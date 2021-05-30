/*
     File:       Appearance.h
 
     Contains:   Appearance Manager Interfaces.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __APPEARANCE__
#define __APPEARANCE__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __TEXTEDIT__
#include <TextEdit.h>
#endif

#ifndef __QDOFFSCREEN__
#include <QDOffscreen.h>
#endif

#ifndef __MACWINDOWS__
#include <MacWindows.h>
#endif

#ifndef __CONTROLS__
#include <Controls.h>
#endif

#ifndef __MACERRORS__
#include <MacErrors.h>
#endif

#ifndef __TEXTUTILS__
#include <TextUtils.h>
#endif

#ifndef __CFSTRING__
#include <CFString.h>
#endif

/*——————————————————————————————————————————————————————————————————————————————————*/
/* Appearance Manager constants, etc.                                               */
/*——————————————————————————————————————————————————————————————————————————————————*/
/* Appearance Manager Apple Events (1.1 and later)              */


#if PRAGMA_ONCE
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT
#pragma import on
#endif

#if PRAGMA_STRUCT_ALIGN
    #pragma options align=mac68k
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(push, 2)
#elif PRAGMA_STRUCT_PACK
    #pragma pack(2)
#endif

enum {
  kAppearanceEventClass         = FOUR_CHAR_CODE('appr'), /* Event Class */
  kAEAppearanceChanged          = FOUR_CHAR_CODE('thme'), /* Appearance changed (e.g. platinum to hi-tech) */
  kAESystemFontChanged          = FOUR_CHAR_CODE('sysf'), /* system font changed */
  kAESmallSystemFontChanged     = FOUR_CHAR_CODE('ssfn'), /* small system font changed */
  kAEViewsFontChanged           = FOUR_CHAR_CODE('vfnt') /* views font changed */
};

/*——————————————————————————————————————————————————————————————————————————————————*/
/* Appearance Manager file types                                                    */
/*——————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeDataFileType            = FOUR_CHAR_CODE('thme'), /* file type for theme files */
  kThemePlatinumFileType        = FOUR_CHAR_CODE('pltn'), /* file type for platinum appearance */
  kThemeCustomThemesFileType    = FOUR_CHAR_CODE('scen'), /* file type for user themes */
  kThemeSoundTrackFileType      = FOUR_CHAR_CODE('tsnd')
};


enum {
  kThemeBrushDialogBackgroundActive = 1, /* Dialogs */
  kThemeBrushDialogBackgroundInactive = 2, /* Dialogs */
  kThemeBrushAlertBackgroundActive = 3,
  kThemeBrushAlertBackgroundInactive = 4,
  kThemeBrushModelessDialogBackgroundActive = 5,
  kThemeBrushModelessDialogBackgroundInactive = 6,
  kThemeBrushUtilityWindowBackgroundActive = 7, /* Miscellaneous */
  kThemeBrushUtilityWindowBackgroundInactive = 8, /* Miscellaneous */
  kThemeBrushListViewSortColumnBackground = 9, /* Finder */
  kThemeBrushListViewBackground = 10,
  kThemeBrushIconLabelBackground = 11,
  kThemeBrushListViewSeparator  = 12,
  kThemeBrushChasingArrows      = 13,
  kThemeBrushDragHilite         = 14,
  kThemeBrushDocumentWindowBackground = 15,
  kThemeBrushFinderWindowBackground = 16
};

/* Brushes available in Appearance 1.1 or later */
enum {
  kThemeBrushScrollBarDelimiterActive = 17,
  kThemeBrushScrollBarDelimiterInactive = 18,
  kThemeBrushFocusHighlight     = 19,
  kThemeBrushPopupArrowActive   = 20,
  kThemeBrushPopupArrowPressed  = 21,
  kThemeBrushPopupArrowInactive = 22,
  kThemeBrushAppleGuideCoachmark = 23,
  kThemeBrushIconLabelBackgroundSelected = 24,
  kThemeBrushStaticAreaFill     = 25,
  kThemeBrushActiveAreaFill     = 26,
  kThemeBrushButtonFrameActive  = 27,
  kThemeBrushButtonFrameInactive = 28,
  kThemeBrushButtonFaceActive   = 29,
  kThemeBrushButtonFaceInactive = 30,
  kThemeBrushButtonFacePressed  = 31,
  kThemeBrushButtonActiveDarkShadow = 32,
  kThemeBrushButtonActiveDarkHighlight = 33,
  kThemeBrushButtonActiveLightShadow = 34,
  kThemeBrushButtonActiveLightHighlight = 35,
  kThemeBrushButtonInactiveDarkShadow = 36,
  kThemeBrushButtonInactiveDarkHighlight = 37,
  kThemeBrushButtonInactiveLightShadow = 38,
  kThemeBrushButtonInactiveLightHighlight = 39,
  kThemeBrushButtonPressedDarkShadow = 40,
  kThemeBrushButtonPressedDarkHighlight = 41,
  kThemeBrushButtonPressedLightShadow = 42,
  kThemeBrushButtonPressedLightHighlight = 43,
  kThemeBrushBevelActiveLight   = 44,
  kThemeBrushBevelActiveDark    = 45,
  kThemeBrushBevelInactiveLight = 46,
  kThemeBrushBevelInactiveDark  = 47
};

/* Brushes available in Appearance 1.1.1 or later */
enum {
  kThemeBrushNotificationWindowBackground = 48
};

/* Brushes available in Appearance X or later */
enum {
  kThemeBrushMovableModalBackground = 49,
  kThemeBrushSheetBackground    = 50,
  kThemeBrushDrawerBackground   = 51
};

/* These values are meta-brushes, specific colors that do not       */
/* change from theme to theme. You can use them instead of using    */
/* direct RGB values.                                               */
enum {
  kThemeBrushBlack              = -1,
  kThemeBrushWhite              = -2
};

typedef SInt16                          ThemeBrush;
enum {
  kThemeTextColorDialogActive   = 1,
  kThemeTextColorDialogInactive = 2,
  kThemeTextColorAlertActive    = 3,
  kThemeTextColorAlertInactive  = 4,
  kThemeTextColorModelessDialogActive = 5,
  kThemeTextColorModelessDialogInactive = 6,
  kThemeTextColorWindowHeaderActive = 7,
  kThemeTextColorWindowHeaderInactive = 8,
  kThemeTextColorPlacardActive  = 9,
  kThemeTextColorPlacardInactive = 10,
  kThemeTextColorPlacardPressed = 11,
  kThemeTextColorPushButtonActive = 12,
  kThemeTextColorPushButtonInactive = 13,
  kThemeTextColorPushButtonPressed = 14,
  kThemeTextColorBevelButtonActive = 15,
  kThemeTextColorBevelButtonInactive = 16,
  kThemeTextColorBevelButtonPressed = 17,
  kThemeTextColorPopupButtonActive = 18,
  kThemeTextColorPopupButtonInactive = 19,
  kThemeTextColorPopupButtonPressed = 20,
  kThemeTextColorIconLabel      = 21,
  kThemeTextColorListView       = 22
};

/* Text Colors available in Appearance 1.0.1 or later */
enum {
  kThemeTextColorDocumentWindowTitleActive = 23,
  kThemeTextColorDocumentWindowTitleInactive = 24,
  kThemeTextColorMovableModalWindowTitleActive = 25,
  kThemeTextColorMovableModalWindowTitleInactive = 26,
  kThemeTextColorUtilityWindowTitleActive = 27,
  kThemeTextColorUtilityWindowTitleInactive = 28,
  kThemeTextColorPopupWindowTitleActive = 29,
  kThemeTextColorPopupWindowTitleInactive = 30,
  kThemeTextColorRootMenuActive = 31,
  kThemeTextColorRootMenuSelected = 32,
  kThemeTextColorRootMenuDisabled = 33,
  kThemeTextColorMenuItemActive = 34,
  kThemeTextColorMenuItemSelected = 35,
  kThemeTextColorMenuItemDisabled = 36,
  kThemeTextColorPopupLabelActive = 37,
  kThemeTextColorPopupLabelInactive = 38
};


/* Text colors available in Appearance 1.1 or later */
enum {
  kThemeTextColorTabFrontActive = 39,
  kThemeTextColorTabNonFrontActive = 40,
  kThemeTextColorTabNonFrontPressed = 41,
  kThemeTextColorTabFrontInactive = 42,
  kThemeTextColorTabNonFrontInactive = 43,
  kThemeTextColorIconLabelSelected = 44,
  kThemeTextColorBevelButtonStickyActive = 45,
  kThemeTextColorBevelButtonStickyInactive = 46
};

/* Text colors available in Appearance 1.1.1 or later */
enum {
  kThemeTextColorNotification   = 47
};

/* These values are specific colors that do not change from             */
/* theme to theme. You can use them instead of using direct RGB values. */
enum {
  kThemeTextColorBlack          = -1,
  kThemeTextColorWhite          = -2
};

typedef SInt16                          ThemeTextColor;
/* States to draw primitives: disabled, active, and pressed (hilited) */
enum {
  kThemeStateInactive           = 0,
  kThemeStateActive             = 1,
  kThemeStatePressed            = 2,
  kThemeStateRollover           = 6,
  kThemeStateUnavailable        = 7,
  kThemeStateUnavailableInactive = 8
};

/* obsolete name */
enum {
  kThemeStateDisabled           = 0
};

enum {
  kThemeStatePressedUp          = 2,    /* draw with up pressed     (increment/decrement buttons) */
  kThemeStatePressedDown        = 3     /* draw with down pressed (increment/decrement buttons) */
};

typedef UInt32                          ThemeDrawState;
/*——————————————————————————————————————————————————————————————————————————————————*/
/* Theme cursor selectors available in Appearance 1.1 or later                      */
/*——————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeArrowCursor             = 0,
  kThemeCopyArrowCursor         = 1,
  kThemeAliasArrowCursor        = 2,
  kThemeContextualMenuArrowCursor = 3,
  kThemeIBeamCursor             = 4,
  kThemeCrossCursor             = 5,
  kThemePlusCursor              = 6,
  kThemeWatchCursor             = 7,    /* Can Animate */
  kThemeClosedHandCursor        = 8,
  kThemeOpenHandCursor          = 9,
  kThemePointingHandCursor      = 10,
  kThemeCountingUpHandCursor    = 11,   /* Can Animate */
  kThemeCountingDownHandCursor  = 12,   /* Can Animate */
  kThemeCountingUpAndDownHandCursor = 13, /* Can Animate */
  kThemeSpinningCursor          = 14,   /* Can Animate */
  kThemeResizeLeftCursor        = 15,
  kThemeResizeRightCursor       = 16,
  kThemeResizeLeftRightCursor   = 17
};

typedef UInt32                          ThemeCursor;
/*——————————————————————————————————————————————————————————————————————————————————*/
/* Theme menu bar drawing states                                                    */
/*——————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeMenuBarNormal           = 0,
  kThemeMenuBarSelected         = 1
};

typedef UInt16                          ThemeMenuBarState;
/* attributes */
enum {
  kThemeMenuSquareMenuBar       = (1 << 0)
};

/*——————————————————————————————————————————————————————————————————————————————————*/
/* Theme menu drawing states                                                        */
/*——————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeMenuActive              = 0,
  kThemeMenuSelected            = 1,
  kThemeMenuDisabled            = 3
};

typedef UInt16                          ThemeMenuState;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* MenuType: add kThemeMenuTypeInactive to menu type for DrawThemeMenuBackground if entire  */
/* menu is inactive                                                                         */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeMenuTypePullDown        = 0,
  kThemeMenuTypePopUp           = 1,
  kThemeMenuTypeHierarchical    = 2,
  kThemeMenuTypeInactive        = 0x0100
};

typedef UInt16                          ThemeMenuType;
enum {
  kThemeMenuItemPlain           = 0,
  kThemeMenuItemHierarchical    = 1,    /* item has hierarchical arrow*/
  kThemeMenuItemScrollUpArrow   = 2,    /* for scrollable menus, indicates item is scroller*/
  kThemeMenuItemScrollDownArrow = 3,
  kThemeMenuItemAtTop           = 0x0100, /* indicates item is being drawn at top of menu*/
  kThemeMenuItemAtBottom        = 0x0200, /* indicates item is being drawn at bottom of menu*/
  kThemeMenuItemHierBackground  = 0x0400, /* item is within a hierarchical menu*/
  kThemeMenuItemPopUpBackground = 0x0800, /* item is within a popped up menu*/
  kThemeMenuItemHasIcon         = 0x8000 /* add into non-arrow type when icon present.*/
};

typedef UInt16                          ThemeMenuItemType;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Theme Backgrounds                                                                        */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeBackgroundTabPane       = 1,
  kThemeBackgroundPlacard       = 2,
  kThemeBackgroundWindowHeader  = 3,
  kThemeBackgroundListViewWindowHeader = 4,
  kThemeBackgroundSecondaryGroupBox = 5
};

typedef UInt32                          ThemeBackgroundKind;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Theme Collection tags for Get/SetTheme                                                   */
/*                                                                                          */
/*  X ALERT: Please note that Get/SetTheme are severely neutered under Mac OS X at present. */
/*           The first group of tags below are available to get under both 9 and X. The     */
/*           second group is 9 only. None of the tags can be used in SetTheme on X, as it   */
/*           is completely inert on X, and will return unimpErr.                            */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeNameTag                 = FOUR_CHAR_CODE('name'), /* Str255*/
  kThemeVariantNameTag          = FOUR_CHAR_CODE('varn'), /* Str255*/
  kThemeHighlightColorTag       = FOUR_CHAR_CODE('hcol'), /* RGBColor*/
  kThemeScrollBarArrowStyleTag  = FOUR_CHAR_CODE('sbar'), /* ThemeScrollBarArrowStyle*/
  kThemeScrollBarThumbStyleTag  = FOUR_CHAR_CODE('sbth'), /* ThemeScrollBarThumbStyle*/
  kThemeSoundsEnabledTag        = FOUR_CHAR_CODE('snds'), /* Boolean*/
  kThemeDblClickCollapseTag     = FOUR_CHAR_CODE('coll') /* Boolean*/
};

enum {
  kThemeAppearanceFileNameTag   = FOUR_CHAR_CODE('thme'), /* Str255*/
  kThemeSystemFontTag           = FOUR_CHAR_CODE('lgsf'), /* Str255*/
  kThemeSmallSystemFontTag      = FOUR_CHAR_CODE('smsf'), /* Str255*/
  kThemeViewsFontTag            = FOUR_CHAR_CODE('vfnt'), /* Str255*/
  kThemeViewsFontSizeTag        = FOUR_CHAR_CODE('vfsz'), /* SInt16*/
  kThemeDesktopPatternNameTag   = FOUR_CHAR_CODE('patn'), /* Str255*/
  kThemeDesktopPatternTag       = FOUR_CHAR_CODE('patt'), /* <variable-length data> (flattened pattern)*/
  kThemeDesktopPictureNameTag   = FOUR_CHAR_CODE('dpnm'), /* Str255*/
  kThemeDesktopPictureAliasTag  = FOUR_CHAR_CODE('dpal'), /* <alias handle>*/
  kThemeDesktopPictureAlignmentTag = FOUR_CHAR_CODE('dpan'), /* UInt32*/
  kThemeHighlightColorNameTag   = FOUR_CHAR_CODE('hcnm'), /* Str255*/
  kThemeExamplePictureIDTag     = FOUR_CHAR_CODE('epic'), /* SInt16*/
  kThemeSoundTrackNameTag       = FOUR_CHAR_CODE('sndt'), /* Str255*/
  kThemeSoundMaskTag            = FOUR_CHAR_CODE('smsk'), /* UInt32*/
  kThemeUserDefinedTag          = FOUR_CHAR_CODE('user'), /* Boolean (this should _always_ be true if present - used by Control Panel).*/
  kThemeSmoothFontEnabledTag    = FOUR_CHAR_CODE('smoo'), /* Boolean*/
  kThemeSmoothFontMinSizeTag    = FOUR_CHAR_CODE('smos') /* UInt16 (must be >= 12 and <= 24)*/
};

/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Theme Control Settings                                                                   */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeCheckBoxClassicX        = 0,    /* check box with an 'X'*/
  kThemeCheckBoxCheckMark       = 1     /* check box with a real check mark*/
};

typedef UInt16                          ThemeCheckBoxStyle;
enum {
  kThemeScrollBarArrowsSingle   = 0,    /* single arrow on each end*/
  kThemeScrollBarArrowsLowerRight = 1   /* double arrows only on right or bottom*/
};

typedef UInt16                          ThemeScrollBarArrowStyle;
enum {
  kThemeScrollBarThumbNormal    = 0,    /* normal, classic thumb size*/
  kThemeScrollBarThumbProportional = 1  /* proportional thumbs*/
};

typedef UInt16                          ThemeScrollBarThumbStyle;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Font constants                                                                           */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeSystemFont              = 0,
  kThemeSmallSystemFont         = 1,
  kThemeSmallEmphasizedSystemFont = 2,
  kThemeViewsFont               = 3,    /* The following ID's are only available with MacOS X or CarbonLib 1.3 and later*/
  kThemeEmphasizedSystemFont    = 4,
  kThemeApplicationFont         = 5,
  kThemeLabelFont               = 6,
  kThemeMenuTitleFont           = 100,
  kThemeMenuItemFont            = 101,
  kThemeMenuItemMarkFont        = 102,
  kThemeMenuItemCmdKeyFont      = 103,
  kThemeWindowTitleFont         = 104,
  kThemePushButtonFont          = 105,
  kThemeUtilityWindowTitleFont  = 106,
  kThemeAlertHeaderFont         = 107,
  kThemeCurrentPortFont         = 200
};

typedef UInt16                          ThemeFontID;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Tab constants                                                                            */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeTabNonFront             = 0,
  kThemeTabNonFrontPressed      = 1,
  kThemeTabNonFrontInactive     = 2,
  kThemeTabFront                = 3,
  kThemeTabFrontInactive        = 4,
  kThemeTabNonFrontUnavailable  = 5,
  kThemeTabFrontUnavailable     = 6
};

typedef UInt16                          ThemeTabStyle;
enum {
  kThemeTabNorth                = 0,
  kThemeTabSouth                = 1,
  kThemeTabEast                 = 2,
  kThemeTabWest                 = 3
};

typedef UInt16                          ThemeTabDirection;
/* NOTE ON TAB HEIGHT                                                                       */
/* Use the kThemeSmallTabHeightMax and kThemeLargeTabHeightMax when calculating the rects   */
/* to draw tabs into. This height includes the tab frame overlap. Tabs that are not in the  */
/* front are only drawn down to where they meet the frame, as if the height was just        */
/* kThemeLargeTabHeight, for example, as opposed to the ...Max constant. Remember that for  */
/* East and West tabs, the height referred to below is actually the width.                  */
enum {
  kThemeSmallTabHeight          = 16,   /* amount small tabs protrude from frame.*/
  kThemeLargeTabHeight          = 21,   /* amount large tabs protrude from frame.*/
  kThemeTabPaneOverlap          = 3,    /* amount tabs overlap frame.*/
  kThemeSmallTabHeightMax       = 19,   /* small tab height + overlap*/
  kThemeLargeTabHeightMax       = 24    /* large tab height + overlap*/
};

/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Track kinds                                                                              */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeMediumScrollBar         = 0,
  kThemeSmallScrollBar          = 1,
  kThemeMediumSlider            = 2,
  kThemeMediumProgressBar       = 3,
  kThemeMediumIndeterminateBar  = 4,
  kThemeRelevanceBar            = 5,
  kThemeSmallSlider             = 6,
  kThemeLargeProgressBar        = 7,
  kThemeLargeIndeterminateBar   = 8
};

typedef UInt16                          ThemeTrackKind;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Track enable states                                                                      */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
                                        /* track states */
  kThemeTrackActive             = 0,
  kThemeTrackDisabled           = 1,
  kThemeTrackNothingToScroll    = 2,
  kThemeTrackInactive           = 3
};

typedef UInt8                           ThemeTrackEnableState;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Track pressed states                                                                     */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
                                        /* press states (ignored unless track is active) */
  kThemeLeftOutsideArrowPressed = 0x01,
  kThemeLeftInsideArrowPressed  = 0x02,
  kThemeLeftTrackPressed        = 0x04,
  kThemeThumbPressed            = 0x08,
  kThemeRightTrackPressed       = 0x10,
  kThemeRightInsideArrowPressed = 0x20,
  kThemeRightOutsideArrowPressed = 0x40,
  kThemeTopOutsideArrowPressed  = kThemeLeftOutsideArrowPressed,
  kThemeTopInsideArrowPressed   = kThemeLeftInsideArrowPressed,
  kThemeTopTrackPressed         = kThemeLeftTrackPressed,
  kThemeBottomTrackPressed      = kThemeRightTrackPressed,
  kThemeBottomInsideArrowPressed = kThemeRightInsideArrowPressed,
  kThemeBottomOutsideArrowPressed = kThemeRightOutsideArrowPressed
};

typedef UInt8                           ThemeTrackPressState;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Thumb directions                                                                         */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
                                        /* thumb direction */
  kThemeThumbPlain              = 0,
  kThemeThumbUpward             = 1,
  kThemeThumbDownward           = 2
};

typedef UInt8                           ThemeThumbDirection;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Track attributes                                                                         */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeTrackHorizontal         = (1 << 0), /* track is drawn horizontally*/
  kThemeTrackRightToLeft        = (1 << 1), /* track progresses from right to left*/
  kThemeTrackShowThumb          = (1 << 2), /* track's thumb should be drawn*/
  kThemeTrackThumbRgnIsNotGhost = (1 << 3), /* the provided thumbRgn should be drawn opaque, not as a ghost*/
  kThemeTrackNoScrollBarArrows  = (1 << 4) /* the scroll bar doesn't have arrows*/
};

typedef UInt16                          ThemeTrackAttributes;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Track info block                                                                         */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
struct ScrollBarTrackInfo {
  SInt32              viewsize;               /* current view range size */
  ThemeTrackPressState  pressState;           /* pressed parts state */
};
typedef struct ScrollBarTrackInfo       ScrollBarTrackInfo;
struct SliderTrackInfo {
  ThemeThumbDirection  thumbDir;              /* thumb direction */
  ThemeTrackPressState  pressState;           /* pressed parts state */
};
typedef struct SliderTrackInfo          SliderTrackInfo;
struct ProgressTrackInfo {
  UInt8               phase;                  /* phase for indeterminate progress */
};
typedef struct ProgressTrackInfo        ProgressTrackInfo;
struct ThemeTrackDrawInfo {
  ThemeTrackKind      kind;                   /* what kind of track this info is for */
  Rect                bounds;                 /* track basis rectangle */
  SInt32              min;                    /* min track value */
  SInt32              max;                    /* max track value */
  SInt32              value;                  /* current thumb value */
  UInt32              reserved;

  ThemeTrackAttributes  attributes;           /* various track attributes */
  ThemeTrackEnableState  enableState;         /* enable state */
  UInt8               filler1;

  union {
    ScrollBarTrackInfo  scrollbar;
    SliderTrackInfo     slider;
    ProgressTrackInfo   progress;
  }                       trackInfo;
};
typedef struct ThemeTrackDrawInfo       ThemeTrackDrawInfo;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* ThemeWindowAttributes                                                                    */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeWindowHasGrow           = (1 << 0), /* can the size of the window be changed by the user? */
  kThemeWindowHasHorizontalZoom = (1 << 3), /* window can zoom only horizontally */
  kThemeWindowHasVerticalZoom   = (1 << 4), /* window can zoom only vertically */
  kThemeWindowHasFullZoom       = kThemeWindowHasHorizontalZoom + kThemeWindowHasVerticalZoom, /* window zooms in all directions */
  kThemeWindowHasCloseBox       = (1 << 5), /* window has a close box */
  kThemeWindowHasCollapseBox    = (1 << 6), /* window has a collapse box */
  kThemeWindowHasTitleText      = (1 << 7), /* window has a title/title icon */
  kThemeWindowIsCollapsed       = (1 << 8), /* window is in the collapsed state */
  kThemeWindowHasDirty          = (1 << 9)
};


typedef UInt32                          ThemeWindowAttributes;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Window Types Supported by the Appearance Manager                                         */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeDocumentWindow          = 0,
  kThemeDialogWindow            = 1,
  kThemeMovableDialogWindow     = 2,
  kThemeAlertWindow             = 3,
  kThemeMovableAlertWindow      = 4,
  kThemePlainDialogWindow       = 5,
  kThemeShadowDialogWindow      = 6,
  kThemePopupWindow             = 7,
  kThemeUtilityWindow           = 8,
  kThemeUtilitySideWindow       = 9,
  kThemeSheetWindow             = 10
};

typedef UInt16                          ThemeWindowType;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Window Widgets Supported by the Appearance Manager                                       */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeWidgetCloseBox          = 0,
  kThemeWidgetZoomBox           = 1,
  kThemeWidgetCollapseBox       = 2,
  kThemeWidgetDirtyCloseBox     = 6
};

typedef UInt16                          ThemeTitleBarWidget;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Popup arrow orientations                                                                 */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeArrowLeft               = 0,
  kThemeArrowDown               = 1,
  kThemeArrowRight              = 2,
  kThemeArrowUp                 = 3
};

typedef UInt16                          ThemeArrowOrientation;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Popup arrow sizes                                                                        */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeArrow3pt                = 0,
  kThemeArrow5pt                = 1,
  kThemeArrow7pt                = 2,
  kThemeArrow9pt                = 3
};

typedef UInt16                          ThemePopupArrowSize;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Grow box directions                                                                      */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeGrowLeft                = (1 << 0), /* can grow to the left */
  kThemeGrowRight               = (1 << 1), /* can grow to the right */
  kThemeGrowUp                  = (1 << 2), /* can grow up */
  kThemeGrowDown                = (1 << 3) /* can grow down */
};

typedef UInt16                          ThemeGrowDirection;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Button kinds                                                                             */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemePushButton              = 0,
  kThemeCheckBox                = 1,
  kThemeRadioButton             = 2,
  kThemeBevelButton             = 3,    /* bevel button (obsolete) */
  kThemeArrowButton             = 4,    /* popup button without text (no label). See ThemeButtonAdornment for glyphs. */
  kThemePopupButton             = 5,    /* popup button */
  kThemeDisclosureButton        = 6,
  kThemeIncDecButton            = 7,    /* increment/decrement buttons  (no label) */
  kThemeSmallBevelButton        = 8,    /* small-shadow bevel button */
  kThemeMediumBevelButton       = 3,    /* med-shadow bevel button */
  kThemeLargeBevelButton        = 9,    /* large-shadow bevel button */
  kThemeListHeaderButton        = 10,   /* sort button for top of list */
  kThemeRoundButton             = 11,   /* round button */
  kThemeLargeRoundButton        = 12,   /* large round button */
  kThemeSmallCheckBox           = 13,   /* small checkbox */
  kThemeSmallRadioButton        = 14,   /* small radio button */
  kThemeRoundedBevelButton      = 15,   /* rounded bevel button */
  kThemeNormalCheckBox          = kThemeCheckBox,
  kThemeNormalRadioButton       = kThemeRadioButton
};

typedef UInt16                          ThemeButtonKind;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Common button values                                                                     */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeButtonOff               = 0,
  kThemeButtonOn                = 1,
  kThemeButtonMixed             = 2,
  kThemeDisclosureRight         = 0,
  kThemeDisclosureDown          = 1,
  kThemeDisclosureLeft          = 2
};

typedef UInt16                          ThemeButtonValue;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Button adornment types                                                                   */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeAdornmentNone           = 0,
  kThemeAdornmentDefault        = (1 << 0), /* if set, draw default ornamentation ( for push button and generic well ) */
  kThemeAdornmentFocus          = (1 << 2), /* if set, draw focus */
  kThemeAdornmentRightToLeft    = (1 << 4), /* if set, draw right to left label */
  kThemeAdornmentDrawIndicatorOnly = (1 << 5), /* if set, don't draw or erase label ( radio, check, disclosure ) */
  kThemeAdornmentHeaderButtonLeftNeighborSelected = (1 << 6), /* if set, draw the left border of the button as selected ( list header button only ) */
  kThemeAdornmentHeaderButtonRightNeighborSelected = (1 << 7), /* if set, draw the right border of the button ( list header button only ) */
  kThemeAdornmentHeaderButtonSortUp = (1 << 8), /* if set, draw the sort indicator pointing upward ( list header button only ) */
  kThemeAdornmentHeaderMenuButton = (1 << 9), /* if set, draw as a header menu button ( list header button only ) */
  kThemeAdornmentHeaderButtonNoShadow = (1 << 10), /* if set, draw the non-shadow area of the button ( list header button only ) */
  kThemeAdornmentHeaderButtonShadowOnly = (1 << 11), /* if set, draw the only the shadow area of the button ( list header button only ) */
  kThemeAdornmentNoShadow       = kThemeAdornmentHeaderButtonNoShadow, /* old name */
  kThemeAdornmentShadowOnly     = kThemeAdornmentHeaderButtonShadowOnly, /* old name */
  kThemeAdornmentArrowLeftArrow = (1 << 6), /* If set, draw a left arrow on the arrow button */
  kThemeAdornmentArrowDownArrow = (1 << 7), /* If set, draw a down arrow on the arrow button */
  kThemeAdornmentArrowDoubleArrow = (1 << 8), /* If set, draw a double arrow on the arrow button */
  kThemeAdornmentArrowUpArrow   = (1 << 9) /* If set, draw a up arrow on the arrow button */
};

typedef UInt16                          ThemeButtonAdornment;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Button drawing info block                                                                */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
struct ThemeButtonDrawInfo {
  ThemeDrawState      state;
  ThemeButtonValue    value;
  ThemeButtonAdornment  adornment;
};
typedef struct ThemeButtonDrawInfo      ThemeButtonDrawInfo;
typedef ThemeButtonDrawInfo *           ThemeButtonDrawInfoPtr;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Sound Support                                                                            */
/*                                                                                          */
/*  X ALERT: Please note that none of the theme sound APIs currently function on X.         */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Sound classes                                                                            */
/*                                                                                          */
/* You can use the constants below to set what sounds are active using the SetTheme API.    */
/* Use these with the kThemeSoundMask tag.                                                  */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeNoSounds                = 0,
  kThemeWindowSoundsMask        = (1 << 0),
  kThemeMenuSoundsMask          = (1 << 1),
  kThemeControlSoundsMask       = (1 << 2),
  kThemeFinderSoundsMask        = (1 << 3)
};


/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Drag Sounds                                                                              */
/*                                                                                          */
/* Drag sounds are looped for the duration of the drag.                                     */
/*                                                                                          */
/* Call BeginThemeDragSound at the start of the drag.                                       */
/* Call EndThemeDragSound when the drag has finished.                                       */
/*                                                                                          */
/* Note that in order to maintain a consistent user experience, only one drag sound may     */
/* occur at a time.  The sound should be attached to a mouse action, start after the        */
/* mouse goes down and stop when the mouse is released.                                     */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeDragSoundNone           = 0,
  kThemeDragSoundMoveWindow     = FOUR_CHAR_CODE('wmov'),
  kThemeDragSoundGrowWindow     = FOUR_CHAR_CODE('wgro'),
  kThemeDragSoundMoveUtilWindow = FOUR_CHAR_CODE('umov'),
  kThemeDragSoundGrowUtilWindow = FOUR_CHAR_CODE('ugro'),
  kThemeDragSoundMoveDialog     = FOUR_CHAR_CODE('dmov'),
  kThemeDragSoundMoveAlert      = FOUR_CHAR_CODE('amov'),
  kThemeDragSoundMoveIcon       = FOUR_CHAR_CODE('imov'),
  kThemeDragSoundSliderThumb    = FOUR_CHAR_CODE('slth'),
  kThemeDragSoundSliderGhost    = FOUR_CHAR_CODE('slgh'),
  kThemeDragSoundScrollBarThumb = FOUR_CHAR_CODE('sbth'),
  kThemeDragSoundScrollBarGhost = FOUR_CHAR_CODE('sbgh'),
  kThemeDragSoundScrollBarArrowDecreasing = FOUR_CHAR_CODE('sbad'),
  kThemeDragSoundScrollBarArrowIncreasing = FOUR_CHAR_CODE('sbai'),
  kThemeDragSoundDragging       = FOUR_CHAR_CODE('drag')
};

typedef OSType                          ThemeDragSoundKind;
/*——————————————————————————————————————————————————————————————————————————*/
/* State-change sounds                                                      */
/*                                                                          */
/* State-change sounds are played asynchonously as a one-shot.              */
/*                                                                          */
/* Call PlayThemeSound to play the sound.  The sound will play              */
/* asynchronously until complete, then stop automatically.                  */
/*——————————————————————————————————————————————————————————————————————————*/
enum {
  kThemeSoundNone               = 0,
  kThemeSoundMenuOpen           = FOUR_CHAR_CODE('mnuo'), /* menu sounds */
  kThemeSoundMenuClose          = FOUR_CHAR_CODE('mnuc'),
  kThemeSoundMenuItemHilite     = FOUR_CHAR_CODE('mnui'),
  kThemeSoundMenuItemRelease    = FOUR_CHAR_CODE('mnus'),
  kThemeSoundWindowClosePress   = FOUR_CHAR_CODE('wclp'), /* window sounds */
  kThemeSoundWindowCloseEnter   = FOUR_CHAR_CODE('wcle'),
  kThemeSoundWindowCloseExit    = FOUR_CHAR_CODE('wclx'),
  kThemeSoundWindowCloseRelease = FOUR_CHAR_CODE('wclr'),
  kThemeSoundWindowZoomPress    = FOUR_CHAR_CODE('wzmp'),
  kThemeSoundWindowZoomEnter    = FOUR_CHAR_CODE('wzme'),
  kThemeSoundWindowZoomExit     = FOUR_CHAR_CODE('wzmx'),
  kThemeSoundWindowZoomRelease  = FOUR_CHAR_CODE('wzmr'),
  kThemeSoundWindowCollapsePress = FOUR_CHAR_CODE('wcop'),
  kThemeSoundWindowCollapseEnter = FOUR_CHAR_CODE('wcoe'),
  kThemeSoundWindowCollapseExit = FOUR_CHAR_CODE('wcox'),
  kThemeSoundWindowCollapseRelease = FOUR_CHAR_CODE('wcor'),
  kThemeSoundWindowDragBoundary = FOUR_CHAR_CODE('wdbd'),
  kThemeSoundUtilWinClosePress  = FOUR_CHAR_CODE('uclp'), /* utility window sounds */
  kThemeSoundUtilWinCloseEnter  = FOUR_CHAR_CODE('ucle'),
  kThemeSoundUtilWinCloseExit   = FOUR_CHAR_CODE('uclx'),
  kThemeSoundUtilWinCloseRelease = FOUR_CHAR_CODE('uclr'),
  kThemeSoundUtilWinZoomPress   = FOUR_CHAR_CODE('uzmp'),
  kThemeSoundUtilWinZoomEnter   = FOUR_CHAR_CODE('uzme'),
  kThemeSoundUtilWinZoomExit    = FOUR_CHAR_CODE('uzmx'),
  kThemeSoundUtilWinZoomRelease = FOUR_CHAR_CODE('uzmr'),
  kThemeSoundUtilWinCollapsePress = FOUR_CHAR_CODE('ucop'),
  kThemeSoundUtilWinCollapseEnter = FOUR_CHAR_CODE('ucoe'),
  kThemeSoundUtilWinCollapseExit = FOUR_CHAR_CODE('ucox'),
  kThemeSoundUtilWinCollapseRelease = FOUR_CHAR_CODE('ucor'),
  kThemeSoundUtilWinDragBoundary = FOUR_CHAR_CODE('udbd'),
  kThemeSoundWindowOpen         = FOUR_CHAR_CODE('wopn'), /* window close and zoom action */
  kThemeSoundWindowClose        = FOUR_CHAR_CODE('wcls'),
  kThemeSoundWindowZoomIn       = FOUR_CHAR_CODE('wzmi'),
  kThemeSoundWindowZoomOut      = FOUR_CHAR_CODE('wzmo'),
  kThemeSoundWindowCollapseUp   = FOUR_CHAR_CODE('wcol'),
  kThemeSoundWindowCollapseDown = FOUR_CHAR_CODE('wexp'),
  kThemeSoundWindowActivate     = FOUR_CHAR_CODE('wact'),
  kThemeSoundUtilWindowOpen     = FOUR_CHAR_CODE('uopn'),
  kThemeSoundUtilWindowClose    = FOUR_CHAR_CODE('ucls'),
  kThemeSoundUtilWindowZoomIn   = FOUR_CHAR_CODE('uzmi'),
  kThemeSoundUtilWindowZoomOut  = FOUR_CHAR_CODE('uzmo'),
  kThemeSoundUtilWindowCollapseUp = FOUR_CHAR_CODE('ucol'),
  kThemeSoundUtilWindowCollapseDown = FOUR_CHAR_CODE('uexp'),
  kThemeSoundUtilWindowActivate = FOUR_CHAR_CODE('uact'),
  kThemeSoundDialogOpen         = FOUR_CHAR_CODE('dopn'),
  kThemeSoundDialogClose        = FOUR_CHAR_CODE('dlgc'),
  kThemeSoundAlertOpen          = FOUR_CHAR_CODE('aopn'),
  kThemeSoundAlertClose         = FOUR_CHAR_CODE('altc'),
  kThemeSoundPopupWindowOpen    = FOUR_CHAR_CODE('pwop'),
  kThemeSoundPopupWindowClose   = FOUR_CHAR_CODE('pwcl'),
  kThemeSoundButtonPress        = FOUR_CHAR_CODE('btnp'), /* button */
  kThemeSoundButtonEnter        = FOUR_CHAR_CODE('btne'),
  kThemeSoundButtonExit         = FOUR_CHAR_CODE('btnx'),
  kThemeSoundButtonRelease      = FOUR_CHAR_CODE('btnr'),
  kThemeSoundDefaultButtonPress = FOUR_CHAR_CODE('dbtp'), /* default button */
  kThemeSoundDefaultButtonEnter = FOUR_CHAR_CODE('dbte'),
  kThemeSoundDefaultButtonExit  = FOUR_CHAR_CODE('dbtx'),
  kThemeSoundDefaultButtonRelease = FOUR_CHAR_CODE('dbtr'),
  kThemeSoundCancelButtonPress  = FOUR_CHAR_CODE('cbtp'), /* cancel button */
  kThemeSoundCancelButtonEnter  = FOUR_CHAR_CODE('cbte'),
  kThemeSoundCancelButtonExit   = FOUR_CHAR_CODE('cbtx'),
  kThemeSoundCancelButtonRelease = FOUR_CHAR_CODE('cbtr'),
  kThemeSoundCheckboxPress      = FOUR_CHAR_CODE('chkp'), /* checkboxes */
  kThemeSoundCheckboxEnter      = FOUR_CHAR_CODE('chke'),
  kThemeSoundCheckboxExit       = FOUR_CHAR_CODE('chkx'),
  kThemeSoundCheckboxRelease    = FOUR_CHAR_CODE('chkr'),
  kThemeSoundRadioPress         = FOUR_CHAR_CODE('radp'), /* radio buttons */
  kThemeSoundRadioEnter         = FOUR_CHAR_CODE('rade'),
  kThemeSoundRadioExit          = FOUR_CHAR_CODE('radx'),
  kThemeSoundRadioRelease       = FOUR_CHAR_CODE('radr'),
  kThemeSoundScrollArrowPress   = FOUR_CHAR_CODE('sbap'), /* scroll bars */
  kThemeSoundScrollArrowEnter   = FOUR_CHAR_CODE('sbae'),
  kThemeSoundScrollArrowExit    = FOUR_CHAR_CODE('sbax'),
  kThemeSoundScrollArrowRelease = FOUR_CHAR_CODE('sbar'),
  kThemeSoundScrollEndOfTrack   = FOUR_CHAR_CODE('sbte'),
  kThemeSoundScrollTrackPress   = FOUR_CHAR_CODE('sbtp'),
  kThemeSoundSliderEndOfTrack   = FOUR_CHAR_CODE('slte'), /* sliders */
  kThemeSoundSliderTrackPress   = FOUR_CHAR_CODE('sltp'),
  kThemeSoundBalloonOpen        = FOUR_CHAR_CODE('blno'), /* help balloons */
  kThemeSoundBalloonClose       = FOUR_CHAR_CODE('blnc'),
  kThemeSoundBevelPress         = FOUR_CHAR_CODE('bevp'), /* Bevel buttons */
  kThemeSoundBevelEnter         = FOUR_CHAR_CODE('beve'),
  kThemeSoundBevelExit          = FOUR_CHAR_CODE('bevx'),
  kThemeSoundBevelRelease       = FOUR_CHAR_CODE('bevr'),
  kThemeSoundLittleArrowUpPress = FOUR_CHAR_CODE('laup'), /* Little Arrows */
  kThemeSoundLittleArrowDnPress = FOUR_CHAR_CODE('ladp'),
  kThemeSoundLittleArrowEnter   = FOUR_CHAR_CODE('lare'),
  kThemeSoundLittleArrowExit    = FOUR_CHAR_CODE('larx'),
  kThemeSoundLittleArrowUpRelease = FOUR_CHAR_CODE('laur'),
  kThemeSoundLittleArrowDnRelease = FOUR_CHAR_CODE('ladr'),
  kThemeSoundPopupPress         = FOUR_CHAR_CODE('popp'), /* Popup Buttons */
  kThemeSoundPopupEnter         = FOUR_CHAR_CODE('pope'),
  kThemeSoundPopupExit          = FOUR_CHAR_CODE('popx'),
  kThemeSoundPopupRelease       = FOUR_CHAR_CODE('popr'),
  kThemeSoundDisclosurePress    = FOUR_CHAR_CODE('dscp'), /* Disclosure Buttons */
  kThemeSoundDisclosureEnter    = FOUR_CHAR_CODE('dsce'),
  kThemeSoundDisclosureExit     = FOUR_CHAR_CODE('dscx'),
  kThemeSoundDisclosureRelease  = FOUR_CHAR_CODE('dscr'),
  kThemeSoundTabPressed         = FOUR_CHAR_CODE('tabp'), /* Tabs */
  kThemeSoundTabEnter           = FOUR_CHAR_CODE('tabe'),
  kThemeSoundTabExit            = FOUR_CHAR_CODE('tabx'),
  kThemeSoundTabRelease         = FOUR_CHAR_CODE('tabr'),
  kThemeSoundDragTargetHilite   = FOUR_CHAR_CODE('dthi'), /* drag manager */
  kThemeSoundDragTargetUnhilite = FOUR_CHAR_CODE('dtuh'),
  kThemeSoundDragTargetDrop     = FOUR_CHAR_CODE('dtdr'),
  kThemeSoundEmptyTrash         = FOUR_CHAR_CODE('ftrs'), /* finder */
  kThemeSoundSelectItem         = FOUR_CHAR_CODE('fsel'),
  kThemeSoundNewItem            = FOUR_CHAR_CODE('fnew'),
  kThemeSoundReceiveDrop        = FOUR_CHAR_CODE('fdrp'),
  kThemeSoundCopyDone           = FOUR_CHAR_CODE('fcpd'),
  kThemeSoundResolveAlias       = FOUR_CHAR_CODE('fral'),
  kThemeSoundLaunchApp          = FOUR_CHAR_CODE('flap'),
  kThemeSoundDiskInsert         = FOUR_CHAR_CODE('dski'),
  kThemeSoundDiskEject          = FOUR_CHAR_CODE('dske'),
  kThemeSoundFinderDragOnIcon   = FOUR_CHAR_CODE('fdon'),
  kThemeSoundFinderDragOffIcon  = FOUR_CHAR_CODE('fdof')
};

typedef OSType                          ThemeSoundKind;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Window Metrics                                                                           */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/*  Window metrics are used by the Appearance manager to fill in the blanks necessary to    */
/*  draw windows. If a value is not appropriate for the type of window, be sure to fill in  */
/*  the slot in the structure with zero.    For the popupTabOffset parameter, you can pass a*/
/*  real value based on the left edge of the window. This value might be interpreted in a   */
/*  different manner when depending on the value of the popupTabPosition field. The values  */
/*  you can pass into popupTabPosition are:                                                 */
/*                                                                                          */
/*  kThemePopupTabNormalPosition                                                            */
/*      Starts the tab left edge at the position indicated by the popupTabOffset field.     */
/*                                                                                          */
/*  kThemePopupTabCenterOnWindow                                                            */
/*      tells us to ignore the offset field and instead simply center the width of the      */
/*      handle on the window.                                                               */
/*                                                                                          */
/*  kThemePopupTabCenterOnOffset                                                            */
/*      tells us to center the width of the handle around the value passed in offset.       */
/*                                                                                          */
/*  The Appearance Manager will try its best to accomodate the requested placement, but may */
/*  move the handle slightly to make it fit correctly.                                      */
/*                                                                                          */
enum {
  kThemePopupTabNormalPosition  = 0,
  kThemePopupTabCenterOnWindow  = 1,
  kThemePopupTabCenterOnOffset  = 2
};

struct ThemeWindowMetrics {
  UInt16              metricSize;             /* should be always be sizeof( ThemeWindowMetrics )*/
  SInt16              titleHeight;
  SInt16              titleWidth;
  SInt16              popupTabOffset;
  SInt16              popupTabWidth;
  UInt16              popupTabPosition;
};
typedef struct ThemeWindowMetrics       ThemeWindowMetrics;
typedef ThemeWindowMetrics *            ThemeWindowMetricsPtr;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Theme Metrics                                                                            */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/*  Theme metrics allow you to find out sizes of things in the current environment, such as */
/*  how wide a scroll bar is, etc.                                                          */
enum {
  kThemeMetricScrollBarWidth    = 0,
  kThemeMetricSmallScrollBarWidth = 1,
  kThemeMetricCheckBoxHeight    = 2,
  kThemeMetricRadioButtonHeight = 3,
  kThemeMetricEditTextWhitespace = 4,
  kThemeMetricEditTextFrameOutset = 5,
  kThemeMetricListBoxFrameOutset = 6,
  kThemeMetricFocusRectOutset   = 7,
  kThemeMetricImageWellThickness = 8,
  kThemeMetricScrollBarOverlap  = 9,
  kThemeMetricLargeTabHeight    = 10,
  kThemeMetricLargeTabCapsWidth = 11,
  kThemeMetricTabFrameOverlap   = 12,
  kThemeMetricTabIndentOrStyle  = 13,
  kThemeMetricTabOverlap        = 14,
  kThemeMetricSmallTabHeight    = 15,
  kThemeMetricSmallTabCapsWidth = 16,
  kThemeMetricDisclosureButtonHeight = 17,
  kThemeMetricRoundButtonSize   = 18,
  kThemeMetricPushButtonHeight  = 19,
  kThemeMetricListHeaderHeight  = 20,
  kThemeMetricSmallCheckBoxHeight = 21,
  kThemeMetricDisclosureButtonWidth = 22,
  kThemeMetricSmallDisclosureButtonHeight = 23,
  kThemeMetricSmallDisclosureButtonWidth = 24,
  kThemeMetricDisclosureTriangleHeight = 25,
  kThemeMetricDisclosureTriangleWidth = 26,
  kThemeMetricLittleArrowsHeight = 27,
  kThemeMetricLittleArrowsWidth = 28,
  kThemeMetricPaneSplitterHeight = 29,
  kThemeMetricPopupButtonHeight = 30,
  kThemeMetricSmallPopupButtonHeight = 31,
  kThemeMetricLargeProgressBarThickness = 32,
  kThemeMetricPullDownHeight    = 33,
  kThemeMetricSmallPullDownHeight = 34,
  kThemeMetricSmallPushButtonHeight = 35,
  kThemeMetricSmallRadioButtonHeight = 36,
  kThemeMetricRelevanceIndicatorHeight = 37,
  kThemeMetricResizeControlHeight = 38,
  kThemeMetricSmallResizeControlHeight = 39,
  kThemeMetricLargeRoundButtonSize = 40,
  kThemeMetricHSliderHeight     = 41,
  kThemeMetricHSliderTickHeight = 42,
  kThemeMetricSmallHSliderHeight = 43,
  kThemeMetricSmallHSliderTickHeight = 44,
  kThemeMetricVSliderWidth      = 45,
  kThemeMetricVSliderTickWidth  = 46,
  kThemeMetricSmallVSliderWidth = 47,
  kThemeMetricSmallVSliderTickWidth = 48,
  kThemeMetricTitleBarControlsHeight = 49,
  kThemeMetricCheckBoxWidth     = 50,
  kThemeMetricSmallCheckBoxWidth = 51,
  kThemeMetricRadioButtonWidth  = 52,
  kThemeMetricSmallRadioButtonWidth = 53,
  kThemeMetricSmallHSliderMinThumbWidth = 54,
  kThemeMetricSmallVSliderMinThumbHeight = 55,
  kThemeMetricSmallHSliderTickOffset = 56,
  kThemeMetricSmallVSliderTickOffset = 57,
  kThemeMetricNormalProgressBarThickness = 58,
  kThemeMetricProgressBarShadowOutset = 59,
  kThemeMetricSmallProgressBarShadowOutset = 60,
  kThemeMetricPrimaryGroupBoxContentInset = 61,
  kThemeMetricSecondaryGroupBoxContentInset = 62
};

typedef UInt32                          ThemeMetric;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Drawing State                                                                            */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
typedef struct OpaqueThemeDrawingState*  ThemeDrawingState;
/*——————————————————————————————————————————————————————————————————————————————————————————*/
/* Callback procs                                                                           */
/*——————————————————————————————————————————————————————————————————————————————————————————*/
typedef CALLBACK_API( void , ThemeTabTitleDrawProcPtr )(const Rect *bounds, ThemeTabStyle style, ThemeTabDirection direction, SInt16 depth, Boolean isColorDev, UInt32 userData);
typedef CALLBACK_API( void , ThemeEraseProcPtr )(const Rect *bounds, UInt32 eraseData, SInt16 depth, Boolean isColorDev);
typedef CALLBACK_API( void , ThemeButtonDrawProcPtr )(const Rect *bounds, ThemeButtonKind kind, const ThemeButtonDrawInfo *info, UInt32 userData, SInt16 depth, Boolean isColorDev);
typedef CALLBACK_API( void , WindowTitleDrawingProcPtr )(const Rect *bounds, SInt16 depth, Boolean colorDevice, UInt32 userData);
typedef CALLBACK_API( Boolean , ThemeIteratorProcPtr )(ConstStr255Param inFileName, SInt16 resID, Collection inThemeSettings, void *inUserData);
typedef STACK_UPP_TYPE(ThemeTabTitleDrawProcPtr)                ThemeTabTitleDrawUPP;
typedef STACK_UPP_TYPE(ThemeEraseProcPtr)                       ThemeEraseUPP;
typedef STACK_UPP_TYPE(ThemeButtonDrawProcPtr)                  ThemeButtonDrawUPP;
typedef STACK_UPP_TYPE(WindowTitleDrawingProcPtr)               WindowTitleDrawingUPP;
typedef STACK_UPP_TYPE(ThemeIteratorProcPtr)                    ThemeIteratorUPP;
/*
 *  NewThemeTabTitleDrawUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( ThemeTabTitleDrawUPP )
NewThemeTabTitleDrawUPP(ThemeTabTitleDrawProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppThemeTabTitleDrawProcInfo = 0x00036AC0 };  /* pascal no_return_value Func(4_bytes, 2_bytes, 2_bytes, 2_bytes, 1_byte, 4_bytes) */
  #ifdef __cplusplus
    inline ThemeTabTitleDrawUPP NewThemeTabTitleDrawUPP(ThemeTabTitleDrawProcPtr userRoutine) { return (ThemeTabTitleDrawUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppThemeTabTitleDrawProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewThemeTabTitleDrawUPP(userRoutine) (ThemeTabTitleDrawUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppThemeTabTitleDrawProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewThemeEraseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( ThemeEraseUPP )
NewThemeEraseUPP(ThemeEraseProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppThemeEraseProcInfo = 0x00001BC0 };  /* pascal no_return_value Func(4_bytes, 4_bytes, 2_bytes, 1_byte) */
  #ifdef __cplusplus
    inline ThemeEraseUPP NewThemeEraseUPP(ThemeEraseProcPtr userRoutine) { return (ThemeEraseUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppThemeEraseProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewThemeEraseUPP(userRoutine) (ThemeEraseUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppThemeEraseProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewThemeButtonDrawUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( ThemeButtonDrawUPP )
NewThemeButtonDrawUPP(ThemeButtonDrawProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppThemeButtonDrawProcInfo = 0x0001BEC0 };  /* pascal no_return_value Func(4_bytes, 2_bytes, 4_bytes, 4_bytes, 2_bytes, 1_byte) */
  #ifdef __cplusplus
    inline ThemeButtonDrawUPP NewThemeButtonDrawUPP(ThemeButtonDrawProcPtr userRoutine) { return (ThemeButtonDrawUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppThemeButtonDrawProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewThemeButtonDrawUPP(userRoutine) (ThemeButtonDrawUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppThemeButtonDrawProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewWindowTitleDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( WindowTitleDrawingUPP )
NewWindowTitleDrawingUPP(WindowTitleDrawingProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppWindowTitleDrawingProcInfo = 0x000036C0 };  /* pascal no_return_value Func(4_bytes, 2_bytes, 1_byte, 4_bytes) */
  #ifdef __cplusplus
    inline WindowTitleDrawingUPP NewWindowTitleDrawingUPP(WindowTitleDrawingProcPtr userRoutine) { return (WindowTitleDrawingUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppWindowTitleDrawingProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewWindowTitleDrawingUPP(userRoutine) (WindowTitleDrawingUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppWindowTitleDrawingProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewThemeIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( ThemeIteratorUPP )
NewThemeIteratorUPP(ThemeIteratorProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppThemeIteratorProcInfo = 0x00003ED0 };  /* pascal 1_byte Func(4_bytes, 2_bytes, 4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline ThemeIteratorUPP NewThemeIteratorUPP(ThemeIteratorProcPtr userRoutine) { return (ThemeIteratorUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppThemeIteratorProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewThemeIteratorUPP(userRoutine) (ThemeIteratorUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppThemeIteratorProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposeThemeTabTitleDrawUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeThemeTabTitleDrawUPP(ThemeTabTitleDrawUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeThemeTabTitleDrawUPP(ThemeTabTitleDrawUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeThemeTabTitleDrawUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeThemeEraseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeThemeEraseUPP(ThemeEraseUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeThemeEraseUPP(ThemeEraseUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeThemeEraseUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeThemeButtonDrawUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeThemeButtonDrawUPP(ThemeButtonDrawUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeThemeButtonDrawUPP(ThemeButtonDrawUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeThemeButtonDrawUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeWindowTitleDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeWindowTitleDrawingUPP(WindowTitleDrawingUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeWindowTitleDrawingUPP(WindowTitleDrawingUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeWindowTitleDrawingUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeThemeIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeThemeIteratorUPP(ThemeIteratorUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeThemeIteratorUPP(ThemeIteratorUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeThemeIteratorUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokeThemeTabTitleDrawUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
InvokeThemeTabTitleDrawUPP(
  const Rect *          bounds,
  ThemeTabStyle         style,
  ThemeTabDirection     direction,
  SInt16                depth,
  Boolean               isColorDev,
  UInt32                userData,
  ThemeTabTitleDrawUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeThemeTabTitleDrawUPP(const Rect * bounds, ThemeTabStyle style, ThemeTabDirection direction, SInt16 depth, Boolean isColorDev, UInt32 userData, ThemeTabTitleDrawUPP userUPP) { CALL_SIX_PARAMETER_UPP(userUPP, uppThemeTabTitleDrawProcInfo, bounds, style, direction, depth, isColorDev, userData); }
  #else
    #define InvokeThemeTabTitleDrawUPP(bounds, style, direction, depth, isColorDev, userData, userUPP) CALL_SIX_PARAMETER_UPP((userUPP), uppThemeTabTitleDrawProcInfo, (bounds), (style), (direction), (depth), (isColorDev), (userData))
  #endif
#endif

/*
 *  InvokeThemeEraseUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
InvokeThemeEraseUPP(
  const Rect *   bounds,
  UInt32         eraseData,
  SInt16         depth,
  Boolean        isColorDev,
  ThemeEraseUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeThemeEraseUPP(const Rect * bounds, UInt32 eraseData, SInt16 depth, Boolean isColorDev, ThemeEraseUPP userUPP) { CALL_FOUR_PARAMETER_UPP(userUPP, uppThemeEraseProcInfo, bounds, eraseData, depth, isColorDev); }
  #else
    #define InvokeThemeEraseUPP(bounds, eraseData, depth, isColorDev, userUPP) CALL_FOUR_PARAMETER_UPP((userUPP), uppThemeEraseProcInfo, (bounds), (eraseData), (depth), (isColorDev))
  #endif
#endif

/*
 *  InvokeThemeButtonDrawUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
InvokeThemeButtonDrawUPP(
  const Rect *                 bounds,
  ThemeButtonKind              kind,
  const ThemeButtonDrawInfo *  info,
  UInt32                       userData,
  SInt16                       depth,
  Boolean                      isColorDev,
  ThemeButtonDrawUPP           userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeThemeButtonDrawUPP(const Rect * bounds, ThemeButtonKind kind, const ThemeButtonDrawInfo * info, UInt32 userData, SInt16 depth, Boolean isColorDev, ThemeButtonDrawUPP userUPP) { CALL_SIX_PARAMETER_UPP(userUPP, uppThemeButtonDrawProcInfo, bounds, kind, info, userData, depth, isColorDev); }
  #else
    #define InvokeThemeButtonDrawUPP(bounds, kind, info, userData, depth, isColorDev, userUPP) CALL_SIX_PARAMETER_UPP((userUPP), uppThemeButtonDrawProcInfo, (bounds), (kind), (info), (userData), (depth), (isColorDev))
  #endif
#endif

/*
 *  InvokeWindowTitleDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
InvokeWindowTitleDrawingUPP(
  const Rect *           bounds,
  SInt16                 depth,
  Boolean                colorDevice,
  UInt32                 userData,
  WindowTitleDrawingUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeWindowTitleDrawingUPP(const Rect * bounds, SInt16 depth, Boolean colorDevice, UInt32 userData, WindowTitleDrawingUPP userUPP) { CALL_FOUR_PARAMETER_UPP(userUPP, uppWindowTitleDrawingProcInfo, bounds, depth, colorDevice, userData); }
  #else
    #define InvokeWindowTitleDrawingUPP(bounds, depth, colorDevice, userData, userUPP) CALL_FOUR_PARAMETER_UPP((userUPP), uppWindowTitleDrawingProcInfo, (bounds), (depth), (colorDevice), (userData))
  #endif
#endif

/*
 *  InvokeThemeIteratorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
InvokeThemeIteratorUPP(
  ConstStr255Param  inFileName,
  SInt16            resID,
  Collection        inThemeSettings,
  void *            inUserData,
  ThemeIteratorUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline Boolean InvokeThemeIteratorUPP(ConstStr255Param inFileName, SInt16 resID, Collection inThemeSettings, void * inUserData, ThemeIteratorUPP userUPP) { return (Boolean)CALL_FOUR_PARAMETER_UPP(userUPP, uppThemeIteratorProcInfo, inFileName, resID, inThemeSettings, inUserData); }
  #else
    #define InvokeThemeIteratorUPP(inFileName, resID, inThemeSettings, inUserData, userUPP) (Boolean)CALL_FOUR_PARAMETER_UPP((userUPP), uppThemeIteratorProcInfo, (inFileName), (resID), (inThemeSettings), (inUserData))
  #endif
#endif

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewThemeTabTitleDrawProc(userRoutine)               NewThemeTabTitleDrawUPP(userRoutine)
    #define NewThemeEraseProc(userRoutine)                      NewThemeEraseUPP(userRoutine)
    #define NewThemeButtonDrawProc(userRoutine)                 NewThemeButtonDrawUPP(userRoutine)
    #define NewWindowTitleDrawingProc(userRoutine)              NewWindowTitleDrawingUPP(userRoutine)
    #define NewThemeIteratorProc(userRoutine)                   NewThemeIteratorUPP(userRoutine)
    #define CallThemeTabTitleDrawProc(userRoutine, bounds, style, direction, depth, isColorDev, userData) InvokeThemeTabTitleDrawUPP(bounds, style, direction, depth, isColorDev, userData, userRoutine)
    #define CallThemeEraseProc(userRoutine, bounds, eraseData, depth, isColorDev) InvokeThemeEraseUPP(bounds, eraseData, depth, isColorDev, userRoutine)
    #define CallThemeButtonDrawProc(userRoutine, bounds, kind, info, userData, depth, isColorDev) InvokeThemeButtonDrawUPP(bounds, kind, info, userData, depth, isColorDev, userRoutine)
    #define CallWindowTitleDrawingProc(userRoutine, bounds, depth, colorDevice, userData) InvokeWindowTitleDrawingUPP(bounds, depth, colorDevice, userData, userRoutine)
    #define CallThemeIteratorProc(userRoutine, inFileName, resID, inThemeSettings, inUserData) InvokeThemeIteratorUPP(inFileName, resID, inThemeSettings, inUserData, userRoutine)
#endif /* CALL_NOT_IN_CARBON */

/*——————————————————————————————————————————————————————————————————————————————————*/
/* Menu Drawing callbacks                                                           */
/*——————————————————————————————————————————————————————————————————————————————————*/
typedef CALLBACK_API( void , MenuTitleDrawingProcPtr )(const Rect *inBounds, SInt16 inDepth, Boolean inIsColorDevice, SInt32 inUserData);
typedef CALLBACK_API( void , MenuItemDrawingProcPtr )(const Rect *inBounds, SInt16 inDepth, Boolean inIsColorDevice, SInt32 inUserData);
typedef STACK_UPP_TYPE(MenuTitleDrawingProcPtr)                 MenuTitleDrawingUPP;
typedef STACK_UPP_TYPE(MenuItemDrawingProcPtr)                  MenuItemDrawingUPP;
/*
 *  NewMenuTitleDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( MenuTitleDrawingUPP )
NewMenuTitleDrawingUPP(MenuTitleDrawingProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppMenuTitleDrawingProcInfo = 0x000036C0 };  /* pascal no_return_value Func(4_bytes, 2_bytes, 1_byte, 4_bytes) */
  #ifdef __cplusplus
    inline MenuTitleDrawingUPP NewMenuTitleDrawingUPP(MenuTitleDrawingProcPtr userRoutine) { return (MenuTitleDrawingUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppMenuTitleDrawingProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewMenuTitleDrawingUPP(userRoutine) (MenuTitleDrawingUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppMenuTitleDrawingProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  NewMenuItemDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( MenuItemDrawingUPP )
NewMenuItemDrawingUPP(MenuItemDrawingProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppMenuItemDrawingProcInfo = 0x000036C0 };  /* pascal no_return_value Func(4_bytes, 2_bytes, 1_byte, 4_bytes) */
  #ifdef __cplusplus
    inline MenuItemDrawingUPP NewMenuItemDrawingUPP(MenuItemDrawingProcPtr userRoutine) { return (MenuItemDrawingUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppMenuItemDrawingProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewMenuItemDrawingUPP(userRoutine) (MenuItemDrawingUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppMenuItemDrawingProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposeMenuTitleDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeMenuTitleDrawingUPP(MenuTitleDrawingUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeMenuTitleDrawingUPP(MenuTitleDrawingUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeMenuTitleDrawingUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  DisposeMenuItemDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeMenuItemDrawingUPP(MenuItemDrawingUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeMenuItemDrawingUPP(MenuItemDrawingUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeMenuItemDrawingUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokeMenuTitleDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
InvokeMenuTitleDrawingUPP(
  const Rect *         inBounds,
  SInt16               inDepth,
  Boolean              inIsColorDevice,
  SInt32               inUserData,
  MenuTitleDrawingUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeMenuTitleDrawingUPP(const Rect * inBounds, SInt16 inDepth, Boolean inIsColorDevice, SInt32 inUserData, MenuTitleDrawingUPP userUPP) { CALL_FOUR_PARAMETER_UPP(userUPP, uppMenuTitleDrawingProcInfo, inBounds, inDepth, inIsColorDevice, inUserData); }
  #else
    #define InvokeMenuTitleDrawingUPP(inBounds, inDepth, inIsColorDevice, inUserData, userUPP) CALL_FOUR_PARAMETER_UPP((userUPP), uppMenuTitleDrawingProcInfo, (inBounds), (inDepth), (inIsColorDevice), (inUserData))
  #endif
#endif

/*
 *  InvokeMenuItemDrawingUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
InvokeMenuItemDrawingUPP(
  const Rect *        inBounds,
  SInt16              inDepth,
  Boolean             inIsColorDevice,
  SInt32              inUserData,
  MenuItemDrawingUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void InvokeMenuItemDrawingUPP(const Rect * inBounds, SInt16 inDepth, Boolean inIsColorDevice, SInt32 inUserData, MenuItemDrawingUPP userUPP) { CALL_FOUR_PARAMETER_UPP(userUPP, uppMenuItemDrawingProcInfo, inBounds, inDepth, inIsColorDevice, inUserData); }
  #else
    #define InvokeMenuItemDrawingUPP(inBounds, inDepth, inIsColorDevice, inUserData, userUPP) CALL_FOUR_PARAMETER_UPP((userUPP), uppMenuItemDrawingProcInfo, (inBounds), (inDepth), (inIsColorDevice), (inUserData))
  #endif
#endif

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewMenuTitleDrawingProc(userRoutine)                NewMenuTitleDrawingUPP(userRoutine)
    #define NewMenuItemDrawingProc(userRoutine)                 NewMenuItemDrawingUPP(userRoutine)
    #define CallMenuTitleDrawingProc(userRoutine, inBounds, inDepth, inIsColorDevice, inUserData) InvokeMenuTitleDrawingUPP(inBounds, inDepth, inIsColorDevice, inUserData, userRoutine)
    #define CallMenuItemDrawingProc(userRoutine, inBounds, inDepth, inIsColorDevice, inUserData) InvokeMenuItemDrawingUPP(inBounds, inDepth, inIsColorDevice, inUserData, userRoutine)
#endif /* CALL_NOT_IN_CARBON */

/*——————————————————————————————————————————————————————————————————————————————————*/
/*  Appearance Manager APIs                                                         */
/*——————————————————————————————————————————————————————————————————————————————————*/
/* Registering Appearance-Savvy Applications */
/*
 *  RegisterAppearanceClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
RegisterAppearanceClient(void)                                THREEWORDINLINE(0x303C, 0x0015, 0xAA74);


/*
 *  UnregisterAppearanceClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
UnregisterAppearanceClient(void)                              THREEWORDINLINE(0x303C, 0x0016, 0xAA74);


/*
 *  IsAppearanceClient()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
IsAppearanceClient(const ProcessSerialNumber * process)       THREEWORDINLINE(0x303C, 0xFFFF, 0xAA74);


/*****************************************************************************
    NOTES ON THEME BRUSHES
    Theme brushes can be either colors or patterns, depending on the theme.
    Because of this, you should be prepared to handle the case where a brush
    is a pattern and save and restore the pnPixPat and bkPixPat fields of
    your GrafPorts when saving the fore and back colors. Also, since patterns
    in bkPixPat override the background color of the window, you should use
    BackPat to set your background pattern to a normal white pattern. This
    will ensure that you can use RGBBackColor to set your back color to white,
    call EraseRect and get the expected results.
*****************************************************************************/

/*
 *  SetThemePen()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetThemePen(
  ThemeBrush   inBrush,
  SInt16       inDepth,
  Boolean      inIsColorDevice)                               THREEWORDINLINE(0x303C, 0x0001, 0xAA74);


/*
 *  SetThemeBackground()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetThemeBackground(
  ThemeBrush   inBrush,
  SInt16       inDepth,
  Boolean      inIsColorDevice)                               THREEWORDINLINE(0x303C, 0x0002, 0xAA74);


/*
 *  SetThemeTextColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetThemeTextColor(
  ThemeTextColor   inColor,
  SInt16           inDepth,
  Boolean          inIsColorDevice)                           THREEWORDINLINE(0x303C, 0x0003, 0xAA74);


/*
 *  SetThemeWindowBackground()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetThemeWindowBackground(
  WindowRef    inWindow,
  ThemeBrush   inBrush,
  Boolean      inUpdate)                                      THREEWORDINLINE(0x303C, 0x0004, 0xAA74);


/* Window Placards, Headers and Frames */
/*
 *  DrawThemeWindowHeader()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeWindowHeader(
  const Rect *     inRect,
  ThemeDrawState   inState)                                   THREEWORDINLINE(0x303C, 0x0005, 0xAA74);


/*
 *  DrawThemeWindowListViewHeader()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeWindowListViewHeader(
  const Rect *     inRect,
  ThemeDrawState   inState)                                   THREEWORDINLINE(0x303C, 0x0006, 0xAA74);


/*
 *  DrawThemePlacard()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemePlacard(
  const Rect *     inRect,
  ThemeDrawState   inState)                                   THREEWORDINLINE(0x303C, 0x0007, 0xAA74);


/*
 *  DrawThemeEditTextFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeEditTextFrame(
  const Rect *     inRect,
  ThemeDrawState   inState)                                   THREEWORDINLINE(0x303C, 0x0009, 0xAA74);


/*
 *  DrawThemeListBoxFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeListBoxFrame(
  const Rect *     inRect,
  ThemeDrawState   inState)                                   THREEWORDINLINE(0x303C, 0x000A, 0xAA74);


/* Keyboard Focus Drawing */
/*
 *  DrawThemeFocusRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeFocusRect(
  const Rect *  inRect,
  Boolean       inHasFocus)                                   THREEWORDINLINE(0x303C, 0x000B, 0xAA74);


/* Dialog Group Boxes and Separators */
/*
 *  DrawThemePrimaryGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemePrimaryGroup(
  const Rect *     inRect,
  ThemeDrawState   inState)                                   THREEWORDINLINE(0x303C, 0x000C, 0xAA74);


/*
 *  DrawThemeSecondaryGroup()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeSecondaryGroup(
  const Rect *     inRect,
  ThemeDrawState   inState)                                   THREEWORDINLINE(0x303C, 0x000D, 0xAA74);


/*
 *  DrawThemeSeparator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeSeparator(
  const Rect *     inRect,
  ThemeDrawState   inState)                                   THREEWORDINLINE(0x303C, 0x000E, 0xAA74);


/*—————————————————————————————— BEGIN APPEARANCE 1.0.1 ————————————————————————————————————————————*/
/* The following Appearance Manager APIs are only available */
/* in Appearance 1.0.1 or later                             */
/*
 *  DrawThemeModelessDialogFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeModelessDialogFrame(
  const Rect *     inRect,
  ThemeDrawState   inState)                                   THREEWORDINLINE(0x303C, 0x0008, 0xAA74);


/*
 *  DrawThemeGenericWell()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeGenericWell(
  const Rect *     inRect,
  ThemeDrawState   inState,
  Boolean          inFillCenter)                              THREEWORDINLINE(0x303C, 0x0022, 0xAA74);


/*
 *  DrawThemeFocusRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeFocusRegion(
  RgnHandle   inRegion,
  Boolean     inHasFocus)                                     THREEWORDINLINE(0x303C, 0x0023, 0xAA74);


/*
 *  IsThemeInColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
IsThemeInColor(
  SInt16    inDepth,
  Boolean   inIsColorDevice)                                  THREEWORDINLINE(0x303C, 0x0024, 0xAA74);


/* IMPORTANT: GetThemeAccentColors will only work in the platinum theme. Any other theme will */
/* most likely return an error */
/*
 *  GetThemeAccentColors()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeAccentColors(CTabHandle * outColors)                  THREEWORDINLINE(0x303C, 0x0025, 0xAA74);


/*
 *  DrawThemeMenuBarBackground()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeMenuBarBackground(
  const Rect *        inBounds,
  ThemeMenuBarState   inState,
  UInt32              inAttributes)                           THREEWORDINLINE(0x303C, 0x0018, 0xAA74);


/*
 *  DrawThemeMenuTitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeMenuTitle(
  const Rect *          inMenuBarRect,
  const Rect *          inTitleRect,
  ThemeMenuState        inState,
  UInt32                inAttributes,
  MenuTitleDrawingUPP   inTitleProc,         /* can be NULL */
  UInt32                inTitleData)                          THREEWORDINLINE(0x303C, 0x0019, 0xAA74);



/*
 *  GetThemeMenuBarHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeMenuBarHeight(SInt16 * outHeight)                     THREEWORDINLINE(0x303C, 0x001A, 0xAA74);


/*
 *  DrawThemeMenuBackground()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeMenuBackground(
  const Rect *    inMenuRect,
  ThemeMenuType   inMenuType)                                 THREEWORDINLINE(0x303C, 0x001B, 0xAA74);


/*
 *  GetThemeMenuBackgroundRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeMenuBackgroundRegion(
  const Rect *    inMenuRect,
  ThemeMenuType   menuType,
  RgnHandle       region)                                     THREEWORDINLINE(0x303C, 0x001C, 0xAA74);


/*
 *  DrawThemeMenuItem()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeMenuItem(
  const Rect *         inMenuRect,
  const Rect *         inItemRect,
  SInt16               inVirtualMenuTop,
  SInt16               inVirtualMenuBottom,
  ThemeMenuState       inState,
  ThemeMenuItemType    inItemType,
  MenuItemDrawingUPP   inDrawProc,                /* can be NULL */
  UInt32               inUserData)                            THREEWORDINLINE(0x303C, 0x001D, 0xAA74);


/*
 *  DrawThemeMenuSeparator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeMenuSeparator(const Rect * inItemRect)               THREEWORDINLINE(0x303C, 0x001E, 0xAA74);


/*
 *  GetThemeMenuSeparatorHeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeMenuSeparatorHeight(SInt16 * outHeight)               THREEWORDINLINE(0x303C, 0x001F, 0xAA74);


/*
 *  GetThemeMenuItemExtra()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeMenuItemExtra(
  ThemeMenuItemType   inItemType,
  SInt16 *            outHeight,
  SInt16 *            outWidth)                               THREEWORDINLINE(0x303C, 0x0020, 0xAA74);


/*
 *  GetThemeMenuTitleExtra()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeMenuTitleExtra(
  SInt16 *  outWidth,
  Boolean   inIsSquished)                                     THREEWORDINLINE(0x303C, 0x0021, 0xAA74);


/*——————————————————————————————— BEGIN APPEARANCE 1.1 —————————————————————————————————————————————*/
/*—————————————————————————————————— THEME SWITCHING ———————————————————————————————————————————————*/
/*                                                                                                  */
/*  X ALERT: Please note that Get/SetTheme are severely neutered under Mac OS X at present.         */
/*           See the note above regarding what collection tags are supported under X.               */

/*
 *  GetTheme()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetTheme(Collection ioCollection);


/*
 *  SetTheme()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetTheme(Collection ioCollection);


/*
 *  IterateThemes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
IterateThemes(
  ThemeIteratorUPP   inProc,
  void *             inUserData);      /* can be NULL */


/*———————————————————————————————————————— TABS ————————————————————————————————————————————————————*/
/*
 *  DrawThemeTabPane()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeTabPane(
  const Rect *     inRect,
  ThemeDrawState   inState);


/*
 *  DrawThemeTab()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeTab(
  const Rect *           inRect,
  ThemeTabStyle          inStyle,
  ThemeTabDirection      inDirection,
  ThemeTabTitleDrawUPP   labelProc,         /* can be NULL */
  UInt32                 userData);


/*
 *  GetThemeTabRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeTabRegion(
  const Rect *        inRect,
  ThemeTabStyle       inStyle,
  ThemeTabDirection   inDirection,
  RgnHandle           ioRgn);


/*——————————————————————————————————————— CURSORS ——————————————————————————————————————————————————*/
/*
 *  SetThemeCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetThemeCursor(ThemeCursor inCursor);


/*
 *  SetAnimatedThemeCursor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetAnimatedThemeCursor(
  ThemeCursor   inCursor,
  UInt32        inAnimationStep);


/*———————————————————————————————— CONTROL STYLE SETTINGS ——————————————————————————————————————————*/
/*
 *  GetThemeScrollBarThumbStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeScrollBarThumbStyle(ThemeScrollBarThumbStyle * outStyle);


/*
 *  GetThemeScrollBarArrowStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeScrollBarArrowStyle(ThemeScrollBarArrowStyle * outStyle);


/*
 *  GetThemeCheckBoxStyle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeCheckBoxStyle(ThemeCheckBoxStyle * outStyle);


/*———————————————————————————————————————— FONTS/TEXT ——————————————————————————————————————————————*/
/*
 *  UseThemeFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
UseThemeFont(
  ThemeFontID   inFontID,
  ScriptCode    inScript);


/*
 *  GetThemeFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeFont(
  ThemeFontID   inFontID,
  ScriptCode    inScript,
  Str255        outFontName,       /* can be NULL */
  SInt16 *      outFontSize,
  Style *       outStyle);


/*
 *  DrawThemeTextBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeTextBox(
  CFStringRef      inString,
  ThemeFontID      inFontID,
  ThemeDrawState   inState,
  Boolean          inWrapToWidth,
  const Rect *     inBoundingBox,
  SInt16           inJust,
  void *           inContext);


/*
 *  TruncateThemeText()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
TruncateThemeText(
  CFMutableStringRef   inString,
  ThemeFontID          inFontID,
  ThemeDrawState       inState,
  SInt16               inPixelWidthLimit,
  TruncCode            inTruncWhere,
  Boolean *            outTruncated);           /* can be NULL */


/*
 *  GetThemeTextDimensions()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeTextDimensions(
  CFStringRef      inString,
  ThemeFontID      inFontID,
  ThemeDrawState   inState,
  Boolean          inWrapToWidth,
  Point *          ioBounds,
  SInt16 *         outBaseline);


/*
 *  GetThemeTextShadowOutset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeTextShadowOutset(
  ThemeFontID      inFontID,
  ThemeDrawState   inState,
  Rect *           outOutset);


/*———————————————————————————————————————— TRACKS ——————————————————————————————————————————————————*/
/*
 *  DrawThemeTrack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeTrack(
  const ThemeTrackDrawInfo *  drawInfo,
  RgnHandle                   rgnGhost,        /* can be NULL */
  ThemeEraseUPP               eraseProc,       /* can be NULL */
  UInt32                      eraseData);


/*
 *  HitTestThemeTrack()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
HitTestThemeTrack(
  const ThemeTrackDrawInfo *  drawInfo,
  Point                       mousePoint,
  ControlPartCode *           partHit);


/*
 *  GetThemeTrackBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeTrackBounds(
  const ThemeTrackDrawInfo *  drawInfo,
  Rect *                      bounds);


/*
 *  GetThemeTrackThumbRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeTrackThumbRgn(
  const ThemeTrackDrawInfo *  drawInfo,
  RgnHandle                   thumbRgn);


/*
 *  GetThemeTrackDragRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeTrackDragRect(
  const ThemeTrackDrawInfo *  drawInfo,
  Rect *                      dragRect);


/*
 *  DrawThemeTrackTickMarks()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeTrackTickMarks(
  const ThemeTrackDrawInfo *  drawInfo,
  ItemCount                   numTicks,
  ThemeEraseUPP               eraseProc,       /* can be NULL */
  UInt32                      eraseData);


/*
 *  GetThemeTrackThumbPositionFromOffset()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeTrackThumbPositionFromOffset(
  const ThemeTrackDrawInfo *  drawInfo,
  Point                       thumbOffset,
  SInt32 *                    relativePosition);


/*
 *  GetThemeTrackThumbPositionFromRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeTrackThumbPositionFromRegion(
  const ThemeTrackDrawInfo *  drawInfo,
  RgnHandle                   thumbRgn,
  SInt32 *                    relativePosition);


/*
 *  GetThemeTrackLiveValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeTrackLiveValue(
  const ThemeTrackDrawInfo *  drawInfo,
  SInt32                      relativePosition,
  SInt32 *                    value);


/*——————————————————————————————————— SCROLLBAR ARROWS —————————————————————————————————————————————*/
/*
 *  DrawThemeScrollBarArrows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeScrollBarArrows(
  const Rect *            bounds,
  ThemeTrackEnableState   enableState,
  ThemeTrackPressState    pressState,
  Boolean                 isHoriz,
  Rect *                  trackBounds);


/*
 *  GetThemeScrollBarTrackRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeScrollBarTrackRect(
  const Rect *            bounds,
  ThemeTrackEnableState   enableState,
  ThemeTrackPressState    pressState,
  Boolean                 isHoriz,
  Rect *                  trackBounds);


/*
 *  HitTestThemeScrollBarArrows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
HitTestThemeScrollBarArrows(
  const Rect *            scrollBarBounds,
  ThemeTrackEnableState   enableState,
  ThemeTrackPressState    pressState,
  Boolean                 isHoriz,
  Point                   ptHit,
  Rect *                  trackBounds,
  ControlPartCode *       partcode);


/*———————————————————————————————————————— WINDOWS —————————————————————————————————————————————————*/
/*
 *  GetThemeWindowRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeWindowRegion(
  ThemeWindowType             flavor,
  const Rect *                contRect,
  ThemeDrawState              state,
  const ThemeWindowMetrics *  metrics,
  ThemeWindowAttributes       attributes,
  WindowRegionCode            winRegion,
  RgnHandle                   rgn);


/*
 *  DrawThemeWindowFrame()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeWindowFrame(
  ThemeWindowType             flavor,
  const Rect *                contRect,
  ThemeDrawState              state,
  const ThemeWindowMetrics *  metrics,
  ThemeWindowAttributes       attributes,
  WindowTitleDrawingUPP       titleProc,        /* can be NULL */
  UInt32                      titleData);


/*
 *  DrawThemeTitleBarWidget()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeTitleBarWidget(
  ThemeWindowType             flavor,
  const Rect *                contRect,
  ThemeDrawState              state,
  const ThemeWindowMetrics *  metrics,
  ThemeWindowAttributes       attributes,
  ThemeTitleBarWidget         widget);


/*
 *  GetThemeWindowRegionHit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
GetThemeWindowRegionHit(
  ThemeWindowType             flavor,
  const Rect *                inContRect,
  ThemeDrawState              state,
  const ThemeWindowMetrics *  metrics,
  ThemeWindowAttributes       inAttributes,
  Point                       inPoint,
  WindowRegionCode *          outRegionHit);


/*
 *  DrawThemeScrollBarDelimiters()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeScrollBarDelimiters(
  ThemeWindowType         flavor,
  const Rect *            inContRect,
  ThemeDrawState          state,
  ThemeWindowAttributes   attributes);



/*———————————————————————————————————————— BUTTONS —————————————————————————————————————————————————*/
/*
 *  DrawThemeButton()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeButton(
  const Rect *                 inBounds,
  ThemeButtonKind              inKind,
  const ThemeButtonDrawInfo *  inNewInfo,
  const ThemeButtonDrawInfo *  inPrevInfo,        /* can be NULL */
  ThemeEraseUPP                inEraseProc,       /* can be NULL */
  ThemeButtonDrawUPP           inLabelProc,       /* can be NULL */
  UInt32                       inUserData);


/*
 *  GetThemeButtonRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeButtonRegion(
  const Rect *                 inBounds,
  ThemeButtonKind              inKind,
  const ThemeButtonDrawInfo *  inNewInfo,
  RgnHandle                    outRegion);


/*
 *  GetThemeButtonContentBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeButtonContentBounds(
  const Rect *                 inBounds,
  ThemeButtonKind              inKind,
  const ThemeButtonDrawInfo *  inDrawInfo,
  Rect *                       outBounds);


/*
 *  GetThemeButtonBackgroundBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeButtonBackgroundBounds(
  const Rect *                 inBounds,
  ThemeButtonKind              inKind,
  const ThemeButtonDrawInfo *  inDrawInfo,
  Rect *                       outBounds);



/*————————————————————————————————————— INTERFACE SOUNDS ———————————————————————————————————————————*/
/*                                                                                                  */
/*  X ALERT: Please note that the sound APIs do not work on Mac OS X at present.                    */
/*
 *  PlayThemeSound()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
PlayThemeSound(ThemeSoundKind kind)                           THREEWORDINLINE(0x303C, 0x0026, 0xAA74);


/*
 *  BeginThemeDragSound()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
BeginThemeDragSound(ThemeDragSoundKind kind)                  THREEWORDINLINE(0x303C, 0x0027, 0xAA74);


/*
 *  EndThemeDragSound()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
EndThemeDragSound(void)                                       THREEWORDINLINE(0x303C, 0x0028, 0xAA74);


/*—————————————————————————————————————— PRIMITIVES ————————————————————————————————————————————————*/
/*
 *  DrawThemeTickMark()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeTickMark(
  const Rect *     bounds,
  ThemeDrawState   state);


/*
 *  DrawThemeChasingArrows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeChasingArrows(
  const Rect *     bounds,
  UInt32           index,
  ThemeDrawState   state,
  ThemeEraseUPP    eraseProc,       /* can be NULL */
  UInt32           eraseData);


/*
 *  DrawThemePopupArrow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemePopupArrow(
  const Rect *            bounds,
  ThemeArrowOrientation   orientation,
  ThemePopupArrowSize     size,
  ThemeDrawState          state,
  ThemeEraseUPP           eraseProc,         /* can be NULL */
  UInt32                  eraseData);


/*
 *  DrawThemeStandaloneGrowBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeStandaloneGrowBox(
  Point                origin,
  ThemeGrowDirection   growDirection,
  Boolean              isSmall,
  ThemeDrawState       state);


/*
 *  DrawThemeStandaloneNoGrowBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DrawThemeStandaloneNoGrowBox(
  Point                origin,
  ThemeGrowDirection   growDirection,
  Boolean              isSmall,
  ThemeDrawState       state);


/*
 *  GetThemeStandaloneGrowBoxBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeStandaloneGrowBoxBounds(
  Point                origin,
  ThemeGrowDirection   growDirection,
  Boolean              isSmall,
  Rect *               bounds);


/*————————————————————————————————————— DRAWING STATE ——————————————————————————————————————————————*/
/* The following routines help you save and restore the drawing state in a theme-savvy manner. With */
/* these weapons in your arsenal, there is no grafport you cannot tame. Use ThemeGetDrawingState to */
/* get the current drawing settings for the current port. It will return an opaque object for you   */
/* to pass into ThemeSetDrawingState later on. When you are finished with the state, call the       */
/* ThemeDisposeDrawingState routine. You can alternatively pass true into the inDisposeNow          */
/* parameter of the ThemeSetDrawingState routine.  You can use this routine to copy the drawing     */
/* state from one port to another as well.                                                          */
/*                                                                                                  */
/* As of this writing (Mac OS 9.1 and Mac OS X), Get/SetThemeDrawingState will save and restore     */
/* this data in the port:                                                                           */
/*                                                                                                  */
/*      pen size                                                                                    */
/*      pen location                                                                                */
/*      pen mode                                                                                    */
/*      pen Pattern and PixPat                                                                      */
/*      background Pattern and PixPat                                                               */
/*      RGB foreground and background colors                                                        */
/*      text mode                                                                                   */
/*      pattern origin                                                                              */
/*                                                                                                  */
/* Get/SetThemeDrawingState may save and restore additional port state in the future, but you can   */
/* rely on them to always save at least this port state.                                            */
/*
 *  NormalizeThemeDrawingState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
NormalizeThemeDrawingState(void);


/*
 *  GetThemeDrawingState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeDrawingState(ThemeDrawingState * outState);


/*
 *  SetThemeDrawingState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetThemeDrawingState(
  ThemeDrawingState   inState,
  Boolean             inDisposeNow);


/*
 *  DisposeThemeDrawingState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DisposeThemeDrawingState(ThemeDrawingState inState);


/*————————————————————————————————————— MISCELLANEOUS ——————————————————————————————————————————————*/
/* ApplyThemeBackground is used to set up the background for embedded controls  */
/* It is normally called by controls that are embedders. The standard controls  */
/* call this API to ensure a correct background for the current theme. You pass */
/* in the same rectangle you would if you were calling the drawing primitive.   */
/*
 *  ApplyThemeBackground()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
ApplyThemeBackground(
  ThemeBackgroundKind   inKind,
  const Rect *          bounds,
  ThemeDrawState        inState,
  SInt16                inDepth,
  Boolean               inColorDev);


/*
 *  SetThemeTextColorForWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetThemeTextColorForWindow(
  WindowRef   window,
  Boolean     isActive,
  SInt16      depth,
  Boolean     isColorDev);


/*
 *  IsValidAppearanceFileType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
IsValidAppearanceFileType(OSType fileType);


/*
 *  GetThemeBrushAsColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeBrushAsColor(
  ThemeBrush   inBrush,
  SInt16       inDepth,
  Boolean      inColorDev,
  RGBColor *   outColor);


/*
 *  GetThemeTextColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeTextColor(
  ThemeTextColor   inColor,
  SInt16           inDepth,
  Boolean          inColorDev,
  RGBColor *       outColor);


/*——————————————————————————————————————— BEGIN CARBON —————————————————————————————————————————————*/
/*
 *  GetThemeMetric()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetThemeMetric(
  ThemeMetric   inMetric,
  SInt32 *      outMetric);


/*
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
 */
EXTERN_API( OSStatus )
GetTextAndEncodingFromCFString(
  CFStringRef     inString,
  BytePtr         outText,
  ByteCount       inTextMaxLength,
  ByteCount *     outTextLength,
  TextEncoding *  outEncoding);          /* can be NULL */



/*——————————————————————————————————————————————————————————————————————————————————————————————————*/
/* Obsolete symbolic names                                                                          */
/*——————————————————————————————————————————————————————————————————————————————————————————————————*/
/* Obsolete error codes - use the new ones, s'il vous plait / kudasai */
enum {
  appearanceBadBrushIndexErr    = themeInvalidBrushErr, /* pattern index invalid */
  appearanceProcessRegisteredErr = themeProcessRegisteredErr,
  appearanceProcessNotRegisteredErr = themeProcessNotRegisteredErr,
  appearanceBadTextColorIndexErr = themeBadTextColorErr,
  appearanceThemeHasNoAccents   = themeHasNoAccentsErr,
  appearanceBadCursorIndexErr   = themeBadCursorIndexErr
};

enum {
  kThemeActiveDialogBackgroundBrush = kThemeBrushDialogBackgroundActive,
  kThemeInactiveDialogBackgroundBrush = kThemeBrushDialogBackgroundInactive,
  kThemeActiveAlertBackgroundBrush = kThemeBrushAlertBackgroundActive,
  kThemeInactiveAlertBackgroundBrush = kThemeBrushAlertBackgroundInactive,
  kThemeActiveModelessDialogBackgroundBrush = kThemeBrushModelessDialogBackgroundActive,
  kThemeInactiveModelessDialogBackgroundBrush = kThemeBrushModelessDialogBackgroundInactive,
  kThemeActiveUtilityWindowBackgroundBrush = kThemeBrushUtilityWindowBackgroundActive,
  kThemeInactiveUtilityWindowBackgroundBrush = kThemeBrushUtilityWindowBackgroundInactive,
  kThemeListViewSortColumnBackgroundBrush = kThemeBrushListViewSortColumnBackground,
  kThemeListViewBackgroundBrush = kThemeBrushListViewBackground,
  kThemeIconLabelBackgroundBrush = kThemeBrushIconLabelBackground,
  kThemeListViewSeparatorBrush  = kThemeBrushListViewSeparator,
  kThemeChasingArrowsBrush      = kThemeBrushChasingArrows,
  kThemeDragHiliteBrush         = kThemeBrushDragHilite,
  kThemeDocumentWindowBackgroundBrush = kThemeBrushDocumentWindowBackground,
  kThemeFinderWindowBackgroundBrush = kThemeBrushFinderWindowBackground
};

enum {
  kThemeActiveScrollBarDelimiterBrush = kThemeBrushScrollBarDelimiterActive,
  kThemeInactiveScrollBarDelimiterBrush = kThemeBrushScrollBarDelimiterInactive,
  kThemeFocusHighlightBrush     = kThemeBrushFocusHighlight,
  kThemeActivePopupArrowBrush   = kThemeBrushPopupArrowActive,
  kThemePressedPopupArrowBrush  = kThemeBrushPopupArrowPressed,
  kThemeInactivePopupArrowBrush = kThemeBrushPopupArrowInactive,
  kThemeAppleGuideCoachmarkBrush = kThemeBrushAppleGuideCoachmark
};

enum {
  kThemeActiveDialogTextColor   = kThemeTextColorDialogActive,
  kThemeInactiveDialogTextColor = kThemeTextColorDialogInactive,
  kThemeActiveAlertTextColor    = kThemeTextColorAlertActive,
  kThemeInactiveAlertTextColor  = kThemeTextColorAlertInactive,
  kThemeActiveModelessDialogTextColor = kThemeTextColorModelessDialogActive,
  kThemeInactiveModelessDialogTextColor = kThemeTextColorModelessDialogInactive,
  kThemeActiveWindowHeaderTextColor = kThemeTextColorWindowHeaderActive,
  kThemeInactiveWindowHeaderTextColor = kThemeTextColorWindowHeaderInactive,
  kThemeActivePlacardTextColor  = kThemeTextColorPlacardActive,
  kThemeInactivePlacardTextColor = kThemeTextColorPlacardInactive,
  kThemePressedPlacardTextColor = kThemeTextColorPlacardPressed,
  kThemeActivePushButtonTextColor = kThemeTextColorPushButtonActive,
  kThemeInactivePushButtonTextColor = kThemeTextColorPushButtonInactive,
  kThemePressedPushButtonTextColor = kThemeTextColorPushButtonPressed,
  kThemeActiveBevelButtonTextColor = kThemeTextColorBevelButtonActive,
  kThemeInactiveBevelButtonTextColor = kThemeTextColorBevelButtonInactive,
  kThemePressedBevelButtonTextColor = kThemeTextColorBevelButtonPressed,
  kThemeActivePopupButtonTextColor = kThemeTextColorPopupButtonActive,
  kThemeInactivePopupButtonTextColor = kThemeTextColorPopupButtonInactive,
  kThemePressedPopupButtonTextColor = kThemeTextColorPopupButtonPressed,
  kThemeIconLabelTextColor      = kThemeTextColorIconLabel,
  kThemeListViewTextColor       = kThemeTextColorListView
};

enum {
  kThemeActiveDocumentWindowTitleTextColor = kThemeTextColorDocumentWindowTitleActive,
  kThemeInactiveDocumentWindowTitleTextColor = kThemeTextColorDocumentWindowTitleInactive,
  kThemeActiveMovableModalWindowTitleTextColor = kThemeTextColorMovableModalWindowTitleActive,
  kThemeInactiveMovableModalWindowTitleTextColor = kThemeTextColorMovableModalWindowTitleInactive,
  kThemeActiveUtilityWindowTitleTextColor = kThemeTextColorUtilityWindowTitleActive,
  kThemeInactiveUtilityWindowTitleTextColor = kThemeTextColorUtilityWindowTitleInactive,
  kThemeActivePopupWindowTitleColor = kThemeTextColorPopupWindowTitleActive,
  kThemeInactivePopupWindowTitleColor = kThemeTextColorPopupWindowTitleInactive,
  kThemeActiveRootMenuTextColor = kThemeTextColorRootMenuActive,
  kThemeSelectedRootMenuTextColor = kThemeTextColorRootMenuSelected,
  kThemeDisabledRootMenuTextColor = kThemeTextColorRootMenuDisabled,
  kThemeActiveMenuItemTextColor = kThemeTextColorMenuItemActive,
  kThemeSelectedMenuItemTextColor = kThemeTextColorMenuItemSelected,
  kThemeDisabledMenuItemTextColor = kThemeTextColorMenuItemDisabled,
  kThemeActivePopupLabelTextColor = kThemeTextColorPopupLabelActive,
  kThemeInactivePopupLabelTextColor = kThemeTextColorPopupLabelInactive
};

enum {
  kAEThemeSwitch                = kAEAppearanceChanged /* Event ID's: Theme Switched */
};

enum {
  kThemeNoAdornment             = kThemeAdornmentNone,
  kThemeDefaultAdornment        = kThemeAdornmentDefault,
  kThemeFocusAdornment          = kThemeAdornmentFocus,
  kThemeRightToLeftAdornment    = kThemeAdornmentRightToLeft,
  kThemeDrawIndicatorOnly       = kThemeAdornmentDrawIndicatorOnly
};

enum {
  kThemeBrushPassiveAreaFill    = kThemeBrushStaticAreaFill
};

enum {
  kThemeMetricCheckBoxGlyphHeight = kThemeMetricCheckBoxHeight,
  kThemeMetricRadioButtonGlyphHeight = kThemeMetricRadioButtonHeight,
  kThemeMetricDisclosureButtonSize = kThemeMetricDisclosureButtonHeight,
  kThemeMetricBestListHeaderHeight = kThemeMetricListHeaderHeight,
  kThemeMetricSmallProgressBarThickness = kThemeMetricNormalProgressBarThickness, /* obsolete */
  kThemeMetricProgressBarThickness = kThemeMetricLargeProgressBarThickness /* obsolete */
};

enum {
  kThemeScrollBar               = kThemeMediumScrollBar,
  kThemeSlider                  = kThemeMediumSlider,
  kThemeProgressBar             = kThemeMediumProgressBar,
  kThemeIndeterminateBar        = kThemeMediumIndeterminateBar
};


#if PRAGMA_STRUCT_ALIGN
    #pragma options align=reset
#elif PRAGMA_STRUCT_PACKPUSH
    #pragma pack(pop)
#elif PRAGMA_STRUCT_PACK
    #pragma pack()
#endif

#ifdef PRAGMA_IMPORT_OFF
#pragma import off
#elif PRAGMA_IMPORT
#pragma import reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __APPEARANCE__ */


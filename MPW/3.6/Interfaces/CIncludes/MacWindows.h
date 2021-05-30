/*
     File:       MacWindows.h
 
     Contains:   Window Manager Interfaces
 
     Version:    Technology: Mac OS X/CarbonLib 1.3
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1997-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
*/
#ifndef __MACWINDOWS__
#define __MACWINDOWS__

#ifndef __MACTYPES__
#include <MacTypes.h>
#endif

#ifndef __ALIASES__
#include <Aliases.h>
#endif

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif

#ifndef __COLLECTIONS__
#include <Collections.h>
#endif

#ifndef __DRAG__
#include <Drag.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __MENUS__
#include <Menus.h>
#endif

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif

#ifndef __QDOFFSCREEN__
#include <QDOffscreen.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifndef __TEXTCOMMON__
#include <TextCommon.h>
#endif

#ifndef __ICONS__
#include <Icons.h>
#endif

#ifndef __MACERRORS__
#include <MacErrors.h>
#endif

#ifndef __CFSTRING__
#include <CFString.h>
#endif



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

/*                                                                                                      */
/* Current documentation for the Mac OS Window Manager is available on the web:                         */
/*  <http://developer.apple.com/techpubs/macos8/HumanInterfaceToolbox/WindowManager/windowmanager.html> */
/*                                                                                                      */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Property Types                                                                     */
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef OSType                          PropertyCreator;
typedef OSType                          PropertyTag;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Classes                                                                     */
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef UInt32 WindowClass;
enum {
  kAlertWindowClass             = 1L,   /* “I need your attention now.”*/
  kMovableAlertWindowClass      = 2L,   /* “I need your attention now, but I’m kind enough to let you switch out of this app to do other things.”*/
  kModalWindowClass             = 3L,   /* system modal, not draggable*/
  kMovableModalWindowClass      = 4L,   /* application modal, draggable*/
  kFloatingWindowClass          = 5L,   /* floats above all other application windows*/
  kDocumentWindowClass          = 6L,   /* document windows*/
  kUtilityWindowClass           = 8L,   /* system-wide floating windows (TSM, AppleGuide) (available in CarbonLib 1.1)*/
  kHelpWindowClass              = 10L,  /* help window (no frame; coachmarks, help tags ) (available in CarbonLib 1.1)*/
  kSheetWindowClass             = 11L,  /* sheet windows for dialogs (available in Mac OS X and CarbonLib 1.3)*/
  kToolbarWindowClass           = 12L,  /* toolbar windows (above documents, below floating windows) (available in CarbonLib 1.1)*/
  kPlainWindowClass             = 13L,  /* plain window (in document layer)*/
  kOverlayWindowClass           = 14L,  /* transparent window which allows 'screen' drawing via CoreGraphics (Mac OS X only)*/
  kSheetAlertWindowClass        = 15L,  /* sheet windows for alerts (available in Mac OS X after 1.0 and CarbonLib 1.3)*/
  kAltPlainWindowClass          = 16L,  /* alternate plain window (in document layer) (available in Mac OS X after 1.0 and CarbonLib 1.3)*/
  kAllWindowClasses             = (unsigned long)0xFFFFFFFF /* for use with GetFrontWindowOfClass, FindWindowOfClass, GetNextWindowOfClass*/
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Attributes                                                                  */
/*——————————————————————————————————————————————————————————————————————————————————————*/

typedef UInt32                          WindowAttributes;
enum {
  kWindowNoAttributes           = 0L,   /* no attributes */
  kWindowCloseBoxAttribute      = (1L << 0), /* window has a close box */
  kWindowHorizontalZoomAttribute = (1L << 1), /* window has horizontal zoom box */
  kWindowVerticalZoomAttribute  = (1L << 2), /* window has vertical zoom box */
  kWindowFullZoomAttribute      = (kWindowVerticalZoomAttribute | kWindowHorizontalZoomAttribute),
  kWindowCollapseBoxAttribute   = (1L << 3), /* window has a collapse box */
  kWindowResizableAttribute     = (1L << 4), /* window is resizable */
  kWindowSideTitlebarAttribute  = (1L << 5), /* window wants a titlebar on the side    (floating window class only) */
  kWindowNoUpdatesAttribute     = (1L << 16), /* this window receives no update events */
  kWindowNoActivatesAttribute   = (1L << 17), /* this window receives no activate events */
  kWindowOpaqueForEventsAttribute = (1L << 18), /* valid only for kOverlayWindowClass. Means even transparent areas get clicks.*/
  kWindowNoShadowAttribute      = (1L << 21), /* this window should have no shadow (X only)*/
  kWindowHideOnSuspendAttribute = (1L << 24), /* this window is automatically hidden on suspend and shown on resume (Carbon only) */
                                        /* floating windows get kWindowHideOnSuspendAttribute automatically*/
  kWindowStandardHandlerAttribute = (1L << 25), /* this window should have the standard toolbox window event handler installed (Carbon only) */
  kWindowHideOnFullScreenAttribute = (1L << 26), /* this window is automatically hidden during fullscreen mode and shown afterwards (Carbon only) */
                                        /* utility windows get kWindowHideOnFullScreenAttribute automatically*/
  kWindowInWindowMenuAttribute  = (1L << 27), /* this window is automatically tracked in the window menu (Carbon only)*/
  kWindowLiveResizeAttribute    = (1L << 28), /* this window supports live resizing (X only)*/
  kWindowStandardDocumentAttributes = (kWindowCloseBoxAttribute | kWindowFullZoomAttribute | kWindowCollapseBoxAttribute | kWindowResizableAttribute),
  kWindowStandardFloatingAttributes = (kWindowCloseBoxAttribute | kWindowCollapseBoxAttribute)
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Definition Type                                                             */
/*——————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kWindowDefProcType            = FOUR_CHAR_CODE('WDEF')
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Mac OS 7.5 Window Definition Resource IDs                                          */
/*——————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kStandardWindowDefinition     = 0,    /* for document windows and dialogs*/
  kRoundWindowDefinition        = 1,    /* old da-style window*/
  kFloatingWindowDefinition     = 124   /* for floating windows*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Variant Codes                                                                      */
/*——————————————————————————————————————————————————————————————————————————————————————*/
enum {
                                        /* for use with kStandardWindowDefinition */
  kDocumentWindowVariantCode    = 0,
  kModalDialogVariantCode       = 1,
  kPlainDialogVariantCode       = 2,
  kShadowDialogVariantCode      = 3,
  kMovableModalDialogVariantCode = 5,
  kAlertVariantCode             = 7,
  kMovableAlertVariantCode      = 9,    /* for use with kFloatingWindowDefinition */
  kSideFloaterVariantCode       = 8
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • DefProc IDs                                                                        */
/*——————————————————————————————————————————————————————————————————————————————————————*/
enum {
                                        /* classic ids */
  documentProc                  = 0,
  dBoxProc                      = 1,
  plainDBox                     = 2,
  altDBoxProc                   = 3,
  noGrowDocProc                 = 4,
  movableDBoxProc               = 5,
  zoomDocProc                   = 8,
  zoomNoGrow                    = 12,   /* floating window defproc ids */
  floatProc                     = 1985,
  floatGrowProc                 = 1987,
  floatZoomProc                 = 1989,
  floatZoomGrowProc             = 1991,
  floatSideProc                 = 1993,
  floatSideGrowProc             = 1995,
  floatSideZoomProc             = 1997,
  floatSideZoomGrowProc         = 1999
};

#if CALL_NOT_IN_CARBON
/* The rDocProc (rounded WDEF, ala calculator) is not supported in Carbon.*/
enum {
  rDocProc                      = 16
};

#endif  /* CALL_NOT_IN_CARBON */

enum {
                                        /* Resource IDs for theme-savvy window defprocs */
  kWindowDocumentDefProcResID   = 64,
  kWindowDialogDefProcResID     = 65,
  kWindowUtilityDefProcResID    = 66,
  kWindowUtilitySideTitleDefProcResID = 67,
  kWindowSheetDefProcResID      = 68,
  kWindowSimpleDefProcResID     = 69,
  kWindowSheetAlertDefProcResID = 70
};

enum {
                                        /* Proc IDs for theme-savvy windows */
  kWindowDocumentProc           = 1024,
  kWindowGrowDocumentProc       = 1025,
  kWindowVertZoomDocumentProc   = 1026,
  kWindowVertZoomGrowDocumentProc = 1027,
  kWindowHorizZoomDocumentProc  = 1028,
  kWindowHorizZoomGrowDocumentProc = 1029,
  kWindowFullZoomDocumentProc   = 1030,
  kWindowFullZoomGrowDocumentProc = 1031
};


enum {
                                        /* Proc IDs for theme-savvy dialogs */
  kWindowPlainDialogProc        = 1040,
  kWindowShadowDialogProc       = 1041,
  kWindowModalDialogProc        = 1042,
  kWindowMovableModalDialogProc = 1043,
  kWindowAlertProc              = 1044,
  kWindowMovableAlertProc       = 1045
};


enum {
                                        /* procIDs available from Mac OS 8.1 (Appearance 1.0.1) forward */
  kWindowMovableModalGrowProc   = 1046
};


enum {
                                        /* Proc IDs for top title bar theme-savvy floating windows */
  kWindowFloatProc              = 1057,
  kWindowFloatGrowProc          = 1059,
  kWindowFloatVertZoomProc      = 1061,
  kWindowFloatVertZoomGrowProc  = 1063,
  kWindowFloatHorizZoomProc     = 1065,
  kWindowFloatHorizZoomGrowProc = 1067,
  kWindowFloatFullZoomProc      = 1069,
  kWindowFloatFullZoomGrowProc  = 1071
};


enum {
                                        /* Proc IDs for side title bar theme-savvy floating windows */
  kWindowFloatSideProc          = 1073,
  kWindowFloatSideGrowProc      = 1075,
  kWindowFloatSideVertZoomProc  = 1077,
  kWindowFloatSideVertZoomGrowProc = 1079,
  kWindowFloatSideHorizZoomProc = 1081,
  kWindowFloatSideHorizZoomGrowProc = 1083,
  kWindowFloatSideFullZoomProc  = 1085,
  kWindowFloatSideFullZoomGrowProc = 1087
};


enum {
                                        /* Proc IDs for sheet windows */
  kWindowSheetProc              = 1088, /* available in Mac OS X and CarbonLib 1.3 */
  kWindowSheetAlertProc         = 1120  /* available in Mac OS X after 1.0, and CarbonLib 1.3 */
};



/*
 *  Discussion:
 *    Window defproc IDs for simple windows
 */
enum {
                                        /* Proc IDs for simple windows */

  /*
   * A window that has no structure region; the content covers the
   * entire window.
   */
  kWindowSimpleProc             = 1104,

  /*
   * A window that has a 1-pixel black frame as its structure.
   */
  kWindowSimpleFrameProc        = 1105
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • System 7 Window Positioning Constants                                              */
/*                                                                                      */
/* Passed into StandardAlert and used in ‘WIND’, ‘DLOG’, and ‘ALRT’ templates           */
/* StandardAlert uses zero to specify the default position. Other calls use zero to     */
/* specify “no position”.  Do not pass these constants to RepositionWindow.  Do not     */
/* store these constants in the BasicWindowDescription of a ‘wind’ resource.            */
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
  kWindowNoPosition             = 0x0000,
  kWindowDefaultPosition        = 0x0000, /* used by StandardAlert*/
  kWindowCenterMainScreen       = 0x280A,
  kWindowAlertPositionMainScreen = 0x300A,
  kWindowStaggerMainScreen      = 0x380A,
  kWindowCenterParentWindow     = 0xA80A,
  kWindowAlertPositionParentWindow = 0xB00A,
  kWindowStaggerParentWindow    = 0xB80A,
  kWindowCenterParentWindowScreen = 0x680A,
  kWindowAlertPositionParentWindowScreen = 0x700A,
  kWindowStaggerParentWindowScreen = 0x780A
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Positioning Methods                                                         */
/*                                                                                      */
/* Positioning methods passed to RepositionWindow.                                      */
/* Do not use them in WIND, ALRT, DLOG templates.                                       */
/* Do not confuse these constants with the constants above                              */
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef UInt32 WindowPositionMethod;
enum {
  kWindowCenterOnMainScreen     = 0x00000001,
  kWindowCenterOnParentWindow   = 0x00000002,
  kWindowCenterOnParentWindowScreen = 0x00000003,
  kWindowCascadeOnMainScreen    = 0x00000004,
  kWindowCascadeOnParentWindow  = 0x00000005,
  kWindowCascadeOnParentWindowScreen = 0x00000006,
  kWindowAlertPositionOnMainScreen = 0x00000007,
  kWindowAlertPositionOnParentWindow = 0x00000008,
  kWindowAlertPositionOnParentWindowScreen = 0x00000009
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • GetWindowRegion Types                                                              */
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef UInt16                          WindowRegionCode;
enum {
                                        /* Region values to pass into GetWindowRegion & GetWindowBounds */
  kWindowTitleBarRgn            = 0,
  kWindowTitleTextRgn           = 1,
  kWindowCloseBoxRgn            = 2,
  kWindowZoomBoxRgn             = 3,
  kWindowDragRgn                = 5,
  kWindowGrowRgn                = 6,
  kWindowCollapseBoxRgn         = 7,
  kWindowTitleProxyIconRgn      = 8,    /* Mac OS 8.5 forward*/
  kWindowStructureRgn           = 32,
  kWindowContentRgn             = 33,   /* Content area of the window; empty when the window is collapsed*/
  kWindowUpdateRgn              = 34,   /* Carbon forward*/
  kWindowOpaqueRgn              = 35,   /* Mac OS X: Area of window considered to be opaque. Only valid for windows with alpha channels.*/
  kWindowGlobalPortRgn          = 40    /* Carbon forward - bounds of the window’s port in global coordinates; not affected by CollapseWindow*/
};

/* GetWindowRegionRec - a pointer to this is passed in WDEF param for kWindowMsgGetRegion*/
struct GetWindowRegionRec {
  RgnHandle           winRgn;
  WindowRegionCode    regionCode;
};
typedef struct GetWindowRegionRec       GetWindowRegionRec;
typedef GetWindowRegionRec *            GetWindowRegionPtr;
typedef GetWindowRegionRec *            GetWindowRegionRecPtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • WDEF Message Types                                                                 */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
   SetupWindowProxyDragImageRec - setup the proxy icon drag image
   Both regions are allocated and disposed by the Window Manager.
   The GWorld is disposed of by the Window Manager, but the WDEF must allocate
   it.  See Technote on Drag Manager 1.1 additions for more information and sample code for
   setting up drag images.
*/

struct SetupWindowProxyDragImageRec {
  GWorldPtr           imageGWorld;            /* locked GWorld containing the drag image - output - can be NULL*/
  RgnHandle           imageRgn;               /* image clip region, contains the portion of the image which gets blitted to screen - preallocated output - if imageGWorld is NULL, this is ignored*/
  RgnHandle           outlineRgn;             /* the outline region used on shallow monitors - preallocated output - must always be non-empty*/
};
typedef struct SetupWindowProxyDragImageRec SetupWindowProxyDragImageRec;
/* MeasureWindowTitleRec - a pointer to this is passed in WDEF param for kWindowMsgMeasureTitle*/
struct MeasureWindowTitleRec {
                                              /* output parameters (filled in by the WDEF)*/
  SInt16              fullTitleWidth;         /* text + proxy icon width*/
  SInt16              titleTextWidth;         /* text width*/
};
typedef struct MeasureWindowTitleRec    MeasureWindowTitleRec;
typedef MeasureWindowTitleRec *         MeasureWindowTitleRecPtr;
/*
   GetGrowImageRegionRec - generate a region to be xored during GrowWindow and ResizeWindow.
   This is passed along with a kWindowMsgGetGrowImageRegion message. On input, the growRect
   parameter is the window's new bounds in global coordinates. The growImageRegion parameter
   will be allocated and disposed automatically; the window definition should alter the 
   region appropriately.
*/
struct GetGrowImageRegionRec {
  Rect                growRect;
  RgnHandle           growImageRegion;
};
typedef struct GetGrowImageRegionRec    GetGrowImageRegionRec;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Standard Window Kinds                                                              */
/*——————————————————————————————————————————————————————————————————————————————————————*/
enum {
  dialogKind                    = 2,
  userKind                      = 8,
  kDialogWindowKind             = 2,
  kApplicationWindowKind        = 8
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • FindWindow Result Codes                                                            */
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef SInt16 WindowPartCode;
enum {
  inDesk                        = 0,
  inNoWindow                    = 0,
  inMenuBar                     = 1,
  inSysWindow                   = 2,
  inContent                     = 3,
  inDrag                        = 4,
  inGrow                        = 5,
  inGoAway                      = 6,
  inZoomIn                      = 7,
  inZoomOut                     = 8,
  inCollapseBox                 = 11,   /* Mac OS 8.0 forward*/
  inProxyIcon                   = 12    /* Mac OS 8.5 forward*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Definition Hit Test Result Codes                                            */
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef SInt16 WindowDefPartCode;
enum {
  wNoHit                        = 0,
  wInContent                    = 1,
  wInDrag                       = 2,
  wInGrow                       = 3,
  wInGoAway                     = 4,
  wInZoomIn                     = 5,
  wInZoomOut                    = 6,
  wInCollapseBox                = 9,    /* Mac OS 8.0 forward*/
  wInProxyIcon                  = 10    /* Mac OS 8.5 forward*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Definition Messages                                                         */
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
  kWindowMsgDraw                = 0,
  kWindowMsgHitTest             = 1,
  kWindowMsgCalculateShape      = 2,
  kWindowMsgInitialize          = 3,
  kWindowMsgCleanUp             = 4,
  kWindowMsgDrawGrowOutline     = 5,
  kWindowMsgDrawGrowBox         = 6
};

/* Messages available from Mac OS 8.0 forward*/
enum {
  kWindowMsgGetFeatures         = 7,
  kWindowMsgGetRegion           = 8
};

/* Messages available from Mac OS 8.5 forward*/
enum {
  kWindowMsgDragHilite          = 9,    /* parameter boolean indicating on or off*/
  kWindowMsgModified            = 10,   /* parameter boolean indicating saved (false) or modified (true)*/
  kWindowMsgDrawInCurrentPort   = 11,   /* same as kWindowMsgDraw, but must draw in current port*/
  kWindowMsgSetupProxyDragImage = 12,   /* parameter pointer to SetupWindowProxyDragImageRec*/
  kWindowMsgStateChanged        = 13,   /* something about the window's state has changed*/
  kWindowMsgMeasureTitle        = 14    /* measure and return the ideal title width*/
};

/* Messages only available in Carbon*/
enum {
  kWindowMsgGetGrowImageRegion  = 19    /* get region to xor during grow/resize. parameter pointer to GetGrowImageRegionRec.*/
};

/* old names*/
enum {
  wDraw                         = 0,
  wHit                          = 1,
  wCalcRgns                     = 2,
  wNew                          = 3,
  wDispose                      = 4,
  wGrow                         = 5,
  wDrawGIcon                    = 6
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • State-changed Flags for kWindowMsgStateChanged                                     */
/*——————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kWindowStateTitleChanged      = (1 << 0)
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Feature Bits                                                                */
/*——————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kWindowCanGrow                = (1 << 0),
  kWindowCanZoom                = (1 << 1),
  kWindowCanCollapse            = (1 << 2),
  kWindowIsModal                = (1 << 3),
  kWindowCanGetWindowRegion     = (1 << 4),
  kWindowIsAlert                = (1 << 5),
  kWindowHasTitleBar            = (1 << 6)
};

/* Feature bits available from Mac OS 8.5 forward*/
enum {
  kWindowSupportsDragHilite     = (1 << 7), /* window definition supports kWindowMsgDragHilite*/
  kWindowSupportsModifiedBit    = (1 << 8), /* window definition supports kWindowMsgModified*/
  kWindowCanDrawInCurrentPort   = (1 << 9), /* window definition supports kWindowMsgDrawInCurrentPort*/
  kWindowCanSetupProxyDragImage = (1 << 10), /* window definition supports kWindowMsgSetupProxyDragImage*/
  kWindowCanMeasureTitle        = (1 << 11), /* window definition supports kWindowMsgMeasureTitle*/
  kWindowWantsDisposeAtProcessDeath = (1 << 12), /* window definition wants a Dispose message for windows still extant during ExitToShell*/
  kWindowSupportsGetGrowImageRegion = (1 << 13), /* window definition will calculate the grow image region manually.*/
  kWindowDefSupportsColorGrafPort = 0x40000002
};

/* Feature bits for post MacOS 10.0*/
enum {
  kWindowIsOpaque               = (1 << 14) /* Window doesn't need an alpha channel. Saves memory.*/
};

/*
   THIS CONSTANT IS GOING AWAY. IT IS NAMED INCORRECTLY. USE THE GETGROWIMAGE CONSTANT ABOVE INSTEAD.
   DO YOU HEAR ME! AM I YELLING LOUD ENOUGH?!
*/
enum {
  kWindowSupportsSetGrowImageRegion = (1 << 13)
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Desktop Pattern Resource ID                                                        */
/*——————————————————————————————————————————————————————————————————————————————————————*/
enum {
  deskPatID                     = 16
};



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Color Part Codes                                                            */
/*——————————————————————————————————————————————————————————————————————————————————————*/
enum {
  wContentColor                 = 0,
  wFrameColor                   = 1,
  wTextColor                    = 2,
  wHiliteColor                  = 3,
  wTitleBarColor                = 4
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/*  • Region Dragging Constants                                                         */
/*——————————————————————————————————————————————————————————————————————————————————————*/

enum {
  kMouseUpOutOfSlop             = (long)0x80008000
};


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Color Table                                                                 */
/*——————————————————————————————————————————————————————————————————————————————————————*/
struct WinCTab {
  long                wCSeed;                 /* reserved */
  short               wCReserved;             /* reserved */
  short               ctSize;                 /* usually 4 for windows */
  ColorSpec           ctTable[5];
};
typedef struct WinCTab                  WinCTab;
typedef WinCTab *                       WCTabPtr;
typedef WCTabPtr *                      WCTabHandle;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • WindowRecord                                                                       */
/*——————————————————————————————————————————————————————————————————————————————————————*/
#if !OPAQUE_TOOLBOX_STRUCTS
typedef struct WindowRecord             WindowRecord;
typedef WindowRecord *                  WindowPeek;
struct WindowRecord {
  GrafPort            port;                   /* in Carbon use GetWindowPort*/
  short               windowKind;             /* in Carbon use Get/SetWindowKind*/
  Boolean             visible;                /* in Carbon use Hide/ShowWindow, ShowHide, IsWindowVisible*/
  Boolean             hilited;                /* in Carbon use HiliteWindow, IsWindowHilited*/
  Boolean             goAwayFlag;             /* in Carbon use ChangeWindowAttributes*/
  Boolean             spareFlag;              /* in Carbon use ChangeWindowAttributes*/
  RgnHandle           strucRgn;               /* in Carbon use GetWindowRegion*/
  RgnHandle           contRgn;                /* in Carbon use GetWindowRegion*/
  RgnHandle           updateRgn;              /* in Carbon use GetWindowRegion*/
  Handle              windowDefProc;          /* not supported in Carbon */
  Handle              dataHandle;             /* not supported in Carbon */
  StringHandle        titleHandle;            /* in Carbon use Get/SetWTitle */
  short               titleWidth;             /* in Carbon use GetWindowRegion */
  Handle              controlList;            /* in Carbon use GetRootControl */
  WindowPeek          nextWindow;             /* in Carbon use GetNextWindow */
  PicHandle           windowPic;              /* in Carbon use Get/SetWindowPic */
  long                refCon;                 /* in Carbon use Get/SetWRefCon*/
};

#endif  /* !OPAQUE_TOOLBOX_STRUCTS */

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Color WindowRecord                                                                 */
/*——————————————————————————————————————————————————————————————————————————————————————*/
#if !OPAQUE_TOOLBOX_STRUCTS
typedef struct CWindowRecord            CWindowRecord;
typedef CWindowRecord *                 CWindowPeek;
struct CWindowRecord {
  CGrafPort           port;                   /* in Carbon use GetWindowPort*/
  short               windowKind;             /* in Carbon use Get/SetWindowKind    */
  Boolean             visible;                /* in Carbon use Hide/ShowWindow, ShowHide, IsWindowVisible     */
  Boolean             hilited;                /* in Carbon use HiliteWindow, IsWindowHilited*/
  Boolean             goAwayFlag;             /* in Carbon use ChangeWindowAttributes   */
  Boolean             spareFlag;              /* in Carbon use ChangeWindowAttributes   */
  RgnHandle           strucRgn;               /* in Carbon use GetWindowRegion  */
  RgnHandle           contRgn;                /* in Carbon use GetWindowRegion  */
  RgnHandle           updateRgn;              /* in Carbon use GetWindowRegion  */
  Handle              windowDefProc;          /* not supported in Carbon */
  Handle              dataHandle;             /* not supported in Carbon */
  StringHandle        titleHandle;            /* in Carbon use Get/SetWTitle */
  short               titleWidth;             /* in Carbon use GetWindowRegion */
  Handle              controlList;            /* in Carbon use GetRootControl */
  CWindowPeek         nextWindow;             /* in Carbon use GetNextWindow */
  PicHandle           windowPic;              /* in Carbon use Get/SetWindowPic     */
  long                refCon;                 /* in Carbon use Get/SetWRefCon      */
};

#endif  /* !OPAQUE_TOOLBOX_STRUCTS */

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • AuxWinHandle                                                                       */
/*——————————————————————————————————————————————————————————————————————————————————————*/
#if !OPAQUE_TOOLBOX_STRUCTS
typedef struct AuxWinRec                AuxWinRec;
typedef AuxWinRec *                     AuxWinPtr;
typedef AuxWinPtr *                     AuxWinHandle;
struct AuxWinRec {
  AuxWinHandle        awNext;                 /* handle to next AuxWinRec, not supported in Carbon*/
  WindowRef           awOwner;                /* not supported in Carbon*/
  CTabHandle          awCTable;               /* color table for this window, use  Get/SetWindowContentColor in Carbon*/
  Handle              reserved;               /* not supported in Carbon*/
  long                awFlags;                /* reserved for expansion, not supported in Carbon*/
  CTabHandle          awReserved;             /* reserved for expansion, not supported in Carbon*/
  long                awRefCon;               /* user constant, in Carbon use Get/SetWindowProperty if you need more refCons*/
};

#endif  /* !OPAQUE_TOOLBOX_STRUCTS */

/*——————————————————————————————————————————————————————————————————————————————————————*/
/*  • BasicWindowDescription                                                            */
/*                                                                                      */
/*  Contains statically-sized basic attributes of the window, for storage in a          */
/*  collection item.                                                                    */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* constants for the version field*/
enum {
  kWindowDefinitionVersionOne   = 1,
  kWindowDefinitionVersionTwo   = 2
};

/* constants for the stateflags bit field */
enum {
  kWindowIsCollapsedState       = (1 << 0L)
};

struct BasicWindowDescription {
  UInt32              descriptionSize;        /* sizeof(BasicWindowDescription)*/

  Rect                windowContentRect;      /* location on screen*/
  Rect                windowZoomRect;         /* location on screen when zoomed out*/
  UInt32              windowRefCon;           /* the refcon - __avoid saving stale pointers here__  */
  UInt32              windowStateFlags;       /* window state bit flags*/
  WindowPositionMethod  windowPositionMethod; /* method last used by RepositionWindow to position the window (if any)*/

  UInt32              windowDefinitionVersion;
  union {
    struct {
      SInt16              windowDefProc;      /* defProc and variant*/
      Boolean             windowHasCloseBox;
    }                       versionOne;

    struct {
      WindowClass         windowClass;        /* the class*/
      WindowAttributes    windowAttributes;   /* the attributes*/
    }                       versionTwo;

  }                       windowDefinition;
};
typedef struct BasicWindowDescription   BasicWindowDescription;
/*  the window manager stores the default collection items using these IDs*/
enum {
  kStoredWindowSystemTag        = FOUR_CHAR_CODE('appl'), /* Only Apple collection items will be of this tag*/
  kStoredBasicWindowDescriptionID = FOUR_CHAR_CODE('sbas'), /* BasicWindowDescription*/
  kStoredWindowPascalTitleID    = FOUR_CHAR_CODE('s255') /* pascal title string*/
};

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Class Ordering                                                              */
/*                                                                                      */
/*  Special cases for the “behind” parameter in window creation calls.                  */
/*——————————————————————————————————————————————————————————————————————————————————————*/
#define kFirstWindowOfClass             ((WindowRef)(-1))
#define kLastWindowOfClass              ((WindowRef)0)

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Zoom Information Handle                                                            */
/*——————————————————————————————————————————————————————————————————————————————————————*/
struct WStateData {
  Rect                userState;              /*user zoom state*/
  Rect                stdState;               /*standard zoom state*/
};
typedef struct WStateData               WStateData;
typedef WStateData *                    WStateDataPtr;
typedef WStateDataPtr *                 WStateDataHandle;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • MixedMode & ProcPtrs                                                               */
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef CALLBACK_API( long , WindowDefProcPtr )(short varCode, WindowRef window, short message, long param);
typedef CALLBACK_API_REGISTER68K( void , DeskHookProcPtr, (Boolean mouseClick, EventRecord *theEvent) );
typedef CALLBACK_API( OSStatus , WindowPaintProcPtr )(GDHandle device, GrafPtr qdContext, WindowRef window, RgnHandle inClientPaintRgn, RgnHandle outSystemPaintRgn, void *refCon);
typedef STACK_UPP_TYPE(WindowDefProcPtr)                        WindowDefUPP;
typedef REGISTER_UPP_TYPE(DeskHookProcPtr)                      DeskHookUPP;
typedef STACK_UPP_TYPE(WindowPaintProcPtr)                      WindowPaintUPP;
/*
 *  NewWindowDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( WindowDefUPP )
NewWindowDefUPP(WindowDefProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppWindowDefProcInfo = 0x00003BB0 };  /* pascal 4_bytes Func(2_bytes, 4_bytes, 2_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline WindowDefUPP NewWindowDefUPP(WindowDefProcPtr userRoutine) { return (WindowDefUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppWindowDefProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewWindowDefUPP(userRoutine) (WindowDefUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppWindowDefProcInfo, GetCurrentArchitecture())
  #endif
#endif

#if CALL_NOT_IN_CARBON
/*
 *  NewDeskHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( DeskHookUPP )
NewDeskHookUPP(DeskHookProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppDeskHookProcInfo = 0x00130802 };  /* register no_return_value Func(1_byte:D0, 4_bytes:A0) */
  #ifdef __cplusplus
    inline DeskHookUPP NewDeskHookUPP(DeskHookProcPtr userRoutine) { return (DeskHookUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDeskHookProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewDeskHookUPP(userRoutine) (DeskHookUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppDeskHookProcInfo, GetCurrentArchitecture())
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

/*
 *  NewWindowPaintUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( WindowPaintUPP )
NewWindowPaintUPP(WindowPaintProcPtr userRoutine);
#if !OPAQUE_UPP_TYPES
  enum { uppWindowPaintProcInfo = 0x0003FFF0 };  /* pascal 4_bytes Func(4_bytes, 4_bytes, 4_bytes, 4_bytes, 4_bytes, 4_bytes) */
  #ifdef __cplusplus
    inline WindowPaintUPP NewWindowPaintUPP(WindowPaintProcPtr userRoutine) { return (WindowPaintUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppWindowPaintProcInfo, GetCurrentArchitecture()); }
  #else
    #define NewWindowPaintUPP(userRoutine) (WindowPaintUPP)NewRoutineDescriptor((ProcPtr)(userRoutine), uppWindowPaintProcInfo, GetCurrentArchitecture())
  #endif
#endif

/*
 *  DisposeWindowDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeWindowDefUPP(WindowDefUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeWindowDefUPP(WindowDefUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeWindowDefUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

#if CALL_NOT_IN_CARBON
/*
 *  DisposeDeskHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
DisposeDeskHookUPP(DeskHookUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeDeskHookUPP(DeskHookUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeDeskHookUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

/*
 *  DisposeWindowPaintUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DisposeWindowPaintUPP(WindowPaintUPP userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline void DisposeWindowPaintUPP(WindowPaintUPP userUPP) { DisposeRoutineDescriptor((UniversalProcPtr)userUPP); }
  #else
    #define DisposeWindowPaintUPP(userUPP) DisposeRoutineDescriptor(userUPP)
  #endif
#endif

/*
 *  InvokeWindowDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( long )
InvokeWindowDefUPP(
  short         varCode,
  WindowRef     window,
  short         message,
  long          param,
  WindowDefUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline long InvokeWindowDefUPP(short varCode, WindowRef window, short message, long param, WindowDefUPP userUPP) { return (long)CALL_FOUR_PARAMETER_UPP(userUPP, uppWindowDefProcInfo, varCode, window, message, param); }
  #else
    #define InvokeWindowDefUPP(varCode, window, message, param, userUPP) (long)CALL_FOUR_PARAMETER_UPP((userUPP), uppWindowDefProcInfo, (varCode), (window), (message), (param))
  #endif
#endif

#if CALL_NOT_IN_CARBON
/*
 *  InvokeDeskHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC && TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#pragma parameter InvokeDeskHookUPP(__D0, __A0, __A1)
#endif
EXTERN_API_C( void )
InvokeDeskHookUPP(
  Boolean        mouseClick,
  EventRecord *  theEvent,
  DeskHookUPP    userUPP)                                     ONEWORDINLINE(0x4E91);
#if !OPAQUE_UPP_TYPES && (!TARGET_OS_MAC || !TARGET_CPU_68K || TARGET_RT_MAC_CFM)
  #ifdef __cplusplus
    inline void InvokeDeskHookUPP(Boolean mouseClick, EventRecord * theEvent, DeskHookUPP userUPP) { CALL_TWO_PARAMETER_UPP(userUPP, uppDeskHookProcInfo, mouseClick, theEvent); }
  #else
    #define InvokeDeskHookUPP(mouseClick, theEvent, userUPP) CALL_TWO_PARAMETER_UPP((userUPP), uppDeskHookProcInfo, (mouseClick), (theEvent))
  #endif
#endif

#endif  /* CALL_NOT_IN_CARBON */

/*
 *  InvokeWindowPaintUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
InvokeWindowPaintUPP(
  GDHandle        device,
  GrafPtr         qdContext,
  WindowRef       window,
  RgnHandle       inClientPaintRgn,
  RgnHandle       outSystemPaintRgn,
  void *          refCon,
  WindowPaintUPP  userUPP);
#if !OPAQUE_UPP_TYPES
  #ifdef __cplusplus
    inline OSStatus InvokeWindowPaintUPP(GDHandle device, GrafPtr qdContext, WindowRef window, RgnHandle inClientPaintRgn, RgnHandle outSystemPaintRgn, void * refCon, WindowPaintUPP userUPP) { return (OSStatus)CALL_SIX_PARAMETER_UPP(userUPP, uppWindowPaintProcInfo, device, qdContext, window, inClientPaintRgn, outSystemPaintRgn, refCon); }
  #else
    #define InvokeWindowPaintUPP(device, qdContext, window, inClientPaintRgn, outSystemPaintRgn, refCon, userUPP) (OSStatus)CALL_SIX_PARAMETER_UPP((userUPP), uppWindowPaintProcInfo, (device), (qdContext), (window), (inClientPaintRgn), (outSystemPaintRgn), (refCon))
  #endif
#endif

#if CALL_NOT_IN_CARBON || OLDROUTINENAMES
    /* support for pre-Carbon UPP routines: New...Proc and Call...Proc */
    #define NewWindowDefProc(userRoutine)                       NewWindowDefUPP(userRoutine)
    #define NewDeskHookProc(userRoutine)                        NewDeskHookUPP(userRoutine)
    #define NewWindowPaintProc(userRoutine)                     NewWindowPaintUPP(userRoutine)
    #define CallWindowDefProc(userRoutine, varCode, window, message, param) InvokeWindowDefUPP(varCode, window, message, param, userRoutine)
    #define CallDeskHookProc(userRoutine, mouseClick, theEvent) InvokeDeskHookUPP(mouseClick, theEvent, userRoutine)
    #define CallWindowPaintProc(userRoutine, device, qdContext, window, inClientPaintRgn, outSystemPaintRgn, refCon) InvokeWindowPaintUPP(device, qdContext, window, inClientPaintRgn, outSystemPaintRgn, refCon, userRoutine)
#endif /* CALL_NOT_IN_CARBON */

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Definition Spec.  Used in Carbon to specify the code that defines a window. */
/*——————————————————————————————————————————————————————————————————————————————————————*/
enum {
  kWindowDefProcPtr             = 0,    /* raw proc-ptr based access*/
  kWindowDefObjectClass         = 1,    /* event-based definition (Carbon 1.1 or later)*/
  kWindowDefProcID              = 2     /* explicit proc ID; overrides the window class default proc ID*/
};

typedef UInt32                          WindowDefType;
struct WindowDefSpec {
  WindowDefType       defType;
  union {
    WindowDefUPP        defProc;
    void *              classRef;
    short               procID;
  }                       u;
};
typedef struct WindowDefSpec            WindowDefSpec;
typedef WindowDefSpec *                 WindowDefSpecPtr;
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Creation & Persistence                                                      */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
 *  GetNewCWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( WindowRef )
GetNewCWindow(
  short       windowID,
  void *      wStorage,
  WindowRef   behind)                                         ONEWORDINLINE(0xAA46);


/*
 *  NewWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( WindowRef )
NewWindow(
  void *             wStorage,
  const Rect *       boundsRect,
  ConstStr255Param   title,
  Boolean            visible,
  short              theProc,
  WindowRef          behind,
  Boolean            goAwayFlag,
  long               refCon)                                  ONEWORDINLINE(0xA913);


/*
 *  GetNewWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( WindowRef )
GetNewWindow(
  short       windowID,
  void *      wStorage,
  WindowRef   behind)                                         ONEWORDINLINE(0xA9BD);


/*
 *  NewCWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( WindowRef )
NewCWindow(
  void *             wStorage,
  const Rect *       boundsRect,
  ConstStr255Param   title,
  Boolean            visible,
  short              procID,
  WindowRef          behind,
  Boolean            goAwayFlag,
  long               refCon)                                  ONEWORDINLINE(0xAA45);


/*
 *  DisposeWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
DisposeWindow(WindowRef window)                               ONEWORDINLINE(0xA914);


#if CALL_NOT_IN_CARBON
/*
 *  [Mac]CloseWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
#if TARGET_OS_MAC
    #define MacCloseWindow CloseWindow
#endif
EXTERN_API( void )
MacCloseWindow(WindowRef window)                              ONEWORDINLINE(0xA92D);



/*
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
*/

#endif  /* CALL_NOT_IN_CARBON */

/*
 *  CreateNewWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
CreateNewWindow(
  WindowClass        windowClass,
  WindowAttributes   attributes,
  const Rect *       contentBounds,
  WindowRef *        outWindow);


/* Routines available from Mac OS 8.5 forward*/

/* Create a window from a ‘wind’ resource*/
/*
 *  CreateWindowFromResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
CreateWindowFromResource(
  SInt16       resID,
  WindowRef *  outWindow);


/* window persistence*/
/*
 *  StoreWindowIntoCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
StoreWindowIntoCollection(
  WindowRef    window,
  Collection   collection);


/*
 *  CreateWindowFromCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
CreateWindowFromCollection(
  Collection   collection,
  WindowRef *  outWindow);


/* window refcounting*/
/*
 *  GetWindowOwnerCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowOwnerCount(
  WindowRef   window,
  UInt32 *    outCount);


/*
 *  CloneWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
CloneWindow(WindowRef window);


/*
 *  GetWindowRetainCount()
 *  
 *  Summary:
 *    Returns the retain count of a window.
 *  
 *  Discussion:
 *    This API is equivalent to GetWindowOwnerCount. For consistency
 *    with CoreFoundation and Carbon Events, it is preferred over
 *    GetWindowOwnerCount. Both APIs will continue to be supported.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window whose retain count to retrieve.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( ItemCount )
GetWindowRetainCount(WindowRef inWindow);


/*
 *  RetainWindow()
 *  
 *  Summary:
 *    Increments the retain count of a window.
 *  
 *  Discussion:
 *    This API is equivalent to CloneWindow. For consistency with
 *    CoreFoundation and Carbon Events, it is preferred over
 *    CloneWindow. Both APIs will continue to be supported.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window whose retain count to increment.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
RetainWindow(WindowRef inWindow);


/*
 *  ReleaseWindow()
 *  
 *  Summary:
 *    Decrements the retain count of a window, and destroys the window
 *    if the retain count falls to zero.
 *  
 *  Discussion:
 *    This API is equivalent to DisposeWindow. For consistency with
 *    CoreFoundation and Carbon Events, it is preferred over
 *    DisposeWindow. Both APIs will continue to be supported.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window whose retain count to decrement.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
ReleaseWindow(WindowRef inWindow);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Custom Windows                                                                     */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward*/

/*
 *  CreateCustomWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
CreateCustomWindow(
  const WindowDefSpec *  def,
  WindowClass            windowClass,
  WindowAttributes       attributes,
  const Rect *           contentBounds,
  WindowRef *            outWindow);


/*
 *  ReshapeCustomWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
ReshapeCustomWindow(WindowRef window);


/*
 *  RegisterWindowDefinition()
 *  
 *  Summary:
 *    Registers or unregisters a binding between a resource ID and a
 *    window definition function.
 *  
 *  Discussion:
 *    In the Mac OS 8.x Window Manager, a 'WIND' resource can contain
 *    an embedded WDEF procID that is used by the Window Manager as the
 *    resource ID of an 'WDEF' resource to lay out and draw the window.
 *    The 'WDEF' resource is loaded by the Window Manager when you load
 *    the menu with GetNewWindow. Since WDEFs can no longer be packaged
 *    as code resources on Carbon, the procID can no longer refer
 *    directly to a WDEF resource. However, using
 *    RegisterWindowDefinition you can instead specify a
 *    UniversalProcPtr pointing to code in your application code
 *    fragment. RegisterWindowDefinition is available when linking to
 *    CarbonLib 1.1 forward.
 *  
 *  Parameters:
 *    
 *    inResID:
 *      A WDEF proc ID, as used in a 'WIND' resource.
 *    
 *    inDefSpec:
 *      Specifies the WindowDefUPP that should be used for windows with
 *      the given WDEF proc ID. Passing NULL allows you to unregister
 *      the window definition that had been associated with the given
 *      WDEF proc ID.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
RegisterWindowDefinition(
  SInt16                 inResID,
  const WindowDefSpec *  inDefSpec);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window part tracking                                                               */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
   Routines available from Mac OS 8.5 forward
        (or from Mac OS 8.6 forward when linking to CarbonLib 1.1 forward)
*/


/*
 *  GetWindowWidgetHilite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowWidgetHilite(
  WindowRef            inWindow,
  WindowDefPartCode *  outHilite);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Metainformation Accessors                                                   */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
*/
/*
 *  GetWindowClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowClass(
  WindowRef      window,
  WindowClass *  outClass);


/*
 *  GetWindowAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowAttributes(
  WindowRef           window,
  WindowAttributes *  outAttributes);


/*
   Routines available from Mac OS 9.0 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
*/
/*
 *  ChangeWindowAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
ChangeWindowAttributes(
  WindowRef          window,
  WindowAttributes   setTheseAttributes,
  WindowAttributes   clearTheseAttributes);


/*
    WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
    WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
    
    SetWindowClass will disappear in the near future. Instead of SetWindowClass,
    you should use SetWindowGroup to move a window into the group of the desired
    class. This API is very dangerous in that is actually does change the class
    of the window, but class was meant to be an immutable property of the window.
    At the very least, this API will be modified to only change the layer of the
    window to match the layer that the specified class normally lives in. Consider
    yourself warned!
    
    WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
    WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING
*/
/*
 *  SetWindowClass()
 *  
 *  Summary:
 *    Changes the window class of a window.
 *  
 *  Discussion:
 *    SetWindowClass changes the class of a window. It also changes the
 *    window's z-order so that it is grouped with other windows of the
 *    same class. It does not change the visual appearance of the
 *    window. In CarbonLib, SetWindowClass may not be used to change a
 *    non-utility window to have utility window class, or to make a
 *    utility window have non-utility class. SetWindowClass is
 *    available from CarbonLib 1.1 forward.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window whose class to change.
 *    
 *    inWindowClass:
 *      The new window class.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetWindowClass(
  WindowRef     inWindow,
  WindowClass   inWindowClass);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/*  • Window Modality                                                                   */
/*——————————————————————————————————————————————————————————————————————————————————————*/

/*
 *  WindowModality
 *  
 */

  /*
   * A window does not prevent interaction with any other window in the
   * system.
   */
typedef UInt32 WindowModality;
enum {
  kWindowModalityNone           = 0,

  /*
   * A window prevents interaction with all other windows in the
   * system. Only available in CarbonLib. Mapped to
   * kWindowModalityAppModal in Mac OS X.
   */
  kWindowModalitySystemModal    = 1,

  /*
   * A window prevents interaction with other windows in the same
   * process.
   */
  kWindowModalityAppModal       = 2,

  /*
   * A window prevents interaction with a single other window.
   */
  kWindowModalityWindowModal    = 3
};


/*
 *  SetWindowModality()
 *  
 *  Summary:
 *    Sets the modality of a window.
 *  
 *  Discussion:
 *    The modality of a window is used by the Carbon event manager to
 *    automatically determine appropriate event handling.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window whose modality to set.
 *    
 *    inModalKind:
 *      The new modality for the window.
 *    
 *    inUnavailableWindow:
 *      If the window is becoming window-modal, this parameter
 *      specifies the window to which the inWindow parameter is modal.
 *      The unavailableWindow will not be available while inWindow is
 *      in window-modal state.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetWindowModality(
  WindowRef        inWindow,
  WindowModality   inModalKind,
  WindowRef        inUnavailableWindow);


/*
 *  GetWindowModality()
 *  
 *  Summary:
 *    Retrieves the modality of a window.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window whose modality to retrieve.
 *    
 *    outModalKind:
 *      On exit, contains the modality of the window.
 *    
 *    outUnavailableWindow:
 *      On exit, if the window is window-modal, contains the target
 *      window of the specified window's modality.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowModality(
  WindowRef         inWindow,
  WindowModality *  outModalKind,
  WindowRef *       outUnavailableWindow);      /* can be NULL */



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Floating Windows                                                                   */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
   Routines available from Mac OS 8.6 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
*/

/*
 *  ShowFloatingWindows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
ShowFloatingWindows(void);


/*
 *  HideFloatingWindows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HideFloatingWindows(void);


/*
 *  AreFloatingWindowsVisible()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
AreFloatingWindowsVisible(void);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Groups                                                                      */
/*                                                                                      */
/* The Window Group API allows the creation and management of groups of windows,        */
/* allowing control of the z-order, activation, and positioning of the windows.         */
/* Internally to the Window Manager, each of the standard window tiers (document,       */
/* toolbar, floating, modal, utility, help, and overlay) is implemented as a window     */
/* group; you can access the window group for a class with GetWindowGroupOfClass.       */
/* You can create your own window groups, if you would like your windows to float,      */
/* for example, above the floating window layer but below the modal layer. It is        */
/* also possible to create more complex hierarchical arrangements of window groups.     */
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef struct OpaqueWindowGroupRef*    WindowGroupRef;
enum {
  windowGroupInvalidErr         = -5616 /* WindowGroup is invalid */
};

/* may be passed as the "behindWindow" parameter to NewCWindow and SendBehind*/
#define kFirstWindowOfGroup             ((WindowRef)(-1))
#define kLastWindowOfGroup              ((WindowRef)NULL)
/* may be passed as the "behindGroup" parameter to SendWindowGroupBehind*/
#define kFirstWindowGroup               ((WindowGroupRef)(-1))
#define kLastWindowGroup                ((WindowGroupRef)NULL)

/*
 *  WindowGroupAttributes
 *  
 *  Summary:
 *    These are attributes that may be applied to a window group.
 */

  /*
   * Makes the group behave somewhat as a layer of windows that move
   * together. When any window in the group is brought to the front of
   * the group, the entire group will also be brought to the front of
   * the containing group's child hierarchy.
   */
typedef UInt32 WindowGroupAttributes;
enum {
  kWindowGroupAttrSelectAsLayer = 1 << 0,

  /*
   * The positions of the contents of this group with respect to each
   * other cannot be changed. When one item moves, all other items are
   * moved simultaneously.
   */
  kWindowGroupAttrMoveTogether  = 1 << 1,

  /*
   * The z-order of the contents of this group with respect to each
   * other cannot be changed. When one item changes z-order, all other
   * items are moved simulataneously. For purposes of z-ordering, the
   * group and all its subgroups are effectively treated as if they
   * were a single window in the parent group of this group.
   */
  kWindowGroupAttrLayerTogether = 1 << 2,

  /*
   * The active state of the windows in this group is shared. The
   * windows in the group are activated or deactivated according to the
   * activation scope of the group, but when any window in the group
   * changes activation, all other windows change to match.
   */
  kWindowGroupAttrSharedActivation = 1 << 3,

  /*
   * When any window in this group is collapsed, all other windows in
   * this group are hidden. All subgroups of this group are also
   * examined for the HideOnCollapse attribute, and any the windows of
   * any subgroup with this attribute are also hidden. All windows will
   * be shown again when the collapsed window is expanded.
   */
  kWindowGroupAttrHideOnCollapse = 1 << 4
};


/*
 *  WindowActivationScope
 *  
 *  Discussion:
 *    Every window has a WindowActivationScope. It defines how windows
 *    are activated by the Window Manager with respect to other windows
 *    in the window’s group and in the current process.
 */

  /*
   * Windows with this scope are never activated by the Window Manager.
   * This should be used when the window’s visual state does not change
   * based on activation (for example, tooltip windows), or when the
   * client wishes to manually control all activation. The window owner
   * is free to explicitly activate windows using the ActivateWindow
   * and DeactivateWindow APIs.
   */
typedef UInt32 WindowActivationScope;
enum {
  kWindowActivationScopeNone    = 0,

  /*
   * Windows with this scope are always active if visible. Windows with
   * this scope are unaffected by the activation state of other
   * windows. This activation scope is automatically used by floating
   * windows.
   */
  kWindowActivationScopeIndependent = 1,

  /*
   * Windows with this scope are activated relative to other windows
   * with the same scope in the current process. Only one window with
   * this scope can be active in the entire process. This activation
   * scope is automatically used by document and dialog windows.
   */
  kWindowActivationScopeAll     = 2
};


/*
 *  Summary:
 *    These are constants that can be used for the inNextGroup
 *    parameter to GetSiblingWindowGroup.
 */

  /*
   * Indicates that GetSiblingWindowGroup should return the next deeper
   * sibling group in the z-order.
   */
enum {
  kNextWindowGroup              = true,

  /*
   * Indicates that GetSiblingWindowGroup should return the next higher
   * sibling group in the z-order.
   */
  kPreviousWindowGroup          = false
};


/*
 *  WindowGroupContentOptions
 *  
 *  Discussion:
 *    Window group contents options are used to control what group
 *    content is counted or returned by the CountWindowGroupContents
 *    and GetWindowGroupContents APIs.
 */

  /*
   * Indicates that Count/GetWindowGroupContents should return the
   * windows in a group. If this option is not set, these APIs return
   * the groups in a group.
   */
typedef UInt32 WindowGroupContentOptions;
enum {
  kWindowGroupContentsReturnWindows = 1 << 0,

  /*
   * Indicates that Count/GetWindowGroupContents should include the
   * contents of groups contained by the specified group. If this
   * option is not set, these APIs only return information about the
   * specified group’s contents.
   */
  kWindowGroupContentsRecurse   = 1 << 1,

  /*
   * Indicates that Count/GetWindowGroupContents should only include
   * visible windows. Only valid when kWindowGroupContentsReturnWindows
   * is specified.
   */
  kWindowGroupContentsVisible   = 1 << 2
};


/*----------------------------------------------------------------------------------*/
/*  • Group creation, destruction, and refcounting                                  */
/*----------------------------------------------------------------------------------*/
/*
 *  CreateWindowGroup()
 *  
 *  Summary:
 *    Creates a new window group.
 *  
 *  Parameters:
 *    
 *    inAttributes:
 *      Attributes for the new window group.
 *    
 *    outGroup:
 *      On exit, contains the new window group.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
CreateWindowGroup(
  WindowGroupAttributes   inAttributes,
  WindowGroupRef *        outGroup);


/*
 *  RetainWindowGroup()
 *  
 *  Summary:
 *    Increments the refcount of a window group.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose refcount to increment.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
RetainWindowGroup(WindowGroupRef inGroup);


/*
 *  ReleaseWindowGroup()
 *  
 *  Summary:
 *    Releases a refcount on a window group. If the refcount goes to
 *    zero, the group is destroyed, and a refcount is released from all
 *    contained objects.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose refcount to decrement.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
ReleaseWindowGroup(WindowGroupRef inGroup);


/*
 *  GetWindowGroupRetainCount()
 *  
 *  Summary:
 *    Returns the refcount of a window group.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose refcount to return.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X after version 10.0
 *    Mac OS X:         in after version 10.0
 */
EXTERN_API_C( ItemCount )
GetWindowGroupRetainCount(WindowGroupRef inGroup);


/*
 *  GetWindowGroupOfClass()
 *  
 *  Summary:
 *    Gets the window group in which windows of a given class are
 *    placed.
 *  
 *  Discussion:
 *    The Window Manager uses window groups internally to manage the
 *    ordering of windows of different classes. In some cases, multiple
 *    classes are placed within the same group; for example, windows
 *    from all of the modal and alert window classes are placed into
 *    the same modal window group. The refcount of the group returned
 *    by this API is not incremented, and the caller does not need to
 *    release the reference.
 *  
 *  Parameters:
 *    
 *    windowClass:
 *      The class whose window group to retrieve. You may pass
 *      kAllWindowClasses to retrieve the root window group.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( WindowGroupRef )
GetWindowGroupOfClass(WindowClass windowClass);



/*----------------------------------------------------------------------------------*/
/*  • Group name, attributes, and level                                             */
/*----------------------------------------------------------------------------------*/
/*
 *  SetWindowGroupName()
 *  
 *  Summary:
 *    Sets the name of a window group.
 *  
 *  Discussion:
 *    The name of a window group is never displayed to the user.
 *    However, it is displayed by debugging functions such as
 *    DebugPrintWindowGroup. This can be very useful when debugging the
 *    structure of your window groups.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose name to set.
 *    
 *    inName:
 *      The name of the group.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
SetWindowGroupName(
  WindowGroupRef   inGroup,
  CFStringRef      inName);


/*
 *  CopyWindowGroupName()
 *  
 *  Summary:
 *    Returns a copy of the name of a window group.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose name to retrieve.
 *    
 *    outName:
 *      On exit, contains the name of the group. It is the caller's
 *      responsibility to release the name.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
CopyWindowGroupName(
  WindowGroupRef   inGroup,
  CFStringRef *    outName);


/*
 *  GetWindowGroupAttributes()
 *  
 *  Summary:
 *    Retrieves the attributes of a window group.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose attributes to retrieve.
 *    
 *    outAttributes:
 *      On exit, the group’s attributes.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
GetWindowGroupAttributes(
  WindowGroupRef           inGroup,
  WindowGroupAttributes *  outAttributes);


/*
 *  ChangeWindowGroupAttributes()
 *  
 *  Summary:
 *    Changes the attributes of a window group.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose attributes to change.
 *    
 *    setTheseAttributes:
 *      The attributes to set.
 *    
 *    clearTheseAttributes:
 *      The attributes to clear.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
ChangeWindowGroupAttributes(
  WindowGroupRef          inGroup,
  WindowGroupAttributes   setTheseAttributes,
  WindowGroupAttributes   clearTheseAttributes);


/*
 *  SetWindowGroupLevel()
 *  
 *  Summary:
 *    Sets the CoreGraphics window group level of windows in a group.
 *  
 *  Discussion:
 *    CoreGraphics windows (used to implement all windows in Carbon and
 *    Cocoa applications on Mac OS X) are divided into layers specified
 *    by a window level. Standard window levels are listed in
 *    <CoreGraphics/CGWindowLevel.h>. By default, a new window group
 *    has a window level of kCGNormalWindowLevel. When a window is
 *    placed into a window group, its window level is determined by the
 *    window level of its "base group". This is the containing group
 *    that is a child of the root group. For example, if group A is a
 *    child of the root group, and group B is a child of group A, and
 *    window C is in group B, then window C's base group is group A,
 *    and group A's window level determines the level of window C.
 *    SetWindowGroupLevel only allows changing the window level of
 *    groups that are children of the root group. It returns paramErr
 *    for other groups, since a group that is not a child of the root
 *    group is not a base group and changing its level has no effect.
 *    Changing the level of a group also changes the level of all
 *    windows currently contained by the group.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The window group whose level to change.
 *    
 *    inLevel:
 *      The new level for the windows in this group.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
SetWindowGroupLevel(
  WindowGroupRef   inGroup,
  SInt32           inLevel);


/*
 *  GetWindowGroupLevel()
 *  
 *  Summary:
 *    Gets the CoreGraphics window group level of windows in a group.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The window group whose level to return.
 *    
 *    outLevel:
 *      On exit, contains the window level of the windows in this group.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
GetWindowGroupLevel(
  WindowGroupRef   inGroup,
  SInt32 *         outLevel);



/*----------------------------------------------------------------------------------*/
/*  • Group z-ordering                                                              */
/*----------------------------------------------------------------------------------*/
/*
 *  SendWindowGroupBehind()
 *  
 *  Summary:
 *    Changes the z-order of a group, if the group does not have the
 *    kWindowGroupAttributeLayerTogether attribute set.
 *  
 *  Discussion:
 *    SendWindowGroupBehind currently requires that the group being
 *    moved and the behindGroup have the same parent group.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose z-order to change.
 *    
 *    behindGroup:
 *      The group behind which to position the specified group.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
SendWindowGroupBehind(
  WindowGroupRef   inGroup,
  WindowGroupRef   behindGroup);


/*----------------------------------------------------------------------------------*/
/*  • Group containment hierarchy manipulation                                      */
/*----------------------------------------------------------------------------------*/
/*
 *  GetWindowGroup()
 *  
 *  Summary:
 *    Gets the window group that contains a window.
 *  
 *  Discussion:
 *    The refcount of the group returned by this API is not
 *    incremented, and the caller does not need to release the
 *    reference.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window whose containing group to retrieve.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( WindowGroupRef )
GetWindowGroup(WindowRef inWindow);


/*
 *  SetWindowGroup()
 *  
 *  Summary:
 *    Sets the window group that contains a window.
 *  
 *  Discussion:
 *    The window’s z-order relative to windows in the current process
 *    may also be changed by this API. If the new window group is
 *    z-ordered above the window’s current group, the window will be
 *    placed at the end of the new group. If the new window group is
 *    z-ordered below the window’s current group, the window will be
 *    placed at the top of the new group. You may not place a window
 *    directly into the root group.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window whose group to change.
 *    
 *    inNewGroup:
 *      The new containing group.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
SetWindowGroup(
  WindowRef        inWindow,
  WindowGroupRef   inNewGroup);


/*
 *  IsWindowContainedInGroup()
 *  
 *  Summary:
 *    Indicates whether a window is contained within a group or any of
 *    its subgroups.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window whose containment to examine.
 *    
 *    inGroup:
 *      The group that might contain the window.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
IsWindowContainedInGroup(
  WindowRef        inWindow,
  WindowGroupRef   inGroup);


/*
 *  GetWindowGroupParent()
 *  
 *  Summary:
 *    Gets the window group that contains a group.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose containing group to retrieve.
 *    
 *    outGroup:
 *      On exit, the containing window group of the group. The group’s
 *      refcount is not incremented by this API, and the caller does
 *      not need to release the reference.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( WindowGroupRef )
GetWindowGroupParent(WindowGroupRef inGroup);


/*
 *  SetWindowGroupParent()
 *  
 *  Summary:
 *    Sets the window group that contains a group.
 *  
 *  Discussion:
 *    SetWindowGroupParent currently requires that the group have no
 *    windows in it.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose containing group to change.
 *    
 *    inNewGroup:
 *      The new containing group.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
SetWindowGroupParent(
  WindowGroupRef   inGroup,
  WindowGroupRef   inNewGroup);


/*
 *  GetWindowGroupSibling()
 *  
 *  Summary:
 *    Returns the next or previous group of a window group.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose sibling to return.
 *    
 *    inNextGroup:
 *      True to return the next sibling, false to return the previous
 *      sibling.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( WindowGroupRef )
GetWindowGroupSibling(
  WindowGroupRef   inGroup,
  Boolean          inNextGroup);


/*
 *  GetWindowGroupOwner()
 *  
 *  Summary:
 *    Returns the window that owns a window group, or NULL if none.
 *  
 *  Discussion:
 *    A window may own one or more window groups. The windows in an
 *    owned window group will always be z-ordered above the owner
 *    window. Whenever the owner window changes z-order, the windows in
 *    the groups owned by the window will be moved also.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose owner to retrieve.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( WindowRef )
GetWindowGroupOwner(WindowGroupRef inGroup);


/*
 *  SetWindowGroupOwner()
 *  
 *  Summary:
 *    Sets the window that owns a window group.
 *  
 *  Discussion:
 *    The group and the window must have the same parent group.
 *    SetWindowGroupOwner currently requires that the group have no
 *    windows in it.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose owner to set.
 *    
 *    inWindow:
 *      The group's new owner.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
SetWindowGroupOwner(
  WindowGroupRef   inGroup,
  WindowRef        inWindow);



/*----------------------------------------------------------------------------------*/
/*  • Inspection of group contents                                                  */
/*----------------------------------------------------------------------------------*/

/*
 *  CountWindowGroupContents()
 *  
 *  Summary:
 *    Counts the windows or groups contained in a group.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose contents to count.
 *    
 *    inOptions:
 *      Specifies how to count the group’s contents.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( ItemCount )
CountWindowGroupContents(
  WindowGroupRef              inGroup,
  WindowGroupContentOptions   inOptions);


/*
 *  GetWindowGroupContents()
 *  
 *  Summary:
 *    Retrieves the windows or groups contained in a group.
 *  
 *  Discussion:
 *    The windows or groups returned by this API will be placed into
 *    the output buffer in z-order, from highest to lowest.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose contents to retrieve.
 *    
 *    inOptions:
 *      Specifies which content to retrieve.
 *    
 *    inAllowedItems:
 *      The number of items that will fit in the output buffer.
 *    
 *    outNumItems:
 *      On exit, the number of items that were returned. May be NULL.
 *    
 *    outItems:
 *      On entry, points to enough memory to hold inAllowedSize
 *      WindowRefs or WindowGroupRefs. On exit, contains *outNumItems
 *      WindowRefs or WindowGroupRefs.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
GetWindowGroupContents(
  WindowGroupRef              inGroup,
  WindowGroupContentOptions   inOptions,
  ItemCount                   inAllowedItems,
  ItemCount *                 outNumItems,          /* can be NULL */
  void **                     outItems);


/*
 *  GetIndexedWindow()
 *  
 *  Summary:
 *    Retrieves a specified window from a group.
 *  
 *  Discussion:
 *    GetIndexedWindow is provided as an easier way to get a particular
 *    window from a group than using GetWindowGroupContents. If you
 *    only need to retrieve, say, the last window in a group, it is
 *    easier and more efficient to use GetIndexedWindow. If you need to
 *    retrieve all the windows in a group, it is more efficient to use
 *    GetWindowGroupContents.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group containing the window to retrieve.
 *    
 *    inIndex:
 *      The index of the window. This parameter may range from 1 to
 *      CountWindowGroupContents( inGroup,
 *      kWindowGroupContentsReturnWindows | inOptions );
 *    
 *    inOptions:
 *      Indicates how to locate the specified window.
 *      kWindowGroupContentsReturnWindows is implied by this API and
 *      does not need to be explicitly specified.
 *    
 *    outWindow:
 *      On exit, the window at the specified index.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
GetIndexedWindow(
  WindowGroupRef              inGroup,
  UInt32                      inIndex,
  WindowGroupContentOptions   inOptions,
  WindowRef *                 outWindow);


/*
 *  GetWindowIndex()
 *  
 *  Summary:
 *    Retrieves the z-order index of a window inside a group.
 *  
 *  Discussion:
 *    The z-order index of a window is its relative position in z-order
 *    inside a group. The index ranges from 1 to the number of windows
 *    in the group.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window whose z-order index to retrieve.
 *    
 *    inStartGroup:
 *      The group on which to base the z-order index. This should be
 *      either the containing group of the window, or NULL. If NULL,
 *      this API returns the z-order index of the window across the
 *      entire process.
 *    
 *    inOptions:
 *      Indicates how to enumerate the specified window.
 *      kWindowGroupContentsReturnWindows is implied by this API and
 *      does not need to be explicitly specified.
 *    
 *    outIndex:
 *      On exit, contains the window’s z-order index.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
GetWindowIndex(
  WindowRef                   inWindow,
  WindowGroupRef              inStartGroup,
  WindowGroupContentOptions   inOptions,
  UInt32 *                    outIndex);



/*----------------------------------------------------------------------------------*/
/*  • Window activation                                                             */
/*----------------------------------------------------------------------------------*/
/*
 *  ActiveNonFloatingWindow()
 *  
 *  Summary:
 *    Returns the window, among all windows with activation scope of
 *    kWindowActivationScopeAll, that is considered active.
 *  
 *  Discussion:
 *    The Mac OS 8.5 Window Manager introduced the
 *    FrontNonFloatingWindow API, which was designed to return the
 *    window that should be considered active by the application. With
 *    the advent of window groups, it is now possible to have a window
 *    that looks active (is highlighted, and accepts keyboard input)
 *    but to have other non-floating windows grouped above the active
 *    window. The ActiveNonFloatingWindow API returns the active window
 *    regardless of where it is positioned in the z-order. Most code
 *    that currently uses FrontNonFloatingWindow or
 *    GetFrontWindowOfClass(kDocumentClass) to get the active window
 *    should use ActiveNonFloatingWindow instead.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( WindowRef )
ActiveNonFloatingWindow(void);


/*
 *  IsWindowActive()
 *  
 *  Summary:
 *    Indicates whether a window is active.
 *  
 *  Discussion:
 *    The active state of a window is simply determined by whether its
 *    window frame is drawn using an active appearance. This does not
 *    indicate whether the window has keyboard focus. To get the window
 *    with keyboard focus, use GetUserFocusWindow().
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window whose active state to retrieve.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( Boolean )
IsWindowActive(WindowRef inWindow);


/*
 *  ActivateWindow()
 *  
 *  Summary:
 *    Activates or deactivates a window.
 *  
 *  Discussion:
 *    Window activation consists of two steps: hiliting the window
 *    frame and sending an activate event to the window. ActivateWindow
 *    handles both of these steps and also updates internal Window
 *    Manager state. If you just need to hilite the window frame, you
 *    may use HiliteWindow. If you need to send an activate event, you
 *    should always use ActivateWindow rather than creating and sending
 *    the event yourself.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window to activate or deactivate.
 *    
 *    inActivate:
 *      Whether to activate or deactivate the window.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
ActivateWindow(
  WindowRef   inWindow,
  Boolean     inActivate);


/*
 *  GetWindowActivationScope()
 *  
 *  Summary:
 *    Retrieves a window’s activation scope.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window whose activation scope to retrieve.
 *    
 *    outScope:
 *      On exit, the window’s activation scope.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
GetWindowActivationScope(
  WindowRef                inWindow,
  WindowActivationScope *  outScope);


/*
 *  SetWindowActivationScope()
 *  
 *  Summary:
 *    Sets a window’s activation scope.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window whose activation scope to set.
 *    
 *    inScope:
 *      The new activation scope.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
SetWindowActivationScope(
  WindowRef               inWindow,
  WindowActivationScope   inScope);



/*----------------------------------------------------------------------------------*/
/*  • Debugging Utilities                                                           */
/*----------------------------------------------------------------------------------*/
/*
 *  DebugPrintWindowGroup()
 *  
 *  Summary:
 *    Prints the contents of a window group to stdout.
 *  
 *  Parameters:
 *    
 *    inGroup:
 *      The group whose contents to print.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DebugPrintWindowGroup(WindowGroupRef inGroup);


/*
 *  DebugPrintAllWindowGroups()
 *  
 *  Summary:
 *    Prints the full window group hierarchy, starting at the root
 *    group.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( void )
DebugPrintAllWindowGroups(void);




/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Background Image                                                                   */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* SetWinColor is not available in Carbon.*/
#if CALL_NOT_IN_CARBON
/*
 *  SetWinColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SetWinColor(
  WindowRef     window,
  WCTabHandle   newColorTable)                                ONEWORDINLINE(0xAA41);


/* SetDeskCPat is not available in Carbon.*/
/*
 *  SetDeskCPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SetDeskCPat(PixPatHandle deskPixPat)                          ONEWORDINLINE(0xAA47);


/*
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
*/
#endif  /* CALL_NOT_IN_CARBON */

/*
 *  SetWindowContentColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetWindowContentColor(
  WindowRef         window,
  const RGBColor *  color);


/*
 *  GetWindowContentColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowContentColor(
  WindowRef   window,
  RGBColor *  color);


/* Routines available from Mac OS 8.5 forward*/
/*
 *  GetWindowContentPattern()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowContentPattern(
  WindowRef      window,
  PixPatHandle   outPixPat);


/*
 *  SetWindowContentPattern()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetWindowContentPattern(
  WindowRef      window,
  PixPatHandle   pixPat);


/* Routines available from Mac OS 9.0 forward*/
typedef OptionBits                      WindowPaintProcOptions;
enum {
  kWindowPaintProcOptionsNone   = 0
};

/*
 *  InstallWindowContentPaintProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
InstallWindowContentPaintProc(
  WindowRef                window,
  WindowPaintUPP           paintProc,
  WindowPaintProcOptions   options,
  void *                   refCon);         /* can be NULL */


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Scrolling Routines                                                                 */
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef UInt32 ScrollWindowOptions;
enum {
  kScrollWindowNoOptions        = 0,
  kScrollWindowInvalidate       = (1L << 0), /* add the exposed area to the window’s update region*/
  kScrollWindowEraseToPortBackground = (1L << 1) /* erase the exposed area using the background color/pattern of the window’s grafport*/
};


/* Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward*/

/*
 *  ScrollWindowRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
ScrollWindowRect(
  WindowRef             inWindow,
  const Rect *          inScrollRect,
  SInt16                inHPixels,
  SInt16                inVPixels,
  ScrollWindowOptions   inOptions,
  RgnHandle             outExposedRgn);      /* can be NULL */


/*
 *  ScrollWindowRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
ScrollWindowRegion(
  WindowRef             inWindow,
  RgnHandle             inScrollRgn,
  SInt16                inHPixels,
  SInt16                inVPixels,
  ScrollWindowOptions   inOptions,
  RgnHandle             outExposedRgn);      /* can be NULL */




/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Low-Level Region & Painting Routines                                               */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
 *  ClipAbove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
ClipAbove(WindowRef window)                                   ONEWORDINLINE(0xA90B);


/* SaveOld/DrawNew are not available in Carbon.  Use ReshapeCustomWindow instead.*/
#if CALL_NOT_IN_CARBON
/*
 *  SaveOld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
SaveOld(WindowRef window)                                     ONEWORDINLINE(0xA90E);


/*
 *  DrawNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
DrawNew(
  WindowRef   window,
  Boolean     update)                                         ONEWORDINLINE(0xA90F);


#endif  /* CALL_NOT_IN_CARBON */

/*
 *  PaintOne()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
PaintOne(
  WindowRef   window,             /* can be NULL */
  RgnHandle   clobberedRgn)                                   ONEWORDINLINE(0xA90C);


/*
 *  PaintBehind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
PaintBehind(
  WindowRef   startWindow,        /* can be NULL */
  RgnHandle   clobberedRgn)                                   ONEWORDINLINE(0xA90D);


/*
 *  CalcVis()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
CalcVis(WindowRef window)                                     ONEWORDINLINE(0xA909);


/*
 *  CalcVisBehind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
CalcVisBehind(
  WindowRef   startWindow,        /* can be NULL */
  RgnHandle   clobberedRgn)                                   ONEWORDINLINE(0xA90A);


/*
 *  CheckUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
CheckUpdate(EventRecord * theEvent)                           ONEWORDINLINE(0xA911);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window List                                                                        */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
 *  [Mac]FindWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
#if TARGET_OS_MAC
    #define MacFindWindow FindWindow
#endif
EXTERN_API( WindowPartCode )
MacFindWindow(
  Point        thePoint,
  WindowRef *  window)                                        ONEWORDINLINE(0xA92C);


/*
 *  FrontWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( WindowRef )
FrontWindow(void)                                             ONEWORDINLINE(0xA924);


/*
 *  BringToFront()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
BringToFront(WindowRef window)                                ONEWORDINLINE(0xA920);


/*
 *  SendBehind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
SendBehind(
  WindowRef   window,
  WindowRef   behindWindow)                                   ONEWORDINLINE(0xA921);


/*
 *  SelectWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
SelectWindow(WindowRef window)                                ONEWORDINLINE(0xA91F);


/*
   Routines available from Mac OS 8.6 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
*/

/*
 *  FrontNonFloatingWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( WindowRef )
FrontNonFloatingWindow(void);


/* Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward*/

/*
 *  GetNextWindowOfClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( WindowRef )
GetNextWindowOfClass(
  WindowRef     inWindow,
  WindowClass   inWindowClass,
  Boolean       mustBeVisible);


/*
 *  GetFrontWindowOfClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( WindowRef )
GetFrontWindowOfClass(
  WindowClass   inWindowClass,
  Boolean       mustBeVisible);


/*
 *  FindWindowOfClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
FindWindowOfClass(
  const Point *     where,
  WindowClass       inWindowClass,
  WindowRef *       outWindow,
  WindowPartCode *  outWindowPart);      /* can be NULL */



/* Carbon only*/
/*
 *  CreateStandardWindowMenu()
 *  
 *  Discussion:
 *    Creates a standard Window menu for your application. You can call
 *    this to create a window menu for your application and insert it
 *    in your menu bar (typically at the end of your menu list). To
 *    register a window to be tracked by this menu, you either create
 *    your window with CreateNewWindow, passing the
 *    kWindowInWindowMenuAttribute, or you can use
 *    ChangeWindowAttributes after the window is created. The Toolbox
 *    takes care of acting on the standard items such as zoom and
 *    minimize, as well as bringing selected windows to the front. All
 *    you need to do is install it and register your windows and the
 *    Toolbox does the rest.
 *  
 *  Parameters:
 *    
 *    inOptions:
 *      Currently you must pass zero for this parameter.
 *    
 *    outMenu:
 *      Receives a new menu reference which contains the standard
 *      window menu items and commands.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
CreateStandardWindowMenu(
  OptionBits   inOptions,
  MenuRef *    outMenu);


/*
 *  SetWindowAlternateTitle()
 *  
 *  Discussion:
 *    This API sets an alternate title for a window. The alternate
 *    title overrides what is displayed in the Window menu. If you do
 *    not set an alternate title, the normal window title is used. You
 *    would normally use this if the window title was not expressive
 *    enough to be used in the Window menu (or similar text-only
 *    situation).
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window to set the alternate title.
 *    
 *    inTitle:
 *      The alternate title for the window. Passing NULL for this
 *      parameter will remove any alternate title that might be present.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetWindowAlternateTitle(
  WindowRef     inWindow,
  CFStringRef   inTitle);


/*
 *  CopyWindowAlternateTitle()
 *  
 *  Discussion:
 *    This API gets the alternate title for a window. See the
 *    discussion of SetWindowAlternateTitle for more info.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window to get the alternate title from.
 *    
 *    outTitle:
 *      Receives the alternate title for the window. If the window does
 *      not have an alternate title, NULL will be returned in outTitle.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
CopyWindowAlternateTitle(
  WindowRef      inWindow,
  CFStringRef *  outTitle);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Misc Low-Level stuff                                                               */
/*——————————————————————————————————————————————————————————————————————————————————————*/
#if CALL_NOT_IN_CARBON
/*
 *  InitWindows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
InitWindows(void)                                             ONEWORDINLINE(0xA912);


/*  The window manager port does not exist in Carbon.   */
/*  We are investigating replacement technologies.      */
/*
 *  GetWMgrPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
GetWMgrPort(GrafPtr * wPort)                                  ONEWORDINLINE(0xA910);


/*
 *  GetCWMgrPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
GetCWMgrPort(CGrafPtr * wMgrCPort)                            ONEWORDINLINE(0xAA48);


/*
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
*/
#endif  /* CALL_NOT_IN_CARBON */

/*
 *  IsValidWindowPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
IsValidWindowPtr(WindowRef possibleWindow);


#define IsValidWindowRef IsValidWindowPtr
/*
   Routines available from Mac OS 8.6 forward
   InitFloatingWindows is not available in Carbon;
   window ordering is always active for Carbon clients
*/
#if CALL_NOT_IN_CARBON
/*
 *  InitFloatingWindows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( OSStatus )
InitFloatingWindows(void);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Various & Sundry Window Accessors                                                  */
/*——————————————————————————————————————————————————————————————————————————————————————*/
#endif  /* CALL_NOT_IN_CARBON */

/*
 *  HiliteWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
HiliteWindow(
  WindowRef   window,
  Boolean     fHilite)                                        ONEWORDINLINE(0xA91C);


/*
 *  SetWRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
SetWRefCon(
  WindowRef   window,
  long        data)                                           ONEWORDINLINE(0xA918);


/*
 *  GetWRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( long )
GetWRefCon(WindowRef window)                                  ONEWORDINLINE(0xA917);


/*
 *  SetWindowPic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
SetWindowPic(
  WindowRef   window,
  PicHandle   pic)                                            ONEWORDINLINE(0xA92E);


/*
 *  GetWindowPic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( PicHandle )
GetWindowPic(WindowRef window)                                ONEWORDINLINE(0xA92F);


/*
 *  GetWVariant()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( short )
GetWVariant(WindowRef window)                                 ONEWORDINLINE(0xA80A);


/* Routines available from Mac OS 8.0 (Appearance 1.0) forward*/
/*
 *  GetWindowFeatures()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowFeatures(
  WindowRef   window,
  UInt32 *    outFeatures)                                    THREEWORDINLINE(0x303C, 0x0013, 0xAA74);


/*
 *  GetWindowRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowRegion(
  WindowRef          window,
  WindowRegionCode   inRegionCode,
  RgnHandle          ioWinRgn)                                THREEWORDINLINE(0x303C, 0x0014, 0xAA74);


/*
 *  GetWindowStructureWidths()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowStructureWidths(
  WindowRef   inWindow,
  Rect *      outRect);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Update Events                                                                      */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
   These aren't present in Carbon. Please use the InvalWindowRect, etc. routines
   below instead.
*/
#if CALL_NOT_IN_CARBON
/*
 *  InvalRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
InvalRect(const Rect * badRect)                               ONEWORDINLINE(0xA928);


/*
 *  InvalRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
InvalRgn(RgnHandle badRgn)                                    ONEWORDINLINE(0xA927);


/*
 *  ValidRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
ValidRect(const Rect * goodRect)                              ONEWORDINLINE(0xA92A);


/*
 *  ValidRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( void )
ValidRgn(RgnHandle goodRgn)                                   ONEWORDINLINE(0xA929);


#endif  /* CALL_NOT_IN_CARBON */

/*
 *  BeginUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
BeginUpdate(WindowRef window)                                 ONEWORDINLINE(0xA922);


/*
 *  EndUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
EndUpdate(WindowRef window)                                   ONEWORDINLINE(0xA923);


/*
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
*/

/*
 *  InvalWindowRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
InvalWindowRgn(
  WindowRef   window,
  RgnHandle   region);


/*
 *  InvalWindowRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
InvalWindowRect(
  WindowRef     window,
  const Rect *  bounds);


/*
 *  ValidWindowRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
ValidWindowRgn(
  WindowRef   window,
  RgnHandle   region);


/*
 *  ValidWindowRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
ValidWindowRect(
  WindowRef     window,
  const Rect *  bounds);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • DrawGrowIcon                                                                       */
/*                                                                                      */
/*  DrawGrowIcon is deprecated from Mac OS 8.0 forward.  Theme-savvy window defprocs    */
/*  include the grow box in the window frame.                                           */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
 *  DrawGrowIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
DrawGrowIcon(WindowRef window)                                ONEWORDINLINE(0xA904);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Titles                                                                      */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
 *  SetWTitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
SetWTitle(
  WindowRef          window,
  ConstStr255Param   title)                                   ONEWORDINLINE(0xA91A);


/*
 *  GetWTitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
GetWTitle(
  WindowRef   window,
  Str255      title)                                          ONEWORDINLINE(0xA919);


/*
 *  SetWindowTitleWithCFString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetWindowTitleWithCFString(
  WindowRef     inWindow,
  CFStringRef   inString);


/*
 *  CopyWindowTitleAsCFString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
CopyWindowTitleAsCFString(
  WindowRef      inWindow,
  CFStringRef *  outString);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Proxies                                                                     */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* Routines available from Mac OS 8.5 forward*/

/*
 *  SetWindowProxyFSSpec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetWindowProxyFSSpec(
  WindowRef       window,
  const FSSpec *  inFile);


/*
 *  GetWindowProxyFSSpec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowProxyFSSpec(
  WindowRef   window,
  FSSpec *    outFile);


/*
 *  SetWindowProxyAlias()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetWindowProxyAlias(
  WindowRef     window,
  AliasHandle   alias);


/*
 *  GetWindowProxyAlias()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowProxyAlias(
  WindowRef      window,
  AliasHandle *  alias);


/*
 *  SetWindowProxyCreatorAndType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetWindowProxyCreatorAndType(
  WindowRef   window,
  OSType      fileCreator,
  OSType      fileType,
  SInt16      vRefNum);


/*
 *  GetWindowProxyIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowProxyIcon(
  WindowRef   window,
  IconRef *   outIcon);


/*
 *  SetWindowProxyIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetWindowProxyIcon(
  WindowRef   window,
  IconRef     icon);


/*
 *  RemoveWindowProxy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
RemoveWindowProxy(WindowRef window);


/*
 *  BeginWindowProxyDrag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
BeginWindowProxyDrag(
  WindowRef        window,
  DragReference *  outNewDrag,
  RgnHandle        outDragOutlineRgn);


/*
 *  EndWindowProxyDrag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
EndWindowProxyDrag(
  WindowRef       window,
  DragReference   theDrag);


/*
 *  TrackWindowProxyFromExistingDrag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
TrackWindowProxyFromExistingDrag(
  WindowRef       window,
  Point           startPt,
  DragReference   drag,
  RgnHandle       inDragOutlineRgn);


/*
 *  TrackWindowProxyDrag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
TrackWindowProxyDrag(
  WindowRef   window,
  Point       startPt);


/*
 *  IsWindowModified()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
IsWindowModified(WindowRef window);


/*
 *  SetWindowModified()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetWindowModified(
  WindowRef   window,
  Boolean     modified);


/*
 *  IsWindowPathSelectClick()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
IsWindowPathSelectClick(
  WindowRef            window,
  const EventRecord *  event);


/*
 *  WindowPathSelect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
WindowPathSelect(
  WindowRef   window,
  MenuRef     menu,                /* can be NULL */
  SInt32 *    outMenuResult);


/*
 *  IsWindowPathSelectEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
IsWindowPathSelectEvent(
  WindowRef   window,
  EventRef    inEvent);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/*  • HiliteWindowFrameForDrag                                                          */
/*                                                                                      */
/*  If you call ShowDragHilite and HideDragHilite, you don’t need to use this routine.  */
/*  If you implement custom drag hiliting, you should call HiliteWindowFrameForDrag     */
/*  when the drag is tracking inside a window with drag-hilited content.                */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* Routines available from Mac OS 8.5 forward*/

/*
 *  HiliteWindowFrameForDrag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HiliteWindowFrameForDrag(
  WindowRef   window,
  Boolean     hilited)                                        TWOWORDINLINE(0x7019, 0xA829);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Transitions                                                                 */
/*                                                                                      */
/*  TransitionWindow displays a window with accompanying animation and sound.           */
/*——————————————————————————————————————————————————————————————————————————————————————*/
typedef UInt32 WindowTransitionEffect;
enum {
  kWindowZoomTransitionEffect   = 1,    /* Finder-like zoom rectangles. Use with Show or Hide transition actions*/
  kWindowSheetTransitionEffect  = 2,    /* Zoom in/out from parent. Use with TransitionWindowAndParent and Show or Hide transition actions*/
  kWindowSlideTransitionEffect  = 3     /* Slide the window into its new position. Use with Move or Resize transition actions*/
};

typedef UInt32 WindowTransitionAction;
enum {
  kWindowShowTransitionAction   = 1,    /* param is rect in global coordinates from which to start the animation*/
  kWindowHideTransitionAction   = 2,    /* param is rect in global coordinates at which to end the animation*/
  kWindowMoveTransitionAction   = 3,    /* param is rect in global coordinates of window's new structure bounds*/
  kWindowResizeTransitionAction = 4     /* param is rect in global coordinates of window's new structure bounds*/
};

/*
 *  TransitionWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
TransitionWindow(
  WindowRef                window,
  WindowTransitionEffect   effect,
  WindowTransitionAction   action,
  const Rect *             rect);        /* can be NULL */


/*
 *  TransitionWindowAndParent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
TransitionWindowAndParent(
  WindowRef                window,
  WindowRef                parentWindow,
  WindowTransitionEffect   effect,
  WindowTransitionAction   action,
  const Rect *             rect);              /* can be NULL */



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Positioning                                                                 */
/*——————————————————————————————————————————————————————————————————————————————————————*/

/*
 *  [Mac]MoveWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
#if TARGET_OS_MAC
    #define MacMoveWindow MoveWindow
#endif
EXTERN_API( void )
MacMoveWindow(
  WindowRef   window,
  short       hGlobal,
  short       vGlobal,
  Boolean     front)                                          ONEWORDINLINE(0xA91B);


/*
 *  SizeWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
SizeWindow(
  WindowRef   window,
  short       w,
  short       h,
  Boolean     fUpdate)                                        ONEWORDINLINE(0xA91D);



/* Note: bBox can only be NULL when linking to CarbonLib 1.0 forward */
/*
 *  GrowWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( long )
GrowWindow(
  WindowRef     window,
  Point         startPt,
  const Rect *  bBox)          /* can be NULL */              ONEWORDINLINE(0xA92B);


/* Note: boundsRect can only be NULL when linking to CarbonLib 1.0 forward */
/*
 *  DragWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
DragWindow(
  WindowRef     window,
  Point         startPt,
  const Rect *  boundsRect)       /* can be NULL */           ONEWORDINLINE(0xA925);


/*
 *  ZoomWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
ZoomWindow(
  WindowRef        window,
  WindowPartCode   partCode,
  Boolean          front)                                     ONEWORDINLINE(0xA83A);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Collapsing/Expanding                                                        */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/* Routines available from Mac OS 8.0 (Appearance 1.0) forward*/
/*
 *  IsWindowCollapsable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
IsWindowCollapsable(WindowRef window)                         THREEWORDINLINE(0x303C, 0x000F, 0xAA74);


/*
 *  IsWindowCollapsed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
IsWindowCollapsed(WindowRef window)                           THREEWORDINLINE(0x303C, 0x0010, 0xAA74);


/*
 *  CollapseWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
CollapseWindow(
  WindowRef   window,
  Boolean     collapse)                                       THREEWORDINLINE(0x303C, 0x0011, 0xAA74);


/*
 *  CollapseAllWindows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
CollapseAllWindows(Boolean collapse)                          THREEWORDINLINE(0x303C, 0x0012, 0xAA74);


/* Routines available on Mac OS X*/

/*
 *  CreateQDContextForCollapsedWindowDockTile()
 *  
 *  Discussion:
 *    Creates and returns a CGrafPtr for a collapsed window's tile in
 *    the dock. You can use this port to draw into your window's dock
 *    tile with Quickdraw. You **MUST** call
 *    ReleaseQDContextForCollapsedWindowDockTile and NOT DisposePort
 *    when using this API, as it maintains more state than just the
 *    port. If you call DisposePort, you may leak system resources.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window to create the dock tile port for. If this window is
 *      not collapsed, an error is returned.
 *    
 *    outContext:
 *      The Quickdraw port for you to use to draw into. If you wish to
 *      use CoreGraphics (Quartz) drawing, call CreateCGContextForPort
 *      with this port to obtain a CGContext.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
CreateQDContextForCollapsedWindowDockTile(
  WindowRef   inWindow,
  CGrafPtr *  outContext);


/*
 *  ReleaseQDContextForCollapsedWindowDockTile()
 *  
 *  Discussion:
 *    Releases a port and other state created by the
 *    CreateQDContextForCollapsedWindowDockTile API. You MUST call this
 *    instead of DisposePort directly, or you may leak system resources.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window you created the port for. If this window is not
 *      collapsed, an error is returned.
 *    
 *    inContext:
 *      The Quickdraw context to dispose.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
ReleaseQDContextForCollapsedWindowDockTile(
  WindowRef   inWindow,
  CGrafPtr    inContext);


/*
 *  UpdateCollapsedWindowDockTile()
 *  
 *  Discussion:
 *    Automatically updates the image of a particular window in the
 *    dock to the current contents of the window. Use this for periodic
 *    updates, etc. Do not use this for animation purposes, if you want
 *    animation, use the above create/release drawing context APIs.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window to update the dock tile for. If this window is not
 *      collapsed, an error is returned.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API_C( OSStatus )
UpdateCollapsedWindowDockTile(WindowRef inWindow);



/*
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
*/

/*
 *  GetWindowBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowBounds(
  WindowRef          window,
  WindowRegionCode   regionCode,
  Rect *             globalBounds);


/* Note: newContentRect can only be NULL when linking to CarbonLib 1.0 forward */
/*
 *  ResizeWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
ResizeWindow(
  WindowRef     window,
  Point         startPoint,
  const Rect *  sizeConstraints,       /* can be NULL */
  Rect *        newContentRect);       /* can be NULL */



/*
   Routines available from Mac OS 8.5 forward,
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0.2 forward
*/

/*
 *  SetWindowBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetWindowBounds(
  WindowRef          window,
  WindowRegionCode   regionCode,
  const Rect *       globalBounds);


/* Routines available from Mac OS 8.5 forward*/

/*
 *  RepositionWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
RepositionWindow(
  WindowRef              window,
  WindowRef              parentWindow,
  WindowPositionMethod   method);


/*
 *  MoveWindowStructure()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
MoveWindowStructure(
  WindowRef   window,
  short       hGlobal,
  short       vGlobal);


/*
   Routines available from Mac OS 8.5 forward,
   or from Mac OS 8.6 forward when linking to CarbonLib 1.1 forward
*/

/*
 *  IsWindowInStandardState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
IsWindowInStandardState(
  WindowRef   window,
  Point *     idealSize,                /* can be NULL */
  Rect *      idealStandardState);      /* can be NULL */


/*
 *  ZoomWindowIdeal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
ZoomWindowIdeal(
  WindowRef        window,
  WindowPartCode   partCode,
  Point *          ioIdealSize);


/*
 *  GetWindowIdealUserState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowIdealUserState(
  WindowRef   window,
  Rect *      userState);


/*
 *  SetWindowIdealUserState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetWindowIdealUserState(
  WindowRef     window,
  const Rect *  userState);


/* Routines available in CarbonLib 1.1 and later*/

/*
 *  GetWindowGreatestAreaDevice()
 *  
 *  Summary:
 *    Returns the graphics device with the greatest area of
 *    intersection with a specified window region.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window to compare against.
 *    
 *    inRegion:
 *      The window region to compare against.
 *    
 *    outGreatestDevice:
 *      On exit, the graphics device with the greatest intersection.
 *      May be NULL.
 *    
 *    outGreatestDeviceRect:
 *      On exit, the bounds of the graphics device with the greatest
 *      intersection. May be NULL. If the device with the greatest
 *      intersection also contains the menu bar, the device rect will
 *      exclude the menu bar area.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowGreatestAreaDevice(
  WindowRef          inWindow,
  WindowRegionCode   inRegion,
  GDHandle *         outGreatestDevice,           /* can be NULL */
  Rect *             outGreatestDeviceRect);      /* can be NULL */



/*
 *  WindowConstrainOptions
 *  
 */

  /*
   * The window may be resized if necessary to make it fit onscreen.
   */
typedef UInt32 WindowConstrainOptions;
enum {
  kWindowConstrainMayResize     = (1L << 0),

  /*
   * The window will be moved even if it doesn't fit entirely onscreen.
   */
  kWindowConstrainMoveRegardlessOfFit = (1L << 1),

  /*
   * Allow partial intersection of the specified window region with the
   * screen, instead of requiring total intersection.
   */
  kWindowConstrainAllowPartial  = (1L << 2),

  /*
   * Only calculate the new window bounds; don't actually move the
   * window.
   */
  kWindowConstrainCalcOnly      = (1L << 3),

  /*
   * The most common options: don't resize the window, move the window
   * regardless of fit to the screen, require total intersection of the
   * specified window region with the screen, and do actually move the
   * window.
   */
  kWindowConstrainStandardOptions = kWindowConstrainMoveRegardlessOfFit
};

/*
 *  ConstrainWindowToScreen()
 *  
 *  Summary:
 *    Moves and resizes a window so that it's contained entirely on a
 *    single screen.
 *  
 *  Parameters:
 *    
 *    inWindowRef:
 *      The window to constrain.
 *    
 *    inRegionCode:
 *      The window region to constrain.
 *    
 *    inOptions:
 *      Flags controlling how the window is constrained.
 *    
 *    inScreenRect:
 *      A rectangle, in global coordinates, in which to constrain the
 *      window. May be NULL. If NULL, the window is constrained to the
 *      screen with the greatest intersection with the specified window
 *      region.
 *    
 *    outStructure:
 *      On exit, contains the new structure bounds of the window, in
 *      global coordinates. May be NULL.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
ConstrainWindowToScreen(
  WindowRef                inWindowRef,
  WindowRegionCode         inRegionCode,
  WindowConstrainOptions   inOptions,
  const Rect *             inScreenRect,       /* can be NULL */
  Rect *                   outStructure);      /* can be NULL */


/*
 *  GetAvailableWindowPositioningBounds()
 *  
 *  Summary:
 *    Returns the available window positioning bounds on the given
 *    screen (i.e., the screen rect minus the MenuBar and Dock if
 *    located on that screen).
 *  
 *  Parameters:
 *    
 *    inDevice:
 *      The device for which to find the available bounds.
 *    
 *    availableRect:
 *      On exit, contains the available bounds for the given device.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetAvailableWindowPositioningBounds(
  GDHandle   inDevice,
  Rect *     availableRect);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Visibility                                                                  */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
 *  HideWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
HideWindow(WindowRef window)                                  ONEWORDINLINE(0xA916);


/*
 *  [Mac]ShowWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
#if TARGET_OS_MAC
    #define MacShowWindow ShowWindow
#endif
EXTERN_API( void )
MacShowWindow(WindowRef window)                               ONEWORDINLINE(0xA915);


/*
 *  ShowHide()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
ShowHide(
  WindowRef   window,
  Boolean     showFlag)                                       ONEWORDINLINE(0xA908);



/*
 *  [Mac]IsWindowVisible()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
#if TARGET_OS_MAC
    #define MacIsWindowVisible IsWindowVisible
#endif
EXTERN_API( Boolean )
MacIsWindowVisible(WindowRef window);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( Boolean ) MacIsWindowVisible(WindowRef window) { return ((WindowPeek)window)->visible != 0; }
  #else
    #if TARGET_OS_MAC
      #define IsWindowVisible(window) (((WindowPeek)window)->visible != 0)
    #else
      #define MacIsWindowVisible(window) (((WindowPeek)window)->visible != 0)
    #endif
  #endif
#endif



/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
    • Sheets
    
    Sheets are a new user interface object in Mac OS X. A sheet is a modal alert or dialog,
    but unlike a traditional alert or dialog window (which is visually separate from the
    frontmost document window), a sheet appears to be attached to its parent window; it
    moves and z-orders simultaneously with its parent. Furthermore, sheets on Mac OS X
    use a new type of modality called window modality. A traditional alert or dialog is
    app-modal; it prevents user interaction with all other windows in the current application.
    A sheet is window-modal; it only prevents user interaction with its parent window, and
    events continue to flow to other windows in the application.
    
    • Sheet Event Handling
    
    Implementing a sheet window in your application generally requires some modifications
    to your event-handling code. A traditional app-modal window is implemented using a modal
    event loop; your application starts a new event loop (either by processing events itself,
    or by calling ModalDialog), which does not return back to your application's main event
    loop until the app-modal window has closed.
    
    Starting a new event loop doesn't work with sheets, because typically the modal event loop
    will only handle events destined for the sheet, and not events for other windows, but
    a sheet only blocks events for its parent window, and your application must still handle
    events for the rest of its windows as normal. Therefore, you will usually not use a modal
    event loop to handle events in a sheet. Rather, you will show the sheet window, and then
    return directly back to your main event loop. The Carbon Event Manager automatically 
    prevents events in the sheet's parent window from reaching it; events in your application's
    other windows are still returned to you via WaitNextEvent or your application's Carbon
    event handlers, where you can process them as normal.
    
    You have several choices for handling events in the sheet itself. A sheet is, at the most
    basic level, simply another window in your application, and you can use any of the standard
    event-handling APIs to receive events in the sheet. For example, you can:
    
        -   receive events in the sheet via WaitNextEvent, and handle them directly in your
            main event loop
            
        -   create the sheet using Dialog Manager APIs, and use IsDialogEvent and DialogSelect
            to handle events in the sheet
            
        -   install Carbon event handlers on the sheet, and respond to events in your handlers
    
    Which approach you choose is up to you.
    
    • Sheets in CarbonLib
    
    The sheet window class, sheet WDEF procIDs, and ShowSheetWindow, HideSheetWindow, and
    GetSheetWindowParent APIs are implemented in CarbonLib starting with version 1.3. However,
    since Mac OS 8 and 9 do not traditionally support a window-modal user interface, sheet
    windows are displayed as app-modal windows by CarbonLib. From your application's perspective,
    event handling for a sheet in CarbonLib is the same as event handling for a sheet on X;
    ShowSheetWindow still returns immediately, and your application should still return back
    to its main event loop and be prepared to handle events in other windows. On CarbonLib,
    your application will simply never receive an user input in any of your other windows;
    since the sheet has application modality, the Carbon Event Manager will discard events
    in any windows other than the sheet.
    
    • Creating a Sheet
    
    A sheet is just a normal window with a special window class: kSheetWindowClass or
    kSheetAlertWindowClass. As such, it can be created in any of the ways you might create
    a window: NewWindow, NewCWindow, CreateNewWindow, GetNewWindow, GetNewCWindow, 
    CreateWindowFromCollection, CreateWindowFromResource, CreateWindowFromNib, NewDialog,
    NewColorDialog, NewFeaturesDialog, or GetNewDialog.
    
    The Window Manager defines two window classes and two WDEF procIDs for sheets:
        
        -   kSheetWindowClass and kSheetAlertWindowClass
        -   kWindowSheetProc and kWindowSheetAlertProc
        
    The window classes may be used with CreateNewWindow, CreateWindowFromCollection, and
    CreateWindowFromResource; the WDEF procIDs may be used with NewWindow, NewCWindow, NewDialog,
    NewColorDialog, NewFeaturesDialog, and in 'WDEF' and 'DLOG' resources.
    
    The first release of Mac OS X only supports kSheetWindowClass and kWindowSheetProc;
    it does not support kSheetAlertWindowClass or kWindowSheetAlertProc. The latter window
    class and procID were added in CarbonLib 1.3 and will be added to a future version of
    Mac OS X. A new window class and procID were necessary for CarbonLib support because
    sheets can be used for both alerts ("Do you want to save changes before closing this
    window?") and dialogs (a Navigation Services PutFile dialog). On Mac OS X, sheet windows
    have the same appearance when used for either an alert or a dialog, but on Mac OS 8 and 9,
    alert windows have a different appearance from dialog windows. Two separate window classes
    are necessary for CarbonLib to know whether to display a sheet using a movable alert or a
    movable dialog window. Therefore, it is recommended that you use kSheetAlertWindowClass when
    creating a sheet window that will be used to display an alert, although this is not required.
    
    • Displaying a Sheet
    
    A sheet is made visible by calling the ShowSheetWindow API. This API shows the sheet,
    using whatever visual effects are appropriate for the platform, and then returns immediately.
    On Mac OS X, it creates a window group and places the sheet and its parent window into the
    group; it also marks the sheet as window-modal. On CarbonLib, it marks the sheet as app-modal
    but does not create a window group.
    
    On Mac OS X, before the sheet window is actually made visible, ShowSheetWindow sends a 
    kEventWindowDrawContent event to the sheet window, asking it to draw its content into the
    window's offscreen buffer. The sheet must handle this event, or its content area will be
    blank after the sheet becomes visible.
    
    In some cases, this handler is automatically provided for you:
    
        -   If you create your sheet window using the Dialog Manager, the Dialog Manager
            automatically installs a handler for this event that calls DrawDialog, so you
            don't need to install the handler yourself.
            
        -   If you install the standard Carbon window event handler on your sheet window
            (using kWindowStandardHandlerAttribute or InstallStandardEventHandler), the
            standard handler automatically handles this event and calls DrawControls.
            
    Typically, your event handling code (whether it uses WaitNextEvent, the Dialog Manager,
    or Carbon event handlers) will receive and respond to events in the sheet until the
    user does something that should cause the sheet to close. This might be clicking in an
    OK or Cancel button, for example. At that time, your event handling code should call
    HideSheetWindow. The sheet window will hide, but will not be destroyed, so you can use
    it again later if you want.
*/
/*
 *  ShowSheetWindow()
 *  
 *  Summary:
 *    Shows a sheet window using appropriate visual effects.
 *  
 *  Discussion:
 *    ShowSheetWindow is implemented in both CarbonLib 1.3 and Mac OS
 *    X. Since Mac OS 9 does not use a window-modal user interface for
 *    alerts and dialogs, ShowSheetWindow in CarbonLib does not bind
 *    the sheet to the parent window in the same way that it does on
 *    Mac OS X; instead, it shows the sheet like a standard
 *    movable-modal dialog window. Sheet windows must use the window
 *    classes kSheetWindowClass or kSheetAlertWindowClass to get the
 *    right appearance on both platforms.
 *  
 *  Parameters:
 *    
 *    inSheet:
 *      The sheet window to show.
 *    
 *    inParentWindow:
 *      The sheet's parent window.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
ShowSheetWindow(
  WindowRef   inSheet,
  WindowRef   inParentWindow);


/*
 *  HideSheetWindow()
 *  
 *  Summary:
 *    Hides a sheet window using appropriate visual effects.
 *  
 *  Parameters:
 *    
 *    inSheet:
 *      The sheet window to hide.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
HideSheetWindow(WindowRef inSheet);


/*
 *  GetSheetWindowParent()
 *  
 *  Summary:
 *    Returns the parent window of a sheet.
 *  
 *  Parameters:
 *    
 *    inSheet:
 *      The sheet window whose parent to retrieve.
 *    
 *    outParentWindow:
 *      On exit, contains the parent window of the sheet.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetSheetWindowParent(
  WindowRef    inSheet,
  WindowRef *  outParentWindow);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Disabling Screen Redraw                                                            */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
   disable and enable screen updates for changes to the current application’s windows
   (OS X only for now)
*/

/*
 *  DisableScreenUpdates()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
DisableScreenUpdates(void);


/*
 *  EnableScreenUpdates()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
EnableScreenUpdates(void);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Properties                                                                  */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
*/

/*
 *  GetWindowProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowProperty(
  WindowRef         window,
  PropertyCreator   propertyCreator,
  PropertyTag       propertyTag,
  UInt32            bufferSize,
  UInt32 *          actualSize,            /* can be NULL */
  void *            propertyBuffer);


/*
 *  GetWindowPropertySize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowPropertySize(
  WindowRef         window,
  PropertyCreator   creator,
  PropertyTag       tag,
  UInt32 *          size);


/*
 *  SetWindowProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
SetWindowProperty(
  WindowRef         window,
  PropertyCreator   propertyCreator,
  PropertyTag       propertyTag,
  UInt32            propertySize,
  void *            propertyBuffer);


/*
 *  RemoveWindowProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
RemoveWindowProperty(
  WindowRef         window,
  PropertyCreator   propertyCreator,
  PropertyTag       propertyTag);



/* Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward*/

enum {
  kWindowPropertyPersistent     = 0x00000001 /* whether this property gets saved when flattening the window */
};

/*
 *  GetWindowPropertyAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
GetWindowPropertyAttributes(
  WindowRef   window,
  OSType      propertyCreator,
  OSType      propertyTag,
  UInt32 *    attributes);


/*
 *  ChangeWindowPropertyAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( OSStatus )
ChangeWindowPropertyAttributes(
  WindowRef   window,
  OSType      propertyCreator,
  OSType      propertyTag,
  UInt32      attributesToSet,
  UInt32      attributesToClear);


/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Utilities                                                                          */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
 *  PinRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( long )
PinRect(
  const Rect *  theRect,
  Point         thePt)                                        ONEWORDINLINE(0xA94E);



/*
 *  GetGrayRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( RgnHandle )
GetGrayRgn(void)                                              TWOWORDINLINE(0x2EB8, 0x09EE);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Part Tracking                                                               */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
 *  TrackBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
TrackBox(
  WindowRef        window,
  Point            thePt,
  WindowPartCode   partCode)                                  ONEWORDINLINE(0xA83B);


/*
 *  TrackGoAway()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
TrackGoAway(
  WindowRef   window,
  Point       thePt)                                          ONEWORDINLINE(0xA91E);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Region Dragging                                                                    */
/*——————————————————————————————————————————————————————————————————————————————————————*/
/*
 *  DragGrayRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( long )
DragGrayRgn(
  RgnHandle        theRgn,
  Point            startPt,
  const Rect *     limitRect,
  const Rect *     slopRect,
  short            axis,
  DragGrayRgnUPP   actionProc)                                ONEWORDINLINE(0xA905);


/*
 *  DragTheRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( long )
DragTheRgn(
  RgnHandle        theRgn,
  Point            startPt,
  const Rect *     limitRect,
  const Rect *     slopRect,
  short            axis,
  DragGrayRgnUPP   actionProc)                                ONEWORDINLINE(0xA926);



/*——————————————————————————————————————————————————————————————————————————————————————*/
/*  • GetAuxWin                                                                         */
/*                                                                                      */
/*  GetAuxWin is not available in Carbon                                                */
/*——————————————————————————————————————————————————————————————————————————————————————*/
#if !OPAQUE_TOOLBOX_STRUCTS
#if CALL_NOT_IN_CARBON
/*
 *  GetAuxWin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
GetAuxWin(
  WindowRef       window,
  AuxWinHandle *  awHndl)                                     ONEWORDINLINE(0xAA42);


#endif  /* CALL_NOT_IN_CARBON */

#endif  /* !OPAQUE_TOOLBOX_STRUCTS */

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • C Glue                                                                             */
/*——————————————————————————————————————————————————————————————————————————————————————*/
#if CALL_NOT_IN_CARBON
/*
 *  setwtitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
setwtitle(
  WindowRef     window,
  const char *  title);


/*
 *  trackgoaway()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( Boolean )
trackgoaway(
  WindowRef   window,
  Point *     thePt);


/*
 *  findwindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( short )
findwindow(
  Point *      thePoint,
  WindowRef *  window);


/*
 *  getwtitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
getwtitle(
  WindowRef   window,
  char *      title);


/*
 *  growwindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( long )
growwindow(
  WindowRef     window,
  Point *       startPt,
  const Rect *  bBox);


/*
 *  newwindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( WindowRef )
newwindow(
  void *        wStorage,
  const Rect *  boundsRect,
  const char *  title,
  Boolean       visible,
  short         theProc,
  WindowRef     behind,
  Boolean       goAwayFlag,
  long          refCon);


/*
 *  newcwindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( WindowRef )
newcwindow(
  void *        wStorage,
  const Rect *  boundsRect,
  const char *  title,
  Boolean       visible,
  short         procID,
  WindowRef     behind,
  Boolean       goAwayFlag,
  long          refCon);


/*
 *  pinrect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( long )
pinrect(
  const Rect *  theRect,
  Point *       thePt);


/*
 *  trackbox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( Boolean )
trackbox(
  WindowRef   window,
  Point *     thePt,
  short       partCode);


/*
 *  draggrayrgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( long )
draggrayrgn(
  RgnHandle        theRgn,
  Point *          startPt,
  const Rect *     boundsRect,
  const Rect *     slopRect,
  short            axis,
  DragGrayRgnUPP   actionProc);


/*
 *  dragwindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
dragwindow(
  WindowRef     window,
  Point *       startPt,
  const Rect *  boundsRect);


#endif  /* CALL_NOT_IN_CARBON */

/*——————————————————————————————————————————————————————————————————————————————————————*/
/* • Window Accessors                                                                   */
/*——————————————————————————————————————————————————————————————————————————————————————*/

#if CALL_NOT_IN_CARBON
/*
 *  GetWindowGoAwayFlag()
 *  
 *  Discussion:
 *    use GetWindowAttributes in Carbon
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
GetWindowGoAwayFlag(WindowRef window);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( Boolean ) GetWindowGoAwayFlag(WindowRef window) { return ((WindowPeek)window)->goAwayFlag; }
  #else
    #define GetWindowGoAwayFlag(window) (((WindowPeek)window)->goAwayFlag)
  #endif
#endif


/*
 *  GetWindowSpareFlag()
 *  
 *  Discussion:
 *    use GetWindowAttributes in Carbon
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API( Boolean )
GetWindowSpareFlag(WindowRef window);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( Boolean ) GetWindowSpareFlag(WindowRef window) { return ((WindowPeek)window)->spareFlag; }
  #else
    #define GetWindowSpareFlag(window) (((WindowPeek)window)->spareFlag)
  #endif
#endif


#endif  /* CALL_NOT_IN_CARBON */

/*
 *  GetWindowList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( WindowRef )
GetWindowList(void);



/*
 *  GetWindowPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( CGrafPtr )
GetWindowPort(WindowRef window);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( CGrafPtr ) GetWindowPort(WindowRef window) { return (CGrafPtr)window; }
  #else
    #define GetWindowPort(window) ((CGrafPtr)window)
  #endif
#endif



/*
 *  GetWindowKind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( short )
GetWindowKind(WindowRef window);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( short ) GetWindowKind(WindowRef window) { return ((WindowPeek)window)->windowKind; }
  #else
    #define GetWindowKind(window) (((WindowPeek)window)->windowKind)
  #endif
#endif



/*
 *  IsWindowHilited()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
IsWindowHilited(WindowRef window);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( Boolean ) IsWindowHilited(WindowRef window) { return ((WindowPeek)window)->hilited != 0; }
  #else
    #define IsWindowHilited(window) (((WindowPeek)window)->hilited != 0)
  #endif
#endif



/*
 *  IsWindowUpdatePending()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Boolean )
IsWindowUpdatePending(WindowRef window);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( Boolean ) IsWindowUpdatePending(WindowRef window) { return (((WindowPeek) window)->updateRgn != NULL) && !EmptyRgn(((WindowPeek) window)->updateRgn); }
  #else
    #define IsWindowUpdatePending(window) ((((WindowPeek) window)->updateRgn != NULL) && !EmptyRgn(((WindowPeek) window)->updateRgn))
  #endif
#endif



/*
 *  [Mac]GetNextWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
#if TARGET_OS_MAC
    #define MacGetNextWindow GetNextWindow
#endif
EXTERN_API( WindowRef )
MacGetNextWindow(WindowRef window);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( WindowRef ) MacGetNextWindow(WindowRef window) { return (WindowRef)(((WindowPeek)window)->nextWindow); }
  #else
    #if TARGET_OS_MAC
      #define GetNextWindow(window) ((WindowRef)(((WindowPeek)window)->nextWindow))
    #else
      #define MacGetNextWindow(window) ((WindowRef)(((WindowPeek)window)->nextWindow))
    #endif
  #endif
#endif



/*
 *  GetWindowStandardState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Rect * )
GetWindowStandardState(
  WindowRef   window,
  Rect *      rect);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( Rect *) GetWindowStandardState(WindowRef window, Rect *rect) { return (*(rect) = ((*(((WindowPeek)window)->dataHandle) == NULL) ? *(rect) : ((Rect*)(*(((WindowPeek)window)->dataHandle)))[1])), (rect); }
  #else
    #define GetWindowStandardState(window, rect) ((*(rect) = ((*(((WindowPeek)window)->dataHandle) == NULL) ? *(rect) : ((Rect*)(*(((WindowPeek)window)->dataHandle)))[1])), (rect))
  #endif
#endif



/*
 *  GetWindowUserState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Rect * )
GetWindowUserState(
  WindowRef   window,
  Rect *      rect);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( Rect *) GetWindowUserState(WindowRef window, Rect *rect) { return (*(rect) = ((*(((WindowPeek)window)->dataHandle) == NULL) ? *(rect) : ((Rect*)(*(((WindowPeek)window)->dataHandle)))[0])), (rect); }
  #else
    #define GetWindowUserState(window, rect) ((*(rect) = ((*(((WindowPeek)window)->dataHandle) == NULL) ? *(rect) : ((Rect*)(*(((WindowPeek)window)->dataHandle)))[0])), (rect))
  #endif
#endif



/*
 *  SetWindowKind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
SetWindowKind(
  WindowRef   window,
  short       kind);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( void ) SetWindowKind(WindowRef window, short kind) { ((WindowPeek)window)->windowKind = kind; }
  #else
    #define SetWindowKind(window, kind) (((WindowPeek)window)->windowKind = kind)
  #endif
#endif



/*
 *  SetWindowStandardState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
SetWindowStandardState(
  WindowRef     window,
  const Rect *  rect);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( void ) SetWindowStandardState(WindowRef window, const Rect *rect) { Rect* stateRects = (Rect*)(*(((WindowPeek)window)->dataHandle)); if (stateRects != NULL) stateRects[1] = *rect; }
  #else
    #define SetWindowStandardState(window, rect) do { Rect* stateRects = (Rect*)(*(((WindowPeek)window)->dataHandle)); if (stateRects != NULL) stateRects[1] = *rect; } while (false)
  #endif
#endif




/*
 *  SetWindowUserState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
SetWindowUserState(
  WindowRef     window,
  const Rect *  rect);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( void ) SetWindowUserState(WindowRef window, const Rect *rect) { Rect* stateRects = (Rect*)(*(((WindowPeek)window)->dataHandle)); if (stateRects != NULL) stateRects[0] = *rect; }
  #else
    #define SetWindowUserState(window, rect) do { Rect* stateRects = (Rect*)(*(((WindowPeek)window)->dataHandle)); if (stateRects != NULL) stateRects[0] = *rect; } while (false)
  #endif
#endif



/*
 *  SetPortWindowPort()
 *  
 *  Discussion:
 *    set the current QuickDraw port to the port associated with the
 *    window
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( void )
SetPortWindowPort(WindowRef window);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( void ) SetPortWindowPort(WindowRef window) { MacSetPort((GrafPtr)window); }
  #else
    #define SetPortWindowPort(window) (MacSetPort((GrafPtr)window))
  #endif
#endif




/*
 *  GetWindowPortBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( Rect * )
GetWindowPortBounds(
  WindowRef   window,
  Rect *      bounds);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( Rect *) GetWindowPortBounds(WindowRef window, Rect *bounds) { return ((*(bounds) = (window)->portRect)), (bounds); }
  #else
    #define GetWindowPortBounds(window, bounds) (((*(bounds) = (window)->portRect)), (bounds))
  #endif
#endif



/*
 *  GetWindowFromPort()
 *  
 *  Discussion:
 *    Needed to ‘cast up’ to a WindowRef from a GrafPtr
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 */
EXTERN_API( WindowRef )
GetWindowFromPort(CGrafPtr port);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline DEFINE_API( WindowRef ) GetWindowFromPort(CGrafPtr port) { return (WindowRef)port; }
  #else
    #define GetWindowFromPort(port) ((WindowRef)port)
  #endif
#endif






/* old accessors*/

#if CALL_NOT_IN_CARBON
/*
 *  GetWindowDataHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( Handle )
GetWindowDataHandle(WindowRef window);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline Handle GetWindowDataHandle(WindowRef window) { return ((WindowPeek)window)->dataHandle; }
  #else
    #define GetWindowDataHandle(window) (((WindowPeek)window)->dataHandle)
  #endif
#endif



/*
 *  SetWindowDataHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
SetWindowDataHandle(
  WindowRef   window,
  Handle      data);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline void SetWindowDataHandle(WindowRef window, Handle data) { ((WindowPeek)window)->dataHandle = data; }
  #else
    #define SetWindowDataHandle(window, data) (((WindowPeek)window)->dataHandle = data)
  #endif
#endif



/*
 *  GetWindowZoomFlag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( Boolean )
GetWindowZoomFlag(WindowRef window);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline Boolean GetWindowZoomFlag(WindowRef window) { return ((WindowPeek)window)->spareFlag; }
  #else
    #define GetWindowZoomFlag(window) (((WindowPeek)window)->spareFlag)
  #endif
#endif



/*
 *  GetWindowStructureRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
GetWindowStructureRgn(
  WindowRef   window,
  RgnHandle   r);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline void GetWindowStructureRgn(WindowRef window, RgnHandle r) { MacCopyRgn(((WindowPeek)window)->strucRgn, r); }
  #else
    #define GetWindowStructureRgn(window, r) (MacCopyRgn(((WindowPeek)window)->strucRgn, r))
  #endif
#endif



/*
 *  GetWindowContentRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
GetWindowContentRgn(
  WindowRef   window,
  RgnHandle   r);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline void GetWindowContentRgn(WindowRef window, RgnHandle r) { MacCopyRgn(((WindowPeek)window)->contRgn, r); }
  #else
    #define GetWindowContentRgn(window, r) (MacCopyRgn(((WindowPeek)window)->contRgn, r))
  #endif
#endif



/*
 *  GetWindowUpdateRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( void )
GetWindowUpdateRgn(
  WindowRef   window,
  RgnHandle   r);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline void GetWindowUpdateRgn(WindowRef window, RgnHandle r) { MacCopyRgn(((WindowPeek)window)->updateRgn, r); }
  #else
    #define GetWindowUpdateRgn(window, r) (MacCopyRgn(((WindowPeek)window)->updateRgn, r))
  #endif
#endif



/*
 *  GetWindowTitleWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 */
EXTERN_API_C( SInt16 )
GetWindowTitleWidth(WindowRef window);
#if !OPAQUE_TOOLBOX_STRUCTS && !ACCESSOR_CALLS_ARE_FUNCTIONS
  #ifdef __cplusplus
    inline SInt16 GetWindowTitleWidth(WindowRef window) { return ((WindowPeek)window)->titleWidth; }
  #else
    #define GetWindowTitleWidth(window) (((WindowPeek)window)->titleWidth)
  #endif
#endif



/*——————————————————————————————————————————————————————————————————————————————————————————————————*/
/* Obsolete symbolic names                                                                          */
/*——————————————————————————————————————————————————————————————————————————————————————————————————*/
#endif  /* CALL_NOT_IN_CARBON */

enum {
  kWindowGroupAttrSelectable    = kWindowGroupAttrSelectAsLayer,
  kWindowGroupAttrPositionFixed = kWindowGroupAttrMoveTogether,
  kWindowGroupAttrZOrderFixed   = kWindowGroupAttrLayerTogether
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

#endif /* __MACWINDOWS__ */


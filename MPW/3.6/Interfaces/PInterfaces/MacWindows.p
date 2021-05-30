{
     File:       MacWindows.p
 
     Contains:   Window Manager Interfaces
 
     Version:    Technology: Mac OS X/CarbonLib 1.3
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1997-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MacWindows;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MACWINDOWS__}
{$SETC __MACWINDOWS__ := 1}

{$I+}
{$SETC MacWindowsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __ALIASES__}
{$I Aliases.p}
{$ENDC}
{$IFC UNDEFINED __APPLEEVENTS__}
{$I AppleEvents.p}
{$ENDC}
{$IFC UNDEFINED __COLLECTIONS__}
{$I Collections.p}
{$ENDC}
{$IFC UNDEFINED __DRAG__}
{$I Drag.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __QDOFFSCREEN__}
{$I QDOffscreen.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __TEXTCOMMON__}
{$I TextCommon.p}
{$ENDC}
{$IFC UNDEFINED __ICONS__}
{$I Icons.p}
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

{                                                                                                      }
{ Current documentation for the Mac OS Window Manager is available on the web:                         }
{  <http://developer.apple.com/techpubs/macos8/HumanInterfaceToolbox/WindowManager/windowmanager.html> }
{                                                                                                      }
{——————————————————————————————————————————————————————————————————————————————————————}
{ • Property Types                                                                     }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	PropertyCreator						= OSType;
	PropertyTag							= OSType;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Window Classes                                                                     	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	WindowClass 				= UInt32;
CONST
	kAlertWindowClass			= 1;							{  “I need your attention now.” }
	kMovableAlertWindowClass	= 2;							{  “I need your attention now, but I’m kind enough to let you switch out of this app to do other things.” }
	kModalWindowClass			= 3;							{  system modal, not draggable }
	kMovableModalWindowClass	= 4;							{  application modal, draggable }
	kFloatingWindowClass		= 5;							{  floats above all other application windows }
	kDocumentWindowClass		= 6;							{  document windows }
	kUtilityWindowClass			= 8;							{  system-wide floating windows (TSM, AppleGuide) (available in CarbonLib 1.1) }
	kHelpWindowClass			= 10;							{  help window (no frame; coachmarks, help tags ) (available in CarbonLib 1.1) }
	kSheetWindowClass			= 11;							{  sheet windows for dialogs (available in Mac OS X and CarbonLib 1.3) }
	kToolbarWindowClass			= 12;							{  toolbar windows (above documents, below floating windows) (available in CarbonLib 1.1) }
	kPlainWindowClass			= 13;							{  plain window (in document layer) }
	kOverlayWindowClass			= 14;							{  transparent window which allows 'screen' drawing via CoreGraphics (Mac OS X only) }
	kSheetAlertWindowClass		= 15;							{  sheet windows for alerts (available in Mac OS X after 1.0 and CarbonLib 1.3) }
	kAltPlainWindowClass		= 16;							{  alternate plain window (in document layer) (available in Mac OS X after 1.0 and CarbonLib 1.3) }
	kAllWindowClasses			= $FFFFFFFF;					{  for use with GetFrontWindowOfClass, FindWindowOfClass, GetNextWindowOfClass }


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Window Attributes                                                                  	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}


TYPE
	WindowAttributes					= UInt32;

CONST
	kWindowNoAttributes			= 0;							{  no attributes  }
	kWindowCloseBoxAttribute	= $00000001;					{  window has a close box  }
	kWindowHorizontalZoomAttribute = $00000002;					{  window has horizontal zoom box  }
	kWindowVerticalZoomAttribute = $00000004;					{  window has vertical zoom box  }
	kWindowFullZoomAttribute	= $00000006;
	kWindowCollapseBoxAttribute	= $00000008;					{  window has a collapse box  }
	kWindowResizableAttribute	= $00000010;					{  window is resizable  }
	kWindowSideTitlebarAttribute = $00000020;					{  window wants a titlebar on the side    (floating window class only)  }
	kWindowNoUpdatesAttribute	= $00010000;					{  this window receives no update events  }
	kWindowNoActivatesAttribute	= $00020000;					{  this window receives no activate events  }
	kWindowOpaqueForEventsAttribute = $00040000;				{  valid only for kOverlayWindowClass. Means even transparent areas get clicks. }
	kWindowNoShadowAttribute	= $00200000;					{  this window should have no shadow (X only) }
	kWindowHideOnSuspendAttribute = $01000000;					{  this window is automatically hidden on suspend and shown on resume (Carbon only)  }
																{  floating windows get kWindowHideOnSuspendAttribute automatically }
	kWindowStandardHandlerAttribute = $02000000;				{  this window should have the standard toolbox window event handler installed (Carbon only)  }
	kWindowHideOnFullScreenAttribute = $04000000;				{  this window is automatically hidden during fullscreen mode and shown afterwards (Carbon only)  }
																{  utility windows get kWindowHideOnFullScreenAttribute automatically }
	kWindowInWindowMenuAttribute = $08000000;					{  this window is automatically tracked in the window menu (Carbon only) }
	kWindowLiveResizeAttribute	= $10000000;					{  this window supports live resizing (X only) }
	kWindowStandardDocumentAttributes = $0000001F;
	kWindowStandardFloatingAttributes = $00000009;


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Window Definition Type                                                             	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	kWindowDefProcType			= 'WDEF';

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Mac OS 7.5 Window Definition Resource IDs                                          	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	kStandardWindowDefinition	= 0;							{  for document windows and dialogs }
	kRoundWindowDefinition		= 1;							{  old da-style window }
	kFloatingWindowDefinition	= 124;							{  for floating windows }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Variant Codes                                                                      	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
																{  for use with kStandardWindowDefinition  }
	kDocumentWindowVariantCode	= 0;
	kModalDialogVariantCode		= 1;
	kPlainDialogVariantCode		= 2;
	kShadowDialogVariantCode	= 3;
	kMovableModalDialogVariantCode = 5;
	kAlertVariantCode			= 7;
	kMovableAlertVariantCode	= 9;							{  for use with kFloatingWindowDefinition  }
	kSideFloaterVariantCode		= 8;


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • DefProc IDs                                                                        	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
																{  classic ids  }
	documentProc				= 0;
	dBoxProc					= 1;
	plainDBox					= 2;
	altDBoxProc					= 3;
	noGrowDocProc				= 4;
	movableDBoxProc				= 5;
	zoomDocProc					= 8;
	zoomNoGrow					= 12;							{  floating window defproc ids  }
	floatProc					= 1985;
	floatGrowProc				= 1987;
	floatZoomProc				= 1989;
	floatZoomGrowProc			= 1991;
	floatSideProc				= 1993;
	floatSideGrowProc			= 1995;
	floatSideZoomProc			= 1997;
	floatSideZoomGrowProc		= 1999;

{$IFC CALL_NOT_IN_CARBON }
	{  The rDocProc (rounded WDEF, ala calculator) is not supported in Carbon. }
	rDocProc					= 16;

{$ENDC}  {CALL_NOT_IN_CARBON}

																{  Resource IDs for theme-savvy window defprocs  }
	kWindowDocumentDefProcResID	= 64;
	kWindowDialogDefProcResID	= 65;
	kWindowUtilityDefProcResID	= 66;
	kWindowUtilitySideTitleDefProcResID = 67;
	kWindowSheetDefProcResID	= 68;
	kWindowSimpleDefProcResID	= 69;
	kWindowSheetAlertDefProcResID = 70;

																{  Proc IDs for theme-savvy windows  }
	kWindowDocumentProc			= 1024;
	kWindowGrowDocumentProc		= 1025;
	kWindowVertZoomDocumentProc	= 1026;
	kWindowVertZoomGrowDocumentProc = 1027;
	kWindowHorizZoomDocumentProc = 1028;
	kWindowHorizZoomGrowDocumentProc = 1029;
	kWindowFullZoomDocumentProc	= 1030;
	kWindowFullZoomGrowDocumentProc = 1031;


																{  Proc IDs for theme-savvy dialogs  }
	kWindowPlainDialogProc		= 1040;
	kWindowShadowDialogProc		= 1041;
	kWindowModalDialogProc		= 1042;
	kWindowMovableModalDialogProc = 1043;
	kWindowAlertProc			= 1044;
	kWindowMovableAlertProc		= 1045;


																{  procIDs available from Mac OS 8.1 (Appearance 1.0.1) forward  }
	kWindowMovableModalGrowProc	= 1046;


																{  Proc IDs for top title bar theme-savvy floating windows  }
	kWindowFloatProc			= 1057;
	kWindowFloatGrowProc		= 1059;
	kWindowFloatVertZoomProc	= 1061;
	kWindowFloatVertZoomGrowProc = 1063;
	kWindowFloatHorizZoomProc	= 1065;
	kWindowFloatHorizZoomGrowProc = 1067;
	kWindowFloatFullZoomProc	= 1069;
	kWindowFloatFullZoomGrowProc = 1071;


																{  Proc IDs for side title bar theme-savvy floating windows  }
	kWindowFloatSideProc		= 1073;
	kWindowFloatSideGrowProc	= 1075;
	kWindowFloatSideVertZoomProc = 1077;
	kWindowFloatSideVertZoomGrowProc = 1079;
	kWindowFloatSideHorizZoomProc = 1081;
	kWindowFloatSideHorizZoomGrowProc = 1083;
	kWindowFloatSideFullZoomProc = 1085;
	kWindowFloatSideFullZoomGrowProc = 1087;


																{  Proc IDs for sheet windows  }
	kWindowSheetProc			= 1088;							{  available in Mac OS X and CarbonLib 1.3  }
	kWindowSheetAlertProc		= 1120;							{  available in Mac OS X after 1.0, and CarbonLib 1.3  }



	{
	 *  Discussion:
	 *    Window defproc IDs for simple windows
	 	}
																{  Proc IDs for simple windows  }
	kWindowSimpleProc			= 1104;
	kWindowSimpleFrameProc		= 1105;


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • System 7 Window Positioning Constants                                              	}
	{	                                                                                      	}
	{	 Passed into StandardAlert and used in ‘WIND’, ‘DLOG’, and ‘ALRT’ templates           	}
	{	 StandardAlert uses zero to specify the default position. Other calls use zero to     	}
	{	 specify “no position”.  Do not pass these constants to RepositionWindow.  Do not     	}
	{	 store these constants in the BasicWindowDescription of a ‘wind’ resource.            	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	kWindowNoPosition			= $0000;
	kWindowDefaultPosition		= $0000;						{  used by StandardAlert }
	kWindowCenterMainScreen		= $280A;
	kWindowAlertPositionMainScreen = $300A;
	kWindowStaggerMainScreen	= $380A;
	kWindowCenterParentWindow	= $A80A;
	kWindowAlertPositionParentWindow = $B00A;
	kWindowStaggerParentWindow	= $B80A;
	kWindowCenterParentWindowScreen = $680A;
	kWindowAlertPositionParentWindowScreen = $700A;
	kWindowStaggerParentWindowScreen = $780A;


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Window Positioning Methods                                                         	}
	{	                                                                                      	}
	{	 Positioning methods passed to RepositionWindow.                                      	}
	{	 Do not use them in WIND, ALRT, DLOG templates.                                       	}
	{	 Do not confuse these constants with the constants above                              	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

TYPE
	WindowPositionMethod 		= UInt32;
CONST
	kWindowCenterOnMainScreen	= $00000001;
	kWindowCenterOnParentWindow	= $00000002;
	kWindowCenterOnParentWindowScreen = $00000003;
	kWindowCascadeOnMainScreen	= $00000004;
	kWindowCascadeOnParentWindow = $00000005;
	kWindowCascadeOnParentWindowScreen = $00000006;
	kWindowAlertPositionOnMainScreen = $00000007;
	kWindowAlertPositionOnParentWindow = $00000008;
	kWindowAlertPositionOnParentWindowScreen = $00000009;


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • GetWindowRegion Types                                                              	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

TYPE
	WindowRegionCode					= UInt16;

CONST
																{  Region values to pass into GetWindowRegion & GetWindowBounds  }
	kWindowTitleBarRgn			= 0;
	kWindowTitleTextRgn			= 1;
	kWindowCloseBoxRgn			= 2;
	kWindowZoomBoxRgn			= 3;
	kWindowDragRgn				= 5;
	kWindowGrowRgn				= 6;
	kWindowCollapseBoxRgn		= 7;
	kWindowTitleProxyIconRgn	= 8;							{  Mac OS 8.5 forward }
	kWindowStructureRgn			= 32;
	kWindowContentRgn			= 33;							{  Content area of the window; empty when the window is collapsed }
	kWindowUpdateRgn			= 34;							{  Carbon forward }
	kWindowOpaqueRgn			= 35;							{  Mac OS X: Area of window considered to be opaque. Only valid for windows with alpha channels. }
	kWindowGlobalPortRgn		= 40;							{  Carbon forward - bounds of the window’s port in global coordinates; not affected by CollapseWindow }

	{  GetWindowRegionRec - a pointer to this is passed in WDEF param for kWindowMsgGetRegion }

TYPE
	GetWindowRegionRecPtr = ^GetWindowRegionRec;
	GetWindowRegionRec = RECORD
		winRgn:					RgnHandle;
		regionCode:				WindowRegionCode;
	END;

	GetWindowRegionPtr					= ^GetWindowRegionRec;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • WDEF Message Types                                                                 	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{
	   SetupWindowProxyDragImageRec - setup the proxy icon drag image
	   Both regions are allocated and disposed by the Window Manager.
	   The GWorld is disposed of by the Window Manager, but the WDEF must allocate
	   it.  See Technote on Drag Manager 1.1 additions for more information and sample code for
	   setting up drag images.
	}

	SetupWindowProxyDragImageRecPtr = ^SetupWindowProxyDragImageRec;
	SetupWindowProxyDragImageRec = RECORD
		imageGWorld:			GWorldPtr;								{  locked GWorld containing the drag image - output - can be NULL }
		imageRgn:				RgnHandle;								{  image clip region, contains the portion of the image which gets blitted to screen - preallocated output - if imageGWorld is NULL, this is ignored }
		outlineRgn:				RgnHandle;								{  the outline region used on shallow monitors - preallocated output - must always be non-empty }
	END;

	{  MeasureWindowTitleRec - a pointer to this is passed in WDEF param for kWindowMsgMeasureTitle }
	MeasureWindowTitleRecPtr = ^MeasureWindowTitleRec;
	MeasureWindowTitleRec = RECORD
																		{  output parameters (filled in by the WDEF) }
		fullTitleWidth:			SInt16;									{  text + proxy icon width }
		titleTextWidth:			SInt16;									{  text width }
	END;

	{
	   GetGrowImageRegionRec - generate a region to be xored during GrowWindow and ResizeWindow.
	   This is passed along with a kWindowMsgGetGrowImageRegion message. On input, the growRect
	   parameter is the window's new bounds in global coordinates. The growImageRegion parameter
	   will be allocated and disposed automatically; the window definition should alter the 
	   region appropriately.
	}
	GetGrowImageRegionRecPtr = ^GetGrowImageRegionRec;
	GetGrowImageRegionRec = RECORD
		growRect:				Rect;
		growImageRegion:		RgnHandle;
	END;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Standard Window Kinds                                                              	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

CONST
	dialogKind					= 2;
	userKind					= 8;
	kDialogWindowKind			= 2;
	kApplicationWindowKind		= 8;


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • FindWindow Result Codes                                                            	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

TYPE
	WindowPartCode 				= SInt16;
CONST
	inDesk						= 0;
	inNoWindow					= 0;
	inMenuBar					= 1;
	inSysWindow					= 2;
	inContent					= 3;
	inDrag						= 4;
	inGrow						= 5;
	inGoAway					= 6;
	inZoomIn					= 7;
	inZoomOut					= 8;
	inCollapseBox				= 11;							{  Mac OS 8.0 forward }
	inProxyIcon					= 12;							{  Mac OS 8.5 forward }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Window Definition Hit Test Result Codes                                            	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

TYPE
	WindowDefPartCode 			= SInt16;
CONST
	wNoHit						= 0;
	wInContent					= 1;
	wInDrag						= 2;
	wInGrow						= 3;
	wInGoAway					= 4;
	wInZoomIn					= 5;
	wInZoomOut					= 6;
	wInCollapseBox				= 9;							{  Mac OS 8.0 forward }
	wInProxyIcon				= 10;							{  Mac OS 8.5 forward }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Window Definition Messages                                                         	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	kWindowMsgDraw				= 0;
	kWindowMsgHitTest			= 1;
	kWindowMsgCalculateShape	= 2;
	kWindowMsgInitialize		= 3;
	kWindowMsgCleanUp			= 4;
	kWindowMsgDrawGrowOutline	= 5;
	kWindowMsgDrawGrowBox		= 6;

	{  Messages available from Mac OS 8.0 forward }
	kWindowMsgGetFeatures		= 7;
	kWindowMsgGetRegion			= 8;

	{  Messages available from Mac OS 8.5 forward }
	kWindowMsgDragHilite		= 9;							{  parameter boolean indicating on or off }
	kWindowMsgModified			= 10;							{  parameter boolean indicating saved (false) or modified (true) }
	kWindowMsgDrawInCurrentPort	= 11;							{  same as kWindowMsgDraw, but must draw in current port }
	kWindowMsgSetupProxyDragImage = 12;							{  parameter pointer to SetupWindowProxyDragImageRec }
	kWindowMsgStateChanged		= 13;							{  something about the window's state has changed }
	kWindowMsgMeasureTitle		= 14;							{  measure and return the ideal title width }

	{  Messages only available in Carbon }
	kWindowMsgGetGrowImageRegion = 19;							{  get region to xor during grow/resize. parameter pointer to GetGrowImageRegionRec. }

	{  old names }
	wDraw						= 0;
	wHit						= 1;
	wCalcRgns					= 2;
	wNew						= 3;
	wDispose					= 4;
	wGrow						= 5;
	wDrawGIcon					= 6;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • State-changed Flags for kWindowMsgStateChanged                                     	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	kWindowStateTitleChanged	= $01;


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Window Feature Bits                                                                	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	kWindowCanGrow				= $01;
	kWindowCanZoom				= $02;
	kWindowCanCollapse			= $04;
	kWindowIsModal				= $08;
	kWindowCanGetWindowRegion	= $10;
	kWindowIsAlert				= $20;
	kWindowHasTitleBar			= $40;

	{  Feature bits available from Mac OS 8.5 forward }
	kWindowSupportsDragHilite	= $80;							{  window definition supports kWindowMsgDragHilite }
	kWindowSupportsModifiedBit	= $0100;						{  window definition supports kWindowMsgModified }
	kWindowCanDrawInCurrentPort	= $0200;						{  window definition supports kWindowMsgDrawInCurrentPort }
	kWindowCanSetupProxyDragImage = $0400;						{  window definition supports kWindowMsgSetupProxyDragImage }
	kWindowCanMeasureTitle		= $0800;						{  window definition supports kWindowMsgMeasureTitle }
	kWindowWantsDisposeAtProcessDeath = $1000;					{  window definition wants a Dispose message for windows still extant during ExitToShell }
	kWindowSupportsGetGrowImageRegion = $2000;					{  window definition will calculate the grow image region manually. }
	kWindowDefSupportsColorGrafPort = $40000002;

	{  Feature bits for post MacOS 10.0 }
	kWindowIsOpaque				= $4000;						{  Window doesn't need an alpha channel. Saves memory. }

	{
	   THIS CONSTANT IS GOING AWAY. IT IS NAMED INCORRECTLY. USE THE GETGROWIMAGE CONSTANT ABOVE INSTEAD.
	   DO YOU HEAR ME! AM I YELLING LOUD ENOUGH?!
	}
	kWindowSupportsSetGrowImageRegion = $2000;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Desktop Pattern Resource ID                                                        	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	deskPatID					= 16;



	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Window Color Part Codes                                                            	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	wContentColor				= 0;
	wFrameColor					= 1;
	wTextColor					= 2;
	wHiliteColor				= 3;
	wTitleBarColor				= 4;


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Region Dragging Constants                                                         	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	kMouseUpOutOfSlop			= $80008000;


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Window Color Table                                                                 	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

TYPE
	WinCTabPtr = ^WinCTab;
	WinCTab = RECORD
		wCSeed:					LONGINT;								{  reserved  }
		wCReserved:				INTEGER;								{  reserved  }
		ctSize:					INTEGER;								{  usually 4 for windows  }
		ctTable:				ARRAY [0..4] OF ColorSpec;
	END;

	WCTabPtr							= ^WinCTab;
	WCTabHandle							= ^WCTabPtr;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • WindowRecord                                                                       	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	WindowRecordPtr = ^WindowRecord;
	WindowPeek							= ^WindowRecord;
	WindowRecord = RECORD
		port:					GrafPort;								{  in Carbon use GetWindowPort }
		windowKind:				INTEGER;								{  in Carbon use Get/SetWindowKind }
		visible:				BOOLEAN;								{  in Carbon use Hide/ShowWindow, ShowHide, IsWindowVisible }
		hilited:				BOOLEAN;								{  in Carbon use HiliteWindow, IsWindowHilited }
		goAwayFlag:				BOOLEAN;								{  in Carbon use ChangeWindowAttributes }
		spareFlag:				BOOLEAN;								{  in Carbon use ChangeWindowAttributes }
		strucRgn:				RgnHandle;								{  in Carbon use GetWindowRegion }
		contRgn:				RgnHandle;								{  in Carbon use GetWindowRegion }
		updateRgn:				RgnHandle;								{  in Carbon use GetWindowRegion }
		windowDefProc:			Handle;									{  not supported in Carbon  }
		dataHandle:				Handle;									{  not supported in Carbon  }
		titleHandle:			StringHandle;							{  in Carbon use Get/SetWTitle  }
		titleWidth:				INTEGER;								{  in Carbon use GetWindowRegion  }
		controlList:			Handle;									{  in Carbon use GetRootControl  }
		nextWindow:				WindowPeek;								{  in Carbon use GetNextWindow  }
		windowPic:				PicHandle;								{  in Carbon use Get/SetWindowPic  }
		refCon:					LONGINT;								{  in Carbon use Get/SetWRefCon }
	END;

{$ENDC}

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Color WindowRecord                                                                 	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	CWindowRecordPtr = ^CWindowRecord;
	CWindowPeek							= ^CWindowRecord;
	CWindowRecord = RECORD
		port:					CGrafPort;								{  in Carbon use GetWindowPort }
		windowKind:				INTEGER;								{  in Carbon use Get/SetWindowKind     }
		visible:				BOOLEAN;								{  in Carbon use Hide/ShowWindow, ShowHide, IsWindowVisible      }
		hilited:				BOOLEAN;								{  in Carbon use HiliteWindow, IsWindowHilited }
		goAwayFlag:				BOOLEAN;								{  in Carbon use ChangeWindowAttributes    }
		spareFlag:				BOOLEAN;								{  in Carbon use ChangeWindowAttributes    }
		strucRgn:				RgnHandle;								{  in Carbon use GetWindowRegion   }
		contRgn:				RgnHandle;								{  in Carbon use GetWindowRegion   }
		updateRgn:				RgnHandle;								{  in Carbon use GetWindowRegion   }
		windowDefProc:			Handle;									{  not supported in Carbon  }
		dataHandle:				Handle;									{  not supported in Carbon  }
		titleHandle:			StringHandle;							{  in Carbon use Get/SetWTitle  }
		titleWidth:				INTEGER;								{  in Carbon use GetWindowRegion  }
		controlList:			Handle;									{  in Carbon use GetRootControl  }
		nextWindow:				CWindowPeek;							{  in Carbon use GetNextWindow  }
		windowPic:				PicHandle;								{  in Carbon use Get/SetWindowPic      }
		refCon:					LONGINT;								{  in Carbon use Get/SetWRefCon       }
	END;

{$ENDC}

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • AuxWinHandle                                                                       	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
	AuxWinRecPtr = ^AuxWinRec;
	AuxWinPtr							= ^AuxWinRec;
	AuxWinHandle						= ^AuxWinPtr;
	AuxWinRec = RECORD
		awNext:					AuxWinHandle;							{  handle to next AuxWinRec, not supported in Carbon }
		awOwner:				WindowRef;								{  not supported in Carbon }
		awCTable:				CTabHandle;								{  color table for this window, use  Get/SetWindowContentColor in Carbon }
		reserved:				Handle;									{  not supported in Carbon }
		awFlags:				LONGINT;								{  reserved for expansion, not supported in Carbon }
		awReserved:				CTabHandle;								{  reserved for expansion, not supported in Carbon }
		awRefCon:				LONGINT;								{  user constant, in Carbon use Get/SetWindowProperty if you need more refCons }
	END;

{$ENDC}

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • BasicWindowDescription                                                            	}
	{	                                                                                      	}
	{	  Contains statically-sized basic attributes of the window, for storage in a          	}
	{	  collection item.                                                                    	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{  constants for the version field }

CONST
	kWindowDefinitionVersionOne	= 1;
	kWindowDefinitionVersionTwo	= 2;

	{  constants for the stateflags bit field  }
	kWindowIsCollapsedState		= $01;


TYPE
	BasicWindowDescriptionPtr = ^BasicWindowDescription;
	BasicWindowDescription = RECORD
		descriptionSize:		UInt32;									{  sizeof(BasicWindowDescription) }
		windowContentRect:		Rect;									{  location on screen }
		windowZoomRect:			Rect;									{  location on screen when zoomed out }
		windowRefCon:			UInt32;									{  the refcon - __avoid saving stale pointers here__   }
		windowStateFlags:		UInt32;									{  window state bit flags }
		windowPositionMethod:	WindowPositionMethod;					{  method last used by RepositionWindow to position the window (if any) }
		windowDefinitionVersion: UInt32;
		CASE INTEGER OF
		0: (
			windowDefProc:		SInt16;									{  defProc and variant }
			windowHasCloseBox:	BOOLEAN;
		   );
		1: (
			windowClass:		WindowClass;							{  the class }
			windowAttributes:	WindowAttributes;						{  the attributes }
		   );
	END;

	{   the window manager stores the default collection items using these IDs }

CONST
	kStoredWindowSystemTag		= 'appl';						{  Only Apple collection items will be of this tag }
	kStoredBasicWindowDescriptionID = 'sbas';					{  BasicWindowDescription }
	kStoredWindowPascalTitleID	= 's255';						{  pascal title string }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Window Class Ordering                                                              	}
	{	                                                                                      	}
	{	  Special cases for the “behind” parameter in window creation calls.                  	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	kFirstWindowOfClass			= -1;
	kLastWindowOfClass			= 0;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Zoom Information Handle                                                            	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

TYPE
	WStateDataPtr = ^WStateData;
	WStateData = RECORD
		userState:				Rect;									{ user zoom state }
		stdState:				Rect;									{ standard zoom state }
	END;

	WStateDataHandle					= ^WStateDataPtr;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • MixedMode & ProcPtrs                                                               	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
{$IFC TYPED_FUNCTION_POINTERS}
	WindowDefProcPtr = FUNCTION(varCode: INTEGER; window: WindowRef; message: INTEGER; param: LONGINT): LONGINT;
{$ELSEC}
	WindowDefProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	DeskHookProcPtr = PROCEDURE(mouseClick: BOOLEAN; VAR theEvent: EventRecord);
{$ELSEC}
	DeskHookProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	WindowPaintProcPtr = FUNCTION(device: GDHandle; qdContext: GrafPtr; window: WindowRef; inClientPaintRgn: RgnHandle; outSystemPaintRgn: RgnHandle; refCon: UNIV Ptr): OSStatus;
{$ELSEC}
	WindowPaintProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	WindowDefUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	WindowDefUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DeskHookUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DeskHookUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	WindowPaintUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	WindowPaintUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppWindowDefProcInfo = $00003BB0;
	uppDeskHookProcInfo = $00130802;
	uppWindowPaintProcInfo = $0003FFF0;
	{
	 *  NewWindowDefUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewWindowDefUPP(userRoutine: WindowDefProcPtr): WindowDefUPP; { old name was NewWindowDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  NewDeskHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION NewDeskHookUPP(userRoutine: DeskHookProcPtr): DeskHookUPP; { old name was NewDeskHookProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  NewWindowPaintUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewWindowPaintUPP(userRoutine: WindowPaintProcPtr): WindowPaintUPP; { old name was NewWindowPaintProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeWindowDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeWindowDefUPP(userUPP: WindowDefUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  DisposeDeskHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeDeskHookUPP(userUPP: DeskHookUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  DisposeWindowPaintUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeWindowPaintUPP(userUPP: WindowPaintUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeWindowDefUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeWindowDefUPP(varCode: INTEGER; window: WindowRef; message: INTEGER; param: LONGINT; userRoutine: WindowDefUPP): LONGINT; { old name was CallWindowDefProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  InvokeDeskHookUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvokeDeskHookUPP(mouseClick: BOOLEAN; VAR theEvent: EventRecord; userRoutine: DeskHookUPP); { old name was CallDeskHookProc }
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  InvokeWindowPaintUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeWindowPaintUPP(device: GDHandle; qdContext: GrafPtr; window: WindowRef; inClientPaintRgn: RgnHandle; outSystemPaintRgn: RgnHandle; refCon: UNIV Ptr; userRoutine: WindowPaintUPP): OSStatus; { old name was CallWindowPaintProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Definition Spec.  Used in Carbon to specify the code that defines a window. }
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	kWindowDefProcPtr			= 0;							{  raw proc-ptr based access }
	kWindowDefObjectClass		= 1;							{  event-based definition (Carbon 1.1 or later) }
	kWindowDefProcID			= 2;							{  explicit proc ID; overrides the window class default proc ID }


TYPE
	WindowDefType						= UInt32;
	WindowDefSpecPtr = ^WindowDefSpec;
	WindowDefSpec = RECORD
		defType:				WindowDefType;
		CASE INTEGER OF
		0: (
			defProc:			WindowDefUPP;
			);
		1: (
			classRef:			Ptr;
			);
		2: (
			procID:				INTEGER;
			);
	END;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Window Creation & Persistence                                                      	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{
	 *  GetNewCWindow()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION GetNewCWindow(windowID: INTEGER; wStorage: UNIV Ptr; behind: WindowRef): WindowRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA46;
	{$ENDC}

{
 *  NewWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewWindow(wStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; theProc: INTEGER; behind: WindowRef; goAwayFlag: BOOLEAN; refCon: LONGINT): WindowRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A913;
	{$ENDC}

{
 *  GetNewWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetNewWindow(windowID: INTEGER; wStorage: UNIV Ptr; behind: WindowRef): WindowRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9BD;
	{$ENDC}

{
 *  NewCWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewCWindow(wStorage: UNIV Ptr; {CONST}VAR boundsRect: Rect; title: Str255; visible: BOOLEAN; procID: INTEGER; behind: WindowRef; goAwayFlag: BOOLEAN; refCon: LONGINT): WindowRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA45;
	{$ENDC}

{
 *  DisposeWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeWindow(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A914;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  [Mac]CloseWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE CloseWindow(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92D;
	{$ENDC}


{
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  CreateNewWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateNewWindow(windowClass: WindowClass; attributes: WindowAttributes; {CONST}VAR contentBounds: Rect; VAR outWindow: WindowRef): OSStatus;

{  Routines available from Mac OS 8.5 forward }

{  Create a window from a ‘wind’ resource }
{
 *  CreateWindowFromResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateWindowFromResource(resID: SInt16; VAR outWindow: WindowRef): OSStatus;

{  window persistence }
{
 *  StoreWindowIntoCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION StoreWindowIntoCollection(window: WindowRef; collection: Collection): OSStatus;

{
 *  CreateWindowFromCollection()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateWindowFromCollection(collection: Collection; VAR outWindow: WindowRef): OSStatus;

{  window refcounting }
{
 *  GetWindowOwnerCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowOwnerCount(window: WindowRef; VAR outCount: UInt32): OSStatus;

{
 *  CloneWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CloneWindow(window: WindowRef): OSStatus;

{
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
 }
FUNCTION GetWindowRetainCount(inWindow: WindowRef): ItemCount;

{
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
 }
FUNCTION RetainWindow(inWindow: WindowRef): OSStatus;

{
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
 }
FUNCTION ReleaseWindow(inWindow: WindowRef): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Custom Windows                                                                     }
{——————————————————————————————————————————————————————————————————————————————————————}
{  Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward }

{
 *  CreateCustomWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateCustomWindow({CONST}VAR def: WindowDefSpec; windowClass: WindowClass; attributes: WindowAttributes; {CONST}VAR contentBounds: Rect; VAR outWindow: WindowRef): OSStatus;

{
 *  ReshapeCustomWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ReshapeCustomWindow(window: WindowRef): OSStatus;

{
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
 }
FUNCTION RegisterWindowDefinition(inResID: SInt16; {CONST}VAR inDefSpec: WindowDefSpec): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window part tracking                                                               }
{——————————————————————————————————————————————————————————————————————————————————————}
{
   Routines available from Mac OS 8.5 forward
        (or from Mac OS 8.6 forward when linking to CarbonLib 1.1 forward)
}


{
 *  GetWindowWidgetHilite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowWidgetHilite(inWindow: WindowRef; VAR outHilite: WindowDefPartCode): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Metainformation Accessors                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}
{
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}
{
 *  GetWindowClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowClass(window: WindowRef; VAR outClass: WindowClass): OSStatus;

{
 *  GetWindowAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowAttributes(window: WindowRef; VAR outAttributes: WindowAttributes): OSStatus;

{
   Routines available from Mac OS 9.0 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}
{
 *  ChangeWindowAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ChangeWindowAttributes(window: WindowRef; setTheseAttributes: WindowAttributes; clearTheseAttributes: WindowAttributes): OSStatus;

{
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
}
{
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
 }
FUNCTION SetWindowClass(inWindow: WindowRef; inWindowClass: WindowClass): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{  • Window Modality                                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}

{
 *  WindowModality
 *  
 }

TYPE
	WindowModality 				= UInt32;
CONST
	kWindowModalityNone			= 0;
	kWindowModalitySystemModal	= 1;
	kWindowModalityAppModal		= 2;
	kWindowModalityWindowModal	= 3;


	{
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
	 	}
FUNCTION SetWindowModality(inWindow: WindowRef; inModalKind: WindowModality; inUnavailableWindow: WindowRef): OSStatus;

{
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
 }
FUNCTION GetWindowModality(inWindow: WindowRef; VAR outModalKind: WindowModality; VAR outUnavailableWindow: WindowRef): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Floating Windows                                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}
{
   Routines available from Mac OS 8.6 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}

{
 *  ShowFloatingWindows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ShowFloatingWindows: OSStatus;

{
 *  HideFloatingWindows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HideFloatingWindows: OSStatus;

{
 *  AreFloatingWindowsVisible()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AreFloatingWindowsVisible: BOOLEAN;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Groups                                                                      }
{                                                                                      }
{ The Window Group API allows the creation and management of groups of windows,        }
{ allowing control of the z-order, activation, and positioning of the windows.         }
{ Internally to the Window Manager, each of the standard window tiers (document,       }
{ toolbar, floating, modal, utility, help, and overlay) is implemented as a window     }
{ group; you can access the window group for a class with GetWindowGroupOfClass.       }
{ You can create your own window groups, if you would like your windows to float,      }
{ for example, above the floating window layer but below the modal layer. It is        }
{ also possible to create more complex hierarchical arrangements of window groups.     }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	WindowGroupRef    = ^LONGINT; { an opaque 32-bit type }
	WindowGroupRefPtr = ^WindowGroupRef;  { when a VAR xx:WindowGroupRef parameter can be nil, it is changed to xx: WindowGroupRefPtr }

CONST
	windowGroupInvalidErr		= -5616;						{  WindowGroup is invalid  }

	{  may be passed as the "behindWindow" parameter to NewCWindow and SendBehind }
	kFirstWindowOfGroup			= -1;
{$IFC NOT UNDEFINED MWERKS}
	kLastWindowOfGroup			= nil;
{$ENDC}
	{  may be passed as the "behindGroup" parameter to SendWindowGroupBehind }
	kFirstWindowGroup			= -1;
{$IFC NOT UNDEFINED MWERKS}
	kLastWindowGroup			= nil;
{$ENDC}

	{
	 *  WindowGroupAttributes
	 *  
	 *  Summary:
	 *    These are attributes that may be applied to a window group.
	 	}

TYPE
	WindowGroupAttributes 		= UInt32;
CONST
	kWindowGroupAttrSelectAsLayer = $01;
	kWindowGroupAttrMoveTogether = $02;
	kWindowGroupAttrLayerTogether = $04;
	kWindowGroupAttrSharedActivation = $08;
	kWindowGroupAttrHideOnCollapse = $10;


	{
	 *  WindowActivationScope
	 *  
	 *  Discussion:
	 *    Every window has a WindowActivationScope. It defines how windows
	 *    are activated by the Window Manager with respect to other windows
	 *    in the window’s group and in the current process.
	 	}

TYPE
	WindowActivationScope 		= UInt32;
CONST
	kWindowActivationScopeNone	= 0;
	kWindowActivationScopeIndependent = 1;
	kWindowActivationScopeAll	= 2;


	{
	 *  Summary:
	 *    These are constants that can be used for the inNextGroup
	 *    parameter to GetSiblingWindowGroup.
	 	}
	kNextWindowGroup			= true;
	kPreviousWindowGroup		= false;


	{
	 *  WindowGroupContentOptions
	 *  
	 *  Discussion:
	 *    Window group contents options are used to control what group
	 *    content is counted or returned by the CountWindowGroupContents
	 *    and GetWindowGroupContents APIs.
	 	}

TYPE
	WindowGroupContentOptions 	= UInt32;
CONST
	kWindowGroupContentsReturnWindows = $01;
	kWindowGroupContentsRecurse	= $02;
	kWindowGroupContentsVisible	= $04;


	{	----------------------------------------------------------------------------------	}
	{	  • Group creation, destruction, and refcounting                                  	}
	{	----------------------------------------------------------------------------------	}
	{
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
	 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateWindowGroup(inAttributes: WindowGroupAttributes; VAR outGroup: WindowGroupRef): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RetainWindowGroup(inGroup: WindowGroupRef): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ReleaseWindowGroup(inGroup: WindowGroupRef): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X after version 10.0
 *    Mac OS X:         in after version 10.0
 }
FUNCTION GetWindowGroupRetainCount(inGroup: WindowGroupRef): ItemCount; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowGroupOfClass(windowClass: WindowClass): WindowGroupRef; C;


{----------------------------------------------------------------------------------}
{  • Group name, attributes, and level                                             }
{----------------------------------------------------------------------------------}
{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowGroupName(inGroup: WindowGroupRef; inName: CFStringRef): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CopyWindowGroupName(inGroup: WindowGroupRef; VAR outName: CFStringRef): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowGroupAttributes(inGroup: WindowGroupRef; VAR outAttributes: WindowGroupAttributes): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ChangeWindowGroupAttributes(inGroup: WindowGroupRef; setTheseAttributes: WindowGroupAttributes; clearTheseAttributes: WindowGroupAttributes): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowGroupLevel(inGroup: WindowGroupRef; inLevel: SInt32): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowGroupLevel(inGroup: WindowGroupRef; VAR outLevel: SInt32): OSStatus; C;


{----------------------------------------------------------------------------------}
{  • Group z-ordering                                                              }
{----------------------------------------------------------------------------------}
{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SendWindowGroupBehind(inGroup: WindowGroupRef; behindGroup: WindowGroupRef): OSStatus; C;

{----------------------------------------------------------------------------------}
{  • Group containment hierarchy manipulation                                      }
{----------------------------------------------------------------------------------}
{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowGroup(inWindow: WindowRef): WindowGroupRef; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowGroup(inWindow: WindowRef; inNewGroup: WindowGroupRef): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsWindowContainedInGroup(inWindow: WindowRef; inGroup: WindowGroupRef): BOOLEAN; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowGroupParent(inGroup: WindowGroupRef): WindowGroupRef; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowGroupParent(inGroup: WindowGroupRef; inNewGroup: WindowGroupRef): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowGroupSibling(inGroup: WindowGroupRef; inNextGroup: BOOLEAN): WindowGroupRef; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowGroupOwner(inGroup: WindowGroupRef): WindowRef; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowGroupOwner(inGroup: WindowGroupRef; inWindow: WindowRef): OSStatus; C;


{----------------------------------------------------------------------------------}
{  • Inspection of group contents                                                  }
{----------------------------------------------------------------------------------}

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CountWindowGroupContents(inGroup: WindowGroupRef; inOptions: WindowGroupContentOptions): ItemCount; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowGroupContents(inGroup: WindowGroupRef; inOptions: WindowGroupContentOptions; inAllowedItems: ItemCount; VAR outNumItems: ItemCount; VAR outItems: UNIV Ptr): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIndexedWindow(inGroup: WindowGroupRef; inIndex: UInt32; inOptions: WindowGroupContentOptions; VAR outWindow: WindowRef): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowIndex(inWindow: WindowRef; inStartGroup: WindowGroupRef; inOptions: WindowGroupContentOptions; VAR outIndex: UInt32): OSStatus; C;


{----------------------------------------------------------------------------------}
{  • Window activation                                                             }
{----------------------------------------------------------------------------------}
{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ActiveNonFloatingWindow: WindowRef; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsWindowActive(inWindow: WindowRef): BOOLEAN; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ActivateWindow(inWindow: WindowRef; inActivate: BOOLEAN): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowActivationScope(inWindow: WindowRef; VAR outScope: WindowActivationScope): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowActivationScope(inWindow: WindowRef; inScope: WindowActivationScope): OSStatus; C;


{----------------------------------------------------------------------------------}
{  • Debugging Utilities                                                           }
{----------------------------------------------------------------------------------}
{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DebugPrintWindowGroup(inGroup: WindowGroupRef); C;

{
 *  DebugPrintAllWindowGroups()
 *  
 *  Summary:
 *    Prints the full window group hierarchy, starting at the root
 *    group.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DebugPrintAllWindowGroups; C;



{——————————————————————————————————————————————————————————————————————————————————————}
{ • Background Image                                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}
{  SetWinColor is not available in Carbon. }
{$IFC CALL_NOT_IN_CARBON }
{
 *  SetWinColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetWinColor(window: WindowRef; newColorTable: WCTabHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA41;
	{$ENDC}

{  SetDeskCPat is not available in Carbon. }
{
 *  SetDeskCPat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetDeskCPat(deskPixPat: PixPatHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA47;
	{$ENDC}

{
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  SetWindowContentColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowContentColor(window: WindowRef; {CONST}VAR color: RGBColor): OSStatus;

{
 *  GetWindowContentColor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowContentColor(window: WindowRef; VAR color: RGBColor): OSStatus;

{  Routines available from Mac OS 8.5 forward }
{
 *  GetWindowContentPattern()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowContentPattern(window: WindowRef; outPixPat: PixPatHandle): OSStatus;

{
 *  SetWindowContentPattern()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowContentPattern(window: WindowRef; pixPat: PixPatHandle): OSStatus;

{  Routines available from Mac OS 9.0 forward }

TYPE
	WindowPaintProcOptions				= OptionBits;

CONST
	kWindowPaintProcOptionsNone	= 0;

	{
	 *  InstallWindowContentPaintProc()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in WindowsLib 9.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION InstallWindowContentPaintProc(window: WindowRef; paintProc: WindowPaintUPP; options: WindowPaintProcOptions; refCon: UNIV Ptr): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Scrolling Routines                                                                 }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	ScrollWindowOptions 		= UInt32;
CONST
	kScrollWindowNoOptions		= 0;
	kScrollWindowInvalidate		= $00000001;					{  add the exposed area to the window’s update region }
	kScrollWindowEraseToPortBackground = $00000002;				{  erase the exposed area using the background color/pattern of the window’s grafport }


	{  Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward }

	{
	 *  ScrollWindowRect()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION ScrollWindowRect(inWindow: WindowRef; {CONST}VAR inScrollRect: Rect; inHPixels: SInt16; inVPixels: SInt16; inOptions: ScrollWindowOptions; outExposedRgn: RgnHandle): OSStatus;

{
 *  ScrollWindowRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ScrollWindowRegion(inWindow: WindowRef; inScrollRgn: RgnHandle; inHPixels: SInt16; inVPixels: SInt16; inOptions: ScrollWindowOptions; outExposedRgn: RgnHandle): OSStatus;



{——————————————————————————————————————————————————————————————————————————————————————}
{ • Low-Level Region & Painting Routines                                               }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  ClipAbove()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ClipAbove(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90B;
	{$ENDC}

{  SaveOld/DrawNew are not available in Carbon.  Use ReshapeCustomWindow instead. }
{$IFC CALL_NOT_IN_CARBON }
{
 *  SaveOld()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SaveOld(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90E;
	{$ENDC}

{
 *  DrawNew()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DrawNew(window: WindowRef; update: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90F;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  PaintOne()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PaintOne(window: WindowRef; clobberedRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90C;
	{$ENDC}

{
 *  PaintBehind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PaintBehind(startWindow: WindowRef; clobberedRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90D;
	{$ENDC}

{
 *  CalcVis()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CalcVis(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A909;
	{$ENDC}

{
 *  CalcVisBehind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE CalcVisBehind(startWindow: WindowRef; clobberedRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A90A;
	{$ENDC}

{
 *  CheckUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CheckUpdate(VAR theEvent: EventRecord): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A911;
	{$ENDC}


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window List                                                                        }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  [Mac]FindWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FindWindow(thePoint: Point; VAR window: WindowRef): WindowPartCode;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92C;
	{$ENDC}

{
 *  FrontWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FrontWindow: WindowRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A924;
	{$ENDC}

{
 *  BringToFront()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE BringToFront(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A920;
	{$ENDC}

{
 *  SendBehind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SendBehind(window: WindowRef; behindWindow: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A921;
	{$ENDC}

{
 *  SelectWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SelectWindow(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91F;
	{$ENDC}

{
   Routines available from Mac OS 8.6 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}

{
 *  FrontNonFloatingWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FrontNonFloatingWindow: WindowRef;

{  Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward }

{
 *  GetNextWindowOfClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetNextWindowOfClass(inWindow: WindowRef; inWindowClass: WindowClass; mustBeVisible: BOOLEAN): WindowRef;

{
 *  GetFrontWindowOfClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetFrontWindowOfClass(inWindowClass: WindowClass; mustBeVisible: BOOLEAN): WindowRef;

{
 *  FindWindowOfClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FindWindowOfClass({CONST}VAR where: Point; inWindowClass: WindowClass; VAR outWindow: WindowRef; VAR outWindowPart: WindowPartCode): OSStatus;


{  Carbon only }
{
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
 }
FUNCTION CreateStandardWindowMenu(inOptions: OptionBits; VAR outMenu: MenuRef): OSStatus;

{
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
 }
FUNCTION SetWindowAlternateTitle(inWindow: WindowRef; inTitle: CFStringRef): OSStatus;

{
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
 }
FUNCTION CopyWindowAlternateTitle(inWindow: WindowRef; VAR outTitle: CFStringRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Misc Low-Level stuff                                                               }
{——————————————————————————————————————————————————————————————————————————————————————}
{$IFC CALL_NOT_IN_CARBON }
{
 *  InitWindows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InitWindows;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A912;
	{$ENDC}

{  The window manager port does not exist in Carbon.   }
{  We are investigating replacement technologies.      }
{
 *  GetWMgrPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetWMgrPort(VAR wPort: GrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A910;
	{$ENDC}

{
 *  GetCWMgrPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetCWMgrPort(VAR wMgrCPort: CGrafPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA48;
	{$ENDC}

{
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  IsValidWindowPtr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsValidWindowPtr(possibleWindow: WindowRef): BOOLEAN;

{
   Routines available from Mac OS 8.6 forward
   InitFloatingWindows is not available in Carbon;
   window ordering is always active for Carbon clients
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  InitFloatingWindows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InitFloatingWindows: OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Various & Sundry Window Accessors                                                  }
{——————————————————————————————————————————————————————————————————————————————————————}
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  HiliteWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HiliteWindow(window: WindowRef; fHilite: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91C;
	{$ENDC}

{
 *  SetWRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetWRefCon(window: WindowRef; data: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A918;
	{$ENDC}

{
 *  GetWRefCon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWRefCon(window: WindowRef): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A917;
	{$ENDC}

{
 *  SetWindowPic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetWindowPic(window: WindowRef; pic: PicHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92E;
	{$ENDC}

{
 *  GetWindowPic()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowPic(window: WindowRef): PicHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92F;
	{$ENDC}

{
 *  GetWVariant()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWVariant(window: WindowRef): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A80A;
	{$ENDC}

{  Routines available from Mac OS 8.0 (Appearance 1.0) forward }
{
 *  GetWindowFeatures()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowFeatures(window: WindowRef; VAR outFeatures: UInt32): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0013, $AA74;
	{$ENDC}

{
 *  GetWindowRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowRegion(window: WindowRef; inRegionCode: WindowRegionCode; ioWinRgn: RgnHandle): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0014, $AA74;
	{$ENDC}

{
 *  GetWindowStructureWidths()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowStructureWidths(inWindow: WindowRef; VAR outRect: Rect): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Update Events                                                                      }
{——————————————————————————————————————————————————————————————————————————————————————}
{
   These aren't present in Carbon. Please use the InvalWindowRect, etc. routines
   below instead.
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  InvalRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvalRect({CONST}VAR badRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A928;
	{$ENDC}

{
 *  InvalRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE InvalRgn(badRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A927;
	{$ENDC}

{
 *  ValidRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ValidRect({CONST}VAR goodRect: Rect);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92A;
	{$ENDC}

{
 *  ValidRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE ValidRgn(goodRgn: RgnHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A929;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  BeginUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE BeginUpdate(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A922;
	{$ENDC}

{
 *  EndUpdate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE EndUpdate(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A923;
	{$ENDC}

{
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}

{
 *  InvalWindowRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvalWindowRgn(window: WindowRef; region: RgnHandle): OSStatus;

{
 *  InvalWindowRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvalWindowRect(window: WindowRef; {CONST}VAR bounds: Rect): OSStatus;

{
 *  ValidWindowRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ValidWindowRgn(window: WindowRef; region: RgnHandle): OSStatus;

{
 *  ValidWindowRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ValidWindowRect(window: WindowRef; {CONST}VAR bounds: Rect): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • DrawGrowIcon                                                                       }
{                                                                                      }
{  DrawGrowIcon is deprecated from Mac OS 8.0 forward.  Theme-savvy window defprocs    }
{  include the grow box in the window frame.                                           }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  DrawGrowIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DrawGrowIcon(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A904;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Titles                                                                      }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  SetWTitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetWTitle(window: WindowRef; title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91A;
	{$ENDC}

{
 *  GetWTitle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetWTitle(window: WindowRef; VAR title: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A919;
	{$ENDC}

{
 *  SetWindowTitleWithCFString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowTitleWithCFString(inWindow: WindowRef; inString: CFStringRef): OSStatus;

{
 *  CopyWindowTitleAsCFString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CopyWindowTitleAsCFString(inWindow: WindowRef; VAR outString: CFStringRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Proxies                                                                     }
{——————————————————————————————————————————————————————————————————————————————————————}
{  Routines available from Mac OS 8.5 forward }

{
 *  SetWindowProxyFSSpec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowProxyFSSpec(window: WindowRef; {CONST}VAR inFile: FSSpec): OSStatus;

{
 *  GetWindowProxyFSSpec()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowProxyFSSpec(window: WindowRef; VAR outFile: FSSpec): OSStatus;

{
 *  SetWindowProxyAlias()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowProxyAlias(window: WindowRef; alias: AliasHandle): OSStatus;

{
 *  GetWindowProxyAlias()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowProxyAlias(window: WindowRef; VAR alias: AliasHandle): OSStatus;

{
 *  SetWindowProxyCreatorAndType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowProxyCreatorAndType(window: WindowRef; fileCreator: OSType; fileType: OSType; vRefNum: SInt16): OSStatus;

{
 *  GetWindowProxyIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowProxyIcon(window: WindowRef; VAR outIcon: IconRef): OSStatus;

{
 *  SetWindowProxyIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowProxyIcon(window: WindowRef; icon: IconRef): OSStatus;

{
 *  RemoveWindowProxy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveWindowProxy(window: WindowRef): OSStatus;

{
 *  BeginWindowProxyDrag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BeginWindowProxyDrag(window: WindowRef; VAR outNewDrag: DragReference; outDragOutlineRgn: RgnHandle): OSStatus;

{
 *  EndWindowProxyDrag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION EndWindowProxyDrag(window: WindowRef; theDrag: DragReference): OSStatus;

{
 *  TrackWindowProxyFromExistingDrag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TrackWindowProxyFromExistingDrag(window: WindowRef; startPt: Point; drag: DragReference; inDragOutlineRgn: RgnHandle): OSStatus;

{
 *  TrackWindowProxyDrag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TrackWindowProxyDrag(window: WindowRef; startPt: Point): OSStatus;

{
 *  IsWindowModified()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsWindowModified(window: WindowRef): BOOLEAN;

{
 *  SetWindowModified()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowModified(window: WindowRef; modified: BOOLEAN): OSStatus;

{
 *  IsWindowPathSelectClick()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsWindowPathSelectClick(window: WindowRef; {CONST}VAR event: EventRecord): BOOLEAN;

{
 *  WindowPathSelect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION WindowPathSelect(window: WindowRef; menu: MenuRef; VAR outMenuResult: SInt32): OSStatus;

{
 *  IsWindowPathSelectEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsWindowPathSelectEvent(window: WindowRef; inEvent: EventRef): BOOLEAN;


{——————————————————————————————————————————————————————————————————————————————————————}
{  • HiliteWindowFrameForDrag                                                          }
{                                                                                      }
{  If you call ShowDragHilite and HideDragHilite, you don’t need to use this routine.  }
{  If you implement custom drag hiliting, you should call HiliteWindowFrameForDrag     }
{  when the drag is tracking inside a window with drag-hilited content.                }
{——————————————————————————————————————————————————————————————————————————————————————}
{  Routines available from Mac OS 8.5 forward }

{
 *  HiliteWindowFrameForDrag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HiliteWindowFrameForDrag(window: WindowRef; hilited: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7019, $A829;
	{$ENDC}


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Transitions                                                                 }
{                                                                                      }
{  TransitionWindow displays a window with accompanying animation and sound.           }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	WindowTransitionEffect 		= UInt32;
CONST
	kWindowZoomTransitionEffect	= 1;							{  Finder-like zoom rectangles. Use with Show or Hide transition actions }
	kWindowSheetTransitionEffect = 2;							{  Zoom in/out from parent. Use with TransitionWindowAndParent and Show or Hide transition actions }
	kWindowSlideTransitionEffect = 3;							{  Slide the window into its new position. Use with Move or Resize transition actions }


TYPE
	WindowTransitionAction 		= UInt32;
CONST
	kWindowShowTransitionAction	= 1;							{  param is rect in global coordinates from which to start the animation }
	kWindowHideTransitionAction	= 2;							{  param is rect in global coordinates at which to end the animation }
	kWindowMoveTransitionAction	= 3;							{  param is rect in global coordinates of window's new structure bounds }
	kWindowResizeTransitionAction = 4;							{  param is rect in global coordinates of window's new structure bounds }

	{
	 *  TransitionWindow()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION TransitionWindow(window: WindowRef; effect: WindowTransitionEffect; action: WindowTransitionAction; rect: {Const}RectPtr): OSStatus;

{
 *  TransitionWindowAndParent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TransitionWindowAndParent(window: WindowRef; parentWindow: WindowRef; effect: WindowTransitionEffect; action: WindowTransitionAction; rect: {Const}RectPtr): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Positioning                                                                 }
{——————————————————————————————————————————————————————————————————————————————————————}

{
 *  [Mac]MoveWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MoveWindow(window: WindowRef; hGlobal: INTEGER; vGlobal: INTEGER; front: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91B;
	{$ENDC}

{
 *  SizeWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SizeWindow(window: WindowRef; w: INTEGER; h: INTEGER; fUpdate: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91D;
	{$ENDC}


{ Note: bBox can only be NULL when linking to CarbonLib 1.0 forward }
{
 *  GrowWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GrowWindow(window: WindowRef; startPt: Point; bBox: {Const}RectPtr): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A92B;
	{$ENDC}

{ Note: boundsRect can only be NULL when linking to CarbonLib 1.0 forward }
{
 *  DragWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DragWindow(window: WindowRef; startPt: Point; boundsRect: {Const}RectPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A925;
	{$ENDC}

{
 *  ZoomWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ZoomWindow(window: WindowRef; partCode: WindowPartCode; front: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A83A;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Collapsing/Expanding                                                        }
{——————————————————————————————————————————————————————————————————————————————————————}
{  Routines available from Mac OS 8.0 (Appearance 1.0) forward }
{
 *  IsWindowCollapsable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsWindowCollapsable(window: WindowRef): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000F, $AA74;
	{$ENDC}

{
 *  IsWindowCollapsed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsWindowCollapsed(window: WindowRef): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0010, $AA74;
	{$ENDC}

{
 *  CollapseWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CollapseWindow(window: WindowRef; collapse: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0011, $AA74;
	{$ENDC}

{
 *  CollapseAllWindows()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CollapseAllWindows(collapse: BOOLEAN): OSStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0012, $AA74;
	{$ENDC}

{  Routines available on Mac OS X }

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateQDContextForCollapsedWindowDockTile(inWindow: WindowRef; VAR outContext: CGrafPtr): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ReleaseQDContextForCollapsedWindowDockTile(inWindow: WindowRef; inContext: CGrafPtr): OSStatus; C;

{
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
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UpdateCollapsedWindowDockTile(inWindow: WindowRef): OSStatus; C;


{
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}

{
 *  GetWindowBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowBounds(window: WindowRef; regionCode: WindowRegionCode; VAR globalBounds: Rect): OSStatus;

{ Note: newContentRect can only be NULL when linking to CarbonLib 1.0 forward }
{
 *  ResizeWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ResizeWindow(window: WindowRef; startPoint: Point; sizeConstraints: {Const}RectPtr; newContentRect: RectPtr): BOOLEAN;


{
   Routines available from Mac OS 8.5 forward,
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0.2 forward
}

{
 *  SetWindowBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowBounds(window: WindowRef; regionCode: WindowRegionCode; {CONST}VAR globalBounds: Rect): OSStatus;

{  Routines available from Mac OS 8.5 forward }

{
 *  RepositionWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RepositionWindow(window: WindowRef; parentWindow: WindowRef; method: WindowPositionMethod): OSStatus;

{
 *  MoveWindowStructure()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MoveWindowStructure(window: WindowRef; hGlobal: INTEGER; vGlobal: INTEGER): OSStatus;

{
   Routines available from Mac OS 8.5 forward,
   or from Mac OS 8.6 forward when linking to CarbonLib 1.1 forward
}

{
 *  IsWindowInStandardState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsWindowInStandardState(window: WindowRef; idealSize: PointPtr; idealStandardState: RectPtr): BOOLEAN;

{
 *  ZoomWindowIdeal()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ZoomWindowIdeal(window: WindowRef; partCode: WindowPartCode; VAR ioIdealSize: Point): OSStatus;

{
 *  GetWindowIdealUserState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowIdealUserState(window: WindowRef; VAR userState: Rect): OSStatus;

{
 *  SetWindowIdealUserState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowIdealUserState(window: WindowRef; {CONST}VAR userState: Rect): OSStatus;

{  Routines available in CarbonLib 1.1 and later }

{
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
 }
FUNCTION GetWindowGreatestAreaDevice(inWindow: WindowRef; inRegion: WindowRegionCode; VAR outGreatestDevice: GDHandle; outGreatestDeviceRect: RectPtr): OSStatus;


{
 *  WindowConstrainOptions
 *  
 }

TYPE
	WindowConstrainOptions 		= UInt32;
CONST
	kWindowConstrainMayResize	= $00000001;
	kWindowConstrainMoveRegardlessOfFit = $00000002;
	kWindowConstrainAllowPartial = $00000004;
	kWindowConstrainCalcOnly	= $00000008;
	kWindowConstrainStandardOptions = $00000002;

	{
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
	 	}
FUNCTION ConstrainWindowToScreen(inWindowRef: WindowRef; inRegionCode: WindowRegionCode; inOptions: WindowConstrainOptions; inScreenRect: {Const}RectPtr; outStructure: RectPtr): OSStatus;

{
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
 }
FUNCTION GetAvailableWindowPositioningBounds(inDevice: GDHandle; VAR availableRect: Rect): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Visibility                                                                  }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  HideWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE HideWindow(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A916;
	{$ENDC}

{
 *  [Mac]ShowWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ShowWindow(window: WindowRef);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A915;
	{$ENDC}

{
 *  ShowHide()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ShowHide(window: WindowRef; showFlag: BOOLEAN);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A908;
	{$ENDC}


{
 *  [Mac]IsWindowVisible()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsWindowVisible(window: WindowRef): BOOLEAN;


{——————————————————————————————————————————————————————————————————————————————————————}
{
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
}
{
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
 }
FUNCTION ShowSheetWindow(inSheet: WindowRef; inParentWindow: WindowRef): OSStatus;

{
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
 }
FUNCTION HideSheetWindow(inSheet: WindowRef): OSStatus;

{
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
 }
FUNCTION GetSheetWindowParent(inSheet: WindowRef; VAR outParentWindow: WindowRef): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Disabling Screen Redraw                                                            }
{——————————————————————————————————————————————————————————————————————————————————————}
{
   disable and enable screen updates for changes to the current application’s windows
   (OS X only for now)
}

{
 *  DisableScreenUpdates()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DisableScreenUpdates: OSStatus;

{
 *  EnableScreenUpdates()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION EnableScreenUpdates: OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Properties                                                                  }
{——————————————————————————————————————————————————————————————————————————————————————}
{
   Routines available from Mac OS 8.5 forward
   or from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward
}

{
 *  GetWindowProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowProperty(window: WindowRef; propertyCreator: PropertyCreator; propertyTag: PropertyTag; bufferSize: UInt32; VAR actualSize: UInt32; propertyBuffer: UNIV Ptr): OSStatus;

{
 *  GetWindowPropertySize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowPropertySize(window: WindowRef; creator: PropertyCreator; tag: PropertyTag; VAR size: UInt32): OSStatus;

{
 *  SetWindowProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowProperty(window: WindowRef; propertyCreator: PropertyCreator; propertyTag: PropertyTag; propertySize: UInt32; propertyBuffer: UNIV Ptr): OSStatus;

{
 *  RemoveWindowProperty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in WindowsLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveWindowProperty(window: WindowRef; propertyCreator: PropertyCreator; propertyTag: PropertyTag): OSStatus;


{  Routines available from Mac OS 8.1 forward when linking to CarbonLib 1.0 forward }


CONST
	kWindowPropertyPersistent	= $00000001;					{  whether this property gets saved when flattening the window  }

	{
	 *  GetWindowPropertyAttributes()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION GetWindowPropertyAttributes(window: WindowRef; propertyCreator: OSType; propertyTag: OSType; VAR attributes: UInt32): OSStatus;

{
 *  ChangeWindowPropertyAttributes()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ChangeWindowPropertyAttributes(window: WindowRef; propertyCreator: OSType; propertyTag: OSType; attributesToSet: UInt32; attributesToClear: UInt32): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Utilities                                                                          }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  PinRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PinRect({CONST}VAR theRect: Rect; thePt: Point): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94E;
	{$ENDC}


{
 *  GetGrayRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetGrayRgn: RgnHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2EB8, $09EE;
	{$ENDC}


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Part Tracking                                                               }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  TrackBox()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TrackBox(window: WindowRef; thePt: Point; partCode: WindowPartCode): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A83B;
	{$ENDC}

{
 *  TrackGoAway()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TrackGoAway(window: WindowRef; thePt: Point): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A91E;
	{$ENDC}


{——————————————————————————————————————————————————————————————————————————————————————}
{ • Region Dragging                                                                    }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  DragGrayRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DragGrayRgn(theRgn: RgnHandle; startPt: Point; {CONST}VAR limitRect: Rect; {CONST}VAR slopRect: Rect; axis: INTEGER; actionProc: DragGrayRgnUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A905;
	{$ENDC}

{
 *  DragTheRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DragTheRgn(theRgn: RgnHandle; startPt: Point; {CONST}VAR limitRect: Rect; {CONST}VAR slopRect: Rect; axis: INTEGER; actionProc: DragGrayRgnUPP): LONGINT;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A926;
	{$ENDC}


{——————————————————————————————————————————————————————————————————————————————————————}
{  • GetAuxWin                                                                         }
{                                                                                      }
{  GetAuxWin is not available in Carbon                                                }
{——————————————————————————————————————————————————————————————————————————————————————}
{$IFC NOT OPAQUE_TOOLBOX_STRUCTS }
{$IFC CALL_NOT_IN_CARBON }
{
 *  GetAuxWin()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetAuxWin(window: WindowRef; VAR awHndl: AuxWinHandle): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA42;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{ • Window Accessors                                                                   }
{——————————————————————————————————————————————————————————————————————————————————————}

{$IFC CALL_NOT_IN_CARBON }
{
 *  GetWindowGoAwayFlag()
 *  
 *  Discussion:
 *    use GetWindowAttributes in Carbon
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetWindowGoAwayFlag(window: WindowRef): BOOLEAN;

{
 *  GetWindowSpareFlag()
 *  
 *  Discussion:
 *    use GetWindowAttributes in Carbon
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetWindowSpareFlag(window: WindowRef): BOOLEAN;

{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  GetWindowList()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowList: WindowRef;


{
 *  GetWindowPort()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowPort(window: WindowRef): CGrafPtr;


{
 *  GetWindowKind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowKind(window: WindowRef): INTEGER;


{
 *  IsWindowHilited()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsWindowHilited(window: WindowRef): BOOLEAN;


{
 *  IsWindowUpdatePending()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsWindowUpdatePending(window: WindowRef): BOOLEAN;


{
 *  [Mac]GetNextWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetNextWindow(window: WindowRef): WindowRef;


{
 *  GetWindowStandardState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowStandardState(window: WindowRef; VAR rect: Rect): RectPtr;


{
 *  GetWindowUserState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowUserState(window: WindowRef; VAR rect: Rect): RectPtr;


{
 *  SetWindowKind()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetWindowKind(window: WindowRef; kind: INTEGER);


{
 *  SetWindowStandardState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetWindowStandardState(window: WindowRef; {CONST}VAR rect: Rect);



{
 *  SetWindowUserState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetWindowUserState(window: WindowRef; {CONST}VAR rect: Rect);


{
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
 }
PROCEDURE SetPortWindowPort(window: WindowRef);



{
 *  GetWindowPortBounds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowPortBounds(window: WindowRef; VAR bounds: Rect): RectPtr;


{
 *  GetWindowFromPort()
 *  
 *  Discussion:
 *    Needed to ‘cast up’ to a WindowRef from a GrafPtr
 *  
 *  Availability:
 *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowFromPort(port: CGrafPtr): WindowRef;





{  old accessors }

{$IFC CALL_NOT_IN_CARBON }
{
 *  GetWindowDataHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetWindowDataHandle(window: WindowRef): Handle; C;


{
 *  SetWindowDataHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SetWindowDataHandle(window: WindowRef; data: Handle); C;


{
 *  GetWindowZoomFlag()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetWindowZoomFlag(window: WindowRef): BOOLEAN; C;


{
 *  GetWindowStructureRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetWindowStructureRgn(window: WindowRef; r: RgnHandle); C;


{
 *  GetWindowContentRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetWindowContentRgn(window: WindowRef; r: RgnHandle); C;


{
 *  GetWindowUpdateRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GetWindowUpdateRgn(window: WindowRef; r: RgnHandle); C;


{
 *  GetWindowTitleWidth()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GetWindowTitleWidth(window: WindowRef): SInt16; C;


{——————————————————————————————————————————————————————————————————————————————————————————————————}
{ Obsolete symbolic names                                                                          }
{——————————————————————————————————————————————————————————————————————————————————————————————————}
{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
	kWindowGroupAttrSelectable	= $01;
	kWindowGroupAttrPositionFixed = $02;
	kWindowGroupAttrZOrderFixed	= $04;









{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MacWindowsIncludes}

{$ENDC} {__MACWINDOWS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

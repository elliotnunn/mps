{
     File:       MacHelp.p
 
     Contains:   Macintosh Help Package Interfaces.
 
     Version:    Technology: CarbonLib 1.x
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1998-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MacHelp;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MACHELP__}
{$SETC __MACHELP__ := 1}

{$I+}
{$SETC MacHelpIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __BALLOONS__}
{$I Balloons.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}
{$IFC UNDEFINED __DIALOGS__}
{$I Dialogs.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{——————————————————————————————————————————————————————————————————————————————————}
{ Help Manager constants, etc.                                                     }
{——————————————————————————————————————————————————————————————————————————————————}

CONST
	kMacHelpVersion				= $0003;


TYPE
	HMContentRequest 			= SInt16;
CONST
	kHMSupplyContent			= 0;
	kHMDisposeContent			= 1;


TYPE
	HMContentType 				= UInt32;
CONST
	kHMNoContent				= 'none';
	kHMCFStringContent			= 'cfst';						{  CFStringRef }
	kHMPascalStrContent			= 'pstr';
	kHMStringResContent			= 'str#';
	kHMTEHandleContent			= 'txth';						{  NOT SUPPORTED ON MAC OS X }
	kHMTextResContent			= 'text';						{  NOT SUPPORTED ON MAC OS X }
	kHMStrResContent			= 'str ';


	{
	 *  HMTagDisplaySide
	 *  
	 *  Discussion:
	 *    Help tag display locations relative to absolute hot rect
	 	}

TYPE
	HMTagDisplaySide 			= SInt16;
CONST
	kHMDefaultSide				= 0;
	kHMOutsideTopScriptAligned	= 1;
	kHMOutsideLeftCenterAligned	= 2;
	kHMOutsideBottomScriptAligned = 3;
	kHMOutsideRightCenterAligned = 4;
	kHMOutsideTopLeftAligned	= 5;
	kHMOutsideTopRightAligned	= 6;
	kHMOutsideLeftTopAligned	= 7;
	kHMOutsideLeftBottomAligned	= 8;
	kHMOutsideBottomLeftAligned	= 9;
	kHMOutsideBottomRightAligned = 10;
	kHMOutsideRightTopAligned	= 11;
	kHMOutsideRightBottomAligned = 12;
	kHMOutsideTopCenterAligned	= 13;
	kHMOutsideBottomCenterAligned = 14;
	kHMInsideRightCenterAligned	= 15;
	kHMInsideLeftCenterAligned	= 16;
	kHMInsideBottomCenterAligned = 17;
	kHMInsideTopCenterAligned	= 18;
	kHMInsideTopLeftCorner		= 19;
	kHMInsideTopRightCorner		= 20;
	kHMInsideBottomLeftCorner	= 21;
	kHMInsideBottomRightCorner	= 22;
	kHMAbsoluteCenterAligned	= 23;

	{	 Obsoleted constants HMTagDisplaySides, use the new ones, please 	}
	kHMTopSide					= 1;
	kHMLeftSide					= 2;
	kHMBottomSide				= 3;
	kHMRightSide				= 4;
	kHMTopLeftCorner			= 5;
	kHMTopRightCorner			= 6;
	kHMLeftTopCorner			= 7;
	kHMLeftBottomCorner			= 8;
	kHMBottomLeftCorner			= 9;
	kHMBottomRightCorner		= 10;
	kHMRightTopCorner			= 11;
	kHMRightBottomCorner		= 12;


TYPE
	HMContentProvidedType 		= SInt16;
CONST
	kHMContentProvided			= 0;
	kHMContentNotProvided		= 1;
	kHMContentNotProvidedDontPropagate = 2;

	kHMMinimumContentIndex		= 0;							{  first entry in HMHelpContentRec.content is the minimum content  }
	kHMMaximumContentIndex		= 1;							{  second entry in HMHelpContentRec.content is the maximum content  }

	errHMIllegalContentForMinimumState = -10980;				{  unrecognized content type for minimum content  }
	errHMIllegalContentForMaximumState = -10981;				{  unrecognized content type for maximum content  }

	{  obsolete names; will be removed }
	kHMIllegalContentForMinimumState = -10980;

	kHelpTagEventHandlerTag		= 'hevt';


TYPE
	HMHelpContentPtr = ^HMHelpContent;
	HMHelpContent = RECORD
		contentType:			HMContentType;
		CASE INTEGER OF
		0: (
			tagCFString:		CFStringRef;							{  CFStringRef }
			);
		1: (
			tagString:			Str255;									{  Pascal String }
			);
		2: (
			tagStringRes:		HMStringResType;						{  STR# resource ID and index }
			);
		3: (
			tagTEHandle:		TEHandle;								{  TextEdit handle (NOT SUPPORTED ON MAC OS X) }
			);
		4: (
			tagTextRes:			SInt16;									{  TEXT/styl resource ID (NOT SUPPORTED ON MAC OS X) }
			);
		5: (
			tagStrRes:			SInt16;									{  STR resource ID }
			);
	END;

	HMHelpContentRecPtr = ^HMHelpContentRec;
	HMHelpContentRec = RECORD
		version:				SInt32;
		absHotRect:				Rect;
		tagSide:				HMTagDisplaySide;
		content:				ARRAY [0..1] OF HMHelpContent;
	END;

	{	——————————————————————————————————————————————————————————————————————————————————————————	}
	{	 Callback procs                                       	}
	{	—————————————————————————————————————————————————————————————————————————————————————————— 	}
{$IFC TYPED_FUNCTION_POINTERS}
	HMControlContentProcPtr = FUNCTION(inControl: ControlRef; inGlobalMouse: Point; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr): OSStatus;
{$ELSEC}
	HMControlContentProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	HMWindowContentProcPtr = FUNCTION(inWindow: WindowRef; inGlobalMouse: Point; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr): OSStatus;
{$ELSEC}
	HMWindowContentProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	HMMenuTitleContentProcPtr = FUNCTION(inMenu: MenuRef; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr): OSStatus;
{$ELSEC}
	HMMenuTitleContentProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	HMMenuItemContentProcPtr = FUNCTION({CONST}VAR inTrackingData: MenuTrackingData; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr): OSStatus;
{$ELSEC}
	HMMenuItemContentProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	HMControlContentUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	HMControlContentUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	HMWindowContentUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	HMWindowContentUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	HMMenuTitleContentUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	HMMenuTitleContentUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	HMMenuItemContentUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	HMMenuItemContentUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppHMControlContentProcInfo = $0000FBF0;
	uppHMWindowContentProcInfo = $0000FBF0;
	uppHMMenuTitleContentProcInfo = $00003EF0;
	uppHMMenuItemContentProcInfo = $00003EF0;
	{
	 *  NewHMControlContentUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewHMControlContentUPP(userRoutine: HMControlContentProcPtr): HMControlContentUPP; { old name was NewHMControlContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewHMWindowContentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewHMWindowContentUPP(userRoutine: HMWindowContentProcPtr): HMWindowContentUPP; { old name was NewHMWindowContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewHMMenuTitleContentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewHMMenuTitleContentUPP(userRoutine: HMMenuTitleContentProcPtr): HMMenuTitleContentUPP; { old name was NewHMMenuTitleContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewHMMenuItemContentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewHMMenuItemContentUPP(userRoutine: HMMenuItemContentProcPtr): HMMenuItemContentUPP; { old name was NewHMMenuItemContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeHMControlContentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeHMControlContentUPP(userUPP: HMControlContentUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeHMWindowContentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeHMWindowContentUPP(userUPP: HMWindowContentUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeHMMenuTitleContentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeHMMenuTitleContentUPP(userUPP: HMMenuTitleContentUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeHMMenuItemContentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeHMMenuItemContentUPP(userUPP: HMMenuItemContentUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeHMControlContentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeHMControlContentUPP(inControl: ControlRef; inGlobalMouse: Point; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr; userRoutine: HMControlContentUPP): OSStatus; { old name was CallHMControlContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeHMWindowContentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeHMWindowContentUPP(inWindow: WindowRef; inGlobalMouse: Point; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr; userRoutine: HMWindowContentUPP): OSStatus; { old name was CallHMWindowContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeHMMenuTitleContentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeHMMenuTitleContentUPP(inMenu: MenuRef; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr; userRoutine: HMMenuTitleContentUPP): OSStatus; { old name was CallHMMenuTitleContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeHMMenuItemContentUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeHMMenuItemContentUPP({CONST}VAR inTrackingData: MenuTrackingData; inRequest: HMContentRequest; VAR outContentProvided: HMContentProvidedType; ioHelpContent: HMHelpContentPtr; userRoutine: HMMenuItemContentUPP): OSStatus; { old name was CallHMMenuItemContentProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————————}
{ API                                                                                      }
{——————————————————————————————————————————————————————————————————————————————————————————}
{ Help Menu }
{
 *  HMGetHelpMenu()
 *  
 *  Summary:
 *    Returns a menu to which applications may add their own help items.
 *  
 *  Parameters:
 *    
 *    outHelpMenu:
 *      On exit, contains the help menu.
 *    
 *    outFirstCustomItemIndex:
 *      On exit, contains the menu item index that will be used by the
 *      first item added by the application. This parameter may be NULL.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMGetHelpMenu(VAR outHelpMenu: MenuRef; VAR outFirstCustomItemIndex: MenuItemIndex): OSStatus;

{ Installing/Retrieving Content }
{ Menu title and item help tags are not yet supported by Carbon or CarbonLib. }
{ They will be fully supported in a future release. }
{
 *  HMSetControlHelpContent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMSetControlHelpContent(inControl: ControlRef; {CONST}VAR inContent: HMHelpContentRec): OSStatus;

{
 *  HMGetControlHelpContent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMGetControlHelpContent(inControl: ControlRef; VAR outContent: HMHelpContentRec): OSStatus;

{
 *  HMSetWindowHelpContent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMSetWindowHelpContent(inWindow: WindowRef; {CONST}VAR inContent: HMHelpContentRec): OSStatus;

{
 *  HMGetWindowHelpContent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMGetWindowHelpContent(inWindow: WindowRef; VAR outContent: HMHelpContentRec): OSStatus;

{
 *  HMSetMenuItemHelpContent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMSetMenuItemHelpContent(inMenu: MenuRef; inItem: MenuItemIndex; {CONST}VAR inContent: HMHelpContentRec): OSStatus;

{
 *  HMGetMenuItemHelpContent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMGetMenuItemHelpContent(inMenu: MenuRef; inItem: MenuItemIndex; VAR outContent: HMHelpContentRec): OSStatus;

{ Installing/Retrieving Content Callbacks }
{
 *  HMInstallControlContentCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMInstallControlContentCallback(inControl: ControlRef; inContentUPP: HMControlContentUPP): OSStatus;

{
 *  HMInstallWindowContentCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMInstallWindowContentCallback(inWindow: WindowRef; inContentUPP: HMWindowContentUPP): OSStatus;

{
 *  HMInstallMenuTitleContentCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMInstallMenuTitleContentCallback(inMenu: MenuRef; inContentUPP: HMMenuTitleContentUPP): OSStatus;

{
 *  HMInstallMenuItemContentCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMInstallMenuItemContentCallback(inMenu: MenuRef; inContentUPP: HMMenuItemContentUPP): OSStatus;

{
 *  HMGetControlContentCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMGetControlContentCallback(inControl: ControlRef; VAR outContentUPP: HMControlContentUPP): OSStatus;

{
 *  HMGetWindowContentCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMGetWindowContentCallback(inWindow: WindowRef; VAR outContentUPP: HMWindowContentUPP): OSStatus;

{
 *  HMGetMenuTitleContentCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMGetMenuTitleContentCallback(inMenu: MenuRef; VAR outContentUPP: HMMenuTitleContentUPP): OSStatus;

{
 *  HMGetMenuItemContentCallback()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMGetMenuItemContentCallback(inMenu: MenuRef; VAR outContentUPP: HMMenuItemContentUPP): OSStatus;

{ Enabling and Disabling Help Tags }
{
 *  HMAreHelpTagsDisplayed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMAreHelpTagsDisplayed: BOOLEAN;

{
 *  HMSetHelpTagsDisplayed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMSetHelpTagsDisplayed(inDisplayTags: BOOLEAN): OSStatus;

{
 *  HMSetTagDelay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMSetTagDelay(inDelay: Duration): OSStatus;

{
 *  HMGetTagDelay()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMGetTagDelay(VAR outDelay: Duration): OSStatus;

{ Compatibility }
{
 *  HMSetMenuHelpFromBalloonRsrc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMSetMenuHelpFromBalloonRsrc(inMenu: MenuRef; inHmnuRsrcID: SInt16): OSStatus;

{
 *  HMSetDialogHelpFromBalloonRsrc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMSetDialogHelpFromBalloonRsrc(inDialog: DialogRef; inHdlgRsrcID: SInt16; inItemStart: SInt16): OSStatus;

{ Displaying tags }
{
 *  HMDisplayTag()
 *  
 *  Summary:
 *    Displays a help tag at a user defined location.
 *  
 *  Parameters:
 *    
 *    inContent:
 *      HMHelpContentRec describing the help tag to be displayed.
 *  
 *  Result:
 *    An OSStatus code indicating success or failure.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available in CarbonLib 1.x, is availble on Mac OS X version 10.0 or later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION HMDisplayTag({CONST}VAR inContent: HMHelpContentRec): OSStatus;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MacHelpIncludes}

{$ENDC} {__MACHELP__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

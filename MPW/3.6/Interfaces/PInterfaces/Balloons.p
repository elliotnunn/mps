{
     File:       Balloons.p
 
     Contains:   Balloon Help Package Interfaces.
 
     Version:    Technology: System 7.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1990-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Balloons;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __BALLOONS__}
{$SETC __BALLOONS__ := 1}

{$I+}
{$SETC BalloonsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __TEXTEDIT__}
{$I TextEdit.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
   Carbon clients should use MacHelp. The definitions below will NOT work for Carbon and
   are only defined for those files that need to build pre-Carbon applications.
}
{  • constants }


TYPE
	BalloonVariant 				= SInt16;
CONST
	kTopLeftTipPointsLeftVariant = 0;
	kTopLeftTipPointsUpVariant	= 1;
	kTopRightTipPointsUpVariant	= 2;
	kTopRightTipPointsRightVariant = 3;
	kBottomRightTipPointsRightVariant = 4;
	kBottomRightTipPointsDownVariant = 5;
	kBottomLeftTipPointsDownVariant = 6;
	kBottomLeftTipPointsLeftVariant = 7;
	kBalloonVariantCount		= 8;


	hmBalloonHelpVersion		= $0002;						{  The real version of the Help Manager  }

	kHMHelpMenuID				= -16490;						{  Resource ID and menu ID of help menu  }
	kHMAboutHelpItem			= 1;							{  help menu item number of About Balloon Help…  }
	kHMShowBalloonsItem			= 3;							{  help menu item number of Show/Hide Balloons  }

	kHMHelpID					= -5696;						{  ID of various Help Mgr package resources (in Pack14 range)  }
	kBalloonWDEFID				= 126;							{  Resource ID of the WDEF proc used in standard balloons  }

																{  Dialog item template type constant  }
	helpItem					= 1;							{  key value in DITL template that corresponds to the help item  }

																{  Options for Help Manager resources in 'hmnu', 'hdlg', 'hrct', 'hovr', & 'hfdr' resources  }
	hmDefaultOptions			= 0;							{  default options for help manager resources  }
	hmUseSubIDBit				= 0;
	hmAbsoluteCoordsBit			= 1;
	hmSaveBitsNoWindowBit		= 2;
	hmSaveBitsWindowBit			= 3;
	hmMatchInTitleBit			= 4;
	hmUseSubIDMask				= $01;							{  treat resID's in resources as subID's of driver base ID (for Desk Accessories)  }
	hmAbsoluteCoordsMask		= $02;							{  ignore window port origin and treat rectangles as absolute coords (local to window)  }
	hmSaveBitsNoWindowMask		= $04;							{  don't create a window, just blast bits on screen. No update event is generated  }
	hmSaveBitsWindowMask		= $08;							{  create a window, but restore bits behind window when window goes away & generate update event  }
	hmMatchInTitleMask			= $10;							{  for hwin resources, match string anywhere in window title string  }

{$IFC OLDROUTINENAMES }
	hmUseSubID					= $01;
	hmAbsoluteCoords			= $02;
	hmSaveBitsNoWindow			= $04;
	hmSaveBitsWindow			= $08;
	hmMatchInTitle				= $10;

{$ENDC}  {OLDROUTINENAMES}

																{  Constants for Help Types in 'hmnu', 'hdlg', 'hrct', 'hovr', & 'hfdr' resources  }
	kHMStringItem				= 1;							{  pstring used in resource  }
	kHMPictItem					= 2;							{  'PICT' ResID used in resource  }
	kHMStringResItem			= 3;							{  'STR#' ResID & index used in resource  }
	kHMTEResItem				= 6;							{  Styled Text Edit ResID used in resource ('TEXT' & 'styl')  }
	kHMSTRResItem				= 7;							{  'STR ' ResID used in resource  }
	kHMSkipItem					= 256;							{  don't display a balloon  }
	kHMCompareItem				= 512;							{  Compare pstring in menu item w/ PString in resource item ('hmnu' only)  }
	kHMNamedResourceItem		= 1024;							{  Use pstring in menu item to get 'STR#', 'PICT', or 'STR ' resource ('hmnu' only)  }
	kHMTrackCntlItem			= 2048;							{  Reserved  }

																{  Constants for hmmHelpType's when filling out HMMessageRecord  }
	khmmString					= 1;							{  help message contains a PString  }
	khmmPict					= 2;							{  help message contains a resource ID to a 'PICT' resource  }
	khmmStringRes				= 3;							{  help message contains a res ID & index to a 'STR#' resource  }
	khmmTEHandle				= 4;							{  help message contains a Text Edit handle  }
	khmmPictHandle				= 5;							{  help message contains a Picture handle  }
	khmmTERes					= 6;							{  help message contains a res ID to 'TEXT' & 'styl' resources  }
	khmmSTRRes					= 7;							{  help message contains a res ID to a 'STR ' resource  }
	kHMEnabledItem				= 0;							{  item is enabled, but not checked or control value = 0  }

																{  ResTypes for Styled TE Handles in Resources  }
	kHMTETextResType			= 'TEXT';						{  Resource Type of text data for styled TE record w/o style info  }
	kHMTEStyleResType			= 'styl';						{  Resource Type of style information for styled TE record  }

	kHMDisabledItem				= 1;							{  item is disabled, grayed in menus or disabled in dialogs  }
	kHMCheckedItem				= 2;							{  item is enabled, and checked or control value = 1  }
	kHMOtherItem				= 3;							{  item is enabled, and control value > 1  }
																{  Method parameters to pass to HMShowBalloon  }
	kHMRegularWindow			= 0;							{  Create a regular window floating above all windows  }
	kHMSaveBitsNoWindow			= 1;							{  Just save the bits and draw (for MDEF calls)  }
	kHMSaveBitsWindow			= 2;							{  Regular window, save bits behind, AND generate update event  }

																{  Resource Types for whichType parameter used when extracting 'hmnu' & 'hdlg' messages  }
	kHMMenuResType				= 'hmnu';						{  ResType of help resource for supporting menus  }
	kHMDialogResType			= 'hdlg';						{  ResType of help resource for supporting dialogs  }
	kHMWindListResType			= 'hwin';						{  ResType of help resource for supporting windows  }
	kHMRectListResType			= 'hrct';						{  ResType of help resource for rectangles in windows  }
	kHMOverrideResType			= 'hovr';						{  ResType of help resource for overriding system balloons  }
	kHMFinderApplResType		= 'hfdr';						{  ResType of help resource for custom balloon in Finder  }


TYPE
	HMStringResTypePtr = ^HMStringResType;
	HMStringResType = RECORD
		hmmResID:				INTEGER;
		hmmIndex:				INTEGER;
	END;

	HMMessageRecordPtr = ^HMMessageRecord;
	HMMessageRecord = RECORD
		hmmHelpType:			SInt16;
		CASE INTEGER OF
		0: (
			hmmString:			Str255;
			);
		1: (
			hmmPict:			SInt16;
			);
		2: (
			hmmTEHandle:		TEHandle;
			);
		3: (
			hmmStringRes:		HMStringResType;
			);
		4: (
			hmmPictRes:			SInt16;
			);
		5: (
			hmmPictHandle:		PicHandle;
			);
		6: (
			hmmTERes:			SInt16;
			);
		7: (
			hmmSTRRes:			SInt16;
			);
	END;

	HMMessageRecPtr						= ^HMMessageRecord;
{$IFC TYPED_FUNCTION_POINTERS}
	TipFunctionProcPtr = FUNCTION(tip: Point; structure: RgnHandle; VAR r: Rect; VAR balloonVariant: BalloonVariant): OSErr;
{$ELSEC}
	TipFunctionProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	TipFunctionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TipFunctionUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppTipFunctionProcInfo = $00003FE0;
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  NewTipFunctionUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION NewTipFunctionUPP(userRoutine: TipFunctionProcPtr): TipFunctionUPP; { old name was NewTipFunctionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeTipFunctionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DisposeTipFunctionUPP(userUPP: TipFunctionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeTipFunctionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION InvokeTipFunctionUPP(tip: Point; structure: RgnHandle; VAR r: Rect; VAR balloonVariant: BalloonVariant; userRoutine: TipFunctionUPP): OSErr; { old name was CallTipFunctionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{  Public Interfaces  }
{$IFC CALL_NOT_IN_CARBON }
{
 *  HMGetHelpMenuHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMGetHelpMenuHandle(VAR mh: MenuRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0200, $A830;
	{$ENDC}

{
 *  HMShowBalloon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMShowBalloon({CONST}VAR inHelpMessage: HMMessageRecord; inTip: Point; inHotRect: RectPtr; inTipProc: TipFunctionUPP; inWindowProcID: SInt16; inBalloonVariant: BalloonVariant; inMethod: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0B01, $A830;
	{$ENDC}

{
 *  HMShowMenuBalloon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMShowMenuBalloon(itemNum: SInt16; itemMenuID: SInt16; itemFlags: SInt32; itemReserved: SInt32; tip: Point; alternateRect: RectPtr; tipProc: TipFunctionUPP; theProc: SInt16; balloonVariant: BalloonVariant): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0E05, $A830;
	{$ENDC}

{
 *  HMRemoveBalloon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMRemoveBalloon: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0002, $A830;
	{$ENDC}

{
 *  HMGetIndHelpMsg()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMGetIndHelpMsg(inWhichResType: ResType; inWhichResID: SInt16; inMessageIndex: SInt16; inMessageState: SInt16; VAR outOptions: UInt32; VAR outTip: Point; VAR outHotRect: Rect; VAR outWindowProcID: SInt16; VAR outBalloonVariant: BalloonVariant; VAR outHelpMessage: HMMessageRecord; VAR outMessageCount: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $1306, $A830;
	{$ENDC}

{
 *  HMIsBalloon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMIsBalloon: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0007, $A830;
	{$ENDC}

{
 *  HMGetBalloons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMGetBalloons: BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0003, $A830;
	{$ENDC}

{
 *  HMSetBalloons()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMSetBalloons(flag: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0104, $A830;
	{$ENDC}

{
 *  HMSetFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMSetFont(font: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0108, $A830;
	{$ENDC}

{
 *  HMSetFontSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMSetFontSize(fontSize: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0109, $A830;
	{$ENDC}

{
 *  HMGetFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMGetFont(VAR font: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020A, $A830;
	{$ENDC}

{
 *  HMGetFontSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMGetFontSize(VAR fontSize: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020B, $A830;
	{$ENDC}

{
 *  HMSetDialogResID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMSetDialogResID(resID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $010C, $A830;
	{$ENDC}

{
 *  HMSetMenuResID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMSetMenuResID(menuID: SInt16; resID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020D, $A830;
	{$ENDC}

{
 *  HMBalloonRect()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMBalloonRect({CONST}VAR inMessage: HMMessageRecord; VAR outRect: Rect): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040E, $A830;
	{$ENDC}

{
 *  HMBalloonPict()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMBalloonPict({CONST}VAR inMessage: HMMessageRecord; VAR outPict: PicHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $040F, $A830;
	{$ENDC}

{
 *  HMScanTemplateItems()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMScanTemplateItems(whichID: SInt16; whichResFile: SInt16; whichType: ResType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0410, $A830;
	{$ENDC}

{
 *  HMExtractHelpMsg()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMExtractHelpMsg(inType: ResType; inResID: SInt16; inMessageIndex: SInt16; inMessageState: SInt16; VAR outMessage: HMMessageRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0711, $A830;
	{$ENDC}

{
 *  HMGetDialogResID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMGetDialogResID(VAR resID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0213, $A830;
	{$ENDC}

{
 *  HMGetMenuResID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMGetMenuResID(menuID: SInt16; VAR resID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0314, $A830;
	{$ENDC}

{
 *  HMGetBalloonWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION HMGetBalloonWindow(VAR window: WindowRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0215, $A830;
	{$ENDC}





{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := BalloonsIncludes}

{$ENDC} {__BALLOONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

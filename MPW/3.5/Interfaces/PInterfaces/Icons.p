{
     File:       Icons.p
 
     Contains:   Icon Utilities and Icon Services Interfaces.
 
     Version:    Technology: Mac OS 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1990-2001 by Apple Computer, Inc. All rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Icons;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ICONS__}
{$SETC __ICONS__ := 1}

{$I+}
{$SETC IconsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{$IFC UNDEFINED __FILES__}
{$I Files.p}
{$ENDC}
{$IFC UNDEFINED __CODEFRAGMENTS__}
{$I CodeFragments.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{ The following are icons for which there are both icon suites and SICNs. }
{ Avoid using icon resources if possible. Use IconServices instead. }

CONST
	kGenericDocumentIconResource = -4000;
	kGenericStationeryIconResource = -3985;
	kGenericEditionFileIconResource = -3989;
	kGenericApplicationIconResource = -3996;
	kGenericDeskAccessoryIconResource = -3991;
	kGenericFolderIconResource	= -3999;
	kPrivateFolderIconResource	= -3994;
	kFloppyIconResource			= -3998;
	kTrashIconResource			= -3993;
	kGenericRAMDiskIconResource	= -3988;
	kGenericCDROMIconResource	= -3987;

	{	 The following are icons for which there are SICNs only. 	}
	{	 Avoid using icon resources if possible. Use IconServices instead. 	}
	kDesktopIconResource		= -3992;
	kOpenFolderIconResource		= -3997;
	kGenericHardDiskIconResource = -3995;
	kGenericFileServerIconResource = -3972;
	kGenericSuitcaseIconResource = -3970;
	kGenericMoverObjectIconResource = -3969;

	{	 The following are icons for which there are icon suites only. 	}
	{	 Avoid using icon resources if possible. Use IconServices instead. 	}
	kGenericPreferencesIconResource = -3971;
	kGenericQueryDocumentIconResource = -16506;
	kGenericExtensionIconResource = -16415;
	kSystemFolderIconResource	= -3983;
	kHelpIconResource			= -20271;
	kAppleMenuFolderIconResource = -3982;

	{	 Obsolete. Use named constants defined above. 	}
	genericDocumentIconResource	= -4000;
	genericStationeryIconResource = -3985;
	genericEditionFileIconResource = -3989;
	genericApplicationIconResource = -3996;
	genericDeskAccessoryIconResource = -3991;
	genericFolderIconResource	= -3999;
	privateFolderIconResource	= -3994;
	floppyIconResource			= -3998;
	trashIconResource			= -3993;
	genericRAMDiskIconResource	= -3988;
	genericCDROMIconResource	= -3987;
	desktopIconResource			= -3992;
	openFolderIconResource		= -3997;
	genericHardDiskIconResource	= -3995;
	genericFileServerIconResource = -3972;
	genericSuitcaseIconResource	= -3970;
	genericMoverObjectIconResource = -3969;
	genericPreferencesIconResource = -3971;
	genericQueryDocumentIconResource = -16506;
	genericExtensionIconResource = -16415;
	systemFolderIconResource	= -3983;
	appleMenuFolderIconResource	= -3982;

	{	 Avoid using icon resources if possible. Use IconServices instead. 	}
	kStartupFolderIconResource	= -3981;
	kOwnedFolderIconResource	= -3980;
	kDropFolderIconResource		= -3979;
	kSharedFolderIconResource	= -3978;
	kMountedFolderIconResource	= -3977;
	kControlPanelFolderIconResource = -3976;
	kPrintMonitorFolderIconResource = -3975;
	kPreferencesFolderIconResource = -3974;
	kExtensionsFolderIconResource = -3973;
	kFontsFolderIconResource	= -3968;
	kFullTrashIconResource		= -3984;

	{	 Obsolete. Use named constants defined above. 	}
	startupFolderIconResource	= -3981;
	ownedFolderIconResource		= -3980;
	dropFolderIconResource		= -3979;
	sharedFolderIconResource	= -3978;
	mountedFolderIconResource	= -3977;
	controlPanelFolderIconResource = -3976;
	printMonitorFolderIconResource = -3975;
	preferencesFolderIconResource = -3974;
	extensionsFolderIconResource = -3973;
	fontsFolderIconResource		= -3968;
	fullTrashIconResource		= -3984;

	{	 The following icon types can only be used as an icon element 	}
	{	 inside a 'icns' icon family 	}
	kThumbnail32BitData			= 'it32';
	kThumbnail8BitMask			= 't8mk';

	kHuge1BitMask				= 'ich#';
	kHuge4BitData				= 'ich4';
	kHuge8BitData				= 'ich8';
	kHuge32BitData				= 'ih32';
	kHuge8BitMask				= 'h8mk';

	{	 The following icon types can be used as a resource type 	}
	{	 or as an icon element type inside a 'icns' icon family 	}
	kLarge1BitMask				= 'ICN#';
	kLarge4BitData				= 'icl4';
	kLarge8BitData				= 'icl8';
	kLarge32BitData				= 'il32';
	kLarge8BitMask				= 'l8mk';
	kSmall1BitMask				= 'ics#';
	kSmall4BitData				= 'ics4';
	kSmall8BitData				= 'ics8';
	kSmall32BitData				= 'is32';
	kSmall8BitMask				= 's8mk';
	kMini1BitMask				= 'icm#';
	kMini4BitData				= 'icm4';
	kMini8BitData				= 'icm8';

	{	  Icon Variants 	}
	{	 These can be used as an element of an 'icns' icon family 	}
	{	 or as a parameter to GetIconRefVariant 	}
	kTileIconVariant			= 'tile';
	kRolloverIconVariant		= 'over';
	kDropIconVariant			= 'drop';
	kOpenIconVariant			= 'open';
	kOpenDropIconVariant		= 'odrp';

	{	 Obsolete. Use names defined above. 	}
	large1BitMask				= 'ICN#';
	large4BitData				= 'icl4';
	large8BitData				= 'icl8';
	small1BitMask				= 'ics#';
	small4BitData				= 'ics4';
	small8BitData				= 'ics8';
	mini1BitMask				= 'icm#';
	mini4BitData				= 'icm4';
	mini8BitData				= 'icm8';

	{	 Alignment type values. 	}
	kAlignNone					= $00;
	kAlignVerticalCenter		= $01;
	kAlignTop					= $02;
	kAlignBottom				= $03;
	kAlignHorizontalCenter		= $04;
	kAlignAbsoluteCenter		= $05;
	kAlignCenterTop				= $06;
	kAlignCenterBottom			= $07;
	kAlignLeft					= $08;
	kAlignCenterLeft			= $09;
	kAlignTopLeft				= $0A;
	kAlignBottomLeft			= $0B;
	kAlignRight					= $0C;
	kAlignCenterRight			= $0D;
	kAlignTopRight				= $0E;
	kAlignBottomRight			= $0F;

	{	 Obsolete. Use names defined above. 	}
	atNone						= $00;
	atVerticalCenter			= $01;
	atTop						= $02;
	atBottom					= $03;
	atHorizontalCenter			= $04;
	atAbsoluteCenter			= $05;
	atCenterTop					= $06;
	atCenterBottom				= $07;
	atLeft						= $08;
	atCenterLeft				= $09;
	atTopLeft					= $0A;
	atBottomLeft				= $0B;
	atRight						= $0C;
	atCenterRight				= $0D;
	atTopRight					= $0E;
	atBottomRight				= $0F;


TYPE
	IconAlignmentType					= SInt16;
	{	 Transform type values. 	}

CONST
	kTransformNone				= $00;
	kTransformDisabled			= $01;
	kTransformOffline			= $02;
	kTransformOpen				= $03;
	kTransformLabel1			= $0100;
	kTransformLabel2			= $0200;
	kTransformLabel3			= $0300;
	kTransformLabel4			= $0400;
	kTransformLabel5			= $0500;
	kTransformLabel6			= $0600;
	kTransformLabel7			= $0700;
	kTransformSelected			= $4000;
	kTransformSelectedDisabled	= $4001;
	kTransformSelectedOffline	= $4002;
	kTransformSelectedOpen		= $4003;

	{	 Obsolete. Use names defined above. 	}
	ttNone						= $00;
	ttDisabled					= $01;
	ttOffline					= $02;
	ttOpen						= $03;
	ttLabel1					= $0100;
	ttLabel2					= $0200;
	ttLabel3					= $0300;
	ttLabel4					= $0400;
	ttLabel5					= $0500;
	ttLabel6					= $0600;
	ttLabel7					= $0700;
	ttSelected					= $4000;
	ttSelectedDisabled			= $4001;
	ttSelectedOffline			= $4002;
	ttSelectedOpen				= $4003;


TYPE
	IconTransformType					= SInt16;
	{	 Selector mask values. 	}

CONST
	kSelectorLarge1Bit			= $00000001;
	kSelectorLarge4Bit			= $00000002;
	kSelectorLarge8Bit			= $00000004;
	kSelectorLarge32Bit			= $00000008;
	kSelectorLarge8BitMask		= $00000010;
	kSelectorSmall1Bit			= $00000100;
	kSelectorSmall4Bit			= $00000200;
	kSelectorSmall8Bit			= $00000400;
	kSelectorSmall32Bit			= $00000800;
	kSelectorSmall8BitMask		= $00001000;
	kSelectorMini1Bit			= $00010000;
	kSelectorMini4Bit			= $00020000;
	kSelectorMini8Bit			= $00040000;
	kSelectorHuge1Bit			= $01000000;
	kSelectorHuge4Bit			= $02000000;
	kSelectorHuge8Bit			= $04000000;
	kSelectorHuge32Bit			= $08000000;
	kSelectorHuge8BitMask		= $10000000;
	kSelectorAllLargeData		= $000000FF;
	kSelectorAllSmallData		= $0000FF00;
	kSelectorAllMiniData		= $00FF0000;
	kSelectorAllHugeData		= $FF000000;
	kSelectorAll1BitData		= $01010101;
	kSelectorAll4BitData		= $02020202;
	kSelectorAll8BitData		= $04040404;
	kSelectorAll32BitData		= $08000808;
	kSelectorAllAvailableData	= $FFFFFFFF;


	{	 Obsolete. Use names defined above. 	}
	svLarge1Bit					= $00000001;
	svLarge4Bit					= $00000002;
	svLarge8Bit					= $00000004;
	svSmall1Bit					= $00000100;
	svSmall4Bit					= $00000200;
	svSmall8Bit					= $00000400;
	svMini1Bit					= $00010000;
	svMini4Bit					= $00020000;
	svMini8Bit					= $00040000;
	svAllLargeData				= $000000FF;
	svAllSmallData				= $0000FF00;
	svAllMiniData				= $00FF0000;
	svAll1BitData				= $01010101;
	svAll4BitData				= $02020202;
	svAll8BitData				= $04040404;
	svAllAvailableData			= $FFFFFFFF;


TYPE
	IconSelectorValue					= UInt32;
{$IFC TYPED_FUNCTION_POINTERS}
	IconActionProcPtr = FUNCTION(theType: ResType; VAR theIcon: Handle; yourDataPtr: UNIV Ptr): OSErr;
{$ELSEC}
	IconActionProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	IconGetterProcPtr = FUNCTION(theType: ResType; yourDataPtr: UNIV Ptr): Handle;
{$ELSEC}
	IconGetterProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	IconActionUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	IconActionUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	IconGetterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	IconGetterUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppIconActionProcInfo = $00000FE0;
	uppIconGetterProcInfo = $000003F0;
	{
	 *  NewIconActionUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewIconActionUPP(userRoutine: IconActionProcPtr): IconActionUPP; { old name was NewIconActionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewIconGetterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewIconGetterUPP(userRoutine: IconGetterProcPtr): IconGetterUPP; { old name was NewIconGetterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeIconActionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeIconActionUPP(userUPP: IconActionUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeIconGetterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeIconGetterUPP(userUPP: IconGetterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeIconActionUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeIconActionUPP(theType: ResType; VAR theIcon: Handle; yourDataPtr: UNIV Ptr; userRoutine: IconActionUPP): OSErr; { old name was CallIconActionProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeIconGetterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeIconGetterUPP(theType: ResType; yourDataPtr: UNIV Ptr; userRoutine: IconGetterUPP): Handle; { old name was CallIconGetterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}


TYPE
	IconGetter							= IconGetterProcPtr;
	IconAction							= IconActionProcPtr;
	{  CIconHandle, GetCIcon(), PlotCIcon(), and DisposeCIcon() moved here from Quickdraw.h }
	CIconPtr = ^CIcon;
	CIcon = RECORD
		iconPMap:				PixMap;									{ the icon's pixMap }
		iconMask:				BitMap;									{ the icon's mask }
		iconBMap:				BitMap;									{ the icon's bitMap }
		iconData:				Handle;									{ the icon's data }
		iconMaskData:			ARRAY [0..0] OF SInt16;					{ icon's mask and BitMap data }
	END;

	CIconHandle							= ^CIconPtr;
	{
	 *  GetCIcon()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION GetCIcon(iconID: SInt16): CIconHandle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA1E;
	{$ENDC}

{
 *  PlotCIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PlotCIcon({CONST}VAR theRect: Rect; theIcon: CIconHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA1F;
	{$ENDC}

{
 *  DisposeCIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeCIcon(theIcon: CIconHandle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $AA25;
	{$ENDC}


{  GetIcon and PlotIcon moved here from ToolUtils }
{
 *  GetIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIcon(iconID: SInt16): Handle;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9BB;
	{$ENDC}

{
 *  PlotIcon()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PlotIcon({CONST}VAR theRect: Rect; theIcon: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A94B;
	{$ENDC}



{
    Note:   IconSuiteRef and IconCacheRef should be an abstract types, 
            but too much source code already relies on them being of type Handle.
}

TYPE
	IconSuiteRef						= Handle;
	IconCacheRef						= Handle;
	{  IconRefs are 32-bit values identifying cached icon data. IconRef 0 is invalid. }
	IconRef    = ^LONGINT; { an opaque 32-bit type }
	IconRefPtr = ^IconRef;  { when a VAR xx:IconRef parameter can be nil, it is changed to xx: IconRefPtr }
	{
	 *  PlotIconID()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION PlotIconID({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theResID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0500, $ABC9;
	{$ENDC}

{
 *  NewIconSuite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewIconSuite(VAR theIconSuite: IconSuiteRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0207, $ABC9;
	{$ENDC}

{
 *  AddIconToSuite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AddIconToSuite(theIconData: Handle; theSuite: IconSuiteRef; theType: ResType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0608, $ABC9;
	{$ENDC}

{
 *  GetIconFromSuite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIconFromSuite(VAR theIconData: Handle; theSuite: IconSuiteRef; theType: ResType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0609, $ABC9;
	{$ENDC}

{
 *  ForEachIconDo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ForEachIconDo(theSuite: IconSuiteRef; selector: IconSelectorValue; action: IconActionUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $080A, $ABC9;
	{$ENDC}

{
 *  GetIconSuite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIconSuite(VAR theIconSuite: IconSuiteRef; theResID: SInt16; selector: IconSelectorValue): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0501, $ABC9;
	{$ENDC}

{
 *  DisposeIconSuite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DisposeIconSuite(theIconSuite: IconSuiteRef; disposeData: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0302, $ABC9;
	{$ENDC}

{
 *  PlotIconSuite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PlotIconSuite({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theIconSuite: IconSuiteRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0603, $ABC9;
	{$ENDC}

{
 *  MakeIconCache()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MakeIconCache(VAR theCache: IconCacheRef; makeIcon: IconGetterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0604, $ABC9;
	{$ENDC}

{
 *  LoadIconCache()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION LoadIconCache({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theIconCache: IconCacheRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0606, $ABC9;
	{$ENDC}

{
 *  PlotIconMethod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PlotIconMethod({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theMethod: IconGetterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0805, $ABC9;
	{$ENDC}

{
 *  GetLabel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetLabel(labelNumber: SInt16; VAR labelColor: RGBColor; VAR labelString: Str255): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $050B, $ABC9;
	{$ENDC}

{
 *  PtInIconID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PtInIconID(testPt: Point; {CONST}VAR iconRect: Rect; align: IconAlignmentType; iconID: SInt16): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $060D, $ABC9;
	{$ENDC}

{
 *  PtInIconSuite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PtInIconSuite(testPt: Point; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theIconSuite: IconSuiteRef): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $070E, $ABC9;
	{$ENDC}

{
 *  PtInIconMethod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PtInIconMethod(testPt: Point; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theMethod: IconGetterUPP; yourDataPtr: UNIV Ptr): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $090F, $ABC9;
	{$ENDC}

{
 *  RectInIconID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RectInIconID({CONST}VAR testRect: Rect; {CONST}VAR iconRect: Rect; align: IconAlignmentType; iconID: SInt16): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0610, $ABC9;
	{$ENDC}

{
 *  RectInIconSuite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RectInIconSuite({CONST}VAR testRect: Rect; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theIconSuite: IconSuiteRef): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0711, $ABC9;
	{$ENDC}

{
 *  RectInIconMethod()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RectInIconMethod({CONST}VAR testRect: Rect; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theMethod: IconGetterUPP; yourDataPtr: UNIV Ptr): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0912, $ABC9;
	{$ENDC}

{
 *  IconIDToRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IconIDToRgn(theRgn: RgnHandle; {CONST}VAR iconRect: Rect; align: IconAlignmentType; iconID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0613, $ABC9;
	{$ENDC}

{
 *  IconSuiteToRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IconSuiteToRgn(theRgn: RgnHandle; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theIconSuite: IconSuiteRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0714, $ABC9;
	{$ENDC}

{
 *  IconMethodToRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IconMethodToRgn(theRgn: RgnHandle; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theMethod: IconGetterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0915, $ABC9;
	{$ENDC}

{
 *  SetSuiteLabel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetSuiteLabel(theSuite: IconSuiteRef; theLabel: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0316, $ABC9;
	{$ENDC}

{
 *  GetSuiteLabel()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetSuiteLabel(theSuite: IconSuiteRef): SInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0217, $ABC9;
	{$ENDC}

{
 *  GetIconCacheData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIconCacheData(theCache: IconCacheRef; VAR theData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0419, $ABC9;
	{$ENDC}

{
 *  SetIconCacheData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetIconCacheData(theCache: IconCacheRef; theData: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $041A, $ABC9;
	{$ENDC}

{
 *  GetIconCacheProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIconCacheProc(theCache: IconCacheRef; VAR theProc: IconGetterUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $041B, $ABC9;
	{$ENDC}

{
 *  SetIconCacheProc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetIconCacheProc(theCache: IconCacheRef; theProc: IconGetterUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $041C, $ABC9;
	{$ENDC}

{
 *  PlotIconHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PlotIconHandle({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theIcon: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $061D, $ABC9;
	{$ENDC}

{
 *  PlotSICNHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PlotSICNHandle({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theSICN: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $061E, $ABC9;
	{$ENDC}

{
 *  PlotCIconHandle()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PlotCIconHandle({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theCIcon: CIconHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $061F, $ABC9;
	{$ENDC}











{
   IconServices is an efficient mechanism to share icon data amongst multiple 
   clients. It avoids duplication of data; it provides efficient caching, 
   releasing memory when the icon data is no longer needed; it can provide
   the appropriate icon for any filesystem object; it can provide commonly 
   used icons (caution, note, help...); it is Appearance-savvy: the icons
   are switched when appropriate.
   IconServices refer to cached icon data using IconRef, a 32-bit opaque
   value. IconRefs are reference counted. When there are no more "owners" 
   of an IconRef, the memory used by the icon bitmap is disposed of.
   Two files of same type and creator with no custom icon will have the same IconRef.
   Files with custom icons will have their own IconRef.
}

{
   Use the special creator kSystemIconsCreator to get "standard" icons 
   that are not associated with a file, such as the help icon.
   Note that all lowercase creators are reserved by Apple.
}

CONST
	kSystemIconsCreator			= 'macs';


	{
	   Type of the predefined/generic icons. For example, the call:
	      err = GetIconRef(kOnSystemDisk, kSystemIconsCreator, kHelpIcon, &iconRef);
	   will retun in iconRef the IconRef for the standard help icon.
	}

	{	 Generic Finder icons 	}
	kClipboardIcon				= 'CLIP';
	kClippingUnknownTypeIcon	= 'clpu';
	kClippingPictureTypeIcon	= 'clpp';
	kClippingTextTypeIcon		= 'clpt';
	kClippingSoundTypeIcon		= 'clps';
	kDesktopIcon				= 'desk';
	kFinderIcon					= 'FNDR';
	kFontSuitcaseIcon			= 'FFIL';
	kFullTrashIcon				= 'ftrh';
	kGenericApplicationIcon		= 'APPL';
	kGenericCDROMIcon			= 'cddr';
	kGenericControlPanelIcon	= 'APPC';
	kGenericControlStripModuleIcon = 'sdev';
	kGenericComponentIcon		= 'thng';
	kGenericDeskAccessoryIcon	= 'APPD';
	kGenericDocumentIcon		= 'docu';
	kGenericEditionFileIcon		= 'edtf';
	kGenericExtensionIcon		= 'INIT';
	kGenericFileServerIcon		= 'srvr';
	kGenericFontIcon			= 'ffil';
	kGenericFontScalerIcon		= 'sclr';
	kGenericFloppyIcon			= 'flpy';
	kGenericHardDiskIcon		= 'hdsk';
	kGenericIDiskIcon			= 'idsk';
	kGenericRemovableMediaIcon	= 'rmov';
	kGenericMoverObjectIcon		= 'movr';
	kGenericPCCardIcon			= 'pcmc';
	kGenericPreferencesIcon		= 'pref';
	kGenericQueryDocumentIcon	= 'qery';
	kGenericRAMDiskIcon			= 'ramd';
	kGenericSharedLibaryIcon	= 'shlb';
	kGenericStationeryIcon		= 'sdoc';
	kGenericSuitcaseIcon		= 'suit';
	kGenericWORMIcon			= 'worm';
	kInternationResourcesIcon	= 'ifil';
	kKeyboardLayoutIcon			= 'kfil';
	kSoundFileIcon				= 'sfil';
	kSystemSuitcaseIcon			= 'zsys';
	kTrashIcon					= 'trsh';
	kTrueTypeFontIcon			= 'tfil';
	kTrueTypeFlatFontIcon		= 'sfnt';
	kTrueTypeMultiFlatFontIcon	= 'ttcf';
	kUserIDiskIcon				= 'udsk';

	{	 Internet locations 	}
	kInternetLocationHTTPIcon	= 'ilht';
	kInternetLocationFTPIcon	= 'ilft';
	kInternetLocationAppleShareIcon = 'ilaf';
	kInternetLocationAppleTalkZoneIcon = 'ilat';
	kInternetLocationFileIcon	= 'ilfi';
	kInternetLocationMailIcon	= 'ilma';
	kInternetLocationNewsIcon	= 'ilnw';
	kInternetLocationNSLNeighborhoodIcon = 'ilns';
	kInternetLocationGenericIcon = 'ilge';

	{	 Folders 	}
	kGenericFolderIcon			= 'fldr';
	kDropFolderIcon				= 'dbox';
	kMountedFolderIcon			= 'mntd';
	kOpenFolderIcon				= 'ofld';
	kOwnedFolderIcon			= 'ownd';
	kPrivateFolderIcon			= 'prvf';
	kSharedFolderIcon			= 'shfl';

	{	 Sharing Privileges icons 	}
	kSharingPrivsNotApplicableIcon = 'shna';
	kSharingPrivsReadOnlyIcon	= 'shro';
	kSharingPrivsReadWriteIcon	= 'shrw';
	kSharingPrivsUnknownIcon	= 'shuk';
	kSharingPrivsWritableIcon	= 'writ';


	{	 Users and Groups icons 	}
	kUserFolderIcon				= 'ufld';
	kWorkgroupFolderIcon		= 'wfld';
	kGuestUserIcon				= 'gusr';
	kUserIcon					= 'user';
	kOwnerIcon					= 'susr';
	kGroupIcon					= 'grup';

	{	 Special folders 	}
	kAppleExtrasFolderIcon		= 'aexƒ';
	kAppleMenuFolderIcon		= 'amnu';
	kApplicationsFolderIcon		= 'apps';
	kApplicationSupportFolderIcon = 'asup';
	kAssistantsFolderIcon		= 'astƒ';
	kContextualMenuItemsFolderIcon = 'cmnu';
	kControlPanelDisabledFolderIcon = 'ctrD';
	kControlPanelFolderIcon		= 'ctrl';
	kControlStripModulesFolderIcon = 'sdvƒ';
	kDocumentsFolderIcon		= 'docs';
	kExtensionsDisabledFolderIcon = 'extD';
	kExtensionsFolderIcon		= 'extn';
	kFavoritesFolderIcon		= 'favs';
	kFontsFolderIcon			= 'font';
	kHelpFolderIcon				= 'ƒhlp';
	kInternetFolderIcon			= 'intƒ';
	kInternetPlugInFolderIcon	= 'ƒnet';
	kLocalesFolderIcon			= 'ƒloc';
	kMacOSReadMeFolderIcon		= 'morƒ';
	kPreferencesFolderIcon		= 'prfƒ';
	kPrinterDescriptionFolderIcon = 'ppdf';
	kPrinterDriverFolderIcon	= 'ƒprd';
	kPrintMonitorFolderIcon		= 'prnt';
	kRecentApplicationsFolderIcon = 'rapp';
	kRecentDocumentsFolderIcon	= 'rdoc';
	kRecentServersFolderIcon	= 'rsrv';
	kScriptingAdditionsFolderIcon = 'ƒscr';
	kSharedLibrariesFolderIcon	= 'ƒlib';
	kScriptsFolderIcon			= 'scrƒ';
	kShutdownItemsDisabledFolderIcon = 'shdD';
	kShutdownItemsFolderIcon	= 'shdf';
	kSpeakableItemsFolder		= 'spki';
	kStartupItemsDisabledFolderIcon = 'strD';
	kStartupItemsFolderIcon		= 'strt';
	kSystemExtensionDisabledFolderIcon = 'macD';
	kSystemFolderIcon			= 'macs';
	kTextEncodingsFolderIcon	= 'ƒtex';
	kAppearanceFolderIcon		= 'appr';
	kUtilitiesFolderIcon		= 'utiƒ';
	kVoicesFolderIcon			= 'fvoc';
	kColorSyncFolderIcon		= 'prof';
	kInternetSearchSitesFolderIcon = 'issf';
	kUsersFolderIcon			= 'usrƒ';

	{	 Badges 	}
	kAppleScriptBadgeIcon		= 'scrp';
	kLockedBadgeIcon			= 'lbdg';
	kMountedBadgeIcon			= 'mbdg';
	kSharedBadgeIcon			= 'sbdg';
	kAliasBadgeIcon				= 'abdg';

	{	 Alert icons 	}
	kAlertNoteIcon				= 'note';
	kAlertCautionIcon			= 'caut';
	kAlertStopIcon				= 'stop';

	{	 Networking icons 	}
	kAppleTalkIcon				= 'atlk';
	kAppleTalkZoneIcon			= 'atzn';
	kAFPServerIcon				= 'afps';
	kFTPServerIcon				= 'ftps';
	kHTTPServerIcon				= 'htps';
	kGenericNetworkIcon			= 'gnet';
	kIPFileServerIcon			= 'isrv';

	{	 Other icons 	}
	kAppleLogoIcon				= 'capl';
	kAppleMenuIcon				= 'sapl';
	kBackwardArrowIcon			= 'baro';
	kFavoriteItemsIcon			= 'favr';
	kForwardArrowIcon			= 'faro';
	kGridIcon					= 'grid';
	kHelpIcon					= 'help';
	kKeepArrangedIcon			= 'arng';
	kLockedIcon					= 'lock';
	kNoFilesIcon				= 'nfil';
	kNoFolderIcon				= 'nfld';
	kNoWriteIcon				= 'nwrt';
	kProtectedApplicationFolderIcon = 'papp';
	kProtectedSystemFolderIcon	= 'psys';
	kRecentItemsIcon			= 'rcnt';
	kShortcutIcon				= 'shrt';
	kSortAscendingIcon			= 'asnd';
	kSortDescendingIcon			= 'dsnd';
	kUnlockedIcon				= 'ulck';
	kConnectToIcon				= 'cnct';



	{	  IconServicesUsageFlags 	}

TYPE
	IconServicesUsageFlags				= UInt32;

CONST
	kIconServicesNormalUsageFlag = 0;


	{
	    IconFamily 'icns' resources contain an entire IconFamily (all sizes and depths).  
	   For custom icons, icns IconFamily resources of the custom icon resource ID are fetched first before
	   the classic custom icons (individual 'ics#, ICN#, etc) are fetched.  If the fetch of the icns resource
	   succeeds then the icns is looked at exclusively for the icon data.
	   For custom icons, new icon features such as 32-bit deep icons are only fetched from the icns resource.
	   This is to avoid incompatibilities with cut & paste of new style icons with an older version of the
	   MacOS Finder.
	   DriverGestalt is called with code kdgMediaIconSuite by IconServices after calling FSM to determine a
	   driver icon for a particular device.  The result of the kdgMediaIconSuite call to DriverGestalt should
	   be a pointer an an IconFamily.  In this manner driver vendors can provide rich, detailed drive icons
	   instead of the 1-bit variety previously supported.
	}
	kIconFamilyType				= 'icns';



TYPE
	IconFamilyElementPtr = ^IconFamilyElement;
	IconFamilyElement = RECORD
		elementType:			OSType;									{  'ICN#', 'icl8', etc... }
		elementSize:			Size;									{  Size of this element }
		elementData:			SInt8;
	END;

	IconFamilyResourcePtr = ^IconFamilyResource;
	IconFamilyResource = RECORD
		resourceType:			OSType;									{  Always 'icns' }
		resourceSize:			Size;									{  Total size of this resource }
		elements:				ARRAY [0..0] OF IconFamilyElement;
	END;

	IconFamilyPtr						= ^IconFamilyResource;
	IconFamilyHandle					= ^IconFamilyPtr;
	{
	  ==============================================================================
	   Initialization and Termination
	  ==============================================================================
	}

	{
	   IconServicesInit
	   
	   Call this routine once per classic 68K application initialization.
	   This routine does not need to be called at boot time.
	}

{$IFC CALL_NOT_IN_CARBON }
	{
	 *  IconServicesInit()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION IconServicesInit(initBlockPtr: CFragInitBlockPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7015, $AA75;
	{$ENDC}


{
   IconServicesTerminate:
   
   Call this routine once from the termination of a classic 68K application.
   This routine does not need to be called at boot time.
}

{
 *  IconServicesTerminate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE IconServicesTerminate;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7016, $AA75;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{
  ==============================================================================
   Converting data structures
  ==============================================================================
}


{
   IconRefToIconFamily
   This routines returns a new IconFamily that contains the data corresponding
   to the specified IconRef.
}

{
 *  IconRefToIconFamily()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IconRefToIconFamily(theIconRef: IconRef; whichIcons: IconSelectorValue; VAR iconFamily: IconFamilyHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7024, $AA75;
	{$ENDC}


{
   IconFamilyToIconSuite
   This routine transfers the data from an icon family handle into an icon suite.
}

{
 *  IconFamilyToIconSuite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IconFamilyToIconSuite(iconFamily: IconFamilyHandle; whichIcons: IconSelectorValue; VAR iconSuite: IconSuiteRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7025, $AA75;
	{$ENDC}


{
   IconSuiteToIconFamily
   This routine transfers the data in an icon suite into an icon family.
}

{
 *  IconSuiteToIconFamily()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IconSuiteToIconFamily(iconSuite: IconSuiteRef; whichIcons: IconSelectorValue; VAR iconFamily: IconFamilyHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7026, $AA75;
	{$ENDC}


{
   SetIconFamilyData
   Change the data of an icon family. The data is copied.
   The type can be one of the icon type, or 'PICT'.
   The data will be compressed if needed.
}

{
 *  SetIconFamilyData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetIconFamilyData(iconFamily: IconFamilyHandle; iconType: OSType; h: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7030, $AA75;
	{$ENDC}


{
   GetIconFamilyData
   Return a copy of the data in the icon family.
   The type can be one of the icon type, or 'PICT'
   The data will be returned uncompressed.
   The handle (h) will be resized as appropriate. If no data of the 
   requested type is present, the handle size will be set to 0.
}

{
 *  GetIconFamilyData()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIconFamilyData(iconFamily: IconFamilyHandle; iconType: OSType; h: Handle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7031, $AA75;
	{$ENDC}


{
  ==============================================================================
   Reference counting
  ==============================================================================
}


{
   GetIconRefOwners
   
   This routine returns the reference count for the IconRef, or number of owners.
   
   A valid IconRef always has at least one owner.
}

{
 *  GetIconRefOwners()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIconRefOwners(theIconRef: IconRef; VAR owners: UInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700B, $AA75;
	{$ENDC}


{
   AcquireIconRef
   This routine increments the reference count for the IconRef
}

{
 *  AcquireIconRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AcquireIconRef(theIconRef: IconRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7027, $AA75;
	{$ENDC}



{
   ReleaseIconRef
   
   This routine decrements the reference count for the IconRef.
   
   When the reference count reaches 0, all memory allocated for the icon
   is disposed. Any subsequent use of the IconRef is invalid.
}

{
 *  ReleaseIconRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ReleaseIconRef(theIconRef: IconRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7028, $AA75;
	{$ENDC}



{
  ==============================================================================
   Getting an IconRef
  ==============================================================================
}


{
   GetIconRefFromFile
   
   This routine returns an icon ref for the specified file, folder or volume.
   The label information is provided separately, since two files with the same icon 
   but a different label would share the same iconRef. The label can be used in 
   PlotIconRef() for example.
   
   Use this routine if you have no information about the file system object. If 
   you have already done a GetCatInfo on the file and want to save some I/O, 
   call GetIconRefFromFolder() if you know it's a folder with no custom icon or 
   call GetIconRef() if it's a file with no custom icon.
   This routine increments the reference count of the returned IconRef. Call 
   ReleaseIconRef() when you're done with it.
}

{
 *  GetIconRefFromFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIconRefFromFile({CONST}VAR theFile: FSSpec; VAR theIconRef: IconRef; VAR theLabel: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7002, $AA75;
	{$ENDC}



{
   GetIconRef
   
   This routine returns an icon ref for an icon in the desktop database or
   for a registered icon.
   The system registers a set of icon such as the help icon with the creator 
   code kSystemIconsCreator. See above for a list of the registered system types.
   The vRefNum is used as a hint on where to look for the icon first. Use 
   kOnSystemDisk if you don't know what to pass.
   This routine increments the reference count of the returned IconRef. Call 
   ReleaseIconRef() when you're done with it.
}

{
 *  GetIconRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIconRef(vRefNum: SInt16; creator: OSType; iconType: OSType; VAR theIconRef: IconRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7021, $AA75;
	{$ENDC}



{
   GetIconRefFromFolder
   
   This routine returns an icon ref for a folder with no custom icon.
   Use the more generic, but slightly slower, GetIconRefFromFile() if
   you don't already have the necessary info about the file.
   Attributes should be CInfoPBRec.dirInfo.ioFlAttrib for this folder.
   Access privileges should be CInfoPBRec.dirInfo.ioACUser for this folder.
   This routine increments the reference count of the IconRef. Call ReleaseIconRef() 
   when you're done with it.
}

{
 *  GetIconRefFromFolder()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIconRefFromFolder(vRefNum: SInt16; parentFolderID: SInt32; folderID: SInt32; attributes: SInt8; accessPrivileges: SInt8; VAR theIconRef: IconRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7022, $AA75;
	{$ENDC}



{
  ==============================================================================
   Adding and modifying IconRef
  ==============================================================================
}


{
   RegisterIconRefFromIconFamily
   This routine adds a new entry to the IconRef registry. Other clients will be 
   able to access it using the (creator, iconType) pair specified here.
   Lower-case creators are reserved for the system.
   Consider using RegisterIconRefFromResource() if possible, since the data 
   registered using RegisterIconRefFromFamily() cannot be purged.
   The iconFamily data is copied and the caller is reponsible for disposing of it.
   This routine increments the reference count of the IconRef. Call ReleaseIconRef() 
   when you're done with it.
}

{
 *  RegisterIconRefFromIconFamily()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RegisterIconRefFromIconFamily(creator: OSType; iconType: OSType; iconFamily: IconFamilyHandle; VAR theIconRef: IconRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701C, $AA75;
	{$ENDC}


{
   RegisterIconRefFromResource
   
   Registers an IconRef from a resouce file.  
   Lower-case creators are reserved for the system.
   The icon data to be fetched is either classic icon data or an icon family.  
   The 'icns' icon family is searched for before the classic icon data.
   This routine increments the reference count of the IconRef. Call ReleaseIconRef() 
   when you're done with it.
}

{
 *  RegisterIconRefFromResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RegisterIconRefFromResource(creator: OSType; iconType: OSType; {CONST}VAR resourceFile: FSSpec; resourceID: SInt16; VAR theIconRef: IconRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7023, $AA75;
	{$ENDC}


{
   UnregisterIconRef
   
   Removes the specified icon from the icon cache (if there are no users of it).  
   If some clients are using this iconRef, then the IconRef will be removed when the 
   last user calls ReleaseIconRef.
}

{
 *  UnregisterIconRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UnregisterIconRef(creator: OSType; iconType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7008, $AA75;
	{$ENDC}



{
   UpdateIconRef
   
   Call this routine to force an update of the data for iconRef.
   
   For example after changing an icon in the desktop database or changing the custom 
   icon of a file. Note that after _adding_ a custom icon to file or folder, you 
   need to call GetIconRefFromFile() to get a new IconRef specific to this file. 
   
   This routine does nothing if the IconRef is a registered icon.
}

{
 *  UpdateIconRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UpdateIconRef(theIconRef: IconRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7009, $AA75;
	{$ENDC}



{
   OverrideIconRefFromResource
   
   This routines replaces the bitmaps of the specified IconRef with the ones
   in the specified resource file.
}

{
 *  OverrideIconRefFromResource()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OverrideIconRefFromResource(theIconRef: IconRef; {CONST}VAR resourceFile: FSSpec; resourceID: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702A, $AA75;
	{$ENDC}



{
   OverrideIconRef
   
   This routines replaces the bitmaps of the specified IconRef with the ones
   from the new IconRef.
}

{
 *  OverrideIconRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION OverrideIconRef(oldIconRef: IconRef; newIconRef: IconRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $702B, $AA75;
	{$ENDC}


{
   RemoveIconRefOverride
   This routine remove an override if one was applied to the icon and 
   reverts back to the original bitmap data.
}

{
 *  RemoveIconRefOverride()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveIconRefOverride(theIconRef: IconRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701E, $AA75;
	{$ENDC}



{
  ==============================================================================
   Creating composite IconRef
  ==============================================================================
}


{
   CompositeIconRef
   
   Superimposes an IconRef on top of another one
}

{
 *  CompositeIconRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CompositeIconRef(backgroundIconRef: IconRef; foregroundIconRef: IconRef; VAR compositeIconRef: IconRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7014, $AA75;
	{$ENDC}


{
   IsIconRefComposite
   Indicates if a given icon ref is a composite of two other icon refs (and which ones)
   If it isn't a composite, backgroundIconRef and foreGroundIconRef will be 0.
}

{
 *  IsIconRefComposite()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsIconRefComposite(compositeIconRef: IconRef; VAR backgroundIconRef: IconRef; VAR foregroundIconRef: IconRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701A, $AA75;
	{$ENDC}



{
  ==============================================================================
   Using IconRef
  ==============================================================================
}

{
   IsValidIconRef
   Return true if the iconRef passed in is a valid icon ref
}

{
 *  IsValidIconRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsValidIconRef(theIconRef: IconRef): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7032, $AA75;
	{$ENDC}


{
   PlotIconRef
   
   This routine plots the IconRef.  It mostly takes the same parameters as 
   PlotIconSuite. Pass kIconServicesNormalUsageFlag as a default value for 
   IconServicesUsageFlags.
}

{
 *  PlotIconRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PlotIconRef({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theIconServicesUsageFlags: IconServicesUsageFlags; theIconRef: IconRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700E, $AA75;
	{$ENDC}


{
   PtInIconRef
   
   This routine indicates if testPt would hit the icon designated by iconRef.
   It mostly takes the same parameters as PtInIconSuite.
   Pass kIconServicesNormalUsageFlag as a default value for IconServicesUsageFlags.
}


{
 *  PtInIconRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PtInIconRef({CONST}VAR testPt: Point; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theIconServicesUsageFlags: IconServicesUsageFlags; theIconRef: IconRef): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $700F, $AA75;
	{$ENDC}


{
   RectInIconRef
   
   This routine indicates if testRect would intersect the icon designated by iconRef.
   It mostly takes the same parameters as RectInIconSuite.
   Pass kIconServicesNormalUsageFlag as a default value for IconServicesUsageFlags.
}


{
 *  RectInIconRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RectInIconRef({CONST}VAR testRect: Rect; {CONST}VAR iconRect: Rect; align: IconAlignmentType; iconServicesUsageFlags: IconServicesUsageFlags; theIconRef: IconRef): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7010, $AA75;
	{$ENDC}


{
   IconRefToRgn
   
   This routine returns a region for the icon.
   It mostly takes the same parameters as IconSuiteToRgn.
   Pass kIconServicesNormalUsageFlag as a default value for IconServicesUsageFlags.
}

{
 *  IconRefToRgn()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IconRefToRgn(theRgn: RgnHandle; {CONST}VAR iconRect: Rect; align: IconAlignmentType; iconServicesUsageFlags: IconServicesUsageFlags; theIconRef: IconRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7011, $AA75;
	{$ENDC}


{
   GetIconSizesFromIconRef
   
   This routine returns an IconSelectorValue indicating the depths and sizes of 
   icon data which are actually available.  It takes an IconSelectorValue 
   indicating which sizes/depths the caller is interested and returns an 
   IconSelectorValue indicating which sizes/depths exist.
   
   Caution:
   
   This is potentially an extremely expensive call as IconServices may be forced 
   to attempt fetching the data for the IconRef's sizes/depths which may result 
   in hitting the local disk or even the network to obtain the data to determine 
   which sizes/depths actually exist.
   Pass kIconServicesNormalUsageFlag as a default value for IconServicesUsageFlags.
}

{
 *  GetIconSizesFromIconRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIconSizesFromIconRef(iconSelectorInput: IconSelectorValue; VAR iconSelectorOutputPtr: IconSelectorValue; iconServicesUsageFlags: IconServicesUsageFlags; theIconRef: IconRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7012, $AA75;
	{$ENDC}



{
  ==============================================================================
   Flushing IconRef data
  ==============================================================================
}


{
   FlushIconRefs
   
   Making this call will dispose of all the data for the specified icons if 
   the data can be reacquired, for example if the data is provided from a resource.
   '****' is a wildcard for all types or all creators.
}

{
 *  FlushIconRefs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FlushIconRefs(creator: OSType; iconType: OSType): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7029, $AA75;
	{$ENDC}


{
   FlushIconRefsByVolume
   
   This routine disposes of the data for the icons related to the indicated volume
   if this data can be reacquired, for example if the data is provided from a 
   resource.
}

{
 *  FlushIconRefsByVolume()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FlushIconRefsByVolume(vRefNum: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7018, $AA75;
	{$ENDC}



{
  ==============================================================================
   Controling custom icons
  ==============================================================================
}


{
   SetCustomIconsEnabled
   
   Enable or disable custom icons on the specified volume.
}

{
 *  SetCustomIconsEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetCustomIconsEnabled(vRefNum: SInt16; enableCustomIcons: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $701F, $AA75;
	{$ENDC}


{
   GetCustomIconsEnabled
   
   Return true if custom icons are enabled on the specified volume, false otherwise.
}

{
 *  GetCustomIconsEnabled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCustomIconsEnabled(vRefNum: SInt16; VAR customIconsEnabled: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7020, $AA75;
	{$ENDC}


{
   IsIconRefMaskEmpty
   Returns true if the mask for this icon is blank
}

{
 *  IsIconRefMaskEmpty()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 8.5 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsIconRefMaskEmpty(iconRef: IconRef): BOOLEAN;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7033, $AA75;
	{$ENDC}


{
   GetIconRefVariant
   Icon variants allows different images to be used with different icon state.
   For example, the 'open' variant for a folder could be represented with
   an open folder.
   Given an icon ref and a desired variant, this routine returns an icon
   ref (which may be the same as the input icon ref) and a transformation 
   which should be used with PlotIconRef() to render the icon appropriately.
   The returned icon ref should be used to do hit-testing.
}

{
 *  GetIconRefVariant()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetIconRefVariant(inIconRef: IconRef; inVariant: OSType; VAR outTransform: IconTransformType): IconRef;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7034, $AA75;
	{$ENDC}



{
  ==============================================================================
   Icon files (.icns files)
  ==============================================================================
}


{
   RegisterIconRefFromIconFile
   This routine adds a new entry to the IconRef registry. Other clients will be 
   able to access it using the (creator, iconType) pair specified here.
   Lower-case creators are reserved for the system.
   If the creator is kSystemIconsCreator and the iconType is 0, a new IconRef
   is always returned. Otherwise, if the creator and type have already been
   registered, the previously registered IconRef is returned.
   This routine increments the reference count of the IconRef. Call ReleaseIconRef() 
   when you're done with it.
}

{
 *  RegisterIconRefFromIconFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RegisterIconRefFromIconFile(creator: OSType; iconType: OSType; {CONST}VAR iconFile: FSSpec; VAR theIconRef: IconRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7035, $AA75;
	{$ENDC}


{
   ReadIconFile
   Read the specified icon file into the icon family handle.
   The caller is responsible for disposing the iconFamily
}

{
 *  ReadIconFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ReadIconFile({CONST}VAR iconFile: FSSpec; VAR iconFamily: IconFamilyHandle): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7036, $AA75;
	{$ENDC}


{
   WriteIconFile
   Write the iconFamily handle to the specified file
}

{
 *  WriteIconFile()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in IconServicesLib 9.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION WriteIconFile(iconFamily: IconFamilyHandle; {CONST}VAR iconFile: FSSpec): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $7037, $AA75;
	{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := IconsIncludes}

{$ENDC} {__ICONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

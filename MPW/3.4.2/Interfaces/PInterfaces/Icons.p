{
 	File:		Icons.p
 
 	Contains:	Icon Utilities Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
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


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{	MixedMode.p													}
{	QuickdrawText.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{ The following are icons for which there are both icon suites and SICNs. }
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
{ The following are icons for which there are SICNs only. }
	kDesktopIconResource		= -3992;
	kOpenFolderIconResource		= -3997;
	kGenericHardDiskIconResource = -3995;
	kGenericFileServerIconResource = -3972;
	kGenericSuitcaseIconResource = -3970;
	kGenericMoverObjectIconResource = -3969;
{ The following are icons for which there are icon suites only. }
	kGenericPreferencesIconResource = -3971;
	kGenericQueryDocumentIconResource = -16506;
	kGenericExtensionIconResource = -16415;
	kSystemFolderIconResource	= -3983;
	kAppleMenuFolderIconResource = -3982;

{ Obsolete. Use named constants defined above. }
	genericDocumentIconResource	= kGenericDocumentIconResource;
	genericStationeryIconResource = kGenericStationeryIconResource;
	genericEditionFileIconResource = kGenericEditionFileIconResource;
	genericApplicationIconResource = kGenericApplicationIconResource;
	genericDeskAccessoryIconResource = kGenericDeskAccessoryIconResource;
	genericFolderIconResource	= kGenericFolderIconResource;
	privateFolderIconResource	= kPrivateFolderIconResource;
	floppyIconResource			= kFloppyIconResource;
	trashIconResource			= kPrivateFolderIconResource;
	genericRAMDiskIconResource	= kGenericRAMDiskIconResource;
	genericCDROMIconResource	= kGenericCDROMIconResource;
	desktopIconResource			= kDesktopIconResource;
	openFolderIconResource		= kOpenFolderIconResource;
	genericHardDiskIconResource	= kGenericHardDiskIconResource;
	genericFileServerIconResource = kGenericFileServerIconResource;
	genericSuitcaseIconResource	= kGenericSuitcaseIconResource;
	genericMoverObjectIconResource = kGenericMoverObjectIconResource;
	genericPreferencesIconResource = kGenericPreferencesIconResource;
	genericQueryDocumentIconResource = kGenericQueryDocumentIconResource;
	genericExtensionIconResource = kGenericExtensionIconResource;
	systemFolderIconResource	= kSystemFolderIconResource;
	appleMenuFolderIconResource	= kAppleMenuFolderIconResource;

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

{ Obsolete. Use named constants defined above. }
	startupFolderIconResource	= kStartupFolderIconResource;
	ownedFolderIconResource		= kOwnedFolderIconResource;
	dropFolderIconResource		= kDropFolderIconResource;
	sharedFolderIconResource	= kSharedFolderIconResource;
	mountedFolderIconResource	= kMountedFolderIconResource;
	controlPanelFolderIconResource = kControlPanelFolderIconResource;
	printMonitorFolderIconResource = kPrintMonitorFolderIconResource;
	preferencesFolderIconResource = kPreferencesFolderIconResource;
	extensionsFolderIconResource = kExtensionsFolderIconResource;
	fontsFolderIconResource		= kFontsFolderIconResource;
	fullTrashIconResource		= kFullTrashIconResource;

	kLarge1BitMask				= 'ICN#';
	kLarge4BitData				= 'icl4';
	kLarge8BitData				= 'icl8';
	kSmall1BitMask				= 'ics#';
	kSmall4BitData				= 'ics4';
	kSmall8BitData				= 'ics8';
	kMini1BitMask				= 'icm#';
	kMini4BitData				= 'icm4';
	kMini8BitData				= 'icm8';

{ Obsolete. Use names defined above. }
	large1BitMask				= kLarge1BitMask;
	large4BitData				= kLarge4BitData;
	large8BitData				= kLarge8BitData;
	small1BitMask				= kSmall1BitMask;
	small4BitData				= kSmall4BitData;
	small8BitData				= kSmall8BitData;
	mini1BitMask				= kMini1BitMask;
	mini4BitData				= kMini4BitData;
	mini8BitData				= kMini8BitData;

{  alignment type values }
	kAlignNone					= $0;
	kAlignVerticalCenter		= $1;
	kAlignTop					= $2;
	kAlignBottom				= $3;
	kAlignHorizontalCenter		= $4;
	kAlignAbsoluteCenter		= kAlignVerticalCenter + kAlignHorizontalCenter;
	kAlignCenterTop				= kAlignTop + kAlignHorizontalCenter;
	kAlignCenterBottom			= kAlignBottom + kAlignHorizontalCenter;
	kAlignLeft					= $8;
	kAlignCenterLeft			= kAlignVerticalCenter + kAlignLeft;
	kAlignTopLeft				= kAlignTop + kAlignLeft;
	kAlignBottomLeft			= kAlignBottom + kAlignLeft;
	kAlignRight					= $C;
	kAlignCenterRight			= kAlignVerticalCenter + kAlignRight;
	kAlignTopRight				= kAlignTop + kAlignRight;
	kAlignBottomRight			= kAlignBottom + kAlignRight;

{ Obsolete. Use names defined above. }
	atNone						= kAlignNone;
	atVerticalCenter			= kAlignVerticalCenter;
	atTop						= kAlignTop;
	atBottom					= kAlignBottom;
	atHorizontalCenter			= kAlignHorizontalCenter;
	atAbsoluteCenter			= kAlignAbsoluteCenter;
	atCenterTop					= kAlignCenterTop;
	atCenterBottom				= kAlignCenterBottom;
	atLeft						= kAlignLeft;
	atCenterLeft				= kAlignCenterLeft;
	atTopLeft					= kAlignTopLeft;
	atBottomLeft				= kAlignBottomLeft;
	atRight						= kAlignRight;
	atCenterRight				= kAlignCenterRight;
	atTopRight					= kAlignTopRight;
	atBottomRight				= kAlignBottomRight;

	
TYPE
	IconAlignmentType = SInt16;

{  transform type values  }

CONST
	kTransformNone				= $0;
	kTransformDisabled			= $1;
	kTransformOffline			= $2;
	kTransformOpen				= $3;
	kTransformLabel1			= $0100;
	kTransformLabel2			= $0200;
	kTransformLabel3			= $0300;
	kTransformLabel4			= $0400;
	kTransformLabel5			= $0500;
	kTransformLabel6			= $0600;
	kTransformLabel7			= $0700;
	kTransformSelected			= $4000;
	kTransformSelectedDisabled	= kTransformSelected + kTransformDisabled;
	kTransformSelectedOffline	= kTransformSelected + kTransformOffline;
	kTransformSelectedOpen		= kTransformSelected + kTransformOpen;

{ Obsolete. Use names defined above. }
	ttNone						= kTransformNone;
	ttDisabled					= kTransformDisabled;
	ttOffline					= kTransformOffline;
	ttOpen						= kTransformOpen;
	ttLabel1					= kTransformLabel1;
	ttLabel2					= kTransformLabel2;
	ttLabel3					= kTransformLabel3;
	ttLabel4					= kTransformLabel4;
	ttLabel5					= kTransformLabel5;
	ttLabel6					= kTransformLabel6;
	ttLabel7					= kTransformLabel7;
	ttSelected					= kTransformSelected;
	ttSelectedDisabled			= kTransformSelectedDisabled;
	ttSelectedOffline			= kTransformSelectedOffline;
	ttSelectedOpen				= kTransformSelectedOpen;

	
TYPE
	IconTransformType = SInt16;

{  Selector mask values  }

CONST
	kSelectorLarge1Bit			= $00000001;
	kSelectorLarge4Bit			= $00000002;
	kSelectorLarge8Bit			= $00000004;
	kSelectorSmall1Bit			= $00000100;
	kSelectorSmall4Bit			= $00000200;
	kSelectorSmall8Bit			= $00000400;
	kSelectorMini1Bit			= $00010000;
	kSelectorMini4Bit			= $00020000;
	kSelectorMini8Bit			= $00040000;
	kSelectorAllLargeData		= $000000FF;
	kSelectorAllSmallData		= $0000FF00;
	kSelectorAllMiniData		= $00FF0000;
	kSelectorAll1BitData		= kSelectorLarge1Bit + kSelectorSmall1Bit + kSelectorMini1Bit;
	kSelectorAll4BitData		= kSelectorLarge4Bit + kSelectorSmall4Bit + kSelectorMini4Bit;
	kSelectorAll8BitData		= kSelectorLarge8Bit + kSelectorSmall8Bit + kSelectorMini8Bit;
	kSelectorAllAvailableData	= $FFFFFFFF;

{ Obsolete. Use names defined above. }
	svLarge1Bit					= kSelectorLarge1Bit;
	svLarge4Bit					= kSelectorLarge4Bit;
	svLarge8Bit					= kSelectorLarge8Bit;
	svSmall1Bit					= kSelectorSmall1Bit;
	svSmall4Bit					= kSelectorSmall4Bit;
	svSmall8Bit					= kSelectorSmall8Bit;
	svMini1Bit					= kSelectorMini1Bit;
	svMini4Bit					= kSelectorMini4Bit;
	svMini8Bit					= kSelectorMini8Bit;
	svAllLargeData				= kSelectorAllLargeData;
	svAllSmallData				= kSelectorAllSmallData;
	svAllMiniData				= kSelectorAllMiniData;
	svAll1BitData				= kSelectorAll1BitData;
	svAll4BitData				= kSelectorAll4BitData;
	svAll8BitData				= kSelectorAll8BitData;
	svAllAvailableData			= kSelectorAllAvailableData;

	
TYPE
	IconSelectorValue = UInt32;

	IconActionProcPtr = ProcPtr;  { FUNCTION IconAction(theType: ResType; VAR theIcon: Handle; yourDataPtr: UNIV Ptr): OSErr; }
	IconActionUPP = UniversalProcPtr;

CONST
	uppIconActionProcInfo = $00000FE0; { FUNCTION (4 byte param, 4 byte param, 4 byte param): 2 byte result; }

FUNCTION NewIconActionProc(userRoutine: IconActionProcPtr): IconActionUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallIconActionProc(theType: ResType; VAR theIcon: Handle; yourDataPtr: UNIV Ptr; userRoutine: IconActionUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	IconAction = IconActionUPP;

	IconGetterProcPtr = ProcPtr;  { FUNCTION IconGetter(theType: ResType; yourDataPtr: UNIV Ptr): Handle; }
	IconGetterUPP = UniversalProcPtr;

CONST
	uppIconGetterProcInfo = $000003F0; { FUNCTION (4 byte param, 4 byte param): 4 byte result; }

FUNCTION NewIconGetterProc(userRoutine: IconGetterProcPtr): IconGetterUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

FUNCTION CallIconGetterProc(theType: ResType; yourDataPtr: UNIV Ptr; userRoutine: IconGetterUPP): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $4E90;
	{$ENDC}
	
TYPE
	IconGetter = IconGetterUPP;

{$IFC NOT OLDROUTINELOCATIONS }
	CIcon = RECORD
		iconPMap:				PixMap;									{the icon's pixMap}
		iconMask:				BitMap;									{the icon's mask}
		iconBMap:				BitMap;									{the icon's bitMap}
		iconData:				Handle;									{the icon's data}
		iconMaskData:			ARRAY [0..0] OF SInt16;					{icon's mask and BitMap data}
	END;

	CIconPtr = ^CIcon;
	CIconHandle = ^CIconPtr;


FUNCTION GetCIcon(iconID: SInt16): CIconHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $AA1E;
	{$ENDC}
PROCEDURE PlotCIcon({CONST}VAR theRect: Rect; theIcon: CIconHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA1F;
	{$ENDC}
PROCEDURE DisposeCIcon(theIcon: CIconHandle);
	{$IFC NOT GENERATINGCFM}
	INLINE $AA25;
	{$ENDC}
{$ENDC}

FUNCTION GetIcon(iconID: SInt16): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9BB;
	{$ENDC}
PROCEDURE PlotIcon({CONST}VAR theRect: Rect; theIcon: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $A94B;
	{$ENDC}
FUNCTION PlotIconID({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theResID: SInt16): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0500, $ABC9;
	{$ENDC}
FUNCTION NewIconSuite(VAR theIconSuite: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0207, $ABC9;
	{$ENDC}
FUNCTION AddIconToSuite(theIconData: Handle; theSuite: Handle; theType: ResType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0608, $ABC9;
	{$ENDC}
FUNCTION GetIconFromSuite(VAR theIconData: Handle; theSuite: Handle; theType: ResType): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0609, $ABC9;
	{$ENDC}
FUNCTION ForEachIconDo(theSuite: Handle; selector: IconSelectorValue; action: IconActionUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $080A, $ABC9;
	{$ENDC}
FUNCTION GetIconSuite(VAR theIconSuite: Handle; theResID: SInt16; selector: IconSelectorValue): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0501, $ABC9;
	{$ENDC}
FUNCTION DisposeIconSuite(theIconSuite: Handle; disposeData: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0302, $ABC9;
	{$ENDC}
FUNCTION PlotIconSuite({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theIconSuite: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0603, $ABC9;
	{$ENDC}
FUNCTION MakeIconCache(VAR theHandle: Handle; makeIcon: IconGetterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0604, $ABC9;
	{$ENDC}
FUNCTION LoadIconCache({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theIconCache: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0606, $ABC9;
	{$ENDC}
FUNCTION PlotIconMethod({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theMethod: IconGetterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0805, $ABC9;
	{$ENDC}
FUNCTION GetLabel(labelNumber: SInt16; VAR labelColor: RGBColor; VAR labelString: Str255): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $050B, $ABC9;
	{$ENDC}
FUNCTION PtInIconID(testPt: Point; {CONST}VAR iconRect: Rect; align: IconAlignmentType; iconID: SInt16): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $060D, $ABC9;
	{$ENDC}
FUNCTION PtInIconSuite(testPt: Point; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theIconSuite: Handle): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $070E, $ABC9;
	{$ENDC}
FUNCTION PtInIconMethod(testPt: Point; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theMethod: IconGetterUPP; yourDataPtr: UNIV Ptr): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $090F, $ABC9;
	{$ENDC}
FUNCTION RectInIconID({CONST}VAR testRect: Rect; {CONST}VAR iconRect: Rect; align: IconAlignmentType; iconID: SInt16): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0610, $ABC9;
	{$ENDC}
FUNCTION RectInIconSuite({CONST}VAR testRect: Rect; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theIconSuite: Handle): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0711, $ABC9;
	{$ENDC}
FUNCTION RectInIconMethod({CONST}VAR testRect: Rect; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theMethod: IconGetterUPP; yourDataPtr: UNIV Ptr): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0912, $ABC9;
	{$ENDC}
FUNCTION IconIDToRgn(theRgn: RgnHandle; {CONST}VAR iconRect: Rect; align: IconAlignmentType; iconID: SInt16): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0613, $ABC9;
	{$ENDC}
FUNCTION IconSuiteToRgn(theRgn: RgnHandle; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theIconSuite: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0714, $ABC9;
	{$ENDC}
FUNCTION IconMethodToRgn(theRgn: RgnHandle; {CONST}VAR iconRect: Rect; align: IconAlignmentType; theMethod: IconGetterUPP; yourDataPtr: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0915, $ABC9;
	{$ENDC}
FUNCTION SetSuiteLabel(theSuite: Handle; theLabel: SInt16): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0316, $ABC9;
	{$ENDC}
FUNCTION GetSuiteLabel(theSuite: Handle): SInt16;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0217, $ABC9;
	{$ENDC}
FUNCTION GetIconCacheData(theCache: Handle; theData: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0419, $ABC9;
	{$ENDC}
FUNCTION SetIconCacheData(theCache: Handle; theData: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $041A, $ABC9;
	{$ENDC}
FUNCTION GetIconCacheProc(theCache: Handle; VAR theProc: IconGetterUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $041B, $ABC9;
	{$ENDC}
FUNCTION SetIconCacheProc(theCache: Handle; theProc: IconGetterUPP): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $041C, $ABC9;
	{$ENDC}
FUNCTION PlotIconHandle({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theIcon: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $061D, $ABC9;
	{$ENDC}
FUNCTION PlotSICNHandle({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theSICN: Handle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $061E, $ABC9;
	{$ENDC}
FUNCTION PlotCIconHandle({CONST}VAR theRect: Rect; align: IconAlignmentType; transform: IconTransformType; theCIcon: CIconHandle): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $061F, $ABC9;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := IconsIncludes}

{$ENDC} {__ICONS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

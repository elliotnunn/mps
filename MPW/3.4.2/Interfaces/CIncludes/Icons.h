/*
 	File:		Icons.h
 
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
 
*/

#ifndef __ICONS__
#define __ICONS__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
/*	#include <MixedMode.h>										*/
/*	#include <QuickdrawText.h>									*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
/* The following are icons for which there are both icon suites and SICNs. */
	kGenericDocumentIconResource = -4000,
	kGenericStationeryIconResource = -3985,
	kGenericEditionFileIconResource = -3989,
	kGenericApplicationIconResource = -3996,
	kGenericDeskAccessoryIconResource = -3991,
	kGenericFolderIconResource	= -3999,
	kPrivateFolderIconResource	= -3994,
	kFloppyIconResource			= -3998,
	kTrashIconResource			= -3993,
	kGenericRAMDiskIconResource	= -3988,
	kGenericCDROMIconResource	= -3987,
/* The following are icons for which there are SICNs only. */
	kDesktopIconResource		= -3992,
	kOpenFolderIconResource		= -3997,
	kGenericHardDiskIconResource = -3995,
	kGenericFileServerIconResource = -3972,
	kGenericSuitcaseIconResource = -3970,
	kGenericMoverObjectIconResource = -3969,
/* The following are icons for which there are icon suites only. */
	kGenericPreferencesIconResource = -3971,
	kGenericQueryDocumentIconResource = -16506,
	kGenericExtensionIconResource = -16415,
	kSystemFolderIconResource	= -3983,
	kAppleMenuFolderIconResource = -3982
};

enum {
/* Obsolete. Use named constants defined above. */
	genericDocumentIconResource	= kGenericDocumentIconResource,
	genericStationeryIconResource = kGenericStationeryIconResource,
	genericEditionFileIconResource = kGenericEditionFileIconResource,
	genericApplicationIconResource = kGenericApplicationIconResource,
	genericDeskAccessoryIconResource = kGenericDeskAccessoryIconResource,
	genericFolderIconResource	= kGenericFolderIconResource,
	privateFolderIconResource	= kPrivateFolderIconResource,
	floppyIconResource			= kFloppyIconResource,
	trashIconResource			= kPrivateFolderIconResource,
	genericRAMDiskIconResource	= kGenericRAMDiskIconResource,
	genericCDROMIconResource	= kGenericCDROMIconResource,
	desktopIconResource			= kDesktopIconResource,
	openFolderIconResource		= kOpenFolderIconResource,
	genericHardDiskIconResource	= kGenericHardDiskIconResource,
	genericFileServerIconResource = kGenericFileServerIconResource,
	genericSuitcaseIconResource	= kGenericSuitcaseIconResource,
	genericMoverObjectIconResource = kGenericMoverObjectIconResource,
	genericPreferencesIconResource = kGenericPreferencesIconResource,
	genericQueryDocumentIconResource = kGenericQueryDocumentIconResource,
	genericExtensionIconResource = kGenericExtensionIconResource,
	systemFolderIconResource	= kSystemFolderIconResource,
	appleMenuFolderIconResource	= kAppleMenuFolderIconResource
};

enum {
	kStartupFolderIconResource	= -3981,
	kOwnedFolderIconResource	= -3980,
	kDropFolderIconResource		= -3979,
	kSharedFolderIconResource	= -3978,
	kMountedFolderIconResource	= -3977,
	kControlPanelFolderIconResource = -3976,
	kPrintMonitorFolderIconResource = -3975,
	kPreferencesFolderIconResource = -3974,
	kExtensionsFolderIconResource = -3973,
	kFontsFolderIconResource	= -3968,
	kFullTrashIconResource		= -3984
};

enum {
/* Obsolete. Use named constants defined above. */
	startupFolderIconResource	= kStartupFolderIconResource,
	ownedFolderIconResource		= kOwnedFolderIconResource,
	dropFolderIconResource		= kDropFolderIconResource,
	sharedFolderIconResource	= kSharedFolderIconResource,
	mountedFolderIconResource	= kMountedFolderIconResource,
	controlPanelFolderIconResource = kControlPanelFolderIconResource,
	printMonitorFolderIconResource = kPrintMonitorFolderIconResource,
	preferencesFolderIconResource = kPreferencesFolderIconResource,
	extensionsFolderIconResource = kExtensionsFolderIconResource,
	fontsFolderIconResource		= kFontsFolderIconResource,
	fullTrashIconResource		= kFullTrashIconResource
};

enum {
	kLarge1BitMask				= 'ICN#',
	kLarge4BitData				= 'icl4',
	kLarge8BitData				= 'icl8',
	kSmall1BitMask				= 'ics#',
	kSmall4BitData				= 'ics4',
	kSmall8BitData				= 'ics8',
	kMini1BitMask				= 'icm#',
	kMini4BitData				= 'icm4',
	kMini8BitData				= 'icm8'
};

enum {
/* Obsolete. Use names defined above. */
	large1BitMask				= kLarge1BitMask,
	large4BitData				= kLarge4BitData,
	large8BitData				= kLarge8BitData,
	small1BitMask				= kSmall1BitMask,
	small4BitData				= kSmall4BitData,
	small8BitData				= kSmall8BitData,
	mini1BitMask				= kMini1BitMask,
	mini4BitData				= kMini4BitData,
	mini8BitData				= kMini8BitData
};

/*  alignment type values */
enum {
	kAlignNone					= 0x0,
	kAlignVerticalCenter		= 0x1,
	kAlignTop					= 0x2,
	kAlignBottom				= 0x3,
	kAlignHorizontalCenter		= 0x4,
	kAlignAbsoluteCenter		= kAlignVerticalCenter | kAlignHorizontalCenter,
	kAlignCenterTop				= kAlignTop | kAlignHorizontalCenter,
	kAlignCenterBottom			= kAlignBottom | kAlignHorizontalCenter,
	kAlignLeft					= 0x8,
	kAlignCenterLeft			= kAlignVerticalCenter | kAlignLeft,
	kAlignTopLeft				= kAlignTop | kAlignLeft,
	kAlignBottomLeft			= kAlignBottom | kAlignLeft,
	kAlignRight					= 0xC,
	kAlignCenterRight			= kAlignVerticalCenter | kAlignRight,
	kAlignTopRight				= kAlignTop | kAlignRight,
	kAlignBottomRight			= kAlignBottom | kAlignRight
};

enum {
/* Obsolete. Use names defined above. */
	atNone						= kAlignNone,
	atVerticalCenter			= kAlignVerticalCenter,
	atTop						= kAlignTop,
	atBottom					= kAlignBottom,
	atHorizontalCenter			= kAlignHorizontalCenter,
	atAbsoluteCenter			= kAlignAbsoluteCenter,
	atCenterTop					= kAlignCenterTop,
	atCenterBottom				= kAlignCenterBottom,
	atLeft						= kAlignLeft,
	atCenterLeft				= kAlignCenterLeft,
	atTopLeft					= kAlignTopLeft,
	atBottomLeft				= kAlignBottomLeft,
	atRight						= kAlignRight,
	atCenterRight				= kAlignCenterRight,
	atTopRight					= kAlignTopRight,
	atBottomRight				= kAlignBottomRight
};

typedef SInt16 IconAlignmentType;

/*  transform type values  */

enum {
	kTransformNone				= 0x0,
	kTransformDisabled			= 0x1,
	kTransformOffline			= 0x2,
	kTransformOpen				= 0x3,
	kTransformLabel1			= 0x0100,
	kTransformLabel2			= 0x0200,
	kTransformLabel3			= 0x0300,
	kTransformLabel4			= 0x0400,
	kTransformLabel5			= 0x0500,
	kTransformLabel6			= 0x0600,
	kTransformLabel7			= 0x0700,
	kTransformSelected			= 0x4000,
	kTransformSelectedDisabled	= kTransformSelected | kTransformDisabled,
	kTransformSelectedOffline	= kTransformSelected | kTransformOffline,
	kTransformSelectedOpen		= kTransformSelected | kTransformOpen
};

enum {
/* Obsolete. Use names defined above. */
	ttNone						= kTransformNone,
	ttDisabled					= kTransformDisabled,
	ttOffline					= kTransformOffline,
	ttOpen						= kTransformOpen,
	ttLabel1					= kTransformLabel1,
	ttLabel2					= kTransformLabel2,
	ttLabel3					= kTransformLabel3,
	ttLabel4					= kTransformLabel4,
	ttLabel5					= kTransformLabel5,
	ttLabel6					= kTransformLabel6,
	ttLabel7					= kTransformLabel7,
	ttSelected					= kTransformSelected,
	ttSelectedDisabled			= kTransformSelectedDisabled,
	ttSelectedOffline			= kTransformSelectedOffline,
	ttSelectedOpen				= kTransformSelectedOpen
};

typedef SInt16 IconTransformType;

/*  Selector mask values  */

enum {
	kSelectorLarge1Bit			= 0x00000001,
	kSelectorLarge4Bit			= 0x00000002,
	kSelectorLarge8Bit			= 0x00000004,
	kSelectorSmall1Bit			= 0x00000100,
	kSelectorSmall4Bit			= 0x00000200,
	kSelectorSmall8Bit			= 0x00000400,
	kSelectorMini1Bit			= 0x00010000,
	kSelectorMini4Bit			= 0x00020000,
	kSelectorMini8Bit			= 0x00040000,
	kSelectorAllLargeData		= 0x000000FF,
	kSelectorAllSmallData		= 0x0000FF00,
	kSelectorAllMiniData		= 0x00FF0000,
	kSelectorAll1BitData		= kSelectorLarge1Bit | kSelectorSmall1Bit | kSelectorMini1Bit,
	kSelectorAll4BitData		= kSelectorLarge4Bit | kSelectorSmall4Bit | kSelectorMini4Bit,
	kSelectorAll8BitData		= kSelectorLarge8Bit | kSelectorSmall8Bit | kSelectorMini8Bit,
	kSelectorAllAvailableData	= 0xFFFFFFFFL
};

enum {
/* Obsolete. Use names defined above. */
	svLarge1Bit					= kSelectorLarge1Bit,
	svLarge4Bit					= kSelectorLarge4Bit,
	svLarge8Bit					= kSelectorLarge8Bit,
	svSmall1Bit					= kSelectorSmall1Bit,
	svSmall4Bit					= kSelectorSmall4Bit,
	svSmall8Bit					= kSelectorSmall8Bit,
	svMini1Bit					= kSelectorMini1Bit,
	svMini4Bit					= kSelectorMini4Bit,
	svMini8Bit					= kSelectorMini8Bit,
	svAllLargeData				= kSelectorAllLargeData,
	svAllSmallData				= kSelectorAllSmallData,
	svAllMiniData				= kSelectorAllMiniData,
	svAll1BitData				= kSelectorAll1BitData,
	svAll4BitData				= kSelectorAll4BitData,
	svAll8BitData				= kSelectorAll8BitData,
	svAllAvailableData			= kSelectorAllAvailableData
};

typedef UInt32 IconSelectorValue;

typedef pascal OSErr (*IconActionProcPtr)(ResType theType, Handle *theIcon, void *yourDataPtr);

#if GENERATINGCFM
typedef UniversalProcPtr IconActionUPP;
#else
typedef IconActionProcPtr IconActionUPP;
#endif

enum {
	uppIconActionProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ResType)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Handle*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewIconActionProc(userRoutine)		\
		(IconActionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppIconActionProcInfo, GetCurrentArchitecture())
#else
#define NewIconActionProc(userRoutine)		\
		((IconActionUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallIconActionProc(userRoutine, theType, theIcon, yourDataPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppIconActionProcInfo, (theType), (theIcon), (yourDataPtr))
#else
#define CallIconActionProc(userRoutine, theType, theIcon, yourDataPtr)		\
		(*(userRoutine))((theType), (theIcon), (yourDataPtr))
#endif

typedef IconActionProcPtr IconAction;

typedef pascal Handle (*IconGetterProcPtr)(ResType theType, void *yourDataPtr);

#if GENERATINGCFM
typedef UniversalProcPtr IconGetterUPP;
#else
typedef IconGetterProcPtr IconGetterUPP;
#endif

enum {
	uppIconGetterProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Handle)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ResType)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewIconGetterProc(userRoutine)		\
		(IconGetterUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppIconGetterProcInfo, GetCurrentArchitecture())
#else
#define NewIconGetterProc(userRoutine)		\
		((IconGetterUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallIconGetterProc(userRoutine, theType, yourDataPtr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppIconGetterProcInfo, (theType), (yourDataPtr))
#else
#define CallIconGetterProc(userRoutine, theType, yourDataPtr)		\
		(*(userRoutine))((theType), (yourDataPtr))
#endif

typedef IconGetterProcPtr IconGetter;

#if !OLDROUTINELOCATIONS
struct CIcon {
	PixMap							iconPMap;					/*the icon's pixMap*/
	BitMap							iconMask;					/*the icon's mask*/
	BitMap							iconBMap;					/*the icon's bitMap*/
	Handle							iconData;					/*the icon's data*/
	SInt16							iconMaskData[1];			/*icon's mask and BitMap data*/
};
typedef struct CIcon CIcon, *CIconPtr, **CIconHandle;

extern pascal CIconHandle GetCIcon(SInt16 iconID)
 ONEWORDINLINE(0xAA1E);
extern pascal void PlotCIcon(const Rect *theRect, CIconHandle theIcon)
 ONEWORDINLINE(0xAA1F);
extern pascal void DisposeCIcon(CIconHandle theIcon)
 ONEWORDINLINE(0xAA25);
#endif
extern pascal Handle GetIcon(SInt16 iconID)
 ONEWORDINLINE(0xA9BB);
extern pascal void PlotIcon(const Rect *theRect, Handle theIcon)
 ONEWORDINLINE(0xA94B);
extern pascal OSErr PlotIconID(const Rect *theRect, IconAlignmentType align, IconTransformType transform, SInt16 theResID)
 THREEWORDINLINE(0x303C, 0x0500, 0xABC9);
extern pascal OSErr NewIconSuite(Handle *theIconSuite)
 THREEWORDINLINE(0x303C, 0x0207, 0xABC9);
extern pascal OSErr AddIconToSuite(Handle theIconData, Handle theSuite, ResType theType)
 THREEWORDINLINE(0x303C, 0x0608, 0xABC9);
extern pascal OSErr GetIconFromSuite(Handle *theIconData, Handle theSuite, ResType theType)
 THREEWORDINLINE(0x303C, 0x0609, 0xABC9);
extern pascal OSErr ForEachIconDo(Handle theSuite, IconSelectorValue selector, IconActionUPP action, void *yourDataPtr)
 THREEWORDINLINE(0x303C, 0x080A, 0xABC9);
extern pascal OSErr GetIconSuite(Handle *theIconSuite, SInt16 theResID, IconSelectorValue selector)
 THREEWORDINLINE(0x303C, 0x0501, 0xABC9);
extern pascal OSErr DisposeIconSuite(Handle theIconSuite, Boolean disposeData)
 THREEWORDINLINE(0x303C, 0x0302, 0xABC9);
extern pascal OSErr PlotIconSuite(const Rect *theRect, IconAlignmentType align, IconTransformType transform, Handle theIconSuite)
 THREEWORDINLINE(0x303C, 0x0603, 0xABC9);
extern pascal OSErr MakeIconCache(Handle *theHandle, IconGetterUPP makeIcon, void *yourDataPtr)
 THREEWORDINLINE(0x303C, 0x0604, 0xABC9);
extern pascal OSErr LoadIconCache(const Rect *theRect, IconAlignmentType align, IconTransformType transform, Handle theIconCache)
 THREEWORDINLINE(0x303C, 0x0606, 0xABC9);
extern pascal OSErr PlotIconMethod(const Rect *theRect, IconAlignmentType align, IconTransformType transform, IconGetterUPP theMethod, void *yourDataPtr)
 THREEWORDINLINE(0x303C, 0x0805, 0xABC9);
extern pascal OSErr GetLabel(SInt16 labelNumber, RGBColor *labelColor, Str255 labelString)
 THREEWORDINLINE(0x303C, 0x050B, 0xABC9);
extern pascal Boolean PtInIconID(Point testPt, const Rect *iconRect, IconAlignmentType align, SInt16 iconID)
 THREEWORDINLINE(0x303C, 0x060D, 0xABC9);
extern pascal Boolean PtInIconSuite(Point testPt, const Rect *iconRect, IconAlignmentType align, Handle theIconSuite)
 THREEWORDINLINE(0x303C, 0x070E, 0xABC9);
extern pascal Boolean PtInIconMethod(Point testPt, const Rect *iconRect, IconAlignmentType align, IconGetterUPP theMethod, void *yourDataPtr)
 THREEWORDINLINE(0x303C, 0x090F, 0xABC9);
extern pascal Boolean RectInIconID(const Rect *testRect, const Rect *iconRect, IconAlignmentType align, SInt16 iconID)
 THREEWORDINLINE(0x303C, 0x0610, 0xABC9);
extern pascal Boolean RectInIconSuite(const Rect *testRect, const Rect *iconRect, IconAlignmentType align, Handle theIconSuite)
 THREEWORDINLINE(0x303C, 0x0711, 0xABC9);
extern pascal Boolean RectInIconMethod(const Rect *testRect, const Rect *iconRect, IconAlignmentType align, IconGetterUPP theMethod, void *yourDataPtr)
 THREEWORDINLINE(0x303C, 0x0912, 0xABC9);
extern pascal OSErr IconIDToRgn(RgnHandle theRgn, const Rect *iconRect, IconAlignmentType align, SInt16 iconID)
 THREEWORDINLINE(0x303C, 0x0613, 0xABC9);
extern pascal OSErr IconSuiteToRgn(RgnHandle theRgn, const Rect *iconRect, IconAlignmentType align, Handle theIconSuite)
 THREEWORDINLINE(0x303C, 0x0714, 0xABC9);
extern pascal OSErr IconMethodToRgn(RgnHandle theRgn, const Rect *iconRect, IconAlignmentType align, IconGetterUPP theMethod, void *yourDataPtr)
 THREEWORDINLINE(0x303C, 0x0915, 0xABC9);
extern pascal OSErr SetSuiteLabel(Handle theSuite, SInt16 theLabel)
 THREEWORDINLINE(0x303C, 0x0316, 0xABC9);
extern pascal SInt16 GetSuiteLabel(Handle theSuite)
 THREEWORDINLINE(0x303C, 0x0217, 0xABC9);
extern pascal OSErr GetIconCacheData(Handle theCache, void **theData)
 THREEWORDINLINE(0x303C, 0x0419, 0xABC9);
extern pascal OSErr SetIconCacheData(Handle theCache, void *theData)
 THREEWORDINLINE(0x303C, 0x041A, 0xABC9);
extern pascal OSErr GetIconCacheProc(Handle theCache, IconGetterUPP *theProc)
 THREEWORDINLINE(0x303C, 0x041B, 0xABC9);
extern pascal OSErr SetIconCacheProc(Handle theCache, IconGetterUPP theProc)
 THREEWORDINLINE(0x303C, 0x041C, 0xABC9);
extern pascal OSErr PlotIconHandle(const Rect *theRect, IconAlignmentType align, IconTransformType transform, Handle theIcon)
 THREEWORDINLINE(0x303C, 0x061D, 0xABC9);
extern pascal OSErr PlotSICNHandle(const Rect *theRect, IconAlignmentType align, IconTransformType transform, Handle theSICN)
 THREEWORDINLINE(0x303C, 0x061E, 0xABC9);
extern pascal OSErr PlotCIconHandle(const Rect *theRect, IconAlignmentType align, IconTransformType transform, CIconHandle theCIcon)
 THREEWORDINLINE(0x303C, 0x061F, 0xABC9);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __ICONS__ */

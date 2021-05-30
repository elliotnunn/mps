/*
 	File:		Displays.h
 
 	Contains:	Display Manager Interfaces.
 
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

#ifndef __DISPLAYS__
#define __DISPLAYS__


#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#ifndef __COMPONENTS__
#include <Components.h>
#endif
/*	#include <Types.h>											*/
/*	#include <MixedMode.h>										*/

#ifndef __VIDEO__
#include <Video.h>
#endif
/*	#include <Quickdraw.h>										*/
/*		#include <QuickdrawText.h>								*/

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
/*	#include <Errors.h>											*/
/*	#include <Memory.h>											*/
/*	#include <OSUtils.h>										*/
/*	#include <Events.h>											*/
/*	#include <EPPC.h>											*/
/*		#include <AppleTalk.h>									*/
/*		#include <Files.h>										*/
/*			#include <Finder.h>									*/
/*		#include <PPCToolbox.h>									*/
/*		#include <Processes.h>									*/
/*	#include <Notification.h>									*/

#ifndef __WINDOWS__
#include <Windows.h>
#endif
/*	#include <Controls.h>										*/
/*		#include <Menus.h>										*/

#ifndef __EVENTS__
#include <Events.h>
#endif

#ifndef __PROCESSES__
#include <Processes.h>
#endif

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif
/*	#include <TextEdit.h>										*/

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
/* AppleEvents Core Suite */
	kAESystemConfigNotice		= 'cnfg',
/* Core Suite types */
	kAEDisplayNotice			= 'dspl',
	kAEDisplaySummary			= 'dsum',
	keyDMConfigVersion			= 'dmcv',
	keyDMConfigFlags			= 'dmcf',
	keyDMConfigReserved			= 'dmcr',
	keyDisplayID				= 'dmid',
	keyDisplayComponent			= 'dmdc',
	keyDisplayDevice			= 'dmdd',
	keyDisplayFlags				= 'dmdf',
	keyDisplayMode				= 'dmdm',
	keyDisplayModeReserved		= 'dmmr',
	keyDisplayReserved			= 'dmdr',
	keyDisplayMirroredId		= 'dmmi',
	keyDeviceFlags				= 'dddf',
	keyDeviceDepthMode			= 'dddm',
	keyDeviceRect				= 'dddr',
	keyPixMapRect				= 'dpdr',
	keyPixMapHResolution		= 'dphr',
	keyPixMapVResolution		= 'dpvr',
	keyPixMapPixelType			= 'dppt',
	keyPixMapPixelSize			= 'dpps',
	keyPixMapCmpCount			= 'dpcc',
	keyPixMapCmpSize			= 'dpcs',
	keyPixMapAlignment			= 'dppa',
	keyPixMapResReserved		= 'dprr',
	keyPixMapReserved			= 'dppr',
	keyPixMapColorTableSeed		= 'dpct',
	keySummaryMenubar			= 'dsmb',
	keySummaryChanges			= 'dsch',
	keyDisplayOldConfig			= 'dold',
	keyDisplayNewConfig			= 'dnew'
};

enum {
	dmOnlyActiveDisplays		= true,
	dmAllDisplays				= false
};

enum {
/* Switch Flags */
	kNoSwitchConfirmBit			= 0,							/* Flag indicating that there is no need to confirm a switch to this mode */
	kDepthNotAvailableBit,										/* Current depth not available in new mode */
	kShowModeBit				= 3,							/* Show this mode even though it requires a confirm. */
	kModeNotResizeBit			= 4								/* Do not use this mode to resize display (for cards that mode drives a different connector). */
};

enum {
/*	Summary Change Flags (sticky bits indicating an operation was performed)
	For example, moving a display then moving it back will still set the kMovedDisplayBit.
*/
	kBeginEndConfigureBit		= 0,
	kMovedDisplayBit,
	kSetMainDisplayBit,
	kSetDisplayModeBit,
	kAddDisplayBit,
	kRemoveDisplayBit,
	kNewDisplayBit,
	kDisposeDisplayBit,
	kEnabledDisplayBit,
	kDisabledDisplayBit,
	kMirrorDisplayBit,
	kUnMirrorDisplayBit
};

enum {
/* Notification Messages for extended call back routines */
	kDMNotifyInstalled			= 1,							/* At install time */
	kDMNotifyEvent				= 2,							/* Post change time */
	kDMNotifyRemoved			= 3,							/* At remove time */
	kDMNotifyPrep				= 4,							/* Pre change time */
	kDMNotifyExtendEvent		= 5,							/* Allow registrees to extend apple event before it is sent */
	kDMNotifyDependents			= 6,							/* Minor notification check without full update */
/* Notification Flags */
	kExtendedNotificationProc	= (1L << 16)
};

/* types for notifyType */
enum {
	kFullNotify,												/* This is the appleevent whole nine yards notify */
	kFullDependencyNotify										/* Only sends to those who want to know about interrelated functionality (used for updating UI) */
};

/* DisplayID/DeviceID constants */
enum {
	kDummyDeviceID				= 0x0FF,						/* This is the ID of the dummy display, used when the last “real” display is disabled.*/
	kInvalidDisplayID			= 0x000,						/* This is the invalid ID*/
	kFirstDisplayID				= 0x100
};

enum {
/* bits for panelListFlags */
	kAllowDuplicatesBit			= 0
};

/* Constants for fidelity checks */
enum {
	kNoFidelity					= 0,
	kMinimumFidelity			= 1,
	kDefaultFidelity			= 500,							/* I'm just picking a number for Apple default panels and engines*/
	kDefaultManufacturerFidelity = 1000							/* I'm just picking a number for Manufacturer's panels and engines (overrides apple defaults)*/
};

enum {
	kAnyPanelType				= 0,							/* Pass to DMNewEngineList for list of all panels (as opposed to specific types)*/
	kAnyEngineType				= 0,							/* Pass to DMNewEngineList for list of all engines*/
	kAnyDeviceType				= 0,							/* Pass to DMNewDeviceList for list of all devices*/
	kAnyPortType				= 0								/* Pass to DMNewDevicePortList for list of all devices*/
};

/* portListFlags for DM_NewDevicePortList */
enum {
/* Should offline devices be put into the port list (such as dummy display) */
	kPLIncludeOfflineDevicesBit	= 0
};

typedef unsigned long DMFidelityType;

/* AVID is an ID for ports and devices the old DisplayID type
	is carried on for compatibility
*/
typedef unsigned long AVIDType;

typedef AVIDType DisplayIDType;

typedef void *DMListType;

typedef unsigned long DMListIndexType;

typedef void *AVPowerStatePtr;

struct DMComponentListEntryRec {
	DisplayIDType					itemID;						/* DisplayID Manager*/
	Component						itemComponent;				/* Component Manager*/
	ComponentDescription			itemDescription;			/* We can always construct this if we use something beyond the compontent mgr.*/
	ResType							itemClass;					/* Class of group to put this panel (eg geometry/color/etc for panels, brightness/contrast for engines, video out/sound/etc for devices)*/
	DMFidelityType					itemFidelity;				/* How good is this item for the specified search?*/
	ResType							itemSubClass;				/* Subclass of group to put this panel.  Can use to do sub-grouping (eg volume for volume panel and mute panel)*/
	Point							itemSort;					/* Set to 0 - future to sort the items in a sub group.*/
	unsigned long					itemFlags;					/* Set to 0 (future expansion)*/
	ResType							itemReserved;				/* What kind of code does the itemReference point to  (right now - kPanelEntryTypeComponentMgr only)*/
	unsigned long					itemFuture1;				/* Set to 0 (future expansion - probably an alternate code style)*/
	unsigned long					itemFuture2;				/* Set to 0 (future expansion - probably an alternate code style)*/
	unsigned long					itemFuture3;				/* Set to 0 (future expansion - probably an alternate code style)*/
	unsigned long					itemFuture4;				/* Set to 0 (future expansion - probably an alternate code style)*/
};
typedef struct DMComponentListEntryRec DMComponentListEntryRec;

typedef DMComponentListEntryRec *DMComponentListEntryPtr;

/* ••• Move AVLocationRec to AVComponents.i AFTER AVComponents.i is created*/
struct AVLocationRec {
	unsigned long					locationConstant;			/* Set to 0 (future expansion - probably an alternate code style)*/
};
typedef struct AVLocationRec AVLocationRec;

typedef AVLocationRec *AVLocationPtr;

struct DMDepthInfoRec {
	VDSwitchInfoPtr					depthSwitchInfo;			/* This is the switch mode to choose this timing/depth */
	VPBlockPtr						depthVPBlock;				/* VPBlock (including size, depth and format) */
	unsigned long					depthFlags;					/* Reserved */
	unsigned long					depthReserved1;				/* Reserved */
	unsigned long					depthReserved2;				/* Reserved */
};
typedef struct DMDepthInfoRec DMDepthInfoRec;

typedef DMDepthInfoRec *DMDepthInfoPtr;

struct DMDepthInfoBlockRec {
	unsigned long					depthBlockCount;			/* How many depths are there? */
	DMDepthInfoPtr					depthVPBlock;				/* Array of DMDepthInfoRec */
	unsigned long					depthBlockFlags;			/* Reserved */
	unsigned long					depthBlockReserved1;		/* Reserved */
	unsigned long					depthBlockReserved2;		/* Reserved */
};
typedef struct DMDepthInfoBlockRec DMDepthInfoBlockRec;

typedef DMDepthInfoBlockRec *DMDepthInfoBlockPtr;

struct DMDisplayModeListEntryRec {
	unsigned long					displayModeFlags;
	VDSwitchInfoPtr					displayModeSwitchInfo;
	Ptr								displayModeResolutionInfo;
	VDTimingInfoPtr					displayModeTimingInfo;
	DMDepthInfoBlockPtr				displayModeDepthBlockInfo;	/* Information about all the depths*/
	Ptr								displayModeReserved;		/* Reserved*/
	Str255							*displayModeName;			/* Name of the timing mode*/
};
typedef struct DMDisplayModeListEntryRec DMDisplayModeListEntryRec;

typedef DMDisplayModeListEntryRec *DMDisplayModeListEntryPtr;

struct DependentNotifyRec {
	ResType							notifyType;					/* What type was the engine that made the change (may be zero)*/
	ResType							notifyClass;				/* What class was the change (eg geometry, color etc)*/
	DisplayIDType					notifyPortID;				/* Which device was touched (kInvalidDisplayID -> all or none)*/
	ComponentInstance				notifyComponent;			/* What engine did it (may be 0)?*/
	unsigned long					notifyVersion;				/* Set to 0 (future expansion)*/
	unsigned long					notifyFlags;				/* Set to 0 (future expansion)*/
	unsigned long					notifyReserved;				/* Set to 0 (future expansion)*/
	unsigned long					notifyFuture;				/* Set to 0 (future expansion)*/
};
typedef struct DependentNotifyRec DependentNotifyRec;

typedef DependentNotifyRec *DependentNotifyPtr;

/* Exports to support Interfaces library containing unused calls */
typedef pascal void (*DMNotificationProcPtr)(AppleEvent *theEvent);
typedef pascal void (*DMExtendedNotificationProcPtr)(void *userData, short theMessage, void *notifyData);
typedef pascal void (*DMComponentListIteratorProcPtr)(void *userData, DMListIndexType itemIndex, DMComponentListEntryPtr componentInfo);
typedef pascal void (*DMDisplayModeListIteratorProcPtr)(void *userData, DMListIndexType itemIndex, DMDisplayModeListEntryPtr displaymodeInfo);

#if GENERATINGCFM
typedef UniversalProcPtr DMNotificationUPP;
typedef UniversalProcPtr DMExtendedNotificationUPP;
typedef UniversalProcPtr DMComponentListIteratorUPP;
typedef UniversalProcPtr DMDisplayModeListIteratorUPP;
#else
typedef DMNotificationProcPtr DMNotificationUPP;
typedef DMExtendedNotificationProcPtr DMExtendedNotificationUPP;
typedef DMComponentListIteratorProcPtr DMComponentListIteratorUPP;
typedef DMDisplayModeListIteratorProcPtr DMDisplayModeListIteratorUPP;
#endif

enum {
	uppDMNotificationProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(AppleEvent*))),
	uppDMExtendedNotificationProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void*))),
	uppDMComponentListIteratorProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DMListIndexType)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(DMComponentListEntryPtr))),
	uppDMDisplayModeListIteratorProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DMListIndexType)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(DMDisplayModeListEntryPtr)))
};

#if GENERATINGCFM
#define NewDMNotificationProc(userRoutine)		\
		(DMNotificationUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDMNotificationProcInfo, GetCurrentArchitecture())
#define NewDMExtendedNotificationProc(userRoutine)		\
		(DMExtendedNotificationUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDMExtendedNotificationProcInfo, GetCurrentArchitecture())
#define NewDMComponentListIteratorProc(userRoutine)		\
		(DMComponentListIteratorUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDMComponentListIteratorProcInfo, GetCurrentArchitecture())
#define NewDMDisplayModeListIteratorProc(userRoutine)		\
		(DMDisplayModeListIteratorUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDMDisplayModeListIteratorProcInfo, GetCurrentArchitecture())
#else
#define NewDMNotificationProc(userRoutine)		\
		((DMNotificationUPP) (userRoutine))
#define NewDMExtendedNotificationProc(userRoutine)		\
		((DMExtendedNotificationUPP) (userRoutine))
#define NewDMComponentListIteratorProc(userRoutine)		\
		((DMComponentListIteratorUPP) (userRoutine))
#define NewDMDisplayModeListIteratorProc(userRoutine)		\
		((DMDisplayModeListIteratorUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallDMNotificationProc(userRoutine, theEvent)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDMNotificationProcInfo, (theEvent))
#define CallDMExtendedNotificationProc(userRoutine, userData, theMessage, notifyData)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDMExtendedNotificationProcInfo, (userData), (theMessage), (notifyData))
#define CallDMComponentListIteratorProc(userRoutine, userData, itemIndex, componentInfo)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDMComponentListIteratorProcInfo, (userData), (itemIndex), (componentInfo))
#define CallDMDisplayModeListIteratorProc(userRoutine, userData, itemIndex, displaymodeInfo)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDMDisplayModeListIteratorProcInfo, (userData), (itemIndex), (displaymodeInfo))
#else
#define CallDMNotificationProc(userRoutine, theEvent)		\
		(*(userRoutine))((theEvent))
#define CallDMExtendedNotificationProc(userRoutine, userData, theMessage, notifyData)		\
		(*(userRoutine))((userData), (theMessage), (notifyData))
#define CallDMComponentListIteratorProc(userRoutine, userData, itemIndex, componentInfo)		\
		(*(userRoutine))((userData), (itemIndex), (componentInfo))
#define CallDMDisplayModeListIteratorProc(userRoutine, userData, itemIndex, displaymodeInfo)		\
		(*(userRoutine))((userData), (itemIndex), (displaymodeInfo))
#endif

extern pascal GDHandle DMGetFirstScreenDevice(Boolean activeOnly)
 TWOWORDINLINE(0x7000, 0xABEB);
extern pascal GDHandle DMGetNextScreenDevice(GDHandle theDevice, Boolean activeOnly)
 TWOWORDINLINE(0x7001, 0xABEB);
extern pascal void DMDrawDesktopRect(Rect *globalRect)
 TWOWORDINLINE(0x7002, 0xABEB);
extern pascal void DMDrawDesktopRegion(RgnHandle globalRgn)
 TWOWORDINLINE(0x7003, 0xABEB);
extern pascal OSErr DMBeginConfigureDisplays(Handle *displayState)
 THREEWORDINLINE(0x303C, 0x0206, 0xABEB);
extern pascal OSErr DMEndConfigureDisplays(Handle displayState)
 THREEWORDINLINE(0x303C, 0x0207, 0xABEB);
extern pascal OSErr DMAddDisplay(GDHandle newDevice, short driver, unsigned long mode, unsigned long reserved, unsigned long displayID, Component displayComponent, Handle displayState)
 THREEWORDINLINE(0x303C, 0x0D08, 0xABEB);
extern pascal OSErr DMMoveDisplay(GDHandle moveDevice, short x, short y, Handle displayState)
 THREEWORDINLINE(0x303C, 0x0609, 0xABEB);
extern pascal OSErr DMDisableDisplay(GDHandle disableDevice, Handle displayState)
 THREEWORDINLINE(0x303C, 0x040A, 0xABEB);
extern pascal OSErr DMEnableDisplay(GDHandle enableDevice, Handle displayState)
 THREEWORDINLINE(0x303C, 0x040B, 0xABEB);
extern pascal OSErr DMRemoveDisplay(GDHandle removeDevice, Handle displayState)
 THREEWORDINLINE(0x303C, 0x040C, 0xABEB);
extern pascal OSErr DMSetMainDisplay(GDHandle newMainDevice, Handle displayState)
 THREEWORDINLINE(0x303C, 0x0410, 0xABEB);
extern pascal OSErr DMSetDisplayMode(GDHandle theDevice, unsigned long mode, unsigned long *depthMode, unsigned long reserved, Handle displayState)
 THREEWORDINLINE(0x303C, 0x0A11, 0xABEB);
extern pascal OSErr DMCheckDisplayMode(GDHandle theDevice, unsigned long mode, unsigned long depthMode, unsigned long *switchFlags, unsigned long reserved, Boolean *modeOk)
 THREEWORDINLINE(0x303C, 0x0C12, 0xABEB);
extern pascal OSErr DMGetDeskRegion(RgnHandle *desktopRegion)
 THREEWORDINLINE(0x303C, 0x0213, 0xABEB);
extern pascal OSErr DMRegisterNotifyProc(DMNotificationUPP notificationProc, ProcessSerialNumberPtr whichPSN)
 THREEWORDINLINE(0x303C, 0x0414, 0xABEB);
extern pascal OSErr DMRemoveNotifyProc(DMNotificationUPP notificationProc, ProcessSerialNumberPtr whichPSN)
 THREEWORDINLINE(0x303C, 0x0415, 0xABEB);
extern pascal OSErr DMQDIsMirroringCapable(Boolean *qdIsMirroringCapable)
 THREEWORDINLINE(0x303C, 0x0216, 0xABEB);
extern pascal OSErr DMCanMirrorNow(Boolean *canMirrorNow)
 THREEWORDINLINE(0x303C, 0x0217, 0xABEB);
extern pascal OSErr DMIsMirroringOn(Boolean *isMirroringOn)
 THREEWORDINLINE(0x303C, 0x0218, 0xABEB);
extern pascal OSErr DMMirrorDevices(GDHandle gD1, GDHandle gD2, Handle displayState)
 THREEWORDINLINE(0x303C, 0x0619, 0xABEB);
extern pascal OSErr DMUnmirrorDevice(GDHandle gDevice, Handle displayState)
 THREEWORDINLINE(0x303C, 0x041A, 0xABEB);
extern pascal OSErr DMGetNextMirroredDevice(GDHandle gDevice, GDHandle *mirroredDevice)
 THREEWORDINLINE(0x303C, 0x041B, 0xABEB);
extern pascal OSErr DMBlockMirroring(void)
 TWOWORDINLINE(0x701C, 0xABEB);
extern pascal OSErr DMUnblockMirroring(void)
 TWOWORDINLINE(0x701D, 0xABEB);
extern pascal OSErr DMGetDisplayMgrA5World(Ptr *dmA5)
 THREEWORDINLINE(0x303C, 0x021E, 0xABEB);
extern pascal OSErr DMGetDisplayIDByGDevice(GDHandle displayDevice, DisplayIDType *displayID, Boolean failToMain)
 THREEWORDINLINE(0x303C, 0x051F, 0xABEB);
extern pascal OSErr DMGetGDeviceByDisplayID(DisplayIDType displayID, GDHandle *displayDevice, Boolean failToMain)
 THREEWORDINLINE(0x303C, 0x0520, 0xABEB);
extern pascal OSErr DMSetDisplayComponent(GDHandle theDevice, Component displayComponent)
 THREEWORDINLINE(0x303C, 0x0421, 0xABEB);
extern pascal OSErr DMGetDisplayComponent(GDHandle theDevice, Component *displayComponent)
 THREEWORDINLINE(0x303C, 0x0422, 0xABEB);
extern pascal OSErr DMNewDisplay(GDHandle *newDevice, short driverRefNum, unsigned long mode, unsigned long reserved, DisplayIDType displayID, Component displayComponent, Handle displayState)
 THREEWORDINLINE(0x303C, 0x0D23, 0xABEB);
extern pascal OSErr DMDisposeDisplay(GDHandle disposeDevice, Handle displayState)
 THREEWORDINLINE(0x303C, 0x0424, 0xABEB);
extern pascal OSErr DMResolveDisplayComponents(void)
 TWOWORDINLINE(0x7025, 0xABEB);
extern pascal OSErr DMRegisterExtendedNotifyProc(DMExtendedNotificationUPP notifyProc, void *notifyUserData, unsigned short nofifyOnFlags, ProcessSerialNumberPtr whichPSN)
 THREEWORDINLINE(0x303C, 0x07EF, 0xABEB);
extern pascal OSErr DMRemoveExtendedNotifyProc(DMExtendedNotificationUPP notifyProc, void *notifyUserData, ProcessSerialNumberPtr whichPSN, unsigned short removeFlags)
 THREEWORDINLINE(0x303C, 0x0726, 0xABEB);
extern pascal OSErr DMNewAVPanelList(DisplayIDType displayID, ResType panelType, DMFidelityType minimumFidelity, unsigned long panelListFlags, unsigned long reserved, DMListIndexType *thePanelCount, DMListType *thePanelList)
 THREEWORDINLINE(0x303C, 0x0C27, 0xABEB);
extern pascal OSErr DMNewAVEngineList(DisplayIDType displayID, ResType engineType, DMFidelityType minimumFidelity, unsigned long engineListFlags, unsigned long reserved, DMListIndexType *engineCount, DMListType *engineList)
 THREEWORDINLINE(0x303C, 0x0C28, 0xABEB);
extern pascal OSErr DMNewAVDeviceList(ResType deviceType, unsigned long deviceListFlags, unsigned long reserved, DMListIndexType *deviceCount, DMListType *deviceList)
 THREEWORDINLINE(0x303C, 0x0A29, 0xABEB);
extern pascal OSErr DMNewAVPortListByPortType(ResType subType, unsigned long portListFlags, unsigned long reserved, DMListIndexType *devicePortCount, DMListType *theDevicePortList)
 THREEWORDINLINE(0x303C, 0x0A2A, 0xABEB);
extern pascal OSErr DMGetIndexedComponentFromList(DMListType panelList, DMListIndexType itemIndex, unsigned long reserved, DMComponentListIteratorUPP listIterator, void *userData)
 THREEWORDINLINE(0x303C, 0x0A2B, 0xABEB);
extern pascal OSErr DMDisposeList(DMListType panelList)
 THREEWORDINLINE(0x303C, 0x022C, 0xABEB);
extern pascal OSErr DMGetNameByAVID(AVIDType theID, unsigned long nameFlags, Str255 *name)
 THREEWORDINLINE(0x303C, 0x062D, 0xABEB);
extern pascal OSErr DMNewAVIDByPortComponent(Component thePortComponent, ResType portKind, unsigned long reserved, AVIDType *newID)
 THREEWORDINLINE(0x303C, 0x082E, 0xABEB);
extern pascal OSErr DMGetPortComponentByAVID(DisplayIDType thePortID, Component *thePortComponent, ComponentDescription *theDesciption, ResType *thePortKind)
 THREEWORDINLINE(0x303C, 0x082F, 0xABEB);
extern pascal OSErr DMSendDependentNotification(ResType notifyType, ResType notifyClass, AVIDType displayID, ComponentInstance notifyComponent)
 THREEWORDINLINE(0x303C, 0x0A30, 0xABEB);
extern pascal OSErr DMDisposeAVComponent(Component theAVComponent)
 THREEWORDINLINE(0x303C, 0x0231, 0xABEB);
extern pascal OSErr DMSaveScreenPrefs(unsigned long reserved1, unsigned long saveFlags, unsigned long reserved2)
 THREEWORDINLINE(0x303C, 0x0632, 0xABEB);
extern pascal OSErr DMNewAVIDByDeviceComponent(Component theDeviceComponent, ResType portKind, unsigned long reserved, DisplayIDType *newID)
 THREEWORDINLINE(0x303C, 0x0833, 0xABEB);
extern pascal OSErr DMNewAVPortListByDeviceAVID(AVIDType theID, DMFidelityType minimumFidelity, unsigned long portListFlags, unsigned long reserved, DMListIndexType *devicePortCount, DMListType *theDevicePortList)
 THREEWORDINLINE(0x303C, 0x0C34, 0xABEB);
extern pascal OSErr DMGetDeviceComponentByAVID(AVIDType theDeviceID, Component *theDeviceComponent, ComponentDescription *theDesciption, ResType *theDeviceKind)
 THREEWORDINLINE(0x303C, 0x0835, 0xABEB);
extern pascal OSErr DMNewDisplayModeList(DisplayIDType displayID, unsigned long modeListFlags, unsigned long reserved, DMListIndexType *thePanelCount, DMListType *thePanelList)
 THREEWORDINLINE(0x303C, 0x0A36, 0xABEB);
extern pascal OSErr DMGetIndexedDisplayModeFromList(DMListType panelList, DMListIndexType itemIndex, unsigned long reserved, DMDisplayModeListIteratorUPP listIterator, void *userData)
 THREEWORDINLINE(0x303C, 0x0A37, 0xABEB);
extern pascal OSErr DMGetGraphicInfoByAVID(AVIDType theID, PicHandle *theAVPcit, Handle *theAVIconSuite, AVLocationRec *theAVLocation)
 THREEWORDINLINE(0x303C, 0x0838, 0xABEB);
extern pascal OSErr DMGetAVPowerState(AVIDType theID, AVPowerStatePtr getPowerState, unsigned long reserved1)
 THREEWORDINLINE(0x303C, 0x0839, 0xABEB);
extern pascal OSErr DMSetAVPowerState(AVIDType theID, AVPowerStatePtr setPowerState, unsigned long powerFlags, Handle displayState)
 THREEWORDINLINE(0x303C, 0x083A, 0xABEB);
extern pascal OSErr DMGetDeviceAVIDByPortAVID(AVIDType portAVID, AVIDType *deviceAVID)
 THREEWORDINLINE(0x303C, 0x043B, 0xABEB);
extern pascal OSErr DMGetEnableByAVID(AVIDType theAVID, Boolean *isAVIDEnabledNow, Boolean *canChangeEnableNow)
 THREEWORDINLINE(0x303C, 0x063C, 0xABEB);
extern pascal OSErr DMSetEnableByAVID(AVIDType theAVID, Boolean doEnable, Handle displayState)
 THREEWORDINLINE(0x303C, 0x053D, 0xABEB);
extern pascal OSErr DMGetDisplayMode(GDHandle theDevice, VDSwitchInfoPtr switchInfo)
 THREEWORDINLINE(0x303C, 0x043E, 0xABEB);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __DISPLAYS__ */

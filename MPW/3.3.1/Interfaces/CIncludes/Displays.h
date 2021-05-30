/*
	File:		Displays.h

	Copyright:	© 1984-1993 by Apple Computer, Inc., all rights reserved.

	WARNING
	This file was auto generated by the interfacer tool. Modifications
	must be made to the master file.

*/

#ifndef __DISPLAYS__
#define __DISPLAYS__

#ifndef __TRAPS__
#include <Traps.h>
#endif

#ifndef __EVENTS__
#include <Events.h>
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*		#include <MixedMode.h>									*/
/*	#include <Quickdraw.h>										*/
/*		#include <QuickdrawText.h>								*/
/*			#include <IntlResources.h>							*/
/*	#include <OSUtils.h>										*/
#endif

#ifndef __PROCESSES__
#include <Processes.h>
/*	#include <Files.h>											*/
/*		#include <SegLoad.h>									*/
#endif

#ifndef __COMPONENTS__
#include <Components.h>
#endif

#ifndef __WINDOWS__
#include <Windows.h>
/*	#include <Controls.h>										*/
/*		#include <Menus.h>										*/
#endif

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
/*	#include <Memory.h>											*/
/*	#include <EPPC.h>											*/
/*		#include <PPCToolBox.h>									*/
/*			#include <AppleTalk.h>								*/
/*	#include <Notification.h>									*/
#endif


/* AppleEvents Core Suite */

#define kAESystemConfigNotice 'cnfg'


/* Core Suite types */

#define kAEDisplayNotice 'dspl'

#define kAEDisplaySummary 'dsum'

#define keyDMConfigVersion 'dmcv'

#define keyDMConfigFlags 'dmcf'

#define keyDMConfigReserved 'dmcr'

#define keyDisplayID 'dmid'

#define keyDisplayComponent 'dmdc'

#define keyDisplayDevice 'dmdd'

#define keyDisplayFlags 'dmdf'

#define keyDisplayMode 'dmdm'

#define keyDisplayModeReserved 'dmmr'

#define keyDisplayReserved 'dmdr'

#define keyDisplayMirroredId 'dmmi'

#define keyDeviceFlags 'dddf'

#define keyDeviceDepthMode 'dddm'

#define keyDeviceRect 'dddr'

#define keyPixMapRect 'dpdr'

#define keyPixMapHResolution 'dphr'

#define keyPixMapVResolution 'dpvr'

#define keyPixMapPixelType 'dppt'

#define keyPixMapPixelSize 'dpps'

#define keyPixMapCmpCount 'dpcc'

#define keyPixMapCmpSize 'dpcs'

#define keyPixMapAlignment 'dppa'

#define keyPixMapResReserved 'dprr'

#define keyPixMapReserved 'dppr'

#define keyPixMapColorTableSeed 'dpct'

#define keySummaryMenubar 'dsmb'

#define keySummaryChanges 'dsch'

#define keyDisplayOldConfig 'dold'

#define keyDisplayNewConfig 'dnew'

#define dmOnlyActiveDisplays true

#define dmAllDisplays false

typedef unsigned long DisplayIDType;


/* Switch Flags */

enum  {
	kNoSwitchConfirmBit			= 0,							/* Flag indicating that there is no need to confirm a switch to this mode */
	kDepthNotAvailableBit
};


/* Summary Change Flags (sticky bits indicating an operation was performed) */


/* Note that moving a display, then moving it back will still set the kMovedDisplayBit */

enum  {
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

typedef pascal void (*DMNotificationProcPtr)(AppleEvent *theEvent);

enum {
	uppDMNotificationProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(AppleEvent*)))
};

#if USESROUTINEDESCRIPTORS
typedef UniversalProcPtr DMNotificationUPP;

#define CallDMNotificationProc(userRoutine, theEvent)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDMNotificationProcInfo, (theEvent))
#define NewDMNotificationProc(userRoutine)		\
		(DMNotificationUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDMNotificationProcInfo, GetCurrentISA())
#else
typedef DMNotificationProcPtr DMNotificationUPP;

#define CallDMNotificationProc(userRoutine, theEvent)		\
		(*(userRoutine))((theEvent))
#define NewDMNotificationProc(userRoutine)		\
		(DMNotificationUPP)(userRoutine)
#endif


/* Display Manager Error Codes */

enum  {
	kDMGenErr					= -6220,						/* Unexpected Error */
/* Mirroring-Specific Errors */
	kDMMirroringOnAlreadyErr	= -6221,						/* Returned by all calls that need mirroring to be off to do their thing */
	kDMWrongNumberOfDisplaysErr	= -6222,						/* Can only handle 2 displays for now */
	kDMMirroringBlockedErr		= -6223,						/* DMBlockMirroring() has been called */
	kDMCantBlockErr				= -6224,						/* Mirroring is already on, can’t Block now (call DMUnMirror() first) */
	kDMMirroringNotOnErr		= -6225,						/* Returned by all calls that need mirroring to be on to do their thing */
/* Other Errors */
	kSysSWTooOldErr				= -6226,						/* Missing critical pieces of System Software */
	kDMSWNotInitializedErr		= -6227,						/* Required software not initialized (eg windowmanager or display mgr) */
	kDMDriverNotDisplayMgrAwareErr = -6228,						/* Video Driver does not support display manager */
	kDMDisplayNotFoundErr		= -6229,						/* Could not find item */
	kDMDisplayAlreadyInstalledErr = -6230						/* Attempt to add an already installed display */
};

#ifdef __cplusplus
extern "C" {
#endif

extern pascal GDHandle DMGetFirstScreenDevice(Boolean activeOnly)
 TWOWORDINLINE(0x7000, 0xABEB);
extern pascal GDHandle DMGetNextScreenDevice(GDHandle theDevice, Boolean activeOnly)
 TWOWORDINLINE(0x7001, 0xABEB);
extern pascal void DMDrawDesktopRect(Rect *globalRect)
 TWOWORDINLINE(0x7002, 0xABEB);
extern pascal void DMDrawDesktopRegion(RgnHandle globalRgn)
 TWOWORDINLINE(0x7003, 0xABEB);
extern pascal OSErr DMGetGDeviceTablecloth(GDHandle displayDevice, ComponentInstance *tableclothInstance)
 THREEWORDINLINE(0x303C, 0x0404, 0xABEB);
extern pascal OSErr DMSetGDeviceTablecloth(GDHandle displayDevice, ComponentInstance tableclothInstance)
 THREEWORDINLINE(0x303C, 0x0405, 0xABEB);
extern pascal OSErr DMBeginConfigureDisplays(Handle *displayState)
 THREEWORDINLINE(0x303C, 0x0206, 0xABEB);
extern pascal OSErr DMEndConfigureDisplays(Handle displayState)
 THREEWORDINLINE(0x303C, 0x0207, 0xABEB);
extern pascal OSErr DMAddDisplay(GDHandle newDevice, short driver, unsigned long mode, unsigned long reserved, unsigned long displayID, ComponentInstance displayComponent, Handle displayState)
 THREEWORDINLINE(0x303C, 0x0D08, 0xABEB);
extern pascal OSErr DMMoveDisplay(GDHandle moveDevice, short x, short y, Handle displayState)
 THREEWORDINLINE(0x303C, 0x0609, 0xABEB);
extern pascal OSErr DMDisableDisplay(GDHandle disableDevice, Handle displayState)
 THREEWORDINLINE(0x303C, 0x040A, 0xABEB);
extern pascal OSErr DMEnableDisplay(GDHandle enableDevice, Handle displayState)
 THREEWORDINLINE(0x303C, 0x040B, 0xABEB);
extern pascal OSErr DMRemoveDisplay(GDHandle removeDevice, Handle displayState)
 THREEWORDINLINE(0x303C, 0x040C, 0xABEB);
extern pascal OSErr DMGetComponentAnimateTicks(ComponentInstance animationComponent, unsigned long *goodDelay, unsigned long *maxDelay)
 THREEWORDINLINE(0x303C, 0x060D, 0xABEB);
extern pascal OSErr DMSetComponentAnimateTicks(ComponentInstance animationComponent, unsigned long goodDelay, unsigned long maxDelay)
 THREEWORDINLINE(0x303C, 0x060E, 0xABEB);
extern pascal OSErr DMGetNextAnimateTime(unsigned long *nextAnimateTime)
 THREEWORDINLINE(0x303C, 0x020F, 0xABEB);
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
extern pascal OSErr DMGetDisplayMgrA5World(unsigned long *dmA5)
 THREEWORDINLINE(0x303C, 0x021E, 0xABEB);
extern pascal OSErr DMGetDisplayIDByGDevice(GDHandle displayDevice, DisplayIDType *displayID, Boolean failToMain)
 THREEWORDINLINE(0x303C, 0x051F, 0xABEB);
extern pascal OSErr DMGetGDeviceByDisplayID(DisplayIDType displayID, GDHandle *displayDevice, Boolean failToMain)
 THREEWORDINLINE(0x303C, 0x0520, 0xABEB);
extern pascal OSErr DMSetDisplayComponent(GDHandle theDevice, ComponentInstance displayComponent)
 THREEWORDINLINE(0x303C, 0x0421, 0xABEB);
extern pascal OSErr DMGetDisplayComponent(GDHandle theDevice, ComponentInstance *displayComponent)
 THREEWORDINLINE(0x303C, 0x0422, 0xABEB);
extern pascal OSErr DMNewDisplay(GDHandle *newDevice, short driverRefNum, unsigned long mode, unsigned long reserved, DisplayIDType displayID, ComponentInstance displayComponent, Handle displayState)
 THREEWORDINLINE(0x303C, 0x0D23, 0xABEB);
extern pascal OSErr DMDisposeDisplay(GDHandle disposeDevice, Handle displayState)
 THREEWORDINLINE(0x303C, 0x0424, 0xABEB);
extern pascal OSErr DMResolveDisplayComponents(void)
 TWOWORDINLINE(0x7025, 0xABEB);
#ifdef __cplusplus
}
#endif

#endif

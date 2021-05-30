/*
 	File:		LocationManager.h
 
 	Contains:	Walkabout Interfaces
 
 	Version:	Technology:	System 7.5
 				Release:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/


#ifndef __LOCATIONMANAGER__
#define __LOCATIONMANAGER__

#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
#ifndef __COMPONENTS__
#include <Components.h>
#endif
#ifndef __PROCESSES__
#include <Processes.h>
#endif
#ifndef __DISPLAYS__
#include <Displays.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

typedef long ALMToken;
/*
----------------------------------
 public error codes
*/

enum {
	ALMInternalErr				= -30049,
	ALMLocationNotFound			= -30048,
	ALMNoSuchModuleErr			= -30047,
	ALMModuleCommunicationErr	= -30046,
	ALMDuplicateModuleErr		= -30045,
	ALMInstallationErr			= -30044,
	ALMDeferSwitchErr			= -30043,
	ALMLastErr					= ALMDeferSwitchErr,
	ALMLastAllocatedErrNum		= -30030
};

/*------------------------------------*/

enum {
																/* ALMConfirmName reports these results*/
	ALMConfirmRenameConfig		= 1,
	ALMConfirmReplaceConfig		= 2,
	kALMDefaultSwitchFlags		= 0,							/* switchFlags masks*/
	kALMDontShowStatusWindow	= 1,
	kALMSignalViaAE				= 2,							/* gestalt selectors*/
	gestaltALMVers				= 'walk',
	gestaltALMAttr				= 'trip',
	gestaltALMPresent			= 0,
	kALMLocationNameMaxLen		= 31,
	kALMMaxLocations			= 16,							/* arbitrary limit.  enforced by walkabout.*/
	kALMNoLocationIndex			= -1,							/* index and token for the 'off' location*/
	kALMNoLocationToken			= -1,							/* Notification AEvent sent to apps when location*/
																/* changes.*/
																/* kAESystemConfigNotice		= 'cnfg',				// (defined in Displays.i)*/
	kAELocationNotice			= 'walk',						/* creator type of walkabout files*/
	kALMFileCreator				= 'walk'
};

/*--------------------------------------------------------------------------------------*/
typedef pascal void (*ALMNotificationProcPtr)(AppleEvent *theEvent);

#if GENERATINGCFM
typedef UniversalProcPtr ALMNotificationUPP;
#else
typedef ALMNotificationProcPtr ALMNotificationUPP;
#endif

enum {
	uppALMNotificationProcInfo = kPascalStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(AppleEvent *)))
};

#if GENERATINGCFM
#define NewALMNotificationProc(userRoutine)		\
		(ALMNotificationUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppALMNotificationProcInfo, GetCurrentArchitecture())
#else
#define NewALMNotificationProc(userRoutine)		\
		((ALMNotificationUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallALMNotificationProc(userRoutine, theEvent)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppALMNotificationProcInfo, (theEvent))
#else
#define CallALMNotificationProc(userRoutine, theEvent)		\
		(*(userRoutine))((theEvent))
#endif
/*
--------------------------------------------------------------------------------------
 dispatched trap API
*/

enum {
	_ALMDispatch				= 0xAAA4
};

extern pascal OSErr ALMGetCurrentLocation(short *index, ALMToken *token, Str31 name)
 THREEWORDINLINE(0x303C, 0x0600, 0xAAA4);

extern pascal OSErr ALMGetIndLocation(short index, ALMToken *token, Str31 name)
 THREEWORDINLINE(0x303C, 0x0501, 0xAAA4);

extern pascal OSErr ALMCountLocations(short *nLocations)
 THREEWORDINLINE(0x303C, 0x0202, 0xAAA4);

extern pascal OSErr ALMSwitchToLocation(ALMToken newLocation, long switchFlags)
 THREEWORDINLINE(0x303C, 0x0403, 0xAAA4);

extern pascal OSErr ALMRegisterNotifyProc(ALMNotificationUPP notificationProc, const ProcessSerialNumber *whichPSN)
 THREEWORDINLINE(0x303C, 0x0404, 0xAAA4);

extern pascal OSErr ALMRemoveNotifyProc(ALMNotificationUPP notificationProc, const ProcessSerialNumber *whichPSN)
 THREEWORDINLINE(0x303C, 0x0405, 0xAAA4);

extern pascal OSErr ALMConfirmName(Str255 msg, Str255 configName, short *choice, ModalFilterUPP filter)
 THREEWORDINLINE(0x303C, 0x0806, 0xAAA4);

/*
--------------------------------------------------------------------------------------
 Location Manager Module API
*/

enum {
	kALMComponentType			= 'walk',						/* These masks apply to the "flags" field in the ComponentDescription record. */
	kALMMultiplePerLocation		= 1,							/* this module can be added more than once to a location*/
																/* this module's settings' descriptions can change even */
	kALMDescriptionGetsStale	= 2								/* when the setting didn't change.*/
};

typedef unsigned long ALMComponentFlagsEnum;
/* These are the possible values to be returned in the 'flags' parameter of ALMSetCurrent()*/

enum {
	kALMNoChange				= 0,
	kALMAvailableNow			= 1,
	kALMFinderRestart			= 2,
	kALMProcesses				= 3,
	kALMExtensions				= 4,
	kALMWarmBoot				= 5,
	kALMColdBoot				= 6,
	kALMShutdown				= 7
};

typedef long ALMRebootFlags;

enum {
	kALMScriptInfoVersion		= 2
};

struct ALMScriptMgrInfo {
	short 							version;					/* set to kALMScriptInfoVersion*/
	short 							scriptCode;
	short 							regionCode;
	short 							langCode;
	short 							fontNum;
	short 							fontSize;
};
typedef struct ALMScriptMgrInfo ALMScriptMgrInfo;

/*
 These are prototypes for the routines that your module will implement (some are optional).
 Each prototype is given in two forms, the one you'll use depends on whether you dispatch to 
 the routine with CallComponentFunction() or CallComponentFunctionWithStorage().
 If you use CallComponentFunctionWithStorage(), you'll create the globals handle in your Open
 routine.
*/
typedef Handle MyGlobals;
/* CallComponentFunction() variant*/
extern pascal ComponentResult MyALMGetCurrent(Handle setting);

extern pascal ComponentResult MyALMSetCurrent(Handle setting, ALMRebootFlags *flags);

extern pascal ComponentResult MyALMCompareSetting(Handle setting1, Handle setting2, Boolean *equal);

extern pascal ComponentResult MyALMEditSetting(Handle setting);

extern pascal ComponentResult MyALMDescribeSettings(Handle setting, CharsHandle text);

extern pascal ComponentResult MyALMDescribeError(OSErr lastErr, Str255 errStr);

extern pascal ComponentResult MyALMImportExport(Boolean import, Handle setting, short resRefNum);

extern pascal ComponentResult MyALMGetScriptInfo(ALMScriptMgrInfo *info);

extern pascal ComponentResult MyALMGetInfo(CharsHandle *text, StScrpHandle *style, ModalFilterUPP filter);

/* CallComponentFunctionWithStorage() variant.*/
extern pascal ComponentResult MyALMGetCurrentStorage(MyGlobals g, Handle setting);

extern pascal ComponentResult MyALMSetCurrentStorage(MyGlobals g, Handle setting, ALMRebootFlags *flags);

extern pascal ComponentResult MyALMCompareSettingStorage(MyGlobals g, Handle setting1, Handle setting2, Boolean *equal);

extern pascal ComponentResult MyALMEditSettingStorage(MyGlobals g, Handle setting);

extern pascal ComponentResult MyALMDescribeSettingsStorage(MyGlobals g, Handle setting, CharsHandle text);

extern pascal ComponentResult MyALMDescribeErrorStorage(MyGlobals g, OSErr lastErr, Str255 errStr);

extern pascal ComponentResult MyALMImportExportStorage(MyGlobals g, Boolean import, Handle setting, short resRefNum);

extern pascal ComponentResult MyALMGetScriptInfoStorage(MyGlobals g, ALMScriptMgrInfo *info);

extern pascal ComponentResult MyALMGetInfoStorage(MyGlobals g, CharsHandle *text, StScrpHandle *style, ModalFilterUPP filter);


#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#ifdef __cplusplus
}
#endif

#endif /* __LOCATIONMANAGER__ */


/*
 	File:		AppleGuide.h
 
 	Contains:	Apple Guide Interfaces.
 
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

#ifndef __APPLEGUIDE__
#define __APPLEGUIDE__


#ifndef __APPLEEVENTS__
#include <AppleEvents.h>
#endif
/*	#include <Errors.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <Types.h>											*/
/*	#include <Memory.h>											*/
/*		#include <MixedMode.h>									*/
/*	#include <OSUtils.h>										*/
/*	#include <Events.h>											*/
/*		#include <Quickdraw.h>									*/
/*			#include <QuickdrawText.h>							*/
/*	#include <EPPC.h>											*/
/*		#include <AppleTalk.h>									*/
/*		#include <Files.h>										*/
/*			#include <Finder.h>									*/
/*		#include <PPCToolbox.h>									*/
/*		#include <Processes.h>									*/
/*	#include <Notification.h>									*/

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __TYPES__
#include <Types.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

typedef UInt32 AGRefNum;

typedef UInt32 AGCoachRefNum;

typedef UInt32 AGContextRefNum;

struct AGAppInfo {
	AEEventID						eventId;
	long							refCon;
	void							*contextObj;				/* private system field*/
};
typedef struct AGAppInfo AGAppInfo, *AGAppInfoPtr, **AGAppInfoHdl;

typedef pascal OSErr (*CoachReplyProcPtr)(Rect *pRect, Ptr name, long refCon);
typedef pascal OSErr (*ContextReplyProcPtr)(Ptr pInputData, Size inputDataSize, Ptr *ppOutputData, Size *pOutputDataSize, AGAppInfoHdl hAppInfo);

#if GENERATINGCFM
typedef UniversalProcPtr CoachReplyUPP;
typedef UniversalProcPtr ContextReplyUPP;
#else
typedef CoachReplyProcPtr CoachReplyUPP;
typedef ContextReplyProcPtr ContextReplyUPP;
#endif

enum {
	uppCoachReplyProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Rect*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long))),
	uppContextReplyProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Size)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Ptr*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(Size*)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(AGAppInfoHdl)))
};

#if GENERATINGCFM
#define NewCoachReplyProc(userRoutine)		\
		(CoachReplyUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppCoachReplyProcInfo, GetCurrentArchitecture())
#define NewContextReplyProc(userRoutine)		\
		(ContextReplyUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppContextReplyProcInfo, GetCurrentArchitecture())
#else
#define NewCoachReplyProc(userRoutine)		\
		((CoachReplyUPP) (userRoutine))
#define NewContextReplyProc(userRoutine)		\
		((ContextReplyUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallCoachReplyProc(userRoutine, pRect, name, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppCoachReplyProcInfo, (pRect), (name), (refCon))
#define CallContextReplyProc(userRoutine, pInputData, inputDataSize, ppOutputData, pOutputDataSize, hAppInfo)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppContextReplyProcInfo, (pInputData), (inputDataSize), (ppOutputData), (pOutputDataSize), (hAppInfo))
#else
#define CallCoachReplyProc(userRoutine, pRect, name, refCon)		\
		(*(userRoutine))((pRect), (name), (refCon))
#define CallContextReplyProc(userRoutine, pInputData, inputDataSize, ppOutputData, pOutputDataSize, hAppInfo)		\
		(*(userRoutine))((pInputData), (inputDataSize), (ppOutputData), (pOutputDataSize), (hAppInfo))
#endif


enum {
	gestaltAppleGuidePresent	= 31,
	gestaltAppleGuideIsDebug	= 30,
	kAGDefault					= 0,
	kAGFrontDatabase			= 1,
	kAGNoMixin					= (-1)
};

enum {
	kAGViewFullHowdy			= 1,							/* Full-size Howdy*/
	kAGViewTopicAreas			= 2,							/* Full-size Topic Areas*/
	kAGViewIndex				= 3,							/* Full-size Index Terms*/
	kAGViewLookFor				= 4,							/* Full-size Look-For (Search)*/
	kAGViewSingleHowdy			= 5,							/* Single-list-size Howdy*/
	kAGViewSingleTopics			= 6								/* Single-list-size Topics*/
};

enum {
	kAGFileMain					= 'poco',
	kAGFileMixin				= 'mixn'
};

/* To test against AGGetAvailableDBTypes*/
enum AGDBTypeBit {
	kAGDBTypeBitAny				= 0x00000001,
	kAGDBTypeBitHelp			= 0x00000002,
	kAGDBTypeBitTutorial		= 0x00000004,
	kAGDBTypeBitShortcuts		= 0x00000008,
	kAGDBTypeBitAbout			= 0x00000010,
	kAGDBTypeBitOther			= 0x00000080
};

typedef UInt16 AGStatus;

/* Returned by AGGetStatus*/

enum {
	kAGIsNotRunning,
	kAGIsSleeping,
	kAGIsActive
};

typedef UInt16 AGWindowKind;

/* Returned by AGGetFrontWindowKind*/

enum {
	kAGNoWindow,
	kAGAccessWindow,
	kAGPresentationWindow
};

/* Error Codes*/
/* Not an enum, because other OSErrs are valid.*/
typedef SInt16 AGErr;

/* Apple Guide error codes*/

enum {
/* -------------------- Apple event reply codes*/
	kAGErrUnknownEvent			= -2900,
	kAGErrCantStartup			= -2901,
	kAGErrNoAccWin				= -2902,
	kAGErrNoPreWin				= -2903,
	kAGErrNoSequence			= -2904,
	kAGErrNotOopsSequence		= -2905,
	kAGErrReserved06			= -2906,
	kAGErrNoPanel				= -2907,
	kAGErrContentNotFound		= -2908,
	kAGErrMissingString			= -2909,
	kAGErrInfoNotAvail			= -2910,
	kAGErrEventNotAvailable		= -2911,
	kAGErrCannotMakeCoach		= -2912,
	kAGErrSessionIDsNotMatch	= -2913,
	kAGErrMissingDatabaseSpec	= -2914,
/* -------------------- Coach's Chalkboard reply codes*/
	kAGErrItemNotFound			= -2925,
	kAGErrBalloonResourceNotFound = -2926,
	kAGErrChalkResourceNotFound	= -2927,
	kAGErrChdvResourceNotFound	= -2928,
	kAGErrAlreadyShowing		= -2929,
	kAGErrBalloonResourceSkip	= -2930,
	kAGErrItemNotVisible		= -2931,
	kAGErrReserved32			= -2932,
	kAGErrNotFrontProcess		= -2933,
	kAGErrMacroResourceNotFound	= -2934,
/* -------------------- API reply codes*/
	kAGErrAppleGuideNotAvailable = -2951,
	kAGErrCannotInitCoach		= -2952,
	kAGErrCannotInitContext		= -2953,
	kAGErrCannotOpenAliasFile	= -2954,
	kAGErrNoAliasResource		= -2955,
	kAGErrDatabaseNotAvailable	= -2956,
	kAGErrDatabaseNotOpen		= -2957,
	kAGErrMissingAppInfoHdl		= -2958,
	kAGErrMissingContextObject	= -2959,
	kAGErrInvalidRefNum			= -2960,
	kAGErrDatabaseOpen			= -2961,
	kAGErrInsufficientMemory	= -2962
};

/* Events*/
/* Not an enum because we want to make assignments.*/
typedef UInt32 AGEvent;

/* Handy events for AGGeneral.*/

enum {
/* Panel actions (Require a presentation window).*/
	kAGEventDoCoach				= 'doco',
	kAGEventDoHuh				= 'dhuh',
	kAGEventGoNext				= 'gonp',
	kAGEventGoPrev				= 'gopp',
	kAGEventHidePanel			= 'pahi',
	kAGEventReturnBack			= 'gobk',
	kAGEventShowPanel			= 'pash',
	kAGEventTogglePanel			= 'patg'
};

/* Functions*/
/* AGClose*/
/* Close the database associated with the AGRefNum.*/
extern pascal AGErr AGClose(AGRefNum *refNum)
 TWOWORDINLINE(0x7011, 0xAA6E);
/* AGGeneral*/
/* Cause various events to happen.*/
extern pascal AGErr AGGeneral(AGRefNum refNum, AGEvent theEvent)
 TWOWORDINLINE(0x700D, 0xAA6E);
/* AGGetAvailableDBTypes*/
/* Return the database types available for this application.*/
extern pascal UInt32 AGGetAvailableDBTypes(void)
 TWOWORDINLINE(0x7008, 0xAA6E);
/* AGGetFrontWindowKind*/
/* Return the kind of the front window.*/
extern pascal AGWindowKind AGGetFrontWindowKind(AGRefNum refNum)
 TWOWORDINLINE(0x700C, 0xAA6E);
/* AGGetFSSpec*/
/* Return the FSSpec for the AGRefNum.*/
extern pascal AGErr AGGetFSSpec(AGRefNum refNum, FSSpec *fileSpec)
 TWOWORDINLINE(0x700F, 0xAA6E);
/* AGGetStatus*/
/* Return the status of Apple Guide.*/
extern pascal AGStatus AGGetStatus(void)
 TWOWORDINLINE(0x7009, 0xAA6E);
/* AGInstallCoachHandler*/
/* Install a Coach object location query handler.*/
extern pascal AGErr AGInstallCoachHandler(CoachReplyUPP coachReplyProc, long refCon, AGCoachRefNum *resultRefNum)
 TWOWORDINLINE(0x7012, 0xAA6E);
/* AGInstallContextHandler*/
/* Install a context check query handler.*/
extern pascal AGErr AGInstallContextHandler(ContextReplyUPP contextReplyProc, AEEventID eventID, long refCon, AGContextRefNum *resultRefNum)
 TWOWORDINLINE(0x7013, 0xAA6E);
/* AGIsDatabaseOpen*/
/* Return true if the database associated with the AGRefNum is open.*/
extern pascal Boolean AGIsDatabaseOpen(AGRefNum refNum)
 TWOWORDINLINE(0x7006, 0xAA6E);
/* AGOpen*/
/* Open a guide database.*/
extern pascal AGErr AGOpen(FSSpec *fileSpec, UInt32 flags, Handle mixinControl, AGRefNum *resultRefNum)
 TWOWORDINLINE(0x7001, 0xAA6E);
/* AGOpenWithSearch*/
/* Open a guide database and preset a search string.*/
extern pascal AGErr AGOpenWithSearch(FSSpec *fileSpec, UInt32 flags, Handle mixinControl, ConstStr255Param searchString, AGRefNum *resultRefNum)
 TWOWORDINLINE(0x7002, 0xAA6E);
/* AGOpenWithSequence*/
/* Open a guide database and display a presentation window sequence.*/
extern pascal AGErr AGOpenWithSequence(FSSpec *fileSpec, UInt32 flags, Handle mixinControl, short sequenceID, AGRefNum *resultRefNum)
 TWOWORDINLINE(0x7004, 0xAA6E);
/* AGOpenWithView*/
/* Open a guide database and override the default view.*/
extern pascal AGErr AGOpenWithView(FSSpec *fileSpec, UInt32 flags, Handle mixinControl, short viewNum, AGRefNum *resultRefNum)
 TWOWORDINLINE(0x7005, 0xAA6E);
/* AGQuit*/
/* Make Apple Guide quit.*/
extern pascal AGErr AGQuit(void)
 TWOWORDINLINE(0x7010, 0xAA6E);
/* AGRemoveCoachHandler*/
/* Remove the Coach object location query handler.*/
extern pascal AGErr AGRemoveCoachHandler(AGCoachRefNum *resultRefNum)
 TWOWORDINLINE(0x7014, 0xAA6E);
/* AGRemoveContextHandler*/
/* Remove the context check query handler.*/
extern pascal AGErr AGRemoveContextHandler(AGContextRefNum *resultRefNum)
 TWOWORDINLINE(0x7015, 0xAA6E);
/* AGStart*/
/* Start up Apple Guide in the background.*/
extern pascal AGErr AGStart(void)
 TWOWORDINLINE(0x700A, 0xAA6E);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __APPLEGUIDE__ */

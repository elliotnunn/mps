// File: ToolAPI.h

#ifndef __TOOLAPI__
#define __TOOLAPI__

#ifndef __TYPES__
	#include <Types.h>
#endif

#ifndef __WINDOWS__
	#include <Windows.h>
#endif

#ifndef __EVENTS__
	#include <Events.h>
#endif

#ifndef __MIXEDMODE__
	#include <MixedMode.h>
#endif

// === Pointer definitions for our callback routines
typedef OSErr (*ToolStartupProcPtr)(WindowPtr wp);
typedef void (*ToolShutdownProcPtr)(WindowPtr wp);
typedef void (*ToolMenuAdjustProcPtr)(WindowPtr wp);
typedef void (*ToolMenuDispatchProcPtr)(WindowPtr wp, short menuID, short itemID);
typedef void (*ToolIdleProcPtr)(WindowPtr wp);
typedef void (*ToolUpdateProcPtr)(WindowPtr wp);
typedef void (*ToolWindowClickProcPtr)(WindowPtr wp, EventRecord *theEvent);
typedef void (*ToolWindowKeyProcPtr)(WindowPtr wp, EventRecord *theEvent);
typedef void (*ToolWindowMovedProcPtr)(WindowPtr wp);
typedef void (*ToolWindowResizedProcPtr)(WindowPtr wp);
typedef void (*ToolWindowActivateProcPtr)(WindowPtr wp, Boolean activeFlag);

// === Mixed Mode definitions for our callback routines
// We're creating these so we can have 68K tools and PowerPC tools work together
// in the application without needing multiple calling sequences

enum { 
	uppToolStartupProcInfo = kCStackBased 
							| RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr))),

	uppToolShutdownProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr))),

	uppToolMenuAdjustProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr))),

	uppToolMenuDispatchProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr)))
							| STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(short)))
							| STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(short))),

	uppToolIdleProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr))),

	uppToolUpdateProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr))),

	uppToolWindowClickProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr)))
							| STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(EventRecord*))),

	uppToolWindowKeyProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr)))
							| STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(EventRecord*))),

	uppToolWindowMovedProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr))),

	uppToolWindowResizedProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr))),

	uppToolWindowActivateProcInfo = kCStackBased 
							| STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(WindowPtr)))
							| STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Boolean)))
};

#if USESROUTINEDESCRIPTORS
	typedef UniversalProcPtr ToolStartupUPP;

	#define CallToolStartupProc(userRoutine, toolWindow)		\
			CallUniversalProc((UniversalProcPtr)userRoutine, uppToolStartupProcInfo, toolWindow)
			
	#define NewToolStartupProc(userRoutine)		\
			(ToolStartupUPP) NewRoutineDescriptor((ProcPtr)userRoutine, uppToolStartupProcInfo, GetCurrentISA())
#else	/* For systems that don't use routine descriptors */
	typedef ToolStartupProcPtr ToolStartupUPP;
	
	#define CallToolStartupProc(userRoutine, toolWindow)		\
			(*userRoutine)(toolWindow)

	#define NewToolStartupProc(userRoutine)		\
			(ToolStartupUPP)(userRoutine)
#endif


#if USESROUTINEDESCRIPTORS
	typedef UniversalProcPtr ToolShutdownUPP;

	#define CallToolShutdownProc(userRoutine, wp)		\
			CallUniversalProc((UniversalProcPtr)userRoutine, uppToolShutdownProcInfo, wp)
			
	#define NewToolShutdownProc(userRoutine)		\
			(ToolShutdownUPP) NewRoutineDescriptor((ProcPtr)userRoutine, uppToolShutdownProcInfo, GetCurrentISA())
#else	/* For systems that don't use routine descriptors */
	typedef ToolShutdownProcPtr ToolShutdownUPP;
	
	#define CallToolShutdownProc(userRoutine, wp)		\
			(*userRoutine)(wp)

	#define NewToolShutdownProc(userRoutine)		\
			(ToolShutdownUPP)(userRoutine)
#endif


#if USESROUTINEDESCRIPTORS
	typedef UniversalProcPtr ToolMenuAdjustUPP;

	#define CallToolMenuAdjustProc(userRoutine, wp)		\
			CallUniversalProc((UniversalProcPtr)userRoutine, uppToolMenuAdjustProcInfo, wp)
			
	#define NewToolMenuAdjustProc(userRoutine)		\
			(ToolMenuAdjustUPP) NewRoutineDescriptor((ProcPtr)userRoutine, uppToolMenuAdjustProcInfo, GetCurrentISA())
#else	/* For systems that don't use routine descriptors */
	typedef ToolMenuAdjustProcPtr ToolMenuAdjustUPP;
	
	#define CallToolMenuAdjustProc(userRoutine, wp)		\
			(*userRoutine)(wp)

	#define NewToolMenuAdjustProc(userRoutine)		\
			(ToolMenuAdjustUPP)(userRoutine)
#endif


#if USESROUTINEDESCRIPTORS
	typedef UniversalProcPtr ToolMenuDispatchUPP;

	#define CallToolMenuDispatchProc(userRoutine, wp, theMenu, theItem)		\
			CallUniversalProc((UniversalProcPtr)userRoutine, uppToolMenuDispatchProcInfo, wp, theMenu, theItem)
			
	#define NewToolMenuDispatchProc(userRoutine)		\
			(ToolMenuDispatchUPP) NewRoutineDescriptor((ProcPtr)userRoutine, uppToolMenuDispatchProcInfo, GetCurrentISA())
#else	/* For systems that don't use routine descriptors */
	typedef ToolMenuDispatchProcPtr ToolMenuDispatchUPP;
	
	#define CallToolMenuDispatchProc(userRoutine, wp, theMenu, theItem)		\
			(*userRoutine)(wp, theMenu, theItem)

	#define NewToolMenuDispatchProc(userRoutine)		\
			(ToolMenuDispatchUPP)(userRoutine)
#endif


#if USESROUTINEDESCRIPTORS
	typedef UniversalProcPtr ToolIdleUPP;

	#define CallToolIdleProc(userRoutine, wp)		\
			CallUniversalProc((UniversalProcPtr)userRoutine, uppToolIdleProcInfo, wp)
			
	#define NewToolIdleProc(userRoutine)		\
			(ToolIdleUPP) NewRoutineDescriptor((ProcPtr)userRoutine, uppToolIdleProcInfo, GetCurrentISA())
#else	/* For systems that don't use routine descriptors */
	typedef ToolIdleProcPtr ToolIdleUPP;
	
	#define CallToolIdleProc(userRoutine, wp)		\
			(*userRoutine)(wp)

	#define NewToolIdleProc(userRoutine)		\
			(ToolIdleUPP)(userRoutine)
#endif


#if USESROUTINEDESCRIPTORS
	typedef UniversalProcPtr ToolUpdateUPP;

	#define CallToolUpdateProc(userRoutine, wp)		\
			CallUniversalProc((UniversalProcPtr)userRoutine, uppToolUpdateProcInfo, wp)
			
	#define NewToolUpdateProc(userRoutine)		\
			(ToolUpdateUPP) NewRoutineDescriptor((ProcPtr)userRoutine, uppToolUpdateProcInfo, GetCurrentISA())
#else	/* For systems that don't use routine descriptors */
	typedef ToolUpdateProcPtr ToolUpdateUPP;
	
	#define CallToolUpdateProc(userRoutine, wp)		\
			(*userRoutine)(wp)

	#define NewToolUpdateProc(userRoutine)		\
			(ToolUpdateUPP)(userRoutine)
#endif


#if USESROUTINEDESCRIPTORS
	typedef UniversalProcPtr ToolWindowClickUPP;

	#define CallToolWindowClickProc(userRoutine, wp, theEvent)		\
			CallUniversalProc((UniversalProcPtr)userRoutine, uppToolWindowClickProcInfo, wp, theEvent)
			
	#define NewToolWindowClickProc(userRoutine)		\
			(ToolWindowClickUPP) NewRoutineDescriptor((ProcPtr)userRoutine, uppToolWindowClickProcInfo, GetCurrentISA())
#else	/* For systems that don't use routine descriptors */
	typedef ToolWindowClickProcPtr ToolWindowClickUPP;
	
	#define CallToolWindowClickProc(userRoutine, wp, theEvent)		\
			(*userRoutine)(wp, theEvent)

	#define NewToolWindowClickProc(userRoutine)		\
			(ToolWindowClickUPP)(userRoutine)
#endif


#if USESROUTINEDESCRIPTORS
	typedef UniversalProcPtr ToolWindowKeyUPP;

	#define CallToolWindowKeyProc(userRoutine, wp, theEvent)		\
			CallUniversalProc((UniversalProcPtr)userRoutine, uppToolWindowKeyProcInfo, wp, theEvent)
			
	#define NewToolWindowKeyProc(userRoutine)		\
			(ToolWindowKeyUPP) NewRoutineDescriptor((ProcPtr)userRoutine, uppToolWindowKeyProcInfo, GetCurrentISA())
#else	/* For systems that don't use routine descriptors */
	typedef ToolWindowKeyProcPtr ToolWindowKeyUPP;
	
	#define CallToolWindowKeyProc(userRoutine, wp, theEvent)		\
			(*userRoutine)(wp, theEvent)

	#define NewToolWindowKeyProc(userRoutine)		\
			(ToolWindowKeyUPP)(userRoutine)
#endif


#if USESROUTINEDESCRIPTORS
	typedef UniversalProcPtr ToolWindowMovedUPP;

	#define CallToolWindowMovedProc(userRoutine, wp)		\
			CallUniversalProc((UniversalProcPtr)userRoutine, uppToolWindowMovedProcInfo, wp)
			
	#define NewToolWindowMovedProc(userRoutine)		\
			(ToolWindowMovedUPP) NewRoutineDescriptor((ProcPtr)userRoutine, uppToolWindowMovedProcInfo, GetCurrentISA())
#else	/* For systems that don't use routine descriptors */
	typedef ToolWindowMovedProcPtr ToolWindowMovedUPP;
	
	#define CallToolWindowMovedProc(userRoutine, wp)		\
			(*userRoutine)(wp)

	#define NewToolWindowMovedProc(userRoutine)		\
			(ToolWindowMovedUPP)(userRoutine)
#endif


#if USESROUTINEDESCRIPTORS
	typedef UniversalProcPtr ToolWindowResizedUPP;

	#define CallToolWindowResizedProc(userRoutine, wp)		\
			CallUniversalProc((UniversalProcPtr)userRoutine, uppToolWindowResizedProcInfo, wp)
			
	#define NewToolWindowResizedProc(userRoutine)		\
			(ToolWindowResizedUPP) NewRoutineDescriptor((ProcPtr)userRoutine, uppToolWindowResizedProcInfo, GetCurrentISA())
#else	/* For systems that don't use routine descriptors */
	typedef ToolWindowResizedProcPtr ToolWindowResizedUPP;
	
	#define CallToolWindowResizedProc(userRoutine, wp)		\
			(*userRoutine)(wp)

	#define NewToolWindowResizedProc(userRoutine)		\
			(ToolWindowResizedUPP)(userRoutine)
#endif


#if USESROUTINEDESCRIPTORS
	typedef UniversalProcPtr ToolWindowActivateUPP;

	#define CallToolWindowActivateProc(userRoutine, wp, activeFlag)		\
			CallUniversalProc((UniversalProcPtr)userRoutine, uppToolWindowActivateProcInfo, wp, activeFlag)
			
	#define NewToolWindowActivateProc(userRoutine)		\
			(ToolWindowActivateUPP) NewRoutineDescriptor((ProcPtr)userRoutine, uppToolWindowActivateProcInfo, GetCurrentISA())
#else	/* For systems that don't use routine descriptors */
	typedef ToolWindowActivateProcPtr ToolWindowActivateUPP;
	
	#define CallToolWindowActivateProc(userRoutine, wp, activeFlag)		\
			(*userRoutine)(wp, activeFlag)

	#define NewToolWindowActivateProc(userRoutine)		\
			(ToolWindowActivateUPP)(userRoutine)
#endif


// === The "tool information block"
#ifdef powerc
	#pragma options align=mac68k
#endif
struct ToolInfoBlock {
//	long					toolMenuID;				// Unique ID assigned to our menu
	ToolShutdownUPP			shutdownProc;			// Routine to call when tool is unloaded
	ToolMenuAdjustUPP		menuAdjustProc;			// Routine to call to adjust tool's menus
	ToolMenuDispatchUPP		menuDispatchProc;		// Routine to call when tool's menu is selected
	ToolIdleUPP				toolIdleProc;			// Routine to call when tool's image is idled
	ToolUpdateUPP			toolUpdateProc;			// Routine to call when tool's window needs updating
	ToolWindowKeyUPP		toolKeyProc;			// Routine to call when tool's window is clicked
	ToolWindowClickUPP		toolClickProc;			// Routine to call when tool's window is foremost & typing occurs
	ToolWindowMovedUPP		toolWindowMovedProc;	// Routine to call when tool's window has been moved
	ToolWindowResizedUPP	toolWindowResizedProc;	// Routine to call when tool's window has been resized
	ToolWindowActivateUPP	toolWindowActivateProc;	// Routine to call when tool's window has been activated or deactivated
};
#ifdef powerc
	#pragma options align=reset
#endif

typedef struct ToolInfoBlock ToolInfoBlock, *ToolInfoPtr;

// === Prototypes for our tools
OSErr ToolStartup (WindowPtr wp);
void ToolShutdown (WindowPtr wp);
void ToolMenuAdjust (WindowPtr wp);
void ToolMenuDispatch (WindowPtr wp, short menuID, short itemID);
void ToolIdle (WindowPtr wp);
void ToolUpdate (WindowPtr wp);
void ToolWindowKey(WindowPtr wp, EventRecord *theEvent);
void ToolWindowClick(WindowPtr wp, EventRecord *theEvent);
void ToolWindowMoved(WindowPtr wp);
void ToolWindowResized(WindowPtr wp);
void ToolWindowActivate(WindowPtr wp, Boolean activeFlag);

#endif // __TOOLAPI__
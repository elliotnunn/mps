{
     File:       Threads.p
 
     Contains:   Thread Manager Interfaces.
 
     Version:    Technology: Mac OS 8
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1991-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Threads;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __THREADS__}
{$SETC __THREADS__ := 1}

{$I+}
{$SETC ThreadsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{$IFC UNDEFINED __MACERRORS__}
{$I MacErrors.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{  Thread states }

TYPE
	ThreadState 				= UInt16;
CONST
	kReadyThreadState			= 0;
	kStoppedThreadState			= 1;
	kRunningThreadState			= 2;

	{  Error codes have been moved to Errors.(pah) }

	{  Thread environment characteristics }

TYPE
	ThreadTaskRef						= Ptr;
	{  Thread characteristics }
	ThreadStyle 				= UInt32;
CONST
	kCooperativeThread			= $00000001;
	kPreemptiveThread			= $00000002;

	{  Thread identifiers }

TYPE
	ThreadID 					= UInt32;
CONST
	kNoThreadID					= 0;
	kCurrentThreadID			= 1;
	kApplicationThreadID		= 2;

	{  Options when creating a thread }

TYPE
	ThreadOptions 				= UInt32;
CONST
	kNewSuspend					= $01;
	kUsePremadeThread			= $02;
	kCreateIfNeeded				= $04;
	kFPUNotNeeded				= $08;
	kExactMatchThread			= $10;

	{  Information supplied to the custom scheduler }

TYPE
	SchedulerInfoRecPtr = ^SchedulerInfoRec;
	SchedulerInfoRec = RECORD
		InfoRecSize:			UInt32;
		CurrentThreadID:		ThreadID;
		SuggestedThreadID:		ThreadID;
		InterruptedCoopThreadID: ThreadID;
	END;


	{	
	    The following ProcPtrs cannot be interchanged with UniversalProcPtrs because
	    of differences between 680x0 and PowerPC runtime architectures with regard to
	    the implementation of the Thread Manager.
	 	}
	voidPtr								= Ptr;
	{  Prototype for thread's entry (main) routine }
{$IFC TYPED_FUNCTION_POINTERS}
	ThreadEntryProcPtr = FUNCTION(threadParam: UNIV Ptr): voidPtr;
{$ELSEC}
	ThreadEntryProcPtr = ProcPtr;
{$ENDC}

	{  Prototype for custom thread scheduler routine }
{$IFC TYPED_FUNCTION_POINTERS}
	ThreadSchedulerProcPtr = FUNCTION(schedulerInfo: SchedulerInfoRecPtr): ThreadID;
{$ELSEC}
	ThreadSchedulerProcPtr = ProcPtr;
{$ENDC}

	{  Prototype for custom thread switcher routine }
{$IFC TYPED_FUNCTION_POINTERS}
	ThreadSwitchProcPtr = PROCEDURE(threadBeingSwitched: ThreadID; switchProcParam: UNIV Ptr);
{$ELSEC}
	ThreadSwitchProcPtr = ProcPtr;
{$ENDC}

	{  Prototype for thread termination notification routine }
{$IFC TYPED_FUNCTION_POINTERS}
	ThreadTerminationProcPtr = PROCEDURE(threadTerminated: ThreadID; terminationProcParam: UNIV Ptr);
{$ELSEC}
	ThreadTerminationProcPtr = ProcPtr;
{$ENDC}

	{  Prototype for debugger NewThread notification }
{$IFC TYPED_FUNCTION_POINTERS}
	DebuggerNewThreadProcPtr = PROCEDURE(threadCreated: ThreadID);
{$ELSEC}
	DebuggerNewThreadProcPtr = ProcPtr;
{$ENDC}

	{  Prototype for debugger DisposeThread notification }
{$IFC TYPED_FUNCTION_POINTERS}
	DebuggerDisposeThreadProcPtr = PROCEDURE(threadDeleted: ThreadID);
{$ELSEC}
	DebuggerDisposeThreadProcPtr = ProcPtr;
{$ENDC}

	{  Prototype for debugger schedule notification }
{$IFC TYPED_FUNCTION_POINTERS}
	DebuggerThreadSchedulerProcPtr = FUNCTION(schedulerInfo: SchedulerInfoRecPtr): ThreadID;
{$ELSEC}
	DebuggerThreadSchedulerProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	ThreadEntryUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ThreadEntryUPP = ThreadEntryProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ThreadSchedulerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ThreadSchedulerUPP = ThreadSchedulerProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ThreadSwitchUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ThreadSwitchUPP = ThreadSwitchProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	ThreadTerminationUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	ThreadTerminationUPP = ThreadTerminationProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DebuggerNewThreadUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DebuggerNewThreadUPP = DebuggerNewThreadProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DebuggerDisposeThreadUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DebuggerDisposeThreadUPP = DebuggerDisposeThreadProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	DebuggerThreadSchedulerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	DebuggerThreadSchedulerUPP = DebuggerThreadSchedulerProcPtr;
{$ENDC}	

CONST
	uppThreadEntryProcInfo = $000000F0;
	uppThreadSchedulerProcInfo = $000000F0;
	uppThreadSwitchProcInfo = $000003C0;
	uppThreadTerminationProcInfo = $000003C0;
	uppDebuggerNewThreadProcInfo = $000000C0;
	uppDebuggerDisposeThreadProcInfo = $000000C0;
	uppDebuggerThreadSchedulerProcInfo = $000000F0;
	{
	 *  NewThreadEntryUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewThreadEntryUPP(userRoutine: ThreadEntryProcPtr): ThreadEntryUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewThreadSchedulerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewThreadSchedulerUPP(userRoutine: ThreadSchedulerProcPtr): ThreadSchedulerUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewThreadSwitchUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewThreadSwitchUPP(userRoutine: ThreadSwitchProcPtr): ThreadSwitchUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewThreadTerminationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewThreadTerminationUPP(userRoutine: ThreadTerminationProcPtr): ThreadTerminationUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDebuggerNewThreadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDebuggerNewThreadUPP(userRoutine: DebuggerNewThreadProcPtr): DebuggerNewThreadUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDebuggerDisposeThreadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDebuggerDisposeThreadUPP(userRoutine: DebuggerDisposeThreadProcPtr): DebuggerDisposeThreadUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewDebuggerThreadSchedulerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewDebuggerThreadSchedulerUPP(userRoutine: DebuggerThreadSchedulerProcPtr): DebuggerThreadSchedulerUPP;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeThreadEntryUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeThreadEntryUPP(userUPP: ThreadEntryUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeThreadSchedulerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeThreadSchedulerUPP(userUPP: ThreadSchedulerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeThreadSwitchUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeThreadSwitchUPP(userUPP: ThreadSwitchUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeThreadTerminationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeThreadTerminationUPP(userUPP: ThreadTerminationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDebuggerNewThreadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDebuggerNewThreadUPP(userUPP: DebuggerNewThreadUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDebuggerDisposeThreadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDebuggerDisposeThreadUPP(userUPP: DebuggerDisposeThreadUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeDebuggerThreadSchedulerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeDebuggerThreadSchedulerUPP(userUPP: DebuggerThreadSchedulerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeThreadEntryUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeThreadEntryUPP(threadParam: UNIV Ptr; userRoutine: ThreadEntryUPP): voidPtr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeThreadSchedulerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeThreadSchedulerUPP(schedulerInfo: SchedulerInfoRecPtr; userRoutine: ThreadSchedulerUPP): ThreadID;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeThreadSwitchUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeThreadSwitchUPP(threadBeingSwitched: ThreadID; switchProcParam: UNIV Ptr; userRoutine: ThreadSwitchUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeThreadTerminationUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeThreadTerminationUPP(threadTerminated: ThreadID; terminationProcParam: UNIV Ptr; userRoutine: ThreadTerminationUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDebuggerNewThreadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDebuggerNewThreadUPP(threadCreated: ThreadID; userRoutine: DebuggerNewThreadUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDebuggerDisposeThreadUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeDebuggerDisposeThreadUPP(threadDeleted: ThreadID; userRoutine: DebuggerDisposeThreadUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeDebuggerThreadSchedulerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeDebuggerThreadSchedulerUPP(schedulerInfo: SchedulerInfoRecPtr; userRoutine: DebuggerThreadSchedulerUPP): ThreadID;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
   Thread Manager function pointers (TPP):
   on classic 68k use raw function pointers (same as UPP's)
   on classic PowerPC, use raw function pointers
   on classic PowerPC with OPAQUE_UPP_TYPES=1, use UPP's
   on CFM-68K, use UPP's
   on Carbon, use UPP's
}

{$IFC TARGET_OS_MAC AND TARGET_CPU_PPC AND NOT OPAQUE_UPP_TYPES }
{  use raw function pointers }

TYPE
	ThreadEntryTPP						= ThreadEntryProcPtr;
	ThreadSchedulerTPP					= ThreadSchedulerProcPtr;
	ThreadSwitchTPP						= ThreadSwitchProcPtr;
	ThreadTerminationTPP				= ThreadTerminationProcPtr;
	DebuggerNewThreadTPP				= DebuggerNewThreadProcPtr;
	DebuggerDisposeThreadTPP			= DebuggerDisposeThreadProcPtr;
	DebuggerThreadSchedulerTPP			= DebuggerThreadSchedulerProcPtr;
{$ELSEC}
{  use UPP's }

TYPE
	ThreadEntryTPP						= ThreadEntryUPP;
	ThreadSchedulerTPP					= ThreadSchedulerUPP;
	ThreadSwitchTPP						= ThreadSwitchUPP;
	ThreadTerminationTPP				= ThreadTerminationUPP;
	DebuggerNewThreadTPP				= DebuggerNewThreadUPP;
	DebuggerDisposeThreadTPP			= DebuggerDisposeThreadUPP;
	DebuggerThreadSchedulerTPP			= DebuggerThreadSchedulerUPP;
{$ENDC}

	{
	 *  NewThread()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewThread(threadStyle: ThreadStyle; threadEntry: ThreadEntryTPP; threadParam: UNIV Ptr; stackSize: Size; options: ThreadOptions; threadResult: UNIV Ptr; VAR threadMade: ThreadID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0E03, $ABF2;
	{$ENDC}

{
 *  SetThreadScheduler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetThreadScheduler(threadScheduler: ThreadSchedulerTPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0209, $ABF2;
	{$ENDC}

{
 *  SetThreadSwitcher()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetThreadSwitcher(thread: ThreadID; threadSwitcher: ThreadSwitchTPP; switchProcParam: UNIV Ptr; inOrOut: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $070A, $ABF2;
	{$ENDC}

{
 *  SetThreadTerminator()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetThreadTerminator(thread: ThreadID; threadTerminator: ThreadTerminationTPP; terminationProcParam: UNIV Ptr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0611, $ABF2;
	{$ENDC}

{
 *  SetDebuggerNotificationProcs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDebuggerNotificationProcs(notifyNewThread: DebuggerNewThreadTPP; notifyDisposeThread: DebuggerDisposeThreadTPP; notifyThreadScheduler: DebuggerThreadSchedulerTPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $060D, $ABF2;
	{$ENDC}

{
 *  CreateThreadPool()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CreateThreadPool(threadStyle: ThreadStyle; numToCreate: SInt16; stackSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0501, $ABF2;
	{$ENDC}

{
 *  GetFreeThreadCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetFreeThreadCount(threadStyle: ThreadStyle; VAR freeCount: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0402, $ABF2;
	{$ENDC}

{
 *  GetSpecificFreeThreadCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetSpecificFreeThreadCount(threadStyle: ThreadStyle; stackSize: Size; VAR freeCount: SInt16): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0615, $ABF2;
	{$ENDC}

{
 *  GetDefaultThreadStackSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetDefaultThreadStackSize(threadStyle: ThreadStyle; VAR stackSize: Size): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0413, $ABF2;
	{$ENDC}

{
 *  ThreadCurrentStackSpace()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ThreadCurrentStackSpace(thread: ThreadID; VAR freeStack: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0414, $ABF2;
	{$ENDC}

{
 *  DisposeThread()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION DisposeThread(threadToDump: ThreadID; threadResult: UNIV Ptr; recycleThread: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0504, $ABF2;
	{$ENDC}

{
 *  YieldToThread()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION YieldToThread(suggestedThread: ThreadID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0205, $ABF2;
	{$ENDC}

{
 *  YieldToAnyThread()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION YieldToAnyThread: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $42A7, $303C, $0205, $ABF2;
	{$ENDC}

{
 *  [Mac]GetCurrentThread()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCurrentThread(VAR currentThreadID: ThreadID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0206, $ABF2;
	{$ENDC}

{
 *  GetThreadState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThreadState(threadToGet: ThreadID; VAR threadState: ThreadState): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0407, $ABF2;
	{$ENDC}

{
 *  SetThreadState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetThreadState(threadToSet: ThreadID; newState: ThreadState; suggestedThread: ThreadID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0508, $ABF2;
	{$ENDC}

{
 *  SetThreadStateEndCritical()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetThreadStateEndCritical(threadToSet: ThreadID; newState: ThreadState; suggestedThread: ThreadID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0512, $ABF2;
	{$ENDC}

{
 *  ThreadBeginCritical()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ThreadBeginCritical: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000B, $ABF2;
	{$ENDC}

{
 *  ThreadEndCritical()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ThreadEndCritical: OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $000C, $ABF2;
	{$ENDC}

{
 *  GetThreadCurrentTaskRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThreadCurrentTaskRef(VAR threadTRef: ThreadTaskRef): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $020E, $ABF2;
	{$ENDC}

{
 *  GetThreadStateGivenTaskRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetThreadStateGivenTaskRef(threadTRef: ThreadTaskRef; threadToGet: ThreadID; VAR threadState: ThreadState): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $060F, $ABF2;
	{$ENDC}

{
 *  SetThreadReadyGivenTaskRef()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in ThreadsLib 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetThreadReadyGivenTaskRef(threadTRef: ThreadTaskRef; threadToSet: ThreadID): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0410, $ABF2;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ThreadsIncludes}

{$ENDC} {__THREADS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

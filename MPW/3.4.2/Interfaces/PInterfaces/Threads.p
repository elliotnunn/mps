{
 	File:		Threads.p
 
 	Contains:	Thread Manager Interfaces.
 
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
 UNIT Threads;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __THREADS__}
{$SETC __THREADS__ := 1}

{$I+}
{$SETC ThreadsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __ERRORS__}
{$I Errors.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __MEMORY__}
{$I Memory.p}
{$ENDC}
{	Types.p														}
{	MixedMode.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
	
TYPE
	ThreadState = INTEGER;


CONST
	kReadyThreadState			= 0;
	kStoppedThreadState			= 1;
	kRunningThreadState			= 2;

{ Error codes have been meoved to Errors.(pah) }
{ Thread environment characteristics }
	
TYPE
	ThreadTaskRef = Ptr;

{ Thread characteristics }
	ThreadStyle = LONGINT;


CONST
	kCooperativeThread			= 1 * (2**(0));
	kPreemptiveThread			= 1 * (2**(1));

{ Thread identifiers }
	
TYPE
	ThreadID = LONGINT;


CONST
	kNoThreadID					= 0;
	kCurrentThreadID			= 1;
	kApplicationThreadID		= 2;

{ Options when creating a thread }
	
TYPE
	ThreadOptions = LONGINT;


CONST
	kNewSuspend					= 0+(1 * (2**(0)));
	kUsePremadeThread			= 0+(1 * (2**(1)));
	kCreateIfNeeded				= 0+(1 * (2**(2)));
	kFPUNotNeeded				= 0+(1 * (2**(3)));
	kExactMatchThread			= 0+(1 * (2**(4)));

{ Information supplied to the custom scheduler }

TYPE
	SchedulerInfoRec = RECORD
		InfoRecSize:			LONGINT;
		CurrentThreadID:		ThreadID;
		SuggestedThreadID:		ThreadID;
		InterruptedCoopThreadID: ThreadID;
	END;

	SchedulerInfoRecPtr = ^SchedulerInfoRec;

{$IFC GENERATING68K  & GENERATINGCFM }
{
	The following UniversalProcPtrs are for CFM-68k compatiblity with
	the implementation of the Thread Manager.
}
	ThreadEntryProcPtr = UniversalProcPtr;

	ThreadSchedulerProcPtr = UniversalProcPtr;

	ThreadSwitchProcPtr = UniversalProcPtr;

	ThreadTerminationProcPtr = UniversalProcPtr;

	DebuggerNewThreadProcPtr = UniversalProcPtr;

	DebuggerDisposeThreadProcPtr = UniversalProcPtr;

	DebuggerThreadSchedulerProcPtr = UniversalProcPtr;

{$ELSEC}
{
	The following ProcPtrs cannot be interchanged with UniversalProcPtrs because
	of differences between 680x0 and PowerPC runtime architectures with regard to
	the implementation of the Thread Manager.
 }
{ Prototype for thread's entry (main) routine }
	voidPtr = Ptr;

	ThreadEntryProcPtr = ProcPtr;  { FUNCTION (threadParam: UNIV Ptr): voidPtr; }

{ Prototype for custom thread scheduler routine }
	ThreadSchedulerProcPtr = ProcPtr;  { FUNCTION (schedulerInfo: SchedulerInfoRecPtr): ThreadID; }

{ Prototype for custom thread switcher routine }
	ThreadSwitchProcPtr = ProcPtr;  { PROCEDURE (threadBeingSwitched: ThreadID; switchProcParam: UNIV Ptr); }

{ Prototype for thread termination notification routine }
	ThreadTerminationProcPtr = ProcPtr;  { PROCEDURE (threadTerminated: ThreadID; terminationProcParam: UNIV Ptr); }

{ Prototype for debugger NewThread notification }
	DebuggerNewThreadProcPtr = ProcPtr;  { PROCEDURE (threadCreated: ThreadID); }

{ Prototype for debugger DisposeThread notification }
	DebuggerDisposeThreadProcPtr = ProcPtr;  { PROCEDURE (threadDeleted: ThreadID); }

{ Prototype for debugger schedule notification }
	DebuggerThreadSchedulerProcPtr = ProcPtr;  { FUNCTION (schedulerInfo: SchedulerInfoRecPtr): ThreadID; }

{$ENDC}

FUNCTION CreateThreadPool(threadStyle: ThreadStyle; numToCreate: INTEGER; stackSize: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0501, $ABF2;
	{$ENDC}
FUNCTION GetFreeThreadCount(threadStyle: ThreadStyle; VAR freeCount: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0402, $ABF2;
	{$ENDC}
FUNCTION GetSpecificFreeThreadCount(threadStyle: ThreadStyle; stackSize: Size; VAR freeCount: INTEGER): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0615, $ABF2;
	{$ENDC}
FUNCTION GetDefaultThreadStackSize(threadStyle: ThreadStyle; VAR stackSize: Size): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0413, $ABF2;
	{$ENDC}
FUNCTION ThreadCurrentStackSpace(thread: ThreadID; VAR freeStack: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0414, $ABF2;
	{$ENDC}
FUNCTION NewThread(threadStyle: ThreadStyle; threadEntry: ThreadEntryProcPtr; threadParam: UNIV Ptr; stackSize: Size; options: ThreadOptions; threadResult: UNIV Ptr; VAR threadMade: ThreadID): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0E03, $ABF2;
	{$ENDC}
FUNCTION DisposeThread(threadToDump: ThreadID; threadResult: UNIV Ptr; recycleThread: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0504, $ABF2;
	{$ENDC}
FUNCTION YieldToThread(suggestedThread: ThreadID): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0205, $ABF2;
	{$ENDC}
FUNCTION YieldToAnyThread: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $42A7, $303C, $0205, $ABF2;
	{$ENDC}
FUNCTION GetCurrentThread(VAR currentThreadID: ThreadID): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0206, $ABF2;
	{$ENDC}
FUNCTION GetThreadState(threadToGet: ThreadID; VAR threadState: ThreadState): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0407, $ABF2;
	{$ENDC}
FUNCTION SetThreadState(threadToSet: ThreadID; newState: ThreadState; suggestedThread: ThreadID): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0508, $ABF2;
	{$ENDC}
FUNCTION SetThreadStateEndCritical(threadToSet: ThreadID; newState: ThreadState; suggestedThread: ThreadID): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0512, $ABF2;
	{$ENDC}
FUNCTION SetThreadScheduler(threadScheduler: ThreadSchedulerProcPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0209, $ABF2;
	{$ENDC}
FUNCTION SetThreadSwitcher(thread: ThreadID; threadSwitcher: ThreadSwitchProcPtr; switchProcParam: UNIV Ptr; inOrOut: BOOLEAN): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $070A, $ABF2;
	{$ENDC}
FUNCTION SetThreadTerminator(thread: ThreadID; threadTerminator: ThreadTerminationProcPtr; terminationProcParam: UNIV Ptr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0611, $ABF2;
	{$ENDC}
FUNCTION ThreadBeginCritical: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $000B, $ABF2;
	{$ENDC}
FUNCTION ThreadEndCritical: OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $000C, $ABF2;
	{$ENDC}
FUNCTION SetDebuggerNotificationProcs(notifyNewThread: DebuggerNewThreadProcPtr; notifyDisposeThread: DebuggerDisposeThreadProcPtr; notifyThreadScheduler: DebuggerThreadSchedulerProcPtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $060D, $ABF2;
	{$ENDC}
FUNCTION GetThreadCurrentTaskRef(VAR threadTRef: ThreadTaskRef): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $020E, $ABF2;
	{$ENDC}
FUNCTION GetThreadStateGivenTaskRef(threadTRef: ThreadTaskRef; threadToGet: ThreadID; VAR threadState: ThreadState): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $060F, $ABF2;
	{$ENDC}
FUNCTION SetThreadReadyGivenTaskRef(threadTRef: ThreadTaskRef; threadToSet: ThreadID): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $0410, $ABF2;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ThreadsIncludes}

{$ENDC} {__THREADS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

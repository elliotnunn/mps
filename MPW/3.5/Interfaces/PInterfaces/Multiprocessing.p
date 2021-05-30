{
     File:       Multiprocessing.p
 
     Contains:   Multiprocessing interfaces
 
     Version:    Technology: Multiprocessing API version 2.2, integrated NanoKernel support
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1995-2001 DayStar Digital, Inc.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}


{
   ===========================================================================================
   *** WARNING: You must properly check the availability of MP services before calling them!
   See the section titled "Checking API Availability".
   ===========================================================================================
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Multiprocessing;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MULTIPROCESSING__}
{$SETC __MULTIPROCESSING__ := 1}

{$I+}
{$SETC MultiprocessingIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}


{
   ===========================================================================================
   This is the header file for version 2.2 of the Mac OS multiprocessing support.  This version
   has been totally reimplemented and has significant new services.  The main goal of the
   reimplementation has been to transfer task management into the core operating system to provide
   much more reliable and more efficient operation, including on single processor machines.
   The memory management has also been massively improved, it is much faster and wastes much
   less space.  New services include POSIX style per-task storage, timers with millisecond and
   microsecond resolutions, memory allocation at a specified alignment, and system pageable
   and RAM resident memory pools.  See the MP API documentation for details.
   The old "DayStar" debugging services (whose names began with an underscore) have been
   removed from this header.  A very few are still implemented for binary compatibility, or in
   cases where they happened to be exposed inappropriately.  (E.g. _MPIsFullyInitialized must
   be called to see if the MP API is ReallyTruly™ usable.)  New code and recompiles of old
   code should avoid use of these defunct services, except for _MPIsFullyInitialized.
   ===========================================================================================
}


{
   ===========================================================================================
   The following services are from the original MP API and remain supported in version 2.0:
    MPProcessors
    MPCreateTask
    MPTerminateTask
    MPCurrentTaskID
    MPYield
    MPExit
    MPCreateQueue
    MPDeleteQueue
    MPNotifyQueue
    MPWaitOnQueue
    MPCreateSemaphore
    MPCreateBinarySemaphore     (In C only, a macro that calls MPCreateSemaphore.)
    MPDeleteSemaphore
    MPSignalSemaphore
    MPWaitOnSemaphore
    MPCreateCriticalRegion
    MPDeleteCriticalRegion
    MPEnterCriticalRegion
    MPExitCriticalRegion
    MPAllocate                  (Deprecated, use MPAllocateAligned for new builds.)
    MPFree
    MPBlockCopy
    MPLibraryIsLoaded           (In C only, a macro.)
    _MPIsFullyInitialized       (See comments about checking for MP API availability.)
   ===========================================================================================
}


{
   ===========================================================================================
   The following services are new in version 2.0:
    MPProcessorsScheduled
    MPSetTaskWeight
    MPTaskIsPreemptive
    MPAllocateTaskStorageIndex
    MPDeallocateTaskStorageIndex
    MPSetTaskStorageValue
    MPGetTaskStorageValue
    MPSetQueueReserve
    MPCreateEvent
    MPDeleteEvent
    MPSetEvent
    MPWaitForEvent
    UpTime
    DurationToAbsolute
    AbsoluteToDuration
    MPDelayUntil
    MPCreateTimer
    MPDeleteTimer
    MPSetTimerNotify
    MPArmTimer
    MPCancelTimer
    MPSetExceptionHandler
    MPThrowException
    MPDisposeTaskException
    MPExtractTaskState
    MPSetTaskState
    MPRegisterDebugger
    MPUnregisterDebugger
    MPAllocateAligned           (Preferred over MPAllocate.)
    MPGetAllocatedBlockSize
    MPBlockClear
    MPDataToCode
    MPRemoteCall                (Preferred over _MPRPC.)
   ===========================================================================================
}


{
   ===========================================================================================
   The following services are new in version 2.1:
    MPCreateNotification
    MPDeleteNotification
    MPModifyNotification
    MPCauseNotification
    MPGetNextTaskID
    MPGetNextCpuID
   ===========================================================================================
}


{
   ===========================================================================================
   The following services are "unofficial" extensions to the original API.  They are not in
   the multiprocessing API documentation, but were in previous versions of this header.  They
   remain supported in version 2.0.  They may not be supported in other environments.
    _MPRPC                      (Deprecated, use MPRemoteCall for new builds.)
    _MPAllocateSys              (Deprecated, use MPAllocateAligned for new builds.)
    _MPTaskIsToolboxSafe
    _MPLibraryVersion
    _MPLibraryIsCompatible
   ===========================================================================================
}


{
   ===========================================================================================
   The following services were in previous versions of this header for "debugging only" use.
   They are NOT implemented in version 2.0.  For old builds they can be accessed by defining
   the symbol MPIncludeDefunctServices to have a nonzero value.
    _MPInitializePrintf
    _MPPrintf
    _MPDebugStr
    _MPStatusPString
    _MPStatusCString
   ===========================================================================================
}


{
   §
   ===========================================================================================
   General Types and Constants
   ===========================
}




CONST
	MPLibrary_MajorVersion		= 2;							{  ! When these change be sure to update the build versions }
	MPLibrary_MinorVersion		= 3;							{  !  used in the startup check in MPInitializeAPI! }
	MPLibrary_Release			= 1;
	MPLibrary_DevelopmentRevision = 1;




TYPE
	MPProcessID    = ^LONGINT; { an opaque 32-bit type }
	MPProcessIDPtr = ^MPProcessID;  { when a VAR xx:MPProcessID parameter can be nil, it is changed to xx: MPProcessIDPtr }
	MPTaskID    = ^LONGINT; { an opaque 32-bit type }
	MPTaskIDPtr = ^MPTaskID;  { when a VAR xx:MPTaskID parameter can be nil, it is changed to xx: MPTaskIDPtr }
	MPQueueID    = ^LONGINT; { an opaque 32-bit type }
	MPQueueIDPtr = ^MPQueueID;  { when a VAR xx:MPQueueID parameter can be nil, it is changed to xx: MPQueueIDPtr }
	MPSemaphoreID    = ^LONGINT; { an opaque 32-bit type }
	MPSemaphoreIDPtr = ^MPSemaphoreID;  { when a VAR xx:MPSemaphoreID parameter can be nil, it is changed to xx: MPSemaphoreIDPtr }
	MPCriticalRegionID    = ^LONGINT; { an opaque 32-bit type }
	MPCriticalRegionIDPtr = ^MPCriticalRegionID;  { when a VAR xx:MPCriticalRegionID parameter can be nil, it is changed to xx: MPCriticalRegionIDPtr }
	MPTimerID    = ^LONGINT; { an opaque 32-bit type }
	MPTimerIDPtr = ^MPTimerID;  { when a VAR xx:MPTimerID parameter can be nil, it is changed to xx: MPTimerIDPtr }
	MPEventID    = ^LONGINT; { an opaque 32-bit type }
	MPEventIDPtr = ^MPEventID;  { when a VAR xx:MPEventID parameter can be nil, it is changed to xx: MPEventIDPtr }
	MPAddressSpaceID    = ^LONGINT; { an opaque 32-bit type }
	MPAddressSpaceIDPtr = ^MPAddressSpaceID;  { when a VAR xx:MPAddressSpaceID parameter can be nil, it is changed to xx: MPAddressSpaceIDPtr }
	MPNotificationID    = ^LONGINT; { an opaque 32-bit type }
	MPNotificationIDPtr = ^MPNotificationID;  { when a VAR xx:MPNotificationID parameter can be nil, it is changed to xx: MPNotificationIDPtr }
	MPCoherenceID    = ^LONGINT; { an opaque 32-bit type }
	MPCoherenceIDPtr = ^MPCoherenceID;  { when a VAR xx:MPCoherenceID parameter can be nil, it is changed to xx: MPCoherenceIDPtr }
	MPCpuID    = ^LONGINT; { an opaque 32-bit type }
	MPCpuIDPtr = ^MPCpuID;  { when a VAR xx:MPCpuID parameter can be nil, it is changed to xx: MPCpuIDPtr }
	MPAreaID    = ^LONGINT; { an opaque 32-bit type }
	MPAreaIDPtr = ^MPAreaID;  { when a VAR xx:MPAreaID parameter can be nil, it is changed to xx: MPAreaIDPtr }
	MPConsoleID    = ^LONGINT; { an opaque 32-bit type }
	MPConsoleIDPtr = ^MPConsoleID;  { when a VAR xx:MPConsoleID parameter can be nil, it is changed to xx: MPConsoleIDPtr }
	MPOpaqueID    = ^LONGINT; { an opaque 32-bit type }
	MPOpaqueIDPtr = ^MPOpaqueID;  { when a VAR xx:MPOpaqueID parameter can be nil, it is changed to xx: MPOpaqueIDPtr }

CONST
																{  Values for MPOpaqueIDClass. }
	kOpaqueAnyID				= 0;
	kOpaqueProcessID			= 1;
	kOpaqueTaskID				= 2;
	kOpaqueTimerID				= 3;
	kOpaqueQueueID				= 4;
	kOpaqueSemaphoreID			= 5;
	kOpaqueCriticalRegionID		= 6;
	kOpaqueCpuID				= 7;
	kOpaqueAddressSpaceID		= 8;
	kOpaqueEventID				= 9;
	kOpaqueCoherenceID			= 10;
	kOpaqueAreaID				= 11;
	kOpaqueNotificationID		= 12;
	kOpaqueConsoleID			= 13;


TYPE
	MPOpaqueIDClass						= UInt32;


CONST
	kMPNoID						= 0;							{  New code should use kInvalidID everywhere. }



TYPE
	MPTaskOptions						= OptionBits;
	TaskStorageIndex					= UInt32;
	TaskStorageValue					= UInt32;
	MPSemaphoreCount					= ItemCount;
	MPTaskWeight						= UInt32;
	MPEventFlags						= UInt32;
	MPExceptionKind						= UInt32;
	MPTaskStateKind						= UInt32;
	MPPageSizeClass						= UInt32;


CONST
	kDurationImmediate			= 0;
	kDurationForever			= $7FFFFFFF;
	kDurationMillisecond		= 1;
	kDurationMicrosecond		= -1;


	{
	   §
	   ===========================================================================================
	   Process/Processor Services
	   ==========================
	}



	{
	 *  MPProcessors()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION MPProcessors: ItemCount; C;

{  The physical total. }

{
 *  MPProcessorsScheduled()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPProcessorsScheduled: ItemCount; C;

{  Those currently in use. }

{
   §
   ===========================================================================================
   Tasking Services
   ================
}




CONST
																{  For MPCreateTask options }
	kMPCreateTaskSuspendedMask	= $00000001;
	kMPCreateTaskTakesAllExceptionsMask = $00000002;
	kMPCreateTaskNotDebuggableMask = $00000004;
	kMPCreateTaskValidOptionsMask = $00000007;


	{  ------------------------------------------------------------------------------------------- }





TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	TaskProc = FUNCTION(parameter: UNIV Ptr): OSStatus; C;
{$ELSEC}
	TaskProc = ProcPtr;
{$ENDC}


	{
	 *  MPCreateTask()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION MPCreateTask(entryPoint: TaskProc; parameter: UNIV Ptr; stackSize: ByteCount; notifyQueue: MPQueueID; terminationParameter1: UNIV Ptr; terminationParameter2: UNIV Ptr; options: MPTaskOptions; VAR task: MPTaskID): OSStatus; C;



{
 *  MPTerminateTask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPTerminateTask(task: MPTaskID; terminationStatus: OSStatus): OSStatus; C;



{
 *  MPSetTaskWeight()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPSetTaskWeight(task: MPTaskID; weight: MPTaskWeight): OSStatus; C;



{
 *  MPTaskIsPreemptive()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPTaskIsPreemptive(taskID: MPTaskID): BOOLEAN; C;

{  May be kInvalidID. }

{
 *  MPExit()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MPExit(status: OSStatus); C;



{
 *  MPYield()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MPYield; C;



{
 *  MPCurrentTaskID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPCurrentTaskID: MPTaskID; C;



{
 *  MPSetTaskType()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.3 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPSetTaskType(task: MPTaskID; taskType: OSType): OSStatus; C;


{  ------------------------------------------------------------------------------------------- }


{
   ---------------------------------------------------
   ! The task storage services are new in version 2.0.
}



{
 *  MPAllocateTaskStorageIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPAllocateTaskStorageIndex(VAR index: TaskStorageIndex): OSStatus; C;



{
 *  MPDeallocateTaskStorageIndex()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPDeallocateTaskStorageIndex(index: TaskStorageIndex): OSStatus; C;



{
 *  MPSetTaskStorageValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPSetTaskStorageValue(index: TaskStorageIndex; value: TaskStorageValue): OSStatus; C;



{
 *  MPGetTaskStorageValue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPGetTaskStorageValue(index: TaskStorageIndex): TaskStorageValue; C;


{
   §
   ===========================================================================================
   Synchronization Services
   ========================
}



{
 *  MPCreateQueue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPCreateQueue(VAR queue: MPQueueID): OSStatus; C;



{
 *  MPDeleteQueue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPDeleteQueue(queue: MPQueueID): OSStatus; C;



{
 *  MPNotifyQueue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPNotifyQueue(queue: MPQueueID; param1: UNIV Ptr; param2: UNIV Ptr; param3: UNIV Ptr): OSStatus; C;



{
 *  MPWaitOnQueue()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPWaitOnQueue(queue: MPQueueID; VAR param1: UNIV Ptr; VAR param2: UNIV Ptr; VAR param3: UNIV Ptr; timeout: Duration): OSStatus; C;



{
 *  MPSetQueueReserve()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPSetQueueReserve(queue: MPQueueID; count: ItemCount): OSStatus; C;


{  ------------------------------------------------------------------------------------------- }



{
 *  MPCreateSemaphore()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPCreateSemaphore(maximumValue: MPSemaphoreCount; initialValue: MPSemaphoreCount; VAR semaphore: MPSemaphoreID): OSStatus; C;



{
 *  MPDeleteSemaphore()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPDeleteSemaphore(semaphore: MPSemaphoreID): OSStatus; C;



{
 *  MPSignalSemaphore()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPSignalSemaphore(semaphore: MPSemaphoreID): OSStatus; C;



{
 *  MPWaitOnSemaphore()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPWaitOnSemaphore(semaphore: MPSemaphoreID; timeout: Duration): OSStatus; C;



{  ------------------------------------------------------------------------------------------- }



{
 *  MPCreateCriticalRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPCreateCriticalRegion(VAR criticalRegion: MPCriticalRegionID): OSStatus; C;



{
 *  MPDeleteCriticalRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPDeleteCriticalRegion(criticalRegion: MPCriticalRegionID): OSStatus; C;



{
 *  MPEnterCriticalRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPEnterCriticalRegion(criticalRegion: MPCriticalRegionID; timeout: Duration): OSStatus; C;



{
 *  MPExitCriticalRegion()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPExitCriticalRegion(criticalRegion: MPCriticalRegionID): OSStatus; C;


{  ------------------------------------------------------------------------------------------- }


{
 *  MPCreateEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPCreateEvent(VAR event: MPEventID): OSStatus;


{
 *  MPDeleteEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPDeleteEvent(event: MPEventID): OSStatus; C;



{
 *  MPSetEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPSetEvent(event: MPEventID; flags: MPEventFlags): OSStatus; C;


{
 *  MPWaitForEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPWaitForEvent(event: MPEventID; VAR flags: MPEventFlags; timeout: Duration): OSStatus;

{
   §
   ===========================================================================================
   Notification Services (API)
   =====================
}



{
 *  MPCreateNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPCreateNotification(VAR notificationID: MPNotificationID): OSStatus; C;



{
 *  MPDeleteNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPDeleteNotification(notificationID: MPNotificationID): OSStatus; C;



{
 *  MPModifyNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPModifyNotification(notificationID: MPNotificationID; anID: MPOpaqueID; notifyParam1: UNIV Ptr; notifyParam2: UNIV Ptr; notifyParam3: UNIV Ptr): OSStatus; C;



{
 *  MPModifyNotificationParameters()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.3 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPModifyNotificationParameters(notificationID: MPNotificationID; kind: MPOpaqueIDClass; notifyParam1: UNIV Ptr; notifyParam2: UNIV Ptr; notifyParam3: UNIV Ptr): OSStatus; C;



{
 *  MPCauseNotification()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPCauseNotification(notificationID: MPNotificationID): OSStatus; C;


{
   §
   ===========================================================================================
   Timer Services
   ==============
}


{
   --------------------------------------------
   ! The timer services are new in version 2.0.
}


{$IFC 0 }
{  For now these are taken from DriverServices, should be in a better place. }
{$IFC CALL_NOT_IN_CARBON }
{
 *  UpTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION UpTime: AbsoluteTime; C;

{
 *  DurationToAbsolute()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION DurationToAbsolute(duration: Duration): AbsoluteTime; C;

{
 *  AbsoluteToDuration()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION AbsoluteToDuration(time: AbsoluteTime): Duration; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {0}



CONST
																{  For MPArmTimer options }
	kMPPreserveTimerIDMask		= $00000001;
	kMPTimeIsDeltaMask			= $00000002;
	kMPTimeIsDurationMask		= $00000004;



	{
	 *  MPDelayUntil()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION MPDelayUntil(VAR expirationTime: AbsoluteTime): OSStatus; C;



{$IFC CALL_NOT_IN_CARBON }
{
 *  MPDelayUntilSys()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPDelayUntilSys(VAR expirationTime: AbsoluteTime): OSStatus;



{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  MPCreateTimer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPCreateTimer(VAR timerID: MPTimerID): OSStatus; C;



{
 *  MPDeleteTimer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPDeleteTimer(timerID: MPTimerID): OSStatus; C;



{
 *  MPSetTimerNotify()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPSetTimerNotify(timerID: MPTimerID; anID: MPOpaqueID; notifyParam1: UNIV Ptr; notifyParam2: UNIV Ptr; notifyParam3: UNIV Ptr): OSStatus; C;



{
 *  MPArmTimer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPArmTimer(timerID: MPTimerID; VAR expirationTime: AbsoluteTime; options: OptionBits): OSStatus; C;



{
 *  MPCancelTimer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPCancelTimer(timerID: MPTimerID; VAR timeRemaining: AbsoluteTime): OSStatus; C;


{
   §
   ===========================================================================================
   Memory Services
   ===============
}



CONST
																{  Maximum allocation request size is 1GB. }
	kMPMaxAllocSize				= 1073741824;

																{  Values for the alignment parameter to MPAllocateAligned. }
	kMPAllocateDefaultAligned	= 0;
	kMPAllocate8ByteAligned		= 3;
	kMPAllocate16ByteAligned	= 4;
	kMPAllocate32ByteAligned	= 5;
	kMPAllocate1024ByteAligned	= 10;
	kMPAllocate4096ByteAligned	= 12;
	kMPAllocateMaxAlignment		= 16;							{  Somewhat arbitrary limit on expectations. }
	kMPAllocateAltiVecAligned	= 4;							{  The P.C. name. }
	kMPAllocateVMXAligned		= 4;							{  The older, common name. }
	kMPAllocateVMPageAligned	= 254;							{  Pseudo value, converted at runtime. }
	kMPAllocateInterlockAligned	= 255;							{  Pseudo value, converted at runtime. }



																{  Values for the options parameter to MPAllocateAligned. }
	kMPAllocateClearMask		= $0001;						{  Zero the allocated block. }
	kMPAllocateGloballyMask		= $0002;						{  Allocate from the globally visible pool. }
	kMPAllocateResidentMask		= $0004;						{  Allocate from the RAM-resident pool. }
	kMPAllocateNoGrowthMask		= $0010;						{  Do not attempt to grow the pool. }
	kMPAllocateNoCreateMask		= $0020;						{  Do not attempt to create the pool if it doesn't exist yet. }


	{  ------------------------------------------------------------------------------------------- }



	{
	 *  MPAllocateAligned()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION MPAllocateAligned(size: ByteCount; alignment: ByteParameter; options: OptionBits): LogicalAddress; C;

{  ! MPAllocateAligned is new in version 2.0. }

{
 *  MPAllocate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPAllocate(size: ByteCount): LogicalAddress; C;

{  Use MPAllocateAligned instead. }

{
 *  MPFree()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MPFree(object: LogicalAddress); C;



{
 *  MPGetAllocatedBlockSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPGetAllocatedBlockSize(object: LogicalAddress): ByteCount; C;


{  ------------------------------------------------------------------------------------------- }



{
 *  MPBlockCopy()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MPBlockCopy(source: LogicalAddress; destination: LogicalAddress; size: ByteCount); C;



{
 *  MPBlockClear()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MPBlockClear(address: LogicalAddress; size: ByteCount); C;

{  ! MPBlockClear is new in version 2.0. }

{
 *  MPDataToCode()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE MPDataToCode(address: LogicalAddress; size: ByteCount); C;

{  ! MPDataToCode is new in version 2.0. }
{
   §
   ===========================================================================================
   Exception/Debugging Services
   ============================
}


{
   -------------------------------------------------------------------------------------------
   *** Important Note ***
   ----------------------
   
   The functions MPExtractTaskState and MPSetTaskState infer the size of the "info" buffer
   from the "kind" parameter.  A given value for MPTaskStateKind will always refer to a
   single specific physical buffer layout.  Should new register sets be added, or the size
   or number of any registers change, new values of MPTaskStateKind will be introduced to
   refer to the new buffer layouts.
   
   The following types for the buffers are in MachineExceptions. The correspondence between
   MPTaskStateKind values and MachineExceptions types is:
   
        kMPTaskStateRegisters               -> RegisterInformation
        kMPTaskStateFPU                     -> FPUInformation
        kMPTaskStateVectors                 -> VectorInformation
        kMPTaskStateMachine                 -> MachineInformation
        kMPTaskState32BitMemoryException    -> ExceptionInfo for old-style 32-bit memory exceptions
   
    For reference, on PowerPC the MachineExceptions types contain:
   
        RegisterInformation -> The GPRs, 32 values of 64 bits each.
        FPUInformation      -> The FPRs plus FPSCR, 32 values of 64 bits each, one value of
                                32 bits.
        VectorInformation   -> The AltiVec vector registers plus VSCR and VRSave, 32 values
                                of 128 bits each, one value of 128 bits, and one 32 bit value.
        MachineInformation  -> The CTR, LR, PC, each of 64 bits.  The CR, XER, MSR, MQ,
                                exception kind, and DSISR, each of 32 bits.  The 64 bit DAR.
        ExceptionInfo       -> Only memory exceptions are specified, 4 fields of 32 bits each.
                                Note that this type only covers memory exceptions on 32-bit CPUs!
   The following types are declared here:
        kMPTaskStateTaskInfo                -> MPTaskInfo
}




CONST
																{  Values for the TaskStateKind to MPExtractTaskState and MPSetTaskState. }
	kMPTaskStateRegisters		= 0;							{  The task general registers. }
	kMPTaskStateFPU				= 1;							{  The task floating point registers }
	kMPTaskStateVectors			= 2;							{  The task vector registers }
	kMPTaskStateMachine			= 3;							{  The task machine registers }
	kMPTaskState32BitMemoryException = 4;						{  The task memory exception information for 32-bit CPUs. }
	kMPTaskStateTaskInfo		= 5;							{  Static and dynamic information about the task. }



																{  Option bits and numbers for MPDisposeTaskException. }
	kMPTaskPropagate			= 0;							{  The exception is propagated. }
	kMPTaskResumeStep			= 1;							{  The task is resumed and single step is enabled. }
	kMPTaskResumeBranch			= 2;							{  The task is resumed and branch stepping is enabled. }
	kMPTaskResumeMask			= $0000;						{  The task is resumed. }
	kMPTaskPropagateMask		= $01;							{  The exception is propagated. }
	kMPTaskResumeStepMask		= $02;							{  The task is resumed and single step is enabled. }
	kMPTaskResumeBranchMask		= $04;							{  The task is resumed and branch stepping is enabled. }



																{  For kMPTaskStateTaskInfo, the task's runState }
	kMPTaskBlocked				= 0;							{  Task is blocked (queued on resource) }
	kMPTaskReady				= 1;							{  Task is runnable }
	kMPTaskRunning				= 2;							{  Task is running }

																{  For kMPTaskStateTaskInfo, the version of the MPTaskInfo structure requested. }
	kMPTaskInfoVersion			= 3;



TYPE
	MPTaskInfoPtr = ^MPTaskInfo;
	MPTaskInfo = RECORD
		version:				PBVersion;								{  Version 3 of the data structure requested }
		name:					OSType;									{  Task name }
		queueName:				OSType;									{  Task's queue owner name }
		runState:				UInt16;									{  Running, ready, blocked }
		lastCPU:				UInt16;									{  Address of CPU where task previously ran }
		weight:					UInt32;									{  Processing weight: 1 - 10,000 }
		processID:				MPProcessID;							{  Owning process ID }
		cpuTime:				AbsoluteTime;							{  Accumulated task time }
		schedTime:				AbsoluteTime;							{  Time when last scheduled }
		creationTime:			AbsoluteTime;							{  Time when task created }
		codePageFaults:			ItemCount;								{  Page faults from code execution }
		dataPageFaults:			ItemCount;								{  Page faults from data access }
		preemptions:			ItemCount;								{  Number of times task was preempted }
		cpuID:					MPCpuID;								{  ID of CPU where task previously ran. }
		blockedObject:			MPOpaqueID;								{  ID of blocked object. }
		spaceID:				MPAddressSpaceID;						{  Address space ID of this task. }
		stackBase:				LogicalAddress;							{  Base of stack (lowest address). }
		stackLimit:				LogicalAddress;							{  Stack limit (highest address). }
		stackCurr:				LogicalAddress;							{  Current stack address. }
	END;

	{
	    Upon a task exception, the following message is sent to the designated queue:
	      1. The MPTaskID, 
	      2. The exception kind. These are enumerated in the interfaces header MachineExceptions.h 
	      3. N/A
	}


	{  ------------------------------------------------------------------------------------------- }



	{
	 *  MPSetExceptionHandler()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION MPSetExceptionHandler(task: MPTaskID; exceptionQ: MPQueueID): OSStatus; C;



{
 *  MPDisposeTaskException()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPDisposeTaskException(task: MPTaskID; action: OptionBits): OSStatus; C;



{
 *  MPExtractTaskState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPExtractTaskState(task: MPTaskID; kind: MPTaskStateKind; info: UNIV Ptr): OSStatus; C;



{
 *  MPSetTaskState()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPSetTaskState(task: MPTaskID; kind: MPTaskStateKind; info: UNIV Ptr): OSStatus; C;



{
 *  MPThrowException()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPThrowException(task: MPTaskID; kind: MPExceptionKind): OSStatus; C;


{  ------------------------------------------------------------------------------------------- }



TYPE
	MPDebuggerLevel 			= UInt32;
CONST
	kMPLowLevelDebugger			= $00000000;					{  MacsBug-like }
	kMPMidLevelDebugger			= $10000000;					{  Jasik-like }
	kMPHighLevelDebugger		= $20000000;					{  Metrowerks-like }



	{
	 *  MPRegisterDebugger()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION MPRegisterDebugger(queue: MPQueueID; level: MPDebuggerLevel): OSStatus; C;



{
 *  MPUnregisterDebugger()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION MPUnregisterDebugger(queue: MPQueueID): OSStatus; C;


{
   §
   ===========================================================================================
   Remote Call Services
   ====================
}




TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	MPRemoteProcedure = FUNCTION(parameter: UNIV Ptr): Ptr; C;
{$ELSEC}
	MPRemoteProcedure = ProcPtr;
{$ENDC}

	MPRemoteContext						= UInt8;

CONST
	kMPAnyRemoteContext			= 0;
	kMPOwningProcessRemoteContext = 1;
	kMPInterruptRemoteContext	= 2;
	kMPAsyncInterruptRemoteContext = 3;



	{
	 *  MPRemoteCall()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in MPLibrary 2.0 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION MPRemoteCall(remoteProc: MPRemoteProcedure; parameter: UNIV Ptr; context: ByteParameter): Ptr; C;

{  ! MPRemoteCall is new in version 2.0. }
{
   §
   ===========================================================================================
   Checking API Availability
   =========================
}


{
   ===========================================================================================
   *** WARNING: You must properly check the availability of MP services before calling them!
   ===========================================================================================
   
   Checking for the availability of the MP API is rather ugly.  This is a historical problem,
   caused by the original implementation letting itself get prepared when it really wasn't
   usable and complicated by some important clients then depending on weak linking to "work".
   (And further complicated by CFM not supporting "deferred" imports, which is how many
   programmers think weak imports work.)
   
   The end result is that the MP API library may get prepared by CFM but be totally unusable.
   This means that if you import from the MP API library, you cannot simply check for a
   resolved import to decide if MP services are available.  Worse, if you explicitly prepare
   the MP API library you cannot assume that a noErr result from GetSharedLibrary means that
   MP services are available.
   
   • If you import from the MP API library you MUST:
   
        Use the MPLibraryIsLoaded macro (or equivalent code in languages other than C) to tell
        if the MP API services are available.  It is not sufficient to simply check that an
        imported symbol is resolved as is commonly done for other libraries.  The macro expands
        to the expression:
   
            ( ( (UInt32)_MPIsFullyInitialized != (UInt32)kUnresolvedCFragSymbolAddress ) &&
              ( _MPIsFullyInitialized () ) )
   
        This checks if the imported symbol _MPIsFullyInitialized is resolved and if resolved
        calls it.  Both parts must succeed for the MP API services to be available.
   
   • If you explicitly prepare the MP API library you MUST:
   
        Use code similar to the following example to tell if the MP API services are available.
        It is not sufficient to depend on just a noErr result from GetSharedLibrary.
   
            OSErr                       err;
            Boolean                     mpIsAvailable           = false;
            CFragConnectionID           connID                  = kInvalidID;
            MPIsFullyInitializedProc    mpIsFullyInitialized    = NULL;
   
            err = GetSharedLibrary  ( "\pMPLibrary", kCompiledCFragArch, kReferenceCFrag,
                                      &connID, NULL, NULL );
   
            if ( err == noErr ) (
                err = FindSymbol    ( connID, "\p_MPIsFullyInitialized",
                                      (Ptr *) &mpIsFullyInitialized, NULL );
            )
   
            if ( err == noErr ) (
                mpIsAvailable = (* mpIsFullyInitialized) ();
            )
   
   ===========================================================================================
}


{
 *  _MPIsFullyInitialized()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION _MPIsFullyInitialized: BOOLEAN; C;


TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	MPIsFullyInitializedProc = FUNCTION: BOOLEAN; C;
{$ELSEC}
	MPIsFullyInitializedProc = ProcPtr;
{$ENDC}

	{
	   ===========================================================================================
	   The MPLibraryIsLoaded service is a macro under C that expands to the logical expression:
	        ( (UInt32)MPProcessors != (UInt32)kUnresolvedCFragSymbolAddress )
	   The intention is to check if the imported symbol MPProcessors is resolved.  For other
	   languages use the equivalent expression.
	   ===========================================================================================
	}
	{
	   §
	   ===========================================================================================
	   Miscellaneous Services
	   ======================
	}


{$IFC CALL_NOT_IN_CARBON }
	{
	 *  _MPLibraryVersion()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
PROCEDURE _MPLibraryVersion(VAR versionCString: ConstCStringPtr; VAR major: UInt32; VAR minor: UInt32; VAR release: UInt32; VAR revision: UInt32); C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{
   §
   ===========================================================================================
   Unofficial Services
   ===================
}


{
   ===========================================================================================
   *** WARNING ***
   These services are not part of the officially documented multiprocessing API.  They may not
   be avaliable in future versions of Mac OS multiprocessing support, or in environments that
   have a different underlying OS architecture such as Mac OS on top of a microkernel, the
   Mac OS Blue Box under Mac OS X, native MP support in Mac OS X, etc.
   ===========================================================================================
}

{$IFC CALL_NOT_IN_CARBON }
{$IFC CALL_NOT_IN_CARBON }
{
 *  _MPAllocateSys()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION _MPAllocateSys(size: ByteCount): LogicalAddress; C;

{  Use MPAllocateAligned instead. }
{
 *  _MPRPC()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION _MPRPC(remoteProc: MPRemoteProcedure; parameter: UNIV Ptr): Ptr; C;

{  Use _MPRemoteCall instead. }
{
 *  _MPTaskIsToolboxSafe()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION _MPTaskIsToolboxSafe(task: MPTaskID): BOOLEAN; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  _MPLibraryIsCompatible()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibrary 1.0 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION _MPLibraryIsCompatible(versionCString: ConstCStringPtr; major: UInt32; minor: UInt32; release: UInt32; revision: UInt32): BOOLEAN; C;



{
   §
   ===========================================================================================
   Defunct Services
   ================
}

{$IFC CALL_NOT_IN_CARBON }
{$IFC UNDEFINED MPIncludeDefunctServices }
{$SETC MPIncludeDefunctServices := 0 }
{$ENDC}
{$IFC MPIncludeDefunctServices }
{$IFC CALL_NOT_IN_CARBON }
{
 *  _MPDebugStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibraryObsolete 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE _MPDebugStr(msg: Str255); C;

{
 *  _MPStatusPString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibraryObsolete 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION _MPStatusPString(status: OSStatus): StringPtr; C;

{
 *  _MPStatusCString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPLibraryObsolete 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION _MPStatusCString(status: OSStatus): ConstCStringPtr; C;


{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {MPIncludeDefunctServices}
{$ENDC}  {CALL_NOT_IN_CARBON}

{  =========================================================================================== }


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MultiprocessingIncludes}

{$ENDC} {__MULTIPROCESSING__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

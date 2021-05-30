{
     File:       MultiprocessingInfo.p
 
     Contains:   Multiprocessing Information interfaces
 
     Version:    Technology: Multiprocessing Information API version 2.2
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1995-2001 DayStar Digital, Inc.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}

{
   ==========================================================================================================================
   *** WARNING: You must properly check the availability of MP services before calling them!
   See the section titled "Checking API Availability".
   ==========================================================================================================================
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MultiprocessingInfo;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MULTIPROCESSINGINFO__}
{$SETC __MULTIPROCESSINGINFO__ := 1}

{$I+}
{$SETC MultiprocessingInfoIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MULTIPROCESSING__}
{$I Multiprocessing.p}
{$ENDC}


{$PUSH}
{$ALIGN POWER}
{$LibExport+}

{
   ==========================================================================================================================
   This is the header file for version 2.3 of the Mac OS multiprocessing information support. 
   ==========================================================================================================================
}


{
   ==========================================================================================================================
   The following services are new in version 2.1:
    MPGetNextTaskID
    MPGetNextCpuID
   ==========================================================================================================================
}

{
   ==========================================================================================================================
   The following services are new in version 2.2:
    MPGetPageSizeClasses
    MPGetPageSize
    MPGetNextAreaID
   ==========================================================================================================================
}

{
   ==========================================================================================================================
   The following services are new in version 2.3:
    MPGetNextCoherenceID
    MPGetNextProcessID
    MPGetNextAddressSpaceID
    MPGetNextQueueID
    MPGetNextSemaphoreID
    MPGetNextCriticalRegionID
    MPGetNextTimerID
    MPGetNextEventID
    MPGetNextNotificationID
    MPGetNextConsoleID
   ==========================================================================================================================
}



{
   §
   ==========================================================================================================================
   Page size Services
   ==================
}

{$IFC CALL_NOT_IN_CARBON }
{
 *  MPGetPageSizeClasses()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetPageSizeClasses: MPPageSizeClass; C;

{  The number of page size classes, 1 to n. }
{$ENDC}  {CALL_NOT_IN_CARBON}

{  ------------------------------------------------------------------------------------------- }
{$IFC CALL_NOT_IN_CARBON }
{
 *  MPGetPageSize()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetPageSize(pageClass: MPPageSizeClass): ByteCount; C;

{  The page size in bytes. }
{$ENDC}  {CALL_NOT_IN_CARBON}


{
   §
   ==========================================================================================================================
   ID Iterator Services
   ==========================
}

{$IFC CALL_NOT_IN_CARBON }
{
 *  MPGetNextCoherenceID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetNextCoherenceID(VAR coherenceID: MPCoherenceID): OSStatus; C;

{
 *  MPGetNextCpuID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetNextCpuID(owningCoherenceID: MPCoherenceID; VAR cpuID: MPCpuID): OSStatus; C;

{
 *  MPGetNextProcessID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetNextProcessID(VAR processID: MPProcessID): OSStatus; C;

{
 *  MPGetNextAddressSpaceID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetNextAddressSpaceID(owningProcessID: MPProcessID; VAR addressSpaceID: MPAddressSpaceID): OSStatus; C;

{
 *  MPGetNextTaskID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetNextTaskID(owningProcessID: MPProcessID; VAR taskID: MPTaskID): OSStatus; C;

{
 *  MPGetNextQueueID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetNextQueueID(owningProcessID: MPProcessID; VAR queueID: MPQueueID): OSStatus; C;

{
 *  MPGetNextSemaphoreID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetNextSemaphoreID(owningProcessID: MPProcessID; VAR semaphoreID: MPSemaphoreID): OSStatus; C;

{
 *  MPGetNextCriticalRegionID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetNextCriticalRegionID(owningProcessID: MPProcessID; VAR criticalRegionID: MPCriticalRegionID): OSStatus; C;

{
 *  MPGetNextTimerID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetNextTimerID(owningProcessID: MPProcessID; VAR timerID: MPTimerID): OSStatus; C;

{
 *  MPGetNextEventID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetNextEventID(owningProcessID: MPProcessID; VAR eventID: MPEventID): OSStatus; C;

{
 *  MPGetNextNotificationID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetNextNotificationID(owningProcessID: MPProcessID; VAR notificationID: MPNotificationID): OSStatus; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  MPGetNextAreaID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetNextAreaID(owningSpaceID: MPAddressSpaceID; VAR areaID: MPAreaID): OSStatus;

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC CALL_NOT_IN_CARBON }
{
 *  MPGetNextConsoleID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetNextConsoleID(VAR consoleID: MPConsoleID): OSStatus; C;



{  ------------------------------------------------------------------------------------------- }


{
 *  MPGetNextID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetNextID(kind: MPOpaqueIDClass; VAR id: MPOpaqueID): OSStatus; C;



{
   §
   ==========================================================================================================================
   Object Information Services
   ===========================
}


{
   ----------------------------------------------------------------------------------------------
   ! The implementation of MPGetObjectInfo assumes that all info records are in 4 byte multiples.
}


{$ENDC}  {CALL_NOT_IN_CARBON}


CONST
																{  The version of the MPAreaInfo structure requested. }
	kMPQueueInfoVersion			= 262145;
	kMPSemaphoreInfoVersion		= 327681;
	kMPEventInfoVersion			= 589825;
	kMPCriticalRegionInfoVersion = 393217;
	kMPNotificationInfoVersion	= 786433;
	kMPAddressSpaceInfoVersion	= 524289;



TYPE
	MPQueueInfoPtr = ^MPQueueInfo;
	MPQueueInfo = RECORD
		version:				PBVersion;								{  Version of the data structure requested }
		processID:				MPProcessID;							{  Owning process ID }
		queueName:				OSType;									{  Queue name }
		nWaiting:				ItemCount;
		waitingTaskID:			MPTaskID;								{  First waiting task. }
		nMessages:				ItemCount;
		nReserved:				ItemCount;
		p1:						Ptr;									{  First message parameters... }
		p2:						Ptr;
		p3:						Ptr;
	END;

	MPSemaphoreInfoPtr = ^MPSemaphoreInfo;
	MPSemaphoreInfo = RECORD
		version:				PBVersion;								{  Version of the data structure requested }
		processID:				MPProcessID;							{  Owning process ID }
		semaphoreName:			OSType;									{  Semaphore name }
		nWaiting:				ItemCount;
		waitingTaskID:			MPTaskID;								{  First waiting task. }
		maximum:				ItemCount;
		count:					ItemCount;
	END;

	MPEventInfoPtr = ^MPEventInfo;
	MPEventInfo = RECORD
		version:				PBVersion;								{  Version of the data structure requested }
		processID:				MPProcessID;							{  Owning process ID }
		eventName:				OSType;									{  Event name }
		nWaiting:				ItemCount;
		waitingTaskID:			MPTaskID;								{  First waiting task. }
		events:					MPEventFlags;
	END;

	MPCriticalRegionInfoPtr = ^MPCriticalRegionInfo;
	MPCriticalRegionInfo = RECORD
		version:				PBVersion;								{  Version of the data structure requested }
		processID:				MPProcessID;							{  Owning process ID }
		regionName:				OSType;									{  Critical region name }
		nWaiting:				ItemCount;
		waitingTaskID:			MPTaskID;								{  First waiting task. }
		owningTask:				MPTaskID;
		count:					ItemCount;
	END;

	MPNotificationInfoPtr = ^MPNotificationInfo;
	MPNotificationInfo = RECORD
		version:				PBVersion;								{  Version of the data structure requested }
		processID:				MPProcessID;							{  Owning process ID }
		notificationName:		OSType;									{  Notification name }
		queueID:				MPQueueID;								{  Queue to notify. }
		p1:						Ptr;
		p2:						Ptr;
		p3:						Ptr;
		eventID:				MPEventID;								{  Event to set. }
		events:					MPEventFlags;
		semaphoreID:			MPSemaphoreID;							{  Sempahore to signal.    }
	END;

	MPAddressSpaceInfoPtr = ^MPAddressSpaceInfo;
	MPAddressSpaceInfo = RECORD
		version:				PBVersion;								{  Version of the data structure requested }
		processID:				MPProcessID;							{  Owning process ID }
		groupID:				MPCoherenceID;							{  Related coherence group. }
		nTasks:					ItemCount;								{  Number of tasks in this space. }
		vsid:					ARRAY [0..15] OF UInt32;				{  Segment register VSIDs. }
	END;

	{  *** We should put the task info call here instead of in MPExtractTaskState. }


{$IFC CALL_NOT_IN_CARBON }
	{
	 *  MPGetQueueInfo()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION MPGetQueueInfo(id: MPQueueID; version: PBVersion; VAR info_o: MPQueueInfo): OSStatus; C;

{
 *  MPGetSemaphoreInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetSemaphoreInfo(id: MPSemaphoreID; version: PBVersion; VAR info_o: MPSemaphoreInfo): OSStatus; C;

{
 *  MPGetEventInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetEventInfo(id: MPEventID; version: PBVersion; VAR info_o: MPEventInfo): OSStatus; C;

{
 *  MPGetCriticalRegionInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetCriticalRegionInfo(id: MPCriticalRegionID; version: PBVersion; VAR info_o: MPCriticalRegionInfo): OSStatus; C;

{
 *  MPGetNotificationInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetNotificationInfo(id: MPNotificationID; version: PBVersion; VAR info_o: MPNotificationInfo): OSStatus; C;

{
 *  MPGetAddressSpaceInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in MPDiagnostics 2.3 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION MPGetAddressSpaceInfo(id: MPAddressSpaceID; version: PBVersion; VAR info_o: MPAddressSpaceInfo): OSStatus; C;


{  ========================================================================================================================== }



{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MultiprocessingInfoIncludes}

{$ENDC} {__MULTIPROCESSINGINFO__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

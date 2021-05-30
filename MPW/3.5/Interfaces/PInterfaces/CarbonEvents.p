{
     File:       CarbonEvents.p
 
     Contains:   Carbon Event Manager
 
     Version:    Technology: Mac OS X/CarbonLib 1.3
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1999-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT CarbonEvents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __CARBONEVENTS__}
{$SETC __CARBONEVENTS__ := 1}

{$I+}
{$SETC CarbonEventsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{$IFC UNDEFINED __MENUS__}
{$I Menus.p}
{$ENDC}
{$IFC UNDEFINED __CONTROLS__}
{$I Controls.p}
{$ENDC}
{$IFC UNDEFINED __MACWINDOWS__}
{$I MacWindows.p}
{$ENDC}
{$IFC UNDEFINED __CFSTRING__}
{$I CFString.p}
{$ENDC}
{$IFC UNDEFINED __AEREGISTRY__}
{$I AERegistry.p}
{$ENDC}
{$IFC UNDEFINED __AEDATAMODEL__}
{$I AEDataModel.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{======================================================================================}
{  EVENT COMMON                                                                        }
{======================================================================================}



{
 *  Discussion:
 *    The following are all errors which can be returned from the
 *    routines contained in this file.
 }

CONST
	eventAlreadyPostedErr		= -9860;
	eventClassInvalidErr		= -9862;
	eventClassIncorrectErr		= -9864;
	eventHandlerAlreadyInstalledErr = -9866;
	eventInternalErr			= -9868;
	eventKindIncorrectErr		= -9869;
	eventParameterNotFoundErr	= -9870;
	eventNotHandledErr			= -9874;
	eventLoopTimedOutErr		= -9875;
	eventLoopQuitErr			= -9876;
	eventNotInQueueErr			= -9877;
	eventHotKeyExistsErr		= -9878;
	eventHotKeyInvalidErr		= -9879;

	{	======================================================================================	}
	{	  EVENT CORE                                                                          	}
	{	======================================================================================	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • Event Flags, options                                                              	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  EventPriority
	 *  
	 *  Discussion:
	 *    These values define the relative priority of an event, and are
	 *    used when posting events with PostEventToQueue. In general events
	 *    are pulled from the queue in order of first posted to last
	 *    posted. These priorities are a way to alter that when posting
	 *    events. You can post a standard priority event and then a high
	 *    priority event and the high priority event will be pulled from
	 *    the queue first.
	 	}

TYPE
	EventPriority 				= SInt16;
CONST
	kEventPriorityLow			= 0;
	kEventPriorityStandard		= 1;
	kEventPriorityHigh			= 2;

	kEventLeaveInQueue			= false;
	kEventRemoveFromQueue		= true;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 • Event Times                                                                        	}
	{	                                                                                      	}
	{	 EventTime is in seconds since boot. Use the constants to make life easy.             	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

TYPE
	EventTime							= Double;
	EventTimeout						= EventTime;
	EventTimerInterval					= EventTime;

CONST
	kEventDurationSecond		= 1.0;
	kEventDurationMillisecond	= kEventDurationSecond/1000;
	kEventDurationMicrosecond	= kEventDurationSecond/1000000;
	kEventDurationNanosecond	= kEventDurationSecond/1000000000;
	kEventDurationMinute		= kEventDurationSecond*60;
	kEventDurationHour			= kEventDurationMinute*60;
	kEventDurationDay			= kEventDurationHour*24;
	kEventDurationNoWait		= 0.0;
	kEventDurationForever		= -1.0;


	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 EventTypeSpec structure                                                              	}
	{	                                                                                      	}
	{	 This structure is used in many routines to pass a list of event types to a function. 	}
	{	 You typically would declare a const array of these types to pass in.                 	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  EventTypeSpec
	 *  
	 *  Discussion:
	 *    This structure is used to specify an event. Typically, a static
	 *    array of EventTypeSpecs are passed into functions such as
	 *    InstallEventHandler, as well as routines such as
	 *    FlushEventsMatchingListFromQueue.
	 	}

TYPE
	EventTypeSpecPtr = ^EventTypeSpec;
	EventTypeSpec = RECORD
		eventClass:				UInt32;
		eventKind:				UInt32;
	END;


	{
	 *  Discussion:
	 *    These are returned from calls to TrackMouseLocation and
	 *    TrackMouseRegion. Those routines are designed as replacements to
	 *    calls such as StillDown and WaitMouseUp. The advantage over those
	 *    routines is that TrackMouseLocation and TrackMouseRegion will
	 *    block if the user is not moving the mouse, whereas mouse tracking
	 *    loops based on StillDown and WaitMouseUp will spin, chewing up
	 *    valuable CPU time that could be better spent elsewhere. It is
	 *    highly recommended that any tracking loops in your application
	 *    stop using StillDown and WaitMouseUp and start using
	 *    TrackMouseLocation/Region. See the notes on those routines for
	 *    more information.
	 	}

CONST
	kTrackMouseLocationOptionDontConsumeMouseUp = $01;


TYPE
	MouseTrackingResult 		= UInt16;
CONST
	kMouseTrackingMousePressed	= 1;
	kMouseTrackingMouseReleased	= 2;
	kMouseTrackingMouseExited	= 3;
	kMouseTrackingMouseEntered	= 4;
	kMouseTrackingMouseMoved	= 5;
	kMouseTrackingKeyModifiersChanged = 6;
	kMouseTrackingUserCancelled	= 7;
	kMouseTrackingTimedOut		= 8;


TYPE
	EventParamName						= OSType;
	EventParamType						= OSType;
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • EventLoop                                                                         	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  EventLoopRef
	 *  
	 *  Discussion:
	 *    An EventLoopRef represents an 'event loop', which is the
	 *    conceptual entity that you 'run' to fetch events from hardware
	 *    and other sources and also fires timers that might be installed
	 *    with InstallEventLoopTimer. The term 'run' is a bit of a
	 *    misnomer, as the event loop's goal is to stay as blocked as
	 *    possible to minimize CPU usage for the current application. The
	 *    event loop is run implicitly thru APIs like ReceiveNextEvent,
	 *    RunApplicationEventLoop, or even WaitNextEvent. It can also be
	 *    run explicitly thru a call to RunCurrentEventLoop. Each
	 *    preemptive thread can have an event loop. Cooperative threads
	 *    share the main thread's event loop.
	 	}
	EventLoopRef    = ^LONGINT; { an opaque 32-bit type }
	EventLoopRefPtr = ^EventLoopRef;  { when a VAR xx:EventLoopRef parameter can be nil, it is changed to xx: EventLoopRefPtr }
	{
	 *  GetCurrentEventLoop()
	 *  
	 *  Discussion:
	 *    Returns the current event loop for the current thread. If the
	 *    current thread is a cooperative thread, the main event loop is
	 *    returned.
	 *  
	 *  Result:
	 *    An event loop reference.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION GetCurrentEventLoop: EventLoopRef;

{
 *  GetMainEventLoop()
 *  
 *  Discussion:
 *    Returns the event loop object for the main application thread.
 *  
 *  Result:
 *    An event loop reference.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMainEventLoop: EventLoopRef;


{
 *  RunCurrentEventLoop()
 *  
 *  Discussion:
 *    This routine 'runs' the event loop, returning only if aborted or
 *    the timeout specified is reached. The event loop is mostly
 *    blocked while in this function, occasionally waking up to fire
 *    timers or pick up events. The typical use of this function is to
 *    cause the current thread to wait for some operation to complete,
 *    most likely on another thread of execution.
 *  
 *  Parameters:
 *    
 *    inTimeout:
 *      The time to wait until returning (can be kEventDurationForever).
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RunCurrentEventLoop(inTimeout: EventTimeout): OSStatus;

{
 *  QuitEventLoop()
 *  
 *  Discussion:
 *    Causes a specific event loop to terminate. Usage of this is
 *    similar to WakeUpProcess, in that it causes the eventloop
 *    specified to return immediately (as opposed to timing out).
 *    Typically this call is used in conjunction with
 *    RunCurrentEventLoop.
 *  
 *  Parameters:
 *    
 *    inEventLoop:
 *      The event loop to terminate.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QuitEventLoop(inEventLoop: EventLoopRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Low-level event fetching                                                          }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  ReceiveNextEvent()
 *  
 *  Discussion:
 *    This routine tries to fetch the next event of a specified type.
 *    If no events in the event queue match, this routine will run the
 *    current event loop until an event that matches arrives, or the
 *    timeout expires. Except for timers firing, your application is
 *    blocked waiting for events to arrive when inside this function.
 *  
 *  Parameters:
 *    
 *    inNumTypes:
 *      The number of event types we are waiting for (0 if any event
 *      should cause this routine to return).
 *    
 *    inList:
 *      The list of event types we are waiting for (pass NULL if any
 *      event should cause this routine to return).
 *    
 *    inTimeout:
 *      The time to wait (passing kEventDurationForever is preferred).
 *    
 *    inPullEvent:
 *      Pass true for this parameter to actually remove the next
 *      matching event from the queue.
 *    
 *    outEvent:
 *      The next event that matches the list passed in. If inPullEvent
 *      is true, the event is owned by you, and you will need to
 *      release it when done.
 *  
 *  Result:
 *    A result indicating whether an event was received, the timeout
 *    expired, or the current event loop was quit.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ReceiveNextEvent(inNumTypes: UInt32; {CONST}VAR inList: EventTypeSpec; inTimeout: EventTimeout; inPullEvent: BOOLEAN; VAR outEvent: EventRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Core event lifetime APIs                                                          }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	EventAttributes 			= UInt32;
CONST
	kEventAttributeNone			= 0;
	kEventAttributeUserEvent	= $01;

	{
	 *  [Mac]CreateEvent()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION CreateEvent(inAllocator: CFAllocatorRef; inClassID: UInt32; kind: UInt32; when: EventTime; flags: EventAttributes; VAR outEvent: EventRef): OSStatus;

{
 *  CopyEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CopyEvent(inOther: EventRef): EventRef;

{
 *  RetainEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RetainEvent(inEvent: EventRef): EventRef;

{
 *  GetEventRetainCount()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetEventRetainCount(inEvent: EventRef): UInt32;

{
 *  ReleaseEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE ReleaseEvent(inEvent: EventRef);

{
 *  SetEventParameter()
 *  
 *  Discussion:
 *    Sets a piece of data for the given event.
 *  
 *  Parameters:
 *    
 *    inEvent:
 *      The event to set the data for.
 *    
 *    inName:
 *      The symbolic name of the parameter.
 *    
 *    inType:
 *      The symbolic type of the parameter.
 *    
 *    inSize:
 *      The size of the parameter data.
 *    
 *    inDataPtr:
 *      The pointer to the parameter data.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetEventParameter(inEvent: EventRef; inName: EventParamName; inType: EventParamType; inSize: UInt32; inDataPtr: UNIV Ptr): OSStatus;


{
 *  GetEventParameter()
 *  
 *  Discussion:
 *    Gets a piece of data from the given event, if it exists.
 *  
 *  Parameters:
 *    
 *    inEvent:
 *      The event to get the parameter from.
 *    
 *    inName:
 *      The symbolic name of the parameter.
 *    
 *    inDesiredType:
 *      The desired type of the parameter. At present we do not support
 *      coercion, so this parameter must be the actual type of data
 *      stored in the event, or an error will be returned.
 *    
 *    outActualType:
 *      The actual type of the parameter, can be NULL if you are not
 *      interested in receiving this information.
 *    
 *    inBufferSize:
 *      The size of the output buffer specified by ioBuffer.
 *    
 *    outActualSize:
 *      The actual size of the data, or NULL if you don't want this
 *      information.
 *    
 *    outData:
 *      The pointer to the buffer which will receive the parameter data.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetEventParameter(inEvent: EventRef; inName: EventParamName; inDesiredType: EventParamType; VAR outActualType: EventParamType; inBufferSize: UInt32; VAR outActualSize: UInt32; outData: UNIV Ptr): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{  • Getters for 'base-class' event info                                               }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  GetEventClass()
 *  
 *  Discussion:
 *    Returns the class of the given event, such as mouse, keyboard,
 *    etc.
 *  
 *  Parameters:
 *    
 *    inEvent:
 *      The event in question.
 *  
 *  Result:
 *    The class ID of the event.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetEventClass(inEvent: EventRef): UInt32;

{
 *  GetEventKind()
 *  
 *  Discussion:
 *    Returns the kind of the given event (mousedown, etc.). Event
 *    kinds overlap between event classes, e.g. kEventMouseDown and
 *    kEventAppActivated have the same value (1). The combination of
 *    class and kind is what determines an event signature.
 *  
 *  Parameters:
 *    
 *    inEvent:
 *      The event in question.
 *  
 *  Result:
 *    The kind of the event.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetEventKind(inEvent: EventRef): UInt32;

{
 *  GetEventTime()
 *  
 *  Discussion:
 *    Returns the time the event specified occurred, specified in
 *    EventTime, which is a floating point number representing seconds
 *    since the last system startup.
 *  
 *  Parameters:
 *    
 *    inEvent:
 *      The event in question.
 *  
 *  Result:
 *    The time the event occurred.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetEventTime(inEvent: EventRef): EventTime;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Setters for 'base-class' event info                                               }
{——————————————————————————————————————————————————————————————————————————————————————}

{
 *  SetEventTime()
 *  
 *  Discussion:
 *    This routine allows you to set the time of a given event, if you
 *    so desire. In general, you would never use this routine, except
 *    for those special cases where you reuse an event from time to
 *    time instead of creating a new event each time.
 *  
 *  Parameters:
 *    
 *    inEvent:
 *      The event in question.
 *    
 *    inTime:
 *      The new time.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetEventTime(inEvent: EventRef; inTime: EventTime): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Event Queue routines (posting, finding, flushing)                                 }
{——————————————————————————————————————————————————————————————————————————————————————}


TYPE
	EventQueueRef    = ^LONGINT; { an opaque 32-bit type }
	EventQueueRefPtr = ^EventQueueRef;  { when a VAR xx:EventQueueRef parameter can be nil, it is changed to xx: EventQueueRefPtr }
	{
	 *  GetCurrentEventQueue()
	 *  
	 *  Discussion:
	 *    Returns the current event queue for the current thread. If the
	 *    current thread is a cooperative thread, the main event queue is
	 *    returned.
	 *  
	 *  Result:
	 *    An event queue reference.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION GetCurrentEventQueue: EventQueueRef;

{
 *  GetMainEventQueue()
 *  
 *  Discussion:
 *    Returns the event queue object for the main application thread.
 *  
 *  Result:
 *    An event queue reference.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMainEventQueue: EventQueueRef;


{
 *  EventComparatorProcPtr
 *  
 *  Discussion:
 *    Type of a callback function used by queue searches.
 *  
 *  Parameters:
 *    
 *    inEvent:
 *      The event to compare.
 *    
 *    inCompareData:
 *      The data used to compare the event.
 *  
 *  Result:
 *    A boolean value indicating whether the event matches (true) or
 *    not (false).
 }

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	EventComparatorProcPtr = FUNCTION(inEvent: EventRef; inCompareData: UNIV Ptr): BOOLEAN;
{$ELSEC}
	EventComparatorProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	EventComparatorUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	EventComparatorUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppEventComparatorProcInfo = $000003D0;
	{
	 *  NewEventComparatorUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewEventComparatorUPP(userRoutine: EventComparatorProcPtr): EventComparatorUPP; { old name was NewEventComparatorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeEventComparatorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeEventComparatorUPP(userUPP: EventComparatorUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeEventComparatorUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeEventComparatorUPP(inEvent: EventRef; inCompareData: UNIV Ptr; userRoutine: EventComparatorUPP): BOOLEAN; { old name was CallEventComparatorProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  PostEventToQueue()
 *  
 *  Discussion:
 *    Posts an event to the queue specified. This automatically wakes
 *    up the event loop of the thread the queue belongs to. After
 *    posting the event, you should release the event. The event queue
 *    retains it.
 *  
 *  Parameters:
 *    
 *    inQueue:
 *      The event queue to post the event onto.
 *    
 *    inEvent:
 *      The event to post.
 *    
 *    inPriority:
 *      The priority of the event.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PostEventToQueue(inQueue: EventQueueRef; inEvent: EventRef; inPriority: EventPriority): OSStatus;

{
 *  FlushEventsMatchingListFromQueue()
 *  
 *  Discussion:
 *    Flushes events matching a specified list of classes and kinds
 *    from an event queue.
 *  
 *  Parameters:
 *    
 *    inQueue:
 *      The event queue to flush events from.
 *    
 *    inNumTypes:
 *      The number of event kinds to flush.
 *    
 *    inList:
 *      The list of event classes and kinds to flush from the queue.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FlushEventsMatchingListFromQueue(inQueue: EventQueueRef; inNumTypes: UInt32; {CONST}VAR inList: EventTypeSpec): OSStatus;

{
 *  FlushSpecificEventsFromQueue()
 *  
 *  Discussion:
 *    Flushes events that match a comparator function.
 *  
 *  Parameters:
 *    
 *    inQueue:
 *      The event queue to flush events from.
 *    
 *    inComparator:
 *      The comparison function to invoke for each event in the queue.
 *    
 *    inCompareData:
 *      The data you wish to pass to your comparison function.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FlushSpecificEventsFromQueue(inQueue: EventQueueRef; inComparator: EventComparatorUPP; inCompareData: UNIV Ptr): OSStatus;

{
 *  FlushEventQueue()
 *  
 *  Discussion:
 *    Flushes all events from an event queue.
 *  
 *  Parameters:
 *    
 *    inQueue:
 *      The event queue to flush.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FlushEventQueue(inQueue: EventQueueRef): OSStatus;

{
 *  FindSpecificEventInQueue()
 *  
 *  Discussion:
 *    Returns the first event that matches a comparator function, or
 *    NULL if no events match.
 *  
 *  Parameters:
 *    
 *    inQueue:
 *      The event queue to search.
 *    
 *    inComparator:
 *      The comparison function to invoke for each event in the queue.
 *    
 *    inCompareData:
 *      The data you wish to pass to your comparison function.
 *  
 *  Result:
 *    An event reference.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION FindSpecificEventInQueue(inQueue: EventQueueRef; inComparator: EventComparatorUPP; inCompareData: UNIV Ptr): EventRef;

{
 *  GetNumEventsInQueue()
 *  
 *  Discussion:
 *    Returns the number of events in an event queue.
 *  
 *  Parameters:
 *    
 *    inQueue:
 *      The event queue to query.
 *  
 *  Result:
 *    The number of items in the queue.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetNumEventsInQueue(inQueue: EventQueueRef): UInt32;

{
 *  RemoveEventFromQueue()
 *  
 *  Discussion:
 *    Removes the given event from the queue which it was posted. When
 *    you call this function, the event ownership is transferred to
 *    you, the caller, at no charge. You must release the event when
 *    you are through with it.
 *  
 *  Parameters:
 *    
 *    inQueue:
 *      The queue to remove the event from.
 *    
 *    inEvent:
 *      The event to remove.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveEventFromQueue(inQueue: EventQueueRef; inEvent: EventRef): OSStatus;

{
 *  IsEventInQueue()
 *  
 *  Discussion:
 *    Returns true if the specified event is posted to a queue.
 *  
 *  Parameters:
 *    
 *    inQueue:
 *      The queue to check.
 *    
 *    inEvent:
 *      The event in question.
 *  
 *  Result:
 *    A boolean value.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsEventInQueue(inQueue: EventQueueRef; inEvent: EventRef): BOOLEAN;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Helpful utilities                                                                 }
{——————————————————————————————————————————————————————————————————————————————————————}

{
 *  GetCurrentEventTime()
 *  
 *  Discussion:
 *    Returns the current time since last system startup in seconds.
 *  
 *  Result:
 *    EventTime.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetCurrentEventTime: EventTime;

{
 *  IsUserCancelEventRef()
 *  
 *  Discussion:
 *    Tests the event given to see whether the event represents a 'user
 *    cancel' event. Currently this is defined to be either the escape
 *    key being pressed, or command-period being pressed.
 *  
 *  Result:
 *    A boolean value indicating whether the event is a user cancel
 *    event.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsUserCancelEventRef(event: EventRef): BOOLEAN;

{
 *  TrackMouseLocation()
 *  
 *  Discussion:
 *    Once entered, this routine waits for certain mouse events (move,
 *    mouse down, mouse up). When one of these events occurs, the
 *    function returns and tells the caller what happened and where the
 *    mouse is currently located. While there is no activity, the
 *    current event loop is run, effectively blocking the current
 *    thread (save for any timers that fire). This helps to minimize
 *    CPU usage when there is nothing going on.
 *  
 *  Parameters:
 *    
 *    inPort:
 *      The grafport to consider for mouse coordinates. You can pass
 *      NULL for this parameter to indicate the current port. The mouse
 *      location is returned in terms of local coordinates of this port.
 *    
 *    outPt:
 *      On exit, this parameter receives the mouse location from the
 *      last mouse event that caused this function to exit.
 *    
 *    outResult:
 *      On exit, this parameter receives a value representing what kind
 *      of event was received that cause the function to exit, such as
 *      kMouseTrackingMouseReleased.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TrackMouseLocation(inPort: GrafPtr; VAR outPt: Point; VAR outResult: MouseTrackingResult): OSStatus;

{
 *  TrackMouseLocationWithOptions()
 *  
 *  Discussion:
 *    Once entered, this routine waits for certain mouse events (move,
 *    mouse down, mouse up). When one of these events occurs, the
 *    function returns and tells the caller what happened and where the
 *    mouse is currently located. While there is no activity, the
 *    current event loop is run, effectively blocking the current
 *    thread (save for any timers that fire). This helps to minimize
 *    CPU usage when there is nothing going on.
 *  
 *  Parameters:
 *    
 *    inPort:
 *      The grafport to consider for mouse coordinates. You can pass
 *      NULL for this parameter to indicate the current port. The mouse
 *      location is returned in terms of local coordinates of this port.
 *    
 *    inOptions:
 *      The only option supported by this routine at present is the
 *      option to have the toolbox leave mouse up events in the queue,
 *      rather than pulling them (which is the default).
 *    
 *    inTimeout:
 *      The amount of time to wait for an event. If no events arrive
 *      within this time, kMouseTrackingTimedOut is returned in
 *      outResult.
 *    
 *    outPt:
 *      On exit, this parameter receives the mouse location from the
 *      last mouse event that caused this function to exit. If a
 *      timeout or key modifiers changed event caused this function to
 *      exit, the current mouse position at the time is returned.
 *    
 *    outModifiers:
 *      On exit, this parameter receives the most recent state of the
 *      keyboard modifiers.
 *    
 *    outResult:
 *      On exit, this parameter receives a value representing what kind
 *      of event was received that cause the function to exit, such as
 *      kMouseTrackingMouseReleased.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TrackMouseLocationWithOptions(inPort: GrafPtr; inOptions: OptionBits; inTimeout: EventTimeout; VAR outPt: Point; VAR outModifiers: UInt32; VAR outResult: MouseTrackingResult): OSStatus; C;

{
 *  TrackMouseRegion()
 *  
 *  Discussion:
 *    This routine is largely identical to TrackMouseLocation. Please
 *    read the notes on that function as well. The difference between
 *    TrackMouseLocation and TrackMouseRegion is that TrackMouseRegion
 *    only returns when the mouse enters or exits a specified region
 *    that you pass in to the function, as opposed to whenever the
 *    mouse moves (it also returns for mouse up/down events). This is
 *    useful if you don't need to know intermediate mouse events, but
 *    rather just if the mouse enters or leaves an area.
 *  
 *  Parameters:
 *    
 *    inPort:
 *      The grafport to consider for mouse coordinates. You can pass
 *      NULL for this parameter to indicate the current port.
 *    
 *    inRegion:
 *      The region to consider. This should be in the coordinates of
 *      the port you passed to inPort.
 *    
 *    ioWasInRgn:
 *      On enter, this parameter should be set to true if the mouse is
 *      currently inside the region passed in inRegion, or false if the
 *      mouse is currently outside the region. On exit, this parameter
 *      is updated to reflect the current reality, e.g. if the
 *      outResult parameter returns kMouseTrackingMouseExited,
 *      ioWasInRgn will be set to false when this function exits.
 *      Because it is updated from within, you should only need to set
 *      this yourself before the first call to this function in your
 *      tracking loop.
 *    
 *    outResult:
 *      On exit, this parameter receives a value representing what kind
 *      of event was received that cause the function to exit, such as
 *      kMouseTrackingMouseEntered.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION TrackMouseRegion(inPort: GrafPtr; inRegion: RgnHandle; VAR ioWasInRgn: BOOLEAN; VAR outResult: MouseTrackingResult): OSStatus;

{
 *  ConvertEventRefToEventRecord()
 *  
 *  Discussion:
 *    This is a convenience routine to help you if there are places in
 *    your application where you need an EventRecord and all you have
 *    is an EventRef. If the event can be converted, outEvent is filled
 *    in and the function returns true. If not, false is returned and
 *    outEvent will contain a nullEvent.
 *  
 *  Parameters:
 *    
 *    inEvent:
 *      The EventRef to convert into an EventRecord.
 *    
 *    outEvent:
 *      The EventRecord to fill out.
 *  
 *  Result:
 *    A boolean indicating if the conversion was successful (true) or
 *    not (false).
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ConvertEventRefToEventRecord(inEvent: EventRef; VAR outEvent: EventRecord): BOOLEAN;

{
 *  IsEventInMask()
 *  
 *  Discussion:
 *    This is a companion function for ConvertEventRefToEventRecord,
 *    and is provided as a convenience routine to help you if there are
 *    places in your application where you want to check an EventRef to
 *    see if it matches a classic EventMask bitfield. If the event
 *    matches, the function returns true.
 *  
 *  Parameters:
 *    
 *    inEvent:
 *      The EventRef to convert into an EventRecord.
 *    
 *    inMask:
 *      The mask to consider.
 *  
 *  Result:
 *    A boolean indicating if the event was considered to be in the
 *    mask provided.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION IsEventInMask(inEvent: EventRef; inMask: EventMask): BOOLEAN;

{
 *  GetLastUserEventTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetLastUserEventTime: EventTime;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Timers                                                                            }
{——————————————————————————————————————————————————————————————————————————————————————}

{
 *  EventLoopTimerRef
 *  
 *  Discussion:
 *    An EventLoopTimerRef represents what we term a 'timer'. A timer
 *    is a function that is called either once or at regular intervals.
 *    It executes at task level and should not be confused with Time
 *    Manager Tasks or any other interrupt-level callback. This means
 *    you can call Toolbox routines, allocate memory and draw. When a
 *    timer 'fires', it calls a callback that you specify when the
 *    timer is installed. Timers in general have two uses - as a
 *    timeout mechanism and as a periodic task. An everyday example of
 *    using a timer for a timeout might be a light that goes out if no
 *    motion is detected in a room for 5 minutes. For this, you might
 *    install a timer which will fire in 5 minutes. If motion is
 *    detected, you would reset the timer fire time and let the clock
 *    start over. If no motion is detected for the full 5 minutes, the
 *    timer will fire and you could power off the light. A periodic
 *    timer is one that fires at regular intervals (say every second or
 *    so). You might use such a timer to blink the insertion point in
 *    your editor, etc. One advantage of timers is that you can install
 *    the timer right from the code that wants the time. For example,
 *    the standard Toolbox Edit Text control can install a timer to
 *    blink the cursor when it's active, meaning that IdleControls is a
 *    no-op for that control and doesn't need to be called. When the
 *    control is inactive, it removes its timer and doesn't waste CPU
 *    time in that state. NOTE: Currently, if you do decide to draw
 *    when your timer is called, be sure to save and restore the
 *    current port so that calling your timer doesn't inadvertently
 *    change the port out from under someone.
 }

TYPE
	EventLoopTimerRef    = ^LONGINT; { an opaque 32-bit type }
	EventLoopTimerRefPtr = ^EventLoopTimerRef;  { when a VAR xx:EventLoopTimerRef parameter can be nil, it is changed to xx: EventLoopTimerRefPtr }

	{
	 *  EventLoopTimerProcPtr
	 *  
	 *  Discussion:
	 *    Called when a timer fires.
	 *  
	 *  Parameters:
	 *    
	 *    inTimer:
	 *      The timer that fired.
	 *    
	 *    inUserData:
	 *      The data passed into InstallEventLoopTimer.
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	EventLoopTimerProcPtr = PROCEDURE(inTimer: EventLoopTimerRef; inUserData: UNIV Ptr);
{$ELSEC}
	EventLoopTimerProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	EventLoopTimerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	EventLoopTimerUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppEventLoopTimerProcInfo = $000003C0;
	{
	 *  NewEventLoopTimerUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewEventLoopTimerUPP(userRoutine: EventLoopTimerProcPtr): EventLoopTimerUPP; { old name was NewEventLoopTimerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeEventLoopTimerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeEventLoopTimerUPP(userUPP: EventLoopTimerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeEventLoopTimerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeEventLoopTimerUPP(inTimer: EventLoopTimerRef; inUserData: UNIV Ptr; userRoutine: EventLoopTimerUPP); { old name was CallEventLoopTimerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InstallEventLoopTimer()
 *  
 *  Discussion:
 *    Installs a timer onto the event loop specified. The timer can
 *    either fire once or repeatedly at a specified interval depending
 *    on the parameters passed to this function.
 *  
 *  Parameters:
 *    
 *    inEventLoop:
 *      The event loop to add the timer.
 *    
 *    inFireDelay:
 *      The delay before first firing this timer (can be 0).
 *    
 *    inInterval:
 *      The timer interval (pass 0 for one-shot timers).
 *    
 *    inTimerProc:
 *      The routine to call when the timer fires.
 *    
 *    inTimerData:
 *      Data to pass to the timer proc when called.
 *    
 *    outTimer:
 *      A reference to the newly installed timer.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InstallEventLoopTimer(inEventLoop: EventLoopRef; inFireDelay: EventTimerInterval; inInterval: EventTimerInterval; inTimerProc: EventLoopTimerUPP; inTimerData: UNIV Ptr; VAR outTimer: EventLoopTimerRef): OSStatus;


{
 *  RemoveEventLoopTimer()
 *  
 *  Discussion:
 *    Removes a timer that was previously installed by a call to
 *    InstallEventLoopTimer. You call this function when you are done
 *    using a timer.
 *  
 *  Parameters:
 *    
 *    inTimer:
 *      The timer to remove.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveEventLoopTimer(inTimer: EventLoopTimerRef): OSStatus;

{
 *  SetEventLoopTimerNextFireTime()
 *  
 *  Discussion:
 *    This routine is used to 'reset' a timer. It controls the next
 *    time the timer fires. This will override any interval you might
 *    have set. For example, if you have a timer that fires every
 *    second, and you call this function setting the next time to 5
 *    seconds from now, the timer will sleep for 5 seconds, then fire.
 *    It will then resume it's one second interval after that. It is as
 *    if you removed the timer and reinstalled it with a new first-fire
 *    delay.
 *  
 *  Parameters:
 *    
 *    inTimer:
 *      The timer to adjust
 *    
 *    inNextFire:
 *      The interval from the current time to wait until firing the
 *      timer again.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetEventLoopTimerNextFireTime(inTimer: EventLoopTimerRef; inNextFire: EventTimerInterval): OSStatus;

{======================================================================================}
{  EVENT CLASSES                                                                       }
{======================================================================================}

{
 *  Discussion:
 *    Event classes
 }

CONST
	kEventClassMouse			= 'mous';
	kEventClassKeyboard			= 'keyb';
	kEventClassTextInput		= 'text';
	kEventClassApplication		= 'appl';
	kEventClassAppleEvent		= 'eppc';
	kEventClassMenu				= 'menu';
	kEventClassWindow			= 'wind';
	kEventClassControl			= 'cntl';
	kEventClassCommand			= 'cmds';
	kEventClassTablet			= 'tblt';
	kEventClassVolume			= 'vol ';

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 Mouse Events                                                                         	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 Mouse Events 	}

	{
	 *  Discussion:
	 *    Mouse events (kEventClassMouse)
	 	}
	kEventMouseDown				= 1;
	kEventMouseUp				= 2;
	kEventMouseMoved			= 5;
	kEventMouseDragged			= 6;
	kEventMouseWheelMoved		= 10;

	{	
	    Parameters for mouse events:
	
	    kEventMouseDown
	        -->     kEventParamMouseLocation    typeQDPoint
	        -->     kEventParamKeyModifiers     typeUInt32
	        -->     kEventParamMouseButton      typeMouseButton
	        -->     kEventParamClickCount       typeUInt32
	        -->     kEventParamMouseChord       typeUInt32  (X Only)
	
	    kEventMouseUp
	        -->     kEventParamMouseLocation    typeQDPoint
	        -->     kEventParamKeyModifiers     typeUInt32
	        -->     kEventParamMouseButton      typeMouseButton
	        -->     kEventParamClickCount       typeUInt32
	        -->     kEventParamMouseChord       typeUInt32  (X Only)
	
	    kEventMouseMoved
	        -->     kEventParamMouseLocation    typeQDPoint
	        -->     kEventParamKeyModifiers     typeUInt32
	
	    kEventMouseDragged
	        -->     kEventParamMouseLocation    typeQDPoint
	        -->     kEventParamKeyModifiers     typeUInt32
	        -->     kEventParamMouseButton      typeMouseButton
	        -->     kEventParamMouseChord       typeUInt32  (X Only)
	
	    kEventMouseWheelMoved
	        -->     kEventParamMouseLocation    typeQDPoint
	        -->     kEventParamKeyModifiers     typeUInt32
	        -->     kEventParamMouseWheelAxis   typeMouseWheelAxis
	        -->     kEventParamMouseWheelDelta  typeLongInteger
		}

	{
	 *  EventMouseButton
	 *  
	 	}

TYPE
	EventMouseButton 			= UInt16;
CONST
	kEventMouseButtonPrimary	= 1;
	kEventMouseButtonSecondary	= 2;
	kEventMouseButtonTertiary	= 3;



	{
	 *  EventMouseWheelAxis
	 *  
	 	}

TYPE
	EventMouseWheelAxis 		= UInt16;
CONST
	kEventMouseWheelAxisX		= 0;
	kEventMouseWheelAxisY		= 1;




	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 Text Input Events                                                                    	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  Summary:
	 *    Text input events (kEventClassTextInput)
	 *  
	 *  Discussion:
	 *    The following TextInput events reimplement the AppleEvents
	 *    defined in Inside Mac Text - Text Services Manager, and provide
	 *    the benefits of Carbon Event targeting, dispatching and
	 *    propagation to applications that have formerly handled the TSM
	 *    suite of AppleEvents. TextInput handlers may be installed on
	 *    controls, windows, or the application event target (equivalent to
	 *    AppleEvent-based handling). In all cases, if a given TextInput
	 *    handler is not installed, TSM will convert that TextInput to an
	 *    AppleEvent and redispatch via AESend to the current process,
	 *    making adoption as gradual as is desired.
	 	}
	kEventTextInputUpdateActiveInputArea = 1;
	kEventTextInputUnicodeForKeyEvent = 2;
	kEventTextInputOffsetToPos	= 3;
	kEventTextInputPosToOffset	= 4;
	kEventTextInputShowHideBottomWindow = 5;
	kEventTextInputGetSelectedText = 6;

	{	
	    Parameters for TextInput events:
	    
	    kEventTextInputUpdateActiveInputArea
	        Required parameters:
	        -->     kEventParamTextInputSendComponentInstance           typeComponentInstance
	        -->     kEventParamTextInputSendRefCon                      typeLongInteger
	        -->     kEventParamTextInputSendSLRec                       typeIntlWritingCode
	        -->     kEventParamTextInputSendFixLen                      typeLongInteger
	        -->     kEventParamTextInputSendText                        typeUnicodeText, typeChar
	                    (data type depends on TSMDocument type created via NewTSMDocument...
	                     typeChar for kTextService document, typeUnicodeText for kUnicodeDocument)
	        
	        Optional parameters:
	        -->     kEventParamTextInputSendUpdateRng                   typeTextRangeArray
	        -->     kEventParamTextInputSendHiliteRng                   typeTextRangeArray
	        -->     kEventParamTextInputSendClauseRng                   typeOffsetArray
	        -->     kEventParamTextInputSendPinRng                      typeTextRange
	        -->     kEventParamTextInputSendPinRng                      typeTextRange
	        -->     kEventParamTextInputSendTextServiceEncoding         typeUInt32
	        -->     kEventParamTextInputSendTextServiceMacEncoding      typeUInt32
	        
	    kEventTextInputUnicodeForKeyEvent
	        Required parameters:
	        -->     kEventParamTextInputSendComponentInstance           typeComponentInstance
	        -->     kEventParamTextInputSendRefCon                      typeLongInteger
	        -->     kEventParamTextInputSendSLRec                       typeIntlWritingCode
	        -->     kEventParamTextInputSendText                        typeUnicodeText
	        -->     kEventParamTextInputSendKeyboardEvent               typeEventRef
	                    (This parameter is the original raw keyboard event that produced the
	                     text.  It enables access to kEventParamKeyModifiers and 
	                     kEventParamKeyCode parameters.
	                     You can also extract from this event either Unicodes or Mac encoding
	                     characters as follows:
	                            kEventParamKeyUnicodes              typeUnicodeText
	                            kEventParamKeyMacCharCodes          typeChar (if available)
	                     The kEventParamKeyUnicodes parameter of the raw keyboard event is
	                     identical to the TextInput event's kEventParamTextInputSendText
	                     parameter.  Note that when contents of TSM's bottom-line input
	                     window (i.e. during typing Chinese, Korean, or Japanese) are confirmed,
	                     the raw keyboard event's keyCode and modifiers are set to default values.)
	
	    kEventTextInputOffsetToPos
	        Required parameters:
	        -->     kEventParamTextInputSendComponentInstance           typeComponentInstance
	        -->     kEventParamTextInputSendRefCon                      typeLongInteger
	        -->     kEventParamTextInputSendTextOffset                  typeLongInteger
	        <--     kEventParamTextInputReplyPoint                      typeQDPoint
	        
	        Optional parameters:
	        -->     kEventParamTextInputSendSLRec                       typeIntlWritingCode
	        -->     kEventParamTextInputSendLeadingEdge                 typeBoolean
	        <--     kEventParamTextInputReplySLRec                      typeIntlWritingCode
	        <--     kEventParamTextInputReplyFont                       typeLongInteger
	        <--     kEventParamTextInputReplyPointSize                  typeFixed
	        <--     kEventParamTextInputReplyLineHeight                 typeShortInteger
	        <--     kEventParamTextInputReplyLineAscent                 typeShortInteger
	        <--     kEventParamTextInputReplyTextAngle                  typeFixed
	
	    kEventTextInputPosToOffset
	        Required parameters:
	        -->     kEventParamTextInputSendComponentInstance           typeComponentInstance
	        -->     kEventParamTextInputSendRefCon                      typeLongInteger
	        -->     kEventParamTextInputSendCurrentPoint                typeQDPoint
	        <--     kEventParamTextInputReplyRegionClass                typeLongInteger
	        <--     kEventParamTextInputReplyTextOffset                 typeLongInteger
	                    (required if the position is inside the document's body)
	        
	        Optional parameters:
	        -->     kEventParamTextInputSendDraggingMode                typeBoolean
	        <--     kEventParamTextInputReplyLeadingEdge                typeBoolean
	        <--     kEventParamTextInputReplySLRec                      typeIntlWritingCode
	        
	    kEventTextInputShowHideBottomWindow
	        Required parameters:
	        -->     kEventParamTextInputSendComponentInstance           typeComponentInstance
	        -->     kEventParamTextInputSendRefCon                      typeLongInteger
	        
	        Optional parameters:
	        -->     kEventParamTextInputSendShowHide                    typeBoolean
	        <--     kEventParamTextInputReplyShowHide                   typeBoolean
	
	    kEventTextInputGetSelectedText
	        Required parameters:
	        -->     kEventParamTextInputSendComponentInstance           typeComponentInstance
	        -->     kEventParamTextInputSendRefCon                      typeLongInteger
	        
	        Optional parameters:
	        -->     kEventParamTextInputSendLeadingEdge                 typeBoolean
	        -->     kEventParamTextInputSendTextServiceEncoding         typeUInt32
	        -->     kEventParamTextInputSendTextServiceMacEncoding      typeUInt32
	        <--     kEventParamTextInputReplyText                       typeUnicodeText, typeChar
	                    (data type depends on TSMDocument.  See kEventTextInputUpdateActiveInputArea Notes)
	        <--     kEventParamTextInputReplySLRec                      typeIntlWritingCode
		}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 Raw Keyboard Events                                                                  	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  Summary:
	 *    Keyboard events (kEventClassKeyboard)
	 *  
	 *  Discussion:
	 *    These events are the lowest-level keyboard events.
	 	}
	kEventRawKeyDown			= 1;							{  hardware-level events }
	kEventRawKeyRepeat			= 2;
	kEventRawKeyUp				= 3;
	kEventRawKeyModifiersChanged = 4;
	kEventHotKeyPressed			= 5;
	kEventHotKeyReleased		= 6;							{  X Only }



	{
	 *  Summary:
	 *    Key modifier change event bits and masks
	 *  
	 *  Discussion:
	 *    From bit 8, cmdKeyBit, to bit 15, rightControlKeyBit, are
	 *    compatible with Event Manager modifiers.
	 	}
	kEventKeyModifierNumLockBit	= 16;							{  Num Lock is on? (Mac OS X only) }
	kEventKeyModifierFnBit		= 17;							{  Fn key is down? (Mac OS X only) }

	kEventKeyModifierNumLockMask = $00010000;
	kEventKeyModifierFnMask		= $00020000;

	{	
	    Parameters for keyboard events:
	
	    kEventRawKeyDown
	        -->     kEventParamKeyMacCharCodes  typeChar
	        -->     kEventParamKeyCode          typeUInt32
	        -->     kEventParamKeyModifiers     typeUInt32
	
	    kEventRawKeyRepeat
	        -->     kEventParamKeyMacCharCodes  typeChar
	        -->     kEventParamKeyCode          typeUInt32
	        -->     kEventParamKeyModifiers     typeUInt32
	
	    kEventRawKeyUp
	        -->     kEventParamKeyMacCharCodes  typeChar
	        -->     kEventParamKeyCode          typeUInt32
	        -->     kEventParamKeyModifiers     typeUInt32
	
	    kEventRawKeyModifiersChanged
	        -->     kEventParamKeyModifiers     typeUInt32
	
	    kEventHotKeyPressed
	        -->     kEventParamDirectObject     typeEventHotKeyID
	
	    kEventHotKeyReleased
	        -->     kEventParamDirectObject     typeEventHotKeyID
		}

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 Application Events                                                                   	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  Summary:
	 *    Application events (kEventClassApplication)
	 	}
	kEventAppActivated			= 1;							{  resume, in old parlance }
	kEventAppDeactivated		= 2;							{  suspend, in old parlance }
	kEventAppQuit				= 3;							{  this app is quitting }
	kEventAppLaunchNotification	= 4;							{  response to async application launch }
	kEventAppLaunched			= 5;							{  (CarbonLib 1.3 or later) some other app was launched }
	kEventAppTerminated			= 6;							{  (CarbonLib 1.3 or later) some other app was terminated }
	kEventAppFrontSwitched		= 7;							{  (CarbonLib 1.3 or later) the frontmost app has changed }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  Apple Events                                                                        	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  Summary:
	 *    Apple events (kEventClassAppleEvent)
	 	}
	kEventAppleEvent			= 1;


	{	
	    Parameters for Apple events:
	
	    kEventAppleEvent
	        -->     kEventParamAEEventClass     typeType        // the eventClass of the Apple event
	        -->     kEventParamAEEventID        typeType        // the eventID of the Apple event
		}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  Window Events                                                                       	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  Summary:
	 *    Window refresh events (kEventClassWindow)
	 *  
	 *  Discussion:
	 *    Events related to drawing a window's content.
	 	}
	kEventWindowUpdate			= 1;
	kEventWindowDrawContent		= 2;

	{	
	    Parameters for window refresh events:
	
	    kEventWindowUpdate
	        -->     kEventParamDirectObject     typeWindowRef
	
	    kEventWindowDrawContent
	        -->     kEventParamDirectObject     typeWindowRef
		}

	{
	 *  Summary:
	 *    Window activation events (kEventClassWindow)
	 *  
	 *  Discussion:
	 *    Events related to activating and deactivating a window.
	 	}
	kEventWindowActivated		= 5;
	kEventWindowDeactivated		= 6;
	kEventWindowGetClickActivation = 7;

	{	
	    Parameters for window activation events:
	
	    kEventWindowActivated
	        -->     kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowDeactivated
	        -->     kEventParamDirectObject     typeWindowRef
	
	    kEventWindowGetClickActivation
	        -->     kEventParamDirectObject     typeWindowRef
	        -->     kEventParamMouseLocation    typeQDPoint
	        -->     kEventParamKeyModifiers     typeUInt32
	        -->     kEventParamWindowDefPart    typeWindowDefPartCode
	        -->     kEventParamControlRef       typeControlRef (only present if the click was on a control)
	        <--     kEventParamClickActivation  typeClickActivationResult
		}

	{
	 *  Summary:
	 *    Window state change events (kEventClassWindow)
	 *  
	 *  Discussion:
	 *    Events that notify of a change in the window's state. These
	 *    events are sent to all windows, regardless of whether the window
	 *    has the standard handler installed.
	 	}
	kEventWindowShowing			= 22;
	kEventWindowHiding			= 23;
	kEventWindowShown			= 24;
	kEventWindowHidden			= 25;
	kEventWindowBoundsChanging	= 26;
	kEventWindowBoundsChanged	= 27;
	kEventWindowResizeStarted	= 28;
	kEventWindowResizeCompleted	= 29;
	kEventWindowDragStarted		= 30;
	kEventWindowDragCompleted	= 31;


	{
	 *  Summary:
	 *    Window bounds change event attributes
	 *  
	 *  Discussion:
	 *    When the toolbox sends out a kEventWindowBoundsChanging or
	 *    kEventWindowBoundsChanged event, it also sends along a parameter
	 *    containing attributes of the event. These attributes can be used
	 *    to determine what aspect of the window changed (origin, size, or
	 *    both), and whether or not some user action is driving the change
	 *    (drag or resize).
	 	}
	kWindowBoundsChangeUserDrag	= $01;
	kWindowBoundsChangeUserResize = $02;
	kWindowBoundsChangeSizeChanged = $04;
	kWindowBoundsChangeOriginChanged = $08;


	{	
	    Parameters for window state change events:
	    
	    kEventWindowBoundsChanging
	        -->     kEventParamDirectObject     typeWindowRef
	        -->     kEventParamAttributes       typeUInt32
	        -->     kEventParamOriginalBounds   typeQDRectangle
	        -->     kEventParamPreviousBounds   typeQDRectangle
	        <->     kEventParamCurrentBounds    typeQDRectangle
	        
	    kEventWindowBoundsChanged
	        -->     kEventParamDirectObject     typeWindowRef
	        -->     kEventParamAttributes       typeUInt32
	        -->     kEventParamOriginalBounds   typeQDRectangle
	        -->     kEventParamPreviousBounds   typeQDRectangle
	        -->     kEventParamCurrentBounds    typeQDRectangle
	    
	    kEventWindowShown
	        -->     kEventParamDirectObject     typeWindowRef
	
	    kEventWindowHidden
	        -->     kEventParamDirectObject     typeWindowRef
		}

	{
	 *  Summary:
	 *    Window click events (kEventClassWindow)
	 *  
	 *  Discussion:
	 *    Low-level events which generate higher-level “action” events.
	 *    These events are only generated for windows with the standard
	 *    window handler installed. Most clients should allow the standard
	 *    handler to implement these events.
	 	}
	kEventWindowClickDragRgn	= 32;
	kEventWindowClickResizeRgn	= 33;
	kEventWindowClickCollapseRgn = 34;
	kEventWindowClickCloseRgn	= 35;
	kEventWindowClickZoomRgn	= 36;
	kEventWindowClickContentRgn	= 37;
	kEventWindowClickProxyIconRgn = 38;


	{
	 *  Summary:
	 *    Window cursor change events (kEventClassWindow)
	 	}
	kEventWindowCursorChange	= 40;

	{	
	    Parameters for window cursor change events:
	    
	    kEventWindowCursorChange
	        -->     kEventParamDirectObject     typeWindowRef
	        -->     kEventParamMouseLocation    typeQDPoint
	        -->     kEventParamKeyModifiers     typeUInt32
		}

	{
	 *  Summary:
	 *    Window action events
	 *  
	 *  Discussion:
	 *    Events which indicate that certain changes have been made to the
	 *    window. These events have greater semantic meaning than the
	 *    low-level window click events and are usually prefered for
	 *    overriding.
	 	}
	kEventWindowCollapse		= 66;
	kEventWindowCollapsed		= 67;
	kEventWindowCollapseAll		= 68;
	kEventWindowExpand			= 69;
	kEventWindowExpanded		= 70;
	kEventWindowExpandAll		= 71;
	kEventWindowClose			= 72;
	kEventWindowClosed			= 73;
	kEventWindowCloseAll		= 74;
	kEventWindowZoom			= 75;
	kEventWindowZoomed			= 76;
	kEventWindowZoomAll			= 77;
	kEventWindowContextualMenuSelect = 78;
	kEventWindowPathSelect		= 79;
	kEventWindowGetIdealSize	= 80;
	kEventWindowGetMinimumSize	= 81;
	kEventWindowGetMaximumSize	= 82;
	kEventWindowConstrain		= 83;
	kEventWindowHandleContentClick = 85;
	kEventWindowProxyBeginDrag	= 128;
	kEventWindowProxyEndDrag	= 129;

	{	
	    Parameters for window action events:
	    
	    kEventWindowCollapse
	        --> kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowCollapsed
	        --> kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowCollapseAll
	        --> kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowExpand
	        --> kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowExpanded
	        --> kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowExpandAll
	        --> kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowClose
	        --> kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowClosed
	        --> kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowCloseAll
	        --> kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowZoom
	        --> kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowZoomed
	        --> kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowZoomAll
	        --> kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowContextualMenuSelect
	        --> kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowPathSelect
	        --> kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowGetIdealSize
	        --> kEventParamDirectObject     typeWindowRef
	        <-- kEventParamDimensions       typeQDPoint
	        
	    kEventWindowGetMinimumSize
	        --> kEventParamDirectObject     typeWindowRef
	        <-- kEventParamDimensions       typeQDPoint
	        
	    kEventWindowGetMaximumSize
	        --> kEventParamDirectObject     typeWindowRef
	        <-- kEventParamDimensions       typeQDPoint
	    
	    kEventWindowConstrain
	        --> kEventParamAvailableBounds  typeQDRectangle
	    
	    kEventWindowHandleContentClick
	        --> kEventParamDirectObject     typeWindowRef
	        --> kEventParamMouseLocation    typeQDPoint
	        --> kEventParamKeyModifiers     typeUInt32
	
	    kEventWindowProxyBeginDrag
	        --> kEventParamDirectObject     typeWindowRef
	        
	    kEventWindowProxyEndDrag
	        --> kEventParamDirectObject     typeWindowRef
		}

	{
	 *  Summary:
	 *    Window focus events (kEventClassWindow)
	 *  
	 *  Discussion:
	 *    Events related to focus changes between windows. These events are
	 *    generated by SetUserFocusWindow; since that API is only called by
	 *    default by the standard window handler, these events are normally
	 *    only sent to windows with the standard handler installed.
	 	}
	kEventWindowFocusAcquired	= 200;
	kEventWindowFocusRelinquish	= 201;

	{	
	    Parameters for window focus events:
	    
	    kEventWindowFocusAcquire
	        -->     kEventParamDirectObject     typeWindowRef
	
	    kEventWindowFocusRelinquish
	        -->     kEventParamDirectObject     typeWindowRef
		}

	{
	 *  Summary:
	 *    Window definition events (kEventClassWindow)
	 *  
	 *  Discussion:
	 *    Events that correspond to WDEF messages. Sent to all windows,
	 *    regardless of whether they have the standard window handler
	 *    installed.
	 	}
	kEventWindowDrawFrame		= 1000;
	kEventWindowDrawPart		= 1001;
	kEventWindowGetRegion		= 1002;
	kEventWindowHitTest			= 1003;
	kEventWindowInit			= 1004;
	kEventWindowDispose			= 1005;
	kEventWindowDragHilite		= 1006;
	kEventWindowModified		= 1007;
	kEventWindowSetupProxyDragImage = 1008;
	kEventWindowStateChanged	= 1009;
	kEventWindowMeasureTitle	= 1010;
	kEventWindowDrawGrowBox		= 1011;
	kEventWindowGetGrowImageRegion = 1012;
	kEventWindowPaint			= 1013;

	{	
	    Parameters for window definition events:
	    
	    kEventWindowDrawFrame
	        -->     kEventParamDirectObject     typeWindowRef               the window
	
	    kEventWindowDrawPart
	        -->     kEventParamDirectObject     typeWindowRef               the window
	        -->     kEventParamWindowDefPart    typeWindowDefPartCode       the part to draw
	
	    kEventWindowGetRegion
	        -->     kEventParamDirectObject     typeWindowRef               the window
	        -->     kEventParamWindowRegionCode typeWindowRegionCode        the region to get
	        -->     kEventParamRgnHandle        typeQDRgnHandle             the region to munge
	
	    kEventWindowHitTest
	        -->     kEventParamDirectObject     typeWindowRef               the window
	        -->     kEventParamMouseLocation    typeQDPoint                 the mouse location
	        <--     kEventParamWindowDefPart    typeWindowDefPartCode       the part hit
	
	    kEventWindowInit
	        -->     kEventParamDirectObject     typeWindowRef               the window
	        <--     kEventParamWindowFeatures   typeUInt32                  the window features
	
	    kEventWindowDispose
	        -->     kEventParamDirectObject     typeWindowRef               the window
	
	    kEventWindowDragHilite
	        -->     kEventParamDirectObject             typeWindowRef       the window
	        -->     kEventParamWindowDragHiliteFlag     typeBoolean         whether to draw (true) or
	                                                                        erase (false) the hilite
	
	    kEventWindowModified
	        -->     kEventParamDirectObject             typeWindowRef       the window
	        -->     kEventParamWindowModifiedFlag       typeBoolean         the new modified state
	
	    kEventWindowSetupProxyDragImage
	        -->     kEventParamDirectObject             typeWindowRef       the window
	        -->     kEventParamWindowProxyImageRgn      typeQDRgnHandle     the region you modify
	                                                                        to contain the clip
	                                                                        region for the GWorld.
	        -->     kEventParamWindowProxyOutlineRgn    typeQDRgnHandle     the region you modify
	                                                                        to contain the drag
	                                                                        outline used when the
	                                                                        GWorld cannot be used.
	        <--     kEventParamWindowProxyGWorldPtr     typeGWorldPtr       a GWorld you allocate
	                                                                        which contains the
	                                                                        drag image.
	
	    kEventWindowStateChanged
	        -->     kEventParamDirectObject             typeWindowRef       the window
	        -->     kEventParamWindowStateChangedFlags  typeUInt32          the state change flags
	
	    kEventWindowMeasureTitle
	        -->     kEventParamDirectObject             typeWindowRef       the window
	        <--     kEventParamWindowTitleFullWidth     typeSInt16          the length of the whole title area
	        <--     kEventParamWindowTitleTextWidth     typeSInt16          the length just the title text
	
	    kEventWindowDrawGrowBox
	        -->     kEventParamDirectObject     typeWindowRef               the window
	
	    kEventWindowGetGrowImageRegion
	        -->     kEventParamDirectObject     typeWindowRef               the window
	        -->     kEventParamWindowGrowRect   typeQDRectangle             the global rect
	        -->     kEventParamRgnHandle        typeQDRgnHandle             the region to modify
	
	    kEventWindowPaint
	        -->     kEventParamDirectObject     typeWindowRef               the window
		}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  Menu Events                                                                         	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  Summary:
	 *    Menu events (kEventClassMenu)
	 	}
	kEventMenuBeginTracking		= 1;
	kEventMenuEndTracking		= 2;
	kEventMenuChangeTrackingMode = 3;
	kEventMenuOpening			= 4;
	kEventMenuClosed			= 5;
	kEventMenuTargetItem		= 6;
	kEventMenuMatchKey			= 7;
	kEventMenuEnableItems		= 8;
	kEventMenuDispose			= 1001;

	{	
	    Parameters for menu events:
	    
	    kEventMenuBeginTracking
	        -->     kEventParamDirectObject             typeMenuRef
	        -->     kEventParamCurrentMenuTrackingMode  typeMenuTrackingMode
	        
	    kEventMenuEndTracking
	        -->     kEventParamDirectObject             typeMenuRef
	        
	    kEventMenuOpening
	        -->     kEventParamDirectObject             typeMenuRef
	        -->     kEventParamMenuFirstOpen            typeBoolean
	        
	    kEventMenuClosed
	        -->     kEventParamDirectObject             typeMenuRef
	        
	    kEventMenuTargetItem
	        -->     kEventParamDirectObject             typeMenuRef
	        -->     kEventParamMenuItemIndex            typeMenuItemIndex
	        -->     kEventParamMenuCommand              typeMenuCommand
	    
	    kEventMenuMatchKey
	        -->     kEventParamDirectObject             typeMenuRef
	        -->     kEventParamEventRef                 typeEventRef
	        -->     kEventParamMenuEventOptions         typeMenuEventOptions
	        <--     kEventParamMenuItemIndex            typeMenuItemIndex
	        
	    kEventMenuEnableItems
	        -->     kEventParamDirectObject             typeMenuRef
	        -->     kEventParamEnableMenuForKeyEvent    typeBoolean
	        
	    kEventMenuDispose
	        -->     kEventParamDirectObject             typeMenuRef
		}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  Command Events                                                                      	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  Summary:
	 *    Command events (kEventClassCommand)
	 	}
	kEventProcessCommand		= 1;
	kEventCommandProcess		= 1;
	kEventCommandUpdateStatus	= 2;

	{	
	    Parameters for command events:
	
	    kEventCommandProcess
	        -->     kEventParamDirectObject     typeHICommand
	        -->     kEventParamKeyModifiers     typeUInt32 (optional)
	
	    kEventCommandUpdateStatus
	        -->     kEventParamDirectObject     typeHICommand
		}
	{	 HI Commands 	}
	kHICommandOK				= 'ok  ';
	kHICommandCancel			= 'not!';
	kHICommandQuit				= 'quit';
	kHICommandUndo				= 'undo';
	kHICommandRedo				= 'redo';
	kHICommandCut				= 'cut ';
	kHICommandCopy				= 'copy';
	kHICommandPaste				= 'past';
	kHICommandClear				= 'clea';
	kHICommandSelectAll			= 'sall';
	kHICommandHide				= 'hide';
	kHICommandPreferences		= 'pref';
	kHICommandZoomWindow		= 'zoom';
	kHICommandMinimizeWindow	= 'mini';
	kHICommandArrangeInFront	= 'frnt';
	kHICommandAbout				= 'abou';

	kHICommandFromMenu			= $00000001;


TYPE
	HICommandPtr = ^HICommand;
	HICommand = RECORD
		attributes:				UInt32;
		commandID:				UInt32;
		menuRef:				MenuRef;
		menuItemIndex:			MenuItemIndex;
	END;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  Control Events                                                                      	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  Summary:
	 *    Control events (kEventClassControl)
	 	}

CONST
	kEventControlInitialize		= 1000;
	kEventControlDispose		= 1001;
	kEventControlGetOptimalBounds = 1003;
	kEventControlDefInitialize	= 1000;
	kEventControlDefDispose		= 1001;
	kEventControlHit			= 1;
	kEventControlSimulateHit	= 2;
	kEventControlHitTest		= 3;
	kEventControlDraw			= 4;
	kEventControlApplyBackground = 5;
	kEventControlApplyTextColor	= 6;
	kEventControlSetFocusPart	= 7;
	kEventControlGetFocusPart	= 8;
	kEventControlActivate		= 9;
	kEventControlDeactivate		= 10;
	kEventControlSetCursor		= 11;
	kEventControlContextualMenuClick = 12;
	kEventControlClick			= 13;
	kEventControlTrack			= 51;
	kEventControlGetScrollToHereStartPoint = 52;
	kEventControlGetIndicatorDragConstraint = 53;
	kEventControlIndicatorMoved	= 54;
	kEventControlGhostingFinished = 55;
	kEventControlGetActionProcPart = 56;
	kEventControlGetPartRegion	= 101;
	kEventControlGetPartBounds	= 102;
	kEventControlSetData		= 103;
	kEventControlGetData		= 104;
	kEventControlValueFieldChanged = 151;
	kEventControlAddedSubControl = 152;
	kEventControlRemovingSubControl = 153;
	kEventControlBoundsChanged	= 154;
	kEventControlOwningWindowChanged = 159;
	kEventControlArbitraryMessage = 201;


	{
	 *  Summary:
	 *    Control bounds change event attributes
	 *  
	 *  Discussion:
	 *    When the toolbox sends out a kEventControlBoundsChanged event, it
	 *    also sends along a parameter containing attributes of the event.
	 *    These attributes can be used to determine what aspect of the
	 *    control changed (position, size, or both).
	 	}
	kControlBoundsChangeSizeChanged = $04;
	kControlBoundsChangePositionChanged = $08;

	{	
	    Parameters for control events:
	
	    kEventControlInitialize
	        -->     kEventParamDirectObject     typeControlRef
	        -->     kEventParamInitCollection   typeCollection
	        <--     kEventParamControlFeatures  typeUInt32
	        
	    kEventControlDispose
	        -->     kEventParamDirectObject     typeControlRef
	
	    kEventControlGetOptimalBounds
	        Required parameters:
	        -->     kEventParamDirectObject                     typeControlRef
	        <--     kEventParamControlOptimalBounds             typeQDRectangle
	        
	        Optional parameters:
	        <--     kEventParamControlOptimalBaselineOffset     typeShortInteger (optional)
	        
	    kEventControlHit
	        -->     kEventParamDirectObject     typeControlRef
	        -->     kEventParamControlPart      typeControlPartCode
	        -->     kEventParamKeyModifiers     typeUInt32
	
	    kEventControlSimulateHit
	        -->     kEventParamDirectObject     typeControlRef
	        
	    kEventControlHitTest
	        -->     kEventParamDirectObject     typeControlRef
	        -->     kEventParamMouseLocation    typeQDPoint
	        <--     kEventParamControlPart      typeControlPartCode
	        
	    kEventControlDraw
	        Required parameters:
	        -->     kEventParamDirectObject     typeControlRef
	        
	        Optional parameters:
	        -->     kEventParamControlPart      typeControlPartCode
	                    (draw the entire control if kEventParamControlPart is not present)
	        -->     kEventParamGrafPort         typeGrafPtr
	                    (draw into the current port if kEventParamGrafPort is not present)
	
	    kEventControlApplyBackground
	        Required parameters:
	        -->     kEventParamDirectObject         typeControlRef
	        -->     kEventParamControlSubControl    typeControlRef
	        -->     kEventParamControlDrawDepth     typeShortInteger
	        -->     kEventParamControlDrawInColor   typeBoolean
	        
	        Optional parameters:
	        -->     kEventParamGrafPort             typeGrafPtr
	                    (apply to the current port if kEventParamGrafPort is not present)
	
	    kEventControlApplyTextColor
	        Required parameters:
	        -->     kEventParamDirectObject         typeControlRef
	        -->     kEventParamControlSubControl    typeControlRef
	        -->     kEventParamControlDrawDepth     typeShortInteger
	        -->     kEventParamControlDrawInColor   typeBoolean
	        
	        Optional parameters:
	        -->     kEventParamCGContextRef         typeCGContextRef
	        -->     kEventParamGrafPort             typeGrafPtr
	                    (apply to the current port if kEventParamGrafPort is not present)
	
	    kEventControlSetFocusPart
	        -->     kEventParamDirectObject     typeControlRef
	        <->     kEventParamControlPart      typeControlPartCode
	
	    kEventControlGetFocusPart
	        -->     kEventParamDirectObject     typeControlRef
	        <--     kEventParamControlPart      typeControlPartCode
	
	    kEventControlActivate
	        -->     kEventParamDirectObject     typeControlRef
	
	    kEventControlDeactivate
	        -->     kEventParamDirectObject     typeControlRef
	
	    kEventControlSetCursor
	        -->     kEventParamDirectObject     typeControlRef
	        -->     kEventParamMouseLocation    typeQDPoint
	        -->     kEventParamKeyModifiers     typeUInt32
	
	    kEventControlContextualMenuClick
	        -->     kEventParamDirectObject     typeControlRef
	        -->     kEventParamMouseLocation    typeQDPoint
	
	    kEventControlTrack
	        -->     kEventParamDirectObject     typeControlRef
	        -->     kEventParamMouseLocation    typeQDPoint
	        <->     kEventParamKeyModifiers     typeUInt32
	        -->     kEventParamControlAction    typeControlActionUPP
	        <--     kEventParamControlPart      typeControlPartCode
	
	    kEventControlGetScrollToHereStartPoint
	        -->     kEventParamDirectObject     typeControlRef
	        <->     kEventParamMouseLocation    typeQDPoint
	        -->     kEventParamKeyModifiers     typeUInt32
	
	    kEventControlGetIndicatorDragConstraint
	        -->     kEventParamDirectObject                     typeControlRef
	        -->     kEventParamMouseLocation                    typeQDPoint
	        -->     kEventParamKeyModifiers                     typeUInt32
	        <--     kEventParamControlIndicatorDragConstraint   typeIndicatorDragConstraint
	
	    kEventControlIndicatorMoved
	        -->     kEventParamDirectObject             typeControlRef
	        -->     kEventParamControlIndicatorRegion   typeQDRgnHandle
	        -->     kEventParamControlIsGhosting        typeBoolean
	
	    kEventControlGhostingFinished
	        -->     kEventParamDirectObject             typeControlRef
	        -->     kEventParamControlIndicatorOffset   typeQDPoint
	
	    kEventControlGetActionProcPart
	        -->     kEventParamDirectObject             typeControlRef
	        -->     kEventParamKeyModifiers             typeUInt32
	        <->     kEventParamControlPart              typeControlPartCode
	
	    kEventControlGetPartRegion
	        -->     kEventParamDirectObject             typeControlRef
	        -->     kEventParamControlPart              typeControlPartCode
	        -->     kEventParamControlRegion            typeQDRgnHandle
	
	    kEventControlGetPartBounds
	        -->     kEventParamDirectObject             typeControlRef
	        -->     kEventParamControlPart              typeControlPartCode
	        <--     kEventParamControlPartBounds        typeQDRectangle
	
	    kEventControlSetData
	        -->     kEventParamDirectObject             typeControlRef
	        -->     kEventParamControlPart              typeControlPartCode
	        -->     kEventParamControlDataTag           typeEnumeration
	        -->     kEventParamControlDataBuffer        typePtr
	        -->     kEventParamControlDataBufferSize    typeLongInteger
	
	    kEventControlGetData
	        -->     kEventParamDirectObject             typeControlRef
	        -->     kEventParamControlPart              typeControlPartCode
	        -->     kEventParamControlDataTag           typeEnumeration
	        -->     kEventParamControlDataBuffer        typePtr
	        <->     kEventParamControlDataBufferSize    typeLongInteger
	
	    kEventControlValueFieldChanged
	        -->     kEventParamDirectObject             typeControlRef
	
	    kEventControlAddedSubControl
	        -->     kEventParamDirectObject             typeControlRef
	        -->     kEventParamControlSubControl        typeControlRef
	
	    kEventControlRemovingSubControl
	        -->     kEventParamDirectObject             typeControlRef
	        -->     kEventParamControlSubControl        typeControlRef
	
	    kEventControlBoundsChanged
	        -->     kEventParamDirectObject             typeControlRef
	        -->     kEventParamAttributes               typeUInt32
	        -->     kEventParamOriginalBounds           typeQDRectangle
	        -->     kEventParamPreviousBounds           typeQDRectangle
	        -->     kEventParamCurrentBounds            typeQDRectangle
	
	    kEventControlOwningWindowChanged
	        -->     kEventParamDirectObject                 typeControlRef
	        -->     kEventParamAttributes                   typeUInt32
	        -->     kEventParamControlOriginalOwningWindow  typeWindowRef
	        -->     kEventParamControlCurrentOwningWindow   typeWindowRef
	
	    kEventControlArbitraryMessage
	        -->     kEventParamDirectObject             typeControlRef
	        -->     kEventParamControlMessage           typeShortInteger
	        -->     kEventParamControlParam             typeLongInteger
	        <--     kEventParamControlResult            typeLongInteger
		}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  Tablet Events                                                                       	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  Summary:
	 *    Tablet events (kEventClassTablet)
	 	}
	kEventTabletPointer			= 1;
	kEventTabletProximity		= 2;


TYPE
	TabletPointerRecPtr = ^TabletPointerRec;
	TabletPointerRec = RECORD
		absX:					SInt32;									{  absolute x coordinate in tablet space at full tablet resolution  }
		absY:					SInt32;									{  absolute y coordinate in tablet space at full tablet resolution  }
		absZ:					SInt32;									{  absolute z coordinate in tablet space at full tablet resolution  }
		buttons:				UInt16;									{  one bit per button - bit 0 is first button - 1 = closed  }
		pressure:				UInt16;									{  scaled pressure value; MAXPRESSURE=(2^16)-1, MINPRESSURE=0  }
		tiltX:					SInt16;									{  scaled tilt x value; range is -((2^15)-1) to (2^15)-1 (-32767 to 32767)  }
		tiltY:					SInt16;									{  scaled tilt y value; range is -((2^15)-1) to (2^15)-1 (-32767 to 32767)  }
		rotation:				UInt16;									{  Fixed-point representation of device rotation in a 10.6 format  }
		tangentialPressure:		SInt16;									{  tangential pressure on the device; range same as tilt  }
		deviceID:				UInt16;									{  system-assigned unique device ID - matches to deviceID field in proximity event  }
		vendor1:				SInt16;									{  vendor-defined signed 16-bit integer  }
		vendor2:				SInt16;									{  vendor-defined signed 16-bit integer  }
		vendor3:				SInt16;									{  vendor-defined signed 16-bit integer  }
	END;

	TabletProximityRecPtr = ^TabletProximityRec;
	TabletProximityRec = RECORD
		vendorID:				UInt16;									{  vendor-defined ID - typically will be USB vendor ID  }
		tabletID:				UInt16;									{  vendor-defined tablet ID - typically will be USB product ID for the tablet  }
		pointerID:				UInt16;									{  vendor-defined ID of the specific pointing device  }
		deviceID:				UInt16;									{  system-assigned unique device ID - matches to deviceID field in tablet event  }
		systemTabletID:			UInt16;									{  system-assigned unique tablet ID  }
		vendorPointerType:		UInt16;									{  vendor-defined pointer type  }
		pointerSerialNumber:	UInt32;									{  vendor-defined serial number of the specific pointing device  }
		uniqueID:				UInt64;									{  vendor-defined unique ID for this pointer  }
		capabilityMask:			UInt32;									{  mask representing the capabilities of the device  }
		pointerType:			SInt8;									{  type of pointing device - enum to be defined  }
		enterProximity:			SInt8;									{  non-zero = entering; zero = leaving  }
	END;

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 Volume Events                                                                        	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  Summary:
	 *    Volume events (kEventClassVolume)
	 	}

CONST
	kEventVolumeMounted			= 1;							{  new volume mounted }
	kEventVolumeUnmounted		= 2;							{  volume has been ejected or unmounted }

	{	
	    Parameters for volume events:
	
	    kEventVolumeMounted
	        -->     kEventParamDirectObject     typeFSVolumeRefNum
	    
	    kEventVolumeUnmounted
	        -->     kEventParamDirectObject     typeFSVolumeRefNum
		}

	{  types for volume events }

	typeFSVolumeRefNum			= 'voln';						{  FSVolumeRefNum }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	 Parameter names and types                                                            	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}
	kEventParamDirectObject		= '----';						{  type varies depending on event }

	{  Generic toolbox types and parameter names }

	kEventParamWindowRef		= 'wind';						{  typeWindowRef }
	kEventParamGrafPort			= 'graf';						{  typeGrafPtr }
	kEventParamDragRef			= 'drag';						{  typeDragRef }
	kEventParamMenuRef			= 'menu';						{  typeMenuRef }
	kEventParamEventRef			= 'evnt';						{  typeEventRef }
	kEventParamControlRef		= 'ctrl';						{  typeControlRef }
	kEventParamRgnHandle		= 'rgnh';						{  typeQDRgnHandle }
	kEventParamEnabled			= 'enab';						{  typeBoolean }
	kEventParamDimensions		= 'dims';						{  typeQDPoint }
	kEventParamAvailableBounds	= 'avlb';						{  typeQDRectangle }
	kEventParamAEEventID		= 'evti';						{  typeType }
	kEventParamAEEventClass		= 'evcl';						{  typeType }
	kEventParamCGContextRef		= 'cntx';						{  typeCGContextRef }
	typeWindowRef				= 'wind';						{  WindowRef }
	typeGrafPtr					= 'graf';						{  CGrafPtr }
	typeGWorldPtr				= 'gwld';						{  GWorldPtr }
	typeDragRef					= 'drag';						{  DragRef }
	typeMenuRef					= 'menu';						{  MenuRef }
	typeControlRef				= 'ctrl';						{  ControlRef }
	typeCollection				= 'cltn';						{  Collection }
	typeQDRgnHandle				= 'rgnh';						{  RgnHandle }
	typeOSStatus				= 'osst';						{  OSStatus }
	typeCGContextRef			= 'cntx';						{  CGContextRef }

	{  mouse-event-related event parameters }

	kEventParamMouseLocation	= 'mloc';						{  typeQDPoint }
	kEventParamMouseButton		= 'mbtn';						{  typeMouseButton }
	kEventParamClickCount		= 'ccnt';						{  typeUInt32 }
	kEventParamMouseWheelAxis	= 'mwax';						{  typeMouseWheelAxis }
	kEventParamMouseWheelDelta	= 'mwdl';						{  typeSInt32 }
	kEventParamMouseDelta		= 'mdta';						{  typeQDPoint }
	kEventParamMouseChord		= 'chor';						{  typeUInt32 }
	typeMouseButton				= 'mbtn';						{  EventMouseButton }
	typeMouseWheelAxis			= 'mwax';						{  EventMouseWheelAxis }

	{  keyboard parameter types }

	kEventParamKeyCode			= 'kcod';						{  typeUInt32 }
	kEventParamKeyMacCharCodes	= 'kchr';						{  typeChar }
	kEventParamKeyModifiers		= 'kmod';						{  typeUInt32 }
	kEventParamKeyUnicodes		= 'kuni';						{  typeUnicodeText }
	typeEventHotKeyID			= 'hkid';						{  EventHotKeyID }

	{  TextInput parameter types }

	kEventParamTextInputSendRefCon = 'tsrc';					{     typeLongInteger }
	kEventParamTextInputSendComponentInstance = 'tsci';			{     typeComponentInstance }
	kEventParamTextInputSendSLRec = 'tssl';						{     typeIntlWritingCode }
	kEventParamTextInputReplySLRec = 'trsl';					{     typeIntlWritingCode }
	kEventParamTextInputSendText = 'tstx';						{     typeUnicodeText (if TSMDocument is Unicode), otherwise typeChar }
	kEventParamTextInputReplyText = 'trtx';						{     typeUnicodeText (if TSMDocument is Unicode), otherwise typeChar }
	kEventParamTextInputSendUpdateRng = 'tsup';					{     typeTextRangeArray }
	kEventParamTextInputSendHiliteRng = 'tshi';					{     typeTextRangeArray }
	kEventParamTextInputSendClauseRng = 'tscl';					{     typeOffsetArray }
	kEventParamTextInputSendPinRng = 'tspn';					{     typeTextRange }
	kEventParamTextInputSendFixLen = 'tsfx';					{     typeLongInteger }
	kEventParamTextInputSendLeadingEdge = 'tsle';				{     typeBoolean }
	kEventParamTextInputReplyLeadingEdge = 'trle';				{     typeBoolean }
	kEventParamTextInputSendTextOffset = 'tsto';				{     typeLongInteger }
	kEventParamTextInputReplyTextOffset = 'trto';				{     typeLongInteger }
	kEventParamTextInputReplyRegionClass = 'trrg';				{     typeLongInteger }
	kEventParamTextInputSendCurrentPoint = 'tscp';				{     typeQDPoint }
	kEventParamTextInputSendDraggingMode = 'tsdm';				{     typeBoolean }
	kEventParamTextInputReplyPoint = 'trpt';					{     typeQDPoint }
	kEventParamTextInputReplyFont = 'trft';						{     typeLongInteger }
	kEventParamTextInputReplyPointSize = 'trpz';				{     typeFixed }
	kEventParamTextInputReplyLineHeight = 'trlh';				{     typeShortInteger }
	kEventParamTextInputReplyLineAscent = 'trla';				{     typeShortInteger }
	kEventParamTextInputReplyTextAngle = 'trta';				{     typeFixed }
	kEventParamTextInputSendShowHide = 'tssh';					{     typeBoolean }
	kEventParamTextInputReplyShowHide = 'trsh';					{     typeBoolean }
	kEventParamTextInputSendKeyboardEvent = 'tske';				{     typeEventRef }
	kEventParamTextInputSendTextServiceEncoding = 'tsse';		{     typeUInt32 }
	kEventParamTextInputSendTextServiceMacEncoding = 'tssm';	{     typeUInt32 }



	{  HICommand stuff }

	kEventParamHICommand		= 'hcmd';						{  typeHICommand }
	typeHICommand				= 'hcmd';						{  HICommand }

	{  Window-related stuff }
	kEventParamWindowFeatures	= 'wftr';						{  typeUInt32 }
	kEventParamWindowDefPart	= 'wdpc';						{  typeWindowDefPartCode }
	kEventParamCurrentBounds	= 'crct';						{  typeQDRectangle }
	kEventParamOriginalBounds	= 'orct';						{  typeQDRectangle }
	kEventParamPreviousBounds	= 'prct';						{  typeQDRectangle }
	kEventParamClickActivation	= 'clac';						{  typeClickActivationResult }
	kEventParamWindowRegionCode	= 'wshp';						{  typeWindowRegionCode }
	kEventParamWindowDragHiliteFlag = 'wdhf';					{  typeBoolean }
	kEventParamWindowModifiedFlag = 'wmff';						{  typeBoolean }
	kEventParamWindowProxyGWorldPtr = 'wpgw';					{  typeGWorldPtr }
	kEventParamWindowProxyImageRgn = 'wpir';					{  typeQDRgnHandle }
	kEventParamWindowProxyOutlineRgn = 'wpor';					{  typeQDRgnHandle }
	kEventParamWindowStateChangedFlags = 'wscf';				{  typeUInt32  }
	kEventParamWindowTitleFullWidth = 'wtfw';					{  typeSInt16 }
	kEventParamWindowTitleTextWidth = 'wttw';					{  typeSInt16 }
	kEventParamWindowGrowRect	= 'grct';						{  typeQDRectangle }
	kEventParamAttributes		= 'attr';						{  typeUInt32 }
	typeWindowRegionCode		= 'wshp';						{  WindowRegionCode }
	typeWindowDefPartCode		= 'wdpt';						{  WindowDefPartCode }
	typeClickActivationResult	= 'clac';						{  ClickActivationResult }


	{  control stuff }

	kEventParamControlPart		= 'cprt';						{  typeControlPartCode }
	kEventParamInitCollection	= 'icol';						{  typeCollection }
	kEventParamControlMessage	= 'cmsg';						{  typeShortInteger }
	kEventParamControlParam		= 'cprm';						{  typeLongInteger }
	kEventParamControlResult	= 'crsl';						{  typeLongInteger }
	kEventParamControlRegion	= 'crgn';						{  typeQDRgnHandle }
	kEventParamControlAction	= 'caup';						{  typeControlActionUPP }
	kEventParamControlIndicatorDragConstraint = 'cidc';			{  typeIndicatorDragConstraint }
	kEventParamControlIndicatorRegion = 'cirn';					{  typeQDRgnHandle }
	kEventParamControlIsGhosting = 'cgst';						{  typeBoolean }
	kEventParamControlIndicatorOffset = 'ciof';					{  typeQDPoint }
	kEventParamControlClickActivationResult = 'ccar';			{  typeClickActivationResult }
	kEventParamControlSubControl = 'csub';						{  typeControlRef }
	kEventParamControlOptimalBounds = 'cobn';					{  typeQDRectangle }
	kEventParamControlOptimalBaselineOffset = 'cobo';			{  typeShortInteger }
	kEventParamControlDataTag	= 'cdtg';						{  typeEnumeration }
	kEventParamControlDataBuffer = 'cdbf';						{  typePtr }
	kEventParamControlDataBufferSize = 'cdbs';					{  typeLongInteger }
	kEventParamControlDrawDepth	= 'cddp';						{  typeShortInteger }
	kEventParamControlDrawInColor = 'cdic';						{  typeBoolean }
	kEventParamControlFeatures	= 'cftr';						{  typeUInt32 }
	kEventParamControlPartBounds = 'cpbd';						{  typeQDRectangle }
	kEventParamControlOriginalOwningWindow = 'coow';			{  typeWindowRef }
	kEventParamControlCurrentOwningWindow = 'ccow';				{  typeWindowRef }
	typeControlActionUPP		= 'caup';						{  ControlActionUPP }
	typeIndicatorDragConstraint	= 'cidc';						{  IndicatorDragConstraint }
	typeControlPartCode			= 'cprt';						{  ControlPartCode }

	{  menu-related event parameters }

	kEventParamCurrentMenuTrackingMode = 'cmtm';				{  typeMenuTrackingMode }
	kEventParamNewMenuTrackingMode = 'nmtm';					{  typeMenuTrackingMode }
	kEventParamMenuFirstOpen	= '1sto';						{  typeBoolean }
	kEventParamMenuItemIndex	= 'item';						{  typeMenuItemIndex }
	kEventParamMenuCommand		= 'mcmd';						{  typeMenuCommand }
	kEventParamEnableMenuForKeyEvent = 'fork';					{  typeBoolean }
	kEventParamMenuEventOptions	= 'meop';						{  typeMenuEventOptions }
	typeMenuItemIndex			= 'midx';						{  MenuItemIndex }
	typeMenuCommand				= 'mcmd';						{  MenuCommand }
	typeMenuTrackingMode		= 'mtmd';						{  MenuTrackingMode }
	typeMenuEventOptions		= 'meop';						{  MenuEventOptions }

	{  application-event parameters }

	kEventParamProcessID		= 'psn ';						{  typeProcessSerialNumber }
	kEventParamLaunchRefCon		= 'lref';						{  typeWildcard }
	kEventParamLaunchErr		= 'err ';						{  typeOSStatus }

	{  tablet event parameters }

	kEventParamTabletPointerRec	= 'tbrc';						{  typeTabletPointerRec }
	kEventParamTabletProximityRec = 'tbpx';						{  typeTabletProximityRec }
	typeTabletPointerRec		= 'tbrc';						{  kEventParamTabletPointerRec }
	typeTabletProximityRec		= 'tbpx';						{  kEventParamTabletProximityRec }


	{	======================================================================================	}
	{	  EVENT HANDLERS                                                                      	}
	{	======================================================================================	}


TYPE
	EventHandlerRef    = ^LONGINT; { an opaque 32-bit type }
	EventHandlerRefPtr = ^EventHandlerRef;  { when a VAR xx:EventHandlerRef parameter can be nil, it is changed to xx: EventHandlerRefPtr }
	EventHandlerCallRef    = ^LONGINT; { an opaque 32-bit type }
	EventHandlerCallRefPtr = ^EventHandlerCallRef;  { when a VAR xx:EventHandlerCallRef parameter can be nil, it is changed to xx: EventHandlerCallRefPtr }

	{	——————————————————————————————————————————————————————————————————————————————————————	}
	{	  • EventHandler specification                                                        	}
	{	——————————————————————————————————————————————————————————————————————————————————————	}

	{
	 *  EventHandlerProcPtr
	 *  
	 *  Discussion:
	 *    Callback for receiving events sent to a target this callback is
	 *    installed on.
	 *  
	 *  Parameters:
	 *    
	 *    inHandlerCallRef:
	 *      A reference to the current handler call chain. This is sent to
	 *      your handler so that you can call CallNextEventHandler if you
	 *      need to.
	 *    
	 *    inEvent:
	 *      The Event.
	 *    
	 *    inUserData:
	 *      The app-specified data you passed in a call to
	 *      InstallEventHandler.
	 *  
	 *  Result:
	 *    An operating system result code. Returning noErr indicates you
	 *    handled the event. Returning eventNotHandledErr indicates you did
	 *    not handle the event and perhaps the toolbox should take other
	 *    action.
	 	}
{$IFC TYPED_FUNCTION_POINTERS}
	EventHandlerProcPtr = FUNCTION(inHandlerCallRef: EventHandlerCallRef; inEvent: EventRef; inUserData: UNIV Ptr): OSStatus;
{$ELSEC}
	EventHandlerProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	EventHandlerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	EventHandlerUPP = UniversalProcPtr;
{$ENDC}	

CONST
	uppEventHandlerProcInfo = $00000FF0;
	{
	 *  NewEventHandlerUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewEventHandlerUPP(userRoutine: EventHandlerProcPtr): EventHandlerUPP; { old name was NewEventHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeEventHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeEventHandlerUPP(userUPP: EventHandlerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeEventHandlerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeEventHandlerUPP(inHandlerCallRef: EventHandlerCallRef; inEvent: EventRef; inUserData: UNIV Ptr; userRoutine: EventHandlerUPP): OSStatus; { old name was CallEventHandlerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Installing Event Handlers                                                         }
{                                                                                      }
{ Use these routines to install event handlers for a specific toolbox object. You may  }
{ pass zero for inNumTypes and NULL for inList if you need to be in a situation where  }
{ you know you will be receiving events, but not exactly which ones at the time you    }
{ are installing the handler. Later, your application can call the Add/Remove routines }
{ listed below this section.                                                           }
{                                                                                      }
{ You can only install a specific handler once. The combination of inHandler and       }
{ inUserData is considered the 'signature' of a handler. Any attempt to install a new  }
{ handler with the same proc and user data as an already-installed handler will result }
{ in eventHandlerAlreadyInstalledErr. Installing the same proc and user data on a      }
{ different object is legal.                                                           }
{                                                                                      }
{ Upon successful completion of this routine, you are returned an EventHandlerRef,     }
{ which you can use in various other calls, and is passed to your event handler. You   }
{ use it to extract information about the handler, such as the target (window, etc.)   }
{ if you have the same handler installed for different objects and need to perform     }
{ actions on the current target (say, call a window manager function).                 }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	EventTargetRef    = ^LONGINT; { an opaque 32-bit type }
	EventTargetRefPtr = ^EventTargetRef;  { when a VAR xx:EventTargetRef parameter can be nil, it is changed to xx: EventTargetRefPtr }
	{
	 *  GetWindowEventTarget()
	 *  
	 *  Discussion:
	 *    Returns the EventTargetRef for the specified window. Once you
	 *    obtain this reference, you can send events to the target and
	 *    install an event handler on it.
	 *  
	 *  Parameters:
	 *    
	 *    inWindow:
	 *      The window to return the target for.
	 *  
	 *  Result:
	 *    An EventTargetRef.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION GetWindowEventTarget(inWindow: WindowRef): EventTargetRef;

{
 *  GetControlEventTarget()
 *  
 *  Discussion:
 *    Returns the EventTargetRef for the specified control. Once you
 *    obtain this reference, you can send events to the target and
 *    install event handler on it.
 *  
 *  Parameters:
 *    
 *    inControl:
 *      The control to return the target for.
 *  
 *  Result:
 *    An EventTargetRef.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetControlEventTarget(inControl: ControlRef): EventTargetRef;

{
 *  GetMenuEventTarget()
 *  
 *  Discussion:
 *    Returns the EventTargetRef for the specified menu. Once you
 *    obtain this reference, you can send events to the target and
 *    install event handler on it.
 *  
 *  Parameters:
 *    
 *    inMenu:
 *      The menu to return the target for.
 *  
 *  Result:
 *    An EventTargetRef.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetMenuEventTarget(inMenu: MenuRef): EventTargetRef;

{
 *  GetApplicationEventTarget()
 *  
 *  Discussion:
 *    Returns the EventTargetRef for the application. Once you obtain
 *    this reference, you can send events to the target and install
 *    event handler on it.
 *  
 *  Result:
 *    An EventTargetRef.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetApplicationEventTarget: EventTargetRef;

{
 *  GetUserFocusEventTarget()
 *  
 *  Discussion:
 *    Returns the EventTargetRef for the current user focus at the time
 *    of the call. Keyboard events are always sent to this target.
 *  
 *  Result:
 *    An EventTargetRef.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetUserFocusEventTarget: EventTargetRef;

{
 *  GetEventDispatcherTarget()
 *  
 *  Discussion:
 *    Returns the EventTargetRef for the standard toolbox dispatcher.
 *    You typically would never need to use this, but there are some
 *    exotic apps that need to pick events off the event queue and call
 *    the dispatcher themselves. This allows you to do just that
 *    instead of calling RunApplicationEventLoop to handle it all.
 *  
 *  Result:
 *    An EventTargetRef.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetEventDispatcherTarget: EventTargetRef; C;

{
 *  InstallEventHandler()
 *  
 *  Discussion:
 *    Installs an event handler on a specified target. Your handler
 *    proc will be called with the events you registered with when an
 *    event of the corresponding type and class are send to the target
 *    you are installing your handler on.
 *  
 *  Parameters:
 *    
 *    inTarget:
 *      The target to register your handler with.
 *    
 *    inHandler:
 *      A pointer to your handler function.
 *    
 *    inNumTypes:
 *      The number of events you are registering for.
 *    
 *    inList:
 *      A pointer to an array of EventTypeSpec entries representing the
 *      events you are interested in.
 *    
 *    inUserData:
 *      The value passed in this parameter is passed on to your event
 *      handler proc when it is called.
 *    
 *    outRef:
 *      Receives an EventHandlerRef, which you can use later to remove
 *      the handler. You can pass null if you don't want the reference
 *      - when the target is disposed, the handler will be disposed as
 *      well.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InstallEventHandler(inTarget: EventTargetRef; inHandler: EventHandlerUPP; inNumTypes: UInt32; {CONST}VAR inList: EventTypeSpec; inUserData: UNIV Ptr; outRef: EventHandlerRefPtr): OSStatus;

{
 *  InstallStandardEventHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InstallStandardEventHandler(inTarget: EventTargetRef): OSStatus;

{
 *  RemoveEventHandler()
 *  
 *  Discussion:
 *    Removes an event handler from the target it was bound to.
 *  
 *  Parameters:
 *    
 *    inHandlerRef:
 *      The handler ref to remove (returned in a call to
 *      InstallEventHandler). After you call this function, the handler
 *      ref is considered to be invalid and can no longer be used.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveEventHandler(inHandlerRef: EventHandlerRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Adjusting set of event types after a handler is created                           }
{                                                                                      }
{ After installing a handler with the routine above, you can adjust the event type     }
{ list telling the toolbox what events to send to that handler by calling the two      }
{ routines below. If you add an event type twice for the same handler, your handler    }
{ will only be called once, but it will take two RemoveEventType calls to stop your    }
{ handler from being called with that event type. In other words, the install count    }
{ for each event type is maintained by the toolbox. This might allow you, for example  }
{ to have subclasses of a window object register for types without caring if the base  }
{ class has already registered for that type. When the subclass removes its types, it  }
{ can successfully do so without affecting the base class's reception of its event     }
{ types, yielding eternal bliss.                                                       }
{——————————————————————————————————————————————————————————————————————————————————————}

{
 *  AddEventTypesToHandler()
 *  
 *  Discussion:
 *    Adds additional events to an event handler that has already been
 *    installed.
 *  
 *  Parameters:
 *    
 *    inHandlerRef:
 *      The event handler to add the additional events to.
 *    
 *    inNumTypes:
 *      The number of events to add.
 *    
 *    inList:
 *      A pointer to an array of EventTypeSpec entries.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AddEventTypesToHandler(inHandlerRef: EventHandlerRef; inNumTypes: UInt32; {CONST}VAR inList: EventTypeSpec): OSStatus;

{
 *  RemoveEventTypesFromHandler()
 *  
 *  Discussion:
 *    Removes events from an event handler that has already been
 *    installed.
 *  
 *  Parameters:
 *    
 *    inHandlerRef:
 *      The event handler to remove the events from.
 *    
 *    inNumTypes:
 *      The number of events to remove.
 *    
 *    inList:
 *      A pointer to an array of EventTypeSpec entries.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveEventTypesFromHandler(inHandlerRef: EventHandlerRef; inNumTypes: UInt32; {CONST}VAR inList: EventTypeSpec): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Explicit Propogation                                                              }
{                                                                                      }
{  CallNextEventHandler can be used to call thru to all handlers below the current     }
{  handler being called. You pass the EventHandlerCallRef passed to your EventHandler  }
{  into this call so that we know how to properly forward the event. The result of     }
{  this function should normally be the result of your own handler that you called     }
{  this API from. The typical use of this routine would be to allow the toolbox to do  }
{  its standard processing and then follow up with some type of embellishment.         }
{——————————————————————————————————————————————————————————————————————————————————————}

{
 *  CallNextEventHandler()
 *  
 *  Discussion:
 *    Calls thru to the event handlers below you in the event handler
 *    stack of the target to which your handler is bound. You might use
 *    this to call thru to the default toolbox handling in order to
 *    post-process the event. You can only call this routine from
 *    within an event handler.
 *  
 *  Parameters:
 *    
 *    inCallRef:
 *      The event handler call ref passed into your event handler.
 *    
 *    inEvent:
 *      The event to pass thru.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION CallNextEventHandler(inCallRef: EventHandlerCallRef; inEvent: EventRef): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Sending Events                                                                    }
{——————————————————————————————————————————————————————————————————————————————————————}
{
 *  SendEventToEventTarget()
 *  
 *  Discussion:
 *    Sends an event to the specified event target.
 *  
 *  Parameters:
 *    
 *    inEvent:
 *      The event to send.
 *    
 *    inTarget:
 *      The target to send it to.
 *  
 *  Result:
 *    An operating system result code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SendEventToEventTarget(inEvent: EventRef; inTarget: EventTargetRef): OSStatus;

{======================================================================================}
{  EVENT-BASED OBJECT CLASSES                                                          }
{                                                                                      }
{  Here it is - the replacement for classic defprocs. This is also a convenient way    }
{  to create toolbox objects (windows, etc.) that have a specific behavior without     }
{  installing handlers on each instance of the object. With a toolbox object class,    }
{  you register your class, then use special creation routines to create objects of    }
{  that class. The event handlers are automatically installed and ready to go.         }
{======================================================================================}


TYPE
	ToolboxObjectClassRef    = ^LONGINT; { an opaque 32-bit type }
	ToolboxObjectClassRefPtr = ^ToolboxObjectClassRef;  { when a VAR xx:ToolboxObjectClassRef parameter can be nil, it is changed to xx: ToolboxObjectClassRefPtr }

	{
	 *  RegisterToolboxObjectClass()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION RegisterToolboxObjectClass(inClassID: CFStringRef; inBaseClass: ToolboxObjectClassRef; inNumEvents: UInt32; {CONST}VAR inEventList: EventTypeSpec; inEventHandler: EventHandlerUPP; inEventHandlerData: UNIV Ptr; VAR outClassRef: ToolboxObjectClassRef): OSStatus;

{
 *  UnregisterToolboxObjectClass()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UnregisterToolboxObjectClass(inClassRef: ToolboxObjectClassRef): OSStatus;

{======================================================================================}
{  • Command Routines                                                                  }
{======================================================================================}

{
 *  ProcessHICommand()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ProcessHICommand({CONST}VAR inCommand: HICommand): OSStatus;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Event Loop Routines                                                               }
{——————————————————————————————————————————————————————————————————————————————————————}

{
 *  RunApplicationEventLoop()
 *  
 *  Discussion:
 *    This routine is used as the main event loop for a Carbon
 *    Event-based application. Once entered, this function waits for
 *    events to arrive and dispatches them to your event handlers
 *    automatically.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE RunApplicationEventLoop;

{
 *  QuitApplicationEventLoop()
 *  
 *  Discussion:
 *    This routine is used to quit the RunApplicationEventLoop
 *    function. Typically, your application doesn't need to call this.
 *    If your application has the Quit menu item tagged with the
 *    kHICommandQuit Menu Command ID, the toolbox will automatically
 *    call this for your application, automatically terminating your
 *    event loop. If your application wants to do pre-processing before
 *    the event loop exits, it should intercept either the
 *    kHICommandQuit menu command, or the kEventApplicationQuit event.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE QuitApplicationEventLoop;

{——————————————————————————————————————————————————————————————————————————————————————}
{  • Event Modality routines                                                           }
{——————————————————————————————————————————————————————————————————————————————————————}

{
 *  RunAppModalLoopForWindow()
 *  
 *  Discussion:
 *    This routine is used as a replacement to ModalDialog to drive a
 *    Carbon Event-based modal dialog. Once called, this routine will
 *    not exit until QuitAppModalLoopForWindow is called.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window you wish to behave modally.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RunAppModalLoopForWindow(inWindow: WindowRef): OSStatus; C;

{
 *  QuitAppModalLoopForWindow()
 *  
 *  Discussion:
 *    This routine is used to quit a currently running call to
 *    RunAppModalLoopForWindow, i.e. it terminates a modal loop.
 *    Typically this would be called from a handler you have installed
 *    on the modal window in question when the user clicks the
 *    appropriate button, etc.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window for which to quit the modal state.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION QuitAppModalLoopForWindow(inWindow: WindowRef): OSStatus; C;

{
 *  BeginAppModalStateForWindow()
 *  
 *  Discussion:
 *    This routine is a lower level routine than
 *    RunAppModalLoopForWindow. It can be used if you wish to enter an
 *    app modal state for a window, but need to control the event loop
 *    yourself for whatever reason. In most cases, you would use
 *    RunAppModalLoopForWindow. Once you begin your app modal state,
 *    the menu bar will disable and prepare for the modal situation.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window you wish to behave modally.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION BeginAppModalStateForWindow(inWindow: WindowRef): OSStatus; C;

{
 *  EndAppModalStateForWindow()
 *  
 *  Discussion:
 *    This routine ends an app modal state started with
 *    BeginAppModalStateForWindow.
 *  
 *  Parameters:
 *    
 *    inWindow:
 *      The window you wish to stop acting as app modal.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION EndAppModalStateForWindow(inWindow: WindowRef): OSStatus; C;


{——————————————————————————————————————————————————————————————————————————————————————}
{  • User Focus                                                                        }
{                                                                                      }
{ The 'user focus' is where keyboard input goes. We also use the term 'key' applied    }
{ to windows to mean this. The user focus window is normally the active non-floating   }
{ window or dialog. It is possible to make a floater get the focus, however, by calling}
{ SetUserFocusWindow. After that call, the event model will automatically route key    }
{ input to the active keyboard focus of that window, if any. Passing kUserFocusAuto    }
{ into the window parameter tells the toolbox to pick what it considers to be the best }
{ candidate for focus. You should call this to restore focus, rather than getting the  }
{ focus, setting it to a special window, and then restoring to the saved focus. There  }
{ are cases, however, when you might want to restore to an explicit window, but the    }
{ typical usage should just be to restore to the kUserFocusAuto focus.                 }
{                                                                                      }
{ Keep in mind that setting the focus will only last until you restore focus, or the   }
{ user starts clicking in other windows. When that happens, the toolbox will auto-     }
{ redirect the user focus to a newly selected window.                                  }
{——————————————————————————————————————————————————————————————————————————————————————}

CONST
	kUserFocusAuto				= -1;

	{
	 *  SetUserFocusWindow()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.1 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION SetUserFocusWindow(inWindow: WindowRef): OSStatus;

{
 *  GetUserFocusWindow()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetUserFocusWindow: WindowRef;


{——————————————————————————————————————————————————————————————————————————————————————}
{  • Default/Cancel buttons                                                            }
{                                                                                      }
{ In our quest to eliminate the need for dialogs when using the new event model, we    }
{ have added the following routines which add dialog-like button control to normal     }
{ windows. With these routines, you can set the default and cancel buttons for a       }
{ window; these work just like the corresponding concepts in dialogs, and when         }
{ present, the standard toolbox handlers will handle keyboard input mapping to these   }
{ buttons. This means that pressing return or enter will 'press' the default button    }
{ and escape or command-period will 'press' the cancel button.                         }
{——————————————————————————————————————————————————————————————————————————————————————}

{
 *  SetWindowDefaultButton()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowDefaultButton(inWindow: WindowRef; inControl: ControlRef): OSStatus;

{
 *  SetWindowCancelButton()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetWindowCancelButton(inWindow: WindowRef; inControl: ControlRef): OSStatus;

{
 *  GetWindowDefaultButton()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowDefaultButton(inWindow: WindowRef; VAR outControl: ControlRef): OSStatus;

{
 *  GetWindowCancelButton()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.1 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION GetWindowCancelButton(inWindow: WindowRef; VAR outControl: ControlRef): OSStatus;


{——————————————————————————————————————————————————————————————————————————————————————}
{  • Global HotKey API                                                                 }
{——————————————————————————————————————————————————————————————————————————————————————}

TYPE
	EventHotKeyIDPtr = ^EventHotKeyID;
	EventHotKeyID = RECORD
		signature:				OSType;
		id:						UInt32;
	END;

	EventHotKeyRef    = ^LONGINT; { an opaque 32-bit type }
	EventHotKeyRefPtr = ^EventHotKeyRef;  { when a VAR xx:EventHotKeyRef parameter can be nil, it is changed to xx: EventHotKeyRefPtr }
	{
	 *  RegisterEventHotKey()
	 *  
	 *  Discussion:
	 *    Registers a global hot key based on the virtual key code and
	 *    modifiers you pass in. Only one such combination can exist for
	 *    the current application, i.e. multiple entities in the same
	 *    application cannot register for the same hot key combination. The
	 *    same hot key can, however, be registered by multiple
	 *    applications. This means that multiple applications can
	 *    potentially be notified when a particular hot key is requested.
	 *    This might not necessarily be desirable, but it is how it works
	 *    at present.
	 *  
	 *  Parameters:
	 *    
	 *    inHotKeyCode:
	 *      The virtual key code of the key to watch
	 *    
	 *    inHotKeyModifiers:
	 *      The keyboard modifiers to look for. There must be a modifier
	 *      specified, or this function will return paramErr.
	 *    
	 *    inHotKeyID:
	 *      The application-specified hot key ID. You will receive this in
	 *      the kEventHotKeyPressed event as the direct object parameter.
	 *    
	 *    inTarget:
	 *      The target to notify when the hot key is pressed.
	 *    
	 *    inOptions:
	 *      Currently unused. Pass 0 or face the consequences.
	 *    
	 *    outRef:
	 *      The EventHotKeyRef that represents your new, shiny hot key. You
	 *      need this if you later wish to unregister it.
	 *  
	 *  Result:
	 *    An operating system status code.
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.3 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION RegisterEventHotKey(inHotKeyCode: UInt32; inHotKeyModifiers: UInt32; inHotKeyID: EventHotKeyID; inTarget: EventTargetRef; inOptions: OptionBits; VAR outRef: EventHotKeyRef): OSStatus; C;

{
 *  UnregisterEventHotKey()
 *  
 *  Discussion:
 *    Unregisters a global hot key that was previously registered with
 *    the RegisterEventHotKey API. You do not need to unregister a hot
 *    key when your application terminates, the system will take care
 *    of that for you. This would be used if the user changes a hot key
 *    for something in your application - you would unregister the
 *    previous key and register your new key.
 *  
 *  Parameters:
 *    
 *    inHotKey:
 *      The EventHotKeyRef to unregister.
 *  
 *  Result:
 *    An operating system status code.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.3 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UnregisterEventHotKey(inHotKey: EventHotKeyRef): OSStatus; C;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := CarbonEventsIncludes}

{$ENDC} {__CARBONEVENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

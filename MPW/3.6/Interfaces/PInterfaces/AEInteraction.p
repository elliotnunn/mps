{
     File:       AEInteraction.p
 
     Contains:   AppleEvent functions that deal with Events and interacting with user
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 2000-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AEInteraction;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __AEINTERACTION__}
{$SETC __AEINTERACTION__ := 1}

{$I+}
{$SETC AEInteractionIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __AEDATAMODEL__}
{$I AEDataModel.p}
{$ENDC}
{$IFC UNDEFINED __NOTIFICATION__}
{$I Notification.p}
{$ENDC}
{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{*************************************************************************
  AppleEvent callbacks. 
*************************************************************************}

TYPE
{$IFC TYPED_FUNCTION_POINTERS}
	AEIdleProcPtr = FUNCTION(VAR theEvent: EventRecord; VAR sleepTime: LONGINT; VAR mouseRgn: RgnHandle): BOOLEAN;
{$ELSEC}
	AEIdleProcPtr = ProcPtr;
{$ENDC}

{$IFC TYPED_FUNCTION_POINTERS}
	AEFilterProcPtr = FUNCTION(VAR theEvent: EventRecord; returnID: LONGINT; transactionID: LONGINT; {CONST}VAR sender: AEAddressDesc): BOOLEAN;
{$ELSEC}
	AEFilterProcPtr = ProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	AEIdleUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	AEIdleUPP = UniversalProcPtr;
{$ENDC}	
{$IFC OPAQUE_UPP_TYPES}
	AEFilterUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	AEFilterUPP = UniversalProcPtr;
{$ENDC}	

	{	*************************************************************************
	  The next couple of calls are basic routines used to create, send,
	  and process AppleEvents. 
	*************************************************************************	}
	{
	 *  AESend()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION AESend({CONST}VAR theAppleEvent: AppleEvent; VAR reply: AppleEvent; sendMode: AESendMode; sendPriority: AESendPriority; timeOutInTicks: LONGINT; idleProc: AEIdleUPP; filterProc: AEFilterUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0D17, $A816;
	{$ENDC}

{
 *  AEProcessAppleEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEProcessAppleEvent({CONST}VAR theEventRecord: EventRecord): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021B, $A816;
	{$ENDC}


{ 
 Note: during event processing, an event handler may realize that it is likely
 to exceed the client's timeout limit. Passing the reply to this
 routine causes a wait event to be generated that asks the client
 for more time. 
}
{
 *  AEResetTimer()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEResetTimer({CONST}VAR reply: AppleEvent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0219, $A816;
	{$ENDC}


{*************************************************************************
  The following three calls are used to allow applications to behave
  courteously when a user interaction such as a dialog box is needed. 
*************************************************************************}


TYPE
	AEInteractAllowed 			= SInt8;
CONST
	kAEInteractWithSelf			= 0;
	kAEInteractWithLocal		= 1;
	kAEInteractWithAll			= 2;

	{
	 *  AEGetInteractionAllowed()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION AEGetInteractionAllowed(VAR level: AEInteractAllowed): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021D, $A816;
	{$ENDC}

{
 *  AESetInteractionAllowed()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AESetInteractionAllowed(level: ByteParameter): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $011E, $A816;
	{$ENDC}

{
 *  AEInteractWithUser()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEInteractWithUser(timeOutInTicks: LONGINT; nmReqPtr: NMRecPtr; idleProc: AEIdleUPP): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $061C, $A816;
	{$ENDC}


{*************************************************************************
 The following four calls are available for applications which need more
 sophisticated control over when and how events are processed. Applications
 which implement multi-session servers or which implement their own
 internal event queueing will probably be the major clients of these
 routines. They can be called from within a handler to prevent the AEM from
 disposing of the AppleEvent when the handler returns. They can be used to
 asynchronously process the event (as MacApp does).
*************************************************************************}
{
 *  AESuspendTheCurrentEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AESuspendTheCurrentEvent({CONST}VAR theAppleEvent: AppleEvent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022B, $A816;
	{$ENDC}

{ 
 Note: The following routine tells the AppleEvent manager that processing
 is either about to resume or has been completed on a previously suspended
 event. The procPtr passed in as the dispatcher parameter will be called to
 attempt to redispatch the event. Several constants for the dispatcher
 parameter allow special behavior. They are:
    - kAEUseStandardDispatch means redispatch as if the event was just
      received, using the standard AppleEvent dispatch mechanism.
    - kAENoDispatch means ignore the parameter.
      Use this in the case where the event has been handled and no
      redispatch is needed.
    - non nil means call the routine which the dispatcher points to.
}
{ Constants for Refcon in AEResumeTheCurrentEvent with kAEUseStandardDispatch }

CONST
	kAEDoNotIgnoreHandler		= $00000000;
	kAEIgnoreAppPhacHandler		= $00000001;					{  available only in vers 1.0.1 and greater  }
	kAEIgnoreAppEventHandler	= $00000002;					{  available only in vers 1.0.1 and greater  }
	kAEIgnoreSysPhacHandler		= $00000004;					{  available only in vers 1.0.1 and greater  }
	kAEIgnoreSysEventHandler	= $00000008;					{  available only in vers 1.0.1 and greater  }
	kAEIngoreBuiltInEventHandler = $00000010;					{  available only in vers 1.0.1 and greater  }
	kAEDontDisposeOnResume		= $80000000;					{  available only in vers 1.0.1 and greater  }

	{	 Constants for AEResumeTheCurrentEvent 	}
	kAENoDispatch				= 0;							{  dispatch parameter to AEResumeTheCurrentEvent takes a pointer to a dispatch  }
	kAEUseStandardDispatch		= $FFFFFFFF;					{  table, or one of these two constants  }

	{
	 *  AEResumeTheCurrentEvent()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION AEResumeTheCurrentEvent({CONST}VAR theAppleEvent: AppleEvent; {CONST}VAR reply: AppleEvent; dispatcher: AEEventHandlerUPP; handlerRefcon: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0818, $A816;
	{$ENDC}

{
 *  AEGetTheCurrentEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEGetTheCurrentEvent(VAR theAppleEvent: AppleEvent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $021A, $A816;
	{$ENDC}

{
 *  AESetTheCurrentEvent()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AESetTheCurrentEvent({CONST}VAR theAppleEvent: AppleEvent): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $022C, $A816;
	{$ENDC}


{*************************************************************************
  AppleEvent callbacks. 
*************************************************************************}

CONST
	uppAEIdleProcInfo = $00000FD0;
	uppAEFilterProcInfo = $00003FD0;
	{
	 *  NewAEIdleUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewAEIdleUPP(userRoutine: AEIdleProcPtr): AEIdleUPP; { old name was NewAEIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  NewAEFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION NewAEFilterUPP(userRoutine: AEFilterProcPtr): AEFilterUPP; { old name was NewAEFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeAEIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeAEIdleUPP(userUPP: AEIdleUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  DisposeAEFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeAEFilterUPP(userUPP: AEFilterUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeAEIdleUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeAEIdleUPP(VAR theEvent: EventRecord; VAR sleepTime: LONGINT; VAR mouseRgn: RgnHandle; userRoutine: AEIdleUPP): BOOLEAN; { old name was CallAEIdleProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}

{
 *  InvokeAEFilterUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InvokeAEFilterUPP(VAR theEvent: EventRecord; returnID: LONGINT; transactionID: LONGINT; {CONST}VAR sender: AEAddressDesc; userRoutine: AEFilterUPP): BOOLEAN; { old name was CallAEFilterProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $4E90;
	{$ENDC}




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AEInteractionIncludes}

{$ENDC} {__AEINTERACTION__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

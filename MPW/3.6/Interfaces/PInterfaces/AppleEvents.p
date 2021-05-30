{
     File:       AppleEvents.p
 
     Contains:   AppleEvent Package Interfaces.
 
     Version:    Technology: System 7.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1989-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT AppleEvents;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __APPLEEVENTS__}
{$SETC __APPLEEVENTS__ := 1}

{$I+}
{$SETC AppleEventsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __MIXEDMODE__}
{$I MixedMode.p}
{$ENDC}
{
    Note:   The functions and types for the building and parsing AppleEvent  
            messages has moved to AEDataModel.h
}
{$IFC UNDEFINED __AEDATAMODEL__}
{$I AEDataModel.p}
{$ENDC}

{
    Note:   The functions for interacting with events has moved to AEInteraction.h
}
{$IFC UNDEFINED __AEINTERACTION__}
{$I AEInteraction.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  Keywords for Apple event parameters  }
	keyDirectObject				= '----';
	keyErrorNumber				= 'errn';
	keyErrorString				= 'errs';
	keyProcessSerialNumber		= 'psn ';						{  Keywords for special handlers  }
	keyPreDispatch				= 'phac';						{  preHandler accessor call  }
	keySelectProc				= 'selh';						{  more selector call  }
																{  Keyword for recording  }
	keyAERecorderCount			= 'recr';						{  available only in vers 1.0.1 and greater  }
																{  Keyword for version information  }
	keyAEVersion				= 'vers';						{  available only in vers 1.0.1 and greater  }

	{	 Event Class 	}
	kCoreEventClass				= 'aevt';

	{	 Event ID’s 	}
	kAEOpenApplication			= 'oapp';
	kAEOpenDocuments			= 'odoc';
	kAEPrintDocuments			= 'pdoc';
	kAEQuitApplication			= 'quit';
	kAEAnswer					= 'ansr';
	kAEApplicationDied			= 'obit';
	kAEShowPreferences			= 'pref';						{  sent by Mac OS X when the user chooses the Preferences item  }

	{	 Constants for recording 	}
	kAEStartRecording			= 'reca';						{  available only in vers 1.0.1 and greater  }
	kAEStopRecording			= 'recc';						{  available only in vers 1.0.1 and greater  }
	kAENotifyStartRecording		= 'rec1';						{  available only in vers 1.0.1 and greater  }
	kAENotifyStopRecording		= 'rec0';						{  available only in vers 1.0.1 and greater  }
	kAENotifyRecording			= 'recr';						{  available only in vers 1.0.1 and greater  }





	{	
	 * AEEventSource is defined as an SInt8 for compatability with pascal.
	 * Important note: keyEventSourceAttr is returned by AttributePtr as a typeShortInteger.
	 * Be sure to pass at least two bytes of storage to AEGetAttributePtr - the result can be
	 * compared directly against the following enums.
	 	}

TYPE
	AEEventSource 				= SInt8;
CONST
	kAEUnknownSource			= 0;
	kAEDirectCall				= 1;
	kAESameProcess				= 2;
	kAELocalProcess				= 3;
	kAERemoteProcess			= 4;

	{	*************************************************************************
	  These calls are used to set up and modify the event dispatch table.
	*************************************************************************	}
	{
	 *  AEInstallEventHandler()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION AEInstallEventHandler(theAEEventClass: AEEventClass; theAEEventID: AEEventID; handler: AEEventHandlerUPP; handlerRefcon: LONGINT; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $091F, $A816;
	{$ENDC}

{
 *  AERemoveEventHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AERemoveEventHandler(theAEEventClass: AEEventClass; theAEEventID: AEEventID; handler: AEEventHandlerUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0720, $A816;
	{$ENDC}

{
 *  AEGetEventHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEGetEventHandler(theAEEventClass: AEEventClass; theAEEventID: AEEventID; VAR handler: AEEventHandlerUPP; VAR handlerRefcon: LONGINT; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0921, $A816;
	{$ENDC}



{*************************************************************************
  These calls are used to set up and modify special hooks into the
  AppleEvent manager.
*************************************************************************}
{
 *  AEInstallSpecialHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEInstallSpecialHandler(functionClass: AEKeyword; handler: AEEventHandlerUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0500, $A816;
	{$ENDC}

{
 *  AERemoveSpecialHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AERemoveSpecialHandler(functionClass: AEKeyword; handler: AEEventHandlerUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0501, $A816;
	{$ENDC}

{
 *  AEGetSpecialHandler()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEGetSpecialHandler(functionClass: AEKeyword; VAR handler: AEEventHandlerUPP; isSysHandler: BOOLEAN): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $052D, $A816;
	{$ENDC}


{*************************************************************************
  This call was added in version 1.0.1. If called with the keyword
  keyAERecorderCount ('recr'), the number of recorders that are
  currently active is returned in 'result'
  (available only in vers 1.0.1 and greater).
*************************************************************************}
{
 *  AEManagerInfo()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION AEManagerInfo(keyWord: AEKeyword; VAR result: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $0441, $A816;
	{$ENDC}





{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := AppleEventsIncludes}

{$ENDC} {__APPLEEVENTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

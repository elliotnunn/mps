{
     File:       Timer.p
 
     Contains:   Time Manager interfaces.
 
     Version:    Technology: Mac OS 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Timer;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TIMER__}
{$SETC __TIMER__ := 1}

{$I+}
{$SETC TimerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}
{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


CONST
																{  high bit of qType is set if task is active  }
	kTMTaskActive				= $00008000;


TYPE
	TMTaskPtr = ^TMTask;
{$IFC TYPED_FUNCTION_POINTERS}
	TimerProcPtr = PROCEDURE(tmTaskPtr: TMTaskPtr);
{$ELSEC}
	TimerProcPtr = Register68kProcPtr;
{$ENDC}

{$IFC OPAQUE_UPP_TYPES}
	TimerUPP = ^LONGINT; { an opaque UPP }
{$ELSEC}
	TimerUPP = UniversalProcPtr;
{$ENDC}	
	TMTask = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		tmAddr:					TimerUPP;
		tmCount:				LONGINT;
		tmWakeUp:				LONGINT;
		tmReserved:				LONGINT;
	END;

	{
	 *  InsTime()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE InsTime(tmTaskPtr: QElemPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A058;
	{$ENDC}

{
 *  InsXTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InsXTime(tmTaskPtr: QElemPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A458;
	{$ENDC}

{
 *  PrimeTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE PrimeTime(tmTaskPtr: QElemPtr; count: LONGINT);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $205F, $A05A;
	{$ENDC}

{
 *  RmvTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE RmvTime(tmTaskPtr: QElemPtr);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A059;
	{$ENDC}


{ InstallTimeTask, InstallXTimeTask, PrimeTimeTask and RemoveTimeTask work }
{ just like InsTime, InsXTime, PrimeTime, and RmvTime except that they }
{ return an OSErr result. }
{
 *  InstallTimeTask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InstallTimeTask(tmTaskPtr: QElemPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A058, $3E80;
	{$ENDC}

{
 *  InstallXTimeTask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InstallXTimeTask(tmTaskPtr: QElemPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A458, $3E80;
	{$ENDC}

{
 *  PrimeTimeTask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION PrimeTimeTask(tmTaskPtr: QElemPtr; count: LONGINT): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $205F, $A05A, $3E80;
	{$ENDC}

{
 *  RemoveTimeTask()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
 *    CarbonLib:        in CarbonLib 1.0.2 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION RemoveTimeTask(tmTaskPtr: QElemPtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A059, $3E80;
	{$ENDC}


{
 *  Microseconds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE Microseconds(VAR microTickCount: UnsignedWide);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A193, $225F, $22C8, $2280;
	{$ENDC}


CONST
	uppTimerProcInfo = $0000B802;
	{
	 *  NewTimerUPP()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   available as macro/inline
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
FUNCTION NewTimerUPP(userRoutine: TimerProcPtr): TimerUPP; { old name was NewTimerProc }
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2E9F;
	{$ENDC}

{
 *  DisposeTimerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DisposeTimerUPP(userUPP: TimerUPP);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $584F;
	{$ENDC}

{
 *  InvokeTimerUPP()
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE InvokeTimerUPP(tmTaskPtr: TMTaskPtr; userRoutine: TimerUPP); { old name was CallTimerProc }


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TimerIncludes}

{$ENDC} {__TIMER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

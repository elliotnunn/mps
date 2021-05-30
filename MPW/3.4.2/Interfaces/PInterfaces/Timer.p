{
 	File:		Timer.p
 
 	Contains:	Time Manager interfaces.
 
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
 UNIT Timer;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TIMER__}
{$SETC __TIMER__ := 1}

{$I+}
{$SETC TimerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}
{	MixedMode.p													}
{	Memory.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{ high bit of qType is set if task is active }
	kTMTaskActive				= 0+(1 * (2**(15)));

	
TYPE
	TMTaskPtr = ^TMTask;

	{
		TimerProcPtr uses register based parameters on the 68k and cannot
		be written in or called from a high-level language without the help of
		mixed mode or assembly glue.

		In:
		 => tmTaskPtr   	A1.L
	}
	TimerProcPtr = Register68kProcPtr;  { register PROCEDURE Timer(tmTaskPtr: TMTaskPtr); }
	TimerUPP = UniversalProcPtr;

	TMTask = RECORD
		qLink:					QElemPtr;
		qType:					INTEGER;
		tmAddr:					TimerUPP;
		tmCount:				LONGINT;
		tmWakeUp:				LONGINT;
		tmReserved:				LONGINT;
	END;


PROCEDURE InsTime(tmTaskPtr: QElemPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A058;
	{$ENDC}
PROCEDURE InsXTime(tmTaskPtr: QElemPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A458;
	{$ENDC}
PROCEDURE PrimeTime(tmTaskPtr: QElemPtr; count: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $201F, $205F, $A05A;
	{$ENDC}
PROCEDURE RmvTime(tmTaskPtr: QElemPtr);
	{$IFC NOT GENERATINGCFM}
	INLINE $205F, $A059;
	{$ENDC}
PROCEDURE Microseconds(VAR microTickCount: UnsignedWide);
	{$IFC NOT GENERATINGCFM}
	INLINE $A193, $225F, $22C8, $2280;
	{$ENDC}
CONST
	uppTimerProcInfo = $0000B802; { Register PROCEDURE (4 bytes in A1); }

FUNCTION NewTimerProc(userRoutine: TimerProcPtr): TimerUPP;
	{$IFC NOT GENERATINGCFM }
	INLINE $2E9F;
	{$ENDC}

PROCEDURE CallTimerProc(tmTaskPtr: TMTaskPtr; userRoutine: TimerUPP);
	{$IFC NOT GENERATINGCFM}
	{To be implemented:  Glue to move parameters into registers.}
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TimerIncludes}

{$ENDC} {__TIMER__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

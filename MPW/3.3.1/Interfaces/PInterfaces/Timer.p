{
	File:		Timer.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT Timer;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingTimer}
{$SETC UsingTimer := 1}

{$I+}
{$SETC TimerIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$IFC UNDEFINED UsingOSUtils}
{$I $$Shell(PInterfaces)OSUtils.p}
{$ENDC}
{$SETC UsingIncludes := TimerIncludes}

TYPE
TMTaskPtr = ^TMTask;
TMTask = RECORD
    qLink: QElemPtr;
    qType: INTEGER;
    tmAddr: ProcPtr;
    tmCount: LONGINT;
    tmWakeUp: LONGINT;
    tmReserved: LONGINT;
    END;


PROCEDURE InsTime(tmTaskPtr: QElemPtr);
    INLINE $205F,$A058;
PROCEDURE InsXTime(tmTaskPtr: QElemPtr);
    INLINE $205F,$A458;
PROCEDURE PrimeTime(tmTaskPtr: QElemPtr;count: LONGINT);
    INLINE $201F,$205F,$A05A;
PROCEDURE RmvTime(tmTaskPtr: QElemPtr);
    INLINE $205F,$A059;


{$ENDC}    { UsingTimer }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}


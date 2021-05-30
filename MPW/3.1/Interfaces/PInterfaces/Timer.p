{
Created: Tuesday, August 2, 1988 at 11:14 AM
	Timer.p
	Pascal Interface to the Macintosh Libraries

	Copyright Apple Computer, Inc.	1985-1988
	All rights reserved
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
	END;



PROCEDURE InsTime(tmTaskPtr: QElemPtr);
PROCEDURE PrimeTime(tmTaskPtr: QElemPtr;count: LONGINT);
PROCEDURE RmvTime(tmTaskPtr: QElemPtr);

{$ENDC}    { UsingTimer }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}


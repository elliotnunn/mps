{
	File:		ShutDown.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT ShutDown;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingShutDown}
{$SETC UsingShutDown := 1}

{$I+}
{$SETC ShutDownIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$SETC UsingIncludes := ShutDownIncludes}

CONST
sdOnPowerOff = 1;       {call procedure before power off.}
sdOnRestart = 2;        {call procedure before restart.}
sdOnUnmount = 4;        {call procedure before unmounting.}
sdOnDrivers = 8;        {call procedure before closing drivers.}
sdRestartOrPower = 3;   {call before either power off or restart.}

PROCEDURE ShutDwnPower;
    INLINE $3F3C,$0001,$A895;
PROCEDURE ShutDwnStart;
    INLINE $3F3C,$0002,$A895;
PROCEDURE ShutDwnInstall(shutDownProc: ProcPtr;flags: INTEGER);
    INLINE $3F3C,$0003,$A895;
PROCEDURE ShutDwnRemove(shutDownProc: ProcPtr);
    INLINE $3F3C,$0004,$A895;


{$ENDC}    { UsingShutDown }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}


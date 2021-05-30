{
	File:		Signal.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

}

{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Signal;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingSignal}
{$SETC UsingSignal := 1}


TYPE
	SignalMap = 	INTEGER;
	SignalHandler = ^LONGINT;	{ Pointer to function }

CONST
	SIG_ERR =	   -1;			{ Returned by IEsignal on error }
	SIG_IGN =		0;
	SIG_DFL =		1;
	SIG_HOLD =		3;
	SIG_RELEASE =	5;

	SIGABRT =		$0001;
	SIGINT =		$0002;		{ Currently only SIGINT implemented }
	SIGFPE =		$0004;
	SIGILL =		$0008;
	SIGSEGV =		$0010;
	SIGTERM =		$0020;

{ Signal Handling Functions }

FUNCTION
	IEsignal(sigNum: LONGINT; sigHdlr: UNIV SignalHandler):
	SignalHandler; C;

FUNCTION
	IEraise(sigNum: LONGINT):
	LONGINT; C;


{$ENDC} { UsingSignal }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

{
  File: Signal.p

 Copyright Apple Computer, Inc. 1984-1987
 All Rights Reserved

	Signal Handling interface.
	This must be compatible with C's <signal.h>
}

UNIT Signal;

INTERFACE

TYPE
	SignalMap = 	INTEGER;
	SignalHandler = ^LONGINT;	{ Pointer to function }

CONST
	SIG_IGN =		0;

	SIGALLSIGS =	$FFFF;
	SIGKILL =		$0001;
	SIGINT =		$0002;		{ Currently only SIGINT implemented }
	SIGUPDATE = 	$0004;
	SIGADDRERR =	$0008;

{$J+}		{ IMPORTed global in SignalEnv.a }
VAR
	SIG_DFL:		SignalHandler;
{$J-}

{ Signal Handling Functions }

FUNCTION
	IEsigset(sgMap: SignalMap; sigHdlr: UNIV SignalHandler):
	SignalHandler; C;

FUNCTION
	IEsighold(sgMap: SignalMap):
	SignalMap; C;
PROCEDURE
	IEsigrelease(sgMap: SignalMap; prevMap: SignalMap); C;

PROCEDURE
	IEsigpause(sgMap: SignalMap); C;

END.

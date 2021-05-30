{
Created: Thursday, May 25, 1989 at 6:55 PM
	Types.p
	Pascal Interface to the Macintosh Libraries

	Copyright Apple Computer, Inc.	1985-1989
	All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
	UNIT Types;
	INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingTypes}
{$SETC UsingTypes := 1}


CONST
noErr = 0;					{All is well}


TYPE

Byte = 0..255;				{ unsigned byte for fontmgr }

SignedByte = - 128..127;	{ any byte in memory }
Ptr = ^SignedByte;			{ blind pointer }
Handle = ^Ptr;				{ pointer to a master pointer }
VHSelect = (v,h);
Point = RECORD
	CASE INTEGER OF
	  1:
		(v: INTEGER;		{vertical coordinate}
		h: INTEGER);		{horizontal coordinate}
	  2:
		(vh: ARRAY[VHSelect] OF INTEGER);
	END;


Rect = RECORD
	CASE INTEGER OF
	  1:
		(top: INTEGER;
		left: INTEGER;
		bottom: INTEGER;
		right: INTEGER);
	  2:
		(topLeft: Point;
		botRight: Point);
	END;

ProcPtr = Ptr;				{ pointer to a procedure }

Fixed = LONGINT;			{ fixed point arithmatic type }

Fract = LONGINT;

StringPtr = ^Str255;
StringHandle = ^StringPtr;

Str255 = String[255];		{ maximum string size }

Str63 = String[63];

Str31 = String[31];

Str27 = String[27];

Str15 = String[15];

OSErr = INTEGER;			{ error code }

ResType = PACKED ARRAY [1..4] OF CHAR;

OSType = PACKED ARRAY [1..4] OF CHAR;



PROCEDURE Debugger;
	INLINE $A9FF;
PROCEDURE DebugStr(aStr: Str255);
	INLINE $ABFF;
PROCEDURE SysBreak;
	INLINE $303C,$FE16,$A9C9;
PROCEDURE SysBreakStr(debugStr: Str255);
	INLINE $303C,$FE15,$A9C9;
PROCEDURE SysBreakFunc(debugFunc: Str255);
	INLINE $303C,$FE14,$A9C9;

{$ENDC}    { UsingTypes }

{$IFC NOT UsingIncludes}
	END.
{$ENDC}


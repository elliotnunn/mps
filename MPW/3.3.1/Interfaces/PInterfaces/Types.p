{
	File:		Types.p

	Copyright:	© 1983-1993 by Apple Computer, Inc.
				All rights reserved.

	Version:	System 7.1 for ETO #11
	Created:	Tuesday, March 30, 1993 18:00

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

{$IFC UNDEFINED SystemSevenOrLater}
{$SETC SystemSevenOrLater := FALSE}
{$ENDC}

{$IFC UNDEFINED SystemSixOrLater}
{$SETC SystemSixOrLater := SystemSevenOrLater}
{$ENDC}



CONST
noErr = 0;					{All is well}




TYPE
Byte = 0..255;				{ unsigned byte for fontmgr }
SignedByte = - 128..127;	{ any byte in memory }
Ptr = ^SignedByte;
Handle = ^Ptr;				{  pointer to a master pointer }

{$IFC UNDEFINED qMacApp}
IntegerPtr = ^INTEGER;
LongIntPtr = ^LONGINT;
{$ENDC}

Fixed = LONGINT;			{ fixed point arithmatic type }
FixedPtr = ^Fixed;
Fract = LONGINT;
FractPtr = ^Fract;
{$IFC OPTION(MC68881)}
Extended80 = ARRAY [0..4] OF INTEGER;
{$ELSEC}
Extended80 = EXTENDED;
{$ENDC}

VHSelect = (v,h);


ProcPtr = Ptr;				{ pointer to a procedure }

StringPtr = ^Str255;
StringHandle = ^StringPtr;

Str255 = String[255];		{ maximum string size }

Str63 = String[63];

Str32 = String[32];

Str31 = String[31];

Str27 = String[27];

Str15 = String[15];



OSErr = INTEGER;			{ error code }
OSType = PACKED ARRAY [1..4] OF CHAR;
OSTypePtr = ^OSType;
ResType = PACKED ARRAY [1..4] OF CHAR;
ResTypePtr = ^ResType;
ScriptCode = INTEGER;
LangCode = INTEGER;


PointPtr = ^Point;
Point = RECORD
 CASE INTEGER OF
   1:
  (v: INTEGER; 				{vertical coordinate}
  h: INTEGER); 				{horizontal coordinate}
   2:
  (vh: ARRAY[VHSelect] OF INTEGER);
 END;

RectPtr = ^Rect;
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

StyleItem = (bold,italic,underline,outline,shadow,condense,extend);

Style = SET OF StyleItem;



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


{$ENDC} { UsingTypes }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}


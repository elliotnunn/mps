{
 	File:		Types.p
 
 	Contains:	Basic Macintosh data types.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.4
 
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
 UNIT Types;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TYPES__}
{$SETC __TYPES__ := 1}

{$I+}
{$SETC TypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
	noErr						= 0;

	
TYPE
	Byte = 0..255;

	SignedByte = -128..127;

	UInt8 = Byte;

	SInt8 = SignedByte;

	UInt16 = INTEGER;

	SInt16 = INTEGER;

	UInt32 = LONGINT;

	SInt32 = LONGINT;

	UniChar = UInt16;

	ByteParameter = SignedByte;

	Ptr = ^SignedByte;

	Handle = ^Ptr;

{$IFC UNDEFINED qMacApp }
	IntegerPtr = ^INTEGER;

	LongIntPtr = ^LONGINT;

{$ENDC}
	Fixed = LONGINT;

	FixedPtr = ^Fixed;

	Fract = LONGINT;

	FractPtr = ^Fract;

	_extended80 = RECORD
		exp:					INTEGER;
		man:					ARRAY [0..3] OF INTEGER;
	END;

	_extended96 = RECORD
		exp:					ARRAY [0..1] OF INTEGER;
		man:					ARRAY [0..3] OF INTEGER;
	END;

{$IFC GENERATING68K }
{ 
Note: on PowerPC extended is undefined.
      on 68K when mc68881 is on, extended is 96 bits.  
             when mc68881 is off, extended is 80 bits.  
      Some old toolbox routines require an 80 bit extended so we define extended80
}
{$IFC GENERATING68881 }
	extended80 = _extended80;

	extended96 = extended;

{$ELSEC}
	extended80 = extended;

	extended96 = _extended96;

{$ENDC}
{$ELSEC}
	extended80 = _extended80;

	extended96 = _extended96;

{$ENDC}
{
Note: float_t and double_t are "natural" computational types
      (i.e.the compiler/processor can most easily do floating point
	  operations with that type.) 
}
{$IFC GENERATINGPOWERPC }
{ on PowerPC, double = 64-bit which is fastest.  float = 32-bit }
	float_t = Single;

	double_t = Double;

{$IFC NOT UNDEFINED LSPWRP }
	LongDouble = RECORD
		head:					Double;
		tail:					Double;
	END;

{$ENDC}
{$ELSEC}
{ on 68K, long double (a.k.a. extended) is always the fastest.  It is 80 or 96-bits }
	float_t = extended;

	double_t = extended;

{$ENDC}
	wide = RECORD
		hi:						SInt32;
		lo:						UInt32;
	END;

	WidePtr = ^wide;

	UnsignedWide = RECORD
		hi:						UInt32;
		lo:						UInt32;
	END;

	UnsignedWidePtr = ^UnsignedWide;


CONST
	v							= 0;
	h							= 1;

	
TYPE
	VHSelect = SInt8;

	ProcPtr = Ptr;

	Register68kProcPtr = ProcPtr;  { PROCEDURE ; }

	ProcHandle = ^ProcPtr;

	UniversalProcPtr = ProcPtr;
	UniversalProcHandle = ^ProcPtr;

	Str255 = STRING[255];
	Str63 = STRING[63];
	Str32 = STRING[32];
	Str31 = STRING[31];
	Str27 = STRING[27];
	Str15 = STRING[15];

	StringPtr = ^Str255;
	StringHandle = ^StringPtr;

{ A C string is a zero terminated array of bytes.  There is no length byte.
    a CStringPtr is a pointer to a C string (e.g. char* )
    a ConstCStringPtr is a CStringPtr whose contents cannot be changed (e.g. const char* )
}
	CStringPtr = Ptr;
	ConstCStringPtr = Ptr;

	ConstStr255Param = Str255;

	ConstStr63Param = Str63;

	ConstStr32Param = Str32;

	ConstStr31Param = Str31;

	ConstStr27Param = Str27;

	ConstStr15Param = Str15;

	OSErr = INTEGER;

	ScriptCode = INTEGER;

	LangCode = INTEGER;

{$IFC GENERATING68K OR UNDEFINED MWERKS }
	FourCharCode =  PACKED ARRAY [1..4] OF CHAR;
{$ELSEC}
	FourCharCode =  UNSIGNEDLONG;
{$ENDC}
	StyleItem = (bold,italic,underline,outline,shadow,condense,extend);
	Style = SET OF StyleItem;

	OSType = FourCharCode;

	ResType = FourCharCode;

	OSTypePtr = ^OSType;

	ResTypePtr = ^ResType;

	Point = RECORD
		CASE INTEGER OF
		0: (
			v:							INTEGER;
			h:							INTEGER;
		   );
		1: (
			vh:							ARRAY [0..1] OF INTEGER;
		   );
	END;

	PointPtr = ^Point;

	Rect = RECORD
		CASE INTEGER OF
		0: (
			top:						INTEGER;
			left:						INTEGER;
			bottom:						INTEGER;
			right:						INTEGER;
		   );
		1: (
			topLeft:					Point;
			botRight:					Point;
		   );
	END;

	RectPtr = ^Rect;

{
	kVariableLengthArray is used in array bounds to specify a variable length array.
	It is ususally used in variable length structs when the last field is an array
	of any size.  Before ANSI C, we used zero as the bounds of variable length 
	array, but that is illegal in ANSI C.  Example:
	
		struct FooList 
		(
			short 	listLength;
			Foo		elements[kVariableLengthArray];
		);
}

CONST
	kVariableLengthArray		= 1;

{ Numeric version part of 'vers' resource }

TYPE
	NumVersion = PACKED RECORD
		majorRev:				UInt8;									{1st part of version number in BCD}
		minorAndBugRev:			UInt8;									{2nd & 3rd part of version number share a byte}
		stage:					UInt8;									{stage code: dev, alpha, beta, final}
		nonRelRev:				UInt8;									{revision level of non-released version}
	END;

{ 'vers' resource format }
	VersRec = RECORD
		numericVersion:			NumVersion;								{encoded version number}
		countryCode:			INTEGER;								{country code from intl utilities}
		shortVersion:			Str255;									{version number string - worst case}
		reserved:				Str255;									{longMessage string packed after shortVersion}
	END;
	VersRecPtr = ^VersRec;
	VersRecHndl = ^VersRecPtr;

	KernelID 							= ^LONGINT;
	OSStatus							= SInt32;
	LogicalAddress						= Ptr;
	ConstLogicalAddress					= Ptr;
	BytePtr								= ^UInt8;
	ByteCount							= UInt32;
	ByteOffset							= UInt32;
	ItemCount							= UInt32;
	PhysicalAddress						= Ptr;
	OptionBits							= UInt32;
	PBVersion							= UInt32;
	Duration							= SInt32;
	AbsoluteTime						= UnsignedWide;
	AbsoluteTimePtr 					= ^AbsoluteTime;

CONST
	kInvalidID							= 0;
	
{
	Who implements what debugger functions:
	
	Name			MacsBug				SADE		Macintosh Debugger
	----------		-----------			-------		-----------------------------
	Debugger		yes					no			InterfaceLib maps to DebugStr
	DebugStr		yes					no			yes
	Debugger68k		yes					no			InterfaceLib maps to DebugStr
	DebugStr68k		yes					no			InterfaceLib maps to DebugStr
	debugstr		yes					no			InterfaceLib maps to DebugStr
	SysBreak		no, for SADE		yes			InterfaceLib maps to SysError
	SysBreakStr		no, for SADE		yes			InterfaceLib maps to SysError
	SysBreakFunc	no, for SADE		yes			InterfaceLib maps to SysError

}

PROCEDURE Debugger;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9FF;
	{$ENDC}
PROCEDURE DebugStr(debuggerMsg: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $ABFF;
	{$ENDC}
PROCEDURE Debugger68k;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9FF;
	{$ENDC}
PROCEDURE DebugStr68k(debuggerMsg: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $ABFF;
	{$ENDC}
PROCEDURE SysBreak;
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $FE16, $A9C9;
	{$ENDC}
PROCEDURE SysBreakStr(debuggerMsg: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $FE15, $A9C9;
	{$ENDC}
PROCEDURE SysBreakFunc(debuggerMsg: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $303C, $FE14, $A9C9;
	{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TypesIncludes}

{$ENDC} {__TYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

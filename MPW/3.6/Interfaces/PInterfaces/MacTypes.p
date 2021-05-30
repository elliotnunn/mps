{
     File:       MacTypes.p
 
     Contains:   Basic Macintosh data types.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1985-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT MacTypes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MACTYPES__}
{$SETC __MACTYPES__ := 1}

{$I+}
{$SETC MacTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


{*******************************************************************************

    Base integer types for all target OS's and CPU's
    
        UInt8            8-bit unsigned integer 
        SInt8            8-bit signed integer
        UInt16          16-bit unsigned integer 
        SInt16          16-bit signed integer           
        UInt32          32-bit unsigned integer 
        SInt32          32-bit signed integer   
        UInt64          64-bit unsigned integer 
        SInt64          64-bit signed integer   

********************************************************************************}
TYPE
    SInt8                               = -128..127;
    SInt16                              = INTEGER;
    SInt32                              = LONGINT;
{$IFC NOT UNDEFINED MWERKS}
    UInt8                               = 0..255;       { UNISIGNEDBYTE }
    UInt16                              = UNSIGNEDWORD;
    UInt32                              = UNSIGNEDLONG;
{$ELSEC}
    UInt8                               = 0..255;
    UInt16                              = INTEGER;
    UInt32                              = LONGINT;
{$ENDC}

{$IFC TARGET_RT_BIG_ENDIAN }

TYPE
	widePtr = ^wide;
	wide = RECORD
		hi:						SInt32;
		lo:						UInt32;
	END;

	UnsignedWidePtr = ^UnsignedWide;
	UnsignedWide = RECORD
		hi:						UInt32;
		lo:						UInt32;
	END;

{$ELSEC}

TYPE
	wide = RECORD
		lo:						UInt32;
		hi:						SInt32;
	END;

    widePtr = ^wide;
    UnsignedWidePtr = ^UnsignedWide;
	UnsignedWide = RECORD
		lo:						UInt32;
		hi:						UInt32;
	END;

{$ENDC}  {TARGET_RT_BIG_ENDIAN}

	SInt64								= wide;
	SInt64Ptr 							= ^SInt64;
	UInt64								= UnsignedWide;
	UInt64Ptr 							= ^UInt64;
	{	*******************************************************************************
	
	    Special types for pascal
	    
	        IntegerPtr          Pointer to a 16-bit integer
	        LongIntPtr          Pointer to a 16-bit integer
	        ByteParameter       UInt8 passed as an 8-bit parameter
	        
	    Note:   The conventions for Pascal on 68K require that a UInt8 when
	            passed as a parameter occupy 16-bits on the stack, whereas 
	            an SInt8 would only occupy 8-bits.  To make C and Pascal
	            compatable, in pascal all function parameters of type UInt8
	            or equivalent are changed to ByteParameter.
	
	********************************************************************************	}
	IntegerPtr							= ^INTEGER;
	LongIntPtr							= ^LONGINT;
    ByteParameter                       = SInt8;


	{	*******************************************************************************
	
	    Base fixed point types 
	    
	        Fixed           16-bit signed integer plus 16-bit fraction
	        UnsignedFixed   16-bit unsigned integer plus 16-bit fraction
	        Fract           2-bit signed integer plus 30-bit fraction
	        ShortFixed      8-bit signed integer plus 8-bit fraction
	        
	********************************************************************************	}
	Fixed								= LONGINT;
	FixedPtr							= ^Fixed;
	Fract								= LONGINT;
	FractPtr							= ^Fract;
	UnsignedFixed						= UInt32;
	UnsignedFixedPtr					= ^UnsignedFixed;
	ShortFixed							= INTEGER;
	ShortFixedPtr						= ^ShortFixed;


	{	*******************************************************************************
	
	    Base floating point types 
	    
	        Float32         32 bit IEEE float:  1 sign bit, 8 exponent bits, 23 fraction bits
	        Float64         64 bit IEEE float:  1 sign bit, 11 exponent bits, 52 fraction bits  
	        Float80         80 bit MacOS float: 1 sign bit, 15 exponent bits, 1 integer bit, 63 fraction bits
	        Float96         96 bit 68881 float: 1 sign bit, 15 exponent bits, 16 pad bits, 1 integer bit, 63 fraction bits
	        
	    Note: These are fixed size floating point types, useful when writing a floating
	          point value to disk.  If your compiler does not support a particular size 
	          float, a struct is used instead.
	          Use of of the NCEG types (e.g. double_t) or an ANSI C type (e.g. double) if
	          you want a floating point representation that is natural for any given
	          compiler, but might be a different size on different compilers.
	
	********************************************************************************	}
TYPE
    Float32 =   SINGLE;
    Float64 =   DOUBLE;
{$IFC TARGET_CPU_68K}
    {$IFC TARGET_RT_MAC_68881 }
        Float96 = EXTENDED;
        Float80 = RECORD
            exp:    SInt16;
            man:    ARRAY [0..3] OF UInt16;
        END;
    {$ELSEC}
        Float80 = EXTENDED;
        Float96 = RECORD
            exp:    SInt16;
            filler: INTEGER;
            man:    ARRAY [0..3] OF UInt16;
        END;
    {$ENDC}
{$ELSEC}
    Float80 = RECORD
        exp:    SInt16;
        man:    ARRAY [0..3] OF UInt16;
    END;
    Float96 = RECORD
        exp:    SInt16;
        filler: INTEGER;
        man:    ARRAY [0..3] OF UInt16;
    END;
{$ENDC}
Float32Point = RECORD
    x:  Float32;
    y:  Float32;
END;

	{	*******************************************************************************
	
	    MacOS Memory Manager types
	    
	        Ptr             Pointer to a non-relocatable block
	        Handle          Pointer to a master pointer to a relocatable block
	        Size            The number of bytes in a block (signed for historical reasons)
	        
	********************************************************************************	}
	Ptr									= ^SInt8;
	Handle								= ^Ptr;
	Size								= LONGINT;

	{	*******************************************************************************
	
	    Higher level basic types
	    
	        OSErr                   16-bit result error code
	        OSStatus                32-bit result error code
	        LogicalAddress          Address in the clients virtual address space
	        ConstLogicalAddress     Address in the clients virtual address space that will only be read
	        PhysicalAddress         Real address as used on the hardware bus
	        BytePtr                 Pointer to an array of bytes
	        ByteCount               The size of an array of bytes
	        ByteOffset              An offset into an array of bytes
	        ItemCount               32-bit iteration count
	        OptionBits              Standard 32-bit set of bit flags
	        PBVersion               ?
	        Duration                32-bit millisecond timer for drivers
	        AbsoluteTime            64-bit clock
	        ScriptCode              A particular set of written characters (e.g. Roman vs Cyrillic) and their encoding
	        LangCode                A particular language (e.g. English), as represented using a particular ScriptCode
	        RegionCode              Designates a language as used in a particular region (e.g. British vs American
	                                English) together with other region-dependent characteristics (e.g. date format)
	        FourCharCode            A 32-bit value made by packing four 1 byte characters together
	        OSType                  A FourCharCode used in the OS and file system (e.g. creator)
	        ResType                 A FourCharCode used to tag resources (e.g. 'DLOG')
	        
	********************************************************************************	}
	OSErr								= SInt16;
	OSStatus							= SInt32;
	LogicalAddress						= Ptr;
	ConstLogicalAddress					= Ptr;
	PhysicalAddress						= Ptr;
	BytePtr								= ^UInt8;
	ByteCount							= UInt32;
	ByteOffset							= UInt32;
	Duration							= SInt32;
	AbsoluteTime						= UnsignedWide;
	AbsoluteTimePtr 					= ^AbsoluteTime;
	OptionBits							= UInt32;
	ItemCount							= UInt32;
	PBVersion							= UInt32;
	ScriptCode							= SInt16;
	LangCode							= SInt16;
	RegionCode							= SInt16;
{$IFC NOT UNDEFINED MWERKS }
    {$IFC TARGET_CPU_68K }
        {Use array version of FourCharCode for compatibility with old 68k apps.}
        FourCharCode                    = PACKED ARRAY [1..4] OF CHAR;
    {$ELSEC}
        FourCharCode                    = UNSIGNEDLONG;
    {$ENDC}
{$ELSEC}
    FourCharCode                        = PACKED ARRAY [1..4] OF CHAR;
{$ENDC}
	OSType								= FourCharCode;
	ResType								= FourCharCode;
	OSTypePtr							= ^OSType;
	ResTypePtr							= ^ResType;

	{	*******************************************************************************
	
	    Boolean types and values
	    
	        Boolean         A one byte value, holds "false" (0) or "true" (1)
	        false           The Boolean value of zero (0)
	        true            The Boolean value of one (1)
	        
	********************************************************************************	}
{ "Boolean", "true", and "false" are built into the Pascal language }
	{	*******************************************************************************
	
	    Function Pointer Types
	    
	        ProcPtr                 Generic pointer to a function
	        Register68kProcPtr      Pointer to a 68K function that expects parameters in registers
	        UniversalProcPtr        Pointer to classic 68K code or a RoutineDescriptor
	        
	        ProcHandle              Pointer to a ProcPtr
	        UniversalProcHandle     Pointer to a UniversalProcPtr
	        
	********************************************************************************	}
    ProcPtr                             = Ptr;
    Register68kProcPtr                  = ProcPtr;
	{	 UniversalProcPtr is ^RoutineDescriptor on a PowerPC machine 	}
	UniversalProcPtr					= ProcPtr;
	ProcHandle							= ^ProcPtr;
	UniversalProcHandle					= ^UniversalProcPtr;


	{	*******************************************************************************
	
	    Common Constants
	    
	        noErr                   OSErr: function performed properly - no error
	        kNilOptions             OptionBits: all flags false
	        kInvalidID              KernelID: NULL is for pointers as kInvalidID is for ID's
	        kVariableLengthArray    array bounds: variable length array
	
	    Note: kVariableLengthArray is used in array bounds to specify a variable length array.
	          It is ususally used in variable length structs when the last field is an array
	          of any size.  Before ANSI C, we used zero as the bounds of variable length 
	          array, but zero length array are illegal in ANSI C.  Example usage:
	    
	        struct FooList 
	        (
	            short   listLength;
	            Foo     elements[kVariableLengthArray];
	        );
	        
	********************************************************************************	}

CONST
	noErr						= 0;

	kNilOptions					= 0;

	kInvalidID					= 0;

	kVariableLengthArray		= 1;

	kUnknownType				= $3F3F3F3F;					{  "????" QuickTime 3.0: default unknown ResType or OSType  }



	{	*******************************************************************************
	
	    String Types and Unicode Types
	    
	        UnicodeScalarValue,     A complete Unicode character in UTF-32 format, with
	        UTF32Char               values from 0 through 0x10FFFF (excluding the surrogate
	                                range 0xD800-0xDFFF and certain disallowed values).
	
	        UniChar,                A 16-bit Unicode code value in the default UTF-16 format.
	        UTF16Char               UnicodeScalarValues 0-0xFFFF are expressed in UTF-16
	                                format using a single UTF16Char with the same value.
	                                UnicodeScalarValues 0x10000-0x10FFFF are expressed in
	                                UTF-16 format using a pair of UTF16Chars - one in the
	                                high surrogate range (0xD800-0xDBFF) followed by one in
	                                the low surrogate range (0xDC00-0xDFFF). All of the
	                                characters defined in Unicode versions through 3.0 are
	                                in the range 0-0xFFFF and can be expressed using a single
	                                UTF16Char, thus the term "Unicode character" generally
	                                refers to a UniChar = UTF16Char.
	
	        UTF8Char                An 8-bit code value in UTF-8 format. UnicodeScalarValues
	                                0-0x7F are expressed in UTF-8 format using one UTF8Char
	                                with the same value. UnicodeScalarValues above 0x7F are
	                                expressed in UTF-8 format using 2-4 UTF8Chars, all with
	                                values in the range 0x80-0xF4 (UnicodeScalarValues
	                                0x100-0xFFFF use two or three UTF8Chars,
	                                UnicodeScalarValues 0x10000-0x10FFFF use four UTF8Chars).
	
	        UniCharCount            A count of UTF-16 code values in an array or buffer.
	
	        StrNNN                  Pascal string holding up to NNN bytes
	        StringPtr               Pointer to a pascal string
	        StringHandle            Pointer to a StringPtr
	        ConstStringPtr          Pointer to a read-only pascal string
	        ConstStrNNNParam        For function parameters only - means string is const
	        
	        CStringPtr              Pointer to a C string           (in C:  char*)
	        ConstCStringPtr         Pointer to a read-only C string (in C:  const char*)
	        
	    Note: The length of a pascal string is stored as the first byte.
	          A pascal string does not have a termination byte.
	          A pascal string can hold at most 255 bytes of data.
	          The first character in a pascal string is offset one byte from the start of the string. 
	          
	          A C string is terminated with a byte of value zero.  
	          A C string has no length limitation.
	          The first character in a C string is the zeroth byte of the string. 
	          
	        
	********************************************************************************	}

TYPE
	UnicodeScalarValue					= UInt32;
	UTF32Char							= UInt32;
	UniChar								= UInt16;
	UTF16Char							= UInt16;
	UTF8Char							= UInt8;
	UniCharPtr							= ^UniChar;
	UniCharCount						= UInt32;
	UniCharCountPtr						= ^UniCharCount;
	Str255								= STRING[255];
	Str63								= STRING[63];
	Str32								= STRING[32];
	Str31								= STRING[31];
	Str27								= STRING[27];
	Str15								= STRING[15];
	{	
	    The type Str32 is used in many AppleTalk based data structures.
	    It holds up to 32 one byte chars.  The problem is that with the
	    length byte it is 33 bytes long.  This can cause weird alignment
	    problems in structures.  To fix this the type "Str32Field" has
	    been created.  It should only be used to hold 32 chars, but
	    it is 34 bytes long so that there are no alignment problems.
		}
    Str32Field = Str32;
	{	
	    QuickTime 3.0:
	    The type StrFileName is used to make MacOS structs work 
	    cross-platform.  For example FSSpec or SFReply previously
	    contained a Str63 field.  They now contain a StrFileName
	    field which is the same when targeting the MacOS but is
	    a 256 char buffer for Win32 and unix, allowing them to
	    contain long file names.
		}
{$IFC TARGET_OS_MAC }
	StrFileName							= Str63;
{$ELSEC}
	StrFileName							= Str255;
{$ENDC}  {TARGET_OS_MAC}

	StringPtr							= ^Str255;
	StringHandle						= ^StringPtr;
	ConstStringPtr						= StringPtr;
	CStringPtr							= Ptr;
	CStringPtrPtr						= ^CStringPtr;
	ConstCStringPtr						= Ptr;
	ConstCStringPtrPtr					= ^ConstCStringPtr;
	ConstStr255Param					= Str255;
	ConstStr63Param						= Str63;
	ConstStr32Param						= Str32;
	ConstStr31Param						= Str31;
	ConstStr27Param						= Str27;
	ConstStr15Param						= Str15;
{$IFC TARGET_OS_MAC }
	ConstStrFileNameParam				= Str63;
{$ELSEC}
	ConstStrFileNameParam				= Str255;
{$ENDC}  {TARGET_OS_MAC}

	{	*******************************************************************************
	
	    Quickdraw Types
	    
	        Point               2D Quickdraw coordinate, range: -32K to +32K
	        Rect                Rectangular Quickdraw area
	        Style               Quickdraw font rendering styles
	        StyleParameter      Style when used as a parameter (historical 68K convention)
	        StyleField          Style when used as a field (historical 68K convention)
	        CharParameter       Char when used as a parameter (historical 68K convention)
	        
	    Note:   The original Macintosh toolbox in 68K Pascal defined Style as a SET.  
	            Both Style and CHAR occupy 8-bits in packed records or 16-bits when 
	            used as fields in non-packed records or as parameters. 
	        
	********************************************************************************	}
	PointPtr = ^Point;
	Point = RECORD
		CASE INTEGER OF
		0: (
			v:					INTEGER;
			h:					INTEGER;
		   );
		1: (
			vh:					ARRAY [0..1] OF INTEGER;
			);
	END;

	RectPtr = ^Rect;
	Rect = RECORD
		CASE INTEGER OF
		0: (
			top:				INTEGER;
			left:				INTEGER;
			bottom:				INTEGER;
			right:				INTEGER;
		   );
		1: (
			topLeft:			Point;
			botRight:			Point;
		   );
	END;

	FixedPointPtr = ^FixedPoint;
	FixedPoint = RECORD
		x:						Fixed;
		y:						Fixed;
	END;

	FixedRectPtr = ^FixedRect;
	FixedRect = RECORD
		left:					Fixed;
		top:					Fixed;
		right:					Fixed;
		bottom:					Fixed;
	END;

    CharParameter = CHAR;

    StyleItem = (bold,italic,underline,outline,shadow,condense,extend);
    Style = SET OF StyleItem;

    StyleParameter = Style;

    StyleField = Style;


	{	*******************************************************************************
	
	    QuickTime TimeBase types (previously in Movies.h)
	    
	        TimeValue           Count of units
	        TimeScale           Units per second
	        CompTimeValue       64-bit count of units (always a struct) 
	        TimeValue64         64-bit count of units (long long or struct) 
	        TimeBase            An opaque reference to a time base
	        TimeRecord          Package of TimeBase, duration, and scale
	        
	********************************************************************************	}
	TimeValue							= LONGINT;
	TimeScale							= LONGINT;
	CompTimeValue						= wide;
	CompTimeValuePtr 					= ^CompTimeValue;
	TimeValue64							= SInt64;
	TimeValue64Ptr 						= ^TimeValue64;
	TimeBase    = ^LONGINT; { an opaque 32-bit type }
	TimeBasePtr = ^TimeBase;  { when a VAR xx:TimeBase parameter can be nil, it is changed to xx: TimeBasePtr }
	TimeRecordPtr = ^TimeRecord;
	TimeRecord = RECORD
		value:					CompTimeValue;							{  units (duration or absolute)  }
		scale:					TimeScale;								{  units per second  }
		base:					TimeBase;								{  refernce to the time base  }
	END;




	{	*******************************************************************************
	
	    MacOS versioning structures
	    
	        VersRec                 Contents of a 'vers' resource
	        VersRecPtr              Pointer to a VersRecPtr
	        VersRecHndl             Resource Handle containing a VersRec
	        NumVersion              Packed BCD version representation (e.g. "4.2.1a3" is 0x04214003)
	        UniversalProcPtr        Pointer to classic 68K code or a RoutineDescriptor
	        
	        ProcHandle              Pointer to a ProcPtr
	        UniversalProcHandle     Pointer to a UniversalProcPtr
	        
	********************************************************************************	}
{$IFC TARGET_RT_BIG_ENDIAN }
	NumVersionPtr = ^NumVersion;
	NumVersion = PACKED RECORD
																		{  Numeric version part of 'vers' resource  }
		majorRev:				UInt8;									{ 1st part of version number in BCD }
		minorAndBugRev:			UInt8;									{ 2nd & 3rd part of version number share a byte }
		stage:					UInt8;									{ stage code: dev, alpha, beta, final }
		nonRelRev:				UInt8;									{ revision level of non-released version }
	END;

{$ELSEC}
	NumVersion = PACKED RECORD
																		{  Numeric version part of 'vers' resource accessable in little endian format  }
		nonRelRev:				UInt8;									{ revision level of non-released version }
		stage:					UInt8;									{ stage code: dev, alpha, beta, final }
		minorAndBugRev:			UInt8;									{ 2nd & 3rd part of version number share a byte }
		majorRev:				UInt8;									{ 1st part of version number in BCD }
	END;

{$ENDC}  {TARGET_RT_BIG_ENDIAN}


CONST
																{  Version Release Stage Codes  }
	developStage				= $20;
	alphaStage					= $40;
	betaStage					= $60;
	finalStage					= $80;


TYPE
	NumVersionVariantPtr = ^NumVersionVariant;
	NumVersionVariant = RECORD
		CASE INTEGER OF
																		{  NumVersionVariant is a wrapper so NumVersion can be accessed as a 32-bit value  }
		0: (
			parts:				NumVersion;
			);
		1: (
			whole:				UInt32;
			);
	END;

	NumVersionVariantHandle				= ^NumVersionVariantPtr;
	VersRecPtr = ^VersRec;
	VersRec = RECORD
																		{  'vers' resource format  }
		numericVersion:			NumVersion;								{ encoded version number }
		countryCode:			INTEGER;								{ country code from intl utilities }
		shortVersion:			Str255;									{ version number string - worst case }
		reserved:				Str255;									{ longMessage string packed after shortVersion }
	END;

	VersRecHndl							= ^VersRecPtr;
	{	********************************************************************************
	
	    Old names for types
	        
	********************************************************************************	}
	Byte								= UInt8;
	SignedByte							= SInt8;
	extended80							= Float80;
	extended80Ptr 						= ^extended80;
	extended96							= Float96;
	extended96Ptr 						= ^extended96;
	VHSelect							= SInt8;
	SinglePtr							= ^Single;
	{	********************************************************************************
	
	    Debugger functions
	    
	********************************************************************************	}
	{
	 *  Debugger()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE Debugger;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $A9FF;
	{$ENDC}

{
 *  DebugStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DebugStr(debuggerMsg: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $ABFF;
	{$ENDC}

{$IFC TARGET_OS_MAC }
{$IFC TARGET_CPU_PPC }
{ Only for Mac OS native drivers }
{$IFC CALL_NOT_IN_CARBON }
{
 *  SysDebug()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SysDebug; C;

{
 *  SysDebugStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in DriverServicesLib 1.0 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE SysDebugStr(str: Str255); C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_CPU_PPC}
{ SADE break points }
{
 *  SysBreak()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SysBreak;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $FE16, $A9C9;
	{$ENDC}

{
 *  SysBreakStr()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SysBreakStr(debuggerMsg: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $FE15, $A9C9;
	{$ENDC}

{
 *  SysBreakFunc()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SysBreakFunc(debuggerMsg: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $303C, $FE14, $A9C9;
	{$ENDC}

{$IFC CALL_NOT_IN_CARBON }
{
 *  Debugger68k()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE Debugger68k;

{
 *  DebugStr68k()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE DebugStr68k(debuggerMsg: Str255);

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TARGET_OS_MAC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := MacTypesIncludes}

{$ENDC} {__MACTYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

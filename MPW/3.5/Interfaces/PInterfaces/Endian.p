{
     File:       Endian.p
 
     Contains:   QuickTime Interfaces
 
     Version:    Technology: QuickTime 3.0
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1997-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Endian;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __ENDIAN__}
{$SETC __ENDIAN__ := 1}

{$I+}
{$SETC EndianIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
    This file provides Endian Flipping routines for dealing with converting data
    between Big-Endian and Little-Endian machines.  These routines are useful
    when writing code to compile for both Big and Little Endian machines and  
    which must handle other endian number formats, such as reading or writing 
    to a file or network packet.
    
    These routines are named as follows:
    
        Endian<U><W>_<S>to<D>

    where
        <U> is whether the integer is signed ('S') or unsigned ('U')
        <W> is integer bit width: 16, 32, or 64 
        <S> is the source endian format: 'B' for big, 'L' for little, or 'N' for native
        <D> is the destination endian format: 'B' for big, 'L' for little, or 'N' for native
    
    For example, to convert a Big Endian 32-bit unsigned integer to the current native format use:
        
        long i = EndianU32_BtoN(data);
        
    This file is set up so that the function macro to nothing when the target runtime already
    is the desired format (e.g. on Big Endian machines, EndianU32_BtoN() macros away).
            
    If long long's are not supported, you cannot get 64-bit quantities as a single value.
    The macros are not defined in that case.
    
    
    
                                <<< W A R N I N G >>>
    
    It is very important not to put any autoincrements inside the macros.  This 
    will produce erroneous results because each time the address is accessed in the macro, 
    the increment occurs.
    
 }
{
   Note: These functions are currently not implemented in any library
         and are only listed here as function prototypes to document the macros
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  EndianS16_BtoN()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS16_BtoN(value: SInt16): SInt16; C;

{
 *  EndianS16_NtoB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS16_NtoB(value: SInt16): SInt16; C;

{
 *  EndianS16_LtoN()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS16_LtoN(value: SInt16): SInt16; C;

{
 *  EndianS16_NtoL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS16_NtoL(value: SInt16): SInt16; C;

{
 *  EndianS16_LtoB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS16_LtoB(value: SInt16): SInt16; C;

{
 *  EndianS16_BtoL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS16_BtoL(value: SInt16): SInt16; C;

{
 *  EndianU16_BtoN()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU16_BtoN(value: UInt16): UInt16; C;

{
 *  EndianU16_NtoB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU16_NtoB(value: UInt16): UInt16; C;

{
 *  EndianU16_LtoN()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU16_LtoN(value: UInt16): UInt16; C;

{
 *  EndianU16_NtoL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU16_NtoL(value: UInt16): UInt16; C;

{
 *  EndianU16_LtoB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU16_LtoB(value: UInt16): UInt16; C;

{
 *  EndianU16_BtoL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU16_BtoL(value: UInt16): UInt16; C;

{
 *  EndianS32_BtoN()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS32_BtoN(value: SInt32): SInt32; C;

{
 *  EndianS32_NtoB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS32_NtoB(value: SInt32): SInt32; C;

{
 *  EndianS32_LtoN()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS32_LtoN(value: SInt32): SInt32; C;

{
 *  EndianS32_NtoL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS32_NtoL(value: SInt32): SInt32; C;

{
 *  EndianS32_LtoB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS32_LtoB(value: SInt32): SInt32; C;

{
 *  EndianS32_BtoL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS32_BtoL(value: SInt32): SInt32; C;

{
 *  EndianU32_BtoN()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU32_BtoN(value: UInt32): UInt32; C;

{
 *  EndianU32_NtoB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU32_NtoB(value: UInt32): UInt32; C;

{
 *  EndianU32_LtoN()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU32_LtoN(value: UInt32): UInt32; C;

{
 *  EndianU32_NtoL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU32_NtoL(value: UInt32): UInt32; C;

{
 *  EndianU32_LtoB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU32_LtoB(value: UInt32): UInt32; C;

{
 *  EndianU32_BtoL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU32_BtoL(value: UInt32): UInt32; C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC NOT TYPE_LONGLONG }
{
   Note: If these Int64 functions ever were implemented in a library,
         we would need two libraries, one for compilers that
         support long long and one for other compilers.
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  EndianS64_BtoN()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS64_BtoN(value: SInt64): SInt64; C;

{
 *  EndianS64_NtoB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS64_NtoB(value: SInt64): SInt64; C;

{
 *  EndianS64_LtoN()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS64_LtoN(value: SInt64): SInt64; C;

{
 *  EndianS64_NtoL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS64_NtoL(value: SInt64): SInt64; C;

{
 *  EndianS64_LtoB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS64_LtoB(value: SInt64): SInt64; C;

{
 *  EndianS64_BtoL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianS64_BtoL(value: SInt64): SInt64; C;

{
 *  EndianU64_BtoN()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU64_BtoN(value: UInt64): UInt64; C;

{
 *  EndianU64_NtoB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU64_NtoB(value: UInt64): UInt64; C;

{
 *  EndianU64_LtoN()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU64_LtoN(value: UInt64): UInt64; C;

{
 *  EndianU64_NtoL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU64_NtoL(value: UInt64): UInt64; C;

{
 *  EndianU64_LtoB()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU64_LtoB(value: UInt64): UInt64; C;

{
 *  EndianU64_BtoL()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION EndianU64_BtoL(value: UInt64): UInt64; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}

{
   These types are used for structures that contain data that is
   always in BigEndian format.  This extra typing prevents little
   endian code from directly changing the data, thus saving much
   time in the debugger.
}

{$IFC TARGET_RT_LITTLE_ENDIAN }

TYPE
	BigEndianLongPtr = ^BigEndianLong;
	BigEndianLong = RECORD
		bigEndianValue:			LONGINT;
	END;

	BigEndianUnsignedLongPtr = ^BigEndianUnsignedLong;
	BigEndianUnsignedLong = RECORD
		bigEndianValue:			UInt32;
	END;

	BigEndianShortPtr = ^BigEndianShort;
	BigEndianShort = RECORD
		bigEndianValue:			INTEGER;
	END;

	BigEndianUnsignedShortPtr = ^BigEndianUnsignedShort;
	BigEndianUnsignedShort = RECORD
		bigEndianValue:			UInt16;
	END;

	BigEndianFixedPtr = ^BigEndianFixed;
	BigEndianFixed = RECORD
		bigEndianValue:			Fixed;
	END;

	BigEndianUnsignedFixedPtr = ^BigEndianUnsignedFixed;
	BigEndianUnsignedFixed = RECORD
		bigEndianValue:			UnsignedFixed;
	END;

	BigEndianOSTypePtr = ^BigEndianOSType;
	BigEndianOSType = RECORD
		bigEndianValue:			OSType;
	END;

{$ELSEC}

TYPE
	BigEndianLong						= LONGINT;
	BigEndianUnsignedLong				= UInt32;
	BigEndianShort						= INTEGER;
	BigEndianUnsignedShort				= UInt16;
	BigEndianFixed						= Fixed;
	BigEndianUnsignedFixed				= UnsignedFixed;
	BigEndianOSType						= OSType;
{$ENDC}  {TARGET_RT_LITTLE_ENDIAN}





	{	
	    Implement low level ≈_Swap functions.
	    
	        extern UInt16 Endian16_Swap(UInt16 value);
	        extern UInt32 Endian32_Swap(UInt32 value);
	        extern UInt64 Endian64_Swap(UInt64 value);
	        
	    Note: Depending on the processor, you might want to implement
	          these as function calls instead of macros.
	    
		}
{$IFC CALL_NOT_IN_CARBON }
	{
	 *  Endian16_Swap()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        not available
	 *    Mac OS X:         not available
	 	}
FUNCTION Endian16_Swap(value: UInt16): UInt16;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $301F, $E158, $3E80;
	{$ENDC}

{
 *  Endian32_Swap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Endian32_Swap(value: UInt32): UInt32;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $E158, $4840, $E158, $2E80;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC TYPE_LONGLONG }
{$ELSEC}
{ 
    Note: When using compilers that don't support "long long",
          Endian64_Swap must be implemented as glue. 
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  Endian64_Swap()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION Endian64_Swap(value: UInt64): UInt64; C;

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {TYPE_LONGLONG}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := EndianIncludes}

{$ENDC} {__ENDIAN__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

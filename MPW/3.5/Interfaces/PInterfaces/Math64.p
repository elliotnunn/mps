{
     File:       Math64.p
 
     Contains:   64-bit integer math Interfaces.
 
     Version:    Technology: Mac OS 9
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Math64;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MATH64__}
{$SETC __MATH64__ := 1}

{$I+}
{$SETC Math64Includes := UsingIncludes}
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
 *  S64Max()
 *  
 *  Discussion:
 *    Returns largest possible SInt64 value
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64Max: SInt64; C;

{
 *  S64Min()
 *  
 *  Discussion:
 *    Returns smallest possible SInt64 value
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64Min: SInt64; C;


{
 *  S64Add()
 *  
 *  Discussion:
 *    Adds two integers, producing an integer result.  If an overflow
 *    occurs the result is congruent mod (2^64) as if the operands and
 *    result were unsigned.  No overflow is signaled.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64Add(left: SInt64; right: SInt64): SInt64; C;


{
 *  S64Subtract()
 *  
 *  Discussion:
 *    Subtracts two integers, producing an integer result.  If an
 *    overflow occurs the result is congruent mod (2^64) as if the
 *    operands and result were unsigned.  No overflow is signaled.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64Subtract(left: SInt64; right: SInt64): SInt64; C;


{
 *  S64Negate()
 *  
 *  Discussion:
 *    Returns the additive inverse of a signed number (i.e. it returns
 *    0 - the number).  S64Negate (S64Min) is not representable (in
 *    fact, it returns S64Min).
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64Negate(value: SInt64): SInt64; C;


{$IFC NOT TYPE_LONGLONG }
{
 *  S64Absolute()
 *  
 *  Discussion:
 *    Returns the absolute value of the number (i.e. the number if it
 *    is positive, or 0 - the number if it is negative). Disabled for
 *    compilers that support long long until llabs() is available
 *    everywhere.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64Absolute(value: SInt64): SInt64; C;

{$ENDC}

{
 *  S64Multiply()
 *  
 *  Discussion:
 *    Multiplies two signed numbers, producing a signed result. 
 *    Overflow is ignored and the low-order part of the product is
 *    returned.  The sign of the result is not guaranteed to be correct
 *    if the magnitude of the product is not representable.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64Multiply(left: SInt64; right: SInt64): SInt64; C;


{$IFC CALL_NOT_IN_CARBON }
{
 *  S64Mod()
 *  
 *  Discussion:
 *    Returns the remainder of divide of dividend by divisor.  The sign
 *    of the remainder is the same as the sign of the dividend (i.e.,
 *    it takes the absolute values of the operands, does the division,
 *    then fixes the sign of the quotient and remainder).
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION S64Mod(dividend: SInt64; divisor: SInt64): SInt64; C;



{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  S64Divide()
 *  
 *  Discussion:
 *    Divides dividend by divisor, returning the quotient.  The
 *    remainder is returned in *remainder if remainder (the pointer) is
 *    non-NULL. The sign of the remainder is the same as the sign of
 *    the dividend (i.e. it takes the absolute values of the operands,
 *    does the division, then fixes the sign of the quotient and
 *    remainder).  If the divisor is zero, then S64Max() will be
 *    returned (or S64Min() if the dividend is negative), and the
 *    remainder will be the dividend; no error is reported.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64Divide(dividend: SInt64; divisor: SInt64; remainder: SInt64Ptr): SInt64; C;



{
 *  S64Set()
 *  
 *  Discussion:
 *    Given an SInt32, returns an SInt64 with the same value.  Use this
 *    routine instead of coding 64-bit constants (at least when the
 *    constant will fit in an SInt32).
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64Set(value: SInt32): SInt64; C;


{
 *  S64SetU()
 *  
 *  Discussion:
 *    Given a UInt32, returns a SInt64 with the same value.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64SetU(value: UInt32): SInt64; C;

{
 *  S32Set()
 *  
 *  Discussion:
 *    Given an SInt64, returns an SInt32 by discarding the high-order
 *    32 bits.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S32Set(value: SInt64): SInt32; C;


{
 *  S64And()
 *  
 *  Discussion:
 *    Returns one if left and right are non-zero, otherwise returns zero
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64And(left: SInt64; right: SInt64): BOOLEAN; C;


{
 *  S64Or()
 *  
 *  Discussion:
 *    Returns one if left or right are non-zero, otherwise returns zero
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64Or(left: SInt64; right: SInt64): BOOLEAN; C;


{
 *  S64Eor()
 *  
 *  Discussion:
 *    Returns one if left xor right are non-zero, otherwise returns zero
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64Eor(left: SInt64; right: SInt64): BOOLEAN; C;


{
 *  S64Not()
 *  
 *  Discussion:
 *    Returns one if value is non-zero, otherwisze returns zero.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64Not(value: SInt64): BOOLEAN; C;


{
 *  S64Compare()
 *  
 *  Discussion:
 *    Given two signed numbers, left and right, returns an SInt32 that
 *    compares with zero the same way left compares with right.  If you
 *    wanted to perform a comparison on 64-bit integers of the
 *    form:
 *    operand_1 <operation> operand_2
 *    then you could use an expression of the form:
 *     xxxS64Compare(operand_1,operand_2) <operation> 0
 *    to test for the same condition. CAUTION: DO NOT depend on the
 *    exact value returned by this routine. Only the sign (i.e.
 *    positive, zero, or negative) of the result is guaranteed.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64Compare(left: SInt64; right: SInt64): SInt32; C;


{
 *  S64BitwiseAnd()
 *  
 *  Discussion:
 *    bitwise AND
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64BitwiseAnd(left: SInt64; right: SInt64): SInt64; C;


{
 *  S64BitwiseOr()
 *  
 *  Discussion:
 *    bitwise OR
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64BitwiseOr(left: SInt64; right: SInt64): SInt64; C;


{
 *  S64BitwiseEor()
 *  
 *  Discussion:
 *    bitwise XOR
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64BitwiseEor(left: SInt64; right: SInt64): SInt64; C;


{
 *  S64BitwiseNot()
 *  
 *  Discussion:
 *    bitwise negate
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64BitwiseNot(value: SInt64): SInt64; C;


{
 *  S64ShiftRight()
 *  
 *  Discussion:
 *    Arithmetic shift of value by the lower 7 bits of the shift.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64ShiftRight(value: SInt64; shift: UInt32): SInt64; C;


{
 *  S64ShiftLeft()
 *  
 *  Discussion:
 *    Logical shift of value by the lower 7 bits of the shift.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION S64ShiftLeft(value: SInt64; shift: UInt32): SInt64; C;



{
 *  U64Max()
 *  
 *  Discussion:
 *    Returns largest possible UInt64 value
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64Max: UInt64; C;

{
 *  U64Add()
 *  
 *  Discussion:
 *    Adds two unsigned integers, producing an integer result.  If an
 *    overflow occurs the result is congruent mod (2^64) as if the
 *    operands and result were unsigned.  No overflow is signaled.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64Add(left: UInt64; right: UInt64): UInt64; C;

{
 *  U64Subtract()
 *  
 *  Discussion:
 *    Subtracts two unsigned integers, producing an integer result.  If
 *    an overflow occurs the result is congruent mod (2^64) as if the
 *    operands and result were unsigned.  No overflow is signaled.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64Subtract(left: UInt64; right: UInt64): UInt64; C;


{
 *  U64Multiply()
 *  
 *  Discussion:
 *    Multiplies two unsigned numbers, producing a signed result. 
 *    Overflow is ignored and the low-order part of the product is
 *    returned.  The sign of the result is not guaranteed to be correct
 *    if the magnitude of the product is not representable.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64Multiply(left: UInt64; right: UInt64): UInt64; C;


{$IFC CALL_NOT_IN_CARBON }
{
 *  U64Mod()
 *  
 *  Discussion:
 *    Returns the remainder of divide of dividend by divisor.  The sign
 *    of the remainder is the same as the sign of the dividend (i.e.,
 *    it takes the absolute values of the operands, does the division,
 *    then fixes the sign of the quotient and remainder).
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION U64Mod(dividend: UInt64; divisor: UInt64): UInt64; C;


{$ENDC}  {CALL_NOT_IN_CARBON}

{
 *  U64Divide()
 *  
 *  Discussion:
 *    Divides dividend by divisor, returning the quotient.  The
 *    remainder is returned in *remainder if remainder (the pointer) is
 *    non-NULL. The sign of the remainder is the same as the sign of
 *    the dividend (i.e. it takes the absolute values of the operands,
 *    does the division, then fixes the sign of the quotient and
 *    remainder).  If the divisor is zero, then U64Max() will be
 *    returned (or U64Min() if the dividend is negative), and the
 *    remainder will be the dividend; no error is reported.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64Divide(dividend: UInt64; divisor: UInt64; remainder: UInt64Ptr): UInt64; C;



{
 *  U64Set()
 *  
 *  Discussion:
 *    Given an SInt32, returns an UInt64 with the same value.  Use this
 *    routine instead of coding 64-bit constants (at least when the
 *    constant will fit in an SInt32).
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64Set(value: SInt32): UInt64; C;


{
 *  U64SetU()
 *  
 *  Discussion:
 *    Given a UInt32, returns a UInt64 with the same value.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64SetU(value: UInt32): UInt64; C;

{
 *  U32SetU()
 *  
 *  Discussion:
 *    Given an UInt64, returns an UInt32 by discarding the high-order
 *    32 bits.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U32SetU(value: UInt64): UInt32; C;


{
 *  U64And()
 *  
 *  Discussion:
 *    Returns one if left and right are non-zero, otherwise returns zero
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64And(left: UInt64; right: UInt64): BOOLEAN; C;


{
 *  U64Or()
 *  
 *  Discussion:
 *    Returns one if left or right are non-zero, otherwise returns zero
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64Or(left: UInt64; right: UInt64): BOOLEAN; C;


{
 *  U64Eor()
 *  
 *  Discussion:
 *    Returns one if left xor right are non-zero, otherwise returns zero
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64Eor(left: UInt64; right: UInt64): BOOLEAN; C;


{
 *  U64Not()
 *  
 *  Discussion:
 *    Returns one if value is non-zero, otherwisze returns zero.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64Not(value: UInt64): BOOLEAN; C;


{
 *  U64Compare()
 *  
 *  Discussion:
 *    Given two unsigned numbers, left and right, returns an SInt32
 *    that compares with zero the same way left compares with right. 
 *    If you wanted to perform a comparison on 64-bit integers of the
 *    form:
 *    operand_1 <operation> operand_2
 *    then you could use an expression of the form:
 *     xxxU64Compare(operand_1,operand_2) <operation> 0
 *    to test for the same condition. CAUTION: DO NOT depend on the
 *    exact value returned by this routine. Only the sign (i.e.
 *    positive, zero, or negative) of the result is guaranteed.
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64Compare(left: UInt64; right: UInt64): SInt32; C;

{
 *  U64BitwiseAnd()
 *  
 *  Discussion:
 *    bitwise AND
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64BitwiseAnd(left: UInt64; right: UInt64): UInt64; C;


{
 *  U64BitwiseOr()
 *  
 *  Discussion:
 *    bitwise OR
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64BitwiseOr(left: UInt64; right: UInt64): UInt64; C;


{
 *  U64BitwiseEor()
 *  
 *  Discussion:
 *    bitwise XOR
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64BitwiseEor(left: UInt64; right: UInt64): UInt64; C;


{
 *  U64BitwiseNot()
 *  
 *  Discussion:
 *    bitwise negate
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64BitwiseNot(value: UInt64): UInt64; C;


{
 *  U64ShiftRight()
 *  
 *  Discussion:
 *    Arithmetic shift of value by the lower 7 bits of the shift.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64ShiftRight(value: UInt64; shift: UInt32): UInt64; C;


{
 *  U64ShiftLeft()
 *  
 *  Discussion:
 *    Logical shift of value by the lower 7 bits of the shift.
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION U64ShiftLeft(value: UInt64; shift: UInt32): UInt64; C;



{
 *  UInt64ToSInt64()
 *  
 *  Discussion:
 *    converts UInt64 -> SInt64
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION UInt64ToSInt64(value: UInt64): SInt64; C;


{
 *  SInt64ToUInt64()
 *  
 *  Discussion:
 *    converts SInt64 -> UInt64
 *  
 *  Availability:
 *    Non-Carbon CFM:   available as macro/inline
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SInt64ToUInt64(value: SInt64): UInt64; C;






{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := Math64Includes}

{$ENDC} {__MATH64__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

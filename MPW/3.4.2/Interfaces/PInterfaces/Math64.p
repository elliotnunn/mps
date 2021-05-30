{
 	File:		Math64.p
 
 	Contains:	64-bit integer math Interfaces.
 
 	Version:	Technology:	Math64Lib
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
 UNIT Math64;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __MATH64__}
{$SETC __MATH64__ := 1}

{$I+}
{$SETC Math64Includes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{
--------------------------------------------------------------------------------
				These routines are intended to provide C software support for
				64 bit integer types.  Their behavior should mimic anticipated
				64 bit hardware. This implementation should replace use of the
				"wide" type found in PowerPC.

	The following routines are available for performing math on 64-bit integers:
	
	S64Max
				Returns the largest representable SInt64.
	S64Min
				Returns the smallest (i.e. most negative) SInt64.  Note: the negative
				(absolute value) of this number is not representable in an SInt64.
				That means that S64Negate(S64Min) is not representable (in fact,
				it returns S64Min).
	S64Add
				Adds two integers, producing an integer result.  If an overflow
				occurs the result is congruent mod (2^64) as if the operands and
				result were unsigned.  No overflow is signaled.
	
	S64Subtract
				Subtracts two integers, producing an integer result.  If an overflow
				occurs the result is congruent mod (2^64) as if the operands and
				result were unsigned.  No overflow is signaled.

	S64Negate
				Returns the additive inverse of a signed number (i.e. it returns
				0 - the number).  S64Negate (S64Min) is not representable (in fact,
				it returns S64Min).
	
	S64Absolute
				Returns the absolute value of the number (i.e. the number if
				it is positive, or 0 - the number if it is negative).
				See S64Negate above.
				
	S64Multiply
				Multiplies two signed numbers, producing a signed result.  Overflow
				is ignored and the low-order part of the product is returned.  The
				sign of the result is not guaranteed to be correct if the magnitude
				of the product is not representable.
	S64Divide
				Divides dividend by divisor, returning the quotient.  The remainder
				is returned in *remainder if remainder (the pointer) is non-NULL.
				The sign of the remainder is the same as the sign of the dividend
				(i.e. it takes the absolute values of the operands, does the division,
				then fixes the sign of the quotient and remainder).  If the divisor
				is zero, then S64Max() will be returned (or S64Min() if the dividend
				is negative), and the remainder will be the dividend; no error is
				reported.
	
	S64Set
				Given an SInt32, returns an SInt64 with the same value.  Use this
				routine instead of coding 64-bit constants (at least when the
				constant will fit in an SInt32).
	
	S64SetU
				Given a UInt32, returns a SInt64 with the same value.
	
	S64Compare
				Given two signed numbers, left and right, returns an
				SInt32 that compares with zero the same way left compares with
				right.  If you wanted to perform a comparison on 64-bit integers
				of the form:
						operand_1 <operation> operand_2
				then you could use an expression of the form:
						xxxS64Compare(operand_1,operand_2) <operation> 0
				to test for the same condition.
				
				CAUTION: DO NOT depend on the exact value returned by this routine.
				Only the sign (i.e. positive, zero, or negative) of the result is
				guaranteed.

	S64And, S64Or, S64Eor and S64Not
	
				Return Boolean (1 or 0) depending on the outcome of the logical
				operation.

	S64BitwiseAnd, S64BitwiseOr, S64BitwiseEor and S64BitwiseNot
	
				Return the Bitwise result.
				
	S64ShiftRight and S64ShiftLeft
	
				The lower 7 bits of the shift argument determines the amount of 
				shifting.  S64ShiftRight is an arithmetic shift while U64ShiftRight
				is a logical shift.

	SInt64ToLongDouble
				
				Converts SInt64 to long double.  Note all SInt64s fit exactly into 
				long doubles, thus, the binary -> decimal conversion routines
				in fp.h can be used to achieve SInt64 -> long double -> decimal
				conversions.
				
	LongDoubleToSInt64
	
				Converts a long double to a SInt64.  Any decimal string that fits
				into a SInt64 can be converted exactly into a long double, using the
				conversion routines found in fp.h.  Then this routine can be used
				to complete the conversion to SInt64.
				
				
	
	The corresponding UInt64 routines are also included.
	
--------------------------------------------------------------------------------
}
TYPE
	SInt64Ptr = ^SInt64;
	SInt64 = RECORD
		hi:						SInt32;
		lo:						UInt32;
	END;

	UInt64Ptr = ^UInt64;
	UInt64 = RECORD
		hi:						UInt32;
		lo:						UInt32;
	END;

{$IFC GENERATINGPOWERPC }
FUNCTION S64Max: SInt64; C;
FUNCTION S64Min: SInt64; C;
FUNCTION S64Add(x: SInt64; y: SInt64): SInt64; C;
FUNCTION S64Subtract(left: SInt64; right: SInt64): SInt64; C;
FUNCTION S64Negate(value: SInt64): SInt64; C;
FUNCTION S64Absolute(value: SInt64): SInt64; C;
FUNCTION S64Multiply(xparam: SInt64; yparam: SInt64): SInt64; C;
FUNCTION S64Divide(dividend: SInt64; divisor: SInt64; VAR remainder: SInt64): SInt64; C;
FUNCTION S64Set(value: SInt32): SInt64; C;
FUNCTION S64SetU(value: UInt32): SInt64; C;
FUNCTION S32Set(value: SInt64): SInt32; C;
FUNCTION S64Compare(left: SInt64; right: SInt64): LONGINT; C;
FUNCTION S64And(left: SInt64; right: SInt64): BOOLEAN; C;
FUNCTION S64Or(left: SInt64; right: SInt64): BOOLEAN; C;
FUNCTION S64Eor(left: SInt64; right: SInt64): BOOLEAN; C;
FUNCTION S64Not(value: SInt64): BOOLEAN; C;
FUNCTION S64BitwiseAnd(left: SInt64; right: SInt64): SInt64; C;
FUNCTION S64BitwiseOr(left: SInt64; right: SInt64): SInt64; C;
FUNCTION S64BitwiseEor(left: SInt64; right: SInt64): SInt64; C;
FUNCTION S64BitwiseNot(value: SInt64): SInt64; C;
FUNCTION S64ShiftRight(value: SInt64; shift: UInt32): SInt64; C;
FUNCTION S64ShiftLeft(value: SInt64; shift: UInt32): SInt64; C;
FUNCTION SInt64ToLongDouble(value: SInt64): LongDouble; C;
FUNCTION LongDoubleToSInt64(value: LongDouble): SInt64; C;
FUNCTION U64Max: UInt64; C;
FUNCTION U64Add(x: UInt64; y: UInt64): UInt64; C;
FUNCTION U64Subtract(left: UInt64; right: UInt64): UInt64; C;
FUNCTION U64Multiply(xparam: UInt64; yparam: UInt64): UInt64; C;
FUNCTION U64Divide(dividend: UInt64; divisor: UInt64; VAR remainder: UInt64): UInt64; C;
FUNCTION U64Set(value: SInt32): UInt64; C;
FUNCTION U64SetU(value: UInt32): UInt64; C;
FUNCTION U32SetU(value: UInt64): UInt32; C;
FUNCTION U64Compare(left: UInt64; right: UInt64): LONGINT; C;
FUNCTION U64And(left: UInt64; right: UInt64): BOOLEAN; C;
FUNCTION U64Or(left: UInt64; right: UInt64): BOOLEAN; C;
FUNCTION U64Eor(left: UInt64; right: UInt64): BOOLEAN; C;
FUNCTION U64Not(value: UInt64): BOOLEAN; C;
FUNCTION U64BitwiseAnd(left: UInt64; right: UInt64): UInt64; C;
FUNCTION U64BitwiseOr(left: UInt64; right: UInt64): UInt64; C;
FUNCTION U64BitwiseEor(left: UInt64; right: UInt64): UInt64; C;
FUNCTION U64BitwiseNot(value: UInt64): UInt64; C;
FUNCTION U64ShiftRight(value: UInt64; shift: UInt32): UInt64; C;
FUNCTION U64ShiftLeft(value: UInt64; shift: UInt32): UInt64; C;
FUNCTION UInt64ToLongDouble(value: UInt64): LongDouble; C;
FUNCTION LongDoubleToUInt64(value: LongDouble): UInt64; C;
FUNCTION UInt64ToSInt64(value: UInt64): SInt64; C;
FUNCTION SInt64ToUInt64(value: SInt64): UInt64; C;
{$ENDC}


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := Math64Includes}

{$ENDC} {__MATH64__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

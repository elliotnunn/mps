/*
 	File:		Math64.h
 
 	Contains:	64-bit integer math Interfaces.
 
 	Version:	Technology:	Math64Lib
 				Package:	Use with Universal Interfaces 2.1
 
 	Copyright:	© 1995-1997 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __MATH64__
#define __MATH64__

#include <ConditionalMacros.h>
#include <Types.h>				/* For SInt32, UInt32, and Boolean */

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

/*--------------------------------------------------------------------------------
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
	
	S64Div, S64Mod
				Provide simple two argument divide and modulo functions to allow easier
				porting to a builtin "long long" data type.  The three argument 
				S64Divide function cannot be represented with builtin binary operators
				and retain the same semantics as the function call.
	
	S64Set
				Given an SInt32, returns an SInt64 with the same value.  Use this
				routine instead of coding 64-bit constants (at least when the
				constant will fit in an SInt32).
	
	S64SetU
				Given a UInt32, returns a SInt64 with the same value.
	
	S32Set
				Given a SInt64, returns a SInt32 with the same value, modulo LONG_MAX.
	
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
				
				Converts SInt64 to long double.
				
	LongDoubleToSInt64
	
				Converts a long double to a SInt64.
				
	SInt64toStr
	
				Converts a SInt64 to a decimal string.  The buffer pointed to by
				"target" must be long enough to contain the longest expected
				decimal string.  The longest possible decimal constant is 21
				characters.  With a StdCLib that provides "long long" support,
				this functionality can be achieved with the "sprintf" function.

	StrtoSInt64
					
				Converts a decimal string to a SInt64.  Except for the length of the
				string, the format of the source is the same as that expected for "atol".
				By using a pointer to the target, this function can be used with either
				the struct typedef of SInt64, or the "long long" typedef.  It returns a
				non-zero value if a conversion error (such as overflow) occurred.
				With a StdCLib that provides "long long" support, this functionality can
				be achieved with the "atoll" function.  If overflow occurs, S64Max is
				returned in "target" if the "source" string is positive, or S64Min if
				the "source" string is negative.

	
	The corresponding UInt64 routines are also included.
	
--------------------------------------------------------------------------------*/

#if _LONG_LONG   /* Is long long supported? */

#include <limits.h>
#include <stdlib.h>

typedef signed long long int SInt64;

typedef unsigned long long int UInt64;

#define S64Max() LLONG_MAX
#define S64Min() LLONG_MIN
#define S64Add(x, y) ((x) + (y))
#define S64Subtract(x, y) ((x) - (y))
#define S64Negate(x) (-(x))
#define S64Absolute(x) absll((x))
#define S64Multiply(x, y) ((x) * (y))
#define S64Div(x, y) ((x) / (y))
#define S64Mod(x, y) ((x) % (y))
#define S64Set(x) ((SInt64) (x))
#define S64SetU(x) ((SInt64) (x))
#define S32Set(x) ((SInt32) (x))
#define S64Compare(x, y) ((int)((x) - (y)))
#define S64And(x, y) ((Boolean)((x) && (y)))
#define S64Or(x, y) ((Boolean)((x) || (y)))
#define S64Not(x) ((Boolean)(!(x)))
#define S64BitwiseAnd(x, y) ((x) & (y))
#define S64BitwiseOr(x, y) ((x) | (y))
#define S64BitwiseEor(x, y) ((x) ^ (y))
#define S64BitwiseNot(x) (~(x))
#define S64ShiftRight(x, y) ((x) >> (y))
#define S64ShiftLeft(x, y) ((x) << (y))
#define SInt64ToLongDouble(x) ((long double)(x))
#define LongDoubleToSInt64(x) ((SInt64)(x))

#define U64Max() ULLONG_MAX
#define U64Add(x, y) ((x) + (y))
#define U64Subtract(x, y) ((x) - (y))
#define U64Multiply(x, y) ((x) * (y))
#define U64Div(x, y) ((x) / (y))
#define U64Mod(x, y) ((x) % (y))
#define U64Set(x) ((UInt64) (x))
#define U64SetU(x) ((UInt64) (x))
#define U32SetU(x) ((UInt32) (x))
#define U64Compare(x, y) ((int)((x) - (y)))
#define U64And(x, y) ((Boolean)((x) && (y)))
#define U64Or(x, y) ((Boolean)((x) || (y)))
#define U64Not(x) ((Boolean)(!(x)))
#define U64BitwiseAnd(x, y) ((x) & (y))
#define U64BitwiseOr(x, y) ((x) | (y))
#define U64BitwiseEor(x, y) ((x) ^ (y))
#define U64BitwiseNot(x) (~(x))
#define U64ShiftRight(x, y) ((x) >> (y))
#define U64ShiftLeft(x, y) ((x) << (y))
#define UInt64ToLongDouble(x) ((long double)(x))
#define LongDoubleToUInt64(x) ((UInt64)(x))
#define UInt64ToSInt64(x) ((SInt64)(x))
#define SInt64ToUInt64(x) ((UInt64)(x))

#else  /* If _LONG_LONG is not supported */

struct SInt64 {
	SInt32							hi;
	UInt32							lo;
};
typedef struct SInt64 SInt64;

struct UInt64 {
	UInt32							hi;
	UInt32							lo;
};
typedef struct UInt64 UInt64;

extern SInt64 S64Max(void);
extern SInt64 S64Min(void);
extern SInt64 S64Add(SInt64 x, SInt64 y);
extern SInt64 S64Subtract(SInt64 left, SInt64 right);
extern SInt64 S64Negate(SInt64 value);
extern SInt64 S64Absolute(SInt64 value);
extern SInt64 S64Multiply(SInt64 xparam, SInt64 yparam);
extern SInt64 S64Div(SInt64 dividend, SInt64 divisor);
extern SInt64 S64Mod(SInt64 dividend, SInt64 divisor);
extern SInt64 S64Set(SInt32 value);
extern SInt64 S64SetU(UInt32 value);
extern SInt32 S32Set(SInt64 value);
extern int S64Compare(SInt64 left, SInt64 right);
extern Boolean S64And(SInt64 left, SInt64 right);
extern Boolean S64Or(SInt64 left, SInt64 right);
extern Boolean S64Not(SInt64 value);
extern SInt64 S64BitwiseAnd(SInt64 left, SInt64 right);
extern SInt64 S64BitwiseOr(SInt64 left, SInt64 right);
extern SInt64 S64BitwiseEor(SInt64 left, SInt64 right);
extern SInt64 S64BitwiseNot(SInt64 value);
extern SInt64 S64ShiftRight(SInt64 value, UInt32 shift);
extern SInt64 S64ShiftLeft(SInt64 value, UInt32 shift);
extern long double SInt64ToLongDouble(SInt64 value);
extern SInt64 LongDoubleToSInt64(long double value);
extern UInt64 U64Max(void);
extern UInt64 U64Add(UInt64 x, UInt64 y);
extern UInt64 U64Subtract(UInt64 left, UInt64 right);
extern UInt64 U64Multiply(UInt64 xparam, UInt64 yparam);
extern UInt64 U64Div(UInt64 dividend, UInt64 divisor);
extern UInt64 U64Mod(UInt64 dividend, UInt64 divisor);
extern UInt64 U64Set(SInt32 value);
extern UInt64 U64SetU(UInt32 value);
extern UInt32 U32SetU(UInt64 value);
extern int U64Compare(UInt64 left, UInt64 right);
extern Boolean U64And(UInt64 left, UInt64 right);
extern Boolean U64Or(UInt64 left, UInt64 right);
extern Boolean U64Not(UInt64 value);
extern UInt64 U64BitwiseAnd(UInt64 left, UInt64 right);
extern UInt64 U64BitwiseOr(UInt64 left, UInt64 right);
extern UInt64 U64BitwiseEor(UInt64 left, UInt64 right);
extern UInt64 U64BitwiseNot(UInt64 value);
extern UInt64 U64ShiftRight(UInt64 value, UInt32 shift);
extern UInt64 U64ShiftLeft(UInt64 value, UInt32 shift);
extern long double UInt64ToLongDouble(UInt64 value);
extern UInt64 LongDoubleToUInt64(long double value);
extern SInt64 UInt64ToSInt64(UInt64 value);
extern UInt64 SInt64ToUInt64(SInt64 value);

/* Functions for which macros are not appropriate. */

/* Use the "x64Div" and "x64Mod" functions instead of these. */
/* These functions will not work with the "long long"		 */
/* definitions of SInt64 or UInt64.							 */
extern SInt64 S64Divide(SInt64 dividend, SInt64 divisor, SInt64 *remainder);
extern UInt64 U64Divide(UInt64 dividend, UInt64 divisor, UInt64 *remainder);


#endif  /* If _LONG_LONG is supported */

/* These functions can be used with any definition of SInt64 or UInt64. */
extern void SInt64toStr(SInt64 source, char *target);
extern void UInt64toStr(UInt64 source, char *target);
extern int StrtoSInt64(const char *source, SInt64 *target);
extern int StrtoUInt64(const char *source, UInt64 *target);

/* These functions can be used with any definition of SInt64 or UInt64,	*/
/* and there is no appropriate binary operator that corresponds with a	*/
/* logical exclusive OR operation.										*/
extern Boolean S64Eor(SInt64 left, SInt64 right);
extern Boolean U64Eor(UInt64 left, UInt64 right);



#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __MATH64__ */

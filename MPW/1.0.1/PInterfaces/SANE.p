{
	SANE.p - Pascal interface for Standard Apple Numeric Environment
	
	Copyright Apple Computer Inc. 1983 - 1986
	All rights reserved.
}

Unit SANE;

	INTERFACE

	const
		DecStrLen = 255;
		SigDigLen = 20;   { for 68K;  use 28 in 6502 SANE }
		
		{---------------------------------------------------
		*  Exceptions.
		---------------------------------------------------}
		Invalid 	= 1;
		Underflow	= 2;
		Overflow	= 4;
		DivByZero	= 8;
		Inexact 	= 16;

	type
		{---------------------------------------------------
		* Types for handling decimal representations.
		---------------------------------------------------}
		DecStr		= string[DecStrLen];

		CStrPtr 	= ^char;

		Decimal 	= record
						sgn : 0..1;
						exp : integer;
						sig : string[SigDigLen]
					end;

		DecForm 	= record
						style	 : ( FloatDecimal, FixedDecimal );
						digits : integer;
					end;

		{---------------------------------------------------
		* Ordering relations.
		---------------------------------------------------}
		RelOp		= ( GreaterThan, LessThan, EqualTo, Unordered );

		{---------------------------------------------------
		* Inquiry classes.
		---------------------------------------------------}
		NumClass	= ( SNaN, QNaN, Infinite, ZeroNum, NormalNum, DenormalNum );

		{---------------------------------------------------
		* Environmental control.
		---------------------------------------------------}
		Exception	= integer;

		RoundDir	= ( ToNearest, Upward, Downward, TowardZero );

		RoundPre	= ( ExtPrecision, DblPrecision, RealPrecision );

		Environment = integer;

{*==============================================================================*
 *		The functions and procedures of the SANE library						*
 *==============================================================================*}

		{---------------------------------------------------
		* Conversions between numeric binary types.
		---------------------------------------------------}
		function  Num2Integer	( x : extended ) : integer;
		function  Num2Longint	( x : extended ) : longint;
		function  Num2Real		( x : extended ) : real;
		function  Num2Double	( x : extended ) : double;
		function  Num2Extended	( x : extended ) : extended;
		function  Num2Comp		( x : extended ) : comp;

		{---------------------------------------------------
		* Conversions between binary and decimal.
		---------------------------------------------------}
		procedure Num2Dec ( f : DecForm; x : extended; var d : Decimal );
			{ d <-- x according to format f }
		function  Dec2Num ( d : Decimal ) : extended;
			{ Dec2Num <-- d }

		procedure Num2Str ( f : DecForm; x : extended; var s : DecStr );
			{ s <-- x according to format f }
		function  Str2Num ( s : DecStr ) : extended;
			{ Str2Num <-- s }

		{---------------------------------------------------
		* Conversions between decimal formats.
		---------------------------------------------------}
		procedure Str2Dec ( s : DecStr;  var Index : integer;
						var d : Decimal; var ValidPrefix : boolean );
				{ On input Index is starting index into s, on output Index is one
				  greater than index of last character of longest numeric substring;
				  d <-- Decimal rep of longest numeric substring;
				  ValidPrefix <-- "s, beginning at Index, contains valid numeric
							string or valid prefix of some numeric string" }

		procedure CStr2Dec ( s : CStrPtr; var Index : integer;
						var d : Decimal; var ValidPrefix : boolean );
				{ Str2Dec for character buffers or C strings instead of Pascal
				  strings:	the first argument is the the address of a character
				  buffer and ValidPrefix <-- "scanning ended with a null byte"	 }

		procedure Dec2Str ( f: DecForm; d: Decimal; var s: DecStr );
				{ s <-- d according to format f }

		{---------------------------------------------------
		* Arithmetic, auxiliary, and elementary functions.
		---------------------------------------------------}
		function Remainder ( x, y : extended; var quo : integer) : extended;
				{ Remainder <-- x rem y; quo <-- low-order seven bits of integer
				  quotient x/y so that -127 < quo < 127 }

		function Rint ( x : extended ) : extended;
				{ round to integral value	}

		function Scalb ( n : integer; x : extended ) : extended;
				{ scale binary;  Scalb <-- x * 2^n }

		function Logb ( x : extended ) : extended;
				{ Logb <-- unbiased exponent of x	}

		function CopySign ( x, y : extended ) : extended;
				{ CopySign <-- y with sign of x }

		function NextReal ( x, y : real ) : real;
		function NextDouble ( x, y : double ) : double;
		function NextExtended ( x, y : extended ) : extended;
				{ return next representable value from x toward y }

		function Log2 ( x : extended ) : extended;
				{ base-2 log	}
		function Ln1 ( x : extended ) : extended;
				{ Ln1 <-- ln(1+x)	}
		function Exp2 ( x : extended ) : extended;
				{ base-2 exponential	}
		function Exp1 ( x : extended ) : extended;
				{ Exp1 <-- exp(x) - 1	}
		function XpwrI ( x : extended; i : integer ) : extended;
				{ XpwrI <-- x^i }
		function XpwrY ( x, y : extended ) : extended;
				{ XpwrY <-- x^y }
		function Compound ( r, n : extended ) : extended;
				{ Compound <-- (1+r)^n	}
		function Annuity ( r, n : extended )  : extended;
				{ Annuity <-- (1 - (1+r)^(-n)) / r }
		function Tan ( x : extended ) : extended;
				{ tangent	}
		function RandomX ( var x : extended ) : extended;
				{ returns next random number and updates argument;
				  x integral, 1 <= x <= (2^31)-2	}

		{---------------------------------------------------
		* Inquiry routines.
		---------------------------------------------------}
		function ClassReal ( x : real ) : NumClass;
		function ClassDouble ( x : double ) : NumClass;
		function ClassComp ( x : comp ) : NumClass;
		function ClassExtended ( x : extended ) : NumClass;
				{ return class of x }

		function SignNum ( x : extended ) : integer;
				{ 0 if sign bit clear, 1 if sign bit set }

		{---------------------------------------------------
		* NaN function.
		---------------------------------------------------}
		function NAN ( i : integer ) : extended;
				{ returns NaN with code i }

		{---------------------------------------------------
		* Environment access routines.
		---------------------------------------------------}
		procedure SetException ( e : Exception; b : boolean );
				{ set e flags if b is true, clear e flags otherwise; may cause halt }

		function TestException ( e : Exception) : boolean;
				{ return true if any e flag is set, return false otherwise	}

		procedure SetHalt ( e : Exception; b : boolean );
				{ set e halt enables if b is true, clear e halt enables otherwise	}

		function TestHalt ( e : Exception) : boolean;
				{ return true if any e halt is enabled, return false otherwise	}
		procedure SetRound ( r : RoundDir );
				{ set rounding direction to r	}
		function GetRound : RoundDir;
				{ return rounding direction }
		procedure SetPrecision ( p : RoundPre );
				{ set rounding precision to p	}
		function GetPrecision : RoundPre;
				{ return rounding precision }
		procedure SetEnvironment ( e : Environment );
				{ set environment to e	}
		procedure GetEnvironment ( var e : Environment );
				{ e <-- environment }
		procedure ProcEntry ( var e : Environment );
				{ e <-- environment;  environment <-- IEEE default }
		procedure ProcExit ( e : Environment );
				{ temp <-- exceptions;	environment <-- e;
				  signal exceptions in temp }

		function GetHaltVector : longint ;
				{ return halt vector	}
		procedure SetHaltVector ( v : longint ) ;
				{ halt vector <-- v }

		{---------------------------------------------------
		* Comparison routine.
		---------------------------------------------------}
		function Relation ( x, y : extended ) : Relop;
				{ return Relation such that "x Relation y" is true }


	END.

{
 SANE.p - Pascal interface for Standard Apple Numeric Environment

 Copyright Apple Computer, Inc. 1983 - 1987
 All rights reserved.
}

UNIT SANE;

  INTERFACE

  { Elems881 mode set by -d Elems881=true on Pascal command line }
	
  {$IFC UNDEFINED Elems881}
	{$SETC Elems881 = FALSE}
  {$ENDC}

  {$IFC OPTION(MC68881)}
	
  {*====================================================================*
   *  The interface specific to the MC68881 SANE library				*
   *====================================================================*}
	CONST
	{---------------------------------------------------
	* Exceptions.
	---------------------------------------------------}
	Inexact = 8;
	DivByZero = 16;
	Underflow = 32;
	Overflow = 64;
	Invalid = 128;

	CurInex1 = 256;
	CurInex2 = 512;
	CurDivByZero = 1024;
	CurUnderflow = 2048;
	CurOverflow = 4096;
	CurOpError = 8192;
	CurSigNaN = 16384;
	CurBSonUnor = 32768;

	{---------------------------------------------------
	* Environmental control.
	---------------------------------------------------}
	TYPE		
	TrapVector = RECORD
					Unordered: LONGINT;
					Inexact  : LONGINT;
					DivByZero: LONGINT;
					Underflow: LONGINT;
					OpError  : LONGINT;
					Overflow : LONGINT;
					SigNaN   : LONGINT;
					END;

	Exception = LONGINT;
	Environment = RECORD
					FPCR: LONGINT;
					FPSR: LONGINT;
					END;
					
	FUNCTION IEEEDefaultEnv: Environment;
	{ return IEEE default environment }
	
	PROCEDURE GetTrapVector(VAR Traps: TrapVector);
	{ Traps <-- FPCP trap vectors }
	
	PROCEDURE SetTrapVector(Traps: TrapVector);
	{ FPCP trap vectors <-- Traps }
	
   {-------------------------------------------------------------------
	* TYPEs and FUNCTIONs for converting between SANE Extended formats
	-------------------------------------------------------------------}
	TYPE		
	Extended80 = ARRAY [0..4] OF INTEGER;
	
	FUNCTION X96toX80(x: EXTENDED): Extended80;
	{ X96toX80 <-- 96 bit x in 80 bit extended format }

	FUNCTION X80toX96(x: Extended80): EXTENDED;
	{ X80toX96 <-- 80 bit x in 96 bit extended format }
	
   {---------------------------------------------------------------------
	* Compatable Transendental functions - bypasses direct MC68881 calls
	---------------------------------------------------------------------}
	{$IFC Elems881 = false}
	
	FUNCTION Sin(x: EXTENDED): EXTENDED;
	{ sine }
	
	FUNCTION Cos(x: EXTENDED): EXTENDED;
	{ cosine }
	
	FUNCTION ArcTan(x: EXTENDED): EXTENDED;
	{ inverse tangent }
	
	FUNCTION Exp(x: EXTENDED): EXTENDED;
	{ base-e exponential }
	
	FUNCTION Ln(x: EXTENDED): EXTENDED;
	{ base-e log }
	
	FUNCTION Log2(x: EXTENDED): EXTENDED;
	{ base-2 log }

	FUNCTION Ln1(x: EXTENDED): EXTENDED;
	{ ln(1+x) }

	FUNCTION Exp2(x: EXTENDED): EXTENDED;
	{ base-2 exponential }

	FUNCTION Exp1(x: EXTENDED): EXTENDED;
	{ exp(x) - 1 }

	FUNCTION Tan(x: EXTENDED): EXTENDED;
	{ tangent }
	
	{$ENDC}
	
  {$ELSEC}

  {*====================================================================*
   *  The interface specific to the software SANE library				*
   *====================================================================*}
	
	CONST
	{---------------------------------------------------
	*  Exceptions.
	---------------------------------------------------}
	Invalid = 1;
	Underflow = 2;
	Overflow = 4;
	DivByZero = 8;
	Inexact = 16;

   {---------------------------------------------------
   *  IEEE default environment constant.
	---------------------------------------------------}
	IEEEDefaultEnv = 0;
		
   {---------------------------------------------------
	 * Environmental control.
	---------------------------------------------------}
	TYPE		
	Exception   = INTEGER;
	Environment = INTEGER;
		
	FUNCTION GetHaltVector: LONGINT;
	{ return halt vector }

	PROCEDURE SetHaltVector(v: LONGINT);
	{ halt vector <-- v }

   {-------------------------------------------------------------------
	* TYPEs and FUNCTIONs for converting between SANE Extended formats
	-------------------------------------------------------------------}
	TYPE		
	Extended96 = ARRAY [0..5] OF INTEGER;
	
	FUNCTION X96toX80(x: Extended96): EXTENDED;
	{ 96 bit x in 80 bit extended format }

	FUNCTION X80toX96(x: EXTENDED): Extended96;
	{ 80 bit x in 96 bit extended format }

   {-------------------------------------------------------------------
	* SANE library functions
	-------------------------------------------------------------------}
	FUNCTION Log2(x: EXTENDED): EXTENDED;
	{ base-2 log }

	FUNCTION Ln1(x: EXTENDED): EXTENDED;
	{ ln(1+x) }

	FUNCTION Exp2(x: EXTENDED): EXTENDED;
	{ base-2 exponential }

	FUNCTION Exp1(x: EXTENDED): EXTENDED;
	{ exp(x) - 1 }

	FUNCTION Tan(x: EXTENDED): EXTENDED;
	{ tangent }

  {$ENDC}

{*======================================================================*
 *	The common interface for the SANE library							*
 *======================================================================*}

	CONST
	DecStrLen = 255;
	SigDigLen = 20; { for 68K; use 28 in 6502 SANE }

	TYPE
	{---------------------------------------------------
	* Types for handling decimal representations.
	---------------------------------------------------}
	DecStr = STRING[DecStrLen];

	CStrPtr = ^CHAR;

	Decimal = RECORD
				sgn: 0..1;
				exp: INTEGER;
				sig: STRING[SigDigLen]
				END;

	DecForm = RECORD
				style: (FloatDecimal, FixedDecimal);
				digits: INTEGER;
				END;
	{---------------------------------------------------
	* Ordering relations.
	---------------------------------------------------}
	RelOp = (GreaterThan, LessThan, EqualTo, Unordered);

	{---------------------------------------------------
	* Inquiry classes.
	---------------------------------------------------}
	NumClass = (SNaN, QNaN, Infinite, ZeroNum, NormalNum, DenormalNum);


	RoundDir = (ToNearest, Upward, Downward, TowardZero);

	RoundPre = (ExtPrecision, DblPrecision, RealPrecision);

{*======================================================================*
 *	The functions and procedures of the SANE library					*
 *======================================================================*}

  {---------------------------------------------------
  * Conversions between numeric binary types.
  ---------------------------------------------------}

	FUNCTION Num2Integer(x: EXTENDED): INTEGER;

	FUNCTION Num2Longint(x: EXTENDED): LONGINT;

	FUNCTION Num2Real(x: EXTENDED): real;

	FUNCTION Num2Double(x: EXTENDED): DOUBLE;

	FUNCTION Num2Extended(x: EXTENDED): EXTENDED;

	FUNCTION Num2Comp(x: EXTENDED): comp;

  {---------------------------------------------------
  * Conversions between binary and decimal.
  ---------------------------------------------------}

	PROCEDURE Num2Dec(f: DecForm; x: EXTENDED; VAR d: Decimal);
	{ d <-- x according to format f }

	FUNCTION Dec2Num(d: Decimal): EXTENDED;
	{ Dec2Num <-- d }

	PROCEDURE Num2Str(f: DecForm; x: EXTENDED; VAR s: DecStr);
	{ s <-- x according to format f }

	FUNCTION Str2Num(s: DecStr): EXTENDED;
	{ Str2Num <-- s }

  {---------------------------------------------------
  * Conversions between decimal formats.
  ---------------------------------------------------}

	PROCEDURE Str2Dec(s: DecStr; VAR Index: INTEGER; VAR d: Decimal;
					VAR ValidPrefix: BOOLEAN);
	{ On input Index is starting index into s, on output Index is
	one greater than index of last character of longest numeric
	substring;
	d <-- Decimal rep of longest numeric substring;
	ValidPrefix <-- "s, beginning at Index, contains valid numeric
	string or valid prefix of some numeric string" }

	PROCEDURE CStr2Dec(s: CStrPtr; VAR Index: INTEGER; VAR d: Decimal;
					 VAR ValidPrefix: BOOLEAN);
	{ Str2Dec for character buffers or C strings instead of Pascal
	strings: the first argument is the the address of a character
	buffer and ValidPrefix <-- "scanning ended with a null byte" }

	PROCEDURE Dec2Str(f: DecForm; d: Decimal; VAR s: DecStr);
	{ s <-- d according to format f }

  {---------------------------------------------------
  * Arithmetic, auxiliary, and elementary functions.
  ---------------------------------------------------}

	FUNCTION Remainder(x, y: EXTENDED; VAR quo: INTEGER): EXTENDED;
	{ Remainder <-- x rem y; quo <-- low-order seven bits of integer
	quotient x/y so that -127 < quo < 127 }

	FUNCTION Rint(x: EXTENDED): EXTENDED;
	{ round to integral value }

	FUNCTION Scalb(n: INTEGER; x: EXTENDED): EXTENDED;
	{ scale binary;  Scalb <-- x * 2^n }

	FUNCTION Logb(x: EXTENDED): EXTENDED;
	{ Logb <-- unbiased exponent of x }

	FUNCTION CopySign(x, y: EXTENDED): EXTENDED;
	{ CopySign <-- y with sign of x }

	FUNCTION NextReal(x, y: real): real;

	FUNCTION NextDouble(x, y: DOUBLE): DOUBLE;

	FUNCTION NextExtended(x, y: EXTENDED): EXTENDED;
	{ return next representable value from x toward y }

	FUNCTION XpwrI(x: EXTENDED; i: INTEGER): EXTENDED;
	{ XpwrI <-- x^i }

	FUNCTION XpwrY(x, y: EXTENDED): EXTENDED;
	{ XpwrY <-- x^y }

	FUNCTION Compound(r, n: EXTENDED): EXTENDED;
	{ Compound <-- (1+r)^n }

	FUNCTION Annuity(r, n: EXTENDED): EXTENDED;
	{ Annuity <-- (1 - (1+r)^(-n)) / r }

	FUNCTION RandomX(VAR x: EXTENDED): EXTENDED;
	{ returns next random number and updates argument;
	x integral, 1 <= x <= (2^31)-2 }

  {---------------------------------------------------
  * Inquiry routines.
  ---------------------------------------------------}

	FUNCTION ClassReal(x: real): NumClass;

	FUNCTION ClassDouble(x: DOUBLE): NumClass;

	FUNCTION ClassComp(x: comp): NumClass;

	FUNCTION ClassExtended(x: EXTENDED): NumClass;
	{ return class of x }

	FUNCTION SignNum(x: EXTENDED): INTEGER;
	{ 0 if sign bit clear, 1 if sign bit set }

  {---------------------------------------------------
  * NaN function.
  ---------------------------------------------------}

	FUNCTION NAN(i: INTEGER): EXTENDED;
	{ returns NaN with code i }

  {---------------------------------------------------
  * Environment access routines.
  ---------------------------------------------------}

	PROCEDURE SetException(e: Exception; b: BOOLEAN);
	{ set e flags if b is true, clear e flags otherwise; may cause halt }

	FUNCTION TestException(e: Exception): BOOLEAN;
	{ return true if any e flag is set, return false otherwise }

	PROCEDURE SetHalt(e: Exception; b: BOOLEAN);
	{ set e halt enables if b is true, clear e halt enables otherwise }

	FUNCTION TestHalt(e: Exception): BOOLEAN;
	{ return true if any e halt is enabled, return false otherwise }

	PROCEDURE SetRound(r: RoundDir);
	{ set rounding direction to r }

	FUNCTION GetRound: RoundDir;
	{ return rounding direction }

	PROCEDURE SetPrecision(p: RoundPre);
	{ set rounding precision to p }

	FUNCTION GetPrecision: RoundPre;
	{ return rounding precision }

	PROCEDURE SetEnvironment(e: Environment);
	{ set environment to e }

	PROCEDURE GetEnvironment(VAR e: Environment);
	{ e <-- environment }

	PROCEDURE ProcEntry(VAR e: Environment);
	{ e <-- environment;  environment <-- IEEE default env }

	PROCEDURE ProcExit(e: Environment);
	{ temp <-- exceptions; environment <-- e;
	signal exceptions in temp }

  {---------------------------------------------------
  * Comparison routine.
  ---------------------------------------------------}

	FUNCTION Relation(x, y: EXTENDED): RelOp;
	{ return Relation such that "x Relation y" is true }

END.

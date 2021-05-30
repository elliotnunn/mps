{
 	File:		TextUtils.p
 
 	Contains:	Text Utilities Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1.5
 
 	Copyright:	© 1984-1997 by Apple Computer, Inc.
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
 UNIT TextUtils;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __TEXTUTILS__}
{$SETC __TEXTUTILS__ := 1}

{$I+}
{$SETC TextUtilsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __SCRIPT__}
{$I Script.p}
{$ENDC}
{	Quickdraw.p													}
{		MixedMode.p												}
{		QuickdrawText.p											}
{	IntlResources.p												}
{	Events.p													}
{		OSUtils.p												}
{			Memory.p											}

{$IFC UNDEFINED __OSUTILS__}
{$I OSUtils.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}
{

	Here are the current routine names and the translations to the older forms.
	Please use the newer forms in all new code and migrate the older names out of existing
	code as maintainance permits.
	
	New Name					Old Name(s)
	
	CompareString				IUCompPString IUMagString IUMagPString IUCompString 
	CompareText
	DateString					IUDatePString IUDateString 
	EqualString							
	ExtendedToString			FormatX2Str
	FindScriptRun
	FindWordBreaks				NFindWord FindWord
	FormatRecToString			Format2Str
	GetIndString			
	GetString
	IdenticalString				IUMagIDString IUMagIDPString IUEqualString IUEqualPString
	IdenticalText
	InitDateCache
	LanguageOrder				IULangOrder
	LongDateString				IULDateString
	LongTimeString				IULTimeString
	LowercaseText				LwrText LowerText
	Munger
	NewString				
	NumToString				
	RelString				
	ReplaceText
	ScriptOrder					IUScriptOrder
	SetString				
	StringOrder					IUStringOrder
	StringToDate				String2Date
	StringToExtended			FormatStr2X
	StringToFormatRec			Str2Format
	StringToNum				
	StringToTime								
	StripDiacritics				StripText
	StyledLineBreak
	TextOrder
	TimeString					IUTimeString IUTimePString
	TruncString
	TruncText
	UpperString					UprString
	UppercaseStripDiacritics	StripUpperText
	UppercaseText				UprText UprText
}
{ New constants for System 7.0: }

CONST
{ Constants for truncWhere argument in TruncString and TruncText }
	truncEnd					= 0;							{ Truncate at end }
	truncMiddle					= $4000;						{ Truncate in middle }
	smTruncEnd					= 0;							{ Truncate at end - obsolete }
	smTruncMiddle				= $4000;						{ Truncate in middle - obsolete }
{ Constants for TruncString and TruncText results }
	notTruncated				= 0;							{ No truncation was necessary }
	truncated					= 1;							{ Truncation performed }
	truncErr					= -1;							{ General error }
	smNotTruncated				= 0;							{ No truncation was necessary - obsolete }
	smTruncated					= 1;							{ Truncation performed	- obsolete }
	smTruncErr					= -1;							{ General error - obsolete }

	fVNumber					= 0;							{ first version of NumFormatString }
{ Special language code values for Language Order }
	systemCurLang				= -2;							{ current (itlbLang) lang for system script }
	systemDefLang				= -3;							{ default (table) lang for system script }
	currentCurLang				= -4;							{ current (itlbLang) lang for current script }
	currentDefLang				= -5;							{ default lang for current script }
	scriptCurLang				= -6;							{ current (itlbLang) lang for specified script }
	scriptDefLang				= -7;							{ default language for a specified script }

	iuSystemCurLang				= -2;							{ <obsolete> current (itlbLang) lang for system script }
	iuSystemDefLang				= -3;							{ <obsolete> default (table) lang for system script }
	iuCurrentCurLang			= -4;							{ <obsolete> current (itlbLang) lang for current script }
	iuCurrentDefLang			= -5;							{ <obsolete> default lang for current script }
	iuScriptCurLang				= -6;							{ <obsolete> current (itlbLang) lang for specified script }

{ <obsolete> default language for a specified script }
	iuScriptDefLang				= -7;

	
TYPE
	StyledLineBreakCode = SInt8;


CONST
	smBreakWord					= 0;
	smBreakChar					= 1;
	smBreakOverflow				= 2;

	
TYPE
	FormatClass = SInt8;


CONST
	fPositive					= 0;
	fNegative					= 1;
	fZero						= 2;

	
TYPE
	FormatResultType = SInt8;


CONST
	fFormatOK					= 0;
	fBestGuess					= 1;
	fOutOfSynch					= 2;
	fSpuriousChars				= 3;
	fMissingDelimiter			= 4;
	fExtraDecimal				= 5;
	fMissingLiteral				= 6;
	fExtraExp					= 7;
	fFormatOverflow				= 8;
	fFormStrIsNAN				= 9;
	fBadPartsTable				= 10;
	fExtraPercent				= 11;
	fExtraSeparator				= 12;
	fEmptyFormatString			= 13;


TYPE
	NumFormatString = PACKED RECORD
		fLength:				UInt8;
		fVersion:				UInt8;
		data:					PACKED ARRAY [0..253] OF CHAR;			{ private data }
	END;

	NumFormatStringRec = NumFormatString;

	FVector = RECORD
		start:					INTEGER;
		length:					INTEGER;
	END;

{ index by [fPositive..fZero] }
	TripleInt = ARRAY [0..2] OF FVector;

	ScriptRunStatus = RECORD
		script:					SInt8;
		runVariant:				SInt8;
	END;

{ New types for System 7.0: }
{ Type for truncWhere parameter in new TruncString, TruncText }
	TruncCode = INTEGER;


CONST
	shortDate					= 0;
	longDate					= 1;
	abbrevDate					= 2;

	
TYPE
	DateForm = SInt8;


CONST
{ StringToDate status values }
	fatalDateTime				= $8000;						{ StringToDate and String2Time mask to a fatal error }
	longDateFound				= 1;							{ StringToDate mask to long date found }
	leftOverChars				= 2;							{ StringToDate & Time mask to warn of left over characters }
	sepNotIntlSep				= 4;							{ StringToDate & Time mask to warn of non-standard separators }
	fieldOrderNotIntl			= 8;							{ StringToDate & Time mask to warn of non-standard field order }
	extraneousStrings			= 16;							{ StringToDate & Time mask to warn of unparsable strings in text }
	tooManySeps					= 32;							{ StringToDate & Time mask to warn of too many separators }
	sepNotConsistent			= 64;							{ StringToDate & Time mask to warn of inconsistent separators }
	tokenErr					= $8100;						{ StringToDate & Time mask for 'tokenizer err encountered' }
	cantReadUtilities			= $8200;
	dateTimeNotFound			= $8400;
	dateTimeInvalid				= $8800;

	
TYPE
	StringToDateStatus = INTEGER;

	String2DateStatus = INTEGER;

	DateCacheRecord = PACKED RECORD
		hidden:					ARRAY [0..255] OF INTEGER;				{ only for temporary use }
	END;

	DateCachePtr = ^DateCacheRecord;

	BreakTable = RECORD
		charTypes:				PACKED ARRAY [0..255] OF CHAR;
		tripleLength:			INTEGER;
		triples:				ARRAY [0..0] OF INTEGER;
	END;

	BreakTablePtr = ^BreakTable;

{ New NBreakTable for System 7.0: }
	NBreakTable = RECORD
		flags1:					SInt8;
		flags2:					SInt8;
		version:				INTEGER;
		classTableOff:			INTEGER;
		auxCTableOff:			INTEGER;
		backwdTableOff:			INTEGER;
		forwdTableOff:			INTEGER;
		doBackup:				INTEGER;
		length:					INTEGER;								{ length of NBreakTable }
		charTypes:				PACKED ARRAY [0..255] OF CHAR;
		tables:					ARRAY [0..0] OF INTEGER;
	END;

	NBreakTablePtr = ^NBreakTable;


FUNCTION InitDateCache(theCache: DateCachePtr): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8204, $FFF8, $A8B5;
	{$ENDC}
FUNCTION Munger(h: Handle; offset: LONGINT; ptr1: UNIV Ptr; len1: LONGINT; ptr2: UNIV Ptr; len2: LONGINT): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9E0;
	{$ENDC}
FUNCTION NewString(theString: ConstStr255Param): StringHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A906;
	{$ENDC}
PROCEDURE SetString(theString: StringHandle; strNew: ConstStr255Param);
	{$IFC NOT GENERATINGCFM}
	INLINE $A907;
	{$ENDC}
FUNCTION GetString(stringID: INTEGER): StringHandle;
	{$IFC NOT GENERATINGCFM}
	INLINE $A9BA;
	{$ENDC}
PROCEDURE GetIndString(VAR theString: Str255; strListID: INTEGER; index: INTEGER);
FUNCTION ScriptOrder(script1: ScriptCode; script2: ScriptCode): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $001E, $A9ED;
	{$ENDC}
FUNCTION StyledLineBreak(textPtr: Ptr; textLen: LONGINT; textStart: LONGINT; textEnd: LONGINT; flags: LONGINT; VAR textWidth: Fixed; VAR textOffset: LONGINT): StyledLineBreakCode;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $821C, $FFFE, $A8B5;
	{$ENDC}
FUNCTION TruncString(width: INTEGER; VAR theString: Str255; truncWhere: TruncCode): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8208, $FFE0, $A8B5;
	{$ENDC}
FUNCTION TruncText(width: INTEGER; textPtr: Ptr; VAR length: INTEGER; truncWhere: TruncCode): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $820C, $FFDE, $A8B5;
	{$ENDC}
FUNCTION ReplaceText(baseText: Handle; substitutionText: Handle; VAR key: Str15): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $820C, $FFDC, $A8B5;
	{$ENDC}
PROCEDURE FindWordBreaks(textPtr: Ptr; textLength: INTEGER; offset: INTEGER; leadingEdge: BOOLEAN; breaks: BreakTablePtr; VAR offsets: OffsetTable; script: ScriptCode);
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $C012, $001A, $A8B5;
	{$ENDC}
PROCEDURE LowercaseText(textPtr: Ptr; len: INTEGER; script: ScriptCode);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0000, $2F3C, $800A, $FFB6, $A8B5;
	{$ENDC}
PROCEDURE UppercaseText(textPtr: Ptr; len: INTEGER; script: ScriptCode);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0400, $2F3C, $800A, $FFB6, $A8B5;
	{$ENDC}
PROCEDURE StripDiacritics(textPtr: Ptr; len: INTEGER; script: ScriptCode);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0200, $2F3C, $800A, $FFB6, $A8B5;
	{$ENDC}
PROCEDURE UppercaseStripDiacritics(textPtr: Ptr; len: INTEGER; script: ScriptCode);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0600, $2F3C, $800A, $FFB6, $A8B5;
	{$ENDC}
FUNCTION FindScriptRun(textPtr: Ptr; textLen: LONGINT; VAR lenUsed: LONGINT): ScriptRunStatus;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $820C, $0026, $A8B5;
	{$ENDC}
FUNCTION EqualString(str1: ConstStr255Param; str2: ConstStr255Param; caseSensitive: BOOLEAN; diacSensitive: BOOLEAN): BOOLEAN;
PROCEDURE UpperString(VAR theString: Str255; diacSensitive: BOOLEAN);
PROCEDURE StringToNum(theString: ConstStr255Param; VAR theNum: LONGINT);
PROCEDURE NumToString(theNum: LONGINT; VAR theString: Str255);
FUNCTION RelString(str1: ConstStr255Param; str2: ConstStr255Param; caseSensitive: BOOLEAN; diacSensitive: BOOLEAN): INTEGER;
FUNCTION StringToDate(textPtr: Ptr; textLen: LONGINT; theCache: DateCachePtr; VAR lengthUsed: LONGINT; VAR dateTime: LongDateRec): StringToDateStatus;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8214, $FFF6, $A8B5;
	{$ENDC}
FUNCTION StringToTime(textPtr: Ptr; textLen: LONGINT; theCache: DateCachePtr; VAR lengthUsed: LONGINT; VAR dateTime: LongDateRec): StringToDateStatus;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8214, $FFF4, $A8B5;
	{$ENDC}
FUNCTION ExtendedToString({CONST}VAR x: extended80; {CONST}VAR myCanonical: NumFormatString; {CONST}VAR partsTable: NumberParts; VAR outString: Str255): FormatStatus;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8210, $FFE8, $A8B5;
	{$ENDC}
FUNCTION StringToExtended(source: ConstStr255Param; {CONST}VAR myCanonical: NumFormatString; {CONST}VAR partsTable: NumberParts; VAR x: extended80): FormatStatus;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8210, $FFE6, $A8B5;
	{$ENDC}
FUNCTION StringToFormatRec(inString: ConstStr255Param; {CONST}VAR partsTable: NumberParts; VAR outString: NumFormatString): FormatStatus;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $820C, $FFEC, $A8B5;
	{$ENDC}
FUNCTION FormatRecToString({CONST}VAR myCanonical: NumFormatString; {CONST}VAR partsTable: NumberParts; VAR outString: Str255; VAR positions: TripleInt): FormatStatus;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8210, $FFEA, $A8B5;
	{$ENDC}
{
	The following functions are old names, but are required for PowerPC builds
	becuase InterfaceLib exports these names, instead of the new ones.
}
FUNCTION IUMagString(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000A, $A9ED;
	{$ENDC}
FUNCTION IUMagIDString(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000C, $A9ED;
	{$ENDC}
FUNCTION IUMagPString(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; itl2Handle: Handle): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $001A, $A9ED;
	{$ENDC}
FUNCTION IUMagIDPString(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; itl2Handle: Handle): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $001C, $A9ED;
	{$ENDC}
PROCEDURE IUDateString(dateTime: LONGINT; longFlag: ByteParameter; VAR result: Str255);
	{$IFC NOT GENERATINGCFM}
	INLINE $4267, $A9ED;
	{$ENDC}
PROCEDURE IUTimeString(dateTime: LONGINT; wantSeconds: BOOLEAN; VAR result: Str255);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0002, $A9ED;
	{$ENDC}
PROCEDURE IUDatePString(dateTime: LONGINT; longFlag: ByteParameter; VAR result: Str255; intlHandle: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000E, $A9ED;
	{$ENDC}
PROCEDURE IUTimePString(dateTime: LONGINT; wantSeconds: BOOLEAN; VAR result: Str255; intlHandle: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0010, $A9ED;
	{$ENDC}
PROCEDURE IULDateString(VAR dateTime: LongDateTime; longFlag: ByteParameter; VAR result: Str255; intlHandle: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0014, $A9ED;
	{$ENDC}
PROCEDURE IULTimeString(VAR dateTime: LongDateTime; wantSeconds: BOOLEAN; VAR result: Str255; intlHandle: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0016, $A9ED;
	{$ENDC}
FUNCTION IUScriptOrder(script1: ScriptCode; script2: ScriptCode): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $001E, $A9ED;
	{$ENDC}
FUNCTION IULangOrder(language1: LangCode; language2: LangCode): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0020, $A9ED;
	{$ENDC}
FUNCTION IUTextOrder(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; aScript: ScriptCode; bScript: ScriptCode; aLang: LangCode; bLang: LangCode): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0022, $A9ED;
	{$ENDC}
PROCEDURE FindWord(textPtr: Ptr; textLength: INTEGER; offset: INTEGER; leadingEdge: BOOLEAN; breaks: BreakTablePtr; VAR offsets: OffsetTable);
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8012, $001A, $A8B5;
	{$ENDC}
PROCEDURE NFindWord(textPtr: Ptr; textLength: INTEGER; offset: INTEGER; leadingEdge: BOOLEAN; nbreaks: NBreakTablePtr; VAR offsets: OffsetTable);
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8012, $FFE2, $A8B5;
	{$ENDC}
PROCEDURE UprText(textPtr: Ptr; len: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $205F, $A054;
	{$ENDC}
PROCEDURE LwrText(textPtr: Ptr; len: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $205F, $A056;
	{$ENDC}
PROCEDURE LowerText(textPtr: Ptr; len: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $205F, $A056;
	{$ENDC}
PROCEDURE StripText(textPtr: Ptr; len: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $205F, $A256;
	{$ENDC}
PROCEDURE UpperText(textPtr: Ptr; len: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $205F, $A456;
	{$ENDC}
PROCEDURE StripUpperText(textPtr: Ptr; len: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $301F, $205F, $A656;
	{$ENDC}
FUNCTION IUCompPString(aStr: ConstStr255Param; bStr: ConstStr255Param; itl2Handle: Handle): INTEGER;
FUNCTION IUEqualPString(aStr: ConstStr255Param; bStr: ConstStr255Param; itl2Handle: Handle): INTEGER;
FUNCTION IUStringOrder(aStr: ConstStr255Param; bStr: ConstStr255Param; aScript: ScriptCode; bScript: ScriptCode; aLang: LangCode; bLang: LangCode): INTEGER;
FUNCTION IUCompString(aStr: ConstStr255Param; bStr: ConstStr255Param): INTEGER;
FUNCTION IUEqualString(aStr: ConstStr255Param; bStr: ConstStr255Param): INTEGER;
{
	The following provide direct function prototypes for new names for 68k
}
PROCEDURE DateString(dateTime: LONGINT; longFlag: ByteParameter; VAR result: Str255; intlHandle: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $000E, $A9ED;
	{$ENDC}
PROCEDURE TimeString(dateTime: LONGINT; wantSeconds: BOOLEAN; VAR result: Str255; intlHandle: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0010, $A9ED;
	{$ENDC}
PROCEDURE LongDateString(VAR dateTime: LongDateTime; longFlag: ByteParameter; VAR result: Str255; intlHandle: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0014, $A9ED;
	{$ENDC}
PROCEDURE LongTimeString(VAR dateTime: LongDateTime; wantSeconds: BOOLEAN; VAR result: Str255; intlHandle: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0016, $A9ED;
	{$ENDC}
FUNCTION CompareString(aStr: ConstStr255Param; bStr: ConstStr255Param; itl2Handle: Handle): INTEGER;
FUNCTION IdenticalString(aStr: ConstStr255Param; bStr: ConstStr255Param; itl2Handle: Handle): INTEGER;
FUNCTION CompareText(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; itl2Handle: Handle): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $001A, $A9ED;
	{$ENDC}
FUNCTION IdenticalText(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; itl2Handle: Handle): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $001C, $A9ED;
	{$ENDC}
FUNCTION LanguageOrder(language1: LangCode; language2: LangCode): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0020, $A9ED;
	{$ENDC}
FUNCTION TextOrder(aPtr: UNIV Ptr; bPtr: UNIV Ptr; aLen: INTEGER; bLen: INTEGER; aScript: ScriptCode; bScript: ScriptCode; aLang: LangCode; bLang: LangCode): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0022, $A9ED;
	{$ENDC}
FUNCTION StringOrder(aStr: ConstStr255Param; bStr: ConstStr255Param; aScript: ScriptCode; bScript: ScriptCode; aLang: LangCode; bLang: LangCode): INTEGER;
{$IFC NOT OLDROUTINELOCATIONS }
PROCEDURE C2PStrProc(aStr: UNIV Ptr);
FUNCTION C2PStr(cString: UNIV Ptr): StringPtr;
PROCEDURE P2CStrProc(aStr: StringPtr);
FUNCTION P2CStr(pString: StringPtr): Ptr;
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := TextUtilsIncludes}

{$ENDC} {__TEXTUTILS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

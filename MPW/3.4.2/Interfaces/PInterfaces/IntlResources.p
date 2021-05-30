{
 	File:		IntlResources.p
 
 	Contains:	International Resource definitions.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
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
 UNIT IntlResources;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __INTLRESOURCES__}
{$SETC __INTLRESOURCES__ := 1}

{$I+}
{$SETC IntlResourcesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{ Bits in the itlcFlags byte }
	itlcShowIcon				= 7;							{Show icon even if only one script}
	itlcDualCaret				= 6;							{Use dual caret for mixed direction text}
{ Bits in the itlcSysFlags word }
	itlcSysDirection			= 15;							{System direction - left to right/right to left}
	tokLeftQuote				= 0;
	tokRightQuote				= 1;
	tokLeadPlacer				= 2;
	tokLeader					= 3;
	tokNonLeader				= 4;
	tokZeroLead					= 5;
	tokPercent					= 6;
	tokPlusSign					= 7;
	tokMinusSign				= 8;
	tokThousands				= 9;
	tokSeparator				= 11;							{10 is a reserved field}
	tokEscape					= 12;
	tokDecPoint					= 13;
	tokEPlus					= 14;
	tokEMinus					= 15;
	tokMaxSymbols				= 30;
	curNumberPartsVersion		= 1;							{current version of NumberParts record}

	currSymLead					= 16;
	currNegSym					= 32;
	currTrailingZ				= 64;
	currLeadingZ				= 128;

	mdy							= 0;
	dmy							= 1;
	ymd							= 2;
	myd							= 3;
	dym							= 4;
	ydm							= 5;

	
TYPE
	DateOrders = SInt8;


CONST
	timeCycle24					= 0;							{time sequence 0:00 - 23:59}
	timeCycleZero				= 1;							{time sequence 0:00-11:59, 0:00 - 11:59}
	timeCycle12					= 255;							{time sequence 12:00 - 11:59, 12:00 - 11:59}
	zeroCycle					= 1;							{old name for timeCycleZero}
	longDay						= 0;							{day of the month}
	longWeek					= 1;							{day of the week}
	longMonth					= 2;							{month of the year}
	longYear					= 3;							{year}
	supDay						= 1;							{suppress day of month}
	supWeek						= 2;							{suppress day of week}
	supMonth					= 4;							{suppress month}
	supYear						= 8;							{suppress year}
	dayLdingZ					= 32;
	mntLdingZ					= 64;
	century						= 128;
	secLeadingZ					= 32;
	minLeadingZ					= 64;
	hrLeadingZ					= 128;

{ move OffsetTable to QuickdrawText }

TYPE
	Intl0Rec = PACKED RECORD
		decimalPt:				CHAR;									{decimal point character}
		thousSep:				CHAR;									{thousands separator character}
		listSep:				CHAR;									{list separator character}
		currSym1:				CHAR;									{currency symbol}
		currSym2:				CHAR;
		currSym3:				CHAR;
		currFmt:				UInt8;									{currency format flags}
		dateOrder:				UInt8;									{order of short date elements: mdy, dmy, etc.}
		shrtDateFmt:			UInt8;									{format flags for each short date element}
		dateSep:				CHAR;									{date separator character}
		timeCycle:				UInt8;									{specifies time cycle: 0..23, 1..12, or 0..11}
		timeFmt:				UInt8;									{format flags for each time element}
		mornStr:				PACKED ARRAY [1..4] OF CHAR;			{trailing string for AM if 12-hour cycle}
		eveStr:					PACKED ARRAY [1..4] OF CHAR;			{trailing string for PM if 12-hour cycle}
		timeSep:				CHAR;									{time separator character}
		time1Suff:				CHAR;									{trailing string for AM if 24-hour cycle}
		time2Suff:				CHAR;
		time3Suff:				CHAR;
		time4Suff:				CHAR;
		time5Suff:				CHAR;									{trailing string for PM if 24-hour cycle}
		time6Suff:				CHAR;
		time7Suff:				CHAR;
		time8Suff:				CHAR;
		metricSys:				UInt8;									{255 if metric, 0 if inches etc.}
		intl0Vers:				INTEGER;								{region code (hi byte) and version (lo byte)}
	END;

	Intl0Ptr = ^Intl0Rec;
	Intl0Hndl = ^Intl0Ptr;

	Intl1Rec = PACKED RECORD
		days:					ARRAY [1..7] OF Str15;					{day names}
		months:					ARRAY [1..12] OF Str15;					{month names}
		suppressDay:			UInt8;									{255 for no day, or flags to suppress any element}
		lngDateFmt:				UInt8;									{order of long date elements}
		dayLeading0:			UInt8;									{255 for leading 0 in day number}
		abbrLen:				UInt8;									{length for abbreviating names}
		st0:					PACKED ARRAY [1..4] OF CHAR;			{separator strings for long date format}
		st1:					PACKED ARRAY [1..4] OF CHAR;
		st2:					PACKED ARRAY [1..4] OF CHAR;
		st3:					PACKED ARRAY [1..4] OF CHAR;
		st4:					PACKED ARRAY [1..4] OF CHAR;
		intl1Vers:				INTEGER;								{region code (hi byte) and version (lo byte)}
		localRtn:				ARRAY [0..0] OF INTEGER;				{now a flag for opt extension}
	END;

	Intl1Ptr = ^Intl1Rec;
	Intl1Hndl = ^Intl1Ptr;

{fields for optional itl1 extension}
	Itl1ExtRec = RECORD
		base:					Intl1Rec;								{un-extended Intl1Rec}
		version:				INTEGER;
		format:					INTEGER;
		calendarCode:			INTEGER;								{calendar code for this itl1 resource}
		extraDaysTableOffset:	LONGINT;								{offset in itl1 to extra days table}
		extraDaysTableLength:	LONGINT;								{length of extra days table}
		extraMonthsTableOffset:	LONGINT;								{offset in itl1 to extra months table}
		extraMonthsTableLength:	LONGINT;								{length of extra months table}
		abbrevDaysTableOffset:	LONGINT;								{offset in itl1 to abbrev days table}
		abbrevDaysTableLength:	LONGINT;								{length of abbrev days table}
		abbrevMonthsTableOffset: LONGINT;								{offset in itl1 to abbrev months table}
		abbrevMonthsTableLength: LONGINT;								{length of abbrev months table}
		extraSepsTableOffset:	LONGINT;								{offset in itl1 to extra seps table}
		extraSepsTableLength:	LONGINT;								{length of extra seps table}
		tables:					ARRAY [0..0] OF INTEGER;				{now a flag for opt extension}
	END;

	UntokenTable = RECORD
		len:					INTEGER;
		lastToken:				INTEGER;
		index:					ARRAY [0..255] OF INTEGER;				{index table; last = lastToken}
	END;

	UntokenTablePtr = ^UntokenTable;
	UntokenTableHandle = ^UntokenTablePtr;

	WideChar = RECORD
		CASE INTEGER OF
		0: (
			a:							PACKED ARRAY [0..1] OF CHAR;		{0 is the high order character}
		   );
		1: (
			b:							INTEGER;
		   );
	END;

	WideCharArr = RECORD
		size:					INTEGER;
		data:					ARRAY [0..9] OF WideChar;
	END;

	NumberParts = RECORD
		version:				INTEGER;
		data:					PACKED ARRAY [0..30] OF WideChar;		{index by [tokLeftQuote..tokMaxSymbols]}
		pePlus:					WideCharArr;
		peMinus:				WideCharArr;
		peMinusPlus:			WideCharArr;
		altNumTable:			WideCharArr;
		reserved:				PACKED ARRAY [0..19] OF CHAR;
	END;

	NumberPartsPtr = ^NumberParts;

	Itl4Rec = RECORD
		flags:					INTEGER;								{reserved}
		resourceType:			LONGINT;								{contains 'itl4'}
		resourceNum:			INTEGER;								{resource ID}
		version:				INTEGER;								{version number}
		resHeader1:				LONGINT;								{reserved}
		resHeader2:				LONGINT;								{reserved}
		numTables:				INTEGER;								{number of tables, one-based}
		mapOffset:				LONGINT;								{offset to table that maps byte to token}
		strOffset:				LONGINT;								{offset to routine that copies canonical string}
		fetchOffset:			LONGINT;								{offset to routine that gets next byte of character}
		unTokenOffset:			LONGINT;								{offset to table that maps token to canonical string}
		defPartsOffset:			LONGINT;								{offset to default number parts table}
		resOffset6:				LONGINT;								{reserved}
		resOffset7:				LONGINT;								{reserved}
		resOffset8:				LONGINT;								{reserved}
	END;

	Itl4Ptr = ^Itl4Rec;
	Itl4Handle = ^Itl4Ptr;

{ New NItl4Rec for System 7.0: }
	NItl4Rec = RECORD
		flags:					INTEGER;								{reserved}
		resourceType:			LONGINT;								{contains 'itl4'}
		resourceNum:			INTEGER;								{resource ID}
		version:				INTEGER;								{version number}
		format:					INTEGER;								{format code}
		resHeader:				INTEGER;								{reserved}
		resHeader2:				LONGINT;								{reserved}
		numTables:				INTEGER;								{number of tables, one-based}
		mapOffset:				LONGINT;								{offset to table that maps byte to token}
		strOffset:				LONGINT;								{offset to routine that copies canonical string}
		fetchOffset:			LONGINT;								{offset to routine that gets next byte of character}
		unTokenOffset:			LONGINT;								{offset to table that maps token to canonical string}
		defPartsOffset:			LONGINT;								{offset to default number parts table}
		whtSpListOffset:		LONGINT;								{offset to white space code list}
		resOffset7:				LONGINT;								{reserved}
		resOffset8:				LONGINT;								{reserved}
		resLength1:				INTEGER;								{reserved}
		resLength2:				INTEGER;								{reserved}
		resLength3:				INTEGER;								{reserved}
		unTokenLength:			INTEGER;								{length of untoken table}
		defPartsLength:			INTEGER;								{length of default number parts table}
		whtSpListLength:		INTEGER;								{length of white space code list}
		resLength7:				INTEGER;								{reserved}
		resLength8:				INTEGER;								{reserved}
	END;

	NItl4Ptr = ^NItl4Rec;
	NItl4Handle = ^NItl4Ptr;

	TableDirectoryRecord = RECORD
		tableSignature:			OSType;									{4 byte long table name }
		reserved:				LONGINT;								{Reserved for internal use }
		tableStartOffset:		LONGINT;								{Table start offset in byte}
		tableSize:				LONGINT;								{Table size in byte}
	END;

	Itl5Record = RECORD
		versionNumber:			Fixed;									{itl5 resource version number }
		numberOfTables:			INTEGER;								{Number of tables it contains }
		reserved:				ARRAY [0..2] OF INTEGER;				{Reserved for internal use }
		tableDirectory:			ARRAY [0..0] OF TableDirectoryRecord;	{Table directory records }
	END;

	RuleBasedTrslRecord = RECORD
		sourceType:				INTEGER;								{Transliterate target type for the LHS of the rule }
		targetType:				INTEGER;								{Transliterate target type for the RHS of the rule }
		formatNumber:			INTEGER;								{Transliterate resource format number }
		propertyFlag:			INTEGER;								{Transliterate property flags }
		numberOfRules:			INTEGER;								{Number of rules following this field }
	END;

	ItlcRecord = RECORD
		itlcSystem:				INTEGER;								{default system script}
		itlcReserved:			INTEGER;								{reserved}
		itlcFontForce:			SInt8;									{default font force flag}
		itlcIntlForce:			SInt8;									{default intl force flag}
		itlcOldKybd:			SInt8;									{MacPlus intl keybd flag}
		itlcFlags:				SInt8;									{general flags}
		itlcIconOffset:			INTEGER;								{keyboard icon offset; not used in 7.0}
		itlcIconSide:			SInt8;									{keyboard icon side; not used in 7.0}
		itlcIconRsvd:			SInt8;									{rsvd for other icon info}
		itlcRegionCode:			INTEGER;								{preferred verXxx code}
		itlcSysFlags:			INTEGER;								{flags for setting system globals}
		itlcReserved4:			PACKED ARRAY [0..31] OF SInt8;			{for future use}
	END;

	ItlbRecord = RECORD
		itlbNumber:				INTEGER;								{itl0 id number}
		itlbDate:				INTEGER;								{itl1 id number}
		itlbSort:				INTEGER;								{itl2 id number}
		itlbFlags:				INTEGER;								{Script flags}
		itlbToken:				INTEGER;								{itl4 id number}
		itlbEncoding:			INTEGER;								{itl5 ID # (optional; char encoding)}
		itlbLang:				INTEGER;								{current language for script }
		itlbNumRep:				SInt8;									{number representation code}
		itlbDateRep:			SInt8;									{date representation code }
		itlbKeys:				INTEGER;								{KCHR id number}
		itlbIcon:				INTEGER;								{ID # of SICN or kcs#/kcs4/kcs8 suite.}
	END;

{ New ItlbExtRecord structure for System 7.0 }
	ItlbExtRecord = PACKED RECORD
		base:					ItlbRecord;								{un-extended ItlbRecord}
		itlbLocalSize:			LONGINT;								{size of script's local record}
		itlbMonoFond:			INTEGER;								{default monospace FOND ID}
		itlbMonoSize:			INTEGER;								{default monospace font size}
		itlbPrefFond:			INTEGER;								{preferred FOND ID}
		itlbPrefSize:			INTEGER;								{preferred font size}
		itlbSmallFond:			INTEGER;								{default small FOND ID}
		itlbSmallSize:			INTEGER;								{default small font size}
		itlbSysFond:			INTEGER;								{default system FOND ID}
		itlbSysSize:			INTEGER;								{default system font size}
		itlbAppFond:			INTEGER;								{default application FOND ID}
		itlbAppSize:			INTEGER;								{default application font size}
		itlbHelpFond:			INTEGER;								{default Help Mgr FOND ID}
		itlbHelpSize:			INTEGER;								{default Help Mgr font size}
		itlbValidStyles:		Style;									{set of valid styles for script}
		itlbAliasStyle:			Style;									{style (set) to mark aliases}
	END;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := IntlResourcesIncludes}

{$ENDC} {__INTLRESOURCES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

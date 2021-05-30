{
     File:       DateTimeUtils.p
 
     Contains:   International Date and Time Interfaces (previously in TextUtils)
 
     Version:    Technology: Mac OS 8.5
                 Release:    Universal Interfaces 3.4
 
     Copyright:  © 1994-2001 by Apple Computer, Inc., all rights reserved.
 
     Bugs?:      For bug reports, consult the following page on
                 the World Wide Web:
 
                     http://developer.apple.com/bugreporter/
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT DateTimeUtils;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __DATETIMEUTILS__}
{$SETC __DATETIMEUTILS__ := 1}

{$I+}
{$SETC DateTimeUtilsIncludes := UsingIncludes}
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

    Here are the current routine names and the translations to the older forms.
    Please use the newer forms in all new code and migrate the older names out of existing
    code as maintainance permits.
    
    New Name                    Old Name(s)
    
    DateString                  IUDatePString IUDateString 
    InitDateCache
    LongDateString              IULDateString
    LongTimeString              IULTimeString
    StringToDate                String2Date
    StringToTime                                
    TimeString                  IUTimeString IUTimePString
    LongDateToSeconds           LongDate2Secs
    LongSecondsToDate           LongSecs2Date
    DateToSeconds               Date2Secs
    SecondsToDate               Secs2Date


    Carbon only supports the new names.  The old names are undefined for Carbon targets.
    This is true for C, Assembly and Pascal.
    
    InterfaceLib always has exported the old names.  For C macros have been defined to allow
    the use of the new names.  For Pascal and Assembly using the new names will result
    in link errors. 
    
}


TYPE
	ToggleResults 				= SInt16;
CONST
																{  Toggle results  }
	toggleUndefined				= 0;
	toggleOK					= 1;
	toggleBadField				= 2;
	toggleBadDelta				= 3;
	toggleBadChar				= 4;
	toggleUnknown				= 5;
	toggleBadNum				= 6;
	toggleOutOfRange			= 7;							{ synonym for toggleErr3 }
	toggleErr3					= 7;
	toggleErr4					= 8;
	toggleErr5					= 9;

																{  Date equates  }
	smallDateBit				= 31;							{ Restrict valid date/time to range of Time global }
	togChar12HourBit			= 30;							{ If toggling hour by char, accept hours 1..12 only }
	togCharZCycleBit			= 29;							{ Modifier for togChar12HourBit: accept hours 0..11 only }
	togDelta12HourBit			= 28;							{ If toggling hour up/down, restrict to 12-hour range (am/pm) }
	genCdevRangeBit				= 27;							{ Restrict date/time to range used by genl CDEV }
	validDateFields				= -1;
	maxDateField				= 10;

	eraMask						= $0001;
	yearMask					= $0002;
	monthMask					= $0004;
	dayMask						= $0008;
	hourMask					= $0010;
	minuteMask					= $0020;
	secondMask					= $0040;
	dayOfWeekMask				= $0080;
	dayOfYearMask				= $0100;
	weekOfYearMask				= $0200;
	pmMask						= $0400;
	dateStdMask					= $007F;						{ default for ValidDate flags and ToggleDate TogglePB.togFlags }


TYPE
	LongDateField 				= SInt8;
CONST
	eraField					= 0;
	yearField					= 1;
	monthField					= 2;
	dayField					= 3;
	hourField					= 4;
	minuteField					= 5;
	secondField					= 6;
	dayOfWeekField				= 7;
	dayOfYearField				= 8;
	weekOfYearField				= 9;
	pmField						= 10;
	res1Field					= 11;
	res2Field					= 12;
	res3Field					= 13;


TYPE
	DateForm 					= SInt8;
CONST
	shortDate					= 0;
	longDate					= 1;
	abbrevDate					= 2;

																{  StringToDate status values  }
	fatalDateTime				= $8000;						{  StringToDate and String2Time mask to a fatal error  }
	longDateFound				= 1;							{  StringToDate mask to long date found  }
	leftOverChars				= 2;							{  StringToDate & Time mask to warn of left over characters  }
	sepNotIntlSep				= 4;							{  StringToDate & Time mask to warn of non-standard separators  }
	fieldOrderNotIntl			= 8;							{  StringToDate & Time mask to warn of non-standard field order  }
	extraneousStrings			= 16;							{  StringToDate & Time mask to warn of unparsable strings in text  }
	tooManySeps					= 32;							{  StringToDate & Time mask to warn of too many separators  }
	sepNotConsistent			= 64;							{  StringToDate & Time mask to warn of inconsistent separators  }
	tokenErr					= $8100;						{  StringToDate & Time mask for 'tokenizer err encountered'  }
	cantReadUtilities			= $8200;
	dateTimeNotFound			= $8400;
	dateTimeInvalid				= $8800;


TYPE
	StringToDateStatus					= INTEGER;
	String2DateStatus					= StringToDateStatus;
	DateCacheRecordPtr = ^DateCacheRecord;
	DateCacheRecord = PACKED RECORD
		hidden:					ARRAY [0..255] OF INTEGER;				{  only for temporary use  }
	END;

	DateCachePtr						= ^DateCacheRecord;
	DateTimeRecPtr = ^DateTimeRec;
	DateTimeRec = RECORD
		year:					INTEGER;
		month:					INTEGER;
		day:					INTEGER;
		hour:					INTEGER;
		minute:					INTEGER;
		second:					INTEGER;
		dayOfWeek:				INTEGER;
	END;

	LongDateTime						= SInt64;
	LongDateTimePtr 					= ^LongDateTime;
	LongDateCvtPtr = ^LongDateCvt;
	LongDateCvt = RECORD
		CASE INTEGER OF
		0: (
			c:					SInt64;
			);
		1: (
			lHigh:				UInt32;
			lLow:				UInt32;
		   );
	END;

	LongDateRecPtr = ^LongDateRec;
	LongDateRec = RECORD
		CASE INTEGER OF
		0: (
			era:				INTEGER;
			year:				INTEGER;
			month:				INTEGER;
			day:				INTEGER;
			hour:				INTEGER;
			minute:				INTEGER;
			second:				INTEGER;
			dayOfWeek:			INTEGER;
			dayOfYear:			INTEGER;
			weekOfYear:			INTEGER;
			pm:					INTEGER;
			res1:				INTEGER;
			res2:				INTEGER;
			res3:				INTEGER;
		   );
		1: (
			list:				ARRAY [0..13] OF INTEGER;				{ Index by LongDateField! }
			);
		2: (
			eraAlt:				INTEGER;
			oldDate:			DateTimeRec;
		   );
	END;

	DateDelta							= SInt8;
	TogglePBPtr = ^TogglePB;
	TogglePB = RECORD
		togFlags:				LONGINT;								{ caller normally sets low word to dateStdMask=$7F }
		amChars:				ResType;								{ from 'itl0', but uppercased }
		pmChars:				ResType;								{ from 'itl0', but uppercased }
		reserved:				ARRAY [0..3] OF LONGINT;
	END;

	{	
	    These routine are available in Carbon with their new name
		}
	{
	 *  DateString()
	 *  
	 *  Availability:
	 *    Non-Carbon CFM:   not available
	 *    CarbonLib:        in CarbonLib 1.0 and later
	 *    Mac OS X:         in version 10.0 or later
	 	}
PROCEDURE DateString(dateTime: LONGINT; longFlag: ByteParameter; VAR result: Str255; intlHandle: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000E, $A9ED;
	{$ENDC}

{
 *  TimeString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE TimeString(dateTime: LONGINT; wantSeconds: BOOLEAN; VAR result: Str255; intlHandle: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0010, $A9ED;
	{$ENDC}

{
 *  LongDateString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LongDateString({CONST}VAR dateTime: LongDateTime; longFlag: ByteParameter; VAR result: Str255; intlHandle: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0014, $A9ED;
	{$ENDC}

{
 *  LongTimeString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LongTimeString({CONST}VAR dateTime: LongDateTime; wantSeconds: BOOLEAN; VAR result: Str255; intlHandle: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0016, $A9ED;
	{$ENDC}


{
    These routine are available in Carbon and InterfaceLib with their new name
}
{
 *  InitDateCache()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION InitDateCache(theCache: DateCachePtr): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8204, $FFF8, $A8B5;
	{$ENDC}

{
 *  StringToDate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION StringToDate(textPtr: Ptr; textLen: LONGINT; theCache: DateCachePtr; VAR lengthUsed: LONGINT; VAR dateTime: LongDateRec): StringToDateStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8214, $FFF6, $A8B5;
	{$ENDC}

{
 *  StringToTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION StringToTime(textPtr: Ptr; textLen: LONGINT; theCache: DateCachePtr; VAR lengthUsed: LONGINT; VAR dateTime: LongDateRec): StringToDateStatus;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8214, $FFF4, $A8B5;
	{$ENDC}

{
 *  LongDateToSeconds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LongDateToSeconds({CONST}VAR lDate: LongDateRec; VAR lSecs: LongDateTime);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8008, $FFF2, $A8B5;
	{$ENDC}

{
 *  LongSecondsToDate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE LongSecondsToDate({CONST}VAR lSecs: LongDateTime; VAR lDate: LongDateRec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8008, $FFF0, $A8B5;
	{$ENDC}

{
 *  ToggleDate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ToggleDate(VAR lSecs: LongDateTime; field: ByteParameter; delta: DateDelta; ch: INTEGER; {CONST}VAR params: TogglePB): ToggleResults;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $820E, $FFEE, $A8B5;
	{$ENDC}

{
 *  ValidDate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ValidDate({CONST}VAR vDate: LongDateRec; flags: LONGINT; VAR newSecs: LongDateTime): INTEGER;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $820C, $FFE4, $A8B5;
	{$ENDC}

{
 *  ReadDateTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION ReadDateTime(VAR time: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A039, $3E80;
	{$ENDC}

{
 *  GetDateTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetDateTime(VAR secs: UInt32);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $20B8, $020C;
	{$ENDC}

{
 *  SetDateTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
FUNCTION SetDateTime(time: UInt32): OSErr;
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $201F, $A03A, $3E80;
	{$ENDC}

{
 *  SetTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SetTime({CONST}VAR d: DateTimeRec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $A9C7, $A03A;
	{$ENDC}

{
 *  GetTime()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE GetTime(VAR d: DateTimeRec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $2038, $020C, $A9C6;
	{$ENDC}

{
 *  DateToSeconds()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE DateToSeconds({CONST}VAR d: DateTimeRec; VAR secs: UInt32);

{
 *  SecondsToDate()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        in CarbonLib 1.0 and later
 *    Mac OS X:         in version 10.0 or later
 }
PROCEDURE SecondsToDate(secs: UInt32; VAR d: DateTimeRec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $201F, $A9C6;
	{$ENDC}


{
    These routine are available in InterfaceLib using their old name.
    Macros allow using the new names in all source code.
}
{$IFC CALL_NOT_IN_CARBON }
{
 *  IUDateString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE IUDateString(dateTime: LONGINT; longFlag: ByteParameter; VAR result: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $4267, $A9ED;
	{$ENDC}

{
 *  IUTimeString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE IUTimeString(dateTime: LONGINT; wantSeconds: BOOLEAN; VAR result: Str255);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0002, $A9ED;
	{$ENDC}

{
 *  IUDatePString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE IUDatePString(dateTime: LONGINT; longFlag: ByteParameter; VAR result: Str255; intlHandle: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $000E, $A9ED;
	{$ENDC}

{
 *  IUTimePString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE IUTimePString(dateTime: LONGINT; wantSeconds: BOOLEAN; VAR result: Str255; intlHandle: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0010, $A9ED;
	{$ENDC}

{
 *  IULDateString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE IULDateString(VAR dateTime: LongDateTime; longFlag: ByteParameter; VAR result: Str255; intlHandle: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0014, $A9ED;
	{$ENDC}

{
 *  IULTimeString()
 *  
 *  Availability:
 *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE IULTimeString(VAR dateTime: LongDateTime; wantSeconds: BOOLEAN; VAR result: Str255; intlHandle: Handle);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $3F3C, $0016, $A9ED;
	{$ENDC}


{$ENDC}  {CALL_NOT_IN_CARBON}

{$IFC OLDROUTINENAMES }
{$IFC CALL_NOT_IN_CARBON }
{
 *  LongDate2Secs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE LongDate2Secs({CONST}VAR lDate: LongDateRec; VAR lSecs: LongDateTime);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8008, $FFF2, $A8B5;
	{$ENDC}

{
 *  LongSecs2Date()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE LongSecs2Date(VAR lSecs: LongDateTime; VAR lDate: LongDateRec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $2F3C, $8008, $FFF0, $A8B5;
	{$ENDC}

{
 *  Date2Secs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE Date2Secs({CONST}VAR d: DateTimeRec; VAR secs: UInt32);

{
 *  Secs2Date()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE Secs2Date(secs: UInt32; VAR d: DateTimeRec);
	{$IFC TARGET_OS_MAC AND TARGET_CPU_68K AND NOT TARGET_RT_MAC_CFM}
	INLINE $205F, $201F, $A9C6;
	{$ENDC}

{$ENDC}  {CALL_NOT_IN_CARBON}
{$ENDC}  {OLDROUTINENAMES}




{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := DateTimeUtilsIncludes}

{$ENDC} {__DATETIMEUTILS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

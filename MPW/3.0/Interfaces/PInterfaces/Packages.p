{
Created: Monday, November 7, 1988 at 7:00 PM
    Packages.p
    Pascal Interface to the Macintosh Libraries

    Copyright Apple Computer, Inc.  1985-1988
    All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT Packages;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingPackages}
{$SETC UsingPackages := 1}

{$I+}
{$SETC PackagesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$IFC UNDEFINED UsingDialogs}
{$I $$Shell(PInterfaces)Dialogs.p}
{$ENDC}
{$IFC UNDEFINED UsingFiles}
{$I $$Shell(PInterfaces)Files.p}
{$ENDC}
{$SETC UsingIncludes := PackagesIncludes}

CONST
listMgr = 0;                                {list manager}
dskInit = 2;                                {Disk Initializaton}
stdFile = 3;                                {Standard File}
flPoint = 4;                                {Floating-Point Arithmetic}
trFunc = 5;                                 {Transcendental Functions}
intUtil = 6;                                {International Utilities}
bdConv = 7;                                 {Binary/Decimal Conversion}
putDlgID = -3999;
putSave = 1;
putCancel = 2;
putEject = 5;
putDrive = 6;
putName = 7;
getDlgID = -4000;
getOpen = 1;
getCancel = 3;
getEject = 5;
getDrive = 6;
getNmList = 7;
getScroll = 8;
currSymLead = 16;
currNegSym = 32;
currTrailingZ = 64;
currLeadingZ = 128;
zeroCycle = 1;                              {0:00 AM/PM format}
longDay = 0;                                {day of the month}
longWeek = 1;                               {day of the week}
longMonth = 2;                              {month of the year}
longYear = 3;                               {year}
supDay = 1;                                 {suppress day of month}
supWeek = 2;                                {suppress day of week}
supMonth = 4;                               {suppress month}
supYear = 8;                                {suppress year}
dayLdingZ = 32;
mntLdingZ = 64;
century = 128;
secLeadingZ = 32;
minLeadingZ = 64;
hrLeadingZ = 128;

{ Date Orders }

mdy = 0;
dmy = 1;
ymd = 2;
myd = 3;
dym = 4;
ydm = 5;

{ Country Version }

verUS = 0;
verFrance = 1;
verBritain = 2;
verGermany = 3;
verItaly = 4;
verNetherlands = 5;
verBelgiumLux = 6;
verSweden = 7;
verSpain = 8;
verDenmark = 9;
verPortugal = 10;
verFrCanada = 11;
verNorway = 12;
verIsrael = 13;
verJapan = 14;
verAustralia = 15;
verArabia = 16;
verFinland = 17;
verFrSwiss = 18;
verGrSwiss = 19;
verGreece = 20;
verIceland = 21;
verMalta = 22;
verCyprus = 23;
verTurkey = 24;
verYugoslavia = 25;
verIreland = 50;
verKorea = 51;
verChina = 52;
verTaiwan = 53;
verThailand = 54;
minCountry = verUS;
maxCountry = verThailand;


TYPE

DateForm = (shortDate,longDate,abbrevDate);


SFReply = RECORD
    good: BOOLEAN;
    copy: BOOLEAN;
    fType: OSType;
    vRefNum: INTEGER;
    version: INTEGER;
    fName: Str63;
    END;

SFTypeList = ARRAY [0..3] OF OSType;

Intl0Ptr = ^Intl0Rec;
Intl0Hndl = ^Intl0Ptr;
Intl0Rec = PACKED RECORD
    decimalPt: CHAR;                        {decimal point character}
    thousSep: CHAR;                         {thousands separator}
    listSep: CHAR;                          {list separator}
    currSym1: CHAR;                         {currency symbol}
    currSym2: CHAR;
    currSym3: CHAR;
    currFmt: Byte;                          {currency format}
    dateOrder: Byte;                        {order of short date elements}
    shrtDateFmt: Byte;                      {short date format}
    dateSep: CHAR;                          {date separator}
    timeCycle: Byte;                        {0 if 24-hour cycle, 255 if 12-hour}
    timeFmt: Byte;                          {time format}
    mornStr: PACKED ARRAY [1..4] OF CHAR;   {trailing string for first 12-hour cycle}
    eveStr: PACKED ARRAY [1..4] OF CHAR;    {trailing string for last 12-hour cycle}
    timeSep: CHAR;                          {time separator}
    time1Suff: CHAR;                        {trailing string for 24-hour cycle}
    time2Suff: CHAR;
    time3Suff: CHAR;
    time4Suff: CHAR;
    time5Suff: CHAR;
    time6Suff: CHAR;
    time7Suff: CHAR;
    time8Suff: CHAR;
    metricSys: Byte;                        {255 if metric, 0 if not}
    intl0Vers: INTEGER;                     {version information}
    END;

Intl1Ptr = ^Intl1Rec;
Intl1Hndl = ^Intl1Ptr;
Intl1Rec = PACKED RECORD
    days: ARRAY [1..7] OF Str15;            {day names}
    months: ARRAY [1..12] OF Str15;         {month names}
    suppressDay: Byte;                      {0 for day name, 255 for none}
    lngDateFmt: Byte;                       {order of long date elements}
    dayLeading0: Byte;                      {255 for leading 0 in day number}
    abbrLen: Byte;                          {length for abbreviating names}
    st0: PACKED ARRAY [1..4] OF CHAR;       {strings for long date format}
    st1: PACKED ARRAY [1..4] OF CHAR;
    st2: PACKED ARRAY [1..4] OF CHAR;
    st3: PACKED ARRAY [1..4] OF CHAR;
    st4: PACKED ARRAY [1..4] OF CHAR;
    intl1Vers: INTEGER;                     {version information}
    localRtn: ARRAY [0..0] OF INTEGER;      {routine for localizing string comparison}
    END;



PROCEDURE InitPack(packID: INTEGER);
    INLINE $A9E5;
PROCEDURE InitAllPacks;
    INLINE $A9E6;
FUNCTION IUGetIntl(theID: INTEGER): Handle;
PROCEDURE IUSetIntl(refNum: INTEGER;theID: INTEGER;intlParam: Handle);
PROCEDURE IUDateString(dateTime: LONGINT;longFlag: DateForm;VAR result: Str255);
PROCEDURE IUDatePString(dateTime: LONGINT;longFlag: DateForm;VAR result: Str255;
    intlParam: Handle);
FUNCTION IUMetric: BOOLEAN;
PROCEDURE IUTimePString(dateTime: LONGINT;wantSeconds: BOOLEAN;VAR result: Str255;
    intlParam: Handle);
FUNCTION IUMagString(aPtr: Ptr;bPtr: Ptr;aLen: INTEGER;bLen: INTEGER): INTEGER;
PROCEDURE IUTimeString(dateTime: LONGINT;wantSeconds: BOOLEAN;VAR result: Str255);
FUNCTION IUMagIDString(aPtr: Ptr;bPtr: Ptr;aLen: INTEGER;bLen: INTEGER): INTEGER;
FUNCTION IUCompString(aStr: Str255;bStr: Str255): INTEGER;
FUNCTION IUEqualString(aStr: Str255;bStr: Str255): INTEGER;
PROCEDURE SFGetFile(where: Point;prompt: Str255;fileFilter: ProcPtr;numTypes: INTEGER;
    typeList: SFTypeList;dlgHook: ProcPtr;VAR reply: SFReply);
PROCEDURE StringToNum(theString: Str255;VAR theNum: LONGINT);
PROCEDURE SFPGetFile(where: Point;prompt: Str255;fileFilter: ProcPtr;numTypes: INTEGER;
    typeList: SFTypeList;dlgHook: ProcPtr;VAR reply: SFReply;dlgID: INTEGER;
    filterProc: ProcPtr);
PROCEDURE NumToString(theNum: LONGINT;VAR theString: Str255);
PROCEDURE SFPPutFile(where: Point;prompt: Str255;origName: Str255;dlgHook: ProcPtr;
    VAR reply: SFReply;dlgID: INTEGER;filterProc: ProcPtr);
PROCEDURE SFPutFile(where: Point;prompt: Str255;origName: Str255;dlgHook: ProcPtr;
    VAR reply: SFReply);

{$ENDC}    { UsingPackages }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}


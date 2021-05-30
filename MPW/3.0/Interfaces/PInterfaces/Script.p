{
Created: Saturday, October 15, 1988 at 6:30 AM
    Script.p
    Pascal Interface to the Macintosh Libraries

    Copyright Apple Computer, Inc.  1986-1988
    All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
    UNIT Script;
    INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingScript}
{$SETC UsingScript := 1}

{$I+}
{$SETC ScriptIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}
{$IFC UNDEFINED UsingTypes}
{$I $$Shell(PInterfaces)Types.p}
{$ENDC}
{$IFC UNDEFINED UsingPackages}
{$I $$Shell(PInterfaces)Packages.p}
{$ENDC}
{$SETC UsingIncludes := ScriptIncludes}

CONST

{ Note that the version number is divided into two bytes:  The high byte is
bumped when the changes make the next version incompatible with previous
versions.  If compatability is maintained, the low byte is bumped. }

smgrVers = $0210;                                   {current version number.}

{ Script Interface System Numbers }

smRoman = 0;                                        {Font script is Roman.}
smJapanese = 1;                                     {Font script is Japanese.}
smChinese = 2;                                      {Font script is Chinese.}
smKorean = 3;                                       {Font script is Korean.}
smArabic = 4;                                       {Font script is Arabic.}
smHebrew = 5;                                       {Font script is Hebrew.}
smGreek = 6;                                        {Font script is Greek.}
smRussian = 7;                                      {Font script is Russian.}
smRSymbol = 8;                                      {Font script is Right-left symbol.}
smDevanagari = 9;                                   {Font script is Devanagari.}
smGurmukhi = 10;                                    {Font script is Gurmukhi.}
smGujarati = 11;                                    {Font script is Gujarati.}
smOriya = 12;                                       {Font script is Oriya.}
smBengali = 13;                                     {Font script is Bengali.}
smTamil = 14;                                       {Font script is Tamil.}
smTelugu = 15;                                      {Font script is Telugu.}
smKannada = 16;                                     {Font script is Kannada.}
smMalayalam = 17;                                   {Font script is Malayalam.}
smSinhalese = 18;                                   {Font script is Sinhalese.}
smBurmese = 19;                                     {Font script is Burmese.}
smKhmer = 20;                                       {Font script is Khmer.}
smThai = 21;                                        {Font script is Thai.}
smLaotian = 22;                                     {Font script is Laotian.}
smGeorgian = 23;                                    {Font script is Georgian.}
smArmenian = 24;                                    {Font script is Armenian.}
smMaldivian = 25;                                   {Font script is Maldivian.}
smTibetan = 26;                                     {Font script is Tibetan.}
smMongolian = 27;                                   {Font script is Mongolian.}
smAmharic = 28;                                     {Font script is Amharic.}
smSlavic = 29;                                      {Font script is Slavic.}
smVietnamese = 30;                                  {Font script is Vietnamese.}
smSindhi = 31;                                      {Font script is Sindhi.}
smUninterp = 32;                                    {Font script is uninterpreted symbols.}

{ Language Codes }

langEnglish = 0;
langFrench = 1;
langGerman = 2;
langItalian = 3;
langDutch = 4;
langSwedish = 5;
langSpanish = 6;
langDanish = 7;
langPortugese = 8;
langNorwegian = 9;
langHebrew = 10;
langJapanese = 11;
langArabic = 12;
langFinnish = 13;
langGreek = 14;
langIcelandic = 15;
langMalta = 16;
langTurkish = 17;
langYugoslavian = 18;
langChinese = 19;
langUrdu = 20;
langHindi = 21;
langThai = 22;

{ Calendar Codes }

calGregorian = 0;
calArabicCivil = 1;
calArabicLunar = 2;
calJapanese = 3;
calJewish = 4;
calCoptic = 5;

{ Integer Format Codes }

intWestern = 0;
intArabic = 1;
intRoman = 2;
intJapanese = 3;
intEuropean = 4;
intOutputMask = $8000;

{ CharByte byte types }

smSingleByte = 0;
smFirstByte = -1;
smLastByte = 1;
smMiddleByte = 2;

{ CharType field masks }

smcTypeMask = $000F;
smcReserved = $00F0;
smcClassMask = $0F00;
smcReserved12 = $1000;
smcRightMask = $2000;
smcUpperMask = $4000;
smcDoubleMask = $8000;

{ CharType character types }

smCharPunct = 0;
smCharAscii = 1;
smCharEuro = 7;

{ CharType punctuation types }

smPunctNormal = $0000;
smPunctNumber = $0100;
smPunctSymbol = $0200;
smPunctBlank = $0300;

{ CharType directions }

smCharLeft = $0000;
smCharRight = $2000;

{ CharType case modifers }

smCharLower = $0000;
smCharUpper = $4000;

{ CharType character size modifiers (1 or multiple bytes). }

smChar1byte = $0000;
smChar2byte = $8000;

{ Char2Pixel directions }

smLeftCaret = 0;                                    {Place caret for left block.}
smRightCaret = -1;                                  {Place caret for right block.}
smHilite = 1;                                       {Direction is TESysJust.}

{ Transliterate target types }

smTransAscii = 0;
smTransNative = 1;
smTransCase = $FF;

{ Transliterate target modifiers }

smTransLower = $4000;
smTransUpper = $8000;

{ Transliterate source masks }

smMaskAscii = $0001;
smMaskNative = $0002;

{ Result values from GetEnvirons, SetEnvirons, GetScript and SetScript calls. }

smNotInstalled = 0;                                 {routine not available in script}
smBadVerb = -1;                                     {Bad verb passed to a routine.}
smBadScript = -2;                                   {Bad script code passed to a routine.}

{ GetEnvirons and SetEnvirons verbs }

smVersion = 0;                                      {Environment version number.}
smMunged = 2;                                       {Globals change count.}
smEnabled = 4;                                      {Environment enabled flag.}
smBidirect = 6;                                     {At least on bidirect script.}
smFontForce = 8;                                    {Force font flag.}
smIntlForce = 10;                                   {Force intl flag.}
smForced = 12;                                      {script forced to system script.}
smDefault = 14;                                     {script defaulted to Roman script.}
smPrint = 16;                                       {Printer action routine.}
smSysScript = 18;                                   {System script.}
smLastScript = 20;                                  {Last keyboard script.}
smKeyScript = 22;                                   {Keyboard script.}
smSysRef = 24;                                      {System folder refNum.}
smKeyCache = 26;                                    {Keyboard table cache pointer.}
smKeySwap = 28;                                     {Swapping table pointer.}
smGenFlags = 30;                                    {General flags long}
smOverride = 32;                                    {Script override flags.}
smCharPortion = 34;                                 {Ch vs SpExtra proportion}
smLastEVerb = smCharPortion;                        {Last environment verb.}

{ GetScript and SetScript verbs.
Note: Verbs private to script systems are negative, while
those general across script systems are non-negative. }

smScriptVersion = 0;                                {Script software version.}
smScriptMunged = 2;                                 {Script entry changed count.}
smScriptEnabled = 4;                                {Script enabled flag.}
smScriptRight = 6;                                  {Right to left flag.}
smScriptJust = 8;                                   {Justification flag.}
smScriptRedraw = 10;                                {Word redraw flag.}
smScriptSysFond = 12;                               {Preferred system font.}
smScriptAppFond = 14;                               {Preferred Application font.}
smScriptBundle = 16;                                {Beginning of dictionary verbs.}
smScriptNumber = 16;                                {Script itl0 id from dictionary.}
smScriptDate = 18;                                  {Script itl1 id from dictionary.}
smScriptSort = 20;                                  {Script itl2 id from dictionary.}
smScriptFlags = 22;                                 {flags word.}
smScriptToken = 24;                                 {Script itl3 id, from dictionary.}
smScriptRsvd3 = 26;                                 {reserved.}
smScriptLang = 28;                                  {Current language for script.}
smScriptNumDate = 30;                               {Script Number/Date formats.}
smScriptKeys = 32;                                  {Script KEYC id from dictionary.}
smScriptIcon = 34;                                  {Script SICN id from dictionary.}
smScriptPrint = 36;                                 {Script printer action routine.}
smScriptTrap = 38;                                  {Trap entry pointer.}
smScriptCreator = 40;                               {Script file creator.}
smScriptFile = 42;                                  {Script file name.}
smScriptName = 44;                                  {Script name.}
smLastSVerb = smScriptName;                         {Last script verb.}

{ Bits in the smScriptFlags word
(bits above 7 are non-static) }

smsfIntellCP = 0;                                   {script has intellegent cut & paste}
smsfSingByte = 1;                                   {script has only single bytes}
smsfNatCase = 2;                                    {native chars have upper & lower case}
smsfContext = 3;                                    {contextual script (e.g. AIS-based)}
smsfNoForceFont = 4;                                {Will not force characters.}
smsfB0Digits = 5;                                   {Has alternate digits at B0-B9.}
smsfForms = 13;                                     {Uses contextual forms for letters.}
smsfLigatures = 14;                                 {Uses contextual ligatures.}
smsfReverse = 15;                                   {Reverses native text, right-left.}

{ Bits in the smGenFlags long.
First byte is set from itlc flags byte. }

smfShowIcon = 31;                                   {Show icon even if only one script.}
smfDualCaret = 30;                                  {Use dual caret for mixed direction text.}

{ Roman script constants }

romanVers = $0101;                                  {version number}
romanSysFond = $3FFF;                               {system font id number}
romanAppFond = 3;                                   {application font id number.}
romanFlags = $0007;                                 {roman settings}

{ Script Manager font equates. }

smFondStart = $4000;                                {start from 16K.}
smFondEnd = $C000;                                  {past end of range at 48K.}

{ Character Set Extensions }

diaeresisUprY = $D9;
fraction = $DA;
intlCurrency = $DB;
leftSingGuillemet = $DC;
rightSingGuillemet = $DD;
fiLigature = $DE;
flLigature = $DF;
dblDagger = $E0;
centeredDot = $E1;
baseSingQuote = $E2;
baseDblQuote = $E3;
perThousand = $E4;
circumflexUprA = $E5;
circumflexUprE = $E6;
acuteUprA = $E7;
diaeresisUprE = $E8;
graveUprE = $E9;
acuteUprI = $EA;
circumflexUprI = $EB;
diaeresisUprI = $EC;
graveUprI = $ED;
acuteUprO = $EE;
circumflexUprO = $EF;
appleLogo = $F0;
graveUprO = $F1;
acuteUprU = $F2;
circumflexUprU = $F3;
graveUprU = $F4;
dotlessLwrI = $F5;
circumflex = $F6;
tilde = $F7;
macron = $F8;
breve = $F9;
overDot = $FA;
ring = $FB;
cedilla = $FC;
doubleAcute = $FD;
ogonek = $FE;
hachek = $FF;

{ String2Date status values }

fatalDateTime = $8000;
longDateFound = 1;
leftOverChars = 2;
sepNotIntlSep = 4;
fieldOrderNotIntl = 8;
extraneousStrings = 16;
tooManySeps = 32;
sepNotConsistent = 64;
tokenErr = $8100;
cantReadUtilities = $8200;
dateTimeNotFound = $8400;
dateTimeInvalid = $8800;

{ TokenType values }

tokenIntl = 4;                                      {the itl resource number of the tokenizer}
tokenEmpty = -1;
tokenUnknown = 0;
tokenWhite = 1;
tokenLeftLit = 2;
tokenRightLit = 3;
tokenAlpha = 4;
tokenNumeric = 5;
tokenNewLine = 6;
tokenLeftComment = 7;
tokenRightComment = 8;
tokenLiteral = 9;
tokenEscape = 10;
tokenAltNum = 11;
tokenRealNum = 12;
tokenAltReal = 13;
tokenReserve1 = 14;
tokenReserve2 = 15;
tokenLeftParen = 16;
tokenRightParen = 17;
tokenLeftBracket = 18;
tokenRightBracket = 19;
tokenLeftCurly = 20;
tokenRightCurly = 21;
tokenLeftEnclose = 22;
tokenRightEnclose = 23;
tokenPlus = 24;
tokenMinus = 25;
tokenAsterisk = 26;
tokenDivide = 27;
tokenPlusMinus = 28;
tokenSlash = 29;
tokenBackSlash = 30;
tokenLess = 31;
tokenGreat = 32;
tokenEqual = 33;
tokenLessEqual2 = 34;
tokenLessEqual1 = 35;
tokenGreatEqual2 = 36;
tokenGreatEqual1 = 37;
token2Equal = 38;
tokenColonEqual = 39;
tokenNotEqual = 40;
tokenLessGreat = 41;
tokenExclamEqual = 42;
tokenExclam = 43;
tokenTilda = 44;
tokenComma = 45;
tokenPeriod = 46;
tokenLeft2Quote = 47;
tokenRight2Quote = 48;
tokenLeft1Quote = 49;
tokenRight1Quote = 50;
token2Quote = 51;
token1Quote = 52;
tokenSemicolon = 53;
tokenPercent = 54;
tokenCarat = 55;
tokenUnderline = 56;
tokenAmpersand = 57;
tokenAtSign = 58;
tokenBar = 59;
tokenQuestion = 60;
tokenPi = 61;
tokenRoot = 62;
tokenSigma = 63;
tokenIntegral = 64;
tokenMicro = 65;
tokenCapPi = 66;
tokenInfinity = 67;
tokenColon = 68;
tokenHash = 69;
tokenDollar = 70;
tokenNoBreakSpace = 71;
tokenNil = 127;
delimPad = -2;

{ the NumberParts indeces }

tokLeftQuote = 1;
tokRightQuote = 2;
tokLeadPlacer = 3;
tokLeader = 4;
tokNonLeader = 5;
tokZeroLead = 6;
tokPercent = 7;
tokPlusSign = 8;
tokMinusSign = 9;
tokThousands = 10;
tokSeparator = 12;                                  {11 is a reserved field}
tokEscape = 13;
tokDecPoint = 14;
tokEPlus = 15;
tokEMinus = 16;
tokMaxSymbols = 31;
curNumberPartsVersion = 1;                          {current version of NumberParts record}

{  Date equates }

smallDateBit = 31;
validDateFields = -1;
maxDateField = 10;
eraMask = $0001;
yearMask = $0002;
monthMask = $0004;
dayMask = $0008;
hourMask = $0010;
minuteMask = $0020;
secondMask = $0040;
dayOfWeekMask = $0080;
dayOfYearMask = $0100;
weekOfYearMask = $0200;
pmMask = $0400;
dateStdMask = $007F;
fVNumber = 0;                                       {first version of NumFormatString}


TYPE

TokenResults = (tokenOK,tokenOverflow,stringOverflow,badDelim,badEnding,
    crash);

LongDateField = (eraField,yearField,monthField,dayField,hourField,minuteField,
    secondField,dayOfWeekField,dayOfYearField,weekOfYearField,pmField,res1Field,
    res2Field,res3Field);

StyledLineBreakCode = (smBreakWord,smBreakChar,smBreakOverflow);

FormatClass = (fPositive,fNegative,fZero);

ToggleResults = (toggleUndefined,toggleOk,toggleBadField,toggleBadDelta,
    toggleBadChar,toggleUnknown,toggleBadNum,toggleErr3,toggleErr4,toggleErr5);

FormatResultType = (fFormatOK,fBestGuess,fOutOfSynch,fSpuriousChars,fMissingDelimiter,
    fExtraDecimal,fMissingLiteral,fExtraExp,fFormatOverflow,fFormStrIsNAN,
    fBadPartsTable,fExtraPercent,fExtraSeparator,fEmptyFormatString);


CharByteTable = PACKED ARRAY [0..255] OF SignedByte;

BreakTablePtr = ^BreakTable;
BreakTable = RECORD
    charTypes: ARRAY [0..255] OF SignedByte;
    tripleLength: INTEGER;
    triples: ARRAY [0..0] OF INTEGER;
    END;

OffPair = RECORD
    offFirst: INTEGER;
    offSecond: INTEGER;
    END;

OffsetTable = ARRAY [0..2] of OffPair;

ItlcRecord = RECORD
    itlcSystem: INTEGER;                            {default system script.}
    itlcReserved: INTEGER;                          {reserved}
    itlcFontForce: SignedByte;                      {default font force flag}
    itlcIntlForce: SignedByte;                      {default intl force flag.}
    itlcOldKybd: SignedByte;                        {old keyboard}
    itlcFlags: SignedByte;                          {general flags}
    itlcReserved2: ARRAY [0..39] OF SignedByte;     {for future use}
    END;

ItlbRecord = RECORD
    itlbNumber: INTEGER;                            {ITL0 id number.}
    itlbDate: INTEGER;                              {ITL1 id number.}
    itlbSort: INTEGER;                              {ITL2 id number.}
    itlbFlags: INTEGER;                             {Script flags}
    itlbToken: INTEGER;                             {ITL4 id number.}
    itlbReserved3: INTEGER;                         {reserved.}
    itlbLang: INTEGER;                              {cur language for script }
    itlbNumRep: SignedByte;                         {number representation code}
    itlbDateRep: SignedByte;                        {date representation code }
    itlbKeys: INTEGER;                              {KCHR id number.}
    itlbIcon: INTEGER;                              {SICN id number.}
    END;

MachineLocation = RECORD
    latitude: Fract;
    longitude: Fract;
    CASE INTEGER OF
      0:
        (dlsDelta: SignedByte);                     {signed byte; daylight savings delta}
      1:
        (gmtDelta: LONGINT);                        {must mask - see documentation}
    END;

String2DateStatus = INTEGER;

TokenType = INTEGER;

DelimType = ARRAY [0..1] OF TokenType;

CommentType = ARRAY [0..3] OF TokenType;

TokenRecPtr = ^TokenRec;
TokenRec = RECORD
    theToken: TokenType;
    position: Ptr;                                  {pointer into original Source}
    length: LONGINT;                                {length of text in original source}
    stringPosition: StringPtr;                      {Pascal/C string copy of identifier}
    END;

TokenBlockPtr = ^TokenBlock;
TokenBlock = RECORD
    source: Ptr;                                    {pointer to stream of characters}
    sourceLength: LONGINT;                          {length of source stream}
    tokenList: Ptr;                                 {pointer to array of tokens}
    tokenLength: LONGINT;                           {maximum length of TokenList}
    tokenCount: LONGINT;                            {number tokens generated by tokenizer}
    stringList: Ptr;                                {pointer to stream of identifiers}
    stringLength: LONGINT;                          {length of string list}
    stringCount: LONGINT;                           {number of bytes currently used}
    doString: BOOLEAN;                              {make strings & put into StringLIst}
    doAppend: BOOLEAN;                              {append to TokenList rather than replace}
    doAlphanumeric: BOOLEAN;                        {identifiers may include numeric}
    doNest: BOOLEAN;                                {do comments nest?}
    leftDelims: ARRAY [0..1] OF TokenType;
    rightDelims: ARRAY [0..1] OF TokenType;
    leftComment: ARRAY [0..3] OF TokenType;
    rightComment: ARRAY [0..3] OF TokenType;
    escapeCode: TokenType;                          {escape symbol code}
    decimalCode: TokenType;
    itlResource: Handle;                            {ptr to itl4 resource of current script}
    reserved: ARRAY [0..7] OF LONGINT;              {must be zero!}
    END;

UntokenTablePtr = ^UntokenTable;
UntokenTableHandle = ^UntokenTablePtr;
UntokenTable = RECORD
    len: INTEGER;
    lastToken: INTEGER;
    index: ARRAY [0..255] OF INTEGER;               {index table; last = lastToken}
    END;

DateCachePtr = ^DateCacheRecord;
DateCacheRecord = PACKED RECORD
    hidden: ARRAY [0..255] OF INTEGER;              {only for temporary use}
    END;

LongDateTime = Comp;

LongDateCvt = RECORD
    CASE INTEGER OF
      0:
        (c: Comp);
      1:
        (lHigh: LONGINT;
        lLow: LONGINT);
    END;

LongDateRec = RECORD
    CASE INTEGER OF
      0:
        (era: INTEGER;
        year: INTEGER;
        month: INTEGER;
        day: INTEGER;
        hour: INTEGER;
        minute: INTEGER;
        second: INTEGER;
        dayOfWeek: INTEGER;
        dayOfYear: INTEGER;
        weekOfYear: INTEGER;
        pm: INTEGER;
        res1: INTEGER;
        res2: INTEGER;
        res3: INTEGER);
      1:
        (list: ARRAY [0..13] OF INTEGER);           {Index by LongDateField!}
      2:
        (eraAlt: INTEGER;
        oldDate: DateTimeRec);
    END;

DateDelta = SignedByte;

TogglePB = RECORD
    togFlags: LONGINT;                              {default $7E}
    amChars: ResType;                               {from intl0}
    pmChars: ResType;                               {from intl0}
    reserved: ARRAY [0..3] OF LONGINT;
    END;

FormatOrderPtr = ^FormatOrder;
FormatOrder = ARRAY [0..0] OF INTEGER;

FormatStatus = INTEGER;

WideChar = RECORD
    CASE BOOLEAN OF
      TRUE:
        (a: PACKED ARRAY [0..1] OF CHAR);           {0 is the high order character}
      FALSE:
        (b: INTEGER);
    END;

WideCharArr = RECORD
    size: INTEGER;
    data: PACKED ARRAY [0..9] OF WideChar;
    END;

NumFormatString = PACKED RECORD
    fLength: Byte;
    fVersion: Byte;
    data: PACKED ARRAY [0..253] OF SignedByte;      {private data}
    END;

Itl4Ptr = ^Itl4Rec;
Itl4Handle = ^Itl4Ptr;
Itl4Rec = RECORD
    flags: INTEGER;
    resourceType: LONGINT;
    resourceNum: INTEGER;
    version: INTEGER;
    resHeader1: LONGINT;
    resHeader2: LONGINT;
    numTables: INTEGER;                             {one-based}
    mapOffset: LONGINT;                             {offsets are from record start}
    strOffset: LONGINT;
    fetchOffset: LONGINT;
    unTokenOffset: LONGINT;
    defPartsOffset: LONGINT;
    resOffset6: LONGINT;
    resOffset7: LONGINT;
    resOffset8: LONGINT;
    END;

NumberPartsPtr = ^NumberParts;
NumberParts = RECORD
    version: INTEGER;
    data: ARRAY [1..31] OF WideChar;                {index by [tokLeftQuote..tokMaxSymbols]}
    pePlus: WideCharArr;
    peMinus: WideCharArr;
    peMinusPlus: WideCharArr;
    altNumTable: WideCharArr;
    reserved: PACKED ARRAY [0..19] OF CHAR;
    END;

FVector = RECORD
    start: INTEGER;
    length: INTEGER;
    END;

TripleInt = ARRAY [0..2] OF FVector;                { index by [fPositive..fZero] }

ScriptRunStatus = RECORD
    script: SignedByte;
    variant: SignedByte;
    END;



FUNCTION FontScript: INTEGER;
    INLINE $2F3C,$8200,$0000,$A8B5;
FUNCTION IntlScript: INTEGER;
    INLINE $2F3C,$8200,$0002,$A8B5;
PROCEDURE KeyScript(code: INTEGER);
    INLINE $2F3C,$8002,$0004,$A8B5;
FUNCTION Font2Script(fontNumber: INTEGER): INTEGER;
    INLINE $2F3C,$8202,$0006,$A8B5;
FUNCTION GetEnvirons(verb: INTEGER): LONGINT;
    INLINE $2F3C,$8402,$0008,$A8B5;
FUNCTION SetEnvirons(verb: INTEGER;param: LONGINT): OSErr;
    INLINE $2F3C,$8206,$000A,$A8B5;
FUNCTION GetScript(script: INTEGER;verb: INTEGER): LONGINT;
    INLINE $2F3C,$8404,$000C,$A8B5;
FUNCTION SetScript(script: INTEGER;verb: INTEGER;param: LONGINT): OSErr;
    INLINE $2F3C,$8208,$000E,$A8B5;
FUNCTION CharByte(textBuf: Ptr;textOffset: INTEGER): INTEGER;
    INLINE $2F3C,$8206,$0010,$A8B5;
FUNCTION CharType(textBuf: Ptr;textOffset: INTEGER): INTEGER;
    INLINE $2F3C,$8206,$0012,$A8B5;
FUNCTION Pixel2Char(textBuf: Ptr;textLen: INTEGER;slop: INTEGER;pixelWidth: INTEGER;
    VAR leftSide: BOOLEAN): INTEGER;
    INLINE $2F3C,$820E,$0014,$A8B5;
FUNCTION Char2Pixel(textBuf: Ptr;textLen: INTEGER;slop: INTEGER;offset: INTEGER;
    direction: INTEGER): INTEGER;
    INLINE $2F3C,$820C,$0016,$A8B5;
FUNCTION Transliterate(srcHandle: Handle;dstHandle: Handle;target: INTEGER;
    srcMask: LONGINT): OSErr;
    INLINE $2F3C,$820E,$0018,$A8B5;
PROCEDURE FindWord(textPtr: Ptr;textLength: INTEGER;offset: INTEGER;leftSide: BOOLEAN;
    breaks: BreakTablePtr;VAR offsets: OffsetTable);
    INLINE $2F3C,$8012,$001A,$A8B5;
PROCEDURE HiliteText(textPtr: Ptr;textLength: INTEGER;firstOffset: INTEGER;
    secondOffset: INTEGER;VAR offsets: OffsetTable);
    INLINE $2F3C,$800E,$001C,$A8B5;
PROCEDURE DrawJust(textPtr: Ptr;textLength: INTEGER;slop: INTEGER);
    INLINE $2F3C,$8008,$001E,$A8B5;
PROCEDURE MeasureJust(textPtr: Ptr;textLength: INTEGER;slop: INTEGER;charLocs: Ptr);
    INLINE $2F3C,$800C,$0020,$A8B5;
FUNCTION ParseTable(table: CharByteTable): BOOLEAN;
    INLINE $2F3C,$8204,$0022,$A8B5;
FUNCTION GetDefFontSize: INTEGER;
    INLINE $3EB8,$0BA8,$6604,$3EBC,$000C;
FUNCTION GetSysFont: INTEGER;
    INLINE $3EB8,$0BA6;
FUNCTION GetAppFont: INTEGER;
    INLINE $3EB8,$0984;
FUNCTION GetMBarHeight: INTEGER;
    INLINE $3EB8,$0BAA;
FUNCTION GetSysJust: INTEGER;
    INLINE $3EB8,$0BAC;
PROCEDURE SetSysJust(newJust: INTEGER);
    INLINE $31DF,$0BAC;
PROCEDURE ReadLocation(VAR loc: MachineLocation);
    INLINE $205F,$203C,$000C,$00E4,$A051;
PROCEDURE WriteLocation(loc: MachineLocation);
    INLINE $205F,$203C,$000C,$00E4,$A052;
PROCEDURE UprText(textPtr: Ptr;len: INTEGER);
    INLINE $301F,$205F,$A054;
PROCEDURE LwrText(textPtr: Ptr;len: INTEGER);
    INLINE $301F,$205F,$A056;
FUNCTION StyledLineBreak(textPtr: Ptr;textLen: LONGINT;textStart: LONGINT;
    textEnd: LONGINT;flags: LONGINT;VAR textWidth: Fixed;VAR textOffset: LONGINT): StyledLineBreakCode;
    INLINE $2F3C,$821C,$FFFE,$A8B5;
PROCEDURE GetFormatOrder(ordering: FormatOrderPtr;firstFormat: INTEGER;
    lastFormat: INTEGER;lineRight: BOOLEAN;rlDirProc: Ptr;dirParam: Ptr);
    INLINE $2F3C,$8012,$FFFC,$A8B5;
FUNCTION IntlTokenize(tokenParam: TokenBlockPtr): TokenResults;
    INLINE $2F3C,$8204,$FFFA,$A8B5;
FUNCTION InitDateCache(theCache: DateCachePtr): OSErr;
    INLINE $2F3C,$8204,$FFF8,$A8B5;
FUNCTION String2Date(textPtr: Ptr;textLen: LONGINT;theCache: DateCachePtr;
    VAR lengthUsed: LONGINT;VAR dateTime: LongDateRec): String2DateStatus;
    INLINE $2F3C,$8214,$FFF6,$A8B5;
FUNCTION String2Time(textPtr: Ptr;textLen: LONGINT;theCache: DateCachePtr;
    VAR lengthUsed: LONGINT;VAR dateTime: LongDateRec): String2DateStatus;
    INLINE $2F3C,$8214,$FFF4,$A8B5;
PROCEDURE LongDate2Secs(lDate: LongDateRec;VAR lSecs: LongDateTime);
    INLINE $2F3C,$8008,$FFF2,$A8B5;
PROCEDURE LongSecs2Date(VAR lSecs: LongDateTime;VAR lDate: LongDateRec);
    INLINE $2F3C,$8008,$FFF0,$A8B5;
FUNCTION ToggleDate(VAR lSecs: LongDateTime;field: LongDateField;delta: DateDelta;
    ch: INTEGER;params: TogglePB): ToggleResults;
    INLINE $2F3C,$820E,$FFEE,$A8B5;
FUNCTION Str2Format(inString: Str255;partsTable: NumberParts;VAR outString: NumFormatString): FormatStatus;
    INLINE $2F3C,$820C,$FFEC,$A8B5;
FUNCTION Format2Str(myCanonical: NumFormatString;partsTable: NumberParts;
    VAR outString: Str255;VAR positions: TripleInt): FormatStatus;
    INLINE $2F3C,$8210,$FFEA,$A8B5;
FUNCTION FormatX2Str(x: Extended;myCanonical: NumFormatString;partsTable: NumberParts;
    VAR outString: Str255): FormatStatus;
    INLINE $2F3C,$8210,$FFE8,$A8B5;
FUNCTION FormatStr2X(source: Str255;myCanonical: NumFormatString;partsTable: NumberParts;
    VAR x: Extended): FormatStatus;
    INLINE $2F3C,$8210,$FFE6,$A8B5;
FUNCTION PortionText(textPtr: Ptr;textLen: LONGINT): Fixed;
    INLINE $2F3C,$8408,$0024,$A8B5;
FUNCTION FindScriptRun(textPtr: Ptr;textLen: LONGINT;VAR lenUsed: LONGINT): ScriptRunStatus;
    INLINE $2F3C,$820C,$0026,$A8B5;
FUNCTION VisibleLength(textPtr: Ptr;textLen: LONGINT): LONGINT;
    INLINE $2F3C,$8408,$0028,$A8B5;
FUNCTION ValidDate(VAR vDate: LongDateRec;flags: LONGINT;VAR newSecs: LongDateTime): INTEGER;
    INLINE $2F3C,$8204,$FFE4,$A8B5;
PROCEDURE IULDateString(VAR dateTime: LongDateTime;longFlag: DateForm;VAR result: Str255;
    intlParam: Handle);
    INLINE $3F3C,$0014,$A9ED;
PROCEDURE IULTimeString(VAR dateTime: LongDateTime;wantSeconds: BOOLEAN;
    VAR result: Str255;intlParam: Handle);
    INLINE $3F3C,$0016,$A9ED;

{$ENDC}    { UsingScript }

{$IFC NOT UsingIncludes}
    END.
{$ENDC}


/************************************************************

Created: Tuesday, September 12, 1989 at 6:35 PM
	Script.h
	C Interface to the Macintosh Libraries


	Copyright Apple Computer, Inc.	1986-1989
	All rights reserved

************************************************************/


#ifndef __SCRIPT__
#define __SCRIPT__

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __PACKAGES__
#include <Packages.h>
#endif


/* Note that the version number is divided into two bytes:	The high byte is
bumped when the changes make the next version incompatible with previous
versions.  If compatability is maintained, the low byte is bumped. The low
byte is maintained privately by the Script Manager, and is shown as 0 here. */

#define smgrVers 0x0200 			/*current version number.*/

/* Script Interface System Numbers */

#define smRoman 0					/*Font script is Roman.*/
#define smJapanese 1				/*Font script is Japanese.*/
#define smChinese 2 				/*Font script is Chinese.*/
#define smKorean 3					/*Font script is Korean.*/
#define smArabic 4					/*Font script is Arabic.*/
#define smHebrew 5					/*Font script is Hebrew.*/
#define smGreek 6					/*Font script is Greek.*/
#define smRussian 7 				/*Font script is Russian.*/
#define smRSymbol 8 				/*Font script is Right-left symbol.*/
#define smDevanagari 9				/*Font script is Devanagari.*/
#define smGurmukhi 10				/*Font script is Gurmukhi.*/
#define smGujarati 11				/*Font script is Gujarati.*/
#define smOriya 12					/*Font script is Oriya.*/
#define smBengali 13				/*Font script is Bengali.*/
#define smTamil 14					/*Font script is Tamil.*/
#define smTelugu 15 				/*Font script is Telugu.*/
#define smKannada 16				/*Font script is Kannada.*/
#define smMalayalam 17				/*Font script is Malayalam.*/
#define smSinhalese 18				/*Font script is Sinhalese.*/
#define smBurmese 19				/*Font script is Burmese.*/
#define smKhmer 20					/*Font script is Khmer.*/
#define smThai 21					/*Font script is Thai.*/
#define smLaotian 22				/*Font script is Laotian.*/
#define smGeorgian 23				/*Font script is Georgian.*/
#define smArmenian 24				/*Font script is Armenian.*/
#define smMaldivian 25				/*Font script is Maldivian.*/
#define smTibetan 26				/*Font script is Tibetan.*/
#define smMongolian 27				/*Font script is Mongolian.*/
#define smAmharic 28				/*Font script is Amharic.*/
#define smGeez 28					/*Font script is Amharic.*/
#define smSlavic 29 				/*Font script is Slavic.*/
#define smVietnamese 30 			/*Font script is Vietnamese.*/
#define smSindhi 31 				/*Font script is Sindhi.*/
#define smUninterp 32				/*Font script is uninterpreted symbols.*/

/* Language Codes */

#define langEnglish 0
#define langFrench 1
#define langGerman 2
#define langItalian 3
#define langDutch 4
#define langSwedish 5
#define langSpanish 6
#define langDanish 7
#define langPortugese 8
#define langNorwegian 9
#define langHebrew 10
#define langJapanese 11
#define langArabic 12
#define langFinnish 13
#define langGreek 14
#define langIcelandic 15
#define langMalta 16
#define langTurkish 17
#define langYugoslavian 18
#define langChinese 19
#define langUrdu 20
#define langHindi 21
#define langThai 22

/* Calendar Codes */

#define calGregorian 0
#define calArabicCivil 1
#define calArabicLunar 2
#define calJapanese 3
#define calJewish 4
#define calCoptic 5

/* Integer Format Codes */

#define intWestern 0
#define intArabic 1
#define intRoman 2
#define intJapanese 3
#define intEuropean 4
#define intOutputMask 0x8000

/* CharByte byte types */

#define smSingleByte 0
#define smFirstByte -1
#define smLastByte 1
#define smMiddleByte 2

/* CharType field masks */

#define smcTypeMask 0x000F
#define smcReserved 0x00F0
#define smcClassMask 0x0F00
#define smcReserved12 0x1000
#define smcRightMask 0x2000
#define smcUpperMask 0x4000
#define smcDoubleMask 0x8000

/* CharType character types */

#define smCharPunct 0
#define smCharAscii 1
#define smCharEuro 7

/* additional CharType character types for FIS character sets */

#define smCharFISKana 2 			/*Katakana*/
#define smCharFISGana 3 			/*Hiragana*/
#define smCharFISIdeo 4 			/*Hanzi, Kanji, Hanja*/
#define smCharFISGreek 5			/*Greek (2-byte)*/
#define smCharFISRussian 6			/*Russian/Cyrillic (2-byte)*/
#define smCharFISHangul 8			/*Hangul (**tentative**)*/

/* CharType classes (smCharPunct sub-types) */

#define smPunctNormal 0x0000
#define smPunctNumber 0x0100
#define smPunctSymbol 0x0200
#define smPunctBlank 0x0300

/* additional CharType classes for FIS (smCharFISIdeo sub-types) */

#define smFISClassLvl1 0x0000		/*level 1 char*/
#define smFISClassLvl2 0x0100		/*level 2 char*/
#define smFISClassUser 0x0200		/*user char*/

/* CharType directions */

#define smCharLeft 0x0000
#define smCharRight 0x2000

/* CharType case modifers */

#define smCharLower 0x0000
#define smCharUpper 0x4000

/* CharType character size modifiers (1 or multiple bytes). */

#define smChar1byte 0x0000
#define smChar2byte 0x8000

/* Char2Pixel directions */

#define smLeftCaret 0				/*Place caret for left block.*/
#define smRightCaret -1 			/*Place caret for right block.*/
#define smHilite 1					/*Direction is TESysJust.*/

/* Transliterate target types */

#define smTransAscii 0
#define smTransNative 1
#define smTransCase 0xFE
#define smTransSystem 0xFF			/*convert to system script*/

/* Transliterate target types for FIS */

#define smTransAscii1 2 			/*1-byte Roman*/
#define smTransAscii2 3 			/*2-byte Roman*/
#define smTransKana1 4				/*1-byte Katakana*/
#define smTransKana2 5				/*2-byte Katakana*/
#define smTransGana2 7				/*2-byte Hiragana (no 1-byte Hiragana)*/

/* Transliterate target modifiers */

#define smTransLower 0x4000
#define smTransUpper 0x8000

/* Transliterate source mask - general */

#define smMaskAll 0xFFFFFFFF		/*Convert all text*/

/* Transliterate source masks */

#define smMaskAscii 0x00000001		/*2^smTransAscii*/
#define smMaskNative 0x00000002 	/*2^smTransNative*/

/* Transliterate source masks for FIS */

#define smMaskAscii1 0x00000004 	/*2^smTransAscii1*/
#define smMaskAscii2 0x00000008 	/*2^smTransAscii2*/
#define smMaskKana1 0x00000010		/*2^smTransKana1*/
#define smMaskKana2 0x00000020		/*2^smTransKana2*/
#define smMaskGana2 0x00000080		/*2^smTransGana2*/

/* Result values from GetEnvirons, SetEnvirons, GetScript and SetScript calls. */

#define smNotInstalled 0			/*routine not available in script*/
#define smBadVerb -1				/*Bad verb passed to a routine.*/
#define smBadScript -2				/*Bad script code passed to a routine.*/

/* GetEnvirons and SetEnvirons verbs */

#define smVersion 0 				/*Environment version number.*/
#define smMunged 2					/*Globals change count.*/
#define smEnabled 4 				/*Environment enabled flag.*/
#define smBidirect 6				/*At least on bidirect script.*/
#define smFontForce 8				/*Force font flag.*/
#define smIntlForce 10				/*Force intl flag.*/
#define smForced 12 				/*script forced to system script.*/
#define smDefault 14				/*script defaulted to Roman script.*/
#define smPrint 16					/*Printer action routine.*/
#define smSysScript 18				/*System script.*/
#define smLastScript 20 			/*Last keyboard script.*/
#define smKeyScript 22				/*Keyboard script.*/
#define smSysRef 24 				/*System folder refNum.*/
#define smKeyCache 26				/*Keyboard table cache pointer.*/
#define smKeySwap 28				/*Swapping table pointer.*/
#define smGenFlags 30				/*General flags long*/
#define smOverride 32				/*Script override flags.*/
#define smCharPortion 34			/*Ch vs SpExtra proportion*/
#define smLastEVerb smCharPortion	/*Last environment verb.*/

/* GetScript and SetScript verbs.
Note: Verbs private to script systems are negative, while
those general across script systems are non-negative. */

#define smScriptVersion 0			/*Script software version.*/
#define smScriptMunged 2			/*Script entry changed count.*/
#define smScriptEnabled 4			/*Script enabled flag.*/
#define smScriptRight 6 			/*Right to left flag.*/
#define smScriptJust 8				/*Justification flag.*/
#define smScriptRedraw 10			/*Word redraw flag.*/
#define smScriptSysFond 12			/*Preferred system font.*/
#define smScriptAppFond 14			/*Preferred Application font.*/
#define smScriptBundle 16			/*Beginning of dictionary verbs.*/
#define smScriptNumber 16			/*Script itl0 id from dictionary.*/
#define smScriptDate 18 			/*Script itl1 id from dictionary.*/
#define smScriptSort 20 			/*Script itl2 id from dictionary.*/
#define smScriptFlags 22			/*flags word.*/
#define smScriptToken 24			/*Script itl3 id, from dictionary.*/
#define smScriptRsvd3 26			/*reserved.*/
#define smScriptLang 28 			/*Current language for script.*/
#define smScriptNumDate 30			/*Script Number/Date formats.*/
#define smScriptKeys 32 			/*Script KEYC id from dictionary.*/
#define smScriptIcon 34 			/*Script SICN id from dictionary.*/
#define smScriptPrint 36			/*Script printer action routine.*/
#define smScriptTrap 38 			/*Trap entry pointer.*/
#define smScriptCreator 40			/*Script file creator.*/
#define smScriptFile 42 			/*Script file name.*/
#define smScriptName 44 			/*Script name.*/
#define smLastSVerb smScriptName	/*Last script verb.*/

/* Bits in the smScriptFlags word
(bits above 7 are non-static) */

#define smsfIntellCP 0				/*script has intellegent cut & paste*/
#define smsfSingByte 1				/*script has only single bytes*/
#define smsfNatCase 2				/*native chars have upper & lower case*/
#define smsfContext 3				/*contextual script (e.g. AIS-based)*/
#define smsfNoForceFont 4			/*Will not force characters.*/
#define smsfB0Digits 5				/*Has alternate digits at B0-B9.*/
#define smsfForms 13				/*Uses contextual forms for letters.*/
#define smsfLigatures 14			/*Uses contextual ligatures.*/
#define smsfReverse 15				/*Reverses native text, right-left.*/

/* Bits in the smGenFlags long.
First byte is set from itlc flags byte. */

#define smfShowIcon 31				/*Show icon even if only one script.*/
#define smfDualCaret 30 			/*Use dual caret for mixed direction text.*/

/* Roman script constants */

#define romanVers 0x0101			/*version number*/
#define romanSysFond 0x3FFF 		/*system font id number*/
#define romanAppFond 3				/*application font id number.*/
#define romanFlags 0x0007			/*roman settings*/

/* Script Manager font equates. */

#define smFondStart 0x4000			/*start from 16K.*/
#define smFondEnd 0xC000			/*past end of range at 48K.*/

/* Character Set Extensions */

#define diaeresisUprY 0xD9
#define fraction 0xDA
#define intlCurrency 0xDB
#define leftSingGuillemet 0xDC
#define rightSingGuillemet 0xDD
#define fiLigature 0xDE
#define flLigature 0xDF
#define dblDagger 0xE0
#define centeredDot 0xE1
#define baseSingQuote 0xE2
#define baseDblQuote 0xE3
#define perThousand 0xE4
#define circumflexUprA 0xE5
#define circumflexUprE 0xE6
#define acuteUprA 0xE7
#define diaeresisUprE 0xE8
#define graveUprE 0xE9
#define acuteUprI 0xEA
#define circumflexUprI 0xEB
#define diaeresisUprI 0xEC
#define graveUprI 0xED
#define acuteUprO 0xEE
#define circumflexUprO 0xEF
#define appleLogo 0xF0
#define graveUprO 0xF1
#define acuteUprU 0xF2
#define circumflexUprU 0xF3
#define graveUprU 0xF4
#define dotlessLwrI 0xF5
#define circumflex 0xF6
#define tilde 0xF7
#define macron 0xF8
#define breve 0xF9
#define overDot 0xFA
#define ring 0xFB
#define cedilla 0xFC
#define doubleAcute 0xFD
#define ogonek 0xFE
#define hachek 0xFF

/* String2Date status values */

#define fatalDateTime 0x8000
#define longDateFound 1
#define leftOverChars 2
#define sepNotIntlSep 4
#define fieldOrderNotIntl 8
#define extraneousStrings 16
#define tooManySeps 32
#define sepNotConsistent 64
#define tokenErr 0x8100
#define cantReadUtilities 0x8200
#define dateTimeNotFound 0x8400
#define dateTimeInvalid 0x8800

/* TokenType values */

#define tokenIntl 4 				/*the itl resource number of the tokenizer*/
#define tokenEmpty -1
#define tokenUnknown 0
#define tokenWhite 1
#define tokenLeftLit 2
#define tokenRightLit 3
#define tokenAlpha 4
#define tokenNumeric 5
#define tokenNewLine 6
#define tokenLeftComment 7
#define tokenRightComment 8
#define tokenLiteral 9
#define tokenEscape 10
#define tokenAltNum 11
#define tokenRealNum 12
#define tokenAltReal 13
#define tokenReserve1 14
#define tokenReserve2 15
#define tokenLeftParen 16
#define tokenRightParen 17
#define tokenLeftBracket 18
#define tokenRightBracket 19
#define tokenLeftCurly 20
#define tokenRightCurly 21
#define tokenLeftEnclose 22
#define tokenRightEnclose 23
#define tokenPlus 24
#define tokenMinus 25
#define tokenAsterisk 26
#define tokenDivide 27
#define tokenPlusMinus 28
#define tokenSlash 29
#define tokenBackSlash 30
#define tokenLess 31
#define tokenGreat 32
#define tokenEqual 33
#define tokenLessEqual2 34
#define tokenLessEqual1 35
#define tokenGreatEqual2 36
#define tokenGreatEqual1 37
#define token2Equal 38
#define tokenColonEqual 39
#define tokenNotEqual 40
#define tokenLessGreat 41
#define tokenExclamEqual 42
#define tokenExclam 43
#define tokenTilda 44
#define tokenComma 45
#define tokenPeriod 46
#define tokenLeft2Quote 47
#define tokenRight2Quote 48
#define tokenLeft1Quote 49
#define tokenRight1Quote 50
#define token2Quote 51
#define token1Quote 52
#define tokenSemicolon 53
#define tokenPercent 54
#define tokenCarat 55
#define tokenUnderline 56
#define tokenAmpersand 57
#define tokenAtSign 58
#define tokenBar 59
#define tokenQuestion 60
#define tokenPi 61
#define tokenRoot 62
#define tokenSigma 63
#define tokenIntegral 64
#define tokenMicro 65
#define tokenCapPi 66
#define tokenInfinity 67
#define tokenColon 68
#define tokenHash 69
#define tokenDollar 70
#define tokenNoBreakSpace 71
#define tokenFraction 72
#define tokenIntlCurrency 73
#define tokenLeftSingGuillemet 74
#define tokenRightSingGuillemet 75
#define tokenPerThousand 76
#define tokenNil 127
#define delimPad -2

/* the NumberParts indeces */

#define tokLeftQuote 1
#define tokRightQuote 2
#define tokLeadPlacer 3
#define tokLeader 4
#define tokNonLeader 5
#define tokZeroLead 6
#define tokPercent 7
#define tokPlusSign 8
#define tokMinusSign 9
#define tokThousands 10
#define tokSeparator 12 			/*11 is a reserved field*/
#define tokEscape 13
#define tokDecPoint 14
#define tokEPlus 15
#define tokEMinus 16
#define tokMaxSymbols 31
#define curNumberPartsVersion 1 	/*current version of NumberParts record*/

/*	Date equates */

#define smallDateBit 31 			/*Restrict valid date/time to range of Time global*/
#define togChar12HourBit 30 		/*If toggling hour by char, accept hours 1..12 only*/
#define togCharZCycleBit 29 		/*Modifier for togChar12HourBit: accept hours 0..11 only*/
#define togDelta12HourBit 28		/*If toggling hour up/down, restrict to 12-hour range (am/pm)*/
#define genCdevRangeBit 27			/*Restrict date/time to range used by genl CDEV*/
#define validDateFields -1
#define maxDateField 10
#define eraMask 0x0001
#define yearMask 0x0002
#define monthMask 0x0004
#define dayMask 0x0008
#define hourMask 0x0010
#define minuteMask 0x0020
#define secondMask 0x0040
#define dayOfWeekMask 0x0080
#define dayOfYearMask 0x0100
#define weekOfYearMask 0x0200
#define pmMask 0x0400
#define dateStdMask 0x007F
#define fVNumber 0					/*first version of NumFormatString*/

/* Toggle results */

#define toggleUndefined 0
#define toggleOK 1
#define toggleBadField 2
#define toggleBadDelta 3
#define toggleBadChar 4
#define toggleUnknown 5
#define toggleBadNum 6
#define toggleOutOfRange 7			/*synonym for toggleErr3*/
#define toggleErr3 7
#define toggleErr4 8
#define toggleErr5 9

enum {tokenOK,tokenOverflow,stringOverflow,badDelim,badEnding,crash};
typedef unsigned char TokenResults;

enum {eraField,yearField,monthField,dayField,hourField,minuteField,secondField,
	dayOfWeekField,dayOfYearField,weekOfYearField,pmField,res1Field,res2Field,
	res3Field};
typedef unsigned char LongDateField;

enum {smBreakWord,smBreakChar,smBreakOverflow};
typedef unsigned char StyledLineBreakCode;

enum {fPositive,fNegative,fZero};
typedef unsigned char FormatClass;

enum {fFormatOK,fBestGuess,fOutOfSynch,fSpuriousChars,fMissingDelimiter,
	fExtraDecimal,fMissingLiteral,fExtraExp,fFormatOverflow,fFormStrIsNAN,
	fBadPartsTable,fExtraPercent,fExtraSeparator,fEmptyFormatString};
typedef unsigned char FormatResultType;

typedef char CharByteTable[256];
typedef short ToggleResults;


struct BreakTable {
	char charTypes[256];
	short tripleLength;
	short triples[1];
};

typedef struct BreakTable BreakTable;
typedef BreakTable *BreakTablePtr;

struct OffPair {
	short offFirst;
	short offSecond;
};

typedef struct OffPair OffPair;
typedef OffPair OffsetTable[3];


struct ItlcRecord {
	short itlcSystem;				/*default system script.*/
	short itlcReserved; 			/*reserved*/
	char itlcFontForce; 			/*default font force flag*/
	char itlcIntlForce; 			/*default intl force flag.*/
	char itlcOldKybd;				/*old keyboard*/
	char itlcFlags; 				/*general flags*/
	short itlcIconOffset;			/*script icon offset*/
	char itlcIconSide;				/*icon side*/
	char itlcIconRsvd;				/*rsvd for other icon info*/
	char itlcReserved2[36]; 		/*for future use*/
};

typedef struct ItlcRecord ItlcRecord;
struct ItlbRecord {
	short itlbNumber;				/*ITL0 id number.*/
	short itlbDate; 				/*ITL1 id number.*/
	short itlbSort; 				/*ITL2 id number.*/
	short itlbFlags;				/*Script flags*/
	short itlbToken;				/*ITL4 id number.*/
	short itlbReserved3;			/*reserved.*/
	short itlbLang; 				/*cur language for script */
	char itlbNumRep;				/*number representation code*/
	char itlbDateRep;				/*date representation code */
	short itlbKeys; 				/*KCHR id number.*/
	short itlbIcon; 				/*SICN id number.*/
};

typedef struct ItlbRecord ItlbRecord;
struct MachineLocation {
	Fract latitude;
	Fract longitude;
	union{
		char dlsDelta;				/*signed byte; daylight savings delta*/
		long gmtDelta;				/*must mask - see documentation*/
		}gmtFlags;
};

typedef struct MachineLocation MachineLocation;
typedef short String2DateStatus;
typedef short TokenType;
typedef TokenType DelimType[2];
typedef TokenType CommentType[4];

struct TokenRec {
	TokenType theToken;
	Ptr position;					/*pointer into original Source*/
	long length;					/*length of text in original source*/
	StringPtr stringPosition;		/*Pascal/C string copy of identifier*/
};

typedef struct TokenRec TokenRec;
typedef TokenRec *TokenRecPtr;

struct TokenBlock {
	Ptr source; 					/*pointer to stream of characters*/
	long sourceLength;				/*length of source stream*/
	Ptr tokenList;					/*pointer to array of tokens*/
	long tokenLength;				/*maximum length of TokenList*/
	long tokenCount;				/*number tokens generated by tokenizer*/
	Ptr stringList; 				/*pointer to stream of identifiers*/
	long stringLength;				/*length of string list*/
	long stringCount;				/*number of bytes currently used*/
	Boolean doString;				/*make strings & put into StringLIst*/
	Boolean doAppend;				/*append to TokenList rather than replace*/
	Boolean doAlphanumeric; 		/*identifiers may include numeric*/
	Boolean doNest; 				/*do comments nest?*/
	TokenType leftDelims[2];
	TokenType rightDelims[2];
	TokenType leftComment[4];
	TokenType rightComment[4];
	TokenType escapeCode;			/*escape symbol code*/
	TokenType decimalCode;
	Handle itlResource; 			/*ptr to itl4 resource of current script*/
	long reserved[8];				/*must be zero!*/
};

typedef struct TokenBlock TokenBlock;
typedef TokenBlock *TokenBlockPtr;

struct UntokenTable {
	short len;
	short lastToken;
	short index[256];				/*index table; last = lastToken*/
};

typedef struct UntokenTable UntokenTable;
typedef UntokenTable *UntokenTablePtr, **UntokenTableHandle;

struct DateCacheRecord {
	short hidden[256];				/*only for temporary use*/
};

typedef struct DateCacheRecord DateCacheRecord;
typedef DateCacheRecord *DateCachePtr;

typedef comp LongDateTime;

union LongDateCvt {
	comp c;
	struct {
		long lHigh;
		long lLow;
		} hl;
};

typedef union LongDateCvt LongDateCvt;

union LongDateRec {
	struct {
		short era;
		short year;
		short month;
		short day;
		short hour;
		short minute;
		short second;
		short dayOfWeek;
		short dayOfYear;
		short weekOfYear;
		short pm;
		short res1;
		short res2;
		short res3;
		} ld;
	short list[14]; 				/*Index by LongDateField!*/
	struct {
		short eraAlt;
		DateTimeRec oldDate;
		} od;
};

typedef union LongDateRec LongDateRec;

typedef char DateDelta;

struct TogglePB {
	long togFlags;					/*caller normally sets low word to dateStdMask=$7F*/
	ResType amChars;				/*from intl0*/
	ResType pmChars;				/*from intl0*/
	long reserved[4];
};

typedef struct TogglePB TogglePB;
typedef short FormatOrder[1];
typedef FormatOrder *FormatOrderPtr;
typedef short FormatStatus;

union WideChar {
	char a[2];						/*0 is the high order character*/
	short b;
};

typedef union WideChar WideChar;

struct WideCharArr {
	short size;
	WideChar data[10];
};

typedef struct WideCharArr WideCharArr;
struct NumFormatString {
	char fLength;
	char fVersion;
	char data[254]; 				/*private data*/
};

typedef struct NumFormatString NumFormatString;
struct Itl4Rec {
	short flags;
	long resourceType;
	short resourceNum;
	short version;
	long resHeader1;
	long resHeader2;
	short numTables;				/*one-based*/
	long mapOffset; 				/*offsets are from record start*/
	long strOffset;
	long fetchOffset;
	long unTokenOffset;
	long defPartsOffset;
	long resOffset6;
	long resOffset7;
	long resOffset8;
};

typedef struct Itl4Rec Itl4Rec;
typedef Itl4Rec *Itl4Ptr, **Itl4Handle;

struct NumberParts {
	short version;
	WideChar data[31];				/*index by [tokLeftQuote..tokMaxSymbols]*/
	WideCharArr pePlus;
	WideCharArr peMinus;
	WideCharArr peMinusPlus;
	WideCharArr altNumTable;
	char reserved[20];
};

typedef struct NumberParts NumberParts;
typedef NumberParts *NumberPartsPtr;

struct FVector {
	short start;
	short length;
};

typedef struct FVector FVector;
typedef FVector TripleInt[3];		/* index by [fPositive..fZero] */

struct ScriptRunStatus {
	short script;
	short variant;
};

typedef struct ScriptRunStatus ScriptRunStatus;
#ifdef __cplusplus
extern "C" {
#endif
pascal short FontScript(void)
	= {0x2F3C,0x8200,0x0000,0xA8B5};
pascal short IntlScript(void)
	= {0x2F3C,0x8200,0x0002,0xA8B5};
pascal void KeyScript(short code)
	= {0x2F3C,0x8002,0x0004,0xA8B5};
pascal short Font2Script(short fontNumber)
	= {0x2F3C,0x8202,0x0006,0xA8B5};
pascal long GetEnvirons(short verb)
	= {0x2F3C,0x8402,0x0008,0xA8B5};
pascal OSErr SetEnvirons(short verb,long param)
	= {0x2F3C,0x8206,0x000A,0xA8B5};
pascal long GetScript(short script,short verb)
	= {0x2F3C,0x8404,0x000C,0xA8B5};
pascal OSErr SetScript(short script,short verb,long param)
	= {0x2F3C,0x8208,0x000E,0xA8B5};
pascal short CharByte(Ptr textBuf,short textOffset)
	= {0x2F3C,0x8206,0x0010,0xA8B5};
pascal short CharType(Ptr textBuf,short textOffset)
	= {0x2F3C,0x8206,0x0012,0xA8B5};
pascal short Pixel2Char(Ptr textBuf,short textLen,short slop,short pixelWidth,
	Boolean *leadingEdge)
	= {0x2F3C,0x820E,0x0014,0xA8B5};
pascal short Char2Pixel(Ptr textBuf,short textLen,short slop,short offset,
	short direction)
	= {0x2F3C,0x820C,0x0016,0xA8B5};
pascal OSErr Transliterate(Handle srcHandle,Handle dstHandle,short target,
	long srcMask)
	= {0x2F3C,0x820E,0x0018,0xA8B5};
pascal void FindWord(Ptr textPtr,short textLength,short offset,Boolean leadingEdge,
	BreakTablePtr breaks,OffsetTable offsets)
	= {0x2F3C,0x8012,0x001A,0xA8B5};
pascal void HiliteText(Ptr textPtr,short textLength,short firstOffset,short secondOffset,
	OffsetTable offsets)
	= {0x2F3C,0x800E,0x001C,0xA8B5};
pascal void DrawJust(Ptr textPtr,short textLength,short slop)
	= {0x2F3C,0x8008,0x001E,0xA8B5};
pascal void MeasureJust(Ptr textPtr,short textLength,short slop,Ptr charLocs)
	= {0x2F3C,0x800C,0x0020,0xA8B5};
pascal Boolean ParseTable(CharByteTable *table)
	= {0x2F3C,0x8204,0x0022,0xA8B5};
pascal short GetDefFontSize(void)
	= {0x3EB8,0x0BA8,0x6604,0x3EBC,0x000C}; 
pascal short GetSysFont(void)
	= {0x3EB8,0x0BA6};
pascal short GetAppFont(void)
	= {0x3EB8,0x0984};
pascal short GetMBarHeight(void)
	= {0x3EB8,0x0BAA};
pascal short GetSysJust(void)
	= {0x3EB8,0x0BAC};
pascal void SetSysJust(short newJust)
	= {0x31DF,0x0BAC};
pascal void ReadLocation(MachineLocation *loc)
	= {0x205F,0x203C,0x000C,0x00E4,0xA051}; 
pascal void WriteLocation(const MachineLocation *loc)
	= {0x205F,0x203C,0x000C,0x00E4,0xA052}; 
pascal void UprText(Ptr textPtr,short len)
	= {0x301F,0x205F,0xA054};
pascal void LwrText(Ptr textPtr,short len)
	= {0x301F,0x205F,0xA056};
pascal StyledLineBreakCode StyledLineBreak(Ptr textPtr,long textLen,long textStart,
	long textEnd,long flags,Fixed *textWidth,long *textOffset)
	= {0x2F3C,0x821C,0xFFFE,0xA8B5};
pascal void GetFormatOrder(FormatOrderPtr ordering,short firstFormat,short lastFormat,
	Boolean lineRight,Ptr rlDirProc,Ptr dirParam)
	= {0x2F3C,0x8012,0xFFFC,0xA8B5};
pascal TokenResults IntlTokenize(TokenBlockPtr tokenParam)
	= {0x2F3C,0x8204,0xFFFA,0xA8B5};
pascal OSErr InitDateCache(DateCachePtr theCache)
	= {0x2F3C,0x8204,0xFFF8,0xA8B5};
pascal String2DateStatus String2Date(Ptr textPtr,long textLen,DateCachePtr theCache,
	long *lengthUsed,LongDateRec *dateTime)
	= {0x2F3C,0x8214,0xFFF6,0xA8B5};
pascal String2DateStatus String2Time(Ptr textPtr,long textLen,DateCachePtr theCache,
	long *lengthUsed,LongDateRec *dateTime)
	= {0x2F3C,0x8214,0xFFF4,0xA8B5};
pascal void LongDate2Secs(const LongDateRec *lDate,LongDateTime *lSecs)
	= {0x2F3C,0x8008,0xFFF2,0xA8B5};
pascal void LongSecs2Date(LongDateTime *lSecs,LongDateRec *lDate)
	= {0x2F3C,0x8008,0xFFF0,0xA8B5};
pascal ToggleResults ToggleDate(LongDateTime *lSecs,LongDateField field,
	DateDelta delta,short ch,const TogglePB *params)
	= {0x2F3C,0x820E,0xFFEE,0xA8B5};
pascal FormatStatus Str2Format(const Str255 inString,const NumberParts *partsTable,
	NumFormatString *outString)
	= {0x2F3C,0x820C,0xFFEC,0xA8B5};
pascal FormatStatus Format2Str(const NumFormatString *myCanonical,const NumberParts *partsTable,
	Str255 outString,TripleInt *positions)
	= {0x2F3C,0x8210,0xFFEA,0xA8B5};
pascal FormatStatus FormatX2Str(extended x,const NumFormatString *myCanonical,
	const NumberParts *partsTable,Str255 outString)
	= {0x2F3C,0x8210,0xFFE8,0xA8B5};
pascal FormatStatus FormatStr2X(const Str255 source,const NumFormatString *myCanonical,
	const NumberParts *partsTable,extended *x)
	= {0x2F3C,0x8210,0xFFE6,0xA8B5};
pascal Fixed PortionText(Ptr textPtr,long textLen)
	= {0x2F3C,0x8408,0x0024,0xA8B5};
pascal struct ScriptRunStatus FindScriptRun(Ptr textPtr,long textLen,long *lenUsed)
	= {0x2F3C,0x820C,0x0026,0xA8B5};
pascal long VisibleLength(Ptr textPtr,long textLen)
	= {0x2F3C,0x8408,0x0028,0xA8B5};
pascal short ValidDate(LongDateRec *vDate,long flags,LongDateTime *newSecs)
	= {0x2F3C,0x8204,0xFFE4,0xA8B5};
pascal void IULDateString(LongDateTime *dateTime,DateForm longFlag,Str255 result,
	Handle intlParam)
	= {0x3F3C,0x0014,0xA9ED};
pascal void IULTimeString(LongDateTime *dateTime,Boolean wantSeconds,Str255 result,
	Handle intlParam)
	= {0x3F3C,0x0016,0xA9ED};
#ifdef __cplusplus
}
#endif

#endif

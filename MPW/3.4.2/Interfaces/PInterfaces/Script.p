{
 	File:		Script.p
 
 	Contains:	Script Manager interfaces
 
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
 UNIT Script;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SCRIPT__}
{$SETC __SCRIPT__ := 1}

{$I+}
{$SETC ScriptIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __TYPES__}
{$I Types.p}
{$ENDC}
{	ConditionalMacros.p											}

{$IFC UNDEFINED __QUICKDRAW__}
{$I Quickdraw.p}
{$ENDC}
{	MixedMode.p													}
{	QuickdrawText.p												}

{$IFC UNDEFINED __INTLRESOURCES__}
{$I IntlResources.p}
{$ENDC}

{$IFC UNDEFINED __EVENTS__}
{$I Events.p}
{$ENDC}
{	OSUtils.p													}
{		Memory.p												}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

CONST
{ Script System constants }
	smSystemScript				= -1;							{designates system script.}
	smCurrentScript				= -2;							{designates current font script.}
	smAllScripts				= -3;							{designates any script	}
	smRoman						= 0;							{Roman}
	smJapanese					= 1;							{Japanese}
	smTradChinese				= 2;							{Traditional Chinese}
	smKorean					= 3;							{Korean}
	smArabic					= 4;							{Arabic}
	smHebrew					= 5;							{Hebrew}
	smGreek						= 6;							{Greek}
	smCyrillic					= 7;							{Cyrillic}
	smRSymbol					= 8;							{Right-left symbol}
	smDevanagari				= 9;							{Devanagari}
	smGurmukhi					= 10;							{Gurmukhi}
	smGujarati					= 11;							{Gujarati}
	smOriya						= 12;							{Oriya}
	smBengali					= 13;							{Bengali}
	smTamil						= 14;							{Tamil}
	smTelugu					= 15;							{Telugu}
	smKannada					= 16;							{Kannada/Kanarese}
	smMalayalam					= 17;							{Malayalam}

	smSinhalese					= 18;							{Sinhalese}
	smBurmese					= 19;							{Burmese}
	smKhmer						= 20;							{Khmer/Cambodian}
	smThai						= 21;							{Thai}
	smLaotian					= 22;							{Laotian}
	smGeorgian					= 23;							{Georgian}
	smArmenian					= 24;							{Armenian}
	smSimpChinese				= 25;							{Simplified Chinese}
	smTibetan					= 26;							{Tibetan}
	smMongolian					= 27;							{Mongolian}
	smGeez						= 28;							{Geez/Ethiopic}
	smEthiopic					= 28;							{Synonym for smGeez}
	smEastEurRoman				= 29;							{Synonym for smSlavic}
	smCentralEuroRoman			= smEastEurRoman;				{ another synonym }
	smVietnamese				= 30;							{Vietnamese}
	smExtArabic					= 31;							{extended Arabic}
	smUninterp					= 32;							{uninterpreted symbols, e.g. palette symbols}
	smKlingon					= 32;							{Klingon}
{Obsolete names for script systems (kept for backward compatibility)}
	smChinese					= 2;							{(use smTradChinese or smSimpChinese)}
	smRussian					= 7;							{(old name for smCyrillic)}
{ smMaldivian = 25;         (no more smMaldivian!)}
	smAmharic					= 28;							{(old name for smGeez)}
	smSlavic					= 29;							{(old name for smEastEurRoman)}

	smSindhi					= 31;							{(old name for smExtArabic)}
{ Language Codes }
	langEnglish					= 0;							{ smRoman script }
	langFrench					= 1;							{ smRoman script }
	langGerman					= 2;							{ smRoman script }
	langItalian					= 3;							{ smRoman script }
	langDutch					= 4;							{ smRoman script }
	langSwedish					= 5;							{ smRoman script }
	langSpanish					= 6;							{ smRoman script }
	langDanish					= 7;							{ smRoman script }
	langPortuguese				= 8;							{ smRoman script }
	langNorwegian				= 9;							{ smRoman script }
	langHebrew					= 10;							{ smHebrew script }
	langJapanese				= 11;							{ smJapanese script }
	langArabic					= 12;							{ smArabic script }
	langFinnish					= 13;							{ smRoman script }
	langGreek					= 14;							{ smGreek script }
	langIcelandic				= 15;							{ extended Roman script }
	langMaltese					= 16;							{ extended Roman script }
	langTurkish					= 17;							{ extended Roman script }
	langCroatian				= 18;							{ Serbo-Croatian in extended Roman script }
	langTradChinese				= 19;							{ Chinese in traditional characters }

	langUrdu					= 20;							{ smArabic script }
	langHindi					= 21;							{ smDevanagari script }
	langThai					= 22;							{ smThai script }
	langKorean					= 23;							{ smKorean script }
	langLithuanian				= 24;							{ smEastEurRoman script }
	langPolish					= 25;							{ smEastEurRoman script }
	langHungarian				= 26;							{ smEastEurRoman script }
	langEstonian				= 27;							{ smEastEurRoman script }
	langLettish					= 28;							{ smEastEurRoman script }
	langLatvian					= 28;							{ Synonym for langLettish }
	langSaamisk					= 29;							{ ext. Roman script, lang. of the Sami/Lapp people of Scand. }
	langLappish					= 29;							{ Synonym for langSaamisk }
	langFaeroese				= 30;							{ smRoman script }
	langFarsi					= 31;							{ smArabic script }
	langPersian					= 31;							{ Synonym for langFarsi }
	langRussian					= 32;							{ smCyrillic script }
	langSimpChinese				= 33;							{ Chinese in simplified characters }
	langFlemish					= 34;							{ smRoman script }
	langIrish					= 35;							{ smRoman script }
	langAlbanian				= 36;							{ smRoman script }

	langRomanian				= 37;							{ smEastEurRoman script }
	langCzech					= 38;							{ smEastEurRoman script }
	langSlovak					= 39;							{ smEastEurRoman script }
	langSlovenian				= 40;							{ smEastEurRoman script }
	langYiddish					= 41;							{ smHebrew script }
	langSerbian					= 42;							{ Serbo-Croatian in smCyrillic script }
	langMacedonian				= 43;							{ smCyrillic script }
	langBulgarian				= 44;							{ smCyrillic script }
	langUkrainian				= 45;							{ smCyrillic script }
	langByelorussian			= 46;							{ smCyrillic script }
	langUzbek					= 47;							{ smCyrillic script }
	langKazakh					= 48;							{ smCyrillic script }
	langAzerbaijani				= 49;							{ Azerbaijani in smCyrillic script (USSR) }
	langAzerbaijanAr			= 50;							{ Azerbaijani in smArabic script (Iran) }
	langArmenian				= 51;							{ smArmenian script }
	langGeorgian				= 52;							{ smGeorgian script }
	langMoldavian				= 53;							{ smCyrillic script }
	langKirghiz					= 54;							{ smCyrillic script }
	langTajiki					= 55;							{ smCyrillic script }
	langTurkmen					= 56;							{ smCyrillic script }

	langMongolian				= 57;							{ Mongolian in smMongolian script }
	langMongolianCyr			= 58;							{ Mongolian in smCyrillic script }
	langPashto					= 59;							{ smArabic script }
	langKurdish					= 60;							{ smArabic script }
	langKashmiri				= 61;							{ smArabic script }
	langSindhi					= 62;							{ smExtArabic script }
	langTibetan					= 63;							{ smTibetan script }
	langNepali					= 64;							{ smDevanagari script }
	langSanskrit				= 65;							{ smDevanagari script }
	langMarathi					= 66;							{ smDevanagari script }
	langBengali					= 67;							{ smBengali script }
	langAssamese				= 68;							{ smBengali script }
	langGujarati				= 69;							{ smGujarati script }
	langPunjabi					= 70;							{ smGurmukhi script }
	langOriya					= 71;							{ smOriya script }
	langMalayalam				= 72;							{ smMalayalam script }
	langKannada					= 73;							{ smKannada script }
	langTamil					= 74;							{ smTamil script }
	langTelugu					= 75;							{ smTelugu script }
	langSinhalese				= 76;							{ smSinhalese script }

	langBurmese					= 77;							{ smBurmese script }
	langKhmer					= 78;							{ smKhmer script }
	langLao						= 79;							{ smLaotian script }
	langVietnamese				= 80;							{ smVietnamese script }
	langIndonesian				= 81;							{ smRoman script }
	langTagalog					= 82;							{ smRoman script }
	langMalayRoman				= 83;							{ Malay in smRoman script }
	langMalayArabic				= 84;							{ Malay in smArabic script }
	langAmharic					= 85;							{ smEthiopic script }
	langTigrinya				= 86;							{ smEthiopic script }
	langGalla					= 87;							{ smEthiopic script }
	langOromo					= 87;							{ Synonym for langGalla }
	langSomali					= 88;							{ smRoman script }
	langSwahili					= 89;							{ smRoman script }
	langRuanda					= 90;							{ smRoman script }
	langRundi					= 91;							{ smRoman script }
	langChewa					= 92;							{ smRoman script }
	langMalagasy				= 93;							{ smRoman script }
	langEsperanto				= 94;							{ extended Roman script }
	langWelsh					= 128;							{ smRoman script }

	langBasque					= 129;							{ smRoman script }
	langCatalan					= 130;							{ smRoman script }
	langLatin					= 131;							{ smRoman script }
	langQuechua					= 132;							{ smRoman script }
	langGuarani					= 133;							{ smRoman script }
	langAymara					= 134;							{ smRoman script }
	langTatar					= 135;							{ smCyrillic script }
	langUighur					= 136;							{ smArabic script }
	langDzongkha				= 137;							{ (lang of Bhutan) smTibetan script }
	langJavaneseRom				= 138;							{ Javanese in smRoman script }
	langSundaneseRom			= 139;							{ Sundanese in smRoman script }
{ Obsolete names, kept for backward compatibility }
	langPortugese				= 8;							{ old misspelled version, kept for compatibility }
	langMalta					= 16;							{ old misspelled version, kept for compatibility }
	langYugoslavian				= 18;							{ (use langCroatian, langSerbian, etc.) }
	langChinese					= 19;							{ (use langTradChinese or langSimpChinese) }
	langLapponian				= 29;							{ Synonym for langSaamisk, not correct name }

{ Regional version codes }
	verUS						= 0;
	verFrance					= 1;
	verBritain					= 2;
	verGermany					= 3;
	verItaly					= 4;
	verNetherlands				= 5;
	verFrBelgiumLux				= 6;							{ French for Belgium & Luxembourg }
	verSweden					= 7;
	verSpain					= 8;
	verDenmark					= 9;
	verPortugal					= 10;
	verFrCanada					= 11;
	verNorway					= 12;

	verIsrael					= 13;
	verJapan					= 14;
	verAustralia				= 15;
	verArabic					= 16;							{ synonym for verArabia }
	verFinland					= 17;
	verFrSwiss					= 18;							{ French Swiss }
	verGrSwiss					= 19;							{ German Swiss }
	verGreece					= 20;
	verIceland					= 21;
	verMalta					= 22;
	verCyprus					= 23;
	verTurkey					= 24;
	verYugoCroatian				= 25;							{ Croatian system for Yugoslavia }
	verNetherlandsComma			= 26;
	verBelgiumLuxPoint			= 27;
	verCanadaComma				= 28;
	verCanadaPoint				= 29;
	vervariantPortugal			= 30;
	vervariantNorway			= 31;
	vervariantDenmark			= 32;
	verIndiaHindi				= 33;							{ Hindi system for India }
	verPakistan					= 34;
	verTurkishModified			= 35;
	verRomania					= 39;
	verGreekAncient				= 40;
	verLithuania				= 41;
	verPoland					= 42;
	verHungary					= 43;
	verEstonia					= 44;
	verLatvia					= 45;

	verLapland					= 46;
	verFaeroeIsl				= 47;
	verIran						= 48;
	verRussia					= 49;
	verIreland					= 50;							{ English-language version for Ireland }
	verKorea					= 51;
	verChina					= 52;
	verTaiwan					= 53;
	verThailand					= 54;
	verCzech					= 56;
	verSlovak					= 57;
	verGenericFE				= 58;
	verMagyar					= 59;
	verBengali					= 60;
	verByeloRussian				= 61;
	verUkrania					= 62;
	verItalianSwiss				= 63;
	verAlternateGr				= 64;
	verCroatia					= 68;

	minCountry					= verUS;
	maxCountry					= verCroatia;					{ changed from verAlternateGr when additional enums added }

{ Obsolete region code names, kept for backward compatibility }
	verBelgiumLux				= 6;							{ (use verFrBelgiumLux instead, less ambiguous) }
	verArabia					= 16;
	verYugoslavia				= 25;							{ (use verYugoCroatian instead, less ambiguous) }
	verIndia					= 33;							{ (use verIndiaHindi instead, less ambiguous) }
{ Calendar Codes }
	calGregorian				= 0;
	calArabicCivil				= 1;
	calArabicLunar				= 2;
	calJapanese					= 3;
	calJewish					= 4;
	calCoptic					= 5;
	calPersian					= 6;
{ Integer Format Codes }
	intWestern					= 0;
	intArabic					= 1;
	intRoman					= 2;
	intJapanese					= 3;
	intEuropean					= 4;
	intOutputMask				= $8000;
{ CharByte byte types }
	smSingleByte				= 0;
	smFirstByte					= -1;
	smLastByte					= 1;
	smMiddleByte				= 2;
{ CharType field masks }
	smcTypeMask					= $000F;
	smcReserved					= $00F0;

	smcClassMask				= $0F00;
	smcOrientationMask			= $1000;						{two-byte script glyph orientation}
	smcRightMask				= $2000;
	smcUpperMask				= $4000;
	smcDoubleMask				= $8000;
{ Basic CharType character types }
	smCharPunct					= $0000;
	smCharAscii					= $0001;
	smCharEuro					= $0007;
	smCharExtAscii				= $0007;						{ More correct synonym for smCharEuro }
{ Additional CharType character types for script systems }
	smCharKatakana				= $0002;						{Japanese Katakana}
	smCharHiragana				= $0003;						{Japanese Hiragana}
	smCharIdeographic			= $0004;						{Hanzi, Kanji, Hanja}
	smCharTwoByteGreek			= $0005;						{2-byte Greek in Far East systems}
	smCharTwoByteRussian		= $0006;						{2-byte Cyrillic in Far East systems}
	smCharBidirect				= $0008;						{Arabic/Hebrew}
	smCharContextualLR			= $0009;						{Contextual left-right: Thai, Indic scripts}
	smCharNonContextualLR		= $000A;						{Non-contextual left-right: Cyrillic, Greek}
	smCharHangul				= $000C;						{Korean Hangul}
	smCharJamo					= $000D;						{Korean Jamo}
	smCharBopomofo				= $000E;						{Chinese Bopomofo}
{ old names for some of above, for backward compatibility }
	smCharFISKana				= $0002;						{Katakana}
	smCharFISGana				= $0003;						{Hiragana}
	smCharFISIdeo				= $0004;						{Hanzi, Kanji, Hanja}

	smCharFISGreek				= $0005;						{2-byte Greek in Far East systems}
	smCharFISRussian			= $0006;						{2-byte Cyrillic in Far East systems}
{ CharType classes for punctuation (smCharPunct) }
	smPunctNormal				= $0000;
	smPunctNumber				= $0100;
	smPunctSymbol				= $0200;
	smPunctBlank				= $0300;
{ Additional CharType classes for punctuation in two-byte systems }
	smPunctRepeat				= $0400;						{ repeat marker }
	smPunctGraphic				= $0500;						{ line graphics }
{ CharType Katakana and Hiragana classes for two-byte systems }
	smKanaSmall					= $0100;						{small kana character}
	smKanaHardOK				= $0200;						{can have dakuten}
	smKanaSoftOK				= $0300;						{can have dakuten or han-dakuten}
{ CharType Ideographic classes for two-byte systems }
	smIdeographicLevel1			= $0000;						{level 1 char}
	smIdeographicLevel2			= $0100;						{level 2 char}
	smIdeographicUser			= $0200;						{user char}
{ old names for above, for backward compatibility }
	smFISClassLvl1				= $0000;						{level 1 char}
	smFISClassLvl2				= $0100;						{level 2 char}
	smFISClassUser				= $0200;						{user char}
{ CharType Jamo classes for Korean systems }
	smJamoJaeum					= $0000;						{simple consonant char}
	smJamoBogJaeum				= $0100;						{complex consonant char}
	smJamoMoeum					= $0200;						{simple vowel char}

	smJamoBogMoeum				= $0300;						{complex vowel char}
{ CharType glyph orientation for two-byte systems }
	smCharHorizontal			= $0000;						{ horizontal character form, or for both }
	smCharVertical				= $1000;						{ vertical character form }
{ CharType directions }
	smCharLeft					= $0000;
	smCharRight					= $2000;
{ CharType case modifers }
	smCharLower					= $0000;
	smCharUpper					= $4000;
{ CharType character size modifiers (1 or multiple bytes). }
	smChar1byte					= $0000;
	smChar2byte					= $8000;
{ TransliterateText target types for Roman }
	smTransAscii				= 0;							{convert to ASCII}
	smTransNative				= 1;							{convert to font script}
	smTransCase					= $FE;							{convert case for all text}
	smTransSystem				= $FF;							{convert to system script}
{ TransliterateText target types for two-byte scripts }
	smTransAscii1				= 2;							{1-byte Roman}
	smTransAscii2				= 3;							{2-byte Roman}
	smTransKana1				= 4;							{1-byte Japanese Katakana}
	smTransKana2				= 5;							{2-byte Japanese Katakana}

	smTransGana2				= 7;							{2-byte Japanese Hiragana (no 1-byte Hiragana)}
	smTransHangul2				= 8;							{2-byte Korean Hangul}
	smTransJamo2				= 9;							{2-byte Korean Jamo}
	smTransBopomofo2			= 10;							{2-byte Chinese Bopomofo}
{ TransliterateText target modifiers }
	smTransLower				= $4000;						{target becomes lowercase}
	smTransUpper				= $8000;						{target becomes uppercase}
{ TransliterateText resource format numbers }
	smTransRuleBaseFormat		= 1;							{Rule based trsl resource format }
	smTransHangulFormat			= 2;							{Table based Hangul trsl resource format}
{ TransliterateText property flags }
	smTransPreDoubleByting		= 1;							{Convert all text to double byte before transliteration}
	smTransPreLowerCasing		= 2;							{Convert all text to lower case before transliteration}
{ TransliterateText source mask - general }
	smMaskAll					= $FFFFFFFF;					{Convert all text}
{ TransliterateText source masks }
	smMaskAscii					= $00000001;					{2^smTransAscii}
	smMaskNative				= $00000002;					{2^smTransNative}
{ TransliterateText source masks for two-byte scripts }
	smMaskAscii1				= $00000004;					{2^smTransAscii1}
	smMaskAscii2				= $00000008;					{2^smTransAscii2}
	smMaskKana1					= $00000010;					{2^smTransKana1}
	smMaskKana2					= $00000020;					{2^smTransKana2}
	smMaskGana2					= $00000080;					{2^smTransGana2}
	smMaskHangul2				= $00000100;					{2^smTransHangul2}
	smMaskJamo2					= $00000200;					{2^smTransJamo2}
	smMaskBopomofo2				= $00000400;					{2^smTransBopomofo2}

{ Result values from GetScriptManagerVariable and SetScriptManagerVariable calls. }
	smNotInstalled				= 0;							{routine not available in script}
	smBadVerb					= -1;							{Bad verb passed to a routine}
	smBadScript					= -2;							{Bad script code passed to a routine}

{ Values for script redraw flag. }
	smRedrawChar				= 0;							{Redraw character only}
	smRedrawWord				= 1;							{Redraw entire word (2-byte systems)}
	smRedrawLine				= -1;							{Redraw entire line (bidirectional systems)}
{ GetScriptManagerVariable and SetScriptManagerVariable verbs }
	smVersion					= 0;							{Script Manager version number}
	smMunged					= 2;							{Globals change count}
	smEnabled					= 4;							{Count of enabled scripts, incl Roman}
	smBidirect					= 6;							{At least one bidirectional script}
	smFontForce					= 8;							{Force font flag}
	smIntlForce					= 10;							{Force intl flag}
	smForced					= 12;							{Script was forced to system script}
	smDefault					= 14;							{Script was defaulted to Roman script}
	smPrint						= 16;							{Printer action routine}
	smSysScript					= 18;							{System script}
	smLastScript				= 20;							{Last keyboard script}
	smKeyScript					= 22;							{Keyboard script}
	smSysRef					= 24;							{System folder refNum}
	smKeyCache					= 26;							{obsolete}
	smKeySwap					= 28;							{Swapping table handle}
	smGenFlags					= 30;							{General flags long}
	smOverride					= 32;							{Script override flags}

	smCharPortion				= 34;							{Ch vs SpExtra proportion}
{ New for System 7.0: }
	smDoubleByte				= 36;							{Flag for double-byte script installed}
	smKCHRCache					= 38;							{Returns pointer to KCHR cache}
	smRegionCode				= 40;							{Returns current region code (verXxx)}
	smKeyDisableState			= 42;							{Returns current keyboard disable state}
{ GetScriptVariable and SetScriptVariable verbs.
Note: Verbs private to script systems are negative, while
those general across script systems are non-negative. }
	smScriptVersion				= 0;							{Script software version}
	smScriptMunged				= 2;							{Script entry changed count}
	smScriptEnabled				= 4;							{Script enabled flag}
	smScriptRight				= 6;							{Right to left flag}
	smScriptJust				= 8;							{Justification flag}
	smScriptRedraw				= 10;							{Word redraw flag}
	smScriptSysFond				= 12;							{Preferred system font}
	smScriptAppFond				= 14;							{Preferred Application font}
	smScriptBundle				= 16;							{Beginning of itlb verbs}
	smScriptNumber				= 16;							{Script itl0 id}
	smScriptDate				= 18;							{Script itl1 id}
	smScriptSort				= 20;							{Script itl2 id}
	smScriptFlags				= 22;							{flags word}
	smScriptToken				= 24;							{Script itl4 id}
	smScriptEncoding			= 26;							{id of optional itl5, if present}
	smScriptLang				= 28;							{Current language for script}

	smScriptNumDate				= 30;							{Script Number/Date formats.}
	smScriptKeys				= 32;							{Script KCHR id}
	smScriptIcon				= 34;							{ID # of SICN or kcs#/kcs4/kcs8 suite}
	smScriptPrint				= 36;							{Script printer action routine}
	smScriptTrap				= 38;							{Trap entry pointer}
	smScriptCreator				= 40;							{Script file creator}
	smScriptFile				= 42;							{Script file name}
	smScriptName				= 44;							{Script name}
{ There is a hole here for old Kanji private verbs 46-76 

 New for System 7.0: }
	smScriptMonoFondSize		= 78;							{default monospace FOND (hi) & size (lo)}
	smScriptPrefFondSize		= 80;							{preferred FOND (hi) & size (lo)}
	smScriptSmallFondSize		= 82;							{default small FOND (hi) & size (lo)}
	smScriptSysFondSize			= 84;							{default system FOND (hi) & size (lo)}
	smScriptAppFondSize			= 86;							{default app FOND (hi) & size (lo)}
	smScriptHelpFondSize		= 88;							{default Help Mgr FOND (hi) & size (lo)}
	smScriptValidStyles			= 90;							{mask of valid styles for script}
	smScriptAliasStyle			= 92;							{style (set) to use for aliases}
{ Special script code values for International Utilities }
	iuSystemScript				= -1;							{ <obsolete>  system script }
	iuCurrentScript				= -2;							{ <obsolete>  current script (for font of grafPort) }
{ Negative verbs for KeyScript }
	smKeyNextScript				= -1;							{ Switch to next available script }
	smKeySysScript				= -2;							{ Switch to the system script }
	smKeySwapScript				= -3;							{ Switch to previously-used script }
{ New for System 7.0: }
	smKeyNextKybd				= -4;							{ Switch to next keyboard in current keyscript }

	smKeySwapKybd				= -5;							{ Switch to previously-used keyboard in current keyscript }
	smKeyDisableKybds			= -6;							{ Disable keyboards not in system or Roman script }
	smKeyEnableKybds			= -7;							{ Re-enable keyboards for all enabled scripts }
	smKeyToggleInline			= -8;							{ Toggle inline input for current keyscript }
	smKeyToggleDirection		= -9;							{ Toggle default line direction (TESysJust) }
	smKeyNextInputMethod		= -10;							{ Switch to next input method in current keyscript }
	smKeySwapInputMethod		= -11;							{ Switch to last-used input method in current keyscript }
	smKeyDisableKybdSwitch		= -12;							{ Disable switching from the current keyboard }
	smKeySetDirLeftRight		= -15;							{ Set default line dir to left-right, align left }
	smKeySetDirRightLeft		= -16;							{ Set default line dir to right-left, align right }
	smKeyRoman					= -17;							{ Set keyscript to Roman. Does nothing if Roman-only
										system, unlike KeyScript(smRoman) which forces
										an update to current default Roman keyboard }
{ Bits in the smScriptFlags word
(bits above 8 are non-static) }
	smsfIntellCP				= 0;							{Script has intelligent cut & paste}
	smsfSingByte				= 1;							{Script has only single bytes}
	smsfNatCase					= 2;							{Native chars have upper & lower case}
	smsfContext					= 3;							{Script is contextual}
	smsfNoForceFont				= 4;							{Script will not force characters}
	smsfB0Digits				= 5;							{Script has alternate digits at B0-B9}
	smsfAutoInit				= 6;							{Auto initialize the script}
	smsfUnivExt					= 7;							{Script is handled by universal extension}
	smsfSynchUnstyledTE			= 8;							{Script synchronizes for unstyled TE}
	smsfForms					= 13;							{Uses contextual forms for letters}
	smsfLigatures				= 14;							{Uses contextual ligatures}
	smsfReverse					= 15;							{Reverses native text, right-left}
{ Bits in the smGenFlags long.
First (high-order) byte is set from itlc flags byte. }
	smfShowIcon					= 31;							{Show icon even if only one script}
	smfDualCaret				= 30;							{Use dual caret for mixed direction text}
	smfNameTagEnab				= 29;							{Reserved for internal use}
	smfUseAssocFontInfo			= 28;							{Use the associated font info for FontMetrics calls <48>}

{ Roman script constants 
 The following are here for backward compatibility, but should not be used. 
 This information should be obtained using GetScript. }
	romanSysFond				= $3FFF;						{system font id number}
	romanAppFond				= 3;							{application font id number}
	romanFlags					= $0007;						{roman settings}
{ Script Manager font equates. }
	smFondStart					= $4000;						{start from 16K}
	smFondEnd					= $C000;						{past end of range at 48K}
{ Miscellaneous font equates. }
	smUprHalfCharSet			= $80;							{first char code in top half of std char set}
{ Character Set Extensions }
	diaeresisUprY				= $D9;
	fraction					= $DA;
	intlCurrency				= $DB;
	leftSingGuillemet			= $DC;
	rightSingGuillemet			= $DD;
	fiLigature					= $DE;
	flLigature					= $DF;
	dblDagger					= $E0;
	centeredDot					= $E1;
	baseSingQuote				= $E2;
	baseDblQuote				= $E3;
	perThousand					= $E4;
	circumflexUprA				= $E5;

	circumflexUprE				= $E6;
	acuteUprA					= $E7;
	diaeresisUprE				= $E8;
	graveUprE					= $E9;
	acuteUprI					= $EA;
	circumflexUprI				= $EB;
	diaeresisUprI				= $EC;
	graveUprI					= $ED;
	acuteUprO					= $EE;
	circumflexUprO				= $EF;
	appleLogo					= $F0;
	graveUprO					= $F1;
	acuteUprU					= $F2;
	circumflexUprU				= $F3;
	graveUprU					= $F4;
	dotlessLwrI					= $F5;
	circumflex					= $F6;
	tilde						= $F7;
	macron						= $F8;
	breveMark					= $F9;

	overDot						= $FA;
	ringMark					= $FB;
	cedilla						= $FC;
	doubleAcute					= $FD;
	ogonek						= $FE;
	hachek						= $FF;
{ TokenType values }
	tokenIntl					= 4;							{the itl resource number of the tokenizer}
	tokenEmpty					= -1;							{used internally as an empty flag}

	tokenUnknown				= 0;							{chars that do not match a defined token type}
	tokenWhite					= 1;							{white space}
	tokenLeftLit				= 2;							{literal begin}
	tokenRightLit				= 3;							{literal end}
	tokenAlpha					= 4;							{alphabetic}
	tokenNumeric				= 5;							{numeric}
	tokenNewLine				= 6;							{new line}
	tokenLeftComment			= 7;							{open comment}
	tokenRightComment			= 8;							{close comment}
	tokenLiteral				= 9;							{literal}
	tokenEscape					= 10;							{character escape (e.g. '\' in "\n", "\t")}
	tokenAltNum					= 11;							{alternate number (e.g. $B0-B9 in Arabic,Hebrew)}
	tokenRealNum				= 12;							{real number}
	tokenAltReal				= 13;							{alternate real number}
	tokenReserve1				= 14;							{reserved}
	tokenReserve2				= 15;							{reserved}
	tokenLeftParen				= 16;							{open parenthesis}
	tokenRightParen				= 17;							{close parenthesis}
	tokenLeftBracket			= 18;							{open square bracket}
	tokenRightBracket			= 19;							{close square bracket}

	tokenLeftCurly				= 20;							{open curly bracket}
	tokenRightCurly				= 21;							{close curly bracket}
	tokenLeftEnclose			= 22;							{open guillemet}
	tokenRightEnclose			= 23;							{close guillemet}
	tokenPlus					= 24;
	tokenMinus					= 25;
	tokenAsterisk				= 26;							{times/multiply}
	tokenDivide					= 27;
	tokenPlusMinus				= 28;							{plus or minus symbol}
	tokenSlash					= 29;
	tokenBackSlash				= 30;
	tokenLess					= 31;							{less than symbol}
	tokenGreat					= 32;							{greater than symbol}
	tokenEqual					= 33;
	tokenLessEqual2				= 34;							{less than or equal, 2 characters (e.g. <=)}
	tokenLessEqual1				= 35;							{less than or equal, 1 character}
	tokenGreatEqual2			= 36;							{greater than or equal, 2 characters (e.g. >=)}
	tokenGreatEqual1			= 37;							{greater than or equal, 1 character}
	token2Equal					= 38;							{double equal (e.g. ==)}
	tokenColonEqual				= 39;							{colon equal}

	tokenNotEqual				= 40;							{not equal, 1 character}
	tokenLessGreat				= 41;							{less/greater, Pascal not equal (e.g. <>)}
	tokenExclamEqual			= 42;							{exclamation equal, C not equal (e.g. !=)}
	tokenExclam					= 43;							{exclamation point}
	tokenTilde					= 44;							{centered tilde}
	tokenComma					= 45;
	tokenPeriod					= 46;
	tokenLeft2Quote				= 47;							{open double quote}
	tokenRight2Quote			= 48;							{close double quote}
	tokenLeft1Quote				= 49;							{open single quote}
	tokenRight1Quote			= 50;							{close single quote}
	token2Quote					= 51;							{double quote}
	token1Quote					= 52;							{single quote}
	tokenSemicolon				= 53;
	tokenPercent				= 54;
	tokenCaret					= 55;
	tokenUnderline				= 56;
	tokenAmpersand				= 57;
	tokenAtSign					= 58;
	tokenBar					= 59;							{vertical bar}

	tokenQuestion				= 60;
	tokenPi						= 61;							{lower-case pi}
	tokenRoot					= 62;							{square root symbol}
	tokenSigma					= 63;							{capital sigma}
	tokenIntegral				= 64;							{integral sign}
	tokenMicro					= 65;
	tokenCapPi					= 66;							{capital pi}
	tokenInfinity				= 67;
	tokenColon					= 68;
	tokenHash					= 69;							{e.g. #}
	tokenDollar					= 70;
	tokenNoBreakSpace			= 71;							{non-breaking space}
	tokenFraction				= 72;
	tokenIntlCurrency			= 73;
	tokenLeftSingGuillemet		= 74;
	tokenRightSingGuillemet		= 75;
	tokenPerThousand			= 76;
	tokenEllipsis				= 77;
	tokenCenterDot				= 78;
	tokenNil					= 127;

	delimPad					= -2;
{ obsolete, misspelled token names kept for backward compatibility }
	tokenTilda					= 44;
	tokenCarat					= 55;

{ Table selectors for GetItlTable }
	smWordSelectTable			= 0;							{ get word select break table from 'itl2' }
	smWordWrapTable				= 1;							{ get word wrap break table from 'itl2' }
	smNumberPartsTable			= 2;							{ get default number parts table from 'itl4' }
	smUnTokenTable				= 3;							{ get unToken table from 'itl4' }
	smWhiteSpaceList			= 4;							{ get white space list from 'itl4' }
	iuWordSelectTable			= 0;							{ <obsolete>  get word select break table from 'itl2' }
	iuWordWrapTable				= 1;							{ <obsolete>  get word wrap break table from 'itl2' }
	iuNumberPartsTable			= 2;							{ <obsolete>  get default number parts table from 'itl4' }
	iuUnTokenTable				= 3;							{ <obsolete>  get unToken table from 'itl4' }
	iuWhiteSpaceList			= 4;							{ <obsolete>  get white space list from 'itl4' }

{ end of stuff moved from Packages.h }
	tokenOK						= 0;							{ TokenResults }
	tokenOverflow				= 1;							{ TokenResults }
	stringOverflow				= 2;							{ TokenResults }
	badDelim					= 3;							{ TokenResults }
	badEnding					= 4;							{ TokenResults }
	crash						= 5;							{ TokenResults }

	
TYPE
	TokenResults = SInt8;

	CharByteTable = PACKED ARRAY [0..255] OF CHAR;

	TokenType = INTEGER;

	DelimType = ARRAY [0..1] OF TokenType;

	CommentType = ARRAY [0..3] OF TokenType;

	TokenRec = RECORD
		theToken:				TokenType;
		position:				Ptr;									{pointer into original source}
		length:					LONGINT;								{length of text in original source}
		stringPosition:			StringPtr;								{Pascal/C string copy of identifier}
	END;

	TokenRecPtr = ^TokenRec;

	TokenBlock = RECORD
		source:					Ptr;									{pointer to stream of characters}
		sourceLength:			LONGINT;								{length of source stream}
		tokenList:				Ptr;									{pointer to array of tokens}
		tokenLength:			LONGINT;								{maximum length of TokenList}
		tokenCount:				LONGINT;								{number tokens generated by tokenizer}
		stringList:				Ptr;									{pointer to stream of identifiers}
		stringLength:			LONGINT;								{length of string list}
		stringCount:			LONGINT;								{number of bytes currently used}
		doString:				BOOLEAN;								{make strings & put into StringList}
		doAppend:				BOOLEAN;								{append to TokenList rather than replace}
		doAlphanumeric:			BOOLEAN;								{identifiers may include numeric}
		doNest:					BOOLEAN;								{do comments nest?}
		leftDelims:				ARRAY [0..1] OF TokenType;
		rightDelims:			ARRAY [0..1] OF TokenType;
		leftComment:			ARRAY [0..3] OF TokenType;
		rightComment:			ARRAY [0..3] OF TokenType;
		escapeCode:				TokenType;								{escape symbol code}
		decimalCode:			TokenType;
		itlResource:			Handle;									{handle to itl4 resource of current script}
		reserved:				ARRAY [0..7] OF LONGINT;				{must be zero!}
	END;

	TokenBlockPtr = ^TokenBlock;

FUNCTION GetSysDirection : INTEGER;
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $3EB8, $0BAC;			{ MOVE.w $0BAC,(SP) }
	{$ENDC}

PROCEDURE SetSysDirection( value: INTEGER );
	{$IFC NOT CFMSYSTEMCALLS}
	INLINE $31DF, $0BAC;			{ MOVE.w (SP)+,$0BAC }
	{$ENDC}

FUNCTION FontScript: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8200, $0000, $A8B5;
	{$ENDC}
FUNCTION IntlScript: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8200, $0002, $A8B5;
	{$ENDC}
PROCEDURE KeyScript(code: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8002, $0004, $A8B5;
	{$ENDC}
FUNCTION CharByte(textBuf: Ptr; textOffset: INTEGER): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8206, $0010, $A8B5;
	{$ENDC}
FUNCTION CharType(textBuf: Ptr; textOffset: INTEGER): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8206, $0012, $A8B5;
	{$ENDC}
FUNCTION IsCmdChar({CONST}VAR event: EventRecord; test: INTEGER): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8206, $FFD0, $A8B5;
	{$ENDC}
FUNCTION Transliterate(srcHandle: Handle; dstHandle: Handle; target: INTEGER; srcMask: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $820E, $0018, $A8B5;
	{$ENDC}
FUNCTION ParseTable(VAR table: CharByteTable): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8204, $0022, $A8B5;
	{$ENDC}
FUNCTION IntlTokenize(tokenParam: TokenBlockPtr): TokenResults;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8204, $FFFA, $A8B5;
	{$ENDC}
FUNCTION FontToScript(fontNumber: INTEGER): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8202, $0006, $A8B5;
	{$ENDC}
FUNCTION GetScriptManagerVariable(selector: INTEGER): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8402, $0008, $A8B5;
	{$ENDC}
FUNCTION SetScriptManagerVariable(selector: INTEGER; param: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8206, $000A, $A8B5;
	{$ENDC}
FUNCTION GetScriptVariable(script: INTEGER; selector: INTEGER): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8404, $000C, $A8B5;
	{$ENDC}
FUNCTION SetScriptVariable(script: INTEGER; selector: INTEGER; param: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8208, $000E, $A8B5;
	{$ENDC}
{  New for 7.1  }
FUNCTION GetScriptUtilityAddress(selector: INTEGER; Before: BOOLEAN; script: ScriptCode): UniversalProcPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $C404, $0038, $A8B5;
	{$ENDC}
PROCEDURE SetScriptUtilityAddress(selector: INTEGER; Before: BOOLEAN; routineAddr: UniversalProcPtr; script: ScriptCode);
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $C008, $003A, $A8B5;
	{$ENDC}
FUNCTION GetScriptQDPatchAddress(trapNum: INTEGER; Before: BOOLEAN; forPrinting: BOOLEAN; script: ScriptCode): UniversalProcPtr;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $C406, $003C, $A8B5;
	{$ENDC}
PROCEDURE SetScriptQDPatchAddress(trapNum: INTEGER; Before: BOOLEAN; forPrinting: BOOLEAN; routineAddr: UniversalProcPtr; script: ScriptCode);
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $C00A, $003E, $A8B5;
	{$ENDC}
FUNCTION CharacterByteType(textBuf: Ptr; textOffset: INTEGER; script: ScriptCode): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $C206, $0010, $A8B5;
	{$ENDC}
FUNCTION CharacterType(textBuf: Ptr; textOffset: INTEGER; script: ScriptCode): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $C206, $0012, $A8B5;
	{$ENDC}
FUNCTION TransliterateText(srcHandle: Handle; dstHandle: Handle; target: INTEGER; srcMask: LONGINT; script: ScriptCode): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $C20E, $0018, $A8B5;
	{$ENDC}
FUNCTION FillParseTable(VAR table: CharByteTable; script: ScriptCode): BOOLEAN;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $C204, $0022, $A8B5;
	{$ENDC}
{ Moved from Packages.h }
FUNCTION GetIntlResource(theID: INTEGER): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0006, $A9ED;
	{$ENDC}
PROCEDURE SetIntlResource(refNum: INTEGER; theID: INTEGER; intlHandle: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0008, $A9ED;
	{$ENDC}
PROCEDURE ClearIntlResourceCache;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0018, $A9ED;
	{$ENDC}
PROCEDURE GetIntlResourceTable(script: ScriptCode; tableCode: INTEGER; VAR itlHandle: Handle; VAR offset: LONGINT; VAR length: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0024, $A9ED;
	{$ENDC}
{$IFC OLDROUTINENAMES }
PROCEDURE SetSysJust(newDirection: INTEGER);
	{$IFC NOT GENERATINGCFM}
	INLINE $31DF, $0BAC;
	{$ENDC}
FUNCTION GetSysJust: INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $3EB8, $0BAC;
	{$ENDC}
FUNCTION Font2Script(fontNumber: INTEGER): INTEGER;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8202, $0006, $A8B5;
	{$ENDC}
FUNCTION GetEnvirons(selector: INTEGER): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8402, $0008, $A8B5;
	{$ENDC}
FUNCTION SetEnvirons(selector: INTEGER; param: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8206, $000A, $A8B5;
	{$ENDC}
FUNCTION GetScript(script: INTEGER; verb: INTEGER): LONGINT;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8404, $000C, $A8B5;
	{$ENDC}
FUNCTION SetScript(script: INTEGER; verb: INTEGER; param: LONGINT): OSErr;
	{$IFC NOT GENERATINGCFM}
	INLINE $2F3C, $8208, $000E, $A8B5;
	{$ENDC}
FUNCTION IUGetIntl(theID: INTEGER): Handle;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0006, $A9ED;
	{$ENDC}
PROCEDURE IUSetIntl(refNum: INTEGER; theID: INTEGER; intlHandle: Handle);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0008, $A9ED;
	{$ENDC}
PROCEDURE IUClearCache;
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0018, $A9ED;
	{$ENDC}
PROCEDURE IUGetItlTable(script: ScriptCode; tableCode: INTEGER; VAR itlHandle: Handle; VAR offset: LONGINT; VAR length: LONGINT);
	{$IFC NOT GENERATINGCFM}
	INLINE $3F3C, $0024, $A9ED;
	{$ENDC}
{$ENDC}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := ScriptIncludes}

{$ENDC} {__SCRIPT__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

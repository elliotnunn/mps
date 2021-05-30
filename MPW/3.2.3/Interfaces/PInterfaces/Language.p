
{
Created: Sunday, September 15, 1991 at 11:20 PM
 Language.p
 Pascal Interface to the Macintosh Libraries

  Copyright Apple Computer, Inc. 1986-1991
  All rights reserved
}


{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT Language;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED UsingLanguage}
{$SETC UsingLanguage := 1}


CONST

{ Language Codes }
langEnglish = 0;			{ smRoman script }
langFrench = 1;				{ smRoman script }
langGerman = 2;				{ smRoman script }
langItalian = 3;			{ smRoman script }
langDutch = 4;				{ smRoman script }
langSwedish = 5;			{ smRoman script }
langSpanish = 6;			{ smRoman script }
langDanish = 7;				{ smRoman script }
langPortuguese = 8;			{ smRoman script }
langNorwegian = 9;			{ smRoman script }
langHebrew = 10;			{ smHebrew script }
langJapanese = 11;			{ smJapanese script }
langArabic = 12;			{ smArabic script }
langFinnish = 13;			{ smRoman script }
langGreek = 14;				{ smGreek script }
langIcelandic = 15;			{ extended Roman script }
langMaltese = 16;			{ extended Roman script }
langTurkish = 17;			{ extended Roman script }
langCroatian = 18;			{ Serbo-Croatian in extended Roman script }
langTradChinese = 19;		{ Chinese in traditional characters }
langUrdu = 20;				{ smArabic script }
langHindi = 21;				{ smDevanagari script }
langThai = 22;				{ smThai script }
langKorean = 23;			{ smKorean script }
langLithuanian = 24;		{ smEastEurRoman script }
langPolish = 25;			{ smEastEurRoman script }
langHungarian = 26;			{ smEastEurRoman script }
langEstonian = 27;			{ smEastEurRoman script }
langLettish = 28;			{ smEastEurRoman script }
langLatvian = 28;			{ Synonym for langLettish }
langLapponian = 29;			{ extended Roman script }
langLappish = 29;			{ Synonym for langLapponian }
langFaeroese = 30;			{ smRoman script }
langFarsi = 31;				{ smArabic script }
langPersian = 31;			{ Synonym for langFarsi }
langRussian = 32;			{ smCyrillic script }
langSimpChinese = 33;		{ Chinese in simplified characters }
langFlemish = 34;			{ smRoman script }
langIrish = 35;				{ smRoman script }
langAlbanian = 36;			{ smRoman script }
langRomanian = 37;			{ smEastEurRoman script }
langCzech = 38;				{ smEastEurRoman script }
langSlovak = 39;			{ smEastEurRoman script }
langSlovenian = 40;			{ smEastEurRoman script }
langYiddish = 41;			{ smHebrew script }
langSerbian = 42;			{ Serbo-Croatian in smCyrillic script }
langMacedonian = 43;		{ smCyrillic script }
langBulgarian = 44;			{ smCyrillic script }
langUkrainian = 45;			{ smCyrillic script }
langByelorussian = 46;		{ smCyrillic script }
langUzbek = 47;				{ smCyrillic script }
langKazakh = 48;			{ smCyrillic script }
langAzerbaijani = 49;		{ Azerbaijani in smCyrillic script (USSR) }
langAzerbaijanAr = 50;		{ Azerbaijani in smArabic script (Iran) }
langArmenian = 51;			{ smArmenian script }
langGeorgian = 52;			{ smGeorgian script }
langMoldavian = 53;			{ smCyrillic script }
langKirghiz = 54;			{ smCyrillic script }
langTajiki = 55;			{ smCyrillic script }
langTurkmen = 56;			{ smCyrillic script }
langMongolian = 57;			{ Mongolian in smMongolian script }
langMongolianCyr = 58;		{ Mongolian in smCyrillic script }
langPashto = 59;			{ smArabic script }
langKurdish = 60;			{ smArabic script }
langKashmiri = 61;			{ smArabic script }
langSindhi = 62;			{ smExtArabic script }
langTibetan = 63;			{ smTibetan script }
langNepali = 64;			{ smDevanagari script }
langSanskrit = 65;			{ smDevanagari script }
langMarathi = 66;			{ smDevanagari script }
langBengali = 67;			{ smBengali script }
langAssamese = 68;			{ smBengali script }
langGujarati = 69;			{ smGujarati script }
langPunjabi = 70;			{ smGurmukhi script }
langOriya = 71;				{ smOriya script }
langMalayalam = 72;			{ smMalayalam script }
langKannada = 73;			{ smKannada script }
langTamil = 74;				{ smTamil script }
langTelugu = 75;			{ smTelugu script }
langSinhalese = 76;			{ smSinhalese script }
langBurmese = 77;			{ smBurmese script }
langKhmer = 78;				{ smKhmer script }
langLao = 79;				{ smLaotian script }
langVietnamese = 80;		{ smVietnamese script }
langIndonesian = 81;		{ smRoman script }
langTagalog = 82;			{ smRoman script }
langMalayRoman = 83;		{ Malay in smRoman script }
langMalayArabic = 84;		{ Malay in smArabic script }
langAmharic = 85;			{ smEthiopic script }
langTigrinya = 86;			{ smEthiopic script }
langGalla = 87;				{ smEthiopic script }
langOromo = 87;				{ Synonym for langGalla }
langSomali = 88;			{ smRoman script }
langSwahili = 89;			{ smRoman script }
langRuanda = 90;			{ smRoman script }
langRundi = 91;				{ smRoman script }
langChewa = 92;				{ smRoman script }
langMalagasy = 93;			{ smRoman script }
langEsperanto = 94;			{ extended Roman script }
langWelsh = 128;			{ smRoman script }
langBasque = 129;			{ smRoman script }
langCatalan = 130;			{ smRoman script }
langLatin = 131;			{ smRoman script }
langQuechua = 132;			{ smRoman script }
langGuarani = 133;			{ smRoman script }
langAymara = 134;			{ smRoman script }
langTatar = 135;			{ smCyrillic script }
langUighur = 136;			{ smArabic script }
langDzongkha = 137;			{ (lang of Bhutan) smTibetan script }
langJavaneseRom = 138;		{ Javanese in smRoman script }
langSundaneseRom = 139;		{ Sundanese in smRoman script }

{ Obsolete names, kept for backward compatibility }
langPortugese = 8;			{ old misspelled version, kept for compatibility }
langMalta = 16;				{ old misspelled version, kept for compatibility }
langYugoslavian = 18;		{ (use langCroatian, langSerbian, etc.) }
langChinese = 19;			{ (use langTradChinese or langSimpChinese) }


{$ENDC} { UsingLanguage }

{$IFC NOT UsingIncludes}
 END.
{$ENDC}


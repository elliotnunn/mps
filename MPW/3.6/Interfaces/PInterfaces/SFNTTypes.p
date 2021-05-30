{
     File:       SFNTTypes.p
 
     Contains:   Font file structures.
 
     Version:    Technology: Mac OS
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
 UNIT SFNTTypes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SFNTTYPES__}
{$SETC __SFNTTYPES__ := 1}

{$I+}
{$SETC SFNTTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __MACTYPES__}
{$I MacTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


TYPE
	sfntDirectoryEntryPtr = ^sfntDirectoryEntry;
	sfntDirectoryEntry = RECORD
		tableTag:				FourCharCode;
		checkSum:				UInt32;
		offset:					UInt32;
		length:					UInt32;
	END;

	{	 The search fields limits numOffsets to 4096. 	}
	sfntDirectoryPtr = ^sfntDirectory;
	sfntDirectory = RECORD
		format:					FourCharCode;
		numOffsets:				UInt16;									{  number of tables  }
		searchRange:			UInt16;									{  (max2 <= numOffsets)*16  }
		entrySelector:			UInt16;									{  log2(max2 <= numOffsets)  }
		rangeShift:				UInt16;									{  numOffsets*16-searchRange }
		table:					ARRAY [0..0] OF sfntDirectoryEntry;		{  table[numOffsets]  }
	END;


CONST
	sizeof_sfntDirectory		= 12;

	{	 Cmap - character id to glyph id mapping 	}
	cmapFontTableTag			= 'cmap';

	kFontUnicodePlatform		= 0;
	kFontMacintoshPlatform		= 1;
	kFontReservedPlatform		= 2;
	kFontMicrosoftPlatform		= 3;
	kFontCustomPlatform			= 4;

	kFontUnicodeDefaultSemantics = 0;
	kFontUnicodeV1_1Semantics	= 1;
	kFontISO10646_1993Semantics	= 2;

	kFontRomanScript			= 0;
	kFontJapaneseScript			= 1;
	kFontTraditionalChineseScript = 2;
	kFontChineseScript			= 2;
	kFontKoreanScript			= 3;
	kFontArabicScript			= 4;
	kFontHebrewScript			= 5;
	kFontGreekScript			= 6;
	kFontCyrillicScript			= 7;
	kFontRussian				= 7;
	kFontRSymbolScript			= 8;
	kFontDevanagariScript		= 9;
	kFontGurmukhiScript			= 10;
	kFontGujaratiScript			= 11;
	kFontOriyaScript			= 12;
	kFontBengaliScript			= 13;
	kFontTamilScript			= 14;
	kFontTeluguScript			= 15;
	kFontKannadaScript			= 16;
	kFontMalayalamScript		= 17;
	kFontSinhaleseScript		= 18;
	kFontBurmeseScript			= 19;
	kFontKhmerScript			= 20;
	kFontThaiScript				= 21;
	kFontLaotianScript			= 22;
	kFontGeorgianScript			= 23;
	kFontArmenianScript			= 24;
	kFontSimpleChineseScript	= 25;
	kFontTibetanScript			= 26;
	kFontMongolianScript		= 27;
	kFontGeezScript				= 28;
	kFontEthiopicScript			= 28;
	kFontAmharicScript			= 28;
	kFontSlavicScript			= 29;
	kFontEastEuropeanRomanScript = 29;
	kFontVietnameseScript		= 30;
	kFontExtendedArabicScript	= 31;
	kFontSindhiScript			= 31;
	kFontUninterpretedScript	= 32;

	kFontMicrosoftSymbolScript	= 0;
	kFontMicrosoftStandardScript = 1;


	kFontCustom8BitScript		= 0;
	kFontCustom816BitScript		= 1;
	kFontCustom16BitScript		= 2;

	{	 Language codes are zero based everywhere but within a 'cmap' table 	}
	kFontEnglishLanguage		= 0;
	kFontFrenchLanguage			= 1;
	kFontGermanLanguage			= 2;
	kFontItalianLanguage		= 3;
	kFontDutchLanguage			= 4;
	kFontSwedishLanguage		= 5;
	kFontSpanishLanguage		= 6;
	kFontDanishLanguage			= 7;
	kFontPortugueseLanguage		= 8;
	kFontNorwegianLanguage		= 9;
	kFontHebrewLanguage			= 10;
	kFontJapaneseLanguage		= 11;
	kFontArabicLanguage			= 12;
	kFontFinnishLanguage		= 13;
	kFontGreekLanguage			= 14;
	kFontIcelandicLanguage		= 15;
	kFontMalteseLanguage		= 16;
	kFontTurkishLanguage		= 17;
	kFontCroatianLanguage		= 18;
	kFontTradChineseLanguage	= 19;
	kFontUrduLanguage			= 20;
	kFontHindiLanguage			= 21;
	kFontThaiLanguage			= 22;
	kFontKoreanLanguage			= 23;
	kFontLithuanianLanguage		= 24;
	kFontPolishLanguage			= 25;
	kFontHungarianLanguage		= 26;
	kFontEstonianLanguage		= 27;
	kFontLettishLanguage		= 28;
	kFontLatvianLanguage		= 28;
	kFontSaamiskLanguage		= 29;
	kFontLappishLanguage		= 29;
	kFontFaeroeseLanguage		= 30;
	kFontFarsiLanguage			= 31;
	kFontPersianLanguage		= 31;
	kFontRussianLanguage		= 32;
	kFontSimpChineseLanguage	= 33;
	kFontFlemishLanguage		= 34;
	kFontIrishLanguage			= 35;
	kFontAlbanianLanguage		= 36;
	kFontRomanianLanguage		= 37;
	kFontCzechLanguage			= 38;
	kFontSlovakLanguage			= 39;
	kFontSlovenianLanguage		= 40;
	kFontYiddishLanguage		= 41;
	kFontSerbianLanguage		= 42;
	kFontMacedonianLanguage		= 43;
	kFontBulgarianLanguage		= 44;
	kFontUkrainianLanguage		= 45;
	kFontByelorussianLanguage	= 46;
	kFontUzbekLanguage			= 47;
	kFontKazakhLanguage			= 48;
	kFontAzerbaijaniLanguage	= 49;
	kFontAzerbaijanArLanguage	= 50;
	kFontArmenianLanguage		= 51;
	kFontGeorgianLanguage		= 52;
	kFontMoldavianLanguage		= 53;
	kFontKirghizLanguage		= 54;
	kFontTajikiLanguage			= 55;
	kFontTurkmenLanguage		= 56;
	kFontMongolianLanguage		= 57;
	kFontMongolianCyrLanguage	= 58;
	kFontPashtoLanguage			= 59;
	kFontKurdishLanguage		= 60;
	kFontKashmiriLanguage		= 61;
	kFontSindhiLanguage			= 62;
	kFontTibetanLanguage		= 63;
	kFontNepaliLanguage			= 64;
	kFontSanskritLanguage		= 65;
	kFontMarathiLanguage		= 66;
	kFontBengaliLanguage		= 67;
	kFontAssameseLanguage		= 68;
	kFontGujaratiLanguage		= 69;
	kFontPunjabiLanguage		= 70;
	kFontOriyaLanguage			= 71;
	kFontMalayalamLanguage		= 72;
	kFontKannadaLanguage		= 73;
	kFontTamilLanguage			= 74;
	kFontTeluguLanguage			= 75;
	kFontSinhaleseLanguage		= 76;
	kFontBurmeseLanguage		= 77;
	kFontKhmerLanguage			= 78;
	kFontLaoLanguage			= 79;
	kFontVietnameseLanguage		= 80;
	kFontIndonesianLanguage		= 81;
	kFontTagalogLanguage		= 82;
	kFontMalayRomanLanguage		= 83;
	kFontMalayArabicLanguage	= 84;
	kFontAmharicLanguage		= 85;
	kFontTigrinyaLanguage		= 86;
	kFontGallaLanguage			= 87;
	kFontOromoLanguage			= 87;
	kFontSomaliLanguage			= 88;
	kFontSwahiliLanguage		= 89;
	kFontRuandaLanguage			= 90;
	kFontRundiLanguage			= 91;
	kFontChewaLanguage			= 92;
	kFontMalagasyLanguage		= 93;
	kFontEsperantoLanguage		= 94;
	kFontWelshLanguage			= 128;
	kFontBasqueLanguage			= 129;
	kFontCatalanLanguage		= 130;
	kFontLatinLanguage			= 131;
	kFontQuechuaLanguage		= 132;
	kFontGuaraniLanguage		= 133;
	kFontAymaraLanguage			= 134;
	kFontTatarLanguage			= 135;
	kFontUighurLanguage			= 136;
	kFontDzongkhaLanguage		= 137;
	kFontJavaneseRomLanguage	= 138;
	kFontSundaneseRomLanguage	= 139;

	{	 The following are special "don't care" values to be used in interfaces 	}
	kFontNoPlatform				= -1;
	kFontNoScript				= -1;
	kFontNoLanguage				= -1;


TYPE
	sfntCMapSubHeaderPtr = ^sfntCMapSubHeader;
	sfntCMapSubHeader = RECORD
		format:					UInt16;
		length:					UInt16;
		languageID:				UInt16;									{  base-1  }
	END;


CONST
	sizeof_sfntCMapSubHeader	= 6;


TYPE
	sfntCMapEncodingPtr = ^sfntCMapEncoding;
	sfntCMapEncoding = RECORD
		platformID:				UInt16;									{  base-0  }
		scriptID:				UInt16;									{  base-0  }
		offset:					UInt32;
	END;


CONST
	sizeof_sfntCMapEncoding		= 8;


TYPE
	sfntCMapHeaderPtr = ^sfntCMapHeader;
	sfntCMapHeader = RECORD
		version:				UInt16;
		numTables:				UInt16;
		encoding:				ARRAY [0..0] OF sfntCMapEncoding;
	END;


CONST
	sizeof_sfntCMapHeader		= 4;

	{	 Name table 	}
	nameFontTableTag			= 'name';

	kFontCopyrightName			= 0;
	kFontFamilyName				= 1;
	kFontStyleName				= 2;
	kFontUniqueName				= 3;
	kFontFullName				= 4;
	kFontVersionName			= 5;
	kFontPostscriptName			= 6;
	kFontTrademarkName			= 7;
	kFontManufacturerName		= 8;
	kFontDesignerName			= 9;
	kFontDescriptionName		= 10;
	kFontVendorURLName			= 11;
	kFontDesignerURLName		= 12;
	kFontLicenseDescriptionName	= 13;
	kFontLicenseInfoURLName		= 14;
	kFontLastReservedName		= 255;

	{	 The following is a special "don't care" value to be used in interfaces 	}
	kFontNoName					= -1;


TYPE
	sfntNameRecordPtr = ^sfntNameRecord;
	sfntNameRecord = RECORD
		platformID:				UInt16;									{  base-0  }
		scriptID:				UInt16;									{  base-0  }
		languageID:				UInt16;									{  base-0  }
		nameID:					UInt16;									{  base-0  }
		length:					UInt16;
		offset:					UInt16;
	END;


CONST
	sizeof_sfntNameRecord		= 12;


TYPE
	sfntNameHeaderPtr = ^sfntNameHeader;
	sfntNameHeader = RECORD
		format:					UInt16;
		count:					UInt16;
		stringOffset:			UInt16;
		rec:					ARRAY [0..0] OF sfntNameRecord;
	END;


CONST
	sizeof_sfntNameHeader		= 6;

	{	 Fvar table - font variations 	}
	variationFontTableTag		= 'fvar';

	{	 These define each font variation 	}

TYPE
	sfntVariationAxisPtr = ^sfntVariationAxis;
	sfntVariationAxis = RECORD
		axisTag:				FourCharCode;
		minValue:				Fixed;
		defaultValue:			Fixed;
		maxValue:				Fixed;
		flags:					SInt16;
		nameID:					SInt16;
	END;


CONST
	sizeof_sfntVariationAxis	= 20;

	{	 These are named locations in style-space for the user 	}

TYPE
	sfntInstancePtr = ^sfntInstance;
	sfntInstance = RECORD
		nameID:					SInt16;
		flags:					SInt16;
		coord:					ARRAY [0..0] OF Fixed;					{  [axisCount]  }
																		{  room to grow since the header carries a tupleSize field  }
	END;


CONST
	sizeof_sfntInstance			= 4;


TYPE
	sfntVariationHeaderPtr = ^sfntVariationHeader;
	sfntVariationHeader = RECORD
		version:				Fixed;									{  1.0 Fixed  }
		offsetToData:			UInt16;									{  to first axis = 16 }
		countSizePairs:			UInt16;									{  axis+inst = 2  }
		axisCount:				UInt16;
		axisSize:				UInt16;
		instanceCount:			UInt16;
		instanceSize:			UInt16;
																		{  …other <count,size> pairs  }
		axis:					ARRAY [0..0] OF sfntVariationAxis;		{  [axisCount]  }
		instance:				ARRAY [0..0] OF sfntInstance;			{  [instanceCount]  …other arrays of data  }
	END;


CONST
	sizeof_sfntVariationHeader	= 16;

	{	 Fdsc table - font descriptor 	}
	descriptorFontTableTag		= 'fdsc';


TYPE
	sfntFontDescriptorPtr = ^sfntFontDescriptor;
	sfntFontDescriptor = RECORD
		name:					FourCharCode;
		value:					Fixed;
	END;

	sfntDescriptorHeaderPtr = ^sfntDescriptorHeader;
	sfntDescriptorHeader = RECORD
		version:				Fixed;									{  1.0 in Fixed  }
		descriptorCount:		SInt32;
		descriptor:				ARRAY [0..0] OF sfntFontDescriptor;
	END;


CONST
	sizeof_sfntDescriptorHeader	= 8;

	{	 Feat Table - layout feature table 	}
	featureFontTableTag			= 'feat';


TYPE
	sfntFeatureNamePtr = ^sfntFeatureName;
	sfntFeatureName = RECORD
		featureType:			UInt16;
		settingCount:			UInt16;
		offsetToSettings:		SInt32;
		featureFlags:			UInt16;
		nameID:					UInt16;
	END;

	sfntFontFeatureSettingPtr = ^sfntFontFeatureSetting;
	sfntFontFeatureSetting = RECORD
		setting:				UInt16;
		nameID:					UInt16;
	END;

	sfntFontRunFeaturePtr = ^sfntFontRunFeature;
	sfntFontRunFeature = RECORD
		featureType:			UInt16;
		setting:				UInt16;
	END;

	sfntFeatureHeaderPtr = ^sfntFeatureHeader;
	sfntFeatureHeader = RECORD
		version:				SInt32;									{  1.0  }
		featureNameCount:		UInt16;
		featureSetCount:		UInt16;
		reserved:				SInt32;									{  set to 0  }
		names:					ARRAY [0..0] OF sfntFeatureName;
		settings:				ARRAY [0..0] OF sfntFontFeatureSetting;
		runs:					ARRAY [0..0] OF sfntFontRunFeature;
	END;

	{	 OS/2 Table 	}

CONST
	os2FontTableTag				= 'OS/2';

	{	  Special invalid glyph ID value, useful as a sentinel value, for example 	}
	nonGlyphID					= 65535;

	{	  Data type used to access names from font name table 	}

TYPE
	FontNameCode						= UInt32;
	{	 Data types for encoding components as used in interfaces 	}
	FontPlatformCode					= UInt32;
	FontScriptCode						= UInt32;
	FontLanguageCode					= UInt32;
	{	
	**  FontVariation is used to specify a coordinate along a variation axis. The name
	**  identifies the axes to be applied, and value is the setting to be used.
		}
	FontVariationPtr = ^FontVariation;
	FontVariation = RECORD
		name:					FourCharCode;
		value:					Fixed;
	END;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SFNTTypesIncludes}

{$ENDC} {__SFNTTYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

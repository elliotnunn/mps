{
 	File:		SFNTTypes.p
 
 	Contains:	Font file structures.
 
 	Version:	Technology:	Quickdraw GX 1.1
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
 UNIT SFNTTypes;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __SFNTTYPES__}
{$SETC __SFNTTYPES__ := 1}

{$I+}
{$SETC SFNTTypesIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}


{$IFC UNDEFINED __GXMATH__}
{$I GXMath.p}
{$ENDC}
{	ConditionalMacros.p											}
{	Types.p														}
{	FixMath.p													}

{$IFC UNDEFINED __GXTYPES__}
{$I GXTypes.p}
{$ENDC}
{	MixedMode.p													}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

TYPE
	sfntDirectoryEntry = RECORD
		tableTag:				gxFontTableTag;
		checkSum:				LONGINT;
		offset:					LONGINT;
		length:					LONGINT;
	END;

{ The search fields limits numOffsets to 4096. }
	sfntDirectory = RECORD
		format:					gxFontFormatTag;
		numOffsets:				INTEGER;								{ number of tables }
		searchRange:			INTEGER;								{ (max2 <= numOffsets)*16 }
		entrySelector:			INTEGER;								{ log2(max2 <= numOffsets) }
		rangeShift:				INTEGER;								{ numOffsets*16-searchRange}
		table:					ARRAY [0..0] OF sfntDirectoryEntry;		{ table[numOffsets] }
	END;


CONST
	sizeof_sfntDirectory		= 12;

{ Cmap - character id to glyph id gxMapping }
	cmapFontTableTag			= 'cmap';


TYPE
	sfntCMapSubHeader = RECORD
		format:					INTEGER;
		length:					INTEGER;
		languageID:				INTEGER;								{ base-1 }
	END;


CONST
	sizeof_sfntCMapSubHeader	= 6;


TYPE
	sfntCMapEncoding = RECORD
		platformID:				INTEGER;								{ base-0 }
		scriptID:				INTEGER;								{ base-0 }
		offset:					LONGINT;
	END;


CONST
	sizeof_sfntCMapEncoding		= 8;


TYPE
	sfntCMapHeader = RECORD
		version:				INTEGER;
		numTables:				INTEGER;
		encoding:				ARRAY [0..0] OF sfntCMapEncoding;
	END;


CONST
	sizeof_sfntCMapHeader		= 4;

{ Name table }
	nameFontTableTag			= 'name';


TYPE
	sfntNameRecord = RECORD
		platformID:				INTEGER;								{ base-0 }
		scriptID:				INTEGER;								{ base-0 }
		languageID:				INTEGER;								{ base-0 }
		nameID:					INTEGER;								{ base-0 }
		length:					INTEGER;
		offset:					INTEGER;
	END;


CONST
	sizeof_sfntNameRecord		= 12;


TYPE
	sfntNameHeader = RECORD
		format:					INTEGER;
		count:					INTEGER;
		stringOffset:			INTEGER;
		rec:					ARRAY [0..0] OF sfntNameRecord;
	END;


CONST
	sizeof_sfntNameHeader		= 6;

{ Fvar table - gxFont variations }
	variationFontTableTag		= 'fvar';

{ These define each gxFont variation }

TYPE
	sfntVariationAxis = RECORD
		axisTag:				gxFontVariationTag;
		minValue:				Fixed;
		defaultValue:			Fixed;
		maxValue:				Fixed;
		flags:					INTEGER;
		nameID:					INTEGER;
	END;


CONST
	sizeof_sfntVariationAxis	= 20;

{ These are named locations in gxStyle-space for the user }

TYPE
	sfntInstance = RECORD
		nameID:					INTEGER;
		flags:					INTEGER;
		coord:					ARRAY [0..0] OF Fixed;					{ [axisCount] }
		{ room to grow since the header carries a tupleSize field }
	END;


CONST
	sizeof_sfntInstance			= 4;


TYPE
	sfntVariationHeader = RECORD
		version:				Fixed;									{ 1.0 Fixed }
		offsetToData:			INTEGER;								{ to first axis = 16}
		countSizePairs:			INTEGER;								{ axis+inst = 2 }
		axisCount:				INTEGER;
		axisSize:				INTEGER;
		instanceCount:			INTEGER;
		instanceSize:			INTEGER;
		{ …other <count,size> pairs }
		axis:					ARRAY [0..0] OF sfntVariationAxis;		{ [axisCount] }
		instance:				ARRAY [0..0] OF sfntInstance;			{ [instanceCount]  …other arrays of data }
	END;


CONST
	sizeof_sfntVariationHeader	= 16;

{ Fdsc table - gxFont descriptor }
	descriptorFontTableTag		= 'fdsc';


TYPE
	sfntDescriptorHeader = RECORD
		version:				Fixed;									{ 1.0 in Fixed }
		descriptorCount:		LONGINT;
		descriptor:				ARRAY [0..0] OF gxFontDescriptor;
	END;


CONST
	sizeof_sfntDescriptorHeader	= 8;

{ Feat Table - layout feature table }
	featureFontTableTag			= 'feat';


TYPE
	sfntFeatureName = RECORD
		featureType:			INTEGER;
		settingCount:			INTEGER;
		offsetToSettings:		LONGINT;
		featureFlags:			INTEGER;
		nameID:					INTEGER;
	END;

	sfntFontRunFeature = RECORD
		featureType:			INTEGER;
		setting:				INTEGER;
	END;

	sfntFeatureHeader = RECORD
		version:				LONGINT;								{ 1.0 }
		featureNameCount:		INTEGER;
		featureSetCount:		INTEGER;
		reserved:				LONGINT;								{ set to 0 }
		names:					ARRAY [0..0] OF sfntFeatureName;
		settings:				ARRAY [0..0] OF gxFontFeatureSetting;
		runs:					ARRAY [0..0] OF sfntFontRunFeature;
	END;

{ OS/2 Table }

CONST
	os2FontTableTag				= 'OS/2';

{  Special invalid glyph ID value, useful as a sentinel value, for example }
	nonGlyphID					= 65535;


{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := SFNTTypesIncludes}

{$ENDC} {__SFNTTYPES__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

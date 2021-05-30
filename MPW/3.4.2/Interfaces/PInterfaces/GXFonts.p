{
 	File:		GXFonts.p
 
 	Contains:	QuickDraw GX font routine interfaces.
 
 	Version:	Technology:	Quickdraw GX 1.1
 				Release:	Universal Interfaces 2.1.4
 
 	Copyright:	© 1984-1996 by Apple Computer, Inc.  All rights reserved.
 
 	Bugs?:		If you find a problem with this file, send the file and version
 				information (from above) and the problem description to:
 
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
}
{$IFC UNDEFINED UsingIncludes}
{$SETC UsingIncludes := 0}
{$ENDC}

{$IFC NOT UsingIncludes}
 UNIT GXFonts;
 INTERFACE
{$ENDC}

{$IFC UNDEFINED __GXFONTS__}
{$SETC __GXFONTS__ := 1}

{$I+}
{$SETC GXFontsIncludes := UsingIncludes}
{$SETC UsingIncludes := 1}

{$IFC UNDEFINED __CONDITIONALMACROS__}
{$I ConditionalMacros.p}
{$ENDC}
{$IFC UNDEFINED __GXMATH__}
{$I GXMath.p}
{$ENDC}
{$IFC UNDEFINED __GXTYPES__}
{$I GXTypes.p}
{$ENDC}
{$IFC UNDEFINED __SCALERTYPES__}
{$I ScalerTypes.p}
{$ENDC}

{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}


FUNCTION GXNewFont(storage: gxFontStorageTag; reference: gxFontStorageReference; attributes: gxFontAttribute): gxFont; C;
FUNCTION GXGetFont(fontID: gxFont; VAR reference: gxFontStorageReference; VAR attributes: gxFontAttribute): gxFontStorageTag; C;
FUNCTION GXFindFont(storage: gxFontStorageTag; reference: gxFontStorageReference; VAR attributes: gxFontAttribute): gxFont; C;
PROCEDURE GXSetFont(fontID: gxFont; storage: gxFontStorageTag; reference: gxFontStorageReference; attributes: gxFontAttribute); C;
PROCEDURE GXDisposeFont(fontID: gxFont); C;
PROCEDURE GXChangedFont(fontID: gxFont); C;
FUNCTION GXGetFontFormat(fontID: gxFont): gxFontFormatTag; C;
FUNCTION GXGetDefaultFont: gxFont; C;
FUNCTION GXSetDefaultFont(fontID: gxFont): gxFont; C;
FUNCTION GXFindFonts(familyID: gxFont; name: gxFontName; platform: gxFontPlatform; script: gxFontScript; language: gxFontLanguage; length: LONGINT; {CONST}VAR text: UInt8; index: LONGINT; count: LONGINT; VAR fonts: gxFont): LONGINT; C;
FUNCTION GXCountFontGlyphs(fontID: gxFont): LONGINT; C;
FUNCTION GXCountFontTables(fontID: gxFont): LONGINT; C;
FUNCTION GXGetFontTable(fontID: gxFont; index: LONGINT; tableData: UNIV Ptr; VAR tableTag: gxFontTableTag): LONGINT; C;
FUNCTION GXFindFontTable(fontID: gxFont; tableTag: gxFontTableTag; tableData: UNIV Ptr; VAR index: LONGINT): LONGINT; C;
FUNCTION GXGetFontTableParts(fontID: gxFont; index: LONGINT; offset: LONGINT; length: LONGINT; tableData: UNIV Ptr; VAR tableTag: gxFontTableTag): LONGINT; C;
FUNCTION GXFindFontTableParts(fontID: gxFont; tableTag: gxFontTableTag; offset: LONGINT; length: LONGINT; tableData: UNIV Ptr; VAR index: LONGINT): LONGINT; C;
FUNCTION GXSetFontTable(fontID: gxFont; index: LONGINT; tableTag: gxFontTableTag; length: LONGINT; tableData: UNIV Ptr): LONGINT; C;
FUNCTION GXSetFontTableParts(fontID: gxFont; index: LONGINT; tableTag: gxFontTableTag; offset: LONGINT; oldLength: LONGINT; newLength: LONGINT; tableData: UNIV Ptr): LONGINT; C;
FUNCTION GXDeleteFontTable(fontID: gxFont; index: LONGINT; tableTag: gxFontTableTag): LONGINT; C;
FUNCTION GXCountFontNames(fontID: gxFont): LONGINT; C;
FUNCTION GXGetFontName(fontID: gxFont; index: LONGINT; VAR name: gxFontName; VAR platform: gxFontPlatform; VAR script: gxFontScript; VAR language: gxFontLanguage; VAR text: UInt8): LONGINT; C;
FUNCTION GXFindFontName(fontID: gxFont; name: gxFontName; platform: gxFontPlatform; script: gxFontScript; language: gxFontLanguage; VAR text: UInt8; VAR index: LONGINT): LONGINT; C;
FUNCTION GXSetFontName(fontID: gxFont; name: gxFontName; platform: gxFontPlatform; script: gxFontScript; language: gxFontLanguage; length: LONGINT; {CONST}VAR text: UInt8): LONGINT; C;
FUNCTION GXDeleteFontName(fontID: gxFont; index: LONGINT; name: gxFontName; platform: gxFontPlatform; script: gxFontScript; language: gxFontLanguage): LONGINT; C;
FUNCTION GXNewFontNameID(fontID: gxFont): gxFontName; C;
FUNCTION GXCountFontEncodings(fontID: gxFont): LONGINT; C;
FUNCTION GXGetFontEncoding(fontID: gxFont; index: LONGINT; VAR script: gxFontScript; VAR language: gxFontLanguage): gxFontPlatform; C;
FUNCTION GXFindFontEncoding(fontID: gxFont; platform: gxFontPlatform; script: gxFontScript; language: gxFontLanguage): LONGINT; C;
FUNCTION GXApplyFontEncoding(fontID: gxFont; index: LONGINT; VAR length: LONGINT; {CONST}VAR text: UInt8; count: LONGINT; VAR glyphs: INTEGER; VAR was16Bit: CHAR): LONGINT; C;
FUNCTION GXCountFontVariations(fontID: gxFont): LONGINT; C;
FUNCTION GXFindFontVariation(fontID: gxFont; variationTag: gxFontVariationTag; VAR minValue: Fixed; VAR defaultValue: Fixed; VAR maxValue: Fixed; VAR name: gxFontName): LONGINT; C;
FUNCTION GXGetFontVariation(fontID: gxFont; index: LONGINT; VAR minValue: Fixed; VAR defaultValue: Fixed; VAR maxValue: Fixed; VAR name: gxFontName): gxFontVariationTag; C;
FUNCTION GXCountFontInstances(fontID: gxFont): LONGINT; C;
FUNCTION GXGetFontInstance(fontID: gxFont; index: LONGINT; VAR variation: gxFontVariation): gxFontName; C;
FUNCTION GXSetFontInstance(fontID: gxFont; index: LONGINT; name: gxFontName; {CONST}VAR variation: gxFontVariation): LONGINT; C;
FUNCTION GXDeleteFontInstance(fontID: gxFont; index: LONGINT; name: gxFontName): LONGINT; C;
FUNCTION GXCountFontDescriptors(fontID: gxFont): LONGINT; C;
FUNCTION GXGetFontDescriptor(fontID: gxFont; index: LONGINT; VAR descriptorValue: Fixed): gxFontDescriptorTag; C;
FUNCTION GXFindFontDescriptor(fontID: gxFont; descriptorTag: gxFontDescriptorTag; VAR descriptorValue: Fixed): LONGINT; C;
FUNCTION GXSetFontDescriptor(fontID: gxFont; index: LONGINT; descriptorTag: gxFontDescriptorTag; descriptorValue: Fixed): LONGINT; C;
FUNCTION GXDeleteFontDescriptor(fontID: gxFont; index: LONGINT; descriptorTag: gxFontDescriptorTag): LONGINT; C;
FUNCTION GXCountFontFeatures(fontID: gxFont): LONGINT; C;
FUNCTION GXGetFontFeature(fontID: gxFont; index: LONGINT; VAR flags: gxFontFeatureFlag; VAR settingCount: LONGINT; VAR settings: gxFontFeatureSetting; VAR feature: gxFontFeature): gxFontName; C;
FUNCTION GXFindFontFeature(fontID: gxFont; feature: gxFontFeature; VAR flags: gxFontFeatureFlag; VAR settingCount: LONGINT; VAR settings: gxFontFeatureSetting; VAR index: LONGINT): gxFontName; C;
FUNCTION GXGetFontDefaultFeatures(fontID: gxFont; VAR features: gxRunFeature): LONGINT; C;
PROCEDURE GXFlattenFont(source: gxFont; VAR stream: scalerStream; VAR block: gxSpoolBlock); C;

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXFontsIncludes}

{$ENDC} {__GXFONTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

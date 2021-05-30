{
     File:       GXFonts.p
 
     Contains:   QuickDraw GX font routine interfaces.
 
     Version:    Technology: Quickdraw GX 1.1
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
{$IFC UNDEFINED __SCALERSTREAMTYPES__}
{$I ScalerStreamTypes.p}
{$ENDC}


{$PUSH}
{$ALIGN MAC68K}
{$LibExport+}

{$IFC CALL_NOT_IN_CARBON }
{
 *  GXNewFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewFont(storage: gxFontStorageTag; reference: gxFontStorageReference; attributes: gxFontAttribute): gxFont; C;
{
 *  GXGetFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetFont(fontID: gxFont; VAR reference: gxFontStorageReference; VAR attributes: gxFontAttribute): gxFontStorageTag; C;
{
 *  GXFindFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXFindFont(storage: gxFontStorageTag; reference: gxFontStorageReference; VAR attributes: gxFontAttribute): gxFont; C;
{
 *  GXSetFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXSetFont(fontID: gxFont; storage: gxFontStorageTag; reference: gxFontStorageReference; attributes: gxFontAttribute); C;
{
 *  GXDisposeFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXDisposeFont(fontID: gxFont); C;
{
 *  GXChangedFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXChangedFont(fontID: gxFont); C;
{
 *  GXGetFontFormat()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetFontFormat(fontID: gxFont): gxFontFormatTag; C;
{
 *  GXGetDefaultFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetDefaultFont: gxFont; C;
{
 *  GXSetDefaultFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXSetDefaultFont(fontID: gxFont): gxFont; C;
{
 *  GXFindFonts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXFindFonts(familyID: gxFont; name: gxFontName; platform: gxFontPlatform; script: gxFontScript; language: gxFontLanguage; length: LONGINT; {CONST}VAR text: UInt8; index: LONGINT; count: LONGINT; VAR fonts: gxFont): LONGINT; C;
{
 *  GXCountFontGlyphs()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCountFontGlyphs(fontID: gxFont): LONGINT; C;
{
 *  GXCountFontTables()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCountFontTables(fontID: gxFont): LONGINT; C;
{
 *  GXGetFontTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetFontTable(fontID: gxFont; index: LONGINT; tableData: UNIV Ptr; VAR tableTag: gxFontTableTag): LONGINT; C;
{
 *  GXFindFontTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXFindFontTable(fontID: gxFont; tableTag: gxFontTableTag; tableData: UNIV Ptr; VAR index: LONGINT): LONGINT; C;
{
 *  GXGetFontTableParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetFontTableParts(fontID: gxFont; index: LONGINT; offset: LONGINT; length: LONGINT; tableData: UNIV Ptr; VAR tableTag: gxFontTableTag): LONGINT; C;
{
 *  GXFindFontTableParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXFindFontTableParts(fontID: gxFont; tableTag: gxFontTableTag; offset: LONGINT; length: LONGINT; tableData: UNIV Ptr; VAR index: LONGINT): LONGINT; C;
{
 *  GXSetFontTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXSetFontTable(fontID: gxFont; index: LONGINT; tableTag: gxFontTableTag; length: LONGINT; tableData: UNIV Ptr): LONGINT; C;
{
 *  GXSetFontTableParts()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXSetFontTableParts(fontID: gxFont; index: LONGINT; tableTag: gxFontTableTag; offset: LONGINT; oldLength: LONGINT; newLength: LONGINT; tableData: UNIV Ptr): LONGINT; C;
{
 *  GXDeleteFontTable()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXDeleteFontTable(fontID: gxFont; index: LONGINT; tableTag: gxFontTableTag): LONGINT; C;
{
 *  GXCountFontNames()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCountFontNames(fontID: gxFont): LONGINT; C;
{
 *  GXGetFontName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetFontName(fontID: gxFont; index: LONGINT; VAR name: gxFontName; VAR platform: gxFontPlatform; VAR script: gxFontScript; VAR language: gxFontLanguage; VAR text: UInt8): LONGINT; C;
{
 *  GXFindFontName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXFindFontName(fontID: gxFont; name: gxFontName; platform: gxFontPlatform; script: gxFontScript; language: gxFontLanguage; VAR text: UInt8; VAR index: LONGINT): LONGINT; C;
{
 *  GXSetFontName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXSetFontName(fontID: gxFont; name: gxFontName; platform: gxFontPlatform; script: gxFontScript; language: gxFontLanguage; length: LONGINT; {CONST}VAR text: UInt8): LONGINT; C;
{
 *  GXDeleteFontName()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXDeleteFontName(fontID: gxFont; index: LONGINT; name: gxFontName; platform: gxFontPlatform; script: gxFontScript; language: gxFontLanguage): LONGINT; C;
{
 *  GXNewFontNameID()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXNewFontNameID(fontID: gxFont): gxFontName; C;
{
 *  GXCountFontEncodings()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCountFontEncodings(fontID: gxFont): LONGINT; C;
{
 *  GXGetFontEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetFontEncoding(fontID: gxFont; index: LONGINT; VAR script: gxFontScript; VAR language: gxFontLanguage): gxFontPlatform; C;
{
 *  GXFindFontEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXFindFontEncoding(fontID: gxFont; platform: gxFontPlatform; script: gxFontScript; language: gxFontLanguage): LONGINT; C;
{
 *  GXApplyFontEncoding()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXApplyFontEncoding(fontID: gxFont; index: LONGINT; VAR length: LONGINT; {CONST}VAR text: UInt8; count: LONGINT; VAR glyphs: UInt16; VAR was16Bit: CHAR): LONGINT; C;
{
 *  GXCountFontVariations()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCountFontVariations(fontID: gxFont): LONGINT; C;
{
 *  GXFindFontVariation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXFindFontVariation(fontID: gxFont; variationTag: gxFontVariationTag; VAR minValue: Fixed; VAR defaultValue: Fixed; VAR maxValue: Fixed; VAR name: gxFontName): LONGINT; C;
{
 *  GXGetFontVariation()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetFontVariation(fontID: gxFont; index: LONGINT; VAR minValue: Fixed; VAR defaultValue: Fixed; VAR maxValue: Fixed; VAR name: gxFontName): gxFontVariationTag; C;
{
 *  GXCountFontInstances()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCountFontInstances(fontID: gxFont): LONGINT; C;
{
 *  GXGetFontInstance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetFontInstance(fontID: gxFont; index: LONGINT; VAR variation: gxFontVariation): gxFontName; C;
{
 *  GXSetFontInstance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXSetFontInstance(fontID: gxFont; index: LONGINT; name: gxFontName; {CONST}VAR variation: gxFontVariation): LONGINT; C;
{
 *  GXDeleteFontInstance()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXDeleteFontInstance(fontID: gxFont; index: LONGINT; name: gxFontName): LONGINT; C;
{
 *  GXCountFontDescriptors()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCountFontDescriptors(fontID: gxFont): LONGINT; C;
{
 *  GXGetFontDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetFontDescriptor(fontID: gxFont; index: LONGINT; VAR descriptorValue: Fixed): gxFontDescriptorTag; C;
{
 *  GXFindFontDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXFindFontDescriptor(fontID: gxFont; descriptorTag: gxFontDescriptorTag; VAR descriptorValue: Fixed): LONGINT; C;
{
 *  GXSetFontDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXSetFontDescriptor(fontID: gxFont; index: LONGINT; descriptorTag: gxFontDescriptorTag; descriptorValue: Fixed): LONGINT; C;
{
 *  GXDeleteFontDescriptor()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXDeleteFontDescriptor(fontID: gxFont; index: LONGINT; descriptorTag: gxFontDescriptorTag): LONGINT; C;
{
 *  GXCountFontFeatures()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXCountFontFeatures(fontID: gxFont): LONGINT; C;
{
 *  GXGetFontFeature()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetFontFeature(fontID: gxFont; index: LONGINT; VAR flags: gxFontFeatureFlag; VAR settingCount: LONGINT; VAR settings: gxFontFeatureSetting; VAR feature: gxFontFeature): gxFontName; C;
{
 *  GXFindFontFeature()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXFindFontFeature(fontID: gxFont; feature: gxFontFeature; VAR flags: gxFontFeatureFlag; VAR settingCount: LONGINT; VAR settings: gxFontFeatureSetting; VAR index: LONGINT): gxFontName; C;
{
 *  GXGetFontDefaultFeatures()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
FUNCTION GXGetFontDefaultFeatures(fontID: gxFont; VAR features: gxRunFeature): LONGINT; C;
{
 *  GXFlattenFont()
 *  
 *  Availability:
 *    Non-Carbon CFM:   not available
 *    CarbonLib:        not available
 *    Mac OS X:         not available
 }
PROCEDURE GXFlattenFont(source: gxFont; VAR stream: scalerStream; VAR block: gxSpoolBlock); C;

{$ENDC}  {CALL_NOT_IN_CARBON}

{$ALIGN RESET}
{$POP}

{$SETC UsingIncludes := GXFontsIncludes}

{$ENDC} {__GXFONTS__}

{$IFC NOT UsingIncludes}
 END.
{$ENDC}

/*
 	File:		GXFonts.h
 
 	Contains:	QuickDraw GX font routine interfaces.
 
 	Version:	Technology:	Quickdraw GX 1.1
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __GXFONTS__
#define __GXFONTS__


#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#ifndef __GXMATH__
#include <GXMath.h>
#endif
/*	#include <Types.h>											*/
/*	#include <FixMath.h>										*/

#ifndef __GXTYPES__
#include <GXTypes.h>
#endif
/*	#include <MixedMode.h>										*/

#ifndef __SCALERTYPES__
#include <ScalerTypes.h>
#endif
/*	#include <SFNTTypes.h>										*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#if defined(__MWERKS__) && GENERATING68K
	#pragma push
	#pragma pointers_in_D0
#endif
 
#define fontRoutinesIncludes
/* old header = font routines */
 
extern gxFont GXNewFont(gxFontStorageTag storage, gxFontStorageReference reference, gxFontAttribute attributes)
 THREEWORDINLINE(0x303C, 0x201, 0xA832);
extern gxFontStorageTag GXGetFont(gxFont fontID, gxFontStorageReference *reference, gxFontAttribute *attributes)
 THREEWORDINLINE(0x303C, 0x202, 0xA832);
extern gxFont GXFindFont(gxFontStorageTag storage, gxFontStorageReference reference, gxFontAttribute *attributes)
 THREEWORDINLINE(0x303C, 0x203, 0xA832);
extern void GXSetFont(gxFont fontID, gxFontStorageTag storage, gxFontStorageReference reference, gxFontAttribute attributes)
 THREEWORDINLINE(0x303C, 0x204, 0xA832);
extern void GXDisposeFont(gxFont fontID)
 THREEWORDINLINE(0x303C, 0x205, 0xA832);
extern void GXChangedFont(gxFont fontID)
 THREEWORDINLINE(0x303C, 0x206, 0xA832);
extern gxFontFormatTag GXGetFontFormat(gxFont fontID)
 THREEWORDINLINE(0x303C, 0x207, 0xA832);
extern gxFont GXGetDefaultFont(void)
 THREEWORDINLINE(0x303C, 0x208, 0xA832);
extern gxFont GXSetDefaultFont(gxFont fontID)
 THREEWORDINLINE(0x303C, 0x209, 0xA832);
extern long GXFindFonts(gxFont familyID, gxFontName name, gxFontPlatform platform, gxFontScript script, gxFontLanguage language, long length, const unsigned char text[], long index, long count, gxFont fonts[])
 THREEWORDINLINE(0x303C, 0x20a, 0xA832);
extern long GXCountFontGlyphs(gxFont fontID)
 THREEWORDINLINE(0x303C, 0x20b, 0xA832);
extern long GXCountFontTables(gxFont fontID)
 THREEWORDINLINE(0x303C, 0x20c, 0xA832);
extern long GXGetFontTable(gxFont fontID, long index, void *tableData, gxFontTableTag *tableTag)
 THREEWORDINLINE(0x303C, 0x20d, 0xA832);
extern long GXFindFontTable(gxFont fontID, gxFontTableTag tableTag, void *tableData, long *index)
 THREEWORDINLINE(0x303C, 0x20e, 0xA832);
extern long GXGetFontTableParts(gxFont fontID, long index, long offset, long length, void *tableData, gxFontTableTag *tableTag)
 THREEWORDINLINE(0x303C, 0x20f, 0xA832);
extern long GXFindFontTableParts(gxFont fontID, gxFontTableTag tableTag, long offset, long length, void *tableData, long *index)
 THREEWORDINLINE(0x303C, 0x210, 0xA832);
extern long GXSetFontTable(gxFont fontID, long index, gxFontTableTag tableTag, long length, const void *tableData)
 THREEWORDINLINE(0x303C, 0x211, 0xA832);
extern long GXSetFontTableParts(gxFont fontID, long index, gxFontTableTag tableTag, long offset, long oldLength, long newLength, const void *tableData)
 THREEWORDINLINE(0x303C, 0x212, 0xA832);
extern long GXDeleteFontTable(gxFont fontID, long index, gxFontTableTag tableTag)
 THREEWORDINLINE(0x303C, 0x213, 0xA832);
extern long GXCountFontNames(gxFont fontID)
 THREEWORDINLINE(0x303C, 0x214, 0xA832);
extern long GXGetFontName(gxFont fontID, long index, gxFontName *name, gxFontPlatform *platform, gxFontScript *script, gxFontLanguage *language, unsigned char text[])
 THREEWORDINLINE(0x303C, 0x215, 0xA832);
extern long GXFindFontName(gxFont fontID, gxFontName name, gxFontPlatform platform, gxFontScript script, gxFontLanguage language, unsigned char text[], long *index)
 THREEWORDINLINE(0x303C, 0x216, 0xA832);
extern long GXSetFontName(gxFont fontID, gxFontName name, gxFontPlatform platform, gxFontScript script, gxFontLanguage language, long length, const unsigned char text[])
 THREEWORDINLINE(0x303C, 0x217, 0xA832);
extern long GXDeleteFontName(gxFont fontID, long index, gxFontName name, gxFontPlatform platform, gxFontScript script, gxFontLanguage language)
 THREEWORDINLINE(0x303C, 0x218, 0xA832);
extern gxFontName GXNewFontNameID(gxFont fontID)
 THREEWORDINLINE(0x303C, 0x219, 0xA832);
extern long GXCountFontEncodings(gxFont fontID)
 THREEWORDINLINE(0x303C, 0x21a, 0xA832);
extern gxFontPlatform GXGetFontEncoding(gxFont fontID, long index, gxFontScript *script, gxFontLanguage *language)
 THREEWORDINLINE(0x303C, 0x21b, 0xA832);
extern long GXFindFontEncoding(gxFont fontID, gxFontPlatform platform, gxFontScript script, gxFontLanguage language)
 THREEWORDINLINE(0x303C, 0x21c, 0xA832);
extern long GXApplyFontEncoding(gxFont fontID, long index, long *length, const unsigned char text[], long count, unsigned short glyphs[], char was16Bit[])
 THREEWORDINLINE(0x303C, 0x21d, 0xA832);
extern long GXCountFontVariations(gxFont fontID)
 THREEWORDINLINE(0x303C, 0x21e, 0xA832);
extern long GXFindFontVariation(gxFont fontID, gxFontVariationTag variationTag, Fixed *minValue, Fixed *defaultValue, Fixed *maxValue, gxFontName *name)
 THREEWORDINLINE(0x303C, 0x21f, 0xA832);
extern gxFontVariationTag GXGetFontVariation(gxFont fontID, long index, Fixed *minValue, Fixed *defaultValue, Fixed *maxValue, gxFontName *name)
 THREEWORDINLINE(0x303C, 0x220, 0xA832);
extern long GXCountFontInstances(gxFont fontID)
 THREEWORDINLINE(0x303C, 0x221, 0xA832);
extern gxFontName GXGetFontInstance(gxFont fontID, long index, gxFontVariation variation[])
 THREEWORDINLINE(0x303C, 0x222, 0xA832);
extern long GXSetFontInstance(gxFont fontID, long index, gxFontName name, const gxFontVariation variation[])
 THREEWORDINLINE(0x303C, 0x223, 0xA832);
extern long GXDeleteFontInstance(gxFont fontID, long index, gxFontName name)
 THREEWORDINLINE(0x303C, 0x224, 0xA832);
extern long GXCountFontDescriptors(gxFont fontID)
 THREEWORDINLINE(0x303C, 0x225, 0xA832);
extern gxFontDescriptorTag GXGetFontDescriptor(gxFont fontID, long index, Fixed *descriptorValue)
 THREEWORDINLINE(0x303C, 0x226, 0xA832);
extern long GXFindFontDescriptor(gxFont fontID, gxFontDescriptorTag descriptorTag, Fixed *descriptorValue)
 THREEWORDINLINE(0x303C, 0x227, 0xA832);
extern long GXSetFontDescriptor(gxFont fontID, long index, gxFontDescriptorTag descriptorTag, Fixed descriptorValue)
 THREEWORDINLINE(0x303C, 0x228, 0xA832);
extern long GXDeleteFontDescriptor(gxFont fontID, long index, gxFontDescriptorTag descriptorTag)
 THREEWORDINLINE(0x303C, 0x229, 0xA832);
extern long GXCountFontFeatures(gxFont fontID)
 THREEWORDINLINE(0x303C, 0x22a, 0xA832);
extern gxFontName GXGetFontFeature(gxFont fontID, long index, gxFontFeatureFlag *flags, long *settingCount, gxFontFeatureSetting settings[], gxFontFeature *feature)
 THREEWORDINLINE(0x303C, 0x22b, 0xA832);
extern gxFontName GXFindFontFeature(gxFont fontID, gxFontFeature feature, gxFontFeatureFlag *flags, long *settingCount, gxFontFeatureSetting settings[], long *index)
 THREEWORDINLINE(0x303C, 0x22c, 0xA832);
extern long GXGetFontDefaultFeatures(gxFont fontID, gxRunFeature features[])
 THREEWORDINLINE(0x303C, 0x274, 0xA832);
extern void GXFlattenFont(gxFont source, scalerStream *stream, gxSpoolBlock *block)
 THREEWORDINLINE(0x303C, 0x22d, 0xA832);
 
#if defined(__MWERKS__) && GENERATING68K
	#pragma pop
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __GXFONTS__ */

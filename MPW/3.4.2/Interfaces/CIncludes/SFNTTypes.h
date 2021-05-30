/*
 	File:		SFNTTypes.h
 
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
 
*/

#ifndef __SFNTTYPES__
#define __SFNTTYPES__


#ifndef __GXMATH__
#include <GXMath.h>
#endif
/*	#include <ConditionalMacros.h>								*/
/*	#include <Types.h>											*/
/*	#include <FixMath.h>										*/

#ifndef __GXTYPES__
#include <GXTypes.h>
#endif
/*	#include <MixedMode.h>										*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

 
#define sfntTypesIncludes
 
/* old header = sfnt types */
 
struct sfntDirectoryEntry {
	gxFontTableTag					tableTag;
	unsigned long					checkSum;
	unsigned long					offset;
	unsigned long					length;
};
typedef struct sfntDirectory sfntDirectory;

/* The search fields limits numOffsets to 4096. */
struct sfntDirectory {
	gxFontFormatTag					format;
	unsigned short					numOffsets;					/* number of tables */
	unsigned short					searchRange;				/* (max2 <= numOffsets)*16 */
	unsigned short					entrySelector;				/* log2(max2 <= numOffsets) */
	unsigned short					rangeShift;					/* numOffsets*16-searchRange*/
	struct sfntDirectoryEntry		table[1];					/* table[numOffsets] */
};
typedef struct sfntDirectoryEntry sfntDirectoryEntry;


enum {
	sizeof_sfntDirectory		= 12
};

/* Cmap - character id to glyph id gxMapping */
enum {
	cmapFontTableTag			= 'cmap'
};

struct sfntCMapSubHeader {
	unsigned short					format;
	unsigned short					length;
	unsigned short					languageID;					/* base-1 */
};
typedef struct sfntCMapSubHeader sfntCMapSubHeader;


enum {
	sizeof_sfntCMapSubHeader	= 6
};

struct sfntCMapEncoding {
	unsigned short					platformID;					/* base-0 */
	unsigned short					scriptID;					/* base-0 */
	unsigned long					offset;
};
typedef struct sfntCMapEncoding sfntCMapEncoding;


enum {
	sizeof_sfntCMapEncoding		= 8
};

struct sfntCMapHeader {
	unsigned short					version;
	unsigned short					numTables;
	struct sfntCMapEncoding			encoding[1];
};
typedef struct sfntCMapHeader sfntCMapHeader;


enum {
	sizeof_sfntCMapHeader		= 4
};

/* Name table */
enum {
	nameFontTableTag			= 'name'
};

struct sfntNameRecord {
	unsigned short					platformID;					/* base-0 */
	unsigned short					scriptID;					/* base-0 */
	unsigned short					languageID;					/* base-0 */
	unsigned short					nameID;						/* base-0 */
	unsigned short					length;
	unsigned short					offset;
};
typedef struct sfntNameRecord sfntNameRecord;


enum {
	sizeof_sfntNameRecord		= 12
};

struct sfntNameHeader {
	unsigned short					format;
	unsigned short					count;
	unsigned short					stringOffset;
	sfntNameRecord					rec[1];
};
typedef struct sfntNameHeader sfntNameHeader;


enum {
	sizeof_sfntNameHeader		= 6
};

/* Fvar table - gxFont variations */
enum {
	variationFontTableTag		= 'fvar'
};

/* These define each gxFont variation */
struct sfntVariationAxis {
	gxFontVariationTag				axisTag;
	Fixed							minValue;
	Fixed							defaultValue;
	Fixed							maxValue;
	short							flags;
	short							nameID;
};
typedef struct sfntVariationAxis sfntVariationAxis;


enum {
	sizeof_sfntVariationAxis	= 20
};

/* These are named locations in gxStyle-space for the user */
struct sfntInstance {
	short							nameID;
	short							flags;
	Fixed							coord[1];					/* [axisCount] */
/* room to grow since the header carries a tupleSize field */
};
typedef struct sfntInstance sfntInstance;


enum {
	sizeof_sfntInstance			= 4
};

struct sfntVariationHeader {
	Fixed							version;					/* 1.0 Fixed */
	unsigned short					offsetToData;				/* to first axis = 16*/
	unsigned short					countSizePairs;				/* axis+inst = 2 */
	unsigned short					axisCount;
	unsigned short					axisSize;
	unsigned short					instanceCount;
	unsigned short					instanceSize;
/* …other <count,size> pairs */
	struct sfntVariationAxis		axis[1];					/* [axisCount] */
	struct sfntInstance				instance[1];				/* [instanceCount]  …other arrays of data */
};
typedef struct sfntVariationHeader sfntVariationHeader;


enum {
	sizeof_sfntVariationHeader	= 16
};

/* Fdsc table - gxFont descriptor */
enum {
	descriptorFontTableTag		= 'fdsc'
};

struct sfntDescriptorHeader {
	Fixed							version;					/* 1.0 in Fixed */
	long							descriptorCount;
	gxFontDescriptor				descriptor[1];
};
typedef struct sfntDescriptorHeader sfntDescriptorHeader;


enum {
	sizeof_sfntDescriptorHeader	= 8
};

/* Feat Table - layout feature table */
enum {
	featureFontTableTag			= 'feat'
};

struct sfntFeatureName {
	unsigned short					featureType;
	unsigned short					settingCount;
	long							offsetToSettings;
	unsigned short					featureFlags;
	unsigned short					nameID;
};
typedef struct sfntFeatureName sfntFeatureName;

struct sfntFontRunFeature {
	unsigned short					featureType;
	unsigned short					setting;
};
struct sfntFeatureHeader {
	long							version;					/* 1.0 */
	unsigned short					featureNameCount;
	unsigned short					featureSetCount;
	long							reserved;					/* set to 0 */
	struct sfntFeatureName			names[1];
	struct gxFontFeatureSetting		settings[1];
	struct sfntFontRunFeature		runs[1];
};
typedef struct sfntFeatureHeader sfntFeatureHeader;

/* OS/2 Table */

enum {
	os2FontTableTag				= 'OS/2'
};

/*  Special invalid glyph ID value, useful as a sentinel value, for example */
enum {
	nonGlyphID					= 65535
};


#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __SFNTTYPES__ */

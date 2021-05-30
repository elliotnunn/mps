/*
 	File:		WorldScript.h
 
 	Contains:	WorldScript I Interfaces.
 
 	Version:	Technology:	System 7.5
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __WORLDSCRIPT__
#define __WORLDSCRIPT__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __TRAPS__
#include <Traps.h>
#endif

#ifndef __QUICKDRAWTEXT__
#include <QuickdrawText.h>
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

typedef UInt16 WSIOffset;

typedef UInt8 WSIByteCount;

typedef UInt8 WSIByteIndex;

/* offset from start of sub-table to row in state table */
typedef UInt16 WSIStateOffset;

typedef UInt32 WSITableOffset;

typedef UInt16 WSISubtableOffset;

typedef UInt16 WSIGlyphcode;

typedef UInt32 WSITableIdentifiers;


enum {
	kScriptSettingsTag			= 'info',
	kMetamorphosisTag			= 'mort',
	kGlyphExpansionTag			= 'g2g#',
	kPropertiesTag				= 'prop',
	kJustificationTag			= 'kash',
	kCharToGlyphTag				= 'cmap',
	kGlyphToCharTag				= 'pamc',
	kFindScriptRunTag			= 'fstb'
};

/**** 			L O O K U P    T A B L E    T Y P E S		****/
enum {
	WSILookupSimpleArray		= 0,							/* a simple array indexed by glyph code */
	WSILookupSegmentSingle		= 2,							/* segment mapping to single value */
	WSILookupSegmentArray		= 4,							/* segment mapping to lookup array */
	WSILookupSingleTable		= 6,							/* sorted list of glyph, value pairs */
	WSILookupTrimmedArray		= 8								/* a simple trimmed array indexed by glyph code */
};

typedef unsigned short WSILookupTableFormat;

typedef unsigned short WSILookupValue;

/* An offset from the beginning of the lookup table */
typedef unsigned short WSILookupOffset;

/*	FORMAT SPECIFIC DEFINITIONS */
/*
		lookupSimpleArray:
		
		This is a simple array which maps all glyphs in the font
		to lookup values.
	*/
struct WSILookupArrayHeader {
	WSILookupValue					lookupValues[1];			/* The array of values indexed by glyph code */
};
typedef struct WSILookupArrayHeader WSILookupArrayHeader;

/*
		lookupTrimmedArray:
		
		This is a single trimmed array which maps a single range
		of glyhs in the font to lookup values.
	*/
struct WSILookupTrimmedArrayHeader {
	WSIGlyphcode					firstGlyph;
	WSIGlyphcode					limitGlyph;
	WSILookupValue					valueArray[1];
};
typedef struct WSILookupTrimmedArrayHeader WSILookupTrimmedArrayHeader;

/* The format specific part of the subtable header */
union WSILookupFormatSpecificHeader {
	WSILookupArrayHeader			lookupArray;
	WSILookupTrimmedArrayHeader		trimmedArray;
};
typedef union WSILookupFormatSpecificHeader WSILookupFormatSpecificHeader;

/* The overall subtable header */
struct WSILookupTableHeader {
	WSILookupTableFormat			format;						/* table format */
	WSILookupFormatSpecificHeader	fsHeader;					/* format specific header */
};
typedef struct WSILookupTableHeader WSILookupTableHeader;

/****		G L Y P H    E X P A N S I O N    ****/

enum {
/* fixed 1.0 */
	kCurrentGlyphExpansionVersion = 0x00010000
};

typedef unsigned short GlyphExpansionFormats;


enum {
	GlyphExpansionLookupFormat	= 1,
	GlyphExpansionContextualFormat = 2
};

struct ExpandedGlyphCluster {
	WSIByteCount					numGlyphs;
	WSIByteIndex					bestGlyph;
	WSIGlyphcode					glyphs[1];
};
typedef struct ExpandedGlyphCluster ExpandedGlyphCluster;

struct ExpandedGlyphOffset {
	WSIGlyphcode					glyph;
	WSIOffset						offset;						/* offset to ExpandedGlyphCluster */
};
typedef struct ExpandedGlyphOffset ExpandedGlyphOffset;

struct GlyphExpansionTable {
	Fixed							version;
	short							format;
	short							expansionNumer;
	short							expansionDenom;				/* num/denom ratio for expansion <2> */
	union {
		struct GlyphExpansionStateTable {
			WSISubtableOffset				stateTableOffset;
			WSISubtableOffset				classTableOffset;
			WSISubtableOffset				actionTableOffset;	/* state, class and actions tables follow here... */
		}								stateTable;
		WSILookupTableHeader			lookup;					/* expanded glyph clusters follow here... */
	}								table;
};
typedef struct GlyphExpansionTable GlyphExpansionTable;

/* Glyph-to-Character constants and types  */

enum {
	kCurrentGlyphToCharVersion	= (Fixed)0x00010100
};

typedef unsigned short GlyphToCharLookupFormats;


enum {
	kGlyphToCharLookup8Format	= 1,
	kGlyphToCharLookup16Format	= 2,
	kGlyphToCharLookup32Format	= 3
};

typedef UInt8 GlyphToCharFontIndex;

typedef UInt8 QDGlyphcode;

struct GlyphToCharActionTable {
	WSISubtableOffset				fontNameOffset;				/* offset relative to this table */
	WSILookupTableHeader			actions;					/* only support lookupSimpleArray format for now */
};
typedef struct GlyphToCharActionTable GlyphToCharActionTable;

struct GlyphToCharActionHeader {
	short							numTables;					/* 0..n */
	WSISubtableOffset				offsets[1];					/* offsets from start of action table header */
};
typedef struct GlyphToCharActionHeader GlyphToCharActionHeader;

struct GlyphToCharHeader {
	Fixed							version;
	WSISubtableOffset				actionOffset;				/* offset to GlyphToCharActionHeader */
	short							format;						/* size of font mask */
	WSILookupTableHeader			mappingTable;
};
typedef struct GlyphToCharHeader GlyphToCharHeader;

/* JUSTIFICATION TYPES
	WorldScript supports justification of text using insertion. The justification
	table specifies a insertion string to insert between 2 specified glyphs.
	Each combination of inter-glyph boundary can be assigned a justification priority,
	the higher the priority the more justification strings inserted at that position.
	
	The priorities for each inter-glyph boundary are specified by the justification table's
	state table.
	
	Special handling is done for scripts which use spaces to justify, because the width of 
	a space varies depending on the setting of SpaceExtra. This is why the number of spaces
	per inserting string is specified in the justification table.

*/

enum {
/* 1.0 not supported */
	kCurrentJustificationVersion = 0x0200
};

enum {
	kJustificationStateTableFormat = 1
};

enum {
/* WSI's internal limitation <12> */
	kMaxJustificationStringLength = 13
};

typedef UInt8 WSIJustificationPriority;


enum {
	WSIJustificationSetMarkMask	= 0x80
};

struct WSIJustificationStateEntry {
	WSIJustificationPriority		markPriority;				/* non-zero priorities means insertion */
	WSIJustificationPriority		priority;
	WSIStateOffset					newState;
};
typedef struct WSIJustificationStateEntry WSIJustificationStateEntry;

typedef unsigned short WSIJustificationClasses;


enum {
	wsiJustEndOfLineClass		= 0,
	wsiJustEndOfRunClass		= 1,
	wsiJustDeletedGlyphClass	= 2,
	wsiJustUserDefinedClass		= 3
};

typedef unsigned short WSIJustificationStates;


enum {
	wsiStartOfLineState			= 0,							/* pre-defined states */
	wsiStartOfRunState			= 1,
	wsiUserDefinedState			= 2
};

/* pre-multiplied: class# * sizeof(WSIJustificationStateEntry) */
typedef UInt8 WSIJustificationClassOffset;

struct WSIJustificationStateTable {
	short							maxPriorities;
	unsigned short					rowWidth;					/* width of a state table row in bytes */
	short							classTableOffset;
	short							stateTableOffset;
};
typedef struct WSIJustificationStateTable WSIJustificationStateTable;

struct WSIJustificationHeader {
	short							version;
	short							format;
	Point							scaling;					/* numer/denom scaling of priority weights <7> */
	unsigned short					spacesPerInsertion;			/* # of $20 chars in justification insertion string <12> */
	unsigned short					justStringOffset;			/* offset to justification string */
	WSIJustificationStateTable		stateTable;					/* long-aligned boundary aligned w/ spacesPerInsertion field - justification string follows */
};
typedef struct WSIJustificationHeader WSIJustificationHeader;

/* Line Layout's Property table version <11> */

enum {
/* v1.0 */
	currentPropsTableVersion	= 0x00010000
};

enum {
/* ??? is this right */
	kCharToGlyphCurrentVersion	= 0100
};

/* pass as priorityWeight to JustifyWSILayout to use script's current just setting */
enum {
	kScriptsDefaultJustWeight	= -1
};

struct WSIGlyphInfoRec {
	UInt8							qdChar;
	SInt8							rightToLeft;				/* !0 means rightToLeft, 0 means leftToRight */
	short							fontID;
	short							originalOffset;				/* or negative original offset if not in original text input */
	unsigned short					unused;						/* long-align */
};
typedef struct WSIGlyphInfoRec WSIGlyphInfoRec, **WSIGlyphInfoHandle;

typedef Handle WSILayoutHandle;

extern pascal WSILayoutHandle NewWSILayout(WSILayoutHandle layoutH, Ptr text, short txLength, short lineDirection, unsigned long flags, OSErr *err)
 FOURWORDINLINE(0x2F3C, 0X8414, 0x0040, 0xA8B5);
extern pascal WSILayoutHandle JustifyWSILayout(WSILayoutHandle layoutH, Fixed slop, short priorityWeight, JustStyleCode styleRunPosition, Point numer, Point denom, OSErr *err)
 FOURWORDINLINE(0x2F3C, 0x8418, 0x0042, 0xA8B5);
extern pascal Fixed MeasureWSILayout(WSILayoutHandle layoutH, Point numer, Point denom)
 FOURWORDINLINE(0x2F3C, 0x840C, 0x0044, 0xA8B5);
extern pascal void DrawWSILayout(WSILayoutHandle layoutH, Point numer, Point denom)
 FOURWORDINLINE(0x2F3C, 0x800C, 0x0046, 0xA8B5);
/* "low-level" routines */
extern pascal WSIGlyphInfoHandle GetWSILayoutParts(WSILayoutHandle layoutH, WSIGlyphInfoHandle destH, short *numGlyphs, OSErr *err)
 FOURWORDINLINE(0x2F3C, 0x8410, 0x0048, 0xA8B5);
extern pascal void DrawWSIGlyphs(short length, Ptr qdCodes, Point numer, Point denom)
 FOURWORDINLINE(0x2F3C, 0x800E, 0x004A, 0xA8B5);
extern pascal Fixed xMeasureWSIGlyphs(Ptr *qdCodes, short length, Point numer, Point denom)
 FOURWORDINLINE(0x2F3C, 0x840E, 0x004C, 0xA8B5);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __WORLDSCRIPT__ */

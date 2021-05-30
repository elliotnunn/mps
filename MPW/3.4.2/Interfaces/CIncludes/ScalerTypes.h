/*
 	File:		ScalerTypes.h
 
 	Contains:	Apple public font scaler object and constant definitions
 
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

#ifndef __SCALERTYPES__
#define __SCALERTYPES__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __MIXEDMODE__
#include <MixedMode.h>
#endif

#ifndef __GXMATH__
#include <GXMath.h>
#endif
/*	#include <FixMath.h>										*/

#ifndef __SFNTTYPES__
#include <SFNTTypes.h>
#endif
/*	#include <GXTypes.h>										*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

#define scalerTypeIncludes
/* old header = scaler types */
 

enum {
	truetypeFontFormatTag		= 'true',
	type1FontFormatTag			= 'typ1',
	nfntFontFormatTag			= 'nfnt'
};

enum {
	scaler_first_error			= 1,
	scaler_first_warning		= 1024
};

enum {
	kOFAVersion1Dot0			= 0x10000,
	kOFAVersion1Dot1			= 0x10100						/* added scalerVariationInfo */
};

enum scalerErrors {
	scaler_no_problem			= 0,							/* Everything went OK */
	scaler_null_context			= scaler_first_error,			/* Client passed a null context pointer */
	scaler_null_input			= scaler_first_error + 1,		/* Client passed a null input pointer */
	scaler_invalid_context		= scaler_first_error + 2,		/* There was a problem with the context */
	scaler_invalid_input		= scaler_first_error + 3,		/* There was a problem with an input */
	scaler_invalid_font_data	= scaler_first_error + 4,		/* A portion of the font was corrupt */
	scaler_new_block_failed		= scaler_first_error + 5,		/* A call to NewBlock() failed */
	scaler_get_font_table_failed = scaler_first_error + 6,		/* The table was present (length > 0) but couldn't be read */
	scaler_bitmap_alloc_failed	= scaler_first_error + 7,		/* Call to allocate bitmap permanent block failed */
	scaler_outline_alloc_failed	= scaler_first_error + 8,		/* Call to allocate outline permanent block failed */
	scaler_required_table_missing = scaler_first_error + 9,		/* A needed font table was not found */
	scaler_unsupported_outline_format = scaler_first_error + 10, /* Couldn't create an outline of the desired format */
	scaler_unsupported_stream_format = scaler_first_error + 11,	/* ScalerStreamFont() call can't supply any requested format */
	scaler_unsupported_font_format = scaler_first_error + 12,	/* No scaler supports the font format */
	scaler_hinting_error		= scaler_first_error + 13,		/* An error occurred during hinting */
	scaler_scan_error			= scaler_first_error + 14,		/* An error occurred in scan conversion */
	scaler_internal_error		= scaler_first_error + 15,		/* Scaler has a bug */
	scaler_invalid_matrix		= scaler_first_error + 16,		/* The transform matrix was unusable */
	scaler_fixed_overflow		= scaler_first_error + 17,		/* An overflow ocurred during matrix operations */
	scaler_API_version_mismatch	= scaler_first_error + 18,		/* Scaler requires a newer/older version of the scaler API */
	scaler_streaming_aborted	= scaler_first_error + 19,		/* StreamFunction callback indicated that streaming should cease */
	scaler_last_error			= scaler_streaming_aborted,
	scaler_no_output			= scaler_first_warning,			/* Couldn't fulfill any glyph request. */
	scaler_fake_metrics			= scaler_first_warning,			/* Returned metrics aren't based on information in the font */
	scaler_fake_linespacing		= scaler_first_warning,			/* Linespacing metrics not based on information in the font */
	scaler_glyph_substitution	= scaler_first_warning,			/* Requested glyph out of range, a substitute was used */
	scaler_last_warning			= scaler_glyph_substitution
};

typedef long scalerError;

/* ScalerOpen output type */
struct scalerInfo {
	gxFontFormatTag					format;						/* Font format supported by this scaler */
	Fixed							scalerVersion;				/* Version number of the scaler */
	Fixed							APIVersion;					/* Version of API implemented (compare with version in scalerContext) */
};
typedef struct scalerInfo scalerInfo;

/* ScalerNewFont output type */

enum scalerFontFlags {
	requiresLayoutFont			= 1,
	hasNormalLayoutFont			= 2,
	canReorderFont				= 4,
	canRearrangeFont			= 8,
	hasOutlinesFont				= 16
};

typedef long scalerFontFlag;

struct scalerFontInfo {
	unsigned long					unitsPerEm;
	scalerFontFlag					flags;
	unsigned long					numGlyphs;
};
typedef struct scalerFontInfo scalerFontInfo;

/* ScalerNewTransform input types */
/* ScalerNewVariation1Dot1 output type */
struct scalerFixedRectangle {
	Fixed							left;
	Fixed							top;
	Fixed							right;
	Fixed							bottom;
};
typedef struct scalerFixedRectangle scalerFixedRectangle;

struct scalerVariationInfo {
	scalerFixedRectangle			bounds;
};
typedef struct scalerVariationInfo scalerVariationInfo;

/* ScalerNewTransform input types */

enum scalerTransformFlags {
	applyHintsTransform			= 1,							/* Execute hinting instructions (grid fit) */
	exactBitmapTransform		= 2,							/* Use embedded gxBitmap iff exact size */
	useThresholdTransform		= 4,							/* Use scaled gxBitmap (if any) if below outline threshold */
	verticalTransform			= 8,							/* Glyphs will be in vertical orientation */
	deviceMetricsTransform		= 16,							/* All metrics should be device (vs. fractional) */
	allScalerTransformFlags		= applyHintsTransform | exactBitmapTransform | useThresholdTransform | verticalTransform | deviceMetricsTransform
};

typedef long scalerTransformFlag;

struct scalerTransform {
	scalerTransformFlag				flags;						/* Hint, embedded gxBitmap control, etc. */
	Fixed							pointSize;					/* The desired pointsize */
	const gxMapping					*fontMatrix;				/* The 3x3 matrix to apply to glyphs */
	gxPoint							resolution;					/* 2D device resolution */
	gxPoint							spotSize;					/* 2D pixel size */
};
typedef struct scalerTransform scalerTransform;

/* ScalerNewTransform output type */
struct scalerTransformInfo {
	gxPoint							before;						/* Spacing of the line before */
	gxPoint							after;						/* Spacing of the line after */
	gxPoint							caretAngle;					/* Rise (y) and run (x) of the insertion caret */
	gxPoint							caretOffset;				/* Adjustment to caret for variants like italic */
};
typedef struct scalerTransformInfo scalerTransformInfo;

/* ScalerNewGlyph input types */

enum scalerGlyphFlags {
	noImageGlyph				= 1								/* Don't return the bitmap image for this glyph */
};

typedef long scalerGlyphFlag;

/* QuickDraw GX outline */

enum {
	pathOutlineFormat			= 'path'
};

typedef long scalerOutlineFormat;

struct scalerGlyph {
	long							glyphIndex;					/* Index of the glyph to be considered */
	long							bandingTop;					/* Banding controls (scanline numbers) top=bottom=0 means no banding */
	long							bandingBottom;
	scalerOutlineFormat				format;						/* Format of outline to return, ignored if no outline desired */
	scalerGlyphFlag					flags;						/* Control generation of image representation */
};
typedef struct scalerGlyph scalerGlyph;

/* ScalerNewGlyph output types */
struct scalerMetrics {
	gxPoint							advance;
	gxPoint							sideBearing;
	gxPoint							otherSideBearing;
};
typedef struct scalerMetrics scalerMetrics;

struct scalerRectangle {
	long							xMin;
	long							yMin;
	long							xMax;
	long							yMax;
};
typedef struct scalerRectangle scalerRectangle;

/* ScalerKernGlyphs input/output types */

enum scalerKerningFlags {
	lineStartKerning			= 1,							/* Array of glyphs starts a line */
	lineEndKerning				= 2,							/* Array of glyphs ends a line */
	noCrossKerning				= 4,							/* Prohibit cross kerning */
	allScalerKerningFlags		= lineStartKerning | lineEndKerning | noCrossKerning
};

typedef long scalerKerningFlag;


enum scalerKerningNotes {
	noStakeKerningNote			= 1,							/* Indicates a glyph was involver in a kerning pair/group */
	crossStreamResetKerningNote	= 2								/* Indicates a return-to-baseline in cross-stream kerning */
};

typedef unsigned short scalerKerningNote;


enum scalerKerningOutputs {
	noKerningAppliedOutput		= 0x0001						/* All kerning values were zero, kerning call had no effect */
};

/* These are bit-fields */
typedef long scalerKerningOutput;

typedef struct scalerKerning scalerKerning;

struct scalerKerning {
	long							numGlyphs;					/* Number of glyphs in the glyphs array */
	Fract							scaleFactor;				/* Amount of kerning to apply (0 == none, fract1 == all) */
	scalerKerningFlag				flags;						/* Various control flags */
	const unsigned short			*glyphs;					/* Pointer to the array of glyphs to be kerned */
	scalerKerningOutput				info;						/* Qualitative results of kerning */
};
/* ScalerStream input/output types */

enum scalerStreamTypeFlags {
	cexec68K					= 0x0001,
	truetypeStreamType			= 0x0001,
	type1StreamType				= 0x0002,
	type3StreamType				= 0x0004,
	type42StreamType			= 0x0008,
	type42GXStreamType			= 0x0010,
	portableStreamType			= 0x0020,
	flattenedStreamType			= 0x0040,
	evenOddModifierStreamType	= 0x8000
};

/* Possible streamed font formats */
typedef unsigned long scalerStreamTypeFlag;


enum scalerStreamActions {
	downloadStreamAction		= 0,							/* Transmit the (possibly sparse) font data */
	asciiDownloadStreamAction	= 1,							/* Transmit font data to a 7-bit ASCII destination */
	fontSizeQueryStreamAction	= 2,							/* Estimate in-printer memory used if the font were downloaded */
	encodingOnlyStreamAction	= 3,							/* Transmit only the encoding for the font */
	prerequisiteQueryStreamAction = 4,							/* Return a list of prerequisite items needed for the font */
	prerequisiteItemStreamAction = 5,							/* Transmit a specified prerequisite item */
	variationQueryStreamAction	= 6,							/* Return information regarding support for variation streaming */
	variationPSOperatorStreamAction = 7							/* Transmit Postscript code necessary to effect variation of a font */
};

typedef long scalerStreamAction;


enum {
	selectAllVariations			= -1							/* Special variationCount value meaning include all variation data */
};

struct scalerPrerequisiteItem {
	long							enumeration;				/* Shorthand tag identifying the item */
	long							size;						/* Worst case vm in printer item requires */
	unsigned char					name[1];					/* Name to be used by the client when emitting the item (Pascal string) */
};
typedef struct scalerPrerequisiteItem scalerPrerequisiteItem;

struct scalerStream {
	const void						*streamRefCon;				/* <-	private reference for client */
	const char						*targetVersion;				/* <-	e.g. Postscript printer name (C string) */
	scalerStreamTypeFlag			types;						/* <->	Data stream formats desired/supplied */
	scalerStreamAction				action;						/* <- 	What action to take */
	unsigned long					memorySize;					/* ->	Worst case memory use (vm) in printer or as sfnt */
	long							variationCount;				/* <-	The number of variations, or selectAllVariations */
	const struct gxFontVariation	*variations;				/* <-	A pointer to an array of the variations */
	union {
		struct {
			const unsigned short			*encoding;			/* <-	Intention is * unsigned short[256] */
			long							*glyphBits;			/* <->	Bitvector: a bit for each glyph, 1 = desired/supplied */
			char							*name;				/* <->	The printer font name to use/used (C string) */
		}								font;					/* Normal font streaming information */
		struct {
			long							size;				/* -> 	Size of the prereq. list in bytes (0 indicates no prerequisites)*/
			void							*list;				/* <-	Pointer to client block to hold list (nil = list size query only) */
		}								prerequisiteQuery;		/* Used to obtain a list of prerequisites from the scaler */
		long							prerequisiteItem;		/* <- 	Enumeration value for the prerequisite item to be streamed.*/
		long							variationQueryResult;	/* ->	Output from the variationQueryStreamAction */
	}								info;
};
typedef struct scalerStream scalerStream;

struct scalerStreamData {
	long							hexFlag;					/* Indicates that the data is to be interpreted as hex, versus binary */
	long							byteCount;					/* Number of bytes in the data being streamed */
	const void						*data;						/* Pointer to the data being streamed */
};
typedef struct scalerStreamData scalerStreamData;


enum scalerBlockTypes {
	scalerScratchBlock			= -1,							/* Scaler alloced/freed temporary memory */
	scalerOpenBlock				= 0,							/* Five permanent input/state block types */
	scalerFontBlock				= 1,
	scalerVariationBlock		= 2,
	scalerTransformBlock		= 3,
	scalerGlyphBlock			= 4,
	scalerBlockCount			= 5,							/* Number of permanent block types */
	scalerOutlineBlock			= scalerBlockCount,				/* Two output block types */
	scalerBitmapBlock			= scalerBlockCount + 1
};

typedef long scalerBlockType;

/* special tag used only by scalers to access an sfnt's directory */

enum {
	sfntDirectoryTag			= 'dir '
};

typedef struct scalerBitmap scalerBitmap;

typedef struct scalerContext scalerContext;

/* Type definitions for function pointers used with the scalerContext structure */
 
#ifdef TrueTypeCoreBuild
 
typedef long (*GetFontTableProcPtr)(scalerContext *context, gxFontTableTag tableTag, long offset, long length, void *data);
typedef void (*ReleaseFontTableProcPtr)(scalerContext *context, void* fontData);
typedef void* (*NewBlockProcPtr)(scalerContext *context, long size, scalerBlockType theType, void* oldBlock);
typedef void (*DisposeBlockProcPtr)(scalerContext *context, void* scratchData, scalerBlockType theType);
typedef long (*StreamFunctionProcPtr)(scalerContext *context, struct scalerStream* streamInfo, const struct scalerStreamData *dataInfo);
typedef void (*ScanLineFunctionProcPtr)(scalerContext *context, const struct scalerBitmap* scanLine);
typedef void (*PostErrorFunctionProcPtr)(scalerContext *context, scalerError theProblem);
typedef void (*ScalerFunctionProcPtr)(scalerContext *context, void* data);
#define	CallNewBlockProc(F,C,S,T,O)			(F)(C,S,T,O)
#define	CallDisposeBlockProc(F,C,D,T)		(F)(C,D,T)
#define CallGetFontTableProc(F,C,T,O,L,D)	(F)(C,T,O,L,D)
#define CallReleaseFontTableProc(F,C,D)		(F)(C,D)
#define CallPostErrorFunctionProc(F,C,E)	(F)(C,E)
#define CallStreamFunctionProc(F,C,S,D)		(F)(C,S,D)
#define CallScanLineFunctionProc(F,C,S)		(F)(C,S)
#define CallScalerFunctionProc(F,C,D)		(F)(C,D)
typedef GetFontTableProcPtr GetFontTableUPP;
typedef ReleaseFontTableProcPtr ReleaseFontTableUPP;
typedef NewBlockProcPtr NewBlockUPP;
typedef DisposeBlockProcPtr DisposeBlockUPP;
typedef StreamFunctionProcPtr StreamFunctionUPP;
typedef ScanLineFunctionProcPtr ScanLineFunctionUPP;
typedef PostErrorFunctionProcPtr PostErrorFunctionUPP;
typedef ScalerFunctionProcPtr ScalerFunctionUPP;
 
#else
 
typedef long (*GetFontTableProcPtr)(scalerContext *context, gxFontTableTag tableTag, long offset, long length, void *data);
typedef void (*ReleaseFontTableProcPtr)(scalerContext *context, void *fontData);
typedef void *(*NewBlockProcPtr)(scalerContext *context, long size, scalerBlockType theType, void *oldBlock);
typedef void (*DisposeBlockProcPtr)(scalerContext *context, void *scratchData, scalerBlockType theType);
typedef long (*StreamFunctionProcPtr)(scalerContext *context, struct scalerStream *streamInfo, const struct scalerStreamData *dataInfo);
typedef void (*ScanLineFunctionProcPtr)(scalerContext *context, const struct scalerBitmap *scanLine);
typedef void (*PostErrorFunctionProcPtr)(scalerContext *context, scalerError theProblem);
typedef void (*ScalerFunctionProcPtr)(scalerContext *context, void *data);

#if GENERATINGCFM
typedef UniversalProcPtr GetFontTableUPP;
typedef UniversalProcPtr ReleaseFontTableUPP;
typedef UniversalProcPtr NewBlockUPP;
typedef UniversalProcPtr DisposeBlockUPP;
typedef UniversalProcPtr StreamFunctionUPP;
typedef UniversalProcPtr ScanLineFunctionUPP;
typedef UniversalProcPtr PostErrorFunctionUPP;
typedef UniversalProcPtr ScalerFunctionUPP;
#else
typedef GetFontTableProcPtr GetFontTableUPP;
typedef ReleaseFontTableProcPtr ReleaseFontTableUPP;
typedef NewBlockProcPtr NewBlockUPP;
typedef DisposeBlockProcPtr DisposeBlockUPP;
typedef StreamFunctionProcPtr StreamFunctionUPP;
typedef ScanLineFunctionProcPtr ScanLineFunctionUPP;
typedef PostErrorFunctionProcPtr PostErrorFunctionUPP;
typedef ScalerFunctionProcPtr ScalerFunctionUPP;
#endif

 
#endif
 
struct scalerBitmap {
	char							*image;						/* Pointer to pixels */
	gxPoint							topLeft;					/* Bitmap positioning relative to client's origin */
	struct scalerRectangle			bounds;						/* Bounding box of bitmap */
	long							rowBytes;					/* Width in bytes */
};
/* scalerContext: the vehicle with which the caller and scaler communicate */
struct scalerContext {
	Fixed							version;					/* Version of the scaler API implemented by the caller */
	void							*theFont;					/* Caller's private reference to the font being processed */
	gxFontFormatTag					format;						/* Format of the sfnt font data, corresponds to the scaler */
	GetFontTableUPP					GetFontTable;				/* Callback for accessing sfnt tables or portions thereof */
	ReleaseFontTableUPP				ReleaseFontTable;			/* Callback for releasing sfnt tables */
	NewBlockUPP						NewBlock;					/* Callback for allocating and/or growing permanent and scratch blocks */
	DisposeBlockUPP					DisposeBlock;				/* Callback for freeing permanent and scratch blocks */
	StreamFunctionUPP				StreamFunction;				/* Callback for transmitting blocks of data during streaming */
	ScanLineFunctionUPP				ScanLineFunction;			/* Callback for emitting individual bitmap scanlines during scan conversion */
	PostErrorFunctionUPP			PostErrorFunction;			/* Callback for posting errors and warnings */
	void							*scalerBlocks[scalerBlockCount]; /* Array of permanent scaler blocks */
	ScalerFunctionUPP				ScalerFunction;				/* Callback for scaler-specific tracing, debugging, etc. */
};
 
#ifndef TrueTypeCoreBuild
 

#if GENERATINGCFM
#else
#endif

enum {
	uppGetFontTableProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(scalerContext*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(gxFontTableTag)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(void*))),
	uppReleaseFontTableProcInfo = kCStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(scalerContext*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*))),
	uppNewBlockProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(scalerContext*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(scalerBlockType)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(void*))),
	uppDisposeBlockProcInfo = kCStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(scalerContext*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(scalerBlockType))),
	uppStreamFunctionProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(scalerContext*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(struct scalerStream*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(struct scalerStreamData*))),
	uppScanLineFunctionProcInfo = kCStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(scalerContext*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(struct scalerBitmap*))),
	uppPostErrorFunctionProcInfo = kCStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(scalerContext*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(scalerError))),
	uppScalerFunctionProcInfo = kCStackBased
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(scalerContext*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewGetFontTableProc(userRoutine)		\
		(GetFontTableUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGetFontTableProcInfo, GetCurrentArchitecture())
#define NewReleaseFontTableProc(userRoutine)		\
		(ReleaseFontTableUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppReleaseFontTableProcInfo, GetCurrentArchitecture())
#define NewNewBlockProc(userRoutine)		\
		(NewBlockUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppNewBlockProcInfo, GetCurrentArchitecture())
#define NewDisposeBlockProc(userRoutine)		\
		(DisposeBlockUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppDisposeBlockProcInfo, GetCurrentArchitecture())
#define NewStreamFunctionProc(userRoutine)		\
		(StreamFunctionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppStreamFunctionProcInfo, GetCurrentArchitecture())
#define NewScanLineFunctionProc(userRoutine)		\
		(ScanLineFunctionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppScanLineFunctionProcInfo, GetCurrentArchitecture())
#define NewPostErrorFunctionProc(userRoutine)		\
		(PostErrorFunctionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppPostErrorFunctionProcInfo, GetCurrentArchitecture())
#define NewScalerFunctionProc(userRoutine)		\
		(ScalerFunctionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppScalerFunctionProcInfo, GetCurrentArchitecture())
#else
#define NewGetFontTableProc(userRoutine)		\
		((GetFontTableUPP) (userRoutine))
#define NewReleaseFontTableProc(userRoutine)		\
		((ReleaseFontTableUPP) (userRoutine))
#define NewNewBlockProc(userRoutine)		\
		((NewBlockUPP) (userRoutine))
#define NewDisposeBlockProc(userRoutine)		\
		((DisposeBlockUPP) (userRoutine))
#define NewStreamFunctionProc(userRoutine)		\
		((StreamFunctionUPP) (userRoutine))
#define NewScanLineFunctionProc(userRoutine)		\
		((ScanLineFunctionUPP) (userRoutine))
#define NewPostErrorFunctionProc(userRoutine)		\
		((PostErrorFunctionUPP) (userRoutine))
#define NewScalerFunctionProc(userRoutine)		\
		((ScalerFunctionUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGetFontTableProc(userRoutine, context, tableTag, offset, length, data)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGetFontTableProcInfo, (context), (tableTag), (offset), (length), (data))
#define CallReleaseFontTableProc(userRoutine, context, fontData)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppReleaseFontTableProcInfo, (context), (fontData))
#define CallNewBlockProc(userRoutine, context, size, theType, oldBlock)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppNewBlockProcInfo, (context), (size), (theType), (oldBlock))
#define CallDisposeBlockProc(userRoutine, context, scratchData, theType)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppDisposeBlockProcInfo, (context), (scratchData), (theType))
#define CallStreamFunctionProc(userRoutine, context, streamInfo, dataInfo)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppStreamFunctionProcInfo, (context), (streamInfo), (dataInfo))
#define CallScanLineFunctionProc(userRoutine, context, scanLine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppScanLineFunctionProcInfo, (context), (scanLine))
#define CallPostErrorFunctionProc(userRoutine, context, theProblem)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppPostErrorFunctionProcInfo, (context), (theProblem))
#define CallScalerFunctionProc(userRoutine, context, data)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppScalerFunctionProcInfo, (context), (data))
#else
#define CallGetFontTableProc(userRoutine, context, tableTag, offset, length, data)		\
		(*(userRoutine))((context), (tableTag), (offset), (length), (data))
#define CallReleaseFontTableProc(userRoutine, context, fontData)		\
		(*(userRoutine))((context), (fontData))
#define CallNewBlockProc(userRoutine, context, size, theType, oldBlock)		\
		(*(userRoutine))((context), (size), (theType), (oldBlock))
#define CallDisposeBlockProc(userRoutine, context, scratchData, theType)		\
		(*(userRoutine))((context), (scratchData), (theType))
#define CallStreamFunctionProc(userRoutine, context, streamInfo, dataInfo)		\
		(*(userRoutine))((context), (streamInfo), (dataInfo))
#define CallScanLineFunctionProc(userRoutine, context, scanLine)		\
		(*(userRoutine))((context), (scanLine))
#define CallPostErrorFunctionProc(userRoutine, context, theProblem)		\
		(*(userRoutine))((context), (theProblem))
#define CallScalerFunctionProc(userRoutine, context, data)		\
		(*(userRoutine))((context), (data))
#endif

 
#endif  /* not TrueTypeCoreBuild */
 

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __SCALERTYPES__ */

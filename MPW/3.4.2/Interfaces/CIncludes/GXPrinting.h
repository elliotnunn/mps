/*
 	File:		GXPrinting.h
 
 	Contains:	This file contains all printing APIs except for driver/extension specific ones.
 
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

#ifndef __GXPRINTING__
#define __GXPRINTING__


#ifndef __COLLECTIONS__
#include <Collections.h>
#endif
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <MixedMode.h>										*/

#ifndef __CONDITIONALMACROS__
#include <ConditionalMacros.h>
#endif

#ifndef __DIALOGS__
#include <Dialogs.h>
#endif
/*	#include <Errors.h>											*/
/*	#include <Memory.h>											*/
/*	#include <Menus.h>											*/
/*		#include <Quickdraw.h>									*/
/*			#include <QuickdrawText.h>							*/
/*	#include <Controls.h>										*/
/*	#include <Windows.h>										*/
/*		#include <Events.h>										*/
/*			#include <OSUtils.h>								*/
/*	#include <TextEdit.h>										*/

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif
/*	#include <Finder.h>											*/

#ifndef __GXFONTS__
#include <GXFonts.h>
#endif
/*	#include <GXMath.h>											*/
/*		#include <FixMath.h>									*/
/*	#include <GXTypes.h>										*/
/*	#include <ScalerTypes.h>									*/
/*		#include <SFNTTypes.h>									*/

#ifndef __GXMATH__
#include <GXMath.h>
#endif

#ifndef __GXTYPES__
#include <GXTypes.h>
#endif

#ifndef __LISTS__
#include <Lists.h>
#endif

#ifndef __MENUS__
#include <Menus.h>
#endif

#ifndef __GXMESSAGES__
#include <GXMessages.h>
#endif

#ifndef __PRINTING__
#include <Printing.h>
#endif

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif


enum {
	gestaltGXPrintingMgrVersion	= 'pmgr',
	gestaltGXVersion			= 'qdgx'
};

typedef unsigned long gxOwnerSignature;

#if OLDROUTINENAMES
typedef unsigned long Signature;

#endif
typedef struct gxPrivatePrinterRecord *gxPrinter;

typedef struct gxPrivateJobRecord *gxJob;

typedef struct gxPrivateFormatRecord *gxFormat;

typedef struct gxPrivatePaperTypeRecord *gxPaperType;

typedef struct gxPrivatePrintFileRecord *gxPrintFile;

typedef Boolean gxLoopStatus;


enum {
	gxStopLooping				= false,
	gxKeepLooping				= true
};

typedef pascal gxLoopStatus (*gxViewDeviceProcPtr)(gxViewDevice aViewDevice, void *refCon);

#if GENERATINGCFM
typedef UniversalProcPtr gxViewDeviceUPP;
#else
typedef gxViewDeviceProcPtr gxViewDeviceUPP;
#endif

enum {
	uppgxViewDeviceProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(gxLoopStatus)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxViewDevice)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewgxViewDeviceProc(userRoutine)		\
		(gxViewDeviceUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxViewDeviceProcInfo, GetCurrentArchitecture())
#else
#define NewgxViewDeviceProc(userRoutine)		\
		((gxViewDeviceUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallgxViewDeviceProc(userRoutine, aViewDevice, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppgxViewDeviceProcInfo, (aViewDevice), (refCon))
#else
#define CallgxViewDeviceProc(userRoutine, aViewDevice, refCon)		\
		(*(userRoutine))((aViewDevice), (refCon))
#endif

typedef pascal gxLoopStatus (*gxFormatProcPtr)(gxFormat aFormat, void *refCon);

#if GENERATINGCFM
typedef UniversalProcPtr gxFormatUPP;
#else
typedef gxFormatProcPtr gxFormatUPP;
#endif

enum {
	uppgxFormatProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(gxLoopStatus)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxFormat)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewgxFormatProc(userRoutine)		\
		(gxFormatUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxFormatProcInfo, GetCurrentArchitecture())
#else
#define NewgxFormatProc(userRoutine)		\
		((gxFormatUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallgxFormatProc(userRoutine, aFormat, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppgxFormatProcInfo, (aFormat), (refCon))
#else
#define CallgxFormatProc(userRoutine, aFormat, refCon)		\
		(*(userRoutine))((aFormat), (refCon))
#endif

typedef pascal gxLoopStatus (*gxPaperTypeProcPtr)(gxPaperType aPapertype, void *refCon);

#if GENERATINGCFM
typedef UniversalProcPtr gxPaperTypeUPP;
#else
typedef gxPaperTypeProcPtr gxPaperTypeUPP;
#endif

enum {
	uppgxPaperTypeProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(gxLoopStatus)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxPaperType)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewgxPaperTypeProc(userRoutine)		\
		(gxPaperTypeUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxPaperTypeProcInfo, GetCurrentArchitecture())
#else
#define NewgxPaperTypeProc(userRoutine)		\
		((gxPaperTypeUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallgxPaperTypeProc(userRoutine, aPapertype, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppgxPaperTypeProcInfo, (aPapertype), (refCon))
#else
#define CallgxPaperTypeProc(userRoutine, aPapertype, refCon)		\
		(*(userRoutine))((aPapertype), (refCon))
#endif

typedef pascal OSErr (*gxPrintingFlattenProcPtr)(long size, void *data, void *refCon);

#if GENERATINGCFM
typedef UniversalProcPtr gxPrintingFlattenUPP;
#else
typedef gxPrintingFlattenProcPtr gxPrintingFlattenUPP;
#endif

enum {
	uppgxPrintingFlattenProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewgxPrintingFlattenProc(userRoutine)		\
		(gxPrintingFlattenUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppgxPrintingFlattenProcInfo, GetCurrentArchitecture())
#else
#define NewgxPrintingFlattenProc(userRoutine)		\
		((gxPrintingFlattenUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallgxPrintingFlattenProc(userRoutine, size, data, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppgxPrintingFlattenProcInfo, (size), (data), (refCon))
#else
#define CallgxPrintingFlattenProc(userRoutine, size, data, refCon)		\
		(*(userRoutine))((size), (data), (refCon))
#endif

typedef gxViewDeviceProcPtr gxViewDeviceProc;

typedef gxFormatProcPtr gxFormatProc;

typedef gxPaperTypeProcPtr gxPaperTypeProc;

typedef gxPrintingFlattenProcPtr gxPrintingFlattenProc;

/*
	The following constants are used to set collection item flags in printing
	collections. The Printing Manager purges certain items whenever a driver
	switch occurs. If the formatting driver changes, all items marked as
	gxVolatileFormattingDriverCategory will be purged.  If the output driver
	changes, all items marked as gxVolatileOutputDriverCategory will be purged.
	Note that to prevent items from being flattened when GXFlattenJob is called,
	you should unset the collectionPersistenceBit (defined in Collections.h),
	which is on by default.
*/
/* Structure stored in collection items' user attribute bits */
typedef short gxCollectionCategory;


enum {
	gxNoCollectionCategory		= (gxCollectionCategory)0x0000,
	gxOutputDriverCategory		= (gxCollectionCategory)0x0001,
	gxFormattingDriverCategory	= (gxCollectionCategory)0x0002,
	gxDriverVolatileCategory	= (gxCollectionCategory)0x0004,
	gxVolatileOutputDriverCategory = gxOutputDriverCategory + gxDriverVolatileCategory,
	gxVolatileFormattingDriverCategory = gxFormattingDriverCategory + gxDriverVolatileCategory
};

/*

	>>>>>> JOB COLLECTION ITEMS <<<<<<

*/
/* gxJobInfo COLLECTION ITEM */
enum {
	gxJobTag					= 'job '
};

struct gxJobInfo {
	long							numPages;					/* Number of pages in the document */
	long							priority;					/* Priority of this job plus "is it on hold?" */
	unsigned long					timeToPrint;				/* When to print job, if scheduled */
	long							jobTimeout;					/* Timeout value, in ticks */
	long							firstPageToPrint;			/* Start printing from this page */
	short							jobAlert;					/* How to alert user when printing */
	Str31							appName;					/* Which application printed the document */
	Str31							documentName;				/* The name of the document being printed */
	Str31							userName;					/* The owner name of the machine that printed the document */
};
typedef struct gxJobInfo gxJobInfo;

/* priority field constants */

enum {
	gxPrintJobHoldingBit		= 0x00001000					/* This bit is set if the job is on hold. */
};

enum {
	gxPrintJobUrgent			= 0x00000001,
	gxPrintJobAtTime			= 0x00000002,
	gxPrintJobASAP				= 0x00000003,
	gxPrintJobHolding			= (gxPrintJobHoldingBit + gxPrintJobASAP),
	gxPrintJobHoldingAtTime		= (gxPrintJobHoldingBit + gxPrintJobAtTime),
	gxPrintJobHoldingUrgent		= (gxPrintJobHoldingBit + gxPrintJobUrgent)
};

/* jobAlert field constants */
enum {
	gxNoPrintTimeAlert			= 0,							/* Don't alert user when we print */
	gxAlertBefore				= 1,							/* Alert user before we print */
	gxAlertAfter				= 2,							/* Alert user after we print */
	gxAlertBothTimes			= 3								/* Alert before and after we print */
};

/* jobTimeout field constants */
enum {
	gxThirtySeconds				= 1800,							/* 30 seconds in ticks */
	gxTwoMinutes				= 7200							/* 2 minutes in ticks */
};

/* gxCollationTag COLLECTION ITEM */
enum {
	gxCollationTag				= 'sort'
};

struct gxCollationInfo {
	Boolean							collation;					/* True if copies are to be collated */
	char							padByte;
};
typedef struct gxCollationInfo gxCollationInfo;

/* gxCopiesTag COLLECTION ITEM */

enum {
	gxCopiesTag					= 'copy'
};

struct gxCopiesInfo {
	long							copies;						/* Number of copies of the document to print */
};
typedef struct gxCopiesInfo gxCopiesInfo;

/* gxPageRangeTag COLLECTION ITEM */

enum {
	gxPageRangeTag				= 'rang'
};

struct gxSimplePageRangeInfo {
	char							optionChosen;				/* From options listed below */
	Boolean							printAll;					/* True if user wants to print all pages */
	long							fromPage;					/* For gxDefaultPageRange, current value */
	long							toPage;						/* For gxDefaultPageRange, current value */
};
typedef struct gxSimplePageRangeInfo gxSimplePageRangeInfo;

struct gxPageRangeInfo {
	gxSimplePageRangeInfo			simpleRange;				/* Info which will be returned for GetJobPageRange */
	Str31							fromString;					/* For gxCustomizePageRange, current value */
	Str31							toString;					/* For gxCustomizePageRange, current value */
	long							minFromPage;				/* For gxDefaultPageRange, we parse with this, ignored if nil */
	long							maxToPage;					/* For gxDefaultPageRange, we parse with this, ignored if nil */
	char							replaceString[1];			/* For gxReplacePageRange, string to display */
};
typedef struct gxPageRangeInfo gxPageRangeInfo;

/* optionChosen field constants for SimplePageRangeInfo */

enum {
	gxDefaultPageRange			= (char)0,
	gxReplacePageRange			= (char)1,
	gxCustomizePageRange		= (char)2
};

/* gxQualityTag COLLECTION ITEM */
enum {
	gxQualityTag				= 'qual'
};

struct gxQualityInfo {
	Boolean							disableQuality;				/* True to disable standard quality controls */
	char							padByte;
	short							defaultQuality;				/* The default quality value */
	short							currentQuality;				/* The current quality value */
	short							qualityCount;				/* The number of quality menu items in popup menu */
	char							qualityNames[1];			/* An array of packed pascal strings for popup menu titles */
};
typedef struct gxQualityInfo gxQualityInfo;

/* gxFileDestinationTag COLLECTION ITEM */

enum {
	gxFileDestinationTag		= 'dest'
};

struct gxFileDestinationInfo {
	Boolean							toFile;						/* True if destination is a file */
	char							padByte;
};
typedef struct gxFileDestinationInfo gxFileDestinationInfo;

/* gxFileLocationTag COLLECTION ITEM */

enum {
	gxFileLocationTag			= 'floc'
};

struct gxFileLocationInfo {
	FSSpec							fileSpec;					/* Location to put file, if destination is file */
};
typedef struct gxFileLocationInfo gxFileLocationInfo;

/* gxFileFormatTag COLLECTION ITEM */

enum {
	gxFileFormatTag				= 'ffmt'
};

struct gxFileFormatInfo {
	Str31							fileFormatName;				/* Name of file format (e.g. "PostScript") if destination is file */
};
typedef struct gxFileFormatInfo gxFileFormatInfo;

/* gxFileFontsTag COLLECTION ITEM */

enum {
	gxFileFontsTag				= 'incf'
};

struct gxFileFontsInfo {
	char							includeFonts;				/* Which fonts to include, if destination is file */
	char							padByte;
};
typedef struct gxFileFontsInfo gxFileFontsInfo;

/* includeFonts field constants */

enum {
	gxIncludeNoFonts			= (char)1,						/* Include no fonts */
	gxIncludeAllFonts			= (char)2,						/* Include all fonts */
	gxIncludeNonStandardFonts	= (char)3						/* Include only fonts that aren't in the standard LW set */
};

/* gxPaperFeedTag COLLECTION ITEM */
enum {
	gxPaperFeedTag				= 'feed'
};

struct gxPaperFeedInfo {
	Boolean							autoFeed;					/* True if automatic feed, false if manual */
	char							padByte;
};
typedef struct gxPaperFeedInfo gxPaperFeedInfo;

/* gxTrayFeedTag COLLECTION ITEM */

enum {
	gxTrayFeedTag				= 'tray'
};

typedef long gxTrayIndex;

struct gxTrayFeedInfo {
	gxTrayIndex						feedTrayIndex;				/* Tray to feed paper from */
	Boolean							manualFeedThisPage;			/* Signals manual feeding for the page */
	char							padByte;
};
typedef struct gxTrayFeedInfo gxTrayFeedInfo;

/* gxManualFeedTag COLLECTION ITEM */

enum {
	gxManualFeedTag				= 'manf'
};

struct gxManualFeedInfo {
	long							numPaperTypeNames;			/* Number of paperTypes to manually feed */
	Str31							paperTypeNames[1];			/* Array of names of paperTypes to manually feed */
};
typedef struct gxManualFeedInfo gxManualFeedInfo;

/* gxNormalMappingTag COLLECTION ITEM */

enum {
	gxNormalMappingTag			= 'nmap'
};

struct gxNormalMappingInfo {
	Boolean							normalPaperMapping;			/* True if not overriding normal paper mapping */
	char							padByte;
};
typedef struct gxNormalMappingInfo gxNormalMappingInfo;

/* gxSpecialMappingTag COLLECTION ITEM */

enum {
	gxSpecialMappingTag			= 'smap'
};

struct gxSpecialMappingInfo {
	char							specialMapping;				/* Enumerated redirect, scale or tile setting */
	char							padByte;
};
typedef struct gxSpecialMappingInfo gxSpecialMappingInfo;

/* specialMapping field constants */

enum {
	gxRedirectPages				= (char)1,						/* Redirect pages to a papertype and clip if necessary */
	gxScalePages				= (char)2,						/* Scale pages if necessary */
	gxTilePages					= (char)3						/* Tile pages if necessary */
};

/* gxTrayMappingTag COLLECTION ITEM */
enum {
	gxTrayMappingTag			= 'tmap'
};

struct gxTrayMappingInfo {
	gxTrayIndex						mapPaperToTray;				/* Tray to map all paper to */
};
typedef struct gxTrayMappingInfo gxTrayMappingInfo;

/* gxPaperMappingTag COLLECTION ITEM */
/* This collection item contains a flattened paper type resource */

enum {
	gxPaperMappingTag			= 'pmap'
};

/* gxPrintPanelTag COLLECTION ITEM */
enum {
	gxPrintPanelTag				= 'ppan'
};

struct gxPrintPanelInfo {
	Str31							startPanelName;				/* Name of starting panel in Print dialog */
};
typedef struct gxPrintPanelInfo gxPrintPanelInfo;

/* gxFormatPanelTag COLLECTION ITEM */

enum {
	gxFormatPanelTag			= 'fpan'
};

struct gxFormatPanelInfo {
	Str31							startPanelName;				/* Name of starting panel in Format dialog */
};
typedef struct gxFormatPanelInfo gxFormatPanelInfo;

/* gxTranslatedDocumentTag COLLECTION ITEM */

enum {
	gxTranslatedDocumentTag		= 'trns'
};

struct gxTranslatedDocumentInfo {
	long							translatorInfo;				/* Information from the translation process */
};
typedef struct gxTranslatedDocumentInfo gxTranslatedDocumentInfo;

/*

	>>>>>> FORMAT COLLECTION ITEMS <<<<<<

*/
/* gxPaperTypeLockTag COLLECTION ITEM */

enum {
	gxPaperTypeLockTag			= 'ptlk'
};

struct gxPaperTypeLockInfo {
	Boolean							paperTypeLocked;			/* True if format's paperType is locked */
	char							padByte;
};
typedef struct gxPaperTypeLockInfo gxPaperTypeLockInfo;

/* gxOrientationTag COLLECTION ITEM */

enum {
	gxOrientationTag			= 'layo'
};

struct gxOrientationInfo {
	char							orientation;				/* An enumerated orientation value */
	char							padByte;
};
typedef struct gxOrientationInfo gxOrientationInfo;

/* orientation field constants */

enum {
	gxPortraitLayout			= (char)0,						/* Portrait */
	gxLandscapeLayout			= (char)1,						/* Landscape */
	gxRotatedPortraitLayout		= (char)2,						/* Portrait, rotated 180° */
	gxRotatedLandscapeLayout	= (char)3						/* Landscape, rotated 180°  */
};

/* gxScalingTag COLLECTION ITEM */
enum {
	gxScalingTag				= 'scal'
};

struct gxScalingInfo {
	Fixed							horizontalScaleFactor;		/* Current horizontal scaling factor */
	Fixed							verticalScaleFactor;		/* Current vertical scaling factor */
	short							minScaling;					/* Minimum scaling allowed */
	short							maxScaling;					/* Maximum scaling allowed */
};
typedef struct gxScalingInfo gxScalingInfo;

/* gxDirectModeTag COLLECTION ITEM */

enum {
	gxDirectModeTag				= 'dirm'
};

struct gxDirectModeInfo {
	Boolean							directModeOn;				/* True if a direct mode is enabled */
	char							padByte;
};
typedef struct gxDirectModeInfo gxDirectModeInfo;

/* gxFormatHalftoneTag COLLECTION ITEM */

enum {
	gxFormatHalftoneTag			= 'half'
};

struct gxFormatHalftoneInfo {
	long							numHalftones;				/* Number of halftone records */
	gxHalftone						halftones[1];				/* The halftone records */
};
typedef struct gxFormatHalftoneInfo gxFormatHalftoneInfo;

/* gxInvertPageTag COLLECTION ITEM */

enum {
	gxInvertPageTag				= 'invp'
};

struct gxInvertPageInfo {
	char							padByte;
	Boolean							invert;						/* If true, invert page */
};
typedef struct gxInvertPageInfo gxInvertPageInfo;

/* gxFlipPageHorizontalTag COLLECTION ITEM */

enum {
	gxFlipPageHorizontalTag		= 'flph'
};

struct gxFlipPageHorizontalInfo {
	char							padByte;
	Boolean							flipHorizontal;				/* If true, flip x coordinates on page */
};
typedef struct gxFlipPageHorizontalInfo gxFlipPageHorizontalInfo;

/* gxFlipPageVerticalTag COLLECTION ITEM */

enum {
	gxFlipPageVerticalTag		= 'flpv'
};

struct gxFlipPageVerticalInfo {
	char							padByte;
	Boolean							flipVertical;				/* If true, flip y coordinates on page */
};
typedef struct gxFlipPageVerticalInfo gxFlipPageVerticalInfo;

/* gxPreciseBitmapsTag COLLECTION ITEM */

enum {
	gxPreciseBitmapsTag			= 'pbmp'
};

struct gxPreciseBitmapInfo {
	Boolean							preciseBitmaps;				/* If true, scale page by 96% */
	char							padByte;
};
typedef struct gxPreciseBitmapInfo gxPreciseBitmapInfo;

/*

	>>>>>> PAPERTYPE COLLECTION ITEMS <<<<<<

*/
/* gxBaseTag COLLECTION ITEM */

enum {
	gxBaseTag					= 'base'
};

struct gxBaseInfo {
	long							baseType;					/* PaperType's base type */
};
typedef struct gxBaseInfo gxBaseInfo;

/* baseType field constants */

enum {
	gxUnknownBase				= 0,							/* Base paper type from which this paper type is */
	gxUSLetterBase				= 1,							/* derived.  This is not a complete set. */
	gxUSLegalBase				= 2,
	gxA4LetterBase				= 3,
	gxB5LetterBase				= 4,
	gxTabloidBase				= 5
};

/* gxCreatorTag COLLECTION ITEM */
enum {
	gxCreatorTag				= 'crea'
};

struct gxCreatorInfo {
	OSType							creator;					/* PaperType's creator */
};
typedef struct gxCreatorInfo gxCreatorInfo;

/* gxUnitsTag COLLECTION ITEM */

enum {
	gxUnitsTag					= 'unit'
};

struct gxUnitsInfo {
	char							units;						/* PaperType's units (used by PaperType Editor). */
	char							padByte;
};
typedef struct gxUnitsInfo gxUnitsInfo;

/* units field constants */

enum {
	gxPicas						= (char)0,						/* Pica measurement */
	gxMMs						= (char)1,						/* Millimeter measurement */
	gxInches					= (char)2						/* Inches measurement */
};

/* gxFlagsTag COLLECTION ITEM */
enum {
	gxFlagsTag					= 'flag'
};

struct gxFlagsInfo {
	long							flags;						/* PaperType's flags */
};
typedef struct gxFlagsInfo gxFlagsInfo;

/* flags field constants */

enum {
	gxOldPaperTypeFlag			= 0x00800000,					/* Indicates a paper type for compatibility printing */
	gxNewPaperTypeFlag			= 0x00400000,					/* Indicates a paper type for QuickDraw GX-aware printing */
	gxOldAndNewFlag				= 0x00C00000,					/* Indicates a paper type that's both old and new */
	gxDefaultPaperTypeFlag		= 0x00100000					/* Indicates the default paper type in the group */
};

/* gxCommentTag COLLECTION ITEM */
enum {
	gxCommentTag				= 'cmnt'
};

struct gxCommentInfo {
	Str255							comment;					/* PaperType's comment */
};
typedef struct gxCommentInfo gxCommentInfo;

/*

	>>>>>> PRINTER VIEWDEVICE TAGS <<<<<<

*/
/* gxPenTableTag COLLECTION ITEM */

enum {
	gxPenTableTag				= 'pent'
};

struct gxPenTableEntry {
	Str31							penName;					/* Name of the pen */
	gxColor							penColor;					/* Color to use from the color set */
	Fixed							penThickness;				/* Size of the pen */
	short							penUnits;					/* Specifies units in which pen thickness is defined */
	short							penPosition;				/* Pen position in the carousel, -1 (kPenNotLoaded) if not loaded */
};
typedef struct gxPenTableEntry gxPenTableEntry;

struct gxPenTable {
	long							numPens;					/* Number of pen entries in the following array */
	gxPenTableEntry					pens[1];					/* Array of pen entries */
};
typedef struct gxPenTable gxPenTable, *gxPenTablePtr, **gxPenTableHdl;

/* penUnits field constants */

enum {
	gxDeviceUnits				= 0,
	gxMMUnits					= 1,
	gxInchesUnits				= 2
};

/* penPosition field constants */
enum {
	gxPenNotLoaded				= -1
};

/*

	>>>>>> DIALOG-RELATED CONSTANTS AND TYPES <<<<<<

*/
typedef long gxDialogResult;


enum {
	gxCancelSelected			= (gxDialogResult)0,
	gxOKSelected				= (gxDialogResult)1,
	gxRevertSelected			= (gxDialogResult)2
};

struct gxEditMenuRecord {
	short							editMenuID;
	short							cutItem;
	short							copyItem;
	short							pasteItem;
	short							clearItem;
	short							undoItem;
};
typedef struct gxEditMenuRecord gxEditMenuRecord;

/*

	>>>>>> JOB FORMAT MODE CONSTANTS AND TYPES <<<<<<

*/
typedef OSType gxJobFormatMode;

struct gxJobFormatModeTable {
	long							numModes;					/* Number of job format modes to choose from */
	gxJobFormatMode					modes[1];					/* The job format modes */
};
typedef struct gxJobFormatModeTable gxJobFormatModeTable, *gxJobFormatModeTablePtr, **gxJobFormatModeTableHdl;


enum {
	gxGraphicsJobFormatMode		= (gxJobFormatMode)'grph',
	gxTextJobFormatMode			= (gxJobFormatMode)'text',
	gxPostScriptJobFormatMode	= (gxJobFormatMode)'post'
};

typedef long gxQueryType;


enum {
	gxGetJobFormatLineConstraintQuery = (gxQueryType)0,
	gxGetJobFormatFontsQuery	= (gxQueryType)1,
	gxGetJobFormatFontCommonStylesQuery = (gxQueryType)2,
	gxGetJobFormatFontConstraintQuery = (gxQueryType)3,
	gxSetStyleJobFormatCommonStyleQuery = (gxQueryType)4
};

/* Structures used for Text mode field constants */
struct gxPositionConstraintTable {
	gxPoint							phase;						/* Position phase */
	gxPoint							offset;						/* Position offset */
	long							numSizes;					/* Number of available font sizes */
	Fixed							sizes[1];					/* The available font sizes */
};
typedef struct gxPositionConstraintTable gxPositionConstraintTable, *gxPositionConstraintTablePtr, **gxPositionConstraintTableHdl;

/* numSizes field constants */

enum {
	gxConstraintRange			= -1
};

struct gxStyleNameTable {
	long							numStyleNames;				/* Number of style names */
	Str255							styleNames[1];				/* The style names */
};
typedef struct gxStyleNameTable gxStyleNameTable, *gxStyleNameTablePtr, **gxStyleNameTableHdl;

struct gxFontTable {
	long							numFonts;					/* Number of font references */
	gxFont							fonts[1];					/* The font references */
};
typedef struct gxFontTable gxFontTable, *gxFontTablePtr, **gxFontTableHdl;

/* ------------------------------------------------------------------------------

								Printing Manager API Functions

-------------------------------------------------------------------------------- */
extern pascal OSErr GXInitPrinting(void)
 FOURWORDINLINE(0x203C, 0x0000, 0, 0xABFE);
extern pascal OSErr GXExitPrinting(void)
 FOURWORDINLINE(0x203C, 0x0000, 1, 0xABFE);
/*
	Error-Handling Routines
*/
extern pascal OSErr GXGetJobError(gxJob aJob)
 FOURWORDINLINE(0x203C, 0x0000, 14, 0xABFE);
extern pascal void GXSetJobError(gxJob aJob, OSErr anErr)
 FOURWORDINLINE(0x203C, 0x0000, 15, 0xABFE);
/*
	Job Routines
*/
extern pascal OSErr GXNewJob(gxJob *aJob)
 FOURWORDINLINE(0x203C, 0x0000, 2, 0xABFE);
extern pascal OSErr GXDisposeJob(gxJob aJob)
 FOURWORDINLINE(0x203C, 0x0000, 3, 0xABFE);
extern pascal void GXFlattenJob(gxJob aJob, gxPrintingFlattenProc flattenProc, void *aVoid)
 FOURWORDINLINE(0x203C, 0x0000, 4, 0xABFE);
extern pascal gxJob GXUnflattenJob(gxJob aJob, gxPrintingFlattenProc flattenProc, void *aVoid)
 FOURWORDINLINE(0x203C, 0x0000, 5, 0xABFE);
extern pascal Handle GXFlattenJobToHdl(gxJob aJob, Handle aHdl)
 FOURWORDINLINE(0x203C, 0x0000, 6, 0xABFE);
extern pascal gxJob GXUnflattenJobFromHdl(gxJob aJob, Handle aHdl)
 FOURWORDINLINE(0x203C, 0x0000, 7, 0xABFE);
extern pascal void GXInstallApplicationOverride(gxJob aJob, short messageID, void *override)
 FOURWORDINLINE(0x203C, 0x0000, 8, 0xABFE);
extern pascal Collection GXGetJobCollection(gxJob aJob)
 FOURWORDINLINE(0x203C, 0x0000, 29, 0xABFE);
extern pascal void *GXGetJobRefCon(gxJob aJob)
 FOURWORDINLINE(0x203C, 0x0000, 30, 0xABFE);
extern pascal void GXSetJobRefCon(gxJob aJob, void *refCon)
 FOURWORDINLINE(0x203C, 0x0000, 31, 0xABFE);
extern pascal gxJob GXCopyJob(gxJob srcJob, gxJob dstJob)
 FOURWORDINLINE(0x203C, 0x0000, 32, 0xABFE);
extern pascal void GXSelectJobFormattingPrinter(gxJob aJob, Str31 printerName)
 FOURWORDINLINE(0x203C, 0x0000, 33, 0xABFE);
extern pascal void GXSelectJobOutputPrinter(gxJob aJob, Str31 printerName)
 FOURWORDINLINE(0x203C, 0x0000, 34, 0xABFE);
extern pascal void GXForEachJobFormatDo(gxJob aJob, gxFormatProc formatProc, void *refCon)
 FOURWORDINLINE(0x203C, 0x0000, 35, 0xABFE);
extern pascal long GXCountJobFormats(gxJob aJob)
 FOURWORDINLINE(0x203C, 0x0000, 36, 0xABFE);
extern pascal Boolean GXUpdateJob(gxJob aJob)
 FOURWORDINLINE(0x203C, 0x0000, 37, 0xABFE);
extern pascal void GXConvertPrintRecord(gxJob aJob, THPrint hPrint)
 FOURWORDINLINE(0x203C, 0x0000, 38, 0xABFE);
extern pascal void GXIdleJob(gxJob aJob)
 FOURWORDINLINE(0x203C, 0x0000, 87, 0xABFE);
/*
	Job Format Modes Routines
*/
extern pascal void GXSetAvailableJobFormatModes(gxJob aJob, gxJobFormatModeTableHdl formatModeTable)
 FOURWORDINLINE(0x203C, 0x0000, 59, 0xABFE);
extern pascal gxJobFormatMode GXGetPreferredJobFormatMode(gxJob aJob, Boolean *directOnly)
 FOURWORDINLINE(0x203C, 0x0000, 60, 0xABFE);
extern pascal gxJobFormatMode GXGetJobFormatMode(gxJob aJob)
 FOURWORDINLINE(0x203C, 0x0000, 61, 0xABFE);
extern pascal void GXSetJobFormatMode(gxJob aJob, gxJobFormatMode formatMode)
 FOURWORDINLINE(0x203C, 0x0000, 62, 0xABFE);
extern pascal void GXJobFormatModeQuery(gxJob aJob, gxQueryType aQueryType, void *srcData, void *dstData)
 FOURWORDINLINE(0x203C, 0x0000, 63, 0xABFE);
/*
	Format Routines
*/
extern pascal gxFormat GXNewFormat(gxJob aJob)
 FOURWORDINLINE(0x203C, 0x0000, 9, 0xABFE);
extern pascal void GXDisposeFormat(gxFormat aFormat)
 FOURWORDINLINE(0x203C, 0x0000, 10, 0xABFE);
extern pascal gxFormat GXGetJobFormat(gxJob aJob, long whichFormat)
 FOURWORDINLINE(0x203C, 0x0000, 19, 0xABFE);
extern pascal gxJob GXGetFormatJob(gxFormat aFormat)
 FOURWORDINLINE(0x203C, 0x0000, 20, 0xABFE);
extern pascal gxPaperType GXGetFormatPaperType(gxFormat aFormat)
 FOURWORDINLINE(0x203C, 0x0000, 21, 0xABFE);
extern pascal void GXGetFormatDimensions(gxFormat aFormat, gxRectangle *pageSize, gxRectangle *paperSize)
 FOURWORDINLINE(0x203C, 0x0000, 22, 0xABFE);
extern pascal Collection GXGetFormatCollection(gxFormat aFormat)
 FOURWORDINLINE(0x203C, 0x0000, 51, 0xABFE);
extern pascal void GXChangedFormat(gxFormat aFormat)
 FOURWORDINLINE(0x203C, 0x0000, 52, 0xABFE);
extern pascal gxFormat GXCopyFormat(gxFormat srcFormat, gxFormat dstFormat)
 FOURWORDINLINE(0x203C, 0x0000, 53, 0xABFE);
extern pascal gxFormat GXCloneFormat(gxFormat aFormat)
 FOURWORDINLINE(0x203C, 0x0000, 54, 0xABFE);
extern pascal long GXCountFormatOwners(gxFormat aFormat)
 FOURWORDINLINE(0x203C, 0x0000, 55, 0xABFE);
extern pascal void GXGetFormatMapping(gxFormat aFormat, gxMapping *fmtMapping)
 FOURWORDINLINE(0x203C, 0x0000, 56, 0xABFE);
extern pascal gxShape GXGetFormatForm(gxFormat aFormat, gxShape *mask)
 FOURWORDINLINE(0x203C, 0x0000, 57, 0xABFE);
extern pascal void GXSetFormatForm(gxFormat aFormat, gxShape form, gxShape mask)
 FOURWORDINLINE(0x203C, 0x0000, 58, 0xABFE);
/*
	PaperType Routines
*/
extern pascal gxPaperType GXNewPaperType(gxJob aJob, Str31 name, gxRectangle *pageSize, gxRectangle *paperSize)
 FOURWORDINLINE(0x203C, 0x0000, 11, 0xABFE);
extern pascal void GXDisposePaperType(gxPaperType aPaperType)
 FOURWORDINLINE(0x203C, 0x0000, 12, 0xABFE);
extern pascal gxPaperType GXGetNewPaperType(gxJob aJob, short resID)
 FOURWORDINLINE(0x203C, 0x0000, 13, 0xABFE);
extern pascal long GXCountJobPaperTypes(gxJob aJob, Boolean forFormatDevice)
 FOURWORDINLINE(0x203C, 0x0000, 66, 0xABFE);
extern pascal gxPaperType GXGetJobPaperType(gxJob aJob, long whichPaperType, Boolean forFormatDevice, gxPaperType aPaperType)
 FOURWORDINLINE(0x203C, 0x0000, 67, 0xABFE);
extern pascal void GXForEachJobPaperTypeDo(gxJob aJob, gxPaperTypeProc aProc, void *refCon, Boolean forFormattingPrinter)
 FOURWORDINLINE(0x203C, 0x0000, 68, 0xABFE);
extern pascal gxPaperType GXCopyPaperType(gxPaperType srcPaperType, gxPaperType dstPaperType)
 FOURWORDINLINE(0x203C, 0x0000, 69, 0xABFE);
extern pascal void GXGetPaperTypeName(gxPaperType aPaperType, Str31 papertypeName)
 FOURWORDINLINE(0x203C, 0x0000, 70, 0xABFE);
extern pascal void GXGetPaperTypeDimensions(gxPaperType aPaperType, gxRectangle *pageSize, gxRectangle *paperSize)
 FOURWORDINLINE(0x203C, 0x0000, 71, 0xABFE);
extern pascal gxJob GXGetPaperTypeJob(gxPaperType aPaperType)
 FOURWORDINLINE(0x203C, 0x0000, 72, 0xABFE);
extern pascal Collection GXGetPaperTypeCollection(gxPaperType aPaperType)
 FOURWORDINLINE(0x203C, 0x0000, 73, 0xABFE);
/*
	Printer Routines
*/
extern pascal gxPrinter GXGetJobFormattingPrinter(gxJob aJob)
 FOURWORDINLINE(0x203C, 0x0000, 39, 0xABFE);
extern pascal gxPrinter GXGetJobOutputPrinter(gxJob aJob)
 FOURWORDINLINE(0x203C, 0x0000, 40, 0xABFE);
extern pascal gxPrinter GXGetJobPrinter(gxJob aJob)
 FOURWORDINLINE(0x203C, 0x0000, 41, 0xABFE);
extern pascal gxJob GXGetPrinterJob(gxPrinter aPrinter)
 FOURWORDINLINE(0x203C, 0x0000, 42, 0xABFE);
extern pascal void GXForEachPrinterViewDeviceDo(gxPrinter aPrinter, gxViewDeviceProc aProc, void *refCon)
 FOURWORDINLINE(0x203C, 0x0000, 43, 0xABFE);
extern pascal long GXCountPrinterViewDevices(gxPrinter aPrinter)
 FOURWORDINLINE(0x203C, 0x0000, 44, 0xABFE);
extern pascal gxViewDevice GXGetPrinterViewDevice(gxPrinter aPrinter, long whichViewDevice)
 FOURWORDINLINE(0x203C, 0x0000, 45, 0xABFE);
extern pascal void GXSelectPrinterViewDevice(gxPrinter aPrinter, long whichViewDevice)
 FOURWORDINLINE(0x203C, 0x0000, 46, 0xABFE);
extern pascal void GXGetPrinterName(gxPrinter aPrinter, Str31 printerName)
 FOURWORDINLINE(0x203C, 0x0000, 47, 0xABFE);
extern pascal OSType GXGetPrinterType(gxPrinter aPrinter)
 FOURWORDINLINE(0x203C, 0x0000, 48, 0xABFE);
extern pascal void GXGetPrinterDriverName(gxPrinter aPrinter, Str31 driverName)
 FOURWORDINLINE(0x203C, 0x0000, 49, 0xABFE);
extern pascal OSType GXGetPrinterDriverType(gxPrinter aPrinter)
 FOURWORDINLINE(0x203C, 0x0000, 50, 0xABFE);
/*
	Dialog Routines
*/
extern pascal gxDialogResult GXJobDefaultFormatDialog(gxJob aJob, gxEditMenuRecord *anEditMenuRec)
 FOURWORDINLINE(0x203C, 0x0000, 16, 0xABFE);
extern pascal gxDialogResult GXJobPrintDialog(gxJob aJob, gxEditMenuRecord *anEditMenuRec)
 FOURWORDINLINE(0x203C, 0x0000, 17, 0xABFE);
extern pascal gxDialogResult GXFormatDialog(gxFormat aFormat, gxEditMenuRecord *anEditMenuRec, StringPtr title)
 FOURWORDINLINE(0x203C, 0x0000, 18, 0xABFE);
extern pascal void GXEnableJobScalingPanel(gxJob aJob, Boolean enabled)
 FOURWORDINLINE(0x203C, 0x0000, 64, 0xABFE);
extern pascal void GXGetJobPanelDimensions(gxJob aJob, Rect *panelArea)
 FOURWORDINLINE(0x203C, 0x0000, 65, 0xABFE);
/*
	Spooling Routines
*/
extern pascal void GXGetJobPageRange(gxJob theJob, long *firstPage, long *lastPage)
 FOURWORDINLINE(0x203C, 0x0000, 23, 0xABFE);
extern pascal void GXStartJob(gxJob theJob, StringPtr docName, long pageCount)
 FOURWORDINLINE(0x203C, 0x0000, 24, 0xABFE);
extern pascal void GXPrintPage(gxJob theJob, long pageNumber, gxFormat theFormat, gxShape thePage)
 FOURWORDINLINE(0x203C, 0x0000, 25, 0xABFE);
extern pascal Boolean GXStartPage(gxJob theJob, long pageNumber, gxFormat theFormat, long numViewPorts, gxViewPort *viewPortList)
 FOURWORDINLINE(0x203C, 0x0000, 26, 0xABFE);
extern pascal void GXFinishPage(gxJob theJob)
 FOURWORDINLINE(0x203C, 0x0000, 27, 0xABFE);
extern pascal void GXFinishJob(gxJob theJob)
 FOURWORDINLINE(0x203C, 0x0000, 28, 0xABFE);
/*
	PrintFile Routines
*/
extern pascal gxPrintFile GXOpenPrintFile(gxJob theJob, FSSpecPtr anFSSpec, char permission)
 FOURWORDINLINE(0x203C, 0x0000, 74, 0xABFE);
extern pascal void GXClosePrintFile(gxPrintFile aPrintFile)
 FOURWORDINLINE(0x203C, 0x0000, 75, 0xABFE);
extern pascal gxJob GXGetPrintFileJob(gxPrintFile aPrintFile)
 FOURWORDINLINE(0x203C, 0x0000, 76, 0xABFE);
extern pascal long GXCountPrintFilePages(gxPrintFile aPrintFile)
 FOURWORDINLINE(0x203C, 0x0000, 77, 0xABFE);
extern pascal void GXReadPrintFilePage(gxPrintFile aPrintFile, long pageNumber, long numViewPorts, gxViewPort *viewPortList, gxFormat *pgFormat, gxShape *pgShape)
 FOURWORDINLINE(0x203C, 0x0000, 78, 0xABFE);
extern pascal void GXReplacePrintFilePage(gxPrintFile aPrintFile, long pageNumber, gxFormat aFormat, gxShape aShape)
 FOURWORDINLINE(0x203C, 0x0000, 79, 0xABFE);
extern pascal void GXInsertPrintFilePage(gxPrintFile aPrintFile, long atPageNumber, gxFormat pgFormat, gxShape pgShape)
 FOURWORDINLINE(0x203C, 0x0000, 80, 0xABFE);
extern pascal void GXDeletePrintFilePageRange(gxPrintFile aPrintFile, long fromPageNumber, long toPageNumber)
 FOURWORDINLINE(0x203C, 0x0000, 81, 0xABFE);
extern pascal void GXSavePrintFile(gxPrintFile aPrintFile, FSSpec *anFSSpec)
 FOURWORDINLINE(0x203C, 0x0000, 82, 0xABFE);
/*
	ColorSync Routines
*/
extern pascal long GXFindPrinterProfile(gxPrinter aPrinter, void *searchData, long index, gxColorProfile *returnedProfile)
 FOURWORDINLINE(0x203C, 0x0000, 83, 0xABFE);
extern pascal long GXFindFormatProfile(gxFormat aFormat, void *searchData, long index, gxColorProfile *returnedProfile)
 FOURWORDINLINE(0x203C, 0x0000, 84, 0xABFE);
extern pascal void GXSetPrinterProfile(gxPrinter aPrinter, gxColorProfile oldProfile, gxColorProfile newProfile)
 FOURWORDINLINE(0x203C, 0x0000, 85, 0xABFE);
extern pascal void GXSetFormatProfile(gxFormat aFormat, gxColorProfile oldProfile, gxColorProfile newProfile)
 FOURWORDINLINE(0x203C, 0x0000, 86, 0xABFE);
/************************************************************************
						Start of old "GXPrintingResEquates.h/a/p" interface file.
				*************************************************************************/
/*	------------------------------------
				Basic client types
	------------------------------------ */

enum {
	gxPrintingManagerType		= 'pmgr',
	gxImagingSystemType			= 'gxis',
	gxPrinterDriverType			= 'pdvr',
	gxPrintingExtensionType		= 'pext',
	gxUnknownPrinterType		= 'none',
	gxAnyPrinterType			= 'univ',
	gxQuickdrawPrinterType		= 'qdrw',
	gxPortableDocPrinterType	= 'gxpd',
	gxRasterPrinterType			= 'rast',
	gxPostscriptPrinterType		= 'post',
	gxVectorPrinterType			= 'vect'
};

/* All pre-defined printing collection items have this ID */
enum {
	gxPrintingTagID				= -28672
};

/*	----------------------------------------------------------------------

		Resource types and IDs used by both extension and driver writers

	---------------------------------------------------------------------- */
/* Resources in a printer driver or extension must be based off of these IDs */
enum {
	gxPrintingDriverBaseID		= -27648,
	gxPrintingExtensionBaseID	= -27136
};

/*	Override resources tell the system what messages a driver or extension
		is overriding.  A driver may have a series of these resources. */
enum {
	gxOverrideType				= 'over'
};

/*	--------------------------------------------------------------

		Message ID definitions by both extension and driver writers

	--------------------------------------------------------------- */
/* Identifiers for universal message overrides. */
enum {
	gxInitializeMsg				= 0,
	gxShutDownMsg				= 1,
	gxJobIdleMsg				= 2,
	gxJobStatusMsg				= 3,
	gxPrintingEventMsg			= 4,
	gxJobDefaultFormatDialogMsg	= 5,
	gxFormatDialogMsg			= 6,
	gxJobPrintDialogMsg			= 7,
	gxFilterPanelEventMsg		= 8,
	gxHandlePanelEventMsg		= 9,
	gxParsePageRangeMsg			= 10,
	gxDefaultJobMsg				= 11,
	gxDefaultFormatMsg			= 12,
	gxDefaultPaperTypeMsg		= 13,
	gxDefaultPrinterMsg			= 14,
	gxCreateSpoolFileMsg		= 15,
	gxSpoolPageMsg				= 16,
	gxSpoolDataMsg				= 17,
	gxSpoolResourceMsg			= 18,
	gxCompleteSpoolFileMsg		= 19,
	gxCountPagesMsg				= 20,
	gxDespoolPageMsg			= 21,
	gxDespoolDataMsg			= 22,
	gxDespoolResourceMsg		= 23,
	gxCloseSpoolFileMsg			= 24,
	gxStartJobMsg				= 25,
	gxFinishJobMsg				= 26,
	gxStartPageMsg				= 27,
	gxFinishPageMsg				= 28,
	gxPrintPageMsg				= 29,
	gxSetupImageDataMsg			= 30,
	gxImageJobMsg				= 31,
	gxImageDocumentMsg			= 32,
	gxImagePageMsg				= 33,
	gxRenderPageMsg				= 34,
	gxCreateImageFileMsg		= 35,
	gxOpenConnectionMsg			= 36,
	gxCloseConnectionMsg		= 37,
	gxStartSendPageMsg			= 38,
	gxFinishSendPageMsg			= 39,
	gxWriteDataMsg				= 40,
	gxBufferDataMsg				= 41,
	gxDumpBufferMsg				= 42,
	gxFreeBufferMsg				= 43,
	gxCheckStatusMsg			= 44,
	gxGetDeviceStatusMsg		= 45,
	gxFetchTaggedDataMsg		= 46,
	gxGetDTPMenuListMsg			= 47,
	gxDTPMenuSelectMsg			= 48,
	gxHandleAlertFilterMsg		= 49,
	gxJobFormatModeQueryMsg		= 50,
	gxWriteStatusToDTPWindowMsg	= 51,
	gxInitializeStatusAlertMsg	= 52,
	gxHandleAlertStatusMsg		= 53,
	gxHandleAlertEventMsg		= 54,
	gxCleanupStartJobMsg		= 55,
	gxCleanupStartPageMsg		= 56,
	gxCleanupOpenConnectionMsg	= 57,
	gxCleanupStartSendPageMsg	= 58,
	gxDefaultDesktopPrinterMsg	= 59,
	gxCaptureOutputDeviceMsg	= 60,
	gxOpenConnectionRetryMsg	= 61,
	gxExamineSpoolFileMsg		= 62,
	gxFinishSendPlaneMsg		= 63,
	gxDoesPaperFitMsg			= 64,
	gxChooserMessageMsg			= 65,
	gxFindPrinterProfileMsg		= 66,
	gxFindFormatProfileMsg		= 67,
	gxSetPrinterProfileMsg		= 68,
	gxSetFormatProfileMsg		= 69,
	gxHandleAltDestinationMsg	= 70,
	gxSetupPageImageDataMsg		= 71
};

/* Identifiers for Quickdraw message overrides. */
enum {
	gxPrOpenDocMsg				= 0,
	gxPrCloseDocMsg				= 1,
	gxPrOpenPageMsg				= 2,
	gxPrClosePageMsg			= 3,
	gxPrintDefaultMsg			= 4,
	gxPrStlDialogMsg			= 5,
	gxPrJobDialogMsg			= 6,
	gxPrStlInitMsg				= 7,
	gxPrJobInitMsg				= 8,
	gxPrDlgMainMsg				= 9,
	gxPrValidateMsg				= 10,
	gxPrJobMergeMsg				= 11,
	gxPrGeneralMsg				= 12,
	gxConvertPrintRecordToMsg	= 13,
	gxConvertPrintRecordFromMsg	= 14,
	gxPrintRecordToJobMsg		= 15
};

/* Identifiers for raster imaging message overrides. */
enum {
	gxRasterDataInMsg			= 0,
	gxRasterLineFeedMsg			= 1,
	gxRasterPackageBitmapMsg	= 2
};

/* Identifiers for PostScript imaging message overrides. */
enum {
	gxPostscriptQueryPrinterMsg	= 0,
	gxPostscriptInitializePrinterMsg = 1,
	gxPostscriptResetPrinterMsg	= 2,
	gxPostscriptExitServerMsg	= 3,
	gxPostscriptGetStatusTextMsg = 4,
	gxPostscriptGetPrinterTextMsg = 5,
	gxPostscriptScanStatusTextMsg = 6,
	gxPostscriptScanPrinterTextMsg = 7,
	gxPostscriptGetDocumentProcSetListMsg = 8,
	gxPostscriptDownloadProcSetListMsg = 9,
	gxPostscriptGetPrinterGlyphsInformationMsg = 10,
	gxPostscriptStreamFontMsg	= 11,
	gxPostscriptDoDocumentHeaderMsg = 12,
	gxPostscriptDoDocumentSetUpMsg = 13,
	gxPostscriptDoDocumentTrailerMsg = 14,
	gxPostscriptDoPageSetUpMsg	= 15,
	gxPostscriptSelectPaperTypeMsg = 16,
	gxPostscriptDoPageTrailerMsg = 17,
	gxPostscriptEjectPageMsg	= 18,
	gxPostscriptProcessShapeMsg	= 19,
	gxPostScriptEjectPendingPageMsg = 20
};

/* Identifiers for Vector imaging message overrides. */
enum {
	gxVectorPackageDataMsg		= 0,
	gxVectorLoadPensMsg			= 1,
	gxVectorVectorizeShapeMsg	= 2
};

/* Dialog related resource types */
enum {
	gxPrintingAlertType			= 'plrt',
	gxStatusType				= 'stat',
	gxExtendedDITLType			= 'xdtl',
	gxPrintPanelType			= 'ppnl',
	gxCollectionType			= 'cltn'
};

/* Communication resource types */
/*
	The looker resource is used by the Chooser PACK to determine what kind
	of communications this driver supports. (In order to generate/handle the 
	pop-up menu for "Connect via:".
	
	The looker resource is also used by PrinterShare to determine the AppleTalk NBP Type
	for servers created for this driver.
*/
enum {
	gxLookerType				= 'look',
	gxLookerID					= -4096
};

/* The communications method and private data used to connect to the printer */
enum {
	gxDeviceCommunicationsType	= 'comm'
};

/*	-------------------------------------------------

	Resource types and IDs used by extension writers

	------------------------------------------------- */
enum {
	gxExtensionUniversalOverrideID = gxPrintingExtensionBaseID
};

enum {
	gxExtensionImagingOverrideSelectorID = gxPrintingExtensionBaseID
};

enum {
	gxExtensionScopeType		= 'scop',
	gxDriverScopeID				= gxPrintingExtensionBaseID,
	gxPrinterScopeID			= gxPrintingExtensionBaseID + 1,
	gxPrinterExceptionScopeID	= gxPrintingExtensionBaseID + 2
};

enum {
	gxExtensionLoadType			= 'load',
	gxExtensionLoadID			= gxPrintingExtensionBaseID
};

enum {
	gxExtensionLoadFirst		= 0x00000100,
	gxExtensionLoadAnywhere		= 0x7FFFFFFF,
	gxExtensionLoadLast			= 0xFFFFFF00
};

enum {
	gxExtensionOptimizationType	= 'eopt',
	gxExtensionOptimizationID	= gxPrintingExtensionBaseID
};

/*	-----------------------------------------------

	Resource types and IDs used by driver writers

	----------------------------------------------- */
enum {
	gxDriverUniversalOverrideID	= gxPrintingDriverBaseID,
	gxDriverImagingOverrideID	= gxPrintingDriverBaseID + 1,
	gxDriverCompatibilityOverrideID = gxPrintingDriverBaseID + 2
};

enum {
	gxDriverFileFormatType		= 'pfil',
	gxDriverFileFormatID		= gxPrintingDriverBaseID
};

enum {
	gxDestinationAdditionType	= 'dsta',
	gxDestinationAdditionID		= gxPrintingDriverBaseID
};

/* IMAGING RESOURCES */
/*	The imaging system resource specifies which imaging system a printer
		driver wishes to use. */
enum {
	gxImagingSystemSelectorType	= 'isys',
	gxImagingSystemSelectorID	= gxPrintingDriverBaseID
};

/* 'exft' resource ID -- exclude font list */
enum {
	kExcludeFontListType		= 'exft',
	kExcludeFontListID			= gxPrintingDriverBaseID
};

/* Resource for type for color matching */
enum {
	gxColorMatchingDataType		= 'prof',
	gxColorMatchingDataID		= gxPrintingDriverBaseID
};

/* Resource type and id for the tray count */
enum {
	gxTrayCountDataType			= 'tray',
	gxTrayCountDataID			= gxPrintingDriverBaseID
};

/* Resource type for the tray names */
enum {
	gxTrayNameDataType			= 'tryn'
};

/* Resource type for manual feed preferences, stored in DTP. */
enum {
	gxManualFeedAlertPrefsType	= 'mfpr',
	gxManualFeedAlertPrefsID	= gxPrintingDriverBaseID
};

/* Resource type for desktop printer output characteristics, stored in DTP. */
enum {
	gxDriverOutputType			= 'outp',
	gxDriverOutputTypeID		= 1
};

/* IO Resources */
/* Resource type and ID for default IO and buffering resources */
enum {
	gxUniversalIOPrefsType		= 'iobm',
	gxUniversalIOPrefsID		= gxPrintingDriverBaseID
};

/*	Resource types and IDs for default implementation of CaptureOutputDevice.
		The default implementation of CaptureOutputDevice only handles PAP devices */
enum {
	gxCaptureType				= 'cpts',
	gxCaptureStringID			= gxPrintingDriverBaseID,
	gxReleaseStringID			= gxPrintingDriverBaseID + 1,
	gxUncapturedAppleTalkType	= gxPrintingDriverBaseID + 2,
	gxCapturedAppleTalkType		= gxPrintingDriverBaseID + 3
};

/* Resource type and ID for custom halftone matrix */
enum {
	gxCustomMatrixType			= 'dmat',
	gxCustomMatrixID			= gxPrintingDriverBaseID
};

/* Resource type and ID for raster driver rendering preferences */
enum {
	gxRasterPrefsType			= 'rdip',
	gxRasterPrefsID				= gxPrintingDriverBaseID
};

/* Resource type for specifiying a colorset */
enum {
	gxColorSetResType			= 'crst'
};

/* Resource type and ID for raster driver packaging preferences */
enum {
	gxRasterPackType			= 'rpck',
	gxRasterPackID				= gxPrintingDriverBaseID
};

/* Resource type and ID for raster driver packaging options */
enum {
	gxRasterNumNone				= 0,							/* Number isn't output at all */
	gxRasterNumDirect			= 1,							/* Lowest minWidth bytes as data */
	gxRasterNumToASCII			= 2								/* minWidth ASCII characters */
};

enum {
	gxRasterPackOptionsType		= 'ropt',
	gxRasterPackOptionsID		= gxPrintingDriverBaseID
};

/* Resource type for the PostScript imaging system procedure set control resource */
enum {
	gxPostscriptProcSetControlType = 'prec'
};

/* Resource type for the PostScript imaging system printer font resource */
enum {
	gxPostscriptPrinterFontType	= 'pfnt'
};

/* Resource type and id for the PostScript imaging system imaging preferences */
enum {
	gxPostscriptPrefsType		= 'pdip',
	gxPostscriptPrefsID			= gxPrintingDriverBaseID
};

/* Resource type and id for the PostScript imaging system default scanning code */
enum {
	gxPostscriptScanningType	= 'scan',
	gxPostscriptScanningID		= gxPrintingDriverBaseID
};

/* Old Application Support Resources */
enum {
	gxCustType					= 'cust',
	gxCustID					= -8192
};

enum {
	gxReslType					= 'resl',
	gxReslID					= -8192
};

enum {
	gxDiscreteResolution		= 0
};

enum {
	gxStlDialogResID			= -8192
};

enum {
	gxJobDialogResID			= -8191
};

enum {
	gxScaleTableType			= 'stab',
	gxDITLControlType			= 'dctl'
};

/*	The default implementation of gxPrintDefault loads and
	PrValidates a print record stored in the following driver resource. */
enum {
	gxPrintRecordType			= 'PREC',
	gxDefaultPrintRecordID		= 0
};

/*
	-----------------------------------------------

	Resource types and IDs used in papertype files

	-----------------------------------------------
*/
/* Resource type and ID for driver papertypes placed in individual files */
enum {
	gxSignatureType				= 'sig ',
	gxPapertypeSignatureID		= 0
};

/* Papertype creator types */
enum {
	gxDrvrPaperType				= 'drpt',
	gxSysPaperType				= 'sypt',						/* System paper type creator */
	gxUserPaperType				= 'uspt',						/* User paper type creator */
/* Driver creator types == driver file's creator value */
	gxPaperTypeType				= 'ptyp'
};

/*********************************************************************
					Start of old "GXPrintingMessages.h/a/p" interface file.
			**********************************************************************/
/* ------------------------------------------------------------------------------

									Constants and Types

-------------------------------------------------------------------------------- */
/*

	ABSTRACT DATA TYPES

*/
typedef struct gxPrivateFileRecord *gxSpoolFile;

typedef long gxPanelEvent;

/* Dialog panel event equates */

enum {
	gxPanelNoEvt				= (gxPanelEvent)0,
	gxPanelOpenEvt				= (gxPanelEvent)1,				/* Initialize and draw */
	gxPanelCloseEvt				= (gxPanelEvent)2,				/* Your panel is going away (panel switch, confirm or cancel) */
	gxPanelHitEvt				= (gxPanelEvent)3,				/* There's a hit in your panel */
	gxPanelActivateEvt			= (gxPanelEvent)4,				/* The dialog window has just been activated */
	gxPanelDeactivateEvt		= (gxPanelEvent)5,				/* The dialog window is about to be deactivated */
	gxPanelIconFocusEvt			= (gxPanelEvent)6,				/* The focus changes from the panel to the icon list */
	gxPanelPanelFocusEvt		= (gxPanelEvent)7,				/* The focus changes from the icon list to the panel */
	gxPanelFilterEvt			= (gxPanelEvent)8,				/* Every event is filtered */
	gxPanelCancelEvt			= (gxPanelEvent)9,				/* The user has cancelled the dialog */
	gxPanelConfirmEvt			= (gxPanelEvent)10,				/* The user has confirmed the dialog */
	gxPanelDialogEvt			= (gxPanelEvent)11,				/* Event to be handle by dialoghandler */
	gxPanelOtherEvt				= (gxPanelEvent)12,				/* osEvts, etc. */
	gxPanelUserWillConfirmEvt	= (gxPanelEvent)13				/* User has selected confirm, time to parse panel interdependencies */
};

/* Constants for panel responses to dialog handler calls */
typedef long gxPanelResult;


enum {
	gxPanelNoResult				= 0,
	gxPanelCancelConfirmation	= 1								/* Only valid from panelUserWillConfirmEvt - used to keep the dialog from going away */
};

/* Panel event info record for FilterPanelEvent and HandlePanelEvent messages */
struct gxPanelInfoRecord {
	gxPanelEvent					panelEvt;					/* Why we were called */
	short							panelResId;					/* 'ppnl' resource id of current panel */
	DialogPtr						pDlg;						/* Pointer to dialog */
	EventRecord						*theEvent;					/* Pointer to event */
	short							itemHit;					/* Actual item number as Dialog Mgr thinks */
	short							itemCount;					/* Number of items before your items */
	short							evtAction;					/* Once this event is processed, the action that will result */
/* (evtAction is only meaningful during filtering) */
	short							errorStringId;				/* STR id of string to put in error alert (0 means no string) */
	gxFormat						theFormat;					/* The current format (only meaningful in a format dialog) */
	void							*refCon;					/* refCon passed in PanelSetupRecord */
};
typedef struct gxPanelInfoRecord gxPanelInfoRecord;

/* Constants for the evtAction field in PanelInfoRecord */

enum {
	gxOtherAction				= 0,							/* Current item will not change */
	gxClosePanelAction			= 1,							/* Panel will be closed */
	gxCancelDialogAction		= 2,							/* Dialog will be cancelled */
	gxConfirmDialogAction		= 3								/* Dialog will be confirmed */
};

/* Constants for the panelKind field in gxPanelSetupRecord */
typedef long gxPrintingPanelKind;

/* The gxPanelSetupInfo structure is passed to GXSetupDialogPanel */
struct gxPanelSetupRecord {
	gxPrintingPanelKind				panelKind;
	short							panelResId;
	short							resourceRefNum;
	void							*refCon;
};
typedef struct gxPanelSetupRecord gxPanelSetupRecord;


enum {
	gxApplicationPanel			= (gxPrintingPanelKind)0,
	gxExtensionPanel			= (gxPrintingPanelKind)1,
	gxDriverPanel				= (gxPrintingPanelKind)2
};

/* Constants returned by gxParsePageRange message */
typedef long gxParsePageRangeResult;


enum {
	gxRangeNotParsed			= (gxParsePageRangeResult)0,	/* Default initial value */
	gxRangeParsed				= (gxParsePageRangeResult)1,	/* Range has been parsed */
	gxRangeBadFromValue			= (gxParsePageRangeResult)2,	/* From value is bad */
	gxRangeBadToValue			= (gxParsePageRangeResult)3		/* To value is bad */
};

/*

	STATUS-RELATED CONSTANTS AND TYPES

*/
/* Structure for status messages */
struct gxStatusRecord {
	unsigned short					statusType;					/* One of the ids listed above (nonFatalError, etc. ) */
	unsigned short					statusId;					/* Specific status (out of paper, etc.) */
	unsigned short					statusAlertId;				/*	Printing alert id (if any) for status */
	gxOwnerSignature				statusOwner;				/* Creator type of status owner */
	short							statResId;					/* ID for 'stat' resource */
	short							statResIndex;				/* Index into 'stat' resource for this status */
	short							dialogResult;				/* ID of button string selected on dismissal of printing alert */
	unsigned short					bufferLen;					/* Number of bytes in status buffer - total record size must be <= 512 */
	char							statusBuffer[1];			/* User response from alert */
};
typedef struct gxStatusRecord gxStatusRecord;

/* Constants for statusType field of gxStatusRecord */

enum {
	gxNonFatalError				= 1,							/* An error occurred, but the job can continue */
	gxFatalError				= 2,							/* A fatal error occurred-- halt job */
	gxPrinterReady				= 3,							/* Tells QDGX to leave alert mode */
	gxUserAttention				= 4,							/* Signals initiation of a modal alert */
	gxUserAlert					= 5,							/* Signals initiation of a moveable modal alert */
	gxPageTransmission			= 6,							/* Signals page sent to printer, increments page count in strings to user */
	gxOpenConnectionStatus		= 7,							/* Signals QDGX to begin animation on printer icon */
	gxInformationalStatus		= 8,							/* Default status type, no side effects */
	gxSpoolingPageStatus		= 9,							/* Signals page spooled, increments page count in spooling dialog */
	gxEndStatus					= 10,							/* Signals end of spooling */
	gxPercentageStatus			= 11							/* Signals QDGX as to the amount of the job which is currently complete */
};

/* Structure for gxWriteStatusToDTPWindow message */
struct gxDisplayRecord {
	Boolean							useText;					/* Use text as opposed to a picture */
	char							padByte;
	Handle							hPicture;					/* if !useText, the picture handle */
	Str255							theText;					/* if useText, the text */
};
typedef struct gxDisplayRecord gxDisplayRecord;

/*-----------------------------------------------*/
/* paper mapping-related constants and types...  */
/*-----------------------------------------------*/
typedef long gxTrayMapping;


enum {
	gxDefaultTrayMapping		= (gxTrayMapping)0,
	gxConfiguredTrayMapping		= (gxTrayMapping)1
};

/* ------------------------------------------------------------------------------

				API Functions callable only from within message overrides

-------------------------------------------------------------------------------- */
#if !GENERATINGPOWERPC
extern OSErr GXPrintingDispatch(long selector, ...)
 SIXWORDINLINE(0x221F, 0x203C, 0x0001, 0x0000, 0xABFE, 0x598F);
#endif
extern gxJob GXGetJob(void)
 FOURWORDINLINE(0x203C, 0x0001, 1, 0xABFE);
extern short GXGetMessageHandlerResFile(void)
 FOURWORDINLINE(0x203C, 0x0001, 2, 0xABFE);
extern Boolean GXSpoolingAborted(void)
 FOURWORDINLINE(0x203C, 0x0001, 3, 0xABFE);
extern OSErr GXJobIdle(void)
 FOURWORDINLINE(0x203C, 0x0001, 4, 0xABFE);
extern OSErr GXReportStatus(long statusID, unsigned long statusIndex)
 FOURWORDINLINE(0x203C, 0x0001, 5, 0xABFE);
extern OSErr GXAlertTheUser(gxStatusRecord *statusRec)
 FOURWORDINLINE(0x203C, 0x0001, 6, 0xABFE);
extern OSErr GXSetupDialogPanel(gxPanelSetupRecord *panelRec)
 FOURWORDINLINE(0x203C, 0x0001, 7, 0xABFE);
extern OSErr GXCountTrays(gxTrayIndex *numTrays)
 FOURWORDINLINE(0x203C, 0x0001, 8, 0xABFE);
extern OSErr GXGetTrayName(gxTrayIndex trayNumber, Str31 trayName)
 FOURWORDINLINE(0x203C, 0x0001, 9, 0xABFE);
extern OSErr GXSetTrayPaperType(gxTrayIndex whichTray, gxPaperType aPapertype)
 FOURWORDINLINE(0x203C, 0x0001, 10, 0xABFE);
extern OSErr GXGetTrayPaperType(gxTrayIndex whichTray, gxPaperType aPapertype)
 FOURWORDINLINE(0x203C, 0x0001, 11, 0xABFE);
extern OSErr GXGetTrayMapping(gxTrayMapping *trayMapping)
 FOURWORDINLINE(0x203C, 0x0001, 12, 0xABFE);
extern void GXCleanupStartJob(void)
 FOURWORDINLINE(0x203C, 0x0001, 13, 0xABFE);
extern void GXCleanupStartPage(void)
 FOURWORDINLINE(0x203C, 0x0001, 14, 0xABFE);
extern void GXCleanupOpenConnection(void)
 FOURWORDINLINE(0x203C, 0x0001, 15, 0xABFE);
extern void GXCleanupStartSendPage(void)
 FOURWORDINLINE(0x203C, 0x0001, 16, 0xABFE);
/* ------------------------------------------------------------------------------

					Constants and types for Universal Printing Messages

-------------------------------------------------------------------------------- */
/* Options for gxCreateSpoolFile message */

enum {
	gxNoCreateOptions			= 0x00000000,					/* Just create the file */
	gxInhibitAlias				= 0x00000001,					/* Do not create an alias in the PMD folder */
	gxInhibitUniqueName			= 0x00000002,					/* Do not append to the filename to make it unique */
	gxResolveBitmapAlias		= 0x00000004					/* Resolve bitmap aliases and duplicate data in file */
};

/* Options for gxCloseSpoolFile message */
enum {
	gxNoCloseOptions			= 0x00000000,					/* Just close the file */
	gxDeleteOnClose				= 0x00000001,					/* Delete the file rather than closing it */
	gxUpdateJobData				= 0x00000002,					/* Write current job information into file prior to closing */
	gxMakeRemoteFile			= 0x00000004					/* Mark job as a remote file */
};

/* Options for gxCreateImageFile message */
enum {
	gxNoImageFile				= 0x00000000,					/* Don't create image file */
	gxMakeImageFile				= 0x00000001,					/* Create an image file */
	gxEachPlane					= 0x00000002,					/* Only save up planes before rewinding */
	gxEachPage					= 0x00000004,					/* Save up entire pages before rewinding */
	gxEntireFile				= gxEachPlane + gxEachPage		/* Save up the entire file before rewinding */
};

/* Options for gxBufferData message */
enum {
	gxNoBufferOptions			= 0x00000000,
	gxMakeBufferHex				= 0x00000001,
	gxDontSplitBuffer			= 0x00000002
};

/* Structure for gxDumpBuffer and gxFreeBuffer messages */
struct gxPrintingBuffer {
	long							size;						/* Size of buffer in bytes */
	long							userData;					/* Client assigned id for the buffer */
	char							data[1];					/* Array of size bytes */
};
typedef struct gxPrintingBuffer gxPrintingBuffer;

/* Structure for gxRenderPage message */
struct gxPageInfoRecord {
	long							docPageNum;					/* Number of page being printed */
	long							copyNum;					/* Copy number being printed */
	Boolean							formatChanged;				/* True if format changed from last page */
	Boolean							pageChanged;				/* True if page contents changed from last page */
	long							internalUse;				/* Private */
};
typedef struct gxPageInfoRecord gxPageInfoRecord;

/* ------------------------------------------------------------------------------

								Universal Printing Messages

-------------------------------------------------------------------------------- */
#define Send_GXFetchTaggedDriverData(tag, id, pHandle) Send_GXFetchTaggedData(tag, id, pHandle, 'drvr')
#define Forward_GXFetchTaggedDriverData(tag, id, pHandle) Forward_GXFetchTaggedData(tag, id, pHandle, 'drvr')
typedef OSErr (*GXJobIdleProcPtr)(void);

#if GENERATINGCFM
typedef UniversalProcPtr GXJobIdleUPP;
#else
typedef GXJobIdleProcPtr GXJobIdleUPP;
#endif

enum {
	uppGXJobIdleProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
};

#if GENERATINGCFM
#define NewGXJobIdleProc(userRoutine)		\
		(GXJobIdleUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXJobIdleProcInfo, GetCurrentArchitecture())
#else
#define NewGXJobIdleProc(userRoutine)		\
		((GXJobIdleUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXJobIdleProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXJobIdleProcInfo)
#else
#define CallGXJobIdleProc(userRoutine)		\
		(*(userRoutine))()
#endif

typedef GXJobIdleProcPtr GXJobIdleProc;

extern OSErr Send_GXJobIdle(void)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 2, 0xABFB);
extern OSErr Forward_GXJobIdle(void)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXJobStatusProcPtr)(gxStatusRecord *pStatus);

#if GENERATINGCFM
typedef UniversalProcPtr GXJobStatusUPP;
#else
typedef GXJobStatusProcPtr GXJobStatusUPP;
#endif

enum {
	uppGXJobStatusProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxStatusRecord*)))
};

#if GENERATINGCFM
#define NewGXJobStatusProc(userRoutine)		\
		(GXJobStatusUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXJobStatusProcInfo, GetCurrentArchitecture())
#else
#define NewGXJobStatusProc(userRoutine)		\
		((GXJobStatusUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXJobStatusProc(userRoutine, pStatus)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXJobStatusProcInfo, (pStatus))
#else
#define CallGXJobStatusProc(userRoutine, pStatus)		\
		(*(userRoutine))((pStatus))
#endif

typedef GXJobStatusProcPtr GXJobStatusProc;

extern OSErr Send_GXJobStatus(gxStatusRecord *pStatus)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 3, 0xABFB);
extern OSErr Forward_GXJobStatus(gxStatusRecord *pStatus)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXPrintingEventProcPtr)(EventRecord *evtRecord, Boolean filterEvent);

#if GENERATINGCFM
typedef UniversalProcPtr GXPrintingEventUPP;
#else
typedef GXPrintingEventProcPtr GXPrintingEventUPP;
#endif

enum {
	uppGXPrintingEventProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(EventRecord*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Boolean)))
};

#if GENERATINGCFM
#define NewGXPrintingEventProc(userRoutine)		\
		(GXPrintingEventUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXPrintingEventProcInfo, GetCurrentArchitecture())
#else
#define NewGXPrintingEventProc(userRoutine)		\
		((GXPrintingEventUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXPrintingEventProc(userRoutine, evtRecord, filterEvent)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXPrintingEventProcInfo, (evtRecord), (filterEvent))
#else
#define CallGXPrintingEventProc(userRoutine, evtRecord, filterEvent)		\
		(*(userRoutine))((evtRecord), (filterEvent))
#endif

typedef GXPrintingEventProcPtr GXPrintingEventProc;

extern OSErr Send_GXPrintingEvent(EventRecord *evtRecord, Boolean filterEvent)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 4, 0xABFB);
extern OSErr Forward_GXPrintingEvent(EventRecord *evtRecord, Boolean filterEvent)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXJobDefaultFormatDialogProcPtr)(gxDialogResult *dlgResult);

#if GENERATINGCFM
typedef UniversalProcPtr GXJobDefaultFormatDialogUPP;
#else
typedef GXJobDefaultFormatDialogProcPtr GXJobDefaultFormatDialogUPP;
#endif

enum {
	uppGXJobDefaultFormatDialogProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxDialogResult*)))
};

#if GENERATINGCFM
#define NewGXJobDefaultFormatDialogProc(userRoutine)		\
		(GXJobDefaultFormatDialogUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXJobDefaultFormatDialogProcInfo, GetCurrentArchitecture())
#else
#define NewGXJobDefaultFormatDialogProc(userRoutine)		\
		((GXJobDefaultFormatDialogUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXJobDefaultFormatDialogProc(userRoutine, dlgResult)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXJobDefaultFormatDialogProcInfo, (dlgResult))
#else
#define CallGXJobDefaultFormatDialogProc(userRoutine, dlgResult)		\
		(*(userRoutine))((dlgResult))
#endif

typedef GXJobDefaultFormatDialogProcPtr GXJobDefaultFormatDialogProc;

extern OSErr Send_GXJobDefaultFormatDialog(gxDialogResult *dlgResult)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 5, 0xABFB);
extern OSErr Forward_GXJobDefaultFormatDialog(gxDialogResult *dlgResult)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXFormatDialogProcPtr)(gxFormat theFormat, StringPtr title, gxDialogResult *dlgResult);

#if GENERATINGCFM
typedef UniversalProcPtr GXFormatDialogUPP;
#else
typedef GXFormatDialogProcPtr GXFormatDialogUPP;
#endif

enum {
	uppGXFormatDialogProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxFormat)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(StringPtr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(gxDialogResult*)))
};

#if GENERATINGCFM
#define NewGXFormatDialogProc(userRoutine)		\
		(GXFormatDialogUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXFormatDialogProcInfo, GetCurrentArchitecture())
#else
#define NewGXFormatDialogProc(userRoutine)		\
		((GXFormatDialogUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXFormatDialogProc(userRoutine, theFormat, title, dlgResult)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXFormatDialogProcInfo, (theFormat), (title), (dlgResult))
#else
#define CallGXFormatDialogProc(userRoutine, theFormat, title, dlgResult)		\
		(*(userRoutine))((theFormat), (title), (dlgResult))
#endif

typedef GXFormatDialogProcPtr GXFormatDialogProc;

extern OSErr Send_GXFormatDialog(gxFormat theFormat, StringPtr title, gxDialogResult *dlgResult)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 6, 0xABFB);
extern OSErr Forward_GXFormatDialog(gxFormat theFormat, StringPtr title, gxDialogResult *dlgResult)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXJobPrintDialogProcPtr)(gxDialogResult *dlgResult);

#if GENERATINGCFM
typedef UniversalProcPtr GXJobPrintDialogUPP;
#else
typedef GXJobPrintDialogProcPtr GXJobPrintDialogUPP;
#endif

enum {
	uppGXJobPrintDialogProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxDialogResult*)))
};

#if GENERATINGCFM
#define NewGXJobPrintDialogProc(userRoutine)		\
		(GXJobPrintDialogUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXJobPrintDialogProcInfo, GetCurrentArchitecture())
#else
#define NewGXJobPrintDialogProc(userRoutine)		\
		((GXJobPrintDialogUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXJobPrintDialogProc(userRoutine, dlgResult)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXJobPrintDialogProcInfo, (dlgResult))
#else
#define CallGXJobPrintDialogProc(userRoutine, dlgResult)		\
		(*(userRoutine))((dlgResult))
#endif

typedef GXJobPrintDialogProcPtr GXJobPrintDialogProc;

extern OSErr Send_GXJobPrintDialog(gxDialogResult *dlgResult)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 7, 0xABFB);
extern OSErr Forward_GXJobPrintDialog(gxDialogResult *dlgResult)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXFilterPanelEventProcPtr)(gxPanelInfoRecord *pHitInfo, Boolean *returnImmed);

#if GENERATINGCFM
typedef UniversalProcPtr GXFilterPanelEventUPP;
#else
typedef GXFilterPanelEventProcPtr GXFilterPanelEventUPP;
#endif

enum {
	uppGXFilterPanelEventProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxPanelInfoRecord*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Boolean*)))
};

#if GENERATINGCFM
#define NewGXFilterPanelEventProc(userRoutine)		\
		(GXFilterPanelEventUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXFilterPanelEventProcInfo, GetCurrentArchitecture())
#else
#define NewGXFilterPanelEventProc(userRoutine)		\
		((GXFilterPanelEventUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXFilterPanelEventProc(userRoutine, pHitInfo, returnImmed)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXFilterPanelEventProcInfo, (pHitInfo), (returnImmed))
#else
#define CallGXFilterPanelEventProc(userRoutine, pHitInfo, returnImmed)		\
		(*(userRoutine))((pHitInfo), (returnImmed))
#endif

typedef GXFilterPanelEventProcPtr GXFilterPanelEventProc;

extern OSErr Send_GXFilterPanelEvent(gxPanelInfoRecord *pHitInfo, Boolean *returnImmed)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 8, 0xABFB);
typedef OSErr (*GXHandlePanelEventProcPtr)(gxPanelInfoRecord *pHitInfo, gxPanelResult *panelResponse);

#if GENERATINGCFM
typedef UniversalProcPtr GXHandlePanelEventUPP;
#else
typedef GXHandlePanelEventProcPtr GXHandlePanelEventUPP;
#endif

enum {
	uppGXHandlePanelEventProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxPanelInfoRecord*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(gxPanelResult*)))
};

#if GENERATINGCFM
#define NewGXHandlePanelEventProc(userRoutine)		\
		(GXHandlePanelEventUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXHandlePanelEventProcInfo, GetCurrentArchitecture())
#else
#define NewGXHandlePanelEventProc(userRoutine)		\
		((GXHandlePanelEventUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXHandlePanelEventProc(userRoutine, pHitInfo, panelResponse)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXHandlePanelEventProcInfo, (pHitInfo), (panelResponse))
#else
#define CallGXHandlePanelEventProc(userRoutine, pHitInfo, panelResponse)		\
		(*(userRoutine))((pHitInfo), (panelResponse))
#endif

typedef GXHandlePanelEventProcPtr GXHandlePanelEventProc;

extern OSErr Send_GXHandlePanelEvent(gxPanelInfoRecord *pHitInfo, gxPanelResult *panelResponse)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 9, 0xABFB);
typedef OSErr (*GXParsePageRangeProcPtr)(StringPtr fromString, StringPtr toString, gxParsePageRangeResult *result);

#if GENERATINGCFM
typedef UniversalProcPtr GXParsePageRangeUPP;
#else
typedef GXParsePageRangeProcPtr GXParsePageRangeUPP;
#endif

enum {
	uppGXParsePageRangeProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(StringPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(StringPtr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(gxParsePageRangeResult*)))
};

#if GENERATINGCFM
#define NewGXParsePageRangeProc(userRoutine)		\
		(GXParsePageRangeUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXParsePageRangeProcInfo, GetCurrentArchitecture())
#else
#define NewGXParsePageRangeProc(userRoutine)		\
		((GXParsePageRangeUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXParsePageRangeProc(userRoutine, fromString, toString, result)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXParsePageRangeProcInfo, (fromString), (toString), (result))
#else
#define CallGXParsePageRangeProc(userRoutine, fromString, toString, result)		\
		(*(userRoutine))((fromString), (toString), (result))
#endif

typedef GXParsePageRangeProcPtr GXParsePageRangeProc;

extern OSErr Send_GXParsePageRange(StringPtr fromString, StringPtr toString, gxParsePageRangeResult *result)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 10, 0xABFB);
extern OSErr Forward_GXParsePageRange(StringPtr fromString, StringPtr toString, gxParsePageRangeResult *result)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXDefaultJobProcPtr)(void);

#if GENERATINGCFM
typedef UniversalProcPtr GXDefaultJobUPP;
#else
typedef GXDefaultJobProcPtr GXDefaultJobUPP;
#endif

enum {
	uppGXDefaultJobProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
};

#if GENERATINGCFM
#define NewGXDefaultJobProc(userRoutine)		\
		(GXDefaultJobUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXDefaultJobProcInfo, GetCurrentArchitecture())
#else
#define NewGXDefaultJobProc(userRoutine)		\
		((GXDefaultJobUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXDefaultJobProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXDefaultJobProcInfo)
#else
#define CallGXDefaultJobProc(userRoutine)		\
		(*(userRoutine))()
#endif

typedef GXDefaultJobProcPtr GXDefaultJobProc;

extern OSErr Send_GXDefaultJob(void)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 11, 0xABFB);
extern OSErr Forward_GXDefaultJob(void)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXDefaultFormatProcPtr)(gxFormat theFormat);

#if GENERATINGCFM
typedef UniversalProcPtr GXDefaultFormatUPP;
#else
typedef GXDefaultFormatProcPtr GXDefaultFormatUPP;
#endif

enum {
	uppGXDefaultFormatProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxFormat)))
};

#if GENERATINGCFM
#define NewGXDefaultFormatProc(userRoutine)		\
		(GXDefaultFormatUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXDefaultFormatProcInfo, GetCurrentArchitecture())
#else
#define NewGXDefaultFormatProc(userRoutine)		\
		((GXDefaultFormatUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXDefaultFormatProc(userRoutine, theFormat)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXDefaultFormatProcInfo, (theFormat))
#else
#define CallGXDefaultFormatProc(userRoutine, theFormat)		\
		(*(userRoutine))((theFormat))
#endif

typedef GXDefaultFormatProcPtr GXDefaultFormatProc;

extern OSErr Send_GXDefaultFormat(gxFormat theFormat)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 12, 0xABFB);
extern OSErr Forward_GXDefaultFormat(gxFormat theFormat)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXDefaultPaperTypeProcPtr)(gxPaperType thePaperType);

#if GENERATINGCFM
typedef UniversalProcPtr GXDefaultPaperTypeUPP;
#else
typedef GXDefaultPaperTypeProcPtr GXDefaultPaperTypeUPP;
#endif

enum {
	uppGXDefaultPaperTypeProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxPaperType)))
};

#if GENERATINGCFM
#define NewGXDefaultPaperTypeProc(userRoutine)		\
		(GXDefaultPaperTypeUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXDefaultPaperTypeProcInfo, GetCurrentArchitecture())
#else
#define NewGXDefaultPaperTypeProc(userRoutine)		\
		((GXDefaultPaperTypeUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXDefaultPaperTypeProc(userRoutine, thePaperType)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXDefaultPaperTypeProcInfo, (thePaperType))
#else
#define CallGXDefaultPaperTypeProc(userRoutine, thePaperType)		\
		(*(userRoutine))((thePaperType))
#endif

typedef GXDefaultPaperTypeProcPtr GXDefaultPaperTypeProc;

extern OSErr Send_GXDefaultPaperType(gxPaperType thePaperType)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 13, 0xABFB);
extern OSErr Forward_GXDefaultPaperType(gxPaperType thePaperType)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXDefaultPrinterProcPtr)(gxPrinter thePrinter);

#if GENERATINGCFM
typedef UniversalProcPtr GXDefaultPrinterUPP;
#else
typedef GXDefaultPrinterProcPtr GXDefaultPrinterUPP;
#endif

enum {
	uppGXDefaultPrinterProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxPrinter)))
};

#if GENERATINGCFM
#define NewGXDefaultPrinterProc(userRoutine)		\
		(GXDefaultPrinterUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXDefaultPrinterProcInfo, GetCurrentArchitecture())
#else
#define NewGXDefaultPrinterProc(userRoutine)		\
		((GXDefaultPrinterUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXDefaultPrinterProc(userRoutine, thePrinter)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXDefaultPrinterProcInfo, (thePrinter))
#else
#define CallGXDefaultPrinterProc(userRoutine, thePrinter)		\
		(*(userRoutine))((thePrinter))
#endif

typedef GXDefaultPrinterProcPtr GXDefaultPrinterProc;

extern OSErr Send_GXDefaultPrinter(gxPrinter thePrinter)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 14, 0xABFB);
extern OSErr Forward_GXDefaultPrinter(gxPrinter thePrinter)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXCreateSpoolFileProcPtr)(FSSpecPtr pFileSpec, long createOptions, gxSpoolFile *theSpoolFile);

#if GENERATINGCFM
typedef UniversalProcPtr GXCreateSpoolFileUPP;
#else
typedef GXCreateSpoolFileProcPtr GXCreateSpoolFileUPP;
#endif

enum {
	uppGXCreateSpoolFileProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(FSSpecPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(gxSpoolFile*)))
};

#if GENERATINGCFM
#define NewGXCreateSpoolFileProc(userRoutine)		\
		(GXCreateSpoolFileUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXCreateSpoolFileProcInfo, GetCurrentArchitecture())
#else
#define NewGXCreateSpoolFileProc(userRoutine)		\
		((GXCreateSpoolFileUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXCreateSpoolFileProc(userRoutine, pFileSpec, createOptions, theSpoolFile)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXCreateSpoolFileProcInfo, (pFileSpec), (createOptions), (theSpoolFile))
#else
#define CallGXCreateSpoolFileProc(userRoutine, pFileSpec, createOptions, theSpoolFile)		\
		(*(userRoutine))((pFileSpec), (createOptions), (theSpoolFile))
#endif

typedef GXCreateSpoolFileProcPtr GXCreateSpoolFileProc;

extern OSErr Send_GXCreateSpoolFile(FSSpecPtr pFileSpec, long createOptions, gxSpoolFile *theSpoolFile)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 15, 0xABFB);
extern OSErr Forward_GXCreateSpoolFile(FSSpecPtr pFileSpec, long createOptions, gxSpoolFile *theSpoolFile)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXSpoolPageProcPtr)(gxSpoolFile theSpoolFile, gxFormat theFormat, gxShape thePage);

#if GENERATINGCFM
typedef UniversalProcPtr GXSpoolPageUPP;
#else
typedef GXSpoolPageProcPtr GXSpoolPageUPP;
#endif

enum {
	uppGXSpoolPageProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxSpoolFile)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(gxFormat)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(gxShape)))
};

#if GENERATINGCFM
#define NewGXSpoolPageProc(userRoutine)		\
		(GXSpoolPageUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXSpoolPageProcInfo, GetCurrentArchitecture())
#else
#define NewGXSpoolPageProc(userRoutine)		\
		((GXSpoolPageUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXSpoolPageProc(userRoutine, theSpoolFile, theFormat, thePage)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXSpoolPageProcInfo, (theSpoolFile), (theFormat), (thePage))
#else
#define CallGXSpoolPageProc(userRoutine, theSpoolFile, theFormat, thePage)		\
		(*(userRoutine))((theSpoolFile), (theFormat), (thePage))
#endif

typedef GXSpoolPageProcPtr GXSpoolPageProc;

extern OSErr Send_GXSpoolPage(gxSpoolFile theSpoolFile, gxFormat theFormat, gxShape thePage)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 16, 0xABFB);
extern OSErr Forward_GXSpoolPage(gxSpoolFile theSpoolFile, gxFormat theFormat, gxShape thePage)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXSpoolDataProcPtr)(gxSpoolFile theSpoolFile, Ptr data, long *length);

#if GENERATINGCFM
typedef UniversalProcPtr GXSpoolDataUPP;
#else
typedef GXSpoolDataProcPtr GXSpoolDataUPP;
#endif

enum {
	uppGXSpoolDataProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxSpoolFile)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long*)))
};

#if GENERATINGCFM
#define NewGXSpoolDataProc(userRoutine)		\
		(GXSpoolDataUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXSpoolDataProcInfo, GetCurrentArchitecture())
#else
#define NewGXSpoolDataProc(userRoutine)		\
		((GXSpoolDataUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXSpoolDataProc(userRoutine, theSpoolFile, data, length)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXSpoolDataProcInfo, (theSpoolFile), (data), (length))
#else
#define CallGXSpoolDataProc(userRoutine, theSpoolFile, data, length)		\
		(*(userRoutine))((theSpoolFile), (data), (length))
#endif

typedef GXSpoolDataProcPtr GXSpoolDataProc;

extern OSErr Send_GXSpoolData(gxSpoolFile theSpoolFile, Ptr data, long *length)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 17, 0xABFB);
extern OSErr Forward_GXSpoolData(gxSpoolFile theSpoolFile, Ptr data, long *length)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXSpoolResourceProcPtr)(gxSpoolFile theSpoolFile, Handle theResource, ResType theType, long id);

#if GENERATINGCFM
typedef UniversalProcPtr GXSpoolResourceUPP;
#else
typedef GXSpoolResourceProcPtr GXSpoolResourceUPP;
#endif

enum {
	uppGXSpoolResourceProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxSpoolFile)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Handle)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(ResType)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewGXSpoolResourceProc(userRoutine)		\
		(GXSpoolResourceUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXSpoolResourceProcInfo, GetCurrentArchitecture())
#else
#define NewGXSpoolResourceProc(userRoutine)		\
		((GXSpoolResourceUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXSpoolResourceProc(userRoutine, theSpoolFile, theResource, theType, id)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXSpoolResourceProcInfo, (theSpoolFile), (theResource), (theType), (id))
#else
#define CallGXSpoolResourceProc(userRoutine, theSpoolFile, theResource, theType, id)		\
		(*(userRoutine))((theSpoolFile), (theResource), (theType), (id))
#endif

typedef GXSpoolResourceProcPtr GXSpoolResourceProc;

extern OSErr Send_GXSpoolResource(gxSpoolFile theSpoolFile, Handle theResource, ResType theType, long id)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 18, 0xABFB);
extern OSErr Forward_GXSpoolResource(gxSpoolFile theSpoolFile, Handle theResource, ResType theType, long id)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXCompleteSpoolFileProcPtr)(gxSpoolFile theSpoolFile);

#if GENERATINGCFM
typedef UniversalProcPtr GXCompleteSpoolFileUPP;
#else
typedef GXCompleteSpoolFileProcPtr GXCompleteSpoolFileUPP;
#endif

enum {
	uppGXCompleteSpoolFileProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxSpoolFile)))
};

#if GENERATINGCFM
#define NewGXCompleteSpoolFileProc(userRoutine)		\
		(GXCompleteSpoolFileUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXCompleteSpoolFileProcInfo, GetCurrentArchitecture())
#else
#define NewGXCompleteSpoolFileProc(userRoutine)		\
		((GXCompleteSpoolFileUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXCompleteSpoolFileProc(userRoutine, theSpoolFile)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXCompleteSpoolFileProcInfo, (theSpoolFile))
#else
#define CallGXCompleteSpoolFileProc(userRoutine, theSpoolFile)		\
		(*(userRoutine))((theSpoolFile))
#endif

typedef GXCompleteSpoolFileProcPtr GXCompleteSpoolFileProc;

extern OSErr Send_GXCompleteSpoolFile(gxSpoolFile theSpoolFile)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 19, 0xABFB);
extern OSErr Forward_GXCompleteSpoolFile(gxSpoolFile theSpoolFile)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXCountPagesProcPtr)(gxSpoolFile theSpoolFile, long *numPages);

#if GENERATINGCFM
typedef UniversalProcPtr GXCountPagesUPP;
#else
typedef GXCountPagesProcPtr GXCountPagesUPP;
#endif

enum {
	uppGXCountPagesProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxSpoolFile)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long*)))
};

#if GENERATINGCFM
#define NewGXCountPagesProc(userRoutine)		\
		(GXCountPagesUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXCountPagesProcInfo, GetCurrentArchitecture())
#else
#define NewGXCountPagesProc(userRoutine)		\
		((GXCountPagesUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXCountPagesProc(userRoutine, theSpoolFile, numPages)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXCountPagesProcInfo, (theSpoolFile), (numPages))
#else
#define CallGXCountPagesProc(userRoutine, theSpoolFile, numPages)		\
		(*(userRoutine))((theSpoolFile), (numPages))
#endif

typedef GXCountPagesProcPtr GXCountPagesProc;

extern OSErr Send_GXCountPages(gxSpoolFile theSpoolFile, long *numPages)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 20, 0xABFB);
extern OSErr Forward_GXCountPages(gxSpoolFile theSpoolFile, long *numPages)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXDespoolPageProcPtr)(gxSpoolFile theSpoolFile, long numPages, gxFormat theFormat, gxShape *thePage, Boolean *formatChanged);

#if GENERATINGCFM
typedef UniversalProcPtr GXDespoolPageUPP;
#else
typedef GXDespoolPageProcPtr GXDespoolPageUPP;
#endif

enum {
	uppGXDespoolPageProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxSpoolFile)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(gxFormat)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(gxShape*)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(Boolean*)))
};

#if GENERATINGCFM
#define NewGXDespoolPageProc(userRoutine)		\
		(GXDespoolPageUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXDespoolPageProcInfo, GetCurrentArchitecture())
#else
#define NewGXDespoolPageProc(userRoutine)		\
		((GXDespoolPageUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXDespoolPageProc(userRoutine, theSpoolFile, numPages, theFormat, thePage, formatChanged)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXDespoolPageProcInfo, (theSpoolFile), (numPages), (theFormat), (thePage), (formatChanged))
#else
#define CallGXDespoolPageProc(userRoutine, theSpoolFile, numPages, theFormat, thePage, formatChanged)		\
		(*(userRoutine))((theSpoolFile), (numPages), (theFormat), (thePage), (formatChanged))
#endif

typedef GXDespoolPageProcPtr GXDespoolPageProc;

extern OSErr Send_GXDespoolPage(gxSpoolFile theSpoolFile, long numPages, gxFormat theFormat, gxShape *thePage, Boolean *formatChanged)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 21, 0xABFB);
extern OSErr Forward_GXDespoolPage(gxSpoolFile theSpoolFile, long numPages, gxFormat theFormat, gxShape *thePage, Boolean *formatChanged)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXDespoolDataProcPtr)(gxSpoolFile theSpoolFile, Ptr data, long *length);

#if GENERATINGCFM
typedef UniversalProcPtr GXDespoolDataUPP;
#else
typedef GXDespoolDataProcPtr GXDespoolDataUPP;
#endif

enum {
	uppGXDespoolDataProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxSpoolFile)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long*)))
};

#if GENERATINGCFM
#define NewGXDespoolDataProc(userRoutine)		\
		(GXDespoolDataUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXDespoolDataProcInfo, GetCurrentArchitecture())
#else
#define NewGXDespoolDataProc(userRoutine)		\
		((GXDespoolDataUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXDespoolDataProc(userRoutine, theSpoolFile, data, length)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXDespoolDataProcInfo, (theSpoolFile), (data), (length))
#else
#define CallGXDespoolDataProc(userRoutine, theSpoolFile, data, length)		\
		(*(userRoutine))((theSpoolFile), (data), (length))
#endif

typedef GXDespoolDataProcPtr GXDespoolDataProc;

extern OSErr Send_GXDespoolData(gxSpoolFile theSpoolFile, Ptr data, long *length)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 22, 0xABFB);
extern OSErr Forward_GXDespoolData(gxSpoolFile theSpoolFile, Ptr data, long *length)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXDespoolResourceProcPtr)(gxSpoolFile theSpoolFile, ResType theType, long id, Handle *theResource);

#if GENERATINGCFM
typedef UniversalProcPtr GXDespoolResourceUPP;
#else
typedef GXDespoolResourceProcPtr GXDespoolResourceUPP;
#endif

enum {
	uppGXDespoolResourceProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxSpoolFile)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(ResType)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(Handle*)))
};

#if GENERATINGCFM
#define NewGXDespoolResourceProc(userRoutine)		\
		(GXDespoolResourceUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXDespoolResourceProcInfo, GetCurrentArchitecture())
#else
#define NewGXDespoolResourceProc(userRoutine)		\
		((GXDespoolResourceUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXDespoolResourceProc(userRoutine, theSpoolFile, theType, id, theResource)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXDespoolResourceProcInfo, (theSpoolFile), (theType), (id), (theResource))
#else
#define CallGXDespoolResourceProc(userRoutine, theSpoolFile, theType, id, theResource)		\
		(*(userRoutine))((theSpoolFile), (theType), (id), (theResource))
#endif

typedef GXDespoolResourceProcPtr GXDespoolResourceProc;

extern OSErr Send_GXDespoolResource(gxSpoolFile theSpoolFile, ResType theType, long id, Handle *theResource)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 23, 0xABFB);
extern OSErr Forward_GXDespoolResource(gxSpoolFile theSpoolFile, ResType theType, long id, Handle *theResource)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXCloseSpoolFileProcPtr)(gxSpoolFile theSpoolFile, long closeOptions);

#if GENERATINGCFM
typedef UniversalProcPtr GXCloseSpoolFileUPP;
#else
typedef GXCloseSpoolFileProcPtr GXCloseSpoolFileUPP;
#endif

enum {
	uppGXCloseSpoolFileProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxSpoolFile)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewGXCloseSpoolFileProc(userRoutine)		\
		(GXCloseSpoolFileUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXCloseSpoolFileProcInfo, GetCurrentArchitecture())
#else
#define NewGXCloseSpoolFileProc(userRoutine)		\
		((GXCloseSpoolFileUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXCloseSpoolFileProc(userRoutine, theSpoolFile, closeOptions)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXCloseSpoolFileProcInfo, (theSpoolFile), (closeOptions))
#else
#define CallGXCloseSpoolFileProc(userRoutine, theSpoolFile, closeOptions)		\
		(*(userRoutine))((theSpoolFile), (closeOptions))
#endif

typedef GXCloseSpoolFileProcPtr GXCloseSpoolFileProc;

extern OSErr Send_GXCloseSpoolFile(gxSpoolFile theSpoolFile, long closeOptions)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 24, 0xABFB);
extern OSErr Forward_GXCloseSpoolFile(gxSpoolFile theSpoolFile, long closeOptions)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXStartJobProcPtr)(StringPtr docName, long pageCount);

#if GENERATINGCFM
typedef UniversalProcPtr GXStartJobUPP;
#else
typedef GXStartJobProcPtr GXStartJobUPP;
#endif

enum {
	uppGXStartJobProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(StringPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewGXStartJobProc(userRoutine)		\
		(GXStartJobUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXStartJobProcInfo, GetCurrentArchitecture())
#else
#define NewGXStartJobProc(userRoutine)		\
		((GXStartJobUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXStartJobProc(userRoutine, docName, pageCount)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXStartJobProcInfo, (docName), (pageCount))
#else
#define CallGXStartJobProc(userRoutine, docName, pageCount)		\
		(*(userRoutine))((docName), (pageCount))
#endif

typedef GXStartJobProcPtr GXStartJobProc;

extern OSErr Send_GXStartJob(StringPtr docName, long pageCount)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 25, 0xABFB);
extern OSErr Forward_GXStartJob(StringPtr docName, long pageCount)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXFinishJobProcPtr)(void);

#if GENERATINGCFM
typedef UniversalProcPtr GXFinishJobUPP;
#else
typedef GXFinishJobProcPtr GXFinishJobUPP;
#endif

enum {
	uppGXFinishJobProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
};

#if GENERATINGCFM
#define NewGXFinishJobProc(userRoutine)		\
		(GXFinishJobUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXFinishJobProcInfo, GetCurrentArchitecture())
#else
#define NewGXFinishJobProc(userRoutine)		\
		((GXFinishJobUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXFinishJobProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXFinishJobProcInfo)
#else
#define CallGXFinishJobProc(userRoutine)		\
		(*(userRoutine))()
#endif

typedef GXFinishJobProcPtr GXFinishJobProc;

extern OSErr Send_GXFinishJob(void)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 26, 0xABFB);
extern OSErr Forward_GXFinishJob(void)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXStartPageProcPtr)(gxFormat theFormat, long numViewPorts, gxViewPort *viewPortList);

#if GENERATINGCFM
typedef UniversalProcPtr GXStartPageUPP;
#else
typedef GXStartPageProcPtr GXStartPageUPP;
#endif

enum {
	uppGXStartPageProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxFormat)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(gxViewPort*)))
};

#if GENERATINGCFM
#define NewGXStartPageProc(userRoutine)		\
		(GXStartPageUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXStartPageProcInfo, GetCurrentArchitecture())
#else
#define NewGXStartPageProc(userRoutine)		\
		((GXStartPageUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXStartPageProc(userRoutine, theFormat, numViewPorts, viewPortList)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXStartPageProcInfo, (theFormat), (numViewPorts), (viewPortList))
#else
#define CallGXStartPageProc(userRoutine, theFormat, numViewPorts, viewPortList)		\
		(*(userRoutine))((theFormat), (numViewPorts), (viewPortList))
#endif

typedef GXStartPageProcPtr GXStartPageProc;

extern OSErr Send_GXStartPage(gxFormat theFormat, long numViewPorts, gxViewPort *viewPortList)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 27, 0xABFB);
extern OSErr Forward_GXStartPage(gxFormat theFormat, long numViewPorts, gxViewPort *viewPortList)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXFinishPageProcPtr)(void);

#if GENERATINGCFM
typedef UniversalProcPtr GXFinishPageUPP;
#else
typedef GXFinishPageProcPtr GXFinishPageUPP;
#endif

enum {
	uppGXFinishPageProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
};

#if GENERATINGCFM
#define NewGXFinishPageProc(userRoutine)		\
		(GXFinishPageUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXFinishPageProcInfo, GetCurrentArchitecture())
#else
#define NewGXFinishPageProc(userRoutine)		\
		((GXFinishPageUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXFinishPageProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXFinishPageProcInfo)
#else
#define CallGXFinishPageProc(userRoutine)		\
		(*(userRoutine))()
#endif

typedef GXFinishPageProcPtr GXFinishPageProc;

extern OSErr Send_GXFinishPage(void)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 28, 0xABFB);
extern OSErr Forward_GXFinishPage(void)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXPrintPageProcPtr)(gxFormat theFormat, gxShape thePage);

#if GENERATINGCFM
typedef UniversalProcPtr GXPrintPageUPP;
#else
typedef GXPrintPageProcPtr GXPrintPageUPP;
#endif

enum {
	uppGXPrintPageProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxFormat)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(gxShape)))
};

#if GENERATINGCFM
#define NewGXPrintPageProc(userRoutine)		\
		(GXPrintPageUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXPrintPageProcInfo, GetCurrentArchitecture())
#else
#define NewGXPrintPageProc(userRoutine)		\
		((GXPrintPageUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXPrintPageProc(userRoutine, theFormat, thePage)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXPrintPageProcInfo, (theFormat), (thePage))
#else
#define CallGXPrintPageProc(userRoutine, theFormat, thePage)		\
		(*(userRoutine))((theFormat), (thePage))
#endif

typedef GXPrintPageProcPtr GXPrintPageProc;

extern OSErr Send_GXPrintPage(gxFormat theFormat, gxShape thePage)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 29, 0xABFB);
extern OSErr Forward_GXPrintPage(gxFormat theFormat, gxShape thePage)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXSetupImageDataProcPtr)(void *imageData);

#if GENERATINGCFM
typedef UniversalProcPtr GXSetupImageDataUPP;
#else
typedef GXSetupImageDataProcPtr GXSetupImageDataUPP;
#endif

enum {
	uppGXSetupImageDataProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewGXSetupImageDataProc(userRoutine)		\
		(GXSetupImageDataUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXSetupImageDataProcInfo, GetCurrentArchitecture())
#else
#define NewGXSetupImageDataProc(userRoutine)		\
		((GXSetupImageDataUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXSetupImageDataProc(userRoutine, imageData)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXSetupImageDataProcInfo, (imageData))
#else
#define CallGXSetupImageDataProc(userRoutine, imageData)		\
		(*(userRoutine))((imageData))
#endif

typedef GXSetupImageDataProcPtr GXSetupImageDataProc;

extern OSErr Send_GXSetupImageData(void *imageData)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 30, 0xABFB);
extern OSErr Forward_GXSetupImageData(void *imageData)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXImageJobProcPtr)(gxSpoolFile theSpoolFile, long *closeOptions);

#if GENERATINGCFM
typedef UniversalProcPtr GXImageJobUPP;
#else
typedef GXImageJobProcPtr GXImageJobUPP;
#endif

enum {
	uppGXImageJobProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxSpoolFile)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long*)))
};

#if GENERATINGCFM
#define NewGXImageJobProc(userRoutine)		\
		(GXImageJobUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXImageJobProcInfo, GetCurrentArchitecture())
#else
#define NewGXImageJobProc(userRoutine)		\
		((GXImageJobUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXImageJobProc(userRoutine, theSpoolFile, closeOptions)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXImageJobProcInfo, (theSpoolFile), (closeOptions))
#else
#define CallGXImageJobProc(userRoutine, theSpoolFile, closeOptions)		\
		(*(userRoutine))((theSpoolFile), (closeOptions))
#endif

typedef GXImageJobProcPtr GXImageJobProc;

extern OSErr Send_GXImageJob(gxSpoolFile theSpoolFile, long *closeOptions)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 31, 0xABFB);
extern OSErr Forward_GXImageJob(gxSpoolFile theSpoolFile, long *closeOptions)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXImageDocumentProcPtr)(gxSpoolFile theSpoolFile, void *imageData);

#if GENERATINGCFM
typedef UniversalProcPtr GXImageDocumentUPP;
#else
typedef GXImageDocumentProcPtr GXImageDocumentUPP;
#endif

enum {
	uppGXImageDocumentProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxSpoolFile)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewGXImageDocumentProc(userRoutine)		\
		(GXImageDocumentUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXImageDocumentProcInfo, GetCurrentArchitecture())
#else
#define NewGXImageDocumentProc(userRoutine)		\
		((GXImageDocumentUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXImageDocumentProc(userRoutine, theSpoolFile, imageData)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXImageDocumentProcInfo, (theSpoolFile), (imageData))
#else
#define CallGXImageDocumentProc(userRoutine, theSpoolFile, imageData)		\
		(*(userRoutine))((theSpoolFile), (imageData))
#endif

typedef GXImageDocumentProcPtr GXImageDocumentProc;

extern OSErr Send_GXImageDocument(gxSpoolFile theSpoolFile, void *imageData)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 32, 0xABFB);
extern OSErr Forward_GXImageDocument(gxSpoolFile theSpoolFile, void *imageData)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXImagePageProcPtr)(gxSpoolFile theSpoolFile, long pageNumber, gxFormat theFormat, void *imageData);

#if GENERATINGCFM
typedef UniversalProcPtr GXImagePageUPP;
#else
typedef GXImagePageProcPtr GXImagePageUPP;
#endif

enum {
	uppGXImagePageProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxSpoolFile)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(gxFormat)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewGXImagePageProc(userRoutine)		\
		(GXImagePageUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXImagePageProcInfo, GetCurrentArchitecture())
#else
#define NewGXImagePageProc(userRoutine)		\
		((GXImagePageUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXImagePageProc(userRoutine, theSpoolFile, pageNumber, theFormat, imageData)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXImagePageProcInfo, (theSpoolFile), (pageNumber), (theFormat), (imageData))
#else
#define CallGXImagePageProc(userRoutine, theSpoolFile, pageNumber, theFormat, imageData)		\
		(*(userRoutine))((theSpoolFile), (pageNumber), (theFormat), (imageData))
#endif

typedef GXImagePageProcPtr GXImagePageProc;

extern OSErr Send_GXImagePage(gxSpoolFile theSpoolFile, long pageNumber, gxFormat theFormat, void *imageData)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 33, 0xABFB);
extern OSErr Forward_GXImagePage(gxSpoolFile theSpoolFile, long pageNumber, gxFormat theFormat, void *imageData)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXRenderPageProcPtr)(gxFormat theFormat, gxShape thePage, gxPageInfoRecord *pageInfo, void *imageData);

#if GENERATINGCFM
typedef UniversalProcPtr GXRenderPageUPP;
#else
typedef GXRenderPageProcPtr GXRenderPageUPP;
#endif

enum {
	uppGXRenderPageProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxFormat)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(gxShape)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(gxPageInfoRecord*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewGXRenderPageProc(userRoutine)		\
		(GXRenderPageUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXRenderPageProcInfo, GetCurrentArchitecture())
#else
#define NewGXRenderPageProc(userRoutine)		\
		((GXRenderPageUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXRenderPageProc(userRoutine, theFormat, thePage, pageInfo, imageData)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXRenderPageProcInfo, (theFormat), (thePage), (pageInfo), (imageData))
#else
#define CallGXRenderPageProc(userRoutine, theFormat, thePage, pageInfo, imageData)		\
		(*(userRoutine))((theFormat), (thePage), (pageInfo), (imageData))
#endif

typedef GXRenderPageProcPtr GXRenderPageProc;

extern OSErr Send_GXRenderPage(gxFormat theFormat, gxShape thePage, gxPageInfoRecord *pageInfo, void *imageData)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 34, 0xABFB);
extern OSErr Forward_GXRenderPage(gxFormat theFormat, gxShape thePage, gxPageInfoRecord *pageInfo, void *imageData)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXCreateImageFileProcPtr)(FSSpecPtr pFileSpec, long imageFileOptions, long *theImageFile);

#if GENERATINGCFM
typedef UniversalProcPtr GXCreateImageFileUPP;
#else
typedef GXCreateImageFileProcPtr GXCreateImageFileUPP;
#endif

enum {
	uppGXCreateImageFileProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(FSSpecPtr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long*)))
};

#if GENERATINGCFM
#define NewGXCreateImageFileProc(userRoutine)		\
		(GXCreateImageFileUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXCreateImageFileProcInfo, GetCurrentArchitecture())
#else
#define NewGXCreateImageFileProc(userRoutine)		\
		((GXCreateImageFileUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXCreateImageFileProc(userRoutine, pFileSpec, imageFileOptions, theImageFile)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXCreateImageFileProcInfo, (pFileSpec), (imageFileOptions), (theImageFile))
#else
#define CallGXCreateImageFileProc(userRoutine, pFileSpec, imageFileOptions, theImageFile)		\
		(*(userRoutine))((pFileSpec), (imageFileOptions), (theImageFile))
#endif

typedef GXCreateImageFileProcPtr GXCreateImageFileProc;

extern OSErr Send_GXCreateImageFile(FSSpecPtr pFileSpec, long imageFileOptions, long *theImageFile)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 35, 0xABFB);
extern OSErr Forward_GXCreateImageFile(FSSpecPtr pFileSpec, long imageFileOptions, long *theImageFile)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXOpenConnectionProcPtr)(void);

#if GENERATINGCFM
typedef UniversalProcPtr GXOpenConnectionUPP;
#else
typedef GXOpenConnectionProcPtr GXOpenConnectionUPP;
#endif

enum {
	uppGXOpenConnectionProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
};

#if GENERATINGCFM
#define NewGXOpenConnectionProc(userRoutine)		\
		(GXOpenConnectionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXOpenConnectionProcInfo, GetCurrentArchitecture())
#else
#define NewGXOpenConnectionProc(userRoutine)		\
		((GXOpenConnectionUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXOpenConnectionProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXOpenConnectionProcInfo)
#else
#define CallGXOpenConnectionProc(userRoutine)		\
		(*(userRoutine))()
#endif

typedef GXOpenConnectionProcPtr GXOpenConnectionProc;

extern OSErr Send_GXOpenConnection(void)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 36, 0xABFB);
extern OSErr Forward_GXOpenConnection(void)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXCloseConnectionProcPtr)(void);

#if GENERATINGCFM
typedef UniversalProcPtr GXCloseConnectionUPP;
#else
typedef GXCloseConnectionProcPtr GXCloseConnectionUPP;
#endif

enum {
	uppGXCloseConnectionProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
};

#if GENERATINGCFM
#define NewGXCloseConnectionProc(userRoutine)		\
		(GXCloseConnectionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXCloseConnectionProcInfo, GetCurrentArchitecture())
#else
#define NewGXCloseConnectionProc(userRoutine)		\
		((GXCloseConnectionUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXCloseConnectionProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXCloseConnectionProcInfo)
#else
#define CallGXCloseConnectionProc(userRoutine)		\
		(*(userRoutine))()
#endif

typedef GXCloseConnectionProcPtr GXCloseConnectionProc;

extern OSErr Send_GXCloseConnection(void)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 37, 0xABFB);
extern OSErr Forward_GXCloseConnection(void)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXStartSendPageProcPtr)(gxFormat theFormat);

#if GENERATINGCFM
typedef UniversalProcPtr GXStartSendPageUPP;
#else
typedef GXStartSendPageProcPtr GXStartSendPageUPP;
#endif

enum {
	uppGXStartSendPageProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxFormat)))
};

#if GENERATINGCFM
#define NewGXStartSendPageProc(userRoutine)		\
		(GXStartSendPageUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXStartSendPageProcInfo, GetCurrentArchitecture())
#else
#define NewGXStartSendPageProc(userRoutine)		\
		((GXStartSendPageUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXStartSendPageProc(userRoutine, theFormat)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXStartSendPageProcInfo, (theFormat))
#else
#define CallGXStartSendPageProc(userRoutine, theFormat)		\
		(*(userRoutine))((theFormat))
#endif

typedef GXStartSendPageProcPtr GXStartSendPageProc;

extern OSErr Send_GXStartSendPage(gxFormat theFormat)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 38, 0xABFB);
extern OSErr Forward_GXStartSendPage(gxFormat theFormat)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXFinishSendPageProcPtr)(void);

#if GENERATINGCFM
typedef UniversalProcPtr GXFinishSendPageUPP;
#else
typedef GXFinishSendPageProcPtr GXFinishSendPageUPP;
#endif

enum {
	uppGXFinishSendPageProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
};

#if GENERATINGCFM
#define NewGXFinishSendPageProc(userRoutine)		\
		(GXFinishSendPageUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXFinishSendPageProcInfo, GetCurrentArchitecture())
#else
#define NewGXFinishSendPageProc(userRoutine)		\
		((GXFinishSendPageUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXFinishSendPageProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXFinishSendPageProcInfo)
#else
#define CallGXFinishSendPageProc(userRoutine)		\
		(*(userRoutine))()
#endif

typedef GXFinishSendPageProcPtr GXFinishSendPageProc;

extern OSErr Send_GXFinishSendPage(void)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 39, 0xABFB);
extern OSErr Forward_GXFinishSendPage(void)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXWriteDataProcPtr)(Ptr data, long length);

#if GENERATINGCFM
typedef UniversalProcPtr GXWriteDataUPP;
#else
typedef GXWriteDataProcPtr GXWriteDataUPP;
#endif

enum {
	uppGXWriteDataProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewGXWriteDataProc(userRoutine)		\
		(GXWriteDataUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXWriteDataProcInfo, GetCurrentArchitecture())
#else
#define NewGXWriteDataProc(userRoutine)		\
		((GXWriteDataUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXWriteDataProc(userRoutine, data, length)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXWriteDataProcInfo, (data), (length))
#else
#define CallGXWriteDataProc(userRoutine, data, length)		\
		(*(userRoutine))((data), (length))
#endif

typedef GXWriteDataProcPtr GXWriteDataProc;

extern OSErr Send_GXWriteData(Ptr data, long length)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 40, 0xABFB);
extern OSErr Forward_GXWriteData(Ptr data, long length)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXBufferDataProcPtr)(Ptr data, long length, long bufferOptions);

#if GENERATINGCFM
typedef UniversalProcPtr GXBufferDataUPP;
#else
typedef GXBufferDataProcPtr GXBufferDataUPP;
#endif

enum {
	uppGXBufferDataProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewGXBufferDataProc(userRoutine)		\
		(GXBufferDataUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXBufferDataProcInfo, GetCurrentArchitecture())
#else
#define NewGXBufferDataProc(userRoutine)		\
		((GXBufferDataUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXBufferDataProc(userRoutine, data, length, bufferOptions)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXBufferDataProcInfo, (data), (length), (bufferOptions))
#else
#define CallGXBufferDataProc(userRoutine, data, length, bufferOptions)		\
		(*(userRoutine))((data), (length), (bufferOptions))
#endif

typedef GXBufferDataProcPtr GXBufferDataProc;

extern OSErr Send_GXBufferData(Ptr data, long length, long bufferOptions)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 41, 0xABFB);
extern OSErr Forward_GXBufferData(Ptr data, long length, long bufferOptions)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXDumpBufferProcPtr)(gxPrintingBuffer *theBuffer);

#if GENERATINGCFM
typedef UniversalProcPtr GXDumpBufferUPP;
#else
typedef GXDumpBufferProcPtr GXDumpBufferUPP;
#endif

enum {
	uppGXDumpBufferProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxPrintingBuffer*)))
};

#if GENERATINGCFM
#define NewGXDumpBufferProc(userRoutine)		\
		(GXDumpBufferUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXDumpBufferProcInfo, GetCurrentArchitecture())
#else
#define NewGXDumpBufferProc(userRoutine)		\
		((GXDumpBufferUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXDumpBufferProc(userRoutine, theBuffer)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXDumpBufferProcInfo, (theBuffer))
#else
#define CallGXDumpBufferProc(userRoutine, theBuffer)		\
		(*(userRoutine))((theBuffer))
#endif

typedef GXDumpBufferProcPtr GXDumpBufferProc;

extern OSErr Send_GXDumpBuffer(gxPrintingBuffer *theBuffer)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 42, 0xABFB);
extern OSErr Forward_GXDumpBuffer(gxPrintingBuffer *theBuffer)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXFreeBufferProcPtr)(gxPrintingBuffer *theBuffer);

#if GENERATINGCFM
typedef UniversalProcPtr GXFreeBufferUPP;
#else
typedef GXFreeBufferProcPtr GXFreeBufferUPP;
#endif

enum {
	uppGXFreeBufferProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxPrintingBuffer*)))
};

#if GENERATINGCFM
#define NewGXFreeBufferProc(userRoutine)		\
		(GXFreeBufferUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXFreeBufferProcInfo, GetCurrentArchitecture())
#else
#define NewGXFreeBufferProc(userRoutine)		\
		((GXFreeBufferUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXFreeBufferProc(userRoutine, theBuffer)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXFreeBufferProcInfo, (theBuffer))
#else
#define CallGXFreeBufferProc(userRoutine, theBuffer)		\
		(*(userRoutine))((theBuffer))
#endif

typedef GXFreeBufferProcPtr GXFreeBufferProc;

extern OSErr Send_GXFreeBuffer(gxPrintingBuffer *theBuffer)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 43, 0xABFB);
extern OSErr Forward_GXFreeBuffer(gxPrintingBuffer *theBuffer)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXCheckStatusProcPtr)(Ptr data, long length, long statusType, gxOwnerSignature owner);

#if GENERATINGCFM
typedef UniversalProcPtr GXCheckStatusUPP;
#else
typedef GXCheckStatusProcPtr GXCheckStatusUPP;
#endif

enum {
	uppGXCheckStatusProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(gxOwnerSignature)))
};

#if GENERATINGCFM
#define NewGXCheckStatusProc(userRoutine)		\
		(GXCheckStatusUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXCheckStatusProcInfo, GetCurrentArchitecture())
#else
#define NewGXCheckStatusProc(userRoutine)		\
		((GXCheckStatusUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXCheckStatusProc(userRoutine, data, length, statusType, owner)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXCheckStatusProcInfo, (data), (length), (statusType), (owner))
#else
#define CallGXCheckStatusProc(userRoutine, data, length, statusType, owner)		\
		(*(userRoutine))((data), (length), (statusType), (owner))
#endif

typedef GXCheckStatusProcPtr GXCheckStatusProc;

extern OSErr Send_GXCheckStatus(Ptr data, long length, long statusType, gxOwnerSignature owner)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 44, 0xABFB);
extern OSErr Forward_GXCheckStatus(Ptr data, long length, long statusType, gxOwnerSignature owner)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXGetDeviceStatusProcPtr)(Ptr cmdData, long cmdSize, Ptr responseData, long *responseSize, Str255 termination);

#if GENERATINGCFM
typedef UniversalProcPtr GXGetDeviceStatusUPP;
#else
typedef GXGetDeviceStatusProcPtr GXGetDeviceStatusUPP;
#endif

enum {
	uppGXGetDeviceStatusProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Ptr)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(long*)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(/* Str255 is array */ void*)))
};

#if GENERATINGCFM
#define NewGXGetDeviceStatusProc(userRoutine)		\
		(GXGetDeviceStatusUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXGetDeviceStatusProcInfo, GetCurrentArchitecture())
#else
#define NewGXGetDeviceStatusProc(userRoutine)		\
		((GXGetDeviceStatusUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXGetDeviceStatusProc(userRoutine, cmdData, cmdSize, responseData, responseSize, termination)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXGetDeviceStatusProcInfo, (cmdData), (cmdSize), (responseData), (responseSize), (termination))
#else
#define CallGXGetDeviceStatusProc(userRoutine, cmdData, cmdSize, responseData, responseSize, termination)		\
		(*(userRoutine))((cmdData), (cmdSize), (responseData), (responseSize), (termination))
#endif

typedef GXGetDeviceStatusProcPtr GXGetDeviceStatusProc;

extern OSErr Send_GXGetDeviceStatus(Ptr cmdData, long cmdSize, Ptr responseData, long *responseSize, Str255 termination)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 45, 0xABFB);
extern OSErr Forward_GXGetDeviceStatus(Ptr cmdData, long cmdSize, Ptr responseData, long *responseSize, Str255 termination)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXFetchTaggedDataProcPtr)(ResType theType, long id, Handle *dataHdl, gxOwnerSignature owner);

#if GENERATINGCFM
typedef UniversalProcPtr GXFetchTaggedDataUPP;
#else
typedef GXFetchTaggedDataProcPtr GXFetchTaggedDataUPP;
#endif

enum {
	uppGXFetchTaggedDataProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ResType)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Handle*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(gxOwnerSignature)))
};

#if GENERATINGCFM
#define NewGXFetchTaggedDataProc(userRoutine)		\
		(GXFetchTaggedDataUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXFetchTaggedDataProcInfo, GetCurrentArchitecture())
#else
#define NewGXFetchTaggedDataProc(userRoutine)		\
		((GXFetchTaggedDataUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXFetchTaggedDataProc(userRoutine, theType, id, dataHdl, owner)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXFetchTaggedDataProcInfo, (theType), (id), (dataHdl), (owner))
#else
#define CallGXFetchTaggedDataProc(userRoutine, theType, id, dataHdl, owner)		\
		(*(userRoutine))((theType), (id), (dataHdl), (owner))
#endif

typedef GXFetchTaggedDataProcPtr GXFetchTaggedDataProc;

extern OSErr Send_GXFetchTaggedData(ResType theType, long id, Handle *dataHdl, gxOwnerSignature owner)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 46, 0xABFB);
extern OSErr Forward_GXFetchTaggedData(ResType theType, long id, Handle *dataHdl, gxOwnerSignature owner)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXGetDTPMenuListProcPtr)(MenuHandle menuHdl);

#if GENERATINGCFM
typedef UniversalProcPtr GXGetDTPMenuListUPP;
#else
typedef GXGetDTPMenuListProcPtr GXGetDTPMenuListUPP;
#endif

enum {
	uppGXGetDTPMenuListProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(MenuHandle)))
};

#if GENERATINGCFM
#define NewGXGetDTPMenuListProc(userRoutine)		\
		(GXGetDTPMenuListUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXGetDTPMenuListProcInfo, GetCurrentArchitecture())
#else
#define NewGXGetDTPMenuListProc(userRoutine)		\
		((GXGetDTPMenuListUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXGetDTPMenuListProc(userRoutine, menuHdl)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXGetDTPMenuListProcInfo, (menuHdl))
#else
#define CallGXGetDTPMenuListProc(userRoutine, menuHdl)		\
		(*(userRoutine))((menuHdl))
#endif

typedef GXGetDTPMenuListProcPtr GXGetDTPMenuListProc;

extern OSErr Send_GXGetDTPMenuList(MenuHandle menuHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 47, 0xABFB);
extern OSErr Forward_GXGetDTPMenuList(MenuHandle menuHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXDTPMenuSelectProcPtr)(long id);

#if GENERATINGCFM
typedef UniversalProcPtr GXDTPMenuSelectUPP;
#else
typedef GXDTPMenuSelectProcPtr GXDTPMenuSelectUPP;
#endif

enum {
	uppGXDTPMenuSelectProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewGXDTPMenuSelectProc(userRoutine)		\
		(GXDTPMenuSelectUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXDTPMenuSelectProcInfo, GetCurrentArchitecture())
#else
#define NewGXDTPMenuSelectProc(userRoutine)		\
		((GXDTPMenuSelectUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXDTPMenuSelectProc(userRoutine, id)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXDTPMenuSelectProcInfo, (id))
#else
#define CallGXDTPMenuSelectProc(userRoutine, id)		\
		(*(userRoutine))((id))
#endif

typedef GXDTPMenuSelectProcPtr GXDTPMenuSelectProc;

extern OSErr Send_GXDTPMenuSelect(long id)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 48, 0xABFB);
extern OSErr Forward_GXDTPMenuSelect(long id)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXHandleAlertFilterProcPtr)(gxJob theJob, gxStatusRecord *pStatusRec, DialogPtr pDialog, EventRecord *theEvent, short *itemHit, Boolean *returnImmed);

#if GENERATINGCFM
typedef UniversalProcPtr GXHandleAlertFilterUPP;
#else
typedef GXHandleAlertFilterProcPtr GXHandleAlertFilterUPP;
#endif

enum {
	uppGXHandleAlertFilterProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxJob)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(gxStatusRecord*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(DialogPtr)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(EventRecord*)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(short*)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(Boolean*)))
};

#if GENERATINGCFM
#define NewGXHandleAlertFilterProc(userRoutine)		\
		(GXHandleAlertFilterUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXHandleAlertFilterProcInfo, GetCurrentArchitecture())
#else
#define NewGXHandleAlertFilterProc(userRoutine)		\
		((GXHandleAlertFilterUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXHandleAlertFilterProc(userRoutine, theJob, pStatusRec, pDialog, theEvent, itemHit, returnImmed)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXHandleAlertFilterProcInfo, (theJob), (pStatusRec), (pDialog), (theEvent), (itemHit), (returnImmed))
#else
#define CallGXHandleAlertFilterProc(userRoutine, theJob, pStatusRec, pDialog, theEvent, itemHit, returnImmed)		\
		(*(userRoutine))((theJob), (pStatusRec), (pDialog), (theEvent), (itemHit), (returnImmed))
#endif

typedef GXHandleAlertFilterProcPtr GXHandleAlertFilterProc;

extern OSErr Send_GXHandleAlertFilter(gxJob theJob, gxStatusRecord *pStatusRec, DialogPtr pDialog, EventRecord *theEvent, short *itemHit, Boolean *returnImmed)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 49, 0xABFB);
extern OSErr Forward_GXHandleAlertFilter(gxJob theJob, gxStatusRecord *pStatusRec, DialogPtr pDialog, EventRecord *theEvent, short *itemHit, Boolean *returnImmed)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXJobFormatModeQueryProcPtr)(gxQueryType theQuery, void *srcData, void *dstData);

#if GENERATINGCFM
typedef UniversalProcPtr GXJobFormatModeQueryUPP;
#else
typedef GXJobFormatModeQueryProcPtr GXJobFormatModeQueryUPP;
#endif

enum {
	uppGXJobFormatModeQueryProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxQueryType)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewGXJobFormatModeQueryProc(userRoutine)		\
		(GXJobFormatModeQueryUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXJobFormatModeQueryProcInfo, GetCurrentArchitecture())
#else
#define NewGXJobFormatModeQueryProc(userRoutine)		\
		((GXJobFormatModeQueryUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXJobFormatModeQueryProc(userRoutine, theQuery, srcData, dstData)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXJobFormatModeQueryProcInfo, (theQuery), (srcData), (dstData))
#else
#define CallGXJobFormatModeQueryProc(userRoutine, theQuery, srcData, dstData)		\
		(*(userRoutine))((theQuery), (srcData), (dstData))
#endif

typedef GXJobFormatModeQueryProcPtr GXJobFormatModeQueryProc;

extern OSErr Send_GXJobFormatModeQuery(gxQueryType theQuery, void *srcData, void *dstData)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 50, 0xABFB);
extern OSErr Forward_GXJobFormatModeQuery(gxQueryType theQuery, void *srcData, void *dstData)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXWriteStatusToDTPWindowProcPtr)(gxStatusRecord *pStatusRec, gxDisplayRecord *pDisplay);

#if GENERATINGCFM
typedef UniversalProcPtr GXWriteStatusToDTPWindowUPP;
#else
typedef GXWriteStatusToDTPWindowProcPtr GXWriteStatusToDTPWindowUPP;
#endif

enum {
	uppGXWriteStatusToDTPWindowProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxStatusRecord*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(gxDisplayRecord*)))
};

#if GENERATINGCFM
#define NewGXWriteStatusToDTPWindowProc(userRoutine)		\
		(GXWriteStatusToDTPWindowUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXWriteStatusToDTPWindowProcInfo, GetCurrentArchitecture())
#else
#define NewGXWriteStatusToDTPWindowProc(userRoutine)		\
		((GXWriteStatusToDTPWindowUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXWriteStatusToDTPWindowProc(userRoutine, pStatusRec, pDisplay)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXWriteStatusToDTPWindowProcInfo, (pStatusRec), (pDisplay))
#else
#define CallGXWriteStatusToDTPWindowProc(userRoutine, pStatusRec, pDisplay)		\
		(*(userRoutine))((pStatusRec), (pDisplay))
#endif

typedef GXWriteStatusToDTPWindowProcPtr GXWriteStatusToDTPWindowProc;

extern OSErr Send_GXWriteStatusToDTPWindow(gxStatusRecord *pStatusRec, gxDisplayRecord *pDisplay)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 51, 0xABFB);
extern OSErr Forward_GXWriteStatusToDTPWindow(gxStatusRecord *pStatusRec, gxDisplayRecord *pDisplay)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXInitializeStatusAlertProcPtr)(gxStatusRecord *pStatusRec, DialogPtr *pDialog);

#if GENERATINGCFM
typedef UniversalProcPtr GXInitializeStatusAlertUPP;
#else
typedef GXInitializeStatusAlertProcPtr GXInitializeStatusAlertUPP;
#endif

enum {
	uppGXInitializeStatusAlertProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxStatusRecord*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DialogPtr*)))
};

#if GENERATINGCFM
#define NewGXInitializeStatusAlertProc(userRoutine)		\
		(GXInitializeStatusAlertUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXInitializeStatusAlertProcInfo, GetCurrentArchitecture())
#else
#define NewGXInitializeStatusAlertProc(userRoutine)		\
		((GXInitializeStatusAlertUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXInitializeStatusAlertProc(userRoutine, pStatusRec, pDialog)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXInitializeStatusAlertProcInfo, (pStatusRec), (pDialog))
#else
#define CallGXInitializeStatusAlertProc(userRoutine, pStatusRec, pDialog)		\
		(*(userRoutine))((pStatusRec), (pDialog))
#endif

typedef GXInitializeStatusAlertProcPtr GXInitializeStatusAlertProc;

extern OSErr Send_GXInitializeStatusAlert(gxStatusRecord *pStatusRec, DialogPtr *pDialog)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 52, 0xABFB);
extern OSErr Forward_GXInitializeStatusAlert(gxStatusRecord *pStatusRec, DialogPtr *pDialog)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXHandleAlertStatusProcPtr)(gxStatusRecord *pStatusRec);

#if GENERATINGCFM
typedef UniversalProcPtr GXHandleAlertStatusUPP;
#else
typedef GXHandleAlertStatusProcPtr GXHandleAlertStatusUPP;
#endif

enum {
	uppGXHandleAlertStatusProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxStatusRecord*)))
};

#if GENERATINGCFM
#define NewGXHandleAlertStatusProc(userRoutine)		\
		(GXHandleAlertStatusUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXHandleAlertStatusProcInfo, GetCurrentArchitecture())
#else
#define NewGXHandleAlertStatusProc(userRoutine)		\
		((GXHandleAlertStatusUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXHandleAlertStatusProc(userRoutine, pStatusRec)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXHandleAlertStatusProcInfo, (pStatusRec))
#else
#define CallGXHandleAlertStatusProc(userRoutine, pStatusRec)		\
		(*(userRoutine))((pStatusRec))
#endif

typedef GXHandleAlertStatusProcPtr GXHandleAlertStatusProc;

extern OSErr Send_GXHandleAlertStatus(gxStatusRecord *pStatusRec)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 53, 0xABFB);
extern OSErr Forward_GXHandleAlertStatus(gxStatusRecord *pStatusRec)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXHandleAlertEventProcPtr)(gxStatusRecord *pStatusRec, DialogPtr pDialog, EventRecord *theEvent, short *response);

#if GENERATINGCFM
typedef UniversalProcPtr GXHandleAlertEventUPP;
#else
typedef GXHandleAlertEventProcPtr GXHandleAlertEventUPP;
#endif

enum {
	uppGXHandleAlertEventProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxStatusRecord*)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(DialogPtr)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(EventRecord*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(short*)))
};

#if GENERATINGCFM
#define NewGXHandleAlertEventProc(userRoutine)		\
		(GXHandleAlertEventUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXHandleAlertEventProcInfo, GetCurrentArchitecture())
#else
#define NewGXHandleAlertEventProc(userRoutine)		\
		((GXHandleAlertEventUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXHandleAlertEventProc(userRoutine, pStatusRec, pDialog, theEvent, response)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXHandleAlertEventProcInfo, (pStatusRec), (pDialog), (theEvent), (response))
#else
#define CallGXHandleAlertEventProc(userRoutine, pStatusRec, pDialog, theEvent, response)		\
		(*(userRoutine))((pStatusRec), (pDialog), (theEvent), (response))
#endif

typedef GXHandleAlertEventProcPtr GXHandleAlertEventProc;

extern OSErr Send_GXHandleAlertEvent(gxStatusRecord *pStatusRec, DialogPtr pDialog, EventRecord *theEvent, short *response)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 54, 0xABFB);
extern OSErr Forward_GXHandleAlertEvent(gxStatusRecord *pStatusRec, DialogPtr pDialog, EventRecord *theEvent, short *response)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef void (*GXCleanupStartJobProcPtr)(void);

#if GENERATINGCFM
typedef UniversalProcPtr GXCleanupStartJobUPP;
#else
typedef GXCleanupStartJobProcPtr GXCleanupStartJobUPP;
#endif

enum {
	uppGXCleanupStartJobProcInfo = kCStackBased
};

#if GENERATINGCFM
#define NewGXCleanupStartJobProc(userRoutine)		\
		(GXCleanupStartJobUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXCleanupStartJobProcInfo, GetCurrentArchitecture())
#else
#define NewGXCleanupStartJobProc(userRoutine)		\
		((GXCleanupStartJobUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXCleanupStartJobProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXCleanupStartJobProcInfo)
#else
#define CallGXCleanupStartJobProc(userRoutine)		\
		(*(userRoutine))()
#endif

typedef GXCleanupStartJobProcPtr GXCleanupStartJobProc;

extern void Send_GXCleanupStartJob(void)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 55, 0xABFB);
extern void Forward_GXCleanupStartJob(void)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef void (*GXCleanupStartPageProcPtr)(void);

#if GENERATINGCFM
typedef UniversalProcPtr GXCleanupStartPageUPP;
#else
typedef GXCleanupStartPageProcPtr GXCleanupStartPageUPP;
#endif

enum {
	uppGXCleanupStartPageProcInfo = kCStackBased
};

#if GENERATINGCFM
#define NewGXCleanupStartPageProc(userRoutine)		\
		(GXCleanupStartPageUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXCleanupStartPageProcInfo, GetCurrentArchitecture())
#else
#define NewGXCleanupStartPageProc(userRoutine)		\
		((GXCleanupStartPageUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXCleanupStartPageProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXCleanupStartPageProcInfo)
#else
#define CallGXCleanupStartPageProc(userRoutine)		\
		(*(userRoutine))()
#endif

typedef GXCleanupStartPageProcPtr GXCleanupStartPageProc;

extern void Send_GXCleanupStartPage(void)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 56, 0xABFB);
extern void Forward_GXCleanupStartPage(void)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef void (*GXCleanupOpenConnectionProcPtr)(void);

#if GENERATINGCFM
typedef UniversalProcPtr GXCleanupOpenConnectionUPP;
#else
typedef GXCleanupOpenConnectionProcPtr GXCleanupOpenConnectionUPP;
#endif

enum {
	uppGXCleanupOpenConnectionProcInfo = kCStackBased
};

#if GENERATINGCFM
#define NewGXCleanupOpenConnectionProc(userRoutine)		\
		(GXCleanupOpenConnectionUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXCleanupOpenConnectionProcInfo, GetCurrentArchitecture())
#else
#define NewGXCleanupOpenConnectionProc(userRoutine)		\
		((GXCleanupOpenConnectionUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXCleanupOpenConnectionProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXCleanupOpenConnectionProcInfo)
#else
#define CallGXCleanupOpenConnectionProc(userRoutine)		\
		(*(userRoutine))()
#endif

typedef GXCleanupOpenConnectionProcPtr GXCleanupOpenConnectionProc;

extern void Send_GXCleanupOpenConnection(void)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 57, 0xABFB);
extern void Forward_GXCleanupOpenConnection(void)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef void (*GXCleanupStartSendPageProcPtr)(void);

#if GENERATINGCFM
typedef UniversalProcPtr GXCleanupStartSendPageUPP;
#else
typedef GXCleanupStartSendPageProcPtr GXCleanupStartSendPageUPP;
#endif

enum {
	uppGXCleanupStartSendPageProcInfo = kCStackBased
};

#if GENERATINGCFM
#define NewGXCleanupStartSendPageProc(userRoutine)		\
		(GXCleanupStartSendPageUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXCleanupStartSendPageProcInfo, GetCurrentArchitecture())
#else
#define NewGXCleanupStartSendPageProc(userRoutine)		\
		((GXCleanupStartSendPageUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXCleanupStartSendPageProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXCleanupStartSendPageProcInfo)
#else
#define CallGXCleanupStartSendPageProc(userRoutine)		\
		(*(userRoutine))()
#endif

typedef GXCleanupStartSendPageProcPtr GXCleanupStartSendPageProc;

extern void Send_GXCleanupStartSendPage(void)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 58, 0xABFB);
extern void Forward_GXCleanupStartSendPage(void)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXDefaultDesktopPrinterProcPtr)(Str31 dtpName);

#if GENERATINGCFM
typedef UniversalProcPtr GXDefaultDesktopPrinterUPP;
#else
typedef GXDefaultDesktopPrinterProcPtr GXDefaultDesktopPrinterUPP;
#endif

enum {
	uppGXDefaultDesktopPrinterProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(/* Str31 is array */ void*)))
};

#if GENERATINGCFM
#define NewGXDefaultDesktopPrinterProc(userRoutine)		\
		(GXDefaultDesktopPrinterUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXDefaultDesktopPrinterProcInfo, GetCurrentArchitecture())
#else
#define NewGXDefaultDesktopPrinterProc(userRoutine)		\
		((GXDefaultDesktopPrinterUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXDefaultDesktopPrinterProc(userRoutine, dtpName)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXDefaultDesktopPrinterProcInfo, (dtpName))
#else
#define CallGXDefaultDesktopPrinterProc(userRoutine, dtpName)		\
		(*(userRoutine))((dtpName))
#endif

typedef GXDefaultDesktopPrinterProcPtr GXDefaultDesktopPrinterProc;

extern OSErr Send_GXDefaultDesktopPrinter(Str31 dtpName)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 59, 0xABFB);
extern OSErr Forward_GXDefaultDesktopPrinter(Str31 dtpName)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXCaptureOutputDeviceProcPtr)(Boolean capture);

#if GENERATINGCFM
typedef UniversalProcPtr GXCaptureOutputDeviceUPP;
#else
typedef GXCaptureOutputDeviceProcPtr GXCaptureOutputDeviceUPP;
#endif

enum {
	uppGXCaptureOutputDeviceProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Boolean)))
};

#if GENERATINGCFM
#define NewGXCaptureOutputDeviceProc(userRoutine)		\
		(GXCaptureOutputDeviceUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXCaptureOutputDeviceProcInfo, GetCurrentArchitecture())
#else
#define NewGXCaptureOutputDeviceProc(userRoutine)		\
		((GXCaptureOutputDeviceUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXCaptureOutputDeviceProc(userRoutine, capture)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXCaptureOutputDeviceProcInfo, (capture))
#else
#define CallGXCaptureOutputDeviceProc(userRoutine, capture)		\
		(*(userRoutine))((capture))
#endif

typedef GXCaptureOutputDeviceProcPtr GXCaptureOutputDeviceProc;

extern OSErr Send_GXCaptureOutputDevice(Boolean capture)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 60, 0xABFB);
extern OSErr Forward_GXCaptureOutputDevice(Boolean capture)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXOpenConnectionRetryProcPtr)(ResType theType, void *aVoid, Boolean *retryopenPtr, OSErr anErr);

#if GENERATINGCFM
typedef UniversalProcPtr GXOpenConnectionRetryUPP;
#else
typedef GXOpenConnectionRetryProcPtr GXOpenConnectionRetryUPP;
#endif

enum {
	uppGXOpenConnectionRetryProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(ResType)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Boolean*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(OSErr)))
};

#if GENERATINGCFM
#define NewGXOpenConnectionRetryProc(userRoutine)		\
		(GXOpenConnectionRetryUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXOpenConnectionRetryProcInfo, GetCurrentArchitecture())
#else
#define NewGXOpenConnectionRetryProc(userRoutine)		\
		((GXOpenConnectionRetryUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXOpenConnectionRetryProc(userRoutine, theType, aVoid, retryopenPtr, anErr)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXOpenConnectionRetryProcInfo, (theType), (aVoid), (retryopenPtr), (anErr))
#else
#define CallGXOpenConnectionRetryProc(userRoutine, theType, aVoid, retryopenPtr, anErr)		\
		(*(userRoutine))((theType), (aVoid), (retryopenPtr), (anErr))
#endif

typedef GXOpenConnectionRetryProcPtr GXOpenConnectionRetryProc;

extern OSErr Send_GXOpenConnectionRetry(ResType theType, void *aVoid, Boolean *retryopenPtr, OSErr anErr)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 61, 0xABFB);
extern OSErr Forward_GXOpenConnectionRetry(ResType theType, void *aVoid, Boolean *retryopenPtr, OSErr anErr)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXExamineSpoolFileProcPtr)(gxSpoolFile theSpoolFile);

#if GENERATINGCFM
typedef UniversalProcPtr GXExamineSpoolFileUPP;
#else
typedef GXExamineSpoolFileProcPtr GXExamineSpoolFileUPP;
#endif

enum {
	uppGXExamineSpoolFileProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxSpoolFile)))
};

#if GENERATINGCFM
#define NewGXExamineSpoolFileProc(userRoutine)		\
		(GXExamineSpoolFileUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXExamineSpoolFileProcInfo, GetCurrentArchitecture())
#else
#define NewGXExamineSpoolFileProc(userRoutine)		\
		((GXExamineSpoolFileUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXExamineSpoolFileProc(userRoutine, theSpoolFile)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXExamineSpoolFileProcInfo, (theSpoolFile))
#else
#define CallGXExamineSpoolFileProc(userRoutine, theSpoolFile)		\
		(*(userRoutine))((theSpoolFile))
#endif

typedef GXExamineSpoolFileProcPtr GXExamineSpoolFileProc;

extern OSErr Send_GXExamineSpoolFile(gxSpoolFile theSpoolFile)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 62, 0xABFB);
extern OSErr Forward_GXExamineSpoolFile(gxSpoolFile theSpoolFile)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXFinishSendPlaneProcPtr)(void);

#if GENERATINGCFM
typedef UniversalProcPtr GXFinishSendPlaneUPP;
#else
typedef GXFinishSendPlaneProcPtr GXFinishSendPlaneUPP;
#endif

enum {
	uppGXFinishSendPlaneProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
};

#if GENERATINGCFM
#define NewGXFinishSendPlaneProc(userRoutine)		\
		(GXFinishSendPlaneUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXFinishSendPlaneProcInfo, GetCurrentArchitecture())
#else
#define NewGXFinishSendPlaneProc(userRoutine)		\
		((GXFinishSendPlaneUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXFinishSendPlaneProc(userRoutine)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXFinishSendPlaneProcInfo)
#else
#define CallGXFinishSendPlaneProc(userRoutine)		\
		(*(userRoutine))()
#endif

typedef GXFinishSendPlaneProcPtr GXFinishSendPlaneProc;

extern OSErr Send_GXFinishSendPlane(void)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 63, 0xABFB);
extern OSErr Forward_GXFinishSendPlane(void)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXDoesPaperFitProcPtr)(gxTrayIndex whichTray, gxPaperType paper, Boolean *fits);

#if GENERATINGCFM
typedef UniversalProcPtr GXDoesPaperFitUPP;
#else
typedef GXDoesPaperFitProcPtr GXDoesPaperFitUPP;
#endif

enum {
	uppGXDoesPaperFitProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxTrayIndex)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(gxPaperType)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(Boolean*)))
};

#if GENERATINGCFM
#define NewGXDoesPaperFitProc(userRoutine)		\
		(GXDoesPaperFitUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXDoesPaperFitProcInfo, GetCurrentArchitecture())
#else
#define NewGXDoesPaperFitProc(userRoutine)		\
		((GXDoesPaperFitUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXDoesPaperFitProc(userRoutine, whichTray, paper, fits)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXDoesPaperFitProcInfo, (whichTray), (paper), (fits))
#else
#define CallGXDoesPaperFitProc(userRoutine, whichTray, paper, fits)		\
		(*(userRoutine))((whichTray), (paper), (fits))
#endif

typedef GXDoesPaperFitProcPtr GXDoesPaperFitProc;

extern OSErr Send_GXDoesPaperFit(gxTrayIndex whichTray, gxPaperType paper, Boolean *fits)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 64, 0xABFB);
extern OSErr Forward_GXDoesPaperFit(gxTrayIndex whichTray, gxPaperType paper, Boolean *fits)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXChooserMessageProcPtr)(long message, long caller, StringPtr objName, StringPtr zoneName, ListHandle theList, long p2);

#if GENERATINGCFM
typedef UniversalProcPtr GXChooserMessageUPP;
#else
typedef GXChooserMessageProcPtr GXChooserMessageUPP;
#endif

enum {
	uppGXChooserMessageProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(StringPtr)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(StringPtr)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(ListHandle)))
		 | STACK_ROUTINE_PARAMETER(6, SIZE_CODE(sizeof(long)))
};

#if GENERATINGCFM
#define NewGXChooserMessageProc(userRoutine)		\
		(GXChooserMessageUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXChooserMessageProcInfo, GetCurrentArchitecture())
#else
#define NewGXChooserMessageProc(userRoutine)		\
		((GXChooserMessageUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXChooserMessageProc(userRoutine, message, caller, objName, zoneName, theList, p2)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXChooserMessageProcInfo, (message), (caller), (objName), (zoneName), (theList), (p2))
#else
#define CallGXChooserMessageProc(userRoutine, message, caller, objName, zoneName, theList, p2)		\
		(*(userRoutine))((message), (caller), (objName), (zoneName), (theList), (p2))
#endif

typedef GXChooserMessageProcPtr GXChooserMessageProc;

extern OSErr Send_GXChooserMessage(long message, long caller, StringPtr objName, StringPtr zoneName, ListHandle theList, long p2)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 65, 0xABFB);
extern OSErr Forward_GXChooserMessage(long message, long caller, StringPtr objName, StringPtr zoneName, ListHandle theList, long p2)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXFindPrinterProfileProcPtr)(gxPrinter thePrinter, void *searchData, long index, gxColorProfile *returnedProfile, long *numProfiles);

#if GENERATINGCFM
typedef UniversalProcPtr GXFindPrinterProfileUPP;
#else
typedef GXFindPrinterProfileProcPtr GXFindPrinterProfileUPP;
#endif

enum {
	uppGXFindPrinterProfileProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxPrinter)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(gxColorProfile*)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(long*)))
};

#if GENERATINGCFM
#define NewGXFindPrinterProfileProc(userRoutine)		\
		(GXFindPrinterProfileUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXFindPrinterProfileProcInfo, GetCurrentArchitecture())
#else
#define NewGXFindPrinterProfileProc(userRoutine)		\
		((GXFindPrinterProfileUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXFindPrinterProfileProc(userRoutine, thePrinter, searchData, index, returnedProfile, numProfiles)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXFindPrinterProfileProcInfo, (thePrinter), (searchData), (index), (returnedProfile), (numProfiles))
#else
#define CallGXFindPrinterProfileProc(userRoutine, thePrinter, searchData, index, returnedProfile, numProfiles)		\
		(*(userRoutine))((thePrinter), (searchData), (index), (returnedProfile), (numProfiles))
#endif

typedef GXFindPrinterProfileProcPtr GXFindPrinterProfileProc;

extern OSErr Send_GXFindPrinterProfile(gxPrinter thePrinter, void *searchData, long index, gxColorProfile *returnedProfile, long *numProfiles)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 66, 0xABFB);
extern OSErr Forward_GXFindPrinterProfile(gxPrinter thePrinter, void *searchData, long index, gxColorProfile *returnedProfile, long *numProfiles)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXFindFormatProfileProcPtr)(gxFormat theFormat, void *searchData, long index, gxColorProfile *returnedProfile, long *numProfiles);

#if GENERATINGCFM
typedef UniversalProcPtr GXFindFormatProfileUPP;
#else
typedef GXFindFormatProfileProcPtr GXFindFormatProfileUPP;
#endif

enum {
	uppGXFindFormatProfileProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxFormat)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(gxColorProfile*)))
		 | STACK_ROUTINE_PARAMETER(5, SIZE_CODE(sizeof(long*)))
};

#if GENERATINGCFM
#define NewGXFindFormatProfileProc(userRoutine)		\
		(GXFindFormatProfileUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXFindFormatProfileProcInfo, GetCurrentArchitecture())
#else
#define NewGXFindFormatProfileProc(userRoutine)		\
		((GXFindFormatProfileUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXFindFormatProfileProc(userRoutine, theFormat, searchData, index, returnedProfile, numProfiles)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXFindFormatProfileProcInfo, (theFormat), (searchData), (index), (returnedProfile), (numProfiles))
#else
#define CallGXFindFormatProfileProc(userRoutine, theFormat, searchData, index, returnedProfile, numProfiles)		\
		(*(userRoutine))((theFormat), (searchData), (index), (returnedProfile), (numProfiles))
#endif

typedef GXFindFormatProfileProcPtr GXFindFormatProfileProc;

extern OSErr Send_GXFindFormatProfile(gxFormat theFormat, void *searchData, long index, gxColorProfile *returnedProfile, long *numProfiles)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 67, 0xABFB);
extern OSErr Forward_GXFindFormatProfile(gxFormat theFormat, void *searchData, long index, gxColorProfile *returnedProfile, long *numProfiles)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXSetPrinterProfileProcPtr)(gxPrinter thePrinter, gxColorProfile oldProfile, gxColorProfile newProfile);

#if GENERATINGCFM
typedef UniversalProcPtr GXSetPrinterProfileUPP;
#else
typedef GXSetPrinterProfileProcPtr GXSetPrinterProfileUPP;
#endif

enum {
	uppGXSetPrinterProfileProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxPrinter)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(gxColorProfile)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(gxColorProfile)))
};

#if GENERATINGCFM
#define NewGXSetPrinterProfileProc(userRoutine)		\
		(GXSetPrinterProfileUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXSetPrinterProfileProcInfo, GetCurrentArchitecture())
#else
#define NewGXSetPrinterProfileProc(userRoutine)		\
		((GXSetPrinterProfileUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXSetPrinterProfileProc(userRoutine, thePrinter, oldProfile, newProfile)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXSetPrinterProfileProcInfo, (thePrinter), (oldProfile), (newProfile))
#else
#define CallGXSetPrinterProfileProc(userRoutine, thePrinter, oldProfile, newProfile)		\
		(*(userRoutine))((thePrinter), (oldProfile), (newProfile))
#endif

typedef GXSetPrinterProfileProcPtr GXSetPrinterProfileProc;

extern OSErr Send_GXSetPrinterProfile(gxPrinter thePrinter, gxColorProfile oldProfile, gxColorProfile newProfile)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 68, 0xABFB);
extern OSErr Forward_GXSetPrinterProfile(gxPrinter thePrinter, gxColorProfile oldProfile, gxColorProfile newProfile)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXSetFormatProfileProcPtr)(gxFormat theFormat, gxColorProfile oldProfile, gxColorProfile newProfile);

#if GENERATINGCFM
typedef UniversalProcPtr GXSetFormatProfileUPP;
#else
typedef GXSetFormatProfileProcPtr GXSetFormatProfileUPP;
#endif

enum {
	uppGXSetFormatProfileProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxFormat)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(gxColorProfile)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(gxColorProfile)))
};

#if GENERATINGCFM
#define NewGXSetFormatProfileProc(userRoutine)		\
		(GXSetFormatProfileUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXSetFormatProfileProcInfo, GetCurrentArchitecture())
#else
#define NewGXSetFormatProfileProc(userRoutine)		\
		((GXSetFormatProfileUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXSetFormatProfileProc(userRoutine, theFormat, oldProfile, newProfile)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXSetFormatProfileProcInfo, (theFormat), (oldProfile), (newProfile))
#else
#define CallGXSetFormatProfileProc(userRoutine, theFormat, oldProfile, newProfile)		\
		(*(userRoutine))((theFormat), (oldProfile), (newProfile))
#endif

typedef GXSetFormatProfileProcPtr GXSetFormatProfileProc;

extern OSErr Send_GXSetFormatProfile(gxFormat theFormat, gxColorProfile oldProfile, gxColorProfile newProfile)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 69, 0xABFB);
extern OSErr Forward_GXSetFormatProfile(gxFormat theFormat, gxColorProfile oldProfile, gxColorProfile newProfile)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXHandleAltDestinationProcPtr)(Boolean *userCancels);

#if GENERATINGCFM
typedef UniversalProcPtr GXHandleAltDestinationUPP;
#else
typedef GXHandleAltDestinationProcPtr GXHandleAltDestinationUPP;
#endif

enum {
	uppGXHandleAltDestinationProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(Boolean*)))
};

#if GENERATINGCFM
#define NewGXHandleAltDestinationProc(userRoutine)		\
		(GXHandleAltDestinationUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXHandleAltDestinationProcInfo, GetCurrentArchitecture())
#else
#define NewGXHandleAltDestinationProc(userRoutine)		\
		((GXHandleAltDestinationUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXHandleAltDestinationProc(userRoutine, userCancels)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXHandleAltDestinationProcInfo, (userCancels))
#else
#define CallGXHandleAltDestinationProc(userRoutine, userCancels)		\
		(*(userRoutine))((userCancels))
#endif

typedef GXHandleAltDestinationProcPtr GXHandleAltDestinationProc;

extern OSErr Send_GXHandleAltDestination(Boolean *userCancels)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 70, 0xABFB);
extern OSErr Forward_GXHandleAltDestination(Boolean *userCancels)
 TWOWORDINLINE(0x7036, 0xABFB);
typedef OSErr (*GXSetupPageImageDataProcPtr)(gxFormat theFormat, gxShape thePage, void *imageData);

#if GENERATINGCFM
typedef UniversalProcPtr GXSetupPageImageDataUPP;
#else
typedef GXSetupPageImageDataProcPtr GXSetupPageImageDataUPP;
#endif

enum {
	uppGXSetupPageImageDataProcInfo = kCStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(gxFormat)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(gxShape)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewGXSetupPageImageDataProc(userRoutine)		\
		(GXSetupPageImageDataUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppGXSetupPageImageDataProcInfo, GetCurrentArchitecture())
#else
#define NewGXSetupPageImageDataProc(userRoutine)		\
		((GXSetupPageImageDataUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallGXSetupPageImageDataProc(userRoutine, theFormat, thePage, imageData)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppGXSetupPageImageDataProcInfo, (theFormat), (thePage), (imageData))
#else
#define CallGXSetupPageImageDataProc(userRoutine, theFormat, thePage, imageData)		\
		(*(userRoutine))((theFormat), (thePage), (imageData))
#endif

typedef GXSetupPageImageDataProcPtr GXSetupPageImageDataProc;

extern OSErr Send_GXSetupPageImageData(gxFormat theFormat, gxShape thePage, void *imageData)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0000, 71, 0xABFB);
extern OSErr Forward_GXSetupPageImageData(gxFormat theFormat, gxShape thePage, void *imageData)
 TWOWORDINLINE(0x7036, 0xABFB);
/*******************************************************************
					Start of old "GXPrintingErrors.h/a/p" interface file.
			********************************************************************/

enum {
	gxPrintingResultBase		= -510							/*First QuickDraw GX printing error code.*/
};

/*RESULT CODES FOR QUICKDRAW GX PRINTING OPERATIONS*/
enum {
	gxAioTimeout				= (gxPrintingResultBase),		/*-510 : Timeout condition occurred during operation*/
	gxAioBadRqstState			= (gxPrintingResultBase - 1),	/*-511 : Async I/O request in invalid state for operation*/
	gxAioBadConn				= (gxPrintingResultBase - 2),	/*-512 : Invalid Async I/O connection refnum*/
	gxAioInvalidXfer			= (gxPrintingResultBase - 3),	/*-513 : Read data transfer structure contained bad values*/
	gxAioNoRqstBlks				= (gxPrintingResultBase - 4),	/*-514 : No available request blocks to process request*/
	gxAioNoDataXfer				= (gxPrintingResultBase - 5),	/*-515 : Data transfer structure pointer not specified*/
	gxAioTooManyAutos			= (gxPrintingResultBase - 6),	/*-516 : Auto status request already active*/
	gxAioNoAutoStat				= (gxPrintingResultBase - 7),	/*-517 : Connection not configured for auto status*/
	gxAioBadRqstID				= (gxPrintingResultBase - 8),	/*-518 : Invalid I/O request identifier*/
	gxAioCantKill				= (gxPrintingResultBase - 9),	/*-519 : Comm. protocol doesn't support I/O term*/
	gxAioAlreadyExists			= (gxPrintingResultBase - 10),	/*-520 : Protocol spec. data already specified*/
	gxAioCantFind				= (gxPrintingResultBase - 11),	/*-521 : Protocol spec. data does not exist*/
	gxAioDeviceDisconn			= (gxPrintingResultBase - 12),	/*-522 : Machine disconnected from printer*/
	gxAioNotImplemented			= (gxPrintingResultBase - 13),	/*-523 : Function not implemented*/
	gxAioOpenPending			= (gxPrintingResultBase - 14),	/*-524 : Opening a connection for protocol, but another open pending*/
	gxAioNoProtocolData			= (gxPrintingResultBase - 15),	/*-525 : No protocol specific data specified in request*/
	gxAioRqstKilled				= (gxPrintingResultBase - 16),	/*-526 : I/O request was terminated*/
	gxBadBaudRate				= (gxPrintingResultBase - 17),	/*-527 : Invalid baud rate specified*/
	gxBadParity					= (gxPrintingResultBase - 18),	/*-528 : Invalid parity specified*/
	gxBadStopBits				= (gxPrintingResultBase - 19),	/*-529 : Invalid stop bits specified*/
	gxBadDataBits				= (gxPrintingResultBase - 20),	/*-530 : Invalid data bits specified*/
	gxBadPrinterName			= (gxPrintingResultBase - 21),	/*-531 : Bad printer name specified*/
	gxAioBadMsgType				= (gxPrintingResultBase - 22),	/*-532 : Bad masType field in transfer info structure*/
	gxAioCantFindDevice			= (gxPrintingResultBase - 23),	/*-533 : Cannot locate target device*/
	gxAioOutOfSeq				= (gxPrintingResultBase - 24),	/*-534 : Non-atomic SCSI requests submitted out of sequence*/
	gxPrIOAbortErr				= (gxPrintingResultBase - 25),	/*-535 : I/O operation aborted*/
	gxPrUserAbortErr			= (gxPrintingResultBase - 26),	/*-536 : User aborted*/
	gxCantAddPanelsNowErr		= (gxPrintingResultBase - 27),	/*-537 : Can only add panels during driver switch or dialog setup*/
	gxBadxdtlKeyErr				= (gxPrintingResultBase - 28),	/*-538 : Unknown key for xdtl - must be radiobutton, etc*/
	gxXdtlItemOutOfRangeErr		= (gxPrintingResultBase - 29),	/*-539 : Referenced item does not belong to panel*/
	gxNoActionButtonErr			= (gxPrintingResultBase - 30),	/*-540 : Action button is nil*/
	gxTitlesTooLongErr			= (gxPrintingResultBase - 31),	/*-541 : Length of buttons exceeds alert maximum width*/
	gxUnknownAlertVersionErr	= (gxPrintingResultBase - 32),	/*-542 : Bad version for printing alerts*/
	gxGBBufferTooSmallErr		= (gxPrintingResultBase - 33),	/*-543 : Buffer too small.*/
	gxInvalidPenTable			= (gxPrintingResultBase - 34),	/*-544 : Invalid vector driver pen table.*/
	gxIncompletePrintFileErr	= (gxPrintingResultBase - 35),	/*-545 : Print file was not completely spooled*/
	gxCrashedPrintFileErr		= (gxPrintingResultBase - 36),	/*-546 : Print file is corrupted*/
	gxInvalidPrintFileVersion	= (gxPrintingResultBase - 37),	/*-547 : Print file is incompatible with current QuickDraw GX version*/
	gxSegmentLoadFailedErr		= (gxPrintingResultBase - 38),	/*-548 : Segment loader error*/
	gxExtensionNotFoundErr		= (gxPrintingResultBase - 39),	/*-549 : Requested printing extension could not be found*/
	gxDriverVersionErr			= (gxPrintingResultBase - 40),	/*-550 : Driver too new for current version of QuickDraw GX*/
	gxImagingSystemVersionErr	= (gxPrintingResultBase - 41),	/*-551 : Imaging system too new for current version of QuickDraw GX*/
	gxFlattenVersionTooNew		= (gxPrintingResultBase - 42),	/*-552 : Flattened object format too new for current version of QDGX*/
	gxPaperTypeNotFound			= (gxPrintingResultBase - 43),	/*-553 : Requested papertype could not be found*/
	gxNoSuchPTGroup				= (gxPrintingResultBase - 44),	/*-554 : Requested papertype group could not be found*/
	gxNotEnoughPrinterMemory	= (gxPrintingResultBase - 45),	/*-555 : Printer does not have enough memory for fonts in document*/
	gxDuplicatePanelNameErr		= (gxPrintingResultBase - 46),	/*-556 : Attempt to add more than 10 panels with the same name*/
	gxExtensionVersionErr		= (gxPrintingResultBase - 47)	/*-557 : Extension too new for current version of QuickDraw GX*/
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

#endif /* __GXPRINTING__ */

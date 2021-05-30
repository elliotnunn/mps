/*
 	File:		GXPrinterDrivers.h
 
 	Contains:	This file defines data types and API functions for printer driver development.
 
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

#ifndef __GXPRINTERDRIVERS__
#define __GXPRINTERDRIVERS__


#ifndef __SCALERTYPES__
#include <ScalerTypes.h>
#endif
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <MixedMode.h>										*/
/*	#include <GXMath.h>											*/
/*		#include <FixMath.h>									*/
/*	#include <SFNTTypes.h>										*/
/*		#include <GXTypes.h>									*/

#ifndef __PRINTING__
#include <Printing.h>
#endif
/*	#include <Errors.h>											*/
/*	#include <Quickdraw.h>										*/
/*		#include <QuickdrawText.h>								*/
/*	#include <Dialogs.h>										*/
/*		#include <Memory.h>										*/
/*		#include <Menus.h>										*/
/*		#include <Controls.h>									*/
/*		#include <Windows.h>									*/
/*			#include <Events.h>									*/
/*				#include <OSUtils.h>							*/
/*		#include <TextEdit.h>									*/

#ifndef __GXPRINTING__
#include <GXPrinting.h>
#endif
/*	#include <Collections.h>									*/
/*	#include <Files.h>											*/
/*		#include <Finder.h>										*/
/*	#include <GXFonts.h>										*/
/*	#include <Lists.h>											*/
/*	#include <GXMessages.h>										*/

#ifdef __cplusplus
extern "C" {
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=mac68k
#endif

#if PRAGMA_IMPORT_SUPPORTED
#pragma import on
#endif

struct gxManualFeedAlertPrefs {
	long							alertFlags;					/*	Flags--first word is for driver's private use, the rest is predefined. */
};
typedef struct gxManualFeedAlertPrefs gxManualFeedAlertPrefs, *gxManualFeedAlertPrefsPtr, **gxManualFeedAlertPrefsHdl;

/* Constants for the alertFlags field of gxManualFeedAlertPrefs.*/

enum {
	gxShowAlerts				= 0x00000001,					/* Show alerts for this desktop printer. */
	gxAlertOnPaperChange		= 0x00000002					/* …only if the papertype changes. */
};

enum {
	gxDefaultMFeedAlertSettings	= (gxShowAlerts | gxAlertOnPaperChange)
};

/* Driver output settings structure for desktop printer gxDriverOutputType resource */
struct gxDriverOutputSettings {
	long							driverflags;				/*	Flags -- for use by driver. */
	long							outputSettings;				/*	Flags -- predefined. */
};
typedef struct gxDriverOutputSettings gxDriverOutputSettings, *gxDriverOutputSettingsPtr, **gxDriverOutputSettingsHdl;

/* Constants for the outputSettings field of gxDriverOutputSettings. */

enum {
	gxCanConfigureTrays			= 0x00000001					/* Desktop printer represents a device with a paper feed. */
};

/* ------------------------------------------------------------------------------

						Printing Driver Constants and Types

-------------------------------------------------------------------------------- */
enum {
	gxInputTraysMenuItem		= -1							/* Menu item number for "Input Trays..." */
};

/* Buffering and IO preferences-- this structure mirrors the 'iobm' resource */
struct gxIOPrefsRec {
	unsigned long					communicationsOptions;		/* Standard or nonstandard I/O? */
	unsigned long					numBuffers;					/* Requested number of buffers for QDGX to create */
	unsigned long					bufferSize;					/* The size of each buffer */
	unsigned long					numReqBlocks;				/* The number of async I/O request blocks which will be needed */
	unsigned long					openCloseTimeout;			/* The open/close timeout (in ticks) */
	unsigned long					readWriteTimeout;			/* The read/write timeout (in ticks) */
};
typedef struct gxIOPrefsRec gxIOPrefsRec, *gxIOPrefsPtr, **gxIOPrefsHdl;

/* Constants for the communicationsOptions field of IOPrefsRec. */

enum {
	gxUseCustomIO				= 0x00000001					/* Driver uses a non-standard IO mechanism */
};

/* Information about writing to a file */
struct gxPrintDestinationRec {
	Boolean							printToFile;				/* True if output is to go to a file */
	char							padByte;
	FSSpec							fSpec;						/* If going to a file, the FSSpec for the file */
	char							includeFonts;				/* True if fonts are to be included */
	Str31							fileFormat;					/* Format to write file */
};
typedef struct gxPrintDestinationRec gxPrintDestinationRec, *gxPrintDestinationPtr, **gxPrintDestinationHdl;

/* This structure is the content of each cell in the standard PACK LDEF */
struct gxPortListRec {
	char							firstMarker;				/* Markers to indicate icon or non-icon version */
	char							secondMarker;				/* if these are ≈ and ≈, then the cell is an icon cell. */
/* Otherwise, it is assumed to be a standard text LDEF */
/* cell */
	Handle							iconSuiteHandle;			/* The icon suite to draw for this cell */
	Handle							outputDriverName;			/* Handle to the output driver name (for serial) */
	Handle							inputDriverName;			/* Handle to the input driver name (for serial) */
	Str255							iconName;					/* Name to draw under the icon */
};
typedef struct gxPortListRec gxPortListRec, *gxPortListPtr;

/* ------------------------------------------------------------------------------

						Printing Driver Constants for resources in the desktop printer

-------------------------------------------------------------------------------- */

enum {
	gxDeviceCommunicationsID	= 0
};

/* ----------------------------------• 'prod' •---------------------------------- */
/*
	  For PostScript devices, the device and version names of the device.
	  (0) product name is of type PString
	  (1) version is of type PString
	  (2) revision is of type PString
	  (3) vm available is of type long
	  (4) font stream type is of type scalerStreamTypeFlag
	  (5) language level is of type long
*/
enum {
	gxPostscriptProductInfoType	= 'prod',
	gxPostscriptProductNameID	= 0,
	gxPostscriptVersionID		= 1,
	gxPostscriptRevisionID		= 2,
	gxPostscriptVMAvailableID	= 3,
	gxPostscriptFontStreamTypeID = 4,
	gxPostscriptLanguageLevelID	= 5
};

/* ------------------------------------------------------------------------------

						Printing Driver Constants for status alerts

-------------------------------------------------------------------------------- */
/* Structure passed in statusBuffer of StatusRecord for manual feed alert */
struct gxManualFeedRecord {
	Boolean							canAutoFeed;				/* True if driver can switch to auto feed */
	Str31							paperTypeName;				/* Name of paperType to feed manually */
};
typedef struct gxManualFeedRecord gxManualFeedRecord;

/* Structure passed in statusBuffer of StatusRecord for out of paper alert */
struct gxOutOfPaperRecord {
	Str31							paperTypeName;				/* Name of printing document */
};
typedef struct gxOutOfPaperRecord gxOutOfPaperRecord;

/* The DITL id for the auto feed button in the manual feed alert */

enum {
	gxAutoFeedButtonId			= 3
};

/* Status resource id for the alerts */
enum {
	gxUnivAlertStatusResourceId	= -28508
};

/* Status resource indices for alerts */
enum {
	gxUnivManualFeedIndex		= 2,
	gxUnivFailToPrintIndex		= 3,
	gxUnivPaperJamIndex			= 4,
	gxUnivOutOfPaperIndex		= 5,
	gxUnivNoPaperTrayIndex		= 6,
	gxUnivPrinterReadyIndex		= 7,
	gxUnivAlertBeforeIndex		= 9,
	gxUnivAlertAfterIndex		= 10
};

/* Allocation sizes for status buffers needed for automatic alerts */
enum {
	gxDefaultStatusBufferSize	= 10,
	gxManualFeedStatusBufferSize = 34,
	gxOutOfPaperStatusBufferSize = 42
};

/* ------------------------------------------------------------------------------

								Old Application Support

-------------------------------------------------------------------------------- */
/* The format of a 'cust' resource  */
struct gxCustomizationRec {
	short							horizontalResolution;		/* Horizontal res (integral part) */
	short							verticalResolution;			/* Vertical res (integral part) */
	short							upDriverType;				/* "upDriver" emulation type */
	Point							patternStretch;				/* Pattern stretch factor */
	short							translatorSettings;			/* Translator settings to use */
};
typedef struct gxCustomizationRec gxCustomizationRec, *gxCustomizationPtr, **gxCustomizationHdl;

/* The format of a 'resl' resource */
struct gxResolutionRec {
	short							rangeType;					/* Always 1 */
	short							xMinimumResolution;			/* Min X resolution available */
	short							xMaximumResolution;			/* Max X resolution available */
	short							yMinimumResolution;			/* Min Y resolution available */
	short							yMaximumResolution;			/* Max Y resolution available */
	short							resolutionCount;			/* Number of resolutions */
	Point							resolutions[1];				/* Array of resolutions */
};
typedef struct gxResolutionRec gxResolutionRec, *gxResolutionPtr, **gxResolutionHdl;

/*

		Constants for the "universal" print record.

*/
/* Constant for version number in universal print record */

enum {
	gxPrintRecordVersion		= 8
};

/* Constants for feed field in universal print record */
enum {
	gxAutoFeed					= 0,
	gxManualFeed				= 1
};

/* Constants for options field in universal print record */
enum {
	gxPreciseBitmap				= 0x0001,						/* Tall adjusted (IW), precise bitmap (LW, SC) */
	gxBiggerPages				= 0x0002,						/* No gaps (IW), larger print area (LW) */
	gxGraphicSmoothing			= 0x0004,						/* Graphic smoothing (LW) */
	gxTextSmoothing				= 0x0008,						/* Text smoothing (SC) */
	gxFontSubstitution			= 0x0010,						/* Font substitution */
	gxInvertPage				= 0x0020,						/* B/W invert image */
	gxFlipPageHoriz				= 0x0040,						/* Flip horizontal */
	gxFlipPageVert				= 0x0080,						/* Flip vertical */
	gxColorMode					= 0x0100,						/* Color printing */
	gxBidirectional				= 0x0200,						/* Bidirectional printing */
	gxUserFlag0					= 0x0400,						/* User flag 0 */
	gxUserFlag1					= 0x0800,						/* User flag 1 */
	gxUserFlag2					= 0x1000,						/* User flag 2 */
	gxReservedFlag0				= 0x2000,						/* Reserved flag 0 */
	gxReservedFlag1				= 0x4000,						/* Reserved flag 1 */
	gxReservedFlag2				= 0x8000						/* Reserved flag 2 */
};

/* Constants for orientation field in universal print record */
enum {
	gxPortraitOrientation		= 0,
	gxLandscapeOrientation		= 1,
	gxAltPortraitOrientation	= 2,
	gxAltLandscapeOrientation	= 3
};

/* Constants for qualityMode field in universal print record */
enum {
	gxBestQuality				= 0,
	gxFasterQuality				= 1,
	gxDraftQuality				= 2
};

/* Constants for firstTray and remainingTray fields in universal print record */
enum {
	gxFirstTray					= 0,
	gxSecondTray				= 1,
	gxThirdTray					= 2
};

/* Constants for coverPage field in universal print record */
enum {
	gxNoCoverPage				= 0,
	gxFirstPageCover			= 1,
	gxLastPageCover				= 2
};

/* Constants for headMotion field in universal print record */
enum {
	gxUnidirectionalMotion		= 0,
	gxBidirectionalMotion		= 1
};

/* Constants for saveFile field in universal print record */
enum {
	gxNoFile					= 0,
	gxPostScriptFile			= 1
};

/* The format of the "universal" print record */
struct gxUniversalPrintRecord {
	short							prVersion;					/* Print record version */
/*
														prInfo subrecord
												*/
	short							appDev;						/* Device kind, always 0 */
	short							appVRes;					/* Application vertical resolution */
	short							appHRes;					/* Application horizontal resolution */
	Rect							appPage;					/* Page size, in application resolution */
	Rect							appPaper;					/* Paper rectangle [offset from rPage] */
/*
														prStl subrecord
												*/
	short							devType;					/* Device type, always 0xA900 (was wDev) */
	short							pageV;						/* Page height in 120ths of an inch */
	short							pageH;						/* Page width in 120ths of an inch */
	char							fillByte;					/* Page calculation mode */
	char							feed;						/* Feed mode */
/*
														prInfoPT subrecord
												*/
	short							devKind;					/* Device kind, always 0 */
	short							devVRes;					/* Device vertical resolution */
	short							devHRes;					/* Device horizontal resolution */
	Rect							devPage;					/* Device page size */
/*
														prXInfo subrecord
												*/
	short							actualCopies;				/* Actual number of copies for this job */
	short							options;					/* Options for this device */
	short							reduction;					/* Reduce/enlarge factor */
	char							orientation;				/* Orientation of paper ( 0=portrait, 1=landscape ) */
/*
														Clusters and PopUps
												*/
	char							qualityMode;				/* Quality mode */
	char							coverPage;					/* Cover page */
	char							firstTray;					/* First feed tray */
	char							remainingTray;				/* Remaining feed tray */
	char							headMotion;					/* Head motion */
	char							saveFile;					/* Save file */
	char							userCluster1;				/* Three clusters left over */
	char							userCluster2;
	char							userCluster3;
/*
														prJob subrecord
												*/
	short							firstPage;					/* First page */
	short							lastPage;					/* Last page */
	short							copies;						/* Number of copies, always 1 */
	char							reserved1;					/* Always true, unused */
	char							reserved2;					/* Always true, unused */
	PrIdleUPP						pIdleProc;					/* Idle proc */
	Ptr								pFileName;					/* Spool file name pointer */
	short							fileVol;					/* Spool file vRefNum */
	char							fileVers;					/* File version, must be 0 */
	char							reserved3;					/* Always 0 */
	short							printX[19];					/* Internal use */
};
typedef struct gxUniversalPrintRecord gxUniversalPrintRecord, *gxUniversalPrintRecordPtr, **gxUniversalPrintRecordHdl;

/* ------------------------------------------------------------------------------

							Compatibility Printing Messages

-------------------------------------------------------------------------------- */
extern OSErr Forward_GXPrOpenDoc(THPrint hPrint, TPPrPort *pPort)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Forward_GXPrCloseDoc(TPPrPort pPort)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Forward_GXPrOpenPage(TPPrPort pPort, TPRect pRect, Point resolution)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Forward_GXPrClosePage(TPPrPort pPort)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Forward_GXPrintDefault(THPrint hPrint)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Forward_GXPrStlDialog(THPrint hPrint, Boolean *confirmed)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Forward_GXPrJobDialog(THPrint hPrint, Boolean *confirmed)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Forward_GXPrStlInit(THPrint hPrint, TPPrDlgRef *pDlg)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Forward_GXPrJobInit(THPrint hPrint, TPPrDlgRef *pDlg)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Forward_GXPrDlgMain(THPrint hPrint, PDlgInitUPP initProc, Boolean *confirmed)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Forward_GXPrValidate(THPrint hPrint, Boolean *changedPrintRecord)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Forward_GXPrJobMerge(THPrint srcPrint, THPrint destPrint)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Forward_GXPrGeneral(Ptr dataPtr)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Forward_GXConvertPrintRecordTo(THPrint hPrint)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Forward_GXConvertPrintRecordFrom(THPrint hPrint)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Forward_GXPrintRecordToJob(THPrint hPrint, gxJob aJob)
 TWOWORDINLINE(0x7036, 0xABFB);
/* ------------------------------------------------------------------------------

						Raster Driver Contants and Types

-------------------------------------------------------------------------------- */
typedef long gxRasterPlaneOptions;

/* Input structure for setting up the offscreen */
struct gxPlaneSetupRec {
	gxRasterPlaneOptions			planeOptions;				/* Options for the offscreen package */
	gxHalftone						planeHalftone;				/* OPTIONAL: halftone structure for this plane */
	gxColorSpace					planeSpace;					/* OPTIONAL: noSpace will get the graphics default */
	gxColorSet						planeSet;					/* OPTIONAL: NIL gets the default */
	gxColorProfile					planeProfile;				/* OPTIONAL: NIL gets no matching */
};
typedef struct gxPlaneSetupRec gxPlaneSetupRec;

/* Constants for planeOptions field in gxPlaneSetupRec */

enum {
	gxDefaultOffscreen			= 0x00000000,					/* Default value - bits are allocated for the client, halftoning takes place */
	gxDontSetHalftone			= 0x00000001,					/* Don't call SetViewPortHalftone */
	gxDotTypeIsDitherLevel		= 0x00000002					/* Call SetViewPortDither using the dotType as the level */
};

struct gxOffscreenSetupRec {
	short							width;						/* Width in pixels */
	short							minHeight;					/* Minimum height in pixels - actual height returned here */
	short							maxHeight;					/* Maximum height in pixels */
	Fixed							ramPercentage;				/* Maximum percentage of RAM to take */
	long							ramSlop;					/* Amount of RAM to be sure to leave */
	short							depth;						/* Depths in bits of each plane */
	gxMapping						vpMapping;					/* Mapping to assign to offscreen viewPorts */
	gxMapping						vdMapping;					/* Mapping to assign to offscreen viewDevices */
	short							planes;						/* Number of planes to allocate of depth bits each (can be more than 4) */
	gxPlaneSetupRec					planeSetup[4];				/* Parameters for each plane, 4 is provided because it is most handy for writers of devices */
};
typedef struct gxOffscreenSetupRec gxOffscreenSetupRec;

/* The format of one plane in the offscreen planar area */
struct gxOffscreenPlaneRec {
	gxViewPort						theViewPort;				/* viewPort for the offscreen */
	gxViewDevice					theDevice;					/* viewDevice for the offscreen */
	gxViewGroup						theViewGroup;				/* The viewGroup that they share */
	gxShape							theBitmap;					/* The offscreen bitmap shape */
	gxBitmap						theBits;					/* The bits of the offscreen */
};
typedef struct gxOffscreenPlaneRec gxOffscreenPlaneRec;

/* The format of an entire offscreen area */
struct gxOffscreenRec {
	short							numberOfPlanes;				/* Number of planes we have */
	Handle							offscreenStorage;			/* Handle containing the bitmaps image data */
	gxOffscreenPlaneRec				thePlanes[1];				/* Planes to draw in */
};
typedef struct gxOffscreenRec gxOffscreenRec, *gxOffscreenPtr, **gxOffscreenHdl;

typedef long gxRasterRenderOptions;

/* Structure that mirrors 'rdip' resource. */
struct gxRasterPrefsRec {
	gxRasterRenderOptions			renderOptions;				/* Options for the raster imaging system */
	Fixed							hImageRes;					/* Horizontal resolution to image at */
	Fixed							vImageRes;					/* Vertical resolution to image at */
	short							minBandSize;				/* Minimum band size to use (in pixels) */
	short							maxBandSize;				/* Maximum band size to use (in pixels), 0 == entire page */
	Fixed							ramPercentage;				/* Maximum percentage of RAM to take */
	long							ramSlop;					/* Amount of RAM to be sure to leave */
	short							depth;						/* Depth in pixels (PER PLANE!) */
	short							numPlanes;					/* Number of planes to render */
	gxPlaneSetupRec					planeSetup[1];				/* One for each plane */
};
/* Constants for renderOptions field in gxRasterPrefsRec. */

enum {
	gxDefaultRaster				= 0x00000000,					/* Default raster options */
	gxDontResolveTransferModes	= 0x00000001,					/* 0=Resolve, 1=Don't Resolve */
	gxRenderInReverse			= 0x00000002,					/* Traverse image in reverse order */
	gxOnePlaneAtATime			= 0x00000004,					/* Render each plane separately */
	gxSendAllBands				= 0x00000008					/* Send even empty bands */
};

typedef struct gxRasterPrefsRec gxRasterPrefsRec, *gxRasterPrefsPtr, **gxRasterPrefsHdl;

typedef long gxRasterPackageOptions;

/* Structure that mirrors 'rpck' resource. */
struct gxRasterPackageRec {
	Ptr								bufferSize;					/* Buffer size for packaging (>= maximum head pass size) */
	short							colorPasses;				/* 1 (b/w) or 4 (CMYK) is typical */
	short							headHeight;					/* Printhead height in pixels */
	short							numberPasses;				/* Number of head passes it takes to == iHeadHeight */
	short							passOffset;					/* Offset between passes, in pixels */
	gxRasterPackageOptions			packageOptions;				/* Packaging options */
};
typedef struct gxRasterPackageRec gxRasterPackageRec, *gxRasterPackagePtr, **gxRasterPackageHdl;

/* Constants for packageOptions field in gxRasterPackageRec. */

enum {
	gxSendAllColors				= 0x00000001,					/* Send even clean bands through */
	gxInterlaceColor			= 0x00000002,					/* Ribbon contamination is a concern */
	gxOverlayColor				= 0x00000004,					/* Color printer without a ribbon problem */
	gxUseColor					= (gxInterlaceColor | gxOverlayColor) /* This is a color printer */
};

/* Structure for RasterPackageBitmap message */
struct gxRasterPackageBitmapRec {
	gxBitmap						*bitmapToPackage;			/* Bitmap containing the data to package */
	unsigned short					startRaster;				/* Raster to begin the packaging from */
	unsigned short					colorBand;					/* For which color pass this is a packaging request */
	Boolean							isBandDirty;				/* Whether there are any dirty bits in this band */
	char							padByte;
	Rect							dirtyRect;					/* Which bits are dirty */
};
typedef struct gxRasterPackageBitmapRec gxRasterPackageBitmapRec;

/* Structure of number record in gxRasterPackageControlsRec */
struct gxStandardNumberRec {
	short							numberType;					/* Type of numberic output desired */
	short							minWidth;					/* Minimum output width of the number */
	char							padChar;					/* Pad character for numbers shorter than the minWidth */
	char							padChar2;
	Str31							startString;				/* Prefix string */
	Str31							endString;					/* Postfix string */
};
typedef struct gxStandardNumberRec gxStandardNumberRec, *gxStandardNumberPtr;

/* Structure that mirrors 'ropt' resource */
struct gxRasterPackageControlsRec {
	short							startPageStringID;			/* 'wstr' to send to the device at start of page */
	short							formFeedStringID;			/* 'wstr' to send to the device to cause a form feed */
	short							forwardMax;					/* Line feed strings */
	gxStandardNumberRec				forwardLineFeed;			/* Number record for forward line feed */
	short							reverseMax;					/* Max number of reverse line feeds device can do */
	gxStandardNumberRec				reverseLineFeed;			/* Number record for forward line feed */
};
typedef struct gxRasterPackageControlsRec gxRasterPackageControlsRec, *gxRasterPackageControlsPtr, **gxRasterPackageControlsHdl;

/* Raster imaging system imageData structure */
struct gxRasterImageDataRec {
	gxRasterRenderOptions			renderOptions;				/* Options for the raster imaging system */
	Fixed							hImageRes;					/* horizontal resolution to image at */
	Fixed							vImageRes;					/* vertical resolution to image at */
	short							minBandSize;				/* smallest band that makes sense for this device */
	short							maxBandSize;				/* biggest band that makes sense, or 0 for "full page" */
	gxRectangle						pageSize;					/* size of page for device */
/*
			Values used within the RasterDataIn message
	*/
	short							currentYPos;				/* Current position moving down the page */
	gxRasterPackageRec				packagingInfo;				/* Raster packaging record */
/*
			Values used within the remaining messages
	*/
	Boolean							optionsValid;				/* Were options specified by the driver? */
	char							padByte;
	gxRasterPackageControlsRec		packageControls;			/* Options for the packaging messages */
	gxOffscreenSetupRec				theSetup;					/* setup for the offscreen code, variable length componant */
};
typedef struct gxRasterImageDataRec gxRasterImageDataRec, *gxRasterImageDataPtr, **gxRasterImageDataHdl;

/* ------------------------------------------------------------------------------

								Raster Driver Imaging Messages

-------------------------------------------------------------------------------- */
extern OSErr Send_GXRasterDataIn(gxOffscreenHdl offScreen, gxRectangle *bandRectangle, gxRectangle *dirtyRectangle)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 0, 0xABFB);
extern OSErr Forward_GXRasterDataIn(gxOffscreenHdl offScreen, gxRectangle *bandRectangle, gxRectangle *dirtyRectangle)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXRasterLineFeed(long *lineFeedSize, Ptr buffer, unsigned long *bufferPos, gxRasterImageDataHdl imageDataHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 1, 0xABFB);
extern OSErr Forward_GXRasterLineFeed(long *lineFeedSize, Ptr buffer, unsigned long *bufferPos, gxRasterImageDataHdl imageDataHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXRasterPackageBitmap(gxRasterPackageBitmapRec *whatToPackage, Ptr buffer, unsigned long *bufferPos, gxRasterImageDataHdl imageDataHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 2, 0xABFB);
extern OSErr Forward_GXRasterPackageBitmap(gxRasterPackageBitmapRec *whatToPackage, Ptr buffer, unsigned long *bufferPos, gxRasterImageDataHdl imageDataHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
/* ------------------------------------------------------------------------------

						Vector Driver Contants and Types

-------------------------------------------------------------------------------- */
/* Vector device halftone component record */
struct gxVHalftoneCompRec {
	Fixed							angle;						/* Angle to halftone at. Must be 0, 90, 45 or 135 */
	long							penIndex;					/* index of the pen to draw this component with */
};
typedef struct gxVHalftoneCompRec gxVHalftoneCompRec;

/* Vector device halftone record */
struct gxVHalftoneRec {
	gxColorSpace					halftoneSpace;
	gxVHalftoneCompRec				halftoneComps[4];			/* Info for each color component */
	long							penIndexForBW;				/* Pen index to draw one bit deep or black and white bitmap with */
};
typedef struct gxVHalftoneRec gxVHalftoneRec;

/* Vector shape rendering information */
typedef long gxVectorShapeOptions;

struct gxVectorShapeDataRec {
	gxVectorShapeOptions			shapeOptions;				/* Options to control shape handling */
	long							maxPolyPoints;				/* Maximum number of polygon points that device can support */
	Fixed							shapeError;					/* Defines allowed deviation from the original shape */
	Fixed							textSize;					/* Text above this size is filled; text below this size is outlined */
	Fixed							frameSize;					/* Frame's smaller than this -> shape stroked; frame's larger -> shape is filled */
};
typedef struct gxVectorShapeDataRec gxVectorShapeDataRec;

/* Constants for shapeOptions field in gxVectorShapeDataRec. */

enum {
	gxUnidirectionalFill		= 0x00000001,					/* Generate scanlines in one direction only.  Useful for transparencies */
	gxAlsoOutlineFilledShape	= 0x00000002					/* Turn on this bit to also outline solid filled shapes */
};

/* Vector device rendering information */
typedef long gxVectorRenderOptions;

/* Vector imaging system imageData structure */
struct gxVectorImageDataRec {
	gxVectorRenderOptions			renderOptions;				/* Options to control rendering: color sort, clipping, etc. */
	Fixed							devRes;						/* Device resolution */
	gxTransform						devTransform;				/* Mapping, clip and halftoning information for colored bitmaps */
	gxColorSet						clrSet;						/* Entire set of colors; usually indexed color space for pen plotters */
	gxColor							bgColor;					/* The background color in the color space specified by the clrSpace field */
	gxVHalftoneRec					halftoneInfo;				/* Defines halftone information for color bitmaps */
	gxPenTableHdl					hPenTable;					/* Complete list of pens along with their pen positions and thickness */
	gxRectangle						pageRect;					/* Page dimensions */
	gxVectorShapeDataRec			shapeData;					/* Information on how to render a shape */
};
typedef struct gxVectorImageDataRec gxVectorImageDataRec, *gxVectorImageDataPtr, **gxVectorImageDataHdl;

/* Constants for renderOptions field in gxVectorImageDataRec. */

enum {
	gxColorSort					= 0x00000001,					/* Set for pen plotters */
	gxATransferMode				= 0x00000002,					/* Set if transfer modes need to be resolved */
	gxNoOverlap					= 0x00000004,					/* Set if non-overlapping output is desired*/
	gxAColorBitmap				= 0x00000008,					/* Set if color bitmap output is desired */
	gxSortbyPenPos				= 0x00000010,					/* Set if shapes are to be drawn in the order of the pen index */
/* in the pen table. NOTE: this is not the pen position in the carousel */
	gxPenLessPlotter			= 0x00000020,					/* Indicates raster printer/plotter */
	gxCutterPlotter				= 0x00000040,					/* Indicates cutter */
	gxNoBackGround				= 0x00000080					/* Set if shapes that map to the background color should not be sent to driver */
};

/* ------------------------------------------------------------------------------

								Vector Driver Imaging Messages

-------------------------------------------------------------------------------- */
extern OSErr Send_GXVectorPackageShape(gxShape theShape, long penIndex)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 0, 0xABFB);
extern OSErr Forward_GXVectorPackageShape(gxShape theShape, long penIndex)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXVectorLoadPens(gxPenTableHdl penTable, long *shapeCounts, Boolean *penTableChanged)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 1, 0xABFB);
extern OSErr Forward_GXVectorLoadPens(gxPenTableHdl penTable, long *shapeCounts, Boolean *penTableChanged)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXVectorVectorizeShape(gxShape theShape, long penIndex, gxVectorShapeDataRec *vectorData)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 2, 0xABFB);
extern OSErr Forward_GXVectorVectorizeShape(gxShape theShape, long penIndex, gxVectorShapeDataRec *vectorData)
 TWOWORDINLINE(0x7036, 0xABFB);
/* ------------------------------------------------------------------------------

							PostScript Driver Contants and Types

-------------------------------------------------------------------------------- */

enum {
	gxPostSynonym				= (long)'post'
};

/* PostScript glyphs record */
struct gxPrinterGlyphsRec {
	gxFont							theFont;					/*  ---> Font reference */
	long							nGlyphs;					/*  ---> Number of glyphs in the font */
	gxFontPlatform					platform;					/* <---  How printer font is encoded */
	gxFontScript					script;						/* <---  Script if platform != glyphPlatform */
	gxFontLanguage					language;					/* <---  Language if platform != glyphPlatform */
	long							vmUsage;					/* <---  How much PostScript VM font uses */
/* Size of this array is long-alligned(nGlyphs) */
	unsigned long					glyphBits[1];				/* <---  Bit array of which system glyphs are in printer */
};
typedef struct gxPrinterGlyphsRec gxPrinterGlyphsRec;

/* PostScript device rendering information */
typedef long gxPostScriptRenderOptions;

struct gxPostScriptImageDataRec {
	short							languageLevel;				/* PostScript language level */
	gxColorSpace					devCSpace;					/* The printer's color space */
	gxColorProfile					devCProfile;				/* The printer's color profile for matching */
	gxPostScriptRenderOptions		renderOptions;				/* Options for the imaging system */
	long							pathLimit;					/* Maximum path size */
	short							gsaveLimit;					/* Maximum number of gsaves allowed */
	short							opStackLimit;				/* Operand stack limit */
	scalerStreamTypeFlag			fontType;					/* These are the font types that the printer supports  */
	long							printerVM;					/* How much memory is in the printer */
	long							reserved0;
};
typedef struct gxPostScriptImageDataRec gxPostScriptImageDataRec, *gxPostScriptImageDataPtr, **gxPostScriptImageDataHdl;

/* Constants for renderOptions field in gxPostScriptImageDataRec. */

enum {
	gxNeedsHexOption			= 0x00000001,					/* Convert all binary data to hex */
	gxNeedsCommentsOption		= 0x00000002,					/* Issue PostScript comments */
	gxBoundingBoxesOption		= 0x00000004,					/* Calculate the values for %%BoundingBox: and %%PageBoundingBox: -- requires needsCommentsOption */
	gxPortablePostScriptOption	= 0x00000008,					/* Generate portable PostScript */
	gxTextClipsToPathOption		= 0x00000010,					/* Convert all clips that are composed of text to path shapes */
	gxFlattenClipPathOption		= 0x00000020,					/* Convert all clips that are path shapes to polygons (helps better control point limit) */
	gxUseCharpath1Option		= 0x00000040,					/* (ignored if text clips are converted to paths)  When the clip is text,  */
/* Do it one glyph at a time, redrawing the main shape each time */
	gxUseLevel2ColorOption		= 0x00000080,					/* When printing to level-2 use level-2 device independent color */
	gxNoEPSIllegalOperators		= 0x00000100,					/* Don't use any operators prohibited by the Encapsulated PostScript File Format V3.0 */
	gxEPSTargetOption			= gxNoEPSIllegalOperators + gxNeedsCommentsOption + gxBoundingBoxesOption /* PostScript intended for EPS Use. */
};

/* Structure for gxPostScriptGetProcSetList / gxPostScriptDownLoadProcSetList */
struct gxProcSetListRec {
	gxOwnerSignature				clientid;
	OSType							controlType;				/* The driver will call FetchTaggedData on each of these resources */
	short							controlid;
	OSType							dataType;
	long							reserved0;
};
typedef struct gxProcSetListRec gxProcSetListRec, *gxProcSetListPtr, **gxProcSetListHdl;

/* Possible results of querying printer (returned by gxPostScriptQueryPrinter message) */

enum {
	gxPrinterOK					= 0,
	gxIntializePrinter			= 1,
	gxFilePrinting				= 2,
	gxResetPrinter				= 128
};

/* ------------------------------------------------------------------------------

								PostScript Driver Imaging Messages

-------------------------------------------------------------------------------- */
extern OSErr Send_GXPostScriptQueryPrinter(long *queryData)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 0, 0xABFB);
extern OSErr Forward_GXPostScriptQueryPrinter(long *queryData)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXPostScriptInitializePrinter(void)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 1, 0xABFB);
extern OSErr Forward_GXPostScriptInitializePrinter(void)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXPostScriptResetPrinter(void)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 2, 0xABFB);
extern OSErr Forward_GXPostScriptResetPrinter(void)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXPostScriptExitServer(void)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 3, 0xABFB);
extern OSErr Forward_GXPostScriptExitServer(void)
 TWOWORDINLINE(0x7036, 0xABFB);
/*

		Device communication messages

*/
extern OSErr Send_GXPostScriptGetStatusText(Handle textHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 4, 0xABFB);
extern OSErr Forward_GXPostScriptGetStatusText(Handle textHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXPostScriptGetPrinterText(Handle textHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 5, 0xABFB);
extern OSErr Forward_GXPostScriptGetPrinterText(Handle textHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXPostScriptScanStatusText(Handle textHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 6, 0xABFB);
extern OSErr Forward_GXPostScriptScanStatusText(Handle textHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXPostScriptScanPrinterText(Handle textHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 7, 0xABFB);
extern OSErr Forward_GXPostScriptScanPrinterText(Handle textHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
/*

		Proc set management messages

*/
extern OSErr Send_GXPostScriptGetDocumentProcSetList(gxProcSetListHdl procSet, gxPostScriptImageDataHdl imageDataHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 8, 0xABFB);
extern OSErr Forward_GXPostScriptGetDocumentProcSetList(gxProcSetListHdl procSet, gxPostScriptImageDataHdl imageDataHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXPostScriptDownloadProcSetList(gxProcSetListHdl procSet, gxPostScriptImageDataHdl imageDataHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 9, 0xABFB);
extern OSErr Forward_GXPostScriptDownloadProcSetList(gxProcSetListHdl procSet, gxPostScriptImageDataHdl imageDataHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
/*

		Font management messages

*/
extern OSErr Send_GXPostScriptGetPrinterGlyphsInformation(gxPrinterGlyphsRec *glyphsInfo)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 10, 0xABFB);
extern OSErr Forward_GXPostScriptGetPrinterGlyphsInformation(gxPrinterGlyphsRec *glyphsInfo)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXPostScriptStreamFont(gxFont fontref, scalerStream *streamPtr)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 11, 0xABFB);
extern OSErr Forward_GXPostScriptStreamFont(gxFont fontref, scalerStream *streamPtr)
 TWOWORDINLINE(0x7036, 0xABFB);
/*

		Document structuring and formatting messages

*/
extern OSErr Send_GXPostScriptDoDocumentHeader(gxPostScriptImageDataHdl imageDataHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 12, 0xABFB);
extern OSErr Forward_GXPostScriptDoDocumentHeader(gxPostScriptImageDataHdl imageDataHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXPostScriptDoDocumentSetup(gxPostScriptImageDataHdl imageDataHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 13, 0xABFB);
extern OSErr Forward_GXPostScriptDoDocumentSetup(gxPostScriptImageDataHdl imageDataHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXPostScriptDoDocumentTrailer(gxPostScriptImageDataHdl imageDataHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 14, 0xABFB);
extern OSErr Forward_GXPostScriptDoDocumentTrailer(gxPostScriptImageDataHdl imageDataHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
/*

		Page structuring and formatting messages

*/
extern OSErr Send_GXPostScriptDoPageSetup(gxFormat pageFormat, long thePage, gxPostScriptImageDataHdl imageDataHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 15, 0xABFB);
extern OSErr Forward_GXPostScriptDoPageSetup(gxFormat pageFormat, long thePage, gxPostScriptImageDataHdl imageDataHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXPostScriptSelectPaperType(gxPaperType thePapertype, long thePage, gxPostScriptImageDataHdl imageDataHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 16, 0xABFB);
extern OSErr Forward_GXPostScriptSelectPaperType(gxPaperType thePapertype, long thePage, gxPostScriptImageDataHdl imageDataHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXPostScriptDoPageTrailer(gxPostScriptImageDataHdl imageDataHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 17, 0xABFB);
extern OSErr Forward_GXPostScriptDoPageTrailer(gxPostScriptImageDataHdl imageDataHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXPostScriptEjectPage(gxPaperType thePapertype, long pagenumber, long copiescount, long erasepage, gxPostScriptImageDataHdl imageDataHdl)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 18, 0xABFB);
extern OSErr Forward_GXPostScriptEjectPage(gxPaperType thePapertype, long pagenumber, long copiescount, long erasepage, gxPostScriptImageDataHdl imageDataHdl)
 TWOWORDINLINE(0x7036, 0xABFB);
extern OSErr Send_GXPostScriptEjectPendingPage(Boolean *pageWasEjected)
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 20, 0xABFB);
extern OSErr Forward_GXPostScriptEjectPendingPage(Boolean *pageWasEjected)
 TWOWORDINLINE(0x7036, 0xABFB);
/*

		Shape imaging messages

*/
extern OSErr Send_GXPostScriptProcessShape(gxShape page, long trcount, gxTransform trlist[])
 FIVEWORDINLINE(0x7032, 0x223C, 0x0001, 19, 0xABFB);
extern OSErr Forward_GXPostScriptProcessShape(gxShape page, long trcount, gxTransform trlist[])
 TWOWORDINLINE(0x7036, 0xABFB);
/* ------------------------------------------------------------------------------

											Driver API Functions

-------------------------------------------------------------------------------- */

enum {
	gxMissingImagePointer		= -4
};

extern OSErr GXAddPrinterViewDevice(gxPrinter thePrinter, gxViewDevice theViewDevice)
 FOURWORDINLINE(0x203C, 0x0002, 0, 0xABFE);
extern OSErr GXGetAvailableJobFormatModes(gxJobFormatModeTableHdl *theFormatModes)
 FOURWORDINLINE(0x203C, 0x0002, 1, 0xABFE);
extern OSErr GXSetPreferredJobFormatMode(gxJobFormatMode theFormatMode, Boolean directOnly)
 FOURWORDINLINE(0x203C, 0x0002, 2, 0xABFE);
extern OSErr GXPrintingAlert(long iconId, long txtSize, long defaultTitleNum, long cancelTitleNum, long textLength, Ptr pAlertMsg, StringPtr actionTitle, StringPtr title2, StringPtr title3, StringPtr msgFont, ModalFilterUPP filterProc, short *itemHit, StringPtr alertTitle)
 FOURWORDINLINE(0x203C, 0x0002, 3, 0xABFE);
extern OSErr GXGetPrintingAlert(long alertResId, ModalFilterUPP filterProc, short *itemHit)
 FOURWORDINLINE(0x203C, 0x0002, 4, 0xABFE);
extern OSErr GXFetchDTPData(Str31 dtpName, OSType theType, long theID, Handle *theData)
 FOURWORDINLINE(0x203C, 0x0002, 5, 0xABFE);
extern OSErr GXWriteDTPData(Str31 dtpName, OSType theType, long theID, Handle theData)
 FOURWORDINLINE(0x203C, 0x0002, 6, 0xABFE);
extern OSErr GXHandleChooserMessage(gxJob *aJob, Str31 driverName, long message, long caller, StringPtr objName, StringPtr zoneName, ListHandle theList, long p2)
 FOURWORDINLINE(0x203C, 0x0002, 7, 0xABFE);

#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __GXPRINTERDRIVERS__ */

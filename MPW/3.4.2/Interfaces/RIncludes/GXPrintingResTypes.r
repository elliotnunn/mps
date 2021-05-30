/*
	File:		GXPrintingResTypes.r

	Contains:	This file contains the resource descriptions used by
				writers of applications, printer drivers and printing
				extensions.

	Version:	Quickdraw GX 1.1 for ETO #18

	Copyright:	© 1994-1995 by Apple Computer, Inc., all rights reserved.
*/


#ifndef _GXPRINTINGRESTYPES_
#define _GXPRINTINGRESTYPES_

#include "GXPrintingResEquates.r"


// -------------------------------------------------------------------------------
// Resource definitions used by applications, extension and driver writers
// -------------------------------------------------------------------------------

// 'cltn' - definition of a collection resource

type gxCollectionType {
	longint = $$CountOf(ItemArray);
	array ItemArray
		{
		longint;	// tag
		longint;	// id
			boolean		itemUnlocked			=	false,	// defined attributes bits...
						itemLocked				=	true;
			boolean		itemNonPersistent		=	false,
						itemPersistent			=	true;
			unsigned bitstring[14] = 0;						// reserved attributes bits...
			unsigned bitstring[16];							// user attributes bits...
		wstring;
		align word;
	};
};



// -------------------------------------------------------------------------------
// Resource definitions used by both extension and driver writers
// -------------------------------------------------------------------------------

type gxOverrideType
	{
	integer = $$CountOf(OverrideArray);
	array OverrideArray {
		integer;							// enabled Message ID
		unsigned bitstring[4] = 0;
		unsigned bitstring[12]; 			// dispatchResID
		integer;							//	codeOffset
		longint = -1;
	};
};


// -------------------------------------------------------------------------------
// Resource definitions REQUIRED by extension writers
// -------------------------------------------------------------------------------

type gxExtensionScopeType {
	
	integer = $$CountOf(ScopeArray);
	
	array ScopeArray {
		longint;			//	scope OSType
	};
};

type gxExtensionLoadType {

	longint;				//	load Priority
};

type gxExtensionOptimizationType {

	boolean		gxExecuteDuringImaging			=	true,
				gxDontExecuteDuringImaging		=	false;
	boolean		gxNeedDeviceStatus				=	true,
				gxDontNeedDeviceStatus			=	false;
	boolean		gxChangePageAtGXDespoolPage		=	true,
				gxDontChangePageAtGXDespoolPage	=	false;
	boolean		gxChangePageAtGXImagePage		=	true,
				gxDontChangePageAtGXImagePage	=	false;
	boolean		gxChangePageAtGXRenderPage		=	true,
				gxDontChangePageAtGXRenderPage	=	false;
	boolean		gxServerPresenceRequired		=	true,
				gxNotServerPresenceRequired		=	false;
	boolean		gxClientPresenceRequired		=	true,
				gxNotClientPresenceRequired		=	false;
	unsigned bitstring[25] = 0;							// reserved flags
};


// -------------------------------------------------------------------------------
// Resource definitions REQUIRED by driver writers
// -------------------------------------------------------------------------------

// imaging system selection
type gxImagingSystemSelectorType
	{
	longint;		// type of imaging system to select
};


#define gxDefaultOptionsTranslation		0x0000
#define gxOptimizedTranslation		 	0x0001
#define gxReplaceLineWidthTranslation 	0x0002
#define gxSimpleScalingTranslation	 	0x0004
#define gxSimpleGeometryTranslation	 	0x0008	/* implies simple scaling */
#define gxSimpleLinesTranslation		0x000C	/* implies simple geometry & scaling */
#define gxLayoutTextTranslation		 	0x0010	/* turn on gxLine layout (normally off) */
#define gxRasterTargetTranslation		0x0020
#define gxPostScriptTargetTranslation	0x0040
#define gxVectorTargetTranslation		0x0080

type gxCustType
	{
	integer; 										// horizontalResolution;
	integer; 										// verticalResolution;
	integer 	defaultUpDriver 	= 0,
				laserWriter 		= 0,
				laserWriterSC 		= 1;			// upDriverType

	point;											// pattern stretch factor
	integer;										// translator settings
	};

type gxReslType
	{
	integer	rangeType = 1; 								// constant;
	integer;											//	xMinimumResolution
	integer;											//	xMaximumResolution
	
	integer;											//	yMinimumResolution
	integer;											//	yMaximumResolution
	
	integer = $$CountOf(ResolutionArray);
	array		ResolutionArray
		{
		integer;										// xResolution
		integer;										// yResolution
		};
	};



type gxPrintRecordType (3)
	{
	integer;								/* count: number of paper types */
	point;								/* a paper type's bottom/left coordinate */
	point;								/* ...expressed in 120th of an inch */
	point;								/* There are always six of them */
	point;
	point;
	point;
	pstring;								/* The paper type name */
	pstring;								/* The paper type name */
	pstring;								/* The paper type name */
	pstring;								/* The paper type name */
	pstring;								/* The paper type name */
	pstring;								/* The paper type name */
	};



// IO RELATED RESOURCES

// the "look"er resource defines the list of things to look for - and thus the types
// of communications this device will support.


#define isAppleTalk		1			/* looker type is AppleTalk */
#define iconCells		2			/* looker wants large cells w/ icons in them */
#define isPrinterShare	4			/* looker is for a PrinterShare connection */

type gxLookerType (-4096) {
	integer;						// looker to select by default
	integer = $$CountOf(LookerList);
	array LookerList {
		pstring[33];					// name of looker - displayed to user in list
		align word;
		integer;						// id of 'comm' resource for this looker;
		longint noFlags = 0;			// flags for this looker
		pstring[33];					// NBP type, or default item name for non-AppleTalk
	};
};


// -------------------------------------------------------------------------------
// Resource definitions optional for driver writers
// -------------------------------------------------------------------------------
/* this resource should be included in specific drivers that wish to supply driver */
/* specific output file formats for the print to file option.  The pstrings will */
/* be added to the standard file dialog popup menu when the user confirms the  */
/* print dialog after selecting 'Print to a file'.  The job contains a destination */
/* record which is updated from this dialog.  The destination record specifies */
/* whether output is to go to the printer or to disk.  If it is to go to disk */
/* the format string in the record will designate the format of the file to create. */
/* the format string will either be 'Print File' specifying a spool file or */
/* a string the driver has provided through this resource.  */

type gxDriverFileFormatType {
	integer = $$Countof(fileFormatArray);
	array fileFormatArray {
		pstring;								/* what to show in menu - formatname */
		};
	};

type gxDestinationAdditionType {
	integer = $$Countof(additionArray);
	array additionArray {
		pstring;								/* what to show in menu - formatname */
		pstring;								/* change Print button to this string */
		};
	};

// IO RELATED RESOURCES

// Connection to the printer control resources 													*/
type gxDeviceCommunicationsType
{
	switch 
		{
		case Serial:
			key unsigned longint='SPTL';																/* Communications type identifier */
		
			integer						baud300 = 380, baud600 = 189, baud1200 = 94, baud1800 = 62, /* Output baud rate */
											baud2400 = 46, baud3600 = 30, baud4800 = 22, baud7200 = 14, 
											baud9600 = 10, baud19200 = 4, baud38400 = 2, baud57600 = 0;
			integer						noParity = 0, oddParity = 4096, evenParity = 12288;			/* Output parity */
			integer						oneStop = 16384, oneFiveStop = -32768, twoStop = -16384;		/* Output stop bits */
			integer						data5 = 0, data6 = 2048, data7 = 1024, data8 = 3072;			/* Output data bits */
			unsigned hex longint;																		/* Output handshaking high word */
			unsigned hex longint;																		/* Output handshaking low word */
			integer						baud300 = 380, baud600 = 189, baud1200 = 94, baud1800 = 62, /* Input baud rate */
											baud2400 = 46, baud3600 = 30, baud4800 = 22, baud7200 = 14, 
											baud9600 = 10, baud19200 = 4, baud38400 = 2, baud57600 = 0;
			integer						noParity = 0, oddParity = 4096, evenParity = 12288;			/* Input parity */
			integer						oneStop = 16384, oneFiveStop = -32768, twoStop = -16384;		/* Input stop bits */
			integer						data5 = 0, data6 = 2048, data7 = 1024, data8 = 3072;			/* Input data bits */
			unsigned hex longint;																		/* Input handshaking high word */
			unsigned hex longint;																		/* Input handshaking low word */
			integer;																							/* Serial input buffer size */
			pstring[63];																					/* Input port name */
			pstring[63];																					/* Output port name */
			
		case PAP:
			key unsigned longint='PPTL';		/* Communications type identifier */
			integer;									/* Flow quantum */
			string[99];								/* Compacted AppleTalk name of printer */
			fill byte;
			longint;									/* future use - must be nil */
			longint;									/* future use - must be nil */
			longint;									/* future use - must be nil */
			longint;									/* Most recent network address of the printer */
			
		case SCSI:
			key unsigned longint='sPTL';		/* Communications type identifier */
			longint;									/* future use - must be nil */
			integer;									/* SCSI I/O attributes applicable to data transfers*/
			longint;									/* future use - must be nil */
			integer;									/* SCSI bus number where device is located. 0 = motherboard */
			integer;									/* SCSI device number of device. */
			longint;									/* 0 => ignored; > 0 => break data transfer into chunks of this size */
														/* (at SCSI TIB level) */
			longint;									/* future use - must be nil */
			integer;									/* deviceType to look for */
			integer;									/* minimum amount of data in the response */
			integer;									/* offset from start to look in the response data */
			pstring;									/* string to look for in the response data */
			
		case PrinterShare:
			key unsigned longint='ptsr';		/* Communications type identifier */
			string[99];								/* Compacted AppleTalk name of server */
			fill byte;
			longint;									/* Most recent network address of the printer */

		case NotConnected:
			key unsigned longint='nops';		/* Communications type identifier */
		};
};


// This resource controls the behavior of the standard buffering and IO
// within the Printing Manager.  If the specific driver does not include
// such a resource, the system defaults to 2 buffers of 1K each,
// and timeout values of 10 seconds each.  The specific driver can prevent
// the system from doing buffering or IO by specifying the correct
// values within this resource
type gxUniversalIOPrefsType
{
	longint standardIO = 0x00000000, customIO = 0x00000001;
	
	longint;		// number of buffers to allocate, 0 = none
	longint;		// size of each buffer
	longint;		// number of IO requests that can be pending at any one time
	longint;		// open/close timeout in ticks
	longint;		// read/write timeout in ticks
};


// A driver may supply 3 capture strings which are used to capture PAP devices.
//	 captureStringID				- string used for capture/uncapture (no length byte)
//	 uncapturedAppleTalkType	- AppleTalk type used for uncaptured devices (w/ length byte)
//	 capturedAppleTalkType		- AppleTalk type used for captured devices (w/ length byte)
// The default implementation performs string substitution on the capture string
// prior to sending it to the device, and the following strings are defined:
//  PRINTERNAME	- name of the printer 
//	 PRINTERTYPE	- type of the printer 
//	 NAMELEN	- name length byte
//	 TYPELEN - type length byte

type gxCaptureType {
		string;												/* String				*/
};



// RASTER RELATED RESOURCES

// This resource specifies the imaging preferences for raster drivers.
// Many common drivers can simply specify their imaging preferences via this resource.
#define gxNoColorPacking		0x0000
#define gxAlphaSpace			0x0080
#define gxWord5ColorPacking		0x0500
#define gxLong8ColorPacking		0x0800
#define gxLong10ColorPacking	0x0a00
#define gxAlphaFirstPacking		0x1000

#define gxNoSpace					0

#define gxRGBSpace				1
#define gxCMYKSpace				2
#define gxHSVSpace				3
#define gxHLSSpace				4

#define gxYXYSpace				5
#define gxXYZSpace				6
#define gxLUVSpace				7
#define gxLABSpace				8

#define gxYIQSpace				9
#define gxNTSCSpace				gxYIQSpace
#define gxPALSpace				gxYIQSpace

#define gxGraySpace				10
#define gxIndexedSpace			11

#define gxRGBASpace				gxRGBSpace + gxAlphaSpace
#define gxGrayASpace			gxGraySpace + gxAlphaSpace
#define gxRGB16Space  	 		gxWord5ColorPacking + gxRGBSpace
#define gxRGB32Space  			gxLong8ColorPacking + gxRGBSpace
#define gxARGB32Space 	 		gxLong8ColorPacking + gxAlphaFirstPacking + gxRGBASpace
#define gxCMYK32Space 	 		gxLong8ColorPacking + gxCMYKSpace
#define gxHSV32Space  	 		gxLong10ColorPacking + gxHSVSpace
#define gxHLS32Space  	 		gxLong10ColorPacking + gxHLSSpace
#define gxYXY32Space  	 		gxLong10ColorPacking + gxYXYSpace
#define gxXYZ32Space  	 		gxLong10ColorPacking + gxXYZSpace
#define gxLUV32Space  			gxLong10ColorPacking + gxLUVSpace
#define gxLAB32Space  			gxLong10ColorPacking + gxLABSpace
#define gxYIQ32Space  			gxLong10ColorPacking + gxYIQSpace
#define gxNTSC32Space    	 	gxYIQ32Space
#define gxPAL32Space  			gxYIQ32Space

type gxRasterPrefsType
{
	longint 	gxDefaultRaster = 0,								// default options
				gxDontResolveTransferModes   	= 0x01,				// 0=Resolve, 1=Don't Resolve
				gxRenderInReverse		      	= 0x02,				// traverse image in reverse order
				gxOnePlaneAtATime				= 0x04,				// render each plane separately
				gxSendAllBands					= 0x08;				// send even white bands

															// both of these are fixed point numbers
	longint;												// horizontal resolution to image at
	longint;												// vertical resolution to image at
	
	integer;												// min band size
	integer; 												// max band size
	
	longint;												// RAM percentage
	longint;												// RAM slop
	
	integer;												// depth of imaging, in pixels per plane
	integer = $$CountOf(PlaneArray);
	array PlaneArray 
		{
		// plane flags
		longint gxDefaultOffscreen = 0,
				gxDontSetHalftone = 1,
				gxDotTypeIsDitherLevel = 2;
					
		// HALFTONE STRUCTURE
		hex longint;									// fixed point angle
		hex longint;									// fixed point frequency
		
		longint gxRoundDot = 1, gxSpiralDot = 2, 	// type of dither
			gxSquareDot = 3, gxLineDot = 4, gxEllipticDot = 5, 
			gxTriangleDot = 6, gxDispersedDot = 7, gxCustomDot = 8;
		longint 											// tintType
			gxLuminanceTint = 1, gxAverageTint = 2, gxMixtureTint = 3, 
			gxComponent1Tint = 4, gxComponent2Tint = 5, gxComponent3Tint = 6, gxComponent4Tint = 7;
		
		longint;											// dot color
		longint gxNoProfile = 0;											
		hex integer;
		hex integer;
		hex integer;
		hex integer;
		
		longint;											// background color
		longint gxNoProfile = 0;											
		hex integer;
		hex integer;
		hex integer;
		hex integer;

		longint;											// tintSpace
		
		// OTHER PLANE FLAGS
		longint;											// plane colorSpace, can be gxNoSpace
		longint gxNoSet = 0;									// plane color set resource ID
		longint gxNoProfile = 0;								// plane color profile resource ID
		};
};

// The custom halftone resource allows the driver to specify a matrix to use
// for halftoning.
type gxCustomMatrixType
{
		hex longint;									// fixed point dpiX
		hex longint;									// fixed point dpiY
		longint;										// width
		longint;										// height
		longint;										// tile shift
		array samples
			{
			hex integer;
			};
};

// The raster packaging resource controls how your driver uses the default
// RasterDataIn message.  If you implement this message yourself, you should
// not have this resource.  If you use the default RasterDataIn message,
// you MUST have a resource of this type
#define gxSendAllColors		0x00000001
#define gxInterlaceColor	0x00000002
#define gxOverlayColor		0x00000004

type gxRasterPackType
{
	longint;			// buffer size for packaging (>= maximum head pass size)
	integer;			// iColorPasses :1 or 4 is typical
	integer;			// iHeadHeight  :Printhead height in pixels
	integer;			// iNumberPasses :number of head passes it takes to == iHeadHeight
	integer;			// iPassOffset : offset between passes, in pixels
	hex longint;	// flags
}; 


// This resource controls the remaining 2 raster packaging messages: RasterLineFeed,
// and RasterPackageBitmap.  If you allow the generic driver to implement these messages for
// you then you MUST have a resource of this type. 

type gxRasterPackOptionsType
{
	integer;		// start page wstring ID
	integer;		// form feed wstring ID
	
	// forward line feed
	integer;		// max value
	integer;		// numberType
	integer;		// minWidth
	char;			// pad char
	fill byte;
	pstring[31];	// prefix string		
	pstring[31];	// postfix string
	
	// reverse line feed
	integer;		// max value
	integer;		// numberType
	integer;		// minWidth
	char;			// pad char
	fill byte;
	pstring[31];	// prefix string
	pstring[31];	// postfix string
	
};


// For specifying a colorSet.

type gxColorSetResType {
	longint;							// colorSpace for the colorSet
	longint = $$CountOf(colorSet);
	array colorSet 						// members of the colorSet
		{
		hex integer;	
		hex integer;
		hex integer;
		hex integer;
		};
};



// POSTSCRIPT IMAGING RESOURCES

// resource for PostScript procedure set control resource

// these types are for the second integer in the array

#define donothing			0
#define dumpwidestring		1
#define dumpstringlist		2
#define converttohex		0x0100

type gxPostscriptProcSetControlType	{

		pstring;		 								// procset name
		align word;
		hex longint;								// procset version -- type( Fixed )
		integer;										// revision
		longint;										// vm usage
		
		integer = $$Countof(IDArray);				// Number of resources that make up the data set.

			wide array IDArray {
				
				integer;								// ID of the resource containing the data.
				integer;								// the flags are defined above

			};
	};


type gxPostscriptPrinterFontType {

	longint		ROMFont = 0;				// memory usage
	
	switch		{
		case	AdobeCharacterSet:			// a font with the adobe character set
			key hex longint = 0x00000000;
		
		case	AppleCharacterSet:
			key hex longint = 0x00010000;	// a font with some of the glyph in the apple std set
			glyphbits:
				longint		glyphcount;		// the max number of the glyph in the array
				hex string [ ( ( $$Long( glyphbits ) + 7 ) / 8 ) ];
				align long;
	
		case	EquivalentFont:				// a font with all equivalent glyphs on the mac
			key hex longint = 0x00020000;
	
		case	EncodedFont:				// a font that must be used as encoded
			key hex longint = 0x00030000;
				longint;					// platform
				longint;					// script
				longint;					// language
	};
};

// the following defines are used for the flags fields in the PostScriptPrefs data structure

#define gxNeedsHex					1
#define gxNeedsComments				2
#define gxBoundingBoxesOption		4
#define gxPortablePostScript		8
#define gxTextClipsToPath			16
#define gxFlattenClipPath			32
#define gxUsercharpath1				64
#define gxUseLevel2Color			128
#define gxNoEPSIllegalOperators		256
#define gxEPSTargetOption			gxNoEPSIllegalOperators + gxBoundingBoxesOption + gxNeedsComments

// the following define is for the fontType field in the PostScriptPrefs data structure
// it should parallel the enumeration for "streamType" inside the file "scaler types.h"

#define	truetypeStreamType		0x0001
#define	type1StreamType			0x0002
#define	type3StreamType			0x0004
#define	type42StreamType		0x0008
#define	type42GXStreamType		0x0010
#define	portableStreamType		0x0020
#define	flattenedStreamType		0x0040

type gxPostscriptPrefsType	{

		integer;			// language Level;
		longint;			// the color space for the device
		longint;			// render Options;

		longint;			// pathLimit;
		integer;			// gsaveLimit;
		integer;			// opStackLimit;
		longint;			// FontTypes;

		longint;			// printerVM;
};


// the following is the definition for the default scanning resource for postscript imaging system

#define StringScan	switch	{					\
			case SimpleScan:					\
				key integer = 0;				\
						wstring;				\
						align word;				\
			case UserNameScan:					\
				key integer = 1;				\
			case DocumentNameScan:				\
				key integer = 2;				\
			case PrinterNameScan:				\
				key integer = 3;				\
			case NilPtrScan:					\
				key integer = 4;				\
				integer	length;					\
		}
		
#define	OffsetScan	switch	{					\
			case SimpleOffset:					\
				key integer = 0;				\
			case SameAsPreviousOffset:			\
				key integer = 1;				\
			case ReturnedOffset:				\
				key integer = 2;				\
			case SimpleRepeat:					\
				key integer = 16;				\
			case SampleAsPreviousRepeat:		\
				key integer = 17;				\
			case ReturnedRepeat:				\
				key integer = 18;				\
		}
		
#define	ActionScan	switch	{					\
			case NoAction:						\
				key integer = 0;				\
			case SimpleAction:					\
				key integer = 1;				\
				integer	normal = 0,				\
						nonFatalError,			\
						fatalError;				\
				integer	alertID;				\
		}

type gxPostscriptScanningType		{

	longint ownerCount;
	
	array	{ 
				StringScan;
				StringScan;
				OffsetScan;
				ActionScan;
			};
};

// PAPER TYPE ('ptyp') DEFINITION AND CONSTANTS	

// Version of the 'ptyp' resource definition

#define		gxPaperTypeVersion	0x00010000	// Version 1.0


// Miscellaneous types used by the 'ptyp' definition

#define		fixed			hex longint
#define		gxRectangle		fixed; /* left */ fixed; /* top */ fixed; /* right */ fixed; /* bottom */


// 'ptyp' - definition of a paper type resource

type gxPaperTypeType {
	pstring;								// paper type name
	align word;
	gxRectangle;							// page rectangle
	gxRectangle;							// paper rectangle
	longint		unknownBase		=	0,		// base paper type from which this paper type is
				usLetterBase	=	1,		// derived.  This is not a complete set.
				usLegalBase		=	2,
				a4LetterBase	=	3,
				b5LetterBase	=	4,
				tabloidBase		=	5;
	literal longint;						// creator
	byte			pica	=	0,			// Unit of measure
					mm		=	1,
					inch	=	2;
	unsigned bitstring[2]	newStylePaperType		=	1,	// Flags
							oldStylePaperType		=	2,
							oldAndNewStylePaperType	=	3;
	unsigned bitstring[1]	= 0;					
	boolean		notDefaultPaperType		=	false,
				isDefaultPaperType		=	true;
	unsigned bitstring[20] = 0;						// Reserved flags
	
	longint = $$CountOf(ItemArray);					// embedded collection
	array ItemArray
		{
		longint;		//	tag;
		longint;		//	id;
			boolean		itemUnlocked			=	false,	// defined attributes bits...
						itemLocked				=	true;
			boolean		itemNonPersistent		=	false,
						itemPersistent			=	true;
			unsigned bitstring[14] = 0;						// reserved attributes bits...
			unsigned bitstring[16];				// user attributes bits...
		wstring;
		align word;
	};
};

// STATUS RELATED RESOURCES

type gxStatusType {
	longint;									// status Owner
	array statarray {
		INTEGER		nonFatalError = 1, 
					fatalError = 2, 
					printerReady = 3, 
					userAttention = 4, 
					userAlert = 5, 
					pageTransmission = 6, 
					openConnectionStatus = 7,
					informationalStatus = 8,
					spoolingPageStatus = 9,
					endStatus = 10,
					percentageStatus = 11;
					
		INTEGER;								// statusId;
		INTEGER;								// statusAlertId;
		pstring; 								// statusMessage;
		align word;
		};
	};
	

// DIALOG RELATED RESOURCES

#define		xdtlRadioButtons		0
#define		xdtlCheckBox			1
#define		xdtlEditTextInteger		2
#define		xdtlEditTextReal		3
#define		xdtlEditTextString		4
#define		xdtlPopUp				5


type gxPrintPanelType {
	pstring[31];			// the panel name
	integer Script;			// script id
	fill 	word;			// reserve a long word for future use of international
	fill 	word;			// reserve a long word for future use of international
	integer;				// the icon id
	integer;				// the ditl id
};

type gxExtendedDITLType {
	integer = $$CountOf(xdtlarray) -1;
	wide array xdtlarray {
		switch {
			case RadioButtons:
				key		integer = xdtlRadioButtons;
				literal	longint;		// 4 byte id for storage in job or format
						longint;		// numerical id for storage in job or format
						integer;		// offset in bytes into tag item
						integer = $$CountOf(RadioButtonsArray) - 1;
						wide array RadioButtonsArray
						{
							byte;		// array of corresponding items
						};
			case CheckBox:
				key		integer = xdtlCheckBox;
				literal	longint;		// 4 byte id for storage in job or format
						longint;		// numerical id for storage in job or format
						integer;		// offset in bytes into tag item
						byte;			// corresponding ditl item
						fill byte;
									
			case EditTextInteger:
				key		integer = xdtlEditTextInteger;
				literal	longint;			// 4 byte id for storage in job or format
							longint;		// numerical id for storage in job or format
							integer;		// offset in bytes into tag item
							byte;			// corresponding ditl item
							byte;			// 0 = dont select, 1 = select
							pstring[15];	// low bound - nil means 'I don't care'
							pstring[15];	// high bound - nil means 'I don't care'

			case EditTextReal:
				key		integer = xdtlEditTextReal;
				literal	longint;			// 4 byte id for storage in job or format
							longint;		// numerical id for storage in job or format
							integer;		// offset in bytes into tag item
							byte;			// corresponding ditl item
							byte;			// 0 = dont select, 1 = select
							pstring[15];	// low bound - nil means 'I don't care'
							pstring[15];	// high bound - nil means 'I don't care'

			case EditTextString:
				key		integer = xdtlEditTextString;
				literal	longint;		// 4 byte id for storage in job or format
						longint;		// numerical id for storage in job or format
						integer;		// offset in bytes into tag item
						byte;			// corresponding ditl item
						byte;			// 0 = dont select, 1 = select

			case PopUp:
				key		integer = xdtlPopUp;
				literal	longint;		// 4 byte id for storage in job or format
						longint;		// numerical id for storage in job or format
						integer;		// offset in bytes into tag item
						byte;			// corresponding ditl item 
						fill byte;
			};
			align word;
		};
	};
	
// Printing ALERT RELATED RESOURCES 'plrt'

type gxPrintingAlertType {
	integer		printingAlert = 1, printingStatus = 2;											// printing alert version
	integer 	noIcon = -1, stopIcon = 0, noteIcon = 1, cautionIcon = 2;						// icon id
	integer 	defaultSystemSize = 0;															// text size
	byte		noDefaultTitle = 0, defaultAction = 1, defaultTitle2 = 2, defaultTitle3 = 3;	// default button
	byte		noCancelTitle = 0, cancelAction = 1, cancelTitle2 = 2, cancelTitle3 = 3;		// cancel button
	wstring;																					// text string
	pstring;																					// action button label
	pstring;																					// button label 2
	pstring;																					// button label 3
	pstring;																					// font name
	pstring		AlertTitle = "Alert";															// alert title
	};


// DESKTOP CONFIGURATION FILE RELATED RESOURCES

// driver resource to specify the tray name

type gxTrayNameDataType {					// tray name data type ('tryn')
	pstring[31];
};


// driver resource to specify the tray count

type gxTrayCountDataType {
	longint;							// count of trays
};


// Desktop printer resource to specify manual feed alert preferences. ('mfpr')

#define gxShowAlerts			0x00000001	// Enable manual feed alerts (default).
#define gxAlertOnPaperChange	0x00000002	// …but only if the papertype changes.

type gxManualFeedAlertPrefsType {
	unsigned bitstring[16];	// flags -- for driver's private use.
	unsigned bitstring[16];	// flags -- predefined. gxShowAlerts, gxShowAlerts +gxAlertOnPaperChange, or 0.
};


// Desktop printer resource to specify whether or not this desktop printer has trays. ('outp')

#define gxCanConfigureTrays		0x00000001	// Can configure trays for this printer.

type gxDriverOutputType {
	longint;				// flags -- for driver's private use.
	longint;				// flags -- predefined. Currently, gxCanConfigureTrays or 0.
};



type gxDITLControlType{
	integer;								/*  DTILsize Maximum item count for DITL */
	
	integer = $$CountOf(dctlarray) - 1;		/* Array size */
	wide array dctlarray {
		switch {

		case Button:
			key integer 	= 1;
				integer;					/* Item ID that this is the button of */
				integer							/* Button kind */
					cancel	= 0;	
		case Cluster:
			key integer 	= 2;
			integer							/* What kind of cluster is this? */
				feed		= 0,
				quality		= 1,
				coverPage	= 2,
				firstPage	= 3,
				restPage	= 4,
				headMotion	= 5,
				createFile	= 6,
				user0		= 7,
				user1		= 8,
				user2		= 9;
				
			integer = $$CountOf(ClusterArray) - 1;
				wide array ClusterArray
					{
					integer;			/* The item ID this corresponds to */
					};

		case Copies:
			key integer = 3;
				integer;				/* ID of the item */
				
		case DialogBtn:
			key integer = 4;
				integer;				/* Item ID of the cascade button */
				integer;				/* ID of the dialog */
				integer;				/* ID of the dctl for the dialog */

		case Frill:
			key integer = 5;		
				integer;				/* Item ID of this frill */
				integer						/* What kind of frill might this be? */
					line 		= 0,
					version		= 1,
					default		= 2,
					printerName	= 3,
					grayBoxLine = 4;

		case Moof:
			key integer = 6;
				integer;				/* ID of the Moof∞™ */
				
		case OKButton:
			key integer = 7;
				integer;				/* Item ID of the OK button */
				integer;				/* ID of the "Print" string */
				integer;				/* ID of the "Save" string */

		case Orientation:
			key integer = 8;	
				integer;			/* ID of portrait orientation */
				integer;		/* ID of the landscape orientation */
				integer;		/* ID of flipped portrait */
				integer;		/* ID of the flipped landscape */

		case PageRange:
			key integer = 9;
				integer;				/* ID of the "all" button */
				integer;			/* ID of the range button */
				integer;				/* ID of the from edit text */
				integer;				/* ID of the to edit text */
				
		case PaperSizes:
			key integer = 10;
			integer;		/* Item of the popup */
			integer;			/* Item of the popup radio button */
			fill long;
			fill word;
						
			integer = $$CountOf(ClusterArray) - 1;
				wide array ClusterArray
					{
					integer;			/* The item ID this corresponds to */
					};
					
		case Scale:
			key integer = 11;
					integer;			/* Item ID of the edit text */
					integer;			/* Item ID of the arrow useritem */
					integer;			/* resource ID for the 'stab' resource */
		case Toggle:
			key integer = 12;
			integer;					/* Item ID that this coresponds to */
			integer						/* Value to OR into flags to set it */
				bPreciseBitmap 		= $0001,
				bBiggerPages		= $0002,
				bGraphicSmoothing	= $0004,
				bTextSmoothing		= $0008,
				bFontSubstitution	= $0010,
				bInvert				= $0020,
				bFlipHoriz			= $0040,
				bFlipVert			= $0080,
				bColorMode			= $0100,
				bBidirectional		= $0200,
				bUser0				= $0400,
				bUser1				= $0800,
				bUser2				= $1000,
				bReserved0			= $2000,
				bReserved1			= $4000,
				bReserved2			= $8000;
		
		case PopUp:
			key integer = 13;
			integer							/* What kind of PopUp is this? */
				N_Up		= -1,
				feed		= 0,
				quality		= 1,
				coverPage	= 2,
				firstPage	= 3,
				restPage	= 4,
				headMotion	= 5,
				createFile	= 6,
				user0		= 7,
				user1		= 8,
				user2		= 9;
			integer;						/* id of control */			
		};
	align word;								/* Each item is word aligned */
	};
};


type gxScaleTableType {					/* definition for values in reduction table -	*/
								/*  NOTE - VALUES EXPECTED IN ASCENDING ORDER  	*/
	integer = $$Countof(valarray);
	array valarray {
		integer;
		};
	};

#endif

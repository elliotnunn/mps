/*
 	File:		CMICCProfile.h
 
 	Contains:	Definitions for ColorSync 2.0 profile
 
 	Version:	Technology:	ColorSync 2.0
 				Package:	Universal Interfaces 2.1 in “MPW Latest” on ETO #18
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __CMICCPROFILE__
#define __CMICCPROFILE__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

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
	cmCS2ProfileVersion			= 0x02000000
};

/* Current Major version number */
enum {
	cmCurrentProfileMajorVersion = 0x02000000
};

/* magic cookie number for anonymous file ID */
enum {
	cmMagicNumber				= 'acsp'
};

/* ColorSync profile version 1.0 */
enum {
	cmCS1ProfileVersion			= 0x00000100
};

/************************************************************************/
/*************** ColorSync 2.0 profile specification ********************/
/************************************************************************/
/* profile flags element values */
enum {
	cmEmbeddedProfile			= 0,							/* 0 is not embedded profile, 1 is embedded profile */
	cmEmbeddedUse				= 1								/* 0 is to use anywhere, 1 is to use as embedded profile only */
};

/* data type element values */
enum {
	cmAsciiData					= 0,
	cmBinaryData				= 1
};

/* rendering intent element values  */
enum {
	cmPerceptual				= 0,							/* Photographic images */
	cmRelativeColorimetric		= 1,							/* Logo Colors */
	cmSaturation				= 2,							/* Business graphics */
	cmAbsoluteColorimetric		= 3								/* Logo Colors */
};

/* speed and quality flag options */
enum {
	cmNormalMode				= 0,							/* it uses the least significent two bits in the high word of flag */
	cmDraftMode					= 1,							/* it should be evaulated like this: right shift 16 bits first, mask off the */
	cmBestMode					= 2								/* high 14 bits, and then compare with the enum to determine the option value */
};

/* device/media attributes element values  */
enum {
	cmReflective				= 0,							/* 0 is reflective media, 1 is transparency media */
	cmGlossy					= 1								/* 0 is glossy, 1 is matte */
};

/* screen encodings  */
enum {
	cmPrtrDefaultScreens		= 0,							/* Use printer default screens.  0 is false, 1 is ture */
	cmLinesPer					= 1								/* 0 is LinesPerCm, 1 is LinesPerInch */
};

/* 2.0 tag type information */
enum {
	cmNumHeaderElements			= 10
};

/* public tags */
enum {
	cmAToB0Tag					= 'A2B0',
	cmAToB1Tag					= 'A2B1',
	cmAToB2Tag					= 'A2B2',
	cmBlueColorantTag			= 'bXYZ',
	cmBlueTRCTag				= 'bTRC',
	cmBToA0Tag					= 'B2A0',
	cmBToA1Tag					= 'B2A1',
	cmBToA2Tag					= 'B2A2',
	cmCalibrationDateTimeTag	= 'calt',
	cmCharTargetTag				= 'targ',
	cmCopyrightTag				= 'cprt',
	cmDeviceMfgDescTag			= 'dmnd',
	cmDeviceModelDescTag		= 'dmdd',
	cmGamutTag					= 'gamt',
	cmGrayTRCTag				= 'kTRC',
	cmGreenColorantTag			= 'gXYZ',
	cmGreenTRCTag				= 'gTRC',
	cmLuminanceTag				= 'lumi',
	cmMeasurementTag			= 'meas',
	cmMediaBlackPointTag		= 'bkpt',
	cmMediaWhitePointTag		= 'wtpt',
	cmNamedColorTag				= 'ncol',
	cmPreview0Tag				= 'pre0',
	cmPreview1Tag				= 'pre1',
	cmPreview2Tag				= 'pre2',
	cmProfileDescriptionTag		= 'desc',
	cmProfileSequenceDescTag	= 'pseq',
	cmPS2CRD0Tag				= 'psd0',
	cmPS2CRD1Tag				= 'psd1',
	cmPS2CRD2Tag				= 'psd2',
	cmPS2CRD3Tag				= 'psd3',
	cmPS2CSATag					= 'ps2s',
	cmPS2RenderingIntentTag		= 'ps2i',
	cmRedColorantTag			= 'rXYZ',
	cmRedTRCTag					= 'rTRC',
	cmScreeningDescTag			= 'scrd',
	cmScreeningTag				= 'scrn',
	cmTechnologyTag				= 'tech',
	cmUcrBgTag					= 'bfd ',
	cmViewingConditionsDescTag	= 'vued',
	cmViewingConditionsTag		= 'view'
};

/* custom tags */
enum {
	cmPS2CRDVMSizeTag			= 'psvm'
};

/* technology tag descriptions */
enum {
	cmTechnologyFilmScanner		= 'fscn',
	cmTechnologyReflectiveScanner = 'rscn',
	cmTechnologyInkJetPrinter	= 'ijet',
	cmTechnologyThermalWaxPrinter = 'twax',
	cmTechnologyElectrophotographicPrinter = 'epho',
	cmTechnologyElectrostaticPrinter = 'esta',
	cmTechnologyDyeSublimationPrinter = 'dsub',
	cmTechnologyPhotographicPaperPrinter = 'rpho',
	cmTechnologyFilmWriter		= 'fprn',
	cmTechnologyVideoMonitor	= 'vidm',
	cmTechnologyVideoCamera		= 'vidc',
	cmTechnologyProjectionTelevision = 'pjtv',
	cmTechnologyCRTDisplay		= 'CRT ',
	cmTechnologyPMDisplay		= 'PMD ',
	cmTechnologyAMDisplay		= 'AMD ',
	cmTechnologyPhotoCD			= 'KPCD',
	cmTechnologyPhotoImageSetter = 'imgs',
	cmTechnologyGravure			= 'grav',
	cmTechnologyOffsetLithography = 'offs',
	cmTechnologySilkscreen		= 'silk',
	cmTechnologyFlexography		= 'flex'
};

/* type signatures */
enum {
	cmSigCurveType				= 'curv',
	cmSigDataType				= 'data',
	cmSigDateTimeType			= 'dtim',
	cmSigLut16Type				= 'mft2',
	cmSigLut8Type				= 'mft1',
	cmSigMeasurementType		= 'meas',
	cmSigNamedColorType			= 'ncol',
	cmSigProfileDescriptionType	= 'desc',
	cmSigScreeningType			= 'scrn',
	cmSigS15Fixed16Type			= 'sf32',
	cmSigSignatureType			= 'sig ',
	cmSigTextType				= 'text',
	cmSigU16Fixed16Type			= 'uf32',
	cmSigU1Fixed15Type			= 'uf16',
	cmSigUInt32Type				= 'ui32',
	cmSigUInt64Type				= 'ui64',
	cmSigUInt8Type				= 'ui08',
	cmSigViewingConditionsType	= 'view',
	cmSigXYZType				= 'XYZ '
};

/* Measurement type encodings */
/* Measurement Flare */
enum {
	cmFlare0					= 0x00000000,
	cmFlare100					= 0x00000001
};

/* Measurement Geometry	*/
enum {
	cmGeometryUnknown			= 0x00000000,
	cmGeometry045or450			= 0x00000001,
	cmGeometry0dord0			= 0x00000002
};

/* Standard Observer	*/
enum {
	cmStdobsUnknown				= 0x00000000,
	cmStdobs1931TwoDegrees		= 0x00000001,
	cmStdobs1964TenDegrees		= 0x00000002
};

/* Standard Illuminant */
enum {
	cmIlluminantUnknown			= 0x00000000,
	cmIlluminantD50				= 0x00000001,
	cmIlluminantD65				= 0x00000002,
	cmIlluminantD93				= 0x00000003,
	cmIlluminantF2				= 0x00000004,
	cmIlluminantD55				= 0x00000005,
	cmIlluminantA				= 0x00000006,
	cmIlluminantEquiPower		= 0x00000007,
	cmIlluminantF8				= 0x00000008
};

/* Spot Function Value */
enum {
	cmSpotFunctionUnknown		= 0,
	cmSpotFunctionDefault		= 1,
	cmSpotFunctionRound			= 2,
	cmSpotFunctionDiamond		= 3,
	cmSpotFunctionEllipse		= 4,
	cmSpotFunctionLine			= 5,
	cmSpotFunctionSquare		= 6,
	cmSpotFunctionCross			= 7
};

/* Color Space Signatures */
enum {
	cmXYZData					= 'XYZ ',
	cmLabData					= 'Lab ',
	cmLuvData					= 'Luv ',
	cmYxyData					= 'Yxy ',
	cmRGBData					= 'RGB ',
	cmGrayData					= 'GRAY',
	cmHSVData					= 'HSV ',
	cmHLSData					= 'HLS ',
	cmCMYKData					= 'CMYK',
	cmCMYData					= 'CMY ',
	cmMCH5Data					= 'MCH5',
	cmMCH6Data					= 'MCH6',
	cmMCH7Data					= 'MCH7',
	cmMCH8Data					= 'MCH8'
};

/* profileClass enumerations */
enum {
	cmInputClass				= 'scnr',
	cmDisplayClass				= 'mntr',
	cmOutputClass				= 'prtr',
	cmLinkClass					= 'link',
	cmAbstractClass				= 'abst',
	cmColorSpaceClass			= 'spac'
};

/* platform enumerations */
enum {
	cmMacintosh					= 'APPL',
	cmMicrosoft					= 'MSFT',
	cmSolaris					= 'SUNW',
	cmSiliconGraphics			= 'SGI ',
	cmTaligent					= 'TGNT'
};

/* ColorSync 1.0 elements */
enum {
	cmCS1ChromTag				= 'chrm',
	cmCS1TRCTag					= 'trc ',
	cmCS1NameTag				= 'name',
	cmCS1CustTag				= 'cust'
};

/* General element data types */
struct CMDateTime {
	unsigned short					year;
	unsigned short					month;
	unsigned short					dayOfTheMonth;
	unsigned short					hours;
	unsigned short					minutes;
	unsigned short					seconds;
};
typedef struct CMDateTime CMDateTime;

struct CMFixedXYZColor {
	Fixed							X;
	Fixed							Y;
	Fixed							Z;
};
typedef struct CMFixedXYZColor CMFixedXYZColor;

typedef unsigned short CMXYZComponent;

struct CMXYZColor {
	CMXYZComponent					X;
	CMXYZComponent					Y;
	CMXYZComponent					Z;
};
typedef struct CMXYZColor CMXYZColor;

struct CM2Header {
	unsigned long					size;						/* This is the total size of the Profile */
	OSType							CMMType;					/* CMM signature,  Registered with CS2 consortium  */
	unsigned long					profileVersion;				/* Version of CMProfile format */
	OSType							profileClass;				/* input, display, output, devicelink, abstract, or color conversion profile type */
	OSType							dataColorSpace;				/* color space of data */
	OSType							profileConnectionSpace;		/* profile connection color space */
	CMDateTime						dateTime;					/* date and time of profile creation */
	OSType							CS2profileSignature;		/* 'acsp' constant ColorSync 2.0 file ID */
	OSType							platform;					/* primary profile platform, Registered with CS2 consortium */
	unsigned long					flags;						/* profile flags */
	OSType							deviceManufacturer;			/* Registered with CS2 consortium */
	unsigned long					deviceModel;				/* Registered with CS2 consortium */
	unsigned long					deviceAttributes[2];		/* Attributes like paper type */
	unsigned long					renderingIntent;			/* preferred rendering intent of tagged object */
	CMFixedXYZColor					white;						/* profile illuminant */
	char							reserved[48];				/* reserved for future use */
};
typedef struct CM2Header CM2Header;

struct CMTagRecord {
	OSType							tag;						/* Registered with CS2 consortium */
	unsigned long					elementOffset;				/* Relative to start of CMProfile */
	unsigned long					elementSize;
};
typedef struct CMTagRecord CMTagRecord;

struct CMTagElemTable {
	unsigned long					count;
	CMTagRecord						tagList[1];					/* Variable size */
};
typedef struct CMTagElemTable CMTagElemTable;

/* External 0x02002001 CMProfile */
struct CM2Profile {
	CM2Header						header;
	CMTagElemTable					tagTable;
	char							elemData[1];				/* Tagged element storage. Variable size */
};
typedef struct CM2Profile CM2Profile, **CM2ProfileHandle;

/* Tag Type Definitions */
struct CMCurveType {
	OSType							typeDescriptor;				/* 'curv' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned long					countValue;					/* number of entries in table that follows */
	unsigned short					data[1];					/* Tagged element storage. Variable size */
};
typedef struct CMCurveType CMCurveType;

struct CMDataType {
	OSType							typeDescriptor;				/* 'data' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned long					dataFlag;					/* 0 = ASCII, 1 = binary */
	char							data[1];					/* Tagged element storage. Variable size */
};
typedef struct CMDataType CMDataType;

struct CMDateTimeType {
	OSType							typeDescriptor;				/* 'dtim' */
	unsigned long					reserved;
	CMDateTime						dateTime;
};
typedef struct CMDateTimeType CMDateTimeType;

struct CMLut16Type {
	OSType							typeDescriptor;				/* 'mft2' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned char					inputChannels;				/* Number of input channels */
	unsigned char					outputChannels;				/* Number of output channels */
	unsigned char					gridPoints;					/* Number of clutTable grid points */
	unsigned char					reserved2;					/* fill with 0x00 */
	Fixed							matrix[3][3];				/* */
	unsigned short					inputTableEntries;			/* */
	unsigned short					outputTableEntries;			/* */
	unsigned short					inputTable[1];				/* Variable size */
	unsigned short					CLUT[1];					/* Variable size */
	unsigned short					outputTable[1];				/* Variable size */
};
typedef struct CMLut16Type CMLut16Type;

struct CMLut8Type {
	OSType							typeDescriptor;				/* 'mft1' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned char					inputChannels;				/* */
	unsigned char					outputChannels;				/* */
	unsigned char					gridPoints;					/* */
	unsigned char					reserved2;					/* fill with 0x00 */
	Fixed							matrix[3][3];				/* */
	unsigned char					inputTable[256];			/* fixed size of 256 */
	unsigned char					CLUT[1];					/* Variable size */
	unsigned char					outputTable[256];			/* fixed size of 256 */
};
typedef struct CMLut8Type CMLut8Type;

struct CMMeasurementType {
	OSType							typeDescriptor;				/* 'meas' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned long					standardObserver;			/* 0 : unknown, 1 : CIE 1931, 2 : CIE 1964 */
	CMFixedXYZColor					backingXYZ;					/* absolute XYZ values of backing */
	unsigned long					geometry;					/* 0 : unknown, 1 : 0/45 or 45/0, 2 :0/d or d/0 */
	unsigned long					flare;						/* 0 : 0%, 1 : 100% flare */
	unsigned long					illuminant;					/* standard illuminant */
};
typedef struct CMMeasurementType CMMeasurementType;

struct CMNamedColorType {
	OSType							typeDescriptor;				/* 'ncol' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned long					vendorFlag;					/* */
	unsigned long					count;						/* count of named colors in array that follows */
	unsigned char					prefixName[1];				/* Variable size, max = 32, to access fields after this one, have to count bytes */
	unsigned char					suffixName[1];				/* Variable size, max = 32 */
	struct {
		unsigned char					rootName[1];			/* Variable size, max = 32 */
		unsigned char					colorCoords[1];			/* Variable size  */
	}								colorName[1];				/* Variable size  */
};
typedef struct CMNamedColorType CMNamedColorType;

struct CMTextDescriptionType {
	OSType							typeDescriptor;				/* 'desc' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned long					ASCIICount;					/* the count of "bytes" */
	unsigned char					ASCIIName[2];				/* Variable size, to access fields after this one, have to count bytes */
	unsigned long					UniCodeCode;
	unsigned long					UniCodeCount;				/* the count of characters, each character has two bytes */
	unsigned char					UniCodeName[2];				/* Variable size */
	short							ScriptCodeCode;
	unsigned char					ScriptCodeCount;			/* the count of "bytes" */
	unsigned char					ScriptCodeName[2];			/* Variable size */
};
typedef struct CMTextDescriptionType CMTextDescriptionType;

struct CMTextType {
	OSType							typeDescriptor;				/* 'text' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned char					text[1];					/* count of text is obtained from tag size element */
};
typedef struct CMTextType CMTextType;

struct CMScreeningType {
	OSType							typeDescriptor;				/* 'scrn' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned long					screeningFlag;				/* bit 0 : use printer default screens, bit 1 : inch/cm */
	unsigned long					channelCount;
	struct {
		Fixed							frequency;
		Fixed							angle;
		unsigned long					sportFunction;
	}								channelScreening[1];		/* Variable size */
};
typedef struct CMScreeningType CMScreeningType;

struct CMSignatureType {
	OSType							typeDescriptor;				/* 'sig ' */
	unsigned long					reserved;					/* fill with 0x00 */
	OSType							signature;
};
typedef struct CMSignatureType CMSignatureType;

struct CMS15Fixed16ArrayType {
	OSType							typeDescriptor;				/* 'sf32' */
	unsigned long					reserved;					/* fill with 0x00 */
	Fixed							value[1];					/* Variable size */
};
typedef struct CMS15Fixed16ArrayType CMS15Fixed16ArrayType;

struct CMU16Fixed16ArrayType {
	OSType							typeDescriptor;				/* 'uf32' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned long					value[1];					/* Variable size */
};
typedef struct CMU16Fixed16ArrayType CMU16Fixed16ArrayType;

struct CMUInt16ArrayType {
	OSType							typeDescriptor;				/* 'ui16' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned short					value[1];					/* Variable size */
};
typedef struct CMUInt16ArrayType CMUInt16ArrayType;

struct CMUInt32ArrayType {
	OSType							typeDescriptor;				/* 'ui32' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned long					value[1];					/* Variable size */
};
typedef struct CMUInt32ArrayType CMUInt32ArrayType;

struct CMUInt64ArrayType {
	OSType							typeDescriptor;				/* 'ui64' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned long					value[1];					/* Variable size (x2) */
};
typedef struct CMUInt64ArrayType CMUInt64ArrayType;

struct CMUInt8ArrayType {
	OSType							typeDescriptor;				/* 'ui08' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned char					value[1];					/* Variable size */
};
typedef struct CMUInt8ArrayType CMUInt8ArrayType;

struct CMViewingConditionsType {
	OSType							typeDescriptor;				/* 'view' */
	unsigned long					reserved;					/* fill with 0x00 */
	CMFixedXYZColor					illuminant;					/* absolute XYZs of illuminant  in cd/m^2 */
	CMFixedXYZColor					surround;					/* absolute XYZs of surround in cd/m^2 */
	unsigned long					stdIlluminant;				/* see definitions of std illuminants */
};
typedef struct CMViewingConditionsType CMViewingConditionsType;

struct CMXYZType {
	OSType							typeDescriptor;				/* 'XYZ ' */
	unsigned long					reserved;					/* fill with 0x00 */
	CMFixedXYZColor					XYZ[1];						/* variable size XYZ tristimulus values */
};
typedef struct CMXYZType CMXYZType;

/* Profile sequence description type */
struct CMProfileSequenceDescType {
	OSType							typeDescriptor;				/* 'pseq ' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned long					count;						/* Number of descriptions
														 * variable size fields to follow, to access them, must count bytes */
	struct {
		OSType							deviceMfg;				/* Device Manufacturer */
		OSType							deviceModel;			/* Decvice Model */
		unsigned long					attributes[2];			/* Device attributes */
		OSType							technology;				/* Technology signature */
		unsigned long					mfgDescASCIICount;		/* the count of "bytes" */
		unsigned char					mfgDescASCIIName[2];	/* Variable size */
		unsigned long					mfgDescUniCodeCode;
		unsigned long					mfgDescUniCodeCount;	/* the count of characters, each character has two bytes */
		unsigned char					mfgDescUniCodeName[2];	/* Variable size */
		unsigned long					mfgDescScriptCodeCode;
		unsigned long					mfgDescScriptCodeCount;	/* the count of "bytes" */
		unsigned char					mfgDescScriptCodeName[2]; /* Variable size */
		unsigned long					modelDescASCIICount;	/* the count of "bytes" */
		unsigned char					modelDescASCIIName[2];	/* Variable size */
		unsigned long					modelDescUniCodeCode;
		unsigned long					modelDescUniCodeCount;	/* the count of characters, each character has two bytes */
		unsigned char					modelDescUniCodeName[2]; /* Variable size */
		short							modelDescScriptCodeCode;
		unsigned char					modelDescScriptCodeCount; /* the count of "bytes" */
		unsigned char					modelDescScriptCodeName[2]; /* Variable size */
	}								profileDescription[1];
};
typedef struct CMProfileSequenceDescType CMProfileSequenceDescType;

/* Under color removal, black generation type */
struct CMUcrBgType {
	OSType							typeDescriptor;				/* 'bfd  ' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned long					ucrCount;					/* Number of UCR entries */
	unsigned short					ucrValues[1];				/* variable size */
	unsigned long					bgCount;					/* Number of BG entries */
	unsigned short					bgValues[1];				/* variable size */
	unsigned char					ucrbgASCII[1];				/* null terminated ASCII string */
};
typedef struct CMUcrBgType CMUcrBgType;

struct CMIntentCRDVMSize {
	long							renderingIntent;			/* rendering intent */
	unsigned long					VMSize;						/* VM size taken up by the CRD */
};
typedef struct CMIntentCRDVMSize CMIntentCRDVMSize;

struct CMPS2CRDVMSizeType {
	OSType							typeDescriptor;				/* 'psvm' */
	unsigned long					reserved;					/* fill with 0x00 */
	unsigned long					count;						/* number of intent entries */
	CMIntentCRDVMSize				intentCRD[1];				/* variable size */
};
typedef struct CMPS2CRDVMSizeType CMPS2CRDVMSizeType;

/************************************************************************/
/*************** ColorSync 1.0 profile specification ********************/
/************************************************************************/

enum {
	cmGrayResponse				= 0,
	cmRedResponse,
	cmGreenResponse,
	cmBlueResponse,
	cmCyanResponse,
	cmMagentaResponse,
	cmYellowResponse,
	cmUcrResponse,
	cmBgResponse,
	cmOnePlusLastResponse
};

/* Device types */
enum {
	cmMonitorDevice				= 'mntr',
	cmScannerDevice				= 'scnr',
	cmPrinterDevice				= 'prtr'
};

struct CMIString {
	ScriptCode						theScript;
	Str63							theString;
};
typedef struct CMIString CMIString;

/* Profile options */

enum {
	cmPerceptualMatch			= 0x0000,						/* Default. For photographic images */
	cmColorimetricMatch			= 0x0001,						/* Exact matching when possible */
	cmSaturationMatch			= 0x0002						/* For solid colors */
};

/* Profile flags */
enum {
	cmNativeMatchingPreferred	= 0x00000001,					/* Default to native not preferred */
	cmTurnOffCache				= 0x00000002					/* Default to turn on CMM cache */
};

typedef long CMMatchOption;

typedef long CMMatchFlag;

struct CMHeader {
	unsigned long					size;
	OSType							CMMType;
	unsigned long					applProfileVersion;
	OSType							dataType;
	OSType							deviceType;
	OSType							deviceManufacturer;
	unsigned long					deviceModel;
	unsigned long					deviceAttributes[2];
	unsigned long					profileNameOffset;
	unsigned long					customDataOffset;
	CMMatchFlag						flags;
	CMMatchOption					options;
	CMXYZColor						white;
	CMXYZColor						black;
};
typedef struct CMHeader CMHeader;

struct CMProfileChromaticities {
	CMXYZColor						red;
	CMXYZColor						green;
	CMXYZColor						blue;
	CMXYZColor						cyan;
	CMXYZColor						magenta;
	CMXYZColor						yellow;
};
typedef struct CMProfileChromaticities CMProfileChromaticities;

struct CMProfileResponse {
	unsigned short					counts[cmOnePlusLastResponse];
	unsigned short					data[1];					/* Variable size */
};
typedef struct CMProfileResponse CMProfileResponse;

struct CMProfile {
	CMHeader						header;
	CMProfileChromaticities			profile;
	CMProfileResponse				response;
	CMIString						profileName;
	char							customData[1];				/* Variable size */
};
typedef struct CMProfile CMProfile, **CMProfileHandle;

#if OLDROUTINENAMES 

enum {
	kCMApplProfileVersion		= cmCS1ProfileVersion
};

enum {
	grayResponse				= cmGrayResponse,
	redResponse					= cmRedResponse,
	greenResponse				= cmGreenResponse,
	blueResponse				= cmBlueResponse,
	cyanResponse				= cmCyanResponse,
	magentaResponse				= cmMagentaResponse,
	yellowResponse				= cmYellowResponse,
	ucrResponse					= cmUcrResponse,
	bgResponse					= cmBgResponse,
	onePlusLastResponse			= cmOnePlusLastResponse
};

enum {
	rgbData						= cmRGBData,
	cmykData					= cmCMYKData,
	grayData					= cmGrayData,
	xyzData						= cmXYZData
};

enum {
	XYZData						= cmXYZData
};

enum {
	monitorDevice				= cmMonitorDevice,
	scannerDevice				= cmScannerDevice,
	printerDevice				= cmPrinterDevice
};

enum {
	CMNativeMatchingPreferred	= cmNativeMatchingPreferred,	/* Default to native not preferred */
	CMTurnOffCache				= cmTurnOffCache				/* Default to turn on CMM cache */
};

enum {
	CMPerceptualMatch			= cmPerceptualMatch,			/* Default. For photographic images */
	CMColorimetricMatch			= cmColorimetricMatch,			/* Exact matching when possible */
	CMSaturationMatch			= cmSaturationMatch				/* For solid colors */
};

typedef unsigned short XYZComponent;

typedef struct CMXYZColor XYZColor;

typedef unsigned short CMResponseData;

typedef struct CMIString IString;

typedef long CMResponseColor;

typedef CMResponseColor responseColor;

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

#endif /* __CMICCPROFILE__ */

/*
 	File:		CMApplication.h
 
 	Contains:	Color Matching Interfaces
 
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

#ifndef __CMAPPLICATION__
#define __CMAPPLICATION__


#ifndef __TYPES__
#include <Types.h>
#endif
/*	#include <ConditionalMacros.h>								*/

#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
/*	#include <MixedMode.h>										*/
/*	#include <QuickdrawText.h>									*/

#ifndef __FILES__
#include <Files.h>
#endif
/*	#include <OSUtils.h>										*/
/*		#include <Memory.h>										*/
/*	#include <Finder.h>											*/

#ifndef __PRINTING__
#include <Printing.h>
#endif
/*	#include <Errors.h>											*/
/*	#include <Dialogs.h>										*/
/*		#include <Menus.h>										*/
/*		#include <Controls.h>									*/
/*		#include <Windows.h>									*/
/*			#include <Events.h>									*/
/*		#include <TextEdit.h>									*/

#ifndef __CMICCPROFILE__
#include <CMICCProfile.h>
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
	gestaltColorSync20			= 0x0200
};

enum {
	kDefaultCMMSignature		= 'appl'
};

/* Macintosh 68K trap word */
enum {
	cmTrap						= 0xABEE
};

/* PicComment IDs */
enum {
	cmBeginProfile				= 220,
	cmEndProfile				= 221,
	cmEnableMatching			= 222,
	cmDisableMatching			= 223,
	cmComment					= 224
};

/* PicComment selectors for cmComment */
enum {
	cmBeginProfileSel			= 0,
	cmContinueProfileSel		= 1,
	cmEndProfileSel				= 2
};

/* Defines for version 1.0 CMProfileSearchRecord.fieldMask */
enum {
	cmMatchCMMType				= 0x00000001,
	cmMatchApplProfileVersion	= 0x00000002,
	cmMatchDataType				= 0x00000004,
	cmMatchDeviceType			= 0x00000008,
	cmMatchDeviceManufacturer	= 0x00000010,
	cmMatchDeviceModel			= 0x00000020,
	cmMatchDeviceAttributes		= 0x00000040,
	cmMatchFlags				= 0x00000080,
	cmMatchOptions				= 0x00000100,
	cmMatchWhite				= 0x00000200,
	cmMatchBlack				= 0x00000400
};

/* Defines for version 2.0 CMSearchRecord.searchMask */
enum {
	cmMatchAnyProfile			= 0x00000000,
	cmMatchProfileCMMType		= 0x00000001,
	cmMatchProfileClass			= 0x00000002,
	cmMatchDataColorSpace		= 0x00000004,
	cmMatchProfileConnectionSpace = 0x00000008,
	cmMatchManufacturer			= 0x00000010,
	cmMatchModel				= 0x00000020,
	cmMatchAttributes			= 0x00000040,
	cmMatchProfileFlags			= 0x00000080
};

/* Result codes */
enum {
/* General Errors */
	cmProfileError				= -170,
	cmMethodError				= -171,
	cmMethodNotFound			= -175,							/* CMM not present */
	cmProfileNotFound			= -176,							/* Responder error */
	cmProfilesIdentical			= -177,							/* Profiles the same */
	cmCantConcatenateError		= -178,							/* Profile can't be concatenated */
	cmCantXYZ					= -179,							/* CMM cant handle XYZ space */
	cmCantDeleteProfile			= -180,							/* Responder error */
	cmUnsupportedDataType		= -181,							/* Responder error */
	cmNoCurrentProfile			= -182,							/* Responder error */
/* Profile Access Errors */
	cmElementTagNotFound		= -4200,
	cmIndexRangeErr				= -4201,						/* Index out of range */
	cmCantDeleteElement			= -4202,
	cmFatalProfileErr			= -4203,
	cmInvalidProfile			= -4204,						/* A Profile must contain a 'cs1 ' tag to be valid */
	cmInvalidProfileLocation	= -4205,						/* Operation not supported for this profile location */
/* Profile Search Errors */
	cmInvalidSearch				= -4206,						/* Bad Search Handle */
	cmSearchError				= -4207,
	cmErrIncompatibleProfile	= -4208,
/* Other ColorSync Errors */
	cmInvalidColorSpace			= -4209,						/* Profile colorspace does not match bitmap type */
	cmInvalidSrcMap				= -4210,						/* Source pix/bit map was invalid */
	cmInvalidDstMap				= -4211,						/* Destination pix/bit map was invalid */
	cmNoGDevicesError			= -4212,						/* Begin/End Matching -- no gdevices available */
	cmInvalidProfileComment		= -4213,						/* Bad Profile comment during drawpicture */
/* Color Conversion Errors */
	cmRangeOverFlow				= -4214,						/* One or more output color value overflows in color conversion 
														all input color values will still be converted, and the overflown 
														will be clipped */
/* Other Profile Access Errors */
	cmCantCopyModifiedV1Profile	= -4215							/* It is illegal to copy version 1 profiles that  
														have been modified */
};

/* deviceType values for ColorSync 1.0 Device Profile access */
enum {
	cmSystemDevice				= 'sys ',
	cmGDevice					= 'gdev'
};

/* Commands for CMFlattenUPP(…) */
enum {
	cmOpenReadSpool				= 1,
	cmOpenWriteSpool,
	cmReadSpool,
	cmWriteSpool,
	cmCloseSpool
};

/* Flags for PostScript-related functions */
enum {
	cmPS7bit					= 1,
	cmPS8bit					= 2
};

typedef struct CMPrivateProfileRecord *CMProfileRef;

/* Abstract data type for Profile search result */
typedef struct CMPrivateProfileSearchResult *CMProfileSearchRef;

/* Abstract data type for BeginMatching(…) reference */
typedef struct CMPrivateMatchRefRecord *CMMatchRef;

/* Abstract data type for ColorWorld reference */
typedef struct CMPrivateColorWorldRecord *CMWorldRef;

/* Caller-supplied progress function for Bitmap & PixMap matching routines */
/* Caller-supplied filter function for Profile search */
typedef pascal OSErr (*CMFlattenProcPtr)(long command, long *size, void *data, void *refCon);
typedef pascal Boolean (*CMBitmapCallBackProcPtr)(long progress, void *refCon);
typedef pascal Boolean (*CMProfileFilterProcPtr)(CMProfileRef prof, void *refCon);

#if GENERATINGCFM
typedef UniversalProcPtr CMFlattenUPP;
typedef UniversalProcPtr CMBitmapCallBackUPP;
typedef UniversalProcPtr CMProfileFilterUPP;
#else
typedef CMFlattenProcPtr CMFlattenUPP;
typedef CMBitmapCallBackProcPtr CMBitmapCallBackUPP;
typedef CMProfileFilterProcPtr CMProfileFilterUPP;
#endif

enum {
	uppCMFlattenProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(OSErr)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(long*)))
		 | STACK_ROUTINE_PARAMETER(3, SIZE_CODE(sizeof(void*)))
		 | STACK_ROUTINE_PARAMETER(4, SIZE_CODE(sizeof(void*))),
	uppCMBitmapCallBackProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(long)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*))),
	uppCMProfileFilterProcInfo = kPascalStackBased
		 | RESULT_SIZE(SIZE_CODE(sizeof(Boolean)))
		 | STACK_ROUTINE_PARAMETER(1, SIZE_CODE(sizeof(CMProfileRef)))
		 | STACK_ROUTINE_PARAMETER(2, SIZE_CODE(sizeof(void*)))
};

#if GENERATINGCFM
#define NewCMFlattenProc(userRoutine)		\
		(CMFlattenUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppCMFlattenProcInfo, GetCurrentArchitecture())
#define NewCMBitmapCallBackProc(userRoutine)		\
		(CMBitmapCallBackUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppCMBitmapCallBackProcInfo, GetCurrentArchitecture())
#define NewCMProfileFilterProc(userRoutine)		\
		(CMProfileFilterUPP) NewRoutineDescriptor((ProcPtr)(userRoutine), uppCMProfileFilterProcInfo, GetCurrentArchitecture())
#else
#define NewCMFlattenProc(userRoutine)		\
		((CMFlattenUPP) (userRoutine))
#define NewCMBitmapCallBackProc(userRoutine)		\
		((CMBitmapCallBackUPP) (userRoutine))
#define NewCMProfileFilterProc(userRoutine)		\
		((CMProfileFilterUPP) (userRoutine))
#endif

#if GENERATINGCFM
#define CallCMFlattenProc(userRoutine, command, size, data, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppCMFlattenProcInfo, (command), (size), (data), (refCon))
#define CallCMBitmapCallBackProc(userRoutine, progress, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppCMBitmapCallBackProcInfo, (progress), (refCon))
#define CallCMProfileFilterProc(userRoutine, prof, refCon)		\
		CallUniversalProc((UniversalProcPtr)(userRoutine), uppCMProfileFilterProcInfo, (prof), (refCon))
#else
#define CallCMFlattenProc(userRoutine, command, size, data, refCon)		\
		(*(userRoutine))((command), (size), (data), (refCon))
#define CallCMBitmapCallBackProc(userRoutine, progress, refCon)		\
		(*(userRoutine))((progress), (refCon))
#define CallCMProfileFilterProc(userRoutine, prof, refCon)		\
		(*(userRoutine))((prof), (refCon))
#endif

typedef long CMError;

/* For 1.0 and 2.0 profile header variants */
/* CMAppleProfileHeader */
union CMAppleProfileHeader {
	CMHeader						cm1;
	CM2Header						cm2;
};
typedef union CMAppleProfileHeader CMAppleProfileHeader;

/* Param for CWConcatColorWorld(…) */
struct CMConcatProfileSet {
	unsigned short					keyIndex;					/* Zero-based */
	unsigned short					count;						/* Min 1 */
	CMProfileRef					profileSet[1];				/* Variable. Ordered from Source -> Dest */
};
typedef struct CMConcatProfileSet CMConcatProfileSet;

/* ColorSync color data types */
struct CMRGBColor {
	unsigned short					red;						/* 0..65535 */
	unsigned short					green;
	unsigned short					blue;
};
typedef struct CMRGBColor CMRGBColor;

struct CMCMYKColor {
	unsigned short					cyan;						/* 0..65535 */
	unsigned short					magenta;
	unsigned short					yellow;
	unsigned short					black;
};
typedef struct CMCMYKColor CMCMYKColor;

struct CMCMYColor {
	unsigned short					cyan;						/* 0..65535 */
	unsigned short					magenta;
	unsigned short					yellow;
};
typedef struct CMCMYColor CMCMYColor;

struct CMHLSColor {
	unsigned short					hue;						/* 0..65535. Fraction of circle. Red at 0 */
	unsigned short					lightness;					/* 0..65535 */
	unsigned short					saturation;					/* 0..65535 */
};
typedef struct CMHLSColor CMHLSColor;

struct CMHSVColor {
	unsigned short					hue;						/* 0..65535. Fraction of circle. Red at 0 */
	unsigned short					saturation;					/* 0..65535 */
	unsigned short					value;						/* 0..65535 */
};
typedef struct CMHSVColor CMHSVColor;

struct CMLabColor {
	unsigned short					L;							/* 0..65535 maps to 0..100 */
	unsigned short					a;							/* 0..65535 maps to -128..127.996 */
	unsigned short					b;							/* 0..65535 maps to -128..127.996 */
};
typedef struct CMLabColor CMLabColor;

struct CMLuvColor {
	unsigned short					L;							/* 0..65535 maps to 0..100 */
	unsigned short					u;							/* 0..65535 maps to -128..127.996 */
	unsigned short					v;							/* 0..65535 maps to -128..127.996 */
};
typedef struct CMLuvColor CMLuvColor;

struct CMYxyColor {
	unsigned short					capY;						/* 0..65535 maps to 0..1 */
	unsigned short					x;							/* 0..65535 maps to 0..1 */
	unsigned short					y;							/* 0..65535 maps to 0..1 */
};
typedef struct CMYxyColor CMYxyColor;

struct CMGrayColor {
	unsigned short					gray;						/* 0..65535 */
};
typedef struct CMGrayColor CMGrayColor;

struct CMMultichannel5Color {
	unsigned char					components[5];				/* 0..255 */
};
typedef struct CMMultichannel5Color CMMultichannel5Color;

struct CMMultichannel6Color {
	unsigned char					components[6];				/* 0..255 */
};
typedef struct CMMultichannel6Color CMMultichannel6Color;

struct CMMultichannel7Color {
	unsigned char					components[7];				/* 0..255 */
};
typedef struct CMMultichannel7Color CMMultichannel7Color;

struct CMMultichannel8Color {
	unsigned char					components[8];				/* 0..255 */
};
typedef struct CMMultichannel8Color CMMultichannel8Color;

union CMColor {
	CMRGBColor						rgb;
	CMHSVColor						hsv;
	CMHLSColor						hls;
	CMXYZColor						XYZ;
	CMLabColor						Lab;
	CMLuvColor						Luv;
	CMYxyColor						Yxy;
	CMCMYKColor						cmyk;
	CMCMYColor						cmy;
	CMGrayColor						gray;
	CMMultichannel5Color			mc5;
	CMMultichannel6Color			mc6;
	CMMultichannel7Color			mc7;
	CMMultichannel8Color			mc8;
};
typedef union CMColor CMColor;

struct CMProfileSearchRecord {
	CMHeader						header;
	unsigned long					fieldMask;
	unsigned long					reserved[2];
};
typedef struct CMProfileSearchRecord CMProfileSearchRecord, **CMProfileSearchRecordHandle;

/* Search definition for 2.0 */
struct CMSearchRecord {
	OSType							CMMType;
	OSType							profileClass;
	OSType							dataColorSpace;
	OSType							profileConnectionSpace;
	unsigned long					deviceManufacturer;
	unsigned long					deviceModel;
	unsigned long					deviceAttributes[2];
	unsigned long					profileFlags;
	unsigned long					searchMask;
	CMProfileFilterUPP				filter;
};
typedef struct CMSearchRecord CMSearchRecord;

/* GetCWInfo structures */
struct CMMInfoRecord {
	OSType							CMMType;
	long							CMMVersion;
};
typedef struct CMMInfoRecord CMMInfoRecord;

struct CMCWInfoRecord {
	unsigned long					cmmCount;
	CMMInfoRecord					cmmInfo[2];
};
typedef struct CMCWInfoRecord CMCWInfoRecord;


enum {
	cmNoColorPacking			= 0x0000,
	cmAlphaSpace				= 0x0080,
	cmWord5ColorPacking			= 0x0500,
	cmLong8ColorPacking			= 0x0800,
	cmLong10ColorPacking		= 0x0a00,
	cmAlphaFirstPacking			= 0x1000,
	cmOneBitDirectPacking		= 0x0b00
};

enum {
	cmNoSpace					= 0,
	cmRGBSpace,
	cmCMYKSpace,
	cmHSVSpace,
	cmHLSSpace,
	cmYXYSpace,
	cmXYZSpace,
	cmLUVSpace,
	cmLABSpace,
	cmReservedSpace1,
	cmGraySpace,
	cmReservedSpace2,
	cmGamutResultSpace,
	cmRGBASpace					= cmRGBSpace + cmAlphaSpace,
	cmGrayASpace				= cmGraySpace + cmAlphaSpace,
	cmRGB16Space				= cmWord5ColorPacking + cmRGBSpace,
	cmRGB32Space				= cmLong8ColorPacking + cmRGBSpace,
	cmARGB32Space				= cmLong8ColorPacking + cmAlphaFirstPacking + cmRGBASpace,
	cmCMYK32Space				= cmLong8ColorPacking + cmCMYKSpace,
	cmHSV32Space				= cmLong10ColorPacking + cmHSVSpace,
	cmHLS32Space				= cmLong10ColorPacking + cmHLSSpace,
	cmYXY32Space				= cmLong10ColorPacking + cmYXYSpace,
	cmXYZ32Space				= cmLong10ColorPacking + cmXYZSpace,
	cmLUV32Space				= cmLong10ColorPacking + cmLUVSpace,
	cmLAB32Space				= cmLong10ColorPacking + cmLABSpace,
	cmGamutResult1Space			= cmOneBitDirectPacking + cmGamutResultSpace
};

typedef unsigned long CMBitmapColorSpace;

struct CMBitmap {
	char							*image;
	long							width;
	long							height;
	long							rowBytes;
	long							pixelSize;
	CMBitmapColorSpace				space;
	long							user1;
	long							user2;
};
typedef struct CMBitmap CMBitmap;

/* Classic Print Manager Stuff */

enum {
	enableColorMatchingOp		= 12,
	registerProfileOp			= 13
};

/* PrGeneral parameter blocks */
struct TEnableColorMatchingBlk {
	short							iOpCode;
	short							iError;
	long							lReserved;
	THPrint							hPrint;
	Boolean							fEnableIt;
	SInt8							filler;
};
typedef struct TEnableColorMatchingBlk TEnableColorMatchingBlk;

struct TRegisterProfileBlk {
	short							iOpCode;
	short							iError;
	long							lReserved;
	THPrint							hPrint;
	Boolean							fRegisterIt;
	SInt8							filler;
};
typedef struct TRegisterProfileBlk TRegisterProfileBlk;


enum {
	cmNoProfileBase				= 0,
	cmFileBasedProfile			= 1,
	cmHandleBasedProfile		= 2,
	cmPtrBasedProfile			= 3
};

struct CMFileLocation {
	FSSpec							spec;
};
typedef struct CMFileLocation CMFileLocation;

struct CMHandleLocation {
	Handle							h;
};
typedef struct CMHandleLocation CMHandleLocation;

struct CMPtrLocation {
	Ptr								p;
};
typedef struct CMPtrLocation CMPtrLocation;

union CMProfLoc {
	CMFileLocation					fileLoc;
	CMHandleLocation				handleLoc;
	CMPtrLocation					ptrLoc;
};
typedef union CMProfLoc CMProfLoc;

struct CMProfileLocation {
	short							locType;
	CMProfLoc						u;
};
typedef struct CMProfileLocation CMProfileLocation;

/* Profile file and element access */
extern pascal CMError CMOpenProfile(CMProfileRef *prof, const CMProfileLocation *theProfile)
 FOURWORDINLINE(0x203C, 0x0008, 0x001C, 0xABEE);
extern pascal CMError CMCloseProfile(CMProfileRef prof)
 FOURWORDINLINE(0x203C, 0x0004, 0x001D, 0xABEE);
extern pascal CMError CMUpdateProfile(CMProfileRef prof)
 FOURWORDINLINE(0x203C, 0x0004, 0x0034, 0xABEE);
extern pascal CMError CMNewProfile(CMProfileRef *prof, const CMProfileLocation *theProfile)
 FOURWORDINLINE(0x203C, 0x0008, 0x001B, 0xABEE);
extern pascal CMError CMCopyProfile(CMProfileRef *targetProf, const CMProfileLocation *targetLocation, CMProfileRef srcProf)
 FOURWORDINLINE(0x203C, 0x000C, 0x0025, 0x0ABEE);
extern pascal CMError CMGetProfileLocation(CMProfileRef prof, CMProfileLocation *theProfile)
 FOURWORDINLINE(0x203C, 0x0008, 0x003C, 0x0ABEE);
extern pascal CMError CMValidateProfile(CMProfileRef prof, Boolean *valid, Boolean *preferredCMMnotfound)
 FOURWORDINLINE(0x203C, 0x000C, 0x0026, 0x0ABEE);
extern pascal CMError CMFlattenProfile(CMProfileRef prof, unsigned long flags, CMFlattenUPP proc, void *refCon, Boolean *preferredCMMnotfound)
 FOURWORDINLINE(0x203C, 0x0014, 0x0031, 0x0ABEE);
extern pascal CMError CMUnflattenProfile(FSSpec *resultFileSpec, CMFlattenUPP proc, void *refCon, Boolean *preferredCMMnotfound)
 FOURWORDINLINE(0x203C, 0x0010, 0x0032, 0x0ABEE);
extern pascal CMError CMProfileElementExists(CMProfileRef prof, OSType tag, Boolean *found)
 FOURWORDINLINE(0x203C, 0x000C, 0x001E, 0x0ABEE);
extern pascal CMError CMCountProfileElements(CMProfileRef prof, unsigned long *elementCount)
 FOURWORDINLINE(0x203C, 0x0008, 0x001F, 0x0ABEE);
extern pascal CMError CMGetProfileElement(CMProfileRef prof, OSType tag, unsigned long *elementSize, void *elementData)
 FOURWORDINLINE(0x203C, 0x0010, 0x0020, 0x0ABEE);
extern pascal CMError CMGetProfileHeader(CMProfileRef prof, CMAppleProfileHeader *header)
 FOURWORDINLINE(0x203C, 0x0008, 0x0039, 0x0ABEE);
extern pascal CMError CMGetPartialProfileElement(CMProfileRef prof, OSType tag, unsigned long offset, unsigned long *byteCount, void *elementData)
 FOURWORDINLINE(0x203C, 0x0014, 0x0036, 0x0ABEE);
extern pascal CMError CMSetProfileElementSize(CMProfileRef prof, OSType tag, unsigned long elementSize)
 FOURWORDINLINE(0x203C, 0x000C, 0x0038, 0x0ABEE);
extern pascal CMError CMSetPartialProfileElement(CMProfileRef prof, OSType tag, unsigned long offset, unsigned long byteCount, void *elementData)
 FOURWORDINLINE(0x203C, 0x0014, 0x0037, 0x0ABEE);
extern pascal CMError CMGetIndProfileElementInfo(CMProfileRef prof, unsigned long index, OSType *tag, unsigned long *elementSize, Boolean *refs)
 FOURWORDINLINE(0x203C, 0x0014, 0x0021, 0x0ABEE);
extern pascal CMError CMGetIndProfileElement(CMProfileRef prof, unsigned long index, unsigned long *elementSize, void *elementData)
 FOURWORDINLINE(0x203C, 0x0010, 0x0022, 0x0ABEE);
extern pascal CMError CMSetProfileElement(CMProfileRef prof, OSType tag, unsigned long elementSize, void *elementData)
 FOURWORDINLINE(0x203C, 0x0010, 0x0023, 0x0ABEE);
extern pascal CMError CMSetProfileHeader(CMProfileRef prof, const CMAppleProfileHeader *header)
 FOURWORDINLINE(0x203C, 0x0008, 0x003A, 0x0ABEE);
extern pascal CMError CMSetProfileElementReference(CMProfileRef prof, OSType elementTag, OSType referenceTag)
 FOURWORDINLINE(0x203C, 0x000C, 0x0035, 0x0ABEE);
extern pascal CMError CMRemoveProfileElement(CMProfileRef prof, OSType tag)
 FOURWORDINLINE(0x203C, 0x0008, 0x0024, 0x0ABEE);
extern pascal CMError CMGetScriptProfileDescription(CMProfileRef prof, Str255 name, ScriptCode *code)
 FOURWORDINLINE(0x203C, 0x000C, 0x003E, 0x0ABEE);
/* Low-level matching functions */
extern pascal CMError NCWNewColorWorld(CMWorldRef *cw, CMProfileRef src, CMProfileRef dst)
 FOURWORDINLINE(0x203C, 0x000C, 0x0014, 0x0ABEE);
extern pascal CMError CWConcatColorWorld(CMWorldRef *cw, CMConcatProfileSet *profileSet)
 FOURWORDINLINE(0x203C, 0x0008, 0x0015, 0x0ABEE);
extern pascal CMError CWNewLinkProfile(CMProfileRef *prof, const CMProfileLocation *targetLocation, CMConcatProfileSet *profileSet)
 FOURWORDINLINE(0x203C, 0x000C, 0x0033, 0x0ABEE);
extern pascal void CWDisposeColorWorld(CMWorldRef cw)
 FOURWORDINLINE(0x203C, 0x0004, 0x0001, 0x0ABEE);
extern pascal CMError CWMatchColors(CMWorldRef cw, CMColor *myColors, unsigned long count)
 FOURWORDINLINE(0x203C, 0x000C, 0x0002, 0x0ABEE);
extern pascal CMError CWCheckColors(CMWorldRef cw, CMColor *myColors, unsigned long count, long *result)
 FOURWORDINLINE(0x203C, 0x0010, 0x0003, 0x0ABEE);
/* Bitmap matching */
extern pascal CMError CWMatchBitmap(CMWorldRef cw, CMBitmap *bitmap, CMBitmapCallBackUPP progressProc, void *refCon, CMBitmap *matchedBitmap)
 FOURWORDINLINE(0x203C, 0x0010, 0x002C, 0x0ABEE);
extern pascal CMError CWCheckBitmap(CMWorldRef cw, const CMBitmap *bitmap, CMBitmapCallBackUPP progressProc, void *refCon, CMBitmap *resultBitmap)
 FOURWORDINLINE(0x203C, 0x0014, 0x002D, 0x0ABEE);
/* Quickdraw-specific matching */
extern pascal CMError CWMatchPixMap(CMWorldRef cw, PixMap *myPixMap, CMBitmapCallBackUPP progressProc, void *refCon)
 FOURWORDINLINE(0x203C, 0x0010, 0x0004, 0x0ABEE);
extern pascal CMError CWCheckPixMap(CMWorldRef cw, PixMap *myPixMap, CMBitmapCallBackUPP progressProc, void *refCon, BitMap *resultBitMap)
 FOURWORDINLINE(0x203C, 0x0014, 0x0007, 0x0ABEE);
extern pascal CMError NCMBeginMatching(CMProfileRef src, CMProfileRef dst, CMMatchRef *myRef)
 FOURWORDINLINE(0x203C, 0x000C, 0x0016, 0x0ABEE);
extern pascal void CMEndMatching(CMMatchRef myRef)
 FOURWORDINLINE(0x203C, 0x0004, 0x000B, 0x0ABEE);
extern pascal void NCMDrawMatchedPicture(PicHandle myPicture, CMProfileRef dst, Rect *myRect)
 FOURWORDINLINE(0x203C, 0x000C, 0x0017, 0x0ABEE);
extern pascal void CMEnableMatchingComment(Boolean enableIt)
 FOURWORDINLINE(0x203C, 0x0002, 0x000D, 0x0ABEE);
extern pascal CMError NCMUseProfileComment(CMProfileRef prof, unsigned long flags)
 FOURWORDINLINE(0x203C, 0x0008, 0x003B, 0x0ABEE);
/* System Profile access */
extern pascal CMError CMGetSystemProfile(CMProfileRef *prof)
 FOURWORDINLINE(0x203C, 0x0004, 0x0018, 0x0ABEE);
extern pascal CMError CMSetSystemProfile(const FSSpec *profileFileSpec)
 FOURWORDINLINE(0x203C, 0x0004, 0x0019, 0x0ABEE);
/* External Profile Management */
extern pascal CMError CMNewProfileSearch(CMSearchRecord *searchSpec, void *refCon, unsigned long *count, CMProfileSearchRef *searchResult)
 FOURWORDINLINE(0x203C, 0x0010, 0x0027, 0x0ABEE);
extern pascal CMError CMUpdateProfileSearch(CMProfileSearchRef search, void *refCon, unsigned long *count)
 FOURWORDINLINE(0x203C, 0x000C, 0x0028, 0x0ABEE);
extern pascal void CMDisposeProfileSearch(CMProfileSearchRef search)
 FOURWORDINLINE(0x203C, 0x0004, 0x0029, 0x0ABEE);
extern pascal CMError CMSearchGetIndProfile(CMProfileSearchRef search, unsigned long index, CMProfileRef *prof)
 FOURWORDINLINE(0x203C, 0x000C, 0x002A, 0x0ABEE);
extern pascal CMError CMSearchGetIndProfileFileSpec(CMProfileSearchRef search, unsigned long index, FSSpec *profileFile)
 FOURWORDINLINE(0x203C, 0x000C, 0x002B, 0x0ABEE);
/* Utilities */
extern pascal CMError CMGetColorSyncFolderSpec(short vRefNum, Boolean createFolder, short *foundVRefNum, long *foundDirID)
 FOURWORDINLINE(0x203C, 0x000C, 0x0011, 0x0ABEE);
extern pascal CMError CMGetCWInfo(CMWorldRef cw, CMCWInfoRecord *info)
 FOURWORDINLINE(0x203C, 0x000C, 0x001A, 0x0ABEE);
/* PS-related */
extern pascal CMError CMGetPS2ColorSpace(CMProfileRef srcProf, unsigned long flags, CMFlattenUPP proc, void *refCon, Boolean *preferredCMMnotfound)
 FOURWORDINLINE(0x203C, 0x0014, 0x002E, 0x0ABEE);
extern pascal CMError CMGetPS2ColorRenderingIntent(CMProfileRef srcProf, unsigned long flags, CMFlattenUPP proc, void *refCon, Boolean *preferredCMMnotfound)
 FOURWORDINLINE(0x203C, 0x0014, 0x002F, 0x0ABEE);
extern pascal CMError CMGetPS2ColorRendering(CMProfileRef srcProf, CMProfileRef dstProf, unsigned long flags, CMFlattenUPP proc, void *refCon, Boolean *preferredCMMnotfound)
 FOURWORDINLINE(0x203C, 0x0018, 0x0030, 0x0ABEE);
extern pascal CMError CMGetPS2ColorRenderingVMSize(CMProfileRef srcProf, CMProfileRef dstProf, unsigned long *vmSize, Boolean *preferredCMMnotfound)
 FOURWORDINLINE(0x203C, 0x0010, 0x003D, 0x0ABEE);
/* ColorSync 1.0 functions which have parallel 2.0 counterparts */
extern pascal CMError CWNewColorWorld(CMWorldRef *cw, CMProfileHandle src, CMProfileHandle dst)
 FOURWORDINLINE(0x203C, 0x000C, 0x0000, 0x0ABEE);
extern pascal CMError ConcatenateProfiles(CMProfileHandle thru, CMProfileHandle dst, CMProfileHandle *newDst)
 FOURWORDINLINE(0x203C, 0x000C, 0x000C, 0x0ABEE);
extern pascal CMError CMBeginMatching(CMProfileHandle src, CMProfileHandle dst, CMMatchRef *myRef)
 FOURWORDINLINE(0x203C, 0x000C, 0x000A, 0x0ABEE);
extern pascal void CMDrawMatchedPicture(PicHandle myPicture, CMProfileHandle dst, Rect *myRect)
 FOURWORDINLINE(0x203C, 0x000C, 0x0009, 0x0ABEE);
extern pascal CMError CMUseProfileComment(CMProfileHandle profile)
 FOURWORDINLINE(0x203C, 0x0004, 0x0008, 0x0ABEE);
extern pascal void CMGetProfileName(CMProfileHandle myProfile, CMIString *IStringResult)
 FOURWORDINLINE(0x203C, 0x0008, 0x000E, 0x0ABEE);
extern pascal long CMGetProfileAdditionalDataOffset(CMProfileHandle myProfile)
 FOURWORDINLINE(0x203C, 0x0004, 0x000F, 0x0ABEE);
/* ProfileResponder functions */
extern pascal CMError GetProfile(OSType deviceType, long refNum, CMProfileHandle aProfile, CMProfileHandle *returnedProfile)
 FOURWORDINLINE(0x203C, 0x0010, 0x0005, 0x0ABEE);
extern pascal CMError SetProfile(OSType deviceType, long refNum, CMProfileHandle newProfile)
 FOURWORDINLINE(0x203C, 0x000C, 0x0006, 0x0ABEE);
extern pascal CMError SetProfileDescription(OSType deviceType, long refNum, long deviceData, CMProfileHandle hProfile)
 FOURWORDINLINE(0x203C, 0x0010, 0x0010, 0x0ABEE);
extern pascal CMError GetIndexedProfile(OSType deviceType, long refNum, CMProfileSearchRecordHandle search, CMProfileHandle *returnProfile, long *index)
 FOURWORDINLINE(0x203C, 0x0014, 0x0012, 0x0ABEE);
extern pascal CMError DeleteDeviceProfile(OSType deviceType, long refNum, CMProfileHandle deleteMe)
 FOURWORDINLINE(0x203C, 0x000C, 0x0013, 0x0ABEE);
#if OLDROUTINENAMES
typedef CMFlattenProcPtr CMFlattenProc;

typedef CMBitmapCallBackProcPtr CMBitmapCallBackProc;

typedef CMProfileFilterProcPtr CMProfileFilterProc;


enum {
	CMTrap						= cmTrap,
	CMBeginProfile				= cmBeginProfile,
	CMEndProfile				= cmEndProfile,
	CMEnableMatching			= cmEnableMatching,
	CMDisableMatching			= cmDisableMatching
};

/* 1.0 Error codes, for compatibility with older applications. 1.0 CMM's may return obsolete error codes */
enum {
	CMNoError					= 0,							/*	obsolete name, use noErr */
	CMProfileError				= cmProfileError,
	CMMethodError				= cmMethodError,
	CMMemFullError				= -172,							/*	obsolete, 2.0 uses memFullErr */
	CMUnimplementedError		= -173,							/*	obsolete, 2.0 uses unimpErr */
	CMParamError				= -174,							/*	obsolete, 2.0 uses paramErr */
	CMMethodNotFound			= cmMethodNotFound,
	CMProfileNotFound			= cmProfileNotFound,
	CMProfilesIdentical			= cmProfilesIdentical,
	CMCantConcatenateError		= cmCantConcatenateError,
	CMCantXYZ					= cmCantXYZ,
	CMCantDeleteProfile			= cmCantDeleteProfile,
	CMUnsupportedDataType		= cmUnsupportedDataType,
	CMNoCurrentProfile			= cmNoCurrentProfile
};

enum {
	qdSystemDevice				= cmSystemDevice,
	qdGDevice					= cmGDevice
};

enum {
	kMatchCMMType				= cmMatchCMMType,
	kMatchApplProfileVersion	= cmMatchApplProfileVersion,
	kMatchDataType				= cmMatchDataType,
	kMatchDeviceType			= cmMatchDeviceType,
	kMatchDeviceManufacturer	= cmMatchDeviceManufacturer,
	kMatchDeviceModel			= cmMatchDeviceModel,
	kMatchDeviceAttributes		= cmMatchDeviceAttributes,
	kMatchFlags					= cmMatchFlags,
	kMatchOptions				= cmMatchOptions,
	kMatchWhite					= cmMatchWhite,
	kMatchBlack					= cmMatchBlack
};

/* types */
typedef struct CMCMYKColor CMYKColor;

typedef CMWorldRef CWorld;

typedef long *CMGamutResult;

/* functions */
#define EndMatching(myRef) CMEndMatching(myRef)
#define EnableMatching(enableIt) CMEnableMatchingComment(enableIt)
#define GetColorSyncFolderSpec(vRefNum, createFolder, foundVRefNum, foundDirID) CMGetColorSyncFolderSpec(vRefNum, createFolder, foundVRefNum, foundDirID)
#define BeginMatching(src, dst, myRef) CMBeginMatching(src, dst, myRef)
#define DrawMatchedPicture(myPicture, dst, myRect) CMDrawMatchedPicture(myPicture, dst, myRect)
#define UseProfile(profile) CMUseProfileComment(profile)
#define GetProfileName(myProfile, IStringResult) CMGetProfileName(myProfile, IStringResult)
#define GetProfileAdditionalDataOffset(myProfile) CMGetProfileAdditionalDataOffset(myProfile)
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

#endif /* __CMAPPLICATION__ */

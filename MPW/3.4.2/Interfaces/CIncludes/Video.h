/*
 	File:		Video.h
 
 	Contains:	Video Driver Interfaces.
 
 	Version:	Technology:	PowerSurge 1.0.2.
 				Package:	Universal Interfaces 2.1.2 on ETO #20
 
 	Copyright:	© 1984-1995 by Apple Computer, Inc.
 				All rights reserved.
 
 	Bugs?:		If you find a problem with this file, use the Apple Bug Reporter
 				stack.  Include the file and version information (from above)
 				in the problem description and send to:
 					Internet:	apple.bugs@applelink.apple.com
 					AppleLink:	APPLE.BUGS
 
*/

#ifndef __VIDEO__
#define __VIDEO__


#ifndef __QUICKDRAW__
#include <Quickdraw.h>
#endif
/*	#include <Types.h>											*/
/*		#include <ConditionalMacros.h>							*/
/*	#include <MixedMode.h>										*/
/*	#include <QuickdrawText.h>									*/

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
	mBaseOffset					= 1,							/*Id of mBaseOffset.*/
	mRowBytes					= 2,							/*Video sResource parameter Id's */
	mBounds						= 3,							/*Video sResource parameter Id's */
	mVersion					= 4,							/*Video sResource parameter Id's */
	mHRes						= 5,							/*Video sResource parameter Id's */
	mVRes						= 6,							/*Video sResource parameter Id's */
	mPixelType					= 7,							/*Video sResource parameter Id's */
	mPixelSize					= 8,							/*Video sResource parameter Id's */
	mCmpCount					= 9,							/*Video sResource parameter Id's */
	mCmpSize					= 10,							/*Video sResource parameter Id's */
	mPlaneBytes					= 11,							/*Video sResource parameter Id's */
	mVertRefRate				= 14,							/*Video sResource parameter Id's */
	mVidParams					= 1,							/*Video parameter block id.*/
	mTable						= 2,							/*Offset to the table.*/
	mPageCnt					= 3,							/*Number of pages*/
	mDevType					= 4,							/*Device Type*/
	oneBitMode					= 128,							/*Id of OneBitMode Parameter list.*/
	twoBitMode					= 129,							/*Id of TwoBitMode Parameter list.*/
	fourBitMode					= 130,							/*Id of FourBitMode Parameter list.*/
	eightBitMode				= 131							/*Id of EightBitMode Parameter list.*/
};

enum {
	sixteenBitMode				= 132,							/*Id of SixteenBitMode Parameter list.*/
	thirtyTwoBitMode			= 133,							/*Id of ThirtyTwoBitMode Parameter list.*/
	firstVidMode				= 128,							/*The new, better way to do the above. */
	secondVidMode				= 129,							/* QuickDraw only supports six video */
	thirdVidMode				= 130,							/* at this time.      */
	fourthVidMode				= 131,
	fifthVidMode				= 132,
	sixthVidMode				= 133,
	spGammaDir					= 64,
	spVidNamesDir				= 65
};

/* csTimingFormat values in VDTimingInfo */
/* look in the declaration rom for timing info */
enum {
	kDeclROMtables				= 'decl'
};

/* Timing mode constants for Display Manager MultiMode support
	Corresponding	.h equates are in Video.h
					.a equates are in Video.a
					.r equates are in DepVideoEqu.r
	
	The first enum is the old names (for compatibility).
	The second enum is the new names.
*/
enum {
	timingApple12				= 130,							/*  512x384 (60 Hz) Rubik timing.*/
	timingApple12x				= 135,							/*  560x384 (60 Hz) Rubik-560 timing.*/
	timingApple13				= 140,							/*  640x480 (67 Hz) HR timing.*/
	timingApple13x				= 145,							/*  640x400 (67 Hz) HR-400 timing.*/
	timingAppleVGA				= 150,							/*  640x480  (60 Hz) VGA timing.*/
	timingApple15				= 160,							/*  640x870 (75 Hz) FPD timing.*/
	timingApple15x				= 165,							/*  640x818 (75 Hz) FPD-818 timing.*/
	timingApple16				= 170,							/*  832x624 (75 Hz) GoldFish timing.*/
	timingAppleSVGA				= 180,							/*  800x600  (56 Hz) SVGA timing.*/
	timingApple1Ka				= 190,							/* 1024x768 (60 Hz) VESA 1K-60Hz timing.*/
	timingApple1Kb				= 200,							/* 1024x768 (70 Hz) VESA 1K-70Hz timing.*/
	timingApple19				= 210,							/* 1024x768  (75 Hz) Apple 19" RGB.*/
	timingApple21				= 220							/* 1152x870  (75 Hz) Apple 21" RGB.*/
};

enum {
	timingInvalid				= 0,							/* Unknown timing… force user to confirm.*/
	timingApple_512x384_60hz	= 130,							/*  512x384  (60 Hz) Rubik timing.*/
	timingApple_560x384_60hz	= 135,							/*  560x384  (60 Hz) Rubik-560 timing.*/
	timingApple_640x480_67hz	= 140,							/*  640x480  (67 Hz) HR timing.*/
	timingApple_640x400_67hz	= 145,							/*  640x400  (67 Hz) HR-400 timing.*/
	timingVESA_640x480_60hz		= 150,							/*  640x480  (60 Hz) VGA timing.*/
	timingApple_640x870_75hz	= 160,							/*  640x870  (75 Hz) FPD timing.*/
	timingApple_640x818_75hz	= 165,							/*  640x818  (75 Hz) FPD-818 timing.*/
	timingApple_832x624_75hz	= 170,							/*  832x624  (75 Hz) GoldFish timing.*/
	timingVESA_800x600_56hz		= 180,							/*  800x600  (56 Hz) SVGA timing.*/
	timingVESA_800x600_60hz		= 182,							/*  800x600  (60 Hz) SVGA timing.*/
	timingVESA_800x600_72hz		= 184,							/*  800x600  (72 Hz) SVGA timing.*/
	timingVESA_800x600_75hz		= 186,							/*  800x600  (75 Hz) SVGA timing.*/
	timingVESA_1024x768_60hz	= 190,							/* 1024x768  (60 Hz) VESA 1K-60Hz timing.*/
	timingVESA_1024x768_70hz	= 200,							/* 1024x768  (70 Hz) VESA 1K-70Hz timing.*/
	timingVESA_1024x768_75hz	= 204,							/* 1024x768  (75 Hz) VESA 1K-70Hz timing (very similar to timingApple_1024x768_75hz).*/
	timingApple_1024x768_75hz	= 210,							/* 1024x768  (75 Hz) Apple 19" RGB.*/
	timingApple_1152x870_75hz	= 220,							/* 1152x870  (75 Hz) Apple 21" RGB.*/
	timingAppleNTSC_ST			= 230,							/*  512x384  (60 Hz, interlaced, non-convolved).*/
	timingAppleNTSC_FF			= 232,							/*  640x480  (60 Hz, interlaced, non-convolved).*/
	timingAppleNTSC_STconv		= 234,							/*  512x384  (60 Hz, interlaced, convolved).*/
	timingAppleNTSC_FFconv		= 236,							/*  640x480  (60 Hz, interlaced, convolved).*/
	timingApplePAL_ST			= 238,							/*  640x480  (50 Hz, interlaced, non-convolved).*/
	timingApplePAL_FF			= 240,							/*  768x576  (50 Hz, interlaced, non-convolved).*/
	timingApplePAL_STconv		= 242,							/*  640x480  (50 Hz, interlaced, convolved).*/
	timingApplePAL_FFconv		= 244,							/*  768x576  (50 Hz, interlaced, convolved).*/
	timingVESA_1280x960_75hz	= 250,							/* 1280x960  (75 Hz)*/
	timingVESA_1280x1024_60hz	= 260,							/* 1280x1024 (60 Hz)*/
	timingVESA_1280x1024_75hz	= 262,							/* 1280x1024 (75 Hz)*/
	timingVESA_1600x1200_60hz	= 280,							/* 1600x1200 (60 Hz) VESA proposed timing.*/
	timingVESA_1600x1200_65hz	= 282,							/* 1600x1200 (65 Hz) VESA proposed timing.*/
	timingVESA_1600x1200_70hz	= 284,							/* 1600x1200 (70 Hz) VESA proposed timing.*/
	timingVESA_1600x1200_75hz	= 286,							/* 1600x1200 (75 Hz) VESA proposed timing.*/
	timingVESA_1600x1200_80hz	= 288							/* 1600x1200 (80 Hz) VESA proposed timing (pixel clock is 216 Mhz dot clock).*/
};

/* csConnectFlags values in VDDisplayConnectInfo */
enum {
	kAllModesValid				= 0,							/* All modes not trimmed by primary init are good close enough to try */
	kAllModesSafe				= 1,							/* All modes not trimmed by primary init are know to be safe */
	kReportsTagging				= 2,							/* Can detect tagged displays (to identify smart monitors) */
	kHasDirectConnection		= 3,							/* True implies that driver can talk directly to device (e.g. serial data link via sense lines) */
	kIsMonoDev					= 4,							/* Says whether there’s an RGB (0) or Monochrome (1) connection. */
	kUncertainConnection		= 5,							/* There may not be a display (no sense lines?). */
	kTaggingInfoNonStandard		= 6,							/* Set when csConnectTaggedType/csConnectTaggedData are non-standard (i.e., not the Apple CRT sense codes). */
	kReportsDDCConnection		= 7,							/* Card can do ddc (set kHasDirectConnect && kHasDDCConnect if you actually found a ddc display). */
	kHasDDCConnection			= 8								/* Card has ddc connect now. */
};

/* csDisplayType values in VDDisplayConnectInfo */
enum {
	kUnknownConnect				= 1,							/* Not sure how we’ll use this, but seems like a good idea. */
	kPanelConnect				= 2,							/* For use with fixed-in-place LCD panels. */
	kPanelTFTConnect			= 2,							/* Alias for kPanelConnect */
	kFixedModeCRTConnect		= 3,							/*  For use with fixed-mode (i.e., very limited range) displays. */
	kMultiModeCRT1Connect		= 4,							/* 320x200 maybe, 12" maybe, 13" (default), 16" certain, 19" maybe, 21" maybe */
	kMultiModeCRT2Connect		= 5,							/* 320x200 maybe, 12" maybe, 13" certain, 16" (default), 19" certain, 21" maybe */
	kMultiModeCRT3Connect		= 6,							/* 320x200 maybe, 12" maybe, 13" certain, 16" certain, 19" default, 21" certain */
	kMultiModeCRT4Connect		= 7,							/* Expansion to large multi mode (not yet used) */
	kModelessConnect			= 8,							/* Expansion to modeless model (not yet used) */
	kFullPageConnect			= 9,							/* 640x818 (to get 8bpp in 512K case) and 640x870 (these two only) */
	kVGAConnect					= 10,							/* 640x480 VGA default -- question everything else */
	kNTSCConnect				= 11,							/* NTSC ST (default), FF, STconv, FFconv */
	kPALConnect					= 12,							/* PAL ST (default), FF, STconv, FFconv */
	kHRConnect					= 13,							/* Straight-6 connect -- 640x480 and 640x400 (to get 8bpp in 256K case) (these two only) */
	kPanelFSTNConnect			= 14,							/* For use with fixed-in-place LCD FSTN (aka “Supertwist”) panels */
	kMonoTwoPageConnect			= 15,							/* 1152x870 Apple color two-page display */
	kColorTwoPageConnect		= 16,							/* 1152x870 Apple B&W two-page display */
	kColor16Connect				= 17,							/* 832x624 Apple B&W two-page display */
	kColor19Connect				= 18							/* 1024x768 Apple B&W two-page display */
};

/* csTimingFlags values in VDTimingInfoRec */
enum {
	kModeValid					= 0,							/* Says that this mode should NOT be trimmed. */
	kModeSafe					= 1,							/* This mode does not need confirmation */
	kModeDefault				= 2,							/* This is the default mode for this type of connection */
	kModeShowNow				= 3,							/* This mode should always be shown (even though it may require a confirm) */
	kModeNotResize				= 4,							/* This mode should not be used to resize the display (eg. mode selects a different connector on card) */
	kModeRequiresPan			= 5								/* This mode has more pixels than are actually displayed */
};

/* csResolutionFlags bit flags for VDResolutionInfoRec */
enum {
	kResolutionHasMultipleDepthSizes = 0						/* Says that this mode has different csHorizontalPixels, csVerticalLines at different depths (usually slightly larger at lower depths) */
};

enum {
/*	Power Mode constants for VDPowerStateRec.powerState.	*/
	kAVPowerOff,
	kAVPowerStandby,
	kAVPowerSuspend,
	kAVPowerOn
};

enum {
/*	Power Mode masks and bits for VDPowerStateRec.powerFlags.	*/
	kPowerStateNeedsRefresh		= 0,
	kPowerStateNeedsRefreshMask	= (1L << 0)
};

enum {
/* Control Codes */
	cscReset					= 0,
	cscKillIO					= 1,
	cscSetMode					= 2,
	cscSetEntries				= 3,
	cscSetGamma					= 4,
	cscGrayPage					= 5,
	cscGrayScreen				= 5,
	cscSetGray					= 6,
	cscSetInterrupt				= 7,
	cscDirectSetEntries			= 8,
	cscSetDefaultMode			= 9,
	cscSwitchMode				= 10,
	cscSetSync					= 11,
	cscSavePreferredConfiguration = 16,
	cscSetHardwareCursor		= 22,
	cscDrawHardwareCursor		= 23,
	cscSetConvolution			= 24,
	cscSetPowerState			= 25,
	cscUnusedCall				= 127							/* This call used to expend the scrn resource.  Its imbedded data contains more control info */
};

enum {
/* Status Codes */
	cscGetMode					= 2,
	cscGetEntries				= 3,
	cscGetPageCnt				= 4,
	cscGetPages					= 4,							/* This is what C&D 2 calls it. */
	cscGetPageBase				= 5,
	cscGetBaseAddr				= 5,							/* This is what C&D 2 calls it. */
	cscGetGray					= 6,
	cscGetInterrupt				= 7,
	cscGetGamma					= 8,
	cscGetDefaultMode			= 9,
	cscGetCurMode				= 10,
	cscGetSync					= 11,
	cscGetConnection			= 12,							/* Return information about the connection to the display */
	cscGetModeTiming			= 13,							/* Return timing info for a mode */
	cscGetModeBaseAddress		= 14,							/* Return base address information about a particular mode */
	cscGetScanProc				= 15,							/* QuickTime scan chasing routine */
	cscGetPreferredConfiguration = 16,
	cscGetNextResolution		= 17,
	cscGetVideoParameters		= 18,
	cscGetGammaInfoList			= 20,
	cscRetrieveGammaTable		= 21,
	cscSupportsHardwareCursor	= 22,
	cscGetHardwareCursorDrawState = 23,
	cscGetConvolution			= 24,
	cscGetPowerState			= 25
};

/* Bit definitions for the Get/Set Sync call*/
enum {
	kDisableHorizontalSyncBit	= 0,
	kDisableVerticalSyncBit		= 1,
	kDisableCompositeSyncBit	= 2,
	kEnableSyncOnBlue			= 3,
	kEnableSyncOnGreen			= 4,
	kEnableSyncOnRed			= 5,
	kNoSeparateSyncControlBit	= 6,
	kHorizontalSyncMask			= 0x01,
	kVerticalSyncMask			= 0x02,
	kCompositeSyncMask			= 0x04,
	kDPMSSyncMask				= 0x7,
	kSyncOnBlueMask				= 0x08,
	kSyncOnGreenMask			= 0x10,
	kSyncOnRedMask				= 0x20,
	kSyncOnMask					= 0x38
};

enum {
/*	Power Mode constants for translating DPMS modes to Get/SetSync calls.	*/
	kDPMSSyncOn					= 0,
	kDPMSSyncStandby			= 1,
	kDPMSSyncSuspend			= 2,
	kDPMSSyncOff				= 7
};

enum {
	kConvolved					= 0,
	kLiveVideoPassThru			= 1,
	kConvolvedMask				= 0x01,
	kLiveVideoPassThruMask		= 0x02
};

struct VPBlock {
	long							vpBaseOffset;				/*Offset to page zero of video RAM (From minorBaseOS).*/
	short							vpRowBytes;					/*Width of each row of video memory.*/
	Rect							vpBounds;					/*BoundsRect for the video display (gives dimensions).*/
	short							vpVersion;					/*PixelMap version number.*/
	short							vpPackType;
	long							vpPackSize;
	long							vpHRes;						/*Horizontal resolution of the device (pixels per inch).*/
	long							vpVRes;						/*Vertical resolution of the device (pixels per inch).*/
	short							vpPixelType;				/*Defines the pixel type.*/
	short							vpPixelSize;				/*Number of bits in pixel.*/
	short							vpCmpCount;					/*Number of components in pixel.*/
	short							vpCmpSize;					/*Number of bits per component*/
	long							vpPlaneBytes;				/*Offset from one plane to the next.*/
};
typedef struct VPBlock VPBlock;

typedef VPBlock *VPBlockPtr;

struct VDEntryRecord {
	Ptr								csTable;					/*(long) pointer to color table entry=value, r,g,b:INTEGER*/
};
typedef struct VDEntryRecord VDEntryRecord;

typedef VDEntryRecord *VDEntRecPtr;

/* Parm block for SetGray control call */
struct VDGrayRecord {
	Boolean							csMode;						/*Same as GDDevType value (0=color, 1=mono)*/
	SInt8							filler;
};
typedef struct VDGrayRecord VDGrayRecord;

typedef VDGrayRecord *VDGrayPtr;

/* Parm block for SetInterrupt call */
struct VDFlagRecord {
	SInt8							csMode;
	SInt8							filler;
};
typedef struct VDFlagRecord VDFlagRecord;

typedef VDFlagRecord *VDFlagRecPtr;

/* Parm block for SetEntries control call */
struct VDSetEntryRecord {
	ColorSpec						*csTable;					/*Pointer to an array of color specs*/
	short							csStart;					/*Which spec in array to start with, or -1*/
	short							csCount;					/*Number of color spec entries to set*/
};
typedef struct VDSetEntryRecord VDSetEntryRecord;

typedef VDSetEntryRecord *VDSetEntryPtr;

/* Parm block for SetGamma control call */
struct VDGammaRecord {
	Ptr								csGTable;					/*pointer to gamma table*/
};
typedef struct VDGammaRecord VDGammaRecord;

typedef VDGammaRecord *VDGamRecPtr;

struct VDBaseAddressInfoRec {
	long							csDevData;					/* LONGINT - (long) timing mode */
	long							csDevBase;					/* LONGINT - (long) base address of the mode */
	short							csModeReserved;				/* INTEGER - (short) will some day be the depth */
	long							csModeBase;					/* LONGINT - (long) reserved */
};
typedef struct VDBaseAddressInfoRec VDBaseAddressInfoRec, *VDBaseAddressInfoPtr;

struct VDSwitchInfoRec {
	unsigned short					csMode;						/*(word) mode depth*/
	unsigned long					csData;						/*(long) functional sResource of mode*/
	unsigned short					csPage;						/*(word) page to switch in*/
	Ptr								csBaseAddr;					/*(long) base address of page (return value)*/
	unsigned long					csReserved;					/*(long) Reserved (set to 0) */
};
typedef struct VDSwitchInfoRec VDSwitchInfoRec;

typedef VDSwitchInfoRec *VDSwitchInfoPtr;

struct VDTimingInfoRec {
	unsigned long					csTimingMode;				/* LONGINT - (long) timing mode (a la InitGDevice) */
	unsigned long					csTimingReserved;			/* LONGINT - (long) reserved */
	unsigned long					csTimingFormat;				/* LONGINT - (long) what format is the timing info */
	unsigned long					csTimingData;				/* LONGINT - (long) data supplied by driver */
	unsigned long					csTimingFlags;				/* LONGINT - (long) mode within device */
};
typedef struct VDTimingInfoRec VDTimingInfoRec;

typedef VDTimingInfoRec *VDTimingInfoPtr;

struct VDDisplayConnectInfoRec {
	unsigned short					csDisplayType;				/* INTEGER - (word) Type of display connected */
	unsigned char					csConnectTaggedType;		/* BYTE - type of tagging */
	unsigned char					csConnectTaggedData;		/* BYTE - tagging data */
	unsigned long					csConnectFlags;				/* LONGINT - (long) tell us about the connection */
	unsigned long					csDisplayComponent;			/* LONGINT - (long) if the card has a direct connection to the display, it returns the display component here (FUTURE) */
	unsigned long					csConnectReserved;			/* LONGINT - (long) reserved */
};
typedef struct VDDisplayConnectInfoRec VDDisplayConnectInfoRec;

typedef VDDisplayConnectInfoRec *VDDisplayConnectInfoPtr;

/* RawSenseCode
	This abstract data type is not exactly abstract.  Rather, it is merely enumerated constants
	for the possible raw sense code values when 'standard' sense code hardware is implemented.

	For 'standard' sense code hardware, the raw sense is obtained as follows:
		• Instruct the frame buffer controller NOT to actively drive any of the monitor sense lines
		• Read the state of the monitor sense lines 2, 1, and 0.  (2 is the MSB, 0 the LSB)

	IMPORTANT Note: 
	When the 'kTaggingInfoNonStandard' bit of 'csConnectFlags' is FALSE, then these constants 
	are valid 'csConnectTaggedType' values in 'VDDisplayConnectInfo' 

*/
typedef unsigned char RawSenseCode;


enum {
	kRSCZero					= 0,
	kRSCOne						= 1,
	kRSCTwo						= 2,
	kRSCThree					= 3,
	kRSCFour					= 4,
	kRSCFive					= 5,
	kRSCSix						= 6,
	kRSCSeven					= 7
};

/* ExtendedSenseCode
	This abstract data type is not exactly abstract.  Rather, it is merely enumerated constants
	for the values which are possible when the extended sense algorithm is applied to hardware
	which implements 'standard' sense code hardware.

 	For 'standard' sense code hardware, the extended sense code algorithm is as follows:
	(Note:  as described here, sense line 'A' corresponds to '2', 'B' to '1', and 'C' to '0')
		• Drive sense line 'A' low and read the values of 'B' and 'C'.  
		• Drive sense line 'B' low and read the values of 'A' and 'C'.
		• Drive sense line 'C' low and read the values of 'A' and 'B'.

	In this way, a six-bit number of the form BC/AC/AB is generated. 

	IMPORTANT Note: 
	When the 'kTaggingInfoNonStandard' bit of 'csConnectFlags' is FALSE, then these constants 
	are valid 'csConnectTaggedData' values in 'VDDisplayConnectInfo' 

*/
typedef unsigned char ExtendedSenseCode;


enum {
	kESCZero21Inch				= 0x00,							/* 21" RGB 								*/
	kESCOnePortraitMono			= 0x14,							/* Portrait Monochrome 					*/
	kESCTwo12Inch				= 0x21,							/* 12" RGB								*/
	kESCThree21InchRadius		= 0x31,							/* 21" RGB (Radius)						*/
	kESCThree21InchMonoRadius	= 0x34,							/* 21" Monochrome (Radius) 				*/
	kESCThree21InchMono			= 0x35,							/* 21" Monochrome						*/
	kESCFourNTSC				= 0x0A,							/* NTSC 								*/
	kESCFivePortrait			= 0x1E,							/* Portrait RGB 						*/
	kESCSixMSB1					= 0x03,							/* MultiScan Band-1 (12" thru 1Six")	*/
	kESCSixMSB2					= 0x0B,							/* MultiScan Band-2 (13" thru 19")		*/
	kESCSixMSB3					= 0x23,							/* MultiScan Band-3 (13" thru 21")		*/
	kESCSixStandard				= 0x2B,							/* 13"/14" RGB or 12" Monochrome		*/
	kESCSevenPAL				= 0x00,							/* PAL									*/
	kESCSevenNTSC				= 0x14,							/* NTSC 								*/
	kESCSevenVGA				= 0x17,							/* VGA 									*/
	kESCSeven16Inch				= 0x2D,							/* 16" RGB (GoldFish) 				 	*/
	kESCSevenPALAlternate		= 0x30,							/* PAL (Alternate) 						*/
	kESCSeven19Inch				= 0x3A,							/* Third-Party 19”						*/
	kESCSevenNoDisplay			= 0x3F							/* No display connected 				*/
};

/* DepthMode
	This abstract data type is used to to reference RELATIVE pixel depths.
	Its definition is largely derived from its past usage, analogous to 'xxxVidMode'

	Bits per pixel DOES NOT directly map to 'DepthMode'  For example, on some
	graphics hardware, 'kDepthMode1' may represent 1 BPP, whereas on other
	hardware, 'kDepthMode1' may represent 8BPP.

	DepthMode IS considered to be ordinal, i.e., operations such as <, >, ==, etc.
	behave as expected.  The values of the constants which comprise the set are such
	that 'kDepthMode4 < kDepthMode6' behaves as expected.
*/
typedef unsigned short DepthMode;


enum {
	kDepthMode1					= 128,
	kDepthMode2					= 129,
	kDepthMode3					= 130,
	kDepthMode4					= 131,
	kDepthMode5					= 132,
	kDepthMode6					= 133
};

enum {
	kFirstDepthMode				= 128,							/* These constants are obsolete, and just included	*/
	kSecondDepthMode			= 129,							/* for clients that have converted to the above		*/
	kThirdDepthMode				= 130,							/* kDepthModeXXX constants.							*/
	kFourthDepthMode			= 131,
	kFifthDepthMode				= 132,
	kSixthDepthMode				= 133
};

struct VDPageInfo {
	short							csMode;						/*(word) mode within device*/
	long							csData;						/*(long) data supplied by driver*/
	short							csPage;						/*(word) page to switch in*/
	Ptr								csBaseAddr;					/*(long) base address of page*/
};
typedef struct VDPageInfo VDPageInfo;

typedef VDPageInfo *VDPgInfoPtr;

struct VDSizeInfo {
	short							csHSize;					/*(word) desired/returned h size*/
	short							csHPos;						/*(word) desired/returned h position*/
	short							csVSize;					/*(word) desired/returned v size*/
	short							csVPos;						/*(word) desired/returned v position*/
};
typedef struct VDSizeInfo VDSizeInfo;

typedef VDSizeInfo *VDSzInfoPtr;

struct VDSettings {
	short							csParamCnt;					/*(word) number of params*/
	short							csBrightMax;				/*(word) max brightness*/
	short							csBrightDef;				/*(word) default brightness*/
	short							csBrightVal;				/*(word) current brightness*/
	short							csCntrstMax;				/*(word) max contrast*/
	short							csCntrstDef;				/*(word) default contrast*/
	short							csCntrstVal;				/*(word) current contrast*/
	short							csTintMax;					/*(word) max tint*/
	short							csTintDef;					/*(word) default tint*/
	short							csTintVal;					/*(word) current tint*/
	short							csHueMax;					/*(word) max hue*/
	short							csHueDef;					/*(word) default hue*/
	short							csHueVal;					/*(word) current hue*/
	short							csHorizDef;					/*(word) default horizontal*/
	short							csHorizVal;					/*(word) current horizontal*/
	short							csHorizMax;					/*(word) max horizontal*/
	short							csVertDef;					/*(word) default vertical*/
	short							csVertVal;					/*(word) current vertical*/
	short							csVertMax;					/*(word) max vertical*/
};
typedef struct VDSettings VDSettings;

typedef VDSettings *VDSettingsPtr;

struct VDDefMode {
	UInt8							csID;
	SInt8							filler;
};
typedef struct VDDefMode VDDefMode;

typedef VDDefMode *VDDefModePtr;

struct VDSyncInfoRec {
	UInt8							csMode;
	UInt8							csFlags;
};
typedef struct VDSyncInfoRec VDSyncInfoRec;

typedef VDSyncInfoRec *VDSyncInfoPtr;

typedef unsigned long DisplayModeID;

typedef unsigned long VideoDeviceType;

typedef unsigned long GammaTableID;

/* Constants for the GetNextResolution call */

enum {
	kDisplayModeIDCurrent		= 0x0,							/* Reference the Current DisplayModeID */
	kDisplayModeIDInvalid		= 0xffffffff,					/* A bogus DisplayModeID in all cases */
	kDisplayModeIDFindFirstResolution = 0xfffffffe,				/* Used in cscGetNextResolution to reset iterator */
	kDisplayModeIDNoMoreResolutions = 0xfffffffd				/* Used in cscGetNextResolution to indicate End Of List */
};

/* Constants for the GetGammaInfoList call */
enum {
	kGammaTableIDFindFirst		= 0xfffffffe,					/* Get the first gamma table ID */
	kGammaTableIDNoMoreTables	= 0xfffffffd,					/* Used to indicate end of list */
	kGammaTableIDSpecific		= 0x0							/* Return the info for the given table id */
};

struct VDResolutionInfoRec {
	DisplayModeID					csPreviousDisplayModeID;	/* ID of the previous resolution in a chain */
	DisplayModeID					csDisplayModeID;			/* ID of the next resolution */
	unsigned long					csHorizontalPixels;			/* # of pixels in a horizontal line at the max depth */
	unsigned long					csVerticalLines;			/* # of lines in a screen at the max depth */
	Fixed							csRefreshRate;				/* Vertical Refresh Rate in Hz */
	DepthMode						csMaxDepthMode;				/* 0x80-based number representing max bit depth */
	unsigned long					csResolutionFlags;			/* Reserved - flag bits */
	unsigned long					csReserved;					/* Reserved */
};
typedef struct VDResolutionInfoRec VDResolutionInfoRec;

typedef VDResolutionInfoRec *VDResolutionInfoPtr;

struct VDVideoParametersInfoRec {
	DisplayModeID					csDisplayModeID;			/* the ID of the resolution we want info on */
	DepthMode						csDepthMode;				/* The bit depth we want the info on (0x80 based) */
	VPBlockPtr						csVPBlockPtr;				/* Pointer to a video parameter block */
	unsigned long					csPageCount;				/* Number of pages supported by the resolution */
	VideoDeviceType					csDeviceType;				/* Device Type:  Direct, Fixed or CLUT; */
	unsigned long					csReserved;					/* Reserved */
};
typedef struct VDVideoParametersInfoRec VDVideoParametersInfoRec;

typedef VDVideoParametersInfoRec *VDVideoParametersInfoPtr;

struct VDGammaInfoRec {
	GammaTableID					csLastGammaID;				/* the ID of the previous gamma table */
	GammaTableID					csNextGammaID;				/* the ID of the next gamma table */
	Ptr								csGammaPtr;					/* Ptr to a gamma table data */
	unsigned long					csReserved;					/* Reserved */
};
typedef struct VDGammaInfoRec VDGammaInfoRec;

typedef VDGammaInfoRec *VDGammaInfoPtr;

struct VDGetGammaListRec {
	GammaTableID					csPreviousGammaTableID;		/* ID of the previous gamma table */
	GammaTableID					csGammaTableID;				/* ID of the gamma table following csPreviousDisplayModeID */
	unsigned long					csGammaTableSize;			/* Size of the gamma table in bytes */
	char							*csGammaTableName;			/* Gamma table name (c-string) */
};
typedef struct VDGetGammaListRec VDGetGammaListRec;

typedef VDGetGammaListRec *VDGetGammaListPtr;

struct VDRetrieveGammaRec {
	GammaTableID					csGammaTableID;				/* ID of gamma table to retrieve */
	GammaTbl						*csGammaTablePtr;			/* Location to copy desired gamma to */
};
typedef struct VDRetrieveGammaRec VDRetrieveGammaRec;

typedef VDRetrieveGammaRec *VDRetrieveGammaPtr;

struct VDSetHardwareCursorRec {
	void							*csCursorRef;				/* reference to cursor data */
	UInt32							csReserved1;				/* reserved for future use */
	UInt32							csReserved2;				/* should be ignored */
};
typedef struct VDSetHardwareCursorRec VDSetHardwareCursorRec;

typedef VDSetHardwareCursorRec *VDSetHardwareCursorPtr;

struct VDDrawHardwareCursorRec {
	SInt32							csCursorX;					/* x coordinate */
	SInt32							csCursorY;					/* y coordinate */
	UInt32							csCursorVisible;			/* true if cursor is must be visible */
	UInt32							csReserved1;				/* reserved for future use */
	UInt32							csReserved2;				/* should be ignored */
};
typedef struct VDDrawHardwareCursorRec VDDrawHardwareCursorRec;

typedef VDDrawHardwareCursorRec *VDDrawHardwareCursorPtr;

struct VDSupportsHardwareCursorRec {
	UInt32							csSupportsHardwareCursor;
/* true if hardware cursor is supported */
	UInt32							csReserved1;				/* reserved for future use */
	UInt32							csReserved2;				/* must be zero */
};
typedef struct VDSupportsHardwareCursorRec VDSupportsHardwareCursorRec;

typedef VDSupportsHardwareCursorRec *VDSupportsHardwareCursorPtr;

struct VDHardwareCursorDrawStateRec {
	SInt32							csCursorX;					/* x coordinate */
	SInt32							csCursorY;					/* y coordinate */
	UInt32							csCursorVisible;			/* true if cursor is visible */
	UInt32							csCursorSet;				/* true if cursor successfully set by last set control call */
	UInt32							csReserved1;				/* reserved for future use */
	UInt32							csReserved2;				/* must be zero */
};
typedef struct VDHardwareCursorDrawStateRec VDHardwareCursorDrawStateRec;

typedef VDHardwareCursorDrawStateRec *VDHardwareCursorDrawStatePtr;

struct VDConvolutionInfoRec {
	DisplayModeID					csDisplayModeID;			/* the ID of the resolution we want info on */
	DepthMode						csDepthMode;				/* The bit depth we want the info on (0x80 based) */
	unsigned long					csPage;
	UInt32							csFlags;
	UInt32							csReserved;
};
typedef struct VDConvolutionInfoRec VDConvolutionInfoRec;

typedef VDConvolutionInfoRec *VDConvolutionInfoPtr;

struct VDPowerStateRec {
	unsigned long					powerState;
	unsigned long					powerFlags;
	unsigned long					powerReserved1;
	unsigned long					powerReserved2;
};
typedef struct VDPowerStateRec VDPowerStateRec;

typedef VDPowerStateRec *VDPowerStatePtr;


#if PRAGMA_IMPORT_SUPPORTED
#pragma import off
#endif

#if PRAGMA_ALIGN_SUPPORTED
#pragma options align=reset
#endif

#ifdef __cplusplus
}
#endif

#endif /* __VIDEO__ */
